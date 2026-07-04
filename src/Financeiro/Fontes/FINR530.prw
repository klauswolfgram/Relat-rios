/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR530.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} FINR530
Resumo Bancario - Movimento Financeiro Diario
@type function  
@author Pedro Pereira Lima
@since 03/05/2013
/*/
User Function FINR530()
	Local oReport As Object

	Private cPerg As Character

	cPerg := "FIN530"

	oReport := ReportDef()
	oReport:PrintDialog()
	
Return

/*/{Protheus.doc} ReportDef
Definicao do layout do Relatorio
@type function
@author Pedro Pereira Lima
@since 07/05/2013
@return object, objeto report do Relatório
/*/
Static Function ReportDef() As Object
	Local oReport 	As Object
	Local oSecBco 	As Object
	Local cPictTit	As Character	
	Local nTamVal	As Numeric

	cPictTit := ""
	nTamVal	 := 0

	Pergunte(cPerg,.F.)
	////////////////////////////////////////////
	//	Variaveis utilizadas para parametros   //
	// ====================================== //
	//	MV_PAR01 - A partir de                 //
	//	MV_PAR02 - Qual moeda                  //
	//	MV_PAR03 - Considera Limite de Credito //
	//	MV_PAR04 - Outras Moedas               //
	//	MV_PAR05 - Seleciona Filiais           //
	////////////////////////////////////////////

	oReport := TReport():New("FINR530", STR0003, cPerg, { |oReport| ReportPrint(oReport) }, STR0001 + STR0002)

	oReport:SetLandScape(.T.)
	oReport:SetTotalInLine(.F.) // Imprime o total em linhas

	/* GESTAO - remover botão "gestão de empresas" (descontinuado) */
	oReport:SetUseGC(.F.)
	/* GESTAO */

	cPictTit := PesqPict("SE5","E5_VALOR")
	nTamVal  := TamSx3("E5_VALOR")[1]

	//Criação da Section principal
	oSecBco := TRSection():New(oReport, STR0003, {"SA6","SE5"})

	TRCell():New(oSecBco, "A6_COD",, 	 STR0014,		  , TamSX3("A6_COD")[1]	    ,.F.,,,,,,,.T.)
	TRCell():New(oSecBco, "A6_AGENCIA",, STR0015,		  , TamSX3("A6_AGENCIA")[1] ,.F.,,,,,,,.T.)
	TRCell():New(oSecBco, "A6_NUMCON",,  STR0016,		  , TamSX3("A6_NUMCON")[1]  ,.F.,,,,,,,.T.)
	TRCell():New(oSecBco, "A6_NREDUZ",,  STR0017,		  , TamSX3("A6_NREDUZ")[1]  ,.F.,,,,,,,.T.)
	TRCell():New(oSecBco, "SLD_INI",, 	 STR0018, cPictTit, nTamVal				    ,.F.,,,,,,,.T.)
	TRCell():New(oSecBco, "ENTRADAS",, 	 STR0019, cPictTit, nTamVal				    ,.F.,,,,,,,.T.)
	TRCell():New(oSecBco, "SAIDAS",, 	 STR0020, cPictTit, nTamVal				    ,.F.,,,,,,,.T.)
	TRCell():New(oSecBco, "APLICACOES",, STR0021, cPictTit, nTamVal				    ,.F.,,,,,,,.T.)
	TRCell():New(oSecBco, "SLD_DISPO",,  STR0022, cPictTit, nTamVal				    ,.F.,,,,,,,.T.)

	oSecBco:Cell("SLD_INI"):SetHeaderAlign("RIGHT")
	oSecBco:Cell("ENTRADAS"):SetHeaderAlign("RIGHT")
	oSecBco:Cell("SAIDAS"):SetHeaderAlign("RIGHT")
	oSecBco:Cell("APLICACOES"):SetHeaderAlign("RIGHT")
	oSecBco:Cell("SLD_DISPO"):SetHeaderAlign("RIGHT")

Return oReport

/*/{Protheus.doc} ReportPrint
A funcao estatica ReportDef devera ser criada para todos os
relatorios que poderao ser agendados pelo usuario.
@type function
@author Pedro Pereira Lima
@since 08/05/2013
@param oReport, object, objeto report do Relatório 
/*/
Static Function ReportPrint(oReport As Object)
	Local oSecBco		As Object
	Local nSaldoIni		As Numeric
	Local cBanco		As Character
	Local cAgencia		As Character
	Local cConta		As Character
	Local nRecBco		As Numeric
	Local nPagBco		As Numeric
	Local nAplic		As Numeric
	Local nDisponiv		As Numeric
	Local lAllFil		As Logical		
	Local lSelecFill	As Logical 	
	Local nOrdSE5 		As Numeric
	Local nTotRec		As Numeric
	Local cChave		As Character
	Local cIndex		As Character
	Local nTxMoeda		As Numeric
	Local nValor 		As Numeric
	Local cFilUser		As Character
	Local nMoedaBco		As Numeric
	Local nCasas		As Numeric
	Local nMoeda    	As Numeric
	Local bCondWhile    As Block
	Local nTxMoedBc		As Numeric
	Local cTab14 		As Character
	Local nK			As Numeric
	Local cAcumFil		As Character
	Local lCxLoja 		As Logical	
	Local oBreak		As Object
	Local nIndex 		As Numeric
	Local aArea			As Array
	Local aSM0Area		As Array
	Local cFilBak		As Character
	Local lSE5Compar    As Logical 
	Local lSE8Compar    As Logical
	Local lMsmCompar    As Logical
	Local lSE5Exclus    As Logical
	Local lSA6Compar    As Logical
	Local lGestao       As Logical
	Local lVldUnNeg     As Logical
	Local cTitulo       As Character
	Local dDataAtu      As Date
    LOCAL aRetAuto      AS Array
	Local cChaveSE5     As Char
	Local cFilialSE5    As Char
	Local cMAEmpSA6     As Char
	Local cMAUniSA6     As Char
	Local cMAFilSA6     As Char
	Local cMAEmpSE8     As Char
	Local cMAUniSE8     As Char
	Local cMAFilSE8     As Char
	Local cMAEmpSE5     As Char
	Local cMAUniSE5     As Char
	Local cMAFilSE5     As Char
	Local nTamEmp       As Numeric
	Local nTamUni       As Numeric	
	
	oSecBco		:= oReport:Section(1)
	nSaldoIni	:= 0
	cBanco		:= ""
	cAgencia	:= ""
	cConta		:= ""
	nRecBco		:= 0
	nPagBco		:= 0
	nAplic		:= 0
	nDisponiv	:= 0
	lAllFil		:= .F.
	lSelecFill 	:= (MV_PAR05 == 1)
	nOrdSE5 	:= SE5->(IndexOrd())
	nTotRec		:= SE5->(RecCount())
	cChave		:= ""
	cIndex		:= ""
	nTxMoeda	:= 0
	nValor 		:= 0
	cFilUser	:= ""
	nMoedaBco	:= 1
	nCasas		:= GetMv("MV_CENT"+(IIF(mv_par02 > 1 , Alltrim(STR(mv_par02)),"")))
	nMoeda    	:= mv_par02
	nTxMoedBc	:= 0
	cTab14 		:= ""
	nK			:= 0
	cAcumFil	:= ""
	lCxLoja 	:= GetNewPar("MV_CXLJFIN",.F.)
	nIndex 		:= 0
	aArea		:= GetArea()
	aSM0Area	:= SM0->(GetArea())
	cFilBak		:= cFilAnt
	lSE5Compar  := .F.
	lSE8Compar  := .F.
	lMsmCompar  := .F.
	lSE5Exclus  := .F.
	lGestao     := .T.
	lVldUnNeg   := .T.
	cTitulo     := ""
	dDataAtu    := dDataBase
    aRetAuto    := {}
	cChaveSE5   := ""
	cFilialSE5  := ""
	cMAEmpSA6   := AllTrim(FWModeAccess("SA6",1))
	cMAUniSA6   := AllTrim(FWModeAccess("SA6",2))
	cMAFilSA6   := AllTrim(FWModeAccess("SA6",3))
	cMAEmpSE8   := AllTrim(FWModeAccess("SE8",1))
	cMAUniSE8   := AllTrim(FWModeAccess("SE8",2))
	cMAFilSE8   := AllTrim(FWModeAccess("SE8",3))
	cMAEmpSE5   := AllTrim(FWModeAccess("SE5",1))
	cMAUniSE5   := AllTrim(FWModeAccess("SE5",2))
	cMAFilSE5   := AllTrim(FWModeAccess("SE5",3))
	nTamEmp     := Len(FwSM0Layout(,1))
	nTamUni     := Len(FwSM0Layout(,2))
	
	If Type("aSelFil") == "U"
		Private aSelFil := {}
	EndIf
	
	//Sempre que vier pelo teste automatizado o array aRetAuto terá conteúdo e funcionará como o lAutomato sinalizando que é um teste.
	If FindFunction("GetParAuto")
		aRetAuto := GetParAuto("FINR530TestCase")
	EndIf	
	
	If (nTamEmp+nTamUni) == 0
		cMAEmpSA6 := cMAUniSA6 := cMAFilSA6	
		cMAEmpSE8 := cMAUniSE8 := cMAFilSE8
		cMAEmpSE5 := cMAUniSE5 := cMAFilSE5
		lGestao   := .F.
	Else
		If nTamEmp == 0
			cMAEmpSA6 := cMAUniSA6
			cMAEmpSE8 := cMAUniSE8
			cMAEmpSE5 := cMAUniSE5
		ElseIf nTamUni == 0
			cMAUniSA6 := cMAFilSA6
			cMAUniSE8 := cMAFilSE8
			cMAUniSE5 := cMAFilSE5
		EndIf 
	EndIf
	
	//Exibe data de referencia no título
	lVldUnNeg  := lGestao
	lSA6Compar := ((cMAEmpSA6+cMAUniSA6+cMAFilSA6) == "CCC") 
	lSE5Compar := ((cMAEmpSE5+cMAUniSE5+cMAFilSE5) == "CCC")
	lSE8Compar := ((cMAEmpSE8+cMAUniSE8+cMAFilSE8) == "CCC")
	lSE5Exclus := ((cMAEmpSE5+cMAUniSE5+cMAFilSE5) == "EEE")	
	lAllFil    := ((cMAFilSA6 == "C") .Or. lSE8Compar)
	cTitulo    := STR0003 + " - "+dtoc(MV_PAR01)
	
	oReport:SetTitle(cTitulo)
	
	If mv_par05 == 1 .And. Len(aSelFil) == 0
		If !lSE8Compar .And. ((lSE5Exclus .Or. (cMAEmpSE5+cMAUniSE5) == "EE"))
			If nTamUni > 0 .And. !lSA6Compar
				lVldUnNeg := (cMAUniSA6 == "E")
			EndIf
			
			aSelFil := AdmGetFil(.F., lGestao, "SA6", lVldUnNeg, Nil, .T., lSA6Compar)
		ElseIf ((cMAFilSA6 == "C") .Or. lSE8Compar)
			Help(" ",1,"FIR530COMP",,STR0012,2,0)//"A Tabela SA6 (BANCOS) esta compartilhada, a pergunta 05 não terá efeito."
			lAllFil := .T.		
		EndIf
	EndIf
	
	If Len(aSelFil) == 0
		aSelFil := {cFilAnt}
	EndIf
	
	//Verifica se o usuário selecionou ao menos uma filial.
	oSecBco:Cell("A6_COD"):SetBlock( { || SA6->A6_COD })
	oSecBco:Cell("A6_AGENCIA"):SetBlock( { || SA6->A6_AGENCIA })
	oSecBco:Cell("A6_NUMCON"):SetBlock( { || SA6->A6_NUMCON })
	oSecBco:Cell("A6_NREDUZ"):SetBlock( { || SA6->A6_NREDUZ })
	oSecBco:Cell("SLD_INI"):SetBlock( { || nSaldoIni })
	oSecBco:Cell("ENTRADAS"):SetBlock( { || nRecBco })
	oSecBco:Cell("SAIDAS"):SetBlock( { || nPagBco })
	oSecBco:Cell("APLICACOES"):SetBlock( { || nAplic })
	oSecBco:Cell("SLD_DISPO"):SetBlock( { || nDisponiv })

	oBreak := TRBreak():New(oSecBco, {|| cFilAnt} , {|| STR0023},,, .T.)
	TRFunction():New(oSecBco:Cell("SLD_INI"),"","SUM",oBreak,,,,.F.,.F.)
	TRFunction():New(oSecBco:Cell("ENTRADAS"),"","SUM",oBreak,,,,.F.,.F.)
	TRFunction():New(oSecBco:Cell("SAIDAS"),"","SUM",oBreak,,,,.F.,.F.)
	TRFunction():New(oSecBco:Cell("APLICACOES"),"","SUM",oBreak,,,,.F.,.F.)
	TRFunction():New(oSecBco:Cell("SLD_DISPO"),"","SUM",oBreak,,,,.F.,.F.)

	oSecBco:Init()
	oReport:SetMeter(nTotRec)

	//Acerta a database de acordo com o parametro
	dDataBase := mv_par01

	For nK := 1 To Len(aSelFil)
		//-- Nessa condição ja houve a impressão de todos registros, conforme montagem do bCondWhile abaixo.
		If nK > 1 .And. TRIM(xFilial('SE8')) $ aSelFil[nK] .And. (lSE8Compar .Or. lSE5Compar)
			Loop
		EndIf
		
		cFilAnt := aSelFil[nK]
		SM0->(dbSetOrder(1))  // M0_CODIGO, M0_CODFIL.
		SM0->(dbSeek(cEmpAnt + cFilAnt, .F.))

		cTab14 := ""
		SX5->(dbSetOrder(1))
		SX5->(MsSeek(xFilial("SX5") + "14", .F.))

		While !SX5->(Eof()) .And. SX5->X5_TABELA == "14"
			cTab14 += AllTrim(SX5->X5_CHAVE) + "/"
			SX5->(dbSkip())
		Enddo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Filtra o arquivo por tipo e vencimento                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE5")
		dbSetOrder(nOrdSE5)

		cChave := "DTOS(E5_DTDISPO)+E5_BANCO+E5_AGENCIA+E5_CONTA"
		
		If !lSE8Compar .And. !lSE5Compar
			lMsmCompar := ((cMAEmpSE5+cMAUniSE5+cMAFilSE5) == (cMAEmpSE8+cMAUniSE8+cMAFilSE8) .And. ("C" $ (cMAEmpSE8+cMAUniSE8+cMAFilSE8)))
			cTitulo    := STR0003 + " - "+dtoc(MV_PAR01)+" ("+STR0027+": "+Alltrim(cFilAnt)+")"
			oReport:SetTitle(cTitulo)
			
			If cMAFilSA6 != "C"
				If (lMsmCompar .Or. ((cMAEmpSE8+cMAUniSE8+cMAFilSE8) > (cMAEmpSE5+cMAUniSE5+cMAFilSE5)))
					cChave := "E5_FILORIG+" + cChave
				ElseIf (cMAEmpSE5+cMAUniSE5+cMAFilSE5) >= (cMAEmpSE8+cMAUniSE8+cMAFilSE8)
					cChave := "E5_FILIAL+" + cChave
				EndIf
			EndIf
		EndIf
		
		cIndex  := CriaTrab(nil,.f.)
		IndRegua("SE5", cIndex, cChave, Nil, U_fr530Check(), STR0008) //"Selecionando Registros..."
		nIndex   := RetIndex("SE5")
		dbSelectArea("SE5")

		SE5->(dbSetOrder(nIndex+1))
		SE5->(dbGoTop())

		dbSelectArea("SA6")
		SA6->(dbSetOrder(1))
		SA6->(msSeek(xFilial(), .F.))

		While !SA6->(Eof()) .And. SA6->A6_FILIAL == xFilial()
			oReport:IncMeter()
			
			//Considera filtro do usuario
			If !Empty(cFilUser).and.!(&cFilUser) .Or. (!Empty(aRetAuto) .And. !(SA6->A6_COD == aRetAuto[1] .And. SA6->A6_AGENCIA == aRetAuto[2] .And. SA6->A6_NUMCON == aRetAuto[3]))
				SA6->(dbSkip())
				Loop
			Endif
			
			cBanco    := SA6->A6_COD
			cAgencia  := SA6->A6_AGENCIA
			cConta    := SA6->A6_NUMCON
			nLimCred  := SA6->A6_LIMCRED
			
			If Len(aRetAuto) > 0
				cBanco    := aRetAuto[1]
				cAgencia  := aRetAuto[2]
				cConta    := aRetAuto[3]
				nLimCred  := aRetAuto[4]
			EndIf

			If cPaisLoc	# "BRA" .Or. FXMultSld()
				nMoedaBco := Max(SA6->A6_MOEDA,1)
			Endif

			dbSelectArea("SE8")
			SE8->(dbSeek(xFilial('SE8')+cBanco+cAgencia+cConta+DtoS(mv_par01),.T.))
			SE8->(dbSkip(-1))

			If SE8->E8_BANCO != cBanco .Or. SE8->E8_AGENCIA != cAgencia .Or. SE8->E8_CONTA != cConta .Or. SE8->E8_FILIAL != xFilial("SE8") .Or. Bof()
				nSaldoIni := 0
			Else
				nSaldoIni := xMoeda(SE8->E8_SALATUA,nMoedaBco,mv_par02,SE8->E8_DTSALAT,nCasas+1)
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Caso considere limite de credito, soma limite ao saldo Inicial ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par03 == 1
				nSaldoIni += xMoeda(nLimCred,nMoedaBco,mv_par02,mv_par01,nCasas+1)
			Endif
			
			//Localizar movimentacao bancaria do banco
			DbSelectArea("SE5")
			cFilialSE5 := xFilial("SE5")
			cChaveSE5  := (cFilialSE5 + DToS(mv_par01) + (cBanco+cAgencia+cConta))
			bCondWhile := {|| !SE5->(Eof()) .And. SE5->E5_DTDISPO == mv_par01 .And. SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA) == (cBanco+cAgencia+cConta)}
			
			If (lAllFil .Or. lSE5Compar)
				cChaveSE5 := (DToS(MV_PAR01) + (cBanco+cAgencia+cConta))
			ElseIf "E5_FILORIG" $ cChave
				cChaveSE5  := (cFilAnt + DToS(mv_par01) + (cBanco+cAgencia+cConta))
				bCondWhile := { || !SE5->(Eof()) .AND. cFilAnt == SE5->E5_FILORIG .And. SE5->E5_DTDISPO == mv_par01 .And. SE5->(E5_BANCO + E5_AGENCIA + E5_CONTA) == cBanco+cAgencia+cConta}
			EndIf
			
			SE5->(DbSeek(cChaveSE5, .T.))
			
			While Eval(bCondWhile)
				If !lSE8Compar .And. lSE5Exclus .And. (ASCan(aSelFil, {|x| AllTrim(x) == AllTrim(SE5->E5_FILIAL)}) == 0)
					SE5->(DbSkip())
					Loop
				ElseIf !lSE5Exclus				
					If ((lAllFil .Or. lSE5Compar) .And. cFilialSE5 != SE5->E5_FILIAL)
						SE5->(DbSkip())
						Loop
					ElseIf !"E5_FILORIG" $ cChave .And. cFilialSE5 != SE5->E5_FILIAL
						Exit
					EndIf				
				EndIf
				
				oReport:IncMeter()				
				
				If !Fr530Skip(cBanco,cAgencia,cConta)
					SE5->(dbSkip())
					Loop
				EndIf

				IF SE5->E5_MOEDA $ "C1/C2/C3/C4/C5/CH" .And. Empty(SE5->E5_NUMCHEQ) .And. !(SE5->E5_TIPODOC $ "TR#TE")
					SE5->(dbSkip())
					Loop
				Endif

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Na transferencia somente considera nestes numerarios 		 ³
				//³ No Fina100 ‚ tratado desta forma.                    		 ³
				//³ As transferencias TR de titulos p/ Desconto/Cau‡Æo (FINA060) ³
				//³ nÆo sofrem mesmo tratamento dos TR bancarias do FINA100      ³
				//³ Aclaracao : Foi incluido o tipo $ para os movimentos en di-- ³
				//³ nheiro em QUALQUER moeda, pois o R$ nao e representativo     ³
				//³ fora do BRASIL. Bruno 07/12/2000 Paraguai                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If SE5->E5_TIPODOC $ "TR/TE" .And. Empty(SE5->E5_NUMERO)
					If !(SE5->E5_MOEDA $ "R$/DO/TB/TC/CH" + cTab14 + IIf(cPaisLoc=="BRA","","/$ "))
						SE5->(dbSkip())
						Loop
					Endif
				Endif

				If SE5->E5_TIPODOC $ "TR/TE" .And. (Substr(SE5->E5_NUMCHEQ,1,1) == "*" .Or. Substr(SE5->E5_DOCUMEN,1,1) == "*")
					SE5->(dbSkip())
					Loop
				Endif

				If SE5->E5_MOEDA == "CH" .And. (IsCaixaLoja(SE5->E5_BANCO) .And. !lCxLoja .And. SE5->E5_TIPODOC $ "TR/TE")// Sangria
					SE5->(dbSkip())
					Loop
				Endif

				If SubStr(SE5->E5_NUMCHEQ,1,1) == "*" .And. SE5->E5_RECPAG == "P"//cheque para juntar (PA)
					SE5->(dbSkip())
					Loop
				Endif

				If !Empty(SE5->E5_MOTBX)
					If !MovBcoBx(SE5->E5_MOTBX)
						SE5->(dbSkip( ))
						Loop
					EndIf
				EndIf

				If mv_par04 == 2
					If nMoedaBco <> nMoeda
						SE5->(DbSkip())
						Loop
					EndIf
				EndIf
				
				dbSelectArea("SE5")

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³VerIfica se foi utilizada taxa contratada para moeda > 1          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nTxMoedBc := SE5->E5_TXMOEDA
				If mv_par02 > 1 .And. !Empty(SE5->E5_VLMOED2)
					nTxMoeda := RecMoeda(SE5->E5_DTDISPO,mv_par02)
					nTxMoeda := If(nTxMoeda=0,1,nTxMoeda)
					nValor := Round(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par02,,nCasas+1,nTxMoedBc,nTxMoeda),nCasas)
				Else
					nValor := Round(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par02,SE5->E5_DTDISPO,nCasas+1,nTxMoedBc),nCasas)
				Endif

				IF !(SE5->E5_RECPAG $ "PR" .And. SE5->E5_TIPODOC == "AP")
					IF SE5->E5_RECPAG == "R"
						nRecBco += nValor
					Else
						nPagBco += nValor
					EndIF
				Else
					If SE5->E5_RECPAG == "P" .And. SE5->E5_TIPODOC == "AP"
						nAplic += xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par02,SE5->E5_DATA,nCasas+1)
					Else
						nAplic -= xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par02,SE5->E5_DATA,nCasas+1)
					Endif
				Endif

				SE5->(dbSkip())
			Enddo

			nDisponiv := Round(nSaldoIni+nRecBco-nPagBco-nAplic, nCasas)

			oSecBco:PrintLine()

			nDisponiv := 0
			nRecBco   := 0
			nPagBco   := 0
			nAplic    := 0

			IF cAcumFil <> cFilAnt
				If lSelecFill
					nTotRec   := 0
					nSaldoIni := 0
				EndIf
				cAcumFil := cFilAnt
			Endif

			dbSelectArea("SA6")
			SA6->(dbSkip())
		EndDo

		dbSelectArea("SA6")
		SA6->(dbSetOrder(1))
		Set Filter To

		dbSelectArea("SE5")
		RetIndex("SE5")
		SE5->(dbSetOrder(1))

		If !Empty(cIndex)
			FErase(cIndex+OrdBagExt())
		EndIf

		SE5->(dbSetOrder(1))
		Set Filter To

		If lAllFil
			Exit
		EndIf

		oReport:IncMeter()
	Next

	oSecBco:Finish()
	RestArea(aSM0Area)
	RestArea(aArea)
	cFilAnt := cFilBak
	aSelFil := {}
	
	//Acerta a database de acordo com a database real do sistema
	dDataBase := dDataAtu
Return

/*/{Protheus.doc} Fr530Skip
Pula registros de acordo com as condicoes (AS 400/CDX/ADS) 
@type function
@version 11   
@author Pilar S. Albaladejo
@since 13/10/1999
@param cBanco, character, banco
@param cAgencia, character, agencia
@param cConta, character, conta
@return logical, returna se pulará o registro
/*/
Static Function Fr530Skip(cBanco As Character, cAgencia As Character, cConta As Character) As Logical
	Local lRet := .T.

	Default cBanco   := ""
	Default cAgencia := ""
	Default cConta   := ""

	IF SE5->E5_TIPODOC $ "DC/JR/MT/CM/D2/J2/M2/V2/C2/CP/TL/BA/I2/EI/VA"  //Valores de Baixas
		lRet := .F.
	ElseIf SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA)!=cBanco+cAgencia+cConta
		lRet := .F.
	ElseIf SE5->E5_SITUACA = "C"		//Cancelado
		lRet := .F.
	EndIF

Return lRet

/*/{Protheus.doc} fr530Check
Função para adicionar filtro com a data de disponibilidade
@type function
@version 11
@author Caio Quiqueto dos Santos
@since 21/12/2016
@return character, returna filtro com a data de disponibilidade
/*/
User Function fr530Check() As Character
	Local cFiltro As Character

	cFiltro := 'DTOS(E5_DTDISPO) == "'+DTOS(mv_par01)+'"'
Return cFiltro

/*/{Protheus.doc} PrimeraFil
Busca a primeira filial da empresa corrente
@type function
@version 11  
@author Caio Quiqueto dos Santos
@since 21/12/2016
@return character, filial da empresa corrente
/*/
Static Function PrimeraFil() As Character
	Local cFilResp	:= ""
	Local cFilEmp 	:= ""
	Local cfilUnit	:= ""
	Local lGestao	:= FWSizeFilial() > 2	// Indica se usa Gestao Corporativa
	Local aRet      := {}
	
	If lGestao
		If FWModeAccess("SE8",1) == "C" //verifica se é compartilhado em nivel empresa
			aRet := FWAllCompany()
			If Len(aRet) > 0
				cFilEmp := aRet[1]
			EndIf
			
			aRet := FWAllUnitBusiness(cFilEmp)
			If Len(aRet) > 0
				cfilUnit := aRet[1]	
			EndIf
		ELse
			cFilEmp  := FWCODEMP()
			If FWModeAccess("SE8",2) == "C" //verifica se é compartilhado em nivel unidade de negocio
				cfilUnit := IF(EMPTY(FWAllUnitBusiness(cFilEmp)),"",FWAllUnitBusiness(cFilEmp)[1])
			Else
				cfilUnit := FWUnitBusiness()
			EndIf
		EndIf 
		
		aRet := FWALLFILIAL(cFilEmp,cfilUnit)
		cFilResp := cFilEmp + cfilUnit + If(Len(aRet) > 0, aRet[1], "")
		cFilResp := Xfilial("SE5",cFilResp)
	Else
		If FWModeAccess("SE8",3)  == "C" .AND. FWModeAccess("SA6",3) == "C"
			cFilResp := ""
		Else
			aRet := FWAllFilial()[1]
			cFilResp := If(Len(aRet) > 0, aRet[1], "")
			cFilResp := xFilial("SE5",cFilResp)
		Endif
	EndIf

Return cFilResp
