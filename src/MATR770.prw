/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR770.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR770  ³ Autor ³ Marco Bianchi         ³ Data ³ 18/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o da rela‡„o das Devolucoes.                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR770()                                   		

Local oReport := Nil

Pergunte("MTR770", .F.)

//-- Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()


Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 18/07/06 ³±±
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
Local oNotaDev
Local oTitulos   
Local oCellCod
Local cAliasSF1 := GetNextAlias()
Local cAliasSD1 := cAliasSF1
Local cAliasSA1 := cAliasSF1
Local cAliasSB1 := cAliasSF1
Local cAliasSE1 := GetNextAlias()


Local nIPI     := 0
Local nDecs    := 0
Local nTamData := Len(DTOC(MsDate()))

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
oReport := TReport():New("MATR770",STR0014,"MTR770", {|oReport| ReportPrint(oReport,oNotaDev,cAliasSF1,cAliasSD1,cAliasSA1,cAliasSB1,cAliasSE1,oTitulos,nDecs)},STR0015 + " " + STR0016)	// "Relacao das Devolucoes de Vendas"###"Este relatório irá imprimir a relaçäo de itens"###"referentes as devoluçóes de vendas."
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                         		       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(oReport:uParam,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         		   ³
//³ mv_par01             // Data digitacao De         	         		   ³
//³ mv_par02             // Data digitacao Ate                   		   ³
//³ mv_par03             // Fornec. de                           		   ³
//³ mv_par04             // Fornec. Ate                          		   ³
//³ mv_par05             // Loja de                              		   ³
//³ mv_par06             // Loja Ate                             		   ³
//³ mv_par07             // CFO de                               		   ³
//³ mv_par08             // CFO Ate                              		   ³
//³ mv_par09             // Qual moeda                           		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
//³ Definicao da Secao 1 - Notas de Devolucao                 			   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oNotaDev := TRSection():New(oReport,STR0021,{"SF1","SD1","SB1","SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/,,,,,,.T. )	// "Relacao das Devolucoes de Vendas"
oNotaDev:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao das Celulas da Secao 1 - Notas de Devolucao                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oNotaDev,"D1_DOC"		,"SD1"		,RetTitle("D1_DOC"		),PesqPict("SD1","D1_DOC"				),TamSx3("D1_DOC"		)[1],/*lPixel*/,{|| (cAliasSD1)->D1_DOC 	},,,,,,.F.)
oCellCod := TRCell():New(oNotaDev,"D1_COD"		,"SD1"		,RetTitle("D1_COD"		),PesqPict("SD1","D1_COD"	),TamSx3("D1_COD"		)[1],/*lPixel*/,{|| (cAliasSD1)->D1_COD 		},,,,,,.F.)
TRCell():New(oNotaDev,"B1_DESC"		,"SB1"		,RetTitle("B1_DESC"		),PesqPict("SB1","B1_DESC"				),TamSx3("B1_DESC"		)[1],/*lPixel*/,{|| (cAliasSB1)->B1_DESC	},,.T.,,,,.T.)
TRCell():New(oNotaDev,"D1_QUANT"	,"SD1"		,RetTitle("D1_QUANT"	),PesqPict("SD1","D1_QUANT"				),TamSx3("D1_QUANT"		)[1],/*lPixel*/,{|| (cAliasSD1)->D1_QUANT 	},,,"RIGHT",,,.T.)
TRCell():New(oNotaDev,"B1_UM"		,"SB1"		,RetTitle("B1_UM"		),PesqPict("SB1","B1_UM"				),TamSx3("B1_UM"		)[1],/*lPixel*/,{|| (cAliasSB1)->B1_UM },,,,,,.T.)
TRCell():New(oNotaDev,"D1_VUNIT"	,"SD1"		,RetTitle("D1_VUNIT"	),PesqPict("SD1","D1_VUNIT",14,mv_par09),TamSx3("D1_VUNIT"		)[1],/*lPixel*/,{|| xMoeda((cAliasSD1)->D1_VUNIT,(cAliasSF1)->F1_MOEDA,mv_par09,(cAliasSD1)->D1_DTDIGIT,nDecs+1,(cAliasSF1)->F1_TXMOEDA) 	},,,"RIGHT",,,.T.)
TRCell():New(oNotaDev,"NIPI"		,/*Tabela*/	,RetTitle("D1_IPI"		),PesqPict("SD1","D1_IPI"				),TamSx3("D1_IPI"		)[1],/*lPixel*/,{|| nIPI	},,,"RIGHT",,,.F.)
TRCell():New(oNotaDev,"D1_TOTAL"	,"SD1"		,RetTitle("D1_TOTAL"	),PesqPict("SD1","D1_TOTAL",16,mv_par09),TamSx3("D1_TOTAL"		)[1],/*lPixel*/,{|| xMoeda(((cAliasSD1)->D1_TOTAL-(cAliasSD1)->D1_VALDESC),(cAliasSF1)->F1_MOEDA,mv_par09,(cAliasSD1)->D1_DTDIGIT,nDecs+1,(cAliasSF1)->F1_TXMOEDA)	},,,"RIGHT",,,.T.)
If ( cPaisLoc=="BRA" )
	TRCell():New(oNotaDev,"D1_PICM"	,"SD1"		,RetTitle("D1_PICM"		),PesqPict("SD1","D1_PICM"				),TamSx3("D1_PICM"		)[1],/*lPixel*/,{|| (cAliasSD1)->D1_PICM },,,"RIGHT",,,.F.)
EndIf	
TRCell():New(oNotaDev,"D1_FORNECE"	,"SD1"		,RetTitle("D1_FORNECE"	),PesqPict("SD1","D1_FORNECE"			),TamSx3("D1_FORNECE"	)[1],/*lPixel*/,{|| (cAliasSD1)->D1_FORNECE 	},,,,,,.T.)
TRCell():New(oNotaDev,"A1_NOME"		,"SA1"		,RetTitle("A1_NOME"		),PesqPict("SA1","A1_NOME"				),TamSx3("A1_NOME"		)[1],/*lPixel*/,{|| (cAliasSA1)->A1_NOME },,.T.,,,,.T.)
TRCell():New(oNotaDev,"D1_TIPO"		,"SD1"		,RetTitle("D1_TIPO"		),PesqPict("SD1","D1_TIPO"				),TamSx3("D1_TIPO"		)[1],/*lPixel*/,{|| (cAliasSD1)->D1_TIPO },,,,,,.T.)
TRCell():New(oNotaDev,"D1_TES"		,"SD1"		,RetTitle("D1_TES"		),PesqPict("SD1","D1_TES"				),TamSx3("D1_TES"		)[1],/*lPixel*/,{|| (cAliasSD1)->D1_TES 			},,,,,,.T.)
TRCell():New(oNotaDev,"D1_TP"		,"SD1"		,RetTitle("D1_TP"		),PesqPict("SD1","D1_TP"				),TamSx3("D1_TP"		)[1],/*lPixel*/,{|| (cAliasSD1)->D1_TP 		},,,,,,.T.)
TRCell():New(oNotaDev,"D1_GRUPO"	,"SD1"		,RetTitle("D1_GRUPO"	),PesqPict("SD1","D1_GRUPO"				),TamSx3("D1_GRUPO"		)[1],/*lPixel*/,{|| (cAliasSD1)->D1_GRUPO},,,,,,.T.)
TRCell():New(oNotaDev,"D1_DTDIGIT"	,"SD1"		,RetTitle("D1_DTDIGIT"	),PesqPict("SD1","D1_DTDIGIT"			),nTamData					 ,/*lPixel*/,{|| (cAliasSD1)->D1_DTDIGIT },,,,,,.T.)
TRCell():New(oNotaDev,"NCUSTO"		,/*Tabela*/	,RetTitle("D1_CUSTO"	),PesqPict("SD1","D1_CUSTO",14,mv_par09),TamSx3("D1_CUSTO"		)[1],/*lPixel*/,{|| If(mv_par09==1,(cAliasSD1)->D1_CUSTO,&("D1_CUSTO"+Str(mv_par09,1)))},,,"RIGHT",,,.T.)
TRCell():New(oNotaDev,"D1_NFORI"	,"SD1"		,RetTitle("D1_NFORI"	),PesqPict("SD1","D1_NFORI"				),TamSx3("D1_NFORI"		)[1],/*lPixel*/,{|| (cAliasSD1)->D1_NFORI	},,,,,,.F.)
TRCell():New(oNotaDev,"D1_SERIORI"	,"SD1"		,RetTitle("D1_SERIORI"	),PesqPict("SD1","D1_SERIORI"			),TamSx3("D1_SERIORI"	)[1],/*lPixel*/,{|| (cAliasSD1)->D1_SERIORI	},,,,,,.F.)
                      
oReport:Section(1):SetHeaderPage()		// Cabecalho da secao no topo da pegina 
oCellCod:nHeaderSize := TamSx3( "D1_COD" )[1]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao das Celulas dsa Secao 2 - Titulos da Nota de Saida           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTitulos := TRSection():New(oReport,STR0022,{"SE1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Relacao das Devolucoes de Vendas"
oTitulos:SetTotalInLine(.F.)

TRCell():New(oTitulos,"E1_PREFIXO"	,"SE1",RetTitle("E1_PREFIXO"	),PesqPict("SE1","E1_PREFIXO"			),TamSx3("E1_PREFIXO"	)[1],/*lPixel*/,{|| (cAliasSE1)->E1_PREFIXO 																})
TRCell():New(oTitulos,"E1_NUM"		,"SE1",RetTitle("E1_NUM"		),PesqPict("SE1","E1_NUM"				),TamSx3("E1_NUM"		)[1],/*lPixel*/,{|| (cAliasSE1)->E1_NUM 																	})
TRCell():New(oTitulos,"E1_PARCELA"	,"SE1",RetTitle("E1_PARCELA"	),PesqPict("SE1","E1_PARCELA"			),TamSx3("E1_PARCELA"	)[1],/*lPixel*/,{|| (cAliasSE1)->E1_PARCELA 																})
TRCell():New(oTitulos,"E1_VENCTO"	,"SE1",RetTitle("E1_VENCTO"		),PesqPict("SE1","E1_VENCTO"			),TamSx3("E1_VENCTO"	)[1],/*lPixel*/,{|| (cAliasSE1)->E1_VENCTO 																})
TRCell():New(oTitulos,"E1_SALDO"		,"SE1",RetTitle("E1_SALDO"		),PesqPict("SE1","E1_SALDO",14,mv_par09	),TamSx3("E1_SALDO"		)[1],/*lPixel*/,{|| xMoeda((cAliasSE1)->E1_SALDO,(cAliasSE1)->E1_MOEDA,mv_par09,(cAliasSE1)->E1_EMISSAO)	})


Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 18/07/06 ³±±
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
Static Function ReportPrint(oReport,oNotaDev,cAliasSF1,cAliasSD1,cAliasSA1,cAliasSB1,cAliasSE1,oTitulos,nDecs)

Local nX 	  	:= 0
Local nImpInc 	:= 0
Local nValMerc	:= 0
Local nFrete	:= 0
Local nDespesa	:= 0
Local nValIPI	:= 0
Local nICMSRet	:= 0
Local nDescont	:= 0
Local nMoeda	:= 0
Local dDtDigit	:= ctod("  /  /  ")
Local nTxMoeda	:= 0
Local lDevolucao:= .F.
Local cQuebra   := ""
Local cNFOri	:= ""
Local cSeriOri	:= ""
Local nTotNota  := 0
Local nTotal    := 0
Local cSCpo		:= ""
Local cCpo		:= ""
Local cCamposD1 := ""

Local cWhere := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

oReport:Section(1):Cell("NIPI"):SetBlock({|| nIPI })
nIPI := 0
nDecs := msdecimais(mv_par09)

                                   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera titulo do relatorio de acordo com parametros                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " - " + GetMv("MV_MOEDA"+STR(mv_par09,1)))		// 	"Relacao das Devolucoes de Vendas"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Campos dos impostos variaveis                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSCpo:="1"
cCpo:="D1_VALIMP"+cSCpo
cCamposD1 := "%"
While SD1->(FieldPos(cCpo))>0
	cCamposD1 += ","+cCpo //+ " " + Substr(cCpo,4)
	cSCpo:=Soma1(cSCpo)
	cCpo:="D1_VALIMP"+cSCpo
Enddo
cCamposD1 += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cWhere := "% NOT ("+IsRemito(2,"F1_TIPODOC")+")%"
oReport:Section(1):BeginQuery()	
BeginSql Alias cAliasSF1
SELECT F1_FILIAL,F1_DTDIGIT,F1_TIPO,F1_DOC,F1_SERIE,F1_FORNECE,F1_LOJA,F1_MOEDA,F1_TXMOEDA,F1_VALMERC,
F1_FRETE,F1_DESPESA,F1_VALIPI,F1_ICMSRET,F1_DESCONT,D1_FILIAL,D1_DOC,D1_SERIE,D1_COD,D1_ITEM,D1_QUANT,D1_VUNIT,
D1_TOTAL,D1_FORNECE,D1_LOJA,D1_TIPO,D1_TES,D1_TP,D1_GRUPO,D1_DTDIGIT,D1_NFORI,D1_SERIORI,D1_ALQIMP1,D1_IPI,
D1_CUSTO,D1_CUSTO2,D1_CUSTO3,D1_CUSTO4,D1_CUSTO5,D1_VALDESC,D1_PICM,B1_DESC,B1_UM,A1_NOME %Exp:cCamposD1%
FROM %Table:SF1% SF1,%Table:SD1% SD1,%Table:SB1% SB1,%Table:SA1% SA1
WHERE F1_FILIAL = %xFilial:SF1% AND 
	F1_TIPO = "D" AND 
	F1_DTDIGIT >= %Exp:DtoS(mv_par01)% AND F1_DTDIGIT <= %Exp:DtoS(mv_par02)% AND
	F1_FORNECE >= %Exp:mv_par03% AND F1_FORNECE <= %Exp:mv_par04% AND
	F1_LOJA >= %Exp:mv_par05% AND F1_LOJA <= %Exp:mv_par06% AND
	%Exp:cWhere% AND
	SF1.%NotDel% AND 
	D1_FILIAL = %xFilial:SD1% AND 
	D1_DOC = F1_DOC AND D1_SERIE = F1_SERIE AND D1_FORNECE = F1_FORNECE AND D1_LOJA = F1_LOJA AND
	D1_CF >= %Exp:mv_par07% AND D1_CF <= %Exp:mv_par08% AND
	SD1.%NotDel% AND
	B1_FILIAL = %xFilial:SB1% AND 
	B1_COD = D1_COD AND
	SB1.%NotDel% AND 
	A1_FILIAL = %xFilial:SA1% AND 
	A1_COD = F1_FORNECE AND A1_LOJA = F1_LOJA AND
	SA1.%NotDel%
ORDER BY F1_FILIAL,F1_DOC,F1_SERIE,F1_FORNECE,F1_LOJA,F1_TIPO
EndSql 
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

TRPosition():New(oNotaDev,"SF1",1,{|| xFilial("SF1") + (cAliasSF1)->F1_DOC + (cAliasSF1)->F1_SERIE + (cAliasSF1)->F1_FORNECE + (cAliasSF1)->F1_LOJA + (cAliasSF1)->F1_TIPO })
TRPosition():New(oNotaDev,"SD1",1,{|| xFilial("SD1") + (cAliasSF1)->D1_DOC + (cAliasSF1)->D1_SERIE + (cAliasSF1)->D1_FORNECE + (cAliasSF1)->D1_LOJA + (cAliasSF1)->D1_COD + (cAliasSF1)->D1_ITEM })
TRPosition():New(oNotaDev,"SB1",1,{|| xFilial("SB1") + (cAliasSF1)->D1_COD })
TRPosition():New(oNotaDev,"SA1",1,{|| xFilial("SA1") + (cAliasSF1)->F1_FORNECE + (cAliasSF1)->F1_LOJA })
TRPosition():New(oTitulos,"SE1",1,{|| xFilial("SE1") + (cAliasSE1)->E1_PREFIXO + (cAliasSE1)->E1_NUM + (cAliasSE1)->E1_PARCELA + (cAliasSE1)->E1_TIPO })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAliasSF1)->(LastRec()))
oReport:Section(1):Init()
dbSelectArea(cAliasSF1)
dbGoTop()
While !oReport:Cancel() .And. !(cAliasSF1)->(Eof()) .And. (cAliasSF1)->F1_FILIAL == xFilial("SF1")
	
	nValMerc	:= (cAliasSF1)->F1_VALMERC
	nFrete		:= (cAliasSF1)->F1_FRETE 
	nDespesa	:= (cAliasSF1)->F1_DESPESA 
	nValIPI		:= (cAliasSF1)->F1_VALIPI 
	nICMSRet	:= (cAliasSF1)->F1_ICMSRET 
	nDescont	:= (cAliasSF1)->F1_DESCONT
	nMoeda		:= (cAliasSF1)->F1_MOEDA
	dDtDigit	:= (cAliasSF1)->F1_DTDIGIT
	nTxMoeda	:= (cAliasSF1)->F1_TXMOEDA
	cNFOri		:= (cAliasSD1)->D1_NFORI
	cSeriOri	:= BuscaPref(cNFOri,(cAliasSD1)->D1_SERIORI)
	
	nImpInc    := 0
	lDevolucao := .F.
	cQuebra    := (cAliasSD1)->D1_FILIAL+(cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA
	dbSelectArea(cAliasSD1)
	While !oReport:Cancel() .And. !Eof() .And. (cAliasSD1)->D1_FILIAL+(cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA == cQuebra
		
		
		lDevolucao := .T.
		dbSelectArea(cAliasSD1)
		If ( cPaisLoc#"BRA" )
			aImpostos:=TesImpInf(D1_TES)
			For nX:=1 to len(aImpostos)
				If ( aImpostos[nX][3]=="1")
					cCampoImp:=aImpostos[nX][2]
					nImpInc	+=	&cCampoImp
				EndIf
			Next
		EndIf
		If (cPaisLoc<>"BRA")
			nIpi:=(cAliasSD1)->D1_ALQIMP1
		Else
			nIpi:=(cAliasSD1)->D1_IPI
		EndIf
		dbSelectArea(cAliasSD1)
		
		// Impressao da nota
		oReport:Section(1):PrintLine()		
		
		dbSelectArea(cAliasSD1)
		dbSkip()

	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Quebra de Nota: Imprime Totais da Nota e Duplicata                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lDevolucao
		nTotNota:=0
		If ( cPaisLoc=="BRA" )
			nTotNota:= nValMerc + nFrete + nDespesa + nValIPI + nICMSRet - nDescont
		Else
			nTotNota:= nValMerc + nFrete + nDespesa + nImpInc - nDescont
		EndIf
		nTotNota:=xMoeda(nTotNota,nMoeda,mv_par09,dDtDigit,nDecs+1,nTXMoeda)
		nTotal  += nTotNota
		
		// Impressao dos totais
		oReport:SkipLine()
		oReport:PrintText(STR0017 + Transform(xMoeda(nDescont,nMoeda,mv_par09,dDtDigit,nDecs+1,nTXMoeda),PesqPict("SF1","F1_DESCONT",14,mv_par09)),oReport:Row(),500)	// "TOTAL DESCONTOS --> "
		oReport:Printtext(STR0018 + Transform(nTotNota,Pesqpict("SF1","F1_VALMERC",14,mv_par09)),oReport:Row(),1200)	// "TOTAL NOTA FISCAL --> "
		oReport:SkipLine()
		oReport:Printtext(STR0019)	// "Duplicatas da Nota Fiscal de Saida"
		oReport:SkipLine()
	
		// Impressao das Duplicatas
		dbSelectArea("SE1")			// Contas a Receber
		dbSetOrder(1)		  		// Prefixo,Numero,Parcela,Tipo
		oReport:Section(2):BeginQuery()
		BeginSql Alias cAliasSE1
		SELECT E1_FILIAL,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_VENCTO,E1_SALDO,E1_MOEDA,E1_EMISSAO
		FROM %Table:SE1% SE1
		WHERE E1_FILIAL = %xFilial:SE1% AND E1_NUM = %Exp:cNFOri% AND E1_PREFIXO = %Exp:cSeriOri% AND
			SE1.%Notdel%
		EndSql
		oReport:Section(2):EndQuery()
		dbSelectArea(cAliasSE1)
		If !Eof()
			oReport:Section(2):Init()
			While !oReport:Cancel() .And. !Eof() .And. E1_FILIAL+E1_PREFIXO+E1_NUM == xFilial("SE1")+cSeriOri+cNFOri
			    oReport:Section(2):PrintLine() 
				dbSkip()
			EndDo
			oReport:Section(2):Finish()
		Else
			oReport:PrintText(STR0020)		// "Nao houve titulos gerados na saida"
		EndIf
		oReport:SkipLine()
		oReport:FatLine()    
	Endif
	
	oReport:IncMeter()

EndDo
If nTotal > 0
	oReport:SkipLine()
	oReport:PrintText(STR0023 + Transform(nTotal,Pesqpict("SF1","F1_VALMERC",14,mv_par09)),oReport:Row(),1200)	// "TOTAL GERAL       --> "
EndIf
oReport:Section(1):Finish()
oReport:Section(1):SetPageBreak(.T.)

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna prefixo utilizado no titulo a pagar                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function BuscaPref(cNFOri,cSerieOri)

Local cPrefixo := ""

dbSelectArea("SF2")
dbSetOrder(1)
dbSeek(xFilial()+cNFOri+cSerieOri)
If Empty(SF2->F2_PREFIXO)
	cPrefixo := Alltrim(Posicione("SX6",1,xFilial()+"MV_1DUPREF","X6_CONTEUD"))
	If !Empty(cPrefixo)
		cPrefixo := &(cPrefixo)
	EndIf	
	If Empty(cPrefixo) //Caso não exista o parametro na filial posicionada, pega o coteudo (GetMv)
		cPrefixo := &(GetMV("MV_1DUPREF"))
	EndIf
Else
	cPrefixo := SF2->F2_PREFIXO
EndIf

Return(cPrefixo) 