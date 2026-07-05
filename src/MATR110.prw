/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR110.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

Static nPAJ_MSBLQL	:= SAJ->(FieldPos("AJ_MSBLQL"))
Static cPicA2_CEP	:= PesqPict("SA2","A2_CEP")
Static cPicA2_CGC	:= PesqPict("SA2","A2_CGC")
Static cUserId   	:= RetCodUsr()
Static lLGPD		:= FindFunction("SuprLGPD") .And. SuprLGPD()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR110  ³ Autor ³ Alexandre Inacio Lemes³ Data ³06/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pedido de Compras e Autorizacao de Entrega                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR110(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico SIGACOM                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr110( cAlias, nReg, nOpcx )

Local oReport
Local lTRepInUse := .T.


Private lAuto 	 := (nReg!=Nil)
Private cFilSA2	 := xFilial("SA2")
Private cFilSA5	 := xFilial("SA5")
Private cFilSAJ	 := xFilial("SAJ")
Private cFilSB1	 := xFilial("SB1")
Private cFilSB5	 := xFilial("SB5")
Private cFilSC7	 := xFilial("SC7")
Private cFilSCR	 := xFilial("SCR")
Private cFilSE4	 := xFilial("SE4")
Private cFilSM4	 := xFilial("SM4")
Private xUsrName := Nil 
Private	oHash 	 := Nil 

//Carrega os usuários do sistema para ser utilizado posteriormente nas demais funções através do HashMap
oHash := U_R110Hash()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Para versoes localizadas em TReport R4 e usado o MATR110, a chamada e       ³
//³realizada atraves do MATR111 onde a funcao TRepInUse() e executada para     ³
//³selecionar o tipo de impressao R3 ou R4, este tratamento e para impedir que ³
//³a pergunta seja apresentada 2 vezes.                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If FunName() == Alltrim("MATR111") .Or. (cPaisLoc <> "BRA" .And. FunName() == Alltrim("MATA121"))
	lTRepInUse := .T.
Else                                    
	lTRepInUse := TRepInUse()
EndIf

If lTRepInUse
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:= ReportDef(nReg, nOpcx)
	oReport:PrintDialog()
Else
	U_MATR110R3( cAlias, nReg, nOpcx )
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Alexandre Inacio Lemes ³Data  ³06/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pedido de Compras / Autorizacao de Entrega                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nExp01: nReg = Registro posicionado do SC7 apartir Browse  ³±±
±±³          ³ nExp02: nOpcx= 1 - PC / 2 - AE                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(nReg,nOpcx)

Local cTitle   		:= STR0003 // "Emissao dos Pedidos de Compras ou Autorizacoes de Entrega"
Local oReport
Local oSection1
Local oSection2
Local nTamDscPrd 	:= 30 //Padrão da B1_DESC

If Type("lAuto") == "U"
	lAuto := (nReg!=Nil)
Endif

If Type("cFilSA2") == "U"
	cFilSA2		:= xFilial("SA2")
Endif

If Type("cFilSA5") == "U"
	cFilSA5		:= xFilial("SA5")
Endif

If Type("cFilSAJ") == "U"
	cFilSAJ		:= xFilial("SAJ")
Endif

If Type("cFilSB1") == "U"
	cFilSB1		:= xFilial("SB1")
Endif

If Type("cFilSB5") == "U"
	cFilSB5		:= xFilial("SB5")
Endif

If Type("cFilSC7") == "U"
	cFilSC7		:= xFilial("SC7")
Endif

If Type("cFilSCR") == "U"
	cFilSCR		:= xFilial("SCR")
Endif

If Type("cFilSE4") == "U"
	cFilSE4		:= xFilial("SE4")
Endif

If Type("cFilSM4") == "U"
	cFilSM4		:= xFilial("SM4")
Endif

If Type("oHash") == "U"
	oHash		:= U_R110Hash()
EndIf 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01               Do Pedido                             ³
//³ mv_par02               Ate o Pedido                          ³
//³ mv_par03               A partir da data de emissao           ³
//³ mv_par04               Ate a data de emissao                 ³
//³ mv_par05               Somente os Novos                      ³
//³ mv_par06               Campo Descricao do Produto    	     ³
//³ mv_par07               Unidade de Medida:Primaria ou Secund. ³
//³ mv_par08               Imprime ? Pedido Compra ou Aut. Entreg³
//³ mv_par09               Numero de vias                        ³
//³ mv_par10               Pedidos ? Liberados Bloqueados Ambos  ³
//³ mv_par11               Impr. SC's Firmes, Previstas ou Ambas ³
//³ mv_par12               Qual a Moeda ?                        ³
//³ mv_par13               Endereco de Entrega                   ³
//³ mv_par14               todas ou em aberto ou atendidos       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR110",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New("MATR110",cTitle,"MTR110", {|oReport| ReportPrint(oReport,nReg,nOpcx)},STR0001+" "+STR0002)
oReport:SetPortrait()
oReport:HideParamPage()
oReport:HideHeader()
oReport:HideFooter()
oReport:SetTotalInLine(.F.)
oReport:DisableOrientation()
oReport:ParamReadOnly(lAuto)
oReport:SetUseGC(.F.)
oSection1:= TRSection():New(oReport,STR0102,{"SC7","SM0","SA2"}, /* <aOrder> */ ,;
								 /* <.lLoadCells.> */ , , /* <cTotalText>  */, /* !<.lTotalInCol.>  */, /* <.lHeaderPage.>  */,;
								 /* <.lHeaderBreak.> */, /* <.lPageBreak.>  */, /* <.lLineBreak.>  */, /* <nLeftMargin>  */,;
								 .T./* <.lLineStyle.>  */, /* <nColSpace>  */,.T. /*<.lAutoSize.> */, /*<cSeparator> */,;
								 /*<nLinesBefore>  */, /*<nCols>  */, /* <nClrBack> */, /* <nClrFore>  */)
oSection1:SetReadOnly()
oSection1:SetNoFilter("SA2")

TRCell():New(oSection1,"M0_NOMECOM","SM0",STR0087      ,/*Picture*/,49,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"M0_ENDENT" ,"SM0",STR0088      ,/*Picture*/,48,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"M0_CEPENT" ,"SM0",STR0089      ,/*Picture*/,10,/*lPixel*/,{|| Trans(SM0->M0_CEPENT,cPicA2_CEP) })
TRCell():New(oSection1,"M0_CIDENT" ,"SM0",STR0090      ,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"M0_ESTENT" ,"SM0",STR0091      ,/*Picture*/,11,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"M0_CGC"    ,"SM0",STR0124      ,/*Picture*/,18,/*lPixel*/,{|| Transform(SM0->M0_CGC,cPicA2_CGC) })
If cPaisLoc == "BRA"
	TRCell():New(oSection1,"M0IE"  ,"   ",STR0041      ,/*Picture*/,18,/*lPixel*/,{|| InscrEst()})
EndIf
TRCell():New(oSection1,"M0_TEL"    ,"SM0",STR0092      ,/*Picture*/,14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"M0_FAX"    ,"SM0",STR0093      ,/*Picture*/,34,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_NOME"   ,"SA2",/*Titulo*/   ,/*Picture*/,40,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_COD"    ,"SA2",/*Titulo*/   ,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_LOJA"   ,"SA2",/*Titulo*/   ,/*Picture*/,04,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_END"    ,"SA2",/*Titulo*/   ,/*Picture*/,40,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_BAIRRO" ,"SA2",/*Titulo*/   ,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_CEP"    ,"SA2",/*Titulo*/   ,/*Picture*/,08,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_MUN"    ,"SA2",/*Titulo*/   ,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_EST"    ,"SA2",/*Titulo*/   ,/*Picture*/,02,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_CGC"    ,"SA2",/*Titulo*/   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_INSCR"  ,"   ",If( cPaisLoc$"ARG|POR|EUA",space(11) , STR0095 ),/*Picture*/,18,/*lPixel*/,{|| If( cPaisLoc$"ARG|POR|EUA",space(18), SA2->A2_INSCR ) })
TRCell():New(oSection1,"A2_TEL"    ,"   ",STR0094      ,/*Picture*/,25,/*lPixel*/,{|| "("+Substr(SA2->A2_DDD,1,3)+") "+Substr(SA2->A2_TEL,1,15)})
TRCell():New(oSection1,"A2_FAX"    ,"   ",STR0093      ,/*Picture*/,25,/*lPixel*/,{|| "("+Substr(SA2->A2_DDD,1,3)+") "+SubStr(SA2->A2_FAX,1,15)})

oSection1:Cell("A2_BAIRRO"):SetCellBreak()
oSection1:Cell("A2_CGC"   ):SetCellBreak()
oSection1:Cell("A2_INSCR"    ):SetCellBreak()

oSection2:= TRSection():New(oSection1, STR0103, {"SC7","SB1"}, /* <aOrder> */ ,;
								 /* <.lLoadCells.> */ , , /* <cTotalText>  */, /* !<.lTotalInCol.>  */, /* <.lHeaderPage.>  */,;
								 /* <.lHeaderBreak.> */, /* <.lPageBreak.>  */, /* <.lLineBreak.>  */, /* <nLeftMargin>  */,;
								 /* <.lLineStyle.>  */, /* <nColSpace>  */, /*<.lAutoSize.> */, /*<cSeparator> */,;
								 /*<nLinesBefore>  */, /*<nCols>  */, /* <nClrBack> */, /* <nClrFore>  */)

//-- Bordas para o cabeçalho
oSection2:SetCellBorder("LEFT",,, .T.)  
oSection2:SetCellBorder("TOP" ,,, .T.)

TRCell():New(oSection2, "C7_NUM"		, "SC7", AllTrim(STR0129),/*Picture*/,,,,,,,,, .T.)                                                                                
TRCell():New(oSection2, "C7_ITEM"    	, "SC7",/*Titulo*/	   ,/*Picture*/,,,,,,,,, .T.)
TRCell():New(oSection2, "C7_PRODUTO" 	, "SC7",/*Titulo*/	   ,/*Picture*/,,,,,,,,, .T.)
TRCell():New(oSection2, "DESCPROD"   	, "   ", AllTrim(STR0097),/*Picture*/, nTamDscPrd,/*lPixel*/, {|| cDescPro},,,,,, .F.)
TRCell():New(oSection2, "C7_UM"      	, "SC7", AllTrim(STR0115),/*Picture*/,,/*lPixel*/,/* */, "CENTER",, "CENTER",,, .T.)
TRCell():New(oSection2, "C7_QUANT"   	, "SC7",/*Titulo*/	   ,/*Picture*/,,/*lPixel*/,/* */, "RIGHT",, "RIGHT",,, .T.)
TRCell():New(oSection2, "C7_SEGUM"   	, "SC7", AllTrim(STR0118),/*Picture*/,,/*lPixel*/,/* */, "CENTER",, "CENTER",,, .T.)
TRCell():New(oSection2, "C7_QTSEGUM" 	, "SC7",/*Titulo*/	   ,/*Picture*/,,/*lPixel*/,/* */, "RIGHT",, "RIGHT",,, .T.)
TRCell():New(oSection2, "PRECO"      	, "   ", AllTrim(STR0098),/*Picture*/, TamSX3("C7_PRECO")[1],/*lPixel*/, {|| nVlUnitSC7 }, "RIGHT",, "RIGHT",,, .F.)
TRCell():New(oSection2, "C7_IPI"     	, "SC7", AllTrim(STR0119),/*Picture*/,,/*lPixel*/,/* */,"RIGHT",, "RIGHT",,, .T.)
TRCell():New(oSection2, "TOTAL"     	, "   ", AllTrim(STR0099),/*Picture*/, TamSX3("C7_TOTAL")[1],/*lPixel*/, {|| nValTotSC7 }, "RIGHT",, "RIGHT",,, .F.)
TRCell():New(oSection2, "C7_DATPRF"  	, "SC7",/*Titulo*/	   ,/*Picture*/,,/*lPixel*/,/* */, "CENTER",, "CENTER",,, .T.)
TRCell():New(oSection2, "C7_CC"      	, "SC7", AllTrim(STR0066),/*Picture*/,,/*lPixel*/,/* */, "CENTER",, "CENTER",,, .T.)
TRCell():New(oSection2, "C7_NUMSC"   	, "SC7", AllTrim(STR0123),/*Picture*/,,/*lPixel*/,/* */, "CENTER",, "CENTER",,, .T.)
TRCell():New(oSection2, "OPCC"       	, "   ", AllTrim(STR0100),/*Picture*/, TamSX3("C7_OP")[1],/*lPixel*/, {|| cOPCC }, "CENTER",, "CENTER",,, .F.)        

oSection2:Cell("C7_PRODUTO"):SetLineBreak()
oSection2:Cell("DESCPROD"):SetLineBreak()
oSection2:Cell("C7_CC"):SetLineBreak()
oSection2:Cell("OPCC"):SetLineBreak()
oSection2:Cell("C7_NUMSC"):SetLineBreak()

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Alexandre Inacio Lemes ³Data  ³06/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Pedido de Compras / Autorizacao de Entrega      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportPrint(ExpO1,ExpN1,ExpN2)                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oReport                      	              ³±±
±±³          ³ ExpN1 = Numero do Recno posicionado do SC7 impressao Menu  ³±±
±±³          ³ ExpN2 = Numero da opcao para impressao via menu do PC      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,nReg,nOpcX)

Local oSection1   := oReport:Section(1)
Local oSection2   := oReport:Section(1):Section(1)

Local aRecnoSave  := {}
Local aPedido     := {}
Local aPedMail    := {}
Local aValIVA     := {}

Local cNumSC7		:= Len(SC7->C7_NUM)
Local cCondicao		:= ""
Local cFiltro		:= ""
Local cComprador	:= ""
LOcal cAlter		:= ""
Local cAprov		:= ""
Local cTipoSC7		:= ""
Local cCondBus		:= ""
Local cMensagem		:= ""
Local cVar			:= ""
Local cPictVUnit	:= PesqPict("SC7","C7_PRECO",15)
Local cPictVTot		:= PesqPict("SC7","C7_TOTAL",, mv_par12)
Local lNewAlc		:= .F.
Local lLiber		:= .F.
Local lRejeit		:= .F.

Local nRecnoSC7   	:= 0
Local nRecnoSM0   	:= 0
Local nX          	:= 0
Local nY          	:= 0
Local nVias       	:= 0
Local nTxMoeda    	:= 0
Local nPageWidth  	:= oReport:PageWidth()
Local nPrinted    	:= 0
Local nValIVA     	:= 0
Local nTotIpi	    := 0
Local nTotIcms    	:= 0
Local nTotDesp    	:= 0
Local nTotFrete   	:= 0
Local nTotalNF    	:= 0
Local nTotSeguro  	:= 0
Local nLinPC	    := 0
Local nLinObs     	:= 0
Local nDescProd   	:= 0
Local nTotal      	:= 0
Local nTotMerc    	:= 0
Local nTotNFImp     := 0
Local nPagina     	:= 0
Local nOrder      	:= 1
Local lImpri      	:= .F.
Local cCident	  	:= ""
Local cCidcob	  	:= ""
Local nLinPC2	  	:= 0
Local nLinPC3	  	:= 0
Local nAprovLin 	:= 0
Local aAux1
Local nQtdLinhas //, nX
Local lC7OBSChar  	:= Type( "SC7->C7_OBS" ) == "C"
Local nFrete		:= 0
Local nSeguro       := 0
Local nDesp			:= 0
Local aSC7Obs		:= {}
Local lPOFrete 		:= cPaisLoc == "COL" .AND. FunName() == "MATA123"

Private cDescPro  	:= ""
Private cOPCC     	:= ""
Private nVlUnitSC7	:= 0
Private nValTotSC7	:= 0

Private cObs01    	 := ""
Private cObs02    	  := ""
Private cObs03    	  := ""
Private cObs04    	  := ""
Private cObs05    	  := ""
Private cObs06    	  := ""
Private cObs07    	  := ""
Private cObs08    	  := ""
Private cObs09    	  := ""
Private cObs10    	  := ""
Private cObs11    	  := ""
Private cObs12    	  := ""
Private cObs13    	  := ""
Private cObs14    	  := ""
Private cObs15    	  := ""
Private cObs16    	  := ""

Private nRet		  := 0
Private cMoeda		  := ""
Private cPicMoeda	  := ""
Private cPicC7_VLDESC := "" 
Private cInscrEst	  := InscrEst()
Private cRegra        := SuperGetMV("MV_ARRPEDC",.F.,"ROUND")
Private nTamTot       := TamSX3("C7_PRECO")[2]

If !(cRegra $ "ROUND|NOROUND")
	cRegra := "LEGADO"
Endif

If Type("lPedido") != "L"
	lPedido := .F.
Endif

If Type("lAuto") == "U"
	lAuto := (nReg!=Nil)
Endif

If Type("cFilSA2") == "U"
	cFilSA2		:= xFilial("SA2")
Endif

If Type("cFilSA5") == "U"
	cFilSA5		:= xFilial("SA5")
Endif

If Type("cFilSAJ") == "U"
	cFilSAJ		:= xFilial("SAJ")
Endif

If Type("cFilSB1") == "U"
	cFilSB1		:= xFilial("SB1")
Endif

If Type("cFilSB5") == "U"
	cFilSB5		:= xFilial("SB5")
Endif

If Type("cFilSC7") == "U"
	cFilSC7		:= xFilial("SC7")
Endif

If Type("cFilSCR") == "U"
	cFilSCR		:= xFilial("SCR")
Endif

If Type("cFilSE4") == "U"
	cFilSE4		:= xFilial("SE4")
Endif

If Type("cFilSM4") == "U"
	cFilSM4		:= xFilial("SM4")
Endif

If Type("oHash") == "U"
	oHash		:= U_R110Hash()
EndIf 

dbSelectArea("SAJ")
SAJ->(dbSetOrder(1))

dbSelectArea("SCR")
SCR->(dbSetOrder(1))

dbSelectArea("SC7")

SB1->(dbSetOrder(1))
SB5->(dbSetOrder(1))
SA5->(dbSetOrder(1))
SM0->(dbSetOrder(1))
SE4->(dbSetOrder(1))
SM4->(dbSetOrder(1))

If lAuto	
	SC7->(dbGoto(nReg))
	mv_par01 := SC7->C7_NUM
	mv_par02 := SC7->C7_NUM
	mv_par03 := SC7->C7_EMISSAO
	mv_par04 := SC7->C7_EMISSAO
	R110ChkPerg()
	cCondBus := AllTrim(Str(SC7->C7_TIPO) + SC7->C7_NUM)
Else
	MakeAdvplExpr(oReport:uParam)

	cCondicao := 'C7_FILIAL=="'       + cFilSC7 + '".And.'
	cCondicao += 'C7_NUM>="'          + mv_par01       + '".And.C7_NUM<="'          + mv_par02 + '".And.'
	cCondicao += 'Dtos(C7_EMISSAO)>="'+ Dtos(mv_par03) +'".And.Dtos(C7_EMISSAO)<="' + Dtos(mv_par04) + '"'
	
	oReport:Section(1):SetFilter(cCondicao,IndexKey())
	
	cCondBus := "1"+PadL(mv_par01, Len(SC7->C7_NUM),"0")
EndIf      

If lPedido
	mv_par12 := MAX(SC7->C7_MOEDA,1)
EndIf

cMoeda		:= IIf( mv_par12 < 10 , Str(mv_par12,1) , Str(mv_par12,2) )
If Val(cMoeda) == 0
	cMoeda := "1"
Endif
cPicMoeda	:= GetMV("MV_MOEDA"+cMoeda)
cPicC7_VLDESC:= PesqPict("SC7","C7_VLDESC",14, MV_PAR12)

nOrder	 := 10

If mv_par14 == 2
	cFiltro := "SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)"
Elseif mv_par14 == 3
	cFiltro := "SC7->C7_QUANT > SC7->C7_QUJE"
EndIf

oSection2:Cell("PRECO"):SetPicture(cPictVUnit)
oSection2:Cell("TOTAL"):SetPicture(cPictVTot)

TRPosition():New(oSection2,"SB1",1,{ || cFilSB1 + SC7->C7_PRODUTO })
TRPosition():New(oSection2,"SB5",1,{ || cFilSB5 + SC7->C7_PRODUTO })

//-------------------------------------------------------------
// Imprime cabeçalho se não for modo planilha - Formato Tabela
//-------------------------------------------------------------
If oReport:nDevice != 4 .Or. (oReport:nDevice == 4 .And. !oReport:lXlsTable .And. oReport:lXlsHeader)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa o CodeBlock com o PrintLine da Sessao 1 toda vez que rodar o oSection1:Init()   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:onPageBreak( { || nPagina++ , nPrinted := 0 , CabecPCxAE(oReport,oSection1,nVias,nPagina) })
EndIf

oReport:SetMeter(SC7->(LastRec()))
SC7->(dbSetOrder(nOrder))
SC7->(dbSeek(cFilSC7+cCondBus,.T.))

oSection2:Init()

cNumSC7 := SC7->C7_NUM

While !oReport:Cancel() .And. !SC7->(Eof()) .And. SC7->C7_FILIAL == cFilSC7 .And. SC7->C7_NUM >= mv_par01 .And. SC7->C7_NUM <= mv_par02
	
	If (SC7->C7_CONAPRO <> "B" .And. mv_par10 == 2) .Or.;
		(SC7->C7_CONAPRO <> "L" .And. mv_par10 == 1) .Or.;
		(SC7->C7_EMITIDO == "S" .And. mv_par05 == 1) .Or.;
		((SC7->C7_EMISSAO < mv_par03) .Or. (SC7->C7_EMISSAO > mv_par04)) .Or.;
		((SC7->C7_TIPO == 1 .OR. SC7->C7_TIPO == 3) .And. mv_par08 == 2) .Or.;
		(SC7->C7_TIPO == 2 .And. (mv_par08 == 1 .OR. mv_par08 == 3)) .Or. !MtrAValOP(mv_par11, "SC7") .Or.;
		(SC7->C7_QUANT > SC7->C7_QUJE .And. mv_par14 == 3) .Or.;
		((SC7->C7_QUANT - SC7->C7_QUJE <= 0 .Or. !Empty(SC7->C7_RESIDUO)) .And. mv_par14 == 2 )
		
		SC7->(dbSkip())
		Loop
	Endif
	
	If oReport:Cancel()
		Exit
	EndIf
	
	MaFisEnd()
	R110FIniPC(SC7->C7_NUM,,,cFiltro)
	
	cObs01    := " "
	cObs02    := " "
	cObs03    := " "
	cObs04    := " "
	cObs05    := " "
	cObs06    := " "
	cObs07    := " "
	cObs08    := " "
	cObs09    := " "
	cObs10    := " "
	cObs11    := " "
	cObs12    := " "
	cObs13    := " "
	cObs14    := " "
	cObs15    := " "
	cObs16    := " "
	aSC7Obs	  := {}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Roda a impressao conforme o numero de vias informado no mv_par09 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nVias := 1 to mv_par09
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Dispara a cabec especifica do relatorio.                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		oReport:EndPage()
		oReport:Box( 260, 010, 3020 , nPageWidth-4 ) //-- Box dos itens do relatório
		
		nPagina  := 0
		nPrinted := 0
		nTotal   := 0
		nTotMerc := 0
		nDescProd:= 0
		nLinObs  := 0
		nRecnoSC7:= SC7->(Recno())
		cNumSC7  := SC7->C7_NUM
		aPedido  := {SC7->C7_FILIAL,SC7->C7_NUM,SC7->C7_EMISSAO,SC7->C7_FORNECE,SC7->C7_LOJA,SC7->C7_TIPO}
		
		While !oReport:Cancel() .And. !SC7->(Eof()) .And. SC7->C7_FILIAL == cFilSC7 .And. SC7->C7_NUM == cNumSC7
			
			If (SC7->C7_CONAPRO <> "B" .And. mv_par10 == 2) .Or.;
				(SC7->C7_CONAPRO <> "L" .And. mv_par10 == 1) .Or.;
				(SC7->C7_EMITIDO == "S" .And. mv_par05 == 1) .Or.;
				((SC7->C7_EMISSAO < mv_par03) .Or. (SC7->C7_EMISSAO > mv_par04)) .Or.;
				((SC7->C7_TIPO == 1 .OR. SC7->C7_TIPO == 3) .And. mv_par08 == 2) .Or.;
				(SC7->C7_TIPO == 2 .And. (mv_par08 == 1 .OR. mv_par08 == 3)) .Or. !MtrAValOP(mv_par11, "SC7") .Or.;
				(SC7->C7_QUANT > SC7->C7_QUJE .And. mv_par14 == 3) .Or.;
				((SC7->C7_QUANT - SC7->C7_QUJE <= 0 .Or. !Empty(SC7->C7_RESIDUO)) .And. mv_par14 == 2 )
				
				SC7->(dbSkip())
				Loop
			Endif
			
			If oReport:Cancel()
				Exit
			EndIf
			
			oReport:IncMeter()
			
			If oReport:Row() > oReport:LineHeight() * 100
				oReport:Box( oReport:Row(),010,oReport:Row() + oReport:LineHeight() * 3, nPageWidth-4 )
				oReport:SkipLine()
				oReport:PrintText(STR0101,, 050 ) // Continua na Proxima pagina ....
				oReport:EndPage()
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Salva os Recnos do SC7 no aRecnoSave para marcar reimpressao.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Ascan(aRecnoSave,SC7->(Recno())) == 0
				AADD(aRecnoSave,SC7->(Recno()))
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializa o descricao do Produto conf. parametro digitado.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cDescPro :=  ""
			If Empty(mv_par06)
				mv_par06 := "B1_DESC"
			EndIf
			
			If AllTrim(mv_par06) == "B1_DESC"
				SB1->(dbSeek( cFilSB1 + SC7->C7_PRODUTO ))
				cDescPro := SB1->B1_DESC
			ElseIf AllTrim(mv_par06) == "B5_CEME"
				If SB5->(dbSeek( cFilSB5 + SC7->C7_PRODUTO ))
					cDescPro := SB5->B5_CEME
				EndIf
			ElseIf AllTrim(mv_par06) == "C7_DESCRI"
				cDescPro := SC7->C7_DESCRI
			EndIf
			
			If Empty(cDescPro)
				SB1->(dbSeek( cFilSB1 + SC7->C7_PRODUTO ))
				cDescPro := SB1->B1_DESC
			EndIf
			
			If SA5->(dbSeek(cFilSA5+SC7->C7_FORNECE+SC7->C7_LOJA+SC7->C7_PRODUTO)) .And. !Empty(SA5->A5_CODPRF)
				cDescPro := Alltrim(cDescPro) + " ("+Alltrim(SA5->A5_CODPRF)+")"
			EndIf
			
			If SC7->C7_DESC1 != 0 .Or. SC7->C7_DESC2 != 0 .Or. SC7->C7_DESC3 != 0
				nDescProd+= CalcDesc(SC7->C7_TOTAL,SC7->C7_DESC1,SC7->C7_DESC2,SC7->C7_DESC3)
			Else
				nDescProd+=SC7->C7_VLDESC
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializacao da Observacao do Pedido.                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lC7OBSChar .AND. !Empty(SC7->C7_OBS) .And. nLinObs < 17
				If !(SC7->C7_OBS $ SC7->C7_OBSM) 
					nLinObs++
					cVar:="cObs"+StrZero(nLinObs,2)
					Eval(MemVarBlock(cVar),Alltrim(SC7->C7_OBS))
				EndIf 
			Endif
			
			If !Empty(SC7->C7_OBSM) .And. nLinObs < 17
				nLinObs++
				cVar:="cObs"+StrZero(nLinObs,2)
				if Ascan(aSC7Obs,{|x| AllTrim(x) == Alltrim(SC7->C7_OBSM) }) == 0
					aAdd(aSC7Obs, Alltrim(SC7->C7_OBSM))        	
					Eval(MemVarBlock(cVar),Alltrim(SC7->C7_OBSM))
				endif
			Endif
						
			nTxMoeda   := IIF(SC7->C7_TXMOEDA > 0,SC7->C7_TXMOEDA,0)
			nTotIpi	   := MaFisRet(,'NF_VALIPI')
			nTotIcms   := MaFisRet(,'NF_VALICM')

			If !Empty(cRegra)
				If AllTrim(cRegra) == "NOROUND"
					nValTotSC7            := NoRound( SC7->C7_QUANT * SC7->C7_PRECO, nTamTot )
				ElseIf AllTrim(cRegra) == "ROUND"
					nValTotSC7            := Round( SC7->C7_QUANT * SC7->C7_PRECO, nTamTot )
				Else
					nValTotSC7            := SC7->C7_TOTAL
				EndIf
				If nValTotSC7 > 0
					nTotal 	:= nTotal 	+ nValTotSC7
					IF SC7->C7_MOEDA == 1 .And. Val(cMoeda) == 1
						nTotMerc   := MaFisRet(,"NF_TOTAL")
					ELSE
						nFrete		:= nFrete 	+ SC7->C7_VALFRE
						nSeguro		:= nSeguro 	+ SC7->C7_SEGURO
						nDesp		:= nDesp 	+ SC7->C7_DESPESA
						If (cPaisLoc == "BRA" .And. (nTotIpi > 0 .Or. nTotIcms > 0))
							nTotMerc	:= MaFisRet(,"NF_TOTAL")
						Else
							nTotMerc	+= nValTotSC7
						Endif
					ENDIF 
				EndIf
			EndIf
		
			If !Empty(cRegra)
				If AllTrim(cRegra) == "NOROUND"
					nValTotSC7	:= NoRound( xMoeda(nValTotSC7,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda),2 )
				ElseIf AllTrim(cRegra) == "ROUND"
					nValTotSC7	:= Round( xMoeda(nValTotSC7,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda),2 )
				Else
					nValTotSC7	:= xMoeda(nValTotSC7,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
				Endif
			ENDIF
			
			If oReport:nDevice != 4 .Or. (oReport:nDevice == 4 .And. !oReport:lXlsTable .And. oReport:lXlsHeader)  //impressao em planilha tipo tabela
				oSection2:Cell("C7_NUM"):Disable()
			EndIf
			
			If MV_PAR07 == 2 .And. !Empty(SC7->C7_QTSEGUM) .And. !Empty(SC7->C7_SEGUM)
				oSection2:Cell("C7_SEGUM"  ):Enable()
				oSection2:Cell("C7_QTSEGUM"):Enable()
				oSection2:Cell("C7_UM"     ):Disable()
				oSection2:Cell("C7_QUANT"  ):Disable()
				nVlUnitSC7 := xMoeda(((SC7->C7_PRECO*SC7->C7_QUANT)/SC7->C7_QTSEGUM),SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
			ElseIf MV_PAR07 == 1 .And. !Empty(SC7->C7_QUANT) .And. !Empty(SC7->C7_UM)
				oSection2:Cell("C7_SEGUM"  ):Disable()
				oSection2:Cell("C7_QTSEGUM"):Disable()
				oSection2:Cell("C7_UM"     ):Enable()
				oSection2:Cell("C7_QUANT"  ):Enable()
				nVlUnitSC7 := xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
			Else
				oSection2:Cell("C7_SEGUM"  ):Enable()
				oSection2:Cell("C7_QTSEGUM"):Enable()
				oSection2:Cell("C7_UM"     ):Enable()
				oSection2:Cell("C7_QUANT"  ):Enable()
				nVlUnitSC7 := xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
			EndIf
			
			If cPaisLoc <> "BRA" .Or. mv_par08 == 2
				oSection2:Cell("C7_IPI" ):Disable()
			EndIf
			 
			If mv_par08 == 1 .OR. mv_par08 == 3
				oSection2:Cell("OPCC"):Disable()
			Else
				oSection2:Cell("C7_CC"):Disable()
				oSection2:Cell("C7_NUMSC"):Disable()
				If !Empty(SC7->C7_OP)
					cOPCC := STR0065 + " " + SC7->C7_OP
				ElseIf !Empty(SC7->C7_CC)
					cOPCC := STR0066 + " " + SC7->C7_CC
				EndIf
			EndIf
			

			If oReport:nDevice == 4 .And. oReport:lXlsTable .And. !oReport:lXlsHeader  //impressao em planilha tipo tabela	
				oSection1:Init()
				TRPosition():New(oSection1,"SA2",1,{ || cFilSA2 + SC7->C7_FORNECE + SC7->C7_LOJA })
				oSection1:PrintLine()
				oSection2:PrintLine()
				oSection1:Finish()
			Else	
				oSection2:PrintLine()
			EndIf
			
			nPrinted++
			lImpri  := .T.
			
			SC7->(dbSkip())
			
		EndDo
		
		SC7->(dbGoto(nRecnoSC7))
		
		If oReport:Row() > oReport:LineHeight() * 68
			
			oReport:Box( oReport:Row(),010,oReport:Row() + oReport:LineHeight() * 3, nPageWidth-4 )
			oReport:SkipLine()
			oReport:PrintText(STR0101,, 050 ) // Continua na Proxima pagina ....
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Dispara a cabec especifica do relatorio.                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oReport:EndPage()
			oReport:PrintText(" ",1992 , 010 ) // Necessario para posicionar Row() para a impressao do Rodape
			
			oReport:Box( 280,010,oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , nPageWidth-4 )

		EndIf
		
		oReport:Box( 1990 ,010,oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , nPageWidth-4 )
		oReport:Box( 2080 ,010,oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , nPageWidth-4 )
		oReport:Box( 2200 ,010,oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , nPageWidth-4 )
		oReport:Box( 2320 ,010,oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , nPageWidth-4 )
		
		oReport:Box( 2200 , 1080 , 2320 , 1400 ) // Box da Data de Emissao
		oReport:Box( 2320 ,  010 , 2406 , 1220 ) // Box do Reajuste
		oReport:Box( 2320 , 1220 , 2460 , 1750 ) // Box do IPI e do Frete
		oReport:Box( 2320 , 1750 , 2460 , nPageWidth-4 ) // Box do ICMS Despesas e Seguro
		oReport:Box( 2406 ,  010 , 2700 , 1220 ) // Box das Observacoes

		cMensagem:= Formula(C7_MSG)
		If !Empty(cMensagem)
			oReport:SkipLine()
			oReport:PrintText(PadR(cMensagem,129), , oSection2:Cell("DESCPROD"):ColPos() )
		Endif

		If SC7->C7_MOEDA == 1
			nDescProd := xMoeda(nDescProd,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
		Else
			If !Empty(cRegra)
				If AllTrim(cRegra) == "NOROUND"
					nDescProd := NoRound((xMoeda(nDescProd,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)))
				Elseif AllTrim(cRegra) == "ROUND"
					nDescProd := Round((xMoeda(nDescProd,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)),2)
				Else
					nDescProd := xMoeda(nDescProd,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
				Endif
			Endif
		Endif
		
		oReport:PrintText( STR0007 /*"D E S C O N T O S -->"*/ + " " + ;
		TransForm(SC7->C7_DESC1,"999.99" ) + " %    " + ;
		TransForm(SC7->C7_DESC2,"999.99" ) + " %    " + ;
		TransForm(SC7->C7_DESC3,"999.99" ) + " %    " + ;
		TransForm(nDescProd , cPicC7_VLDESC ),;
		2022 , 050 )
		
		oReport:SkipLine()
		oReport:SkipLine()
		oReport:SkipLine()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona o Arquivo de Empresa SM0.                          ³
		//³ Imprime endereco de entrega do SM0 somente se o MV_PAR13 =" "³
		//³ e o Local de Cobranca :                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nRecnoSM0 := SM0->(Recno())
		SM0->(dbSeek(SUBS(cNumEmp,1,2)+SC7->C7_FILENT))

		cCident := IIF(len(SM0->M0_CIDENT)>20,Substr(SM0->M0_CIDENT,1,15),SM0->M0_CIDENT)
		cCidcob := IIF(len(SM0->M0_CIDCOB)>20,Substr(SM0->M0_CIDCOB,1,15),SM0->M0_CIDCOB)

		If Empty(MV_PAR13) //"Local de Entrega  : "
			oReport:PrintText(STR0008 + SM0->M0_ENDENT+"  "+Rtrim(SM0->M0_CIDENT)+"  - "+SM0->M0_ESTENT+" - "+STR0009+" "+Trans(Alltrim(SM0->M0_CEPENT),cPicA2_CEP),, 050 )
		Else
			oReport:PrintText(STR0008 + mv_par13,, 050 ) //"Local de Entrega  : " imprime o endereco digitado na pergunte
		Endif
		SM0->(dbGoto(nRecnoSM0))
		oReport:PrintText(STR0010 + SM0->M0_ENDCOB+"  "+Rtrim(SM0->M0_CIDCOB)+"  - "+SM0->M0_ESTCOB+" - "+STR0009+" "+Trans(Alltrim(SM0->M0_CEPCOB),cPicA2_CEP),, 050 )
		
		oReport:SkipLine()
		oReport:SkipLine()
		
		SE4->(dbSeek(cFilSE4+SC7->C7_COND))
		
		nLinPC := oReport:Row()
		oReport:PrintText( STR0011+SubStr(SE4->E4_CODIGO,1,40),nLinPC,050 )
		oReport:PrintText( STR0070,nLinPC,1120 ) //"Data de Emissao"
		oReport:PrintText( STR0013 +" "+ Transform(xMoeda(nTotal,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) , tm(nTotal,14,MsDecimais(Val(cMoeda))) ),nLinPC,1612 ) //"Total das Mercadorias : "
		oReport:SkipLine()
		nLinPC := oReport:Row()
	
		If cPaisLoc<>"BRA"
			aValIVA := MaFisRet(,"NF_VALIMP")
			nValIVA :=0
			If !Empty(aValIVA)
				For nY:=1 to Len(aValIVA)
					nValIVA+=aValIVA[nY]
				Next nY
			EndIf
			oReport:PrintText(SubStr(SE4->E4_DESCRI,1,34),nLinPC, 050 )
			oReport:PrintText( dtoc(SC7->C7_EMISSAO),nLinPC,1120 )
			oReport:PrintText( STR0063+ "   " + ; //"Total dos Impostos:    "
			Transform(xMoeda(nValIVA,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) , tm(nValIVA,14,MsDecimais(Val(cMoeda))) ),nLinPC,1612 )
		Else
			oReport:PrintText( SubStr(SE4->E4_DESCRI,1,34),nLinPC, 050 )
			oReport:PrintText( dtoc(SC7->C7_EMISSAO),nLinPC,1120 )
			oReport:PrintText( STR0064+ "  " + ; //"Total com Impostos:    "
			Transform(xMoeda(nTotMerc,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) , tm(nTotMerc,14,MsDecimais(Val(cMoeda))) ),nLinPC,1612 )
		Endif
		oReport:SkipLine()
		
        nTotDesp  	:= MaFisRet(,'NF_DESPESA')
        nTotFrete 	:= MaFisRet(,'NF_FRETE')
        nTotSeguro	:= MaFisRet(,'NF_SEGURO')
        nTotalNF  	:= MaFisRet(,'NF_TOTAL')
		
        If SC7->C7_MOEDA > 1 .Or. Val(cMoeda) > 1
			If !Empty(cRegra)
				If AllTrim(cRegra) == "NOROUND"
					nTotFrete 	:= NoRound(xMoeda(nFrete  ,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda))
					nTotSeguro 	:= NoRound(xMoeda(nSeguro ,SC7->C7_MOEDA,MV_PAR12   ,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda))
					nTotDesp	:= NoRound(xMoeda(nDesp   ,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda))
                    nTotIpi     := NoRound(xMoeda(nTotIpi ,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda))
                    nTotIcms    := NoRound(xMoeda(nTotIcms,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda))
				Elseif AllTrim(cRegra) == "ROUND"
					nTotFrete 	:= Round(xMoeda(nFrete  ,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda),2)
					nTotSeguro 	:= Round(xMoeda(nSeguro ,SC7->C7_MOEDA,MV_PAR12   ,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda),2)
					nTotDesp	:= Round(xMoeda(nDesp   ,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda),2)
                    nTotIpi     := Round(xMoeda(nTotIpi ,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda),2)
                    nTotIcms    := Round(xMoeda(nTotIcms,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda),2)
				Else
					nTotFrete 	:= xMoeda(nFrete  ,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
					nTotSeguro 	:= xMoeda(nSeguro ,SC7->C7_MOEDA,MV_PAR12   ,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
					nTotDesp	:= xMoeda(nDesp   ,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
                    nTotIpi     := xMoeda(nTotIpi ,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
                    nTotIcms    := xMoeda(nTotIcms,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
				EndIf
			EndIf

            nTotNFImp := MaFisRet(,'NF_TOTAL') //-- Total com impostos
            nTotalNF  := nTotal + nFrete + nSeguro + nDesp //-- Total sem impostos

            nTotalNF := IIf(cPaisLoc <> "BRA" .Or. (cPaisLoc == "BRA" .And. (nTotIpi > 0 .Or. nTotIcms > 0)), nTotNFImp, nTotalNF)
            nTotalNF := xMoeda(nTotalNF,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
        Else
            nTotIPI  := xMoeda(nTotIPI ,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
            nTotIcms := xMoeda(nTotIcms,SC7->C7_MOEDA,Val(cMoeda),SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)
		EndIf
		
		oReport:SkipLine()
		oReport:SkipLine()
		nLinPC := oReport:Row()
		
		If SM4->(dbSeek(cFilSM4+SC7->C7_REAJUST))
			oReport:PrintText(  STR0014 + " " + SC7->C7_REAJUST + " " + SM4->M4_DESCR ,nLinPC, 050 )  //"Reajuste :"
		EndIf			

		If cPaisLoc == "BRA"
			oReport:PrintText( STR0071 + Transform(nTotIPI , tm(nTotIpi ,14,MsDecimais(Val(cMoeda)))) ,nLinPC,1320 ) //"IPI      :"
			oReport:PrintText( STR0072 + Transform(nTotIcms , tm(nTotIcms,14,MsDecimais(Val(cMoeda)))) ,nLinPC,1815 ) //"ICMS     :"
		EndIf
		oReport:SkipLine()

		nLinPC := oReport:Row()
		oReport:PrintText( STR0073 + Transform(nTotFrete , tm(nTotFrete,14,MsDecimais(Val(cMoeda)))) ,nLinPC,1320 ) //"Frete    :"
		oReport:PrintText( STR0074 + Transform(nTotDesp , tm(nTotDesp ,14,MsDecimais(Val(cMoeda)))) ,nLinPC,1815 ) //"Despesas :"
		oReport:SkipLine()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializar campos de Observacoes.                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		If Empty(cObs02) .Or. cObs01 == cObs02
			
			cObs02 := ""
			aAux1 := strTokArr(cObs01, chr(13)+chr(10))
			nQtdLinhas := 0						
			for nX := 1 To  Len(aAux1)
				nQtdLinhas += Ceiling(Len(aAux1[nX]) / 65)
			Next nX			
			If nQtdLinhas <= 8
				U_R110cObs(aAux1, 65)
			Else
				U_R110cObs(aAux1, 40)
			EndIf			
		Else
			cObs01:= Substr(cObs01,1,IIf(Len(cObs01)<65,Len(cObs01),65))
			cObs02:= Substr(cObs02,1,IIf(Len(cObs02)<65,Len(cObs02),65))
			cObs03:= Substr(cObs03,1,IIf(Len(cObs03)<65,Len(cObs03),65))
			cObs04:= Substr(cObs04,1,IIf(Len(cObs04)<65,Len(cObs04),65))
			cObs05:= Substr(cObs05,1,IIf(Len(cObs05)<65,Len(cObs05),65))
			cObs06:= Substr(cObs06,1,IIf(Len(cObs06)<65,Len(cObs06),65))
			cObs07:= Substr(cObs07,1,IIf(Len(cObs07)<65,Len(cObs07),65))
			cObs08:= Substr(cObs08,1,IIf(Len(cObs08)<65,Len(cObs08),65))
			cObs09:= Substr(cObs09,1,IIf(Len(cObs09)<65,Len(cObs09),65))
			cObs10:= Substr(cObs10,1,IIf(Len(cObs10)<65,Len(cObs10),65))
			cObs11:= Substr(cObs11,1,IIf(Len(cObs11)<65,Len(cObs11),65))
			cObs12:= Substr(cObs12,1,IIf(Len(cObs12)<65,Len(cObs12),65))
			cObs13:= Substr(cObs13,1,IIf(Len(cObs13)<65,Len(cObs13),65))
			cObs14:= Substr(cObs14,1,IIf(Len(cObs14)<65,Len(cObs14),65))
			cObs15:= Substr(cObs15,1,IIf(Len(cObs15)<65,Len(cObs15),65))
			cObs16:= Substr(cObs16,1,IIf(Len(cObs16)<65,Len(cObs16),65))
		EndIf
		
		cComprador:= ""
		cAlter	  := ""
		cAprov	  := ""
		lNewAlc	  := .F.
		lLiber 	  := .F.
		lRejeit	  := .F.
		
		
	//Incluida validação para os pedidos de compras por item do pedido  (IP/alçada)			
		cTipoSC7:= IIF((SC7->C7_TIPO == 1 .OR. SC7->C7_TIPO == 3),"PC","AE") 
		
		If cTipoSC7 == "PC"
		
			If SCR->(dbSeek(cFilSCR+cTipoSC7+SC7->C7_NUM))
				cTst = ''
			Else
				If SCR->(dbSeek(cFilSCR+"IP"+SC7->C7_NUM))
					cTst = ''
				EndIf
			EndIf
		
		Else
		
			SCR->(dbSeek(cFilSCR+cTipoSC7+SC7->C7_NUM))
		EndIf
		
		If !Empty(SC7->C7_APROV) .Or. (Empty(SC7->C7_APROV) .And. SCR->CR_TIPO == "IP")
			
			lNewAlc := .T.
			oHash:Get(SC7->C7_USER,@xUsrName)
			cComprador := Iif(type("xUsrName") == 'C', xUsrName, "")
			If SC7->C7_CONAPRO != "B"
				IF SC7->C7_CONAPRO == "R"
					lRejeit	  := .T.
				Else
					lLiber    := .T.
				EndIf
			EndIf

			While SCR->(!Eof()) .And. SCR->CR_FILIAL+Alltrim(SCR->CR_NUM) == cFilSCR+Alltrim(SC7->C7_NUM) .And. SCR->CR_TIPO $ "PC|AE|IP"
				oHash:Get(SCR->CR_USER,@xUsrName)
				cAprov += AllTrim(xUsrName)+" ["
				Do Case
					Case SCR->CR_STATUS=="02" //Pendente
        				cAprov += "BLQ"
					Case SCR->CR_STATUS=="03" //Liberado
						cAprov += "Ok"
					Case SCR->CR_STATUS=="04" //Bloqueado
						cAprov += "BLQ"
					Case SCR->CR_STATUS=="05" //Nivel Liberado
						cAprov += "##"
					Case SCR->CR_STATUS=="06" //Rejeitado
						cAprov += "REJ"
						
					OtherWise                 //Aguar.Lib
						cAprov += "??"
				EndCase
				cAprov += "] - "
				
				SCR->(dbSkip())
			Enddo
			If !Empty(SC7->C7_GRUPCOM)
				SAJ->(dbSeek(cFilSAJ+SC7->C7_GRUPCOM))
				While SAJ->(!Eof()) .And. SAJ->AJ_FILIAL+SAJ->AJ_GRCOM == cFilSAJ+SC7->C7_GRUPCOM
					If SAJ->AJ_USER != SC7->C7_USER
						If nPAJ_MSBLQL > 0
							If SAJ->AJ_MSBLQL == "1"
								SAJ->(dbSkip())
								LOOP
							EndIf 
						EndIf
						oHash:Get(SAJ->AJ_USER,@xUsrName)
						cAlter += AllTrim(xUsrName)+"/"
					EndIf
					
					SAJ->(dbSkip())
				EndDo
			EndIf
			If "[BLQ]" $ cAprov
				lLiber    := .F.
			EndIf
		EndIf

		nLinPC := oReport:Row()
		oReport:PrintText( STR0077 ,nLinPC, 050 ) // "Observacoes "
		oReport:PrintText( STR0076 + Transform(nTotSeguro , tm(nTotSeguro,14,MsDecimais(MV_PAR12))) ,nLinPC, 1815 ) // "SEGURO   :"
		oReport:SkipLine()

		nLinPC2 := oReport:Row()
		oReport:PrintText(cObs01,,050 )
		oReport:PrintText(cObs02,,050 )

		nLinPC := oReport:Row()
		oReport:PrintText(cObs03,nLinPC,050 )

		If !lNewAlc
			oReport:PrintText( STR0078 + Transform(nTotalNF , tm(nTotalNF,14,MsDecimais(MV_PAR12))) ,nLinPC,1774 ) //"Total Geral :"
		Else
			If lLiber
				oReport:PrintText( STR0078 + Transform(nTotalNF , tm(nTotalNF,14,MsDecimais(MV_PAR12))) ,nLinPC,1774 )
			Else
				oReport:PrintText( STR0078 + If((SC7->C7_TIPO == 1 .OR. SC7->C7_TIPO == 3),IF(lRejeit,STR0130,STR0051),STR0086) ,nLinPC,1390 )
			EndIf
		EndIf
		oReport:SkipLine()
		
		oReport:PrintText(cObs04,,050 )
		oReport:PrintText(cObs05,,050 )
		oReport:PrintText(cObs06,,050 )
		nLinPC3 := oReport:Row()
		oReport:PrintText(cObs07,,050 )
		oReport:PrintText(cObs08,,050 )
		oReport:PrintText(cObs09,nLinPC2,650 )
		oReport:SkipLine()
		oReport:PrintText(cObs10,,650 )
		oReport:PrintText(cObs11,,650 )
		oReport:PrintText(cObs12,,650 )
		oReport:PrintText(cObs13,,650 )
		oReport:PrintText(cObs14,,650 )
		oReport:PrintText(cObs15,,650 )
		oReport:PrintText(cObs16,,650 )

		If !lNewAlc
			
			oReport:Box( 2700 , 0010 , 3020 , 0400 )
			oReport:Box( 2700 , 0400 , 3020 , 0800 )
			oReport:Box( 2700 , 0800 , 3020 , 1220 )
			oReport:Box( 2600 , 1220 , 3020 , 1770 )
			oReport:Box( 2600 , 1770 , 3020 , nPageWidth-4 )
			
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()

			nLinPC := oReport:Row()
			oReport:PrintText( If((SC7->C7_TIPO == 1 .OR. SC7->C7_TIPO == 3),STR0079,STR0084),nLinPC,1310) //"Liberacao do Pedido"##"Liber. Autorizacao "
			If lPOFrete
				oReport:PrintText( STR0080 + SC7->C7_FREPPCC+If(SC7->C7_FREPPCC="CC","-Collect","-Prepaid") ,nLinPC,1820 ) //STR0132 Por conta remetente, STR0133 Por conta destinatario,STR0134 Por Conta Terceiros.
			Else
				oReport:PrintText( STR0080 + IF( SC7->C7_TPFRETE $ "F","FOB",IF(SC7->C7_TPFRETE $ "C","CIF",IF(SC7->C7_TPFRETE $ "R",STR0132,IF(SC7->C7_TPFRETE $ "D",STR0133,IF(SC7->C7_TPFRETE $ "T",STR0134," " ) )))) ,nLinPC,1820 ) //STR0132 Por conta remetente, STR0133 Por conta destinatario,STR0134 Por Conta Terceiros.
			Endif
			oReport:SkipLine()

			oReport:SkipLine()
			oReport:SkipLine()

			nLinPC := oReport:Row()
			oReport:PrintText( STR0021 ,nLinPC, 050 ) //"Comprador"
			oReport:PrintText( STR0022 ,nLinPC, 430 ) //"Gerencia"
			oReport:PrintText( STR0023 ,nLinPC, 850 ) //"Diretoria"
			oReport:SkipLine()

			oReport:SkipLine()
			oReport:SkipLine()

			nLinPC := oReport:Row()
			oReport:PrintText( Replic("_",23) ,nLinPC,  050 )
			oReport:PrintText( Replic("_",23) ,nLinPC,  430 )
			oReport:PrintText( Replic("_",23) ,nLinPC,  850 )
			oReport:PrintText( Replic("_",31) ,nLinPC, 1310 )
			oReport:SkipLine()

			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			If SC7->C7_TIPO == 1 .OR. SC7->C7_TIPO == 3
				oReport:PrintText(STR0081,,050 ) //"NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero do nosso Pedido de Compras."
			Else
				oReport:PrintText(STR0083,,050 ) //"NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero da Autorizacao de Entrega."
			EndIf
			
		Else
			
			oReport:Box( 2570 , 1220 , 2700 , 1820 )
			oReport:Box( 2570 , 1820 , 2700 , nPageWidth-4 )
			oReport:Box( 2700 , 0010 , 3020 , nPageWidth-4 )
			oReport:Box( 2970 , 0010 , 3020 , 1800 )
			
			nLinPC := nLinPC3
			
			oReport:PrintText( If((SC7->C7_TIPO == 1 .OR. SC7->C7_TIPO == 3), If( lLiber , STR0050 , IF(lRejeit,STR0130,STR0051) ) , If( lLiber , STR0085 , STR0086 ) ),nLinPC,1290 ) //"     P E D I D O   L I B E R A D O"#"|     P E D I D O   B L O Q U E A D O !!!"
			oReport:PrintText( STR0080 + Substr(RetTipoFrete(SC7->C7_TPFRETE),3),nLinPC,1830 ) //"Obs. do Frete: "
			oReport:SkipLine()

			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:PrintText(STR0052+" "+Substr(cComprador,1,60),,050 ) 	//"Comprador Responsavel :" //"BLQ:Bloqueado"
			oReport:SkipLine()
			oReport:PrintText(STR0053+" "+ If( Len(cAlter) > 0 , Substr(cAlter,001,130) , " " ),,050 ) //"Compradores Alternativos :"
			oReport:PrintText(            If( Len(cAlter) > 0 , Substr(cAlter,131,130) , " " ),,440 ) //"Compradores Alternativos :"
			
			

			nLinCar := 140
			nColCarac := 050
			nCCarac := 140
			
			nAprovLin := Ceiling( IIF(Len(AllTrim(cAprov)) < 75, 75, Len(AllTrim(cAprov))) / nLinCar)
			
			For nX := 1 to nAprovLin 
				If nX == 1
					oReport:PrintText(STR0054+" "+If( Len(cAprov) > 0 , Substr(cAprov,001,nLinCar) , " " ),,nColCarac ) //"Aprovador(es) :"
					nColCarac+=250
				Else
					oReport:PrintText(            If( Len(cAprov) > 0 , Substr(cAprov,nCCarac+1,nLinCar) , " " ),,nColCarac )
					nCCarac+=nLinCar
				EndIf
			Next nx

			nX:=nAprovLin
			While nX <= 3			
				oReport:SkipLine()
				nX:=nX+1
			EndDo


			nLinPC := oReport:Row()
			oReport:PrintText( STR0082+" "+STR0060 ,nLinPC, 050 ) 	//"Legendas da Aprovacao : //"BLQ:Bloqueado"
			oReport:PrintText(       "|  "+STR0061 ,nLinPC, 610 ) 	//"Ok:Liberado"
			oReport:PrintText(       "|  "+STR0131 ,nLinPC, 830 ) 	//"Ok:REJEITADO"
			oReport:PrintText(       "|  "+STR0062 ,nLinPC, 1050 ) 	//"??:Aguar.Lib"
			oReport:PrintText(       "|  "+STR0067 ,nLinPC, 1300 )	//"##:Nivel Lib"
			oReport:SkipLine()

			oReport:SkipLine()
			If SC7->C7_TIPO == 1 .OR. SC7->C7_TIPO == 3
				oReport:PrintText(STR0081,,050 ) //"NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero do nosso Pedido de Compras."
			Else
				oReport:PrintText(STR0083,,050 ) //"NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero da Autorizacao de Entrega."
			EndIf
		EndIf
		
	Next nVias
	
	MaFisEnd()
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava no SC7 as Reemissoes e atualiza o Flag de impressao.   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
		
	If Len(aRecnoSave) > 0
		For nX :=1 to Len(aRecnoSave)
			dbGoto(aRecnoSave[nX])
			If(SC7->C7_QTDREEM >= 99)	
				If nRet == 1
					RecLock("SC7",.F.)
					SC7->C7_EMITIDO := "S"
					MsUnLock()
				Elseif nRet == 2
					RecLock("SC7",.F.)
					SC7->C7_QTDREEM := 1
					SC7->C7_EMITIDO := "S"
					MsUnLock()
				Elseif nRet == 3
					//cancelar
				Endif
			Else
				RecLock("SC7",.F.)
				SC7->C7_QTDREEM := (SC7->C7_QTDREEM + 1)
				SC7->C7_EMITIDO := "S"
				MsUnLock()
			Endif
		Next nX
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Reposiciona o SC7 com base no ultimo elemento do aRecnoSave. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SC7->(dbGoto(aRecnoSave[Len(aRecnoSave)]))
	Endif
	
	Aadd(aPedMail,aPedido)
	
	aRecnoSave := {}
	
	
	SC7->(dbSkip())
	
EndDo

oSection2:Finish()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa o ponto de entrada M110MAIL quando a impressao for   ³
//³ enviada por email, fornecendo um Array para o usuario conten ³
//³ do os pedidos enviados para possivel manipulacao.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("M110MAIL")
	lEnvMail := (oReport:nDevice == 3)
	If lEnvMail
		Execblock("M110MAIL",.F.,.F.,{aPedMail})
	EndIf
EndIf

If lAuto .And. !lImpri
	Aviso(STR0104,STR0105,{"OK"})
Endif


SC7->(dbClearFilter())
SC7->(dbSetOrder(1))

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CabecPCxAE³ Autor ³Alexandre Inacio Lemes ³Data  ³06/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Pedido de Compras / Autorizacao de Entrega      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CabecPCxAE(ExpO1,ExpO2,ExpN1,ExpN2)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oReport                      	              ³±±
±±³          ³ ExpO2 = Objeto da sessao1 com o cabec                      ³±±
±±³          ³ ExpN1 = Numero de Vias                                     ³±±
±±³          ³ ExpN2 = Numero de Pagina                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CabecPCxAE(oReport,oSection1,nVias,nPagina)

Local nLinPC		:= 0
Local nPageWidth	:= oReport:PageWidth()
Local cCGC			:= ""
Local cTitCGC 		:= AllTrim( FWX3Titulo( "A2_CGC" ))

If Type("cPicMoeda") == "U"
	cMoeda		:= IIf( mv_par12 < 10 , Str(mv_par12,1) , Str(mv_par12,2) )
	If Val(cMoeda) == 0
		cMoeda := "1"
	Endif
	cPicMoeda := GetMV("MV_MOEDA"+cMoeda)
Endif

If Type("cInscrEst") == "U"
	cInscrEst := InscrEst()
Endif

If Type("cFilSA2") == "U"
	cFilSA2		:= xFilial("SA2")
Endif

If Type("cFilSA5") == "U"
	cFilSA5		:= xFilial("SA5")
Endif

If Type("cFilSAJ") == "U"
	cFilSAJ		:= xFilial("SAJ")
Endif

If Type("cFilSB1") == "U"
	cFilSB1		:= xFilial("SB1")
Endif

If Type("cFilSB5") == "U"
	cFilSB5		:= xFilial("SB5")
Endif

If Type("cFilSC7") == "U"
	cFilSC7		:= xFilial("SC7")
Endif

If Type("cFilSCR") == "U"
	cFilSCR		:= xFilial("SCR")
Endif

If Type("cFilSE4") == "U"
	cFilSE4		:= xFilial("SE4")
Endif

If Type("cFilSM4") == "U"
	cFilSM4		:= xFilial("SM4")
Endif

If Type("oHash") == "U"
	oHash		:= U_R110Hash()
EndIf 

TRPosition():New(oSection1,"SA2",1,{ || cFilSA2 + SC7->C7_FORNECE + SC7->C7_LOJA })
cBitmap := R110Logo()

SA2->(dbSetOrder(1))
SA2->(dbSeek(cFilSA2 + SC7->C7_FORNECE + SC7->C7_LOJA))

oSection1:Init()

oReport:Box( 010 , 010 ,  260 , 1000 )
oReport:Box( 010 , 1000,  260 , nPageWidth-4 )  

oReport:PrintText( If(nPagina > 1,(STR0033)," "),,oSection1:Cell("M0_NOMECOM"):ColPos())

nLinPC := oReport:Row()
oReport:PrintText( If( mv_par08 == 1 , (STR0068), (STR0069) ) + " - " + cPicMoeda ,nLinPC,1030 )
oReport:PrintText( If( mv_par08 == 1 , SC7->C7_NUM, SC7->C7_NUMSC + "/" + SC7->C7_NUM ) + " /" + Ltrim(Str(nPagina,2)) ,nLinPC,1910 )
oReport:SkipLine()


nLinPC := oReport:Row()
If(SC7->C7_QTDREEM >= 99)	
	nRet := Aviso("TOTVS", STR0125 +chr(13)+chr(10)+ "1- " + STR0126 +chr(13)+chr(10)+ "2- " + STR0127 +chr(13)+chr(10)+ "3- " + STR0128,{"1", "2", "3"},2)
	If(nRet == 1)
		oReport:PrintText( Str(SC7->C7_QTDREEM,2) + STR0034 + Str(nVias,2) + STR0035 ,nLinPC,1910 )
	Elseif(nRet == 2)
		oReport:PrintText( "1" + STR0034 + Str(nVias,2) + STR0035 ,nLinPC,1910 )
	Elseif(nRet == 3)
		oReport:CancelPrint()
	Endif
Else		
	oReport:PrintText( If( SC7->C7_QTDREEM > 0, Str(SC7->C7_QTDREEM+1,2) , "1" ) + STR0034 + Str(nVias,2) + STR0035 ,nLinPC,1910 )
Endif                                             

oReport:SkipLine()

_cFileLogo	:= GetSrvProfString('Startpath','') + cBitmap
oReport:SayBitmap(25,25,_cFileLogo,150,60) // insere o logo no relatorio

nLinPC := oReport:Row()
oReport:PrintText(STR0087 + SM0->M0_NOMECOM,nLinPC,15)  // "Empresa:"

oReport:PrintText(STR0106 + Substr(;
If(lLGPD,RetTxtLGPD(SA2->A2_NOME,"A2_NOME"),SA2->A2_NOME),;
1,50) + " " + STR0107 + SA2->A2_COD + " " + STR0108 + SA2->A2_LOJA ,nLinPC,1025)

oReport:SkipLine()

nLinPC := oReport:Row()
oReport:PrintText(STR0088 + SM0->M0_ENDENT,nLinPC,15)

oReport:PrintText(STR0088 + Substr(;
If(lLGPD,RetTxtLGPD(SA2->A2_END,"A2_END"),SA2->A2_END),;
1,49) + " " + STR0109 + Substr(;
If(lLGPD,RetTxtLGPD(SA2->A2_BAIRRO,"A2_BAIRRO"),SA2->A2_BAIRRO),;
1,25),nLinPC,1025)

oReport:SkipLine()

If cPaisLoc == "BRA"
	cCGC	:= Transform(If(lLGPD,RetTxtLGPD(SA2->A2_CGC,"A2_CGC"),SA2->A2_CGC),Substr(PICPES(SA2->A2_TIPO),1,at("%",PICPES(SA2->A2_TIPO))-1))
Else  
	cCGC	:= SA2->A2_CGC
EndIf   
        
nLinPC := oReport:Row()
oReport:PrintText(STR0089 + Trans(SM0->M0_CEPENT,cPicA2_CEP)+Space(2)+STR0090 + "  " + RTRIM(SM0->M0_CIDENT) + " " + STR0091 + SM0->M0_ESTENT ,nLinPC,15)
oReport:PrintText(STR0110+Left(;
If(lLGPD,RetTxtLGPD(SA2->A2_MUN,"A2_MUN"),SA2->A2_MUN),;
30)+" "+STR0111+;
If(lLGPD,RetTxtLGPD(SA2->A2_EST,"A2_EST"),SA2->A2_EST)+;
" "+STR0112+;
If(lLGPD,RetTxtLGPD(SA2->A2_CEP,"A2_CEP"),SA2->A2_CEP)+;
" "+cTitCGC+": "+cCGC,nLinPC,1025)

oReport:SkipLine()

nLinPC := oReport:Row()
oReport:PrintText(STR0092 + SM0->M0_TEL + Space(2) + STR0093 + SM0->M0_FAX ,nLinPC,15)

oReport:PrintText(STR0094 + "("+Substr(;
If(lLGPD,RetTxtLGPD(SA2->A2_DDD,"A2_DDD"),SA2->A2_DDD),;
1,3)+") "+Substr(;
If(lLGPD,RetTxtLGPD(SA2->A2_TEL,"A2_TEL"),SA2->A2_TEL),;
1,15) + " "+STR0114+"("+Substr(;
If(lLGPD,RetTxtLGPD(SA2->A2_DDD,"A2_DDD"),SA2->A2_DDD),;
1,3)+") "+SubStr(;
If(lLGPD,RetTxtLGPD(SA2->A2_FAX,"A2_FAX"),SA2->A2_FAX),;
1,15)+" "+If( cPaisLoc$"ARG|POR|EUA",space(11) , STR0095 )+If( cPaisLoc$"ARG|POR|EUA",space(18),;
If(lLGPD,RetTxtLGPD(SA2->A2_INSCR,"A2_INSCR"),SA2->A2_INSCR);
),nLinPC,1025)

oReport:SkipLine()

nLinPC := oReport:Row()
oReport:PrintText(cTitCGC+": "+Transform(SM0->M0_CGC,cPicA2_CGC) ,nLinPC,15)
If cPaisLoc == "BRA"
	oReport:PrintText(Space(2) + STR0041 + cInscrEst ,nLinPC,415)
Endif
oReport:SkipLine()
oReport:SkipLine()

oSection1:Finish()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR110R3³ Autor ³ Wagner Xavier         ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Pedido de Compras                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Descri‡ao ³ PLANO DE MELHORIA CONTINUA        ³Programa: MATR110R3.PRX ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ITEM PMC  ³ Responsavel              ³ Data          |BOPS             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³      01  ³                          ³               ³                 ³±±
±±³      02  ³ Marcos V. Ferreira       ³ 01/02/2006    ³                 ³±±
±±³      03  ³                          ³               ³                 ³±±
±±³      04  ³ Ricardo Berti            ³ 03/05/2006    ³00000097026      ³±±
±±³      05  ³                          ³               ³                 ³±±
±±³      06  ³ Marcos V. Ferreira       ³ 01/02/2006    ³                 ³±±
±±³      07  ³ Ricardo Berti            ³ 03/05/2006    ³00000097026      ³±±
±±³      08  ³ Flavio Luiz Vicco        ³ 07/04/2006    ³00000094742      ³±±
±±³      09  ³                          ³               ³                 ³±±
±±³      10  ³ Flavio Luiz Vicco        ³ 07/04/2006    ³00000094742      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MATR110R3(cAlias,nReg,nOpcx)

LOCAL wnrel		:= "MATR110"
LOCAL cDesc1	:= STR0001	//"Emissao dos pedidos de compras ou autorizacoes de entrega"
LOCAL cDesc2	:= STR0002	//"cadastradados e que ainda nao foram impressos"
LOCAL cDesc3	:= " "
LOCAL cString	:= "SC7"
Local lComp		:= .T.	// Ativado habilita escolher modo RETRATO / PAISAGEM

PRIVATE lAuto		:= (nReg!=Nil)
PRIVATE Tamanho		:= "G"
PRIVATE titulo	 	:=STR0003										//"Emissao dos Pedidos de Compras ou Autorizacoes de Entrega"
PRIVATE aReturn 	:= {STR0004, 1,STR0005, 1, 2, 1, "",0 }		//"Zebrado"###"Administracao"
PRIVATE nomeprog	:="MATR110"
PRIVATE nLastKey	:= 0
PRIVATE nBegin		:= 0
PRIVATE nDifColCC   := 0
PRIVATE aLinha		:= {}
PRIVATE aSenhas		:= {}
PRIVATE aUsuarios	:= {}
PRIVATE M_PAG		:= 1

If Type("lPedido") != "L"
	lPedido := .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01               Do Pedido                             ³
//³ mv_par02               Ate o Pedido                          ³
//³ mv_par03               A partir da data de emissao           ³
//³ mv_par04               Ate a data de emissao                 ³
//³ mv_par05               Somente os Novos                      ³
//³ mv_par06               Campo Descricao do Produto    	     ³
//³ mv_par07               Unidade de Medida:Primaria ou Secund. ³
//³ mv_par08               Imprime ? Pedido Compra ou Aut. Entreg³
//³ mv_par09               Numero de vias                        ³
//³ mv_par10               Pedidos ? Liberados Bloqueados Ambos  ³
//³ mv_par11               Impr. SC's Firmes, Previstas ou Ambas ³
//³ mv_par12               Qual a Moeda ?                        ³
//³ mv_par13               Endereco de Entrega                   ³
//³ mv_par14               todas ou em aberto ou atendidos       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR110",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se no SX3 o C7_CC esta com tamanho 9 (Default) se igual a 9 muda o tamanho do relatorio           ³
//³ para Medio possibilitando a impressao em modo Paisagem ou retrato atraves da reducao na variavel nDifColCC ³
//³ se o tamanho do C7_CC no SX3 estiver > que 9 o relatorio sera impresso comprrimido com espaco para o campo ³
//³ C7_CC centro de custo para ate 20 posicoes,Obs.desabilitando a selecao do modo de impresso retrato/paisagem³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If TamSx3("C7_CC")[1] == 9
	nDifColCC := 11
	Tamanho   := "M"
Else
	lComp	  := .F.   // C.Custo c/ tamanho maior que 9, sempre PAISAGEM
EndIf

wnrel:=SetPrint(cString,wnrel,If(lAuto,Nil,"MTR110"),@Titulo,cDesc1,cDesc2,cDesc3,.F.,,lComp,Tamanho,,!lAuto)

If nLastKey <> 27

	SetDefault(aReturn,cString)

	If lAuto
		mv_par01 := C7_NUM
		mv_par02 := C7_NUM
		mv_par03 := C7_EMISSAO
		mv_par04 := C7_EMISSAO
		R110ChkPerg()
	EndIf	

	If lPedido
		mv_par12 := MAX(SC7->C7_MOEDA,1)
	EndIf

	If mv_par08 == 1 .OR. mv_par08 == 3
		RptStatus({|lEnd| C110PC(@lEnd,wnRel,cString,nReg)},titulo)
	Else
		RptStatus({|lEnd| C110AE(@lEnd,wnRel,cString,nReg)},titulo)
	EndIf

	lPedido := .F.
	
Else 
	dbClearFilter()
EndIf

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C110PC   ³ Autor ³ Cristina M. Ogura     ³ Data ³ 09.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR110			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C110PC(lEnd,WnRel,cString,nReg)
Local nReem
Local nOrder
Local cCondBus
Local nSavRec
Local aPedido := {}
Local aPedMail:= {}
Local aSavRec := {}
Local nLinObs := 0
Local i       := 0
Local ncw     := 0
Local cFiltro := ""
Local lImpri  := .F.
Local lC7OBSChar  := Type( "SC7->C7_OBS" ) == "C"

Private cCGCPict, cCepPict
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definir as pictures                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCepPict:=PesqPict("SA2","A2_CEP")
cCGCPict:=PesqPict("SA2","A2_CGC")

If nDifColCC < 11
	limite   := 139
Else
	limite   := 129
Endif

li       := 80
nDescProd:= 0
nTotal   := 0
nTotMerc := 0
NumPed   := Space(6)

If lAuto
	dbSelectArea("SC7")
	dbGoto(nReg)
	SetRegua(1)
	mv_par01 := C7_NUM
	mv_par02 := C7_NUM
	mv_par03 := C7_EMISSAO
	mv_par04 := C7_EMISSAO
	R110ChkPerg() 
EndIf

If ( cPaisLoc$"ARG|POR|EUA" )
	cCondBus	:=	"1"+strzero(val(mv_par01),6)
	nOrder	:=	10
	nTipo		:= 1
Else
	cCondBus	:=mv_par01
	nOrder	:=	1
EndIf

If mv_par14 == 2
	cFiltro := "SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)"
Elseif mv_par14 == 3
	cFiltro := "SC7->C7_QUANT > SC7->C7_QUJE"
EndIf

dbSelectArea("SC7")
dbSetOrder(nOrder)
SetRegua(RecCount())
dbSeek(cFilSC7+cCondBus,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz manualmente porque nao chama a funcao Cabec()                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 0,0 PSay AvalImp(Iif(nDifColCC < 11,220,132))

While !Eof() .And. C7_FILIAL = cFilSC7 .And. C7_NUM >= mv_par01 .And. ;
		C7_NUM <= mv_par02

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria as variaveis para armazenar os valores do pedido        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nOrdem   := 1
	nReem    := 0
	cObs01   := " "
	cObs02   := " "
	cObs03   := " "
	cObs04   := " "

	If	C7_EMITIDO == "S" .And. mv_par05 == 1
		dbSkip()
		Loop
	Endif
	If	(C7_CONAPRO <> "B" .And. mv_par10 == 2) .Or.;
		(C7_CONAPRO <> "L" .And. mv_par10 == 1)
		dbSkip()
		Loop
	Endif
	If	(C7_EMISSAO < mv_par03) .Or. (C7_EMISSAO > mv_par04)
		dbSkip()
		Loop
	Endif
	If	C7_TIPO == 2
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. EM ABERTO                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par14 == 2
		If SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)
			dbSelectArea("SC7")
			dbSkip()
			Loop
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. ATENDIDOS                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par14 == 3
		If SC7->C7_QUANT > SC7->C7_QUJE
			dbSelectArea("SC7")
			dbSkip()
			Loop
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra Tipo de SCs Firmes ou Previstas                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !MtrAValOP(mv_par11, 'SC7')
		SC7->(dbSkip())
		Loop
	EndIf

	MaFisEnd()
	R110FIniPC(SC7->C7_NUM,,,cFiltro)

	For ncw := 1 To mv_par09		// Imprime o numero de vias informadas

		ImpCabec(ncw)

		nTotal   := 0
		nTotMerc	:= 0
		nDescProd:= 0
		nReem    := SC7->C7_QTDREEM + 1
		nSavRec  := SC7->(Recno())
		NumPed   := SC7->C7_NUM
		nLinObs  := 0
		aPedido  := {SC7->C7_FILIAL,SC7->C7_NUM,SC7->C7_EMISSAO,SC7->C7_FORNECE,SC7->C7_LOJA,SC7->C7_TIPO}

		While !Eof() .And. C7_FILIAL = cFilSC7 .And. C7_NUM == NumPed

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Consiste este item. EM ABERTO                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par14 == 2
				If SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)
					dbSelectArea("SC7")
					dbSkip()
					Loop
				Endif
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Consiste este item. ATENDIDOS                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par14 == 3
				If SC7->C7_QUANT > SC7->C7_QUJE
					dbSelectArea("SC7")
					dbSkip()
					Loop
				Endif
			Endif

			If Ascan(aSavRec,Recno()) == 0		// Guardo recno p/gravacao
				AADD(aSavRec,Recno())
			Endif
			If lEnd
				@PROW()+1,001 PSAY STR0006	//"CANCELADO PELO OPERADOR"
				Goto Bottom
				Exit
			Endif

			IncRegua()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se havera salto de formulario                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If li > 56
				nOrdem++
				ImpRodape()			// Imprime rodape do formulario e salta para a proxima folha
				ImpCabec(ncw)
			Endif

			li++

			@ li,001 PSAY "|"
			@ li,002 PSAY C7_ITEM  		Picture PesqPict("SC7","C7_ITEM")
			@ li,006 PSAY "|"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Pesquisa Descricao do Produto                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			ImpProd()

			If SC7->C7_DESC1 != 0 .or. SC7->C7_DESC2 != 0 .or. SC7->C7_DESC3 != 0
				nDescProd+= CalcDesc(SC7->C7_TOTAL,SC7->C7_DESC1,SC7->C7_DESC2,SC7->C7_DESC3)
			Else
				nDescProd+=SC7->C7_VLDESC
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializacao da Observacao do Pedido.                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lC7OBSChar .AND. !Empty(SC7->C7_OBS) .And. nLinObs < 5
				If !(SC7->C7_OBS $ SC7->C7_OBSM) 
					nLinObs++
					cVar:="cObs"+StrZero(nLinObs,2)
					Eval(MemVarBlock(cVar),Alltrim(SC7->C7_OBS))
				EndIf
			Endif
			
			If !Empty(SC7->C7_OBSM) .And. nLinObs < 5
				nLinObs++
				cVar:="cObs"+StrZero(nLinObs,2)
				Eval(MemVarBlock(cVar),Alltrim(SC7->C7_OBSM))
			Endif
			
			lImpri  := .T.
			dbSkip()
		EndDo

		dbGoto(nSavRec)

		If li>38
			nOrdem++
			ImpRodape()		// Imprime rodape do formulario e salta para a proxima folha
			ImpCabec(ncw)
		Endif

		FinalPed(nDescProd)		// Imprime os dados complementares do PC

	Next

	MaFisEnd()

	If Len(aSavRec)>0
		For i:=1 to Len(aSavRec)
			dbGoto(aSavRec[i])
			RecLock("SC7",.F.)  //Atualizacao do flag de Impressao
			Replace C7_QTDREEM With (C7_QTDREEM+1)
			Replace C7_EMITIDO With "S"
			MsUnLock()
		Next
		dbGoto(aSavRec[Len(aSavRec)])		// Posiciona no ultimo elemento e limpa array
	Endif

	Aadd(aPedMail,aPedido)

	aSavRec := {}

	dbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa o ponto de entrada M110MAIL quando a impressao for   ³
//³ enviada por email, fornecendo um Array para o usuario conten ³
//³ do os pedidos enviados para possivel manipulacao.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("M110MAIL")
	lEnvMail := HasEmail(,,,,.F.)
	If lEnvMail
		Execblock("M110MAIL",.F.,.F.,{aPedMail})
	EndIf
EndIf

If lAuto .And. !lImpri
	Aviso(STR0104,STR0105,{"OK"})
Endif

dbSelectArea("SC7")
dbClearFilter()
dbSetOrder(1)

dbSelectArea("SX3")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se em disco, desvia para Spool                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5] == 1    // Se Saida para disco, ativa SPOOL
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C110AE   ³ Autor ³ Cristina M. Ogura     ³ Data ³ 09.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR110			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C110AE(lEnd,WnRel,cString,nReg)
Local nReem
Local nSavRec,aSavRec := {}
Local aPedido := {}
Local aPedMail:= {}
Local nLinObs := 0
Local ncw     := 0
Local i       := 0
Local cFiltro := ""
Local lImpri  := .F.
Local lC7OBSChar  := Type( "SC7->C7_OBS" ) == "C"

Private cCGCPict, cCepPict
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definir as pictures                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCepPict:=PesqPict("SA2","A2_CEP")
cCGCPict:=PesqPict("SA2","A2_CGC")

If nDifColCC < 11
	limite   := 139
Else
	limite   := 129
Endif

li       := 80
nDescProd:= 0
nTotal   := 0
nTotMerc := 0
NumPed   := Space(6)

If !lAuto
	dbSelectArea("SC7")
	dbSetOrder(10)
	dbSeek(cFilSC7+"2"+mv_par01,.T.)
Else
	dbSelectArea("SC7")
	dbGoto(nReg)
	mv_par01 := C7_NUM
	mv_par02 := C7_NUM
	mv_par03 := C7_EMISSAO
	mv_par04 := C7_EMISSAO
	R110ChkPerg() 

	dbSelectArea("SC7")
	dbSetOrder(10)
	dbSeek(cFilSC7+"2"+mv_par01,.T.)
EndIf

If mv_par14 == 2
	cFiltro := "SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)"
Elseif mv_par14 == 3
	cFiltro := "SC7->C7_QUANT > SC7->C7_QUJE"
EndIf

SetRegua(Reccount())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz manualmente porque nao chama a funcao Cabec()                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 0,0 PSay AvalImp(Iif(nDifColCC < 11,220,132))
While !Eof().And.C7_FILIAL = cFilSC7 .And. C7_NUM >= mv_par01 .And. C7_NUM <= mv_par02
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria as variaveis para armazenar os valores do pedido        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nOrdem   := 1
	nReem    := 0
	cObs01   := " "
	cObs02   := " "
	cObs03   := " "
	cObs04   := " "

	If	C7_EMITIDO == "S" .And. mv_par05 == 1
		dbSelectArea("SC7")
		dbSkip()
		Loop
	Endif
	If	(C7_CONAPRO <> "B" .And. mv_par10 == 2) .Or.;
		(C7_CONAPRO <> "L" .And. mv_par10 == 1)
		dbSelectArea("SC7")
		dbSkip()
		Loop
	Endif
	If	(SC7->C7_EMISSAO < mv_par03) .Or. (SC7->C7_EMISSAO > mv_par04)
		dbSelectArea("SC7")
		dbSkip()
		Loop
	Endif
	If	SC7->C7_TIPO != 2
		dbSelectArea("SC7")
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. EM ABERTO                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par14 == 2
		If SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)
			dbSelectArea("SC7")
			dbSkip()
			Loop
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. ATENDIDOS                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par14 == 3
		If SC7->C7_QUANT > SC7->C7_QUJE
			dbSelectArea("SC7")
			dbSkip()
			Loop
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra Tipo de SCs Firmes ou Previstas                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !MtrAValOP(mv_par11, 'SC7')
		SC7->(dbSkip())
		Loop
	EndIf

	MaFisEnd()
	R110FIniPC(SC7->C7_NUM,,,cFiltro)

	For ncw := 1 To mv_par09		// Imprime o numero de vias informadas

		ImpCabec(ncw)

		nTotal   := 0
		nTotMerc := 0

		nDescProd:= 0
		nReem    := SC7->C7_QTDREEM + 1
		nSavRec  := SC7->(Recno())
		NumPed   := SC7->C7_NUM
		nLinObs := 0
		aPedido  := {SC7->C7_FILIAL,SC7->C7_NUM,SC7->C7_EMISSAO,SC7->C7_FORNECE,SC7->C7_LOJA,SC7->C7_TIPO}

		While !Eof() .And. C7_FILIAL = cFilSC7 .And. C7_NUM == NumPed

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Consiste este item. EM ABERTO                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par14 == 2
				If SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)
					dbSelectArea("SC7")
					dbSkip()
					Loop
				Endif
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Consiste este item. ATENDIDOS                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par14 == 3
				If SC7->C7_QUANT > SC7->C7_QUJE
					dbSelectArea("SC7")
					dbSkip()
					Loop
				Endif
			Endif

			If Ascan(aSavRec,Recno()) == 0		// Guardo recno p/gravacao
				AADD(aSavRec,Recno())
			Endif

			If lEnd
				@PROW()+1,001 PSAY STR0006		//"CANCELADO PELO OPERADOR"
				Goto Bottom
				Exit
			Endif

			IncRegua()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se havera salto de formulario                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If li > 56
				nOrdem++
				ImpRodape()		// Imprime rodape do formulario e salta para a proxima folha
				ImpCabec(ncw)
			Endif
			li++
			@ li,001 PSAY "|"
			@ li,002 PSAY SC7->C7_ITEM  	Picture PesqPict("SC7","C7_ITEM")
			@ li,006 PSAY "|"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Pesquisa Descricao do Produto                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			ImpProd()		// Imprime dados do Produto

			If SC7->C7_DESC1 != 0 .or. SC7->C7_DESC2 != 0 .or. SC7->C7_DESC3 != 0
				nDescProd+= CalcDesc(SC7->C7_TOTAL,SC7->C7_DESC1,SC7->C7_DESC2,SC7->C7_DESC3)
			Else
				nDescProd+=SC7->C7_VLDESC
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializacao da Observacao do Pedido.                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lC7OBSChar .AND. !Empty(SC7->C7_OBS) .And. nLinObs < 5
				nLinObs++
				cVar:="cObs"+StrZero(nLinObs,2)
				Eval(MemVarBlock(cVar),Alltrim(SC7->C7_OBS))
			Endif
			
			If !EMPTY(SC7->C7_OBSM) .And. nLinObs < 5
				nLinObs++
				cVar:="cObs"+StrZero(nLinObs,2)
				Eval(MemVarBlock(cVar),Alltrim(SC7->C7_OBSM))
			Endif
			
			lImpri  := .T.
			dbSelectArea("SC7")
			dbSkip()
		EndDo

		dbGoto(nSavRec)
		If li>38
			nOrdem++
			ImpRodape()		// Imprime rodape do formulario e salta para a proxima folha
			ImpCabec(ncw)
		Endif

		FinalAE(nDescProd)		// dados complementares da Autorizacao de Entrega
	Next

	MaFisEnd()

	If Len(aSavRec)>0
		dbGoto(aSavRec[Len(aSavRec)])
		For i:=1 to Len(aSavRec)
			dbGoto(aSavRec[i])
			RecLock("SC7",.F.)  //Atualizacao do flag de Impressao
			Replace C7_EMITIDO With "S"
			Replace C7_QTDREEM With (C7_QTDREEM+1)
			MsUnLock()
		Next
	Endif

	Aadd(aPedMail,aPedido)

	aSavRec := {}

	dbSelectArea("SC7")
	dbSkip()
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa o ponto de entrada M110MAIL quando a impressao for   ³
//³ enviada por email, fornecendo um Array para o usuario conten ³
//³ do os pedidos enviados para possivel manipulacao.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("M110MAIL")
	lEnvMail := HasEmail(,,,,.F.)
	If lEnvMail
		Execblock("M110MAIL",.F.,.F.,{aPedMail})
	EndIf
EndIf

If lAuto .And. !lImpri
	Aviso(STR0104,STR0105,{"OK"})
Endif

dbSelectArea("SC7")
dbClearFilter()
dbSetOrder(1)

dbSelectArea("SX3")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se em disco, desvia para Spool                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5] == 1    // Se Saida para disco, ativa SPOOL
	Set Printer TO
	Commit
	ourspool(wnrel)
Endif

MS_FLUSH()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpProd  ³ Autor ³ Wagner Xavier         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pesquisar e imprimir  dados Cadastrais do Produto.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpProd(Void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpProd()
LOCAL nBegin   := 0, cDescri := "", nLinha:=0
Local nTamDesc := 26
Local aColuna  := Array(8)
Local nTamProd := 15

If Empty(mv_par06)
	mv_par06 := "B1_DESC"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da descricao generica do Produto.                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If AllTrim(mv_par06) == "B1_DESC"
	dbSelectArea("SB1")
	dbSetOrder(1)
	dbSeek( cFilSB1+SC7->C7_PRODUTO )
	cDescri := Alltrim(SB1->B1_DESC)
	dbSelectArea("SC7")
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da descricao cientifica do Produto.                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If AllTrim(mv_par06) == "B5_CEME"
	dbSelectArea("SB5")
	dbSetOrder(1)
	If dbSeek( cFilSB5+SC7->C7_PRODUTO )
		cDescri := Alltrim(B5_CEME)
	EndIf
	dbSelectArea("SC7")
EndIf

dbSelectArea("SC7")
If AllTrim(mv_par06) == "C7_DESCRI"
	cDescri := Alltrim(SC7->C7_DESCRI)
EndIf

If Empty(cDescri)
	dbSelectArea("SB1")
	dbSetOrder(1)
	MsSeek( cFilSB1+SC7->C7_PRODUTO )
	cDescri := Alltrim(SB1->B1_DESC)
	dbSelectArea("SC7")
EndIf

dbSelectArea("SA5")
dbSetOrder(1)
If dbSeek(cFilSA5+SC7->C7_FORNECE+SC7->C7_LOJA+SC7->C7_PRODUTO).And. !Empty(SA5->A5_CODPRF)
	cDescri := cDescri + " ("+Alltrim(A5_CODPRF)+")"
EndIf
dbSelectArea("SC7")
aColuna[1] :=  49
aColuna[2] :=  52
aColuna[3] :=  65
aColuna[4] :=  80
aColuna[5] :=  86
aColuna[6] := 103
aColuna[7] := 114
acoluna[8] := 142 - nDifColCC

If Len(cDescri) > Len(SC7->C7_PRODUTO)
	nLinha:= MLCount(cDescri,nTamDesc)    
Else
	nLinha:= MLCount(SC7->C7_PRODUTO,nTamProd) 
EndIf

@ li,007 PSAY MemoLine(SC7->C7_PRODUTO,nTamProd,1)
@ li,022 PSAY "|"
@ li,023 PSAY MemoLine(cDescri,nTamDesc,1)

ImpCampos()
For nBegin := 2 To nLinha
	li++
	@ li,001 PSAY "|"
	@ li,006 PSAY "|"    
	@ li,007 PSAY MemoLine(SC7->C7_PRODUTO,nTamProd,nBegin)
	@ li,022 PSAY "|"
	@ li,023 PSAY Memoline(cDescri,nTamDesc,nBegin)
	@ li,aColuna[1] PSAY "|"
	@ li,acoluna[2] PSAY "|"
	@ li,acoluna[3] PSAY "|"
	@ li,aColuna[4] PSAY "|"

	If mv_par08 == 1 .OR. mv_par08 == 3
		If cPaisLoc == "BRA"
			@ li,aColuna[5] PSAY "|"
		Else
			@ li,aColuna[5] PSAY " "
		EndIf
		@ li,aColuna[6] PSAY "|"
		@ li,114 PSAY "|"
		@ li,135 - nDIfColCC PSAY "|"
		@ li,aColuna[8] PSAY "|"
	Else
		@ li,097 PSAY "|"
		@ li,108 PSAY "|"
		@ li,142 - nDifColCC PSAY "|"
	EndIf
Next nBegin

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpCampos³ Autor ³ Wagner Xavier         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir dados Complementares do Produto no Pedido.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpCampos(Void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpCampos()

LOCAL aColuna[6]
Local nTxMoeda := IIF(SC7->C7_TXMOEDA > 0,SC7->C7_TXMOEDA,0)
dbSelectArea("SC7")

aColuna[1] :=  49
aColuna[2] :=  52
aColuna[3] :=  65
aColuna[4] :=  80
aColuna[5] :=  86
aColuna[6] := 103

@ li,aColuna[1] PSAY "|"
If MV_PAR07 == 2 .And. !Empty(SC7->C7_SEGUM)
	@ li,PCOL() PSAY SC7->C7_SEGUM Picture PesqPict("SC7","C7_UM")
Else
	@ li,PCOL() PSAY SC7->C7_UM    Picture PesqPict("SC7","C7_UM")
EndIf
@ li,aColuna[2] PSAY "|"
If MV_PAR07 == 2 .And. !Empty(SC7->C7_QTSEGUM)
	@ li,PCOL() PSAY SC7->C7_QTSEGUM Picture PesqPictQt("C7_QUANT",13)
Else
	@ li,PCOL() PSAY SC7->C7_QUANT   Picture PesqPictQt("C7_QUANT",13)
EndIf
@ li,aColuna[3] PSAY "|"
If MV_PAR07 == 2 .And. !Empty(SC7->C7_QTSEGUM)
	@ li,PCOL()	PSAY xMoeda(((SC7->C7_PRECO*SC7->C7_QUANT)/SC7->C7_QTSEGUM),SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture PesqPict("SC7","C7_PRECO",14)
Else
	@ li,PCOL() PSAY xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture PesqPict("SC7","C7_PRECO",14)
EndIf
@ li,aColuna[4] PSAY "|"

If mv_par08 == 1 .OR. mv_par08 == 3
	If cPaisLoc == "BRA"
		@ li,    PCOL() PSAY SC7->C7_IPI Picture PesqPictQt("C7_IPI",5)
		@ li,    aColuna[5] PSAY "|"
	Else
		@ li,    PCOL() 	PSAY "  "
		@ li,aColuna[5]-2 	PSAY " "
		@ li,    PCOL() 	PSAY " "
	EndIf
	@ li,    PCOL() PSAY xMoeda(SC7->C7_TOTAL,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture PesqPict("SC7","C7_TOTAL",16,MV_PAR12)
	@ li,aColuna[6] PSAY "|"
	@ li,    PCOL() PSAY SC7->C7_DATPRF Picture PesqPict("SC7","C7_DATPRF")
	@ li,114 PSAY "|"
	@ li,PCOL() PSAY SC7->C7_CC         Picture PesqPict("SC7","C7_CC",20)
	@ li,135 - nDifColCC PSAY "|"
	@ li,  PCOL() PSAY SC7->C7_NUMSC
	@ li,142 - nDifColCC PSAY "|"
Else
	@ li,  PCOL() PSAY xMoeda(SC7->C7_TOTAL,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture PesqPict("SC7","C7_TOTAL",16,MV_PAR12)
	@ li,     097 PSAY "|"
	@ li,  PCOL() PSAY SC7->C7_DATPRF   Picture PesqPict("SC7","C7_DATPRF")
	@ li,     108 PSAY "|"
	// Tenta imprimir OP
	If !Empty(SC7->C7_OP)
		@ li,  PCOL() PSAY STR0065
		@ li,  PCOL() PSAY SC7->C7_OP
	// Caso Op esteja vazia imprime Centro de Custos
	ElseIf !Empty(SC7->C7_CC)
		@ li,  PCOL() PSAY STR0066
		@ li,PCOL() PSAY SC7->C7_CC     Picture PesqPict("SC7","C7_CC",20)
	EndIf
	@ li,142 - nDifColCC PSAY "|"
EndIf

nTotal  :=nTotal+SC7->C7_TOTAL
nTotMerc:=MaFisRet(,"NF_TOTAL")
Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FinalPed ³ Autor ³ Wagner Xavier         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados complementares do Pedido de Compra        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FinalPed(Void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FinalPed(nDescProd)

Local nk		:= 1,nG
Local nX		:= 0
Local nTotDesc	:= nDescProd
Local lNewAlc	:= .F.
Local lLiber 	:= .F.
Local lRejeit	:= .F.
Local lImpLeg	:= .T.
Local lImpLeg2	:= .F.
Local lImpLeg3	:= .F.
Local cComprador:=""
LOcal cAlter	:=""
Local cAprov	:=""
Local nTotIpi	:= MaFisRet(,'NF_VALIPI')
Local nTotIcms	:= MaFisRet(,'NF_VALICM')
Local nTotDesp	:= MaFisRet(,'NF_DESPESA')
Local nTotFrete	:= MaFisRet(,'NF_FRETE')
Local nTotalNF	:= MaFisRet(,'NF_TOTAL')
Local nTotSeguro:= MaFisRet(,'NF_SEGURO')
Local aValIVA   := MaFisRet(,"NF_VALIMP")
Local nValIVA   :=0
Local aColuna   := Array(8), nTotLinhas
Local nTxMoeda  := IIF(SC7->C7_TXMOEDA > 0,SC7->C7_TXMOEDA,0)

If cPaisLoc <> "BRA" .And. !Empty(aValIVA)
	For nG:=1 to Len(aValIVA)
		nValIVA+=aValIVA[nG]
	Next
Endif

cMensagem:= Formula(C7_MSG)

If !Empty(cMensagem)
	li++
	@ li,001 PSAY "|"
	@ li,002 PSAY Padc(cMensagem,129)
	@ li,142 - nDifColCC PSAY "|"
Endif
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,142 - nDifColCC PSAY "|"
li++

aColuna[1] :=  49
aColuna[2] :=  52
aColuna[3] :=  65
aColuna[4] :=  80
aColuna[5] :=  86
aColuna[6] := 103
acoluna[7] := 114
aColuna[8] := 142 - nDifColCC
nTotLinhas :=  39

While li<nTotLinhas
	@ li,001 PSAY "|"
	@ li,006 PSAY "|"
	@ li,022 PSAY "|"
	@ li,022 + nk PSAY "*"
	nk := IIf( nk == 42 , 1 , nk + 1 )
	@ li,aColuna[1] PSAY "|"
	@ li,aColuna[2] PSAY "|"
	@ li,aColuna[3] PSAY "|"
	@ li,aColuna[4] PSAY "|"
	If cPaisLoc == "BRA"
		@ li,aColuna[5] PSAY "|"
	EndIf
	@ li,aColuna[6] PSAY "|"
	@ li,114 PSAY "|"
	@ li,135 - nDifColCC PSAY "|"
	@ li,aColuna[8] PSAY "|"
	li++
EndDo
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,015 PSAY STR0007		//"D E S C O N T O S -->"
@ li,037 PSAY C7_DESC1 Picture "999.99"
@ li,046 PSAY C7_DESC2 Picture "999.99"
@ li,055 PSAY C7_DESC3 Picture "999.99"

@ li,068 PSAY xMoeda(nTotDesc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture PesqPict("SC7","C7_VLDESC",14, MV_PAR12)

@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona o Arquivo de Empresa SM0.                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAlias := Alias()
dbSelectArea("SM0")
dbSetOrder(1)   // forca o indice na ordem certa
nRegistro := Recno()
dbSeek(SUBS(cNumEmp,1,2)+SC7->C7_FILENT)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime endereco de entrega do SM0 somente se o MV_PAR13 =" "³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(MV_PAR13)
	//"Local de Entrega  : " -- //"CEP :"
	@ li,003 PSAY STR0008 + AllTrim(SM0->M0_ENDENT) + " - " + AllTrim(SM0->M0_CIDENT) + " - " + Alltrim(SM0->M0_ESTENT) + " - " + STR0009 + Trans(Alltrim(SM0->M0_CEPENT),cCepPict)
Else
	@ li,003 PSAY STR0008 + MV_PAR13		//"Local de Entrega  : " imprime o endereco digitado na pergunte
Endif

@ li,142 - nDifColCC PSAY "|"
dbGoto(nRegistro)
dbSelectArea( cAlias )

li++
@ li,001 PSAY "|"
//"Local de Cobranca : "
@ li,003 PSAY STR0010 + Alltrim(SM0->M0_ENDCOB) + " - " + Alltrim(SM0->M0_CIDCOB) + " - " + Alltrim(SM0->M0_ESTCOB) + " - " +	STR0009 + Trans(Alltrim(SM0->M0_CEPCOB),cCepPict)
@ li,141 - nDifColCC PSAY " |"
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,141 - nDifColCC PSAY "|"

dbSelectArea("SE4")
dbSetOrder(1)
dbSeek(cFilSE4+SC7->C7_COND)
dbSelectArea("SC7")
li++
@ li,001 PSAY "|"
@ li,003 PSAY STR0011+SubStr(SE4->E4_CODIGO,1,40)		//"Condicao de Pagto "
@ li,061 PSAY STR0012		//"|Data de Emissao|"
@ li,079 PSAY STR0013		//"Total das Mercadorias : " 
@ li,108 PSAY xMoeda(nTotal,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotal,14,MsDecimais(MV_PAR12))
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,003 PSAY SubStr(SE4->E4_DESCRI,1,34)
@ li,061 PSAY "|"
@ li,066 PSAY SC7->C7_EMISSAO
@ li,077 PSAY "|"
If cPaisLoc<>"BRA"
	@ li,079 PSAY OemtoAnsi(STR0063)	//"Total de los Impuestos : "
	@ li,108 PSAY xMoeda(nValIVA,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nValIVA,14,MsDecimais(MV_PAR12))
Else
	@ li,079 PSAY STR0064		//"Total com Impostos : "
	@ li,108 PSAY xMoeda(nTotMerc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotMerc,14,MsDecimais(MV_PAR12))
Endif
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",53)
@ li,055 PSAY Replicate("-",86 - nDifColCC)
@ li,142 - nDifColCC PSAY "|"
li++
dbSelectArea("SM4")
dbSetOrder(1)
dbSeek(cFilSM4+SC7->C7_REAJUST)
dbSelectArea("SC7")

@ li,001 PSAY "|"
@ li,003 PSAY STR0014		//"Reajuste :"
@ li,014 PSAY SC7->C7_REAJUST Picture PesqPict("SC7","C7_REAJUST",,MV_PAR12)
@ li,018 PSAY SM4->M4_DESCR

If cPaisLoc == "BRA"
	@ li,054 PSAY STR0015		//"| IPI   :"
	@ li,064 PSAY xMoeda(nTotIPI,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotIpi,14,MsDecimais(MV_PAR12))
	@ li,088 PSAY "| ICMS   : "
	@ li,100 PSAY xMoeda(nTotIcms,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotIcms,14,MsDecimais(MV_PAR12))
	@ li,142 - nDifColCC PSAY "|"
Else	
	@ li,054 PSAY "|"
	@ li,142 - nDifColCC PSAY "|"
EndIf

li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",52)
@ li,054 PSAY (STR0049) //"| Frete :"
@ li,064 PSAY xMoeda(nTotFrete,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotFrete,14,MsDecimais(MV_PAR12))
@ li,088 PSAY (STR0058) //"| Despesas :"
@ li,100 PSAY xMoeda(nTotDesp,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotDesp,14,MsDecimais(MV_PAR12))

@ li,142 - nDifColCC PSAY "|"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializar campos de Observacoes.                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(cObs02) .Or. cObs01 == cObs02
			
	cObs02 := ""
	If Len(cObs01) > 50
		cObs := cObs01
		cObs01 := Substr(cObs,1,50)
		For nX := 2 To 4
			cVar  := "cObs"+StrZero(nX,2)
			&cVar := Substr(cObs,(50*(nX-1))+1,50)
		Next
	EndIf
Else
	cObs01:= Substr(cObs01,1,IIf(Len(cObs01)<50,Len(cObs01),50))
	cObs02:= Substr(cObs02,1,IIf(Len(cObs02)<50,Len(cObs02),50))
	cObs03:= Substr(cObs03,1,IIf(Len(cObs03)<50,Len(cObs03),50))
	cObs04:= Substr(cObs04,1,IIf(Len(cObs04)<50,Len(cObs04),50))
EndIf

dbSelectArea("SC7")
If !Empty(SC7->C7_APROV) .Or. (Empty(SC7->C7_APROV) .And. SCR->CR_TIPO == "IP")
	lNewAlc := .T.
	oHash:Get(SC7->C7_USER,@xUsrName)
	cComprador := xUsrName
	If C7_CONAPRO != "B"
		IF C7_CONAPRO == "R"
			lRejeit	  := .T.
		Else
			lLiber    := .T.
		EndIf
	EndIf
	dbSelectArea("SCR")
	dbSetOrder(1)
	dbSeek(cFilSCR+"PC"+SC7->C7_NUM)
	While !Eof() .And. SCR->CR_FILIAL+Alltrim(SCR->CR_NUM)==cFilSCR+Alltrim(SC7->C7_NUM) .And. SCR->CR_TIPO $ "PC|AE|IP"
		oHash:Get(SCR->CR_USER,@xUsrName)
		cAprov += AllTrim(xUsrName)+" ["
        Do Case
        	Case SCR->CR_STATUS=="02" //Pendente
        		cAprov += "BLQ"
        	Case SCR->CR_STATUS=="03" //Liberado
        		cAprov += "Ok"
        	Case SCR->CR_STATUS=="04" //Bloqueado
        		cAprov += "BLQ"
			Case SCR->CR_STATUS=="05" //Nivel Liberado
				cAprov += "##"
			Case SCR->CR_STATUS=="06" //Rejeitado
				cAprov += "REJ"
			OtherWise                 //Aguar.Lib
				cAprov += "??"
		EndCase
		cAprov += "] - "
		dbSelectArea("SCR")
		dbSkip()
	Enddo
	If !Empty(SC7->C7_GRUPCOM)
		dbSelectArea("SAJ")
		dbSetOrder(1)
		dbSeek(cFilSAJ+SC7->C7_GRUPCOM)
		While !Eof() .And. SAJ->AJ_FILIAL+SAJ->AJ_GRCOM == cFilSAJ+SC7->C7_GRUPCOM
			If SAJ->AJ_USER != SC7->C7_USER
				If nPAJ_MSBLQL > 0
					If SAJ->AJ_MSBLQL == "1"
						dbSkip()
						LOOP
					EndIf 
				EndIf
				oHash:Get(SAJ->AJ_USER,@xUsrName)
				cAlter += AllTrim(xUsrName)+"/"
			EndIf
			dbSelectArea("SAJ")
			dbSkip()
		EndDo
	EndIf
EndIf

li++
@ li,001 PSAY STR0016		//"| Observacoes"
@ li,054 PSAY STR0017		//"| Grupo :"
@ li,088 PSAY STR0059      //"| SEGURO :"
@ li,100 PSAY xMoeda(nTotSeguro,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotSeguro,14,MsDecimais(MV_PAR12))
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,003 PSAY cObs01
@ li,054 PSAY "|"+Replicate("-",86 - nDifColCC)
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,003 PSAY cObs02
@ li,054 PSAY STR0018		//"| Total Geral : "

If !lNewAlc
	@ li,094 PSAY xMoeda(nTotalNF,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotalNF,14,MsDecimais(MV_PAR12))
Else
	If lLiber
		@ li,094 PSAY xMoeda(nTotalNF,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotalNF,14,MsDecimais(MV_PAR12))
	Else
		@ li,080 PSAY (IF(lRejeit,STR0130,STR0051))
	EndIf
EndIf

@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,003 PSAY cObs03
@ li,054 PSAY "|"+Replicate("-",86 - nDifColCC)
@ li,142 - nDifColCC PSAY "|"
li++

If !lNewAlc
	@ li,001 PSAY "|"
	@ li,003 PSAY cObs04
	@ li,054 PSAY "|"
	@ li,061 PSAY STR0019		//"|           Liberacao do Pedido"
	@ li,102 PSAY STR0020		//"| Obs. do Frete: "
	@ li,119 PSAY Substr(RetTipoFrete(SC7->C7_TPFRETE),3,10)
	@ li,142 - nDifColCC PSAY "|"
	li++
	@ li,001 PSAY "|"+Replicate("-",59)
	@ li,061 PSAY "|"
	@ li,102 PSAY "|"
	If !Empty(Substr(RetTipoFrete(SC7->C7_TPFRETE),13))
		@ li,104 PSAY Substr(RetTipoFrete(SC7->C7_TPFRETE),13)
	EndIf
	@ li,142 - nDifColCC PSAY "|"

	li++
	cLiberador := ""
	nPosicao := 0
	@ li,001 PSAY "|"
	@ li,007 PSAY STR0021		//"Comprador"
	@ li,021 PSAY "|"
	@ li,028 PSAY STR0022		//"Gerencia"
	@ li,041 PSAY "|"
	@ li,046 PSAY STR0023		//"Diretoria"
	@ li,061 PSAY "|     ------------------------------"
	@ li,102 PSAY "|"
	@ li,142 - nDifColCC PSAY "|"
	li++
	@ li,001 PSAY "|"
	@ li,021 PSAY "|"
	@ li,041 PSAY "|"
	@ li,061 PSAY "|     " + R110Center(cLiberador) // 30 posicoes
	@ li,102 PSAY "|"
	@ li,142 - nDifColCC PSAY "|"
	li++
	@ li,001 PSAY "|"
	@ li,002 PSAY Replicate("-",limite)
	@ li,142 - nDifColCC PSAY "|"
	li++
	@ li,001 PSAY STR0024		//"|   NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero do nosso Pedido de Compras."
	@ li,142 - nDifColCC PSAY "|"
	li++
	@ li,001 PSAY "|"
	@ li,002 PSAY Replicate("-",limite)
	@ li,142 - nDifColCC PSAY "|"
Else
	@ li,001 PSAY "|"
	@ li,003 PSAY cObs04
	@ li,054 PSAY "|"
	@ li,059 PSAY IF(lLiber,STR0050,IF(lRejeit,STR0130,STR0051))		//"     P E D I D O   L I B E R A D O"#"|     P E D I D O   B L O Q U E A D O !!!"
	@ li,102 PSAY STR0020		//"| Obs. do Frete: "
	@ li,119 PSAY Substr(RetTipoFrete(SC7->C7_TPFRETE),3,10)
	@ li,142 - nDifColCC PSAY "|"
	li++
	@ li,001 PSAY "|"+Replicate("-",99)
	@ li,102 PSAY "|"
	If !Empty(Substr(RetTipoFrete(SC7->C7_TPFRETE),13))
		@ li,104 PSAY Substr(RetTipoFrete(SC7->C7_TPFRETE),13)
	EndIf
	@ li,142 - nDifColCC PSAY "|"
	li++
	@ li,001 PSAY "|"
	@ li,003 PSAY STR0052		//"Comprador Responsavel :"
	@ li,027 PSAY Substr(cComprador,1,60)
	@ li,088 PSAY "|"
	@ li,089 PSAY STR0060      //"BLQ:Bloqueado"
	@ li,102 PSAY "|"
	@ li,142 - nDifColCC PSAY "|"
	li++
	nAuxLin := Len(cAlter)
	@ li,001 PSAY "|"
	@ li,003 PSAY STR0053		//"Compradores Alternativos :"
	While nAuxLin > 0 .Or. lImpLeg
		@ li,029 PSAY Substr(cAlter,Len(cAlter)-nAuxLin+1,60)
		@ li,088 PSAY "|"
		If lImpLeg
			@ li,089 PSAY STR0061   //"Ok:Liberado"
			lImpLeg := .F.
		EndIf
		@ li,102 PSAY "|"
		@ li,142 - nDifColCC PSAY "|"
		nAuxLin -= 60
		li++
	EndDo
	nAuxLin := Len(cAprov)
	lImpLeg := .T.
	While nAuxLin > 0	.Or. lImpLeg
		@ li,001 PSAY "|"
		If lImpLeg  // Imprimir soh a 1a vez
			@ li,003 PSAY STR0054		//"Aprovador(es) :"
		EndIf
		@ li,018 PSAY Substr(cAprov,Len(cAprov)-nAuxLin+1,70)
		@ li,088 PSAY "|"
		If lImpLeg3   // Imprimir soh a 3a vez
			@ li,089 PSAY STR0131 //"REJ:REJEITADO"
			lImpLeg3 := .F.
		EndIf
		If lImpLeg2  // Imprimir soh a 2a vez
			@ li,089 PSAY STR0067 //"##:Nivel.Lib"
			lImpLeg2 := .F.
			lImpLeg3 := .T.
		EndIf
		If lImpLeg   // Imprimir soh a 1a vez
			@ li,089 PSAY STR0062  //"??:Aguar.Lib"
			lImpLeg  := .F.
			lImpLeg2 := .T.
		EndIf
		@ li,102 PSAY "|"
		@ li,142 - nDifColCC PSAY "|"
		nAuxLin -=70
		li++
	EndDo
	If lImpLeg2
		lImpLeg2 := .F.
		lImpLeg3 := .T.
		@ li,001 PSAY "|"
		@ li,088 PSAY "|"
		@ li,089 PSAY STR0067 //"##:Nivel Lib"
		@ li,102 PSAY "|"
		@ li,142 - nDifColCC PSAY "|"
		li++
    EndIf
	If lImpLeg3
		lImpLeg3 := .F.
		@ li,001 PSAY "|"
		@ li,088 PSAY "|"
		@ li,089 PSAY STR0131 //"REJ:REJEITADO"
		@ li,102 PSAY "|"
		@ li,142 - nDifColCC PSAY "|"
		li++
	EndIf	
	If nAuxLin == 0
		li++
	EndIf
	@ li,001 PSAY "|"
	@ li,002 PSAY Replicate("-",limite)
	@ li,142 - nDifColCC PSAY "|"
	li++
	@ li,001 PSAY STR0024		//"|   NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero do nosso Pedido de Compras."
	@ li,142 - nDifColCC PSAY "|"
	li++
	@ li,001 PSAY "|"
	@ li,002 PSAY Replicate("-",limite)
	@ li,142 - nDifColCC PSAY "|"
EndIf

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FinalAE  ³ Autor ³ Cristina Ogura        ³ Data ³ 05.04.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados complementares da Autorizacao de Entrega  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FinalAE(Void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FinalAE(nDescProd)
Local nk := 1
Local nX := 0
Local nTotNF	:= MaFisRet(,'NF_TOTAL')
Local nTxMoeda := IIF(SC7->C7_TXMOEDA > 0,SC7->C7_TXMOEDA,0)
Local cComprador:=""
LOcal cAlter	:=""
Local cAprov	:=""
Local lImpLeg	:= .T.
Local lImpLeg2	:= .F.
Local lImpLeg3  := .F.

cMensagem:= Formula(C7_MSG)                                   

If !Empty(cMensagem)
	li++
	@ li,001 PSAY "|"
	@ li,002 PSAY Padc(cMensagem,129)
	@ li,142 - nDifColCC PSAY "|"
Endif
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,142 - nDifColCC PSAY "|"
li++
While li<39
	@ li,001 PSAY "|"
	@ li,006 PSAY "|"
	@ li,022 PSAY "|"
	@ li,022 + nk PSAY "*"
	nk := IIf( nk == 32 , 1 , nk + 1 )
	@ li,049 PSAY "|"
	@ li,052 PSAY "|"
	@ li,065 PSAY "|"
	@ li,080 PSAY "|"
	@ li,097 PSAY "|"
	@ li,108 PSAY "|"
	@ li,142 - nDifColCC PSAY "|"
	li++
EndDo
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona o Arquivo de Empresa SM0.                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAlias := Alias()
dbSelectArea("SM0")
dbSetOrder(1)   // forca o indice na ordem certa
nRegistro := Recno()
dbSeek(SUBS(cNumEmp,1,2)+SC7->C7_FILENT)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime endereco de entrega do SM0 somente se o MV_PAR13 =" "³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(MV_PAR13)
	//"Local de Entrega  : " -- //"CEP :"
	@ li,003 PSAY STR0008 + AllTrim(SM0->M0_ENDENT) + " - " + AllTrim(SM0->M0_CIDENT) + " - " + Alltrim(SM0->M0_ESTENT) + " - " + STR0009 + Trans(Alltrim(SM0->M0_CEPENT),cCepPict)
Else
	@ li,003 PSAY STR0008 + MV_PAR13		//"Local de Entrega  : " imprime o endereco digitado na pergunte
Endif

@ li,142 - nDifColCC PSAY " |"
dbGoto(nRegistro)
dbSelectArea(cAlias)

li++
@ li,001 PSAY "|"
//"Local de Cobranca : "
@ li,003 PSAY STR0010 + Alltrim(SM0->M0_ENDCOB) + " - " + Alltrim(SM0->M0_CIDCOB) + " - " + Alltrim(SM0->M0_ESTCOB) + " - " +	STR0009 + Trans(Alltrim(SM0->M0_CEPCOB),cCepPict)
@ li,142 - nDifColCC PSAY " |"
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,142 - nDifColCC PSAY "|"

dbSelectArea("SE4")
dbSetOrder(1)
dbSeek(cFilSE4+SC7->C7_COND)
dbSelectArea("SC7")
li++
@ li,001 PSAY "|"
@ li,003 PSAY STR0011+SubStr(SE4->E4_CODIGO,1,15)		//"Condicao de Pagto "
@ li,038 PSAY STR0012		// "|Data de Emissao|"
@ li,056 PSAY STR0013		// "Total das Mercadorias : "
@ li,094 PSAY xMoeda(nTotal,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotal,14,MsDecimais(MV_PAR12))

@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,003 PSAY SubStr(SE4->E4_DESCRI,1,34)
@ li,038 PSAY "|"
@ li,043 PSAY SC7->C7_EMISSAO
@ li,054 PSAY "|"
@ li,056 PSAY STR0064		// "Total com Impostos : "
@ li,094 PSAY xMoeda(nTotMerc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda) Picture tm(nTotMerc,14,MsDecimais(MV_PAR12))
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",52)
@ li,054 PSAY "|"
@ li,055 PSAY Replicate("-",86 - nDifColCC)
@ li,142 - nDifColCC PSAY "|"
li++
dbSelectArea("SM4")
dbSeek(cFilSM4+SC7->C7_REAJUST)
dbSelectArea("SC7")
@ li,001 PSAY "|"
@ li,003 PSAY STR0014		//"Reajuste :"
@ li,014 PSAY SC7->C7_REAJUST Picture PesqPict("SC7","C7_REAJUST",,MV_PAR12)
@ li,018 PSAY SM4->M4_DESCR
@ li,054 PSAY STR0018		//"| Total Geral : "

@ li,094 PSAY xMoeda(nTotNF,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,MsDecimais(SC7->C7_MOEDA),nTxMoeda)      Picture tm(nTotNF,14,MsDecimais(MV_PAR12))
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,142 - nDifColCC PSAY "|"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializar campos de Observacoes.                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(cObs02) .Or. cObs01 == cObs02
			
	cObs02 := ""
	If Len(cObs01) > 50
		cObs 	:= cObs01
		cObs01:= Substr(cObs,1,50)
		For nX := 2 To 4
			cVar  := "cObs"+StrZero(nX,2)
			&cVar := Substr(cObs,(50*(nX-1))+1,50)
		Next
	EndIf
Else
	cObs01:= Substr(cObs01,1,IIf(Len(cObs01)<50,Len(cObs01),50))
	cObs02:= Substr(cObs02,1,IIf(Len(cObs02)<50,Len(cObs02),50))
	cObs03:= Substr(cObs03,1,IIf(Len(cObs03)<50,Len(cObs03),50))
	cObs04:= Substr(cObs04,1,IIf(Len(cObs04)<50,Len(cObs04),50))
EndIf

li++
@ li,001 PSAY STR0025	//"| Observacoes"
@ li,054 PSAY STR0026	//"| Comprador    "
@ li,070 PSAY STR0027	//"| Gerencia     "
@ li,085 PSAY STR0028	//"| Diretoria    "
@ li,142 - nDifColCC PSAY "|"

li++
@ li,001 PSAY "|"
@ li,003 PSAY cObs01
@ li,054 PSAY "|"
@ li,070 PSAY "|"
@ li,085 PSAY "|"
@ li,142 - nDifColCC PSAY "|"

li++
@ li,001 PSAY "|"
@ li,003 PSAY cObs02
@ li,054 PSAY "|"
@ li,070 PSAY "|"
@ li,085 PSAY "|"
@ li,142 - nDifColCC PSAY "|"

li++
@ li,001 PSAY "|"
@ li,003 PSAY cObs03
@ li,054 PSAY "|"
@ li,070 PSAY "|"
@ li,085 PSAY "|"
@ li,142 - nDifColCC PSAY "|"

li++
@ li,001 PSAY "|"
@ li,003 PSAY cObs04
@ li,054 PSAY "|"
@ li,070 PSAY "|"
@ li,085 PSAY "|"
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,142 - nDifColCC PSAY "|"
li++

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista de Aprovadores   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC7")
lNewAlc := .F.
If !Empty(C7_APROV)   
	lNewAlc := .T.
	oHash:Get(SC7->C7_USER,@xUsrName)
	cComprador := xUsrName
		If C7_CONAPRO != "B"
		IF C7_CONAPRO == "R"
			lRejeit	  := .T.
		Else
			lLiber    := .T.
		EndIf
	EndIf
	dbSelectArea("SCR")
	dbSetOrder(1)
	dbSeek(cFilSCR+"AE"+SC7->C7_NUM)
	While !Eof() .And. SCR->CR_FILIAL+Alltrim(SCR->CR_NUM)==cFilSCR+Alltrim(SC7->C7_NUM) .And. SCR->CR_TIPO == "AE"
		oHash:Get(SCR->CR_USER,@xUsrName)
		cAprov += AllTrim(xUsrName)+"/"
        Do Case
        	Case SCR->CR_STATUS=="03" //Liberado
        		cAprov += "Ok"
        	Case SCR->CR_STATUS=="04" //Bloqueado
        		cAprov += "BLQ"
			Case SCR->CR_STATUS=="05" //Nivel Liberado
				cAprov += "##"
			Case SCR->CR_STATUS=="06" //Rejeitado
				cAprov += "REJ"
				
			OtherWise                 //Aguar.Lib
				cAprov += "??"
		EndCase
		cAprov += "] - "
		dbSelectArea("SCR")
		dbSkip()
	Enddo
	If !Empty(SC7->C7_GRUPCOM)
		dbSelectArea("SAJ")
		dbSetOrder(1)
		dbSeek(cFilSAJ+SC7->C7_GRUPCOM)
		While !Eof() .And. SAJ->AJ_FILIAL+SAJ->AJ_GRCOM == cFilSAJ+SC7->C7_GRUPCOM
			If SAJ->AJ_USER != SC7->C7_USER
				If nPAJ_MSBLQL > 0
					If SAJ->AJ_MSBLQL == "1"
						dbSkip()
						LOOP
					EndIf
				EndIf
				oHash:Get(SAJ->AJ_USER,@xUsrName)
				cAlter += AllTrim(xUsrName)+"/"
			EndIf
			dbSelectArea("SAJ")
			dbSkip()
		EndDo
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Aprovadores  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lNewAlc                   
	@ li,001 PSAY "|"
	@ li,003 PSAY STR0052		//"Comprador Responsavel :"
	@ li,027 PSAY Substr(cComprador,1,60)
	@ li,088 PSAY "|"
	@ li,089 PSAY STR0060      //"BLQ:Bloqueado"
	@ li,102 PSAY "|"
	@ li,142 - nDifColCC PSAY "|"
	li++
	nAuxLin := Len(cAlter)
	@ li,001 PSAY "|"
	@ li,003 PSAY STR0053		//"Compradores Alternativos :"
	While nAuxLin > 0 .Or. lImpLeg
		@ li,029 PSAY Substr(cAlter,Len(cAlter)-nAuxLin+1,60)
		@ li,088 PSAY "|"
		If lImpLeg
			@ li,089 PSAY STR0061   //"Ok:Liberado"
			lImpLeg := .F.
		EndIf
		@ li,102 PSAY "|"
		@ li,142 - nDifColCC PSAY "|"
		nAuxLin -= 60
		li++
	EndDo
	
	nAuxLin := Len(cAprov)
	lImpLeg := .T.
	
	While nAuxLin > 0	.Or. lImpLeg
		@ li,001 PSAY "|"
		If lImpLeg  // Imprimir soh a 1a vez
			@ li,003 PSAY STR0054		//"Aprovador(es) :"
		EndIf
		@ li,018 PSAY Substr(cAprov,Len(cAprov)-nAuxLin+1,70)
		@ li,088 PSAY "|"
		If lImpLeg3   // Imprimir soh a 3a vez
			@ li,089 PSAY STR0131 //"REJ:REJEITADO"
			lImpLeg3 := .F.
		EndIf
		If lImpLeg2  // Imprimir soh a 2a vez
			@ li,089 PSAY STR0067 //"##:Nivel.Lib"
			lImpLeg2 := .F.
			lImpLeg3 := .T.
		EndIf
		If lImpLeg   // Imprimir soh a 1a vez
			@ li,089 PSAY STR0062  //"??:Aguar.Lib"
			lImpLeg  := .F.
			lImpLeg2 := .T.
		EndIf

		@ li,102 PSAY "|"
		@ li,142 - nDifColCC PSAY "|"
	
		nAuxLin -=70
		li++
	EndDo
	If lImpLeg2
		lImpLeg2 := .F.
		lImpLeg3 := .T.
		@ li,001 PSAY "|"
		@ li,088 PSAY "|"
		@ li,089 PSAY STR0067 //"##:Nivel Lib"
		@ li,102 PSAY "|"
		@ li,142 - nDifColCC PSAY "|"
		li++
    EndIf
	If lImpLeg3
		lImpLeg3 := .F.
		@ li,001 PSAY "|"
		@ li,088 PSAY "|"
		@ li,089 PSAY STR0131 //"REJ:REJEITADO"
		@ li,102 PSAY "|"
		@ li,142 - nDifColCC PSAY "|"
		li++		
	EndIf
	If nAuxLin == 0
		li++
	EndIf

	@ li,001 PSAY "|"
	@ li,002 PSAY Replicate("-",limite)
	@ li,142 - nDifColCC PSAY "|"
	li++
	
EndIf

@ li,001 PSAY STR0029	//"|   NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero da Autorizacao de Entrega."
@ li,142 - nDifColCC PSAY "|"   

li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)     
@ li,142 - nDifColCC PSAY "|"

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpRodape³ Autor ³ Wagner Xavier         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o rodape do formulario e salta para a proxima folha³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpRodape(Void)   			         					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 					                     				      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpRodape()
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,070 PSAY STR0030		//"Continua ..."
@ li,142 - nDifColCC PSAY "|"
li++
@ li,001 PSAY "|"
@ li,002 PSAY Replicate("-",limite)
@ li,142 - nDifColCC PSAY "|"
li:=0
Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpCabec ³ Autor ³ Wagner Xavier         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o Cabecalho do Pedido de Compra                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpCabec(Void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpCabec(ncw)
Local nOrden, cCGC
LOCAL cMoeda
Local cCGCFOR := ""

cMoeda := Iif(mv_par12<10,Str(mv_par12,1),Str(mv_par12,2))

If Val(cMoeda) == 0
	cMoeda := "1"
Endif

@ 01,001 PSAY "|"
@ 01,002 PSAY Replicate("-",limite)
@ 01,142 - nDifColCC PSAY "|"
@ 02,001 PSAY "|"
@ 02,029 PSAY IIf(nOrdem>1,(STR0033)," ")		//" - continuacao"

If mv_par08 == 1 .OR. mv_par08 == 3
	@ 02,045 PSAY (STR0031)+" - "+GetMV("MV_MOEDA"+cMoeda) 	//"| P E D I D O  D E  C O M P R A S"
Else
	@ 02,045 PSAY (STR0032)+" - "+GetMV("MV_MOEDA"+cMoeda)  //"| A U T. D E  E N T R E G A     "
EndIf

If ( Mv_PAR08==2 )
	@ 02,090 PSAY "|"
	@ 02,093 PSAY SC7->C7_NUMSC + "/" + SC7->C7_NUM  //    Picture PesqPict("SC7","c7_num")	
Else
	@ 02,096 PSAY "|"
	@ 02,101 PSAY SC7->C7_NUM      Picture PesqPict("SC7","C7_NUM")
EndIf

@ 02,107 PSAY "/"+Str(nOrdem,1)
@ 02,112 PSAY IIf(SC7->C7_QTDREEM>0,Str(SC7->C7_QTDREEM+1,2)+STR0034+Str(ncw,2)+STR0035," ")		//"a.Emissao "###"a.VIA"
@ 02,142 - nDifColCC PSAY "|"
@ 03,001 PSAY "|"
@ 03,003 PSAY Substr(SM0->M0_NOMECOM,1,42)
@ 03,045 PSAY "|"+Replicate("-",95 - nDifColCC)
@ 03,142 - nDifColCC PSAY "|"
@ 04,001 PSAY "|"
@ 04,003 PSAY Substr(SM0->M0_ENDENT,1,42)
dbSelectArea("SA2")
dbSetOrder(1)
dbSeek(cFilSA2+SC7->C7_FORNECE+SC7->C7_LOJA)
@ 04,045 PSAY "|"
If ( cPaisLoc$"ARG|POR|EUA" )
	@ 04,047 PSAY Substr(SA2->A2_NOME,1,35)+"-"+SA2->A2_COD+"-"+SA2->A2_LOJA	
Else
	@ 04,047 PSAY Substr(;
	If(lLGPD,RetTxtLGPD(SA2->A2_NOME,"A2_NOME"),SA2->A2_NOME),;
	1,35)+"-"+SA2->A2_COD+"-"+SA2->A2_LOJA+(STR0036)+" " +;
	If(lLGPD,RetTxtLGPD(SA2->A2_INSCR,"A2_INSCR"),SA2->A2_INSCR)		//" I.E.: "	
EndIf
@ 04,142 - nDifColCC PSAY "|"
@ 05,001 PSAY "|"
@ 05,003 PSAY (STR0009)+Trans(SM0->M0_CEPENT,cCepPict)+" - "+Trim(SM0->M0_CIDENT)+" - "+SM0->M0_ESTENT		//"CEP :"
@ 05,045 PSAY "|"

@ 05,047 PSAY SubStr(;
If(lLGPD,RetTxtLGPD(SA2->A2_END,"A2_END"),SA2->A2_END),;
1,42)   Picture PesqPict("SA2","A2_END")

@ 05,089 PSAY "-  "+SubStr(Trim(;
If(lLGPD,RetTxtLGPD(SA2->A2_BAIRRO,"A2_BAIRRO"),SA2->A2_BAIRRO);
),1,(53-nDifColCC))	Picture "@!"

@ 05,142 - nDifColCC PSAY "|"
@ 06,001 PSAY "|"
@ 06,003 PSAY STR0037+SM0->M0_TEL		//"TEL: "
@ 06,023 PSAY STR0038+SM0->M0_FAX		//"FAX: "
@ 06,045 PSAY "|"

@ 06,047 PSAY Trim(;
If(lLGPD,RetTxtLGPD(SA2->A2_MUN,"A2_MUN"),SA2->A2_MUN) ;
)  Picture "@!"

@ 06,069 PSAY ;
If(lLGPD,RetTxtLGPD(SA2->A2_EST,"A2_EST"),SA2->A2_EST) ;
Picture PesqPict("SA2","A2_EST")

@ 06,074 PSAY STR0009	//"CEP :"
@ 06,081 PSAY ;
If(lLGPD,RetTxtLGPD(SA2->A2_CEP,"A2_CEP"),SA2->A2_CEP) ;  		
Picture PesqPict("SA2","A2_CEP")

dbSelectArea("SX3")
nOrden = IndexOrd()
dbSetOrder(2)
dbSeek("A2_CGC")
cCGC := Alltrim(X3TITULO())
@ 06,093 PSAY cCGC+":" //"CGC: "
dbSetOrder(nOrden)

dbSelectArea("SA2")
If cPaisLoc == "BRA"
	cCGCFOR	:= Transform(;
	If(lLGPD,RetTxtLGPD(SA2->A2_CGC,"A2_CGC"),SA2->A2_CGC),;
	Iif(SA2->A2_TIPO == 'F',Substr(PICPES(SA2->A2_TIPO),1,17),Substr(PICPES(SA2->A2_TIPO),1,21))) 
Else  
	cCGCFOR	:= SA2->A2_CGC
EndIf  
@ 06,103 PSAY cCGCFOR 
@ 06,142 - nDifColCC PSAY "|"
@ 07,001 PSAY "|"
@ 07,002 PSAY (cCGC) + " "+ Transform(SM0->M0_CGC,cCgcPict)		//"CGC: "
If cPaisLoc == "BRA"
	@ 07,029 PSAY (STR0041)+ InscrEst()		//"IE:"
EndIf
@ 07,045 PSAY "|"

@ 07,047 PSAY ;
If(lLGPD,RetTxtLGPD(SC7->C7_CONTATO,"C7_CONTATO"),SC7->C7_CONTATO) ;
Picture PesqPict("SC7","C7_CONTATO")

@ 07,069 PSAY STR0042	//"FONE: "

@ 07,075 PSAY "("+Substr(;
If(lLGPD,RetTxtLGPD(SA2->A2_DDD,"A2_DDD"),SA2->A2_DDD),;
1,3)+") "+Substr(;
If(lLGPD,RetTxtLGPD(SA2->A2_TEL,"A2_TEL"),SA2->A2_TEL),;
1,15)

@ 07,100 PSAY (STR0038)	//"FAX: "

@ 07,106 PSAY "("+Substr(;
If(lLGPD,RetTxtLGPD(SA2->A2_DDD,"A2_DDD"),SA2->A2_DDD),;
1,3)+") "+SubStr(;
If(lLGPD,RetTxtLGPD(SA2->A2_FAX,"A2_FAX"),SA2->A2_FAX),;
1,15)

@ 07,142 - nDifColCC PSAY "|"
@ 08,001 PSAY "|"
@ 08,002 PSAY Replicate("-",limite)
@ 08,142 - nDifColCC PSAY "|"

If mv_par08 == 1 .OR. mv_par08 == 3
	@ 09,001 PSAY "|"
	@ 09,002 PSAY STR0043	//"Itm|"
	@ 09,009 PSAY STR0044	//"Codigo      "
	@ 09,022 PSAY STR0045	//"|Descricao do Material"
	@ 09,049 PSAY STR0046	//"|UM|  Quant."
	If cPaisLoc <> "BRA"
		@ 09,065 PSAY IIF(nDifColcc == 0,STR0056,STR0057)	//"|Valor Unitario|      Valor Total   |Entrega   |  C.C.   | S.C. |"
	Else
		@ 09,065 PSAY IIF(nDifColcc == 0,STR0047,STR0055)	//"|Valor Unitario|IPI% |  Valor Total   | Entrega  |  C.C.   | S.C. |"
	EndIf
	@ 10,001 PSAY "|"
	@ 10,002 PSAY Replicate("-",limite)
	@ 10,142 - nDifColCC PSAY "|"
Else
	@ 09,001 PSAY "|"
	@ 09,002 PSAY STR0043	//"Itm|"
	@ 09,009 PSAY STR0044	//"Codigo      "
	@ 09,022 PSAY STR0045	//"|Descricao do Material"
	@ 09,049 PSAY STR0046	//"|UM|  Quant."
	@ 09,065 PSAY STR0048	//"|Valor Unitario|  Valor Total   |Entrega | Numero da OP  "
	@ 09,142 - nDifColCC PSAY "|"
	@ 10,001 PSAY "|"
	@ 10,002 PSAY Replicate("-",limite)
	@ 10,142 - nDifColCC PSAY "|"
EndIf
dbSelectArea("SC7")
li := 10
Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R110Center³ Autor ³ Jose Lucas            ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Centralizar o Nome do Liberador do Pedido.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ExpC1 := R110CenteR(ExpC2)                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 := Nome do Liberador                                 ³±±
±±³Parametros³ ExpC2 := Nome do Liberador Centralizado                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R110Center(cLiberador)
Return( Space((30-Len(AllTrim(cLiberador)))/2)+AllTrim(cLiberador) )

/*/
Função R110ChkPerg
Autor  Vitor Pires
Data 21/09/19
Descrição Funcao para buscar as perguntas que o usuario nao pode alterar para impressao de relatorios direto do browse
/*/

Static Function R110ChkPerg()
	
	Local lPcHabPer := SuperGetMv("MV_PCHABPG", .F., .F.)
	
	If lPcHabPer
		mv_par05 := U_ChkPergUs(cUserId,"MTR110","05",mv_par05)
		mv_par08 := U_ChkPergUs(cUserId,"MTR110","08",mv_par08)
		mv_par09 := U_ChkPergUs(cUserId,"MTR110","09",mv_par09)
		mv_par10 := U_ChkPergUs(cUserId,"MTR110","10",mv_par10)
		mv_par11 := U_ChkPergUs(cUserId,"MTR110","11",mv_par11)
		mv_par14 := U_ChkPergUs(cUserId,"MTR110","14",mv_par14)
	Else
		mv_par05 := 2
		mv_par08 := SC7->C7_TIPO
		mv_par09 := 1
		mv_par10 := 3
		mv_par11 := 3
		mv_par14 := 1
	EndIf

Return
                                                    
/*/
Função ChkPergUs
Autor  Nereu Humberto Junior 
Data 21/09/07
Descrição FFuncao para buscar as perguntas que o usuario nao pode alterar para impressao de relatorios direto do browse
Sintaxe   xVar := U_ChkPergUs(cUserId,cGrupo,cSeq,xDefault)
Parametros cUserId 	: Id do usuario
           cGrupo 	: Grupo de perguntas
           cSeq 	 	: Numero da sequencia da pergunta
			  xDefault	: Valor default para o parametro
 Uso       MatR110
 Versão 2: Vitor Pires	25/10/2019
/*/
User Function ChkPergUs(cUserId,cGrupo,cSeq,xDefault)

Local xRet   := Nil
Local cParam := "MV_PAR"+cSeq

SXK->(dbSetOrder(2))
If SXK->(dbSeek("U"+cUserId+cGrupo+cSeq))
	If ValType(&cParam) == "C"
		xRet := AllTrim(SXK->XK_CONTEUD)
	ElseIf 	ValType(&cParam) == "N"
		xRet := Val(AllTrim(SXK->XK_CONTEUD))
	ElseIf 	ValType(&cParam) == "D"
		xRet := CTOD((AllTrim(SXK->XK_CONTEUD)))
	Endif
Else
	If !(Type(cParam)=='U')
		xRet := &cParam
	Else
		xRet := xDefault
	EndIf		
Endif

Return(xRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R110FIniPC³ Autor ³ Edson Maricate        ³ Data ³20/05/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Inicializa as funcoes Fiscais com o Pedido de Compras      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R110FIniPC(ExpC1,ExpC2)                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 := Numero do Pedido                                  ³±±
±±³          ³ ExpC2 := Item do Pedido                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR110,MATR120,Fluxo de Caixa                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R110FIniPC(cPedido,cItem,cSequen,cFiltro)

Local aArea		:= GetArea()
Local aAreaSC7	:= SC7->(GetArea())
Local cValid	:= ""
Local nPosRef	:= 0
Local nItem		:= 0
Local cItemDe	:= IIf(cItem==Nil,'',cItem)
Local cItemAte	:= IIf(cItem==Nil,Repl('Z',Len(SC7->C7_ITEM)),cItem)
Local cRefCols	:= ''
Local nX
Static aStru	:= FWFormStruct(3,"SC7")[1]

DEFAULT cSequen	:= ""
DEFAULT cFiltro	:= "" 
DEFAULT cRegra    := SuperGetMV("MV_ARRPEDC",.F.,"ROUND")
DEFAULT nTamTot   := TamSX3("C7_PRECO")[2]

If !(cRegra $ "ROUND|NOROUND")
	cRegra := "LEGADO"
Endif

dbSelectArea("SC7")
dbSetOrder(1)
If dbSeek(cFilSC7+cPedido+cItemDe+Alltrim(cSequen))
	MaFisEnd()
	MaFisIni(SC7->C7_FORNECE,SC7->C7_LOJA,"F","N","R",{})
	While !Eof() .AND. SC7->C7_FILIAL+SC7->C7_NUM == cFilSC7+cPedido .AND. ;
			SC7->C7_ITEM <= cItemAte .AND. (Empty(cSequen) .OR. cSequen == SC7->C7_SEQUEN)

		// Nao processar os Impostos se o item possuir residuo eliminado  
		If &cFiltro
			SC7->(dbSkip())
			Loop
		EndIf

		If !Empty(cRegra)
			If AllTrim(cRegra) == "NOROUND"
				nValTotSC7 := NoRound( SC7->C7_QUANT * SC7->C7_PRECO, nTamTot )
			ElseIf AllTrim(cRegra) == "ROUND"
				nValTotSC7 := Round( SC7->C7_QUANT * SC7->C7_PRECO, nTamTot )
			Else
				nValTotSC7 := SC7->C7_TOTAL
			EndIf
		EndIf
            
		// Inicia a Carga do item nas funcoes MATXFIS  
		nItem++
		MaFisIniLoad(nItem)

		For nX := 1 To Len(aStru)
			cValid	:= StrTran(UPPER(GetCbSource(aStru[nX][7]))," ","")
			cValid	:= StrTran(cValid,"'",'"')
			If "MAFISREF" $ cValid .And. !(aStru[nX][14]) //campos que não são virtuais
				nPosRef  := AT('MAFISREF("',cValid) + 10
				cRefCols := Substr(cValid,nPosRef,AT('","MT120",',cValid)-nPosRef )
				// Carrega os valores direto do SC7.
				If aStru[nX][3] == "C7_TOTAL" .AND. !Empty(cRegra) 
					MaFisLoad(cRefCols,nValTotSC7,nItem)
				Else           
					MaFisLoad(cRefCols,&("SC7->"+ aStru[nX][3]),nItem)
				EndIf
			EndIf
		Next nX		

		MaFisEndLoad(nItem,2)
		
		SC7->(dbSkip())
	End
EndIf

RestArea(aAreaSC7)
RestArea(aArea)

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R110Logo  ³ Autor ³ Materiais             ³ Data ³07/01/2015³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Retorna string com o nome do arquivo bitmap de logotipo    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R110Logo()

Local cBitmap := "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP" // Empresa+Filial

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao encontrar o arquivo com o codigo do grupo de empresas ³
//³ completo, retira os espacos em branco do codigo da empresa   ³
//³ para nova tentativa.                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !File( cBitmap )
	cBitmap := "LGRL" + AllTrim(SM0->M0_CODIGO) + SM0->M0_CODFIL+".BMP" // Empresa+Filial
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao encontrar o arquivo com o codigo da filial completo,  ³
//³ retira os espacos em branco do codigo da filial para nova    ³
//³ tentativa.                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !File( cBitmap )
	cBitmap := "LGRL"+SM0->M0_CODIGO + AllTrim(SM0->M0_CODFIL)+".BMP" // Empresa+Filial
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se ainda nao encontrar, retira os espacos em branco do codigo³
//³ da empresa e da filial simultaneamente para nova tentativa.  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !File( cBitmap )
	cBitmap := "LGRL" + AllTrim(SM0->M0_CODIGO) + AllTrim(SM0->M0_CODFIL)+".BMP" // Empresa+Filial
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao encontrar o arquivo por filial, usa o logo padrao     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !File( cBitmap )
	cBitmap := "LGRL"+SM0->M0_CODIGO+".BMP" // Empresa
EndIf

Return cBitmap

/*/{Protheus.doc} R110cObs
//Receber conteúdo do campo "Observações" para a impressão correta 

@param aAux1					Pegar array do cObs01 onde foi separado com "enter" como quebra de linha
@param nTamLinha				Definição do máximo de caracteres que precisa ser definido na linha do campo Observações 

@author Gustavo Mantovani Cândido
@since 09/05/2018
@version 1.0
/*/
User Function R110cObs(aAux1, nTamLinha)	
	Local cVar
	Local nObs := 1
	Local nTam := 0
	Local nX, nY
	Local nQtdLinhas := 0
	For nX := 1 To Len(aAux1)				
		nY := 1
		nQtdLinhas := Ceiling(Len(aAux1[nX]) / nTamLinha)
		While nY <= nQtdLinhas .And. nObs <= 16			
			cVar := "cObs"+StrZero(nObs,2)
			nTam := (nTamLinha * ( nY - 1 )) + 1

			&(cVar) := Substr(aAux1[nX],nTam, IIF( nY <> nQtdLinhas, nTamLinha, (( Len(aAux1[nX]) - ( nTam ))) + 1 ))
			nObs++	
			nY++					
		EndDo
	Next nY	
Return Nil

/*/{Protheus.doc} R110Hash
//Carga de usuários do sistema para objeto HashMap
@Return oHash Objeto 		

@author Fabiano Dantas
@since 19/10/2022
@version 1.0
/*/
User Function R110Hash()
	Local aAllusers  := FWSFALLUSERS()
	Local nM 		 := 0 
	 	
	oHash := tHashMap():New()
	For nM := 1 To Len(aAllusers)
		oHash:Set(aAllusers[nM][2],aAllusers[nM][4])//Carrega o codigo e nome completo do usuário. 
	Next

Return oHash 
