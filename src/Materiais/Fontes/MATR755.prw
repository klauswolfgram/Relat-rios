/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR755.CH" 
#INCLUDE "PROTHEUS.CH"

/*эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  Ё MATR755  Ё Autor Ё Marco Bianchi         Ё Data Ё 12/07/06 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Relatorio de Curva ABC de Consumo de Vendas por Regiao.    Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё SIGAFAT                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ*/
User Function MATR755()

Local oReport

//-- Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()

Return

/*эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  ЁReportDef Ё Autor Ё Marco Bianchi         Ё Data Ё 12/07/06 Ё╠╠
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
Local oFilReg
Local oProd
Local oValores
Local cAliasSJ3 	:= GetNextAlias()
Local nPorcPrd   	:= 0
Local nAcPorce  	:= 0

Private aValores 	:= {0,0,0,0,0,0,0,0,0,0,0,0}
Private nG	  	 	:= 0

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Funcao utilizada para verificar a ultima versao dos fontes      Ё
//Ё SIGACUS.PRW, SIGACUSA.PRX e SIGACUSB.PRX, aplicados no rpo do   |
//| cliente, assim verificando a necessidade de uma atualizacao     |
//| nestes fontes. NAO REMOVER !!!							        Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If !(FindFunction("SIGACUS_V") .and. SIGACUS_V() >= 20050512)
	Final("Atualizar patch do programa SIGACUS.PRW !!!")
EndIf
If !(FindFunction("SIGACUSA_V") .and. SIGACUSA_V() >= 20050512)
	Final("Atencao","Atualizar patch do programa SIGACUSA.PRX !!!")
EndIf
If !(FindFunction("SIGACUSB_V") .and. SIGACUSB_V() >= 20060920)
	Final("Atencao","Atualizar patch do programa SIGACUSB.PRX !!!")
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
oReport := TReport():New("MATR755",STR0045,"MTR755", {|oReport| ReportPrint(oReport,cAliasSJ3,oFilReg,oProd,oValores)},STR0034 + " " + STR0035 + " " + STR0036)	// "Curva ABC de Estoque"###"RelatСrio para mostrar as quantidades de vendas (consumos) de "###"produtos no estoque por regiao do cliente. "###"Este relatorio deverА ser impresso no formulАrio de 132 colunas."
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
//Ё Section(1)                                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oFilReg := TRSection():New(oReport,STR0069,{"SJ3"},{STR0042,STR0043,STR0044},/*Campos do SX3*/,/*Campos do SIX*/)	// "Regiao"###"Por % de Participacao"###"Por Codigo (Numerica)"###"Por Regiao + %Participacao"
oFilReg:SetTotalInLine(.F.)
oReport:Section(1):SetHeaderSection(.F.)

TRCell():New(oFilReg,"FILIAL"		,"TRB"	,RetTitle("J3_FILIAL"	)	,/*Picture*/,20,/*lPixel*/,{|| STR0066 + TRB->FILIAL 						})	// "Filial: "
TRCell():New(oFilReg,"REGIAO"		,"TRB"	,RetTitle("J3_REGVEND"	)	,/*Picture*/,11,/*lPixel*/,{|| STR0067 + TRB->REGIAO 						})	// "Regiao: "
TRCell():New(oFilReg,"X5_DESCRI"	,"SX5"	,STR0051				 	,			,50,/*lPixel*/,{|| AllTrim(SX5->X5_DESCRI)		 				})	// "Nome da Regiao"
TRCell():New(oFilReg,"NPORCPRD"		,		,STR0052				 	,			,20,/*lPixel*/,{|| STR0068 + Transform(nPorcPrd,"@E 999.99") 	})	// "Percentual: "

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Section(1):Section(1)                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oProd := TRSection():New(oFilReg,STR0070,{},/*{Array com as ordens do relatСrio}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Produto"
oProd:SetTotalInLine(.F.)
oReport:Section(1):Section(1):SetHeaderPage()

TRCell():New(oProd,"PRODUTO"	,"TRB",RetTitle("J3_PRODUTO"	)	,PesqPict("SJ3","J3_PRODUTO"	)	,TamSX3("J3_PRODUTO")[1]	,/*lPixel*/,{|| TRB->PRODUTO	})	// Codigo do Produto
TRCell():New(oProd,"CLASSE"		,"TRB",STR0065				 		,PesqPict("SJ3","J3_FATVEN"	)		,TamSX3("J3_FATVEN"	)[1]	,/*lPixel*/,{|| TRB->CLASSE		})	// Classe
TRCell():New(oProd,"B1_DESC"	,"SB1",RetTitle("B1_DESC"		)	,PesqPict("SB1","B1_DESC"		)	,TamSX3("B1_DESC"	)[1]	,/*lPixel*/,{|| TRB->PRODESC 	})	// Descricao do Produto
TRCell():New(oProd,"VAL_UNIT"	,"TRB",STR0037				 		,PesqPict("SJ3","J3_VALR01"	)		,TamSX3("J3_VALR01"	)[1]	,/*lPixel*/,{|| TRB->VAL_UNIT	})	// "Valor Unitario"
TRCell():New(oProd,"PROCPROD"	,"TRB",STR0038				 		,"@E 999.99"			 		 	,06							,/*lPixel*/,{|| TRB->PORCPROD	})	// "% Part"
TRCell():New(oProd,"NACPORCE"	,	  ,STR0039				 		,"@E 999.99"			 		 	,06							,/*lPixel*/,{|| nAcPorce 		})	// "% Acum"


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Section(1):Section(1):Section(1)                                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oValores := TRSection():New(oProd,STR0071,{},/*{Array com as ordens do relatСrio}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Valores"
oValores:SetTotalInLine(.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Impressao do Cabecalho da Secao 3 no topo da pagina                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oReport:Section(1):Section(1):Section(1):SetHeaderPage()
oReport:Section(1):SetEditCell(.F.)
oReport:Section(1):Section(1):SetEdit(.F.)
oReport:Section(1):Section(1):Section(1):SetEdit(.F.)

Return(oReport)

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  ЁReportPrinЁ Autor Ё Marco Bianchi         Ё Data Ё 12/07/06 Ё╠╠
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
Static Function ReportPrint(oReport,cAliasSJ3,oFilReg,oProd,oValores)

Local oBreak1
Local oBreak2
Local aNomeMes 	 	:= {STR0053,STR0054,STR0055,STR0056,STR0057,STR0058,STR0059,STR0060,STR0061,STR0062,STR0063,STR0064}		//"Jan"###"Fev"###"Mar"###"Abr"###"Mai"###"Jun"###"Jul"###"Ago"###"Set"###"Out"###"Nov"###"Dez"
Local aCampos    	:= {}
Local aRegQtde   	:= {}
Local aTam       	:= {}
Local aTamDesc      := {}
Local cProduto   	:= ""
Local cRegiaoC   	:= ""
Local cInd       	:= ""
Local nI         	:= 0
Local nTtGeral   	:= 0
Local nDecQtde   	:= 0
Local nElement   	:= 0
Local nContaIt   	:= 0
Local cQuebraReg 	:= ""
Local aCabec 	 	:= {"","","","","","","","","","","",""}
Local lIndexCod	 	:= .F.
Local oTempTable 	:= Nil
Local aFields		:= {}


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Calcula o mes/ano para o cabecalho.                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
For nI := 11 To 0 Step -1
	nMes := Val(StrZero(mv_par03,2)) - nI
	If nMes < 1
		nMes := 12 + nMes
		cAno := Str(Val(StrZero(mv_par04,4))-1,4)
	Else
		cAno := StrZero(mv_par04,4)
	Endif
	aCabec[12-nI] := aNomeMes[nMes] + "/" + cAno
Next

oReport:Section(1):Cell("NPORCPRD"):SetBlock({|| STR0068 + Transform(nPorcPrd,"@E 999.99") })
oReport:Section(1):Section(1):Cell("NACPORCE"):SetBlock({|| nAcPOrce })
nPorcPrd   := 0
nAcPorce 	 := 0

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё                                                                        Ё
//Ё                     Definicao das Celulas                              Ё
//Ё                                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Secao 03                                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
TRCell():New(oValores,"NCOL01"		,	  ,aCabec[01]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[01] 	})
TRCell():New(oValores,"NCOL02"		,	  ,aCabec[02]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[02] 	})
TRCell():New(oValores,"NCOL03"		,	  ,aCabec[03]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[03] 	})
TRCell():New(oValores,"NCOL04"		,	  ,aCabec[04]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[04] 	})
TRCell():New(oValores,"NCOL05"		,	  ,aCabec[05]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[05]		})
TRCell():New(oValores,"NCOL06"		,	  ,aCabec[06]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[06] 	})
TRCell():New(oValores,"NCOL07"		,	  ,aCabec[07]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[07] 	})
TRCell():New(oValores,"NCOL08"		,	  ,aCabec[08]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[08] 	})
TRCell():New(oValores,"NCOL09"		,	  ,aCabec[09]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[09] 	})
TRCell():New(oValores,"NCOL10"		,	  ,aCabec[10]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[10] 	})
TRCell():New(oValores,"NCOL11"		,	  ,aCabec[11]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[11] 	})
TRCell():New(oValores,"NCOL12"		,	  ,aCabec[12]	,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| aValores[12] 	})
TRCell():New(oValores,"QTDECM"		,"TRB",STR0040		,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| TRB->QTDECM 		})	// "C.M.M."
TRCell():New(oValores,"NTOTACUM"	,	  ,STR0041		,PesqPict("SJ3","J3_QUAR01"),TamSX3("J3_QUAR01")[1],/*lPixel*/,{|| nTotAcum 				})	// "Tot.Cons."

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Definicao das Quebras: por Regiao e por Filial                         Ё
//Ё As quebras sao definidas por celulas da Secao 1 e os campos que serao  Ё
//Ё totalizados pertencem a secao 3.                                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oBreak1 := TRBreak():New(oFilReg,oFilReg:Cell("REGIAO" ),"TOTAL DA REGIAO " ,.F.)
oBreak2 := TRBreak():New(oFilReg,oFilReg:Cell("FILIAL" ),"TOTAL DA FILIAL " ,.F.)

oTotal1 := TRFunction():New(oValores:Cell("NCOL01"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL02"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL03"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL04"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL05"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL06"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL07"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL08"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL09"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL10"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL11"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NCOL12"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("QTDECM"		),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1 := TRFunction():New(oValores:Cell("NTOTACUM"	),/* cID */,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

oTotal2 := TRFunction():New(oValores:Cell("NCOL01"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL02"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL03"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL04"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL05"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL06"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL07"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL08"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL09"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL10"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL11"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NCOL12"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("QTDECM"		),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)
oTotal2 := TRFunction():New(oValores:Cell("NTOTACUM"	),/* cID */,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilReg)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁTransforma parametros Range em expressao SQL                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
MakeSqlExpr(oReport:uParam)

If mv_par03 > 12 .Or. mv_par03 < 1
	mv_par03 := 12
Endif

If mv_par08 == 2
	cTipPrec := "S"      		// Preco Standard
ElseIf mv_par08 == 3
	cTipPrec := "C"      		// Preco de tabela informado no cad. de cliente
ElseIf mv_par08 == 4
	Pergunte("MR765B",.F.)    	// Preco de tabela informado pelo usuario
	Pergunte("MR765B",.T.)
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Variaveis utilizadas para parametros                         Ё
	//Ё mv_par01 // Nro. Tabela                                      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cTipPrec := mv_par01
	Pergunte("MTR755",.F.)
Else
	cTipPrec := "M"      		// Preco Medio
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Pesquisa o numero de casas decimais do valor e qtde.         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aFields	 := FWSX3Util():GetFieldStruct( "J3_QUAR01" )

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define estrutura e gera o arquivo de trabalho                Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aTam     := TamSX3("J3_REGVEND")
aTamDesc := TamSX3("B1_DESC")

aCampos := { { "REGIAO"  , "C"		 , aTam[1]		 ,aTam[2]	 },;
			 { "FILIAL"  , "C"		 , FWGETTAMFILIAL, 0		 },;
			 { "REC" 	 , "C"		 , 15			 , 0 		 },;
			 { "PRODUTO" , "C"		 , 15		  	 , 0		 },;
			 { "PRODESC" , "C"		 , aTamDesc[1]	 ,aTamDesc[2]},;
			 { "VALCHAV" , "C"		 , 16		  	, 0			 },;
			 { "MESCONS" , "N"		 , 02		  	, 0			 },;
			 { "CLASSE"  , "C"		 , 01		  	, 0			 },;
			 { "PORCPROD", "N"		 , 08		  	, 4			 },;
			 { "VAL_UNIT", "N"		 , 16		  	, 2			 },;
			 { "VALCMED" , "N"		 , 16		  	, 2			 },;
			 { "QTDE01"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE02"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE03"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE04"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE05"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE06"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE07"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE08"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE09"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE10"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE11"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDE12"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDECM"  , aFields[2], aFields[3] 	, aFields[4] },;
			 { "QTDECT"  , aFields[2], aFields[3] 	, aFields[4] }}

//-------------------------------------------------------------------
// Instancia tabela temporАria.  
//-------------------------------------------------------------------
oTempTable	:= FWTemporaryTable():New( "TRB" )

//-------------------------------------------------------------------
// Atribui o  os Мndices.  
//-------------------------------------------------------------------
oTempTable:SetFields( aCampos )

oTempTable:AddIndex("1",{"FILIAL","REGIAO","PRODUTO"})

oTempTable:AddIndex("2",{"FILIAL","REGIAO","VALCHAV"})

If oReport:Section(1):GetOrder() == 1				// por % de participacao
	oReport:SetTitle(oReport:Title() + " - " + GetMv("MV_MOEDA" + STR(mv_par10,1)) + STR0046 )	// "Curva ABC de Estoque"###" - ORDEM DE % DE PARTICIPACAO"

	oTempTable:AddIndex("3" ,{"FILIAL","REC"})
	
ElseIf oReport:Section(1):GetOrder() == 2          // " Por codigo (numerico)"
	oReport:SetTitle(STR0045+ " - " + GetMv("MV_MOEDA" + STR(mv_par10,1)) + STR0048 )	// "Curva ABC de Estoque"###" - ORDEM DE CODIGO (NUMERICA)"
	lIndexCod := .T.	
ElseIf oReport:Section(1):GetOrder() == 3			// "Por Regiao + %Participacao"
	oReport:SetTitle(STR0045+ " - " + GetMv("MV_MOEDA" + STR(mv_par10,1)) + STR0049 )	// "Curva ABC de Estoque"###" - ORDEM DE REGIAO + PARTICIPACAO"

	oTempTable:AddIndex("3",{"FILIAL","REGIAO","CLASSE","PRODUTO"})
	
Endif
//------------------
//CriaГЦo da tabela
//------------------
oTempTable:Create()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Gera arquivo de trabalho com dados do SJ3 - acum. mensais.   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aRegQtde 	:= MR755TraR4( cTipPrec,cAliasSJ3,oReport)
nTtGeral	:= 0

For nI :=1 To len(aRegQtde)
	nTtGeral += aRegQtde[nI][2]
Next

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё A classificacao ABC dos produtos sempre deve ser calculada   Ё
//Ё sobre o % de participacao em ordem decrescente.              Ё
//Ё Esta rotina calcula o % e a classe do produto.               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
MR755Clas( aRegQtde )

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
TRPosition():New(oReport:Section(1),"SX5",1,{|| xFilial("SX5")+"A2"+cRegiaoC })

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Impressao do relatorio.                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("TRB")
If lIndexCod
	Set Order to 1
Else
	Set Order to 3
EndIf
oReport:SetMeter(RecCount())		// Total de Elementos da regua
dbGoTop()

cQuebraReg	:= ""
oReport:Section(1):Init()
oReport:Section(1):Section(1):Init()  
oReport:Section(1):Section(1):Section(1):Init()  

While !oReport:Cancel() .And. TRB->(!Eof())
	
	cFilia   := TRB->FILIAL	
	cRegiaoC := TRB->REGIAO
	nElement := AScan( aRegQtde, { | x | x[1] == cRegiaoC .And. x[3] == cFilia } )
	nPorcPrd := IIF(nTtGeral == 0,100,(aRegQtde[nElement][2] / nTtGeral)*100)
	nContaIt := 1

	If cQuebraReg <> TRB->FILIAL+TRB->REGIAO
		oReport:Section(1):PrintLine()
		cQuebraReg := TRB->FILIAL+TRB->REGIAO      
		nAcPorce := 0
	EndIf	
	
	If nContaIt <= mv_par09
			
		cProduto := TRB->PRODUTO
		If TRB->PORCPROD >= 0
			nAcPorce += TRB->PORCPROD
		Endif
		
		nTotAcum := 0
		aValores := {0,0,0,0,0,0,0,0,0,0,0,0}
			
		For ni = 1 To 12
			cInd := "TRB->QTDE"+StrZero(ni,2)
			nTotAcum += &cInd
			aValores[ni] := &cInd
			nG := ni
		Next
			
		oReport:Section(1):Section(1):PrintLine()
		oReport:Section(1):Section(1):Section(1):PrintLine()

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Altera o Titulo dos Totalizadores                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		oBreak1:SetTotalText("TOTAL DA REGIAO " + TRB->REGIAO)
		oBreak2:SetTotalText("TOTAL DA FILIAL " + TRB->FILIAL)
			
		nContaIt++
		dbSelectArea("TRB")
		dbSkip()
		oReport:IncMeter()
			
	Else
						
		If cRegiaoC == TRB->REGIAO
			dbSelectArea("TRB")
			dbSkip()
		Endif
			
	Endif
		
EndDo

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Finaliza Secoes                                              Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oReport:Section(1):Section(1):Section(1):Finish()
oReport:Section(1):Section(1):Finish()			
oReport:Section(1):Finish()	

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha tabela de trabalho                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If( valtype(oTempTable) == "O")
	dbSelectArea("TRB")
	oTempTable:Delete()
	freeObj(oTempTable)
	oTempTable := nil
EndIf

Return

/*/
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤└o    ЁMR755TraR4Ё Revis Ё Alexandre Inacio LemesЁ Data Ё 02/03/01 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Gera arquivo de trabalho com dados do SJ3.                 Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё ExpA1 := MR755Trab( ExpC1,ExpC2,ExpC3,ExpC4,ExpC5,ExpN1)   Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁ ExpA1 - array contendo as regioes e valores totais de con- Ё╠╠
╠╠Ё          Ё         sumo da regiao                                     Ё╠╠
╠╠Ё          Ё ExpC1 - regiao inicial                                     Ё╠╠
╠╠Ё          Ё ExpC2 - regiao final                                       Ё╠╠
╠╠Ё          Ё ExpC3 - mes final do relatorio                             Ё╠╠
╠╠Ё          Ё ExpC4 - ano final do relatorio                             Ё╠╠
╠╠Ё          Ё ExpC5 - tipo de preco selecionado pelo usuario             Ё╠╠
╠╠Ё          Ё ExpN1 - numero de casas decimais do preco                  Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё MATR755                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function MR755TraR4( cTipPrec,cAliasSJ3,oReport )

Local aRegQtde := {}
Local aColunas := {}
Local cMesInic := ""
Local cAnoAnte := ""
Local nX       := 0
Local nPrecoUn := 0
Local nAno     := 0
Local nNMesCons:= 0
Local nValor   := 0
Local nRegQtde := 0
Local dIniCons := Ctod("")
Local dFimCons := dIniCons
Local cRec	   := "0"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Os 12 meses estao contidos em 1 ano ou 2 anos.               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If StrZero(mv_par03,2) == "12"
	cAnoAnte := StrZero(mv_par04,4)
	cMesInic := "01"
Else
	cAnoAnte := StrZero((Val(StrZero(mv_par04,4))-1),4)
	cMesInic := StrZero((Val(StrZero(mv_par03,2))+1),2)
EndIf
nAno := Val(cAnoAnte)
nMes := Val(cMesInic)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Calcula o MES/ANO de cada coluna do relatorio                Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
For nX := 1 To 12
	aadd(aColunas,{ StrZero(nAno,4) , StrZero(nMes,2) , StrZero(nX,2) } )
	nMes++
	If ( nMes > 12 )
		nMes := 1
		nAno++
	EndIf
	dFimCons := LastDay(Ctod("01/"+StrZero(nMes,2)+"/"+StrZero(nAno,4)))
Next nX
                          
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica o Filtro                                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SJ3")

oReport:Section(1):BeginQuery()

BeginSql Alias cAliasSJ3
SELECT *
FROM %Table:SJ3% SJ3
WHERE J3_FILIAL >= %Exp:mv_par11%  AND
J3_FILIAL <= %Exp:mv_par12% AND
J3_REGVEND >= %Exp:mv_par01% AND
J3_REGVEND <= %Exp:mv_par02% AND
(J3_ANO = %Exp:StrZero(mv_par04,4)% OR J3_ANO = %Exp:cAnoAnte%) AND
SJ3.%notdel%
ORDER BY J3_FILIAL,J3_REGVEND,J3_PRODUTO,J3_ANO,J3_FATVEN
EndSql

oReport:Section(1):EndQuery()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Grava TRB                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea(cAliasSJ3)
oReport:SetMeter(SJ3->(LastRec()))   // Total de Elementos da regua
While !oReport:Cancel() .And. (cAliasSJ3)->(!Eof())  
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Pesquisa a Filial/Regiao                                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nRegQtde := Ascan(aRegQtde,{|x| x[1] == (cAliasSJ3)->J3_REGVEND .And. x[3]==(cAliasSJ3)->J3_FILIAL })
	If ( nRegQtde == 0 )
		aadd(aRegQtde,{(cAliasSJ3)->J3_REGVEND,0,(cAliasSJ3)->J3_FILIAL})
		nRegQtde := Len(aRegQtde)
	EndIf
	
	cProduto := (cAliasSJ3)->J3_PRODUTO
	
	dbSelectArea("TRB")
	dbSetOrder(1)
	If !dbSeek( (cAliasSJ3)->J3_FILIAL + (cAliasSJ3)->J3_REGVEND + (cAliasSJ3)->J3_PRODUTO )
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Calcula o Valor Unitario conforme os parametros              Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		dbSelectArea("SB1")
		dbSeek( xFilial("SB1") + (cAliasSJ3)->J3_PRODUTO )
		
		Do Case
			Case cTipPrec == "S"
				nPrecoUn := xMoeda( RetFldProd(SB1->B1_COD,"B1_CUSTD"),Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),mv_par10,ddatabase)
			Case cTipPrec == "M" .Or. cTipPrec == "1"
				nPrecoUn := xMoeda(SB1->B1_PRV1,1,mv_par10,ddatabase)
			Case cTipPrec == "C"
				dbSelectArea("SA1")
				dbSetOrder(1)
				dbSeek( xFilial("SA1") + (cAliasSJ3)->J3_CLIENTE + (cAliasSJ3)->J3_LOJA )
				If Empty(SA1->A1_TABELA) .Or. SA1->A1_TABELA == "1"
					nPrecoUn := xMoeda(SB1->B1_PRV1,1,mv_par10,ddatabase)
				Else
					nPrecoUn := MaTabPrVen(SA1->A1_TABELA,cProduto,0,SA1->A1_COD,SA1->A1_LOJA,mv_par10,ddatabase)
				EndIf
			OtherWise
				nPrecoUn := MaTabPrVen(cTipPrec,cProduto,0,SJ3->J3_CLIENTE,SJ3->J3_LOJA,mv_par10,ddatabase)
		EndCase
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Calcula o numero de meses de consumo                         Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		dIniCons := LastDay(RetFldProd(SB1->B1_COD,"B1_CONINI"))
		nNmesCons := 0
		While	dIniCons < dFimCons
			nNmesCons++
			dIniCons++
			dIniCons := LastDay(dIniCons)
			If nNMescons >= 12
				Exit
			EndIf
		EndDo
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Atualiza o arquivo temporario                                Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cRec := AllTrim(Str(Val(cRec) + 1))
		RecLock("TRB",.T.)
		Replace FILIAL   With (cAliasSJ3)->J3_FILIAL
		Replace REGIAO   With (cAliasSJ3)->J3_REGVEND
		Replace PRODUTO  With (cAliasSJ3)->J3_PRODUTO
		Replace PRODESC  With SB1->B1_DESC
		Replace VAL_UNIT With nPrecoUn
		Replace MESCONS  With nNmesCons
		Replace REC  	 With cRec
	Else
		RecLock("TRB")
	EndIf
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Estorna o valor acumulado por regiao                         Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aRegQtde[nRegQtde][2] -= TRB->VALCMED
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Atualiza o consumo dos ultimos 12 meses                      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	For nX := 1 To Len(aColunas)
		If ( aColunas[nX,1] == (cAliasSJ3)->J3_ANO )
			nValor := (cAliasSJ3)->(FieldGet(FieldPos("J3_QUAR"+aColunas[nX,2])))
			FieldPut(FieldPos("QTDE"+aColunas[nX,3]),nValor+FieldGet(FieldPos("QTDE"+aColunas[nX,3])))
			Replace QTDECT With QTDECT + nValor
		EndIf
	Next nX
	Replace QTDECM  With QTDECT/MESCONS
	Replace VALCMED With QTDECM * nPrecoUn
	Replace VALCHAV With Right(StrZero(10000000000000-Max(TRB->VALCMED,0.01),17,2),16)
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Soma o valor acumulado por regiao                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aRegQtde[nRegQtde][2] += TRB->VALCMED
	
	MsUnLock()
	
	dbSelectArea(cAliasSJ3)
	dbSkip()
	oReport:IncMeter()
	
EndDo

Return aRegQtde

/*/
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤└o    Ё MR755ClasЁRev.   Ё Alexandre Inacio LemesЁ Data Ё 02/03/01 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Calcula o % e a classe de cada produto dentro da regiao.   Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё Void := MR755Clas( ExpA1 )                                 Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁ ExpA1 - array com regiao e valor total de consumo (regiao) Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё MATR755                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function MR755Clas( aRegQtde)

LOCAL aElement := {}
LOCAL cRegiaoC := ""
LOCAL cClassif := ""
LOCAL nPorcPrd := 0
LOCAL nAcPorce := 0

Default aRegQtde:= {}
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis para movimentacao do cursor.                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("TRB")
DbSetOrder(2)

dbGoTop()

cFilia   := TRB->FILIAL
cRegiaoC := TRB->REGIAO

aElement := AScan( aRegQtde, { | x | x[1] == cRegiaoC .And. x[3] == cFilia } )
nAcPorce := 0

While TRB->(!Eof())
	
	If  TRB->FILIAL != cFilia .Or. TRB->REGIAO != cRegiaoC
		
		cFilia   := TRB->FILIAL
		cRegiaoC := TRB->REGIAO
		
		aElement := AScan( aRegQtde, { | x | x[1] == cRegiaoC .And. x[3] == cFilia } )
		nAcPorce := 0
		
	Endif
	
	If TRB->FILIAL == cFilia .Or. TRB->REGIAO == cRegiaoC //  .Or. TRB->(!Eof())
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Calcula classificacao ABC dos produtos.               Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		
		If nAcPorce <= mv_par05
			cClassif := "A"
		ElseIf nAcPorce <= (mv_par05 + mv_par06)
			cClassif := "B"
		Else
			cClassif := "C"
		Endif
		
		If !Empty( aRegQtde ) .And. !Empty( aElement )
			If aRegQtde[aElement][2] <= 0
				nPorcPrd := 100
			Else
				nPorcPrd := Round(TRB->VALCMED / aRegQtde[aElement][2],4) * 100
			Endif
			nAcPorce += nPorcPrd
		EndIf 
		
		
		If nAcPorce > 100
			nDiferen := nAcPorce - 100
			nAcPorce := 100
			nPorcPrd := Iif( nPorcPrd < nDiferen, 0, (nPorcPrd - nDiferen) )
		Endif
		
		RecLock("TRB")
		Replace CLASSE With cClassif, PORCPROD With nPorcPrd
		MsUnLock()
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Movimentacao do cursor.                                      Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		dbSelectArea("TRB")
		dbSkip()
		
	Endif
	
EndDo

Return .T. 
