/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR620.CH"
#Include "PROTHEUS.CH"

/* GESTAO - inicio */
Static lFWCodFil := .T.
/* GESTAO - fim */
Static  __lOracle := TcGetDb() $ "INFORMIX*ORACLE"

Static __nTamFSE5 := 0
Static __nTamFSE8 := 0
Static __nTamFSA6 := 0

//-------------------------------------------------------------------
/*/{Protheus.doc} FINR620
Relacao da Movimentacao Bancaria
@author Wagner Xavier
@since 05/10/92
@version 1.0
/*/
//-------------------------------------------------------------------

User Function FinR620()

	Local oReport
	Local aAreaR4	:= GetArea()

	Private nOrdena
	Private lPccBxCr	:= FPccBxCr()

/* GESTAO - inicio */
	Private aSelFil	:= {}
/* GESTAO - fim */

	oReport := ReportDef()
	oReport:PrintDialog()

	RestArea(aAreaR4)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Definicao do objeto do relatorio personalizavel e das secoes que serao utilizadas.
@author Marcio Menon
@since 05/10/92
@version 1.0
/*/
//-------------------------------------------------------------------

Static Function ReportDef()

	Local oReport
	Local oSection1
	Local oSection2
	Local oSection3
	Local cReport 	:= "FINR620" 		// Nome do relatorio
	Local cDescri 	:= STR0001 +;		//"Este programa ir  emitir a rela‡„o da movimenta‡„o banc ria"
	STR0002 +;	//"de acordo com os parametros definidos pelo usuario. Poder  ser"
	STR0003		//"impresso em ordem de data disponivel,banco,natureza ou dt.digita‡„o."
	Local cPerg		:= "FIN620"			// Nome do grupo de perguntas
	Local aOrdem	:= {OemToAnsi(STR0004),OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0015),OemToAnsi(STR0034)}  //"Por Dt.Dispo"###"Por Banco"###"Por Natureza"###"Por Dt.Digitacao"###"Por Dt. Movimentacao"



 //Verifica as perguntas selecionadas 								 ³

	pergunte("FIN620",.F.)

//TReport():New(ExpC1 : Nome do relatorio,ExpC2 : Titulo,ExpC3 : Pergunte,ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao,ExpC5 : Descricao)

	oReport := TReport():New(cReport, STR0021, cPerg, {|oReport| ReportPrint(oReport)}, cDescri)

	If mv_par11 == 1			//Analitico
		oReport:SetLandscape()	//Imprime o relatorio no formato paisagem
	Else                 		//Sintetico
		oReport:SetPortrait()	//Imprime o relatorio no formato retrato
	EndIf

/* GESTAO - inicio */
	oReport:SetUseGC(.F.)
/* GESTAO - fim */

	oReport:HideParamPage(.F.)

//Definicao das Secoes                              
//Secao 01                                                               

	oSection1 := TRSection():New(oReport, STR0035, /*"SE5"*/, aOrdem) //"Saldo anterior dos bancos"
	DbSelectArea('SX3')
	DbSetOrder(2)
	DbSeek('E5_BANCO')
	cDescBanco	:=	 X3Titulo("E5_BANCO")
	DbSeek('E5_AGENCIA')
	cDescAge		:=	 X3Titulo("E5_AGENCIA")
	DbSeek('E5_CONTA')
	cDescConta	:=	 X3Titulo("E5_CONTA")
	DbSeek('E5_NATUREZ')
	cDescNat  	:=	 X3Titulo("E5_NATUREZ")
	DbSeek('E5_DOCUMEN')
	cDescDoc		:=	 X3Titulo("E5_DOCUMEN")
	DbSeek('E5_HISTOR')
	cDescHist 	:=	 X3Titulo("E5_HISTOR")
	DbSeek('E5_NUMCHEQ')
	cDescChq 	:=	 X3Titulo("E5_NUMCHEQ")


	TRCell():New(oSection1, "TXTSALDO"     , "" , STR0031 , , 17 ,/*lPixel*/,{ || STR0031 } )	//"Saldo anterior a "
	TRCell():New(oSection1, "DATA"   		, "" , STR0042 , PesqPict("SE5","E5_DATA") , TamSX3("E5_DATA")[1]+2 ,/*lPixel*/,/*CodeBlock*/)	//"DATA"
	TRCell():New(oSection1, "TODOSBCO"     , "" , STR0032 	, , 22 ,/*lPixel*/,{ || STR0032 })		//" (Todos os bancos): "
	TRCell():New(oSection1, "BANCO"   		, "" , cDescBanco , PesqPict("SE5","E5_BANCO")   , TamSX3("E5_BANCO")[1]   	,/*lPixel*/,/*CodeBlock*/)	//"BCO"
	TRCell():New(oSection1, "AGENCIA"		, "" , cDescAGE	, PesqPict("SE5","E5_AGENCIA")	, TamSX3("E5_AGENCIA")[1] ,/*lPixel*/,/*CodeBlock*/)	//"AGENCIA"
	TRCell():New(oSection1, "CONTA"    		, "" , cDescCONTA , PesqPict("SE5","E5_CONTA")  	, TamSX3("E5_CONTA")[1]	   ,/*lPixel*/,/*CodeBlock*/)	//"CONTA"
	TRCell():New(oSection1, "SALDOANTERIOR", "" , STR0041 , PesqPict("SE8","E8_SALANT")	, TamSX3("E8_SALANT")[1]	 ,/*lPixel*/,/*CodeBlock*/)

	oSection1:Cell("TODOSBCO"):Disable()
	oSection1:Cell("SALDOANTERIOR"):SetHeaderAlign("RIGHT")
	oSection1:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao

// Secao 02

	oSection2 := TRSection():New(oReport, STR0036, {"SE5","SA6","SED"}, aOrdem) //"Movimentacao Bancaria"
/* GESTAO - inicio */
	TRCell():New(oSection2, "FILORIG"		, "SE5" , SX3->(RetTitle("E5_FILORIG"))	, PesqPict("SE5","E5_FILORIG")	, TamSX3("E5_FILORIG")[1]+2	,/*lPixel*/,{|| If(Empty(SE5->E5_FILORIG),SE5->E5_FILIAL,SE5->E5_FILORIG)}/*CodeBlock*/)
/* GESTAO - fim */
	TRCell():New(oSection2, "DATA"			, "SE5" , STR0042 	, PesqPict("SE5","E5_DTDISPO")	, TamSX3("E5_DTDISPO")[1]+4	,/*lPixel*/,/*CodeBlock*/)	//"DATA"
	TRCell():New(oSection2, "BANCO"   		, "SE5" , cDescBANCO	, PesqPict("SE5","E5_BANCO")    , TamSX3("E5_BANCO")[1]  	,/*lPixel*/,{|| SE5->E5_BANCO}/*CodeBlock*/)	//"BCO"
	TRCell():New(oSection2, "AGENCIA"		, "SE5" , cDescAGE	, PesqPict("SE5","E5_AGENCIA")	, TamSX3("E5_AGENCIA")[1]	,/*lPixel*/,{|| SE5->E5_AGENCIA}/*CodeBlock*/)	//"AGENCIA"
	TRCell():New(oSection2, "CONTA"    		, "SE5" , cDescCONTA	, PesqPict("SE5","E5_CONTA")  	, TamSX3("E5_CONTA")[1]		,/*lPixel*/,{|| SE5->E5_CONTA}/*CodeBlock*/)	//"CONTA"
	TRCell():New(oSection2, "NATUREZA"		, "SE5" , cDescNAT 	, PesqPict("SE5","E5_NATUREZ")	, TamSX3("E5_NATUREZ")[1],/*lPixel*/,{|| MascNat(SE5->E5_NATUREZ)}/*CodeBlock*/)	//"NATUREZA"
	TRCell():New(oSection2, "DOCUMENTO" 	, "SE5" , cDescDOC 	, PesqPict("SE5","E5_DOCUMEN")  , TamSX3("E5_NUMCHEQ")[1]+1	,/*lPixel*/,{|| SE5->E5_DOCUMEN}/*CodeBlock*/)	//"DOCUMENTO"
	TRCell():New(oSection2, "NUMCHEQ" 		, "SE5" , cDescChq 	, PesqPict("SE5","E5_NUMCHEQ")  , TamSX3("E5_NUMCHEQ")[1]+1	,/*lPixel*/,{|| SE5->E5_NUMCHEQ}/*CodeBlock*/)	//"NUMERO DE CHEQUE"
	TRCell():New(oSection2, "ENTRADA"		, "" 	  , STR0038 	, PesqPict("SE5","E5_VALOR")    , TamSX3("E5_VALOR")[1]+1   ,/*lPixel*/,/*CodeBlock*/,,,,,,.T.,,)	//"ENTRADA"
	TRCell():New(oSection2, "SAIDA"    		, ""    , STR0039 	, PesqPict("SE5","E5_VALOR")    , TamSX3("E5_VALOR")[1]+1  	,/*lPixel*/,/*CodeBlock*/,,,,,,.T.,,)	//"SAIDA"
	TRCell():New(oSection2, "SALDOATUAL"	, "" 	  , STR0040 	, PesqPict("SE8","E8_SALANT")  	, TamSX3("E8_SALANT")[1]+1 	,/*lPixel*/,/*CodeBlock*/,,,,,,.T.,,)	//"SALDO ATUAL"
	TRCell():New(oSection2, "SEPARADOR"		, ""	  , ""		 	, ,2,/*lPixel*/,/*CodeBlock*/)
	TRCell():New(oSection2, "HISTORICO"		, ""	  , cDescHIST 	, PesqPict("SE5","E5_HISTOR")   , 30,/*lPixel*/,{|| SE5->E5_HISTOR}/*CodeBlock*/,,,,,,.T.,,)	//"HISTORICO"

	TrPosition():New(oSection2,'SA6',1,{|| xFilial('SA6')+ SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA })
	TrPosition():New(oSection2,'SED',1,{|| xFilial('SED')+ SE5->E5_NATUREZ })

//Faz o alinhamento do texto da celula
	oSection2:Cell("ENTRADA"   ):SetHeaderAlign("RIGHT")
	oSection2:Cell("SAIDA"     ):SetHeaderAlign("RIGHT")
	oSection2:Cell("SALDOATUAL"):SetHeaderAlign("RIGHT")

	oSection2:SetHeaderPage()	//Define o cabecalho da secao como padrao

// Secao 03 

	oSection3 := TRSection():New(oReport, STR0037, /*a/cAlias*/, aOrdem) //"Totais"

	TRCell():New(oSection3, "TXTTOTAL"     , "" , STR0033 	, , 2 ,/*lPixel*/,{ || STR0033 } )	//"Total : "
	TRCell():New(oSection3, "FILORIG"	   , "" , SX3->(RetTitle("E5_FILORIG"))	, PesqPict("SE5","E5_FILORIG")	, TamSX3("E5_FILORIG")[1]	,/*lPixel*/,/*CodeBlock*/)
	TRCell():New(oSection3, "DATA"   	   , "" , STR0042		, PesqPict("SE5","E5_DATA")  		, TamSX3("E5_DATA")[1]+4 		,/*lPixel*/,/*CodeBlock*/)	//"DATA"
	TRCell():New(oSection3, "BANCO"   		, "" , cDescBanco , PesqPict("SE5","E5_BANCO")    	, TamSX3("E5_BANCO")[1]   	,/*lPixel*/,/*CodeBlock*/)	//"BCO"
	TRCell():New(oSection3, "AGENCIA"		, "" , cDescAGE   , PesqPict("SE5","E5_AGENCIA")	, TamSX3("E5_AGENCIA")[1]	,/*lPixel*/,/*CodeBlock*/)	//"AGENCIA"
	TRCell():New(oSection3, "CONTA"    		, "" , cDescConta , PesqPict("SE5","E5_CONTA")  	, TamSX3("E5_CONTA")[1]		,/*lPixel*/,/*CodeBlock*/)	//"CONTA"
	TRCell():New(oSection3, "NATUREZA"		, "" , cDescNat	, PesqPict("SE5","E5_NATUREZ")	, 25	,/*lPixel*/,/*CodeBlock*/)	//"NATUREZA", 40 ,/*lPixel*/,/*CodeBlock*/)	//"NATUREZA"
	TRCell():New(oSection3, "DOCUMENTO" 	, "" , cDescDOC 	, PesqPict("SE5","E5_DOCUMEN")  ,,/*lPixel*/,{|| SE5->E5_DOCUMEN}/*CodeBlock*/)	//"DOCUMENTO"
	TRCell():New(oSection3, "ENTRADA"		, "" , STR0038 , PesqPict("SE5","E5_VALOR")    	, 13    ,/*lPixel*/,/*CodeBlock*/,,,,,,.T.,,)	//"ENTRADA"
	TRCell():New(oSection3, "SAIDA"    		, "" , STR0039 , PesqPict("SE5","E5_VALOR")    	, 12   	,/*lPixel*/,/*CodeBlock*/,,,,,,.T.,,)	//"SAIDA"
	TRCell():New(oSection3, "SALDOATUAL"	, "" , STR0040 , PesqPict("SE8","E8_SALANT")  	, 13  	,/*lPixel*/,/*CodeBlock*/,,,,,,.T.,,)	//"SALDO ATUAL"
	TRCell():New(oSection3, "SEPARADOR"		, ""	  , ""		 	, ,2,/*lPixel*/,/*CodeBlock*/)
	TRCell():New(oSection3, "HISTORICO"		, ""	  , cDescHIST 	, PesqPict("SE5","E5_HISTOR")   , 22	,/*lPixel*/,{|| REPLICATE("-", TamSX3("E5_HISTOR")[1]	)}/*CodeBlock*/,,,,,,.T.,,)	//"HISTORICO"

//Oculta as colunas

/* GESTAO - inicio */
	oSection3:Cell("FILORIG"):Hide()
/* GESTAO - fim */
	oSection3:Cell("DATA"    ):Hide()
	oSection3:Cell("AGENCIA" ):Hide()
	oSection3:Cell("CONTA"   ):Hide()
	oSection3:Cell("NATUREZA"):Hide()
	oSection3:Cell("SALDOATUAL"):Hide()
	oSection3:Cell("BANCO"):Hide()
	oSection3:Cell("DOCUMENTO"):Hide()


	oSection3:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o objeto oReport definido na funcao ReportDef.
@author Marcio Menon
@since 07/08/2006
@version 1.0
/*/
//-------------------------------------------------------------------

Static Function ReportPrint(oReport)

	Local oSection1 	:= oReport:Section(1)
	Local oSection2 	:= oReport:Section(2)
	Local oSection3 	:= oReport:Section(3)
	Local nOrdem		:= oReport:Section(1):GetOrder()

	Local nTotEnt := 0,nTotSai := 0,nGerEnt := 0,nGerSai := 0,lContinua := .T.
	Local nValor := 0
	Local cDoc := " "
	Local cCheque := " "
	Local lVazio  := .T.
	Local nMoeda
	Local cIndice	:= SE5->(IndexKey())
	Local cHistor
	Local cChaveSe5
	Local nTxMoeda		:=0
	Local nMoedaBco	:=	1
	Local nCasas		:= GetMv("MV_CENT"+(IIF(mv_par09 > 1 , AllTrim(STR(mv_par09,2)),"")))
	Local bWhile   	:= { || IF( mv_par12 == 1, .T., SE5->E5_FILIAL == xFilial("SE5") ) }
	Local nTotSaldo 	:= 0
	Local aSaldo
	Local nGerSaldo 	:= 0
	Local nSaldoAtual := 0
	Local lFirst 		:= .T.
	Local nTxMoedBc	:= 0
	Local cPict 		:= ""
	Local nA				:= 0
	Local cFilterUser := ""
	Local lF620Qry 	:= ExistBlock("F620QRY")
	Local cQueryAdd 	:= ""
	Local nSaldoAnt 	:= 0
	Local lImpSaldo 	:= .F.
	Local nAscan 		:= 0
	Local cAnterior 	:= ""
	Local nBancos 		:= 0
	Local cCond2 		:= ""
	Local cCond3 		:= ""
	Local cMoeda		:= ""
	Local cFilterSA6	:=	oSection2:GetAdvplExp('SA6')
	Local cFilterSE5	:=	oSection2:GetAdvplExp('SE5')
	Local cFilterSED	:=	oSection2:GetAdvplExp('SED')
	Local lCxLoja 		:= GetNewPar("MV_CXLJFIN",.F.)
	Local cAliasQry     := GetNextAlias()
	Local cTitulo 		:= "" 			

	/*
	GESTAO - inicio */
	Local cTmpSE5Fil	:= ""
	Local aTmpFil		:= {}
	Local nTamValor 	:= 19//TamSX3("E5_VALOR")[1]
	Local cTabela14 	:= FR620Tab14()

	If MV_PAR17 == 1
		If Empty(aSelFil)
			AdmSelecFil("FIN620",17,.F.,@aSelFil,"SE5",.F.)
		Endif
	Else
		Aadd(aSelFil,cFilAnt)
	Endif

	/* GESTAO - fim
	*/

	//Caso só exista uma empresa/filial ou o SE5 seja compartilhado
	//nao há necessidade de ser processado por filiais            

		mv_par12 := Iif(SM0->(Reccount()) == 1 .or. Empty(xFilial("SE5")),2,mv_par12)

		nOrdena := nOrdem
		f620CalcF()

	/* GESTAO - inicio */
		bWhile := {|| .T.}
		aSaldo := GetSaldos( nMoeda,mv_par01,mv_par03,mv_par04)
	/* GESTAO - fim */


	//³ Caso a ordem for por banco, deve-se retirar da array os bancos que mesmo com saldo, não tenham sofrido movimentacoes para o periodo especificado na parametrizacao

	If nOrdem == 2
		aSaldoAux := {}
		For nA := 1 to len(aSaldo)

			cQrySld := " SELECT COUNT(*) AS QTD FROM "+RetSQLName("SE5")+" SE5 "
			cQrySld += " WHERE SE5.E5_BANCO = '"+aSaldo[nA,2]+"' "
			cQrySld += " AND SE5.E5_AGENCIA = '"+aSaldo[nA,3]+"' "
			cQrySld += " AND SE5.E5_CONTA = '"  +aSaldo[nA,4]+"' "
			cQrySld += " AND SE5.E5_DATA BETWEEN '"+DTOS(mv_par01)+"' AND '"+DTOS(mv_par02)+"' "

			If __nTamFSA6 == __nTamFSE5
				cQrySld += " AND SE5.E5_FILIAL = '"+aSaldo[nA,9]+"' "
			ElseIf __nTamFSA6 <> __nTamFSE5 .AND. __nTamFSA6 > 0 .AND. __nTamFSE5 > 0
				cQrySld += " AND SUBSTRING(SE5.E5_FILORIG,1," + AllTrim(Str(__nTamFSA6)) + ") = SUBSTRING('"+aSaldo[nA,9]+"',1," + Alltrim(Str(__nTamFSA6)) + ") "
			EndIf

			cQrySld += " AND SE5.D_E_L_E_T_ = ' ' "

		/* GESTAO - inicio */
			If !Empty(aSelFil)
				If MV_PAR17 == 1
					cQrySld += " AND " + "E5_FILIAL " + GetRngFil( aSelFil, "SE5", .T., @cTmpSE5Fil)
				Else
					If MV_PAR12 == 1
						cQrySld += " AND E5_FILIAL BETWEEN '" + mv_par13 + "' AND '" + mv_par14 + "'"
					Else
						cQrySld += " AND " + "E5_FILIAL " + GetRngFil( aSelFil, "SE5", .T., @cTmpSE5Fil)
					Endif
				Endif
				Aadd(aTmpFil,cTmpSE5Fil)
			Else
				If MV_PAR12 == 1
					cQrySld += " AND E5_FILIAL BETWEEN '" + mv_par13 + "' AND '" + mv_par14 + "'"
				Else
					cQuery += " AND E5_FILIAL = '" + xFilial("SE5") + "'"
				EndIf
			EndIf
		/* GESTAO - fim*/			 

			cQrySld += " AND E5_SITUACA <> 'C'"
			cQrySld += " AND E5_NUMCHEQ <> '%*'"
			cQrySld += " AND E5_DTDISPO BETWEEN '" + DTOS(mv_par01)  + "' AND '" + DTOS(mv_par02)       + "'"
			cQrySld += " AND E5_BANCO BETWEEN   '" + mv_par03        + "' AND '" + mv_par04       + "'"
			cQrySld += " AND E5_BANCO <> '   '"
			cQrySld += " AND E5_NATUREZ BETWEEN '" + mv_par05        + "' AND '" + mv_par06       + "'"
			cQrySld += " AND E5_DTDIGIT BETWEEN '" + DTOS(mv_par07)        + "' AND '" + DTOS(mv_par08)       + "'"
			cQrySld += " AND E5_TIPODOC NOT IN ('DC','JR','MT','BA','MT','CM','D2','J2','M2','C2','V2','CX','CP','TL','VA')"

			If cPaisLoc <> "BRA"
				If cPaisLoc == 'ARG'
					cQrySld += " AND ( ((E5_TIPODOC = 'VL' AND E5_TIPO = 'CH' AND E5_RECPAG = 'P' ) OR E5_TIPO <> 'CH' )  OR (E5_TIPODOC = 'VL' AND E5_TIPO = 'CH' AND E5_RECPAG = 'R') OR (E5_TIPODOC = 'ES' AND E5_TIPO ='CH' AND E5_RECPAG ='R'))"
				Else
					cQrySld += " AND ( ((E5_TIPODOC = 'VL' AND E5_TIPO = 'CH' AND E5_RECPAG = 'P' ) OR E5_TIPO <> 'CH' )  OR (E5_TIPODOC = 'VL' AND E5_TIPO = 'CH' AND E5_RECPAG = 'R') )"
				EndIf
			EndIf

			If lF620Qry
				cQueryAdd := ExecBlock("F620QRY", .F., .F.,{"",{aSaldo[nA,2], aSaldo[nA,3], aSaldo[nA,4]}})
				If ValType(cQueryAdd) == "C" .AND. !EMPTY(cQueryAdd)
					cQrySld += " AND ( " + cQueryAdd + ")"
				EndIf
			EndIf

			cQrySld := ChangeQuery(cQrySld)

				If Select("SE5SLD") > 0
				SE5SLD->(dbCloseArea())
			EndIf
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQrySld), 'SE5SLD', .T., .T.)
			If SE5SLD->QTD > 0
				aAdd(aSaldoAux,aSaldo[nA])
			EndIf
		Next
		If mv_par16 == 2 //Não inclui bancos sem movimentos
			aSaldo := aSaldoAux
		EndIf
		nA := 0
		If Select("SE5SLD") > 0
			SE5SLD->(dbCloseArea())
		EndIf
	Endif

	If mv_par09 == 0
		mv_par09 := 1
	Endif
	cMoeda := AllTrim(Str(mv_par09,2,0))


	// Definição dos cabeçalhos
	cTitulo := oReport:Title()
	If mv_par11 == 1
		If nOrdem == 3 .And. mv_par15 == 1 // Ordem de natureza nao sera impresso os saldos
			oSection2:Cell("SALDOATUAL"):Disable()
		Else
			oSection2:Cell("SALDOATUAL"):Enable()
		Endif
	Else
		oSection2:Cell("DATA"):Hide()
		If nOrdem == 1
			oSection2:Cell("DATA"):Setsize(10)
		Else
			oSection2:Cell("DATA"):Setsize(30)
		Endif
		oSection2:Cell("BANCO"):Hide()
		oSection2:Cell("BANCO"):SetTitle("")
		oSection2:Cell("AGENCIA"):Hide()
		oSection2:Cell("AGENCIA"):SetTitle("")
		oSection2:Cell("CONTA"):Hide()
		oSection2:Cell("CONTA"):SetTitle("")
		oSection2:Cell("NATUREZA"):Hide()
		oSection2:Cell("NATUREZA"):SetTitle("")
		oSection2:Cell("DOCUMENTO"):Hide()
		oSection2:Cell("DOCUMENTO"):SetTitle("")
		oSection2:Cell("NUMCHEQ"):Hide()
		oSection2:Cell("NUMCHEQ"):SetTitle("")
		oSection2:Cell("HISTORICO"):Hide()
		oSection2:Cell("HISTORICO"):SetTitle("")
		If mv_par15 == 1
			oSection2:Cell("SALDOATUAL"):Enable()
		Else
			oSection2:Cell("SALDOATUAL"):Disable()
		EndIf
	Endif

	nMoeda	:= mv_par09
	cTitulo  += " " + GetMv("MV_MOEDA"+AllTrim(Str(nMoeda,2))) + STR0028 + If(mv_par11==1, STR0029, STR0030) + STR0028 //" - "###"Analitico"###"Sintetico"###" - "

	dbSelectArea("SE5")

	cQuery := "SELECT R_E_C_N_O_  "
	cQuery += " FROM " + RetSqlName("SE5")

	/* GESTAO - inicio */
	If !Empty(aSelFil)
		If MV_PAR17 == 1
			cQuery += " WHERE " + "E5_FILIAL " + GetRngFil( aSelFil, "SE5", .T., @cTmpSE5Fil)
		Else
			If MV_PAR12 == 1
				cQuery += " WHERE E5_FILIAL BETWEEN '" + mv_par13 + "' AND '" + mv_par14 + "'"
			Else
				cQuery += " WHERE " + "E5_FILIAL " + GetRngFil( aSelFil, "SE5", .T., @cTmpSE5Fil)
			Endif
		Endif
		Aadd(aTmpFil,cTmpSE5Fil)
	Else
		If MV_PAR12 == 1
			cQuery += " WHERE E5_FILIAL BETWEEN '" + mv_par13 + "' AND '" + mv_par14 + "'"
		Else
			cQuery += " WHERE E5_FILIAL = '" + xFilial("SE5") + "'"
		EndIf
	ENDIF
	/* GESTAO - fim */

	cQuery += " AND D_E_L_E_T_ = ' '"

	If nOrdem == 1
		cTitulo += OemToAnsi(STR0004)  //"por Dt.Dispo"

		cCondicao 	:= ".T."
		cCond2 		:= "SE5->E5_DTDISPO"

	/* GESTAO - inicio */
		cOrder		:= "E5_DTDISPO+E5_BANCO+E5_AGENCIA+E5_CONTA+E5_FILIAL"
	/* GESTAO - fim */

	Elseif nOrdem == 2
		cTitulo += OemToAnsi(STR0013)  //"por Banco"

		SE5->(dbSetOrder(3))

		cCondicao 	:= ".T."
		If  __nTamFSE5 > 0
			cCond2 := "SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA+xFilial('SA6',SE5->E5_FILORIG)"
		Else
			cCond2 := "SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA"
		EndIf
		cIndice := SE5->(IndexKey())

	/* GESTAO - inicio */
		cIndice := ALLTRIM(SUBSTR(cIndice,AT("+",cIndice)+1)) + "+E5_FILIAL"
   /* GESTAO - fim */

		cOrder	:= "E5_BANCO+E5_AGENCIA+E5_CONTA+E5_FILORIG+E5_DTDISPO+R_E_C_N_O_+E5_NUMCHEQ+E5_DOCUMEN+E5_PREFIXO+E5_NUMERO"
	Elseif nOrdem == 3
		cTitulo += OemToAnsi(STR0014)  //"por Natureza"

		SE5->(dbSetOrder(4))

		cCondicao 	:= ".T."
		cCond2		:= "SE5->E5_NATUREZ"
		cIndice := SE5->(IndexKey())

	/* GESTAO - inicio */
		cIndice := ALLTRIM(SUBSTR(cIndice,AT("+",cIndice)+1))+"+E5_FILIAL"
   /* GESTAO - fim */

		cOrder := cIndice
	Elseif nOrdem == 4 // Digitacao
		cTitulo += OemToAnsi(STR0015)  //"por Dt.digitação"

		cCond2	  := "SE5->E5_DTDIGIT"

	/* GESTAO - inicio */
		cCondicao 	:= ".T."
		cOrder	 := "DTOS(E5_DTDIGIT)+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_FILIAL"
	/* GESTAO - fim */
	ElseIf nOrdem >= 5 // Data da Movimentacao
		cTitulo += OemToAnsi(STR0034)  //"por Dt. Movimentação"

		cCond2 := "SE5->E5_DATA"

	/* GESTAO - inicio */
		cCondicao 	:= ".T."
		cOrder := "DTOS(E5_DATA)+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_FILIAL"
	/* GESTAO - fim */
	EndIF

	cQuery += " AND E5_SITUACA <> 'C'"
	cQuery += " AND E5_NUMCHEQ <> '%*'"
	cQuery += " AND E5_DTDISPO BETWEEN '" + DTOS(mv_par01)  + "' AND '" + DTOS(mv_par02)       + "'"
	cQuery += " AND E5_BANCO BETWEEN   '" + mv_par03        + "' AND '" + mv_par04       + "'"
	If !Empty(oSection2:GetSqlExp('SE5'))
		cQuery += " AND (" +oSection2:GetSqlExp('SE5')+")"
	Endif
	cQuery += " AND E5_BANCO <> '   '"
	cQuery += " AND E5_NATUREZ BETWEEN '" + mv_par05        + "' AND '" + mv_par06       + "'"
	cQuery += " AND E5_DTDIGIT BETWEEN '" + DTOS(mv_par07)        + "' AND '" + DTOS(mv_par08)       + "'"
	cQuery += " AND E5_TIPODOC NOT IN ('DC','JR','MT','BA','MT','CM','D2','J2','M2','C2','V2','CX','CP','TL','VA')"

	If cPaisLoc <> "BRA"
		If cPaisLoc == 'ARG'
			cQuery += " AND ( ((E5_TIPODOC = 'VL' AND E5_TIPO = 'CH' AND E5_RECPAG = 'P' ) OR E5_TIPO <> 'CH' )  OR (E5_TIPODOC = 'VL' AND E5_TIPO = 'CH' AND E5_RECPAG = 'R') OR (E5_TIPODOC = 'ES' AND E5_TIPO ='CH' AND E5_RECPAG ='R')) "
		Else
			cQuery += " AND ( ((E5_TIPODOC = 'VL' AND E5_TIPO = 'CH' AND E5_RECPAG = 'P' ) OR E5_TIPO <> 'CH' )  OR (E5_TIPODOC = 'VL' AND E5_TIPO = 'CH' AND E5_RECPAG = 'R') ) "
		EndIF
	EndIf

	If lF620Qry
		cQueryAdd := ExecBlock("F620QRY", .F., .F.)
		If ValType(cQueryAdd) == "C" .AND. !EMPTY(cQueryAdd)
			cQuery += " AND ( " + cQueryAdd + ")"
		EndIf
	EndIf
	cQuery += " ORDER BY " + SqlOrder(cOrder)

	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasQry, .T., .T.)


	oReport:SetMeter(Len(aSaldo))
	oReport:SetTitle(cTitulo)	//Altera o Titulo do relatorio

	For nBancos := 1 To IIf(nOrdem == 2, Len(aSaldo), 1)

		SE5->(dbGoto((cAliasQry)->(R_E_C_N_O_)))		

		nTotEnt:=0
		nTotSai:=0
		nTotSaldo := 0
		lImpSaldo := (lFirst .And. nOrdem != 3) // Indica se o saldo anterior deve ser impresso

		If nOrdem == 2
			nSaldoAtual := 0
		Endif
		nSaldoAnt := 0

		// Pesquisa o saldo bancario
		If (Empty(cFilterUser) .And. nOrdem == 2) .Or. nOrdem <> 2
			If mv_par15 == 1 .And. lImpSaldo
				nSaldoAnt := 0
				If nOrdem == 2 // Ordem de banco
					If cPaisLoc	# "BRA" .OR. FXMultSld()
						SA6->(DbSetOrder(1))
						SA6->(DbSeek(aSaldo[nBancos][9]+aSaldo[nBancos][2]+aSaldo[nBancos][3]+aSaldo[nBancos][4]))
						nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
					EndIf
					If (!Empty(aSaldo[nBancos][2]) .And. !Empty(aSaldo[nBancos][3]) .And. !Empty(aSaldo[nBancos][4]))
						cCond3:=aSaldo[nBancos][9]+aSaldo[nBancos][2]+aSaldo[nBancos][3]+aSaldo[nBancos][4]
					Else
						cCond3 := "EOF"
					EndIf
					nAscan := Ascan(aSaldo, {|e| e[9]+e[2]+e[3]+e[4] == cCond3 } )
					If nAscan > 0
						nSaldoAnt := Round(xMoeda(aSaldo[nAscan][6],nMoedaBco,mv_par09,IIf(SE5->(EOF()),dDataBase,SE5->E5_DTDISPO),nCasas+1,nTxMoedBc),nCasas)
					Else
						nSaldoAnt := 0
					Endif
					lFirst := .T.
				Else
					// Na primeira vez, soma todos os saldos de todos os bancos
					If lFirst
						// Soma os saldos de todos os bancos
						For nA := 1 To Len(aSaldo)
							nSaldoAnt += Round(xMoeda(aSaldo[nA][6],MoedaBco(aSaldo[nA][2],aSaldo[nA][3],aSaldo[nA][4]),mv_par09,IIf(SE5->(EOF()),dDataBase,SE5->E5_DTDISPO),nCasas+1,nTxMoedBc),nCasas)
						Next
						lFirst := .F.
					Else
						// Apos a impressao da primeira linha, o saldo Anterior sera igual ao
						// saldo atual, impresso na ultima linha, antes da quebra de data
						If ( cPaisLoc == "BRA" )
							nSaldoAnt := nSaldoAtual
						Else
							nSaldoAnt := Round(xMoeda(nSaldoAtual,nMoedaBco,mv_par09,SE5->E5_DTDISPO,nCasas+1,nTxMoedBc),nCasas)
						Endif
					Endif
				Endif

				cPict := tm(nSaldoAnt,18,nCasas)

				oSection1:Cell("DATA"   ):SetBlock( { || DTOC(mv_par01) } )
				oSection1:Cell("BANCO"  ):Disable()
				oSection1:Cell("AGENCIA"):Disable()
				oSection1:Cell("CONTA"  ):SetSize(11)

				If nOrdem == 2
					oSection1:Cell("TODOSBCO"):Disable()
					oSection1:Cell("BANCO"   ):Enable()
					oSection1:Cell("BANCO"   ):SetBlock( { || aSaldo[nBancos][2] } )
					oSection1:Cell("AGENCIA" ):Enable()
					oSection1:Cell("AGENCIA" ):SetBlock( { || aSaldo[nBancos][3] } )
					oSection1:Cell("CONTA"   ):Enable()
					oSection1:Cell("CONTA"   ):SetSize(20)
					oSection1:Cell("CONTA"   ):SetBlock( { || aSaldo[nBancos][4] } )
				Else
					oSection1:Cell("TODOSBCO"):Enable()
				EndIf
				oSection1:Cell("SALDOANTERIOR"):SetBlock( { || nSaldoAnt } )
				oSection1:Cell("SALDOANTERIOR"):Picture( cPict )
				nSaldoAtual := nSaldoAnt

				oSection1:Init()
				oSection1:PrintLine()
				oSection1:Finish()
			Else
				oSection1:Disable()	 //Desabilita a secao dos saldos
			Endif

		EndIf

		While (cAliasQry)->(!Eof())

			SE5->(dbGoto((cAliasQry)->(R_E_C_N_O_)))

			If Len(aSaldo) > 0
				IF SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA) <> aSaldo[nBancos][2]+aSaldo[nBancos][3]+aSaldo[nBancos][4] .AND. nOrdem == 2
					Exit
				EndIf
			EndIf

			If EVAL(bWhile) .And. &cCondicao .and. lContinua

				oReport:IncMeter()
				IF SE5->E5_MOEDA $ "C1/C2/C3/C4/C5/CH" .and. Empty(SE5->E5_NUMCHEQ) .and. !(SE5->E5_TIPODOC $ "TR#TE")
					(cAliasQry)->(dbSkip())
					Loop
				EndIf

				
				// Na transferencia somente considera nestes numerarios
				// No Fina100 ‚ tratado desta forma
				// As transferencias TR de titulos p/ Desconto/Cau‡Æo (FINA060)
				// não sofrem mesmo tratamento dos TR bancarias do FINA100
				// Aclaracao : Foi incluido o tipo $ para os movimentos en di
				// nheiro em QUALQUER moeda, pois o R$ nao e representativo
				// fora do BRASIL. Bruno 07/12/2000 Paraguai
				
				If SE5->E5_TIPODOC $ "TR/TE" .and. Empty(SE5->E5_NUMERO)
					If !(SE5->E5_MOEDA $ cTabela14)
						(cAliasQry)->(dbSkip())
						Loop
					Endif
				Endif

				If SE5->E5_TIPODOC $ "TR/TE" .and. (Substr(SE5->E5_NUMCHEQ,1,1)=="*" ;
						.or. Substr(SE5->E5_DOCUMEN,1,1) == "*" )
					(cAliasQry)->(dbSkip())
					Loop
				Endif

				If SE5->E5_MOEDA == "CH" .and. (IsCaixaLoja(SE5->E5_BANCO) .And. !lCxLoja .And. SE5->E5_TIPODOC $ "TR/TE")		// Sangria
					(cAliasQry)->(dbSkip())
					Loop
				Endif

				cAnterior := &cCond2
				nTotEnt	 := 0
				nTotSai	 := 0
				nTotSaldo := 0

				If nOrdem == 2
					lImpSaldo 	:= (lFirst .And. nOrdem != 3) // Indica se o saldo anterior deve ser impresso
				EndIf

				If nOrdem == 2 .and. __nTamFSE5 > 0
					cCond3  := "xFilial('SA6',SE5->E5_FILORIG) =='"+aSaldo[nBancos][9]+ "' .And. SE5->E5_BANCO=='"+aSaldo[nBancos][2]+"' .And. SE5->E5_AGENCIA=='"+aSaldo[nBancos][3]+"' .And. SE5->E5_CONTA=='"+aSaldo[nBancos][4]+"'"
					// Nao processa a movimentacao caso o banco nao esteja no array aSaldo
					If aScan(aSaldo, {|e| e[9]+e[2]+e[3]+e[4] == xFilial("SA6",SE5->E5_FILORIG)+SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA) } ) == 0
						(cAliasQry)->(dbSkip())
						Loop
					EndIf
				Else
					cCond3:=".T."
				Endif

				oSection2:Init()

				While (cAliasQry)->(!EOF())

					SE5->(dbGoto((cAliasQry)->(R_E_C_N_O_)))

					If !(&cCond2 = cAnterior .and. EVAL(bWhile) .and. lContinua .And. &cCond3)
						Exit
					Endif

					IF Empty(SE5->E5_BANCO)
						(cAliasQry)->(dbSkip())
						Loop
					Endif

					oReport:IncMeter()

					IF SE5->E5_SITUACA == "C"
						(cAliasQry)->(dbSkip())
						Loop
					EndIF

					IF SE5->E5_MOEDA $ "C1/C2/C3/C4/C5/CH" .and. Empty(SE5->E5_NUMCHEQ) .and. !(SE5->E5_TIPODOC $ "TR#TE")
						(cAliasQry)->(dbSkip())
						Loop
					EndIF

					
					// Na transferencia somente considera nestes numerarios
					// No Fina100 ‚ tratado desta forma.
					// As transferencias TR de titulos p/ Desconto/Caução (FINA060)
					// não sofrem mesmo tratamento dos TR bancarias do FINA100
					// Aclaracao : Foi incluido o tipo $ para os movimentos en di
					// nheiro em QUALQUER moeda, pois o R$ nao e representativo
					// fora do BRASIL. Bruno 07/12/2000 Paraguai
					
					If SE5->E5_TIPODOC $ "TR/TE" .and. Empty(SE5->E5_NUMERO)
						If !(SE5->E5_MOEDA $ cTabela14)
							(cAliasQry)->(dbSkip())
							Loop
						Endif
					Endif

					If SE5->E5_TIPODOC $ "TR/TE" .and. (Substr(SE5->E5_NUMCHEQ,1,1)=="*" ;
							.or. Substr(SE5->E5_DOCUMEN,1,1) == "*" )
						(cAliasQry)->(dbSkip())
						Loop
					Endif

					If SE5->E5_MOEDA == "CH" .and. (IsCaixaLoja(SE5->E5_BANCO) .And. !lCxLoja .And. SE5->E5_TIPODOC $ "TR/TE")		// Sangria
						(cAliasQry)->(dbSkip())
						Loop
					Endif

					
					// Verifica se está FORA dos parametros
					
					IF (SE5->E5_DTDISPO < mv_par01) .or. (SE5->E5_DTDISPO > mv_par02)
						(cAliasQry)->(dbSkip())
						Loop
					Endif

					IF (SE5->E5_BANCO	< mv_par03) .or. (SE5->E5_BANCO  > mv_par04)
						(cAliasQry)->(dbSkip())
						Loop
					EndIf

					IF (SE5->E5_NATUREZ < mv_par05) .or. (SE5->E5_NATUREZ > mv_par06)
						(cAliasQry)->(dbSkip())
						Loop
					EndIF

					IF (SE5->E5_DTDIGIT < mv_par07) .or. (SE5->E5_DTDIGIT > mv_par08)
						(cAliasQry)->(dbSkip())
						Loop
					EndIF

					IF SE5->E5_TIPODOC $ "DCüJRüMTüBAüMTüCMüD2/J2/M2/C2/V2/CX/CP/TL"
						(cAliasQry)->(dbSkip())
						Loop
					Endif

					//  Para o Sigaloja, quando for sangria e nao for R$, nÆo listar nos
					// movimentos bancarios

					If (SE5->E5_TIPODOC == "SG") .And. (!SE5->E5_MOEDA $ "R$"+IIf(cPaisLoc=="BRA","","/$ ")) //Sangria com moeda <> R$
						(cAliasQry)->(dbSkip())
						Loop
					EndIf

					If SubStr(SE5->E5_NUMCHEQ,1,1)=="*"      //cheque para juntar (PA)
						(cAliasQry)->(dbSkip())
						Loop
					Endif

					If !Empty( SE5->E5_MOTBX )
						If !MovBcoBx(SE5->E5_MOTBX)
							(cAliasQry)->(dbSkip())
							Loop
						Endif
					Endif

					If !Empty(cFilterSE5) .And. !SE5->(&(cFilterSE5))
						(cAliasQry)->(dbSkip())
						Loop
					Endif
					If !Empty(cFilterSA6)
						SA6->(DbSetOrder(1))
						IF !SA6->(MsSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
							(cAliasQry)->(dbSkip())
							Loop
						Endif
					Endif
					If !Empty(cFilterSED)
						SED->(DbSetOrder(1))
						SED->(MsSeek(xFilial()+SE5->E5_NATUREZ))
						If !SED->(&(cFilterSED))
							(cAliasQry)->(dbSkip())
							Loop
						Endif
					Endif

					If cPaisLoc	# "BRA" .OR. FXMultSld()
						SA6->(DbSetOrder(1))
						SA6->(MsSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
						nMoedaBco := Max(SA6->A6_MOEDA,1)

						
						//VerIfica se foi utilizada taxa contratada para moeda > 1
						
						nTxMoedBc := SE5->E5_TXMOEDA
						If mv_par09 > 1 .and. !Empty(SE5->E5_VLMOED2)
							nTxMoeda := RecMoeda(SE5->E5_DTDISPO,mv_par09)
							nTxMoeda := if(nTxMoeda=0,1,nTxMoeda)
							nValor 	:= Round(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par09,,nCasas+1,nTxMoedBc,nTxMoeda),nCasas)
						Else
							nValor 	:= Round(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par09,SE5->E5_DTDISPO,nCasas+1,nTxMoedBc),nCasas)
						Endif
					Else
						nValor := xMoeda(SE5->E5_VALOR,1,mv_par09,SE5->E5_DATA)
					Endif
					lVazio := .F.
					// Calcula saldo atual
					// Se for troco(E5_MOEDA=="TC") nao altera o valor do Saldo Atual
					nSaldoAtual := If(SE5->E5_RECPAG = "R",nSaldoAtual+nValor,/*Iif(E5_MOEDA<>"TC",*/nSaldoAtual-nValor/*,nSaldoAtual)*/)

					If mv_par11 == 1	//Analitico

						oSection2:Cell("DATA"):SetBlock( { || If(nOrdem != 5, SE5->E5_DTDISPO, SE5->E5_DATA) } )

						cDoc 	:= SUBSTR(Alltrim(SE5->E5_DOCUMEN),1,15)
						cCheque	:= Alltrim(SE5->E5_NUMCHEQ)

						If Empty(cDoc)
							cDoc := Alltrim(SE5->E5_PREFIXO)+if(!empty(SE5->E5_PREFIXO),"-","")+;
								Alltrim(SE5->E5_NUMERO )+if(!empty(SE5->E5_PARCELA),"-"+SE5->E5_PARCELA,"")
						Endif

						If Substr( cDoc,1,1 ) == "*"
							(cAliasQry)->(dbSkip())
							Loop
						Endif

						oSection2:Cell("DOCUMENTO"):SetBlock( { || cDoc } )
						oSection2:Cell("NUMCHEQ"):SetBlock( { || cCheque } )

						If SE5->E5_RECPAG = "R"
							oSection2:Cell("ENTRADA"):SetBlock  ( { || nValor } )
							oSection2:Cell("ENTRADA"):SetPicture( Tm(nValor,nTamValor,MsDecimais(mv_par09)) )
							oSection2:Cell("SAIDA"  ):SetBlock  ( { ||  } )
						Else
							oSection2:Cell("SAIDA"  ):SetBlock  ( { || nValor } )
							oSection2:Cell("SAIDA"  ):SetPicture( Tm(nValor,nTamValor,MsDecimais(mv_par09)) )
							oSection2:Cell("ENTRADA"):SetBlock  ( { ||  } )
						EndIF

						If nOrdem != 3 .And. mv_par15 == 1
							oSection2:Cell("SALDOATUAL"):SetBlock( { || nSaldoAtual } )
							oSection2:Cell("SALDOATUAL"):SetPicture( Tm(nSaldoAtual,nTamValor,MsDecimais(mv_par09)) )
						Else
							oSection2:Cell("SALDOATUAL"):Disable()
						EndIf
					Else
						oSection2:Disable()
					EndIf

					If SE5->E5_RECPAG = "R"
						nTotEnt += nValor
					Else
						nTotSai += nValor
					EndIf

					nTotSaldo += nSaldoAtual

					If mv_par11 == 1
						If mv_par10 == 1	// Imprime normalmente
							oSection2:Cell("HISTORICO"):SetBlock( { || SE5->E5_HISTOR } )
						Else					// Busca historico do titulo
							If SE5->E5_RECPAG == "R"
								cHistor		:= SE5->E5_HISTOR
								cChaveSe5	:=xFilial("SE1",SE5->E5_FILORIG) + SE5->E5_PREFIXO + ;
									SE5->E5_NUMERO + SE5->E5_PARCELA + ;
									SE5->E5_TIPO
								dbSelectArea("SE1")
								DbSetOrder(1)
								dbSeek( cChaveSe5 )
								oSection2:Cell("HISTORICO"):SetBlock( { || If(Empty(SE1->E1_HIST), cHistor, SE1->E1_HIST) } )
							Else
								cHistor		:= SE5->E5_HISTOR
								cChaveSe5	:= xFilial("SE2",SE5->E5_FILORIG) + SE5->E5_PREFIXO + ;
									SE5->E5_NUMERO + SE5->E5_PARCELA + ;
									SE5->E5_TIPO	 + SE5->E5_CLIFOR
								dbSelectArea("SE2")
								SE2->(DbSetOrder(1))
								If SE5->E5_TIPODOC == "CH"
									dbSelectArea("SEF")
									SEF->(dbSetOrder(1))
									SEF->(dbSeek(xFilial("SEF",SE5->E5_FILORIG)+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA+SE5->E5_NUMCHEQ))
									While !SEF->(Eof()) .And. SEF->(EF_FILIAL+EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM) ==;
											xFilial("SEF",SE5->E5_FILORIG)+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA+SE5->E5_NUMCHEQ
										If Empty(SEF->EF_IMPRESS)
											SEF->(dbSkip())
										Else
											Exit
										EndIf
									EndDo
									SE2->(dbSeek(xFilial("SE2",SE5->E5_FILORIG)+SEF->(EF_PREFIXO+EF_TITULO+EF_PARCELA+EF_TIPO+EF_FORNECE)))
								Else
									SE2->(dbSeek(cChaveSe5))
								EndIf
								oSection2:Cell("HISTORICO"):SetBlock( { || If(Empty(SE2->E2_HIST), cHistor, SE2->E2_HIST) } )
							Endif
						Endif

						oSection2:PrintLine()

					Endif

					(cAliasQry)->(dbSkip())

				Enddo

				oSection2:Finish()

				
				// Impressao dos totais das secoes.

				If ( nTotEnt + nTotSai ) != 0

					IF nOrdem == 1 .Or. nOrdem == 4 .Or. nOrdem == 5		//Data Dispo. # Digitacao # Data Movimentacao
						oSection2:Enable()
						If nOrdem == 1 .AND. oreport:oPage:LPORTRAIT //retrato
							oSection3:Cell("DATA"):SetSize(12)
						Endif

						If nOrdem == 4 .Or. nOrdem == 5
							If mv_par11 == 1 .AND. oreport:oPage:LPORTRAIT//analitico e retrato
								oSection3:Cell("DATA"):SetSize(12)
							ElseIf mv_par11 == 1 .AND. !oreport:oPage:LPORTRAIT//analitico e paisagem
								oSection3:Cell("DATA"):SetSize(11)
							Endif

							If mv_par11 != 1 .AND. oreport:oPage:LPORTRAIT//sintetico e retrato
								oSection3:Cell("DATA"):SetSize(29)
							ElseIf mv_par11 != 1 .AND. !oreport:oPage:LPORTRAIT//sintetico e paisagem
								oSection3:Cell("DATA"):SetSize(31)
							Endif
						Endif
						oSection3:Cell("DATA"):Show()
						oSection3:Cell("DATA"):SetBlock( { || DTOC(cAnterior) } )

						If mv_par11 != 1
							oSection3:Cell("BANCO"  ):Disable()
						Endif

					Elseif nOrdem == 2 	//Banco
						oSection3:Cell("DATA"   ):Hide()
						oSection3:Cell("BANCO"  ):Show()
						oSection3:Cell("AGENCIA"):Show()
						oSection3:Cell("CONTA"  ):Show()
						oSection3:Cell("BANCO"  ):SetBlock( { || Substr(cAnterior,1,3)  } )
						oSection3:Cell("AGENCIA"):SetBlock( { || Substr(cAnterior,4,5)  } )
						oSection3:Cell("CONTA"  ):SetBlock( { || Substr(cAnterior,9,10) } )
						oSection3:Cell("NATUREZA"):Hide()

						If mv_par11 != 1 //Sintetico
							oSection3:Cell("NATUREZA"):SetSize(39)//Retrato e Paisagem
							oSection3:Cell("NATUREZA"):Hide()
						Else
							If 	!oreport:oPage:LPORTRAIT// Paisagem
								oSection3:Cell("NATUREZA"):SetSize(24)
							Else
								oSection3:Cell("NATUREZA"):SetSize(25)//Retrato
							Endif
						Endif

					ElseIf nOrdem == 3	//Natureza
						oSection2:Enable()
						oSection2:Cell("SALDOATUAL"):SetTitle("")
						oSection3:Cell("DATA"   ):Disable()
						oSection3:Cell("BANCO"  ):Disable()
						oSection3:Cell("AGENCIA"):Disable()
						oSection3:Cell("CONTA"  ):Disable()
						dbSelectArea("SED")
						dbSeek(xFilial("SED")+cAnterior)


						If mv_par11 == 1 .AND. oreport:oPage:LPORTRAIT//Analitico e Retrato
							oSection3:Cell("NATUREZA"):SetSize(64)
						ElseIf mv_par11 == 1 .AND. !oreport:oPage:LPORTRAIT//Analitico e Paisagem
							oSection3:Cell("NATUREZA"):SetSize(63)
						Endif

						If mv_par11 != 1 .AND. oreport:oPage:LPORTRAIT//Sintetico e Retrato
							oSection3:Cell("NATUREZA"):SetSize(70)
						ElseIf mv_par11 != 1 .AND. !oreport:oPage:LPORTRAIT//Sintetico e Paisagem
							oSection3:Cell("NATUREZA"):SetSize(64)
						Endif

						oSection3:Cell("NATUREZA"):Show()
						oSection3:Cell("NATUREZA"):SetBlock( { || AllTrim(MascNat(cAnterior)) + " - " + Substr(SED->ED_DESCRIC,1,30) } )
					EndIf

					oSection3:Cell("ENTRADA"):SetBlock  ( { || nTotEnt } )
					oSection3:Cell("ENTRADA"):SetPicture( Tm(nTotEnt,nTamValor,MsDecimais(mv_par09)) )
					oSection3:Cell("SAIDA"  ):SetBlock  ( { || nTotSai } )
					oSection3:Cell("SAIDA"  ):SetPicture( Tm(nTotSai,nTamValor,MsDecimais(mv_par09)) )

					If nOrdem != 3 .And. mv_par15 == 1
						oSection3:Cell("SALDOATUAL"):Show()
						oSection3:Cell("SALDOATUAL"):SetBlock( { || nSaldoAtual } )
						oSection3:Cell("SALDOATUAL"):SetPicture( Tm(nSaldoAtual,nTamValor,MsDecimais(mv_par09)) )
					Else
						oSection3:Cell("SALDOATUAL"):Disable()
					Endif


					oSection3:Init()
					oSection3:PrintLine()
					oSection3:Finish()

					nGerEnt 	 += nTotEnt
					nGerSai 	 += nTotSai
					nGerSaldo += (nSaldoAnt + nTotEnt - nTotSai)
					nSaldoAnt := 0
					nTotSaldo := 0
					nTotEnt   := 0
					nTotSai   := 0

				Endif


				dbSelectArea("SE5")
				If nOrdem == 2
					Exit
				EndIf
			Else
				Exit
			Endif

		EndDo
		If nOrdem == 2 .And. nSaldoAnt > 0
			nGerSaldo += nSaldoAnt
		EndIf

	Next


	// Impressao do total geral.
	If (nGerEnt+nGerSai) != 0
		oSection3:Cell("TXTTOTAL"):SetSize(21)
		If nOrdem == 1
			If mv_par11 == 1 .AND. oreport:oPage:LPORTRAIT//Analitico e Retrato
				oSection3:Cell("TXTTOTAL"):SetSize(14)
			ElseIf mv_par11 == 1 .AND. !oreport:oPage:LPORTRAIT//Analitico e Paisagem
				oSection3:Cell("TXTTOTAL"):SetSize(16)
			Endif

			If mv_par11 != 1 .AND. oreport:oPage:LPORTRAIT//Sintetico e Retrato
				oSection3:Cell("TXTTOTAL"):SetSize(14)
			ElseIf mv_par11 != 1 .AND. !oreport:oPage:LPORTRAIT//Sintetico e Paisagem
				oSection3:Cell("TXTTOTAL"):SetSize(16)
			Endif
		Endif

		If nOrdem == 4 .Or. nOrdem == 5
			If mv_par11 == 1 .AND. oreport:oPage:LPORTRAIT//Analitico e Retrato
				oSection3:Cell("TXTTOTAL"):SetSize(16)
			ElseIf mv_par11 == 1 .AND. !oreport:oPage:LPORTRAIT//Analitico e Paisagem
				oSection3:Cell("TXTTOTAL"):SetSize(15)
			Endif

			If mv_par11 != 1 .AND. oreport:oPage:LPORTRAIT//Sintetico e Retrato
				oSection3:Cell("TXTTOTAL"):SetSize(16)
			ElseIf mv_par11 != 1 .AND. !oreport:oPage:LPORTRAIT//Sintetico e Paisagem
				oSection3:Cell("TXTTOTAL"):SetSize(17)
			Endif
		Endif

		oSection3:Cell("TXTTOTAL"):SetBlock ( { || STR0017 } )	//"Total Geral : "
		oSection3:Cell("DATA"    ):Hide()
		oSection3:Cell("BANCO"   ):Hide()
		oSection3:Cell("AGENCIA" ):Hide()
		oSection3:Cell("CONTA"   ):Hide()
		oSection3:Cell("NATUREZA" ):Hide()
		oSection3:Cell("DOCUMENTO" ):Hide()



		If nOrdem == 2//Banco
			If mv_par11 == 1 .AND. oreport:oPage:LPORTRAIT//Analitico e Retrato
				oSection3:Cell("NATUREZA"):SetSize(11)
			ElseIf mv_par11 == 1 .AND. !oreport:oPage:LPORTRAIT//Analitico e Paisagem
				oSection3:Cell("NATUREZA"):SetSize(10)
			Endif

			If mv_par11 != 1 .AND. oreport:oPage:LPORTRAIT//Sintetico e Retrato
				oSection3:Cell("NATUREZA"):SetSize(23)
			ElseIf mv_par11 != 1 .AND. !oreport:oPage:LPORTRAIT//Sintetico e Paisagem
				oSection3:Cell("NATUREZA"):SetSize(25)
			Endif

		ElseIf nOrdem == 3 //natureza
			If mv_par11 == 1 .AND. oreport:oPage:LPORTRAIT//Analitico e Retrato
				oSection3:Cell("NATUREZA"):SetSize(51)
			ElseIf mv_par11 == 1 .AND. !oreport:oPage:LPORTRAIT//Analitico e Paisagem
				oSection3:Cell("NATUREZA"):SetSize(50)
			Endif

			If mv_par11 != 1 .AND. oreport:oPage:LPORTRAIT//Sintetico e Retrato
				oSection3:Cell("NATUREZA"):SetSize(58)
			ElseIf mv_par11 != 1 .AND. !oreport:oPage:LPORTRAIT//Sintetico e Paisagem
				oSection3:Cell("NATUREZA"):SetSize(52)
			Endif
		Else
			oSection3:Cell("NATUREZA"):SetSize(16)
		EndIf

		oSection3:Cell("NATUREZA"):Hide()
		oSection3:Cell("ENTRADA" ):SetBlock  ( { || nGerEnt } )
		oSection3:Cell("ENTRADA" ):SetPicture( Tm(nGerEnt,nTamValor,MsDecimais(mv_par09)) )
		oSection3:Cell("SAIDA"   ):SetBlock  ( { || nGerSai } )
		oSection3:Cell("SAIDA"   ):SetPicture( Tm(nGerEnt,nTamValor,MsDecimais(mv_par09)) )
		oSection3:Cell("SALDOATUAL"):SetBlock( { || nGerSaldo } )
		oSection3:Cell("SALDOATUAL"):SetPicture( Tm(nGerEnt,nTamValor,MsDecimais(mv_par09)) )
	EndIf

	oSection3:Init()
	oSection3:PrintLine()
	oSection3:Finish()

	If lVazio
		oReport:SkipLine()
		oReport:PrintText("***** " + STR0018 + " *****")	//"Nao existem lancamentos neste periodo"
	EndIf

	/* GESTAO - inicio */
	If !Empty(aTmpFil)
		For nA := 1 To Len(aTmpFil)
			CtbTmpErase(aTmpFil[nA])
		Next
	Endif
	/* GESTAO - fim */

	(cAliasQry)->(DbCloseArea())

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} GetSaldos
Obter os saldos dos bancos do SA6
@author Claudio D. de Souza
@since 30/08/1991
@version 1.0
/*/
//-------------------------------------------------------------------

Static Function GetSaldos( nMoeda, dDataSaldo, cBancoDe, cBancoAte )
	Local aRet     		:= {}
	Local aArea    		:= GetArea()
	Local cTrbFilial	:= ""
	Local cTrbBanco		:= ""
	Local cTrbAgencia	:= ""
	Local cTrbConta		:= ""
	Local cTrbNome 		:= ""
	Local nTrbSaldo		:= 0
	Local cQry			:= ""
	Local cAliasTmp		:= GetNextAlias()
	Local nTamFil       := 0

	nTamFil := Iif(__nTamFSA6 > __nTamFSE8,__nTamFSE8,__nTamFSA6)

	cQry := " SELECT A6_FILIAL,A6_COD,A6_AGENCIA,A6_NUMCON,A6_NREDUZ,A6_FLUXCAI,A6_LIMCRED,A6_MOEDA,ISNULL(SE8_3.SALDO,0) AS SALDO "
	cQry += " FROM " + RetSqlName("SA6") + " SA6 LEFT JOIN "
	cQry += " ( "

	If __nTamFSA6 == __nTamFSE8
		cQry += " 	SELECT (SE8_1.E8_FILIAL) AS FILIAL, SE8_1.E8_BANCO, SE8_1.E8_CONTA, SE8_1.E8_AGENCIA, SUM(ISNULL(SE8_1.E8_SALATUA,0)) AS SALDO "
	ElseIf __nTamFSA6 <> __nTamFSE8 .AND. __nTamFSA6 > 0 .AND. __nTamFSE8 > 0
		cQry += " 	SELECT SUBSTRING(SE8_1.E8_FILIAL,1," + Alltrim(Str(nTamFil)) + ") AS FILIAL, SE8_1.E8_BANCO, SE8_1.E8_CONTA, SE8_1.E8_AGENCIA, SUM(ISNULL(SE8_1.E8_SALATUA,0)) AS SALDO"
	Else
		cQry += " 	SELECT SE8_1.E8_BANCO, SE8_1.E8_CONTA, SE8_1.E8_AGENCIA, SUM(ISNULL(SE8_1.E8_SALATUA,0)) AS SALDO"
	EndIf

	cQry += " 	FROM " + RetSqlName("SE8") + " SE8_1 INNER JOIN  "
	cQry += "   ( "
	cQry += " 		SELECT (E8_FILIAL) AS FILIAL,E8_BANCO, E8_AGENCIA, E8_CONTA, MAX(E8_DTSALAT) AS DATA "
	cQry += " 		FROM " + RetSqlName("SE8") + " SE8 "
	cQry += " 		WHERE E8_DTSALAT < '"+DTOS(dDataSaldo)+"' "
	cQry += " 		   AND D_E_L_E_T_ = ' ' "
	cQry += "          AND E8_BANCO >= '"+cBancoDe+"' AND E8_BANCO <= '"+cBancoAte+"' "
	cQry += " 		GROUP BY E8_FILIAL,E8_BANCO,E8_AGENCIA, E8_CONTA  "
	cQry += " 	) SE8_2  "
	cQry += " 	ON SE8_1.E8_FILIAL = SE8_2.FILIAL AND "
	cQry += " 	   SE8_1.E8_BANCO = SE8_2.E8_BANCO "
	cQry += " 	   AND SE8_1.E8_CONTA = SE8_2.E8_CONTA "
	cQry += " 	   AND SE8_1.E8_AGENCIA = SE8_2.E8_AGENCIA "
	cQry += " 	   AND SE8_1.E8_DTSALAT = SE8_2.DATA "
	cQry += " 	WHERE  D_E_L_E_T_ = ' ' "
	cQry += "      AND SE8_1.E8_BANCO >= '"+cBancoDe+"' AND SE8_1.E8_BANCO <= '"+cBancoAte+"' "

	If __nTamFSA6 == __nTamFSE8
		cQry += " 	GROUP BY SE8_1.E8_FILIAL, SE8_1.E8_BANCO, SE8_1.E8_CONTA, SE8_1.E8_AGENCIA "
	ElseIf __nTamFSA6 <> __nTamFSE8 .AND. __nTamFSA6 > 0 .AND. __nTamFSE8 > 0
		cQry += " 	GROUP BY SUBSTRING(SE8_1.E8_FILIAL,1," + Alltrim(Str(nTamFil)) + "), SE8_1.E8_BANCO, SE8_1.E8_CONTA, SE8_1.E8_AGENCIA "
	Else
		cQry += " 	GROUP BY  SE8_1.E8_BANCO, SE8_1.E8_CONTA, SE8_1.E8_AGENCIA"
	EndIf

	cQry += " )  SE8_3  "
	cQry += " 	ON "

	If __nTamFSA6 == __nTamFSE8
		cQry += "  SA6.A6_FILIAL = SE8_3.FILIAL AND "
	ElseIf __nTamFSA6 <> __nTamFSE8 .AND. __nTamFSA6 > 0 .AND. __nTamFSE8 > 0
		cQry += "  SUBSTRING(SA6.A6_FILIAL,1,"+Alltrim(Str(nTamFil))+") = SUBSTRING(SE8_3.FILIAL,1," + Alltrim(Str(nTamFil)) + ") AND "
	EndIf

	cQry += "    SA6.A6_COD = SE8_3.E8_BANCO  "
	cQry += "    AND SA6.A6_NUMCON = SE8_3.E8_CONTA "
	cQry += "    AND SA6.A6_AGENCIA = SE8_3.E8_AGENCIA "

/* GESTAO - Inicio */
	If __nTamFSE5 > 0 //efetua filtro por filial se a SE5 estiver exclusiva em algum nivel
		If !Empty(aSelFil)
			If MV_PAR17 == 1
				cQry += " WHERE " + "A6_FILIAL " + GetRngFil( aSelFil, "SA6", .T.)
			Else
				If MV_PAR12 == 1
					cQry += " WHERE A6_FILIAL BETWEEN '" + xFilial("SA6",mv_par13) + "' AND '" + xFilial("SA6",mv_par14) + "'"
				Else
					cQry += " WHERE A6_FILIAL " + GetRngFil( aSelFil, "SA6", .T.)
				EndIf
			EndIf
		Else
			If MV_PAR12 == 1
				cQry += " WHERE A6_FILIAL BETWEEN '" + xFilial("SA6",mv_par13) + "' AND '" + xFilial("SA6",mv_par14) + "'"
			Else
				cQry += " WHERE A6_FILIAL = '" + xFilial("SA6") + "'"
			EndIf
		EndIf
		cQry += " AND "
	Else
		cQry += " WHERE "
	EndIf
/* GESTAO - Fim */

	cQry += "    A6_COD >= '"+cBancoDe+"' AND A6_COD <= '"+cBancoAte+"' "
	cQry += "    AND D_E_L_E_T_ = ' ' "
	cQry += " ORDER BY A6_COD, A6_AGENCIA , A6_NUMCON, A6_FILIAL "

	cQry := ChangeQuery(cQry)

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), cAliasTmp, .T., .T.)

	While (cAliasTmp)->(!Eof())
		If (cAliasTmp)->A6_FLUXCAI $ "S " .Or.  nOrdena == 2
			
			//Verifica banco a banco a disponibilidade imediata			

			cTrbFilial := (cAliasTmp)->A6_FILIAL
			cTrbBanco  := (cAliasTmp)->A6_COD
			cTrbAgencia:= (cAliasTmp)->A6_AGENCIA
			cTrbConta  := (cAliasTmp)->A6_NUMCON
			cTrbNome   := (cAliasTmp)->A6_NREDUZ
			nTrbSaldo  := xMoeda((cAliasTmp)->SALDO,1,nMoeda)

			Aadd(aRet,{.F.,cTrbBanco,cTrbAgencia,cTrbConta,cTrbNome,nTrbSaldo,nMoeda, xMoeda((cAliasTmp)->A6_LIMCRED,If(cPaisLoc=="BRA",1,Max((cAliasTmp)->A6_MOEDA,1)),mv_par09),cTrbFilial})

		EndIf
		dbSelectArea(cAliasTmp)
		(cAliasTmp)->(dbSkip())
	EndDo

	(cAliasTmp)->(DBCLOSEAREA())

	RestArea(aArea)

Return aRet

//-------------------------------------------------------------------
/*/{Protheus.doc} F620CalcF
Carregamento das variaveis utilizadas para verificar o compartilhamento das tabelas SE5, SE8 e SA6
@author Igor Fricks
@since 17/05/2019
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function f620CalcF()
	Local nTamFil := FWSizeFilial()
	Local nTamE   := Len(FWSM0Layout(,1))
	Local nTamU   := Len(FWSM0Layout(,2))
	Local nTamF   := Len(FWSM0Layout(,3))

	__nTamFSA6 := fRetTamFil("SA6",nTamFil,nTamE,nTamU,nTamF)
	__nTamFSE8 := fRetTamFil("SE8",nTamFil,nTamE,nTamU,nTamF)
	__nTamFSE5 := fRetTamFil("SE5",nTamFil,nTamE,nTamU,nTamF)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fRetTamFil
Obter tamnho do campo filial da tabela de acordo com seu compartilhamento 
@author Igor Fricks
@since 17/05/2019
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function fRetTamFil(cTabela,nTamFil,nTamE,nTamU,nTamF )
	Local nTam    := nTamFil
	Local cComp_E := FWModeAccess(cTabela,1)
	Local cComp_U := FWModeAccess(cTabela,2)
	Local cComp_F := FWModeAccess(cTabela,3)

	If nTamFil > 2
		If cComp_E=='C'
			nTam -= nTamE
		EndIf

		If cComp_U=='C'
			nTam -= nTamU
		EndIf
	EndIf

	If cComp_F=='C'
		nTam -= nTamF
	EndIf

Return nTam

//-------------------------------------------------------------------
/*/{Protheus.doc} FR620Tab14
Carrega e retorna moedas da tabela 14
@author Gustavo Henrique
@since 05/09/2010
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function FR620Tab14()

	Local cTabela14 := ""

	SX5->(DbSetOrder(1))
	SX5->(MsSeek(xFilial("SX5")+"14"))
	While SX5->(!Eof()) .And. SX5->X5_TABELA == "14"
		cTabela14 += (Alltrim(SX5->X5_CHAVE) + "/")
		SX5->(DbSkip())
	Enddo
	cTabela14 += IIF(cPaisLoc=="BRA","","/$ ")
	If cPaisLoc == "BRA"
		cTabela14 := SubStr( cTabela14, 1, Len(cTabela14) - 1 )
	EndIf

Return cTabela14
