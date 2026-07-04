/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR285.CH"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR285  ³ Autor ³ Marcos V. Ferreira    ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Listagem dos itens inventariados                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR285()

Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Marcos V. Ferreira     ³ Data ³20/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR285			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local aOrdem    := {OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009)}		//' Por Codigo    '###' Por Tipo      '###' Por Grupo   '###' Por Descricao '###' Por Local    '
Local cPictQFim := PesqPict("SB2",'B2_QFIM',20)
Local cPictQtd  := PesqPict("SB7",'B7_QUANT',20)
Local cPictVFim := PesqPict("SB2",'B2_VFIM1',20)
Local cTamQFim  := 20
Local cTamQtd   := 20
Local cTamVFim  := 20
Local cAliasSB1 := GetNextAlias()
Local cAliasSB2 := cAliasSB1
Local cAliasSB7 := cAliasSB1
Local oSection1
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
oReport:= TReport():New("MATR285",STR0001,"MTR285", {|oReport| ReportPrint(oReport,aOrdem,cAliasSB1,cAliasSB2,cAliasSB7)},STR0002+" "+STR0003+" "+STR0004)
oReport:DisableOrientation()
oReport:SetLandscape() //Define a orientacao de pagina do relatorio como paisagem.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01             // Produto de                           ³
//³ MV_PAR02             // Produto ate                          ³
//³ MV_PAR03             // Data de Selecao                      ³
//³ MV_PAR04             // De  Tipo                             ³
//³ MV_PAR05             // Ate Tipo                             ³
//³ MV_PAR06             // De  Local                            ³
//³ MV_PAR07             // Ate Local                            ³
//³ MV_PAR08             // De  Grupo                            ³
//³ MV_PAR09             // Ate Grupo                            ³
//³ MV_PAR10             // Qual Moeda (1 a 5)                   ³
//³ MV_PAR11             // Imprime Lote/Sub-Lote                ³
//³ MV_PAR12             // Custo Medio Atual/Ultimo Fechamento  ³
//³ MV_PAR13             // Imprime Localizacao ?                ³
//³ MV_PAR14             // Listar Produtos ?                    ³
//³ MV_PAR15             // Imprime totalizador por quebra?      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da secao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a secao.                   ³
//³ExpA4 : Array com as Ordens do relatorio                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Sessao 1                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:= TRSection():New(oReport,STR0050,{"SB1","SB7","SB2"},aOrdem) // "Lancamentos para Inventario"
oSection1:SetTotalInLine(.F.)
oSection1:SetNoFilter("SB7")
oSection1:SetNoFilter("SB2")

TRCell():New(oSection1,'B1_CODITE'	,cAliasSB1	,STR0027				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_COD'		,cAliasSB1	,STR0027				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_DESC'	,cAliasSB1	,STR0028				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_LOTECTL'	,cAliasSB7	,STR0029				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_NUMLOTE'	,cAliasSB7	,STR0030+CRLF+STR0029	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_LOCALIZ'	,cAliasSB7	,STR0031				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_NUMSERI'	,cAliasSB7	,STR0032				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_TIPO'	,cAliasSB1	,STR0033				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_GRUPO'	,cAliasSB1	,STR0034				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_UM'		,cAliasSB1	,STR0035				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_LOCAL'	,cAliasSB7	,STR0036				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_DOC'		,cAliasSB7	,STR0037				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_QUANT'	,cAliasSB7	,STR0038+CRLF+STR0039	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,'QUANTDATA'	,'   '		,STR0040+CRLF+STR0041	,cPictQFim	,cTamQFim	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,'DIFQUANT'	,'   '		,STR0042+CRLF+STR0043	,cPictQtd	,cTamQtd	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,'DIFVALOR'	,'   '		,STR0042+CRLF+STR0044	,cPictVFim	,cTamVFim	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")

oSection1:SetHeaderPage()
oSection1:SetTotalText(STR0049) // "T o t a l  G e r a l :"

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Marcos V. Ferreira   ³ Data ³20/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR285			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aOrdem,cAliasSB1,cAliasSB2,cAliasSB7)

Local oSection1 := oReport:Section(1)
Local nOrdem    := oSection1:GetOrder()
local oSaldoWMS := Nil
Local cSeek     := ''
Local cCompara  := ''
Local cLocaliz  := ''
Local cNumSeri  := ''
Local cLoteCtl  := ''
Local cNumLote  := ''
Local cProduto  := ''
Local cLocal    := ''
Local cTipo     := ''
Local cGrupo    := ''
Local cWhere    := ''
Local cOrderBy  := ''
Local lSB7Cnt   := .T.
Local nTotal    := 0
Local nX        := 0
Local nTotRegs  := 0
Local nSaldo	:= 0
Local aSaldo    := {}
Local aSalQtd   := {}
Local aCM       := {}
Local lImprime  := .T.
Local lContagem := SuperGetMv('MV_CONTINV',.F.,.F.)
Local lVeic		:= Upper(GetMV("MV_VEICULO"))=="S"
Local lWmsNew   := SuperGetMV("MV_WMSNEW",.F.,.F.)
Local oBreak
Local oBreak01
Local lFirst    := .F.
Local lEmAberto := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title()+' (' + AllTrim(aOrdem[nOrdem]) + ')')
oSection1:Cell('B1_COD'):SetAutoSize(.T.) 		
oSection1:Cell('B1_COD'):SetLineBreak(.T.) 		
oSection1:Cell('B1_DESC'):SetAutoSize(.T.) 		
oSection1:Cell('B1_DESC'):SetLineBreak(.T.) 		

// Deve imprimir totalizador por quebra de seção
If MV_PAR15 == 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definicao da linha de SubTotal                               |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oBreak01 := TRBreak():New(oSection1,oSection1:Cell("B1_COD"),STR0045,.F.)
	TRFunction():New(oSection1:Cell('B7_QUANT'	),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection1:Cell('QUANTDATA'	),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection1:Cell('DIFQUANT'	),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection1:Cell('DIFVALOR'	),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	
	If nOrdem == 2 .Or. nOrdem == 3 .Or. nOrdem == 5
		If nOrdem == 2
			//-- SubtTotal por Tipo
			oBreak := TRBreak():New(oSection1,oSection1:Cell("B1_TIPO"),STR0046,.F.) //"SubTotal do Tipo : "
		ElseIf nOrdem == 3
			//-- SubtTotal por Grupo
			oBreak := TRBreak():New(oSection1,oSection1:Cell("B1_GRUPO"),STR0047,.F.) //"SubTotal do Grupo : "
		ElseIf nOrdem == 5
			//-- SubtTotal por Armazem
			oBreak := TRBreak():New(oSection1,oSection1:Cell("B7_LOCAL"),STR0048,.F.) //"SubTotal do Armazem : "
		EndIf
		TRFunction():New(oSection1:Cell('B7_QUANT'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
		TRFunction():New(oSection1:Cell('QUANTDATA'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
		TRFunction():New(oSection1:Cell('DIFQUANT'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
		TRFunction():New(oSection1:Cell('DIFVALOR'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao do Total Geral do Relatorio                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRFunction():New(oSection1:Cell('B7_QUANT'	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oSection1:Cell('QUANTDATA'	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oSection1:Cell('DIFQUANT'	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oSection1:Cell('DIFVALOR'	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desliga as colunas que nao serao utilizadas no relatorio     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lVeic
	oSection1:Cell('B1_CODITE'	):Disable()
Else
	oSection1:Cell('B1_COD'		):Disable()
EndIf

If !(MV_PAR11 == 1)
	oSection1:Cell('B7_LOTECTL'	):Disable()
	oSection1:Cell('B7_NUMLOTE'	):Disable()
EndIf

If !(MV_PAR13 == 1)
	oSection1:Cell('B7_LOCALIZ'	):Disable()
	oSection1:Cell('B7_NUMSERI'	):Disable()
EndIf

dbSelectArea('SB2')
dbSetOrder(1)

dbSelectArea('SB7')
dbSetOrder(1)

dbSelectArea('SB1')
dbSetOrder(1)

nTotRegs += SB2->(LastRec())
nTotRegs += SB7->(LastRec())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ ORDER BY - Adicional                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cOrderBy := "%"
If nOrdem == 1 //-- Por Codigo
	If lVeic
		cOrderBy += " B1_FILIAL, B1_CODITE "
	Else
		cOrderBy += " B1_FILIAL, B1_COD, B7_DOC, B7_STATUS, B7_LOTECTL, B7_NUMLOTE, B7_LOCALIZ "
	EndIf
ElseIf nOrdem == 2 //-- Por Tipo
	cOrderBy += " B1_FILIAL, B1_TIPO, B1_COD, B7_DOC, B7_STATUS "
ElseIf nOrdem == 3 //-- Por Grupo
	If lVeic
		cOrderBy += " B1_FILIAL, B1_GRUPO, B1_CODITE "
	Else
		cOrderBy += " B1_FILIAL, B1_GRUPO, B1_COD, B7_DOC, B7_STATUS "
	EndIf
	cOrderBy += ", B7_LOCAL"
ElseIf nOrdem == 4 //-- Por Descricao
	cOrderBy += "B1_FILIAL, B1_DESC, B1_COD, B7_DOC, B7_STATUS"
ElseIf nOrdem == 5 //-- Por Local
	If lVeic
		cOrderBy += " B1_FILIAL, B7_LOCAL, B1_CODITE"
	Else
		cOrderBy += " B1_FILIAL, B7_LOCAL, B1_COD, B7_DOC, B7_STATUS"
	EndIf
EndIf
cOrderBy += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ WHERE - Adicional                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cWhere   := "%"
If lVeic
	cWhere   += "SB1.B1_CODITE	>= '"+MV_PAR01+"' AND SB1.B1_CODITE <= '"+MV_PAR02+	"' "
Else
	cWhere   += "SB1.B1_COD	>= '"+MV_PAR01+"' AND SB1.B1_COD	<= '"+MV_PAR02+	"' "
EndIf
If lContagem
	If ! Empty(cWhere)
		cWhere   += " AND "
	EndIf
	cWhere   += " SB7.B7_ESCOLHA = 'S' "
EndIf
cWhere   += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da Query do relatorio                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:BeginQuery()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicio do Embedded SQL                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BeginSql Alias cAliasSB1

		SELECT 	SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_TIPO, SB1.B1_GRUPO, SB1.B1_DESC, SB1.B1_UM, SB1.B1_CODITE,
				SB7.B7_FILIAL, SB7.B7_COD, SB7.B7_LOCAL, SB7.B7_LOCALIZ, SB7.B7_DATA,
				SB7.B7_NUMSERI, SB7.B7_LOTECTL, SB7.B7_NUMLOTE, SB7.B7_DOC, SB7.B7_ESCOLHA,
				SUM(SB7.B7_QUANT) B7_QUANT, SB7.B7_STATUS
		FROM %table:SB7% SB7
		INNER JOIN %table:SB1% SB1 ON SB1.B1_FILIAL = %xFilial:SB1%
										AND SB1.B1_COD = SB7.B7_COD
										AND SB1.B1_TIPO BETWEEN %Exp:MV_PAR04% AND %Exp:MV_PAR05%
										AND SB1.B1_GRUPO BETWEEN %Exp:MV_PAR08%	AND %Exp:MV_PAR09%
										AND SB1.%NotDel%
		WHERE
			SB7.B7_FILIAL =  %xFilial:SB7%
			AND SB7.B7_LOCAL BETWEEN %Exp:MV_PAR06%	AND %Exp:MV_PAR07%
			AND SB7.B7_DATA = %Exp:Dtos(MV_PAR03)%
			AND SB7.%NotDel%
			AND %Exp:cWhere%
		GROUP BY SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_TIPO,
				SB1.B1_GRUPO, SB1.B1_DESC, SB1.B1_UM, SB1.B1_CODITE,
				SB7.B7_FILIAL, SB7.B7_COD, SB7.B7_LOCAL, SB7.B7_LOCALIZ, SB7.B7_DATA,
				SB7.B7_NUMSERI, SB7.B7_LOTECTL, SB7.B7_NUMLOTE, SB7.B7_DOC,
				SB7.B7_ESCOLHA, SB7.B7_STATUS
		ORDER BY %Exp:cOrderBy%

	EndSql

oSection1:EndQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abertura do Arquivo de Trabalho                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAliasSB1)
oReport:SetMeter(nTotRegs)

SB7->(dbSetOrder(1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento do Relatorio                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Init(.F.)
While !oReport:Cancel() .And. !(cAliasSB7)->(Eof())

	oReport:IncMeter()

	If cSeek <> (cAliasSB7)->&(cCompara)

		nTotal     := 0
		lSB7Cnt    := .T.
		lImprime   := .T.
		cSeek      := xFilial('SB7')+DTOS(MV_PAR03)+(cAliasSB7)->B7_COD+(cAliasSB7)->B7_LOCAL+(cAliasSB7)->B7_LOCALIZ+(cAliasSB7)->B7_NUMSERI+(cAliasSB7)->B7_LOTECTL+(cAliasSB7)->B7_NUMLOTE
		cCompara   := "B7_FILIAL+DTOS(B7_DATA)+B7_COD+B7_LOCAL+B7_LOCALIZ+B7_NUMSERI+B7_LOTECTL+B7_NUMLOTE"
		cProduto   := (cAliasSB7)->B7_COD
		cLocal     := (cAliasSB7)->B7_LOCAL
		cLocaliz   := (cAliasSB7)->B7_LOCALIZ
		cNumSeri   := (cAliasSB7)->B7_NUMSERI
		cLoteCtl   := (cAliasSB7)->B7_LOTECTL
		cNumLote   := (cAliasSB7)->B7_NUMLOTE
		cTipo      := (cAliasSB1)->B1_TIPO
		cGrupo     := (cAliasSB1)->B1_GRUPO
		lFirst     := .T.
		lEmAberto  := .F.
		nTotal     := A285Total(cAliasSB7,lContagem,@lEmAberto,@lSB7Cnt)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica a Quantidade Disponivel/Custo Medio                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SB2->(DbSeek(xFilial("SB2")+cProduto+cLocal))
			If (Localiza(cProduto,.T.) .And. !Empty(cLocaliz+cNumSeri)) .Or. (Rastro(cProduto) .And. !Empty(cLotectl+cNumLote))
				If IntDl(cProduto) .and. lWmsNew
					oSaldoWMS 	:= WMSDTCEstoqueEndereco():New()
					aSalQtd   := oSaldoWMS:SldPrdData(cProduto,cLocal,MV_PAR03,cLoteCtl,cNumLote,cLocaliz,cNumSeri)
				Else
					aSalQtd   := CalcEstL(cProduto,cLocal,MV_PAR03+1,cLoteCtl,cNumLote,cLocaliz,cNumSeri)
				EndIf
				aSaldo    := CalcEst(cProduto,cLocal,MV_PAR03+1)
				aSaldo[2] := (aSaldo[2] / aSaldo[1]) * aSalQtd[1]
				aSaldo[3] := (aSaldo[3] / aSaldo[1]) * aSalQtd[1]
				aSaldo[4] := (aSaldo[4] / aSaldo[1]) * aSalQtd[1]
				aSaldo[5] := (aSaldo[5] / aSaldo[1]) * aSalQtd[1]
				aSaldo[6] := (aSaldo[6] / aSaldo[1]) * aSalQtd[1]
				aSaldo[7] := aSalQtd[7]
				aSaldo[1] := aSalQtd[1]
			Else
				aSaldo := CalcEst(cProduto,cLocal,MV_PAR03+1)
			EndIf
			If MV_PAR12 == 1
				aCM:={}
				If QtdComp(aSaldo[1]) > QtdComp(0)
					For nX:=2 to Len(aSaldo)
						aAdd(aCM,aSaldo[nX]/aSaldo[1])
					Next nX
				Else
					aCM := PegaCmAtu(cProduto,cLocal)
				EndIf
			Else
				aCM := PegaCMFim(cProduto,cLocal)
			EndIf
		Else
			aSaldo := {0,0}
			aCM    := {0,0,0,0,0}
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ lImprime - Variavel utilizada para verificar se o usuario deseja |
		//| Listar Produto: 1-Com Diferencas / 2-Sem Diferencas / 3-Todos    |                              |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTotal-aSaldo[1] == 0
			If MV_PAR14 == 1
				lImprime := .F.
			EndIf
		Else
			If MV_PAR14 == 2
				lImprime := .F.
			EndIf
		EndIf
	Else
		nTotal  := A285Total(cAliasSB7,lContagem,@lEmAberto,@lSB7Cnt)
		lFirst  := .F.
	EndIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do Inventario                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lSB7Cnt .AND.(lImprime .Or. MV_PAR14 == 3)
		If lFirst
			nSaldo := aSaldo[1]
		Else
			nSaldo := 0
		EndIf 	
		oSection1:Cell('B7_QUANT'	):SetValue(nTotal)
		oSection1:Cell('QUANTDATA'	):SetValue(nSaldo)
		oSection1:Cell('DIFQUANT'	):SetValue(nTotal - nSaldo )
		oSection1:Cell('DIFVALOR'	):SetValue((nTotal - nSaldo)*aCM[MV_PAR10])
		
		// Sem quebra de seção, imprime todas as celulas
		If MV_PAR15 == 1
			If lFirst
				oSection1:Cell('B1_CODITE'	):Show()
				oSection1:Cell('B1_COD'	 	):Show()
				oSection1:Cell('B1_TIPO'	):Show()
				oSection1:Cell('B1_DESC'	):Show()
				oSection1:Cell('B1_GRUPO'	):Show()
				oSection1:Cell('B1_UM'		):Show()
				oSection1:Cell('B7_LOCAL'	):Show()
				oSection1:Cell('B7_LOTECTL'	):Show()
				oSection1:Cell('B7_NUMLOTE'	):Show()
				oSection1:Cell('B7_LOCALIZ'	):Show()
				oSection1:Cell('B7_NUMSERI'	):Show()
				oSection1:Cell('QUANTDATA'	):Show()
			Else
				oSection1:Cell('B1_CODITE'	):Hide()
				oSection1:Cell('B1_COD'		):Hide()
				oSection1:Cell('B1_TIPO'  	):Hide()
				oSection1:Cell('B1_DESC'  	):Hide()
				oSection1:Cell('B1_GRUPO' 	):Hide()
				oSection1:Cell('B1_UM'    	):Hide()
				oSection1:Cell('B7_LOCAL' 	):Hide()
				oSection1:Cell('B7_LOTECTL'	):Hide()
				oSection1:Cell('B7_NUMLOTE'	):Hide()
				oSection1:Cell('B7_LOCALIZ'	):Hide()
				oSection1:Cell('B7_NUMSERI'	):Hide()
				oSection1:Cell('QUANTDATA'	):Hide()
			EndIF

			oSection1:Cell('B7_QUANT'	):Show()
			oSection1:Cell('DIFQUANT'	):Show()
			oSection1:Cell('DIFVALOR'	):Show()
		EndIf

		oSection1:PrintLine()

	EndIf

(cAliasSB7)->(dbSkip())

EndDo

oSection1:Finish()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A285Total
Função responsável por calcular a quantidade inventariada, identificando
lançamentos processados e não processados

@author Squad Entradas
@param cAliasSB7  Alias temporário com registros da tabela SB7
@param lContagem  Informa se o inventário por contagem está habilitado 
@param lEmAberto  Variável responsável por informar se existe lançamentos
				  de inventário em aberto para o produto
@param lSB7Cnt    Informa se a linha do produto deve ou não ser impressa

@since 20/01/2023
@version P12
@return
/*/
//-------------------------------------------------------------------
Static Function A285Total(cAliasSB7,lContagem,lEmAberto,lSB7Cnt)
Local nTotal := 0

If lContagem
	nTotal += (cAliasSB7)->B7_QUANT
Else
	If (cAliasSB7)->B7_STATUS == "1"
		nTotal 	   := (cAliasSB7)->B7_QUANT
		lEmAberto  := .T.
	Else
		If !lEmAberto
			nTotal += (cAliasSB7)->B7_QUANT
		Else
			lSB7Cnt := .F.
		EndIf
	EndIf
EndIf

Return nTotal
