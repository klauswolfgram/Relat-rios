/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR131.CH"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR131  ³ Autor ³Alexandre Inacio Lemes ³ Data ³14/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Informe de Pedidos de Compra/Remitos/Notas Fiscais         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR131(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MATR131()

Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Alexandre Inacio Lemes ³Data  ³14/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Informe de Pedidos de Compra/Remitos/Notas Fiscais         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local aOrdem    := {STR0003,STR0004,STR0005} //"Fecha emision" , "Proveedor" , "Producto"
Local cTitle    := ""
Local oReport
Local oSection1
Local cRetTitle := Rtrim(RetTitle("D2_REMITO"))	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros ³
//³ mv_par01       // ¨Basado por ?      ³
//³ mv_par02       // ¨De proveedor?     ³
//³ mv_par03       // ¨Hasta proveedor?  ³
//³ mv_par04       // ¨De producto ?     ³
//³ mv_par05       // ¨Hasta producto?   ³
//³ mv_par06       // ¨De grupo ?        ³
//³ mv_par07       // ¨Hasta grupo ?     ³
//³ mv_par08       // ¨De Fecha Emision? ³
//³ mv_par09       // ¨Hasta Fech.Emis.? ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR131",.F.)

If mv_par01 = 1                                                        //OC/RM/FT
	cTitle := STR0072 + cRetTitle + STR0073 + "/" + STR0074            //"Relacion de Orden de Compras/Remitos/Facturas"
ElseIf mv_par01 = 2                                                    //RM/OC/FT
	cTitle := STR0075 + cRetTitle + STR0073 + STR0076 + "/" + STR0074  //"Relacion de Remitos/Orden de Compras/Facturas"
ElseIf mv_par01 = 3                                                    //FT/RM/OC
	cTitle := STR0075 + STR0074 + "/" + cRetTitle + STR0073 + STR0076  //"Relacion de Facturas/Remitos/Orden de Compras"
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
oReport:= TReport():New("MATR131",cTitle,"MTR131", {|oReport| ReportPrint(oReport,aOrdem)},STR0001 + " " + cRetTitle + " " + STR0073 + STR0071 )//"Imprime relaci¢n de las ordenes de compra"+cRetTitle+"Remito(s) y Facturas"
oReport:SetLandscape()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSect1Ped:= TRSection():New(oReport,STR0085,{"SC7","SB1","SA2"},aOrdem)
TRCell():New(oSect1Ped,"C7_EMISSAO","SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Ped,"C7_FORNECE","SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Ped,"C7_LOJA"   ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Ped,"A2_NOME"   ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Ped,"C7_PRODUTO","SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Ped,"B1_DESC"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSect2Ped:= TRSection():New(oSect1Ped,STR0086,{"SC7","SD1","SF1","SB1","SA2"})
oSect2Ped:SetTotalInLine(.F.)
oSect2Ped:SetHeaderPage()
TRCell():New(oSect2Ped,"C7_EMISSAO","SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"C7_FORNECE","SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"C7_LOJA"   ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"C7_PRODUTO","SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"C7_NUM"    ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"C7_ITEM"   ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"C7_PRECO"  ,"SC7",/*Titulo*/,PesqPict("SC7","C7_PRECO",16),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"C7_QUANT"  ,"SC7",/*Titulo*/,PesqPictQt( "C7_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"C7_DATPRF" ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"REMDOC"    ,"   ",STR0079,/*Picture*/,TamSX3('D1_DOC')[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"REMITEM"   ,"   ",STR0080,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"REMQUANT"  ,"   ",STR0081,PesqPictQt( "C7_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"REMEMISSAO","   ",STR0082,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"D1_DOC"    ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,SerieNfId("SD1",3,"D1_SERIE"),"SD1",SerieNfId("SD1",7,"D1_SERIE"),/*Picture*/,SerieNfId("SD1",6,"D1_SERIE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"D1_ITEM"   ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"D1_VUNIT"  ,"SD1",/*Titulo*/,PesqPict("SD1","D1_VUNIT",16),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"D1_QUANT"  ,"SD1",/*Titulo*/,PesqPictQt( "D1_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Ped,"DIVPRECO"  ,"   ",STR0083,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf((cAliasQry)->C7_PRECO  <> SD1->D1_VUNIT  , STR0069 , STR0070 )})
TRCell():New(oSect2Ped,"DIVDATE"   ,"   ",STR0084,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf((cAliasQry)->C7_DATPRF <> SD1->D1_EMISSAO, STR0069 , STR0070 )})

oSect1Rem:= TRSection():New(oReport,STR0087,{"SD1","SB1","SA2"},aOrdem)
TRCell():New(oSect1Rem,"D1_EMISSAO","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Rem,"D1_FORNECE","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Rem,"D1_LOJA"   ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Rem,"A2_NOME"   ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Rem,"D1_COD"    ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Rem,"B1_DESC"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSect2Rem:= TRSection():New(oSect1Rem,STR0088,{"SD1","SF1","SC7","SB1","SA2"})
oSect2Rem:SetTotalInLine(.F.)
oSect2Rem:SetHeaderPage()
TRCell():New(oSect2Rem,"D1_EMISSAO","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"D1_FORNECE","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"D1_LOJA"   ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"D1_COD"    ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"D1_DOC"    ,"SD1",STR0079,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"D1_ITEM"   ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"D1_QUANT"  ,"SD1",/*Titulo*/,PesqPictQt("D1_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"DT_EMISSAO","   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"C7_NUM"    ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"C7_ITEM"   ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"C7_PRECO"  ,"SC7",/*Titulo*/,PesqPict("SC7","C7_PRECO",16),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"C7_QUANT"  ,"SC7",/*Titulo*/,PesqPictQt("C7_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"C7_DATPRF" ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"NFDOC"     ,"   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"NFITEM"    ,"   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"NFVUNIT"   ,"   ",/*Titulo*/,PesqPict("SD1","D1_VUNIT",16),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"NFQUANT"   ,"   ",/*Titulo*/,PesqPictQt("D1_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Rem,"DIVPRECO"  ,"   ",STR0083,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf( lSC7 , IIf( SC7->C7_PRECO  <> SD1->D1_VUNIT   , STR0069 , STR0070 ) , "" )})
TRCell():New(oSect2Rem,"DIVDATE"   ,"   ",STR0084,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf( lSC7 , IIf( SC7->C7_DATPRF <> SD1->D1_EMISSAO , STR0069 , STR0070 ) , "" )})

oSect2Rem:Cell("NFDOC"):GetFieldInfo("D1_DOC")
oSect2Rem:Cell("NFITEM"):GetFieldInfo("D1_ITEM")
oSect2Rem:Cell("NFVUNIT"):GetFieldInfo("D1_VUNIT")
oSect2Rem:Cell("NFQUANT"):GetFieldInfo("D1_QUANT")
oSect2Rem:Cell("DT_EMISSAO"):GetFieldInfo("D1_EMISSAO")

oSect1Nfe:= TRSection():New(oReport,STR0089,{"SD1","SB1","SA2"},aOrdem)
TRCell():New(oSect1Nfe,"D1_EMISSAO","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Nfe,"D1_FORNECE","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Nfe,"D1_LOJA"   ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Nfe,"A2_NOME"   ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Nfe,"D1_COD"    ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect1Nfe,"B1_DESC"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSect2Nfe:= TRSection():New(oSect1Nfe,STR0090,{"SD1","SF1","SC7","SB1","SA2"})
oSect2Nfe:SetTotalInLine(.F.)
oSect2Nfe:SetHeaderPage()
TRCell():New(oSect2Nfe,"D1_EMISSAO","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"D1_FORNECE","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"D1_LOJA"   ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"D1_COD"    ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"D1_DOC"    ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,SerieNfId("SD1",3,"D1_SERIE")  ,"SD1",SerieNfId("SD1",7,"D1_SERIE"),/*Picture*/,SerieNfId("SD1",6,"D1_SERIE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"D1_ITEM"   ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"D1_VUNIT"  ,"SD1",/*Titulo*/,PesqPict("SD1","D1_VUNIT",16),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"D1_QUANT"  ,"SD1",/*Titulo*/,PesqPictQt("D1_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"REMDOC"    ,"   ",STR0079,/*Picture*/,TamSX3('D1_DOC')[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"REMITEM"   ,"   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"REMQUANT"  ,"   ",/*Titulo*/,PesqPictQt("D1_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"REMEMISSAO","   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"C7_NUM"    ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"C7_ITEM"   ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"C7_PRECO"  ,"SC7",/*Titulo*/,PesqPict("SC7","C7_PRECO",16),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"C7_QUANT"  ,"SC7",/*Titulo*/,PesqPictQt("C7_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"C7_DATPRF" ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSect2Nfe,"DIVPRECO"  ,"   ",STR0083,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| Iif( lSC7 , Iif( SC7->C7_PRECO  <> SD1->D1_VUNIT   , STR0069 , STR0070 ) , "" ) })
TRCell():New(oSect2Nfe,"DIVDATE"   ,"   ",STR0084,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| Iif( lSC7 , Iif( SC7->C7_DATPRF <> SD1->D1_EMISSAO , STR0069 , STR0070 ) , "" ) })

oSect2Nfe:Cell("REMITEM"):GetFieldInfo("D1_ITEM")
oSect2Nfe:Cell("REMQUANT"):GetFieldInfo("D1_QUANT")
oSect2Nfe:Cell("REMEMISSAO"):GetFieldInfo("D1_EMISSAO")


oSect1Ped:SetNoFilter("SB1")
oSect1Ped:SetNoFilter("SA2")
oSect2Ped:SetNoFilter("SF1")

oSect1Rem:SetNoFilter("SB1")
oSect1Rem:SetNoFilter("SA2")
oSect2Rem:SetNoFilter("SF1")

oSect1Nfe:SetNoFilter("SB1")
oSect1Nfe:SetNoFilter("SA2")
oSect2Nfe:SetNoFilter("SF1")

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Alexandre Inacio Lemes ³Data  ³14/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Informe de Pedidos de Compra/Remitos/Notas Fiscais         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aOrdem)

Local oSection1
Local oSection2
Local aArea      := {}
Local cCondicao  := ""
Local cIndexKey  := ""
Local cOrder     := ""
Local cOrdem     := ""
Local cInitOrdem := ""
Local cRemito    := ""
Local cFatuRem   := ""
Local cSeriRem   := ""
Local cFornRem   := ""
Local cLojaRem   := ""
Local cCodRem    := ""
Local cItemRem   := ""
Local DtEmisRem  := ""
Local cWhere     := ""
Local nQuantRem  := 0
Local nRecnoSD1  := 0
Local nPrinted   := 0
Local nTPrinted  := 0
Local nOrdem     := oReport:Section(1):GetOrder()
Local lQuery     := .F.
Local lPrintLine := .F.
Local cSelect    := ""

Local cQryRem    := ""
Local cQryNfes   := ""
Local cTamDoc	 := space(TamSX3('D1_DOC')[1])

Private cAliasQry:= ""
Private lSC7     := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declara as Sections 1 e 2 conforme o parametro selecionado no ³
//³mv_par01 e desabilata as sessoes que nao serao utilizadas     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par01 == 1
	oSection1  := oReport:Section(1)
	oSection2  := oReport:Section(1):Section(1)
	oReport:Section(2):Disable()
	oReport:Section(2):Section(1):Disable()
	oReport:Section(3):Disable()
	oReport:Section(3):Section(1):Disable()
ElseIf mv_par01 == 2
	oSection1  := oReport:Section(2)
	oSection2  := oReport:Section(2):Section(1)
	oReport:Section(1):Disable()
	oReport:Section(1):Section(1):Disable()
	oReport:Section(3):Disable()
	oReport:Section(3):Section(1):Disable()
ElseIf mv_par01 == 3
	oSection1  := oReport:Section(3)
	oSection2  := oReport:Section(3):Section(1)
	oReport:Section(1):Disable()
	oReport:Section(1):Section(1):Disable()
	oReport:Section(2):Disable()
	oReport:Section(2):Section(1):Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Desabilita as celulas conforme a Ordem seleciona e o mv_par01 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par01 == 1
	If nOrdem == 1
		oSection1:Cell("C7_FORNECE"):Disable()
		oSection1:Cell("C7_LOJA"):Disable()
		oSection1:Cell("A2_NOME"):Disable()
		oSection1:Cell("C7_PRODUTO"):Disable()
		oSection1:Cell("B1_DESC"):Disable()
		oSection2:Cell("C7_EMISSAO"):Disable()
	ElseIf nOrdem == 2
		oSection1:Cell("C7_EMISSAO"):Disable()
		oSection1:Cell("C7_PRODUTO"):Disable()
		oSection1:Cell("B1_DESC"):Disable()
		oSection2:Cell("C7_FORNECE"):Disable()
		oSection2:Cell("C7_LOJA"):Disable()
	ElseIf nOrdem == 3
		oSection1:Cell("C7_EMISSAO"):Disable()
		oSection1:Cell("C7_FORNECE"):Disable()
		oSection1:Cell("C7_LOJA"):Disable()
		oSection1:Cell("A2_NOME"):Disable()
		oSection2:Cell("C7_PRODUTO"):Disable()
	EndIf
Else
	If nOrdem == 1
		oSection1:Cell("D1_FORNECE"):Disable()
		oSection1:Cell("D1_LOJA"):Disable()
		oSection1:Cell("A2_NOME"):Disable()
		oSection1:Cell("D1_COD"):Disable()
		oSection1:Cell("B1_DESC"):Disable()		
		oSection2:Cell("D1_EMISSAO"):Disable()
	ElseIf nOrdem == 2
		oSection1:Cell("D1_EMISSAO"):Disable()
		oSection1:Cell("D1_COD"):Disable()
		oSection1:Cell("B1_DESC"):Disable()		
		oSection2:Cell("D1_FORNECE"):Disable()
		oSection2:Cell("D1_LOJA"):Disable()
	ElseIf nOrdem == 3
		oSection1:Cell("D1_EMISSAO"):Disable()
		oSection1:Cell("D1_FORNECE"):Disable()
		oSection1:Cell("D1_LOJA"):Disable()
		oSection1:Cell("A2_NOME"):Disable()
		oSection2:Cell("D1_COD"):Disable()
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " ("+AllTrim(aOrdem[nOrdem])+") ")

lQuery    := .T.	

cAliasQry := GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query da Section1 em Pedido de compras conforme o mv_par01 =1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
If mv_par01 == 1

	dbSelectArea("SC7")

	MakeSqlExpr(oReport:uParam)

	oSection1:BeginQuery()	

	If nOrdem == 1
		cOrder := "% C7_FILIAL,C7_EMISSAO,C7_FORNECE,C7_PRODUTO,C7_NUM %"
		cOrdem := "C7_FILIAL+DTOS(C7_EMISSAO)"

	ElseIf nOrdem == 2
		cOrder := "% C7_FILIAL,C7_FORNECE,C7_EMISSAO,C7_PRODUTO,C7_NUM %"
		cOrdem := "C7_FILIAL+C7_FORNECE+C7_LOJA"

	ElseIf nOrdem == 3
		cOrder := "% C7_FILIAL,C7_PRODUTO,C7_EMISSAO,C7_FORNECE,C7_NUM %"
		cOrdem := "C7_FILIAL+C7_PRODUTO"
	EndIf

	BeginSql Alias cAliasQry

	SELECT SC7.*

	FROM %table:SC7% SC7

	WHERE C7_FILIAL  = %xFilial:SC7% AND
	C7_FORNECE  >= %Exp:mv_par02% AND
	C7_FORNECE  <= %Exp:mv_par03% AND
	C7_PRODUTO  >= %Exp:mv_par04% AND
	C7_PRODUTO  <= %Exp:mv_par05% AND
	C7_EMISSAO  >= %Exp:Dtos(mv_par08)% AND
	C7_EMISSAO  <= %Exp:Dtos(mv_par09)% AND
	SC7.%NotDel%

	ORDER BY %Exp:cOrder%

	EndSql

	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)

		oSection2:SetParentQuery()
         
Else

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da Section1 no SD1 conforme o mv_par01 == 2-Remito 3-NFE³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	dbSelectArea("SD1")

	MakeSqlExpr(oReport:uParam)

	oSection1:BeginQuery()	

	cWhere :="%"
	If mv_par01 == 2
		cWhere += "AND ("+IsRemito(3,'D1_TIPODOC')+ ")"
	Else
		cWhere += "AND NOT ("+IsRemito(3,'D1_TIPODOC')+ ")"
	EndIf
	cWhere +="%"	

	If nOrdem == 1
		cOrder := "% D1_FILIAL,D1_EMISSAO,D1_FORNECE,D1_COD,D1_DOC %"
		cOrdem := "D1_FILIAL+DTOS(D1_EMISSAO)"
	ElseIf nOrdem == 2
		cOrder := "% D1_FILIAL,D1_FORNECE,D1_EMISSAO,D1_COD,D1_DOC %"
		cOrdem := "D1_FILIAL+D1_FORNECE+D1_LOJA"
	ElseIf nOrdem == 3
		cOrder := "% D1_FILIAL,D1_COD,D1_EMISSAO,D1_FORNECE,D1_DOC %"
		cOrdem := "D1_FILIAL+D1_COD"
	EndIf

	cSelect:= "%D1_FILIAL,D1_DOC,"
	cSelect+= Iif(SerieNfId("SD1",3,"D1_SERIE")<>"D1_SERIE",SerieNfId("SD1",3,"D1_SERIE")+","," ")
	cSelect+= "D1_SERIE,D1_FORNECE,D1_LOJA,D1_COD,D1_ITEM,D1_EMISSAO,D1_DTDIGIT,D1_QUANT,D1_VUNIT,	D1_TOTAL,D1_TIPODOC, "
	cSelect+= Iif(SerieNfId("SD1",3,"D1_SERIREM")<>"D1_SERIREM",SerieNfId("SD1",3,"D1_SERIREM")+","," ")
	cSelect+= "D1_SERIREM,D1_REMITO,D1_ITEMREM,D1_PEDIDO,D1_ITEMPC,D1_TIPO,D1_GRUPO%"
	

	BeginSql Alias cAliasQry

	SELECT %Exp:cSelect%

	FROM %table:SD1% SD1

	WHERE D1_FILIAL  = %xFilial:SD1% AND
	D1_FORNECE  >= %Exp:mv_par02% AND
	D1_FORNECE  <= %Exp:mv_par03% AND
	D1_COD      >= %Exp:mv_par04% AND
	D1_COD      <= %Exp:mv_par05% AND
	D1_EMISSAO  >= %Exp:Dtos(mv_par08)% AND
	D1_EMISSAO  <= %Exp:Dtos(mv_par09)% AND
	SD1.%NotDel%
	%Exp:cWhere%

	ORDER BY %Exp:cOrder%

	EndSql

	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)

EndIf


oReport:SetMeter( Iif( mv_par01 == 1 , SC7->(LastRec()) , SD1->(LastRec()) ) )
dbSelectArea(cAliasQry)

While !oReport:Cancel() .And. !(cAliasQry)->(Eof())

	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posicionamento do SB1 - Produtos e SA2 - Fornecedores        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	SB1->(MsSeek( xFilial("SB1")+ Iif( mv_par01 == 1 , (cAliasQry)->C7_PRODUTO , (cAliasQry)->D1_COD )))
	SA2->(MsSeek( xFilial("SA2")+ Iif( mv_par01 == 1 , (cAliasQry)->C7_FORNECE + (cAliasQry)->C7_LOJA , (cAliasQry)->D1_FORNECE + (cAliasQry)->D1_LOJA )))

	If SB1->B1_GRUPO < mv_par06 .Or. SB1->B1_GRUPO > mv_par07
		dbskip()
		Loop
	Endif

	cInitOrdem := (cAliasQry)->&(cOrdem)

	oReport:SkipLine()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Section1 imprime o Dado da Quebra conforme a Ordem Selecionada³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	oSection1:Init()
	oSection1:PrintLine()		
	oReport:SkipLine()

	oSection2:Init()	
	While !oReport:Cancel() .And. !(cAliasQry)->(Eof()) .And. cInitOrdem	==	(cAliasQry)->&(cOrdem)

		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf  



	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posicionamento do SB1 - Produtos e SA2 - Fornecedores        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	SB1->(MsSeek( xFilial("SB1")+ Iif( mv_par01 == 1 , (cAliasQry)->C7_PRODUTO , (cAliasQry)->D1_COD )))
	SA2->(MsSeek( xFilial("SA2")+ Iif( mv_par01 == 1 , (cAliasQry)->C7_FORNECE + (cAliasQry)->C7_LOJA , (cAliasQry)->D1_FORNECE + (cAliasQry)->D1_LOJA )))

	If SB1->B1_GRUPO < mv_par06 .Or. SB1->B1_GRUPO > mv_par07
		dbskip()
		Loop
	Endif



		If mv_par01  == 3
			SF1->(MsSeek( xFilial("SF1")+(cAliasQry)->D1_DOC+(cAliasQry)->D1_SERIE+(cAliasQry)->D1_FORNECE+(cAliasQry)->D1_LOJA))
		EndIf
			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Relatorio com Base no Pedido De Compras                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		If mv_par01 == 1

			lPrintline := .F.

			cQryRem := GetNextAlias()
			cSelect := "% D1_FILIAL, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_COD, D1_ITEM, D1_EMISSAO, D1_DTDIGIT, D1_QUANT, D1_VUNIT, D1_TOTAL, D1_TIPODOC, D1_SERIREM, D1_REMITO, D1_ITEMREM, D1_PEDIDO, D1_ITEMPC, D1_LOCAL, D1_NUMSEQ %"
			cOrder := "% D1_FILIAL,D1_COD,D1_LOCAL,D1_NUMSEQ %"

			BeginSql Alias cQryRem

			SELECT %Exp:cSelect%
			FROM %table:SD1% SD1
			WHERE SD1.D1_FILIAL  = %xFilial:SD1% AND
				SD1.D1_COD = %Exp:(cAliasQry)->C7_PRODUTO% AND
				SD1.D1_PEDIDO = %Exp:(cAliasQry)->C7_NUM% AND
				SD1.D1_ITEMPC = %Exp:(cAliasQry)->C7_ITEM% AND
				SD1.%NotDel%
			ORDER BY %Exp:cOrder%

			EndSql

			dbSelectArea(cQryRem)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³While de Busca dos Remito SD1                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			While !(cQryRem)->(Eof()) .And. (cQryRem)->D1_COD == (cAliasQry)->C7_PRODUTO

				oSection2:Cell("REMDOC"):Show()
				oSection2:Cell("REMITEM"):Show()
				oSection2:Cell("REMQUANT"):Show()
				oSection2:Cell("REMEMISSAO"):Show()

				If (cQryRem)->D1_TIPODOC >= "50"

					// Informacoes da nota baseadas no item do remito localizado
					cFatuRem	:= (cQryRem)->D1_DOC
					cSeriRem	:= (cQryRem)->D1_SERIE
					cFornRem	:= (cQryRem)->D1_FORNECE
					cLojaRem	:= (cQryRem)->D1_LOJA
					cCodRem		:= (cQryRem)->D1_COD
					cItemRem	:= (cQryRem)->D1_ITEM

					SF1->(MsSeek( xFilial("SF1")+(cQryRem)->D1_DOC+(cQryRem)->D1_SERIE))
		
					oSection2:Cell("REMDOC"):SetValue((cQryRem)->D1_DOC)
					oSection2:Cell("REMITEM"):SetValue((cQryRem)->D1_ITEM)
					oSection2:Cell("REMQUANT"):SetValue((cQryRem)->D1_QUANT)
					oSection2:Cell("REMEMISSAO"):SetValue(SToD((cQryRem)->D1_EMISSAO))

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ While de Busca das NFES                                      ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
					
					cQryNfes := GetNextAlias()
					cSelect := "% D1_FILIAL, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_COD, D1_ITEM, D1_EMISSAO, D1_DTDIGIT, D1_QUANT, D1_VUNIT, D1_TOTAL, D1_TIPODOC, D1_SERIREM, D1_REMITO, D1_ITEMREM, D1_PEDIDO, D1_ITEMPC %"
					cOrder := "% D1_FILIAL, D1_FORNECE, D1_LOJA, D1_SERIREM, D1_REMITO, D1_ITEMREM %"

					BeginSql Alias cQryNfes

					SELECT %Exp:cSelect%
					FROM %table:SD1% SD1
					WHERE SD1.D1_FILIAL  = %xFilial:SD1% AND
						SD1.D1_REMITO = %Exp:cFatuRem% AND
						SD1.D1_SERIREM = %Exp:cSeriRem% AND
						SD1.D1_ITEMREM = %Exp:cItemRem% AND
						SD1.D1_FORNECE = %Exp:cFornRem% AND
						SD1.D1_LOJA = %Exp:cLojaRem% AND
						SD1.D1_COD = %Exp:cCodRem% AND
						SD1.%NotDel%
					ORDER BY %Exp:cOrder%

					EndSql

					dbSelectArea(cQryNfes)

					If !(cQryNfes)->(EOF())

						While !SD1->(Eof()) .And. cFatuRem == (cQryNfes)->D1_REMITO .And. cSeriRem == (cQryNfes)->D1_SERIREM .And.;
								cFornRem == (cQryNfes)->D1_FORNECE .And. cLojaRem == (cQryNfes)->D1_LOJA .And. cCodRem == (cQryNfes)->D1_COD .And. cItemRem == (cQryNfes)->D1_ITEMREM

								oSection2:Cell("D1_DOC"):Show()
								oSection2:Cell("D1_SERIE"):Show()
								oSection2:Cell("D1_ITEM"):Show()
								oSection2:Cell("D1_VUNIT"):Show()
								oSection2:Cell("D1_QUANT"):Show()
								oSection2:Cell("DIVPRECO"):Show()
								oSection2:Cell("DIVDATE"):Show()

								oSection2:Cell("D1_DOC"):SetValue((cQryNfes)->D1_DOC)
								oSection2:Cell("D1_SERIE"):SetValue((cQryNfes)->D1_SERIE)
								oSection2:Cell("D1_ITEM"):SetValue((cQryNfes)->D1_ITEM)
								oSection2:Cell("D1_VUNIT"):SetValue((cQryNfes)->D1_VUNIT)
								oSection2:Cell("D1_QUANT"):SetValue((cQryNfes)->D1_QUANT)
								oSection2:Cell("DIVPRECO"):SetValue(Iif( (cAliasQry)->C7_PRECO  <> (cQryNfes)->D1_VUNIT   , STR0069 , STR0070 ))
								oSection2:Cell("DIVDATE"):SetValue(Iif( (cAliasQry)->C7_DATPRF <> STOD((cQryNfes)->D1_EMISSAO) , STR0069 , STR0070 ))
								
								lPrintline := .T.
								oSection2:PrintLine()

								oSection2:Cell("C7_EMISSAO"):Hide()
								oSection2:Cell("C7_FORNECE"):Hide()
								oSection2:Cell("C7_LOJA"):Hide()
								oSection2:Cell("C7_PRODUTO"):Hide()
								oSection2:Cell("C7_NUM"):Hide()
								oSection2:Cell("C7_ITEM"):Hide()
								oSection2:Cell("C7_PRECO"):Hide()
								oSection2:Cell("C7_QUANT"):Hide()
								oSection2:Cell("C7_DATPRF"):Hide()
								oSection2:Cell("REMDOC"):Hide()
								oSection2:Cell("REMITEM"):Hide()
								oSection2:Cell("REMQUANT"):Hide()
								oSection2:Cell("REMEMISSAO"):Hide()

							(cQryNfes)->(dbSkip())
						Enddo
					Else
						lPrintline := .T.
						oSection2:Cell("D1_DOC"):Hide()
						oSection2:Cell(SerieNfId("SD1",3,"D1_SERIE")):Hide()
						oSection2:Cell("D1_ITEM"):Hide()
						oSection2:Cell("D1_VUNIT"):Hide()
						oSection2:Cell("D1_QUANT"):Hide()
						oSection2:Cell("DIVPRECO"):Hide()
						oSection2:Cell("DIVDATE"):Hide()

						oSection2:PrintLine()

						oSection2:Cell("C7_EMISSAO"):Hide()
						oSection2:Cell("C7_FORNECE"):Hide()
						oSection2:Cell("C7_LOJA"):Hide()
						oSection2:Cell("C7_PRODUTO"):Hide()
						oSection2:Cell("C7_NUM"):Hide()
						oSection2:Cell("C7_ITEM"):Hide()
						oSection2:Cell("C7_PRECO"):Hide()
						oSection2:Cell("C7_QUANT"):Hide()
						oSection2:Cell("C7_DATPRF"):Hide()
					EndIf
					(cQryNfes)->(DBCloseArea())
				EndIf

				(cQryRem)->(dbSkip())
			Enddo
			

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Busca por NFs caso nao exista Remitos                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
				(cQryRem)->(DBGoTop())	  
				While !(cQryRem)->(Eof()) .And. (cAliasQry)->C7_PRODUTO == (cQryRem)->D1_COD

					SF1->(MsSeek( xFilial("SF1")+SD1->D1_DOC+SD1->D1_SERIE))
					
					If (cQryRem)->D1_TIPODOC < "50" .and. Empty((cQryRem)->D1_REMITO)
						oSection2:Cell("D1_DOC"):Show()
						oSection2:Cell(SerieNfId("SD1",3,"D1_SERIE")):Show()
						oSection2:Cell("D1_ITEM"):Show()
						oSection2:Cell("D1_VUNIT"):Show()
						oSection2:Cell("D1_QUANT"):Show()
						oSection2:Cell("DIVPRECO"):Show()
						oSection2:Cell("DIVDATE"):Show()

						oSection2:Cell("D1_DOC"):SetValue((cQryRem)->D1_DOC)
						oSection2:Cell("D1_SERIE"):SetValue((cQryRem)->D1_SERIE)
						oSection2:Cell("D1_ITEM"):SetValue((cQryRem)->D1_ITEM)
						oSection2:Cell("D1_VUNIT"):SetValue((cQryRem)->D1_VUNIT)
						oSection2:Cell("D1_QUANT"):SetValue((cQryRem)->D1_QUANT)
						oSection2:Cell("DIVPRECO"):SetValue(Iif( (cAliasQry)->C7_PRECO  <> (cQryRem)->D1_VUNIT   , STR0069 , STR0070 ))
						oSection2:Cell("DIVDATE"):SetValue(Iif( (cAliasQry)->C7_DATPRF <> STOD((cQryRem)->D1_EMISSAO) , STR0069 , STR0070 ))
							
						lPrintline := .T.

						oSection2:Cell("REMDOC"):Hide()
						oSection2:Cell("REMITEM"):Hide()
						oSection2:Cell("REMQUANT"):Hide()
						oSection2:Cell("REMEMISSAO"):Hide()

                     oSection2:PrintLine() 
                     
						oSection2:Cell("C7_EMISSAO"):Hide()
						oSection2:Cell("C7_FORNECE"):Hide()
						oSection2:Cell("C7_LOJA"):Hide()
						oSection2:Cell("C7_PRODUTO"):Hide()
						oSection2:Cell("C7_NUM"):Hide()
						oSection2:Cell("C7_ITEM"):Hide()
						oSection2:Cell("C7_PRECO"):Hide()
						oSection2:Cell("C7_QUANT"):Hide()
						oSection2:Cell("C7_DATPRF"):Hide()
					EndIf

					(cQryRem)->(dbSkip())
				Enddo

			oSection2:Cell("C7_EMISSAO"):Show()
			oSection2:Cell("C7_FORNECE"):Show()
			oSection2:Cell("C7_LOJA"):Show()
			oSection2:Cell("C7_PRODUTO"):Show()
			oSection2:Cell("C7_NUM"):Show()
			oSection2:Cell("C7_ITEM"):Show()
			oSection2:Cell("C7_PRECO"):Show()
			oSection2:Cell("C7_QUANT"):Show()
			oSection2:Cell("C7_DATPRF"):Show()
  
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime somente os Pedidos caso na haja Remitos nem NFEs     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
 			If !lPrintline
				SF1->(MsSeek( xFilial("SF1")+cTamDoc+space(SerieNfId("SD1",6,"D1_SERIE"))))
				
				oSection2:Cell("REMDOC"):Hide()
				oSection2:Cell("REMITEM"):Hide()
				oSection2:Cell("REMQUANT"):Hide()
				oSection2:Cell("REMEMISSAO"):Hide() 
				oSection2:Cell("D1_DOC"):Hide()
				oSection2:Cell(SerieNfId("SD1",3,"D1_SERIE")):Hide()
				oSection2:Cell("D1_ITEM"):Hide()
				oSection2:Cell("D1_VUNIT"):Hide()
				oSection2:Cell("D1_QUANT"):Hide()
				oSection2:Cell("DIVPRECO"):Hide()
				oSection2:Cell("DIVDATE"):Hide()
 
				oSection2:PrintLine()

			EndIf
		(cQryRem)->(DBCloseArea())

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Relatorio baseado nos Remitos de compras                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		ElseIf mv_par01 == 2  

			oSection2:Cell("D1_EMISSAO"):Show()
			oSection2:Cell("D1_FORNECE"):Show()
			oSection2:Cell("D1_LOJA"):Show()
			oSection2:Cell("D1_COD"):Show()
			oSection2:Cell("D1_DOC"):Show()
			oSection2:Cell("D1_ITEM"):Show()
			oSection2:Cell("D1_QUANT"):Show()
			oSection2:Cell("DT_EMISSAO"):Show()
			oSection2:Cell("C7_NUM"):Show()
			oSection2:Cell("C7_ITEM"):Show()
			oSection2:Cell("C7_PRECO"):Show()
			oSection2:Cell("C7_QUANT"):Show()
			oSection2:Cell("C7_DATPRF"):Show()
			

			cFatuRem	:= (cAliasQry)->D1_DOC
			cSeriRem	:= (cAliasQry)->D1_SERIE
			cFornRem	:= (cAliasQry)->D1_FORNECE
			cLojaRem	:= (cAliasQry)->D1_LOJA
			cCodRem	:= (cAliasQry)->D1_COD
			cItemRem	:= (cAliasQry)->D1_ITEM
			nQuantRem	:= (cAliasQry)->D1_QUANT
			dtEmisRem  := (cAliasQry)->D1_EMISSAO

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se existe Pedido de compras vinculado e posiciona   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If !Empty((cAliasQry)->D1_PEDIDO)
				SC7->(dbSetOrder(1))
				lSC7 := SC7->(MsSeek( xFilial("SC7")+(cAliasQry)->D1_PEDIDO+(cAliasQry)->D1_ITEMPC))
			Else
				lSC7 := .F.
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Guarda a area para nao perder o filtro do SD1 ao reposicionar ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			aArea := GetArea()

			dbSelectArea("SD1")
			SD1->(dbSetOrder(10))
			If SD1->(MsSeek( xFilial("SD1")+cFornRem+cLojaRem+cSeriRem+cFatuRem+cItemRem))

				While !SD1->(Eof()) .And. cFatuRem == SD1->D1_REMITO .And. cSeriRem == SD1->D1_SERIREM .And.;
						cFornRem == SD1->D1_FORNECE .And. cLojaRem == SD1->D1_LOJA .And. cCodRem == SD1->D1_COD

					If cFatuRem == SD1->D1_REMITO .And. Alltrim(cItemRem) == SD1->D1_ITEMREM

						oSection2:Cell("NFDOC"):SetValue(SD1->D1_DOC)
						oSection2:Cell("NFITEM"):SetValue(SD1->D1_ITEM)
						oSection2:Cell("NFVUNIT"):SetValue(SD1->D1_VUNIT)
						oSection2:Cell("NFQUANT"):SetValue(SD1->D1_QUANT)

						oSection2:Cell("D1_EMISSAO"):SetValue(dtEmisRem)
						oSection2:Cell("D1_FORNECE"):SetValue(cFornRem)
						oSection2:Cell("D1_LOJA"):SetValue(cLojaRem)
						oSection2:Cell("D1_COD"):SetValue(cCodRem)
						oSection2:Cell("D1_DOC"):SetValue(cFatuRem)
						oSection2:Cell("D1_ITEM"):SetValue(cItemRem)
						oSection2:Cell("D1_QUANT"):SetValue(nQuantRem)

						If !lSC7 		
							oSection2:Cell("C7_NUM"):Hide()
							oSection2:Cell("C7_ITEM"):Hide()
							oSection2:Cell("C7_PRECO"):Hide()
							oSection2:Cell("C7_QUANT"):Hide()
							oSection2:Cell("C7_DATPRF"):Hide()			
						EndIf   
						
						oSection2:Cell("NFDOC"):SHOW()
						oSection2:Cell("NFITEM"):SHOW()
						oSection2:Cell("NFVUNIT"):SHOW()
						oSection2:Cell("NFQUANT"):SHOW() 
						oSection2:Cell("DIVPRECO"):SHOW()
						oSection2:Cell("DIVDATE"):SHOW()

						oSection2:PrintLine()

						oSection2:Cell("D1_EMISSAO"):Hide()
						oSection2:Cell("D1_FORNECE"):Hide()
						oSection2:Cell("D1_LOJA"):Hide()
						oSection2:Cell("D1_COD"):Hide()				
						oSection2:Cell("D1_DOC"):Hide()
						oSection2:Cell("D1_ITEM"):Hide()
						oSection2:Cell("D1_QUANT"):Hide()
						oSection2:Cell("D1_EMISSAO"):Hide()
						oSection2:Cell("C7_NUM"):Hide()
						oSection2:Cell("C7_ITEM"):Hide()
						oSection2:Cell("C7_PRECO"):Hide()
						oSection2:Cell("C7_QUANT"):Hide()
						oSection2:Cell("C7_DATPRF"):Hide()

					EndIf
					SD1->(dbSkip())
				Enddo
			Else
				RestArea(aArea)

				oSection2:Cell("D1_EMISSAO"):SetValue(dtEmisRem)
				oSection2:Cell("D1_FORNECE"):SetValue(cFornRem)
				oSection2:Cell("D1_LOJA"):SetValue(cLojaRem)
				oSection2:Cell("D1_COD"):SetValue(cCodRem)
				oSection2:Cell("D1_DOC"):SetValue(cFatuRem)
				oSection2:Cell("D1_ITEM"):SetValue(cItemRem)
				oSection2:Cell("D1_QUANT"):SetValue(nQuantRem)
				oSection2:Cell("DT_EMISSAO"):SetValue(dtEmisRem)				

				oSection2:Cell("NFDOC"):Hide()
				oSection2:Cell("NFITEM"):Hide()
				oSection2:Cell("NFVUNIT"):Hide()
				oSection2:Cell("NFQUANT"):Hide()
				oSection2:Cell("DIVPRECO"):Hide()
				oSection2:Cell("DIVDATE"):Hide()

				If !lSC7 		
					oSection2:Cell("C7_NUM"):Hide()
					oSection2:Cell("C7_ITEM"):Hide()
					oSection2:Cell("C7_PRECO"):Hide()
					oSection2:Cell("C7_QUANT"):Hide()
					oSection2:Cell("C7_DATPRF"):Hide()			
				EndIf

				oSection2:PrintLine()
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Restaura a ordem original apos a pesquisa no SD1              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			RestArea(aArea)

			dbSelectArea(cAliasQry)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Relatorio com base nas NFEs                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		ElseIf mv_par01 == 3  

			oSection2:Cell("REMDOC"):Show()
			oSection2:Cell("REMITEM"):Show()
			oSection2:Cell("REMQUANT"):Show()
			oSection2:Cell("REMEMISSAO"):Show()
			oSection2:Cell("C7_NUM"):Show()
			oSection2:Cell("C7_ITEM"):Show()
			oSection2:Cell("C7_PRECO"):Show()
			oSection2:Cell("C7_QUANT"):Show()
			oSection2:Cell("C7_DATPRF"):Show()
			oSection2:Cell("DIVPRECO"):Show()
			oSection2:Cell("DIVDATE"):Show()		

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se existe Pedido de compras vinculado e posiciona   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If !Empty((cAliasQry)->D1_PEDIDO)
				SC7->(dbSetOrder(1))
				lSC7 := SC7->(MsSeek( xFilial("SC7")+(cAliasQry)->D1_PEDIDO+(cAliasQry)->D1_ITEMPC))
			Else
				lSC7 := .F.
			EndIf

			cRemito 	:= (cAliasQry)->D1_REMITO
			cItemRem	:= (cAliasQry)->D1_ITEMREM
			cSeriRem   := (cAliasQry)->D1_SERIREM
			cFornRem	:= (cAliasQry)->D1_FORNECE
			cLojaRem	:= (cAliasQry)->D1_LOJA
			cCodRem	:= (cAliasQry)->D1_COD

			oSection2:Cell("D1_EMISSAO"):SetValue((cAliasQry)->D1_EMISSAO)
			oSection2:Cell("D1_FORNECE"):SetValue((cAliasQry)->D1_FORNECE)
			oSection2:Cell("D1_LOJA"):SetValue((cAliasQry)->D1_LOJA)
			oSection2:Cell("D1_COD"):SetValue((cAliasQry)->D1_COD)
			oSection2:Cell("D1_DOC"):SetValue((cAliasQry)->D1_DOC)
			oSection2:Cell(SerieNfId("SD1",3,"D1_SERIE")):SetValue((cAliasQry)->&(SerieNfId("SD1",3,"D1_SERIE")))
			oSection2:Cell("D1_ITEM"):SetValue((cAliasQry)->D1_ITEM)
			oSection2:Cell("D1_VUNIT"):SetValue((cAliasQry)->D1_VUNIT)
			oSection2:Cell("D1_QUANT"):SetValue((cAliasQry)->D1_QUANT)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Guarda a area para nao perder o filtro do SD1 ao reposicionar ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			aArea := GetArea()

			dbSelectArea("SD1")
			SD1->(dbSetOrder(1))
			If SD1->(MsSeek( xFilial("SD1")+cRemito+cSeriRem+cFornRem+cLojaRem+cCodRem+Alltrim(cItemRem)))
				oSection2:Cell("REMDOC"):SetValue(SD1->D1_DOC)
				oSection2:Cell("REMITEM"):SetValue(SD1->D1_ITEM)
				oSection2:Cell("REMQUANT"):SetValue(SD1->D1_QUANT)
				oSection2:Cell("REMEMISSAO"):SetValue(SD1->D1_EMISSAO)

				If !Empty(SD1->D1_PEDIDO) .And. !lSC7
					SC7->(dbSetOrder(1))
					lSC7 := SC7->(MsSeek( xFilial("SC7")+SD1->D1_PEDIDO+SD1->D1_ITEMPC))
				EndIf

			Else
				oSection2:Cell("REMDOC"):Hide()
				oSection2:Cell("REMITEM"):Hide()
				oSection2:Cell("REMQUANT"):Hide()
				oSection2:Cell("REMEMISSAO"):Hide()
			EndIf

			If !lSC7
				oSection2:Cell("C7_NUM"):Hide()
				oSection2:Cell("C7_ITEM"):Hide()
				oSection2:Cell("C7_PRECO"):Hide()
				oSection2:Cell("C7_QUANT"):Hide()
				oSection2:Cell("C7_DATPRF"):Hide()
				oSection2:Cell("DIVPRECO"):Hide()
				oSection2:Cell("DIVDATE"):Hide()		
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Restaura a ordem original apos a pesquisa no SD1              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			RestArea(aArea)
			oSection2:PrintLine()
			dbSelectArea(cAliasQry)
		EndIf

		nPrinted ++
		dbSelectArea(cAliasQry)
		dbskip()

	Enddo

	oReport:SkipLine()

	If nOrdem == 1      // Emissao
		oReport:PrintText(STR0023+" "+TransForm(nPrinted,"@R 999,999"),,oSection1:Cell(Iif( mv_par01 == 1 , "C7_EMISSAO" , "D1_EMISSAO" )):ColPos()) //"Total Fecha -> "
	ElseIf nOrdem == 2  // Fornecedor
		oReport:PrintText(STR0024+" "+TransForm(nPrinted,"@R 999,999"),,oSection1:Cell(Iif( mv_par01 == 1 , "C7_EMISSAO" , "D1_EMISSAO" )):ColPos()) //"Total Proveedor -> "
	ElseIf nOrdem == 3  // Producto
		oReport:PrintText(STR0025+" "+TransForm(nPrinted,"@R 999,999"),,oSection1:Cell(Iif( mv_par01 == 1 , "C7_EMISSAO" , "D1_EMISSAO" )):ColPos()) //"Total Producto -> "
	EndIf

	nTPrinted := nTPrinted + nPrinted
	nPrinted  := 0

	oSection1:Finish()
	oSection2:Finish()

Enddo

oReport:SkipLine() // "Total General -> "
oReport:PrintText(STR0044+" "+TransForm(nTPrinted,"@R 999,999"),,oSection1:Cell(Iif( mv_par01 == 1 , "C7_EMISSAO" , "D1_EMISSAO" )):ColPos()) //"Total Fecha -> "

Return Nil

