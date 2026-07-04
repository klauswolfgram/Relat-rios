/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR680.CH" 
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR680  ³ Autor ³ Marco Bianchi         ³ Data ³ 04/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Pedidos nao entregues                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT - R4                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR680() 

Local oReport
Local aFieldsPD := {}

If FindFunction("TRepInUse") .And. TRepInUse()
	aFieldsPD := {"A1_NOME", "A3_NOME"}
	FATPDLoad(Nil, Nil, aFieldsPD)
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
	FATPDUnload()
	ASize(aFieldsPD, 0)
Else
	U_MATR680R3()
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 04/07/06 ³±±
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
Local oPedNEnt
Local oProduto
Local oCliente
Local oData
Local oVendedor

Local nSaldo		:= 0
Local nValor		:= 0
Local nTotVen		:= 0
Local nTotEnt		:= 0
Local cPerg			:= IIf(cPaisLoc == "BRA","MTR680","MR680A")
Local nTamData		:= Len(DTOC(MsDate()))
Local lLineBreak    := .T. 										
Local cAliasQry 	:= GetNextAlias()

Private nTamRef 	:= Val(Substr(GetMv("MV_MASCGRD"),1,2)) //Manter a private pois há ponto de entrada no relatorio.

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
oReport := TReport():New("MATR680",STR0027,cPerg, {|oReport| ReportPrint(oReport,cAliasQry,oPedNEnt,oProduto,oCliente,oData,oVendedor)},STR0028 + " " + STR0029 + " " + STR0030)	// "Relacao de Pedidos nao entregues"###"Este programa ira emitir a relacao dos Pedidos Pendentes,"###"imprimindo o numero do Pedido, Cliente, Data da Entrega, "###"Qtde pedida, Qtde ja entregue,Saldo do Produto e atraso."
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

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
//³ Por Pedido                                                         	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPedNEnt := TRSection():New(oReport,STR0041,{"TRB","SC6","SA1","SA3","SF4"},{STR0031,STR0032,STR0033,STR0034,STR0035},;
/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,/*lHeaderBreak*/,/*lPageBreak*/,lLineBreak)	// "Relacao de Pedidos nao entregues"###"Por Pedido"###"Por Produto"###"Por Cliente"###"Por Dt.Entrega"###"Por Vendedor"
oPedNEnt:SetTotalInLine(.F.)
TRCell():New(oPedNEnt,"NUM"			,"TRB",RetTitle("C6_NUM"		),PesqPict("SC6","C6_NUM"		),TamSx3("C6_NUM"		)[1],/*lPixel*/,{|| TRB->NUM						                                    },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oPedNEnt,"EMISSAO"		,"TRB",RetTitle("C5_EMISSAO"	),PesqPict("SC5","C5_EMISSAO"	),TamSx3("C5_EMISSAO"	)[1],/*lPixel*/,{|| Iif(oReport:nDevice == 4,DtoC(TRB->EMISSAO),TRB->EMISSAO)	        },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oPedNEnt,"CLIENTE"		,"TRB",RetTitle("C6_CLI"		),PesqPict("SC6","C6_CLI"		),TamSx3("C6_CLI"		)[1],/*lPixel*/,{|| TRB->CLIENTE					                                    },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oPedNEnt,"LOJA"		,"TRB",RetTitle("C6_LOJA"		),PesqPict("SC6","C6_LOJA"		),TamSx3("C6_LOJA"		)[1],/*lPixel*/,{|| TRB->LOJA 						                                    },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oPedNEnt,"NOMECLI"		,"TRB",RetTitle("A1_NOME"		),PesqPict("SA1","A1_NOME"		),TamSx3("A1_NOME"		)[1],/*lPixel*/,{|| FATPDObfuscate(TRB->NOMECLI, "A1_NOME")					            },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oPedNEnt,"ITEM"		,"TRB",RetTitle("C6_ITEM"		),PesqPict("SC6","C6_ITEM"		),TamSx3("C6_ITEM"		)[1],/*lPixel*/,{|| TRB->ITEM 						                                    },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oPedNEnt,"PRODUTO1"	,"TRB",RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| Substr(TRB->PRODUTO,1,nTamRef)	                                    },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oPedNEnt,"PRODUTO2"	,"TRB",RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| IIF (TRB->GRADE == 'S',Substr(TRB->PRODUTO,1,nTamRef) ,TRB->PRODUTO)},/*cAlign*/,/*lLineBreak*/)
TRCell():New(oPedNEnt,"DESCRICAO"	,"TRB",RetTitle("C6_DESCRI"		),PesqPict("SC6","C6_DESCRI"	),TamSx3("C6_DESCRI"	)[1],/*lPixel*/,{|| TRB->DESCRICAO					                                    },/*cAlign*/,/*lLineBreak*/)

// Quando nome da celular nao e do SX3 e o campo for do tipo Data, o tamanho deve ser preenchido com
// Len(DTOC(MsDate())), para que nao haja problema na utilizacao de ano com 4 digitos.
TRCell():New(oPedNEnt,"DATENTR"	,"TRB"	,RetTitle("C6_ENTREG")	,PesqPict("SC6","C6_ENTREG"	),nTamData				      ,/*lPixel*/ ,{|| Iif(oReport:nDevice == 4,DtoC(TRB->DATENTR),TRB->DATENTR)	},/*cAlign*/,/*lLineBreak*/)	// Data de Entrega
TRCell():New(oPedNEnt,"NTOTVEN"	,   	,RetTitle("C6_QTDVEN")	,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nTotVen							},/*cAlign*/,/*lLineBreak*/)
TRCell():New(oPedNEnt,"NTOTENT"	,   	,RetTitle("C6_QTDENT")	,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nTotEnt							},/*cAlign*/,/*lLineBreak*/)
TRCell():New(oPedNEnt,"NSALDO"	,	 	,STR0036				,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nSaldo																						},/*cAlign*/,/*lLineBreak*/)	// "Quant.Pendente"
TRCell():New(oPedNEnt,"NVALOR"	,	  	,STR0037				,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nValor																						},/*cAlign*/,/*lLineBreak*/)	// "Valot Total Pendente"

	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Por Produto                                                       	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oProduto := TRSection():New(oReport,STR0042,{"TRB","SC6","SA1","SA3","SF4"},{STR0031,STR0032,STR0033,STR0034,STR0035},;
/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,/*lHeaderBreak*/,/*lPageBreak*/,lLineBreak)	
// "Relacao de Pedidos nao entregues"###"Por Pedido"###"Por Produto"###"Por Cliente"###"Por Dt.Entrega"###"Por Vendedor"
oProduto:SetTotalInLine(.F.)

TRCell():New(oProduto,"PRODUTO1"	,"TRB",RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| Substr(TRB->PRODUTO,1,nTamRef)	                            },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"PRODUTO2"	,"TRB",RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| TRB->PRODUTO	                                            },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"DESCRICAO"	,"TRB",RetTitle("C6_DESCRI"		),PesqPict("SC6","C6_DESCRI"	),TamSx3("C6_DESCRI"	)[1],/*lPixel*/,{|| TRB->DESCRICAO												},/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"NUM"			,"TRB",RetTitle("C6_NUM"		),PesqPict("SC6","C6_NUM"		),TamSx3("C6_NUM"		)[1],/*lPixel*/,{|| TRB->NUM 													},/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"ITEM"		,"TRB",RetTitle("C6_ITEM"		),PesqPict("SC6","C6_ITEM"		),TamSx3("C6_ITEM"		)[1],/*lPixel*/,{|| TRB->ITEM 													},/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"EMISSAO"		,"TRB",RetTitle("C5_EMISSAO"	),PesqPict("SC5","C5_EMISSAO"	),TamSx3("C5_EMISSAO"	)[1],/*lPixel*/,{|| Iif(oReport:nDevice == 4,DtoC(TRB->EMISSAO ),TRB->EMISSAO)	},/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"DATENTR"		,"TRB",RetTitle("C6_ENTREG"		),PesqPict("SC6","C6_ENTREG"	),nTamData                  ,/*lPixel*/,{|| Iif(oReport:nDevice == 4,DtoC(TRB->DATENTR),TRB->DATENTR)   },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"CLIENTE"		,"TRB",RetTitle("C6_CLI"		),PesqPict("SC6","C6_CLI"		),TamSx3("C6_CLI"		)[1],/*lPixel*/,{|| TRB->CLIENTE 												},/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"LOJA"		,"TRB",RetTitle("C6_LOJA"		),PesqPict("SC6","C6_LOJA"		),TamSx3("C6_LOJA"		)[1],/*lPixel*/,{|| TRB->LOJA 													},/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"NOMECLI"		,"TRB",RetTitle("A1_NOME"		),PesqPict("SA1","A1_NOME"		),TamSx3("A1_NOME"		)[1],/*lPixel*/,{|| FATPDObfuscate(TRB->NOMECLI, "A1_NOME")                     },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"NTOTVEN"		,"TRB",RetTitle("C6_QTDVEN"		),PesqPict("SF2","F2_VALBRUT"  ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nTotVen							                            },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"NTOTENT"		,"TRB",RetTitle("C6_QTDENT"		),PesqPict("SF2","F2_VALBRUT"  ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nTotEnt							                            },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oProduto,"NSALDO"		,	  ,STR0036					 ,PesqPict("SF2","F2_VALBRUT"  ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nSaldo														},/*cAlign*/,/*lLineBreak*/)	// "Quant.Pendente"
TRCell():New(oProduto,"NVALOR"		,	  ,STR0037					 ,PesqPict("SF2","F2_VALBRUT"  ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nValor														},/*cAlign*/,/*lLineBreak*/)	// "Valot Total Pendente"
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Por Cliente                                                       	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCliente := TRSection():New(oReport,STR0043,{"TRB","SC6","SA1","SA3","SF4"},{STR0031,STR0032,STR0033,STR0034,STR0035},;
/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,/*lHeaderBreak*/,/*lPageBreak*/,lLineBreak)	// "Relacao de Pedidos nao entregues"###"Por Pedido"###"Por Produto"###"Por Cliente"###"Por Dt.Entrega"###"Por Vendedor"
oCliente:SetTotalInLine(.F.)

TRCell():New(oCliente,"CLIENTE"		,"TRB",RetTitle("C6_CLI"		),PesqPict("SC6","C6_CLI"		),TamSx3("C6_CLI"		)[1],/*lPixel*/,{|| TRB->CLIENTE 												 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"LOJA"		,"TRB",RetTitle("C6_LOJA"		),PesqPict("SC6","C6_LOJA"		),TamSx3("C6_LOJA"		)[1],/*lPixel*/,{|| TRB->LOJA 													 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"NOMECLI"		,"TRB",RetTitle("A1_NOME"		),PesqPict("SA1","A1_NOME"		),TamSx3("A1_NOME"		)[1],/*lPixel*/,{|| FATPDObfuscate(TRB->NOMECLI, "A1_NOME")                      },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"NUM"			,"TRB",RetTitle("C6_NUM"		),PesqPict("SC6","C6_NUM"		),TamSx3("C6_NUM"		)[1],/*lPixel*/,{|| TRB->NUM 													 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"ITEM"	  	,"TRB",RetTitle("C6_ITEM"		),PesqPict("SC6","C6_ITEM"		),TamSx3("C6_ITEM"		)[1],/*lPixel*/,{|| TRB->ITEM 													 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"EMISSAO"		,"TRB",RetTitle("C5_EMISSAO"	),PesqPict("SC5","C5_EMISSAO"	),TamSx3("C5_EMISSAO"	)[1],/*lPixel*/,{|| Iif(oReport:nDevice == 4,DtoC(TRB->EMISSAO),TRB->EMISSAO)	 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"PRODUTO1"	,"TRB",RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| Substr(TRB->PRODUTO,1,nTamRef)	                             },/*cAlign*/,/*lLineBreak*/) 
TRCell():New(oCliente,"PRODUTO2"	,"TRB",RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| TRB->PRODUTO	                                             },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"DESCRICAO"	,"TRB",RetTitle("C6_DESCRI"		),PesqPict("SC6","C6_DESCRI"	),TamSx3("C6_DESCRI"	)[1],/*lPixel*/,{|| TRB->DESCRICAO												 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"DATENTR"		,"TRB",RetTitle("C6_ENTREG"		),PesqPict("SC6","C6_ENTREG"	),nTamData                  ,/*lPixel*/,{|| Iif(oReport:nDevice == 4,DtoC(TRB->DATENTR),TRB->DATENTR)    },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"NTOTVEN"		,"TRB",RetTitle("C6_QTDVEN"		),PesqPict("SF2","F2_VALBRUT"   ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nTotVen							                             },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"NTOTENT"		,"TRB",RetTitle("C6_QTDENT"		),PesqPict("SF2","F2_VALBRUT"   ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nTotEnt							                             },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oCliente,"NSALDO"		,	  ,STR0036					 ,PesqPict("SF2","F2_VALBRUT"   ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nSaldo														 },/*cAlign*/,/*lLineBreak*/)	// "Quant.Pendente"
TRCell():New(oCliente,"NVALOR"		,	  ,STR0037					 ,PesqPict("SF2","F2_VALBRUT"   ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nValor														 },/*cAlign*/,/*lLineBreak*/)	// "Valot Total Pendente"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Por Data de Entrega                                                	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oData := TRSection():New(oReport,STR0044,{"TRB","SC6","SA1","SA3","SF4"},{STR0031,STR0032,STR0033,STR0034,STR0035},;
/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,/*lHeaderBreak*/,/*lPageBreak*/,lLineBreak)	// "Relacao de Pedidos nao entregues"###"Por Pedido"###"Por Produto"###"Por Cliente"###"Por Dt.Entrega"###"Por Vendedor"
oData:SetTotalInLine(.F.)

TRCell():New(oData,"DATENTR"	,"TRB",RetTitle("C6_ENTREG"		),PesqPict("SC6","C6_ENTREG"	),nTamData,/*lPixel*/,{|| Iif(oReport:nDevice == 4,DtoC(TRB->DATENTR),TRB->DATENTR)							 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oData,"NUM"		,"TRB",RetTitle("C6_NUM"		),PesqPict("SC6","C6_NUM"		),TamSx3("C6_NUM"		)[1],/*lPixel*/,{|| TRB->NUM 														 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oData,"EMISSAO"	,"TRB",RetTitle("C5_EMISSAO"	),PesqPict("SC5","C5_EMISSAO"	),TamSx3("C5_EMISSAO"	)[1],/*lPixel*/,{|| Iif(oReport:nDevice == 4,DtoC(TRB->EMISSAO),TRB->EMISSAO)		 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oData,"CLIENTE"	,"TRB",RetTitle("C6_CLI"		),PesqPict("SC6","C6_CLI"		),TamSx3("C6_CLI"		)[1],/*lPixel*/,{|| TRB->CLIENTE 													 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oData,"LOJA"		,"TRB",RetTitle("C6_LOJA"		),PesqPict("SC6","C6_LOJA"		),TamSx3("C6_LOJA"		)[1],/*lPixel*/,{|| TRB->LOJA 														 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oData,"NOMECLI"	,"TRB",RetTitle("A1_NOME"		),PesqPict("SA1","A1_NOME"		),TamSx3("A1_NOME"		)[1],/*lPixel*/,{|| FATPDObfuscate(TRB->NOMECLI, "A1_NOME")		                     },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oData,"ITEM"		,"TRB",RetTitle("C6_ITEM"		),PesqPict("SC6","C6_ITEM"		),TamSx3("C6_ITEM"		)[1],/*lPixel*/,{|| TRB->ITEM 														 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oData,"PRODUTO1"	,"TRB",RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| Substr(TRB->PRODUTO,1,nTamRef)	                                 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(odata,"PRODUTO2"	,"TRB",RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| TRB->PRODUTO	                                                 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oData,"DESCRICAO"	,"TRB",RetTitle("C6_DESCRI"		),PesqPict("SC6","C6_DESCRI"	),TamSx3("C6_DESCRI"	)[1],/*lPixel*/,{|| TRB->DESCRICAO													 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oData,"NTOTVEN"	,"TRB",RetTitle("C6_QTDVEN"		),PesqPict("SF2","F2_VALBRUT"  ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nTotVen							                                 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(odata,"NTOTENT"	,"TRB",RetTitle("C6_QTDENT"		),PesqPict("SF2","F2_VALBRUT"  ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nTotEnt							                                 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oData,"NSALDO"		,	  ,STR0036					 ,PesqPict("SF2","F2_VALBRUT"  ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nSaldo															 },/*cAlign*/,/*lLineBreak*/)	// "Quant.Pendente"
TRCell():New(oData,"NVALOR"		,	  ,STR0037					 ,PesqPict("SF2","F2_VALBRUT"  ),TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nValor															 },/*cAlign*/,/*lLineBreak*/)	// "Valot Total Pendente"
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Por Vendedor                                                       	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oVendedor := TRSection():New(oReport,STR0045,{"TRB","SC6","SA1","SA3","SF4"},{STR0031,STR0032,STR0033,STR0034,STR0035},;
/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,/*lHeaderBreak*/,/*lPageBreak*/,lLineBreak)	// "Relacao de Pedidos nao entregues"###"Por Pedido"###"Por Produto"###"Por Cliente"###"Por Dt.Entrega"###"Por Vendedor"
oVendedor:SetTotalInLine(.F.)

TRCell():New(oVendedor,"VENDEDOR"	,"TRB",RetTitle("C5_VEND1"		),PesqPict("SC5","C5_VEND1"	)    ,TamSx3("C5_VEND1"	)[1],/*lPixel*/,{|| TRB->VENDEDOR													 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"NOMEVEN"	,"TRB",RetTitle("A3_NOME"		),PesqPict("SA3","A3_NOME"	)    ,TamSx3("A3_NOME"	)[1]         ,/*lPixel*/,{|| FATPDObfuscate(TRB->NOMEVEN, "A3_NOME")				 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"NUM"		,"TRB",RetTitle("C6_NUM"		),PesqPict("SC6","C6_NUM"		),TamSx3("C6_NUM"		)[1],/*lPixel*/,{|| TRB->NUM 													 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"ITEM"		,"TRB",RetTitle("C6_ITEM"		),PesqPict("SC6","C6_ITEM"		),TamSx3("C6_ITEM"		)[1],/*lPixel*/,{|| TRB->ITEM 													 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"EMISSAO"	,"TRB",RetTitle("C5_EMISSAO"	),PesqPict("SC5","C5_EMISSAO"	),TamSx3("C5_EMISSAO"	)[1],/*lPixel*/,{|| Iif(oReport:nDevice == 4,DtoC(TRB->EMISSAO),TRB->EMISSAO)	 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"PRODUTO1"	,"TRB",RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| Substr(TRB->PRODUTO,1,nTamRef)	                             },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"PRODUTO2"	,"TRB",RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| TRB->PRODUTO	                                             },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"DESCRICAO"	,"TRB",RetTitle("C6_DESCRI"		),PesqPict("SC6","C6_DESCRI"	),TamSx3("C6_DESCRI"	)[1],/*lPixel*/,{|| TRB->DESCRICAO												 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"DATENTR"	,"TRB",RetTitle("C6_ENTREG"		),PesqPict("SC6","C6_ENTREG"	),nTamData,/*lPixel*/,{|| Iif(oReport:nDevice == 4,DtoC(TRB->DATENTR),TRB->DATENTR)						 },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"NTOTVEN"	,"TRB",RetTitle("C6_QTDVEN"		),PesqPict("SF2","F2_VALBRUT"  ) ,TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nTotVen							                             },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"NTOTENT"	,"TRB",RetTitle("C6_QTDENT"		),PesqPict("SF2","F2_VALBRUT"  ) ,TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nTotEnt							                             },/*cAlign*/,/*lLineBreak*/)
TRCell():New(oVendedor,"NSALDO"		,	  ,STR0036					 ,PesqPict("SF2","F2_VALBRUT"  ) ,TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nSaldo														 },/*cAlign*/,/*lLineBreak*/)	// "Quant.Pendente"
TRCell():New(oVendedor,"NVALOR"		,	  ,STR0037					 ,PesqPict("SF2","F2_VALBRUT"  ) ,TamSx3("F2_VALBRUT"	)[1],/*lPixel*/,{|| nValor														 },/*cAlign*/,/*lLineBreak*/)	// "Valot Total Pendente"

oReport:Section(1):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query
oReport:Section(2):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query
oReport:Section(3):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query
oReport:Section(4):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query
oReport:Section(5):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas 				    	               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)

oReport:Section(1):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query
oReport:Section(2):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query
oReport:Section(3):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query
oReport:Section(4):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query
oReport:Section(5):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 04/07/06 ³±±
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

Static Function ReportPrint(oReport,cAliasQry,oPedNEnt,oProduto,oCliente,oData,oVendedor)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis   										     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local dData     := CtoD("  /  /  ")
Local cNumPed   := ""
Local cNumCli   := ""
Local nTotVen   := 0
Local nTotEnt   := 0
Local nFirst    := 0
Local nSaldo    := 0
Local nValor    := 0
Local cQuebra	:= ""
Local nMoeda    := IIF(cPaisLoc == "BRA",MV_PAR18,1)
Local aConfSched:= IIf(isBlind() .And. FWGetRunSchedule(), FWSchPrintCFG(),{})
Local nSection  := IIf(isBlind() .And. FWGetRunSchedule(), aConfSched[4], oReport:Section(1):GetOrder())
Local oSecao    := oReport:Section(nSection) 
Local cTitNVALOR:= ""

Private cNum		:= ""
Private cProduto	:= ""
Private cCli		:= ""
Private dEntreg 	:= CtoD("  /  /  ")
Private cVde    	:= ""
Private nTamRef 	:= Val(Substr(GetMv("MV_MASCGRD"),1,2)) //Manter a private pois há ponto de entrada no relatorio.
Private oTempTable	:= Nil 
 
If cPaisLoc == "BRA"
	If MV_PAR19 = 1
		cTitNVALOR := STR0046
	Else
		cTitNVALOR := STR0047
	EndIf
Else
	If MV_PAR20 = 1
		cTitNVALOR := STR0046
	Else
		cTitNVALOR := STR0047
	EndIf
EndIf

oSecao:Cell("NSALDO" ):SetBlock({|| nSaldo})
oSecao:Cell("NVALOR" ):SetBlock({|| nValor})
oSecao:Cell("NTOTVEN" ):SetBlock({|| nTotVen})
oSecao:Cell("NTOTENT" ):SetBlock({|| nTotEnt})
nSaldo  := 0
nValor  := 0
nTotVen := 0
nTotEnt := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Por Pedido                                                         	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nSection == 1			// Por Pedido
	cQuebra := "NUM = cNum"
	TRFunction():New(oPedNEnt:Cell("NTOTVEN"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oPedNEnt:Cell("NTOTENT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oPedNEnt:Cell("NSALDO"		),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	oPedNEnt:Cell("NVALOR"):SetTitle(oPedNEnt:Cell("NVALOR"):Title() + cTitNVALOR)
	TRFunction():New(oPedNEnt:Cell("NVALOR"		),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Por Produto                                                       	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ElseIf nSection == 2		// Por Produto
	cQuebra := "PRODUTO = cProduto"
	TRFunction():New(oProduto:Cell("NTOTVEN"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oProduto:Cell("NTOTENT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oProduto:Cell("NSALDO"		),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	oProduto:Cell("NVALOR"):SetTitle(oProduto:Cell("NVALOR"):Title() + cTitNVALOR)
	TRFunction():New(oProduto:Cell("NVALOR"		),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Por Cliente                                                       	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ElseIf nSection == 3		// Por Cliente
	cQuebra := "CLIENTE+LOJA = cCli"
	TRFunction():New(oCliente:Cell("NTOTVEN"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oCliente:Cell("NTOTENT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oCliente:Cell("NSALDO"		),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	oCliente:Cell("NVALOR"):SetTitle(oCliente:Cell("NVALOR"):Title() + cTitNVALOR)
	TRFunction():New(oCliente:Cell("NVALOR"		),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Por Data de Entrega                                                	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ElseIf nSection == 4		// Por Data de Entrega
	cQuebra := "DATENTR = dEntreg"
	TRFunction():New(oData:Cell("NTOTVEN"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oData:Cell("NTOTENT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oData:Cell("NSALDO"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	oData:Cell("NVALOR"):SetTitle(oData:Cell("NVALOR"):Title() + cTitNVALOR)
	TRFunction():New(oData:Cell("NVALOR"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Por Vendedor                                                       	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Else 
	cQuebra := "VENDEDOR = cVde"
	TRFunction():New(oVendedor:Cell("NTOTVEN"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oVendedor:Cell("NTOTENT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oVendedor:Cell("NSALDO"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	oVendedor:Cell("NVALOR"):SetTitle(oVendedor:Cell("NVALOR"):Title() + cTitNVALOR)
	TRFunction():New(oVendedor:Cell("NVALOR"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict("SF2","F2_VALBRUT"),/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera o Titulo do Relatorio de acordo com parametros	 	           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " - " + IIF(nSection == 1,STR0031,	;		// "Relacao de Pedidos nao entregues"###"Por Pedido"
								IIF(nSection==2,STR0032,;				// "Por Produto"
								IIF(nSection==3,STR0033,;				// "Por Cliente"
								IIF(nSection==4,STR0034,STR0035))));	// "Por Dt.Entrega"###"Por Vendedor"
								 + " - " + GetMv("MV_MOEDA"+STR(nMoeda,1)))	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Cabecalho no top da pagina                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecao:SetHeaderPage()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Transforma parametros Range em expressao SQL                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo TrPosition()                                                     ³
//³                                                                        ³
//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
//³realizado antes da impressao de cada linha do relatório.                ³
//³                                                                        ³
//³                                                                        ³
//³ExpO1 : Objeto Report da Secao                                          ³
//³ExpC2 : Alias da Tabela                                                 ³
//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
//³        cutada.                                                         ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSecao,"SA1",1,{|| xFilial("SA1")+TRB->CLIENTE+TRB->LOJA })
TRPosition():New(oSecao,"SA3",1,{|| xFilial("SA3")+TRB->VENDEDOR })
TRPosition():New(oSecao,"SF4",1,{|| xFilial("SF4")+TRB->TES })
TRPosition():New(oSecao,"SC6",1,{|| xFilial("SC6")+TRB->NUM+TRB->ITEM+TRB->PRODUTO })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera Tabela Temporaria para impressao                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| TR680Trab(oReport,cAliasQry,nSection,oSecao)},STR0038)			// "Gerando Tabela de Trabalho. Aguarde..."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Relatorio                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TRB")
dbGoTop()
oReport:SetMeter(RecCount())		// Total de elementos da regua

nFirst := 0

While !oReport:Cancel() .And. !Eof()

	If nFirst = 0
		If TRB->GRADE=="S" .And. MV_PAR12 == 1
			oSecao:Cell("PRODUTO1"):Show()
			oSecao:Cell("PRODUTO2"):Show()
		Else
			oSecao:Cell("PRODUTO1"):Disable()
			oSecao:Cell("PRODUTO2"):Show()
		EndIf
	EndIf
	
	If nFirst = 0
		oSecao:Init()
    Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica campo para quebra									 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNum	:= NUM
	cProduto:= PRODUTO
	cCli	:= CLIENTE+LOJA
	dEntreg := DATENTR
	cVde    := VENDEDOR
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis Totalizadoras     		    					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nSaldo  := QUANTIDADE-ENTREGUE
	nTotVen := QUANTIDADE
	nTotEnt := ENTREGUE
    nValor  := xMoeda(VALOR,MOEDA,nMoeda,EMISSAO)
    
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Agrutina os produtos da grade conforme o parametro MV_PAR12  |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF TRB->GRADE == "S" .And. MV_PAR12 == 1
		
		cProdRef:= Substr(TRB->PRODUTO,1,nTamRef)
		
		If nSection = 2
			cAgrutina := "cProdRef == Substr(PRODUTO,1,nTamRef)"
		Else
			cAgrutina := cQuebra
		Endif
		
		nSaldo  := 0
		nTotVen := 0
		nTotEnt := 0
        nValor  := 0
		nReg    := 0
		
		While !Eof() .And. xFilial("SC6") == TRB->FILIAL .And. cProdRef == Substr(PRODUTO,1,nTamRef);
			.And. TRB->GRADE == "S" .And. &cAgrutina .And. cNum == NUM
			
			nReg	:= Recno()
			nTotVen += QUANTIDADE
			nTotEnt += ENTREGUE
			nSaldo  += QUANTIDADE-ENTREGUE
    	    nValor  += xMoeda(VALOR,MOEDA,nMoeda,EMISSAO)
			
			dbSelectArea("TRB")
			dbSkip()
			oReport:IncMeter()
			
		End
		
		If nReg > 0
			dbGoto(nReg)
			nReg :=0
		Endif
	Endif
	
	If (nFirst = 0 .And. nSection != 4) .Or. nSection == 4
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleicona celulas do cabecalho da linha                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Do Case
			Case nSection = 1    				// Por Pedido
				oSecao:Cell("NUM"		):Show()
				oSecao:Cell("EMISSAO"	):Show()
				oSecao:Cell("CLIENTE"	):Show()
				oSecao:Cell("LOJA"		):Show()
				oSecao:Cell("NOMECLI"	):Show()
				oSecao:Cell("ITEM"		):Show()
				oSecao:Cell("PRODUTO1"	):Show()
				oSecao:Cell("PRODUTO2"	):Show()
				oSecao:Cell("DESCRICAO"	):Show()
				oSecao:Cell("DATENTR"	):Show()
			Case nSection = 2					// Pro Produto
				If TRB->GRADE=="S" .And. MV_PAR12 == 1
					oSecao:Cell("PRODUTO1"):Show()
					oSecao:Cell("PRODUTO2"):Show()
				Else
					oSecao:Cell("PRODUTO1"):Disable()
					oSecao:Cell("PRODUTO2"):Show()
				EndIf
				oSecao:Cell("DESCRICAO"	):Show()
				oSecao:Cell("NUM"		):Show()
				oSecao:Cell("ITEM"		):Show()
				oSecao:Cell("EMISSAO"	):Show()
				oSecao:Cell("DATENTR"	):Show()
				oSecao:Cell("CLIENTE"	):Show()
				oSecao:Cell("LOJA"		):Show()
				oSecao:Cell("NOMECLI"	):Show()
			Case nSection = 3					// Por Cliente
				oSecao:Cell("CLIENTE"	):Show()
				oSecao:Cell("LOJA"		):Show()
				oSecao:Cell("NOMECLI"	):Show()
				oSecao:Cell("NUM"		):Show()
				oSecao:Cell("ITEM"		):Show()
				oSecao:Cell("EMISSAO"	):Show()
				oSecao:Cell("PRODUTO1"	):Show()
				oSecao:Cell("PRODUTO2"	):Show()
				oSecao:Cell("DESCRICAO"	):Show()
				oSecao:Cell("DATENTR"	):Show()
			Case nSection = 4					// Por Data de Entrega
				If cNumPed+cNumCli+DtoS(dData) == NUM+CLIENTE+DtoS(DATENTR)
					oSecao:Cell("DATENTR"	):Hide()
					oSecao:Cell("NUM"		):Hide()
					oSecao:Cell("EMISSAO"	):Hide()
					oSecao:Cell("CLIENTE"	):Hide()
					oSecao:Cell("LOJA"		):Hide()
					oSecao:Cell("NOMECLI"	):Hide()
				Else
					oSecao:Cell("DATENTR"	):Show()
					oSecao:Cell("NUM"		):Show()
					oSecao:Cell("EMISSAO"	):Show()
					oSecao:Cell("CLIENTE"	):Show()
					oSecao:Cell("LOJA"		):Show()
					oSecao:Cell("NOMECLI"	):Show()
				EndIf
				cNumPed := NUM
				cNumCli := CLIENTE
				dData   := DATENTR

				oSecao:Cell("ITEM"		):Show()
				oSecao:Cell("PRODUTO1"	):Show()
				oSecao:Cell("PRODUTO2"	):Show()
				oSecao:Cell("DESCRICAO"	):Show()
			OtherWise	  											// Por Vendedor
				oSecao:Cell("VENDEDOR"	):Show()				
				oSecao:Cell("NOMEVEN"	):Show()				
				oSecao:Cell("NUM"		):Show()
				oSecao:Cell("ITEM"		):Show()
				oSecao:Cell("EMISSAO"	):Show()
				oSecao:Cell("PRODUTO1"	):Show()
				oSecao:Cell("PRODUTO2"	):Show()
				oSecao:Cell("DESCRICAO"	):Show()
				oSecao:Cell("DATENTR"	):Show()
		EndCase
		
		IF nFirst = 0 .And. nSection != 4
			nFirst := 1
		Endif
		
	Else

		Do Case
			Case nSection = 1    				// Por Pedido
				oSecao:Cell("NUM"		):Hide()
				oSecao:Cell("EMISSAO"	):Hide()
				oSecao:Cell("CLIENTE"	):Hide()
				oSecao:Cell("LOJA"		):Hide()
				oSecao:Cell("NOMECLI"	):Hide()
				oSecao:Cell("ITEM"		):Show()
				oSecao:Cell("PRODUTO1"	):Show()
				oSecao:Cell("PRODUTO2"	):Show()
				oSecao:Cell("DESCRICAO"	):Show()
				oSecao:Cell("DATENTR"	):Show()
			Case nSection = 2					// Pro Produto
				oSecao:Cell("PRODUTO1"	):Hide()
				oSecao:Cell("PRODUTO2"	):Hide()
				oSecao:Cell("DESCRICAO"	):Hide()
				oSecao:Cell("NUM"		):Show()
				oSecao:Cell("ITEM"		):Show()
				oSecao:Cell("EMISSAO"	):Show()
				oSecao:Cell("DATENTR"	):Show()
				oSecao:Cell("CLIENTE"	):Show()
				oSecao:Cell("LOJA"		):Show()
				oSecao:Cell("NOMECLI"	):Show()
			Case nSection = 3					// Por Cliente
				oSecao:Cell("CLIENTE"	):Hide()
				oSecao:Cell("LOJA"		):Hide()
				oSecao:Cell("NOMECLI"	):Hide()
				oSecao:Cell("NUM"		):Show()
				oSecao:Cell("ITEM"		):Show()
				oSecao:Cell("EMISSAO"	):Show()
				oSecao:Cell("PRODUTO1"	):Show()
				oSecao:Cell("PRODUTO2"	):Show()
				oSecao:Cell("DESCRICAO"	):Show()
				oSecao:Cell("DATENTR"	):Show()
			Case nSection = 4					// Por Data de Entrega
				If cNumPed+cNumCli+DtoS(dData) == NUM+CLIENTE+DtoS(DATENTR)
					oSecao:Cell("DATENTR"	):Hide()
					oSecao:Cell("NUM"		):Hide()
					oSecao:Cell("EMISSAO"	):Hide()
					oSecao:Cell("CLIENTE"	):Hide()
					oSecao:Cell("LOJA"		):Hide()
					oSecao:Cell("NOMECLI"	):Hide()
				Else
					oSecao:Cell("DATENTR"	):Show()
					oSecao:Cell("NUM"		):Show()
					oSecao:Cell("EMISSAO"	):Show()
					oSecao:Cell("CLIENTE"	):Show()
					oSecao:Cell("LOJA"		):Show()
					oSecao:Cell("NOMECLI"	):Show()
				EndIf
				cNumPed := NUM
				cNumCli := CLIENTE
				dData   := DATENTR
				
				oSecao:Cell("ITEM"		):Show()
				oSecao:Cell("PRODUTO1"	):Show()
				oSecao:Cell("PRODUTO2"	):Show()
				oSecao:Cell("DESCRICAO"	):Show()
			OtherWise												// Por Vendedor
				oSecao:Cell("VENDEDOR"	):Hide()
				oSecao:Cell("NOMEVEN"	):Hide()
				oSecao:Cell("NUM"		):Show()
				oSecao:Cell("ITEM"		):Show()
				oSecao:Cell("EMISSAO"	):Show()
				oSecao:Cell("PRODUTO1"	):Show()
				oSecao:Cell("PRODUTO2"	):Show()
				oSecao:Cell("DESCRICAO"	):Show()
				oSecao:Cell("DATENTR"	):Show()
		EndCase
	
	EndIf

	oSecao:PrintLine()

	dbSelectArea("TRB")
	dbSkip()
	oReport:IncMeter()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o Total do Pedido                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If NUM <> cNum
       If   nSection = 3 .Or.	nSection = 4 .Or.	nSection = 1
			oSecao:SetTotalText(STR0031 + " " + cNum)
			oSecao:Finish()
			oSecao:Init()
       EndIf
    EndIf
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o Total ou linha divisora conforme a quebra		     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !&cQuebra
			
		nTotVen := 0
		nTotEnt := 0
		nFirst  := 0   

		oSecao:SetTotalText(IIF(nSection == 1,STR0031 + " " + cNum,	;	// "Total do Pedido"
								IIF(nSection==2,STR0032 + " " + cProduto,;					// "Total do Produto"
								IIF(nSection==3,STR0033 + " " + cCli,;					// "Total do Cliente"
								IIF(nSection==4,STR0034 + " " + DTOC(dEntreg),STR0035  + " " + cVde)))))		// "Total da Dt.Entrega"###"Total do Vendedor"
		
		// Finaliza Secao
		If nSection <> 3 .And. nSection <> 4 .And. nSection <> 1
			oSecao:Finish()
			oSecao:Init()
		EndIf
			
		If MV_PAR15 = 1 .And. !Eof()
			// Forca salto de pagina no fim da secao
			oReport:nrow := 5000			
			oReport:skipLine()
		EndIf
				
	Endif
	
	dbSelectArea("TRB")
	
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza Relatorio                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecao:SetPageBreak()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha tabela de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If( Valtype(oTempTable) == "O" )
	DBSelectArea("TRB")
	oTempTable:Delete()
	FreeObj(oTempTable)
	oTempTable := nil
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura Tabelas                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea(cAliasQry)
dbClosearea()
dbSelectArea("SC6")
dbSetOrder(1)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³TR680Trab ³ Autor ³ Marco Bianchi         ³ Data ³ 05/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria Arquivo de Trabalho                             	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ MATR680													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function TR680Trab(oReport,cAliasQry,nSection,oSecao)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aArea			:= GetArea()
Local aCampos   	:= {}
Local aStruSC6		:= SC6->(dbStruct())
Local aTam      	:= ""
Local cVend     	:= ""
Local cVendedor 	:= ""
Local nTipVal   	:= IIF(cPaisLoc == "BRA",MV_PAR19,MV_PAR20)
Local nSaldo    	:= 0
Local nX        	:= 0
Local nQtdVend  	:= FA440CntVen() // Retorna a quantidade maxima de Vendedores
Local nValor		:= 0 
Local cFilSA1		:= ""
Local cFilSA3		:= ""
Local cFilSF4		:= ""
Local cFilSC6		:= ""
Local cQuery		:= ""
Local cQueryAdd 	:= ""
Local cWhere		:= "" 
Local cFieldsQry	:= ""
Local cFilialSA1	:= ""
Local cFilialSA3	:= ""
Local cFilialSC5	:= ""
Local cFilialSC6	:= ""
Local cFilialSF4	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array para arquivo de trabalho                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("C6_FILIAL")
AADD(aCampos,{ "FILIAL"    ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_NUM")
AADD(aCampos,{ "NUM"       ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_EMISSAO")
AADD(aCampos,{ "EMISSAO"   ,"D",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_CLI")
AADD(aCampos,{ "CLIENTE"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_NOME")
AADD(aCampos,{ "NOMECLI"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_LOJA")
AADD(aCampos,{ "LOJA"      ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_VEND1")
AADD(aCampos,{ "VENDEDOR"  ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A3_NOME")
AADD(aCampos,{ "NOMEVEN"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_ENTREG")
AADD(aCampos,{ "DATENTR"   ,"D",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_ITEM")
AADD(aCampos,{ "ITEM"      ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_PRODUTO")
AADD(aCampos,{ "PRODUTO"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_DESCRI")
AADD(aCampos,{ "DESCRICAO" ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_QTDVEN")
AADD(aCampos,{ "QUANTIDADE","N",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_QTDENT")
AADD(aCampos,{ "ENTREGUE"  ,"N",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_GRADE")
AADD(aCampos,{ "GRADE"     ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_ITEMGRD")
AADD(aCampos,{ "ITEMGRD"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_TES")
AADD(aCampos,{ "TES"       ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_BLQ")
AADD(aCampos,{ "BLQ"       ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_BLOQUEI")
AADD(aCampos,{ "BLOQUEI"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_VALOR")
AADD(aCampos,{ "VALOR"   ,"N",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_MOEDA")
AADD(aCampos,{ "MOEDA"   ,"N",aTam[1],aTam[2] } )
AADD(aCampos,{ "SDATA"   ,"C",8 , 0 } )

If len(oSecao:GetAdvplExp("SA1")) > 0
	cFilSA1 := oSecao:GetAdvplExp("SA1")
EndIf
If len(oSecao:GetAdvplExp("SA3")) > 0
	cFilSA3 := oSecao:GetAdvplExp("SA3")
EndIf
If len(oSecao:GetAdvplExp("SF4")) > 0
	cFilSF4 := oSecao:GetAdvplExp("SF4")
EndIf
If len(oSecao:GetAdvplExp("SC6")) > 0
	cFilSC6 := oSecao:GetAdvplExp("SC6")
EndIf

//-------------------------------------------------------------------
// Instancia tabela temporária.  
//-------------------------------------------------------------------

oTempTable	:= FWTemporaryTable():New( "TRB" )

//-------------------------------------------------------------------
// Atribui o  os índices.  
//-------------------------------------------------------------------
oTempTable:SetFields( aCampos )

Do Case
	Case nSection = 1
		oTempTable:AddIndex("1",{"FILIAL","NUM","ITEM","PRODUTO"})
	Case nSection = 2
		oTempTable:AddIndex("1",{"FILIAL","PRODUTO","NUM","ITEM"})
	Case nSection = 3
		oTempTable:AddIndex("1",{"FILIAL","CLIENTE","LOJA","NUM","ITEM"})
	Case nSection = 4
		oTempTable:AddIndex("1",{"FILIAL","SDATA","NUM","ITEM"})
	Case nSection = 5
		oTempTable:AddIndex("1",{"FILIAL","VENDEDOR","NUM","ITEM"})
EndCase

//------------------
//Criação da tabela
//------------------
oTempTable:Create()

dbSelectArea("TRB")
dbSetOrder(1)
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o Filtro                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC6")
dbSetOrder(1)
If mv_par13 == 3
	cWhere += "AND C6_BLQ = 'R '"
Endif	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ponto de entrada para tratamento do filtro do usuario.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("F680QRY")
	cQueryAdd := ExecBlock("F680QRY", .F., .F., {cFilSC6})
	If ValType(cQueryAdd) == "C"
		cWhere += " AND ( " + cQueryAdd + ")"
	EndIf
EndIf

cFilialSA1	:= xFilial("SA1")
cFilialSA3	:= xFilial("SA3")
cFilialSC5	:= xFilial("SC5")
cFilialSC6	:= xFilial("SC6")
cFilialSF4	:= xFilial("SF4")

cFieldsQry	:= GetFields('SC6' /*cAlias*/, .F. /*lMemo*/, aStruSC6)

cQuery		:= "SELECT " + cFieldsQry + " " +;
                 "FROM " + RetSqlName("SC6") + " SC6 " +;
                "WHERE SC6.C6_FILIAL = '" + cFilialSC6 + "' " +;
			      "AND SC6.C6_NUM >= '" + MV_PAR01 + "' AND SC6.C6_NUM <= '" + MV_PAR02 + "' " +;
                  "AND SC6.C6_PRODUTO >= '" + MV_PAR03 + "' AND SC6.C6_PRODUTO <= '" + MV_PAR04 + "' " +;
                  "AND SC6.C6_CLI >= '" + MV_PAR05 + "' AND SC6.C6_CLI <= '" + MV_PAR06 + "' " +;
                  "AND SC6.C6_ENTREG >= '" + DtoS(MV_PAR07) + "' AND SC6.C6_ENTREG <= '" + DtoS(MV_PAR08) + "' " +;
                  "AND SC6.D_E_L_E_T_ = ' ' " +;
                  cWhere + " " +;
			    "ORDER BY SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_ITEM,SC6.C6_PRODUTO"

cQuery		:= ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)
For nX := 1 To Len(aStruSC6)
	If ( aStruSC6[nX][2] <> "C" )
		TcSetField(cAliasQry, aStruSC6[nX][1], aStruSC6[nX][2], aStruSC6[nX][3], aStruSC6[nX][4])
	EndIf
Next nX

oReport:SetMeter(RecCount())     // Total de Elementos da Regua
While !oReport:Cancel() .And. (cAliasQry)->(!Eof())
	
	If !Empty(cFilSC6) .And. !(&cFilSC6)
		dbSelectArea(cAliasQry)	
   		dbSkip()
		Loop
	EndIf
	
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(cFilialSA1 + (cAliasQry)->C6_CLI + (cAliasQry)->C6_LOJA )
   
	// Verifica filtro do usuario
	If !Empty(cFilSA1) .And. !(&cFilSA1)
		dbSelectArea(cAliasQry)	
	   	dbSkip()
		Loop
	EndIf	

	dbSelectArea("SF4")
	dbSetOrder(1)
	dbSeek(cFilialSF4 + (cAliasQry)->C6_TES )

	// Verifica filtro do usuario	
	If !Empty(cFilSF4) .And. !(&cFilSF4)
		dbSelectArea(cAliasQry)	
	   	dbSkip()
		Loop
	EndIf	
	
	dbSelectArea("SC5")
	dbSetOrder(1)
	dbSeek(cFilialSC5 + (cAliasQry)->C6_NUM )
	
	dbSelectArea(cAliasQry)
	If cPaisLoc <> "BRA"
		If ( SF4->F4_ESTOQUE == "S" .And. mv_par18 == 2 ) .Or. ( SF4->F4_ESTOQUE!= "S" .And. mv_par18 == 1 )
			dbSkip()
			Loop
		Endif
		If mv_par19 <> 4 .And. SC5->(FIELDPOS("C5_DOCGER")) > 0
			If (mv_par19 == 1 .And. SC5->C5_DOCGER <> '1' ) .Or.;		// Gera nota
				(mv_par19 == 2 .And. SC5->C5_DOCGER <> '2' ) .Or.;		// Gera REMITO
				(mv_par19 == 3 .And. SC5->C5_DOCGER <> '3' ) 			// Entrega futura
				dbSkip()
				Loop
			Endif
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se esta dentro dos parametros						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lRet:=ValidMasc((cAliasQry)->C6_PRODUTO,MV_PAR11)
	If Alltrim((cAliasQry)->C6_BLQ) == "R" .and. mv_par13 == 2 // Se Foi Eliminado Residuos
		nSaldo  := 0
	Else
		nSaldo  := C6_QTDVEN-C6_QTDENT
	Endif
	
	If ((C6_QTDENT < C6_QTDVEN .And. MV_PAR09 == 1) .Or. (MV_PAR09 == 2)) .And. ((nSaldo == 0 .And. MV_PAR14 == 1 .And. Alltrim((cAliasQry)->C6_BLQ)<>"R") .Or. nSaldo <> 0) .And. ((SF4->F4_DUPLIC == "S" .And. MV_PAR10 == 1) .Or. (SF4->F4_DUPLIC == "N" .And. MV_PAR10 == 2) .Or. (MV_PAR10 == 3)).And. At(SC5->C5_TIPO,"DB") = 0 .And. lRet
		
		If nSection = 5		// Por Vendedor
			
			cVend := "1"
			For nX := 1 to nQtdVend
				cVendedor := SC5->(FieldGet(FieldPos("C5_VEND"+cVend)))
				If !EMPTY(cVendedor) .And. (cVendedor >= MV_PAR16 .And. cVendedor <= MV_PAR17 )
					
					dbSelectArea("SA3")
					dbSetOrder(1)
					dbSeek(cFilialSA3 + cVendedor)

					// Verifica filtro do usuario					
					If (Empty(cFilSA3)) .Or. (!Empty(cFilSA3) .And. (&cFilSA3))
					
						dbSelectArea("TRB")
						RecLock("TRB",.T.)
					
						Replace VENDEDOR   With cVendedor
						Replace NOMEVEN    With SA3->A3_NOME
						Replace FILIAL     With (cAliasQry)->C6_FILIAL
						Replace NUM        With (cAliasQry)->C6_NUM
						Replace EMISSAO    With SC5->C5_EMISSAO
						Replace CLIENTE    With (cAliasQry)->C6_CLI
						Replace NOMECLI    With SA1->A1_NOME
						Replace LOJA       With (cAliasQry)->C6_LOJA
						Replace DATENTR    With (cAliasQry)->C6_ENTREG
						Replace SDATA      With DtoS((cAliasQry)->C6_ENTREG)
						Replace ITEM       With (cAliasQry)->C6_ITEM
						Replace PRODUTO    With (cAliasQry)->C6_PRODUTO
						Replace DESCRICAO  With (cAliasQry)->C6_DESCRI
						Replace QUANTIDADE With (cAliasQry)->C6_QTDVEN
						Replace ENTREGUE   With (cAliasQry)->C6_QTDENT
						Replace GRADE      With (cAliasQry)->C6_GRADE
						Replace ITEMGRD    With (cAliasQry)->C6_ITEMGRD
						Replace TES        With (cAliasQry)->C6_TES
						Replace BLQ        With (cAliasQry)->C6_BLQ
						Replace BLOQUEI    With (cAliasQry)->C6_BLOQUEI
					
						If nTipVal == 1 //--  Imprime Valor Total do Item
							nValor:=(cAliasQry)->C6_VALOR
						Else
							//--  Imprime Saldo
							If TRB->QUANTIDADE==0
								nValor:=(cAliasQry)->C6_VALOR
							Else
								nValor := (TRB->QUANTIDADE - TRB->ENTREGUE) * (cAliasQry)->C6_PRCVEN
								nValor := If(nValor<0,0,nValor)
							EndIf
						EndIf
						Replace VALOR      With nValor
						Replace MOEDA      With SC5->C5_MOEDA
					
						MsUnLock()
					
					EndIf
					
				Endif
				
				cVend := Soma1(cVend,1)
				dbSelectArea("SC5")
				dbSetOrder(1)
			Next nX
			
		Else
			
			lVend := .F.
			cVend := "1"
			For nX := 1 to nQtdVend
				cVendedor := SC5->(FieldGet(FieldPos("C5_VEND"+cVend)))			
				dbSelectArea("SA3")
				dbSetOrder(1)
				dbSeek(cFilialSA3 + cVendedor)
				
				// Verifica filtro do usuario					
				If (Empty(cFilSA3)) .Or. (!Empty(cFilSA3) .And. (&cFilSA3))
					If (cVendedor >= MV_PAR16 .And. cVendedor <= MV_PAR17 )
						lVend :=.T.
						Exit
					Endif
				Endif
				cVend := Soma1(cVend,1)
			Next nX

			If lVend
				
				dbSelectArea("TRB")
				RecLock("TRB",.T.)
				
				Replace FILIAL     With (cAliasQry)->C6_FILIAL
				Replace NUM        With (cAliasQry)->C6_NUM
				Replace EMISSAO    With SC5->C5_EMISSAO
				Replace CLIENTE    With (cAliasQry)->C6_CLI
				Replace NOMECLI    With SA1->A1_NOME
				Replace LOJA       With (cAliasQry)->C6_LOJA
				Replace DATENTR    With (cAliasQry)->C6_ENTREG
				Replace SDATA      With DTOS((cAliasQry)->C6_ENTREG)
				Replace ITEM       With (cAliasQry)->C6_ITEM
				Replace PRODUTO    With (cAliasQry)->C6_PRODUTO
				Replace DESCRICAO  With (cAliasQry)->C6_DESCRI
				Replace QUANTIDADE With (cAliasQry)->C6_QTDVEN
				Replace ENTREGUE   With (cAliasQry)->C6_QTDENT
				Replace GRADE      With (cAliasQry)->C6_GRADE
				Replace ITEMGRD    With (cAliasQry)->C6_ITEMGRD
				Replace TES        With (cAliasQry)->C6_TES
				Replace BLQ        With (cAliasQry)->C6_BLQ
				Replace BLOQUEI    With (cAliasQry)->C6_BLOQUEI
				Replace VENDEDOR   With cVendedor
				If nTipVal == 1 //--  Imprime Valor Total do Item
					nValor:=(cAliasQry)->C6_VALOR
				Else
					//--  Imprime Saldo
					If TRB->QUANTIDADE==0
						nValor:=(cAliasQry)->C6_VALOR
					Else
						nValor := (TRB->QUANTIDADE - TRB->ENTREGUE) * (cAliasQry)->C6_PRCVEN
						nValor := If(nValor<0,0,nValor)
					EndIf
				EndIf
				Replace VALOR      With nValor
				Replace MOEDA      With SC5->C5_MOEDA
				
				lVend := .F.
				MsUnLock()
			Endif
		Endif
	Endif
	
	dbSelectArea(cAliasQry)
	dbSkip()
	oReport:IncMeter()
	
EndDo
RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ MATR680R3³ Autor ³ Alexandre Inacio Lemes³ Data ³ 15.03.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Pedidos nao entregues							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL. 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³	MOTIVO DA ALTERACAO					  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr680R3()

Local titulo    := OemToAnsi(STR0001)	//"Relacao de Pedidos nao entregues"
Local cDesc1    := OemToAnsi(STR0002)	//"Este programa ira emitir a relacao dos Pedidos Pendentes,"
Local cDesc2    := OemToAnsi(STR0003)	//"imprimindo o numero do Pedido, Cliente, Data da Entrega, "
Local cDesc3    := OemToAnsi(STR0004)	//"Qtde pedida, Qtde ja entregue,Saldo do Produto e atraso."
Local cString   := "SC6"
Local tamanho   := "G"
Local wnrel     := "MATR680"
Local aConfSched:= IIf(isBlind() .And. FWGetRunSchedule(), FWSchPrintCFG(),{})
Local aFieldsPD :={"A1_NOME"}

PRIVATE aReturn := { STR0005, 1,STR0006, 1, 2, 1, "", IIf(isBlind().And. FWGetRunSchedule(), aConfSched[4], 1) }      //"Zebrado"###"Administracao"
PRIVATE nTamRef := Val(Substr(GetMv("MV_MASCGRD"),1,2))
PRIVATE nomeprog:= "MATR680"
PRIVATE cPerg	 :=	IIf(cPaisLoc == "BRA","MTR680","MR680A")
PRIVATE cFilTrab:= ""
PRIVATE nLastKey:= 0

FATPDLoad(Nil, Nil, aFieldsPD)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas 				    	     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros		    			 ³
//³ mv_par01				// Do Pedido	                     ³
//³ mv_par02				// Ate o Pedido	                     ³
//³ mv_par03				// Do Produto				         ³
//³ mv_par04				// Ate o Produto					 ³
//³ mv_par05				// Do Cliente						 ³
//³ mv_par06				// Ate o cliente					 ³
//³ mv_par07				// Da data de entrega	    		 ³
//³ mv_par08				// Ate a data de entrega			 ³
//³ mv_par09				// Em Aberto , Todos 				 ³
//³ mv_par10				// C/Fatur.,S/Fatur.,Todos 			 ³
//³ mv_par11				// Mascara							 ³
//³ mv_par12				// Aglutina itens grade 			 ³
//³ mv_par13				// Considera Residuos (Sim/Nao)		 ³
//³ mv_par14				// Lista Tot.Faturados(Sim/Nao)		 ³
//³ mv_par15				// Salta pagina na Quebra(Sim/Nao)	     ³
//³ mv_par16				// Do vendedor                 		 ³
//³ mv_par17				// Ate o vendedor                    |
//³ mv_par18				// Qual a moeda                      |
//³ As proximas pertencem ao grupo MR680A que eh so para         |
//³ Localizacoes...                                     	     ³
//³ mv_par18				// Movimenta stock    (Sim/Nao)	     ³
//³ mv_par19		 // Gen. Doc (Factura/Remito/Ent. Fut/Todos) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT 					     ³
//| aOrd = Ordems Por Pedido/Produto/Cliente/Dt.Entrega/Vendedor |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aOrd :={STR0007,STR0008,STR0009,STR0010,STR0022}
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey==27
	dbClearFilter()
	Return
Endif  

SetDefault(aReturn,cString)

If nLastKey==27
	dbClearFilter()
	Return
Endif

RptStatus({|lEnd| C680Imp(@lEnd,wnRel,cString)},Titulo)
FATPDUnload()
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ C680IMP	³ Autor ³ Alexandre Incaio Lemes³ Data ³ 15.03.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio 									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ MATR680													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C680Imp(lEnd,WnRel,cString)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis   										     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local titulo    := OemToAnsi(STR0001)	//"Relacao de Pedidos nao entregues"
Local dData     := CtoD("  /  /  ")
Local cTotPed   := "NUM = cNum"
Local CbTxt     := ""
Local cabec1    := ""
Local cabec2    := ""
Local tamanho   := "G"
Local cNumPed   := ""
Local cNumCli   := ""
Local CbCont    := 0
Local nOrdem    := 0
Local nTotVen   := 0
Local nTotEnt   := 0
Local nTotSal   := 0
Local nTotItem  := 0
Local nFirst    := 0
Local nSaldo    := 0
Local nValor    := 0
Local nCont     := 0
Local lImpTot   := .F.
Local lContinua := .T.
Local nMoeda    := IIF(cPaisLoc == "BRA",MV_PAR18,1)
Local nTVGeral  := 0
Local nTEGeral  := 0
Local nTSGeral  := 0
Local nTIGeral  := 0
Local cCLIObfus  :=""
Local lCLIObfus  :=  FATPDIsObfuscate("A1_NOME")
Local cVENObfus  :=""
Local lVENObfus  :=  FATPDIsObfuscate("A3_NOME")

Private oTempTable 	:= Nil


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt   := SPACE(10)
cbcont  := 0
m_pag   := 1
li 	    := 80

nTipo   := IIF(aReturn[4]==1,15,18)
nOrdem  := aReturn[8]

Processa({|lEnd| C680Trb(@lEnd)},Titulo)

//                   999999 99/99/9999 999999xxxxxxxxxxxxxx/XXXXXXXX XX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX 99/99/9999 999999999999 999999999999 999999999999
//                             1         2         3         4         5         6         7         8         9        10        11        12        13
//                   012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
dbSelectArea("TRB")

Do Case
	Case nOrdem = 1
		cQuebra := "NUM = cNum"
		titulo  := titulo +" - "+ STR0007 //"Por Pedido"
		cabec1  := STR0011 //"NUMERO  DATA DE   CODIGO LOJA /NOME DO CLIENTE                       IT CODIGO DO       DESCRICAO DO                    DATA DE        QUANTIDADE   QUANTIDADE   QUANTIDADE      VALOR TOTAL "
		cabec2  := STR0012 //"PEDIDO  EMISSAO                                                         PRODUTO         MATERIAL                        ENTREGA        PEDIDA       ENTREGUE     PENDENTE        DO ITEM.    "    
	Case nOrdem = 2
		cQuebra := "PRODUTO = cProduto"
		titulo  := titulo + " - "+STR0008 //"Por Produto"
		cabec1  := STR0013 //"CODIGO DO       DESCRICAO DO                   NUMERO IT DATA DE      DATA DE      CODIGO LOJA /NOME DO CLIENTE                        QUANTIDADE   QUANTIDADE   QUANTIDADE      VALOR TOTAL "
		cabec2  := STR0014 //"PRODUTO         MATERIAL                       PEDIDO    EMISSAO      ENTREGA                                                          PEDIDA       ENTREGUE     PENDENTE        DO ITEM.    "
	Case nOrdem = 3
		cQuebra := "CLIENTE+LOJA = cCli"
		titulo  := titulo + " - "+STR0009 //"Por Cliente"
		cabec1  := STR0016 //"CODIGO-LOJA/NOME DO CLIENTE                        NUMERO IT  DATA DE      CODIGO DO       DESCRICAO DO                   DATA DE      QUANTIDADE   QUANTIDADE   QUANTIDADE      VALOR TOTAL "
		cabec2  := STR0017 //"                                                   PEDIDO     EMISSAO      PRODUTO         MATERIAL                       ENTREGA      PEDIDA       ENTREGUE     PENDENTE        DO ITEM.    "
	Case nOrdem = 4
		cQuebra := "DATENTR = dEntreg"
		titulo  := titulo + STR0018 //" - Por Data de Entrega"
		cabec1  := STR0019 //" DATA DE      NUMERO DATA DE      CODIGO LOJA /NOME DO CLIENTE                       IT CODIGO DO       DESCRICAO DO                   QUANTIDADE   QUANTIDADE   QUANTIDADE      VALOR TOTAL "
		cabec2  := STR0020 //" ENTREGA      PEDIDO EMISSAO                                                            PRODUTO         MATERIAL                       PEDIDA       ENTREGUE     PENDENTE        DO ITEM.    "
		
	Case nOrdem = 5
		cQuebra := "VENDEDOR = cVde"
		titulo  := titulo + STR0022 //" - Por Vendedor"
		cabec1  := STR0023 //"CODIGO VENDEDOR                                 NUMERO IT  DATA DE      CODIGO DO       DESCRICAO DO                   DATA DE         QUANTIDADE   QUANTIDADE   QUANTIDADE      VALOR TOTAL "
		cabec2  := STR0024 //"                                                PEDIDO     EMISSAO      PRODUTO         MATERIAL                       ENTREGA         PEDIDA       ENTREGUE     PENDENTE        DO ITEM.    "
EndCase

titulo += " - " + GetMv("MV_MOEDA"+STR(nMoeda,1))		//" MOEDA "
dbSelectArea("TRB")
dbGoTop()
SetRegua(RecCount())                    	// TOTAL DE ELEMENTOS DA REGUA

nFirst := 0

While !Eof() .And. lContinua
	If lCLIObfus .And. Empty(cCLIObfus)
				cCLIObfus:= FATPDObfuscate(NOMECLI,"A1_NOME")
	EndIf	
	If lVENObfus .And. Empty(cVENObfus)
				cVENObfus:= FATPDObfuscate(NOMEVEN,"A3_NOME")
	EndIf	
	
	IF lEnd
		@PROW()+1,001 Psay STR0021        //    "CANCELADO PELO OPERADOR"
		Exit
	Endif
	
	IF li > 58 .Or.( MV_PAR15 = 1 .And.!&cQuebra)
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica campo para quebra									 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNum	:= NUM
	cProduto:= PRODUTO
	cCli	:= CLIENTE+LOJA
	dEntreg := DATENTR
	cVde    := VENDEDOR
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis Totalizadoras     		    					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nSaldo  := QUANTIDADE-ENTREGUE
	nTotSal += nSaldo
	nTotVen += QUANTIDADE
	nTotEnt += ENTREGUE
    nValor  := xMoeda(VALOR,MOEDA,nMoeda,EMISSAO)
    
	If !(TRB->GRADE == "S" .And. MV_PAR12 == 1)
       nTotItem+= nValor
       nTIGeral+= nValor
    EndIf	
    
	If nTotVen > QUANTIDADE .Or. nTotEnt > ENTREGUE
		lImpTot := .T.
	Else
		lImpTot := .F.
	EndIf
	
	IF (nFirst = 0 .And. nOrdem != 4).Or. nOrdem == 4
		
		li++
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o cabecalho da linha		    					 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Do Case
			Case nOrdem = 1
				@li,  0 Psay NUM
				@li,  7 Psay TRB->EMISSAO
				If lCLIObfus .And. Empty(cCLIObfus)
					cCLIObfus:= FATPDObfuscate(TRB->NOMECLI,"A1_NOME")	
				EndIf
				@li, 18 Psay Left(CLIENTE+"-"+LOJA+"/"+ Iif(Empty(cCLIObfus),TRB->NOMECLI, cCLIObfus), 50)
							
			Case nOrdem = 2
				@li,  0 Psay IIF(GRADE=="S" .And. MV_PAR12 == 1,Substr(PRODUTO,1,nTamRef),PRODUTO)
				@li, 16 Psay Left(TRB->DESCRICAO, 30)
			Case nOrdem = 3
				@li,  0 Psay Left(CLIENTE+"-"+LOJA+"/"+Iif(Empty(cCLIObfus),NOMECLI, cCLIObfus), 50)
			Case nOrdem = 4
				If cNumPed+cNumCli+DtoS(dData) != NUM+CLIENTE+DtoS(DATENTR)
					@li,  1 Psay DATENTR
					@li, 14 Psay NUM
					@li, 21 Psay EMISSAO
					@li, 34 Psay Left(CLIENTE+"-"+LOJA+"/"+Iif(Empty(cCLIObfus),NOMECLI, cCLIObfus), 50)
					cNumPed := NUM
					cNumCli := CLIENTE
				Else
					li--
				EndIf
				dData := DATENTR
			Case nOrdem = 5
				@li,  0 Psay Left(TRB->VENDEDOR+" "+Iif(Empty(cCLIObfus),NOMEVEN, cCLIObfus), 47)
		EndCase
		
		IF nFirst = 0 .And. nOrdem != 4
			nFirst := 1
		Endif
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Agrutina os produtos da grade conforme o parametro MV_PAR12  |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF TRB->GRADE == "S" .And. MV_PAR12 == 1
		
		cProdRef:= Substr(TRB->PRODUTO,1,nTamRef)
		
		If nOrdem = 2
			cAgrutina := "cProdRef == Substr(PRODUTO,1,nTamRef)"
		Else
			cAgrutina := cQuebra
		Endif
		
		nSaldo  := 0
		nTotVen := 0
		nTotEnt := 0
		nTotSal := 0
        nValor  := 0
		nReg    := 0
		
		While !Eof() .And.xFilial("SC6") == TRB->FILIAL .And. cProdRef == Substr(PRODUTO,1,nTamRef);
			.And. TRB->GRADE == "S" .And. &cAgrutina .And. cNum == NUM
			
			nReg	 := Recno()
			
			nTotVen += QUANTIDADE
			nTotEnt += ENTREGUE
			nSaldo  += QUANTIDADE-ENTREGUE
    	    nValor  += xMoeda(VALOR,MOEDA,nMoeda,EMISSAO)
			
			dbSelectArea("TRB")
			IncRegua()
			dbSkip()
			
			lImpTot := .T.
			
		End
		
		nTotSal += nSaldo
        nTotItem+= nValor
		nTIGeral+= nValor
		If nReg > 0
			dbGoto(nReg)
			nReg :=0
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime a linha Conforme a ordem selecionada na setprint	 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Do Case
		Case nOrdem = 1
			@li, 69 Psay ITEM
			@li, 72 Psay IIF(GRADE=="S" .And. MV_PAR12 == 1,Substr(PRODUTO,1,nTamRef),PRODUTO)
			@li, 88 Psay Left(TRB->DESCRICAO, 30)
			@li,119 Psay DATENTR
		Case nOrdem = 2
			@li, 47 Psay NUM
			@li, 54 Psay ITEM
			@li, 57 Psay EMISSAO
			@li, 70 Psay DATENTR
			@li, 83 Psay Left(TRB->CLIENTE+"-"+LOJA+"/"+Iif(Empty(cCLIObfus),TRB->NOMECLI, cCLIObfus),50)
		Case nOrdem = 3
			@li, 51 Psay NUM
			@li, 58 Psay ITEM
			@li, 61 Psay EMISSAO
			@li, 74 Psay IIF(GRADE == "S" .And. MV_PAR12 == 1,Substr(PRODUTO,1,nTamRef),PRODUTO)
			@li, 91 Psay Left(TRB->DESCRICAO,30)
			@li,122 Psay DATENTR
		Case nOrdem = 4
			@li, 85 Psay ITEM
			@li, 88 Psay IIF(GRADE == "S" .And. MV_PAR12 == 1,Substr(PRODUTO,1,nTamRef),PRODUTO)
			@li,104 Psay Left(TRB->DESCRICAO, 30)
		OtherWise
			@li, 48 Psay NUM
			@li, 55 Psay ITEM
			@li, 59 Psay EMISSAO
			@li, 72 Psay IIF(GRADE == "S" .And. MV_PAR12 == 1,Substr(PRODUTO,1,nTamRef),PRODUTO)
			@li, 88 Psay Left(TRB->DESCRICAO,30)
			@li,119 Psay DATENTR
	EndCase
	
	@li,136 Psay IIF(GRADE=="S" .And. MV_PAR12 == 1,nTotVen,QUANTIDADE)	PICTURE PesqPictQt("C6_QTDVEN",12)
	@li,149 Psay IIF(GRADE=="S" .And. MV_PAR12 == 1,nTotEnt,ENTREGUE)	PICTURE PesqPictQt("C6_QTDENT",12)
	@li,162 Psay nSaldo	PICTURE PesqPictQt("C6_QTDVEN",12)
	@li,176 Psay nValor	PICTURE PesqPict("SC6","C6_VALOR",12)
	
	nCont++
	li++
	
	dbSelectArea("TRB")
	IncRegua()
	dbSkip()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o Total do Pedido                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If !&( cTotPed )
       If nOrdem = 1 .Or. nOrdem = 3 .Or.  nOrdem = 4 .Or. (nOrdem == 5 .And. !&cQuebra)
           @Li,000 Psay STR0025
           @Li,173 Psay nTotItem PICTURE PesqPict("SF2","F2_VALBRUT",16)
           If nOrdem = 3 
              li+=2
           Else
              li++
           ENdif
	       nTotitem:= 0	
       EndIf
    EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o Total ou linha divisora conforme a quebra		     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !&cQuebra
		
		If (MV_PAR15 = 1 .And. nOrdem = 2) .Or. MV_PAR15 = 2
			
			If nOrdem = 2
				@Li,000 Psay STR0025
				@Li,130 Psay nTotVen PICTURE PesqPict("SF2","F2_VALBRUT")
				@Li,146 Psay nTotEnt PICTURE PesqPict("SF2","F2_VALBRUT")
				@Li,162 Psay nTotSal PICTURE PesqPict("SF2","F2_VALBRUT")
				li++
			Endif
			
			If nTotVen > 0 .And. nOrdem != 1
				@li,  0 Psay __PrtThinLine()
				li++
			Endif
			
		Endif

		nTVGeral += nTotVen
		nTEGeral += nTotEnt
		nTSGeral += nTotSal
				
		nTotVen := 0
		nTotEnt := 0
		nTotSal := 0
		nCont   := 0
		nFirst  := 0
		
	Endif
	
End

If nTIGeral > 0        
	If li >= 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIf
	li++
	@Li,000 Psay STR0026
	@Li,125 Psay nTVGeral PICTURE PesqPict("SF2","F2_VALBRUT")
	@Li,141 Psay nTEGeral PICTURE PesqPict("SF2","F2_VALBRUT")
	@Li,157 Psay nTSGeral PICTURE PesqPict("SF2","F2_VALBRUT")
	@Li,173 Psay nTIGeral PICTURE PesqPict("SF2","F2_VALBRUT",16)
EndIf

If li != 80
	Roda(cbcont,cbtxt)
Endif


If( Valtype(oTempTable) == "O")
	DBSelectArea("TRB")
	oTempTable:Delete()
	FreeObj(oTempTable)
	oTempTable := nil
EndIf

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ C680TRB	³ Autor ³ Alexandre Inacio Lemes³ Data ³ 15.03.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria Arquivo de Trabalho                             	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ MATR660													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function C680TRB(nOrdem)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aCampos		:= {}
Local aStruSC6		:= {}
Local aTam			:= ""
Local cVend			:= ""
Local cVendedor		:= ""
Local cAliasSC6		:= "SC6"
Local cPedIni		:= MV_PAR01
Local cPedFim		:= MV_PAR02
Local cProIni		:= MV_PAR03
Local cProFim		:= MV_PAR04
Local cCliIni		:= MV_PAR05
Local cCliFim		:= MV_PAR06
Local cDatIni		:= MV_PAR07
Local cDatFim		:= MV_PAR08
Local nTipVal		:= IIF(cPaisLoc == "BRA",MV_PAR19,MV_PAR20)
Local nSaldo		:= 0
Local nX			:= 0
Local nQtdVend		:= FA440CntVen() // Retorna a quantidade maxima de Vendedores
Local nValor		:= 0
Local cQueryAdd		:= ""
Local cFieldsQry	:= ""
Local cFilialSA1	:= ""
Local cFilialSA3	:= ""
Local cFilialSC5	:= ""
Local cFilialSC6	:= ""
Local cFilialSF4	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array para arquivo de trabalho                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("C6_FILIAL")
AADD(aCampos,{ "FILIAL"    ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_NUM")
AADD(aCampos,{ "NUM"       ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_EMISSAO")
AADD(aCampos,{ "EMISSAO"   ,"D",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_CLI")
AADD(aCampos,{ "CLIENTE"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_NOME")
AADD(aCampos,{ "NOMECLI"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_LOJA")
AADD(aCampos,{ "LOJA"      ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_VEND1")
AADD(aCampos,{ "VENDEDOR"  ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A3_NOME")
AADD(aCampos,{ "NOMEVEN"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_ENTREG")
AADD(aCampos,{ "DATENTR"   ,"D",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_ITEM")
AADD(aCampos,{ "ITEM"      ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_PRODUTO")
AADD(aCampos,{ "PRODUTO"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_DESCRI")
AADD(aCampos,{ "DESCRICAO" ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_QTDVEN")
AADD(aCampos,{ "QUANTIDADE","N",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_QTDENT")
AADD(aCampos,{ "ENTREGUE"  ,"N",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_GRADE")
AADD(aCampos,{ "GRADE"     ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_ITEMGRD")
AADD(aCampos,{ "ITEMGRD"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_TES")
AADD(aCampos,{ "TES"       ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_BLQ")
AADD(aCampos,{ "BLQ"       ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_BLOQUEI")
AADD(aCampos,{ "BLOQUEI"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_VALOR")
AADD(aCampos,{ "VALOR"   ,"N",aTam[1],aTam[2] } ) 
aTam:=TamSX3("C5_MOEDA")
AADD(aCampos,{ "MOEDA"   ,"N",aTam[1],aTam[2] } )
AADD(aCampos,{ "SDATA"   ,"C",8 , 0 } )

//-------------------------------------------------------------------
// Instancia tabela temporária.  
//-------------------------------------------------------------------
oTempTable	:= FWTemporaryTable():New( "TRB" )

//-------------------------------------------------------------------
// Atribui o  os índices.  
//-------------------------------------------------------------------
oTempTable:SetFields( aCampos )

nOrdem  := aReturn[8]

Do Case
	Case nOrdem = 1
		oTempTable:AddIndex("1",{"FILIAL","NUM","ITEM","PRODUTO"})
	Case nOrdem = 2
		oTempTable:AddIndex("1",{"FILIAL","PRODUTO","NUM","ITEM"})
	Case nOrdem = 3
		oTempTable:AddIndex("1",{"FILIAL","CLIENTE","LOJA","NUM","ITEM"})
	Case nOrdem = 4
		oTempTable:AddIndex("1",{"FILIAL","SDATA","NUM","ITEM"})
	Case nOrdem = 5
		oTempTable:AddIndex("1",{"FILIAL","VENDEDOR","NUM","ITEM"})
EndCase

//------------------
//Criação da tabela
//------------------
oTempTable:Create()

dbSelectArea("TRB")
dbSetOrder(1)
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o Filtro                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC6")
dbSetOrder(1)

cAliasSC6 := "MR680Trab"
aStruSC6  := SC6->(dbStruct())

cFilialSA1	:= xFilial("SA1")
cFilialSA3	:= xFilial("SA3")
cFilialSC5	:= xFilial("SC5")
cFilialSC6	:= xFilial("SC6")
cFilialSF4	:= xFilial("SF4")

cFieldsQry	:= GetFields('SC6' /*cAlias*/, .F. /*lMemo*/, aStruSC6)

cQuery    := "SELECT " + cFieldsQry + " "
cQuery    += "FROM "+RetSqlName("SC6")+" SC6 "
cQuery    += "WHERE SC6.C6_FILIAL = '"+cFilialSC6+"' AND "
cQuery    += "SC6.C6_NUM >= '"+cPedIni+"' AND "
cQuery    += "SC6.C6_NUM <= '"+cPedFim+"' AND "
cQuery    += "SC6.C6_PRODUTO >= '"+cProIni+"' AND "
cQuery    += "SC6.C6_PRODUTO <= '"+cProFim+"' AND "
cQuery    += "SC6.C6_CLI >= '"+cCliIni+"' AND "
cQuery    += "SC6.C6_CLI <= '"+cCliFim+"' AND "
cQuery    += "SC6.C6_ENTREG >= '"+Dtos(cDatIni)+"' AND "
cQuery    += "SC6.C6_ENTREG <= '"+Dtos(cDatFim)+"' AND "
If mv_par13 == 3
	cQuery += "SC6.C6_BLQ = 'R ' AND "
Endif
cQuery += "SC6.D_E_L_E_T_ = ' ' "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ponto de entrada para tratamento do filtro do usuario.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("F680QRY")
	cQueryAdd := ExecBlock("F680QRY", .F., .F., {aReturn[7]})
	If ValType(cQueryAdd) == "C"
		cQuery += " AND ( " + cQueryAdd + ")"
	EndIf
EndIf

cQuery += "ORDER BY "+SqlOrder(IndexKey())

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC6,.T.,.T.)

For nX := 1 To Len(aStruSC6)
	If ( aStruSC6[nX][2] <> "C" )
		TcSetField(cAliasSC6,aStruSC6[nX][1],aStruSC6[nX][2],aStruSC6[nX][3],aStruSC6[nX][4])
	EndIf
Next nX

dbSelectArea(cAliasSC6)
ProcRegua(RecCount())                                         // Total de Elementos da Regua
While (cAliasSC6)->(!Eof())
	
	If ( Empty(aReturn[7]) .Or. &(aReturn[7]) )
		
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(cFilialSA1 + (cAliasSC6)->C6_CLI + (cAliasSC6)->C6_LOJA )
		
		dbSelectArea("SF4")
		dbSetOrder(1)
		dbSeek(cFilialSF4 + (cAliasSC6)->C6_TES )
		
		dbSelectArea("SC5")
		dbSetOrder(1)
		dbSeek(cFilialSC5 + (cAliasSC6)->C6_NUM )
		
		dbSelectArea(cAliasSC6)
		
		If cPaisLoc <> "BRA"
			If ( SF4->F4_ESTOQUE == "S" .And. mv_par18 == 2 ) .Or. ( SF4->F4_ESTOQUE!= "S" .And. mv_par18 == 1 )
				dbSkip()
				Loop
			Endif
			If mv_par19 <> 4 .And. SC5->(FIELDPOS("C5_DOCGER")) > 0
				If (mv_par19 == 1 .And. SC5->C5_DOCGER <> '1' ) .Or.;//Gera nota
					(mv_par19 == 2 .And. SC5->C5_DOCGER <> '2' ) .Or.;//Gera REMITO
					(mv_par19 == 3 .And. SC5->C5_DOCGER <> '3' ) //Entrega futura
					dbSkip()
					Loop
				Endif
			Endif
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se esta dentro dos parametros						 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lRet:=ValidMasc((cAliasSC6)->C6_PRODUTO,MV_PAR11)
		
		If Alltrim((cAliasSC6)->C6_BLQ) == "R" .and. mv_par13 == 2 // Se Foi Eliminado Residuos
			nSaldo  := 0
		Else
			nSaldo  := C6_QTDVEN-C6_QTDENT
		Endif
		
		If ((C6_QTDENT < C6_QTDVEN .And. MV_PAR09 == 1) .Or. (MV_PAR09 == 2)).And.;
			((nSaldo == 0 .And. MV_PAR14 == 1.And.Alltrim((cAliasSC6)->C6_BLQ)<>"R").Or. nSaldo <> 0).And.;
			((SF4->F4_DUPLIC == "S" .And. MV_PAR10 == 1) .Or. (SF4->F4_DUPLIC == "N";
			.And. MV_PAR10 == 2).Or.(MV_PAR10 == 3));
			.And. At(SC5->C5_TIPO,"DB") = 0 .And.lRet
			
			If nOrdem = 5
				
				cVend := "1"
				
				For nX := 1 to nQtdVend
					
					cVendedor := SC5->(FieldGet(FieldPos("C5_VEND"+cVend)))
					
					If !EMPTY(cVendedor) .And. (cVendedor >= MV_PAR16 .And. cVendedor <= MV_PAR17 )
						
						dbSelectArea("SA3")
						dbSetOrder(1)
						dbSeek(cFilialSA3 + cVendedor)
						
						dbSelectArea("TRB")
						RecLock("TRB",.T.)
						
						REPLACE VENDEDOR   WITH cVendedor
						REPLACE NOMEVEN    WITH SA3->A3_NOME
						REPLACE FILIAL     WITH (cAliasSC6)->C6_FILIAL
						REPLACE NUM        WITH (cAliasSC6)->C6_NUM
						REPLACE EMISSAO    WITH SC5->C5_EMISSAO
						REPLACE CLIENTE    WITH (cAliasSC6)->C6_CLI
						REPLACE NOMECLI    WITH SA1->A1_NOME
						REPLACE LOJA       WITH (cAliasSC6)->C6_LOJA
						REPLACE DATENTR    WITH (cAliasSC6)->C6_ENTREG
						REPLACE SDATA      WITH DtoS((cAliasSC6)->C6_ENTREG)
						REPLACE ITEM       WITH (cAliasSC6)->C6_ITEM
						REPLACE PRODUTO    WITH (cAliasSC6)->C6_PRODUTO
						REPLACE DESCRICAO  WITH (cAliasSC6)->C6_DESCRI
						REPLACE QUANTIDADE WITH (cAliasSC6)->C6_QTDVEN
						REPLACE ENTREGUE   WITH (cAliasSC6)->C6_QTDENT
						REPLACE GRADE      WITH (cAliasSC6)->C6_GRADE
						REPLACE ITEMGRD    WITH (cAliasSC6)->C6_ITEMGRD
						REPLACE TES        WITH (cAliasSC6)->C6_TES
						REPLACE BLQ        WITH (cAliasSC6)->C6_BLQ
						REPLACE BLOQUEI    WITH (cAliasSC6)->C6_BLOQUEI
						If nTipVal == 1 //--  Imprime Valor Total do Item
							nValor:=(cAliasSC6)->C6_VALOR						
						Else
							//--  Imprime Saldo
							If TRB->QUANTIDADE==0
								nValor:=(cAliasSC6)->C6_VALOR
							Else
								nValor := (TRB->QUANTIDADE - TRB->ENTREGUE) * (cAliasSC6)->C6_PRCVEN
								nValor := If(nValor<0,0,nValor)
							EndIf
						EndIf							
						REPLACE VALOR      WITH nValor
						REPLACE MOEDA      WITH SC5->C5_MOEDA
						
						MsUnLock()
						
					Endif
					
					cVend := Soma1(cVend,1)
					
					dbSelectArea("SC5")
					dbSetOrder(1)
					
				Next nX
				
			Else
				
				lVend := .F.
				cVend := "1"
				
				For nX := 1 to nQtdVend
					cVendedor := SC5->(FieldGet(FieldPos("C5_VEND"+cVend)))
					If (cVendedor >= MV_PAR16 .And. cVendedor <= MV_PAR17 )
						lVend :=.T.
						Exit
					Endif
					cVend := Soma1(cVend,1)
				Next nX
				
				If lVend
					
					dbSelectArea("TRB")
					RecLock("TRB",.T.)
					
					REPLACE FILIAL     WITH (cAliasSC6)->C6_FILIAL
					REPLACE NUM        WITH (cAliasSC6)->C6_NUM
					REPLACE EMISSAO    WITH SC5->C5_EMISSAO
					REPLACE CLIENTE    WITH (cAliasSC6)->C6_CLI
					REPLACE NOMECLI    WITH SA1->A1_NOME
					REPLACE LOJA       WITH (cAliasSC6)->C6_LOJA
					REPLACE DATENTR    WITH (cAliasSC6)->C6_ENTREG
					REPLACE SDATA      WITH DtoS((cAliasSC6)->C6_ENTREG)
					REPLACE ITEM       WITH (cAliasSC6)->C6_ITEM
					REPLACE PRODUTO    WITH (cAliasSC6)->C6_PRODUTO
					REPLACE DESCRICAO  WITH (cAliasSC6)->C6_DESCRI
					REPLACE QUANTIDADE WITH (cAliasSC6)->C6_QTDVEN
					REPLACE ENTREGUE   WITH (cAliasSC6)->C6_QTDENT
					REPLACE GRADE      WITH (cAliasSC6)->C6_GRADE
					REPLACE ITEMGRD    WITH (cAliasSC6)->C6_ITEMGRD
					REPLACE TES        WITH (cAliasSC6)->C6_TES
					REPLACE BLQ        WITH (cAliasSC6)->C6_BLQ
					REPLACE BLOQUEI    WITH (cAliasSC6)->C6_BLOQUEI
					If nTipVal == 1 //--  Imprime Valor Total do Item
						nValor:=(cAliasSC6)->C6_VALOR						
					Else
						//--  Imprime Saldo
						If TRB->QUANTIDADE==0
							nValor:=(cAliasSC6)->C6_VALOR
						Else
							nValor := (TRB->QUANTIDADE - TRB->ENTREGUE) * (cAliasSC6)->C6_PRCVEN
							nValor := If(nValor<0,0,nValor)
						EndIf
					EndIf						
					REPLACE VALOR      WITH nValor
					REPLACE MOEDA      WITH SC5->C5_MOEDA
					
					lVend := .F.
					
					MsUnLock()
					
				Endif
				
			Endif
			
		Endif
		
	Endif
	
	dbSelectArea(cAliasSC6)
	IncProc()
	dbSkip()
	
End

dbSelectArea(cAliasSC6)
dbClosearea()
dbSelectArea("SC6")

Return Nil 


//-----------------------------------------------------------------------------
/*/{Protheus.doc} GetFields
    @description Busca os campos da Tabela SC6 para a montagem do Relatório
    @type  Function
    @sample GetFields()
    @author Squad CRM & Faturamento
    @since Mai/2021
    @version P12    
    @return aRet, Array, Array com os campos da Estrutura da Tabela
/*/
//-----------------------------------------------------------------------------
Static Function GetFields(cAlias, lMemo, aStruSC6)

Local nInd			:= 0
Local nQtdElem		:= 0
Local cRetFldQry	:= ''

Default cAlias		:= "SC6"
Default lMemo		:= .F.
Default aStruSC6	:= (cAlias)->(DbStruct())

nQtdElem	:= Len(aStruSC6)
For nInd := 1 to nQtdElem
	If  !lMemo .AND. aStruSC6[nInd,02] == "M"
		Loop
	EndIf
	cRetFldQry	+= IIf(!Empty(cRetFldQry), ',', '') + cAlias + '.' + AllTrim(aStruSC6[nInd,01])
Next nInd
Return cRetFldQry

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

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDIsObfuscate
    @description
    Verifica se um campo deve ser ofuscado, esta função deve utilizada somente após 
    a inicialização das variaveis atravez da função FATPDLoad.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cField, Caractere, Campo que sera validado
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado
    @return lObfuscate, Lógico, Retorna se o campo será ofuscado.
    @example FATPDIsObfuscate("A1_CGC",Nil,.T.)
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDIsObfuscate(cField, cSource, lLoad)
    
	Local lObfuscate := .F.

    If FATPDActive()
		lObfuscate := FTPDIsObfuscate(cField, cSource, lLoad)
    EndIf 

Return lObfuscate


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
