/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"
#include "PMSR040.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Pmsr040   ³ Autor ³ Fabio Rogerio Pereira   ³ Data ³ 29.07.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao da Curva ABC valor orcado dos recursos do orcamento ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                        ³±±
±±³          ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                              ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PmsR040()
Local oReport	:= Nil
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                             ³
//³ MV_PAR01 : Orcamento de ?                                              ³
//³ MV_PAR02 : Ate?                                                        ³
//³ MV_PAR03 : Data validade de                                   		   ³
//³ MV_PAR04 : Data validade ate                                   		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If PMSBLKINT()
	Return Nil
EndIf

Pergunte("PMR040", .F.)

oReport := ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Carnelossi       ³ Data ³29/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³ExpC1: Alias da tabela de Orcamento (AF1)                   ³±±
±±³          ³ExpC2: Alias da tabela de Tarefas do Orcamento (AF2)        ³±±
±±³          ³ExpC3: Alias da tabela de Recursos (AE8)                    ³±±
±±³          ³ExpC4: Alias da tabela de Produtos (SB1)                    ³±±
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
Local aOrdem := {}
Local oReport
Local oOrcto
Local oBreak1, oTotal1
Local oBreak2, oTotal2, oBreak21, oTotal21
Local oBreak3, oTotal3
Local oBreak4, oTotal4
Local oBreak5, oTotal5
Local cAliasAF1 := "AF1"
Local cAliasAF2 := "AF2"
Local cAliasAF3 := "AF3"
Local cAliasAF4 := "AF4"
Local cAliasSB1 := "SB1"
Local cAliasAE8 := "AE8"
Local cAliasAE1 := "AE1"
Local lQuebra   := .T.

Private aABC   := {}
Private nCusto := 0
Private nCustoTsk:= 0
Private nPerAcum := 0


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
oReport := TReport():New("PMSR040",STR0002,"PMR040", ;
			{|oReport| ReportPrint(oReport, @cAliasAF1, @cAliasAF2, @cAliasAF3, @cAliasAF4, @cAliasSB1, @cAliasAE8, @cAliasAE1)},;
			STR0001)
//STR0002 //"Curvas ABC dos Orcamentos"
//STR0001 //"Este relatorio ira imprimir as curvas ABC do orcamento conforme os parametros solicitados"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Alimentar Array aOrdem com as Ordens Disponiveis no relatorio           ³
//³observe que estas ordens nao sao do banco de dados e sim do Array       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAdd(aOrdem, STR0003) //"ORCAMENTO+PRODUTO+DESPESA"
aAdd(aOrdem, STR0004) //"TAREFA+PRODUTO+DESPESA"
aAdd(aOrdem, STR0005) //"TAREFA"
aAdd(aOrdem, STR0006) //"COMPOSICAO"
aAdd(aOrdem, STR0007) //"SUB-COMPOSICAO"

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
oOrcto := TRSection():New(oReport,STR0020,{cAliasAF1}, aOrdem/*{}*/, .F., .F.) //"Orçamento"
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
TRCell():New(oOrcto,	"AF1_ORCAME"	,cAliasAF1,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasAF1)->AF1_ORCAME})
TRCell():New(oOrcto,	"AF1_DESCRI"	,cAliasAF1,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasAF1)->AF1_DESCRI})
oOrcto:SetHeaderPage()
oOrcto:SetLineStyle()

//---CRIAR UMA SECTION PARA CADA ORDEM DO RELATORIO----------------------------//

//-----------------------------------------------------------------------------//
oABCOrdem1 := TRSection():New(oReport, STR0037 + STR0032,{cAliasSB1, cAliasAE8, "SX5"}, {}, .F., .F.) //"Ordem"
TRCell():New(oABCOrdem1	,"TIPO"			,cAliasSB1,STR0028/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Tipo"
TRCell():New(oABCOrdem1	,"B1_COD"   	,cAliasSB1,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem1	,"B1_DESC"		,cAliasSB1,/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem1	,"B1_UM"			,cAliasSB1,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem1	,"AF3_QUANT"	,cAliasAF3,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem1	,"AF3_CUSTD"	,cAliasAF3,STR0029/*Titulo*/,/*Picture*/,22/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Valor"
TRCell():New(oABCOrdem1	,"AF3_CUSTD1"	,cAliasAF3,"% " + STR0030/*Titulo*/,"@E 999.99%"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Proj."
TRCell():New(oABCOrdem1	,"AF3_CUSTD2"	,cAliasAF3,"% " + STR0031/*Titulo*/,"@E 999.99%"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Acum."


oBreak1:= TRBreak():New(oABCOrdem1,{||.T.},STR0021)
oTotal1 := TRFunction():New(oABCOrdem1:Cell("AF3_CUSTD"),"NCUSTO" ,"ONPRINT",oBreak1,STR0021/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal1:ShowHeader()
oTotal1:SetFormula({||nCusto})
oTotal1:SetTotalInLine(.F.) 

//-----------------------------------------------------------------------------//
oABCOrdem2 := TRSection():New(oReport, STR0037 + STR0033, {cAliasAF2,cAliasSB1, cAliasAE8, "SX5"}, {}, .F., .F.) //"Ordem"

TRCell():New(oABCOrdem2	,"AF2_TAREFA"	,cAliasAF2,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem2	,"AF2_DESCRI"	,cAliasAF2,/*Titulo*/,/*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem2	,"TIPO"			,cAliasSB1,STR0028/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Tipo"
TRCell():New(oABCOrdem2	,"B1_COD"   	,cAliasSB1,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem2	,"B1_DESC"		,cAliasSB1,/*Titulo*/,/*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem2	,"B1_UM"		,cAliasSB1,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem2	,"AF3_QUANT"	,cAliasAF3,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem2	,"AF3_CUSTD"	,cAliasAF3,STR0029/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Valor"
TRCell():New(oABCOrdem2	,"AF3_CUSTD1"	,cAliasAF3,"% " + STR0030/*Titulo*/,"@E 999.99%"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Proj."
TRCell():New(oABCOrdem2	,"AF3_CUSTD2"	,cAliasAF3,"% " + STR0031/*Titulo*/,"@E 999.99%"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Acum."


oBreak2:= TRBreak():New(oABCOrdem2,{||lQuebra := !lQuebra},StrTran(STR0021,".....", " Trf."))
oBreak2:OnBreak({|| lQuebra  := .T. })
oTotal2:= TRFunction():New(oABCOrdem2:Cell("AF3_CUSTD"),"NCUSTOTSK" ,"SUM",oBreak2,STR0021/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal2:ShowHeader()
oTotal2:SetFormula({||nCustoTsk })
oTotal2:SetTotalInLine(.F.) 

oBreak21:= TRBreak():New(oABCOrdem2,{||.T.},STR0021) //"Total....."
oTotal21:= TRFunction():New(oABCOrdem2:Cell("AF3_CUSTD"),"NCUSTO" ,"ONPRINT",oBreak21,STR0021/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal21:SetFormula({||nCusto})
oTotal21:SetTotalInLine(.F.) 

//-----------------------------------------------------------------------------//
oABCOrdem3 := TRSection():New(oReport, STR0037 + STR0034,{cAliasAF2}, {}, .F., .F.) //"Ordem"

TRCell():New(oABCOrdem3	,"AF2_TAREFA"	,cAliasAF2,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem3	,"AF2_DESCRI"	,cAliasAF2,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem3	,"AF2_UM"		,cAliasAF2,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem3	,"AF2_QUANT"	,cAliasAF2,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem3	,"AF3_CUSTD"	,cAliasAF3,STR0029/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Valor"
TRCell():New(oABCOrdem3	,"AF2_CUSPRJ"	,cAliasAF2,"% " + STR0030/*Titulo*/,"@E 999.99%"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Proj."
TRCell():New(oABCOrdem3	,"AF2_CUSACU"	,cAliasAF2,"% " + STR0031/*Titulo*/,"@E 999.99%"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Acum."


oBreak3:= TRBreak():New(oABCOrdem3,{||.T.},STR0021)
oTotal3:= TRFunction():New(oABCOrdem3:Cell("AF3_CUSTD"),"NCUSTO" ,"ONPRINT",oBreak3,STR0021/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal3:ShowHeader()
oTotal3:SetFormula({||nCusto})
oTotal3:SetTotalInLine(.F.) 

//-----------------------------------------------------------------------------//
oABCOrdem4 := TRSection():New(oReport, STR0037 + STR0035, {cAliasAE1}, {}, .F., .F.) //"Ordem"

TRCell():New(oABCOrdem4	,"AF2_COMPOS"	,cAliasAF2,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem4	,"AF2_DESCRI"	,cAliasAF2,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem4	,"AF2_UM"		,cAliasAF2,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem4	,"AF3_QUANT"	,cAliasAF3,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem4	,"AF3_CUSTD"	,cAliasAF3,STR0029/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Valor"
TRCell():New(oABCOrdem4	,"AF3_CUSTD1"	,cAliasAF3,"% " + STR0030/*Titulo*/,"@E 999.99%"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Proj."
TRCell():New(oABCOrdem4	,"AF3_CUSTD2"	,cAliasAF3,"% " + STR0031/*Titulo*/,"@E 999.99%"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/) //"Acum."

oBreak4:= TRBreak():New(oABCOrdem4,{||.T.},STR0021)
oTotal4:= TRFunction():New(oABCOrdem4:Cell("AF3_CUSTD"),"NCUSTO" ,"ONPRINT",oBreak4,STR0021/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal4:ShowHeader()
oTotal4:SetFormula({||nCusto})
oTotal4:SetTotalInLine(.F.) 

//-----------------------------------------------------------------------------//
oABCOrdem5 := TRSection():New(oReport, STR0037 + STR0036,{cAliasAE1}, {}, .F., .F.) //"Ordem"

TRCell():New(oABCOrdem5	,"AF2_COMPOS"	,cAliasAF2,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressao}*/)
TRCell():New(oABCOrdem5	,"AE1_DESCRI"  	,cAliasAE1,/*Titulo*/,/*Picture*/,40/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressa}*/)
TRCell():New(oABCOrdem5	,"AF2_UM"		,cAliasSB1,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressa}*/)
TRCell():New(oABCOrdem5	,"AF3_CUSTD"	,cAliasAF3,"Valor"/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressa}*/)
TRCell():New(oABCOrdem5	,"AF3_CUSTD1"	,cAliasAF3,"% " + STR0030/*Titulo*/,"@E 999.99%"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressa}*/) //"Proj."
TRCell():New(oABCOrdem5	,"AF3_CUSTD2"	,cAliasAF3,"% " + STR0031/*Titulo*/,"@E 999.99%"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||bloco-Impressa}*/) //"Acum."

oBreak5:= TRBreak():New(oABCOrdem5,{||.T.},STR0021)
oTotal5:= TRFunction():New(oABCOrdem5:Cell("AF3_CUSTD"),"NCUSTO" ,"ONPRINT",oBreak5,STR0021/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal5:ShowHeader()
oTotal5:SetFormula({||nCusto})
oTotal5:SetTotalInLine(.F.) 

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Paulo Carnelossi      ³ Data ³29/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao do relatorio utilizando TReport         ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³ExpC1: Alias da tabela de Orcamento (AF1)                   ³±±
±±³          ³ExpC2: Alias da tabela de Tarefas do Orcamento (AF2)        ³±±
±±³          ³ExpC3: Alias da tabela de Recursos (AE8)                    ³±±
±±³          ³ExpC4: Alias da tabela de Produtos (SB1)                    ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport, cAliasAF1, cAliasAF2, cAliasAF3, cAliasAF4, cAliasSB1, cAliasAE8, cAliasAE1)
Local nX       	:= 0
Local cTrunca  	:= "1"
Local oOrcto 		 := oReport:Section(1)
Local oABCOrdPrint := oReport:Section(oOrcto:GetOrder()+1)  
Local cObfNRecur	:= IIF(FATPDIsObfuscate("AE8_DESCRI",,.T.),FATPDObfuscate("RESOURCE NAME","AE8_DESCRI",,.T.),"")        

	oReport:OnPageBreak({||oABCOrdPrint:lPrintHeader := .T.})
	If oOrcto:GetOrder() == 1
		oABCOrdPrint:Cell("TIPO")		:SetBlock({|| aABC[nX,1]})
		oABCOrdPrint:Cell("B1_COD")		:SetBlock({|| If(aABC[nX,1]=="PRD", (cAliasSB1)->B1_COD,;
													If(aABC[nX,1]=="REC",(cAliasAE8)->AE8_RECURS,"") )})
		
		oABCOrdPrint:Cell("B1_DESC")	:SetBlock({|| If(aABC[nX,1]=="PRD", (cAliasSB1)->B1_DESC,;
													If(aABC[nX,1]=="REC",IIF(Empty(cObfNRecur),(cAliasAE8)->AE8_DESCRI,cObfNRecur),aABC[nX,2]) )})
		oABCOrdPrint:Cell("B1_UM")		:SetBlock({|| If(aABC[nX,1]=="PRD", (cAliasSB1)->B1_UM,;
													If(aABC[nX,1]=="REC","HR","") )})  
		
		oABCOrdPrint:Cell("AF3_QUANT")	:SetBlock({|| aABC[nX,4] })  
		oABCOrdPrint:Cell("AF3_CUSTD")	:SetBlock({|| aABC[nX,5] })
		oABCOrdPrint:Cell("AF3_CUSTD1")	:SetBlock({|| aABC[nX,5]/nCusto*100 })
		oABCOrdPrint:Cell("AF3_CUSTD2")	:SetBlock({|| nPerAcum })
	
	ElseIf	oOrcto:GetOrder() == 2
	
		oABCOrdPrint:Cell("AF2_TAREFA")	:SetBlock({|| (cAliasAF2)->AF2_TAREFA })
		oABCOrdPrint:Cell("AF2_DESCRI")	:SetBlock({|| (cAliasAF2)->AF2_DESCRI })
		oABCOrdPrint:Cell("TIPO")		:SetBlock({|| aABC[nX,1]})
		oABCOrdPrint:Cell("B1_COD")		:SetBlock({|| If(aABC[nX,1]=="PRD", (cAliasSB1)->B1_COD,;
													If(aABC[nX,1]=="REC",(cAliasAE8)->AE8_RECURS,"") )})
		oABCOrdPrint:Cell("B1_DESC")	:SetBlock({|| If(aABC[nX,1]=="PRD", (cAliasSB1)->B1_DESC,;
														If(aABC[nX,1]=="REC",IIF(Empty(cObfNRecur),(cAliasAE8)->AE8_DESCRI,cObfNRecur),aABC[nX,2]) )})
		oABCOrdPrint:Cell("B1_UM")		:SetBlock({|| If(aABC[nX,1]=="PRD", (cAliasSB1)->B1_UM,;
														If(aABC[nX,1]=="REC","HR","") )})
		oABCOrdPrint:Cell("AF3_QUANT")	:SetBlock({|| aABC[nX,4] })
		oABCOrdPrint:Cell("AF3_CUSTD")	:SetBlock({|| aABC[nX,5] })
		oABCOrdPrint:Cell("AF3_CUSTD1")	:SetBlock({|| aABC[nX,5]/nCusto*100 })
		oABCOrdPrint:Cell("AF3_CUSTD2")	:SetBlock({|| nPerAcum })
	
	ElseIf	oOrcto:GetOrder() == 3
	
		oABCOrdPrint:Cell("AF2_TAREFA")	:SetBlock({|| (cAliasAF2)->AF2_TAREFA })
		oABCOrdPrint:Cell("AF2_DESCRI")	:SetBlock({|| aABC[nX,2] })
		oABCOrdPrint:Cell("AF2_UM")		:SetBlock({|| aABC[nX,3]})
		oABCOrdPrint:Cell("AF2_QUANT")	:SetBlock({|| aABC[nX,4] })
		oABCOrdPrint:Cell("AF3_CUSTD")	:SetBlock({|| aABC[nX,5] })
		oABCOrdPrint:Cell("AF2_CUSPRJ")	:SetBlock({|| aABC[nX,5]/nCusto*100 })
		oABCOrdPrint:Cell("AF2_CUSACU")	:SetBlock({|| nPerAcum })
	
	ElseIf	oOrcto:GetOrder() == 4
	
		oABCOrdPrint:Cell("AF2_COMPOS")	:SetBlock({|| aABC[nX,1] })   //"OUTROS"
		oABCOrdPrint:Cell("AF2_DESCRI")	:SetBlock({|| If(aABC[nX,1]=="OTR", STR0022,AE1->AE1_DESCRI) })
		oABCOrdPrint:Cell("AF2_UM")		:SetBlock({|| aABC[nX,3]})
		oABCOrdPrint:Cell("AF3_QUANT")	:SetBlock({|| aABC[nX,4] })
		oABCOrdPrint:Cell("AF3_CUSTD")	:SetBlock({|| aABC[nX,5] })
		oABCOrdPrint:Cell("AF3_CUSTD1")	:SetBlock({|| aABC[nX,5]/nCusto*100 })
		oABCOrdPrint:Cell("AF3_CUSTD2")	:SetBlock({|| nPerAcum })
	
	ElseIf	oOrcto:GetOrder() == 5
	
		oABCOrdPrint:Cell("AF2_COMPOS")	:SetBlock({|| aABC[nX,1] })   //"OUTROS"
		oABCOrdPrint:Cell("AE1_DESCRI")	:SetBlock({|| If(aABC[nX,1]=="OTR", STR0022,AE1->AE1_DESCRI)})
		oABCOrdPrint:Cell("AF2_UM")		:SetBlock({|| aABC[nX,3]})
		oABCOrdPrint:Cell("AF3_CUSTD")	:SetBlock({|| aABC[nX,5] })
		oABCOrdPrint:Cell("AF3_CUSTD1")	:SetBlock({|| aABC[nX,5]/nCusto*100 })  
		oABCOrdPrint:Cell("AF3_CUSTD2")	:SetBlock({|| nPerAcum })
	
	EndIf
	
	aABC	   := {}
	nCusto   := 0
	nCustoTsk:= 0
	nPerAcum := 0

/* DEFINICAO DO ARRAY aABC
PARA PRODUTOS/DESPESAS
1- TIPO (PRD/DSP)
2- CODIGO PRODUTO/DESCRICAO DESPESA
3- TAREFA   
4- QUANTIDADE PRODUTO
5- VALOR PRODUTO / VALOR DESPESA

PARA TAREFAS
1- TAREFA
2- DESCRICAO TAREFA
3- UNIDADE DE MEDIDA             
4- QUANTIDADE TAREFA
5- CUSTO TAREFA    

PARA COMPOSICAO E SUB-COMPOSICAO
1- COMPOSICAO DA TAREFA
2- SUB-COMPOSICAO
3- UNIDADE DE MEDIDA             
4- QUANTIDADE TAREFA
5- CUSTO TAREFA    
*/
	oOrcto:Init()
	
	dbSelectArea(cAliasAF1)
	dbSetOrder(1)
	MsSeek(xFilial("AF1") + Mv_Par01,.T.)
	oReport:SetMeter((cAliasAF1)->(LastRec()))
	
	While (cAliasAF1)->(!Eof() .And. AF1_ORCAME >= Mv_Par01 .And. AF1_ORCAME <= Mv_Par02) .AND. !oReport:Cancel()
	
		oReport:IncMeter()

		// avalia se o orcamento está dentro da validade
		If !Empty((cAliasAF1)->AF1_VALID)
			If (cAliasAF1)->( AF1_VALID < Mv_Par03 .Or. AF1_VALID > Mv_Par04 )
				dbSelectArea(cAliasAF1)
				dbSkip()
				Loop
			EndIf
		EndIf
	
		// se deve truncar ou arredondar as casas decimais
		cTrunca := (cAliasAF1)->AF1_TRUNCA
		
		// carrega os valores do orcamento
		Pmr040_Ini( oOrcto, @aABC ,@nCusto ,cTrunca, cAliasAF1 )
		
		If (Len(aABC) > 0)
		    
			oOrcto:PrintLine()
			
			oABCOrdPrint:Init()

			For nX:= 1 To Len(aABC)
				
				Do Case 
					Case oOrcto:GetOrder() == 1 //Por Orcamento
						If aABC[nX,1]=="PRD"
							SB1->(dbSetOrder(1))
	  						SB1->(MsSeek(xFilial("SB1")+aABC[nX,2]))
							nPerAcum += aABC[nX,5]/nCusto*100

							If oABCOrdPrint:lPrintHeader
								oABCOrdPrint:PrintHeader()
								oABCOrdPrint:lPrintHeader := .F.
							EndIf	
                            
	      					oABCOrdPrint:PrintLine()
		                    
						ElseIf aABC[nX,1]=="REC"
							AE8->(dbSetOrder(1))
							AE8->(MsSeek(xFilial("AE8") + aABC[nX,2]))
							nPerAcum += aABC[nX,5]/nCusto*100

							If oABCOrdPrint:lPrintHeader
								oABCOrdPrint:PrintHeader()
								oABCOrdPrint:lPrintHeader := .F.
							EndIf	
							
							oABCOrdPrint:PrintLine()

						ElseIf aABC[nX,1]=="DSP"
							nPerAcum += aABC[nX,5]/nCusto*100				
				
							If oABCOrdPrint:lPrintHeader
								oABCOrdPrint:PrintHeader()
								oABCOrdPrint:lPrintHeader := .F.
							EndIf	
							SX5->(DbSetOrder(1))
							SX5->(MsSeek(xFilial("SX5") + 'FD' + aABC[nX,6]))
							//Esconde  as celulas que nao vao ser impressas
							oABCOrdPrint:Cell("B1_COD"):Hide()
							oABCOrdPrint:Cell("B1_UM"):Hide()
							oABCOrdPrint:Cell("AF3_QUANT"):Hide()
                            
							oABCOrdPrint:PrintLine()

							//Volta exibir as celulas que nao vao ser impressas
							oABCOrdPrint:Cell("B1_COD"):Show()
							oABCOrdPrint:Cell("B1_UM"):Show()
							oABCOrdPrint:Cell("AF3_QUANT"):Show()
							
						EndIf
							
					Case oOrcto:GetOrder() == 2 //Por Tarefa
						nCustoTsk+= aABC[nX,5]
						
						AF2->(dbSetOrder(1))
						AF2->(dbSeek(xFilial("AF2")+(cAliasAF1)->AF1_ORCAME+aABC[nX,3]))
		
						If aABC[nX,1] == "PRD"
							SB1->(dbSetOrder(1))
							SB1->(dbSeek(xFilial("SB1")+aABC[nX,2]))
							nPerAcum += aABC[nX,5]/nCusto*100

							If oABCOrdPrint:lPrintHeader
								oABCOrdPrint:PrintHeader()
								oABCOrdPrint:lPrintHeader := .F.
							EndIf	
										
							oABCOrdPrint:PrintLine()
							
						ElseIf aABC[nX,1]=="REC"
							AE8->(dbSetOrder(1))
							AE8->(MsSeek(xFilial("AE8") + aABC[nX,2]))
							nPerAcum += aABC[nX,5]/nCusto*100
							
							If oABCOrdPrint:lPrintHeader
								oABCOrdPrint:PrintHeader()
								oABCOrdPrint:lPrintHeader := .F.
							EndIf	

							oABCOrdPrint:PrintLine()
	                    

						ElseIf aABC[nX,1] == "DSP"
							nPerAcum += aABC[nX,5]/nCusto*100
							
							If oABCOrdPrint:lPrintHeader
								oABCOrdPrint:PrintHeader()
								oABCOrdPrint:lPrintHeader := .F.
							EndIf	
							SX5->(DbSetOrder(1))
							SX5->(MsSeek(xFilial("SX5") + 'FD' + aABC[nX,6]))
							//Esconde  as celulas que nao vao ser impressas
							oABCOrdPrint:Cell("B1_COD"):Hide()
							oABCOrdPrint:Cell("B1_UM"):Hide()
							oABCOrdPrint:Cell("AF3_QUANT"):Hide()
                            
		                    oABCOrdPrint:PrintLine()

							//Exibe as celulas que nao vao ser impressas
							oABCOrdPrint:Cell("B1_COD"):Show()
							oABCOrdPrint:Cell("B1_UM"):Show()
							oABCOrdPrint:Cell("AF3_QUANT"):Show()

						EndIf	
	
					Case oOrcto:GetOrder() == 3 //Tarefas
					
						nPerAcum += aABC[nX,5]/nCusto*100

						AF2->(dbSetOrder(1))
						AF2->(dbSeek(xFilial("AF9")+AF1->AF1_ORCAME+aABC[nx,1]))
						
						oABCOrdPrint:PrintLine()

					Case oOrcto:GetOrder() == 4 //Composicao
						If (aABC[nX,1] != "OTR")
							AE1->(dbSetOrder(1))
							AE1->(MsSeek(xFilial("AE1") + aABC[nX,1]))
						EndIf
						nPerAcum += aABC[nX,5]/nCusto*100
						
						oABCOrdPrint:PrintLine()

					Case oOrcto:GetOrder() == 5   //Sub-Composicao
						nPerAcum += aABC[nX,5]/nCusto*100
					
						If (aABC[nX,1] != "OTR")
							AE1->(dbSetOrder(1))
							AE1->(MsSeek(xFilial("AE1") + aABC[nX,2]))
						EndIf 
						
						oABCOrdPrint:PrintLine()
	
		        EndCase
                
            	If oOrcto:GetOrder() == 2 //Por Tarefa
					nCustoTsk:= 0
				EndIf

			Next
			
			oABCOrdPrint:Finish()
    
		EndIf
		
		aABC     := {}
		nPerAcum := 0
		nCustoTsk:= 0
		nCusto   := 0
		
		dbSelectArea(cAliasAF1)
		dbSkip()
	EndDo
	
	If oReport:Cancel()
		oReport:Say( oReport:Row()+1 ,10 ,STR0038) //"*** CANCELADO PELO OPERADOR ***"
	EndIf

	oOrcto:Finish()
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR040Ini   ³ Autor ³Fabio Rogerio Pereira³ Data ³29.07.2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Avalia os dados do orcamento								   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Pmr040Ini(aPar1, nPar1)				                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Pmr040_Ini( oOrcto, aABC ,nCusto ,cTrunca, cAliasAF1 )
Local aArea    := GetArea()
Local nPos     := 0
Local nQuantAF3:= 0
Local nValorAF4:= 0
Local cCompos  := ""	
Local nDecCst  := TamSX3("AF3_CUSTD")[2]

DEFAULT cTrunca  := "1"

/* DEFINICAO DO ARRAY aABC
PARA PRODUTOS/DESPESAS
1- TIPO (PRD/DSP)
2- CODIGO PRODUTO/DESCRICAO DESPESA
3- TAREFA   
4- QUANTIDADE PRODUTO
5- VALOR PRODUTO / VALOR DESPESA

PARA TAREFAS
1- TAREFA
2- DESCRICAO TAREFA
3- UNIDADE DE MEDIDA             
4- QUANTIDADE TAREFA
5- CUSTO TAREFA    

PARA COMPOSICAO E SUB-COMPOSICAO
1- COMPOSICAO
2- SUB-COMPOSICAO
3- UNIDADE DE MEDIDA             
4- QUANTIDADE TAREFA
5- CUSTO TAREFA    
*/

If oOrcto:GetOrder() == 1 .Or. oOrcto:GetOrder() == 2
	dbSelectArea("AF2")
	dbSetOrder(1)
	MsSeek(xFilial("AF2")+(cAliasAF1)->AF1_ORCAME)
	While !Eof() .And. (xFilial("AF2")+(cAliasAF1)->AF1_ORCAME == AF2->AF2_FILIAL+AF2->AF2_ORCAME)

			// verifica os produtos do orcamento
			dbSelectArea("AF3")
			dbSetOrder(1)
			If MsSeek(xFilial("AF3")+AF2->AF2_ORCAME+AF2->AF2_TAREFA)
				While !Eof() .And. (xFilial("AF3")+AF2->AF2_ORCAME+AF2->AF2_TAREFA == AF3->AF3_FILIAL+AF3->AF3_ORCAME+AF3->AF3_TAREFA)
									
					If oOrcto:GetOrder() == 1 //Por Orcamento
						If (Empty(AF3->AF3_RECURS))
							nPos     := aScan(aABC,{|x| x[1] == "PRD" .And. x[2] == AF3->AF3_PRODUT})
						Else                                                                         
							nPos     := aScan(aABC,{|x| x[1] == "REC" .And. x[2] == AF3->AF3_RECURS})
						EndIf

					ElseIf oOrcto:GetOrder() == 2 //Por Tarefa
						If (Empty(AF3->AF3_RECURS)) 
							nPos     := aScan(aABC,{|x| x[1] == "PRD" .And. x[2] == AF3->AF3_PRODUT .And. x[3]== AF3->AF3_TAREFA})
						Else                                                                         
							nPos     := aScan(aABC,{|x| x[1] == "REC" .And. x[2] == AF3->AF3_RECURS .And. x[3]== AF3->AF3_TAREFA})
						EndIf
					EndIf
		
					nQuantAF3:= PmsAF3Quant(AF3->AF3_ORCAME,AF3->AF3_TAREFA,AF3->AF3_PRODUT,AF2->AF2_QUANT,AF3->AF3_QUANT)
					If (nPos > 0)
						aABC[nPos,4]+= nQuantAF3
						aABC[nPos,5]+= xMoeda(PMSTrunca(cTrunca,nQuantAF3 * AF3->AF3_CUSTD,nDecCst ,AF2->AF2_QUANT),AF3->AF3_MOEDA,1)
					Else
						If (Empty(AF3->AF3_RECURS)) 
							aAdd(aABC,{"PRD",AF3->AF3_PRODUT,AF3->AF3_TAREFA,nQuantAF3,xMoeda(PMSTrunca(cTrunca,nQuantAF3 * AF3->AF3_CUSTD,nDecCst ,AF2->AF2_QUANT),AF3->AF3_MOEDA,1)})
						Else                                                                                                                                            
							aAdd(aABC,{"REC",AF3->AF3_RECURS,AF3->AF3_TAREFA,nQuantAF3,xMoeda(PMSTrunca(cTrunca,nQuantAF3 * AF3->AF3_CUSTD,nDecCst ,AF2->AF2_QUANT),AF3->AF3_MOEDA,1)})
						Endif
					EndIf
						
					nCusto += xMoeda(PMSTrunca(cTrunca,nQuantAF3 * AF3->AF3_CUSTD,nDecCst ,AF2->AF2_QUANT),AF3->AF3_MOEDA,1)
					dbSelectArea("AF3")
					dbSkip()
				End
			EndIf
			
			// verifica as despesa do orcamento
			dbSelectArea("AF4")
			dbSetOrder(1)
			If MsSeek(xFilial("AF4")+AF2->AF2_ORCAME+AF2->AF2_TAREFA)
				While !Eof() .And. (xFilial("AF4")+AF2->AF2_ORCAME+AF2->AF2_TAREFA == AF4->AF4_FILIAL+AF4->AF4_ORCAME+AF4->AF4_TAREFA)
									
					If oOrcto:GetOrder() == 1 //Por Orcamento
						nPos     := aScan(aABC,{|x| x[1] == "DSP" .And. x[2] == AF4->AF4_DESCRI})
		
					ElseIf oOrcto:GetOrder() == 2 //Por Tarefa
						nPos     := aScan(aABC,{|x| x[1] == "DSP" .And. x[2] == AF4->AF4_DESCRI .And. x[3] == AF4->AF4_TAREFA})
					EndIf
		
					nValorAF4:= PMSTrunca(cTrunca,PmsAF4Valor(AF2->AF2_QUANT,AF4->AF4_VALOR),nDecCst ,AF2->AF2_QUANT)
					If (nPos > 0)
						aABC[nPos,5]+= xMoeda(nValorAF4,AF4->AF4_MOEDA,1)
					Else
						aAdd(aABC,{"DSP",AF4->AF4_DESCRI,AF4->AF4_TAREFA,0,xMoeda(nValorAF4,AF4->AF4_MOEDA,1),AF4->AF4_TIPOD})
					EndIf
						
					nCusto += xMoeda(nValorAF4,AF4->AF4_MOEDA,1)
					
					dbSelectArea("AF4")
					dbSkip()
				End
			EndIf
		    
			dbSelectArea("AF2")
			dbSkip()
	EndDo
	
ElseIf oOrcto:GetOrder() == 3 //Tarefa
	dbSelectArea("AF2")
	dbSetOrder(1)
	 MsSeek(xFilial("AF2")+(cAliasAF1)->AF1_ORCAME)
	While !Eof() .And. (xFilial("AF2")+(cAliasAF1)->AF1_ORCAME == AF2->AF2_FILIAL+AF2->AF2_ORCAME)

		nPos     := aScan(aABC,{|x| x[1] == AF2->AF2_TAREFA})

		If (nPos > 0)
			aABC[nPos,5]+= AF2->AF2_CUSTO
			aABC[nPos,4]+= AF2->AF2_QUANT
		Else
			aAdd(aABC,{AF2->AF2_TAREFA,AF2->AF2_DESCRI,AF2->AF2_UM,AF2->AF2_QUANT,AF2->AF2_CUSTO})
		EndIf
					
		nCusto += AF2->AF2_CUSTO
		dbSelectArea("AF2")
		dbSkip()
	EndDo

ElseIf oOrcto:GetOrder() == 4 //Composicao
	dbSelectArea("AF2")
	dbSetOrder(3)
	MsSeek(xFilial("AF2")+(cAliasAF1)->AF1_ORCAME)
	While !Eof() .And. (xFilial("AF2")+(cAliasAF1)->AF1_ORCAME == AF2->AF2_FILIAL+AF2->AF2_ORCAME)

		
		// analisa se e uma composicao
		If !Empty(AF2->AF2_COMPOS)
			nPos     := aScan(aABC,{|x| x[1] == AF2->AF2_COMPOS})
	
			If (nPos > 0)
				aABC[nPos,5]+= AF2->AF2_CUSTO
				aABC[nPos,4]+= AF2->AF2_QUANT
			Else
				aAdd(aABC,{AF2->AF2_COMPOS,"",AF2->AF2_UM,AF2->AF2_QUANT,AF2->AF2_CUSTO})
			EndIf
		Else
			nPos     := aScan(aABC,{|x| x[1] == "OTR"})
	
			If (nPos > 0)
				aABC[nPos,5]+= AF2->AF2_CUSTO
				aABC[nPos,4]+= AF2->AF2_QUANT
			Else
				aAdd(aABC,{"OTR","--","--",AF2->AF2_QUANT,AF2->AF2_CUSTO})
			EndIf
		EndIf

		// soma o custo de todas as tarefas sempre
		nCusto += AF2->AF2_CUSTO
	    
		dbSelectArea("AF2")
		dbSkip()
	EndDo

ElseIf oOrcto:GetOrder() == 5 //Sub-Composicao
	dbSelectArea("AF2")
	dbSetOrder(3)
	MsSeek(xFilial("AF2")+(cAliasAF1)->AF1_ORCAME)
	While !Eof() .And. (xFilial("AF2")+(cAliasAF1)->AF1_ORCAME == AF2->AF2_FILIAL+AF2->AF2_ORCAME)
		If !Empty(AF2->AF2_COMPOS)

			// verifica os produtos do orcamento
			dbSelectArea("AF3")
			dbSetOrder(1)
			If MsSeek(xFilial("AF3")+AF2->AF2_ORCAME+AF2->AF2_TAREFA)
				While !Eof() .And. (xFilial("AF3")+AF2->AF2_ORCAME+AF2->AF2_TAREFA == AF3->AF3_FILIAL+AF3->AF3_ORCAME+AF3->AF3_TAREFA)
					
					// calcula a quantidade de produtos pertencentes a sub-composicao
					nQuantAF3:= PmsAF3Quant(AF3->AF3_ORCAME,AF3->AF3_TAREFA,AF3->AF3_PRODUT,AF2->AF2_QUANT,AF3->AF3_QUANT)

					// verifica se o produto pertence a alguma sub-composicao
					// caso nao pertenca adiciona o valor do produto em Outros
					cCompos:= IIf(!Empty(AF3->AF3_COMPOS),AF3->AF3_COMPOS,AF2->AF2_COMPOS)
					nPos   := aScan(aABC,{|x| x[2]== cCompos})
					
					If (nPos > 0)
						aABC[nPos,5]+= xMoeda(PMSTrunca(cTrunca,nQuantAF3 * AF3->AF3_CUSTD,nDecCst ,AF2->AF2_QUANT),AF3->AF3_MOEDA,1)
					Else
						aAdd(aABC,{AF2->AF2_COMPOS,cCompos,AF2->AF2_UM,0,xMoeda(PMSTrunca(cTrunca,nQuantAF3 * AF3->AF3_CUSTD,nDecCst,AF2->AF2_QUANT ),AF3->AF3_MOEDA,1)})
					EndIf
						
					nCusto += xMoeda(PMSTrunca(cTrunca,nQuantAF3 * AF3->AF3_CUSTD,nDecCst ,AF2->AF2_QUANT),AF3->AF3_MOEDA,1)
					dbSelectArea("AF3")
					dbSkip()
				End
			EndIf
			
			// verifica as despesa do orcamento
			dbSelectArea("AF4")
			dbSetOrder(1)
			If MsSeek(xFilial("AF4")+AF2->AF2_ORCAME+AF2->AF2_TAREFA)
				While !Eof() .And. (xFilial("AF4")+AF2->AF2_ORCAME+AF2->AF2_TAREFA == AF4->AF4_FILIAL+AF4->AF4_ORCAME+AF4->AF4_TAREFA)
									
					// calcula o valor da despesa da sub-composicao
					nValorAF4:= PMSTrunca(cTrunca,PmsAF4Valor(AF2->AF2_QUANT,AF4->AF4_VALOR),nDecCst ,AF2->AF2_QUANT)

					// verifica se a despesa pertence a alguma sub-composicao
					// caso nao pertenca adiciona o valor da despesa em Outros
					cCompos:= IIf(!Empty(AF4->AF4_COMPOS),AF4->AF4_COMPOS,AF2->AF2_COMPOS)
					nPos   := aScan(aABC,{|x| x[2]== AF4->AF4_COMPOS})
			
					If (nPos > 0)
						aABC[nPos,5]+= xMoeda(nValorAF4,AF4->AF4_MOEDA,1)
					Else
						aAdd(aABC,{AF2->AF2_COMPOS,cCompos,AF2->AF2_UM,0,nValorAF4})
					EndIf
												
					nCusto += xMoeda(nValorAF4,AF4->AF4_MOEDA,1)
					
					dbSelectArea("AF4")
					dbSkip()
				End
			EndIf
		Else

			// soma o custo de todas as tarefas sempre
			nCusto += AF2->AF2_CUSTO

			nPos     := aScan(aABC,{|x| x[1] == "OTR"})
			If (nPos > 0)
				aABC[nPos,5]+= AF2->AF2_CUSTO
			Else
				aAdd(aABC,{"OTR","--","--",0,AF2->AF2_CUSTO})
			EndIf

		EndIf
		    
		dbSelectArea("AF2")
		dbSkip()
	EndDo
	
EndIf

aABC := aSort(aABC,,,{|x,y| x[5] > y[5]})

RestArea(aArea)
Return( .T. )

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
