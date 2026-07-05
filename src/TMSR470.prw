/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR470.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR470  ³ Autor ³ Eduardo de Souza      ³ Data ³ 31/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o Analise do Contas a Receber (Aging)	           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR470()

Local oReport
Local aArea    := GetArea()
Local aAreaSix := SIX->( GetArea() )

Private oTemp  := Nil

If SIX->( !MsSeek("DVV2") )
	Aviso( STR0056 , STR0057 , { STR0058 } )
EndIf
RestArea(aAreaSix)

//-- Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Eduardo de Souza      ³ Data ³ 31/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR470                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local cAliasQry := GetNextAlias()
Local aOrdem    := {}
Local oCliente
Local oTotal1
Local oTotal2
Local oTotal3
Local oTotal4
Local oTotal5
Local oTotal6
Local oTotal7

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
oReport:= TReport():New("TMSR470",STR0021,"TMR470", {|oReport| ReportPrint(oReport,cAliasQry,oCliente,oTotal1,oTotal2,oTotal3,oTotal4,oTotal5,oTotal6,oTotal7)},STR0022) // "Análise do contas a Receber - Aging" ### "Este programa imprimirá o relatório para anjálise do contas a receber - Aging"
oReport:SetTotalInLine(.F.)
oReport:SetLandscape(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros									³
//³ mv_par01		// Data de referencia									³
//³ mv_par02		// Lista (Fatura/Ctrcs/Todos							³
//³ mv_par03       	// Da Filial de debito									³
//³ mv_par04       	// Ate a Filial de debito		   						³
//³ mv_par05       	// Tipo (Analitico/Sintetico)       					³
//| mv_par06       	// Considera data base									|
//³ mv_par07       	// Qual moeda                    						³
//³ mv_par08       	// Outras moedas                 						³
//³ mv_par09       	// Cliente De                 							³
//³ mv_par10       	// Loja De                 								³
//³ mv_par11       	// Cliente Ate                 							³
//³ mv_par12       	// Loja Ate                								³
//³ mv_par13       	// Do Vencimento           								³
//³ mv_par14       	// Ate o Vencimento        								³
//³ mv_par15       	// Da Emissao        									³
//³ mv_par16       	// Ate a Emissao        								³
//³ mv_par17       	// Totaliza        										³
//³ mv_par18       	// Sintetico por        								³
//³ mv_par19       	// Qual ordem        									³
//³ mv_par20       	// Considera adiantamentos								³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)
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
oCliente:= TRSection():New(oReport,STR0023,{"TMP"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oCliente:lReadOnly := .T.
oCliente:SetTotalInLine(.F.)
TRCell():New(oCliente,"CLIENTE"    ,"TMP",STR0026,/*Picture*/,TamSx3("E1_CLIENTE")[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"LOJA"       ,"TMP",STR0027,/*Picture*/,TamSx3("E1_LOJA"   )[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"NOMCLI"     ,"TMP",STR0028,/*Picture*/,30                      ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oCliente,"CPFCGC"     ,"TMP",STR0029,/*Picture*/,TamSx3("A1_CGC"    )[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"FILIAL"     ,"TMP",STR0030,/*Picture*/,TamSx3("E1_FILIAL" )[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"PREFIXO"    ,"TMP",STR0031,/*Picture*/,TamSx3("E1_PREFIXO")[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"NUM"        ,"TMP",STR0032,/*Picture*/,TamSx3("E1_NUM"    )[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"PARCELA"    ,"TMP",STR0033,/*Picture*/,TamSx3("E1_PARCELA")[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"TIPO"       ,"TMP",STR0034,/*Picture*/,TamSx3("E1_TIPO"   )[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"CF"         ,"TMP",STR0035,/*Picture*/,1                      ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"EMISSAO"    ,"TMP",STR0036,/*Picture*/,8                      ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"VENCTO"     ,"TMP",STR0037,/*Picture*/,8                      ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"FILDEB"     ,"TMP",STR0038,/*Picture*/,TamSx3("E1_FILDEB" )[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCliente,"DOCTO"      ,     ,STR0052,/*Picture*/,TamSX3("F2_DOC")[1]    ,/*lPixel*/, {|| Iif(TMP->FATCTRCS == "F",STR0053,STR0054) },,,,,,.F.)
TRCell():New(oCliente,"AVENCER"    ,"TMP",STR0039,"@E 999,999,999.99",19             ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oCliente,"AVENCER%"   ,"TMP",STR0055,"@E 999.99%"       ,6              ,/*lPixel*/, {|| Tmr470Perc(TMP->AVENCER) },,,,,,.T.)
TRCell():New(oCliente,"ATE30"      ,"TMP",STR0040,"@E 999,999,999.99",19             ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oCliente,"ATE30%"     ,"TMP",STR0055,"@E 999.99%"       ,6              ,/*lPixel*/, {|| Tmr470Perc(TMP->ATE30) },,,,,,.T.)
TRCell():New(oCliente,"ATE60"      ,"TMP",STR0041,"@E 999,999,999.99",19             ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oCliente,"ATE60%"     ,"TMP",STR0055,"@E 999.99%"       ,6              ,/*lPixel*/, {|| Tmr470Perc(TMP->ATE60) },,,,,,.T.)
TRCell():New(oCliente,"ATE90"      ,"TMP",STR0042,"@E 999,999,999.99",19             ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oCliente,"ATE90%"     ,"TMP",STR0055,"@E 999.99%"       ,6              ,/*lPixel*/, {|| Tmr470Perc(TMP->ATE90) },,,,,,.T.)
TRCell():New(oCliente,"ATE120"     ,"TMP",STR0043,"@E 999,999,999.99",19             ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oCliente,"ATE120%"    ,"TMP",STR0055,"@E 999.99%"       ,6              ,/*lPixel*/, {|| Tmr470Perc(TMP->ATE120) },,,,,,.T.)
TRCell():New(oCliente,"ACIMADE120" ,"TMP",STR0044,"@E 999,999,999.99",19             ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oCliente,"ACIMADE120%","TMP",STR0055,"@E 999.99%"       ,6              ,/*lPixel*/, {|| Tmr470Perc(TMP->ACIMADE120) },,,,,,.T.)
TRCell():New(oCliente,"SITUACA"    ,"TMP",STR0045,/*Picture*/ ,11                    ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
If DT6->(FieldPos("DT6_BL_ALI")) > 0
	TRCell():New(oCliente,"BLOQALI","TMP",STR0046,/*Picture*/ ,3                     ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
EndIf
TRCell():New(oCliente,"TOTAL"    ,""   ,STR0051 ,"@E 999,999,999.99",19             ,/*lPixel*/, {|| TMP->AVENCER+TMP->ATE30+TMP->ATE60+TMP->ATE90+TMP->ATE120+TMP->ACIMADE120 },,,,,,.T.)

oTotal1:= TRFunction():New(oCliente:Cell("AVENCER"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal2:= TRFunction():New(oCliente:Cell("ATE30"     ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal3:= TRFunction():New(oCliente:Cell("ATE60"     ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal4:= TRFunction():New(oCliente:Cell("ATE90"     ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal5:= TRFunction():New(oCliente:Cell("ATE120"    ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal6:= TRFunction():New(oCliente:Cell("ACIMADE120"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal7:= TRFunction():New(oCliente:Cell("TOTAL"     ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

oTotaliz:= TRFunction():New(oCliente:Cell("AVENCER"   ),"AVC"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS <> "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("ATE30"     ),"30C"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS <> "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("ATE60"     ),"60C"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS <> "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("ATE90"     ),"90C"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS <> "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("ATE120"    ),"120C" ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS <> "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("ACIMADE120"),"A120C","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS <> "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("TOTAL"     ),"TOTC","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS <> "F" } )

oTotaliz:= TRFunction():New(oCliente:Cell("AVENCER"   ),"AVF"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS == "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("ATE30"     ),"30F"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS == "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("ATE60"     ),"60F"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS == "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("ATE90"     ),"90F"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS == "F" } )                
oTotaliz:= TRFunction():New(oCliente:Cell("ATE120"    ),"120F" ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS == "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("ACIMADE120"),"A120F","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS == "F" } )
oTotaliz:= TRFunction():New(oCliente:Cell("TOTAL"     ),"TOTF","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || TMP->FATCTRCS == "F" } )

//-- Secao Totalizadora
oTotal := TRSection():New(oReport,STR0025,{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oTotal:lReadOnly := .T.
oTotal:SetHeaderSection()
TRCell():New(oTotal,"TEXTO"     ,"   ",STR0025,/*cPicture*/      ,25,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"AVENCER"   ,"   ",STR0039,"@E 99,999,999.99",19,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"ATE30"     ,"   ",STR0040,"@E 99,999,999.99",19,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"ATE60"     ,"   ",STR0041,"@E 99,999,999.99",19,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"ATE90"     ,"   ",STR0042,"@E 99,999,999.99",19,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"ATE120"    ,"   ",STR0043,"@E 99,999,999.99",19,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"ACIMADE120","   ",STR0044,"@E 99,999,999.99",19,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"TOTAL"     ,"   ",STR0051,"@E 99,999,999.99",19,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo de Souza       ³ Data ³ 31/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR420                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,cAliasQry,oCliente,oTotal1,oTotal2,oTotal3,oTotal4,oTotal5,oTotal6,oTotal7)

//-- Criar o arquivo de trabalho
Tmr470Imp()

If mv_par05 == 2 // Sintetico
	If mv_par18 == 1
		oBreak := TRBreak():New(oCliente,oCliente:Cell("FILDEB" ),STR0049,.F.) // "Total Filial"
	Elseif mv_par18 == 2
		oBreak := TRBreak():New(oCliente,oCliente:Cell("CLIENTE"),STR0050,.F.) // "Total Devedor"
	EndIf
Else
	oBreak := TRBreak():New(oCliente,oCliente:Cell("CLIENTE"),STR0024,.F.)
EndIf
oTotal1:SetBreak(oBreak)
oTotal2:SetBreak(oBreak)
oTotal3:SetBreak(oBreak)
oTotal4:SetBreak(oBreak)
oTotal5:SetBreak(oBreak)
oTotal6:SetBreak(oBreak)
oTotal7:SetBreak(oBreak)

//-- Inicio da impressao do fluxo do relatório
oReport:SetMeter(TMP->(LastRec()))

If mv_par05 == 2 // Sintetico
	If mv_par18 == 1
		oReport:Section(1):Cell("CLIENTE"):Disable()
		oReport:Section(1):Cell("LOJA"   ):Disable()
		oReport:Section(1):Cell("NOMCLI" ):Disable()
	Else
		oReport:Section(1):Cell("FILDEB" ):Disable()
	EndIf
	oReport:Section(1):Cell("CPFCGC" ):Disable()
	oReport:Section(1):Cell("PREFIXO"):Disable()
	oReport:Section(1):Cell("NUM"    ):Disable()
	oReport:Section(1):Cell("PARCELA"):Disable()
	oReport:Section(1):Cell("TIPO"   ):Disable()
	oReport:Section(1):Cell("CF"     ):Disable()
	oReport:Section(1):Cell("EMISSAO"):Disable()
	oReport:Section(1):Cell("VENCTO" ):Disable()
	oReport:Section(1):Cell("FILIAL" ):Disable()
	oReport:Section(1):Cell("SITUACA"):Disable()
	If DT6->(FieldPos("DT6_BL_ALI")) > 0
		oReport:Section(1):Cell("BLOQALI"):Disable()
	EndIf
Else
	oReport:Section(1):Cell("DOCTO"      ):Disable()
	oReport:Section(1):Cell("AVENCER%"   ):Disable()
	oReport:Section(1):Cell("ATE30%"     ):Disable()
	oReport:Section(1):Cell("ATE60%"     ):Disable()
	oReport:Section(1):Cell("ATE90%"     ):Disable()
	oReport:Section(1):Cell("ATE120%"    ):Disable()
	oReport:Section(1):Cell("ACIMADE120%"):Disable()
EndIf

While !oReport:Cancel() .And. !TMP->(Eof())
	oReport:Section(1):Init()
	oReport:Section(1):PrintLine()
	TMP->(DbSkip())
EndDo
oReport:Section(1):Finish()

//-- Impressao dos totalizadores
If mv_par17 == 1
	oReport:SkipLine(2)

	oReport:Section(2):Init()
	
	oReport:Section(2):Cell("TEXTO"     ):SetValue(STR0047) // "Total CTRCs"
	oReport:Section(2):Cell("AVENCER"   ):SetValue(oReport:Section(1):GetFunction("AVC"  ):ReportValue())
	oReport:Section(2):Cell("ATE30"     ):SetValue(oReport:Section(1):GetFunction("30C"  ):ReportValue())
	oReport:Section(2):Cell("ATE60"     ):SetValue(oReport:Section(1):GetFunction("60C"  ):ReportValue())
	oReport:Section(2):Cell("ATE90"     ):SetValue(oReport:Section(1):GetFunction("90C"  ):ReportValue())
	oReport:Section(2):Cell("ATE120"    ):SetValue(oReport:Section(1):GetFunction("120C" ):ReportValue())
	oReport:Section(2):Cell("ACIMADE120"):SetValue(oReport:Section(1):GetFunction("A120C"):ReportValue())
	oReport:Section(2):Cell("TOTAL"     ):SetValue(oReport:Section(1):GetFunction("TOTC" ):ReportValue())
	oReport:Section(2):PrintLine()
	
	oReport:Section(2):Cell("TEXTO"     ):SetValue(STR0048) // "Total Faturas"
	oReport:Section(2):Cell("AVENCER"   ):SetValue(oReport:Section(1):GetFunction("AVF"  ):ReportValue())
	oReport:Section(2):Cell("ATE30"     ):SetValue(oReport:Section(1):GetFunction("30F"  ):ReportValue())
	oReport:Section(2):Cell("ATE60"     ):SetValue(oReport:Section(1):GetFunction("60F"  ):ReportValue())
	oReport:Section(2):Cell("ATE90"     ):SetValue(oReport:Section(1):GetFunction("90F"  ):ReportValue())
	oReport:Section(2):Cell("ATE120"    ):SetValue(oReport:Section(1):GetFunction("120F" ):ReportValue())
	oReport:Section(2):Cell("ACIMADE120"):SetValue(oReport:Section(1):GetFunction("A120F"):ReportValue())
	oReport:Section(2):Cell("TOTAL"     ):SetValue(oReport:Section(1):GetFunction("TOTF" ):ReportValue())
	oReport:Section(2):PrintLine()
	
	oReport:Section(2):Cell("TEXTO"     ):SetValue(STR0025) // "Total Geral"
	oReport:Section(2):Cell("AVENCER"   ):SetValue(oReport:Section(1):GetFunction("AVC"  ):ReportValue()+oReport:Section(1):GetFunction("AVF"  ):ReportValue())
	oReport:Section(2):Cell("ATE30"     ):SetValue(oReport:Section(1):GetFunction("30C"  ):ReportValue()+oReport:Section(1):GetFunction("30F"  ):ReportValue())
	oReport:Section(2):Cell("ATE60"     ):SetValue(oReport:Section(1):GetFunction("60C"  ):ReportValue()+oReport:Section(1):GetFunction("60F"  ):ReportValue())
	oReport:Section(2):Cell("ATE90"     ):SetValue(oReport:Section(1):GetFunction("90C"  ):ReportValue()+oReport:Section(1):GetFunction("90F"  ):ReportValue())
	oReport:Section(2):Cell("ATE120"    ):SetValue(oReport:Section(1):GetFunction("120C" ):ReportValue()+oReport:Section(1):GetFunction("120F" ):ReportValue())
	oReport:Section(2):Cell("ACIMADE120"):SetValue(oReport:Section(1):GetFunction("A120C"):ReportValue()+oReport:Section(1):GetFunction("A120F"):ReportValue())
	oReport:Section(2):Cell("TOTAL"     ):SetValue(oReport:Section(1):GetFunction("TOTC" ):ReportValue()+oReport:Section(1):GetFunction("TOTF" ):ReportValue())
	oReport:Section(2):PrintLine()

	oReport:Section(2):Finish()
EndIf

TMP->(DbCloseArea())

Return

//-----------------------------------------------------------------------------------------------------------
/* Tmr470Imp 
@author  	Jefferson Tomaz
@version 	P12 R12.1.30
@since 		13/05/2020
@return 	*/
//-----------------------------------------------------------------------------------------------------------
Static Function Tmr470Imp()

Local cAliasTmp
Local nX
Local aStruTmp 	:= {}
			
Local aCampos
Local aStru 	:= SE1->(DbStruct())
Local cQuery
Local cCampos
Local cWhere
Local cArqTmp	:= "TMP"

// Cria arquivo temporario de trabalho
Aadd( aStruTmp, { "FILIAL"		, "C", TamSx3("E1_FILIAL")[1], 0 } )
Aadd( aStruTmp, { "PREFIXO"		, "C", TamSx3("E1_PREFIXO")[1], 0 } )
Aadd( aStruTmp, { "NUM"    		, "C", TamSx3("E1_NUM")[1], 0 } )
Aadd( aStruTmp, { "PARCELA"		, "C", TamSx3("E1_PARCELA")[1], 0 } )
Aadd( aStruTmp, { "TIPO"		, "C", TamSx3("E1_TIPO")[1], 0 } )
Aadd( aStruTmp, { "CLIENTE"		, "C", TamSx3("E1_CLIENTE")[1], 0 } )
Aadd( aStruTmp, { "NOMCLI"		, "C", 30, 0 } )
Aadd( aStruTmp, { "LOJA"   		, "C", TamSx3("E1_LOJA")[1], 0 } )
Aadd( aStruTmp, { "CPFCGC"   	, "C", TamSx3("A1_CGC")[1], 0 } )
Aadd( aStruTmp, { "FILDEB"   	, "C", TamSx3("E1_FILDEB")[1], 0 } )
Aadd( aStruTmp, { "QUEBRA"   	, "C", TamSx3("A1_NOME")[1]+1, 0 } )
Aadd( aStruTmp, { "ORDEM"   	, "C", 50, 0 } )
Aadd( aStruTmp, { "CF"   		, "C", 1, 0 } )
Aadd( aStruTmp, { "VENCTO"		, "D", 8, 0 } )
Aadd( aStruTmp, { "EMISSAO"		, "D", 8, 0 } )
Aadd( aStruTmp, { "AVENCER"		, "N", 17, 2 } )
Aadd( aStruTmp, { "ATE30"		, "N", 17, 2 } )
Aadd( aStruTmp, { "ATE60"		, "N", 17, 2 } )
Aadd( aStruTmp, { "ATE90"		, "N", 17, 2 } )
Aadd( aStruTmp, { "ATE120"		, "N", 17, 2 } )
Aadd( aStruTmp, { "ACIMADE120"	, "N", 17, 2 } )
Aadd( aStruTmp, { "SITUACA"		, "C", 11, 0 } )
Aadd( aStruTmp, { "FATCTRCS"	, "C",  1, 0 } ) // FATURA OU CTRCS
If DT6->(FieldPos("DT6_BL_ALI")) > 0
	Aadd( aStruTmp, { "BLOQALI"	, "C",  1, 0 } ) // Bloqueio Alianca
Endif

oTemp	:= FwTemporaryTable():New(cArqTmp)
oTemp:SetFields(aStruTmp)
oTemp:AddIndex( Left(cArqTmp,7)+"A", {"QUEBRA"} )

If mv_par19 == 2  // Ordem Ranking
	oTemp:AddIndex( Left(cArqTmp,7)+"B", {"DESCEND(ORDEM)","FATCTRCS"} )
Else	
	oTemp:AddIndex( Left(cArqTmp,7)+"B", {"ORDEM","FATCTRCS"} )
Endif	
oTemp:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtra APENAS os emitidos antes da database, pois este rela³
//³ torio pode ser retroativo.                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par02 == 1 .Or. mv_par02 == 3 // Fatura ou Ambos
	
	// Condicao comum as duas queries
	cWhere := "SE1.E1_FILIAL ='"+xFilial("SE1")+"' AND "
	cWhere += "SE1.E1_CLIENTE >= '"+mv_par09+"' AND "
	cWhere += "SE1.E1_CLIENTE <= '"+mv_par11+"' AND "
	cWhere += "SE1.E1_LOJA >= '"+mv_par10+"' AND "
	cWhere += "SE1.E1_LOJA <= '"+mv_par12+"' AND "
	cWhere += "SE1.E1_EMISSAO >= '"+Dtos(mv_par15)+"' AND "
	cWhere += "SE1.E1_EMISSAO <= '"+Dtos(mv_par16)+"' AND "
	cWhere += "SE1.E1_EMISSAO <= '"+Dtos(mv_par01)+"' AND "
	cWhere += "SE1.E1_VENCREA >= '"+Dtos(mv_par13)+"' AND "
	cWhere += "SE1.E1_VENCREA <= '"+Dtos(mv_par14)+"' AND "
	cWhere += "SE1.E1_FILDEB >='"+mv_par03+"' AND "
	cWhere += "SE1.E1_FILDEB <='"+mv_par04+"' AND "
	cWhere += "SE1.E1_TIPO NOT IN "+FormatIn(MVIRABT+"|"+MVCSABT+"|"+MVCFABT+"|"+MVPIABT+"|"+MVABATIM, "|") +" AND "
	// Se nao considera adiantamentos
	If mv_par20 == 2
		cWhere += "SE1.E1_TIPO NOT IN "+FormatIn(MVRECANT,,3) +" AND "
	Endif	
	If mv_par08 == 2 // Nao imprimir outras moedas
		cWhere += "SE1.E1_MOEDA = "+Str(MV_PAR07,2)+" AND "
	Endif	
	cWhere += " SA1.A1_FILIAL='"	+ xFilial("SA1") + "' AND "
	cWhere += " SA1.A1_COD = SE1.E1_CLIENTE AND "
	cWhere += " SA1.A1_LOJA = SE1.E1_LOJA AND "
	cWhere += " SE1.D_E_L_E_T_=' ' AND "
	cWhere += " SA1.D_E_L_E_T_=' ' "

	aStru := SE1->(DbStruct())
	aCampos  := { "E1_FILIAL", "E1_FILORIG", "E1_FILDEB", "E1_PREFIXO", "E1_NUM", "E1_PARCELA", "E1_TIPO", "E1_CLIENTE", "E1_EMISSAO", "E1_VENCREA", "E1_NATUREZ", "E1_LOJA", "E1_VALOR", "E1_SALDO", "E1_TXMOEDA", "E1_MOEDA" }
	cAliasTmp := GetNextAlias()
	cQuery := ""
	cCampos := ""
	aEval(aCampos,{|x| cCampos += ","+AllTrim(x)})
	cQuery := "SELECT DISTINCT "+SubStr(cCampos,2)
	cQuery +=         ", SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_CGC, SE1.R_E_C_N_O_ RECNO "
	cQuery += "FROM "+RetSqlName("SE1")+ " SE1, "
	cQuery +=         RetSqlName("SA1")+ " SA1 "
	cQuery += "WHERE "
	cQuery += cWhere
	
	If mv_par06 == 2
		cQuery += " AND SE1.E1_SALDO > 0 "
	Endif
		
	If mv_par06 == 2
		cQuery += " AND SE1.E1_SITFAT <> '3' " // Nao seleciiona fatura canceladas
	Endif
			
	If mv_par06 == 1 // Compoe saldo retroativo
		
		cQuery   += " UNION ALL "
			
		// Seleciona tambem as faturas canceladas com data posterior a data de referencia
		cQuery += "SELECT DISTINCT "+SubStr(cCampos,2)
		cQuery +=         ", SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_CGC, SE1.R_E_C_N_O_ RECNO "
		cQuery += "FROM "	+	RetSqlName("SE1")+ " SE1, "
		cQuery +=				RetSqlName("SA1")+ " SA1, "
		cQuery +=				RetSqlName("DVV")+ " DVV "
		cQuery += "WHERE "
	   cQuery += cWhere
		   
	   // Seleciona apenas as faturas canceladas para recompor o valor dos titulos excluidos apos
	   // a data de referencia - Ex. dia 14/02 foi excluido um ctrc da fatura, mas no dia 13/02 ele ainda nao
	   // havia sido excluido, entao se a data de referencia for dia 13/02 o titulo deve aparecer com o valor
	   // que estava naquela data.
	  	cQuery += " AND SE1.E1_SITFAT = '3' "
		cQuery += " AND DVV_FILIAL='"	+ xFilial("DVV") + "'"
		cQuery += " AND SE1.E1_BAIXA = ' ' "
		cQuery += " AND DVV.DVV_PREFIX=SE1.E1_PREFIXO "
		cQuery += " AND DVV.DVV_NUM=SE1.E1_NUM "
		cQuery += " AND DVV.DVV_TIPO=SE1.E1_TIPO "
		cQuery += " AND DVV.DVV_DTEXCL >= '"+Dtos(mv_par01) + "'"
		cQuery += " AND SE1.D_E_L_E_T_ = ' '"
		cQuery += " AND DVV.D_E_L_E_T_ = ' '"
		cQuery += " ORDER BY RECNO "
			
	Endif	
   	
	cQuery := ChangeQuery(cQuery)
	Memowrite("TMSR470.SE1", cQuery )
		
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)	
	For nX :=  1 To Len(aStru)
		If aStru[nX][2] <> "C" .And. Ascan(aCampos, { |e| Alltrim(aStru[nX][1]) == Alltrim(e)}) > 0
			TcSetField(cAliasTmp,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
		EndIf
	Next nX
	GeraArq(cAliasTmp, 1)
	(cAliasTmp)->(DbCloseArea())
Endif

If mv_par02 == 2 .Or. mv_par02 == 3 // conhecimento ou Ambos
	cWhere := "DT6.DT6_FILIAL ='"+xFilial("DT6")+"' AND "
	cWhere += "DT6.DT6_CLIDEV >= '"+mv_par09+"' AND "
	cWhere += "DT6.DT6_CLIDEV <= '"+mv_par11+"' AND "
	cWhere += "DT6.DT6_LOJDEV >= '"+mv_par10+"' AND "
	cWhere += "DT6.DT6_LOJDEV <= '"+mv_par12+"' AND "
	cWhere += "DT6.DT6_DATEMI >= '"+Dtos(mv_par15)+"' AND "
	cWhere += "DT6.DT6_DATEMI <= '"+Dtos(mv_par16)+"' AND "
	cWhere += "DT6.DT6_FILDEB >='"+mv_par03+"' AND "
	cWhere += "DT6.DT6_FILDEB <='"+mv_par04+"' AND "
	cWhere += "DT6.DT6_IDRCTE <> '101' AND " //--Cte Cancelados
	cWhere += "DT6.DT6_IDRCTE <> '102' AND " //--Cte Inutilizados
		
	// Fatura apenas documentos validos de transporte
	cWhere += "DT6.DT6_DOCTMS NOT IN ( '1', 'A' ) AND "
	cWhere += "DT6.DT6_SERIE <> 'PED' AND "
	// Documento Anulado
	cWhere += "DT6.DT6_STATUS <> '9' AND "

	If mv_par08 == 2 // Nao imprimir outras moedas
		cWhere += " DT6.DT6_MOEDA = "+Str(MV_PAR07,2)+" AND "
	Endif	
	cWhere   += " SA1.A1_FILIAL='"	+ xFilial("SA1") + "' AND "
	cWhere   += " SA1.A1_COD = DT6.DT6_CLIDEV AND "
	cWhere   += " SA1.A1_LOJA = DT6.DT6_LOJDEV AND "
	cWhere 	+= " DT6.D_E_L_E_T_=' ' AND "
	cWhere 	+= " SA1.D_E_L_E_T_=' ' "

	aStru  := DT6->(dbStruct())
	cAliasTmp := "TMSR470"
	cQuery := ""
	cCampos := ""
	aEval(aStru,{|x| cCampos += ","+AllTrim(x[1])})
	cQuery := "SELECT "+SubStr(cCampos,2)
	cQuery +=         ", SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_CGC, ' ' E1_EMISSAO "
	cQuery += "FROM "+RetSqlName("DT6")+ " DT6, "
	cQuery +=         RetSqlName("SA1")+ " SA1 "
	cQuery += "WHERE "
	cQuery += cWhere
	// Seleciona doctos em aberto (nao faturados)
	cQuery	+= " AND DT6.DT6_PREFIX='"+Space(Len(DT6->DT6_PREFIX))+"' AND "
	cQuery	+= " DT6.DT6_NUM='"+Space(Len(DT6->DT6_NUM))+"' AND "
	cQuery	+= " DT6.DT6_TIPO='"+Space(Len(DT6->DT6_TIPO))+"'"
		
	cQuery   += " UNION ALL "
		
	cQuery += "SELECT "+SubStr(cCampos,2)
	cQuery +=         ", SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_CGC, SE1.E1_EMISSAO "
	cQuery += "FROM "+RetSqlName("DT6")+ " DT6, "
	cQuery +=        	RetSqlName("SA1")+ " SA1, "
	cQuery += 		 	RetSqlName("SE1")+ " SE1 "
	cQuery += "WHERE "
	cQuery += cWhere
		
	// Seleciona doctos faturados, porem com data de faturamento maior que a data de referencia
	cQuery	+= " AND DT6.DT6_PREFIX<>'"+Space(Len(DT6->DT6_PREFIX))+"' AND "
	cQuery	+= " DT6.DT6_NUM<>'"+Space(Len(DT6->DT6_NUM))+"' AND "
	cQuery	+= " DT6.DT6_TIPO<>'"+Space(Len(DT6->DT6_TIPO))+"' AND "
	cQuery 	+= " SE1.E1_FILIAL = '" + xFilial("SE1") + "' AND "
	cQuery  += " SE1.E1_BAIXA = ' ' AND "
	cQuery 	+= " DT6.DT6_PREFIX = SE1.E1_PREFIXO AND "
	cQuery 	+= " DT6.DT6_NUM = SE1.E1_NUM AND "
	cQuery 	+= " DT6.DT6_TIPO = SE1.E1_TIPO AND "
	cQuery 	+= " SE1.E1_EMISSAO > '" + DTOS(mv_par01) + "' AND "
	cQuery 	+= " SE1.D_E_L_E_T_=' ' "
   	
	cQuery := ChangeQuery(cQuery)
	Memowrite("TMSR470.DT6", cQuery )
		
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)	
	For nX :=  1 To Len(aStru)
		If aStru[nX][2] <> "C"
			TcSetField(cAliasTmp,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
		EndIf
	Next nX
	GeraArq(cAliasTmp, 2)
	(cAliasTmp)->(DbCloseArea())
Endif

DbSelectArea("TMP")
DbGotop()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³GeraArq   ³ Autor ³ Claudio D. de Souza   ³ Data ³ 22/12/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Gera arquivo temporario de trabalho								³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ GeraArq(cAliasTmp, nProcesso)										³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ TMSR470                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GeraArq(cAliasTmp, nProcesso)

Local cTipo
Local nRecno
Local nTotExcl
Local lCancAntigo
Local nAbatim := 0

While (cAliasTmp)->(!Eof())
	
	nAbatim := 0
	If nProcesso == 1
		nRecno := (cAliasTmp)->RECNO
	Endif
		
	cTipo := If(nProcesso == 1 , "F", "C" ) // Tipo: F=Fatura ou C=Ctrcs
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If .T. // Empty(cFilterUser).Or. (&cFilterUser)
		If nProcesso == 1 // Fatura
			If ! (cAliasTmp)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG
				nAbatim := SomaAbat((cAliasTmp)->E1_PREFIXO,(cAliasTmp)->E1_NUM,(cAliasTmp)->E1_PARCELA,"R",mv_par07,dDataBase,(cAliasTmp)->E1_CLIENTE,(cAliasTmp)->E1_LOJA,, mv_par01)
			Endif	
			If mv_par06 == 1
				SE1->(MsGoto((cAliasTmp)->RECNO)) // SaldoTit precisa do SE1 posicionado
				nSaldo := Round(Saldotit((cAliasTmp)->E1_PREFIXO, (cAliasTmp)->E1_NUM, (cAliasTmp)->E1_PARCELA, (cAliasTmp)->E1_TIPO, (cAliasTmp)->E1_NATUREZ, "R", (cAliasTmp)->E1_CLIENTE, mv_par07,, mv_par01, (cAliasTmp)->E1_LOJA),2)
				// Soma o Decrescimo, pois ele sera tratado conforme data de referencia, pela rotina T470TotExc (abaixo)
				nSaldo += SE1->E1_SDDECRE
			Else
				nSaldo := Round(xMoeda((cAliasTmp)->E1_SALDO,(cAliasTmp)->E1_MOEDA,MV_PAR07,,,If(cPaisLoc=="BRA",(cAliasTmp)->E1_TXMOEDA,0)),2)
			Endif
			nSaldo -= nAbatim
			If ! (cAliasTmp)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG
				lCancAntigo := Str((cAliasTmp)->E1_VALOR,17,2) != Str((cAliasTmp)->E1_SALDO,17,2) .Or. Empty((cAliasTmp)->E1_VALOR)
				nTotExcl := T470TotExc(mv_par01, (cAliasTmp)->E1_PREFIXO, (cAliasTmp)->E1_NUM, (cAliasTmp)->E1_TIPO, lCancAntigo)
				// Indica faturas canceladas no modo antigo, em que o valor do titulo era zerado.
				If lCancAntigo
					// Soma exclusoes ao total da fatura, para recompor o valor da fatura na data de referencia
					nSaldo += nTotExcl
				Else
					// Subtrai o valor total das exclusoes para exibir o valor da fatura na data de referencia
					nSaldo -= nTotExcl
				Endif
			Else
				nSaldo *= (-1) // Inverte o valor para titulos de credito
			Endif
		Else // Ctrc
			nSaldo := xMoeda((cAliasTmp)->(DT6_VALTOT+DT6_ACRESC-DT6_DECRES),1,MV_PAR07)
		Endif
		// Se o titulo nao estiver vencido
		If nSaldo != 0
			If mv_par05 == 2 // Sintetico
				If mv_par18 == 1 // 	Sintetico por filial
					cChave := (cAliasTmp)->(If(nProcesso == 1, E1_FILDEB, DT6_FILDEB)+cTipo)
				Elseif mv_par18 == 2 // Sintetico por Devedor
					cChave := (cAliasTmp)->(If(nProcesso == 1, E1_CLIENTE, DT6_CLIDEV)+cTipo)
				Endif
				If !TMP->(MsSeek(cChave))
					DbSelectArea("TMP")
					DbAppend()
				Endif
			Else
				DbSelectArea("TMP")
				DbAppend()
			Endif	
			If nProcesso == 1 // Fatura
				// Posiciona no cliente
				TMP->FILIAL		:= (cAliasTmp)->E1_FILORIG
				TMP->PREFIXO	:= (cAliasTmp)->E1_PREFIXO
				TMP->NUM		:= (cAliasTmp)->E1_NUM
				TMP->PARCELA	:= (cAliasTmp)->E1_PARCELA
				TMP->TIPO		:= (cAliasTmp)->E1_TIPO
				TMP->CLIENTE	:= (cAliasTmp)->E1_CLIENTE
				TMP->FILDEB		:= (cAliasTmp)->E1_FILDEB
				TMP->EMISSAO	:= (cAliasTmp)->E1_EMISSAO
				TMP->VENCTO		:= (cAliasTmp)->E1_VENCREA
			Else // Ctrc
				// Posiciona no cliente
				TMP->FILIAL		:= (cAliasTmp)->DT6_FILDOC
				TMP->PREFIXO	:= (cAliasTmp)->DT6_SERIE
				TMP->NUM			:= (cAliasTmp)->DT6_DOC
				TMP->CLIENTE	:= (cAliasTmp)->DT6_CLIDEV
				TMP->TIPO		:= If( (cAliasTmp)->DT6_TIPFRE == "1", "C", "F" ) // Tipo de  frete, 1=Cif, 2=Fob
				TMP->FILDEB		:= (cAliasTmp)->DT6_FILDEB
				TMP->EMISSAO	:= (cAliasTmp)->DT6_DATEMI
				TMP->VENCTO		:= (cAliasTmp)->DT6_DATEMI //(cAliasTmp)->DT6_VENCTO
				If DT6->(FieldPos("DT6_BL_ALI")) > 0
					TMP->BLOQALI := (cAliasTmp)->DT6_BL_ALI
				Endif
			Endif	
			TMP->NOMCLI		:= (cAliasTmp)->A1_NOME
			TMP->LOJA		:= (cAliasTmp)->A1_LOJA
			TMP->CPFCGC		:= (cAliasTmp)->A1_CGC
			TMP->FATCTRCS	:= cTipo
			If mv_par18 == 1 // Quebra por filial			
				TMP->QUEBRA		:= TMP->FILDEB+cTipo
			Elseif mv_par18 == 2 // Quebra por devedor
				TMP->QUEBRA		:= TMP->CLIENTE+cTipo
			Endif	
			
			If TMP->VENCTO >= mv_par01
				TMP->AVENCER += nSaldo
			Else	
				nDias := (cAliasTmp)->(mv_par01 - TMP->VENCTO)
				Do Case
				Case nDias >= 1 .And. nDias <= 30
					TMP->ATE30 += nSaldo
				Case nDias >= 31 .And. nDias <= 60
					TMP->ATE60 += nSaldo
				Case nDias >= 61 .And. nDias <= 90
					TMP->ATE90 += nSaldo
				Case nDias >= 91 .And. nDias <= 120	
					TMP->ATE120 += nSaldo
				Case nDias >= 121
					TMP->ACIMADE120 += nSaldo
				EndCase	
				If mv_par19 == 2  .And. mv_par05 == 2// Sintetico por Ordem de Ranking
					// Grava a Ordem para todos os registros (Faturas e Ctrcs) para que ambos fiquem na mesma sequencia
					nRecTmp := TMP->(Recno())
					If TMP->(MsSeek(SubStr(cChave,1,Len(cChave)-1)))
						nDevido := 0
						// somo o total devido (Faturas e Ctrcs)
						While TMP->(!Eof()) .And.;
								SubStr(TMP->QUEBRA,1,Len(cChave)-1) == SubStr(cChave,1,Len(cChave)-1)
							nDevido += TMP->(ATE30+ATE60+ATE90+ATE120+ACIMADE120)
							TMP->(DbSkip())
						End
						// Gravo op mesmo valor para o Total de Ctrc e Total de Faturas para mesma quebra
						TMP->(MsSeek(SubStr(cChave,1,Len(cChave)-1)))
						While TMP->(!Eof()) .And.;
								SubStr(TMP->QUEBRA,1,Len(cChave)-1) == SubStr(cChave,1,Len(cChave)-1)
							TMP->ORDEM		:= Str(nDevido, 24, 2)
							TMP->(DbSkip())
						End
						TMP->(DbGoto(nRecTmp))
					Else
						TMP->(DbGoto(nRecTmp))
						TMP->ORDEM		:= TMP->(Str(ATE30+ATE60+ATE90+ATE120+ACIMADE120,24,2))
					Endif	
				Endif
			Endif
			If mv_par19 == 1 // Ordem Alfabetica
				If mv_par18 == 1 // Quebra por filial
					TMP->ORDEM		:= TMP->FILDEB
				Elseif mv_par18 == 2 // Quebra por devedor
					TMP->ORDEM		:= TMP->NOMCLI
				Endif	
			Endif	
		Endif	
	Endif
	Msunlock()
	(cAliasTmp)->(DbSkip())
	// No processamento das faturas, avanca para proximo registro valido
	If nProcesso == 1
		// Avanca para proximo registro valido
		While (cAliasTmp)->RECNO  == nRecno
			(cAliasTmp)->(DbSkip())
		End
	Endif	
EndDo

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³Tmr470Perc³ Autor ³ Claudio D. de Souza   ³ Data ³ 22/12/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Calcula a proporcao de uma base sobre um total					³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ Tmr470Perc(nBase, nTotal)												³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ TMSR470                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Tmr470Perc(nBase,nTotal)

If nTotal == Nil
	nTotal := TMP->(AVENCER + ATE30 + ATE60 + ATE90	+ ATE120	+ ACIMADE120)
Endif	

Return Transform((nBase / nTotal) * 100, "@E 999.99") + "%"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³T470TotExc³ Autor ³ Claudio D. de Souza   ³ Data ³ 15/02/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Soma o total de doctos excluidos de uma fatura 				³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ T470TotExc(dDataRef, cPrefixo, cNum, cTipo)					   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ TMSR470                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function T470TotExc(dDataRef, cPrefixo, cNum, cTipo, lCancAntigo)

Local cQuery
Local cAliasTrb := GetNextAlias()
Local cAliasOld := Alias()
Local nTotCanc  := 0

If DVV->(FieldPos("DVV_VALTOT")) > 0 .And.;
	DVV->(FieldPos("DVV_ACRESC")) > 0 .And.;
	DVV->(FieldPos("DVV_DECRES")) > 0
	cQuery := "SELECT SUM(DVV.DVV_VALTOT+DVV.DVV_ACRESC-DVV.DVV_DECRES) TOTEXCLUIDO "
	cQuery += " FROM "+RetSqlName("DVV")+ " DVV "
	cQuery += "WHERE DVV.DVV_FILIAL ='"	 + xFilial("DVV") + "'"
	cQuery += "  AND DVV.DVV_PREFIX ='"  + cPrefixo +"'"
	cQuery += "  AND DVV.DVV_NUM    ='"  + cNum +"'"
	cQuery += "  AND DVV.DVV_TIPO   ='"  + cTipo +"'"
Else	
	cQuery := "SELECT SUM(DT6.DT6_VALTOT+DT6.DT6_ACRESC-DT6.DT6_DECRES) TOTEXCLUIDO "
	// Considera DT6 excluidos, pois eles podem ter sido excluidos de uma fatura e excluidos do sistema.
	// Se nao considerar os DT6 excluidos, não sera possivel somar o valor deles no total de 
	// Ctrc excluidos de uma fatura
	cQuery	+= "FROM "+RetSqlName("DVV")+ " DVV, "
	cQuery	+=         RetSqlName("DT6")+ " DT6 "
	cQuery	+= "WHERE DVV_FILIAL='"	+ xFilial("DVV") + "'"
	cQuery	+= "  AND DVV.DVV_PREFIX='" + cPrefixo +"'"
	cQuery	+= "  AND DVV.DVV_NUM='" + cNum +"'"
	cQuery	+= "  AND DVV.DVV_TIPO='" + cTipo +"'"
	cQuery	+= "  AND DT6.DT6_FILIAL = '" + xFilial("DT6") + "'"
	cQuery	+= "  AND DT6.DT6_FILDOC=DVV.DVV_FILDOC" 
	cQuery	+= "  AND DT6.DT6_DOC=DVV.DVV_DOC"
	cQuery	+= "  AND DT6.DT6_SERIE=DVV.DVV_SERIE"
	cQuery	+= "  AND DT6.D_E_L_E_T_ = ' '"
EndIf	
// Cancelamentos antigos devem considerar 
If lCancAntigo
	cQuery	+= " AND DVV.DVV_DTEXCL > '" +Dtos(dDataRef) + "'"
Else
	cQuery	+= " AND DVV.DVV_DTEXCL <= '" +Dtos(dDataRef) + "'"
Endif	
cQuery	+= " AND DVV.D_E_L_E_T_ = ' '"

cQuery := ChangeQuery(cQuery)

dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasTrb, .F., .T.)

TcSetField(cAliasTrb,"TOTEXCLUIDO"  ,"N", 17,2)

nTotCanc := (cAliasTrb)->TOTEXCLUIDO

(cAliasTrb)->(DbCloseArea())
DbSelectArea(cAliasOld)
	
Return nTotCanc
