/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR260.CH"
#INCLUDE "PROTHEUS.CH"

Static __aNameCells := {}
Static __oTmpTab  := NIL
Static __cNameIndex := NIL
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR260  ³ Autor ³ Marcos V. Ferreira    ³ Data ³ 16/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Posicao dos Estoques                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function MATR260()
Local oReport

Private aMV_PAR		:= array(25) // total de perguntas do grupo MTR260R1
Private cPerg		:= ""

cPerg := DefineSX1() // grupo de pergunta

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
±±³Programa  ³ReportDef ³ Autor ³Marcos V. Ferreira     ³ Data ³16/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR260			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local aOrdem    := {OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009)}    //" Por Codigo         "###" Por Tipo           "###" Por Descricao     "###" Por Grupo        "###" Por Almoxarifado   "
Local cAliasTRB	:= GetNextAlias()
Local nSizeQT	:= TamSX3("B2_QATU")[1] + 4
Local nSizeVL	:= TamSX3("B2_VATU1")[1] + 4
Local nTamProd	:= TamSX3("B1_COD")[1] + 5
Local nSizeLZ   := TamSX3("NNR_DESCRI")[1]
Local cPictQT   := PesqPict("SB2","B2_QATU")
Local cPictVL   := PesqPict("SB2","B2_VATU1")
Local cPictLZ   := PesqPict("NNR","NNR_DESCRI")
Local oReport
Local oSection

If __oTmpTab <> NIL
	cAliasTRB := __oTmpTab:GetAlias()
EndIf

oReport:= TReport():New("MATR260",STR0001,cPerg,,)

IIf( !( IsBlind() ), Pergunte( cPerg, .F. ), Nil )
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Variaveis utilizadas para parametros no grupo de pergunta MTR260R1
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// mv_par01 - Aglutina por: Almoxarifado / Filial / Empresa
// mv_par02 - Filial de
// mv_par03 - Filial ate
// mv_par04 - almoxarifado de
// mv_par05 - almoxarifado ate
// mv_par06 - Produto de
// mv_par07 - Produto ate
// mv_par08 - tipo de
// mv_par09 - tipo ate
// mv_par10 - grupo de
// mv_par11 - grupo ate
// mv_par12 - descricao de
// mv_par13 - descricao ate
// mv_par14 - Codigo do Item de
// mv_par15 - Codigo do Item ate
// mv_par16 - imprime produtos: Todos /Positivos /Negativos
// mv_par17 - Saldo a considerar : Atual / Fechamento / Movimento
// mv_par18 - Qual Moeda (1 a 5)
// mv_par19 - Aglutina por UM ?(S)im (N)ao
// mv_par20 - Lista itens zerados ? (S)im (N)ao
// mv_par21 - Imprimir o Valor ? Custo / Custo Std / Ult Prc Compr
// mv_par22 - Data de Referencia
// mv_par23 - Lista valores zerados ? (S)im (N)ao
// mv_par24 - QTDE na 2a. U.M. ? (S)im (N)ao
// mv_par25 - Imprime descricao do Armazem ? (S)im (N)ao
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
oSection := TRSection():New(oReport,STR0053,{"SB2","SB1"},aOrdem) //"Saldos em Estoque"
MontaTrab(oReport,oSection:GetOrder(),cAliasTRB,oSection,.T.)
oReport := TReport():New("MATR260",STR0001,cPerg, {|oReport| ReportPrint(oreport,aOrdem,cAliasTRB)},STR0002+" "+STR0003+" "+STR0004) //"Relacao da Posicao do Estoque"
oReport:SetUseGC(.F.) //-- Desabilita GE para não conflitar com perguntas do relatório
If TamSX3("B1_COD")[1] > 15
	oReport:SetLandscape()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Sessao 1                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection := TRSection():New(oReport,STR0053,{"SB2","SB1",cAliasTRB},aOrdem) //"Saldos em Estoque"
oSection:SetTotalInLine(.F.)

TRCell():New(oSection,'B1_COD'	  ,'SB1',STR0036,/*Picture*/,   nTamProd,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'B1_TIPO'	  ,'SB1',STR0037,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'B1_GRUPO'  ,'SB1',STR0038,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'B1_DESC'	  ,'SB1',STR0039,/*Picture*/,If(oReport:GetOrientation() == 1,50,),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'B1_UM'	  ,'SB1',STR0040,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT")
TRCell():New(oSection,'B1_SEGUM'  ,'SB1',STR0040,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'B2_FILIAL' ,'SB2',STR0041,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'B2_LOCAL'  ,'SB2',STR0042,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

TRCell():New(oSection,'QUANT'	  ,cAliasTRB,STR0043+CRLF+STR0044, cPictQT, nSizeQT,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection,'QUANTR'	  ,cAliasTRB,STR0045+CRLF+STR0046, cPictQT, nSizeQT,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection,'DISPON'	  ,cAliasTRB,STR0047+CRLF+STR0048, cPictQT, nSizeQT,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection,'VALOR'	  ,cAliasTRB,STR0049+CRLF+STR0044, cPictVL, nSizeVL,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection,'VALORR'	  ,cAliasTRB,STR0049+CRLF+STR0050, cPictVL, nSizeVL,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection,'DESCARM'	  ,cAliasTRB,STR0051+CRLF+STR0052, cPictLZ, nSizeLZ,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection:SetHeaderPage()
oSection:SetNoFilter(cAliasTRB)

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Marcos V. Ferreira   ³ Data ³16/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±³          ³ExpA2: Array com as ordem do relatorio                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR260			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aOrdem,cAliasTRB)

Local oSection    := oReport:Section(1)
Local nOrdem      := oSection:GetOrder()
Local nX          := 0
Local nQtdCol     := 0
Local cCodAnt     := ""
Local cFilAnter   := ""
Local cNameCell   := ""
Local lRet        := .T.
Local oBreak01 	  
Local oBreak02 	  
Local nTamLOC     := TamSX3("B2_LOCAL")[1]
Local cALL_LOC    := Replicate( '*' , nTamLOC)
Local cALL_Empty  := Replicate( ' ' , nTamLOC)
Local cALL_ZZ     := Replicate( 'Z' , nTamLOC)
Local lCusUnif    := A330CusFil() // Verifica se utiliza custo unificado por Empresa/Filial
Local cPictQT     := PesqPict("SB2","B2_QATU")
Local cPictVL     := PesqPict("SB2","B2_VATU1")
Local lImpPrdData as logical
Local cFieldUM    as character

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Private                                            |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// carrega as perguntas 
For nX := 01 to 25
	aMV_PAR[nX] := &("mv_par"+StrZero(nX,2))
Next nX

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao do titulo do relatorio                             |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title()+" - ("+AllTrim(aOrdem[oSection:GetOrder()])+" - "+AllTrim(SuperGetMv("MV_SIMB"+Ltrim(Str(aMV_PAR[18])),.F.))+")")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da linha de SubTotal                               |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If StrZero(nOrdem,1) $ "245"
	If nOrdem == 2
		//-- SubtTotal por Tipo
		oBreak01 := TRBreak():New(oSection,oSection:Cell("B1_TIPO"),STR0016+" "+STR0017,.F.)
	ElseIf nOrdem == 4
		//-- SubtTotal por Grupo
		oBreak01 := TRBreak():New(oSection,oSection:Cell("B1_GRUPO"),STR0016+" "+STR0018,.F.)
	ElseIf nOrdem == 5
		//-- SubtTotal por Armazem
		oBreak01 := TRBreak():New(oSection,oSection:Cell("B2_LOCAL"),STR0033,.F.)
	EndIf

	TRFunction():New(oSection:Cell('QUANT'	),NIL,"SUM",oBreak01,/*Titulo*/, cPictQT,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('QUANTR'	),NIL,"SUM",oBreak01,/*Titulo*/, cPictQT,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('DISPON'	),NIL,"SUM",oBreak01,/*Titulo*/, cPictQT,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('VALOR'	),NIL,"SUM",oBreak01,/*Titulo*/, cPictVL,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('VALORR'	),NIL,"SUM",oBreak01,/*Titulo*/, cPictVL,/*uFormula*/,.F.,.F.)
EndIf

// Definicao da Unidade de Medida a ser impressa          |
//-- SubTotal pela 2a.U.M.
If aMV_PAR[24] == 1
	cFieldUM := "B1_SEGUM"
//-- SubTotal pela 1a. U.M.
else
	cFieldUM := "B1_UM"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da linha de SubTotal da Unidade de Medida          |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aMV_PAR[19] == 1
	oBreak02 := TRBreak():New(oSection,oSection:Cell(cFieldUM),STR0019,.F.)

	TRFunction():New(oSection:Cell('QUANT'	),NIL,"SUM",oBreak02,/*Titulo*/, cPictQT,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('QUANTR'	),NIL,"SUM",oBreak02,/*Titulo*/, cPictQT,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('DISPON'	),NIL,"SUM",oBreak02,/*Titulo*/, cPictQT,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('VALOR'	),NIL,"SUM",oBreak02,/*Titulo*/, cPictVL,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('VALORR'	),NIL,"SUM",oBreak02,/*Titulo*/, cPictVL,/*uFormula*/,.F.,.F.)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da linha de Total Geral                            |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

TRFunction():New(oSection:Cell('QUANT'	),NIL,"SUM",/*oBreak*/,/*Titulo*/, cPictQT,/*uFormula*/,.T.,.F.)
TRFunction():New(oSection:Cell('QUANTR'	),NIL,"SUM",/*oBreak*/,/*Titulo*/, cPictQT,/*uFormula*/,.T.,.F.)
TRFunction():New(oSection:Cell('DISPON'	),NIL,"SUM",/*oBreak*/,/*Titulo*/, cPictQT,/*uFormula*/,.T.,.F.)
TRFunction():New(oSection:Cell('VALOR'	),NIL,"SUM",/*oBreak*/,/*Titulo*/, cPictVL,/*uFormula*/,.T.,.F.)
TRFunction():New(oSection:Cell('VALORR'	),NIL,"SUM",/*oBreak*/,/*Titulo*/, cPictVL,/*uFormula*/,.T.,.F.)

If oSection:UseFilter()

	nQtdCol := Len(oSection:aCell)
	For nX := 1 to nQtdCol
		If oSection:aCell[nX]:lUserField .And. oSection:aCell[nX]:cAlias == "SB2" .And. oSection:aCell[nX]:cType == "N"
			cNameCell	:= oSection:aCell[nX]:cName
			If StrZero(nOrdem,1) $ "245"
				TRFunction():New(oSection:Cell(cNameCell),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
			EndIf
			If aMV_PAR[19] == 1
				TRFunction():New(oSection:Cell(cNameCell),NIL,"SUM",oBreak02,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
			EndIf

			TRFunction():New(oSection:Cell(cNameCell),NIL,"SUM",,,,,.T.,.F.)
		EndIf
	Next nX
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³	Visualizar a coluna B1_UM ou B1_SEGUM conforme parametrizacao |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aMV_PAR[24] == 1
	oSection:Cell('B1_UM'):Disable()
Else
	oSection:Cell('B1_SEGUM'):Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³	Visualizar "Descricao do Armazem" conforme parametrizacao     |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aMV_PAR[25] != 1
	oSection:Cell('DESCARM'):Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta as perguntas para Custo Unificado                     |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lCusUnif .And. ((aMV_PAR[01]==1) .Or. !(aMV_PAR[04]==cALL_LOC) .Or. !(aMV_PAR[05]==cALL_LOC) .Or. nOrdem==5)
	If Aviso(STR0024,STR0025+CHR(10)+CHR(13)+STR0029+CHR(10)+CHR(13)+STR0026+CHR(10)+CHR(13)+STR0027+CHR(10)+CHR(13)+STR0028+CHR(10)+CHR(13)+STR0030,{STR0031,STR0032}) == 2
		lRet := .F.
	EndIf
EndIf

If lRet

	If aMV_PAR[04] == cALL_LOC
		aMV_PAR[04] := cALL_Empty
	EndIf

	If aMV_PAR[05] == cALL_LOC
		aMV_PAR[05] := cALL_ZZ
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ajusta parametro de configuracao da Moeda                    |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aMV_PAR[18] := If( ((aMV_PAR[18] < 1) .Or. (aMV_PAR[18] > 5)),1,aMV_PAR[18] )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta arquivo de trabalho                                    |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MontaTrab(oReport,nOrdem,cAliasTRB,oSection,.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³	Processando Impressao                                        |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( cAliasTRB )
	( cAliasTRB )->( dbGoTop() )
	oReport:SetMeter(LastRec())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³	Posiciona nas tabelas SB1 e SB2                              |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRPosition():New(oSection,"SB1",1,{|| If(FWModeAccess("SB1") == "E" .And. FWModeAccess("SB2") == "E",(cAliasTRB)->FILIAL+(cAliasTRB)->CODIGO,xFilial("SB1")+(cAliasTRB)->CODIGO)})
	TRPosition():New(oSection,"SB2",1,{|| (cAliasTRB)->FILIAL+(cAliasTRB)->CODIGO+(cAliasTRB)->LOCALARM})

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³	Aglutina por Armazem/Filial/Empresa                          |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aMV_PAR[01] == 2
		If !(nOrdem == 5)
			oSection:Cell("B2_LOCAL"):SetValue(cALL_LOC)
		EndIf
	ElseIf aMV_PAR[01] == 3
		oSection:Cell("B2_FILIAL"):SetValue(Replicate("*",FWSizeFilial()))
		If !(nOrdem == 5)
			oSection:Cell("B2_LOCAL"):SetValue(cALL_LOC)
		EndIf
	EndIf

	oSection:Init()
	cCodAnt  := ""
	cFilAnter  := ""
	While !oReport:Cancel() .And. !Eof()

		oReport:IncMeter()

		If ( (aMV_PAR[16] == 1) .Or. ((aMV_PAR[16] == 2) .And. (QtdComp(FIELD->QUANT) >= QtdComp(0)) ) .Or. ;
		   ( (aMV_PAR[16] == 3) .And. (QtdComp(FIELD->QUANT) < QtdComp(0)) ) )

			// imprime tipo EXCEL em formato TABELA
			If oReport:nExcelPrintType == 3 
				lImpPrdData := .T.
			else
				if (cAliasTRB)->CODIGO == cCodAnt .And. (cAliasTRB)->FILIAL == cFilAnter
					lImpPrdData := .F.
				else 
					lImpPrdData := .T.
				EndIf
			EndIf

		    If lImpPrdData
				oSection:Cell('B1_COD'		):Show()
				oSection:Cell('B1_TIPO'		):Show()
				oSection:Cell('B1_GRUPO'	):Show()
				oSection:Cell('B1_DESC'		):Show()
				oSection:Cell(cFieldUM      ):Show()
			else
				oSection:Cell('B1_COD'		):Hide()
				oSection:Cell('B1_TIPO'		):Hide()
				oSection:Cell('B1_GRUPO'	):Hide()
				oSection:Cell('B1_DESC'		):Hide()
				oSection:Cell(cFieldUM      ):Hide()
			EndIf

		    // atribui os valores para os campos customizados
			For nX := 1 To Len(__aNameCells)
				oSection:Cell(__aNameCells[nX]):SetValue((cAliasTRB)->&(__aNameCells[nX]))
			Next nX

			oSection:PrintLine()

			cCodAnt := (cAliasTRB)->CODIGO
			cFilAnter := (cAliasTRB)->FILIAL
		EndIf
		dbSkip()
	EndDo

	oSection:Finish()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³	Apagando arquivo de trabalho temporario                    |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cGetRealName :=__oTmpTab:GETREALNAME()
	TcSqlExec('Truncate table '+cGetRealName)

EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MontaTrab | Autor ³ Marcos V. Ferreira    ³ Data ³ 16/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Preparacao do Arquivo de Trabalho p/ Relatorio             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR260                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MontaTrab(oReport,nOrdem,cAliasTRB,oSection,lVisualiz)
Local cWhere      := ""
Local cWhereB1    := ""
Local cWhereB9    := ""
Local cWhereNNR   := ""
Local cWhereLOCAL := ""
Local aSizeQT     := TamSX3( "B2_QATU" )
Local aSizeVL     := TamSX3( "B2_VATU1")
Local aSaldo      := {}
Local nQuant      := 0
Local nValor      := 0
Local nQuantR     := 0
Local nValorR     := 0
Local cFilOK      := cFilAnt
Local cAliasSB1   := "SB1"
Local lExcl       := .F.
Local lAglutLoc   := .F.
Local lAglutFil   := .F.
Local lAchou      := .F.
Local cSeek       := ""
Local cCampos     := ""
Local cAliasSB2   := "SB2"
Local nX          := 0
Local cFilUser    := ""
Local dDataRef    := Ctod( '' )
Local aStrucSB1   := {}
Local aStrucSB2   := {}
Local aStrucSB9   := {}
Local lVeic       := Upper(SuperGetMV( 'MV_VEICULO' ,.F., 'N' ))=="S"
Local nDec        := 0
Local aSM0        := FWLoadSM0(.T., .T.)
Local aNotAccess  := {}
Local nCount      := 0
Local cFil        := ""
Local cGrEmp      := FWGrpCompany()
Local cFNoAccess  := ''
Local lNoRunCalc  := .F.
Local cIsNull     := MatIsNull()
Local cWhereD1    := ""
Local cWhereD2    := ""
Local cWhereD3    := ""
Local cLocProc    := GetMvNNR( 'MV_LOCPROC' , '99' )
Local cAsc255     := Chr( 255 )
Local cNameCell as character
Local cQuery    as character

Default lVisualiz:= .F.

If oSection:UseFilter()
	__aNameCells := {}
	nQtdCol := Len(oSection:aCell)
	For nX := 1 to nQtdCol
		If oSection:aCell[nX]:lUserField .And. oSection:aCell[nX]:cAlias == "SB2" .And. oSection:aCell[nX]:cType == "N"
			cNameCell := oSection:aCell[nX]:cName
			aAdd(__aNameCells,cNameCell)
		EndIF
	Next nX
EndIf

// cria a tabela temporaria para guardar as informacoes para impressão
NewTable(cAliasTRB, oReport:GetOrientation(),nOrdem,aSizeVL,aSizeQT,lVeic)

If !lVisualiz
	// Cria array de filiais que o usuário não possui acesso.
	For nCount := 1 To Len(aSM0)
		If aSM0[nCount,1] == cGrEmp .And. !aSM0[nCount][11]
			cFil := FWxFilial("SB2", aSM0[nCount][2])
			IIf(ASCAN(aNotAccess, cFil) == 0, AADD(aNotAccess, cFil), Nil)
		EndIf
	Next nCount

	aStrucSB1 := SB1->(dbStruct())
	aStrucSB2 := SB2->(dbStruct())
	aStrucSB9 := SB9->(dbStruct())

	nDec := MsDecimais(aMV_PAR[18])
	AEval( aNotAccess ,{ | x | cFNoAccess += AllTrim( x ) + '|' }  )
	dDataRef := IIf(Empty(aMV_PAR[22]),dDataBase,aMV_PAR[22])
	// obtem o filtro de usuario em formato SQL
	cFilUser := oSection:GetSqlExp()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³	Aglutina por Armazem/Filial/Empresa                          |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aMV_PAR[01] == 2
		If !(nOrdem == 5)
			lAglutLoc := .T.
		EndIf
	ElseIf aMV_PAR[01] == 3
		lAglutFil := .T.
		If !(nOrdem == 5)
			lAglutLoc := .T.
		EndIf
	EndIf

	dbSelectArea("SB2")
	oReport:SetMeter(LastRec())

	cSelect := ""

	//Adiciona campos personalizados na Query para Aglutinar valores
	For nX := 1 To Len(__aNameCells)
		cSelect += "," + __aNameCells[nX] + " "
	Next nX

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtro adicional no clausula Where                                     |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cWhere := ""
	If lVeic
		If !Empty( aMV_PAR[15] )
			cWhere += " SB1.B1_CODITE BETWEEN '" + aMV_PAR[14] + "' AND '" + aMV_PAR[15] + "' "
		EndIf

	Else
		If !Empty( aMV_PAR[07] )
			If Left( AllTrim( Upper( aMV_PAR[07] ) ), 3 ) == 'ZZZ'
				cWhere += " ((SB1.B1_COD    BETWEEN '" + aMV_PAR[06] + "' AND '" + aMV_PAR[07] + "') OR "
				cWhere += " (SB1.B1_COD    BETWEEN '" + aMV_PAR[06] + "' AND '" + cAsc255 + "')) "
			Else
				cWhere += " SB1.B1_COD    BETWEEN '" + aMV_PAR[06] + "' AND '" + aMV_PAR[07] + "' "
			Endif
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro de usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFilUser)
		cWhere +=  + IIf( Empty( cWhere ), " " + cFilUser , " AND " + cFilUser )
	EndIf
	cWhere += ""

	cWhereB2 := ""
	If FWModeAccess("SB2") == "E"
		If !Empty( aMV_PAR[03] )
			cWhereB2 += " SB2.B2_FILIAL BETWEEN '"+ aMV_PAR[02] + "' AND '" + aMV_PAR[03] + "' "
		EndIf
	Else
	    cWhereB2 += " SB2.B2_FILIAL = '" + xFilial("SB2") + "'"
	EndIf
	cWhereB2 += ""

	cWhereB9 := ""
	If FWModeAccess("SB9") == "E"
		If !Empty( aMV_PAR[03] )
			cWhereB9 += " SB9A.B9_FILIAL BETWEEN '"+ aMV_PAR[02] + "' AND '" + aMV_PAR[03] + "' "
		EndIf
	Else
	    cWhereB9 += " SB9A.B9_FILIAL = '" + xFilial("SB1") + "' "
	EndIf
	cWhereB9 += ""

	cWhereB1 := ""
	If FWModeAccess("SB1") == "E"
		If FWModeAccess("SB2") == "E"
			cWhereB1 += " SB1.B1_FILIAL = SB2.B2_FILIAL "
	    Else
			If !Empty( aMV_PAR[03] )
				cWhereB1 += " SB1.B1_FILIAL BETWEEN '"+ aMV_PAR[02] + "' AND '" + aMV_PAR[03] + "' "
			EndIf
	    EndIf
	Else
	     cWhereB1 += " SB1.B1_FILIAL = '" + xFilial("SB1") + "'"
	EndIf
	cWhereB1 += ""

	cWhereNNR := ""
	If FWModeAccess("NNR") == "E"
		If FWModeAccess("SB2") == "E"
			cWhereNNR += " NNR.NNR_FILIAL = SB2.B2_FILIAL "
	    Else
			If !Empty( aMV_PAR[03] )
				cWhereNNR += " NNR.NNR_FILIAL BETWEEN '"+ aMV_PAR[02] + "' AND '" + aMV_PAR[03] + "' "
			EndIf
	    EndIf
	Else
	   	cWhereNNR += " NNR.NNR_FILIAL = '" + xFilial("NNR") + "'"
	EndIf
	cWhereNNR += ""


	cWhereD1 := ""
	If FWModeAccess("SD1") == "E"
		If FWModeAccess("SB2") == "E"
			cWhereD1 += " SD1.D1_FILIAL = SB2.B2_FILIAL "
	    Else
			If !Empty( aMV_PAR[03] )
				cWhereD1 += " SD1.D1_FILIAL BETWEEN '"+ aMV_PAR[02] + "' AND '" + aMV_PAR[03] + "' "
			EndIf
		EndIf
	Else
	    cWhereD1 += " SD1.D1_FILIAL = '" + xFilial("SD1") + "'"
	EndIf
	cWhereD1 += " "

	cWhereD2 := ""
	If FWModeAccess("SD2") == "E"
		If FWModeAccess("SB2") == "E"
			cWhereD2 += " SD2.D2_FILIAL = SB2.B2_FILIAL "
	    Else
			If !Empty( aMV_PAR[03] )
				cWhereD2 += " SD2.D2_FILIAL BETWEEN '"+ aMV_PAR[02] + "' AND '" + aMV_PAR[03] + "' "
			EndIf
		EndIf
	Else
	    cWhereD2 += " SD2.D2_FILIAL = '" + xFilial("SD2") + "'"
	EndIf
	cWhereD2 += " "

	cWhereD3 := ""
	If FWModeAccess("SD3") == "E"
		If FWModeAccess("SB2") == "E"
			cWhereD3 += " SD3.D3_FILIAL = SB2.B2_FILIAL "
	    Else
			If !Empty( aMV_PAR[03] )
				cWhereD3 += " SD3.D3_FILIAL BETWEEN '"+ aMV_PAR[02] + "' AND '" + aMV_PAR[03] + "' "
			EndIf
		EndIf
	Else
	    cWhereD3 += " SD3.D3_FILIAL = '" + xFilial("SD3") + "'"
	EndIf
	cWhereD3 += " "

	cWhereLOCAL := ""
	If !Empty( aMV_PAR[05] )
		cWhereLOCAL += " SB2.B2_LOCAL BETWEEN '"+ aMV_PAR[04] + "' AND '" + aMV_PAR[05] + "' "
	EndIf

	cCampos +=""
	For nX := 1 To Len(__aNameCells)
		cCampos += ", " + __aNameCells[nX]
	Next nX
	cCampos +=""

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)

	cAliasSB2 := GetNextAlias()
	cAliasSB1 := cAliasSB2

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicio do Embedded SQL                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cQuery := " SELECT B2_FILIAL, B2_LOCAL, B2_COD, "
	If (aMV_PAR[17] == 3)
		cQuery += "	   		"+ cIsNull +"( SB9.B9_COD, ' ' ) B9_COD,  	"
		cQuery += "	   		"+ cIsNull +"( SB9.B9_QINI,  0  ) B9_QINI,  "
		cQuery += "	   		"+ cIsNull +"( SB9.B9_QISEGUM, 0  ) B9_QISEGUM,"
		cQuery += "	   		"+ cIsNull +"( SB9.B9_VINI1, 0  ) B9_VINI1, "
		cQuery += "	   		"+ cIsNull +"( SB9.B9_VINI2, 0  ) B9_VINI2, "
		cQuery += "	   		"+ cIsNull +"( SB9.B9_VINI3, 0  ) B9_VINI3, "
		cQuery += "	   		"+ cIsNull +"( SB9.B9_VINI4, 0  ) B9_VINI4, "
		cQuery += "	   		"+ cIsNull +"( SB9.B9_VINI5, 0  ) B9_VINI5, "

		cQuery += "	   		( 	SELECT "+ cIsNull +"( MAX( SD1.D1_COD ), ' ' ) D1_COD "
		cQuery += "	   			FROM "+ RetSQLName( 'SD1' ) +"  SD1 "
		cQuery += "	   			WHERE "+ IIf( Empty( cWhereD1 ), " SD1.D1_FILIAL IS NOT NULL ", cWhereD1 ) +" "
		cQuery += "	   				AND SD1.D1_COD =  "+ cIsNull +"( SB9.B9_COD, ' ' )  "
		cQuery += "	   				AND SD1.D1_LOCAL = "+ cIsNull +"( SB9.B9_LOCAL, ' ' )"
		cQuery += "	   				AND SD1.D1_DTDIGIT BETWEEN  "+ cIsNull +"( SB9.B9_DATA, ' ' ) AND '"+ Dtos( dDataRef ) +"'  "
		cQuery += "	   				AND SD1.D_E_L_E_T_ = ' '  "
		cQuery += "	   		) D1_COD,  "

		cQuery += "	   		( 	SELECT "+ cIsNull +"( MAX( SD2.D2_COD ), ' ' ) D2_COD  "
		cQuery += "	   			FROM "+ RetSQLName( 'SD2' ) +"   SD2  "
		cQuery += "	   			WHERE "+ IIf( Empty( cWhereD2 ), " SD2.D2_FILIAL IS NOT NULL ", cWhereD2 ) +" "
		cQuery += "	   				AND SD2.D2_COD =  "+ cIsNull +"( SB9.B9_COD, ' ' ) "
		cQuery += "	   				AND SD2.D2_LOCAL =  "+ cIsNull +"( SB9.B9_LOCAL, ' ' ) "
		cQuery += "	   				AND SD2.D2_EMISSAO BETWEEN  "+ cIsNull +"( SB9.B9_DATA, ' ' ) AND '"+ Dtos( dDataRef ) +"'  "
		cQuery += "	   				AND SD2.D_E_L_E_T_ = ' '  "
		cQuery += "	   		) D2_COD,  "

		cQuery += "			( 	SELECT  "+ cIsNull +"( MAX( SD3.D3_COD ), ' ' )  "
		cQuery += "			  	FROM  "+ RetSQLName( 'SD3' ) +"   SD3  "
		cQuery += "			  	WHERE "+ IIf( Empty( cWhereD3 ), " SD3.D3_FILIAL IS NOT NULL ", cWhereD3 ) +" "
		cQuery += "				  AND SD3.D3_COD =  "+ cIsNull +"( SB9.B9_COD, ' ' )  "
		cQuery += "	   			  AND SD3.D3_LOCAL =  "+ cIsNull +"( SB9.B9_LOCAL, ' ' )  "
		cQuery += "	   			  AND SD3.D3_EMISSAO BETWEEN  "+ cIsNull +"( SB9.B9_DATA, ' ' ) AND '"+ Dtos( dDataRef ) +"'  "
		cQuery += "	   			  AND SD3.D_E_L_E_T_ = ' '  "
		cQuery += "	   	  	) D3_COD, "
	EndIf

	cQuery += "	   		B2_QATU, B2_QTSEGUM, B2_QFIM, B2_QFIM2, B2_VATU1, B2_VATU2, "
	cQuery += "   	   	B2_VATU3, B2_VATU4, B2_VATU5, B2_VFIMFF1, B2_VFIMFF2, B2_VFIMFF3, B2_VFIMFF4, B2_VFIMFF5, "
	cQuery += "   	   	B2_QEMP, B2_QEMP2, B2_QEMPPRE, B2_RESERVA, B2_RESERV2, B2_QEMPSA, B2_QEMPPRJ, B2_VFIM1, "
	cQuery += "   	   	B2_QEMPPR2, B2_VFIM2, B2_VFIM3, B2_VFIM4, B2_VFIM5, B1_COD, B1_FILIAL, B1_TIPO, B1_GRUPO, "
	cQuery += "   	   	B1_DESC, B1_CUSTD, B1_UPRC, B1_MCUSTD, B1_SEGUM, B1_UM, B1_CODITE, NNR_DESCRI, "
	cQuery += "   	   	B2_SALPPRE, B2_QEPRE2 "

	cQuery += "   	   "+ IIf( Empty( cCampos ), '', cCampos ) +" "

	cQuery += " FROM "+ RetSQLName( 'SB2' ) +" SB2 "
	cQuery += " 	INNER JOIN "+ RetSQLName( 'SB1' ) +" SB1 ON ( "+ IIf( Empty( cWhereB1 ), " SB1.B1_COD = SB2.B2_COD " , cWhereB1 +" AND SB1.B1_COD = SB2.B2_COD "  ) +" ) "
	cQuery += " 	INNER JOIN "+ RetSQLName( 'NNR' ) +" NNR ON ( "+ IIf( Empty( cWhereNNR ), " NNR.NNR_CODIGO = SB2.B2_LOCAL " , cWhereNNR +" AND NNR.NNR_CODIGO = SB2.B2_LOCAL "  ) +" ) "

	If (aMV_PAR[17] == 3)
		cQuery += " 	LEFT OUTER JOIN (  "
		cQuery += " 				  SELECT B9_FILIAL, B9_COD, B9_LOCAL, B9_DATA, B9_QINI, B9_VINI1, B9_QISEGUM, B9_VINI2, B9_VINI3, B9_VINI4, B9_VINI5 "
		cQuery += " 				  FROM "+ RetSQLName( 'SB9' ) +" SB9A "
		cQuery += " 				  WHERE "+ cWhereB9 + " AND "
		cQuery += " 					SB9A.B9_DATA = (  "
		cQuery += " 					 					SELECT "+ cIsNull +"( MAX( SB9B.B9_DATA ), ' ' )  "
		cQuery += " 					  					FROM "+ RetSQLName( 'SB9' ) +" SB9B  "
		cQuery += " 				  						WHERE SB9B.B9_FILIAL = SB9A.B9_FILIAL  "
		cQuery += " 						  					AND SB9B.B9_COD  = SB9A.B9_COD  "
		cQuery += " 						  					AND SB9B.B9_LOCAL = SB9A.B9_LOCAL"
		cQuery += " 						  					AND SB9B.B9_DATA <= '"+ Dtos( dDataRef ) +"'  "
		cQuery += " 						  					AND SB9B.D_E_L_E_T_ = ' '  "
		cQuery += " 					  					)  "
		cQuery += " 				  AND SB9A.D_E_L_E_T_ = ' '  "
		cQuery += " 	) SB9 ON ( SB9.B9_FILIAL = SB2.B2_FILIAL AND SB9.B9_COD = SB2.B2_COD AND SB9.B9_LOCAL = SB2.B2_LOCAL )  "
	EndIf

	cQuery += " WHERE "+ IIf( Empty( cWhereB2 ), "", cWhereB2 + " AND " ) +" "
	If !Empty( aMV_PAR[11] )
		cQuery += " 	SB1.B1_GRUPO BETWEEN '"+ aMV_PAR[10] +"' AND '"+ aMV_PAR[11] +"' AND "
	EndIf

	If !Empty( aMV_PAR[09] )
		cQuery += " 	SB1.B1_TIPO  BETWEEN '"+ aMV_PAR[08] +"' AND '"+ aMV_PAR[09] +"' AND "
	EndIf

	If !Empty( aMV_PAR[13] )
		If Left( AllTrim( Upper( aMV_PAR[13] ) ), 3 ) == 'ZZZ'
			cQuery += " 	((SB1.B1_DESC BETWEEN  '"+ aMV_PAR[12] +"' AND '"+ aMV_PAR[13] +"') OR "
			cQuery += " 	(SB1.B1_DESC BETWEEN  '"+ aMV_PAR[12] +"' AND '"+ cAsc255 +"')) AND "
		Else
			cQuery += " 	SB1.B1_DESC BETWEEN  '"+ aMV_PAR[12] +"' AND '"+ aMV_PAR[13] +"' AND "
		Endif
	EndIf

	If !Empty( cWhereLOCAL )
		cQuery += " 	"+ cWhereLOCAL +" AND "
	EndIf

	If !Empty( cWhere )
		cQuery += "   "+ cWhere +" AND "
	EndIf

	If !( Empty( cFNoAccess ) )
		cQuery += " SB2.B2_FILIAL NOT IN "+ FormatIn( cFNoAccess, '|' ) +" AND "
	EndIf

	cQuery += " 	NNR.D_E_L_E_T_ = ' ' "
	cQuery += " 	AND SB2.D_E_L_E_T_ = ' ' "
	cQuery += " 	AND SB1.D_E_L_E_T_ = ' ' "

	cQuery := ChangeQuery( cQuery )
	dbUseArea( .T., __cRdd, TcGenQry( ,, cQuery ), cAliasSB2, .T., .F. )

	AEval( aStrucSB1, { | x | IIf( x[2] <> "C", TcSetField(cAliasSB2, x[1], x[2], x[3], x[4] ), Nil ) } )
	AEval( aStrucSB2, { | x | IIf( x[2] <> "C", TcSetField(cAliasSB2, x[1], x[2], x[3], x[4] ), Nil ) } )

	If (aMV_PAR[17] == 3)
		AEval( aStrucSB9, { | x | IIf( x[2] <> "C", TcSetField(cAliasSB2, x[1], x[2], x[3], x[4] ), Nil ) } )
	EndIf

	nContador := 0
	lExcl := xFilial("SB2") != Space(FwSizeFilial())
	dbSelectArea( cAliasSB2 )
	While !oReport:Cancel() .And. !Eof()

		If lExcl
			cFilAnt := (cAliasSB2)->B2_FILIAL
		EndIf

		oReport:IncMeter()
		If (aMV_PAR[17] == 3)
			lNoRunCalc := ( !Empty( ( cAliasSB2 )->B9_COD ) ) .And. ( Empty( ( cAliasSB2 )->D1_COD ) .And. Empty( ( cAliasSB2 )->D2_COD ) .And. Empty( ( cAliasSB2 )->D3_COD ) ) .And. (cAliasSB2)->B2_LOCAL <> cLocProc
		EndIf

		Do Case
			Case (aMV_PAR[17] == 1)
				nQuant := If( aMV_PAR[24]==1, ConvUM( (cAliasSB2)->B2_COD, (cAliasSB2)->B2_QATU, (cAliasSB2)->B2_QTSEGUM, 2 ), (cAliasSB2)->B2_QATU )

			Case (aMV_PAR[17] == 2)
				nQuant := If( aMV_PAR[24]==1, ConvUM( (cAliasSB2)->B2_COD, (cAliasSB2)->B2_QFIM, (cAliasSB2)->B2_QFIM2, 2 ), (cAliasSB2)->B2_QFIM )

			Case (aMV_PAR[17] == 3)
				If lNoRunCalc
					nQuant := If( aMV_PAR[24]==1, ( cAliasSB2 )->B9_QISEGUM, ( cAliasSB2 )->B9_QINI )
				Else
					nQuant := (aSaldo := CalcEst( (cAliasSB2)->B2_COD,(cAliasSB2)->B2_LOCAL,dDataRef+1,(cAliasSB2)->B2_FILIAL ))[ If( aMV_PAR[24]==1, 7, 1 ) ]
				EndIf

			Case (aMV_PAR[17] == 4)
				nQuant := If( aMV_PAR[24]==1, ConvUM( (cAliasSB2)->B2_COD, (cAliasSB2)->B2_QFIM, (cAliasSB2)->B2_QFIM2, 2 ), (cAliasSB2)->B2_QFIM )

			Case (aMV_PAR[17] == 5)
				nQuant := (aSaldo := CalcEstFF( (cAliasSB2)->B2_COD,(cAliasSB2)->B2_LOCAL,dDataRef+1,(cAliasSB2)->B2_FILIAL ))[ If( aMV_PAR[24]==1, 7, 1 ) ]
		EndCase

		dbSelectArea( cAliasSB1 )
		If (aMV_PAR[21] == 1)
			Do Case
				Case (aMV_PAR[17] == 1)
					nValor := (cAliasSB2)->(FieldGet( FieldPos( "B2_VATU"+Str( aMV_PAR[18],1 ) ) ))

				Case (aMV_PAR[17] == 2)
					nValor := (cAliasSB2)->(FieldGet( FieldPos( "B2_VFIM"+Str( aMV_PAR[18],1 ) ) ))

				Case (aMV_PAR[17] == 3)
					If lNoRunCalc
						nValor := (cAliasSB2)->( FieldGet( FieldPos( "B9_VINI"+Str( aMV_PAR[18],1 ) ) ))
					Else
						nValor := aSaldo[ 1+aMV_PAR[18] ]
					EndIf

				Case (aMV_PAR[17] == 4)
					nValor := (cAliasSB2)->(FieldGet( FieldPos( "B2_VFIMFF"+Str( aMV_PAR[18],1 ) ) ))

				Case (aMV_PAR[17] == 5)
						nValor := aSaldo[ 1+aMV_PAR[18] ]

			EndCase
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Converte valores para a moeda do relatorio (C.St. e U.Pr.Compra)³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Do Case
				Case (aMV_PAR[21] == 2)
					nValor := nQuant * xMoeda( RetFldProd((cAliasSB1)->B1_COD,"B1_CUSTD",cAliasSB1),Val( (cAliasSB1)->B1_MCUSTD ),aMV_PAR[18],dDataRef,4 )
				Case (aMV_PAR[21] == 3)  // Ult.Pr.Compra sempre na Moeda 1
					nValor := nQuant * xMoeda( RetFldProd((cAliasSB1)->B1_COD,"B1_UPRC" ,cAliasSB1),1,aMV_PAR[18],dDataRef,4 )
			EndCase
		EndIf

		If (aMV_PAR[24]==1)
			nQuantR := (cAliasSB2)->B2_QEMP2 + AvalQtdPre("SB2",1,.T.,cAliasSB2) + (cAliasSB2)->B2_RESERV2  + ConvUM( (cAliasSB2)->B2_COD, (cAliasSB2)->B2_QEMPSA, 0, 2)+(cAliasSB2)->B2_QEMPPR2
		Else
			nQuantR := (cAliasSB2)->B2_QEMP + AvalQtdPre("SB2",1,NIL,cAliasSB2) + (cAliasSB2)->B2_RESERVA + (cAliasSB2)->B2_QEMPSA + (cAliasSB2)->B2_QEMPPRJ
		EndIf

		nValorR := (QtdComp(nValor) / QtdComp(nQuant)) * QtdComp(nQuantR)

		//Verifica se é para Apresentar os Registros com Valores e Quantidades Zerados
		If ( aMV_PAR[20] == 2 .And. QtdComp( nQuant ) == QtdComp( 0 ) ) .Or. ( aMV_PAR[23] == 2 .And. QtdComp( nValor ) == QtdComp( 0 ) )
			dbSelectArea( cAliasSB2 )
			( cAliasSB2 )->( dbSkip() )
			Loop
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta Chave de pesquisa para aglutinar Armazem/Filial/Empresa ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAglutLoc .Or. lAglutFil
			If (nOrdem == 5)
				cSeek := (cAliasSB2)->B2_LOCAL
			Else
				cSeek := ""
			EndIf
			Do Case
				Case (nOrdem == 1)
					If (aMV_PAR[19] == 1)
						cSeek += IIf(aMV_PAR[24]==1,(cAliasSB1)->B1_SEGUM,(cAliasSB1)->B1_UM)
					EndIf
					cSeek += IIf(!lVeic,(cAliasSB2)->B2_COD,(cAliasSB2)->B1_CODITE)+IIf(lAglutFil,"",(cAliasSB2)->B2_FILIAL)+IIf(lAglutLoc,"",(cAliasSB2)->B2_LOCAL)
				Case (nOrdem == 2)
					cSeek += (cAliasSB1)->B1_TIPO
					If (aMV_PAR[19] == 1)
						cSeek += IIf(aMV_PAR[24]==1,(cAliasSB1)->B1_SEGUM,(cAliasSB1)->B1_UM)
					EndIf
					cSeek += IIf(!lVeic,(cAliasSB2)->B2_COD,(cAliasSB2)->B1_CODITE)+IIf(lAglutFil,"",(cAliasSB2)->B2_FILIAL)+IIf(lAglutLoc,"",(cAliasSB2)->B2_LOCAL)
				Case (nOrdem == 3)
					If (aMV_PAR[19] == 1)
						cSeek += IIf(aMV_PAR[24]==1,(cAliasSB1)->B1_SEGUM,(cAliasSB1)->B1_UM)
					EndIf
					cSeek += PADR((cAliasSB1)->B1_DESC,LEN((cAliasTRB)->DESCRI))+IIf(!lVeic,(cAliasSB2)->B2_COD,(cAliasSB2)->B1_CODITE)+IIf(lAglutFil,"",(cAliasSB2)->B2_FILIAL)+IIf(lAglutLoc,"",(cAliasSB2)->B2_LOCAL)
				Case (nOrdem == 4)
					cSeek += (cAliasSB1)->B1_GRUPO
					If (aMV_PAR[19] == 1)
						cSeek += IIf(aMV_PAR[24]==1,(cAliasSB1)->B1_SEGUM,(cAliasSB1)->B1_UM)
					EndIf
					cSeek += IIf(!lVeic,(cAliasSB2)->B2_COD,(cAliasSB2)->B1_CODITE)+IIf(lAglutFil,"",(cAliasSB2)->B2_FILIAL)+IIf(lAglutLoc,"",(cAliasSB2)->B2_LOCAL)
				Case (nOrdem == 5)
					If (aMV_PAR[19] == 1)
						cSeek += IIf(aMV_PAR[24]==1,(cAliasSB1)->B1_SEGUM,(cAliasSB1)->B1_UM)
					EndIf
					cSeek += IIf(!lVeic,(cAliasSB2)->B2_COD,(cAliasSB2)->B1_CODITE)+IIf(lAglutFil,"",(cAliasSB2)->B2_FILIAL)
				OtherWise
					If (aMV_PAR[19] == 1)
						cSeek += IIf(aMV_PAR[24]==1,(cAliasSB1)->B1_SEGUM,(cAliasSB1)->B1_UM)
					EndIf
					cSeek += IIf(!lVeic,(cAliasSB2)->B2_COD,(cAliasSB2)->B1_CODITE)+IIf(lAglutLoc,"",(cAliasSB2)->B2_LOCAL)
			EndCase
		EndIf

		dbSelectArea( cAliasTRB )
		If lAglutLoc .Or. lAglutFil
		    lAchou := !dbSeek( cSeek )
			If ( lAchou )
				( cAliasTRB )->( dbAppend( lAchou ) )
			Else
				RecLock( cAliasTRB, lAchou )
			EndIf
		Else
			( cAliasTRB )->( dbAppend( .T. ) )
		EndIf

		FIELD->FILIAL   := (cAliasSB2)->B2_FILIAL
		FIELD->CODIGO   := (cAliasSB2)->B2_COD
		FIELD->LOCALARM := (cAliasSB2)->B2_LOCAL
		FIELD->TIPO     := (cAliasSB1)->B1_TIPO
		FIELD->GRUPO    := (cAliasSB1)->B1_GRUPO
		FIELD->DESCRI   := (cAliasSB1)->B1_DESC
		If aMV_PAR[24] == 1
			FIELD->UNDMED  := (cAliasSB1)->B1_SEGUM
	 	Else
	 		FIELD->UNDMED     := (cAliasSB1)->B1_UM
	 	EndIf
		FIELD->QUANTR += nQuantR
		FIELD->VALORR += Round(nValorR,nDec)
		FIELD->QUANT  += nQuant
		FIELD->VALOR  += Round(nValor,nDec)
		FIELD->DISPON += (nQuant - nQuantR)
		If lVeic
			FIELD->CODITE := (cAliasSB1)->B1_CODITE
		EndIf
		If aMV_PAR[25] == 1
			FIELD->DESCARM := (cAliasSB2)->NNR_DESCRI
		EndIf

		For nX := 1 To Len(__aNameCells)
			FIELD->&(__aNameCells[nX]) += (cAliasSB2)->&(__aNameCells[nX])
		Next nX

		If lAglutLoc .Or. lAglutFil
			If ( lAchou )
				( cAliasTRB )->( dbCommit() )
			Else
				( cAliasTRB )->( MsUnlock() )
			EndIf
		Else
			( cAliasTRB )->( dbCommit() )
		EndIf

		dbSelectArea( cAliasSB2 )
		( cAliasSB2 )->( dbSkip() )
	EndDo

	( cAliasTRB )->( dbrUnlock() )
	( cAliasTRB )->( dbCommit() )

	cFilAnt := cFilOK

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apaga os arquivos de trabalho, cancela os filtros e restabelece as ordens originais.|
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cAliasSB2)
	dbCloseArea()
	ChkFile("SB2",.F.)

	dbSelectArea("SB1")
	dbClearFilter()
EndIf

Return .T.

// Define qual o Grupo de pergunta a ser
//utilizado no relatorio
Static Function DefineSX1()

Local cRet := "MTR260R1"

Return cRet

/*/{Protheus.doc} TMPStruct
Monta a estrutura da tabela temporia de acordo com as parametrizações feitas no relatorio.
@author reynaldo
@since 25/12/2021
@version 1.0
@param lTamDesc, logical, define o tamanho do descricao, conforme orientacao de impressao do relatorio
@param aSizeVL, array, tamanho e decimais para campos de valor(custo)
@param aSizeQT, array, tamanho e decimais para campos de quantidade
@param lVeic, logical, descricao
@param aCampos, array, estrutura da tabela temporaria desejada
@type function
/*/
Static Function TMPStruct(lTamDesc,aSizeVL,aSizeQT,lVeic)
Local aSB1Ite as array
Local aCampos as array
Local aSizeCell as array
Local nX as numeric

DEFAULT aSizeQT	:= TamSX3( "B2_QATU" )
DEFAULT aSizeVL	:= TamSX3( "B2_VATU1")

	aCampos :={	;
				{"FILIAL"  , "C", FWSizeFilial()                           , 00},;
				{"CODIGO"  , "C", TamSX3("B1_COD")[1]                      , 00},;
				{"LOCALARM", "C", TamSX3("B2_LOCAL")[1]                    , 00},;
				{"TIPO"    , "C", 02                                       , 00},;
				{"GRUPO"   , "C", 04                                       , 00},;
				{"DESCRI"  , "C", If(lTamDesc == 1,50,TamSX3("B1_DESC")[1]), 00},;
				{"UNDMED"  , "C", 02                                       , 00},;
				{"VALORR"  , "N", aSizeVL[ 1 ]+1                           , aSizeVL[ 2 ]},;
				{"QUANTR"  , "N", aSizeQT[ 1 ]+1                           , aSizeQT[ 2 ]},;
				{"VALOR"   , "N", aSizeVL[ 1 ]+1                           , aSizeVL[ 2 ]},;
				{"QUANT"   , "N", aSizeQT[ 1 ]+1                           , aSizeQT[ 2 ]},;
				{"DESCARM" , "C", TamSX3("NNR_DESCRI")[1]                  , 00},;
				{"DISPON"  , "N", aSizeQT[ 1 ]+1                           , aSizeQT[ 2 ]};
			}

	If Len(__aNameCells)>0
		//Adiciona campos personalizados a query
		For nX := 1 To Len(__aNameCells)
			aSizeCell := TamSx3(__aNameCells[nX])
			aAdd(aCampos,{__aNameCells[nX],"N",aSizeCell[1],aSizeCell[2]})
		Next nX
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Para SIGAVEI, SIGAPEC e SIGAOFI                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lVeic
		aSB1Ite 	:= TAMSX3("B1_CODITE")
		aAdd(aCampos,{"CODITE","C",aSB1Ite[ 1 ],00})
	ENDIF

Return aCampos

/*/{Protheus.doc} CreateTable
Cria uma tabela temporaria no banco de dados via classe FWTemporaryTable
@author reynaldo
@since 15/12/2021
@version 1.0
@param cAliasTRB, character, alias da tabela temporia a ser utilizado
@param aCampos, array, estrutura da tabela temporaria desejada
@type function
/*/
Static Function CreateTable(cAliasTRB, aCampos)

	__oTmpTab := FWTemporaryTable():New( cAliasTRB )
	__oTmpTab:SetFields( aCampos )
	__oTmpTab:Create()

RETURN


/*/{Protheus.doc} EqualsStruct
Verifica se já existe uma tabela temporaria e se pode utilizar ela verificando 
sua estrutura e indices. Ou se deve deletar e criar outra tabela temporaria no 
lugar.
@author reynaldo
@since 26/02/2018
@version 1.0
@param aCampos, array, estrutura da tabela temporaria desejada
@return logico, se a estrutura da tabela temporaria aberta é da estrutura informada em aCampos
@type function
/*/
Static Function EqualsStruct(aCampos)
	Local lEquals as Logical
	Local cTMPAlias as character
	Local aTMPCampos as array
	Local nX

	cTMPAlias := __oTmpTab:GetAlias()

	aTMPCampos := (cTMPAlias)->(dbStruct())

	If Len(aCampos) == len(aTMPCampos)
		aSort(aCampos,,,{|x,y| x[1] < y[1]})
		aSort(aTMPCampos,,,{|x,y| x[1] < y[1]})

		For nX := 1 To Len(aCampos)

			// nome dos campos iguais
			lEquals := aCampos[nX,1] == aTMPCampos[nX,1]

			// Tipo de dado dos campos iguais
			lEquals := lEquals .And. aCampos[nX,2] == aTMPCampos[nX,2]

			// tamanho dos campos iguais
			lEquals := lEquals .And. aCampos[nX,3] == aTMPCampos[nX,3]

			// decimais dos campos iguais
			lEquals := lEquals  .And. aCampos[nX,4] == aTMPCampos[nX,4]

			If !lEquals
				Exit
			EndIf
		Next nX
	else
		lEquals := .F.

	EndIf
RETURN lEquals

/*/{Protheus.doc} NewTable
Utiliza uma tabela temporaria para armazenar as informaçoes que serão impressas
@author reynaldo
@since 26/02/2018
@version 1.0
@return logico, sempre verdadeiro
@param cAliasTRB, caracter, nome do alias da tabela
@param lTamDesc, logical, define o tamanho do descricao, conforme orientacao de impressao do relatorio
@param nOrdem, numeric, define a ordem de impressão que impacta na ordenacao dos registros
@param aSizeVL, array, tamanho e decimais para campos de valor(custo)
@param aSizeQT, array, tamanho e decimais para campos de quantidade
@param lVeic, logical, descricao
@type function
/*/
Static Function NewTable(cAliasTRB, lTamDesc,nOrdem,aSizeVL,aSizeQT,lVeic)
Local aCampos	:= {}
Local cGetRealName As Character
Local lStruct as logical

aCampos := TMPStruct(lTamDesc,aSizeVL,aSizeQT,lVeic)

If Select(cAliasTRB) <= 0 .And. __oTmpTab != NIL
	__oTmpTab:Delete()
	FreeObj(__oTmpTab)
EndIf

If __oTmpTab == NIL

	aMV_PAR[01] := MV_PAR01
	aMV_PAR[19] := MV_PAR19
	cIndex := DefineIndex( lVeic, nOrdem)
	CreateTable(cAliasTRB, aCampos)
	CreateIndex(cAliasTRB, cIndex)

else
	cIndex := DefineIndex( lVeic, nOrdem)

	If (cAliasTRB)->(INDEXKEY())<>cIndex
		__oTmpTab:Delete()
		CreateTable(cAliasTRB, aCampos)
		CreateIndex(cAliasTRB, cIndex)
	Else
		// se as estruturas forem iguais
		lStruct := EqualsStruct(aCampos)

		if lStruct
			cGetRealName :=__oTmpTab:GETREALNAME()
			TcSqlExec('Truncate table '+cGetRealName)
		else
			__oTmpTab:Delete()
			CreateTable(cAliasTRB, aCampos)
			CreateIndex(cAliasTRB, cIndex)
		EndIf
	EndIf

EndIf

Return .T.

/*/{Protheus.doc} CreateIndex
//TODO Cria o indice para tabela temporaria
@author reynaldo
@since 01/12/2021
@version 1.0
@param cAliasTRB, caracter, nome do alias da tabela
@param cIndex, Character, Campos da tabela para criacao do indice separados por +
@return Nulo
@type function
/*/
Static Function CreateIndex(cAliasTRB, cIndex)

	__cNameIndex := "Idx_"+CriaTrab(Nil,.F.)
	(cAliasTRB)->(DBCreateIndex(__cNameIndex,cIndex))
	(cAliasTRB)->(DBSetIndex(__cNameIndex))
	(cAliasTRB)->(dbSetOrder(1))

Return

/*/{Protheus.doc} DefineIndex
//TODO Monta a chave do indice de acordo com a Ordem do relatorio, Pametro MV_CUSFIL e o grupo de perguntas
@author reynaldo
@since 01/12/2021
@version 1.0
@param lVeic, Logico, Verdadeiro se tem integracao com SIGAVEIC
@param nOrdem, Numerico, Numero da ordem do relatorio selecionado
@return cIndex, Character, chave do indice montado
@type function
/*/
Static Function DefineIndex( lVeic, nOrdem)
	Local cUM        as Character
	Local aIndxKEY   as ARRAY
	Local nLoop      as Numeric
	Local cIndex     as Character

	cUM := "UNDMED"
	aIndxKEY := {}

	If !lVeic
		If (aMV_PAR[01] == 1)
			If (nOrdem == 5)
				Aadd(aIndxKEY,"LOCALARM")
			Else
				Aadd(aIndxKEY,"FILIAL")
			EndIf
			Do Case
				Case (nOrdem == 1)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 2)
					Aadd(aIndxKEY,"TIPO")
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 3)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"DESCRI")
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 4)
					Aadd(aIndxKEY,"GRUPO")
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 5)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"FILIAL")
				OtherWise
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"LOCALARM")
			EndCase
		Else //-- (aMV_PAR[01] == 1)
			If (nOrdem == 5)
				Aadd(aIndxKEY,"LOCALARM")
			Else
				aIndxKEY := {}
			EndIf

			Do Case
				Case (nOrdem == 1)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"FILIAL")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 2)
					Aadd(aIndxKEY,"TIPO")
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"FILIAL")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 3)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"DESCRI")
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"FILIAL")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 4)
					Aadd(aIndxKEY,"GRUPO")
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"FILIAL")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 5)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"FILIAL")
				OtherWise
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODIGO")
					Aadd(aIndxKEY,"LOCALARM")
			EndCase
		EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Para SIGAVEI, SIGAPEC e SIGAOFI                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Else
		If (aMV_PAR[01] == 1) // ARMAZEN
			If (nOrdem == 5) // ALMOXARIFADO
				Aadd(aIndxKEY,"LOCALARM")
			Else
				Aadd(aIndxKEY,"FILIAL")
			EndIf
			Do Case
				Case (nOrdem == 1)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 2)
					Aadd(aIndxKEY,"TIPO")
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 3)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"DESCRI")
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 4)
					Aadd(aIndxKEY,"GRUPO")
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 5)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"FILIAL")
				OtherWise
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"LOCALARM")
			EndCase
		Else // FILIAL / EMPRESA
			If (nOrdem == 5) // ALMOXARIFADO
				Aadd(aIndxKEY,"LOCALARM")
			Else
				aIndxKEY := {}
			EndIf
			Do Case
				Case (nOrdem == 1) // CODIGO
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"FILIAL")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 2)
					Aadd(aIndxKEY,"TIPO")
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"FILIAL")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 3)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"DESCRI")
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"FILIAL")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 4)
					Aadd(aIndxKEY,"GRUPO")
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"FILIAL")
					Aadd(aIndxKEY,"LOCALARM")
				Case (nOrdem == 5)
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"FILIAL")
				OtherWise
					If (aMV_PAR[19] == 1)
						Aadd(aIndxKEY,cUM)
					EndIf
					Aadd(aIndxKEY,"CODITE")
					Aadd(aIndxKEY,"LOCALARM")
			EndCase
		EndIf
	EndIf

	cIndex := ""
	For nLoop := 1 To Len(aIndxKEY)
		cIndex += aIndxKey[nLoop]
		If nLoop < Len(aIndxKEY)
			cIndex += "+"
		EndIf
	Next nLoop
Return cIndex

/*/
{Protheus.doc} SchedDef
	Funcao Responsavel por definir informacoes para Execu??o do Relatorio via Schedule
	@type  Static Function
	@author Paulo V. Beraldo
	@since Fev/2020
	@version 1.00
	@param param, param_type, param_descr
	@return return, return_type, return_description
	@example
	(examples)
	@see (links_or_references)
/*/
Static Function SchedDef()
Local cPerg	 := DefineSX1()
Local aParam := Nil
local aOrdem := {OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009)}
               //" Por Codigo         "###" Por Tipo           "###" Por Descricao     "###" Por Grupo        "###" Por Almoxarifado   "

aParam := { "R", cPerg , "SB2" , aOrdem, OemToAnsi(STR0001) }

Return aParam
