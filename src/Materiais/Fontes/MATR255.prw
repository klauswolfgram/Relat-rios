/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR255.CH"
#INCLUDE "PROTHEUS.CH"
//#INCLUDE "FWLIBVERSION.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MATR255   ³ Autor ³Felipe Nunes Toledo    ³ Data ³ 07/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Posi‡„o Detalhada do Estoque por Endereco.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR255()
Local oReport

Static __l255VLib

__l255VLib	:= .T. //If(__l255VLib == NIL,FWLibVersion() >= "20211116",__l255VLib)

oReport:= ReportDef()
oReport:PrintDialog()

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Felipe Nunes Toledo    ³ Data ³07/07/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³MATR255			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local cTitle    := OemToAnsi(STR0001) //"Posicao Detalhada do Estoque por Endereco"
Local aOrdem    := {STR0005,STR0006}  //" Armazem + Grupo + Produto "###" Produto + Armazem "
Local cAliasSBF := GetNextAlias()

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
oReport:= TReport():New("MATR255",cTitle,"MTR255", {|oReport| ReportPrint(oReport,cAliasSBF)},OemToAnsi(STR0002)+" "+OemToAnsi(STR0003)+" "+OemToAnsi(STR0004)) //##"Neste relat¢rio ‚ possivel obter uma posi‡„o de quantidade por"##"produto/lote/endereco/status, o que permite o mapeamento perfeito"##"de cada Endereco."
oReport:SetEdit(.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas (MTR255)                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // Produto 	de                               ³
//³ mv_par02     // Produto 	ate                              ³
//³ mv_par03     // Situacao 	de                               ³
//³ mv_par04     // Situacao	ate                              ³
//³ mv_par05     // Imprimir  Normal/Ambos                       ³
//³ mv_par06     // Do Armazem                                   ³
//³ mv_par07     // Ate o Armazem                                ³
//³ mv_par08     // Da Localizacao                               ³
//³ mv_par09     // Ate a Localizacao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:GetParam(),.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao das secoes utilizadas pelo relatorio                            ³
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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Section1                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport,STR0025,{"SBF","SB1"},aOrdem) //"Posicao Detalhada do Estoque por Endereco"
oSection1:SetHeaderPage()

TRCell():New(oSection1,'BF_LOCAL'	,'SBF',/*Titulo*/,/*Picture*/,iif(tamsx3('BF_LOCAL')[1] < 12,12,tamsx3('BF_LOCAL')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_GRUPO' 	,'SB1',/*Titulo*/,/*Picture*/,iif(tamsx3('B1_GRUPO')[1] < 12,12,tamsx3('B1_GRUPO')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'BM_DESC'   	,'SBM',/*Titulo*/,/*Picture*/,iif(tamsx3('BM_DESC')[1] < 12,12,tamsx3('BM_DESC')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'BF_PRODUTO'	,'SBF',/*Titulo*/,/*Picture*/,iif(tamsx3('BF_PRODUTO')[1] < 12,12,tamsx3('BF_PRODUTO')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_DESC' 	,'SB1',/*Titulo*/,/*Picture*/,iif(tamsx3('B1_DESC')[1] < 12,12,tamsx3('B1_DESC')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ oSection2                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,STR0026,{"SBF","SB1","SB8"},/*Ordem*/) //"Posicao Detalhada do Estoque por Endereco"
oSection2:SetHeaderPage()

TRCell():New(oSection2,'BF_LOTECTL'	,'SBF',/*Titulo*/,/*Picture*/,iif(tamsx3('BF_LOTECTL')[1] < 10,10,tamsx3('BF_LOTECTL')[1]),/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection2,'BF_NUMLOTE'	,'SBF',/*Titulo*/,/*Picture*/,iif(tamsx3('BF_NUMLOTE')[1] < 6,6,tamsx3('BF_NUMLOTE')[1]),/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection2,'B8_DTVALID'	,'SB8',/*Titulo*/,PesqPict('SB8','B8_DTVALID'),12,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection2,'BF_LOCALIZ'	,'SBF',/*Titulo*/,/*Picture*/,iif(tamsx3('BF_LOCALIZ')[1] < 12,12,tamsx3('BF_LOCALIZ')[1]),/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection2,'BF_NUMSERI'	,'SBF',/*Titulo*/,/*Picture*/,iif(tamsx3('BF_NUMSERI')[1] < 12,12,tamsx3('BF_NUMSERI')[1]),/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection2,'DD_MOTIVO' 	,'SDD',/*Titulo*/,/*Picture*/,iif(tamsx3('DD_MOTIVO')[1] < 2,2,tamsx3('DD_MOTIVO')[1]),/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection2,'DescSitua' 	,'SX5', STR0021  , ''        , 16        ,/*lPixel*/,  {|| '' }                      ,,,,,,.T.)
TRCell():New(oSection2,'DD_OBSERVA'	,'SDD',/*Titulo*/,/*Picture*/,iif(tamsx3('DD_OBSERVA')[1] < 12,12,tamsx3('DD_OBSERVA')[1]),/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection2,'B1_UM'  	   ,'SB1',/*Titulo*/,/*Picture*/,iif(tamsx3('B1_UM')[1] < 12,12,tamsx3('B1_UM')[1]),/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection2,'BF_QUANT'	,'SBF',/*Titulo*/,/*Picture*/,18,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection2,'BF_EMPENHO'	,'SBF',/*Titulo*/,/*Picture*/,18,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection2,'DC_QUANT'	,'SDC', STR0022  ,/*Picture*/,18,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection2,'Disponivel' ,'SBF', STR0023  ,PesqPict("SBF","BF_QUANT"),18,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F.)
TRCell():New(oSection2,'BF_LOCAL' 	,'SBF',/*Titulo*/,/*Picture*/,18,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection2,'B1_GRUPO' 	,'SB1',/*Titulo*/,/*Picture*/,18,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ oSection3                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3 := TRSection():New(oSection2,STR0027,{"SBF","SB1","SB8"},/*Ordem*/) //"Posicao Detalhada do Estoque por Endereco"
oSection3:SetHeaderPage(.F.)
oSection3:SetHeaderSection(.F.)

TRCell():New(oSection3,'BF_LOTECTL'	,'SBF',/*Titulo*/,/*Picture*/,iif(tamsx3('BF_LOTECTL')[1] < 12,12,tamsx3('BF_LOTECTL')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'BF_NUMLOTE'	,'SBF',/*Titulo*/,/*Picture*/,iif(tamsx3('BF_NUMLOTE')[1] < 12,12,tamsx3('BF_NUMLOTE')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'B8_DTVALID'	,'SB8',/*Titulo*/,/*Picture*/,16,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'BF_LOCALIZ'	,'SBF',/*Titulo*/,/*Picture*/,iif(tamsx3('BF_LOCALIZ')[1] < 12,12,tamsx3('BF_LOCALIZ')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'BF_NUMSERI'	,'SBF',/*Titulo*/,/*Picture*/,iif(tamsx3('BF_NUMSERI')[1] < 12,12,tamsx3('BF_NUMSERI')[1]),/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection3,'DD_MOTIVO' 	,'SDD',/*Titulo*/,/*Picture*/,iif(tamsx3('DD_MOTIVO')[1] < 12,12,tamsx3('DD_MOTIVO')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'DescSitua' 	,'SX5', STR0021  , ''        , 16        ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'DD_OBSERVA'	,'SDD',/*Titulo*/,/*Picture*/,iif(tamsx3('DD_OBSERVA')[1] < 12,12,tamsx3('DD_OBSERVA')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'B1_UM'      ,'SB1',/*Titulo*/,/*Picture*/,iif(tamsx3('B1_UM')[1] < 12,12,tamsx3('B1_UM')[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'BF_QUANT'	,'SBF',/*Titulo*/,/*Picture*/, 18,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'BF_EMPENHO'	,'SBF',/*Titulo*/,/*Picture*/, 18,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'DC_QUANT'	,'SDC',/*Titulo*/,/*Picture*/, 18,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Felipe Nunes Toledo  ³ Data ³07/07/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±³          ³ExpC1: String contendo o Alias Principal                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³MATR255			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport, cAliasSBF)
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local oSection3  := oReport:Section(1):Section(1):Section(1)
Local nOrdem     := oSection1:GetOrder()
Local l300SalNeg := SuperGetMv('MV_MT300NG', .F., .F.) // Indica se permite saldo negativo (DEFAULT = .F.)
Local lImpBlock  := (mv_par05==2)
Local cDescBloq
Local oBreak
Local oFunction
Local cWhere
Local cOrderBy
Local cProdAnt
Local cJoin
Local cAliQry
Local cQuery
Local nTotBlock

Local oPrepStat1
Local oPrepStat2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Prepara Arquivo de Trabalho p/Impressao                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definindo a Quebra³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oBreak := TRBreak():New(oSection1,oSection1:Cell('BF_PRODUTO'),STR0028,.F.) //"Total do Produto"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Defindo os totalizadores do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oFunction := TRFunction():New(oSection2:Cell('BF_QUANT'  ),NIL,"SUM",oBreak,NIL,/*Picture*/,/*uFormula*/,.F.,.F.)
oFunction := TRFunction():New(oSection2:Cell('BF_EMPENHO'),NIL,"SUM",oBreak,NIL,/*Picture*/,/*uFormula*/,.F.,.F.)
oFunction := TRFunction():New(oSection2:Cell('Disponivel'),NIL,"SUM",oBreak,NIL,/*Picture*/,/*uFormula*/,.F.,.F.)
oFunction := TRFunction():New(oSection2:Cell('DC_QUANT'  ),NIL,"SUM",oBreak,NIL,/*Picture*/,/*uFormula*/,.F.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Determinando o titulo do Relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 1
	oReport:SetTitle(oReport:Title()+" ("+STR0005+")") //"Posicao Detalhada do Estoque por Endereco"##"Armazem + Grupo + Produto"
ElseIf nOrdem == 2
	oReport:SetTitle(oReport:Title()+" ("+STR0006+")") //"Posicao Detalhada do Estoque por Endereco"##"Produto + Armazem"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:GetParam())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cWhere := "%"
If l300SalNeg //-- Considera registros no SBF com saldo negativo
	cWhere += "SBF.BF_QUANT <> 0"
Else //-- Considera somente registros no SBF que possuirem quantidade maior que zero
	cWhere += "SBF.BF_QUANT > 0"
EndIf
cWhere += "%"

cJoin := "% BF_NUMLOTE = Case When BF_NUMLOTE <> '" + CriaVar("BF_NUMLOTE",.F.) +"' Then SB8.B8_NUMLOTE Else '" + CriaVar("BF_NUMLOTE",.F.) +"' END %"

cOrderBy := "%"
If nOrdem == 1
	cOrderBy += "SBF.BF_FILIAL, SBF.BF_LOCAL, SB1.B1_GRUPO, SBF.BF_PRODUTO, SBF.BF_LOTECTL, SBF.BF_NUMLOTE"
ElseIf nOrdem == 2
	cOrderBy += "SBF.BF_FILIAL, SBF.BF_PRODUTO, SBF.BF_LOCAL, SBF.BF_LOTECTL, SBF.BF_NUMLOTE"
Endif
cOrderBy += "%"

BEGIN REPORT QUERY oSection1
	BeginSql Alias cAliasSBF

		SELECT SBF.BF_FILIAL, SBF.BF_LOCAL, SBF.BF_PRODUTO, SB1.B1_DESC, SB1.B1_GRUPO, SBF.BF_LOCALIZ,
			SBF.BF_NUMSERI, SBF.BF_LOTECTL, SBF.BF_NUMLOTE, SB1.B1_UM, SUM(SBF.BF_QUANT) BF_QUANT,
			SUM(SBF.BF_EMPENHO) BF_EMPENHO

		FROM %table:SBF% SBF

		JOIN %table:SB1% SB1 ON
			SB1.B1_FILIAL = %xFilial:SB1% AND
			SB1.%NotDel%                  AND
			SB1.B1_COD    = BF_PRODUTO

		LEFT JOIN %table:SB8% SB8 ON
			SB8.B8_FILIAL = %xFilial:SB8% AND
			SB8.%NotDel% AND
			SB8.B8_PRODUTO = BF_PRODUTO AND
			SB8.B8_LOCAL   = BF_LOCAL AND
			SB8.B8_NUMLOTE = BF_NUMLOTE AND
			SB8.B8_LOTECTL = BF_LOTECTL AND
			SB8.B8_SALDO <> 0

		WHERE
			SBF.BF_FILIAL = %xFilial:SBF% AND
			SBF.BF_PRODUTO BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
			SBF.BF_LOCAL BETWEEN %Exp:mv_par06% AND %Exp:mv_par07% AND
			SBF.BF_LOCALIZ BETWEEN %Exp:mv_par08% AND%Exp:mv_par09% AND
			%Exp:cWhere% AND
			SBF.%NotDel% AND
		%Exp:cJoin%

		GROUP BY SBF.BF_FILIAL, SBF.BF_LOCAL, SBF.BF_PRODUTO, SB1.B1_DESC, SB1.B1_GRUPO, SBF.BF_LOCALIZ,
			SBF.BF_NUMSERI, SBF.BF_LOTECTL , SBF.BF_NUMLOTE, SB1.B1_UM

		ORDER BY %Exp:cOrderBy%

	EndSql
END REPORT QUERY oSection1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posicionamento das tabelas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSection1,"SBM",1,{|| xFilial("SBM") + (cAliasSBF)->B1_GRUPO})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definindo as secoes filhas para utilizarem a query da secao pai³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2:SetParentQuery()
oSection3:SetParentQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inibindo celulas para impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2:Cell('DD_MOTIVO' ):Hide()
oSection2:Cell('DescSitua' ):Hide()
oSection2:Cell('DD_OBSERVA'):Hide()
If nOrdem == 1
	oSection2:Cell('BF_LOCAL'):Hide()
	oSection2:Cell('BF_LOCAL'):HideHeader()
	oSection2:Cell('B1_GRUPO'):Hide()
	oSection2:Cell('B1_GRUPO'):HideHeader()
ElseIf nOrdem ==2
	oSection1:Cell('BF_LOCAL'):Hide()
	oSection1:Cell('BF_LOCAL'):HideHeader()
	oSection1:Cell('B1_GRUPO'):Hide()
	oSection1:Cell('B1_GRUPO'):HideHeader()
	oSection1:Cell('BM_DESC' ):Hide()
	oSection1:Cell('BM_DESC' ):HideHeader()
EndIf
oSection3:Cell('BF_NUMLOTE'):Hide()
oSection3:Cell('BF_QUANT'  ):Hide()
oSection3:Cell('BF_EMPENHO'):Hide()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter( SBF->(LastRec()) )
oSection1:Init()
While !oReport:Cancel() .And. !(cAliasSBF)->(Eof())
	oReport:SkipLine()
	oSection1:PrintLine() // Impressao da secao 1
	oReport:SkipLine()
	cProdAnt := xFilial('SBF')+(cAliasSBF)->BF_LOCAL +(cAliasSBF)->BF_PRODUTO
	While !(cAliasSBF)->(Eof()) .And. xFilial('SBF')+(cAliasSBF)->BF_LOCAL +(cAliasSBF)->BF_PRODUTO == cProdAnt
		If lImpBlock // Se mv_par05 == 2
			If oPrepStat1 == NIL
				cQuery := montaQuery("SUM(DC_QUANT) DC_QUANT","sdd.DD_PRODUTO, sdc.DC_LOCALIZ, sdd.DD_MOTIVO, sdc.DC_QUANT")
				If __l255VLib
					oPrepStat1 := FwExecStatement():New(cQuery)
				Else
					oPrepStat1 := FWPreparedStatement():New()
					oPrepStat1:SetQuery(cQuery)
				EndIf 	
			EndIf

			oPrepStat1:SetString(1,(cAliasSBF)->BF_LOCALIZ)
			oPrepStat1:SetString(2,(cAliasSBF)->BF_LOCAL)
			oPrepStat1:SetString(3,(cAliasSBF)->BF_PRODUTO)
			oPrepStat1:SetString(4,(cAliasSBF)->BF_LOTECTL)
			oPrepStat1:SetString(5,(cAliasSBF)->BF_NUMLOTE)
			oPrepStat1:SetString(6,(cAliasSBF)->BF_LOCALIZ)
			oPrepStat1:SetString(7,(cAliasSBF)->BF_NUMSERI)

			//Recupera a consulta já com os parâmetros injetados
			If __l255VLib
				nTotBlock := oPrepStat1:ExecScalar("DC_QUANT")
			Else
				cQuery := oPrepStat1:GetFixQuery()
				nTotBlock := MpSysExecScalar(cQuery,"DC_QUANT")
			EndIf 
		Else
			nTotBlock := 0
		EndIf

		oSection2:Init()
		SB8->(dbSetOrder(3))
		SB8->( dbSeek( xFilial("SB8")+(cAliasSBF)->(BF_PRODUTO + BF_LOCAL + BF_LOTECTL + If(Rastro((cAliasSBF)->BF_PRODUTO, 'S'),(cAliasSBF)->BF_NUMLOTE,''))) )
		oSection2:Cell('B8_DTVALID'):SetValue(SB8->B8_DTVALID)
		oSection2:Cell('BF_QUANT'):SetValue((cAliasSBF)->BF_QUANT)
		oSection2:Cell('BF_EMPENHO'):SetValue((cAliasSBF)->BF_EMPENHO - nTotBlock)
		oSection2:Cell('DC_QUANT'):SetValue( nTotBlock )
		oSection2:Cell('Disponivel'):SetValue( oSection2:Cell('BF_QUANT'):GetValue() - oSection2:Cell('BF_EMPENHO'):GetValue() - oSection2:Cell('DC_QUANT'):GetValue()   )
		oSection2:PrintLine() // Impressao da secao 2

		oReport:IncMeter()

		If lImpBlock // Se mv_par05 == 2
			If oPrepStat2 == NIL
				cQuery := montaQuery("sdd.DD_DTVALID, sdd.DD_MOTIVO, sdd.DD_OBSERVA, sum(DC_QUANT) DC_QUANT",;
											"sdd.DD_PRODUTO, sdc.DC_LOTECTL, sdc.DC_NUMLOTE, sdc.DC_LOCALIZ, sdc.DC_NUMSERI, sdd.DD_DTVALID, sdd.DD_MOTIVO, sdd.DD_OBSERVA ";
											)
				If __l255VLib
					oPrepStat2 := FwExecStatement():New(cQuery)
				Else
					oPrepStat2 := FWPreparedStatement():New()
					oPrepStat2:SetQuery(cQuery)
				EndIf				
			EndIf

			oPrepStat2:SetString(1,(cAliasSBF)->BF_LOCALIZ)
			oPrepStat2:SetString(2,(cAliasSBF)->BF_LOCAL)
			oPrepStat2:SetString(3,(cAliasSBF)->BF_PRODUTO)
			oPrepStat2:SetString(4,(cAliasSBF)->BF_LOTECTL)
			oPrepStat2:SetString(5,(cAliasSBF)->BF_NUMLOTE)
			oPrepStat2:SetString(6,(cAliasSBF)->BF_LOCALIZ)
			oPrepStat2:SetString(7,(cAliasSBF)->BF_NUMSERI)

			cAliQry := ""
			//Recupera a consulta já com os parâmetros injetados
			If __l255VLib
				cAliQry := oPrepStat2:OpenAlias()
			Else
				cQuery := oPrepStat2:GetFixQuery()
				cAliQry := MPSysOpenQuery( cQuery , /*[cAlias]*/ , /*[aSetField]*/ )
			EndIf 

			If !Empty(cAliQry) .and. Select(cAliQry) >0
				If !(cAliQry)->(Eof())

					oSection3:Init()

					While !(cAliQry)->(Eof())
						dbSelectArea('SX5')
						dbSetOrder(1)
						If dbSeek(xFilial('SX5')+'E1'+(cAliQry)->DD_MOTIVO, .F.)
							cDescBloq := X5Descri()
						Else
							cDescBloq := ''
						EndIf

						oSection3:Cell( 'BF_LOTECTL' ):SetValue( STR0024 )
						oSection3:Cell( 'B8_DTVALID' ):SetValue( (cAliQry)->DD_DTVALID )
						oSection3:Cell( 'DD_MOTIVO' ):SetValue( (cAliQry)->DD_MOTIVO )
						oSection3:Cell( 'DescSitua' ):SetValue( cDescBloq )
						oSection3:Cell( 'DD_OBSERVA' ):SetValue( (cAliQry)->DD_OBSERVA )
						oSection3:Cell( 'DC_QUANT' ):SetValue( (cAliQry)->DC_QUANT )

						oSection3:PrintLine() // Impressao da secao 3
						(cAliQry)->(dbSkip())
					EndDo
					oSection3:Finish()

				EndIf
				(cAliQry)->(DbCloseArea())
				oReport:SkipLine()
			EndIf
		EndIf
		(cAliasSBF)->(dbSkip())
    EndDo
    oSection2:Finish()
EndDo
oSection1:Finish()
(cAliasSBF)->(DbCloseArea())

Return Nil

/*/{Protheus.doc} montaQuery
	Monta a query para consulta das quantidades bloqueadas do produto
	@type  Function
	@author reynaldo
	@since 15/10/2020
	@version 1.0
	@param cFields, caracter, string com os campos a serem utilizados no SELECT
	@param cGroupBy, caracter, string com os campos a serem utilizados no agrupamento do SELECT
	@return cQuery, caracter, Query para uso

	/*/
Static Function montaQuery(cFields, cGroupBy)
local cQuery

	cQuery := ""
	cQuery += "select " + cFields
	cQuery += "from "+RetSQLName("SDC")+" sdc "
	cQuery += "inner join "+RetSQLName("SDD")+" sdd "
	cQuery += "on sdd.DD_FILIAL ='" +xFilial("SDD")+ "' "
	cQuery += "and sdd.DD_IDSDD = sdc.DC_IDSDD "
	cQuery += "and sdd.DD_LOCAL = sdc.DC_LOCAL "
	cQuery += "and sdd.DD_PRODUTO = sdc.DC_PRODUTO "
	cQuery += "and sdd.DD_LOTECTL = sdc.DC_LOTECTL "
	cQuery += "and sdd.DD_NUMLOTE = sdc.DC_NUMLOTE "
	cQuery += "and (sdd.DD_LOCALIZ = ? OR sdd.DD_LOCALIZ = ' ') "
	cQuery += "and sdd.D_E_L_E_T_ = ' ' "
	cQuery += " where "
	cQuery += " sdc.DC_FILIAL = '" +xFilial("SDC")+ "' "
	cQuery += " and sdc.DC_ORIGEM = 'SDD' "
	cQuery += " and sdc.DC_LOCAL = ? "
	cQuery += " and sdc.DC_PRODUTO = ? "
	cQuery += " and sdc.DC_LOTECTL = ? "
	cQuery += " and sdc.DC_NUMLOTE = ? "
	cQuery += " and sdc.DC_LOCALIZ = ? "
	cQuery += " and sdc.DC_NUMSERI = ? "
	cQuery += " and sdc.D_E_L_E_T_ = ' ' "
	cQuery += "group by " + cGroupBy

	cQuery := ChangeQuery(cQuery)

Return cQuery
