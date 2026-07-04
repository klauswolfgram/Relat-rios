/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR690.CH" 
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR690  ³ Autor ³ Marco Bianchi         ³ Data ³ 06/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Disponibilidade de Estoque para Vendas                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT - R4                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR690()

Local oReport
 
Private nQAtu 		:= 0
Private nQEmp 		:= 0
Private nPed 		:= 0
Private nBlo 		:= 0
Private nRes 		:= 0
Private oTempTable 	:= Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR690",.F.)

//-- Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()


Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 06/07/06 ³±±
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
Local oDispEst
Local oTemp
Local oTemp2
Local oTemp3
Local oTotUM

Local cAliasSB1 := GetNextAlias()
Local cAliasSB2 := GetNextAlias()
Local cAliasSC6 := GetNextAlias()
Local cAliasSC9 := GetNextAlias()
Local cPicture	:= ""
Local nTamPict	:= 0

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
oReport := TReport():New("MATR690",STR0018,"MTR690", {|oReport| ReportPrint(oReport,oDispEst,oTemp,oTotUM,oTemp2,oTemp3,cAliasSB1,cAliasSB2,cAliasSC6,cAliasSC9)},STR0019 + " " + STR0020)
oReport:SetPortrait()
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
//³ Secao Principal                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oDispEst := TRSection():New(oReport,STR0038,{"SB1","TRB"},{STR0028,STR0029,STR0030,STR0031},/*Campos do SX3*/,/*Campos do SIX*/)	// "Disponibilidade de Estoque para Vendas"###"Por Codigo"###"Por Tipo"###"Por Descricao"###"Por Armazem"
oDispEst:SetLineBreak( .T. ) 
oDispEst:SetTotalInLine(.F.)
cPicture := FatGetPicN("B2_QATU")
nTamPict := Len(cPicture)
TRCell():New(oDispEst,"B1_COD"	,/*Tabela*/,RetTitle("B1_COD")	,PesqPict("SB1","B1_COD"		),TamSX3("B1_COD"		)[1],/*lPixel*/,{|| (cAliasSB1)->B1_COD 			})	// Codigo do Produto
TRCell():New(oDispEst,"B1_DESC"	,/*Tabela*/,RetTitle("B1_DESC")	,PesqPict("SB1","B1_DESC"		),TamSX3("B1_DESC"		)[1],/*lPixel*/,{|| (cAliasSB1)->B1_DESC			})	// Descricao do Produto
TRCell():New(oDispEst,"B1_UM"	,/*Tabela*/,STR0021				,PesqPict("SB1","B1_UM"			),TamSX3("B1_UM"		)[1],/*lPixel*/,{|| (cAliasSB1)->B1_UM				})	// "UM"
TRCell():New(oDispEst,"NQATU"	,/*Tabela*/,STR0022				,cPicture	      				 ,nTamPict					,/*lPixel*/,{|| nQAtu 							})	// "Saldo em Estoque"
TRCell():New(oDispEst,"NQEMP"	,/*Tabela*/,STR0023				,PesqPict("SB2","B2_QEMP"		),TamSX3("B2_QEMP"		)[1],/*lPixel*/,{|| nQEmp 							})	// "Saldo Empenhado"
TRCell():New(oDispEst,"NPED"	,/*Tabela*/,STR0024				,PesqPict("SC6","C6_QTDVEN"		),TamSX3("C6_QTDVEN"	)[1],/*lPixel*/,{|| nPed 							})	// "Pedidos Pendentes"
TRCell():New(oDispEst,"NBLO"	,/*Tabela*/,STR0025				,PesqPict("SC6","C6_QTDVEN"		),TamSX3("C6_QTDVEN"	)[1],/*lPixel*/,{|| nBlo 							})	// "Pedidos Bloqueados"
TRCell():New(oDispEst,"NRES"	,/*Tabela*/,STR0026				,PesqPict("SB2","B2_RESERVA"	),TamSX3("B2_RESERVA"	)[1],/*lPixel*/,{|| nRes 							})	// "Reserva"
TRCell():New(oDispEst,"NDISP"	,/*Tabela*/,STR0027				,cPicture	                     ,nTamPict	                ,/*lPixel*/,{|| nQatu-nRes-nPed-nBlo-nQEmp  	})	// "Disponivel p/ Venda"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Esta Secao serve apenas para receber as Querys do SB2, SC6 e SC9       ³
//³ que nao sao as tabelas da Section Principal. A tabela para impressao   ³
//³ e a SB1. Se deixamos o filtro de SB1,SB2,SC6 e SC9 na section principal³
//³ no momento do filtro do SB2 o sistema fecha o filtro do SB1 nao        ³
//³ reconhecendo o alias.											                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTemp := TRSection():New(oReport,STR0039,{"SB2","TRB"},{STR0028,STR0029,STR0030,STR0031},/*Campos do SX3*/,/*Campos do SIX*/) // "Disponibilidade de Estoque para Vendas"###"Por Codigo"###"Por Tipo"###"Por Descricao"###"Por Armazem"
oTemp:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores por Unidade de Medida no final do Relatorio              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTotUM := TRSection():New(oReport,STR0036,{"SB1","SB2","SC6","SF4","SC9","TRB"},{STR0028,STR0029,STR0030,STR0031},/*Campos do SX3*/,/*Campos do SIX*/)	// "Disponibilidade de Estoque para Vendas"###"Por Codigo"###"Por Tipo"###"Por Descricao"###"Por Armazem"
oTotUM:SetLineBreak(.T.)  
oTotUM:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Esta Secao serve apenas para receber a Query do SB2                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTemp2 := TRSection():New(oReport,STR0040,{"SC6","SF4"},{STR0028,STR0029,STR0030,STR0031},/*Campos do SX3*/,/*Campos do SIX*/) // "Disponibilidade de Estoque para Vendas"###"Por Codigo"###"Por Tipo"###"Por Descricao"###"Por Armazem"
oTemp2:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Esta Secao serve apenas para receber a Query do SC9                    ³
//³ Como na Query do SC9 e referenciado o Alias da Query do SC6, devemos 	³
//³ gerar estas querys em secoes diferentes.											³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTemp3 := TRSection():New(oReport,STR0041,{"SC9"},{STR0028,STR0029,STR0030,STR0031},/*Campos do SX3*/,/*Campos do SIX*/) // "Disponibilidade de Estoque para Vendas"###"Por Codigo"###"Por Tipo"###"Por Descricao"###"Por Armazem"
oTemp3:SetTotalInLine(.F.)

oReport:Section(2):SetEdit(.F.)
oReport:Section(3):SetEdit(.F.)
oReport:Section(4):SetEdit(.F.)
oReport:Section(5):SetEdit(.F.)

oReport:Section(2):SetEditCell(.F.)
oReport:Section(4):SetEditCell(.F.)
oReport:Section(5):SetEditCell(.F.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³06/07/2006³±±
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
Static Function ReportPrint(oReport,oDispEst,oTemp,oTotUM,oTemp2,oTemp3,cAliasSB1,cAliasSB2,cAliasSC6,cAliasSC9)

Local lTotSec 		:= IIF(oReport:Section(1):GetOrder() == 2 .Or. oReport:Section(1):GetOrder() == 4,.T.,.F.)	// Imprime Sub-Total apenas se ordenado por Tipo ou Armazem
Local cFilSB1		:= xFilial("SB1")
Local cFilSB2		:= xFilial("SB2")
Local cFilSF4		:= xFilial("SF4")
Local cFilSC6		:= xFilial("SC6")
Local cFilSC9		:= xFilial("SC9")
Local cKey    		:= ""
Local lArqProd  	:=SuperGetMV("MV_ARQPROD",.F.,"SB1") == "SBZ"
Local lOk			:= .F.
Local cVar      	:= ""
Local cAnt      	:= ""
Local cCond     	:= ".T."
Local cPicture		:= ""
Local nTamPict		:= 0
Local nX        	:= 0
Local aTotUM    	:= {}
Local aStruSB1		:= {}
Local cFieldsQry	:= ""

oReport:Section(1):Cell("NQATU" ):SetBlock({|| nQAtu })
oReport:Section(1):Cell("NQEMP" ):SetBlock({|| nQEmp })
oReport:Section(1):Cell("NPED"	 ):SetBlock({|| nPed })
oReport:Section(1):Cell("NBLO" ):SetBlock({|| nBlo })
oReport:Section(1):Cell("NRES" ):SetBlock({|| nRes })
nQAtu	:= 0
nQEmp	:= 0
nPed	:= 0
nBlo	:= 0
nRes	:= 0
cPicture := FatGetPicN("B2_QATU")
nTamPict := Len(cPicture)

TRFunction():New(oDispEst:Cell("B1_COD"	),/* cID */,"ONPRINT",/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| Space(TamSX3("B1_COD")[1])}/*uFormula*/,lTotSec/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDispEst:Cell("NQATU"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,lTotSec/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDispEst:Cell("NQEMP"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,lTotSec/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDispEst:Cell("NPED"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,lTotSec/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDispEst:Cell("NBLO"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,lTotSec/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDispEst:Cell("NRES"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,lTotSec/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDispEst:Cell("NDISP"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,lTotSec/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores por Unidade de Medida no final do Relatorio              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oTotUM,"B1_COD"	,/*Tabela*/,RetTitle("B1_COD")	,PesqPict("SB1","B1_COD"		),TamSX3("B1_COD"		)[1],/*lPixel*/,/*{|| code-block de impressao	}*/ 								 	 )	// Codigo do Produto
TRCell():New(oTotUM,"B1_DESC"	,/*Tabela*/,RetTitle("B1_DESC")	,PesqPict("SB1","B1_DESC"		),TamSX3("B1_DESC"		)[1],/*lPixel*/,/*{|| code-block de impressao	}*/  								 	 )	// Descricao do Produto
TRCell():New(oTotUM,"B1_UM"		,/*Tabela*/,STR0021				,PesqPict("SB1","B1_UM"			),TamSX3("B1_UM"		)[1],/*lPixel*/,{|| aTotUM[nX,1]														})	// "UM"
TRCell():New(oTotUM,"NQATU"		,/*Tabela*/,STR0022				,cPicture						 ,nTamPict					,/*lPixel*/,{|| aTotUM[nX,2] 														})	// "Saldo em Estoque"
TRCell():New(oTotUM,"NQEMP"		,/*Tabela*/,STR0023				,PesqPict("SB2","B2_QEMP"		),TamSX3("B2_QEMP"		)[1],/*lPixel*/,{|| aTotUM[nX,3] 														})	// "Saldo Empenhado"
TRCell():New(oTotUM,"NPED"		,/*Tabela*/,STR0024				,PesqPict("SC6","C6_QTDVEN"		),TamSX3("C6_QTDVEN"	)[1],/*lPixel*/,{|| aTotUM[nX,4] 														})	// "Pedidos Pendentes"
TRCell():New(oTotUM,"NBLO"		,/*Tabela*/,STR0025				,PesqPict("SC6","C6_QTDVEN"		),TamSX3("C6_QTDVEN"	)[1],/*lPixel*/,{|| aTotUM[nX,5] 														})	// "Pedidos Bloqueados"
TRCell():New(oTotUM,"NRES"		,/*Tabela*/,STR0026				,PesqPict("SB2","B2_RESERVA"	),TamSX3("B2_RESERVA"	)[1],/*lPixel*/,{|| aTotUM[nX,6] 												  		})	// "Reserva"
TRCell():New(oTotUM,"NDISP"		,/*Tabela*/,STR0027				,cPicture						 ,nTamPict					,/*lPixel*/,{|| aTotUM[nX,2]-aTotUM[nX,3]-aTotUM[nX,4]-aTotUM[nX,5]-aTotUM[nX,6]	})	// "Disponivel p/ Venda"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nao Imprime o cabecalho da Secao 3                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(3):SetHeaderSection(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera o Titulo do Relatorio de acordo com parametros	 	           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " (" +	IIF(oReport:Section(1):GetOrder() == 1,STR0028,	;		// "Disponibilidade de Estoque para Vendas"###"Por Codigo"
								  	IIF(oReport:Section(1):GetOrder()==2,STR0029,;				// "Por Tipo"
								   	IIF(oReport:Section(1):GetOrder()==3,STR0030,STR0031)));	// "Por Descricao"###"Por Armazem"
								   	+ ")")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Cabecalho no top da pagina                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):SetHeaderPage()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SB1")

If oReport:Section(1):GetOrder() == 2
	cKey := "%B1_FILIAL,B1_TIPO,B1_COD%"
ElseIf oReport:Section(1):GetOrder() == 3
	cKey := "%B1_FILIAL,B1_DESC,B1_COD%"
ElseIf oReport:Section(1):GetOrder() == 4
	cKey := "%B1_FILIAL,B1_LOCPAD,B1_COD%"
	lOk := lArqProd
Else
	cKey := "%B1_FILIAL,B1_COD%"
EndIf

aStruSB1 := FWSX3Util():GetListFieldsStruct( "SB1" )
For nX := 1 to Len(aStruSB1)
	If  aStruSB1[ nX, 02 ] == "M"
		Loop
	EndIf
	cFieldsQry	+= IIf( !Empty( cFieldsQry ), ",", "" ) + AllTrim( aStruSB1[ nX, 01 ] )
Next nX

cFieldsQry := "%" + cFieldsQry + "%"

oReport:Section(1):BeginQuery()	
BeginSql Alias cAliasSB1
SELECT %Exp:cFieldsQry%
FROM %Table:SB1% SB1
WHERE B1_FILIAL = %Exp:cFilSB1% 
	AND B1_COD >= %Exp:mv_par01% AND B1_COD <= %Exp:mv_par02%
	AND B1_TIPO >= %Exp:mv_par05% AND B1_TIPO <= %Exp:mv_par06%
	AND SB1.%notdel%
ORDER BY %Exp:cKey% 
EndSql 
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajuste utilizado para adequar o campo B1_LOCPAD para o novo conceito |
//| de indicadores de Suprimentos (Tabela SBZ).							 |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lOk
	cAliasSB1 := GeraTrab(cAliasSB1)
	dbSelectArea(cAliasSB1)
	dbSeek(xFilial()+mv_par03,.T.)
Endif
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Relatorio                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Init()
dbSelectArea(cAliasSB1)
oReport:SetMeter(RecCount())
While !oReport:Cancel() .And. !(cAliasSB1)->(EOF()) .And. cFilSB1 == (cAliasSB1)->B1_FILIAL .And. &(cCond)
	
	//	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//	³ Valida o produto conforme a mascara         ³
	//	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lRet:=ValidMasc((cAliasSB1)->B1_COD,MV_PAR07)
	If !lRet
		dbSkip()
		Loop
	Endif
	
	If oReport:Section(1):GetOrder() == 2		//Tipo
		cAnt	:= "B1_TIPO"
		cVar  	:= B1_TIPO
	ElseIf oReport:Section(1):GetOrder() == 3	//Descricao
		cAnt	:= ".T."
		cVar	:= .T.
	ElseIf oReport:Section(1):GetOrder() == 4	//Por local
		cAnt	:= "B1_LOCPAD"
		cVar	:= B1_LOCPAD
	Else										//Codigo
		cAnt	:= "B1_COD"
		cVar	:= B1_COD
	EndIf
	
	While !oReport:Cancel() .And. !Eof() .And. cFilSB1 == (cAliasSB1)->B1_FILIAL .and. &(cAnt) == cVar
		
		//	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//	³ Valida o produto conforme a mascara         ³
		//	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lRet:=ValidMasc((cAliasSB1)->B1_COD,MV_PAR07)
		If !lRet
			dbSkip()
			Loop
		Endif
		
		DbSelectArea("SB2")
		DbSetOrder(1)
			
		BeginSql Alias cAliasSB2
		SELECT SUM(SB2.B2_QATU) B2_QATU, SUM(SB2.B2_QEMP) B2_QEMP, SUM(SB2.B2_RESERVA) B2_RESERVA, SUM(SB2.B2_SALPEDI) B2_SALPEDI
		FROM %Table:SB2% SB2
		WHERE B2_FILIAL = %Exp:cFilSB2%
			AND SB2.B2_COD = %Exp:(cAliasSB1)->B1_COD%
			AND B2_LOCAL >= %Exp:mv_par03%
			AND B2_LOCAL <= %Exp:mv_par04%
			AND SB2.%notdel%
		EndSql

		nQatu := 0
		nQEmp := 0
		nRes  := 0
		If (cAliasSB2)->(!EOF())
				nQatu += (cAliasSB2)->B2_QATU + Iif(MV_PAR10 == 1,0,(cAliasSB2)->B2_SALPEDI)
				nQEmp += (cAliasSB2)->B2_QEMP
				nRes  += (cAliasSB2)->B2_RESERVA
			(cAliasSB2)->(dbSkip())
		EndIf
		
		dbSelectArea(cAliasSB2)
		dbCloseArea()
		dbSelectArea("SB2")
					
		dbSelectArea("SC6")
		dbSetOrder(2)

		BeginSql Alias cALiasSC6
		SELECT C6_FILIAL,C6_PRODUTO,C6_QTDVEN,C6_QTDEMP,C6_QTDENT,C6_QTDRESE,C6_BLQ,C6_NUM,C6_ITEM,C6_LOCAL
		FROM %Table:SC6% SC6, %Table:SF4% SF4
		WHERE C6_FILIAL = %Exp:cFilSC6%
			AND C6_PRODUTO = %Exp:(cAliasSB1)->B1_COD%
			AND C6_QTDVEN > C6_QTDENT
			AND SC6.%notdel%
			AND F4_FILIAL = %Exp:cFilSF4%
			AND F4_CODIGO = C6_TES
			AND SF4.F4_ESTOQUE ='S'
			AND SF4.%notdel%
			AND SC6.%notdel%
		ORDER BY C6_FILIAL,C6_PRODUTO,C6_NUM,C6_ITEM
		EndSql
				
		nPed := 0
		nBlo := 0
		While cFilSC6 == (cAliasSC6)->C6_FILIAL .And.;
			(cAliasSB1)->B1_COD = (cAliasSC6)->C6_PRODUTO .And. !(cAliasSC6)->(Eof())
				
			dbSelectArea(cAliasSC6)
				
			If (cAliasSC6)->C6_QTDVEN <= (cAliasSC6)->C6_QTDENT
				dbSkip()
				Loop
			EndIf
				
			If mv_par08 == 2 .And. Alltrim((cAliasSC6)->C6_BLQ) == "S"			// Bloqueado
				dbSkip()
				Loop
			EndIf
				
			If mv_par09 == 2 .And. Alltrim((cAliasSC6)->C6_BLQ) == "R"			// Residuo
				dbSkip()
				Loop
			EndIf
				
			If (cAliasSC6)->C6_LOCAL >= mv_par03 .And. (cAliasSC6)->C6_LOCAL <= mv_par04
				nPed := nPed + ((cAliasSC6)->C6_QTDVEN-(cAliasSC6)->C6_QTDENT-(cAliasSC6)->C6_QTDEMP-(cAliasSC6)->C6_QTDRESE)
					
				dbSelectArea("SC9")
				dbSetOrder(1)

				BeginSql Alias cAliasSC9
				SELECT C9_FILIAL,C9_PEDIDO,C9_ITEM,C9_BLCRED,C9_BLEST,C9_PRODUTO,C9_SEQUEN,C9_QTDLIB,C9_QTDRESE
				FROM %Table:SC9% SC9
				WHERE C9_FILIAL = %Exp:cFilSC9%
					AND C9_PEDIDO = %Exp:(cAliasSC6)->C6_NUM%
					AND C9_ITEM = %Exp:(cAliasSC6)->C6_ITEM%
					AND C9_PRODUTO = %Exp:(cAliasSC6)->C6_PRODUTO%
					AND SC9.%notdel%
				ORDER BY C9_FILIAL,C9_PEDIDO,C9_ITEM,C9_SEQUEN,C9_PRODUTO
				EndSql

				While ( !Eof() .And. (cAliasSC9)->C9_FILIAL == cFilSC9 .And.;
					(cAliasSC9)->C9_PEDIDO == (cAliasSC6)->C6_NUM    .And.;
					(cAliasSC9)->C9_ITEM   == (cAliasSC6)->C6_ITEM )
					If ( ( !Empty((cAliasSC9)->C9_BLCRED) .Or. !Empty((cAliasSC9)->C9_BLEST) ) .And.;
						( (cAliasSC9)->C9_BLCRED != "10" .And. (cAliasSC9)->C9_BLEST != "10" ) ).And.;
						(cAliasSC9)->C9_PRODUTO==(cAliasSC6)->C6_PRODUTO
						nBlo += (cAliasSC9)->C9_QTDLIB-(cAliasSC9)->C9_QTDRESE
					EndIf
					dbSelectArea(cAliasSC9)
					dbSkip()
				EndDo
				dbSelectArea(cAliasSC9)
				dbCloseArea()
				dbSelectArea("SC9")
				
			EndIf
			dbSelectArea(cAliasSC6)
			dbSkip()
		EndDo
		dbSelectArea(cAliasSC6)
		dbCloseArea()
		dbSelectArea("SC6")
			
		If nPed != 0 .OR. nQatu != 0 .Or. nBlo <> 0
			dbSelectArea(cAliasSB1)
			oReport:Section(1):PrintLine()
				
			//-- Armazena Total por unidade de medida
			If ( nPos := Ascan( aTotUM, { |x| x[1] == (cAliasSB1)->B1_UM } ) ) == 0
				Aadd( aTotUM, { (cAliasSB1)->B1_UM, nQatu, nQEmp, nPed, nBlo, nRes } )
			Else
				aTotUM[nPos,2] += nQatu
				aTotUM[nPos,3] += nQEmp
				aTotUM[nPos,4] += nPed
				aTotUM[nPos,5] += nBlo
				aTotUM[nPos,6] += nRes
			EndIf
		EndIf
		
		dbSelectArea(cAliasSB1)
		dbSkip()
		oReport:IncMeter()

	EndDo
	
	If oReport:Section(1):GetOrder() == 2 .Or. oReport:Section(1):GetOrder() == 4
		If oReport:Section(1):GetOrder() == 2
			oReport:Section(1):SetTotalText(STR0033 + " " + cVar)
		Else 
			oReport:Section(1):SetTotalText(STR0034 + " " + cVar)		
		EndIf	   
		
		oReport:Section(1):Finish()
		oReport:Section(1):Init()
	EndIf
	
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza Relatorio                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):SetPageBreak()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Totais por Unidade de Medida                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(aTotUM)
	//-- Ordena por unidade
	aTotUM := aSort( aTotUM,,,{ |x,y| x[1] < y[1] } )
	oReport:Section(3):Init()
	oReport:Section(3):Cell("B1_COD"	):Hide()
	oReport:Section(3):Cell("B1_DESC"	):Hide()
	oReport:SkipLine()
	oReport:ThinLine()
	oReport:PrintText(STR0035)
	
	For nX := 1 To Len(aTotUM)
		oReport:Section(3):PrintLine()
	Next nCnt
	oReport:ThinLine()
	oReport:Section(3):Finish()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha Areas                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If( valtype(oTempTable) == "O")
	dbSelectArea(cAliasSB1)
	oTempTable:Delete()
	freeObj(oTempTable)
	oTempTable := nil
EndIf	

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GeraTrab ³ Autor ³ Marcos V. Ferreira    ³ Data ³ 12.05.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera Arquivo de Trabalho                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR690			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GeraTrab(cAliasTop)
Local aArea		:= GetArea()
Local cFilSB1	:= xFilial("SB1")
Default cAliasTop := "SB1"

//-------------------------------------------------------------------
// Instancia tabela temporária.  
//-------------------------------------------------------------------
oTempTable	:= FWTemporaryTable():New( "TRB" )

//-------------------------------------------------------------------
// Atribui o  os índices.  
//-------------------------------------------------------------------
oTempTable:SetFields( SB1->(dbStruct()) )
oTempTable:AddIndex("1",{"B1_FILIAL","B1_LOCPAD","B1_COD"})
	
//------------------
//Criação da tabela
//------------------
oTempTable:Create()

dbSelectArea(cAliasTop)
Do While !(cAliasTop)->(Eof()) .And. cFilSB1 == SB1->B1_FILIAL
	If (cAliasTop)->B1_COD < mv_par01 .Or. (cAliasTop)->B1_COD > mv_par02 .Or. (cAliasTop)->B1_TIPO < mv_par05 .Or. (cAliasTop)->B1_TIPO > mv_par06
		DbSkip()
		Loop
	Endif

	dbSelectArea("TRB")
	RecLock("TRB",.T.)
	Replace TRB->B1_FILIAL	With cFilSB1
	Replace TRB->B1_COD		With (cAliasTop)->B1_COD
	Replace TRB->B1_TIPO	With (cAliasTop)->B1_TIPO
	Replace TRB->B1_LOCPAD	With RetFldProd((cAliasTop)->B1_COD,"B1_LOCPAD",cAliasTop)
	Replace TRB->B1_DESC	With (cAliasTop)->B1_DESC
	Replace TRB->B1_UM		With (cAliasTop)->B1_UM	
	MsUnLock()

	dbSelectArea(cAliasTop)
	dbSkip()
EndDo
RestArea(aArea)
Return ("TRB")
