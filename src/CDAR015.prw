/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CDAR015.ch"
#include "rwmake.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CDAR015  ³ Autor ³ Liber de Esteban      ³ Data ³ 08/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio periodico de direitos autorais (royalty).        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CDAR015(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico - controle de royalty (direito autoral)         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CDAR015()

Local oReport

If FindFunction("TRepInUse") .And. TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	U_CDAR015R3()
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
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := TReport():New("CDAR015",STR0037,"CDR015P9R1",{|oReport| ReportPrint(oReport)},STR0038) //"Relação de Direitos Autorais(Periodico)"###"Emissão do relatorio periodico de Direitos Autorais"
oReport:SetLandscape()
oReport:SetTotalInLine(.F.)
pergunte("CDR015P9R1",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Sessao dos fornecedores                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oFornecedor := TRSection():New(oReport,STR0039,{"AH1","AH3","AH4","AH5","SA2"},{STR0040},/*Campos do SX3*/,/*Campos do SIX*/) //"Fornecedores"###"Fornecedor + Loja + Produto"
oFornecedor:SetTotalInLine(.F.)

TRCell():New(oFornecedor,"FORNEC"    ,     ,STR0041,/*Picture*/,TAMSX3("A2_COD")[1],/*lPixel*/,{|| cForneced  }) //"Fornecedor"
TRCell():New(oFornecedor,"NOME"      ,     ,STR0042,/*Picture*/,/*nTamanho*/,/*lPixel*/,{|| SA2->A2_NOME }) //"Nome do Fornecedor"
TRCell():New(oFornecedor,"AH1_MOEDA" ,"AH1",STR0043,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| cTipCalc }) //"Tipo de Calculo"
TRCell():New(oFornecedor,"QTDEVENDA" ,     ,STR0044,PesqPict("AH5","AH5_QTDACU"),TAMSX3("AH5_QTDACU")[1],/*lPixel*/,{|| nTotQtdVda }) //"Qtde. Venda"
TRCell():New(oFornecedor,"TOTPAG"    ,     ,STR0045,PesqPict("AH5","AH5_VALORD"),TAMSX3("AH5_VALORD")[1],/*lPixel*/,{|| nTotPagar }) //"Valor a pagar"
TRCell():New(oFornecedor,"IRRF"      ,     ,STR0046,PesqPict("AH5","AH5_VALORD"),TAMSX3("AH5_VALORD")[1],/*lPixel*/,{|| nValIRRF }) //"Valor de IRRF"
TRCell():New(oFornecedor,"AH1_SALDQT","AH1",STR0047,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| nAdiaQtde }) //"Adiantamento Quantidade"
TRCell():New(oFornecedor,"AH1_SALDOA","AH1",STR0048,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| nAdiaValor }) //"Adiantamento Valor"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Sessao dos produtos                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oProduto := TRSection():New(oReport,STR0049,{"AH1","AH3","AH4","AH5","SB1"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/,,,,,,,,,0) //"Produtos"
oProduto:SetTotalInLine(.F.)

TRCell():New(oProduto,"B1_COD"    ,"SB1",STR0050,/*Picture*/,/*nTamanho*/,/*lPixel*/,{|| cProduto } ) //"Produto"
TRCell():New(oProduto,"DESC"      ,     ,STR0051,/*Picture*/,TAMSX3("B1_DESC")[1]/*nTamanho*/,.F./*lPixel*/,{|| SB1->B1_DESC }) //"Desc Prod"
TRCell():New(oProduto,"AH1_MOEDA" ,"AH1",STR0070,/*Picture*/,/*nTamaho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "C"
TRCell():New(oProduto,"AH1_MOEDRO","AH1",STR0052,/*Picture*/,/*nTamaho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Md"
TRCell():New(oProduto,"AH5_DTPRES","AH5",STR0053,/*Picture*/,/*nTamaho*/,/*lPixel*/,{|| dDtpres }) //"Data"
TRCell():New(oProduto,"QTDVENDA"  ,     ,STR0054,PesqPict("AH5","AH5_QTDACU"),TAMSX3("AH5_QTDACU")[1],/*lPixel*/,{|| nQtdVenda }) //"Qtd Ven"
TRCell():New(oProduto,"AH5_PRECOU","AH5",STR0055,/*Picture*/,/*nTamaho*/,/*lPixel*/, {|| nPreco }) //"Preço Produto"
TRCell():New(oProduto,"QTDEDEV"   ,     ,STR0056,PesqPict("AH5","AH5_QTDACU"),TAMSX3("AH5_QTDACU")[1],/*lPixel*/,{|| nQtdDev }) //"Qtd Dev"
TRCell():New(oProduto,"QTDLIQU"   ,     ,STR0057,PesqPict("AH5","AH5_QTDACU"),TAMSX3("AH5_QTDACU")[1],/*lPixel*/,{|| nQtliq }) //"Qtd Liq"
TRCell():New(oProduto,"AH5_BASEDA","AH5",STR0058,/*Picture*/,/*nTamaho*/,/*lPixel*/,{||nBaseda }) //"Base para D.A."
TRCell():New(oProduto,"AH5_PERCDA","AH5",STR0059,/*Picture*/,/*nTamaho*/,/*lPixel*/,{|| nPercda }) //"%D.A."
TRCell():New(oProduto,"VALOR"     ,     ,STR0060,PesqPict("AH5","AH5_VALORD"),TAMSX3("AH5_VALORD")[1],/*lPixel*/,{|| nValorda }) //"Valor do D.A."
TRCell():New(oProduto,"TOTPAG"    ,     ,STR0045,PesqPict("AH5","AH5_VALORD"),TAMSX3("AH5_VALORD")[1],/*lPixel*/,{|| nTotPagar }) //"Valor a pagar"
TRCell():New(oProduto,"AH3_TIPOPA","AH3",STR0061,/*Picture*/,3/*nTamaho*/,/*lPixel*/,{|| cTipoPag }) //"Tp"
TRCell():New(oProduto,"AH1_VALADI","AH1",STR0062,/*Picture*/,/*nTamaho*/,/*lPixel*/,{|| nSubAdiant }) //"Valor Adian."
TRCell():New(oProduto,"AH1_SALDQT","AH1",STR0063,/*Picture*/,/*nTamaho*/,/*lPixel*/,{|| nSubAdQtd }) //"Sald Qt"
TRCell():New(oProduto,"AH1_SALDOA","AH1",STR0064,/*Picture*/,/*nTamaho*/,/*lPixel*/,{|| nSubAdVal }) //"Saldo Valor"
TRCell():New(oProduto,"MOEDA"     ,     ,STR0052,"@E 99",2,/*lPixel*/,{|| nMoedAdt }) //"Md"

oProduto:Cell("TOTPAG"):SetAlign( "RIGH" )
oProduto:Cell("AH1_SALDOA"):SetAlign( "RIGH" )

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
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport)

Local oFornecedor := oReport:Section(1)
Local oProduto    := oReport:Section(2)
Local cPeriod		:= ""

Private lQuery
Private cAliasAH1 := "AH1"
Private cAliasAH4 := "AH4"
Private cAliasAH5 := "AH5"

Private nTotEstran := 0
Private nTotNacion := 0
Private nTotPagar  := 0
Private nSubAdVal  := 0
Private dDtpres    := 0
Private nQtdVenda  := 0
Private nPreco     := 0
Private nQtdDev    := 0
Private nQtliq     := 0
Private nBaseda    := 0
Private nPercda    := 0
Private nValorda   := 0
Private nValIRRF   := 0
Private nSaldoAdia := 0
Private nQtdeAdia  := 0 //SubTotal por obra 
Private nAdiaQtde  := 0 //Total do fornecedor
Private n
Private nTGAdiant  := 0
Private oTpAdiaPro
Private oTGAdiaPro

dPerInici := CTOD("01/" + StrZero(Month(Mv_Par01),2) + "/" + Str(Year(Mv_Par01)))
dPerFinal := LastDay(dPerInici)
cPeriod	:= MV_PAR02
aTabela   := CD040AbrIR()

//oFornecedor:Cell(19):Disable()

If mv_par06 == 1 //relatorio analitico
	
	oFornecedor:Cell("NOME"):SetSize(40)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Desabilitando celulas que nao serao impressas no modelo analitico |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oFornecedor:Cell("AH1_MOEDA"):Disable()
	oFornecedor:Cell("QTDEVENDA"):Disable()
	oFornecedor:Cell("TOTPAG"):Disable()
	oFornecedor:Cell("IRRF"):Disable()
	oFornecedor:Cell("AH1_SALDQT"):Disable()
	oFornecedor:Cell("AH1_SALDOA"):Disable()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Totalizadores que serao impressos no modelo analitico   |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Totalizador por quebra de produto
	oProduto:SetTotalText(STR0012) //"Sub-Totais"
	TRFunction():New(oProduto:Cell("QTDVENDA"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
	TRFunction():New(oProduto:Cell("QTDEDEV"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
	TRFunction():New(oProduto:Cell("QTDLIQU"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
	TRFunction():New(oProduto:Cell("VALOR"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
	TRFunction():New(oProduto:Cell("TOTPAG"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
	TRFunction():New(oProduto:Cell("AH1_SALDOA"),NIL,"ONPRINT",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
	
	//Totalizador por quebra de fornecedor
	oBreak := TRBreak():New(oFornecedor,oFornecedor:Cell("FORNEC"),STR0067,.F.) // "Total do Fornecedor"
	TRFunction():New(oProduto:Cell("QTDVENDA"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oProduto:Cell("QTDEDEV"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oProduto:Cell("QTDLIQU"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oProduto:Cell("VALOR"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oProduto:Cell("TOTPAG"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	oTpAdiaPro := TRFunction():New(oProduto:Cell("AH1_SALDOA"),NIL,"ONPRINT",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	
	//Total Geral no final do relatorio
	TRFunction():New(oProduto:Cell("TOTPAG"),NIL,"SUM",/*oBreak*/,,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
	oTGAdiaPro := TRFunction():New(oProduto:Cell("AH1_SALDOA"),NIL,"ONPRINT",/*oBreak*/,,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
	
Else //relatorio sintetico
	
	//Total Geral no final do relatorio
	TRFunction():New(oFornecedor:Cell("QTDEVENDA"),NIL,"SUM",/*oBreak*/,/*oTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
	TRFunction():New(oFornecedor:Cell("TOTPAG"),NIL,"SUM",/*oBreak*/,/*oTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
	TRFunction():New(oFornecedor:Cell("IRRF"),NIL,"SUM",/*oBreak*/,/*oTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
	TRFunction():New(oFornecedor:Cell("AH1_SALDQT"),NIL,"SUM",/*oBreak*/,/*oTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
	TRFunction():New(oFornecedor:Cell("AH1_SALDOA"),NIL,"SUM",/*oBreak*/,/*oTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)
EndIf

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Filtragem do relatorio                                        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                         ³
³ mv_par01    // Periodo do Calculo                            ³
³ mv_par02    // Period.de Impressao                           ³
³ mv_par03    // Fornecedor                                    ³
³ mv_par04    // Produto                                       ³
³ mv_par05    // Um por Pagina                                 ³
³ mv_par06    // Relatorio Analitico ou Sintetico              ³
³ mv_par07    // Imprime Zerado                                ³
³ mv_par08    // Imprime Adiantamento                          ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

#IFDEF TOP

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatorio                                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lQuery    := .T.
	oReport:Section(1):BeginQuery()	
	
	cAliasAH1 := GetNextAlias()
	cAliasAH4 := cAliasAH1
	cAliasAH5 := cAliasAH4
	
	BeginSql Alias cAliasAH1
	
	SELECT AH1_PRODUT, AH1_FORNEC, AH1_LOJAFO, AH1_MOEDRO, AH1_MOEDA, AH1_SALDQT, AH1_VALADI, AH1_SALDOA,
	       AH4_PRODUT, AH4_FORNEC, AH4_LOJAFO, AH4_DATCAL, AH4_VALADI, AH4_QTDADI, AH4_LICITA, AH4_DTPRES,
	       AH5_PRODUT, AH5_FORNEC, AH5_LOJAFO, AH5_DATCAL, AH5_VALORD, AH5_LICITA,
	       AH5_PERCDA, AH5_QTDACU, AH5_PRECOU, AH5_BASEDA, AH5_DTPRES
	
	FROM %table:AH1% AH1, %table:AH4% AH4, %table:AH5% AH5
	
	WHERE AH1_FILIAL = %xFilial:AH1% AND AH1.%NotDel% AND
		  AH4_FILIAL = %xFilial:AH4% AND AH4.%NotDel% AND
		  AH4_DTPRES >= %Exp:dPerInici% AND AH4_DTPRES <= %Exp:dPerFinal% AND
		  AH5_FILIAL = %xFilial:AH5% AND AH5.%NotDel% AND
		  AH4_PRODUT = AH5_PRODUT AND AH4_FORNEC = AH5_FORNEC AND
		  AH4_LOJAFO = AH5_LOJAFO AND AH4_LICITA = AH5_LICITA AND AH4_DATCAL = AH5_DATCAL AND
		  AH1_PERIOD = %Exp:cPeriod%	
	ORDER BY AH1_FILIAL,AH1_FORNEC,AH1_LOJAFO,AH1_PRODUT,AH4_FILIAL,AH4_FORNEC,AH4_LOJAFO,AH4_PRODUT
	
	EndSql
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar oEmbedded SQL.                        ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):EndQuery({MV_PAR03,MV_PAR04})  
	
	
#ELSE
	
	lQuery    := .F.  
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros para ambiente CDX ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("CDR015P9R1")
	
	dbSelectArea(cAliasAH1)
	dbSetOrder(2)
	
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
		cTipCalc := If((cAliasAH1)->AH1_MOEDA == "1",STR0065,STR0066) //"Corrente"###"Forte"
		lImpProd := .T.
		nAdiaValor := 0
		nAdiaQtde  := 0
		
		
		While (cAliasAH1)->AH1_FORNEC+(cAliasAH1)->AH1_LOJAFO == cForneced .And. ;
			  (cAliasAH1)->AH1_PRODUT == cProduto .And. !(cAliasAH1)->(Eof())
			
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
			lImpAdian  := .t.
			If mv_par06 == 1
				cTipoPag := ""
				nMoedAdt := 0
			EndIf
			
			If !lQuery
				dbSelectArea(cAliasAH4)
				dbSetOrder(4) // AH4_FILIAL+AH4_FORNEC+AH4_LOJAFO+AH4_PRODUT+Dtos(AH4_DTPRES)
				dbSeek( xFilial("AH4") + cForneced + cProduto + Dtos(dPerFinal) )
				cCond := {|| xFilial(cAliasAH4) + cForneced + cProduto == (cAliasAH4)->AH4_FILIAL + (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO + (cAliasAH4)->AH4_PRODUT }
			Else
				cCond := {|| (cAliasAH1)->AH1_FORNEC + (cAliasAH1)->AH1_LOJAFO + (cAliasAH1)->AH1_PRODUT ==;
				             (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO + (cAliasAH4)->AH4_PRODUT }
			EndIf
			
			While Eval(cCond) .AND. (cAliasAH4)->(!Eof()) .AND. (cAliasAH4)->AH4_DTPRES == dPerFinal
				
				lTemMov := .t.
				
				If !lQuery
					If (cAliasAH4)->AH4_DTPRES < dPerInici .Or. (cAliasAH4)->AH4_DTPRES > dPerFinal
						dbSelectArea((cAliasAH4))
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
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica o parametro mv_par08 - se o usuario deseja imprimir ³
				//³ apuracoes com ou sem adiantamento, ou ambos.                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !((mv_par08 == 1 .And. (nAdiaQtde > 0 .Or. nAdiaValor > 0)) .Or. (mv_par08 == 2 .And. nAdiaQtde == 0 .And. nAdiaValor == 0) .Or. mv_par08 == 3)
					lImpAdian := .f.
					dbSelectArea(cAliasAH4)
					dbSkip()
					Loop
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
					dDtpres   := Substr(Dtoc((cAliasAH5)->AH5_DTPRES),4,7)
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
			nQtdeAdia  := nQtdeAdia  + nSubAdQtd
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
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se nao houve movimento e mv_par07 = 1(imprime zerado) ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
				
				dDtpres   := 0
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
	Else
		nAdiaValor += nSaldoAdia
		nAdiaQtde  += nQtdeAdia
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se houve movimento e se o usuario deseja imprimir zerado    ³
	//³ e verifica mv_par08(se usuario deseja imprimir com/sem adiantamento) ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ((lTemmov .and. nTotQtdVda + nTotPagto <> 0.00 .and. mv_par07 == 2 .and. lImpAdian) .or.;
	    (mv_par07 == 1 .and. lImpAdian))
		
		If SA2->A2_TIPO == "F"
			nValIRRF := CD040CalIR(nTotPagto, dPerFinal, .F.)
		Else
			nValIRRF := 0
		Endif
		If SA2->A2_TXTRIBU > 0 .And. nTotPagto > 0
			nValIRRF := nValIRRF + Round(nTotPagto*SA2->A2_TXTRIBU/100,2)
		Endif
		If mv_par06 == 1 .and. !lImpFornec
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao do total por fornecedor se for rel. analitico  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oFornecedor:SetTotalText(STR0067 + cForneced) // "Total do Fornecedor "
			If mv_par05 == 1
				oFornecedor:Finish()
			Endif
			
			oReport:SkipLine()
			nLinTot := oReport:nRow
			
			oReport:PrintText(STR0068 + Transform(nValIRRF,"@E 999,999,999.99"),nLinTot,10) //"Total do IR: "
			oReport:PrintText(STR0069 + Transform((nTotPagto - nValIRRF),"@E 999,999,999.99"),nLinTot,500) //"Liquido: "
			
			oReport:SkipLine()
 			
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao da linha se a escolha for rel. sintetico.  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
			nTotPagar := nTotPagto

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
	
End

If mv_par05 == 2
	oFornecedor:Finish()
EndIf

Return   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CDAR015R3 ³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 17/09/96  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio gerencial de direitos autorais(royalty)- Release 3³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CDAR015(void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico - controle de royalty (direito autoral)          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

User Function CDAR015R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cString    := "AH1"
Local cDesc1     := STR0001 //"Emissao da Relacao dos Direitos Autorais."
Local cDesc2     := STR0002 //"Sera solicitado em qual Ordem, e parametros necessarios "
Local cDesc3     := STR0003 //"para a emissao do relatorio. "

Private cPerg      := "CDR015"
Private nLastKey   := 0
Private wnRel
Private m_pag      := 1
Private li
Private Tamanho
Private Titulo

Private aReturn

Private NomeProg
Private Limite

Private nTGAdiant
Private nTGRoyalt
Private Cabec1
Private Cabec2
Private dPerInici
Private dPerFinal

Private aTabela
Private lFirst
Private cForneced
Private nTotQtdVda
Private nTotDireit
Private nSaldoAdia

Private nTotQtdVen
Private nTotQtdDev
Private nTotAdQtde
Private lImpCabec
Private cMdaRoy

Private cMdaOri
Private cProduto
Private nSubAdiant
Private nSubTtQtde
Private nSubRoyalt

Private nSubQtdVen
Private nSubQtdDev
Private nSubAdQtde
Private lSomaAdian
Private nTotPagar
Private lTemMov

Private lImpFirst
Private cTipoPag
Private nMoedAdt
Private nSubAdisDe
Private nValIRRF

Private aTotGeral
Private aTotFornec
Private cTipCalcul

Private nSomaAdian
Private nValDAIt := 0
Private nInd
Private aTotProdut
Private aOrd := {}

/*/
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                         ³
³ mv_par01    // Mes/Ano da prestacao                          ³
³ mv_par02    // Periodicidade a ser impressa? ** (todos)      ³
³ mv_par03    // Fornecedor inicial                            ³
³ mv_par04    // Fornecedor final                              ³
³ mv_par05    // Produto inicial                               ³
³ mv_par06    // Produto final                                 ³
³ mv_par07    // Um por pagina (Fornecedor / Produto)          ³
³ mv_par08    // Relatorio ? Analitico / Sintetico             ³
³ mv_par09    // Imprime Zerado? Sim / Nao                     ³
³ mv_par10    // Imprime ? Com Adiant. / Sem Adiant. / Todos   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*/

li         := 80
tamanho    := "G"
titulo     := STR0004 //"Relacao de Direitos Autorais (Periodicidade)"

aReturn    := { STR0005, 1,STR0006, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("CDR015",.F.)

dbSelectArea("AH4")
dbSetOrder(1)      // AH4_FILIAL + AH4_PRODUT + AH4_FORNEC + AH4_LOJAFO + Dtos(AH4_DATCAL)

dbSelectArea("AH5")
dbSetOrder(4)      // AH5_FILIAL+AH5_PRODUT+AH5_FORNEC+AH5_LOJAFO+AH5_LICITA+DTOS(AH5_DATCAL)+STR(AH5_FXFINA,9)

dbSelectArea("AH1")
dbSetOrder(1)      // AH1_FILIAL + AH1_PRODUT + AH1_FORNEC + AH1_LOJAFO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "CDAR015"
wnrel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,Tamanho)

If nLastKey == 27
	Return (.T.)
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return (.T.)
Endif

RptStatus({|| CD015Imp()})

Return (.T.)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CD015Imp ³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 17/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR015                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CD015Imp()
Local CbTxt       := SPACE(10)
Local cbCont      := 0
//Local cCondFiltr  := aReturn[7]

nomeprog    := "CDAR015"
limite := 220
tamanho := "G"
li          := 80

SetRegua(RecCount())

dbSelectArea("AH1")
DbClearFilter()

nTGAdiant := 0
nTGRoyalt := 0

If aReturn[8] == 1   // ordem de fornecedor
	
	If mv_par08 == 1   // Relatorio analitico
		CD015Forn()
	Else               // Relatorio sintetico
		CD015FSint()
	Endif
	
Else   // ordem de produto
	
	If mv_par08 == 1   // Relatorio analitico
		CD015Prod()
	Else               // Relatorio sintetico
		CD015PSint()
	Endif
	
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
	dbCommitall()
	ourspool(wnrel)
Endif

dbSelectArea("AH1")
DbClearFilter()
dbSetOrder(1)

MS_FLUSH()

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CD015Forn³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 18/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio por ordem de fornecedor  R3         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR015                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CD015Forn()
Local lImpFornec
Local lImpForn
Local lFora := .F.

Local cPictqtd := PesqPict("AH5","AH5_QTDACU")
Local cPictval := PesqPict("AH5","AH5_VALORD")

Local nTamDscPrd := 19

If Len(aOrd)>0
	titulo := titulo + STR0007 //" - Fornecedor"
EndIf
If mv_par08 == 1   // Relatorio Analitico
	cabec1 := STR0008 //"                                                                                                                                                                      ******* A  D  I  A  N  T  A  M  E  N  T  O *******"
	cabec2 := STR0009
	//        "Codigo Produto |Descricao do Produto      |Pe|C|Mda|Data   |Qtd. Venda|Preco produto|Qtde Devo|Qtde Liqu.|  Base para D.A.|% D.A.|   Valor do D.A.|    Valor a Pagar|Tp|    Valor  Total|Saldo Qtde|  Saldo em Valor|Md"
	//         123456789012345 12345678901234567890123456 12 1  11 99/9999 999.999.999 99.999.999,99 9.999.999 99.999.999 9.999.999.999,99 999.99 9.999.999.999,99 99.999.999.999,99  1 9.999.999.999,99 99.999.999 9.999.999.999,99 12
	//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
Else   // Relatorio Sintetico
	cabec1 := STR0010 //"Fornecedor                                                                 Tipo de Calculo              Quantidade de Venda                Valor a Pagar                  Valor de IRRF               Saldo Adiantamento"
	//         123456-12 1234567890123456789012345678901234567890                                x                             999.999.999            99.999.999.999,99              99.999.999.999,99                99.999.999.999,99
	//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	cabec2 := ""
Endif

dPerInici := CTOD("01/" + StrZero(Month(Mv_Par01),2) + "/" + Str(Year(Mv_Par01)))
dPerFinal := LastDay(dPerInici)
aTabela   := CD040AbrIR()

dbSelectArea("AH4")
dbSetOrder(4)     // AH4_FILIAL+AH4_FORNEC+AH4_LOJAFO+AH4_PRODUT+Dtos(AH4_DTPRES)

dbSelectArea("AH1")
dbSetOrder(2)     // AH1_FILIAL + AH1_FORNEC + AH1_LOJAFO + AH1_PRODUT

SetRegua( RecCount() )
// R3-Analitico
lFirst := .T.
dbSeek( xFilial("AH1") + mv_par03, .T. )
While AH1->AH1_FORNEC <= mv_par04 .And. !Eof()
	
	cForneced  := AH1->AH1_FORNEC + AH1->AH1_LOJAFO
	nTotQtdVda := 0
	nTotDireit := 0
	nSaldoAdia := 0
	nTotQtdVen := 0
	nTotQtdDev := 0
	nTotAdQtde := 0
	nTotPagto  := 0
	nSubTotDir := 0 // Subtotal de direitos autorais	
	lFirst     := .T.
	lImpFornec := .F.
	lImpCabec  := .T.
	cMdaRoy    := Str(AH1->AH1_MOEDRO,2)
	cMdaOri    := Iif(AH1->AH1_MOEDA == "1","1",SuperGetMv("MV_MCUSTO"))
	
	While AH1->AH1_FORNEC+AH1->AH1_LOJAFO == cForneced .And. !Eof()
		lFora := .F.
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o produto est  dentro do intervalo.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If AH1->AH1_PRODUT < mv_par05 .Or. AH1->AH1_PRODUT > mv_par06
			lFora := .T.
			dbSelectArea("AH1")
			dbSkip()
			Loop
		Endif
		cProduto := AH1->AH1_PRODUT
		lImpForn := .F.
		
		While AH1->AH1_FORNEC+AH1->AH1_LOJAFO == cForneced .And. ;
			AH1->AH1_PRODUT == cProduto .And. !Eof()
			
			IncRegua()
			
			If mv_par02 #"**" .And. mv_par02 # AH1->AH1_PERIOD
				dbSelectArea("AH1")
				dbSkip()
				Loop
			Endif
			
			nSubAdiant := 0
			nSubTtQtde := 0
			nSubQtdVen := 0
			nSubQtdDev := 0
			nSubAdQtd  := AH1->AH1_SALDQT
			nSubTotPag := 0 // Subtotal de direitos autorais com desconto de adiantamentos
			lSomaAdian := .T.
			nTotPagar  := 0.00
			nSubAdVal  := 0
			lTemMov    := .F.        // Nao Possui Movimentacao
			
			dbSelectArea("AH4")
			dbSetOrder(4)   // AH4_FILIAL+AH4_FORNEC+AH4_LOJAFO+AH4_PRODUT+Dtos(AH4_DTPRES)
			dbSeek( xFilial("AH4") + cForneced + cProduto + Dtos(dPerFinal) )
			While AH4->AH4_FILIAL+AH4->AH4_FORNEC+AH4->AH4_LOJAFO+AH4->AH4_PRODUT==;
				xFilial("AH4") + cForneced + cProduto .And. !Eof() .And. ;
				AH4->AH4_DTPRES == dPerFinal
				
				lTemMov := .T.
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se o usuario cancelou o relatorio.                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lAbortPrint
					@Prow()+1,001 PSAY STR0011 //"CANCELADO PELO OPERADOR"
					Exit
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se o registro est  dentro do intervalo de datas.    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If AH4->AH4_DTPRES < dPerInici .Or. AH4->AH4_DTPRES > dPerFinal
					dbSelectArea("AH4")
					dbSkip()
					Loop
				Endif
				If lFirst .Or. li > 56
					If li > 56
						Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
					Endif
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime fornecedor.                                          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("SA2")
					dbSeek( xFilial("SA2") + cForneced )
					dbSelectArea("AH4")
					If mv_par08 == 1    // Rel. Analitico
						@ li,00 PSAY AH1->AH1_FORNEC + "-" + AH1->AH1_LOJAFO
						@ li,15 PSAY "|" + Substr(SA2->A2_NOME,1,50)
					Endif
					lFirst := .F.
					lImpCabec := .T.
					lImpFirst := .t.
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
					dbSkip()
				End
				
				dbSelectArea("AH4")
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Impressao da linha detalhe se a escolha for rel. analitico.  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par08 == 1 .And. !lImpForn   // Relatorio Analitico
					li++
					@ li, 00 PSAY AH4->AH4_PRODUT
					@ li, 30 PSAY "|"
					@ li, 31 PSAY Substr(SB1->B1_DESC,1,nTamDscPrd)
					@ li, nTamDscPrd+31 PSAY "|"
					@ li, nTamDscPrd+32 PSAY AH1->AH1_PERIOD
					@ li, nTamDscPrd+34 PSAY "|"
					@ li, nTamDscPrd+35 PSAY AH1->AH1_MOEDA
					@ li, nTamDscPrd+36 PSAY "|"
					@ li, nTamDscPrd+37 PSAY AH1->AH1_MOEDRO Picture "99"
										
					lImpFirst  := .T.
					lImpForn   := .T.
					lImpFornec := .T.
				Endif

				If lSomaAdian	
					If AH4->AH4_VALADI > 0
						nSubAdiant := nSubAdiant + AH4->AH4_VALADI
						nSubAdVal  := nSubAdVal + AH4->AH4_VALADI
						nSubAdQtd  := nSubAdQtd + AH4->AH4_QTDADI
					Else
						nSubAdiant := nSubAdiant + AH1->AH1_SALDOA
						nSubAdVal  := nSubAdVal + AH1->AH1_SALDOA
						nSubAdQtd  := nSubAdQtd + AH4->AH4_QTDADI
					Endif
					lSomaAdian := .F.
				Endif

				dbSelectArea("AH5")
				dbSetOrder(4)
				dbSeek( xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + Dtos(AH4->AH4_DATCAL) )
				While !Eof() .And. xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + ;
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
						If nSubAdVal < 0.00
							nTotpagar := (nSubAdVal*-1) + AH5->AH5_VALORD //Saldo em valor
						Else
							nSubAdVal  := 0  //Saldo em valor
						Endif
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao da linha detalhe se a escolha for rel. analitico.  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par08 == 1    // Relatorio Analitico
						
						If li > 56
							Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Imprime fornecedor.                                          ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If mv_par08 == 1
								@ li,00 PSAY AH4->AH4_FORNEC + "-" + AH4->AH4_LOJAFO
								@ li,15 PSAY "|" + Substr(SA2->A2_NOME,1,50)
								li++
								
								@ li, 00 PSAY AH4->AH4_PRODUT
								@ li, 30 PSAY "|"
								@ li, 31 PSAY Substr(SB1->B1_DESC,1,nTamDscPrd)
								@ li, nTamDscPrd+31 PSAY "|"
								@ li, nTamDscPrd+32 PSAY AH1->AH1_PERIOD
								@ li, nTamDscPrd+34 PSAY "|"
								@ li, nTamDscPrd+35 PSAY AH1->AH1_MOEDA
								@ li, nTamDscPrd+36 PSAY "|"
								@ li, nTamDscPrd+37 PSAY AH1->AH1_MOEDRO Picture "99"
							EndIf
								
							lImpFirst := .T.
							lImpCabec := .T.
						Endif
						
						@ li, nTamDscPrd+39 PSAY "|"
						@ li, nTamDscPrd+40 PSAY Substr(STRZERO(Month(AH5->AH5_DTPRES),2),1,2)+"/"+Substr(CVALTOCHAR(Year(AH5->AH5_DTPRES)),3,2)
						@ li, nTamDscPrd+45 PSAY "|"
						@ li, nTamDscPrd+46 PSAY Iif(AH5->AH5_QTDACU>0,AH5->AH5_QTDACU,0) Picture "@E 99,999,999"
						@ li, nTamDscPrd+56 PSAY "|"
						@ li, nTamDscPrd+57 PSAY AH5->AH5_PRECOU Picture "@E 99,999,999.99"
						@ li, nTamDscPrd+70 PSAY "|"
						@ li, nTamDscPrd+71 PSAY Iif(AH5->AH5_QTDACU<0,AH5->AH5_QTDACU,0) Picture "@E 99,999,999"
						@ li, nTamDscPrd+81 PSAY "|"
						@ li, nTamDscPrd+82 PSAY AH5->AH5_QTDACU Picture "@E 99,999,999"
						@ li, nTamDscPrd+92 PSAY "|"
						@ li, nTamDscPrd+93 PSAY AH5->AH5_BASEDA  Picture PesqPict("AH5","AH5_BASEDA")
						@ li, nTamDscPrd+109 PSAY "|"
						@ li, nTamDscPrd+110 PSAY AH5->AH5_PERCDA  Picture PesqPict("AH5","AH5_PERCDA")
						@ li, nTamDscPrd+116 PSAY "|"
						@ li, nTamDscPrd+117 PSAY AH5->AH5_VALORD Picture cPictval
						@ li, nTamDscPrd+133 PSAY "|"
						@ li, nTamDscPrd+134 PSAY nTotPagar  Picture "@E 99,999,999,999.99"
						@ li, nTamDscPrd+151 PSAY "|"
										
						If lImpFirst
							@ li, nTamDscPrd+152 PSAY cTipoPag Picture "!"
							@ li, nTamDscPrd+154 PSAY "|"
						EndIf
													
						@ li,nTamDscPrd+155 PSAY nSubAdiant Picture "@E 9,999,999,999.99"
						@ li,nTamDscPrd+171 PSAY "|"
						@ li,nTamDscPrd+172 PSAY nSubAdQtd Picture "@E 99,999,999"
						@ li,nTamDscPrd+182 PSAY "|"
						@ li,nTamDscPrd+183 PSAY nSubAdVal   Picture "@E 9,999,999,999.99"
                        
						If lImpFirst
							@ li,nTamDscPrd+199 PSAY "|"
							@ li,nTamDscPrd+200 PSAY nMoedAdt Picture "99"
							lImpFirst := .F.
						EndIf
						
						li++
					Endif
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totalizacao.                                                 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nSubTtQtde := nSubTtQtde + AH5->AH5_QTDACU
					nSubQtdVen := nSubQtdVen + Iif(AH5->AH5_QTDACU>0,AH5->AH5_QTDACU,0)
					nSubQtdDev := nSubQtdDev + Iif(AH5->AH5_QTDACU<0,AH5->AH5_QTDACU,0)
					nSubTotDir := nSubTotDir + AH5->AH5_VALORD // Subtotal de direitos autorais
					nSubTotPag := nSubTotPag + nTotPagar  // Subtotal de direitos autorais com desconto de adiantamento
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
			If mv_par08 == 1 .And. !lFirst
				If (lTemMov .and. mv_par09 == 1) .Or. (mv_par09 == 2 .and. (nSubQtdVen + nSubQtdDev + nSubTtQtde + nSubTotPag)<> 0)
					If lImpFirst
						li++
						lImpFirst := .F.
					Endif
					@ li, 00 PSAY Replicate("-",limite)
					li++
					@ li, 00 PSAY STR0071 //"Sub-totais"
					@ li, 64 PSAY nSubQtdVen Picture cPictqtd
					@ li, 91 PSAY nSubQtdDev Picture "@E 9,999,999"
					@ li,100 PSAY nSubTtQtde Picture cPictqtd
					@ li,136 PSAY Round(nSubTotDir,2) Picture cPictval
					@ li,154 PSAY Round(nSubTotPag,2) Picture cPictval
					
					If AH1->AH1_SALDQT > 0
						@ li,191 PSAY nSubAdQtde       Picture "@E 99,999,999"
					Else
						nSubAdQtde := 0
					Endif
					If AH1->AH1_SALDOA > 0
						@ li,202 PSAY nSubAdiant       Picture "@E 9,999,999,999.99"
					Else
						nSubAdiant := 0
					Endif
					li++
				Else
					If AH1->AH1_SALDQT == 0
						nSubAdQtde := 0
					Endif
					If AH1->AH1_SALDOA == 0
						nSubAdiant := 0
					Endif
					If lTemMov .and. mv_par09 ==2
						li := li+1
					Endif
				Endif
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
	If ((nTotQtdVda + nTotPagto) <> 0 .And. mv_par09 == 2) .Or. (mv_par09 == 1 .And. !lFora)
		If nSaldoAdia < 0
			nSaldoAdia := 0
		Endif
		If li > 56
			Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime fornecedor.                                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SA2")
			dbSeek( xFilial("SA2") + cForneced )
			dbSelectArea("AH1")
			@ li,00 PSAY Left(cForneced,6) + "-" + Right(cForneced,2)
			@ li,15 PSAY "|" + Substr(SA2->A2_NOME,1,50)
			li := li + 2
			lImpCabec := .T.
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Foi impresso o Fornecedor e nao teve movimentacao            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par09 == 1 .and. !lTemMov
				lFirst := .f.
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao dos totais.                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par08 == 1 .And. !lFirst    // Relatorio Analitico
			If SA2->A2_TIPO == "F"
				nValIRRF := CD040CalIR(nTotPagto, dPerFinal, .F.)
			Else
				nValIRRF := 0
			Endif
			If SA2->A2_TXTRIBU > 0 .And. nTotPagto > 0
				nValIRRF := nValIRRF + Round(nTotPagto*SA2->A2_TXTRIBU/100,2)
			Endif
			@ li, 00 PSAY Replicate("-",limite)
			li++
			@ li, 00 PSAY STR0013 //"Total do Fornecedor"
			@ li, 64 PSAY nTotQtdVen          Picture cPictqtd
			@ li, 91 PSAY nTotQtdDev          Picture "@E 9,999,999"
			@ li,100 PSAY nTotQtdVda          Picture cPictqtd
			@ li,136 PSAY Round(nTotDireit,2)  Picture cPictval
			@ li,154 PSAY Round(nTotPagto,2)  Picture cPictval
			@ li,202 PSAY nSaldoAdia          Picture "@E 9,999,999,999.99"
			li++
			
			@ li, 00 PSAY STR0014 //"Total IR:"
			@ li, 12 PSAY nValIRRF            Picture cPictval
			@ li, 35 PSAY STR0015 //"Liq.:"
			@ li, 42 PSAY Round(nTotPagto,2) - nValIRRF  Picture cPictval
			
			
			
			******* A  D  I  A  N  T  A  M  E  N  T  O *******
			li++
			@ li, 00 PSAY Replicate("-",limite)
			li++
			@ li, 00 PSAY Replicate("-",limite)
			li++
		Else
			If lTemMov
				dbSelectArea("SB1")
				dbSeek( xFilial("SB1") + AH4->AH4_PRODUT )
				dbSelectArea("AH1")
				@ li, 00 PSAY AH4->AH4_PRODUT
				@ li, 31 PSAY "|" + Substr(SB1->B1_DESC,1,nTamDscPrd) + "|"
				@ li, nTamDscPrd+49 PSAY AH1->AH1_PERIOD + "|"
				@ li, nTamDscPrd+52 PSAY AH1->AH1_MOEDA
				@ li, nTamDscPrd+53 PSAY "|"
				@ li, nTamDscPrd+55 PSAY AH1->AH1_MOEDRO Picture "99"
				@ li, nTamDscPrd+74 PSAY nTotQtdVda          Picture cPictqtd
				@ li, nTamDscPrd+90 PSAY Round(nTotDireit,2) Picture cPictval
				@ li, nTamDscPrd+114 PSAY nSaldoAdia          Picture "@E 99,999,999,999.99"
				li := li +1
			Endif
			lImpCabec := .f.
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se for um por folha inicializa a linha com 90, p/ pular pag. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lImpCabec
		li++
	Endif
	If lImpFornec
		If mv_par07 == 1
			li := 90
		Else
			li++
		Endif
	Endif
	nTGAdiant := nTGAdiant + nSaldoAdia
	nTGRoyalt := nTGRoyalt + Round(nTotPagto,2)
End
If li != 80
	If li > 56
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
	Endif
	If mv_par08 == 1
		@ li, 00 PSAY STR0016 //"Total Geral"
		@ li,154 PSAY nTGRoyalt Picture cPictval
		@ li,202 PSAY nTGAdiant Picture "@E 9,999,999,999.99"
	Else
		@ li, 00 PSAY Replicate("-",limite)
		li++
		@ li, 00 PSAY STR0016 //"Total Geral"
		@ li, 93 PSAY nTGRoyalt Picture cPictval
		@ li,120 PSAY nTGAdiant Picture "@E 99,999,999,999.99"
	Endif
	li++
Endif

Return (.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CD015Prod³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 18/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio por ordem de produto                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR015                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CD015Prod()
Local lImpProdut
Local lImpProd
Local nTamDscPrd := 17
Local cPictqtd := PesqPict("AH5","AH5_QTDACU")
Local cPictval := PesqPict("AH5","AH5_VALORD")

If Len(aOrd)>0
	titulo := titulo + STR0017 //" - Produto"
EndIf
If mv_par08 == 1   // Relatorio Analitico
	cabec1 := "                                                                                                                                                                          ******* A  D  I  A  N  T  A  M  E  N  T  O *******"
	cabec2 := STR0074 //"Cod.Fornecedor |Nome do Fornecedor               |C|Md|Data |Qtde. Venda|Preco produto   |Qtde Dev.|Qtde Liqu.|  Base para D.A.|% D.A.|   Valor do D.A.|    Valor a Pagar|Tp|    Valor  Total|Saldo Qtde|  Saldo em Valor|Md"
	//          123456 - 12   |12345678901234567890123456789012345|1| 11|99/99|999.999.999|99.999.999,99|9.999.999|99.999.999|9.999.999.999,99|999.99|9.999.999.999,99|99.999.999.999,99| 1|9.999.999.999,99|99.999.999|9.999.999.999,99|12
	//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	
Else   // Relatorio Sintetico
	cabec1 := STR0075 //"Cod. Produto    Descricao do Produto                               Calc   Qtde. Venda       Valor a Pagar   Mda  Saldo Adiantamento"
	//         123456789012345 12345678901234567890123456789012345678901234567890   x    999.999.999   99.999.999.999,99    12   99.999.999.999,99
	//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	//                   1         2         3         4         5         6         7         8         9        10        11        12        13
	cabec2 := ""
Endif

dPerInici := CTOD("01/" + StrZero(Month(Mv_Par01),2) + "/" + Str(Year(Mv_Par01)))
dPerFinal := LastDay(dPerInici)

dbSelectArea("AH4")
dbSetOrder(1)      // AH4_FILIAL + AH4_PRODUT + AH4_FORNEC + AH4_LOJAFO + Dtos(AH4_DATCAL)

dbSelectArea("AH5")
dbSetOrder(4)      // AH5_FILIAL+AH5_PRODUT+AH5_FORNEC+AH5_LOJAFO+AH5_LICITA+DTOS(AH5_DATCAL)+STR(AH5_FXFINA,9)

dbSelectArea("AH1")
dbSetOrder(1)      // AH1_FILIAL + AH1_PRODUT + AH1_FORNEC + AH1_LOJAFO
SetRegua( RecCount() )

lFirst := .T.
dbSeek( xFilial("AH1") + mv_par05, .T. )
While AH1->AH1_PRODUT <= mv_par06 .And. !Eof()
	
	cProduto   := AH1->AH1_PRODUT
	nTotQtdVda := 0
	nTotDireit := 0
	nSaldoAdia := 0
	nTotQtdVen := 0
	nTotQtdDev := 0
	nTotAdQtde := 0
	lFirst     := .T.
	lImpProdut := .F.
	lImpCabec  := .F.
	
	While AH1->AH1_PRODUT == cProduto .And. !Eof()
		
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
			@Prow()+1,001 PSAY STR0072 // "CANCELADO PELO OPERADOR"
			Exit
		Endif
		
		cForneced := AH1->AH1_FORNEC + AH1->AH1_LOJAFO
		lImpProd := .F.
		
		While AH1->AH1_FORNEC+AH1->AH1_LOJAFO == cForneced .And. ;
			AH1->AH1_PRODUT == cProduto .And. !Eof()
			
			IncRegua()
			
			If lFirst .Or. li > 56
				If li > 56
					Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime produto.                                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea("SB1")
				dbSeek( xFilial("SB1") + cProduto )
				dbSelectArea("AH4")
				If mv_par08 == 1
					@ li,00 PSAY AllTrim(AH1->AH1_PRODUT)
					@ li,31 PSAY "|" + Substr(SB1->B1_DESC,1,nTamDscPrd)
				Endif
				lFirst := .F.
				lImpCabec := .T.
			Endif
			
			nSubAdiant := 0
			nSubTtQtde := 0
			nSubRoyalt := 0
			nSubQtdVen := 0
			nSubQtdDev := 0
			nSubAdQtde := AH1->AH1_SALDQT
			lSomaAdian := .T.
			nTotPagar  := 0
			lTemMov    := .f.
			
			dbSelectArea("AH4")
			dbSeek( xFilial("AH4") + cProduto + cForneced )
			While AH4->AH4_FILIAL+AH4->AH4_PRODUT+AH4->AH4_FORNEC+AH4->AH4_LOJAFO==;
				xFilial("AH4") + cProduto + cForneced .And. !Eof()
				
				lTemMov := .t.
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se o usuario cancelou o relatorio.                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lAbortPrint
					@Prow()+1,001 PSAY STR0072 //"CANCELADO PELO OPERADOR"
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
				
				If li > 56
					Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime produto.                                         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("SB1")
					dbSeek( xFilial("SB1") + cProduto )
					dbSelectArea("AH4")
					If mv_par08 == 1
						@ li,00 PSAY AllTrim(AH1->AH1_PRODUT)
						@ li,31 PSAY "|" + Substr(SB1->B1_DESC,1,nTamDscPrd)
					Endif
					li := li + 2
					lImpCabec := .T.
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
					dbSkip()
				End
				cMdaOri := Iif(AH1->AH1_MOEDA == "1","1",GetMv("MV_MCUSTO"))
				
				dbSelectArea("AH4")
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Impressao da linha detalhe se a escolha for rel. analitico.  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par08 == 1 .And. !lImpProd   // Relatorio Analitico
					li++
					@ li, 00 PSAY AH4->AH4_FORNEC + "-" + AH4->AH4_LOJAFO
					@ li, 10 PSAY Substr(SA2->A2_NOME,1,50)
					@ li, nTamDscPrd+33 PSAY AH1->AH1_MOEDA
					@ li, nTamDscPrd+34 PSAY "|"
					@ li, nTamDscPrd+35 PSAY AH1->AH1_MOEDRO Picture "99"
					lImpFirst  := .T.
					lImpProd   := .T.
					lImpProdut := .T.
				Endif
				If lSomaAdian
					If AH4->AH4_VALADI > 0
						nSubAdiant := nSubAdiant + AH4->AH4_VALADI
					Else
						nSubAdiant := nSubAdiant + AH1->AH1_SALDOA
					Endif
					lSomaAdian := .F.
					nTotPagar  := nSubAdiant * -1
				Endif
				dbSelectArea("AH5")
				dbSeek( xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + Dtos(AH4->AH4_DATCAL) )
				While !Eof() .And. xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + ;
					Dtos(AH4->AH4_DATCAL) == AH5->AH5_FILIAL+AH5->AH5_PRODUT + ;
					AH5->AH5_FORNEC + AH5->AH5_LOJAFO + AH5->AH5_LICITA + Dtos(AH5->AH5_DATCAL)
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao da linha detalhe se a escolha for rel. analitico.  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par08 == 1    // Relatorio Analitico
						If li > 56
							Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Imprime produto.                                  ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							@ li,00 PSAY AllTrim(AH1->AH1_PRODUT) + " - " + Substr(SB1->B1_DESC,1,nTamDscPrd)
							li++
							@ li, 00 PSAY AH4->AH4_FORNEC + "-" + AH4->AH4_LOJAFO
							@ li, 10 PSAY Substr(SA2->A2_NOME,1,40)
							@ li, 50 PSAY AH1->AH1_MOEDA
							@ li, 51 PSAY "|"
							@ li, 53 PSAY AH1->AH1_MOEDRO Picture "99"
							@ li, nTamDscPrd+33 PSAY AH1->AH1_MOEDA
							@ li, nTamDscPrd+34 PSAY "|"
							@ li, nTamDscPrd+35 PSAY AH1->AH1_MOEDRO Picture "99"
							lImpFirst := .T.
							lImpCabec := .T.
						Endif

						If AH5->AH5_PERCDA != 0
							nTotPagar := nTotPagar + xMoeda(AH5->AH5_VALORD,Val(cMdaOri),1,AH4->AH4_DATCAL)
						Else
							nTotPagar := nTotpagar + AH5->AH5_VALORD
						Endif
						
						@ li, nTamDscPrd+37 PSAY "|"
						@ li, nTamDscPrd+38 PSAY Substr(STRZERO(Month(AH5->AH5_DTPRES),2),1,2)+"/"+Substr(CVALTOCHAR(Year(AH5->AH5_DTPRES)),3,2)
						@ li, nTamDscPrd+43 PSAY "|"
						@ li, nTamDscPrd+44 PSAY Iif(AH5->AH5_QTDACU>0,AH5->AH5_QTDACU,0) Picture cPictqtd
						@ li, nTamDscPrd+55 PSAY "|"
						@ li, nTamDscPrd+56 PSAY AH5->AH5_PRECOU Picture PesqPict("AH5","AH5_PRECOU")
						@ li, nTamDscPrd+72 PSAY "|"
						@ li, nTamDscPrd+73 PSAY Iif(AH5->AH5_QTDACU<0,AH5->AH5_QTDACU,0) Picture cPictqtd
						@ li, nTamDscPrd+84 PSAY "|"
						@ li, nTamDscPrd+85 PSAY AH5->AH5_QTDACU Picture cPictqtd
						@ li, nTamDscPrd+96 PSAY "|"
						@ li, nTamDscPrd+97 PSAY AH5->AH5_BASEDA  Picture PesqPict("AH5","AH5_BASEDA")
						@ li,nTamDscPrd+113 PSAY "|"
						@ li,nTamDscPrd+114 PSAY AH5->AH5_PERCDA  Picture PesqPict("AH5","AH5_PERCDA")
						@ li,nTamDscPrd+120 PSAY "|"
						@ li,nTamDscPrd+121 PSAY AH5->AH5_VALORD Picture cPictval
						@ li,nTamDscPrd+137 PSAY "|"
						@ li,nTamDscPrd+138 PSAY nTotPagar  Picture cPictval
						@ li,nTamDscPrd+154 PSAY "|"
						
						If lImpFirst
							@ li,nTamDscPrd+155 PSAY cTipoPag Picture "!"
							@ li,nTamDscPrd+157 PSAY "|"
							@ li,nTamDscPrd+158 PSAY AH1->AH1_VALADI Picture "@E 9,999,999,999.99"
							@ li,nTamDscPrd+174 PSAY "|"
							@ li,nTamDscPrd+175 PSAY AH1->AH1_SALDQT Picture "@E 99,999,999"
							@ li,nTamDscPrd+185 PSAY "|"
							@ li,nTamDscPrd+186 PSAY AH1->AH1_SALDOA   Picture "@E 9,999,999,999.99"
							@ li,nTamDscPrd+202 PSAY "|"
							@ li,nTamDscPrd+203 PSAY nMoedAdt Picture "99"
							lImpFirst := .F.
						Endif
						li++
					Endif
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totalizacao.                                                 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nSubTtQtde := nSubTtQtde + AH5->AH5_QTDACU
					If AH5->AH5_PERCDA != 0
						nSubRoyalt := nSubRoyalt + xMoeda(AH5->AH5_VALORD,Val(cMdaOri),1,AH4->AH4_DATCAL)
					Else
						nSubRoyalt := nSubRoyalt + AH5->AH5_VALORD
					Endif
					
					nSubQtdVen := nSubQtdVen + Iif(AH5->AH5_QTDACU>0,AH5->AH5_QTDACU,0)
					nSubQtdDev := nSubQtdDev + Iif(AH5->AH5_QTDACU<0,AH5->AH5_QTDACU,0)
					If nSubAdQtde > 0
						nSubAdQtde := nSubAdQtde - AH5->AH5_QTDACU
					Endif
					dbSelectArea("AH5")
					dbSkip()
				End
				dbSelectArea("AH4")
				dbSkip()
			End
			
			nSubAdiant := nSubAdiant - Round(nSubRoyalt,2)
			If nSubAdiant < 0
				nSubAdiant := 0
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao de sub-total se a escolha for rel. analitico.      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par08 == 1
				If (lTemMov .and. mv_par09 == 1) .Or. (mv_par09 == 2 .and. (nSubQtdVen + nSubQtdDev + nSubTtQtde + nSubRoyalt)<> 0)
					@ li, 00 PSAY Replicate("-",limite)
					li++
					@ li, 00 PSAY STR0071 //"Sub-totais"
					***
					@ li, 61 PSAY nSubQtdVen Picture cPictqtd
					@ li, 90 PSAY nSubQtdDev Picture cPictqtd
					@ li,102 PSAY nSubTtQtde Picture cPictqtd
					@ li,138 PSAY Round(nSubRoyalt,2) Picture cPictval
					If AH1->AH1_SALDQT > 0
						@ li,182 PSAY nSubAdQtde       Picture "@E 99,999,999"
					Else
						nSubAdQtde := 0
					Endif
					If AH1->AH1_SALDOA > 0
						@ li,203 PSAY nSubAdiant       Picture "@E 9,999,999,999.99"
					Else
						nSubAdiant := 0
					Endif
					li++
				Else
					nSubAdiant:=0
					nSubAdQtde:=0
				Endif
				***
			Endif
			nSaldoAdia := nSaldoAdia + nSubAdiant
			nTotQtdVda := nTotQtdVda + nSubTtQtde
			// O Direito Autoral so sera pago, caso nao houve Adiantamento, ou
			// o valor do DA seja maior que o Adiantamento( Paga-se a Diferenca)
			If Empty(nSubAdiant)
				nTotDireit := nTotDireit + nSubRoyalt
			Else
				If nSubRoyalt > nSubAdiant
					nTotDireit := nTotDireit + (nSubRoyalt - nSubAdiant)
				Endif
			Endif
			nTotQtdVen := nTotQtdVen + nSubQtdVen
			nTotQtdDev := nTotQtdDev + nSubQtdDev
			nTotAdQtde := nTotAdQtde + nSubAdQtde
			
			dbSelectArea("AH1")
			dbSkip()
		End
	End
	If ((nTotQtdVda + nTotDireit) <> 0 .And. mv_par09 == 2) .Or. mv_par09 == 1
		If nSaldoAdia < 0
			nSaldoAdia := 0
		Endif
		If li > 56
			Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime produto.                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SB1")
			dbSeek( xFilial("SB1") + cProduto )
			dbSelectArea("AH1")
			@ li,00 PSAY cProduto + " - " + Substr(SB1->B1_DESC,1,nTamDscPrd)
			li := li + 2
			lImpCabec := .T.
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao dos totais.                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par08 == 1    // Relatorio Analitico
			@ li, 00 PSAY Replicate("-",limite)
			li++
			@ li, 00 PSAY STR0020 //"Total do Produto"
			@ li, 61 PSAY nTotQtdVen          Picture cPictqtd
			@ li, 90 PSAY nTotQtdDev          Picture cPictqtd
			@ li,102 PSAY nTotQtdVda          Picture cPictqtd
			@ li,138 PSAY Round(nTotDireit,2) Picture cPictval
			@ li,203 PSAY nSaldoAdia          Picture "@E 9,999,999,999.99"
			CD015Estoq()
			li++
			@ li, 00 PSAY Replicate("_",limite)
			li++
			@ li, 00 PSAY Replicate("-",limite)
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime produto.                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lTemMov
				dbSelectArea("SB1")
				dbSeek( xFilial("SB1") + cProduto )
				dbSelectArea("AH4")
				@ li, 00 PSAY AllTrim(AH1->AH1_PRODUT)
				@ li, 31 PSAY "|" + Substr(SB1->B1_DESC,1,nTamDscPrd)
				@ li, nTamDscPrd+69 PSAY AH1->AH1_MOEDA Picture "!"
				@ li, nTamDscPrd+74 PSAY nTotQtdVda          Picture cPictqtd
				@ li, nTamDscPrd+88 PSAY Round(nTotDireit,2) Picture cPictval
				@ li, nTamDscPrd+109 PSAY AH1->AH1_MOEDRO     Picture "99"
				@ li, nTamDscPrd+114 PSAY nSaldoAdia          Picture "@E 99,999,999,999.99"
			Endif
			lImpCabec:=.F.
		Endif
		li++
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se for um por folha inicializa a linha com 90, p/ pular pag. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lImpProdut
		If mv_par07 == 1
			li := 90
		Else
			li++
		Endif
	Endif
	nTGAdiant := nTGAdiant + nSaldoAdia
	nTGRoyalt := nTGRoyalt + Round(nTotDireit,2)
End
If li != 80
	If li > 56
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
	Endif
	If mv_par08 == 1
		@ li, 00 PSAY STR0016 //"Total Geral"
		@ li,138 PSAY nTGRoyalt Picture cPictval
		@ li,202 PSAY nTGAdiant Picture "@E 99,999,999,999.99"
	Else
		@ li, 00 PSAY Replicate("-",limite)
		li++
		@ li, 00 PSAY STR0016 //"Total Geral"
		@ li, 90 PSAY nTGRoyalt Picture cPictval
		@ li,114 PSAY nTGAdiant Picture "@E 99,999,999,999.99"
	Endif
	li++
Endif

Return (.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CD015Estoq³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 28/10/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de dados do estoque (AH7)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR015                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CD015Estoq()

Local cAlias := Alias()
Local aTotais := Array(10)
Afill(aTotais,0)
aTotais[1] := -9999

If li > 56
	Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
Endif
li++
//@ li, 00 PSAY "Saldo inic.:999.999.999  Vendas:999.999.999  Devolucao:99.999.999  Transfer.:999.999.999  Promocoes:99.999.999  Consignacao:99.999.999  Perdas:99.999.999  Producao:999.999.999  Acertos:99.999.999  Saldo final:999.999.999"
//@ li, 00 PSAY "Saldo inic.:             Vendas:             Devolucao:            Transfer.:             Promocoes:            Consignacao:            Perdas:            Producao:             Acertos:            Saldo final:           "
//               0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//               0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22

dbSelectArea("AH7")
dbSeek( xFilial("AH7") + cProduto )
While xFilial("AH7") + cProduto == AH7->AH7_FILIAL + AH7->AH7_PRODUT .And. ;
	!Eof()
	
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

@ li, 00 PSAY STR0021 //"Saldo inic.:"
@ li, 12 PSAY Iif(aTotais[1] < 0, 0, aTotais[1])  Picture PesqPict("AH7","AH7_SALDIN")
@ li, 25 PSAY STR0022 //"Vendas:"
@ li, 32 PSAY aTotais[2]  Picture PesqPict("AH7","AH7_VENDAS")
@ li, 45 PSAY STR0023 //"Devolucao:"
@ li, 55 PSAY aTotais[3]  Picture PesqPict("AH7","AH7_DEVOLU")
@ li, 67 PSAY STR0024 //"Transfer.:"
@ li, 77 PSAY aTotais[4]  Picture PesqPict("AH7","AH7_TRANSF")
@ li, 90 PSAY STR0025 //"Promocoes:"
@ li,100 PSAY aTotais[5]  Picture PesqPict("AH7","AH7_PROMOC")
@ li,112 PSAY STR0026 //"Consignacao:"
@ li,124 PSAY aTotais[6]  Picture PesqPict("AH7","AH7_CONSIG")
@ li,136 PSAY STR0027 //"Perdas:"
@ li,143 PSAY aTotais[7]  Picture PesqPict("AH7","AH7_PERDAS")
@ li,155 PSAY STR0028 //"Producao:"
@ li,164 PSAY aTotais[8]  Picture PesqPict("AH7","AH7_PRODUC")
@ li,177 PSAY STR0029 //"Acertos:"
@ li,185 PSAY aTotais[9]  Picture PesqPict("AH7","AH7_ACERTO")
@ li,197 PSAY STR0030 //"Saldo final:"
@ li,209 PSAY aTotais[10] Picture PesqPict("AH7","AH7_SALDFI")
dbSelectArea( cAlias )

Return (.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CD015FSint³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 27/10/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio sintetico por ordem de fornecedor   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR015      R3-SINTETICO                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CD015FSint()
Local nInd := 0

Local cPictqtd := PesqPict("AH5","AH5_QTDACU")
Local cPictval := PesqPict("AH5","AH5_VALORD")

titulo := titulo + STR0031 //" - Fornecedor (Sintetico)"
cabec1 := STR0032 // "Fornecedor                                         Calc  Qtde. Venda     Valor a Pagar     Valor de IRRF     Qtde Adiant.  Saldo Adiantamento"
cabec2 := ""

//          1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//Fornecedor                                         Calc  Qtde. Venda     Valor a Pagar     Valor de IRRF     Qtde Adiant.  Saldo Adiantamento

dPerInici := CTOD("01/" + StrZero(Month(Mv_Par01),2) + "/" + Str(Year(Mv_Par01)))
dPerFinal := LastDay(dPerInici)
aTabela := CD040AbrIR()

dbSelectArea("AH4")
dbSetOrder(4)     // AH4_FILIAL+AH4_FORNEC+AH4_LOJAFO+AH4_PRODUT+Dtos(AH4_DTPRES)

dbSelectArea("AH1")
dbSetOrder(2)     // AH1_FILIAL + AH1_FORNEC + AH1_LOJAFO + AH1_PRODUT

SetRegua( RecCount() )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ aTotGeral: . 1 - total geral de qtde. de venda                 ³
//³            . 2 - total geral de valor a pagar (dir.autoral)    ³
//³            . 3 - total geral de imposto de renda               ³
//³            . 4 - total geral de saldo em qtde de adiantamento  ³
//³            . 5 - total geral de saldo em valor de adiantamento ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTotGeral := { 0, 0, 0, 0, 0 }

lFirst := .T.
dbSeek( xFilial("AH1") + mv_par03, .T. )
While AH1->AH1_FORNEC <= mv_par04 .And. !Eof()
	
	cForneced  := AH1->AH1_FORNEC + AH1->AH1_LOJAFO
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ aTotFornec: . 1 - total por fornec. de qtde. de venda                 ³
	//³             . 2 - total por fornec. de valor a pagar (dir.autoral)    ³
	//³             . 3 - total por fornec. de imposto de renda               ³
	//³             . 4 - total por fornec. de saldo em qtde de adiantamento  ³
	//³             . 5 - total por fornec. de saldo em valor de adiantamento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aTotFornec := { 0, 0, 0, 0, 0 }
	cTipCalcul := " "
	cMdaRoy    := "1"
	cMdaOri    := "1"
	While AH1->AH1_FORNEC+AH1->AH1_LOJAFO == cForneced .And. !Eof()
		
		IncRegua()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o produto est  dentro do intervalo.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If AH1->AH1_PRODUT < mv_par05 .Or. AH1->AH1_PRODUT > mv_par06
			dbSelectArea("AH1")
			dbSkip()
			Loop
		Endif
		
		If mv_par02 != "**" .And. mv_par02 != AH1->AH1_PERIOD
			dbSelectArea("AH1")
			dbSkip()
			Loop
		Endif
		
		cProduto   := AH1->AH1_PRODUT
		cTipCalcul := AH1->AH1_MOEDA
		cMdaRoy    := Str(AH1->AH1_MOEDRO,2)
		cMdaOri    := Iif(AH1->AH1_MOEDA == "1","1",SuperGetMv("MV_MCUSTO"))
		lSomaAdian := .T.
		nSomaAdian := 0
		
		dbSelectArea("AH4")
		dbSeek( xFilial("AH4") + cForneced + cProduto + Dtos(dPerFinal) )
		
		dbSelectArea("AH4")
		While AH4->AH4_FILIAL+AH4->AH4_FORNEC+AH4->AH4_LOJAFO+AH4->AH4_PRODUT==;
			xFilial("AH4") + cForneced + cProduto .And. !Eof() .And. ;
			AH4->AH4_DTPRES == dPerFinal
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se o usuario cancelou o relatorio.                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAbortPrint
				@Prow()+1,001 PSAY STR0011 //"CANCELADO PELO OPERADOR"
				Exit
			Endif
			
			cMdaOri := Iif(AH1->AH1_MOEDA == "1","1",SuperGetMv("MV_MCUSTO"))
			
			dbSelectArea("AH4")
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se o registro est  dentro do intervalo de datas.    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If AH4->AH4_DTPRES < dPerInici .Or. AH4->AH4_DTPRES > dPerFinal
				dbSelectArea("AH4")
				dbSkip()
				Loop
			Endif
			
			If lSomaAdian
				If AH4->AH4_VALADI > 0
					nSomaAdian := nSomaAdian + AH4->AH4_VALADI
					aTotFornec[5] := aTotFornec[5] + AH4->AH4_VALADI
					aTotFornec[4] := aTotFornec[4] + AH4->AH4_QTDADI
				Else
					nSomaAdian := nSomaAdian + AH1->AH1_SALDOA
					aTotFornec[5] := aTotFornec[5] + AH1->AH1_SALDOA
					aTotFornec[4] := aTotFornec[4] + AH4->AH4_QTDADI
				Endif
				lSomaAdian := .F.
			Endif

			nValDAIt:=0
			dbSelectArea("AH5")
			dbSeek( xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + Dtos(AH4->AH4_DATCAL) )
			While !Eof() .And. xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + ;
				Dtos(AH4->AH4_DATCAL) == AH5->AH5_FILIAL + AH5->AH5_PRODUT + ;
				AH5->AH5_FORNEC + AH5->AH5_LOJAFO + AH5->AH5_LICITA + Dtos(AH5->AH5_DATCAL)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Totalizacao.                                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				aTotFornec[1] := aTotFornec[1] + AH5->AH5_QTDACU
				
				If AH5->AH5_PERCDA != 0
					nValDAIt := nValDAit + xMoeda(AH5->AH5_VALORD,Val(cMdaOri),1,AH4->AH4_DATCAL)
				Else
					nValDAIt := nValDAIt + AH5->AH5_VALORD
				Endif
				
				dbSelectArea("AH5")
				dbSkip()
			End
			nValDAIt := Round(nValDAIt,2)
			If Empty(nSomaAdian)
				aTotFornec[2] := aTotFornec[2] + nValDAIt
			Else
				If nValDaIt > nSomaAdian
					aTotFornec[2] := aTotFornec[2] + (nValDAIt - nSomaAdian)
					aTotFornec[5] := 0
				Else                              
					aTotFornec[5] := aTotFornec[5] - nValDaIt
				Endif
			Endif
			dbSelectArea("AH4")
			dbSkip()
		End
		
		dbSelectArea("AH1")
		dbSkip()
	End
	
	*** imprime fornecedor
	If ((aTotFornec[1] + aTotFornec[2]) <> 0 .And. mv_par09 == 2) .Or. mv_par09 == 1
		dbSelectArea("SA2")
		dbSeek( xFilial() + cForneced )
		If SA2->A2_TIPO == "F"
			nValIRRF := CD040CalIR(aTotFornec[2], dPerFinal, .F.)
		Else
			nValIRRF := 0
		Endif
		If SA2->A2_TXTRIBU > 0 .And. aTotFornec[2] > 0
			nValIRRF := nValIRRF + Round(aTotFornec[2] * SA2->A2_TXTRIBU / 100,2)
		Endif
		
		aTotFornec[3] := nValIRRF
		
		If li > 56
			Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime fornecedor.                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("AH1")
		
		If (mv_par10 == 1 .And. (aTotFornec[4] > 0 .Or. aTotFornec[5] > 0)) .Or. (mv_par10 == 2 .And. aTotFornec[4] == 0 .And. aTotFornec[5] == 0) .Or. mv_par10 == 3
			@ li, 00 PSAY Left(cForneced,TAMSX3("AH1_FORNEC")[1]) + "-" + Right(cForneced,TAMSX3("AH1_LOJAFO")[1])
			@ li, 12 PSAY Substr(SA2->A2_NOME,1,40)
			@ li, 54 PSAY cTipCalcul
			@ li, 57 PSAY aTotFornec[1] Picture cPictqtd
			@ li, 73 PSAY aTotFornec[2] Picture cPictval
			@ li, 91 PSAY aTotFornec[3] Picture cPictval
			@ li,109 PSAY aTotFornec[4] Picture cPictqtd
			@ li,123 PSAY aTotFornec[5] Picture cPictval
			li++
		Endif
	Endif
	For nInd := 1 To 5
		aTotGeral[nInd] := aTotGeral[nInd] + aTotFornec[nInd]
	Next
End
If li != 80
	If li > 56
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
	Endif
	@ li, 00 PSAY Replicate("-",limite)
	li++
	If mv_par10 != 2 .Or. (mv_par10 == 2 .And. (aTotFornec[4] > 0 .Or. aTotFornec[5] > 0))
		@ li, 00 PSAY STR0016 //"Total Geral"
		@ li, 57 PSAY aTotGeral[1] Picture cPictqtd
		@ li, 73 PSAY aTotGeral[2] Picture cPictval
		@ li, 91 PSAY aTotGeral[3] Picture cPictval
		@ li,109 PSAY aTotGeral[4] Picture cPictqtd
		@ li,123 PSAY aTotGeral[5] Picture cPictval
	Endif
	
	li++
Endif

Return (.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CD015PSint³ Autor ³ Elizabeth A. Eguni    ³ Data ³ 11/11/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio sintetico por ordem de produto      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR015                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CD015PSint()
Local nInd := 0
Local nValDAIt := 0
Local NTAMDSCPRD := 19
Local cPictqtd := PesqPict("AH5","AH5_QTDACU")
Local cPictval := PesqPict("AH5","AH5_VALORD")

titulo := titulo + STR0033 //" - Produto (Sintetico)"
cabec1 := STR0073 //"Cod. Produto                   Descricao do Produto                          Calc  Qtde. Venda      Valor a Pagar  Mda  Qtde Adiant  Saldo Adiantament"
//         123456789012345 1234567890123456789012345678901234567890    x   999.999.999  99.999.999.999,99   12  999.999.999  99.999.999.999,99
//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
//                   1         2         3         4         5         6         7         8         9        10        11        12        13
cabec2 := ""

dPerInici := CTOD("01/" + StrZero(Month(Mv_Par01),2) + "/" + Str(Year(Mv_Par01)))
dPerFinal := LastDay(dPerInici)

dbSelectArea("AH4")
dbSetOrder(1)      // AH4_FILIAL + AH4_PRODUT + AH4_FORNEC + AH4_LOJAFO + Dtos(AH4_DATCAL)

dbSelectArea("AH5")
dbSetOrder(4)      // AH5_FILIAL+AH5_PRODUT+AH5_FORNEC+AH5_LOJAFO+AH5_LICITA+DTOS(AH5_DATCAL)+STR(AH5_FXFINA,9)

dbSelectArea("AH1")
dbSetOrder(1)      // AH1_FILIAL + AH1_PRODUT + AH1_FORNEC + AH1_LOJAFO
SetRegua( RecCount() )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ aTotGeral: . 1 - total geral de qtde. de venda                 ³
//³            . 2 - total geral de valor a pagar (dir.autoral)    ³
//³            . 3 - total geral de saldo em qtde de adiantamento  ³
//³            . 4 - total geral de saldo em valor de adiantamento ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTotGeral := { 0, 0, 0, 0 }
lFirst := .T.
dbSeek( xFilial("AH1") + mv_par05, .T. )
While AH1->AH1_PRODUT <= mv_par06 .And. !Eof()
	
	cProduto   := AH1->AH1_PRODUT
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ aTotProdut: . 1 - total por produto de qtde. de venda                 ³
	//³             . 2 - total por produto de valor a pagar (dir.autoral)    ³
	//³             . 3 - total por produto de saldo em qtde de adiantamento  ³
	//³             . 4 - total por produto de saldo em valor de adiantamento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aTotProdut := { 0, 0, 0, 0, 0 }
	aTotFornec := { 0, 0, 0, 0, 0 } 
	cTipCalcul := " "
	cMdaRoy    := "1"
	cMdaOri    := "1"
	
	While AH1->AH1_PRODUT == cProduto .And. !Eof()
		IncRegua()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o fornecedor est  dentro do intervalo.           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If AH1->AH1_FORNEC < mv_par03 .Or. AH1->AH1_FORNEC > mv_par04
			dbSelectArea("AH1")
			dbSkip()
			Loop
		Endif
		
		If mv_par02 != "**" .And. mv_par02 != AH1->AH1_PERIOD
			dbSelectArea("AH1")
			dbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o usuario cancelou o relatorio.                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
			@Prow()+1,001 PSAY STR0072 //"CANCELADO PELO OPERADOR"
			Exit
		Endif
		
		cForneced  := AH1->AH1_FORNEC + AH1->AH1_LOJAFO
		cTipCalcul := AH1->AH1_MOEDA
		cMdaRoy    := Str(AH1->AH1_MOEDROY,2)
		cMdaOri    := Iif(AH1->AH1_MOEDA == "1", "1", SuperGetMv("MV_MCUSTO"))
		lSomaAdian := .T.
		nSomaAdian := 0
		dbSelectArea("AH4")
		dbSeek( xFilial("AH4") + AH1->AH1_PRODUT + AH1->AH1_FORNEC + AH1->AH1_LOJAFO + Dtos(dPerFinal) )
		
		While AH4->AH4_FILIAL+AH4->AH4_PRODUT+AH4->AH4_FORNEC+AH4->AH4_LOJAFO==;
			xFilial("AH4") + cProduto + cForneced .And. !Eof() .And. ;
			AH4->AH4_DTPRES == dPerFinal
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se o usuario cancelou o relatorio.                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAbortPrint
				@Prow()+1,001 PSAY STR0072 //"CANCELADO PELO OPERADOR"
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
			
			dbSelectArea("SA2")
			dbSeek(xFilial("SA2") + AH4->AH4_FORNEC + AH4->AH4_LOJAFO)
			
			dbSelectArea("AH5")    
			dbSeek( xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + Dtos(AH4->AH4_DATCAL) )
			While !Eof() .And. xFilial("AH5") + AH4->AH4_PRODUT + cForneced + AH4->AH4_LICITA + ;
				Dtos(AH4->AH4_DATCAL) == AH5->AH5_FILIAL+AH5->AH5_PRODUT + ;
				AH5->AH5_FORNEC + AH5->AH5_LOJAFO + AH5->AH5_LICITA + Dtos(AH5->AH5_DATCAL)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Totalizacao.                                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				aTotProdut[1] := aTotProdut[1] + AH5->AH5_QTDACU
				nValDAIt      := nValDAIt      + AH5->AH5_VALORD
				dbSelectArea("AH5")
				dbSkip()
			End
			aTotProdut[3] := aTotProdut[3] + AH4->AH4_QTDADI
			aTotProdut[4] := aTotProdut[4] + AH4->AH4_VALADI
			nSomaAdian    := nSomaAdian    + AH4->AH4_VALADI
			
			If Empty(nSomaAdian)
				aTotFornec[2] := aTotFornec[2] + nValDAIt
			Else
				If nValDaIt > nSomaAdian
					aTotFornec[2] := aTotFornec[2] + (nValDAIt - nSomaAdian) 
				Else                              
					aTotFornec[5] := aTotFornec[5] - nValDaIt
				Endif
			Endif
			
			dbSelectArea("AH4")
			dbSkip()
		End
		
		dbSelectArea("AH1")
		dbSkip()
	End
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime produto.                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If ((aTotProdut[1] + aTotProdut[2]) <> 0 .And. mv_par09 == 2) .Or. mv_par09 == 1
		
		If li > 56
			Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
		Endif
		dbSelectArea("SB1")
		dbSeek( xFilial("SB1") + cProduto )
		dbSelectArea("AH4")
		@ li, 00 PSAY AllTrim(AH1->AH1_PRODUT)
		@ li, 31 PSAY "|" + Substr(SB1->B1_DESC,1,nTamDscPrd)
		@ li, nTamDscPrd+60 PSAY AH1->AH1_MOEDA   Picture "!"
		@ li, nTamDscPrd+64 PSAY aTotProdut[1]    Picture cPictqtd
		@ li, nTamDscPrd+77 PSAY aTotProdut[2]    Picture cPictval
		@ li, nTamDscPrd+97 PSAY AH1->AH1_MOEDRO  Picture "99"
		@ li, nTamDscPrd+101 PSAY aTotProdut[3]    Picture cPictqtd
		@ li, nTamDscPrd+114 PSAY aTotProdut[4]    Picture cPictval
		li++
	Endif
	
	For nInd := 1 To 4
		aTotGeral[nInd] := aTotGeral[nInd] + aTotProdut[nInd]
	Next
End
If li != 80
	If li > 56
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15,Nil,.T.)
	Endif
	@ li, 00 PSAY Replicate("-",limite)
	li++
	If mv_par10!=2 .Or. (mv_par10==2 .And. (aTotProdut[3]>0 .Or. aTotProdut[4]>0))
		@ li, 00 PSAY STR0016 //"Total Geral"
		@ li, 83 PSAY aTotGeral[1]  Picture cPictqtd
		@ li, 97 PSAY aTotGeral[2]  Picture cPictval
		@ li,108 PSAY aTotGeral[3]  Picture cPictqtd
		@ li,134 PSAY aTotGeral[4]  Picture cPictval
	Endif
	li++
Endif

Return (.T.)
