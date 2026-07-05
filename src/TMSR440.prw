/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR440.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR440  ³ Autor ³ Eduardo de Souza      ³ Data ³ 31/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Comparativo de Rentabilidade de Viagem                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR440()

Local oReport
Local aArea := GetArea()

PutHelp("P.TMR44014.",{"Informe se considera niveis inferiores","de Região Origem."},{},{},.F.)
PutHelp("P.TMR44015.",{"Informe se considera niveis inferiores","de Região Destino."},{},{},.F.)
PutHelp("P.TMR44016.",{"Informe se considera somente Rateio ","para Viagem."},{},{},.F.)

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
±±³Uso       ³ TMSR440                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local cAliasQry := GetNextAlias()
Local aOrdem    := {}
Local nRent        := 0
Local nRentPerc    := 0
Local nValFre      := 0 
Local nFretPago    := 0
Local nPdgPago     := 0
Local cFilDoc      := " "
Local cDocto       := " "
Local cSerie       := " "
Local nFretComp    := 0
Local oDocumento

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
oReport:= TReport():New("TMSR440",STR0020,"TMR440", {|oReport| ReportPrint(oReport,cAliasQry,@nRent,@nRentPerc,@nValFre,@nFretPago,@nPdgPago,@cFilDoc,@cDocto,@cSerie,@nFretComp)},STR0021) // "Comparativo de Rentabilidade de Viagem" ### "Emite a relacao de Comparativo de Rentabilidade de Viagem conforme os parametros informados"
oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mv_par01	 // Devedor De                                    ³
//³ mv_par02	 // Loja De                                       ³
//³ mv_par03	 // Devedor Ate                                   ³
//³ mv_par04	 // Loja Ate                                      ³
//³ mv_par05	 // Regiao Origem                                 ³
//³ mv_par06	 // Regiao Destino                                ³
//³ mv_par07	 // Data Fech. Viagem De                          ³
//³ mv_par08	 // Data Fech. Viagem Ate                         ³
//³ mv_par09	 // Frota                                         ³
//³ mv_par10	 // Rentabilidade                                 ³
//³ mv_par11	 // Tipo Relatorio                                ³
//³ mv_par12	 // Status Viagem                                 ³
//³ mv_par13    // Rateio Frete A Pagar                          ³
//³ mv_par14	 // Considera Niveis Inferiores p/ Regiao Origem  ³
//³ mv_par15	 // Considera Niveis Inferiores p/ Regiao Destino ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
Aadd( aOrdem, STR0022 ) // "Devedor + Origem + Destino + Viagem"

oCliente:= TRSection():New(oReport,STR0025,{"DT6"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oCliente:SetTotalInLine(.F.)
oCliente:SetTotalText(STR0059) //-- "Total"
oCliente:SetPageBreak()
TRCell():New(oCliente,"DT6_CLIDEV","DT6",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"DT6_LOJDEV","DT6",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"A1_NOME"   ,"SA1",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"DT6_CDRORI",""   ,STR0023   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"DT6_REGORI","DT6",STR0027   ,/*Picture*/,25/*Tamanho*/,/*lPixel*/, {|| Posicione("DUY",1,xFilial("DUY")+(cAliasQry)->DT6_CDRORI,"DUY_DESCRI") } )
TRCell():New(oCliente,"DT6_CDRDES",""   ,STR0024   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"DT6_REGDES","DT6",STR0027   ,/*Picture*/,25/*Tamanho*/,/*lPixel*/, {|| Posicione("DUY",1,xFilial("DUY")+(cAliasQry)->DT6_CDRDES,"DUY_DESCRI") } )

oViagem:= TRSection():New(oCliente,STR0026,{"DTQ","DTY","DA8","DTR","SA2","DA3"},/*Ordem do relatorio*/,/*Campos do SX3*/,/*Campos do SIX*/)
oViagem:SetTotalInLine(.F.)
TRCell():New(oViagem,"DTQ_FILORI","DTQ",STR0028,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTQ_VIAGEM","DTQ",STR0026,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTQ_DATFEC","DTQ",STR0029,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTQ_STATUS","DTQ",STR0030,/*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTY_NUMCTC","DTY",STR0042,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTY_DATCTC","DTY",STR0043,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTQ_ROTA"  ,"DTQ",STR0041,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DA8_DESC"  ,"DA8",STR0027,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTR_CODFOR","DTR",STR0033,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTR_LOJFOR","DTR",STR0034,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"A2_NREDUZ" ,"SA2",STR0035,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTR_CODVEI","DTR",STR0031,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DA3_PLACA" ,"DA3",STR0032,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oDocumento:= TRSection():New(oViagem,STR0044,{"DUD"},/*Ordem do relatorio*/,/*Campos do SX3*/,/*Campos do SIX*/)
oDocumento:SetTotalInLine(.F.)
TRCell():New(oDocumento,"DUD_FILDOC","DUD",STR0045,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocumento,"DUD_DOC"   ,"DUD",,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocumento,SerieNfId("DUD",3,"DUD_SERIE") ,"DUD",STR0047,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocumento,"DT6_DOCTMS","DT6",STR0048,/*Picture*/,15/*Tamanho*/,/*lPixel*/, {|| SubStr(AllTrim(TMSValField((cAliasQry)+'->DT6_DOCTMS',.F.)),1,15) })
TRCell():New(oDocumento,"FILDOC"    ,""   ,STR0049,/*Picture*/,2 /*Tamanho*/,/*lPixel*/, {|| cFilDoc } )
TRCell():New(oDocumento,"DOC"       ,""   ,STR0050,/*Picture*/,TamSX3("F2_DOC")[1] /*Tamanho*/,/*lPixel*/, {|| cDocto  } )
TRCell():New(oDocumento,"SERIE"     ,""   ,STR0047,/*Picture*/,3 /*Tamanho*/,/*lPixel*/, {|| cSerie  } )
TRCell():New(oDocumento,"DT6_DATEMI","DT6",STR0051,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocumento,"DT6_STATUS","DT6",STR0030,/*Picture*/,25/*Tamanho*/,/*lPixel*/, {|| U_TMR440StDc((cAliasQry)->DTQ_SERTMS,(cAliasQry)->DUD_FILDOC,(cAliasQry)->DUD_DOC,(cAliasQry)->DUD_SERIE,(cAliasQry)->DT6_STATUS) } )
TRCell():New(oDocumento,"VALFRE"    ,""   ,STR0052,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/, {|| nValFre } )
TRCell():New(oDocumento,"FRETCOMP"  ,""   ,STR0053,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/, {|| nFretComp } )
TRCell():New(oDocumento,"DT6_SERVIC","DT6",STR0040,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocumento,"DT6_DESSER","DT6",STR0027,/*Picture*/,30/*Tamanho*/,/*lPixel*/,{|| AllTrim(Tabela("L4",(cAliasQry)->DT6_SERVIC,.F.)) })
TRCell():New(oDocumento,"DT6_PESO"  ,"DT6",STR0054,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocumento,"FRETPAGO"  ,""   ,STR0055,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/, {|| nFretPago } )
TRCell():New(oDocumento,"PDGPAGO"   ,""   ,STR0056,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/, {|| nPdgPago  } )
TRCell():New(oDocumento,"RENTAB"    ,""   ,STR0057,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/, {|| nRent     } )
TRCell():New(oDocumento,"RENTAB%"   ,""   ,STR0058,"@E 9999.99",7,/*lPixel*/, {|| nRentPerc } )

TRFunction():New(oDocumento:Cell("VALFRE"  ),"VALFRE"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oCliente)
TRFunction():New(oDocumento:Cell("FRETCOMP"),"FRETCOMP","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oCliente)
TRFunction():New(oDocumento:Cell("DT6_PESO"),/*cId*/   ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oCliente)
TRFunction():New(oDocumento:Cell("FRETPAGO"),/*cId*/   ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oCliente)
TRFunction():New(oDocumento:Cell("PDGPAGO" ),/*cId*/   ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oCliente)
TRFunction():New(oDocumento:Cell("RENTAB"  ),"RENTAB"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oCliente)
TRFunction():New(oDocumento:Cell("RENTAB%" ),/*cId*/   ,"MAX",/*oBreak*/,/*cTitle*/,/*cPicture*/,{ || TMR440Tot(oReport,(cAliasQry)->DT6_CLIDEV + (cAliasQry)->DT6_LOJDEV + (cAliasQry)->DT6_CDRORI + (cAliasQry)->DT6_CDRDES) },/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oCliente)

oTotaliz:=TRFunction():New(oDocumento:Cell("VALFRE"  ),"VALFRE_1"  ,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(1,Len(DA3->DA3_FROVEI	)) } ) //-- Propria
oTotaliz:=TRFunction():New(oDocumento:Cell("FRETCOMP"),"FRETCOMP_1","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(1,Len(DA3->DA3_FROVEI	)) } ) //-- Propria
oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESO"),"DT6_PESO_1","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(1,Len(DA3->DA3_FROVEI	)) } ) //-- Propria
oTotaliz:=TRFunction():New(oDocumento:Cell("FRETPAGO"),"FRETPAGO_1","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(1,Len(DA3->DA3_FROVEI	)) } ) //-- Propria
oTotaliz:=TRFunction():New(oDocumento:Cell("PDGPAGO" ),"PDGPAGO_1","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(1,Len(DA3->DA3_FROVEI	)) } ) //-- Propria
oTotaliz:=TRFunction():New(oDocumento:Cell("RENTAB"  ),"RENTAB_1" ,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(1,Len(DA3->DA3_FROVEI	)) } ) //-- Propria
oTotaliz:=TRFunction():New(oDocumento:Cell("RENTAB%" ),"RENTAB%_1","MAX"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(1,Len(DA3->DA3_FROVEI	)) } ) //-- Propria

oTotaliz:=TRFunction():New(oDocumento:Cell("VALFRE"  ),"VALFRE_2"  ,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(2,Len(DA3->DA3_FROVEI	)) } ) //-- Terceiro
oTotaliz:=TRFunction():New(oDocumento:Cell("FRETCOMP"),"FRETCOMP_2","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(2,Len(DA3->DA3_FROVEI	)) } ) //-- Terceiro
oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESO"),"DT6_PESO_2","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(2,Len(DA3->DA3_FROVEI	)) } ) //-- Terceiro
oTotaliz:=TRFunction():New(oDocumento:Cell("FRETPAGO"),"FRETPAGO_2","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(2,Len(DA3->DA3_FROVEI	)) } ) //-- Terceiro
oTotaliz:=TRFunction():New(oDocumento:Cell("PDGPAGO" ),"PDGPAGO_2","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(2,Len(DA3->DA3_FROVEI	)) } ) //-- Terceiro
oTotaliz:=TRFunction():New(oDocumento:Cell("RENTAB"  ),"RENTAB_2" ,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(2,Len(DA3->DA3_FROVEI	)) } ) //-- Terceiro
oTotaliz:=TRFunction():New(oDocumento:Cell("RENTAB%" ),"RENTAB%_2","AVERAGE",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(2,Len(DA3->DA3_FROVEI	)) } ) //-- Terceiro

oTotaliz:=TRFunction():New(oDocumento:Cell("VALFRE"  ),"VALFRE_3"  ,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(3,Len(DA3->DA3_FROVEI	)) } ) //-- Agregados
oTotaliz:=TRFunction():New(oDocumento:Cell("FRETCOMP"),"FRETCOMP_3","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(3,Len(DA3->DA3_FROVEI	)) } ) //-- Agregados
oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESO"),"DT6_PESO_3","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(3,Len(DA3->DA3_FROVEI	)) } ) //-- Agregados
oTotaliz:=TRFunction():New(oDocumento:Cell("FRETPAGO"),"FRETPAGO_3","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(3,Len(DA3->DA3_FROVEI	)) } ) //-- Agregados
oTotaliz:=TRFunction():New(oDocumento:Cell("PDGPAGO" ),"PDGPAGO_3","SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(3,Len(DA3->DA3_FROVEI	)) } ) //-- Agregados
oTotaliz:=TRFunction():New(oDocumento:Cell("RENTAB"  ),"RENTAB_3" ,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(3,Len(DA3->DA3_FROVEI	)) } ) //-- Agregados
oTotaliz:=TRFunction():New(oDocumento:Cell("RENTAB%" ),"RENTAB%_3","AVERAGE",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition( { || (cAliasQry)->DA3_FROVEI == StrZero(3,Len(DA3->DA3_FROVEI	)) } ) //-- Agregados

//-- Secao Totalizadora
oTotal := TRSection():New(oReport,STR0060,{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oTotal:SetHeaderSection()
oTotal:SetPageBreak()
TRCell():New(oTotal,"TEXTO"   ,"   ",STR0060,/*cPicture*/      ,25         ,/*lPixel*/,/*{|| code-block de impressao }*/) // "Total Geral"
TRCell():New(oTotal,"VALFRE"  ,"   ",STR0052,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"FRETCOMP","   ",STR0053,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"DT6_PESO","   ",STR0054,PesqPict("DT6","DT6_PESO"  ),TamSx3("DT6_PESO"  )[1]+TamSx3("DT6_PESO"  )[2],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"FRETPAGO","   ",STR0055,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"PDGPAGO" ,"   ",STR0056,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"RENTAB"  ,"   ",STR0057,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotal,"RENTAB%" ,"   ",STR0058,"@E 9999.99",7,/*lPixel*/,/*{|| code-block de impressao }*/)

TRPosition():New(oCliente ,"SA1",1,{|| xFilial("SA1")+(cAliasQry)->(DT6_CLIDEV+DT6_LOJDEV) })
TRPosition():New(oViagem  ,"DA8",1,{|| xFilial("DA8")+(cAliasQry)->DTQ_ROTA })
TRPosition():New(oViagem  ,"SA2",1,{|| xFilial("SA2")+(cAliasQry)->DTR_CODFOR+(cAliasQry)->DTR_LOJFOR })

Return(oReport)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo de Souza       ³ Data ³ 24/05/06 ³±±
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
Static Function ReportPrint(oReport,cAliasQry,nRent,nRentPerc,nValFre,nFretPago,nPdgPago,cFilDoc,cDocto,cSerie,nFretComp)

Local nCnt     := 0
Local aOrigem  := {}
Local aDestino := {}
Local cOrigem  := ""
Local cDestino := ""
Local cWhere   := ""
Local cWhereDTY:= ""
Local lCalcula := .T.
//-- Operadoras de Frota/Vale-Pedagio
Local cTMSOPdg := SuperGetMV( 'MV_TMSOPDG',, '0' )
Local cSelect := ''
Local cFecht  := ''
Local cGroup  := ''
Local cCodRb3 := ""
Local lTercRbq	:= DTR->(ColumnPos("DTR_CODRB3")) > 0

If mv_par11 == 2 //-- Sintetico
	oReport:Section(1):Section(1):Hide()
	oReport:Section(1):Section(1):Section(1):Hide()
EndIf

//-- Origem
If !Empty(mv_par05)
	If mv_par14 == 1 //-- Sim
		TmsNivInf(mv_par05,@aOrigem)
   	cOrigem += "'" + mv_par05 + "',"
	   If Len(aOrigem) > 0
			For nCnt := 1 To Len(aOrigem)
			   cOrigem += "'" + aOrigem[nCnt][1] + "',"
			Next
		EndIf	
		cOrigem := Substr(cOrigem,1,Len(cOrigem) - 1)
	Else
   	cOrigem += "'" + mv_par05 + "'"
	EndIf
EndIf

//-- Destino
If !Empty(mv_par06)
	If mv_par15 == 1 //-- Sim
		TmsNivInf(mv_par06,@aDestino)
   	cDestino += "'" + mv_par06 + "',"
	   If Len(aDestino) > 0
			For nCnt := 1 To Len(aDestino)
			   cDestino += "'" + aDestino[nCnt][1] + "',"
			Next
		EndIf	
		cDestino := Substr(cDestino,1,Len(cDestino) - 1)
	Else
   	cDestino += "'" + mv_par06 + "'"	
	EndIf
EndIf

//-- Tipos de Documentos permitidos
cDocTms := "'" + StrZero(1,Len(DT6->DT6_DOCTMS)) + "'," //-- Coleta
cDocTms += "'" + StrZero(2,Len(DT6->DT6_DOCTMS)) + "'," //-- CTRC
cDocTms += "'" + StrZero(5,Len(DT6->DT6_DOCTMS)) + "'," //-- Nota Fiscal
cDocTms += "'" + StrZero(6,Len(DT6->DT6_DOCTMS)) + "' " //-- Devolucao

cWhere := "%"
If mv_par12 == 1 //-- Fechada
	cWhere += "     AND DTQ_STATUS = '" + StrZero(5,Len(DTQ->DTQ_STATUS)) + "' "
ElseIf mv_par12 == 2 //-- Em Transito
	cWhere += "     AND DTQ_STATUS = '" + StrZero(2,Len(DTQ->DTQ_STATUS)) + "' "
ElseIf mv_par12 == 3 //-- Chegada Filial
	cWhere += "     AND DTQ_STATUS = '" + StrZero(4,Len(DTQ->DTQ_STATUS)) + "' "
ElseIf mv_par12 == 4 //-- Encerrada
	cWhere += "     AND DTQ_STATUS = '" + StrZero(3,Len(DTQ->DTQ_STATUS)) + "' "
EndIf
If mv_par09 == 1 .Or. mv_par09 == 2 .Or. mv_par09 == 3 //-- Propria / Terceiro / Agregado
	cWhere += "     AND DA3_FROVEI = '" + StrZero(mv_par09,Len(DA3->DA3_FROVEI)) + "' "
ElseIf mv_par09 == 4 //-- Agregado/Terceiro
	cWhere += "     AND DA3_FROVEI BETWEEN '" + StrZero(2,Len(DA3->DA3_FROVEI)) + "' AND '" + StrZero(3,Len(DA3->DA3_FROVEI)) + "' "
EndIf
If !Empty(mv_par05) //-- Origem
	cWhere += "	AND DT6_CDRORI  IN ( "+cOrigem+" )"
Else
	cWhere += " AND DT6_CDRORI BETWEEN '"+Space(Len(DT6->DT6_CDRORI)) +"'AND'"+Replicate("Z",Len(DT6->DT6_CDRORI))+"'"
EndIf
If !Empty(mv_par06) //-- Destino
	cWhere += "	AND DT6_CDRDES  IN ( "+cDestino+" )"
Else
	cWhere += " AND DT6_CDRDES BETWEEN '"+Space(Len(DT6->DT6_CDRDES)) +"'AND'"+Replicate("Z",Len(DT6->DT6_CDRDES))+"'"
EndIf
cWhere += "     AND DT6_DOCTMS IN ( "+cDocTms+" )"
cWhere += "%"

cWhereDTY := "%"
If !Empty(xFilial("DTY"))
	cWhereDTY += " ON DTY_FILIAL = DTQ_FILORI "
Else
	cWhereDTY += " ON DTY_FILIAL = '"+xFilial("DTY")+"' "
EndIf
cWhereDTY += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tratamento para Operadoras de Frota/Vale-Pedagio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSelect := '%'
If cTMSOPdg <> '0'
	cSelect += ',MAX(DTR_CODOPE) DTR_CODOPE '
EndIf
If DTT->(FieldPos("DTT_TIPVIA")) > 0
	cSelect += ',MAX(DTQ_TIPVIA) DTQ_TIPVIA '
EndIf	
cSelect += '%'

If SerieNfId("DUD",3,"DUD_SERIE")=="DUD_SDOC"
	cFecht :='%DUD_SDOC,%'
	cGroup :='%DUD_SDOC,%'
Else
	cFecht :='%%'
	cGroup :='%%'
EndIf

If lTercRbq
	cCodRb3   := "%DTR_CODRB3%"
EndIf 
//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//-- Filtragem do relatório
//-- Query do relatório da secao 1
oReport:Section(1):BeginQuery()	

BeginSql Alias cAliasQry
	SELECT DTQ_FILORI, DTQ_VIAGEM, DUD_FILDOC, DUD_DOC, DUD_SERIE, %Exp:cFecht% MAX(DT6_CLIDEV) DT6_CLIDEV, 
			 MAX(DT6_LOJDEV) DT6_LOJDEV, MAX(DT6_CDRORI) DT6_CDRORI, MAX(DT6_CDRDES) DT6_CDRDES, 
			 MAX(DTQ_DATFEC) DTQ_DATFEC, MAX(DTQ_STATUS) DTQ_STATUS, MAX(DT6_DOCTMS) DT6_DOCTMS, 
			 MAX(DT6_DATEMI) DT6_DATEMI, MAX(DT6_STATUS) DT6_STATUS, MAX(DT6_VALFRE) DT6_VALFRE,
	       MAX(DT6_SERVIC) DT6_SERVIC, MAX(DT6_PESO  ) DT6_PESO  , MAX(DTQ_ROTA  ) DTQ_ROTA  , 
	       MAX(DTR_CODFOR) DTR_CODFOR, MAX(DTR_LOJFOR) DTR_LOJFOR, DTR_CODVEI                ,
	       MAX(DA3_PLACA)  DA3_PLACA , MAX(DTR_VALFRE) DTR_VALFRE, MAX(DTR_VALPDG) DTR_VALPDG, 
	       MAX(DTY_VALFRE) DTY_VALFRE, MAX(DTY_VALPDG) DTY_VALPDG, MAX(DTY_NUMCTC) DTY_NUMCTC,
	       MAX(DTY_DATCTC) DTY_DATCTC, MAX(DT6_QTDVOL) DT6_QTDVOL, MAX(DT6_VALMER) DT6_VALMER, 
	       MAX(DTQ_SERTMS) DTQ_SERTMS, MAX(DTQ_TIPTRA) DTQ_TIPTRA, MAX(DA3_TIPVEI) DA3_TIPVEI, 
	       MAX(DA3_VEIRAS) DA3_VEIRAS, MAX(DTR_CODRB1) DTR_CODRB1, MAX(DTR_CODRB2) DTR_CODRB2,
	       MAX(%Exp:cCodRb3%) %Exp:cCodRb3%, MAX(DA3_FROVEI) DA3_FROVEI, MAX(DTY_VALPRE) DTY_VALPRE, 
	       MAX(DT6_PESOM3) DT6_PESOM3
	       %Exp:cSelect%	       
	   FROM %table:DTQ% DTQ 
	   JOIN %table:DTR% DTR 
	     ON DTR_FILIAL = %xFilial:DTR%
	     AND DTR_FILORI = DTQ_FILORI 
	     AND DTR_VIAGEM = DTQ_VIAGEM 
	     AND DTR.%NotDel%
	   JOIN %table:DA3% DA3 
	     ON DA3_FILIAL = %xFilial:DA3%
	     AND DA3_COD = DTR_CODVEI 
	     AND DA3.%NotDel%
	   JOIN %table:DUD% DUD 
	     ON DUD_FILIAL = %xFilial:DUD%
	     AND DUD_FILORI = DTQ_FILORI 
	     AND DUD_VIAGEM = DTQ_VIAGEM 
	     AND DUD.%NotDel%
	   JOIN %table:DT6% DT6 
	     ON DT6_FILIAL = %xFilial:DT6%
	     AND DT6_FILDOC = DUD_FILDOC 
	     AND DT6_DOC = DUD_DOC 
	     AND DT6_SERIE = DUD_SERIE 
   	  AND DT6_CLIDEV BETWEEN %Exp:mv_par01% AND %Exp:mv_par03%
	 	  AND DT6_LOJDEV BETWEEN %Exp:mv_par02% AND %Exp:mv_par04%
	     AND DT6_CLIDEV <> ' ' 
	     AND DT6_LOJDEV <> ' ' 
		  AND DT6.%NotDel%
	   LEFT JOIN %table:DTY% DTY 
	     %Exp:cWhereDTY%
	     AND DTY_FILORI = DTQ_FILORI
	     AND DTY_VIAGEM = DTQ_VIAGEM 
	     AND DTY.%NotDel%
	   WHERE DTQ_FILIAL = %xFilial:DTQ%
	     AND DTQ_DATFEC BETWEEN %Exp:DToS(mv_par07)% AND %Exp:DToS(mv_par08)%
	     AND DTQ_STATUS BETWEEN %Exp:StrZero(2,Len(DTQ->DTQ_STATUS))% AND %Exp:StrZero(5,Len(DTQ->DTQ_STATUS))%
	     AND DTQ.%NotDel%
        %Exp:cWhere%
	GROUP BY DTQ_FILORI, DTQ_VIAGEM, DUD_FILDOC, DUD_DOC, DUD_SERIE, %Exp:cGroup% DTR_CODVEI 
	ORDER BY DT6_CLIDEV, DT6_LOJDEV, DT6_CDRORI, DT6_CDRDES, DTQ_FILORI, DTQ_VIAGEM, DUD_FILDOC, DUD_DOC, DUD_SERIE, DTR_CODVEI 
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

//-- Inicio da impressao do fluxo do relatório
oReport:SetMeter(DT6->(LastRec()))

oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter( {|cParam| (cAliasQry)->DT6_CLIDEV + (cAliasQry)->DT6_LOJDEV + (cAliasQry)->DT6_CDRORI + (cAliasQry)->DT6_CDRDES == cParam },{|| (cAliasQry)->DT6_CLIDEV + (cAliasQry)->DT6_LOJDEV + (cAliasQry)->DT6_CDRORI + (cAliasQry)->DT6_CDRDES })
oReport:Section(1):Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):Section(1):SetParentFilter( {|cParam| (cAliasQry)->DT6_CLIDEV + (cAliasQry)->DT6_LOJDEV + (cAliasQry)->DT6_CDRORI + (cAliasQry)->DT6_CDRDES == cParam },{|| (cAliasQry)->DT6_CLIDEV + (cAliasQry)->DT6_LOJDEV + (cAliasQry)->DT6_CDRORI + (cAliasQry)->DT6_CDRDES })

DbSelectArea(cAliasQry)
If !(cAliasQry)->(Eof())
	While !oReport:Cancel() .And. !(cAliasQry)->(Eof())
	
		cCliDev := (cAliasQry)->DT6_CLIDEV
		cLojDev := (cAliasQry)->DT6_LOJDEV
		cCdrOri := (cAliasQry)->DT6_CDRORI
		cCdrDes := (cAliasQry)->DT6_CDRDES
	
		//-- Calculo da rentabilidade
		If !TMR440Calc(@nRent,@nRentPerc,@nValFre,@nFretPago,@nPdgPago,@cFilDoc,@cDocto,@cSerie,@nFretComp,@cAliasQry)
			(cAliasQry)->(DbSkip())
			Loop
		Else
			lCalcula := .F.
		EndIf
	
		oReport:Section(1):Init()
		oReport:Section(1):PrintLine()
		While !oReport:Cancel() .And. !(cAliasQry)->(Eof()) .And. (cAliasQry)->DT6_CLIDEV == cCliDev .And. ;
																						(cAliasQry)->DT6_LOJDEV == cLojDev .And. ;
																						(cAliasQry)->DT6_CDRORI == cCdrOri .And. ;
																						(cAliasQry)->DT6_CDRDES == cCdrDes
			//-- Verifica se ja foi efetuado o calculo da rentabilidade
			If lCalcula
				If !TMR440Calc(@nRent,@nRentPerc,@nValFre,@nFretPago,@nPdgPago,@cFilDoc,@cDocto,@cSerie,@nFretComp,@cAliasQry)
					(cAliasQry)->(DbSkip())
					Loop
				EndIf
			EndIf
			lCalcula := .T.
	
			//-- Qdo o tipo de relatorio for Sintetico, devera apenas iniciar a secao de documentos 
			//   para a soma e a secao nao devera ser finalizada para nao pular linha.
			If mv_par11 == 1 //-- Analitico
				oReport:Section(1):Section(1):Init()
				oReport:Section(1):Section(1):PrintLine()
			EndIf

			oReport:Section(1):Section(1):Section(1):Init()
			oReport:Section(1):Section(1):Section(1):PrintLine()

			If mv_par11 == 1 //-- Analitico
				oReport:Section(1):Section(1):Section(1):Finish()
				oReport:Section(1):Section(1):Finish()
			EndIf
	
			(cAliasQry)->(DbSkip())
		EndDo
		oReport:Section(1):Finish()
	EndDo
	
	//-- Impressao dos totalizadores
	oReport:Section(2):Init()
	
	oReport:Section(2):Cell("TEXTO"   ):SetValue(STR0061) // "Total Proprios"
	oReport:Section(2):Cell("VALFRE"  ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("VALFRE_1"   ):ReportValue())
	oReport:Section(2):Cell("FRETCOMP"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("FRETCOMP_1" ):ReportValue())
	oReport:Section(2):Cell("DT6_PESO"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("DT6_PESO_1" ):ReportValue())
	oReport:Section(2):Cell("FRETPAGO"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("FRETPAGO_1" ):ReportValue())
	oReport:Section(2):Cell("PDGPAGO" ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("PDGPAGO_1"  ):ReportValue())
	oReport:Section(2):Cell("RENTAB"  ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("RENTAB_1"   ):ReportValue())
	oReport:Section(2):Cell("RENTAB%" ):SetValue((oReport:Section(2):Cell("RENTAB"):UValue / ( oReport:Section(2):Cell("VALFRE"):UValue + oReport:Section(2):Cell("FRETCOMP"):UValue ))*100)
	oReport:Section(2):PrintLine()	

	oReport:Section(2):Cell("TEXTO"   ):SetValue(STR0062) // "Total Terceiros"
	oReport:Section(2):Cell("VALFRE"  ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("VALFRE_2"   ):ReportValue())
	oReport:Section(2):Cell("FRETCOMP"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("FRETCOMP_2" ):ReportValue())
	oReport:Section(2):Cell("DT6_PESO"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("DT6_PESO_2" ):ReportValue())
	oReport:Section(2):Cell("FRETPAGO"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("FRETPAGO_2" ):ReportValue())
	oReport:Section(2):Cell("PDGPAGO" ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("PDGPAGO_2"  ):ReportValue())
	oReport:Section(2):Cell("RENTAB"  ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("RENTAB_2"   ):ReportValue())
	oReport:Section(2):Cell("RENTAB%" ):SetValue((oReport:Section(2):Cell("RENTAB"):UValue / ( oReport:Section(2):Cell("VALFRE"):UValue + oReport:Section(2):Cell("FRETCOMP"):UValue ))*100)
	oReport:Section(2):PrintLine()	

	oReport:Section(2):Cell("TEXTO"   ):SetValue(STR0063) // "Total Agregados"
	oReport:Section(2):Cell("VALFRE"  ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("VALFRE_3"   ):ReportValue())
	oReport:Section(2):Cell("FRETCOMP"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("FRETCOMP_3" ):ReportValue())
	oReport:Section(2):Cell("DT6_PESO"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("DT6_PESO_3" ):ReportValue())
	oReport:Section(2):Cell("FRETPAGO"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("FRETPAGO_3" ):ReportValue())
	oReport:Section(2):Cell("PDGPAGO" ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("PDGPAGO_3"  ):ReportValue())
	oReport:Section(2):Cell("RENTAB"  ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("RENTAB_3"   ):ReportValue())
	oReport:Section(2):Cell("RENTAB%" ):SetValue((oReport:Section(2):Cell("RENTAB"):UValue / ( oReport:Section(2):Cell("VALFRE"):UValue + oReport:Section(2):Cell("FRETCOMP"):UValue ))*100)
	oReport:Section(2):PrintLine()	

	oReport:ThinLine()
	oReport:SkipLine(2)
	oReport:Section(2):Cell("TEXTO"   ):SetValue(STR0060) // "Total Geral"
	oReport:Section(2):Cell("VALFRE"  ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("VALFRE_1"   ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("VALFRE_2"   ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("VALFRE_3"   ):ReportValue())
	oReport:Section(2):Cell("FRETCOMP"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("FRETCOMP_1" ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("FRETCOMP_2" ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("FRETCOMP_3" ):ReportValue())
	oReport:Section(2):Cell("DT6_PESO"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("DT6_PESO_1" ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("DT6_PESO_2" ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("DT6_PESO_3" ):ReportValue())
	oReport:Section(2):Cell("FRETPAGO"):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("FRETPAGO_1" ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("FRETPAGO_2" ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("FRETPAGO_3" ):ReportValue())
	oReport:Section(2):Cell("PDGPAGO" ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("PDGPAGO_1"  ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("PDGPAGO_2"  ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("PDGPAGO_3"  ):ReportValue())
	oReport:Section(2):Cell("RENTAB"  ):SetValue(oReport:Section(1):Section(1):Section(1):GetFunction("RENTAB_1"   ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("RENTAB_2"   ):ReportValue()+oReport:Section(1):Section(1):Section(1):GetFunction("RENTAB_3"   ):ReportValue())
	oReport:Section(2):Cell("RENTAB%" ):SetValue((oReport:Section(2):Cell("RENTAB"):UValue / ( oReport:Section(2):Cell("VALFRE"):UValue + oReport:Section(2):Cell("FRETCOMP"):UValue ))*100)

	oReport:Section(2):PrintLine()	

	oReport:Section(2):Finish()
EndIf

TMR440Tot(,,.T.) //-- zera variavel controladora do totalizador

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMR440Tot ³ Autor ³Eduardo de Souza       ³ Data ³ 01/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Controla o totalizador do percentual da rentabilidade      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³ExpC1: Quebra do totalizador                                ³±±
±±³          ³ExpL1: Zera variaveis                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR420                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMR440Tot(oReport,cQuebra,lZera)

Static cQbr    := ''
Static lQuebra := .T.
Local nValor   := 0
Local nValMer  := 0
Local nFreComp := 0
Local nRent    := 0
Default lZera  := .F.

If lZera
	nValMer := 0
	cQbr    := ''
	lQuebra := .T.
Else
	If lQuebra .And. cQbr <> cQuebra
		nValMer  := oReport:Section(1):GetFunction("VALFRE"  ):SectionValue()
		nFreComp := oReport:Section(1):GetFunction("FRETCOMP"):SectionValue()
		nRent    := oReport:Section(1):GetFunction("RENTAB"  ):SectionValue()
		nValor := nRent / ( nValMer + nFreComp ) * 100
	EndIf
	lQuebra := .T.
EndIf

Return nValor


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMR440StDc³ Autor ³ Eduardo de Souza      ³ Data ³ 31/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o status do documento                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR440                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMR440StDc(cSerTms,cFilDoc,cDocto,cSerie,cStatDoc)

Local cStatus  := ''
Local aRetBox1 := {}

If cSerTms == StrZero(1,Len(DTQ->DTQ_SERTMS)) //-- Coleta
	aRetBox1 := RetSx3Box( Posicione('SX3', 2, 'DT5_STATUS', 'X3CBox()' ),,, 1 )
	cStatus  := Posicione("DT5",4,xFilial("DT5")+cFilDoc+cDocto+cSerie,"DT5_STATUS")
	cStatus  := AllTrim( aRetBox1[ Ascan( aRetBox1, { |x| x[ 2 ] == 	cStatus } ), 3 ])
Else
	aRetBox1 := RetSx3Box( Posicione('SX3', 2, 'DT6_STATUS', 'X3CBox()' ),,, 1 )
	cStatus  := AllTrim( aRetBox1[ Ascan( aRetBox1, { |x| x[ 2 ] == cStatDoc} ), 3 ])
EndIf

Return cStatus

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMR440Calc³ Autor ³ Eduardo de Souza      ³ Data ³ 31/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calculo da rentabilidade                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR440                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMR440Calc(nRent,nRentPerc,nValFre,nFretPago,nPdgPago,cFilDoc,cDocto,cSerie,nFretComp,cAliasQry)

Local cChave   := ""
Local aFretCar := {}
Local nQtdVg   := 0
Local aDocto   := {}
Local aDadosViag  := {}
Local nValFreViag := 0
Local lContinua   := .T.
//-- Operadoras de Frota/Vale-Pedagio
Local cTMSOPdg := SuperGetMV( 'MV_TMSOPDG',, '0' )
Local lTercRbq	:= DTR->(ColumnPos("DTR_CODRB3")) > 0

cFilDoc      := " "
cDocto       := " "
cSerie       := " "

//-- Verifica se existe Conhecimento em viagem para a Solicitacao.
If (cAliasQry)->DTQ_SERTMS == StrZero(1,Len(DTQ->DTQ_SERTMS)) //-- Coleta
	aDocto := TMSR440SCtr((cAliasQry)->DUD_FILDOC,(cAliasQry)->DUD_DOC,(cAliasQry)->DUD_SERIE)
	If !Empty(aDocto)
		If !Empty(aDocto[1]) //-- Viagem
			lContinua := .F.
		Else
			cFilDoc      := aDocto[2]
			cDocto       := aDocto[3]
			cSerie       := aDocto[4]
			nValFre      := aDocto[5]
			nFretComp    := TMSR440Doc(cFilDoc,cDocto,cSerie)
		EndIf
	EndIf
EndIf

//-- Retorna a somatoria do valor do frete de todos documentos relacionados.
//   (Original, Complemento, Devolucao, Reentrega)			
If lContinua

	If Empty(cDocto) //-- Valor do frete do documento gerado.
		nValFre    := (cAliasQry)->DT6_VALFRE
		nFretComp  := TMSR440Doc((cAliasQry)->DUD_FILDOC,(cAliasQry)->DUD_DOC,(cAliasQry)->DUD_SERIE)
	EndIf
	
	//-- Retorna os dados da viagem
	aDadosViag  := TMSR440Viag((cAliasQry)->DTQ_FILORI,(cAliasQry)->DTQ_VIAGEM)
	If mv_par16 <> 1 //-- Considera somente a viagem
		nValFreViag := TMR440ValVge((cAliasQry)->DTQ_FILORI,(cAliasQry)->DTQ_VIAGEM,(cAliasQry)->DUD_FILDOC,(cAliasQry)->DUD_DOC,(cAliasQry)->DUD_SERIE,(cAliasQry)->DTQ_SERTMS)
	EndIf
	
	//-- Imprime dados do contrato
	If !Empty((cAliasQry)->DTY_NUMCTC)
		nFretPago  := (cAliasQry)->DTY_VALFRE + (cAliasQry)->DTY_VALPRE
		nPdgPago   := (cAliasQry)->DTY_VALPDG
	Else
		nFretPago := (cAliasQry)->DTR_VALFRE
		nPdgPago  := (cAliasQry)->DTR_VALPDG
		//-- Qdo o valor do frete estiver zerado, calcula o frete.
		If nFretPago == 0
			cChave 	:= (cAliasQry)->DA3_TIPVEI	
			If DA3->(MsSeek(xFilial('DA3')+(cAliasQry)->DTR_CODRB1))
				cChave+= DA3->DA3_FROVEI
			Else
				cChave+= StrZero(0, Len(DA3->DA3_FROVEI))
			EndIf
			If DA3->(MsSeek(xFilial('DA3')+(cAliasQry)->DTR_CODRB2))
				cChave+= DA3->DA3_FROVEI
			Else
				cChave+= StrZero(0, Len(DA3->DA3_FROVEI))
			EndIf
			If lTercRbq
				If DA3->(MsSeek(xFilial('DA3')+(cAliasQry)->DTR_CODRB3))
					cChave+= DA3->DA3_FROVEI
				Else
					cChave+= StrZero(0, Len(DA3->DA3_FROVEI))
				EndIf
			EndIf
			cChave += (cAliasQry)->DA3_VEIRAS
     		If DTT->(FieldPos("DTT_TIPVIA")) > 0
	     		cChave += (cAliasQry)->DTQ_TIPVIA
	     	EndIf

			//-- Calculo do Frete
	   	aFretCar := TMSFretCar((cAliasQry)->DTQ_ROTA, (cAliasQry)->DTR_CODFOR, (cAliasQry)->DTR_LOJFOR,,cChave,;
                                (cAliasQry)->DTQ_SERTMS,(cAliasQry)->DTQ_TIPTRA,,,IIF(cTMSOPdg <> '0', (cAliasQry)->DTR_CODOPE, ''), .F.)
                                
			If !Empty(aFretCar)
				nFretPago := aFretCar[2]
			EndIf
	 	EndIf
	EndIf
	
	//-- Rateia o Frete pela quantidade de viagens.
	nQtdVg := TMSR440QtVg((cAliasQry)->DUD_FILDOC,(cAliasQry)->DUD_DOC,(cAliasQry)->DUD_SERIE,cFilDoc,cDocto,cSerie)
	nValFre := ( nValFre / nQtdVg ) + nValFreViag
	
	//-- Rateio do Frete
	If mv_par16 <> 1 //-- Quantidade de Viagens
		If mv_par13 == 1 //-- Quantidade de Documentos
			nValfre   := nValFre   / aDadosViag[1]
			nFretComp := nFretComp / aDadosViag[1]
			nFretPago := nFretPago / aDadosViag[1]
			nPdgPago  := nPdgPago  / aDadosViag[1]
		ElseIf mv_par13 == 2 //-- Peso
			nValFre   := ( nValFre   * (cAliasQry)->DT6_PESO ) / aDadosViag[2]
			nFretComp := ( nFretComp * (cAliasQry)->DT6_PESO ) / aDadosViag[2]
			nFretPago := ( nFretPago * (cAliasQry)->DT6_PESO ) / aDadosViag[2]
			nPdgPago  := ( nPdgPago  * (cAliasQry)->DT6_PESO ) / aDadosViag[2]
		ElseIf mv_par13 == 3 //-- Volume
			nValFre   := ( nValFre   * (cAliasQry)->DT6_QTDVOL ) / aDadosViag[3]
			nFretComp := ( nFretComp * (cAliasQry)->DT6_QTDVOL ) / aDadosViag[3]
			nFretPago := ( nFretPago * (cAliasQry)->DT6_QTDVOL ) / aDadosViag[3]
			nPdgPago  := ( nPdgPago  * (cAliasQry)->DT6_QTDVOL ) / aDadosViag[3]
		ElseIf mv_par13 == 4 //-- Valor
			nValFre   := ( nValFre   * (cAliasQry)->DT6_VALMER ) / aDadosViag[4]
			nFretComp := ( nFretComp * (cAliasQry)->DT6_VALMER ) / aDadosViag[4]
			nFretPago := ( nFretPago * (cAliasQry)->DT6_VALMER ) / aDadosViag[4]
			nPdgPago  := ( nPdgPago  * (cAliasQry)->DT6_VALMER ) / aDadosViag[4]
		ElseIf mv_par13 == 5 //-- Peso Cubado
			nValFre   := ( nValFre   * (cAliasQry)->DT6_PESOM3 ) / aDadosViag[5]
			nFretComp := ( nFretComp * (cAliasQry)->DT6_PESOM3 ) / aDadosViag[5]
			nFretPago := ( nFretPago * (cAliasQry)->DT6_PESOM3 ) / aDadosViag[5]
			nPdgPago  := ( nPdgPago  * (cAliasQry)->DT6_PESOM3 ) / aDadosViag[5]		
		EndIf
	EndIf
	
	//-- Rentabilidade
	nRent      := ((nValFre + nFretComp) - nFretPago - nPdgPago)
	nRentPerc  := ( nRent / (nValFre + nFretComp) ) * 100

	//-- Verifica a Rentabilidade
	If mv_par10 == 1 //-- Somente Positiva
		If nRent <= 0
			lContinua := .F.
		EndIf
	ElseIf mv_par10 == 2 //-- Somente Negativa
		If nRent > 0
			lContinua := .F.
		EndIf		
	EndIf
EndIf

Return lContinua

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TMSR440Viag³ Autor ³Eduardo de Souza      ³ Data ³ 29/09/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna qtd.doctos,peso,volume,valor merc. total da viagem ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMSR440Viag(ExpC1,ExpC2)                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 - Filial Origem da Viagem                            ³±±
±±³          ³ ExpC2 - Viagem                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMSR440                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMSR440Viag(cFilOri,cViagem)

Local cQuery     := ""
Local cAliasTRB1 := ""
Local nQtdDoc    := 0
Local nPeso      := 0
Local nQtdVol    := 0
Local nValMer    := 0
Local nPesoM3	  := 0

cAliasTRB1 := GetNextAlias()
cQuery := " SELECT "
cQuery += "   COUNT(DTQ.DTQ_FILORI) QTDDOC, SUM(DT6.DT6_PESO) PESO , SUM(DT6.DT6_QTDVOL) QTDVOL , SUM(DT6.DT6_VALMER) VALMER, "
cQuery += "		  SUM(DT6.DT6_PESOM3) PESOM3 "
cQuery += "   FROM " + RetSqlName("DTQ") + " DTQ "
cQuery += "   JOIN " + RetSqlName("DUD") + " DUD "
cQuery += "     ON  DUD.DUD_FILIAL = '" + xFilial("DUD") + "' "
cQuery += "     AND DUD.DUD_FILORI = DTQ.DTQ_FILORI "
cQuery += "     AND DUD.DUD_VIAGEM = DTQ.DTQ_VIAGEM "
cQuery += "     AND DUD.D_E_L_E_T_ = ' ' "
cQuery += "   JOIN " + RetSqlName("DT6") + " DT6 "
cQuery += "     ON  DT6.DT6_FILIAL = '" + xFilial("DT6") + "' "
cQuery += "     AND DT6.DT6_FILDOC = DUD.DUD_FILDOC "
cQuery += "     AND DT6.DT6_DOC    = DUD.DUD_DOC "
cQuery += "     AND DT6.DT6_SERIE  = DUD.DUD_SERIE "
cQuery += "     AND DT6.D_E_L_E_T_ = ' ' "
cQuery += "   WHERE DTQ.DTQ_FILIAL = '" + xFilial("DTQ") + "' "
cQuery += "     AND DTQ.DTQ_FILORI = '" + cFilOri + "' "
cQuery += "     AND DTQ.DTQ_VIAGEM = '" + cViagem + "' "
cQuery += "     AND DTQ.D_E_L_E_T_ = ' ' "
cQuery += "     AND NOT EXISTS ( "
cQuery += "     		SELECT 1 "
cQuery += "   			  FROM " + RetSqlName("DTC") + " DTC  "
cQuery += "   			  JOIN " + RetSqlName("DUD") + " DUD1 "
cQuery += "   			    ON DUD1.DUD_FILIAL = '" + xFilial("DUD") + "' "
cQuery += "   			    AND DUD1.DUD_FILDOC = DTC_FILDOC "
cQuery += "   			    AND DUD1.DUD_DOC    = DTC_DOC "
cQuery += "   			    AND DUD1.DUD_SERIE  = DTC_SERIE "
cQuery += "   			    AND DUD1.D_E_L_E_T_ = ' ' "
cQuery += "   			  JOIN " + RetSqlName("DTQ") + " DTQ "
cQuery += "   			    ON DTQ_FILIAL = '" + xFilial("DTQ") + "' "
cQuery += "   			    AND DTQ_FILORI = DUD1.DUD_FILORI "
cQuery += "   			    AND DTQ_VIAGEM = DUD1.DUD_VIAGEM "
cQuery += "   			    AND DTQ_STATUS <> '" + StrZero(1,Len(DTQ->DTQ_STATUS)) + "' "
cQuery += "   			    AND DTQ.D_E_L_E_T_ = ' ' "
cQuery += "   			  WHERE DTC.DTC_FILIAL = '" + xFilial("DTC") + "' "
cQuery += "   			    AND DTC_FILORI = DUD.DUD_FILDOC "
cQuery += "   			    AND DTC_NUMSOL = DUD.DUD_DOC "
cQuery += "   			    AND DTC.D_E_L_E_T_ = ' ' ) "
cQuery := ChangeQuery(cQuery)
dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasTRB1, .F., .T.)

If (cAliasTRB1)->(!Eof())
	nQtdDoc := (cAliasTRB1)->QTDDOC
	nPeso   := (cAliasTRB1)->PESO
	nQtdVol := (cAliasTRB1)->QTDVOL
	nValMer := (cAliasTRB1)->VALMER
	nPesoM3 := (cAliasTRB1)->PESOM3
EndIf
(cAliasTRB1)->(DbCloseArea())

Return { nQtdDoc, nPeso, nQtdVol, nValMer, nPesoM3 }

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TMSR440Doc³ Autor ³Eduardo de Souza       ³ Data ³ 29/09/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna valor dos documentos gerados a partir do original. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMSR440Doc(ExpC1,ExpC2,ExpC3)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 - Filial do Documento                                ³±±
±±³          ³ ExpC2 - Documento                                          ³±±
±±³          ³ ExpC3 - Serie do Documento                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMSR440                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMSR440Doc(cFilDoc,cDocto,cSerie)

Local cAliasTRB1 := ""
Local nValFre    := 0
Local cQuery     := ""

cAliasTRB1 := GetNextAlias()
cQuery := " SELECT "
cQuery += "   SUM(DT6_VALFRE) VALFRE "
cQuery += "   FROM " + RetSqlName("DT6")
cQuery += "   WHERE DT6_FILIAL =  '" + xFilial("DT6") + "' "
cQuery += "     AND DT6_FILDCO =  '" + cFilDoc + "' "
cQuery += "     AND DT6_DOCDCO =  '" + cDocto  + "' "
cQuery += "     AND DT6_SERDCO =  '" + cSerie  + "' "
cQuery += "     AND DT6_DOCTMS <> '" + StrZero(6,Len(DT6->DT6_DOCTMS)) + "' "
cQuery += "     AND D_E_L_E_T_ = ' ' "

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasTRB1, .F., .T.)

If (cAliasTRB1)->(!Eof())
	nValFre := (cAliasTRB1)->VALFRE
EndIf
(cAliasTRB1)->(DbCloseArea())

Return nValFre

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TMSR440SCtr³ Autor ³Eduardo de Souza      ³ Data ³ 29/09/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o conhecimento da solicitacao.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMSR440SCtr(ExpC1,ExpC2,ExpC3)                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 - Filial do Documento                                ³±±
±±³          ³ ExpC2 - Documento                                          ³±±
±±³          ³ ExpC3 - Serie do Documento                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMSR440                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMSR440SCtr(cFilDoc,cDocto,cSerie)

Local cAliasTRB1 := ''
Local cQuery     := ""
Local aDocto     := {}

cAliasTRB1 := GetNextAlias()

cQuery := " SELECT "
cQuery += "   DUD_FILORI FILORI, DUD_VIAGEM VIAGEM, DUD_FILDOC FILDOC, "
cQuery += "   DUD_DOC DOC      , DUD_SERIE SERIE  , DT6_VALFRE VALFRE, "
cQuery += "   DT6_PESO PESO    , DT6_QTDVOL QTDVOL, DT6_VALMER VALMER  "
cQuery += "   FROM "
cQuery += RetSqlName("DT5") + " DT5, "
cQuery += RetSqlName("DTC") + " DTC, "
cQuery += RetSqlName("DUD") + " DUD, "
cQuery += RetSqlName("DT6") + " DT6 "
cQuery += "   WHERE DT5.DT5_FILIAL = '" + xFilial("DT5") + "' "
cQuery += "     AND DT5.DT5_FILDOC = '" + cFilDoc + "' "
cQuery += "     AND DT5.DT5_DOC    = '" + cDocto  + "' "
cQuery += "     AND DT5.DT5_SERIE  = '" + cSerie  + "' "
cQuery += "     AND DT5.D_E_L_E_T_ = ' ' "
cQuery += "     AND DTC.DTC_FILIAL = '" + xFilial("DTC") + "' "
cQuery += "     AND DTC.DTC_FILORI = DT5.DT5_FILORI "
cQuery += "     AND DTC.DTC_NUMSOL = DT5.DT5_NUMSOL "
cQuery += "     AND DTC.D_E_L_E_T_ = ' ' "
cQuery += "     AND DUD.DUD_FILIAL = '" + xFilial("DUD") + "' "
cQuery += "     AND DUD.DUD_FILDOC = DTC.DTC_FILDOC "
cQuery += "     AND DUD.DUD_DOC    = DTC.DTC_DOC "
cQuery += "     AND DUD.DUD_SERIE  = DTC.DTC_SERIE "
cQuery += "     AND DUD.D_E_L_E_T_ = ' ' "
cQuery += "     AND DT6.DT6_FILIAL = '" + xFilial("DT6") + "' "
cQuery += "     AND DT6.DT6_FILDOC = DUD.DUD_FILDOC "
cQuery += "     AND DT6.DT6_DOC    = DUD.DUD_DOC "
cQuery += "     AND DT6.DT6_SERIE  = DUD.DUD_SERIE "
cQuery += "     AND DT6.D_E_L_E_T_ = ' ' "
cQuery := ChangeQuery(cQuery)
dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasTRB1, .F., .T.)

If (cAliasTRB1)->(!Eof())
	If !Empty((cAliasTRB1)->VIAGEM)
		cStatus := Posicione("DTQ",2,xFilial("DTQ")+(cAliasTRB1)->FILORI+(cAliasTRB1)->VIAGEM,"DTQ_STATUS")
		If cStatus <> StrZero(1,Len(DTQ->DTQ_STATUS)) .And. cStatus <> StrZero(9,Len(DTQ->DTQ_STATUS)) //-- Em Aberto ### Cancelado
			aDocto := { (cAliasTRB1)->VIAGEM, (cAliasTRB1)->FILDOC, (cAliasTRB1)->DOC, (cAliasTRB1)->SERIE, (cAliasTRB1)->VALFRE , ;
			(cAliasTRB1)->PESO , (cAliasTRB1)->QTDVOL, (cAliasTRB1)->VALMER }
		Else
			aDocto := { Space(Len(DTQ->DTQ_STATUS)) , (cAliasTRB1)->FILDOC, (cAliasTRB1)->DOC, (cAliasTRB1)->SERIE, (cAliasTRB1)->VALFRE ,;
			(cAliasTRB1)->PESO , (cAliasTRB1)->QTDVOL, (cAliasTRB1)->VALMER }
		EndIf
	Else
		aDocto := { Space(Len(DTQ->DTQ_STATUS)) , (cAliasTRB1)->FILDOC, (cAliasTRB1)->DOC, (cAliasTRB1)->SERIE, (cAliasTRB1)->VALFRE ,;
		(cAliasTRB1)->PESO , (cAliasTRB1)->QTDVOL, (cAliasTRB1)->VALMER }
	EndIf
EndIf

(cAliasTRB1)->(DbCloseArea())

Return aDocto

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TMSR440QtVg³ Autor ³Eduardo de Souza      ³ Data ³ 16/02/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna a quantidade de viagens do documento.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMSR440QtVg(ExpC1,ExpC2,ExpC3,ExpC4,ExpC5,ExpC6)           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 - Filial do Documento                                ³±±
±±³          ³ ExpC2 - Documento                                          ³±±
±±³          ³ ExpC3 - Serie do Documento                                 ³±±
±±³          ³ ExpC4 - Filial do Documento Frete                          ³±±
±±³          ³ ExpC5 - Documento Frete                                    ³±±
±±³          ³ ExpC6 - Serie do Documento Frete                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMSR440                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMSR440QtVg(cFilDoc,cDocto,cSerie,cFilDocFre,cDoctoFre,cSerieFre)

Local cAliasTRB1 := ""
Local cQuery     := ""
Local nQtdVg     := 0

cAliasTRB1 := GetNextAlias()
cQuery := " SELECT COUNT(*) QTDVG "
cQuery += "  FROM ( "
cQuery += " SELECT DUD_FILORI, DUD_VIAGEM "
cQuery += "  FROM ( "
cQuery += "    SELECT DUD_FILORI, DUD_VIAGEM "
cQuery += "      FROM " + RetSqlName("DT6") + " DT6 "
cQuery += "      JOIN " + RetSqlName("DTC") + " DTC "
cQuery += "        ON  DTC_FILIAL = '" + xFilial("DTC") + "' "
cQuery += "        AND DTC_FILDOC = DT6_FILDOC "
cQuery += "        AND DTC_DOC    = DT6_DOC "
cQuery += "        AND DTC_SERIE  = DT6_SERIE "
cQuery += "        AND DTC.D_E_L_E_T_ = ' ' "
cQuery += "      JOIN " + RetSqlName("DT5") + " DT5 "
cQuery += "        ON  DT5_FILIAL = '" + xFilial("DT5") + "' "
cQuery += "        AND DT5_FILORI = DTC_FILORI "
cQuery += "        AND DT5_NUMSOL = DTC_NUMSOL "
cQuery += "        AND DT5.D_E_L_E_T_ = ' ' "
cQuery += "      JOIN " + RetSqlName("DUD") + " DUD "
cQuery += "        ON  DUD_FILIAL = '" + xFilial("DUD") + "' "
cQuery += "        AND DUD_FILDOC = DT5_FILDOC "
cQuery += "        AND DUD_DOC    = DT5_DOC "
cQuery += "        AND DUD_SERIE  = DT5_SERIE "
cQuery += "        AND DUD_VIAGEM <> ' ' "
cQuery += "        AND DUD.D_E_L_E_T_ = ' ' "
cQuery += "      WHERE DT6_FILIAL = '" + xFilial("DT6") + "' "
cQuery += "        AND DT6_FILDOC = '" + cFilDocFre + "' "
cQuery += "        AND DT6_DOC    = '" + cDoctoFre  + "' "
cQuery += "        AND DT6_SERIE  = '" + cSerieFre  + "' "
cQuery += "        AND DT6.D_E_L_E_T_ = ' ' "
cQuery += "    UNION ALL "
cQuery += "    SELECT DUD_FILORI, DUD_VIAGEM "
cQuery += "      FROM " + RetSqlName("DT6") + " DT6 "
cQuery += "      JOIN " + RetSqlName("DUD") + " DUD "
cQuery += "        ON  DUD_FILIAL = '" + xFilial("DUD") + "' "
cQuery += "        AND DUD_FILDOC = DT6_FILDOC "
cQuery += "        AND DUD_DOC    = DT6_DOC "
cQuery += "        AND DUD_SERIE  = DT6_SERIE "
cQuery += "        AND DUD_VIAGEM <> ' ' "
cQuery += "        AND DUD.D_E_L_E_T_ = ' ' "
cQuery += "      WHERE DT6_FILIAL = '" + xFilial("DT6") + "' "
cQuery += "        AND DT6_FILDOC = '" + cFilDoc + "' "
cQuery += "        AND DT6_DOC    = '" + cDocto  + "' "
cQuery += "        AND DT6_SERIE  = '" + cSerie  + "' "
cQuery += "        AND DT6.D_E_L_E_T_ = ' ' ) QUERY1 "
cQuery += "    GROUP BY DUD_FILORI, DUD_VIAGEM ) QUERY2"

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasTRB1, .F., .T.)

If (cAliasTRB1)->(!Eof())
	nQtdVg := (cAliasTRB1)->QTDVG
EndIf
(cAliasTRB1)->(DbCloseArea())

Return nQtdVg

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TMR440ValVge³ Autor ³Eduardo de Souza     ³ Data ³ 18/11/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o valor total da viagem                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMR440ValVge(ExpC1,ExpC2,ExpC3,ExpC4,ExpC5,ExpC6)          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 - Filial Origem da Viagem                            ³±±
±±³          ³ ExpC2 - Viagem                                             ³±±
±±³          ³ ExpC3 - Filial Documento                                   ³±±
±±³          ³ ExpC4 - Documento                                          ³±±
±±³          ³ ExpC5 - Serie                                              ³±±
±±³          ³ ExpC6 - Servico do Transporte                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMSR440                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMR440ValVge(cFilOri,cViagem,cFil,cDoc,cSer,cSerTms)

Local cQuery     := ""
Local cAliasTRB1 := ""
Local nValFre    := 0
Local cFilDoc    := ""
Local cDocto     := ""
Local cSerie     := ""
Local nQtdVg     := 0
Local nValTot    := 0

cAliasTRB1 := GetNextAlias()
cQuery := " SELECT DUD_FILDOC, DUD_DOC, DUD_SERIE, DT6_VALFRE "
cQuery += "   FROM " + RetSqlName("DUD") + " DUD "
cQuery += "   JOIN " + RetSqlName("DT6") + " DT6 "
cQuery += "     ON  DT6_FILIAL = '" + xFilial("DT6") + "' "
cQuery += "     AND DT6_FILDOC = DUD_FILDOC "
cQuery += "     AND DT6_DOC    = DUD_DOC "
cQuery += "     AND DT6_SERIE  = DUD_SERIE "
cQuery += "     AND DT6.D_E_L_E_T_ = ' ' "
cQuery += "   WHERE DUD_FILIAL = '" + xFilial("DUD") + "' "
cQuery += "     AND DUD_FILORI = '" + cFilOri + "' "
cQuery += "     AND DUD_VIAGEM = '" + cViagem + "' "
cQuery += "     AND DUD.D_E_L_E_T_ = ' ' "
cQuery := ChangeQuery(cQuery)
dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasTRB1, .F., .T.)

While (cAliasTRB1)->(!Eof())
	If (cAliasTRB1)->DUD_FILDOC + (cAliasTRB1)->DUD_DOC + (cAliasTRB1)->DUD_SERIE <> cFil + cDoc+ cSer
		//-- Verifica se existe Conhecimento em viagem para a Solicitacao.
		If cSerTms == StrZero(1,Len(DTQ->DTQ_SERTMS)) //-- Coleta
			aDocto := TMSR440SCtr((cAliasTRB1)->DUD_FILDOC,(cAliasTRB1)->DUD_DOC,(cAliasTRB1)->DUD_SERIE)
			If !Empty(aDocto)
				If !Empty(aDocto[1]) //-- Viagem
					(cAliasTRB1)->(DbSkip())
					Loop
				Else
					cFilDoc      := aDocto[2]
					cDocto       := aDocto[3]
					cSerie       := aDocto[4]
					nValFre      := aDocto[5]
				EndIf
			EndIf
		Else
			nValFre := (cAliasTRB1)->DT6_VALFRE
		EndIf
		//-- Rateia o Frete pela quantidade de viagens.
		nQtdVg  := TMSR440QtVg((cAliasTRB1)->DUD_FILDOC,(cAliasTRB1)->DUD_DOC,(cAliasTRB1)->DUD_SERIE,cFilDoc,cDocto,cSerie)
		nValFre := nValFre / nQtdVg
		nValTot += nValFre
	EndIf
	(cAliasTRB1)->(DbSkip())
EndDo
(cAliasTRB1)->(DbCloseArea())

Return nValTot
