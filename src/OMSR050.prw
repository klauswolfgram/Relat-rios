/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "OMSR050.CH"
#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ OMSR050  ³ Autor ³ Marco Bianchi         ³ Data ³ 03/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Cargas (Prestacao de Contas) - Release 4.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAOMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function OMSR050()
Local oReport := Nil

	If FindFunction("OMSMsgRelD")
		OMSMsgRelD()
	EndIf

	If FindFunction("TRepInUse") .And. TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	Else
		U_OMSR050R3()
	EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 03/08/06 ³±±
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

#IFDEF TOP
Local cAliasSF2 := GetNextAlias()
Local cAliasDAK := cAliasSF2 
Local cAliasSA1 := cAliasSF2

#ELSE
	Local cAliasSF2 := "SF2"
	Local cAliasDAK := "DAK"
	Local cAliasSA1 := "SA1"
#ENDIF

Local cTipoBx	:= ""
Local cNum		:= ""
Local cPrefixo	:= ""
Local cParcela	:= ""
Local cTipo		:= ""
Local nValor	:= 0

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
oReport := TReport():New("OMSR050",STR0025,"OMR050", {|oReport| ReportPrint(oReport,cAliasSF2,cAliasDAK,cAliasSA1)},STR0026 + " " + STR0027 + " " + STR0028)	// "Prestacao de Contas"###"Este programa ira emitir a Relacao dos Titulos na"###"Prestacao de contas de acordo com os parametros es-"###"colhidos pelo usuario                      ."
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
//³ExpC2 : Nome da celula do relatorio. O SX3 sera consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de codigo para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Carga - Section(1)                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCarga := TRSection():New(oReport,STR0040,{"DAK","SF2","SA1","SE1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Prestacao de Contas (Conferencia)"
oCarga:SetLineStyle(.T.)
oCarga:SetTotalInLine(.F.)
TRCell():New(oCarga,"DAK_COD"		,"DAK",RetTitle("DAK_COD"		),PesqPict("DAK","DAK_COD"		),TamSx3("DAK_COD"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_SEQCAR"	,"DAK",RetTitle("DAK_SEQCAR"	),PesqPict("DAK","DAK_SEQCAR"	),TamSx3("DAK_SEQCAR"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_CAMINH"	,"DAK",RetTitle("DAK_CAMINH"	),PesqPict("DAK","DAK_CAMINH"	),TamSx3("DAK_CAMINH"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DA3_DESC"		,"DA3",RetTitle("DA3_DESC"		),PesqPict("DA3","DA3_DESC"		),TamSx3("DA3_DESC"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_MOTORI"	,"DAK",RetTitle("DAK_MOTORI"	),PesqPict("DAK","DAK_MOTORI"	),TamSx3("DAK_MOTORI"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DA4_NOME"		,"DA4",RetTitle("DA4_NOME"		),PesqPict("DA4","DA4_NOME"		),TamSx3("DA4_NOME"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_PESO"		,"DAK",RetTitle("DAK_PESO"		),PesqPict("DAK","DAK_PESO"		),TamSx3("DAK_PESO"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_CAPVOL"	,"DAK",RetTitle("DAK_CAPVOL"	),PesqPict("DAK","DAK_CAPVOL"	),TamSx3("DAK_CAPVOL"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_PTOENT"	,"DAK",RetTitle("DAK_PTOENT"	),PesqPict("DAK","DAK_PTOENT"	),TamSx3("DAK_PTOENT"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_VALOR"		,"DAK",RetTitle("DAK_VALOR"		),PesqPict("DAK","DAK_VALOR"	),TamSx3("DAK_VALOR"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_DATA"		,"DAK",RetTitle("DAK_DATA"		),/*Picture*/                    ,/*Tamanho*/               ,/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cliente - Section(1):Section(1)                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCliente := TRSection():New(oCarga,STR0041,{"SF2","SA1"},/*{Array com as ordens do relatorio}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Prestacao de Contas (Conferencia)"
oCliente:SetTotalInLine(.F.)
TRCell():New(oCliente,"F2_CLIENTE"	,"SF2",RetTitle("F2_CLIENTE"	),PesqPict("SF2","F2_CLIENTE"	),TamSx3("F2_CLIENTE"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"F2_LOJA"		,"SF2",RetTitle("F2_LOJA"		),PesqPict("SF2","F2_LOJA"		),TamSx3("F2_LOJA"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"A1_NOME"		,"SA1",RetTitle("A1_NOME"		),PesqPict("SA1","A1_NOME"		),TamSx3("A1_NOME"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Titulos - Section(1):Section(1):Section(1)                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTitulos := TRSection():New(oCliente,STR0042,{"SE1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Prestacao de Contas (Conferencia)"
oTitulos:SetTotalInLine(.F.)
TRCell():New(oTitulos,"E1_PREFIXO"	,"SE1"		,RetTitle("E1_PREFIXO"	),PesqPict("SE1","E1_PREFIXO"	),TamSx3("E1_PREFIXO"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)
TRCell():New(oTitulos,"E1_NUM"		,"SE1"		,RetTitle("E1_NUM"		),PesqPict("SE1","E1_NUM"		),TamSx3("E1_NUM"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)
TRCell():New(oTitulos,"E1_TIPO"		,"SE1"		,RetTitle("E1_TIPO"		),PesqPict("SE1","E1_TIPO"		),TamSx3("E1_TIPO"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)
TRCell():New(oTitulos,"E1_PARCELA"	,"SE1"		,RetTitle("E1_PARCELA"	),PesqPict("SE1","E1_PARCELA"	),TamSx3("E1_PARCELA"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)
TRCell():New(oTitulos,"E1_VALOR"	,"SE1"		,RetTitle("E1_VALOR"	),PesqPict("SE1","E1_VALOR"		),TamSx3("E1_VALOR"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)
TRCell():New(oTitulos,"E1_SALDO"	,"SE1"		,RetTitle("E1_SALDO"	),PesqPict("SE1","E1_SALDO"		),TamSx3("E1_SALDO"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)
TRCell():New(oTitulos,"E1_VENCREA"	,"SE1"		,RetTitle("E1_VENCREA"	),PesqPict("SE1","E1_VENCREA"	),TamSx3("E1_VENCREA"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)
TRCell():New(oTitulos,"DESCFIN"		,/*Tabela*/	,RetTitle("E1_DESCFIN"	),PesqPict("SE1","E1_DESCFIN"	),TamSx3("E1_DESCFIN"	)[1],/*lPixel*/,{|| FaDescFin(,,,,.T.) }	)                        

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Titulos - Section(1):Section(1):Section(1):Section(1)                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oBaixas := TRSection():New(oTitulos,STR0043,{"SE1","DAM","SE5","SEL"},/*{Array com as ordens do relatorio}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Prestacao de Contas (Conferencia)"
oBaixas:SetTotalInLine(.F.)
TRCell():New(oBaixas,"CTEXTO"	,/*Tabela*/	,STR0035	,/*Picture*/					 ,/*Tamanho*/				,/*lPixel*/,/*{|| code-block de impressao }*/	)	// "B   A   I   X   A   S"
TRCell():New(oBaixas,"CTIPOBX"	,/*Tabela*/	,STR0029	,PesqPict("SE5","E5_MOTBX"		),TamSx3("E5_MOTBX"		)[1],/*lPixel*/,{|| cTipoBx		}					)	// "TP BAIXA"
TRCell():New(oBaixas,"CNUM"		,/*Tabela*/	,STR0030	,PesqPict("SE1","E1_NUM"		),TamSx3("E1_NUM"		)[1],/*lPixel*/,{|| cNum		}					)	// "NUMERO/CHEQUE"
TRCell():New(oBaixas,"CPREFIXO"	,/*Tabela*/	,STR0031	,PesqPict("SE1","E1_PREFIXO"	),TamSx3("E1_PREFIXO"	)[1],/*lPixel*/,{|| cPrefixo	}					)	// "BANCO/PREFIXO"
TRCell():New(oBaixas,"CPARCELA"	,/*Tabela*/	,STR0032	,PesqPict("SE1","E1_PARCELA"	),TamSx3("E1_PARCELA"	)[1],/*lPixel*/,{|| cParcela	}					)	// "AGENCIA/PARCELA"
TRCell():New(oBaixas,"CTIPO"	,/*Tabela*/	,STR0033	,PesqPict("SE1","E1_TIPO"		),TamSx3("E1_TIPO"		)[1],/*lPixel*/,{|| cTipo		}					)	// "NUMERO/TIPO"
TRCell():New(oBaixas,"NVALOR"	,/*Tabela*/	,STR0034	,PesqPict("SE1","E1_VALOR"		),TamSx3("E1_VALOR"		)[1],/*lPixel*/,{|| nValor		}					)	// "VALOR"

TRFunction():New(oBaixas:Cell("NVALOR"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Impressao do cabecalho no topo da pagina                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):section(1):SetHeaderPage(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Altera texto do total da secao                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):section(1):Section(1):SetTotalText(STR0039)	// "TOTAL DAS BAIXAS =>"

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 03/05/06 ³±±
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
Static Function ReportPrint(oReport,cAliasSF2,cAliasDAK,cAliasSA1)

Local lQuery    := .F.
Local nTipoOper := OsVlEntCom()
Local lSkip  	:= .F.
Local cFilSA1 	:= ""

#IFNDEF TOP
	Local cCondicao := ""
#ELSE
	Local cWhere := ""
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("DAK")		// Cargas
dbSetOrder(2)			// Data,Hora,Carga,Sequencia

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tratamento de filial do SA1. Retira as aspas retornadas pela função    ³
//³ OsFilQry.                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFilSA1 := Iif(nTipoOper <> 1, OsFilQry("SA1","SF2.F2_FILIAL"),xFilial("SA1") )
If Substr(cFilSA1,1,1) == "'"
	cFilSA1 := Substr(cFilSA1,2,2)
EndIf

#IFDEF TOP

	If TcSrvType() != "AS/400"

		lQuery   := .T.
		cWhere := "%"
		If nTipoOper <> 1
			cWhere += "SF2.F2_FILIAL = '"+xFilial("SF2") + "' AND"
		Endif
		cWhere += "%"

		oReport:Section(1):BeginQuery()
		BeginSql Alias cALiasDAK
		SELECT SF2.*, DAK.*,A1_NOME
		FROM %Table:SF2% SF2, %Table:SA1% SA1, %Table:DAK% DAK

		LEFT JOIN %Table:DA3% DA3
			ON DA3.DA3_FILIAL = %xFilial:DA3% AND DA3.DA3_COD = DAK.DAK_CAMINH AND DA3.%Notdel%
		LEFT JOIN %Table:DA4% DA4
			ON DA4.DA4_FILIAL = %xFilial:DA4% AND DA4.DA4_COD = DAK.DAK_MOTORI AND DA4.%Notdel%

		WHERE
		SF2.F2_CARGA >= %Exp:mv_par01% AND
		SF2.F2_CARGA <= %Exp:mv_par02% AND
		SF2.F2_SEQCAR>= %Exp:mv_par03% AND
		SF2.F2_SEQCAR<= %Exp:mv_par04% AND

		SF2.F2_TIPO <>'D' AND
		SF2.F2_TIPO <>'B' AND
		SF2.F2_CLIENTE >= %Exp:mv_par11% AND
		SF2.F2_CLIENTE <= %Exp:mv_par12% AND
		SF2.F2_LOJA >= %Exp:mv_par13% AND
		SF2.F2_LOJA <= %Exp:mv_par14% AND
		%Exp:cWhere%
		SF2.%NotDel% AND

		DAK.DAK_FILIAL = %xFilial:DAK% AND
		DAK.DAK_COD = SF2.F2_CARGA AND
		DAK.DAK_SEQCAR = SF2.F2_SEQCAR AND
		DAK.DAK_CAMINH >= %Exp:mv_par05% AND
		DAK.DAK_CAMINH <= %Exp:mv_par06% AND
		DAK.DAK_MOTORI >= %Exp:mv_par07% AND
		DAK.DAK_MOTORI <= %Exp:mv_par08% AND
		DAK.DAK_DATA   >= %Exp:Dtos(mv_par09)% AND
		DAK.DAK_DATA   <= %Exp:Dtos(mv_par10)% AND
		(DAK.DAK_ACEFIN = '1' OR DAK.DAK_ACEFIN = '3' )AND
		DAK.%Notdel% AND
		SA1.A1_FILIAL = %Exp:cFilSA1% AND
		SA1.A1_COD = SF2.F2_CLIENTE AND
		SA1.A1_LOJA = SF2.F2_LOJA AND
		SA1.%Notdel%
		ORDER BY SF2.F2_FILIAL,SF2.F2_CARGA,SF2.F2_SEQCAR,SF2.F2_CLIENTE,SF2.F2_LOJA,SF2.F2_DOC
		EndSql
		oReport:Section(1):EndQuery()
		oReport:Section(1):Section(1):SetParentQuery(.T.)

	Else

#ENDIF

		cIndDAK := CriaTrab(NIL,.F.)

		dbSelectArea("DAK")		// Cargas
		dbSetOrder(1)			// Carga,Sequencia
		cCondicao += 'DAK_FILIAL = "'+xFilial("DAK")+'" .And.' 
		cCondicao += 'DAK_COD >= "'+mv_par01+'" .And. DAK_COD <= "'+mv_par02+'" .And.'
		cCondicao += 'DAK_SEQCAR >= "'+mv_par03+'" .And. DAK_SEQCAR <= "'+mv_par04+'" .And.'
		cCondicao += 'DAK_CAMINH >= "'+mv_par05+'" .And. DAK_CAMINH <= "'+mv_par06+'" .And.'
		cCondicao += 'DAK_MOTORI >= "'+mv_par07+'" .And. DAK_MOTORI <= "'+mv_par08+'" .And.'
		cCondicao += 'Dtos(DAK_DATA) >= "'+Dtos(mv_par09)+'" .And. Dtos(DAK_DATA) <= "'+Dtos(mv_par10)+'" .And.'
		cCondicao += '(DAK_ACEFIN == "1" .Or. DAK_ACEFIN == "3" )'
		oReport:Section(1):SetFilter(cCondicao,(cAliasDAK)->(IndexKey()))

		dbSelectArea("SF2")		// Cabecalho da Nota de Saida
		dbSetOrder(2)			// Cliente,Loja,Documento,Serie
		cIndSF2 := CriaTrab(NIL,.F.)

		dbSelectArea("SF2")		// Cabecalho da Nota de Saida
		dbSetOrder(5)			// Carga,Sequencia,Serie,Nota,Cliente,Loja
		If nTipoOper == 1
			cKeySF2 := SF2->(IndexKey())
		Else
			cKeySF2 := "F2_CARGA+F2_SEQCAR+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA"
		Endif

		cCondicao := ""
		cCondicao += 'F2_CARGA >= "'+mv_par01+'".And.F2_CARGA <="'+mv_par02+'".And.'
		cCondicao += 'F2_SEQCAR >= "'+mv_par03+'".And.F2_SEQCAR <="'+mv_par04+'" .And.'
		cCondicao += 'F2_CLIENTE >= "'+mv_par11+'".And.F2_CLIENTE <="'+mv_par12+'".And.'
		cCondicao += 'F2_LOJA >= "'+mv_par13+'".And.F2_LOJA <="'+mv_par14+'"'
		If nTipoOper == 1
			cCondicao += ".And.F2_FILIAL == '"+xFilial("SF2")+"'"
		Endif
		oReport:Section(1):Section(1):SetFilter(cCondicao,cKeySF2)

#IFDEF TOP
	Endif
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo TrPosition()                                                     ³
//³                                                                        ³
//³Posiciona em um registro de uma outra tabela. O posicionamento sera     ³
//³realizado antes da impressao de cada linha do relatorio.                ³
//³                                                                        ³
//³                                                                        ³
//³ExpO1 : Objeto Report da Secao                                          ³
//³ExpC2 : Alias da Tabela                                                 ³
//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
//³ExpX4 : String ou Bloco de código para pesquisa. A string sera macroexe-³
//³        cutada.                                                         ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFNDEF TOP
	TRPosition():New(oReport:Section(1),"DA3",1,{|| xFilial("DA3")+(cAliasDAK)->DAK_CAMINH })
	TRPosition():New(oReport:Section(1),"DA4",1,{|| xFilial("DA4")+(cAliasDAK)->DAK_MOTORI })
	TRPosition():New(oReport:Section(1):Section(1),"SA1",1,{|| xFilial("SA1")+(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA })
#ELSE	
	If TcSrvType() == "AS/400"
		TRPosition():New(oReport:Section(1),"DA3",1,{|| xFilial("DA3")+(cAliasDAK)->DAK_CAMINH })
		TRPosition():New(oReport:Section(1),"DA4",1,{|| xFilial("DA4")+(cAliasDAK)->DAK_MOTORI })
		TRPosition():New(oReport:Section(1):Section(1),"SA1",1,{|| xFilial("SA1")+(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA })
	EndIf
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o bloco de codigo que retornara o conteudo de impres- 		   ³
//³ sao da celula.                                               		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):Section(1):Section(1):Cell("CTIPOBX"		):SetBlock({|| cTipoBx	})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("CNUM"		):SetBlock({|| cNum		})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("CPREFIXO"	):SetBlock({|| cPrefixo	})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("CPARCELA"	):SetBlock({|| cParcela	})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("CTIPO"		):SetBlock({|| cTipo	})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("NVALOR"		):SetBlock({|| nValor	})
cTipoBx	:= ""
cNum	:= ""
cPrefixo:= ""
cParcela:= ""
cTipo	:= ""
nValor	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAliasDAK)->(LastRec()))
dbSelectArea(cAliasDAK)
While !oReport:Cancel() .And. !(cAliasDAK)->(Eof()) .And. (cAliasDAK)->DAK_FILIAL == xFilial("DAK")

	lSkip   := .F.
	oReport:Section(1):Init()
	oReport:Section(1):PrintLine()
	cCodDAK   := (cAliasDAK)->DAK_COD
	cSeqDAK   := (cAliasDAK)->DAK_SEQCAR

	If !lQuery
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Realiza Seek de acordo com o tipo de operacao de filiais³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTipoOper == 1
			cSeekSF2 := xFilial("SF2")+(cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR
		Else
			cSeekSF2 := (cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR
		Endif

		dbSelectArea("SF2")
		MsSeek(cSeekSF2)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Realiza While de acordo com o tipo de operacao de filiais³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTipoOper == 1
			bWhileSF2 :=  {|| (cAliasSF2)->(!Eof()) .And. (cAliasSF2)->F2_FILIAL+(cAliasSF2)->F2_CARGA+(cAliasSF2)->F2_SEQCAR == ;
						xFilial("SF2")+cCodDAK+cSeqDAK }
		Else
			bWhileSF2 :=  {|| (cAliasSF2)->(!Eof()) .And. (cAliasSF2)->F2_CARGA+(cAliasSF2)->F2_SEQCAR == ;
						cCodDAK+cSeqDAK }
		Endif

	Else
		bWhileSF2 :=  {|| (cAliasSF2)->(!Eof()) .And. (cAliasSF2)->F2_CARGA+(cAliasSF2)->F2_SEQCAR == ;
							cCodDAK+cSeqDAK }
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³While da Carga - Section(1)                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While Eval(bWhileSF2)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Guarda variaveis para quebra por cliente                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cCliente := (cAliasSF2)->F2_CLIENTE
		cLoja    := (cAliasSF2)->F2_LOJA

		If !lQuery
			SA1->(dbSetOrder(1))
			SA1->(MsSeek(OsFilial("SA1",(cAliasSF2)->F2_FILIAL)+cCliente+cLoja))
		Endif

		oReport:Section(1):Section(1):Init()
		oReport:Section(1):Section(1):PrintLine()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³While do Cliente - Section(1):Section(1)                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasSF2)
		While (cAliasSF2)->(!Eof()) .And. (cAliasSF2)->F2_FILIAL == xFilial("SF2") .And. ;
										(cAliasSF2)->F2_CLIENTE == cCliente .And. ;
										(cAliasSF2)->F2_LOJA    == cLoja .And. ;
										(cAliasSF2)->F2_CARGA   == cCodDak .And. ;
										(cAliasSF2)->F2_SEQCAR  == cSeqDak 

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³While dos titulos - Section(1):Section(1):Section(1)     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oReport:Section(1):Section(1):Section(1):Init()
			dbSelectArea("SE1")
			dbSetOrder(2)
			MsSeek(xFilial("SE1")+(cAliasSF2)->F2_CLIENTE+(cALiasSF2)->F2_LOJA+(cAliasSF2)->F2_PREFIXO+(cAliasSF2)->F2_DOC)
			While SE1->(!Eof()) .And. SE1->E1_FILIAL == xFilial("SE1") .And.;
											SE1->E1_CLIENTE == (cAliasSF2)->F2_CLIENTE .And.;
											SE1->E1_LOJA == (cAliasSF2)->F2_LOJA .And. ;
											SE1->E1_PREFIXO == (cAliasSF2)->F2_PREFIXO .And. ;
											SE1->E1_NUM == (cAliasSF2)->F2_DOC


				oReport:Section(1):Section(1):Section(1):PrintLine()

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Imprime os dados das baixas caso existam                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea("DAM")
				dbSetOrder(2)
				If MsSeek(xFilial("DAM")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA +;
						SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA )

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Armazena registro do SE1 pois o ponteiro e modificado     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oReport:Section(1):Section(1):Section(1):Section(1):Init()
					aAreaSE1  := SE1->(GetArea())
					While !Eof() .And. DAM->DAM_FILIAL+DAM->DAM_PREFIX+DAM->DAM_NUMERO+DAM->DAM_PARCEL+DAM_TIPO+DAM_CLIENT+DAM_LOJA == ;
									xFilial("DAM")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+;
									SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA

						Do Case
							Case DAM->DAM_TPBAIX == "1"
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³Imprime caso seja baixa simples                           ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								//Quando o pais eh diferente de Brasil as baixas, realizadas atraves da rotina
								//de recibos, estarao gravadas no arquivo SEL.
								If cPaisLoc == "BRA"
									dbSelectArea("SE5")
									dbSetOrder(7)
									MsSeek(OsFilial("SE5",DAM->DAM_FILCR)+DAM->DAM_PREFIX+DAM->DAM_NUMERO+DAM->DAM_PARCEL+DAM->DAM_TIPO+DAM->DAM_CLIENT+DAM->DAM_LOJA+Rtrim(DAM->DAM_SEQBX))

									While SE5->(!Eof()) .And. SE5->E5_FILIAL == OsFilial("SE5",DAM->DAM_FILCR) .And. ;
																SE5->E5_PREFIXO == DAM->DAM_PREFIX .And. ;
																SE5->E5_NUMERO == DAM->DAM_NUMERO .And. ;
																SE5->E5_PARCELA == DAM->DAM_PARCEL .And. ;
																SE5->E5_TIPO == DAM->DAM_TIPO .And. ;
																SE5->E5_CLIFOR == DAM->DAM_CLIENT .And. ;
																SE5->E5_LOJA == DAM->DAM_LOJA .And. ;
																SE5->E5_SEQ == Rtrim(DAM->DAM_SEQBX)

										If SE5->E5_TIPODOC $ "V2#VL#BA"
											OMR050Load(STR0036,"",SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_VALOR)	// "BX"
											oReport:Section(1):Section(1):Section(1):Section(1):PrintLine()
										Endif

										dbSelectArea("SE5")
										dbSkip()
									Enddo
								Else
									dbSelectArea("SEL")
									dbSetOrder(8)
									MsSeek(OsFilial("SEL",SE1->E1_FILIAL)+SE1->E1_SERREC+SE1->E1_RECIBO)

									While SEL->(!Eof()) .And. SEL->EL_FILIAL==OsFilial("SEL",SE1->E1_FILIAL) .And. ;
										SEL->EL_SERIE == SE1->E1_SERREC .And. SEL->EL_RECIBO == SE1->E1_RECIBO

										If AllTrim(SEL->EL_TIPODOC) $ "TB/RA/NCC"
											SEL->(dbSkip())
											Loop
										Else
											OMR050Load(SEL->EL_TIPO,SEL->EL_NUMERO,SEL->EL_BCOCHQ,SEL->EL_AGECHQ,SEL->EL_CTACHQ,SEL->EL_VLMOED1)
											oReport:Section(1):Section(1):Section(1):Section(1):PrintLine()
										Endif

										dbSelectArea("SEL")
										dbSkip()
									Enddo
								EndIf

							Case DAM->DAM_TPBAIX == "2"
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³Imprime cheques da respectiva liquidacao                  ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								cSeekDAM := OsFilial("SE1",DAM->DAM_FILCR)+PadR(DAM->DAM_NUMLIQ, TamSX3("E1_NUMLIQ")[1])

								dbSelectArea("SE1")
								dbSetOrder(15)
								If DbSeek(cSeekDAM) 

									While SE1->(!Eof()) .And. SE1->E1_FILIAL+SE1->E1_NUMLIQ == cSeekDAM
										If PadR("CH",TamSX3("E1_TIPO")[1]) == SE1->E1_TIPO 
											OMR050Load(STR0037,SE1->E1_NUM,SE1->E1_BCOCHQ,SE1->E1_AGECHQ,SE1->E1_CTACHQ,SE1->E1_VALOR)	// "LQ"
											oReport:Section(1):Section(1):Section(1):Section(1):PrintLine()
										EndIf
										dbSelectArea("SE1")
										dbSkip()
									EndDo
								Endif

							Case DAM->DAM_TPBAIX == "3"
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³Imprime compensacoes da respectivo titulo                 ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                   
								cSeekDAM := OsFilial("SE1",DAM->DAM_FILCR)+Rtrim(DAM->DAM_SEQBX)
								dbSelectArea("SE1")
								dbSetOrder(1)
								If MsSeek(cSeekDAM)

									While SE1->(!Eof()) .And. SE1->E1_FILIAL+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+SE1->E1_LOJA == ;
										cSeekDAM

										If SE1->E1_CLIENTE+SE1->E1_LOJA == DAM->DAM_CLIENT+DAM->DAM_LOJA
											OMR050Load(STR0038,SE1->E1_NUM,SE1->E1_PREFIXO,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_VALOR)	// "CMP"
											oReport:Section(1):Section(1):Section(1):Section(1):PrintLine()
										EndIf
										dbSelectArea("SE1")
										dbSkip()
									EndDo
								Endif
						EndCase
						RestArea(aAreaSE1)

						dbSelectArea("DAM")
						dbSkip()
					EndDo
					oReport:Section(1):Section(1):Section(1):Section(1):Finish()

				Endif
				dbSelectArea("SE1")
				dbSkip()

			Enddo
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Imprime total das baixas                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oReport:Section(1):Section(1):Section(1):Finish()

			dbSelectArea(cAliasSF2)
			dbSkip()
			lSkip := .T.

		Enddo
		oReport:Section(1):Section(1):Finish()

	Enddo
	oReport:Section(1):Finish()	

	If !lQuery .Or. !lSkip
		dbSelectArea(cAliasDAK)
		dbSkip()
	EndIf

Enddo

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³OMR050Load³ Autor ³ Marco Bianchi         ³ Data ³ 03/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega variaveis de acordo com tipo de baixa              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAOMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function OMR050Load(cVar01,cVar02,cVar03,cVar04,cVar05,nVar06)

cTipoBx		:= cVar01
cNum		:= cVAr02
cPrefixo	:= cVar03
cParcela	:= cVar04
cTipo		:= cVar05
nValor		:= nVar06

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³OMSR050   ³ Autor ³ Henry Fila            ³ Data ³22.01.2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de Cargas                                         ³±±
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

User Function OMSR050R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
	Local Titulo  := OemToAnsi(STR0001) //"Prestacao de Contas"
	Local cDesc1  := OemToAnsi(STR0002) //"Este programa ira emitir a Relacao dos Titulos na"
	Local cDesc2  := OemToAnsi(STR0003) //"Prestacao de contas de acordo com os parametros es-"
	Local cDesc3  := OemToAnsi(STR0004) //"colhidos pelo usuario                      ."
#ELSE
	Local Titulo  := STR0001
	Local cDesc1  := STR0002
	Local cDesc2  := STR0003
	Local cDesc3  := ""
#ENDIF

Local cString  := "DAK"  // Alias utilizado na Filtragem
Local lDic     := .F. // Habilita/Desabilita Dicionario
Local lComp    := .T. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro  := .T. // Habilita/Desabilita o Filtro
Local wnrel    := "OMSR050"  // Nome do Arquivo utilizado no Spool
Local nomeprog := "OMSR050"  // nome do programa

Private Tamanho := "G" // P/M/G
Private Limite  := 220 // 80/132/220
Private cPerg   := "OMR050"  // Pergunta do Relatorio
Private aReturn := { STR0005, 1,STR0006, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
						//[1] Reservado para Formulario
						//[2] Reservado para N§ de Vias
						//[3] Destinatario
						//[4] Formato => 1-Comprimido 2-Normal
						//[5] Midia   => 1-Disco 2-Impressora
						//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//[7] Expressao do Filtro
						//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)
//Private aOrdem  := {OemtoAnsi(STR0019), OemtoAnsi(STR0020), OemtoAnsi(STR0021)}

Private lEnd     := .F.	// Controle de cancelamento do relatorio
Private m_pag    := 1  	// Contador de Paginas
Private nLastKey := 0  	// Controla o cancelamento da SetPrint e SetDefault

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If DAP->(FieldPos("DAP_USER")) > 0

	wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,,lComp,Tamanho,lFiltro)
	If ( nLastKey==27 )
		dbSelectArea(cString)
		dbSetOrder(1)
		DbClearFilter()
		Return
	Endif
	SetDefault(aReturn,cString)
	If ( nLastKey==27 )
		dbSelectArea(cString)
		dbSetOrder(1)
		DbClearFilter()
		Return
	Endif
	#IFDEF WINDOWS
		RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)
	#ELSE
		ImpDet(.F.,wnrel,cString,nomeprog,Titulo)
	#ENDIF

Endif

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Henry Fila            ³ Data ³24.01.2002³±±
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

Static Function ImpDet(lEnd,wnrel,cString,nomeprog,Titulo)

#IFDEF TOP
	Local cQuery    := ""
	Local aStruSF2  := {}
	Local aStruDAK  := {}
	Local nX        := 0
#ENDIF

Local cIndDAK   := ""
Local cIndSF2   := ""
Local cAliasSF2 := "SF2"
Local cAliasDAK := "DAK"
Local cAliasSA1 := "SA1"
Local cKeySF2   := ""
Local cKeyDAK   := ""
Local cCondSF2  := ""
Local cCondDAK  := ""

Local nIndDAK   := 0
Local nIndSF2   := 0
Local nTipoOper := OsVlEntCom()

Local lQuery    := .F.


//                           1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                 XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XX  XXXXXX   XXX,XXX.XX XXX,XXX.XX  XXX,XXX.XX XXX,XXX.XX  XXX.XXX     XX  XXXXXXXXXX

//                 CARGA   : XXXXXX-XX
//                 VEICULO : XXXXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXX     MOTORISTA : XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXX
//                 PESO    : XXXX,XXX.XX    VOLUME M3 : XXXX,XXX.XX    PTOS ENTREGA : XXXXXX   VALOR : XXX,XXX,XXX.XX
//                 DATA    : XX/XX/XX AS XX:XX

//
//                                    1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                          01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890


//                                               1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                                     01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890


dbSelectArea(cString)
dbSetOrder(2)
cIndDAK := CriaTrab(NIL,.F.)

#IFDEF TOP

	If TcSrvType() != "AS/400"

		lQuery   := .T.

		aStruSF2 := SF2->(dbStruct())
		aStruDAK := DAK->(dbStruct())

		cAliasSF2 := "TRBQRY"
		cAliasDAK := "TRBQRY"
		cAliasSA1 := "TRBQRY"

		cQuery := "SELECT SF2.*, DAK.*,A1_NOME"

		cQuery += " FROM "+ RetSqlName("SF2")+ " SF2 ,"
		cQuery += RetSqlName("SA1")+ " SA1 , "
		cQuery += RetSqlName("DAK")+ " DAK "
		cQuery += " WHERE "

		If nTipoOper <> 1
			cQuery += "SF2.F2_FILIAL = '"+xFilial("SF2") + "' AND "
		Endif

		cQuery += "SF2.F2_CARGA >='"+mv_par01+"' AND "
		cQuery += "SF2.F2_CARGA <='"+mv_par02+"' AND "
		cQuery += "SF2.F2_SEQCAR>='"+mv_par03+"' AND "
		cQuery += "SF2.F2_SEQCAR<='"+mv_par04+"' AND "
		cQuery += "SF2.F2_TIPO <>'D' AND "
		cQuery += "SF2.F2_TIPO <>'B' AND "
		cQuery += "SF2.F2_CLIENTE >= '"+mv_par11+"' AND "
		cQuery += "SF2.F2_CLIENTE <= '"+mv_par12+"' AND "
		cQuery += "SF2.F2_LOJA >= '"+mv_par13+"' AND "
		cQuery += "SF2.F2_LOJA <= '"+mv_par14+"' AND "
		cQuery += "SF2.D_E_L_E_T_=' ' AND "

		cQuery += "DAK.DAK_FILIAL = '"+xFilial("DAK")+"' AND "
		cQuery += "DAK.DAK_COD = SF2.F2_CARGA AND "
		cQuery += "DAK.DAK_SEQCAR = SF2.F2_SEQCAR AND "
		cQuery += "DAK.DAK_CAMINH >= '"+mv_par05+"' AND "
		cQuery += "DAK.DAK_CAMINH <= '"+mv_par06+"' AND "
		cQuery += "DAK.DAK_MOTORI >= '"+mv_par07+"' AND "
		cQuery += "DAK.DAK_MOTORI <= '"+mv_par08+"' AND "
		cQuery += "DAK.DAK_DATA   >= '"+Dtos(mv_par09)+"' AND "
		cQuery += "DAK.DAK_DATA   <= '"+Dtos(mv_par10)+"' AND "
		cQuery += "(DAK.DAK_ACEFIN = '1' OR DAK.DAK_ACEFIN = '3' )AND "
		cQuery += "DAK.D_E_L_E_T_ = ' ' AND "

		cQuery += "SA1.A1_FILIAL = "+Iif(nTipoOper <> 1,OsFilQry("SA1","SF2.F2_FILIAL")+ " AND ","'"+xFilial("SA1")+"' AND " )
		cQuery += "SA1.A1_COD = SF2.F2_CLIENTE AND "
		cQuery += "SA1.A1_LOJA = SF2.F2_LOJA AND "
		cQuery += "SA1.D_E_L_E_T_ = ' ' "

		cQuery += "ORDER BY SF2.F2_FILIAL,SF2.F2_CARGA,SF2.F2_SEQCAR,SF2.F2_CLIENTE,SF2.F2_LOJA,SF2.F2_DOC"

		cQuery := ChangeQuery(cQuery)
		dBUseArea(.t.,"TOPCONN",TCGENQRY(,,cQuery),"TRBQRY",.f.,.t.)

		For nX := 1 To Len(aStruDAK)
			If aStruDAK[nX][2]!="C"
				TcSetField(cAliasDAK,aStruDAK[nX][1],aStruDAK[nX][2],aStruDAK[nX][3],aStruDAK[nX][4])
			EndIf
		Next nX


		For nX := 1 To Len(aStruSF2)
			If aStruSF2[nX][2]!="C"
				TcSetField(cAliasSF2,aStruSF2[nX][1],aStruSF2[nX][2],aStruSF2[nX][3],aStruSF2[nX][4])
			EndIf
		Next nX

		dbGotop()

	Else

#ENDIF

		dbSelectArea("DAK")
		dbSetOrder(2)
		cIndDAK := CriaTrab(NIL,.F.)

		dbSelectArea("DAK")
		dbSetOrder(1)
		cKeyDAK  := IndexKey()
		cCondDAK += 'DAK_FILIAL = "'+xFilial("DAK")+'" .And.' 
		cCondDAK += 'DAK_COD >= "'+mv_par01+'" .And. DAK_COD <= "'+mv_par02+'" .And.'
		cCondDAK += 'DAK_SEQCAR >= "'+mv_par03+'" .And. DAK_SEQCAR <= "'+mv_par04+'" .And.'
		cCondDAK += 'DAK_CAMINH >= "'+mv_par05+'" .And. DAK_CAMINH <= "'+mv_par06+'" .And.'
		cCondDAK += 'DAK_MOTORI >= "'+mv_par07+'" .And. DAK_MOTORI <= "'+mv_par08+'" .And.'
		cCondDAK += 'Dtos(DAK_DATA) >= "'+Dtos(mv_par09)+'" .And. Dtos(DAK_DATA) <= "'+Dtos(mv_par10)+'" .And.'
		cCondDAK += '(DAK_ACEFIN == "1" .Or. DAK_ACEFIN == "3" )'
		IndRegua("DAK",cIndDAK,cKeyDAK,,cCondDAK) //"Selecionando Registros ..."
		nIndDAK := RetIndex("DAK")
		#IFNDEF TOP
		dbSetIndex(cIndDAK+OrdBagExT())
		#ENDIF
		dbSetOrder(nIndDAK+1)
		dbGotop()


		dbSelectArea("SF2")
		dbSetOrder(2)

		cIndSF2 := CriaTrab(NIL,.F.)

		dbSelectArea("SF2")
		dbSetOrder(5)

		If nTipoOper == 1
			cKeySF2 := SF2->(IndexKey())
		Else
			cKeySF2 := "F2_CARGA+F2_SEQCAR+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA"
		Endif

		cCondSF2 += 'F2_CARGA >= "'+mv_par01+'".And.F2_CARGA <="'+mv_par02+'".And.'
		cCondSF2 += 'F2_SEQCAR >= "'+mv_par03+'".And.F2_SEQCAR <="'+mv_par04+'" .And.'
		cCondSF2 += 'F2_CLIENTE >= "'+mv_par11+'".And.F2_CLIENTE <="'+mv_par12+'".And.'
		cCondSF2 += 'F2_LOJA >= "'+mv_par13+'".And.F2_LOJA <="'+mv_par14+'"'

		If nTipoOper == 1
			cCondSF2 += ".And.F2_FILIAL == '"+xFilial("SF2")+"'"
		Endif
		IndRegua("SF2",cIndSF2,cKeySF2,,cCondSF2) //"Selecionando Registros ..."
		nIndSF2 := RetIndex("SF2")
		#IFNDEF TOP
			dbSetIndex(cIndSF2+OrdBagExT())
		#ENDIF
		dbSetOrder(nIndSF2+1)
		dbGotop()

#IFDEF TOP
	Endif
#ENDIF



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chama funcao de impressao do relatorio                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAliasDAK)
Oms050Det1(cAliasDAK,cAliasSF2,cAliasSA1,Titulo,NomeProg,lQuery)

If lQuery
	dbSelectArea("TRBQRY")
	dbClearFilter()
	dbCloseArea()
Else
	dbSelectArea("DAK")
	Ferase(cIndDAK+OrdBagExt())
	RetIndex("DAK")
Endif


dbSelectArea("DAK")
dbSetOrder(1)

Set Device To Screen
Set Printer To
If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³Oms050Det1³ Autor ³ Henry Fila            ³ Data ³22.01.2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio por ordem de carga                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 : Alias do Arquivo DAK                                ³±±
±±³          ³ExpC2 : Alias do Arquivo DAP                                ³±±
±±³          ³ExpC3 : Titulo                                              ³±±
±±³          ³ExpC4 : NomeProg                                            ³±±
±±³          ³ExpL5 : Flag se usou query                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Oms050Det1(cAliasDAK,cAliasSF2,cAliasSA1,Titulo,NomeProg,lQuery)

Local bWhileSF2 := { || }

Local cCodDAK   := ""
Local cSeqDAK   := ""
//                                                 1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                                       01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

Local cCabec1   := OemtoAnsi(STR0017) //"PREFIXO NUMERO        TIPO  PARCELA             VALOR           SALDO      VENCIMENTO     TIPO     NUMERO      BANCO      AGENCIA       NUMERO           VALOR"
Local cCabec2   := OemtoAnsi(STR0018) //"                                                                                    BAIXA                                          CONTA"      
Local cbCont    := 0   // Numero de Registros Processados                                                                                                                             
Local cbText    := ""
Local cCliente  := ""
Local cLoja     := ""
Local cSeekSF2  := ""
Local cSeekDAM  := ""
Local cOperacao := ""

Local li        := 100 // Contador de Linhas
Local lSkip     := .F.
Local lImp      := .F. // Indica se algo foi impresso

Local nRecSE1   := 0
Local nValBaixa := 0
Local nTipoOper := OsVlEntCom()

dbSelectArea(cAliasDAK)

While (cAliasDAK)->(!Eof())

	lSkip   := .F.
	lImp    := .T.

	#IFNDEF WINDOWS
		If LastKey() = 286
			lEnd := .T.
		EndIf
	#ENDIF
	If lEnd
		@ Prow()+1,001 PSAY STR0006 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf

	If ( li > 53 )
		li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
		li++
	Endif

	dbSelectArea("DA3")
	dbSetOrder(1)
	MsSeek(xFilial("DA3")+(cAliasDAK)->DAK_CAMINH)

	dbSelectArea("DA4")
	dbSetOrder(1)
	MsSeek(xFilial("DA4")+(cAliasDAK)->DAK_MOTORI)

	@ li,000 PSAY OemtoAnsi(STR0006)+ (cAliasDAK)->DAK_COD+"-"+(cAliasDAK)->DAK_SEQCAR //"CARGA   : "
	li++
	@ li,000 PSAY OemtoAnsi(STR0007)+ (cAliasDAK)->DAK_CAMINH + " - " + DA3->DA3_DESC  //"VEICULO : "
	@ li,055 PSAY OemtoAnsi(STR0008)+ (cAliasDAK)->DAK_MOTORI + " - " + DA4->DA4_NOME //"MOTORISTA : "
	li++
	@ li,000 PSAY OemtoAnsi(STR0009) //"PESO    :"
	@ li,010 PSAY (cAliasDAK)->DAK_PESO Picture PesqPict("DAK","DAK_PESO")
	@ li,025 PSAY OemtoAnsi(STR0010) //"VOLUME M3 : "
	@ li,037 PSAY (cAliasDAK)->DAK_CAPVOL Picture PesqPict("DAK","DAK_CAPVOL")
	@ li,052 PSAY OemtoAnsi(STR0011) //"PTOS ENTREGA : "
	@ li,067 PSAY (cAliasDAK)->DAK_PTOENT Picture PesqPict("DAK","DAK_PTOENT")
	@ li,076 PSAY OemtoAnsi(STR0012) //"VALOR : "
	@ li,084 PSAY (cAliasDAK)->DAK_VALOR Picture PesqPict("DAK","DAK_VALOR")
	li++
	@ li,000 PSAY OemtoAnsi(STR0013) +DtoC((cAliasDAK)->DAK_DATA) + OemtoAnsi(STR0014) + (cAliasDAK)->DAK_HORA //"DATA    :"
	li++

	cCodDAK   := (cAliasDAK)->DAK_COD
	cSeqDAK   := (cAliasDAK)->DAK_SEQCAR

	If !lQuery

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Realiza Seek de acordo com o tipo de operacao de filiais³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTipoOper == 1
			cSeekSF2 := xFilial("SF2")+(cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR
		Else
			cSeekSF2 := (cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR
		Endif

		dbSelectArea("SF2")
		MsSeek(cSeekSF2)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Realiza While de acordo com o tipo de operacao de filiais³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTipoOper == 1
			bWhileSF2 :=  {|| (cAliasSF2)->(!Eof()) .And. (cAliasSF2)->F2_FILIAL+(cAliasSF2)->F2_CARGA+(cAliasSF2)->F2_SEQCAR == ;
						xFilial("SF2")+cCodDAK+cSeqDAK }
		Else
			bWhileSF2 :=  {|| (cAliasSF2)->(!Eof()) .And. (cAliasSF2)->F2_CARGA+(cAliasSF2)->F2_SEQCAR == ;
						cCodDAK+cSeqDAK }
		Endif

	Else
		bWhileSF2 :=  {|| (cAliasSF2)->(!Eof()) .And. (cAliasSF2)->F2_CARGA+(cAliasSF2)->F2_SEQCAR == ;
							cCodDAK+cSeqDAK }
	Endif

	@ li,000 PSAY __PrtThinLine()
	li++

	While Eval(bWhileSF2)

		If ( li > 53 )
			li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
			li++
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Guarda variaveis para quebra por cliente                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cCliente := (cAliasSF2)->F2_CLIENTE
		cLoja    := (cAliasSF2)->F2_LOJA


		If !lQuery
			SA1->(dbSetOrder(1))
			SA1->(MsSeek(OsFilial("SA1",(cAliasSF2)->F2_FILIAL)+cCliente+cLoja))
		Endif

		@ li,000 PSAY OemtoAnsi(STR0019)+cCliente + "-" + cLoja+" - " + (cAliasSA1)->A1_NOME    //"Cliente : "
		@ li,110 PSAY OemtoAnsi(STR0020) //"B     A     I     X     A     S"
		li++
		@ li,000 PSAY __PrtThinLine()
		li++


		dbSelectArea(cAliasSF2)

		While (cAliasSF2)->(!Eof()) .And.	(cAliasSF2)->F2_FILIAL  == xFilial("SF2") .And. ;
											(cAliasSF2)->F2_CLIENTE == cCliente       .And. ;
											(cAliasSF2)->F2_LOJA    == cLoja          .And. ;
											(cAliasSF2)->F2_CARGA   == cCodDak        .And. ;
											(cAliasSF2)->F2_SEQCAR  == cSeqDak

			dbSelectArea("SE1")
			dbSetOrder(2)
			MsSeek(xFilial("SE1")+(cAliasSF2)->F2_CLIENTE+(cALiasSF2)->F2_LOJA+(cAliasSF2)->F2_PREFIXO+(cAliasSF2)->F2_DOC)

			While SE1->(!Eof()) .And.      SE1->E1_FILIAL  == xFilial("SE1")          .And.;
											SE1->E1_CLIENTE == (cAliasSF2)->F2_CLIENTE .And.;
											SE1->E1_LOJA    == (cAliasSF2)->F2_LOJA    .And. ;
											SE1->E1_PREFIXO == (cAliasSF2)->F2_PREFIXO .And. ;
											SE1->E1_NUM     == (cAliasSF2)->F2_DOC

				@ li,000 PSAY SE1->E1_PREFIXO
				@ li,008 PSAY SE1->E1_NUM
				@ li,023 PSAY SE1->E1_TIPO
				@ li,029 PSAY SE1->E1_PARCELA
				@ li,040 PSAY SE1->E1_VALOR		Picture "@E 99,999,999.99"
				@ li,056 PSAY SE1->E1_SALDO		Picture "@E 99,999,999.99"
				@ li,075 PSAY SE1->E1_VENCREA
				@ li,107 PSAY SE1->E1_DESCFIN	Picture "@E 99,999,999.99"
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Imprime os dados das baixas caso existam                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

				nValBaixa := 0

				dbSelectArea("DAM")
				dbSetOrder(2)
				If MsSeek(xFilial("DAM")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA +;
						SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA )

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Armazena registro do SE1 pois o ponteiro e modificado     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aAreaSE1  := SE1->(GetArea())

					While !Eof() .And. DAM->DAM_FILIAL+DAM->DAM_PREFIX+DAM->DAM_NUMERO+DAM->DAM_PARCEL+DAM_TIPO+DAM_CLIENT+DAM_LOJA == ;
									xFilial("DAM")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+;
									SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA

						Do Case
							Case DAM->DAM_TPBAIX == "1"

								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³Imprime caso seja baixa simples                           ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								cOperacao := "BX"

								//Quando o pais eh diferente de Brasil as baixas, realizadas atraves da rotina
								//de recibos, estarao gravadas no arquivo SEL.
								If cPaisLoc == "BRA"
									dbSelectArea("SE5")
									dbSetOrder(7)
									MsSeek(OsFilial("SE5",DAM->DAM_FILCR)+DAM->DAM_PREFIX+DAM->DAM_NUMERO+DAM->DAM_PARCEL+DAM->DAM_TIPO+DAM->DAM_CLIENT+DAM->DAM_LOJA+Rtrim(DAM->DAM_SEQBX))								

									While SE5->(!Eof()) .And. SE5->E5_FILIAL   == OsFilial("SE5",DAM->DAM_FILCR) .And. ;
																SE5->E5_PREFIXO == DAM->DAM_PREFIX .And. ;
																SE5->E5_NUMERO  == DAM->DAM_NUMERO .And. ;
																SE5->E5_PARCELA == DAM->DAM_PARCEL .And. ;
																SE5->E5_TIPO    == DAM->DAM_TIPO .And. ;
																SE5->E5_CLIFOR  == DAM->DAM_CLIENT .And. ;
																SE5->E5_LOJA    == DAM->DAM_LOJA .And. ;
																SE5->E5_SEQ     == Rtrim(DAM->DAM_SEQBX)

										If SE5->E5_TIPODOC $ "V2#VL#BA"
											@ li,098 PSAY OemtoAnsi(STR0021) //"BX"
											@ li,125 PSAY SE5->E5_BANCO
											@ li,136 PSAY SE5->E5_AGENCIA
											@ li,146 PSAY SE5->E5_CONTA
											@ li,170 PSAY SE5->E5_VALOR Picture "@E 99,999,999.99"
											nValBaixa += SE5->E5_VALOR
											li++
										Endif

										dbSelectArea("SE5")
										dbSkip()
									Enddo
								Else
									dbSelectArea("SEL")
									dbSetOrder(8)
									MsSeek(OsFilial("SEL",SE1->E1_FILIAL)+SE1->E1_SERREC+SE1->E1_RECIBO)

									While SEL->(!Eof()) .And. SEL->EL_FILIAL==OsFilial("SEL",SE1->E1_FILIAL) .And. ;
  										SEL->EL_SERIE == SE1->E1_SERREC .And. SEL->EL_RECIBO == SE1->E1_RECIBO

										If AllTrim(SEL->EL_TIPODOC) $ "TB/RA/NCC"
											SEL->(dbSkip())
											Loop
										Else
											@ li,098 PSAY SEL->EL_TIPO
											@ li,107 PSAY SEL->EL_NUMERO
											@ li,128 PSAY SEL->EL_BCOCHQ
											@ li,139 PSAY SEL->EL_AGECHQ
											@ li,149 PSAY SEL->EL_CTACHQ
											@ li,170 PSAY SEL->EL_VLMOED1 Picture "@E 99,999,999.99"
											nValBaixa += SEL->EL_VLMOED1
											li++
										Endif

										dbSelectArea("SEL")
										dbSkip()
									Enddo
								EndIf

							Case DAM->DAM_TPBAIX == "2"

								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³Imprime cheques da respectiva liquidacao                  ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

								cSeekDAM := OsFilial("SE1",DAM->DAM_FILCR)+PadR(DAM->DAM_NUMLIQ, TamSX3("E1_NUMLIQ")[1])

								dbSelectArea("SE1")
								dbSetOrder(15)
								If MsSeek(cSeekDAM)

									While SE1->(!Eof()) .And. SE1->E1_FILIAL+SE1->E1_NUMLIQ == cSeekDAM
									
										If PadR("CH",TamSX3("E1_TIPO")[1]) == SE1->E1_TIPO 
	
											@ li,098 PSAY OemtoAnsi(STR0022) //"LQ" 
											@ li,107 PSAY SE1->E1_NUM
											@ li,128 PSAY SE1->E1_BCOCHQ
											@ li,139 PSAY SE1->E1_AGECHQ
											@ li,149 PSAY SE1->E1_CTACHQ
											@ li,170 PSAY SE1->E1_VALOR Picture "@E 99,999,999.99"
	
											nValBaixa += SE1->E1_VALOR
	
											li++
										EndIf
										
										dbSelectArea("SE1")
										dbSkip()
									EndDo
								Endif

							Case DAM->DAM_TPBAIX == "3"

								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³Imprime compensacoes da respectivo titulo                 ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                   

								cSeekDAM := OsFilial("SE1",DAM->DAM_FILCR)+Rtrim(DAM->DAM_SEQBX)

								dbSelectArea("SE1")
								dbSetOrder(1)
								If MsSeek(cSeekDAM)

									While SE1->(!Eof()) .And. SE1->E1_FILIAL+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+SE1->E1_LOJA == ;
										cSeekDAM

										If SE1->E1_CLIENTE+SE1->E1_LOJA == DAM->DAM_CLIENT+DAM->DAM_LOJA
											@ li,098 PSAY OemToAnsi(STR0023) //"CMP" 
											@ li,107 PSAY SE1->E1_NUM
											@ li,128 PSAY SE1->E1_PREFIXO
											@ li,138 PSAY SE1->E1_PARCELA
											@ li,148 PSAY SE1->E1_TIPO
											@ li,170 PSAY SE1->E1_VALOR Picture "@E 99,999,999.99"
											nValBaixa += SE1->E1_VALOR
											li++
										EndIf
										dbSelectArea("SE1")
										dbSkip()
									EndDo
								Endif


						EndCase

						RestArea(aAreaSE1)

						dbSelectArea("DAM")
						dbSkip()
					EndDo

				Endif

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Imprime total das baixas                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				@ li,092 PSAY Replicate("_",128)
				li++
				@ li,092 PSAY OemtoAnsi(STR0024) //"TOTAL DE BAIXAS ->"
				@ li,172 PSAY nValBaixa Picture "@E 99,999,999.99"
				li++

				@ li,000 PSAY __PrtThinLine()
				li++


				dbSelectArea("SE1")
				dbSkip()

			Enddo

			dbSelectArea(cAliasSF2)
			dbSkip()
			li++
			lSkip := .T.

		Enddo

	Enddo

	If !lQuery .Or. !lSkip
		dbSelectArea(cAliasDAK)
		dbSkip()
	EndIf

Enddo

If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf

Return(.T.)
