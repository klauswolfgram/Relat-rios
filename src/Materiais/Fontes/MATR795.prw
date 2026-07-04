/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR795.CH"  
#Include "FIVEWIN.Ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR795  ³ Autor ³ Marco Bianchi         ³ Data ³ 25/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Quantidades em Grades (Release 4).            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR795()

Local oReport

If FindFunction("TRepInUse") .And. TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	U_MATR795R3()
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ MArco Bianchi         ³ Data ³ 25/07/06 ³±±
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
Local oColuna
Local oLinha
Local oRefer
Local oTotal
Local cLinha 		:= ""
Local cLinhaDesc	:= ""
Local nQtdEnt	 	:= 0
Local nQtdEmp 		:= 0
Local nQtdTot 		:= 0
Local cAliasSB4 := GetNextAlias()

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
oReport := TReport():New("MATR795",STR0017,"MTR795", {|oReport| ReportPrint(oReport,cAliasSB4,oColuna,oLinha,oRefer,oTotal)},STR0018 + " " + STR0019)	// "QUANTIDADES EM GRADES - "###"Emissäo do Relatorio de Quantidades em Grades dos Pedidos de Vendas"###"atraves de intervalo de Pedidos informado na opçäo Parâmetros."
oReport:SetPortrait() 
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        		   ³
//³ mv_par01	     	  Do Pedido                             		   ³
//³ mv_par02	     	  Ate o Pedido                          		   ³
//³ mv_par03	     	  Do Produto                            		   ³
//³ mv_par04	     	  Ate o Produto                         		   ³
//³ mv_par05	     	  Da Data Emissao                       		   ³
//³ mv_par06	     	  Ate a Data Emissao                    		   ³
//³ mv_par07	     	  Do Cliente                            		   ³
//³ mv_par08	     	  Ate o Cliente                         		   ³
//³ mv_par09	     	  Analitico/Sintetico/Resumido          		   ³
//³ mv_par10	     	  Mascara do Produto                    		   ³
//³ mv_par11	     	  Codigo de Referencia Produto de       		   ³
//³ mv_par12	     	  Codigo de Referencia do Produto ate   		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 1 - Referencia (11 primeiras posicoes do produto)      		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oRefer := TRSection():New(oReport,STR0034,{"SB4","SBV","SC6","SC5"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "QUANTIDADES EM GRADES - "
oRefer:SetTotalInLine(.F.)
TRCell():New(oRefer,"B4_COD	"	,/*Tabela*/,STR0026				,PesqPict("SB4","B4_COD")	,TamSx3("B4_COD"	)[1],/*lPixel*/,{|| (cAliasSB4)->B4_COD	})	// "Referencia"
TRCell():New(oRefer,"B4_DESC"	,/*Tabela*/,RetTitle("B4_DESC")	,PesqPict("SB4","B4_DESC")	,TamSx3("B4_DESC"	)[1],/*lPixel*/,{|| (cAliasSB4)->B4_DESC	})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 1.1 - Linhas da Grade                                   		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oLinha := TRSection():New(oRefer,STR0035,{"SB4","SBV","SC6","SC5"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "QUANTIDADES EM GRADES - "
oLinha:SetTotalInLine(.F.)
TRCell():New(oLinha,"CLINHA"		,/*Tabela*/	,STR0025				,PesqPict("SBV","BV_CHAVE"	),TamSx3("BV_CHAVE"		)[1],/*lPixel*/,{|| cLinha		})	// "Linha"
TRCell():New(oLinha,"CLINHADESC"	,/*Tabela*/	,RetTitle("BV_DESCRI")	,PesqPict("SBV","BV_DESCRI"	),TamSx3("BV_DESCRI"	)[1],/*lPixel*/,{|| cLinhaDesc	})	// Descricao da Linha

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 1.1.1 - Colunas das Linhas                               		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oColuna := TRSection():New(oLinha,STR0036,{"SB4","SBV","SC6","SC5"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "QUANTIDADES EM GRADES - "
oColuna:SetTotalInLine(.F.)
TRCell():New(oColuna,"BRANCO"		,"SBV"		,STR0037			,							 ,05						,/*lPixel*/,{|| Space(05)	})  //"Coluna em branco"
TRCell():New(oColuna,"BV_CHAVE"		,"SBV"		,STR0023			,PesqPict("SBV","BV_CHAVE"	),TamSx3("BV_CHAVE"		)[1],/*lPixel*/,)	// "Coluna"
TRCell():New(oColuna,"BV_DESCRI"	,"SBV"		,STR0024			,PesqPict("SBV","BV_DESCRI"	),TamSx3("BV_DESCRI"	)[1],/*lPixel*/,)	// "Descricao da Coluna"
TRCell():New(oColuna,"C6_NUM"		,"SC6"		,RetTitle("C6_NUM")	,PesqPict("SC6","C6_NUM"	),TamSx3("C6_NUM"		)[1],/*lPixel*/,)	// Numero do Pedido de Vendas
TRCell():New(oColuna,"NQTDEMP"		,/*Table*/	,STR0020			,PesqPict("SC6","C6_QTDVEN"	),TamSx3("C6_QTDVEN"	)[1],/*lPixel*/,{|| nQtdEmp		})	// "Qtde a Faturar"
TRCell():New(oColuna,"NQTDENT"		,/*Table*/	,STR0021			,PesqPict("SC6","C6_QTDVEN"	),TamSx3("C6_QTDVEN"	)[1],/*lPixel*/,{|| nQtdEnt		})	// "Qtde Faturada"
TRCell():New(oColuna,"NQTDTOT"		,/*Table*/	,STR0022			,PesqPict("SC6","C6_QTDVEN"	),TamSx3("C6_QTDVEN"	)[1],/*lPixel*/,{|| nQtdTot		})	// "Qtde Total"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho da secao no topp da pagina.                		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):Section(1):SetTotalText(STR0031)		// "Sub-Total"

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 25/07/06 ³±±
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
Static Function ReportPrint(oReport,cAliasSB4,oColuna,oLinha,oRefer,oTotal)


Local lFirst  :=.T.
Local aTitulo := {STR0027,STR0028,STR0029,STR0030}			//"Detalhado"###"Analitico"###"Sintetico"###"Resumido "

#IFNDEF TOP
	Local cCondicao := ""
#ELSE
	Local cOrder := ""	
#ENDIF

Private lLinhaAux 	:= .T.
Private nTamRef 	:= Val(Substr(GetMv("MV_MASCGRD"),1,2))

oReport:Section(1):Section(1):Section(1):Cell("BRANCO"):SetTitle("")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Detalhado                                                    		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par09 == 1
	TRFunction():New(oColuna:Cell("NQTDEMP"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	TRFunction():New(oColuna:Cell("NQTDENT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	TRFunction():New(oColuna:Cell("NQTDTOT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	oReport:Section(1):Section(1):Section(1):Cell("C6_NUM"):Enable()
	oReport:Section(1):Section(1):Section(1):SetHeaderPage(.T.)		// Imprime Cabecalho no Topo da Pagina
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Analitico                                                    		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ElseIf mv_par09 == 2	
	oReport:Section(1):Section(1):Section(1):Cell("C6_NUM"):Disable()	
	oReport:Section(1):Section(1):Section(1):SetHeaderPage(.T.)		// Imprime Cabecalho no Topo da Pagina
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sintetico                                                    		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ElseIf mv_par09 == 3
	oReport:Section(1):Section(1):Section(1):Hide()
	oReport:Section(1):Section(1):SetHeaderPage(.T.)					// Imprime Cabecalho no Topo da Pagina
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Resumido                                                     		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ElseIf mv_par09 == 4
	oReport:Section(1):SetHeaderPage(.T.)
	oReport:Section(1):Section(1):Section(1):Hide()					// Imprime Cabecalho no Topo da Pagina
	oReport:Section(1):Section(1):Hide()
EndIf	


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores na quebra da linha e referencia                		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRFunction():New(oColuna:Cell("NQTDEMP"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oLinha)
TRFunction():New(oColuna:Cell("NQTDENT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oLinha)
TRFunction():New(oColuna:Cell("NQTDTOT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oLinha)

TRFunction():New(oColuna:Cell("NQTDEMP"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oRefer)
TRFunction():New(oColuna:Cell("NQTDENT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oRefer)
TRFunction():New(oColuna:Cell("NQTDTOT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oRefer)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o bloco de codigo que retornara o conteudo de impres- 		   ³
//³ sao da celula.                                               		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):Cell("CLINHA"):SetBlock({|| cLinha })
oReport:Section(1):Section(1):Cell("CLINHADESC"):SetBlock({|| cLinhaDesc })

oReport:Section(1):Section(1):Section(1):Cell("NQTDEMP"):SetBlock({|| nQtdEmp })
oReport:Section(1):Section(1):Section(1):Cell("NQTDENT"):SetBlock({|| nQtdEnt })
oReport:Section(1):Section(1):Section(1):Cell("NQTDTOT"):SetBlock({|| nQtdTot })
nQtdEnt := 0
nQtdEmp := 0
nQtdTot := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera titulo do relatorio de acordo com parametro mv_par09            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:setTitle(oReport:Title()+ " " + aTitulo[MV_PAR09])

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SB4")		// Referencia de Produto
dbSetOrder(1)			// Filial,Codigo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cOrder := "%" + SqlOrder(SB4->(IndexKey())) + "%"
oReport:Section(1):BeginQuery()	
BeginSql Alias cAliasSB4
SELECT *
FROM %Table:SB4% SB4
WHERE B4_FILIAL = %xFilial:SB4% AND 
	B4_COD >= %Exp:mv_par11% AND B4_COD <= %Exp:mv_par12% AND
	SB4.%NotDel%
ORDER BY %Exp:cOrder%
EndSql 
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAliasSB4)->(LastRec()))

dbSelectArea(cAliasSB4)
While !oReport:Cancel() .And. !(cAliasSB4)->(Eof()) .And. (cAliasSB4)->B4_FILIAL == xFilial("SB4")
	
	dbSelectArea("SBV")
	dbSetOrder(1)
	dbSeek(xFilial("SBV")+(cAliasSB4)->B4_LINHA)
	
	oReport:SetMeter(RecCount())		// Total de Elementos da regua
	oReport:Section(1):Init()
	oReport:Section(1):PrintLine()
	lTemLinha := .F.
	While !oReport:Cancel() .And. !Eof() .And. SBV->BV_FILIAL == xFilial("SBV") .And. (SBV->BV_TABELA == (cAliasSB4)->B4_LINHA)
		lTemLinha := .T.
		cProdLin  := SubStr((cAliasSB4)->B4_COD,1,nTamRef)+Alltrim(SBV->BV_CHAVE)
		cLinha    := Alltrim(SBV->BV_CHAVE)
		cLinhadesc:= SBV->BV_DESCRI
		dbSelectArea("SBV")
		nRegLin:= Recno()
		dbSeek(xFilial("SBV")+(cAliasSB4)->B4_COLUNA)
		lLinhaAux:=.T.
		
		oReport:Section(1):Section(1):Init()
		oReport:Section(1):Section(1):PrintLine()
		lTemCol := .F.
		While !oReport:Cancel() .And. !Eof() .And. SBV->BV_FILIAL == xFilial("SBV") .And. (SBV->BV_TABELA == (cAliasSB4)->B4_COLUNA)
			LtEMcOL := .t.
			cProdCol:= cProdLin+Alltrim(SBV->BV_CHAVE)
			dbSelectArea("SC6")
			dbSetOrder(2)
			dbSeek(xFilial("SC6")+cProdCol)
			dbSelectArea("SC6")
			lFirst  :=.T.
			
			oReport:Section(1):Section(1):Section(1):Init()
			lTemProd := .F.
			nQtdEnt := 0
			nQtdEmp := 0
			While !oReport:Cancel() .And. !Eof() .And. SC6->C6_FILIAL == xFilial("SC6") .And.;
				Alltrim(SC6->C6_PRODUTO) == Alltrim(cProdCol) .And. xFilial() == SC6->C6_FILIAL

				dbSelectArea("SC5")
				dbSetOrder(1)
				dbSeek( xFilial("SC5")+SC6->C6_NUM )				

				lTemProd := .T.
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Filtro das perguntas                                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If SC6->C6_NUM     < mv_par01 .Or. SC6->C6_NUM     > mv_par02 .Or.;
					SC5->C5_EMISSAO < mv_par05 .Or. SC5->C5_EMISSAO > mv_par06 .Or.;
					SC6->C6_CLI     < mv_par07 .Or. SC6->C6_CLI     > mv_par08 .Or.;
					SC6->C6_GRADE  != "S"      .Or. SC6->C6_PRODUTO < mv_par03 .Or.;
					SC6->C6_PRODUTO     > mv_par04
					SC6->(dbSkip())
					Loop
				Endif
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Valida o produto conforme a mascara         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				lRet:=ValidMasc(SC6->C6_PRODUTO,MV_PAR10)
				If !lRet
					SC6->(dbSkip())
					Loop
				Endif
				
				nQtdEnt += SC6->C6_QTDENT
				nQtdEmp += SC6->C6_QTDEMP

				// Detalhado
				If mv_par09 == 1
					nQtdTot := nQtdEmp + nQtdEnt
					If (nQtdEnt > 0 .Or. nQtdEmp > 0)
						If lFirst
							oReport:Section(1):Section(1):Section(1):Cell("BV_CHAVE"):Show()
							oReport:Section(1):Section(1):Section(1):Cell("BV_DESCRI"):Show()
							lFirst := .F.
						Else
							oReport:Section(1):Section(1):Section(1):Cell("BV_CHAVE"):Hide()
							oReport:Section(1):Section(1):Section(1):Cell("BV_DESCRI"):Hide()
						EndIf
	
						oReport:Section(1):Section(1):Section(1):PrintLine()
	
						nQtdEnt := 0
						nQtdEmp := 0
					EndIf
				EndIf
				
				dbSelectArea("SC6")
				SC6->(dbSkip())
			End
			
			
			// Analitico, Sintetico ou Resumido
			nQtdTot := nQtdEmp + nQtdEnt
			If nQtdTot > 0 .And. (mv_par09 == 2 .Or. mv_par09 == 3 .Or. mv_par09 == 4)
				oReport:Section(1):Section(1):Section(1):PrintLine()
			EndIf
			nQtdEnt := 0
			nQtdEmp := 0
			
			If lTemProd .And. (nQtdEnt > 0 .Or. nQtdEmp > 0)
				oReport:Section(1):Section(1):Section(1):Finish()
			EndIf
			
			dbSelectArea("SBV")
			SBV->(dbSkip())
		End
		If lTemCol .And. mv_par09 <> 4		// Resumido
			oReport:Section(1):Section(1):SetTotalText(STR0032 + cLinhadesc)	// "Sub-Total de "
			oReport:Section(1):Section(1):Finish()
		EndIf
		lLinhaAux:=.F.
		dbSelectArea("SBV")
		dbGoto(nRegLin)
		dbSkip()
	End
	
	If lTemLinha
		oReport:Section(1):SetTotalText(STR0033 +  (cAliasSB4)->B4_DESC)	// "T O T A L DE "
		oReport:Section(1):Finish()
	EndIf
	
	dbSelectArea(cAliasSB4)
	(cAliasSB4)->(dbSkip())
	oReport:IncMeter()
EndDo

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR795R3³ Autor ³ Marcos Bregantim      ³ Data ³ 11.04.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Quantidades em Grades                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MATR795(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Edson   M.   ³30/03/99³XXXXXX³Passar o tamanho na SetPrint.           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr795R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel
LOCAL aTitulo := {OemToAnsi(STR0001),OemToAnsi(STR0002),OemToAnsi(STR0003),OemToAnsi(STR0004)}			//"Detalhado"###"Analitico"###"Sintetico"###"Resumido "
LOCAL cDesc1:=OemToAnsi(STR0005)	//"Emiss„o do Relatorio de Quantidades em Grades dos Pedidos de Vendas"
LOCAL cDesc2:=OemToAnsi(STR0006)	//"atraves de intervalo de Pedidos informado na op‡„o Parƒmetros."
LOCAL cDesc3:=""
LOCAL CbCont
LOCAL lContinua := .T.
LOCAL cProdAnt:=" ",cProdutonPedCar:=0,nPedFat:=0,cColAnt:=" "
cPerg :="MTR795"

PRIVATE lLinhaAux := .T.,lProduto:=.T.
PRIVATE tamanho:="P",lFirst:=.T.,cLinha,cLinhaDesc
PRIVATE titulo:=OemToAnsi(STR0009),cabec1,cabec2   //   "Quantidades em Grades - "
PRIVATE cMascara :=GetMv("MV_MASCGRD")
PRIVATE nTamRef  :=Val(Substr(cMascara,1,2))
PRIVATE nTamLin  :=Val(Substr(cMascara,4,2))
PRIVATE nTamCol  :=Val(Substr(cMascara,7,2))
PRIVATE nFatur:=0,nCart:=0,nSubFat:=0,nSubCar:=0,nTotFat:=0,nTotCar:=0
PRIVATE nSubFat1:=0,nSubCar1:=0
PRIVATE aReturn := {STR0007, 1,STR0008, 2, 2, 1, "",0 }		//"Zebrado"###"Administracao"
PRIVATE nomeprog:="MATR795",nLastKey := 0,nBegin:=0,aLinha:={ }
PRIVATE li:=80,limite:=80,lRodape:=.F.
PRIVATE nTotQtd:=nTotVal:=0

wnrel    := "MATR795"
cString  := "SB4"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       :=80
m_pag    :=1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR795",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ mv_par01	     	  Do Pedido                                ³
//³ mv_par02	     	  Ate o Pedido                             ³
//³ mv_par03	     	  Do Produto                               ³
//³ mv_par04	     	  Ate o Produto                            ³
//³ mv_par05	     	  Da Data Emissao                          ³
//³ mv_par06	     	  Ate a Data Emissao                       ³
//³ mv_par07	     	  Do Cliente                               ³
//³ mv_par08	     	  Ate o Cliente                            ³
//³ mv_par09	     	  Analitico/Sintetico/Resumido             ³
//³ mv_par10	     	  Mascara do Produto                       ³
//³ mv_par11	     	  Codigo de Referencia Produto de          ³
//³ mv_par12	     	  Codigo de Referencia do Produto ate      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

If nLastKey==27
	dbClearFilter()
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey==27
	dbClearFilter()
	Return
Endif

RptStatus({|lEnd| C795Imp(@lEnd,wnRel,cString)},Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C795IMP  ³ Autor ³ Rosane Luciane Chene  ³ Data ³ 09.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR795			                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C795Imp(lEnd,WnRel,cString)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL aTitulo := {OemToAnsi(STR0001),OemToAnsi(STR0002),OemToAnsi(STR0003),OemToAnsi(STR0004)}			//"Detalhado"###"Analitico"###"Sintetico"###"Resumido "



LOCAL lContinua := .T.

cPerg :="MTR795"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := STR0009+aTitulo[MV_PAR09] //"QUANTIDADES EM GRADES - "
cabec1 := STR0010	//"          Coluna  Desc. da Coluna   Qtde a Faturar  Qtde Faturada     Qtde Total"
cabec2 := ""
dbSelectArea("SB4")
dbSetOrder(1)
dbSeek( xFilial()+mv_par11,.T. )

SetRegua(RecCount())		// Total de Elementos da regua

While !Eof() .And. B4_FILIAL+B4_COD <= xFilial()+mv_par12 .And. lContinua
	
	If lEnd
		@Prow()+1,001 PSAY STR0011	//"CANCELADO PELO OPERADOR"
		lContinua := .F.
		Exit
	Endif
	
	IncRegua()
	cProduto := SB4->B4_COD
	cLinha   := SB4->B4_LINHA
	nTotFat  := 0
	nTotCar  := 0
	
	If mv_par09 == 1
		U_AcumDet(@lEnd)
	ElseIf mv_par09 == 2
		U_AcumAnal(@lEnd)
	ElseIf mv_par09 == 3
		U_AcumSint(@lEnd)
	ElseIf mv_par09 == 4
		U_AcumRes(@lEnd)
	Endif
	U_ImpTot()
	dbSelectArea("SB4")
	dbSkip()
	lFirst:=.T.
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC6")
dbClearFilter()
dbSetOrder(1)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se em disco, desvia para Spool                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5] = 1    // Se Saida para disco, ativa SPOOL
	Set Printer TO
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ACUMDET  ³ Autor ³ Marcos Bregantim      ³ Data ³ 11.04.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Acumula total Detalhado                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AcumDet(lEnd)

dbSelectArea("SBV")
dbSetOrder(1)
dbSeek(xFilial()+SB4->B4_LINHA)

SetRegua(RecCount())		// Total de Elementos da regua

While !Eof() .And. (SBV->BV_TABELA == SB4->B4_LINHA)
	cProdLin  := SubStr(SB4->B4_COD,1,nTamRef)+Alltrim(SBV->BV_CHAVE)
	cLinha    := Alltrim(SBV->BV_CHAVE)
	cLinhadesc:= SBV->BV_DESCRI
	nFatur := 0
	nCart  := 0
	dbSelectArea("SBV")
	nRegLin:= Recno()
	dbSeek(xFilial()+SB4->B4_COLUNA)
	lLinhaAux:=.T.
	While !Eof() .And. (SBV->BV_TABELA == SB4->B4_COLUNA)
		cProdCol:= cProdLin+Alltrim(SBV->BV_CHAVE)
		dbSelectArea("SC6")
		dbSetOrder(2)
		dbSeek(xFilial()+cProdCol)
		dbSelectArea("SC6")
		lProduto:=.T.
		While !Eof() .And. Alltrim(SC6->C6_PRODUTO) == Alltrim(cProdCol) .And. xFilial() == SC6->C6_FILIAL
			If lEnd
				@Prow()+1,001 PSAY STR0011	//"CANCELADO PELO OPERADOR"
				lContinua := .F.
				Exit
			Endif
			IncRegua()

			dbSelectArea("SC5")
			dbSetOrder(1)
			dbSeek( xFilial("SC5")+SC6->C6_NUM )
					
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Filtro das perguntas                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SC6->C6_NUM     < mv_par01 .Or. SC6->C6_NUM     > mv_par02 .Or.;
				SC5->C5_EMISSAO < mv_par05 .Or. SC5->C5_EMISSAO > mv_par06 .Or.;
				SC6->C6_CLI     < mv_par07 .Or. SC6->C6_CLI     > mv_par08 .Or.;
				SC6->C6_GRADE  != "S"      .Or. SC6->C6_PRODUTO < mv_par03 .Or.;
				SC6->C6_PRODUTO     > mv_par04
				SC6->(dbSkip())
				Loop
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Valida o produto conforme a mascara         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			lRet:=ValidMasc(SC6->C6_PRODUTO,MV_PAR10)
			If !lRet
				SC6->(dbSkip())
				Loop
			Endif
			
			If SC6->C6_QTDENT > 0
				nFatur  += SC6->C6_QTDENT
			Else
				nCart   += SC6->C6_QTDEMP
			Endif
			Imprime()
			SC6->(dbSkip())
		End
		U_ImpSub2()
		nFatur :=0
		nCart  :=0
		dbSelectArea("SBV")
		dbSkip()
	End
	lLinhaAux:=.F.
	U_ImpSub()
	dbSelectArea("SBV")
	dbGoto(nRegLin)
	dbSkip()
End

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ACUMANAL ³ Autor ³ Marcos Bregantim      ³ Data ³ 11.04.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Acumula total Analitico                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AcumAnal(lEnd)

dbSelectArea("SBV")
dbSetOrder(1)
dbSeek(xFilial()+SB4->B4_LINHA)
While !Eof() .And. (SBV->BV_TABELA == SB4->B4_LINHA)
	
	cProdLin  := Substr(SB4->B4_COD,1,nTamRef)+Alltrim(SBV->BV_CHAVE)
	cLinha    := Alltrim(SBV->BV_CHAVE)
	cLinhadesc:= SBV->BV_DESCRI
	nFatur := 0
	nCart  := 0
	dbSelectArea("SBV")
	nRegLin:= Recno()
	dbSeek(xFilial()+SB4->B4_COLUNA)
	lLinhaAux:=.T.
	While !Eof() .And. (SBV->BV_TABELA == SB4->B4_COLUNA)
		cProdCol:= cProdLin+Alltrim(SBV->BV_CHAVE)
		dbSelectArea("SC6")
		dbSetOrder(2)
		dbSeek(xFilial()+cProdCol)
		dbSelectArea("SC6")
		SetRegua(RecCount())		// Total de Elementos da regua
		
		While !Eof() .And. Alltrim(SC6->C6_PRODUTO) == Alltrim(cProdCol) .And. xFilial() == SC6->C6_FILIAL
			If lEnd
				@Prow()+1,001 PSAY STR0011	//"CANCELADO PELO OPERADOR"
				lContinua := .F.
				Exit
			Endif
			IncRegua()

			dbSelectArea("SC5")
			dbSetOrder(1)
			dbSeek( xFilial("SC5")+SC6->C6_NUM )
					
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Filtro das perguntas                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SC6->C6_NUM     < mv_par01 .Or. SC6->C6_NUM     > mv_par02 .Or.;
				SC5->C5_EMISSAO < mv_par05 .Or. SC5->C5_EMISSAO > mv_par06 .Or.;
				SC6->C6_CLI     < mv_par07 .Or. SC6->C6_CLI     > mv_par08 .Or.;
				SC6->C6_GRADE  != "S"      .Or. SC6->C6_PRODUTO     < mv_par03 .Or.;
				SC6->C6_PRODUTO     > mv_par04
				SC6->(dbSkip())
				Loop
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Valida o produto conforme a mascara         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			lRet:=ValidMasc(SC6->C6_PRODUTO,MV_PAR10)
			If !lRet
				SC6->(dbSkip())
				Loop
			Endif
			
			If SC6->C6_QTDENT > 0
				nFatur  += SC6->C6_QTDENT
			Else
				nCart   += SC6->C6_QTDEMP
			Endif
			SC6->(dbSkip())
		End
		Imprime()
		nFatur :=0
		nCart  :=0
		dbSelectArea("SBV")
		dbSkip()
	End
	lLinhaAux:=.F.
	U_ImpSub()
	dbSelectArea("SBV")
	dbGoto(nRegLin)
	dbSkip()
End

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ACUMSINT ³ Autor ³ Marcos Bregantim      ³ Data ³ 11.04.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Acumula total Sintetico                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AcumSint(lEnd)

dbSelectArea("SBV")
dbSetOrder(1)
dbSeek(xFilial()+SB4->B4_LINHA)
While !Eof() .And. (SBV->BV_tabela == SB4->B4_LINHA)
	
	cLinha    :=Alltrim(SBV->BV_CHAVE)
	cLinhaDesc:=SBV->BV_DESCRI
	nFatur := 0
	nCart  := 0
	nRegLin:= Recno()
	lLinhaAux := .T.
	dbSelectArea("SBV")
	While !Eof() .And. (Alltrim(SBV->BV_CHAVE) == cLinha)
		cProdLin:= Substr(SB4->B4_COD,1,nTamRef)+Alltrim(SBV->BV_CHAVE)
		dbSelectArea("SC6")
		dbSetOrder(2)
		dbSeek(xFilial()+cProdLin)
		dbSelectArea("SC6")
		SetRegua(RecCount())		// Total de Elementos da regua
		
		While !Eof() .And. Substr(SC6->C6_PRODUTO,1,nTamRef+nTamLin) == cProdLin .And. xFilial() == SC6->C6_FILIAL
			
			If lEnd
				@Prow()+1,001 PSAY STR0011	//"CANCELADO PELO OPERADOR"
				lContinua := .F.
				Exit
			Endif
			IncRegua()

			dbSelectArea("SC5")
			dbSetOrder(1)
			dbSeek( xFilial("SC5")+SC6->C6_NUM )
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Filtro das perguntas                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SC6->C6_NUM     < mv_par01 .Or. SC6->C6_NUM     > mv_par02 .Or.;
				SC5->C5_EMISSAO < mv_par05 .Or. SC5->C5_EMISSAO > mv_par06 .Or.;
				SC6->C6_CLI     < mv_par07 .Or. SC6->C6_CLI     > mv_par08 .Or.;
				SC6->C6_GRADE  != "S"      .Or. SC6->C6_PRODUTO     < mv_par03 .Or.;
				SC6->C6_PRODUTO     > mv_par04
				SC6->(dbSkip())
				Loop
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Valida o produto conforme a mascara         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			lRet:=ValidMasc(SC6->C6_PRODUTO,MV_PAR10)
			If !lRet
				SC6->(dbSkip())
				Loop
			Endif
			
			If SC6->C6_QTDENT > 0
				nSubFat  += SC6->C6_QTDENT
			Else
				nSubCar  += SC6->C6_QTDEMP
			Endif
			SC6->(dbSkip())
		End
		dbSelectArea("SBV")
		dbSkip()
	End
	U_ImpSub()
	nSubFat :=0
	nSubCar  :=0
	dbSelectArea("SBV")
	dbGoto(nRegLin)
	dbSkip()
End

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ACumRes  ³ Autor ³ Marcos Bregantim      ³ Data ³ 11.04.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Acumula total Resumido                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AcumRes(lEnd)

dbSelectArea("SC6")
dbSetOrder(2)
dbSeek(xFilial()+Substr(SB4->B4_COD,1,nTamRef))
dbSelectArea("SC6")
SetRegua(RecCount())		// Total de Elementos da regua
While !Eof() .And. Substr(SC6->C6_PRODUTO,1,nTamRef) == Substr(SB4->B4_COD,1,nTamRef) .And.;
	xFilial() == C6_FILIAL
	
	If lEnd
		@Prow()+1,001 PSAY STR0011	//"CANCELADO PELO OPERADOR"
		lContinua := .F.
		Exit
	Endif
	IncRegua()
	
	dbSelectArea("SC5")
	dbSetOrder(1)
	dbSeek( xFilial("SC5")+SC6->C6_NUM )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtro das perguntas                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SC6->C6_NUM     < mv_par01 .Or. SC6->C6_NUM     > mv_par02 .Or.;
		SC5->C5_EMISSAO < mv_par05 .Or. SC5->C5_EMISSAO > mv_par06 .Or.;
		SC6->C6_CLI     < mv_par07 .Or. SC6->C6_CLI     > mv_par08 .Or.;
		SC6->C6_GRADE  != "S"      .Or. SC6->C6_PRODUTO     < mv_par03 .Or.;
		SC6->C6_PRODUTO     > mv_par04
		SC6->(dbSkip())
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida o produto conforme a mascara         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lRet:=ValidMasc(SC6->C6_PRODUTO,MV_PAR10)
	If !lRet
		SC6->(dbSkip())
		Loop
	Endif
	
	If SC6->C6_QTDENT > 0
		nTotFat  += SC6->C6_QTDENT
	Else
		nTotCar  += SC6->C6_QTDEMP
	Endif
	SC6->(dbSkip())
End
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPRIME  ³ Autor ³ Marcos Bregantim      ³ Data ³ 11.04.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime linha de detalhe ja acumulada                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Imprime()

If (nFatur > 0 .Or. nCart > 0)
	If li > 55
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
		lRodape := .T.
	Endif
	
	If lFirst
		li+=2
		@ li,000 PSAY STR0012 + SB4->B4_COD + " " + Substr(SB4->B4_DESC,1,30)			//"REFERENCIA : "
		li++
		@ li,000 PSAY __PrtThinLine()
		lFirst:=.F.
	Endif
	
	If mv_par09 == 2
		If lLinhaAux
			li++
			@ li,005 PSAY STR0013 + cLinha + " " + cLinhaDesc		//"LINHA : "
			lLinhaAux:=.F.
		Endif
		li++
		@li,005 PSAY SBV->BV_CHAVE
		@li,012 PSAY Substr(SBV->BV_DESCRI,1,20)
		@li,035 PSAY nCart            Picture PESQPICTQT("C6_QTDVEN",15)
		@li,050 PSAY nFatur           Picture PESQPICTQT("C6_QTDVEN",15)
		@li,065 PSAY nFatur + nCart   Picture PESQPICTQT("C6_QTDVEN",15)
		nSubFat += nFatur
		nSubCar += nCart
	ElseIf mv_par09 == 1
		If lLinhaAux
			li++
			@ li,005 PSAY STR0013 + cLinha + " " + cLinhaDesc		//"LINHA : "
			lLinhaAux:=.F.
		Endif
		If lProduto
			li++
			@li,010 PSAY SBV->BV_CHAVE
			@li,018 PSAY Substr(SBV->BV_DESCRI,1,20)
			lProduto:=.F.
		Endif
		li++
		@li,018 PSAY STR0014	//"PEDIDO :"
		@li,028 PSAY SC6->C6_NUM 	
		@li,035 PSAY nCart            Picture PESQPICTQT("C6_QTDVEN",15)
		@li,050 PSAY nFatur           Picture PESQPICTQT("C6_QTDVEN",15)
		@li,065 PSAY nFatur + nCart   Picture PESQPICTQT("C6_QTDVEN",15)
		nSubFat += nFatur
		nSubCar += nCart
	Endif
Endif
nFatur:=0
nCart :=0
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPSUB   ³ Autor ³ Marcos Bregantim      ³ Data ³ 11.04.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Sub-Total                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ImpSub()

If nSubFat > 0 .Or. nSubCar > 0 .Or. nSubFat1 > 0 .Or. nSubCar1 > 0
	
	If li > 55
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
		lRodape := .T.
	Endif
	
	If lFirst
		li+=2
		@ li,000 PSAY STR0012 + SB4->B4_COD + " " + Substr(SB4->B4_DESC,1,30)		//"REFERENCIA : "
		li++
		@ li,000 PSAY __PrtThinLine()
		lFirst:=.F.
	Endif
	IF MV_PAR09 == 1
		li++
		@ li,005 PSAY STR0015	//"Sub Total"
		@ li,035 PSAY nSubCar1            Picture PesqPictqt("C6_QTDVEN",15)
		@ li,050 PSAY nSubFat1            Picture PesqPictqt("C6_QTDVEN",15)
		@ li,065 PSAY nSubFat1 + nSubCar1 Picture PesqPictqt("C6_QTDVEN",15)
		li++
		@ li,000 PSAY __PrtThinLine()
		nTotFat += nSubFat1
		nTotCar += nSubCar1
	Else
		If lLinhaAux
			li++
			@ li,005 PSAY STR0013 + cLinha + " " + cLinhaDesc			//"LINHA : "
			lLinhaAux:=.F.
		Endif
		li++
		@ li,010 PSAY STR0015	//"Sub Total"
		@ li,035 PSAY nSubCar	          Picture PesqPictqt("C6_QTDVEN",15)
		@ li,050 PSAY nSubFat           Picture PesqPictqt("C6_QTDVEN",15)
		@ li,065 PSAY nSubFat + nSubCar Picture PesqPictqt("C6_QTDVEN",15)
		nTotFat += nSubFat
		nTotCar += nSubCar
	Endif
Endif
nSubFat:=0
nSubCar:=0
nSubFat1:=0
nSubCar1:=0
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPSUB2  ³ Autor ³ Marcos Bregantim      ³ Data ³ 11.04.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Sub-Total Detalhado                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ImpSub2()

If nSubFat > 0 .Or. nSubCar > 0
	
	If li > 55
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
		lRodape := .T.
	Endif
	li++
	@ li,010 PSAY STR0015	//"Sub Total"
	@ li,035 PSAY nSubCar	          Picture PesqPictqt("C6_QTDVEN",15)
	@ li,050 PSAY nSubFat           Picture PesqPictqt("C6_QTDVEN",15)
	@ li,065 PSAY nSubFat + nSubCar Picture PesqPictqt("C6_QTDVEN",15)
	nSubFat1 += nSubFat
	nSubCar1 += nSubCar
Endif
nSubFat:=0
nSubCar:=0

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPTOT   ³ Autor ³ Marcos Bregantim      ³ Data ³ 11.04.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime linha de total                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ImpTot()

If nTotFat > 0 .Or. nTotCar > 0
	If li > 55
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
		lRodape := .T.
	Endif
	
	If lFirst
		li+=2
		@ li,000 PSAY STR0012 + SB4->B4_COD + " " + Substr(SB4->B4_DESC,1,30)			//"REFERENCIA : "
		li++
		@ li,000 PSAY __PrtThinLine()
		lFirst:=.F.
	Endif
	li++
	@ li,000 PSAY STR0016	//"T O T A L "
	@ li,035 PSAY nTotCar	Picture PesqPictqt("C6_QTDVEN",15)
	@ li,050 PSAY nTotFat	Picture PesqPictqt("C6_QTDVEN",15)
	@ li,065 PSAY nTotCar	+ nTotFat Picture PesqPictqt("C6_QTDVEN",15)
	li++
	@ li,000 PSAY __PrtThinLine()
Endif
nTotCar:=0
nTotFat:=0

Return Nil