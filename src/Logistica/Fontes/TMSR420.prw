/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TMSR420.CH"

Static aConhecSum := {}

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR420  ³ Autor ³ Eduardo de Souza      ³ Data ³ 24/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Averbacao de Seguro.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR420()

Local oReport
Local aArea := GetArea()

//-- Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Eduardo de Souza      ³ Data ³ 24/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR420                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local cAliasQry  := GetNextAlias()
Local cAliasQry2 := GetNextAlias()
Local aOrdem    := {}
Local oBreak

aConhecSum := {}

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
oReport:= TReport():New("TMSR420",STR0025,"TMR420", {|oReport| ReportPrint(oReport,cAliasQry,cAliasQry2)},STR0026) // "Impressao da Averbação de Seguro" ### "Emite a relacao de Averbação de Seguro conforme os parâmetros informados."
oReport:SetTotalInLine(.F.)
oReport:SetLandScape(.T.)
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
Aadd( aOrdem, STR0027 ) // "Ramo + Origem + Destino"

oRamo:= TRSection():New(oReport,STR0050,{"DU7","DU3"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oRamo:SetTotalInLine(.F.)
oRamo:SetPageBreak(.T.)
TRCell():New(oRamo,"DU7_COMSEG","DU7",STR0050,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRamo,"DU3_DESCRI","DU3",STR0045,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oDocto:= TRSection():New(oRamo,STR0028,{"DT6","DU7","SA1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oDocto:SetTotalInLine(.F.)
oDocto:SetTotalText(STR0049) // "Total do Ramo"
TRCell():New(oDocto,"DT6_DATEMI","DT6",STR0029,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DU7_FILDOC","DT6",STR0030,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DU7_DOC"   ,"DT6",STR0031,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,SerieNfId("DU7",3,"DU7_SERIE") ,"DT6",STR0032,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DT6_TIPFRE","DT6",STR0033,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DT6_CLIDEV","DT6",STR0034,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DT6_LOJDEV","DT6",STR0035,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"A1_NREDUZ" ,"SA1",STR0036,/*Picture*/,30         ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DT6_VALMER","DT6",STR0037,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oDocto,"DT6_SERVIC","DT6",STR0038,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DT6_DESSVT","DT6",STR0039,/*Picture*/,20         ,/*lPixel*/, {|| Tabela("L4",(cAliasQry)->DT6_SERVIC,.F.) },,,,,,.F.)
TRCell():New(oDocto,"DT6_REGORI","DT6",STR0041,/*Picture*/,20         ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DT6_REGDES","DT6",STR0043,/*Picture*/,20         ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DU7_COMSEG","DU7",STR0044,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DU3_DESCRI","DU3",STR0045,/*Picture*/,20         ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oDocto,"DVD_PERAJU","DVD",STR0046,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| IIf(!Empty((cAliasQry)->DU7_INTERV),(cAliasQry)->DU7_VALOR/(cAliasQry)->DU7_INTERV,(cAliasQry)->DU7_VALOR) },,,,,,.T.)
TRCell():New(oDocto,"DU7_PREMIO","DU7",STR0047,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)

oBreak := TRBreak():New(oDocto,{ || TMR420Qbr((cAliasQry)->DT6_REGORI,(cAliasQry)->DT6_REGDES,(cAliasQry)->DU7_COMSEG) },STR0048,.F.) // "Total da Região"
TRFunction():New(oDocto:Cell("DT6_VALMER"),/*cId*/,"SUM",oBreak    ,/*cTitle*/,/*cPicture*/,{ || If( VldSumMerc("N",(cAliasQry)->DU7_COMSEG,(cAliasQry)->DU7_FILDOC,(cAliasQry)->DU7_DOC,(cAliasQry)->DU7_SERIE), (cAliasQry)->DT6_VALMER, 0 ) },   /*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDocto:Cell("DU7_PREMIO"),/*cId*/,"SUM",oBreak    ,/*cTitle*/,/*cPicture*/,/*uFormula*/,   /*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDocto:Cell("DT6_VALMER"),/*cId*/,"SUM",          ,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,   /*lEndReport*/,.F./*lEndPage*/,oRamo)
TRFunction():New(oDocto:Cell("DU7_PREMIO"),/*cId*/,"SUM",          ,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,   /*lEndReport*/,.F./*lEndPage*/,oRamo)

oDocto1:= TRSection():New(oReport,STR0028,{"DT6","DU7","SA1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oDocto1:SetPageBreak(.T.)
oDocto1:SetTotalInLine(.F.)
oDocto1:SetTotalText(STR0051) // "Total por parte do Cliente"
TRCell():New(oDocto1,"DT6_DATEMI","DT6",STR0029,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DU7_FILDOC","DT6",STR0030,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DU7_DOC"   ,"DT6",STR0031,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,SerieNfId("DU7",3,"DU7_SERIE") ,"DT6",STR0032,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DT6_TIPFRE","DT6",STR0033,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DT6_CLIDEV","DT6",STR0034,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DT6_LOJDEV","DT6",STR0035,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"A1_NREDUZ" ,"SA1",STR0036,/*Picture*/,30         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DT6_VALMER","DT6",STR0037,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DT6_SERVIC","DT6",STR0038,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DT6_DESSVT","DT6",STR0039,/*Picture*/,20         ,/*lPixel*/, {|| Tabela("L4",(cAliasQry2)->DT6_SERVIC,.F.) } )
TRCell():New(oDocto1,"DT6_REGORI","DT6",STR0041,/*Picture*/,20         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DT6_REGDES","DT6",STR0043,/*Picture*/,20         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DU7_COMSEG","DU7",STR0044,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DU3_DESCRI","DU3",STR0045,/*Picture*/,20         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto1,"DVD_PERAJU","DVD",STR0046,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| IIf(!Empty((cAliasQry2)->DU7_INTERV),(cAliasQry2)->DU7_VALOR/(cAliasQry2)->DU7_INTERV,(cAliasQry2)->DU7_VALOR) } )
TRCell():New(oDocto1,"DU7_PREMIO","DU7",STR0047,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

TRFunction():New(oDocto1:Cell("DT6_VALMER"),/*cId*/,"SUM",/*oBreak1*/,/*cTitle*/,/*cPicture*/,{ || If( VldSumMerc("S",(cAliasQry2)->DU7_COMSEG,(cAliasQry2)->DU7_FILDOC,(cAliasQry2)->DU7_DOC,(cAliasQry2)->DU7_SERIE), (cAliasQry2)->DT6_VALMER, 0 ) },/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)

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
Static Function ReportPrint(oReport,cAliasQry,cAliasQry2)

Local nCnt := 0
Local cFecht:= ""

If SerieNfId("DU7",3,"DU7_SERIE")=="DU7_SDOC"
	cFecht :='%DU7_SDOC,%'
Else
	cFecht :='%%'
EndIf

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//-- Filtragem do relatório
//-- Query do relatório da secao 1
If mv_par07 == 2
oReport:Section(1):BeginQuery()
BeginSql Alias cAliasQry
	SELECT DU7_FILDOC, DU7_DOC   , DU7_SERIE , %Exp:cFecht% DU7_CLIAVB, DU7_LOJAVB, DU7_COMSEG , DU7_VALOR, 
	       DU7_INTERV, DT6_DATEMI, DT6_TIPFRE, DT6_CLIDEV, DT6_LOJDEV, DT6_VALMER , DT6_SERVIC,
	       DT6_CDRORI, DT6_CDRDES, DU7_PREMIO, DU7_FILIAL, A1_NREDUZ, DU3_DESCRI, DUYA.DUY_DESCRI DT6_REGORI,
			 DUYB.DUY_DESCRI DT6_REGDES
	   FROM %table:DT6% DT6
	   JOIN %table:DU7% DU7
	      ON  DU7_FILIAL = %xFilial:DU7%
	      AND DU7_FILDOC = DT6_FILDOC
	      AND DU7_DOC    = DT6_DOC
	      AND DU7_SERIE  = DT6_SERIE
	      AND DU7_COMSEG >= %Exp:mv_par05%
	      AND DU7_COMSEG <= %Exp:mv_par06%
	      AND DU7_CLIAVB = ' '
	      AND DU7_LOJAVB = ' '
	      AND DU7.%NotDel%
	   JOIN %table:DUY% DUYA
	     ON DUYA.DUY_FILIAL  = %xFilial:DUY%
	     AND DUYA.DUY_GRPVEN = DT6_CDRORI
	     AND DUYA.%NotDel%
	   JOIN %table:DUY% DUYB
	     ON DUYB.DUY_FILIAL  = %xFilial:DUY%
	     AND DUYB.DUY_GRPVEN = DT6_CDRDES
	     AND DUYB.%NotDel%
	   JOIN %table:DU3% DU3
	     ON DU3_FILIAL  = %xFilial:DU3%
	     AND DU3_COMSEG = DU7_COMSEG
	     AND DU3.%NotDel%
	   JOIN %table:SA1% SA1
	     ON A1_FILIAL = %xFilial:SA1%
	     AND A1_COD  = DT6_CLIDEV
	     AND A1_LOJA = DT6_LOJDEV
	     AND SA1.%NotDel%
	   WHERE DT6_FILIAL = %xFilial:DT6%
	      AND DT6_FILDOC >= %Exp:mv_par01%
	      AND DT6_FILDOC <= %Exp:mv_par02%
	      AND DT6_DATEMI >= %Exp:Dtos(mv_par03)%
	      AND DT6_DATEMI <= %Exp:Dtos(mv_par04)%
	      AND DT6_DOCTMS <> %Exp:StrZero(1,Len(DT6->DT6_DOCTMS))%
	      AND DT6.%NotDel%
	ORDER BY DU7_FILIAL, DU7_CLIAVB, DU7_LOJAVB, DU7_COMSEG, DT6_CDRORI, DT6_CDRDES, DU7_FILDOC, DU7_DOC, DU7_SERIE	
EndSql
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
Else 
oReport:Section(1):BeginQuery()
BeginSql Alias cAliasQry 	
	SELECT DU7_FILDOC, DU7_DOC   , DU7_SERIE , %Exp:cFecht% DU7_CLIAVB, DU7_LOJAVB, DU7_COMSEG , DU7_VALOR, 
	       DU7_INTERV, DT6_DATEMI, DT6_TIPFRE, DT6_CLIDEV, DT6_LOJDEV, DT6_VALMER , DT6_SERVIC,
	       DT6_CDRORI, DT6_CDRDES, Sum(DU7_PREMIO) as DU7_PREMIO, DU7_FILIAL, A1_NREDUZ, DU3_DESCRI, DUYA.DUY_DESCRI DT6_REGORI,
			 DUYB.DUY_DESCRI DT6_REGDES
	   FROM %table:DT6% DT6
	   JOIN %table:DU7% DU7
	      ON  DU7_FILIAL = %xFilial:DU7%
	      AND DU7_FILDOC = DT6_FILDOC
	      AND DU7_DOC    = DT6_DOC
	      AND DU7_SERIE  = DT6_SERIE
	      AND DU7_COMSEG >= %Exp:mv_par05%
	      AND DU7_COMSEG <= %Exp:mv_par06%
	      AND DU7_CLIAVB = ' '
	      AND DU7_LOJAVB = ' '
	      AND DU7.%NotDel%
	   JOIN %table:DUY% DUYA
	     ON DUYA.DUY_FILIAL  = %xFilial:DUY%
	     AND DUYA.DUY_GRPVEN = DT6_CDRORI
	     AND DUYA.%NotDel%
	   JOIN %table:DUY% DUYB
	     ON DUYB.DUY_FILIAL  = %xFilial:DUY%
	     AND DUYB.DUY_GRPVEN = DT6_CDRDES
	     AND DUYB.%NotDel%
	   JOIN %table:DU3% DU3
	     ON DU3_FILIAL  = %xFilial:DU3%
	     AND DU3_COMSEG = DU7_COMSEG
	     AND DU3.%NotDel%
	   JOIN %table:SA1% SA1
	     ON A1_FILIAL = %xFilial:SA1%
	     AND A1_COD  = DT6_CLIDEV
	     AND A1_LOJA = DT6_LOJDEV
	     AND SA1.%NotDel%
	   WHERE DT6_FILIAL = %xFilial:DT6%
	      AND DT6_FILDOC >= %Exp:mv_par01%
	      AND DT6_FILDOC <= %Exp:mv_par02%
	      AND DT6_DATEMI >= %Exp:Dtos(mv_par03)%
	      AND DT6_DATEMI <= %Exp:Dtos(mv_par04)%
	      AND DT6_DOCTMS <> %Exp:StrZero(1,Len(DT6->DT6_DOCTMS))%
	      AND DT6.%NotDel%	
	GROUP BY DU7_FILDOC, DU7_DOC   , DU7_SERIE ,  %Exp:cFecht% DU7_CLIAVB, DU7_LOJAVB, DU7_COMSEG , DU7_VALOR, 
	         DU7_INTERV, DT6_DATEMI, DT6_TIPFRE, DT6_CLIDEV, DT6_LOJDEV, DT6_VALMER , DT6_SERVIC,
	         DT6_CDRORI, DT6_CDRDES, DU7_FILIAL, A1_NREDUZ, DU3_DESCRI, DUYA.DUY_DESCRI,
			  DUYB.DUY_DESCRI
   ORDER BY DU7_FILIAL, DU7_CLIAVB, DU7_LOJAVB, DU7_COMSEG, DT6_CDRORI, DT6_CDRDES, DU7_FILDOC, DU7_DOC, DU7_SERIE
   EndSql
   oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
EndIF   			  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par07 == 2
oReport:Section(2):BeginQuery()	
BeginSql Alias cAliasQry2
	SELECT DU7_FILDOC, DU7_DOC   , DU7_SERIE , %Exp:cFecht% DU7_CLIAVB, DU7_LOJAVB, DU7_COMSEG , DU7_VALOR, 
	       DU7_INTERV, DT6_DATEMI, DT6_TIPFRE, DT6_CLIDEV, DT6_LOJDEV, DT6_VALMER , DT6_SERVIC,
	       DT6_CDRORI, DT6_CDRDES, DU7_PREMIO, DU7_FILIAL, A1_NREDUZ , DU3_DESCRI, DUYA.DUY_DESCRI DT6_REGORI,
			 DUYB.DUY_DESCRI DT6_REGDES
	   FROM %table:DT6% DT6
	   JOIN %table:DU7% DU7
	      ON  DU7_FILIAL = %xFilial:DU7%
	      AND DU7_FILDOC = DT6_FILDOC
	      AND DU7_DOC    = DT6_DOC
	      AND DU7_SERIE  = DT6_SERIE
	      AND DU7_COMSEG >= %Exp:mv_par05%
	      AND DU7_COMSEG <= %Exp:mv_par06%
	      AND DU7_CLIAVB <> ' '
	      AND DU7_LOJAVB <> ' '
	      AND DU7.%NotDel%
	   JOIN %table:DUY% DUYA
	     ON DUYA.DUY_FILIAL  = %xFilial:DUY%
	     AND DUYA.DUY_GRPVEN = DT6_CDRORI
	     AND DUYA.%NotDel%
	   JOIN %table:DUY% DUYB
	     ON DUYB.DUY_FILIAL  = %xFilial:DUY%
	     AND DUYB.DUY_GRPVEN = DT6_CDRDES
	     AND DUYB.%NotDel%
	   JOIN %table:DU3% DU3
	     ON DU3_FILIAL  = %xFilial:DU3%
	     AND DU3_COMSEG = DU7_COMSEG
	     AND DU3.%NotDel%
	   JOIN %table:SA1% SA1
	     ON A1_FILIAL = %xFilial:SA1%
	     AND A1_COD  = DT6_CLIDEV
	     AND A1_LOJA = DT6_LOJDEV
	     AND SA1.%NotDel%
	   WHERE DT6_FILIAL = %xFilial:DT6%
	      AND DT6_FILDOC >= %Exp:mv_par01%
	      AND DT6_FILDOC <= %Exp:mv_par02%
	      AND DT6_DATEMI >= %Exp:Dtos(mv_par03)%
	      AND DT6_DATEMI <= %Exp:Dtos(mv_par04)%
	      AND DT6_DOCTMS <> %Exp:StrZero(1,Len(DT6->DT6_DOCTMS))%
	      AND DT6.%NotDel%
	ORDER BY DU7_FILIAL, DU7_COMSEG, DT6_CDRORI, DT6_CDRDES, DU7_FILDOC, DU7_DOC, DU7_SERIE
EndSql 
oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)
Else
oReport:Section(2):BeginQuery()	
BeginSql Alias cAliasQry2	
	SELECT DU7_FILDOC, DU7_DOC   , DU7_SERIE , %Exp:cFecht% DU7_CLIAVB, DU7_LOJAVB, DU7_COMSEG , DU7_VALOR, 
	       DU7_INTERV, DT6_DATEMI, DT6_TIPFRE, DT6_CLIDEV, DT6_LOJDEV, DT6_VALMER , DT6_SERVIC,
	       DT6_CDRORI, DT6_CDRDES, Sum(DU7_PREMIO) as DU7_PREMIO, DU7_FILIAL, A1_NREDUZ , DU3_DESCRI, DUYA.DUY_DESCRI DT6_REGORI,
			 DUYB.DUY_DESCRI DT6_REGDES
	   FROM %table:DT6% DT6
	   JOIN %table:DU7% DU7
	      ON  DU7_FILIAL = %xFilial:DU7%
	      AND DU7_FILDOC = DT6_FILDOC
	      AND DU7_DOC    = DT6_DOC
	      AND DU7_SERIE  = DT6_SERIE
	      AND DU7_COMSEG >= %Exp:mv_par05%
	      AND DU7_COMSEG <= %Exp:mv_par06%
	      AND DU7_CLIAVB <> ' '
	      AND DU7_LOJAVB <> ' '
	      AND DU7.%NotDel%
	   JOIN %table:DUY% DUYA
	     ON DUYA.DUY_FILIAL  = %xFilial:DUY%
	     AND DUYA.DUY_GRPVEN = DT6_CDRORI
	     AND DUYA.%NotDel%
	   JOIN %table:DUY% DUYB
	     ON DUYB.DUY_FILIAL  = %xFilial:DUY%
	     AND DUYB.DUY_GRPVEN = DT6_CDRDES
	     AND DUYB.%NotDel%
	   JOIN %table:DU3% DU3
	     ON DU3_FILIAL  = %xFilial:DU3%
	     AND DU3_COMSEG = DU7_COMSEG
	     AND DU3.%NotDel%
	   JOIN %table:SA1% SA1
	     ON A1_FILIAL = %xFilial:SA1%
	     AND A1_COD  = DT6_CLIDEV
	     AND A1_LOJA = DT6_LOJDEV
	     AND SA1.%NotDel%
	   WHERE DT6_FILIAL = %xFilial:DT6%
	      AND DT6_FILDOC >= %Exp:mv_par01%
	      AND DT6_FILDOC <= %Exp:mv_par02%
	      AND DT6_DATEMI >= %Exp:Dtos(mv_par03)%
	      AND DT6_DATEMI <= %Exp:Dtos(mv_par04)%
	      AND DT6_DOCTMS <> %Exp:StrZero(1,Len(DT6->DT6_DOCTMS))%
	      AND DT6.%NotDel%	
	GROUP BY DU7_FILDOC, DU7_DOC   , DU7_SERIE , DU7_CLIAVB, DU7_LOJAVB, DU7_COMSEG , DU7_VALOR, 
	         DU7_INTERV, DT6_DATEMI, DT6_TIPFRE, DT6_CLIDEV, DT6_LOJDEV, DT6_VALMER , DT6_SERVIC,
	         DT6_CDRORI, DT6_CDRDES, DU7_FILIAL, A1_NREDUZ , DU3_DESCRI, DUYA.DUY_DESCRI,
			  DUYB.DUY_DESCRI
    ORDER BY DU7_FILIAL, DU7_COMSEG, DT6_CDRORI, DT6_CDRDES, DU7_FILDOC, DU7_DOC, DU7_SERIE
    EndSql 
    oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)
EndIF    	

//-- Inicio da impressao do fluxo do relatório
oReport:SetMeter(DT6->(LastRec()))

oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter( { |cParam| (cAliasQry)->DU7_COMSEG == cParam },{ || (cAliasQry)->DU7_COMSEG })

oReport:Section(1):Print()
oReport:PrintTotal()

//-- Nao imprime o totalizador geral da secao 2
For nCnt := 1 To Len(oReport:aFunction)
	oReport:aFunction[nCnt]:lEndReport := .F.
Next nCnt

oReport:Section(2):Print()
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMR420Qbr ³ Autor ³Eduardo de Souza       ³ Data ³ 24/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controla a quebra do totalizador                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1: Regiao Origem                                        ³±±
±±³          ³ExpC2: Regiao Destino                                       ³±±
±±³          ³ExpC3: Ramo                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR420                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMR420Qbr(cRegOri,cRegDes,cRamo)
Default cRegOri := ''
Default cRegDes := ''
Default cRamo   := ''

Return(cRegOri + cRegDes + cRamo)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³VldSumMerc ³ Autor ³ Marcelo Nunes        ³ Data ³09/06/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Nao somar valor mercad. quando repetir linha para o conhec.³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldSumMerc( cPossuiCli, cComp, cFil, cDoc, cSerie)

//Local i
Local lSum := .F.  
  IF aScan(aConhecSum,cPossuiCli+cComp+cFil+cDoc+cSerie) == 0  
    lSum := .T.
    aAdd(aConhecSum,cPossuiCli+cComp+cFil+cDoc+cSerie)
  EndIF

Return lSum