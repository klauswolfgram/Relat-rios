/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR570.CH"
#Include "PROTHEUS.CH"

Static lPrintFinish

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR570  ³ Autor ³ Marco Bianchi         ³ Data ³ 22/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Estatistica de Venda por Real/Previsto                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR570()

Local oReport

If FindFunction("TRepInUse") .And. TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	U_MATR570R3()
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 22/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport              
Local oFatRp
Local cFilQbr 		:= "%%"
Local lLineBreak 	:= .T.    

Private cPerg  		:= "MTR570"

lPrintFinish := .F.


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
oReport := TReport():New("MATR570",STR0016,"MTR570", {|oReport| ReportPrint(oReport,cFilQbr)},STR0017 + " " + STR0018)	// "Faturamento Real/Previsto"###"Este relatorio ira emitir a relacao de Faturamento,"###"emitindo o Faturamento Previsto e o Real."
//oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
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
// Altera o Titulo do Relatorio de acordo com Moeda escolhida
oReport:SetTitle(oreport:Title() + " - " + GetMv("MV_MOEDA"+STR(MV_PAR10,1)) )		// "Faturamento Real/Previsto"

oFatRP := TRSection():New(oReport,STR0032,{"SB1","SD2"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,/*lHeaderBreak*/,/*lPageBreak*/,lLineBreak)	// "Faturamento Real/Previsto"
oFatRP:SetTotalInLine(.F.)
TRCell():New(oFatRP,"B1_FILIAL"	,"SB1"	,RetTitle("B1_FILIAL"	),PesqPict("SB1","B1_FILIAL"	),TamSX3("B1_FILIAL")[1],/*lPixel*/,{|| B1_FILIAL 				},/*cAlign*/,lLineBreak)
TRCell():New(oFatRP,"B1_COD"	,"SB1"	,RetTitle("B1_COD"		),PesqPict("SB1","B1_COD"		),TamSX3("B1_COD"	)[1],/*lPixel*/,{|| B1_COD 					},/*cAlign*/,lLineBreak)
TRCell():New(oFatRP,"B1_DESC"	,"SB1"	,RetTitle("B1_DESC"		),PesqPict("SB1","B1_DESC"		),TamSX3("B1_DESC"	)[1],/*lPixel*/,{|| B1_DESC					},/*cAlign*/,lLineBreak)
TRCell():New(oFatRP,"NAC1"		,		,STR0019				 ,PesqPict("SD2","D2_QUANT"		),TamSX3("D2_QUANT"	)[1],/*lPixel*/,{|| nAc1					},/*cAlign*/,lLineBreak)  // "Quant.Real"
TRCell():New(oFatRP,"NPRECOR"	,		,STR0020				 ,PesqPict("SD2","D2_TOTAL"		),TamSX3("D2_TOTAL"	)[1],/*lPixel*/,{|| nPrecoR					},/*cAlign*/,lLineBreak)  // "Preco Real"
TRCell():New(oFatRP,"NAC2"		,		,STR0021				 ,PesqPict("SD2","D2_TOTAL"		),TamSX3("D2_TOTAL"	)[1],/*lPixel*/,{|| nAc2					},/*cAlign*/,lLineBreak)  // "ToTal Real"
TRCell():New(oFatRP,"NAC3"		,		,STR0022				 ,PesqPict("SD2","D2_QUANT"		),TamSX3("D2_QUANT"	)[1],/*lPixel*/,{|| nAc3					},/*cAlign*/,lLineBreak)  // "Quant.Prev."
TRCell():New(oFatRP,"NAC43"		,		,STR0023				 ,PesqPict("SD2","D2_TOTAL"		),TamSX3("D2_TOTAL"	)[1],/*lPixel*/,{|| nAc4/nAc3				},/*cAlign*/,lLineBreak)  // "Preco Prev."
TRCell():New(oFatRP,"NAC4"		,		,STR0024				 ,PesqPict("SD2","D2_TOTAL"		),TamSX3("D2_TOTAL"	)[1],/*lPixel*/,{|| nAc4					},/*cAlign*/,lLineBreak)  // "ToTal Prev."
TRCell():New(oFatRP,"NAC13"		,		,STR0025				 ,PesqPict("SD2","D2_QUANT"		),TamSX3("D2_QUANT"	)[1],/*lPixel*/,{|| nAc1 - nAc3				},/*cAlign*/,lLineBreak)  // "Quant.Var."
TRCell():New(oFatRP,"NPRECOVAR"	,		,STR0026				 ,PesqPict("SD2","D2_TOTAL"		),TamSX3("D2_TOTAL"	)[1],/*lPixel*/,{||  nPrecoR-(nAc4/nAc3)	},/*cAlign*/,lLineBreak)  // "Preco Var."
TRCell():New(oFatRP,"NAC24"		,		,STR0027				 ,PesqPict("SD2","D2_TOTAL"		),TamSX3("D2_TOTAL"	)[1],/*lPixel*/,{||  nAc2 - nAc4			},/*cAlign*/,lLineBreak)  // "Valor Var."
                                
// Totalizador por Filial e Total Geral
TRFunction():New(oFatRP:Cell("NAC1"			),"NAC1"	,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/							,.T.				,.T./*lEndReport*/,	/*lEndPage*/	)
TRFunction():New(oFatRP:Cell("NPRECOR" 		),/* cID */	,"ONPRINT",/*oBreak*/,/*cTitle*/,/*cPicture*/,{ || QR570_1(oReport,cFilQbr,1) }	,.T./*lEndSection*/	,.T./*lEndReport*/,.F./*lEndPage*/	)
TRFunction():New(oFatRP:Cell("NAC2"			),"NAC2"	,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/							,.T.				,.T./*lEndReport*/,/*lEndPage*/		)

TRFunction():New(oFatRP:Cell("NAC3"			),"NAC3"	,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/							,.T.				,.T./*lEndReport*/,/*lEndPage*/		)
TRFunction():New(oFatRP:Cell("NAC43" 		),/* cID */	,"ONPRINT",/*oBreak*/,/*cTitle*/,/*cPicture*/,{ || QR570_1(oReport,cFilQbr,2) }	,.T./*lEndSection*/	,.T./*lEndReport*/,.F./*lEndPage*/	)
TRFunction():New(oFatRP:Cell("NAC4"			),"NAC4"	,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/							,.T.				,.T./*lEndReport*/,/*lEndPage*/		)

TRFunction():New(oFatRP:Cell("NAC13"		),"NAC13"	,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/							,.T.				,.T./*lEndReport*/,/*lEndPage*/		)
TRFunction():New(oFatRP:Cell("NPRECOVAR"	),/* cID */	,"ONPRINT",/*oBreak*/,/*cTitle*/,/*cPicture*/,{ || QR570_1(oReport,cFilQbr,3) }	,.T./*lEndSection*/	,.T./*lEndReport*/,.F./*lEndPage*/	)
TRFunction():New(oFatRP:Cell("NAC24"		),"NAC24"	,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/							,.T.				,.T./*lEndReport*/,/*lEndPage*/		)

// Esta Secao serve apenas para receber a Query das Devolucoes, pois como a query e executada varias vezes,
// com varios Alias diferentes, estes Alias nao sao reconhecidos pelo objeto oFatRP pois nao esta no array de tabelas
oTemp := TRSection():New(oReport,"",,,/*Campos do SX3*/,/*Campos do SIX*/)	// "Faturamento Real/Previsto"
oTemp:SetTotalInLine(.F.)

oReport:Section(2):SetEdit(.F.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 22/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cFilQbr)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nAg1		:= 0
Local nAg2		:= 0
Local nAg3		:= 0
Local nAg4		:= 0
Local nAg1Fil 	:= 0
Local nAg2Fil 	:= 0
Local nAg3Fil 	:= 0
Local nAg4Fil 	:= 0
Local nAgxFil 	:= 0
Local nAgyFil	:= 0
Local nDevolA	:= 0
Local nDevolB	:= 0
Local nLoop		:= 0
Local cIndex	:= ""
Local cCondicao := ""
Local nFrete	:= 0
Local nSeguro	:= 0
Local aAreaSM0	:= {}
Local cCodigo 	:= ""
Local aFiliais	:= {}
Local cFilAtu 	:= cFilAnt
Local nDecs		:= msdecimais(mv_par10) //numero de decimais da moeda selecionda
Local lValadi	:= cPaisLoc == "MEX" .AND. SD2->(FieldPos("D2_VALADI")) > 0 .AND. VALTYPE(MV_PAR14)=="N" .AND. MV_PAR14==1 //  Adiantamentos Mexico

Local cWhere    := ""	
Local cQryEst 	:= ""
Local cQryDupl 	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o array para todas as filiais desta empresa                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAreaSM0 := SM0->( GetArea() )
cCodigo  := SM0->M0_CODIGO

SM0->( dbSetOrder( 1 ) )
If SM0->( dbSeek( cCodigo ) )
	While !SM0->( Eof() ) .And. SM0->M0_CODIGO == cCodigo
		If FWGETCODFILIAL >= mv_par12 .And. FWGETCODFILIAL <= mv_par13
			aAdd( aFiliais, FWGETCODFILIAL )
		EndIf
		SM0->( dbSkip())
	EndDo
EndIf
RestArea( aAreaSM0 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abre tabelas e Indices a serem utilizadas                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SF1->(dbsetorder(1))		// Cabecalho da Nota de Entrada	: Filial,Documento,Serie,Fornecedor,Loja,Tipo
SD1->(dbSetOrder(2))		// Itens da Nota de Entrada		: Filial,Produto,Documento,Serie,Fornecedor,Loja
SD2->(dbSetOrder(1))		// Itens de Venda da NF			: Filial,Produto,Local,NumSeq
SF2->(dbSetOrder(1))		// Cabecalho da Nota de Saida	: Filial,Documento,Serie,Cliente,Loja


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Relatorio                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cQryEst	:= "%" + If( (MV_PAR08 == 1),"'S'",If( (MV_PAR08 == 2),"'N'","'S','N'" ) ) + "%"
cQryDupl:= "%" + If( (MV_PAR09 == 1),"'S'",If( (MV_PAR09 == 2),"'N'","'S','N'" ) ) + "%"

nAg1		:= 0
nAg2		:= 0
nAg3		:= 0
nAg4		:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

oReport:Section(1):Init()
oReport:SetMeter(RecCount())		// Total de Elementos da regua
For nLoop := 1 to Len( aFiliais )
	cFilAnt := aFiliais[nLoop]
	cFilQbr := aFiliais[nLoop]

	nAg1Fil := 0
	nAg2Fil := 0
	nAg3Fil := 0
	nAg4Fil := 0
	nAgxFil := 0
	nAgyFil	:= 0

	dbSelectArea("SB1")
	dbSetOrder(1)
	dbSeek(xFilial("SB1")+mv_par01,.T.)
	While !Eof() .And. B1_FILIAL==xFilial("SB1") .And. B1_COD <= mv_par02
		
		oReport:IncMeter()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se produto teve movimentacao no Periodo             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SD2")
		If dbSeek(xFilial("SD2")+SB1->B1_COD,.F.)
			dbSelectArea("SB1")
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Valida o produto conforme a mascara         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ValidMasc(SD2->D2_COD,MV_PAR07)
				dbSelectArea("SB1")
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Soma Valor do Faturamento do Produto (Realizado)             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nAc1:=0
				nAc2:=0
				nAc3:=0
				nAc4:=0
				
			
				cAliasSD2:=GetNextAlias()
				cWhere := "%"
				cWhere += " NOT ("+IsRemito(2,"D2_TIPODOC")+")"
				If MV_PAR11==2
					cWhere += " AND D2_TIPO <> 'D'"
				Endif
				cWhere += "%"
				
				oReport:Section(2):BeginQuery()
				
				If lValadi
					cExpTot := "% D2_TOTAL-D2_VALADI %"
				Else
					cExpTot := "% D2_TOTAL %"
				EndIf
				
				BeginSql Alias cAliasSD2
				
				SELECT Sum(D2_QUANT) nQuant,SUM(%Exp:cExpTot%) nTotal,sum(D2_VALICM) nICMS,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,F2_MOEDA,F2_EMISSAO,F2_VALMERC 
				FROM %Table:SD2% SD2, %Table:SF2% SF2
				WHERE D2_FILIAL = %xFilial:SF2% 
					AND D2_COD = %Exp:SB1->B1_COD%
					AND D2_EMISSAO >= %Exp:Dtos(MV_PAR03)% AND D2_EMISSAO <= %Exp:Dtos(MV_PAR04)%
					
					AND D2_TES IN (SELECT F4_CODIGO FROM %Table:SF4% SF4 
									WHERE F4_FILIAL = %xFilial:SF4%  
									AND   F4_DUPLIC IN (%Exp:cQryDupl%) 
									AND   F4_ESTOQUE IN (%Exp:cQryEst%))
					
				  	AND SD2.%notdel%
				   	AND %Exp:cWhere%
					AND F2_FILIAL  = %xFilial:SF2%
					AND F2_DOC     = D2_DOC 
					AND F2_SERIE   = D2_SERIE 
					AND F2_CLIENTE = D2_CLIENTE 
					AND F2_LOJA    = D2_LOJA 
					AND SF2.%notdel%

				GROUP BY D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,F2_MOEDA,F2_EMISSAO,F2_VALMERC
				EndSql					

				oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)
				
				
				While (cAliasSD2)->(!Eof())
					nAc1 += (cAliasSD2)->nQuant
					IF mv_par05 == 2
						nAc2 += xMoeda((cAliasSD2)->nTotal,SF2->F2_MOEDA,mv_par10,SF2->F2_EMISSAO,nDecs+1)
					Else
						IF (cAliasSD2)->F2_VALMERC != 0
							nAc2 += xMoeda(((cAliasSD2)->nTotal - (cAliasSD2)->nICMS),(cAliasSD2)->F2_MOEDA,MV_PAR10,(cAliasSD2)->F2_EMISSAO,nDecs+1)
						Endif
					Endif
					(cAliasSD2)->(DbSkip())
				Enddo
				(cAliasSD2)->(DbCloseArea())
				
								
				If mv_par06 == 1
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Soma Devolucoes          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nDevolA:=0
					nDevolB:=0

					cWhere := "% NOT ("+IsRemito(2,"D1_TIPODOC")+")%"

					cAliasSD1:=GetNextAlias()
					oReport:section(2):BeginQuery()
					BeginSql Alias cAliasSD1
					SELECT sum(D1_QUANT) nQuant,sum(D1_TOTAL) nTotal,sum(D1_VALICM) nICMS, sum(D1_VALDESC) nDesc,
					D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA,F1_MOEDA,F1_EMISSAO,F1_VALMERC 
					FROM %Table:SD1% SD1, %Table:SF1% SF1
					WHERE D1_FILIAL = %xFilial:SD1%
						AND D1_COD = %Exp:SB1->B1_COD%
						AND D1_DTDIGIT >= %Exp:Dtos(MV_PAR03)% AND D1_DTDIGIT <= %Exp:Dtos(MV_PAR04)%
						AND D1_TIPO = 'D'
						AND %Exp:cWhere%
						
						AND D1_TES IN (SELECT F4_CODIGO FROM %Table:SF4% SF4 
									WHERE F4_DUPLIC IN (%Exp:cQryDupl%) 
									AND   F4_ESTOQUE IN (%Exp:cQryEst%))
										  
						AND SD1.%notdel%
						AND F1_FILIAL 	= %xFilial:SF1%
						AND F1_DOC 		= D1_DOC 
						AND F1_SERIE 	= D1_SERIE 
						AND F1_FORNECE 	= D1_FORNECE 
						AND F1_LOJA		= D1_LOJA
						AND SF1.%notdel%
					GROUP BY D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA,F1_MOEDA,F1_EMISSAO,F1_VALMERC
					EndSql
					oReport:Section(2):EndQuery()

					While (cAliasSD1)->(!Eof())
						nDevolA += (cAliasSD1)->nQuant
						nDevolB += xMoeda(((cAliasSD1)->nTotal-(cAliasSD1)->nDesc)-(IIF(mv_par05=2,0,(cAliasSD1)->nICMS)),SF1->F1_MOEDA,MV_PAR10,SF1->F1_DTDIGIT,nDecs+1,SF1->F1_TXMOEDA)
						(cAliasSD1)->(DbSkip())
					Enddo
					(cAliasSD1)->(DbCloseArea())
					nAc1:= nAc1-nDevolA
					nAc2:= nAc2-nDevolB
					
				Endif
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Soma Valor do Previsto                                       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

				cAliasSC4 := GetNextAlias()
				oReport:Section(2):BeginQuery()
				BeginSql Alias cAliasSC4
				SELECT sum(C4_QUANT) nQuant,sum(C4_VALOR) nTotal,C4_DATA 
				FROM %Table:SC4% SC4
				WHERE C4_FILIAL = %xFilial:SC4%
					AND C4_PRODUTO = %Exp:SB1->B1_COD%
					AND C4_DATA >= %Exp:Dtos(MV_PAR03)%
					AND C4_DATA <= %Exp:Dtos(MV_PAR04)%
					AND SC4.%notdel%
				GROUP BY C4_DATA
				EndSql
				oReport:Section(2):EndQuery()
				
				While (cAliasSC4)->(!Eof())
					nAc3 += (cAliasSC4)->nQuant
					nAc4 += xMoeda((cAliasSC4)->nTotal,1,mv_par10,(cAliasSC4)->C4_DATA,nDecs+1)
					(cAliasSC4)->(DbSkip())
				Enddo
				(cAliasSC4)->(DbCloseArea())
				
				
				dbSelectArea("SB1")
				IF nAc1 != 0 .Or. nAc2 != 0 .Or. nAc3 != 0 .Or. nAc4 != 0
					
					nPrecoR := 0
					IF nAc1 != 0
						nPrecoR := nAc2/nAc1
					EndIF
					nPrecoP := 0
					IF B1_PRV1 != 0 .And. nAc3 != 0
						nPrecoP := xMoeda(B1_PRV1,1,mv_par10,SD1->D1_DTDIGIT,nDecs+1)
					EndIF
					
					oReport:Section(1):PrintLine()
					
					nAg1 += nAc1
					nAg2 += nAc2
					nAg3 += nAc3
					nAg4 += nAc4
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Acumula o total por filial                               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nAg1Fil += nAc1
					nAg2Fil += nPrecoR
					nAg3Fil += nAc2
					nAg4Fil += nAc3
					nAgxFil += nAc4/nAc3
					nAgyFil += nAc4
					
					

				EndIF
			EndIf
		EndIf
		dbSelectArea("SB1")
		dbSkip()
	EndDo
	
	If nAg1Fil != 0 .Or. nAg2Fil != 0 .Or. nAg3Fil != 0 .Or. nAg4Fil != 0
        

		// Forca impressao de uma linha em branco para quebra de filial, para que o totalizador da coluna
		// nPrecR seja calculado corretamente. Isso e necessario pois nao conseguimos saber se havera 
		// quebra de filial antes da impressao do ultimo printline de uma filial.
		nAc1		:= 0
		nPrecoR		:= 0
		nAc2		:= 0
		nAc3		:= 0
		nAc4		:= 0
		oReport:Section(1):Cell("B1_FILIAL"	):Hide()
		oReport:Section(1):Cell("B1_COD"	):Hide()
		oReport:Section(1):Cell("B1_DESC"	):Hide()
		oReport:Section(1):Cell("NAC1"		):Hide()
		oReport:Section(1):Cell("NPRECOR"	):Hide()
		oReport:Section(1):Cell("NAC2"		):Hide()
		oReport:Section(1):Cell("NAC3"		):Hide()
		oReport:Section(1):Cell("NAC43"		):Hide()
		oReport:Section(1):Cell("NAC4"		):Hide()
		oReport:Section(1):Cell("NAC13"		):Hide()
		oReport:Section(1):Cell("NPRECOVAR"	):Hide()
		oReport:Section(1):Cell("NAC24"		):Hide()
		cFilQbr := "XX"
		oReport:Section(1):PrintLine()
		
		// Total da Filial
		oReport:Section(1):SetTotalText(STR0028 + cFilAnt)		// "Total da Filial	 "
		oReport:Section(1):Finish()		
		
		oReport:Section(1):Init()
		oReport:Section(1):Cell("B1_FILIAL"):Show()
		oReport:Section(1):Cell("B1_COD"	):Show()
		oReport:Section(1):Cell("B1_DESC"	):Show()
		oReport:Section(1):Cell("NAC1"		):Show()
		oReport:Section(1):Cell("NPRECOR"	):Show()
		oReport:Section(1):Cell("NAC2"		):Show()
		oReport:Section(1):Cell("NAC3"		):Show()
		oReport:Section(1):Cell("NAC43"		):Show()
		oReport:Section(1):Cell("NAC4"		):Show()
		oReport:Section(1):Cell("NAC13"		):Show()
		oReport:Section(1):Cell("NPRECOVAR"	):Show()
		oReport:Section(1):Cell("NAC24"		):Show()
		
		
		IF nAg1Fil != 0
			nAg2Fil  := nAg3Fil/nAg1Fil
		EndIF
		
		IF nAg4Fil != 0
			nAgxFil  := nAgyFil/nAg4Fil
		EndIF
		
		nAg1Fil := 0
		nAg2Fil := 0
		nAg3Fil := 0
		nAg4Fil := 0
		nAgxFil := 0
		nAgyFil	:= 0
		
	EndIf
	
Next nLoop

IF nAg1 != 0
	nAgx  := nAg2/nAg1
EndIF

IF nAg3 != 0
	nAgy  := nAg4/nAg3
EndIF


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcula Frete e Seguro                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF2")
cIndex:=CriaTrab(NIL,.F.)
cCondicao:="F2_FILIAL=='"+xFilial("SF2")+"'.And.dtos(F2_EMISSAO)>='"+dtos(mv_par03)+"'"
cCondicao+=".And.dtos(F2_EMISSAO)<='"+dtos(mv_par04)+"'"
cCondicao+=".And. !("+IsRemito(2,'SF2->F2_TIPODOC')+")"
IndRegua("SF2",cIndex,IndexKey(),,cCondicao,STR0031) //"Selecionando registros ..."
dbGotop()
	
While !Eof()
	nFrete  +=xMoeda(F2_FRETE,SF2->F2_MOEDA,mv_par10,SF2->F2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)
	nSeguro +=xMoeda(F2_SEGURO,SF2->F2_MOEDA,mv_par10,SF2->F2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)
	dbSkip()
Enddo
	
dbSelectArea("SF2")
RetIndex()
Ferase(cIndex+OrdBagExt())
dbClearFilter()
dbSetOrder(1)
	
If nFrete != 0
	oReport:PrintText(STR0029 + " " + Transform(nFrete,PesqPict("SF2","F2_VALBRUT")),oReport:Row()+150,0)		// "Frete"
EndIf
	
If nSeguro != 0
	oReport:PrintText(STR0030 + Transform(nSeguro,PesqPict("SF2","F2_VALBRUT")),oReport:Row()+180,0)			// "Seguro"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura Areas                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SB1")
dbClearFilter()
dbSetOrder(1)
cFilAnt := cFilAtu

// Forca o calculo do total geral asntes de sua impressao
lPrintFinish := .T.
For nLoop := 1 To Len(oReport:aFunction)
	If Empty(oReport:aFunction[nLoop]:cName)
		oReport:aFunction[nLoop]:Execute()
	EndIf
Next nLoop

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR570R3³ Autor ³ Wagner Xavier         ³ Data ³ 16.04.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Decscri‡…o³ Estatistica de Venda por Real/Previsto                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR570(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Viviani       ³25/11/98³XXXXXX³Inclusao do mv_par10 e conversao dos    ³±±
±±³              ³        ³      ³valores pelo xMoeda                     ³±±
±±³ Edson   M.   ³30/03/99³XXXXXX³Passar o tamanho na SetPrint.           ³±±
±±³ J. Novaes    ³23/11/99³25234A³Ajuste de picture quant. prevista       ³±±
±±³ Marcello     ³26/08/00³oooooo³Impressao de casas decimais de acordo   ³±±
±±³              ³        ³      ³com a moeda selecionada.                ³±±
±±³ Iuspa        ³04/12/00³      ³Inclusao "Inclui Dev. Compra?" no SX1   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr570R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL CbTxt
LOCAL CbCont,cabec1,cabec2,wnrel
LOCAL titulo := OemToAnsi(STR0001)	//"Faturamento Real/Previsto"
LOCAL cDesc1 := OemToAnsi(STR0002)	//"Este relatorio ira emitir a relacao de Faturamento,"
LOCAL cDesc2 := OemToAnsi(STR0003)	//"emitindo o Faturamento Previsto e o Real."
LOCAL cDesc3 := ""
LOCAL tamanho:= "M"
LOCAL limite := 132
LOCAL cString:= "SB1"
LOCAL lContinua := .T.

PRIVATE aReturn := { STR0004, 1,STR0005, 2, 2, 1, "",1 }		//"Zebrado"###"Administracao"
PRIVATE nomeprog:= "MATR570"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   := "MTR570"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("MTR570",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ mv_par01        	// A partir do Produto                  ³
//³ mv_par02        	// Ate o Produto                        ³
//³ mv_par03        	// A partir da data                     ³
//³ mv_par04        	// Ate a data                           ³
//³ mv_par05        	// deduz ICMS do valor da venda         ³
//³ mv_par06         // Inclui Devolucao		                ³
//³ mv_par07         // Mascara                                 ³
//³ mv_par08      Tes Qto Estoque  Mov. X Nao Mov. X Ambas      ³
//³ mv_par09      Tes Qto Duplicata Gera X Nao Gera X Ambas     ³
//³ mv_par10         // Qual moeda                              ³
//³ mv_par11         // Inclui Devolucao Compra?                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
mv_par12 := If(Empty(mv_par12),cFilAnt,mv_par12)
mv_par13 := If(Empty(mv_par13),cFilAnt,mv_par13)
If cPaisLoc <> "BRA"
	mv_par05:=2
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao do cabecalho e tipo de impressao do relatorio      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := STR0006+iif(mv_par05==1,STR0007,"")+ " - " + GetMv("MV_MOEDA"+STR(MV_PAR10,1)) //"FATURAMENTO REAL x PREVISTO"###" (Deduz.ICM) - MOEDA"
cabec1 := STR0008	// "FIL CODIGO          DENOMINACAO       REAL         QUANT          PRECO       T O T A L                   V A R I A C A O"
cabec2 := STR0009	// "                                      PREVISTO                                                 QUANT          PRECO          VALOR"
//         				xx     xxxxxxxxxxxxxxx XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 999999999,99 99999999999,99 999999999999,99 999999999,99 99999999999,99 99999999999,99
//         				0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//          			0         1         2         3         4         5         6         7         8         9         0         1         2         3
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MATR570"

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey==27
	dbClearFilter()
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey==27
	dbClearFilter()
	Return
Endif

RptStatus({|lEnd| C570Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C570IMP  ³ Autor ³ Rosane Luciane Chene  ³ Data ³ 09.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR570			                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C570Imp(lEnd,WnRel,cString)

LOCAL nAc1,nAc2,nAc3,nAg1,nAg2,nAg3,nAg4,cChave,nAgx,nAgy,nAc4,nDevolA,nDevolB
LOCAL CbCont,cabec1,cabec2
LOCAL titulo := OemToAnsi(STR0001)	//"Faturamento Real/Previsto"
LOCAL tamanho:= "M"
LOCAL lContinua := .T.
Local nTipo:=0
Local cEstoq := If( (MV_PAR08 == 1),"S",If( (MV_PAR08 == 2),"N","SN" ) )
Local cDupli := If( (MV_PAR09 == 1),"S",If( (MV_PAR09 == 2),"N","SN" ) )
Local nFrete:=0,nSeguro:=0
Local aAreaSM0:= {}
Local cCodigo := ""
Local aFiliais:= {}
Local cFilAtu := cFilAnt
LOCAL nAg1Fil := 0,nAg2Fil := 0,nAg3Fil := 0,	nAg4Fil := 0, nAgxFil := 0,	nAgyFil:= 0
Local nPrecoP := 0
Local nLoop
Local nTamFil  := TamSX3("B1_FILIAL")[1]
Local nTamCod  := TamSX3("B1_COD")[1]
Local lValadi  := cPaisLoc == "MEX" .AND. SD2->(FieldPos("D2_VALADI")) > 0 .AND. VALTYPE(MV_PAR14)=="N" .AND. MV_PAR14==1 //  Adiantamentos Mexico

Private nDecs:=msdecimais(mv_par10) //numero de decimais da moeda selecionda
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o array para todas as filiais desta empresa                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAreaSM0 := SM0->( GetArea() )
cCodigo  := SM0->M0_CODIGO

SM0->( dbSetOrder( 1 ) )
If SM0->( dbSeek( cCodigo ) )
	While !SM0->( Eof() ) .And. SM0->M0_CODIGO == cCodigo
		If FWGETCODFILIAL >= mv_par12 .And. FWGETCODFILIAL <= mv_par13
			aAdd( aFiliais, FWGETCODFILIAL )
		EndIf
		SM0->( dbSkip())
	EndDo
EndIf
RestArea( aAreaSM0 )

SF1->(dbsetorder(1))

nTipo:=IIF(aReturn[4]==1,GetMV("MV_COMP"),GetMV("MV_NORM"))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt  := SPACE(10)
cbcont := 00
li     := 80
m_pag  := 01

titulo := STR0006+iif(mv_par05==1,STR0007,"") + " - " + GetMv("MV_MOEDA" + STR(mv_par10,1))	//"FATURAMENTO REAL x PREVISTO"###" (Deduz.ICM)"
cabec1 := STR0008		//"CODIGO          D E N O M I N A C A O    REAL      QUANT         PRECO        T O T A L               V A R I A C A O"
cabec2 := STR0009		//"                                         PREVISTO                                            QUANT         PRECO           VALOR"

dbSelectArea("SD1")
dbSetOrder(2)

dbSelectArea("SD2")
dbSetOrder(1)

dbSelectArea("SF2")
dbSetOrder(1)

nAg1:=0
nAg2:=0
nAg3:=0
nAg4:=0

SetRegua(RecCount())		// Total de Elementos da regua

For nLoop := 1 to Len( aFiliais )
	cFilAnt := aFiliais[nLoop]

	nAg1Fil := 0
	nAg2Fil := 0
	nAg3Fil := 0
	nAg4Fil := 0
	nAgxFil := 0
	nAgyFil	:= 0

	dbSelectArea("SB1")
	dbSetOrder(1)
	dbSeek(xFilial("SB1")+mv_par01,.T.)

	While !Eof().And. B1_FILIAL==xFilial("SB1") .And. B1_COD<=mv_par02
		
		IF lEnd
			@Prow()+1,001 Psay STR0010		//"CANCELADO PELO OPERADOR"
			lContinua := .F.
			Exit
		Endif
		
		IncRegua()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se produto teve movimentacao no Periodo             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SD2")
		If dbSeek(xFilial("SD2")+SB1->B1_COD,.F.)
			dbSelectArea("SB1")
			
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Valida o produto conforme a mascara         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ValidMasc(SD2->D2_COD,MV_PAR07)
				dbSelectArea("SB1")
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Soma Valor do Faturamento do Produto (Realizado)             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nAc1:=0
				nAc2:=0
				nAc3:=0
				nAc4:=0
				
				cAliasSD2:=GetNextAlias()
				cQuery:="select sum(D2_QUANT) nQuant,sum(D2_TOTAL"+Iif(lValadi,"-D2_VALADI","")+") nTotal,sum(D2_VALICM) nICMS,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,F2_MOEDA,F2_EMISSAO,F2_VALMERC from "+RetSqlName("SD2")+"  "+cAliasSD2+", "+RetSqlName("SF2")+" SF2  "
				//filial
				cQuery+="where D2_FILIAL='"+xFilial("SD2")+"' "
				//codigo do produto
				cQuery+="and D2_COD='"+SB1->B1_COD+"' "
				//periodo
				cQuery+="and D2_EMISSAO>='"+Dtos(MV_PAR03)+"' and D2_EMISSAO<='"+Dtos(MV_PAR04)+"' "
				//tipo de devolucao
				
				If MV_PAR11==2
					cQuery+="and D2_TIPO<>'D' "
				Endif
				
				//documento
				cQuery+="and not ("+IsRemito(2,"D2_TIPODOC")+") "
				//tes
				cQuery+="and D2_TES in (select F4_CODIGO from "+RetSqlName("SF4")+" where F4_FILIAL='"+xFilial("SF4")+"' AND F4_DUPLIC in ("+If(mv_par09==1,"'S'",If(mv_par09==2,"'N'","'S','N'"))+") and F4_ESTOQUE in ("+If(mv_par08==1,"'S'",If(mv_par08==2,"'N'","'S','N'"))+")) "
				cQuery+="and "+cAliasSD2+".D_E_L_E_T_='' "
				cQuery+="and F2_FILIAL='"+xFilial("SF2")+"' and F2_DOC=D2_DOC and F2_SERIE=D2_SERIE and F2_CLIENTE=D2_CLIENTE and F2_LOJA=D2_LOJA "
				cQuery+="AND SF2.D_E_L_E_T_=' ' "
				cQuery+="group by D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,F2_MOEDA,F2_EMISSAO,F2_VALMERC"
				cQuery:=ChangeQuery(cQuery)
				dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasSD2,.F.,.T.)
				
				While (cAliasSD2)->(!Eof())
					nAc1 += (cAliasSD2)->nQuant
					IF mv_par05 == 2
						nAc2 += xMoeda((cAliasSD2)->nTotal,SF2->F2_MOEDA,mv_par10,SF2->F2_EMISSAO,nDecs+1)
					Else
						IF (cAliasSD2)->F2_VALMERC != 0
							nAc2 += xMoeda(((cAliasSD2)->nTotal - (cAliasSD2)->nICMS),(cAliasSD2)->F2_MOEDA,MV_PAR10,(cAliasSD2)->F2_EMISSAO,nDecs+1)
						Endif
					Endif
					(cAliasSD2)->(DbSkip())
				Enddo
				(cAliasSD2)->(DbCloseArea())
				
				If mv_par06 == 1
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Soma Devolucoes          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nDevolA:=0
					nDevolB:=0

					cAliasSD1:=GetNextAlias()
					cQuery:="select sum(D1_QUANT) nQuant,sum(D1_TOTAL) nTotal,sum(D1_VALICM) nICMS, sum(D1_VALDESC) nDesc, D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA,F1_MOEDA,F1_EMISSAO,F1_VALMERC from "+RetSqlName("SD1")+" "+cAliasSD1+", "+RetSqlName("SF1")+" SF1  "
					//filial
					cQuery+="where D1_FILIAL='"+xFilial("SD1")+"' "
					//codigo do produto
					cQuery+="and D1_COD='"+SB1->B1_COD+"' "
					//periodo
					cQuery+="and D1_DTDIGIT>='"+Dtos(MV_PAR03)+"' and D1_DTDIGIT<='"+Dtos(MV_PAR04)+"' "
					//tipo
					cQuery+="and D1_TIPO='D' "
					//documento
					cQuery+="and not ("+IsRemito(2,"D1_TIPODOC")+") "
					//tes
					cQuery+="and D1_TES in (select F4_CODIGO from "+RetSqlName("SF4")+" where F4_DUPLIC in ("+If(mv_par09==1,"'S'",If(mv_par09==2,"'N'","'S','N'"))+") and F4_ESTOQUE in ("+If(mv_par08==1,"'S'",If(mv_par08==2,"'N'","'S','N'"))+")) "
					cQuery+="and "+cAliasSD1+".D_E_L_E_T_='' "
					cQuery+="and F1_FILIAL='"+xFilial("SF1")+"' and F1_DOC=D1_DOC and F1_SERIE=D1_SERIE and F1_FORNECE=D1_FORNECE and F1_LOJA=D1_LOJA "
					cQuery+="AND SF1.D_E_L_E_T_=' ' "						
					cQuery+="group by D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA,F1_MOEDA,F1_EMISSAO,F1_VALMERC"
					cQuery:=ChangeQuery(cQuery)
					dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasSD1,.F.,.T.)
					
					While (cAliasSD1)->(!Eof())
						nDevolA += (cAliasSD1)->nQuant
						nDevolB += xMoeda(((cAliasSD1)->nTotal-(cAliasSD1)->nDesc)-(IIF(mv_par05=2,0,(cAliasSD1)->nICMS)),SF1->F1_MOEDA,MV_PAR10,SF1->F1_DTDIGIT,nDecs+1,SF1->F1_TXMOEDA)
						(cAliasSD1)->(DbSkip())
					Enddo
					(cAliasSD1)->(DbCloseArea())
					nAc1:= nAc1-nDevolA
					nAc2:= nAc2-nDevolB
						
				Endif
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Soma Valor do Previsto                                       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				
				cAliasSC4:=GetNextAlias()
				cQuery:="select sum(C4_QUANT) nQuant,sum(C4_VALOR) nTotal,C4_DATA from "+RetSqlName("SC4")+" SC4 "
				//filial
				cQuery+="where C4_FILIAL='"+xFilial("SC4")+"' "
				//codigo do produto
				cQuery+="and C4_PRODUTO='"+SB1->B1_COD+"' "
				//periodo
				cQuery+="and C4_DATA>='"+Dtos(MV_PAR03)+"' and C4_DATA<='"+Dtos(MV_PAR04)+"' "
				cQuery+="AND SC4.D_E_L_E_T_=' ' "					
				cQuery+="group by C4_DATA"
				cQuery:=ChangeQuery(cQuery)
				dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasSC4,.F.,.T.)
				TCSetField(cAliasSC4,"C4_DATA","D",8,0)
				
				While (cAliasSC4)->(!Eof())
					nAc3 += (cAliasSC4)->nQuant
					nAc4 += xMoeda((cAliasSC4)->nTotal,1,mv_par10,(cAliasSC4)->C4_DATA,nDecs+1)
					(cAliasSC4)->(DbSkip())
				Enddo
				(cAliasSC4)->(DbCloseArea())
				
				dbSelectArea("SB1")
				
				IF nAc1 != 0 .Or. nAc2 != 0 .Or. nAc3 != 0 .Or. nAc4 != 0
					
					IF li > 55
						cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
					EndIF
					
					nPrecoR := 0
					
					IF nAc1 != 0
						nPrecoR := nAc2/nAc1
					EndIF
					
					nPrecoP := 0
					
					IF B1_PRV1 != 0 .And. nAc3 != 0
						nPrecoP := xMoeda(B1_PRV1,1,mv_par10,SD1->D1_DTDIGIT,nDecs+1)
					EndIF
					
					Li++
					
					If nTamFil == 2
					
						@li,  0 Psay B1_FILIAL                      && 02 CAMPOS
						@li,  4 Psay B1_COD                         && 15 CAMPOS
						@li, 20 Psay Substr(B1_DESC,1,19)           && 19 CAMPOS
						@li, 42 Psay nAc1     Picture PesqPict("SD2","D2_QUANT",14)
						@li, 58 Psay nPrecoR  PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
						@li, 72 Psay nAc2     PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
						li++
						@li, 42 Psay nAc3	   				PicTure PesqPict("SC4","C4_QUANT",14)
						@li, 56 Psay nAc4/nAc3 				PicTure PesqPict("SC4","C4_VALOR",14,mv_par10)
						@li, 70 Psay nAc4      				PicTure PesqPict("SC4","C4_VALOR",14,mv_par10)
						@li, 85 Psay nAc1-nAc3 				PicTure PesqPict("SD2","D2_QUANT",14)
						@li,100 Psay nPrecoR-(nAc4/nAc3)  	PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
						@li,115 Psay nAc2-nAc4             	PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
					Else 
						@li,  0			 	  Psay B1_FILIAL                     && 02 CAMPOS
						@li, nTamFil	 	  Psay B1_COD                        && 15 CAMPOS
						@li, nTamCod+9	 	  Psay Substr(B1_DESC,1,8)          && 08 CAMPOS
						@li, 42 Psay nAc1     Picture PesqPict("SD2","D2_QUANT",14)
						@li, 58 Psay nPrecoR  PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
						@li, 72 Psay nAc2     PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
						li++
						@li, 42 Psay nAc3	   				PicTure PesqPict("SC4","C4_QUANT",14)
						@li, 56 Psay nAc4/nAc3 				PicTure PesqPict("SC4","C4_VALOR",14,mv_par10)
						@li, 70 Psay nAc4      				PicTure PesqPict("SC4","C4_VALOR",14,mv_par10)
						@li, 85 Psay nAc1-nAc3 				PicTure PesqPict("SD2","D2_QUANT",14)
						@li,100 Psay nPrecoR-(nAc4/nAc3)  	PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
						@li,115 Psay nAc2-nAc4             	PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10) 
					EndIf
						
					nAg1 += nAc1
					nAg2 += nAc2
					nAg3 += nAc3
					nAg4 += nAc4
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Acumula o total por filial                               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nAg1Fil += nAc1
					nAg2Fil += nPrecoR
					nAg3Fil += nAc2
					nAg4Fil += nAc3
					nAgxFil += nAc4/nAc3
					nAgyFil += nAc4
					li++
				EndIF
			EndIf
		EndIf
		dbSelectArea("SB1")
		dbSkip()
	EndDo
	If nAg1Fil != 0 .Or. nAg2Fil != 0 .Or. nAg3Fil != 0 .Or. nAg4Fil != 0
		LI+=2
		If li > 55
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		EndIf
		@li, 03 Psay STR0015+" "+cFilAnt+" --->"//"TOTAL DA FILIAL - "
		
		
		IF nAg1Fil != 0
			nAg2Fil  := nAg3Fil/nAg1Fil
		EndIF
		
		IF nAg4Fil != 0
			nAgxFil  := nAgyFil/nAg4Fil
		EndIF
		
		
		@li, 42 Psay nAg1Fil	 PICTURE PesqPict("SD2","D2_QUANT",14)
		@li, 58 Psay nAg2Fil     PICTURE PesqPict("SD2","D2_TOTAL",14,mv_par10)
		@li, 72 Psay nAg3Fil     PICTURE PesqPict("SD2","D2_TOTAL",14,mv_par10)
		li++
		@li , 42 Psay nAg4Fil PICTURE PesqPict("SC4","C4_QUANT",14)
		@li , 56 Psay nAgxFil PICTURE PesqPict("SC4","C4_VALOR",14,mv_par10)
		@Li , 70 Psay nAgyFil PICTURE PesqPict("SD2","D2_TOTAL",14,mv_par10)
		
		@Li , 85 Psay  nAg1Fil-nAg4Fil PICTURE PesqPict("SD2","D2_QUANT",14)
		@Li , 100 Psay nAg2Fil-(nAgyFil/nAg4Fil)PICTURE PesqPict("SC4","C4_VALOR",14,mv_par10)
		@Li , 115 Psay nAg3Fil-nAgyFil PICTURE PesqPict("SD2","D2_TOTAL",14,mv_par10)
		
		LI++
		nAg1Fil := 0
		nAg2Fil := 0
		nAg3Fil := 0
		nAg4Fil := 0
		nAgxFil := 0
		nAgyFil	:= 0
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ocorreu quebra por Filial                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Next nLoop

IF li != 80
	nAgy:=0
	nAgx:=0
	
	li++
	@li,  03 Psay STR0011		//"T O T A L ---> "
	
	IF nAg1 != 0
		nAgx  := nAg2/nAg1
	EndIF
	
	IF nAg3 != 0
		nAgy  := nAg4/nAg3
	EndIF
	
	@li, 42 Psay nAg1	        PicTure PesqPict("SD2","D2_QUANT",14)
	@li, 58 Psay nAgx          PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
	@li, 72 Psay nAg2          PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
	li++
	@li, 42 Psay nAg3	       PicTure PesqPict("SC4","C4_QUANT",14)
	@li, 56 Psay nAgy         PicTure PesqPict("SC4","C4_VALOR",14,mv_par10)
	@li, 70 Psay nAg4         PicTure PesqPict("SC4","C4_VALOR",14,mv_par10)
	@li, 85 Psay nAg1-nAg3	   PicTure PesqPict("SD2","D2_QUANT",14)
	@li,100 Psay nAgx-nAgy    PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
	@li,115 Psay nAg2-nAg4    PicTure PesqPict("SD2","D2_TOTAL",14,mv_par10)
	
	dbSelectArea("SF2")
	cIndex:=CriaTrab(NIL,.F.)
	cFiltro:="F2_FILIAL=='"+xFilial("SF2")+"'.And.dtos(F2_EMISSAO)>='"+dtos(mv_par03)+"'"
	cFiltro+=".And.dtos(F2_EMISSAO)<='"+dtos(mv_par04)+"'"
	cFiltro+=".And. !("+IsRemito(2,'SF2->F2_TIPODOC')+")"
	
	IndRegua("SF2",cIndex,IndexKey(),,cFiltro,STR0014) //"Selecionando registros ..."
	dbGotop()
	
	While !Eof()
		nFrete  +=xMoeda(F2_FRETE,SF2->F2_MOEDA,mv_par10,SF2->F2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)
		nSeguro +=xMoeda(F2_SEGURO,SF2->F2_MOEDA,mv_par10,SF2->F2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)
		dbSkip()
	Enddo
	
	dbSelectArea("SF2")
	RetIndex()
	Ferase(cIndex+OrdBagExt())
	dbClearFilter()
	dbSetOrder(1)
	
	If nFrete != 0
		li+=2
		@li,  1 Psay STR0012		//"FRETE : "
		@li, 10 Psay nFrete             PicTure PesqPict("SF2","F2_FRETE",15,mv_par10)
	EndIf
	
	If nSeguro != 0
		li++
		@li,  1 Psay STR0013		//"SEGURO : "
		@li, 10 Psay nSeguro            PicTure PesqPict("SF2","F2_SEGURO",15,mv_par10)
	EndIf
	
	roda(cbcont,cbtxt)
	
EndIf

dbSelectArea("SB1")
dbClearFilter()
dbSetOrder(1)
cFilAnt := cFilAtu

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif
MS_FLUSH()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³QR570_1	³ Autor ³Marco Bianchi          ³ Data ³ 22/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Controla o totalizador do Preco Real                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³ExpC1: Quebra do totalizador                                ³±±
±±³          ³ExpL1: Zera variaveis                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ MATR570                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QR570_1(oReport,cFilQbr,nCol)

Local   nValor   	:= 0   
           
If cFilAnt <> cFilQbr  
	If nCol == 1
		If lPrintFinish
			nValor := oReport:Section(1):GetFunction("NAC2"):ReportValue() / oReport:Section(1):GetFunction("NAC1"):ReportValue()
		Else
			nValor := oReport:Section(1):GetFunction("NAC2"):SectionValue() / oReport:Section(1):GetFunction("NAC1"):SectionValue()
		EndIf
	ElseIf nCol == 2	
		If lPrintFinish
			nValor := oReport:Section(1):GetFunction("NAC4"):ReportValue() / oReport:Section(1):GetFunction("NAC3"):ReportValue()
		Else
			nValor := oReport:Section(1):GetFunction("NAC4"):SectionValue() / oReport:Section(1):GetFunction("NAC3"):SectionValue()
		EndIf
	Else
		If lPrintFinish
			nValor := (oReport:Section(1):GetFunction("NAC2"):ReportValue() / oReport:Section(1):GetFunction("NAC1"):ReportValue());
					- (oReport:Section(1):GetFunction("NAC4"):ReportValue() / oReport:Section(1):GetFunction("NAC3"):ReportValue())
		Else
			nValor := (oReport:Section(1):GetFunction("NAC2"):SectionValue() / oReport:Section(1):GetFunction("NAC1"):SectionValue());
					- (oReport:Section(1):GetFunction("NAC4"):SectionValue() / oReport:Section(1):GetFunction("NAC3"):SectionValue())
		EndIF
	EndIf	
EndIf

Return nValor