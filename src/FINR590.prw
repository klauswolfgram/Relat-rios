/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR590.ch"
#INCLUDE "PROTHEUS.CH"

Static lFWCodFil := FindFunction("FWCodFil")

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FinR590  ³ Autor ³ Adrianne Furtado      ³ Data ³ 10/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Mapa de Rateios Multipla Naturezas            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR590(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR590()

Pergunte("FINR590",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							 ³
//³ mv_par01			// Cli/For De ?								 ³
//³ mv_par02			// Cli/For Ate ?							 ³
//³ mv_par03			// Titulo De ?								 ³
//³ mv_par04			// Titulo Ate ?								 ³
//³ mv_par05			// Prefixo De ?								 ³
//³ mv_par06			// Prefixo Ate ? 							 ³
//³ mv_par07			// Emissao De ?								 ³
//³ mv_par08			// Emissao Ate ?							 ³
//³ mv_par09			// Vencimento De ?							 ³
//³ mv_par10			// Vencimento Ate ?							 ³
//³ mv_par11			// Distribicao ? CR /CP /BX-CR /BX-CP	 	 ³
//³ mv_par12			// Nivel de Quebra ? 1-Natur  2- C.Custo	 ³
//³ mv_par13			// Qual Moeda ? 							 ³
//³ mv_par14			// Outras Moedas ? Converter /Nao.Imp		 ³
//³ mv_par15			// Considera Filiais Abaixo ?				 ³
//³ mv_par16			// Filial De  ?								 ³
//³ mv_par17			// Filial Ate ?								 ³
//³ mv_par18			// Seleciona Filiais ?						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


If FindFunction("TRepInUse") .And. TRepInUse() 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := ReportDef()                         
	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf
	oReport:PrintDialog()
Else
    Return U_FinR590R3() // Executa versão anterior do fonte
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Adrianne Furtado      ³ Data ³10.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport 
Local oTitulo
Local oNaturezas
Local oCell   
Local cAlias  := GetNextAlias() 
Local nTamEV  := TAMSX3('EV_NATUREZ')[1]
Local nOffSet := 1

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
oReport := TReport():New("FINR590",STR0003,"FIR590", {|oReport| ReportPrint(oReport,cAlias)},STR0001+" "+STR0002) //"Mapa de Distribuição de Multiplas Naturezas"##"Este relatorio ir  imprimir o mapa de rateios de Multipla Natureza e  ""Multipla Natureza por Centro de Custo"
oReport:SetTotalInLine(.F.)

/********************************************************************/
/* SECOES DA INCLUSAO DE CONTAS A RECEBER							*/
/********************************************************************/
oIncCReceb := TRSection():New(oReport,STR0037,{},)   			//"TituloICReceb"
//CAMPOS PARA - INCLUSAO C.RECEBER
TRCell():New(oIncCReceb,"E1_PREFIXO" 	,"SE1",STR0018)			//"PRF"
TRCell():New(oIncCReceb,"E1_NUM"		,"SE1",STR0019)         //"NUMERO"
TRCell():New(oIncCReceb,"E1_PARCELA"	,"SE1",STR0020)         //"PC"
TRCell():New(oIncCReceb,"E1_TIPO"		,"SE1",STR0021)         //"TIPO"
TRCell():New(oIncCReceb,"E1_CLIENTE"	,"SE1",STR0022)         //"CLIENTE"
TRCell():New(oIncCReceb,"E1_LOJA"		,"SE1",STR0023)         //"LOJA"
TRCell():New(oIncCReceb,"E1_EMISSAO"	,"SE1",STR0024)         //"EMISSAO"
TRCell():New(oIncCReceb,"E1_VENCREA"	,"SE1",STR0025)        	//"VENCIMENTO"
TRCell():New(oIncCReceb,"E1_VALOR"		,"SE1",STR0026,PesqPict("SE1","E1_SALDO",15))  //"VALOR TITULO"  

oTitsIncRcb := TRSection():New(oIncCReceb,STR0038,{})			//"Titulos"

//--- Chamado TGZZXX
TRCell():New(oTitsIncRcb ,"EV_NATUREZ"	,"SEV",STR0027,,nTamEV+nOffSet )  //"NATUREZA"

TRCell():New(oTitsIncRcb ,"ED_DESCRIC"	,"SED",STR0043) 			//"DESCRIÇÃO"
TRCell():New(oTitsIncRcb ,"EV_PERC"		,"SEV",STR0028 ,"@E 999.99",/*[nSize ]*/,/*[ lPixel ]*/,{|| EV_PERC * 100})		//"%NATUREZA"
TRCell():New(oTitsIncRcb ,"EV_VALOR"	,"SEV",STR0029)			//"VALOR NATUREZA"

oTitsRecCCust := TRSection():New(oTitsIncRcb,STR0039,{})		//"Por Centro de Custo"
TRCell():New(oTitsRecCCust ,"EZ_CCUSTO" ,"SEZ",STR0030)			//"C.CUSTO"
TRCell():New(oTitsRecCCust ,"CTT_DESC01","CTT",STR0043,,30)	//"DESCRIÇÃO"
TRCell():New(oTitsRecCCust ,"EZ_PERC"   ,"SEZ",STR0031 ,"@E 999.99",/*[nSize ]*/,/*[ lPixel ]*/,{ || EZ_PERC * 100})		//"%C.CUSTO"
TRCell():New(oTitsRecCCust ,"EZ_VALOR"	  ,"SEZ",STR0032)			//"VALOR C.CUSTO"

/********************************************************************/
/* SECOES DA INCLUSAO DE CONTAS A PAGAR								*/
/********************************************************************/
oIncCPagar := TRSection():New(oReport,STR0040 ,{},)   			//"TituloICPagar"
//CAMPOS PARA - INCLUSAO C.PAGAR
TRCell():New(oIncCPagar,"E2_PREFIXO" 	,"SE2",STR0018)			//"PRF"
TRCell():New(oIncCPagar,"E2_NUM"		,"SE2",STR0019)         //"NUMERO"
TRCell():New(oIncCPagar,"E2_PARCELA"	,"SE2",STR0020)         //"PC"
TRCell():New(oIncCPagar,"E2_TIPO"		,"SE2",STR0021)         //"TIPO"
TRCell():New(oIncCPagar,"E2_FORNECE"	,"SE2",STR0033)         //"FORNEC"
TRCell():New(oIncCPagar,"E2_LOJA"		,"SE2",STR0023)         //"LOJA"
TRCell():New(oIncCPagar,"E2_EMISSAO"	,"SE2",STR0024)         //"EMISSAO"
TRCell():New(oIncCPagar,"E2_VENCREA"	,"SE2",STR0025)        	//"VENCIMENTO"
TRCell():New(oIncCPagar,"E2_VALOR"		,"SE2",STR0026,PesqPict("SE2","E2_SALDO",15))  //"VALOR TITULO"  

oTitsIncPag := TRSection():New(oIncCPagar,STR0038 ,{})			//"Titulos"

//--- Chamado TGZZXX
TRCell():New(oTitsIncPag,"EV_NATUREZ" 	,"SEV",STR0027,,nTamEV+nOffSet )		//"NATUREZA"

TRCell():New(oTitsIncPag,"ED_DESCRIC" 	,"SED",STR0043) 			//"DESCRIÇÃO"
TRCell():New(oTitsIncPag,"EV_PERC"		,"SEV",STR0028,"@E 999.99",/*[nSize ]*/,/*[ lPixel ]*/,{|| EV_PERC * 100})		//"%NATUREZA"
TRCell():New(oTitsIncPag,"EV_VALOR"		,"SEV",STR0029)			//"VALOR NATUREZA"

oTitsPagCCust := TRSection():New(oTitsIncPag,STR0039,{})	//"Por Centro de Custo"
TRCell():New(oTitsPagCCust,"EZ_CCUSTO"	,"SEZ",STR0030)	   	//"C.CUSTO"
TRCell():New(oTitsPagCCust,"CTT_DESC01","CTT",STR0043,,30)	//"DESCRIÇÃO"
TRCell():New(oTitsPagCCust,"EZ_PERC"	,"SEZ",STR0031,"@E 999.99",/*[nSize ]*/,/*[ lPixel ]*/,{|| EZ_PERC * 100})		//"%C.CUSTO"
TRCell():New(oTitsPagCCust,"EZ_VALOR"	,"SEZ",STR0032)	   	//"VALOR C.CUSTO"

/********************************************************************/
/* SECOES DAS BAIXAS					 							*/
/********************************************************************/
oBaixas := TRSection():New(oReport,STR0041 ,{})   			//"TitulosBaixas"
//CAMPOS PARA - Baixas
TRCell():New(oBaixas,"E5_PREFIXO" 	,"SE5",STR0018)			//"PRF"
TRCell():New(oBaixas,"E5_NUMERO"	,"SE5",STR0019)         //"NUMERO"
TRCell():New(oBaixas,"E5_PARCELA"	,"SE5",STR0020)         //"PC"
TRCell():New(oBaixas,"E5_TIPO"		,"SE5",STR0021)         //"TIPO"
TRCell():New(oBaixas,"E5_CLIFOR"	,"SE5",STR0034)			//"CLI/FOR"
TRCell():New(oBaixas,"E5_LOJA"		,"SE5",STR0023)         //"LOJA"
TRCell():New(oBaixas,"E5_DATA"		,"SE5",STR0024)			//"EMISSAO"
TRCell():New(oBaixas,"E5_SEQ"		,"SE5",STR0035)			//"SEQUENCIA"
TRCell():New(oBaixas,"E5_VALOR"		,"SE5",STR0036)			//"VALOR DA BAIXA"

oTitsBaixa := TRSection():New(oBaixas,STR0038,{})				//"Titulos"

//--- Chamado TGZZXX
TRCell():New(oTitsBaixa,"EV_NATUREZ" 	,"SEV",STR0027,,nTamEV+nOffSet )	//"NATUREZA"

TRCell():New(oTitsBaixa,"ED_DESCRIC" 	,"SED",STR0043) 			//"DESCRIÇÃO"
TRCell():New(oTitsBaixa,"EV_PERC"		,"SEV",STR0028,"@E 999.99",/*[nSize ]*/,/*[ lPixel ]*/,{|| EV_PERC * 100})		//"%NATUREZA"
TRCell():New(oTitsBaixa,"EV_VALOR" 		,"SEV",STR0029)		//"VALOR NATUREZA"

oTitsBxCC := TRSection():New(oTitsBaixa,STR0039,{})			//"Por Centro de Custo"
TRCell():New(oTitsBxCC,"EZ_CCUSTO"		,"SEZ",STR0030)		//"C.CUSTO"
TRCell():New(oTitsBxCC,"CTT_DESC01","CTT",STR0043,,30)	//"DESCRIÇÃO"
TRCell():New(oTitsBxCC,"EZ_PERC"			,"SEZ",STR0031	,"@E 999.99",/*[nSize ]*/,/*[ lPixel ]*/,{ || EZ_PERC * 100})		//"%C.CUSTO"
TRCell():New(oTitsBxCC,"EZ_VALOR"		,"SEZ",STR0032)		//"VALOR C.CUSTO"

Return(oReport)             

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Adrianne Furtado      ³ Data ³10.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAlias)
Local oIncCReceb	:= oReport:Section(1)				//secao pai da Inclusao de Contas a Receber
Local oTitsIncRcb 	:= oReport:Section(1):Section(1)   //secao filha da Inclusao de Contas a Receber
Local oTitsRecCCust	:= oReport:Section(1):Section(1):Section(1)	//secao filha da Inclusao de Contas a Receber (Centro de Custo)

Local oIncCPagar	:= oReport:Section(2)				//secao pai da Inclusao de Contas a Pagar
Local oTitsIncPag	:= oReport:Section(2):Section(1)   //secao filha da Inclusao de Contas a Pagar
Local oTitsPagCCust	:= oReport:Section(2):Section(1):Section(1)	//secao filha da Inclusao de Contas a Pagar (Centro de Custo)

Local oBaixas		:= oReport:Section(3)				//secao pai das Baixas
Local oTitsBaixa 	:= oReport:Section(3):Section(1)   //secao filha das Baixas
Local oTitsBxCC 	:= oReport:Section(3):Section(1):Section(1)	//secao filha das Baixas (Centro de Custo)

Local cTit			:= ""
Local cSql1			:= ""			//trecho de query, implementado de acordo com a condicao utilizada
Local cSql2			:= ""			//trecho de query, implementado de acordo com a condicao utilizada
Local cOrder                       //ordem do arquivo de saida da query
Local cTitulo		:= ""
Local nDecs       
Local bPosTit		:= { || }		// Posiciona a impressao dos titulos 
Local bWhile		:= { || }		// Condicao para impressao dos titulos 
Local bWhile1       := { || }		// Condicao skip de impressao da linha do titulos :
Local oBreak
Local cAlias1						//Alias principal - pode assumir SE1, SE2 ou SE5 dependo da opcao de relatorio selecionada
Local cAliasSEV 	:= "SEV"
Local cAliasSEZ 	:= "SEZ"       
Local cQuebra		:= ""
Local cFilialSE2
Local cFilaiSEV
Local cE5_SEQ		:= Space( TamSX3("E5_SEQ")[1] )
Local cEV_SEQ		:= Space( TamSX3("EV_SEQ")[1] )
Local cTipoIn		:= ""

If oReport:lXlsTable
	Alert(STR0044)//Formato de impressão tabela não suportado neste relatório
	oReport:CancelPrint()
	Return
Endif

Pergunte( "FIR590", .F. )

nDecs 	:=Msdecimais(mv_par13)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtro dos registros do relatorio                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	dbSelectArea("SE1")
	dbSetOrder(1)
	cOrder	:= "%"+SqlOrder(IndexKey())+"%"
	SE1->(dbCloseArea())

	cAlias := GetNextAlias()         	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³	
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatorio      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par11 == 1  //Inclusao C.Receber
		bPosTit := { || cTitulo := (cAlias1)->( E1_FILIAL + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + E1_CLIENTE + E1_LOJA) }
		bWhile	:= { || (cAliasSEV)->( EV_FILIAL + EV_PREFIXO + EV_NUM + EV_PARCELA + EV_TIPO + EV_CLIFOR + EV_LOJA) == cTitulo }		
		dbSelectArea("SE1")
		dbSetOrder(1)
		cOrder	:= "%"+SqlOrder(IndexKey())+"%"
		SE1->(dbCloseArea())

		cAlias := GetNextAlias()     
		oIncCReceb:BeginQuery()	

		//Filtra SE1 - Distribuicao Mult Nat Inclusao C.Receber
		If mv_par14 == 2 //Imprime Outras Moedas
			cSql1 := " E1_MOEDA = "+Alltrim(Str(mv_par13))+" AND "
		Endif
		If mv_par15 == 1 .and. !Empty(xFilial("SE1")) .and. !Empty(xFilial("SEV"))
			cSql2 := "BETWEEN '" + mv_par16 + "' AND '" + mv_par17 + "'"		
		Else
			cSql2 := "= '" + xFilial("SE1") + "'"
		EndIf                    
		cSql1 := "%"+cSql1+"%"   
		cSql2 := "%"+cSql2+"%"   		
     
		BeginSql Alias cAlias
		SELECT	E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_CLIENTE, E1_LOJA, E1_EMISSAO, E1_VENCREA, E1_MOEDA,  E1_MULTNAT, E1_VALOR,
				EV_FILIAL, EV_PREFIXO, EV_NUM, EV_PARCELA, EV_TIPO, EV_CLIFOR,  EV_LOJA, EV_NATUREZ, EV_PERC, EV_VALOR, EV_RECPAG, EV_RATEICC,
				EZ_FILIAL, EZ_PREFIXO, EZ_NUM, EZ_PARCELA, EZ_TIPO, EZ_CLIFOR, EZ_CCUSTO,  EZ_LOJA, EZ_NATUREZ, EZ_PERC, EZ_VALOR, EZ_RECPAG,
				ED_DESCRIC, CTT_DESC01
		FROM 	%table:SEV% SEV
				LEFT JOIN %table:SE1% SE1
				ON  (EV_FILIAL   = E1_FILIAL AND
					  EV_PREFIXO  = E1_PREFIXO AND 
					  EV_NUM	  = E1_NUM AND 
					  EV_PARCELA  = E1_PARCELA AND 
					  EV_TIPO	  = E1_TIPO AND 
					  EV_SITUACA  = ' ' AND
					  SE1.%notDel%)
				LEFT JOIN %table:SEZ% SEZ 
				ON  (EV_FILIAL   = EZ_FILIAL AND
					  EV_PREFIXO  = EZ_PREFIXO AND 
					  EV_NUM	  = EZ_NUM AND 
					  EV_PARCELA  = EZ_PARCELA AND 
					  EV_TIPO	  = EZ_TIPO AND
					  EV_CLIFOR   = EZ_CLIFOR AND
					  EV_LOJA     = EZ_LOJA AND
					  EV_NATUREZ  = EZ_NATUREZ AND       
					  EV_IDENT	  = EZ_IDENT AND					  
					  EV_RECPAG	  = EZ_RECPAG AND
					  EZ_SITUACA  = ' ' AND
					  SEZ.%notDel% )  
				LEFT JOIN %table:CTT% CTT
				ON  (CTT_FILIAL = %xFilial:CTT% AND
					  CTT_CUSTO = EZ_CCUSTO AND
  					  CTT.%notDel%)
				LEFT JOIN %table:SED% SED
				ON  ( ED_FILIAL = %xFilial:SED% AND
					  ED_CODIGO = EV_NATUREZ AND
  					  SED.%notDel%)
		WHERE E1_FILIAL %exp:cSql2% AND     	
			E1_CLIENTE 	between %Exp:mv_par01% AND %Exp:mv_par02% AND    
			E1_NUM     	between %Exp:mv_par03% AND %Exp:mv_par04% AND
			E1_PREFIXO 	between %Exp:mv_par05% AND %Exp:mv_par06% AND
			E1_EMISSAO 	between %Exp:DTOS(mv_par07)% AND %Exp:DTOS(mv_par08)% AND    		
			E1_VENCREA 	between %Exp:DTOS(mv_par09)% AND %Exp:DTOS(mv_par10)% AND    					
			%exp:cSql1%		
			E1_MULTNAT	= '1' AND 
			EV_RECPAG 	= 'R' AND
			EV_SEQ 		= %exp:cEV_SEQ% AND
			EV_IDENT	= '1' AND
			SEV.%notDel%
		ORDER BY %exp:cOrder%  
		EndSql                    

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Metodo EndQuery ( Classe TRSection )                                    ³
		//³Prepara o relatório para executar o Embedded SQL.                       ³
		//³ExpA1 : Array com os parametros do tipo Range                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oIncCReceb:EndQuery(/*Array com os parametros do tipo Range*/)
		
		oTitsIncRcb :SetParentQuery()
		oTitsIncRcb :SetParentFilter({|cParam| (cAlias)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO) == cParam }, {||(cAlias)->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO)})
		oTitsIncRcb:Cell("EV_NATUREZ"):SetBlock({|| MascNat((cAlias)->EV_NATUREZ) })
		oTitsRecCCust:SetParentQuery()		
		oTitsRecCCust :SetParentFilter({|cParam| (cAlias)->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EZ_NATUREZ) == cParam }, {||(cAlias)->(EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_NATUREZ)})

	ElseIf mv_par11 == 2  //Inclusao C.Pagar
	
		bPosTit := { || cTitulo := (cAlias1)->( E2_FILIAL + E2_PREFIXO + E2_NUM + E2_PARCELA + E2_TIPO + E2_FORNECE + E2_LOJA) } 
		bWhile	:= { || (cAliasSEV)->( EV_FILIAL + EV_PREFIXO + EV_NUM + EV_PARCELA + EV_TIPO + EV_CLIFOR + EV_LOJA) == cTitulo }

		dbSelectArea("SE2")
		dbSetOrder(1)
		cOrder	:= "%"+SqlOrder(IndexKey())+"%"
		SE2->(dbCloseArea())

		oIncCPagar:BeginQuery()	

		//Filtra SE2 - Distribuicao Mult Nat Inclusao C.Pagar
		If mv_par14 == 2 //Imprime Outras Moedas
			cSql1 += " E2_MOEDA = "+Alltrim(Str(mv_par13))+" AND "
		Endif
		If mv_par15 == 1 .and. !Empty(xFilial("SE2")) .and. !Empty(xFilial("SEV"))
			cSql2 := "BETWEEN '" + mv_par16 + "' AND '" + mv_par17 + "'"		
		Else
			cSql2 := "= '" + xFilial("SE2") + "'"		
		EndIf                     
		cSql1 := "%"+cSql1+"%"   
		cSql2 := "%"+cSql2+"%"   		                

		BeginSql Alias cAlias
		SELECT 	E2_FILIAL, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA, E2_EMISSAO, E2_EMIS1, E2_VENCREA, E2_MOEDA, E2_MULTNAT, E2_VALOR,
				EV_FILIAL, EV_PREFIXO, EV_NUM, EV_PARCELA, EV_TIPO, EV_CLIFOR,  EV_LOJA, EV_NATUREZ, EV_PERC,  EV_VALOR, EV_RECPAG, EV_RATEICC, 
				EZ_FILIAL, EZ_PREFIXO, EZ_NUM, EZ_PARCELA, EZ_TIPO, EZ_CLIFOR,  EZ_LOJA, EZ_CCUSTO, EZ_NATUREZ, EZ_PERC,  EZ_VALOR, EZ_RECPAG, 
				ED_DESCRIC, CTT_DESC01 
		FROM %table:SEV% SEV
				LEFT JOIN %table:SE2% SE2
				ON  (EV_FILIAL   = E2_FILIAL AND
					  EV_PREFIXO  = E2_PREFIXO AND 
					  EV_NUM	  = E2_NUM AND 
					  EV_PARCELA  = E2_PARCELA AND 
					  EV_TIPO	  = E2_TIPO AND
					  EV_SITUACA  = ' ' AND
					  EV_CLIFOR   = E2_FORNECE AND
					  SE2.%notDel%)
				LEFT JOIN %table:SEZ% SEZ 
				ON  (EV_FILIAL   = EZ_FILIAL AND
					  EV_PREFIXO  = EZ_PREFIXO AND 
					  EV_NUM	  = EZ_NUM AND 
					  EV_PARCELA  = EZ_PARCELA AND 
					  EV_TIPO	  = EZ_TIPO AND
					  EV_CLIFOR   = EZ_CLIFOR AND
					  EV_LOJA     = EZ_LOJA AND
					  EV_NATUREZ  = EZ_NATUREZ AND
					  EV_IDENT	  = EZ_IDENT AND
					  EV_RECPAG	  = EZ_RECPAG AND
					  EZ_SITUACA  = ' ' AND
					  SEZ.%notDel%)  
				LEFT JOIN %table:CTT% CTT
				ON  (CTT_FILIAL = %xFilial:CTT% AND
					  EZ_CCUSTO = CTT_CUSTO AND
  					  CTT.%notDel%)
				LEFT JOIN %table:SED% SED
				ON  ( ED_FILIAL = %xFilial:SED% AND
					  ED_CODIGO = EV_NATUREZ AND
  					  SED.%notDel%)
		WHERE E2_FILIAL %exp:cSql2% AND  
			E2_FORNECE 	between %Exp:mv_par01% AND %Exp:mv_par02% AND    
			E2_NUM     	between %Exp:mv_par03% AND %Exp:mv_par04% AND    
			E2_PREFIXO 	between %Exp:mv_par05% AND %Exp:mv_par06% AND    
			E2_EMIS1 	between %Exp:DTOS(mv_par07)% AND %Exp:DTOS(mv_par08)% AND    		
			E2_VENCREA 	between %Exp:DTOS(mv_par09)% AND %Exp:DTOS(mv_par10)% AND    					
			%exp:cSql1%		
			E2_MULTNAT	= '1' AND   
			EV_RECPAG   = 'P' AND	
			EV_SEQ 		= %exp:cEV_SEQ% AND	
			EV_IDENT	= '1' AND
			SEV.%notDel% 
		ORDER BY %exp:cOrder%  
		EndSql

		oIncCPagar:EndQuery(/*Array com os parametros do tipo Range*/)

		oTitsIncPag:SetParentQuery()
		oTitsIncPag:SetParentFilter({|cParam| (cAlias)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE) == cParam}, {||(cAlias)->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR)})		
		oTitsIncPag:Cell("EV_NATUREZ"):SetBlock({|| MascNat((cAlias)->EV_NATUREZ) })
		oTitsPagCCust:SetParentQuery()
		oTitsPagCCust :SetParentFilter({|cParam| (cAlias)->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EZ_NATUREZ) == cParam }, {||(cAlias)->(EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_NATUREZ)})		
		
	ElseIf mv_par11 == 3 .or. mv_par11 == 4   //Baixas a Receber = 3
   														//Baixas a Pagar = 4
		bPosTit := { || cTitulo := (cAlias1)->( E5_FILIAL + E5_PREFIXO + E5_NUMERO + E5_PARCELA + E5_TIPO + E5_CLIFOR + E5_LOJA) } 
		bWhile	:= { || (cAliasSEV)->( EV_FILIAL + EV_PREFIXO + EV_NUM + EV_PARCELA + EV_TIPO + EV_CLIFOR + EV_LOJA) == cTitulo }
		bWhile1	:= { || (cAliasSEV)->( EV_FILIAL + EV_PREFIXO + EV_NUM + EV_PARCELA + EV_TIPO + EV_CLIFOR + EV_LOJA) <> cTitulo }

		//Filtra SE5 - Distribuicao Mult Nat Baixa C.Rceber ou C.Pagar
		oBaixas:BeginQuery()	
		//Filtra SE2 - Distribuicao Mult Nat Inclusao C.Pagar
		dbSelectArea("SE1")
		dbSetOrder(1)
		cOrder	:= "%"+SqlOrder(IndexKey())+"%"
		SE1->(dbCloseArea())

		dbSelectArea("SE5")
		dbSetOrder(7)
		cOrder	:= "%"+SqlOrder(IndexKey())+"%"
		SE5->(dbCloseArea())				

		If mv_par15 == 1 .and. !Empty(xFilial("SE5")) .and. !Empty(xFilial("SEV"))
			cSql2 := " BETWEEN '" + mv_par16 + "' AND '" + mv_par17 + "'" 
		Else
			cSql2 := " = '" + xFilial("SE5") + "'"
		EndIf

		cTipoIn := FormatIn(MVPAGANT+"|"+MV_CPNEG, "|")
		cTipoIn := Replace(cTipoIn, "('", "")
		cTipoIn := Replace(cTipoIn, "')", "")


		If mv_par11 == 3
			If mv_par14 == 2 //Imprime Outras Moedas
				cSql1 += " E1_MOEDA = "+Alltrim(Str(mv_par13))+" AND "				
			EndIf
			cSql1 := "%"+cSql1+"%"
			cSql2 := "%"+cSql2+"%"

			BeginSql Alias cAlias
			SELECT E5_FILIAL, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_RECPAG, E5_DATA, E5_MULTNAT, E5_SEQ, E5_VALOR, E5_SITUACA,
					EV_FILIAL, EV_PREFIXO, EV_NUM,    EV_PARCELA, EV_TIPO, EV_CLIFOR, EV_LOJA, EV_RECPAG, EV_NATUREZ, EV_PERC, EV_VALOR, EV_RATEICC,
					E1_FILIAL, E1_PREFIXO, E1_NUM,    E1_PARCELA, E1_TIPO, E1_MOEDA,
					EZ_FILIAL, EZ_PREFIXO, EZ_NUM,    EZ_PARCELA, EZ_TIPO, EZ_CCUSTO, EZ_CLIFOR, EZ_LOJA, EZ_RECPAG, EZ_NATUREZ, EZ_PERC, EZ_VALOR,
					ED_DESCRIC, CTT_DESC01
			FROM %table:SEV% SEV
				LEFT JOIN %table:SE5% SE5
				ON  (EV_FILIAL   = E5_FILIAL AND
					  EV_PREFIXO  = E5_PREFIXO AND 
					  EV_NUM	  = E5_NUMERO AND 
					  EV_PARCELA  = E5_PARCELA AND 
					  EV_TIPO	  = E5_TIPO AND  
					  'R'		  = E5_RECPAG AND
  					  %exp:cE5_SEQ% <> E5_SEQ AND
					  SE5.%notDel%)
				LEFT JOIN %table:SEZ% SEZ 
				ON  (EV_FILIAL   = EZ_FILIAL AND
					  EV_PREFIXO  = EZ_PREFIXO AND 
					  EV_NUM	  = EZ_NUM AND 
					  EV_PARCELA  = EZ_PARCELA AND 
					  EV_TIPO	  = EZ_TIPO AND
					  EV_CLIFOR   = EZ_CLIFOR AND
					  EV_LOJA     = EZ_LOJA AND
					  EV_NATUREZ  = EZ_NATUREZ AND 
					  EV_IDENT	  = EZ_IDENT AND
					  EV_RECPAG	  = EZ_RECPAG AND
					  EZ_SITUACA  = ' ' AND
					  SEZ.%notDel%)  
				LEFT JOIN %table:SE1% SE1 
				ON  (EV_FILIAL   = E1_FILIAL AND
					  EV_PREFIXO  = E1_PREFIXO AND 
					  EV_NUM	  = E1_NUM AND 
					  EV_PARCELA  = E1_PARCELA AND 
					  EV_TIPO	  = E1_TIPO AND
					  EV_CLIFOR   = E1_CLIENTE AND
					  EV_LOJA     = E1_LOJA AND
					  SE1.%notDel%)
				LEFT JOIN %table:CTT% CTT
				ON  (CTT_FILIAL = %xFilial:CTT% AND
					  EZ_CCUSTO  = CTT_CUSTO AND
  					  CTT.%notDel%)					  
				LEFT JOIN %table:SED% SED
				ON  ( ED_FILIAL = %xFilial:SED% AND
					  ED_CODIGO  = EV_NATUREZ AND
  					  SED.%notDel%)
			WHERE E5_FILIAL %exp:cSql2% AND  
				E5_CLIFOR  	between %Exp:mv_par01% AND %Exp:mv_par02% AND    
				E5_NUMERO  	between %Exp:mv_par03% AND %Exp:mv_par04% AND    
				E5_PREFIXO 	between %Exp:mv_par05% AND %Exp:mv_par06% AND    
				E5_DATA  	between %Exp:DTOS(mv_par07)% AND %Exp:DTOS(mv_par08)% AND    		
				E5_MULTNAT	= "1" AND 		
			    ((E5_RECPAG = 'R') OR (E5_TIPODOC = 'ES' AND E5_RECPAG = 'P') OR (E5_TIPO IN (%Exp:MV_CRNEG%,%Exp:MVRECANT%) AND E5_RECPAG = 'P')) AND
				((E5_TIPO NOT IN (%Exp:MVRECANT%,%Exp:MV_CRNEG%) AND E5_TIPODOC <>'ES') OR 	//Baixa de RA
				(E5_TIPO IN (%Exp:cTipoIn%) AND E5_TIPODOC ='ES')) AND			//Estorno da Baixa de PA
				NOT(E5_RECPAG = 'R' AND E5_TIPO IN (%Exp:MVPAGANT%,%Exp:MV_CRNEG%) AND E5_TIPODOC IN ('VL,BA,DC,D2,MT,JR,J2,M2,CM,C2,CX')) AND 
				%exp:cSql1%		
				EV_SEQ <> %exp:cEV_SEQ% AND				
				SEV.%notDel% 
			ORDER BY %exp:cOrder%  
			EndSql
		Else
			If mv_par14 == 2 //Imprime Outras Moedas
				cSql1 += " E2_MOEDA = "+Alltrim(Str(mv_par13))+" AND "
			EndIf

			cSql1 := "%"+cSql1+"%"
			cSql2 := "%"+cSql2+"%"
			
			BeginSql Alias cAlias
			SELECT E5_FILIAL, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_RECPAG,  E5_DATA, E5_MULTNAT, E5_SEQ, E5_VALOR, E5_SITUACA,
					EV_FILIAL, EV_PREFIXO, EV_NUM, EV_PARCELA, EV_TIPO, EV_CLIFOR, EV_LOJA, EV_NATUREZ, EV_PERC, EV_VALOR,   EV_RECPAG, EV_RATEICC,
					E2_FILIAL, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_MOEDA,
					EZ_FILIAL, EZ_PREFIXO, EZ_NUM, EZ_PARCELA, EZ_TIPO, EZ_CCUSTO, EZ_CLIFOR, EZ_LOJA, EZ_NATUREZ, EZ_PERC, EZ_VALOR,   EZ_RECPAG,
					ED_DESCRIC, CTT_DESC01
			FROM %table:SEV% SEV
				LEFT JOIN %table:SE5% SE5
				ON  (EV_FILIAL = E5_FILIAL AND
					  EV_PREFIXO  = E5_PREFIXO AND 
					  EV_NUM = E5_NUMERO AND 
					  EV_PARCELA  = E5_PARCELA AND 
					  EV_TIPO = E5_TIPO AND  
					  'P' = E5_RECPAG AND
  					  %exp:cE5_SEQ% <> E5_SEQ AND					  
					  SE5.%notDel%)
				LEFT JOIN %table:SEZ% SEZ 
				ON  (EV_FILIAL   = EZ_FILIAL AND
					  EV_PREFIXO  = EZ_PREFIXO AND 
					  EV_NUM	  = EZ_NUM AND 
					  EV_PARCELA  = EZ_PARCELA AND 
					  EV_TIPO	  = EZ_TIPO AND
					  EV_CLIFOR   = EZ_CLIFOR AND
					  EV_LOJA     = EZ_LOJA AND
					  EV_NATUREZ  = EZ_NATUREZ AND
					  EV_IDENT	  = EZ_IDENT AND
					  EV_RECPAG	  = EZ_RECPAG AND
					  SEZ.%notDel%)  
				LEFT JOIN %table:SE2% SE2 
				ON  (EV_FILIAL   = E2_FILIAL AND
					  EV_PREFIXO  = E2_PREFIXO AND 
					  EV_NUM	  = E2_NUM AND 
					  EV_PARCELA  = E2_PARCELA AND 
					  EV_TIPO	  = E2_TIPO AND
					  EV_CLIFOR   = E2_FORNECE AND
					  EV_LOJA     = E2_LOJA AND
					  SE2.%notDel%)
				LEFT JOIN %table:CTT% CTT
				ON  (CTT_FILIAL = %xFilial:CTT% AND
					  EZ_CCUSTO  = CTT_CUSTO AND
  					  CTT.%notDel%)						    				  
				LEFT JOIN %table:SED% SED
				ON  ( ED_FILIAL = %xFilial:SED% AND
					  ED_CODIGO  = EV_NATUREZ AND
  					  SED.%notDel%)
			WHERE E5_FILIAL %exp:cSql2% AND  
				E5_CLIFOR  	between %Exp:mv_par01% AND %Exp:mv_par02% AND    
				E5_NUMERO  	between %Exp:mv_par03% AND %Exp:mv_par04% AND    
				E5_PREFIXO 	between %Exp:mv_par05% AND %Exp:mv_par06% AND    
				E5_DATA  	between %Exp:DTOS(mv_par07)% AND %Exp:DTOS(mv_par08)% AND    		
				E5_MULTNAT	= "1" AND 		
				((E5_RECPAG = 'P') OR (E5_TIPODOC = 'ES' AND E5_RECPAG = 'R') OR (E5_TIPO IN (%Exp:cTipoIn%) AND E5_RECPAG = 'R')) AND
				((E5_TIPO NOT IN (%Exp:cTipoIn%) AND E5_TIPODOC <>'ES') OR 	//Baixa de PA
				(E5_TIPO IN (%Exp:MVRECANT%,%Exp:MV_CRNEG%) AND E5_TIPODOC ='ES')) AND			//Estorno da Baixa de RA
			    NOT(E5_RECPAG = 'P' AND E5_TIPO IN (%Exp:MVRECANT%,%Exp:MV_CRNEG%) AND E5_TIPODOC IN ('VL,BA,DC,D2,MT,JR,J2,M2,CM,C2,CX')) AND
				%exp:cSql1%		
				EV_SEQ <> %exp:cEV_SEQ% AND				
				SEV.%notDel% 
			ORDER BY %exp:cOrder%  
			EndSql
		Endif                     
		oBaixas:EndQuery(/*Array com os parametros do tipo Range*/)
		
		oTitsBaixa:SetParentQuery()
		oTitsBaixa:SetParentFilter({|cParam| (cAlias)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) == cParam }, {||(cAlias)->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA)})		
		oTitsBaixa:Cell("EV_NATUREZ"):SetBlock({|| MascNat((cAlias)->EV_NATUREZ) })
		oTitsBxCC:SetParentQuery()
	Endif	

	cAlias1 	:= cAlias
	cAliasSEV	:= cAlias
	cAliasSEZ 	:= cAlias

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da criacao do Filtro do relatorio                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
oReport:SetTotalText(STR0017)		//"T O T A L   G E R A L   ---->  "             

oIncCReceb:SetTotalInLine(.T.)
oIncCPagar:SetTotalInLine(.T.)
oBaixas:SetTotalInLine(.T.)

oIncCReceb   :SetHeaderSection(.T.)	
oTitsIncRcb  :SetHeaderSection(.T.)	
oTitsRecCCust:SetHeaderSection(.T.)	
oTitsIncRcb  :SetLeftMargin(5)
oTitsRecCCust:SetLeftMargin(80)

oIncCPagar   :SetHeaderSection(.T.)	
oTitsIncPag  :SetHeaderSection(.T.)	
oTitsPagCCust:SetHeaderSection(.T.)	
oTitsIncPag  :SetLeftMargin(5)
oTitsPagCCust:SetLeftMargin(80)

oBaixas     :SetHeaderSection(.T.)	
oTitsBaixa  :SetHeaderSection(.T.)	   
oTitsBxCC   :SetHeaderSection(.T.)	
oTitsBaixa  :SetLeftMargin(5)
oTitsBxCC	:SetLeftMargin(80)

If mv_par12 == 2
	cTit  := STR0010 //" - Por Centro de Custo"
Endif


If mv_par11 == 1
	oIncCReceb :Show()
	oTitsIncRcb:Show()

	oIncCPagar :Hide()
	oTitsIncPag:Hide()
	
	oBaixas    :Hide()
	oTitsBaixa :Hide()		

	cTit := STR0003 + cTit + STR0011   //" - Inclusao C.Receber"
	
	oBreak := TRBreak():New(oReport, {||(cAlias1)->(E1_FILIAL)},, .F. )
	TRFunction():New(oIncCReceb:Cell("E1_VALOR" ),/*[ cID ]*/,"SUM", oBreak ,,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.T.)	//"Valor" 
ElseIf mv_par11 == 2
	oIncCReceb :Hide()
	oTitsIncRcb:Hide()

	oIncCPagar :Show() 
	oTitsIncPag:Show()   

	oBaixas    :Hide() 
	oTitsBaixa :Hide()			

	cTit := STR0003 + cTit + STR0012	//" - Inclusao C.Pagar"

	oBreak := TRBreak():New(oReport, {|| (cAlias1)->(E2_FILIAL)},, .F. )
	TRFunction():New(oIncCPagar:Cell("E2_VALOR" ),/*[ cID ]*/,"SUM", oBreak ,,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.T.)	//"Valor" 
Else 
	oIncCReceb :Hide()
	oTitsIncRcb:Hide()
	
	oIncCPagar :Hide() 
	oTitsIncPag:Hide()  

	oBaixas	   :Show()           
	oTitsBaixa :Show()			

	If mv_par11 == 3
		cTit := STR0003 + cTit + STR0013	//" - Baixas C.Receber"
	Else
		cTit := STR0003 + cTit + STR0014	//" - Baixas C.Receber"	
	EndIf  

	oBreak  := TRBreak():New(oReport, {|| (cAlias1)->(E5_FILIAL)},, .F. )
	TRFunction():New(oBaixas:Cell("E5_VALOR" ),/*[ cID ]*/,"SUM", oBreak ,,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.T.)	//"Valor" 
EndIf      
oBreak:SetTotalText({ || STR0016 + cQuebra })	 //"TOTAL FILIAL ---> "   		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(cTit)

If mv_par11 == 1                       
	oIncCReceb	 :SetHeaderPage(.T.)
	oTitsIncRcb  :SetHeaderPage(.T.)
	oTitsRecCCust:SetHeaderPage(.T.)       
	
	oIncCReceb:Cell("E1_VALOR"):SetBlock({|| If(mv_par14==2 .AND. E1_MOEDA>0,Round(NoRound(xMoeda(E1_VALOR,E1_MOEDA,mv_par13,E1_EMISSAO,3),3),2),E1_VALOR)}) //"Emissao"

	oIncCReceb:SetMeter((cAlias)->(LastRec())) 

	oIncCReceb:Init()   
	While !oReport:Cancel() .And. !(cAlias)->(Eof())  	  
		oIncCReceb:PrintLine()            
		If oReport:Cancel()
			Exit
		EndIf

		oTitsIncRcb:Init()   
		Eval(bPosTit)
		While !oReport:Cancel() .And. !(cAlias)->(Eof()) .And. Eval( bWhile )
			
			// Tratamento de Exibicao SEV/SEZ
			SectionDef(@oTitsIncRcb,@oTitsRecCCust,(cAlias)->EV_RATEICC)

			// Imprime a linha
			oTitsIncRcb:PrintLine()

			cQuebra := (cAlias)->E1_FILIAL
			If oReport:Cancel()
				Exit
			EndIf        
			If (cAlias)->(EZ_FILIAL+EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA+EZ_NATUREZ) == cTitulo+(cAlias)->EV_NATUREZ
				cTitNat := (cAlias)->(EV_FILIAL+EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA+EV_NATUREZ)
				oTitsRecCCust:Init()   
				While !(cAlias)->(Eof()) .And. cTitNat == (cAlias)->(EZ_FILIAL+EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA+EZ_NATUREZ)
					
					oTitsRecCCust:PrintLine()
					(cAlias)->(dbSkip())					
				EndDo          
				oTitsRecCCust:Finish()					
			Else
				(cAlias)->(dbSkip()) 
			EndIf                     
		EndDo             
		oTitsIncRcb:Finish()
		oReport:IncMeter()		
		oReport:SkipLine()				     
		oReport:ThinLine()		
	EndDo                  
	oIncCReceb:Finish()      
ElseIf mv_par11 == 2      
	oIncCPagar:Init()
	oIncCPagar:SetHeaderPage(.T.)
	oTitsIncPag:SetHeaderPage(.T.)
	oTitsPagCCust:SetHeaderPage(.T.)     

	oIncCPagar:Cell("E2_VALOR"):SetBlock({|| If(mv_par14==2 .AND. E2_MOEDA>0,Round(NoRound(xMoeda(E2_VALOR,E2_MOEDA,mv_par13,E2_EMIS1,3),3),2),E2_VALOR)}) //"Emissao"

	oIncCPagar:SetMeter((cAlias)->(LastRec())) 

	oIncCPagar:Init()   
	
	While !oReport:Cancel() .And. !(cAlias)->(Eof())  	  
		
		oIncCPagar:PrintLine()            
		
		If oReport:Cancel()
			Exit
		EndIf

		oTitsIncPag:Init()   

		Eval(bPosTit)
		While !oReport:Cancel() .And. !(cAlias)->(Eof()) .And. Eval( bWhile )
			
			// Tratamento de Exibicao SEV/SEZ
			SectionDef(@oTitsIncPag,@oTitsPagCCust,(cAlias)->EV_RATEICC)

			// Imprime a linha
			oTitsIncPag:PrintLine()

			cQuebra := (cAlias)->E2_FILIAL       
			If oReport:Cancel()
				Exit
			EndIf        
			If (cAlias)->(EV_FILIAL+EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA+EZ_NATUREZ) == cTitulo+(cAlias)->EV_NATUREZ
				oTitsPagCCust:Init()
				cTitNat := (cAlias)->(EV_FILIAL+EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA+EV_NATUREZ)
				While !(cAlias)->(Eof()) .And. cTitNat == (cAlias)->(EZ_FILIAL+EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA+EZ_NATUREZ)
					
					oTitsPagCCust:PrintLine()
					(cAlias)->(dbSkip())
				EndDo          
				oTitsPagCCust:Finish()					
			Else
				(cAlias)->(dbSkip()) 
			EndIf
		EndDo             
		oTitsIncPag:Finish()
		oReport:IncMeter()		
		oReport:SkipLine()				     
		oReport:ThinLine()		
	EndDo 
    oIncCPagar:Finish()

Else 

	oBaixas	  :SetHeaderPage(.T.)
	oTitsBaixa:SetHeaderPage(.T.)
	oTitsBxCC :SetHeaderPage(.T.)   
//	oBaixas:Cell("E5_VALOR"):SetBlock({|| If(mv_par14==2 .AND. E2_MOEDA>0,Round(NoRound(xMoeda(E2_VALOR,E2_MOEDA,mv_par13,E2_EMIS1,3),3),2),E2_VALOR)}) //"Emissao"
	oBaixas:SetMeter((cAlias)->(LastRec())) 

	oBaixas:Init()   
	While !oReport:Cancel() .And. !(cAlias)->(Eof()) 
		If	TemBxCanc( (cAlias)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ) ) .OR. (cAlias)->E5_SITUACA == 'C'
			(cAlias)->(dbSkip())
			Loop
		EndIf		
		cQuebra := (cAlias)->E5_FILIAL          		
		If oReport:Cancel()
			Exit
		EndIf	

		oTitsBaixa:Init()   
		Eval(bPosTit)

		If Eval( bWhile )
			oBaixas:PrintLine()
			oReport:SkipLine() 
			oReport:ThinLine()	
			oReport:IncMeter()            
		Endif

		While !oReport:Cancel() .And. !(cAlias)->(Eof()) .And. !(cAlias)->(Eof()) .And. Eval( bWhile )
		
			If oReport:Cancel()
				Exit
			EndIf   
			
			// Tratamento de Exibicao SEV/SEZ
			SectionDef(@oTitsBaixa,@oTitsBxCC,(cAlias)->EV_RATEICC)

			// Imprime a linha
			oTitsBaixa:PrintLine() 

			If (cAlias)->(EZ_FILIAL+EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA+EZ_NATUREZ) == cTitulo+(cAlias)->EV_NATUREZ
				cTitNat := (cAlias)->EZ_FILIAL+EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA+EZ_NATUREZ
				oTitsBxCC:Init()   
				While !(cAlias)->(Eof()) .And. cTitNat == (cAlias)->(EZ_FILIAL+EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA+EZ_NATUREZ)

					oTitsBxCC:PrintLine()					
					(cAlias)->(dbSkip())
				EndDo          
				oTitsBxCC:Finish()	  
			Else                      
				(cAlias)->(dbSkip())
			EndIf       
			
			oReport:SkipLine() 
			oReport:IncMeter()		
		EndDo             
		oTitsBaixa:Finish()		
		oReport:IncMeter()						
		(cAlias)->(dbSkip())		
	EndDo                  
	oBaixas:Finish()       
EndIf      

Return NIL          

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR590  ³ Autor ³ Mauricio Pequim Jr    ³ Data ³ 08.12.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Mapa de Rateios Multipla Naturezas            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR590(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FinR590R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cDesc1 := STR0001 //"Este relatorio ir  imprimir o mapa de rateios de Multipla Natureza e  "
LOCAL cDesc2 := STR0002 //"Multipla Natureza por Centro de Custo"
LOCAL cDesc3 := ""
LOCAL wnrel
LOCAL cString:=""
LOCAL Tamanho := "G"

PRIVATE titulo :=STR0003 //"Mapa de Distribuição de Multiplas Naturezas"
PRIVATE cabec1
PRIVATE cabec2
PRIVATE aReturn := {STR0004, 1,STR0005  , 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE nomeprog:= "FINR590"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   := "FIR590"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIR590",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros     		  					³
//³ mv_par01            Cli/For De   			       					³
//³ mv_par02            Cli/For Ate  			       					³
//³ mv_par03            Titulo De              				 			³
//³ mv_par04            Titulo Ate             							³
//³ mv_par05            Prefixo    De          							³
//³ mv_par06            Prefixo    Ate         							³
//³ mv_par07            Emissao Ate        		    					³
//³ mv_par08            Emissao De             							³
//³ mv_par09            Vencimento De          							³
//³ mv_par10            Vencimento Ate      		   					³
//³ mv_par11            Distribuicao (Inc Receber/Inc Pagar 		³
//³                                   Bx Receber/ Bx Pagar)     	³
//³ mv_par12            Nivel (Mult Nat ou Mult Nat C.Custo      	³
//³ mv_par13            Qual Moeda         			  					³
//³ mv_par14			 	Outras Moedas   ?  								³
//³ mv_par15            Cons.Filiais Abaixo?                      ³
//³ mv_par16            Da Filial    ?                        		³
//³ mv_par17            Ate a Filial ?                           	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "FINR590"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,Tamanho,"",.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

RptStatus({|lEnd| Fa590Imp(@lEnd,wnRel,cString)},titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FA590Imp ³ Autor ³ Mauricio Pequim Jr    ³ Data ³ 08.12.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Mapa de Rateios Multipla Naturezas            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA590Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FA590Imp(lEnd,wnRel,cString)

Local CbCont
Local CbTxt
LOCAL tamanho:="G"
Local cChave
Local cArq
Local cAlias
Local cPrefixo
Local cNumero
Local cParcela
Local cTipo
Local cLoja
Local cCliFor
Local cChaveSEV
Local cChaveSEZ
Local nTotFil		:= 0
Local nTotGer		:= 0	
Local nValor		:= 0 	//Valor do titulo
Local nRegSM0
Local nAtuSM0
Local dEmissao
Local dVencto
Local aStru := SE1->(dbStruct())
Local lContinua := .T.
Local cFilDe
Local cFilAte
Local lAchou := .F.
Local nMoeda	:= 0           
Local nTamSeq	:= TamSX3( "E5_SEQ" )[1]

#IFDEF TOP
	Local nI	:= 0
	Local cQuery
#ELSE
	Local nIndex
	Local cIndex
	Local cFiltro
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag  := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := STR0003 //"Mapa de Distribuição de Multiplas Naturezas"
If mv_par11 > 2  //Rateio de Baixa
	cabec1:= STR0006 //"PRF NUMERO PC  TIPO CLI/FOR              LOJA EMISSAO                      SEQUENCIA                  VALOR DA BAIXA"
Else             //Rateio de Emissao
	cabec1:= STR0007 //"PRF NUMERO PC  TIPO CLI/FOR              LOJA EMISSAO    VENCTO                                         VALOR TITULO"
Endif
If mv_par12 == 2  //MultNat por C.Custo
	cabec2 := STR0008 //"    NATUREZA    %NATUREZA   VALOR NATUREZA        C.CUSTO               %C.CUSTO    VALOR C.CUSTO"
Else
	cabec2 := STR0009 //"    NATUREZA    %NATUREZA   VALOR NATUREZA"
Endif
m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atribui valores as variaveis ref a filiais                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par15 == 2  
	cFilDe  := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
	cFilAte := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
ELSE
	cFilDe := mv_par16	// Todas as filiais
	cFilAte:= mv_par17
Endif

dbSelectArea("SM0")
dbSeek(cEmpAnt+cFilDe,.T.)

nRegSM0 := SM0->(Recno())
nAtuSM0 := SM0->(Recno())
nTotFil := 0

If mv_par12 == 2
	titulo  := titulo+ STR0010 //" - Por Centro de Custo"
Endif

If mv_par11 == 1
	titulo  := titulo+ STR0011 //" - Inclusao C.Receber"
ElseIf mv_par11 == 2
	titulo  := titulo+ STR0012	 //" - Inclusao C.Pagar"
ElseIf mv_par11 == 3
	titulo  := titulo+ STR0013	 //" - Baixas C.Receber"
ElseIf mv_par11 == 4
	titulo  := titulo+ STR0014	 //" - Baixas C.Pagar"
Endif

While !Eof() .and. M0_CODIGO == cEmpAnt .and. IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ) <= cFilAte .and. (MV_MULNATP .or. MV_MULNATR)
	
	dbSelectArea("SE1")
	cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )

	If mv_par11 == 1  //Inclusao C.Receber

		//Filtra SE1 - Distribuicao Mult Nat Inclusao C.Receber

		cAlias := "SE1"	
		dbSelectArea("SE1")
		dbSetOrder(1)
		cChave	:= IndexKey()
		cArq		:= "E1"
		aStru := SE1->(dbStruct())

		#IFDEF TOP
			dbSelectArea("SE1")
			dbSetOrder(2)
			cQuery := " SELECT SE1.* FROM " +RetSqlName("SE1")+" SE1 WHERE"
			cQuery += " E1_FILIAL = '"+xFilial("SE1")+"' AND "
			cQuery += " E1_CLIENTE Between '"+mv_par01+"' AND '"+mv_par02+"' AND "
			cQuery += " E1_NUM     Between '"+mv_par03+"' AND '"+mv_par04+"' AND "
			cQuery += " E1_PREFIXO Between '"+mv_par05+"' AND '"+mv_par06+"' AND "
			cQuery += " E1_EMISSAO Between '"+DTOS(mv_par07)+"' AND '"+DTOS(mv_par08)+"' AND "
			cQuery += " E1_VENCREA Between '"+DTOS(mv_par09)+"' AND '"+DTOS(mv_par10)+"' AND "
			
			If mv_par14 == 2  //Imprime Outras Moedas
				cQuery += " E1_MOEDA = "+Alltrim(Str(mv_par13))+" AND "
			Endif
			cQuery += " E1_MULTNAT = '1' AND "	
			cQuery += " SE1.D_E_L_E_T_ <> '*' "		
		
			cQuery += " ORDER BY " + SqlOrder(cChave)
			cQuery := ChangeQuery(cQuery)
			dbSelectArea("SE1")
			SE1->(dbCloseArea())
			dbSelectArea("SA1")
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE1', .F., .T.)
			For nI := 1 to Len(aStru)
				If aStru[ni,2] != 'C'
					TCSetField('SE1', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
				Endif
			Next
		 
		#ELSE
			dbSelectArea("SE1")
			dbSetOrder(1)
			cFiltro	:= 'E1_FILIAL=="'+xFilial("SE1")+'".and.'
			cFiltro	+= 'E1_CLIENTE>="'+mv_par01+'".And.'
			cFiltro	+= 'E1_CLIENTE<="'+mv_par02+'".And.'
			cFiltro	+= 'E1_NUM>="'+mv_par03+'".And.'
			cFiltro	+= 'E1_NUM<="'+mv_par04+'".and.'
			cFiltro	+= 'E1_PREFIXO>="'+mv_par05+'".And.'
			cFiltro	+= 'E1_PREFIXO<="'+mv_par06+'".And.'
			cFiltro	+= 'DTOS(E1_EMISSAO)>="'+DTOS(mv_par07)+'".and.'
			cFiltro	+= 'DTOS(E1_EMISSAO)<="'+DTOS(mv_par08)+'".and.'
			cFiltro	+= 'DTOS(E1_VENCREA)>="'+DTOS(mv_par09)+'".and.'
			cFiltro	+= 'DTOS(E1_VENCREA)<="'+DTOS(mv_par10)+'".And.'
			cFiltro	+= 'E1_MULTNAT=="1"'
			cIndex	:= CriaTrab(nil,.f.)
			IndRegua("SE1",cIndex,cChave,,cFiltro,STR0015) //"Selecionando Registros..."
			nIndex := RetIndex("SE1")
			DbSelectArea("SE1")
			DbSetIndex(cIndex+OrdBagExt())
			DbSetOrder(nIndex+1)
			DbSeek(xFilial("SE1"))
			DbGoTop()
      #ENDIF

   ElseIf mv_par11 == 2  //Inclusao C.Pagar

		//Filtra SE2 - Distribuicao Mult Nat Inclusao C.Pagar

		cAlias := "SE2"	
		dbSelectArea("SE2")
		dbSetOrder(1)
		cChave	:= IndexKey()
		cArq		:= "E2"
		aStru		:= SE2->(dbStruct())		

		#IFDEF TOP

			cQuery := " SELECT SE2.* FROM " +RetSqlName("SE2")+" SE2 WHERE"
			cQuery += " E2_FILIAL = '"+xFilial("SE2")+"' AND "
			cQuery += " E2_FORNECE Between '"+mv_par01+"' AND '"+mv_par02+"' AND "
			cQuery += " E2_NUM     Between '"+mv_par03+"' AND '"+mv_par04+"' AND "
			cQuery += " E2_PREFIXO Between '"+mv_par05+"' AND '"+mv_par06+"' AND "
			cQuery += " E2_EMIS1   Between '"+DTOS(mv_par07)+"' AND '"+DTOS(mv_par08)+"' AND "
			cQuery += " E2_VENCREA Between '"+DTOS(mv_par09)+"' AND '"+DTOS(mv_par10)+"' AND "
			
			If mv_par14 == 2  //Imprime Outras Moedas
				cQuery += " E2_MOEDA = "+Alltrim(Str(mv_par13))+" AND "
			Endif
			cQuery += " E2_MULTNAT = '1' AND "	
			cQuery += " SE2.D_E_L_E_T_ <> '*' "		
			cQuery += " ORDER BY " + SqlOrder(cChave)
			cQuery := ChangeQuery(cQuery)
			dbSelectArea("SE2")
			SE2->(dbCloseArea())
			dbSelectArea("SA2")
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE2', .F., .T.)
			For ni := 1 to Len(aStru)
				If aStru[ni,2] != 'C'
					TCSetField('SE2', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
				Endif
			Next
		 
		#ELSE
			cFiltro	:= 'E2_FILIAL=="'+xFilial("SE2")+'".and.'
			cFiltro	+= 'E2_FORNECE>="'+mv_par01+'".And.'
			cFiltro	+= 'E2_FORNECE<="'+mv_par02+'".And.'
			cFiltro	+= 'E2_NUM>="'+mv_par03+'".And.'
			cFiltro	+= 'E2_NUM<="'+mv_par04+'".and.'
			cFiltro	+= 'E2_PREFIXO>="'+mv_par05+'".And.'
			cFiltro	+= 'E2_PREFIXO<="'+mv_par06+'".And.'
			cFiltro	+= 'DTOS(E2_EMIS1)>="'+DTOS(mv_par07)+'".and.'
			cFiltro	+= 'DTOS(E2_EMIS1)<="'+DTOS(mv_par08)+'".and.'
			cFiltro	+= 'DTOS(E2_VENCREA)>="'+DTOS(mv_par09)+'".and.'
			cFiltro	+= 'DTOS(E2_VENCREA)<="'+DTOS(mv_par10)+'".And.'
			cFiltro	+= 'E2_MULTNAT=="1"'
			cIndex	:= CriaTrab(nil,.f.)
			IndRegua("SE2",cIndex,cChave,,cFiltro,STR0015) //"Selecionando Registros..."
			nIndex := RetIndex("SE2")
			DbSelectArea("SE2")
			DbSetIndex(cIndex+OrdBagExt())
			DbSetOrder(nIndex+1)
			DbSeek(xFilial("SE2"))
			DbGoTop()
      #ENDIF

   ElseIf mv_par11 == 3 .or. mv_par11 == 4   //Baixas a Receber = 3
   														//Baixas a Pagar = 4

		//Filtra SE5 - Distribuicao Mult Nat Baixa C.Rceber ou C.Pagar
		cAlias := "SE5"	
		dbSelectArea("SE5")
		dbSetOrder(7)
		cChave	:= IndexKey()
		cArq		:= "E5"
		aStru		:= SE5->(dbStruct())

		#IFDEF TOP
			cQuery := " SELECT SE5.* FROM " +RetSqlName("SE5")+" SE5 WHERE"
			cQuery += " E5_FILIAL = '"+xFilial("SE5")+"' AND "
			cQuery += " E5_CLIFOR  Between '"+mv_par01+"' AND '"+mv_par02+"' AND "
			cQuery += " E5_NUMERO  Between '"+mv_par03+"' AND '"+mv_par04+"' AND "
			cQuery += " E5_PREFIXO Between '"+mv_par05+"' AND '"+mv_par06+"' AND "
			cQuery += " E5_DATA    Between '"+DTOS(mv_par07)+"' AND '"+DTOS(mv_par08)+"' AND "
			cQuery += " E5_MULTNAT = '1' AND "	
			If mv_par11 == 3
				cQuery += " ((E5_RECPAG = 'R')"
				cQuery += " OR (E5_TIPODOC = 'ES' AND E5_RECPAG = 'P')"
				cQuery += " OR (E5_TIPO IN ('"+MV_CRNEG+"','"+MVRECANT+"') AND E5_RECPAG = 'P')) AND "
			Endif
			If mv_par11 == 4
				cQuery += " ((E5_RECPAG = 'P')"
				cQuery += " OR  (E5_TIPODOC = 'ES' AND E5_RECPAG = 'R')"
				cQuery += " OR  (E5_TIPO IN " + FormatIn(MV_CPNEG+"|"+MVPAGANT,"|") + " AND E5_RECPAG = 'R')) AND "
			Endif
			cQuery += " SE5.D_E_L_E_T_ <> '*' "		
		
			cQuery += " ORDER BY " + SqlOrder(cChave)
			cQuery := ChangeQuery(cQuery)
			dbSelectArea("SE5")
			SE5->(dbCloseArea())
			dbSelectArea("SA2")
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE5', .F., .T.)
			For ni := 1 to Len(aStru)
				If aStru[ni,2] != 'C'
					TCSetField('SE5', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
				Endif
			Next
		 
		#ELSE
			cFiltro	:= 'E5_FILIAL=="'+xFilial("SE5")+'".and.'
			cFiltro	+= 'E5_CLIFOR>="'+mv_par01+'".And.'
			cFiltro	+= 'E5_CLIFOR<="'+mv_par02+'".And.'
			cFiltro	+= 'E5_NUMERO>="'+mv_par03+'".And.'
			cFiltro	+= 'E5_NUMERO<="'+mv_par04+'".and.'
			cFiltro	+= 'E5_PREFIXO>="'+mv_par05+'".And.'
			cFiltro	+= 'E5_PREFIXO<="'+mv_par06+'".And.'
			cFiltro	+= 'DTOS(E5_DATA)>="'+DTOS(mv_par07)+'".and.'
			cFiltro	+= 'DTOS(E5_DATA)<="'+DTOS(mv_par08)+'".and.'
			cFiltro	+= 'E5_MULTNAT=="1"'
			cIndex	:= CriaTrab(nil,.f.)
			IndRegua("SE5",cIndex,cChave,,cFiltro,STR0015) //"Selecionando Registros..."
			nIndex := RetIndex("SE5")
			DbSelectArea("SE5")
			DbSetIndex(cIndex+OrdBagExt())
			DbSetOrder(nIndex+1)
			DbSeek(xFilial("SE5"))
      #ENDIF
	Endif

	dbSelectArea(cAlias)
	dbGoTop()
	While !Eof()

		If Li >= 58                                                                                              
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,Iif(aReturn[4]==1,15,18))                               
			Li := 9
		EndIf

		cPrefixo := &(cArq+"_PREFIXO")
		cNumero  := &(cArq+Iif(mv_par11 == 1 .or. mv_par11 == 2, "_NUM", "_NUMERO"))
		cParcela := &(cArq+"_PARCELA")
		cTipo		:= &(cArq+"_TIPO")
		cLoja		:= &(cArq+"_LOJA")
  		If mv_par11 == 1		   //C.Receber
			cCliFor   := E1_CLIENTE
			dEmissao  := E1_EMISSAO
			dVencto   := E1_VENCREA	
			nMoeda	  := E1_MOEDA
			cSeq	  := Space(nTamSeq)
			cIdent	:= "1"  //Emissao
			cCarteira := "R"
		ElseIf mv_par11 == 2 	//C.Pagar
			cCliFor  := E2_FORNECE
			dEmissao := E2_EMIS1
			dVencto  := E2_VENCREA	
			nMoeda	:= E2_MOEDA
			cSeq	 := Space(nTamSeq)
			cIdent	:= "1"  //Emissao
			cCarteira := "P"
		Else		               //Baixas
			cCliFor  := E5_CLIFOR
			dEmissao := E5_DATA
			dVencto  := Ctod("//")
			cSeq		:= E5_SEQ
			cIdent	:= "2"  //Baixa
			If mv_par11 == 3  //Bx C.Receber
				cCarteira := "R"
				dbSelectArea("SE1")
				dbSetOrder(1)
				If dbSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo)
					nMoeda := E1_MOEDA
					lContinua := .T.
				Else
					lContinua := .F.
				Endif
			ElseIf mv_par11 == 4
				cCarteira := "P"
				dbSelectArea("SE2")
				dbSetOrder(1)
				If dbSeek(xFilial("SE2")+cPrefixo+cNumero+cParcela+cTipo+cCliFor+cLoja)
					nMoeda := E2_MOEDA
					lContinua := .T.
				Else
					lContinua := .F.
				Endif
			Endif			
		Endif

		dbSelectArea (cAlias)

		//Nao achou correspondente no SE1 ou SE2 quando for baixa
		If !lContinua
			dbSkip()
			Loop
		Else  
			If nMoeda > 0
		      nValor	:= Round(NoRound(xMoeda(&(cArq+"_VALOR"),nMoeda,mv_par13,dEmissao,3),3),2)
		    Else
			    nValor	:= &(cArq+"_VALOR")
		    EndIf  
		Endif	

		//Verifica se imprime a moeda
		If mv_par14 == 2 .and. nMoeda != mv_par13
			dbSkip()
			Loop
		Endif		

		//Verificacoes especificas dos rateios de baixa
		If mv_par11 > 2	

			//Verifica cancelamento de baixas
			If	TemBxCanc(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+	E5_CLIFOR+E5_LOJA+E5_SEQ) .OR. E5_SITUACA == 'C'
				dbSkip()
				Loop
			EndIf

			//Verifica se são movimentos da carteira a Receber
			//Baixa de Adiantamento
			//Estorno de Baixa de adiantamento
			IF mv_par11 == 3 .and. E5_RECPAG != "R"
				If (!(E5_TIPO $ MVRECANT+"/"+MV_CRNEG ) .AND. E5_TIPODOC !="ES") .or. ; //Baixa de RA
					(E5_TIPO $ MVPAGANT+"/"+MV_CPNEG .AND. E5_TIPODOC =="ES")  //Estorno da Baixa de PA
					dbSkip()
					Loop
				Endif
			Endif
	
			//Verifica se são movimentos da carteira a Pagar
			//Baixa de Adiantamento
			//Estorno de Baixa de adiantamento
			IF mv_par11 == 4 .and. E5_RECPAG != "P"
				If (!(E5_TIPO $ MVPAGANT+"/"+MV_CPNEG ) .AND. E5_TIPODOC !="ES") .or.;   //Baixa de PA
					(E5_TIPO $ MVRECANT+"/"+MV_CRNEG .AND. E5_TIPODOC =="ES")  //Estorno da Baixa de RA
					dbSkip()
					Loop
				Endif
			Endif
			
			If mv_par11 == 3 		 // Se for baixa de adiantamentos
				If E5_RECPAG == "R" .and. E5_TIPO $ MVPAGANT+"/"+MV_CPNEG .AND. E5_TIPODOC $ "VL/BA/DC/D2/MT/JR/J2/M2/CM/C2/CX"
					dbskip()
					LOOP
				Endif
			Endif

			If mv_par11 == 4			// Se for baixa de adiantamentos
				If E5_RECPAG == "P" .and. E5_TIPO $ MVRECANT+"/"+MV_CRNEG .AND. E5_TIPODOC $ "VL/BA/DC/D2/MT/JR/J2/M2/CM/C2/CX"
	  				dbskip()
					LOOP
				Endif
			Endif
		Endif

		@Li,000	PSAY cPrefixo
		@Li,004	PSAY cNumero
		@Li,014	PSAY cParcela
		@Li,018	PSAY cTipo
		@Li,023	PSAY cCliFor
		@Li,044	PSAY cLoja
		@Li,049	PSAY dEmissao
		If mv_par11 < 3
			@Li,060  PSAY dVencto
		Endif
		If mv_par11 > 2 //Rateio de Baixas
			@Li,085  PSAY cSeq
		Endif
		@Li,104	PSAY nValor	Picture PesqPict("SE1","E1_SALDO",15)
		Li++

		//Incrementa totais
		nTotFil += nValor
		nTotGer += nValor
		
		//Impressao das Naturezas
		dbSelectArea("SEV")
		dbSetOrder(2)
		cChaveSEV := cPrefixo+cNumero+cParcela+cTipo+cCliFor+cLoja
		If dbSeek(xFilial("SEV")+cChaveSEV)
			While !Eof() .and. SEV->(EV_FILIAL+EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA) == xFilial("SEV")+cChaveSEV

				//Desprezo os estornos e movimentos de outras carteiras
				If SEV->EV_SITUACA $ "X/E" .or.;
					SEV->EV_RECPAG != cCarteira .Or.;
					(!Empty(EV_IDENT)  .And. EV_IDENT != cIdent) .Or.;
					(!Empty(EV_SEQ) .And. !Empty(cSeq) .And. EV_SEQ != cSeq)
					dbSkip()
					Loop
				Endif

				@Li,004	PSAY SEV->EV_NATUREZ
				@Li,019	PSAY (SEV->EV_PERC * 100) PICTURE "@E 999.99"
				@Li,027	PSAY Round(NoRound(xMoeda(SEV->EV_VALOR,nMoeda,mv_par13,dEmissao,3),3),2) Picture PesqPict("SE1","E1_SALDO",15)
            Li++
            
            //Distribuicao de MultNat por C.Custo
				If MV_PAR12 == 2 .and. SEV->EV_RATEICC == "1"
					dbSelectArea("SEZ")
					dbSetOrder(4)					
					cChaveSEZ := cPrefixo+cNumero+cParcela+cTipo+cCliFor+cLoja+SEV->EV_NATUREZ+cIdent+cSeq
					lAchou := .F.
					If dbSeek(xFilial("SEZ")+cChaveSEZ)  //Padrao 8.11
						lAchou := .T.											
					ElseIf (mv_par11 == 1 .or. mv_par11 == 2)  //Padrao 7.10
						cChaveSEZ := cPrefixo+cNumero+cParcela+cTipo+cCliFor+cLoja+SEV->EV_NATUREZ+" "+cSeq
						If dbSeek(xFilial("SEZ")+cChaveSEZ)
							lAchou := .T.
						Endif
					Endif
																												
					If lAchou
						While !Eof() .and. SEZ->(EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA	+EZ_NATUREZ+EZ_IDENT+EZ_SEQ) == cChaveSEZ	
			
							//Desprezo os estornos e movimentos de outras carteiras
							If SEZ->EZ_SITUACA $ "X/E" .or. SEZ->EZ_RECPAG != cCarteira
								dbSkip()
								Loop
							Endif

							@Li,050	PSAY SEZ->EZ_CCUSTO
							@Li,072	PSAY (SEZ->EZ_PERC * 100) PICTURE "@E 999.99"
							@Li,082	PSAY Round(NoRound(xMoeda(SEZ->EZ_VALOR,nMoeda,mv_par13,dEmissao,3),3),2) Picture PesqPict("SE1","E1_SALDO",15)
							Li++
					
							dbSkip()
							Loop
                  Enddo
               Endif
		      Endif
		      dbSelectArea("SEV")
		      dbSkip()
         Enddo
		Endif
		Li++
		@Li,001	PSAY __PrtThinLine()
		Li++
		dbSelectArea(cAlias)	
		dbSkip()
	Enddo
	//Totais da Filial
	//Verifico se base compartilhada ou exclusiva
	If !(Empty(xFilial(cAlias)))
		IF li > 55	
			nAtuSM0 := SM0->(Recno())
			SM0->(dbGoto(nRegSM0))
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_COMP"))
			SM0->(dbGoTo(nAtuSM0))
		EndIF

		@li,000 PSAY STR0016 + cFilAnt		//"T O T A L   F I L I A L ---->  "
		@li,104 PSAY nTotFil        Picture PesqPict("SE1","E1_VALOR",15)
		Li++
		@Li,001	PSAY __PrtThinLine()
		Li++
		nTotFil		:= 0
		dbSelectArea("SM0")
		dbSkip()
   Else
		Exit   	
	Endif
	(cAlias)->(dbCloseArea())
Enddo	

SM0->(dbGoTo(nRegSM0))
cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
IF li != 80
	Li++	
	IF li > 55
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_COMP"))
	EndIF
	@Li,001	PSAY __PrtThinLine()
	Li++
	@li,000	PSAY STR0017 		//"T O T A L   G E R A L   ---->  "
	@li,104	PSAY nTotGer       Picture PesqPict("SE1","E1_VALOR",15)
	Li++
	@Li,001	PSAY __PrtThinLine()
	Roda(cbcont,cbtxt,"G")
EndIF

Set Device To Screen

#IFDEF TOP
	If mv_par11 == 1 	//Inclusão CR
		dbSelectArea("SE1")
		dbCloseArea()
		ChKFile("SE1")
		dbSelectArea("SE1")
		dbSetOrder(1)
	ElseIf mv_par11 == 2 	//Inclusao CP
		dbSelectArea("SE2")
		dbCloseArea()
		ChKFile("SE2")
		dbSelectArea("SE2")
		dbSetOrder(1)
 	Else
		dbSelectArea("SE5")
		dbCloseArea()
		ChKFile("SE5")
		dbSelectArea("SE5")
		dbSetOrder(1)
	Endif	
#ELSE	
	If mv_par11 == 1 	//Inclusão CR
		dbSelectArea("SE1")
		dbClearFil()
		RetIndex( "SE1" )
		If !Empty(cIndex)
			FErase (cIndex+OrdBagExt())
		Endif
		dbSetOrder(1)
	ElseIf mv_par11 == 2 	//Inclusão CP
		dbSelectArea("SE2")
		dbClearFil()
		RetIndex( "SE2" )
		If !Empty(cIndex)
			FErase (cIndex+OrdBagExt())
		Endif
		dbSetOrder(1)
	Else
		dbSelectArea("SE5")
		dbClearFil()
		RetIndex( "SE5" )
		If !Empty(cIndex)
			FErase (cIndex+OrdBagExt())
		Endif
		dbSetOrder(1)
	Endif
#ENDIF

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	Ourspool(wnrel)
Endif
MS_FLUSH()


//-------------------------------------------------------------------
/*/Static Function SectionDef()
Define exibicao das secoes em tela de acordo com parametrizacao

@return nil

@author Leonardo Castro
@since 24/08/2017
@version 12
/*/
//-------------------------------------------------------------------
Static Function SectionDef(oSecSEV,oSecSEZ,cRateiCC)

Local cNivQuebra	:= If( MV_PAR12 == 1, "NATUREZA","CCUSTO" )

oSecSEV:Cell("EV_NATUREZ"):Show()
oSecSEV:Cell("ED_DESCRIC"):Show()
oSecSEV:Cell("EV_PERC"):Show()
oSecSEV:Cell("EV_VALOR"):Show()

If cNivQuebra == "NATUREZA"
	
	oSecSEZ:Cell("EZ_CCUSTO"):Disable()
	oSecSEZ:Cell("EZ_PERC"):Disable()
	oSecSEZ:Cell("EZ_VALOR"):Disable()
	oSecSEZ:Cell("CTT_DESC01"):Disable()

ElseIf cNivQuebra == "CCUSTO"

	If cRateiCC == "1"
		oSecSEZ:Cell("EZ_CCUSTO"):Enable()
		oSecSEZ:Cell("EZ_PERC"):Enable()
		oSecSEZ:Cell("EZ_VALOR"):Enable()
		oSecSEZ:Cell("CTT_DESC01"):Enable()
	Else
		oSecSEZ:Cell("EZ_CCUSTO"):Disable()
		oSecSEZ:Cell("EZ_PERC"):Disable()
		oSecSEZ:Cell("EZ_VALOR"):Disable()
		oSecSEZ:Cell("CTT_DESC01"):Disable()
	EndIf

EndIf

Return
