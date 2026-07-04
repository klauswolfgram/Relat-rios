/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CDAR010.ch"
#INCLUDE "rwmake.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CDAR010  ³ Autor ³ Liber de Esteban      ³ Data ³ 17/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio gerencial de direitos autorais (royalty).        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CDAR010(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico - controle de royalty (direito autoral)         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CDAR010()

Local oReport

If FindFunction("TRepInUse") .And. TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	U_CDAR010R3()
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ReportDef ³ Autor ³ Liber de Esteban      ³ Data ³ 17/05/2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Definicao do componente                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local oFornecedor
Local oProduto

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := TReport():New("CDAR010",STR0033,"CDR010P9R1",{|oReport| ReportPrint(oReport)},STR0034) //"Relação de Direitos Autorais(Gerencial)"###"Emissão da Relação de Direitos Autorais(Gerencial)"
oReport:SetLandscape()
oReport:SetTotalInLine(.F.)
pergunte("CDR010P9R1",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Sessao dos fornecedores                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oFornecedor := TRSection():New(oReport,STR0035,{"AH1","AH3","AH4","AH5","SA2"},{STR0036,STR0037},/*Campos do SX3*/,/*Campos do SIX*/) //"Fornecedores"###"Fornecedor + Loja + Produto"###"Produto + Fornecedor + Loja"
oFornecedor:SetTotalInLine(.F.)

TRCell():New(oFornecedor,"FORNEC"    ,     ,STR0038,/*Picture*/,8,/*lPixel*/,{|| cForneced  }) //"Fornec"
TRCell():New(oFornecedor,"NOME"      ,     ,STR0039,/*Picture*/,14,/*lPixel*/,{|| Substr(SA2->A2_NOME,1,15) }) //"Nome Fornec"
TRCell():New(oFornecedor,"AH1_MOEDA" ,"AH1",STR0080,/*Picture*/,1,/*lPixel*/,{|| cTipCalc }) // "C"
TRCell():New(oFornecedor,"AH1_MOEDRO","AH1",STR0040,/*Picture*/,2,/*lPixel*/,/*{|| code-block de impressao }*/) //"Md"
TRCell():New(oFornecedor,"AH5_DATCAL","AH5",STR0041,/*Picture*/,5,/*lPixel*/,{|| dDatacal }) //"Data"
TRCell():New(oFornecedor,"QTDEVENDA" ,     ,STR0055,PesqPict("AH5","AH5_QTDACU"),7,/*lPixel*/,{|| nQtdVenda }) // "Qtd Ven"
TRCell():New(oFornecedor,"AH5_PRECOU","AH5",STR0042,/*Picture*/,/*nTamaho*/,/*lPixel*/, {|| nPreco }) //"Preço Produto"
TRCell():New(oFornecedor,"QTDEDEV"   ,     ,STR0081,PesqPict("AH5","AH5_QTDACU"),7,/*lPixel*/,{|| nQtdDev }) // "Qtd Dev"
TRCell():New(oFornecedor,"QTDLIQU"   ,     ,STR0043,PesqPict("AH5","AH5_QTDACU"),7,/*lPixel*/,{|| nQtliq }) //"Qtd Liq"
TRCell():New(oFornecedor,"AH5_BASEDA","AH5",STR0044,/*Picture*/,/*nTamaho*/,/*lPixel*/,{||nBaseda }) //"Base para D.A."
TRCell():New(oFornecedor,"AH5_PERCDA","AH5",STR0045,/*Picture*/,5,/*lPixel*/,{|| nPercda }) //"%D.A."
TRCell():New(oFornecedor,"VALOR"     ,     ,STR0046,PesqPict("AH5","AH5_VALORD"),14,/*lPixel*/,{|| nValorda }) //"Valor do D.A."
TRCell():New(oFornecedor,"TOTPAG"    ,     ,STR0047,PesqPict("AH5","AH5_VALORD"),14,/*lPixel*/,{|| nTotPagar }) //"Valor a pagar"
TRCell():New(oFornecedor,"AH3_TIPOPA","AH3",STR0048,"@!",1,/*lPixel*/,{|| cTipoPag }) //"Tp"
TRCell():New(oFornecedor,"AH1_VALADI","AH1",STR0049,/*Picture*/,14,/*lPixel*/,{|| nSubAdiant }) //"Valor Adian."
TRCell():New(oFornecedor,"AH1_SALDQT","AH1",STR0050,/*Picture*/,7,/*lPixel*/,{|| nSubAdQtd }) //"Sald Qt"
TRCell():New(oFornecedor,"AH1_SALDOA","AH1",STR0051,/*Picture*/,14,/*lPixel*/,{|| nSubAdVal }) //"Saldo Valor"
TRCell():New(oFornecedor,"MOEDA"     ,     ,STR0040,/*Picture*/,2,/*lPixel*/,{|| nMoedAdt }) //"Md"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Sessao dos produtos                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oProduto := TRSection():New(oReport,STR0052,{"AH1","AH3","AH4","AH5","SB1"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Produtos"
oProduto:SetTotalInLine(.F.)

TRCell():New(oProduto,"B1_COD"    ,"SB1",STR0053,/*Picture*/,/*nTamanho*/TamSX3("B1_COD")[1],/*lPixel*/,{|| cProduto } ) //"Produto"
TRCell():New(oProduto,"DESC"      ,     ,STR0054,/*Picture*/,/*nTamanho*/TamSX3("B1_DESC")[1],/*lPixel*/,{|| SB1->B1_DESC }) //"Desc Prod" 
TRCell():New(oProduto,"AH1_MOEDA" ,"AH1",STR0080,/*Picture*/,1,/*lPixel*/,/*{|| code-block de impressao }*/) //"C"
TRCell():New(oProduto,"AH1_MOEDRO","AH1",STR0040,/*Picture*/,2,/*lPixel*/,/*{|| code-block de impressao }*/) //"Md"
TRCell():New(oProduto,"AH5_DATCAL","AH5",STR0041,/*Picture*/,5,/*lPixel*/,{|| dDatacal }) //"Data"
TRCell():New(oProduto,"QTDEVENDA" ,     ,STR0055,PesqPict("AH5","AH5_QTDACU"),7,/*lPixel*/,{|| nQtdVenda }) //"Qtd Ven"
TRCell():New(oProduto,"AH5_PRECOU","AH5",STR0042,/*Picture*/,14,/*lPixel*/, {|| nPreco }) //"Preço Produto"
TRCell():New(oProduto,"QTDEDEV"   ,     ,STR0081,PesqPict("AH5","AH5_QTDACU"),7,/*lPixel*/,{|| nQtdDev }) // "Qtd Dev"
TRCell():New(oProduto,"QTDLIQU"   ,     ,STR0043,PesqPict("AH5","AH5_QTDACU"),7,/*lPixel*/,{|| nQtliq }) //"Qtd Liq"
TRCell():New(oProduto,"AH5_BASEDA","AH5",STR0044,/*Picture*/,14,/*lPixel*/,{||nBaseda }) //"Base para D.A."
TRCell():New(oProduto,"AH5_PERCDA","AH5",STR0045,/*Picture*/,5,/*lPixel*/,{|| nPercda }) //"%D.A."
TRCell():New(oProduto,"VALOR"     ,     ,STR0046,PesqPict("AH5","AH5_VALORD"),14,/*lPixel*/,{|| nValorda }) //"Valor do D.A."
TRCell():New(oProduto,"TOTPAG"    ,     ,STR0047,PesqPict("AH5","AH5_VALORD"),14,/*lPixel*/,{|| nTotPagar }) //"Valor a pagar"
TRCell():New(oProduto,"AH3_TIPOPA","AH3",STR0048,"@!",1,/*lPixel*/,{|| cTipoPag }) //"Tp"
TRCell():New(oProduto,"AH1_VALADI","AH1",STR0049,/*Picture*/,14,/*lPixel*/,{|| nSubAdiant }) //"Valor Adian."
TRCell():New(oProduto,"AH1_SALDQT","AH1",STR0050,/*Picture*/,7,/*lPixel*/,{|| nSubAdQtd }) //"Sald Qt"
TRCell():New(oProduto,"AH1_SALDOA","AH1",STR0051,/*Picture*/,14,/*lPixel*/,{|| nSubAdVal }) //"Saldo Valor"
TRCell():New(oProduto,"MOEDA"     ,     ,STR0040,/*Picture*/,2,/*lPixel*/,{|| nMoedAdt }) // "Md"

Return(oReport)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Liber de Esteban       ³ Data ³17/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³20/12/2006³Marcelo Alexand³Alteracao referente ao BOPS 114608.          ³±±
±±³          ³               ³Inclusao de Range nas perguntas Fornecedor e ³±±
±±³          ³               ³Produto.                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport)

Local oFornecedor := oReport:Section(1)
Local oProduto    := oReport:Section(2)

Private lQuery
Private dPerInici := CTOD("01/" + StrZero(Month(mv_par01),2) + "/" + Alltrim(Str(Year(mv_par01))))
Private dPerFinal := LastDay(CTOD("01/" + StrZero(Month(mv_par02),2) + "/" + Alltrim(Str(Year(mv_par02)))))
Private cAliasAH1 := "AH1"
Private cAliasAH4 := "AH4"
Private cAliasAH5 := "AH5"

Private nTotEstran := 0
Private nTotNacion := 0
Private nTotPagar  := 0
Private nSubAdVal  := 0
Private dDatacal   := 0
Private nQtdVenda  := 0
Private nPreco     := 0
Private nQtdDev    := 0
Private nQtliq     := 0
Private nBaseda    := 0
Private nPercda    := 0
Private nValorda   := 0
Private nSaldoAdia := 0
Private nTGAdiant  := 0
Private oTPAdiaPro
Private oTGAdiaPro
Private oTPAdiaFor
Private oTGAdiaFor


If oReport:Section(1):GetOrder() == 1 //Ordem por Fornecedor
	nOrder := 2
	cOrder := "%AH1_FILIAL , AH1_FORNEC , AH1_LOJAFO , AH1_PRODUT , AH4_FILIAL, AH4_FORNEC , AH4_LOJAFO , AH4_PRODUT%"
	oReport:SetTitle(STR0056) //"Relação de Direitos Autorais(Gerencial) - Fornecedor"
	If mv_par06 == 1 //relatorio analitico

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Desabilitando celulas que nao serao impressas no modelo analitico |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oFornecedor:Cell("AH1_MOEDA"):Disable()
		oFornecedor:Cell("AH1_MOEDRO"):Disable()
		oFornecedor:Cell("AH5_DATCAL"):Disable()
		oFornecedor:Cell("QTDEVENDA"):Disable()
		oFornecedor:Cell("AH5_PRECOU"):Disable()
		oFornecedor:Cell("QTDEDEV"):Disable()
		oFornecedor:Cell("QTDLIQU"):Disable()
		oFornecedor:Cell("AH5_BASEDA"):Disable()
		oFornecedor:Cell("AH5_PERCDA"):Disable()
		oFornecedor:Cell("VALOR"):Disable()
		oFornecedor:Cell("TOTPAG"):Disable()
		oFornecedor:Cell("AH3_TIPOPA"):Disable()
		oFornecedor:Cell("AH1_VALADI"):Disable()
		oFornecedor:Cell("AH1_SALDQT"):Disable()
		oFornecedor:Cell("AH1_SALDOA"):Disable()
		oFornecedor:Cell("MOEDA"):Disable()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizadores que serao impressos no modelo analitico   |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		//Totalizador por quebra de produto
		oProduto:SetTotalText(STR0079) //"Sub-Totais"
		TRFunction():New(oProduto:Cell("QTDEVENDA"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		TRFunction():New(oProduto:Cell("QTDEDEV"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		TRFunction():New(oProduto:Cell("QTDLIQU"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		TRFunction():New(oProduto:Cell("VALOR"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		TRFunction():New(oProduto:Cell("TOTPAG"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		TRFunction():New(oProduto:Cell("AH1_SALDOA"),NIL,"ONPRINT",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		
		//Totalizador por quebra de fornecedor
		oBreak := TRBreak():New(oFornecedor,oFornecedor:Cell("FORNEC"),STR0065,.F.) // "Total do Fornecedor"
		TRFunction():New(oProduto:Cell("QTDEVENDA"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
		TRFunction():New(oProduto:Cell("QTDEDEV"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
		TRFunction():New(oProduto:Cell("QTDLIQU"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
		TRFunction():New(oProduto:Cell("VALOR"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
		TRFunction():New(oProduto:Cell("TOTPAG"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
		oTPAdiaPro := TRFunction():New(oProduto:Cell("AH1_SALDOA"),NIL,"ONPRINT",oBreak,,/*cPicture*/,,.F.,.F.,.F.)
		
		//Total Geral no final do relatorio
		TRFunction():New(oProduto:Cell("TOTPAG"),NIL,"SUM",/*oBreak*/,,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
		oTGAdiaPro := TRFunction():New(oProduto:Cell("AH1_SALDOA"),NIL,"ONPRINT",/*oBreak*/,,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
	Else //relatorio sintetico
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Desabilitando celulas que nao serao impressas no modelo sintetico |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oFornecedor:Cell("AH1_MOEDRO"):Disable()
		oFornecedor:Cell("AH5_DATCAL"):Disable()
		oFornecedor:Cell("AH5_PRECOU"):Disable()
		oFornecedor:Cell("QTDEDEV"):Disable()
		oFornecedor:Cell("QTDLIQU"):Disable()
		oFornecedor:Cell("AH5_BASEDA"):Disable()
		oFornecedor:Cell("AH5_PERCDA"):Disable()
		oFornecedor:Cell("VALOR"):Disable()
		oFornecedor:Cell("AH1_VALADI"):Disable()
		oFornecedor:Cell("AH1_SALDQT"):Disable()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Alterando titulo das celulas para impressao no modelo sintetico   |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oFornecedor:Cell("AH1_MOEDA"):SetTitle(STR0057) //"Tipo de Cálculo"
		oFornecedor:Cell("QTDEVENDA"):SetTitle(STR0058) //"Quantidade de Venda"
		oFornecedor:Cell("AH3_TIPOPA"):SetTitle(STR0059) //"Tipo Adiantamento"
		oFornecedor:Cell("AH1_SALDOA"):SetTitle(STR0060) //"Saldo Adiantamento"
		oFornecedor:Cell("MOEDA"):SetTitle(STR0061) //"Moeda Adiantamento"

		oFornecedor:Cell("QTDEVENDA"):SetBlock({|| nTotQtdVda  })
		
		//Total Geral no final do relatorio
		TRFunction():New(oFornecedor:Cell("TOTPAG"),NIL,"SUM",/*oBreak*/,/*oTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
	EndIf
Else  //Ordem por Produto
	nOrder := 1
	cOrder := "%AH1_FILIAL , AH1_PRODUT , AH1_FORNEC , AH1_LOJAFO , AH4_FILIAL , AH4_PRODUT , AH4_FORNEC , AH4_LOJAFO%"
	oReport:SetTitle(STR0062) //"Relação de Direitos Autorais(Gerencial) - Produto"
	If mv_par06 == 1 //relatorio analitico
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Desabilitando celulas que nao serao impressas no modelo analitico |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oProduto:Cell("AH1_MOEDA"):Disable()
		oProduto:Cell("AH1_MOEDRO"):Disable()
		oProduto:Cell("AH5_DATCAL"):Disable()
		oProduto:Cell("QTDEVENDA"):Disable()
		oProduto:Cell("AH5_PRECOU"):Disable()
		oProduto:Cell("QTDEDEV"):Disable()
		oProduto:Cell("QTDLIQU"):Disable()
		oProduto:Cell("AH5_BASEDA"):Disable()
		oProduto:Cell("AH5_PERCDA"):Disable()
		oProduto:Cell("VALOR"):Disable()
		oProduto:Cell("TOTPAG"):Disable()
		oProduto:Cell("AH3_TIPOPA"):Disable()
		oProduto:Cell("AH1_VALADI"):Disable()
		oProduto:Cell("AH1_SALDQT"):Disable()
		oProduto:Cell("AH1_SALDOA"):Disable()
		oProduto:Cell("MOEDA"):Disable()	

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizadores que serao impressos no modelo analitico   |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//Totalizador por quebra de fornecedor
		oFornecedor:SetTotalText(STR0079) //"Sub-Totais"
		TRFunction():New(oFornecedor:Cell("QTDEVENDA"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		TRFunction():New(oFornecedor:Cell("QTDEDEV"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		TRFunction():New(oFornecedor:Cell("QTDLIQU"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		TRFunction():New(oFornecedor:Cell("VALOR"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		TRFunction():New(oFornecedor:Cell("TOTPAG"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		TRFunction():New(oFornecedor:Cell("AH1_SALDOA"),NIL,"ONPRINT",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
		
		//Totalizador por quebra de produto
		oBreak := TRBreak():New(oProduto,oProduto:Cell("B1_COD"),STR0068,.F.) // "Total do Produto"
		TRFunction():New(oFornecedor:Cell("QTDEVENDA"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
		TRFunction():New(oFornecedor:Cell("QTDEDEV"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
		TRFunction():New(oFornecedor:Cell("QTDLIQU"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
		TRFunction():New(oFornecedor:Cell("VALOR"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
		TRFunction():New(oFornecedor:Cell("TOTPAG"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
		//TRFunction():New(oFornecedor:Cell("AH1_SALDOA"),NIL,"ONPRINT",oBreak,,/*cPicture*/,,.F.,.F.,.F.)
		oTPAdiaFor := TRFunction():New(oFornecedor:Cell("AH1_SALDOA"),NIL,"ONPRINT",oBreak,,/*cPicture*/,,.F.,.F.,.F.)
		
		//Total Geral no final do relatorio
		TRFunction():New(oFornecedor:Cell("TOTPAG"),NIL,"SUM",/*oBreak*/,,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
		oTGAdiaFor := TRFunction():New(oFornecedor:Cell("AH1_SALDOA"),NIL,"ONPRINT",/*oBreak*/,,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
	Else //relatorio sintetico
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Desabilitando celulas que nao serao impressas no modelo sintetico |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oProduto:Cell("AH1_MOEDRO"):Disable()
		oProduto:Cell("AH5_DATCAL"):Disable()
		oProduto:Cell("AH5_PRECOU"):Disable()
		oProduto:Cell("QTDEDEV"):Disable()
		oProduto:Cell("QTDLIQU"):Disable()
		oProduto:Cell("AH5_BASEDA"):Disable()
		oProduto:Cell("AH5_PERCDA"):Disable()
		oProduto:Cell("VALOR"):Disable()
		oProduto:Cell("AH3_TIPOPA"):Disable()
		oProduto:Cell("AH1_VALADI"):Disable()
		oProduto:Cell("AH1_SALDQT"):Disable()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Alterando titulo das celulas para impressao no modelo sintetico   |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oProduto:Cell("AH1_MOEDA"):SetTitle(STR0057) //"Tipo de Cálculo"
		oProduto:Cell("QTDEVENDA"):SetTitle(STR0058) //"Quantidade de Venda"
		oProduto:Cell("AH3_TIPOPA"):SetTitle(STR0059) //"Tipo Adiantamento"
		oProduto:Cell("AH1_SALDOA"):SetTitle(STR0060) //"Saldo Adiantamento"
		oProduto:Cell("MOEDA"):SetTitle(STR0061) //"Moeda Adiantamento"
		
		oProduto:Cell("QTDEVENDA"):SetBlock({|| nTotQtdVda  })
		
		//Total Geral no final do relatorio
		TRFunction():New(oProduto:Cell("TOTPAG"),NIL,"SUM",/*oBreak*/,/*oTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
	EndIf
EndIf

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Filtragem do relatorio                                        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                         ³
³ mv_par01    // Mes/Ano inicial                               ³
³ mv_par02    // Mes/Ano final                                 ³
³ mv_par03    // Fornecedor                                    ³
³ mv_par04    // Produto                                       ³
³ mv_par05    // Um por pagina (Fornecedor / Produto)          ³
³ mv_par06    // Relatorio ? Analitico / Sintetico             ³
³ mv_par07    // Imprime Zerado? Sim / Nao                     ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

#IFDEF TOP
	
	lQuery    := .T.   
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)
    
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatorio                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):BeginQuery()	

	cAliasAH1 := GetNextAlias()
	cAliasAH4 := cAliasAH1
	cAliasAH5 := cAliasAH4
	
	BeginSql Alias cAliasAH1
	
	SELECT AH1_PRODUT, AH1_FORNEC, AH1_LOJAFO, AH1_MOEDRO, AH1_MOEDA, AH1_SALDQT, AH1_VALADI, AH1_SALDOA,
	       AH4_PRODUT, AH4_FORNEC, AH4_LOJAFO, AH4_DATCAL, AH4_VALADI, AH4_QTDADI, AH4_LICITA,
	       AH5_PRODUT, AH5_FORNEC, AH5_LOJAFO, AH5_DATCAL, AH5_VALORD, AH5_LICITA,
	       AH5_PERCDA, AH5_QTDACU, AH5_PRECOU, AH5_BASEDA
	
	FROM %table:AH1% AH1, %table:AH4% AH4, %table:AH5% AH5
	
	WHERE AH1_FILIAL = %xFilial:AH1% AND AH1.%NotDel% AND
		  AH4_FILIAL = %xFilial:AH4% AND AH4.%NotDel% AND
		  AH4_DATCAL >= %Exp:dPerInici% AND AH4_DATCAL <= %Exp:dPerFinal% AND
		  AH5_FILIAL = %xFilial:AH5% AND AH5.%NotDel% AND
		  AH4_PRODUT = AH5_PRODUT AND AH4_FORNEC = AH5_FORNEC AND
		  AH4_LOJAFO = AH5_LOJAFO AND AH4_LICITA = AH5_LICITA AND AH4_DATCAL = AH5_DATCAL
	
	ORDER BY %Exp:cOrder%
	
	EndSql
	
	oReport:Section(1):EndQuery({MV_PAR03,MV_PAR04})
	
#ELSE
	
	lQuery    := .F.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros para ambiente CDX ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("CDR010P9R1")

	dbSelectArea(cAliasAH1)
	dbSetOrder(nOrder)
    
	cFiltro := 'AH1_FILIAL == "'+xFilial("AH1")+'".And.'
    
    If !Empty(mv_par03)
	cFiltro += +mv_par03+".And."
	EndIf              
    
    If !Empty(mv_par04)	
	cFiltro += +mv_par04
	EndIf

	oReport:Section(1):SetFilter(cFiltro,IndexKey())
	
#ENDIF

TRPosition():New(oFornecedor,"SA2",1,{|| xFilial("SA2")+cForneced })
TRPosition():New(oProduto,"SB1",1,{|| xFilial("SB1")+cProduto  })

If oReport:Section(1):GetOrder() == 1 //Ordem por Fornecedor
	RepPrintFor(oReport)
Else //Ordem por Produto
	RepPrintPro(oReport)
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³RepPrintFor³ Autor ³Liber de Esteban       ³ Data ³17/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio por ordem de fornecedor              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function RepPrintFor(oReport)

Local oFornecedor := oReport:Section(1)
Local oProduto    := oReport:Section(2)

oReport:SetMeter(AH1->(LastRec()))

dbSelectArea(cAliasAH1)
dbGotop()

If mv_par05 == 1 
	oFornecedor:SetPageBreak(.T.)
Else
	oFornecedor:Init()
EndIf

While !oReport:Cancel() .And. !(cAliasAH1)->(Eof())
	
	cForneced  := (cAliasAH1)->AH1_FORNEC + (cAliasAH1)->AH1_LOJAFO
	nTotQtdVda := 0
	nTotDireit := 0
	nTotPagto  := 0
	nSubTotDir := 0
	nSaldoAdia := 0
	nTotQtdVen := 0
	nTotQtdDev := 0
	nTotAdQtde := 0
	lImpFornec := .T.
	cTipoPag   := ""
	nMoedAdt   := 0
	While (cAliasAH1)->AH1_FORNEC+(cAliasAH1)->AH1_LOJAFO == cForneced .And. !(cAliasAH1)->(Eof())
		
		cProduto := (cAliasAH1)->AH1_PRODUT
		cTipCalc := If((cAliasAH1)->AH1_MOEDA == "1",STR0063,STR0064) //"Corrente"###"Forte"
		lImpProd := .T.
		
		While (cAliasAH1)->AH1_FORNEC+(cAliasAH1)->AH1_LOJAFO == cForneced .And. ;
			  (cAliasAH1)->AH1_PRODUT == cProduto .And. !(cAliasAH1)->(Eof())
			
			nSubAdiant := 0
			nSubTtQtde := 0
			nSubQtdVen := 0
			nSubQtdDev := 0
			nSubAdQtd  := AH1->AH1_SALDQT
			nSubTotDir := 0
			nSubTotPag := 0
			lSomaAdian := .T.
			nTotPagar  := 0.00
			nSubAdVal  := 0
			lTemMov    := .f.
			If mv_par06 == 1
				cTipoPag := ""
				nMoedAdt := 0
			EndIf
			
			If !lQuery
				dbSelectArea(cAliasAH4)
				dbSetOrder(4) // AH4_FILIAL+AH4_FORNEC+AH4_LOJAFO+AH4_PRODUT+Dtos(AH4_DTPRES)
				dbSeek( xFilial("AH4") + cForneced + cProduto )
				cCond := {|| xFilial(cALiasAH4) + cForneced + cProduto == (cAliasAH4)->AH4_FILIAL +;
				             (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO + (cAliasAH4)->AH4_PRODUT }
			Else
				cCond := {|| (cAliasAH1)->AH1_FORNEC + (cAliasAH1)->AH1_LOJAFO + (cAliasAH1)->AH1_PRODUT ==;
				             (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO + (cAliasAH4)->AH4_PRODUT }
			EndIf
			
			While Eval(cCond) .AND. (cALiasAH4)->(!Eof())
				
				lTemMov := .t.
				
				If !lQuery
					If AH4->AH4_DATCAL < dPerInici .Or. AH4->AH4_DATCAL > dPerFinal
						dbSelectArea("AH4")
						dbSkip()
						Loop
					Endif
				EndIf
				
				dbSelectArea("AH3")
				dbSeek( xFilial() + (cAliasAH4)->AH4_PRODUT + (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO )
				While xFilial()+(cAliasAH4)->AH4_PRODUT+(cAliasAH4)->AH4_FORNEC+(cAliasAH4)->AH4_LOJAFO == ;
					AH3->AH3_FILIAL+AH3->AH3_PRODUT+AH3->AH3_FORNEC+AH3->AH3_LOJAFO
					
					cTipoPag := Iif(Empty(cTipoPag),AH3->AH3_TIPOPA,cTipoPag)
					nMoedAdt := Iif(Empty(nMoedAdt),AH3->AH3_MDATIT,nMoedAdt)
					dbSkip()
				End
				cMdaOri := Iif((cAliasAH1)->AH1_MOEDA == "1","1",SuperGetMv("MV_MCUSTO"))   // 1=Corrente;2=Forte
				
				dbSelectArea(cAliasAH4)
				
				If lSomaAdian
					If (cAliasAH4)->AH4_VALADI > 0
						nSubAdiant := nSubAdiant + (cAliasAH4)->AH4_VALADI
						nSubAdVal  := nSubAdVal + (cAliasAH4)->AH4_VALADI
						nSubAdQtd  := nSubAdQtd + (cAliasAH4)->AH4_QTDADI
						nTotPagar  := nSubAdiant * -1
					Else
						nSubAdiant := nSubAdiant + (cAliasAH1)->AH1_SALDOA
						nSubAdVal  := nSubAdVal + (cAliasAH1)->AH1_SALDOA
						nSubAdQtd  := nSubAdQtd + (cAliasAH4)->AH4_QTDADI
						nTotPagar  := nSubAdiant * -1
					Endif
					lSomaAdian := .F.
				Endif
				
			#IFNDEF TOP
				dbSelectArea(cAliasAH5)
				dbSetOrder(4) // AH5_FILIAL+AH5_PRODUT+AH5_FORNEC+AH4_LOJAFO+AH5_LICITA+Dtos(AH5_DTPRES)
				dbSeek( xFilial("AH5") + cProduto + cForneced + (cAliasAH4)->AH4_LICITA + Dtos((cAliasAH4)->AH4_DATCAL))
				While (cAliasAH5)->(!Eof()) .AND. xFilial(cAliasAH5)+cProduto+cForneced+(cAliasAH4)->AH4_LICITA+Dtos((cAliasAH4)->AH4_DATCAL) ==;
				      (cAliasAH5)->AH5_FILIAL+(cAliasAH5)->AH5_PRODUT+(cAliasAH5)->AH5_FORNEC+(cAliasAH5)->AH5_LOJAFO+(cAliasAH5)->AH5_LICITA+Dtos((cAliasAH5)->AH5_DATCAL)

					If (cAliasAH5)->AH5_VALORD == 0.00
						dbSelectArea(cAliasAH5)
						dbSkip()
						Loop
					Endif
			#EndIf
					
					If nSubAdiant > 0.00 // Se ainda ha saldo de adiantamento em valor
						nTotPagar  := nSubAdiant * -1
					EndIf
					
					If (cAliasAH5)->AH5_PERCDA != 0
						nTotPagar := nTotPagar + xMoeda((cAliasAH5)->AH5_VALORD,Val(cMdaOri),1,(cAliasAH4)->AH4_DATCAL)
					Else
						nTotPagar := nTotPagar + (cAliasAH5)->AH5_VALORD
					Endif
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Se o valor a pagar for negativo, imprime zero e abate valor  ³
					//³ do saldo de adiantamento disponivel                          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If nTotpagar < 0.00
						If nSubAdVal > 0.00
							nSubAdVal := nSubAdVal - (cAliasAH5)->AH5_VALORD //Saldo em valor
							nTotpagar := 0
						EndIf
					Else
						nSubAdVal  := 0  //Saldo em valor
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Carrega valores para impressao da linha detalhe se a escolha for rel. analitico.  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ					
					dDatacal  := Substr(StrZero(Month((cAliasAH5)->AH5_DATCAL),2),1,2)+"/"+Substr(StrZero(Year((cAliasAH5)->AH5_DATCAL),4),3,2)
					nQtdVenda := Iif((cAliasAH5)->AH5_QTDACU>0,(cAliasAH5)->AH5_QTDACU,0)
					nPreco    := (cAliasAH5)->AH5_PRECOU
					nQtdDev   := Iif((cAliasAH5)->AH5_QTDACU<0,(cAliasAH5)->AH5_QTDACU,0)
					nQtliq    := (cAliasAH5)->AH5_QTDACU
					nBaseda   := (cAliasAH5)->AH5_BASEDA
					nPercda   := (cAliasAH5)->AH5_PERCDA
					nValorda  := xMoeda((cAliasAH5)->AH5_VALORD,(cAliasAH1)->AH1_MOEDRO,1,(cAliasAH5)->AH5_DATCAL)
					
					If mv_par06 == 1
						If lImpFornec
							If mv_par05 == 1
								oFornecedor:Init()
							Endif
							oFornecedor:PrintLine()
							lImpFornec := .F.
						EndIf
						If lImpProd
							oProduto:Cell("B1_COD"):Show()
							oProduto:Cell("DESC"):Show()
							oProduto:Cell("AH1_MOEDA"):Show()
							oProduto:Cell("AH1_MOEDRO"):Show()
							oProduto:Cell("AH3_TIPOPA"):Show()
							oProduto:Cell("MOEDA"):Show()
						Else
							oProduto:Cell("B1_COD"):Hide()
							oProduto:Cell("DESC"):Hide()
							oProduto:Cell("AH1_MOEDA"):Hide()
							oProduto:Cell("AH1_MOEDRO"):Hide()
							oProduto:Cell("AH3_TIPOPA"):Hide()
							oProduto:Cell("MOEDA"):Hide()
						EndIf
						lImpProd := .F.
						oProduto:Init()
						oProduto:PrintLine()
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totalizacao.                                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nSubTtQtde := nSubTtQtde + (cAliasAH5)->AH5_QTDACU
					nSubQtdVen := nSubQtdVen + Iif((cAliasAH5)->AH5_QTDACU>0,(cAliasAH5)->AH5_QTDACU,0)
					nSubQtdDev := nSubQtdDev + Iif((cAliasAH5)->AH5_QTDACU<0,(cAliasAH5)->AH5_QTDACU,0)
					nSubTotPag := nSubTotPag + nTotPagar // Subtotal a pagar para autor (descontando adiantamentos)
					nSubTotDir := nSubTotDir + nValorda  // Subtotal de direitos autorais
					nTotPagar  := 0.00
					If nSubAdQtd > 0
						nSubAdQtd := nSubAdQtd - (cAliasAH5)->AH5_QTDACU
					Elseif nSubAdQtd <= 0
						nSubAdQtd := 0
					EndIf
					
					If nSubAdVal > 0.00 // Se ainda ha saldo de adiantamento em valor
						nSubAdiant := nSubAdVal
					Else // Se nao ha mais saldo de adiantamentos em valor
						nSubAdiant := 0
					EndIf
					
			#IFNDEF TOP
					dbSelectArea(cAliasAH5)
					dbSkip()
				End
			#ENDIF
			
				dbSelectArea(cAliasAH4)
				dbSkip()
			End
	 		
			//subtotais
			
			nTotQtdVen := nTotQtdVen + nSubQtdVen
			nTotQtdDev := nTotQtdDev + nSubQtdDev
			nTotQtdVda := nTotQtdVda + nSubTtQtde
			nTotDireit := nTotDireit + nSubTotDir
			nTotPagto  := nTotPagto  + nSubTotPag
			nSaldoAdia := nSaldoAdia + nSubAdiant
			
			dbSelectArea(cAliasAH1)
			dbSkip()
			oReport:IncMeter()
		End
		If oProduto:Cell("AH1_SALDOA"):lEnabled .And. mv_par06 == 1
			oTPAdiaPro:SetFormula(&("{||"+str(nSaldoAdia)+"}"))	
		EndIf
		If !lImpprod
			oProduto:Finish()
		ElseIf mv_par06 == 1 .and. mv_par07 == 1 .and. !lTemMov .and. (lImpFornec .or. lImpProd)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se fornecedor nao tiver movimento e mv_par07 = 1(imprime zerado) ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If lImpFornec
				If mv_par05 == 1
					oFornecedor:Init()
				Endif
				oFornecedor:PrintLine()
				lImpFornec := .F.
			EndIf
			If lImpProd
				oProduto:Cell("B1_COD"):Show()
				oProduto:Cell("DESC"):Show()
				oProduto:Cell("AH1_MOEDA"):Show()
				oProduto:Cell("AH1_MOEDRO"):Show()
				oProduto:Cell("AH3_TIPOPA"):Show()
				oProduto:Cell("MOEDA"):Show()
				
				dDatacal  := 0
				nQtdVenda := 0
				nPreco    := 0
				nQtdDev   := 0
				nQtliq    := 0
				nBaseda   := 0
				nPercda   := 0
				nValorda  := 0
				
				oProduto:Init()
				oProduto:PrintLine()
				oProduto:Finish()
				lImpProd := .F.
			EndIf
		EndIf
		
	End
	If oProduto:Cell("AH1_SALDOA"):lEnabled .And. mv_par06 == 1
		nTGAdiant += nSaldoAdia
	    oTGAdiaPro:SetFormula(&("{||"+str(nTGAdiant)+"}"))	
	EndIf	    
	If (lTemmov .and. nTotQtdVda + nTotPagto <> 0.00 .and. mv_par07 == 2) .or. (mv_par07 == 1)
		
		If mv_par06 == 1
			If !lImpFornec
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Impressao do total por fornecedor se for rel. analitico  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oFornecedor:SetTotalText(STR0065 + cForneced) // "Total do Fornecedor "
				If mv_par05 == 1
					oFornecedor:Finish()
				Endif
			EndIf
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao da linha se a escolha for rel. sintetico.  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If nSaldoAdia < 0.00
				nSaldoAdia := 0.00
			Endif
			nTotPagar := nTotPagto
			nSubAdVal := nSaldoAdia
			If mv_par05 == 1
				oFornecedor:Init()
				oFornecedor:PrintLine()
				oFornecedor:Finish()
			Else
				oFornecedor:PrintLine()
			EndIf
		EndIf
	EndIf
	
	If SA2->A2_TIPO == "X" .or. SA2->A2_EST == "EX" // Autor Estrangeiro
		nTotEstran := nTotEstran + Round(nTotPagto,2)
	Else // Autor Nacional
		nTotNacion := nTotNacion + Round(nTotPagto,2)
	Endif
	
End                    

If mv_par05 == 2
	oFornecedor:Finish()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime total estrangeiro e nacional.                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine()
oReport:PrintText(STR0066 + TRANSFORM(VAL(STR(nTotEstran,14,2)), "@E 999,999,999.99") ) //"Total de autores estrangeiros: "
oReport:PrintText(STR0067 + TRANSFORM(VAL(STR(nTotNacion,14,2)),"@E 999,999,999.99") ) //"Total de autores nacionais:    "
oReport:SkipLine()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³RepPrintPro³ Autor ³Liber de Esteban       ³ Data ³17/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio por ordem de produto                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function RepPrintPro(oReport)

Local oFornecedor := oReport:Section(1)
Local oProduto    := oReport:Section(2)
Local cPictqtd 	  := PesqPict("AH5","AH5_QTDACU")

oReport:SetMeter((cAliasAH1)->(LastRec()))

dbSelectArea(cAliasAH1)
dbGotop()

If mv_par05 == 1 
	oProduto:SetPageBreak(.T.)
Else
	oProduto:Init()
EndIf
While !oReport:Cancel() .And. !(cAliasAH1)->(Eof())
	
	cProduto   := (cAliasAH1)->AH1_PRODUT
	nTotQtdVda := 0
	nTotDireit := 0
	nTotPagto  := 0
	nSubTotDir := 0
	nSaldoAdia := 0
	nTotQtdVen := 0
	nTotQtdDev := 0
	nTotAdQtde := 0
	lImpProd   := .T.
	cTipoPag   := ""
	nMoedAdt   := 0
	
	While (cAliasAH1)->AH1_PRODUT == cProduto .And. !(cAliasAH1)->(Eof())
		
		cForneced := (cAliasAH1)->AH1_FORNEC + (cAliasAH1)->AH1_LOJAFO
		cTipCalc  := If((cAliasAH1)->AH1_MOEDA == "1",STR0063,STR0064) //"Corrente"###"Forte"
		lImpForn  := .T.
		
		While (cAliasAH1)->AH1_PRODUT == cProduto .And.;
			  (cAliasAH1)->AH1_FORNEC+(cAliasAH1)->AH1_LOJAFO == cForneced .And. !(cAliasAH1)->(Eof())
			
			nSubAdiant := 0
			nSubTtQtde := 0
			nSubQtdVen := 0
			nSubQtdDev := 0
			nSubAdQtd  := (cAliasAH1)->AH1_SALDQT
			nSubTotDir := 0
			nSubTotPag := 0
			lSomaAdian := .T.
			nTotPagar  := 0.00
			nSubAdVal  := 0
			lTemMov    := .f.
			If mv_par06 == 1
				cTipoPag := ""
				nMoedAdt := 0
			EndIf
			
			If !lQuery
				dbSelectArea(cAliasAH4)
				dbSetOrder(1) // AH4_FILIAL+AH4_PRODUT+AH4_FORNEC+AH4_LOJAFO+Dtos(AH4_DTPRES)
				dbSeek( xFilial(cAliasAH4) + cProduto + cForneced )
				cCond := {|| xFilial(cALiasAH4) + cProduto + cForneced == (cAliasAH4)->AH4_FILIAL + (cAliasAH4)->AH4_PRODUT + (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO }
			Else
				cCond := {|| (cAliasAH1)->AH1_PRODUT + (cAliasAH1)->AH1_FORNEC + (cAliasAH1)->AH1_LOJAFO == (cAliasAH4)->AH4_PRODUT + (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO }
			EndIf
				
			While Eval(cCond) .AND. (cALiasAH4)->(!Eof())

				lTemMov := .t.
				
				If !lQuery
					If (cAliasAH4)->AH4_DATCAL < dPerInici .Or. (cAliasAH4)->AH4_DATCAL > dPerFinal
						dbSelectArea(cAliasAH4)
						dbSkip()
						Loop
					Endif
				EndIf
				
				dbSelectArea("AH3")
				dbSeek( xFilial() + (cAliasAH4)->AH4_PRODUT + (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO )
				While xFilial()+(cAliasAH4)->AH4_PRODUT+(cAliasAH4)->AH4_FORNEC+(cAliasAH4)->AH4_LOJAFO == ;
					AH3->AH3_FILIAL+AH3->AH3_PRODUT+AH3->AH3_FORNEC+AH3->AH3_LOJAFO
					
					cTipoPag := Iif(Empty(cTipoPag),AH3->AH3_TIPOPA,cTipoPag)
					nMoedAdt := Iif(Empty(nMoedAdt),AH3->AH3_MDATIT,nMoedAdt)
					dbSkip()
				End
				cMdaOri := Iif((cAliasAH1)->AH1_MOEDA == "1","1",SuperGetMv("MV_MCUSTO"))   // 1=Corrente;2=Forte
				
				dbSelectArea(cAliasAH4)
				
				If lSomaAdian
					If (cAliasAH4)->AH4_VALADI > 0
						nSubAdiant := nSubAdiant + (cAliasAH4)->AH4_VALADI
						nSubAdVal  := nSubAdVal + (cAliasAH4)->AH4_VALADI
						nSubAdQtd  := nSubAdQtd + (cAliasAH4)->AH4_QTDADI
						nTotPagar  := nSubAdiant * -1
					Else
						nSubAdiant := nSubAdiant + (cAliasAH1)->AH1_SALDOA
						nSubAdVal  := nSubAdVal + (cAliasAH1)->AH1_SALDOA
						nSubAdQtd  := nSubAdQtd + (cAliasAH4)->AH4_QTDADI
						nTotPagar  := nSubAdiant * -1
					Endif
					lSomaAdian := .F.
				Endif
				
			#IFNDEF TOP
				dbSelectArea(cAliasAH5)
				dbSetOrder(4) // AH5_FILIAL+AH5_PRODUT+AH5_FORNEC+AH4_LOJAFO+AH5_LICITA+Dtos(AH5_DTPRES)
				dbSeek( xFilial("AH5") + cProduto + cForneced + (cAliasAH4)->AH4_LICITA + Dtos((cAliasAH4)->AH4_DATCAL))
				While (cAliasAH5)->(!Eof()) .AND. xFilial(cAliasAH5)+cProduto+cForneced+(cAliasAH4)->AH4_LICITA+Dtos((cAliasAH4)->AH4_DATCAL) ==;
				      (cAliasAH5)->AH5_FILIAL+(cAliasAH5)->AH5_PRODUT+(cAliasAH5)->AH5_FORNEC+(cAliasAH5)->AH5_LOJAFO+(cAliasAH5)->AH5_LICITA+Dtos((cAliasAH5)->AH5_DATCAL)

					If (cAliasAH5)->AH5_VALORD == 0.00
						dbSelectArea(cAliasAH5)
						dbSkip()
						Loop
					Endif
			#EndIf
					
					If nSubAdiant > 0.00 // Se ainda ha saldo de adiantamento em valor
						nTotPagar  := nSubAdiant * -1
					EndIf
					
					If (cAliasAH5)->AH5_PERCDA != 0
						nTotPagar := nTotPagar + xMoeda((cAliasAH5)->AH5_VALORD,Val(cMdaOri),1,(cAliasAH4)->AH4_DATCAL)
					Else
						nTotPagar := nTotPagar + (cAliasAH5)->AH5_VALORD
					Endif
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Se o valor a pagar for negativo, imprime zero e abate valor  ³
					//³ do saldo de adiantamento disponivel                          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If nTotpagar < 0.00
						If nSubAdVal > 0.00
							nSubAdVal := nSubAdVal - (cAliasAH5)->AH5_VALORD //Saldo em valor
							nTotpagar := 0
						EndIf
					Else
						nSubAdVal  := 0  //Saldo em valor
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Carrega valores para impressao da linha detalhe se a escolha for rel. analitico.  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ					
					dDatacal  := Substr(StrZero(Month((cAliasAH5)->AH5_DATCAL),2),1,2)+"/"+Substr(StrZero(Year((cAliasAH5)->AH5_DATCAL),4),3,2)
					nQtdVenda := Iif((cAliasAH5)->AH5_QTDACU>0,(cAliasAH5)->AH5_QTDACU,0)
					nPreco    := (cAliasAH5)->AH5_PRECOU
					nQtdDev   := Iif((cAliasAH5)->AH5_QTDACU<0,(cAliasAH5)->AH5_QTDACU,0)
					nQtliq    := (cAliasAH5)->AH5_QTDACU
					nBaseda   := (cAliasAH5)->AH5_BASEDA
					nPercda   := (cAliasAH5)->AH5_PERCDA
					nValorda  := xMoeda((cAliasAH5)->AH5_VALORD,(cAliasAH1)->AH1_MOEDRO,1,(cAliasAH5)->AH5_DATCAL)
					
					If mv_par06 == 1
						If lImpProd
							If mv_par05 == 1
								oProduto:Init()
							EndIf
							oProduto:PrintLine()
							lImpProd := .F.
						EndIf
						If lImpForn
							oFornecedor:Cell("FORNEC"):Show()
							oFornecedor:Cell("NOME"):Show()
							oFornecedor:Cell("AH1_MOEDA"):Show()
							oFornecedor:Cell("AH1_MOEDRO"):Show()
							oFornecedor:Cell("AH3_TIPOPA"):Show()
							oFornecedor:Cell("MOEDA"):Show()
						Else
							oFornecedor:Cell("FORNEC"):Hide()
							oFornecedor:Cell("NOME"):Hide()
							oFornecedor:Cell("AH1_MOEDA"):Hide()
							oFornecedor:Cell("AH1_MOEDRO"):Hide()
							oFornecedor:Cell("AH3_TIPOPA"):Hide()
							oFornecedor:Cell("MOEDA"):Hide()							
						EndIf
						lImpForn := .F.
						oFornecedor:Init()	
						oFornecedor:PrintLine()
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totalizacao.                                                 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nSubTtQtde := nSubTtQtde + (cAliasAH5)->AH5_QTDACU
					nSubQtdVen := nSubQtdVen + Iif((cAliasAH5)->AH5_QTDACU>0,(cAliasAH5)->AH5_QTDACU,0)
					nSubQtdDev := nSubQtdDev + Iif((cAliasAH5)->AH5_QTDACU<0,(cAliasAH5)->AH5_QTDACU,0)
					nSubTotPag := nSubTotPag + nTotPagar // Subtotal a pagar para autor (descontando adiantamentos)
					nSubTotDir := nSubTotDir + nValorda  // Subtotal de direitos autorais
					nTotPagar  := 0.00
					If nSubAdQtd > 0
						nSubAdQtd := nSubAdQtd - (cAliasAH5)->AH5_QTDACU
					Elseif nSubAdQtd <= 0
						nSubAdQtd := 0
					EndIf
					
					If nSubAdVal > 0.00 // Se ainda ha saldo de adiantamento em valor
						nSubAdiant := nSubAdVal
					Else // Se nao ha mais saldo de adiantamentos em valor
						nSubAdiant := 0
					EndIf
			#IFNDEF TOP
					dbSelectArea(cAliasAH5)
					dbSkip()
				End
			#ENDIF
			
				dbSelectArea(cAliasAH4)
				dbSkip()
			End
	 		
			//subtotais
			
			nTotQtdVen := nTotQtdVen + nSubQtdVen
			nTotQtdDev := nTotQtdDev + nSubQtdDev
			nTotQtdVda := nTotQtdVda + nSubTtQtde
			nTotDireit := nTotDireit + nSubTotDir
			nTotPagto  := nTotPagto  + nSubTotPag
			nSaldoAdia := nSaldoAdia + nSubAdiant
			
			dbSelectArea(cAliasAH1)
			dbSkip()
			oReport:IncMeter()
		End
		If oFornecedor:Cell("AH1_SALDOA"):lEnabled .And. mv_par06 == 1
			oTPAdiaFor:SetFormula(&("{||"+str(nSaldoAdia)+"}"))	
		EndIf
		If !lImpForn
			oFornecedor:Finish()
		ElseIf mv_par06 == 1 .and. mv_par07 == 1 .and. !lTemMov .and. (lImpProd .or. lImpFornec)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se nao tiver movimento e mv_par07 = 1(imprime zerado)            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
			If lImpProd
				If mv_par05 == 1
					oProduto:Init()
				EndIf
				oProduto:PrintLine()
				lImpProd := .F.
			EndIf
			If lImpForn
				oFornecedor:Cell("FORNEC"):Show()
				oFornecedor:Cell("NOME"):Show()
				oFornecedor:Cell("AH1_MOEDA"):Show()
				oFornecedor:Cell("AH1_MOEDRO"):Show()
				oFornecedor:Cell("AH3_TIPOPA"):Show()
				oFornecedor:Cell("MOEDA"):Show()
				
				dDatacal  := 0
				nQtdVenda := 0
				nPreco    := 0
				nQtdDev   := 0
				nQtliq    := 0
				nBaseda   := 0
				nPercda   := 0
				nValorda  := 0
				
				oFornecedor:Init()
				oFornecedor:PrintLine()
				oFornecedor:Finish()
				lImpForn := .F.
			EndIf

		EndIf
		
	End
	If oFornecedor:Cell("AH1_SALDOA"):lEnabled .And. mv_par06 == 1
		nTGAdiant += nSaldoAdia
	    oTGAdiaFor:SetFormula(&("{||"+str(nTGAdiant)+"}"))	
	EndIf	    
	If (lTemmov .and. nTotQtdVda + nTotPagto <> 0.00 .and. mv_par07 == 2) .or. (mv_par07 == 1)
		If mv_par06 == 1
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao do total por produto se for rel. analitico     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oProduto:SetTotalText(STR0068 + Alltrim(SB1->B1_DESC)) // "Total do Produto "
			If mv_par05 == 1
				oProduto:Finish()
			Endif
			
			oReport:SkipLine()
			nLinTot := oReport:nRow
			
			aTotais := CR010Estoq(.t.)
			oReport:PrintText(STR0069 + Alltrim(Transform(Iif(aTotais[1] < 0, 0, aTotais[1]),cPictqtd)),nLinTot,10) //"Saldo Inic.: "
			oReport:PrintText(STR0070 + Alltrim(Transform(aTotais[2],cPictqtd)),nLinTot,320) //"Vendas: "
			oReport:PrintText(STR0071 + Alltrim(Transform(aTotais[3],cPictqtd)),nLinTot,640) //"Devolução: "
			oReport:PrintText(STR0072 + Alltrim(Transform(aTotais[4],cPictqtd)),nLinTot,960) //"Transfer.: "
			oReport:PrintText(STR0073 + Alltrim(Transform(aTotais[5],cPictqtd)),nLinTot,1280) //"Promoções: "
			oReport:PrintText(STR0074 + Alltrim(Transform(aTotais[6],cPictqtd)),nLinTot,1600) //"Consignação: "
			oReport:PrintText(STR0075 + Alltrim(Transform(aTotais[7],cPictqtd)),nLinTot,1950) //"Perdas: "
			oReport:PrintText(STR0076 + Alltrim(Transform(aTotais[8],cPictqtd)),nLinTot,2270) //"Produção: "
			oReport:PrintText(STR0077 + Alltrim(Transform(aTotais[9],cPictqtd)),nLinTot,2590) //"Acertos: "
			oReport:PrintText(STR0078 + Alltrim(Transform(aTotais[10],cPictqtd)),nLinTot,2900) //"Saldo Final: "
			oReport:SkipLine(2)
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao da linha se a escolha for rel. sintetico.  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If nSaldoAdia < 0.00
				nSaldoAdia := 0.00
			Endif
			nTotPagar := nTotPagto
			nSubAdVal := nSaldoAdia
			If mv_par05 == 1
				oProduto:Init()
				oProduto:PrintLine()
				oProduto:Finish()
			Else
				oProduto:PrintLine()
			EndIf
		EndIf
	EndIf			
	
End

If mv_par05 == 2
	oProduto:Finish()
EndIf

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CDAR010R3 ³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 17/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio gerencial de direitos autorais (royalty).        ³±±
±±³          ³ Release 3                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CDAR010(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico - controle de royalty (direito autoral)         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                         ³
³ mv_par01    // Mes/Ano inicial                               ³
³ mv_par02    // Mes/Ano final                                 ³
³ mv_par03    // Fornecedor inicial                            ³
³ mv_par04    // Fornecedor final                              ³
³ mv_par05    // Produto inicial                               ³
³ mv_par06    // Produto final                                 ³
³ mv_par07    // Um por pagina (Fornecedor / Produto)          ³
³ mv_par08    // Relatorio ? Analitico / Sintetico             ³
³ mv_par09    // Imprime Zerado? Sim / Nao                     ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*/

User Function CDAR010R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//SetPrvt("WNREL,NLASTKEY,LI,M_PAG,TAMANHO,TITULO")
Local cDesc1
Local cDesc2
Local cDesc3
Local cString

Private wnrel
Private nLastKey
Private li
Private m_pag
Private Tamanho
Private Titulo

//SetPrvt("CDESC1,CDESC2,CDESC3,AORD,CSTRING,ARETURN")
Private aOrd
Private aReturn

//SetPrvt("CPERG,LEND,NOMEPROG,CBTXT,LIMITE,CBCONT")
Private cPerg
Private lEnd
Private NomeProg
Private Limite

//SetPrvt("CCONDFILTR,NTGADIANT,NTGROYALT,CABEC1,CABEC2,DPERINICI")
Private nTGAdiant := 0
Private nTGRoyalt := 0
Private Cabec1
Private Cabec2
Private dPerInici

//SetPrvt("DPERFINAL,LFIRST,LIMPFIRST,NTOTNACION,NTOTESTRAN,CFORNECED")
Private dPerFinal
Private lFirst
Private lImpFirst
Private cForneced

//SetPrvt("NTOTQTDVDA,NTOTDIREIT,NSALDOADIA,NTOTQTDVEN,NTOTQTDDEV,NTOTADQTDE")
Private nTotQtdVda
Private nTotDireit
Private nSaldoAdia
Private nTotQtdVen
Private nTotAdQtde

//SetPrvt("CTIPOADIAN,LIMPFORNEC,NMOEDA01,CTIPCALC,CPRODUTO,LIMPFORN")
Private nMoeda01
Private cProduto

//SetPrvt("NSUBADIANT,NSUBTTQTDE,NSUBROYALT,NSUBQTDVEN,NSUBQTDDEV,NSUBADQTD")
Private nSubAdiant
Private nSubTtQtde
Private nSubQtdVen
Private nSubQtdDev
Private nSubAdQtd

//SetPrvt("LSOMAADIAN,NTOTPAGAR,NSUBADVAL,NSUBADQTD,LTEMMOV,CTIPOPAG")
Private lSomaAdian
Private nTotPagar
Private lTemMov
Private cTipoPag


//SetPrvt("NMOEDADT,CMDAORI,NSUBADISDE,LIMPPRODUT,LIMPPROD,CALIAS")
Private nMoedAdt
Private cMdaOri

//SetPrvt("ATOTAIS,")

wnrel      := 0
nLastKey   := 0
li         := 80
m_pag      := 1
tamanho    := "M"
titulo     := STR0004 //"Relacao de Direitos Autorais (Gerencial)"
cDesc1     := STR0001 //"Emissao da Relacao dos Direitos Autorais."
cDesc2     := STR0002 //"Sera solicitado em qual Ordem, e parametros necessarios "
cDesc3     := STR0003 //"para a emissao do relatorio. "

aOrd       := { STR0005, STR0006 } //" Por Codigo de Forn."###" Por Codigo do Prod."

cString    := "AH1"
aReturn    := { STR0007, 1,STR0008, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
cPerg      := "CDR010"
lEnd       := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("CDR010",.F.)

dbSelectArea("AH4")
dbSetOrder(1)      // AH4_FILIAL + AH4_PRODUT + AH4_FORNEC + AH4_LOJAFO + Dtos(AH4_DATCAL)

dbSelectArea("AH5")
dbSetOrder(4)      //AH5_FILIAL+AH5_PRODUT+AH5_FORNEC+AH5_LOJAFO+AH5_LICITA+DTOS(AH5_DATCAL)+STR(AH5_FXFINA,9)

dbSelectArea("AH1")
dbSetOrder(1)      // AH1_FILIAL + AH1_PRODUT + AH1_FORNEC + AH1_LOJAFO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "CDAR010"
wnrel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho)

If nLastKey == 27
	Return (.T.)
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return (.T.)
Endif


RptStatus({|lEnd| CR010Imp()})// Substituido pelo assistente de conversao do AP5 IDE em 09/05/01 ==> 	RptStatus({|lEnd| Execute(CR010Imp)})
Return (.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CR010Imp ³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 17/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 09/05/01 ==> Function CR010Imp
Static Function CR010Imp()
Local CbTxt       := SPACE(10)
Local cbCont      := 0
//Local cCondFiltr  := aReturn[7]

nomeprog    := "CDAR010"
limite      := 220
tamanho     := "G"
li          := 80

SetRegua(RecCount())

dbSelectArea("AH1")
DbClearFilter()

nTGAdiant := 0
nTGRoyalt := 0

If aReturn[8] == 1   // ordem de fornecedor
	
	CR010Forn()
	
Else   // ordem de produto
	
	CR010Prod()
	
Endif

If li != 80
	roda(cbcont,cbtxt,tamanho)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna a situacao original.                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set Device to Screen


If aReturn[5] == 1
	Set Printer TO
	Commit
	ourspool(wnrel)
Endif


dbSelectArea("AH1")
DbClearFilter()
dbSetOrder(1)

MS_FLUSH()
// Substituido pelo assistente de conversao do AP5 IDE em 09/05/01 ==> __Return(.T.)
Return(.T.)        // incluido pelo assistente de conversao do AP5 IDE em 09/05/01

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CR010Forn³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 18/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio por ordem de fornecedor             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CR010Forn()
Local cTipoAdian
Local lImpFornec
Local nSubAdVal
Local nSubAdQtd
Local nTotNacion := 0
Local nTotEstran := 0

Local cPictqtd := PesqPict("AH5","AH5_QTDACU")
Local cPictval := PesqPict("AH5","AH5_VALORD")
Local nTamDscPrd := 22

titulo := titulo + STR0009 //" - Fornecedor"
If mv_par08 == 1   // Relatorio Analitico
	cabec1 := STR0032 //"                                                                                                                                                                      ******* A  D  I  A  N  T  A  M  E  N  T  O *******"
	cabec2 := STR0010 //"Codigo Produto |Descricao do Produto         |C|Mda|Data   |Qtde. Venda|Preco produto|Qtde Dev.|Qtde Liqu.|  Base para D.A.|% D.A.|   Valor do D.A.|    Valor a Pagar|Tp|    Valor  Total|Saldo Qtde|  Saldo em Valor|Md"
	//         123456789012345 12345678901234567890123456789 1  11 99/9999 999.999.999 99.999.999,99 9.999.999 99.999.999 9.999.999.999,99 999.99 9.999.999.999,99 99.999.999.999,99  1 9.999.999.999,99 99.999.999 9.999.999.999,99 12
	//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
Else   // Relatorio Sintetico
	cabec1 := STR0011 //"Fornecedor                                                      Tipo de Calculo          Quantidade de Venda                Valor a Pagar (R$)  Moeda Adiantamento  Tipo Adiantamento                 Saldo Adiantamento"
	//         123456-12 1234567890123456789012345678901234567890                     x                         999.999.999                99.999.999.999,99                   12          1                          99.999.999.999,99
	//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	cabec2 := ""
Endif

dPerInici := CTOD("01/" + StrZero(Month(mv_par01),2) + "/" + Alltrim(Str(Year(mv_par01))))
dPerFinal := LastDay(CTOD("01/" + StrZero(Month(mv_par02),2) + "/" + Alltrim(Str(Year(mv_par02)))))

dbSelectArea("AH4")
dbSetOrder(4)     // AH4_FILIAL+AH4_FORNEC+AH4_LOJAFOR+AH4_PRODUT+Dtos(AH4_DTPRES)

dbSelectArea("AH1")
dbSetOrder(2)     // AH1_FILIAL + AH1_FORNEC + AH1_LOJAFO + AH1_PRODUT

SetRegua(RecCount())

dbSeek( xFilial("AH1") + mv_par03, .T. )
While AH1->AH1_FORNEC <= mv_par04 .And. !AH1->(eof())
	
	cForneced  := AH1->AH1_FORNEC + AH1->AH1_LOJAFO
	nTotQtdVda := 0
	nTotDireit := 0
	nTotPagto  := 0
	nSubTotDir := 0 // Subtotal de direitos autorais
	nSaldoAdia := 0
	nTotQtdVen := 0
	nTotQtdDev := 0
	nTotAdQtde := 0
	cTipoAdian := " "
	lImpFornec := .T.
	nMoeda01   := 0   // moeda do adiantamento
	cTipCalc   := "C" // tipo de calculo em moeda Corrente ou Forte
	While AH1->AH1_FORNEC+AH1->AH1_LOJAFO == cForneced .And. !AH1->(eof())
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o produto est  dentro do intervalo.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If AH1->AH1_PRODUT < mv_par05 .Or. AH1->AH1_PRODUT > mv_par06
			dbSelectArea("AH1")
			dbSkip()
			Loop
		Endif
		cProduto := AH1->AH1_PRODUT
		nMoeda01 := AH1->AH1_MOEDRO
		cTipCalc := AH1->AH1_MOEDA
		lImpProd := .T.
		
		While AH1->AH1_FORNEC+AH1->AH1_LOJAFO == cForneced .And. ;
			AH1->AH1_PRODUT == cProduto .And. !AH1->(eof())
			
			IncRegua()
			
			nSubAdiant := 0
			nSubTtQtde := 0
			nSubQtdVen := 0
			nSubQtdDev := 0
			nSubAdQtd  := AH1->AH1_SALDQT
			nSubTotDir := 0 // Subtotal de direitos autorais
			nSubTotPag := 0 // Subtotal de direitos autorais com desconto de adiantamentos
			lSomaAdian := .T.
			nTotPagar  := 0.00
			nSubAdVal  := 0
			lTemMov    := .f.          
			
			dbSelectArea("AH4")
			dbSetOrder(4)   // AH4_FILIAL+AH4_FORNEC+AH4_LOJAFO+AH4_PRODUT+Dtos(AH4_DTPRES)
			dbSeek( xFilial("AH4") + cForneced + cProduto )
			While AH4->AH4_FILIAL+AH4->AH4_FORNEC+AH4->AH4_LOJAFO+AH4->AH4_PRODUT==;
				xFilial("AH4") + cForneced + cProduto .And. !AH4->(eof())
				
				//	lTemMov := .t.
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se o usuario cancelou o relatorio.                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lEnd
					@Prow()+1,001 PSAY STR0012 //"CANCELADO PELO OPERADOR"
					Exit
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se o registro est  dentro do intervalo de datas.    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If AH4->AH4_DATCAL < dPerInici .Or. AH4->AH4_DATCAL > dPerFinal
					dbSelectArea("AH4")
					dbSkip()
					Loop
				Endif
  
		       If lImpFornec .Or. lImpProd  
			       lTemMov := .t.
			   EndIf   
			   				
				If lImpFornec .Or. li > 56    
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime fornecedor.                                          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("SA2")
					dbSeek( xFilial("SA2") + cForneced )
					dbSelectArea("AH4")    
					
					If mv_par08 == 1   // Analitico
						if mv_par07 == 1 .or. li > 56
							Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
						EndIf					
						@ li,00 PSAY AH4->AH4_FORNEC + "-" + AH4->AH4_LOJAFO
						@ li,30 PSAY "|" + Substr(SA2->A2_NOME,1,50)
					Endif
					lImpFornec := .F.
				Endif
				dbSelectArea("SB1")
				dbSeek( xFilial("SB1") + AH4->AH4_PRODUT )
				
				cTipoPag := ""
				nMoedAdt := 0
				dbSelectArea("AH3")
				dbSeek( xFilial() + AH4->AH4_PRODUT + AH4->AH4_FORNEC + AH4->AH4_LOJAFO )
				While xFilial()+AH4->AH4_PRODUT+AH4->AH4_FORNEC+AH4->AH4_LOJAFO == ;
					AH3->AH3_FILIAL+AH3->AH3_PRODUT+AH3->AH3_FORNEC+AH3->AH3_LOJAFO
					
					cTipoPag := Iif(Empty(cTipoPag),AH3->AH3_TIPOPA,cTipoPag)
					nMoedAdt := Iif(Empty(nMoedAdt),AH3->AH3_MDATIT,nMoedAdt)
					cTipoAdian := Iif(Empty(cTipoAdian),AH3->AH3_TIPOPA,cTipoAdian)
					dbSkip()
				End
				cMdaOri := Iif(AH1->AH1_MOEDA == "1","1",SuperGetMv("MV_MCUSTO"))   // 1=Corrente;2=Forte
				
				dbSelectArea("AH4")
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Impressao da linha detalhe se a escolha for rel. analitico.  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par08 == 1 .And. lImpProd   // Relatorio Analitico
					li := li + 1
					@ li, 00 PSAY AH4->AH4_PRODUT
					@ li, 30 PSAY "|"
					@ li, 31 PSAY Substr(SB1->B1_DESC,1,nTamDscPrd)
					@ li, nTamDscPrd+31 PSAY "|"
					@ li, nTamDscPrd+32 PSAY AH1->AH1_MOEDA
					@ li, nTamDscPrd+33 PSAY "|"
					@ li, nTamDscPrd+34 PSAY AH1->AH1_MOEDRO Picture "99"
					lImpProd := .F.
				Endif
				
				If lSomaAdian
					If AH4->AH4_VALADI > 0
						nSubAdiant := nSubAdiant + AH4->AH4_VALADI
						nSubAdVal  := nSubAdVal + AH4->AH4_VALADI
						nSubAdQtd  := nSubAdQtd + AH4->AH4_QTDADI
						nTotPagar  := nSubAdiant * -1
					Else
						nSubAdiant := nSubAdiant + AH1->AH1_SALDOA
						nSubAdVal  := nSubAdVal + AH1->AH1_SALDOA
						nSubAdQtd  := nSubAdQtd + AH4->AH4_QTDADI
						nTotPagar  := nSubAdiant * -1
					Endif
					lSomaAdian := .F.
				Endif

				dbSelectArea("AH5")  
				dbSetOrder(4) // AH5_FILIAL+AH5_PRODUT+AH5_FORNEC+AH4_LOJAFO+AH5_LICITA+Dtos(AH5_DTPRES)
				dbSeek( xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + Dtos(AH4->AH4_DATCAL) )
				While !AH5->(eof()) .And. xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA +;
					Dtos(AH4->AH4_DATCAL) == AH5->AH5_FILIAL + AH5->AH5_PRODUT + ;
					AH5->AH5_FORNEC + AH5->AH5_LOJAFO + AH5->AH5_LICITA + Dtos(AH5->AH5_DATCAL)
									
					If nSubAdiant > 0.00 // Se ainda ha saldo de adiantamento em valor
						nTotPagar  := nSubAdiant * -1
					EndIf
					
					If AH5->AH5_PERCDA != 0
						nTotPagar := nTotPagar + xMoeda(AH5->AH5_VALORD,Val(cMdaOri),1,AH4->AH4_DATCAL)
					Else
						nTotPagar := nTotPagar + AH5->AH5_VALORD
					Endif
						
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Se o valor a pagar for negativo, imprime zero e abate valor  ³
					//³ do saldo de adiantamento disponivel                          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If nTotpagar < 0.00
						If nSubAdVal > 0.00
							nSubAdVal := nSubAdVal - AH5->AH5_VALORD //Saldo em valor
							nTotpagar := 0
						EndIf
					Else
						nSubAdVal  := 0  //Saldo em valor
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao da linha detalhe se a escolha for rel. analitico.  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par08 == 1    // Relatorio Analitico
					
						If  li > 56
							Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Imprime fornecedor.                                          ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							@ li,00 PSAY AH4->AH4_FORNEC + "-" + AH4->AH4_LOJAFO
							@ li,15 PSAY "|" + Substr(SA2->A2_NOME,1,50)
							li := li + 1
							@ li, 00 PSAY AH4->AH4_PRODUT
							@ li, 30 PSAY "|"
							@ li, 31 PSAY Substr(SB1->B1_DESC,1,nTamDscPrd)
							@ li, nTamDscPrd+61 PSAY "|"
							@ li, nTamDscPrd+62 PSAY AH1->AH1_MOEDA
							@ li, nTamDscPrd+63 PSAY "|"
							@ li, nTamDscPrd+64 PSAY AH1->AH1_MOEDRO Picture "99"							
						EndIf
							
						@ li, nTamDscPrd+36 PSAY "|"
						@ li, nTamDscPrd+37 PSAY Substr(StrZero(Month(AH5->AH5_DATCAL),2),1,2)+"/"+Substr(StrZero(Year(AH5->AH5_DATCAL),4),3,2)
						@ li, nTamDscPrd+42 PSAY "|"
						@ li, nTamDscPrd+43 PSAY Iif(AH5->AH5_QTDACU>0,AH5->AH5_QTDACU,0)  Picture "@E 99,999,999"
						@ li, nTamDscPrd+53 PSAY "|"
						@ li, nTamDscPrd+54 PSAY AH5->AH5_PRECOU Picture "@E 99,999,999.99"
						@ li, nTamDscPrd+67 PSAY "|"
						@ li, nTamDscPrd+68 PSAY Iif(AH5->AH5_QTDACU<0,AH5->AH5_QTDACU,0) Picture "@E 99,999,999"
						@ li, nTamDscPrd+78 PSAY "|"
						@ li, nTamDscPrd+79 PSAY AH5->AH5_QTDACU Picture "@E 99,999,999"
						@ li, nTamDscPrd+89 PSAY "|"
						@ li, nTamDscPrd+90 PSAY AH5->AH5_BASEDA  Picture PesqPict("AH5","AH5_BASEDA")
						@ li, nTamDscPrd+106 PSAY "|"
						@ li, nTamDscPrd+107 PSAY AH5->AH5_PERCDA  Picture PesqPict("AH5","AH5_PERCDA")
						@ li, nTamDscPrd+113 PSAY "|"
						@ li, nTamDscPrd+114 PSAY AH5->AH5_VALORD Picture cPictval
						@ li, nTamDscPrd+130 PSAY "|"
						@ li, nTamDscPrd+131 PSAY nTotPagar  Picture "@E 99,999,999,999.99"
						@ li, nTamDscPrd+148 PSAY "|"
						
						@ li, nTamDscPrd+149 PSAY cTipoPag Picture "!"
						@ li, nTamDscPrd+151 PSAY "|"
						@ li, nTamDscPrd+152 PSAY nSubAdiant Picture cPictval
						@ li, nTamDscPrd+168 PSAY "|"
						@ li, nTamDscPrd+169 PSAY nSubAdQtd Picture "@E 99,999,999"
						@ li, nTamDscPrd+179 PSAY "|"
						@ li, nTamDscPrd+180 PSAY nSubAdVal Picture cPictval
						@ li, nTamDscPrd+196 PSAY "|"
						@ li, nTamDscPrd+197 PSAY nMoedAdt Picture "99"

						li := li + 1
					Endif
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totalizacao.                                                 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nSubTtQtde := nSubTtQtde + AH5->AH5_QTDACU
					nSubQtdVen := nSubQtdVen + Iif(AH5->AH5_QTDACU>0,AH5->AH5_QTDACU,0)
					nSubQtdDev := nSubQtdDev + Iif(AH5->AH5_QTDACU<0,AH5->AH5_QTDACU,0)
					nSubTotDir := nSubTotDir + nTotPagar // Subtotal de direitos autorais
					nSubTotPag := nSubTotPag + nTotPagar // Subtotal de direitos autorais com desconto de adiantamento
					nTotPagar  := 0.00
					If nSubAdQtd > 0
						nSubAdQtd := nSubAdQtd - AH5->AH5_QTDACU
					Else
						nSubAdQtd := 0
					EndIf
					
					If nSubAdVal > 0.00 // Se ainda ha saldo de adiantamento em valor
						nSubAdiant := nSubAdVal
					Else // Se nao ha mais saldo de adiantamentos em valor
						nSubAdiant := 0
					EndIf
					
					dbSelectArea("AH5")
					dbSkip()
				End
				
				dbSelectArea("AH4")
				dbSkip()
			End

			If nSubAdiant < 0.00
				nSubAdiant := 0.00
			Endif
			If nSubAdQtd < 0.00
				nSubAdQtd := 0.00
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao de sub-total se a escolha for rel. analitico.      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par08 == 1       //analitico
				If lTemMov
					li := li + 1
					@ li, 00 PSAY Replicate("-",limite)
					li := li + 1
					@ li, 00 PSAY STR0013 //"Sub-totais"
					@ li, 64 PSAY nSubQtdVen Picture cPictqtd
					@ li, 90 PSAY nSubQtdDev Picture "@E 99,999,999"
					@ li,100 PSAY nSubTtQtde Picture cPictqtd
					@ li,153 PSAY Round(nSubTotDir,2) Picture cPictval
					@ li,190 PSAY nSubAdQtd Picture cPictqtd
					@ li,201 PSAY nSubAdiant Picture cPictval
				Else
					nSubAdQtd := 0
					nSubAdiant := 0
				Endif
				li := li + 1
			Endif
			
			nSaldoAdia := nSaldoAdia + nSubAdiant
			nTotQtdVda := nTotQtdVda + nSubTtQtde
			nTotDireit := nTotDireit + nSubTotDir
			nTotPagto  := nTotPagto  + nSubTotPag
			nTotQtdVen := nTotQtdVen + nSubQtdVen
			nTotQtdDev := nTotQtdDev + nSubQtdDev
			nTotAdQtde := nTotAdQtde + nSubAdQtd
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se fornecedor nao tiver movimento e mv_par09 = 1(imprime zerado) ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
			If (mv_par08 == 1 .and. mv_par09 == 1 .and. !lTemmov .and. lImpFornec)
				if mv_par07 == 1 .or. li > 56
					Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
				EndIf
				
				dbSelectArea("SA2")
				dbSeek( xFilial("SA2") + cForneced )
				dbSelectArea("AH1")
				li++
				@ li,00 PSAY Left(cForneced,6) + "-" + Right(cForneced,2)
				@ li,10 PSAY Substr(SA2->A2_NOME,1,50)
				li += 2
				lImpFornec := .F.

				@ li, 00 PSAY Replicate("-",limite)
				li := li + 1
				@ li, 00 PSAY STR0013 //"Sub-totais"
				@ li, 64 PSAY nSubQtdVen Picture cPictqtd
				@ li, 90 PSAY nSubQtdDev Picture "@E 99,999,999"
				@ li,100 PSAY nSubTtQtde Picture cPictqtd
				@ li,153 PSAY Round(nSubTotDir,2) Picture cPictval
				@ li,190 PSAY nSubAdQtd Picture cPictqtd
				@ li,201 PSAY nSubAdiant Picture cPictval
				li := li + 1
			EndIf

			dbSelectArea("AH1")
			dbSkip()
		End
	End
	
	If ((nTotQtdVda + nTotPagto) <> 0.00 .and. mv_par09 == 2) .Or. mv_par09 == 1
		If nSaldoAdia < 0.00
			nSaldoAdia := 0.00
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao dos totais.                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par08 == 1    // Relatorio Analitico
			@ li, 00 PSAY Replicate("-",limite)
			li := li + 1
			@ li, 00 PSAY STR0014 //"Total do Fornecedor - "
			@ li, 23 PSAY Substr(SA2->A2_NOME,1,36)
			@ li, 64 PSAY nTotQtdVen          Picture cPictqtd
			@ li, 90 PSAY nTotQtdDev          Picture "@E 99,999,999"
			@ li,100 PSAY nTotQtdVda          Picture cPictqtd
			@ li,153 PSAY Round(nTotPagto,2) Picture cPictval
			@ li,201 PSAY nSaldoAdia          Picture cPictval
			li := li + 1
			@ li, 00 PSAY Replicate("-",limite)
			li := li + 1
			@ li, 00 PSAY Replicate("-",limite)
			li := li + 1
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime fornecedor.                                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			if mv_par07 == 1 .or. li > 56
				Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
			EndIf			
			dbSelectArea("SA2")
			dbSeek( xFilial("SA2") + cForneced )
			dbSelectArea("AH1")
			@ li,00 PSAY Substr(cForneced,1,6) + "-" + Right(cForneced,2)
			@ li,15 PSAY "|" + Substr(SA2->A2_NOME,1,50)
			@ li,71 PSAY cTipCalc
			@ li,97 PSAY nTotQtdVda          Picture cPictqtd
			@ li,124 PSAY Round(nTotPagto,2) Picture cPictval
			@ li,160 PSAY nMoeda01            Picture "99"
			@ li,172 PSAY cTipoAdian
			@ li,199 PSAY nSaldoAdia          Picture cPictval
		Endif
		li := li + 1
	Endif

	nTGAdiant := nTGAdiant + nSaldoAdia
	nTGRoyalt := nTGRoyalt + Round(nTotPagto,2)
	If SA2->A2_TIPO == "X" .or. SA2->A2_EST == "EX"     // Autor Estrangeiro
		nTotEstran := nTotEstran + Round(nTotPagto,2)
	Else                       // Autor Nacional
		nTotNacion := nTotNacion + Round(nTotPagto,2)
	Endif
End
If li != 80
	If li > 56
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
	Endif
	If mv_par08 == 1       
		@ li, 00 PSAY STR0015 //"Total Geral"
		@ li,149 PSAY nTGRoyalt Picture cPictval
	Else
		@ li, 00 PSAY Replicate("-",limite)
		li := li + 1
		@ li, 00 PSAY STR0015 //"Total Geral"
		@ li,124 PSAY nTGRoyalt Picture cPictval
	Endif
	li := li + 2
	
	@ li,00 PSAY STR0016 //"Total de autores estrangeiros : "
	@ li,32 PSAY nTotEstran   Picture cPictval
	li := li + 1
	@ li,00 PSAY STR0017 //"Total de autores nacionais    : "
	@ li,32 PSAY nTotNacion   Picture cPictval
	li := li + 2
Endif

Return (.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CR010Prod³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 18/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio por ordem de produto                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 09/05/01 ==> Function CR010Prod
Static Function CR010Prod()
Local lImpProdut

Local cPictqtd := PesqPict("AH5","AH5_QTDACU")
Local cPictval := PesqPict("AH5","AH5_VALORD")

titulo := titulo + STR0018 //" - Produto"
If mv_par08 == 1   // Relatorio Analitico
	cabec1 := STR0032 //"                                                                                                                                                                      ******* A  D  I  A  N  T  A  M  E  N  T  O *******"
	cabec2 := STR0019 //"Cod.Fornecedor |Nome do Fornecedor           |C|Mda|Data   |Qtde. Venda|Preco produto|Qtde Dev.|Qtde Liqu.|  Base para D.A.|% D.A.|   Valor do D.A.|    Valor a Pagar|Tp|    Valor  Total|Saldo Qtde|  Saldo em Valor|Md"
	//         123456 - 12    |12345678901234567890123456789|1| 11|99/9999|999.999.999|99.999.999,99|9.999.999|99.999.999|9.999.999.999,99|999.99|9.999.999.999,99|99.999.999.999,99| 1|9.999.999.999,99|99.999.999|9.999.999.999,99|12
	//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	
Else   // Relatorio Sintetico
	cabec1 := STR0020 //"Cod. Produto    Descricao do Produto                                              Tipo de Calculo            Quantidade de Venda                  Valor a Pagar                 Moeda                 Saldo Adiantamento"
	//         123456789012345 12345678901234567890123456789012345678901234567890                       x                           999.999.999              99.999.999.999,99                    99                  99.999.999.999,99
	//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	cabec2 := ""
Endif

//dPerInici := Ctod("01/" + mv_par01)
//dPerFinal := LastDay(Ctod("01/" + mv_par02))

dPerInici := CTOD("01/" + StrZero(Month(mv_par01),2) + "/" + Alltrim(Str(Year(mv_par01))))
dPerFinal := LastDay(CTOD("01/" + StrZero(Month(mv_par02),2) + "/" + Alltrim(Str(Year(mv_par02)))))

dbSelectArea("AH4")
dbSetOrder(1)      // AH4_FILIAL + AH4_PRODUT + AH4_FORNEC + AH4_LOJAFO + Dtos(AH4_DATCAL)

dbSelectArea("AH5")
dbSetOrder(4)      // AH5_FILIAL+AH5_PRODUT+AH5_FORNEC+AH5_LOJAFO+AH5_LICITA+DTOS(AH5_DATCAL)+STR(AH5_FXFINA,9)

dbSelectArea("AH1")
dbSetOrder(1)      // AH1_FILIAL + AH1_PRODUT + AH1_FORNEC + AH1_LOJAFO
SetRegua( RecCount() )

lImpFirst  := .F.
dbSeek( xFilial("AH1") + mv_par05, .T. )
While AH1->AH1_PRODUT <= mv_par06 .And. !AH1->(eof())
	
	cProduto   := AH1->AH1_PRODUT
	nTotQtdVda := 0
	nTotDireit := 0
	nTotPagto  := 0	
	nSaldoAdia := 0
	nTotQtdVen := 0
	nTotQtdDev := 0
	nTotAdQtde := 0
	cTipoAdian := " "	
	lImpProdut := .T.
	cTipCalc := "C"   // Tipo de calculo em moeda Corrente ou Forte
	nMoeda01 := 0     // Moeda da prestacao de contas
	While AH1->AH1_PRODUT == cProduto .And. !AH1->(eof())
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o fornecedor est  dentro do intervalo.           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If AH1->AH1_FORNEC < mv_par03 .Or. AH1->AH1_FORNEC > mv_par04
			dbSelectArea("AH1")
			dbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o usuario cancelou o relatorio.                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
			@Prow()+1,001 PSAY STR0012 //"CANCELADO PELO OPERADOR"
			Exit
		Endif
		
		cForneced := AH1->AH1_FORNEC + AH1->AH1_LOJAFO
		lImpForn  := .T.
		cTipCalc  := AH1->AH1_MOEDA
		nMoeda01  := AH1->AH1_MOEDRO
		
		While AH1->AH1_FORNEC+AH1->AH1_LOJAFO == cForneced .And. ;
			AH1->AH1_PRODUT == cProduto .And. !AH1->(eof())
			
			IncRegua()
			
			nSubAdiant := 0
			nSubTtQtde := 0
			nSubQtdVen := 0
			nSubQtdDev := 0
			nSubAdQtd := AH1->AH1_SALDQT
			nSubTotDir := 0 // Subtotal de direitos autorais
			nSubTotPag := 0 // Subtotal de direitos autorais com desconto de adiantamentos
			lSomaAdian := .T.
			nTotPagar  := 0.00
			nSubAdVal  := 0
			lTemMov    := .f.

			dbSelectArea("AH4")
			dbSeek( xFilial("AH4") + cProduto + cForneced )
			While AH4->AH4_FILIAL+AH4->AH4_PRODUT+AH4->AH4_FORNEC+AH4->AH4_LOJAFO==;
				xFilial("AH4") + cProduto + cForneced .And. !AH4->(eof())
				
  //				lTemMov := .t.
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se o usuario cancelou o relatorio.                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lAbortPrint
					@Prow()+1,001 PSAY STR0012 //"CANCELADO PELO OPERADOR"
					Exit
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se o registro est  dentro do intervalo de datas.    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If AH4->AH4_DATCAL < dPerInici .Or. AH4->AH4_DATCAL > dPerFinal
					dbSelectArea("AH4")
					dbSkip()
					Loop
				Endif
				
			    If lImpForn .or. lImpProdut
			       lTemMov := .t.
			    EndIf   
			   
				If lImpProdut .Or. li > 56
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime produto.                                         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("SB1")
					dbSeek( xFilial("SB1") + cProduto )
					dbSelectArea("AH4")
					If mv_par08 == 1   // Analitico
						if mv_par07 == 1 .or. li > 56
							Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
						EndIf					
						dbSelectArea("SB1")
						dbSeek( xFilial("SB1") + cProduto )
						dbSelectArea("AH4")
						@ li,00 PSAY AllTrim(AH1->AH1_PRODUT)
						@ li,15 PSAY "|" + Substr(SB1->B1_DESC,1,40)
						
					Endif
					lImpProdut := .F.
				Endif
				dbSelectArea("SA2")
				dbSeek(xFilial("SA2") + AH4->AH4_FORNEC + AH4->AH4_LOJAFO)
				
				cTipoPag := ""
				nMoedAdt := 0
				dbSelectArea("AH3")
				dbSeek( xFilial() + AH4->AH4_PRODUT + AH4->AH4_FORNEC + AH4->AH4_LOJAFO )
				While xFilial()+AH4->AH4_PRODUT+AH4->AH4_FORNEC+AH4->AH4_LOJAFO == ;
					AH3->AH3_FILIAL+AH3->AH3_PRODUT+AH3->AH3_FORNEC+AH3->AH3_LOJAFO
					
					cTipoPag := Iif(Empty(cTipoPag),AH3->AH3_TIPOPA,cTipoPag)
					nMoedAdt := Iif(Empty(nMoedAdt),AH3->AH3_MDATIT,nMoedAdt)
					cTipoAdian := Iif(Empty(cTipoAdian),AH3->AH3_TIPOPA,cTipoAdian)
					dbSkip()
				End
				cMdaOri := Iif(AH1->AH1_MOEDA == "1","1",SuperGetMv("MV_MCUSTO"))
				
				dbSelectArea("AH4")
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Impressao da linha detalhe se a escolha for rel. analitico.  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par08 == 1 .And. lImpForn   // Relatorio Analitico
					li := li + 1
					@ li, 00 PSAY AH4->AH4_FORNEC + "-" + AH4->AH4_LOJAFO
					@ li, 15 PSAY "|"
					@ li, 16 PSAY Substr(SA2->A2_NOME,1,28)
					@ li, 45 PSAY "|"
					@ li, 46 PSAY AH1->AH1_MOEDA
					@ li, 47 PSAY "|"
					@ li, 49 PSAY AH1->AH1_MOEDRO Picture "99"
					lImpForn := .F.
				Endif

				If lSomaAdian
					If AH4->AH4_VALADI > 0
						nSubAdiant := nSubAdiant + AH4->AH4_VALADI
						nSubAdVal  := nSubAdVal + AH4->AH4_VALADI
						nSubAdQtd  := nSubAdQtd + AH4->AH4_QTDADI
						nTotPagar  := nSubAdiant * -1
					Else
						nSubAdiant := nSubAdiant + AH1->AH1_SALDOA
						nSubAdVal  := nSubAdVal + AH1->AH1_SALDOA
						nSubAdQtd  := nSubAdQtd + AH4->AH4_QTDADI
						nTotPagar  := nSubAdiant * -1
					Endif
					lSomaAdian := .F.
				Endif
				
				dbSelectArea("AH5")
				dbSeek( xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + Dtos(AH4->AH4_DATCAL) )
				While !AH5->(eof()) .And. xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + ;
					Dtos(AH4->AH4_DATCAL) == AH5->AH5_FILIAL+AH5->AH5_PRODUT + ;
					AH5->AH5_FORNEC + AH5->AH5_LOJAFO + AH5->AH5_LICITA + Dtos(AH5->AH5_DATCAL)
						
					If nSubAdiant > 0.00 // Se ainda ha saldo de adiantamento em valor
						nTotPagar  := nSubAdiant * -1
					EndIf
					
					If AH5->AH5_PERCDA != 0
						nTotPagar := nTotPagar + xMoeda(AH5->AH5_VALORD,Val(cMdaOri),1,AH4->AH4_DATCAL)
					Else
						nTotPagar := nTotPagar + AH5->AH5_VALORD
					Endif
					
					/*If AH5->AH5_VALORD == 0.00
						dbSelectArea("AH5")
						dbSkip()
						Loop
					Endif
				    */
				    
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Se o valor a pagar for negativo, imprime zero e abate valor  ³
					//³ do saldo de adiantamento disponivel                          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If nTotpagar < 0.00
						If nSubAdVal > 0.00
							nSubAdVal := nSubAdVal - AH5->AH5_VALORD //Saldo em valor
							nTotpagar := 0
						EndIf
					Else
						nSubAdVal  := 0  //Saldo em valor
					EndIf						
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao da linha detalhe se a escolha for rel. analitico.  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par08 == 1    // Relatorio Analitico
						If li > 56
							Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Imprime produto.                                             ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							@ li,00 PSAY AllTrim(AH1->AH1_PRODUT)
							@ li,15 PSAY "|" + Substr(SB1->B1_DESC,1,40)
							li := li + 1
							
							@ li, 00 PSAY AH4->AH4_FORNEC + "-" + AH4->AH4_LOJAFO
							@ li, 15 PSAY "|"
							@ li, 16 PSAY Substr(SA2->A2_NOME,1,28)
							@ li, 45 PSAY "|"
							@ li, 46 PSAY AH1->AH1_MOEDA
							@ li, 47 PSAY "|"
							@ li, 49 PSAY AH1->AH1_MOEDRO Picture "99"
						Endif					
					
						@ li, 51 PSAY "|"
						@ li, 52 PSAY Substr(StrZero(Month(AH5->AH5_DATCAL),2),1,2)+"/"+Substr(StrZero(Year(AH5->AH5_DATCAL),4),3,2)
						@ li, 59 PSAY "|"
						@ li, 60 PSAY Iif(AH5->AH5_QTDACU>0,AH5->AH5_QTDACU,0) Picture "@E 99,999,999"
						@ li, 70 PSAY "|"
						@ li, 71 PSAY AH5->AH5_PRECOU Picture "@E 99,999,999.99"
						@ li, 84 PSAY "|"
						@ li, 85 PSAY Iif(AH5->AH5_QTDACU<0,AH5->AH5_QTDACU,0) Picture "@E 99,999,999"
						@ li, 95 PSAY "|"
						@ li, 96 PSAY AH5->AH5_QTDACU Picture cPictqtd
						@ li,106 PSAY "|"
						@ li,107 PSAY AH5->AH5_BASEDA  Picture PesqPict("AH5","AH5_BASEDA")
						@ li,123 PSAY "|"
						@ li,124 PSAY AH5->AH5_PERCDA  Picture PesqPict("AH5","AH5_PERCDA")
						@ li,130 PSAY "|"
						@ li,131 PSAY xMoeda(AH5->AH5_VALORD,AH1->AH1_MOEDRO,1,AH5->AH5_DATCAL) Picture cPictval
						@ li,147 PSAY "|"
						@ li,148 PSAY nTotPagar  Picture "@E 99,999,999,999.99"
						@ li,165 PSAY "|"
						
						@ li,167 PSAY cTipoPag Picture "!"
						@ li,168 PSAY "|"
						@ li,169 PSAY nSubAdiant Picture cPictval
						@ li,185 PSAY "|"
						@ li,186 PSAY nSubAdQtd Picture cPictqtd
						@ li,196 PSAY "|"
						@ li,197 PSAY nSubAdVal   Picture cPictval
						@ li,213 PSAY "|"
						@ li,214 PSAY nMoedAdt Picture "99"
						
						li := li + 1
					Endif
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totalizacao.                                                 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nSubTtQtde := nSubTtQtde + AH5->AH5_QTDACU
					nSubQtdVen := nSubQtdVen + Iif(AH5->AH5_QTDACU>0,AH5->AH5_QTDACU,0)
					nSubQtdDev := nSubQtdDev + Iif(AH5->AH5_QTDACU<0,AH5->AH5_QTDACU,0)
					nSubTotDir := nSubTotDir + nTotPagar // Subtotal de direitos autorais
					nSubTotPag := nSubTotPag + nTotPagar // Subtotal de direitos autorais com desconto de adiantamento					
					nTotPagar  := 0.00
					If nSubAdQtd > 0
						nSubAdQtd := nSubAdQtd - AH5->AH5_QTDACU
					Else
						nSubAdQtd := 0
					EndIf
										
					If nSubAdVal > 0.00 // Se ainda ha saldo de adiantamento em valor
						nSubAdiant := nSubAdVal
					Else // Se nao ha mais saldo de adiantamentos em valor
						nSubAdiant := 0
					EndIf

					dbSelectArea("AH5")
					dbSkip()
				End
				
				dbSelectArea("AH4")
				dbSkip()
			End
			
			If nSubAdiant < 0.00
				nSubAdiant := 0.00
			Endif
			If nSubAdQtd < 0.00
				nSubAdQtd := 0.00
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao de sub-total se a escolha for rel. analitico.      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par08 == 1       //analitico
				If lTemMov
					@ li, 00 PSAY Replicate("-",limite)
					li := li + 1
					@ li, 00 PSAY STR0013 //"Sub-totais"
					@ li, 60 PSAY nSubQtdVen Picture cPictqtd
					@ li, 86 PSAY nSubQtdDev Picture "@E 99,999,999"
					@ li, 96 PSAY nSubTtQtde Picture cPictqtd
					@ li,149 PSAY Round(nSubTotDir,2) Picture cPictval
					@ li,186 PSAY nSubAdQtd Picture cPictqtd
					@ li,197 PSAY nSubAdiant Picture cPictval
				Else
					nSubAdQtd := 0
					nSubAdiant := 0
				Endif
				li := li + 1
			Endif
			
			nSaldoAdia := nSaldoAdia + nSubAdiant
			nTotQtdVda := nTotQtdVda + nSubTtQtde
			nTotDireit := nTotDireit + nSubTotDir
			nTotPagto  := nTotPagto  + nSubTotPag			
			nTotQtdVen := nTotQtdVen + nSubQtdVen
			nTotQtdDev := nTotQtdDev + nSubQtdDev
			nTotAdQtde := nTotAdQtde + nSubAdQtd

			dbSelectArea("AH1")
			dbSkip()
		End
	End

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se produto nao tiver movimento e mv_par09 = 1(imprime zerado)    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If (mv_par08 == 1 .and. mv_par09 == 1 .and. !lTemmov .and. lImpProdut)
		if mv_par07 == 1 .or. li > 56
			Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
		EndIf
		
		dbSelectArea("SB1")
		dbSeek( xFilial("SB1") + cProduto )
		li++
		@ li,00 PSAY AllTrim(cProduto)
		@ li,15 PSAY "|" + Substr(SB1->B1_DESC,1,40)
		li += 2
		lImpProdut := .F.
	EndIf


	If ((nTotQtdVda + nTotPagto) <> 0 .and. mv_par09 == 2) .Or. mv_par09 == 1
		If nSaldoAdia < 0
			nSaldoAdia := 0
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao dos totais.                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par08 == 1    // Relatorio Analitico
			@ li, 00 PSAY Replicate("-",limite)
			li := li + 1
			@ li, 00 PSAY STR0021 //"Total do Produto - "
			dbSelectArea("SB1")
			dbSeek( xFilial("SB1") + cProduto )			
			@ li, 20 PSAY Substr(SB1->B1_DESC,1,36)
			@ li, 60 PSAY nTotQtdVen          Picture cPictqtd
			@ li, 86 PSAY nTotQtdDev          Picture "@E 99,999,999"
			@ li, 96 PSAY nTotQtdVda          Picture cPictqtd
			@ li,149 PSAY Round(nTotPagto,2) Picture cPictval
			@ li,197 PSAY nSaldoAdia          Picture cPictval
			CR010Estoq(.f.)
			li := li + 1
			@ li, 00 PSAY Replicate("_",limite)
			li := li + 1
			@ li, 00 PSAY Replicate("-",limite)
			li := li + 1
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime produto.                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			if mv_par07 == 1 .or. li > 56
				Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
			EndIf
			dbSelectArea("SB1")
			dbSeek( xFilial("SB1") + cProduto )
			dbSelectArea("AH1")
			@ li, 00 PSAY AllTrim(cProduto)
			@ li, 15 PSAY "|"
			@ li, 16 PSAY Substr(SB1->B1_DESC,1,40)
			@ li, 89 PSAY cTipCalc
			@ li,117 PSAY nTotQtdVda          Picture cPictqtd
			@ li,142 PSAY Round(nTotPagto,2) Picture cPictval
			@ li,179 PSAY nMoeda01            Picture "99"
			@ li,199 PSAY nSaldoAdia          Picture cPictval
		Endif
		li := li + 1
	Endif

	nTGAdiant := nTGAdiant + nSaldoAdia
	nTGRoyalt := nTGRoyalt + Round(nTotPagto,2)
End
If li != 80
	If li > 56
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
	Endif
	If mv_par08 == 1
		@ li, 00 PSAY STR0015 //"Total Geral"
		@ li,149 PSAY nTGRoyalt Picture cPictval
	Else
		@ li, 00 PSAY Replicate("-",limite)
		li := li + 1
		@ li, 00 PSAY STR0015 //"Total Geral"
		@ li,142 PSAY nTGRoyalt Picture cPictval
	Endif
	li := li + 1
Endif

Return (.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CR010Estoq³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 28/10/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de dados do estoque (AH7)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lTreport -> Flag que identifica se deve retornar o array,  ³±±
±±³          ³ e nao o imprimir (utilizar .T. para o tReport)             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 09/05/01 ==> Function CR010Estoq
Static Function CR010Estoq(lTreport)

Local cPictqtd := PesqPict("AH5","AH5_QTDACU")
Local cAlias := Alias()
Local aTotais := Array(10)
Afill(aTotais,0)
aTotais[1] := -9999

dbSelectArea("AH7")
dbSeek( xFilial("AH7") + cProduto )
While xFilial("AH7") + cProduto == AH7->AH7_FILIAL + AH7->AH7_PRODUT .And. ;
	!AH7->(eof())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o registro est  dentro do intervalo de datas.    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If AH7->AH7_DATCAL < dPerInici .Or. AH7->AH7_DATCAL > dPerFinal
		dbSelectArea("AH7")
		dbSkip()
		Loop
	Endif
	
	If aTotais[1] == -9999
		aTotais[1] := AH7->AH7_SALDIN
	Endif
	aTotais[2]  := aTotais[2]  + AH7->AH7_VENDAS
	aTotais[3]  := aTotais[3]  + AH7->AH7_DEVOLU
	aTotais[4]  := aTotais[4]  + AH7->AH7_TRANSF
	aTotais[5]  := aTotais[5]  + AH7->AH7_PROMOC
	aTotais[6]  := aTotais[6]  + AH7->AH7_CONSIG
	aTotais[7]  := aTotais[7]  + AH7->AH7_PERDAS
	aTotais[8]  := aTotais[8]  + AH7->AH7_PRODUC
	aTotais[9]  := aTotais[9]  + AH7->AH7_ACERTO
	aTotais[10] := AH7->AH7_SALDFI
	
	dbSelectArea("AH7")
	dbSkip()
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se estiver utilizando TREPORT devera retornar nesse ponto    ³
//³ para que os totais sejam impressos pelo componente           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lTreport
	Return aTotais
EndIf

If li > 56
	Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
Endif
li := li + 1
//@ li, 00 PSAY "Saldo inic.:999.999.999 Vendas:999.999.999 Devolucao:99.999.999 Transfer.:999.999.999  Promocoes:99.999.999  Consignacao:99.999.999  Perdas:99.999.999  Producao:999.999.999 Acertos:99.999.999 Saldo final:999.999.999"
//@ li, 00 PSAY "Saldo inic.:            Vendas:            Devolucao:           Transfer.:             Promocoes:            Consignacao:            Perdas:            Producao:            Acertos:           Saldo final:           "
//               0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//               0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22

@ li, 00 PSAY STR0022 //"Saldo inic.:"
@ li, 12 PSAY Iif(aTotais[1] < 0, 0, aTotais[1])  Picture cPictqtd
@ li, 24 PSAY STR0023 //"Vendas:"
@ li, 31 PSAY aTotais[2]  Picture cPictqtd
@ li, 43 PSAY STR0024 //"Devolucao:"
@ li, 53 PSAY aTotais[3]  Picture cPictqtd
@ li, 64 PSAY STR0025 //"Transfer.:"
@ li, 75 PSAY aTotais[4]  Picture cPictqtd
@ li, 87 PSAY STR0026 //"Promocoes:"
@ li, 97 PSAY aTotais[5]  Picture cPictqtd
@ li,110 PSAY STR0027 //"Consignacao:"
@ li,121 PSAY aTotais[6]  Picture cPictqtd
@ li,133 PSAY STR0028 //"Perdas:"
@ li,140 PSAY aTotais[7]  Picture cPictqtd
@ li,152 PSAY STR0029 //"Producao:"
@ li,161 PSAY aTotais[8]  Picture cPictqtd
@ li,173 PSAY STR0030 //"Acertos:"
@ li,181 PSAY aTotais[9]  Picture cPictqtd
@ li,192 PSAY STR0031 // "Saldo Final:"
@ li,204 PSAY aTotais[10] Picture cPictqtd
dbSelectArea( cAlias )

Return (.T.)
