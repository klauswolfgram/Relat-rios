/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR340.CH"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR340  ³ Autor ³ Marcos V. Ferreira    ³ Data ³ 25/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Consumos mes a mes                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Descri‡…o ³ PLANO DE MELHORIA CONTINUA        ³Programa    MATR340.PRX ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ITEM PMC  ³ Responsavel              ³ Data       	|BOPS             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³      01  ³                          ³           	|                 ³±±
±±³      02  ³ Ricardo Berti            ³ 06/10/2006	| 00000109555     ³±±
±±³      03  ³                          ³           	|                 ³±±
±±³      04  ³ Ricardo Berti            ³ 06/10/2006	| 00000109555     ³±±
±±³      05  ³                          ³           	|                 ³±±
±±³      06  ³                          ³           	|                 ³±±
±±³      07  ³                          ³           	|                 ³±±
±±³      08  ³                          ³           	|                 ³±±
±±³      09  ³                          ³           	|                 ³±±
±±³      10  ³                          ³           	|                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR340()
Local oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Marcos V. Ferreira     ³ Data ³25/05/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR225			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local aMeses   := {STR0011, STR0012, STR0013, STR0014, STR0015, STR0016, STR0017, STR0018, STR0019, STR0020, STR0021, STR0022} //"JAN"###"FEV"###"MAR"###"ABR"###"MAI"###"JUN"###"JUL"###"AGO"###"SET"###"OUT"###"NOV"###"DEZ"
Local nMes     := 0
Local nAno     := 0
Local oReport
Local oConsumo
Local aOrdem   := {STR0005, STR0006, STR0007, STR0008} //##Por Codigo##Por Tipo##Por Descricao##Por Grupo
local nTamDesc := 30
Local nTam     := 14
Local nX       := 0

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
oReport:= TReport():New("MATR340",OemToAnsi(STR0001),"MTR340", {|oReport| ReportPrint(oReport)},OemToAnsi(STR0002)+" "+OemToAnsi(STR0003)+" "+OemToAnsi(STR0004)) //##"Este programa exibira' o consumo dos ultimos 12 meses de cada material"##"ou produto acabado. No caso dos produtos ele estara' listando o  total"##"das vendas."
oReport:SetLandscape()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // codigo de                                    ³
//³ mv_par02	 // codigo ate                                   ³
//³ mv_par03     // tipo de                                      ³
//³ mv_par04     // tipo ate                                     ³
//³ mv_par05     // grupo de                                     ³
//³ mv_par06     // grupo ate                                    ³
//³ mv_par07     // descricao de                                 ³
//³ mv_par08     // descricao ate                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 1 (oConsumo)                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- Só adiciona SB1 no personalizável quando não compartilhado ou sem gestão de empresas
//-- Isto para habilitar o recurso de impressão em N filiais (botão Gestão de Empresas)
If FWModeAccess("SB1",1) == "E" .Or. (At("E",FWSM0Layout()) == 0 .And. At("U",FWSM0Layout()) == 0)
	oConsumo := TRSection():New(oReport,STR0039,{"SB1","SB3"},aOrdem) //"Consumos/Vendas mes a mes de Materiais"##"Demandas"
Else
	oConsumo := TRSection():New(oReport,STR0039,{"SB3"},aOrdem) //"Consumos/Vendas mes a mes de Materiais"##"Demandas"
EndIf
oConsumo:SetTotalInLine(.F.)
oConsumo:SetTotalText(STR0028) //"Total geral"

//
IF(TAMSX3('B1_COD')[1] > 15)
	nTamDesc := nTamDesc - (TAMSX3('B1_COD')[1] -15)
ENDIF

TRCell():New(oConsumo,'B1_COD'		,'SB1',STR0031	 ,/*Picture*/					,TAMSX3('B1_COD')[1]+15,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oConsumo,'B1_TIPO'		,'SB1',STR0032	 ,/*Picture*/					,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oConsumo,'B1_GRUPO'	,'SB1',STR0033	 ,/*Picture*/					,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oConsumo,'B1_DESC'		,'SB1',STR0034	 ,/*Picture*/					,nTamDesc,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oConsumo,'B1_UM'		,'SB1',STR0035	 ,/*Picture*/					,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oConsumo,'MES01'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q01',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES02'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q02',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES03'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q03',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES04'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q04',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES05'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q05',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES06'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q06',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES07'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q07',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES08'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q08',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES09'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q09',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES10'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q10',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES11'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q11',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'MES12'		,'  ' ,/*Titulo*/,PesqPict('SB3','B3_Q12',nTam)	,nTam			,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'B3_MEDIA'	,'SB3',STR0036	 ,/*Picture*/					,/*Tamanho*/    ,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'B3_TOTAL'	,'SB3',STR0037	 ,/*Picture*/					,/*Tamanho*/    ,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oConsumo,'CLASSE'   	,'   ',STR0038	 ,/*Picture*/					,07				,/*lPixel*/,{|| cClasse}					 ,"LEFT",,"LEFT")

oConsumo:SetHeaderPage()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem dos dados do cabecalho do relatorio                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nAno := Year(Date())
If month(Date()) < 12
	nAno--
EndIf

nMes := Month(Date())+1
If nMes = 13
	nMes := 1
EndIf

cMes := StrZero(nMes,2)
For nX := 1 To 12
	If aMeses[nMes] == STR0011 .And. nX != 1	//"JAN"
		nAno++
	EndIf
	oConsumo:Cell('MES'+StrZero(nX,2)):SetTitle(Space(3)+aMeses[nMes]+"/"+StrZero(nAno,4))
	nMes++
	If nMes > 12
		nMes := 1
	EndIf
Next nX

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Marcos V. Ferreira   ³ Data ³25/05/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR340			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
Local oConsumo  := oReport:Section(1)
Local cCampo    := ""
Local nMesAux   := 0
Local nMes      := 0
Local nX        := 0
Local cAliasSB1 := 'SB1'
Local nOrdem    := oConsumo:GetOrder()
Local oBreak

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis privadas exclusivas deste programa                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cMes
Private lContinua := .T.
Private cCondSec
Private cAnt
Private cClasse   := ''

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da linha de SubTotal                               |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 2
	oBreak := TRBreak():New(oConsumo,oConsumo:Cell("B1_TIPO"),STR0029,.F.) //"SubTotal por Tipo:"
ElseIf nOrdem == 4
	oBreak := TRBreak():New(oConsumo,oConsumo:Cell("B1_GRUPO"),STR0030,.F.) //"SubTotal por Grupo:"
EndIf

If nOrdem == 2 .Or. nOrdem == 4
	TRFunction():New(oConsumo:Cell("MES01"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES02"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES03"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES04"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES05"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES06"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES07"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES08"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES09"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES10"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES11"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("MES12"		),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("B3_MEDIA"	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oConsumo:Cell("B3_TOTAL"	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da linha de Total Geral                            |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRFunction():New(oConsumo:Cell("MES01"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES02"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES03"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES04"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES05"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES06"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES07"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES08"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES09"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES10"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES11"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("MES12"		),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("B3_MEDIA"	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oConsumo:Cell("B3_TOTAL"	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SB1")
dbSetOrder(oConsumo:GetOrder())

lQuery := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:Section(1):BeginQuery()

cAliasSB1 := GetNextAlias()

BeginSql Alias cAliasSB1

SELECT B1_FILIAL,B1_COD,B1_DESC,B1_TIPO,B1_GRUPO,B1_UM,B3_Q01,B3_Q02,B3_Q03,B3_Q04,
       B3_Q05,B3_Q06,B3_Q07,B3_Q08,B3_Q09,B3_Q10,B3_Q11,B3_Q12,B3_MEDIA,B3_TOTAL,
       B3_CLASSE

FROM %table:SB1% SB1,%table:SB3% SB3

WHERE B1_FILIAL = %xFilial:SB1%		AND
 	  B1_COD   >= %Exp:mv_par01%	AND
 	  B1_COD   <= %Exp:mv_par02%	AND
 	  B1_TIPO  >= %Exp:mv_par03%	AND
 	  B1_TIPO  <= %Exp:mv_par04%	AND
 	  B1_GRUPO >= %Exp:mv_par05%	AND
 	  B1_GRUPO <= %Exp:mv_par06%	AND
	  B1_DESC  >= %Exp:mv_par07%	AND
	  B1_DESC  <= %Exp:mv_par08%	AND
	  B1_COD    = B3_COD			AND
	  B3_FILIAL = %xFilial:SB3%		AND
 		  SB1.%NotDel% AND
 		  SB3.%NotDel%

ORDER BY %Order:SB1%

EndSql

oReport:Section(1):EndQuery()


oReport:SetMeter(SB1->(LastRec()))

oConsumo:Init()

Do While !oReport:Cancel() .And. (cAliasSB1)->(!Eof()) .And. (cAliasSB1)->B1_FILIAL == xFilial('SB1')

	oReport:IncMeter()
	
	cClasse:=(cAliasSB1)->B3_CLASSE 
 	
	oConsumo:Cell("B1_COD"		):Show()
	oConsumo:Cell("B1_TIPO"		):Show()
	oConsumo:Cell("B1_GRUPO"	):Show()
	oConsumo:Cell("B1_DESC"		):Show()
	oConsumo:Cell("B1_UM"		):Show()
	
	nMes := Month(Date())+1
	If nMes == 13
		nMes := 1
	EndIf

	nMesAux := nMes
	For nX := 1 To 12
		cCampo := "B3_Q"+StrZero(nMesAux,2)
		oConsumo:Cell("MES"+StrZero(nX,2)):SetValue(&cCampo)

		nMesAux++
		If nMesAux > 12
			nMesAux := 1
		EndIf
	Next nX

	oConsumo:Cell("B3_MEDIA"):Show()
	oConsumo:Cell("B3_TOTAL"):Show()
	oConsumo:Cell("CLASSE"):Show()

	oConsumo:PrintLine()

	dbSelectArea(cAliasSB1)
	dbSkip()

EndDo

oConsumo:Finish()

//-- Devolve a condicao original do arquivo principal
dbSelectArea('SB1')
dbSetOrder(1)
dbClearFilter()

Return
