/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR765.CH"
#INCLUDE "protheus.CH"

/*эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  Ё MATR765  Ё Autor Ё Marco Bianchi         Ё Data Ё 17/07/06 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Relatorio de Curva ABC de Consumo de Vendas por Cliente.   Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё SIGAFAT                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ*/
User Function MATR765()

Local oReport
Local aPDFields := {"A1_NOME"}

Private oTempTable 	:= Nil
Private cRec		:= "0"

FATPDLoad(Nil,Nil,aPDFields)
oReport := ReportDef()
oReport:PrintDialog()
FATPDUnload()

Return

/*эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  ЁReportDef Ё Autor Ё Marco Bianchi         Ё Data Ё 17/07/06 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁA funcao estatica ReportDef devera ser criada para todos os Ё╠╠
╠╠Ё          Ёrelatorios que poderao ser agendados pelo usuario.          Ё╠╠
╠╠Ё          Ё                                                            Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁRetorno   ЁExpO1: Objeto do relatСrio                                  Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁNenhum                                                      Ё╠╠
╠╠Ё          Ё                                                            Ё╠╠
╠╠цддддддддддедддддддддддддддбдддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё   DATA   Ё Programador   ЁManutencao efetuada                         Ё╠╠
╠╠цддддддддддедддддддддддддддедддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё          Ё               Ё                                            Ё╠╠
╠╠юддддддддддадддддддддддддддадддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function ReportDef()

Local oReport
Local oRegiao
Local oCliente
Local oProd
Local oValores
Local oBreak1
Local oBreak2
Local cAliasSJ3 := GetNextAlias()
	
Private aValores := {0,0,0,0,0,0,0,0,0,0,0,0}
Private nG	  	 := 0
Private aCabec   := {STR0060+" 01",STR0060+" 02",STR0060+" 03",STR0060+" 04",STR0060+" 05",STR0060+" 06",STR0060+" 07",STR0060+" 08",STR0060+" 09",STR0060+" 10",STR0060+" 11",STR0060+" 12"}

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Funcao utilizada para verificar a ultima versao dos fontes      Ё
//Ё SIGACUS.PRW, SIGACUSA.PRX e SIGACUSB.PRX, aplicados no rpo do   |
//| cliente, assim verificando a necessidade de uma atualizacao     |
//| nestes fontes. NAO REMOVER !!!							        Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If !(FindFunction("SIGACUS_V") .And. SIGACUS_V() >= 20050512)
	Final("Atualizar patch do programa SIGACUS.PRW !!!")
EndIf
If !(FindFunction("SIGACUSA_V") .And. SIGACUSA_V() >= 20050512)
	Final("Atualizar patch do programa SIGACUSA.PRX !!!")
EndIf
If !(FindFunction("SIGACUSB_V") .And. SIGACUSB_V() >= 20060920)
	Final("Atualizar patch do programa SIGACUSB.PRX !!!")
EndIf

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁCriacao do componente de impressao                                      Ё
//Ё                                                                        Ё
//ЁTReport():New                                                           Ё
//ЁExpC1 : Nome do relatorio                                               Ё
//ЁExpC2 : Titulo                                                          Ё
//ЁExpC3 : Pergunte                                                        Ё
//ЁExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  Ё
//ЁExpC5 : Descricao                                                       Ё
//Ё                                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oReport := TReport():New("MATR765",STR0061,"MTR765", {|oReport| ReportPrint(oReport,cAliasSJ3)},STR0028 + " " + STR0029 + " " + STR0030)	// "Curva ABC de Estoque"###"RelatСrio para mostrar as quantidades de vendas (consumos) de "###"produtos no estoque por regiao e por cliente."###"Este relatorio deverА ser impresso no formulАrio de 132 colunas."
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Grupo de Perguntas                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(oReport:uParam,.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё                                                                        Ё
//Ё                      Definicao das Secoes                              Ё
//Ё                                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Secao 01 - Regiao                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oRegiao := TRSection():New(oReport,STR0056,{"SJ3","TRB"},/*{Array com as ordens do relatСrio}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Regiao"
oRegiao:SetTotalInLine(.F.)
oReport:Section(1):SetHeaderSection(.F.)
TRCell():New(oRegiao,"REGIAO"		,"TRB"		,RetTitle("J3_REGVEND"	),/*Picture*/,11,/*lPixel*/,{|| STR0032 + TRB->REGIAO 					 		})	// "Regiao: "
TRCell():New(oRegiao,"X5_DESCRI"	,"SX5"		,/*Titulo*/				 ,/*Picture*/,50,/*lPixel*/,{|| AllTrim(SX5->X5_DESCRI)						})	// Descricao da Regiao
TRCell():New(oRegiao,"NPORCPRD"		,/*Tabela*/	,STR0033				 ,/*Picture*/,21,/*lPixel*/,{|| STR0033 + Transform(nPorcPrd,"@E 999.99") + "%"})	// "Participacao: "

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Secao 02 - Cliente                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oCliente := TRSection():New(oRegiao,STR0057,{},/*{Array com as ordens do relatСrio}*/,/*Campos do SX3*/,/*Campos do SIX*/)			// "Cliente"
oCliente:SetTotalInLine(.F.)
oReport:Section(1):Section(1):SetHeaderSection(.T.)
oReport:Section(1):Section(1):SetHeaderBreak()
TRCell():New(oCliente,"CLIENTE"		,"TRB"		,RetTitle("J3_CLIENTE"	),/*Picture*/					,11						 	,/*lPixel*/,{|| TRB->CLIENTE 	})	// Codigo do Cliente
TRCell():New(oCliente,"NOMECLI"		,"SA1"		,RetTitle("A1_NOME"		),/*Picture*/					,50							,/*lPixel*/,{|| FATPDObfuscate(SA1->A1_NOME,"A1_NOME")	})	// Nome do Cliente
TRCell():New(oCliente,"NTOTCLI"		,/*Tabela*/	,STR0054				 ,PesqPict("SJ3","J3_VALR01")	,TamSX3("J3_VALR01"	)[1]	,/*lPixel*/,{|| nTotCli			})	// Valor do Consumo Medio por Cliente (C.M.M * Vl.Unit.)
TRCell():New(oCliente,"NPORCPRD"	,"TRB"		,STR0055				 ,"@E 999.99"			 		,06						 	,/*lPixel*/,{|| 0		})	// "%Participacao" % de participacao do cliente em relacao ao total da regiao

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Definicao das Quebras: por Regiao e por Cliente                        Ё
//Ё Estas quebras sao validadas sempre na execucao de um PrintLine         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oBreak1 := TRBreak():New(oRegiao	,oRegiao:Cell("REGIAO"		),"TOTAL DA REGIAO " 	,.F.)
oBreak2 := TRBreak():New(oCliente	,oCliente:Cell("CLIENTE"	),"TOTAL DO CLIENTE " 	,.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Secao 03 - Produto                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oProd := TRSection():New(oCliente,STR0058,{},/*{Array com as ordens do relatСrio}*/,/*Campos do SX3*/,/*Campos do SIX*/)			// "Produto"
oProd:SetTotalInLine(.F.)
oReport:Section(1):Section(1):Section(1):SetHeaderPage()
TRCell():New(oProd,"PRODUTO"	,"TRB"		,RetTitle("J3_PRODUTO")		,PesqPict("SJ3","J3_PRODUTO"	),TamSX3("J3_PRODUTO"	)[1]	,/*lPixel*/,{|| TRB->PRODUTO								})	// Codigo do Produto
TRCell():New(oProd,"CCLASSE"	,/*Tabela*/	,STR0037				 	,PesqPict("SJ3","J3_FATVEN"		),TamSX3("J3_FATVEN"	)[1]	,/*lPixel*/,{|| cClasse   	 								})	// Classe
TRCell():New(oProd,"CDESCPROD"	,"SB1"		,RetTitle("B1_DESC"	)		,PesqPict("SB1","B1_DESC"		),TamSX3("B1_DESC"		)[1]	,/*lPixel*/,{|| cDescProd 									})	// Descricao do Produto
TRCell():New(oProd,"VAL_UNIT"	,"TRB"		,STR0034				 	,PesqPict("SJ3","J3_VALR01"		),TamSX3("J3_VALR01"	)[1]	,/*lPixel*/,{|| xMoeda(TRB->VAL_UNIT,1,mv_par13,ddatabase)	})	// "Valor Unitario"
TRCell():New(oProd,"PROCPROD"	,"TRB"		,STR0035				 	,"@E 999.99"			 	 	 ,06							,/*lPixel*/,{|| 0									})	// "% Part"
TRCell():New(oProd,"NACPORCE"	,/*Tabela*/	,STR0036				 	,"@E 999.99"			 	 	 ,06							,/*lPixel*/,{|| 0 									})	// "% Acum"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Secao 04 - Valores Mensais                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oValores := TRSection():New(oProd,STR0059,{"TRB","SJ3","SB1","SA1"},/*{Array com as ordens do relatСrio}*/,/*Campos do SX3*/,/*Campos do SIX*/)			// "Valores Mensais"
oValores:SetTotalInLine(.F.)
oReport:Section(1):Section(1):Section(1):Section(1):SetHeaderPage()

TRCell():New(oValores,"NCOL01"		,/*Tabela*/	,aCabec[01]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[01] 	})
TRCell():New(oValores,"NCOL02"		,/*Tabela*/	,aCabec[02]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[02] 	})
TRCell():New(oValores,"NCOL03"		,/*Tabela*/	,aCabec[03]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[03] 	})
TRCell():New(oValores,"NCOL04"		,/*Tabela*/	,aCabec[04]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[04] 	})
TRCell():New(oValores,"NCOL05"		,/*Tabela*/	,aCabec[05]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[05]	})
TRCell():New(oValores,"NCOL06"		,/*Tabela*/	,aCabec[06]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[06] 	})
TRCell():New(oValores,"NCOL07"		,/*Tabela*/	,aCabec[07]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[07] 	})
TRCell():New(oValores,"NCOL08"		,/*Tabela*/	,aCabec[08]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[08] 	})
TRCell():New(oValores,"NCOL09"		,/*Tabela*/	,aCabec[09]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[09] 	})
TRCell():New(oValores,"NCOL10"		,/*Tabela*/	,aCabec[10]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[10] 	})
TRCell():New(oValores,"NCOL11"		,/*Tabela*/	,aCabec[11]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[11] 	})
TRCell():New(oValores,"NCOL12"		,/*Tabela*/	,aCabec[12]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[12] 	})
TRCell():New(oValores,"QTDECM"		,"TRB"			,STR0038		,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| TRB->QTDECM 	})	// "C.M.M."
TRCell():New(oValores,"NTOTACUM"	,/*Tabela*/	,STR0039		,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| nTotAcum 		})	// "Tot.Cons."

oReport:Section(1):SetEditCell(.F.)

oReport:Section(1):Section(1):SetEdit(.F.)
oReport:Section(1):Section(1):Section(1):SetEdit(.F.)
oReport:Section(1):Section(1):Section(1):Section(1):SetEdit(.F.)

Return(oReport)

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  ЁReportPrinЁ Autor ЁEduardo Riera          Ё Data Ё04.05.2006Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁA funcao estatica ReportDef devera ser criada para todos os Ё╠╠
╠╠Ё          Ёrelatorios que poderao ser agendados pelo usuario.          Ё╠╠
╠╠Ё          Ё                                                            Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁRetorno   ЁNenhum                                                      Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁExpO1: Objeto Report do RelatСrio                           Ё╠╠
╠╠Ё          Ё                                                            Ё╠╠
╠╠цддддддддддедддддддддддддддбдддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё   DATA   Ё Programador   ЁManutencao efetuada                         Ё╠╠
╠╠цддддддддддедддддддддддддддедддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё          Ё               Ё                                            Ё╠╠
╠╠юддддддддддадддддддддддддддадддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function ReportPrint(oReport,cAliasSJ3)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

Local i
Local nI := 0
Local cMesRela, cMesInic
Local nDecPrec, aCampos, cArqTrab, cKey, cIndex
Local cProduto, aRegQtde, cRegiaoC, nPrecoUn, aAcumVal
Local nQtdCons, nNoMeses, dDatCons, cAnoAuxi, nConsMed, nTtGeral
Local nElement, nPorcPrd, nAcPorce, nQtdes, cClasse
Local nContaIt, aTam:=0
Local cInd
Local cDescProd:=""
Local nTotCli  :=0
Local nTotAcum := 0
Local nMes
Local aNomeMes := {STR0042,STR0043,STR0044,STR0045,STR0046,STR0047,STR0048,STR0049,STR0050,STR0051,STR0052,STR0053}		//"Jan"###"Fev"###"Mar"###"Abr"###"Mai"###"Jun"###"Jul"###"Ago"###"Set"###"Out"###"Nov"###"Dez"

Local nTamSXG  := TamSXG("001")			// Grupo de Cliente
Local nTamSXG2 := TamSXG("002")			// Grupo de Loja
Local aCabec   := {"","","","","","","","","","","",""}

Local oRegiao	:= oReport:Section(1) 
Local oCliente	:= oReport:Section(1):Section(1)
Local oProd		:= oReport:Section(1):Section(1):Section(1)
Local oValores	:= oReport:Section(1):Section(1):Section(1):Section(1)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Calcula o mes/ano para o cabecalho.                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cMesRela := StrZero(mv_par03,2)
cAnoRela := StrZero(mv_par04,4)
For nI := 11 To 0 Step -1
	nMes := Val(StrZero(mv_par03,2)) - nI
	If nMes < 1
		nMes := 12 + nMes
		cAno := Str(Val(StrZero(mv_par04,4))-1,4)
	Else
		cAno := StrZero(mv_par04,4)
	Endif
	
	oValores:Cell("NCOL"+strzero(nMes,2)):SetTitle(aNomeMes[nMes] + "/" + cAno)
	
Next nI

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Pesquisa o titulo do campo J3_CLIENTE (cliente/concessionaria).  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SX3")
dbSetOrder(2)
dbSeek( "J3_CLIENTE" )
dbSetOrder(1)
oReport:SetTitle(AllTrim(oReport:Title()) + " - " + STR0062 + " - " + AllTrim(X3Titulo()) + STR0031 +  " - " + GetMv("MV_MOEDA" + STR(mv_par13,1)) )	// "Ordem de"###"Curva ABC de Estoque - Ordem de "###" / % de Participacao"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁTransforma parametros Range em expressao SQL                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
MakeSqlExpr(oReport:uParam)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Os 12 meses estao contidos em 1 ano ou 2 anos.               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If mv_par03 == 12
	cAnoAnte := StrZero(mv_par04,4)
	cMesInic := "01"
Else
	cAnoAnte := StrZero((mv_par04-1),4)
	cMesInic := StrZero((mv_par03+1),2)
Endif
If mv_par08 == 2
	cTipPrec := "S"      		// preco standard
ElseIf mv_par08 == 3
	cTipPrec := "C"      		// preco de tabela informado no cad. de cliente
ElseIf mv_par08 == 4
	Pergunte("MR765B",.F.)    	// preco de tabela informado pelo usuario
	Pergunte("MR765B",.T.)
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Variaveis utilizadas para parametros                         Ё
	//Ё mv_par01 // Nro. Tabela                                      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cTipPrec := mv_par01
	Pergunte("MTR765",.F.)
Else
	cTipPrec := "M"      		// preco medio
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Pesquisa o numero de casas decimais do valor e qtde.         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aTam:=TamSX3("J3_VALR01")
nDecPrec:=aTam[2]

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define estrutura e gera o arquivo de trabalho                Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aTam:=TamSX3("J3_REGVEND")
aCampos := {{ "REGIAO"  , "C",aTam[1],aTam[2]							},;
{ "PRODUTO" , "C", 15						, 0 						},;
{ "CLIENTE" , "C", nTamSXG[1] 				, 0 						},;
{ "LOJACLI" , "C", nTamSXG2[1]				, 0 						},;
{ "VALCHAV" , "C", 16						, 0 						},;
{ "VAL_UNIT", "N", 16						, nDecPrec 					},;
{ "VALCMED" , "N", 16						, nDecPrec 					},;
{ "MESCONS" , "N", 02						, 0							},;
{ "QTDE01"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE02"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE03"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE04"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE05"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE06"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE07"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE08"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE09"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE10"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE11"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDE12"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	},;
{ "QTDECM"  , "N", TamSx3("J3_QUAR01")[1]	, TamSx3("J3_QUAR01")[2]	}}

//-------------------------------------------------------------------
// Instancia tabela temporАria.  
//-------------------------------------------------------------------
oTempTable	:= FWTemporaryTable():New( "TRB" )

//-------------------------------------------------------------------
// Atribui o  os Мndices.  
//-------------------------------------------------------------------
oTempTable:SetFields( aCampos )

oTempTable:AddIndex("1",{"REGIAO","CLIENTE","LOJACLI","PRODUTO"})

oTempTable:AddIndex("2",{"REGIAO","CLIENTE","LOJACLI","VALCHAV"})

//------------------
//CriaГЦo da tabela
//------------------
oTempTable:Create()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Filtros                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SJ3")		// Acumulados Mensais
dbSetOrder(3)      		// Filial,Regial,Cliente,Loja,Produto,Ano

oReport:Section(1):BeginQuery()
BeginSql Alias cAliasSJ3
SELECT *
FROM %Table:SJ3% SJ3
WHERE J3_FILIAL = %xFilial:SJ3%  AND
J3_REGVEND >= %Exp:mv_par01% AND
J3_REGVEND <= %Exp:mv_par02% AND
J3_CLIENTE >= %Exp:mv_par09% AND
J3_CLIENTE <= %Exp:mv_par10% AND
(J3_ANO = %Exp:StrZero(mv_par04,4)% OR J3_ANO = %Exp:cAnoAnte%) AND
SJ3.%notdel%
ORDER BY J3_FILIAL,J3_REGVEND,J3_PRODUTO,J3_ANO,J3_FATVEN
EndSql
oReport:Section(1):EndQuery()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis para movimentacao do cursor.                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea(cAliasSJ3)
oReport:SetMeter(RecCount())		// Total de Elementos da regua

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Gera arquivo de trabalho com dados do SJ3 - acum. mensais.   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aRegQtde := {}
While !oReport:Cancel() .And. (cAliasSJ3)->(!Eof()) .And. (cAliasSJ3)->J3_FILIAL == xFilial("SJ3")
	
	cRegiaoC := (cAliasSJ3)->J3_REGVEND
	While !oReport:Cancel() .And. (cAliasSJ3)->J3_REGVEND == cRegiaoC .And. (cAliasSJ3)->J3_FILIAL == xFilial("SJ3");
		.And. (cAliasSJ3)->(!Eof())
		
		cCliente := (cAliasSJ3)->J3_CLIENTE
		cLojaCli := (cAliasSJ3)->J3_LOJA
		dbSelectArea("SA1")
		dbSeek( xFilial("SA1") + cCliente + cLojaCli )
		Aadd( aRegQtde, { cRegiaoC, cCliente, cLojaCli, 0 } )
		While (cAliasSJ3)->J3_CLIENTE == cCliente .And. (cAliasSJ3)->J3_LOJA == cLojaCli .And. ;
			(cAliasSJ3)->J3_REGVEND == cRegiaoC .And. (cAliasSJ3)->J3_FILIAL == xFilial("SJ3") ;
			.And. (cAliasSJ3)->(!Eof())
			
			cProduto := (cAliasSJ3)->J3_PRODUTO
			dbSelectArea("SB1")
			dbSeek( xFilial("SB1") + cProduto )
			
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Atribui preco unitario conforme escolha do usuario (parametro). Ё
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If cTipPrec == "S"       // preco standard
				nPrecoUn := xMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"),1,mv_par13,ddatabase)
			ElseIf cTipPrec == "M" .Or. cTipPrec == "1" .Or. (cTipPrec > "7" .And. cTipPrec <= "9")
				nPrecoUn := xMoeda(SB1->B1_PRV1,1,mv_par13,ddatabase)
			ElseIf cTipPrec == "C"   // tabela informada no cad. de cliente
				If Empty(SA1->A1_TABELA) .Or. SA1->A1_TABELA == "1" 
					nPrecoUn := xMoeda(SB1->B1_PRV1,1,mv_par13,ddatabase)
				Else                                                   
					nPrecoUn := MaTabPrVen(SA1->A1_TABELA,cProduto,0,SA1->A1_COD,SA1->A1_LOJA,mv_par13,ddatabase)					
				Endif
			Else
				dbSelectArea("SA1")
				dbSeek( xFilial("SA1") + (cAliasSJ3)->J3_CLIENTE + (cAliasSJ3)->J3_LOJA )
				nPrecoUn := MaTabPrVen(cTipPrec,cProduto,0,SA1->A1_COD,SA1->A1_LOJA,mv_par13,ddatabase)									
			Endif
			
			aAcumVal := { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
			nQtdCons := 0   // qtde. consumida do produto no periodo
			nNoMeses := 0   // nro. de meses do produto para calculo
			
			If cAnoAnte == cAnoRela
				//здддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Os 12 meses estao em 1 unico ano.                  Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддды
				While (cAliasSJ3)->J3_PRODUTO==cProduto .And. (cAliasSJ3)->J3_CLIENTE == cCliente ;
					.And. (cAliasSJ3)->J3_LOJA==cLojaCli .And. (cAliasSJ3)->J3_REGVEND == cRegiaoC ;
					.And. (cAliasSJ3)->J3_FILIAL == xFilial("SJ3") .And. (cAliasSJ3)->(!Eof())
					
					For i := 1 To 12
						//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Verifica data de inicio de consumo, informado no SB1.   Ё
						//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						dDatCons := Ctod("01/" + StrZero(i,2) + "/" + cAnoRela,"ddmmyy")
						dDatCons := LastDay(dDatCons)
						dbSelectArea(cAliasSJ3)
						If dDatCons >= RetFldProd(SB1->B1_COD,"B1_CONINI")
							cInd   := "J3_QUAR"+StrZero(i,2)
							nQtdes := &cInd
							aAcumVal[i] += nQtdes
							nQtdCons += nQtdes
							nNoMeses++
						Endif
					Next
					dbSelectArea(cAliasSJ3)
					dbSkip()
					oReport:IncMeter()
				End
				
			Else
				
				//зддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Os 12 meses estao em 2 anos consecutivos.         Ё
				//юддддддддддддддддддддддддддддддддддддддддддддддддддды
				If cAnoRela == (cAliasSJ3)->J3_ANO
					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё O primeiro ano nao possui informacoes, somente o 2o. ano. Ё
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					cMesAuxi := "01"
					cAnoAuxi := cAnoRela
					i := 13 - Val(cMesRela)
					
					For nMes := 1 To (i-1)
						//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Verifica data de inicio de consumo, informado no SB1.   Ё
						//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						dDatCons := Ctod("01/" + StrZero((nMes+Val(cMesRela)),2) + "/" + cAnoAnte,"ddmmyy")
						dDatCons := LastDay(dDatCons)
						If dDatCons >= RetFldProd(SB1->B1_COD,"B1_CONINI")
							nNoMeses++
						Endif
					Next
				Else
					cMesAuxi := cMesInic
					cAnoAuxi := cAnoAnte
					i := 1
				Endif
				
				While (cAliasSJ3)->J3_PRODUTO==cProduto .And. (cAliasSJ3)->J3_CLIENTE == cCliente ;
					.And. (cAliasSJ3)->J3_LOJA==cLojaCli .And. (cAliasSJ3)->J3_REGVEND == cRegiaoC ;
					.And. (cAliasSJ3)->J3_FILIAL == xFilial("SJ3") .And. (cAliasSJ3)->(!Eof())
					
					
					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Verifica data de inicio de consumo, informado no SB1.   Ё
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					dDatCons := Ctod("01/" + cMesAuxi + "/" + cAnoAuxi,"ddmmyy")
					dDatCons := LastDay(dDatCons)
					dbSelectArea(cAliasSJ3)
					If dDatCons >= RetFldProd(SB1->B1_COD,"B1_CONINI")
						cInd   := "J3_QUAR"+cMesAuxi
						nQtdes := &cInd
						aAcumVal[i] += nQtdes
						nQtdCons += nQtdes
						nNoMeses++
					Endif
					
					//здддддддддддддддддддддддддддддддддд©
					//Ё Posiciona no proximo mes.        Ё
					//юдддддддддддддддддддддддддддддддддды
					cMesAuxi := StrZero((Val(cMesAuxi)+1),2)
					i++
					
					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Verifica se e' o proximo ano, ou ja finalizou o periodo.  Ё
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					If Val(cMesAuxi) >= 13 .Or. i >= 13
						dbSelectArea(cAliasSJ3)
						dbSkip()
						oReport:IncMeter()
						
						If (cAliasSJ3)->J3_PRODUTO == cProduto .And. (cAliasSJ3)->J3_CLIENTE == cCliente .And. ;
							(cAliasSJ3)->J3_LOJA == cLojaCli .And. (cAliasSJ3)->J3_REGVEND == cRegiaoC .And. ;
							(cAliasSJ3)->J3_FILIAL == xFilial("SJ3") .And. (cAliasSJ3)->(!Eof()) .And. ;
							((cAliasSJ3)->J3_ANO == cAnoRela .Or. (cAliasSJ3)->J3_ANO == cAnoAnte)
							
							If cAnoAuxi == (cAliasSJ3)->J3_ANO
								If cAnoRela == cAnoAuxi
									cMesAuxi := "01"
									cAnoAuxi := cAnoRela
									i := 13 - Val(cMesRela)
								Else
									cMesAuxi := cMesInic
									i := 1
									nNoMeses := 0
								Endif
							Else
								cMesAuxi := "01"
								cAnoAuxi := (cAliasSJ3)->J3_ANO
							Endif
						Else
							//зддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Se finalizou os dados no ano anterior, acumular no  Ё
							//Ё nro. de meses os meses restante do ano final.       Ё
							//юддддддддддддддддддддддддддддддддддддддддддддддддддддды
							If cAnoAuxi == cAnoAnte .And. Year(RetFldProd(SB1->B1_COD,"B1_CONINI")) <= Val(cAnoAuxi)
								nNoMeses += Val(cMesRela)
							Endif
						Endif
					Endif
				End
			EndIf
			
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Grava somente se houver dados no periodo.           Ё
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If nQtdCons != 0 .Or. nNoMeses > 0
				nConsMed := nQtdCons / Iif(nNoMeses==0,1,nNoMeses)
				aRegQtde[Len(aRegQtde)][4] += Iif(nConsMed<=0,0,(nConsMed*nPrecoUn))
				
				dbSelectArea("TRB")
				dbSeek( cRegiaoC + cCliente + cLojaCli + cProduto )
				
				If Eof()
					RecLock("TRB",.T.)
					Replace REGIAO   With cRegiaoC, PRODUTO With cProduto, ;
					VAL_UNIT With nPrecoUn
					Replace CLIENTE  With cCliente, LOJACLI With cLojaCli
				Else
					RecLock("TRB")
				Endif
				//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Grava o valor do consumo em ordem decrescente de valor,   Ё
				//Ё para ordenacao pelo campo.                                Ё
				//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				nConsPrd := 10000000000000 - Iif(nConsMed > 0,(nConsMed * nPrecoUn),0.01)
				Replace VALCHAV With Right(StrZero(nConsPrd,17,nDecPrec),16)
				Replace VALCMED With (nConsMed * nPrecoUn)
				Replace MESCONS With nNoMeses
				Replace QTDECM  With nConsMed
				For i := 1 To 12
					FieldPut(FieldPos("QTDE"+StrZero(i,2)),aAcumVal[i])
				Next
				MsUnLock()
				dbSelectArea("SJ3")
			Endif
		End     // Cliente
	End        // Regiao
End           // Eof()

nTtGeral	:= 0
AEval( aRegQtde, { | x | nTtGeral += x[4] } )
dbSelectArea("TRB")
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Definicao dos cabecalhos                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If oReport:Section(1):GetOrder() == 1     // por % de participacao
	DbClearFilter()
	RetIndex("SJ3")
	dbSelectArea("TRB")
	DbSetOrder(2)
Endif
	
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁMetodo TrPosition()                                                     Ё
//Ё                                                                        Ё
//ЁPosiciona em um registro de uma outra tabela. O posicionamento serА     Ё
//Ёrealizado antes da impressao de cada linha do relatСrio.                Ё
//Ё                                                                        Ё
//Ё                                                                        Ё
//ЁExpO1 : Objeto Report da Secao                                          Ё
//ЁExpC2 : Alias da Tabela                                                 Ё
//ЁExpX3 : Ordem ou NickName de pesquisa                                   Ё
//ЁExpX4 : String ou Bloco de cСdigo para pesquisa. A string serА macroexe-Ё
//Ё        cutada.                                                         Ё
//Ё                                                                        Ё				
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
TRPosition():New(oReport:Section(1):Section(1)	,"SA1",1,{|| xFilial("SA1")+TRB->CLIENTE	})
TRPosition():New(oReport:Section(1),"SX5",1,{|| xFilial("SX5")+"A2"+cRegiaoC })


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis para movimentacao do cursor.                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("TRB")
oReport:SetMeter(RecCount())		// Total de Elementos da regua

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Impressao do relatorio.                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("TRB")
dbGoTop()
cQuebraReg	:= ""
oReport:Section(1):Init()
oReport:Section(1):Section(1):Init()  
oReport:Section(1):Section(1):Section(1):Init()  
oReport:Section(1):Section(1):Section(1):Section(1):Init()  
cQuebraReg := ""
While !oReport:Cancel() .And. TRB->(!Eof())
	
	cRegiaoC := TRB->REGIAO
	nTotRegi := 0
	AEval( aRegQtde, { | x | Iif(x[1]==cRegiaoC,nTotRegi += x[4],) } )
	nPorcPrd := Iif(nTtGeral==0,1,(nTotRegi / nTtGeral))*100
	
	If cQuebraReg <> TRB->REGIAO
		oReport:FatLine()
		oReport:SkipLine(2)

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Secao 01 - Regiao                                                      Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	    oRegiao:Cell("X5_DESCRI"):SetBlock({||AllTrim(SX5->X5_DESCRI)})
		oRegiao:Cell("NPORCPRD"):SetBlock({||STR0033 + Transform(nPorcPrd,"@E 999.99") + "%"})	
			
		oReport:Section(1):PrintLine()
		cQuebraReg := TRB->REGIAO
	EndIf	
	
	cCliente := TRB->CLIENTE
	cLojaCli := TRB->LOJACLI
	nAcPorce := 0
	nElement := AScan( aRegQtde, { | x | x[1]+x[2]+x[3] == cRegiaoC+cCliente+cLojaCli } )
    nTotCli  := 0
    AEval( aRegQtde, { | x | If(x[1]+x[2]+x[3] == cRegiaoC+cCliente+cLojaCli,nTotCli += x[4],) } )
	nPorcPrd := Iif(nTotRegi==0,1,(nTotCli / nTotRegi))*100

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Secao 02 - Cliente                                                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	oCliente:Cell("NOMECLI"):SetBlock({||FATPDObfuscate(SA1->A1_NOME,"A1_NOME")})    
	oCliente:Cell("NTOTCLI"):SetBlock({||nTotCli	})
			
	oReport:Section(1):Section(1):printLine()
		
	nContaIt := 1
	While TRB->CLIENTE == cCliente .And. TRB->LOJACLI == cLojaCli .And. ;
			TRB->REGIAO == cRegiaoC .And. TRB->(!Eof())
			
		If nContaIt <= mv_par11
			cProduto := TRB->PRODUTO
			SB1 -> ( dbSeek( xFilial("SB1") + cProduto ) )
			If mv_par12 == 1
				cDescProd := SB1->B1_DESC
			Else
				dbSelectArea("SA7")
				dbSetOrder(2)
				If dbSeek(xFilial()+cProduto+cCliente+cLojaCli)
					cDescProd := SA7->A7_DESCCLI
				Else
					cDescProd :=  SB1->B1_DESC
				Endif
			Endif
				
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Calcula classificacao ABC dos produtos.               Ё
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If nAcPorce <= mv_par05
				cClasse := "A"
			ElseIf nAcPorce <= (mv_par05 + mv_par06)
				cClasse := "B"
			Else
				cClasse := "C"
			Endif
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Calcula % do produto sobre o total do cliente.        Ё
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			nPorcPrd := Round(TRB->VALCMED / Iif(nTotCli<=0,0,nTotCli),5) * 100
				
			If nPorcPrd >= 0
				nAcPorce += nPorcPrd
				If nAcPorce > 100
					nDiferen := 100 - nAcPorce
					nPorcPrd += nDiferen
					nAcPorce := 100
				Endif
			Endif
				
			nTotAcum := 0
			aValores := {0,0,0,0,0,0,0,0,0,0,0,0}
			For ni = 1 To 12
				cInd := "TRB->QTDE"+StrZero(ni,2)
				nTotAcum += &cInd
				aValores[ni] := &cInd
				nG := ni
			Next

			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Secao 03 - Produto                                                     Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			oProd:Cell("CCLASSE"):SetBlock({||	cClasse })
			oProd:Cell("CDESCPROD"):SetBlock({||cDescProd })
			oProd:Cell("NACPORCE"):SetBlock({|| nAcPorce })	// "% Acum"
			
			oReport:Section(1):section(1):section(1):PrintLine()

			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Secao 04 - Valores Mensais                                             Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			oValores:Cell("NCOL01"):SetBlock({||aValores[01]	})
			oValores:Cell("NCOL02"):SetBlock({||aValores[02]	})
			oValores:Cell("NCOL03"):SetBlock({||aValores[03]	})
			oValores:Cell("NCOL04"):SetBlock({||aValores[04]	})
			oValores:Cell("NCOL05"):SetBlock({||aValores[05]	})
			oValores:Cell("NCOL06"):SetBlock({||aValores[06]	})
			oValores:Cell("NCOL07"):SetBlock({||aValores[07]	})
			oValores:Cell("NCOL08"):SetBlock({||aValores[08]	})
			oValores:Cell("NCOL09"):SetBlock({||aValores[09]	})
			oValores:Cell("NCOL10"):SetBlock({||aValores[10]	})
			oValores:Cell("NCOL11"):SetBlock({||aValores[11]	})
			oValores:Cell("NCOL12"):SetBlock({||aValores[12]	})
			oValores:Cell("NTOTACUM"):SetBlock({||nTotAcum })	// "Tot.Cons."

			oReport:Section(1):Section(1):Section(1):Section(1):PrintLine()
			nContaIt++
				
			dbSelectArea("TRB")
			TRB -> ( dbSkip() )
			oReport:IncMeter()
		Else
			dbSelectArea("TRB")
			dbSeek( cRegiaoC + Replicate("z",15), .T. )
			If cRegiaoC == TRB->REGIAO
				dbSkip()
			Endif
		Endif
	End
End

oReport:FatLine()
oReport:PrintText(STR0040 + Transform(nTtGeral,Tm(nTtGeral,16,2)))	// "Total Geral:"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Finaliza Secoes                                              Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oReport:Section(1):Section(1):Section(1):Section(1):Finish()
oReport:Section(1):Section(1):Section(1):Finish()
oReport:Section(1):Section(1):Finish()			
oReport:Section(1):Finish()	

If( valtype(oTempTable) == "O")
	dbSelectArea("TRB")
	oTempTable:Delete()
	freeObj(oTempTable)
	oTempTable := nil
EndIf

Return




//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa funГЦo quando nЦo houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuАrio utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serЦo verificados.
    @param aFields, Array, Array com todos os Campos que serЦo verificados, utilizado 
        apenas se parametro aAlias estiver vazio.
    @param cSource, Caractere, Nome do recurso para gerenciar os dados protegidos.
    
    @return cSource, Caractere, Retorna nome do recurso que foi adicionado na pilha.
    @example FATPDLoad("ADMIN", {"SA1","SU5"}, {"A1_CGC"})
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDLoad(cUser, aAlias, aFields, cSource)
	Local cPDSource := ""

	If FATPDActive()
		cPDSource := FTPDLoad(cUser, aAlias, aFields, cSource)
	EndIf

Return cPDSource


//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUnload
    @description
    Finaliza o gerenciamento dos campos com proteГЦo de dados.
	Remover essa funГЦo quando nЦo houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cSource, Caractere, Remove da pilha apenas o recurso que foi carregado.
    @return return, Nulo
    @example FATPDUnload("XXXA010") 
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDUnload(cSource)    

    If FATPDActive()
		FTPDUnload(cSource)    
    EndIf

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa funГЦo quando nЦo houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   




//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    FunГЦo que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  
