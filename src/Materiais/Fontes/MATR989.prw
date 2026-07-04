/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR989.CH"
#INCLUDE "PROTHEUS.CH"

Static __cNumOP
Static __cItemOP
Static __cSeqOP
Static __cItGrdOP

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR989  ³ Autor ³ Microsiga S/A 	    ³ Data ³ 19/05/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatorio de Saldos em Processo (Analitico)                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR989(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MATR989()
Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Microsiga S/A 		³ Data ³19.05.2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
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
Local oSection1
Local oReport 
Local oCell         

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
oReport := TReport():New("MATR989",STR0001,"MTR989", {|oReport| ReportPrint(oReport)},STR0002+" "+STR0003+" "+STR0004)
oReport:SetTotalInLine(.F.)
oReport:SetTotalText(STR0014) //"TOTAL GERAL :"
oReport:SetEdit(.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                   ³
//³ mv_par01   // Produto Inicial ?                                        ³
//³ mv_par02   // Produto Final ?                                          ³
//³ mv_par03   // Armazem Inicial ?                                        ³
//³ mv_par04   // Armazem Final ?                                          ³
//³ mv_par05   // Lista MOD em Processo ?                                  ³
//³ mv_par06   // Data de Fechamento ?                                     ³
//³ mv_par07   // Verif. Sld. Processo ?                                   ³
//³ mv_par08   // Quanto a Quebra Aliquota ?                               ³
//³ mv_par08   // Lista Custo ?                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR989",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a secao.                   ³
//³ExpA4 : Array com as Ordens do relatorio                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1 := TRSection():New(oReport,STR0001,{"SD3","SB1"}) //"Saldo em Processo (Analitico)"
oSection1:SetHeaderPage()
oSection1:SetReadOnly()

TRCell():New(oSection1,"B1_COD"						,"SB1"	,STR0005				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_DESC"					,"SB1"	,STR0013				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_UM"						,"SB1"	,STR0006				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D3_LOCAL"					,"SD3"	,STR0007 				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D3_OP"						,"SD3"	,STR0008+CRLF+STR0009	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D3_CF"						,"SD3"	,STR0019+CRLF+STR0020	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D3_QUANT"					,"SD3"	,STR0010+CRLF+STR0012	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,"D3_CUSTO1"					,"SD3"	,STR0011+CRLF+STR0012	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")

TRFunction():New(oSection1:Cell('D3_QUANT' ),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{|| If(SD3->D3_TM > "500",oSection1:Cell('D3_QUANT') :GetValue(),-oSection1:Cell('D3_QUANT') :GetValue())},.F.,.T.)
TRFunction():New(oSection1:Cell('D3_CUSTO1'	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{|| If(SD3->D3_TM > "500",oSection1:Cell('D3_CUSTO1'):GetValue(),-oSection1:Cell('D3_CUSTO1'):GetValue())},.F.,.T.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Microsiga S/A   		³ Data ³18.04.2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local cProdIni	   := mv_par01
Local cProdFim	   := mv_par02
Local cAlmoxIni	   := mv_par03
Local cAlmoxFim    := mv_par04
Local lModProces   :=(mv_par05 == 1)  
Local dDtFech	   := mv_par06
Local lCalcProcDt  :=(mv_par07 == 1)
Local lListCustMed :=(mv_par08 == 1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ R989EmProcesso - Rotina utilizada para realizar a impressao do saldo em    |
//|                  processo das ordens de producao em aberto.                |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
R989EmProcesso(.F., "", .T. ,cProdIni, cProdFim, cAlmoxIni, cAlmoxFim, lModProces, dDtFech, lCalcProcDt, 0 , lListCustMed, oReport)

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³R989EmProcesso ³Autor³Microsiga S/A       ³ Data ³ 26/05/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Busca saldo em Processo                                     ³±±
±±³          ³Atualiza aqruivo de trab. c/ Saldo em Processo dos Produtos.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd         - Var. que indica se proc. foi interrompido   ³±±
±±³          ³ cArqTemp     - Nome do arquivo de trabalho                 ³±±
±±³          ³ lGraph       - Nao atualiza regua de progressao            ³±±
±±³          ³ cProdIni     - Produto Inicial                             ³±±
±±³          ³ cProdFim     - Produto Final                               ³±±
±±³          ³ cAlmoxIni    - Armazem Inicial                             ³±±
±±³          ³ cAlmoxFim    - Armazem Final                               ³±±
±±³          ³ lModProces   - Considera Mao de Obra em Processo           ³±±
±±³          ³ dDtFech      - Data de Fechamento cons. p/ o calculo       ³±±
±±³          ³ lCalcProcDt  - Cons. => Dt. Emissao(.T.) / Sec. Calc.(.F.) ³±±
±±³          ³ nQuebraAliq  - Opcao de Quebra por Aliquota                ³±±
±±³          ³ (1)Nao Quebra / (2) Icms produto (3) Icms reducao          ³±±
±±³          ³ lListCustMed - Lista Custo Medio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno  ³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R989EmProcesso(lEnd,cArqTemp,lGraph, cProdIni, cProdFim, cAlmoxIni, cAlmoxFim, lModProces, dDtFech, lCalcProcDt, nQuebraAliq, lListCustMed, oReport)

Local oSection1	:= oReport:Section(1)

Local aCampos   := {}
Local aEmAnalise:= {}
Local aSalAtu   := {}
Local aProducao := {}

Local lEmProcess:= .F.

Local cFiltro   := ""
Local cQuery    := ""
Local cArqTemp2 := ""
Local cAliasTop := "SD3"
Local cAliasSD3 := "SD3"
Local cArqTemp3 := CriaTrab(Nil,.F.)
Local cChaveAnt := ""
Local cAlmProc  := ""
Local cPeLocProc:= ""
Local cBkLocProc:= ""

Local nIndex    := 0
Local nQtMedia  := 0
Local nQtNeces  := 0
Local nQtde     := 0
Local nQtdeAcum := 0
Local nCusto    := 0
Local nPos      := 0
Local nX        := 0
Local nQtdOrigem:= 0
Local nQtdProduz:= 0
Local nTotReqDev:= 0
Local nTotReqCus:= 0

Local nProdPR0  := SuperGetMv("MV_PRODPR0",.F.,1)
Local lMT460EP  := SuperGetMv("MV_MT460EP",.F.,.F.)
Local lM460PRC  := SuperGetMv("MV_M460PRC",.F.,.F.)
Local lCusFIFO  := SuperGetMV("MV_CUSFIFO",.F.,.F.)
Local lTemp 	:= .F.
Local cLocProc  := GetMvNNR('MV_LOCPROC','99')
Local cProdMNT	:= SuperGetMv("MV_PRODMNT",.F.,'MANUTENCAO')

Local lA460AMZP := ExistBlock("A460AMZP")

Local nSaldo    := 0
Local nA        := 0

Local aD3Quant  := TamSX3("D3_QUANT")
Local aD3Custo1 := TamSX3("D3_CUSTO1")

Local oTmpTable := NIL

Default nQuebraAliq  := 1
Default lModProces   := .F.
Default lGraph       := .F.
Default lCalcProcDt  := .T.
Default lListCustMed := .T.
Default dDtFech      := CtoD('31/12/49')

//-- A460AMZP - Ponto de Entrada para considerar um armazen
//--            adicional como armazem de processo.
If lA460AMZP
	aA460AMZP := ExecBlock("A460AMZP",.F.,.F.,'')
	If ValType(aA460AMZP)=="A" .And. Len(aA460AMZP) == 1
		cBkLocProc := IIf(Valtype(aA460AMZP[1])=="C",aA460AMZP[1],'')
	EndIf	
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SALDO EM PROCESSO                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !oReport:Cancel()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria arquivo de Trabalho para armazenar as OPs               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	AADD(aCampos,{"OP"		,"C",TamSX3("D3_OP")[1]			,0}) // 01 - OP
	AADD(aCampos,{"SEQCALC"	,"C",TamSX3("D3_SEQCALC")[1]	,0}) // 02 - SEQCALC
	AADD(aCampos,{"DATA1"	,"D",8							,0}) // 03 - DATA1
	
	cArqTemp2 := GetNextAlias() 
	
	oTmpTable := FWTemporaryTable():New( cArqTemp2 )
	oTmpTable:SetFields( aCampos )
	oTmpTable:AddIndex("indice1", {"OP","SEQCALC","DATA1"} )
	oTmpTable:Create()

	If __cNumOP == NIL
		R989AtuVar()
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Busca saldo em processo                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SD3")
	dbSetOrder(1) // D3_FILIAL+D3_OP+D3_COD+D3_LOCAL

	cAliasTop := cArqTemp3
	cQuery := "SELECT D3_FILIAL, D3_OP, D3_COD, D3_LOCAL, D3_CF, D3_EMISSAO, D3_SEQCALC, C2_DATRF "
	cQuery += "FROM " +RetSqlName("SD3") +" SD3 "
	cQuery += "JOIN "+RetSqlName("SC2")+" SC2 "
	cQuery += "ON SC2.C2_FILIAL = '"+xFilial("SC2")+"' " 
	cQuery += "AND SC2.C2_NUM = " + __cNumOP + " AND "
	cQuery += "SC2.C2_ITEM = " + __cItemOP + " AND "
	cQuery += "SC2.C2_SEQUEN = " + __cSeqOP + " AND "
	cQuery += "SC2.C2_ITEMGRD = " + __cItGrdOP + " "
	cQuery += "AND (SC2.C2_DATRF = '"+DTOS(Criavar("C2_DATRF",.F.))+" ' "
	cQuery += "OR SC2.C2_DATRF > '" + DTOS(dDtFech) + " ') "
	cQuery += "AND SC2.C2_PRODUTO <> '"+cProdMNT+"' "
	cQuery += "AND SC2.D_E_L_E_T_ = ' ' "
	cQuery += "WHERE SD3.D3_FILIAL='" +xFilial("SD3") +"' "
	cQuery += "AND SD3.D3_OP <> '" +Criavar("D3_OP",.F.) + "' "
	cQuery += "AND (SD3.D3_CF ='PR0' OR SD3.D3_CF = 'PR1') "
	cQuery += "AND SD3.D3_EMISSAO <= '" + DTOS(dDtFech) +"' "		
	cQuery += "AND SD3.D3_ESTORNO = ' ' "
	cQuery += "AND SD3.D_E_L_E_T_ = ' '     
	cQuery += "UNION "
	cQuery += "SELECT D3_FILIAL, D3_OP, D3_COD, D3_LOCAL, D3_CF, D3_EMISSAO, D3_SEQCALC, C2_DATRF "
	cQuery += "FROM " +RetSqlName("SD3") +" SD3 "
	cQuery += "JOIN "+RetSqlName("SC2")+" SC2 "
	cQuery += "ON SC2.C2_FILIAL = '"+ xFilial("SC2")+"' "
	cQuery += "AND SC2.C2_NUM = " + __cNumOP + " AND "
	cQuery += "SC2.C2_ITEM = " + __cItemOP + " AND "
	cQuery += "SC2.C2_SEQUEN = " + __cSeqOP + " AND "
	cQuery += "SC2.C2_ITEMGRD = " + __cItGrdOP + " "
	cQuery += "AND (SC2.C2_DATRF = '"+DTOS(Criavar("C2_DATRF",.F.))+" ' "
	cQuery += "OR SC2.C2_DATRF > '"+ DTOS(dDtFech) +" ') "	
	cQuery += "AND SC2.C2_PRODUTO <> '"+cProdMNT+"' "
	cQuery += "AND SC2.D_E_L_E_T_ = ' ' "	
	cQuery += "WHERE SD3.D3_FILIAL='" + xFilial("SD3") +"' "
	cQuery += "AND SD3.D3_OP <> '" + Criavar("D3_OP",.F.) + "' "
	cQuery += "AND SD3.D3_COD >= '" + cProdIni +"' "
	cQuery += "AND SD3.D3_COD <= '" + cProdFim +"' "
	cQuery += "AND SD3.D3_CF <>'PR0' AND SD3.D3_CF <>'PR1' "
	cQuery += "AND SD3.D3_EMISSAO <= '" + DTOS(dDtFech) +"' "
	cQuery += "AND SD3.D3_ESTORNO = ' ' "
	cQuery += "AND SD3.D_E_L_E_T_ = ' ' "
			
	If TCGETDB() = 'OPENEDGE'
		cQuery += "ORDER BY 1,2,3,4"
	Else
	    cQuery += "ORDER BY "+SqlOrder(SD3->(IndexKey()))
	EndIf
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTemp3,.T.,.T.)

	TcSetField(cAliasTop,"D3_EMISSAO","D",8,0)


	oReport:SetMeter(SD3->(LastRec()))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Armazena OPs e data de emissao no Arquivo de Trabalho        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While !Eof() .And. !oReport:Cancel()

		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf
		
		// Verifica se o Produto e Valido
		If !Empty(cProdFim) .And. (cAliasTop)->D3_COD > cProdFim .And.;
			SubStr((cAliasTop)->D3_CF,1,2) != "PR"
			Exit
		EndIf
		
		If ( (cAliasTop)->D3_COD < cProdIni .Or. (cAliasTop)->D3_COD > cProdFim .Or. ( IsProdMod((cAliasTop)->D3_COD) .And. !lModProces ) ) .And. SubStr((cAliasTop)->D3_CF,1,2) != "PR"
			dbSkip()
			Loop
		EndIf

		// Armazena OPs e Data de Emissao
		dbSelectArea(cArqTemp2)
		If dbSeek((cAliasTop)->D3_OP)
			RecLock(cArqTemp2,.F.)
		Else
			RecLock(cArqTemp2,.T.)
			Replace OP with (cAliasTop)->D3_OP
		EndIf
		If SubStr((cAliasTop)->D3_CF,1,2) == "PR"
			Replace DATA1 with Max((cAliasTop)->D3_EMISSAO,DATA1)
			If !lCalcProcDt .And. ((cAliasTop)->D3_SEQCALC > SEQCALC)
				Replace SEQCALC With (cAliasTop)->D3_SEQCALC
			EndIf
		EndIf
		MsUnlock()
		dbSelectArea(cAliasTop)
		dbSkip()
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Restaura ambiente e apaga arquivo temporario                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cAliasTop)
	dbCloseArea()
	dbSelectArea("SD3")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gravacao do Saldo em Processo                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cArqTemp2)
	dbGotop()

	oReport:SetMeter((cArqTemp2)->(LastRec()))

	While !Eof() .And. !oReport:Cancel()
	
		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf

		aProducao := {}
		aEmAnalise:= {}
		nTotReqDev:= 0
		nTotReqCus:= 0

		dbSelectArea("SD3")
		dbSetOrder(1)
		cAliasSD3 := GetNextAlias()
		cQuery := "SELECT SD3.D3_FILIAL, SD3.D3_OP, SD3.D3_COD, SD3.D3_LOCAL, SD3.D3_CF, SD3.D3_EMISSAO, "
		cQuery += "SD3.D3_SEQCALC, SD3.D3_CUSTO1, SD3.D3_SEQCALC, SD3.D3_QUANT, SD3.D3_ESTORNO, SD3.D3_PERDA,SD3.D3_TRT, SD3.D3_RATEIO , SD3.R_E_C_N_O_ RECNOSD3 "
		cQuery += "FROM "+RetSqlName("SD3")+" SD3 "
		cQuery += "WHERE SD3.D3_FILIAL='"+xFilial("SD3")+"' "
		cQuery += "AND SD3.D3_OP = '" + (cArqTemp2)->OP + "' "
		cQuery += "AND SD3.D3_EMISSAO <= '" + DTOS(dDtFech) + "' "
		cQuery += "AND SD3.D3_LOCAL >= '" + cAlmoxIni + "' AND SD3.D3_LOCAL <= '" + cAlmoxFim + "' "
		cQuery += "AND SD3.D3_COD >= '" + cProdIni +"' "
		cQuery += "AND SD3.D3_COD <= '" + cProdFim +"' "
		cQuery += "AND SD3.D3_ESTORNO = ' ' "
		cQuery += "AND SD3.D3_CF NOT IN ('PR0', 'PR1')"
		cQuery += "AND SD3.D_E_L_E_T_ = ' ' "
		cQuery += "UNION "
		cQuery += "SELECT SD3.D3_FILIAL, SD3.D3_OP, SD3.D3_COD, SD3.D3_LOCAL, SD3.D3_CF, SD3.D3_EMISSAO, "
		cQuery += "SD3.D3_SEQCALC, SD3.D3_CUSTO1, SD3.D3_SEQCALC, SD3.D3_QUANT, SD3.D3_ESTORNO, SD3.D3_PERDA,SD3.D3_TRT, SD3.D3_RATEIO , SD3.R_E_C_N_O_ RECNOSD3 "
		cQuery += "FROM "+RetSqlName("SD3")+" SD3 "
		cQuery += "WHERE SD3.D3_FILIAL='" + xFilial("SD3") +"' "
		cQuery += "AND SD3.D3_ESTORNO = ' ' "
	   	cQuery += "AND SD3.D3_CF IN ('PR0', 'PR1')  "
		cQuery += "AND SD3.D3_EMISSAO <= '" + DTOS(dDtFech) + "' "
		cQuery += "AND SD3.D3_LOCAL >= '" + cAlmoxIni + "' AND SD3.D3_LOCAL <= '" + cAlmoxFim + "' "
		cQuery += "AND SD3.D3_OP = '" + (cArqTemp2)->OP + "' "
		cQuery += "ORDER BY " + SqlOrder(SD3->(IndexKey()))

		cQuery := ChangeQuery(cQuery)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD3,.T.,.T.)

		TcSetField(cAliasSD3,"D3_EMISSAO","D",8,0)
		TcSetField(cAliasSD3,"D3_QUANT","N",aD3Quant[1],aD3Quant[2])
		TcSetField(cAliasSD3,"D3_CUSTO1","N",aD3Custo1[1],aD3Custo1[2])


		oReport:SetMeter(SD3->(LastRec()))
		
		While !Eof() .And. !oReport:Cancel() 

			oReport:IncMeter()
			If oReport:Cancel()
				Exit
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Somatoria de todos os apontamentos de producao para esta OP          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If SubStr((cAliasSD3)->D3_CF,1,2) == "PR"
				nPos:=Ascan(aProducao,{|x|x[1]==(cAliasSD3)->D3_COD})
				If nPos==0
					AADD(aProducao,{(cAliasSD3)->D3_COD,(cAliasSD3)->D3_QUANT,(cAliasSD3)->D3_CUSTO1,(cAliasSD3)->D3_PERDA,(cAliasSD3)->D3_RATEIO})
				Else
					aProducao[nPos,2] += (cAliasSD3)->D3_QUANT
					aProducao[nPos,3] += (cAliasSD3)->D3_CUSTO1
					aProducao[nPos,4] += (cAliasSD3)->D3_PERDA
					aProducao[nPos,5] += (cAliasSD3)->D3_RATEIO
				EndIf
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Validacao para o local                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If (cAliasSD3)->D3_LOCAL < cAlmoxIni .Or. (cAliasSD3)->D3_LOCAL > cAlmoxFim
				dbSkip()
				Loop
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Validacao para o Produto                                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If (cAliasSD3)->D3_COD < cProdIni .Or. (cAliasSD3)->D3_COD > cProdFim .Or. ( !lModProces .And. IsProdMod((cAliasSD3)->D3_COD) )
				dbSkip()
				Loop
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Somatoria das Requisicoes para Ordem de Producao                     |
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If SubStr((cAliasSD3)->D3_CF,1,2) == "RE"
				AADD(aEmAnalise,{	(cAliasSD3)->D3_COD								,;	// 01 - Codigo do produto
									(cAliasSD3)->D3_LOCAL							,;	// 02 - Codigo do Armazem
									(cAliasSD3)->D3_QUANT							,;	// 03 - Quantidade
									(cAliasSD3)->D3_CUSTO1							,;	// 04 - Custo na moeda 1
									(cAliasSD3)->RECNOSD3							,;	// 05 - Recno da tabela SD3
									"RE" 											 	,;	// 06 - Tipo de movimento RE/DE
									(cAliasSD3)->D3_TRT								;	// 07 - Sequencia da estrutura 	
								})

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Somatoria das Devolucoes para Ordem de Producao                      |
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			ElseIf SubStr((cAliasSD3)->D3_CF,1,2) == "DE"
				AADD(aEmAnalise,{	(cAliasSD3)->D3_COD								,;	// 01 - Codigo do produto
									(cAliasSD3)->D3_LOCAL							,;	// 02 - Codigo do Armazem	
									(cAliasSD3)->D3_QUANT        		     		,;	// 03 - Quantidade
									(cAliasSD3)->D3_CUSTO1               		,;	// 04 - Custo na moeda 1
									(cAliasSD3)->RECNOSD3							,;	// 05 - Recno da tabela SD3
									"DE" 												,;	// 06 - Tipo de movimento RE/DE	
									(cAliasSD3)->D3_TRT								;	// 07 - Sequencia da estrutura 	
								})

			EndIf
			dbSelectArea(cAliasSD3)
			dbSkip()

		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ ANALISE DE SALDO EM PROCESSO EM ABERTO                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
		oSection1:Init()

		//-- Posiciona tabela SC2
		SC2->(dbSetOrder(1))
		If SC2->(C2_FILIAL+C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)#(xFilial("SC2")+(cArqTemp2)->OP)
			SC2->(MsSeek(xFilial("SC2")+(cArqTemp2)->OP))
		EndIf

		If SC2->(C2_FILIAL+C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)==(xFilial("SC2")+(cArqTemp2)->OP)
				
				nSaldo := 0 
									
				If Len(aEmAnalise) > 0 
				
					For nA := 1 To Len(aEmAnalise)
							
						nSaldo += IIf(aEmAnalise[nA,6] == "RE",  aEmAnalise[nA][3], 0 )
						nSaldo += IIf(aEmAnalise[nA,6] == "DE", -aEmAnalise[nA][3], 0 )
						nSaldo += IIf(aEmAnalise[nA,6] == "PR", -aEmAnalise[nA][3], 0 )
							
					Next
				
				EndIf
				
				If Len(aProducao) > 0
					For nA := 1 To Len(aProducao)
						nSaldo += IIf((aProducao[nA,2] + aProducao[nA,4]) > 0, (aProducao[nA,2] + aProducao[nA,4]) * -1, 0 )
					Next
				EndIf
				
				//-- Requisicao para Ordem de Producao
				If Len(aEmAnalise) > 0 

					//-- Apontamento de producao
					If Len(aProducao) > 0
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//| ANALISE DO SALDO EM PROCESSO ATRAVES DO PARAMETRO MV_PRODPR0      |
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If lMT460EP
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//| Calculo da proporcao a ser utilizada no saldo em processo         |
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				            If nProdPR0 == 1
									//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
									//| Neste metodo todo o custo e consumido nos primeiros apontamentos  |
									//| de producao, por isso nao existe custo somente quantidade em      |
									//| processo.                                                         |
									//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				            		nProporcao := 0 
							ElseIf nProdPR0 == 2
								nProporcao := 1 - (aProducao[Len(aProducao),5] / 100)
								//-- Neste metodo e utilizado o conceito de proporcionalizacao	

				            ElseIf nProdPR0 == 3
									//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
									//| Neste metodo e utilizado o conceito de proporcionalizacao         |
									//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
									//-- Quantidade aAberta para producao menos a perda
									nQtdOrigem := SC2->C2_QUANT - SC2->C2_PERDA
									//-- Quantidade produzida menos a perda
									nQtdProduz := aProducao[Len(aProducao),2] - aProducao[Len(aProducao),4] 
									//-- Proporcao para custeio do saldo em processo									
				            	    nProporcao := 1 - ( nQtdProduz / nQtdOrigem )
				            EndIf
				            
								For nX := 1 To Len(aEmAnalise)
									lTemp := .F.
									dbSelectArea("SD4")
									dbSetOrder(2)
									If cChaveAnt != (cArqTemp2)->OP+aEmAnalise[nX,1]+aEmAnalise[nX,2]+aEmAnalise[nX,7]
										cChaveAnt := (cArqTemp2)->OP+aEmAnalise[nX,1]+aEmAnalise[nX,2]+aEmAnalise[nX,7]
										nTotReqDev  := 0
										nTotReqCus 	:= 0
										nQtde       := 0
										nQtdeAcum   := 0
									EndIf
									If dbSeek(xFilial("SD4")+(cArqTemp2)->OP+aEmAnalise[nX,1]+aEmAnalise[nX,2])
										lTemp := .T.
									EndIf
									If lTemp
										While SD4->(!Eof()) .And. SD4->(D4_FILIAL+D4_OP+D4_COD+D4_LOCAL) == (xFilial("SD4")+(cArqTemp2)->OP+aEmAnalise[nX,1]+aEmAnalise[nX,2])
											If aEmAnalise[nX,7]== SD4->D4_TRT
												Exit
											EndIf
											SD4->(dbSkip())
										End
										//-- Quantidade Media por Producao
										If Rastro(SC2->C2_PRODUTO)
											nQtMedia  := M460MdPrc(SD4->D4_COD,SD4->D4_OP,SD4->D4_LOCAL,SC2->C2_QUANT,SD4->D4_TRT)
										Else
											nQtMedia  := SD4->D4_QTDEORI / SC2->C2_QUANT
										EndIf
									Else 
										nQtMedia := aEmAnalise[nX,3] / (SC2->C2_QUANT - SC2->C2_PERDA)
									EndIf
		   							//-- Flag utilizado para gravar saldo em processo
									lEmProcess := .F.
								
		                	   //-- Quantidade necessaria para producao da quantidade apontada
		    						 nQtNeces  := (aProducao[1,2] + aProducao[1,4]) * nQtMedia
		    					
		    						If aEmAnalise[nX,6] == "RE"
		    							If lTemp
											nTotReqDev  += aEmAnalise[nX,3]
											nTotReqCus	+= aEmAnalise[nX,4]
										Else
											nTotReqDev  := aEmAnalise[nX,3]
											nTotReqCus	:= aEmAnalise[nX,4]
										Endif	
	    							Else
	    								nTotReqDev  := -aEmAnalise[nX,3]
										nTotReqCus	:= -aEmAnalise[nX,4]
	    							EndIf
		    					
		    						//-- Avalia quantidade em processo
		    						If aEmAnalise[nX,6] == "DE"
										If nProdPR0 == 1
			    							lEmProcess := .F.
										Else		    						
											lEmProcess := .T.
											nQtdeAcum  += nQtde
											nQtde      := -aEmAnalise[nX,3]
											nCusto     := -aEmAnalise[nX,4]
										EndIF
									ElseIf nTotReqDev > nQtNeces
										If nProdPR0 == 1
			    							lEmProcess := .F.
										Else
											lEmProcess := .T.
											nQtdeAcum  += nQtde
											If lTemp
												nQtde      	:= nTotReqDev - (nQtNeces + nQtdeAcum)
											Else
												nQtde      := nTotReqDev - nQtNeces
											Endif
											nCusto		:= nTotReqCus * nProporcao
										EndIf	
							   		EndIf
									
									//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
									//³ GRAVA SALDO EM PROCESSO                                               ³
									//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
									If lEmProcess .And. (aEmAnalise[nX,1] >= cProdIni .And. aEmAnalise[nX,1] <= cProdFim)
										// Posiciona tabela SB1
										If SB1->B1_COD!=aEmAnalise[nX,1]
											SB1->(MsSeek(xFilial("SB1")+aEmAnalise[nX,1]))
										EndIf
									If SB1->B1_COD==aEmAnalise[nX,1]
										dbSelectArea("SD3")
										MsGoto(aEmAnalise[nX,5])
										oSection1:Cell("B1_COD"   ):setValue(SB1->B1_COD)
										oSection1:Cell("B1_DESC"  ):setValue(SB1->B1_DESC)
										oSection1:Cell("B1_UM"    ):setValue(SB1->B1_UM)
										oSection1:Cell("D3_LOCAL" ):setValue(SD3->D3_LOCAL)
										oSection1:Cell("D3_OP"    ):setValue(SD3->D3_OP)
										oSection1:Cell("D3_CF"    ):setValue(SD3->D3_CF)
										oSection1:Cell("D3_QUANT" ):setValue(nQtde)
										oSection1:Cell("D3_CUSTO1"):setValue(nCusto)
										oSection1:PrintLine()		
									 EndIf
								EndIf
							Next aEmAnalise
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//| ANALISE DO SALDO EM PROCESSO ATRAVES DA QUANTIDADE (PADRAO)       |
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			        	Else
							For nX := 1 To Len(aEmAnalise)
								lTemp := .F.
								dbSelectArea("SD4")
								dbSetOrder(2)
								If cChaveAnt != (cArqTemp2)->OP+aEmAnalise[nX,1]+aEmAnalise[nX,2]+aEmAnalise[nX,7]
									cChaveAnt := (cArqTemp2)->OP+aEmAnalise[nX,1]+aEmAnalise[nX,2]+aEmAnalise[nX,7]
									nTotReqDev  := 0
									nTotReqCus	:= 0
									nQtde       := 0
									nQtdeAcum   := 0
								EndIf
								If dbSeek(xFilial("SD4")+(cArqTemp2)->OP+aEmAnalise[nX,1]+aEmAnalise[nX,2])
									lTemp := .T.
								EndIf
								If lTemp
									While SD4->(!Eof()) .And. SD4->(D4_FILIAL+D4_OP+D4_COD+D4_LOCAL) == (xFilial("SD4")+(cArqTemp2)->OP+aEmAnalise[nX,1]+aEmAnalise[nX,2])
										If aEmAnalise[nX,7]== SD4->D4_TRT
											Exit
										EndIf
										SD4->(dbSkip())
									End
									//-- Quantidade Media por Producao
									If Rastro(SC2->C2_PRODUTO)
										nQtMedia  := M460MdPrc(SD4->D4_COD,SD4->D4_OP,SD4->D4_LOCAL,SC2->C2_QUANT,SD4->D4_TRT)
									Else
										nQtMedia  := SD4->D4_QTDEORI / SC2->C2_QUANT
									EndIf									
								Else 
									nQtMedia := aEmAnalise[nX,3] / (SC2->C2_QUANT - SC2->C2_PERDA)
								EndIf
								//-- Flag utilizado para gravar saldo em processo
								lEmProcess := .F.
		                   //-- Quantidade necessaria para producao da quantidade apontada
		    					nQtNeces  := aProducao[1,2] * nQtMedia

	    						If aEmAnalise[nX,6] == "RE"
	    							If lTemp
										nTotReqDev  += aEmAnalise[nX,3]
										nTotReqCus  += aEmAnalise[nX,4]
									Else
										nTotReqDev  := aEmAnalise[nX,3]
										nTotReqCus  := aEmAnalise[nX,4]
									Endif	
	    						Else
	    							nTotReqDev  := -aEmAnalise[nX,3]
									nTotReqCus 	:= -aEmAnalise[nX,4]
	    						EndIf
	    						//-- Avalia quantidade em processo
	    						If aEmAnalise[nX,6] == "DE"
									lEmProcess := .T.
									nQtdeAcum  += nQtde
									nQtde      := -aEmAnalise[nX,3]
									nCusto     := -aEmAnalise[nX,4]
								ElseIf nTotReqDev > nQtNeces
									lEmProcess := .T.
									nQtdeAcum  += nQtde
									If lTemp
										nQtde      := nTotReqDev - (nQtNeces + nQtdeAcum)
									Else
										nQtde      := nTotReqDev - nQtNeces
									Endif
									nCusto     := (nTotReqCus / nTotReqDev) * nQtde
							   EndIf
								
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ GRAVA SALDO EM PROCESSO                                               ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							 	If lEmProcess .And. (aEmAnalise[nX,1] >= cProdIni .And. aEmAnalise[nX,1] <= cProdFim)
									// Posiciona tabela SB1
									If SB1->B1_COD!=aEmAnalise[nX,1]
										SB1->(MsSeek(xFilial("SB1")+aEmAnalise[nX,1]))
									EndIf
			
									If SB1->B1_COD==aEmAnalise[nX,1]
										dbSelectArea("SD3")
										MsGoto(aEmAnalise[nX,5])
										oSection1:Cell("B1_COD"   ):setValue(SB1->B1_COD)
										oSection1:Cell("B1_DESC"  ):setValue(SB1->B1_DESC)
										oSection1:Cell("B1_UM"    ):setValue(SB1->B1_UM)
										oSection1:Cell("D3_LOCAL" ):setValue(SD3->D3_LOCAL)
										oSection1:Cell("D3_OP"    ):setValue(SD3->D3_OP)
										oSection1:Cell("D3_CF"    ):setValue(SD3->D3_CF)
										oSection1:Cell("D3_QUANT" ):setValue(Abs(nQtde))
										oSection1:Cell("D3_CUSTO1"):setValue(Abs(nCusto))
									 	oSection1:PrintLine()		
									EndIf
							 	EndIf
							Next aEmAnalise
	 		           EndIf
					Else
						//-- Considera todo o saldo requisitado para Ordem de Producao como saldo em processo
						For nX := 1 to Len(aEmAnalise)
							If aEmAnalise[nX,1] >= cProdIni .And. aEmAnalise[nX,1] <= cProdFim
							// Posiciona tabela SB1
								If SB1->B1_COD!=aEmAnalise[nX,1]
									SB1->(MsSeek(xFilial("SB1")+aEmAnalise[nX,1]))
								EndIf
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ GRAVA SALDO EM PROCESSO                                               ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
								If SB1->B1_COD==aEmAnalise[nX,1]
									dbSelectArea("SD3")
									MsGoto(aEmAnalise[nX,5])
									oSection1:Cell("B1_COD"   ):setValue(SB1->B1_COD)
									oSection1:Cell("B1_DESC"  ):setValue(SB1->B1_DESC)
									oSection1:Cell("B1_UM"    ):setValue(SB1->B1_UM)
									oSection1:Cell("D3_LOCAL" ):setValue(SD3->D3_LOCAL)
									oSection1:Cell("D3_OP"    ):setValue(SD3->D3_OP)
									oSection1:Cell("D3_CF"    ):setValue(SD3->D3_CF)
									oSection1:Cell("D3_QUANT" ):setValue(SD3->D3_QUANT)
									oSection1:Cell("D3_CUSTO1"):setValue(SD3->D3_CUSTO1)
							 		oSection1:PrintLine()		
								EndIf
							EndIf
				    	Next aEmAnalise
					EndIf
				EndIf
			EndIf

	dbSelectArea(cAliasSD3)
	dbCloseArea()

		dbSelectArea(cArqTemp2)
		dbSkip()
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apaga arquivos temporarios                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oTmpTable:Delete()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime saldo no armazem de processo ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If mv_par09 == 1
	
		cAliasSB1 := GetNextAlias()
		cQuery := "SELECT * "
		cQuery += "FROM " +RetSqlName("SB1") +" SB1 "
		cQuery += "WHERE SB1.B1_FILIAL='" +xFilial("SB1") +"' "
		cQuery += " AND SB1.B1_COD >= '" + mv_par01 +"' "
		cQuery += " AND SB1.B1_COD <= '" + mv_par02 +"' "
		If !lM460PRC
			// considero somente o que for indireto
			cQuery += " AND SB1.B1_APROPRI = 'I' "
		EndIf
		cQuery += " AND SB1.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSB1,.T.,.T.)

		While !(cAliasSB1)->(EOF()) .And. !lEnd
	
			If !lGraph .And. Interrupcao(@lEnd)
				Exit
			EndIf
	
			If mv_par08 == 1
				aSalatu := CalcEst((cAliasSB1)->B1_COD,cLocProc,mv_par06+1,nil)
			Else
				aSalatu := CalcEstFF((cAliasSB1)->B1_COD,cLocProc,mv_par06+1,nil)
			EndIf
			          
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ GRAVA SALDO EM PROCESSO                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			oSection1:Cell("B1_COD"   ):setValue((cAliasSB1)->B1_COD)
			oSection1:Cell("B1_DESC"  ):setValue((cAliasSB1)->B1_DESC)
			oSection1:Cell("B1_UM"    ):setValue((cAliasSB1)->B1_UM)
			oSection1:Cell("D3_LOCAL" ):setValue(cLocProc)
			oSection1:Cell("D3_OP"    ):setValue("")
			oSection1:Cell("D3_CF"    ):setValue("")
			oSection1:Cell("D3_QUANT" ):setValue(aSalAtu[1])
			oSection1:Cell("D3_CUSTO1"):setValue(aSalAtu[2])
		 	oSection1:PrintLine()
	
			//-- A460AMZP - Ponto de entrada utilizado para definir um armazem
			//--            padrao como armazem de processo.
			cPeLocProc := cBkLocProc
			If !Empty(cPeLocProc)
				While !Empty(cPeLocProc)
					cAlmProc   := SubStr(cPeLocProc,1,At("/",cPeLocProc)-1)
					cPeLocProc := SubStr(cPeLocProc,At("/",cPeLocProc)+1)
					If !Empty(cAlmProc)
						If mv_par08 == 1
							aSalatu:=CalcEst((cAliasSB1)->B1_COD,cAlmProc,mv_par06+1,nil)
						Else
							aSalatu:=CalcEstFF((cAliasSB1)->B1_COD,cAlmProc,mv_par06+1,nil)
						EndIf
				
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ GRAVA SALDO EM PROCESSO                                               ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
						oSection1:Cell("B1_COD"   ):setValue((cAliasSB1)->B1_COD)
						oSection1:Cell("B1_DESC"  ):setValue((cAliasSB1)->B1_DESC)
						oSection1:Cell("B1_UM"    ):setValue((cAliasSB1)->B1_UM)
						oSection1:Cell("D3_LOCAL" ):setValue(cLocProc)
						oSection1:Cell("D3_OP"    ):setValue("")
						oSection1:Cell("D3_CF"    ):setValue("")
						oSection1:Cell("D3_QUANT" ):setValue(aSalAtu[1])
						oSection1:Cell("D3_CUSTO1"):setValue(aSalAtu[2])
		 				oSection1:PrintLine()
					Else
						Exit
					EndIf	
				End
			EndIf
			
			(cAliasSB1)->(dbSkip())
		End
		
		// Encerra a area de trabalho temporaria
		(cAliasSB1)->(dbCloseArea())
		
	EndIf
	
	oSection1:Finish()
	
EndIf

Return Nil

/*/{Protheus.doc} R989AtuVar
Função responsável por inicializar as variáveis staticas
@author Squad Entradas
@since 06/04/2022
/*/
Static Function R989AtuVar()
Local nNumOP   := TamSX3("C2_NUM")[1]
Local nItemOP  := TamSX3("C2_ITEM")[1]
Local nSeqOP   := TamSX3("C2_SEQUEN")[1]
Local nItGrdOP := TamSX3("C2_ITEMGRD")[1]
Local cSubstr  := If(TCGetDB() $ "ORACLE/POSTGRES","SUBSTR","SUBSTRING")

__cNumOP   := cSubstr + "(D3_OP,1," + cValToChar(nNumOP) + ")"
__cItemOP  := cSubstr + "(D3_OP," + cValToChar(nNumOP + 1) + "," + cValToChar(nItemOP) + ")"
__cSeqOP   := cSubstr + "(D3_OP," + cValToChar(nNumOP + nItemOP + 1) + "," + cValToChar(nSeqOP) + ")"
__cItGrdOP := cSubstr + "(D3_OP," + cValToChar(nNumOP + nItemOP + nSeqOP + 1) + "," + cValToChar(nItGrdOP) + ")"

Return
