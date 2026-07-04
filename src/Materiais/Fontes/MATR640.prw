/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR640.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR640  ³ Autor ³ Marco Bianchi         ³ Data ³ 28/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Duplicatas			                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT - R4                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR640()

Local oReport
Local aFieldsPD := {"A1_NOME"}

FATPDLoad(Nil, Nil, aFieldsPD)

//-- Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()

FATPDUnload()
ASize(aFieldsPD, 0)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 28/06/06 ³±±
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                      		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local oReport
Local oDupl

#IFDEF TOP
	Local cAliasQry := GetNextAlias()
#ELSE
	Local cAliasQry := "SE1"
#ENDIF

Local oTotal
Local cPrefixo	:= ""
Local cNum		:= ""
Local cParcela	:= ""
Local cCliente	:= ""
Local cLoja 	:= ""
Local cNome		:= ""
Local dEmissao	:= CTOD("  /  /  ")
Local dVendRea	:= CTOD("  /  /  ")
Local nValor 	:= 0
Local cSupervi	:= ""
Local cVendedor	:= ""
Local cPedido	:= ""

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
oReport := TReport():New("MATR640",STR0025,"MTR640", {|oReport| ReportPrint(oReport,cAliasQry,oTotal,oDupl)},STR0026 + " " + STR0027 + " " + STR0028)	// "Relacao de Duplicatas"###"Este programa ira emitir a relacao de duplicatas"###"emitidas.Podera ser emitida por Ordem de Titulo, "###"Emissao, Vencimento, Vendedor ou Cliente."
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         			  ³
//³ mv_par01             // Da Duplicata                         			  ³
//³ mv_par02             // Ate a Duplicata                      			  ³
//³ mv_par03             // Do Vendedor                          			  ³
//³ mv_par04             // Ate o vendedor                       			  ³
//³ mv_par05             // Todos/em Aberto                      			  ³
//³ mv_par06             // Serie da Duplicata                   			  ³
//³ mv_par07             // A partir da Emissao                  			  ³
//³ mv_par08             // Ate a data de Emissao                		      ³
//³ mv_par09             // A partir do vencimento               			  ³
//³ mv_par10             // Ate o vencimento                     			  ³
//³ mv_par11             // Do Cliente                           			  ³
//³ mv_par12             // Ate o Cliente                        			  ³
//³ mv_par13             // Qual moeda                           			  ³
//³ mv_par14             // Pula Pagina Quebra                   			  ³
//³ mv_par15             // Pagina Inicial                       			  ³
//³ mv_par16             // Considerar titulos (1=Todos,2=Desconsidera,3=Deduz³
//³ mv_par17             // Serie Final                          			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
oDupl := TRSection():New(oReport,STR0039,{"SE1","SA1","TRB"},{STR0029,STR0030,STR0031,STR0032,STR0033},/*Campos do SX3*/,/*Campos do SIX*/)		// "Duplicatas"###Numero###Emissao###Vencimento###Vendedor###Cliente
oDupl:SetTotalInLine(.F.)

TRCell():New(oDupl,"CPREFIXO"	,/*Tabela*/,RetTitle("E1_PREFIXO"	),PesqPict("SE1","E1_PREFIXO"	),TamSx3("E1_PREFIXO"	)[1],/*lPixel*/,{|| cPrefixo 	                    })	// Prefixo do Titulo
TRCell():New(oDupl,"CNUM"		,/*Tabela*/,RetTitle("E1_NUM"		),PesqPict("SE1","E1_NUM"		),TamSx3("E1_NUM"		)[1],/*lPixel*/,{|| cNum 		                    })	// Numero do Titulo
TRCell():New(oDupl,"CPARCELA"	,/*Tabela*/,RetTitle("E1_PARCELA"	),PesqPict("SE1","E1_PARCELA"	),TamSx3("E1_PARCELA"	)[1],/*lPixel*/,{|| cParcela 	                    })	// Parcela
TRCell():New(oDupl,"CCLIENTE"	,/*Tabela*/,RetTitle("E1_CLIENTE"	),PesqPict("SE1","E1_CLIENTE"	),TamSx3("E1_CLIENTE"	)[1],/*lPixel*/,{|| cCliente 	                    })	// Codigo do Cliente
TRCell():New(oDupl,"CLOJA"		,/*Tabela*/,RetTitle("E1_LOJA"		),PesqPict("SE1","E1_LOJA"		),TamSx3("E1_LOJA"		)[1],/*lPixel*/,{|| cLoja 		                    })	// Loja
TRCell():New(oDupl,"CNOME"		,/*Tabela*/,RetTitle("A1_NOME"		),PesqPict("SA1","A1_NOME"		),TamSx3("A1_NOME"		)[1],/*lPixel*/,{|| FATPDObfuscate(cNome, "A1_NOME")})	// Razao Social
TRCell():New(oDupl,"DEMISSAO"	,/*Tabela*/,RetTitle("E1_EMISSAO"	),PesqPict("SE1","E1_EMISSAO"	),TamSx3("E1_EMISSAO"	)[1],/*lPixel*/,{|| dEmissao 	                    })	// Data Emissao do Titulo
TRCell():New(oDupl,"DVENCREA"	,/*Tabela*/,RetTitle("E1_VENCREA"	),PesqPict("SE1","E1_VENCREA"	),TamSx3("E1_VENCREA"	)[1],/*lPixel*/,{|| dVencRea 	                    })	// Vencimento do Titulo
TRCell():New(oDupl,"NVALOR"		,/*Tabela*/,RetTitle("E1_VALOR"		),PesqPict("SE1","E1_VALOR"		),TamSx3("E1_VALOR"		)[1],/*lPixel*/,{|| nValor 		                    })	// Valor
TRCell():New(oDupl,"CSUPERVI"	,/*Tabela*/,RetTitle("E1_SUPERVI"	),PesqPict("SE1","E1_SUPERVI"	),TamSx3("E1_SUPERVI"	)[1],/*lPixel*/,{|| cSupervi 	                    })	// Supervisor
TRCell():New(oDupl,"CVENDEDOR"	,/*Tabela*/,STR0032					 ,PesqPict("SE1","E1_VEND1"		),TamSx3("E1_VEND1"		)[1],/*lPixel*/,{|| cVendedor 	                    })	// "Vendedor"
TRCell():New(oDupl,"CPEDIDO"	,/*Tabela*/,RetTitle("E1_PEDIDO"	),PesqPict("SE1","E1_PEDIDO"	),TamSx3("E1_PEDIDO"	)[1],/*lPixel*/,{|| cPedido		                    })	// Numero do Pedido de Vendas

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizador da Secao e Geral                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTotal := TRFunction():New(oDupl:Cell("NVALOR"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Cabecalho no top da pagina                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):SetHeaderPage()

// Alinhamento a direita do titulo da coluna de valor
oDupl:Cell("NVALOR"):SetHeaderAlign("RIGHT")

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Marco Bianchi          ³ Data ³28/06/2006³±±
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
Static Function ReportPrint(oReport,cAliasQry,oTotal,oDupl)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaracao de Variaveis                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lQuery    := .F.
Local nX	 	:= 0
Local nVend 	:= 0
Local cWhere 	:= ""
Local cOrder 	:= ""
LOCAL nAc1   	:= 0
Local nAg1   	:= 0
Local nNcc1  	:= 0                       
Local nNcc2  	:= 0
Local cVend		:= ""
Local aCampos	:= {}
Local cProxVend	:= ""
Local aTamSXG  	:= TamSXG("001")
Local aTamSXG2 	:= TamSXG("002")
Local nLin		:= 0
Local cCampo  	:= ""
Local cQuebra 	:= ""
Local cCondicao := ""
Local oTempTable:= Nil 	
              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o numero de Vendedores que existe na estrutura  SE1 		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nVend 	:= Fa440CntVen()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SetBlock: faz com que as variaveis locais possam ser         ³
//³ utilizadas em outras funcoes nao precisando declara-las      ³
//³ como private											  	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Cell("CPREFIXO" 	):SetBlock({|| cPrefixo		                     })
oReport:Section(1):Cell("CNUM" 		):SetBlock({|| cNum			                     })
oReport:Section(1):Cell("CPARCELA" 	):SetBlock({|| cParcela		                     })
oReport:Section(1):Cell("CCLIENTE" 	):SetBlock({|| cCliente		                     })
oReport:Section(1):Cell("CLOJA" 	):SetBlock({|| cLoja		                     })
oReport:Section(1):Cell("CNOME" 	):SetBlock({|| FATPDObfuscate(cNome, "A1_NOME")  })
oReport:Section(1):Cell("DEMISSAO" 	):SetBlock({|| dEmissao		                     })
oReport:Section(1):Cell("DVENCREA" 	):SetBlock({|| dVencRea		                     })
oReport:Section(1):Cell("NVALOR" 	):SetBlock({|| nValor		                     })
oReport:Section(1):Cell("CSUPERVI" 	):SetBlock({|| cSupervi		                     })
oReport:Section(1):Cell("CVENDEDOR"	):SetBlock({|| cVendedor	                     })
oReport:Section(1):Cell("CPEDIDO" 	):SetBlock({|| cPedido		                     })
cPrefixo	:= ""
cNum		:= ""
cParcela	:= ""
cCliente	:= ""
cLoja 		:= ""
cNome		:= ""
dEmissao	:= CTOD("  /  /  ")
dVendRea	:= CTOD("  /  /  ")
nValor 		:= 0
cSupervi	:= ""
cVendedor	:= ""
cPedido		:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se havera salto de pagina na quebra da secao   	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If oReport:Section(1):GetOrder() == 1 .AND. MV_PAR14 == 1
	oBreak := TRBreak():New(oDupl,{ || (cAliasQry)->E1_PREFIXO+(cAliasQry)->E1_NUM+(cAliasQry)->E1_PARCELA },STR0034,.F.) 			// por Numero
ElseIf oReport:Section(1):GetOrder() == 2		
	oBreak := TRBreak():New(oDupl,oDupl:Cell("DEMISSAO" ),STR0034,.F.) 	// por Emissao
ElseIf oReport:Section(1):GetOrder() == 3		
	oBreak := TRBreak():New(oDupl,oDupl:Cell("DVENCREA" ),STR0035,.F.) 	// por Vencimento Real
ElseIf oReport:Section(1):GetOrder() == 4		
	oBreak := TRBreak():New(oDupl,oDupl:Cell("CVENDEDOR" ),STR0038,.F.) 	// por Vendedor
ElseIf oReport:Section(1):GetOrder() == 5		
	oBreak := TRBreak():New(oDupl,oDupl:Cell("CCLIENTE" ),STR0036,.F.) 	// por Cliente
EndIf

If (oReport:Section(1):GetOrder() > 1) .OR. (oReport:Section(1):GetOrder() == 1 .AND. MV_PAR14 == 1)
	oTotal:SetBreak(oBreak)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera o Titulo do Relatorio de acordo com parametros	 	 ³
//³ Ordem: 1=Numero 2=Emissao 3=Vencimento 4=Vendedor 5=Cliente  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " - " + IIf(oReport:Section(1):GetOrder() == 1,STR0029,IIF(oReport:Section(1):GetOrder()==2,STR0030,IIF(oReport:Section(1):GetOrder()==3,STR0031,IIF(oReport:Section(1):GetOrder()==4,STR0032,STR0033)))) + " - " + GetMv("MV_MOEDA"+STR(mv_par13,1)) )	// "Relacao de Duplicatas"###"Numero"###"Emissao"###"Vencimento"###"Vendedor"###"Cliente"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se havera salto de pagina na quebra da secao   	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (oReport:Section(1):GetOrder() > 1) .OR. (oReport:Section(1):GetOrder() == 1 .AND. MV_PAR14 == 1)
	If mv_par14 == 1		// Pula pagina na quebra da secao
		oBreak:SetPageBreak(.T.)
	Else	
		oBreak:SetPageBreak(.F.)
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta Query de acordo com parametros                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lQuery := .T.
cWhere := "%"	
If mv_par05 = 2 
	cWhere  += " AND E1_SALDO > 0"
EndIf
cWhere += "%"	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Order de acordo com escolha do cliente                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE1")
cOrder := ""
If oReport:Section(1):GetOrder() == 1			// por Titulo
	cOrder := "%E1_FILIAL,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO%"
ElseIf oReport:Section(1):GetOrder() == 2		// por Emissao
	cOrder := "%E1_FILIAL,E1_EMISSAO,E1_NOMCLI,E1_PREFIXO,E1_NUM,E1_PARCELA%"
ElseIf oReport:Section(1):GetOrder() == 3		// por Vencimento Real
	cOrder := "%E1_FILIAL,E1_VENCREA,E1_NOMCLI,E1_PREFIXO,E1_NUM,E1_PARCELA%"
ElseIf oReport:Section(1):GetOrder() == 5		// por Cliente
	cOrder := "%E1_FILIAL,E1_CLIENTE,E1_LOJA,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO%"
Else
	cOrder := "%E1_FILIAL,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO%"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()	
BeginSql Alias cAliasQry
SELECT E1_FILIAL,E1_NUM,E1_PREFIXO,E1_EMISSAO,E1_VENCREA,E1_CLIENTE,E1_LOJA,E1_VALOR,
E1_SUPERVI,E1_MOEDA,E1_PEDIDO,E1_TIPO,E1_PARCELA,E1_VEND1,E1_VEND2,E1_VEND3,E1_VEND4,E1_VEND5,A1_NOME
FROM %Table:SE1% SE1, %Table:SA1% SA1
WHERE E1_FILIAL = %xFilial:SE1%
	AND E1_NUM >= %Exp:mv_par01% AND E1_NUM <= %Exp:mv_par02%
	AND E1_PREFIXO >= %Exp:mv_par06% AND E1_PREFIXO <= %Exp:mv_par17%
	AND E1_EMISSAO >= %Exp:DTOS(mv_par07)% AND E1_EMISSAO <= %Exp:DTOS(mv_par08)%
	AND E1_VENCREA >= %Exp:DTOS(mv_par09)% AND E1_VENCREA <= %Exp:DTOS(mv_par10)%
	AND E1_CLIENTE >= %Exp:mv_par11% AND E1_CLIENTE <= %Exp:mv_par12%
	AND SE1.%NotDel% 
	AND A1_FILIAL = %xFilial:SA1% 
	AND E1_CLIENTE = A1_COD
	AND E1_LOJA = A1_LOJA
	AND SA1.%NotDel%
	%Exp:cWhere%
ORDER BY %Exp:cOrder%	
EndSql 
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If oReport:Section(1):GetOrder() == 4		// Relatorio por Vendedor
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria arquivo de trabalho                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	AADD(aCampos,{ "TRB_CLIE"		,"C",aTamSXG[1]			,0	} )
	AADD(aCampos,{ "TRB_LOJA"		,"C",aTamSXG2[1]		,0	} )
	AADD(aCampos,{ "TRB_VEND"		,"C",06					,0	} )
	AADD(aCampos,{ "TRB_PREFIX"		,"C",03					,0	} )
	AADD(aCampos,{ "TRB_NUM"		,"C",TamSX3("F2_DOC")[1],0	} )
	AADD(aCampos,{ "TRB_PARCEL"		,"C",TamSx3("E1_PARCELA"	)[1],0	} )
	AADD(aCampos,{ "TRB_EMISSA"		,"D",08					,0	} )
	AADD(aCampos,{ "TRB_VENCRE"		,"D",08					,0	} )
	AADD(aCampos,{ "TRB_VALOR"		,"N",17					,02 } )
	AADD(aCampos,{ "TRB_SUPERV"		,"C",06					,0 	} )
	AADD(aCampos,{ "TRB_PEDIDO"		,"C",06					,0 	} )
	AADD(aCampos,{ "TRB_TIPO"	   	,"C",03					,0 	} )
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria arquivo de trabalho                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//-------------------------------------------------------------------
	// Instancia tabela temporária.  
	//-------------------------------------------------------------------
	
	oTempTable	:= FWTemporaryTable():New( "TRB" )
	
	//-------------------------------------------------------------------
	// Atribui o  os índices.  
	//-------------------------------------------------------------------
	oTempTable:SetFields( aCampos )
	oTempTable:AddIndex("1",{"TRB_VEND", "TRB_CLIE", "TRB_LOJA"})
		
	//------------------
	//Criação da tabela
	//------------------
	oTempTable:Create()
	
	dbSelectArea(cAliasQry)
	dbGoTop()
	
	While !Eof() .AND. xFilial("SE1")=E1_FILIAL
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Desconsidera Abatimentos                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If	( E1_TIPO $ MVABATIM ) .AND. ( MV_PAR16 == 2 )
			dbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Processa todos Vendedores existentes no arquivo SE1          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cProxVend := "1"
		For nx := 1 To nVend
			cVend := FieldGet(FieldPos("E1_VEND"+cProxVend))
			If ( !Empty(cVend) .OR. nx==1 ).AND. ;
				(cVend >= mv_par03	.AND. cVend	<= mv_par04)
				RecLock("TRB",.T.)
				Replace	TRB_LOJA  	With (cAliasQry)->E1_LOJA,;
				TRB_CLIE	With (cAliasQry)->E1_CLIENTE,;
				TRB_VEND	With cVend,;
				TRB_PREFIX	With (cAliasQry)->E1_PREFIXO,;
				TRB_NUM	 	With (cAliasQry)->E1_NUM,;
				TRB_PARCEL 	With (cAliasQry)->E1_PARCELA,;
				TRB_EMISSA	With (cAliasQry)->E1_EMISSAO,;
				TRB_VENCRE	With (cAliasQry)->E1_VENCREA,;
				TRB_VALOR	With xMoeda((cAliasQry)->E1_VALOR,(cAliasQry)->E1_MOEDA,MV_PAR13,(cAliasQry)->E1_EMISSAO),;
				TRB_SUPERV 	With (cAliasQry)->E1_SUPERVI,;
				TRB_PEDIDO  With (cAliasQry)->E1_PEDIDO,;
				TRB_TIPO   	With (cAliasQry)->E1_TIPO
				MsUnlock()
				DbSelectArea(cAliasQry)
			Endif
			cProxVend := Soma1(cProxVend, 1)
		Next
		
		dbSelectArea(cAliasQry)
		dbSkip()
		oReport:IncMeter()
		
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os dados selecionados no arquivo de trabalho         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "TRB" )
	dbGoTop()
	oReport:SetMeter(RecCount())
	oReport:Section(1):Init()
	cVendAnt:= TRB->TRB_VEND
	nAc1 	:= 0
	nNcc2	:= 0
	
	While !Eof()
		
		dbSelectArea("SA3")
		dbSeek(xFilial("SA3")+TRB->TRB_VEND)
		
		dbSelectArea("SA1")
		dbSeek(xFilial()+TRB->TRB_CLIE+TRB->TRB_LOJA)
		dbSelectArea("TRB")
		
		cPrefixo	:= TRB->TRB_PREFIX
		cNum		:= TRB->TRB_NUM
		cParcela	:= TRB->TRB_PARCEL
		cCliente	:= TRB->TRB_CLIE
		cLoja 		:= TRB->TRB_LOJA
		cNome		:= SA1->A1_NOME
		dEmissao	:= TRB->TRB_EMISSA
		dVencRea	:= TRB->TRB_VENCRE
		nValor 		:= TRB->TRB_VALOR
		nValor 		:= IIf( (TRB->TRB_TIPO $ MVABATIM .AND. MV_PAR16 == 3),-nValor,nValor)
		cSupervi	:= TRB->TRB_SUPERV
		cVendedor	:= TRB_VEND
		cPedido		:= TRB->TRB_PEDIDO
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Quebra para impressao do Total Liquido da Secao	   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cVendAnt <> TRB->TRB_VEND
			nLin := oReport:Row() + 20
			If (nAc1 - nNcc2) > 0 
				oReport:PrintText(STR0037 + "(-"+left(MV_CRNEG+"/"+MVRECANT,6)+")",nLin) 		// "Total Liquido"
				oReport:PrintText(Transform(nAc1 - nNcc2,PesqPict("SE1","E1_VALOR")),nLin,(oReport:Section(1):Cell("NVALOR"):ColPos()-40))
			EndIF 
			cVendAnt := TRB->TRB_VEND
			nAc1 := 0
			nNcc2:= 0
			oReport:SkipLine(2)
		EndIf
		
		// Imprime Linha de Detalhes
		oReport:Section(1):PrintLine()
		
		If ( TRB->TRB_TIPO $ MVABATIM ) .AND. !( MV_PAR16 == 1 )
			If MV_PAR16 == 3
				nAc1 -= TRB->TRB_VALOR
				nAg1 -= TRB->TRB_VALOR
			EndIf
		Else
			nAc1 += TRB->TRB_VALOR
			nAg1 += TRB->TRB_VALOR
		EndIf
		
		If ( TRB->TRB_TIPO $ MV_CRNEG+"/"+MVRECANT )
			nNcc1 += TRB->TRB_VALOR
			nNcc2 += TRB->TRB_VALOR
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Altera texto do Total daa Secao                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oBreak:SetTotalText(STR0038 + SA3->A3_COD + " " + SA3->A3_NOME)		// "Total do Vendedor ==> "
		
		dbSelectArea("TRB")
		dbSkip()
		
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do Total Liquido da ultima quebra					   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLin := oReport:Row() + 20
	If (nAc1 - nNcc2) > 0 
		oReport:PrintText(STR0037 + "(-"+left(MV_CRNEG+"/"+MVRECANT,6)+")",nLin) 		// "Total Liquido"
		oReport:PrintText(Transform(nAc1 - nNcc2,PesqPict("SE1","E1_VALOR")),nLin,(oReport:Section(1):Cell("NVALOR"):ColPos()-40))
	EndIf
	cVendAnt := TRB->TRB_VEND
	oReport:SkipLine(2)


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Total Geral do Relatorio									   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):Finish()
	oReport:Section(1):SetPageBreak(.T.)
	nLin := oReport:Row() + 80
	If (nAg1 - nNcc1) > 0 
		oReport:PrintText(STR0037 + "(-"+left(MV_CRNEG+"/"+MVRECANT,6)+")",nLin)		// "Total Liquido"
		oReport:PrintText(Transform(nAg1 - nNcc1,PesqPict("SE1","E1_VALOR")),nLin,(oReport:Section(1):Cell("NVALOR"):ColPos()-40))
	EndIf
Else

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa Variaveis                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If oReport:Section(1):GetOrder() == 1 .AND. MV_PAR14 == 1			// Quebra por Prefixo+ Numero titulo + Parcela
		cCampo  :=  "E1_PREFIXO+E1_NUM+E1_PARCELA"
		cQuebra := (cAliasQry)->E1_PREFIXO+(cAliasQry)->E1_NUM+(cAliasQry)->E1_PARCELA
	ElseIf oReport:Section(1):GetOrder() == 2							// Quebra por Data + Numero titulo
		cCampo  :=  "E1_EMISSAO"
		cQuebra := (cAliasQry)->E1_EMISSAO
	Elseif oReport:Section(1):GetOrder() == 3							// Quebra por Data Vencimento
		cCampo :=  "E1_VENCREA"
		cQuebra := (cAliasQry)->E1_VENCREA
	Elseif oReport:Section(1):GetOrder() == 5							// Quebra por Cliente
		cCampo :=  "E1_CLIENTE"
		cQuebra := (cAliasQry)->E1_CLIENTE		
	Endif
	nAc1 := 0
	nNcc2:= 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia Impressao                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SetMeter((cAliasQry)->(LastRec()))
	oReport:Section(1):Init()
	dbSelectArea(cAliasQry)
	dbGoTop()

	While !oReport:Cancel() .AND. E1_FILIAL == xFilial("SE1") .AND. !(cAliasQry)->(Eof())
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Desconsidera Abatimentos                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If	( (cAliasQry)->E1_TIPO $ MVABATIM ) .AND. ( MV_PAR16 == 2 )
			dbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Filtra os vendedores selecionados na pergunte                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cProxVend := "1"
		lProcVend := .F.
		For nx := 1 To nVend
			cVend := FieldGet(FieldPos("E1_VEND"+cProxVend))
			If ( cVend >= mv_par03	.AND. cVend	<= mv_par04 )
				lProcVend := .T.
				Exit
			Endif
			cProxVend := Soma1(cProxVend, 1)
		Next
		
		If !lProcVend
			dbskip()
			loop
		Endif
		
		cPrefixo	:= (cAliasQry)->E1_PREFIXO
		cNum		:= (cAliasQry)->E1_NUM
		cParcela	:= (cAliasQry)->E1_PARCELA
		cCliente	:= (cAliasQry)->E1_CLIENTE
		cLoja 		:= (cAliasQry)->E1_LOJA
		cNome		:= (cAliasQry)->A1_NOME
		dEmissao	:= (cAliasQry)->E1_EMISSAO
		dVencRea	:= (cAliasQry)->E1_VENCREA
		nValor 		:= xMoeda((cAliasQry)->E1_VALOR,(cAliasQry)->E1_MOEDA,MV_PAR13,(cAliasQry)->E1_EMISSAO)
		nValor 		:= IIf( ((cAliasQry)->E1_TIPO $ MVABATIM .AND. MV_PAR16 == 3),-nValor,nValor)
		cSupervi	:= (cAliasQry)->E1_SUPERVI
		cVendedor	:= cVend
		cPedido		:= (cAliasQry)->E1_PEDIDO
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Quebra para impressao do Total Liquido da Secao	   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasQry)		
		If oReport:Section(1):GetOrder() > 1
			If cQuebra <> &cCampo
				nLin := oReport:Row() + 20
				If (nAc1 - nNcc2) > 0
					oReport:PrintText(STR0037 + "(-"+left(MV_CRNEG+"/"+MVRECANT,6)+")",nLin) 		// "Total Liquido"
					oReport:PrintText(Transform(nAc1 - nNcc2,PesqPict("SE1","E1_VALOR")),nLin,(oReport:Section(1):Cell("NVALOR"):ColPos()-40))
				EndIf
				cQuebra := &cCampo
				nAc1 := 0
				nNcc2:= 0
				oReport:SkipLine(2)
			EndIf
		ElseIf oReport:Section(1):GetOrder() == 1 .AND. MV_PAR14 == 1
			cQuebra := &cCampo
			nAc1 := 0
			nNcc2:= 0
		EndIf
		
		// Imprime Linha de Detalhe
		oReport:Section(1):PrintLine()

		
		If ( (cAliasQry)->E1_TIPO $ MVABATIM ) .AND. !( MV_PAR16 == 1 )
			If MV_PAR16 == 3
				nAc1	-= xMoeda((cAliasQry)->E1_VALOR,(cAliasQry)->E1_MOEDA,MV_PAR13, (cAliasQry)->E1_EMISSAO)
				nAg1	-= xMoeda((cAliasQry)->E1_VALOR,(cAliasQry)->E1_MOEDA,MV_PAR13, (cAliasQry)->E1_EMISSAO)
			EndIf
		Else
			nAc1	+= xMoeda((cAliasQry)->E1_VALOR,(cAliasQry)->E1_MOEDA,MV_PAR13, (cAliasQry)->E1_EMISSAO)
			nAg1	+= xMoeda((cAliasQry)->E1_VALOR,(cAliasQry)->E1_MOEDA,MV_PAR13, (cAliasQry)->E1_EMISSAO)
		EndIf
		If ( (cAliasQry)->E1_TIPO $ MV_CRNEG+"/"+MVRECANT )
			nNcc1 += xMoeda((cAliasQry)->E1_VALOR,(cAliasQry)->E1_MOEDA,MV_PAR13, (cAliasQry)->E1_EMISSAO)
			nNcc2 += xMoeda((cAliasQry)->E1_VALOR,(cAliasQry)->E1_MOEDA,MV_PAR13, (cAliasQry)->E1_EMISSAO)
		Endif
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Altera texto do Total da Secao                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If oReport:Section(1):GetOrder() ==1 .AND. MV_PAR14 == 1
			oBreak:SetTotalText(RetTitle("E1_VALOR") + " ==> " + (&cCampo))		// "Valor do Titulo"		
		ElseIf oReport:Section(1):GetOrder() == 2
			oBreak:SetTotalText(STR0034 + DTOC(&cCampo))			 				// "Total dos Emitidos em ==> "
		Elseif oReport:Section(1):GetOrder() == 3
			oBreak:SetTotalText(STR0035 + DTOC(&cCampo))		   					// "Total dos Vencidos em ==> "
		Elseif oReport:Section(1):GetOrder() == 5
			dbSelectArea("SA1")
			dbSeek(xFilial()+cCliente)
			oBreak:SetTotalText(STR0036 + cCliente + " "+SA1->A1_NOME)				// "Total do Cliente ==> "
		EndIf
		
		dbSelectArea(cAliasQry)
		dbSkip()
		oReport:IncMeter()
		
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do Total Liquido da ultima quebra					   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (oReport:Section(1):GetOrder() > 1) .OR. (oReport:Section(1):GetOrder() == 1 .AND. MV_PAR14 == 1)
		nLin := oReport:Row() + 20
		If (nAc1 - nNcc2) > 0
			oReport:PrintText(STR0037 + "(-"+left(MV_CRNEG+"/"+MVRECANT,6)+")",nLin) 		// "Total Liquido"
			oReport:PrintText(Transform(nAc1 - nNcc2,PesqPict("SE1","E1_VALOR")),nLin,(oReport:Section(1):Cell("NVALOR"):ColPos()-40))
		EndIf
		cCliAnt := (cAliasQry)->E1_CLIENTE
		oReport:SkipLine(2)
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Total Geral do Relatorio									   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (oReport:Section(1):GetOrder() > 1) .OR. (oReport:Section(1):GetOrder() == 1 .AND. MV_PAR14 == 1)
		oReport:Section(1):Finish()
		oReport:Section(1):SetPageBreak(.T.)
	EndIf
	nLin := oReport:Row() + 80
	If (nAg1 - nNcc1) > 0
		oReport:PrintText(STR0037 + "(-"+left(MV_CRNEG+"/"+MVRECANT,6)+")",nLin)		// "Total Liquido"
		oReport:PrintText(Transform(nAg1 - nNcc1,PesqPict("SE1","E1_VALOR")),nLin,(oReport:Section(1):Cell("NVALOR"):ColPos()-40))
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha Query                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !Empty(cAliasQry)
	(cAliasQry)->(dbCloseArea())
EndIf

If oReport:Section(1):GetOrder() == 4
	//---------------------------------
	//Exclui  tabelas temporárias TRB
	//---------------------------------
	If( valtype(oTempTable) == "O")
		oTempTable:Delete()
		freeObj(oTempTable)
		oTempTable := nil
	EndIf
EndIf

Return


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