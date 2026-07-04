/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR430.CH"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR430  ³ Autor ³ Ricardo Berti         ³ Data ³07.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao da Planilha de Formacao de Precos                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Matr430()

Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Ricardo Berti 		³ Data ³07.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR430                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local cPerg     := "MTR430"
Local oReport
Local oSection
Local cPicQuant := PesqPictQt("G1_QUANT",13)
Local cPicUnit  := PesqPict("SB1","B1_CUSTD",18)
Local cPicTot   := PesqPict("SB1","B1_CUSTD",19)

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
oReport := TReport():New("MATR430",STR0004,cPerg, {|oReport| ReportPrint(oReport)},STR0001+" "+STR0002+" "+STR0003)  	//"Emite um relatorio com os calculos da planilha selecionada pa-"##"ra cada produto. Os valores calculados sao os mesmos  referen-"###"tes as formulas da planilha."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // Produto inicial                              ³
//³ mv_par02     // Produto final                                ³
//³ mv_par03     // Nome da planilha utilizada                   ³
//³ mv_par04     // Imprime estrutura : Sim / Nao                ³
//³ mv_par05     // Moeda Secundaria  : 1 2 3 4 5                ³
//³ mv_par06     // Nivel de detalhamento da estrutura           ³
//³ mv_par07     // Qual a Quantidade Basica                     ³
//³ mv_par08     // Considera Qtde Neg na estrutura: Sim/Nao     ³
//³ mv_par09     // Considera Estrutura / Pre Estrutura          ³
//³ mv_par10     // Revisao da Estrutura 				         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Forca utilizacao da estrutura caso nao tenha SGG               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Select("SGG") == 0
	mv_par09 := 1
EndIf
oSection := TRSection():New(oReport,STR0015,{"SB1"}) //"Produtos"
oSection:SetHeaderPage()

TRCell():New(oSection,"CEL"		,"",STR0012/*Titulo*/,"99999"/*Picture*/,5/*Tamanho*/,/*lPixel*/,/*{|| Code block }*/) //"Cel."
TRCell():New(oSection,"NIVEL"	,"",RetTitle("G1_NIV"),"XXXXXX",6)
TRCell():New(oSection,"B1_COD"	,"SB1")
TRCell():New(oSection,"B1_DESC"	,"SB1",,,30)
TRCell():New(oSection,"B1_UM"	,"SB1")
TRCell():New(oSection,"QUANT"	,"",RetTitle("G1_QUANT"),cPicQuant)
TRCell():New(oSection,"VALUNI"	,"",STR0013,cPicUnit) //"Valor Unitario"
TRCell():New(oSection,"VALTOT"	,"",STR0014,cPicTot) //"Valor Total"
TRCell():New(oSection,"VALUNI2" ,"",STR0013,cPicUnit) //"Valor Unitario"
TRCell():New(oSection,"VALTOT2" ,"",STR0014,cPicTot) //"Valor Total"
TRCell():New(oSection,"PERCENT","",STR0009,"999.999",7) //"% Part"

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Ricardo Berti 		³ Data ³07.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local aArray	:= {}
Local aArray1	:= {}
Local aPar		:= Array(20)
Local aParC010	:= Array(20)
Local lFirstCb	:= .T.
Local nReg
Local nI, nX
Local oSection  := oReport:Section(1)
LOCAL cCondFiltr:= ""
Local lProdBlq := .T.
Local lRevPlan := SuperGetMV("MV_REVPLAN",.F.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis privadas exclusivas deste programa                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cProg:="R430"  // Usada na funcao externa MontStru()
Private cProduto

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Custo a ser considerado nos calculos                           ³
//³ 1 = STANDARD    2 = MEDIO     3 = MOEDA2     4 = MOEDA3        ³
//³ 5 = MOEDA4      6 = MOEDA5    7 = ULTPRECO   8 = PLANILHA      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQualCusto := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vetor declarado para inversao do calculo do Valor Unitario   ³
//³ Utilizado no MATC010X -> M010Forma e CalcTot                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aAuxCusto

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nome do arquivo que contem a memoria de calculo desta planilha ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cArqMemo := "STANDARD"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Direcao do calculo .T. para baixo .F. para cima                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE lDirecao := .T.

PRIVATE lConsNeg := (mv_par08 = 1)     // Esta variavel sera' usada na funcao MC010FORMA

//Salvar variaveis existentes
For ni := 1 to 20
	aPar[ni] := &("mv_par"+StrZero(ni,2))
Next ni

Pergunte("MTC010", .F.)
lProdBlq := Iif(!Empty(mv_par13),mv_par13 == 2,.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Forca utilizacao da estrutura caso nao tenha SGG               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Select("SGG") == 0
	mv_par09 := 1
EndIf
//Salvar variaveis existentes
For ni := 1 to 20
	aParC010[ni] := &("mv_par"+StrZero(ni,2))
Next ni
//Forca mesmo valor do relatorio na pergunta 09
mv_par09     := aPar[09]
aParC010[09] := aPar[09]

// Restaura parametros MTR430
For ni := 1 to 20
	&("mv_par"+StrZero(ni,2)) := aPar[ni]
Next ni

cProduto := ""

oReport:NoUserFilter()  // Desabilita a aplicacao do filtro do usuario no filtro/query das secoes

dbSelectArea("SB1")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao Advpl                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeAdvplExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mantem o Cad.Produtos posicionado para cada linha impressa da planilha   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSection,"SB1",1,{|| xFilial("SB1") + cProduto })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa o nome padrao da planilha com o nome selecionado pelo usuario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqMemo := apar[03]

If U_MR430Plan(.T.,aPar)

	If apar[05] == 1
		oSection:Cell("VALUNI2"):Disable()
		oSection:Cell("VALTOT2"):Disable()
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicio da impressao do fluxo do relatorio                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SetMeter(SB1->(LastRec()))

	oSection:Init()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Este procedimento e' necessario p/ transformar o filtro selecionado  ³
	//³ pelo usuario em uma condicao de IF, isto porque o filtro age em todo ³
	//³ o arquivo e devido `a posterior explosao de niveis da estrutura, em  ³
	//³ MATC010X-> M010Forma(), o filtro deve ser validado apenas no While   ³
	//³ principal															 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCondFiltr := oSection:GetAdvplExp()
	If Empty(cCondFiltr)
		cCondFiltr := ".T."
	EndIf

	dbSeek(xFilial("SB1")+apar[01],.T.)
	While !oReport:Cancel() .And. !SB1->(Eof()) .And. ;
		SB1->B1_FILIAL == xFilial("SB1") .And. SB1->B1_COD <= apar[02]
		If oReport:Cancel()
			Exit
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro escolhido                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If &(cCondFiltr)
			nReg := Recno()
			// Restaura parametros MTC010
			For ni := 1 to 20
				&("mv_par"+StrZero(ni,2)) := aParc010[ni]
			Next ni

			If lRevPlan
				aArray1 := MC010Form2("SB1"	,	nReg,	99	 ,apar[07]	,		,.F.	,apar[10]	,			,		,		,cArqMemo	,lProdBlq)
						 //MC010Form2(cAlias,	nReg,	nOpcx,nQtdBas	,nTipo	,lMostra,cRevExt	,	lPesqR	,cCodP	,cCodR	,cPlan		,lProdBlq)
			Else
				aArray1 := MC010Forma("SB1"		,nReg	,99		,apar[07]	,		,	.F.		,apar[10]	,cArqMemo	,lProdBlq)
						 //MC010Forma(cAlias	,nReg	,nOpcx	,nQtdBas	,nTipo	,lMostra	,cRevExt	,cPlan		,lProdBlq)
			EndIf
			// Restaura parametros MTR430
			For ni := 1 to 20
				&("mv_par"+StrZero(ni,2)) := aPar[ni]
			Next ni

			If Len(aArray1) > 0
				aArray	:= aClone(aArray1[2])
				U_MR430ImpTR(aArray1[1],aArray1[2],aArray1[3],oReport,aPar,aParC010,@nx,@lFirstCb)
			EndIf

			dbSelectArea("SB1")
			dbGoTo(nReg)
		EndIf
		dbSkip()
		oReport:IncMeter()
	EndDo
	oSection:Finish()
EndIf
dbSelectArea("SB1")
dbClearFilter()
dbSetOrder(1)

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MR430ImpTR³ Autor ³ Ricardo Berti 		³ Data ³07.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados ja' calculados                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MR430ImpTR(ExpC1,ExpA1,ExpN1,ExpO1,ExpA2,ExpA3,ExpN2)      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Titulo do custo utilizado                          ³±±
±±³          ³ ExpA1 = Array com os dados ja' calculados                  ³±±
±±³          ³ ExpN1 = Numero do elemento inicial a imprimir              ³±±
±±³          ³ ExpO1 = obj Report                                         ³±±
±±³          ³ ExpA2 = Array com os parametros de MTR430                  ³±±
±±³          ³ ExpA2 = Array com os parametros de MTC010                  ³±±
±±³          ³ ExpN2 = elemento do aArray, passado por referencia		  ³±±
±±³          ³ ExpL1 = indica primeiro acesso, para montagem de cabec.	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR430                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MR430ImpTR(cCusto,aArray,nPosForm,oReport,aPar,aParC010,nX,lFirstCb)

Local oSection  := oReport:Section(1)
LOCAL cMoeda1,cMoeda2
LOCAL nDecimal	:=0
Local lFirst	:= .T.
Local cOldAlias
Local nOrder
Local nRecno
Local nValUnit, nCotacao
Local cTit1,cTit2,cTit3,cTit4

DEFAULT lFirstCb := .T.

cCusto := If(cCusto=Nil,'',AllTrim(Upper(cCusto)))
If cCusto == 'ULT PRECO'
	nDecimal := TamSX3('B1_UPRC')[2]
ElseIf 'MEDIO' $ cCusto
	nDecimal := TamSX3('B2_CM1')[2]
Else
	nDecimal := TamSX3('B1_CUSTD')[2]
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ De acordo com o custo da planilha lida monta a cotacao de    ³
//³ conversao e a variavel cMoeda1 usada no cabecalho.           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Str(nQualCusto,1) $ "3/4/5/6"
	nCotacao:=ConvMoeda(dDataBase,,1,Str(nQualCusto-1,1))
	cMoeda1	:=GetMV("MV_SIMB"+Str(nQualCusto-1,1,0))
	If Empty(cMoeda1)
		cMoeda1	:=GetMV("MV_MOEDA"+Str(nQualCusto-1,1,0))
	EndIf
Else
	nCotacao:=1
	cMoeda1	:=GetMV("MV_SIMB1")
EndIf

If lFirstCb
	cMoeda1	:= PADC(Alltrim(cMoeda1),12)
	cTit1:=oSection:Cell("VALUNI"):Title()
	cTit2:=oSection:Cell("VALTOT"):Title()
	oSection:Cell("VALUNI"):SetTitle(cTit1+CRLF+cMoeda1) //"Valor Unitario"
	oSection:Cell("VALTOT"):SetTitle(cTit2+CRLF+cMoeda1) //"Valor Total"

	If apar[05] <> 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ De acordo com o parametro da segunda moeda (mv_par05) remonta³
		//³ os titulos de valores no cabecalho p/ moeda secundaria		 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cMoeda2	:= GetMV("MV_SIMB"+Str(apar[05],1,0))
		If Empty(cMoeda2)
			cMoeda2 := GetMV("MV_MOEDA"+Str(apar[05],1,0))
		EndIf
		cMoeda2	:= PADC(Alltrim(cMoeda2),12)
		cTit3:= oSection:Cell("VALUNI2"):Title()
		cTit4:= oSection:Cell("VALTOT2"):Title()
		oSection:Cell("VALUNI2"):SetTitle(cTit3+CRLF+PadC(AllTrim(cMoeda2),12)) //"Valor Unitario"
		oSection:Cell("VALTOT2"):SetTitle(cTit4+CRLF+PadC(AllTrim(cMoeda2),12)) //"Valor Total"
	EndIf
	lFirstCb := .F.
EndIf

For nX := 1 To Len(aArray)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o nivel da estrutura para ser impresso ou nao  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If apar[04] == 1
		If Val(apar[06]) != 0
			If Val(aArray[nX,2]) > Val(apar[06])
				Loop
			Endif
		Endif
	Endif

	If If( (Len(aArray[ nX ])==12),aArray[nX,12],.T. )

		cProduto := aArray[nX][04]
		If lFirst
			oReport:SkipLine()
			lFirst := .F.
		EndIf
		oSection:Cell("CEL"):SetValue(aArray[nX][01])
		oSection:Cell("NIVEL"):SetValue(aArray[nX][02])
		oSection:Cell("B1_COD"):SetValue(aArray[nX][04])
		oSection:Cell("B1_DESC"):SetValue(aArray[nX][03])
		If aArray[nX][04] == Replicate("-",15)
			oSection:Cell("VALTOT"):Hide()
			oSection:Cell("PERCENT"):Hide()
			If apar[05] <> 1
				oSection:Cell("VALUNI2"):Hide()
				oSection:Cell("VALTOT2"):Hide()
			EndIf
		Else
			If nX < nPosForm-1
				If aParc010[02] == 1
					nValUnit := Round(aAuxCusto[nX]/aArray[nX][05], nDecimal)
				Else
					nValUnit := NoRound(aAuxCusto[nX]/aArray[nX][05], nDecimal)
				EndIf
			EndIf
			oSection:Cell("VALTOT"):SetValue(aArray[nX][06])
			oSection:Cell("PERCENT"):SetValue(aArray[nX][07])
			oSection:Cell("VALTOT"):Show()
			oSection:Cell("PERCENT"):Show()
			If apar[05] <> 1
				If nX < nPosForm-1
					oSection:Cell("VALUNI2"):SetValue(Round(ConvMoeda(dDataBase,,nValUnit/nCotacao,Str(apar[05],1)), nDecimal))
					oSection:Cell("VALUNI2"):Show()
				Else
					oSection:Cell("VALUNI2"):Hide()
				EndIf
				oSection:Cell("VALTOT2"):SetValue(ConvMoeda(dDataBase,,(aArray[nX][06]/nCotacao),Str(apar[05],1)))
				oSection:Cell("VALTOT2"):Show()
			EndIf
		EndIf
		If aArray[nX][04] == Replicate("-",15) .Or. nX >= nPosForm-1
			oSection:Cell("B1_UM"):Hide()
			oSection:Cell("QUANT"):Hide()
			oSection:Cell("VALUNI"):Hide()
		Else
			oSection:Cell("B1_UM"):Show()
			oSection:Cell("QUANT"):Show()
			oSection:Cell("VALUNI"):Show()
			cOldAlias:=Alias()
			dbSelectArea("SB1")
			nOrder:=IndexOrd()
			nRecno:=Recno()
			dbSetOrder(1)
			dbSeek(xFilial()+aArray[nX][04])
			oSection:Cell("B1_UM"):SetValue(SB1->B1_UM)
			dbSetOrder(nOrder)
			dbGoTo(nRecno)
			dbSelectArea(cOldAlias)
			oSection:Cell("QUANT"):SetValue(aArray[nX][05])
			oSection:Cell("VALUNI"):SetValue(nValUnit)
		EndIf

		oSection:PrintLine()

		If nX == 1 .And. apar[04] == 2
			nX += (nPosForm-3)
		EndIf
	EndIf
Next
If !lFirst
	oReport:ThinLine()
EndIf

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MR430Plan ³ Autor ³ Eveli Morasco         ³ Data ³ 30/03/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se a Planilha escolhida existe                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR430                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MR430Plan(lGravado,aPar)
Local cArq 		:= ""
Local lRet 		:= .T.
Local aArea		:= GetArea()
Local cAliasTRB := ""
Local cQuery	:= ""

DEFAULT lGravado:=.F.

cArq:=AllTrim(If(lGravado,apar[03],&(ReadVar())))

If SuperGetMV("MV_REVPLAN",.F.,.F.)
	cAliasTRB := GetNextAlias()
	cQuery:= "SELECT CO_CODIGO, CO_REVISAO, CO_NOME FROM "+RetSqlName("SCO")+" "+(cAliasTRB)+" "
	cQuery+= " WHERE CO_FILIAL='"+xFilial("SCO")+"'  AND D_E_L_E_T_ = ' '"
	cQuery+= "       AND CO_NOME ='"+cArq+"'"
	cQuery+= "Order By CO_CODIGO Desc, CO_REVISAO Desc "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),(cAliasTRB),.F.,.T.)

	If (cAliasTRB)->(Eof())
		Help(" ",1,"MR430NOPLA")
		lRet := .F.
	EndIf
	(cAliasTRB)->(DbCloseArea())
Else
	cArq += ".PDV"
	If !File(cArq)
		Help(" ",1,"MR430NOPLA")
		lRet := .F.
	EndIf
EndIf
RestArea( aArea )
Return (lRet)
