/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR550.CH"
#INCLUDE "PROTHEUS.CH"

Static aRetBox  := RetSx3Box( Posicione('SX3', 2, 'AAM_TIPFRE', 'X3CBox()' ),,, Len(AAM->AAM_TIPFRE) )

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR550  ³ Autor ³ Eduardo de Souza      ³ Data ³ 30/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Emissao do Clientes sem movimento                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR550(lTela,aContrt)

Local oReport
Local aArea := GetArea()

DEFAULT lTela   := .T.
DEFAULT aContrt := {}

//-- Interface de impressao
oReport := ReportDef(aContrt)
oReport:PrintDialog()

RestArea( aArea )

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Eduardo de Souza      ³ Data ³ 30/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR550                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef(aContrt)

Local oReport
Local cAliasQry := GetNextAlias()
Local aOrdem    := {}
Local aAreaSM0  := SM0->(GetArea())
Local nOrdem    := 1
Local nTotalCli := 1
Local nQtdMes   := {}
Local aRelato   := {}
Local aRelTot   := {}
Local nCount1   := 0
Local nPosTot   := 0

DEFAULT aContrt := {}

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
oReport:= TReport():New("TMSR550",STR0014,"TMA990", {|oReport| ReportPrint(oReport,cAliasQry,nQtdMes,aRelato,@nCount1,aRelTot,@nPosTot,aContrt)},STR0015) // 'Clientes sem movimento' ### 'Este programa ira imprimir o relatorio de clientes sem movimento.'
oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

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
Aadd( aOrdem, STR0016 ) // "Filial"

oFilial:= TRSection():New(oReport,STR0016,{},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
TRCell():New(oFilial,"M0_CODFIL","SM0",STR0016,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oFilial,"M0_CIDENT","SM0",STR0017,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oFilial,"M0_ESTENT","SM0",STR0018,/*Picture*/, 2,/*lPixel*/,/*{|| code-block de impressao }*/)

oCliente:= TRSection():New(oFilial,STR0019,{},/*Ordem do relatorio*/,/*Campos do SX3*/,/*Campos do SIX*/)
oCliente:lReadOnly := .T. //Se retirar este comando desposiciona os totalizadores
TRCell():New(oCliente,"SEQUEN"  ,"",STR0020,"@E 999999"         ,6 /*Tamanho*/,/*lPixel*/, {|| nOrdem++ },,,,,,.T.)
TRCell():New(oCliente,"CLIENTE" ,"",STR0021,/*Picture*/         ,15/*Tamanho*/,/*lPixel*/, {|| aRelato[nCount1,4] },,,,,,.T.)
TRCell():New(oCliente,"CODCLI"  ,"",STR0022,/*Picture*/         ,9/*Tamanho*/,/*lPixel*/, {|| aRelato[nCount1,2] + "/" + aRelato[nCount1,3] },,,,,,.T.)
TRCell():New(oCliente,"TIPFRE"  ,"",STR0044,/*Picture*/         ,9/*Tamanho*/,/*lPixel*/, {|| AllTrim( aRetBox[ Ascan( aRetBox, { |x| x[ 2 ] == aRelato[nCount1,18]} ), 3 ]) },,,,,,.T.)
TRCell():New(oCliente,"NEGOC"    ,"",STR0046,/*Picture*/         ,4/*Tamanho*/,/*lPixel*/, {|| aRelato[nCount1,20] },,,,,,.T.)
TRCell():New(oCliente,"SERV"    ,"",STR0045,/*Picture*/         ,4/*Tamanho*/,/*lPixel*/, {|| aRelato[nCount1,19] },,,,,,.T.)
TRCell():New(oCliente,"INIVIGEN","",STR0038,/*Picture*/    ,8/*Tamanho*/,/*lPixel*/, {|| aRelato[nCount1,17] },,,,,,.F.)
TRCell():New(oCliente,"FATURAM" ,"",STR0023,"@E 999,999,999.99" ,12/*Tamanho*/,/*lPixel*/, {|| aRelato[nCount1,5] },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"MEDIAMES","",STR0024,"@E 999,999,999.99" ,12/*Tamanho*/,/*lPixel*/, {|| Round( aRelato[nCount1,5] / nQtdMes,2) },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"PESOREAL","",STR0025,PesqPict("DT6","DT6_PESO"),TamSx3("DT6_PESO")[1]+TamSx3("DT6_PESO")[2],/*lPixel*/, {|| aRelato[nCount1,6] },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"PESOCUB" ,"",STR0026,PesqPict("DT6","DT6_PESO"),TamSx3("DT6_PESO")[1]+TamSx3("DT6_PESO")[2],/*lPixel*/, {|| aRelato[nCount1,7] },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"PESOCOB" ,"",STR0027,PesqPict("DT6","DT6_PESO"),TamSx3("DT6_PESO")[1]+TamSx3("DT6_PESO")[2],/*lPixel*/, {|| aRelato[nCount1,8] },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"FRETEMED","",STR0028,"@E 99,999.99"      , 8/*Tamanho*/,/*lPixel*/, {|| Round((aRelato[nCount1,5] / (aRelato[nCount1,6] / 1000)),2) },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"QTDDOC"  ,"",STR0029,"@E 9,999,999"      , 7/*Tamanho*/,/*lPixel*/, {|| aRelato[nCount1,13] },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"FREMDDOC","",STR0030,"@E 999,999.99"     , 9/*Tamanho*/,/*lPixel*/, {|| Round((aRelato[nCount1,5] / aRelato[nCount1,13]),2) },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"PESMDDOC","",STR0031,PesqPict("DT6","DT6_PESO"),TamSx3("DT6_PESO")[1]+TamSx3("DT6_PESO")[2],/*lPixel*/, {|| Round((aRelato[nCount1,6] / aRelato[nCount1,13]),2) },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"VALMERC" ,"",STR0032,"@E 9999,999,999.99",13/*Tamanho*/,/*lPixel*/, {|| aRelato[nCount1,11] },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"VALMERKG","",STR0033,"@E 9,999.99"       , 7/*Tamanho*/,/*lPixel*/, {|| Round((aRelato[nCount1,11] / aRelato[nCount1,6]),2) },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oCliente,"PERCINC" ,"",STR0034,"@E 999.9%"         , 5/*Tamanho*/,/*lPixel*/, {|| Round((aRelato[nCount1,5] / aRelato[nCount1,11]) * 100,1) },"RIGHT",,"RIGHT",,,.T.)

oTotal:= TRSection():New(oFilial,STR0035,{},/*Ordem do relatorio*/,/*Campos do SX3*/,/*Campos do SIX*/)
oTotal:SetHeaderSection(.F.)
oTotal:lReadOnly := .T. //--Se permitir alterar fica diferente dos itens
TRCell():New(oTotal,"SEQUEN"  ,"",STR0020,"@E 999999"         ,6 /*Tamanho*/,/*lPixel*/,{|| nOrdem++ },,,,,,.T.)
TRCell():New(oTotal,"CLIENTE" ,"",STR0021,/*Picture*/         ,15/*Tamanho*/,/*lPixel*/, {|| STR0036 },,,,,,.T.)
TRCell():New(oTotal,"CODCLI"  ,"",STR0022,/*Picture*/         ,9/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oTotal,"TIPFRE"  ,"",STR0044,/*Picture*/         ,9/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oTotal,"NEGOC"    ,"",STR0046,/*Picture*/         ,4/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oTotal,"SERV"    ,"",STR0045,/*Picture*/         ,4/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oTotal,"INIVIGEN","",STR0038,/*Picture*/    ,8/*Tamanho*/,/*lPixel*/,/*{|| aRelato[nCount1,17] }*/,,,,,,.F.)
TRCell():New(oTotal,"FATURAM" ,"",STR0023,"@E 999,999,999.99" ,12/*Tamanho*/,/*lPixel*/, {|| aRelTot[nPosTot,5] },,,,,,.T.)
TRCell():New(oTotal,"MEDIAMES","",STR0024,"@E 999,999,999.99" ,12/*Tamanho*/,/*lPixel*/, {|| Round( aRelTot[nPosTot,5] / nQtdMes,2) },,,,,,.T.)
TRCell():New(oTotal,"PESOREAL","",STR0025,PesqPict("DT6","DT6_PESO"),TamSx3("DT6_PESO")[1]+TamSx3("DT6_PESO")[2],/*lPixel*/, {|| aRelTot[nPosTot,6] },,,,,,.T.)
TRCell():New(oTotal,"PESOCUB" ,"",STR0026,PesqPict("DT6","DT6_PESO"),TamSx3("DT6_PESO")[1]+TamSx3("DT6_PESO")[2],/*lPixel*/, {|| aRelTot[nPosTot,7] },,,,,,.T.)
TRCell():New(oTotal,"PESOCOB" ,"",STR0027,PesqPict("DT6","DT6_PESO"),TamSx3("DT6_PESO")[1]+TamSx3("DT6_PESO")[2],/*lPixel*/, {|| aRelTot[nPosTot,8] },,,,,,.T.)
TRCell():New(oTotal,"FRETEMED","",STR0028,"@E 99,999.99"      , 8/*Tamanho*/,/*lPixel*/, {|| Round((aRelTot[nPosTot,5] / (aRelTot[nPosTot,6] / 1000)),2) },,,,,,.T.)
TRCell():New(oTotal,"QTDDOC"  ,"",STR0029,"@E 9,999,999"      , 7/*Tamanho*/,/*lPixel*/, {|| aRelTot[nPosTot,13] },,,,,,.T.)
TRCell():New(oTotal,"FREMDDOC","",STR0030,"@E 999,999.99"     , 9/*Tamanho*/,/*lPixel*/, {|| Round((aRelTot[nPosTot,5] / aRelTot[nPosTot,13]),2) },,,,,,.T.)
TRCell():New(oTotal,"PESMDDOC","",STR0031,PesqPict("DT6","DT6_PESO"),TamSx3("DT6_PESO")[1]+TamSx3("DT6_PESO")[2],/*lPixel*/, {|| Round((aRelTot[nPosTot,6] / aRelTot[nPosTot,13]),2) },,,,,,.T.)
TRCell():New(oTotal,"VALMERC" ,"",STR0032,"@E 9999,999,999.99",13/*Tamanho*/,/*lPixel*/, {|| aRelTot[nPosTot,11] },,,,,,.T.)
TRCell():New(oTotal,"VALMERKG","",STR0033,"@E 9,999.99"       , 7/*Tamanho*/,/*lPixel*/, {|| Round((aRelTot[nPosTot,11] / aRelTot[nPosTot,6]),2) },,,,,,.T.)
TRCell():New(oTotal,"PERCINC" ,"",STR0034,"@E 999.9%"         , 5/*Tamanho*/,/*lPixel*/, {|| Round((aRelTot[nPosTot,5] / aRelTot[nPosTot,11]) * 100,1) },,,,,,.T.)

TRFunction():New(oCliente:Cell("SEQUEN" ),/*cId*/,"COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/,oFilial)
TRFunction():New(oTotal:Cell("FATURAM" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("MEDIAMES"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("PESOREAL"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("PESOCUB" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("PESOCOB" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("FRETEMED"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("QTDDOC"  ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("FREMDDOC"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("PESMDDOC"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("VALMERC" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("VALMERKG"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oTotal:Cell("PERCINC" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)

TRPosition():New(oReport:Section(1),"SM0",1,{|| cEmpAnt + aRelato[nCount1,1] })

RestArea( aAreaSM0 )

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
Static Function ReportPrint(oReport,cAliasQry,nQtdMes,aRelato,nCount1,aRelTot,nPosTot,aContrt)

Local nAno      := 0
Local nMes1     := 0
Local nMes2     := 0
Local nCount    := 0
Local cCodFil   := ''
Local lPrintTot := .F.

DEFAULT aContrt := {}

nAno := Year(mv_par02) - Year(mv_par01)
For nCount := 1 To nAno
	nMes2 += 12
Next nCount

nMes2 += Month(mv_par02)
nMes1 := Month(mv_par01)

nQtdMes := nMes2 - nMes1

If nQtdMes == 0
	nQtdMes := 1
EndIf

//-- Retorna os dados para impressao
aRel := U_TMR550Prc(aContrt)
aRelato := aRel[1]
aRelTot := aRel[2]

//-- Inicio da impressao do fluxo do relatório
oReport:SetMeter(Len(aRelato))

For nCount1 := 1 To Len(aRelato)

	If cCodFil <> aRelato[nCount1,1]
		oReport:Section(1):Section(1):Finish()
		oReport:Section(1):Finish()
		//-- Impressao do totalizador
		If lPrintTot
			If ( nPosTot:= Ascan(aReltot,{|x| x[1] == cCodFil+"ZZ"}) ) > 0
				oReport:Section(1):Section(2):Init()
				oReport:Section(1):Section(2):PrintLine()
				oReport:Section(1):Section(2):Finish()
			EndIf
		EndIf
		lPrintTot := .T.
		oReport:Section(1):Init()
		oReport:Section(1):PrintLine()
		oReport:Section(1):Section(1):Init()
	EndIf

	oReport:Section(1):Section(1):PrintLine()
	cCodFil := aRelato[nCount1,1]

Next nCount1

//-- Impressao do ultimo totalizador
If Len(aRelato) > 0
	If ( nPosTot:= Ascan(aReltot,{|x| x[1] == cCodFil+"ZZ"}) ) > 0
		oReport:Section(1):Section(2):Init()
		oReport:Section(1):Section(2):PrintLine()
		oReport:Section(1):Section(2):Finish()
	EndIf
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³TMR550Prc ³ Autor ³Wellington A Santos    ³ Data ³21/03/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processa o Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMR550Prc                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMSR550,TMSA990                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

//-----------------------------------------------------------------------------------------------------------
/* TMR550Prc 
@author  	Jefferson Tomaz
@version 	P12 R12.1.30
@since 		13/05/2020
@return 	*/
//-----------------------------------------------------------------------------------------------------------
User Function TMR550Prc(aContrt)
Local nCount0   := 0
Local nCount1   := 0
Local nTaxas    := 0
Local aRelTot   := {}
Local nSeek     := 0
Local cCodFil   := ''
Local nOrdem    := 0
Local nTotalCli := 0
Local cChave    := ''

Private aRelato := {}

cTitulo := STR0001 + Space(5) + STR0009 + ": " + DtoC(mv_par01) + Space(5) + STR0010 + ": " ;
+ DtoC(mv_par02) + Space(5) + STR0042 + ": " + mv_par05 + Space(5) + STR0043 + ": " +Space(5) + mv_par06

//////////////////////////////////////////
//  Cria e Carrega Array para Impressao //
//////////////////////////////////////////

If Len(aContrt) == 0
	aContrt := tmsa990Qry('2')
EndIf
//-- Formato do array contrt
//-- aContrt[,1] = Flag marcado ou nao
//-- aContrt[,2] = Filial negociacao ou brancos
//-- aContrt[,3] = Codigo do cliente
//-- aContrt[,4] = Loja do cliente
//-- aContrt[,5] = Nome do cliente devedor
//-- aContrt[,6] = Valor total
//-- aContrt[,7] = Quantidade de documentos
//-- aContrt[,8] = Peso real
//-- aContrt[,9] = inicio da vigencia do contrato
//-- aContrt[,10] = descricao do tipo de transporte
//-- aContrt[,11] = numero do contrato do cliente
//-- aContrt[,12] = codido do cliente devedor
//-- aContrt[,13]= loja do cliente devedor
//-- aContrt[,14]= filial
//-- aContrt[,15]= valor da mercadoria
//-- aContrt[,16]= peso cubado
//-- aContrt[,17]= peso cobrado
//-- aContrt[,18]= volume original
//-- aContrt[,19]= tipo de transporte
//-- aContrt[,20]= tipo de frete 
//-- aContrt[,21]= servico
//-- aContrt[,22]= codigo da negociacao

//-- Formato do vetor aRelato
//-- 01 - Codigo Filial
//-- 02 - Codigo Cliente
//-- 03 - Loja Cliente
//-- 04 - Nome Cliente
//-- 05 - Frete
//-- 06 - Peso Real
//-- 07 - Peso Cubado
//-- 08 - Peso Cobrado
//-- 09 - Densidade
//-- 10 - Taxas
//-- 11 - Valor Mercadoria
//-- 12 - Quantidade de Volumes
//-- 13 - Quantidade de Documentos
//-- 14 - Fator de Apuracao
//-- 15 - Fator de Apuracao Invertido
//-- 16 - Filiais de Origem
//-- 17 - Inicio Vigencia
//-- 18 - Tipo Transporte
//-- 19 - Servico
//-- 20 - Codigo da Negociacao
For nCount0 := 1 To Len(aContrt)

	cCodFil := Iif(Empty(aContrt[nCount0,2]),aContrt[nCount0,14],aContrt[nCount0,2])
	//-- Grava Linhas Detalhe da Filial e das Quebras
	Aadd(aRelato,{cCodFil ,; //1
		aContrt[nCount0,3] ,; //2
		aContrt[nCount0,4] ,; //3
		aContrt[nCount0,5] ,; //4
		aContrt[nCount0,6] ,; //5
		aContrt[nCount0,8] ,; //6
		aContrt[nCount0,16],; //7
		aContrt[nCount0,17] ,; //8
		 0                 ,; //9
		nTaxas             ,; //10
		aContrt[nCount0,15],; //11
		aContrt[nCount0,18],; //12
		aContrt[nCount0,7] ,; //13
		0                  ,; //14
		0                  ,; //15
		aContrt[nCount0,14],; //16
		aContrt[nCount0,9],; //17
		aContrt[nCount0,20],; //18
		aContrt[nCount0,21],; //19
		aContrt[nCount0,22]}) //20

	//-- Grava Total de Cada Quebra
	nSeek   := Ascan(aReltot,{|x| x[1] == cCodFil+"ZZ"})
	cCodFil := aContrt[nCount0,2] + "ZZ"
	If nSeek == 0
		Aadd(aReltot,{cCodFil,; //1
		Space(Len(DTC->DTC_CLIREM)),;//2
		Space(Len(DTC->DTC_LOJREM)),;//3
		Space(Len(SA1->A1_NREDUZ)) ,;//4
		aContrt[nCount0,6]         ,;//5
		aContrt[nCount0,8]         ,;//6
		aContrt[nCount0,16]        ,;//7
		aContrt[nCount0,17]        ,;//8
		 0                         ,;//9
		nTaxas                     ,;//10
		aContrt[nCount0,15]        ,;//11
		aContrt[nCount0,18]        ,;//12
		aContrt[nCount0,7]         ,;//13
		0                          ,;//14
		0                          ,;//15
		aContrt[nCount0,14]        ,;//16
		aContrt[nCount0,9]         ,;//17
		aContrt[nCount0,20]})        //18

	Else
		aReltot[nSeek,5]  += aContrt[nCount0,6]
		aReltot[nSeek,6]  += aContrt[nCount0,8]
		aReltot[nSeek,7]  += aContrt[nCount0,16]
		aReltot[nSeek,8]  += aContrt[nCount0,17]
		aReltot[nSeek,9]  += 0
		aReltot[nSeek,10] += nTaxas
		aReltot[nSeek,11] += aContrt[nCount0,15]
		aReltot[nSeek,12] += aContrt[nCount0,14]
		aReltot[nSeek,13] += aContrt[nCount0,7]
	EndIf

Next nCount0

Return { aRelato, aRelTot }