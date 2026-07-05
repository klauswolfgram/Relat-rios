/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR340.CH"
#Include "PROTHEUS.CH"
#INCLUDE "fwcommand.ch"

#Define I_CORRECAO_MONETARIA         1
#Define I_DESCONTO                   2
#Define I_JUROS                      3
#Define I_MULTA                      4
#Define I_VALOR_RECEBIDO             5
#Define I_VALOR_PAGO                 6
#Define I_RECEB_ANT                  7
#Define I_PAGAM_ANT                  8
#Define I_MOTBX                      9
#Define I_VLACRES                    16
#Define I_VLDECRE                    17

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR340  ³ Autor ³ Paulo Boschetti       ³ Data ³ 01.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±       
±±³Descri‡…o ³ Posicao dos Clientes                                       ³±±  
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR340(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAFIN													  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Mauricio   ³21/11/97³13526 ³ Nao imprimir subtotal com valores zerados³±±
±±³ Mauricio   ³08/12/97³xxxxx ³ Corrigir array de situacao de titulos    ³±±
±±³ Mauricio   ³28/06/98³xxxxx ³ Considerar numero titulos c/12 posicoes  ³±±
±±³ Mauricio   ³02/07/98³xxxxx ³ Alinhar relatorio                        ³±±
±±³ Andreia    ³05/10/98³xxxxx ³ Ajustar lay-out para ativar Set Century  ³±±
±±³ Wagner     ³27/11/98³xxxxx ³ Acerto cabecalho                         ³±±
±±³ Andreia    ³11/01/99³xxxxx ³ Ordenacao por ordem alfabetica.          ³±±
±±³ Julio      ³24.06.99³22201A³ Valores significativos impressos entre   ³±±
±±³            ³        ³      ³ parˆnteses caso Valor < 0                ³±±
±±³ Julio      ³29.07.99³META  ³ Interpretar MV_CRNEG                     ³±±
±±³ Mauricio   ³10/08/99³23192A³ Considerar Cliente/Loja na verificacao   ³±±
±±³            ³        ³      ³ de baixas do titulo.                     ³±±
±±³ Pilar	   ³04/10/99³      ³ Melhoria de Performance                  ³±±
±±³ Julio W	   ³30.11.99³META  ³ Interpretar filtro do usuario            ³±±
±±³ MAURICIO   ³09.12.99³xxxxxx³Corrigir filtro usuario                   ³±±
±±³ Bruno      ³10.02.00³xxxxx ³Corrigir o saldo en moeda > 1 (usar nSaldo³±±
±±³            ³        ³      ³ que ‚ o certo r n„o SE1->E1_SALDO).      ³±±
±±³            ³        ³      ³Substarir nos Subtotais o valor pago, usar³±±
±±³            ³        ³      ³ o ABS na chamada da ImpSubTot().         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR340()

Local oReport
Local aArea := GetArea()   

oReport := ReportDef()
oReport:PrintDialog()

RestArea(aArea)  

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Marcio Menon		   º Data ³  16/08/06  º±±
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
Local cReport 	:= "FINR340"	// Nome do relatorio
Local cDescri 	:= OemToAnsi(STR0001)+ OemToAnsi(STR0002)	//"Este programa ir  emitir a posi‡„o de clientes " "referente a data base do sistema."
Local cTitulo 	:= OemToAnsi(STR0005)	//"Posicao dos Clientes "
Local cPerg		:= "FIN340"	// Nome do grupo de perguntas
Local aOrdem	:= {OemToAnsi(STR0020),OemToAnsi(STR0021)}	//"Por Codigo"###"Por Nome"
Local nTamVal	:= TamSX3("E1_VALOR")[1] + 4
Local lFinr340	:= AllTrim(FUNNAME()) == "FINR340"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := TReport():New(cReport, cTitulo + " - ", cPerg, {|oReport| ReportPrint(oReport, cTitulo)}, cDescri) 

If lFinr340
	pergunte("FIN340",.F.)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // do Cliente                            ³
//³ mv_par02            // Ate o Cliente                         ³
//³ mv_par03            // Da Loja                               ³
//³ mv_par04            // Ate a Loja                            ³
//³ mv_par05            // Da Emissao                            ³
//³ mv_par06            // Ate a Emissao                         ³
//³ mv_par07            // Do Vencimento                         ³
//³ mv_par08            // Ate o Vencimento                      ³
//³ mv_par09            // Imprime os t¡tulos provis¢rios        ³
//³ mv_par10            // Qual a moeda                          ³
//³ mv_par11            // Reajusta pela DataBase ou Vencto      ³
//³ mv_par12            // Considera Faturados                   ³
//³ mv_par13            // Imprime Outras Moedas                 ³
//³ mv_par14            // Considera Data Base                   ³
//³ mv_par15            // Imprime Nome? (Razao Social/N.Reduzid)³
//³ mv_par16            // Natureza De ?                         ³
//³ mv_par17            // Natureza Ate?                         ³
//³ mv_par18            // Considera Liquidados?                 ³
//³ mv_par19            // Cons. Baixas por Recibo?              ³
//³ mv_par20		 	// Consid Filiais  ?  					³
//³ mv_par21		 	// da filial							³
//³ mv_par22		 	// a flial 								³
//³ mv_par23		 	// Seleciona filiais					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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

oReport:SetLandscape() 		//Imprime o relatorio no formato paisagem
//Gestao
oReport:SetUseGC(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                                        ³
//³                      Definicao das Secoes                              ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 01                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport, STR0034,"SA1", aOrdem) //"Dados do Cliente"

TRCell():New(oSection1,"TXTCLI"  ,     , STR0035	,									,10						,/*lPixel*/,{|| STR0015 })	//"Cliente ## CLIENTE : "
TRCell():New(oSection1,"A1_COD"  ,"SA1",  			,PesqPict("SA1","A1_COD" ),TamSX3("A1_COD" )[1],/*lPixel*/,/*CodeBlock*/)
TRCell():New(oSection1,"A1_LOJA" ,"SA1",			,PesqPict("SA1","A1_LOJA"),TamSX3("A1_LOJA")[1],/*lPixel*/,/*CodeBlock*/)
TRCell():New(oSection1,"A1_NOME" ,"SA1",			,PesqPict("SA1","A1_NOME"),TamSX3("A1_NOME")[1],/*lPixel*/,{|| IIF(mv_par15 == 1, SA1->A1_NOME, SA1->A1_NREDUZ) } )

oSection1:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 02                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1, STR0036,{"SE1","SED"}, aOrdem) //"Titulos"

TRCell():New(oSection2,"E1_PREFIXO"	, "SE1"	, STR0037	, PesqPict("SE1","E1_PREFIXO") 	, TamSX3("E1_PREFIXO")[1] 	,/*lPixel*/,{ || SE1->E1_PREFIXO })//"Prf"
TRCell():New(oSection2,"E1_NUM"		, "SE1"	, STR0038 	, PesqPict("SE1","E1_NUM") 	 	, TamSX3("E1_NUM")[1]     	,/*lPixel*/,{ || SE1->E1_NUM})//"Numero"
TRCell():New(oSection2,"E1_PARCELA"	, "SE1"	, STR0039	, PesqPict("SE1","E1_PARCELA")	, TamSX3("E1_PARCELA")[1] 	,/*lPixel*/,{ || SE1->E1_PARCELA})//"PC"
TRCell():New(oSection2,"E1_TIPO"	, "SE1"	,			, PesqPict("SE1","E1_TIPO")    	, TamSX3("E1_TIPO")[1]    	,/*lPixel*/,{ || SE1->E1_TIPO})
TRCell():New(oSection2,"VALOR"		,		, STR0040 	,								, 20						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Valor Original"
TRCell():New(oSection2,"E1_EMISSAO"	, "SE1"	, STR0041 	, PesqPict("SE1","E1_EMISSAO") 	, 10						,/*lPixel*/,{ || SE1->E1_EMISSAO})//"Emissao"
TRCell():New(oSection2,"E1_VENCREA"	, "SE1"	, STR0042 	, PesqPict("SE1","E1_VENCREA") 	, 10						,/*lPixel*/,{ || SE1->E1_VENCREA})//"Vencto"
TRCell():New(oSection2,"BAIXA"		,  	 	, STR0043	, PesqPict("SE1","E1_BAIXA")   	, 10						,/*lPixel*/,/*CodeBlock*/)	//"Baixa"
TRCell():New(oSection2,"DESCON"		,       , STR0044	, Tm(0,13) 						, 11						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Descontos"
TRCell():New(oSection2,"ABATIM"		,       , STR0045	, Tm(0,13) 						, 11						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Abatimentos"
TRCell():New(oSection2,"JUROS"		,       , STR0046	, Tm(0,13) 						, 11						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Juros"
TRCell():New(oSection2,"MULTA"		,       , STR0047	, Tm(0,13) 						, 11						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Multa"
TRCell():New(oSection2,"CMONE"		,       , STR0048	, Tm(0,13) 						, 11						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Corr. Monet."
TRCell():New(oSection2,"VA"			,       , STR0060	, Tm(0,13) 						, 11						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"VA"
TRCell():New(oSection2,"VLRBAIXA"	,       , STR0049	, Tm(0,19) 						, 19						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Valor Baixado"
TRCell():New(oSection2,"RECANTEC"	,       , STR0050	, Tm(0,19) 						, 19						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Rec. Antecip."
TRCell():New(oSection2,"E1_ACRESC"	, "SE1"	, 			, Tm(0,13) 						, 11						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New(oSection2,"E1_DECRESC"	, "SE1"	, 			, Tm(0,13) 						, 11						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New(oSection2,"SALDO"		,       , STR0051	, 								, 20						,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Saldo Atual"
TRCell():New(oSection2,"MOTIVO"		,       , STR0052	, 								, 15						,/*lPixel*/,/*CodeBlock*/) //"Motivo"
TRCell():New(oSection2,"SITUACAO"	,       , STR0053	, 								, 10						,/*lPixel*/,/*CodeBlock*/) //"Situacao"
TRCell():New(oSection2,"E1_PORTADO"	, "SE1"	, STR0054	,								, 03						,/*lPixel*/,{ || SE1->E1_PORTADO })	//"Port."


oSection2:SetHeaderSection(.T.)

//Faz o alinhamento do cabecalho das celulas
oSection2:Cell("DESCON"	 ):SetHeaderAlign("RIGHT")
oSection2:Cell("ABATIM"	 ):SetHeaderAlign("RIGHT")
oSection2:Cell("JUROS"	 ):SetHeaderAlign("RIGHT")
oSection2:Cell("MULTA"	 ):SetHeaderAlign("RIGHT")
oSection2:Cell("CMONE"	 ):SetHeaderAlign("RIGHT")
oSection2:Cell("VA"		 ):SetHeaderAlign("RIGHT")
oSection2:Cell("VLRBAIXA"):SetHeaderAlign("RIGHT")
oSection2:Cell("RECANTEC"):SetHeaderAlign("RIGHT")
oSection2:Cell("SALDO"	 ):SetHeaderAlign("RIGHT")

oSection2:SetLineBreak(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 03                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3 := TRSection():New(oReport, STR0055) //"Totais"

TRCell():New(oSection3,"TXTTOTAL"	,       , STR0055	,						    , Iif(cPaisloc=="MEX",32,21) ,/*lPixel*/,/*CodeBlock*/) //"Totais"	
TRCell():New(oSection3,"E1_NUM"		, "SE1"	, STR0038 	, 						 	, TamSX3("E1_NUM")[1]     	,/*lPixel*/,)//"Numero"
TRCell():New(oSection3,"E1_PARCELA"	, "SE1"	, STR0039	, 							, TamSX3("E1_PARCELA")[1] 	,/*lPixel*/,)//"PC"
TRCell():New(oSection3,"E1_TIPO"	, "SE1"	,			, 						   	, TamSX3("E1_TIPO")[1]    	,/*lPixel*/,)
TRCell():New(oSection3,"VALOR"		,		, STR0040	, PesqPict("SE1","E1_VALOR"), 20 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")//"Valor Original"
TRCell():New(oSection3,"E1_EMISSAO"	, "SE1" , STR0041	, 							, 10 ,/*lPixel*/,/*CodeBlock*/) //"Emissao"
TRCell():New(oSection3,"E1_VENCREA"	, "SE1" , STR0042	,							, 10 ,/*lPixel*/,/*CodeBlock*/) //"Vencto"
TRCell():New(oSection3,"E1_BAIXA"	, "SE1" , STR0043 	, 							, 10 ,/*lPixel*/,/*CodeBlock*/) //"Baixa"
TRCell():New(oSection3,"DESCON"		,       , STR0044 	, Tm(0,13)           	   	, 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Descontos"
TRCell():New(oSection3,"ABATIM"		, 	    , STR0045	, Tm(0,13)              	, 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Abatimentos"
TRCell():New(oSection3,"JUROS"		,       , STR0046	, Tm(0,13)                	, 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Juros"
TRCell():New(oSection3,"MULTA"		,       , STR0047	, Tm(0,13)                	, 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Multa"
TRCell():New(oSection3,"CMONE"		,       , STR0048	, Tm(0,13)                	, 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Corr. Monet."
TRCell():New(oSection3,"VA"			,       , STR0060	, Tm(0,13)                	, 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"VA"
TRCell():New(oSection3,"VLRBAIXA"	,    	, STR0049	, Tm(0,19)                	, 19 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Valor Baixado"
TRCell():New(oSection3,"RECANTEC"	,  	  	, STR0050	, Tm(0,19)					, 19 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	 //"Rec. Antecip."
TRCell():New(oSection3,"E1_ACRESC"	, "SE1" , 			, Tm(0,13)					, 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	 //"Acrescimo"
TRCell():New(oSection3,"E1_DECRESC"	, "SE1" , 			, Tm(0,13) 					, 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Decrescimo"
TRCell():New(oSection3,"SALDO"		, 	    , STR0051	, Tm(0,nTamVal) 			, 20 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	 //"Saldo Atual"

oSection3:SetLineBreak(.T.)
//Oculta as celulas
oSection3:Cell("E1_EMISSAO"):Hide()
oSection3:Cell("E1_VENCREA"):Hide()
oSection3:Cell("E1_BAIXA"  ):Hide()

oSection3:SetLinesBefore(0.5)
oSection3:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 04                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection4 := TRSection():New(oReport, STR0057) //"Totais/Filial"

TRCell():New(oSection4,"TXTTOTAL"	,       , STR0055	,							, 54 ,/*lPixel*/,/*CodeBlock*/) //"Totais"
TRCell():New(oSection4,"E1_NUM"		, "SE1"	, STR0038 	, 						 	, TamSX3("E1_NUM")[1]     	,/*lPixel*/,)//"Numero"
TRCell():New(oSection4,"E1_PARCELA"	, "SE1"	, STR0039	, 							, TamSX3("E1_PARCELA")[1] 	,/*lPixel*/,)//"PC"
TRCell():New(oSection4,"E1_TIPO"	, "SE1"	,			, 						   	, TamSX3("E1_TIPO")[1]    	,/*lPixel*/,)
TRCell():New(oSection4,"VALOR"	   	,		, STR0040 	, PesqPict("SE1","E1_VALOR"), 20 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")//"Valor Original"
TRCell():New(oSection4,"E1_EMISSAO"	, "SE1" , STR0041	, 							, 10 ,/*lPixel*/,/*CodeBlock*/) //"Emissao"
TRCell():New(oSection4,"E1_VENCREA"	, "SE1" , STR0042	,							, 10 ,/*lPixel*/,/*CodeBlock*/) //"Vencto"
TRCell():New(oSection4,"E1_BAIXA"	, "SE1" , STR0043 	, 							, 10 ,/*lPixel*/,/*CodeBlock*/) //"Baixa"
TRCell():New(oSection4,"DESCON" 	,       , STR0044 	, Tm(0,13)                  , 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Descontos"
TRCell():New(oSection4,"ABATIM" 	, 	   	, STR0045	, Tm(0,13)                  , 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Abatimentos"
TRCell():New(oSection4,"JUROS" 		,       , STR0046	, Tm(0,13)                  , 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Juros"
TRCell():New(oSection4,"MULTA" 		,       , STR0047	, Tm(0,13)                  , 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Multa"
TRCell():New(oSection4,"CMONE" 		,       , STR0048	, Tm(0,13)                  , 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Corr. Monet."
TRCell():New(oSection4,"VA" 		,       , STR0060	, Tm(0,13)                  , 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"VA"
TRCell():New(oSection4,"VLRBAIXA"	,    	, STR0049	, Tm(0,19)                  , 19 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Valor Baixado"
TRCell():New(oSection4,"RECANTEC" 	,  	  	, STR0050	, Tm(0,19)					, 19 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	 //"Rec. Antecip."
TRCell():New(oSection4,"E1_ACRESC"	, "SE1" , 			, Tm(0,13) 					, 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	 //"Acrescimo"
TRCell():New(oSection4,"E1_DECRESC"	, "SE1" , 			, Tm(0,13) 					, 11 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT") //"Decrescimo"
TRCell():New(oSection4,"SALDO" 		, 	   	, STR0051	, Tm(0,nTamVal)				, 15 ,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	 //"Saldo Atual"

oSection4:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint ºAutor³ Marcio Menon       º Data ³  16/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime o objeto oReport definido na funcao ReportDef.     º±±                                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ oReport - Objeto TReport do relatorio                      º±±
±±º          ³ cTitulo - Titulo do relatorio										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport,cTitulo)

Local oSection1 := oReport:Section(1) 
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(2)//oReport:Section(1):Section(1):Section(1)
Local oSection4 := oReport:Section(3)//oReport:Section(1):Section(1):Section(1):Section(1)
Local nOrdem	:= oReport:Section(1):GetOrder()
Local lTotGer   := .F.
Local nTit1		:= 0
Local nTit2		:= 0
Local nTit3		:= 0
Local nTit4		:= 0
Local nTit5		:= 0
Local nTit6		:= 0
Local nTit7		:= 0
Local nTit8		:= 0
Local nTit9		:= 0
Local nTit10	:= 0
Local nTit11	:= 0
Local nTit12	:= 0
Local nTot1		:= 0
Local nTot2		:= 0
Local nTot3		:= 0
Local nTot4		:= 0
Local nTot5		:= 0
Local nTot6		:= 0
Local nTot7		:= 0
Local nTot8		:= 0
Local nTot9		:= 0
Local nTot10	:= 0
Local nTot11	:= 0
Local nTot12	:= 0
Local nTotAbat	:= 0
Local cForAnt	:= Space(6)
Local lContinua	:= .T.
Local aValor	:= {0,0,0,0,0,0,0,0," ",0,0,0,0,0,0,0,0,0,0,0}				   
Local nSaldo	:= 0
Local nMoeda	:= mv_par10
Local dDataMoeda := dDataBase
Local ndecs		:= Msdecimais(mv_par10)
Local cMotivo	:= " "
Local aMotBx	:= {}
Local nValor	:= 0
Local nPos		:= 0
Local cAliasSA1 := "SA1"
Local cSitCobr  := " "
Local cCond1	:= ""
Local cCond2	:= ""
Local cChave	:= ""
Local cIndex	:= ""
Local cChaveE1	:= ""
Local cChaveE2	:= ""
Local cTipoant	:= ""
Local ntotaltipo:= 0
Local i			:= 0
Local nTotFil1	:= 0
Local nTotFil2	:= 0
Local nTotFil3	:= 0
Local nTotFil4	:= 0
Local nTotFil5	:= 0
Local nTotFil6	:= 0
Local nTotFil7	:= 0
Local nTotFil8	:= 0
Local nTotFil9	:= 0
Local nTotFil10	:= 0
Local nTotFil11	:= 0
Local nTotFil12	:= 0
Local lCancelado:= .F.
Local aFiliais	:= {}           
Local lVerFil	:= .F.
Local nInc		:= 0
Local cFilOld	:= cFilAnt
Local lSai		:= .F.
Local aCelulas	:= aClone(oReport:aSection[1]:aCell[4]:oParent:aSection[1]:aCell)    
Local nX		:= 0
Local cFilSmo	:= ""
Local lCS		:= .T. 
Local lPI		:= .T. 
Local lCF		:= .T.
Local cSeek		:= ""
Local lMVGlosa	:= SuperGetMv("MV_GLOSA",.F.,.F.)
Local lIRGlosa	:= .T.
Local lISGlosa	:= .T.
Local lINGlosa	:= .T.
Local nVlrGlosa := 0
Local nRecnoSE1 := 0 
//Gestao
Local cFilAtu 	:= cFilAnt
Local lGestao   := ( FWSizeFilial() > 2 ) 	// Indica se usa Gestao Corporativa
Local lSE1Excl  := Iif( lGestao, FWModeAccess("SE1",1) == "E", FWModeAccess("SE1",3) == "E")
Local lSE5Excl  := Iif( lGestao, FWModeAccess("SE5",1) == "E", FWModeAccess("SE5",3) == "E")
Local lQuery 	:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
Local aSelFil 	:= {}
//Local aSm0		:= {}
Local nLenFil	:= 0 
Local lSE1Comp  := FWModeAccess("SE1",3)== "C" // Verifica se SE1 é compartilhada
Local lSE5Comp  := FWModeAccess("SE5",3)== "C" // Verifica se SE5 é compartilhada
Local aStru		:= SE1->(dbStruct())
Local ni		:= 0		
Local cOrder	:= ""	
Local cFiltSA1	:= oReport:Section(1):GetSqlExp("SA1")
Local cFiltSE1	:= oReport:Section(1):GetSqlExp("SE1")
Local nTamVal 	:= TAMSX3("E1_VALOR")[1] + 4
Local aAreaSE5	:= {}
Local nValAcess	:= 0
Local lExistVlAc:= ExistFunc('FValAcess')
Local lFxLoadFK6:= ExistFunc('FxLoadFK6')
Local cOriSql   := iif( !(cPaisLoc $ "BRA|ARG") .and. FindFunction('OriSqlCob'),OriSqlCob(),"")
Private nRegSM0 := SM0->(Recno())
Private nAtuSM0 := SM0->(Recno())
Private cFilDe	:= ""
Private cFilAte := ""

//Gestao
If lQuery
	If mv_par23 == 1 .and. (lSE1Excl .or. lSE5Excl)	//filial nao totalmente compartilhada    
		If  FindFunction("AdmSelecFil")
			If !IsBlind()
				AdmSelecFil("FIN340",23,.F.,@aSelFil,"SE1",.F.)
			Else
				If FindFunction("GetParAuto")
					aRetAuto := GetParAuto("FINR340TestCase") 
					aSelFil  := aRetAuto
				EndIf
		   EndIf
		Else
			If !IsBlind()
				aSelFil := AdmGetFil(.F.,.F.,"SE1")
			Else
				If FindFunction("GetParAuto")
					aRetAuto := GetParAuto("FINR340TestCase") 
					aSelFil  := aRetAuto
				EndIf
			EndIf
		Endif
		If Empty(aSelFil)
			Aadd(aSelFil,cFilAnt)
		Endif
	
		aSM0 := FR340AbreSM0(aSelFil)
	
	Else
		aSM0 := AdmAbreSM0()
	Endif	

	SM0->(DbGoTo(nRegSM0))

Else
	aSM0 := AdmAbreSM0()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicoes da secao 2. (Titulos)		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2:Cell("VALOR"	 	):SetBlock( { || SayValor(xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,nMoeda,SE1->E1_EMISSAO,,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0)),nTamVal,;
								 									( SE1->E1_TIPO $ MVRECANT + "," + MV_CRNEG ),nDecs, oReport:nDevice) } )
oSection2:Cell("BAIXA"	 	):SetBlock( { || If(dDataBase >= SE1->E1_BAIXA .Or. (mv_par14 == 2 .And. !Empty(SE1->E1_BAIXA)), IIF(!Empty(SE1->E1_BAIXA),SE1->E1_BAIXA," "), ) } )
oSection2:Cell("DESCON"	 	):SetBlock( { || aValor[I_DESCONTO] 			} )
oSection2:Cell("ABATIM"	 	):SetBlock( { || nTotAbat 						} )
oSection2:Cell("JUROS"	 	):SetBlock( { || aValor[I_JUROS] 				} )		
oSection2:Cell("MULTA"	 	):SetBlock( { || aValor[I_MULTA] 				} )
oSection2:Cell("CMONE"	 	):SetBlock( { || aValor[I_CORRECAO_MONETARIA]	} )
oSection2:Cell("VA"		 	):SetBlock( { || nValAcess 				} )
oSection2:Cell("VLRBAIXA"	):SetBlock( { || aValor[I_VALOR_RECEBIDO] 		} )				
oSection2:Cell("RECANTEC"	):SetBlock( { || aValor[I_RECEB_ANT] 			} )
oSection2:Cell("E1_ACRESC"  ):SetBlock( { || SE1->E1_ACRESC - aValor[I_VLACRES]	} )
oSection2:Cell("E1_DECRESC" ):SetBlock( { || SE1->E1_DECRESC - aValor[I_VLDECRE]				} )
oSection2:Cell("SALDO"	 	):SetBlock( { || SayValor(nSaldo,nTamVal,SE1->E1_TIPO $ MVRECANT+","+MV_CRNEG,nDecs)	} )
oSection2:Cell("MOTIVO"	 	):SetBlock( { || Pad(aValor[I_MOTBX],15)		} )
oSection2:Cell("SITUACAO"	):SetBlock( { || cSitCobr 						} )

oSection2:Cell("DESCON"	 	):Picture( TM(aValor[I_DESCONTO]			,13	,nDecs	))
oSection2:Cell("ABATIM"	 	):Picture( TM(nTotAbat						,13	,nDecs	))
oSection2:Cell("JUROS"	 	):Picture( TM(aValor[I_JUROS]				,13	,nDecs	))
oSection2:Cell("MULTA"	 	):Picture( TM(aValor[I_MULTA]				,13	,nDecs	))
oSection2:Cell("CMONE"	 	):Picture( TM(aValor[I_CORRECAO_MONETARIA]	,13	,nDecs	))
oSection2:Cell("VA"		 	):Picture( TM(nValAcess						,13	,nDecs	))
oSection2:Cell("VLRBAIXA"	):Picture( TM(aValor[I_VALOR_RECEBIDO]		,17	,nDecs	))
oSection2:Cell("RECANTEC"	):Picture( TM(aValor[I_RECEB_ANT]			,17	,nDecs	))
oSection2:Cell("E1_ACRESC"	):Picture( TM(SE1->E1_ACRESC				,13	,nDecs	))
oSection2:Cell("E1_DECRESC"	):Picture( TM(SE1->E1_DECRESC				,13	,nDecs	))

oSection2:SetHeaderPage()	//Define o cabecalho da secao como padrao

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicoes da secao 3.	(Totais)	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If oReport:nDevice == 4
	oSection3:Cell("E1_NUM"    ):Hide()
	oSection3:Cell("E1_PARCELA"):Hide()
	oSection3:Cell("E1_TIPO"   ):Hide()
Else 
	oSection3:Cell("E1_NUM"    ):Disable()
	oSection3:Cell("E1_PARCELA"):Disable()
	oSection3:Cell("E1_TIPO"   ):Disable()
EndIf 

oSection3:Cell("TXTTOTAL"	):SetBlock( { || If (!lTotGer, OemToAnsi(STR0016), OemToAnsi(STR0017)) } )	//"Totais : " ### "TOTAL GERAL : "
oSection3:Cell("VALOR"	 	):SetBlock( { || If (!lTotGer, nTit1, nTot1  	) } )
oSection3:Cell("DESCON"	 	):SetBlock( { || If (!lTotGer, nTit2, nTot2  	) } )
oSection3:Cell("ABATIM"	 	):SetBlock( { || If (!lTotGer, nTit3, nTot3  	) } )				
oSection3:Cell("JUROS"	 	):SetBlock( { || If (!lTotGer, nTit4, nTot4  	) } )
oSection3:Cell("MULTA"	 	):SetBlock( { || If (!lTotGer, nTit5, nTot5  	) } )
oSection3:Cell("CMONE"	 	):SetBlock( { || If (!lTotGer, nTit6, nTot6  	) } )
oSection3:Cell("VA"	 		):SetBlock( { || If (!lTotGer, nTit12, nTot12  	) } )
oSection3:Cell("VLRBAIXA"	):SetBlock( { || If (!lTotGer, nTit7, nTot7  	) } )
oSection3:Cell("RECANTEC"	):SetBlock( { || If (!lTotGer, nTit8, nTot8  	) } )
oSection3:Cell("SALDO"	 	):SetBlock( { || If (!lTotGer, nTit9, nTot9  	) } )
oSection3:Cell("E1_ACRESC"	):SetBlock( { || If (!lTotGer, nTit10, nTot10	) } )
oSection3:Cell("E1_DECRESC"	):SetBlock( { || If (!lTotGer, nTit11, nTot11	) } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicoes da secao 4.	(Totais/Filial)³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If oReport:nDevice == 4 
	oSection4:Cell("E1_NUM"    ):Hide()
	oSection4:Cell("E1_PARCELA"):Hide()
	oSection4:Cell("E1_TIPO"   ):Hide()
	oSection4:Cell("E1_EMISSAO"):Hide()
	oSection4:Cell("E1_VENCREA"):Hide()
	oSection4:Cell("E1_BAIXA"  ):Hide()
Else 
	oSection4:Cell("E1_NUM"    ):Disable()
	oSection4:Cell("E1_PARCELA"):Disable()
	oSection4:Cell("E1_TIPO"   ):Disable()
	oSection4:Cell("E1_EMISSAO"):Disable()
	oSection4:Cell("E1_VENCREA"):Disable()
	oSection4:Cell("E1_BAIXA"  ):Disable()
EndIf 

oSection4:Cell("TXTTOTAL"	):SetBlock( { || STR0058 +" "+Iif( ((lQuery .or. mv_par20==1) .and. lSE1Excl ),Alltrim(cFilSm0),"")})  //"T O T A L   F I L I A L ----> " 
oSection4:Cell("VALOR"	 	):SetBlock( { || nTotFil1  } )
oSection4:Cell("DESCON"	 	):SetBlock( { || nTotFil2  } )
oSection4:Cell("ABATIM"	 	):SetBlock( { || nTotFil3  } )				
oSection4:Cell("JUROS"	 	):SetBlock( { || nTotFil4  } )
oSection4:Cell("MULTA"	 	):SetBlock( { || nTotFil5  } )
oSection4:Cell("CMONE"	 	):SetBlock( { || nTotFil6  } )
oSection4:Cell("VA"	 		):SetBlock( { || nTotFil12 } )
oSection4:Cell("VLRBAIXA"	):SetBlock( { || nTotFil7  } )
oSection4:Cell("RECANTEC"	):SetBlock( { || nTotFil8  } )
oSection4:Cell("SALDO"	 	):SetBlock( { || nTotFil9  } )
oSection4:Cell("E1_ACRESC"  ):SetBlock( { || nTotFil10 } )
oSection4:Cell("E1_DECRESC"	):SetBlock( { || nTotFil11 } )


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ POR MAIS ESTRANHO QUE PARE€A, ESTA FUNCAO DEVE SER CHAMADA AQUI! ³
//³                                                                  ³
//³ A fun‡„o SomaAbat reabre o SE1 com outro nome pela ChkFile para  ³
//³ efeito de performance. Se o alias auxiliar para a SumAbat() n„o  ³
//³ estiver aberto antes da IndRegua, ocorre Erro de & na ChkFile,   ³
//³ pois o Filtro do SE1 uptrapassa 255 Caracteres.                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Select("__SE1") == 0
	ChkFile("SE1",.F.,"__SE1")
Else
	DbSelectArea("__SE1")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defini‡„o dos cabe‡alhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par10 == 0
	SetMVValue("FIN340","MV_PAR10",1)
	pergunte("FIN340",.F.)
EndIf

cTitulo := oReport:Title() + " " + GetMv("MV_MOEDA"+Str(mv_par10,1)) 
oReport:SetTitle(cTitulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atribui valores as variaveis ref a filiais                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Gestao
If lQuery .And. !Empty(aSelFil)
	cFilDe  := aSelFil[1]
	cFilAte := aSelFil[Len(aSelFil)]
Else
	If mv_par20 == 2
		cFilDe  := cFilAnt
		cFilAte := cFilAnt
	Else
		cFilDe := mv_par21	// Todas as filiais
		cFilAte:= mv_par22
	Endif
Endif

aFiliais := FinRetFil()

oReport:NoUserFilter()

For nInc := 1 To Len( aSM0 )
   cFilSm0 :=	""
   If aSM0[nInc][1] == cEmpAnt .AND. (aSM0[nInc][2] >= cFilDe .and. aSM0[nInc][2] <= cFilAte)
   
   		oSection1:Init()
   
		cFilAnt := aSM0[nInc][2]
		cFilSm0 :=	aSM0[nInc][2] + ' - ' + aSM0[nInc][7]

		dbSelectArea("SE1")
		If nOrdem == 1
			dbSetOrder(2)
			cChave := IndexKey()
			dbSeek(xFilial("SE1")+mv_par01+mv_par03,.T.)
			cCond1 := "SE1->E1_CLIENTE+SE1->E1_LOJA <= '"+mv_par02+mv_par04+"' .and. SE1->E1_FILIAL == '"+xFilial("SE1")+"'"
			cCond2 := "SE1->E1_CLIENTE+SE1->E1_LOJA"
			cOrder := SqlOrder(cChave)
		Else
			If MV_PAR15=1
				cChave  := "E1_FILIAL+E1_NOMCLI+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO"
			Else
				cChave  := "E1_FILIAL+E1_NOMCLI+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO"
			EndIf

			If TCSrvType() == "AS/400"
				cIndex	:= CriaTrab(nil,.f.)
				dbSelectArea("SE1")
				IndRegua("SE1",cIndex,cChave,,FR340FIL(),OemToAnsi(STR0022))  //"Selecionando Registros..."
				nIndex	:= RetIndex("SE1")  								
				dbSetOrder(nIndex+1)
			Else
				cOrder := SqlOrder(cChave)
			EndIf

			cCond1 := ".T."
			cCond2 := "SE1->E1_NOMCLI+SE1->E1_CLIENTE+SE1->E1_LOJA"
			SE1->(dbGoTop())
		EndIf
	
		oReport:SetMeter(SE1->(LastRec()))
	
		If TcSrvType() != "AS/400"

			If Select("NEWSE1") > 0
				dbSelectArea("NEWSE1")
				dbCloseArea()
			Endif
			ChkFile("SE1",.F.,"NEWSE1")

			dbSelectArea("SE1")
			aStru := dbStruct()

			// Montagem do SELECT apenas com os campos necessarios ao relatorio
			cQuery := "SELECT DISTINCT "
	
			if nOrdem == 1
				cQuery += " SE1.E1_FILIAL, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_NOMCLI, "
			else
				cQuery += " SE1.E1_FILIAL, SE1.E1_NOMCLI, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, "		
			endif

			cQuery += " SE1.E1_NATUREZ, SE1.E1_SITUACA, SE1.E1_PORTADO, SE1.E1_SALDO, SE1.E1_MOEDA, SE1.E1_RECIBO, SE1.E1_ORIGEM, "		
			cQuery += " SE1.E1_EMISSAO, SE1.E1_VENCREA, SE1.E1_BAIXA, SE1.E1_FATURA, SE1.E1_DTFATUR, SE1.E1_VALLIQ," 		
			cQuery += " SE1.E1_VALOR,SE1.E1_SDACRES,SE1.E1_SDDECRE,SE1.E1_TXMOEDA,SE1.E1_ACRESC,SE1.E1_DECRESC,SE1.R_E_C_N_O_ RECNO, "
			cQuery += " SE1.E1_INSS, SE1.E1_CSLL, SE1.E1_COFINS, SE1.E1_PIS, SE1.E1_IRRF, SE1.E1_ISS, SE1.E1_DTVARIA, "				
			if cPaisLoc == "RUS"
				cQuery += "SE1.E1_CONUNI, "
			endif
			cQuery += " SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_NREDUZ, SE1.E1_FILORIG, SE1.E1_VENCTO, SE1.E1_TITPAI  "
        
			For nx := 1 To Len(aCelulas)
				If !(aCelulas[nX]:cName $ cQuery) .And. (Substr(aCelulas[nX]:cName,1,2) == "E1" .Or. Substr(aCelulas[nX]:cName,1,2) == "A1")  .And. aCelulas[nX]:cType <> "M" 
					If Substr(aCelulas[nX]:cName,1,2) == "E1"						
						cQuery += ",SE1." + aCelulas[nX]:cName + " "							
					Else
						cQuery += ",SA1." + aCelulas[nX]:cName + " "
					EndIf
				EndIf													
			Next nX
		
			cQuery += " FROM " + RetSqlName("SE1") +" SE1 " 

			cQuery += " JOIN " + RetSQLName("SE5") + " SE5 "
			If lSE5Comp
				cQuery += "   ON  SE5.E5_FILORIG  = '" + cFilAnt + "' AND "
			Else
				cQuery += "   ON  SE5.E5_FILIAL  = '" + xFilial("SE5") + "' AND "
			EndIf
			cQuery += "       SE5.E5_PREFIXO = SE1.E1_PREFIXO AND "
			cQuery += "       SE5.E5_NUMERO  = SE1.E1_NUM     AND "
			cQuery += "       SE5.E5_PARCELA = SE1.E1_PARCELA AND "
			cQuery += "       SE5.E5_TIPO    = SE1.E1_TIPO   AND "
			cQuery += "       SE5.E5_MOTBX   <> 'DSD'        AND "
			cQuery += "       (SE5.E5_RECPAG  = 'R'            OR  "
			cQuery += "       (SE5.E5_RECPAG  = 'P'            AND "
			cQuery += "        SE5.E5_TIPO  = '"+MV_CRNEG+"')) AND "
			
			If mv_par18 == 2
				cQuery += "    SE5.E5_MOTBX   <> 'LIQ'        AND "
			EndIf
				
			cQuery += "       SE5.D_E_L_E_T_ = ' ' "
			cQuery += " JOIN " + RetSqlName("SA1") + " SA1 " 
			cQuery += "   ON  SA1.A1_FILIAL = '" + xFilial("SA1") + "' AND " 
			cQuery += "       SA1.A1_COD = SE1.E1_CLIENTE AND "
			cQuery += "       SA1.A1_LOJA = SE1.E1_LOJA  AND "
			cQuery += "       SA1.D_E_L_E_T_ = ' ' "

			cQuery += " WHERE SE1.E1_FILIAL = '" + xFilial("SE1") + "' "                                   
			cQuery += " AND SE1.E1_CLIENTE between '" + mv_par01        + "' AND '" + mv_par02       + "'"
			cQuery += " AND SE1.E1_LOJA    between '" + mv_par03        + "' AND '" + mv_par04       + "'"
			cQuery += " AND SE1.E1_EMISSAO between '" + DTOS(mv_par05)  + "' AND '" + DTOS(mv_par06) + "'"
			cQuery += " AND SE1.E1_VENCREA between '" + DTOS(mv_par07)  + "' AND '" + DTOS(mv_par08) + "'"
			cQuery += " AND SE1.E1_TIPO NOT LIKE '%-' "
			cQuery += " AND SE1.E1_EMISSAO <=  '"     + DTOS(dDataBase) + "'"
			cQuery += " AND SE1.E1_NATUREZ between '" + mv_par16        + "' AND '" + mv_par17       + "'"
			If cPaisLoc<>"BRA"
				cQuery += "AND SE1.E1_TIPO<>'CH' AND SE1.E1_TIPO<>'TF'"
			EndIf
			If mv_par09 == 2
				cQuery += " AND SE1.E1_TIPO <> '"+MVPROVIS+"'"
			EndIf
			If mv_par12 == 2
				cQuery += " AND SE1.E1_FATURA IN('"+Space(Len(E1_FATURA))+"','NOTFAT') "
			Endif
		
			If mv_par19 == 2
				cQuery += "AND (( SE1.E1_RECIBO <> '"+Space(Len(SE1->E1_RECIBO))+"'"
				cQuery += "AND (SE1.E1_ORIGEM = 'FINA087A' "+cOriSql+" )) OR (SE1.E1_RECIBO = '"+Space(Len(SE1->E1_RECIBO))+"') )"
			Endif
			
			If mv_par18 == 2 //Considera Liquidados, 1=SIM, 2=NÃO -> 2 não imprimi os títulos que foram liquidados.
				cQuery += " AND SE1.E1_SALDO > 0  " 
			EndIf
			
			cQuery += " AND SE1.D_E_L_E_T_ = ' '"

			//Adiciono filtro do usuario na Query
			If !Empty(cFiltSA1)
				cQuery += " AND (" + cFiltSA1 + ") "
			EndIf
		
			//Adiciono filtro do usuario na Query
			If !Empty(cFiltSE1)
				cQuery += " AND (" + cFiltSE1 + ") "
			EndIf

			cQuery2 := " UNION SELECT "
	
			if nOrdem == 1
				cQuery2 += " SE1.E1_FILIAL, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_NOMCLI, "
			else
				cQuery2 += " SE1.E1_FILIAL, SE1.E1_NOMCLI, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, "		
			endif

			cQuery2 += " SE1.E1_NATUREZ, SE1.E1_SITUACA, SE1.E1_PORTADO, SE1.E1_SALDO, SE1.E1_MOEDA, SE1.E1_RECIBO, SE1.E1_ORIGEM, "		
			cQuery2 += " SE1.E1_EMISSAO, SE1.E1_VENCREA, SE1.E1_BAIXA, SE1.E1_FATURA, SE1.E1_DTFATUR, SE1.E1_VALLIQ," 		
			cQuery2 += " SE1.E1_VALOR,SE1.E1_SDACRES,SE1.E1_SDDECRE,SE1.E1_TXMOEDA,SE1.E1_ACRESC,SE1.E1_DECRESC,SE1.R_E_C_N_O_ RECNO, "
			cQuery2 += " SE1.E1_INSS, SE1.E1_CSLL, SE1.E1_COFINS, SE1.E1_PIS, SE1.E1_IRRF, SE1.E1_ISS, SE1.E1_DTVARIA, "				
			if cPaisLoc == "RUS"
				cQuery2 += "SE1.E1_CONUNI, "
			endif
			cQuery2 += " SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_NREDUZ, SE1.E1_FILORIG, SE1.E1_VENCTO, SE1.E1_TITPAI  "

			For nx := 1 To Len(aCelulas)
				If !(aCelulas[nX]:cName $ cQuery2) .And. (Substr(aCelulas[nX]:cName,1,2) == "E1" .Or. Substr(aCelulas[nX]:cName,1,2) == "A1") .And. aCelulas[nX]:cType <> "M"
					If Substr(aCelulas[nX]:cName,1,2) == "E1"
						cQuery2 += ",SE1." + aCelulas[nX]:cName + " "						
					Else
						cQuery2 += ",SA1." + aCelulas[nX]:cName + " "
					EndIf
				EndIf													
			Next nX

			cQuery += cQuery2

			cQuery += " FROM " + RetSqlName("SE1") +" SE1 " 

			cQuery += " JOIN " + RetSqlName("SA1") + " SA1 " 
			cQuery += "   ON  SA1.A1_FILIAL = '" + xFilial("SA1") + "' AND " 
			cQuery += "       SA1.A1_COD = SE1.E1_CLIENTE AND "
			cQuery += "       SA1.A1_LOJA = SE1.E1_LOJA  AND "
			cQuery += "       SA1.D_E_L_E_T_ = ' ' "
			If lSE1Comp
				cQuery += " WHERE SE1.E1_FILORIG = '" + cFilAnt + "' "
			Else
				cQuery += " WHERE SE1.E1_FILIAL = '" + xFilial("SE1") + "' "
			EndIf                            
			cQuery += " AND SE1.E1_CLIENTE between '" + mv_par01        + "' AND '" + mv_par02       + "'"
			cQuery += " AND SE1.E1_LOJA    between '" + mv_par03        + "' AND '" + mv_par04       + "'"
			cQuery += " AND SE1.E1_EMISSAO between '" + DTOS(mv_par05)  + "' AND '" + DTOS(mv_par06) + "'"
			cQuery += " AND SE1.E1_VENCREA between '" + DTOS(mv_par07)  + "' AND '" + DTOS(mv_par08) + "'"
			cQuery += " AND SE1.E1_TIPO NOT LIKE '%-' "
			cQuery += " AND SE1.E1_TIPO NOT LIKE 'RA' "
			cQuery += " AND SE1.E1_EMISSAO <=  '"     + DTOS(dDataBase) + "'"
			cQuery += " AND SE1.E1_NATUREZ between '" + mv_par16        + "' AND '" + mv_par17       + "'"
			If cPaisLoc<>"BRA"
				cQuery += "AND SE1.E1_TIPO<>'CH' AND SE1.E1_TIPO<>'TF'"
			EndIf
			If mv_par09 == 2
				cQuery += " AND SE1.E1_TIPO <> '"+MVPROVIS+"'"
			EndIf
			If mv_par12 == 2
				cQuery += " AND SE1.E1_FATURA IN('"+Space(Len(E1_FATURA))+"','NOTFAT') "
			Endif
		
			If mv_par19 == 2
				cQuery += "AND (( SE1.E1_RECIBO <> '"+Space(Len(SE1->E1_RECIBO))+"'"
				cQuery += "AND (SE1.E1_ORIGEM = 'FINA087A' "+cOriSql+" )) OR (SE1.E1_RECIBO = '"+Space(Len(SE1->E1_RECIBO))+"') )"
			Endif
			
			If mv_par18 == 2 //Considera Liquidados, 1=SIM, 2=NÃO -> 2 não imprimi os títulos que foram liquidados.
				cQuery += " AND SE1.E1_SALDO > 0  " 
			EndIf

			cQuery += " AND SE1.D_E_L_E_T_ = ' '"

			//Adiciono filtro do usuario na Query
			If !Empty(cFiltSA1)
				cQuery += " AND (" + cFiltSA1 + ") "
			EndIf
		
			//Adiciono filtro do usuario na Query
			If !Empty(cFiltSE1)
				cQuery += " AND (" + cFiltSE1  + ") "
			EndIf

			cQuery += " ORDER BY " + cOrder
			
			cQuery := ChangeQuery(cQuery)
		
			dbSelectArea("SE1")
			dbCloseArea()
		
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE1', .T., .T.)
			
			For ni := 1 to Len(aStru)
				If aStru[ni,2] != 'C' .and. FieldPos(aStru[ni,1]) > 0
					TCSetField('SE1', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
				Endif
			Next nI
		
			//Desabilita o filtro no tratamento da Printline()
			oReport:NoUserFilter()

			If (SE1->(EOF()))
				lContinua := .F.
			Else
				lContinua := .T.
			EndIf
			cAliasSA1 := "SE1"
		EndIf
	
		While SE1->(!Eof()) .And. lContinua .And. &cCond1 .And. !oReport:Cancel()
		
			If oReport:Cancel()
				lContinua := .F.
				Exit
			EndIf	
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Considera filtro do usuario                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If TcSrvType() != "AS/400"
				dbSelectArea("NEWSE1")
				dbGoto(SE1->RECNO)
			Endif
		
			dbSelectArea("SE1")	
		
			nCont := 1
			nTit1 := nTit2 := nTit3 := nTit4 := nTit5 := nTit6 := nTit7 := nTit8 := nTit9 := nTit10 := nTit11 := nTit12 := 0
			cForAnt := &cCond2
			
			oSection2:Init()
		
			While &cCond2 == cForAnt .And. lContinua .And. &cCond1 .And. !Eof()
			
				If oReport:Cancel()
					lContinua := .F.
					Exit
				EndIf	
				
				oReport:IncMeter()
		
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Considera filtro do usuario                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If TcSrvType() != "AS/400"
					dbSelectArea("NEWSE1")
					dbGoto(SE1->RECNO)
				EndIf
	
				If !Fr340Skip("SE1")
					dbSelectArea("SE1")
					dbSkip()
					Loop
				EndIf
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime os dados dos clientes.                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea("SA1")
				dbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA)
			  	If nCont = 1
			   		oSection1:Init()
			   		If xFilial("SA1")+A1_COD+A1_LOJA <> xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA // para casos em que o Inti() desposiciona a tabela
			   			dbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA)
			   		EndIf
			   		oSection1:PrintLine()
					oSection1:Finish()
					nCont++
				EndIf
	
				dbSelectArea("SE1")
			
				IF mv_par11 == 1
					dDataMoeda	:=	dDataBase
				Else
					dDataMoeda	:=	SE1->E1_VENCREA
				Endif
				
				aValor := Baixas(SE1->E1_NATUREZ,SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,nMoeda,"R",SE1->E1_CLIENTE,dDataBase,SE1->E1_LOJA,,,,mv_par14 == 1, @lCancelado)
						
				DbSelectArea("SE5")
				DbSetOrder(2)
				
				If DbSeek(xFilial("SE5") + "VM" + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO + DtoS(SE1->E1_DTVARIA) + SE1->E1_CLIENTE + SE1->E1_LOJA ) //E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+DtoS(E5_DATA)+E5_CLIFOR+E5_LOJA+E5_SEQ 			
					If !(alltrim(SE1->E1_TIPO) $ MVRECANT+"/"+MVPAGANT+"/"+MV_CRNEG+"/"+MV_CPNEG) .AND. SE5->E5_TIPODOC $ ("VM") .AND. (aValor[I_CORRECAO_MONETARIA] == 0)
						lNaoConv := (nMoeda == 1 .And.(cPaisLoc=="BRA".Or.Empty(E5_BANCO)).or.( nMoeda==Val( SE5->E5_MOEDA) .And. cPaisLoc<>"BRA" .And. !Empty(E5_BANCO)) )
						aValor[I_CORRECAO_MONETARIA]+=Iif(lNaoConv, SE5->E5_VALOR,xMoeda(Iif(cpaisLoc=="BRA", SE5->E5_VLMOED2, SE5->E5_VALOR),Iif(!Empty(SE5->E5_MOEDA) .And. cPaisLoc<>"BRA",Val(SE5->E5_MOEDA),SE1->E1_MOEDA),IIf( nMoeda == NIL , 1 , nMoeda ),SE5->E5_DATA,,Iif(SE5->E5_TXMOEDA > 0, SE5->E5_TXMOEDA,)))
					EndIf
				EndIf				
				
				If lCancelado
					SE1->( DbSkip() )
					Loop
				EndIf			
				
			    // Indica se deve checar outras filiais   
				lVerFil := (!Empty(xFilial("SE1")) .And. !Empty(xFilial("SE5")) .And. Len(aFiliais) > 1)
	                                                                             
				// Caso o titulo tenha baixa e a mesma nao conste para a filial corrente (vetor aValor acima), verifica se existem baixas em oturas filiais
				If lVerFil .And. !Empty(SE1->E1_BAIXA) .And. aValor[11] == 0 
					F340VerBxFil( @aValor, aFiliais, nMoeda )
				EndIf
	
				If mv_par14 == 1 .AND. Empty(SE1->E1_TITPAI) 
					nSaldo := SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,nMoeda,dDataMoeda,,SE1->E1_LOJA,,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))
					// Verifica se existem compensacoes em outras filiais para descontar do saldo, pois a SaldoTit() verifica
					// somente as movimentacoes da filial corrente.

					If lVerFil .And. nSaldo > 0
						nSaldo -= Round(NoRound(xMoeda(FRVlCompFil("R",SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_CLIENTE,SE1->E1_LOJA,,aFiliais),;
										SE1->E1_MOEDA,mv_par10,dDataMoeda,ndecs+1,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0) ),;
										nDecs+1),nDecs)
					EndIf
				Else
					nSaldo := IiF((SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE) > 0,xMoeda((SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE),SE1->E1_MOEDA,mv_par10,,,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0)),0)
				Endif

				lPI       := .T.
				lCF       := .T.
				lCS       := .T.
				lIRGlosa  := .T.
				lISGlosa  := .T.
				lINGlosa  := .T.
				nVlrGlosa := 0

				If SE1->E1_VALOR <> SE1->E1_VALLIQ .Or. SE1->(E1_CSLL+E1_COFINS+E1_PIS+E1_IRRF+E1_INSS) > 0
					nTotAbat := SomaAbat ( SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, "R", nMoeda )
					If Select("SE1new") == 0
						ChkFile("SE1",.F.,"SE1new")// Gerado um novo Alias para nao desposicionar o ponteiro
					Else                            // do Alias atual (SE1).
						DbSelectArea("SE1new")
					EndIf
					
					SE1new->(DbSetOrder(1))
					SE1new->(DbSeek(xFilial("SE1")+ SE1->E1_PREFIXO+ SE1->E1_NUM+ SE1->E1_PARCELA))
					
					Iif(SE1new->(Found()), cSeek := xFilial()+ SE1new->E1_PREFIXO+ SE1new->E1_NUM+;
					SE1new->E1_PARCELA+ SE1new->E1_CLIENTE+ SE1new->E1_LOJA, cSeek :="")
					
					//-- Quando MV_BR10925 = 1(na Baixa) a funcao SomaAbat nao considera PCC pois os titulos ainda nao foram gerados,
					//-- por isto feito o controle abaixo.
					Do While !Eof() .And.;
						cSeek == xFilial()+ SE1new->E1_PREFIXO+ SE1new->E1_NUM+;
						SE1new->E1_PARCELA+ SE1new->E1_CLIENTE+ SE1new->E1_LOJA
						//-- Verifico se ja foi realizado titulos de abatimento para o PCC(PIS, COFINS, CSLL)
						//-- Se sim nao sera somado o PCC novamente a variavel nTotAbat
						//-- Controle usado quando MV_BR10925 = 2(na Emissao).
						If "PI-"$SE1new->E1_TIPO // PIS
							lPI := .F.
						ElseIf "CF-"$SE1new->E1_TIPO // COFINS
							lCF := .F.
						ElseIf "CS-"$SE1new->E1_TIPO // CSLL
							lCS := .F.
						ElseIf lMVGlosa .And. Mv_Par14 == 1
							If "IR-"$SE1new->E1_TIPO // IRRF
								lIRGlosa := .F.
							ElseIf "IS-"$SE1new->E1_TIPO // ISS
								lISGlosa := .F.
							ElseIf "IN-"$SE1new->E1_TIPO // INSS
								lINGlosa := .F.
							EndIf
						EndIf

						SE1new->(DbSkip())
					Enddo
					SE1new->(DbCloseArea())// Fecho o novo Alias para o SE1 pois nao sera usado depois.					
					//-- Somo abaixo PCC dependendo se houve ou nao os titulos de abatimentos do PCC, a funcao SomaAbat somente
					//-- considera o PCC na Emissao e coluna Abatimentos do relatorio ficava errado considerando somente
					//-- o IRRF.
					Iif (lPI , nTotAbat := nTotAbat + SE1->E1_PIS, 	nTotAbat := nTotAbat + 0)
					Iif (lCF , nTotAbat := nTotAbat + SE1->E1_COFINS, 	nTotAbat := nTotAbat + 0)
					Iif (lCS , nTotAbat := nTotAbat + SE1->E1_CSLL, 	nTotAbat := nTotAbat + 0)

					If lMvGlosa .And. Mv_Par14 == 1
						Iif (lIRGlosa , nVlrGlosa += SE1->E1_IRRF, nVlrGlosa += 0 )
						Iif (lISGlosa , nVlrGlosa += SE1->E1_ISS , nVlrGlosa += 0 )
						Iif (lINGlosa , nVlrGlosa += SE1->E1_INSS, nVlrGlosa += 0 )
					EndIf

				Else
					nTotAbat := 0
				EndIf	

				If !(SE1->E1_TIPO $ MVRECANT+"/"+MV_CRNEG) .And. ;
				   !( MV_PAR14 == 2 .And. nSaldo == 0 ) // nao deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo
				   If !lMVGlosa .Or. Mv_Par14 == 1
						nSaldo -= nTotAbat + nVlrGlosa
					EndIf
				EndIf

				// Subtrai decrescimo para recompor o saldo na data escolhida.
				If Str(SE1->E1_VALOR,17,2) == Str(nSaldo,17,2) .And. SE1->E1_DECRESC > 0 .And. SE1->E1_SDDECRE == 0
					nSaldo -= SE1->E1_DECRESC
				Endif
				// Soma Acrescimo para recompor o saldo na data escolhida.
				If Str(SE1->E1_VALOR,17,2) == Str(nSaldo,17,2) .And. SE1->E1_ACRESC > 0 .And. SE1->E1_SDACRES == 0
					nSaldo += SE1->E1_ACRESC
				Endif
				
				//Calculo valor VA
				nValacess	:= 0 
				If SE1->E1_SALDO <>  SE1->E1_VALOR //Sofreu baixa
					aAreaSE5	:= SE5->(GetArea())		
				
					DbSelectArea("SE5")
					DBSetOrder(2) //E5_FILIAL, 	E5_TIPODOC, E5_PREFIXO, E5_NUMERO, 			E5_PARCELA, 	E5_TIPO, 		E5_DATA, E5_CLIFOR, E5_LOJA, E5_SEQ, R_E_C_N_O_, D_E_L_E_T_
					SE5->( dbGoTop() )
					If SE5->(DBSeek(xFilial("SE5") + "VA" + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO + Dtos(SE1->E1_BAIXA) + SE1->E1_CLIENTE + SE1->E1_LOJA))
						nValAcess := IIf(lFxLoadFK6,FxLoadFK6("FK1",SE5->E5_IDORIG,"VA")[1,2],0)
					Endif
					
					RestArea(aAreaSE5)	

					//Acréscimo e decréscimo é apresentando enquanto não for baixado.
					//Depois de baixado o acréscimo está em juros e o decréscimo em desconto 
					If aValor[I_VLACRES] > 0 
						aValor[I_JUROS] := aValor[I_VLACRES]
					EndIf 			 
					
					If aValor[I_VLDECRE] > 0 
						aValor[I_DESCONTO] := aValor[I_VLDECRE]
					EndIf 	

				Else
					nValAcess := IIf(lExistVlAc,FValAcess(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_CLIENTE,SE1->E1_LOJA,SE1->E1_NATUREZ, Iif(Empty(SE1->E1_BAIXA),.F.,.T.),"","R",DDataBase),0)
					nSaldo	+= nValAcess					
				Endif				
				
				//Descricao da Situacao de cobranca			
				cSitCobr := Capital(FN022SITCB(SE1->E1_SITUACA)[9])

				If !(SE1->E1_TIPO $ MVRECANT+"/"+MV_CRNEG)
					nTit1 += xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,nMoeda,SE1->E1_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))
					nTit7 += aValor[I_VALOR_RECEBIDO]
					nTit9 += nSaldo
				Else
					nTit1 -= xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,nMoeda,SE1->E1_EMISSAO,ndecs+1,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))
					nTit7 -= aValor[I_VALOR_RECEBIDO]
					nTit9 -= nSaldo
				EndIf
			
				nTit2 += (aValor[I_DESCONTO])
				nTit3 += nTotAbat
				nTit4 += aValor[I_JUROS]
				nTit5 += aValor[I_MULTA]
				nTit6 += aValor[I_CORRECAO_MONETARIA]
				nTit8 += aValor[I_RECEB_ANT]
				//Acréscimo e decréscimo é apresentando enquanto não for baixado.
				//Depois de baixado o acréscimo está em juros e o decréscimo em desconto
				nTit10 += SE1->E1_ACRESC - aValor[I_VLACRES]	
			    nTit11 += SE1->E1_DECRESC - aValor[I_VLDECRE] 
			    nTit12 += nValAcess   				
		
				If cPaisLoc <> "BRA"
					cMotivo := SE1->E1_TIPO+"   "+ Substr(aValor[I_MOTBX],1,10)
	    	  		nvalor  := xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,nMoeda,SE1->E1_EMISSAO,,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))
					nPos    := aScan(aMotBx,{|X| x[1]== cMotivo})
			
					If nPos > 0
			   		 	aMotBx[nPos][2] += nvalor
					Else
		   				Aadd(aMotBx,{cMotivo,nvalor})
					Endif	
				EndIf
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime os titulos dos clientes.                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
				//oSection2:Init()
				nRecnoSE1 := SE1->(RECNO)
				DbChangeAlias("SE1","SE1QRY")
				DbChangeAlias("__SE1","SE1")
				SE1->(DbGoto(nRecnoSE1))
				oSection2:PrintLine()
				DbChangeAlias("SE1","__SE1")
				DbChangeAlias("SE1QRY","SE1")
	
				dbSelectArea("SE1")
				dbSkip()
			EndDo
		
			oSection2:Finish()
			oSection1:Finish()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime os totais.						                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oSection3:Init()
	
			If ( ABS(nTit1)+ABS(nTit2)+ABS(nTit3)+ABS(nTit4)+ABS(nTit5)+;
			     ABS(nTit6)+ABS(nTit7)+ABS(nTit8)+ABS(nTit9)+ABS(nTit10)+ABS(nTit11)+ABS(nTit12) > 0 )
	        	
				nTot1  += nTit1
				nTot2  += nTit2
				nTot3  += nTit3
				nTot4  += nTit4
				nTot5  += nTit5
				nTot6  += nTit6
				nTot7  += nTit7
				nTot8  += nTit8
				nTot9  += nTit9
				nTot10 += nTit10
				nTot11 += nTit11
				nTot12 += nTit12
				
				nTotFil1  += nTit1
				nTotFil2  += nTit2
				nTotFil3  += nTit3
				nTotFil4  += nTit4
				nTotFil5  += nTit5
				nTotFil6  += nTit6
				nTotFil7  += nTit7
				nTotFil8  += nTit8			
				nTotFil9  += nTit9
				nTotFil10 += nTit10
				nTotFil11 += nTit11
				nTotFil12 += nTit12
	
				oSection3:PrintLine()
			EndIf		
			oSection3:Finish()
			oReport:ThinLine()
		EndDo
	
		SE1->(DbCloseArea())			
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprimir TOTAL por filial somente quan-³
		//³ do houver mais do que 1 filial.        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (lQuery .or. mv_par20 == 1) .and. Len( aSM0 ) > 1
			oSection4:Init()  
			oSection4:PrintLine()
			oSection4:Finish()
			oReport:ThinLine()
		Endif

		Store 0 To nTotFil1,nTotFil2,nTotFil3,nTotFil4,nTotFil5,nTotFil6,nTotFil7,nTotFil8,nTotFil9,nTotFil10,nTotFil11,nTotFil12
	EndIf

Next nInc

cFilAnt := cFilOld

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o Total Geral.					                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lTotGer := .T.	

oSection3:Init()
oSection3:PrintLine()
oSection3:Finish()

If cPaisLoc <> "BRA"
	oSection3:Cell("DESCON"	 ):Disable()
	oSection3:Cell("ABATIM"	 ):Disable()
	oSection3:Cell("JUROS"	 ):Disable()
	oSection3:Cell("MULTA"	 ):Disable()
	oSection3:Cell("CMONE"	 ):Disable()
	oSection3:Cell("VA"		 ):Disable()
	oSection3:Cell("VLRBAIXA"):Disable()
	oSection3:Cell("RECANTEC"):Disable()
	oSection3:Cell("SALDO"	 ):Disable()
	oSection3:Init()
	oReport:PrintText(OemToAnsi(STR0027))		//"TOTAL POR MOTIVO : "

	For i := 1 to Len(aMotBx)
		If cTipoant==" "
	   	cTipoant:=subs(aMotBX[i][1],1,3)
		Endif
		If  ctipoant	== subs(aMotBX[i][1],1,3)
			oSection3:Cell("TXTTOTAL"):SetBlock( { || aMotBX[i] [1] } )
			oSection3:Cell("VALOR"	 ):SetBlock( { || aMotBX[i] [2] } )
			oSection3:Cell("VALOR"	 ):Picture(PesqPict("SE1","E1_VALOR",14,MV_PAR10))
			oSection3:PrintLine()
			ntotaltipo += aMotBX[i] [2] 
			ctipoant	  := subs(aMotBX[i][1],1,3)
		else 
			oSection3:Cell("TXTTOTAL"):SetBlock( { || OemToAnsi(STR0016) + ctipoant } )
			oSection3:Cell("VALOR"	 ):SetBlock( { || ntotaltipo } )
			oSection3:Cell("VALOR"	 ):Picture(PesqPict("SE1","E1_VALOR",14,MV_PAR10))
			ntotaltipo := 0
			oSection3:PrintLine()
			oReport:PrintText("")
			oSection3:Cell("TXTTOTAL"):SetBlock( { || aMotBX[i] [1] } )
			oSection3:Cell("VALOR"	 ):SetBlock( { || aMotBX[i] [2] } )
			oSection3:Cell("VALOR"	 ):Picture(PesqPict("SE1","E1_VALOR",14,MV_PAR10))
			oSection3:PrintLine()
			ntotaltipo += aMotBX[i] [2] 
			ctipoant   := subs(aMotBX[i][1],1,3)
		Endif				
	Next i
	oSection3:Cell("TXTTOTAL"):SetBlock( { || OemToAnsi(STR0016) + ctipoant } )
	oSection3:Cell("VALOR"	 ):SetBlock( { || ntotaltipo } )
	oSection3:Cell("VALOR"	 ):Picture(PesqPict("SE1","E1_VALOR",14,MV_PAR10))
	oSection3:PrintLine()
	oSection3:Finish()
EndIf

//Gestao
If lQuery
	If TcSrvType() != "AS/400"
		If Select("NEWSE1") > 0
			dbSelectArea("NEWSE1")
			dbCloseArea()		
		Endif
		dbSelectArea("SE1")
		dbCloseArea()
		ChkFile("SE1")
		dbSelectArea("SE1")
		dbSetOrder(1)
	Else
		dbSelectArea("SE1")
		dbClearFil()
		RetIndex( "SE1" )
		If !Empty(cIndex)
			FErase (cIndex+OrdBagExt())
		EndIf
		dbSetOrder(1)
	EndIf
Else
	dbSelectArea("SE1")
	dbClearFil()
	RetIndex( "SE1" )
	If !Empty(cIndex)
		FErase (cIndex+OrdBagExt())
	Endif
	dbSetOrder(1)
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³FR340FIL  ³ Autor ³ Andreia           	³ Data ³ 11.01.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Monta Indregua para impressao do relat¢rio				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FR340FIL()
Local cString

cString := 'E1_FILIAL="'+xFilial()+'".And.'
cString += 'dtos(E1_EMISSAO)>="'+dtos(mv_par05)+'".and.dtos(E1_EMISSAO)<="'+dtos(mv_par06)+'".And.'
cString += 'dtos(E1_VENCREA)>="'+dtos(mv_par07)+'".and.dtos(E1_VENCREA)<="'+dtos(mv_par08)+'".And.'
cString += 'E1_CLIENTE>="'+mv_par01+'".and.E1_CLIENTE<="'+mv_par02+'".And.'
cString += 'E1_LOJA>="'+mv_par03+'".and.E1_LOJA<="'+mv_par04+'".and.'
cString += 'E1_NATUREZ>="'+mv_par16+'".and.E1_NATUREZ<="'+mv_par17+'"'
If cPaisLoc<>"BRA"
	cString +='.and. !(E1_TIPO$"TF~CH")'
EndIf

Return cString

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³SayValor  ³ Autor ³ J£lio Wittwer    	    ³ Data ³ 24.06.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Retorna String de valor entre () caso Valor < 0			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR340.PRX												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function SayValor(nNum,nTam,lInvert,nDecs, nTipImp)
Local cPicture,cRetorno
cPicture := tm(nNum,nTam,nDecs)
If nTipImp == 4
	cRetorno := nNum
Else
	cRetorno := Transform(nNum,cPicture)
EndIf
IF nNum<0 .or. lInvert
	cPicture := tm(nNum,nTam-2,nDecs)
	cRetorno := Transform(nNum,cPicture)
   cRetorno := Right(Space(10)+"("+Alltrim(StrTran(cRetorno,"-",""))+")",nTam+1)
Endif
Return cRetorno

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³Fr340Skip ³ Autor ³ Pilar S. Albaladejo	³ Data ³ 13.10.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Pula registros de acordo com as condicoes (AS 400/CDX/ADS)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR340.PRX												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Fr340Skip()

Local lRet := .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se esta dentro dos parametros                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF SE1->E1_CLIENTE < mv_par01 .OR. SE1->E1_CLIENTE > mv_par02 .OR. ;
	SE1->E1_LOJA    < mv_par03 .OR. SE1->E1_LOJA    > mv_par04 .OR. ;
	SE1->E1_EMISSAO < mv_par05 .OR. SE1->E1_EMISSAO > mv_par06 .OR. ;
	SE1->E1_VENCREA < mv_par07 .OR. SE1->E1_VENCREA > mv_par08 .OR. ;
	SE1->E1_NATUREZ < mv_par16 .OR. SE1->E1_NATUREZ > mv_par17 .OR. ;
	SE1->E1_TIPO $ MVABATIM
	lRet := .F.
	
ElseIF SE1->E1_EMISSAO > dDataBase
	lRet := .F.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o t¡tulo ‚ provis¢rio                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ElseIf (SE1->E1_TIPO $ MVPROVIS .and. mv_par09==2)
	lRet := .F.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o t¡tulo foi aglutinado em uma fatura            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ElseIf !Empty(SE1->E1_FATURA) .and. Substr(SE1->E1_FATURA,1,6) != "NOTFAT"
	lRet := IIF(mv_par12 == 1, .T., .F.)	// Considera Faturados = mv_par12
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se deve imprimir outras moedas³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Elseif mv_par13 == 2 // nao imprime
	If SE1->E1_MOEDA != mv_par10 //verifica moeda do campo=moeda parametro
		lRet	:= .F.
	Endif
Endif

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ F340VerBxFil ºAutor ³ Gustavo Henrique º Data ³  21/04/09  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Verifica se existem baixas em outras filiais para o titulo º±±
±±º          ³ posicionado para impressao.                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro - Relatorio Posicao Clientes                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F340VerBxFil( aValor, aFiliais, nMoeda )

Local aTmpValor := {}
Local nX		:= 0
Local nY		:= 0

// Pesquisa baixas do titulo em outras filiais
For nX := 1 To Len(aFiliais)
	If aFiliais[nX] <> SE1->E1_FILIAL
		AAdd( aTmpValor, Baixas(SE1->E1_NATUREZ,SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,nMoeda,"R",SE1->E1_CLIENTE,dDataBase,SE1->E1_LOJA,aFiliais[nX],,,mv_par14 == 1) )
	EndIf	
Next nX                                       

// Atualiza valores das baixas em outras filiais no vetor definitivo aValor
For nX := 1 To Len(aTmpValor)
	For nY := 1 To Len(aValor)
		If nY <> 9	// Nao soma historico de baixa
			aValor[nY] += aTmpValor[nX,nY]
		EndIf	
	Next nY
Next nX                                                                    

// Para impressao, guarda o historico da primeira baixa encontrada
If Empty( aValor[9] )
	For nX := 1 To Len( aTmpValor )
		If !Empty( aTmpValor[ nX , 9 ] )
			aValor[ 9 ] := aTmpValor[ nX , 9 ]
			Exit
		EndIf
	Next nX
EndIf

aSize( aTmpValor , 0 )
aTmpValor := Nil

Return( aValor )

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

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Finr340Val³ Autor ³ Karen Honda           ³ Data ³ 01/03/13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Validação no pergunte Ordem Nome para ambiente não TOP, não ³±±
±±³realiza ordenação pelo Nome Fantasia                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Finr340                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr340Val()
Local lRet := .T.
#IFNDEF TOP
	If (Mv_par15 == 2 )
		lRet := .F.
		MsgAlert(STR0059) //"Opção válida somente para ambiente TOP!"
	EndIf	
#ENDIF

Return lRet                      


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FR340AbreSM0³ Autor ³ Mauricio Pequim Jr  ³ Data ³ 02/10/13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna um array com as informacoes das filias das empresas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FR340AbreSM0(aSelFil)               

Local aArea			:= SM0->( GetArea() )
Local aRetSM0		:= {}
Local nLaco			:= 0
			
aRetSM0	:= FWLoadSM0()

If Len(aRetSM0) != Len(aSelFil)

	For nLaco := Len(aRetSM0) To 1 Step -1
		cFilx := aRetSm0[nLaco,2]
		nPosFil := Ascan(aSelFil,aRetSm0[nLaco,2])
	
		If nPosFil == 0
			ADel(aRetSM0,nLaco)
			aSize(aRetSM0, Len(aRetSM0)-1)
		Endif
	Next nLaco
Endif

aSort(aRetSm0,,,{ |x,y| x[2] < y[2] } )
RestArea( aArea )

Return aClone(aRetSM0)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±                                                                         ±±
±±            Funcoes retiradas do arquivo FINXFUN.PRX                     ±±
±±                                                                         ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡„o    ³ U_BuscaMoeda ( )                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Autor     ³ Antonio Maniero Jr.                      ³ Data ³ 19.05.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o ³ Procura Qual e a moeda de uma titulo baixado no SE1 ou SE2 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ Gen‚rico                                                   ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function BuscaMoeda()
LOCAL cSavArea:=Alias()
LOCAL nMoeda:=0
LOCAL nSavOrd:=0

If SE5->E5_RECPAG == "R"
	dbSelectArea("SE1")
Else
	dbSelectArea("SE2")
Endif
nSavOrd := IndexOrd()   // Guarda ordem do SE1/SE2
dbSetOrder(1)
If dbSeek(cFilial+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+Iif(E5_RECPAG=="R","",E5_CLIFOR)))
	If SE5->E5_RECPAG == "R"
		nMoeda:=E1_MOEDA
	Else
		nMoeda:=E2_MOEDA
	Endif
Endif
dbSetOrder(nSavOrd)   // Restaura ordem do SE1/SE2
dbSelectArea(cSavArea)
Return nMoeda 

