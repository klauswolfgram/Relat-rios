/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "OMSR060.CH"
#INCLUDE "PROTHEUS.CH"
#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ OMSR060  ³ Autor ³ Marco Bianchi         ³ Data ³ 04/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Roteirizacao - Release 4.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAOMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function OMSR060()
Local oReport := Nil

	If FindFunction("OMSMsgRelD")
		OMSMsgRelD()
	EndIf

	If FindFunction("TRepInUse") .And. TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	Else
		U_OMSR060R3()
	EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 04/08/06 ³±±
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
	Local cAliasSA1  := GetNextAlias()
	Local cAliasDA9  := cAliasSA1
	Local cAliasDA8  := cAliasDA9
	Local cAliasDA7  := cAliasDA8	
	Local cAliasDA6  := cAliasDA7
	Local cAliasDA5  := cAliasDA6
	Local cAlias	   := cAliasDA5			
#ELSE	
	Local cAlias    := ""
	Local cAliasDA5 := "DA5"
	Local cAliasDA6 := "DA6"
	Local cAliasDA7 := "DA7"
	Local cAliasDA8 := "DA8"
	Local cAliasDA9 := "DA9"
	Local cAliasSA1 := "SA1"
#ENDIF

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
oReport := TReport():New("OMSR060",STR0017,"OMR060", {|oReport| ReportPrint(oReport,cAlias,cAliasDA5,cAliasDA6,cAliasDA7,cAliasDA8,cAliasDA9,cAliasSA1)},STR0018 + " " + STR0019 + " " + STR0020)	// "Roteirizacoes"###"Este programa ira emitir a Relacao da Roteirizacao"###"distribuida por Rotas, Zonas, Setores e Clientes por Setor"###"de acordo com os parametros escolhidos pelo usuario."
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
//³Ordem: por Roteirizacao                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao Rotas - Section(1)                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oRota := TRSection():New(oReport,STR0023,{"DA8","DA9","DA5","DA6","DA7","SA1"},{STR0021,STR0022},/*Campos do SX3*/,/*Campos do SIX*/) // "Rota"###"Por Roteirizacao"###"Por Clientes"
oRota:SetTotalInLine(.F.)
TRCell():New(oRota,"DA8_COD" ,"DA8",RetTitle("DA8_COD") ,PesqPict("DA8","DA8_COD") ,TamSx3("DA8_COD" )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oRota,"DA8_DESC","DA8",RetTitle("DA8_DESC"),PesqPict("DA8","DA8_DESC"),TamSx3("DA8_DESC")[1],/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao Zona - Section(1):Section(1)                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oZona := TRSection():New(oRota,STR0024,{"DA9","DA5","DA6"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) // "Roteirizacoes"
oZona:SetTotalInLine(.F.)
TRCell():New(oZona,"DA9_SEQUEN","DA9",RetTitle("DA9_SEQUEN"),PesqPict("DA9","DA9_SEQUEN"),TamSx3("DA9_SEQUEN")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oZona,"DA9_PERCUR","DA9",RetTitle("DA9_PERCUR"),PesqPict("DA9","DA9_PERCUR"),TamSx3("DA9_PERCUR")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oZona,"DA5_DESC"  ,"DA5",RetTitle("DA5_DESC"  ),PesqPict("DA5","DA5_DESC"  ),TamSx3("DA5_DESC"  )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oZona,"DA9_ROTA"  ,"DA9",RetTitle("DA9_ROTA"  ),PesqPict("DA9","DA9_ROTA"  ),TamSx3("DA9_ROTA"  )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oZona,"DA6_REF"   ,"DA6",RetTitle("DA6_REF"   ),PesqPict("DA6","DA6_REF"   ),TamSx3("DA6_REF"   )[1],/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao Sequencias - Section(1):Section(1):Section(1)                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSequencia := TRSection():New(oZona,STR0025,{"DA7","SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) // "Roteirizacoes"
oSequencia:SetTotalInLine(.F.)
TRCell():New(oSequencia,"DA7_SEQUEN","DA7",RetTitle("DA7_SEQUEN"),PesqPict("DA7","DA7_SEQUEN"),TamSx3("DA7_SEQUEN")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSequencia,"DA7_CEPDE" ,"DA7",RetTitle("DA7_CEPDE" ),PesqPict("DA7","DA7_CEPDE" ),TamSx3("DA7_CEPDE" )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSequencia,"DA7_CEPATE","DA7",RetTitle("DA7_CEPATE"),PesqPict("DA7","DA7_CEPATE"),TamSx3("DA7_CEPATE")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSequencia,"DA7_CLIENT","DA7",RetTitle("DA7_CLIENT"),PesqPict("DA7","DA7_CLIENT"),TamSx3("DA7_CLIENT")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSequencia,"DA7_LOJA"  ,"DA7",RetTitle("DA7_LOJA"  ),PesqPict("DA7","DA7_LOJA"  ),TamSx3("DA7_LOJA"  )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSequencia,"A1_NOME"   ,"SA1",RetTitle("A1_NOME"   ),PesqPict("SA1","A1_NOME"   ),TamSx3("A1_NOME"   )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSequencia,"A1_END"    ,"SA1",RetTitle("A1_END"    ),PesqPict("SA1","A1_END"    ),TamSx3("A1_END"    )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSequencia,"A1_MUN"    ,"SA1",RetTitle("A1_MUN"    ),PesqPict("SA1","A1_MUN"    ),(TamSx3("A1_MUN"   )[1]-20),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSequencia,"A1_EST"    ,"SA1",RetTitle("A1_EST"    ),PesqPict("SA1","A1_EST"    ),TamSx3("A1_EST"    )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSequencia,"A1_CEP"    ,"SA1",RetTitle("A1_CEP"    ),PesqPict("SA1","A1_CEP"    ),(TamSx3("A1_CEP"   )[1]+1),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSequencia,"DA7_REF"   ,"DA7",RetTitle("DA7_REF"   ),PesqPict("DA7","DA7_REF"   ),TamSx3("DA7_REF"   )[1],/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ordem: por Cliente                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao Cliente -  Section(2)                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCliente := TRSection():New(oReport,STR0026,{"SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) // "Roteirizacoes"
oCliente:SetTotalInLine(.F.)
TRCell():New(oCliente,"A1_COD"  ,"SA1",RetTitle("A1_COD" ),PesqPict("SA1","A1_COD" ),TamSx3("A1_COD" )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"A1_LOJA" ,"SA1",RetTitle("A1_LOJA"),PesqPict("SA1","A1_LOJA"),TamSx3("A1_LOJA")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"A1_NOME" ,"SA1",RetTitle("A1_NOME"),PesqPict("SA1","A1_NOME"),TamSx3("A1_NOME")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"A1_END"  ,"SA1",RetTitle("A1_END" ),PesqPict("SA1","A1_END" ),TamSx3("A1_END" )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"A1_MUN"  ,"SA1",RetTitle("A1_MUN" ),PesqPict("SA1","A1_MUN" ),(TamSx3("A1_MUN")[1]-20),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"A1_EST"  ,"SA1",RetTitle("A1_EST" ),PesqPict("SA1","A1_EST" ),TamSx3("A1_EST" )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"A1_CEP"  ,"SA1",RetTitle("A1_CEP" ),PesqPict("SA1","A1_CEP" ),(TamSx3("A1_CEP")[1] + 1),/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao Sequencia do Cliente -  Section(2):Seciotn(1)                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSeqCli := TRSection():New(oCliente,STR0027,{"DA7","DA5","DA6","DA9","DA8"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) // "Roteirizacoes"
oSeqCli:SetTotalInLine(.F.)
TRCell():New(oSeqCli,"DA7_PERCUR","DA7",RetTitle("DA7_PERCUR"),PesqPict("DA7","DA7_PERCUR" ),TamSx3("DA7_PERCUR" )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSeqCli,"DA5_DESC"  ,"DA5",RetTitle("DA5_DESC"  ),PesqPict("DA5","DA5_DESC"   ),TamSx3("DA5_DESC"   )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSeqCli,"DA7_ROTA"  ,"DA7",RetTitle("DA7_ROTA"  ),PesqPict("DA7","DA7_ROTA"   ),TamSx3("DA7_ROTA"   )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSeqCli,"DA6_REF"   ,"DA6",RetTitle("DA6_REF"   ),PesqPict("DA6","DA6_REF"    ),TamSx3("DA6_REF"    )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSeqCli,"DA7_SEQUEN","DA7",RetTitle("DA7_SEQUEN"),PesqPict("DA7","DA7_SEQUEN" ),TamSx3("DA7_SEQUEN" )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSeqCli,"DA9_ROTEIR","DA9",RetTitle("DA9_ROTEIR"),PesqPict("DA9","DA9_ROTEIR" ),TamSx3("DA9_ROTEIR" )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSeqCli,"DA8_DESC"  ,"DA8",RetTitle("DA8_DESC"  ),PesqPict("DA8","DA8_DESC"   ),TamSx3("DA8_DESC"   )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSeqCli,"DA9_SEQUEN","DA9",RetTitle("DA9_SEQUEN"),PesqPict("DA9","DA9_SEQUEN" ),TamSx3("DA9_SEQUEN" )[1],/*lPixel*/,/*{|| code-block de impressao }*/)
Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 04/08/06 ³±±
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
Static Function ReportPrint(oReport,cAlias,cAliasDA5,cAliasDA6,cAliasDA7,cAliasDA8,cAliasDA9,cAliasSA1)
Local nOrdem := oReport:Section(1):GetOrder()
Local lQuery := .F.
Local nX     := 0
Local cSelect := ''
Local cCpos060 := ''

#IFDEF TOP
	Local cQuery 	:= ""
	Local cUserFlds := ""
	Local aCampos   := {}
#ELSE
	Local cCondicao := ""
#ENDIF

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//-- Filtragem do relatorio
If	nOrdem == 1 // por Roteirizacao
	oReport:Section(2):Disable()

	#IFDEF TOP

		If	TcSrvType() <> "AS/400"

			lQuery := .T.
			//-- Uso de UNION: campos incluidos pelo usuario devem ser incluidos na 2a. SELECT
			aCampos:= oReport:Section(1):Section(1):Section(1):aCell
			For nX := 1 to Len(aCampos)
				If	aCampos[nX]:lUserEnabled .And. aCampos[nX]:lUserField
					cUserFlds +=", ' ' "+aCampos[nX]:cName
					cCpos060  += ","+aCampos[nX]:cName
				EndIf
			Next
			cUserFlds := "%" + cUserFlds + "%"

			cSelect +="% DA8_FILIAL,DA8_COD,DA8_DESC,DA9_FILIAL,DA9_ROTEIR,DA9_SEQUEN,DA9_PERCUR,"
			cSelect +="DA9_ROTA,DA5_COD,DA5_DESC,DA6_ROTA,DA6_REF,DA7_FILIAL,DA7_SEQUEN,"
			cSelect +="DA7_PERCUR,DA7_ROTA,DA7_CLIENT,DA7_LOJA,DA7_CEPDE,DA7_CEPATE,DA7_REF,A1_NOME,A1_END,A1_MUN,A1_EST,A1_CEP, '1' TIPO"

			If !Empty(cCpos060)
				cSelect += cCpos060+" %"
			Else
				cSelect += " %"
			EndIf

			oReport:Section(1):BeginQuery()
			BeginSql Alias cAliasDA8
			SELECT %Exp:cSelect%
			FROM %Table:DA5% DA5, %Table:DA6% DA6,%Table:DA7% DA7, %Table:DA8% DA8, %Table:DA9% DA9, %Table:SA1% SA1
			WHERE
			DA8_FILIAL = %xFilial:DA8% AND
			DA8_COD >= %Exp:mv_par01% AND
			DA8_COD <= %Exp:mv_par02% AND
			DA8.%Notdel% AND

			DA9_FILIAL = %xFilial:DA9% AND
			DA9_PERCUR >= %Exp:mv_par03% AND
			DA9_PERCUR <= %Exp:mv_par04% AND
			DA9_ROTA >= %Exp:mv_par05% AND
			DA9_ROTA <= %Exp:mv_par06% AND
			DA8_COD = DA9_ROTEIR AND
			DA9.%Notdel% AND

			DA7_FILIAL = %xFilial:DA7% AND
			DA7_PERCUR = DA9_PERCUR AND
			DA7_ROTA = DA9_ROTA AND
			DA7_CLIENT >= %Exp:mv_par07% AND
			DA7_CLIENT <= %Exp:mv_par08% AND
			DA7_LOJA >= %Exp:mv_par09% AND
			DA7_LOJA <= %Exp:mv_par10% AND
			DA7.%Notdel% AND

			A1_FILIAL = %xFilial:SA1% AND
			A1_COD = DA7_CLIENT AND
			A1_LOJA = DA7_LOJA AND
			A1_CEP >= %Exp:mv_par11% AND
			A1_CEP <= %Exp:mv_par12% AND
			SA1.%Notdel% AND

			DA6_FILIAL = %xFilial:DA6% AND
			DA6_PERCUR = DA9_PERCUR AND
			DA6_ROTA = DA9_ROTA AND
			DA6.%Notdel% AND

			DA5_FILIAL = %xFilial:DA5% AND
			DA5_COD = DA9_PERCUR AND
			DA5_VENDED >= %Exp:mv_par13% AND
			DA5_VENDED <= %Exp:mv_par14% AND
			DA5.%Notdel%

			UNION

			SELECT
			DA8_FILIAL,DA8_COD,DA8_DESC,DA9_FILIAL,DA9_ROTEIR,DA9_SEQUEN,DA9_PERCUR,
			DA9_ROTA,DA5_COD,DA5_DESC,DA6_ROTA,DA6_REF,DA7_FILIAL,DA7_SEQUEN,
			DA7_PERCUR,DA7_ROTA,DA7_CLIENT,DA7_LOJA,DA7_CEPDE,DA7_CEPATE,DA7_REF,' ' A1_NOME,' ' A1_END,' ' A1_MUN,' ' A1_EST,' ' A1_CEP, '2' TIPO
			%Exp:cUserFlds%
			FROM %Table:DA5% DA5, %Table:DA6% DA6,%Table:DA7% DA7, %Table:DA8% DA8, %Table:DA9% DA9, %Table:SA1% SA1
			WHERE
			DA8_FILIAL = %xFilial:DA8% AND
			DA8_COD >= %Exp:mv_par01% AND
			DA8_COD <= %Exp:mv_par02% AND
			DA8.%Notdel% AND

			DA9_FILIAL = %xFilial:DA9% AND
			DA9_PERCUR >= %Exp:mv_par03% AND
			DA9_PERCUR <= %Exp:mv_par04% AND
			DA9_ROTA >= %Exp:mv_par05% AND
			DA9_ROTA <= %Exp:mv_par06% AND
			DA8_COD = DA9_ROTEIR AND
			DA9.%Notdel% AND

			DA7_FILIAL = %xFilial:DA7% AND
			DA7_PERCUR = DA9_PERCUR AND
			DA7_ROTA = DA9_ROTA AND
			DA7_CLIENT >= %Exp:mv_par07% AND
			DA7_CLIENT <= %Exp:mv_par08% AND
			DA7_LOJA >= %Exp:mv_par09% AND
			DA7_LOJA <= %Exp:mv_par10% AND
			DA7.%Notdel% AND

			NOT EXISTS ( SELECT A1_COD, A1_LOJA FROM  %Table:SA1% SA1
			WHERE A1_FILIAL = %xFilial:SA1% AND
			A1_COD = DA7_CLIENT AND
			A1_LOJA = DA7_LOJA AND
			A1_CEP >= %Exp:mv_par11% AND
			A1_CEP <= %Exp:mv_par12% AND
			SA1.%Notdel%) AND

			DA6_FILIAL = %xFilial:DA6% AND
			DA6_PERCUR = DA9_PERCUR AND
			DA6_ROTA = DA9_ROTA AND
			DA6.%Notdel% AND

			DA5_FILIAL = %xFilial:DA5% AND
			DA5_COD = DA9_PERCUR AND
			DA5_VENDED >= %Exp:mv_par13% AND
			DA5_VENDED <= %Exp:mv_par14% AND
			DA5.%Notdel%

			ORDER BY DA8_COD,DA9_SEQUEN,DA9_PERCUR,DA9_ROTA,TIPO,DA7_SEQUEN,DA7_CLIENT,DA7_LOJA
			EndSql

			oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

			//-- Usa Query da Secao Principal nas Secoes Filhas
			oReport:Section(1):Section(1):SetParentQuery()
			oReport:Section(1):Section(1):Section(1):SetParentQuery()
		Else
	#ENDIF
			dbSelectArea(cAliasDA8)	//-- Cadastro de Rotas
			dbSetOrder(1)			//-- DA8_FILIAL+DA8_COD
			//-- Filtra Rotas de acordo com parametros
			cCondicao := 'DA8_FILIAL == "'+xFilial("DA8")+'".And.'
			cCondicao += 'DA8_COD >= "'+mv_par01+'".And.DA8_COD <="'+mv_par02+'"'
			oReport:Section(1):SetFilter(cCondicao,(cAliasDA8)->(IndexKey()))
			//-- Relaciona tabela principal com tabelas filhas
			oReport:Section(1):Section(1):SetRelation({|| xFilial("DA9")+(cAliasDA8)->DA8_COD}, cAliasDA9 , 1 , .T. )
			oReport:Section(1):Section(1):Section(1):SetRelation({|| xfilial("DA7")+(cAliasDA9)->DA9_PERCUR+(cAliasDA9)->DA9_ROTA}, cAliasDA7 , 1 , .T. )
	#IFDEF TOP
		EndIf
	#ENDIF

	//-- Define regra de saida do loop quando mutilizado metodo Print
	oReport:Section(1):Section(1):SetParentFilter({|x| (cAliasDA9)->DA9_FILIAL+(cAliasDA9)->DA9_ROTEIR == x},{||xFilial("DA9")+(cAliasDA8)->DA8_COD})
	oReport:Section(1):Section(1):Section(1):SetParentFilter({|x| (cAliasDA7)->DA7_FILIAL+(cAliasDA7)->DA7_PERCUR+(cAliasDA7)->DA7_ROTA == x},{||xFilial("DA7")+(cAliasDA9)->DA9_PERCUR+(cAliasDA9)->DA9_ROTA})
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo TrPosition()                                                     ³
	//³                                                                        ³
	//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
	//³realizado antes da impressao de cada linha do relatório.                ³
	//³                                                                        ³
	//³ExpO1 : Objeto Report da Secao                                          ³
	//³ExpC2 : Alias da Tabela                                                 ³
	//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
	//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
	//³        cutada.                                                         ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRPosition():New(oReport:Section(1):Section(1):Section(1),"SA1",1,{|| xFilial("SA1")+(cAliasDA7)->DA7_CLIENT+(cAliasDA7)->DA7_LOJA })
	TRPosition():New(oReport:Section(1):Section(1),"DA5",1,{|| xFilial("DA5")+(cAliasDA9)->DA9_PERCUR })
	TRPosition():New(oReport:Section(1):Section(1),"DA6",1,{|| xFilial("DA6")+(cAliasDA9)->DA9_PERCUR+(cAliasDA9)->DA9_ROTA })

	If !lQuery
		//-- Filtrar outros parametros
		oReport:Section(1):section(1):SetLineConditional({|| OMR060Valid(cAliasDA9,cAliasDA7,cAliasDA5,cAliasSA1)  })
		oReport:Section(1):section(1):Section(1):SetLineConditional({|| OMR060Valid(cAliasDA9,cAliasDA7,cAliasDA5,cAliasSA1)  })	
	EndIf

	oReport:Section(2):Disable()
	oReport:Section(2):Section(1):Disable()

	//-- Inicio da impressao do fluxo do relatório
	oReport:Section(1):SetPageBreak(.T.)
	oReport:Section(1):Print()

Else // por Cliente
	oReport:Section(1):Disable()
	#IFDEF TOP
		If	TcSrvType() <> "AS/400"

			lQuery := .T.
			cDbMs  := UPPER(TcGetDb())

			If	cDbMs == "INFORMIX"
				cQuery += ", OUTER "+ RetSqlName("DA7") + " DA7 "
			ElseIf cDbMs == "POSTGRES"
				cQuery += " LEFT OUTER JOIN "+ RetSqlName("DA7") + " DA7 ON (SA1.A1_COD = DA7.DA7_CLIENT AND SA1.A1_LOJA = DA7.DA7_LOJA)" 
			Else
				cQuery += " LEFT JOIN "+ RetSqlName("DA7") + " DA7 ON (SA1.A1_COD = DA7.DA7_CLIENT AND SA1.A1_LOJA = DA7.DA7_LOJA)" 				
			EndIf
			cQuery := "%" + cQuery + "%"

			aCampos:= oReport:Section(2):aCell
			For nX := 1 to Len(aCampos)
				If	aCampos[nX]:lUserEnabled .And. aCampos[nX]:lUserField
					cCpos060  += ","+aCampos[nX]:cName
				EndIf
			Next

			cSelect +="% A1_COD,A1_LOJA,A1_NOME,A1_END,A1_MUN,A1_EST,A1_CEP,DA7_FILIAL,DA7_PERCUR,DA7_ROTA,DA7_CLIENT,DA7_LOJA,DA7_SEQUEN"

			If !Empty(cCpos060)
				cSelect += cCpos060+" %"
			Else
				cSelect += " %"
			EndIf

			oReport:Section(2):BeginQuery()
			BeginSql Alias cAliasSA1
			SELECT %Exp:cSelect%
			FROM %Table:SA1% SA1
			%Exp:cQuery%
			WHERE
			A1_FILIAL = %xFilial:SA1% AND
			A1_COD  >= %Exp:mv_par07% AND
			A1_COD  <= %Exp:mv_par08% AND
			A1_LOJA >= %Exp:mv_par09% AND
			A1_LOJA <= %Exp:mv_par10% AND
			SA1.%Notdel% AND
			DA7.%Notdel%
			ORDER BY A1_COD,A1_LOJA,DA7_PERCUR,DA7_ROTA
			EndSql
			oReport:Section(2):EndQuery()

			//-- Usa Query da Secao Principal nas Secoes Filhas
			oReport:Section(2):Section(1):SetParentQuery()

		Else
	#ENDIF
			dbSelectArea("SA1")
			dbSetOrder(1)
			cIndSA1 := CriaTrab(NIL,.F.)

			cCondicao += 'A1_FILIAL = "'+xFilial("SA1")+'" .And.' 
			cCondicao += 'A1_COD >= "'+mv_par07+'" .And. A1_COD <= "'+mv_par08+'" .And.'
			cCondicao += 'A1_LOJA >= "'+mv_par09+'" .And. A1_LOJA <= "'+mv_par10+'" .And.'
			cCondicao += 'A1_CEP >= "'+mv_par11+'" .And. A1_CEP <= "'+mv_par12+'" '

			oReport:Section(2):SetFilter(cCondicao,(cAliasSA1)->(IndexKey()))

			//-- Relaciona tabela da Secao principal com tabelas das Secoes filhas
			oReport:Section(2):Section(1):SetRelation({|| xFilial("DA7")+(cAliasSA1)->A1_COD+(cAliasSA1)->A1_LOJA}, cAliasDA7 , 2 , .T. )

	#IFDEF TOP
		Endif
	#ENDIF

	//-- Define regra de saida do loop quando utilizado metodo Print
	oReport:Section(2):Section(1):SetParentFilter({|x| (cAliasDA7)->DA7_FILIAL+(cAliasDA7)->DA7_CLIENT+(cAliasDA7)->DA7_LOJA == x},{||xFilial("DA7")+(cAliasSA1)->A1_COD+(cAliasSA1)->A1_LOJA})

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
	TRPosition():New(oReport:Section(2):Section(1),"DA6",1,{|| xFilial("DA6")+(cAliasDA7)->DA7_PERCUR+(cAliasDA7)->DA7_ROTA })
	TRPosition():New(oReport:Section(2):Section(1),"DA5",1,{|| xFilial("DA5")+(cAliasDA7)->DA7_PERCUR})
	TRPosition():New(oReport:Section(2):Section(1),"DA9",2,{|| xFilial("DA9")+(cAliasDA7)->DA7_PERCUR+(cAliasDA7)->DA7_ROTA})
	TRPosition():New(oReport:Section(2):Section(1),"DA8",1,{|| xFilial("DA8")+DA9->DA9_ROTEIR})

	oReport:Section(1):Disable()
	oReport:Section(1):Section(1):Disable()
	oReport:Section(1):Section(1):Section(1):Disable()

	//-- Imprime Cabecalho da Secao Filha no Topo da Pagina
	oReport:Section(2):section(1):SetHeaderPage()

	//-- Inicio da impressao do fluxo do relatório
	oReport:Section(2):Print()
EndIf
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³OMR060Valid³ Autor ³ Marco Bianchi         ³ Data ³04/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida Impressao da linha (apenas p/ CodeBase)             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAOMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function OMR060Valid(cAliasDA9,cAliasDA7,cAliasDA5,cAliasSA1)
Local lRet := .T.
If	((cAliasDA9)->DA9_PERCUR < mv_par03 .OR. (cAliasDA9)->DA9_PERCUR > mv_par04) .OR.;
	((cAliasDA9)->DA9_ROTA   < mv_par05 .OR. (cAliasDA9)->DA9_ROTA   > mv_par06) .OR.;
	((cAliasDA7)->DA7_CLIENT < mv_par07 .OR. (cAliasDA7)->DA7_CLIENT > mv_par08) .OR.;
	((cAliasDA7)->DA7_LOJA   < mv_par09 .OR. (cAliasDA7)->DA7_LOJA   > mv_par10) .OR.;
	((cAliasSA1)->A1_CEP     < mv_par11 .OR. (cAliasSA1)->A1_CEP     > mv_par12) .OR.;
	((cAliasDA5)->DA5_VENDED < mv_par13 .OR. (cAliasDA5)->DA5_VENDED > mv_par14)
	lRet := .F.
EndIf
Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³OMSR060   ³ Autor ³ Henry Fila            ³ Data ³ 20.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de Roteirizacao                                   ³±±
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
User Function OMSR060R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
	Local Titulo  := OemToAnsi(STR0001) //"Roteirizacao"
	Local cDesc1  := OemToAnsi(STR0002) //"Este programa ira emitir a Relacao da Roteirizacao"
	Local cDesc2  := OemToAnsi(STR0003) //"distribuida por Rotas, Zonas, Setores e Clientes por Setor"
	Local cDesc3  := OemToAnsi(STR0004) //"de acordo com os parametros escolhidos pelo usuario."
#ELSE
	Local Titulo  := ""
	Local cDesc1  := ""
	Local cDesc2  := ""
	Local cDesc3  := ""
#ENDIF
Local cString := "DA8"  // Alias utilizado na Filtragem
Local lDic    := .F. // Habilita/Desabilita Dicionario
Local lComp   := .T. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .T. // Habilita/Desabilita o Filtro
Local wnrel   := "OMSR060"  // Nome do Arquivo utilizado no Spool
Local nomeprog:= "OMSR060"  // nome do programa

Private Tamanho := "G" // P/M/G
Private Limite  := 132 // 80/132/220
Private aOrdem  := {OemtoAnsi(STR0007),OemtoAnsi(STR0008)}  // Ordem do Relatorio
Private cPerg   := "OMR060"  // Pergunta do Relatorio
Private aReturn := { OemtoAnsi(STR0005), 1,OemtoAnsi(STR0006), 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
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
#IFDEF WINDOWS
	RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)
#ELSE
	ImpDet(.F.,wnrel,cString,nomeprog,Titulo)
#ENDIF

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Eduardo Riera         ³ Data ³02.07.1998³±±
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
Local aCeps     := {}
Local aStrucDA8 := {}

Local li        := 100 // Contador de Linhas
Local lImp      := .F. // Indica se algo foi impresso
Local lCabOut   := .T.
Local cbCont    := 0   // Numero de Registros Processados
Local cbText    := ""  // Mensagem do Rodape
Local cQuery    := ""
Local cAlias    := ""
Local cAliasDA5 := "DA5"
Local cAliasDA6 := "DA6"
Local cAliasDA7 := "DA7"
Local cAliasDA8 := "DA8"
Local cAliasDA9 := "DA9"
Local cAliasSA1 := "SA1"
Local cName     := ""
Local cQryAd    := ""
Local cIndSA1   := ""
Local cKeySA1   := ""
Local cCondSA1  := ""
Local cDbMs

Local lQuery    := .F.
Local lRot      := .T.
Local lFiltro   := .T.
Local lImpOut   := .T.

Local nIndSA1   := 0
Local nX        := 0

//
//                         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//               01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//               XXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXX XXX XXXXXXXXXX
//               SEQUENCIA	 CEP INICIAL    CEP FINAL    REFERENCIA" 

Local cCabec1 := ""
Local cCabec2 := ""

If	aReturn[8] == 1 // por Roteirizacao
	cCabec1 :=  OemtoAnsi(STR0009) //"ROTA   DESCRICAO                      SEQUENCIA ZONA   DESCRICAO                      SETOR  DESCRICAO"
	cCabec2 :=  ""
	#IFDEF TOP

		If TcSrvType() <> "AS/400"
			lQuery    := .T.
			cAlias    := "QRYROT"
			cAliasDA5 := "QRYROT"
			cAliasDA6 := "QRYROT"
			cAliasDA7 := "QRYROT"
			cAliasDA8 := "QRYROT"
			cAliasDA9 := "QRYROT"
			cAliasSA1 := "QRYROT"

			aStrucDA8 := DA8->(dbStruct())

			cQuery := "SELECT "

			If !Empty(aReturn[7])
				For nX := 1 To DA8->(FCount())
					cName := DA8->(FieldName(nX))
					If AllTrim( cName ) $ aReturn[7]
						If aStrucDA8[nX,2] <> "M"
							If !cName $ cQuery .And. !cName $ cQryAd
								cQryAd += cName +","
							Endif
						EndIf
					EndIf
				Next nX
			Endif

			cQuery += cQryAd
			cQuery += "DA8_COD,DA8_DESC,DA9_FILIAL,DA9_ROTEIR,DA9_SEQUEN,DA9_PERCUR,"
			cQuery += "DA9_ROTA,DA5_COD,DA5_DESC,DA6_ROTA,DA6_REF,DA7_FILIAL,DA7_SEQUEN,"
			cQuery += "DA7_PERCUR,DA7_ROTA,DA7_CLIENT,DA7_LOJA,DA7_CEPDE,DA7_CEPATE,DA7_REF,A1_NOME,A1_END,A1_MUN,A1_EST,A1_CEP FROM "
			cQuery += RetSqlName("DA5") + " DA5 ,"
			cQuery += RetSqlName("DA6") + " DA6 ,"
			cQuery += RetSqlName("DA7") + " DA7 ,"
			cQuery += RetSqlName("DA8") + " DA8 ,"
			cQuery += RetSqlName("DA9") + " DA9 ,"
			cQuery += RetSqlName("SA1") + " SA1 "
			cQuery += "WHERE "
			cQuery += "DA8_FILIAL = '"+xFilial("DA8")+"' AND "
			cQuery += "DA8_COD >= '"+mv_par01+"' AND "
			cQuery += "DA8_COD <= '"+mv_par02+"' AND "
			cQuery += "DA9_FILIAL = '"+xFilial("DA9")+"' AND "
			cQuery += "DA9_PERCUR >= '"+mv_par03+"' AND "
			cQuery += "DA9_PERCUR <= '"+mv_par04+"' AND "
			cQuery += "DA9_ROTA >= '"+mv_par05+"' AND "
			cQuery += "DA9_ROTA <= '"+mv_par06+"' AND "
			cQuery += "DA8_COD = DA9_ROTEIR AND "
			cQuery += "DA8.D_E_L_E_T_ = ' ' AND "
			cQuery += "DA9.D_E_L_E_T_ = ' ' AND "

			cQuery += "DA7_FILIAL = '"+xFilial("DA7")+"' AND "
			cQuery += "DA7_PERCUR = DA9_PERCUR AND "
			cQuery += "DA7_ROTA = DA9_ROTA AND "
			cQuery += "DA7_CLIENT >= '"+mv_par07+"' AND "
			cQuery += "DA7_CLIENT <= '"+mv_par08+"' AND "
			cQuery += "DA7_LOJA >= '"+mv_par09+"' AND "
			cQuery += "DA7_LOJA <= '"+mv_par10+"' AND "
			cQuery += "DA7.D_E_L_E_T_ = ' ' AND "

			cQuery += "A1_FILIAL = '"+xFilial("SA1")+"' AND "
			cQuery += "A1_COD = DA7_CLIENT AND "
			cQuery += "A1_LOJA = DA7_LOJA AND "
			cQuery += "A1_CEP >= '"+mv_par11+"' AND "
			cQuery += "A1_CEP <= '"+mv_par12+"' AND "
			cQuery += "SA1.D_E_L_E_T_ = ' ' AND "

			cQuery += "DA6_FILIAL = '"+xFilial("DA6")+"' AND "
			cQuery += "DA6_PERCUR = DA9_PERCUR AND "
			cQuery += "DA6_ROTA = DA9_ROTA AND "
			cQuery += "DA6.D_E_L_E_T_ = ' ' AND "

			cQuery += "DA5_FILIAL = '"+xFilial("DA5")+"' AND "
			cQuery += "DA5_COD = DA9_PERCUR AND "
			cQuery += "DA5_VENDED >= '"+mv_par13+"' AND "
			cQuery += "DA5_VENDED <= '"+mv_par14+"' AND "
			cQuery += "DA5.D_E_L_E_T_ = ' ' "
			cQuery += "UNION "
			cQuery += "SELECT "

			If !Empty(aReturn[7])
				For nX := 1 To DA8->(FCount())
					cName := DA8->(FieldName(nX))
					If AllTrim( cName ) $ aReturn[7]
						If aStrucDA8[nX,2] <> "M"
							If !cName $ cQuery .And. !cName $ cQryAd
								cQryAd += cName +","
							Endif
						EndIf
					EndIf
				Next nX
			Endif

			cQuery += cQryAd
			cQuery += "DA8_COD,DA8_DESC,DA9_FILIAL,DA9_ROTEIR,DA9_SEQUEN,DA9_PERCUR,"
			cQuery += "DA9_ROTA,DA5_COD,DA5_DESC,DA6_ROTA,DA6_REF,DA7_FILIAL,DA7_SEQUEN,"
			cQuery += "DA7_PERCUR,DA7_ROTA,DA7_CLIENT,DA7_LOJA,DA7_CEPDE,DA7_CEPATE,DA7_REF,' ' A1_NOME,' ' A1_END,' ' A1_MUN,' ' A1_EST,' ' A1_CEP FROM "
			cQuery += RetSqlName("DA5") + " DA5 ,"
			cQuery += RetSqlName("DA6") + " DA6 ,"
			cQuery += RetSqlName("DA7") + " DA7 ,"
			cQuery += RetSqlName("DA8") + " DA8 ,"
			cQuery += RetSqlName("DA9") + " DA9 ,"
			cQuery += RetSqlName("SA1") + " SA1 "
			cQuery += "WHERE "
			cQuery += "DA8_FILIAL = '"+xFilial("DA8")+"' AND "
			cQuery += "DA8_COD >= '"+mv_par01+"' AND "
			cQuery += "DA8_COD <= '"+mv_par02+"' AND "
			cQuery += "DA9_FILIAL = '"+xFilial("DA9")+"' AND "
			cQuery += "DA9_PERCUR >= '"+mv_par03+"' AND "
			cQuery += "DA9_PERCUR <= '"+mv_par04+"' AND "
			cQuery += "DA9_ROTA >= '"+mv_par05+"' AND "
			cQuery += "DA9_ROTA <= '"+mv_par06+"' AND "
			cQuery += "DA8_COD = DA9_ROTEIR AND "
			cQuery += "DA8.D_E_L_E_T_ = ' ' AND "
			cQuery += "DA9.D_E_L_E_T_ = ' ' AND "

			cQuery += "DA7_FILIAL = '"+xFilial("DA7")+"' AND "
			cQuery += "DA7_PERCUR = DA9_PERCUR AND "
			cQuery += "DA7_ROTA = DA9_ROTA AND "
			cQuery += "DA7_CLIENT >= '"+mv_par07+"' AND "
			cQuery += "DA7_CLIENT <= '"+mv_par08+"' AND "
			cQuery += "DA7_LOJA >= '"+mv_par09+"' AND "
			cQuery += "DA7_LOJA <= '"+mv_par10+"' AND "
			cQuery += "DA7.D_E_L_E_T_ = ' ' AND "

			cQuery += "NOT EXISTS ( SELECT A1_COD, A1_LOJA FROM  "+RetSqlName( "SA1" )+" SA1 "
			cQuery += "WHERE A1_FILIAL = '"+xFilial("SA1")+"' AND "
			cQuery += "A1_COD = DA7_CLIENT AND "
			cQuery += "A1_LOJA = DA7_LOJA AND "
			cQuery += "A1_CEP >= '"+mv_par11+"' AND "
			cQuery += "A1_CEP <= '"+mv_par12+"' AND "
			cQuery += "SA1.D_E_L_E_T_ = ' ') AND "

			cQuery += "DA6_FILIAL = '"+xFilial("DA6")+"' AND "
			cQuery += "DA6_PERCUR = DA9_PERCUR AND "
			cQuery += "DA6_ROTA = DA9_ROTA AND "
			cQuery += "DA6.D_E_L_E_T_ = ' ' AND "

			cQuery += "DA5_FILIAL = '"+xFilial("DA5")+"' AND "
			cQuery += "DA5_COD = DA9_PERCUR AND "
			cQuery += "DA5_VENDED >= '"+mv_par13+"' AND "
			cQuery += "DA5_VENDED <= '"+mv_par14+"' AND "
			cQuery += "DA5.D_E_L_E_T_ = ' ' "

			cQuery += "ORDER BY DA8_COD,DA9_SEQUEN,DA9_PERCUR,DA9_ROTA,DA7_SEQUEN,DA7_CLIENT,DA7_LOJA"

			cQuery := ChangeQuery(cQuery)
			dBUseArea(.t.,"TOPCONN",TCGENQRY(,,cQuery),cAlias,.f.,.t.)

			bWhile := {|| (cAliasDA5)->(!Eof())}
		Else
	#ENDIF

			dbSelectArea(cAliasDA8)
			dbSetOrder(1)
			MsSeek(xFilial("DA8")+mv_par01,.T.)

			bWhile := {|| (cAliasDA8)->(!Eof()) .And. (cAliasDA8)->DA8_COD <= mv_par02 }

	#IFDEF TOP
		Endif
	#ENDIF

	While Eval(bWhile)

		lImp    := .T.
		lSkip   := .F.
		lRot    := .T.
		lImpOut := .T.
		#IFNDEF WINDOWS
			If LastKey() = 286
				lEnd := .T.
			EndIf
		#ENDIF
		If lEnd
			@ Prow()+1,001 PSAY STR0007 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf

		If !Empty(aReturn[7])
			lFiltro := Iif(&(aReturn[7]),.T.,.F.)
		Endif

		If lFiltro

			If ( li > 58 )
				li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
				li++
			Endif

			lCabOut := .T.

			If !lQuery
				dbSelectArea("DA9")
				dbSetOrder(1)
				MsSeek(xFilial("DA9")+(cAliasDA8)->DA8_COD)
			Endif

			cRota := (cAliasDA8)->DA8_COD

			While (cAliasDA9)->(!Eof() .And. DA9_FILIAL+DA9_ROTEIR == xFilial("DA8")+cRota)

				aCeps   := {}
				lImpOut := .T.

				If !lQuery
					dbSelectArea(cAliasDA5)
					dbSetOrder(1)
					MsSeek(xFilial("DA5")+(cAliasDA9)->DA9_PERCUR)

					If (cAliasDA5)->DA5_VENDED < mv_par13 .Or. (cAliasDA5)->DA5_VENDED > mv_par14
						lImpOut := .F.
					Endif

				Endif

				If !lQuery
					dbSelectArea(cAliasDA6)
					dbSetOrder(1)
					MsSeek(xFilial("DA6")+(cAliasDA9)->DA9_PERCUR+(cAliasDA9)->DA9_ROTA)
				Endif

				If lImpOut

					If lCabOut
						@ li,000 PSAY (cAliasDA8)->DA8_COD
						@ li,007 PSAY (cAliasDA8)->DA8_DESC
						li++
						lCabOut := .F.
					Endif

					@ li,000 PSAY __PrtThinLine()
					li++
					@ li,000 PSAY OemtoAnsi(STR0016)
					@ li,038 PSAY (cAliasDA9)->DA9_SEQUEN
					@ li,048 PSAY (cAliasDA9)->DA9_PERCUR
					@ li,055 PSAY (cAliasDA5)->DA5_DESC
					@ li,086 PSAY (cAliasDA9)->DA9_ROTA
					@ li,093 PSAY (cAliasDA6)->DA6_REF

					li++
					@ li,000 PSAY __PrtThinLine()
					li++

					If !lQuery
						dbSelectArea(cAliasDA7)
						dbSetOrder(1)
						MsSeek(xFilial("DA7")+(cAliasDA9)->DA9_PERCUR+(cAliasDA9)->DA9_ROTA)
					Endif

					cZonaSetor := (cAliasDA9)->DA9_PERCUR+(cAliasDA9)->DA9_ROTA
					li++
					@ li,000 PSAY OemtoAnsi(STR0010) //"SEQUENCIA CLIENTE LOJA  NOME                                     ENDERECO                                 CIDADE          ESTADO  CEP       REFERENCIA"
					li++
					@ li,000 PSAY __PrtThinLine()
					li++

					While (cAliasDA7)->(!Eof()) .And. (cAliasDA7)->DA7_FILIAL == xFilial("DA7") .And. ;
									        			(cAliasDA7)->DA7_PERCUR+(cAliasDA7)->DA7_ROTA == cZonaSetor

						If lEnd
							@ Prow()+1,001 PSAY STR0007 //"CANCELADO PELO OPERADOR"
							Exit
						EndIf
						If ( li > 58 )
							li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
							li++
						Endif

						If !lQuery
							dbSelectArea(cAliasSA1)
							dbSetOrder(1)
							MsSeek(xFilial("SA1")+(cAliasDA7)->DA7_CLIENT+(cAliasDA7)->DA7_LOJA )
						Endif

						If (cAliasSA1)->A1_CEP >= mv_par11 .And. (cAliasSA1)->A1_CEP <= mv_par12 .And.;
							!Empty((cAliasDA7)->DA7_CLIENT) .And. !Empty((cAliasDA7)->DA7_LOJA)

							@ li,000 PSAY (cAliasDA7)->DA7_SEQUEN
							@ li,010 PSAY (cAliasDA7)->DA7_CLIENT
							@ li,018 PSAY (cAliasDA7)->DA7_LOJA
							@ li,024 PSAY (cAliasSA1)->A1_NOME
							@ li,065 PSAY (cAliasSA1)->A1_END
							@ li,106 PSAY (cAliasSA1)->A1_MUN
							@ li,122 PSAY (cAliasSA1)->A1_EST
							@ li,130 PSAY (cAliasSA1)->A1_CEP PICTURE PesqPict("SA1","A1_CEP")
							@ li,140 PSAY (cAliasDA7)->DA7_REF
							li++
						Else
							Aadd(aCeps,{(cAliasDA7)->DA7_SEQUEN,(cAliasDA7)->DA7_CEPDE,(cAliasDA7)->DA7_CEPATE,(cAliasDA7)->DA7_REF})
						Endif

						dbSelectArea(cAliasDA7)
						dbSkip()
						lSkip := .T.

					Enddo

					If Len(aCeps) > 0

						li++
						@ li,000 PSAY OemtoAnsi(STR0015) //"SEQUENCIA	 CEP INICIAL    CEP FINAL    REFERENCIA"
						li++
						@ li,000 PSAY __PrtThinLine()
						li++

						For nX := 1 to Len(aCeps)
							@ li,000 PSAY aCeps[nX][1]
							@ li,012 PSAY aCeps[nX][2] PICTURE PesqPict("DA7","DA7_CEPDE")
							@ li,027 PSAY aCeps[nX][3] PICTURE PesqPict("DA7","DA7_CEPATE")
							@ li,040 PSAY aCeps[nX][4] PICTURE PesqPict("DA7","DA7_REF")
							li++
						Next

					Endif

					li++

				Endif

				If !lQuery .Or. !lSkip
					dbSelectArea(cAliasDA9)
					dbSkip()
				Endif

			Enddo

			If !lCabOut
				li := 60
			Endif

		Endif

		If !lQuery .Or. !lSkip
			dbSelectArea(cAliasDA8)
			dbSkip()
		Endif

	Enddo

	If lQuery
		dbSelectArea(cAliasDA5)
		dbCloseArea()
		dbSelectArea("DA5")
	Endif

Else // por Cliente

//                          1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//               01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//               XXXXXX  XX     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XX     XXXXXXXXX     
                
	cCabec1 :=  OemtoAnsi(STR0011) //"CLIENTE LOJA   NOME                                     ENDERECO                                 CIDADE          ESTADO CEP"
	cCabec2 :=  ""
	#IFDEF TOP
		If TcSrvType() <> "AS/400"

			cDbMs	 := UPPER(TcGetDb())
			lQuery    := .T.
			cAlias    := "QRYROT"
			cAliasSA1 := "QRYROT"
			cAliasDA7 := "QRYROT"

			cQuery := "SELECT A1_COD,A1_LOJA,A1_NOME,A1_END,A1_MUN,A1_EST,A1_CEP,DA7_PERCUR,DA7_ROTA,DA7_CLIENT,DA7_LOJA,DA7_SEQUEN "
			cQuery += "FROM "
			cQuery += RetSqlName("SA1")+ " SA1 "

			If cDbMs == "INFORMIX"
				cQuery += ", OUTER "+ RetSqlName("DA7") + " DA7 "
			ElseIf cDbMs == "POSTGRES"
				cQuery += " LEFT OUTER JOIN "+ RetSqlName("DA7") + " DA7 ON (SA1.A1_COD = DA7.DA7_CLIENT AND SA1.A1_LOJA = DA7.DA7_LOJA)"
			Else
				cQuery += " LEFT JOIN "+ RetSqlName("DA7") + " DA7 ON (SA1.A1_COD = DA7.DA7_CLIENT AND SA1.A1_LOJA = DA7.DA7_LOJA)"
			Endif

			cQuery += " WHERE "

			cQuery += "A1_FILIAL = '"+xFilial("SA1")+"' AND "
			cQuery += "A1_COD >= '"+mv_par07+"' AND "
			cQuery += "A1_COD <= '"+mv_par08+"' AND "
			cQuery += "A1_LOJA >= '"+mv_par09+"' AND "
			cQuery += "A1_LOJA <= '"+mv_par10+"' AND "

			cQuery += "SA1.D_E_L_E_T_ = ' ' AND "
			cQuery += "DA7.D_E_L_E_T_ = ' ' "

			cQuery += "ORDER BY A1_COD,A1_LOJA,DA7_PERCUR,DA7_ROTA"

			cQuery := ChangeQuery(cQuery)
			dBUseArea(.t.,"TOPCONN",TCGENQRY(,,cQuery),cAlias,.f.,.t.)

			bWhile := {|| (cAliasSA1)->(!Eof())}
		Else
	#ENDIF

			dbSelectArea("SA1")
			dbSetOrder(1)
			cIndSA1 := CriaTrab(NIL,.F.)

			cKeySA1  := IndexKey()
			cCondSA1 += 'A1_FILIAL = "'+xFilial("SA1")+'" .And.'
			cCondSA1 += 'A1_COD >= "'+mv_par07+'" .And. A1_COD <= "'+mv_par08+'" .And.'
			cCondSA1 += 'A1_LOJA >= "'+mv_par09+'" .And. A1_LOJA <= "'+mv_par10+'" .And.'
			cCondSA1 += 'A1_CEP >= "'+mv_par11+'" .And. A1_CEP <= "'+mv_par12+'" '
			IndRegua("SA1",cIndSA1,cKeySA1,,cCondSA1) //"Selecionando Registros ..."
			nIndSA1 := RetIndex("SA1")
			#IFNDEF TOP
				dbSetIndex(cIndSA1+OrdBagExT())
			#ENDIF
			dbSetOrder(nIndSA1+1)
			dbGotop()

			bWhile := {|| (cAliasSA1)->(!Eof())}

	#IFDEF TOP
		Endif
	#ENDIF

	While Eval(bWhile)

		lImp    := .T.
		lSkip   := .F.
		lCabOut := .T.
		lImpOut := .T.

		lRot := .t.


		#IFNDEF WINDOWS
			If LastKey() = 286
				lEnd := .T.
			EndIf
		#ENDIF
		If lEnd
			@ Prow()+1,001 PSAY STR0007 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		If ( li > 58 )
			li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
			li++
		Endif


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica se o cliente possui rotierizacao            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If lQuery
			If Empty((cAliasDA7)->DA7_PERCUR) .And. Empty((cAliasSA1)->DA7_ROTA)

				@ li,000 PSAY (cAliasSA1)->A1_COD
				@ li,008 PSAY (cAliasSA1)->A1_LOJA
				@ li,015 PSAY (cAliasSA1)->A1_NOME
				@ li,056 PSAY (cAliasSA1)->A1_END
				@ li,097 PSAY (cAliasSA1)->A1_MUN
				@ li,113 PSAY (cAliasSA1)->A1_EST
				@ li,120 PSAY (cAliasSA1)->A1_CEP
				li++
				@ li,000 PSAY __PrtThinLine()
				li++

				@ li,000 PSAY OemtoAnsi(STR0012) //"CLIENTE SEM ROTEIRIZACAO - NAO CADASTRADO EM NENHUMA ZONA / SETOR"
				li++
				@ li,000 PSAY __PrtThinLine()
				li++
				lRot := .F.
			Endif
		Else
			dbSelectArea(cAliasDA7)
			dbSetOrder(2)
			If !MsSeek(xFilial("DA7")+(cAliasSA1)->A1_COD+(cAliasSA1)->A1_LOJA)

				@ li,000 PSAY (cAliasSA1)->A1_COD
				@ li,008 PSAY (cAliasSA1)->A1_LOJA
				@ li,015 PSAY (cAliasSA1)->A1_NOME
				@ li,056 PSAY (cAliasSA1)->A1_END
				@ li,097 PSAY (cAliasSA1)->A1_MUN
				@ li,113 PSAY (cAliasSA1)->A1_EST
				@ li,120 PSAY (cAliasSA1)->A1_CEP
				li++
				@ li,000 PSAY __PrtThinLine()
				li++
				@ li,000 PSAY OemtoAnsi(STR0012) //"CLIENTE SEM ROTEIRIZACAO - NAO CADASTRADO EM NENHUMA ZONA / SETOR"
				li++
				@ li,000 PSAY __PrtThinLine()
				li++
				lRot := .F.
			Endif
		Endif

		If lRot

			cClienteLoja := (cAliasSA1)->A1_COD+(cAliasSA1)->A1_LOJA

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Imprime cabecalho de zonas e setores                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//                       1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
			//             01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
			//             XXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   XXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX       


			While (cAliasDA7)->(!Eof()) .And. (cAliasDA7)->DA7_CLIENT+(cAliasDA7)->DA7_LOJA == cClienteLoja

				If ( li > 58 )
					li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
					li++
				Endif

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Busca descricao da zona                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea(cAliasDA5)
				dbSetOrder(1)
				MsSeek(xFilial("DA5")+(cAliasDA7)->DA7_PERCUR)

				If (cAliasDA5)->DA5_VENDED < mv_par13 .Or. (cAliasDA5)->DA5_VENDED > mv_par14
					lImpOut := .F.
				Endif

				If lImpOut

					If lCabOut
						@ li,000 PSAY (cAliasSA1)->A1_COD
						@ li,008 PSAY (cAliasSA1)->A1_LOJA
						@ li,015 PSAY (cAliasSA1)->A1_NOME
						@ li,056 PSAY (cAliasSA1)->A1_END
						@ li,097 PSAY (cAliasSA1)->A1_MUN
						@ li,113 PSAY (cAliasSA1)->A1_EST
						@ li,120 PSAY (cAliasSA1)->A1_CEP
						li++
						@ li,000 PSAY __PrtThinLine()
						li++
						@ li,000 PSAY OemtoAnsi(STR0013) //"ZONA   DESCRICAO                        SETOR  DESCRICAO                                SEQUENCIA   ROTA   DESCRICAO                      SEQUENCIA"
						li++
						@ li,000 PSAY __PrtThinLine()
						li++
						lCabOut := .F.
					Endif


					dbSelectArea(cAliasDA6)
					dbSetOrder(1)
					MsSeek(xFilial("DA5")+(cAliasDA7)->DA7_PERCUR+(cAliasDA7)->DA7_ROTA)

					@ li,000 PSAY (cAliasDA7)->DA7_PERCUR
					@ li,007 PSAY (cAliasDA5)->DA5_DESC	
					@ li,040 PSAY (cAliasDA7)->DA7_ROTA
					@ li,047 PSAY (cAliasDA6)->DA6_REF
					@ li,088 PSAY (cAliasDA7)->DA7_SEQUEN


					dbSelectArea(cAliasDA9)
					dbSetOrder(2)
					If MsSeek(xFilial("DA9")+(cAliasDA7)->DA7_PERCUR+(cAliasDA7)->DA7_ROTA)

						While (cAliasDA9)->(!Eof()) .And. (cAliasDA9)->DA9_FILIAL == xFilial("DA9") .And. ;
														(cAliasDA9)->DA9_PERCUR == (cAliasDA7)->DA7_PERCUR .And. ;
														(cAliasDA9)->DA9_ROTA == (cAliasDA7)->DA7_ROTA

							If ( li > 58 )
								li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
								li++
							Endif

							dbSelectArea(cAliasDA8)
							dbSetOrder(1)
							MsSeek(xFilial("DA8")+(cAliasDA9)->DA9_ROTEIR)

								@ li,100 PSAY (cAliasDA9)->DA9_ROTEIR
								@ li,107 PSAY (cAliasDA8)->DA8_DESC
								@ li,139 PSAY (cAliasDA9)->DA9_SEQUEN
								li++
							dbSelectArea(cAliasDA9)
							dbSkip()

						Enddo
					Else
						@ li,100 PSAY OemtoAnsi(STR0014) //"ZONA E SETOR NAO CADASTRADO EM NENHUMA ROTA"
						li++
					Endif


					@ li,000 PSAY __PrtThinLine()
					li++

				Endif

				dbSelectArea(cAliasDA7)
				dbSkip()
				lSkip:=.T.

			Enddo

		Endif

		If !lQuery .Or.!lSkip .Or. !lRot
			dbSelectArea(cAliasSA1)
			dbSkip()
		Endif

		If !lCabOut
			li += 2
		Endif

	Enddo

	If !lQuery
		dbSelectArea("SA1")
		Ferase(cIndSA1+OrdBagExt())
		RetIndex("SA1")
	Else
		dbSelectArea(cAliasSA1)
		dbCloseArea()
		dbSelectArea("DA5")
	Endif

Endif


If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf

Set Device To Screen
Set Printer To
If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()
Return(.T.)
