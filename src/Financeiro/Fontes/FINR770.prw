/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR770.CH"
#Include "PROTHEUS.CH"

Static _oFINR7701  As Object
Static _oFINR7702  As Object
Static _oFINR7703  As Object
Static _oFINR7704  As Object
Static __oFJ3NAT As Object

Static __cSGBD		As Character
Static __cCposTit	As Character
Static __cInsNat1	As Character


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Finr770	³ Autor ³ Alessandro B. Freire  ³ Data ³ 04/04/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impress„o do Fluxo de caixa realizado. 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_FinR770()												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Eduardo    ³21/01/98³xxxxxx³ Desconsiderar mov. de ch p/ tit. no se5  ³±±
±±³ Mauricio   ³20/03/98³xxxxxx³ Desmembrar transferencia entrada e sa¡da ³±±
±±³ Mauricio   ³31/07/98³xxxxxx³ Trocar Resumo[9] por aResumo[9]			  ³±±
±±³ Mauricio   ³07/08/98³xxxxxx³ Verificar A6_FLUXCAI           			  ³±±
±±³ Wagner     ³20/08/98³xxxxxx³ Verificar A6_FLUXCAI na leitura do SE5   ³±±
±±³ Andreia    ³13/10/98³xxxxxx³ alteracao no lay-out p/ativar set century³±±
±±³ Mauricio   ³06/11/98³xxxxxx³ Revisao geral do relatorio     			  ³±±
±±³ Andreia    ³09/12/98³xxxxxx³ Verificacao se existe baixa estornada    ³±±
±±³            ³        ³      ³ ( TemBxCanc()).       		     			  ³±±
±±³            ³        ³      ³ Verificacao se o motivo da baixa movimen-³±±
±±³            ³        ³      ³ ta banco ( MovBcoBx())         			  ³±±
±±³ Julio      ³04/03/99³19723A³ Desconsiderar mov. de ch p/ tit. no se5  ³±±
±±³ Julio      ³30.03.99³META  ³ Verif. de Parametros de Tamanho  do Rel. ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR770()
	
	Local oReport
	Local aAreaR4	:= GetArea()
	
	/* GESTAO - inicio */
	//
	Private aResFinal	:= {}
	Private aFlxFinal	:= {}
	Private aSaldoBcos	:= {}
	Private nRegSM0Atu	:= 0
	
	/* GESTAO - fim */
	
		nRegSM0Atu := SM0->(Recno())
		oReport := ReportDef()
		oReport:PrintDialog()
	
	RestArea(aAreaR4)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Marcio Menon		   º Data ³  10/08/06 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas.                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Grupo de perguntas do relatorio                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 												              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
	
	Local oReport
	Local oSection1
	Local oSection2
	Local oSection3
	Local oSection4
	Local cReport 	:= "FINR770" 		// Nome do relatorio
	Local cDescri 	:= STR0001 +;    	//"Este programa tem como objetivo imprimir o fluxo  "
	STR0002			//"de Caixa dos movimentos financeiro já realizados. "
	Local cTitulo 	:= STR0003 			//"Fluxo de Caixa Realizado"
	Local cPerg		:= "FIN770"			// Nome do grupo de perguntas
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas 							³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	pergunte("FIN770",.T.)
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criacao do componente de impressao                                      ³
	//³                                                                        ³
	//³TReport():New                                                           ³
	//³ExpC1 : Nome do relatorio                                               ³
	//³ExpC2 : Titulo                                                          ³
	//³ExpC3 : Pergunte                                                        ³
	//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
	//³ExpC5 : Descricao                                                       ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := TReport():New(cReport, cTitulo, cPerg, {|oReport| ReportPrint(oReport)}, cDescri)
	
	oReport:SetPortrait()	//Imprime o relatorio no formato retrato
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³                                                                        ³
	//³                      Definicao das Secoes                              ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Secao 01                                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	oSection1 := TRSection():New(oReport, STR0009,{""}) //"Saldo Anterior"

	TRCell():New(oSection1, "DATA"			, "" , SubStr(STR0004,004,04) , PesqPict("SE8","E8_DTSALAT")	, 10 /*TamSX3("E8_DTSALAT")[1]*/	,/*lPixel*/,/*CodeBlock*/)	//"DATA"
	TRCell():New(oSection1, "NOMEBANCO"		, "" , "NOMEBANCO" , PesqPict("SA6","A6_NREDUZ")  , TamSX3("A6_NREDUZ")[1]  	,/*lPixel*/,/*CodeBlock*/)
	TRCell():New(oSection1, "BANCO"   		, "" , "BANCO"     , PesqPict("SE8","E8_BANCO")   , TamSX3("E8_BANCO")[1]  	,/*lPixel*/,/*CodeBlock*/)
	TRCell():New(oSection1, "AGENCIA"		, "" , "AGENCIA"   , PesqPict("SE8","E8_AGENCIA")	, TamSX3("E8_AGENCIA")[1]	,/*lPixel*/,/*CodeBlock*/)
	TRCell():New(oSection1, "CONTA"    		, "" , "CONTA"     , PesqPict("SE8","E8_CONTA")  	, TamSX3("E8_CONTA")[1]		,/*lPixel*/,/*CodeBlock*/)
	TRCell():New(oSection1, "DISPONIVEL" 	, "" , SubStr(STR0004,071,10) , PesqPict("SE5","E5_VALOR") , TamSX3("E5_VALOR")[1] ,/*lPixel*/,/*CodeBlock*/)	//"DISPONIVEL"
	
	oSection1:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao
	oSection1:SetTotalInLine(.F.) 	//O totalizador da secao sera impresso em coluna
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Secao 02                                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If (Empty((MV_PAR05)))
		oSection2 := TRSection():New(oSection1, STR0011,{""}) //"Fluxo"
		
		TRCell():New(oSection2, "DATA"   		, "cArqTmp" , SubStr(STR0004,003,04) , PesqPict("SE5","E5_DATA")  , TamSX3("E5_DATA")[1] + 2  ,/*lPixel*/,{ || DtoC(CARQTMP->DATAX) })	//"DATA"
		TRCell():New(oSection2, "RECEBIDOS"   	, "cArqTmp" , SubStr(STR0004,024,09) , PesqPict("SE5","E5_VALOR") , 22 ,/*lPixel*/,{ || CARQTMP->RECEBIDOS },,,"RIGHT")	//"RECEBIDOS"
		TRCell():New(oSection2, "PAGOS"   		, "cArqTmp" , SubStr(STR0004,052,05) , PesqPict("SE5","E5_VALOR") , 22 ,/*lPixel*/,{ || CARQTMP->PAGOS },,,"RIGHT")		//"PAGOS"
		TRCell():New(oSection2, "DISPONIVEL" 	, "cArqTmp" , SubStr(STR0004,071,10) , PesqPict("SE5","E5_VALOR") , 22 ,/*lPixel*/,{ || CARQTMP->DISPONIVEL },,,"RIGHT")	//"DISPONIVEL"
		
		oSection2:SetNoFilter(" ")
		oSection2:SetHeaderPage()	//Define o cabecalho da secao como padrao
		
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Secao 02 - Visão Gerencial                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection2 := TRSection():New(oSection1, "Visão Gerencial",{""})
		
		TRCell():New(oSection2, "DATA-DESCRICAO", "cArqTmp" ,  ,  							 , TamSX3("FJ3_DESCCG")[1] + 20 ,/*lPixel*/,{ || CARQTMP->CODDESC },,,'LEFT',,,,,,.F.)	//"CODIGO E DESCRIÇÃO"
		TRCell():New(oSection2, "RECEBIDOS"   	, "cArqTmp" ,  ,  PesqPict("SE5","E5_VALOR"), 22 ,/*lPixel*/,{ || CARQTMP->RECEBIDOS },,,"RIGHT",,,,,,.F.)	//"RECEBIDOS"
		TRCell():New(oSection2, "PAGOS"   		, "cArqTmp" ,  , PesqPict("SE5","E5_VALOR") , 22 ,/*lPixel*/,{ || CARQTMP->PAGOS },,,"RIGHT",,,,,,.F.)		//"PAGOS"
		TRCell():New(oSection2, "DISPONIVEL" 	, "cArqTmp" ,  , PesqPict("SE5","E5_VALOR") , 22 ,/*lPixel*/,{ || CARQTMP->DISPONIVEL },,,"RIGHT",,,,,,.F.)	//"DISPONIVEL"
		TRCell():New(oSection2, " "			 	, "cArqTmp" ,  , 							 , 22 ,/*lPixel*/,{ || CARQTMP->ORDEM },,,"RIGHT",,,,,,.F.)	//"ORDEM"
		
		oSection2:SetNoFilter(" ")
		oSection2:SetHeaderPage()	//Define o cabecalho da secao como padrao
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Secao 03                                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection3 := TRSection():New(oSection2, STR0014,{""}) //"Resumo Financeiro"
	
	TRCell():New(oSection3, "HISTORICO" , "" , STR0028  , , 30 ,/*lPixel*/,/*CodeBlock*/) //"HISTORICO"
	TRCell():New(oSection3, "RECEBIDO"  , "" , STR0015  , PesqPict("SE5","E5_VALOR") , 18 ,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")	//"RECEBIDO"
	TRCell():New(oSection3, "PAGO"      , "" , STR0016  , PesqPict("SE5","E5_VALOR") , 20 ,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")	//"PAGO"
	oSection3:SetNoFilter(" ")
	oSection3:Cell("HISTORICO"):SetTitle("")
	
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint ºAutor³ Marcio Menon       º Data ³  10/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime o objeto oReport definido na funcao ReportDef.     º±±                                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPO1 - Objeto TReport do relatorio                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)
	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(1):Section(1)
	Local oSection3 := oReport:Section(1):Section(1):Section(1)
	
	Local aBancos	 := {} 					// Guarda os bancos
	Local nSaldoAnt := 0						// Saldo Anterior dos Bancos
	Local cArqTmp	 := ""            	// Arquivo temporario das movimentacoes
	Local nI 		 := 0						// Variavel para FOR NEXT
	Local dDtProc	 := dDataBase - (MV_PAR01) - 1  // Data do saldo anterior
	Local lPrimeiro := .T.					// Verifica se pode ou nao imprimir os saldos
	Local aResumo	 := {}					// Contem os resumos das movimentacoes
	Local nMoedaBco :=	1					//	Moeda do Banco
	Local cSetOfBook
	Local cData
	
	/* GESTAO - inicio */
	Local aSelFil	:= {}
	Local nPos		:= 0
	Local nRegSM0	:= 0
	/* GESTAO - fim */
	
	Private nDecs	    := MsDecimais(mv_par03)
	Private nMoeda     := mv_par03
	Private cIndiceSE5 := ""
	
	
	cSetOfBook :=  mv_par05 // Número da visão gerencial financeira
	
	
	oSection1:Cell("DATA"      ):SetBlock  ( { || aBancos[ni][5] } )		// Data do Saldo
	oSection1:Cell("NOMEBANCO" ):SetBlock  ( { || aBancos[ni][4] } )		// Nome Reduzido
	oSection1:Cell("BANCO"     ):SetBlock  ( { || aBancos[ni][1] } )		// Banco
	oSection1:Cell("AGENCIA"   ):SetBlock  ( { || aBancos[ni][2] } )		// Agencia
	oSection1:Cell("CONTA"     ):SetBlock  ( { || aBancos[ni][3] } )		// Conta
	oSection1:Cell("DISPONIVEL"):SetBlock  ( { || aBancos[ni][6] } )		// Saldo Anterior
	
	oSection3:Cell("HISTORICO"):SetBlock ( { || aResumo[nI][2] } )
	oSection3:Cell("RECEBIDO"):SetBlock  ( { || aResumo[nI][1] } )
	oSection3:Cell("PAGO"    ):SetBlock  ( { || aResumo[nI][1] } )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Totalizador da secao 1.							  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oTot1 := TRFunction():New(oSection1:Cell("DISPONIVEL"),,"SUM",/*oBreak1*/,,,,.F.,.F.,.F.)
	oSection1:SetTotalText(STR0010)		//"TOTAL:"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega o array do Resumo Financeiro com os historicos e tipo.	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nI := 1 to 12
		aAdd(aResumo,{0,"",""})
	Next nI
	
	aResumo[1][2]	:= STR0017				//"Aplicacoes Financeiras........"
	aResumo[1][3]	:= "P"
	aResumo[2][2]	:= STR0018				//"Resgate de Aplicacoes........."
	aResumo[2][3]	:= "R"
	aResumo[3][2]	:= STR0019				//"Emprestimos Recebidos........."
	aResumo[3][3]	:= "R"
	aResumo[4][2]	:= STR0020				//"Pagamento de Emprestimos......"
	aResumo[4][3]	:= "P"
	aResumo[5][2]	:= STR0021				//"Juros Pagos..................."
	aResumo[5][3]	:= "P"
	aResumo[6][2]	:= STR0022				//"Juros Recebidos..............."
	aResumo[6][3]	:= "R"
	aResumo[7][2]	:= STR0023				//"Multas Pagas.................."
	aResumo[7][3]	:= "P"
	aResumo[8][2]	:= STR0024				//"Multas Recebidas.............."
	aResumo[8][3]	:= "R"
	aResumo[9][2]	:= STR0025				//"Descontos Obtidos............."
	aResumo[9][3]	:= "R"
	aResumo[10][2]	:= STR0026 				//"Descontos Concedidos.........."
	aResumo[10][3]	:= "P"
	aResumo[11][2]	:= STR0027				//"Transferencias................"
	aResumo[11][3]	:= "R"
	aResumo[12][2]	:= STR0027				//"Transferencias................"
	aResumo[12][3]	:= "P"
	
	/* GESTAO - inicio */
	If Empty(aResFinal)
		For nI := 1 To Len(aResumo)
			Aadd(aResFinal,{0,aResumo[nI,2],aResumo[nI,3]})
		Next
	Endif
	/* GESTAO - fim */
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura pelo 1.o banco no SA6	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SA6")
	dbSetOrder(1)
	dbSeek(xFilial("SA6"))
	
	If MV_PAR02 == 1		/* executar se se considerar o saldo bancario */
		While SA6->A6_FILIAL == xFilial("SA6") .And. !Eof()
			
			If oReport:Cancel()
				Exit
			EndIF
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se nÆo considerar saldo banc rio, nÆo executar esta rotina.		³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If MV_PAR02 == 2
				Exit
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se n„o considerar banco para o Fluxo de Caixa              	 	³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SA6->A6_FLUXCAI == "N"
				SA6->(dbSkip())
				Loop
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Procura pelo saldo anterior dos bancos no SE8 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SE8")
			dbSetOrder(1)
			If ! dbSeek(xFilial("SE8")+SA6->A6_COD+SA6->A6_AGENCIA+SA6->A6_NUMCON+DtoS( dDtProc ),.T.)
				SE8->(dbSkip(-1))
			EndIf
			
			If SA6->A6_COD 		!= SE8->E8_BANCO		.or. ;
					SA6->A6_AGENCIA	!= SE8->E8_AGENCIA	.or. ;
					SA6->A6_NUMCON 	!= SE8->E8_CONTA		.or. ;
					SE8->E8_DTSALAT	>	dDtProc
				dbSelectArea("SA6")
				dbSkip()
				Loop
			Else
				nMoedaBco := If(cPaisLoc=="BRA",1,Max(SA6->A6_MOEDA,1))
				nSaldoAnt += xMoeda(SE8->E8_SALATUA,nMoedaBco,nMoeda,SE8->E8_DTSALAT,nDecs+1)
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ¿
			//³ Define os parametros do array dos saldos anteriores. aBancos ³³
			//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ³
			//³Banco 	=> [1]																³
			//³Agencia	=> [2]																³
			//³Conta 	=> [3]																³
			//³Nome Red => [4]																³
			//³Data		=> [5]																³
			//³Saldo 	=> [6]																³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			AAdd( aBancos,{SE8->E8_BANCO,SE8->E8_AGENCIA,SE8->E8_CONTA,SA6->A6_NREDUZ,;
				DtoC(SE8->E8_DTSALAT),xMoeda(SE8->E8_SALATUA,nMoedaBco,nMoeda,SE8->E8_DTSALAT,nDecs+1)})
			
			/* GESTAO - inicio */
			/* Acumulo os saldos bancarios para impressao no resumo */
			nPos := Ascan(aSaldoBcos,{|banco| banco[1] == xFilial("SA6",cFilAnt) .And. banco[2] == SE8->E8_DTSALAT .And. banco[4] == SE8->E8_BANCO .And. banco[5] == SE8->E8_AGENCIA .And. banco[6] == SE8->E8_CONTA})
			If nPos == 0
				Aadd(aSaldoBcos,{xFilial("SA6",cFilAnt),SE8->E8_DTSALAT,SA6->A6_NREDUZ,SE8->E8_BANCO,SE8->E8_AGENCIA,SE8->E8_CONTA,0})
				nPos := Len(aSaldoBcos)
				aSaldoBcos[nPos,7] += xMoeda(SE8->E8_SALATUA,nMoedaBco,nMoeda,SE8->E8_DTSALAT,nDecs+1)
			Endif
			/* GESTAO - fim */
			
			dbSelectArea("SA6")
			dbSkip()
		EndDo
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava em um tempor rio os registros necess rios do SE5.				  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If (Empty(MV_PAR05))
		Fr770Tmp(nSaldoAnt, @cArqTmp, @aResumo, oReport)
	Else
		FRVisaoGer(nSaldoAnt, @cArqTmp, oReport)
	EndIf

	dbSelectArea("FJ3")
	dbSetOrder(1)
	dbGoTop()
	
	dbSelectArea("cArqTmp")
	dbSetOrder(1)
	dbGoTop()
		
	oReport:SetMeter(LastRec()+Len(aResumo))
	
	oSection2:Init()
	
	dbGoTop()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ NÆo pode ser While ! Eof() porque dentro do while est  a impressÆo ³
	//³ dos saldos banc rios, que devem ser impressos. 						  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While .T.
		
		If oReport:Cancel()
			Exit
		EndIF
		
		oReport:IncMeter() //Incrmenta regua de progressao
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se considerar saldos banc rios, imprime os saldos anteriores. 			³
		//³ Obs.: somente ser  impresso se for a primeira p gina do relat¢rio.		³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If MV_PAR02 == 1 .And. lPrimeiro .And. !Empty(aBancos)
			
			lPrimeiro := .F.
			
			If Len(aBancos) > 1
				oReport:PrintText(PadC( "** "+STR0008+" **", 77, "-" ))		//"Saldos Anteriores"
				oReport:SkipLine()
			Else
				oReport:PrintText(PadC( "** "+STR0009+" **", 77, "-" ))		//"Saldo Anterior"
				oReport:SkipLine()
			EndIf
			
			oSection1:Init()
			
			oTot1:SetEndSection(.T.)
			
			For nI := 1 to Len(aBancos)
				oSection1:PrintLine()
			Next nI
			
			oSection1:Finish()
			
			oTot1:SetEndSection(.F.)
			
		EndIf
		
		If lPrimeiro
			oReport:PrintText(PadC( "** "+STR0011+" **", 77, "-" ))		//"Fluxo"
			oReport:SkipLine()
			lPrimeiro := .F.
		EndIf
		
		If Eof()
			If Bof()
				oReport:SkipLine()
				oReport:PrintText(PadC( STR0012, 77, " " ))		//"*** NAO HOUVE MOVIMENTACAO NO PERIODO ***"
			EndIf
			Exit
		EndIf

		If !(Empty(MV_PAR05))
			//Seta negrito .F.
			oSection2:Cell("DATA-DESCRICAO"):OFONTBODY:BOLD :=	.F.	
			oSection2:Cell("RECEBIDOS"):OFONTBODY:BOLD :=	.F.
			oSection2:Cell("PAGOS"):OFONTBODY:BOLD :=	.F.
			oSection2:Cell("DISPONIVEL"):OFONTBODY:BOLD :=	.F.
			oSection2:aCell[5]:OFONTBODY:BOLD :=	.F.

			If FJ3->(dbSeek(xFilial("FJ3")+MV_PAR05+AllTrim(CARQTMP->ORDEM))) //Procura pela descricao na FJ3 para impressao em branco
				
				//Se deve imprimir em branco
				If (FJ3->FJ3_IDENT $ "5")
					oSection2:Cell("DATA-DESCRICAO"):Show()
					oSection2:Cell("RECEBIDOS"     ):Hide()
					oSection2:Cell("PAGOS"    	   ):Hide()
					oSection2:Cell("DISPONIVEL"    ):Hide()
					oSection2:aCell[5]:Hide()
				Else
					oSection2:Cell("DATA-DESCRICAO"):Show()
					oSection2:Cell("RECEBIDOS"     ):Show()
					oSection2:Cell("PAGOS"    	   ):Show()
					oSection2:Cell("DISPONIVEL"    ):Show()
					oSection2:aCell[5]:Hide()
				EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Inverte o saldo se assim a entidade estiver configurada ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If FJ3->FJ3_FATSLD == "2" .And. !(FJ3->FJ3_IDENT $ "5" ) //Não for linha sem valor
					RecLock("cArqTmp",.F.)
					CARQTMP->RECEBIDOS  := ((CARQTMP->RECEBIDOS) * -1)
					CARQTMP->PAGOS      := ((CARQTMP->PAGOS) * -1)
					CARQTMP->DISPONIVEL := ((CARQTMP->DISPONIVEL) * -1)
					MsUnLock()
				EndIf
				
			EndIf
			
			//Imprimir Traco
			If FJ3->(dbSeek(xFilial("FJ3")+MV_PAR05+AllTrim(CARQTMP->ORDEM)))
				If FJ3->FJ3_IDENT = '5' .And. Alltrim(FJ3->FJ3_DESCCG) == "-"
					//Desabilita a impressão da linha quando for imprimir o traco
					oReport:PrintText(Replic("-",125))
					oSection2:Cell("DATA-DESCRICAO"):Disable()
					oSection2:Cell("RECEBIDOS"     ):Disable()
					oSection2:Cell("PAGOS"    	   ):Disable()
					oSection2:Cell("DISPONIVEL"    ):Disable()
					oSection2:aCell[5]:Disable()
				ElseIf FJ3->FJ3_IDENT $ "36" 
					//Seta negrito .T.
					oSection2:Cell("DATA-DESCRICAO"):OFONTBODY:BOLD :=	.T.	
					oSection2:Cell("RECEBIDOS"):OFONTBODY:BOLD :=	.T.
					oSection2:Cell("PAGOS"):OFONTBODY:BOLD :=	.T.
					oSection2:Cell("DISPONIVEL"):OFONTBODY:BOLD :=	.T.
					oSection2:aCell[5]:OFONTBODY:BOLD :=	.T.

				Else
					oSection2:Cell("DATA-DESCRICAO"):Enable()
					oSection2:Cell("RECEBIDOS"     ):Enable()
					oSection2:Cell("PAGOS"    	   ):Enable()
					oSection2:Cell("DISPONIVEL"    ):Enable()
					oSection2:aCell[5]:Enable()
				EndIf
			EndIf
		EndIf
		
		oSection2:PrintLine()
		
		/* GESTAO - inicio */
		/* Acumulo os valores para impressao do resumo */
		nPos := Ascan(aFlxFinal,{|fluxo| fluxo[1] == CARQTMP->DATAX})
		If nPos == 0
			Aadd(aFlxFinal,{CARQTMP->DATAX,0,0})		/* data, recebidos, pagos, disponivel */
			nPos := Len(aFlxFinal)
		Endif
		aFlxFinal[nPos,2] += CARQTMP->RECEBIDOS
		aFlxFinal[nPos,3] += CARQTMP->PAGOS
		/* GESTAO - fim */
		
		If !(Empty(MV_PAR05))
			cData := SubStr(CARQTMP->CODDESC,1,10)
		EndIF
		
		dbSkip()
		
		If !(Empty(MV_PAR05))
			If (cData <> SubStr(CARQTMP->CODDESC,1,10))
				oReport:EndPage(.T.)
			EndIf
		EndIf
		
		
	EndDO
	
	oSection2:Finish()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os resumos financeiros. 									 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine()
	oReport:PrintText(PadC( "** "+STR0014+" **", 77, "-" ))		//"Resumo Financeiro"
	
	oSection3:Init()
	
	For nI := 1 to Len(aResumo)
		
		If aResumo[nI][3] == "R"
			oSection3:Cell("RECEBIDO"):Show()
			oSection3:Cell("PAGO"    ):Hide()
		Else
			oSection3:Cell("RECEBIDO"):Hide()
			oSection3:Cell("PAGO"    ):Show()
		EndIf
		
		oSection3:PrintLine()
		oReport:IncMeter()
		
		/* GESTAO - inicio */
		/* acumulo os valores para impressao do resumo financeiro */
		aResFinal[nI,1] += aResumo[nI,1]
		/* GESTAO - fim */
		
	Next nI
	
	oSection3:Finish()
	
	cArqTmp->(dbCloseArea())
	
	//Deleta tabelas temporárias do banco de dados
	If _oFINR7701 <> Nil
		_oFINR7701:Delete()
		_oFINR7701 := Nil
	Endif

	If _oFINR7702 <> Nil
		_oFINR7702:Delete()
		_oFINR7702 := Nil
	Endif	

	dbSelectArea("SE5")
	dbCloseArea()
	ChKFile("SE5")
	dbSetOrder(1)
	
	/* GESTAO - inicio */
	/* Caso utilize gestao de empresas, imprime o resumo da movimentacao */
	If Empty(aSelFil)
		aSelFil := oReport:GetGCList()		/* obtenho as filiais selecionadas */
	Endif
	If !Empty(aSelFil)
		If Len(aSelFil) > 1
			If aSelFil[Len(aSelFil)] == cFilAnt		/* se o relatorio foi gerado para a ultima filial, entao imprimo o resumo */
				nRegSM0 := SM0->(Recno())
				SM0->(DbGoTo(nRegSM0Atu))
				nSaldoAnt := 0
				lPrimeiro := .T.
				Asort(aFlxFinal,,,{|x,y| x[1] < y[1]})		/* ordeno por data */
				oReport:SetTitle(STR0003 + " - " + STR0030)		//"Totalização"
				oReport:EndPage(.F.)
				/*
				Preparo a secao 1 para impressao dos saldos bancarios */
				If Len(aSaldoBcos) > 0
					If lPrimeiro
						oSection1:Cell("DATA"      ):SetBlock({|| aSaldoBcos[ni][2]})		// Data do Saldo
						oSection1:Cell("NOMEBANCO" ):SetBlock({|| aSaldoBcos[ni][3]})		// Nome Reduzido
						oSection1:Cell("BANCO"     ):SetBlock({|| aSaldoBcos[ni][4]})		// Banco
						oSection1:Cell("AGENCIA"   ):SetBlock({|| aSaldoBcos[ni][5]})		// Agencia
						oSection1:Cell("CONTA"     ):SetBlock({|| aSaldoBcos[ni][6]})		// Conta
						oSection1:Cell("DISPONIVEL"):SetBlock({|| aSaldoBcos[ni][7]})		// Saldo Anterior
						lPrimeiro := .F.
						If Len(aSaldoBcos) > 1
							oReport:PrintText(PadC( "** "+STR0008+" **", 77, "-" ))		//"Saldos Anteriores"
							oReport:SkipLine()
						Else
							oReport:PrintText(PadC( "** "+STR0009+" **", 77, "-" ))		//"Saldo Anterior"
							oReport:SkipLine()
						EndIf
						oTot1:SetEndSection(.T.)
						oSection1:Init()
						For nI := 1 To Len(aSaldoBcos)
							oSection1:Printline()
							nSaldoAnt := nSaldoAnt + aSaldoBcos[nI,7]
						Next
						oSection1:Finish()
						oTot1:SetEndSection(.F.)
					Endif
				Endif
				/*
				Preparo a secao 2 para impressao do resumo do fluxo */
				If Len(aFlxFinal) > 0
					oSection2:Cell(1):SetBlock({|| aFlxFinal[nI][1]})
					oSection2:Cell(2):SetBlock({|| aFlxFinal[nI][2]})
					oSection2:Cell(3):SetBlock({|| aFlxFinal[nI][3]})
					oSection2:Cell(4):SetBlock({|| nSaldoAnt + aFlxFinal[nI,2] - aFlxFinal[nI,3]})
					oSection2:Init()
					If lPrimeiro
						oReport:PrintText(PadC( "** "+STR0011+" **", 77, "-" ))		//"Fluxo"
						oReport:SkipLine()
						lPrimeiro := .F.
					EndIf
					For nI := 1 To Len(aFlxFinal)
						oSection2:Printline()
						nSaldoAnt := nSaldoAnt + aFlxFinal[nI,2] - aFlxFinal[nI,3]
					Next
				Else
					oReport:SkipLine()
					oReport:PrintText(PadC( STR0012, 77, " " ))		//"*** NAO HOUVE MOVIMENTACAO NO PERIODO ***"
				Endif
				oSection2:Finish()
				/*
				Preparo a secao 3 para impressao do resumo financeiro */
				oSection3:Cell("HISTORICO"):SetBlock({|| aResFinal[nI][2]})
				oSection3:Cell("RECEBIDO"):SetBlock({|| aResFinal[nI][1]})
				oSection3:Cell("PAGO"):SetBlock({|| aResFinal[nI][1]})
				oSection3:Init()
				oReport:SkipLine()
				oReport:SkipLine()
				oReport:PrintText(PadC( "** "+STR0014+" **", 77, "-" ))		//"Resumo Financeiro"
				For nI := 1 to Len(aResFinal)
					If aResFinal[nI][3] == "R"
						oSection3:Cell("RECEBIDO"):Show()
						oSection3:Cell("PAGO"    ):Hide()
					Else
						oSection3:Cell("RECEBIDO"):Hide()
						oSection3:Cell("PAGO"    ):Show()
					EndIf
					oSection3:PrintLine()
					oReport:IncMeter()
				Next nI
				oSection3:Finish()
				oReport:EndPage(.T.)
				SM0->(DbGoTo(nRegSM0))
			Endif
		Endif
	Endif
	/* GESTAO - fim */
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ Fr770Tmp ³ Autor ³ Marcio Menon			  ³ Data ³ 10/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Filtra os registros do SE5 e Cria um arquivo Tempor rio	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ Fr770Tmp(nSaldoAnt, cArqTmp, aResumo)  						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nSaldoAnt - Saldo Anterior dos bancos							  ³±±
±±³			 ³ cArqTmp	 - Nome do Arquivo tempor rio. Deve ser passado   ³±±
±±³			 ³ 				por parƒmetro. 										  ³±±
±±³			 ³ aResumo	 - Resumo financeiro, por tipo de aplica‡Æo. Deve ³±±
±±³			 ³ 				ser passado por parƒmetro. 						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR770																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fr770Tmp(nSaldoAnt, cArqTmp, aResumo, oReport)
	Local oSection1 := oReport:Section(1)
	Local dDataAnt
	Local nDisponivel := nSaldoAnt
	Local aCampos		:= {	{"DATAX      ","D",8 ,0},;
		{"RECEBIDOS ","N",17,2},;
		{"PAGOS     ","N",17,2},;
		{"DISPONIVEL","N",17,2} }
	Local nPagos		:= 0
	Local nRecebidos	:= 0
	Local nMoedaBco	:=	1
	Local cFilterUser := ""
	Local aStru 		:= SE5->(dbStruct())
	Local nI 			:= 0
	Local cOrder      := ""
	Local lF770Qry 	:= ExistBlock("F770QRY")
	Local cQueryAdd 	:= ""
	Local cFilUser

	//----------------------------
	//Criação da tabela temporaria
	//----------------------------
	If _oFINR7701 <> Nil
		_oFINR7701:Delete()
		_oFINR7701 := Nil
	Endif

	_oFINR7701 := FWTemporaryTable():New( "cArqTmp" )  
	_oFINR7701:SetFields(aCampos) 	

	//Adiciono o índice da tabela temporária
	_oFINR7701:AddIndex("1",{"DATAX"})				

	_oFINR7701:Create()	

	cArqTmp->(dbSetOrder(1)) 

	dbSelectArea("SE5")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria o indice para o SE5 por E5_DTDISPO		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	dDataAnt 	:= dDataBase - MV_PAR01
	
	oReport:NoUserFilter()
	cFilUser := oSection1:GetSqlExp()
	
	// Altera a ordem de	E5_FILIAL,E5_DATA,E5_BANCO,E5_AGENCIA,E5_CONTA,E5_NUMCHEQ para
	// 					E5_FILIAL,E5_DTDISPO,E5_BANCO,E5_AGENCIA,E5_CONTA,E5_NUMCHEQ
	cOrder := StrTran(SqlOrder(IndexKey()), "E5_DATA", "E5_DTDISPO")
	
	cQuery := "SELECT * "
	cQuery += " FROM " + RetSqlName("SE5")
	cQuery += " WHERE E5_FILIAL = '" + xFilial("SE5") + "' AND"
	cQuery += " E5_DTDISPO >= '" + DTOS(dDataAnt) + "' AND "
	cQuery += " E5_MOTBX <> 'FAT' AND "
	cQuery += " D_E_L_E_T_ <> '*'"
	If lF770Qry
		cQueryAdd := ExecBlock("F770QRY", .F., .F.)
		If ValType(cQueryAdd) == "C"
			cQuery += " AND (" + cQueryAdd + ")"
		EndIf
	EndIf
	If !Empty(cFilUser)
		cQuery += " AND " + cFilUser
	EndIf
	
	cQuery += " ORDER BY " + cOrder
	
	cQuery := ChangeQuery(cQuery)
	
	dbSelectAre("SE5")
	dbCloseArea()
	
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE5', .T., .T.)
	
	For nI := 1 to Len(aStru)
		If aStru[nI,2] != 'C'
			TCSetField('SE5', aStru[nI,1], aStru[nI,2],aStru[nI,3],aStru[nI,4])
		Endif
	Next

	dDataAnt 	:= SE5->E5_DTDISPO
	
	cFilterUser := ""
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava as movimenta‡äes do E5 no tempor rio.   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While ! SE5->( eof()) .And. SE5->E5_DTDISPO <= dDataBase .And. xFilial("SE5") == SE5->E5_FILIAL
		
		If xFilial("SE5") <> SE5->E5_FILIAL
			dbSkip()
			Loop
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava os registro no tempor rio.				  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SE5->E5_DTDISPO != dDataAnt
			If ( nRecebidos != 0 .Or. nPagos != 0 )
				nDisponivel += ( nRecebidos - nPagos )
				RecLock( "cArqTmp", .T. )
				REPLACE DATAX			WITH	dDataAnt
				REPLACE RECEBIDOS 	WITH	nRecebidos
				REPLACE PAGOS			WITH	nPagos
				REPLACE DISPONIVEL	WITH	nDisponivel
				msUnlock()
			Endif
			dDataAnt 	:= SE5->E5_DTDISPO
			nRecebidos	:= 0
			nPagos		:= 0
		EndIf
		dbSelectArea("SE5")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava as movimenta‡äes do E5 no tempor rio.   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SA6->(dbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
			If SA6->A6_FLUXCAI == "N"
				SE5->( dbSkip() )
				Loop
			Endif
		Endif
		
		If !Empty(SE5->E5_MOTBX) .And.  !(SE5->E5_TIPODOC$MVPAGANT+"|ES")
			If !MovBcoBx(SE5->E5_MOTBX)
				SE5->( dbSkip() )
				Loop
			EndIf
		Endif
		
		dbSelectArea("SE5")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se existe estorno para esta baixa                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)) .or. SE5->E5_SITUACA =="C"
			If SE5->E5_SITUACA =="C" .Or. TemBxCanc(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ)
				SE5->(dbSkip())
				Loop
			EndIf
		EndIf
		
		If !Empty(SE5->E5_NUMERO)
			If SE5->E5_RECPAG == "R"
				If SE1->( dbSeek(xFilial()+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO) )
					If SE1->E1_FLUXO == "N"
						SE5->( dbSkip() )
						Loop
					Endif
				Endif
			Else
				dbSelectArea("SE2")
				If SE2->( dbSeek(xFilial()+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR) )
					If SE2->E2_FLUXO == "N"
						SE5->( dbSkip() )
						Loop
					Endif
				Endif
			Endif
		Endif
		
		If cPaisLoc	# "BRA" .And. !Empty(SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA))
			SA6->(DbSetOrder(1))
			SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
			nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
		Endif
		
		If mv_par04 == 2
			If nMoedaBco <> nMoeda
				SE5->(DbSkip())
				Loop
			EndIf
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava no array aResumo, os resumos das movi - ³
		//³ menta‡äes financeiras. 							  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Descricao do Array aResumo:														  ³
		//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
		//³  aResumo[n][1]: Valor																  ³
		//³  aResumo[n][2]: Historico															  ³
		//³  aResumo[n][3]: "P" (Pago) ou "R" (Recebido)								  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Do Case
		Case SE5->E5_TIPODOC == "AP" .And. SE5->E5_RECPAG = "P"
			aResumo[1][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
		Case SE5->E5_TIPODOC == "AP" .And. SE5->E5_RECPAG = "R" // Estorno de aplicacoes
			aResumo[1][1] -= xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
		Case SE5->E5_TIPODOC == "RF" .And. SE5->E5_RECPAG = "R"
			aResumo[2][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
		Case SE5->E5_TIPODOC == "RF" .And. SE5->E5_RECPAG = "P" // Estorno de Resgate de Aplicacoes
			aResumo[2][1] -= xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
		Case SE5->E5_TIPODOC == "EP" .And. SE5->E5_RECPAG=="R"
			aResumo[3][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
		Case SE5->E5_TIPODOC == "EP" .And. SE5->E5_RECPAG=="P" // Estorno de Emprestimo
			aResumo[3][1] -= xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
		Case SE5->E5_TIPODOC == "PE" .And. SE5->E5_RECPAG=="P"
			aResumo[4][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
		Case SE5->E5_TIPODOC == "PE" .And. SE5->E5_RECPAG=="R" // Estorno de pagamento de emprestimo
			aResumo[4][1] -= xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
		Case SE5->E5_TIPODOC == "JR" .or. ;
				SE5->E5_TIPODOC == "J2" .or.;
				SE5->E5_TIPODOC == "TL"
			If SE5->E5_RECPAG == "P"
				aResumo[5][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
			ElseIf SE5->E5_RECPAG == "R"
				aResumo[6][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
			EndIf
		Case SE5->E5_TIPODOC == "MT" .or. ;
				SE5->E5_TIPODOC == "M2"
			If SE5->E5_RECPAG == "P"
				aResumo[7][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
			Else
				aResumo[8][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
			EndIf
		Case SE5->E5_TIPODOC == "DC" .or. SE5->E5_TIPODOC == "D2"
			If SE5->E5_RECPAG == "P"
				aResumo[9][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
			Else
				aResumo[10][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
			EndIf
		Case SE5->E5_TIPODOC == "TR"
			If SE5->E5_RECPAG == "P"
				aResumo[12][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
			Else
				aResumo[11][1] += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
			EndIf
		EndCase
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Soma as movimenta‡äes di rias.					  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF (!(SE5->E5_TIPODOC $ "CH/DC/JR/MT/CM/D2/J2/M2/C2/V2/CP/TL/BL/EC/ES"+Iif(cPaisLoc == "BOL","/BA","")) .OR. ;
				(SE5->E5_TIPODOC == "ES" .AND. !EMPTY(SE5->E5_KEY)) ) 	.and. ; //Estorno de PA/RA	OU titulos deletados
			!(Empty(SE5->E5_TIPODOC) .AND. Empty(SE5->E5_MOEDA)).Or.; // Totalizador Bx Cnab
			(Empty(SE5->E5_TIPODOC) .AND. !Empty(SE5->E5_MOEDA))
			If SE5->E5_RECPAG == "R"
				nRecebidos  += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
			Else
				nPagos      += xMoeda(SE5->E5_VALOR,nMoedaBco,nMoeda,SE5->E5_DATA,nDecs+1)
			EndIf
		EndIf
		dbSelectArea("SE5")
		SE5->( dbSkip() )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava os registro no tempor rio.				  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SE5->E5_DTDISPO != dDataAnt
			If ( nRecebidos != 0 .Or. nPagos != 0 )
				nDisponivel += ( nRecebidos - nPagos )
				RecLock( "cArqTmp", .T. )
				REPLACE DATAX			WITH	dDataAnt
				REPLACE RECEBIDOS 	WITH	nRecebidos
				REPLACE PAGOS			WITH	nPagos
				REPLACE DISPONIVEL	WITH	nDisponivel
				msUnlock()
			Endif
			dDataAnt 	:= SE5->E5_DTDISPO
			nRecebidos	:= 0
			nPagos		:= 0
		EndIf
		dbSelectArea("SE5")
	EndDo
	If (npagos <> 0 .or. nRecebidos <> 0 ).and. cArqTmp->(lastrec()) == 0
		
		nDisponivel += ( nRecebidos - nPagos )
		RecLock( "cArqTmp", .T. )
		cArqTmp->DATAX			:=	dDataAnt
		cArqTmp->RECEBIDOS 	:=	nRecebidos
		cArqTmp->PAGOS			:=	nPagos
		cArqTmp->DISPONIVEL	:=	nDisponivel
		msUnlock()
		nRecebidos	:= 0
		nPagos		:= 0
	Endif
		
Return NIL

/*/{Protheus.doc} FRVisaoGer
Funcao que montara o arquivo temporario para impressao do relatorio com visao 
gerencial financeira  

@type 	Function
@since	18/08/2011

@param	nSaldoAnt, Numeric, saldo anterior
@param	cArqTmp, Numeric, arquivo temporario
@param	oReport, object, objeto de impressão

@return Nil
/*/
Static Function FRVisaoGer(nSaldoAnt, cArqTmp, oReport)

	Local oSection1 As Object 

	Local dDataAnt  As Date
	Local dBaixa 	As Date

	Local aStru 	As Array		
	Local aBaixa 	As Array	

	Local cTable     As Character
	Local cColuna    As Character
	Local cAliasMov  As Character
	Local cIdenti	 As Character
	
	oSection1 := oReport:Section(1)

	aStru 		:= {}
	aBaixa		:= {}
	dDataAnt  	:= dDataBase - mv_par01 	
	dBaixa		:= CTOD("  /  /  ")
	cTable      := ""
	cIdenti 	:= ""
	cAliasMov	:= ""	
	cColuna    	:= ""	

	AADD(aStru,{"FILIAL"   ,"C",TAMSX3("E5_FILIAL")[1],0})
	AADD(aStru,{"NATUREZA" ,"C",TAMSX3("E5_NATUREZ")[1],0})
	AADD(aStru,{"RECPAG"   ,"C",1,0})
	AADD(aStru,{"DTBAIXA" ,"D",8,0})
	AADD(aStru,{"MOVRECNO" ,"N",8,0})
	
	If __cSGBD == Nil
		__cSGBD := AllTrim(Upper(TcGetDb()))
	EndIf

	CriaTmpImp()
	dbSelectARea("cArqTmp")
	dbSetOrder(1)

	CriaTmpVis(@cColuna)
	
	CriaTMPMov(AClone(aStru))

	InsTmpMov(dDataAnt, oReport, oSection1 )		

	FwFreeArray(aStru)
	
	cTable 		:= _oFINR7702:GetRealName()
	cAliasMov	:= _oFINR7704:GetAlias()

	If FJ3->(dbSeek(xFilial("FJ3") + mv_par05))
		While (FJ3->(!EOF()) .And. FJ3->FJ3_CODPLA == mv_par05 )						
			If (!Empty(FJ3->FJ3_SEDINI) .And. !Empty(FJ3->FJ3_SEDFIM))
				cIdenti := FJ3->FJ3_IDENT
				
				InsertNat( FJ3->FJ3_SEDINI, FJ3->FJ3_SEDFIM )
				(cAliasMov)->(DbGoTop())
				(cAliasMov)->(DbGoTo(Recno()))

				While (cAliasMov)->(!(EoF()))
					SE5->(dbGoto((cAliasMov)->MOVRECNO))	

					dBaixa 	 	:= SE5->E5_DATA		

					If ASCAN(aBaixa,dBaixa ) == 0 
						AADD(aBaixa,dBaixa)
						InsTmpvis(dBaixa, cColuna, cTable)
					EndIf	

					TRB1->(dbSetOrder(2))
					If TRB1->(dbSeek(mv_par05 + FJ3->FJ3_CONTAG + DTOS(dBaixa)))						
						RecLock("TRB1",.F.)
						If SE5->E5_RECPAG == "R"
							If cIdenti == "1"
								TRB1->FJ3_REC += SE5->E5_VALOR
							Else
								TRB1->FJ3_REC -= SE5->E5_VALOR
							EndIf
						Else
							If cIdenti == "1"	
								TRB1->FJ3_PAGO += SE5->E5_VALOR
							Else
								TRB1->FJ3_PAGO -= SE5->E5_VALOR
							EndIf
						EndIf												
						TRB1->(MsUnLock())															
					EndIf			
					(cAliasMov)->(DbSkip())
				End									
				ClrTmpNat()
			EndIf			
			FJ3->(DbSkip())			
		End		
		
		aBaixa := {}
		FwFreeArray(aBaixa)

		//Atualiza sinteticas
		AtuSintet()	

		//Grava arquivo para impressão
		GrvArqImp(cArqTmp)
		
		//Atuliza disponivel 
		AtuDispon(nSaldoAnt,cArqTmp)	
		
		cArqTmp->(dbSetOrder(1))

		TRB1->(dbCloseArea())

		If _oFINR7702 <> Nil
			_oFINR7702:Delete()
			_oFINR7702 := Nil
		Endif
	EndIf

	If _oFINR7703 <> Nil
		_oFINR7703:Delete()
		_oFINR7703 := Nil
	Endif
	
	If _oFINR7704 <> Nil
		_oFINR7704:Delete()
		_oFINR7704 := Nil
	Endif		

Return


/*/{Protheus.doc}CNICalcFor
Calcula saldo com base na formula digitada

@type 	Function
@since	18/08/2011

@return Nil
/*/
User Function CNICalcFor ()
	Local cSuperior
	Local cIdent
	Local nCont
	Local nFator
	
	cSuperior := TRB1->FJ3_CTASUP // Conta Superior
	cIdenti	  := TRB1->FJ3_IDENT // Somar ou Subtrair
	nCont     := TRB1->(Recno())
	
	//Procurar nas superiores e somar ou subtrair
	Do While (!Empty(cSuperior))
		
		//Ralizar calculo com a formula digitada pelo usuario
		If (cSuperior == TRB1->FJ3_CONTAG)
			If (Left(TRB1->FJ3_FORMUL, 7) == "ROTINA=")
				nFator := &(Subs(TRB1->FJ3_FORMUL, 8))
				
				RecLock("TRB1",.F.)
				TRB1->FJ3_DISP *= nFator
				MsUnLock()
				
			ElseIf Left(TRB1->FJ3_FORMUL, 6) == "FATOR="
				nFator := &(Subs(TRB1->FJ3_FORMUL, 7))
				
				RecLock("TRB1",.F.)
				TRB1->FJ3_DISP *= nFator
				MsUnLock()
				
			Elseif Left(TRB1->FJ3_FORMUL,6 ) == "SALDO="
				nFator := &(Subs(TRB1->FJ3_FORMUL, 7))
				
				RecLock("TRB1",.F.)
				TRB1->FJ3_DISP := nFator
				MsUnLock()
				
			EndIf
		EndIf
		
		cSuperior := TRB1->FJ3_CTASUP
		TRB1->(dbSkip(-1))
	EndDo
	
	TRB1->(dbGoto(nCont))// Posiciona no ultimo registro
	
Return


/*/{Protheus.doc} CriaTMPImp
Cria as tabelas temporárias para Impressão

@type 	Function
@author Simone Mie Sato Kakinoana
@since	06/12/2022

@return Nil
/*/
Static Function CriaTMPImp()

	Local aCampos		As Array
	
	aCampos := {{"CONTAG","C",TamSX3("FJ3_CONTAG")[1] ,0},;
	{"CODDESC","C",60 ,0},;
	{"CTASUP","C",TamSX3("FJ3_CTASUP")[1] ,0},;
	{"ClASSE","C",1 ,0},;
	{"RECEBIDOS","N",17,2},;
	{"PAGOS","N",17,2},;
	{"DISPONIVEL","N",17,2},;
	{"DATAX","D",8 ,0},;
	{"DATAAN","D",8,2},;
	{"ORDEM","C",17,0}}

	_oFINR7701 := FWTemporaryTable():New( "cArqTmp" )
	_oFINR7701:SetFields(aCampos)
	_oFINR7701:AddIndex("1", {"DATAAN","ORDEM"})
	_oFINR7701:AddIndex("2", {"DATAAN","CONTAG"})

	_oFINR7701:Create()

Return Nil

/*/{Protheus.doc} CriaTmpVis
Cria a tabela temporária da Visão

@type 	Function
@author Simone Mie Sato Kakinoana
@since	06/12/2022

@param	cColuna, Character, string com as colunas 

@return Nil
/*/
Static Function CriaTMPVis(cColuna aS character)

	Local nTamFil    As Numeric
	Local nTamCodPla As Numeric
	Local nTamOrd    As Numeric
	Local nTamContag As Numeric
	Local nTamCtaSup As Numeric
	Local nTamDscCg  As Numeric
	Local nTamDetHcg As Numeric
	Local nTamNorm   As Numeric
	Local nTamCol    As Numeric
	Local nTamClas   As Numeric
	Local nTamIdent  As Numeric
	Local nTamNome   As Numeric
	Local nTamLin    As Numeric
	Local nTamSedIn  As Numeric
	Local nTamSedFm  As Numeric
	Local nTamForm   As Numeric
	Local nTamTvsIs  As Numeric
	Local nTamVisEnt As Numeric
	Local nTamSldEnt As Numeric
	Local nTamFatSld As Numeric
	Local nJ 		 As Numeric
	Local aEstruct	 As Array	

	Default cColuna := ""		
	
	nTamFil    := TamSX3("FJ3_FILIAL")[1]
	nTamCodPla := TamSX3("FJ3_CODPLA")[1]
	nTamOrd    := TamSX3("FJ3_ORDEM")[1]
	nTamContag := TamSX3("FJ3_CONTAG")[1]
	nTamCtaSup := TamSX3("FJ3_CTASUP")[1]
	nTamDscCg  := TamSX3("FJ3_DESCCG")[1]
	nTamDetHcg := TamSX3("FJ3_DETHCG")[1]
	nTamNorm   := TamSX3("FJ3_NORMAL")[1]
	nTamCol    := TamSX3("FJ3_COLUNA")[1]
	nTamClas   := TamSX3("FJ3_CLASSE")[1]
	nTamIdent  := TamSX3("FJ3_IDENT")[1]
	nTamNome   := TamSX3("FJ3_NOME")[1]
	nTamLin    := TamSX3("FJ3_LINHA")[1]
	nTamSedIn  := TamSX3("FJ3_SEDINI")[1]
	nTamSedFm  := TamSX3("FJ3_SEDFIM")[1]
	nTamForm   := TamSX3("FJ3_FORMUL")[1]
	nTamTvsIs  := TamSX3("FJ3_TOTVIS")[1]
	nTamVisEnt := TamSX3("FJ3_VISENT")[1]
	nTamSldEnt := TamSX3("FJ3_SLDENT")[1]
	nTamFatSld := TamSX3("FJ3_FATSLD")[1]

	aEstruct	:= {}
	
	//Define as colunas e suas propriedades para criar a tabela temporaria TRB4
	AADD(aEstruct,{"FJ3_REC"   ,"N",17,2})
	AADD(aEstruct,{"FJ3_PAGO"  ,"N",17,2})
	AADD(aEstruct,{"FJ3_DISP"  ,"N",17,2})
	AADD(aEstruct,{"FJ3_FILIAL","C",nTamFil,0})
	AADD(aEstruct,{"FJ3_CODPLA","C",nTamCodPla,0})
	AADD(aEstruct,{"FJ3_ORDEM" ,"C",nTamOrd,0})
	AADD(aEstruct,{"FJ3_CONTAG","C",nTamContag,0})
	AADD(aEstruct,{"FJ3_CTASUP","C",nTamCtaSup,0})
	AADD(aEstruct,{"FJ3_DESCCG","C",nTamDscCg,0})
	AADD(aEstruct,{"FJ3_DETHCG","C",nTamDetHcg,0})
	AADD(aEstruct,{"FJ3_NORMAL","C",nTamNorm,0})
	AADD(aEstruct,{"FJ3_COLUNA","N",nTamCol,0})
	AADD(aEstruct,{"FJ3_CLASSE","C",nTamClas,0})
	AADD(aEstruct,{"FJ3_IDENT" ,"C",nTamIdent,0})
	AADD(aEstruct,{"FJ3_NOME"  ,"C",nTamNome,0})
	AADD(aEstruct,{"FJ3_LINHA" ,"C",nTamLin,0})
	AADD(aEstruct,{"FJ3_SEDINI","C",nTamSedIn,0})
	AADD(aEstruct,{"FJ3_SEDFIM","C",nTamSedFm,0})
	AADD(aEstruct,{"FJ3_FORMUL","C",nTamForm,0})
	AADD(aEstruct,{"FJ3_TOTVIS","C",nTamTvsIs,0})
	AADD(aEstruct,{"FJ3_VISENT","C",nTamVisEnt,0})
	AADD(aEstruct,{"FJ3_SLDENT","C",nTamSldEnt,0})
	AADD(aEstruct,{"FJ3_FATSLD","C",nTamFatSld,0})
	AADD(aEstruct,{"FJ3_DATA"  ,"D",8,0})	

	//Armazena colunas para utilizar no insert de dados na tabela temporaria TRB1
	for nJ := 1 to Len( aEstruct )
		If nJ  > 1 
			cColuna += "," + aEstruct[nJ][1]
		Else
			cColuna += aEstruct[nJ][1]
		EndIf
	next nJ
	
	_oFINR7702 := FWTemporaryTable():New( "TRB1" )  
	_oFINR7702:SetFields(aEstruct) 	
	
	_oFINR7702:AddIndex("1",{"FJ3_CODPLA","FJ3_ORDEM"})		
	_oFINR7702:AddIndex("2",{"FJ3_CODPLA","FJ3_CONTAG","FJ3_DATA"})
	_oFINR7702:AddIndex("3",{"FJ3_CODPLA","FJ3_DATA","FJ3_CONTAG"})		
	
	_oFINR7702:Create()

Return Nil

/*/{Protheus.doc} CriaTMPMov
Cria as tabelas temporárias para movimentos

@type 	Function
@author Simone Mie Sato Kakinoana
@since	06/12/2022
@param 	aStru, array, campos a serem criados na tabela temporária

/*/
Static Function CriaTMPMov(aStru As Array)

	DEFAULT aStru := {}
	
	_oFINR7703 := FwTemporaryTable():New()	
	_oFINR7704 := FwTemporaryTable():New()	
	_oFINR7703:SetFields(aStru)	
	_oFINR7704:SetFields(aStru)	

	_oFINR7703:AddIndex("1", {"NATUREZA"})			
	_oFINR7704:AddIndex("1", {"NATUREZA"})			
	
	_oFINR7703:Create()
	_oFINR7704:Create()

Return Nil

/*/{Protheus.doc} InsTmpMov
Insere dados na tabela temporária

@type 	Function
@author Simone Mie Sato Kakinoana
@since	07/12/2022

@param	dDataAnt, date, Data final a ser considerada
@param	oReport, objeto, Objeto Report
@param	oSection1, objeto, Objeto de sessão
@return	Nil
/*/
Static Function InsTmpMov( dDataAnt As Date, oReport As Object, oSection1 As Object )

	Local cMovTMP 		As Character
	Local cInsertTit 	As Character	
	Local cQuery		As Character	
	Local cQueryAdd		As Character
	Local cOrder		As Character
	Local lF770Qry 		As Logical
		
	Default dDataAnt  := dDataBase
	Default oReport	  := Nil
	Default oSection1 := Nil
	
	cMovTMP 	:= _oFINR7703:GetRealName()	
	cInsertTit	:= ""	
	cQuery		:= ""
	cQueryAdd	:= ""	
	cOrder 		:= StrTran(SqlOrder(IndexKey()), "E5_DATA", "E5_DTDISPO")
	
	lF770Qry 	:= ExistBlock("F770QRY")

	__cCposTit	:= " FILIAL, NATUREZA, RECPAG, DTBAIXA "
	cInsertTit 	:= " INSERT "

	If "ORACLE" $ __cSGBD
		cInsertTit += " /*+ APPEND */ "
	EndIf

	cInsertTit += " INTO " + cMovTMP  + " (" + __cCposTit  + ", MOVRECNO) "

	oReport:NoUserFilter()
	cFilUser := oSection1:GetSqlExp()		

	cQuery := " SELECT E5_FILIAL FILIAL, E5_NATUREZ NATUREZA, 'R' RECPAG, SE5.E5_DATA DTBAIXA, SE5.R_E_C_N_O_ MOVRECNO "
	cQuery += " FROM " + RetSQLName("SE5") + " SE5 "
	cQuery += " INNER JOIN " + RetSQLName("SA6") + " SA6  ON SA6.A6_FILIAL ='"+ xfilial("SA6")+ "' AND SA6.A6_COD = SE5.E5_BANCO AND SA6.A6_AGENCIA = SE5.E5_AGENCIA AND SA6.A6_NUMCON = SE5.E5_CONTA  AND SA6.A6_FLUXCAI <> 'N' AND SA6.D_E_L_E_T_ = ' '"
	cQuery += " LEFT JOIN " + RetSQLName("SE1") + " SE1  ON SE1.E1_FILIAL = '"+ xFilial("SE1")+"' AND "
	cQuery += " SE1.E1_PREFIXO = SE5.E5_PREFIXO AND SE1.E1_NUM = SE5.E5_NUMERO AND SE1.E1_PARCELA = SE5.E5_PARCELA AND SE1.E1_TIPO = SE5.E5_TIPO AND SE1.D_E_L_E_T_ = ' ' "
	cQuery += " AND SE5.E5_RECPAG ='R' AND  SE1.E1_FLUXO <> 'N' "
	cQuery += " LEFT JOIN " + RetSQLName("SE2") + " SE2  ON SE2.E2_FILIAL = '"+ xFilial("SE2")+"' "
	cQuery += " AND SE2.E2_PREFIXO = SE5.E5_PREFIXO AND SE2.E2_NUM = SE5.E5_NUMERO AND SE2.E2_PARCELA = SE5.E5_PARCELA AND SE2.E2_TIPO = SE5.E5_TIPO "
	cQuery += " AND SE2.E2_FORNECE = SE5.E5_CLIFOR AND SE2.E2_LOJA = SE5.E5_LOJA AND SE2.D_E_L_E_T_ = ' ' "
	cQuery += " AND SE5.E5_RECPAG ='P' AND  SE2.E2_FLUXO <> 'N' "
	cQuery += " WHERE SE5.E5_FILIAL = '" + xFilial("SE5") + "' AND "
	cQuery += " SE5.E5_DTDISPO BETWEEN '" + DTOS(dDataAnt) + "' AND '"+ DTOS(dDataBase) + "' AND "
	cQuery += " SE5.E5_MOTBX <> 'FAT' AND "
	cQuery += " SE5.E5_SITUACA != 'C' "
	cQuery += " AND SE5.E5_TIPODOC NOT IN ('JR','MT','DC','BA','CM','J2','M2','D2','C2','V2','CX','CP','TL','VA','VM') "
	cQuery += " AND SE5.D_E_L_E_T_ = ' ' "
	cQuery += " AND NOT EXISTS ( "
	cQuery += " SELECT A.R_E_C_N_O_ "
	cQuery += " FROM "+RetSqlName("SE5")+" A "
	cQuery += " WHERE A.E5_FILIAL = SE5.E5_FILIAL "
	cQuery += " AND A.E5_NUMERO != ' ' "
	cQuery += " AND A.E5_TIPO != ' ' "
	cQuery += " AND A.E5_PREFIXO=SE5.E5_PREFIXO "
	cQuery += " AND A.E5_NUMERO=SE5.E5_NUMERO "
	cQuery += " AND A.E5_PARCELA=SE5.E5_PARCELA "
	cQuery += " AND A.E5_TIPO=SE5.E5_TIPO "
	cQuery += " AND A.E5_CLIFOR=SE5.E5_CLIFOR "
	cQuery += " AND A.E5_LOJA=SE5.E5_LOJA "
	cQuery += " AND A.E5_SEQ=SE5.E5_SEQ "
	cQuery += " AND ( A.E5_TIPODOC='ES' OR A.E5_SITUACA IN ('C','E','X') ) "
	cQuery += " AND A.E5_DATA <= '"+DTOS(dDataBase)+"' "
	cQuery += " AND A.E5_DTCANBX <= '"+DTOS(dDataBase)+"' "
	cQuery += " AND A.D_E_L_E_T_ = ' ') "
	cQuery += " AND SE5.D_E_L_E_T_ = ' ' "

	If lF770Qry
		cQueryAdd := ExecBlock("F770QRY", .F., .F.)
		If ValType(cQueryAdd) == "C"
			cQuery += " AND (" + cQueryAdd + ")"
		EndIf
	EndIf

	cQuery += " ORDER BY " + cOrder
	
	cQuery := ChangeQuery(cQuery)	
	
	If TCSQLExec(cInsertTit + cQuery) < 0
	 	UserException(TCSQLError())
	Endif

Return

/*/{Protheus.doc} InsertNat
Pesquisa os movimentos conforme range de natureza informado.

@type 	Function
@author Simone Mie Sato Kakinoana
@since	07/12/2022
@param	cNatIni, character, natureza inicial do range
@param	cNatFim, character, natureza final do range
@return	Nil
/*/
Static Function InsertNat(cNatIni As Character, nNatFim As Character)

	Local cWhere	As Character

	Default cNatIni		:= ""
	Default cNatFim		:= ""

	cWhere 	:= ""

	__cCposTit := "FILIAL, NATUREZA, RECPAG, DTBAIXA, MOVRECNO  "

	If __cInsNat1 == Nil
		__cInsNat1 := " INSERT "
		If "ORACLE" $ __cSGBD
			__cInsNat1 += " /*+ APPEND */ "
		EndIf
		__cInsNat1 += " INTO " + _oFINR7704:GetRealName()  +   "( " +__cCposTit  +" ) "
		__cInsNat1 += " SELECT " + __cCposTit 
		__cInsNat1 += " FROM " + _oFINR7703:GetRealName() + " "
	EndIf
	cWhere := " WHERE NATUREZA BETWEEN '" + cNatIni + "' AND '" + nNatFim + "'"		
	cWhere += " ORDER BY NATUREZA, DTBAIXA"

	If TCSQLExec(__cInsNat1 + cWhere) < 0
		 UserException(TCSQLError())
	EndIf	

Return Nil

/*/{Protheus.doc} ClrTmpNat
Realiza a limpeza das tabela de movimentos por natureza

@type 	Function
@author Simone Mie Sato Kakinoana
@since	07/12/2022
/*/
Static Function ClrTmpNat()

	If TCSQLExec("TRUNCATE TABLE " + _oFINR7704:GetRealName()) < 0
		 UserException(TCSQLError())
	EndIf
	
	TCRefresh(_oFINR7704:GetTableNameForTCFunctions())	

Return Nil

/*/{Protheus.doc} InsTmpVis
Insere os dados na tabela da visão gerencial por data

@type 	Function
@author Simone Mie Sato Kakinoana
@since	08/12/2022

@param	dBaixa, Date, Data de baixa
@param	cColuna, Character, string com as colunas 
@param	cTable, Character, Tabela a ser inserida os dados

@return	Nil

/*/
Static Function InsTmpvis( dBaixa as Date, cColuna as Character, cTable as Character)

	Local cQueryVis  As Character	
	Local cInsert    As Character
	Local nProcQry   As Numeric
	
	Default dBaixa := CTOD("  /  /  ")
	Default cColuna := ""	
	Default cTable	:= ""

	cQueryVis   := ""
	cInsert     := ""	
	nProcQry	:= 0
	
	If __oFJ3NAT == Nil
		cQueryVis := " SELECT 0 as FJ3_REC, 0 AS FJ3_PAGO, 0 AS FJ3_DISP,FJ3.FJ3_FILIAL,FJ3.FJ3_CODPLA,FJ3.FJ3_ORDEM,FJ3.FJ3_CONTAG,FJ3.FJ3_CTASUP,"
		cQueryVis += " FJ3.FJ3_DESCCG,FJ3.FJ3_DETHCG,FJ3.FJ3_NORMAL,FJ3.FJ3_COLUNA,FJ3.FJ3_CLASSE,FJ3.FJ3_IDENT,FJ3.FJ3_NOME,FJ3.FJ3_LINHA,"
		cQueryVis += " FJ3.FJ3_SEDINI,FJ3.FJ3_SEDFIM,FJ3.FJ3_FORMUL,FJ3.FJ3_TOTVIS,FJ3.FJ3_VISENT,FJ3.FJ3_SLDENT,FJ3.FJ3_FATSLD," 
		cQueryVis += " ?  FJ3_DATA "
		cQueryVis += " FROM " + RetSqlName("FJ3") + " FJ3 "
		cQueryVis += " WHERE FJ3_CODPLA = '" + MV_PAR05 + "' "
		cQueryVis += " AND FJ3.D_E_L_E_T_ = ' ' "
		cQueryVis := ChangeQuery(cQueryVis)	

		__oFJ3NAT := FWPreparedStatement():New(cQueryVis)
		
	EndIf 
	__oFJ3NAT:SetString(1, DTOS(dBaixa) )
	cQueryVis := __oFJ3NAT:GetFixQuery()
	
	cInsert := " INSERT "
	If "ORACLE" $__cSGBD	
		cInsert += " /*+ APPEND */ "
	EndIf

	cInsert += " INTO " + cTable + " ("+cColuna+" ) " + cQueryVis

	//Executo o comando para alimentar a tabela temporária
	Processa({|| nProcQry := TcSQLExec(cInsert)})

	If nProcQry != 0
		UserException( TCSqlError() )
	EndIf

Return Nil

/*/{Protheus.doc} GrvArqImp
Grava arquivo para impressão

@type 	Function
@author Simone Mie Sato Kakinoana
@since	08/12/2022

@param	cArqTmp, Character, Arquivo para impressão
@return	Nil
/*/
Static Function GrvArqImp( cArqTmp As Character )

	Local cCodDesc	As character	
	Local dBaixa	As Date

	Default cArqTmp := ""

	cCodDesc 	:= ""
	dBaixa		:= CTOD("  /  /  ")	

	cArqTmp->(dbSetOrder(2))
	TRB1->(DbSetOrder(3))
	TRB1->(dbGoTop())	
	Do While (TRB1->(!EOF()))				
		// Soh imprimir se a linha estiver como SIM no VISENT		
		If (TRB1->FJ3_VISENT == '1')	
			dBaixa := TRB1->FJ3_DATA
			cCodDesc := DTOC(TRB1->FJ3_DATA ) + " " + Space(TRB1->FJ3_COLUNA) + TRB1->FJ3_DESCCG
				
			If cArqTmp->(!dbSeek(dtos(dBaixa) + TRB1->FJ3_CONTAG))	
				RecLock("cArqTmp",.T.)
				CARQTMP->CONTAG    	:= TRB1->FJ3_CONTAG
				CARQTMP->CTASUP    	:= TRB1->FJ3_CTASUP
				CARQTMP->CODDESC    := cCodDesc							
				CARQTMP->DATAAN 	:= dBaixa
				CARQTMP->ORDEM 		:= TRB1->FJ3_ORDEM
				CARQTMP->RECEBIDOS  := TRB1->FJ3_REC
				CARQTMP->PAGOS      := TRB1->FJ3_PAGO								
				CARQTMP->CLASSE 	:= TRB1->FJ3_CLASSE
			Else
				RecLock("cArqTmp",.F.)
				CARQTMP->RECEBIDOS  += TRB1->FJ3_REC
				CARQTMP->PAGOS      += TRB1->FJ3_PAGO
			EndIf
			CARQTMP->(MsUnLock())
		EndIf

		RecLock("TRB1",.F.)		
		TRB1->FJ3_REC  := 0
		TRB1->FJ3_PAGO := 0		
		TRB1->(MsUnLock())

		TRB1->(dbSkip())
	EndDo

Return Nil		

/*/{Protheus.doc} AtuSintet
Atualiza sintetica

@type 	Function
@author Simone Mie Sato Kakinoana
@since	08/12/2022
Chama função de Atualização de Natureza superior

@return	Nil
/*/
Static Function AtuSintet()

	Local cQuery 		As Character
	Local cAliaSint		As Character

	cQuery 			:= ""
	cAliaSint		:= GetNextAlias()	
	
	cQuery 			:= " SELECT FJ3_DATA, FJ3_CTASUP, FJ3_IDENT, SUM(FJ3_REC) FJ3_REC, SUM(FJ3_PAGO) FJ3_PAGO, SUM(FJ3_DISP) FJ3_DISP "
	cQuery 			+= " FROM "+ _oFINR7702:GetRealName() 
	cQuery			+= " WHERE FJ3_CLASSE ='2' " 	
	cQuery 			+= " AND ( FJ3_REC <> 0 OR FJ3_PAGO <> 0  )"
	cQuery 			+= " GROUP BY FJ3_DATA, FJ3_CTASUP, FJ3_IDENT "
	cQuery 			:= ChangeQuery( cQuery )

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliaSint, .F., .T. )

	dbSelectArea(cAliaSint)
	While (cAliaSint)->(!Eof())
		
		AtuNatSup(cAliaSint)

		(cAliaSint)->(dbSkip()) 
	End

	If Select(cAliaSint) > 0
		(cAliaSint)->(dbCloseArea())
	Endif
	
Return Nil

/*/{Protheus.doc} AtuNatSup
Atualiza natureza superior

@type 	Function
@author Simone Mie Sato Kakinoana
@since	08/12/2022

@param	cAlias, character, alias para atualização da superior

@return	Nil
/*/
Static Function AtuNatSup(cAlias)
	
	Local cSuperior As Character	
	Local cIdenti   As Character 	
	Local dBaixa  	As Date	
	Local nCont 	As Numeric

	Default cAlias 	:= ""
	
	cSuperior := (cAlias)->FJ3_CTASUP 	
	cIdenti	  := (cAlias)->FJ3_IDENT
	dBaixa	   := (cAlias)->FJ3_DATA
	nCont     := (cAlias)->(Recno())	

	dbSelectArea("TRB1")
	dbSetOrder(2)			
	dbGotop()

	While TRB1->(!Eof())

		If TRB1->(MsSeek(mv_par05 + cSuperior + dBaixa))
			TRB1->FJ3_DATA := STOD(dBaixa)			
			RecLock("TRB1",.F.)								
			TRB1->FJ3_REC  += (cAlias)->FJ3_REC				
			TRB1->FJ3_PAGO += (cAlias)->FJ3_PAGO				
			TRB1->(MsUnLock())			
		EndIf

		dbSelectArea("TRB1")
		If !Eof() .And. Empty(TRB1->FJ3_CTASUP)
			dbSelectArea("TRB1")
			Exit
		EndIf
		cSuperior 	:= TRB1->FJ3_CTASUP
	EndDo	

	(cAlias)->(DbGoTo(nCont))
	
Return Nil

/*/{Protheus.doc} AtuDispon
Atualiza disponivel das analiticas

@type 	Function
@author Simone Mie Sato Kakinoana
@since	08/12/2022
Atuliza coluna disponivel das analiticas

@param	nDispon, numeric, saldo disponivel
@param	cArqTmp, character, alias para atualização do saldo disponivel 

@return	Nil
/*/
Static Function AtuDispon(nDispon as Numeric, cArqTmp As character)

	Local cQuery 		As Character
	Local cAliasDisp	As Character	
	Local cSuperior		As Character
	Local cAnterior 	As Character

	Default nDispon := 0
	Default cArqTmp := ""

	cAliasDisp		:= GetNextAlias()
	cQuery 			:= ""
	cAnterior 		:= ""
	cSuperior 		:= ""

	cQuery 			:= " SELECT DATAAN, CONTAG, CTASUP, RECEBIDOS, PAGOS, ORDEM, R_E_C_N_O_ RECDISP "
	cQuery 			+= " FROM "+ _oFINR7701:GetRealName() 
	cQuery			+= " WHERE CLASSE ='2' " 	
	cQuery 			+= " ORDER BY CONTAG, DATAAN "
	cQuery 			:= ChangeQuery( cQuery )

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasDisp, .F., .T. )

	cArqTmp->(dbSetOrder(2))	
	dbSelectArea(cAliasDisp)

	While (cAliasDisp)->(!Eof())

		cArqTmp->(dbGoto((cAliasDisp)->RECDISP))
		cSuperior := cArqTmp->CTASUP

		If cAnterior <> (cAliasDisp)->CONTAG
			nDispon := 0 
		EndIf

		Reclock("cArqTmp",.F.)
		cArqTmp->DISPONIVEL	:= nDispon + (cAliasDisp)->RECEBIDOS - (cAliasDisp)->PAGOS
		cArqTmp->(MsUnlock())		
		nRecTmp := cArqTmp->(Recno())
		nDispon := cArqTmp->DISPONIVEL

		While cArqTmp->(!Eof())

			If cArqTmp->(DbSeek( (cAliasDisp)->DATAAN + cSuperior ))
				RecLock("cArqTmp",.F.)								
				cArqTmp->DISPONIVEL  += nDispon
				cArqTmp->(MsUnLock())			
			EndIf

			dbSelectArea("cArqTmp")
			If !Eof() .And. Empty(cArqTmp->CTASUP)
				dbSelectArea("cArqTmp")
				Exit
			EndIf
			cSuperior 	:= cArqTmp->CTASUP			
		End	
		cAnterior	:= (cAliasDisp)->CONTAG
		(cAliasDisp)->(dbSkip()) 
	End			

	If Select(cAliasDisp) > 0
		(cAliasDisp)->(dbCloseArea())
	Endif
	dbSelectarea("cArqTmp")	

Return Nil
