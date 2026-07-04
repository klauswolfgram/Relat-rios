/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINRSRF.ch"
#INCLUDE "PROTHEUS.CH"

Static lSRFQRY   := ExistBlock("SRFQRY")
Static cFornLoja := ""
Static _oQry     := Nil
Static cTaxas    := StrTran(MVTXA, ",", "|") + "|" + StrTran(MVTAXA, ",", "|") + "|CID"

/*/{Protheus.doc}FINRSRF
Relatório de impressão do DARF gráfico a partir dos títulos de contas a pagar.

@author Eduardo Riera
@since  26/06/2003
/*/
User Function FINRSRF(cAlias, nReg, nOpc)

Local aParamBox  := {}
Local cTitulo    := STR0042
Local lCentered  := .T.
Local cLoad      := "FINRSRF_01"
Local lCanSave   := .T.
Local lUserSave  := .T.
Local dData      := dDataBase

Static aPergRet := {}
Default cAlias  := "FI9"
Default nReg	:= 0
Default nOpc	:= 2

If GetHlpLGPD({"A6_COD", "A6_AGENCIA", "A6_NUMCON"})
	Return .F.
Endif

aAdd(aParamBox, {1, STR0005, dData,  "",    "", "  ", "",  50, .T.})																	// 1  - Vencimento inicial ?
aAdd(aParamBox, {1, STR0006, dData,  "",    "", "  ", "",  50, .T.})																	// 2  - Vencimento final ?
aAdd(aParamBox, {1, STR0007, "    ", "",    "", "37", "",  20, .F.})																	// 3  - Codigo SRF inicial ?
aAdd(aParamBox, {1, STR0008, "ZZZZ", "",    "", "37", "",  20, .F.})																	// 4  - Codigo SRF final ?
aAdd(aParamBox, {2, STR0009, STR0018, {STR0018, STR0019},  75, "", .T.})																// 5  - Agrupa por ? (Fornec./Cod.SRF - Apenas Cod. SRF )
aAdd(aParamBox, {1, STR0010, dData,  "",    "", "  ", "",  50, .T.})																	// 6  - Período de apuração
aAdd(aParamBox, {1, STR0011, Space(15), "", "", "  ", "",  60, .F.})																	// 7  - Numero de referência
aAdd(aParamBox, {1, STR0012, Space(FWGETTAMFILIAL), "@!", "", "XM0", "", 50, .T.})														// 8  - Filial centralizadora
aAdd(aParamBox, {2, STR0013, STR0020, {STR0020, STR0021}, 60, "", .T.})																	// 9  - Modelo ? Comum/Simples
aAdd(aParamBox, {1, STR0014, 999.99, "@E 999,999,999.99",, "", "mv_par09 = '2'", 60, .F.})												// 10 - Receita bruta ?
aAdd(aParamBox, {1, STR0015, 10.00,  "@E 999.99",,         "", "mv_par09 = '2'", 20, .F.})												// 11 - Percentual ?
aAdd(aParamBox, {2, STR0016, STR0022, {STR0022, STR0023, STR0024, STR0025, STR0026, STR0027, STR0028, STR0029, STR0030}, 75, "", .T.})	// 12 - Periodicidade ?
aAdd(aParamBox, {1, STR0017, Space(14), "@!R NN.NNN.NNN/NNNN-99",, "", "", 60, .F.})														// 13 - CNPJ da incorporadora ?
aAdd(aParamBox, {2, STR0031, STR0033, {STR0032, STR0033}, 35, "", .T.})																	// 14 - Seleciona filiais ?

If ParamBox(aParamBox, cTitulo, aPergRet,,, lCentered,,, /*oMainDlg*/, cLoad, lCanSave, lUserSave)
	RptStatus({|lEnd| ImpDet(lEnd, cAlias, nReg, nOpc)}, STR0001) //"Processando - DARF"
EndIf

Return(.T.)


/*/{Protheus.doc}ImpDet
Controle de fluxo do relatório.

@author Eduardo Riera
@since  26/06/2003
/*/
Static Function ImpDet(lEnd, cAlias, nReg, nOpc)

Local aDarf      := {}
Local aInfo      := {}
Local cAliasSE2  := "SE2"
Local dDataIni   := aPergRet[1]
Local dDataFim   := aPergRet[2]
Local nValorImp  := 0
Local cAliasAux
Local cCodIni    := aPergRet[3]
Local cCodFim    := aPergRet[4]
Local lModComum  := aPergRet[9] = "1"
Local aAreaSm0   := SM0->(GetArea())
Local nRegSE2    := 0
Local aInfoAux   := {}
Local lGestao    := !Empty(FWGrpCompany()) .And. !Empty(FWUnitBusiness()) .And. FWGETTAMFILIAL > 2
Local cSelFil    := ""
Local nVlmin     := SuperGetMv("MV_VLRETIR", .T., 10)
Local lE2FilComp := FwModeAccess("SE2",3) == "C"
Local aStru      := {}
Local cQuery     := ""
Local aSelFil    := {}
Local cFilialAtu := cFilAnt
Local lSelFil    := Val(SubStr(aPergRet[14],1,1)) == 1 //seleciona filias = Sim
Local lPaisLoc   := cPaisLoc $ "ANG|ARG|AUS|BOL|BRA|CHI|COL|COS|DOM|EQU|EUA|HAI|MEX|PAD|PAN|PAR|PER|POR|PTG|SAL|TRI|URU|VEN"
Local nTpAgrup   := Val(SubStr(aPergRet[5],1,1))
Local cChaveOld  := ""
Local cChave     := ""
Local lOrigem    := .F.
Local lTaxa      := .F.
Local lIdDarf    := .F.
Local nLenSE2    := 0
Local cStart     := ALLTRIM(STR(TamSx3("E2_PREFIXO")[1] + TamSx3("E2_NUM")[1] + TamSx3("E2_PARCELA")[1] + TamSx3("E2_TIPO")[1] + 1))
Local cCount     := ALLTRIM(STR(TamSx3("E2_FORNECE")[1] + TamSx3("E2_LOJA")[1]))
Local nX         := 0
Local nC         := 0
Local nY         := 0
Local aCmpImp 	 := {}

If lSelFil
	If lGestao
		aSelFil := FwSelectGC(.F.)
	Else
		aSelFil := AdmGetFil(.F.,.T.,"SE2")
	Endif

	If Len(aSelFil) > 1
		aSort(aSelFil)
	EndIf
Else
	aSelFil := {cFilAnt}
Endif

RestArea(aAreaSM0)

aDarf     := {}
aInfo     := {}
nValorImp := 0
aInfoAux  := {}
SM0->(MsSeek(cEmpAnt+cFilAnt))

If lModComum  // Modelo? Comum/Simples
	//Abre o SE2 com outro alias para ser localizado o titulo principal do imposto
	If !( ChkFile("SE2",.F.,"NEWSE2") )
		Return(Nil)
	EndIf

	dbSelectArea("SE2")
	SetRegua(LastRec())
	dbSetOrder(3)

	cSelFil:= GetRngFil( aSelFil, "SE2", .F.)
	aStru  := SE2->(dbStruct())
	nLenSE2 := Len(aStru)
	cAliasSE2 := "IMPDET"

	cQuery := "SELECT "
	For nX := 1 To nLenSE2
		cQuery += aStru[nX][1] + ", "
		If nX == nLenSE2
			cQuery += " R_E_C_N_O_ "
		EndIf
	Next nX
	cQuery += "FROM "+RetSqlName("SE2")+" SE2 "
	cQuery += "WHERE "

	If !Empty(cSelFil)
		cQuery += "( "
		If lE2FilComp .Or. Len(aSelFil) == 0  
			cQuery += "SE2.E2_FILIAL " + cSelFil
		Else
			For nC := 1 To Len(aSelFil)
				If nC == Len(aSelFil)
					cQuery += "SE2.E2_FILIAL IN ('"+ xFilial("SE2",aSelFil[nC]) + "') "
				Else
					cQuery += "SE2.E2_FILIAL IN ('"+ xFilial("SE2",aSelFil[nC]) + "') OR "
				EndIf
			Next
		EndIf
		cQuery += ") AND "
	EndIf

	cQuery += "SE2.E2_VENCREA>='"+DTOS(dDataIni)+"' AND "
	cQuery += "SE2.E2_VENCREA<='"+DTOS(dDataFim)+"' AND "
	cQuery += "SE2.E2_CODRET<>'"+Space(Len(SE2->E2_CODRET))+"' AND "
	cQuery += "SE2.E2_CODRET>='"+cCodIni+"' AND "
	cQuery += "SE2.E2_CODRET<='"+cCodFim+"' AND "

	If cPaisLoc $ "ANG|ARG|AUS|BOL|BRA|CHI|COL|COS|DOM|EQU|EUA|HAI|MEX|PAD|PAN|PAR|PER|POR|PTG|SAL|TRI|URU|VEN"
		cQuery += "SE2.E2_IDDARF='' AND "
	EndIf

	cQuery += "SE2.E2_SALDO > 0 AND "
	cQuery += "(E2_TIPO IN " + FormatIn(cTaxas, "|")  + " OR SE2.E2_ORIGEM in ('MATA996', 'FISA001', 'MATA103')) AND "
	cQuery += "SE2.D_E_L_E_T_=' ' "

	If lSRFQRY
		cQuery := ExecBlock("SRFQRY",.F.,.F.,{cQuery})
	Endif

	cQuery += "ORDER BY " + If(nTpAgrup == 1, "E2_CODRET,E2_VENCREA,E2_FORNECE,E2_FILIAL,E2_LOJA,SUBSTRING(SE2.E2_TITPAI,"+cStart+","+cCount+")", "E2_CODRET,E2_VENCREA")
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSE2)

	For nX := 1 To nLenSE2
		If aStru[nX][2]<>"C"
			TcSetField(cAliasSE2,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
		EndIf
	Next nX

	aAdd(aCmpImp,{"E2_ISS","N",tamSx3("E2_ISS")[1],tamSx3("E2_ISS")[2]})
	aAdd(aCmpImp,{"E2_PIS","N",tamSx3("E2_PIS")[1],tamSx3("E2_PIS")[2]})
	aAdd(aCmpImp,{"E2_COFINS","N",tamSx3("E2_COFINS")[1],tamSx3("E2_COFINS")[2]})
	aAdd(aCmpImp,{"E2_CSLL","N",tamSx3("E2_CSLL")[1],tamSx3("E2_CSLL")[2]})
	aAdd(aCmpImp,{"E2_IRRF","N",tamSx3("E2_IRRF")[1],tamSx3("E2_IRRF")[2]})

	While (cAliasSE2)->(!Eof()) .And. Iif(lSelFil, .T., xFilial("SE2")==(cAliasSE2)->E2_FILIAL) .And. (cAliasSE2)->E2_VENCREA <= dDataFim
		lOrigem := Alltrim((cAliasSE2)->E2_ORIGEM) $ "MATA996|FISA001|MATA103"
		lTaxa := (cAliasSE2)->E2_TIPO $ cTaxas
		lIdDarf := If(lPaisLoc, (AllTrim((cAliasSE2)->E2_IDDARF) == '' .OR. lSRFQRY), .T.)

		If !Empty((cAliasSE2)->E2_CODRET) .And. (cAliasSE2)->E2_CODRET >= cCodIni .And. 	(cAliasSE2)->E2_CODRET <= cCodFim .And. (lTaxa .Or. lOrigem) .And. lIdDarf
			//Posiciona no titulo pai para obter o valor total do titulo
			lAchouPai := FrSrfPai(cAliasSe2,aCmpImp)
			cAliasAux := If(lAchouPai, "NEWSE2", cAliasSE2)
			dbSelectArea("SA2")
			SA2->(MsSeek(xFilial("SA2", (cAliasSE2)->E2_FILORIG) + If(lAchouPai, cFornLoja, (cAliasAux)->(E2_FORNECE+E2_LOJA))))
			dbSelectArea(cAliasSE2)

			If nTpAgrup == 1 //Agrupa por fornecedor
				cChave := (cAliasSE2)->E2_CODRET + DTOS((cAliasSE2)->E2_VENCREA) + SA2->A2_COD + SA2->A2_FILIAL + SA2->A2_LOJA
			Else
				cChave := (cAliasSE2)->(E2_CODRET + DTOS(E2_VENCREA))
			Endif

			//Obtem o valor do imposto se nao achou o titulo pai, esta no proprio titulo pai e entao
			//o valor do imposto sera o valor do campo de imposto, senao sera o valor do titulo de imposto (SE2->E2_VALOR)
			If !lAchouPai .And. !lTaxa .And. !lOrigem .And. !lSRFQRY
				If Alltrim((cAliasSE2)->E2_NATUREZ) $ AllTrim(GetMv("MV_PISNAT"))
					nValorImp := NEWSE2->E2_PIS
				ElseIf Alltrim((cAliasSE2)->E2_NATUREZ) $ AllTrim(GetMv("MV_COFINS"))
					nValorImp := NEWSE2->E2_COFINS
				ElseIf Alltrim((cAliasSE2)->E2_NATUREZ) $ AllTrim(GetMv("MV_CSLL"))
					nValorImp := NEWSE2->E2_CSLL
				Else
					nValorImp := NEWSE2->E2_IRRF
				Endif
			Else
				nValorImp := (cAliasSE2)->E2_SALDO
			Endif

			nRegSE2 := (cAliasSE2)->(R_E_C_N_O_)

			If nY > 0 .And. cChaveOld == cChave .And. !Empty(cChaveOld)
				aDarf[nY][3] += xMoeda(nValorImp, (cAliasSE2)->E2_MOEDA, 1)
				aAdd(aDarf[nY][9],nRegSE2)
				aAdd(aDarf[nY][10],nValorImp)
			Else
				nY += 1
				aadd(aDarf,{;
					(cAliasSE2)->E2_CODRET, (cAliasSE2)->E2_VENCREA, xMoeda(nValorImp, (cAliasSE2)->E2_MOEDA, 1), SA2->A2_COD,;
					SA2->A2_NOME, lAchouPai, (cAliasSE2)->(E2_PREFIXO + E2_NUM + E2_PARCELA + E2_TIPO + E2_FORNECE + E2_LOJA),;
					xFilial("SA2",(cAliasSE2)->E2_FILORIG), {nRegSE2}, {nValorImp}, SA2->A2_LOJA})
			EndIf
		EndIf

		cChaveOld := cChave
		dbSelectArea(cAliasSE2)
		dbSkip()
		IncRegua()

		If lEnd
			Exit
		EndIf
	EndDo

	NEWSE2->(dbCloseArea())
	(cAliasSE2)->(dbCloseArea())
	dbSelectArea("SE2")

	// Se for informada a filial centralizadora, posiciona nela para impressao dos dados como CGC, Nome, Etc.
	If !Empty(aPergRet[8])
		SM0->(MsSeek(cEmpAnt+aPergRet[8]))
	Endif

	For nX := 1 To Len(aDarf)
		If (aDarf[nX][3]) > nVlmin
			aadd(aInfo, {{SM0->M0_NOMECOM,SM0->M0_TEL},;
				aPergRet[6],;
				TransForm(SM0->M0_CGC, "@!R NN.NNN.NNN/NNNN-99"),;
				aDarf[nX][1],;
				aPergRet[7],;
				aDarf[nX][2],;
				aDarf[nX][3],;
				0,;
				0,;
				aDarf[nX][3],;
				aDarf[nX][5],;
				aDarf[nX][6],;
				aDarf[nX][7]})
			U_GInfDARF(aDarf[nX][9], aDarf[nX][3], aDarf[nX][1], nOpc, aDarf[nX][10], SM0->M0_CGC, aDarf[nX][2])
		Endif
	Next nX

	SM0->(MsSeek(cEmpAnt+cFilAnt))
Else
	aadd(aInfo, {{SM0->M0_NOMECOM,SM0->M0_TEL},;
			aPergRet[6],;
			TransForm(SM0->M0_CGC, "@!R NN.NNN.NNN/NNNN-99"),;
			"6106",;                                 // Codigo da Receita
			aPergRet[10],;                           // Valor da Receita Bruta Acumulada
			aPergRet[11],;                           // Percentual
			( ( aPergRet[10] / 100 ) * aPergRet[11] ),; // Valor do Principal
			0,;                                  // Valor da multa
			0,;                                  // Valor dos juros
			"",;                                 // nao eh utilizado
			"",;                                 // nao eh utilizado
			""})                                 // nao eh utilizado
EndIf

aInfoAux := AClone(aInfo)
If ExistBlock("FA373SCL")
	aInfo := ExecBlock("FA373SCL", .F., .F.,{aInfo})
	If ValType(aInfo) <> "A"
		aInfo := AClone(aInfoAux)
	Endif
Endif

If !lModComum .or. Len(aDarf) > 0  // Se tem DARF a imprimir.
	IF len(aInfo) > 0 .and. aInfo[1, 7] > nVlmin  // E pelo menos um atingiu o valor mínimo para ser impresso.
		U_PrtDarf(aInfo, aPergRet)
	Else
		Aviso(STR0034 + cFilAnt + " " + STR0002, STR0035, {STR0004}) //"Filial : "###"Mensagem"###"DARF não pode ser gerada com valor igual ou inferior ao minimo definido no parâmetro MV_VLRETIR "###"Ok"
	Endif
Else
	Aviso(STR0034 + cFilAnt + " " + STR0002, STR0003, {STR0004}) //"Filial : "###"Mensagem"###"Nao há dados no periodo informado"###"Ok"
EndIf
SM0->(RestArea(aAreaSm0))

cFilAnt := cFilialAtu
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrtDarf   ³ Autor ³Eduardo Riera          ³ Data ³26/06/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do formulario DARF grafico conforme layout da SRF³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PrtDarf(aInfo)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1: [1][1] Nome                                         ³±±
±±³          ³        [1][2] Telefone                                     ³±±
±±³          ³        [2] Periodo de Apuracao ( DATA )                    ³±±
±±³          ³        [3] CNPJ                                            ³±±
±±³          ³        [4] Codigo da Receita                               ³±±
±±³          ³        [5] Numero de Referencia                            ³±±
±±³          ³        [6] Data de Vencimento (Data)                       ³±±
±±³          ³        [7] Valor do Principal                              ³±±
±±³          ³        [8] Valor da Multa                                  ³±±
±±³          ³        [9] Valor dos Juros e/ou Encargos DL - 1.025/69     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function  PrtDarf(aInfo,aPergRet)

Local cBmp 		 := ""
Local cStartPath := GetSrvProfString("StartPath","")
Local nX         := 030
Local nY         := 0
Local nW         := 0
Local oFont07    := TFont():New("Arial",07,10,,.F.,,,,.T.,.F.)
Local oFont09    := TFont():New("Arial",09,09,,.F.,,,,.T.,.F.)
Local oFont09n   := TFont():New("Arial",09,09,,.T.,,,,.T.,.F.)
Local oFont10    := TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
Local oFont10n   := TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)
Local oFont11    := TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
Local oFont15    := TFont():New("Arial",15,15,,.F.,,,,.T.,.F.)
Local oFont21n   := TFont():New("Arial",21,21,,.T.,,,,.T.,.F.)
Local oFont07n   := TFont():New("Arial",07,10,,.T.,,,,.T.,.F.)
Local oFont18n   := TFont():New("Arial",18,18,,.T.,,,,.T.,.F.)

Local oPrint
Local cSet

Local cObs       := ""
Local lDarfAdObs := ExistBlock("DarfAdObs")

cSet := Set(_SET_DATEFORMAT)
Set(_SET_DATEFORMAT,"dd/mm/yyyy")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ponto de Entrada: Recebe Informações DARF mais valores de Juros e Multa ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("DARFVAL")
   aInfo := ExecBlock("DARFVAL",.F.,.F.,{aInfo})
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializacao do objeto grafico                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPrint 	:= TMSPrinter():New("DARF - Guia de Recolhimento DARF")
If oPrint:Setup()
	oPrint:SetPortrait()
	cBmp := cStartPath + "Receita.BMP" //Logo da Receita Federal
	For nW := 1 To Len(aInfo)
		oPrint:StartPage()
		nX := 030
		For nY := 1 To 2
			If Val(SubStr(aPergRet[9],1,1)) == 1 // Modelo? Comum/Simples
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Box grafico                                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Box(nX,0030,nX+1100,2350)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Inclusao do logotipo do Ministerio da Fazenda                           ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If File(cBmp)
					oPrint:SayBitmap(nX+10,040,cBmp,200,180)
				EndIf
				oPrint:Say(nX+020,250,"MINISTÉRIO DA FAZENDA",oFont15)
				oPrint:Say(nX+070,250,"Secretaria da Receita Federal do Brasil")
				oPrint:Say(nX+120,250,"Documento de Arrecadação de Receitas Federais",oFont10)
				oPrint:Say(nX+170,250,"DARF",oFont21n)
				oPrint:Line(nX,1300,nX+1100,1300)
				oPrint:Line(nX,1800,nX+810,1800)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 01                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+270,030,nX+270,1300)
				oPrint:Say(nX+280,040,"01",oFont10)
				oPrint:Say(nX+290,110,"NOME / TELEFONE",oFont10)
				oPrint:Say(nX+350,110,Left(aInfo[nW][1][1],40),oFont10)
				oPrint:Say(nX+380,110,aInfo[nW][1][2],oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 02                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+490,030,nX+490,1300)
				oPrint:Line(nX+650,030,nX+650,1300)
				oPrint:Say(nX+020,1305,"02",oFont10)
				oPrint:Say(nX+030,1360,"PERíODO DE APURACAO",oFont09)
				If Len(Dtoc(aInfo[nW][2])) > 8
					oPrint:Say(nX+030,2150,Dtoc(aInfo[nW][2]),oFont10)
				Else
					oPrint:Say(nX+030,2190,Dtoc(aInfo[nW][2]),oFont10)
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 03                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+090,1300,nX+90,2350)
				oPrint:Say(nX+120,1305,"03",oFont10)
				oPrint:Say(nX+130,1360,"NÚMERO DO CPF OU CNPJ",oFont09)
				oPrint:Say(nX+130,2010,aInfo[nW][3],oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 04                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+180,1300,nX+180,2350)
				oPrint:Say(nX+200,1305,"04",oFont10)
				oPrint:Say(nX+210,1360,"CODIGO DA RECEITA",oFont09)
				oPrint:Say(nX+210,2245,aInfo[nW][4],oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 05                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+270,1300,nX+270,2350)
				oPrint:Say(nX+290,1305,"05",oFont10)
				oPrint:Say(nX+300,1360,"NÚMERO DE REFERÊNCIA",oFont09)
				oPrint:Say(nX+300,2035,aInfo[nW][5],oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 06                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+360,1300,nX+360,2350)
				oPrint:Say(nX+380,1305,"06",oFont10)
				oPrint:Say(nX+390,1360,"DATA DE VENCIMENTO",oFont09)
				If Len(Dtoc(aInfo[nW][6])) > 8
					oPrint:Say(nX+390,2150,Dtoc(aInfo[nW][6]),oFont10)
				Else
					oPrint:Say(nX+390,2190,Dtoc(aInfo[nW][6]),oFont10)
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 07                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+450,1300,nX+450,2350)
				oPrint:Say(nX+470,1305,"07",oFont10)
				oPrint:Say(nX+480,1360,"VALOR DO PRINCIPAL",oFont09)
				oPrint:Say(nX+480,2100,Transform(aInfo[nW][7],"@E 9,999,999,999.99"),oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 08                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+ 540,1300,nX+540,2350)
				oPrint:Say(nX+560,1305,"08",oFont10)
				oPrint:Say(nX+570,1360,"VALOR DA MULTA",oFont09)
				oPrint:Say(nX+570,2100,Transform(aInfo[nW][8],"@E 9,999,999,999.99"),oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 09                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+630,1300,nX+630,2350)
				oPrint:Say(nX+650,1305,"09",oFont10)
				oPrint:Say(nX+640,1360,"VALOR DOS JUROS E / OU",oFont09)
				oPrint:Say(nX+670,1370,"ENCARGOS DL 1025/69",oFont09)
				oPrint:Say(nX+670,2100,Transform(aInfo[nW][9],"@E 9,999,999,999.99"),oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 10                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+720,1300,nX+720,2350)
				oPrint:Say(nX+740,1305,"10",oFont10)
				oPrint:Say(nX+750,1360,"VALOR TOTAL",oFont09)
				oPrint:Say(nX+750,2100,Transform(aInfo[nW][7]+aInfo[nW][8]+aInfo[nW][9],"@E 9,999,999,999.99"),oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 11                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+810,1300,nX+810,2350)
				oPrint:Say(nX+830,1305,"11",oFont10)
				oPrint:Say(nX+830,1370,"AUTENTICAÇÃO BANCÁRIA (SOMENTE NAS 1 E 2 VIAS)",oFont09n)

				If lDarfAdObs
					cObs := ExecBlock("DarfAdObs", .F. , .F.,{aInfo,nW,nY})
					If ValType(cObs) == 'C' .And. !Empty(cObs)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Definicao de Observação                                                 ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						oPrint:Say(nX+490,60,"Observação",oFont10)
						oPrint:Say(nX+520,70,Alltrim(cObs),oFont07)
					Endif
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro de aviso                                            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Say(nX+0680,600,"ATENÇÃO",oFont10n)
				oPrint:Say(nX+0740,040,"É vedado o recolhimento de tributos e contribuições administrados pela",oFont07)
				oPrint:Say(nX+0780,040,"Secretaria da Receita Federal cujo valor seja inferior a R$ 10,00. ",oFont07)
				oPrint:Say(nX+0820,040,"Ocorrendo tal situação, adicione esse valor ao tributo/contribuição de",oFont07)
				oPrint:Say(nX+0860,040,"mesmo código de períodos subsequentes, até que o total seja igual ou",oFont07)
				oPrint:Say(nX+0900,040,"superior a R$10,00.",oFont07)
				oPrint:Say(nX+0940,040,"Valores expressos em reais",oFont07)

				If Val(SubStr(aPergRet[5],1,1)) == 1 .And. aInfo[nW][12] // Se encontrou o titulo pai, imprime o nome do fornecedor do titulo pai
					oPrint:Say(nX+1030,040,"Recolhido em nome de " + aInfo[nW][11],oFont07)
				Else
					oPrint:Say(nX+1030,040,"DARF Manual",oFont07)
				Endif

				If nY == 1
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Definicao do picote                                                     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oPrint:Say(nX+1250,000,Replicate("-",132),oFont11)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Segunda via do Darf                                                     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nX := 1480
				EndIf
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Box grafico                                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Box(nX,0030,nX+1100,2350)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Inclusao do logotipo do Ministerio da Fazenda                           ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If File(cBmp)
					oPrint:SayBitmap(nX+10,040,cBmp,200,180)
				EndIf
				oPrint:Say(nX+020,250,"MINISTÉRIO DA FAZENDA",oFont15)
				oPrint:Say(nX+080,250,"Secretaria da Receita Federal do Brasil",oFont15)
				oPrint:Say(nX+160,250,"Documento de Arrecadação",oFont07)
				oPrint:Say(nX+200,040,"do Sistema Integrado de Pagamento de Impostos e Contribuições",oFont07)
				oPrint:Say(nX+240,150,"das Microempresas e Empresas de Pequeno Porte",oFont07)
				oPrint:Say(nX+290,250,"DARF - SIMPLES",oFont18n)

				oPrint:Line(nX,1300,nX+1100,1300)
				oPrint:Line(nX,1800,nX+810,1800)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 01                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+360,030,nX+360,1300)
				oPrint:Say(nX+370,040,"01",oFont10)
				oPrint:Say(nX+380,110,"NOME DA EMPRESA / TELEFONE",oFont10)
				oPrint:Say(nX+440,110,Left(aInfo[nW][1][1],40),oFont10)
				oPrint:Say(nX+470,110,aInfo[nW][1][2],oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 02                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+560,030,nX+560,1300) //d
				oPrint:Say(nX+020,1305,"02",oFont10)
				oPrint:Say(nX+030,1360,"PERíODO DE APURACAO",oFont09)

				If Len(Dtoc(aInfo[nW][2])) > 8
					oPrint:Say(nX+030,2150,Dtoc(aInfo[nW][2]),oFont10)
				Else
					oPrint:Say(nX+030,2190,Dtoc(aInfo[nW][2]),oFont10)
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 03                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+090,1300,nX+90,2350)
				oPrint:Say(nX+120,1305,"03",oFont10)
				oPrint:Say(nX+130,1360,"NÚMERO DO CGC",oFont09)
				oPrint:Say(nX+130,2010,aInfo[nW][3],oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 04                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+180,1300,nX+180,2350)
				oPrint:Say(nX+200,1305,"04",oFont10)
				oPrint:Say(nX+210,1360,"CÓDIGO DA RECEITA",oFont09)
				oPrint:Say(nX+210,2245,aInfo[nW][4],oFont10)

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 05                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+270,1300,nX+270,2350)
				oPrint:Say(nX+290,1305,"05",oFont10)
				oPrint:Say(nX+280,1360,"VALOR DA RECEITA",oFont09)
				oPrint:Say(nX+310,1360,"BRUTA ACUMULADA",oFont09)
				oPrint:Say(nX+300,2100,Transform(aInfo[nW][5],"@E 9,999,999,999.99"),oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 06                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+360,1300,nX+360,2350)
				oPrint:Say(nX+380,1305,"06",oFont10)
				oPrint:Say(nX+390,1360,"PERCENTUAL",oFont09)
				oPrint:Say(nX+390,2100,Transform(aInfo[nW][6],"@E 9,999,999,999.99"),oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 07                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+450,1300,nX+450,2350)
				oPrint:Say(nX+470,1305,"07",oFont10)
				oPrint:Say(nX+480,1360,"VALOR DO PRINCIPAL",oFont09)
				oPrint:Say(nX+480,2100,Transform(aInfo[nW][7],"@E 9,999,999,999.99"),oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 08                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+ 540,1300,nX+540,2350)
				oPrint:Say(nX+560,1305,"08",oFont10)
				oPrint:Say(nX+570,1360,"VALOR DA MULTA",oFont09)
				oPrint:Say(nX+570,2100,Transform(aInfo[nW][8],"@E 9,999,999,999.99"),oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 09                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+630,1300,nX+630,2350)
				oPrint:Say(nX+650,1305,"09",oFont10)
				oPrint:Say(nX+660,1360,"VALOR DOS JUROS",oFont09)
				oPrint:Say(nX+660,2100,Transform(aInfo[nW][9],"@E 9,999,999,999.99"),oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 10                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+720,1300,nX+720,2350)
				oPrint:Say(nX+740,1305,"10",oFont10)
				oPrint:Say(nX+750,1360,"VALOR TOTAL",oFont09)
				oPrint:Say(nX+750,2100,Transform(aInfo[nW][7]+aInfo[nW][8]+aInfo[nW][9],"@E 9,999,999,999.99"),oFont10)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro 11                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Line(nX+810,1300,nX+810,2350)
				oPrint:Say(nX+830,1305,"11",oFont10)
				oPrint:Say(nX+830,1370,"AUTENTICAÇÃO BANCÁRIA (SOMENTE NAS 1 E 2 VIAS)",oFont09n)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Definicao do Quadro de aviso                                            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Say(nX+0600,040,"ATENÇÃO para o preenchimento dos seguintes campos",oFont07n)
				oPrint:Say(nX+0660,040,"02 -",oFont07)
				oPrint:Say(nX+0660,110,"Informe a data de encerramento do período de apuração no formato",oFont07)
				oPrint:Say(nX+0700,110,"DD/MM/AA.",oFont07)
				oPrint:Say(nX+0740,110,"Ex.: periodo de apuração de janeiro de 1997 -> 31/01/97",oFont07)
				oPrint:Say(nX+0800,040,"05 -",oFont07)
				oPrint:Say(nX+0800,110,"Informe a soma das receitas brutas mensais de janeiro até o mes",oFont07)
				oPrint:Say(nX+0840,110,"de apuração.",oFont07)
				oPrint:Say(nX+0900,040,"06 -",oFont07)
				oPrint:Say(nX+0900,110,"Informe o percentual decorrente da receita bruta acumulada a ser ",oFont07)
				oPrint:Say(nX+0940,110,"aplicado sobre a receita mensal, com duas casas decimais.",oFont07)
				oPrint:Say(nX+1000,040,"07 -",oFont07)
				oPrint:Say(nX+1000,110,"Informe o resultado da aplicação do percentual do campo 06",oFont07)
				oPrint:Say(nX+1040,110,"sobre a receita bruta mensal.",oFont07)

				If nY == 1
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Definicao do picote                                                     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oPrint:Say(nX+1250,000,Replicate("-",132),oFont11)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Segunda via do Darf                                                     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nX := 1480
				EndIf
			EndIf
		Next nY
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Finaliza a pagina                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:EndPage()
	Next nW
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Finaliza a Impressão                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Preview()
Endif

Return(.T.)


Static Function FrSrfPai(cAliasSe2,aCmpImp)
LOCAL nRegSE2		:= NEWSE2->(Recno())
LOCAL lAchou		:= .F.
LOCAL cPrefixo		:= (cAliasSe2)->E2_PREFIXO
LOCAL cNum			:= (cAliasSe2)->E2_NUM
LOCAL cParcela		:= (cAliasSe2)->E2_PARCELA
LOCAL cTipoPai		:= (cAliasSe2)->E2_TIPO
LOCAL cParcPai
Local lPai			:= .F.
Local cQry			:= ""
Local lPostgres := (UPPER(Alltrim(TCGetDb())) = "POSTGRES")
Local cTitPai := ""
Local cQryPai := ""
Local oQryPai := Nil
Local cAlsAux := GetNextAlias()

Default aCmpImp := {}

If (cAliasSe2)->E2_TIPO $ cTaxas
	If (cAliasSe2)->E2_FORNECE == GetMv("MV_MUNIC")
		cValorPai := "E2_ISS"
		cParcPai  := "E2_PARCISS"
	Else
		Do Case
		Case Alltrim((cAliasSe2)->E2_NATUREZ) $ AllTrim(GetMv("MV_PISNAT"))
			cValorPai := "E2_PIS"
			cParcPai  := "E2_PARCPIS"
		Case Alltrim((cAliasSe2)->E2_NATUREZ) $ AllTrim(GetMv("MV_COFINS"))
			cValorPai := "E2_COFINS"
			cParcPai  := "E2_PARCCOF"
		Case Alltrim((cAliasSe2)->E2_NATUREZ) $ AllTrim(GetMv("MV_CSLL"))
			cValorPai := "E2_CSLL"
			cParcPai  := "E2_PARCSLL"
		OtherWise
			cValorPai := "E2_IRRF"
			cParcPai  := "E2_PARCIR"
		EndCase
	Endif
Else
	lPai := .T.
Endif

//Se nao estiver no titulo pai, procura o titulo Pai.
If !lPai
	dbSelectArea("NEWSE2")
	dbSetOrder(1)
	If dbSeek((cAliasSe2)->E2_FILIAL+cPrefixo+cNum)
		nRegSE2:= Recno()

		If (cAliasSE2)->(!Empty(E2_TITPAI))
			If _oQry == Nil
				cQry := "SELECT SE2.R_E_C_N_O_, E2_FORNECE, E2_LOJA "
				cQry += " FROM ? SE2 "
				cQry += " WHERE SE2.E2_FILIAL = ? AND "

				If lPostgres
					cQry += " CONCAT(E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_FORNECE,E2_LOJA) = ?  "
				Else
					cQry += " E2_PREFIXO || E2_NUM || E2_PARCELA || E2_TIPO || E2_FORNECE || E2_LOJA = ?  "
				EndIf

				cQry += " AND D_E_L_E_T_ = ' ' "
				cQry := ChangeQuery(cQry)
				_oQry := FWPreparedStatement():New(cQry)
			EndIf

			If lPostgres
				cTitPai := RTRIM((cAliasSE2)->E2_TITPAI)
			Else
				cTitPai := (cAliasSE2)->E2_TITPAI
			EndIf

			_oQry:SetNumeric(1, RetSqlName("SE2"))
			_oQry:SetString(2, xFilial("SE2",(cAliasSe2)->E2_FILORIG))
			_oQry:SetString(3, cTitPai)
			cQry := _oQry:GetFixQuery()
			cAlsAux := MpSysOpenQuery(cQry)

			If !Empty((cAlsAux)->(E2_FORNECE+E2_LOJA))
				lAchou := .T.
				cFornLoja  := (cAlsAux)->(E2_FORNECE+E2_LOJA)
			EndIf
			(cAlsAux)->(dbCloseArea())
		Else
			cQryPai := "SELECT E2_FILIAL, E2_PREFIXO, E2_NUM, E2_TIPO,E2_FORNECE, E2_LOJA, E2_PARCISS, E2_PARCPIS, E2_PARCCOF, E2_PARCSLL, E2_PARCIR "
			cQryPai += "E2_ISS, E2_PIS, E2_COFINS, E2_CSLL, E2_IRRF FROM " + RetSqlName("SE2") + " "
			cQryPai += "WHERE E2_FILIAL = ? AND E2_PREFIXO = ? AND E2_NUM = ? AND " + cParcPai + " = ?  AND D_E_L_E_T_ = ' ' "
			cQryPai := ChangeQuery(cQryPai)
			oQryPai := FWPreparedStatement():New(cQryPai)
			oQryPai:SetString(1, xFilial("SE2"))
			oQryPai:SetString(2, cPrefixo)
			oQryPai:SetString(3, cNum)
			oQryPai:SetString(4, cParcela)
			cQryPai := oQryPai:GetFixQuery()			

			cAlsAux := MpSysOpenQuery(cQryPai,cAlsAux,aCmpImp)

			If (cTipoPai $ cTaxas .And. (cAlsAux)->E2_TIPO $ MVPAGANT + "/" + MV_CPNEG) .Or. (!Empty((cAlsAux)->(E2_FORNECE + E2_LOJA)))
				If (cAlsAux)->&cValorPai != 0
					lAchou := .T.
					cFornLoja  := (cAlsAux)->(E2_FORNECE + E2_LOJA)
				EndIf
			EndIf
			(cAlsAux)->(dbCloseArea())
		EndIf
	EndIf
Endif

// Se nao encontrou o registro pai, restaura o ponteiro do alias alternativo
// Pois o registro pode ja estar posicionado no titulo principal.
dbSelectArea("NEWSE2")
If !lAchou .And. !lPai
	dbGoto(nRegSE2)
Elseif !lAchou
	NEWSE2->(MsSeek(xFilial("SE2")+(cAliasSe2)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)))
Endif

Return lAchou

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GInfDARF ³ Autor ³Adrianne Furtado       ³ Data ³01/07/2009³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gravacao as informações de controle da DARF - Tabela FI9   ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GInfDARF()		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GInfDARF(aRecno, nValorImp, cCodRet, nOpc, aVlr, cCNPJEst, dVenc)

Local aFornec :=  {}
Local cIdDarf := ""
Local nX

If cPaisLoc $ "ANG|ARG|AUS|BOL|BRA|CHI|COL|COS|DOM|EQU|EUA|HAI|MEX|PAD|PAN|PAR|PER|POR|PTG|SAL|TRI|URU|VEN"  //Select("FI9")>0
    FI9->(DBCloseArea())
	cIdDarf := GetSXENum("FI9", "FI9_IDDARF")
	ConfirmSX8()

	If nOpc == 2
		DbSelectArea("FI9")
		For nX = 1 to Len(aRecno)

			SE2->(DBGoto(aRecno[nX]))
	   		If !Empty(SE2->E2_TITPAI)
				//No caso do titulo gerado ser um aglutinado, nao teremos um titulo pai cadastrado, pois podemos aglutinar titulos de N fornecedores
				aAdd(aFornec,{ TamSx3("E2_PREFIXO")[1] + TamSx3("E2_NUM")[1] + ;
							   TamSx3("E2_PARCELA")[1] + TamSx3("E2_TIPO")[1] + 1, TamSx3("E2_FORNECE")[1]})
				aAdd(aFornec,{ aFornec[1,1] + TamSx3("E2_FORNECE")[1], TamSx3("E2_LOJA")[1]})

				cFornec := SubStr(SE2->E2_TITPAI,aFornec[1,1],aFornec[1,2])
				cLoja   := SubStr(SE2->E2_TITPAI,aFornec[2,1],aFornec[2,2])
			Else
				cFornec := SE2->E2_FORNECE
				cLoja   := SE2->E2_LOJA
			Endif

			RecLock( "FI9", .T. )
			FI9->FI9_FILIAL	:= xFilial("FI9")
			FI9->FI9_IDDARF	:= cIdDarf
			FI9->FI9_EMISS	:= dDataBase
			FI9->FI9_PREFIX := SE2->E2_PREFIXO
			FI9->FI9_NUM	:= SE2->E2_NUM
			FI9->FI9_PARCEL := SE2->E2_PARCELA
			FI9->FI9_TIPO   := SE2->E2_TIPO
			FI9->FI9_FORNEC := cFornec
			FI9->FI9_LOJA  	:= cLoja
			FI9->FI9_VALOR  := aVlr[nX]
			FI9->FI9_STATUS	:= "A"
			FI9->FI9_CODRET	:= cCodRet
			FI9->FI9_FILCTR	:= aPergRet[8]
			FI9->FI9_REFER	:= aPergRet[7]
			FI9->FI9_APURA  := aPergRet[6]
			FI9->FI9_PERIOD := SubStr(aPergRet[12],1,1)
			FI9->FI9_VENCIM := dVenc
			FI9->FI9_INCORP := aPergRet[13]
			FI9->FI9_ESTABE := cCNPJEst
			
			If FI9->(FieldPos("FI9_FILORI")) > 0
				FI9->FI9_FILORI	:= SE2->E2_FILORIG
			EndIf
			
			MsUnlock()

			RecLock( "SE2", .F. )
			SE2->E2_IDDARF	:= cIdDarf
			MsUnlock()
		Next nX
	EndIf

	FI9->(DbCloseArea())
EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ExstDarfPg ³ Autor ³Daniel Mendes        ³ Data ³05/10/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se existe DARF gerada para o título e filial envi-³±±
±±³          ³ ado por parâmetro, caso contrário pelo título posicionado  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_ExstDarfPg()		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Lógico, se existe DARF ou não                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ExstDarfPg(cFilialSE2 As Character, cTitPaiSE2 As Character, lHelp As Logical) As Logical
	Local lExiste 	As Logical
	Local oQry		As Object		
	Local cQry 		As Character

	Default cFilialSE2 := SE2->E2_FILIAL
	Default cTitPaiSE2 := SE2->( E2_PREFIXO + E2_NUM + E2_PARCELA + E2_TIPO + E2_FORNECE + E2_LOJA )
	Default lHelp      := .F.

	lExiste := .F.
	oQry	:= Nil
	cQry 	:= ""
	cFilialSE2 := xFilial( "SE2" , cFilialSE2 )
	cTitPaiSE2 := Pad( cTitPaiSE2 , TamSX3( "E2_TITPAI" )[ 1 ] )

	cQry := "SELECT COUNT( E2_TITPAI ) QTD "
	cQry += "FROM" + RetSqlName("SE2") + " E2 "
	cQry += "WHERE E2_FILIAL = ? "
	cQry += "AND E2.E2_TITPAI = ? "
	cQry += "AND E2.E2_IDDARF <> ? "
	cQry += "AND D_E_L_E_T_ = ' ' "

	cQry := ChangeQuery(cQry)
	
	oQry := FWPreparedStatement():New(cQry)
	oQry:SetString(1, cFilialSE2)
	oQry:SetString(2, cTitPaiSE2)
	oQry:SetString(3, Space( TamSX3( "E2_IDDARF" )[ 1 ] ))
	
	nValor := MPSysExecScalar(oQry:GetFixQuery(), "QTD")

	lExiste := nValor > 0

	If lExiste .And. lHelp
		Help( " " , 1 , "SE2DARF1" ) //Este titulo nao podera ser excluido pois faz parte de uma DARF.
	EndIf

	FreeObj(oQry)
Return lExiste
