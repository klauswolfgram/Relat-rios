/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "OMSR040.CH"
#INCLUDE "PROTHEUS.CH"
#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ OMSR040  ³ Autor ³ Marco Bianchi         ³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Cargas (Conferencia) - Release 4.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAOMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function OMSR040()
Local oReport := Nil

Private nTotDev := 0
Private nTotDif := 0

	If FindFunction("OMSMsgRelD")
		OMSMsgRelD()
	EndIf

	If FindFunction("TRepInUse") .And. TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	Else
		U_OMSR040R3()
	EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 31/07/06 ³±±
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

Local cAliasDAK := GetNextAlias()
Local cAliasDAP := cAliasDAK
Local cAliasTRB := "TRBARQ"

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
oReport := TReport():New("OMSR040",STR0025,"OMR040", {|oReport| ReportPrint(oReport,cAliasDAK,cAliasDAP,cAliasTRB)},STR0026 + " " + STR0027)	// "Prestacao de Contas (Conferencia)"###"Este relatorio ira imprimir a Conferencia realizada nas"###"cargas de acordo com os parametros informados pelo usuario"
oReport:SetPortrait()
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
//³                                                                        ³
//³ Ordem - por Carga                                                      ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao Principal - Section(1)                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCarga := TRSection():New(oReport,STR0040,{"DAK","DAP"},{STR0033,STR0034,STR0035},/*Campos do SX3*/,/*Campos do SIX*/)	// "Prestacao de Contas (Conferencia)"
oCarga:SetLineStyle(.T.)
oCarga:SetTotalInLine(.F.)
TRCell():New(oCarga,"DAK_COD"		,"DAK",RetTitle("DAK_COD"		),PesqPict("DAK","DAK_COD"		),TamSx3("DAK_COD"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_SEQCAR"	,"DAK",RetTitle("DAK_SEQCAR"	),PesqPict("DAK","DAK_SEQCAR"	),TamSx3("DAK_SEQCAR"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_CAMINH"	,"DAK",RetTitle("DAK_CAMINH"	),PesqPict("DAK","DAK_CAMINH"	),TamSx3("DAK_CAMINH"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DA3_DESC"		,"DA3",RetTitle("DA3_DESC"		),PesqPict("DA3","DA3_DESC"		),TamSx3("DA3_DESC"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_MOTORI"	,"DAK",RetTitle("DA4_COD"		),PesqPict("DAK","DAK_MOTORI"	),TamSx3("DAK_MOTORI"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DA4_NOME"		,"DA4",RetTitle("DA4_NOME"		),PesqPict("DA4","DA4_NOME"		),TamSx3("DA4_NOME"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_PESO"		,"DAK",RetTitle("DAK_PESO"		),PesqPict("DAK","DAK_PESO"		),TamSx3("DAK_PESO"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_CAPVOL"	,"DAK",RetTitle("DAK_CAPVOL"	),PesqPict("DAK","DAK_CAPVOL"	),TamSx3("DAK_CAPVOL"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_PTOENT"	,"DAK",RetTitle("DAK_PTOENT"	),PesqPict("DAK","DAK_PTOENT"	),TamSx3("DAK_PTOENT"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_VALOR"		,"DAK",RetTitle("DAK_VALOR"		),PesqPict("DAK","DAK_VALOR"	),TamSx3("DAK_VALOR"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_DATA"		,"DAK",RetTitle("DAK_DATA"		),/*Picture*/                    ,/*Tamanho*/               ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_HORA"		,"DAK",RetTitle("DAK_HORA"		),PesqPict("DAK","DAK_HORA"		),TamSx3("DAK_HORA"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"CNOMEUSER"		,"   ",STR0028					 ,/*Picture*/					 ,20						,/*lPixel*/,/*{|| code-block de impressao }*/)	// "Usuario"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao Detalhes - Section(1):Section(1)                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oDet := TRSection():New(oCarga,STR0041,{"DAP"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oDet:SetTotalInLine(.F.)
TRCell():New(oDet,"DAP_CODGRU"	,/*Tabela*/	,STR0037				,PesqPict("DAP","DAP_CODGRU")	,TamSx3("DAP_CODGRU")[1]	,/*lPixel*/,{|| (cAliasDAP)->DAP_CODGRU }							)	// "Forma de Pagto"
TRCell():New(oDet,"CDFORMA"		,/*Tabela*/	,STR0029				,/*Picture*/					,/*Tamanho*/				,/*lPixel*/,{|| Tabela("24",Alltrim((cAliasDAP)->DAP_CODGRU),.F.)})	// "Descricao"
TRCell():New(oDet,"DAP_PREVIS"	,/*Tabela*/	,RetTitle("DAP_PREVIS")	,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,{|| (cAliasDAP)->DAP_PREVIS }							)
TRCell():New(oDet,"NFORMA"		,/*Tabela*/	,STR0030				,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/						)	// "Devolucao"
TRCell():New(oDet,"NVLRAREC"	,/*Tabela*/	,STR0031				,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/						)	// "Total a Receber"
TRCell():New(oDet,"DAP_REALIZ"	,/*Tabela*/	,RetTitle("DAP_REALIZ")	,PesqPict("DAP","DAP_REALIZ")	,TamSx3("DAP_REALIZ")[1]	,/*lPixel*/,{|| (cAliasDAP)->DAP_REALIZ }							)
TRCell():New(oDet,"NVLRDIF"		,/*Tabela*/	,STR0032				,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/						)	// "Diferenca"

TRFunction():New(oDet:Cell("DAP_PREVIS"),/* cID */,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/             ,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet:Cell("NFORMA"    ),/* cID */,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| nTotDev }/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet:Cell("NVLRAREC"  ),/* cID */,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/             ,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet:Cell("DAP_REALIZ"),/* cID */,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/             ,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet:Cell("NVLRDIF"   ),/* cID */,"SUM"    ,/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| nTotDif }/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                                        ³
//³ Ordem - por Emissao                                                    ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao de Cabecalho - Section(1):Section(2)                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oEmissao := TRSection():New(oCarga,STR0042,{cAliasTRB},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oEmissao:SetTotalInLine(.F.)
oEmissao:SetEditCell(.F.)
TRCell():New(oEmissao,"TRB_DTACER"	,/*Tabela*/	,RetTitle("DAP_DTACER")	,PesqPict("DAP","DAP_DTACER")	,TamSx3("DAP_DTACER")[1],/*lPixel*/,{|| (cAliasTRB)->TRB_DTACER }		)
TRCell():New(oEmissao,"CNOMEUSER"	,"   "		,STR0028				 ,/*Picture*/					,20					     ,/*lPixel*/,/*{|| code-block de impressao }*/	)	// "Usuario"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao Detalhes 2 - Section(1):Section(2):Section(1)                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oDet2 := TRSection():New(oEmissao,STR0043,{cAliasTRB},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oDet2:SetTotalInLine(.F.)
oDet2:SetEditCell(.F.)
TRCell():New(oDet2,"DAP_CODGRU"	,/*Tabela*/	,STR0037				,PesqPict("DAP","DAP_CODGRU")	,TamSx3("DAP_CODGRU")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_CODGRU }							)	// "Forma de Pagto"
TRCell():New(oDet2,"CDFORMA"	,/*Tabela*/	,STR0029				,/*Picture*/					,/*Tamanho*/				,/*lPixel*/,{|| Tabela("24",Alltrim((cAliasTRB)->TRB_CODGRU),.F.)})	// "Descricao"
TRCell():New(oDet2,"TRB_PREVIS"	,/*Tabela*/	,RetTitle("DAP_PREVIS")	,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_PREVIS }							)
TRCell():New(oDet2,"TRB_DEVOL"	,/*Tabela*/	,STR0030				,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_DEVOL	 }							)	// "Devolucao"
TRCell():New(oDet2,"TRB_ARECEB"	,/*Tabela*/	,STR0031				,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_ARECEB }							)	// "Total a Receber"
TRCell():New(oDet2,"TRB_REALIZ"	,/*Tabela*/	,RetTitle("DAP_REALIZ")	,PesqPict("DAP","DAP_REALIZ")	,TamSx3("DAP_REALIZ")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_REALIZ }							)
TRCell():New(oDet2,"TRB_DIFERE"	,/*Tabela*/	,STR0032				,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_DIFERE }							)	// "Diferenca"

TRFunction():New(oDet2:Cell("TRB_PREVIS"	),"PREVIS_1","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet2:Cell("TRB_DEVOL"		),"DEVOL_1","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet2:Cell("TRB_ARECEB"	),"ARECEB_1","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet2:Cell("TRB_REALIZ"	),"REALIZ_1","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet2:Cell("TRB_DIFERE"	),"DIFERE_1","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                                        ³
//³ Ordem - por Motorista                                                  ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao de Cabecalho - Section(1):Section(3)                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oMotori := TRSection():New(oCarga,STR0044,{cAliasTRB},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oMotori:SetTotalInLine(.F.)
oMotori:SetEditCell(.F.)
TRCell():New(oMotori,"TRB_MOTORI"	,/*Tabela*/,RetTitle("DA4_COD"		)	,PesqPict("DAK","DAK_MOTORI")	,TamSx3("DAK_MOTORI")[1],/*lPixel*/,{|| (cAliasTRB)->TRB_MOTORI }		)
TRCell():New(oMotori,"CNOMEMOT"		,/*Tabela*/,RetTitle("DA4_NOME"		)	,PesqPict("DA4","DA4_NOME")		,TamSx3("DA4_NOME"	)[1],/*lPixel*/,{|| DA4->DA4_NOME })
TRCell():New(oMotori,"CNOMEUSER"	,/*Tabela*/,STR0028				 		,/*Picture*/					,20					     ,/*lPixel*/,/*{|| code-block de impressao }*/	)	// "Usuario"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao Detalhes 2 - Section(1):Section(3):Section(1)                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oDet3 := TRSection():New(oMotori,STR0043,{cAliasTRB},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oDet3:SetTotalInLine(.F.)
oDet3:SetEditCell(.F.)
TRCell():New(oDet3,"DAP_CODGRU"	,/*Tabela*/	,STR0037				,PesqPict("DAP","DAP_CODGRU")	,TamSx3("DAP_CODGRU")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_CODGRU }							)	// "Forma de Pagto"
TRCell():New(oDet3,"CDFORMA"	,/*Tabela*/	,STR0029				,/*Picture*/					,/*Tamanho*/				,/*lPixel*/,{|| Tabela("24",Alltrim((cAliasTRB)->TRB_CODGRU),.F.)})	// "Descricao"
TRCell():New(oDet3,"TRB_PREVIS"	,/*Tabela*/	,RetTitle("DAP_PREVIS")	,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_PREVIS }							)
TRCell():New(oDet3,"TRB_DEVOL"	,/*Tabela*/	,STR0030				,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_DEVOL	 }							)	// "Devolucao"
TRCell():New(oDet3,"TRB_ARECEB"	,/*Tabela*/	,STR0031				,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_ARECEB }							)	// "Total a Receber"
TRCell():New(oDet3,"TRB_REALIZ"	,/*Tabela*/	,RetTitle("DAP_REALIZ")	,PesqPict("DAP","DAP_REALIZ")	,TamSx3("DAP_REALIZ")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_REALIZ }							)
TRCell():New(oDet3,"TRB_DIFERE"	,/*Tabela*/	,STR0032				,PesqPict("DAP","DAP_PREVIS")	,TamSx3("DAP_PREVIS")[1]	,/*lPixel*/,{|| (cAliasTRB)->TRB_DIFERE }							)	// "Diferenca"

TRFunction():New(oDet3:Cell("TRB_PREVIS"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet3:Cell("TRB_DEVOL"		),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet3:Cell("TRB_ARECEB"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet3:Cell("TRB_REALIZ"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDet3:Cell("TRB_DIFERE"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cabecalho da sub-secao no topo da pagina                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):SetHeaderPage(.T.)
oReport:Section(1):Section(2):Section(1):SetHeaderPage(.T.)
oReport:Section(1):Section(3):Section(1):SetHeaderPage(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera texto dos totalizadores                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):SetTotalText(STR0036)			// "T O T A L =>"
oReport:Section(1):Section(2):Section(1):SetTotalText(STR0036)	// "T O T A L =>"
oReport:Section(1):Section(3):Section(1):SetTotalText(STR0036)	// "T O T A L =>"

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 31/07/06 ³±±
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
Static Function ReportPrint(oReport,cAliasDAK,cAliasDAP,cAliasTRB)
Local oTempTable:= NIL
Local lQuery    := .F.
Local nOrdem    := 0
Local aTotMot   := {}
Local aVlrDev   := {}
Local dDtAcer   := CTOD("  /  /  ")
Local cUserQrb  := ""
Local cNomeUser := ""
Local nX        := 0

Local nTotDebMot := 0
Local nTotalDif  := 0
Local nTotalRlz  := 0
Local nTotCrdMot := 0




#IFNDEF TOP
	Local cCondicao := ""
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("DAK")		// Cargas
dbSetOrder(2)			// Filial,Data,Hora,Codigo da Carga.Sequencia da Carga

#IFDEF TOP

	If TcSrvType() != "AS/400"

		Do Case
			Case oReport:Section(1):GetOrder() == 1	// por Carga
				cOrder := "%DAK_COD,DAK_SEQCAR%"
			Case oReport:Section(1):GetOrder() == 2	// por Emissao
				cOrder := "%DAP_DTACER%"
			Case oReport:Section(1):GetOrder() == 3	// por Motorista
				cOrder := "%DAK_MOTORI%"
		End Case

		lQuery   := .T.
		oReport:Section(1):BeginQuery()
		BeginSql Alias cALiasDAK
		SELECT *
		FROM %Table:DAK% DAK, %Table:DAP% DAP
		WHERE DAK_FILIAL = %xFilial:DAK%
			AND DAK_COD >= %Exp:mv_par01%  AND DAK_COD <= %Exp:mv_par02%
			AND DAK_SEQCAR >= %Exp:mv_par03% AND DAK_SEQCAR <= %Exp:mv_par04%
			AND DAK_CAMINH >= %Exp:mv_par05% AND DAK_CAMINH <= %Exp:mv_par06%
			AND DAK_MOTORI >= %Exp:mv_par07% AND DAK_MOTORI <= %Exp:mv_par08%
			AND DAK_FEZNF = '1'
			AND (DAK_ACEFIN = '3' OR DAK_ACEFIN = '1' )
			AND DAK.%NotDel%
			AND DAP_FILIAL = %xFilial:DAP%
			AND DAP_CARGA = DAK.DAK_COD
			AND DAP_SEQCAR = DAK.DAK_SEQCAR
			AND DAP_DTACER >= %Exp:Dtos(mv_par09)% AND DAP_DTACER <= %Exp:Dtos(mv_par10)%
			AND DAP.%NotDel%
		ORDER BY %Exp:cOrder%
		EndSql
		oReport:Section(1):EndQuery()

	Else

#ENDIF

		cCondicao := 'DAK_FILIAL == "'+xFilial("DAK")+'".And.'
		cCondicao += 'DAK_COD >= "'+mv_par01+'".And.DAK_COD <="'+mv_par02+'".And.'
		cCondicao += 'DAK_SEQCAR >= "'+mv_par03+'".And.DAK_SEQCAR <="'+mv_par04+'".And.'
		cCondicao += 'DAK_CAMINH >= "'+mv_par05+'".And.DAK_CAMINH <="'+mv_par06+'".And.'
		cCondicao += 'DAK_MOTORI >= "'+mv_par07+'".And.DAK_MOTORI <="'+mv_par08+'".And.'
		cCondicao += 'Dtos(DAK_DATA) >= "'+Dtos(mv_par09)+'".And.Dtos(DAK_DATA) <="'+Dtos(mv_par10)+'".And.'
		cCondicao += 'DAK_FEZNF == "1".And.'
		cCondicao += '(DAK_ACEFIN == "3" .Or. DAK_ACEFIN == "1") '

		oReport:Section(1):SetFilter(cCondicao,IndexKey())
		If oReport:Section(1):GetOrder() == 1
			oReport:Section(1):Section(1):SetRelation({|| xFilial("DAP")+(cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR },"DAP",1,.T.)
		EndIf

#IFDEF TOP
	Endif
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gera tabela de trabalho de ordem for por Emissao ou Motorista           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If oReport:Section(1):GetOrder() == 2	.Or. oReport:Section(1):GetOrder() == 3
	nOrdem := oReport:Section(1):GetOrder()
	U_Oms040Trb(nOrdem,@cAliasTRB,@oTempTable,cAliasDAK,cAliasDAP,@aTotMot,@aVlrDev,lQuery)
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
TRPosition():New(oReport:Section(1),"DA3",1,{|| xFilial("DA3") + (cAliasDAK)->DAK_CAMINH })
TRPosition():New(oReport:Section(1),"DA4",1,{|| xFilial("DA4") + (cAliasDAK)->DAK_MOTORI })
TRPosition():New(oReport:Section(1):Section(3),"DA4",1,{|| xFilial("DA4") + (cAliasTRB)->TRB_MOTORI })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Difine regra de saida do loop do metodo print da secao filha           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If oReport:Section(1):GetOrder() == 1			// por Carga
	oReport:Section(1):Section(1):SetParentFilter( { |x| (cAliasDAP)->DAP_FILIAL+(cAliasDAP)->DAP_CARGA == x },{ || (cAliasDAP)->DAP_FILIAL+(cAliasDAP)->DAP_CARGA })

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Difine se a secao filha utiliza a Query da secao pai no processamento  ³
	//³ do Print.                                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lQuery
		oReport:Section(1):Section(1):SetParentQuery(.T.)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Altera Titulo de acordo com ordem escolhida pelo usuario               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SetTitle(STR0025+ " - " + STR0033 )	// "Prestacao de Contas (Conferencia)"###"Por Carga"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define o bloco de codigo que retornara conteudo de impressao da celula.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):Section(1):Cell("NFORMA"  ):SetBlock({|| nTotDev := RetVal(1,cAliasDAK,cAliasDAP) })
	oReport:Section(1):Section(1):Cell("NVLRAREC"):SetBlock({||            RetVal(2,cAliasDAK,cAliasDAP) })
	oReport:Section(1):Section(1):Cell("NVLRDIF" ):SetBlock({|| nTotDif := RetVal(3,cAliasDAK,cAliasDAP) })
	oReport:Section(1):Cell("CNOMEUSER"	):SetBlock({|| UsrFullName((cAliasDAP)->DAP_USER) })

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Desabilita secoes que nao serao impressas de acordo com ordem escolhida³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):Section(2):Disable()
	oReport:Section(1):Section(2):Section(1):Disable()
	oReport:Section(1):Section(3):Disable()
	oReport:Section(1):Section(3):Section(1):Disable()


ElseIf oReport:Section(1):GetOrder() == 2		// por Emissao
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Altera Titulo de acordo com ordem escolhida pelo usuario               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SetTitle(STR0025+ " - " + STR0034 )	// "Prestacao de Contas (Conferencia)"###""Por Emissao"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define o bloco de codigo que retornara o conteudo de impres-           ³
	//³ sao da celula.                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):Section(2):Cell("CNOMEUSER"	):SetBlock({|| UsrFullName((cAliasTRB)->TRB_USER)	})

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Desabilita secoes que nao serao impressas de acordo com ordem escolhida³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):Hide()
	oReport:Section(1):Section(1):Disable()
	oReport:Section(1):Section(3):Disable()
	oReport:Section(1):Section(3):Section(1):Disable()

ElseIf oReport:Section(1):GetOrder() == 3		// por Motorista
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Altera Titulo de acordo com ordem escolhida pelo usuario               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SetTitle(STR0025+ " - " + STR0035 ) // "Prestacao de Contas (Conferencia)"###"Por Motorista"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define o bloco de codigo que retornara o conteudo de impres-           ³
	//³ sao da celula.                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):Section(3):Cell("CNOMEUSER"	):SetBlock({|| UsrFullName((cAliasTRB)->TRB_USER)	})

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Desabilita secoes que nao serao impressas de acordo com ordem escolhida³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):Hide()
	oReport:Section(1):Section(1):Disable()
	oReport:Section(1):Section(2):Disable()
	oReport:Section(1):Section(2):Section(1):Disable()

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se tera quebra de pagina                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAliasDAK)->(LastRec()))
If mv_par11 == 1
	oReport:Section(1):SetPageBreak()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Impressao do Relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If oReport:Section(1):GetOrder() == 1
	dbSelectArea(cAliasDAK)
	While !oReport:Section(1):Cancel() .And. !Eof()
		cCarga := (cAliasDAK)->DAK_COD
		aFormas := OsFormasPg((cAliasDAK)->DAK_COD,(cAliasDAK)->DAK_SEQCAR,1)
		oReport:Section(1):Init()
		oReport:Section(1):Section(1):Init()
		oReport:Section(1):PrintLine()
		dbSelectArea(cAliasDAP)
		cNomeUSer := AllTrim(UsrFullName((cAliasDAP)->DAP_USER))
		While !oReport:Section(1):Cancel() .And. !Eof() .And. 	(cAliasDAK)->DAK_FILIAL == xFilial("DAK") .And. ;
			cCarga == (cAliasDAP)->DAP_CARGA
			oReport:Section(1):Section(1):PrintLine()
			dbSelectArea(cAliasDAP)
			dbSkip()
		EndDo

		If Len(aFormas) > 0 .And. Empty(aFormas[1][3]) .And. Len(aFormas) == 1
			If aFormas[1][6] > 0
				nTotDev += aFormas[1][6]
				nTotDif += aFormas[1][6]
				oReport:PrintText(STR0039,oReport:Row(),010)	//"Devolucoes indefinidas :"
				oReport:PrintText(Transform(aFormas[1][6],PesqPict("DAP","DAP_PREVIS")),oReport:Row(),oReport:Section(1):Section(1):Cell("NFORMA"):ColPos())
				oReport:SkipLine(2)
			EndIf
		EndIf

		oReport:Section(1):Section(1):Finish()
		oReport:Section(1):Finish()

		If mv_par11 == 1
			If mv_par12 == 1
				oReport:PrintText("______________________________",oReport:Row()+50,0030)
				oReport:PrintText("______________________________",oReport:Row()+50,1000)

				oReport:PrintText(cNomeUser+STR0038,oReport:Row()+100,0030)	// "-TESOURARIA"
				oReport:PrintText(DA4->DA4_NOME,    oReport:Row()+100,1000)
			EndIf
		EndIf
	EndDo

ElseIf oReport:Section(1):GetOrder() == 2 .Or. oReport:Section(1):GetOrder() == 3
	dbSelectArea(cAliasTRB)
	dbGoTop()
	While !oReport:Section(1):Cancel() .And. !Eof()

		cUserAnt := (cALiasTRB)->TRB_USER
		If oReport:Section(1):GetOrder() == 2
			dDtAcerAnt  := (cALiasTRB)->TRB_DTACER
			bWhileTRB := { || !Eof() .And. (cAliasTRB)->TRB_DTACER == dDtAcerAnt .And. (cALiasTRB)->TRB_USER == cUserAnt}
		Else
			cMotoriAnt   := (cALiasTRB)->TRB_MOTORI
			bWhileTRB := { || !Eof() .And. (cAliasTRB)->TRB_MOTORI == cMotoriAnt .And. (cALiasTRB)->TRB_USER == cUserAnt}
		EndIf

		oReport:Section(1):Section(nOrdem):Init()
		oReport:Section(1):Section(nOrdem):Section(1):Init()
		oReport:Section(1):Section(nOrdem):PrintLine()

		cASeek  := Iif( nOrdem == 2, DtoS(dDtAcer) , cMotoriAnt )
		nPosDev := Ascan(aVlrDev,{|x| x[1] == cASeek })

		While Eval(bWhileTRB)
			oReport:Section(1):Section(nOrdem):Section(1):PrintLine()
			dbSelectARea(cALiasTRB)
			dbSkip()
		EndDo


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Identifica quais os tipos de titulos gerados e separa para impressao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cASeek  := Iif( nOrdem == 2, DtoS(dDtAcerAnt) , cMotoriAnt )
		nPosMot := Ascan(aTotMot,{|x| x[1] == cASeek })
		If nPosMot > 0
			For nX := 1 to Len(aTotMot[nPosMot][2])
				If aTotMot[nPosMot][2][nX][1] == MV_CPNEG
					nTotDebMot += aTotMot[nPosMot][2][nX][2]
					nTotalDif  += aTotMot[nPosMot][2][nX][2]
					nTotalRlz  += aTotMot[nPosMot][2][nX][2]
				Else
					nTotCrdMot += aTotMot[nPosMot][2][nX][2]
					nTotalDif  -= aTotMot[nPosMot][2][nX][2]
					nTotalRlz  -= aTotMot[nPosMot][2][nX][2]
				Endif
			Next
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime as linhas dos acumulados dos totais do motorista            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTotDebMot > 0
			oReport:SkipLine()
			oReport:PrintText(MV_CPNEG,oReport:Row(),010)
			oReport:PrintText(Transform(nTotDebMot,PesqPict("DAP","DAP_REALIZ")),oReport:Row(),oReport:Section(1):Section(nOrdem):Section(1):Cell("TRB_REALIZ"):ColPos())
		Endif

		If nTotCrdMot > 0
			oReport:SkipLine()
			oReport:PrintText("NCF",oReport:Row(),010)
			oReport:PrintText(Transform(nTotCrdMot,PesqPict("DAP","DAP_REALIZ")),oReport:Row(),oReport:Section(1):Section(nOrdem):Section(1):Cell("TRB_REALIZ"):ColPos())
		Endif

		If nPosDev > 0
			nTotDev := aVlrDev[nPosDev][2]
			nTotDif := aVlrDev[nPosDev][2]
			oReport:PrintText(STR0039,oReport:Row(),010)	// "Devolucoes indefinidas :"
			oReport:PrintText(Transform(aVlrDev[nPosDev][2],PesqPict("DAP","DAP_PREVIS")),oReport:Row(),oReport:Section(1):Section(nOrdem):Section(1):Cell("TRB_DEVOL"):ColPos())
		EndIf
		oReport:SkipLine(2)

		oReport:Section(1):Section(nOrdem):Section(1):Finish()
		oReport:Section(1):Section(nOrdem):Finish()

		If mv_par11 == 1
			If mv_par12 == 1
				oReport:PrintText("______________________________",oReport:Row()+50,030)
				If oReport:Section(1):GetOrder() == 3
					oReport:PrintText("______________________________",oReport:Row()+50,1000)
				EndIf
				oReport:PrintText(AllTrim(UsrFullName(cUserAnt))+STR0038,oReport:Row()+100,030)	// "-TESOURARIA"

				If oReport:Section(1):GetOrder() == 3
					oReport:PrintText(Posicione("DA4",1,xFilial("DA4")+cMotoriAnt,"DA4_NOME"),oReport:Row()+100,1000)
				EndIf

			EndIf
			oReport:Section(1):Section(nOrdem):SetPageBreak(.T.)
		EndIf
	EndDo
	oTempTable:Delete()
EndIf
RetIndex("DAK")
RetIndex("DAP")
Return


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RetVal   ³ Autor ³ Marco Bianchi         ³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna valor para as colunas Previsto, Valor a Receber    ³±±
±±³          ³ e Diferenca.                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAOMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function RetVal(nCol,cAliasDAK,cAliasDAP)
Local aFormas   := {}
Local nPosForma := 0
Local nRet      := 0

aFormas   := OsFormasPg((cAliasDAK)->DAK_COD,(cAliasDAK)->DAK_SEQCAR,1)
nPosForma := Ascan(aFormas,{|x| Alltrim(x[3]) == Alltrim((cAliasDAP)->DAP_CODGRU)})
If nCol == 1
	If nPosForma > 0
		nRet := aFormas[nPosForma][6]
	EndIf
ElseIf nCol == 2
	If nPosForma > 0
		nRet := (cAliasDAP)->DAP_PREVIS - aFormas[nPosForma][6]
	Else
		nRet := (cAliasDAP)->DAP_PREVIS
	EndIf
ElseIf nCol == 3
	If nPosForma > 0
		nRet := (cAliasDAP)->DAP_REALIZ - (cAliasDAP)->DAP_PREVIS + aFormas[nPosForma][6]
	Else
		nRet := (cAliasDAP)->DAP_REALIZ - (cAliasDAP)->DAP_PREVIS
	EndIf
EndIf
Return(nRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³OMSR040   ³ Autor ³ Henry Fila            ³ Data ³22.01.2002³±±
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

User Function OMSR040R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
	Local Titulo  := OemToAnsi(STR0001) //"Prestacao de Contas (Conferencia)"
	Local cDesc1  := OemToAnsi(STR0002) //"Este relatorio ira imprimir a Conferencia realizada naso"
	Local cDesc2  := OemToAnsi(STR0003) //"cargas de acordo com os parametros informados pelo usuario"
	Local cDesc3  := OemToAnsi("") //""  // Descricao 3
#ELSE
	Local Titulo  := STR0001
	Local cDesc1  := STR0002
	Local cDesc2  := STR0003
	Local cDesc3  := ""
#ENDIF

Local cString := "DAK"  // Alias utilizado na Filtragem
Local lDic    := .F. // Habilita/Desabilita Dicionario
Local lComp   := .T. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .T. // Habilita/Desabilita o Filtro
Local wnrel   := "OMSR040"  // Nome do Arquivo utilizado no Spool
Local nomeprog:= "OMSR040"  // nome do programa

Private Tamanho := "M" // P/M/G
Private Limite  := 132 // 80/132/220
Private cPerg   := "OMR040"  // Pergunta do Relatorio
Private aReturn := { STR0004, 1,STR0005, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
						//[1] Reservado para Formulario
						//[2] Reservado para N§ de Vias
						//[3] Destinatario
						//[4] Formato => 1-Comprimido 2-Normal
						//[5] Midia   => 1-Disco 2-Impressora
						//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//[7] Expressao do Filtro
						//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)
Private aOrdem  := {OemtoAnsi(STR0019), OemtoAnsi(STR0020), OemtoAnsi(STR0021)}

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

If DAP->(FieldPos("DAP_USER")) > 0

	wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
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
Local oTempTable:= NIL
Local cQuery    := ""
Local aStruDAK  := {}
Local aStruDAP  := {}
Local nX        := 0

Local aTotMot   := {}
Local aVlrDev   := {}

Local cIndDAK   := ""
Local cAliasDAK := "DAK"
Local cAliasDAP := "DAP"
Local cAliasTRB := ""

Local nIndDAK   := 0
Local nOrdem    := aReturn[8]

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
If TcSrvType() != "AS/400"

	lQuery   := .T.

	aStruDAK := DAK->(dbStruct())
	aStruDAP := DAP->(dbStruct())

	cAliasDAK := "TRBQRY"
	cAliasDAP := "TRBQRY"

	cQuery := "SELECT DAK.*, DAP.*"

	cQuery += " FROM "+ RetSqlName("DAK")+ " DAK ,"
	cQuery += RetSqlName("DAP")+ " DAP "

	cQuery += " WHERE DAK_FILIAL = '"+xFilial("DAK")+"' "
	cQuery += " AND DAK_COD >= '"+mv_par01+"' AND DAK_COD <='"+mv_par02+"' "
	cQuery += " AND DAK_SEQCAR >= '"+mv_par03+"' AND DAK_SEQCAR <='"+mv_par04+"' "
	cQuery += " AND DAK_CAMINH >= '"+mv_par05+"' AND DAK_CAMINH <='"+mv_par06+"' "
	cQuery += " AND DAK_MOTORI >= '"+mv_par07+"' AND DAK_MOTORI <='"+mv_par08+"' "
	cQuery += " AND DAK_FEZNF = '1'"
	cQuery += " AND (DAK_ACEFIN = '3' OR DAK_ACEFIN = '1' )"
	cQuery += " AND DAK.D_E_L_E_T_ = ' '"

	cQuery += " AND DAP_FILIAL = '"+xFilial("DAP")+"' "
	cQuery += " AND DAP_CARGA = DAK.DAK_COD "
	cQuery += " AND DAP_SEQCAR = DAK.DAK_SEQCAR "
	cQuery += " AND DAP_DTACER >= '"+Dtos(mv_par09)+"' AND DAP_DTACER <='"+Dtos(mv_par10)+"' "
	cQuery += " AND DAP.D_E_L_E_T_ = ' '"

	Do Case
		Case nOrdem == 1
			cQuery += "ORDER BY DAK_COD,DAK_SEQCAR"
		Case nOrdem == 2
			cQuery += "ORDER BY DAP_DTACER"
		Case nOrdem == 3
			cQuery += "ORDER BY DAK_MOTORI"
	End Case

	cQuery := ChangeQuery(cQuery)
	dBUseArea(.t.,"TOPCONN",TCGENQRY(,,cQuery),"TRBQRY",.f.,.t.)

	dbGotop()

	For nX := 1 To Len(aStruDAK)
		If aStruDAK[nX][2]!="C"
			TcSetField(cAliasDAK,aStruDAK[nX][1],aStruDAK[nX][2],aStruDAK[nX][3],aStruDAK[nX][4])
	EndIf
	Next nX

	For nX := 1 To Len(aStruDAP)
		If aStruDAP[nX][2]!="C"
			TcSetField(cAliasDAP,aStruDAP[nX][1],aStruDAP[nX][2],aStruDAP[nX][3],aStruDAP[nX][4])
		EndIf
	Next nX

Else
	cKey := IndexKey()

	cCondicao := 'DAK_FILIAL == "'+xFilial("DAK")+'".And.'
	cCondicao += 'DAK_COD    >= "'+mv_par01+'".And.DAK_COD <="'+mv_par02+'".And.'
	cCondicao += 'DAK_SEQCAR >= "'+mv_par03+'".And.DAK_SEQCAR <="'+mv_par04+'".And.'
	cCondicao += 'DAK_CAMINH >= "'+mv_par05+'".And.DAK_CAMINH <="'+mv_par06+'".And.'
	cCondicao += 'DAK_MOTORI >= "'+mv_par07+'".And.DAK_MOTORI <="'+mv_par08+'".And.'
	cCondicao += 'Dtos(DAK_DATA) >= "'+Dtos(mv_par09)+'".And.Dtos(DAK_DATA) <="'+Dtos(mv_par10)+'".And.'
	cCondicao += 'DAK_FEZNF == "1".And.'
	cCondicao += '(DAK_ACEFIN == "3" .Or. DAK_ACEFIN == "1") '

	IndRegua("DAK",cIndDAK,cKey,,cCondicao) //"Selecionando Registros ..."
	nIndDAK := RetIndex("DAK")
	#IFNDEF TOP
	dbSetIndex(cIndDAK+OrdBagExT())
	#ENDIF
	dbSetOrder(nIndDAK+1)
	dbGotop()

	cAliasDAK := "DAK"
	cAliasDAP := "DAP"
Endif

dbSelectArea(cAliasDAK)

Do Case
	Case nOrdem == 1
		Oms040Det1(cAliasDAK,cAliasDAP,Titulo,NomeProg,lQuery)
	Case nOrdem == 2
		U_Oms040Trb(nOrdem,@cAliasTRB,@cArqTRB,cAliasDAK,cAliasDAP,@aTotMot,@aVlrDev,lQuery)
		Oms040Det2(nOrdem,cAliasDAK,cAliasDAP,cAliasTRB,cArqTRB,aTotMot,aVlrDev,Titulo,NomeProg,lQuery)
	Case nOrdem == 3
		U_Oms040Trb(nOrdem,@cAliasTRB,@cArqTRB,cAliasDAK,cAliasDAP,@aTotMot,@aVlrDev,lQuery)
		Oms040Det2(nOrdem,cAliasDAK,cAliasDAP,cAliasTRB,cArqTRB,aTotMot,aVlrDev,Titulo,NomeProg,lQuery)
EndCase

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
±±³Program   ³Oms040Det1³ Autor ³ Henry Fila            ³ Data ³22.01.2002³±±
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

Static Function Oms040Det1(cAliasDAK,cAliasDAP,Titulo,NomeProg,lQuery)

Local aFormas   := {}

Local bWhileDAP := { || }

Local cCodDAK   := ""
Local cSeqDAK   := ""
//                                                1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                                      01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

Local cCabec1   := OemtoAnsi(STR0004) //"FORMA  DESCRICAO                         TOTAL              DEVOLUCAO          TOTAL A             REALIZADO       DIFERENCA"
Local cCabec2   := OemtoAnsi(STR0005) //"PAGTO "
Local cbCont    := 0   // Numero de Registros Processados
Local cbText    := ""
Local cPrefixo  := ""
Local cTitulo   := ""
Local cFornece  := ""
Local cLojaFor  := ""
Local cTipo     := ""
Local cParcela  := ""
Local cNomeUser := ""

Local nPosForma := 0
Local nTotalDev := 0
Local nTotalPrv := 0
Local nTotalRlz := 0
Local nTotalRec := 0
Local nTotalDif := 0
Local nTitMot   := 0
Local nVlrARec  := 0
Local nVlrDif   := 0
Local nDifCalc  := 0
Local nVlrDev   := 0

Local li        := 100 // Contador de Linhas
Local lSkip     := .F.
Local lImp      := .F. // Indica se algo foi impresso

Titulo  += " - "+aOrdem[aReturn[8]]

dbSelectArea(cAliasDAK)

While (cAliasDAK)->(!Eof())

	lSkip   := .F.
	lImp    := .T.
	nVlrDev := 0
	nTitMot := 0

	#IFNDEF WINDOWS
		If LastKey() = 286
			lEnd := .T.
		EndIf
	#ENDIF
	If lEnd
		@ Prow()+1,001 PSAY STR0022 //"CANCELADO PELO OPERADOR"
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
	@ li,055 PSAY OemtoAnsi(STR0008)+(cAliasDAK)->DAK_MOTORI + " - " + DA4->DA4_NOME //"MOTORISTA : "
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

	If !lQuery
		dbSelectArea(cAliasDAP)
		dbSetOrder(1)
		MsSeek(xFilial("DAP")+(cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR)

		bWhileDAP := { || (cAliasDAP)->(!Eof()) .And. (cAliasDAP)->DAP_FILIAL+(cAliasDAP)->DAP_CARGA+(cAliasDAP)->DAP_SEQCAR == ;
						xFilial("DAP")+(cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR }
	Else
		cCodDAK   := (cAliasDAK)->DAK_COD
		cSeqDAK   := (cAliasDAK)->DAK_SEQCAR
		bWhileDAP :=  {|| (cAliasDAP)->(!Eof()) .And. (cAliasDAP)->DAP_CARGA+(cAliasDAP)->DAP_SEQCAR == ;
							cCodDAK+cSeqDAK }
	Endif

	cNomeUser := UsrFullName((cAliasDAP)->DAP_USER)

	@ li,000 PSAY OemtoAnsi(STR0016) + cNomeUser
	li++
	@ li,000 PSAY __PrtThinLine()
	li++

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Busca as formas de pagamento e suas respectivas devolucoes    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aFormas := OsFormasPg((cAliasDAK)->DAK_COD,(cAliasDAK)->DAK_SEQCAR,1)

	//-- Verifica se existia formas de pagamentos previstas antes da conferencia
	If Empty(aFormas[1][3]) .And. Len(aFormas) == 1
		nVlrDev := aFormas[1][6]
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Zera totais por carga                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTotalPrv := 0
	nTotalRec := 0
	nTotalDev := 0
	nTotalRlz := 0
	nTotalDif := 0
	nDifCalc  := 0

	While Eval(bWhileDAP)

		cPrefixo  := (cAliasDAP)->DAP_PREFIX
		cTitulo   := (cAliasDAP)->DAP_NUM
		cFornece  := (cAliasDAP)->DAP_FORNEC
		cLojaFor  := (cAliasDAP)->DAP_LOJA
		cTipo     := (cAliasDAP)->DAP_TIPO
		cParcela  := (cAliasDAP)->DAP_PARCEL

		nPosForma := Ascan(aFormas,{|x| Alltrim(x[3]) == Alltrim((cAliasDAP)->DAP_CODGRU) })


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcula campos para impressao                     ³
		//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		nVlrARec  := (cAliasDAP)->DAP_PREVIS - Iif(nPosForma > 0,aFormas[nPosForma][6],0)
		nVlrDif   := (cAliasDAP)->DAP_REALIZ - (cAliasDAP)->DAP_PREVIS + Iif(nPosForma > 0,aFormas[nPosForma][6],0)

		If ( li > 53 )
			li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
			li++
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Linha de impressao                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ li,000 PSAY (cAliasDAP)->DAP_CODGRU
		@ li,008 PSAY Tabela("24",Alltrim((cAliasDAP)->DAP_CODGRU),.F.)
		@ li,036 PSAY (cAliasDAP)->DAP_PREVIS Picture "@( 99,999,999.99"
		@ li,056 PSAY Iif(nPosForma > 0,aFormas[nPosForma][6],0) Picture "@( 99,999,999.99"
		@ li,076 PSAY nVlrARec Picture "@( 99,999,999.99"
		@ li,096 PSAY (cAliasDAP)->DAP_REALIZ Picture "@( 99,999,999.99"
		@ li,112 PSAY nVlrDif Picture "@( 99,999,999.99"


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Acumula totais para posterior impressao                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotalPrv += (cAliasDAP)->DAP_PREVIS
		nTotalDev += Iif(nPosForma > 0,aFormas[nPosForma][6],0)
		nTotalRec += nVlrARec
		nTotalRlz += (cAliasDAP)->DAP_REALIZ
		nTotalDif += nVlrDif

		li++

		dbSelectArea(cAliasDAP)
		dbSkip()

		lSkip := .T.

	Enddo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se existe devolucoes com forma de pagamento indefinida            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nVlrDev > 0
		@ li,000 PSAY OemtoAnsi(STR0022) //"Devolucoes indefinidas :"
		@ li,056 PSAY nVlrDev Picture "@( 99,999,999.99"
		li++
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se gerou titulo para o motorista                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cTitulo)
		dbSelectArea("SE2")
		dbSetOrder(1)
		If MsSeek(xFilial("SE2")+cPrefixo+cTitulo+cParcela+cTipo+cFornece+cLojaFor)
			li++

			nTitMot := SE2->E2_VALOR

			@ li,000 PSAY SE2->E2_TIPO
			@ li,096 PSAY nTitMot Picture "@( 99,999,999.99"
			li++
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime totais                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ li,000 PSAY __PrtThinLine()
	li++

	If cTipo == MV_CPNEG
		nDifCalc  := (nTotalDif + nTitMot) + nVlrDev
		nTotalRlz += nTitMot
	Else
		nDifCalc  := (nTotalDif - nTitMot) + nVlrDev
		nTotalRlz -= nTitMot
	Endif

	nTotalDev += nVlrDev
	nTotalRec -= nVlrDev

	@ li, 000 PSAY OemtoAnsi(STR0018)
	@ li, 036 PSAY nTotalPrv Picture "@( 99,999,999.99"
	@ li, 056 PSAY nTotalDev Picture "@( 99,999,999.99"
	@ li, 076 PSAY nTotalRec Picture "@( 99,999,999.99"
	@ li, 096 PSAY nTotalRlz Picture "@( 99,999,999.99"
	@ li, 112 PSAY nDifCalc  Picture "@( 99,999,999.99"
	li++


	If mv_par11 == 1
		li++
		If mv_par12 == 1
			li += 5
			@ li,000 PSAY "______________________________"
			@ li,090 PSAY "______________________________"
			li++
			@ li,000 PSAY Alltrim(cNomeUser)+OemtoAnsi(STR0024)
			@ li,090 PSAY DA4->DA4_NOME
		Endif
		li := 100
	Else
		@ li,000 PSAY __PrtThinLine()
		li++
		li++
	Endif

	If !lQuery .Or. !lSkip
		dbSelectArea(cAliasDAK)
		dbSkip()
	EndIf

Enddo

If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³Oms040Det2³ Autor ³ Henry Fila            ³ Data ³22.01.2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio por ordem de carga                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpN1 : Ordem do relatorio                                  ³±±
±±³          ³ExpC2 : Alias do arquivo DAK                                ³±±
±±³          ³ExpC3 : Alias do arquivo DAP                                ³±±
±±³          ³ExpC4 : Alias do arquivo TRB                                ³±±
±±³          ³ExpC5 : Titulo do relatorio                                 ³±±
±±³          ³ExpC6 : Nome do programa                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 : Alias do Arquivo DAK                                ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Oms040Det2(nOrdem,cAliasDAK,cAliasDAP,cAliasTRB,cArqTRB,aTotMot,aVlrDev,Titulo,NomeProg,lQuery)

Local cQuebra   := ""
Local cCabec1   := OemtoAnsi(STR0004) //"FORMA  DESCRICAO                         PREVISTO           DEVOLUCAO          DIFERENCA           REALIZADO"
Local cCabec2   := OemtoAnsi(STR0005) //"PAGTO "
Local cbCont    := 0   // Numero de Registros Processados
Local cbText    := ""
Local cMotorista:= ""
Local cASeek    := ""
Local cNomeUser := ""

Local li        := 100

Local dDataAcer := Ctod("//")
Local lImp      := .F. // Indica se algo foi impresso

Local nTotalPrv := 0
Local nTotalRlz := 0
Local nTotalRec := 0
Local nTotalDev := 0
Local nTotalDif := 0
Local nPosTitMot:= 0
Local nTotCrdMot:= 0
Local nTotDebMot:= 0
Local nX        := 0
Local nPosMot   := 0
Local nPosDev   := 0

Titulo  += " - "+aOrdem[aReturn[8]]

dbSelectArea(cAliasTRB)
dbGotop()

While (cAliasTRB)->(!EOf())

	If ( li > 53 )
		li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
		li++
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Limpa variaveis de acumuladores                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cUser      := (cAliasTRB)->TRB_USER
	nTotDebMot := 0
	nTotCdrMot := 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime com quebra de acordo com a ordem escolhida            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cNomeUser := UsrFullName((cAliasTRB)->TRB_USER)

	If nOrdem == 2
		dDataAcer := (cAliasTRB)->TRB_DTACER

		@ li,000 PSAY OemToAnsi(STR0015) + DtoC((cAliasTRB)->TRB_DTACER)
		@ li,070 PSAY OemtoAnsi(STR0016) + cNomeUser
		bWhile := {|| (cAliasTRB)->(!Eof()) .And. (cAliasTRB)->TRB_DTACER == dDataAcer .And.;
						(cAliasTRB)->TRB_USER == cUser }
	Else
		cMotorista := (cAliasTRB)->TRB_MOTORI

		dbSelectArea("DA4")
		dbSetOrder(1)
		MsSeek(xFilial("DA4")+cMotorista)

		@ li,000 PSAY OemtoAnsi(STR0017) + (cAliasTRB)->TRB_MOTORI+"-"+DA4->DA4_NOME
		@ li,070 PSAY OemtoAnsi(STR0016) + cNomeUser
		bWhile := {|| (cAliasTRB)->(!Eof()) .And. (cAliasTRB)->TRB_MOTORI == cMotorista .And.;
						(cAliasTRB)->TRB_USER == cUser}
	Endif

	li++
	@ li,000 PSAY __PrtThinLine()
	li++

	nTotalPrv := 0
	nTotalRlz := 0
	nTotalRec := 0
	nTotalDev := 0
	nTotalDif := 0

	While Eval(bWhile)

		If ( li > 53 )
			li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
			li++
		Endif

		@ li,000 PSAY (cAliasTRB)->TRB_CODGRU
		@ li,008 PSAY Tabela("24",Alltrim((cAliasTRB)->TRB_CODGRU),.F.)
		@ li,036 PSAY (cAliasTRB)->TRB_PREVIS Picture "@( 99,999,999.99"
		@ li,056 PSAY (cAliasTRB)->TRB_DEVOL  Picture "@( 99,999,999.99"

		@ li,076 PSAY (cAliasTRB)->TRB_ARECEB Picture "@( 99,999,999.99"
		@ li,096 PSAY (cAliasTRB)->TRB_REALIZ Picture "@( 99,999,999.99"
		@ li,112 PSAY (cAliasTRB)->TRB_DIFERE Picture "@( 99,999,999.99"

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Acumula totais da quebra                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotalPrv += (cAliasTRB)->TRB_PREVIS
		nTotalDev += (cAliasTRB)->TRB_DEVOL
		nTotalRec += (cAliasTRB)->TRB_ARECEB
		nTotalRlz += (cAliasTRB)->TRB_REALIZ
		nTotalDif += (cAliasTRB)->TRB_DIFERE

		li++

		dbSelectArea(cAliasTRB)
		dbSkip()

	Enddo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Identifica quais os tipos de titulos gerados e separa para impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cASeek  := Iif( nOrdem == 2, DtoS(dDataAcer) , cMotorista )

	nPosMot := Ascan(aTotMot,{|x| x[1] == cASeek })

	If nPosMot > 0

		For nX := 1 to Len(aTotMot[nPosMot][2])
			If aTotMot[nPosMot][2][nX][1] == MV_CPNEG
				nTotDebMot += aTotMot[nPosMot][2][nX][2]
				nTotalDif  += aTotMot[nPosMot][2][nX][2]
				nTotalRlz  += aTotMot[nPosMot][2][nX][2]
			Else
				nTotCrdMot += aTotMot[nPosMot][2][nX][2]
				nTotalDif  -= aTotMot[nPosMot][2][nX][2]
				nTotalRlz  -= aTotMot[nPosMot][2][nX][2]
			Endif
		Next

	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime as linhas dos acumulados dos totais do motorista            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTotDebMot > 0
		li++
		@ li,000 PSAY MV_CPNEG
		@ li,096 PSAY nTotDebMot Picture "@( 99,999,999.99"
	Endif

	If nTotCrdMot > 0
		li++
		@ li,000 PSAY "NCF"
		@ li,096 PSAY nTotCrdMot Picture "@( 99,999,999.99"
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se existe devolucoes com forma de pagamento indefinida            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	nPosDev := Ascan(aVlrDev,{|x| x[1] == cASeek })

	If nPosDev > 0
		li++
		@ li,000 PSAY OemtoAnsi(STR0022) //"Devolucoes Indefinidas :"
		@ li,056 PSAY aVlrDev[nPosDev][2] Picture "@( 99,999,999.99"

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Soma as devolucoes na diferenca final                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotalDif += aVlrDev[nPosDev][2]
		nTotalDev += aVlrDev[nPosDev][2]
		nTotalRec -= aVlrDev[nPosDev][2]
	Endif

	li++
	@ li,000 PSAY __PrtThinLine()
	li++

	@ li, 000 PSAY OemtoAnsi(STR0018)
	@ li, 036 PSAY nTotalPrv Picture "@( 99,999,999.99"
	@ li, 056 PSAY nTotalDev Picture "@( 99,999,999.99"
	@ li, 076 PSAY nTotalRec Picture "@( 99,999,999.99"
	@ li, 096 PSAY nTotalRlz Picture "@( 99,999,999.99"
	@ li, 112 PSAY nTotalDif Picture "@( 99,999,999.99"
	li++
	@ li,000 PSAY __PrtThinLine()
	li++
	li++

	If ( li > 53 )
		li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
		li++
	Endif

	If mv_par11 == 1

		li++
		If mv_par12 == 1
			li += 5
			@ li,000 PSAY "______________________________"

			If nOrdem == 3
				@ li,090 PSAY "______________________________"
			Endif

			li++
			@ li,000 PSAY Alltrim(cNomeUser)+OemtoAnsi(STR0024)

			If nOrdem == 3
				@ li,090 PSAY DA4->DA4_NOME
			Endif

		Endif

		li := 100
	Endif

Enddo

dbSelectArea(cAliasTRB)
dbCloseArea()
Ferase(cArqTRB+OrdBagExt())

If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³Oms040Trb ³ Autor ³ Henry Fila            ³ Data ³22.01.2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Arquivo temporario para acumular formas de pagamento        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpN1 : Ordem do relatorio                                  ³±±
±±³          ³ExpC1 : Alias do Arquivo DAK                                ³±±
±±³          ³ExpL1 : Se usa query                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Oms040Trb(nOrdem,cAliasTRB,oTempTable,cAliasDAK,cAliasDAP,aTotMot,aVlrDev,lQuery)
Local aFormas   := {}
Local aCampos   := {}

Local cNomInd   := ""
Local cTipo     := ""
Local cPrefixo  := ""
Local cTitulo   := ""
Local cFornece  := ""
Local cLojaFor  := ""
Local cParcela  := ""
Local cTipoTit  := ""

Local dDataAcer := CriaVar("DAP_DTACER",.F.)

Local nPosForma := 0
Local nVlrARec  := 0
Local nDifRec   := 0
Local nPosTitMot:= 0
Local nVlrTitMot:= 0
Local nPosDev

Local lSkip     := .F.

Aadd(aCampos, {"TRB_FILIAL","C",FWGETTAMFILIAL,0})
Aadd(aCampos, {"TRB_CARGA","C",6,0})
Aadd(aCampos, {"TRB_SEQCAR","C",2,0})
Aadd(aCampos, {"TRB_MOTORI","C",6,0})
Aadd(aCampos, {"TRB_DTACER","D",8,2})
Aadd(aCampos, {"TRB_CODGRU","C",3,0})
Aadd(aCampos, {"TRB_PREVIS","N",12,2})
Aadd(aCampos, {"TRB_DEVOL","N",12,2})
Aadd(aCampos, {"TRB_ARECEB","N",12,2})
Aadd(aCampos, {"TRB_REALIZ","N",12,2})
Aadd(aCampos, {"TRB_DIFERE","N",12,2})
Aadd(aCampos, {"TRB_PREFIX","C",3,0})
Aadd(aCampos, {"TRB_NUM"   ,"C",6,0})
Aadd(aCampos, {"TRB_TIPO"  ,"C",3,0})
Aadd(aCampos, {"TRB_PARCEL","C",1,0})
Aadd(aCampos, {"TRB_FORNEC","C",6,0})
Aadd(aCampos, {"TRB_LOJA"  ,"C",2,0})
Aadd(aCampos, {"TRB_USER"  ,"C",6,2})

cAliasTRB := "TRBARQ"
oTempTable := FWTemporaryTable():New( cAliasTRB )
oTempTable:SetFields( aCampos )
If nOrdem == 2
	oTempTable:AddIndex("01", {"TRB_MOTORI","TRB_USER","TRB_CODGRU"} )
Else
	oTempTable:AddIndex("01", {"TRB_DTACER","TRB_USER","TRB_CODGRU"} )
EndIf
oTempTable:Create()

dbSelectArea(cAliasDAK)

While !Eof()

	lSkip   := .F.

	dbSelectArea(cAliasDAP)

	If !lQuery
		dbSelectArea(cAliasDAP)
		dbSetOrder(1)
		MsSeek(xFilial("DAP")+(cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR)

		bWhileDAP := { || !Eof() .And. (cAliasDAP)->DAP_FILIAL+(cAliasDAP)->DAP_CARGA+(cAliasDAP)->DAP_SEQCAR == ;
						xFilial("DAP")+(cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR }
	Else
		cCodDAK   := (cAliasDAK)->DAK_COD
		cSeqDAK   := (cAliasDAK)->DAK_SEQCAR
		bWhileDAP :=  {|| (cAliasDAP)->(!Eof()) .And. (cAliasDAP)->DAP_CARGA+(cAliasDAP)->DAP_SEQCAR == ;
							cCodDAK+cSeqDAK }
	Endif

	aFormas := OsFormasPg((cAliasDAK)->DAK_COD,(cAliasDAK)->DAK_SEQCAR,1)

	While Eval(bWhileDAP)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Guarda variáveis de uso posterior                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cPrefixo  := (cAliasDAP)->DAP_PREFIX
		cTitulo   := (cAliasDAP)->DAP_NUM
		cFornece  := (cAliasDAP)->DAP_FORNEC
		cLojaFor  := (cAliasDAP)->DAP_LOJA
		cTipo     := (cAliasDAP)->DAP_TIPO
		cParcela  := (cAliasDAP)->DAP_PARCEL
		dDataAcer := (cAliasDAP)->DAP_DTACER

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Busca de acordo com a quebra da ordem escolhida                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Do Case
			Case nOrdem == 2
				cSeek := Dtos((cAliasDAP)->DAP_DTACER)+ (cAliasDAP)->DAP_USER + (cAliasDAP)->DAP_CODGRU
			Case nOrdem == 3
				cSeek := (cAliasDAK)->DAK_MOTORI + (cAliasDAP)->DAP_USER + (cAliasDAP)->DAP_CODGRU
		EndCase
		nPosForma := Ascan(aFormas,{|x| Alltrim(x[3]) == Alltrim((cAliasDAP)->DAP_CODGRU) })


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Grava arquivo temporario                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasTRB)
		dbSetOrder(1)
		If MsSeek(cSeek)
			RecLock(cAliasTRB,.F.)
		Else
			RecLock(cAliasTRB,.T.)
				(cAliasTRB)->TRB_FILIAL := (cAliasDAK)->DAK_FILIAL
				(cAliasTRB)->TRB_CARGA  := (cAliasDAK)->DAK_COD
				(cAliasTRB)->TRB_SEQCAR := (cAliasDAK)->DAK_SEQCAR
				(cAliasTRB)->TRB_MOTORI := (cAliasDAK)->DAK_MOTORI
				(cAliasTRB)->TRB_DTACER := (cAliasDAP)->DAP_DTACER
				(cAliasTRB)->TRB_CODGRU := (cAliasDAP)->DAP_CODGRU
				(cAliasTRB)->TRB_USER   := (cAliasDAP)->DAP_USER
				(cAliasTRB)->TRB_PREFIX := (cAliasDAP)->DAP_PREFIX
				(cAliasTRB)->TRB_NUM    := (cAliasDAP)->DAP_NUM
				(cAliasTRB)->TRB_PARCEL := (cAliasDAP)->DAP_PARCEL
				(cAliasTRB)->TRB_TIPO   := (cAliasDAP)->DAP_TIPO
				(cAliasTRB)->TRB_FORNEC := (cAliasDAP)->DAP_FORNEC
				(cAliasTRB)->TRB_LOJA   := (cAliasDAP)->DAP_LOJA
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcula campos                                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nVlrARec := (cAliasDAP)->DAP_PREVIS - Iif(nPosForma > 0,aFormas[nPosForma][6],0)
		nDifRec  := (cAliasDAP)->DAP_REALIZ - nVlrARec

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Acumula totais                                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		(cAliasTRB)->TRB_PREVIS += (cAliasDAP)->DAP_PREVIS
		(cAliasTRB)->TRB_DEVOL  += Iif(nPosForma > 0,aFormas[nPosForma][6],0)
		(cAliasTRB)->TRB_ARECEB += nVlrARec
		(cAliasTRB)->TRB_REALIZ += (cAliasDAP)->DAP_REALIZ
		(cAliasTRB)->TRB_DIFERE += nDifRec
		Msunlock()

		dbSelectArea(cAliasDAP)
		dbSkip()

		lSkip := .T.

	Enddo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Busca se a carga teve titulos gerados para o motorista            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nVlrTitMot := 0
	cTipoTit      := ""

	dbSelectArea("SE2")
	dbSetOrder(1)
	If MsSeek(xFilial("SE2")+cPrefixo+cTitulo+cParcela+cTipo+cFornece+cLojaFor)
		nVlrTitMot := SE2->E2_VALOR
		cTipoTit   := SE2->E2_TIPO
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula no array todos os titulos das cargas para os motoristas   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nPosTitMot := Ascan(aTotMot,{|x| x[1] == Iif(nOrdem == 2,DTos(dDataAcer),(cAliasDAK)->DAK_MOTORI)})
	If nPosTitMot == 0
		AAdd(aTotMot,{Iif(nOrdem == 2,DTos(dDataAcer),(cAliasDAK)->DAK_MOTORI),{{ cTipoTit, nVlrTitMot}}})
	Else
		Aadd(aTotMot[nPosTitMot][2],{cTipoTit,nVlrTitMot})
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se existia formas de pagamentos previstas antes da³
	//³conferencia                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Empty(aFormas[1][3]) .And. Len(aFormas) == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Acumula no array as cargas com devolucoes nao previstas           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosDev := Ascan(aVlrDev,{|x| x[1] == Iif(nOrdem == 2,DTos(dDataAcer),(cAliasDAK)->DAK_MOTORI)})
		If nPosDev == 0
			AAdd(aVlrDev,{Iif(nOrdem == 2,DTos(dDataAcer),(cAliasDAK)->DAK_MOTORI),aFormas[1][6]})
		Else
			aVlrDev[nPosDev][2] += aFormas[1][6]
		Endif
	Endif


	If !lQuery .Or. !lSkip
		dbSelectArea(cAliasDAK)
		dbSkip()
	EndIf
	dbSelectArea(cALiasDAK)

EndDo

Return

