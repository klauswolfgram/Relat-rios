/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR780.CH"
#INCLUDE "PROTHEUS.CH" 


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR780  ³ Autor ³ Marco Bianchi         ³ Data ³ 19/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Vendas por Cliente, quantidade de cada Produto, ³±±
±±³          ³ Release 4.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR780()

Local oReport

Private oTmpTab_1 	:= Nil
Private oTmpTab_2 	:= Nil


	oReport := ReportDef()
	oReport:PrintDialog()


Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 19/07/06 ³±±
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

Local cAliasSD1 := GetNextAlias()
Local cAliasSD2 := GetNextAlias()
Local cAliasSA1 := GetNextAlias()


Local cCodProd	:= ""
Local cDescProd	:= ""
Local cDoc		:= ""
Local cSerie	:= ""
Local dEmissao	:= CTOD("  /  /  ")
Local cUM		:= ""
Local nTotQuant	:= 0
Local nVlrUnit	:= 0
Local nValadi		:= 0
Local nVlrTot	:= 0
Local cVends	:= ""
Local cClieAnt	:= ""
Local cLojaAnt	:= ""
Local nTamData  := Len(DTOC(MsDate()))+4
Local lValadi	:= cPaisLoc == "MEX" .AND. SD2->(FieldPos("D2_VALADI")) > 0 //  Adiantamentos Mexico
Local nTamB1Dsc := Min(TamSX3("B1_DESC")[1]+10,70) //limite da largura da descrição em 60
Local nTamB1Cod := TamSX3("B1_COD")[1]+5


Private cSD1, cSD2

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
oReport := TReport():New("MATR780",STR0018,"MR780A", {|oReport| ReportPrint(oReport,cAliasSD1,cAliasSD2,cAliasSA1)},STR0019 + " " + STR0020)	// "Estatisticas de Vendas (Cliente x Produto)"###"Este programa ira emitir a relacao das compras efetuadas pelo Cliente,"###"totalizando por produto e escolhendo a moeda forte para os Valores."
oReport:SetPortrait() 
oReport:SetTotalInLine(.F.)

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
//³ Secao 1 - Cliente                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCliente := TRSection():New(oReport,STR0027,{"SA1","SD2TRB"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Estatisticas de Vendas (Cliente x Produto)"
oCliente:SetTotalInLine(.F.)
oCliente:SetAutoSize(.T.)

TRCell():New(oCliente,"CCLIEANT"	,/*Tabela*/	,RetTitle("D2_CLIENTE"	),PesqPict("SD2","D2_CLIENTE"	),TamSx3("A1_COD"			)[1],/*lPixel*/,{|| cClieAnt		})
TRCell():New(oCliente,"CLOJA"		,/*Tabela*/	,RetTitle("D2_LOJA"		),PesqPict("SD2","D2_LOJA"		),TamSx3("D2_LOJA"			)[1],/*lPixel*/,{|| cLojaAnt				})
TRCell():New(oCliente,"A1_NOME"		,/*Tabela*/	,RetTitle("A1_NOME"		),PesqPict("SA1","A1_NOME"		),TamSx3("A1_NOME"			)[1],/*lPixel*/,{|| (cAliasSA1)->A1_NOME	})
TRCell():New(oCliente,"A1_OBSERV"	,/*Tabela*/	,RetTitle("A1_OBSERV"	) ,PesqPict("SA1","A1_OBSERV"	),TamSx3("A1_OBSERV"		)[1],/*lPixel*/,{|| (cAliasSA1)->A1_OBSERV	})

// Imprimie Cabecalho no Topo da Pagina
oReport:Section(1):SetHeaderPage()
oReport:Section(1):SetLineBreak()                       

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sub-Secao do Cliente - Produto                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oProduto := TRSection():New(oCliente,STR0028,{"SD2","SD1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Estatisticas de Vendas (Cliente x Produto)"
oProduto:SetTotalInLine(.F.)
oProduto:SetAutoSize(.T.)

TRCell():New(oProduto,"CCODPROD"	,/*Tabela*/,RetTitle("D2_COD"		),PesqPict("SD2","D2_COD"					),nTamB1Cod 				,/*lPixel*/,{|| cCodProd	},,.T.)
TRCell():New(oProduto,"CDESCPROD"	,/*Tabela*/,RetTitle("B1_DESC"		),PesqPict("SB1","B1_DESC"					),nTamB1Dsc				    ,/*lPixel*/,{|| cDescProd	},,.T.)
TRCell():New(oProduto,"CDOC"		,/*Tabela*/,RetTitle("D2_DOC"		),PesqPict("SD2","D2_DOC"					),TamSx3("D2_DOC"		)[1],/*lPixel*/,{|| cDoc		})
TRCell():New(oProduto,"CSERIE" 		,/*Tabela*/,SerieNfId("SD2",7,"D2_SERIE"),PesqPict("SD2","D2_SERIE"			),SerieNfId("SD2",6,"D2_SERIE"),/*lPixel*/,{|| cSerie		})
TRCell():New(oProduto,"DEMISSAO"	,/*Tabela*/,RetTitle("D2_EMISSAO"	),PesqPict("SD2","D2_EMISSAO"				),nTamData			   ,/*lPixel*/,{|| dEmissao	})
TRCell():New(oProduto,"CUM"			,/*Tabela*/,RetTitle("B1_UM"		),PesqPict("SB1","B1_UM"					),TamSx3("B1_UM"		)[1],/*lPixel*/,{|| cUM			})
TRCell():New(oProduto,"NTOTQUANT"	,/*Tabela*/,RetTitle("D2_QUANT"		),PesqPict("SD2","D2_QUANT"					),TamSx3("D2_QUANT"		)[1],/*lPixel*/,{|| nTotQuant	})
TRCell():New(oProduto,"NVLRUNIT"	,/*Tabela*/,RetTitle("D2_PRCVEN"	),PesqPict("SD2","D2_PRCVEN"				),TamSx3("D2_PRCVEN"	)[1],/*lPixel*/,{|| nVlrUnit	})
If lValadi
	TRCell():New(oProduto,"NVALADI"	,/*Tabela*/,RetTitle("D2_VALADI"	),PesqPict("SD2","D2_VALADI"				),TamSx3("D2_VALADI"	)[1],/*lPixel*/,{|| nValadi	})
EndIf
TRCell():New(oProduto,"NVLRTOT"		,/*Tabela*/,RetTitle("D2_TOTAL"		),PesqPict("SD2","D2_TOTAL"					),TamSx3("D2_TOTAL"		)[1],/*lPixel*/,{|| nVlrTot		})
TRCell():New(oProduto,"CVENDS"		,/*Tabela*/,STR0024					 ,PesqPict("SF2","F2_VEND1"					),TamSx3("F2_VEND1"		)[1],/*lPixel*/,{|| cVends		})	// "Vendedor"


// Alinhamento a direita das colunas de valor
oProduto:Cell("NTOTQUANT"):SetHeaderAlign("RIGHT") 
oProduto:Cell("NVLRUNIT"):SetHeaderAlign("RIGHT")
If lValadi
	oProduto:Cell("NVALADI"):SetHeaderAlign("RIGHT")
EndIf 
oProduto:Cell("NVLRTOT"):SetHeaderAlign("RIGHT") 

// Totalizador por Produto
oTotal1 := TRFunction():New(oProduto:Cell("NTOTQUANT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
If lValadi
	TRFunction():New(oProduto:Cell("NVALADI"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
EndIf
oTotal2 := TRFunction():New(oProduto:Cell("NVLRTOT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

// Totalizador por Cliente
oTotal3 := TRFunction():New(oProduto:Cell("NTOTQUANT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/,oCliente)
oTotal4 := TRFunction():New(oProduto:Cell("NVLRTOT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/,oCliente)
If lValadi
	TRFunction():New(oProduto:Cell("NVALADI"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/,oCliente)
EndIf

// Imprimie Cabecalho no Topo da Pagina
oReport:Section(1):Section(1):SetHeaderPage()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 2 - Filtro das nota de devolucao                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTemp1 := TRSection():New(oReport,STR0029,{"SD1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Estatisticas de Vendas (Cliente x Produto)"
oTemp1:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 4 - Filtro das Notas de Saida                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTemp3 := TRSection():New(oReport,STR0028,{"SD2"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Estatisticas de Vendas (Cliente x Produto)"
oTemp3:SetTotalInLine(.F.) 

oReport:Section(2):SetEditCell(.F.)
oReport:Section(3):SetEditCell(.F.)

oReport:Section(1):Section(1):SetLineBreak()

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 19/07/06 ³±±
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
Static Function ReportPrint(oReport,cAliasSD1,cAliasSD2,cAliasSA1)

Local  nV := 0
Local cProdAnt	  := "", cLojaAnt := ""
Local lNewProd	  := .T.
Local nTamRef	  := Val(Substr(GetMv("MV_MASCGRD"),1,2))
Local cProdRef	  := ""
Local cUM		  := ""
Local nTotQuant	  := 0
Local nReg		  := 0
Local cFiltro	  := ""
Local cEstoq	  := If( (mv_par13 == 1),"S",If( (mv_par13 == 2),"N","SN" ))
Local cDupli	  := If( (mv_par14 == 1),"S",If( (mv_par14 == 2),"N","SN" ))
Local cVends	  := ""
Local nVend		  := FA440CntVend()
Local nDevQtd	  := 0
Local nDevVal	  := 0
Local aDev		  := {}
Local aStru
Local lNfD2Ori	  := .F. 
Local cVendedores := ""
Local lNewCli     := .T.
Local nValadi     := 0
Local lValadi	  := cPaisLoc == "MEX" .AND. SD2->(FieldPos("D2_VALADI")) > 0 //  Adiantamentos Mexico
Local cFilSA1	:= xFilial("SA1")
Local cFilSD1	:= xFilial("SD1")
Local cFilSD2	:= xFilial("SD2")
Local cFilSB1	:= xFilial("SB1")
Local cFilSA7	:= xFilial("SA7")
Local cFilSF1	:= xFilial("SF1")
Local cFilSF2	:= xFilial("SF2")
Local cWhere:= ""	
Local nRecSD2	:= 0
Local ncSD2RecOri := 0
Local lGrade := .F.

Static cCodProd := ""

Private nIndD1  :=0
Private nDecs	:=msdecimais(mv_par09)
Private cTipoNf := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o bloco de codigo que retornara o conteudo de impres- ³
//³ sao da celula.                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Cell("CCLIEANT" 	):SetBlock({|| cClieAnt		})
oReport:Section(1):Cell("CLOJA" 	):SetBlock({|| cLojaAnt		})
oReport:Section(1):Section(1):Cell("CCODPROD" 	):SetBlock({|| cCodProd		})
oReport:Section(1):Section(1):Cell("CDESCPROD" ):SetBlock({|| cDescProd	})
oReport:Section(1):Section(1):Cell("CDOC"		):SetBlock({|| cDoc			})
oReport:Section(1):Section(1):Cell("CSERIE" 	):SetBlock({|| cSerie 		})
oReport:Section(1):Section(1):Cell("DEMISSAO" 	):SetBlock({|| dEmissao		})
oReport:Section(1):Section(1):Cell("CUM"		):SetBlock({|| cUM			})
oReport:Section(1):Section(1):Cell("NTOTQUANT"	):SetBlock({|| nTotQuant	})
oReport:Section(1):Section(1):Cell("NVLRUNIT" 	):SetBlock({|| nVlrUnit		})
If lValadi
	oReport:Section(1):Section(1):Cell("NVALADI" 	):SetBlock({|| nValadi	})
EndIf
oReport:Section(1):Section(1):Cell("NVLRTOT" 	):SetBlock({|| nVlrTot		})
oReport:Section(1):Section(1):Cell("CVENDS" 	):SetBlock({|| cVends		})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona ordem dos arquivos consultados no processamento    		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SF1->(dbsetorder(1))
SF2->(dbsetorder(1))
SB1->(dbSetOrder(1))
SA7->(dbSetOrder(2))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o Cabecalho de acordo com parametros                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " " + STR0021 +GetMV("MV_SIMB"+Str(mv_par09,1)))		// "Estatisticas de Vendas (Cliente x Produto)"###"Valores em "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtra nota de devolucao                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SD1")


cSD1   := "SD1TMP"
aStru  := dbStruct()
cWhere := "%NOT ("+IsRemito(3,'SD1.D1_TIPODOC')+ ")%"
oReport:Section(2):BeginQuery()
BeginSql Alias cAliasSD1
SELECT *
FROM %Table:SD1% SD1
WHERE SD1.D1_FILIAL = %xFilial:SD1% AND
    SD1.D1_FORNECE >= %Exp:mv_par01% AND SD1.D1_FORNECE <= %Exp:mv_par02% AND
    SD1.D1_DTDIGIT >= %Exp:DtoS(mv_par03)% AND SD1.D1_DTDIGIT <= %Exp:DtoS(mv_par04)% AND
    SD1.D1_COD >= %Exp:mv_par05% AND SD1.D1_COD <= %Exp:mv_par06% AND
    SD1.D1_TIPO = 'D' AND
	%Exp:cWhere% AND		    
    SD1.%NotDel%
ORDER BY SD1.D1_FILIAL,SD1.D1_FORNECE,SD1.D1_LOJA,SD1.D1_COD
EndSql
oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)

U_A780CriaTmp({"D1_FILIAL","D1_FORNECE","D1_LOJA","D1_COD"}, aStru, cSD1, cALiasSD1 )
    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta filtro para processar as vendas por cliente            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SD2")
cFiltro := SD2->(dbFilter())
If Empty(cFiltro)
	bFiltro := { || .T. }
Else
	cFiltro := "{ || " + cFiltro + " }"
	bFiltro := &(cFiltro)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta filtro para processar as vendas por cliente            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SD2")
            

    cSD2   := "SD2TMP"
    aStru  := dbStruct()
    cWhere := "%NOT ("+IsRemito(3,'SD2.D2_TIPODOC')+ ")%"
    oReport:Section(3):BeginQuery()
    BeginSql Alias cAliasSD2
    SELECT * 
    FROM %Table:SD2% SD2
    WHERE SD2.D2_FILIAL = %xFilial:SD2% AND
    	SD2.D2_CLIENTE BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
    	SD2.D2_EMISSAO BETWEEN %Exp:DTOS(mv_par03)% AND %Exp:DTOS(mv_par04)% AND
    	SD2.D2_COD     BETWEEN %Exp:mv_par05% AND %Exp:mv_par06% AND
    	SD2.D2_TIPO <> 'B' AND SD2.D2_TIPO <> 'D' AND
    	%Exp:cWhere% AND
    	SD2.%NotDel%
    ORDER BY SD2.D2_FILIAL,SD2.D2_CLIENTE,SD2.D2_LOJA,SD2.D2_COD,SD2.D2_ITEM
    EndSql
    oReport:Section(3):EndQuery()

    U_A780CriaTmp({"D2_FILIAL","D2_CLIENTE","D2_LOJA","D2_COD","D2_SERIE","D2_DOC","D2_ITEM"}, aStru, cSD2, cAliasSD2)
  

dbSelectArea("SA1")
dbSetOrder(1)

oReport:Section(1):BeginQuery()  
   
BeginSql Alias cALiasSA1

	SELECT A1_FILIAL,A1_COD,A1_LOJA,A1_NOME,A1_OBSERV
    FROM %Table:SA1% SA1
    WHERE SA1.A1_FILIAL = %xFilial:SA1% AND
    SA1.A1_COD >= %Exp:MV_PAR01% AND
	SA1.A1_COD <= %Exp:MV_PAR02% AND
    SA1.%NotDel%
    ORDER BY A1_FILIAL,A1_COD
    
EndSql
 
oReport:Section(1):EndQuery()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se aglutinara produtos de Grade                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(RecCount())		// Total de Elementos da regua

If MV_PAR12 == 1
	lGrade := .T.
Endif

TRPosition():New(oReport:Section(1):Section(1),"SD1",2,{||IIF((cTipoNf $ "SD1"),SD1->(DBSeek((cSD1)->(D1_FILIAL+D1_COD+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA))),IIF(SA1->(!EOF()),(SA1->(DbGoBottom()),SA1->(DbSkip())),.T.))},.F.)
TRPosition():New(oReport:Section(1):Section(1),"SD2",3,{||IIF((cTipoNf $ "SD2"),SD2->(DBSeek((cSD2)->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM))),IIF(SA1->(!EOF()),(SA1->(DbGoBottom()),SA1->(DbSkip())),.T.))},.F.)

While !oReport:Cancel() .And. (cAliasSA1)->( ! EOF() .AND. A1_COD <= MV_PAR02 ) .And. (cAliasSA1)->A1_FILIAL == cFilSA1
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura pelas saidas daquele cliente                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTipoNf := ""
	DbSelectArea(cSD2)
	If DbSeek(cFilSD2+(cAliasSA1)->A1_COD+(cAliasSA1)->A1_LOJA)
		cTipoNf := "SD2" 
		lRet:=ValidMasc((cSD2)->D2_COD,MV_PAR11)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Montagem da quebra do relatorio por  Cliente             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cClieAnt := (cAliasSA1)->A1_COD
		cLojaAnt := (cAliasSA1)->A1_LOJA
		lNewProd := .T.
		lNewCli  := .T.
		While !oReport:Cancel() .And.!Eof() .and. ;
			((cSD2)->(D2_FILIAL+D2_CLIENTE+D2_LOJA)) == (cFilSD2+cClieAnt+cLojaAnt)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica Se eh uma tipo de nota valida                   ³
			//³ Verifica intervalo de Codigos de Vendedor                ³
			//³ Valida o produto conforme a mascara                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			lRet:=ValidMasc((cSD2)->D2_COD,MV_PAR11)
			If	! Eval(bFiltro) .Or. !U_A780Vend(@cVends,nVend,cFilSF2) .Or. !lRet //.or. SD2->D2_TIPO$"BD" ja esta no filtro
				dbSkip()
				Loop
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao da quebra por produto e NF                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If (cSD2)->D2_GRADE == "S" .And. lGrade
				bGrade := { || Substr((cSD2)->D2_COD, 1, nTamref) }
			Else
				bGrade := { || (cSD2)->D2_COD }
			Endif

			cProdAnt := Eval(bGrade)
			lNewProd := .T.
			oReport:Section(1):Section(1):Init()
			While !oReport:Cancel() .And. ! Eof() .And. ;
				(cSD2)->(D2_FILIAL + D2_CLIENTE + D2_LOJA  + EVAL(bGrade) ) == ;
				( cFilSD2 + cClieAnt   + cLojaAnt + cProdAnt )
				oReport:IncMeter()
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Avalia TES                                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				lRet:=ValidMasc((cSD2)->D2_COD,MV_PAR11)
				If !AvalTes((cSD2)->D2_TES,cEstoq,cDupli) .Or. !Eval(bFiltro) .Or. !lRet
					dbSkip()
					Loop
				Endif
				
				If !U_A780Vend(@cVends,nVend,cFilSF2)
					dbskip()
					Loop
				Endif
				
				If lNewCli
					oReport:Section(1):Init()
					oReport:Section(1):PrintLine()
					lNewCli := .F.
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Se mesmo produto inibe impressao do codigo e descricao   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lNewProd
					lNewProd := .F.
					oReport:Section(1):Section(1):Cell("CCODPROD"	):Show()
					oReport:Section(1):Section(1):Cell("CDESCPROD"	):Show()
				//Se for tipo planilha e estilo relatório em formato de tabela.	
				ElseIf	oReport:nDevice == 4 .AND. oReport:nXlsStyle == 1
					oReport:Section(1):Section(1):Cell("CCODPROD"	):Show()
					oReport:Section(1):Section(1):Cell("CDESCPROD"	):Show()					
				Else
					oReport:Section(1):Section(1):Cell("CCODPROD"	):Hide()
					oReport:Section(1):Section(1):Cell("CDESCPROD"	):Hide()
				EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Caso seja grade aglutina todos produtos do mesmo Pedido  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If (cSD2)->D2_GRADE == "S" .And. lGrade  // Aglutina Grade
					bGrade := { || Substr((cSD2)->D2_COD, 1, nTamref) }

					cProdRef:= Substr((cSD2)->D2_COD,1,nTamRef)
					cNumPed := (cSD2)->D2_PEDIDO
					nReg    := 0
					nDevQtd := 0
					nDevVal := 0
					
					While !oReport:Cancel() .And. !Eof() .And. cProdRef == Eval(bGrade) .And.;
						(cSD2)->D2_GRADE == "S" .And. cNumPed == (cSD2)->D2_PEDIDO .And.;
						(cSD2)->D2_FILIAL == cFilSD2
						
						nReg := Recno()
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valida o produto conforme a mascara         ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						lRet:=ValidMasc((cSD2)->D2_COD,MV_PAR11)
						If !lRet .Or. !Eval(bFiltro)
							dbSkip()
							Loop
						EndIf
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Tratamento das Devolu‡oes   ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If mv_par10 == 1 //inclui Devolucoes
							SomaDev(@nDevQtd, @nDevVal , @aDev, cEstoq, cDupli,cFilSD1, cFilSD2, cFilSF1, @nRecSD2)
						EndIf
						
						(cSD2)->(DbGoTo(nReg))
						nTotQuant += (cSD2)->D2_QUANT
						dbSkip()
						
					EndDo
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se processou algum registro        ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If nReg > 0
						dbGoto(nReg)
						nReg:=0
					EndIf
					
				Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Tratamento das devolucoes   ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					bGrade := { || (cSD2)->D2_COD }
					nDevQtd :=0
					nDevVal :=0
					nReg := Recno()
					If mv_par10 == 1 //inclui Devolucoes
						SomaDev(@nDevQtd, @nDevVal , @aDev, cEstoq, cDupli,cFilSD1, cFilSD2, cFilSF1, @nRecSD2)
					EndIf
					
					(cSD2)->(DbGoTo(nReg))
					nTotQuant := (cSD2)->D2_QUANT
					
				EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime os dados da NF                                   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				SB1->(dbSeek(cFilSB1 +(cSD2)->D2_COD))
				If mv_par16 = 1
					cDescProd := SB1->B1_DESC
				Else
					If SA7->(dbSeek(cFilSA7+(cSD2)->(D2_COD+D2_CLIENTE+D2_LOJA)))
						cDescProd := SA7->A7_DESCCLI
					Else
						cDescProd := SB1->B1_DESC
					Endif
				EndIf
				
				SF2->(dbSeek(cFilSF2+(cSD2)->(D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)))
				cUM      := (cSD2)->D2_UM
				cDoc     := (cSD2)->D2_DOC
				cSerie   := (cSD2)->&(SerieNfId("SD2",3,"D2_SERIE"))
				dEmissao := (cSD2)->D2_EMISSAO
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Faz Verificacao da Moeda Escolhida e Imprime os Valores  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nVlrUnit := xMoeda((cSD2)->D2_PRCVEN,SF2->F2_MOEDA,MV_PAR09,(cSD2)->D2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)
				If lValadi
					nValadi := xMoeda((cSD2)->D2_VALADI,SF2->F2_MOEDA,MV_PAR09,(cSD2)->D2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)
				EndIf
				If (cSD2)->D2_TIPO $ "CIP" 
					If cPaisLoc == "BRA"
						If (cSD2)->D2_TIPO $ "C" .And. SF2->F2_TPCOMPL == "2"	//Complemento de Quantidade
							nVlrTot:= nTotQuant * nVlrUnit
						Else
							nVlrTot:= nVlrUnit
						EndIf
					ElseIf (cSD2)->D2_TIPO $ "C" 
						nVlrTot:= nTotQuant * nVlrUnit
					EndIf	
				Else	
					If (cSD2)->D2_GRADE == "S" .And. MV_PAR12 == 1 // Aglutina Grade
						nVlrTot:= nVlrUnit * nTotQuant
					Else
						nVlrTot:=xmoeda((cSD2)->D2_TOTAL,SF2->F2_MOEDA,mv_par09,(cSD2)->D2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)
					EndIf
				EndIf
				
				If (cSD2)->D2_GRADE == "S" .And. lGrade
					bGrade := { || Substr((cSD2)->D2_COD, 1, nTamref) }
				Else
					bGrade := { || (cSD2)->D2_COD }
				Endif				
				cCodProd 	:= Eval(bGrade)
				U_A780Vend(@cVends,nVend,cFilSF2)  
				cVendedores := cVends
				cVends 		:= Subs(cVendedores,1,7)
				oReport:Section(1):Section(1):PrintLine()
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Impressao dos Vendedores                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oReport:section(1):section(1):Cell("CCODPROD"	):Hide()
				oReport:section(1):section(1):Cell("CDESCPROD"	):Hide()
				oReport:section(1):section(1):Cell("CDOC"		):Hide()
				oReport:section(1):section(1):Cell("CSERIE"	):Hide()
				oReport:section(1):section(1):Cell("DEMISSAO"	):Hide()
				oReport:section(1):section(1):Cell("CUM"		):Hide()
				oReport:section(1):section(1):Cell("NTOTQUANT"	):Hide()
				oReport:section(1):section(1):Cell("NVLRUNIT"	):Hide()
				If lValadi
					oReport:section(1):section(1):Cell("NVALADI"	):Hide()
				EndIf
				oReport:section(1):section(1):Cell("NVLRTOT"	):Hide()
				
				nTotQuant := 0		// Zera variaveis para que nao sejam somadas novamente nos totalizadores
				nVlrTot   := 0		// na impressao dos outros vendedores
				For nV := 8 to Len(cVendedores)
					cVends := Space(20)+Subs(cVendedores,nV,7)
				   	oReport:Section(1):Section(1):PrintLine()
					nV += 6
				Next
				
				oReport:section(1):section(1):Cell("CCODPROD"	):Show()
				oReport:section(1):section(1):Cell("CDESCPROD"	):Show()
				oReport:section(1):section(1):Cell("CDOC"		):Show()
				oReport:section(1):section(1):Cell("CSERIE"	):Show()
				oReport:section(1):section(1):Cell("DEMISSAO"	):Show()
				oReport:section(1):section(1):Cell("CUM"		):Show()
				oReport:section(1):section(1):Cell("NTOTQUANT"	):Show()
				oReport:section(1):section(1):Cell("NVLRUNIT"	):Show()
				If lValadi
					oReport:section(1):section(1):Cell("NVALADI"	):Show()
				EndIf
				oReport:section(1):section(1):Cell("NVLRTOT"	):Show()
				

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime as devolucoes do produto selecionado             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nDevQtd!=0
					ncSD2RecOri := (cSD2)->(Recno())
                    SD2->(DbGoTo(nRecSD2))
					(cSD2)->(DbSeek(xFilial("SD2")+SD2->D2_FILIAL+SD2->D2_CLIENTE+SD2->D2_LOJA+SD2->D2_COD+SD2->D2_SERIE+SD2->D2_DOC+SD2->D2_ITEM))
					cSerie 	:= STR0025	// "DEV"
					nVlrTot   := nDevVal
					nTotQuant := nDevQtd   

					oReport:Section(1):Section(1):Cell("CDOC"		):Hide()
					oReport:Section(1):Section(1):Cell("DEMISSAO"	):Hide()
					oReport:Section(1):Section(1):Cell("NVLRUNIT"	):Hide()
					If lValadi
						oReport:section(1):section(1):Cell("NVALADI"	):Hide()
					EndIf
					oReport:Section(1):Section(1):Cell("CVENDS"	):Hide()
					
					oReport:Section(1):Section(1):PrintLine()
					
					oReport:Section(1):Section(1):Cell("CDOC"		):Show()
					oReport:Section(1):Section(1):Cell("DEMISSAO"	):Show()
					oReport:Section(1):Section(1):Cell("NVLRUNIT"	):Show()
					If lValadi
						oReport:section(1):section(1):Cell("NVALADI"	):Show()
					EndIf
					oReport:Section(1):Section(1):Cell("CVENDS"	):Show()
					(cSD2)->(DbGoTo(ncSD2RecOri))
				EndIf
				nTotQuant := 0
				dbSkip()
				
			EndDo
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime o total do produto selecionado                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oReport:Section(1):Section(1):SetTotalText(STR0022 + cProdAnt)	// "TOTAL DO PRODUTO - "
			oReport:Section(1):Section(1):Finish()
			
		EndDo
		oReport:Section(1):SetTotalText(STR0023 + cClieAnt)	// "TOTAL DO CLIENTE - "
		cClieAnt := ""
		cLojaAnt := ""
		
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura pelas devolucoes dos clientes que nao tem NF SAIDA  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea(cSD1)
	If DbSeek(cFilSD1+(cAliasSA1)->A1_COD+(cAliasSA1)->A1_LOJA)
		cTipoNf := "SD1"
		lRet:=ValidMasc((cSD1)->D1_COD,MV_PAR11)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Procura as devolucoes do periodo, mas que nao pertencem  ³
		//³ as NFS ja impressas do cliente selecionado               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par10 == 1  // Inclui Devolucao
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Soma Devolucoes          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oReport:Section(1):Init()
			While !oReport:Cancel() .And. (cSD1)->(D1_FILIAL + D1_FORNECE + D1_LOJA) == ;
				( cFilSD1 + (cAliasSA1)->A1_COD+ (cAliasSA1)->A1_LOJA)  .AND. ! Eof()
				lRet:=ValidMasc((cSD1)->D1_COD,MV_PAR11)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica Vendedores da N.F.Original ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				
				CtrlVndDev := .F.
				lNfD2Ori   := .F.
				If AvalTes((cSD1)->D1_TES,cEstoq,cDupli)
					dbSelectArea("SD2")
					nSavOrd := IndexOrd()
					dbSetOrder(3)

					dbSeek(cFilSD2+(cSD1)->(D1_NFORI+D1_SERIORI+D1_FORNECE+D1_LOJA+D1_COD))
					While !oReport:Cancel() .And. !SD2->(Eof()) .And. ((cSD1)->(D1_FILIAL+D1_NFORI+D1_SERIORI+D1_FORNECE+D1_LOJA+D1_COD)) == ;
					SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD)
					
						lRet:=ValidMasc((cSD1)->D1_COD,MV_PAR11)
					
						If !Empty((cSD1)->D1_ITEMORI) .AND. AllTrim((cSD1)->D1_ITEMORI) != D2_ITEM .Or. !lRet .Or. !Eval(bFiltro)
							dbSkip()
							Loop
						Else
							CtrlVndDev := U_A780Vend(@cVends,nVend,cFilSF2)
							If Ascan(aDev,D2_CLIENTE + D2_LOJA + D2_COD + D2_DOC + D2_SERIE + D2_ITEM) > 0
								lNfD2Ori := .T.
							EndIf
						Endif
						SD2->(dbSkip())
					EndDo
					//retorna o valor anterior apos while
					SD2->(dbSetOrder(3))

					SD2->(dbSeek(cFilSD2+(cSD1)->(D1_NFORI+D1_SERIORI+D1_FORNECE+D1_LOJA+D1_COD)))
					SD2->(dbSetOrder(nSavOrd))
					dbSelectArea(cSD1)
					
					If !(CtrlVndDev) .Or. lNfD2Ori
						dbSkip()
						Loop					
					EndIf
				
					SF1->(dbSeek(cFilSF1+(cSD1)->(D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA)))
					cUM := (cSD1)->D1_UM
					cDoc := (cSD1)->D1_DOC
					cSerie := (cSD1)->&(SerieNfId("SD1",3,"D1_SERIE"))
					dEmissao := (cSD1)->D1_EMISSAO
					nVlrTot:=xMoeda((cSD1)->(D1_TOTAL-D1_VALDESC),SF1->F1_MOEDA,mv_par09,(cSD1)->D1_DTDIGIT,nDecs+1,SF1->F1_TXMOEDA)
					If (SD2TMP->(EOF()) .And. SD1TMP->(!EOF())) .Or. (SD2TMP->(!EOF()) .And. SD1TMP->(!EOF()))
						
						If !lNewCli .And. cClieAnt <> (cAliasSA1)->A1_COD 
							lNewCli := .T.
						Endif

						cClieAnt := (cAliasSA1)->A1_COD
						cLojaAnt := (cAliasSA1)->A1_LOJA

						If lNewCli
							oReport:Section(1):Init()
							oReport:Section(1):PrintLine()							
							lNewCli := .F.
						EndIf

						cCodProd := D1_COD
						cDescProd := STR0025	// "DEV"
						cDoc := D1_DOC
						cSerie := SerieNfId(cSD1,2,"D1_SERIE")
						dEmissao := D1_EMISSAO
						cUM := D1_UM
						nTotQuant := D1_QUANT * -1
						nVlrUnit := xMoeda((D1_VUNIT - D1_VALDESC),SF1->F1_MOEDA,mv_par09,(cSD1)->D1_DTDIGIT,nDecs+1,SF1->F1_TXMOEDA) * -1
						nVlrTot  := xMoeda((D1_TOTAL - D1_VALDESC),SF1->F1_MOEDA,mv_par09,(cSD1)->D1_DTDIGIT,nDecs+1,SF1->F1_TXMOEDA) * -1
						cVends := cVends  
						oReport:Section(1):Section(1):Init()
						oReport:Section(1):SetTotalText(STR0023 + cClieAnt)	// "TOTAL DO CLIENTE - "
					EndIf
					oReport:Section(1):Section(1):PrintLine()
				Endif
				(cSD1)->(dbSkip())
			EndDo
			oReport:Section(1):Section(1):SetTotalText(STR0022 + cCodProd)
			oReport:Section(1):Section(1):Finish()
		EndIf
		
	EndIf
	If !lNewCli		
		oReport:section(1):Finish()
	EndIf	
	
	DbSelectArea(cAliasSA1)
	DbSkip()
EndDo

If( valtype(oTmpTab_1) == "O")
	oTmpTab_1:Delete()
	freeObj(oTmpTab_1)
	oTmpTab_1 := nil
EndIf

If( valtype(oTmpTab_2) == "O")
	oTmpTab_2:Delete()
	freeObj(oTmpTab_2)
	oTmpTab_2 := nil
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A780Vend ³ Autor ³ Rogerio F. Guimaraes  ³ Data ³ 28.10.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica Intervalo de Vendedores                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR780			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function A780Vend(cVends,nVend, cFilSF2)
Local cAlias:=Alias(),sVend,sCampo
Local lVend, cVend, cBusca
Local nx

Default cFilSF2 := xFilial("SF2")

lVend  := .F.
cVends := ""
// Nao tem Alias na frente dos campos do SD2 para poder trabalhar em DBF e TOP
cBusca := cFilSF2+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA
dbSelectArea("SF2")
If dbSeek(cBusca)
	cVend := "1"
	For nx := 1 to nVend
		sCampo := "F2_VEND" + cVend
		sVend := FieldGet(FieldPos(sCampo))
		If (sVend >= mv_par07 .And. sVend <= mv_par08) .And. (!Empty(sVend))
			cVends += If(Len(cVends)>0,"/","") + sVend
		EndIf
		If (sVend >= mv_par07 .And. sVend <= mv_par08) .And. (nX == 1 .Or. !Empty(sVend))
			lVend := .T.
		EndIf
		cVend := Soma1(cVend, 1)
	Next
EndIf
dbSelectArea(cAlias)
Return(lVend)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ SomaDev  ³ Autor ³ Claudecino C Leao     ³ Data ³ 28.09.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Soma devolucoes de Vendas                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR780			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function SomaDev(nDevQtd, nDevVal, aDev, cEstoq, cDupli, cFilSD1, cFilSD2, cFilSF1, nRecSD2 )

Local DtMoedaDev  := (cSD2)->D2_EMISSAO

Default cFilSD1		:= xFilial("SD1")
Default cFilSD2		:= xFilial("SD2")
Default cFilSF1		:= xFilial("SF1")
Default nRecSD2 	:= 0

If (cSD1)->(dbSeek(cFilSD1+(cSD2)->(D2_CLIENTE + D2_LOJA + D2_COD )))
    nRecSD2 := 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Soma Devolucoes          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While (cSD1)->(D1_FILIAL+D1_FORNECE+D1_LOJA+D1_COD) == (cSD2)->( cFilSD2 +D2_CLIENTE+D2_LOJA+D2_COD).AND.!(cSD1)->(Eof())                   
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia TES                                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !AvalTes((cSD1)->D1_TES,cEstoq,cDupli)
	        (cSD1)->(dbSkip())
			Loop
		Endif
	
        DtMoedaDev  := IIF(MV_PAR17 == 1,(cSD1)->D1_DTDIGIT,(cSD2)->D2_EMISSAO)

		SF1->(dbSeek(cFilSF1+(cSD1)->(D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA)))

		If (cSD1)->(D1_NFORI + D1_SERIORI + AllTrim(D1_ITEMORI)) == (cSD2)->(D2_DOC   + D2_SERIE   + D2_ITEM )

			Aadd(aDev, (cSD1)->(D1_FORNECE + D1_LOJA + D1_COD + D1_NFORI + D1_SERIORI + AllTrim(D1_ITEMORI)))
			nDevQtd -= (cSD1)->D1_QUANT
			nDevVal -=xMoeda((cSD1)->(D1_TOTAL-D1_VALDESC),SF1->F1_MOEDA,mv_par09,DtMoedaDev,nDecs+1,SF1->F1_TXMOEDA)

		ElseIf mv_par15 == 2 .And. (cSD1)->D1_DTDIGIT < (cSD2)->D2_EMISSAO .And.;
			   (cSD1)->(D1_NFORI + D1_SERIORI + AllTrim(D1_ITEMORI)) < ;
			   (cSD2)->(D2_DOC   + D2_SERIE   + D2_ITEM ) .And.;
			   Ascan(aDev, (cSD1)->(D1_FORNECE + D1_LOJA + D1_COD + D1_NFORI + D1_SERIORI + AllTrim(D1_ITEMORI))) == 0

            SD2->(DbSeek(cFilSD2+(cSD1)->(D1_NFORI + D1_SERIORI + D1_FORNECE + D1_LOJA + D1_COD + AllTrim(D1_ITEMORI))))
            nRecSD2 := SD2->(Recno())
			Aadd(aDev, (cSD1)->(D1_FORNECE + D1_LOJA + D1_COD + D1_NFORI + D1_SERIORI + AllTrim(D1_ITEMORI)))
			nDevQtd -= (cSD1)->D1_QUANT
			nDevVal -=xMoeda((cSD1)->(D1_TOTAL-D1_VALDESC),SF1->F1_MOEDA,mv_par09,DtMoedaDev,nDecs+1,SF1->F1_TXMOEDA)

		EndIf

        (cSD1)->(dbSkip())

	EndDo

EndIf
Return .t.
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³A780CriaTmp³ Autor ³ Rubens Joao Pante     ³ Data ³ 04/07/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cria temporario a partir da consulta corrente (TOP)          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³U_MATR780 (TOPCONNECT)                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function A780CriaTmp(aIndice, aStruTmp, cAliasTmp, cAlias)
	
	Local nI, nF, nPos
	Local cFieldName := ""
	nF := (cAlias)->(Fcount())
	
    //-------------------------------------------------------------------
	// Instancia tabela temporária.  
	//-------------------------------------------------------------------
	If( valtype(oTmpTab_1) == "O")
		oTmpTab_2	:= FWTemporaryTable():New( cAliasTmp )
		
		oTmpTab_2:SetFields( aStruTmp )
		oTmpTab_2:AddIndex("1",aIndice)
		oTmpTab_2:Create()
	Else
		oTmpTab_1	:= FWTemporaryTable():New( cAliasTmp )
		
		oTmpTab_1:SetFields( aStruTmp )
		oTmpTab_1:AddIndex("1",aIndice)
		oTmpTab_1:Create()
	EndIf


	(cAlias)->(DbGoTop())
	While ! (cAlias)->(Eof())
        (cAliasTmp)->(DbAppend())
		For nI := 1 To nF 
			cFieldName := (cAlias)->( FieldName( ni ))
		    If (nPos := (cAliasTmp)->(FieldPos(cFieldName))) > 0
		   		    (cAliasTmp)->(FieldPut(nPos,(cAlias)->(FieldGet((cAlias)->(FieldPos(cFieldName))))))
            EndIf   		
		Next
		(cAlias)->(DbSkip())
	End
	(cAlias)->(dbCloseArea())
    DbSelectArea(cAliasTmp)
Return Nil	


