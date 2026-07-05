/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR911.CH"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MATR911  ³ Autor ³ Nereu Humberto Junior ³ Data ³ 20.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Kardex fisico - financeiro                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³Data    ³ BOPS     ³ Motivo da Alteracao                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Jonathan Glz³20/07/15³PCREQ-4256³Se elimina la funcion AjustaSX1() que ³±±
±±³            ³        ³          ³hace modificacion a SX1 por motivo de ³±±
±±³            ³        ³          ³adecuacion a fuentes a nuevas estruc- ³±±
±±³            ³        ³          ³turas SX para Version 12.             ³±±
±±³Alf. Medrano³19/11/15³PCREQ-4263³ se realiza merge 12.1.8              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Descri‡ao ³ PLANO DE MELHORIA CONTINUA        ³Programa:  MATR911.PRX  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ITEM PMC  ³ Responsavel              ³ Data       	|BOPS             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³      01  ³                          ³           	|                 ³±±
±±³      02  ³ Ricardo Berti            ³ 29/09/2006    | 00000105535     ³±±
±±³      03  ³                          ³           	|                 ³±±
±±³      04  ³ Ricardo Berti            ³ 29/09/2006    | 00000105535     ³±±
±±³      05  ³                          ³           	|                 ³±±
±±³      06  ³                          ³           	|                 ³±±
±±³      07  ³                          ³           	|                 ³±±
±±³      08  ³                          ³           	|                 ³±±
±±³      09  ³                          ³           	|                 ³±±
±±³      10  ³                          ³           	|                 ³±±
±±³L.Enríquez³18/01/2017³SERINN001-522³-Se realiza merge para hacer elimi-³±±
±±³          ³          ³             ³ nación de función MTR911CUFac para³±±
±±³          ³          ³             ³ que no afecte la tabla SX1 CTREE. ³±±
±±³Oscar G.  ³20/08/2019³DMINA-7243   ³-Se ajustan filtros de Query en fun³±±
±±³          ³          ³             ³ ReportPrint para uso de filtros   ³±±
±±³          ³          ³             ³ personalizados.                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Matr911()

	Local oReport	:= Nil
	
	Private oTot1	:= Nil
	Private oTot2	:= Nil
	Private oTot3	:= Nil

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:= ReportDef()
	oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Nereu Humberto Junior  ³ Data ³20.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
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
Static Function ReportDef()

Local oReport		:= Nil 
Local oSection1		:= Nil
Local oSection2		:= Nil
Local oSection3		:= Nil
Local cPicD1Qt		:= PesqPict("SD1","D1_QUANT" ,18)
Local cTamD1Qt		:= TamSX3('D1_QUANT')[1]
Local cPicD1Cust	:= PesqPict("SD1","D1_CUSTO",18)
Local cTamD1Cust	:= TamSX3('D1_CUSTO')[1]
Local cPicD2Qt		:= PesqPict("SD2","D2_QUANT" ,18)
Local cTamD2Qt		:= TamSX3('D2_QUANT')[1]
Local cPicD2Cust	:= PesqPict("SD2","D2_CUSTO1",18)
Local cTamD2Cust	:= TamSX3('D2_CUSTO1')[1]
Local cTamDoc		:= TamSX3('D1_DOC')[1]
Local cPicB2Qt		:= PesqPictQt("B2_QATU" ,18)
Local nTamCod		:= TamSX3('B1_COD')[1]
Local nTamDesc		:= TamSX3('B1_DESC')[1]
Local nTamGrup		:= TamSX3('B1_GRUPO')[1]
Local nTamTipo		:= TamSX3('B1_TIPO')[1]
Local nTamUM		:= TamSX3('B1_UM')[1]
Local nTamLoc		:= TamSX3('B2_LOCALIZ')[1]
Local nTamTES		:= TamSX3('FC_TES')[1]
Local nTamCF		:= TamSX3('F4_CF')[1]
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se utiliza custo unificado por Empresa/Filial       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lCusUnif		:= IIf(FindFunction("A330CusFil"),A330CusFil(),GetMV("MV_CUSFIL",.F.))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao utilizada para verificar a ultima versao dos fontes      ³
//³ SIGACUS.PRW, SIGACUSA.PRX e SIGACUSB.PRX, aplicados no rpo do   |
//| cliente, assim verificando a necessidade de uma atualizacao     |
//| nestes fontes. NAO REMOVER !!!							        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !(FindFunction("SIGACUS_V") .and. SIGACUS_V() >= 20050512)
    Final(STR0058+" SIGACUS.PRW !!!")  //"Atualizar patch do programa SIGACUS.PRW"
EndIf
If !(FindFunction("SIGACUSA_V") .and. SIGACUSA_V() >= 20050512)
    Final(STR0058+" SIGACUSA.PRX !!!")  //"Atualizar patch do programa SIGACUSA.PRX"
EndIf
If !(FindFunction("SIGACUSB_V") .and. SIGACUSB_V() >= 20050512)
    Final(STR0058+" SIGACUSB.PRX !!!")  //"Atualizar patch do programa SIGACUSB.PRX"
EndIf
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
oReport:= TReport():New("MATR911",STR0003,"MTR911", {|oReport| ReportPrint(oReport)},STR0001+" "+STR0002) //"Kardex Fisico-Financeiro (DIA)"##"Este programa emitir  uma rela‡„o com as movimenta‡”es"##"dos produtos Selecionados,Ordenados por Dia."
oReport:SetLandscape()    
oReport:SetTotalInLine(.F.)

Pergunte("MTR911",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Sessao 1 - Dados do Produto                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport,STR0064,{"SB1","SB2"}) //"Produtos"
oSection1 :SetTotalInLine(.F.)
oSection1 :SetReadOnly()
oSection1 :SetLineStyle()

TRCell():New(oSection1,"B1_COD"  ,"SB1",/*Titulo*/,"@!"						,nTamCod,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_DESC" ,"SB1",/*Titulo*/,"@!"						,nTamDesc,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_UM"   ,"SB1",STR0059   ,/*Picture*/						,nTamUM,/*lPixel*/,/*{|| code-block de impressao }*/) //"UM"
TRCell():New(oSection1,"B1_TIPO" ,"SB1",STR0060   ,"@!"						,nTamTipo,/*lPixel*/,/*{|| code-block de impressao }*/) //"TIPO"
TRCell():New(oSection1,"B1_GRUPO","SB1",STR0061   ,"@!"						,nTamGrup,/*lPixel*/,/*{|| code-block de impressao }*/) //"GRUPO"
TRCell():New(oSection1,"nCusMed" ,"   ",STR0062   ,If(cPaisloc=="CHI",,cPicD1Cust),cTamD1Cust ,/*lPixel*/,/*{|| code-block de impressao }*/) //"COSTO MEDIO"
TRCell():New(oSection1,"nQtdSal" ,"   ",STR0040   ,cPicB2Qt					    ,cTamD1Qt   ,/*lPixel*/,/*{|| code-block de impressao }*/) //"CTD. SALDO"
TRCell():New(oSection1,"nVlrSal" ,"   ",STR0041   ,If(cPaisloc=="CHI",,cPicD1Cust),cTamD1Cust ,/*lPixel*/,/*{|| code-block de impressao }*/) //"VLR.TOTAL SALDO"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Sessao 2 - Cont. dos dados do Produto           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,STR0065,{"SB2"}) //"Saldos em Estoque"
oSection2 :SetTotalInLine(.F.)
oSection2 :SetReadOnly()
oSection2 :SetLineStyle()

TRCell():New(oSection2,"B2_LOCALIZ","SB2",STR0063,"@!",nTamLoc,/*lPixel*/,/*{|| code-block de impressao }*/) //"DIRECCION"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Sessao 3 - Movimentos                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3 := TRSection():New(oSection2,STR0066,{"SD1","SD2","SD3"}) //"Movimentação dos Produtos"
oSection3 :SetHeaderPage()
oSection3 :SetTotalInLine(.F.)
oSection3 :SetTotalText(STR0017) //	"T O T A I S  :"
oSection3 :SetReadOnly()

TRCell():New(oSection3,"dDtMov"   ,"   ",STR0042+CRLF+STR0043 ,/*Picture*/					    ,10,/*lPixel*/,/*{|| code-block de impressao }*/) //"OPERACION" - "FECHA"
TRCell():New(oSection3,"cTES"     ,"   ",STR0044			   ,"@!"						    ,nTamTES,/*lPixel*/,/*{|| code-block de impressao }*/) //"TES"
TRCell():New(oSection3,"cCF"      ,"   ",STR0045              ,"@!"						    ,nTamCF,/*lPixel*/,/*{|| code-block de impressao }*/) //"C.F"
TRCell():New(oSection3,"cDoc"     ,"   ",STR0046+CRLF+STR0047 ,"@!"						    ,cTamDoc    ,/*lPixel*/,/*{|| code-block de impressao }*/) //"DOCUMENTO" - "NUMERO"
TRCell():New(oSection3,"nENTQtd"  ,"   ",STR0048+CRLF+STR0049 ,cPicD1Qt					    ,cTamD1Qt   ,/*lPixel*/,/*{|| code-block de impressao }*/) //"ENTRADAS" - "CANTIDAD"
TRCell():New(oSection3,"nENTCus"  ,"   ",STR0048+CRLF+STR0050 ,If(cPaisloc=="CHI",,cPicD1Cust),cTamD1Cust ,/*lPixel*/,/*{|| code-block de impressao }*/) //"ENTRADAS" - "COSTO TOTAL"
TRCell():New(oSection3,"nCusMov"  ,"   ",STR0051+CRLF+STR0052 ,If(cPaisloc=="CHI",,cPicD1Cust),cTamD1Cust ,/*lPixel*/,/*{|| code-block de impressao }*/) //"COSTO MEDIO" - "DEL MOVIMIENTO"
TRCell():New(oSection3,"nSAIQtd"  ,"   ",STR0053+CRLF+STR0049 ,cPicB2Qt					    ,cTamD2Qt   ,/*lPixel*/,/*{|| code-block de impressao }*/) //"SALIDAS" - "CANTIDAD"
TRCell():New(oSection3,"nSAICus"  ,"   ",STR0053+CRLF+STR0050 ,If(cPaisloc=="CHI",,cPicD2Cust),cTamD2Cust ,/*lPixel*/,/*{|| code-block de impressao }*/) //"SALIDAS" - "COSTO TOTAL"
TRCell():New(oSection3,"nSALDQtd" ,"   ",STR0054+CRLF+STR0049 ,cPicB2Qt					    ,cTamD1Qt   ,/*lPixel*/,/*{|| code-block de impressao }*/) //"SALDO" - "CANTIDAD"
TRCell():New(oSection3,"nSALDCus" ,"   ",STR0054+CRLF+STR0055 ,If(cPaisloc=="CHI",,cPicD1Cust),cTamD1Cust ,/*lPixel*/,/*{|| code-block de impressao }*/) //"SALDO" - "VALOR TOTAL"
TRCell():New(oSection3,"cCCPVPJOP","   ",STR0056+CRLF+STR0057 ,"@!"                            ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"P.V.,PRO," - "CC o OP"

TRFunction():New(oSection3:Cell("nENTQtd"),NIL,"SUM",/*oBreak*/,"",cPicD1Qt                        ,/*uFormula*/,.T.,.F.) 
oTot1:=TRFunction():New(oSection3:Cell("nENTCus"),NIL,"SUM",/*oBreak*/,"",If(cPaisloc=="CHI",,cPicD1Cust),/*uFormula*/,.T.,.F.) 

TRFunction():New(oSection3:Cell("nSAIQtd"),NIL,"SUM",/*oBreak*/,"",cPicB2Qt                        ,/*uFormula*/,.T.,.F.) 
oTot2:=TRFunction():New(oSection3:Cell("nSAICus"),NIL,"SUM",/*oBreak*/,"",If(cPaisloc=="CHI",,cPicD2Cust),/*uFormula*/,.T.,.F.) 

TRFunction():New(oSection3:Cell("nSALDQtd"),NIL,"ONPRINT",/*oBreak*/,"",cPicB2Qt                        ,{|| oSection3:Cell("nSALDQtd"):GetValue(.T.) },.T.,.F.) 
oTot3:=TRFunction():New(oSection3:Cell("nSALDCus"),NIL,"ONPRINT",/*oBreak*/,"",If(cPaisloc=="CHI",,cPicD1Cust),{|| oSection3:Cell("nSALDCus"):GetValue(.T.) },.T.,.F.) 

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³21.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local oSection1	:= oReport:Section(1) 
Local oSection2	:= oReport:Section(1):Section(1)  
Local oSection3	:= oReport:Section(1):Section(1):Section(1)  
Local cSelectD1	:= '', cWhereD1 := '%%'
Local cSelectD2	:= '', cWhereD2 := '%%'
Local cSelectD3	:= '', cWhereD3 := '%%'
Local cWhereRE	:= '', cWhereB2 := '%%'
Local dData		:= Ctod("")
Local cProdAnt	:= ""
Local aSB1		:= {}
Local aSD1		:= {}
Local aSD3		:= {}
Local aSD2		:= {}
Local bWhile,i
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera arquivo de Trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aTamQ			:= TamSX3("B2_QATU")
Local aTamC			:= TamSX3("B2_CM1")
Local aTamX			:= TamSX3("F4_CF")
Local aTamB2Loc		:= TamSX3("B2_LOCAL")
Local aCampos		:= {}
Local cPicD1Qt		:= PesqPict("SD1","D1_QUANT" ,18)
Local cTamD1Qt		:= TamSX3('D1_QUANT')[1]
Local cPicD1Cust	:= PesqPict("SD1","D1_CUSTO",18)
Local cTamD1Cust	:= TamSX3('D1_CUSTO')[1]
Local cPicD2Qt		:= PesqPict("SD2","D2_QUANT" ,18)
Local cTamD2Qt		:= TamSX3('D2_QUANT')[1]
LOCAL cPicD2Cust	:= PesqPict("SD2","D2_CUSTO1",18)
Local lRemInt		:= SuperGetMv("MV_REMINT",.F.,.F.)
Local lLocProc		:= alltrim(mv_par08) == GetMv("MV_LOCPROC")
Local lInverteMov	:= .F.
Local cAliasTop		:= ""
Local lUsaD2DIG		:= IIF(FindFunction("UsaD2DTDIG"), UsaD2DTDIG(), .F.)
Local cFiltSB1		:= ""
Local cFiltSB2		:= ""
Local cFiltSD1		:= ""
Local cFiltSD2		:= ""
Local cFiltSD3		:= ""

Private bBloco		:= { |nV,nX| Trim(nV)+IIf(Valtype(nX)='C',"",Str(nX,1)) }
Private aGrupos		:= {}
Private aUnids		:= {}
Private lContinua  := .T.
Private cProdIni   := mv_par01
Private nRec1      := 0
Private nRec2      := 0
Private nRec3      := 0
Private aSalAtu    := {}
Private nEntrada   := 0
Private nSaida		:= 0
Private nCEntrada  := 0
Private nCSaida    := 0
Private cPicB2Qt2	:= PesqPictQt("B2_QTSEGUM" ,18)
Private nDec       := MsDecimais(mv_par11)
Private lFirst1    := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se utiliza custo unificado por Empresa/Filial       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private lCusUnif	:= IIf(FindFunction("A330CusFil"),A330CusFil(),GetMV("MV_CUSFIL",.F.))
Private cPictChile	:= ""

lCusUnif := lCusUnif .And. mv_par08 == Repl("*",TamSX3("B2_LOCAL")[1])

AADD(aCampos,{"ORDTMP"    ,"C",01,0})
AADD(aCampos,{"PRODUTO"  ,"C",15,0})
AADD(aCampos,{"EMISSAO"  ,"D",08,0})
AADD(aCampos,{"SEQCALC"  ,"C",14,0})
AADD(aCampos,{"NUMSEQ"   ,"C",14,0})
AADD(aCampos,{"CF"       ,"C",aTamX[1],aTamX[2]})
AADD(aCampos,{"TES"      ,"C",03,0})
AADD(aCampos,{"REMITO"   ,"C",TamSX3("CM_REMITO")[1],0})
AADD(aCampos,{"CLIFOR"  ,"C",TamSX3("D2_CLIENTE")[1],0})
AADD(aCampos,{"SERIE"    ,"C",03,0})
AADD(aCampos,{"LOJA"     ,"C",TamSX3("D1_LOJA")[1],0})
AADD(aCampos,{"ITEMREM"  ,"C",TamSX3("D2_ITEMREM")[1],0})
AADD(aCampos,{"ESPECIE"  ,"C",TamSX3("D1_ESPECIE")[1],0})
AADD(aCampos,{"NFISCAL"  ,"C",TamSX3("CM_NFISCAL")[1],0})
AADD(aCampos,{"QUANT"    ,"N",aTamQ[1],aTamQ[2]})
AADD(aCampos,{"QTSEGUM"  ,"N",aTamQ[1],aTamQ[2]})
AADD(aCampos,{"OP"       ,"C",TamSX3("D1_OP")[1],0})
AADD(aCampos,{"PEDIDO"   ,"C",TamSX3("D2_PEDIDO")[1],0})
AADD(aCampos,{"CC"       ,"C",TamSX3("D3_CC")[1],0})
AADD(aCampos,{"CUSTO"    ,"N",aTamC[1],aTamC[2]})
AADD(aCampos,{"TIPO"     ,"C",1,0})
AADD(aCampos,{"ARMAZEM"  ,"C",aTamB2Loc[1],aTamB2Loc[2]})
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posicao e descricao dos elementos dos arrays  ³
//| 01 - Produto                                  |
//| 02 - Sequencia de Recalculo                   ³
//³ 03 - Numeracao Sequencial                     ³
//³ 04 - Data de Emissao                          ³
//³ 05 - CF                                       ³
//³ 06 - TES / TM                                 ³
//³ 07 - Remito                                   ³
//³ 08 - Cliente/fornece                          ³
//³ 09 - Serie                                    ³
//³ 10 - Loja                                     ³
//³ 11 - Item do Remito                           ³
//³ 12 - Especie                                  ³
//³ 13 - Nota Fiscal / Documento                  ³
//³ 14 - Quantidade                               ³
//³ 15 - Quantidade da Segunda Unidade            ³
//³ 16 - OP                                       ³
//³ 17 - Pedido                                   ³
//³ 18 - Cliente/fornece                          ³
//³ 19 - CC                                       ³
//³ 20 - Custo                                    ³
//³ 21 - Tipo                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(AllTrim(STR0013+IIF(lCusUnif,"",+mv_par08))) //"KARDEX FISICO FINANCIERO (DIA) D E P O S I T O :"
oReport:SetTitle(AllTrim(oReport:Title()+STR0014+STR0004+STR0015+AllTrim(GetMv("MV_SIMB"+Ltrim(Str(mv_par11))))+")")) //" (Por " - " Codigo Producto " - " , en "
oReport:SetTitle(AllTrim(oReport:Title()+IIF(mv_par16==1,OemToAnsi(STR0030),OemToAnsi(STR0031)))) //"(SECUENCIA)" - "(CALCULO)"

cPictChile:= MontPict("SD1","D1_QUANT")

cFiltSB1 := oReport:Section(1):GetSQLExp("SB1")
cFiltSB2 := oReport:Section(1):GetSQLExp("SB2")
cFiltSD1 := oReport:Section(1):GetSQLExp("SD1")
cFiltSD2 := oReport:Section(1):GetSQLExp("SD2")
cFiltSD3 := oReport:Section(1):GetSQLExp("SD3")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

cAliasTop := "TRB"

oReport:NoUserFilter()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do SELECT da tabela SD1                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSelectD1 := "%"
cSelectD1 += "D1_CUSTO"+IIf(mv_par11==1," ",str(mv_par11,1))+" CUSTO, "
cSelectD1 += "%"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do Where da tabela SD1                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cWhereD1 := "%" 
If !lCusUnif
	cWhereD1 += " SD1.D1_LOCAL ='"+mv_par08+"' AND"
EndIf
If lRemInt .And. cPaisLoc <> "BRA"
	If TcGetDb() = "MSSQL"
		cWhereD1 += " ( SD1.D1_TIPO_NF + SD1.D1_TIPODOC <> '510' ) AND "
	Else	
		cWhereD1 += " ( SD1.D1_TIPO_NF || SD1.D1_TIPODOC <> '510' ) AND "
	EndIf	
EndIf			   		
cWhereD1 += IIf(!Empty(cFiltSB1), " (" + cFiltSB1 + ") AND ", "")
cWhereD1 += IIf(!Empty(cFiltSB2), " (" + cFiltSB2 + ") AND ", "")
cWhereD1 += Iif(!Empty(cFiltSD1), " (" + cFiltSD1 + ") AND ", "")
cWhereD1 += "%" 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do Where da tabela SB2                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cWhereB2 := "%" 
If !lCusUnif
	cWhereB2 += " SB2.B2_LOCAL ='"+mv_par08+"' AND"
EndIf
cWhereB2 += "%" 	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do SELECT da tabela SD2                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSelectD2 := "%"
cSelectD2 += "D2_CUSTO"+str(mv_par11,1)+" CUSTO, "
cSelectD2 += "%"
// Verifica se usa o campo D2_DTDIGIT ou nao, de acordo com a funcao UsaD2DTDIG
If lUsaD2DIG
	cD2EMISSAO := "% D2_DTDIGIT EMISSAO,%"
Else
	cD2EMISSAO := "% D2_EMISSAO EMISSAO,%"
EndIf	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do Where da tabela SD1                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cWhereD2 := "%" 
If !lCusUnif
	cWhereD2 += " SD2.D2_LOCAL ='"+mv_par08+"' AND "
EndIf
// Verifica se usa o campo D2_DTDIGIT ou nao, de acordo com a funcao UsaD2DTDIG
If lUsaD2DIG
	cWhereD2 += " SD2.D2_DTDIGIT >= '"+Dtos(mv_par05)+"' AND "
	cWhereD2 += " SD2.D2_DTDIGIT <= '"+Dtos(mv_par06)+"' AND "
Else
	cWhereD2 += " SD2.D2_EMISSAO >= '"+Dtos(mv_par05)+"' AND "
	cWhereD2 += " SD2.D2_EMISSAO <= '"+Dtos(mv_par06)+"' AND "
EndIf
cWhereD2 += IIf(!Empty(cFiltSB1), " (" + cFiltSB1 + ") AND ", "")
cWhereD2 += IIf(!Empty(cFiltSB2), " (" + cFiltSB2 + ") AND ", "")
cWhereD2 += Iif(!Empty(cFiltSD2), " (" + cFiltSD2 + ") AND ", "")
cWhereD2 += "%"    

cWhereRE := "%" 
cWhereRE += " (SD2.D2_REMITO   = '" + Space(TamSx3('D2_REMITO')[1]) + "' OR SD2.D2_TPDCENV IN ('1','A')) "	
cWhereRE += "%" 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do SELECT da tabelas SD3                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSelectD3 := "%"
cSelectD3 += "D3_CUSTO"+str(mv_par11,1)+" CUSTO, "
cSelectD3 += "%"    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do WHERE da tabela SD3                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cWhereD3 := "%"
If !lCusUnif .and. !lLocProc
	cWhereD3 += " SD3.D3_LOCAL ='"+mv_par08+"' AND"
EndIf
If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cWhereD3 += " SD3.D3_ESTORNO <> 'S' AND"
EndIf  
If SuperGetMV('MV_D3SERVI', .F., 'N') == 'N' .And. IntDL()
	cWhereD3 += " ( (D3_SERVIC = '   ') OR (D3_SERVIC <> '   ' AND D3_TM <= '500' AND D3_STSERV = '3') ) AND"
EndIf		      	
cWhereD3 += IIf(!Empty(cFiltSB1), " (" + cFiltSB1 + ") AND ", "")
cWhereD3 += IIf(!Empty(cFiltSB2), " (" + cFiltSB2 + ") AND ", "")
cWhereD3 += Iif(!Empty(cFiltSD3), " (" + cFiltSD3 + ") AND ", "")
cWhereD3 += "%"	

cOrder := "%"
If mv_par16 == 1  
	If UPPER(TcGetDB()) != "INFORMIX"    
		cOrder += " PRODUTO, EMISSAO, ORDTMP, NUMSEQ"
    Else
    	cOrder += " 3, 6, 1, 5"
    EndIf
Else                                
	If UPPER(TcGetDB()) != "INFORMIX"    
		cOrder += " PRODUTO, EMISSAO, ORDTMP, SEQCALC, NUMSEQ"
	Else
    	cOrder += " 3, 6, 1, 4, 5"
    EndIf
Endif	
cOrder += "%"

BeginSql Alias cAliasTop

	SELECT '2' ORDTMP, 				
		   D1_TIPO TIPO, 
		   D1_COD PRODUTO, 
		   D1_SEQCALC SEQCALC, 
		   D1_NUMSEQ NUMSEQ, 
		   D1_DTDIGIT EMISSAO, 
		   D1_TES TES, 
		   D1_CF CF, 
		   D1_ESPECIE ESPECIE, 
		   D1_DOC NFISCAL, 
		   D1_REMITO REMITO, 
		   D1_SERIE SERIE, 
		   D1_OP OP, 
		   D1_LOJA LOJA, 
		   D1_FORNECE CLIFOR, 
		   ' ' ITEMREM, 
		   ' ' PEDIDO, 
		   ' ' CC, 
		   D1_QUANT QUANT, 
		   D1_QTSEGUM QTSEGUM, 
		   D1_LOCAL ARMAZEM,
		   %Exp:cSelectD1%		
		   SD1.R_E_C_N_O_,
		   SD1.D1_SERIREM SERIREM

	FROM %table:SD1% SD1,%table:SF4% SF4,%table:SB1% SB1,%table:SB2% SB2
	
	WHERE SD1.D1_FILIAL  =  %xFilial:SD1%	AND
          SD1.D1_COD     >= %Exp:mv_par01% 	AND
          SD1.D1_COD     <= %Exp:mv_par02% AND          
	      %Exp:cWhereD1%
		  SD1.D1_TIPO_NF >= ' '            	AND
		  SD1.D1_TIPO_NF <= '5'            	AND		      
	      SD1.D1_DTDIGIT >= %Exp:mv_par05% 	AND
		  SD1.D1_DTDIGIT <= %Exp:mv_par06%	AND		
		  SD1.D1_ORIGLAN <> 'LF'           	AND
		  SD1.D1_REMITO  = ' '             	AND
		  SD1.%NotDel%						AND
		  SF4.F4_FILIAL  =  %xFilial:SF4%	AND 	
		  SF4.F4_CODIGO  = SD1.D1_TES 		AND
		  SF4.F4_ESTOQUE = 'S' 				AND
		  SF4.%NotDel%                     	AND      
		  SB1.B1_FILIAL  =  %xFilial:SB1%	AND 	
		  SB1.B1_COD     = SD1.D1_COD 		AND
          SB1.B1_TIPO    >= %Exp:mv_par03% 	AND
          SB1.B1_TIPO    <= %Exp:mv_par04% 	AND          			  
          SB1.%NotDel%                     	AND
		  SB2.B2_FILIAL  =  %xFilial:SB2%	AND 	
		  SB2.B2_COD     = SD1.D1_COD 		AND                       
		  %Exp:cWhereB2%
		  SB2.%NotDel%                     	
          
    UNION

	SELECT '3' ORDTMP, 
	       ' ' TIPO, 
	       D3_COD PRODUTO, 
	       D3_SEQCALC SEQCALC, 
	       D3_NUMSEQ NUMSEQ, 
	       D3_EMISSAO EMISSAO, 
	       D3_TM TES, 
	       D3_CF CF, 
	       ' ' ESPECIE, 
	       D3_DOC NFISCAL, 
	       ' ' REMITO, 
	       ' ' SERIE, 
	       D3_OP OP, 
	       ' ' LOJA, 
	       ' ' CLIFOR, 
	       ' ' ITEMREM, 
	       ' ' PEDIDO, 
	       D3_CC CC, 
	       D3_QUANT QUANT, 
	       D3_QTSEGUM QTSEGUM,
	       D3_LOCAL ARMAZEM, 
		   %Exp:cSelectD3%			
		   SD3.R_E_C_N_O_,
		   ' ' SERIREM
		   
	FROM %table:SD3% SD3,%table:SB1% SB1,%table:SB2% SB2
	
	WHERE SD3.D3_FILIAL  =  %xFilial:SD3%	AND
          SD3.D3_COD     >= %Exp:mv_par01% 	AND
          SD3.D3_COD     <= %Exp:mv_par02% AND
	      SD3.D3_EMISSAO >= %Exp:mv_par05% 	AND
		  SD3.D3_EMISSAO <= %Exp:mv_par06%	AND
		  %Exp:cWhereD3%                      
		  SD3.%NotDel%						AND
		  SB1.B1_FILIAL  =  %xFilial:SB1%	AND 	
		  SB1.B1_COD     = SD3.D3_COD 		AND
          SB1.B1_TIPO    >= %Exp:mv_par03% 	AND
          SB1.B1_TIPO    <= %Exp:mv_par04% 	AND          			  
          SB1.%NotDel%                     	AND                       
		  SB2.B2_FILIAL  =  %xFilial:SB2%	AND 	
		  SB2.B2_COD     = SD3.D3_COD 		AND                       
		  %Exp:cWhereB2%
		  SB2.%NotDel%                     	              

	UNION		

	SELECT '5' ORDTMP, 
	       D2_TIPO TIPO, 
	       D2_COD PRODUTO, 
	       D2_SEQCALC SEQCALC, 
	       D2_NUMSEQ NUMSEQ, 
	       %Exp:cD2EMISSAO% 
	       D2_TES TES, 
	       D2_CF CF, 
	       D2_ESPECIE ESPECIE, 
	       D2_DOC NFISCAL, 
	       D2_REMITO REMITO, 
	       D2_SERIE SERIE, 
	       D2_OP OP, 
	       D2_LOJA LOJA,
	       D2_CLIENTE CLIFOR, 
	       D2_ITEMREM ITEMREM, 
	       D2_PEDIDO PEDIDO, 
	       ' ' CC, 
	       D2_QUANT QUANT, 
	       D2_QTSEGUM QTSEGUM,
	       D2_LOCAL ARMAZEM, 
		   %Exp:cSelectD2%			
		   SD2.R_E_C_N_O_,
		   SD2.D2_SERIREM SERIREM

	FROM %table:SD2% SD2,%table:SF4% SF4,%table:SB1% SB1,%table:SB2% SB2
	
	WHERE SD2.D2_FILIAL  =  %xFilial:SD2%	AND
          SD2.D2_COD     >= %Exp:mv_par01% 	AND
          SD2.D2_COD     <= %Exp:mv_par02% AND          
	      %Exp:cWhereD2%
	      SD2.D2_EMISSAO >= %Exp:mv_par05% 	AND
		  SD2.D2_EMISSAO <= %Exp:mv_par06%	AND		
		  SD2.D2_ORIGLAN <> 'LF'           	AND
		  %Exp:cWhereRE%                   	AND
		  SD2.%NotDel%						AND
		  SF4.F4_FILIAL  =  %xFilial:SF4%	AND 	
		  SF4.F4_CODIGO  = SD2.D2_TES 		AND
		  SF4.F4_ESTOQUE = 'S' 				AND
		  SF4.%NotDel%                     	AND      
		  SB1.B1_FILIAL  =  %xFilial:SB1%	AND 	
		  SB1.B1_COD     = SD2.D2_COD 		AND
          SB1.B1_TIPO    >= %Exp:mv_par03% 	AND
          SB1.B1_TIPO    <= %Exp:mv_par04% 	AND          			  
          SB1.%NotDel%                     	AND                       
		  SB2.B2_FILIAL  =  %xFilial:SB2%	AND 	
		  SB2.B2_COD     = SD2.D2_COD 		AND                       
		  %Exp:cWhereB2%
		  SB2.%NotDel%                     	                            

	ORDER BY %Exp:cOrder%
	
EndSql 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
oSection2:SetParentQuery()
oSection3:SetParentQuery()

aEval(aCampos, {|e| If(e[2]!= "C", TCSetField("TRB", e[1], e[2],e[3],e[4]),Nil)})

dbSelectArea("TRB")
oReport:SetMeter(TRB->(LastRec()))
DbGoTop()

cProdAnt := ""
aSB1     := {}
 
While !oReport:Cancel() .And. !("TRB")->(Eof()) 
	
	If oReport:Cancel()
		Exit
	EndIf	
	
	oReport:IncMeter()		
	
	aSD1  := {}
	aSD3  := {}
	aSD2  := {}
	dData := TRB->EMISSAO
	
	If cProdAnt <> TRB->PRODUTO 

		If Len(aSB1) > 0
			oSection1:Finish()
			oSection2:Finish()
			oSection3:Finish()
			R911TotImp(aSB1,oReport,oSection1,oSection2,oSection3)
			lFirst1 := .T.
		Endif
		cProdAnt := TRB->PRODUTO
		aSB1 := {}
		dbSelectArea("SB1")
		dbSetOrder(1) //B1_FILIAL+B1_COD
		dbSeek(xFilial("SB1")+cProdAnt)

		AADD(aSB1, { SB1->B1_COD, ;					// CODIGO
						SubStr(SB1->B1_DESC,1,30),;	// DESCRICAO
						SB1->B1_UM,; 		     		// UM
						SB1->B1_TIPO,;					// TIPO
						SB1->B1_GRUPO,;    				// GRUPO
						RetFldProd(SB1->B1_COD,"B1_CUSTD") } )
		
		// Imprime Produto sem Movimento
		If mv_par07 == 1
			R911ProdSM(1,.T.,oReport,oSection1,oSection2,oSection3)
		Endif
	Endif
	
	dbSelectArea("TRB")

	While !Eof() .And. TRB->PRODUTO == cProdAnt .And. TRB->EMISSAO == dData .And. TRB->ORDTMP == "2"		// SD1
		R911Array(@aSD1)
		dbSkip()
	EndDo
	
	While !Eof() .And. TRB->PRODUTO == cProdAnt .And. TRB->EMISSAO == dData .And. TRB->ORDTMP == "3"		// SD3
		lInverteMov:=.F.
		If (Substr(TRB->CF,3,1) == "3") .And. lLocProc
			lInverteMov:=.T.
		EndIf
		If lLocProc // Armazem de processo
			If (Substr(TRB->CF,3,1) $ "3") .Or. mv_par08 == TRB->ARMAZEM 
				R911Array(@aSD3,lInverteMov, lLocProc)
			EndIf
		Else
			R911Array(@aSD3,lInverteMov)
		EndIf
		dbSkip()
	EndDo
	
	While !Eof() .And. TRB->PRODUTO == cProdAnt .And. TRB->EMISSAO == dData .And. TRB->ORDTMP == "5"		// SD2
		R911Array(@aSD2)
		dbSkip()
	Enddo
	
	If (Len(aSD1)+Len(aSD3)+Len(aSD2)) > 0
		R911ImpS3(aSB1,aSD1,aSD3,aSD2,oSection1,oSection2,oSection3)
	Endif

	dbSelectArea("TRB")
Enddo

If Len(aSB1) > 0
	oSection1:Finish()
	oSection2:Finish()
	oSection3:Finish()		
	R911TotImp(aSB1,oReport,oSection1,oSection2,oSection3)
Endif

// Imprime Produto sem Movimento
If mv_par07 == 1
	R911ProdSM(2,.T.,oReport,oSection1,oSection2,oSection3)
Endif	

If !Empty(aGrupos)

	oReport:SkipLine()    
	oReport:PrintText(STR0020) //"R E S U M O"
	oReport:SkipLine()    	
	dbSelectArea("SX5")
	For i:=1 to Len(aGrupos)
		dbSeek(xFilial("SX5")+"02"+aGrupos[i][1])
		nLin := oReport:Row()
		oReport:PrintText(X5Descri())
		oReport:PrintText(TransForm(aGrupos[i][2],cPicD1Qt												  ),nLin,oSection3:Cell('nENTQtd'):ColPos()-110)														
		oReport:PrintText(TransForm(aGrupos[i][3],If(cPaisloc=="CHI",cPictChile,cPicD1Cust)),nLin,oSection3:Cell('nENTCus'):ColPos()-60)
		oReport:PrintText(TransForm(aGrupos[i][4],cPicD2Qt												  ),nLin,oSection3:Cell('nSAIQtd'):ColPos()-110)					
		oReport:PrintText(TransForm(aGrupos[i][5],If(cPaisloc=="CHI",cPictChile,cPicD2Cust)),nLin,oSection3:Cell('nSAICus'):ColPos()-50)							
		oReport:SkipLine()
	Next i
	oReport:SkipLine()    
	For i:=1 to Len(aUnids)
		dbSeek(xFilial("SX5")+"62"+aUnids[i][1])
		nLin := oReport:Row()
		oReport:PrintText(X5Descri())
		oReport:PrintText(TransForm(aUnids[i][2],cPicD1Qt  											 ),nLin,oSection3:Cell('nENTQtd'):ColPos()-110)														
		oReport:PrintText(TransForm(aUnids[i][3],If(cPaisloc=="CHI",cPictChile,cPicD1Cust)),nLin,oSection3:Cell('nENTCus'):ColPos()-60)
		oReport:PrintText(TransForm(aUnids[i][4],cPicD2Qt 											     ),nLin,oSection3:Cell('nSAIQtd'):ColPos()-110)					
		oReport:PrintText(TransForm(aUnids[i][5],If(cPaisloc=="CHI",cPictChile,cPicD2Cust)),nLin,oSection3:Cell('nSAICus'):ColPos()-50)
		oReport:SkipLine()
	Next i
	oReport:SkipLine()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³MR911ImpCb³ Autor ³ Eveli Morasco         ³ Data ³ 28/11/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Imprime o cabecalho do item                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³MR911ImpCb(ExpA1,ExpN1,@ExpN2)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA1 = Array com informacoes do saldo inicial do item      ³±±
±±³          ³   [1] = Saldo inicial em quantidade                        ³±±
±±³          ³   [2] = Saldo inicial em valor                             ³±±
±±³          ³   [3] = Saldo inicial na 2a unidade de medida              ³±±
±±³          ³ ExpN1 = Custo medio do item                                ³±±
±±³          ³ ExpN2 = Numero da linha corrente de impressao              ³±±
±±³          ³ ExpN3 = Picture Do Campo                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR910                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MR911ImpCb(aSB1,nCusMed,Li,cPicB2Qt,cPicB2Cust)

@ Li,000 PSAY aSB1[1][1]				// B1_COD
@ Li,019 PSAY aSB1[1][2]				// B1_DESCRICAO
@ Li,056 PSAY STR0023+aSB1[1][3]  		// B1_UM
@ Li,068 PSAY STR0024+aSB1[1][4]  		// B1_TIPO
@ Li,083 PSAY STR0025+aSB1[1][5]  		// B1_GRUPO
@ Li,121 PSAY STR0026          	   		// Custo Medio
If nCusMed > 0
	@ Li,138 PSAY nCusMed		Picture cPicB2Cust
Else
	@ Li,138 PSAY aSB1[1][6]	Picture cPicB2Cust	// B1_CUSTD
EndIf
@ Li,162 PSAY aSalAtu[1] Picture cPicB2Qt
@ Li,187 PSAY aSalAtu[mv_par11+1] Picture cPicB2Cust
Li++
@ Li,000 PSAY STR0028+SB2->B2_LOCALIZ  //"Localizacao : "
Li += 2
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R911Total ³ Autor ³Sergio S. Fuzinaka     ³ Data ³ 11.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Imprime os Totais                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR911                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R911Total(aSB1)

Local nGrp		:= 0
Local nUn		:= 0
Local I			:= 0
Local aArea		:= {}
Local aSalAlmox	:= {}

If (nRec1+nRec2+nRec3) > 0
	nGrp := ASCAN(aGrupos,{|x| aSB1[1][4] == x[1]})
	If nGrp > 0
		aGrupos[nGrp][2]	+= nEntrada				// Quantidade
		aGrupos[nGrp][3]	+= nCEntrada			// Custo
		aGrupos[nGrp][4]	+= nSaida	   			// Quantidade
		aGrupos[nGrp][5]	+= nCSaida				// Custo
	Else
		AADD(aGrupos,{aSB1[1][4],nEntrada,nCEntrada,nSaida,nCSaida,aSalAtu[1],aSalAtu[mv_par11+1]})
	EndIf
	
	//Agrupa custo por unidade de medida
	nUn := ASCAN(aUnids,{|x| aSB1[1][3] == x[1]})
	If nUn > 0
		aUnids[nUn][2]	+= nEntrada				// Quantidade
		aUnids[nUn][3]	+= nCEntrada			// Custo
		aUnids[nUn][4]	+= nSaida	   			// Quantidade
		aUnids[nUn][5]	+= nCSaida				// Custo
	Else
		AADD(aUnids,{aSB1[1][3],nEntrada,nCEntrada,nSaida,nCSaida,aSalAtu[1],aSalAtu[mv_par11+1]})
	EndIf
	
	Li ++
	@ li,000 PSAY STR0017	 //	"T O T A I S  :"
	@ Li,045 PSAY nEntrada   Picture cPicD1Qt
	@ Li,069 PSAY nCEntrada  Picture cPicD1Cust
	@ Li,114 PSAY nSaida     Picture cPicD2Qt
	@ Li,138 PSAY nCSaida    Picture cPicD2Cust
	@ Li,162 PSAY aSalAtu[1] Picture cPicB2Qt
	@ Li,187 PSAY aSalAtu[mv_par11+1] Picture cPicB2Cust
	Li++
	@ Li,140 PSAY STR0018   //"QTD. NA SEGUNDA UM: "
	@ Li,162 PSAY aSalAtu[7] Picture cPicB2Qt2
	Li++
   @ Li,000 PSAY __PrtThinLine()
	Li++
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se deve ou nao listar os produtos s/movimento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 1
		If li > 58
			cabec(Titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula o Saldo Inicial do Produto             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lCusUnif
			aArea:=GetArea()
			aSalAtu  := { 0,0,0,0,0,0,0 }
			dbSelectArea("SB2")
			dbSetOrder(1) //B2_FILIAL+B2_COD+B2_LOCAL
			dbSeek(cSeek:=xFilial("SB2")+aSB1[1][1])
			While !Eof() .And. B2_FILIAL+B2_COD == cSeek
				aSalAlmox := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,mv_par05)
				For i:=1 to Len(aSalAtu)
					aSalAtu[i] += aSalAlmox[i]
				Next i
				dbSkip()
			End
			RestArea(aArea)
		Else		
			aSalAtu := CalcEst(aSB1[1][1],mv_par08,mv_par05)
    	EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula o Custo Medio do Produto               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If aSalAtu[1] > 0 .And. aSalAtu[mv_par11+1] > 0
			nCusMed := aSalAtu[mv_par11+1]/aSalAtu[1]
		ElseIf aSalAtu[1] == 0 .And. aSalAtu[mv_par11+1] == 0
			nCusMed := 0
		Else
			nCusMed := &(Eval(bBloco,"SB2->B2_CM",mv_par11))
		EndIf
		nCusMed := Round(nCusMed,nDec)
		MR911ImpCb(aSB1,nCusMed,@Li,cPicB2Qt,cPicB2Cust)
		@Li ,  0 PSAY STR0019   //"NAO HOUVE MOVIMENTACAO PARA ESTE PRODUTO"
		Li++
      @Li ,  0 PSAY __PrtThinLine()
		Li++
	EndIf
EndIf

nEntrada  := 0
nCEntrada := 0
nSaida    := 0
nCSaida   := 0

nRec1     := 0
nRec2     := 0
nRec3     := 0

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³MTR911VAlm ³ Autor ³Sergio S. Fuzinaka     ³ Data ³15.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Valida Almoxarifado do KARDEX com relacao a custo unificado ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR911                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MTR911VAlm()

Local lRet		:= .T.
Local cConteudo	:= &(ReadVar())
Local nOpc		:= 2
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se utiliza custo unificado por Empresa/Filial       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lCusUnif	:= IIf(FindFunction("A330CusFil"),A330CusFil(),GetMV("MV_CUSFIL",.F.))

If lCusUnif .And. cConteudo != Repl("*",TamSX3("B2_LOCAL")[1])
	nOpc := Aviso(STR0034,STR0035,{STR0036,STR0037})	//"Aten‡„o"###"Ao alterar o almoxarifado o custo medio unificado sera desconsiderado."###"Confirma"###"Abandona"
	If nOpc == 2
		lRet := .F.
	EndIf
EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R911Array  ³ Autor ³Sergio S. Fuzinaka     ³ Data ³15.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Alimenta Array                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR911                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R911Array(aArray,lInvert, lLocProc)

Default lInvert		:= .F.
Default lLocProc	:= .F.

AADD( aArray, { PRODUTO, SEQCALC, NUMSEQ, EMISSAO, IIf(lLocProc .And. (Substr(TRB->CF,3,1) $ "23"), AllTrim(CF)+"*", CF), TES, REMITO,;
				CLIFOR, SERIE,	LOJA, ITEMREM, ESPECIE,	NFISCAL, QUANT,;
				QTSEGUM, OP, PEDIDO, CLIFOR, CC, CUSTO, TIPO, SERIREM, lInvert } )
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R911ProdSM ³ Autor ³Sergio S. Fuzinaka     ³ Data ³15.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Imprime Produto sem Movimento                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR911                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R911ProdSM(nOp,lGraph,oReport,oSection1,oSection2,oSection3)

Local aSB1SM   := {}
Local cProdFim := IIf(nOp == 1, TRB->PRODUTO, mv_par02)
Local bWhile   := IIf(nOp == 1, { ||!Eof() .And. SB1->B1_FILIAL == xFilial("SB1") .And. SB1->B1_COD < cProdFim .And. lContinua }, ;
						{ ||!Eof() .And. SB1->B1_FILIAL == xFilial("SB1") .And. SB1->B1_COD <= cProdFim .And. lContinua })

Default lGraph := .F.

dbSelectArea("SB1")
dbSetOrder(1) //B1_FILIAL+B1_COD
dbSeek(xFilial("SB1")+cProdIni,.T.)
While Eval(bWhile)
	
	// Filtra por Tipo
	If SB1->B1_TIPO < mv_par03 .or. B1_TIPO > mv_par04
		dbSkip()
		Loop
	Endif
	
	// Filtra por Produto
	If SB1->B1_COD < mv_par01 .or. B1_COD > mv_par02
		dbSkip()
		Loop
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se nao encontrar no arquivo de saldos ,nao lista ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !SB2->(dbSeek(xFilial("SB2")+SB1->B1_COD+IIf(lCusUnif,"",mv_par08)))
		dbSelectArea("SB1")
		dbSkip()
		Loop
	Endif
	
	aSB1SM := {}
	AADD(aSB1SM, {	SB1->B1_COD, ;							// CODIGO
					SubStr(SB1->B1_DESC,1,30),;			// DESCRICAO
					SB1->B1_UM,;      						// UM
					SB1->B1_TIPO,;							// TIPO
					SB1->B1_GRUPO,;    						// GRUPO
					RetFldProd(SB1->B1_COD,"B1_CUSTD") } ) // CUSTO STANDARD
	If !lGraph
		R911Total(aSB1SM)
	Else
		oSection1:Finish()
		oSection2:Finish()
		oSection3:Finish()			
		R911TotImp(aSB1SM,oReport,oSection1,oSection2,oSection3)
	Endif	
	dbSkip()
EndDo

If nOp == 1 .And. lContinua
	dbSkip()
	If !Eof()
		cProdIni  := SB1->B1_COD
	Else
		lContinua := .F.
	EndIf
EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R911IMPS3 ³ Autor ³ Nereu Humberto Junior ³ Data ³ 20.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ MATR911                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R911ImpS3(aSB1,aSD1,aSD3,aSD2,oSection1,oSection2,oSection3)

Local nCusMed	:= 0
Local I			:= 0
Local nX		:= 0
Local aArea		:= {}
Local aSalAlmox	:= {}

// Posicionando arquivos
dbSelectArea("SF1")
dbSetOrder(1) //F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
dbSelectArea("SF2")
dbSetOrder(1) //F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO

// Definir Picture quando for para o chile
If cPaisLoc == "CHI" 
	oTot1:SetPicture(cPictChile)
	oTot2:SetPicture(cPictChile)
	oTot3:SetPicture(cPictChile)
	oSection1:Cell("nCusMed") :SetPicture(cPictChile)
	oSection1:Cell("nVlrSal") :SetPicture(cPictChile)
	oSection3:Cell("nENTCus") :SetPicture(cPictChile)
	oSection3:Cell("nCusMov") :SetPicture(cPictChile)
	oSection3:Cell("nSAICus") :SetPicture(cPictChile)
	oSection3:Cell("nSALDCus"):SetPicture(cPictChile)
EndIf

While .T.
	oSection3:Init()
	/**** INICIO SD1 ****/
	For I:=1 To Len(aSD1)
		
		dbSelectArea("SB2")
		dbSetOrder(1) //B2_FILIAL+B2_COD+B2_LOCAL
		dbSeek(xFilial("SB2")+aSD1[I][1]+IIf(lCusUnif,"",mv_par08))
		
		If lFirst1
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula o Saldo Inicial do Produto             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF lCusUnif
				aArea:=GetArea()
				aSalAtu  := { 0,0,0,0,0,0,0 }
				dbSelectArea("SB2")
				dbSetOrder(1) //B2_FILIAL+B2_COD+B2_LOCAL
				dbSeek(cSeek:=xFilial("SB2")+aSD1[I][1])
				While !Eof() .And. B2_FILIAL+B2_COD == cSeek
					aSalAlmox := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,mv_par05)
					For nX:=1 to Len(aSalAtu)
						aSalAtu[nX] += aSalAlmox[nX]
					Next nX
					dbSkip()
				End
				RestArea(aArea)
			Else
				aSalAtu := CalcEst(aSD1[I][1],mv_par08,mv_par05)
			EndIf	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula o Custo Medio do Produto               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If aSalAtu[1] > 0 .And. aSalAtu[mv_par11+1] > 0
				nCusMed := aSalAtu[mv_par11+1]/aSalAtu[1]
			ElseIf aSalAtu[1] == 0 .And. aSalAtu[mv_par11+1] == 0
				nCusMed := 0
			Else
				nCusMed := &(Eval(bBloco,"SB2->B2_CM",mv_par11))
			Endif
			nCusMed := Round(nCusMed,nDec)
			oSection1:Init()
			oSection2:Init()
			oSection1:Cell("B1_COD"):SetValue(aSB1[1][1])			            
			oSection1:Cell("B1_DESC"):SetValue(aSB1[1][2])			            
			oSection1:Cell("B1_UM"):SetValue(aSB1[1][3])			            
			oSection1:Cell("B1_TIPO"):SetValue(aSB1[1][4])			            
			oSection1:Cell("B1_GRUPO"):SetValue(aSB1[1][5])
						            
			If nCusMed > 0
				oSection1:Cell("nCusMed"):SetValue(Round(nCusMed,nDec))
			Else
				oSection1:Cell("nCusMed"):SetValue(Round(aSB1[1][6],nDec))
			EndIf
			oSection1:Cell("nQtdSal"):SetValue(aSalAtu[1])			            
			oSection1:Cell("nVlrSal"):SetValue(aSalAtu[mv_par11+1])	
			oSection1:PrintLine()
			oSection2:PrintLine()
			lFirst1 := .F.
		EndIf
		oSection3:Cell("dDtMov"):SetValue(aSD1[I][4])			
		oSection3:Cell("cTES"):SetValue(aSD1[I][6])														
		oSection3:Cell("cCF"):SetValue(If(aSD1[I][12]=="FT","FAC",aSD1[I][12]))			
		oSection3:Cell("cDoc"):SetValue(IIf(mv_par09 == 1,aSD1[I][13],aSD1[I][3]))					
		
		If aSD1[I][6] <= "500" .And. aSD1[I][21] <> "D"
			If aSD1[I][14] > 0
			  	oSection3:Cell("nCusMov"):Show()
			  	oSection3:Cell("nCusMov"):SetValue(Round(aSD1[I][20] / aSD1[I][14],nDec))		               				
			Else
			  	oSection3:Cell("nCusMov"):Hide()
			  	oSection3:Cell("nCusMov"):SetValue(0)		               							
			EndIf
			
			oSection3:Cell("nENTQtd"):Show()
			oSection3:Cell("nENTCus"):Show()
				
			oSection3:Cell("nENTQtd"):SetValue(aSD1[I][14])			
			oSection3:Cell("nENTCus"):SetValue(Round(aSD1[I][20],nDec))					            
			
			oSection3:Cell("nSAIQtd"):Hide()
			oSection3:Cell("nSAICus"):Hide()
			oSection3:Cell("nSAIQtd"):SetValue(0)			
			oSection3:Cell("nSAICus"):SetValue(0)								
				
			nEntrada	+= aSD1[I][14]
			aSalAtu[1]	+= aSD1[I][14]
			nCEntrada	+= Round(aSD1[I][20],nDec)
			aSalAtu[mv_par11+1] += Round(aSD1[I][20],nDec)
			aSalAtu[7]	+= aSD1[I][15]
		Else
			If aSD1[I][21] == "D"
				If aSD1[I][14] > 0
				  	oSection3:Cell("nCusMov"):Show()
				  	oSection3:Cell("nCusMov"):SetValue(Round(aSD1[I][20] / aSD1[I][14],nDec))		               				
				Else
				  	oSection3:Cell("nCusMov"):Hide()
				  	oSection3:Cell("nCusMov"):SetValue(0)		               							
				EndIf				

				oSection3:Cell("nENTQtd"):Show()
				oSection3:Cell("nENTCus"):Show()
					
				oSection3:Cell("nENTQtd"):SetValue(aSD1[I][14])			
				oSection3:Cell("nENTCus"):SetValue(Round(aSD1[I][20],nDec))					            
				
				oSection3:Cell("nSAIQtd"):Hide()
				oSection3:Cell("nSAICus"):Hide()
				oSection3:Cell("nSAIQtd"):SetValue(0)			
				oSection3:Cell("nSAICus"):SetValue(0)								
				
				nEntrada	+= aSD1[I][14]
				aSalAtu[1]	+= aSD1[I][14]
				nCEntrada	+= Round(aSD1[I][20],nDec)
				aSalAtu[mv_par11+1] += Round(aSD1[I][20],nDec)
				aSalAtu[7]	+= aSD1[I][15]
			Else
				If aSD1[I][14] > 0
				  	oSection3:Cell("nCusMov"):Show()
				  	oSection3:Cell("nCusMov"):SetValue(Round(aSD1[I][20] / aSD1[I][14],nDec))		               				
				Else
				  	oSection3:Cell("nCusMov"):Hide()
				  	oSection3:Cell("nCusMov"):SetValue(0)		               							
				EndIf

				oSection3:Cell("nENTQtd"):Hide()
				oSection3:Cell("nENTCus"):Hide()
				oSection3:Cell("nENTQtd"):SetValue(0)			
				oSection3:Cell("nENTCus"):SetValue(0)					            

				oSection3:Cell("nSAIQtd"):Show()
				oSection3:Cell("nSAICus"):Show()
				oSection3:Cell("nSAIQtd"):SetValue(aSD1[I][14])			
				oSection3:Cell("nSAICus"):SetValue(Round(aSD1[I][20],nDec))												
				
				nEntrada	+= aSD1[I][14]
				aSalAtu[1]	+= aSD1[I][14]
				nCEntrada	+= Round(aSD1[I][20],nDec)
				aSalAtu[mv_par11+1] += Round(aSD1[I][20],nDec)
				aSalAtu[7]	+= aSD1[I][15]
			EndIf
		EndIf

		oSection3:Cell("nSALDQtd"):SetValue(aSalAtu[1])			
		oSection3:Cell("nSALDCus"):SetValue(Round(aSalAtu[mv_par11+1],nDec))					
		
		If Empty(aSD1[I][16])	// OP
			If aSD1[I][21] == "D"
				oSection3:Cell("cCCPVPJOP"):SetValue(STR0039+aSD1[I][08]) //"C-"
			Else
				oSection3:Cell("cCCPVPJOP"):SetValue(STR0038+aSD1[I][18]) //"P-"
			Endif
		Else
			oSection3:Cell("cCCPVPJOP"):SetValue("OP"+aSD1[I][16])
		EndIf
		nRec1++
		oSection3:PrintLine()	
	Next
	/**** FIM SD1 ****/
	
	/**** INICIO SD3 ****/
	For I:=1 To Len(aSD3)
		
		dbSelectArea("SB2")
		dbSetOrder(1) //B2_FILIAL+B2_COD+B2_LOCAL
		dbSeek(xFilial("SB2")+aSD3[I][1]+IIf(lCusUnif,"",mv_par08))
		
		If lFirst1
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula o Saldo Inicial do Produto             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF lCusUnif
				aArea:=GetArea()
				aSalAtu  := { 0,0,0,0,0,0,0 }
				dbSelectArea("SB2")
				dbSetOrder(1) //B2_FILIAL+B2_COD+B2_LOCAL
				dbSeek(cSeek:=xFilial("SB2")+aSD3[I][1])
				While !Eof() .And. B2_FILIAL+B2_COD == cSeek
					aSalAlmox := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,mv_par05)
					For nX:=1 to Len(aSalAtu)
						aSalAtu[nX] += aSalAlmox[nX]
					Next nX
					dbSkip()
				End
				RestArea(aArea)
			Else		
				aSalAtu := CalcEst(aSD3[I][1],mv_par08,mv_par05)
			EndIf	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula o Custo Medio do Produto               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If aSalAtu[1] > 0 .And. aSalAtu[mv_par11+1] > 0
				nCusMed := aSalAtu[mv_par11+1]/aSalAtu[1]
			ElseIf aSalAtu[1] == 0 .And. aSalAtu[mv_par11+1] == 0
				nCusMed := 0
			Else
				nCusMed := &(Eval(bBloco,"SB2->B2_CM",mv_par11))
			EndIf
			nCusMed := Round(nCusMed,nDec)
			oSection1:Init()
			oSection2:Init()
			oSection1:Cell("B1_COD"):SetValue(aSB1[1][1])			            
			oSection1:Cell("B1_DESC"):SetValue(aSB1[1][2])			            
			oSection1:Cell("B1_UM"):SetValue(aSB1[1][3])			            
			oSection1:Cell("B1_TIPO"):SetValue(aSB1[1][4])			            
			oSection1:Cell("B1_GRUPO"):SetValue(aSB1[1][5])			            
			If nCusMed > 0
				oSection1:Cell("nCusMed"):SetValue(nCusMed)
			Else
				oSection1:Cell("nCusMed"):SetValue(aSB1[1][6])
			EndIf
			oSection1:Cell("nQtdSal"):SetValue(aSalAtu[1])			            
			oSection1:Cell("nVlrSal"):SetValue(aSalAtu[mv_par11+1])	
			oSection1:PrintLine()
			oSection2:PrintLine()
			lFirst1 := .F.
		EndIf

		oSection3:Cell("dDtMov"):SetValue(aSD3[I][4])			
		oSection3:Cell("cTES"):SetValue(aSD3[I][6])														
		oSection3:Cell("cCF"):SetValue(aSD3[I][5])			
		oSection3:Cell("cDoc"):SetValue(IIf(mv_par09 == 1,aSD3[I][13],aSD3[I][3]))							
		
		If aSD3[I][23]
			If aSD3[I][6] > "500"
				oSection3:Cell("nENTQtd"):Show()
				oSection3:Cell("nENTCus"):Show()
				oSection3:Cell("nCusMov"):Show()
					
				oSection3:Cell("nENTQtd"):SetValue(aSD3[I][14])			
				oSection3:Cell("nENTCus"):SetValue(aSD3[I][20])					            
				oSection3:Cell("nCusMov"):SetValue(aSD3[I][20] / aSD3[I][14])		               				
				
				oSection3:Cell("nSAIQtd"):Hide()
				oSection3:Cell("nSAICus"):Hide()
				oSection3:Cell("nSAIQtd"):SetValue(0)			
				oSection3:Cell("nSAICus"):SetValue(0)											
				
				nEntrada	+= aSD3[I][14]
				aSalAtu[1]	+= aSD3[I][14]
				nCEntrada	+= Round(aSD3[I][20],nDec)
				aSalAtu[mv_par11+1] += Round(aSD3[I][20],nDec)
				aSalAtu[7]	+= aSD3[I][15]		// QTSEGUM
			Else
				oSection3:Cell("nSAIQtd"):Show()
				oSection3:Cell("nSAICus"):Show()
				oSection3:Cell("nCusMov"):Show()
					
				oSection3:Cell("nSAIQtd"):SetValue(aSD3[I][14])			
				oSection3:Cell("nSAICus"):SetValue(aSD3[I][20])														
				oSection3:Cell("nCusMov"):SetValue(aSD3[I][20] / aSD3[I][14])		               				
				
				oSection3:Cell("nENTQtd"):Hide()
				oSection3:Cell("nENTCus"):Hide()
				oSection3:Cell("nENTQtd"):SetValue(0)			
				oSection3:Cell("nENTCus"):SetValue(0)					            			
				
				nSaida		+= aSD3[I][14]
				aSalAtu[1]	-= aSD3[I][14]
				nCSaida		+= Round(aSD3[I][20],nDec)
				aSalAtu[mv_par11+1] -= Round(aSD3[I][20],nDec)
				aSalAtu[7]	-= aSD3[I][15]
			EndIf
		Else
			If aSD3[I][6] <= "500"
				oSection3:Cell("nENTQtd"):Show()
				oSection3:Cell("nENTCus"):Show()
				oSection3:Cell("nCusMov"):Show()
					
				oSection3:Cell("nENTQtd"):SetValue(aSD3[I][14])			
				oSection3:Cell("nENTCus"):SetValue(aSD3[I][20])					            
				oSection3:Cell("nCusMov"):SetValue(aSD3[I][20] / aSD3[I][14])		               				
				
				oSection3:Cell("nSAIQtd"):Hide()
				oSection3:Cell("nSAICus"):Hide()
				oSection3:Cell("nSAIQtd"):SetValue(0)			
				oSection3:Cell("nSAICus"):SetValue(0)											
				
				nEntrada	+= aSD3[I][14]
				aSalAtu[1]	+= aSD3[I][14]
				nCEntrada	+= Round(aSD3[I][20],nDec)
				aSalAtu[mv_par11+1] += Round(aSD3[I][20],nDec)
				aSalAtu[7]	+= aSD3[I][15]		// QTSEGUM
			Else
				oSection3:Cell("nSAIQtd"):Show()
				oSection3:Cell("nSAICus"):Show()
				oSection3:Cell("nCusMov"):Show()
					
				oSection3:Cell("nSAIQtd"):SetValue(aSD3[I][14])			
				oSection3:Cell("nSAICus"):SetValue(aSD3[I][20])														
				oSection3:Cell("nCusMov"):SetValue(aSD3[I][20] / aSD3[I][14])		               				
				
				oSection3:Cell("nENTQtd"):Hide()
				oSection3:Cell("nENTCus"):Hide()
				oSection3:Cell("nENTQtd"):SetValue(0)			
				oSection3:Cell("nENTCus"):SetValue(0)					            			
				
				nSaida		+= aSD3[I][14]
				aSalAtu[1]	-= aSD3[I][14]
				nCSaida		+= Round(aSD3[I][20],nDec)
				aSalAtu[mv_par11+1] -= Round(aSD3[I][20],nDec)
				aSalAtu[7]	-= aSD3[I][15]
			EndIf
		EndIf
		oSection3:Cell("nSALDQtd"):SetValue(aSalAtu[1])			
		oSection3:Cell("nSALDCus"):SetValue(aSalAtu[mv_par11+1])							
		
		If Empty(aSD3[I][16])					// OP
			oSection3:Cell("cCCPVPJOP"):SetValue("CC"+aSD3[I][19])
		Else
			oSection3:Cell("cCCPVPJOP"):SetValue("OP"+aSD3[I][16])
		EndIf
		nRec3++
		oSection3:PrintLine()	
	Next
	/**** FIM SD3 ****/
	
	/**** INICIO SD2 ****/
	For I:=1 To Len(aSD2)

		dbSelectArea("SB2")
		dbSetOrder(1) //B2_FILIAL+B2_COD+B2_LOCAL
		dbSeek(xFilial("SB2")+aSD2[I][1]+IIf(lCusUnif,"",mv_par08))
		
		If lFirst1
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula o Saldo Inicial do Produto             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF lCusUnif
				aArea:=GetArea()
				aSalAtu  := { 0,0,0,0,0,0,0 }
				dbSelectArea("SB2")
				dbSetOrder(1) //B2_FILIAL+B2_COD+B2_LOCAL
				dbSeek(cSeek:=xFilial("SB2")+aSD2[I][1])
				While !Eof() .And. B2_FILIAL+B2_COD == cSeek
					aSalAlmox := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,mv_par05)
					For nX:=1 to Len(aSalAtu)
						aSalAtu[nX] += aSalAlmox[nX]
					Next nX
					dbSkip()
				End
				RestArea(aArea)
			Else
				aSalAtu := CalcEst(aSD2[I][1],mv_par08,mv_par05)
			EndIf	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula o Custo Medio do Produto               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If aSalAtu[1] > 0 .And. aSalAtu[mv_par11+1] > 0
				nCusMed := aSalAtu[mv_par11+1]/aSalAtu[1]
			ElseIf aSalAtu[1] == 0 .And. aSalAtu[mv_par11+1] == 0
				nCusMed := 0
			Else
				nCusMed := &(Eval(bBloco,"SB2->B2_CM",mv_par11))
			Endif
			nCusMed := Round(nCusMed,nDec)
			oSection1:Init()
			oSection2:Init()
			oSection1:Cell("B1_COD"):SetValue(aSB1[1][1])			            
			oSection1:Cell("B1_DESC"):SetValue(aSB1[1][2])			            
			oSection1:Cell("B1_UM"):SetValue(aSB1[1][3])			            
			oSection1:Cell("B1_TIPO"):SetValue(aSB1[1][4])			            
			oSection1:Cell("B1_GRUPO"):SetValue(aSB1[1][5])			            
			If nCusMed > 0
				oSection1:Cell("nCusMed"):SetValue(nCusMed)
			Else
				oSection1:Cell("nCusMed"):SetValue(aSB1[1][6])
			EndIf
			oSection1:Cell("nQtdSal"):SetValue(aSalAtu[1])			            
			oSection1:Cell("nVlrSal"):SetValue(aSalAtu[mv_par11+1])	
			oSection1:PrintLine()
			oSection2:PrintLine()
			lFirst1 := .F.
		EndIf

		oSection3:Cell("dDtMov"):SetValue(aSD2[I][4])			
		oSection3:Cell("cTES"):SetValue(aSD2[I][6])														
		oSection3:Cell("cCF"):SetValue(If(aSD2[I][12]=="FT","FAC",aSD2[I][12]))			
		oSection3:Cell("cDoc"):SetValue(IIf(mv_par09 == 1,aSD2[I][13],aSD2[I][3]))									
		
		If aSD2[I][6] <= "500" .Or. aSD2[I][21] == "D"
			If  aSD2[I][21] == "D"
				If aSD2[I][14] > 0
					oSection3:Cell("nCusMov"):Show()
					oSection3:Cell("nCusMov"):SetValue(aSD2[I][20] / aSD2[I][14])
				Else
					oSection3:Cell("nCusMov"):Hide()
					oSection3:Cell("nCusMov"):SetValue(0)				
				EndIf
				oSection3:Cell("nSAIQtd"):Show()
				oSection3:Cell("nSAICus"):Show()

				oSection3:Cell("nSAIQtd"):SetValue(aSD2[I][14])			
				oSection3:Cell("nSAICus"):SetValue(aSD2[I][20])										

				oSection3:Cell("nENTQtd"):Hide()
				oSection3:Cell("nENTCus"):Hide()
				oSection3:Cell("nENTQtd"):SetValue(0)			
				oSection3:Cell("nENTCus"):SetValue(0)					            
				nSaida		+= aSD2[I][14]
				aSalAtu[1]	-= aSD2[I][14]
				nCSaida		+= Round(aSD2[I][20],nDec)
				aSalAtu[mv_par11+1] -= Round(aSD2[I][20],nDec)
				aSalAtu[7]	-= aSD2[I][15]
			EndIf
		Else
			If aSD2[I][14] > 0
				oSection3:Cell("nCusMov"):Show()
				oSection3:Cell("nCusMov"):SetValue(aSD2[I][20] / aSD2[I][14])
			Else
				oSection3:Cell("nCusMov"):Hide()
				oSection3:Cell("nCusMov"):SetValue(0)			
			EndIf

			oSection3:Cell("nSAIQtd"):Show()
			oSection3:Cell("nSAICus"):Show()
				
			oSection3:Cell("nSAIQtd"):SetValue(aSD2[I][14])			
			oSection3:Cell("nSAICus"):SetValue(aSD2[I][20])														
			
			oSection3:Cell("nENTQtd"):Hide()
			oSection3:Cell("nENTCus"):Hide()
			oSection3:Cell("nENTQtd"):SetValue(0)			
			oSection3:Cell("nENTCus"):SetValue(0)					            			
			
			nSaida		+= aSD2[I][14]
			aSalAtu[1]	-= aSD2[I][14]
			nCSaida		+= Round(aSD2[I][20],nDec)
			aSalAtu[mv_par11+1] -= Round(aSD2[I][20],nDec)
			aSalAtu[7]	-= aSD2[I][15]
		EndIf

		oSection3:Cell("nSALDQtd"):SetValue(aSalAtu[1])			
		oSection3:Cell("nSALDCus"):SetValue(aSalAtu[mv_par11+1])							
		
		If Empty(aSD2[I][16])		// OP
			If aSD2[I][21] <> "D"
				oSection3:Cell("cCCPVPJOP"):SetValue(STR0038+aSD2[I][08]) //"P-"
			Else
				oSection3:Cell("cCCPVPJOP"):SetValue(STR0039+aSD2[I][18]) //"C-"
			EndIf
		Else
			oSection3:Cell("cCCPVPJOP"):SetValue("OP"+aSD2[I][16])
		EndIf
		nRec2++
		oSection3:PrintLine()	
	Next
	/**** FIM SD2 ****/
	Exit
Enddo

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R911TotImp³ Autor ³Nereu Humberto Junior  ³ Data ³ 20.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Imprime os Totais                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR911                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R911TotImp(aSB1,oReport,oSection1,oSection2,oSection3)

Local nGrp		:= 0
Local nUn		:= 0
Local I			:= 0
Local aArea		:= {}
Local aSalAlmox	:= {}

If (nRec1+nRec2+nRec3) > 0
	nGrp := ASCAN(aGrupos,{|x| aSB1[1][4] == x[1]})
	If nGrp > 0
		aGrupos[nGrp][2]	+= nEntrada				// Quantidade
		aGrupos[nGrp][3]	+= nCEntrada			// Custo
		aGrupos[nGrp][4]	+= nSaida	   			// Quantidade
		aGrupos[nGrp][5]	+= nCSaida				// Custo
	Else
		AADD(aGrupos,{aSB1[1][4],nEntrada,nCEntrada,nSaida,nCSaida,aSalAtu[1],aSalAtu[mv_par11+1]})
	EndIf
	
	//Agrupa custo por unidade de medida
	nUn := ASCAN(aUnids,{|x| aSB1[1][3] == x[1]})
	If nUn > 0
		aUnids[nUn][2]	+= nEntrada				// Quantidade
		aUnids[nUn][3]	+= nCEntrada			// Custo
		aUnids[nUn][4]	+= nSaida	   			// Quantidade
		aUnids[nUn][5]	+= nCSaida				// Custo
	Else
		AADD(aUnids,{aSB1[1][3],nEntrada,nCEntrada,nSaida,nCSaida,aSalAtu[1],aSalAtu[mv_par11+1]})
	EndIf
	oReport:PrintText(STR0018+TransForm(aSalAtu[7],cPicB2Qt2),,oSection3:Cell('nSAICus'):ColPos()) //"QTD. NA SEGUNDA UM: "												
	oReport:ThinLine()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se deve ou nao listar os produtos s/movimento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula o Saldo Inicial do Produto             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lCusUnif
			aArea:=GetArea()
			aSalAtu  := { 0,0,0,0,0,0,0 }
			dbSelectArea("SB2")
			dbSetOrder(1) //B2_FILIAL+B2_COD+B2_LOCAL
			dbSeek(cSeek:=xFilial("SB2")+aSB1[1][1])
			While !Eof() .And. B2_FILIAL+B2_COD == cSeek
				aSalAlmox := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,mv_par05)
				For i:=1 to Len(aSalAtu)
					aSalAtu[i] += aSalAlmox[i]
				Next i
				dbSkip()
			End
			RestArea(aArea)
		Else		
			aSalAtu := CalcEst(aSB1[1][1],mv_par08,mv_par05)
    	EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula o Custo Medio do Produto               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If aSalAtu[1] > 0 .And. aSalAtu[mv_par11+1] > 0
			nCusMed := aSalAtu[mv_par11+1]/aSalAtu[1]
		ElseIf aSalAtu[1] == 0 .And. aSalAtu[mv_par11+1] == 0
			nCusMed := 0
		Else
			nCusMed := &(Eval(bBloco,"SB2->B2_CM",mv_par11))
		EndIf
		nCusMed := Round(nCusMed,nDec)

		oSection1:Init()
		oSection2:Init()
		oSection1:Cell("B1_COD"):SetValue(aSB1[1][1])			            
		oSection1:Cell("B1_DESC"):SetValue(aSB1[1][2])			            
		oSection1:Cell("B1_UM"):SetValue(aSB1[1][3])			            
		oSection1:Cell("B1_TIPO"):SetValue(aSB1[1][4])			            
		oSection1:Cell("B1_GRUPO"):SetValue(aSB1[1][5])			            
		If nCusMed > 0
			oSection1:Cell("nCusMed"):SetValue(nCusMed)
		Else
			oSection1:Cell("nCusMed"):SetValue(aSB1[1][6])
		EndIf
		oSection1:Cell("nQtdSal"):SetValue(aSalAtu[1])			            
		oSection1:Cell("nVlrSal"):SetValue(aSalAtu[mv_par11+1])	
		oSection1:PrintLine()
		oSection2:PrintLine()

		oReport:PrintText(STR0019)	//"NAO HOUVE MOVIMENTACAO PARA ESTE PRODUTO"
		oReport:ThinLine()
	EndIf
EndIf

nEntrada  := 0
nCEntrada := 0
nSaida    := 0
nCSaida   := 0

nRec1     := 0
nRec2     := 0
nRec3     := 0

Return Nil

/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MontPict     ³ Autor ³ Bruno Schmidt         ³ Data ³ 23/11/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta a picture conforme o parametro MV_CENT                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Siga                                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/   
Static Function MontPict(cAlias,cCampo)

Local cPict		:= ""
Local nPosPict	:= 0 
local nTamPic	:= 18//TamSX3(cCampo)[1]
Local ny		:= 0
Local cPictDec	:= ""
Local nx		:= 0

// Decimais apos a virgula conforme o parametro MV_CENT
For ny:= 1 to nDec 
	cPictDec+='9'
Next 

// Informando a virgula da picture conforme o parametro MV_CENT
If nDec > 0 
	cPictDec:='.'+ cPictDec
EndIf
nPosPict := nTamPic - Len(cPictDec)

//Preenchendo os campos conforme o tamanho do mesmo
For ny:= 1 to nPosPict
    If nx <> 3
		cPict:='9'+cPict
		nx+=1
	Else 
		cPict:=','+cPict
		nx:=0
	EndIf
Next

cPict :="@E "+cPict+cPictDec	

Return cPict                                               
