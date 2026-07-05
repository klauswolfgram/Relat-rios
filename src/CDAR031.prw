/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CDAR031.ch"
#include "rwmake.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CDAR031  ³ Autor ³ Sueli C. Santos       ³ Data ³ 22/01/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio periodico de Adiantamento.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CDAR031(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico - controle de royalty (direito autoral)         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CDAR031()

Local oReport

If FindFunction("TRepInUse") .And. TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := ReportDef()
	oReport:PrintDialog()
Else       
	Help("  ",1,"CDAR031TR4",,OEMTOANSI(STR0023),1,0) //"Função disponível apenas em TReport"
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ReportDef ³ Autor ³ Sueli C. Santos       ³ Data ³ 22/01/2008 ³±±
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
/*/
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                         ³
³ mv_par01    // periodo inicial                               ³
³ mv_par02    // Periodo Final                                 ³
³ mv_par03    // Fornecedor inicial                            ³
³ mv_par04    // Fornecedor final                              ³
³ mv_par05    // Produto inicial                               ³
³ mv_par06    // Produto final                                 ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*/

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

oReport := TReport():New("CDAR031",STR0002,"CDR031",{|oReport| ReportPrint(oReport)},STR0003) //"Relação de Adiantamentos"###"Emissão do relatório de Adiantamentos"
oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

pergunte("CDR031",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Sessao dos fornecedores                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oFornecedor := TRSection():New(oReport,STR0004,{"AH1","AH3","AH4","AH5","SA2"},{STR0005},/*Campos do SX3*/,/*Campos do SIX*/) //"Fornecedores"###"Fornecedor + Loja + Produto"
oFornecedor:SetTotalInLine(.F.)

TRCell():New(oFornecedor,"FORNEC"    ,     ,STR0006,/*Picture*/,TAMSX3("A2_COD")[1],/*lPixel*/,{|| cForneced  }) //"Fornecedor"
TRCell():New(oFornecedor,"NOME"      ,     ,STR0007,/*Picture*/,20,/*lPixel*/,{|| SA2->A2_NOME }) //"Nome do Fornecedor"
TRCell():New(oFornecedor,"AH1_SALDQT","AH1",STR0008,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| nAdiaQtde }) //"Adiantamento Quantidade"
TRCell():New(oFornecedor,"AH1_SALDOA","AH1",STR0009,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| nAdiaValor }) //"Adiantamento Valor"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Sessao dos produtos                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oProduto := TRSection():New(oReport,STR0010,{"AH1","AH3","AH4","AH5","SB1"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Produtos"
oProduto:SetTotalInLine(.F.)

TRCell():New(oProduto,"B1_COD"    ,"SB1",STR0011,/*Picture*/,/*nTamaho*/,/*lPixel*/,{|| cProduto } ) //"Produto"
TRCell():New(oProduto,"DESC"      ,     ,STR0012,/*Picture*/,20,/*lPixel*/,{|| SB1->B1_DESC }) //"Desc Prod"
TRCell():New(oProduto,"AH1_MOEDA" ,"AH1",STR0022,/*Picture*/,/*nTamaho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "C"
TRCell():New(oProduto,"AH1_MOEDRO","AH1",STR0013,/*Picture*/,/*nTamaho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Md"
TRCell():New(oProduto,"AH5_DTPRES","AH5",STR0014,/*Picture*/,/*nTamaho*/,/*lPixel*/,{|| dDtpres }) //"Data"
TRCell():New(oProduto,"QTDVENDA"  ,     ,STR0015,PesqPict("AH5","AH5_QTDACU"),TAMSX3("AH5_QTDACU")[1],/*lPixel*/,{|| nQtdVenda }) //"Qtd Ven"
TRCell():New(oProduto,"AH5_PRECOU","AH5",STR0016,/*Picture*/,/*nTamaho*/,/*lPixel*/, {|| nPreco }) //"Preço Produto"
TRCell():New(oProduto,"VALOR"     ,     ,STR0017,PesqPict("AH5","AH5_VALORD"),TAMSX3("AH5_VALORD")[1],/*lPixel*/,{|| nValorda }) //"Valor do D.A."
TRCell():New(oProduto,"AH1_VALADI","AH1",STR0018,/*Picture*/,/*nTamaho*/,/*lPixel*/,{|| nSubAdiant }) //"Valor Adian."
TRCell():New(oProduto,"AH1_SALDQT","AH1",STR0019,/*Picture*/,/*nTamaho*/,/*lPixel*/,{|| nSubAdQtd }) //"Sald Qt"
TRCell():New(oProduto,"AH1_SALDOA","AH1",STR0020,/*Picture*/,/*nTamaho*/,/*lPixel*/,{|| nSubAdVal }) //"Saldo Valor"
TRCell():New(oProduto,"MOEDA"     ,     ,STR0013,"@E 99",2,/*lPixel*/,{|| nMoedAdt }) //"Md"

oProduto:Cell("AH1_SALDOA"):SetAlign( "RIGH" )

Return(oReport)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Sueli C. Santos       ³ Data ³22/01/2008³±±
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

dPerInici := mv_par01
dPerFinal := mv_par02
aTabela   := CD040AbrIR()

//oFornecedor:Cell(19):Disable()

	oFornecedor:Cell("NOME"):SetSize(40)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Desabilitando celulas que nao serao impressas no modelo analitico |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oFornecedor:Cell("AH1_SALDQT"):Disable()
	oFornecedor:Cell("AH1_SALDOA"):Disable()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Totalizadores que serao impressos no modelo analitico   |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Totalizador por quebra de produto
	oProduto:SetTotalText(STR0001) //"Sub-Totais"
	TRFunction():New(oProduto:Cell("QTDVENDA"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
	TRFunction():New(oProduto:Cell("VALOR"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
	TRFunction():New(oProduto:Cell("AH1_SALDOA"),NIL,"ONPRINT",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.)
	
	//Totalizador por quebra de fornecedor
	oBreak := TRBreak():New(oFornecedor,oFornecedor:Cell("FORNEC"),STR0021,.F.) // "Total do Fornecedor"
	TRFunction():New(oProduto:Cell("QTDVENDA"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oProduto:Cell("VALOR"),NIL,"SUM",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	oTpAdiaPro := TRFunction():New(oProduto:Cell("AH1_SALDOA"),NIL,"ONPRINT",oBreak,,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	
	//Total Geral no final do relatorio
	oTGAdiaPro := TRFunction():New(oProduto:Cell("AH1_SALDOA"),NIL,"ONPRINT",/*oBreak*/,,/*cPicture*/,/*uFormula*/,.F.,.T.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
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
		  AH1_FORNEC >= %Exp:mv_par03% AND AH1_FORNEC <= %Exp:mv_par04% AND
		  AH1_PRODUT >= %Exp:mv_par05% AND AH1_PRODUT <= %Exp:mv_par06% AND
		  AH4_FILIAL = %xFilial:AH4% AND AH4.%NotDel% AND
		  AH4_DTPRES >= %Exp:dPerInici% AND AH4_DTPRES <= %Exp:dPerFinal% AND
		  AH5_FILIAL = %xFilial:AH5% AND AH5.%NotDel% AND
		  AH4_PRODUT = AH5_PRODUT AND AH4_FORNEC = AH5_FORNEC AND
		  AH4_LOJAFO = AH5_LOJAFO AND AH4_LICITA = AH5_LICITA AND AH4_DATCAL = AH5_DATCAL
	
	ORDER BY AH1_FILIAL,AH1_FORNEC,AH1_LOJAFO,AH1_PRODUT,AH4_FILIAL,AH4_FORNEC,AH4_LOJAFO,AH4_PRODUT
	
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
	
#ELSE
	
	lQuery    := .F.
	dbSelectArea(cAliasAH1)
	dbSetOrder(2)
	
	cCondicao := 'AH1_FILIAL == "'+xFilial("AH1")+'".And.'
	cCondicao += 'AH1_FORNEC >= "'+mv_par03+'".And.AH1_FORNEC <="'+mv_par04+'".And.'
	cCondicao += 'AH1_PRODUT >= "'+mv_par05+'".And.AH1_PRODUT <="'+mv_par06+'"
	
	oReport:Section(1):SetFilter(cCondicao,IndexKey())
	
#ENDIF

TRPosition():New(oFornecedor,"SA2",1,{|| xFilial("SA2")+cForneced })
TRPosition():New(oProduto,"SB1",1,{|| xFilial("SB1")+cProduto  })

oReport:SetMeter(AH1->(LastRec()))

dbSelectArea(cAliasAH1)
dbGotop()

oFornecedor:Init()

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
	nMoedAdt   := 0
	lImpProd := .T.
	
	While (cAliasAH1)->AH1_FORNEC+(cAliasAH1)->AH1_LOJAFO == cForneced .And. !(cAliasAH1)->(Eof())
		
		cProduto := (cAliasAH1)->AH1_PRODUT
		nAdiaValor := 0
		nAdiaQtde  := 0
		
		
		While (cAliasAH1)->AH1_FORNEC+(cAliasAH1)->AH1_LOJAFO == cForneced .And. ;
			  (cAliasAH1)->AH1_PRODUT == cProduto .And. !(cAliasAH1)->(Eof())
			
			nSubAdiant := 0
			nSubAdVal  := 0
			nSubTtQtde := 0
			nSubQtdVen := 0
			nSubQtdDev := 0
			nSubAdQtd  := (cAliasAH1)->AH1_SALDQT
			nSubTotDir := 0
			nSubTotPag := 0
			lSomaAdian := .T.
			nTotPagar  := 0.00
			lTemMov    := .F.
			lImpAdian  := .F.
			nMoedAdt := 0 
		
		dbSelectArea("AH3")
		dbSeek( xFilial() + (cAliasAH1)->AH1_PRODUT + (cAliasAH1)->AH1_FORNEC + (cAliasAH1)->AH1_LOJAFO )
		If AH3->(!Eof()) .And.( AH3->AH3_DATA >= dPerInici .And. AH3->AH3_DATA <= dPerFinal)

			If !lQuery                          		
				dbSelectArea(cAliasAH4)
				dbSetOrder(4) // AH4_FILIAL+AH4_FORNEC+AH4_LOJAFO+AH4_PRODUT+Dtos(AH4_DTPRES)
				dbSeek( xFilial("AH4") + cForneced + cProduto + Dtos(dPerFinal) )
				cCond := {|| xFilial(cAliasAH4) + cForneced + cProduto == (cAliasAH4)->AH4_FILIAL + (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO + (cAliasAH4)->AH4_PRODUT }
			Else
				cCond := {|| (cAliasAH1)->AH1_FORNEC + (cAliasAH1)->AH1_LOJAFO + (cAliasAH1)->AH1_PRODUT ==;
				             (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO + (cAliasAH4)->AH4_PRODUT }
			EndIf
			
			While Eval(cCond) .AND. (cAliasAH4)->(!Eof()) 
		
				lTemMov := .T.    
				lImpProd := .T.
				lImpAdian := .T.
				
				If !lQuery
					If AH4->AH4_DATCAL < dPerInici .Or. AH4->AH4_DATCAL > dPerFinal
						dbSelectArea((cAliasAH4))
						dbSkip()
						Loop
					Endif
				EndIf
				
				dbSelectArea("AH3")
				dbSeek( xFilial() + (cAliasAH4)->AH4_PRODUT + (cAliasAH4)->AH4_FORNEC + (cAliasAH4)->AH4_LOJAFO )
				While xFilial()+(cAliasAH4)->AH4_PRODUT+(cAliasAH4)->AH4_FORNEC+(cAliasAH4)->AH4_LOJAFO == ;
					AH3->AH3_FILIAL+AH3->AH3_PRODUT+AH3->AH3_FORNEC+AH3->AH3_LOJAFO
					
					nMoedAdt := Iif(Empty(nMoedAdt),AH3->AH3_MDATIT,nMoedAdt)
					dbSkip()
				End
				cMdaOri := Iif((cAliasAH1)->AH1_MOEDA == "1","1",GetMv("MV_MCUSTO"))   // 1=Corrente;2=Forte
				
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
					dDtpres   := Substr(Dtoc((cAliasAH5)->AH5_DTPRES),4,7)
					nQtdVenda := Iif((cAliasAH5)->AH5_QTDACU>0,(cAliasAH5)->AH5_QTDACU,0)
					nPreco    := (cAliasAH5)->AH5_PRECOU
					nQtdDev   := Iif((cAliasAH5)->AH5_QTDACU<0,(cAliasAH5)->AH5_QTDACU,0)
					nQtliq    := (cAliasAH5)->AH5_QTDACU
					nBaseda   := (cAliasAH5)->AH5_BASEDA
					nPercda   := (cAliasAH5)->AH5_PERCDA
					nValorda  := xMoeda((cAliasAH5)->AH5_VALORD,(cAliasAH1)->AH1_MOEDRO,1,(cAliasAH5)->AH5_DATCAL)
					

						If lImpFornec
							oFornecedor:PrintLine()
							lImpFornec := .F.
						EndIf

						If lImpProd
							oProduto:Cell("B1_COD"):Show()
							oProduto:Cell("DESC"):Show()
							oProduto:Cell("AH1_MOEDA"):Show()
							oProduto:Cell("AH1_MOEDRO"):Show()
							oProduto:Cell("MOEDA"):Show()
						Else
							oProduto:Cell("B1_COD"):Hide()
							oProduto:Cell("DESC"):Hide()
							oProduto:Cell("AH1_MOEDA"):Hide()
							oProduto:Cell("AH1_MOEDRO"):Hide()
							oProduto:Cell("MOEDA"):Hide()
						EndIf
						lImpProd := .F.
						oProduto:Init()	
						oProduto:PrintLine()
										
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
		Else
			lImpProd := .F.
		Endif	
			dbSelectArea(cAliasAH1)
			dbSkip()
			oReport:IncMeter()
		End
		If oProduto:Cell("AH1_SALDOA"):lEnabled 
			oTPAdiaPro:SetFormula(&("{||"+str(nSaldoAdia)+"}"))	
		EndIf
		If !lImpprod
			oProduto:Finish()
		ElseIf !lTemMov .and. (lImpFornec .or. lImpProd)
		
			If lImpFornec
				oFornecedor:PrintLine()
				lImpFornec := .F.
			EndIf
			If lImpProd
				oProduto:Cell("B1_COD"):Show()
				oProduto:Cell("DESC"):Show()
				oProduto:Cell("AH1_MOEDA"):Show()
				oProduto:Cell("AH1_MOEDRO"):Show()
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
	
	If oProduto:Cell("AH1_SALDOA"):lEnabled 
		nTGAdiant += nSaldoAdia
    	oTGAdiaPro:SetFormula(&("{||"+str(nTGAdiant)+"}"))	
	Else
		nAdiaValor += nSaldoAdia
		nAdiaQtde  += nQtdeAdia
	EndIf

	If (lTemmov .and. nTotQtdVda + nTotPagto <> 0.00 .and. lImpAdian) 

		If !lImpFornec
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao do total por fornecedor se for rel. analitico  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oFornecedor:SetTotalText(STR0021 + cForneced) // "Total do Fornecedor "
		
			oReport:SkipLine()
			nLinTot := oReport:nRow

			oReport:SkipLine()
 			
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao da linha se a escolha for rel. sintetico.  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If nSaldoAdia < 0.00
				nSaldoAdia := 0.00
			Endif
			nTotPagar := nTotPagto
			nSubAdVal := nSaldoAdia

			oFornecedor:PrintLine()

		EndIf
				
	EndIf			
	
End

Return
