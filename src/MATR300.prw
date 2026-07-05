/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR300.CH"
#INCLUDE "PROTHEUS.CH"
#DEFINE QTDENTRADA	1
#DEFINE QTDSAIDA	2
#DEFINE CUSTO	3
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR300  ³ Autor ³Alexandre Inacio Lemes ³ Data ³21/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao das movimentacoes internas                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR300(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MATR300()
Local oReport

oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Alexandre Inacio Lemes ³Data  ³21/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao das movimentacoes internas                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local aOrdem   := {STR0004,STR0005,STR0006,STR0007,STR0008,STR0009,STR0010,STR0011} //" Codigo Produto "###" Ordem Producao "###" Classificacao  "###" Tipo Produto   "###" Grupo Produto  "###" Centro Custo   "###" Conta Contabil "###" Nr. Documento  "
Local cTitle   := STR0001 //"Relacao das Movimentacoes Internas"
Local oReport
Local oSection1
Local oSection2
Local cCampoCus
Local cAliasSD3 := GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // Produto inicial                              ³
//³ mv_par02     // Produto final                                ³
//³ mv_par03     // Ordem de producao inicial                    ³
//³ mv_par04     // Ordem de producao final                      ³
//³ mv_par05     // classificacao do movimento inicial           ³
//³ mv_par06     // classificacao do movimento final             ³
//³ mv_par07     // tipo do produto inicial                      ³
//³ mv_par08     // tipo do produto final                        ³
//³ mv_par09     // grupo do produto inicial                     ³
//³ mv_par10     // grupo do produto final                       ³
//³ mv_par11     // centro de custo do produto inicial           ³
//³ mv_par12     // centro de custo do produto final             ³
//³ mv_par13     // conta contabil do produto inicial            ³
//³ mv_par14     // conta contabil do produto final              ³
//³ mv_par15     // moeda selecionada ( 1 a 5 )                  ³
//³ mv_par16     // Data inicial                                 ³
//³ mv_par17     // Data final                                   ³
//³ mv_par18     // 1 - Analitico , 2 - Sintetico                ³
//³ mv_par19     // De  Local                                    ³
//³ mv_par20     // Ate Local                                    ³
//³ mv_par21     // De  Documento                                ³
//³ mv_par22     // Ate Documento                                ³
//³ mv_par23     // De  Lote                                     ³
//³ mv_par24     // Ate Lote                                     ³
//³ mv_par25     // De  SubLote                                  ³
//³ mv_par26     // Ate SubLote                                  ³
//³ mv_par27     // Imprime a Descricao do Armazem               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR300",.F.)
cCampoCus := "D3_CUSTO"+Str(mv_par15,1)
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
oReport:= TReport():New("MTR300",cTitle,"MTR300", {|oReport| ReportPrint(oReport,aOrdem,cAliasSD3)},STR0002+" "+ STR0003 ) //"Lista  as  movimentacoes  internas  da empresa  ,ou seja ,Requisicoes ,""Devolucoes ,Producoes e Estornos de Producao."
oReport:SetTotalInLine(.F.)
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
oSection1:= TRSection():New(oReport,STR0051,{"SD3","SB1","NNR"},aOrdem) // "Produtos"
oSection1:SetTotalInLine(.F.)
oSection1:SetLineStyle()

TRCell():New(oSection1,"D3_COD"    ,"SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_DESC"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_TIPO"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D3_GRUPO"  ,"SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_UM"     ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"NNR_DESCRI","NNR",STR0042,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| If( mv_par27 ==1 .And. !Empty((cAliasSD3)->NNR_DESCRI) , (cAliasSD3)->D3_LOCAL+" - "+(cAliasSD3)->NNR_DESCRI, "" )})

oSection2:= TRSection():New(oSection1,STR0052,{"SD3"}) //"Itens de Movimentação Interna"
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderPage()

TRCell():New(oSection2,"D3_LOCAL"  ,"SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"QTDENTRADA","   ",STR0043,PesqPictQt("D3_QUANT",17),TamSX3("D3_QUANT")[1],/*lPixel*/,{|| If((cAliasSD3)->D3_TM <= "500" ,(cAliasSD3)->D3_QUANT, 0 ) })
TRCell():New(oSection2,"QTDSAIDA"  ,"   ",STR0044,PesqPictQt("D3_QUANT",17),TamSX3("D3_QUANT")[1],/*lPixel*/,{|| If((cAliasSD3)->D3_TM > "500",(cAliasSD3)->D3_QUANT, 0 ) })
TRCell():New(oSection2,"CUSTOUNIT" ,"   ",STR0045,PesqPict("SD3", "D3_CUSTO"+Str(mv_par15,1),17),/*Tamanho*/,/*lPixel*/,{|| (cAliasSD3)->&("D3_CUSTO"+Str(mv_par15,1)) / If((cAliasSD3)->D3_QUANT == 0,1,(cAliasSD3)->D3_QUANT ) })
TRCell():New(oSection2,"CUSTO"     ,"   ",STR0046,PesqPict("SD3", "D3_CUSTO"+Str(mv_par15,1),17),/*Tamanho*/,/*lPixel*/,{||  If((cAliasSD3)->D3_TM > "500",((cAliasSD3)->&("D3_CUSTO"+Str(mv_par15,1)))* -1,(cAliasSD3)->&("D3_CUSTO"+Str(mv_par15,1))) })
TRCell():New(oSection2,"D3_TM"     ,"SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D3_CF"     ,"SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D3_OP"     ,"SD3",STR0047,"@!",6,/*lPixel*/,{|| SubStr(D3_OP,1,6) }) //"Ordem Producao"
TRCell():New(oSection2,"D3_OP"     ,"SD3",STR0048,"@!",2,/*lPixel*/,{|| SubStr(D3_OP,7,2) })
TRCell():New(oSection2,"D3_OP"     ,"SD3",STR0049,"@!",3,/*lPixel*/,{|| SubStr(D3_OP,9,3) })
TRCell():New(oSection2,"D3_NUMSEQ" ,"SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D3_CC"     ,"SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D3_CONTA"  ,"SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D3_DOC"    ,"SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D3_EMISSAO","SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D3_USUARIO","SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Alexandre Inacio Lemes ³Data  ³21/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao das movimentacoes internas                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aOrdem,cAliasSD3)

Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local nOrdem     := oReport:Section(1):GetOrder()
Local aFileCtb   := { "CT1", "CTT" }
Local cCposCtb   := If( nOrdem ==6 , "CTT->CTT_CUSTO + '-' + CTT->CTT_DESC" + StrZero(mv_par15, 2) , ;
                  						 "CT1->CT1_DESC" + StrZero(mv_par15, 2))
Local cCampoCus := "D3_CUSTO"+Str(mv_par15,1)
Local cPicD3Cust := PesqPict("SD3", cCampoCus,17)
Local cChave	 := ""
Local cCodPro	 := ""
Local cKeyForTot := ""
Local cSubTotal  := ""
Local cTotaliza  := ""
Local cSubCtb    := ""
Local nProdSegEnt:= 0
Local nProdSegSai:= 0
Local nTotSegEnt := 0
Local nTotSegSai := 0
Local cWhereD3   := '%%'
Local cOrder    := ""
Local lSintetico := (mv_par18 == 2)
Local nQtd := 0
Local nQtd2:= 0
Local aProd := {0,0,0}
Local nRowPos := 0
Local lPlanTab := oReport:lXlsTable .And. mv_par27 == 1
Local cSQLFields
Local nX
Local aFieldSQL
Local lFirstFld := .T.

If oReport:lXlsTable .and. mv_par18==2
	ApMsgAlert(STR0056) //"Formato de Planilha não atende modo Sintético, verifique Parametro "
	oReport:CancelPrint()
Endif

oSection1:SetTotalText("Total Produto") //"Total Produto"
TRFunction():New(oSection2:Cell("QTDENTRADA"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.T.,,oSection1)
TRFunction():New(oSection2:Cell("QTDSAIDA"  ),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.T.,,oSection1)
TRFunction():New(oSection2:Cell("CUSTO"     ),NIL,"SUM",/*oBreak1*/,,cPicD3Cust,/*uFormula*/,.T.,.T.,,oSection1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + STR0040+AllTrim(aOrdem[nOrdem])+STR0041+AllTrim(GetMv("MV_SIMB"+Ltrim(Str(mv_par15))))+")" )//" (Por "###" ,em "

dbSelectArea("SD3")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

If ! __lPyme
	cWhereD3 := "%"
	cWhereD3 += "D3_LOTECTL >= '"+mv_par23+"' AND "
	cWhereD3 += "D3_LOTECTL <= '"+mv_par24+"' AND "
	cWhereD3 += "D3_NUMLOTE >= '"+mv_par25+"' AND "
	cWhereD3 += "D3_NUMLOTE <= '"+mv_par26+"' AND "
	cWhereD3 += "%"
Endif

Do Case
	Case nOrdem == 1
		cOrder := "% D3_FILIAL,D3_COD,D3_LOCAL,D3_NUMSEQ %"
	Case nOrdem == 2
		cOrder := "% D3_FILIAL,D3_OP,D3_COD,D3_LOCAL %"
	Case nOrdem == 3
		cOrder := "% D3_FILIAL,D3_CF,D3_COD,D3_LOCAL %"
	Case nOrdem == 4
		cOrder := "% D3_FILIAL,D3_TIPO,D3_COD,D3_LOCAL %"
	Case nOrdem == 5
		cOrder := "% D3_FILIAL,D3_GRUPO,D3_COD,D3_LOCAL %"
	Case nOrdem == 6
		cOrder := "% D3_FILIAL,D3_CC,D3_COD,D3_LOCAL %"
	Case nOrdem == 7
		cOrder := "% D3_FILIAL,D3_CONTA,D3_COD,D3_LOCAL %"
	Case nOrdem == 8
		cOrder := "% D3_FILIAL,D3_DOC,D3_COD %"
EndCase


Do Case
	Case nOrdem == 1
		cKeyForTot := "D3_COD"
		cSubTotal  := STR0017 //"......... Total do Produto "
	Case nOrdem == 2
		cKeyForTot := "D3_OP"
		cSubTotal  := STR0018 //"......... Total da Ordem de Producao "
	Case nOrdem == 3
		cKeyForTot := "D3_CF"
		cSubTotal  := STR0020 //"......... Total da Classificacao "
	Case nOrdem == 4
		cKeyForTot := "D3_TIPO"
		cSubTotal  := STR0021 //"......... Total do Tipo "
	Case nOrdem == 5
		cKeyForTot := "D3_GRUPO"
		cSubTotal  := STR0022 //"......... Total do Grupo "
	Case nOrdem == 6
		cKeyForTot := "D3_CC"
		cSubTotal  := STR0023 //"......... Total do Centro de Custo"
	Case nOrdem == 7
		cKeyForTot := "D3_CONTA"
		cSubTotal  := STR0024 //"......... Total da Conta"
	Case nOrdem == 8
		cKeyForTot := "D3_DOC"
		cSubTotal  := STR0025 //"......... Total do Documento "
EndCase

// monta os campos que tem nas colunas da 1a seç?o do treport para o SELECT
cSQLFields := ""
nQtdCol := Len(oSection1:aCell)
For nX := 1 to nQtdCol
	If !Empty(oSection1:aCell[nX]:cAlias)
		If !lFirstFld
			cSQLFields += " ,"
			cSQLFields += oSection1:aCell[nX]:cAlias
			cSQLFields += "."
			cSQLFields += oSection1:aCell[nX]:cName
		Else
			cSQLFields += oSection1:aCell[nX]:cAlias
			cSQLFields += "."
			cSQLFields += oSection1:aCell[nX]:cName
			lFirstFld := .F.
		EndIf
	EndIf
Next nX

// monta os campos que tem nas colunas da 1a seç?o do treport para o SELECT
nQtdCol := Len(oSection2:aCell)
For nX := 1 to nQtdCol
	If At(oSection2:aCell[nX]:cName,cSQLFields) == 0
		If ! Empty(oSection2:aCell[nX]:cAlias)
			cSQLFields += " ,"
			cSQLFields += oSection2:aCell[nX]:cAlias
			cSQLFields += "."
			cSQLFields += oSection2:aCell[nX]:cName
		EndIf
	EndIf
Next nX

aFieldSQL := {"D3_QTSEGUM","D3_OP","D3_TM",cCampoCus,"D3_QUANT","D3_CC","D3_CONTA","D3_DOC"}
nQtdCol := len(aFieldSQL)
For nX := 1 to nQtdCol
	If at(aFieldSQL[nX],cSQLFields) == 0
		cSQLFields += " ,"
		cSQLFields += "SD3."
		cSQLFields += aFieldSQL[nX]
	EndIf
Next nX

If at(cKeyForTot,cSQLFields) == 0
	cSQLFields += " ,"
	cSQLFields += "SD3."
	cSQLFields += cKeyForTot
EndIf

cSQLFields := "%"+cSQLFields+"%"

oReport:Section(1):BeginQuery()

BeginSql Alias cAliasSD3

	SELECT SD3.R_E_C_N_O_ SD3RECNO, %Exp:cSQLFields%
	FROM %table:SD3% SD3
	LEFT JOIN %table:SB1% SB1 ON
		SB1.B1_FILIAL  = %xFilial:SB1% AND
		SB1.B1_COD  = SD3.D3_COD
	LEFT JOIN %table:NNR% NNR ON
		NNR.NNR_FILIAL  = %xFilial:NNR% AND
		NNR.NNR_CODIGO  = SD3.D3_LOCAL
	WHERE SD3.D3_FILIAL  = %xFilial:SD3% AND
		SD3.D3_COD      >= %Exp:mv_par01% AND
	    SD3.D3_COD      <= %Exp:mv_par02% AND
	    SD3.D3_OP       >= %Exp:mv_par03% AND
	    SD3.D3_OP       <= %Exp:mv_par04% AND
	    SD3.D3_CF       >= %Exp:mv_par05% AND
	    SD3.D3_CF       <= %Exp:mv_par06% AND
	    SD3.D3_TIPO     >= %Exp:mv_par07% AND
	    SD3.D3_TIPO     <= %Exp:mv_par08% AND
	    SD3.D3_GRUPO    >= %Exp:mv_par09% AND
	    SD3.D3_GRUPO    <= %Exp:mv_par10% AND
	    SD3.D3_CC       >= %Exp:mv_par11% AND
	    SD3.D3_CC       <= %Exp:mv_par12% AND
	    SD3.D3_CONTA    >= %Exp:mv_par13% AND
	    SD3.D3_CONTA    <= %Exp:mv_par14% AND
	    SD3.D3_EMISSAO  >= %Exp:Dtos(mv_par16)% AND
	    SD3.D3_EMISSAO  <= %Exp:Dtos(mv_par17)% AND
	    SD3.D3_LOCAL    >= %Exp:mv_par19% AND
	    SD3.D3_LOCAL    <= %Exp:mv_par20% AND
	    SD3.D3_DOC      >= %Exp:mv_par21% AND
	    SD3.D3_DOC      <= %Exp:mv_par22% AND
	    %Exp:cWhereD3%
	    SD3.%NotDel% AND
	    SB1.%NotDel% AND
	    NNR.%NotDel%
	ORDER BY %Exp:cOrder%
EndSql

oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

oSection2:SetParentQuery()
If lSintetico
	oSection2:Hide()
EndIf

If mv_par27 == 2
 	oSection1:Cell("NNR_DESCRI"):Disable()
EndIf
TRPosition():New(oSection1,"SB1",1,{|| xFilial("SB1") + (cAliasSD3)->D3_COD })

oReport:SetMeter((cAliasSD3)->(LastRec()))
dbSelectArea(cAliasSD3)

While !oReport:Cancel() .And. !(cAliasSD3)->(Eof())

	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf

	SD3->(MsGoto((cAliasSD3)->SD3RECNO))

	If !D3Valido()
		(cAliasSD3)->(dbSkip())
		Loop
	EndIf

	// Acumula a quantidade por movimento do produto e tipo
	aProd[QTDENTRADA] := 0
	aProd[QTDSAIDA] := 0
	aProd[CUSTO] := 0

	cChave := (cAliasSD3)->&(cKeyForTot)
   While !oReport:Cancel() .And. !(cAliasSD3)->(Eof()) .And. cChave == (cAliasSD3)->&(cKeyForTot)
		// Acumula quantidade por movimento do produto e tipo na 2a unidade de medida
		nProdSegEnt := 0
		nProdSegSai := 0

    	oSection1:Init()
    	If !lPlanTab
			oSection1:PrintLine()
		EndIf

    	cCodPro:= (cAliasSD3)->D3_COD
  		cTotaliza := (cAliasSD3)->&(cKeyForTot)

		oSection2:Init()
		While !oReport:Cancel() .And. !(cAliasSD3)->(Eof()) .And. cChave == (cAliasSD3)->&(cKeyForTot) .AND. cCodPro == (cAliasSD3)->D3_COD

			oReport:IncMeter()
			If oReport:Cancel()
				Exit
			EndIf

			SD3->(MsGoto((cAliasSD3)->SD3RECNO))

			If !D3Valido()
				(cAliasSD3)->(dbSkip())
				Loop
			EndIf

			If lPlanTab
				oSection1:Cell("NNR_DESCRI"):SetValue((cAliasSD3)->NNR_DESCRI)
				oSection1:PrintLine()
			EndIf

			oSection2:PrintLine()

			nQtd := (cAliasSD3)->D3_QUANT
			nQtd2:= If(SB1->B1_CONV>0,ConvUm((cAliasSD3)->D3_COD,(cAliasSD3)->D3_QUANT,0,2),(cAliasSD3)->D3_QTSEGUM )
			nCusto := (cAliasSD3)->&cCampoCus
			If (cAliasSD3)->D3_TM <= "500"
				aProd[QTDENTRADA] += nQtd
				nProdSegEnt += nQtd2
				aProd[CUSTO] += nCusto
			Else
				aProd[QTDSAIDA] += nQtd
				nProdSegSai += nQtd2
				aProd[CUSTO] -= nCusto
		    EndIf
			cSubCtb := ""
			If nOrdem == 6 .Or. nOrdem == 7
				If nOrdem == 6 .And. (aFileCtb[2])->(dbSeek(xFilial(aFileCtb[2])+(cAliasSD3)->D3_CC,   .F.)) .Or. ;
				   nOrdem == 7 .And. (aFileCtb[1])->(dbSeek(xFilial(aFileCtb[1])+(cAliasSD3)->D3_CONTA,.F.))
				   cSubCtb := &(cCposCtb)
				ElseIf !Empty((cAliasSD3)->D3_CC) .Or. !Empty((cAliasSD3)->D3_CONTA)
				   cSubCtb := STR0037 // ' ** CC nao cadastrado ** '
				EndIf
			EndIf

			dbSelectArea(cAliasSD3)
			dbSkip()
		EndDo // Loop produto

		oSection2:Finish()

		// Acumula quantidade Geral na segunda unidade de medida
		nTotSegEnt += nProdSegEnt
		nTotSegSai += nProdSegSai

		// Total do produto na 2a unidade de medida
		oReport:PrintText(STR0033+SB1->B1_SEGUM+STR0034+TransForm(nProdSegEnt,cPicD3Cust)+"   "+;
							STR0035+TransForm(nProdSegSai,cPicD3Cust),,oSection1:Cell("B1_UM"):ColPos()) //"Quantidade na Seg. UM ("##"): Entrada -> "##"Saida -> "

		oSection1:Finish()

	EndDo // loop ordenacao

	If nOrdem <> 1
		oReport:SkipLine()
		oReport:ThinLine()
		// imprime o TOTAL POR TIPO
		nRowPos := oReport:nRow
		oReport:PrintText(Transform(aProd[QTDENTRADA], PesqPictQt("D3_QUANT",17)),      , oSection2:Cell("QTDENTRADA"):ColPos())
		oReport:PrintText(Transform(aProd[QTDSAIDA], PesqPictQt("D3_QUANT",17)), nRowPos, oSection2:Cell("QTDSAIDA"):ColPos())
		oReport:PrintText(Transform(aProd[CUSTO]   , cPicD3Cust), nRowPos, oSection2:Cell("CUSTO"):ColPos())
		oReport:PrintText(cSubTotal + " " + cTotaliza + " "+cSubCtb,, oSection1:Cell("B1_UM"):ColPos()) //Sub Total por Tipo definido
		oReport:SkipLine()
	EndIf
EndDo

// total geral na 2a unidade de medida
oReport:PrintText(STR0055+space(TamSx3('B1_SEGUM')[1]+2)+Right(STR0034,len(STR0034)-2)+TransForm(nTotSegEnt ,cPicD3Cust)+"   "+;
					STR0035+TransForm(nTotSegSai, cPicD3Cust),oReport:Row()+2,oSection1:Cell("B1_UM"):ColPos())//"Total Geral Qtde.2a.um:"##"): Entrada -> "##"Saida -> "

Return Nil
