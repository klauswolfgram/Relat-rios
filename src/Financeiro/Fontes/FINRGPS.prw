/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.Ch"
#Include "FWCommand.Ch"

#define GPS_COD		1
#define GPS_LOJA	2
#define GPS_VALOR	4
#define GPS_ACHOU	5
#define GPS_CNPJ	6

Static lFWCodFil := .t.
Static lFRGPSFOR
Static cFilUnEmp := ""

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³FINRGPS   ³ Autor ³ Claudio Donizete      ³ Data ³03.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime a Guia para pagamento da GPS a partir dos titulos   ³±±
±±³          ³de INSS do contas a pagar                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinrGps()

Local cDesc1 	:= "Guia de I.N.S.S. (G.P.S.)"
Local cDesc2 	:= "Ser  impresso de acordo com os parametros solicitados pelo usuario."
Local cDesc3 	:= ""
Local cString	:= "SE2"					// Alias do Arquivo Principal (Base)
Local aOrd   	:= {}    					// Ordem
Local aGps		:= {}
Local aGpsIna	:= {}
Local aGpsIns	:= {}
Local Titulo 	:= "EMISSÃO GUIA DE RECOLHIMENTO DA PREVIDENCIA SOCIAL"
Private cPerg  := "FINGPS"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        //  Filial  De                               ³
//³ mv_par02        //  Filial  Ate                              ³
//³ mv_par03        //  Centralizado ( S/N )                     ³
//³ mv_par04        //  Mes e Ano da Competencia                 ³
//³ mv_par05        //  Codigo de Pagamento.                     ³
//³ mv_par06        //  ATM / MULTA / JUROS                      ³
//³ mv_par07        //  Fornecedor de                            ³
//³ mv_par08        //  Fornecedor ate                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// ------------------------------------------------------------------------------
// Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso 
// aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
If RetGlbLGPD("A2_NOME")
	Help(" ",1,"DADO_PROTEGIDO")
	RETURN
ENDIF
// ------------------------------------------------------------------------------

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAreaSM0 := SM0->(GetArea())
If pergunte(cPerg,.T.)
	RestArea(aAreaSM0)
	RptStatus({|lEnd| U_FGpsProc() }, Titulo ) //"EMISSŽO GUIA DE RECOLHIMENTO DA PREVIDENCIA SOCIAL"
Endif
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FGpsProc  ³ Autor ³Claudio D. de Souza    ³ Data ³08/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Prepara os dados para Impressao do formulario GPS  grafico ³±±
±±³          ³ conforme layout INSS                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PrtGps(aGps)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum   								                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FGpsProc
Local nX
Local dDataIni
Local dDataFim
Local lQuery
Local aStru
Local cAliasSe2
Local aInfo
Local dVencto
Local oPrint
Local nSavSm0 := SM0->(Recno())
Local cFilOld := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
Local bWhile
Local nInc		:= 0
Local aSM0
Local aFil
Local aRecnos := {}
Local lAdto		:= .F.
Local lNota		:= .F.
Local aEmpCont	:=	{} //Dados da empresa contratante caso seja guia emitida por uma cooperativa.
Local lFWCodFil	:= .T.
Local cFilAtual	:=	cFilAnt
Local nRegSM0 		:= SM0->(Recno())
Local lFinGPSPrc  := ExistBlock("FINGPSPRC")
Local aProc		:= {}
Local aAreaSM0
Local lGestao   := ( FWSizeFilial() > 2 )
Local cFilialAtu	:=	cFilAnt
Local cGRP	:=	FWGRPCompany()
Local aSelFil := {}
Local nC := 0
Local cRngFilSE2 := ""
Local cTmpSE2Fil := ""
Local aTmpFil := {}
Local cFilSE2 := ""

dDataIni := Ctod("01/"+Left(mv_par04,2)+"/"+Right(mv_par04,4))
dDataFim := LastDay(dDataIni)

If !( ChkFile("SE2",.F.,"NEWSE2") )
	Return(Nil)
EndIf


aSM0 := AdmAbreSM0()

#IFDEF TOP
	aAreaSM0 := SM0->(GetArea())
	If mv_par10 == 1 
		aSelFil := AdmGetFil(.F.,.T.,"SE2")
	Else
		aSelFil := { cFilAnt }	
	Endif
	RestArea(aAreaSM0)
#ENDIF

If Empty(aSelFil)
	aSelFil := {cFilAnt}
	cFilSE2 := " SE2.E2_FILIAL = '"+ FWxFilial("SE2", cFilAnt) + "' AND "
Else
	aSort(aSelFil)
	cRngFilSE2 := GetRngFil( aSelFil, "SE2", .T., @cTmpSE2Fil )
	aAdd(aTmpFil, cTmpSE2Fil)
	cFilSE2 := " SE2.E2_FILIAL "+ cRngFilSE2 + " AND "
Endif

#IFNDEF TOP
	cFilAtual := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
#ELSE
mv_par01 := Alltrim(aSM0[1][SM0_CODFIL])
mv_par02 := Alltrim(aSM0[Len(aSM0)][SM0_CODFIL])
cFilAtual := cFilAnt
#ENDIF

aEmpCont	:={}

#IFNDEF TOP
SM0->(MsSeek(cEmpAnt))
While !Eof() .and. SM0->M0_CODIGO == cEmpAnt
	If	Alltrim(SM0->M0_CODFIL) == Alltrim(cFilAtual)
		Aadd(aEmpCont,{SM0->M0_CGC,; //CGC
							PadR(SM0->M0_NOMECOM,40),; //RAZAO
							PadR(SM0->M0_ENDCOB,30),; //ENDERECO COBRANCA
							PadR(SM0->M0_BAIRCOB,20),; //BAIRRO COBRANCA
							PadR(SM0->M0_CIDCOB,20),; //CIDADE COBRANCA
							PadR(SM0->M0_ESTCOB,2),; //ESTADO COBRANCA
							PadR(SM0->M0_CEPCOB,2),; //CEP COBRANCA
							PadR(ALLTRIM(SM0->M0_TEL),14)}) //TELEFONE COBRANCA
		Exit
	Endif
	SM0->(Dbskip())
Enddo
SM0->(DbGoto(nRegSM0))
#ELSE
For nInc := 1 To Len( aSM0 )
	If	AllTrim(aSM0[nInc][SM0_CODFIL]) == cFilAtual
		aAreaSM0 := SM0->(GetArea())
		SM0->(dBGoTo(aSM0[nInc][SM0_RECNO]))
		Aadd(aEmpCont,{SM0->M0_CGC,; //CGC
							PadR(SM0->M0_NOMECOM,40),; //RAZAO
							PadR(SM0->M0_ENDCOB,30),; //ENDERECO COBRANCA
							PadR(SM0->M0_BAIRCOB,20),; //BAIRRO COBRANCA
							PadR(SM0->M0_CIDCOB,20),; //CIDADE COBRANCA
							PadR(SM0->M0_ESTCOB,2),; //ESTADO COBRANCA
							PadR(SM0->M0_CEPCOB,2),; //CEP COBRANCA
							PadR(ALLTRIM(SM0->M0_TEL),14)}) //TELEFONE COBRANCA
		RestArea(aAreaSM0)
		Exit
	Endif
Next
#ENDIF

For nInc := Len(aSM0) To 1 Step -1
	If aScan(aSelFil,Alltrim(aSM0[nInc][SM0_CODFIL])) == 0 .Or. Alltrim(aSM0[nInc][SM0_GRPEMP]) != cGRP;
		.Or. Alltrim(aSM0[nInc][SM0_CODFIL]) == "99"
		aDel(aSM0,nInc)
		nC++
	EndIf
Next

aSize(aSM0,Len(aSM0) - nC)
aSort(aSM0,,,{|x,y| x[2] < y[2]})

#IFNDEF TOP
For nInc := 1 To Len( aSM0 )
	If Alltrim(aSM0[nInc][1]) == cEmpAnt .AND. Alltrim(aSM0[nInc][SM0_CODFIL]) >= mv_par01 .AND. Alltrim(aSM0[nInc][SM0_CODFIL]) <= mv_par02
		cFilAnt := Alltrim(aSM0[nInc][SM0_CODFIL])
#ENDIF

		#IFDEF TOP

			lQuery := .T.
			aStru  := SE2->(dbStruct())
			If !Empty(cAliasSE2)
				DbSelectArea(cAliasSE2)
				DbCloseArea()
			EndIf
			cAliasSE2 := GetNextAlias()

			cQuery := "SELECT * "
			cQuery += "FROM "+RetSqlName("SE2")+" SE2 "
			cQuery += "WHERE " + cFilSE2 // SE2.E2_FILIAL='"+xFilial("SE2")+"' AND "
			If mv_par09 == 2
				cQuery += "SE2.E2_EMIS1>='"+DTOS(dDataIni)+"' AND "
				cQuery += "SE2.E2_EMIS1<='"+DTOS(dDataFim)+"' AND "
			Else
				cQuery += "SE2.E2_EMISSAO>='"+DTOS(dDataIni)+"' AND "
				cQuery += "SE2.E2_EMISSAO<='"+DTOS(dDataFim)+"' AND "
			EndIf
			cQuery += "SE2.E2_FORNECE>='"+MV_PAR07+"' AND "
			cQuery += "SE2.E2_FORNECE<='"+MV_PAR08+"' AND "
			cQuery += "(SE2.E2_INSS > 0 OR "
			cQuery += "(SE2.E2_INSS = 0 AND SE2.E2_TIPO IN " + FormatIn(MVINSS+'INA',,3) + ")) AND "

			If ExistBlock("FINGPSQRY")
				cQuery += ExecBlock("FINGPSQRY",.F.,.F.)
			EndIf

			cQuery += "SE2.D_E_L_E_T_=' ' "
			cQuery += "ORDER BY "+SqlOrder(SE2->(IndexKey()))

			cQuery := ChangeQuery(cQuery)

			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSE2)
			For nX := 1 To Len(aStru)
				If aStru[nX][2]<>"C"
					TcSetField(cAliasSE2,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
				EndIf
			Next nX
		#ELSE
			If mv_par09 == 2
				SE2->(DbSetOrder(7))
				SE2->(MsSeek(xFilial("SE2")+DTOS(dDataIni),.T.))
			Else
				SE2->(DbSetOrder(5))
				SE2->(MsSeek(xFilial("SE2")+DTOS(dDataIni),.T.))
			EndIf
			cAliasSe2 := "SE2"
		#ENDIF

		If mv_par09 == 2
			SE2->(DbSetOrder(7))
			bWhile := {|| ((cAliasSE2)->(!Eof()) .And. (cAliasSE2)->(E2_FILIAL)==xFilial("SE2") .And. (cAliasSE2)->(E2_EMIS1) <= dDataFim ) }
		Else
			SE2->(DbSetOrder(5))
			bWhile := {|| ((cAliasSE2)->(!Eof()) .And. (cAliasSE2)->(E2_FILIAL)==xFilial("SE2") .And. (cAliasSE2)->(E2_EMISSAO) <= dDataFim ) }
		EndIf

		aRecnos := {}
		aInfo	:= {}
		aFil	:= {}
		#IFDEF TOP
			cFilAnt := (cAliasSE2)->(E2_FILORIG)
		#ENDIF
		// Se possuir filial centralizadora, posiciona nesta filial
		If !Empty(mv_par03)
			aFil := FWArrFilAtu(cEmpAnt, mv_par03 )
		Else
		    aFil := FWArrFilAtu(cEmpAnt, cFilAnt )
		Endif

		IF !Empty( aFil ) .AND. fInfo( @aInfo, aFil[2] )
			aGpsIns		:= {}
			aGpsIna		:= {}	
			While Eval(bWhile)
				
				lAchouPai	 := .T.
				
				If aScan(aRecnos,{|x| x == (cAliasSE2)->(R_E_C_N_O_) } ) > 0
					(cAliasSE2)->(DbSkip())
				#IFDEF TOP
					cFilAnt := (cAliasSE2)->(E2_FILIAL)
				#ENDIF
					Loop				
				Else
					aAdd(aRecnos, (cAliasSE2)->(R_E_C_N_O_) )
				Endif
				// Se nao for titulo de INSS
				If (cAliasSE2)->E2_TIPO $ MVINSS+"/"+"INA"
					// Se achou o titulo pai, significa que o INSS ja foi impresso ou ainda vai ser
					If FrGpsPai(cAliasSe2)
						(cAliasSE2)->(DbSkip())
						#IFDEF TOP
							cFilAnt := (cAliasSE2)->(E2_FILIAL)
						#ENDIF
						Loop
					Endif
					lAchouPai := .F.
				Else
					If (cAliasSE2)->E2_INSS	 = 0
						(cAliasSE2)->(DbSkip())
						#IFDEF TOP
							cFilAnt := (cAliasSE2)->(E2_FILIAL)
						#ENDIF
						Loop
					Endif
				Endif	
				
				dbSelectArea("SA2")
				cFilUnEmp := xFilial("SA2")
				MsSeek(xFilial("SA2")+(cAliasSe2)->(E2_FORNECE+E2_LOJA))

				If lFinGPSPrc
					aProc := ExecBlock("FINGPSPRC",.F.,.F.,{cAliasSe2,aGpsIns,aGpsIna,lAchouPai})
					aGpsIns := aProc[1]
					aGpsIna := aProc[2]
				Else
					If (cAliasSe2)->E2_TIPO $ MVINSS+"/"+"INA" .Or.;
						((cAliasSe2)->E2_FORNECE >= mv_par07 .And. (cAliasSe2)->E2_FORNECE <= mv_par08)
						// Nao achou o fornecedor, adiciona novo item no array
						If !((cAliasSe2)->E2_TIPO $ MVPAGANT+"/INA")
							nX := Ascan( aGpsIns, { |e| e[1]+e[6] == SA2->A2_COD + SA2->A2_CGC } )
							If nX == 0
								aadd(aGpsIns,{	SA2->A2_COD,;
												SA2->A2_LOJA,;
												SA2->A2_NOME,;
												xMoeda(If( ! (cAliasSE2)->E2_TIPO $ MVINSS+"/"+"INA", (cAliasSe2)->E2_INSS, (cAliasSe2)->E2_VALOR),(cAliasSE2)->E2_MOEDA,1),;
												lAchouPai,;
												SA2->A2_CGC})
							Else
								// Senao soma o valor do INSS do fornecedor
								aGpsIns[nX][GPS_VALOR] += xMoeda(If( ! (cAliasSE2)->E2_TIPO $ MVINSS+"/"+"INA", (cAliasSe2)->E2_INSS, (cAliasSe2)->E2_VALOR),(cAliasSE2)->E2_MOEDA,1)
							EndIf
						Else
							nX := Ascan( aGpsIna, { |e| e[1]+e[6] == SA2->A2_COD + SA2->A2_CGC } )
							If nX == 0
								aadd(aGpsIna,{	SA2->A2_COD,;
												SA2->A2_LOJA,;
												SA2->A2_NOME,;
												xMoeda(If( ! (cAliasSE2)->E2_TIPO $ MVINSS+"/"+"INA", (cAliasSe2)->E2_INSS, (cAliasSe2)->E2_VALOR),(cAliasSE2)->E2_MOEDA,1),;
												lAchouPai,;
												SA2->A2_CGC})
							Else
								// Senao soma o valor do INSS do fornecedor
								aGpsIna[nX][GPS_VALOR] += xMoeda(If( ! (cAliasSE2)->E2_TIPO $ MVINSS+"/"+"INA", (cAliasSe2)->E2_INSS, (cAliasSe2)->E2_VALOR),(cAliasSE2)->E2_MOEDA,1)
							EndIf
						EndIf								
					Endif	
					
				EndIF	
				(cAliasSE2)->(DbSkip())
				#IFDEF TOP
					cFilAnt := (cAliasSE2)->(E2_FILIAL)
				#ENDIF
				
			End

			aGps		:= {}
			
			If Len(aGpsIna) > 0 .And. Len(aGpsIns) > 0
				MsgInfo("Os calculos foram efetuados considerando titulos INSS Adto e Normal para emissão da GPS","Atenção")
				For nX := 1 To Len(aGpsIns)
					nY := Ascan( aGpsIna, { |e| e[1]+e[6] == aGpsIns[nx][1] + aGpsIns[nx][6] } )
					If ny == 0
						aAdd(aGps,aGpsIns[nx])   //Carrega Agps pelo INS
					Else
						If aGpsIns[nx][GPS_VALOR] >= aGpsIna[ny][GPS_VALOR]
							aAdd(aGps,aGpsIns[nx])   //Carrefa Agps pelo INS
						Else
							aAdd(aGps,aGpsIna[ny])   //Carrega Agps pelo INA
						EndIf
					EndIf
				Next
			ElseIf Len(aGpsIns) > 0
				aGps := aClone(aGpsIns) //			Carrefa Agps pelo INS
			ElseIf Len(aGpsIna) > 0
				aGps := aClone(aGpsIna) //			Carrega Agps pelo INA
			EndIf

			If ValType(oPrint) != "O"
				oPrint 	:= TMSPrinter():New("GPS - Guia da Previdência Social")
				oPrint:Setup()
				oPrint:SetPortrait()
			Endif

			For nX := 1 To Len(aGps)
				U_PrtGps(aGps[nX],oPrint,aInfo,aEmpCont)
			Next

		Endif
#IFNDEF TOP
	EndIf
#ENDIF
#IFNDEF TOP
Next
#ELSE
  	For nX := 1 TO Len(aTmpFil)
		CtbTmpErase(aTmpFil[nX])
    Next
#ENDIF

If ValType(oPrint) == "O"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Finaliza a Impressão                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Preview()
Endif

NEWSE2->(DbCloseArea())
#IFNDEF TOP
cFilAnt := cFilOld
#ELSE
cFilAnt := cFilialAtu
#ENDIF

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrtGps    ³ Autor ³Claudio D. de Souza    ³ Data ³04005/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do formulario GPS  grafico conforme layout INSS  ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PrtGps(aGps)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1: [1] Codigo do fornecedor                            ³±±
±±³          ³        [2] Nome do Fornecedor                              ³±±
±±³          ³        [3] Valor do INSS				                       ³±±
±±³          ³        [4] .T. se achou titulo pai                         ³±±
±±³          ³ ExpO1: Objeto printer				                          ³±±
±±³          ³ ExpA2: Dados da filial a ser impressa							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function  PrtGps(aGps,oPrint,aInfo,aEmpCont)

Local cBmp 		 := ""
Local cStartPath := GetSrvProfString("StartPath","")
Local nX         := 030
Local nY         := 0
Local oFont07    := TFont():New("Arial",07,10,,.F.,,,,.T.,.F.)
Local oFont09    := TFont():New("Arial",09,09,,.F.,,,,.T.,.F.)
Local oFont10    := TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
Local oFont10n   := TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)
Local oFont11    := TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
Local oFont15    := TFont():New("Arial",15,15,,.F.,,,,.T.,.F.)
Local cCgc       := ""
Local cRazao     := ""
Local cEndereco  := ""
Local cFone		  := ""
Local cCep       := ""
Local cMunicipio := ""
Local cUf        := ""
Local cCodBarSdv
Local cCodBarCDv
Local cCampo1
Local cCampo2
Local cCampo3
Local cCampo4
Local dEmissao := DataValida(Ctod("01/"+Left(mv_par04,2)+"/"+Right(mv_par04,4)),.T.)
Local cTipo		:= ""
Local aRetGPS := {}
Local nBoxWidth := 2400
Local nWidthBar := 0

Default lFRGPSFOR := ExistBlock("FRGPSFOR")

// Se nao encontrou o titulo pai, imprime os dados de recolhimento em nome da empresa
If ! aGps[GPS_ACHOU]
	cCgc      	:= aInfo[8]                      // CGC
	cRazao    	:= PadR(aInfo[3],40) // Razao Social
	cFone     	:= PadR(aInfo[10],14)
	cEndereco 	:= PadR(aInfo[4],30)
	cBairro   	:= PadR(aInfo[13],20)
	cCep      	:= PadR(aInfo[7],8)
	cMunicipio	:= PadR(aInfo[5],20)
	cUf       	:= PadR(aInfo[6],2)
	cCGC 		:= PadR(If (aInfo[15] == 1 ,aInfo[8],Transform(cCgc,"@R ##.###.###/####-##")),18) // CGC
	cTipo		:= "J"
Else
	// Senao imprime os dados de recolhimento em nome do fornecedor
	If !SA2->(MsSeek(xFilial("SA2")+aGps[GPS_COD]+aGps[GPS_LOJA]))
		SA2->(MsSeek(cFilUnEmp+aGps[GPS_COD]+aGps[GPS_LOJA]))
	EndIf

	If Alltrim(SA2->A2_CNAE) $ "65242_66303" .And. Len(aEmpCont)>0 //Trata-se de uma COOPERATIVA entao os dados a serem enviados deve ser da empresa que está rodando a guia.
		cCgc      	:= aEmpCont[1,1]	         //CGC
		cRazao    	:= PadR(aEmpCont[1,2],40) //Razao Social
		cEndereco 	:= PadR(aEmpCont[1,3],30)	//Endereco
		cMunicipio	:= PadR(aEmpCont[1,5],20) //Cidade
		cUf       	:= PadR(aEmpCont[1,6],2)  //Estado
		cCep      	:= PadR(aEmpCont[1,7],8)  //Cep
		cFone     	:= PadR(aEmpCont[1,8],14) //Telefone
		cBairro   	:= PadR(aEmpCont[1,4],20)	//Bairro
	Else
		cCgc      	:= SA2->A2_CGC            // CGC
		cRazao    	:= PadR(SA2->A2_NOME,40) // Razao Social
		cFone     	:= PadR(ALLTRIM(SA2->A2_TEL),14)
		cEndereco 	:= PadR(SA2->(ALLTRIM(A2_END)+" " +ALLTRIM(A2_NR_END)),30)
		cBairro   	:= PadR(SA2->A2_BAIRRO,20)
		cCep      	:= PadR(SA2->A2_CEP,8)
		cMunicipio	:= PadR(SA2->A2_MUN,20)
		cUf       	:= PadR(SA2->A2_EST,2)
	Endif

	cCGC 			:= PadR(If (SA2->A2_TIPO!="J",aInfo[8],Transform(cCgc,"@R ##.###.###/####-##")),18) // CGC
	cTipo		:= IIf(!Empty(SA2->A2_TIPO),SA2->A2_TIPO,"J")

	If lFRGPSFOR
		aRetGPS := ExecBlock("FRGPSFOR",.F.,.F.,{cCgc,cRazao,cFone,cEndereco,cBairro,cCep,cMunicipio,cUf,SA2->(Recno())})
		If ValType(aRetGPS) == "A" .And. Len(aRetGPS) >= 8
			cCgc 			:= aRetGPS[1]
			cRazao    	:= PadR(aRetGPS[2],40) // Razao Social
			cFone     	:= PadR(aRetGPS[3],14)
			cEndereco 	:= PadR(aRetGPS[4],30)
			cBairro   	:= PadR(aRetGPS[5],20)
			cCep      	:= PadR(aRetGPS[6],8)
			cMunicipio	:= PadR(aRetGPS[7],20)
			cUf       	:= PadR(aRetGPS[8],2)
		EndIf
	EndIf
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializacao do objeto grafico                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cBmp := cStartPath + "GPS.BMP" //Logo da Receita Federal
oPrint:StartPage()
nX := 030
cCodBarSDv := "858" + StrZero((aGps[GPS_VALOR]+mv_par06)*100,11)+"0270"+MV_PAR05+StrTran(StrTran(StrTran(cCgc,".",""),"/",""),"-","")+Right(mv_par04,4)+Left(mv_par04,2) + "7"
cCodBarCDv := Left(cCodBarSDv, 3) + Modulo11( cCodBarSDv,2,9 ) + SubStr(cCodBarSDv,4)

cCampo1 := Left(cCodBarCDv,11)
cCampo1 := cCampo1 + "-" +  Modulo11(cCampo1,2,9)

cCampo2 := SubStr(cCodBarCdv,12,11)
cCampo2 := cCampo2 + "-" +  Modulo11(cCampo2,2,9)

cCampo3 := SubStr(cCodBarCdv,23,11)
cCampo3 := cCampo3 + "-" + Modulo11(cCampo3,2,9)

cCampo4 := SubStr(cCodBarCdv,34,11)
cCampo4 := cCampo4 + "-" +  Modulo11(cCampo4,2,9)

For nY := 1 To 2
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Box grafico                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Box(nX,0030,nX+1100,nBoxWidth)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inclusao do logotipo do Ministerio da Fazenda                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If File(cBmp)
		oPrint:SayBitmap(nX+10,040,cBmp,200,180)
	EndIf
	oPrint:Say(nX+020,270,"MINISTÉRIO DA PREVIDÊNCIA SOCIAL - MPS",oFont07)
	oPrint:Say(nX+070,270,"SECRETARIA DA RECEITA PREVIDENCIÁRIA - SRP",oFont07)
	oPrint:Say(nX+120,270,"INSTITUTO NACIONAL DO SEGURO SOCIAL - INSS",oFont07)
	oPrint:Say(nX+170,270,"GUIA DA PREVIDÊNCIA SOCIAL - GPS",oFont15)

	oPrint:Line(nX,1300,nX+1100,1300)
	oPrint:Line(nX,1800,nX+810,1800)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 01                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+270,030,nX+270,1300)
	oPrint:Say(nX+280,040,"1 - ",oFont10)
	oPrint:Say(nX+280,110,"NOME OU RAZÃO SOCIAL / ENDEREÇO / TELEFONE",oFont10)
	oPrint:Say(nX+345,110,cRazao + "/",oFont10)
	oPrint:Say(nX+380,110,cEndereco + " - " + cBairro,oFont10)
	oPrint:Say(nX+415,110,cCep + " - " + cMunicipio + " - " + cUf,oFont10)

	oPrint:Say(nX+495,040,"2 - VENCIMENTO",oFont10)
	oPrint:Say(nX+530,040,"(Uso exclusivo do INSS)",oFont10)

	//Calculo do Vencto do INSS
	dVencto := F050VIMP("INSS",dEmissao,dEmissao,dEmissao,,cTipo)

	oPrint:Say(nX+530,550,Transform(dVencto,""),oFont10)
	oPrint:Line(nX+490,450,nX+650,450)


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 03                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+490,030,nX+490,1300)
	oPrint:Line(nX+650,030,nX+650,1300)
	oPrint:Say(nX+020,1305,"3 - CÓDIGO DE PAGAMENTO",oFont09)
	oPrint:Say(nX+030,2190,MV_PAR05,oFont10)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 04                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+090,1300,nX+90,nBoxWidth)
	oPrint:Say(nX+120,1305,"4 - COMPETÊNCIA",oFont09)
	oPrint:Say(nX+130,2010,Subs(mv_par04,1,2)+"/"+Subs(mv_par04,3,4),oFont10)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 05                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+180,1300,nX+180,nBoxWidth)
	oPrint:Say(nX+200,1305,"5 - IDENTIFICADOR",oFont09)
	oPrint:Say(nX+210,2010,cCgc,oFont10)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 06                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+270,1300,nX+270,nBoxWidth)
	oPrint:Say(nX+290,1305,"6 - VALOR DO INSS",oFont09)
	oPrint:Say(nX+300,2100,Transform(aGps[GPS_VALOR],"@E 9,999,999,999.99"),oFont10)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 07                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+360,1300,nX+360,nBoxWidth)
	oPrint:Say(nX+380,1305,"7 -",oFont09)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 08                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+450,1300,nX+450,nBoxWidth)
	oPrint:Say(nX+470,1305,"8 - ",oFont09)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 09                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+ 540,1300,nX+540,nBoxWidth)
	oPrint:Say(nX+552,1303,"9 - VALOR DE OUTRAS",oFont09)
	oPrint:Say(nX+582,1350,"ENTIDADES",oFont09)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 10                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+630,1300,nX+630,nBoxWidth)
	oPrint:Say(nX+650,1305,"10 - ATM/MULTA E JUROS",oFont09)
	oPrint:Say(nX+670,2100,Transform(mv_par06,"@E 9,999,999,999.99"),oFont10)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 11                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+720,1300,nX+720,nBoxWidth)
	oPrint:Say(nX+740,1305,"11 - VALOR TOTAL",oFont10)
	oPrint:Say(nX+750,2100,Transform(aGps[GPS_VALOR]+mv_par06,"@E 9,999,999,999.99"),oFont10)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro 12                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Line(nX+810,1300,nX+810,nBoxWidth)
	oPrint:Say(nX+830,1305,"12",oFont10)
	oPrint:Say(nX+830,1370,"AUTENTICAÇÃO BANCÁRIA (SOMENTE NAS 1 E 2 VIAS)",oFont10n)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicao do Quadro de aviso                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Say(nX+0680,600,"ATENÇÃO",oFont10n)
	oPrint:Say(nX+0740,040,"É vedada a utilização de GPS para recolhimento de receita de valor inferior",oFont07)
	oPrint:Say(nX+0780,040,"ao estipulado em Resolução publicada pelo INSS. A receita que resultar valor",oFont07)
	oPrint:Say(nX+0820,040,"inferior, deverá ser adicionada a contribuição ou importância correspondente",oFont07)
	oPrint:Say(nX+0860,040,"nos  meses subsequentes,  até que o total  seja  igual ou  superior ao valor",oFont07)
	oPrint:Say(nX+0900,040,"mínimo fixado",oFont07)

	oPrint:Say(nX+1030,040,"GPS Manual",oFont07)

	oPrint:Say(nX+1110,290,cCampo1 + " " + cCampo2 + " " + cCampo3 + " " + cCampo4,oFont10n)

	nWidthBar := IIf(nY == 1, 10.4, 23.4) * 300 / oPrint:nLogPixelX()

	//MSBAR("INT25",If(nY==1,10.7,23.8),1,AllTrim(StrTran(SubStr(cCampo1,1,len(cCampo1)-1)+SubStr(cCampo2,1,len(cCampo2)-1)+SubStr(cCampo3,1,len(cCampo3)-1)+SubStr(cCampo4,1,len(cCampo4)-1),"-","")),oPrint,.F.,Nil,Nil,0.025,1.5,Nil,Nil,"A",.F.)

	MsBar3("INT25",nWidthBar,1,AllTrim(StrTran(SubStr(cCampo1,1,len(cCampo1)-1)+SubStr(cCampo2,1,len(cCampo2)-1)+SubStr(cCampo3,1,len(cCampo3)-1)+SubStr(cCampo4,1,len(cCampo4)-1),"-","")),oPrint,.F.,Nil,Nil,Nil,Nil,Nil,Nil,"A",.F.)

	If nY == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Definicao do picote                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Say(nX+1410,000,Replicate("-",132),oFont11)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Segunda via do Darf                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nX := 1580
	EndIf
Next
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Finaliza a pagina                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPrint:EndPage()

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ FrGpsPai ³ Autor ³ Claudio Donizete      ³ Data ³08.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Posiciona no titulo pai do titulo de INSS                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³lRet - .T. Encontrou titulo pai, .F. caso contrario         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³cAliasSe2 - Alias do contas a pagar                         ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FrGpsPai(cAliasSe2)
LOCAL nRegSE2:= NEWSE2->(Recno())
LOCAL lAchou:= .F.
LOCAL cPrefixo := (cAliasSe2)->E2_PREFIXO
LOCAL cNum		:= (cAliasSe2)->E2_NUM
LOCAL cParcela := (cAliasSe2)->E2_PARCELA
LOCAL cTipoPai	:= (cAliasSe2)->E2_TIPO
LOCAL cParcPai
LOCAL cValorcPai
Local aArea := GetArea()
Local lPai := .F.

If (cAliasSe2)->E2_TIPO $ MVINSS+"/"+"INA"
	cValorPai := "NEWSE2->E2_INSS"
	cParcPai := "E2_PARCINS"
Else
	lPai := .T.
Endif

// Se nao estiver no titulo pai, procura o titulo Pai.
If !lPai
	dbSelectArea("NEWSE2")
	dbSetOrder(1)
	nRegSE2:= Recno()
	If MsSeek(xFilial("SE2")+cPrefixo+cNum)
		While !Eof() .and. NEWSE2->(E2_FILIAL+E2_PREFIXO+E2_NUM) == xFilial("SE2")+cPrefixo+cNum
			If &(cParcPai) == cParcela
				If &(cValorPai) != 0
					lAchou := .T.
					Exit
				EndIf
			EndIf
			DbSkip()
		Enddo
	EndIf
Endif

dbSelectArea("NEWSE2")
// Se nao encontrou o registro pai, restaura o ponteiro do alias alternativo
// Pois o registro pode ja estar posicionado no titulo principal.
If !lAchou .And. !lPai
	dbGoto(nRegSE2)
Elseif !lAchou
	NEWSE2->(MsSeek(xFilial("SE2")+(cAliasSe2)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)))
Endif

Return lAchou
/*
Static Function Mod10( cNum )
Local nFor    := 0
Local nTot    := 0
Local nMult   := 2

For nFor := Len(cNum) To 1 Step -1
	nTot += (nMult * Val(SubStr(cNum,nFor,1)))
	nMult := If(nMult==2,1,2)
Next

nTot := nTot % 10
nTot := If( nTot#0, 10-nTot, nTot )

Return Str(nTot,1)
*/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AdmAbreSM0³ Autor ³ Orizio                ³ Data ³ 22/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna um array com as informacoes das filias das empresas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AdmAbreSM0()
	Local aArea			:= SM0->( GetArea() )
	Local aAux			:= {}
	Local aRetSM0		:= {}
	Local lFWLoadSM0	:= .T.
	Local lFWCodFilSM0 	:= .T.

	If lFWLoadSM0
		aRetSM0	:= FWLoadSM0()
	Else
		DbSelectArea( "SM0" )
		SM0->( DbGoTop() )
		While SM0->( !Eof() )
			aAux := { 	SM0->M0_CODIGO,;
						IIf( lFWCodFilSM0, FWGETCODFILIAL, SM0->M0_CODFIL ),;
						"",;
						"",;
						"",;
						SM0->M0_NOME,;
						SM0->M0_FILIAL }

			aAdd( aRetSM0, aClone( aAux ) )
			SM0->( DbSkip() )
		End
	EndIf

	RestArea( aArea )
Return aRetSM0
