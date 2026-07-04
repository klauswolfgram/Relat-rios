/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR790.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR790  ³ Autor ³ Marco Bianchi         ³ Data ³ 21/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Romaneio de Despacho  (Expedicao) - Release 4.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR790()

Local oReport

	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()


Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 21/07/06 ³±±
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

Local oReport	:= Nil
Local dEmissao	:= dDatabase
Local nTotLib	:= 0
Local nTamData	:= Len(DTOC(MsDate()))
Local lLineBreak:= .T.
Local cALiasSC9	:= ""
Local cALiasSC5	:= ""
Local cALiasSC6	:= ""
Local cALiasSF2	:= ""
Local cALiasSB1	:= ""
Local cALiasSA1	:= ""


	cALiasSC6 := GetNextAlias()
	cAliasSA1 := cALiasSC6
	cALiasSB1 := cAliasSA1
	cAliasSF2 := cALiasSB1
	cAliasSC5 := cAliasSF2
	cAliasSC9 := cAliasSC5

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
oReport := TReport():New("MATR790",STR0016,"MTR790", {|oReport| ReportPrint(oReport,cAliasSC9,cAliasSC5,cAliasSF2,cALiasSB1,cAliasSA1,cAliasSC6)},STR0017 + " " + STR0018)
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
//³ Secao 1 - Cabecalho do Pedido                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCabec := TRSection():New(oReport,STR0020,{"SC5","SF2","SA1","SA4"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oCabec:SetLineStyle(.T.)
TRCell():New(oCabec,"C5_NUM"		,/*Tabela*/	,RetTitle("C5_NUM"		),PesqPict("SC5","C5_NUM"		),TamSx3("C5_NUM"		)[1],/*lPixel*/,{|| (cAliasSC5)->C5_NUM		})
TRCell():New(oCabec,"C5_EMISSAO"	,/*Tabela*/	,RetTitle("C5_EMISSAO"	),PesqPict("SC5","C5_EMISSAO"	),nTamData                  ,/*lPixel*/,{|| (cAliasSC5)->C5_EMISSAO	})
TRCell():New(oCabec,"C5_CLIENTE"	,/*Tabela*/	,RetTitle("C5_CLIENTE"	),PesqPict("SC5","C5_CLIENTE"	),TamSx3("C5_CLIENTE"	)[1],/*lPixel*/,{|| (cAliasSC5)->C5_CLIENTE	})
TRCell():New(oCabec,"C5_LOJACLI"	,/*Tabela*/	,RetTitle("C5_LOJACLI"	),PesqPict("SC5","C5_LOJACLI"	),TamSx3("C5_LOJACLI"	)[1],/*lPixel*/,{|| (cAliasSC5)->C5_LOJACLI	})
TRCell():New(oCabec,"A1_NOME"		,/*Tabela*/	,RetTitle("A1_NOME"		),PesqPict("SA1","A1_NOME"		),TamSx3("A1_NOME"		)[1],/*lPixel*/,{|| (cAliasSA1)->A1_NOME		})
TRCell():New(oCabec,"A1_END"		,/*Tabela*/	,RetTitle("A1_END"		),PesqPict("SA1","A1_END"		),TamSx3("A1_END"		)[1],/*lPixel*/,{|| (cAliasSA1)->A1_END		})
TRCell():New(oCabec,"A1_BAIRRO"		,/*Tabela*/	,RetTitle("A1_BAIRRO"	),PesqPict("SA1","A1_BAIRRO"	),TamSx3("A1_BAIRRO"	)[1],/*lPixel*/,{|| (cAliasSA1)->A1_BAIRRO		})
TRCell():New(oCabec,"A1_MUN"		,/*Tabela*/	,RetTitle("A1_MUN"		),PesqPict("SA1","A1_MUN"		),TamSx3("A1_MUN"		)[1],/*lPixel*/,{|| (cAliasSA1)->A1_MUN		})
TRCell():New(oCabec,"A1_EST"		,/*Tabela*/	,RetTitle("A1_EST"		),PesqPict("SA1","A1_EST"		),TamSx3("A1_EST"		)[1],/*lPixel*/,{|| (cAliasSA1)->A1_EST		})
TRCell():New(oCabec,"C5_TRANSP"		,/*Tabela*/	,RetTitle("C5_TRANSP"	),PesqPict("SC5","C5_TRANSP"	),TamSx3("C5_TRANSP"	)[1],/*lPixel*/,{|| (cAliasSC5)->C5_TRANSP		})
If SA4->(FieldPos("A4_NREDUZ"))<>0
	TRCell():New(oCabec,"A4_NREDUZ"		,"SA4"		,RetTitle("A4_NREDUZ"	),PesqPict("SA4","A4_NREDUZ"	),TamSx3("A4_NREDUZ"	)[1],/*lPixel*/,{|| SA4->A4_NREDUZ			})
EndIf
TRCell():New(oCabec,"A4_VIA"		,"SA4"		,RetTitle("A4_VIA"		),PesqPict("SA4","A4_VIA"		),TamSx3("A4_VIA"		)[1],/*lPixel*/,{|| SA4->A4_VIA				})
TRCell():New(oCabec,"A4_END"		,"SA4"		,RetTitle("A4_END"		),PesqPict("SA4","A4_END"		),TamSx3("A4_END"		)[1],/*lPixel*/,{|| SA4->A4_END				})
TRCell():New(oCabec,"A4_MUN"		,"SA4"		,RetTitle("A4_MUN"		),PesqPict("SA4","A4_MUN"		),TamSx3("A4_MUN"		)[1],/*lPixel*/,{|| SA4->A4_MUN				})
TRCell():New(oCabec,"A4_EST"		,"SA4"		,RetTitle("A4_EST"		),PesqPict("SA4","A4_EST"		),TamSx3("A4_MUN"		)[1],/*lPixel*/,{|| SA4->A4_EST				})


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 2 - Itens                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oRomaneio := TRSection():New(oReport,STR0021,{"SC9","SC6","SB1"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,/*lHeaderBreak*/,/*lPageBreak*/,lLineBreak)
oRomaneio:SetTotalInLine(.F.)
TRCell():New(oRomaneio,"C9_PRODUTO"	,/*Tabela*/,RetTitle("C9_PRODUTO"	),PesqPict("SC9","C9_PRODUTO"	),TamSx3("C9_PRODUTO"	)[1],/*lPixel*/,{|| (cAliasSC9)->C9_PRODUTO													},/*cAlign*/,lLineBreak,/*cHeaderAlign*/)
TRCell():New(oRomaneio,"C6_DESCRI"	,/*Tabela*/,RetTitle("C6_DESCRI"	),PesqPict("SC6","C6_DESCRI"	),TamSx3("C6_DESCRI"	)[1],/*lPixel*/,{|| (cAliasSC6)->C6_DESCRI														},/*cAlign*/,lLineBreak,/*cHeaderAlign*/)
TRCell():New(oRomaneio,"C6_UM"		,/*Tabela*/,RetTitle("C6_UM"		),PesqPict("SC6","C6_UM"		),TamSx3("C6_UM"		)[1],/*lPixel*/,{|| (cAliasSC6)->C6_UM															},/*cAlign*/,lLineBreak,/*cHeaderAlign*/)
TRCell():New(oRomaneio,"NTOTLIB"	,/*Tabela*/,RetTitle("C9_QTDLIB"	),PesqPict("SC9","C9_QTDLIB"	),TamSx3("C9_QTDLIB"	)[1],/*lPixel*/,{|| nTotLib																		},/*cAlign*/,lLineBreak,"RIGHT")
TRCell():New(oRomaneio,"C9_PRCVEN"	,/*Tabela*/,RetTitle("C9_PRCVEN"	),PesqPict("SC9","C9_PRCVEN"	),TamSx3("C9_PRCVEN"	)[1],/*lPixel*/,{|| xMoeda((cALiasSC9)->C9_PRCVEN,1,mv_par07,(cALiasSC5)->C5_EMISSAO) 		},/*cAlign*/,lLineBreak,"RIGHT")
TRCell():New(oRomaneio,"B1_IPI"		,/*Tabela*/,RetTitle("B1_IPI"		),PesqPict("SB1","B1_IPI"		),TamSx3("B1_IPI"		)[1],/*lPixel*/,{|| (cAliasSB1)->B1_IPI 														},/*cAlign*/,lLineBreak,"RIGHT")
If cPaisloc=="BRA" 
	TRCell():New(oRomaneio,"NALIQ",/*Tabela*/,RetTitle("B1_PICM"),PesqPict("SB1","B1_PICM"),TamSx3("B1_PICM")[1],/*lPixel*/,{|| IIf( !Empty((cAliasSB1)->B1_PICM),(cAliasSB1)->B1_PICM,(cAliasSB1)->B1_ALIQISS ) 			},/*cAlign*/,lLineBreak,"RIGHT")
EndIf
TRCell():New(oRomaneio,"NTOTAL"		,/*Tabela*/,RetTitle("C6_VALOR"		),PesqPict("SC6","C6_VALOR"		),TamSx3("C6_VALOR"		)[1],/*lPixel*/,{|| xMoeda(((IIF((cALiasSC6)->C6_GRADE=="S" .AND. MV_PAR06 ==1,nTotLib,(cALiasSC9)->C9_QTDLIB))*(cAliasSC9)->C9_PRCVEN),1,mv_par07,(cAliasSC5)->C5_EMISSAO)},/*cAlign*/,lLineBreak,"RIGHT")
TRCell():New(oRomaneio,"DEMISSAO"	,/*Tabela*/,RetTitle("F2_EMISSAO"	),PesqPict("SF2","F2_EMISSAO"	),nTamData					,/*lPixel*/,{|| dEmissao					},/*cAlign*/,lLineBreak,/*cHeaderAlign*/)
TRCell():New(oRomaneio,"C6_LOCAL"	,/*Tabela*/,RetTitle("C6_LOCAL"		),PesqPict("SC6","C6_LOCAL"		),TamSx3("C6_LOCAL"		)[1],/*lPixel*/,{|| (cAliasSC6)->C6_LOCAL		},/*cAlign*/,lLineBreak,/*cHeaderAlign*/)
TRCell():New(oRomaneio,"C6_LOCALIZ"	,/*Tabela*/,RetTitle("C6_LOCALIZ"	),PesqPict("SC6","C6_LOCALIZ"	),TamSx3("C6_LOCALIZ"	)[1],/*lPixel*/,{|| (cAliasSC6)->C6_LOCALIZ	},/*cAlign*/,lLineBreak,/*cHeaderAlign*/)
TRCell():New(oRomaneio,"C9_NFISCAL"	,/*Tabela*/,RetTitle("C9_NFISCAL"	),PesqPict("SC9","C9_NFISCAL"	),TamSx3("C9_NFISCAL"	)[1],/*lPixel*/,{|| (cAliasSC9)->C9_NFISCAL	},/*cAlign*/,lLineBreak,/*cHeaderAlign*/)
TRCell():New(oRomaneio,SerieNfId("SC9",3,"C9_SERIENF")	,/*Tabela*/,SerieNfId("SC9",7,"C9_SERIENF"),PesqPict("SC9","C9_SERIENF"	),SerieNfId("SC9",6,"C9_SERIENF"),/*lPixel*/,{|| (cAliasSC9)->&(SerieNfId("SC9",3,"C9_SERIENF"))	},/*cAlign*/,lLineBreak,/*cHeaderAlign*/)

TRFunction():New(oRomaneio:Cell("NTOTLIB"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oRomaneio:Cell("NTOTAL"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera texto dos totalizadores                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(2):SetTotalText(STR0019)


Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 21/07/06 ³±±
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
Static Function ReportPrint(oReport,cAliasSC9,cAliasSC5,cAliasSF2,cALiasSB1,cAliasSA1,cAliasSC6)

Local lFirst  := .T.
Local cPedAnt := "   "
Local cFilSC5 := ""
Local cFilSF2 := ""
Local cFilSA1 := ""
Local cFilSA4 := ""
Local cSelect := ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o bloco de codigo que retornara o conteudo de impres- 		   ³
//³ sao da celula.                                               		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(2):Cell("DEMISSAO"):SetBlock({|| dEmissao })
oReport:Section(2):Cell("NTOTLIB" ):SetBlock({|| nTotLib  })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC9")		// Pedidos Liberados
dbSetOrder(1)			// Pedido,Item,Sequencia,Produto

	cSelect:= "%"
	cSelect+= "C9_PRODUTO,C9_QTDLIB,C9_PRCVEN,C9_NFISCAL,C9_SERIENF,"+Iif(SerieNfId("SC9",3,"C9_SERIENF")<>"C9_SERIENF",SerieNfId("SC9",3,"C9_SERIENF")+",","")
	cSelect+= " C9_FILIAL,C9_BLEST,C9_BLCRED,C9_PEDIDO,"
	cSelect+= " C9_CLIENTE,C9_LOJA,C9_ITEM,C9_SEQUEN,C5_FILIAL,C5_EMISSAO,C5_NUM,C5_TIPO,C5_TRANSP,C5_CLIENTE,"
	cSelect+= " C5_LOJACLI,B1_IPI,B1_PICM,B1_COD,B1_DESC,B1_ALIQISS,A1_COD,A1_LOJA,A1_NOME,A1_END,A1_BAIRRO,A1_MUN,A1_EST,"
	cSelect+= " C6_DESCRI,C6_UM,C6_VALOR,C6_LOCAL,C6_LOCALIZ,C6_FILIAL,C6_NUM,C6_PRODUTO,C6_ITEM,C6_GRADE,"
	cSelect+= " F2_EMISSAO,F2_FILIAL,F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA"
	cSelect+= "%"
	
	oReport:Section(2):BeginQuery()	
	BeginSql Alias cAliasSC9
	SELECT %Exp:cSelect%
	FROM %Table:SC5% SC5,%Table:SF2% SF2,%Table:SC6% SC6, %Table:SC9% SC9
	LEFT JOIN %Table:SB1% SB1
		ON B1_COD = C9_PRODUTO AND
		SB1.B1_FILIAL = %xFilial:SB1% AND 
		SB1.%NotDel%
	LEFT JOIN %Table:SA1% SA1
		ON A1_COD = C9_CLIENTE AND 
		A1_LOJA = C9_LOJA AND
		SA1.A1_FILIAL = %xFilial:SA1% AND 
		SA1.%NotDel%		
	WHERE C9_FILIAL = %xFilial:SC9% AND 
		C9_PEDIDO >= %Exp:mv_par01% AND C9_PEDIDO <= %Exp:mv_par02% AND
		(C9_BLEST = " " OR C9_BLEST = "10") AND
		(C9_BLCRED = " " OR C9_BLCRED = "10") AND
		SC9.%NotDel% AND 
		C5_FILIAL = %xFilial:SC5% AND 
		C5_NUM = C9_PEDIDO AND NOT(C5_TIPO IN ("D","B")) AND
		SC5.%NotDel% AND
		C6_FILIAL = %xFilial:SC6% AND 
		C6_NUM = C9_PEDIDO AND C6_PRODUTO = C9_PRODUTO AND C6_ITEM = C9_ITEM AND
		SC6.%NotDel% AND
		F2_FILIAL = %xFilial:SF2% AND 
		F2_DOC = C9_NFISCAL AND F2_SERIE = C9_SERIENF AND F2_CLIENTE = C9_CLIENTE AND F2_LOJA = C9_LOJA AND
		F2_EMISSAO >= %Exp:DtoS(mv_par03)% AND F2_EMISSAO <= %Exp:DtoS(mv_par04)% AND
		SF2.%NotDel%
	ORDER BY C9_PEDIDO,C9_ITEM,C9_SEQUEN,C9_PRODUTO
	EndSql 
	oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)
		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtros do usuario                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If len(oReport:Section(1):GetAdvplExp("SC5")) > 0
	cFilSC5 := oReport:Section(1):GetAdvplExp("SC5")
EndIf
If len(oReport:Section(1):GetAdvplExp("SF2")) > 0
	cFilSF2 := oReport:Section(1):GetAdvplExp("SF2")
EndIf
If len(oReport:Section(1):GetAdvplExp("SA1")) > 0
	cFilSA1 := oReport:Section(1):GetAdvplExp("SA1")
EndIf
If len(oReport:Section(1):GetAdvplExp("SA4")) > 0
	cFilSA4 := oReport:Section(1):GetAdvplExp("SA4")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " - " + GetMv("MV_MOEDA" + STR(mv_par07,1)) )	// "Curva ABC de Estoque - Ordem de "###" / % de Participacao"
oReport:SetMeter((cAliasSC9)->(LastRec()))
While !oReport:Cancel() .AND. !(cAliasSC9)->(Eof()) .AND. (cAliasSC9)->C9_FILIAL = xFilial("SC9")

	dbSelectArea("SC5")
	dbSetOrder(1)
	dbSeek(xFilial()+(cALiasSC9)->C9_PEDIDO)
	
	dbSelectArea("SF2")
	dbSetOrder(1)
	MsSeek(xFilial("SF2")+(cAliasSC9)->C9_NFISCAL+(cAliasSC9)->C9_SERIENF+(cAliasSC9)->C9_CLIENTE+(cAliasSC9)->C9_LOJA)

	#IFNDEF TOP
	
		If At((cALiasSC5)->C5_TIPO,"DB") != 0 
			dbSelectArea(cAliasSC9)
			dbSkip()
			Loop
		EndIf
	
		dbSelectArea(cAliasSC6)
		dbSetOrder(1)
		dbSeek(xFilial()+(cAliasSC9)->C9_PEDIDO+(cAliasSC9)->C9_ITEM)
		
		If (cAliasSF2)->F2_EMISSAO < MV_PAR03 .OR. (cAliasSF2)->F2_EMISSAO > MV_PAR04
			dbSelectArea(cAliasSC9)
			dbSkip()
			Loop
		Endif
	#ENDIF	
	dEmissao := (cAliasSF2)->F2_EMISSAO
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida o produto conforme a mascara         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cAliasSC9)
	lRet:=ValidMasc(SC9->C9_PRODUTO,MV_PAR05)
	If !lRet
		dbSelectArea(cAliasSC9)
		dbSkip()
		Loop
	Endif
	
	If C9_PEDIDO # cPedAnt .OR. lFirst
		cPedAnt:= C9_PEDIDO
		cPedido:= (cAliasSC5)->C5_NUM
		
		dbSelectArea("SA4")
		dbSeek(xFilial()+(cAliasSC5)->C5_TRANSP)
		
		dbSelectArea("SA1")
		dbSeek(xFilial()+(cAliasSC5)->C5_CLIENTE+(cAliasSC5)->C5_LOJACLI)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica filtro de usuario                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SF2")
		If !Empty(cFilSF2) .AND. !(&cFilSF2)
			dbSelectArea(cAliasSC9)
		   	dbSkip()
		   Loop
		EndIf	

		dbSelectArea("SC5")	
		If !Empty(cFilSC5) .AND. !(&cFilSC5)
			dbSelectArea(cAliasSC9)
		   	dbSkip()
		   Loop
		EndIf	

		dbSelectArea("SA1")
		If !Empty(cFilSA1) .AND. !(&cFilSA1)
			dbSelectArea(cAliasSC9)
		   	dbSkip()
		   Loop
		EndIf	

		dbSelectArea("SA4")
		If !Empty(cFilSA4) .AND. !(&cFilSA4)
			dbSelectArea(cAliasSC9)
		   	dbSkip()
		   Loop
		EndIf	
		
		If lfirst
		  oReport:EndPage() //-- Salta Pagina
		EndIf	
		
		lFirst := .F.

        oReport:Section(1):Init()
        oReport:Section(1):PrintLine()
        oReport:Section(1):Finish()

		oReport:Section(2):Init()
		
	Endif

	ImpItemR4(oReport,cAliasSC9,cAliasSC6,cAliasSB1)
	
	dbSelectArea(cAliasSC9)
	dbSkip()
	oReport:IncMeter()
	
	If C9_PEDIDO # cPedAnt .OR. Eof()
		oReport:Section(2):Finish()
		oReport:SkipLine(1)

		// Um Pedido por Folha
		If mv_par08 == 1
           oReport:Section(1):SetPageBreak(.T.)		
		EndIf
	EndIf
EndDo 
oReport:Section(2):SetPageBreak(.T.)
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ImpItemR4 ³ Autor ³ Marco Bianchi         ³ Data ³ 24/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de Itens do Romaneio  de Despacho                ³±±
±±³          ³ Ordem de Impressao : LOCALIZACAO NO ALMOXARIFADO           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpItem(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR790                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpItemR4(oReport,cAliasSC9,cAliasSC6,cAliasSB1)

Local cMascara :=GetMv("MV_MASCGRD")
Local nTamRef  :=Val(Substr(cMascara,1,2))

nTotLib := (cAliasSC9)->C9_QTDLIB


IF (cAliasSC6)->C6_GRADE == "S" .AND. MV_PAR06 == 1
	dbSelectArea(cAliasSC9)
	cProdRef:=Substr(C9_PRODUTO,1,nTamRef)
	cPedido := (cAliasSC9)->C9_PEDIDO
	nReg    := 0
	nTotLib := 0
	
	While !oReport:Cancel() .AND. !Eof() .AND. xFilial() == C9_FILIAL .AND. Substr(C9_PRODUTO,1,nTamRef) == cProdRef;
		.AND. C9_PEDIDO == cPedido
		nReg:=Recno()
		
		#IFNDEF TOP
			If !Empty(C9_BLEST) .AND. !Empty(C9_BLCRED) .AND. C9_BLEST # "10" .AND. C9_BLCRED # "10"
				dbSkip()
				Loop
			Endif
		#ENDIF
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Valida o produto conforme a mascara         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lRet:=ValidMasc((cAliasSC9)->C9_PRODUTO,MV_PAR05)
		If !lRet
			dbSkip()
			Loop
		Endif
		nTotLib += (cAliasSC9)->C9_QTDLIB
		
		dbSelectArea(cAliasSC9)
		dbSkip()
	End
	
	If nReg > 0
		dbGoto(nReg)
		nReg:=0
	Endif
	
Endif
    
oReport:Section(2):PrintLine()
dbSelectArea(cAliasSC9)

Return