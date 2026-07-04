/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR681.CH"
#INCLUDE "Protheus.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR681  ³ Autor ³ Marco Bianchi         ³ Data ³ 13/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Informe de Pedidos de Venda/Remitos/Notas Fiscais          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT - Localizacoes - R4                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR681()

	Local oReport	:= Nil
	
	Private cRetTitle	:= GetDescRem()

	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³14/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport	:= Nil
Local oRelat1	:= Nil
Local oRelat2	:= Nil
Local oRelat3	:= Nil

Local cAliasQry	:= ""
Local cDoc		:= ""
Local cItem		:= ""
Local dEmissao	:= ctod("  /  /  ")
Local nQuant	:= 0

Local cCliente	:= ""
Local cLoja		:= ""
Local cCod		:= ""
Local cUM		:= ""
Local cGrupo	:= ""

Local cSerie	:= ""
Local cEspecie	:= ""
Local nTotal	:= 0
Local nTamData	:= Len(DTOC(MsDate()))

cAliasQry := GetNextAlias()

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
oReport := TReport():New("MATR681",STR0014,"MTR681", {|oReport| ReportPrint(oReport,oRelat1,oRelat2,oRelat3,cAliasQry)},STR0014) //"Lista de Pedidos de Venta/ Remito /Factura"
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

Pergunte(oReport:uParam,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 1 : PV/RM/FT                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oRelat1 := TRSection():New(oReport,STR0025,{"SC5","SC6","SD2"},{STR0017,STR0018},/*Campos do SX3*/,/*Campos do SIX*/) //"Por Pedido/Remito/Factura" - "Fecha de Emision" - "Cliente"
oRelat1:SetTotalInLine(.F.)
oRelat1:SetLineBreak()

// Informacoes do Pedido de Venda
TRCell():New(oRelat1,"C5_EMISSAOE"	,/*Tabela*/	,RetTitle("C5_EMISSAO"	),PesqPict("SC5","C5_EMISSAO"),nTamData,/*lPixel*/,{|| (cAliasQry)->C5_EMISSAO })
TRCell():New(oRelat1,"C5_CLIENTEE"	,/*Tabela*/	,RetTitle("C5_CLIENTE"	),PesqPict("SC5","C5_CLIENTE"),TamSX3("C5_CLIENTE")[1],/*lPixel*/,{|| (cAliasQry)->C5_CLIENTE })
TRCell():New(oRelat1,"C5_LOJACLIE"	,/*Tabela*/	,RetTitle("C5_LOJACLI"	),PesqPict("SC5","C5_LOJACLI"),TamSX3("C5_LOJACLI")[1],/*lPixel*/,{|| (cAliasQry)->C5_LOJACLI })
TRCell():New(oRelat1,"C5_CLIENTEC"	,/*Tabela*/	,RetTitle("C5_CLIENTE"	),PesqPict("SC5","C5_CLIENTE"),TamSX3("C5_CLIENTE")[1],/*lPixel*/,{|| (cAliasQry)->C5_CLIENTE })
TRCell():New(oRelat1,"C5_LOJACLIC"	,/*Tabela*/	,RetTitle("C5_LOJACLI"	),PesqPict("SC5","C5_LOJACLI"),TamSX3("C5_LOJACLI")[1],/*lPixel*/,{|| (cAliasQry)->C5_LOJACLI })
TRCell():New(oRelat1,"C5_EMISSAOC"	,/*Tabela*/	,RetTitle("C5_EMISSAO"	),PesqPict("SC5","C5_EMISSAO"),nTamData,/*lPixel*/,{|| (cAliasQry)->C5_EMISSAO })
TRCell():New(oRelat1,"C6_NUM"		,"SC6"		,RetTitle("C6_NUM"		),PesqPict("SC6","C6_NUM"		),TamSX3("C6_NUM"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat1,"C6_ITEM"		,"SC6"		,Substr(RetTitle("C6_ITEM"),1,2),PesqPict("SC6","C6_ITEM"		),TamSX3("C6_ITEM"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat1,"C6_PRODUTO"	,"SC6"		,RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSX3("C6_PRODUTO"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat1,"C6_UM"		,"SC6"		,RetTitle("C6_UM"		),PesqPict("SC6","C6_UM"		),TamSX3("C6_UM"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat1,"B1_GRUPO"		,"SB1"		,RetTitle("B1_GRUPO"	),PesqPict("SB1","B1_GRUPO"		),TamSX3("B1_GRUPO"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat1,"C6_QTDVEN"	,"SC6"		,RetTitle("C6_QTDVEN"	),PesqPict("SC6","C6_QTDVEN"	),TamSX3("C6_QTDVEN"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oRelat1,"C6_VALOR"		,"SC6"		,RetTitle("C6_VALOR"	),PesqPict("SC6","C6_VALOR"		),TamSX3("C6_VALOR"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oRelat1,"C6_ENTREG"	,"SC6"		,RetTitle("C6_ENTREG"	),PesqPict("SC6","C6_ENTREG"	),nTamData,/*lPixel*/,/*{|| code-block de impressao }*/)
// Informacoes do Remito
If cPaisLoc == "VEN"
	TRCell():New(oRelat1,"DOC"		,"SD2",STR0024					 ,PesqPict("SD2","D2_DOC"		),TamSX3("D2_DOC"	)[1],/*lPixel*/,{|| cDoc 		})//Fatura
Else
	TRCell():New(oRelat1,"DOC"		,"SD2",cRetTitle				 ,PesqPict("SD2","D2_DOC"		),TamSX3("D2_DOC"	)[1],/*lPixel*/,{|| cDoc 		})//Remito
EndIf
TRCell():New(oRelat1,"ITEM"		,"SD2",Substr(RetTitle("D2_ITEM"),1,2),PesqPict("SD2","D2_ITEM"		),TamSX3("D2_ITEM"	)[1],/*lPixel*/,{|| cItem 		})
TRCell():New(oRelat1,"EMISSAO"	,"SD2",RetTitle("D2_EMISSAO"	),PesqPict("SD2","D2_EMISSAO"	),nTamData				,/*lPixel*/,{|| dEmissao 	})
TRCell():New(oRelat1,"QUANT"	,"SD2",RetTitle("D2_QUANT"		),PesqPict("SD2","D2_QUANT"		),TamSX3("D2_QUANT"	)[1],/*lPixel*/,{|| nQuant 		},,,"RIGHT")
// Informacoes da Fatura
TRCell():New(oRelat1,SerieNfId("SD2",3,"D2_SERIE")	,"SD2",Substr(SerieNfId("SD2",7,"D2_SERIE"),1,3),PesqPict("SD2","D2_SERIE"),SerieNfId("SD2",6,"D2_SERIE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat1,"D2_DOC"		,"SD2",STR0024					 ,PesqPict("SD2","D2_DOC"		),TamSX3("D2_DOC"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/) //"Factura"
TRCell():New(oRelat1,"D2_ITEM"		,"SD2",Substr(RetTitle("D2_ITEM"),1,2),PesqPict("SD2","D2_ITEM"		),TamSX3("D2_ITEM"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat1,"D2_EMISSAO"	,"SD2",RetTitle("D2_EMISSAO"	),PesqPict("SD2","D2_EMISSAO"	),nTamData					,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat1,"D2_QUANT"		,"SD2",RetTitle("D2_QUANT"		),PesqPict("SD2","D2_QUANT"		),TamSX3("D2_QUANT"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oRelat1,"D2_TOTAL"		,"SD2",RetTitle("D2_TOTAL"		),PesqPict("SD2","D2_TOTAL"		),TamSX3("D2_TOTAL"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 2 : RM/PV/FT                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oRelat2 := TRSection():New(oReport,STR0026,{"SC5","SC6","SD2"},{STR0017,STR0018},/*Campos do SX3*/,/*Campos do SIX*/) //"Por Remito/Pedido/Factura" - "Fecha de Emision" - "Cliente"
oRelat2:SetTotalInLine(.F.)
oRelat2:SetLineBreak()

// Informacoes do Remito
TRCell():New(oRelat2,"D2_EMISSAOE"	,/*Tabela*/,RetTitle("D2_EMISSAO")	,PesqPict("SD2","D2_EMISSAO"),nTamData,/*lPixel*/,{||dEmissao})
TRCell():New(oRelat2,"D2_CLIENTEE"	,/*Tabela*/,RetTitle("D2_CLIENTE")	,PesqPict("SD2","D2_CLIENTE"),TamSX3("D2_CLIENTE"	)[1],/*lPixel*/,{||cCliente})
TRCell():New(oRelat2,"D2_LOJAE"		,/*Tabela*/,RetTitle("D2_LOJA"   )	,PesqPict("SD2","D2_LOJA"   ),TamSX3("D2_LOJA"		)[1],/*lPixel*/,{||cLoja	})
TRCell():New(oRelat2,"D2_CLIENTEC"	,/*Tabela*/,RetTitle("D2_CLIENTE")	,PesqPict("SD2","D2_CLIENTE"),TamSX3("D2_CLIENTE"	)[1],/*lPixel*/,{||cCliente})
TRCell():New(oRelat2,"D2_LOJAC"	  	,/*Tabela*/,RetTitle("D2_LOJA"   )	,PesqPict("SD2","D2_LOJA"   ),TamSX3("D2_LOJA"		)[1],/*lPixel*/,{||cLoja	})
TRCell():New(oRelat2,"D2_EMISSAOC"	,/*Tabela*/,RetTitle("D2_EMISSAO")	,PesqPict("SD2","D2_EMISSAO"),nTamData					,/*lPixel*/,{||dEmissao})
If cPaisLoc == "VEN"
	TRCell():New(oRelat2,"D2_DOC"  		,/*Tabela*/,STR0024					,PesqPict("SD2","D2_DOC"	),TamSX3("D2_DOC"		)[1],/*lPixel*/,{|| cDoc 	})//Fatura
Else
	TRCell():New(oRelat2,"D2_DOC"  		,/*Tabela*/,cRetTitle				,PesqPict("SD2","D2_DOC"	),TamSX3("D2_DOC"		)[1],/*lPixel*/,{|| cDoc 	})//Remito
EndIf
TRCell():New(oRelat2,"D2_ITEM"		,/*Tabela*/,Substr(RetTitle("D2_ITEM"),1,2),PesqPict("SD2","D2_ITEM"	),TamSX3("D2_ITEM"		)[1],/*lPixel*/,{|| cItem 	})
TRCell():New(oRelat2,"D2_COD"		,/*Tabela*/,RetTitle("D2_COD"	)	,PesqPict("SD2","D2_COD"	),TamSX3("D2_COD"		)[1],/*lPixel*/,{|| cCod 	})
TRCell():New(oRelat2,"D2_UM"		,/*Tabela*/,RetTitle("D2_UM"	)	,PesqPict("SD2","D2_UM"		),TamSX3("D2_UM"		)[1],/*lPixel*/,{|| cUM 	})
TRCell():New(oRelat2,"D2_GRUPO"		,/*Tabela*/,RetTitle("D2_GRUPO"	)	,PesqPict("SD2","D2_GRUPO"	),TamSX3("D2_GRUPO"		)[1],/*lPixel*/,{|| cGrupo })
TRCell():New(oRelat2,"D2_QUANT"		,/*Tabela*/,RetTitle("D2_QUANT"	)	,PesqPict("SD2","D2_QUANT"	),TamSX3("D2_QUANT"		)[1],/*lPixel*/,{|| nQuant },,,"RIGHT")

// Dados do Pedido de Vendas
TRCell():New(oRelat2,"C6_NUM"		,"SC6",RetTitle("C6_NUM"	),PesqPict("SC6","C6_NUM"		),TamSX3("C6_NUM"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat2,"C6_ITEM"		,"SC6",Substr(RetTitle("C6_ITEM"),1,2),PesqPict("SC6","C6_ITEM"		),TamSX3("C6_ITEM"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat2,"C5_EMISSAO"	,"SC5",RetTitle("C5_EMISSAO"),PesqPict("SC5","C5_EMISSAO"	),nTamData				,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat2,"C6_QTDVEN"	,"SC6",RetTitle("C6_QTDVEN"	),PesqPict("SC6","C6_QTDVEN"	),TamSX3("C6_QTDVEN")[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oRelat2,"C6_VALOR"		,"SC6",RetTitle("C6_VALOR"	),PesqPict("SC6","C6_VALOR"		),TamSX3("C6_VALOR"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oRelat2,"C6_ENTREG"	,"SC6",RetTitle("C6_ENTREG"	),PesqPict("SC6","C6_ENTREG"	),nTamData				,/*lPixel*/,/*{|| code-block de impressao }*/)

// Informacoes da Fatura
TRCell():New(oRelat2,"SERIE"	,"SD2",Substr(SerieNfId("SD2",7,"D2_SERIE"),1,3),PesqPict("SD2","D2_SERIE"),SerieNfId("SD2",6,"D2_SERIE"),/*lPixel*/,{|| SerieNfId("SD2",2,"D2_SERIE")	})
TRCell():New(oRelat2,"DOC"		,"SD2",STR0024				 ,PesqPict("SD2","D2_DOC"	  ),TamSX3("D2_DOC"		)[1],/*lPixel*/,{|| SD2->D2_DOC 		}) //"Factura"
TRCell():New(oRelat2,"ITEM"		,"SD2",Substr(RetTitle("D2_ITEM"),1,2),PesqPict("SD2","D2_ITEM"	  ),TamSX3("D2_ITEM"	)[1],/*lPixel*/,{|| SD2->D2_ITEM 		})
TRCell():New(oRelat2,"EMISSAO"	,"SD2",RetTitle("D2_EMISSAO"),PesqPict("SD2","D2_EMISSAO"),nTamData				,/*lPixel*/,{|| SD2->D2_EMISSAO	})
TRCell():New(oRelat2,"QUANT"	,"SD2",RetTitle("D2_QUANT"	),PesqPict("SD2","D2_QUANT"	  ),TamSX3("D2_QUANT"	)[1],/*lPixel*/,{|| SD2->D2_QUANT 		},,,"RIGHT")
TRCell():New(oRelat2,"TOTAL"	,"SD2",RetTitle("D2_TOTAL"	),PesqPict("SD2","D2_TOTAL"	  ),TamSX3("D2_TOTAL"	)[1],/*lPixel*/,{|| SD2->D2_TOTAL 		},,,"RIGHT")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 3 : FT/RM/PV                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oRelat3 := TRSection():New(oReport,STR0027,{"SC5","SC6","SD2"},{STR0017,STR0018},/*Campos do SX3*/,/*Campos do SIX*/) //"Por Factura/Remito/Pedido" - "Fecha de Emision" - "Cliente"
oRelat3:SetTotalInLine(.F.)
oRelat3:SetLineBreak()

// Informacoes da Fatura
TRCell():New(oRelat3,"D2_EMISSAOE"	,/*Tabela*/,RetTitle("D2_EMISSAO"	),PesqPict("SD2","D2_EMISSAO"	),nTamData,/*lPixel*/,{||dEmissao})
TRCell():New(oRelat3,"D2_CLIENTEE"	,/*Tabela*/,RetTitle("D2_CLIENTE"	),PesqPict("SD2","D2_CLIENTE"	),TamSX3("D2_CLIENTE"	)[1],/*lPixel*/,{||cCliente})
TRCell():New(oRelat3,"D2_LOJAE"		,/*Tabela*/,RetTitle("D2_LOJA"   	),PesqPict("SD2","D2_LOJA"   	),TamSX3("D2_LOJA"		)[1],/*lPixel*/,{||cLoja	})
TRCell():New(oRelat3,"D2_CLIENTEC"	,/*Tabela*/,RetTitle("D2_CLIENTE"	),PesqPict("SD2","D2_CLIENTE"	),TamSX3("D2_CLIENTE"	)[1],/*lPixel*/,{||cCliente})
TRCell():New(oRelat3,"D2_LOJAC"	  	,/*Tabela*/,RetTitle("D2_LOJA"   	),PesqPict("SD2","D2_LOJA"   	),TamSX3("D2_LOJA"		)[1],/*lPixel*/,{||cLoja	})
TRCell():New(oRelat3,"D2_EMISSAOC"	,/*Tabela*/,RetTitle("D2_EMISSAO"	),PesqPict("SD2","D2_EMISSAO"	),nTamData					,/*lPixel*/,{||dEmissao})
TRCell():New(oRelat3,SerieNfId("SD2",3,"D2_SERIE"),/*Tabela*/,Substr(SerieNfId("SD2",7,"D2_SERIE"),1,3),PesqPict("SD2","D2_SERIE"),SerieNfId("SD2",6,"D2_SERIE"),/*lPixel*/,{|| cSerie 		})
TRCell():New(oRelat3,"D2_DOC"		,/*Tabela*/,STR0024					 ,PesqPict("SD2","D2_DOC"		),TamSX3("D2_DOC"		)[1],/*lPixel*/,{|| cDoc 		},,,,,,.T.) //"Factura"
TRCell():New(oRelat3,"D2_ESPECIE"	,/*Tabela*/,RetTitle("D2_ESPECIE"	),PesqPict("SD2","D2_ESPECIE"	),TamSX3("D2_ESPECIE"	)[1],/*lPixel*/,{|| cEspecie	})
TRCell():New(oRelat3,"D2_ITEM"		,/*Tabela*/,Substr(RetTitle("D2_ITEM"),1,2),PesqPict("SD2","D2_ITEM"		),TamSX3("D2_ITEM"		)[1],/*lPixel*/,{|| cItem 		})
TRCell():New(oRelat3,"D2_COD"		,/*Tabela*/,RetTitle("D2_COD"		),PesqPict("SD2","D2_COD"		),TamSX3("D2_COD"		)[1],/*lPixel*/,{|| cCod 		})
TRCell():New(oRelat3,"D2_UM"		,/*Tabela*/,RetTitle("D2_UM"		),PesqPict("SD2","D2_UM"		),TamSX3("D2_UM"		)[1],/*lPixel*/,{|| cUM 		})
TRCell():New(oRelat3,"D2_GRUPO"		,/*Tabela*/,RetTitle("D2_GRUPO"		),PesqPict("SD2","D2_GRUPO"		),TamSX3("D2_GRUPO"		)[1],/*lPixel*/,{|| cGrupo 		})
TRCell():New(oRelat3,"D2_QUANT"		,/*Tabela*/,RetTitle("D2_QUANT"		),PesqPict("SD2","D2_QUANT"		),TamSX3("D2_QUANT"		)[1],/*lPixel*/,{|| nQuant 		},,,"RIGHT")
TRCell():New(oRelat3,"D2_TOTAL"		,/*Tabela*/,RetTitle("D2_TOTAL"		),PesqPict("SD2","D2_TOTAL"		),TamSX3("D2_TOTAL"		)[1],/*lPixel*/,{|| nTotal 		},,,"RIGHT")
// Informacoes do Remito
If cPaisLoc == "VEN"
	TRCell():New(oRelat3,"DOC"			,"SD2",STR0024					 ,PesqPict("SD2","D2_DOC"		),TamSX3("D2_DOC"		)[1],/*lPixel*/,{|| SD2->D2_DOC 		},,,,,,.T.)//Fatura
Else
	TRCell():New(oRelat3,"DOC"			,"SD2",cRetTitle				 ,PesqPict("SD2","D2_DOC"		),TamSX3("D2_DOC"		)[1],/*lPixel*/,{|| SD2->D2_DOC 		},,,,,,.T.)//Remito
EndIf
TRCell():New(oRelat3,"ITEM"			,"SD2",Substr(RetTitle("D2_ITEM"),1,2),PesqPict("SD2","D2_ITEM"		),TamSX3("D2_ITEM"		)[1],/*lPixel*/,{|| SD2->D2_ITEM 		})
TRCell():New(oRelat3,"EMISSAO"		,"SD2",RetTitle("D2_EMISSAO"	),PesqPict("SD2","D2_EMISSAO"	),nTamData					,/*lPixel*/,{|| SD2->D2_EMISSAO	})
TRCell():New(oRelat3,"QUANT"		,"SD2",RetTitle("D2_QUANT"		),PesqPict("SD2","D2_QUANT"		),TamSX3("D2_QUANT"		)[1],/*lPixel*/,{|| SD2->D2_QUANT 		},,,"RIGHT")

// Dados do Pedido de Vendas
TRCell():New(oRelat3,"C6_NUM"		,"SC6",RetTitle("C6_NUM"		),PesqPict("SC6","C6_NUM"		),TamSX3("C6_NUM"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat3,"C6_ITEM"		,"SC6",Substr(RetTitle("C6_ITEM"),1,2),PesqPict("SC6","C6_ITEM"		),TamSX3("C6_ITEM"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat3,"C5_EMISSAO"	,"SC5",RetTitle("C5_EMISSAO"	),PesqPict("SC5","C5_EMISSAO"	),nTamData					,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRelat3,"C6_QTDVEN"	,"SC6",RetTitle("C6_QTDVEN"		),PesqPict("SC6","C6_QTDVEN"	),TamSX3("C6_QTDVEN"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oRelat3,"C6_VALOR"		,"SC6",RetTitle("C6_VALOR"		),PesqPict("SC6","C6_VALOR"		),TamSX3("C6_VALOR"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oRelat3,"C6_ENTREG"	,"SC6",RetTitle("C6_ENTREG"		),PesqPict("SC6","C6_ENTREG"	),nTamData					,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³20/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,oRelat1,oRelat2,oRelat3,cAliasQry)

If mv_par01 = 1        // PV/RM/FT
	ImpPRF(oReport,oRelat1,cAliasQry)
ElseIf mv_PAR01 = 2    // RM/PV/FT
  	ImpRPF(oReport,oRelat2,cAliasQry)
Else				    // FT/RM/PV
	ImpFRP(oReport,oRelat3,cAliasQry)
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ImpPRF   ³ Autor ³ Marco Bianchi         ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao por Pedido/Remito/Fatura		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR681 - R4                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpPRF(oReport,oRelat1,cAliasQry)

Local cChPed	:= ""
Local lImpr		:= .T.
Local cChFat	:= ""
Local cWhere	:= ""	
Local dEmiss	:= CTOD("  /  /  ")
Local cPedido	:= ""
Local cCli  	:= ""
Local cLojaCli	:= ""
Local cOrder	:= ""

Local cDoc		:= ""
Local cItem		:= ""
Local dEmissao	:= CTOD("  /  /  ")
Local nQuant	:= 0

oReport:Section(1):Cell("DOC" 		):SetBlock({|| cDoc		})
oReport:Section(1):Cell("ITEM" 		):SetBlock({|| cItem	})
oReport:Section(1):Cell("EMISSAO"	):SetBlock({|| dEmissao	})
oReport:Section(1):Cell("QUANT" 	):SetBlock({|| nQuant	})
cDoc	:= ""
cItem	:= ""
dEmissao:= ctod("  /  /  ")
nQuant	:= 0

oReport:Section(2):disable()
oReport:Section(3):disable()
                                                                                                                        
If oReport:Section(1):GetOrder() == 1		// Ordem: por Emissao
	oReport:Section(1):Cell("C5_EMISSAOC"):Disable()
	oReport:Section(1):Cell("C5_CLIENTEC"):Disable()
	oReport:Section(1):Cell("C5_LOJACLIC"):Disable()
Else										// Ordem: por Cliente
	oReport:Section(1):Cell("C5_EMISSAOE"):Disable()
	oReport:Section(1):Cell("C5_CLIENTEE"):Disable()
	oReport:Section(1):Cell("C5_LOJACLIE"):Disable()
EndIf

oReport:SetTitle(STR0013 + STR0015 + "/" + cRetTitle + "/" + STR0024) //"Relacao de pedidos de venda/remisiones/faturas

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
	
dbSelectArea("SC5")
If oReport:Section(1):GetOrder() == 1		// Ordem: por Emissao
	dbSetOrder(2) //C5_FILIAL+DTOS(C5_EMISSAO)+C5_NUM
	cOrder := "%C5_EMISSAO,C5_CLIENTE,C5_LOJACLI,C5_NUM%"
Else										// Ordem: por Cliente
	dbSetOrder(3) //C5_FILIAL+C5_CLIENTE+C5_LOJACLI+C5_NUM
	cOrder := "%C5_CLIENTE,C5_LOJACLI,C5_EMISSAO,C5_NUM%"
EndIf	

cWhere := "%"
If !Empty(mv_par02)
	cWhere +=" AND C5_CLIENTE >= '" + %Exp:mv_par02% + "'"
Endif
If !Empty(mv_par03)
	cWhere+=" AND C5_CLIENTE <='" + %Exp:mv_par03% + "'"
Endif
If !Empty(mv_par08)
    cWhere+=" AND C5_EMISSAO >= '" + %Exp:DTOS(mv_par08)% + "'"
Endif
If !Empty(mv_par09)
	cWhere+=" AND C5_EMISSAO <= '" + %Exp:DTOS(mv_par09)% + "'"
Endif        
cWhere += "%"

oReport:Section(1):BeginQuery()	
BeginSql Alias cAliasQry
	SELECT C5_FILIAL,C5_NUM,C5_EMISSAO,C5_CLIENTE,C5_LOJACLI
	FROM %Table:SC5% SC5
	WHERE C5_FILIAL = %xFilial:SC5% AND SC5.%notdel%
	%Exp:cWhere%
	ORDER BY %Exp:cOrder%
EndSql
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)	

SC6->(DbSetOrder(1)) //C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
dbSelectArea(cAliasQry)
dbGoTop()
oReport:Section(1):Init()
oReport:SetMeter((cAliasQry)->(LastRec()))       
                       
dEmiss		:= CTOD("  /  /  ")
cCli 		:= ""
cLojaCli	:= ""
While !oReport:Cancel() .And. !(cAliasQry)->(Eof())
	
	DbSelectArea("SC6")
	cChPed:=xFilial("SC6")+(cAliasQry)->C5_NUM
	
	// Pesquisa SC6: Itens do Pedido de Vendas
	If DbSeek(cChPed)
		lImpr   := .T.
		cPedido := ""
		
		While !Eof() .and. C6_FILIAL+C6_NUM==cChPed
			If(lImpr:=(SC6->C6_PRODUTO>=mv_par04))
				If !Empty(mv_par05)
					lImpr:=(SC6->C6_PRODUTO<=mv_par05)
				Endif
			Endif
			If lImpr
				If !Empty(mv_par06) .Or. !Empty(mv_par07)
					If (SB1->(MsSeek(xFilial("SB1")+SC6->C6_PRODUTO)))
						If (lImpr:=SB1->B1_GRUPO>=mv_par06)
							If !Empty(mv_par07)
								lImpr:=SB1->B1_GRUPO<=mv_par07
							Endif
						Endif
					Endif
				Endif
			Endif
			If lImpr
				cChRem:=xFilial("SD2")+SC6->C6_NUM+SC6->C6_ITEM
				// Pesquisa Remito (SD2) a partir do Pedido de Vendas
				DbSelectArea("SD2")		// Itens da Nota de Saida
				dbSetOrder(8) //D2_FILIAL+D2_PEDIDO+D2_ITEMPV
				
				If DbSeek(cChRem)
					While !Eof() .and. D2_FILIAL+D2_PEDIDO+D2_ITEMPV==cChRem  //impressao das remisiones
						If D2_ITEMPV==SC6->C6_ITEM  .and. IsRemito(1,"SD2->D2_TIPODOC") .and. D2_COD==SC6->C6_PRODUTO
							
							cChFat		:= xFilial("SD2")+SD2->D2_CLIENTE+SD2->D2_LOJA+SD2->D2_SERIE+SD2->D2_DOC+SD2->D2_ITEM
							nReg 		:= Recno()
							cDoc 		:= ""
							cItem 		:= ""
							dEmissao 	:= CTOD("  /  /  ")
							nQuant		:= 0
							cDoc 		:= D2_DOC
							cItem 		:= D2_ITEM
							dEmissao 	:= D2_EMISSAO
							nQuant		:= D2_QUANT
							
							// Pesquisa Fatura (SD2) a partir do Remito (SD2)
							DbSelectArea("SD2")			// Itens da Nota de Saida
							DbSetOrder(9) //D2_FILIAL+D2_CLIENTE+D2_LOJA+D2_SERIREM+D2_REMITO+D2_ITEMREM
							If DbSeek(cChFat)
								
								// Informacoes do Pedido
								If oReport:Section(1):GetOrder() == 1			// Ordem: por Emissao
									If dEmiss <> (cAliasQry)->C5_EMISSAO
										oReport:Section(1):Cell("C5_EMISSAOE"	):Show()
									Else
										oReport:Section(1):Cell("C5_EMISSAOE"	):Hide()
									EndIf
									If  cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI;
										.And. cPedido == SC6->C6_NUM
										oReport:Section(1):Cell("C5_CLIENTEE"	):Hide()
										oReport:Section(1):Cell("C5_LOJACLIE"	):Hide()
										oReport:Section(1):Cell("C6_NUM"		):Hide()
									Else
										oReport:Section(1):Cell("C5_CLIENTEE"	):Show()
										oReport:Section(1):Cell("C5_LOJACLIE"	):Show()
										oReport:Section(1):Cell("C6_NUM"		):Show()
									EndIf
								Else        									// Ordem: por Cliente
									If cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI
										oReport:Section(1):Cell("C5_CLIENTEC"	):Hide()
										oReport:Section(1):Cell("C5_LOJACLIC"	):Hide()
									Else
										oReport:Section(1):Cell("C5_CLIENTEC"	):Show()
										oReport:Section(1):Cell("C5_LOJACLIC"	):Show()
									EndIf
									If dEmiss == (cAliasQry)->C5_EMISSAO .And. cPedido == SC6->C6_NUM
										oReport:Section(1):Cell("C6_NUM"		):Hide()
										oReport:Section(1):Cell("C5_EMISSAOC"	):Hide()
									Else
										oReport:Section(1):Cell("C6_NUM"		):Show()
										oReport:Section(1):Cell("C5_EMISSAOC"	):Show()
									EndIf
								EndIf
								
								oReport:Section(1):Cell("C6_ITEM"		):Show()
								oReport:Section(1):Cell("C6_PRODUTO"	):Show()
								oReport:Section(1):Cell("C6_UM"	   		):Show()
								oReport:Section(1):Cell("B1_GRUPO"		):Show()
								oReport:Section(1):Cell("C6_QTDVEN"		):Show()
								oReport:Section(1):Cell("C6_VALOR"		):Show()
								oReport:Section(1):Cell("C6_ENTREG"		):Show()
								// Informacoes do remito
								oReport:Section(1):Cell("DOC" 			):Show()
								oReport:Section(1):Cell("ITEM"			):Show()
								oReport:Section(1):Cell("EMISSAO"		):Show()
								oReport:Section(1):Cell("QUANT"			):Show()
								// Informacoes da Fatura
								oReport:Section(1):Cell(SerieNfId("SD2",3,"D2_SERIE")):Show()
								oReport:Section(1):Cell("D2_DOC"		):Show()
								oReport:Section(1):Cell("D2_ITEM"		):Show()
								oReport:Section(1):Cell("D2_EMISSAO"	):Show()
								oReport:Section(1):Cell("D2_QUANT"		):Show()
								oReport:Section(1):Cell("D2_TOTAL"		):Show()
								
								lFirst := .T.
								While !Eof() .and. (D2_FILIAL+D2_CLIENTE+D2_LOJA+D2_SERIREM+D2_REMITO+D2_ITEMREM)==cChFat
									If !IsRemito(1,"SD2->D2_TIPODOC")
										
										// Imprime Pedido/Remite/Fatura
										If !lFirst
										
											// Informacoes do Pedido
											If oReport:Section(1):GetOrder() == 1			// Ordem: por Emissao
											
												If dEmiss <> (cAliasQry)->C5_EMISSAO
													oReport:Section(1):Cell("C5_EMISSAOE"	):Show()
												Else
													oReport:Section(1):Cell("C5_EMISSAOE"	):Hide()
												EndIf
												If  cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI;
													.And. cPedido == SC6->C6_NUM
													oReport:Section(1):Cell("C5_CLIENTEE"	):Hide()
													oReport:Section(1):Cell("C5_LOJACLIE"	):Hide()
													oReport:Section(1):Cell("C6_NUM"		):Hide()
												Else
													oReport:Section(1):Cell("C5_CLIENTEE"	):Show()
													oReport:Section(1):Cell("C5_LOJACLIE"	):Show()
													oReport:Section(1):Cell("C6_NUM"		):Show()
												EndIf
											Else											// Ordem: por Cliente
												If cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI
													oReport:Section(1):Cell("C5_CLIENTEC"	):Hide()
													oReport:Section(1):Cell("C5_LOJACLIC"	):Hide()
												Else
													oReport:Section(1):Cell("C5_CLIENTEC"	):Show()
													oReport:Section(1):Cell("C5_LOJACLIC"	):Show()
												EndIf
												If dEmiss == (cAliasQry)->C5_EMISSAO .And. cPedido == SC6->C6_NUM
													oReport:Section(1):Cell("C6_NUM"		):Hide()
													oReport:Section(1):Cell("C5_EMISSAOC"	):Hide()
												Else
													oReport:Section(1):Cell("C6_NUM"		):Show()
													oReport:Section(1):Cell("C5_EMISSAOC"	):Show()
												EndIf
											EndIf
											
											// Informacoes do Pedido
											oReport:Section(1):Cell("C6_ITEM"		):Hide()
											oReport:Section(1):Cell("C6_PRODUTO"	):Hide()
											oReport:Section(1):Cell("C6_UM"	   		):Hide()
											oReport:Section(1):Cell("B1_GRUPO"		):Hide()
											oReport:Section(1):Cell("C6_QTDVEN"		):Hide()
											oReport:Section(1):Cell("C6_VALOR"		):Hide()
											oReport:Section(1):Cell("C6_ENTREG"		):Hide()
											// Informacoes do remito
											oReport:Section(1):Cell("DOC" 			):Hide()
											oReport:Section(1):Cell("ITEM"			):Hide()
											oReport:Section(1):Cell("EMISSAO"		):Hide()
											oReport:Section(1):Cell("QUANT"			):Hide()
										EndIf
										
										oReport:Section(1):PrintLine()
										lFirst := .F.
										
									Endif
									DbSkip()
								Enddo
							Else
								// Imprime Pedido e Remite (Fatura nao encontrada a partir do Remito)
								If oReport:Section(1):GetOrder() == 1			// Ordem: por Emissao
									// Informacoes do Pedido
									If dEmiss <> (cAliasQry)->C5_EMISSAO
										oReport:Section(1):Cell("C5_EMISSAOE"	):Show()
									Else
										oReport:Section(1):Cell("C5_EMISSAOE"	):Hide()
									EndIf
									
									If  cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI;
										.And. cPedido == SC6->C6_NUM
										oReport:Section(1):Cell("C5_CLIENTEE"	):Hide()
										oReport:Section(1):Cell("C5_LOJACLIE"	):Hide()
										oReport:Section(1):Cell("C6_NUM"		):Hide()
									Else
										oReport:Section(1):Cell("C5_CLIENTEE"	):Show()
										oReport:Section(1):Cell("C5_LOJACLIE"	):Show()
										oReport:Section(1):Cell("C6_NUM"		):Show()
									EndIf
								Else        									// Ordem: por Cliente
									If cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI
										oReport:Section(1):Cell("C5_CLIENTEC"	):Hide()
										oReport:Section(1):Cell("C5_LOJACLIC"	):Hide()
									Else
										oReport:Section(1):Cell("C5_CLIENTEC"	):Show()
										oReport:Section(1):Cell("C5_LOJACLIC"	):Show()
									EndIf
									If dEmiss == (cAliasQry)->C5_EMISSAO .And. cPedido == SC6->C6_NUM
										oReport:Section(1):Cell("C6_NUM"		):Hide()
										oReport:Section(1):Cell("C5_EMISSAOC"	):Hide()
									Else
										oReport:Section(1):Cell("C6_NUM"		):Show()
										oReport:Section(1):Cell("C5_EMISSAOC"	):Show()
									EndIf
								EndIf
								
								oReport:Section(1):Cell("C6_ITEM"	 	):Show()
								oReport:Section(1):Cell("C6_PRODUTO"	):Show()
								oReport:Section(1):Cell("C6_UM"	   		):Show()
								oReport:Section(1):Cell("B1_GRUPO"		):Show()
								oReport:Section(1):Cell("C6_QTDVEN"		):Show()
								oReport:Section(1):Cell("C6_VALOR"		):Show()
								oReport:Section(1):Cell("C6_ENTREG"		):Show()
								// Informacoes do remito
								oReport:Section(1):Cell("DOC"			):Show()
								oReport:Section(1):Cell("ITEM"			):Show()
								oReport:Section(1):Cell("EMISSAO"		):Show()
								oReport:Section(1):Cell("QUANT"			):Show()
								// Informacoes da Fatura
								oReport:Section(1):Cell(SerieNfId("SD2",3,"D2_SERIE")):Hide()
								oReport:Section(1):Cell("D2_DOC"		):Hide()
								oReport:Section(1):Cell("D2_ITEM"		):Hide()
								oReport:Section(1):Cell("D2_EMISSAO"	):Hide()
								oReport:Section(1):Cell("D2_QUANT"		):Hide()
								oReport:Section(1):Cell("D2_TOTAL"		):Hide()
								
								oReport:Section(1):PrintLine()
							Endif
							DbSelectArea("SD2")
							DbGoTo(nReg)
							DbSetOrder(8) //D2_FILIAL+D2_PEDIDO+D2_ITEMPV 
						Endif
						DbSkip()
					Enddo
				Else
					// Imprime Pedido
					// Informacoes do Pedido
					If oReport:Section(1):GetOrder() == 1			// Ordem: por Emissao
						If dEmiss <> (cAliasQry)->C5_EMISSAO
							oReport:Section(1):Cell("C5_EMISSAOE"	):Show()
						Else
							oReport:Section(1):Cell("C5_EMISSAOE"	):Hide()
						EndIf
						
						If  cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI;
							.And. cPedido == SC6->C6_NUM
							oReport:Section(1):Cell("C5_CLIENTEE"	):Hide()
							oReport:Section(1):Cell("C5_LOJACLIE"	):Hide()
							oReport:Section(1):Cell("C6_NUM"		):Hide()
						Else
							oReport:Section(1):Cell("C5_CLIENTEE"	):Show()
							oReport:Section(1):Cell("C5_LOJACLIE"	):Show()
							oReport:Section(1):Cell("C6_NUM"		):Show()
						EndIf
					Else
						If cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI
							oReport:Section(1):Cell("C5_CLIENTEC"	):Hide()
							oReport:Section(1):Cell("C5_LOJACLIC"	):Hide()
						Else
							oReport:Section(1):Cell("C5_CLIENTEC"	):Show()
							oReport:Section(1):Cell("C5_LOJACLIC"	):Show()
						EndIf
						If dEmiss == (cAliasQry)->C5_EMISSAO .And. cPedido == SC6->C6_NUM
							oReport:Section(1):Cell("C6_NUM"		):Hide()
							oReport:Section(1):Cell("C5_EMISSAOC"	):Hide()
						Else
							oReport:Section(1):Cell("C6_NUM"		):Show()
							oReport:Section(1):Cell("C5_EMISSAOC"	):Show()
						EndIf
					EndIf
					
					oReport:Section(1):Cell("C6_ITEM"		):Show()
					oReport:Section(1):Cell("C6_PRODUTO"	):Show()
					oReport:Section(1):Cell("C6_UM"	   		):Show()
					oReport:Section(1):Cell("B1_GRUPO"		):Show()
					oReport:Section(1):Cell("C6_QTDVEN"		):Show()
					oReport:Section(1):Cell("C6_VALOR"		):Show()
					oReport:Section(1):Cell("C6_ENTREG"		):Show()
					// Informacoes do remito
					oReport:Section(1):Cell("DOC"			):Hide()
					oReport:Section(1):Cell("ITEM"			):Hide()
					oReport:Section(1):Cell("EMISSAO"		):Hide()
					oReport:Section(1):Cell("QUANT"			):Hide()
					// Informacoes da Fatura
					oReport:Section(1):Cell(SerieNfId("SD2",3,"D2_SERIE")):Hide()
					oReport:Section(1):Cell("D2_DOC"		):Hide()
					oReport:Section(1):Cell("D2_ITEM"		):Hide()
					oReport:Section(1):Cell("D2_EMISSAO"	):Hide()
					oReport:Section(1):Cell("D2_QUANT"		):Hide()
					oReport:Section(1):Cell("D2_TOTAL"		):Hide()
					
					oReport:Section(1):PrintLine()
				Endif
				
				// Pesquisa Fatura (SD2) a partir do Pedido de Vendas
				cChFat:=xFilial("SD2")+SC6->C6_NUM+SC6->C6_ITEM
				DbSelectArea("SD2")
				dbSetOrder(8) //D2_FILIAL+D2_PEDIDO+D2_ITEMPV 
				If DbSeek(cChFat)
					// Informacoes do Pedido
					If oReport:Section(1):GetOrder() == 1			// Ordem: por Emissao
						If dEmiss <> (cAliasQry)->C5_EMISSAO
							oReport:Section(1):Cell("C5_EMISSAOE"	):Show()
						Else
							oReport:Section(1):Cell("C5_EMISSAOE"	):Hide()
						EndIf
						If  cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI;
							.And. cPedido == SC6->C6_NUM
							oReport:Section(1):Cell("C5_CLIENTEE"	):Hide()
							oReport:Section(1):Cell("C5_LOJACLIE"	):Hide()
							oReport:Section(1):Cell("C6_NUM"		):Hide()
						Else
							oReport:Section(1):Cell("C5_CLIENTEE"	):Show()
							oReport:Section(1):Cell("C5_LOJACLIE"	):Show()
							oReport:Section(1):Cell("C6_NUM"		):Show()
						EndIf
					Else
						If cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI
							oReport:Section(1):Cell("C5_CLIENTEC"	):Hide()
							oReport:Section(1):Cell("C5_LOJACLIC"	):Hide()
						Else
							oReport:Section(1):Cell("C5_CLIENTEC"	):Show()
							oReport:Section(1):Cell("C5_LOJACLIC"	):Show()
						EndIf
						If dEmiss == (cAliasQry)->C5_EMISSAO .And. cPedido == SC6->C6_NUM
							oReport:Section(1):Cell("C6_NUM"		):Hide()
							oReport:Section(1):Cell("C5_EMISSAOC"	):Hide()
						Else
							oReport:Section(1):Cell("C6_NUM"		):Show()
							oReport:Section(1):Cell("C5_EMISSAOC"	):Show()
						EndIf
					EndIf
					
					oReport:Section(1):Cell("C6_ITEM"		):Show()
					oReport:Section(1):Cell("C6_PRODUTO"	):Show()
					oReport:Section(1):Cell("C6_UM"	   		):Show()
					oReport:Section(1):Cell("B1_GRUPO"		):Show()
					oReport:Section(1):Cell("C6_QTDVEN"		):Show()
					oReport:Section(1):Cell("C6_VALOR"		):Show()
					oReport:Section(1):Cell("C6_ENTREG"		):Show()
					// Informacoes do remito
					oReport:Section(1):Cell("DOC"			):Hide()
					oReport:Section(1):Cell("ITEM"			):Hide()
					oReport:Section(1):Cell("EMISSAO"		):Hide()
					oReport:Section(1):Cell("QUANT"			):Hide()
					// Informacoes da Fatura
					oReport:Section(1):Cell(SerieNfId("SD2",3,"D2_SERIE")):Show()
					oReport:Section(1):Cell("D2_DOC"		):Show()
					oReport:Section(1):Cell("D2_ITEM"		):Show()
					oReport:Section(1):Cell("D2_EMISSAO"	):Show()
					oReport:Section(1):Cell("D2_QUANT"		):Show()
					oReport:Section(1):Cell("D2_TOTAL"		):Show()
					
					lFirst := .T.
					While !Eof() .and. D2_FILIAL+D2_PEDIDO+D2_ITEMPV==cChFat
						If Empty(D2_REMITO) .AND. !IsRemito(1,"SD2->D2_TIPODOC") .and. D2_COD == SC6->C6_PRODUTO
							If !lFirst
								// Informacoes do Pedido
								If oReport:Section(1):GetOrder() == 1			// Ordem: por Emissao
									If dEmiss <> (cAliasQry)->C5_EMISSAO
										oReport:Section(1):Cell("C5_EMISSAOE"	):Show()
									Else
										oReport:Section(1):Cell("C5_EMISSAOE"	):Hide()
									EndIf
									
									If  cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI;
										.And. cPedido == SC6->C6_NUM
										oReport:Section(1):Cell("C5_CLIENTEE"	):Hide()
										oReport:Section(1):Cell("C5_LOJACLIE"	):Hide()
										oReport:Section(1):Cell("C6_NUM"		):Hide()
									Else
										oReport:Section(1):Cell("C5_CLIENTEE"	):Show()
										oReport:Section(1):Cell("C5_LOJACLIE"	):Show()
										oReport:Section(1):Cell("C6_NUM"		):Show()
									EndIf
								Else        									// Ordem: por Cliente
									If cCli == (cAliasQry)->C5_CLIENTE .And. cLojaCli == (cAliasQry)->C5_LOJACLI
										oReport:Section(1):Cell("C5_CLIENTEC"	):Hide()
										oReport:Section(1):Cell("C5_LOJACLIC"	):Hide()
									Else
										oReport:Section(1):Cell("C5_CLIENTEC"	):Show()
										oReport:Section(1):Cell("C5_LOJACLIC"	):Show()
									EndIf
									If dEmiss == (cAliasQry)->C5_EMISSAO .And. cPedido == SC6->C6_NUM
										oReport:Section(1):Cell("C6_NUM"		):Hide()
										oReport:Section(1):Cell("C5_EMISSAOC"	):Hide()
									Else
										oReport:Section(1):Cell("C6_NUM"		):Show()
										oReport:Section(1):Cell("C5_EMISSAOC"	):Show()
									EndIf
								EndIf
								oReport:Section(1):Cell("C6_ITEM"		):Hide()
								oReport:Section(1):Cell("C6_PRODUTO"	):Hide()
								oReport:Section(1):Cell("C6_UM"	   		):Hide()
								oReport:Section(1):Cell("B1_GRUPO"		):Hide()
								oReport:Section(1):Cell("C6_QTDVEN"		):Hide()
								oReport:Section(1):Cell("C6_VALOR"		):Hide()
								oReport:Section(1):Cell("C6_ENTREG"		):Hide()
							EndIf
							oReport:Section(1):PrintLine()
							lFirst := .F.
						Endif
						DbSkip()
					Enddo
					DbSelectArea("SC6")
				Endif
			Endif
			cCli 	:= SC6->C6_CLI
			cLojaCli:= SC6->C6_LOJA
			cPedido := SC6->C6_NUM
			dEmiss 	:= (cAliasQry)->C5_EMISSAO
			DbselectArea("SC6")
			DbSkip()
		Enddo
		
	Endif
	cCli 	:= (cAliasQry)->C5_CLIENTE
	cPedido	:= (cAliasQry)->C5_NUM
	dEmiss	:= (cAliasQry)->C5_EMISSAO
	dbSelectArea(cAliasQry)
	oReport:IncMeter()
	DbSkip()
EndDo

oReport:Section(1):Finish()
oReport:Section(1):SetPageBreak(.T.)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ImpRPF   ³ Autor ³ Marco Bianchi         ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao por Remito/Pedido/Fatura		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR681 - R4                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpRPF(oReport,oRelat2,cAliasQry)

Local cChPed	:= ""
Local cWhere	:= ""	
Local dEmiss	:= CTOD("  /  /  ")
Local cCli		:= ""
Local cLojaCli	:= ""
Local cOrder	:= ""
Local cCliente	:= ""
Local cLoja		:= ""
Local dEmissao	:= CTOD("  /  /  ")
Local cDoc 		:= ""
Local cItem		:= ""
Local cCod 		:= ""
Local cUM 		:= ""
Local cGrupo	:= ""
Local nQuant	:= 0
Local cSelect	:= ""

MakeSqlExpr(oReport:uParam)

oReport:SetTitle(STR0013 + cRetTitle + "/" +  STR0015 + "/" + STR0024) //"Relacao de remisiones/pedidos de venda/faturas

oReport:Section(2):Cell("D2_EMISSAOE"	):SetBlock({|| dEmissao	})
oReport:Section(2):Cell("D2_CLIENTEE"	):SetBlock({|| cCliente	})
oReport:Section(2):Cell("D2_LOJAE"		):SetBlock({|| cLoja	})
oReport:Section(2):Cell("D2_CLIENTEC"	):SetBlock({|| cCliente	})
oReport:Section(2):Cell("D2_LOJAC"	  	):SetBlock({|| cLoja	})
oReport:Section(2):Cell("D2_EMISSAOC"	):SetBlock({|| dEmissao	})
oReport:Section(2):Cell("D2_DOC"	 	):SetBlock({|| cDoc		})
oReport:Section(2):Cell("D2_ITEM" 		):SetBlock({|| cItem	})
oReport:Section(2):Cell("D2_COD"		):SetBlock({|| cCod		})
oReport:Section(2):Cell("D2_UM"			):SetBlock({|| cUM		})
oReport:Section(2):Cell("D2_GRUPO"		):SetBlock({|| cGrupo	})
oReport:Section(2):Cell("D2_QUANT"		):SetBlock({|| nQuant	})

cDoc	:= ""
cItem	:= ""
dEmissao:= ctod("  /  /  ")
nQuant  := 0
cCliente:= ""
cLoja	:= ""
cCod 	:= ""
cUM 	:= ""
cGrupo  := ""

If oReport:Section(1):GetOrder() == 1		// Ordem: por Emissao
	oReport:Section(2):Cell("D2_EMISSAOC"):Disable()
	oReport:Section(2):Cell("D2_CLIENTEC"):Disable()
	oReport:Section(2):Cell("D2_LOJAC"):Disable()
Else										// Ordem: por Cliente
	oReport:Section(2):Cell("D2_EMISSAOE"):Disable()
	oReport:Section(2):Cell("D2_CLIENTEE"):Disable()
	oReport:Section(2):Cell("D2_LOJAE"):Disable()
EndIf

oReport:Section(1):disable()
oReport:Section(3):disable()

dbSelectArea("SD2")
If oReport:Section(1):GetOrder() == 1		// Ordem: por Emissao
	dbSetOrder(5) //D2_FILIAL+DTOS(D2_EMISSAO)+D2_NUMSEQ
	cOrder := "%D2_EMISSAO,D2_CLIENTE,D2_LOJA,D2_DOC%"
Else										// Ordem: por Cliente
	dbSetOrder(9) //D2_FILIAL+D2_CLIENTE+D2_LOJA+D2_SERIREM+D2_REMITO+D2_ITEMREM 
	cOrder := "%D2_CLIENTE,D2_LOJA,D2_EMISSAO,D2_DOC%"
EndIf	

cWhere := "%"
If !Empty(mv_par02)
	cWhere+=" AND D2_CLIENTE  >= '" + %Exp:mv_par02% + "'"
Endif
If !Empty(mv_par03)
	cWhere+=" AND D2_CLIENTE <= '" + %Exp:mv_par03% + "'"
Endif
If !Empty(mv_par04)
	cWhere+=" AND D2_COD >= '" + %Exp:mv_par04% + "'"
Endif
If !Empty(mv_par05)
	cWhere+=" AND D2_COD <= '" + %Exp:mv_par05% + "'"
Endif
If !Empty(mv_par06)
	cWhere+=" AND D2_GRUPO >= '" + %Exp:mv_par06% + "'"
Endif
If !Empty(mv_par07)
	cWhere+=" AND D2_GRUPO <= '" + %Exp:mv_par07% + "'"
Endif
If !Empty(mv_par08)
    cWhere+=" AND D2_EMISSAO >= '" + %Exp:DTOS(mv_par08)% + "'"
Endif
If !Empty(mv_par09)
	cWhere+=" AND D2_EMISSAO <= '" + %Exp:DTOS(mv_par09)% + "'"
Endif
cWhere+=" AND ("+IsRemito(3,'D2_TIPODOC')+ ")"
cWhere += "%"

cSelect:= "%D2_FILIAL,"+ IIF(SerieNfId("SD2",3,"D2_SERIE")<>"D2_SERIE",SerieNfId("SD2",3,"D2_SERIE")+","," ")
cSelect+= "D2_SERIE,D2_DOC,D2_ITEM,D2_EMISSAO,D2_QUANT,D2_TOTAL,D2_ESPECIE,D2_COD,D2_UM,D2_GRUPO,D2_REMITO,D2_ITEMREM, "
cSelect+= IIF(SerieNfId("SD2",3,"D2_SERIREM")<>"D2_SERIREM",SerieNfId("SD2",3,"D2_SERIREM")+","," ")+" D2_SERIREM,D2_PEDIDO,D2_ITEMPV, "
cSelect+= "D2_CLIENTE,D2_LOJA,R_E_C_N_O_ RECNO%"

oReport:Section(2):BeginQuery()	
BeginSql Alias cAliasQry
	SELECT %Exp:cSelect%
	FROM %Table:SD2% SD2
	WHERE D2_FILIAL = %xFilial:SD2% AND SD2.%notdel%
	%Exp:cWhere%
	ORDER BY %Exp:cOrder%
EndSql       
oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)

SC6->(DbSetOrder(1)) //C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
SC5->(DbSetOrder(1)) //C5_FILIAL+C5_NUM

dbSelectArea(cAliasQry)
dbGoTop()
oReport:Section(2):Init()
oReport:SetMeter((cAliasQry)->(LastRec()))

dEmiss   	:= CTOD("  /  /  ")
cCli 		:= ""
cLojaCli    := ""
cChave		:= ""
While !oReport:Cancel() .And. !(cAliasQry)->(Eof())
	
	If oReport:Section(1):GetOrder() == 1							// Ordem: por Emissao
		If dEmiss <> (cAliasQry)->D2_EMISSAO
			oReport:Section(2):Cell("D2_EMISSAOE"	):Show()
		Else
			oReport:Section(2):Cell("D2_EMISSAOE"	):Hide()
		EndIf
		If cChave <> (cAliasQry)->D2_CLIENTE+(cAliasQry)->D2_DOC
			oReport:Section(2):Cell("D2_CLIENTEE"	):Show()
			oReport:Section(2):Cell("D2_LOJAE"		):Show()
			oReport:Section(2):Cell("D2_DOC"		):Show()
		Else
			oReport:Section(2):Cell("D2_CLIENTEE"	):Hide()
			oReport:Section(2):Cell("D2_LOJAE"		):Hide()
			oReport:Section(2):Cell("D2_DOC"		):Hide()
		EndIf
	Else 															// Ordem: por Cliente
		If cCli <> (cAliasQry)->D2_CLIENTE .Or. cLojaCli <> (cAliasQry)->D2_LOJA
			oReport:Section(2):Cell("D2_CLIENTEC"	):Show()
			oReport:Section(2):Cell("D2_LOJAC"		):Show()
		Else
			oReport:Section(2):Cell("D2_CLIENTEC"	):Hide()
			oReport:Section(2):Cell("D2_LOJAC"		):Hide()
		EndIf
		If cChave <> DTOS((cAliasQry)->D2_EMISSAO)+(cAliasQry)->D2_DOC
			oReport:Section(2):Cell("D2_EMISSAOC"	):Show()
			oReport:Section(2):Cell("D2_DOC"		):Show()
		Else
			oReport:Section(2):Cell("D2_EMISSAOC"	):Hide()
			oReport:Section(2):Cell("D2_DOC"		):Hide()
		EndIf
	EndIf
	
	oReport:Section(2):Cell("D2_ITEM"		):Show()
	oReport:Section(2):Cell("D2_COD"		):Show()
	oReport:Section(2):Cell("D2_UM"			):Show()
	oReport:Section(2):Cell("D2_GRUPO"		):Show()
	oReport:Section(2):Cell("D2_QUANT"		):Show()
	// Dados do Pedido de Vendas
	oReport:Section(2):Cell("C6_NUM"		):Show()
	oReport:Section(2):Cell("C6_ITEM"		):Show()
	oreport:Section(2):Cell("C5_EMISSAO"	):Show()
	oReport:Section(2):Cell("C6_QTDVEN"		):Show()
	oReport:Section(2):Cell("C6_VALOR"		):Show()
	oReport:Section(2):Cell("C6_ENTREG"		):Show()
	// Informacoes da Fatura
	oReport:Section(2):Cell("SERIE"			):Show()
	oReport:Section(2):Cell("DOC"			):Show()
	oReport:Section(2):Cell("ITEM"			):Show()
	oReport:Section(2):Cell("EMISSAO"		):Show()
	oReport:Section(2):Cell("QUANT"			):Show()
	oReport:Section(2):Cell("TOTAL"			):Show()
	
	cCliente	:= (cAliasQry)->D2_CLIENTE
	cLoja		:= (cAliasQry)->D2_LOJA
	dEmissao	:= (cAliasQry)->D2_EMISSAO
	cDoc 		:= (cAliasQry)->D2_DOC
	cItem 		:= (cAliasQry)->D2_ITEM
	cCod 		:= (cAliasQry)->D2_COD
	cUM 		:= (cAliasQry)->D2_UM
	cGrupo		:= (cAliasQry)->D2_GRUPO
	nQuant		:= (cAliasQry)->D2_QUANT
	
	// Pesquisa Pedido de Vendas a partir do Remito (SD2)
	cChPed:=xFilial("SC6")+(cAliasQry)->D2_PEDIDO+(cAliasQry)->D2_ITEMPV
	DbSelectArea("SC6")
	If DbSeek(cChPed)
		SC5->(DbSeek(xFilial("SC5")+(cAliasQry)->D2_PEDIDO))
	Else
		// Imprime apenas Remito
		// Dados do Pedido de Vendas
		oReport:Section(2):Cell("C6_NUM"		):Hide()
		oReport:Section(2):Cell("C6_ITEM"		):Hide()
		oreport:Section(2):Cell("C5_EMISSAO"	):Hide()
		oReport:Section(2):Cell("C6_QTDVEN"		):Hide()
		oReport:Section(2):Cell("C6_VALOR"		):Hide()
		oReport:Section(2):Cell("C6_ENTREG"		):Hide()
	Endif
	
	cChIFat:=xFilial("SD2")+(cAliasQry)->D2_CLIENTE+(cAliasQry)->D2_LOJA+(cAliasQry)->D2_SERIE+(cAliasQry)->D2_DOC+(cAliasQry)->D2_ITEM
	dbSelectArea("SD2")
	Dbsetorder(9) //D2_FILIAL+D2_CLIENTE+D2_LOJA+D2_SERIREM+D2_REMITO+D2_ITEMREM
	nReg := Recno()
	If DbSeek(cChIFat)
		// Imprime Remito, Pedido e Fatura
		While (D2_FILIAL+D2_CLIENTE+D2_LOJA+D2_SERIREM+D2_REMITO+D2_ITEMREM)==cChIFat
			oReport:Section(2):PrintLine()
			dbSelectArea("SD2")
			DbSkip()
		Enddo
	Else
		// Imprime Remito e Pedido
		// Informacoes da Fatura
		oReport:Section(2):Cell("SERIE"		):Hide()
		oReport:Section(2):Cell("DOC"		):Hide()
		oReport:Section(2):Cell("ITEM"		):Hide()
		oReport:Section(2):Cell("EMISSAO"	):Hide()
		oReport:Section(2):Cell("QUANT"		):Hide()
		oReport:Section(2):Cell("TOTAL"		):Hide()
		
		oReport:Section(2):PrintLine()
	Endif
	
	cCli 	:= (cAliasQry)->D2_CLIENTE
	cLojaCli:= (cAliasQry)->D2_LOJA
	dEmiss 	:= (cAliasQry)->D2_EMISSAO
	If oReport:Section(1):GetOrder() == 1								// Ordem: por Emissao
		cChave   := (cAliasQry)->D2_CLIENTE + (cAliasQry)->D2_DOC
	Else																// Ordem por Cliente
		cChave   := DTOS((cAliasQry)->D2_EMISSAO) + (cAliasQry)->D2_DOC
	EndIf
	
	DbSelectArea(cAliasQry)
	oReport:IncMeter()
	DbSkip()
	
Enddo

oReport:Section(2):Finish()
oReport:Section(2):SetPageBreak(.T.)

RetIndex("SC5")
RetIndex("SC6")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ImpFRP   ³ Autor ³ Marco Bianchi         ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao por Fatura/Remito/Pedido		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR681 - R4                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpFRP(oReport,oRelat3,cAliasQry)

Local cWhere	:= ""	
Local dEmiss	:= CTOD("  /  /  ")
Local cCli		:= ""
Local cLojaCli 	:= ""
Local cOrder	:= ""
Local cCliente	:= ""
Local cLoja		:= ""
Local dEmissao	:= CTOD("  /  /  ")
Local cDoc		:= ""
Local cSerie	:= ""
Local cEspecie	:= ""
Local cItem		:= ""
Local cCod		:= ""
Local cUM		:= ""
Local cGrupo	:= ""
Local nQuant	:= 0
Local nTotal	:= 0
Local cSelect	:= ""

oReport:Section(3):Cell("D2_EMISSAOE"	):SetBlock({|| dEmissao		})
oReport:Section(3):Cell("D2_CLIENTEE"	):SetBlock({|| cCliente		})
oReport:Section(3):Cell("D2_LOJAE"		):SetBlock({|| cLoja		})
oReport:Section(3):Cell("D2_CLIENTEC"	):SetBlock({|| cCliente		})
oReport:Section(3):Cell("D2_LOJAC"	  	):SetBlock({|| cLoja		})
oReport:Section(3):Cell("D2_EMISSAOC"	):SetBlock({|| dEmissao		})
oReport:Section(3):Cell(SerieNfId("SD2",3,"D2_SERIE")):SetBlock({|| cSerie		})
oReport:Section(3):Cell("D2_DOC"		):SetBlock({|| cDoc		    })
oReport:Section(3):Cell("D2_ESPECIE"	):SetBlock({|| cEspecie		})
oReport:Section(3):Cell("D2_ITEM"		):SetBlock({|| cItem		})
oReport:Section(3):Cell("D2_COD"	  	):SetBlock({|| cCod		    })
oReport:Section(3):Cell("D2_UM"			):SetBlock({|| cUM		    })
oReport:Section(3):Cell("D2_GRUPO"		):SetBlock({|| cGrupo		})
oReport:Section(3):Cell("D2_QUANT"		):SetBlock({|| nQuant		})
oReport:Section(3):Cell("D2_TOTAL"		):SetBlock({|| nTotal		})

cDoc	 := ""
cItem	 := ""
dEmissao := ctod("  /  /  ")
nQuant   := 0
cCliente := ""
cLoja	 := ""
cCod 	 := ""
cUM 	 := ""
cGrupo   := ""
cSerie   := ""
cEspecie := ""
nTotal   := 0

If oReport:Section(1):GetOrder() == 1		// Ordem: por Emissao
	oReport:Section(3):Cell("D2_EMISSAOC"):Disable()
	oReport:Section(3):Cell("D2_CLIENTEC"):Disable()
	oReport:Section(3):Cell("D2_LOJAC"):Disable()
Else										// Ordem: por Cliente
	oReport:Section(3):Cell("D2_EMISSAOE"):Disable()
	oReport:Section(3):Cell("D2_CLIENTEE"):Disable()
	oReport:Section(3):Cell("D2_LOJAE"):Disable()
EndIf
oReport:Section(1):disable()
oReport:Section(2):disable()

oReport:SetTitle(STR0013 + STR0016 + "/" + cRetTitle + "/" + STR0015) //"Relacao de faturas/remisiones/pedidos de venda
	
MakeSqlExpr(oReport:uParam)

dbSelectArea("SD2")
If oReport:Section(1):GetOrder() == 1		// Ordem: por Emissao
	dbSetOrder(5) //D2_FILIAL+DTOS(D2_EMISSAO)+D2_NUMSEQ  
	cOrder := "%D2_EMISSAO,D2_CLIENTE,D2_LOJA,D2_SERIE,D2_DOC,D2_ITEM%"
Else										// Ordem: por Cliente
	dbSetOrder(9) //D2_FILIAL+D2_CLIENTE+D2_LOJA+D2_SERIREM+D2_REMITO+D2_ITEMREM
	cOrder := "%D2_CLIENTE,D2_LOJA,D2_EMISSAO,D2_SERIE,D2_DOC,D2_ITEM%"
EndIf	

cWhere := "%"
If !Empty(mv_par02)
	cWhere+=" AND D2_CLIENTE  >= '" + %Exp:mv_par02% + "'"
Endif
If !Empty(mv_par03)
	cWhere+=" AND D2_CLIENTE <= '" + %Exp:mv_par03% + "'"
Endif
If !Empty(mv_par04)
	cWhere+=" AND D2_COD >= '" + %Exp:mv_par04% + "'"
Endif
If !Empty(mv_par05)
	cWhere+=" AND D2_COD <= '" + %Exp:mv_par05% + "'"
Endif
If !Empty(mv_par06)
	cWhere+=" AND D2_GRUPO >= '" + %Exp:mv_par06% + "'"
Endif
If !Empty(mv_par07)
	cWhere+=" AND D2_GRUPO <= '" + %Exp:mv_par07% + "'"
Endif
If !Empty(mv_par08)
    cWhere+=" AND D2_EMISSAO >= '" + %Exp:DTOS(mv_par08)% + "'"
Endif
If !Empty(mv_par09)
	cWhere+=" AND D2_EMISSAO <= '" + %Exp:DTOS(mv_par09)% + "'"
Endif
cWhere+=" AND NOT ("+IsRemito(3,'D2_TIPODOC')+ ")"
cWhere += "%"

cSelect:= "%D2_FILIAL," + IIF(SerieNfId("SD2",3,"D2_SERIE")<>"D2_SERIE",SerieNfId("SD2",3,"D2_SERIE")+","," ")
cSelect+= "D2_SERIE,D2_DOC,D2_ITEM,D2_EMISSAO,D2_QUANT,D2_TOTAL,D2_ESPECIE,D2_COD,D2_UM,D2_GRUPO,D2_REMITO,D2_ITEMREM, "
cSelect+= IIF(SerieNfId("SD2",3,"D2_SERIREM")<>"D2_SERIREM",SerieNfId("SD2",3,"D2_SERIREM")+","," ")+" D2_SERIREM,D2_PEDIDO,D2_ITEMPV, "
cSelect+= "D2_CLIENTE,D2_LOJA, R_E_C_N_O_ RECNO%"

oReport:Section(3):BeginQuery()	
BeginSql Alias cAliasQry
SELECT %Exp:cSelect%
	FROM %Table:SD2% SD2
	WHERE D2_FILIAL = %xFilial:SD2% AND SD2.%notdel%
	%Exp:cWhere%
	ORDER BY %Exp:cOrder%
EndSql       
oReport:Section(3):EndQuery(/*Array com os parametros do tipo Range*/)

SC6->(DbSetOrder(1)) //C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
SC5->(DbSetOrder(1)) //C5_FILIAL+C5_NUM

dbSelectArea(cAliasQry)
dbGoTop()
oReport:Section(3):Init()
oReport:SetMeter((cAliasQry)->(LastRec()))

dEmiss  := CTOD("  /  /  ")
cCli 	:= ""
cLojaCli:= ""
cChave	:= ""
While !oReport:Cancel() .And. !(cAliasQry)->(Eof())
	
	If oReport:Section(1):GetOrder() == 1								// Ordem: por Emissao
		If dEmiss <> (cAliasQry)->D2_EMISSAO
			oReport:Section(3):Cell("D2_EMISSAOE"	):Show()
		Else
			oReport:Section(3):Cell("D2_EMISSAOE"	):Hide()
		EndIf
		If cChave <> (cAliasQry)->D2_CLIENTE+(cAliasQry)->D2_SERIE+(cAliasQry)->D2_DOC
			oReport:Section(3):Cell("D2_CLIENTEE"	):Show()
			oReport:Section(3):Cell("D2_LOJAE"		):Show()
			oReport:Section(3):Cell(SerieNfId("SD2",3,"D2_SERIE")):Show()
			oReport:Section(3):Cell("D2_DOC"		):Show()
			oReport:Section(3):Cell("D2_ESPECIE"	):Show()
		Else
			oReport:Section(3):Cell("D2_CLIENTEE"	):Hide()
			oReport:Section(3):Cell("D2_LOJAE"		):Hide()
			oReport:Section(3):Cell(SerieNfId("SD2",3,"D2_SERIE")		):Hide()
			oReport:Section(3):Cell("D2_DOC"		):Hide()
			oReport:Section(3):Cell("D2_ESPECIE"	):Hide()
		EndIf
	Else 																// Ordem: por Cliente
		If cCli <> (cAliasQry)->D2_CLIENTE .Or. cLojaCli <> (cAliasQry)->D2_LOJA
			oReport:Section(3):Cell("D2_CLIENTEC"	):Show()
			oReport:Section(3):Cell("D2_LOJAC"		):Show()
		Else
			oReport:Section(3):Cell("D2_CLIENTEC"	):Hide()
			oReport:Section(3):Cell("D2_LOJAC"		):Hide()
		EndIf
		If cChave <> DTOS((cAliasQry)->D2_EMISSAO)+(cAliasQry)->D2_SERIE+(cAliasQry)->D2_DOC
			oReport:Section(3):Cell("D2_EMISSAOC"	):Show()
			oReport:Section(3):Cell(SerieNfId("SD2",3,"D2_SERIE")):Show()
			oReport:Section(3):Cell("D2_DOC"		):Show()
			oReport:Section(3):Cell("D2_ESPECIE"	):Show()
		Else
			oReport:Section(3):Cell("D2_EMISSAOC"	):Hide()
			oReport:Section(3):Cell(SerieNfId("SD2",3,"D2_SERIE")):Hide()
			oReport:Section(3):Cell("D2_DOC"		):Hide()
			oReport:Section(3):Cell("D2_ESPECIE"	):Hide()
		EndIf
	EndIf
	
	oReport:Section(3):Cell("D2_ITEM"		):Show()
	oReport:Section(3):Cell("D2_COD"		):Show()
	oReport:Section(3):Cell("D2_UM"			):Show()
	oReport:Section(3):Cell("D2_GRUPO"		):Show()
	oReport:Section(3):Cell("D2_QUANT"		):Show()
	oReport:Section(3):Cell("D2_TOTAL"		):Show()
	
	// Informacoes do Remito
	oReport:Section(3):Cell("DOC"			):Show()
	oReport:Section(3):Cell("ITEM"			):Show()
	oReport:Section(3):Cell("EMISSAO"		):Show()
	oReport:Section(3):Cell("QUANT"			):Show()
	
	// Dados do Pedido de Vendas
	oReport:Section(3):Cell("C6_NUM"		):Show()
	oReport:Section(3):Cell("C6_ITEM"		):Show()
	oreport:Section(3):Cell("C5_EMISSAO"	):Show()
	oReport:Section(3):Cell("C6_QTDVEN"		):Show()
	oReport:Section(3):Cell("C6_VALOR"		):Show()
	oReport:Section(3):Cell("C6_ENTREG"		):Show()
	
	cCliente	:= (cAliasQry)->D2_CLIENTE
	cLoja		:= (cAliasQry)->D2_LOJA
	dEmissao	:= (cAliasQry)->D2_EMISSAO
	cSerie 	:= Alltrim((cAliasQry)->&(SerieNfId("SD2",3,"D2_SERIE")))
	cDoc 		:= (cAliasQry)->D2_DOC
	cEspecie	:= (cAliasQry)->D2_ESPECIE
	cItem 		:= (cAliasQry)->D2_ITEM
	cCod 		:= (cAliasQry)->D2_COD
	cUM 		:= (cAliasQry)->D2_UM
	cGrupo		:= (cAliasQry)->D2_GRUPO
	nQuant		:= (cAliasQry)->D2_QUANT
	nTotal		:= (cAliasQry)->D2_TOTAL
	
	SD2->(dbSetOrder(3)) //D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
	SD2->(DBSeek(xFilial("SD2")+(cAliasQry)->D2_REMITO+(cAliasQry)->D2_SERIREM+(cAliasQry)->D2_CLIENTE+(cAliasQry)->D2_LOJA+(cAliasQry)->D2_COD+(cAliasQry)->D2_ITEMREM))
	
	If !Empty((cAliasQry)->D2_PEDIDO)
		SC6->(DBSeek(xFilial("SC6")+(cAliasQry)->D2_PEDIDO+(cAliasQry)->D2_ITEMPV))
		SC5->(DBSeek(xFilial("SC5")+(cAliasQry)->D2_PEDIDO))
	Else
		SC6->(DBSeek(xFilial("SC6")+SD2->D2_PEDIDO+SD2->D2_ITEMPV))
		SC5->(DBSeek(xFilial("SC5")+SD2->D2_PEDIDO))
	EndIf	
	
	oReport:Section(3):PrintLine()
	
	dEmiss  := (cAliasQry)->D2_EMISSAO
	cCli	:= (cAliasQry)->D2_CLIENTE
	cLojaCli:= (cAliasQry)->D2_LOJA
	If oReport:Section(1):GetOrder() == 1							// Ordem: por Emissao
		cChave   := (cAliasQry)->D2_CLIENTE + (cAliasQry)->D2_SERIE +(cAliasQry)->D2_DOC + (cAliasQry)->D2_ESPECIE
	Else																// Ordem por Cliente
		cChave   := DTOS((cAliasQry)->D2_EMISSAO) + (cAliasQry)->D2_SERIE +(cAliasQry)->D2_DOC + (cAliasQry)->D2_ESPECIE
	EndIf
	
	DbSelectArea(cAliasQry)
	oReport:IncMeter()
	DbSkip()
	
Enddo

oReport:Section(3):Finish()
oReport:Section(3):SetPageBreak(.T.)

RetIndex("SC5")
RetIndex("SC6")

Return
