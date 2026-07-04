/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'MATR902.CH'
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MATR902  ³ Autor ³ Nereu Humberto Junior ³ Data ³01.08.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Kardex  Fisico FIFO/LIFO                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR902()
Local oReport

	oReport:= ReportDef()
	oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Nereu Humberto Junior  ³ Data ³01.08.2006³±±
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

Local lCusFIFO  := GetMV("MV_CUSFIFO",.F.)
Local Titulo    := OemToAnsi(IIf(lCusFIFO,STR0001,STR0032)) //'KARDEX FISICO FIFO/LIFO'
Local cPicD1Qt  := PesqPict("SD1","D1_QUANT")
Local cTamD1Qt  := TamSX3('D1_QUANT')[1]
Local cPicD1Cust:= PesqPict("SD1","D1_CUSTO")
Local cTamD1Cust:= TamSX3('D1_CUSTO')[1]
Local cPicD2Qt  := PesqPict("SD2","D2_QUANT")
Local cTamD2Qt  := TamSX3('D2_QUANT')[1]
Local cPicD2Cust:= PesqPict("SD2","D2_CUSTO1")
Local cTamD2Cust:= TamSX3('D2_CUSTO1')[1]
Local cTamD1Doc := TamSX3('D1_DOC')[1]
Local cTamD1CF  := TamSX3('D1_CF')[1]
Local cTamCCOP	:= TamSX3(MaiorCampo("D3_CC;D3_OP"))[1] + 2 //concatena 'CC' + CCusto ou 'OP' + OP
Local aOrdem    := {}
Local oSection1
Local oSection2
Local oSection3
Local oReport

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
oReport:= TReport():New("MATR902",Titulo,"MTR902", {|oReport| ReportPrint(oReport)},STR0002+" "+STR0003) //'KARDEX FISICO FIFO/LIFO'##"Este programa emitir  uma rela‡„o com as movimenta‡”es"##"dos produtos selecionados, ordenados sequencialmente."
oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mv_par01        	// Do produto                           ³
//³ mv_par02        	// Ate o produto                        ³
//³ mv_par03        	// Do tipo                              ³
//³ mv_par04        	// Ate o tipo                           ³
//³ mv_par05        	// Da data                              ³
//³ mv_par06        	// Ate a data                           ³
//³ mv_par07        	// Lista produtos s/movimento           ³
//³ mv_par08        	// Qual Local (almoxarifado)            ³
//³ mv_par09        	// (d)OCUMENTO/(s)EQUENCIA              ³
//³ mv_par10         // moeda selecionada ( 1 a 5 )          ³
//³ mv_par11         // Pagina Inicial                       ³
//³ mv_par12         // Agrupar por Lote ?                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR902",.F.)

Aadd( aOrdem, STR0004 ) // " Codigo Produto "
Aadd( aOrdem, STR0005 ) // " Tipo do Produto"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Secao 1 - Dados do Produto                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport,STR0063,{"SB1"},aOrdem) //"Produtos (Parte 1)"
oSection1:SetTotalInLine(.F.)
oSection1:SetReadOnly()
oSection1:SetLineStyle()

TRCell():New(oSection1, "B1_COD"  , "SB1", /*Titulo*/                   , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection1, "B1_DESC" , "SB1", /*Titulo*/                   , /*Picture*/, 30         , /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection1, "B1_UM"   , "SB1", STR0057                      , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection1, "B1_TIPO" , "SB1", STR0058                      , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection1, "B1_GRUPO", "SB1", STR0059                      , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection1, "nCusMed" , " "  , IIf(lCusFifo,STR0060,STR0056), cPicD1Cust , cTamD1Cust , /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection1, "nQtdSal" , " "  , STR0055                      , cPicD1Qt   , cTamD1Qt   , /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection1, "nVlrSal" , " "  , STR0056                      , cPicD1Cust , cTamD1Cust , /*lPixel*/, /*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Secao 2 - Cont. dos dados do Produto            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,STR0064,{"SB1","SB2","NNR"}) //"Produtos (Parte 2)"
oSection2:SetTotalInLine(.F.)
oSection2:SetReadOnly()
oSection2:SetLineStyle()

TRCell():New(oSection2, "B1_POSIPI" , "SB1", STR0061, /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection2, "NNR_DESCRI", "NNR", STR0062, /*Picture*/, /*Tamanho*/, /*lPixel*/, {|| Posicione("NNR",1,xFilial("NNR")+mv_par08,"NNR_DESCRI")})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Secao 3 - Movimentos                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3 := TRSection():New(oSection2,STR0065,{"SD1","SD2","SD3"}) //"Movimentação dos Produtos"
oSection3:SetHeaderPage()
oSection3:SetTotalInLine(.F.)
oSection3:SetTotalText(STR0024) //"T O T A I S  :"
oSection3:SetReadOnly()

TRCell():New(oSection3, "dDtMov"   , " ", STR0039+CRLF+STR0040                      , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
oSection3:Cell("dDtMov"):GetFieldInfo("D3_EMISSAO") // Para definição correta do tamanho e picure do campo
TRCell():New(oSection3, "cTES"     , " ", STR0041                                   , "@!"       , /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection3, "cCF"      , " ", STR0042                                   , "@!"       , cTamD1CF   , /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection3, "cDoc"     , " ", STR0010+CRLF+STR0043                      , "@!"       , cTamD1Doc  , /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection3, "cTraco1"  , " ", "|"+CRLF+"|"                              , /*Picture*/, 1          , /*lPixel*/, {|| "|" })
TRCell():New(oSection3, "nENTQtd"  , " ", STR0044+CRLF+STR0045                      , cPicD1Qt   , cTamD1Qt   , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection3, "nENTCus"  , " ", STR0044+CRLF+STR0046                      , cPicD1Cust , cTamD1Cust , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection3, "cTraco2"  , " ", "|"+CRLF+"|"                              , /*Picture*/, 1          , /*lPixel*/, {|| "|" })
TRCell():New(oSection3, "nCusMov"  , " ", IIf(lCusFIFO,STR0047,STR0056)+CRLF+STR0048, cPicD1Cust , cTamD1Cust , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection3, "cTraco3"  , " ", "|"+CRLF+"|"                              , /*Picture*/, 1          , /*lPixel*/, {|| "|" })
TRCell():New(oSection3, "nSAIQtd"  , " ", STR0049+CRLF+STR0045                      , cPicD2Qt   , cTamD2Qt   , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection3, "nSAICus"  , " ", STR0049+CRLF+STR0046                      , cPicD2Cust , cTamD2Cust , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection3, "cTraco4"  , " ", "|"+CRLF+"|"                              , /*Picture*/, 1          , /*lPixel*/, {|| "|" })
TRCell():New(oSection3, "nSALDQtd" , " ", STR0050+CRLF+STR0045                      , cPicD1Qt   , cTamD1Qt   , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection3, "nSALDCus" , " ", STR0050+CRLF+STR0051                      , cPicD1Cust , cTamD1Cust , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection3, "cTraco5"  , " ", "|"+CRLF+"|"                              , /*Picture*/, 1          , /*lPixel*/, {|| "|" })
TRCell():New(oSection3, "cCCPVPJOP", " ", STR0052+CRLF+STR0053                      , "@!"       , cTamCCOP   , /*lPixel*/, /*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Secao 4 - SubTotal                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection4 := TRSection():New(oSection2,STR0028,{"SD1","SD2","SD3"}) //"SubTotal
oSection4:SetHeaderPage()
oSection4:SetTotalInLine(.F.)
oSection4:SetTotalText(STR0024) //"T O T A I S  :"
oSection4:SetReadOnly()

TRCell():New(oSection4, "dDtMov"   , " ", STR0039+CRLF+STR0040                      , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
oSection4:Cell("dDtMov"):GetFieldInfo("D3_EMISSAO") // Para definição correta do tamanho e picure do campo
TRCell():New(oSection4, "cTES"     , " ", STR0041                                   , "@!"       , 5          , /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection4, "cCF"      , " ", STR0042                                   , "@!"       , 3          , /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection4, "cDoc"     , " ", STR0010+CRLF+STR0043                      , "@!"       , cTamD1Doc  , /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection4, "cTraco1"  , " ", "|"+CRLF+"|"                              , /*Picture*/, 1          , /*lPixel*/, {|| "|" })
TRCell():New(oSection4, "nENTQtd"  , " ", STR0044+CRLF+STR0045                      , cPicD1Qt   , cTamD1Qt   , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection4, "nENTCus"  , " ", STR0044+CRLF+STR0046                      , cPicD1Cust , cTamD1Cust , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection4, "cTraco2"  , " ", "|"+CRLF+"|"                              , /*Picture*/, 1          , /*lPixel*/, {|| "|" })
TRCell():New(oSection4, "nCusMov"  , " ", IIf(lCusFIFO,STR0047,STR0056)+CRLF+STR0048, cPicD1Cust , cTamD1Cust , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection4, "cTraco3"  , " ", "|"+CRLF+"|"                              , /*Picture*/, 1          , /*lPixel*/, {|| "|" })
TRCell():New(oSection4, "nSAIQtd"  , " ", STR0049+CRLF+STR0045                      , cPicD2Qt   , cTamD2Qt   , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection4, "nSAICus"  , " ", STR0049+CRLF+STR0046                      , cPicD2Cust , cTamD2Cust , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection4, "cTraco4"  , " ", "|"+CRLF+"|"                              , /*Picture*/, 1          , /*lPixel*/, {|| "|" })
TRCell():New(oSection4, "nSALDQtd" , " ", STR0050+CRLF+STR0045                      , cPicD1Qt   , cTamD1Qt   , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection4, "nSALDCus" , " ", STR0050+CRLF+STR0051                      , cPicD1Cust , cTamD1Cust , /*lPixel*/, /*{|| code-block de impressao }*/, , , "RIGHT")
TRCell():New(oSection4, "cTraco5"  , " ", "|"+CRLF+"|"                              , /*Picture*/, 1          , /*lPixel*/, {|| "|" })
TRCell():New(oSection4, "cCCPVPJOP", " ", STR0052+CRLF+STR0053                      , "@!"       , cTamCCOP   , /*lPixel*/, /*{|| code-block de impressao }*/)

oSection4:Cell("cDoc"     ):Hide()
oSection4:Cell("cTES"     ):Hide()
oSection4:Cell("cCF"      ):Hide()
oSection4:Cell("cTraco1"  ):Hide()
oSection4:Cell("cTraco2"  ):Hide()
oSection4:Cell("nCusMov"  ):Hide()
oSection4:Cell("cTraco3"  ):Hide()
oSection4:Cell("cTraco4"  ):Hide()
oSection4:Cell("cTraco5"  ):Hide()
oSection4:Cell("cCCPVPJOP"):Hide()

oSection4:Cell("dDtMov"   ):HideHeader()
oSection4:Cell("cTES"     ):HideHeader()
oSection4:Cell("cCF"      ):HideHeader()
oSection4:Cell("cDoc"     ):HideHeader()
oSection4:Cell("cTraco1"  ):HideHeader()
oSection4:Cell("nENTQtd"  ):HideHeader()
oSection4:Cell("nENTCus"  ):HideHeader()
oSection4:Cell("cTraco2"  ):HideHeader()
oSection4:Cell("nCusMov"  ):HideHeader()
oSection4:Cell("cTraco3"  ):HideHeader()
oSection4:Cell("nSAIQtd"  ):HideHeader()
oSection4:Cell("nSAICus"  ):HideHeader()
oSection4:Cell("cTraco4"  ):HideHeader()
oSection4:Cell("nSALDQtd" ):HideHeader()
oSection4:Cell("nSALDCus" ):HideHeader()
oSection4:Cell("cTraco5"  ):HideHeader()
oSection4:Cell("cCCPVPJOP"):HideHeader()

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³01.08.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
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

Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(1):Section(1)
Local oSection4 := oReport:Section(1):Section(1):Section(2)
Local nOrdem    := oReport:Section(1):GetOrder()
Local cMoeda    := GetMV("MV_SIMB"+Str(mv_par10,1))
Local cAlias    := ""
Local cSeqIni   := "ZZZZZZ"
Local cProdAnt  := ""
Local cLocalAnt := ""
Local cCampo1   := ""
Local cCampo2   := ""
Local cCampo3   := ""
Local cCampo4   := ""
Local lFirst    := .T.
Local aSalAtu   := {}
Local aSalAtuLot:= {}
Local nEntrada  := 0
Local nSEntrada := 0
Local nSaida    := 0
Local nSSaida	:= 0
Local nCEntrada := 0
Local nSCEntrada:= 0
Local nCSaida   := 0
Local nSCSaida	:= 0
Local nCusFif   := 0
Local nCusFifLot:= 0
Local nInd      := 0
Local cPicD1Qt  := PesqPict("SD1","D1_QUANT")
Local cPicD2Qt  := PesqPict("SD2","D2_QUANT")
Local cPicB2Qt2 := PesqPict("SB2","B2_QTSEGUM")
Local cPicD1Cust:= PesqPict("SD1","D1_CUSTO")
Local cPicD2Cust:= PesqPict("SD2","D2_CUSTO1")
Local cTRBSD1   := CriaTrab(,.F.)
Local cTRBSD2   := CriaTrab(,.F.)
Local cTRBSD3   := CriaTrab(,.F.)
Local cTRBSD8   := Subs(cTrbSD3,1,7)+"A"
Local cLoteAnt  := ""
Local lImpSMov  := .F.
Local lImpS3    := .F.
Local lCusFIFO  := GetMV("MV_CUSFIFO",.F.)
Local cAliasTop := ""

If mv_par12 == 1
	TRFunction():New(oSection4:Cell("nENTQtd" ),NIL,"SUM",/*oBreak*/,"",cPicD1Qt	,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection4:Cell("nENTCus" ),NIL,"SUM",/*oBreak*/,"",cPicD1Cust	,/*uFormula*/,.F.,.T.)

	TRFunction():New(oSection4:Cell("nSAIQtd" ),NIL,"SUM",/*oBreak*/,"",cPicD2Qt	,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection4:Cell("nSAICus" ),NIL,"SUM",/*oBreak*/,"",cPicD2Cust	,/*uFormula*/,.F.,.T.)

	TRFunction():New(oSection4:Cell("nSALDQtd" ),NIL,"SUM",/*oBreak*/,"",cPicD2Qt	,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection4:Cell("nSALDCus" ),NIL,"SUM",/*oBreak*/,"",cPicD2Cust,/*uFormula*/,.F.,.T.)
Else
  	TRFunction():New(oSection3:Cell("nENTQtd" ),NIL,"SUM",/*oBreak*/,"",cPicD1Qt	,/*uFormula*/,.T.,.F.)
 	TRFunction():New(oSection3:Cell("nENTCus" ),NIL,"SUM",/*oBreak*/,"",cPicD1Cust	,/*uFormula*/,.T.,.F.)

	TRFunction():New(oSection3:Cell("nSAIQtd" ),NIL,"SUM",/*oBreak*/,"",cPicD2Qt	,/*uFormula*/,.T.,.F.)
	TRFunction():New(oSection3:Cell("nSAICus" ),NIL,"SUM",/*oBreak*/,"",cPicD2Cust	,/*uFormula*/,.T.,.F.)

	TRFunction():New(oSection3:Cell("nSALDQtd"),NIL,"ONPRINT",/*oBreak*/,"",cPicD1Qt	,{|| oSection3:Cell("nSALDQtd"):GetValue(.T.) },.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection3:Cell("nSALDCus"),NIL,"ONPRINT",/*oBreak*/,"",cPicD1Cust	,{|| oSection3:Cell("nSALDCus"):GetValue(.T.) },.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
EndIf

oReport:SetTitle(OemToAnsi(IIf(lCusFIFO,STR0008,STR0033))+mv_par08) // "Kardex Fisico-Financeiro FIFO/LIFO (Calculo) L O C A L : "
If nOrdem == 1
	oReport:SetTitle(oReport:Title()+OemToAnsi(STR0014)+STR0004+OemToAnsi(STR0015)+cMoeda+Str(mv_par10,1)+")")
Else
	oReport:SetTitle(oReport:Title()+OemToAnsi(STR0014)+STR0005+OemToAnsi(STR0015)+cMoeda+Str(mv_par10,1)+")")
Endif

If mv_par09 $ "Ss"
	oSection3:Cell("cDoc"):SetTitle(STR0011+CRLF+STR0043)
Else
	oSection3:Cell("cDoc"):SetTitle(STR0010+CRLF+STR0043)
EndIf

dbSelectArea("SB2")
dbSetOrder(1)

dbSelectArea("SD1")
IndRegua("SD1",cTrbSD1,"D1_FILIAL+D1_COD+D1_LOCAL+D1_DOC+D1_SERIE+D1_ITEM",,,OemToAnsi(STR0016) )  //"Selecionando Registros"
nInd := RetIndex("SD1")
dbSetOrder(nInd+1)

dbSelectArea("SD2")
IndRegua("SD2",cTrbSD2,"D2_FILIAL+D2_COD+D2_LOCAL+D2_DOC+D2_SERIE+D2_ITEM",,,OemToAnsi(STR0016) )  //"Selecionando Registros"
nInd := RetIndex("SD2")
dbSetOrder(nInd+1)

dbSelectArea("SD3")
IndRegua("SD3",cTrbSD3,"D3_FILIAL+D3_COD+D3_LOCAL+D3_SEQCALC+D3_NUMSEQ",,,OemToAnsi(STR0016) )  //"Selecionando Registros"
nInd := RetIndex("SD3")
dbSetOrder(nInd+1)

dbSelectArea("SD8")
if mv_par12 == 1
	cFiltro := "D8_FILIAL+D8_PRODUTO+D8_LOCAL+"+IIF(mv_par09 $ "Ss","D8_SEQ+D8_SEQCALC",IIF(mv_par09 $ "Dd","D8_SEQ+D8_DOC","D8_SEQ+D8_DATA+D8_DOC"))
Else
	cFiltro := "D8_FILIAL+D8_PRODUTO+D8_LOCAL+"+IIF(mv_par09 $ "Ss","D8_SEQCALC+D8_SEQ",IIF(mv_par09 $ "Dd","D8_DOC","D8_DATA+D8_DOC"))
EndIf
IndRegua("SD8",cTrbSD8,cFiltro,,,OemToAnsi(STR0016) )  //"Selecionando Registros"
nInd := RetIndex("SD8")
dbSetOrder(nInd+1)

dbSelectArea("SB1")
If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

cAliasTop := GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()

BeginSql Alias cAliasTop

	SELECT B1_COD, B1_DESC, B1_UM, B1_TIPO, B1_GRUPO, B1_POSIPI

	FROM %table:SB1% SB1

	WHERE SB1.B1_FILIAL  =  %xFilial:SB1%	AND
          	SB1.B1_COD     >= %Exp:mv_par01% 	AND
            SB1.B1_COD     <= %Exp:mv_par02% AND
            SB1.B1_TIPO    >= %Exp:mv_par03% 	AND
            SB1.B1_TIPO    <= %Exp:mv_par04% AND
		    SB1.%NotDel%

	ORDER BY %Order:SB1%

EndSql
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatorio para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(SB1->(LastRec()))
While !oReport:Cancel() .And. !(cAliasTop)->(Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se houve interrupcao pelo operador                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If oReport:Cancel()
		Exit
	EndIf

	oReport:IncMeter()

	// Filtra Mao de Obra
	If IsProdMod((cAliasTop)->B1_COD)
		dbSkip()
		Loop
	Endif

	dbSelectArea("SB2")
	dbSeek(xFilial("SB2")+(cAliasTop)->B1_COD+mv_par08)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se nao encontrar no arquivo de dados, nao lista              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Eof()
		dbSelectArea(cAliasTop)
		dbSkip()
		Loop
	EndIf

	cProdAnt  := (cAliasTop)->B1_COD
	cLocalAnt := SB2->B2_LOCAL

	dbSelectArea("SD3")
	dbSeek(xFilial("SD3")+(cAliasTop)->B1_COD+SB2->B2_LOCAL)

	dbSelectArea("SD8")
	dbSeek(xFilial("SD8")+(cAliasTop)->B1_COD+SB2->B2_LOCAL)

	While .T.
		lImpSMov  := .F.
		lImpS3    := .F.
		dbSelectArea("SD3")
		If !Eof() .And. D3_FILIAL == xFilial("SD3") .And. D3_COD == cProdAnt .And. D3_LOCAL == cLocalAnt .And. IsProdMod(D3_COD)
			If D3_EMISSAO < mv_par05 .Or. D3_EMISSAO > mv_par06
				dbSkip()
				Loop
			Else
				If mv_par11 == 1
					If D3_NUMSEQ < cSeqIni
						cSeqIni := D3_NUMSEQ
						cAlias  := Alias()
					EndIf
				Else
					If D3_SEQCALC+D3_NUMSEQ < cSeqIni
						cSeqIni := D3_SEQCALC+D3_NUMSEQ
						cAlias  := Alias()
					EndIf
				EndIf
			EndIf
		EndIf

		dbSelectArea("SD8")
		If !Eof() .And. D8_FILIAL == xFilial("SD8") .And. D8_PRODUTO == cProdAnt .And. D8_LOCAL == cLocalAnt .And. Empty(cAlias)
			If !Empty(D8_DATA) .And. (D8_DATA < mv_par05 .Or. D8_DATA > mv_par06)
				dbSkip()
				Loop
			Else
				If mv_par11 == 1
					If D8_SEQ < cSeqIni
						cSeqIni := D8_SEQ
						cAlias  := Alias()
					EndIf
				Else
					If D8_SEQCALC+D8_SEQ < cSeqIni
						cSeqIni := D8_SEQCALC+D8_SEQ
						cAlias  := Alias()
					EndIf
				EndIf
			EndIf
		EndIf

		If !Empty(cAlias)

			dbSelectArea(cAlias)

			If mv_par12 == 1
				cDocumento := &(IIf(cAlias=="SD3",Subs(cAlias,2,2)+"_NUMSEQ",Subs(cAlias,2,2)+"_SEQ"))
			Endif
         cCampo1 := Subs(cAlias,2,2)+IIF(cAlias=="SD8","_DATA","_EMISSAO")
			cCampo2 := Subs(cAlias,2,2)+"_TM"
			//-- Movimento Interno
			If cAlias=="SD3"
				cCampo3 := Subs(cAlias,2,2)+"_CF"
			ElseIf cAlias=="SD8"
				//-- Movimento Interno
				If Empty((cAlias)->D8_ITEM)
					cCampo3 := Subs(cAlias,2,2)+"_CF"
				Else
					//-- Documento de Entrada
					If (cAlias)->D8_TM <= '500'
						SD1->(dbSeek(xFilial("SD1")+(cAlias)->D8_PRODUTO+(cAlias)->D8_LOCAL+(cAlias)->D8_DOC+(cAlias)->D8_SERIE+(cAlias)->D8_ITEM))
						cCampo3 := "SD1->D1_CF"
					//-- Documento de Saida
					Else
            		SD2->(dbSeek(xFilial("SD2")+(cAlias)->D8_PRODUTO+(cAlias)->D8_LOCAL+(cAlias)->D8_DOC+(cAlias)->D8_SERIE+(cAlias)->D8_ITEM))
						cCampo3 := "SD2->D2_CF"
					EndIf
					dbSelectArea(cAlias)
				EndIf
			EndIf

			If cAlias == "SD3"
				cCampo4 := Subs(cAlias,2,2)+IIf(mv_par09 $ "Ss","_NUMSEQ","_DOC" )
			Else
				cCampo4 := Subs(cAlias,2,2)+IIf(mv_par09 $ "Ss","_SEQ","_DOC" )
			EndIf

			If lFirst
				nEntrada   := 0
				nSEntrada  := 0
				nSaida     := 0
				nSSaida    := 0
				nCEntrada  := 0
				nSCEntrada := 0
				nCSaida    := 0
				nSCSaida   := 0
				nCusFif    := 0

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Calcula o Saldo Inicial do Produto                           ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

				aSalAtu := CalcEstFF((cAliasTop)->B1_COD,mv_par08,mv_par05)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Calcula o Custo Fifo/Lifo do Produto                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If aSalAtu[1] > 0
					nCusFif := aSalAtu[mv_par10+1]/aSalAtu[1]
				ElseIf aSalAtu[1] == 0 .And. aSalAtu[mv_par10+1] == 0
					nCusFif := 0
				Else
					If mv_par10 == 1
						nCusFif := SB2->B2_CM1
					ElseIf mv_par10 == 2
						nCusFif := SB2->B2_CM2
					ElseIf mv_par10 == 3
						nCusFif := SB2->B2_CM3
					ElseIf mv_par10 == 4
						nCusFif := SB2->B2_CM4
					ElseIf mv_par10 == 5
						nCusFif := SB2->B2_CM5
					EndIf
				EndIf

				oSection1:Init()
				oSection2:Init()

				oSection1:Cell("nCusMed"):SetValue(nCusFif)
				oSection1:Cell("nQtdSal"):SetValue(aSalAtu[1])
				oSection1:Cell("nVlrSal"):SetValue(aSalAtu[mv_par10+1])

				oSection1:PrintLine()
				oSection2:PrintLine()

				lFirst  := .F.
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Cabecalho Saldo Incial por Lote FIFO/LIFO                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par12 == 1

				//Verifica se houve quebra de Lote
				If cLoteAnt != cDocumento

					//Calcula o Saldo Inicial do Lote
					aSalAtuLot := CalcEstFF((cAliasTop)->B1_COD,mv_par08,mv_par05,,,cDocumento)

					//Calcula o Custo Fifo/Lifo do Lote
					If aSalAtuLot[1] > 0
						nCusFifLot := aSalAtuLot[mv_par10+1]/aSalAtuLot[1]
					ElseIf aSalAtuLot[1] == 0 .and. aSalAtuLot[mv_par10+1] == 0
						nCusFifLot := 0
					Else
						nCusFifLot := &(("SB2->B2_CM") + Str(mv_par10,1))
					EndIf

               nLin := oReport:Row()
					oReport:PrintText(OemToAnsi(IIf(lCusFIFO,STR0029,STR0037))+cDocumento) // "Lote Fifo/Lifo:"
					oReport:SkipLine()
					oReport:PrintText(OemToAnsi(IIf(lCusFIFO,STR0030,STR0038))+TransForm(nCusFifLot,cPicD1Cust)+"        "+TransForm(aSalAtuLot[1],cPicD1Cust)+"        "+TransForm(aSalAtuLot[mv_par10+1],cPicD1Cust),nLin,oSection3:Cell('nENTCus'):ColPos()) // "Custo Fifo/Lifo Inicial :"
					oReport:SkipLine()
				EndIf
				cLoteAnt := cDocumento
			Endif

			If	IF(cAlias == "SD3",!Empty(D3_EMISSAO),!Empty(D8_DATA))
				oSection3:Init()
				oSection3:Cell("dDtMov"):SetValue(&cCampo1)
				oSection3:Cell("cTES"  ):SetValue(&cCampo2)
				oSection3:Cell("cCF"   ):SetValue(&cCampo3)
				oSection3:Cell("cDoc"  ):SetValue(&cCampo4)

				If cAlias == "SD3"
					If D3_TM <= "500"

						oSection3:Cell("nENTQtd"):Show()
						oSection3:Cell("nENTCus"):Show()
						oSection3:Cell("nCusMov"):Show()

						oSection3:Cell("nENTQtd"):SetValue(D3_QUANT)
						oSection3:Cell("nENTCus"):SetValue(&(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1))))
						oSection3:Cell("nCusMov"):SetValue(&(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1))))

						oSection3:Cell("nSAIQtd"):Hide()
						oSection3:Cell("nSAICus"):Hide()
						oSection3:Cell("nSAIQtd"):SetValue(0)
						oSection3:Cell("nSAICus"):SetValue(0)

						nEntrada            := nEntrada + D3_QUANT
						nSEntrada           := nSEntrada + D3_QUANT
						aSalAtu[1]          := aSalAtu[1] + D3_QUANT
						nCEntrada           := nCEntrada + &(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						nSCEntrada          := nSCEntrada + &(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						aSalAtu[mv_par10+1] := aSalAtu[mv_par10+1] + &(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						aSalAtu[7]          := aSalAtu[7] + D3_QTSEGUM
						//Saldos por Lote Fifo/Lifo
                  If mv_par12 == 1
							aSalAtuLot[1]          := aSalAtuLot[1] + D3_QUANT
							aSalAtuLot[mv_par10+1] := aSalAtuLot[mv_par10+1] + &(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
							aSalAtuLot[7]          := aSalAtuLot[7] + D3_QTSEGUM
						Endif
					Else
						oSection3:Cell("nENTQtd"):Hide()
						oSection3:Cell("nENTCus"):Hide()
						oSection3:Cell("nENTQtd"):SetValue(0)
						oSection3:Cell("nENTCus"):SetValue(0)

						oSection3:Cell("nCusMov"):Show()
						oSection3:Cell("nSAIQtd"):Show()
						oSection3:Cell("nSAICus"):Show()

						oSection3:Cell("nCusMov"):SetValue((&(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1))) / D3_QUANT))
						oSection3:Cell("nSAIQtd"):SetValue(D3_QUANT)
						oSection3:Cell("nSAICus"):SetValue(&(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1))))

						nSaida              := nSaida + D3_QUANT
						nSSaida             := nSSaida + D3_QUANT
						aSalAtu[1]          := aSalAtu[1] - D3_QUANT
						nCSaida             := nCSaida + &(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						nSCSaida            := nSCSaida + &(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						aSalAtu[mv_par10+1] := aSalAtu[mv_par10+1] - &(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						aSalAtu[7]          := aSalAtu[7] - D3_QTSEGUM
						//Saldos por Lote Fifo/Lifo
						If mv_par12 == 1
							aSalAtuLot[1]          := aSalAtuLot[1] - D3_QUANT
							aSalAtuLot[mv_par10+1] := aSalAtuLot[mv_par10+1] - &(("D3_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
							aSalAtuLot[7]          := aSalAtuLot[7] - D3_QTSEGUM
						EndIf
					EndIf
				Else
					If D8_TM <= "500"

						oSection3:Cell("nENTQtd"):Show()
						oSection3:Cell("nENTCus"):Show()
						oSection3:Cell("nCusMov"):Show()

						oSection3:Cell("nENTQtd"):SetValue(D8_QUANT)
						oSection3:Cell("nENTCus"):SetValue(&(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1))))
						oSection3:Cell("nCusMov"):SetValue((&(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1))) / D8_QUANT))

						oSection3:Cell("nSAIQtd"):Hide()
						oSection3:Cell("nSAICus"):Hide()
						oSection3:Cell("nSAIQtd"):SetValue(0)
						oSection3:Cell("nSAICus"):SetValue(0)

						nEntrada            := nEntrada + D8_QUANT
						nSEntrada           := nSEntrada + D8_QUANT
						aSalAtu[1]          := aSalAtu[1] + D8_QUANT
						nCEntrada           := nCEntrada + &(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						nSCEntrada          := nSCEntrada + &(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						aSalAtu[mv_par10+1] := aSalAtu[mv_par10+1] + &(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						aSalAtu[7]          := aSalAtu[7] + 0
						//Saldos por Lote Fifo/Lifo
						If mv_par12 == 1
							aSalAtuLot[1]          := aSalAtuLot[1] + D8_QUANT
							aSalAtuLot[mv_par10+1] := aSalAtuLot[mv_par10+1] + &(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
							aSalAtuLot[7]          := aSalAtuLot[7] + 0
						Endif
					Else
						oSection3:Cell("nENTQtd"):Hide()
						oSection3:Cell("nENTCus"):Hide()
						oSection3:Cell("nENTQtd"):SetValue(0)
						oSection3:Cell("nENTCus"):SetValue(0)

						oSection3:Cell("nCusMov"):Show()
						oSection3:Cell("nSAIQtd"):Show()
						oSection3:Cell("nSAICus"):Show()

						oSection3:Cell("nCusMov"):SetValue((&(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1))) / D8_QUANT))
						oSection3:Cell("nSAIQtd"):SetValue(D8_QUANT)
						oSection3:Cell("nSAICus"):SetValue(&(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1))))

						nSaida                 := nSaida + D8_QUANT
						nSSaida                := nSSaida + D8_QUANT
						aSalAtu[1]             := aSalAtu[1] - D8_QUANT
						nCSaida                := nCSaida + &(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						nSCSaida               := nSCSaida + &(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						aSalAtu[mv_par10+1]    := aSalAtu[mv_par10+1] - &(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
						aSalAtu[7]             := aSalAtu[7] - 0
						//Saldos por Lote Fifo/Lifo
						If mv_par12 == 1
							aSalAtuLot[1]          := aSalAtuLot[1] - D8_QUANT
							aSalAtuLot[mv_par10+1] := aSalAtuLot[mv_par10+1] - &(("D8_CUSTO") +If(mv_par10==1,"1",Str(mv_par10,1)))
							aSalAtuLot[7]          := aSalAtuLot[7] - 0
						Endif
					Endif
				Endif

				Do Case
					Case cAlias == "SD3"  && movimentos (SD3)
						If Empty(D3_OP)
							oSection3:Cell("cCCPVPJOP"):SetValue('CC'+D3_CC)
						Else
							oSection3:Cell("cCCPVPJOP"):SetValue('OP'+SUBS(D3_OP,1,6))
						EndIf
					Case cAlias == "SD8"  && movimentos (SD8)
						If Empty(D8_OP)
							oSection3:Cell("cCCPVPJOP"):SetValue('CC'+posicione('SD3',4,fwcodfil('SD3')+D8_NUMSEQ,'D3_CC'))
						Else
							oSection3:Cell("cCCPVPJOP"):SetValue('OP'+SUBS(D8_OP,1,6))
						EndIf
				EndCase
			   If mv_par12 == 1
					oSection3:Cell("nSALDQtd"):SetValue(aSalAtuLot[1])
					oSection3:Cell("nSALDCus"):SetValue(aSalAtuLot[mv_par10+1])

				Else
					oSection3:Cell("nSALDQtd"):SetValue(aSalAtu[1])
					oSection3:Cell("nSALDCus"):SetValue(aSalAtu[mv_par10+1])

				EndIf
				oSection3:PrintLine()
			Endif

			dbSkip()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ SubTotal por Lote/Documento                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par12 == 1

				If cLoteAnt != &(IIf(cAlias=="SD3",Subs(cAlias,2,2)+"_NUMSEQ",Subs(cAlias,2,2)+"_SEQ"))

				    //Aviso de Lote sem movimentacao
				    If nSEntrada == 0 .And. nSSaida == 0 .And. nSCEntrada == 0 .And. nSCSaida == 0
						oReport:PrintText(STR0031) // "NAO HOUVE MOVIMENTACAO PARA ESTE LOTE"
				    Endif

					oReport:SkipLine()

					oSection4:Init()

					oSection4:Cell("dDtMov"  ):SetValue(STR0028)
					oSection4:Cell("nENTQtd" ):SetValue(nSEntrada)
					oSection4:Cell("nENTCus" ):SetValue(nSCEntrada)
					oSection4:Cell("nSAIQtd" ):SetValue(nSSaida)
					oSection4:Cell("nSAICus" ):SetValue(nSCSaida)
					oSection4:Cell("nSALDQtd"):SetValue(aSalAtuLot[1])
					oSection4:Cell("nSALDCus"):SetValue(aSalAtuLot[mv_par10+1])

					oSection4:PrintLine()
					oSection4:Finish()

					oReport:SkipLine()

					nSEntrada	:= 0
					nSCEntrada	:= 0
					nSSaida	:= 0
					nSCSaida	:= 0

				EndIf
			EndIf
			cSeqIni := "ZZZZZZ"
			cAlias  := ""

		Else
			If !lFirst
				oReport:PrintText(STR0025+TransForm(aSalAtu[7],cPicB2Qt2),,oSection3:Cell('nSAICus'):ColPos()) //"QTD. NA SEGUNDA UM: "
				oReport:ThinLine()
				lFirst := .T.
				lImpS3 := .T.

			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se deve ou nao listar os produtos s/movimento       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par07 == 1

					nCusFif := 0

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Calcula o Saldo Inicial do Produto                            ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

					aSalAtu := CalcEstFF((cAliasTop)->B1_COD,mv_par08,mv_par05)

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Calcula o Custo Fifo/Lifo do Produto                               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If AsalAtu[1] > 0
						nCusFif := aSalAtu[mv_par10+1]/aSalAtu[1]
					ElseIf AsalAtu[1] == 0 .and. AsalAtu[mv_par10+1] == 0
						nCusFif := 0
					Else
						nCusFif := &(("SB2->B2_CM") + Str(mv_par10,1))
					EndIf

					oSection1:Init()
					oSection2:Init()

					oSection1:Cell("nCusMed"):SetValue(nCusFif)
					oSection1:Cell("nQtdSal"):SetValue(aSalAtu[1])
					oSection1:Cell("nVlrSal"):SetValue(aSalAtu[mv_par10+1])

					oSection1:PrintLine()
					oSection2:PrintLine()

					oReport:PrintText(STR0026) // "NAO HOUVE MOVIMENTACAO PARA ESTE PRODUTO"
					oReport:ThinLine()
					lFirst  := .T.
					lImpSMov := .T.
				EndIf
			EndIf
			Exit
		EndIf

	EndDo
	If !lImpSMov .And. lImpS3
		oSection3:Finish()
	EndIf
	oSection1:Finish()
	oSection2:Finish()

	lFirst  := .T.
	dbSelectArea(cAliasTop)
	dbSkip()
EndDo


dbSelectArea("SB1")
dbSetOrder(1)

dbSelectArea("SB2")
dbSetOrder(1)

dbSelectArea("SD1")
RetIndex("SD1")
Ferase(cTrbSD1+OrdBagExt())
dbSetOrder(1)

dbSelectArea("SD2")
RetIndex("SD2")
Ferase(cTrbSD2+OrdBagExt())
dbSetOrder(1)

dbSelectArea("SD3")
RetIndex("SD3")
Ferase(cTrbSD3+OrdBagExt())
dbSetOrder(1)

dbSelectArea("SD8")
RetIndex("SD8")
Ferase(cTrbSD8+OrdBagExt())
dbSetOrder(1)

Return
