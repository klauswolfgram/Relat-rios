/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR700.CH" 
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR700  ³ Autor ³ Marco Bianchi         ³ Data ³ 07/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Pedidos aptos a faturar                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT - R4                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR700()

Local oReport
Local aFieldsPD :={}

If FindFunction("TRepInUse") .AND. TRepInUse()
	aFieldsPD :={"A1_NOME", "A2_NOME"}
	FATPDLoad(Nil, Nil, aFieldsPD)
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
	FATPDUnload()
	ASize(aFieldsPD, 0)
Else
	U_Matr700R3()
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 07/07/06 ³±±
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
Local oCabec
Local oPedaFat
Local oTemp
Local cVends    := "" 
Local cItem     := "" 
Local cProduto  := "" 
Local cDescricao:= "" 
Local nTotLocal	:= 0
Local nQtdVen	:= 0
Local nQtdEnt	:= 0
Local nQtLib	:= 0
Local nQtBloq	:= 0
Local nValDesc	:= 0
Local nPrcVen	:= 0
Local nImpLinha	:= 0
Local nTFat		:= 0
Local dEntreg	:= dDataBAse
Local cOP		:= ""
Local cDescTab	:= ""
Local nTamData  := Len(DTOC(MsDate()))
Local cAliasSC5  := ""
Local cAliasSC6  := "" 
Local cAliasSC9  := "" 
Local cAliasSF4  := ""

cAliasSF4 := GetNextAlias()	
cAliasSC9 := cAliasSF4
cAliasSC6 := cAliasSC9
cAliasSC5 := cAliasSC6

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
oReport := TReport():New("MATR700",STR0031,"MTR700", {|oReport| ReportPrint(oReport,oCabec,oPedaFat,oTemp,cAliasSC5,cAliasSC6,cAliasSC9,cAliasSF4)},STR0032 + " " + STR0033 + " " + STR0034)	// "Relacao de Pedidos de Vendas"###"Este programa ira emitir a relacao  dos Pedidos de Vendas"###"Sera feita a pesquisa no armazem e verificado"###"se a quantidade esta disponivel"
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
//³Secao de Cabecalho - Section(1)                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCabec := TRSection():New(oReport,STR0060,{"SC6","SC5"},{STR0043,STR0044,STR0045},/*Campos do SX3*/,/*Campos do SIX*/)	// "Relacao de Pedidos de Vendas"###"Pedido""Produto"###"Data de Entrega"
oCabec:SetTotalInLine(.F.)
oCabec:SetReadOnly() 

TRCell():New(oCabec,"C5_NUM"		,/*Tabela*/,STR0047					,PesqPict("SC5","C5_NUM")		,TamSx3("C5_NUM"		)[1]	,/*lPixel*/,{|| SC5->C5_NUM														                                             })
TRCell():New(oCabec,"C5_CLIENTE"	,/*Tabela*/," "                     ,PesqPict("SC5","C5_CLIENTE")	,16								,/*lPixel*/,{|| IIF( SC5->C5_TIPO$"BD",STR0048,STR0049) + SC5->C5_CLIENTE                                                    })
TRCell():New(oCabec,"C5_LOJA"		,/*Tabela*/,STR0050					,PesqPict("SC5","C5_LOJACLI")	,TamSx3("C5_LOJACLI"	)[1]	,/*lPixel*/,{|| SC5->C5_LOJACLI 													                                         })
TRCell():New(oCabec,"CNOME"		    ,/*Tabela*/,RetTitle("A1_NOME")	    ,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME"		)[1]	,/*lPixel*/,{|| FATPDObfuscate(IIF(SC5->C5_TIPO$"BD",SA2->A2_NOME,SA1->A1_NOME), IIF(SC5->C5_TIPO$"BD","A2_NOME","A1_NOME")) })
TRCell():New(oCabec,"C5_EMISSAO"	,/*Tabela*/,STR0051					,PesqPict("SC5","C5_EMISSAO")	,nTamData                       ,/*lPixel*/,{|| SC5->C5_EMISSAO                                                                                              },,,,,,.F.)
TRCell():New(oCabec,"C5_TRANS"	    ,/*Tabela*/,STR0052					,PesqPict("SC5","C5_TRANSP")	,TamSx3("C5_TRANSP"	)[1]        ,/*lPixel*/,{|| SC5->C5_TRANSP														                                         })
TRCell():New(oCabec,"CVENDS"		,/*Tabela*/,STR0053					,PesqPict("SC5","C5_VEND1")	    ,34							    ,/*lPixel*/,{|| cVends																		                                 })
TRCell():New(oCabec,"C5_CONDPAG"	,/*Tabela*/,STR0054					,PesqPict("SC5","C5_CONDPAG")	,TamSx3("C5_CONDPAG"	)[1]    ,/*lPixel*/,{|| SC5->C5_CONDPAG													                                             })
oReport:Section(1):SetLineStyle(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao de Itens - Section(1):Section(1)                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPedaFat := TRSection():New(oCabec,STR0061,{"SC6"},/*{STR0043,STR0044,STR0045}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Relacao de Pedidos de Vendas"###"Pedido""Produto"###"Data de Entrega"
oPedaFat:SetTotalInLine(.F.)
oPedaFat:SetReadOnly() 

TRCell():New(oPedaFat,"CITEM"		,/*Tabela*/,STR0035					,PesqPict("SC6","C6_ITEM"		),TamSx3("C6_ITEM"		)[1],/*lPixel*/,{|| cItem 				})	// "IT"
TRCell():New(oPedaFat,"CPRODUTO"	,/*Tabela*/,RetTitle("C6_PRODUTO")	,PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| cProduto 			})	// Codigo do Produto
TRCell():New(oPedaFat,"CDESCRICAO"	,/*Tabela*/,RetTitle("C6_DESCRI")	,PesqPict("SC6","C6_DESCRI"		),30						 ,/*lPixel*/,{|| cDescricao 		})	// Descricao do Produto
TRCell():New(oPedaFat,"NTOTLOCAL"	,/*Tabela*/,STR0036					,PesqPict("SB2","B2_QATU"		),TamSx3("B2_QATU"		)[1],/*lPixel*/,{|| nTotLocal 			},,,"RIGHT")	// "Estoque Disponivel"
TRCell():New(oPedaFat,"NQTDVEN"		,/*Tabela*/,STR0037					,PesqPict("SC6","C6_PRCVEN"		),TamSx3("C6_PRCVEN"	)[1],/*lPixel*/,{|| nQtdVen 			},,,"RIGHT")	// "Vendido"
TRCell():New(oPedaFat,"NQTDENT"		,/*Tabela*/,STR0038					,PesqPict("SC6","C6_PRCVEN"		),TamSx3("C6_PRCVEN"	)[1],/*lPixel*/,{|| nQtdEnt 			},,,"RIGHT")	// "Atendido"
TRCell():New(oPedaFat,"NSALDO"		,/*Tabela*/,STR0039					,PesqPict("SC6","C6_PRCVEN"		),TamSx3("C6_PRCVEN"	)[1],/*lPixel*/,{|| nQtdVen-nQtdEnt		},,,"RIGHT")	// "Saldo"
TRCell():New(oPedaFat,"NQTLIB"		,/*Tabela*/,RetTitle("C6_QTDLIB")	,PesqPict("SC6","C6_PRCVEN"		),TamSx3("C6_PRCVEN"	)[1],/*lPixel*/,{|| nQtLib				},,,"RIGHT")	// Quantidade Liberada
TRCell():New(oPedaFat,"NQTBLOQ"		,/*Tabela*/,STR0040					,PesqPict("SC6","C6_PRCVEN"		),TamSx3("C6_PRCVEN"	)[1],/*lPixel*/,{|| nQtBloq				},,,"RIGHT")	// "Qtd.Bloqueada"
TRCell():New(oPedaFat,"NVALDESC"	,/*Tabela*/,RetTitle("C6_VALDESC")	,PesqPict("SC6","C6_VALDESC"	),TamSx3("C6_VALDESC"	)[1],/*lPixel*/,{|| nValDesc			},,,"RIGHT")	// Valor do Desconto
TRCell():New(oPedaFat,"NPRCVEN"		,/*Tabela*/,RetTitle("C6_PRCVEN")	,PesqPict("SC6","C6_VALDESC"		),TamSx3("C6_VALDESC"		)[1] ,/*lPixel*/,{|| nPrcVen				},,,"RIGHT")	// Preco Unitario
TRCell():New(oPedaFat,"CDESCTAB"	,/*Tabela*/,STR0059					,								 ,28						 ,/*lPixel*/,{|| cOP+"-"+cDescTab	})	// Situacao do Pedido
TRCell():New(oPedaFat,"NIMPLINHA"	,/*Tabela*/,STR0041					,PesqPict("SC6","C6_VALDESC"		),TamSx3("C6_VALDESC"		)[1],/*lPixel*/ ,{|| nImpLinha			},,,"RIGHT")	// "Impostos"
TRCell():New(oPedaFat,"NTFAT"		,/*Tabela*/,STR0042					,PesqPict("SC6","C6_VALOR"		),TamSx3("C6_VALOR"		)[1],/*lPixel*/ ,{|| nTFat				},,,"RIGHT")	// "Valor a Entregar"

// Quando nome da celular nao e do SX3 e o campo for do tipo Data, o tamanho deve ser preenchido com
// Len(DTOC(MsDate())), para que nao haja problema na utilizacao de ano com 4 digitos.
TRCell():New(oPedaFat,"DENTREG"		,/*Tabela*/,RetTitle("C6_ENTREG")	,PesqPict("SC6","C6_ENTREG"		),nTamData				      ,/*lPixel*/ ,{|| dEntreg			},,,,,,.F.)	// Data de Entrega

TRFunction():New(oPedaFat:Cell("NQTDVEN"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oPedaFat:Cell("NQTDENT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oPedaFat:Cell("NSALDO"		),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oPedaFat:Cell("NQTLIB"		),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oPedaFat:Cell("NQTBLOQ"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oPedaFat:Cell("NVALDESC"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oPedaFat:Cell("NPRCVEN"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oPedaFat:Cell("NIMPLINHA"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oPedaFat:Cell("NTFAT"		),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
                                                
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Faz a quebra de linha para impressao da descricao do produto            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):SetLineBreak()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Cabecalho no top da pagina                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):SetHeaderPage()
                                                   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao temporaria para receber filtro da tabela SC9.                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTemp := TRSection():New(oReport,"",{"SC9"},{STR0043,STR0044,STR0045},/*Campos do SX3*/,/*Campos do SIX*/) // "Todos Pedidos"###"Relacao de Pedidos de Vendas"###"Pedido""Produto"###"Data de Entrega"
oTemp:SetTotalInLine(.F.)
oTemp:SetReadOnly()

oReport:Section(2):SetEdit(.F.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 07/07/06 ³±±
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
Static Function ReportPrint(oReport,oCabec,oPedaFat,oTemp,cAliasSC5,cAliasSC6,cAliasSC9,cAliasSF4)

Local cWhere	 := ""
Local cDescOrdem := ""
Local cTipo  	 := ""
Local cPedido    := ""
Local cFilter    := ""
Local cKey 	     := ""
Local cCampo     := ""
Local cVends     := ""
Local cNumero    := ""
Local cLocal     := ""
Local cTes       := ""
LOCAL cTmpTable  := GetNextAlias()
Local dC5Emissao := dDataBase
Local nOrdem 	 := oReport:Section(1):GetOrder()
Local nX	 	 := 1
Local nQtBloq	 := 0
Local nItem      := 0    
Local nC5Moeda   := 0    
Local nPos       := 0
Local nPrunit    := 0
Local nVldesc    := 0
Local nValIPI    := 0 
Local nAcresFin  := 0
Local nPacresFin := 0
Local nQuant     := 0
Local aQuant 	 := {}
Local aCampos	 := {}
Local aTam   	 := {}
Local aImpostos  := MaFisRelImp("MTR700",{"SC5","SC6"})
Local lContInt   := .T. 
Local lFiltro	 := .T.
Local lCabPed    := .T.
Local lBarra     := .F.
Local lImp 		 := .F.
Local cQueryAdd  := ""
Local cFilUsuSC5 := oReport:Section(1):GetSqlExp("SC5")
Local cFilUsuSC6 := oReport:Section(1):GetSqlExp("SC6")

Private oTempTable := Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SetBlock: faz com que as variaveis locais possam ser                   ³
//³ utilizadas em outras funcoes nao precisando declara-las                ³
//³ como private.                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Cell("CVENDS"):SetBlock({|| cVends			})
oReport:Section(1):Section(1):Cell("CITEM"			):SetBlock({|| cItem			})
oReport:Section(1):Section(1):Cell("CPRODUTO"		):SetBlock({|| cProduto			})
oReport:Section(1):Section(1):Cell("CDESCRICAO"	):SetBlock({|| cDescricao		})
oReport:Section(1):Section(1):Cell("NTOTLOCAL"		):SetBlock({|| nTotLocal		})
oReport:Section(1):Section(1):Cell("NQTDVEN"		):SetBlock({|| nQtdVen			})
oReport:Section(1):Section(1):Cell("NQTDENT"		):SetBlock({|| nQtdEnt			})
oReport:Section(1):Section(1):Cell("NSALDO"		):SetBlock({|| nQtdVen-nQtdEnt	})
oReport:Section(1):Section(1):Cell("NQTLIB"		):SetBlock({|| nQtLib			})
oReport:Section(1):Section(1):Cell("NQTBLOQ"		):SetBlock({|| nQtBloq			})
oReport:Section(1):Section(1):Cell("NVALDESC"		):SetBlock({|| nValDesc			})
oReport:Section(1):Section(1):Cell("NPRCVEN"		):SetBlock({|| nPrcVen			})
oReport:Section(1):Section(1):Cell("CDESCTAB"		):SetBlock({|| cOP+"-"+cDescTab	})
oReport:Section(1):Section(1):Cell("NIMPLINHA"		):SetBlock({|| nImpLinha		})
oReport:Section(1):Section(1):Cell("NTFAT"			):SetBlock({|| nTFat			})
oReport:Section(1):Section(1):Cell("DENTREG"		):SetBlock({|| dEntreg			})
cVends 		:= ""
cItem      	:= "" 
cProduto   	:= "" 
cDescricao 	:= "" 
nTotLocal	:= 0
nQtdVen		:= 0
nQtdEnt		:= 0
nQtLib		:= 0
nQtBloq		:= 0
nValDesc	:= 0
nPrcVen		:= 0
cOP			:= ""
cDescTab	:= ""
nImpLinha	:= 0
nTFat		:= 0
dEntreg		:= dDataBAse

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array com base no SB2 e Monta arquivo de trabalho     ³
//³ para baixar estoque na listagem.                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam	:= TamSX3("B2_LOCAL")
AADD(aCampos, {"TB_LOCAL", "C", aTam[1], aTam[2]})
aTam	:= TamSX3("B2_COD")
AADD(aCampos, {"TB_COD",   "C", aTam[1], aTam[2]})
aTam	:= TamSX3("B2_QATU")
AADD(aCampos, {"TB_SALDO", "N", aTam[1], aTam[2]})
aTam	:= {}

//-------------------------------------------------------------------
// Instancia tabela temporária.  
//-------------------------------------------------------------------
oTempTable	:= FWTemporaryTable():New(cTmpTable)

//-------------------------------------------------------------------
// Atribui o  os índices.  
//-------------------------------------------------------------------
oTempTable:SetFields( aCampos )
                                                           
oTempTable:AddIndex("1",{"TB_LOCAL","TB_COD"})

//------------------
//Criação da tabela
//------------------
oTempTable:Create()

dbSelectArea("SC6")
dbSetOrder(nOrdem) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                                        ³
//³                        Filtros do Relatorio                            ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQueryAdd := ""
			
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³                                                                                           ³
	//³ Montagem das variaveis da Query                                                           ³
	//³                                                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cWhere := "%"
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Trata o Relacionamento com C9 conforme a opcao do MV_PAR06 -> "IMPRIMIR PEDIDOS ?" ³
    //³ "IMPRIMIR PEDIDOS ?"                                                               ³
    //³ MV_PAR06 == 1 -> Pedidos Aptos a Faturar com C9 liberado.                          ³
    //³ MV_PAR06 == 2 -> Pedidos Nao Aptos a Faturar com C9 bloqueado no Credito ou Estoque³
    //³ MV_PAR06 == 3 -> Todos - pedidos liberados e bloqueados do C9 + os C6 sem os C9    ³
    //³ para MV_PAR06 == 3 o relacionamento com C9 na Query e feito atraves de UNION.      ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   	
If mv_par06 == 1
		cWhere += "SC9.C9_BLEST = '" + space(TamSx3("C9_BLEST")[1]) + "' AND "
		cWhere += "SC9.C9_BLCRED = '" + space(TamSx3("C9_BLCRED")[1]) + "' AND "
		cWhere += "SC9.C9_QTDLIB > 0 AND "
ElseIf mv_par06 == 2
		cWhere += "(SC9.C9_BLEST <> '" + space(TamSx3("C9_BLEST")[1]) + "' OR "
		cWhere += "SC9.C9_BLCRED <> '" + space(TamSx3("C9_BLCRED")[1]) + "') AND "
EndIf
If mv_par09 == 1
		cWhere += "SF4.F4_DUPLIC = 'S' AND "
ElseIf mv_par09 == 2
		cWhere += "SF4.F4_DUPLIC <> 'S' AND "
EndIf
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ponto de entrada para tratamento do filtro do usuario.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("F700QRY")
		cQueryAdd := ExecBlock("F700QRY", .F., .F.)
		If ValType(cQueryAdd) == "C" .AND. !Empty(cQueryAdd)
			cWhere += " ( " + cQueryAdd + ") AND"
		EndIf
EndIf
If !Empty(cFilUsuSC5)
		cWhere += " (" + cFilUsuSC5 + ") AND"
EndIf
If !Empty(cFilUsuSC6)
		cWhere += " (" + cFilUsuSC6 + ") AND"
EndIf
cWhere += "%"
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ ATENCAO !!!! ao manipular os campos do SELECT ou a ordem da Clausula ORDER BY verificar   ³
//³ a concordancia entre os mesmos !!!!!!!!!                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem = 1
		cDescOrdem:= STR0043	//	"Pedido"
		cOrder := "%C5_FILIAL,C5_NUM,C6_ITEM%"
ElseIf nOrdem = 2
		cDescOrdem:= STR0044	//	"Produto"
		cOrder :="%C6_FILIAL,C6_PRODUTO,C6_NUM%"
ELSE
		cDescOrdem:= STR0045	//	"Data de Entrega"
		cOrder := "%C6_FILIAL,C6_ENTREG,C5_NUM,C6_ITEM%"
EndIf

If mv_par06 == 3
		cWhere2 := "%"
		If mv_par09 == 1
			cWhere2 += "SF4.F4_DUPLIC = 'S' AND "
		ElseIf mv_par09 == 2
			cWhere2 += "SF4.F4_DUPLIC <> 'S' AND "
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Tratamento do filtro do usuario por PE.               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ValType(cQueryAdd) == "C" .AND. !Empty(cQueryAdd)
			cWhere2 += " ( " + cQueryAdd + ") AND"
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Tratamento do filtro do usuario por personalização.   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFilUsuSC5)
			cWhere2 += " (" + cFilUsuSC5 + ") AND"
		EndIf
		If !Empty(cFilUsuSC6)
			cWhere2 += " (" + cFilUsuSC6 + ") AND"
		EndIf	
		cWhere2 += "%"
EndIf	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Explicacoes da Query                                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³o Campo C9_QTDLIB e somado por haver varios C9 para cada C6.                          ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Agrupamento de todos os campos comuns do SELECT para que nos relacionamentos com     ³
    //³ C5,C6 e C9 com varios C9 para cada C6 gerem apenas um registro com o campo C9_QTDLIB ³
    //³ somado.                                                                              ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Quando o MV_PAR06 ==3 ->"TODOS OS PEDIDOS" esse UNION acrescenta a Query os registros³
    //³ do C6 que nao possuem C9.                                                            ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se mv_par06 == 3                                                                     ³
	//³ ATENCAO !!!! ao manipular os campos do SELECT ou a ordem da Clausula ORDER BY verifi-³
	//³ car a concordancia entre os mesmos !!!!!!!!!                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Para o uso de UNION a estrutura deste SELECT deve ser igual a do SELECT anterior     ³
    //³ note que a nomeclatura do C9 usa os mesmos nomes dos campos da TABELA, porem com o   ³
	//³ uso de ' ' para nao fazer referencia a ela.                                          ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par06 == 3

    	oReport:Section(1):BeginQuery()
    	BeginSql Alias cAliasSC5
		SELECT
		SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_EMISSAO,
		SC5.C5_CONDPAG,SC5.C5_MOEDA,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,
		SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PRODUTO,SC6.C6_DESCRI,SC6.C6_OP,SC6.C6_TES,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,
		SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_PRCVEN,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_LOCAL,SC6.C6_QTDENT,SC6.C6_BLQ,
		SC9.C9_FILIAL,SC9.C9_PEDIDO,SC9.C9_ITEM,SC9.C9_NFISCAL,SC9.C9_BLEST,SC9.C9_BLCRED,SC9.C9_PRODUTO,
		SUM(SC9.C9_QTDLIB) C9_QTDLIB,SF4.F4_FILIAL,SF4.F4_DUPLIC,SF4.F4_CODIGO,SC5.C5_ACRSFIN
		FROM %Table:SC5% SC5 ,%Table:SC6% SC6 ,%Table:SC9% SC9 ,%Table:SF4% SF4
		WHERE
			SC5.C5_FILIAL = %xFilial:SC5% AND SC5.C5_NUM >= %Exp:mv_par01% AND SC5.C5_NUM <= %Exp:mv_par02% AND
			SC5.%notdel% AND SC6.C6_FILIAL = %xFilial:SC6% AND SC6.C6_NUM   = SC5.C5_NUM AND
			SC6.C6_PRODUTO >= %Exp:mv_par03% AND
			SC6.C6_PRODUTO <= %Exp:mv_par04% AND
			SC6.C6_ENTREG  >= %Exp:dtos(mv_par10)% AND
			SC6.C6_ENTREG  <= %Exp:dtos(mv_par11)% AND
			SC6.C6_QTDVEN-SC6.C6_QTDENT > 0 AND SC6.C6_BLQ <> 'R ' AND SC6.%notdel% AND
			SC9.C9_FILIAL = %xFilial:SC9% AND SC9.C9_PEDIDO = SC6.C6_NUM AND SC6.C6_ITEM = SC9.C9_ITEM AND
			SC6.C6_PRODUTO = SC9.C9_PRODUTO AND SC9.C9_NFISCAL = ' ' AND SC9.%notdel% AND
			SF4.F4_FILIAL = %xFilial:SF4% AND
			SC6.C6_TES = SF4.F4_CODIGO AND
			%Exp:cWhere%    				
			SF4.%notdel%
	    GROUP BY
			SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_EMISSAO,
			SC5.C5_CONDPAG,SC5.C5_MOEDA,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,
			SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PRODUTO,SC6.C6_DESCRI,SC6.C6_OP,SC6.C6_TES,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,
			SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_PRCVEN,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_LOCAL,SC6.C6_QTDENT,SC6.C6_BLQ,
			SC9.C9_FILIAL,SC9.C9_PEDIDO,SC9.C9_ITEM,SC9.C9_NFISCAL,SC9.C9_BLEST,SC9.C9_BLCRED,SC9.C9_PRODUTO,
			SF4.F4_FILIAL,SF4.F4_DUPLIC,SF4.F4_CODIGO,SC5.C5_ACRSFIN
			
		UNION
		
		SELECT
		SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_EMISSAO,
		SC5.C5_CONDPAG,SC5.C5_MOEDA,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,
		SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PRODUTO,SC6.C6_DESCRI,SC6.C6_OP,SC6.C6_TES,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,
		SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_PRCVEN,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_LOCAL,SC6.C6_QTDENT,SC6.C6_BLQ,
		' ' C9_FILIAL,' ' C9_PEDIDO,' ' C9_ITEM,' ' C9_NFISCAL,' ' C9_BLEST,' ' C9_BLCRED,' ' C9_PRODUTO,0 C9_QTDLIB,
		SF4.F4_FILIAL,SF4.F4_DUPLIC,SF4.F4_CODIGO,SC5.C5_ACRSFIN
		FROM	%Table:SC5% SC5 ,%Table:SC6% SC6, %Table:SF4% SF4
		WHERE
			SC5.C5_FILIAL = %xFilial:SC5% AND SC5.C5_NUM >= %Exp:mv_par01% AND SC5.C5_NUM <= %Exp:mv_par02% AND 
			SC5.%notdel% AND SC6.C6_FILIAL = %xFilial:SC6% AND SC6.C6_NUM = SC5.C5_NUM AND
			SC6.C6_PRODUTO >= %Exp:mv_par03% AND
			SC6.C6_PRODUTO <= %Exp:mv_par04% AND
			SC6.C6_ENTREG  >= %Exp:dtos(mv_par10)% AND
			SC6.C6_ENTREG  <= %Exp:dtos(mv_par11)% AND
			SC6.C6_QTDVEN-SC6.C6_QTDENT > 0 AND SC6.C6_BLQ <> 'R ' AND SC6.%notdel% AND
			SF4.F4_FILIAL = %xFilial:SF4% AND SC6.C6_TES = SF4.F4_CODIGO AND 
			NOT EXISTS (SELECT SC9.C9_PEDIDO FROM %Table:SC9% SC9
			WHERE
	    		SC9.C9_FILIAL = %xFilial:SC9% AND SC9.C9_PEDIDO = SC6.C6_NUM AND SC6.C6_ITEM = SC9.C9_ITEM AND
	    		SC9.C9_NFISCAL = ' ' AND
	    		SC6.C6_PRODUTO = SC9.C9_PRODUTO AND SC9.%notdel%) AND
	    		%Exp:cWhere2%		    		
	    		SF4.%notdel%
  		ORDER BY %Exp:cOrder%
		EndSql
		oReport:Section(1):EndQuery()

Else

    	oReport:Section(1):BeginQuery()
    	BeginSql Alias cAliasSC5
		SELECT
		SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_EMISSAO,
		SC5.C5_CONDPAG,SC5.C5_MOEDA,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,
		SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PRODUTO,SC6.C6_DESCRI,SC6.C6_OP,SC6.C6_TES,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,
		SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_PRCVEN,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_LOCAL,SC6.C6_QTDENT,SC6.C6_BLQ,
		SC9.C9_FILIAL,SC9.C9_PEDIDO,SC9.C9_ITEM,SC9.C9_NFISCAL,SC9.C9_BLEST,SC9.C9_BLCRED,SC9.C9_PRODUTO,
		SUM(SC9.C9_QTDLIB) C9_QTDLIB,SF4.F4_FILIAL,SF4.F4_DUPLIC,SF4.F4_CODIGO,SC5.C5_ACRSFIN
		FROM %Table:SC5% SC5 ,%Table:SC6% SC6 ,%Table:SC9% SC9 ,%Table:SF4% SF4
		WHERE
			SC5.C5_FILIAL = %xFilial:SC5% AND SC5.C5_NUM >= %Exp:mv_par01% AND SC5.C5_NUM <= %Exp:mv_par02% AND
			SC5.%notdel% AND SC6.C6_FILIAL = %xFilial:SC6% AND SC6.C6_NUM = SC5.C5_NUM AND
			SC6.C6_PRODUTO >= %Exp:mv_par03% AND
			SC6.C6_PRODUTO <= %Exp:mv_par04% AND
			SC6.C6_ENTREG  >= %Exp:dtos(mv_par10)% AND
			SC6.C6_ENTREG  <= %Exp:dtos(mv_par11)% AND
			SC6.C6_QTDVEN-SC6.C6_QTDENT > 0 AND SC6.C6_BLQ <> 'R ' AND SC6.%notdel% AND
			SC9.C9_FILIAL = %xFilial:SC9% AND SC9.C9_PEDIDO = SC6.C6_NUM AND SC6.C6_ITEM = SC9.C9_ITEM AND
			SC6.C6_PRODUTO = SC9.C9_PRODUTO AND SC9.C9_NFISCAL = ' ' AND
			SC9.%notdel% AND
			SF4.F4_FILIAL = %xFilial:SF4% AND
			SC6.C6_TES = SF4.F4_CODIGO AND
			%Exp:cWhere%    				
			SF4.%notdel%
	    GROUP BY
			SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_EMISSAO,
			SC5.C5_CONDPAG,SC5.C5_MOEDA,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,
			SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PRODUTO,SC6.C6_DESCRI,SC6.C6_OP,SC6.C6_TES,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,
			SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_PRCVEN,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_LOCAL,SC6.C6_QTDENT,SC6.C6_BLQ,
			SC9.C9_FILIAL,SC9.C9_PEDIDO,SC9.C9_ITEM,SC9.C9_NFISCAL,SC9.C9_BLEST,SC9.C9_BLCRED,SC9.C9_PRODUTO,
			SF4.F4_FILIAL,SF4.F4_DUPLIC,SF4.F4_CODIGO,SC5.C5_ACRSFIN
		ORDER BY %Exp:cOrder%
		EndSql
		oReport:Section(1):EndQuery()
    
EndIf

If MV_PAR06 == 1
	cTipo := STR0056		// " Aptos a Faturar "
ELSEIf MV_PAR06 == 2
	cTipo := STR0057		// " nao Liberados  "
ELSE
	cTipo := ""
EndIf

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
TRPosition():New(oReport:Section(1),"SA1",1,{|| xFilial()+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA })
TRPosition():New(oReport:Section(1),"SA2",1,{|| xFilial()+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA })
TRPosition():New(oReport:Section(1),"SC5",1,{|| xFilial()+(cAliasSC6)->C6_NUM})
TRPosition():New(oReport:Section(1),"SC6",1,{|| xFilial()+(cAliasSC6)->C6_NUM})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera titulo do relatorio de acordo com parametros          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:SetTitle(oReport:Title() + " " + cTipo +  STR0046 + cDescOrdem + " - " + GetMv("MV_MOEDA"+STR(mv_par08,1)))		// "Relacao de Pedidos de Vendas"###" - Ordem de "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                                        ³
//³                        I M P R E S S A O                               ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbselectArea(cAliasSC6)
oReport:SetMeter(SC6->(RecCount()))
oReport:Section(1):Init()
oReport:Section(1):Section(1):Init()
While !oReport:Cancel() .AND. !( cAliasSC6 )->( Eof() ) .AND. (cAliasSC6)->C6_FILIAL == xFilial("SC6")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a validacao dos filtros do usuario e Parametros  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( cAliasSC6 ) 
	lFiltro := IIf(!(ValidMasc((cAliasSC6)->C6_PRODUTO,MV_PAR05)),.F.,.T.)
	       
	If lFiltro
		
		dbSelectArea(cAliasSC6)
		cNumero    := (cAliasSC6)->C6_NUM
		cItem      := (cAliasSC6)->C6_ITEM
		cProduto   := (cAliasSC6)->C6_PRODUTO
		cDescricao := (cAliasSC6)->C6_DESCRI
		If mv_par14 == 2
			SB1->(dbSetOrder(1))
			If SB1->(dbSeek(xFilial("SB1")+(cAliasSC6)->C6_PRODUTO))
				cDescricao := SB1->B1_DESC
			EndIf
		EndIf
		cLocal     := (cAliasSC6)->C6_LOCAL
		cOp        := (cAliasSC6)->C6_OP
		cTes       := (cAliasSC6)->C6_TES
		nQtdven    := (cAliasSC6)->C6_QTDVEN
		nQtdent    := (cAliasSC6)->C6_QTDENT
		nPrunit    := (cAliasSC6)->C6_PRUNIT
		nPrcven    := (cAliasSC6)->C6_PRCVEN
		nVldesc    := (cAliasSC6)->C6_VALDESC
		dEntreg    := (cAliasSC6)->C6_ENTREG
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ VerIfica se o pedido de venda esta apto a faturar(nQtLib!=0) ³
		//³ ou com bloqueio(nQtBloq!=0) , conforme o parametro mv_par06  ³
		//³ seleciona os reguistros a serem impressos.                   ³
		//³ Elementos do Array aQuant :                                  ³
		//³ 1. Produto                                                   ³
		//³ 2. Quantidade Liberada                                       ³
		//³ 3. Quantidade Bloqueada                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aQuant 	 := {}
		nPos := Ascan(aQuant, {|x|x[1]== (cAliasSC9)->C9_PRODUTO})
		If (cAliasSC9)->C9_BLEST == space(TamSx3("C9_BLEST")[1]).AND.(cAliasSC9)->C9_BLCRED == space(TamSx3("C9_BLCRED")[1]).AND.(cAliasSC9)->C9_QTDLIB > 0
			If mv_par06 <> 2
				If nPos != 0
					aQuant[nPos,2]+= (cAliasSC9)->C9_QTDLIB
				Else
					Aadd(aQuant,{(cAliasSC9)->C9_PRODUTO,(cAliasSC9)->C9_QTDLIB,0})
				EndIf
			EndIf
		ElseIf (cAliasSC9)->C9_BLEST <> space(TamSx3("C9_BLEST")[1]).OR.(cAliasSC9)->C9_BLCRED <> space(TamSx3("C9_BLCRED")[1])
			If mv_par06 <> 1
				If nPos != 0
					aQuant[nPos,3]+= (cAliasSC9)->C9_QTDLIB
				Else
					Aadd(aQuant,{(cAliasSC9)->C9_PRODUTO,0,(cAliasSC9)->C9_QTDLIB})
				EndIf
			EndIf
		EndIf
				
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Varre o Array aQuant e alimenta as variaveis nQtLib e nQtBloq com o conteudo.        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nX := 1 To Len(aQuant)
			If mv_par06 == 2 .AND. aQuant[1,2] > 0 .OR. mv_par06 == 1 .AND. aQuant[1,3] > 0
				lContInt := .F.
			Else
				nQtlib += aQuant[nX,2]
				nQtBloq+= aQuant[nX,3]
			EndIf
		Next nX
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o cabecalho do pedido no relatorio.                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (lCabPed .AND. lContInt .AND. Len(aQuant)>0 .AND. mv_par06 <> 3) .OR. (lCabPed .AND. lContInt .AND. mv_par06 == 3)
			
			dbSelectArea(cAliasSC5)
			
			MaFisIni((cAliasSC5)->C5_CLIENTE,(cAliasSC5)->C5_LOJACLI,"C",(cAliasSC5)->C5_TIPO,(cAliasSC5)->C5_TIPOCLI,aImpostos,,,"SB1","MTR700")

			//Na argentina o calculo de impostos depende da serie.
			If cPaisLoc == 'ARG'
				SA1->(DbSetOrder(1))
				SA1->(MsSeek(xFilial()+(cAliasSC5)->C5_CLIENTE+(cAliasSC5)->C5_LOJACLI))
				MaFisAlt('NF_SERIENF',LocXTipSer('SA1',MVNOTAFIS))
			Endif
			
			For nX:= 1 TO 5
				cCampo := "C5_VEND"+STR(nX,1)
				cCampo := (cAliasSC5)->(FieldGet(FieldPos(cCampo)))
				If !Empty(cCampo)
					cVends += If(lBarra,"/","") + cCampo
					lBarra :=.T.
				EndIf
			Next nX

			oReport:Section(1):PrintLine()
			
			cPedido     := (cAliasSC6)->C6_NUM
			nC5Moeda    := (cAliasSC5)->C5_MOEDA
			dC5Emissao  := (cAliasSC5)->C5_EMISSAO
			nPacresFin  := (cAliasSC5)->C5_ACRSFIN
			lCabPed     := .F.
			
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ o Skip dos dados Validos do C6 e dado antes da impressao dos itens do relatorio por  ³
		//³ causa da compatibilizacao das logicas com Query e codbase onde a disposicao dos dados³
		//³ se deram de formas dIferentes.                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasSC6)
		dbSkip()
		oReport:IncMeter()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime os itens do pedido no relatorio.    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  cNumero + cItem + cProduto <> (cAliasSC6)->C6_NUM + (cAliasSC6)->C6_ITEM + (cAliasSC6)->C6_PRODUTO
			
			If ( lContInt .AND. Len(aQuant)>0 .AND. mv_par06 <> 3 ) .OR. ( lContInt .AND. mv_par06 == 3 )
				
				If (nQtLib+nQtBloq)<> 0
					nQuant  := (nQtLib+nQtBloq)
					nTFat   := (nQtLib+nQtBloq) * nPrcven
				Else
					nQuant  := (nQtdven - nQtdent)
					nTFat   := (nQtdven - nQtdent) * nPrcVen
				Endif	
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Calcula o preco de lista                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If ( nPrUnit == 0 )
					nPrUnit := NoRound(nTFat/nQuant,TamSX3("C6_PRCVEN")[2])
				EndIf
				nAcresFin := A410Arred(nPrcVen*nPacresFin/100,"D2_PRCVEN")
				nTFat     += A410Arred(nQuant*nAcresFin,"D2_TOTAL")
				nValDesc  := a410Arred(nPrUnit*nQuant,"D2_DESCON")-nTFat
				nValDesc := IIf(nVlDesc==0,nVlDesc,nValDesc)
				nValDesc  := Max(0,nValDesc)
				nPrUnit   += nAcresFin

				MaFisAdd(cProduto,cTes,(nQtLib+nQtBloq),nPrunit,nValdesc,,,,0,0,0,0,(nTFat+nValDesc),0,0,0)
				
				nItem 		+= 1
				lImp 		:= .T.
				nTotLocal 	:= 0
				nImpLinha	:= 0
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atualizacao do saldo disponivel em estoque com base no SB2 atraves de arquivo de trab³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea(cTmpTable)
				If msSeek(cLocal+cProduto)
					nTotLocal := (cTmpTable)->TB_SALDO
					RecLock(cTmpTable,.F.)
				ELSE
					SB2->(MsSeek(xFilial("SB2")+cProduto+cLocal))
					nTotLocal := SB2->(SaldoSB2())
					(cTmpTable)->(RecLock(cTmpTable,.T.))
					(cTmpTable)->TB_COD		:= cProduto
					(cTmpTable)->TB_LOCAL	:= cLocal
					(cTmpTable)->TB_SALDO	:= nTotLocal
				EndIf
				
				If nQtLib <= 0
					(cTmpTable)->TB_SALDO	:= (cTmpTable)->TB_SALDO - (nQtdven - nQtdent)
				EndIf
				
				(cTmpTable)->(MsUnLock())
				
				cDescTab	:= ""
				If !Empty(cOp)
					SX5->(MsSeek(xFilial("SX5")+"E2"+cOp))
					cDescTab	:= SX5->(X5Descri())
				EndIf

				If cPaisLoc == "BRA"							 
					nValIPI := MaFisRet(nItem,"IT_VALIPI")
				Else
					nValIPI := MaRetIncIV(nItem,"2")
				EndIf
				nImpLinha := nValIPI
				
				If MV_PAR13 == 2 .AND. cPaisLoc == "BRA"
				   nImpLinha += ( MaFisRet(nItem,"IT_VALICM") + MaFisRet(nItem,"IT_VALISS") ) 
				EndIf 				
				
				If mv_par07 = 1
					nTFat     += nValIPI
				EndIf
								
				nValDesc  := xMoeda(nValDesc,nC5Moeda,mv_par08,IIf(mv_par12 == 1,dC5Emissao,dDataBase))
				nPrcVen   := xMoeda(nPrcVen ,nC5Moeda,mv_par08,IIf(mv_par12 == 1,dC5Emissao,dDataBase))
				nImpLinha := xMoeda(nImpLinha,nC5Moeda,mv_par08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase)) 
				nTFat     := xMoeda(nTFat,nC5Moeda,mv_par08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase))
				oReport:Section(1):Section(1):PrintLine()
				
				nQtlib  	:= 0
				nQtBloq		:= 0 
				
			EndIf
			dbSelectArea(cAliasSC6)

		EndIf
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Skip somente dos registros invalidos do C6 recusados pelo filtro -> lFiltro = .F. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasSC6)
		dbSkip()
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o Rodape do pedido no relatorio.    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cAliasSC6)->C6_NUM  <> cPedido .AND. lImp 
	
		If nOrdem == 1
			oReport:Section(1):Section(1):SetTotalText(STR0055)	// "Total do Pedido-->"
		ElseIf nOrdem == 2
			oReport:Section(1):Section(1):SetTotalText(STR0062)	// "Total do Produto-->"		
		Else 
			oReport:Section(1):Section(1):SetTotalText(STR0063)	// "Total da Data-->"		
		EndIf
		oReport:Section(1):Section(1):Finish()
		oReport:Section(1):Finish()
		oReport:Section(1):Init()
		oReport:Section(1):Section(1):Init()
		
		nQtlib 		:= 0
		nQtBloq 	:= 0
		nItem		:= 0
		cVends      := ""
		lCabPed     := .T.
		lBarra      := .F.
		lImp        := .F.
		
		MaFisEnd()
	EndIf
	
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza Relatorio                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):SetPageBreak()

If( valtype(oTempTable) == "O")
	oTempTable:Delete()
	freeObj(oTempTable)
	oTempTable := nil
EndIf

dbSelectArea(cAliasSC5)
dbCloseArea()
dbSelectArea("SC6")
Return(.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MATR700  ³ Autor ³Alexandre Inacio Lemes ³ Data ³ 25/10/2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relacao de Pedidos aptos a faturar                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observacao³ Baseado no original de Claudinei M. Benzi  Data  05/09/1991 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr700R3()

LOCAL titulo 	  := OemToAnsi(STR0001)	//"Relacao de Pedidos de Vendas"
LOCAL cDesc1 	  := OemToAnsi(STR0002)	//"Este programa ira emitir a relacao  dos Pedidos de Vendas"
LOCAL cDesc2 	  := OemToAnsi(STR0003)	//"Sera feita a pesquisa no almoxarIfado e verIficado"
LOCAL cDesc3 	  := OemToAnsi(STR0004)	//"se a quantidade esta disponivel"
LOCAL nomeprog    := "MATR700"
LOCAL wnrel  	  := "MATR700"
LOCAL cString 	  := "SC6"
Local aFieldsPD :={"A1_NOME"}

PRIVATE aOrdem    := {OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007)} //" Por n§ pedido "###" Por produto "###" Por data entrega "
PRIVATE aReturn   := {STR0008, 1,STR0009, 1, 2, 1, "",1}		                 // " Zebrado"###"Administracao"
PRIVATE cPerg     := "MTR700"
PRIVATE tamanho	  := "G"
PRIVATE limite    := 220
PRIVATE li        := 80
PRIVATE m_pag     := 1
PRIVATE nLastKey  := 0
PRIVATE lEnd      := .F.

FATPDLoad(Nil, Nil, aFieldsPD)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ VerIfica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("MTR700",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                               ³
//³ mv_par01         // Do Pedido                                      ³
//³ mv_par02         // Ate o Pedido                                   ³
//³ mv_par03         // Do Produto                                     ³
//³ mv_par04 	     // Ate o Produto                                  ³
//³ mv_par05 	     // Mascara                                        ³
//³ mv_par06 	     // Aptos a Faturar Nao Aptos Todos                ³
//³ mv_par07 	     // Soma Ipi ao Tot Sim Nao                        ³
//³ mv_par08 	     // Qual moeda                                     ³
//³ mv_par09 	     // Quanto ao Tes- Gera Dupl, Nao Gera, Todos      ³
//³ mv_par10         // Data de entrega de                             ³
//³ mv_par11         // Data de entrega Ate                            ³
//³ mv_par12         // Converter valores 1-emissao  2-Data Base       ³
//³ mv_par13         // Coluna impostos 1-IPI/2-IPI/ICMS/ISS           ³
//³ mv_par14         // Pedidos c/ grade imprime 1 Desc SC6 2 Desc SB1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrdem,,Tamanho)

If ( nLastKey == 27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
EndIf

SetDefault(aReturn,cString)

If ( nLastKey == 27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
EndIf

RptStatus({|lEnd| C700Imp(@lEnd,wnRel,cString,aReturn,aOrdem,tamanho,limite,titulo,cDesc1,cDesc2,cDesc3)},Titulo)
FATPDUnload()
Return(.T.)

/*/						
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C700IMP  ³ Autor ³ Alexandre Inacio Lemes³ Data ³25/10/2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR700			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C700Imp(lEnd,WnRel,cString,aReturn,aOrdem,tamanho,limite,titulo,cDesc1,cDesc2,cDesc3)
            
LOCAL nomeprog   := "MATR700"
LOCAL cabec1 	 := STR0010 //"IT CODIGO PRODUTO  DESCRICAO DO PRODUTO            ESTOQUE        -----------  PEDIDO  --------------     QUANTIDADE     QUANTIDADE         VALOR DO        PRECO UNITARIO                       VALOR A" 
LOCAL cabec2 	 := STR0011	//"                                                  DISPONIVEL    VENDIDO     ATENDIDO      SALDO     LIBERADA    BLOQUEADA    DESCONTO    LIQUIDO     ORDEM DE PRODUCAO      VALOR DO IPI               FATURAR       ENTREGA"
LOCAL cbtxt      := SPACE(10)
LOCAL cAliasSC5  := "SC5"
LOCAL cAliasSC6  := "SC6" 
LOCAL cAliasSC9  := "SC9" 
LOCAL cAliasSF4  := "SF4"
LOCAL cDescOrdem := ""
LOCAL cTipo  	 := ""
LOCAL cQuery     := ""
LOCAL cQryAd     := ""
LOCAL cName      := ""
LOCAL cPedido    := ""
LOCAL cFilter    := ""
LOCAL cIndexSC5  := "" 
LOCAL cIndexSC6  := ""
LOCAL cIndexSC9  := ""
LOCAL cKey 	     := ""
LOCAL cCampo     := ""
LOCAL cVends     := ""
LOCAL cDescTab   := ""
LOCAL cNumero    := ""
LOCAL cItem      := "" 
LOCAL cProduto   := "" 
LOCAL cDescricao := "" 
LOCAL cLocal     := ""
LOCAL cOp        := ""
LOCAL cTes       := ""
LOCAL cTmpTable  := GetNextAlias()
LOCAL dEntreg    := dDataBase 
LOCAL dC5Emissao := dDataBase
LOCAL nTipo		 := GetMv("MV_COMP")
LOCAL nOrdem 	 := aReturn[8]
LOCAL nX	 	 := 1
LOCAL CbCont 	 := 0
LOCAL nAcTotFat	 := 0
LOCAL nTotFat 	 := 0
LOCAL nAcdescont := 0
LOCAL nTotDesc	 := 0
LOCAL nTotImp	 := 0
LOCAL nTotImpPar := 0
LOCAL nQtLib 	 := 0
LOCAL nQtBloq	 := 0
LOCAL nTQtde 	 := 0
LOCAL nTPed  	 := 0
LOCAL nTQLib 	 := 0
LOCAL nTQBLoq	 := 0
LOCAL nTQEnt 	 := 0
LOCAL nSC5       := 0
LOCAL nSC6       := 0 
LOCAL nSC9		 := 0
LOCAL nTotLocal  := 0
LOCAL nValdesc   := 0
LOCAL nTFat      := 0
LOCAL nImpLinha	 := 0
LOCAL nItem      := 0    
LOCAL nC5Moeda   := 0    
LOCAL nPos       := 0
LOCAL nQtdven    := 0
LOCAL nQtdent    := 0
LOCAL nPrunit    := 0
LOCAL nValor     := 0
LOCAL nValEnt    := 0
LOCAL nPrcven    := 0
LOCAL nVldesc    := 0
LOCAL nValIPI    := 0 
LOCAL aQuant 	 := {}
LOCAL aCampos	 := {}
LOCAL aTam   	 := {}
LOCAL aStruSC5   := {}
LOCAL aStruSC6   := {} 
LOCAL aStruSC9   := {}
LOCAL aStruSF4   := {}
LOCAL aImpostos  := MaFisRelImp("MTR700",{"SC5","SC6"})
LOCAL lContInt   := .T. 
LOCAL lFiltro	 := .T.
LOCAL lCabPed    := .T.
LOCAL lBarra     := .F.
LOCAL lImp 		 := .F.
LOCAL cQueryAdd  := ""
Local nAcresFin  := 0
Local nQuant     := 0
Local nPacresFin := 0
Local cCLIObfus  :=""
Local lCLIObfus  :=  FATPDIsObfuscate("A1_NOME")

Private oTempTable := Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array com base no SB2 e Monta arquivo de trabalho     ³
//³ para baixar estoque na listagem.                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam	:= TamSX3("B2_LOCAL")
AADD(aCampos, {"TB_LOCAL", "C", aTam[1], aTam[2]})
aTam	:= TamSX3("B2_COD")
AADD(aCampos, {"TB_COD",   "C", aTam[1], aTam[2]})
aTam	:= TamSX3("B2_QATU")
AADD(aCampos, {"TB_SALDO", "N", aTam[1], aTam[2]})
aTam	:= {}

//-------------------------------------------------------------------
// Instancia tabela temporária.  
//-------------------------------------------------------------------
oTempTable	:= FWTemporaryTable():New(cTmpTable)

//-------------------------------------------------------------------
// Atribui o  os índices.  
//-------------------------------------------------------------------
oTempTable:SetFields( aCampos )

oTempTable:AddIndex("1",{"TB_LOCAL","TB_COD"})

//------------------
//Criação da tabela
//------------------
oTempTable:Create()

dbSelectArea("SC6")
dbSetOrder(nOrdem) 

cQueryAdd := ""
cAliasSC5 := "QRYSC6"
cAliasSC6 := "QRYSC6"
cAliasSC9 := "QRYSC6"
cAliasSF4 := "QRYSC6"

aStruSC5  := SC5->(dbStruct())
aStruSC6  := SC6->(dbStruct())
aStruSC9  := SC9->(dbStruct())
aStruSF4  := SF4->(dbStruct())

cQuery := "SELECT "
cQuery += "SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_EMISSAO,
cQuery += "SC5.C5_CONDPAG,SC5.C5_MOEDA,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,"
cQuery += "SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PRODUTO,SC6.C6_DESCRI,SC6.C6_OP,SC6.C6_TES,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,"
cQuery += "SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_PRCVEN,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_LOCAL,SC6.C6_QTDENT,SC6.C6_BLQ,"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Esta rotina foi escrita para adicionar no select os campos do SC6  ³
//³usados no filtro do usuario quando houver, a rotina acrecenta      ³
//³somente os campos que forem adicionados ao filtro testando         ³
//³se os mesmo já existem no select ou se forem definidos novamente   ³
//³pelo o usuario no filtro.                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   	
If !Empty(aReturn[7])
	For nX := 1 To SC6->(FCount())
		cName := SC6->(FieldName(nX))
		If AllTrim(cName) $ aReturn[7]
			If aStruSC6[nX,2] <> "M"
				If !cName $ cQuery .AND. !cName $ cQryAd
					cQryAd += cName +","
				EndIf
			EndIf
		EndIf
	Next nX
EndIf
 
cQuery += cQryAd

cQuery += "SC9.C9_FILIAL,SC9.C9_PEDIDO,SC9.C9_ITEM,SC9.C9_NFISCAL,SC9.C9_BLEST,SC9.C9_BLCRED,SC9.C9_PRODUTO,"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³o Campo C9_QTDLIB e somado por haver varios C9 para cada C6.       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   	
cQuery += "SUM(SC9.C9_QTDLIB) C9_QTDLIB,"
cQuery += "SF4.F4_FILIAL,SF4.F4_DUPLIC,SF4.F4_CODIGO,SC5.C5_ACRSFIN "
cQuery += "FROM "
cQuery += RetSqlName("SC5")+" SC5 ,"+RetSqlName("SC6")+" SC6 ,"+RetSqlName("SC9")+" SC9 ,"+RetSqlName("SF4")+" SF4 "
cQuery += "WHERE "
cQuery += "SC5.C5_FILIAL = '"+xFilial("SC5")+"' AND SC5.C5_NUM >= '"+mv_par01+"' AND SC5.C5_NUM <= '"+mv_par02+"' AND "
cQuery += "SC5.D_E_L_E_T_ = ' ' AND SC6.C6_FILIAL = '"+xFilial("SC6")+"' AND SC6.C6_NUM   = SC5.C5_NUM AND "
cQuery += "SC6.C6_PRODUTO >= '" + mv_par03       + "' AND "
cQuery += "SC6.C6_PRODUTO <= '" + mv_par04       + "' AND "
cQuery += "SC6.C6_ENTREG  >= '" + dtos(mv_par10) + "' AND "
cQuery += "SC6.C6_ENTREG  <= '" + dtos(mv_par11) + "' AND "
cQuery += "SC6.C6_QTDVEN-SC6.C6_QTDENT > 0 AND SC6.C6_BLQ<>'R ' AND SC6.D_E_L_E_T_ = ' ' AND "
cQuery += "SC9.C9_FILIAL = '"+xFilial("SC9")+"' AND SC9.C9_PEDIDO = SC6.C6_NUM AND SC6.C6_ITEM = SC9.C9_ITEM AND "
cQuery += "SC6.C6_PRODUTO = SC9.C9_PRODUTO AND SC9.C9_NFISCAL = '" + space(TamSx3("C9_NFISCAL")[1]) + "' AND "
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Trata o Relacionamento com C9 conforme a opcao do MV_PAR06 -> "IMPRIMIR PEDIDOS ?" ³
//³ "IMPRIMIR PEDIDOS ?"                                                               ³
//³ MV_PAR06 == 1 -> Pedidos Aptos a Faturar com C9 liberado.                          ³
//³ MV_PAR06 == 2 -> Pedidos Nao Aptos a Faturar com C9 bloqueado no Credito ou Estoque³
//³ MV_PAR06 == 3 -> Todos - pedidos liberados e bloqueados do C9 + os C6 sem os C9    ³
//³ para MV_PAR06 == 3 o relacionamento com C9 na Query e feito atraves de UNION.      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   	
If mv_par06 == 1
	cQuery += "SC9.C9_BLEST = '" + space(TamSx3("C9_BLEST")[1]) + "' AND "
	cQuery += "SC9.C9_BLCRED = '" + space(TamSx3("C9_BLCRED")[1]) + "' AND "
	cQuery += "SC9.C9_QTDLIB > 0 AND "
ElseIf mv_par06 == 2
	cQuery += "(SC9.C9_BLEST <> '" + space(TamSx3("C9_BLEST")[1]) + "' OR "
	cQuery += "SC9.C9_BLCRED <> '" + space(TamSx3("C9_BLCRED")[1]) + "') AND "
EndIf
cQuery += "SC9.D_E_L_E_T_ = ' ' "

cQuery += " AND SF4.F4_FILIAL = '"+xFilial("SF4")+"'"
cQuery += " AND SC6.C6_TES = SF4.F4_CODIGO AND "
If mv_par09 == 1
	cQuery += "SF4.F4_DUPLIC = 'S' AND "
ElseIf mv_par09 == 2
	cQuery += "SF4.F4_DUPLIC <> 'S' AND "
EndIf
cQuery += "SF4.D_E_L_E_T_ = ' ' "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ponto de entrada para tratamento do filtro do usuario.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("F700QRY")
	cQueryAdd := ExecBlock("F700QRY", .F., .F., {aReturn[7]})
	If ValType(cQueryAdd) == "C"
		cQuery += " AND ( " + cQueryAdd + ")"
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Agrupamento de todos os campos comuns do SELECT para que nos relacionamentos com     ³
//³ C5,C6 e C9 com varios C9 para cada C6 gerem apenas um registro com o campo C9_QTDLIB ³
//³ somado.                                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   			
cQuery += "GROUP BY "
cQuery += "SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_EMISSAO,
cQuery += "SC5.C5_CONDPAG,SC5.C5_MOEDA,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,"
cQuery += "SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PRODUTO,SC6.C6_DESCRI,SC6.C6_OP,SC6.C6_TES,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,"
cQuery += "SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_PRCVEN,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_LOCAL,SC6.C6_QTDENT,SC6.C6_BLQ,"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona os campos fornecidos pelo filtro do usuario.             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   	
cQuery += cQryAd		
cQuery += "SC9.C9_FILIAL,SC9.C9_PEDIDO,SC9.C9_ITEM,SC9.C9_NFISCAL,SC9.C9_BLEST,SC9.C9_BLCRED,SC9.C9_PRODUTO,"
cQuery += "SF4.F4_FILIAL,SF4.F4_DUPLIC,SF4.F4_CODIGO,SC5.C5_ACRSFIN "

If mv_par06 == 3
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Quando o MV_PAR06 ==3 ->"TODOS OS PEDIDOS" esse UNION acrescenta a Query os registros³
    //³ do C6 que nao possuem C9.                                                            ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   			

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ ATENCAO !!!! ao manipular os campos do SELECT ou a ordem da Clausula ORDER BY verificar   ³
	//³ a concordancia entre os mesmos !!!!!!!!!                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	cQuery += "UNION "
	cQuery += "SELECT "
	cQuery += "SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_EMISSAO,
	cQuery += "SC5.C5_CONDPAG,SC5.C5_MOEDA,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,"
	cQuery += "SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PRODUTO,SC6.C6_DESCRI,SC6.C6_OP,SC6.C6_TES,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,"
	cQuery += "SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_PRCVEN,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_LOCAL,SC6.C6_QTDENT,SC6.C6_BLQ,"
    cQuery += cQryAd		
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Para o uso de UNION a estrutura deste SELECT deve ser igual a do SELECT anterior     ³
    //³ note que a nomeclatura do C9 usa os mesmos nomes dos campos da TABELA, porem com o   ³
    //³ uso de ' ' para nao fazer referencia a ela.                                          ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   			
	cQuery += "' ' C9_FILIAL,' ' C9_PEDIDO,' ' C9_ITEM,' ' C9_NFISCAL,' ' C9_BLEST,' ' C9_BLCRED,' ' C9_PRODUTO, 0 C9_QTDLIB,"
	cQuery += "SF4.F4_FILIAL,SF4.F4_DUPLIC,SF4.F4_CODIGO,SC5.C5_ACRSFIN "
	cQuery += "FROM "
	cQuery += RetSqlName("SC5")+" SC5 ,"+RetSqlName("SC6")+" SC6 ,"+RetSqlName("SF4")+" SF4 "
	cQuery += "WHERE "
	cQuery += "SC5.C5_FILIAL = '"+xFilial("SC5")+"' AND SC5.C5_NUM >= '"+mv_par01+"' AND SC5.C5_NUM <= '"+mv_par02+"' AND "
	cQuery += "SC5.D_E_L_E_T_ = ' ' AND SC6.C6_FILIAL = '"+xFilial("SC6")+"' AND SC6.C6_NUM   = SC5.C5_NUM AND "
	cQuery += "SC6.C6_PRODUTO >= '" + mv_par03       + "' AND "
	cQuery += "SC6.C6_PRODUTO <= '" + mv_par04       + "' AND "
	cQuery += "SC6.C6_ENTREG  >= '" + dtos(mv_par10) + "' AND "
	cQuery += "SC6.C6_ENTREG  <= '" + dtos(mv_par11) + "' AND "
	cQuery += "SC6.C6_QTDVEN-SC6.C6_QTDENT > 0 AND SC6.C6_BLQ<>'R ' AND SC6.D_E_L_E_T_ = ' ' AND "
	cQuery += "SF4.F4_FILIAL = '"+xFilial("SF4")+"' AND SC6.C6_TES = SF4.F4_CODIGO AND "
	cQuery += "NOT EXISTS (SELECT SC9.C9_PEDIDO FROM "+RetSqlName("SC9")+" SC9 " 
	cQuery += "WHERE "
    cQuery += "SC9.C9_FILIAL = '"+xFilial("SC9")+"' AND SC9.C9_PEDIDO = SC6.C6_NUM AND SC6.C6_ITEM = SC9.C9_ITEM AND "
    cQuery += "SC9.C9_NFISCAL = '"+Space(Len(SC9->C9_NFISCAL))+"' AND "		    
    cQuery += "SC6.C6_PRODUTO = SC9.C9_PRODUTO AND SC9.D_E_L_E_T_ = ' ') AND "
	If mv_par09 == 1
		cQuery += "SF4.F4_DUPLIC = 'S' AND "
	ElseIf mv_par09 == 2
		cQuery += "SF4.F4_DUPLIC <> 'S' AND "
	EndIf
	cQuery += "SF4.D_E_L_E_T_ = ' ' "
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Tratamento do filtro do usuario.                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ValType(cQueryAdd) == "C" .AND. !Empty(cQueryAdd)
		cQuery += " AND ( " + cQueryAdd + ")"
	EndIf
	
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ ATENCAO !!!! ao manipular os campos do SELECT ou a ordem da Clausula ORDER BY verificar   ³
//³ a concordancia entre os mesmos !!!!!!!!!                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem = 1
	cDescOrdem:= STR0013	//"PEDIDO"
	cQuery += "ORDER BY 2,26"
ElseIf nOrdem = 2
	cDescOrdem:= STR0014	//"PRODUTO"
	cQuery += "ORDER BY 18"
ELSE
	cDescOrdem:= STR0015	//"DATA DE ENTREGA"+"PEDIDO"
	cQuery += "ORDER BY 30,2,26"
EndIf

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC5,.T.,.T.)

For nSC5 := 1 To Len(aStruSC5)
	If aStruSC5[nSC5][2] <> "C" .AND.  FieldPos(aStruSC5[nSC5][1]) > 0
		TcSetField(cAliasSC5,aStruSC5[nSC5][1],aStruSC5[nSC5][2],aStruSC5[nSC5][3],aStruSC5[nSC5][4])
	EndIf
Next nSC5

For nSC6 := 1 To Len(aStruSC6)
	If aStruSC6[nSC6][2] <> "C" .AND. FieldPos(aStruSC6[nSC6][1]) > 0
		TcSetField(cAliasSC6,aStruSC6[nSC6][1],aStruSC6[nSC6][2],aStruSC6[nSC6][3],aStruSC6[nSC6][4])
	EndIf
Next nSC6

For nSC9 := 1 To Len(aStruSC9)
    If aStruSC9[nSC9][2] <> "C" .AND. FieldPos(aStruSC9[nSC9][1]) > 0
			TcSetField(cAliasSC9,aStruSC9[nSC9][1],aStruSC9[nSC9][2],aStruSC9[nSC9][3],aStruSC9[nSC9][4])
    EndIf
Next nSC9

If MV_PAR06 == 1
	cTipo := STR0016		//" APTOS A FATURAR "
ELSEIf MV_PAR06 == 2
	cTipo := STR0017		//" NAO LIBERADOS   "
ELSE
	cTipo := ""
EndIf
titulo += cTipo +  STR0018 + cDescOrdem + " - " + GetMv("MV_MOEDA"+STR(mv_par08,1))		//" - ORDEM DE "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona Area do While e retorna o total Elementos da regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbselectArea(cAliasSC6)
SetRegua(SC6->(RecCount()))

While !( cAliasSC6 )->( Eof() ) .AND. (cAliasSC6)->C6_FILIAL == xFilial("SC6")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se cancelado pelo usuario                        	     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lEnd
		@ PROW()+1,001 Psay STR0019	  // "CANCELADO PELO OPERADOR"
		Exit
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a validacao dos filtros do usuario e Parametros  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( cAliasSC6 ) 
	lFiltro := IIf((!Empty(aReturn[7]).AND.!&(aReturn[7])) .OR. !(ValidMasc((cAliasSC6)->C6_PRODUTO,MV_PAR05)),.F.,.T.)
	
	If lFiltro
		
		dbSelectArea(cAliasSC6)
		
		cNumero    := (cAliasSC6)->C6_NUM
		cItem      := (cAliasSC6)->C6_ITEM
		cProduto   := (cAliasSC6)->C6_PRODUTO
		cDescricao := (cAliasSC6)->C6_DESCRI
		If mv_par14 == 2
			SB1->(dbSetOrder(1))
			If SB1->(dbSeek(xFilial("SB1")+(cAliasSC6)->C6_PRODUTO))
				cDescricao := SB1->B1_DESC
			EndIf
		EndIf
		cLocal     := (cAliasSC6)->C6_LOCAL
		cOp        := (cAliasSC6)->C6_OP
		cTes       := (cAliasSC6)->C6_TES
		nQtdven    := (cAliasSC6)->C6_QTDVEN
		nQtdent    := (cAliasSC6)->C6_QTDENT
		nPrunit    := (cAliasSC6)->C6_PRUNIT
		nValor     := (cAliasSC6)->C6_VALOR
		nPrcven    := (cAliasSC6)->C6_PRCVEN
		nVldesc    := (cAliasSC6)->C6_VALDESC
		dEntreg    := (cAliasSC6)->C6_ENTREG
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ VerIfica se o pedido de venda esta apto a faturar(nQtLib!=0) ³
		//³ ou com bloqueio(nQtBloq!=0) , conforme o parametro mv_par06  ³
		//³ seleciona os reguistros a serem impressos.                   ³
		//³ Elementos do Array aQuant :                                  ³
		//³ 1. Produto                                                   ³
		//³ 2. Quantidade Liberada                                       ³
		//³ 3. Quantidade Bloqueada                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aQuant 	 := {}
		
		nPos := Ascan(aQuant, {|x|x[1]== (cAliasSC9)->C9_PRODUTO})
		If (cAliasSC9)->C9_BLEST == space(TamSx3("C9_BLEST")[1]).AND.(cAliasSC9)->C9_BLCRED == space(TamSx3("C9_BLCRED")[1]).AND.(cAliasSC9)->C9_QTDLIB > 0
			If mv_par06 <> 2
				If nPos != 0
					aQuant[nPos,2]+= (cAliasSC9)->C9_QTDLIB
				Else
					Aadd(aQuant,{(cAliasSC9)->C9_PRODUTO,(cAliasSC9)->C9_QTDLIB,0})
				EndIf
			EndIf
		ElseIf (cAliasSC9)->C9_BLEST <> space(TamSx3("C9_BLEST")[1]).OR.(cAliasSC9)->C9_BLCRED <> space(TamSx3("C9_BLCRED")[1])
			If mv_par06 <> 1
				If nPos != 0
					aQuant[nPos,3]+= (cAliasSC9)->C9_QTDLIB
				Else
					Aadd(aQuant,{(cAliasSC9)->C9_PRODUTO,0,(cAliasSC9)->C9_QTDLIB})
				EndIf
			EndIf
		EndIf
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Varre o Array aQuant e alimenta as variaveis nQtLib e nQtBloq com o conteudo.        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nX := 1 To Len(aQuant)
			If mv_par06 == 2 .AND. aQuant[1,2] > 0 .OR. mv_par06 == 1 .AND. aQuant[1,3] > 0
				lContInt := .F.
			Else
				nQtlib += aQuant[nX,2]
				nQtBloq+= aQuant[nX,3]
			EndIf
		Next nX
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o cabecalho do pedido no relatorio.                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (lCabPed .AND. lContInt .AND. Len(aQuant)>0 .AND. mv_par06 <> 3) .OR. (lCabPed .AND. lContInt .AND. mv_par06 == 3)
			
			If li > 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			EndIf
			
			dbSelectArea(cAliasSC5)
						
			MaFisIni((cAliasSC5)->C5_CLIENTE,(cAliasSC5)->C5_LOJACLI,"C",(cAliasSC5)->C5_TIPO,(cAliasSC5)->C5_TIPOCLI,aImpostos,,,"SB1","MTR700")

			//Na argentina o calculo de impostos depende da serie.
			If cPaisLoc == 'ARG'
				SA1->(DbSetOrder(1))
				SA1->(MsSeek(xFilial()+(cAliasSC5)->C5_CLIENTE+(cAliasSC5)->C5_LOJACLI))
				MaFisAlt('NF_SERIENF',LocXTipSer('SA1',MVNOTAFIS))
			Endif

			For nX:= 1 TO 5
				cCampo := "C5_VEND"+STR(nX,1)
				cCampo := (cAliasSC5)->(FieldGet(FieldPos(cCampo)))
				If !Empty(cCampo)
					cVends += If(lBarra,"/","") + cCampo
					lBarra :=.T.
				EndIf
			Next nX
			
			@li,  0 Psay STR0023	 + (cAliasSC5)->C5_NUM		//"PEDIDO : "
			
			If (cAliasSC5)->C5_TIPO $ "BD"
				dbSelectArea("SA2")
				dbSetOrder(1)
				If msSeek( xFilial()+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA )
					@li, PCol()+2 Psay STR0024 + SA2->A2_COD+' - '+ Subs(SA2->A2_NOME,1,40)		//"FORNECEDOR : "
				EndIf
			Else
				dbSelectArea("SA1")
				dbSetOrder(1)
				If msSeek( xFilial()+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA )
					If lCLIObfus .And. Empty(cCLIObfus)
						cCLIObfus:= FATPDObfuscate(Subs(SA1->A1_NOME,1,40))		
					EndIf
					@li, PCol()+2 Psay STR0029 + SA1->A1_COD+' - '+ Iif(Empty(cCLIObfus),Subs(SA1->A1_NOME,1,40), cCLIObfus)//"CLIENTE : "
				EndIf
			EndIf
			
			@li, PCol()+2 Psay STR0025 + (cAliasSC5)->C5_LOJACLI				//"LOJA : "
			@li, PCol()+2 Psay STR0026 + DTOC((cAliasSC5)->C5_EMISSAO)		    //"EMISSAO : "
			@li, PCol()+2 Psay STR0027 + (cAliasSC5)->C5_TRANSP				//"TRANSPORTADORA: "
			@li, PCol()+2 Psay STR0028 + cVends                     			//"VENDEDOR(ES): "
			@li, PCol()+2 Psay STR0030 + (cAliasSC5)->C5_CONDPAG				//"COND.PGTO:  "
			li+=2
			
			cPedido     := (cAliasSC6)->C6_NUM
			nC5Moeda    := (cAliasSC5)->C5_MOEDA
			dC5Emissao  := (cAliasSC5)->C5_EMISSAO
			nPacresFin  := (cAliasSC5)->C5_ACRSFIN
			lCabPed     := .F.
			
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ o Skip dos dados Validos do C6 e dado antes da impressao dos itens do relatorio por  ³
		//³ causa da compatibilizacao das logicas com Query e codbase onde a disposicao dos dados³
		//³ se deram de formas dIferentes.                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasSC6)
		dbSkip()
		IncRegua()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime os itens do pedido no relatorio.    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  cNumero + cItem + cProduto <> (cAliasSC6)->C6_NUM + (cAliasSC6)->C6_ITEM + (cAliasSC6)->C6_PRODUTO
			
			If ( lContInt .AND. Len(aQuant)>0 .AND. mv_par06 <> 3 ) .OR. ( lContInt .AND. mv_par06 == 3 )
				
				If li > 58
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				EndIf

				If (nQtLib+nQtBloq)<> 0
					nQuant  := (nQtLib+nQtBloq)
					nTFat   := (nQtLib+nQtBloq) * nPrcven
				Else
					nQuant  := (nQtdven - nQtdent)
					nTFat   := (nQtdven - nQtdent) * nPrcVen
				Endif	
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Calcula o preco de lista                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If ( nPrUnit == 0 )
					nPrUnit := NoRound(nTFat/nQuant,TamSX3("C6_PRCVEN")[2])
				EndIf
				nAcresFin := A410Arred(nPrcVen*nPacresFin/100,"D2_PRCVEN")
				nTFat     += A410Arred(nQuant*nAcresFin,"D2_TOTAL")
				nValDesc  := a410Arred(nPrUnit*nQuant,"D2_DESCON")-nTFat
				nValDesc := IIf(nVlDesc==0,nVlDesc,nValDesc)
				nValDesc  := Max(0,nValDesc)
				nPrUnit   += nAcresFin				
				
				MaFisAdd(cProduto,cTes,(nQtLib+nQtBloq),nPrunit,nValdesc,,,,0,0,0,0,(nTFat+nValDesc),0,0,0)
				
				nItem += 1
				
				lImp := .T.
				
				nTotLocal := 0
				nImpLinha	  := 0
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atualizacao do saldo disponivel em estoque com base no SB2 atraves de arquivo de trab³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea(cTmpTable)
				If msSeek(cLocal+cProduto)
					nTotLocal := (cTmpTable)->TB_SALDO
					RecLock(cTmpTable,.F.)
				ELSE
					SB2->(MsSeek(xFilial("SB2")+cProduto+cLocal))
					nTotLocal := SB2->(SaldoSB2())
					(cTmpTable)->(RecLock(cTmpTable,.T.))
					(cTmpTable)->TB_COD		:= cProduto
					(cTmpTable)->TB_LOCAL	:= cLocal
					(cTmpTable)->TB_SALDO	:= nTotLocal
				EndIf
				
				If nQtLib <= 0
					(cTmpTable)->TB_SALDO	:= (cTmpTable)->TB_SALDO - (nQtdven - nQtdent)
				EndIf
				
				(cTmpTable)->(MsUnLock())
				
				cDescTab	:= ""
				If !Empty(cOp)
					SX5->(MsSeek(xFilial("SX5")+"E2"+cOp))
					cDescTab	:= SX5->(X5Descri())
				EndIf

				If cPaisLoc == "BRA"							 
					nValIPI	:= MaFisRet(nItem,"IT_VALIPI")
				Else
					nValIPI	:= MaRetIncIV(nItem,"2")
				EndIf
				nImpLinha := nValIPI
				
				If MV_PAR13 == 2 .AND. cPaisLoc == "BRA"
				   nImpLinha += ( MaFisRet(nItem,"IT_VALICM") + MaFisRet(nItem,"IT_VALISS") ) 
				EndIf 				

				nTotImpPar   += nImpLinha        

				If mv_par07 = 1
					nTFat     += nValIPI
				EndIf
				
				@li, 00 Psay SubStr(cItem + " " + AllTrim(cProduto) + " - " + cDescricao,1,46)
				@li, 47 Psay nTotLocal               Picture PesqPictQt("B2_QATU",15)
				@li, 62 Psay nQtdVen                 PicTure PesqPictQt("C6_QTDVEN",11)
				@li, 74 Psay nQtdEnt                 PicTure PesqPictQt("C6_QTDENT",11)
				@li, 86 Psay (nQtdVen - nQtdEnt)     PicTure PesqPictQt("C6_QTDVEN",11)
				@li, 98 Psay nQtLib                  Picture PesqPictQt("C6_QTDVEN",11)
				@li,110 Psay nQtBloq                 Picture PesqPictQt("C6_QTDVEN",11)
				@li,122 Psay xMoeda(nValDesc,nC5Moeda,mv_par08,IIf(mv_par12 == 1,dC5Emissao,dDataBase)) PicTure tm(nValDesc,11)
				@li,134 Psay xMoeda(nPrcVen ,nC5Moeda,mv_par08,IIf(mv_par12 == 1,dC5Emissao,dDataBase)) PicTure PesqPict((cAliasSC6),"C6_PRCVEN",13)
				@li,148 Psay Substr (cOp+"-"+cDescTab,1,24)
				If nImpLinha > 0
					@li,174 Psay xMoeda(nImpLinha,nC5Moeda,mv_par08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase)) PicTure PesqPict((cAliasSC6),"C6_VALOR",13)
				EndIf
				If nTFat > 0
					@li,192 Psay xMoeda(nTFat,nC5Moeda,mv_par08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase))    PicTure tm(nTFat,15)
				EndIf
				@li,210 Psay dEntreg
				
				nTQLib  	+= nQtLib
				nTQBloq 	+= nQtBloq
				nTQtde  	+= nQtdVen
				nTQEnt  	+= nQtdEnt
				nTPed   	+= xMoeda(nPrcVen,nC5Moeda,mv_par08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase))				
				nAcTotFat	+= nTFat

				nAcdescont  += nValDesc
				nQtlib  	:= 0
				nQtBloq		:= 0 

				li++
				
			EndIf

			dbSelectArea(cAliasSC6)
		EndIf
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Skip somente dos registros invalidos do C6 recusados pelo filtro -> lFiltro = .F. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasSC6)
		dbSkip()
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o Rodape do pedido no relatorio.    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cAliasSC6)->C6_NUM  <> cPedido .AND. lImp
		
		If li > 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		EndIf
		
		@li,0   Psay STR0020		//"TOTAL DO PEDIDO--> "
		@li,118 Psay xMoeda(nAcDescont,nC5Moeda,MV_PAR08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase))	PicTure tm(nAcDescont,15)
		If nTotImpPar > 0
			@li,170 Psay xMoeda(nTotImpPar,nC5Moeda,MV_PAR08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase))	Picture PesqPict((cAliasSC6),"C6_VALOR",15)
		EndIf
		If nAcTotFat > 0
			@li,192 Psay xMoeda(nAcTotFat,nC5Moeda,MV_PAR08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase))	PicTure tm(nAcTotFat,15)
		EndIf
		
		nTotFat  += xMoeda(nAcTotFat, nC5Moeda,mv_par08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase))
		nTotDesc += xMoeda(nAcDescont,nC5Moeda,mv_par08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase))
		nTotImp  += xMoeda(nTotImpPar,nC5Moeda,mv_par08,IIf(MV_PAR12 == 1,dC5Emissao,dDataBase))
		
		nAcTotFat	:= 0
		nAcdescont	:= 0
		nTotImpPar 	:= 0
		nQtlib 		:= 0
		nQtBloq 	:= 0
		nItem		:= 0
		cVends      := ""
		lCabPed     := .T.
		lBarra      := .F.
		lImp        := .F.
		li          += 2
		
		MaFisEnd()
	EndIf
	
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime os valores totais do final do Relatorio. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nTotFat > 0
	If li > 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIf
	@li,  0 Psay STR0022	    	//"TOTAL GERAL--> "
	@li, 60 Psay nTQtde				PicTure PesqPictQt("C6_PRCVEN",13)
	@li, 72 Psay nTQent	            PicTure PesqPictQt("C6_PRCVEN",13)
	@li, 84 Psay (nTQtde-nTQEnt)	PicTure PesqPictQt("C6_PRCVEN",13)
	@li, 96 Psay nTQLib				Picture PesqPictQt("C6_PRCVEN",13)
	@li,108 Psay nTQBloq			Picture PesqPictQt("C6_PRCVEN",13)
	@li,119 Psay nTotDesc			PicTure tm(nTotDesc,14)
	@li,134 Psay nTPed				PicTure PesqPict((cAliasSC6),"C6_PRCVEN",13)
	If nTotImp > 0
		@li,170 Psay nTotImp Picture PesqPict((cAliasSC6),"C6_VALOR",15)
	EndIf
	@li,192 Psay nTotFat	PicTure tm(nTotFat,15)
	li++
EndIf

If li != 80
	roda(cbcont,cbtxt,Tamanho)
EndIf

If( valtype(oTempTable) == "O")
	oTempTable:Delete()
	freeObj(oTempTable)
	oTempTable := nil
EndIf

dbSelectArea(cAliasSC5)
dbCloseArea()
dbSelectArea("SC6")

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	ourspool(wnrel)
EndIf
MS_FLUSH()
Return(.T.)




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
