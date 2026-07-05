/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR730.CH" 
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR730  ³ Autor ³ Marco Bianchi         ³ Data ³ 10/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pre Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT-R4                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR730()

Local oReport
Local aPDFields	:= {"A1_NOME","A1_END","A1_ENDENT","A1_CGC","A1_INSCR","A3_NOME","A1_CEPE","A1_CEP","A2_NOME","A2_CGC","A2_END"}

FATPDLoad(Nil,Nil,aPDFields)

If FindFunction("TRepInUse") .And. TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	U_MATR730R3()
EndIf

FATPDUnload()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 10/07/06 ³±±
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
Local oPreNota
Local nValImp  	:= 0
Local nUltLib  	:= 0
Local aCabPed	:= {}
Local aItemPed  := {}
Local nItem 	:= 0
Local nTamData  := Len(DTOC(MsDate()))

Private aCodImps:= {}
Private nI		:= 0
Private nTotQtd := 0
Private nTotVal := 0

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
oReport := TReport():New("MATR730",STR0050,"MTR730", {|oReport| ReportPrint(oReport,oPreNota,@nItem,aItemPed,aCabPed)},STR0051 + " " + STR0052)	// "Emissao da Confirmacao do Pedido"###"Emissao da confirmacao dos pedidos de venda, de acordo com"###"intervalo informado na opcaoo Parametros."
oReport:SetLandscape() 
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
//³ Secao dos itens do Pedido de Vendas                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPreNota := TRSection():New(oReport,STR0108,{"SC5","SC6"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Emissao da Confirmacao do Pedido"
oPreNota:SetTotalInLine(.F.)

TRCell():New(oPreNota,"AITEM01",/*Tabela*/,STR0053					 ,PesqPict("SC6","C6_ITEM"		),TamSx3("C6_ITEM"		)[1],/*lPixel*/,{|| aItemPed[nItem][01] 																	})	// "IT"
TRCell():New(oPreNota,"AITEM02",/*Tabela*/,RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| aItemPed[nItem][02] 																	})	// Codigo do Produto
TRCell():New(oPreNota,"AITEM03",/*Tabela*/,RetTitle("C6_DESCRI"	),PesqPict("SC6","C6_DESCRI"	),TamSx3("C6_DESCRI"	)[1],/*lPixel*/,{|| IIF(Empty(aItemPed[nItem][03]),SB1->B1_DESC, aItemPed[nItem][03])						})	// Descricao do Produto
TRCell():New(oPreNota,"AITEM04",/*Tabela*/,STR0054					 ,PesqPict("SC6","C6_TES"		),TamSx3("C6_TES"		)[1],/*lPixel*/,{|| aItemPed[nItem][04] 																	})	// "TES"
TRCell():New(oPreNota,"AITEM05",/*Tabela*/,STR0055					 ,PesqPict("SC6","C6_CF"		),TamSx3("C6_CF"		)[1],/*lPixel*/,{|| aItemPed[nItem][05] 																	})	// "CF"
TRCell():New(oPreNota,"AITEM06",/*Tabela*/,STR0056					 ,PesqPict("SC6","C6_UM"		),TamSx3("C6_UM"		)[1],/*lPixel*/,{|| aItemPed[nItem][06] 																	})	// "UM"
TRCell():New(oPreNota,"AITEM07",/*Tabela*/,STR0057					 ,PesqPictQt("C6_QTDVEN"	    ),TamSx3("C6_QTDVEN"	)[1],/*lPixel*/,{|| aItemPed[nItem][07] 																	})	// "Quant."
TRCell():New(oPreNota,"AITEM08",/*Tabela*/,RetTitle("C6_PRCVEN"	),PesqPict("SC6","C6_PRCVEN"	),TamSx3("C6_PRCVEN"	)[1],/*lPixel*/,{|| aItemPed[nItem][08] 																	})	// Preco Unitario
If cPaisLoc == "BRA"
	TRCell():New(oPreNota,"NALIQIPI",/*Tabela*/	,STR0058,"@e 99.99"				,5,/*lPixel*/,{|| MaFisRet(nItem,"IT_ALIQIPI") 																											})	// "IPI"
	TRCell():New(oPreNota,"NALIQICM",/*Tabela*/	,STR0059,"@e 99.99"				,5,/*lPixel*/,{|| MaFisRet(nItem,"IT_ALIQICM") 																											})	// "ICM"
	TRCell():New(oPreNota,"NALIQISS",/*Tabela*/	,STR0060,"@e 99.99"				,5,/*lPixel*/,{|| MaFisRet(nItem,"IT_ALIQISS") 																											})	// "ISS"
Else
	TRCell():New(oPreNota,"NVALIMP"	,/*Tabela*/	,STR0058,Tm(nValImp,10,2)	,5,/*lPixel*/,{|| Tm(nValImp,10,2) 																														})	// "IPI"
EndIf
TRCell():New(oPreNota,"AITEM13",/*Tabela*/,STR0061						,PesqPict("SC6","C6_VALOR"		),TamSx3("C6_VALOR"		)[1],/*lPixel*/,{|| aItemPed[nItem][13]+nValImp 														})	// "Vl.Tot.C/IPI"
TRCell():New(oPreNota,"AITEM14",/*Tabela*/,RetTitle("C6_ENTREG"	)	,PesqPict("SC6","C6_ENTREG"		),nTamData					,/*lPixel*/,{|| aItemPed[nItem][14] 																},,,,,,.F.)	// Data de Entrega
TRCell():New(oPreNota,"AITEM15",/*Tabela*/,RetTitle("C6_DESCONT"	)	,PesqPict("SC6","C6_DESCONT"	),TamSx3("C6_DESCONT"	)[1],/*lPixel*/,{|| aItemPed[nItem][15] 																})	// % Desconto
TRCell():New(oPreNota,"AITEM16",/*Tabela*/,STR0062						,PesqPict("SC6","C6_LOCAL"		),TamSx3("C6_LOCAL"		)[1],/*lPixel*/,{|| aItemPed[nItem][16] 																})	// "Loc."
TRCell():New(oPreNota,"AITEM17",/*Tabela*/,STR0063						,PesqPictQt("C6_QTDLIB"		    ),TamSx3("C6_QTDLIB"	)[1],/*lPixel*/,{|| aItemPed[nItem][17] 												  				})	// "Qtd.a Fat."
TRCell():New(oPreNota,"NSALDO" ,/*Tabela*/,STR0064						,PesqPictQt("C6_QTDLIB"		    ),TamSx3("C6_QTDLIB"	)[1],/*lPixel*/,{|| aItemPed[nItem][07]-aItemPed[nItem][17]+aItemPed[nItem][18]-aItemPed[nItem][19]	})	// "Saldo"
TRCell():New(oPreNota,"NULTLIB",/*Tabela*/,STR0065						,PesqPictQt("D2_QUANT",10	    ),TamSx3("D2_QUANT"		)[1],/*lPixel*/,{|| nUltLib 																			})	// "Ult.Fat."

TRFunction():New(oPreNota:Cell("AITEM07"),"AITEM07"/* cID */,"ONPRINT",/*oBreak*/,/*cTitle*/,PesqPict("SC6","C6_QTDVEN",20),{|| nTotQtd }/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oPreNota:Cell("AITEM13"),"AITEM13"/* cID */,"ONPRINT",/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| nTotVal }/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao dos Impostos                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oImpostos := TRSection():New(oReport,STR0109,{"SC5","SC6","SD1","SB1","SD2","SA1","SA2","SA4","SE4","SA3","SX3"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Emissao da Confirmacao do Pedido"
oImpostos:SetTotalInLine(.F.)
If cPaisLoc == "BRA"
	TRCell():New(oImpostos,"NF_BASEICM"	,/*Tabela*/,STR0087,PesqPict("SF2","F2_BASEICM"),TamSx3("F2_BASEICM"		)[1],/*lPixel*/,{|| MaFisRet(,"NF_BASEICM") 	})	// "Base Icms"
	TRCell():New(oImpostos,"NF_VALICM"	,/*Tabela*/,STR0088,PesqPict("SF2","F2_VALICM") ,TamSx3("F2_VALICM"		)[1],/*lPixel*/,{|| MaFisRet(,"NF_VALICM"	) 	})	// "Valor Icms"
	TRCell():New(oImpostos,"NF_BASEIPI"	,/*Tabela*/,STR0089,PesqPict("SF2","F2_BASEIPI"),TamSx3("F2_BASEIPI"		)[1],/*lPixel*/,{|| MaFisRet(,"NF_BASEIPI") 	})	// "Base Ipi"
	TRCell():New(oImpostos,"NF_VALIPI"	,/*Tabela*/,STR0090,PesqPict("SF2","F2_VALIPI") ,TamSx3("F2_VALIPI"		)[1],/*lPixel*/,{|| MaFisRet(,"NF_VALIPI"	) 	})	// "Valor Ipi"
	TRCell():New(oImpostos,"NF_BASESOL"	,/*Tabela*/,STR0091,PesqPict("SF2","F2_BRICMS") ,TamSx3("F2_BRICMS"		)[1],/*lPixel*/,{|| MaFisRet(,"NF_BASESOL") 	})	// "Base Retido"
	TRCell():New(oImpostos,"NF_VALSOL"	,/*Tabela*/,STR0092,PesqPict("SF2","F2_ICMSRET"),TamSx3("F2_ICMSRET"		)[1],/*lPixel*/,{|| MaFisRet(,"NF_VALSOL"	) 	})	// "Valor Retido"
	TRCell():New(oImpostos,"NF_TOTAL"	,/*Tabela*/,STR0093,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT"	    	)[1],/*lPixel*/,{|| MaFisRet(,"NF_TOTAL"	) 	})	// "Valor Total"
	TRCell():New(oImpostos,"NF_BASEISS"	,/*Tabela*/,STR0094,PesqPict("SF2","F2_BASEISS"),TamSx3("F2_BASEISS"		)[1],/*lPixel*/,{|| MaFisRet(,"NF_BASEISS") 	})	// "Base Iss"
	TRCell():New(oImpostos,"NF_VALISS"	,/*Tabela*/,STR0095,PesqPict("SF2","F2_VALISS") ,TamSx3("F2_VALISS"		)[1],/*lPixel*/,{|| MaFisRet(,"NF_VALISS"	) 	})	// "Valor Iss"
Else
	TRCell():New(oImpostos,"aCodImps2"	,/*Tabela*/,STR0096,/*Picture*/			,13,/*lPixel*/,{|| aCodImps[nI][2] 		})	// "Imposto"
	TRCell():New(oImpostos,"aCodImps3"	,/*Tabela*/,STR0097,"@E 99,999,999.99"	,13,/*lPixel*/,{|| aCodImps[nI][3] 		})	// "Base"
	TRCell():New(oImpostos,"aCodImps4"	,/*Tabela*/,STR0098,"@E 99,999,999.99"	,13,/*lPixel*/,{|| aCodImps[nI][4] 		})	// "Aliquota"
	TRCell():New(oImpostos,"aCodImps5"	,/*Tabela*/,STR0099,"@E 99,999,999.99"	,13,/*lPixel*/,{|| aCodImps[nI][5]			})	// "Valor"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Troca descricao do total dos itens                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):SetTotalText(STR0085)	// "T O T A I S "

TRPosition():New(oPreNota,"SC6",1,{|| xFilial("SC5") + aCabPed[07]+aItemPed[nItem][01]})
TRPosition():New(oPreNota,"SC5",1,{|| xFilial("SC6") + aCabPed[07]+aItemPed[nItem][01]})

oReport:Section(2):SetEdit(.F.) 
oReport:Section(1):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alinhamento a direita as colunas de valor                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPreNota:Cell("AITEM07"):SetHeaderAlign("RIGHT")
oPreNota:Cell("AITEM08"):SetHeaderAlign("RIGHT")
If cPaisLoc == "BRA"
	oPreNota:Cell("NALIQIPI"):SetHeaderAlign("RIGHT")
	oPreNota:Cell("NALIQICM"):SetHeaderAlign("RIGHT")
	oPreNota:Cell("NALIQISS"):SetHeaderAlign("RIGHT")

	oImpostos:Cell("NF_BASEICM"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_VALICM"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_BASEIPI"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_VALIPI"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_BASESOL"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_VALSOL"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_TOTAL"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_BASEISS"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_VALISS"):SetHeaderAlign("RIGHT")

Else
	oPreNota:Cell("NVALIMP"):SetHeaderAlign("RIGHT")	

	oImpostos:Cell("aCodImps2"):SetHeaderAlign("RIGHT")	
	oImpostos:Cell("aCodImps3"):SetHeaderAlign("RIGHT")	
	oImpostos:Cell("aCodImps4"):SetHeaderAlign("RIGHT")	
	oImpostos:Cell("aCodImps5"):SetHeaderAlign("RIGHT")	
EndIf
oPreNota:Cell("AITEM13"):SetHeaderAlign("RIGHT")	
oPreNota:Cell("AITEM17"):SetHeaderAlign("RIGHT")	
oPreNota:Cell("NSALDO"):SetHeaderAlign("RIGHT")	
oPreNota:Cell("NULTLIB"):SetHeaderAlign("RIGHT")	
Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 10/07/06 ³±±
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
Static Function ReportPrint(oReport,oPreNota,nItem,aItemPed,aCabPed)

Local aPedCli    := {}
Local aC5Rodape  := {}
Local aRelImp    := MaFisRelImp("MT100",{"SF2","SD2"})
Local aFisGet    := Nil
Local aFisGetSC5 := Nil
Local cAliasSC5  := "SC5"
Local cAliasSC6  := "SC6"
Local cQryAd     := ""
Local cPedido    := ""
Local cCliEnt	 := ""
Local cNfOri     := Nil
Local cSeriOri   := Nil
Local nDesconto  := 0
Local nPesLiq    := 0
Local nRecSD1SD2 := Nil
Local nG		 := 0
Local nFrete	 := 0
Local nSeguro	 := 0
Local nFretAut	 := 0
Local nDespesa	 := 0
Local nDescCab	 := 0
Local nPDesCab	 := 0
Local nY         := 0
Local nValMerc   := 0
Local nPrcLista  := 0
Local nAcresFin  := 0
Local nCont		 := 0
Local aValMerc	 := {}
Local nT		 := 0
Local nTamPrcVen := TamSX3("C6_PRCVEN")[2]
Local cFilialSC6 := xFilial("SC6")
Local cFilialSF4 := xFilial("SF4")
Local cFilialSB1 := xFilial("SB1")
Local nPesoTot	 := 0
Local nVlrPesoUnit:= 0
Local lPedComp	 := .F.
Local lnDescTP	 := SuperGetMv("MV_NDESCTP",.F.,.F.)
Local lRndIss	 := SuperGetMv("MV_RNDISS",,.F.)
Local lTpDpInd	 := SuperGetMv("MV_TPDPIND",.F.,.F.) == "1"
Local nTotDesc   := 0
Local nQtdIts	 := 0
Local nItemPed	 := 0

FisGetInit(@aFisGet,@aFisGetSC5)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQryAd := "%"
For nY := 1 To Len(aFisGet)
	cQryAd += ","+aFisGet[nY][2]
Next nY
For nY := 1 To Len(aFisGetSC5)
	cQryAd += ","+aFisGetSC5[nY][2]
Next nY		
cQryAd += "%"

cAliasSC5:= cAliasSC6:= GetNextAlias()

oReport:Section(1):BeginQuery()
BeginSql Alias cAliasSC5
SELECT SC5.R_E_C_N_O_ SC5REC,SC6.R_E_C_N_O_ SC6REC,
SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,
SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_PBRUTO,SC5.C5_PESOL,SC5.C5_DESC1,
SC5.C5_DESC2,SC5.C5_DESC3,SC5.C5_DESC4,SC5.C5_MENNOTA,SC5.C5_EMISSAO,
SC5.C5_CONDPAG,SC5.C5_FRETE,SC5.C5_DESPESA,SC5.C5_FRETAUT,SC5.C5_TPFRETE,SC5.C5_SEGURO,SC5.C5_TABELA,
SC5.C5_VOLUME1,SC5.C5_ESPECI1,SC5.C5_MOEDA,SC5.C5_REAJUST,SC5.C5_BANCO,
SC5.C5_ACRSFIN,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,
SC5.C5_COMIS1,SC5.C5_COMIS2,SC5.C5_COMIS3,SC5.C5_COMIS4,SC5.C5_COMIS5,SC5.C5_PDESCAB,SC5.C5_DESCONT,C5_INCISS,
SC5.C5_CLIENT,
SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PEDCLI,SC6.C6_PRODUTO,
SC6.C6_TES,SC6.C6_CF,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,
SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_DESCRI,SC6.C6_UM,
SC6.C6_PRCVEN,SC6.C6_NOTA,SC6.C6_SERIE,SC6.C6_CLI,
SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_DESCONT,SC6.C6_LOCAL,
SC6.C6_QTDEMP,SC6.C6_QTDLIB,SC6.C6_QTDENT,SC6.C6_NFORI,SC6.C6_SERIORI,SC6.C6_ITEMORI
%Exp:cQryAd%
FROM %Table:SC5% SC5, %Table:SC6% SC6
WHERE
SC5.C5_FILIAL = %xFilial:SC5% AND
SC5.C5_NUM >= %Exp:mv_par01% AND
SC5.C5_NUM <= %Exp:mv_par02% AND
SC5.%notdel% AND
SC6.C6_FILIAL = %xFilial:SC6% AND
SC6.C6_NUM   = SC5.C5_NUM AND
SC6.%notdel%
ORDER BY SC5.C5_NUM, SC6.C6_ITEM
EndSql
oReport:section(1):endQuery()
(cAliasSC5)->( dbEval( {|| nCont++ } ) )
(cAliasSC5)->( dbGoTop() )
oReport:SetMeter(nCont)		// Total de Elementos da regua

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While !oReport:Cancel() .And. !((cAliasSC5)->(Eof())) .and. xFilial("SC5")==(cAliasSC5)->C5_FILIAL

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a validacao dos filtros do usuario           	     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cAliasSC5)

	cCliEnt := IIf(!Empty((cAliasSC5)->(FieldGet(FieldPos("C5_CLIENT")))),(cAliasSC5)->C5_CLIENT,(cAliasSC5)->C5_CLIENTE)
	aCabPed := {}

	MaFisIni(cCliEnt,;						// 1-Codigo Cliente/Fornecedor
		(cAliasSC5)->C5_LOJACLI,;			// 2-Loja do Cliente/Fornecedor
		If((cAliasSC5)->C5_TIPO$'DB',"F","C"),;	// 3-C:Cliente , F:Fornecedor
		(cAliasSC5)->C5_TIPO,;				// 4-Tipo da NF
		(cAliasSC5)->C5_TIPOCLI,;			// 5-Tipo do Cliente/Fornecedor
		aRelImp,;							// 6-Relacao de Impostos que suportados no arquivo
		,;						   			// 7-Tipo de complemento
		,;									// 8-Permite Incluir Impostos no Rodape .T./.F.
		"SB1",;								// 9-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
		"MATA461")							// 10-Nome da rotina que esta utilizando a funcao
	//Na argentina o calculo de impostos depende da serie.
	If cPaisLoc == 'ARG'
		SA1->(DbSetOrder(1))
		SA1->(MsSeek(xFilial()+(cAliasSC5)->C5_CLIENTE+(cAliasSC5)->C5_LOJACLI))
		MaFisAlt('NF_SERIENF',LocXTipSer('SA1',MVNOTAFIS))
	Endif

	nFrete		:= (cAliasSC5)->C5_FRETE
	nSeguro		:= (cAliasSC5)->C5_SEGURO
	nFretAut	:= (cAliasSC5)->C5_FRETAUT
	nDespesa	:= (cAliasSC5)->C5_DESPESA
	nDescCab	:= (cAliasSC5)->C5_DESCONT
	nPDesCab	:= (cAliasSC5)->C5_PDESCAB

	aItemPed:= {}
	aCabPed := {	(cAliasSC5)->C5_TIPO	,;
		(cAliasSC5)->C5_CLIENTE				,;
		(cAliasSC5)->C5_LOJACLI				,;
		(cAliasSC5)->C5_TRANSP				,;
		(cAliasSC5)->C5_CONDPAG				,;
		(cAliasSC5)->C5_EMISSAO				,;
		(cAliasSC5)->C5_NUM					,;
		(cAliasSC5)->C5_VEND1				,;
		(cAliasSC5)->C5_VEND2				,;
		(cAliasSC5)->C5_VEND3				,;
		(cAliasSC5)->C5_VEND4				,;
		(cAliasSC5)->C5_VEND5				,;
		(cAliasSC5)->C5_COMIS1				,;
		(cAliasSC5)->C5_COMIS2				,;
		(cAliasSC5)->C5_COMIS3				,;
		(cAliasSC5)->C5_COMIS4				,;
		(cAliasSC5)->C5_COMIS5				,;
		(cAliasSC5)->C5_FRETE				,;
		(cAliasSC5)->C5_TPFRETE				,;
		(cAliasSC5)->C5_SEGURO				,;
		(cAliasSC5)->C5_TABELA				,;
		(cAliasSC5)->C5_VOLUME1				,;
		(cAliasSC5)->C5_ESPECI1				,;
		(cAliasSC5)->C5_MOEDA				,;
		(cAliasSC5)->C5_REAJUST				,;
		(cAliasSC5)->C5_BANCO				,;
		(cAliasSC5)->C5_ACRSFIN				 ;
		}
	nTotQtd 	:= 0
	nTotVal 	:= 0
	nPesBru		:= 0
	nPesLiq		:= 0
	aPedCli		:= {}
	cPedido		:= (cAliasSC5)->C5_NUM
	aC5Rodape	:= {}
	nTotDesc	:= 0
	
	aadd(aC5Rodape,{(cAliasSC5)->C5_PBRUTO,(cAliasSC5)->C5_PESOL,(cAliasSC5)->C5_DESC1,(cAliasSC5)->C5_DESC2,;
		(cAliasSC5)->C5_DESC3,(cAliasSC5)->C5_DESC4,(cAliasSC5)->C5_MENNOTA})

	aPedCli := Mtr730Cli(cPedido)

	dbSelectArea(cAliasSC5)
	For nY := 1 to Len(aFisGetSC5)
		If !Empty(&(aFisGetSC5[ny][2]))
			If aFisGetSC5[ny][1] == "NF_SUFRAMA"
				MaFisAlt(aFisGetSC5[ny][1],Iif(&(aFisGetSC5[ny][2]) == "1",.T.,.F.),Len(aItemPed),.T.)		
			Else
				MaFisAlt(aFisGetSC5[ny][1],&(aFisGetSC5[ny][2]),Len(aItemPed),.T.)
			Endif	
		EndIf
	Next nY

	While !oReport:Cancel() .And. !((cAliasSC6)->(Eof())) .And. cFilialSC6==(cAliasSC6)->C6_FILIAL .And.;
			(cAliasSC6)->C6_NUM == cPedido

		oReport:IncMeter()

		cNfOri     := Nil
		cSeriOri   := Nil
		nRecSD1SD2 := 0
		nDesconto  := 0

		SC5->(DbSetOrder(1))
		SC5->(MsSeek((cAliasSC6)->C6_FILIAL+(cAliasSC6)->C6_NUM))
		lPedComp := (SC5->C5_TIPO == "C")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Se o pedido for do tipo Complemento, posiciona na SD2, caso   ³
		//³contrário, posiciona na SD1									 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cAliasSC6)->C6_NFORI)
			If lPedComp
				dbSelectArea("SD2")
				dbSetOrder(3)
				If MsSeek(cFilialSC6+(cAliasSC6)->C6_NFORI+(cAliasSC6)->C6_SERIORI+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA+;
					(cAliasSC6)->C6_PRODUTO+(cAliasSC6)->C6_ITEMORI)
					nRecSD1SD2  := SD2->(RECNO())
				EndIf
			Else
				dbSelectArea("SD1")
				dbSetOrder(1)
				If MsSeek(cFilialSC6+(cAliasSC6)->C6_NFORI+(cAliasSC6)->C6_SERIORI+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA+;
					(cAliasSC6)->C6_PRODUTO+(cAliasSC6)->C6_ITEMORI)
					nRecSD1SD2  := SD1->(RECNO())
				EndIf
			EndIf
			cNfOri     := (cAliasSC6)->C6_NFORI
			cSeriOri   := (cAliasSC6)->C6_SERIORI
		EndIf
		dbSelectArea(cAliasSC6)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcula o preco de lista                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nValMerc  := (cAliasSC6)->C6_VALOR
		nPrcLista := (cAliasSC6)->C6_PRUNIT
		If ( nPrcLista == 0 )
			nPrcLista := NoRound(nValMerc/(cAliasSC6)->C6_QTDVEN,nTamPrcVen)
		ElseIf lnDescTP .And. (cAliasSC6)->C6_VALDESC  == 0 //Tratamento para configuração do MV_NDESCTP como feito pela planilha.
			nPrcLista := A410Arred(nValMerc / (cAliasSC6)->C6_QTDVEN ,"D2_TOTAL")
		EndIf
		nAcresFin := A410Arred((cAliasSC6)->C6_PRCVEN*(cAliasSC5)->C5_ACRSFIN/100,"D2_PRCVEN")
		nValMerc  += A410Arred((cAliasSC6)->C6_QTDVEN*nAcresFin,"D2_TOTAL")		
		nDesconto := a410Arred(nPrcLista*(cAliasSC6)->C6_QTDVEN,"D2_DESCON")-nValMerc
		nDesconto := IIf(nDesconto==0,(cAliasSC6)->C6_VALDESC,nDesconto)
		nDesconto := Max(0,nDesconto)
		nPrcLista += nAcresFin
		If cPaisLoc=="BRA"
			nValMerc  += nDesconto
		EndIf			
		
		MaFisAdd((cAliasSC6)->C6_PRODUTO	,;	// 1-Codigo do Produto ( Obrigatorio )
			(cAliasSC6)->C6_TES				,;	// 2-Codigo do TES ( Opcional )
			(cAliasSC6)->C6_QTDVEN			,;	// 3-Quantidade ( Obrigatorio )
			nPrcLista						,;	// 4-Preco Unitario ( Obrigatorio )
			nDesconto						,;	// 5-Valor do Desconto ( Opcional )
			cNfOri							,;	// 6-Numero da NF Original ( Devolucao/Benef )
			cSeriOri						,;	// 7-Serie da NF Original ( Devolucao/Benef )
			nRecSD1SD2						,;	// 8-RecNo da NF Original no arq SD1/SD2
			0								,;	// 9-Valor do Frete do Item ( Opcional )
			0								,;	// 10-Valor da Despesa do item ( Opcional )
			0								,;	// 11-Valor do Seguro do item ( Opcional )
			0								,;	// 12-Valor do Frete Autonomo ( Opcional )
			nValMerc						,;	// 13-Valor da Mercadoria ( Obrigatorio )
			0								,;	// 14-Valor da Embalagem ( Opiconal )
			0								,;	// 15-RecNo do SB1
			0								)	// 16-RecNo do SF4
	
		aadd(aItemPed,	{	(cAliasSC6)->C6_ITEM	,;
			(cAliasSC6)->C6_PRODUTO					,;
			(cAliasSC6)->C6_DESCRI					,;
			(cAliasSC6)->C6_TES						,;
			(cAliasSC6)->C6_CF						,;
			(cAliasSC6)->C6_UM						,;
			(cAliasSC6)->C6_QTDVEN					,;
			(cAliasSC6)->C6_PRCVEN					,;
			(cAliasSC6)->C6_NOTA					,;
			(cAliasSC6)->C6_SERIE					,;
			(cAliasSC6)->C6_CLI						,;
			(cAliasSC6)->C6_LOJA					,;
			(cAliasSC6)->C6_VALOR					,;
			(cAliasSC6)->C6_ENTREG					,;
			(cAliasSC6)->C6_DESCONT					,;
			(cAliasSC6)->C6_LOCAL					,;
			(cAliasSC6)->C6_QTDEMP					,;
			(cAliasSC6)->C6_QTDLIB					,;
			(cAliasSC6)->C6_QTDENT					,;
			})							


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Forca os valores de impostos que foram informados no SC6.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasSC6)
		For nY := 1 to Len(aFisGet)
			If !Empty(&(aFisGet[ny][2]))
				MaFisAlt(aFisGet[ny][1],&(aFisGet[ny][2]),Len(aItemPed))
			EndIf
		Next nY

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calculo do ISS                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SF4->(dbSetOrder(1))
		SF4->(MsSeek(cFilialSF4+(cAliasSC6)->C6_TES))
		If ( (cAliasSC5)->C5_INCISS == "N" .And. (cAliasSC5)->C5_TIPO == "N")
			If ( SF4->F4_ISS=="S" )
				nPrcLista := a410Arred(nPrcLista/(1-(MaAliqISS(Len(aItemPed))/100)),"D2_PRCVEN")
				If lRndIss	
					//Quando configurado para arredondar ISS, é nescessário calcular ISS por item
					//conforme realizado na função Ma410Impos (Planilha Financeira-MATA410) e MaPvPrcIt (MATA461)
					nValMerc  := a410Arred((nValMerc-nDesconto) / (cAliasSC6)->C6_QTDVEN/(1-(MaAliqISS(Len(aItemPed))/100)) + nDesconto) * (cAliasSC6)->C6_QTDVEN
					nValMerc  := a410Arred(nValMerc,"D2_PRCVEN")
				Else
					nValMerc  := (nValMerc-nDesconto)/(1-(MaAliqISS(Len(aItemPed))/100)) + nDesconto
				EndIf
				MaFisAlt("IT_PRCUNI",nPrcLista,Len(aItemPed))
				MaFisAlt("IT_VALMERC",nValMerc,Len(aItemPed))
			EndIf
		EndIf	
		
		If lTpDpInd .Or. (!lTpDpInd .And. SF4->F4_DUPLIC == "S")
			nTotDesc += MaFisRet(Len(aItemPed),"IT_DESCONTO")
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Altera peso para calcular frete              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SB1->(dbSetOrder(1))
		SB1->(MsSeek(cFilialSB1+(cAliasSC6)->C6_PRODUTO))			
		If SB1->B1_PESO > 0
			MaFisAlt("IT_PESO",(cAliasSC6)->C6_QTDVEN*SB1->B1_PESO,Len(aItemPed))
			MaFisAlt("IT_PRCUNI",nPrcLista,Len(aItemPed))
		EndIf
		aAdd(aValMerc,{nValMerc,Len(aItemPed)})

		// Somatória do Peso do Produto
		nVlrPesoUnit	:= ( (cAliasSC6)->C6_QTDVEN*SB1->B1_PESO )
		nPesoTot 		+= nVlrPesoUnit

		(cAliasSC6)->(dbSkip())
	EndDo

	If (( ( cPaisLoc == "PER" .Or. cPaisLoc == "COL" ) .And. aCabPed[19] == "F" ) .Or. ( cPaisLoc != "PER" .And. cPaisLoc != "COL" ))
		If nPesoTot > 0
			MaFisAlt("NF_PESO"    ,nPesoTot )
		Endif
		MaFisAlt("NF_FRETE"   ,nFrete)
	EndIf
	
	If nSeguro > 0
		MaFisAlt("NF_SEGURO"  ,nSeguro)
	EndIf
	If nFretAut > 0
		MaFisAlt("NF_AUTONOMO",nFretAut)
	EndIf
	If nDespesa > 0
		MaFisAlt("NF_DESPESA" ,nDespesa)
	EndIf

	If nPDesCab > 0
		MaFisAlt("NF_DESCONTO",nPDesCab:=A410Arred((MaFisRet(,"NF_VALMERC")+MaFisRet(,'NF_DESCZF')-nTotDesc)*nPDesCab/100,"C6_VALOR")+MaFisRet(,"NF_DESCONTO"))
	EndIf

	If nDescCab > 0
		MaFisAlt("NF_DESCONTO",Min(MaFisRet(,"NF_VALMERC")-0.01,nPDesCab+nTotDesc+nDescCab),/*nItem*/,/*lNoCabec*/,/*nItemNao*/,IIf(lTpDpInd,.F.,.T.))
	EndIf

	If nFrete > 0 .Or. nFretAut > 0  .OR. nSeguro > 0 .Or. nDespesa > 0 .Or. nDescCab > 0 .Or. nPDesCab > 0 .Or. nPesoTot > 0
		For nT := 1 To Len(aValMerc)
			MaFisAlt("IT_VALMERC",aValMerc[nT][1],aValMerc[nT][2])
		Next nT
	EndIf
	aSize(aValmerc,0)

	ImpCabecR4(aPedCli,oReport,aCabPed)

	oReport:Section(1):Init()
	nItem := 0

	(cAliasSC6)->(DbGotop())
	
	If nQtdIts > 0
		(cAliasSC6)->(dbSkip(nQtdIts))
	EndIf

	nItemPed := Len(aItemPed)

	For nG := 1 To nItemPed
		nItem += 1
		If oReport:Row() > 1500
			oReport:Section(1):Finish()
			ImpRodapR4(nPesLiq,nPesBru,aC5Rodape,.F.,oReport)
			oReport:EndPage(.T.)
			oReport:Section(1):Init()
		 	ImpCabecR4(aPedCli,oReport,aCabPed)
		Endif
		ImpItemR4(nItem,@nPesLiq,@nPesBru,oReport,oPreNota,aCabPed,aItemPed)
		//Acompanha o registro da query na impressão dos registros
		(cAliasSC6)->(DbSkip())
	Next
	oReport:Section(1):Finish()
	ImpRodapR4(nPesLiq,nPesBru,aC5Rodape,.T.,oReport)
	oReport:EndPage(.T.)		// Finaliza pagina de impressao (zeras as linhas e colunas)

	MaFisEnd()
	nQtdIts += nItemPed

EndDo

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ImpCabecR4³ Autor ³ Marco Bianchi         ³ Data ³ 11/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpCabec(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpCabecR4(aPedCli,oReport,aCabPed)

Local nPed		:= 0
Local i         := 0
Local cMoeda	:= ""
Local cPedCli   := ""
Local cPictCgc  := ""
Local oBox
Local nPrinLin  := 0
Local nInicio   := 20
Local nFontB	:= oReport:nFontBody
Local nLinCab	:= Iif(nFontB >= 13,4,IIF(nFontB >= 9,5,8))
Local nModRetr	:= oReport:GetOrientation()
Local oFont1 	:= TFont():New('Courier New',,11,,.F.,,,,.F.,.F.)
Local nQtdPdCli := Iif(nModRetr == 1 .Or. nFontB >= 12,80,100)
Local nQrd1,nQrd2,nQrd3,nQrd4,nQrd5

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  array acabped                                              ³
//³  -------------                                              ³
//³  01 C5_TIPO           10 C5_VEND3     	19 C5_TPFRETE       ³
//³  02 C5_CLIENTE        11 C5_VEND4     	20 C5_SEGURO        ³
//³  03 C5_LOJACLI        12 C5_VEND5     	21 C5_TABELA        ³
//³  04 C5_TRANSP         13 C5_COMIS1    	22 C5_VOLUME1       ³
//³  05 C5_CONDPAG        14 C5_COMIS2    	23 C5_ESPECI1       ³
//³  06 C5_EMISSAO        15 C5_COMIS3    	24 C5_MOEDA         ³
//³  07 C5_NUM            16 C5_COMIS4    	25 C5_REAJUST       ³
//³  08 C5_VEND1          17 C5_COMIS5    	26 C5_BANCO         ³
//³  09 C5_VEND2          18 C5_FRETE     	27 C5_ACRSFIN       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona registro no cliente do pedido                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF !(aCabPed[1]$"DB")   //C5_TIPO
	dbSelectArea("SA1")
	dbSeek(xFilial("SA1")+aCabped[2]+aCabped[3])  //C5_CLIENTE + C5_LOJACLI
	cPictCgc := PesqPict("SA1","A1_CGC")	
Else
	dbSelectArea("SA2")
	dbSeek(xFilial("SA2")+aCabPed[2]+aCabPed[3])  // C5_CLIENTE + C5_LOJACLI
	cPictCgc := PesqPict("SA2","A2_CGC")	
Endif

dbSelectArea("SA4")
dbSetOrder(1)
dbSeek(xFilial("SA4")+aCabPed[4])	   				// C5_TRANSP
dbSelectArea("SE4")
dbSetOrder(1)
dbSeek(xFilial("SE4")+aCabPed[5])	  				// C5_CONDPAG
aSort(aPedCli)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa impressao do cabecalho                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:HideHeader()			// Nao imprime cabecalho padrao do Protheus
oReport:SkipLine()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desenha as caixas do cabecalho                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nModRetr == 1//MODO RETRATO

	nQrd1 := 40
	nQrd2 := 960
	nQrd3 := 2010
	nQrd4 := 1000
	nQrd5 := 2100

	oReport:Box(20,10,200,950,oBox)
	oReport:Box(20,950,200,2000,oBox)
	oReport:Box(20,2000,200,2595,oBox)

ElseIf nModRetr == 2//MODO PAISAGEM

	nQrd1 := 50
	nQrd2 := 1060
	nQrd3 := 2560
	nQrd4 := 1730
	nQrd5 := 2600

	oReport:Box(10,10,230,1050,oBox)
	oReport:Box(10,1050,230,2550,oBox)
	oReport:Box(10,2550,230,3275,oBox)
EndIf

IF !(aCabPed[1]$"DB")//C5_TIPO

	If Oreport:nDevice == 4
		nPrinLin := nInicio
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 1: Dados da Empresa                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:PrintText("",nPrinLin,10)
		oReport:PrintText(SubStr(rTrim(SM0->M0_NOME) + IIF(!Empty(SM0->M0_NOMECOM), ' - ' + rTrim(SM0->M0_NOMECOM),''),1,50),nPrinLin,20)
		nPrinLin += nQrd1
		oReport:PrintText(SM0->M0_ENDCOB,nPrinLin,20)
		nPrinLin += nQrd1
		oReport:PrintText(STR0067+SM0->M0_TEL,nPrinLin,20)	// "TEL: "
		nPrinLin += nQrd1
		oReport:PrintText(Iif(cPaisLoc=="BRA",STR0071,Alltrim(Posicione('SX3',2,'A1_CGC','SX3->X3_TITULO'))+":")+;	// "CGC: "
							Transform(SM0->M0_CGC,cPictCgc)+ " " +Subs(SM0->M0_CIDCOB,1,15),nPrinLin,20)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 2: Dados do Cliente                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPrinLin := nInicio
		oReport:PrintText(SA1->A1_COD+"/"+SA1->A1_LOJA+" "+ FATPDObfuscate(SA1->A1_NOME,"A1_NOME") ,nPrinLin,nQrd2)	
		nPrinLin += nQrd1
		
		oReport:PrintText(IF( !Empty(SA1->A1_ENDENT) .And. SA1->A1_ENDENT # SA1->A1_END,FATPDObfuscate(SA1->A1_ENDENT,"A1_ENDENT"), FATPDObfuscate(SA1->A1_END,"A1_END") ),nPrinLin,nQrd2)
		nPrinLin += nQrd1
		oReport:PrintText(IF( !Empty(SA1->A1_CEPE) .And. SA1->A1_CEPE # SA1->A1_CEP,FATPDObfuscate(SA1->A1_CEPE,"A1_CEPE"), FATPDObfuscate(SA1->A1_CEP,"A1_CEP") )+" "+;
							AllTrim(IF( !Empty(SA1->A1_MUNE) .And. SA1->A1_MUNE # SA1->A1_MUN,SA1->A1_MUNE, SA1->A1_MUN ))+" "+;
							IF( !Empty(SA1->A1_ESTE) .And. SA1->A1_ESTE # SA1->A1_EST,SA1->A1_ESTE, SA1->A1_EST ),nPrinLin,nQrd2)
		nPrinLin += nQrd1
		oReport:PrintText(FATPDObfuscate(subs(transform(SA1->A1_CGC,PicPesFJ(RetPessoa(SA1->A1_CGC))),1,at("%",transform(SA1->A1_CGC,PicPes(RetPessoa(SA1->A1_CGC))))-1),"A1_CGC")+"  "+;
		IIF(cPaisLoc == "BRA",STR0069+SA1->A1_INSCR,""),nPrinLin,nQrd2)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 3: Dados do Pedido                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPrinLin := nInicio
		oReport:PrintText(STR0066,nPrinLin,nQrd3)						// "CONFIRMACAO DO PEDIDO"
		nPrinLin += 60
		oReport:PrintText(STR0068+DTOC(aCabPed[6]),nPrinLin,nQrd3)		// "EMISSAO: "
		nPrinLin += nQrd1
		oReport:PrintText(STR0070+aCabPed[7],nPrinLin,nQrd3)			// "PEDIDO N. "
	Else
		nPrinLin := nInicio
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 1: Dados da Empresa                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:Say(nPrinLin,20,SubStr(rTrim(SM0->M0_NOME) + IIF(!Empty(SM0->M0_NOMECOM), ' - ' + rTrim(SM0->M0_NOMECOM),''),1,IIf(nModRetr == 1,47,50)),oFont1)
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,20,SM0->M0_ENDCOB,oFont1)
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,20,STR0067+SM0->M0_TEL,oFont1) //"TEL: "
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,20,Iif(cPaisLoc=="BRA",STR0071,Alltrim(Posicione('SX3',2,'A1_CGC','SX3->X3_TITULO'))+":")+;	// "CGC: "
							Transform(SM0->M0_CGC,cPictCgc)+ " " +Subs(SM0->M0_CIDCOB,1,15),oFont1)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 2: Dados do Cliente                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPrinLin := nInicio
		oReport:Say(nPrinLin,nQrd2,SA1->A1_COD+"/"+SA1->A1_LOJA+" "+ FATPDObfuscate(SA1->A1_NOME,"A1_NOME"),oFont1)
		nPrinLin += nQrd1
		
		oReport:Say(nPrinLin,nQrd2,IF( !Empty(SA1->A1_ENDENT) .And. SA1->A1_ENDENT # SA1->A1_END,FATPDObfuscate(SA1->A1_ENDENT,"A1_ENDENT"), FATPDObfuscate(SA1->A1_END,"A1_END") ),oFont1)
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,nQrd2,IF( !Empty(SA1->A1_CEPE) .And. SA1->A1_CEPE # SA1->A1_CEP,FATPDObfuscate(SA1->A1_CEPE,"A1_CEPE"), FATPDObfuscate(SA1->A1_CEP,"A1_CEP") )+" "+;
							AllTrim(IF( !Empty(SA1->A1_MUNE) .And. SA1->A1_MUNE # SA1->A1_MUN,SA1->A1_MUNE, SA1->A1_MUN ))+" "+;
							IF( !Empty(SA1->A1_ESTE) .And. SA1->A1_ESTE # SA1->A1_EST,SA1->A1_ESTE, SA1->A1_EST ),oFont1)
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,nQrd2,FATPDObfuscate(subs(transform(SA1->A1_CGC,PicPesFJ(RetPessoa(SA1->A1_CGC))),1,at("%",transform(SA1->A1_CGC,PicPes(RetPessoa(SA1->A1_CGC))))-1),"A1_CGC")+" "+;
		IIF(cPaisLoc == "BRA",STR0069+SA1->A1_INSCR,""),oFont1)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 3: Dados do Pedido                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPrinLin := nInicio
		oReport:Say(nPrinLin,nQrd3,STR0066,oFont1)							// "CONFIRMACAO DO PEDIDO"
		nPrinLin += 60 
		oReport:Say(nPrinLin,nQrd3,STR0068+DTOC(aCabPed[6]),oFont1)		// "EMISSAO: "
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,nQrd3,STR0070+aCabPed[7],oFont1)		// "PEDIDO N. "
	EndIf

Else

	If Oreport:nDevice == 4
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 1: Dados da Empresa                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPrinLin := nInicio
		oReport:PrintText("",nPrinLin,10)
		oReport:PrintText(SubStr(rTrim(SM0->M0_NOME) + IIF(!Empty(SM0->M0_NOMECOM), ' - ' + rTrim(SM0->M0_NOMECOM),''),1,50),nPrinLin,20)
		nPrinLin += nQrd1
		oReport:PrintText(SM0->M0_ENDCOB,nPrinLin,20)
		nPrinLin += nQrd1
		oReport:PrintText(STR0067+SM0->M0_TEL,nPrinLin,20)														// "TEL: "
		nPrinLin += nQrd1
		oReport:PrintText(Iif(cPaisLoc=="BRA",STR0071,Alltrim(Posicione('SX3',2,'A1_CGC','SX3->X3_TITULO'))+":")+;	// "CGC: "
							Transform(SM0->M0_CGC,cPictCgc)+ " " +Subs(SM0->M0_CIDCOB,1,15),nPrinLin,20)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 2: Dados do Cliente                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPrinLin := nInicio
		oReport:PrintText(SA2->A2_COD+"/"+SA2->A2_LOJA+" "+ FATPDObfuscate(SA2->A2_NOME,"A2_NOME")  ,nPrinLin,nQrd2)	
		nPrinLin += nQrd1
		oReport:PrintText(FATPDObfuscate(SA2->A2_END,"A2_END"),nPrinLin,nQrd2)
		nPrinLin += nQrd1
		oReport:PrintText(SA2->A2_CEP + " " + AllTrim(SA2->A2_MUN) + " " + SA2->A2_EST,nPrinLin,nQrd2)
		nPrinLin += nQrd1
		oReport:PrintText(FATPDObfuscate(subs(transform(SA2->A2_CGC,PicPesFJ(RetPessoa(SA2->A2_CGC))),1,at("%",transform(SA2->A2_CGC,PicPes(RetPessoa(SA2->A2_CGC))))-1),"A2_CGC")+"  "+;
		IIF(cPaisLoc == "BRA",STR0069 + SA2->A2_INSCR,""),nPrinLin,nQrd2)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 3: Dados do Pedido                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPrinLin := nInicio
		oReport:PrintText(STR0066,nPrinLin,nQrd3)						// "CONFIRMACAO DO PEDIDO"
		nPrinLin += 60
		oReport:PrintText(STR0068+DTOC(aCabPed[6]),nPrinLin,nQrd3)		// "EMISSAO: "
		nPrinLin += nQrd1
		oReport:PrintText(STR0070+aCabPed[7],nPrinLin,nQrd3)			// "PEDIDO N. "
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 1: Dados da Empresa                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPrinLin := nInicio
		oReport:Say(nPrinLin,20,SubStr(rTrim(SM0->M0_NOME) + IIF(!Empty(SM0->M0_NOMECOM), ' - ' + rTrim(SM0->M0_NOMECOM),''),1,IIf(nModRetr == 1,47,50)),oFont1)
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,20,SM0->M0_ENDCOB,oFont1)
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,20,STR0067+SM0->M0_TEL,oFont1)														// "TEL: "
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,20,Iif(cPaisLoc=="BRA",STR0071,Alltrim(Posicione('SX3',2,'A1_CGC','SX3->X3_TITULO'))+":")+;	// "CGC: "
							Transform(SM0->M0_CGC,cPictCgc)+ " " +Subs(SM0->M0_CIDCOB,1,15),oFont1)
			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 2: Dados do Cliente                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPrinLin := nInicio
		oReport:Say(nPrinLin,nQrd2,SA2->A2_COD+"/"+SA2->A2_LOJA+" "+ FATPDObfuscate(SA2->A2_NOME,"A2_NOME"),oFont1)
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,nQrd2,FATPDObfuscate(SA2->A2_END,"A2_END"),oFont1)
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,nQrd2,SA2->A2_CEP + " " + AllTrim(SA2->A2_MUN) + " " + SA2->A2_EST,oFont1)
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,nQrd2,FATPDObfuscate(subs(transform(SA2->A2_CGC,PicPesFJ(RetPessoa(SA2->A2_CGC))),1,at("%",transform(SA2->A2_CGC,PicPes(RetPessoa(SA2->A2_CGC))))-1),"A2_CGC")+" "+;
		IIF(cPaisLoc == "BRA",STR0069 + SA2->A2_INSCR,""),oFont1)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Informacoes do Quadro 3: Dados do Pedido                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPrinLin := nInicio
		oReport:Say(nPrinLin,nQrd3,STR0066,oFont1)						// "CONFIRMACAO DO PEDIDO"
		nPrinLin += 60
		oReport:Say(nPrinLin,nQrd3,STR0068+DTOC(aCabPed[6]),oFont1)		// "EMISSAO: "
		nPrinLin += nQrd1
		oReport:Say(nPrinLin,nQrd3,STR0070+aCabPed[7],oFont1)			// "PEDIDO N. "
	EndIf

Endif 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pedidos do Cliente                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine(nLinCab)
If Len(aPedCli) > 0	
	oReport:PrintText("PEDIDO(S) DO CLIENTE: ",oReport:Row(),20)
	If nFontB >= 12
		oReport:SkipLine(1)
	EndIf
	cPedCli:=""
	For nPed := 1 To Len(aPedCli)
		cPedCli += aPedCli[nPed]+Space(02)
		If Len(cPedCli) > nQtdPdCli .or. nPed == Len(aPedCli)
			oReport:PrintText(cPedCli,oReport:Row(),oReport:Col()+10)
			cPedCli:=""
 		   oReport:SkipLine(2)
		Endif
	Next
	oReport:Line(oReport:Row(),10,oReport:Row(),3275)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Transportadora                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine()
oReport:PrintText(STR0072+aCabPed[4]+" - "+SA4->A4_NOME,oReport:Row(),20)		// "TRANSP...: "		//C5_TRANSP

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vendedores                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine()
For i := 8 to 12
    dbSelectArea("SA3")
    dbSetOrder(1)
    If dbSeek(xFilial("SA3")+aCabPed[i])                                                                            // C5_VENDi
        If i == 8
            oReport:PrintText(STR0073+aCabPed[i] + " - "+ FATPDObfuscate(SA3->A3_NOME,"A3_NOME"),oReport:Row(),20)  // "VENDEDOR.: "
            oReport:PrintText(STR0074+Transform(aCabPed[i+5],"99.99"),oReport:Row(),nQrd5)                  // "COMISSAO: "
            oReport:SkipLine()
        Else
            oReport:PrintText(Space(Len(STR0073))+aCabPed[i] + " - "+ FATPDObfuscate(SA3->A3_NOME,"A3_NOME"),oReport:Row(),20)
            oReport:PrintText(Space(Len(STR0074))+Transform(aCabPed[i+5],"99.99"),oReport:Row(),nQrd5)
            oReport:SkipLine()
        EndIf
    EndIf   
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Condicao de Pagto, Frete e Seguro                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:PrintText(STR0075+aCabPed[5]+" - "+SE4->E4_DESCRI,oReport:Row(),20)													// "COND.PGTO: "//C5_CONDPAG
oReport:PrintText(STR0076+Alltrim(Transform(aCabPed[18],"@EZ 999,999,999.99")+TipoFrete(aCabPed[19])),oReport:Row(),nQrd4)	// "FRETE...: " // C5_TPFRETE
oReport:PrintText(STR0077+Alltrim(Transform(aCabPed[20],"@EZ 999,999,999.99")),oReport:Row(),nQrd5)							// "SEGURO: " 	//C5_SEGURO
oReport:SkipLine()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tabela, Volume e Especie                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:PrintText(STR0078+aCabPed[21],oReport:Row(),20)											// "TABELA...: "	// C5_TABELA
oReport:PrintText(STR0079+Alltrim(Transform(aCabPed[22],"@EZ 999,999")),oReport:Row(),nQrd4)	// "VOLUMES.: "		// C5_VOLUME1s
oReport:PrintText(STR0080+Alltrim(aCabPed[23]),oReport:Row(),nQrd5) 							// "ESPECIE: "		// C5_ESPECIE1
oReport:SkipLine()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Reajuste, Moeda, Banco e Acrescimo Financeiro               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMoeda:=Strzero(aCabPed[24],1,0)																// C5_MOEDA
oReport:PrintText(STR0081+aCabPed[25]+STR0082 +IIF(cMoeda < "2","1",cMoeda),oReport:Row(),20)	// "REAJUSTE.: "###"   Moeda : " 	//C5_REAJUST
oReport:PrintText(STR0083 + aCabPed[26],oReport:Row(),nQrd4)				   					// "BANCO: "		//C5_BANCO
oReport:PrintText(STR0084 + Alltrim(Str(aCabPed[27],6,2)),oReport:Row(),nQrd5)					// "ACRES.FIN.: "	//C5_ACRSFIN
oReport:SkipLine()
oReport:Line(oReport:Row(),10,oReport:Row()+5,3275)

Return( .T. )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpItemR4³ Autor ³ Marco Bianchi         ³ Data ³ 11/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpItem(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpItemR4(nItem,nPesLiq,nPesBru,oReport,oPreNota,aCabPed,aItemPed)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  array aitemped                                             ³
//³  --------------                                             ³
//³  01 c6_item           08 c6_prcven         15 c6_descont    ³
//³  02 c6_produto        09 c6_nota           16 c6_local      ³
//³  03 c6_descri         10 c6_serie          17 c6_qtdemp     ³
//³  04 c6_tes            11 c6_cli            18 c6_qtdlib     ³
//³  05 c6_cf             12 c6_loja           19 c6_qtdent     ³
//³  06 c6_um             13 c6_valor                           ³
//³  07 c6_qtdven         14 c6_entreg                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cChaveD2	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SetBlock: faz com que as variaveis locais possam ser                   ³
//³ utilizadas em outras funcoes nao precisando declara-las                ³
//³ como private.                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cPaisLoc <> "BRA"
	oReport:Section(1):Cell("NVALIMP"):SetBlock({|| nValImp})
Else	
	oReport:Section(1):Cell("AITEM13"):SetBlock({|| aItemPed[nItem][13]+nValImp})
EndIf
oReport:Section(1):Cell("NULTLIB"):SetBlock({|| nUltLib})
nValImp := 0
nUltLib := 0
If cPaisLoc == "BRA"
	If aCabPed[1] == "P"
		nValImp := 0
	Else
		nValImp	:=	MaFisRet(nItem,"IT_VALIPI")
	Endif
Else
	nValImp	:=	MaRetIncIV(nItem,"2")
Endif

dbSelectArea("SB1")
dbSeek(xFilial("SB1")+aItemPed[nItem][2])  //C6_PRODUTO

//C6_nota C6_serie C6_cli C6_loja C6_produto
cChaveD2 := xFilial("SD2")+aItemPed[nItem][09]+aItemPed[nItem][10]+aItemPed[nItem][11]+aItemPed[nItem][12]+aItemPed[nItem][02]
dbSelectArea("SD2")
dbSetOrder(3)
dbSeek(cChaveD2)
While !Eof() .and. cChaveD2 = xFilial("SD2")+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD
	nUltLib := D2_QUANT
	dbSkip()
EndDo

oReport:Section(1):PrintLine()

nTotQtd += aItemPed[nItem][07]						//C6_QTDVEN
nTotVal += aItemPed[nItem][13]+nValImp				//C6_VALOR
nPesLiq	+= SB1->B1_PESO * aItemPed[nItem][07]		//C6_QTDVEN
nPesBru += SB1->B1_PESBRU * aItemPed[nItem][07]		//C6_QTDVEN

Return (Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ImpRodapR4³ Autor ³ Marco Bianchi         ³ Data ³ 11/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpRoadpe(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpRodapR4(nPesLiq,nPesBru,aC5Rodape,lFinal,oReport)

Local I     	 := 0
Local nTamLin    := 0
Local nLinMsg    := 1
Local nQtdLinMsg := 0
Local cMsgNota   := ""

DEFAULT lFinal	:= .F.

If lFinal

	oReport:SkipLine()
	oReport:Line(oReport:Row(),10,oReport:Row(),3275)

	If cPaisLoc == 'BRA'
		oReport:PrintText(SubStr(STR0038,1,15))
		oReport:Section(2):Init()
		oReport:Section(2):PrintLine()
		oReport:Section(2):Finish()
	Else
		aCodImps	:=	{}
		aCodImps := MaFisRet(,"NF_IMPOSTOS") //Descricao / /Aliquota / Valor / Base
		oReport:Section(2):Init()
		For I:=1 To Len(aCodImps)// Vetor com os impostos
			nI := I
			oReport:Section(2):PrintLine()
		Next
		oReport:Section(2):Finish()
	Endif
Endif	

If oReport:nFontBody >= 13
	oReport:EndPage()
	oReport:PrintText("",10,10) //A primeira linha é default do método PrintText
EndIF

oReport:SkipLine()

oReport:PrintText(STR0100+STR(If(aC5Rodape[1][1] > 0,aC5Rodape[1][1],nPesBru)),1850,30)		// "PESO BRUTO ------>"
oReport:PrintText(STR0101+STR(If(aC5Rodape[1][2] > 0,aC5Rodape[1][2],nPesLiq)),1890,30)		// "PESO LIQUIDO ---->"
oReport:PrintText(STR0102,1940,30)															// "VOLUMES --------->"
oReport:PrintText(STR0103,1990,30)															// "SEPARADO POR ---->"
oReport:PrintText(STR0104,2040,30)															// "CONFERIDO POR --->"
oReport:PrintText(STR0105,2090,30)															// "D A T A --------->"

oReport:PrintText(STR0106,2140,30)															// "DESCONTOS: "
oReport:PrintText(Transform(aC5Rodape[1][3],"99.99"),2140,320)
oReport:PrintText(Transform(aC5Rodape[1][4],"99.99"),2140,480)
oReport:PrintText(Transform(aC5Rodape[1][5],"99.99"),2140,640)
oReport:PrintText(Transform(aC5Rodape[1][6],"99.99"),2140,800)

If oReport:nDevice == 4 //TRATATIVA EXCLUSIVA PARA IMPRESSAO DO TIPO PLANILHA (EXCEL)
	oReport:PrintText(STR0107+AllTrim(aC5Rodape[1][7]),2300,30)
Else 
	cMsgNota := STR0107 + AllTrim(aC5Rodape[1][7])	// "MENSAGEM PARA NOTA FISCAL: "
	nTamLin := MR730TamLin(oReport)
	nQtdLinMsg := MLCount(cMsgNota,nTamLin)

	For nLinMsg := 1 To nQtdLinMsg
		oReport:PrintText(Alltrim(MemoLine(cMsgNota,nTamLin,nLinMsg)), 2190 + ((nLinMsg - 1) *35), 30)
	Next nLinMsg
EndIf

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR730R3³ Autor ³ Eduardo José Zanardo  ³ Data ³ 26.12.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Emissao da Pr‚-Nota                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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

User Function Matr730R3

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local Titulo  := OemToAnsi(STR0001) //"Emissao da Confirmacao do Pedido"
Local cDesc1  := OemToAnsi(STR0002) //"Emiss„o da confirmac„o dos pedidos de venda, de acordo com"
Local cDesc2  := OemToAnsi(STR0003) //"intervalo informado na op‡„o Parƒmetros."
Local cDesc3  := " "
Local cString := "SC5"  // Alias utilizado na Filtragem
Local lDic    := .F. // Habilita/Desabilita Dicionario
Local lComp   := .F. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .F. // Habilita/Desabilita o Filtro
Local wnrel   := "MATR730" // Nome do Arquivo utilizado no Spool
Local nomeprog:= "MATR730"
Local cPerg   := "MTR730"

Private Tamanho := "G" // P/M/G
Private Limite  := 220 // 80/132/220
Private aOrdem  := {}  // Ordem do Relatorio
Private aReturn := { STR0004, 1,STR0005, 2, 2, 1, "",0 } //"Zebrado"###"Administracao"
//[1] Reservado para Formulario
//[2] Reservado para N§ de Vias
//[3] Destinatario
//[4] Formato => 1-Comprimido 2-Normal
//[5] Midia   => 1-Disco 2-Impressora
//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
//[7] Expressao do Filtro
//[8] Ordem a ser selecionada
//[9]..[10]..[n] Campos a Processar (se houver)

Private lEnd    := .F.// Controle de cancelamento do relatorio
Private m_pag   := 1  // Contador de Paginas
Private nLastKey:= 0  // Controla o cancelamento da SetPrint e SetDefault

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

lFiltro := .F.

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
Endif
SetDefault(aReturn,cString)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
Endif

RptStatus({|lEnd| C730Imp(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ C730Imp   ³ Autor ³ Eduardo J. Zanardo   ³ Data ³26.12.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controle de Fluxo do Relatorio.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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

Static Function C730Imp(lEnd,wnrel,cString,nomeprog,Titulo)

Local aPedCli    := {}
Local aStruSC5   := {}
Local aStruSC6   := {}
Local aC5Rodape  := {}
Local aRelImp    := MaFisRelImp("MT100",{"SF2","SD2"})
Local aFisGet    := Nil
Local aFisGetSC5 := Nil
Local li         := 100 // Contador de Linhas
Local lRodape    := .F.
Local cAliasSC5  := "SC5"
Local cAliasSC6  := "SC6"
Local cQuery     := ""
Local cQryAd     := ""
Local cName      := ""
Local cPedido    := ""
Local cCliEnt	 := ""
Local cNfOri     := Nil
Local cSeriOri   := Nil
Local nItem      := 0
Local nTotQtd    := 0
Local nTotVal    := 0
Local nDesconto  := 0
Local nPesLiq    := 0
Local nSC5       := 0
Local nSC6       := 0
Local nX         := 0
Local nRecnoSD1  := Nil
Local nG		 := 0
Local nFrete	 := 0
Local nSeguro	 := 0
Local nFretAut	 := 0
Local nDespesa	 := 0
Local nDescCab	 := 0
Local nPDesCab	 := 0
Local nY         := 0
Local nValMerc   := 0
Local nPrcLista  := 0
Local nAcresFin  := 0
Local aValMerc	 := {}
Local nT		 := 0
Local nTamPrcVen := TamSX3("C6_PRCVEN")[2]
Local cFilialSC6 := xFilial("SC6")
Local cFilialSF4 := xFilial("SF4")
Local cFilialSB1 := xFilial("SB1")
Local nPesoTot	 := 0
Local nVlrPesoUnit:= 0
Local lTpDpInd	 := SuperGetMv("MV_TPDPIND",.F.,.F.) == "1"
Local nTotDesc   := 0


Private aItemPed := {}
Private aCabPed	 := {}

FisGetInit(@aFisGet,@aFisGetSC5)

cAliasSC5:= "C730Imp"
cAliasSC6:= "C730Imp"
aStruSC5  := SC5->(dbStruct())		
aStruSC6  := SC6->(dbStruct())		
cQuery := "SELECT SC5.R_E_C_N_O_ SC5REC,SC6.R_E_C_N_O_ SC6REC,"
cQuery += "SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,"
cQuery += "SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_PBRUTO,SC5.C5_PESOL,SC5.C5_DESC1,"
cQuery += "SC5.C5_DESC2,SC5.C5_DESC3,SC5.C5_DESC4,SC5.C5_MENNOTA,SC5.C5_EMISSAO,"
cQuery += "SC5.C5_CONDPAG,SC5.C5_FRETE,SC5.C5_DESPESA,SC5.C5_FRETAUT,SC5.C5_TPFRETE,SC5.C5_SEGURO,SC5.C5_TABELA,"
cQuery += "SC5.C5_VOLUME1,SC5.C5_ESPECI1,SC5.C5_MOEDA,SC5.C5_REAJUST,SC5.C5_BANCO,"
cQuery += "SC5.C5_ACRSFIN,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,"
cQuery += "SC5.C5_COMIS1,SC5.C5_COMIS2,SC5.C5_COMIS3,SC5.C5_COMIS4,SC5.C5_COMIS5,SC5.C5_PDESCAB,SC5.C5_DESCONT,C5_INCISS,"

If SC5->(FieldPos("C5_CLIENT"))>0
	cQuery += "SC5.C5_CLIENT,"			
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Esta rotina foi escrita para adicionar no select os campos         ³
//³usados no filtro do usuario quando houver, a rotina acrecenta      ³
//³somente os campos que forem adicionados ao filtro testando         ³
//³se os mesmo já existem no select ou se forem definidos novamente   ³
//³pelo o usuario no filtro                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
If !Empty(aReturn[7])
	For nX := 1 To SC5->(FCount())
		cName := SC5->(FieldName(nX))
		If AllTrim( cName ) $ aReturn[7]
			If aStruSC5[nX,2] <> "M"
				If !cName $ cQuery .And. !cName $ cQryAd
					cQryAd += cName +","
				Endif 	
			EndIf
		EndIf 			       	
	Next nX
Endif

For nY := 1 To Len(aFisGet)
	cQryAd += aFisGet[nY][2]+","
Next nY

For nY := 1 To Len(aFisGetSC5)
	cQryAd += aFisGetSC5[nY][2]+","
Next nY		

cQuery += cQryAd
cQuery += "SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PEDCLI,SC6.C6_PRODUTO,"
cQuery += "SC6.C6_TES,SC6.C6_CF,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,"
cQuery += "SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_DESCRI,SC6.C6_UM, "
cQuery += "SC6.C6_PRCVEN,SC6.C6_NOTA,SC6.C6_SERIE,SC6.C6_CLI,"
cQuery += "SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_DESCONT,SC6.C6_LOCAL,"
cQuery += "SC6.C6_QTDEMP,SC6.C6_QTDLIB,SC6.C6_QTDENT,SC6.C6_NFORI,SC6.C6_SERIORI,SC6.C6_ITEMORI "
cQuery += "FROM "
cQuery += RetSqlName("SC5") + " SC5 ,"
cQuery += RetSqlName("SC6") + " SC6 "		
cQuery += "WHERE "
cQuery += "SC5.C5_FILIAL = '"+xFilial("SC5")+"' AND "		
cQuery += "SC5.C5_NUM >= '"+mv_par01+"' AND "
cQuery += "SC5.C5_NUM <= '"+mv_par02+"' AND "
cQuery += "SC5.D_E_L_E_T_ = ' ' AND "
cQuery += "SC6.C6_FILIAL = '"+xFilial("SC6")+"' AND "		
cQuery += "SC6.C6_NUM   = SC5.C5_NUM AND "
cQuery += "SC6.D_E_L_E_T_ = ' ' "
cQuery += "ORDER BY SC5.C5_NUM"

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC5,.T.,.T.)

For nSC5 := 1 To Len(aStruSC5)
	If aStruSC5[nSC5][2] <> "C" .and.  FieldPos(aStruSC5[nSC5][1]) > 0
		TcSetField(cAliasSC5,aStruSC5[nSC5][1],aStruSC5[nSC5][2],aStruSC5[nSC5][3],aStruSC5[nSC5][4])
	EndIf
Next nSC5

For nSC6 := 1 To Len(aStruSC6)
	If aStruSC6[nSC6][2] <> "C" .and. FieldPos(aStruSC6[nSC6][1]) > 0
		TcSetField(cAliasSC6,aStruSC6[nSC6][1],aStruSC6[nSC6][2],aStruSC6[nSC6][3],aStruSC6[nSC6][4])
	EndIf
Next nSC6		    	

While !((cAliasSC5)->(Eof())) .and. xFilial("SC5")==(cAliasSC5)->C5_FILIAL

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a validacao dos filtros do usuario           	     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cAliasSC5)
	lFiltro := IIf((!Empty(aReturn[7]).And.!&(aReturn[7])),.F.,.T.)

	If lFiltro

		cCliEnt   := IIf(!Empty((cAliasSC5)->(FieldGet(FieldPos("C5_CLIENT")))),(cAliasSC5)->C5_CLIENT,(cAliasSC5)->C5_CLIENTE)

		aCabPed := {}

		MaFisIni(cCliEnt,;							// 1-Codigo Cliente/Fornecedor
			(cAliasSC5)->C5_LOJACLI,;			// 2-Loja do Cliente/Fornecedor
			If((cAliasSC5)->C5_TIPO$'DB',"F","C"),;	// 3-C:Cliente , F:Fornecedor
			(cAliasSC5)->C5_TIPO,;				// 4-Tipo da NF
			(cAliasSC5)->C5_TIPOCLI,;			// 5-Tipo do Cliente/Fornecedor
			aRelImp,;							// 6-Relacao de Impostos que suportados no arquivo
			,;						   			// 7-Tipo de complemento
			,;									// 8-Permite Incluir Impostos no Rodape .T./.F.
			"SB1",;							// 9-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
			"MATA461")							// 10-Nome da rotina que esta utilizando a funcao
		//Na argentina o calculo de impostos depende da serie.
		If cPaisLoc == 'ARG'
			SA1->(DbSetOrder(1))
			SA1->(MsSeek(xFilial()+(cAliasSC5)->C5_CLIENTE+(cAliasSC5)->C5_LOJACLI))
			MaFisAlt('NF_SERIENF',LocXTipSer('SA1',MVNOTAFIS))
		Endif

		nFrete		:= (cAliasSC5)->C5_FRETE
		nSeguro		:= (cAliasSC5)->C5_SEGURO
		nFretAut	:= (cAliasSC5)->C5_FRETAUT
		nDespesa	:= (cAliasSC5)->C5_DESPESA
		nDescCab	:= (cAliasSC5)->C5_DESCONT
		nPDesCab	:= (cAliasSC5)->C5_PDESCAB

		aItemPed:= {}
		aCabPed := {	(cAliasSC5)->C5_TIPO,;
			(cAliasSC5)->C5_CLIENTE,;
			(cAliasSC5)->C5_LOJACLI,;
			(cAliasSC5)->C5_TRANSP,;
			(cAliasSC5)->C5_CONDPAG,;
			(cAliasSC5)->C5_EMISSAO,;
			(cAliasSC5)->C5_NUM,;
			(cAliasSC5)->C5_VEND1,;
			(cAliasSC5)->C5_VEND2,;
			(cAliasSC5)->C5_VEND3,;
			(cAliasSC5)->C5_VEND4,;
			(cAliasSC5)->C5_VEND5,;
			(cAliasSC5)->C5_COMIS1,;
			(cAliasSC5)->C5_COMIS2,;
			(cAliasSC5)->C5_COMIS3,;
			(cAliasSC5)->C5_COMIS4,;
			(cAliasSC5)->C5_COMIS5,;
			(cAliasSC5)->C5_FRETE,;
			(cAliasSC5)->C5_TPFRETE,;
			(cAliasSC5)->C5_SEGURO,;
			(cAliasSC5)->C5_TABELA,;
			(cAliasSC5)->C5_VOLUME1,;
			(cAliasSC5)->C5_ESPECI1,;
			(cAliasSC5)->C5_MOEDA,;
			(cAliasSC5)->C5_REAJUST,;
			(cAliasSC5)->C5_BANCO,;
			(cAliasSC5)->C5_ACRSFIN;
			}
		nTotQtd		:= 0
		nTotVal		:= 0
		nPesBru		:= 0
		nPesLiq		:= 0
		aPedCli		:= {}
		cPedido		:= (cAliasSC5)->C5_NUM
		aC5Rodape	:= {}
		nTotDesc	:= 0
		
		aadd(aC5Rodape,{(cAliasSC5)->C5_PBRUTO,(cAliasSC5)->C5_PESOL,(cAliasSC5)->C5_DESC1,(cAliasSC5)->C5_DESC2,;
			(cAliasSC5)->C5_DESC3,(cAliasSC5)->C5_DESC4,(cAliasSC5)->C5_MENNOTA})

		aPedCli := Mtr730Cli(cPedido)

		dbSelectArea(cAliasSC5)
		For nY := 1 to Len(aFisGetSC5)
			If !Empty(&(aFisGetSC5[ny][2]))
				If aFisGetSC5[ny][1] == "NF_SUFRAMA"
					MaFisAlt(aFisGetSC5[ny][1],Iif(&(aFisGetSC5[ny][2]) == "1",.T.,.F.),Len(aItemPed),.T.)		
				Else
					MaFisAlt(aFisGetSC5[ny][1],&(aFisGetSC5[ny][2]),Len(aItemPed),.T.)
				Endif	
			EndIf
		Next nY

		While !((cAliasSC6)->(Eof())) .And. cFilialSC6==(cAliasSC6)->C6_FILIAL .And.;
				(cAliasSC6)->C6_NUM == cPedido

			cNfOri     := Nil
			cSeriOri   := Nil
			nRecnoSD1  := Nil
			nDesconto  := 0

			If !Empty((cAliasSC6)->C6_NFORI)
				dbSelectArea("SD1")
				dbSetOrder(1)
				dbSeek(cFilialSC6+(cAliasSC6)->C6_NFORI+(cAliasSC6)->C6_SERIORI+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA+;
					(cAliasSC6)->C6_PRODUTO+(cAliasSC6)->C6_ITEMORI)
				cNfOri     := (cAliasSC6)->C6_NFORI
				cSeriOri   := (cAliasSC6)->C6_SERIORI
				nRecnoSD1  := SD1->(RECNO())
			EndIf

			dbSelectArea(cAliasSC6)

			If lEnd
				@ Prow()+1,001 PSAY STR0007 //"CANCELADO PELO OPERADOR"
				Exit
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Calcula o preco de lista                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nValMerc  := (cAliasSC6)->C6_VALOR
			nPrcLista := (cAliasSC6)->C6_PRUNIT
			If ( nPrcLista == 0 )
				nPrcLista := NoRound(nValMerc/(cAliasSC6)->C6_QTDVEN,nTamPrcVen)
			EndIf
			nAcresFin := A410Arred((cAliasSC6)->C6_PRCVEN*(cAliasSC5)->C5_ACRSFIN/100,"D2_PRCVEN")
			nValMerc  += A410Arred((cAliasSC6)->C6_QTDVEN*nAcresFin,"D2_TOTAL")		
			nDesconto := a410Arred(nPrcLista*(cAliasSC6)->C6_QTDVEN,"D2_DESCON")-nValMerc
			nDesconto := IIf(nDesconto==0,(cAliasSC6)->C6_VALDESC,nDesconto)
			nDesconto := Max(0,nDesconto)
			nPrcLista += nAcresFin
			If cPaisLoc=="BRA"
				nValMerc  += nDesconto
			EndIf			
						
			MaFisAdd((cAliasSC6)->C6_PRODUTO,; 	  // 1-Codigo do Produto ( Obrigatorio )
				(cAliasSC6)->C6_TES,;			  // 2-Codigo do TES ( Opcional )
				(cAliasSC6)->C6_QTDVEN,;		  // 3-Quantidade ( Obrigatorio )
				nPrcLista,;		  // 4-Preco Unitario ( Obrigatorio )
				nDesconto,;       // 5-Valor do Desconto ( Opcional )
				cNfOri,;		                  // 6-Numero da NF Original ( Devolucao/Benef )
				cSeriOri,;		                  // 7-Serie da NF Original ( Devolucao/Benef )
				nRecnoSD1,;			          // 8-RecNo da NF Original no arq SD1/SD2
				0,;							  // 9-Valor do Frete do Item ( Opcional )
				0,;							  // 10-Valor da Despesa do item ( Opcional )
				0,;            				  // 11-Valor do Seguro do item ( Opcional )
				0,;							  // 12-Valor do Frete Autonomo ( Opcional )
				nValMerc,;// 13-Valor da Mercadoria ( Obrigatorio )
				0,;							  // 14-Valor da Embalagem ( Opiconal )
				0,;		     				  // 15-RecNo do SB1
				0) 							  // 16-RecNo do SF4

			aadd(aItemPed,	{	(cAliasSC6)->C6_ITEM,;
				(cAliasSC6)->C6_PRODUTO,;
				(cAliasSC6)->C6_DESCRI,;
				(cAliasSC6)->C6_TES,;
				(cAliasSC6)->C6_CF,;
				(cAliasSC6)->C6_UM,;
				(cAliasSC6)->C6_QTDVEN,;
				(cAliasSC6)->C6_PRCVEN,;
				(cAliasSC6)->C6_NOTA,;
				(cAliasSC6)->C6_SERIE,;
				(cAliasSC6)->C6_CLI,;
				(cAliasSC6)->C6_LOJA,;
				(cAliasSC6)->C6_VALOR,;
				(cAliasSC6)->C6_ENTREG,;
				(cAliasSC6)->C6_DESCONT,;
				(cAliasSC6)->C6_LOCAL,;
				(cAliasSC6)->C6_QTDEMP,;
				(cAliasSC6)->C6_QTDLIB,;
				(cAliasSC6)->C6_QTDENT,;
				})							
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Forca os valores de impostos que foram informados no SC6.              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea(cAliasSC6)
			For nY := 1 to Len(aFisGet)
				If !Empty(&(aFisGet[ny][2]))
					MaFisAlt(aFisGet[ny][1],&(aFisGet[ny][2]),Len(aItemPed))
				EndIf
			Next nY

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Calculo do ISS                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SF4->(dbSetOrder(1))
			SF4->(MsSeek(cFilialSF4+(cAliasSC6)->C6_TES))
			If ( (cAliasSC5)->C5_INCISS == "N" .And. (cAliasSC5)->C5_TIPO == "N")
				If ( SF4->F4_ISS=="S" )
					nPrcLista := a410Arred(nPrcLista/(1-(MaAliqISS(Len(aItemPed))/100)),"D2_PRCVEN")
					nValMerc  := a410Arred(nValMerc/(1-(MaAliqISS(Len(aItemPed))/100)),"D2_PRCVEN")
					MaFisAlt("IT_PRCUNI",nPrcLista,Len(aItemPed))
					MaFisAlt("IT_VALMERC",nValMerc,Len(aItemPed))
				EndIf
			EndIf	

			If lTpDpInd .Or. (!lTpDpInd .And. SF4->F4_DUPLIC == "S")
				nTotDesc += MaFisRet(Len(aItemPed),"IT_DESCONTO")
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Altera peso para calcular frete              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SB1->(dbSetOrder(1))
			SB1->(MsSeek(cFilialSB1+(cAliasSC6)->C6_PRODUTO))
			IF SB1->B1_PESO > 0			
				MaFisAlt("IT_PESO",(cAliasSC6)->C6_QTDVEN*SB1->B1_PESO,Len(aItemPed))
				MaFisAlt("IT_PRCUNI",nPrcLista,Len(aItemPed))
			EndIf
			aAdd(aValMerc,{nValMerc,Len(aItemPed)})
			
			// Somatória do Peso do Produto
			nVlrPesoUnit	:= ( (cAliasSC6)->C6_QTDVEN*SB1->B1_PESO )
			nPesoTot 		+= nVlrPesoUnit

			(cAliasSC6)->(dbSkip())
		EndDo

		If (( ( cPaisLoc == "PER" .Or. cPaisLoc == "COL" ) .And. aCabPed[19] == "F" ) .Or. ( cPaisLoc != "PER" .And. cPaisLoc != "COL" ))
			If nPesoTot > 0
				MaFisAlt("NF_PESO"    ,nPesoTot )
			Endif
			MaFisAlt("NF_FRETE"   ,nFrete)
		EndIf

		If nSeguro > 0
			MaFisAlt("NF_SEGURO"  ,nSeguro)
		EndIf
		If nFretAut > 0
			MaFisAlt("NF_AUTONOMO",nFretAut)
		EndIf
		If nDespesa > 0
			MaFisAlt("NF_DESPESA" ,nDespesa)
		EndIf
		If nFrete > 0 .Or. nFretAut > 0  .OR. nSeguro > 0 .Or. nDespesa > 0 .Or. nDescCab > 0 .Or. nPDesCab > 0 .Or. nPesoTot > 0
			For nT := 1 To Len(aValMerc)
				MaFisAlt("IT_VALMERC",aValMerc[nT][1],aValMerc[nT][2])
			Next nT
		EndIf
		aSize(aValmerc,0)

		If nPDesCab > 0
			MaFisAlt("NF_DESCONTO",nPDesCab:=A410Arred((MaFisRet(,"NF_VALMERC")+MaFisRet(,'NF_DESCZF')-nTotDesc)*nPDesCab/100,"C6_VALOR")+MaFisRet(,"NF_DESCONTO"))
		EndIf

		If nDescCab > 0
			MaFisAlt("NF_DESCONTO",Min(MaFisRet(,"NF_VALMERC")-0.01,nPDesCab+nTotDesc+nDescCab),/*nItem*/,/*lNoCabec*/,/*nItemNao*/,IIf(lTpDpInd,.F.,.T.))
		EndIf

		nItem := 0
		For nG := 1 To Len(aItemPed)
			nItem += 1
			IF li > 45
				IF lRodape
					ImpRodape(nPesLiq,nTotQtd,nTotVal,@li,nPesBru,aC5Rodape,cAliasSC5,,cAliasSC6)
				Endif
				li := 0
				lRodape := ImpCabec(@li,aPedCli,cAliasSC5)
			Endif
			ImpItem(nItem,@nPesLiq,@li,@nTotQtd,@nTotVal,@nPesBru,cAliasSC6,cAliasSC5)
			li++
		Next

		IF lRodape
			ImpRodape(nPesLiq,nTotQtd,nTotVal,@li,nPesBru,aC5Rodape,cAliasSC5,.T.,cAliasSC6)
			lRodape:=.F.
		Endif

		MaFisEnd()

	Else
		dbSelectArea(cAliasSC5)
		dbSkip()
	EndIf

EndDo

dbSelectArea(cAliasSC5)
dbCloseArea()

Set Device To Screen
Set Printer To

RetIndex("SC5")
dbSelectArea("SC5")
dbClearFilter()

dbSelectArea("SC6")
dbClearFilter()
dbSetOrder(1)
dbGotop()

If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()
Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpItem  ³ Autor ³ Claudinei M. Benzi    ³ Data ³ 05.11.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpItem(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpItem(nItem,nPesLiq,li,nTotQtd,nTotVal,nPesBru,cAliasSC6,cAliasSC5)
/*
01 C6_item
02 C6_produto
03 C6_descri
04 C6_tes
05 C6_cf
06 C6_um
07 C6_qtdven
08 C6_prcven
09 C6_nota
10 C6_serie
11 C6_cli
12 C6_loja
13 C6_valor
14 C6_entreg
15 C6_descont
16 C6_local
17 C6_qtdemp
18 C6_qtdlib
19 C6_qtdent
*/
Local nUltLib  := 0
Local cChaveD2 := ""
Local nDecs	:=	MsDecimais(Max(1,aCabPed[24]))  //C5_MOEDA
Local nValImp	:=0
dbSelectArea("SB1")
dbSeek(xFilial("SB1")+aItemPed[nItem][2])  //C6_PRODUTO

@li,000 psay aItemPed[nItem][01]	//C6_ITEM
@li,003 psay aItemPed[nItem][02]	//C6_PRODUTO
@li,040 psay SUBS(IIF(Empty(aItemPed[nItem][03]),SB1->B1_DESC, aItemPed[nItem][03]),1,30)		//C6_DESCRI
@li,071 psay aItemPed[nItem][04]	//C6_TES
@li,075 psay aItemPed[nItem][05]	//C6_CF
@li,080 psay aItemPed[nItem][06]	//C6_UM
@li,083 psay aItemPed[nItem][07] Picture PesqPictQt("C6_QTDVEN")	//C6_QTDVEN
@li,096 psay aItemPed[nItem][08] Picture PesqPict("SC6","C6_PRCVEN",12)	//C6_PRCVEN
If cPaisLoc == "BRA"
	If aCabPed[1] == "P"
		nValImp := 0
	Else
		nValImp	:=	MaFisRet(nItem,"IT_VALIPI")
	Endif
	@li,109 psay MaFisRet(nItem,"IT_ALIQIPI") Picture "@e 99.99"
Else
	nValImp	:=	MaRetIncIV(nItem,"2")
	@li,110 psay  nValImp	Picture Tm(nValImp,10,nDecs)
Endif
         

If ( cPaisLoc=="BRA" )
	@li,115 psay MaFisRet(nItem,"IT_ALIQICM") Picture "@e 99.99" //Aliq de ICMS
	@li,121 psay MaFisRet(nItem,"IT_ALIQISS") Picture "@e 99.99" //Aliq de ISS	
EndIf
//C6_nota C6_serie C6_cli C6_loja C6_produto
cChaveD2 := xFilial("SD2")+aItemPed[nItem][09]+aItemPed[nItem][10]+aItemPed[nItem][11]+aItemPed[nItem][12]+aItemPed[nItem][02]
dbSelectArea("SD2")
dbSetOrder(3)
dbSeek(cChaveD2)
While !Eof() .and. cChaveD2 = xFilial("SD2")+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD
	nUltLib := D2_QUANT
	dbSkip()
EndDo

@li,126   psay aItemPed[nItem][13]+nValImp Picture PesqPict("SC6","C6_VALOR",16,nDecs)		//C6_VALOR
@li,143   psay aItemPed[nItem][14]		//C6_ENTREG
@li,153   psay aItemPed[nItem][15]    Picture "99.9"  //C6_DESCONT
@li,159   psay aItemPed[nItem][16]		//C6_LOCAL
@li,163   psay aItemPed[nItem][17] Picture PesqPictQt("C6_QTDLIB")		//C6_QTDEMP
//C6_QTDVEN C6_QTDEMP C6_QTDLIB C6_QTDENT
@li,177   psay aItemPed[nItem][07] - aItemPed[nItem][17] + aItemPed[nItem][18] - aItemPed[nItem][19] Picture PesqPictQt("C6_QTDLIB")
@li,190   psay nUltLib Picture PesqPictQt("D2_QUANT")

nTotQtd += aItemPed[nItem][07]						//C6_QTDVEN
nTotVal += aItemPed[nItem][13]+nValImp				//C6_VALOR
nPesLiq	+= SB1->B1_PESO * aItemPed[nItem][07]		//C6_QTDVEN
nPesBru += SB1->B1_PESBRU * aItemPed[nItem][07]		//C6_QTDVEN
Return (Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpRodape³ Autor ³ Claudinei M. Benzi    ³ Data ³ 05.11.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpRoadpe(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpRodape(nPesLiq,nTotQtd,nTotVal,li,nPesBru,aC5Rodape,cAliasSC5,lFinal,cAliasSC6)
Local aCodImps	 :=	{}
Local I     	 := 0
Local nLinMsg    := 1
Local nTamLin    := 0
Local nQtdLinMsg := 0
Local cMsgNota   := ""



DEFAULT lFinal := .F.

@ li,000 psay Replicate("-",limite)
li++
@ li,000 psay STR0029	//" T O T A I S "
@ li,072 psay nTotQtd    Picture PesqPict("SC6","C6_QTDVEN",20)
@ li,126 psay nTotVal    Picture PesqPict("SC6","C6_VALOR",17)
If lFinal
	li++
	@ li,000 psay Replicate("-",limite-37)
	If cPaisLoc == 'BRA'
		li++
		@ li,000 psay STR0038
		@ li,026 PSay STR0039
		@ li,046 PSay STR0040
		@ li,067 PSay STR0041
		@ li,087 PSay STR0042
		@ li,107 PSay STR0043
		@ li,128 PSay STR0044
		@ li,149 PSay STR0045	
		li++
		@ li,022 PSay Transform(MaFisRet(,"NF_BASEICM"),PesqPict("SF2","F2_BASEICM"))
		@ li,042 PSay Transform(MaFisRet(,"NF_VALICM") ,PesqPict("SF2","F2_VALICM") )
		@ li,062 PSay Transform(MaFisRet(,"NF_BASEIPI"),PesqPict("SF2","F2_BASEIPI"))
		@ li,083 PSay Transform(MaFisRet(,"NF_VALIPI") ,PesqPict("SF2","F2_VALIPI") )
		@ li,105 PSay Transform(MaFisRet(,"NF_BASESOL"),PesqPict("SF2","F2_ICMSRET"))
		@ li,127 PSay Transform(MaFisRet(,"NF_VALSOL") ,PesqPict("SF2","F2_VALBRUT"))
		@ li,147 PSay Transform(MaFisRet(,"NF_TOTAL")  ,PesqPict("SF2","F2_VALBRUT"))
		li++                                                                            	
		@ li,026 psay STR0046
		@ li,046 PSay STR0047
		li++                                                                            		
		@ li,022 PSay Transform(MaFisRet(,"NF_BASEISS"),PesqPict("SF2","F2_BASEISS"))
		@ li,042 PSay Transform(MaFisRet(,"NF_VALISS") ,PesqPict("SF2","F2_VALISS") )
	Else

		aCodImps := MaFisRet(,"NF_IMPOSTOS") //Descricao / /Aliquota / Valor / Base
		li++
		@ li,000 psay STR0038
		@ li,025 PSay STR0049 //"Imposto                                 Base      Aliquota         Valor"
		li++         			
		@ li,025 PSay           "------------------------------ ------------- ------------- -------------"
		li++
		For I:=1 To Len(aCodImps)// Vetor com os impostos
			@ li,25 PSay aCodImps[I][2]
			@ li,57 PSay aCodImps[I][3] Picture TM(aCodImps[I][4],12,MsDecimais(1))
			@ li,71 PSay aCodImps[I][4] Picture TM(aCodImps[I][4],12,MsDecimais(1))
			@ li,85 PSay aCodImps[I][5] Picture TM(aCodImps[I][4],12,MsDecimais(1))
			li++
		Next

	Endif
Endif	

@ 51,005 psay STR0030+STR(If(aC5Rodape[1][1] > 0,aC5Rodape[1][1],nPesBru))	//"PESO BRUTO ------>"
@ 52,005 psay STR0031+STR(If(aC5Rodape[1][2] > 0,aC5Rodape[1][2] ,nPesLiq))	//"PESO LIQUIDO ---->"
@ 53,005 psay STR0032	//"VOLUMES --------->"
@ 54,005 psay STR0033	//"SEPARADO POR ---->"
@ 55,005 psay STR0034	//"CONFERIDO POR --->"
@ 56,005 psay STR0035	//"D A T A --------->"

@ 58,000 psay STR0036	//"DESCONTOS: "
@ 58,011 psay aC5Rodape[1][3] Picture "99.99"
@ 58,019 psay aC5Rodape[1][4] picture "99.99"
@ 58,027 psay aC5Rodape[1][5] picture "99.99"
@ 58,035 psay aC5Rodape[1][6] picture "99.99"

cMsgNota := STR0037 + AllTrim(aC5Rodape[1][7])	// "MENSAGEM PARA NOTA FISCAL: "
nTamLin := 220
nQtdLinMsg := MLCount(cMsgNota,nTamLin)

@ 59 + nLinMsg,000 psay MemoLine(cMsgNota,nTamLin,nLinMsg)			//"MENSAGEM PARA NOTA FISCAL: "

For nLinMsg := 2 To nQtdLinMsg
	@ 59 + nLinMsg,000 psay MemoLine(cMsgNota,nTamLin,nLinMsg)			//"MENSAGEM PARA NOTA FISCAL: "
Next nLinMsg

@ 59 + nLinMsg,000 psay ""

li := 80

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpCabec ³ Autor ³ Claudinei M. Benzi    ³ Data ³ 05.11.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpCabec(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpCabec(li,aPedCli,cAliasSC5)

Local cHeader	:= ""
Local nPed		:= 0
Local i         := 0
Local cMoeda	:= ""
Local cPedCli   := ""
Local cPictCgc  := ""
If cPaisLoc == "BRA"
	cHeader := STR0008	// It Codigo          Desc. do Material              TES CF   UM        Quant.  Valor Unit. IPI   ICMS   ISS     Vl.Tot.C/IPI Entrega   Desc Loc.    Qtd.a Fat         Saldo      Ult.Fat.
	//          		   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14
	//                     0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234
Else
	cHeader := STR0048	//"It Codigo          Desc de Material               TES CF   UM        Quant.  Valor Unit.        Imp.Inc.       Valor Total Entrega   Desc Loc.      Ctd.Ent         Saldo     Ult.Entr."
	//        			   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14
	//                     0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234
Endif

/* array acabped
01 C5_TIPO
02 C5_CLIENTE
03 C5_LOJACLI
04 C5_TRANSP
05 C5_CONDPAG
06 C5_EMISSAO
07 C5_NUM
08 C5_VEND1
09 C5_VEND2
10 C5_VEND3
11 C5_VEND4
12 C5_VEND5
13 C5_COMIS1
14 C5_COMIS2
15 C5_COMIS3
16 C5_COMIS4
17 C5_COMIS5
18 C5_FRETE
19 C5_TPFRETE
20 C5_SEGURO
21 C5_TABELA
22 C5_VOLUME1
23 C5_ESPECI1
24 C5_MOEDA
25 C5_REAJUST
26 C5_BANCO
27 C5_ACRSFIN
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona registro no cliente do pedido                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

IF !(aCabPed[1]$"DB")   //C5_TIPO
	dbSelectArea("SA1")
	dbSeek(xFilial("SA1")+aCabped[2]+aCabped[3])  //C5_CLIENTE + C5_LOJACLI
	cPictCgc := PesqPict("SA1","A1_CGC")	
Else
	dbSelectArea("SA2")
	dbSeek(xFilial("SA2")+aCabPed[2]+aCabPed[3])  //C5_CLIENTE + C5_LOJACLI
	cPictCgc := PesqPict("SA2","A2_CGC")	
Endif

dbSelectArea("SA4")
dbSetOrder(1)
dbSeek(xFilial("SA4")+aCabPed[4])		//C5_TRANSP
dbSelectArea("SE4")
dbSetOrder(1)
dbSeek(xFilial("SE4")+aCabPed[5])		//C5_CONDPAG

aSort(aPedCli)
@ 00,000 psay AvalImp(limite)
@ 01,000 psay Replicate("-",limite-37)
@ 02,000 psay SubStr(rTrim(SM0->M0_NOME) + IIF(!Empty(SM0->M0_NOMECOM), ' - ' + rTrim(SM0->M0_NOMECOM),''),1,40)
IF !(aCabPed[1]$"DB")		//C5_TIPO
	@ 02,041 psay "| "+Left(SA1->A1_COD+"/"+SA1->A1_LOJA+" "+ FATPDObfuscate(SA1->A1_NOME,"A1_NOME"), 56)
	@ 02,100 psay STR0009		//"| CONFIRMACAO DO PEDIDO "
	@ 03,000 psay Rtrim(SM0->M0_ENDCOB)
	@ 03,041 psay "| "+IF( !Empty(SA1->A1_ENDENT) .And. SA1->A1_ENDENT # SA1->A1_END, rTrim(FATPDObfuscate(SA1->A1_ENDENT,"A1_ENDENT")), rTrim(FATPDObfuscate(SA1->A1_END,"A1_END")) )
	@ 03,100 psay "|"
	@ 04,000 psay STR0010+SM0->M0_TEL			//"TEL: "
	@ 04,041 psay "| "
	@ 04,043 psay Rtrim(IF( !Empty(SA1->A1_CEPE) .And. SA1->A1_CEPE # SA1->A1_CEP,FATPDObfuscate(SA1->A1_CEPE,"A1_CEPE"), FATPDObfuscate(SA1->A1_CEP,"A1_CEP") ))
	@ 04,053 psay Rtrim(IF( !Empty(SA1->A1_MUNE) .And. SA1->A1_MUNE # SA1->A1_MUN,rTrim(SA1->A1_MUNE), rTrim(SA1->A1_MUN) ))
	@ 04,077 psay Rtrim(IF( !Empty(SA1->A1_ESTE) .And. SA1->A1_ESTE # SA1->A1_EST,SA1->A1_ESTE, SA1->A1_EST ))
	@ 04,100 psay STR0011		//"| EMISSAO: "
	@ 04,111 psay aCabPed[6]	//C5_EMISSAO
	@ 05,000 psay Iif(cPaisLoc=="BRA",STR0012,Alltrim(Posicione('SX3',2,'A1_CGC','SX3->X3_TITULO'))+":")		//"CGC: "
	@ 05,006 psay SM0->M0_CGC    Picture cPictCGC //"@R 99.999.999/9999-99"
	@ 05,025 psay Subs(SM0->M0_CIDCOB,1,15)
	@ 05,041 psay "|"
	@ 05,043 psay FATPDObfuscate(subs(transform(SA1->A1_CGC,PicPes(RetPessoa(SA1->A1_CGC))),1,at("%",transform(SA1->A1_CGC,PicPes(RetPessoa(SA1->A1_CGC))))-1),"A1_CGC")
	If cPaisLoc == "BRA"	
		@ 05,062 psay STR0013+SA1->A1_INSCR			//"IE: "
	Endif
	@ 05,100 psay STR0014+aCabPed[7]			//"| PEDIDO N. "	//C5_NUM
Else
	@ 02,041 psay "| "+SA2->A2_COD+"/"+SA2->A2_LOJA+" "+FATPDObfuscate(SA2->A2_NOME,"A2_NOME")
	@ 02,100 psay STR0009	//"| CONFIRMACAO DO PEDIDO "
	@ 03,000 psay Rtrim(SM0->M0_ENDCOB)
	@ 03,041 psay "| "+ Rtrim(FATPDObfuscate(SA2->A2_END,"A2_END"))
	@ 03,100 psay "|"
	@ 04,000 psay STR0010+SM0->M0_TEL			//"TEL: "
	@ 04,041 psay "| "+ Rtrim(FATPDObfuscate(SA2->A2_CEP,"A2_CEP"))
	@ 04,053 psay Rtrim(SA2->A2_MUN)
	@ 04,077 psay Rtrim(SA2->A2_EST)
	@ 04,100 psay STR0011		//"| EMISSAO: "
	@ 04,111 psay aCabPed[6]	//C5_EMISSAO
	@ 05,000 psay Iif(cPaisLoc=="BRA",STR0012,Alltrim(Posicione('SX3',2,'A1_CGC','SX3->X3_TITULO'))+":")		//"CGC: "
	@ 05,006 psay SM0->M0_CGC    Picture cPictCGC //"@R 99.999.999/9999-99"
	@ 05,025 psay Subs(SM0->M0_CIDCOB,1,15)
	@ 05,041 psay "|"
	@ 05,043 psay FATPDObfuscate(SA2->A2_CGC,"A2_CGC")    Picture cPictCGC //"@R 99.999.999/9999-99"
	If cPaisLoc == "BRA"	
		@ 05,062 psay STR0013+SA2->A2_INSCR			//"IE: "
	Endif	
	@ 05,100 psay STR0014+aCabPed[7]			//"| PEDIDO N. "	//C5_NUM
Endif
li:= 6
If Len(aPedCli) > 0
	@ li,000 psay Replicate("-",limite-37)
	li++
	@ li,000 psay "PEDIDO(S) DO CLIENTE:"
	cPedCli:=""
	For nPed := 1 To Len(aPedCli)
		cPedCli += aPedCli[nPed]+Space(02)
		If Len(cPedCli) > 100 .or. nPed == Len(aPedCli)
			@ li,23 psay cPedCli
			cPedCli:=""
			li++
		Endif
	Next
Endif
@ li,000 psay Replicate("-",limite-37)
li++
@ li,000 psay STR0016+aCabPed[4]+" - "+SA4->A4_NOME			//"TRANSP...: "		//C5_TRANSP
li++

For i := 8 to 12
	dbSelectArea("SA3")
	dbSetOrder(1)
	If dbSeek(xFilial("SA3")+aCabPed[i])	//C5_VENDi
		If i == 8
			@ li,000 psay STR0017		//"VENDEDOR.: "
		EndIf
		@ li,013 psay aCabPed[i] + " - "+ FATPDObfuscate(SA3->A3_NOME,"A3_NOME")	//C5_VENDi
		If i == 8
			@ li,065 psay STR0018		//"COMISSAO: "
		EndIf
		@ li,075 psay aCabPed[i+5] Picture "99.99"		//C5_COMISi+5
		li++
	EndIf	
Next

@ li,000 psay STR0019+aCabPed[5]+" - "+SE4->E4_DESCRI			//"COND.PGTO: "		//C5_CONDPAG
@ li,065 psay STR0020		//"FRETE...: "
@ li,075 psay aCabPed[18] Picture "@EZ 999,999,999.99"		//C5_FRETE
@ li,090 psay TipoFrete(aCabPed[19])		//C5_TPFRETE
@ li,100 psay STR0021		//"SEGURO: "
@ li,108 psay aCabPed[20] Picture "@EZ 999,999,999.99"		//C5_SEGURO
li++
@ li,000 psay STR0022+aCabPed[21]		//"TABELA...: "		//C5_TABELA
@ li,065 psay STR0023		//"VOLUMES.: "
@ li,075 psay aCabPed[22]    Picture "@EZ 999,999"		//C5_VOLUME1s
@ li,100 psay STR0024+aCabPed[23]		//"ESPECIE: "	//C5_ESPECIE1
li++
cMoeda:=Strzero(aCabPed[24],1,0)		//C5_MOEDA
@ li,000 psay STR0025+aCabPed[25]+STR0026 +IIF(cMoeda < "2","1",cMoeda)		//"REAJUSTE.: "###"   Moeda : " 	//C5_REAJUST
@ li,065 psay STR0027 + aCabPed[26]					//"BANCO: "		//C5_BANCO
@ li,100 psay STR0028+Str(aCabPed[27],6,2)		//"ACRES.FIN.: "	//C5_ACRSFIN
li++
@ li,000 psay Replicate("-",limite)
li++
@ li,000 psay cHeader
li++   
@ li,000 psay Replicate("-",limite)
li++

Return( .T. )  

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Mtr730Cli ³ Autor ³ Henry Fila            ³ Data ³ 26.08.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Função que retorna os pedidos do cliente                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ Mtr730Cli(cPedido)                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1: Numero do pedido                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Mtr730Cli(cPedido)

Local aPedidos := {}
Local aArea    := GetArea()
Local aAreaSC6 := SC6->(GetArea())

SC6->(dbSetOrder(1))
SC6->(MsSeek(xFilial("SC6")+cPedido))

While !(SC6->(Eof())) .And. xFilial("SC6")==SC6->C6_FILIAL .And.;
		SC6->C6_NUM == cPedido

	If !Empty(SC6->C6_PEDCLI) .and. Ascan(aPedidos,SC6->C6_PEDCLI) = 0
		Aadd(aPedidos, SC6->C6_PEDCLI )
	Endif		

	SC6->(dbSkip())
Enddo

RestArea(aAreaSC6)
RestArea(aArea)

Return(aPedidos)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FisGetInit³ Autor ³Eduardo Riera          ³ Data ³17.11.2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Inicializa as variaveis utilizadas no Programa              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FisGetInit(aFisGet,aFisGetSC5)

Local cValid      := ""
Local cReferencia := ""
Local nPosIni     := 0
Local nLen        := 0
Local nI 		  := 1
Local aCampos 	  := {}
Local cCampo	  := ""

If aFisGet == Nil
	aFisGet	:= {}
	aCampos := {}
	aCampos := FWSX3Util():GetAllFields('SC6')
	For nI := 01 to Len(aCampos)
		cValid := Upper(GetSX3Cache(aCampos[nI], "X3_VALID" )) + Upper(GetSX3Cache(aCampos[nI], "X3_VLDUSER" ))
		cCampo := GetSX3Cache(aCampos[nI], "X3_CAMPO")
		If 'MAFISGET("'$cValid
			nPosIni 	:= AT('MAFISGET("',cValid)+10
			nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
			cReferencia := Substr(cValid,nPosIni,nLen)
			Aadd(aFisGet,{cReferencia,cCampo,MaFisOrdem(cReferencia)})
			 
		EndIf
		If 'MAFISREF("'$cValid
			nPosIni		:= AT('MAFISREF("',cValid) + 10
			cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
			Aadd(aFisGet,{cReferencia,cCampo,MaFisOrdem(cReferencia)})
		EndIf
	Next
	aSort(aFisGet,,,{|x,y| x[3]<y[3]})
EndIf

If aFisGetSC5 == Nil
	aFisGetSC5	:= {}
	aCampos 	:= {}
	aCampos 	:= FWSX3Util():GetAllFields('SC5')
	For nI := 01 to Len(aCampos)
		cValid := Upper(GetSX3Cache(aCampos[nI], "X3_VALID" )) + Upper(GetSX3Cache(aCampos[nI], "X3_VLDUSER" ))
		cCampo := GetSX3Cache(aCampos[nI], "X3_CAMPO")
		If 'MAFISGET("'$cValid
			nPosIni 	:= AT('MAFISGET("',cValid)+10
			nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
			cReferencia := Substr(cValid,nPosIni,nLen)
			Aadd(aFisGetSC5,{cReferencia,cCampo,MaFisOrdem(cReferencia)})
		EndIf
		If 'MAFISREF("'$cValid
			nPosIni		:= AT('MAFISREF("',cValid) + 10
			cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
			Aadd(aFisGetSC5,{cReferencia,cCampo,MaFisOrdem(cReferencia)})
		EndIf
	Next
	aSort(aFisGetSC5,,,{|x,y| x[3]<y[3]})
EndIf
MaFisEnd()

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³TipoFrete ³ Autor ³Vendas e CRM           ³ Data ³23/02/2012³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Texto do tipo de frete                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Texto do tipo de frete                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Sigla do frete                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function TipoFrete(cTipofrete)
Local cReturn := ''

Do Case
	Case cTipofrete = 'C'
		cReturn := '(CIF)'
	Case cTipofrete = 'F'
		cReturn := '(FOB)'
	Case cTipofrete = 'T'
		cReturn := '(TER)'
	Case cTipofrete = 'R'
		cReturn := '(REM)'
	Case cTipofrete = 'D'
		cReturn := '(DES)'
	Case cTipofrete = 'S'
		cReturn := '(SEM)'
End

Return cReturn

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuário utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serão verificados.
    @param aFields, Array, Array com todos os Campos que serão verificados, utilizado 
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
    Finaliza o gerenciamento dos campos com proteção de dados.
	Remover essa função quando não houver releases menor que 12.1.27

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
	Remover essa função quando não houver releases menor que 12.1.27

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
    Função que verifica se a melhoria de Dados Protegidos existe.

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

//-----------------------------------------------------------------------------
/*/{Protheus.doc} MR730TamLin
    @description
    Função que retorna o tamanho da linha em caracteres de acordo com o tamanho 
	da fonte

    @type  Function
    @sample MR730TamLin(oReport)
    @author Squad CRM & Faturamento
    @since 13/10/2021
    @version P12    
	@param oReport, TReport, Objeto do relatório em execucao
    @return nTamLin, Number, Tamanho da linha em caracteres
/*/
//-----------------------------------------------------------------------------
Static Function MR730TamLin(oReport)
	
	Local nTamLin    := 0
	Local nWidthPxl  := 0
	Local nLenFntPxl := 0

	nWidthPxl  := oReport:PageWidth()	// Largura da página baseado no tamanho da folha (A4, Carta, etc)
	nLenFntPxl := oReport:Char2Pix(" ")	// Tamanho da fonte em pixel

	// Verificar quantos caracteres cabe em 70% da pagina
	nTamLin := Round((nWidthPxl/nLenFntPxl) * 0.70, 0)

Return nTamLin
