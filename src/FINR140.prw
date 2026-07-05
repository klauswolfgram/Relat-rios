/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "FINR140.CH"
#Include "PROTHEUS.Ch"
#INCLUDE "fwcommand.ch"
//#INCLUDE "FWLIBVERSION.CH"

// Posições do aDados2.
#DEFINE DT_VENC		1
#DEFINE PREFIXO		2
#DEFINE TITUL		3
#DEFINE TIPO		4
#DEFINE EMISSAO		5
#DEFINE FORNEC		6
#DEFINE LOJA		7
#DEFINE DESC_TOTAL	8
#DEFINE NOM_FORNEC	9
#DEFINE HISTORICO	10
#DEFINE VL_ORIG		11
#DEFINE VL_PAG		12
#DEFINE VL_REC		13
#DEFINE VL_DIS		14
#DEFINE TAXA		15
#DEFINE FILORIG   	16  
#DEFINE TAM_DADOS2  16	// Sempre deixar com a quantidade de posições no aDados2.	

Static _oFINR1401
Static _oFINR1402

Static lFWCodFil  := .T.
Static nTamFilial := IIf(lFWCodFil, FWGETTAMFILIAL, 2)
Static lGestao    := (nTamFilial > 2)
Static cPerg      := "FIN140"

Static __oTitTMP	As Object
Static __oTitNAT	As Object
Static __oFJ3NAT	As Object 	
Static __cCposTit	As Character
Static __cInsNat1	As Character
Static __lMetric	:= .T. //FwLibVersion() >= "20210517"
Static __cSGBD		As Character
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ FINR140	³ Autor ³ Daniel Tadashi Batori ³ Data ³ 12.09.06 			³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Fluxo de Caixa Analitico												³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR140(void)														³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Finr140()

Local oReport

// Variáveis utilizadas para parâmetros.
// mv_par01 - Número de Dias
// mv_par02 - Moeda
// mv_par03 - Imprime Por Filial ou Empresa
// mv_par04 - Considera Pedidos de Vendas
// mv_par05 - Considera Pedidos de Compras
// mv_par06 - Considera Vencidos
// mv_par07 - Considera Comissoes
// mv_par08 - Considera Moedas
// mv_par09 - Do Prefixo
// mv_par10 - At‚ o Prefixo
// mv_par11 - Retroativo?
// mv_par12 - Outras Moedas?
// mv_par13 - Lista abatimentos?
// mv_par14 - Tit. Emissao Futura
// mv_par15 - Considera limite de credito ?
// mv_par16 - Tipo de Saldo ?    (Normal/Conciliado/Nao Conciliado)
// mv_par17 - Compoe Saldo por?  (Data da Baixa/Data de Credito/Data Digitacao)
// mv_par19 - Lista Estorno?
// mv_par20 - Visao Gerencial Financeira
// mv_par21 - Considera Solic. Fundo
If Pergunte(cPerg, .T.)
	oReport := ReportDef()
	oReport:PrintDialog()
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 11.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do layout do Relatorio							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport
Local oSecFil, oSection2
Local cPictVal
Local nTamTit, nTamVal

oReport := TReport():New("FINR140",STR0004,cPerg,{|oReport| ReportPrint(oReport)},STR0001+STR0002+STR0003)
oReport:SetLandScape(.T.)
oReport:DisableOrientation()
/*
GESTAO - inicio */
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/

nTamTit   := max(TamSX3("E2_NUM")[1] + TamSX3("E2_PARCELA")[1], TamSX3("C5_FILIAL")[1] + TamSX3("C5_NUM")[1] + 3)
nTamVal   := TamSX3("E2_VALOR")[1]
cPictVal  := PesqPict("SE2", "E2_VALOR")

// Relacao das filiais selecionadas para compor o relatório.
oSecFil := TRSection():New(oReport, STR0055, {"SE2"})  // "Filiais"
TRCell():New(oSecFil,"CODFIL",, STR0047,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0048,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0049,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0050,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Filial"

If Empty(MV_PAR20)
	oSection2 := TRSection():New(oReport, STR0004, {"SE2","SE1"})  // "Fluxo de Caixa Analitico"
	TRCell():New(oSection2,"E2_VENCREA","SE2",STR0029,,, .F.)      // "Data Ref"
	TRCell():New(oSection2,"FILORIG","SM0",STR0050,,nTamFilial, .F.,)  //"Filial"
	TRCell():New(oSection2,"E2_PREFIXO","SE2",STR0030,,, .F.)      // "Prf"
	TRCell():New(oSection2,"TITULO",,STR0031,, nTamTit,  .F.)      // "Numero-PC"
	TRCell():New(oSection2,"E2_TIPO",    "SE2",STR0032,,,.F.)      // "Tipo"
	TRCell():New(oSection2,"E2_EMISSAO", "SE2",STR0033,,,.F.)      // "Dt Emiss"
	TRCell():New(oSection2,"E2_FORNECE", "SE2",STR0034,,,.F.)      // "Cli/For"
	TRCell():New(oSection2,"E2_LOJA",    "SE2",,,,       .F.)

	// Colunas TOTAL e TOTAL2 escondidas para impressão de textos totalizadores.
	TRCell():New(oSection2,"TOTAL",           ,STR0035,, 60,.F.)  // "Nome Cliente/Fornecedor"
	TRCell():New(oSection2,"TOTAL2",          ,STR0036,, 35,.F.)  // "Historico"
	TRCell():New(oSection2,"E2_NOMFOR",  "SE2",STR0035,, 60,.F.)  // "Nome Cliente/Fornecedor"
	TRCell():New(oSection2,"E2_HIST",    "SE2",STR0036,, 35,.F.)  // "Historico"

	TRCell():New(oSection2,"VL_ORIGI",,STR0037,cPictVal,nTamVal+3,.F.,,,, "RIGHT")  // "Valor Original"
	TRCell():New(oSection2,"VL_PAGAR",,STR0038,cPictVal,nTamVal,  .F.,,,, "RIGHT")  // "a Pagar"
	TRCell():New(oSection2,"VL_RECEB",,STR0039,cPictVal,nTamVal,  .F.,,,, "RIGHT")  // "a Receber"
	TRCell():New(oSection2,"VL_DISPO",,STR0040,cPictVal,nTamVal+3,.F.,,,, "RIGHT")  // "Disponivel"
	TRCell():New(oSection2,"M2_MOEDA1","SM2",STR0041,,, .F.,)  //"Taxa do Dia"

	oSection2:SetHeaderPage(.T.)	
	oSection2:Setnofilter("SE2")
	oSection2:Setnofilter("SE1")
Else
	// Visão gerencial.
	oSection2 := TRSection():New(oReport, STR0056, {""})  // "Visão gerencial"
	TRCell():New(oSection2, "DATA-DESCRICAO", "cArqTmp",,							, 100)						// "CODIGO E DESCRIÇÃO"
	TRCell():New(oSection2, "ENTRADAS"   	, "cArqTmp",, PesqPict("SE1","E1_VALOR"), nTamVal,,,,,  "RIGHT")	// "ENTRADAS"
	TRCell():New(oSection2, "SAIDAS"   		, "cArqTmp",, PesqPict("SE1","E1_VALOR"), nTamVal,,,,,  "RIGHT")	// "SAIDAS"
	TRCell():New(oSection2, "DISPONIVEL" 	, "cArqTmp",, PesqPict("SE5","E5_VALOR"), nTamVal+3,,,,,"RIGHT")	// "DISPONIVEL"

	oSection2:SetNoFilter("")
	oSection2:SetHeaderPage(.F.)
EndIf

Return oReport
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³10.07.06	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)

Local oSecFil    := oReport:Section(1)
Local oSection2  := oReport:Section(2)
Local aDados2[TAM_DADOS2]
Local cArqTmp	 := "" // Arquivo temporário das movimentações.

Local nDias
Local nValor
Local nTotSaidas
Local dDataVenc
Local lAchou	:= .F.
Local dDataAte
Local dDataImp
Local lFirst			:= .T.
Local lFstPrint			:= .T.
Local nDispon			:= 0
Local nEl				:= 0
Local nDiasInt			:= 0
Local nJurDiario		:= 0
Local nValJuros		:= 0
Local nValGanho		:= 0
Local aValAplic      := 0
Local nTotTitR			:= 0
Local nTotTitP			:= 0
Local nTotGTitR		:= 0
Local nTotGTitP		:= 0
Local nRecHoje			:= 0
Local nPagHoje			:= 0
Local nChqPend			:= 0
Local nTotAplic		:= 0
Local nTotResg			:= 0
Local nTotEntradas	:= 0
Local aAplic			:= {}
Local aResgate			:= {}
Local aBancosA			:= {}
Local aBancosR			:= {}
Local nSalDup			:= 0
Local cArqSA6			:= " "
Local cArqSE1			:= " "
Local cArqSE2			:= " "
Local cArqSEG			:= " "
Local cArqSEH			:= " "

Local nIndexSE3
Local nIndexSE1
Local nIndexSE2

Local nIndexSEG
Local nIndexSEH
Local nIndexFJA
Local nApagVenc		:= 0
Local nArecVenc		:= 0
Local nComissoes	:= 0
Local cArqSE3		:= ""
Local dDtSE8        := Ctod("")
Local lSldSE8		:= .F.
Local nIndSE8		:= 1
Local cArqSE8       := ""
Local cArqFJA       := ""
Local nRegSa6       := 0
Local nRecSE8       := 0
Local nDecs			:= GetMv("MV_CENT"+(IIF(mv_par02 > 1 , STR(mv_par02,1),"")))
Local nMoedaBco		:=	1
Local nMoeda        := mv_par02
Local nImprPV       := 0
Local nImprPC       := 0
Local cAplCotas   	:= GetMv("MV_APLCAL4")
Local nAscan
Local nAbatim
Local nVlrImp    := 0
Local dOldData   := dDatabase
Local nLimCred   := 0
Local lLibCheq   := GetMv("MV_LIBCHEQ")=="N" // Para controlar os cheques pendentes de liberacao.
Local lMvBr10925 := IIf(cPaisLoc == "BRA", GetMv("MV_BR10925")== "1", .F.)
Local lChqLiber  := .T.
Local lTxMoeda   := .T.
Local cTitulo    := STR0004  // "Fluxo de Caixa Analitico"
Local cIpProj    := GetMv("MV_IPPRJAP")
Local dDataTrab
Local dDataVcOri
Local nX, nY
Local aRecSE1	:={}
Local nPos := 0
Local nAcumRc 	:= 0
Local nTotFutR := 0
Local aStru 	:= SE1->(DbStruct())
Local lImpFut	:= .F.
Local lBxFut	:= .F.
Local lImpDev	:= .F.
Local lMovBco	:= .F.
Local lSldZera	:= (mv_par18 <> 1)
Local nDiasRet	:= 0
Local nLastRec  := 0
Local nValConv  := 0
Local nJurConv  := 0
Local nSalConv  := 0

Local cFilSA6   := xFilial("SA6")

Local cFilSE2   := xFilial("SE2")
Local cFilSE1   := xFilial("SE1")
Local cFilSEG   := xFilial("SEG")
Local cFilFJA   := xFilial("FJA")
Local cFilSEH   := xFilial("SEH")

Local cNumMoeda := ""

Local lSolFund	:= MV_PAR21 == 1 .and. cPaisLoc == "ARG"
Local nTamEmp := Len(FwCodEmp())
Local nRecTmp	:= 0 

Local nRegSM0		:= 0
Local nLenSelFil	:= 0
Local nLenFil		:= 0
Local cFilTmp		:= ""
Local aTmpFil		:= {}
Local cTmpFil		:= {}
Local aSM0			:= {}
Local aSelFil		:= {}
Local nTamUnNeg		:= 0
Local nTamTit		:= 0
Local cFilSel		:= ""
Local cTitRel		:= ""
Local oSX1
Local lFilA6E8		:= Len(Alltrim(xfilial("SA6") )) == Len(Alltrim(xfilial("SE8") ))
Local lImpTitVen	:= .F.	
Local lImpLine		:= .T.
Local nDescFin		:= 0
Local cSA6Comp		:= FWModeAccess("SA6",1) +  FWModeAccess("SA6",2) + FWModeAccess("SA6",3)
Local cAliasSE5		:= GetNextAlias()
Local cQuery		:= ""
Local aAuxGem		:= {}
Local aAplicSeh     := {}

// SITCOB
Local cListDesc := FN022LSTCB(2) // Obtém a lista de situações de cobranças descontadas.
Local cListBco	:= FN022LSTCB(3) // Obtém a lista de situações de cobranças que possuem portador.
Local nMoedBanco := 0

Private cErros := ""
Private adCompras := {}, adVendas := {}
Private aCompras  := {}, aVendas  := {}

aAplicSeh := Aplicacoes(mv_par03 == 1, mv_par02)

// *************************************************************
// *  oSX1 - Pode ser retirado após o fim da versão 12.1.17.   *
// *************************************************************
// Verifica as opções dos parâmetros 4 e 5.
oSX1 := FWSX1Util():New()
oSX1:AddGroup(cPerg)
oSX1:SearchGroup()
If empty(oSX1:aGrupo[1, 2, 4]:cX1_DEF03)
	// Nesse caso as opções são:
	// 1=Sim / 2=Não.
	nImprPV := If(mv_par04 = 2, 3, mv_par04)
	nImprPC := If(mv_par05 = 2, 3, mv_par05)
Else
	// Nesse caso as opções são:
	// 1=Sintético / 2=Analítico / 3=Não.
	nImprPV := mv_par04
	nImprPC := mv_par05
Endif
oSX1 := nil
// *******************************************************

//Ponto de entrada para escolha entre bancos com ou sem movimento
If ExistBlock("FA140MVB")
	lMovBco := ExecBlock("FA140MVB")
Endif

/*
GESTAO - inicio */
If !IsBlind()	
	nRegSM0 := SM0->(Recno())
	aSelFil := AdmGetFil(.F., (MV_PAR03 == 1), "SE1")
Endif

If Empty(aSelFil)
	aSelFil := {cFilAnt}
	MV_PAR03 := 1
Endif

If !IsBlind() .and. lGestao 
	SM0->(DbGoTo(nRegSM0))
EndIf

// Imprime a lista de filiais selecionadas para o relatório
If Len(aSelFil) > 1
	oSection2:SetHeaderSection(.F.)
	aSM0 := Finr140Emp()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitRel := oReport:Title()
	oReport:SetTitle(cTitRel + " (" + STR0051 + ")") // "Filiais selecionadas para o relatorio"
	nTamTit := Len(oReport:Title())
	oSecFil:Init()
	oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
	oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
	oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
	oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})
	For nX := 1 To Len(aSelFil)
		nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[nX]})
		If nLinha > 0
			cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
			oSecFil:PrintLine()
		Endif
	Next
	oReport:SetTitle(cTitRel)
	oSecFil:Finish()
	oSection2:SetHeaderSection(.T.)
	oReport:EndPage()
Endif
/* GESTAO - fim
*/

If Empty(MV_PAR20)
	oSection2:Cell("E2_VENCREA"	):SetBlock({|| If(lBxFut, aDados2[DT_VENC],    If(lImpDev,, DTOC(E1VENC->E1_VENCREA))) })
	oSection2:Cell("E2_PREFIXO"	):SetBlock({|| If(lBxFut, aDados2[PREFIXO],    If(lImpDev,, E1VENC->E1_PREFIXO)) })
	oSection2:Cell("TITULO"		):SetBlock({|| If(lBxFut, aDados2[TITUL],      If(lImpDev,, E1VENC->E1_NUM+(IIF(!EMPTY(E1VENC->E1_PARCELA),"-",""))+E1VENC->E1_PARCELA)) })
	oSection2:Cell("E2_TIPO"	):SetBlock({|| If(lBxFut, aDados2[TIPO],       If(lImpDev,, E1VENC->E1_TIPO)) })
	oSection2:Cell("E2_EMISSAO"	):SetBlock({|| If(lBxFut, aDados2[EMISSAO],    If(lImpDev,, DTOC(E1VENC->E1_EMISSAO))) })
	oSection2:Cell("E2_FORNECE"	):SetBlock({|| If(lBxFut, aDados2[FORNEC],     If(lImpDev,, E1VENC->E1_CLIENTE)) })
	oSection2:Cell("E2_LOJA"	):SetBlock({|| If(lBxFut, aDados2[LOJA],       If(lImpDev,, E1VENC->E1_LOJA)) })

	oSection2:Cell("TOTAL"		):SetBlock({|| If(lBxFut, aDados2[DESC_TOTAL], If(lImpDev, STR0018,aDados2[DESC_TOTAL])) })  // "Total De Títulos Vencidos"
	oSection2:Cell("TOTAL2"		):SetBlock({|| ""})
	oSection2:Cell("E2_NOMFOR"	):SetBlock({|| If(lBxFut, aDados2[NOM_FORNEC], If(lImpDev,, SubStr(E1VENC->E1_NOMCLI,1,25))) })
	oSection2:Cell("E2_HIST"	):SetBlock({|| If(lBxFut, aDados2[HISTORICO],  If(lImpDev,, If(E1VENC->E1_SALDO == 0,STR0046,SubStr(E1VENC->E1_HIST,1,25)))) })	//"Tit.Baixado p/Rec. Futuro"

	oSection2:Cell("VL_ORIGI"	):SetBlock({|| If(lBxFut, aDados2[VL_ORIG],    nil)})
	oSection2:Cell("VL_PAGAR"	):SetBlock({|| If(lBxFut, aDados2[VL_PAG],     If(lImpDev,nApagVenc,aDados2[VL_PAG])) })
	oSection2:Cell("VL_RECEB"	):SetBlock({|| If(lBxFut, aDados2[VL_REC],     If(lImpDev,nArecVenc,nSaldo)) })
	oSection2:Cell("VL_DISPO"	):SetBlock({|| If(lBxFut, aDados2[VL_DIS],     nDispon) })

	oSection2:Cell("TOTAL"):Disable()
	oSection2:Cell("TOTAL2"):Disable()

	If mv_par02 == 1
		oSection2:Cell("M2_MOEDA1"):Disable()
	Else
		cNumMoeda += "M2_MOEDA" + cValToChar(mv_par02)
		oSection2:Cell("M2_MOEDA1"):SetBlock({|| SM2->(&cNumMoeda)})
	EndIf

	oSection2:Cell("FILORIG"):SetBlock({|| If(lBxFut, aDados2[FILORIG], If(lImpDev,, E1VENC->E1_FILORIG)) })
	
Else
	oSection2:Cell("DATA-DESCRICAO"):SetBlock({|| If(lBxFut, aDados2[DESC_TOTAL], CARQTMP->CODDESC)})
	oSection2:Cell("ENTRADAS"     ):SetBlock({|| If(lBxFut, aDados2[VL_REC],     CARQTMP->ENTRADAS)})
	oSection2:Cell("SAIDAS"       ):SetBlock({|| If(lBxFut, aDados2[VL_PAG],     CARQTMP->SAIDAS)})
	oSection2:Cell("DISPONIVEL"    ):SetBlock({|| If(lBxFut, aDados2[VL_DIS],     CARQTMP->DISPON)})
EndIf

If mv_par03 == 2 .Or. !Empty(aSelFil)	// Imprime Por Filial ou Empresa		/* GESTAO */
	// Contas a receber
	dbSelectArea("SE1")
	cArqSE1 := SubStr(criatrab("",.f.),1,7)+"A"
	IndRegua("SE1",cArqSE1,"DTOS(E1_VENCREA)+E1_NOMCLI+E1_PREFIXO+E1_NUM+E1_PARCELA",,,OemToAnsi(STR0008))  //"Selecionando Registros..."
	nIndexSE1 := RetIndex("SE1") + 1
	dbSetOrder( nIndexSE1 )

	// Contas a pagar
	dbSelectArea("SE2")
	cArqSE2 := SubStr(criatrab("",.f.),1,7)+"B"
	IndRegua("SE2",cArqSE2,"DTOS(E2_VENCREA)+E2_NOMFOR+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO",,,OemToAnsi(STR0008))  //"Selecionando Registros..."
	nIndexSE2 := RetIndex("SE2") + 1
	dbSetOrder( nIndexSE2 )

	//Contas Correntes
	If !Empty(xFilial("SA6"))
		dbSelectArea("SA6")
		cArqSA6 := CriaTrab(,.F.)
		IndRegua("SA6",cArqSA6,"A6_COD+A6_AGENCIA+A6_NUMCON",,,OemToAnsi(STR0008))  //"Selecionando Registros..."
		nIndSA6 := RetIndex("SA6") + 1
		dbSetOrder(nIndSA6)
	Endif

	// Saldo Bancario
	dbSelectArea("SE8")
	cArqSE8 := CriaTrab(,.F.)
	IndRegua("SE8",cArqSE8,"E8_BANCO+E8_AGENCIA+E8_CONTA+DTOS(E8_DTSALAT)",,,OemToAnsi(STR0008))  //"Selecionando Registros..."
	nIndSE8 := RetIndex("SE8") + 1
	dbSetOrder(nIndSE8)

	// Aplicacoes e emprestimos
	dbSelectArea("SEG")
	cArqSEG := SubStr(criatrab("",.f.),1,7)+"D"
	IndRegua("SEG",cArqSEG,"DTOS(EG_DATARES)+EG_BANCO+EG_AGENCIA+EG_CONTA",,,OemToAnsi(STR0008))  //"Selecionando Registros..."
	SEG->(dbCommit())
	nIndexSEG := RetIndex("SEG") + 1

	// Aplicacoes e emprestimos
	dbCommit()
	dbSelectArea("SEH")
	cArqSEH := criatrab("",.f.)
	IndRegua("SEH",cArqSEH,"EH_STATUS+EH_APLEMP",,,OemToAnsi(STR0008))  //"Selecionando Registros..."
	SEH->(dbCommit())
	nIndexSEH := RetIndex("SEH") + 1

	//Solicitacoes de Fundo
	If lSolFund
		DbSelectArea("FJA")
		cArqFJA := CriaTrab(,.F.)
		IndRegua("FJA",cArqFJA,"DTOS(FJA_DATAPR)",,,OemToAnsi(STR0008))  //"Selecionando Registros..."
		nIndexFJA := RetIndex("FJA") + 1
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria indice condicional temporario para analise das comissoes ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if mv_par07 == 1		// Analisa comissoes == Sim
	If Empty(cArqSE3)
		dbSelectArea("SE3")
		cArqSE3 := SubStr(criatrab("",.f.),1,7)+"E"
		cChave := "DTOS(E3_DATA)"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Condicao 1 - Somente filial 			  ³
		//³Condicao 2 - Todas filias (Empresa)	  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		if mv_par03 == 1 .And. Empty(aSelFil)
			// Nao Alterar o ctod(01/01/80)
			cCond := 'DTOS(E3_DATA)<="'+Dtos(ctod("01/01/80","ddmmyy"))+'".AND.E3_FILIAL=="'+xFilial("SE3")+'"'
		else
			cCond := 'DTOS(E3_DATA)<="'+Dtos(ctod("01/01/80","ddmmyy"))+'"'
		endif

		IndRegua("SE3",cArqSE3,cChave,,cCond,OemToAnsi(STR0008))  //"Selecionando Registros..."
		dbSelectArea("SE3")
		nIndexSE3		:= RetIndex("SE3") + 1
		dbSetOrder(nIndexSE3)
		SE3->(DbGoTop())
	Else
		dbSelectArea("SE3")
		nIndexSE3		:= RetIndex("SE3") + 1
		dbSetOrder( nIndexSE3 )
	Endif
Endif

cTitulo += " em " + GetMV("MV_MOEDA"+AllTrim(Str(mv_par02, 2)))
dDataAte := dDataBase + mv_par01

oReport:SetTitle(cTitulo)

IF mv_par02 != 1
	cSuf := AllTrim(Str(mv_par02,2))
	dbSelectArea("SM2")
	dbSeek( dDataBase )
EndIF

// Imprime disponibilidade bancária.
dbSelectArea("SA6")
/* GESTAO - inicio */
If !IsBlind()
	nLenSelFil := Len(aSelFil)
	If nLenSelFil == 0
		If ( MV_PAR03 == 1 )
			dbSeek( cFilSA6 )
		Else
			dbGotop()
		EndIf
	Else
		nPosFil := 0
		SA6->(DbGotop())
	Endif
Endif
/* GESTAO - fim
*/
cSuf := AllTrim(Str(mv_par02,2,0))

//-- Suporte à Personalização - Despociona titulos 
SE1->(DbGoTo(0))
SE2->(DbGoTo(0))

oSection2:Init()
lBxFut := .T.
HabiCel(.F., oReport)

While !SA6->(Eof()) .and. If(nLenSelFil == 0,If(MV_PAR03==1,SA6->A6_FILIAL == cFilSA6,.T.),.T.)
	/* GESTAO - inicio */
	If nLenSelFil > 0
		cFilTmp := AllTrim(SA6->A6_FILIAL)
		nLenFil := Len(cFilTmp)
		nPosFil := Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)})
		If nPosFil == 0
			SA6->(DbSkip())
			Loop
		Endif
	Else
		If mv_par03 == 2
			If lGestao .and. Substring(SA6->A6_FILIAL, 1,nTamEmp) != Substring(cFilSA6, 1,nTamEmp )
				SA6->(dbSkip())
				Loop
			EndIf
		EndIf
	Endif
	/* GESTAO fim
	*/
	IF SA6->A6_FLUXCAI == "N"
		SA6->(dbSkip())
		Loop
	Endif
	nRegSa6 := RecNo()
	
	If lFirst

		cQuery := "SELECT SE5.R_E_C_N_O_ RECNO, ISNULL(SA6.A6_MOEDA,1) A6_MOEDA FROM " + RetSqlName("SE5") + " SE5 "
		cQuery += "LEFT JOIN " + RetSqlName("SA6") + " SA6 ON ("
		If cSA6Comp == "EEE" 
			cQuery	+=  " SA6.A6_FILIAL = SE5.E5_FILORIG "
		ElseIf cSA6Comp == "EEC" 
			cQuery	+=  " SUBSTRING(SA6.A6_FILIAL,1," + LTRIM( STR( LEN( FWSM0Layout(,1) + FWSM0Layout(,2) ) ) ) + ") =  SUBSTRING(SE5.E5_FILORIG,1," + LTRIM( STR( LEN( FWSM0Layout(,1) + FWSM0Layout(,2) ) ) ) + ") " 
		ElseIf cSA6Comp == "ECC"
			cQuery	+=  " SUBSTRING(SA6.A6_FILIAL,1," + LTRIM( STR( LEN( FWSM0Layout(,1) ) ) ) + ") = SUBSTRING(SE5.E5_FILORIG,1," + LTRIM( STR( LEN( FWSM0Layout(,1) ) ) ) + ") " 
		Else 
			cQuery	+=  " SA6.A6_FILIAL = '" + xFilial("SA6") + "' "	
		Endif

		cQuery += " AND SA6.A6_COD = SE5.E5_BANCO "
		cQuery += " AND SA6.A6_AGENCIA = SE5.E5_AGENCIA "
		cQuery += " AND SA6.A6_NUMCON = SE5.E5_CONTA "
		cQuery += " AND SA6.D_E_L_E_T_ = ' ') "

		cQuery += "WHERE "
		If nLenSelFil == 0 .or. mv_par03 == 1
			cQuery += " SE5.E5_FILIAL = '" + xFilial("SE5") + "' "
		Else
			cQuery += " SE5." + FinSelFil( aSelFil, "SE5", .F., .T.)
		EndIf	
		If mv_par14 == 1
			cQuery += "AND SE5.E5_DATA BETWEEN '" + DtoS(dDataBase) + "' AND '" + DtoS(dDataAte) + "' "
		Else
			cQuery += "AND SE5.E5_DATA = '" + DtoS(dDataBase) + "' " 
		EndIf	

		If mv_par12 == 2
			cQuery += " AND (SA6.A6_MOEDA = " + STR(	nMoeda )+ " OR ISNULL(SA6.A6_MOEDA,1) = " + STR(	nMoeda ) + ") "
		EndIf

		cQuery += " AND SE5.E5_SITUACA != 'C' "
		cQuery += " AND SE5.E5_TIPODOC NOT IN ('JR','MT','DC','BA','CM','J2','M2','D2','C2','V2','CX','CP','TL') "
		cQuery += " AND SE5.D_E_L_E_T_ = ' ' "
		cQuery += "AND NOT EXISTS ( "
		cQuery += "SELECT A.R_E_C_N_O_ "
		cQuery += "FROM "+RetSqlName("SE5")+" A "
		cQuery += "WHERE A.E5_FILIAL = SE5.E5_FILIAL "
		cQuery += "AND A.E5_NUMERO != ' ' "
		cQuery += "AND A.E5_TIPO != ' ' "
		cQuery += "AND A.E5_PREFIXO=SE5.E5_PREFIXO "
		cQuery += "AND A.E5_NUMERO=SE5.E5_NUMERO "
		cQuery += "AND A.E5_PARCELA=SE5.E5_PARCELA "
		cQuery += "AND A.E5_TIPO=SE5.E5_TIPO "
		cQuery += "AND A.E5_CLIFOR=SE5.E5_CLIFOR "
		cQuery += "AND A.E5_LOJA=SE5.E5_LOJA "
		cQuery += "AND A.E5_SEQ=SE5.E5_SEQ "
		cQuery += "AND ( A.E5_TIPODOC='ES' OR A.E5_SITUACA IN ('C','E','X') ) "
		cQuery += "AND A.E5_DATA <= '"+DTOS(dDataBase)+"' "
		cQuery += "AND A.E5_DTCANBX <= '"+DTOS(dDataBase)+"' "
		cQuery += "AND A.D_E_L_E_T_ = ' ') "
		cQuery += "ORDER BY "
		If mv_par03 == 1 
			cQuery += "E5_FILIAL, E5_DATA, E5_BANCO, E5_AGENCIA, E5_CONTA "
		Else
			cQuery += "E5_DATA, E5_BANCO, E5_AGENCIA, E5_CONTA "
		EndIf		
		cQuery := ChangeQuery( cQuery )
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSE5, .F., .T. )

		If FindFunction("FinEraseTmpFil")
			FinEraseTmpFil()
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se houve movimenta‡„o bancaria no dia da emissao do fluxo³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE5")
		
		While (cAliasSE5)->(! Eof() ) //&cCondSE5

			SE5->(DBGoTo( (cAliasSE5)->RECNO ))

			nMoedaBco	:=	Max((cAliasSE5)->A6_MOEDA,1)

			nValConv := xMoeda(E5_VALOR,nMoedaBco,nMoeda,E5_DATA,nDecs+1)

			IF E5_TIPODOC == "AP"  .And. E5_RECPAG = "P"     //Aplicacoes
				nTotAplic += nValConv
				nEl := Ascan(aBancosA,E5_BANCO)
				IF nEl == 0
					AADD(aBancosA,E5_BANCO)
					AADD(aAplic,{E5_BANCO,nValConv,E5_FILIAL})
				Else
					aAplic[nEl][2] += nValConv
				EndIf
			ElseIf E5_TIPODOC == "AP" .And. E5_RECPAG = "R"      //Estorno de Aplicacoes
				nTotAplic -= nValConv
				nEl := Ascan(aBancosA,E5_BANCO)
				IF nEl == 0
					AADD(aBancosA,E5_BANCO)
					AADD(aAplic,{E5_BANCO,nValConv,E5_FILIAL})
				Else
					aAplic[nEl][2] -= nValConv
				EndIf
			ElseIf E5_TIPODOC == "RF" .And. E5_RECPAG = "R"  //Resgates
				nTotResg += nValConv
				nEl := Ascan(aBancosR,E5_BANCO)
				IF nEl == 0
					AADD(aBancosR,E5_BANCO)
					AADD(aResgate,{E5_BANCO,nValConv,E5_FILIAL})
				Else
					aResgate[nEl][2] += nValConv
				EndIf
			ElseIf E5_TIPODOC == "RF" .And. E5_RECPAG = "P"  //Estorno de Resgates
				nTotResg -= nValConv
				nEl := Ascan(aBancosR,E5_BANCO)
				IF nEl == 0
					AADD(aBancosR,E5_BANCO)
					AADD(aResgate,{E5_BANCO,nValConv,E5_FILIAL})
				Else
					aResgate[nEl][2]-=nValConv
				EndIf
			ElseIf E5_TIPODOC == "EP" .And. E5_RECPAG=="R" // Emprestimo
				nRecHoje += nValConv
			ElseIf E5_TIPODOC == "EP" .And. E5_RECPAG=="P" // Estorno de Emprestimo
				nRecHoje -= nValConv
			ElseIf E5_TIPODOC == "PE" .And. E5_RECPAG=="P" // Pagamento de emprestimo
				nPagHoje += nValConv				
			ElseIf E5_TIPODOC == "PE" .And. E5_RECPAG=="R" // Estorno de pagamento de emprestimo
				nPagHoje -= nValConv				
			ElseIf E5_TIPODOC == "RA" .And. E5_RECPAG=="R" .And. E5_DATA <> dDataBase  // Pagamento Antecipado
				nPagHoje -= nValConv				
			ElseIf E5_RECPAG == "R" .And. ! E5_TIPODOC $ "EP#PE#AP#RF"
				// Movimento a receber que nao seja emprestimo nem pagto de emprestimo
				nRecHoje += nValConv
			ElseIf E5_RECPAG == "P" .And. ! E5_TIPODOC $ "EP#PE#AP#RF"
				If lLibCheq
					// Pesquisa cheque pendentes de liberacao
					SEF->(DbSetOrder(3))
					If SEF->(MsSeek(xFilial("SEF")+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_NUMCHEQ+E5_SEQ))) .And. SEF->EF_LIBER $ " N"
						nChqPend += xMoeda(SEF->EF_VALOR,nMoedaBco,nMoeda,E5_DATA,nDecs+1)
					Else
						// Movimento a pagar que nao seja emprestimo nem pagto de emprestimo
						nPagHoje += nValConv						
					Endif
				Else
					// Movimento a pagar que nao seja emprestimo nem pagto de emprestimo
					nPagHoje += nValConv
				Endif
			EndIf

			(cAliasSE5)->( DbSkip() )
		EndDo
		(cAliasSE5)->( DbCloseArea() )

		IF (nPagHoje+nRecHoje+nTotAplic+nTotResg+nChqPend) != 0

			aDados2[DESC_TOTAL] := STR0010  //"Movimentacao na data ate a hora da emissao"
			nTotEntradas := nTotResg + nRecHoje
			nTotSaidas	 := nTotAplic + nPagHoje + nChqPend
			oSection2:PrintLine()
			aFill(aDados2,nil)

			aDados2[DESC_TOTAL] := STR0011  //"Aplicacoes "
			aDados2[VL_PAG] := nTotAplic 
			oSection2:PrintLine()
			aFill(aDados2,nil)

			IF nTotAplic>0
				For nX := 1 To Len(aBancosA)
					aDados2[DESC_TOTAL] := PadR(Space(4) + aAplic[nX][1] , 9)
					dbSelectArea("SA6")
					If ( xFilial("SA6") == Space(nTamFilial) )
						dbSeek( cFilSA6 + aAplic[nX][1] )
					Else
						dbSeek(aAplic[nX,3]+aAplic[nX][1])
					EndIf

					aDados2[DESC_TOTAL] += AllTrim(A6_NREDUZ)
					aDados2[VL_ORIG] := aAplic[nX][2] 
					oSection2:PrintLine()
					aFill(aDados2,nil)
				Next nX
			EndIF

			aDados2[DESC_TOTAL] := STR0012  //  "Resgates "
			aDados2[VL_REC] := nTotResg 
			oSection2:PrintLine()
			aFill(aDados2,nil)

			IF nTotResg>0
				For nX := 1 To Len(aBancosR)
					aDados2[DESC_TOTAL] := Space(4) + aResgate[nX][1]
					dbSelectArea("SA6")
					If ( xFilial("SA6") == Space(nTamFilial) )
						dbSeek( cFilSA6 + aResgate[nX][1] )
					Else
						dbSeek(aResgate[nX,3]+aResgate[nX][1])
					EndIf

					aDados2[DESC_TOTAL] += AllTrim(A6_NREDUZ)
					aDados2[VL_ORIG] := aResgate[nX][2] 
					oSection2:PrintLine()
					aFill(aDados2,nil)
				Next nX
			EndIF

			aDados2[DESC_TOTAL] := STR0013  //"Outras Saidas "
			aDados2[VL_PAG] := nPagHoje 
			oSection2:PrintLine()
			aFill(aDados2,nil)

			If lLibCheq
				aDados2[DESC_TOTAL] := STR0028 // "Cheques pendentes de liberacao"
				aDados2[VL_PAG] := nChqPend 
				oSection2:PrintLine()
				aFill(aDados2,nil)
			Endif

			aDados2[DESC_TOTAL] := STR0014  //"Outras Entradas "
			aDados2[VL_REC] := nRecHoje 
			oSection2:PrintLine()
			aFill(aDados2,nil)

			oReport:SkipLine()
			aDados2[DESC_TOTAL] := STR0015  //"Totais ate a hora da emissao "
			aDados2[VL_PAG] := nTotSaidas 
			aDados2[VL_REC] := nTotEntradas 
			oSection2:PrintLine()
			aFill(aDados2,nil)

			oReport:ThinLine()
			nPagHoje := 0
			nRecHoje := 0
			nTotAplic:= 0
			nTotResg := 0
		EndIF
	EndIF

	dbSelectArea("SA6")
	dbGoTo(nRegSa6)
	dbSelectArea("SE8")
	dbSetOrder( nIndSE8 )
	If !(dbSeek(If((MV_PAR03==1 .And. nLenSelFil == 0),xFilial(),"")+SA6->A6_COD+SA6->A6_AGENCIA+SA6->A6_NUMCON+DtoS(dDataBase),.t.))	/* GESTAO */
		dbSkip(-1)
		dDtSE8  := SE8->E8_DTSALAT
		lSldSE8 := .F.
		nRecSE8 := SE8->(RECNO())
		/* GESTAO - Inicio */
		While (  !Bof() .And. If((MV_PAR03==1 .And. nLenSelFil == 0),xFilial()==SE8->E8_FILIAL, .T. ) .And.;
			SA6->A6_COD+SA6->A6_AGENCIA+SA6->A6_NUMCON == ;
			SE8->E8_BANCO+SE8->E8_AGENCIA+SE8->E8_CONTA .And.;
			SE8->E8_DTSALAT == dDtSE8 )
			If nLenSelFil > 0
				cFilTmp := AllTrim(SE8->E8_FILIAL)
				nLenFil := Len(cFilTmp)
				If Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)}) == 0
					SE8->(DbSkip(-1))
					Loop
				Endif
			Else
				If mv_par03 == 2
					If lGestao .and. Substring(xFilial(),1,nTamEmp)!= Substring(SE8->E8_FILIAL,1,nTamEmp)
						SE8->(DbSkip())
						Loop
					EndIf
				EndIf
			Endif
			/* GESTAO - Fim */
			nRecSE8 := SE8->(RECNO())
			dbSkip(-1)
			lSldSE8 := .T.
		EndDo

		If lSldSE8
			dbGoTo(nRecSE8)
		EndIf
	EndIf

	nValor := 0
	nMoedBanco := Max(SA6->A6_MOEDA,1)
	
	/* GESTAO - inicio */
	While SE8->(!Eof()) .And. If((mv_par03==1 .And. nLenSelFil == 0),xFilial("SE8") == SE8->E8_FILIAL,.T. ) .And.;
		SA6->(A6_COD+A6_AGENCIA+A6_NUMCON) == SE8->(E8_BANCO+E8_AGENCIA+E8_CONTA) .And.	SE8->E8_DTSALAT <= dDataBase
		
		If mv_par12 == 2 .And. nMoedBanco != mv_par02
			SE8->(DbSkip())
			Loop
		EndIf

		If nLenSelFil > 0
			cFilTmp := AllTrim(SE8->E8_FILIAL)
			nLenFil := Len(cFilTmp)
			If Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)}) == 0
				SE8->(DbSkip())
				Loop
			Endif
			If lFilA6E8  // Mesmo compartilhamento
				If SA6->A6_FILIAL != SE8->E8_FILIAL
					SE8->(DbSkip())
					Loop
				EndIf
			ElseIf !Empty(SA6->A6_FILIAL) // Compartilhamento diferente
				If !( AllTrim(SA6->A6_FILIAL) $ SE8->E8_FILIAL )
					SE8->(DbSkip())
					Loop				
				EndIf
			EndIf
		Else
			If mv_par03 == 2
				If lGestao .and. Substring(xFilial("SE8"),1,nTamEmp )!= Substring(SE8->E8_FILIAL,1,nTamEmp)
					SE8->(DbSKip())
					Loop
				EndIf
			EndIf
		Endif
		/* GESTAO - Fim	*/
		If mv_par16 == 1			//Normal
			nValor += xMoeda(SE8->E8_SALATUA,nMoedBanco,mv_par02)
		ElseIf mv_par16 == 2   //Conciliado
			nValor += xMoeda(SE8->E8_SALRECO,nMoedBanco,mv_par02)
		ElseIf mv_par16 == 3   //Nao Conciliado
			nValor += xMoeda(SE8->E8_SALATUA-SE8->E8_SALRECO,nMoedBanco,mv_par02)
		EndIf
		SE8->(dbSkip())
	Enddo

	If mv_par15 == 1 // Se considera limite de credito
		nLimCred := xMoeda(SA6->A6_LIMCRED,nMoedBanco,mv_par02)
	Endif

	// Valida a impressao de banco sem movimentacao, de acordo com o resultado do ponto de entrada FA140MVB
	
	If !(lSldZera .And. nValor == 0) .And. (!lMovBco .or. nValor + nLimCred != 0)
		If lFstPrint
			aDados2[DESC_TOTAL] := STR0016  //"Disponibilidade imediata"
			oSection2:PrintLine()
			aFill(aDados2,nil)
			lFstPrint := .F.
		EndIf

		aDados2[DESC_TOTAL] := SA6->(A6_NREDUZ + "  (" + A6_COD + ") ")
		aDados2[DESC_TOTAL] += SA6->("AG: " + A6_AGENCIA + " C/C: " + RTrim(A6_NUMCON))
		aDados2[VL_DIS]     := nValor
		oSection2:PrintLine()
		aFill(aDados2,nil)

		If mv_par15 == 1
			aDados2[DESC_TOTAL] := STR0027  // "Limite de Credito: "
			aDados2[VL_DIS]    := nLimCred
			oSection2:PrintLine()
			aFill(aDados2,nil)
		Endif
	Endif
	nDispon += (nValor + nLimCred)

	// Se emitido por empresa e o SA6 for Exclusivo, posiciono na proxima conta diferenciada
	// ja que a rotina ja aglutinou os saldos de contas identicas (Bco/Age/Cta) que existam
	// nas diferentes filiais
	dbSelectArea("SA6")
	dbGoTo(nRegSa6)
	SA6->(dbSkip())

	lFirst := .F.
EndDo

IF (nRegSa6 != 0)
	oReport:SkipLine()
	aDados2[DESC_TOTAL] := STR0017  //"Total Disponivel "
	aDados2[VL_DIS] := nDispon

	oSection2:PrintLine()
	oReport:ThinLine()
	aFill(aDados2,nil)
	oReport:SkipLine()
EndIF

HabiCel(.T.,oReport)
lBxFut := .F.
oSection2:Finish()

If Empty(MV_PAR20)

	aFill(aDados2,nil)
	oSection2:Init()

	lFirst := .T.

	// Soma Titulos vencidos - a receber e a pagar
	If mv_par06 == 1  // Considera titulos em atraso

		// Soma contas a pagar vencida pela data de Vencimento
		IF TcSrvType() != "AS/400"
			cOrdSE2 := SqlOrder(SE2->(Indexkey()))
			cRecPagAnt := FormatIn( MVPAGANT, "/" )
			aStru := SE2->(DbStruct())
			cQuery := ""
			aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
			cQuery := "SELECT  " +SubStr(cQuery,2) + ", R_E_C_N_O_ RECNOSE2 "
			cQuery += "FROM " + RetSqlName("SE2") + " SE2 "
			/*
			GESTAO - inicio */
			If nLenSelFil > 0
				cQuery += "WHERE E2_FILIAL " + GetRngFil( aSelFil, "SE2", .T., @cTmpFil)
				Aadd(aTmpFil,cTmpFil)
			Else
				If mv_par03 == 1
					cQuery += "WHERE E2_FILIAL = '" + xFilial("SE2") + "'"
				Else
					If lGestao
						If UPPER(AllTrim(TcGetDb())) $ "DB2|ORACLE"
							cQuery += "WHERE SUBSTR(E2_FILIAL, 1,"+Str(nTamEmp)+" )= '"+ Substring(xFilial("SE2"), 1, nTamEmp)+"'"
						Else
							cQuery += "WHERE SUBSTRING(E2_FILIAL, 1,"+Str(nTamEmp)+" )= '"+ Substring(xFilial("SE2"), 1, nTamEmp)+"'"
						Endif
					Else
						cQuery += "WHERE E2_FILIAL between ' ' AND 'zz'"
					EndIf
				Endif
			Endif
			/* GESTAO - fim
			*/
			cQuery += " AND E2_PREFIXO between '" + mv_par09 + "' AND '"+mv_par10 + "'"
			cQuery += " AND E2_MOEDA IN " + StrTran(FormatIn(AllTrim('0' + mv_par08),,1),"'","")
			cQuery += " AND E2_VENCREA <= '" + Dtos(dDataBase-1) +"'"
			If cPaisLoc=="BRA"
				cQuery += " AND E2_TIPO NOT IN " + cRecPagAnt
			EndIf
			If mv_par11 == 2
				cQuery += " AND E2_SALDO > 0 "
			Endif
			If mv_par12 == 2
				cQuery += " AND E2_MOEDA = " + Str(nMoeda,2)
			Endif
			cQuery += " AND E2_FLUXO <> 'N'"
			//Considerar ou nao titulos com emissao posterior a database
			If mv_par14 == 2
				cQuery += " AND E2_EMIS1 <= '"+Dtos(dDataBase) +"'"
			Endif
			cQuery += " AND D_E_L_E_T_ = ' '"
			cQuery += " ORDER BY " + cOrdSE2
			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"E2VENC",.T.,.T.)
			aEval(aStru, {|e| If(e[2] != "C", TCSetField("E2VENC", e[1], e[2], e[3], e[4]), Nil)})

			oReport:SetMeter(RecCount())
			While E2VENC->(!EOF())
				oReport:IncMeter()
				SE2->(MsGoto(E2VENC->RECNOSE2))
				If mv_par11 == 1
					nSaldo := SaldoTit(E2VENC->E2_PREFIXO,E2VENC->E2_NUM,E2VENC->E2_PARCELA,E2VENC->E2_TIPO,E2VENC->E2_NATUREZ,"P",E2VENC->E2_FORNECE,mv_par02,E2VENC->E2_VENCREA,dDataBase,E2VENC->E2_LOJA,,If(cPaisLoc=="BRA",E2VENC->E2_TXMOEDA,0), mv_par17)

					// Calcula valores acessórios.
					nSaldo   += E2VENC->(FValAcess(E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA, E2_NATUREZ, /*lBaixados*/, /*cCodVa*/, "P", dDataBase, /*aValAces*/, E2_MOEDA, mv_par02, E2_TXMOEDA))
				Else
					// Verifica se existe a taxa na data do vencimento do titulo, se nao existir, utiliza a taxa da database
					lTxMoeda := SM2->(MsSeek(E2VENC->E2_VENCREA)) .And. SM2->&("M2_MOEDA"+Alltrim(Str(mv_par02))) != 0
					nSaldo   := xMoeda((E2VENC->E2_SALDO+E2VENC->E2_SDACRES-E2VENC->E2_SDDECRE),E2VENC->E2_MOEDA,mv_par02,,,If(cPaisLoc=="BRA",E2VENC->E2_TXMOEDA,0))

					// Calcula valores acessórios.
					nSaldo   += E2VENC->(FValAcess(E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA, E2_NATUREZ, /*lBaixados*/, /*cCodVa*/, "P", E2_VENCREA, /*aValAces*/, E2_MOEDA, mv_par02, E2_TXMOEDA))
				EndIf

				If cPaisLoc<>"BRA"
					If E2VENC->E2_TIPO $ MV_CRNEG+"/"+MV_CPNEG+"/"+MVIRABT+"/"+MVCSABT+"/"+MVCFABT+"/"+MVPIABT+"/"+MVABATIM+"/"+MVRECANT+"/"+MVPAGANT
						nApagVenc -= nSaldo
					Else
						nApagVenc += nSaldo
					Endif
				Else
					If E2VENC->E2_TIPO $ MVABATIM .or. E2VENC->E2_TIPO $ MV_CPNEG
						nApagVenc -= nSaldo
					Else
						nApagVenc += nSaldo
					Endif
				EndIf
				E2VENC->(dbSkip())
			Enddo
			E2VENC->(dbCloseArea())
			dbSelectArea("SE2")
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Soma Contas a pagar vencida pela data de Vencimento			  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dDataVenc := dDataBase-1
			dbSelectArea("SE2")
			If mv_par03 == 1 .And. nLenSelFil == 0		/* GESTAO */
				If lFirst
					RetIndex("SE2")
				EndIf
				dbSelectArea("SE2")
				SE2->(dbSetOrder(3))
				SE2->(dbSeek( cFilSE2 + DTOS(CTOD("01/01/60","ddmmyy")) ,.t.))
			Else
				dbGoTop()
			EndIf
			While ! SE2->(EOF()) .And. SE2->E2_VENCREA <= dDataVenc
					/*
					GESTAO - inicio */
				If nLenSelFil > 0
					cFilTmp := AllTrim(SE2->E2_FILIAL)
					nLenFil := Len(cFilTmp)
					If Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)}) == 0
						SE2->(DbSkip())
						Loop
					Endif
				Else
					IF mv_par03 == 1 .and. SE2->E2_FILIAL != cFilSE2
						Exit
					EndIf
					If mv_par03 == 2
						If lGestao .and. Substring(E2_FILIAL,1,nTamEmp)!=Substring(cFilSE2,1,nTamEmp)
							SE2->(dbSkip())
							Loop
						EndIf
					EndIf
				Endif
					/* GESTAO - fim
					*/
				If SE2->E2_TIPO $ MVPAGANT .And. cPaisLoc=="BRA"
					SE2->(dbSkip())
					Loop
				EndIf
				If ! ( AllTrim(Str(SE2->E2_MOEDA,2)) $ mv_par08 )
					dbSkip()
					Loop
				EndIf
				If SE2->E2_SALDO == 0 .and. IIf(mv_par11==1,SE2->E2_BAIXA <= dDataBase,.T.)
					SE2->(dbSkip())
					Loop
				EndIf
				IF SE2->E2_PREFIXO < mv_par09 .or. SE2->E2_PREFIXO > mv_par10  //Do Prefixo ao Prefixo
					SE2->(dbSkip())
					Loop
				EndIF
				If SE2->E2_FLUXO == "N" .or. (SE2->E2_EMIS1 > dDataBase .and. mv_par14 == 2)
					dbSkip()
					Loop
				EndIf
				If mv_par12 = 2
					If SE2->E2_MOEDA != nMoeda
						SE2->(dbSkip())
						Loop
					EndIf
				EndIf
				If mv_par11 == 1
					nSaldo := SaldoTit(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_NATUREZ,"P",SE2->E2_FORNECE,mv_par02,SE2->E2_VENCREA,dDataBase,SE2->E2_LOJA,,If(cPaisLoc=="BRA",SE2->E2_TXMOEDA,0), mv_par17)
				Else
					// Verifica se existe a taxa na data do vencimento do titulo, se nao existir, utiliza a taxa da database
					lTxMoeda := SM2->(MsSeek(SE2->E2_VENCREA)) .And. SM2->&("M2_MOEDA"+Alltrim(Str(mv_par02))) != 0
					nSaldo := xMoeda((SE2->E2_SALDO+SE2->E2_SDACRES-SE2->E2_SDDECRE),SE2->E2_MOEDA,mv_par02,,,If(cPaisLoc=="BRA",SE2->E2_TXMOEDA,0))
				EndIf
				If SE2->E2_TIPO $ MVABATIM+"/"+MV_CPNEG
					nApagVenc -= nSaldo
				Else
					nApagVenc += nSaldo
				EndIf
				SE2->(dbSkip())
			End
		Endif

        // Soma Contas a receber vencida pela data de Vencimento
		IF TcSrvType() != "AS/400"
			cRecPagAnt := FormatIn( MVRECANT + "/" + MVIRF, "/" )
			cOrdSE1 := SqlOrder(SE1->(Indexkey()))
			aStru := SE1->(DbStruct())
			cQuery := ""
			aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
			cQuery := "SELECT  " +SubStr(cQuery,2) + ", R_E_C_N_O_ RECNOSE1 "
			cQuery += " FROM " + RetSqlName("SE1") + " SE1 "
			/*
			GESTAO - inicio */
			If nLenSelFil > 0
				cQuery += "WHERE E1_FILIAL " + GetRngFil( aSelFil, "SE1", .T., @cTmpFil)
				Aadd(aTmpFil,cTmpFil)
			Else
				If mv_par03 == 1
					cQuery += "WHERE E1_FILIAL = '" + xFilial("SE1") + "'"
				Else
					If lGestao
						If UPPER(AllTrim(TcGetDb())) $ "DB2|ORACLE"
							cQuery += "WHERE SUBSTR(E1_FILIAL, 1,"+Str(nTamEmp)+" )= '"+ Substring(xFilial("SE1"), 1, nTamEmp)+"'"
						Else
							cQuery += "WHERE SUBSTRING(E1_FILIAL, 1,"+Str(nTamEmp)+" )= '"+ Substring(xFilial("SE1"), 1, nTamEmp)+"'"
						EndIf
					Else
						cQuery += "WHERE E1_FILIAL between ' ' AND 'zz'"
					EndIf
				Endif
			Endif
			/* GESTAO - fim
			*/
			cQuery += " AND E1_PREFIXO between '" + mv_par09 + "' AND '"+mv_par10 + "'"
			cQuery += " AND E1_MOEDA IN " + StrTran(FormatIn(AllTrim('0' + mv_par08),,1),"'","")
			cQuery += " AND (E1_VENCREA <= '" + Dtos(dDataBase-1) +"')"
			//cQuery += " OR (E1_MOVIMEN <> ' ' AND E1_MOVIMEN <= '" + Dtos(dDataBase-1) + "'))"
			If  cPaisLoc=="BRA"
				cQuery += " AND E1_TIPO NOT IN " + cRecPagAnt
			EndIf
			cQuery += " AND E1_SITUACA NOT IN " + FormatIn(cListDesc,"|")			//sitcob
			If mv_par11 == 2
				cQuery += " AND E1_SALDO > 0 "
			Endif
			If mv_par12 == 2
				cQuery += " AND E1_MOEDA = " + Str(nMoeda,2)
			Endif
			cQuery += " AND E1_FLUXO <> 'N'"
			//Considerar ou nao titulos com emissao posterior a database
			If mv_par14 == 2
				cQuery += " AND E1_EMISSAO <= '"+Dtos(dDataBase) +"'"
			Endif
			If mv_par19 == 2
				cQuery += " AND E1_FILIAL||E1_PREFIXO||E1_NUM||E1_PARCELA NOT IN ( "
				cQuery += " SELECT SE5.E5_FILIAL||SE5.E5_PREFIXO||SE5.E5_NUMERO||SE5.E5_PARCELA "
				cQuery += " FROM " + RetSqlName("SE5")  + " SE5 "
				cQuery += " WHERE  SE5.E5_TIPODOC IN ('ES') AND SE5.D_E_L_E_T_ = ' ' )"
			Endif
			cQuery += " AND D_E_L_E_T_ = ' '"
			cQuery += " ORDER BY " + cOrdSE1
			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"E1VENC",.T.,.T.)
			aEval(aStru, {|e| If(e[2]!= "C", TCSetField("E1VENC", e[1], e[2],e[3],e[4]),Nil)})
			oReport:SetMeter(RecCount())
			While !E1VENC->(EOF())
				oReport:IncMeter()
				SE1->(MsGoto(E1VENC->RECNOSE1))
				If mv_par11 == 1
					nSaldo := SaldoTit(E1VENC->E1_PREFIXO,E1VENC->E1_NUM,E1VENC->E1_PARCELA,E1VENC->E1_TIPO,E1VENC->E1_NATUREZ,"R",E1VENC->E1_CLIENTE,mv_par02,E1VENC->E1_VENCREA,dDataBase,E1VENC->E1_LOJA,,If(cPaisLoc=="BRA",E1VENC->E1_TXMOEDA,0), mv_par17)
					IF cPaisLoc == "BRA" .And. lMvBr10925 .and. E1VENC->E1_TIPO $ "PIS|COF|CSL" .and. E1VENC->E1_BAIXA <= dDatabase // Quando o parametro MV_BR10925 estiver igual a 1 - Baixa
						nSaldo -= E1VENC->E1_VALOR
					Endif
					IF E1VENC->E1_TIPO $ MVABATIM .AND. E1VENC->E1_BAIXA <= dDatabase  //Quando se trata de impostos (abatimento) o saldotit não funciona corretamente por nao tratar tais movimentos de baixa.
						nSaldo -= E1VENC->E1_VALOR
					Endif
					IF E1VENC->(E1_PIS+E1_CSLL+E1_COFINS) > 0 .AND. mv_par13 == 1 // Reteve impostos
						nSaldo -= SomaAbat(E1VENC->E1_PREFIXO,E1VENC->E1_NUM,E1VENC->E1_PARCELA,"R",mv_par02,,E1VENC->E1_CLIENTE,E1VENC->E1_LOJA,E1VENC->E1_FILIAL,E1VENC->E1_EMISSAO)
					Endif
				Else
					// Verifica se existe a taxa na data do vencimento do titulo, se nao existir, utiliza a taxa da database
					lTxMoeda := SM2->(MsSeek(E1VENC->E1_VENCREA)) .And. SM2->&("M2_MOEDA"+Alltrim(Str(mv_par02))) != 0
					nSaldo   := xMoeda((E1VENC->E1_SALDO+E1VENC->E1_SDACRES-E1VENC->E1_SDDECRE),E1VENC->E1_MOEDA,mv_par02,,,If(cPaisLoc=="BRA",E1VENC->E1_TXMOEDA,0))
					IF E1VENC->(E1_PIS+E1_CSLL+E1_COFINS) > 0 .AND. mv_par13 == 1 // Reteve impostos
						nSaldo -= SomaAbat(E1VENC->E1_PREFIXO,E1VENC->E1_NUM,E1VENC->E1_PARCELA,"R",mv_par02,,E1VENC->E1_CLIENTE,E1VENC->E1_LOJA,,E1VENC->E1_EMISSAO)
					Endif
				Endif
				// Se titulo do Template GEM
				If HasTemplate("LOT")  .And. !Empty(SE1->E1_NCONTR)
					If SE1->E1_VALOR == SE1->E1_SALDO .Or.;
					SE1->E1_VALOR == nSaldo //o titulo pode estar quitado(e1_saldo=0) mas valor em datas retroativas nao, portanto devera somar o valor do gem
						aAuxGem := ExecTemplate("CMDtPrc",.F.,.F.,{SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_VENCREA,SE1->E1_VENCREA})
						nSaldo += aAuxGem[2]
					EndIf
				EndIf
				If E1VENC->E1_SALDO > 0
					If cPaisLoc<>"BRA"
						IF Alltrim(E1VENC->E1_TIPO) $  MV_CRNEG+"/"+MV_CPNEG+"/"+MVIRABT+"/"+MVCSABT+"/"+MVCFABT+"/"+MVPIABT+"/"+MVABATIM+"/"+MVRECANT+"/"+MVPAGANT
							nArecVenc -= nSaldo
						Else
							nArecVenc += nSaldo
						EndIf
					Else
						IF E1VENC->E1_TIPO $ MVABATIM+"/"+MV_CRNEG
							nArecVenc -= nSaldo
						Else
							nArecVenc += nSaldo
						EndIf
					EndIf
				Else
					If cPaisLoc<>"BRA"
						IF Alltrim(E1VENC->E1_TIPO) $  MV_CRNEG+"/"+MV_CPNEG+"/"+MVIRABT+"/"+MVCSABT+"/"+MVCFABT+"/"+MVPIABT+"/"+MVABATIM+"/"+MVRECANT+"/"+MVPAGANT
							nAcumRc -= nSaldo
						Else
							nAcumRc += nSaldo
						EndIf
					Else
						IF E1VENC->E1_TIPO $ MVABATIM+"/"+MV_CRNEG
							nAcumRc -= nSaldo
						Else
							nAcumRc += nSaldo
						EndIf
					EndIf
				Endif

				//Quando o parametro mv_par19 = 2 e o titulo tiver estorno ele nao deve ser exibido no relatorio.
				If mv_par19 == 1 .or. mv_par19 == 2
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao dos titulos baixados p/ recebimento futuro.		  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If nSaldo <> 0  .And. E1VENC->E1_SALDO == 0
						If !lImpFut
							oReport:ThinLine()
							oReport:PrintText(STR0045) //"Títulos Baixados com Previsão de Movimentação Bancária Futura"
							lImpFut := .T.
						EndIf
						If E1VENC->E1_TIPO $ MVABATIM+"/"+MV_CRNEG
							nDispon  -= nSaldo
							nTotFutR -= nSaldo
						Else
							nDispon  += nSaldo
							nTotFutR += nSaldo
						EndIf
						oSection2:PrintLine()
					EndIf
				Endif
				E1VENC->(dbSkip())
			Enddo
			oReport:SkipLine()
			oReport:ThinLine()
			E1VENC->(dbCloseArea())
			dbSelectArea("SE1")
		Else

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Soma Contas a receber vencida pela data de Vencimento			  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SE1")
			If mv_par03 == 1
				If lFirst
					RetIndex("SE1")
				EndIf
				dbSelectArea("SE1")
				SE1->(dbSetOrder(7))
				SE1->(dbSeek( cFilSE1 + DTOS(CTOD("01/01/60","ddmmyy")),.T.))
			Else
				dbGoTop()
			EndIf
			While ! SE1->(EOF()) .And. (SE1->E1_VENCREA <= dDataBase-1) .Or. (!Empty(SE1->E1_MOVIMEN) .And. SE1->E1_MOVIMEN <= dDataBase-1)
				IF mv_par03 == 1 .and. cFilSE1 != SE1->E1_FILIAL
					Exit
				EndIf
				If mv_par03 == 2
					If lGestao .and. Substring(E1_FILIAL,1,nTamEmp)!=Substring(cFilSE1,1,nTamEmp)
						SE1->(dbSkip())
						Loop
					EndIf
				EndIf
				If SE1->E1_TIPO $ MVRECANT .And. cPaisLoc=="BRA"
					SE1->(dbSkip())
					Loop
				EndIf
				IF SE1->E1_PREFIXO < mv_par09 .or. SE1->E1_PREFIXO > mv_par10  //Do Prefixo ao Prefixo
					SE1->(dbSkip())
					Loop
				EndIF
				If ! ( AllTrim(Str(SE1->E1_MOEDA,2)) $ mv_par08 )
					dbSkip( )
					Loop
				EndIf
				If SE1->E1_FLUXO == "N" .or. (SE1->E1_EMISSAO > dDatabase .and. mv_par14 == 2)
					dbSkip()
					Loop
				EndIf
				If mv_par12 = 2
					If SE1->E1_MOEDA != nMoeda
						SE1->(dbSkip())
						Loop
					EndIf
				EndIf
				If mv_par11 == 1
					nSaldo := SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,mv_par02,SE1->E1_VENCREA,dDataBase,SE1->E1_LOJA,,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0), mv_par17)
				Else
					// Verifica se existe a taxa na data do vencimento do titulo, se nao existir, utiliza a taxa da database
					lTxMoeda := SM2->(MsSeek(SE1->E1_VENCREA)) .And. SM2->&("M2_MOEDA"+Alltrim(Str(mv_par02))) != 0
					nSaldo   := xMoeda((SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE),SE1->E1_MOEDA,mv_par02,,,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))
				End
				// Se titulo do Template GEM
				If HasTemplate("LOT")  .And. !Empty(SE1->E1_NCONTR)
					If SE1->E1_VALOR == SE1->E1_SALDO .Or.;
					SE1->E1_VALOR == nSaldup //o titulo pode estar quitado(e1_saldo=0) mas valor em datas retroativas nao, portanto devera somar o valor do gem
						aAuxGem := ExecTemplate("CMDtPrc",.F.,.F.,{SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_VENCREA,SE1->E1_VENCREA})
						nSaldo += aAuxGem[2]
					EndIf
				EndIf
				If SE1->E1_SALDO > 0
					IF SE1->E1_TIPO $ MVABATIM+"/"+MV_CRNEG
						nArecVenc -= nSaldo
					Else
						nArecVenc += nSaldo
					EndIf
				Else
					IF SE1->E1_TIPO $ MVABATIM+"/"+MV_CRNEG
						nAcumRc -= nSaldo
					Else
						nAcumRc += nSaldo
					EndIf
				Endif

				//Quando o parametro mv_par19 = 2 e o titulo tiver estorno ele nao deve ser exibido no relatorio.
				If mv_par19 == 1 .or. (mv_par19 == 2 .and. ListaES(xFilial("SE1")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao dos titulos baixados p/ recebimento futuro.		  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If nSaldo <> 0  .And. SE1->E1_SALDO == 0
						If !lImpFut
							oReport:ThinLine()
							oReport:PrintText(STR0045)	//"Títulos Baixados com Previsão de Movimentação Bancária Futura"
							lImpFut := .T.
						EndIf
						If SE1->E1_TIPO $ MVABATIM+"/"+MV_CRNEG
							nDispon  -= nSaldo
							nTotFutR -= nSaldo
						Else
							nDispon  += nSaldo
							nTotFutR += nSaldo
						EndIf
						oSection2:PrintLine()
					EndIf
				Endif
				SE1->(dbSkip())
			EndDo
			oReport:SkipLine()
			oReport:ThinLine()
			oSection2:Finish()
		Endif

		If nArecVenc # 0 .or. nApagVenc # 0
			nDispon += nArecVenc
			nDispon -= nApagVenc

			aDados2[DESC_TOTAL] := STR0018 // "Total De Títulos Vencidos"
			lBxFut := .F.
			lImpDev := .T.
			HabiCel(.F.,oReport)
			oSection2:PrintLine()
			HabiCel(.T.,oReport)
			aFill(aDados2,nil)
			oReport:SkipLine()
			lBxFut := .T.
			lImpDev := .F.
		Endif
	Endif
Else// Se for mostrar por visão Gerencial

	lBxFut := .F.
	FRVisaoGer(nDispon, @cArqTmp, oReport, nMoeda, nDecs, aSelFil)

	oSection2:Init()

	dbSelectArea("FJ3")
	dbSetOrder(1)
	dbGoTop()

	dbSelectArea("cArqTmp")
	nLastRec := LastRec()
	dbSetOrder(1)
	dbGoTop()

	// Impressão
	Do While CARQTMP->(!EOF())

		If FJ3->(dbSeek(xFilial("FJ3") + MV_PAR20 + AllTrim(CARQTMP->ORDEM))) //Procura pela descricao na FJ3 para impressao em branco

			If (mv_par06 == 1 .And. !lImpTitVen .And. CARQTMP->DATAAN < dDataBase)
				lImpTitVen		:= .T.
				nRecTmp 		:= CARQTMP->(Recno())
				RecLock("cArqTmp",.T.)
				CARQTMP->CODDESC := STR0057  // "Títulos vencidos"
				MsUnLock()			
				oSection2:PrintLine()						
				oReport:ThinLine()
				dbGoto(nRecTmp)					
			EndIf
			
			// Inverte o saldo se assim a entidade estiver configurada
			If FJ3->FJ3_FATSLD == "2" .And. !(FJ3->FJ3_IDENT $ "5" ) //Não for linha sem valor
				RecLock("cArqTmp", .F.)
				CARQTMP->ENTRADAS := -(CARQTMP->ENTRADAS)
				CARQTMP->SAIDAS   := -(CARQTMP->SAIDAS)
				CARQTMP->DISPON   := -(CARQTMP->DISPON)
				MsUnLock()
			EndIf

			// Imprimir traço
			If FJ3->FJ3_IDENT = '5' .And. Alltrim(FJ3->FJ3_DESCCG) == "-"
				oReport:ThinLine()
			EndIf
		EndIf
		
		If CARQTMP->(ENTRADAS <> 0 .or. SAIDAS <> 0 ) 
			oSection2:PrintLine()
		Endif

		CARQTMP->(dbSkip())		
		If (mv_par06 == 1 .And. lImpLine .And. SubStr(CARQTMP->CODDESC, 1, 10) <> "00/00/0000")														
			oReport:ThinLine()
			oReport:SkipLine()
			lImpLine := .F.
		EndIf
		
	EndDo
	cArqTmp->(dbCloseArea())

	oSection2:Finish()

	If _oFINR1401 <> Nil
		_oFINR1401:Delete()
		_oFINR1401 := Nil
	Endif
EndIf

If Empty(MV_PAR20)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Soma as Comissoes. Os criterios de selecao dos registros foram³
	//³determinados no instante da criacao do indice condicional.	  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if mv_par07 == 1
		DbSelectArea("SE3")
		dbGoTop()
		While !Eof() .and. SE3->E3_DATA <= dDataBase
			/*
			GESTAO - inicio */
			If nLenSelFil > 0
				cFilTmp := AllTrim(SE3->E3_FILIAL)
				nLenFil := Len(cFilTmp)
				If Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)}) == 0
					SE3->(DbSkip())
					Loop
				Endif
			Endif
			/* GESTAO - fim
			*/
			nComissoes += xMoeda(SE3->E3_COMIS,1,mv_par02)
			dbSkip()
		End

		If nComissoes # 0
			nDispon -= nComissoes
			aDados2[DESC_TOTAL] := STR0019 //"Total de Comissoes A Pagar"
			aDados2[VL_PAG] := nComissoes
			aDados2[VL_DIS] := nDispon
			lBxFut := .T.
			lImpDev := .T.
			HabiCel(.F.,oReport)
			oSection2:PrintLine()
			HabiCel(.T.,oReport)
			aFill(aDados2,nil)
			oReport:SkipLine()
		Endif
	Endif

	// Acessa titulos iniciais
	nDias := (dDataAte-dDataBase)
	oReport:SetMeter(nDias)

	// Verifica pedidos de venda
	If nImprPV <> 3
		fc020Venda( mv_par08, /*cAliasPv*/, /*aTotais*/, /*lRegua*/, mv_par02, /*aPeriodo*/, /*cFilIni*/, /*cFilFin*/,,,, aSelFil, .T.)
		aEval(aVendas, {|x| x[1] := max(x[1], dDataBase)})
		aSort(aVendas,,, {|x, y| dtos(x[1]) + x[6] + x[5] < dtos(y[1]) + y[6] + y[5]})
	Endif

	// Verifica pedidos de compra
	If nImprPC <> 3
		fc020Compra(/*cAliasPc*/,/*aTotais*/,/*lRegua*/,mv_par02,/*aPeriodo*/,/*cFilIni*/,/*cFilFin*/, /*cPedidos*/,,, aSelFil, .T.)
		aEval(aCompras, {|x| x[1] := max(x[1], dDataBase)})
		aSort(aCompras,,, {|x, y| dtos(x[1]) + x[6] + x[5] < dtos(y[1]) + y[6] + y[5]})
	Endif

	If nImprPv <> 3 .Or. nImprPC <> 3
		SE2->(DbGoTo(0))
	EndIf
	// Soma Contas a Receber pela data de Vencimento
	For nY := 1 To nDias
		dDataVenc := dDataBase + nY - 1
		lAchou := .F.
		dbSelectArea("SE1")
		If mv_par03 == 1 .And. nLenSelFil == 0		/* GESTAO */
			dbSetOrder(7)
			dbSeek( cFilSE1 + DTOS(dDataVenc) )
		Else
			dbSetOrder( nIndexSE1 )
			dbSeek(DTOS(dDataVenc))
		Endif
		oReport:IncMeter()
		While !Eof() .And. SE1->E1_VENCREA == dDataVenc
			/*
			GESTAO - inicio */
			If nLenSelFil > 0
				cFilTmp := AllTrim(SE1->E1_FILIAL)
				nLenFil := Len(cFilTmp)
				If Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)}) == 0
					SE1->(DbSkip())
					Loop
				Endif
			Else
				IF mv_par03 == 1 .and. SE1->E1_FILIAL != cFilSE1
					Exit
				EndIF
				IF mv_par03 == 2
					If lGestao .and. Substring(SE1->E1_FILIAL,1,nTamEmp )!= Substring(cFilSE1,1,nTamEmp )
						SE1->(dbSkip())
						Loop
					EndIf
				EndIF
			Endif
			/* GESTAO - fim
			*/
			If SE1->E1_TIPO $ MVRECANT
				dbSkip()
				Loop
			Endif
			IF SE1->E1_PREFIXO < mv_par09 .or. SE1->E1_PREFIXO > mv_par10  //Do Prefixo ao Prefixo
				SE1->(dbSkip())
				Loop
			EndIF
			If ! ( AllTrim(Str(SE1->E1_MOEDA,2)) $ mv_par08 )
				dbSkip( )
				Loop
			EndIf
			If SE1->E1_FLUXO == "N" .or. (SE1->E1_EMISSAO > dDatabase .and. mv_par14 == 2)
				dbSkip()
				Loop
			EndIf
			IF ( SE1->E1_SALDO = 0 .and. IIF( mv_par11 == 1, SE1->E1_BAIXA <= dDataBase, .T. )  ) .or. SE1->E1_SITUACA $ cListDesc //SITCOB
				dbSkip()
				Loop
			EndIF
			IF mv_par13 == 2 .And. SE1->E1_TIPO $ MVABATIM
				dbSkip()
				Loop
			EndIf
			If mv_par12 = 2
				If SE1->E1_MOEDA != nMoeda
					SE1->(dbSkip())
					Loop
				EndIf
			EndIf
			AAdd(aRecSE1,{SE1->E1_VENCREA,SE1->(Recno()),SE1->E1_NOMCLI})
			SE1->(dbSkip())
		EndDo
	Next nY

	// Ordena por data e cliente respectivamente.
	aRecSE1 := aSort(aRecSE1,,,{|x,y| DTOS(x[1])+x[3]<DTOS(y[1])+y[3]})
	oSection2:Init()
	For nY := 1 To nDias
		dDataVenc := dDataBase + nY - 1
		nPos := 0
		If (nPos := aScan(aRecSe1,{|x| x[1] == dDataVenc},1)) > 0
			While (nPos<=Len(aRecSe1)) .and. (aRecSe1[nPos][1] == dDataVenc)
				SE1->(dbGoTo(aRecSe1[nPos][2]))
				If mv_par11 == 1
					nSaldup := SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,mv_par02,SE1->E1_VENCREA,dDataBase,SE1->E1_LOJA,,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0), mv_par17)
				Else
					// Verifica se existe a taxa na data do vencimento do titulo, se nao existir, utiliza a taxa da database
					lTxMoeda := SM2->(MsSeek(SE1->E1_VENCREA)) .And. SM2->&("M2_MOEDA"+Alltrim(Str(mv_par02))) != 0
					nSaldup  := xMoeda((SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE),SE1->E1_MOEDA,mv_par02,If(lTxMoeda,SE1->E1_VENCREA,dDataBase),nDecs+1,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))
				End
				// Se titulo do Template GEM
				If HasTemplate("LOT")  .And. !Empty(SE1->E1_NCONTR)
					If SE1->E1_VALOR == SE1->E1_SALDO .Or.;
					SE1->E1_VALOR == nSaldup //o titulo pode estar quitado(e1_saldo=0) mas valor em datas retroativas nao, portanto devera somar o valor do gem
						aAuxGem := ExecTemplate("CMDtPrc",.F.,.F.,{SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_VENCREA,SE1->E1_VENCREA})
						nSaldup += aAuxGem[2]
					EndIf
				EndIf
				dbSelectArea("SE1")
				If mv_par03 == 1 .And. nLenSelFil == 0		/* GESTAO */
					dbSetOrder(7)
				Endif
				IF SE1->E1_TIPO $ MVABATIM+"/"+MV_CRNEG
					nDispon-=nSalDup
				Else
					nDispon+=nSalDup
				EndIf
				IF !lAchou
					dDataTrab := SE1->E1_VENCREA
					If SE1->E1_SITUACA $ cListBco 	// Situacoes que nao considera dias de retencao  //sitcob
						dDataVcOri := SE1->E1_VENCTO
						//Verifico se o proximo dia util apos o vencimento eh igual ao vencto real do titulo
						//Se for igual e o titulo estiver em cobranca, aplico os dias de retencao do banco
						//Se for diferente e o titulo estiver em cobranca, quer dizer que ja foram aplicados os dias de retencao
						//logo nao aplico novamente.
						If DtoS( DataValida( dDataVcOri ) ) == DtoS( dDataTrab )
							// Posiciona no banco para obter dias de retencao
							SA6->( dbSetOrder( 1 ) )
							SA6->( MsSeek( xFilial("SA6") + SE1->( E1_PORTADO + E1_AGEDEP + E1_CONTA ) ) )
							// Dias de retencao do banco em que o titulo esta
							nDiasRet := SA6->A6_RETENCA
							// Calcula proxima data valida (nao feriado) adicionados os dias de retencao
							For nX := 1 To nDiasRet
								dDataTrab := DataValida( dDataTrab + 1, .T. )
							Next
						EndIf
					EndIf
					aDados2[DT_VENC] := DTOC(dDataTrab)
				EndIF
				aDados2[PREFIXO] := SE1->E1_PREFIXO
				aDados2[TITUL] := SE1->E1_NUM+(If(!EMPTY(SE1->E1_PARCELA),"-",""))+SE1->E1_PARCELA
				aDados2[TIPO] := SE1->E1_TIPO
				aDados2[EMISSAO] := DTOC(SE1->E1_EMISSAO)
				aDados2[FORNEC] := SE1->E1_CLIENTE
				aDados2[LOJA] := SE1->E1_LOJA
				aDados2[NOM_FORNEC] := SubStr(SE1->E1_NOMCLI,1,25)
				aDados2[HISTORICO] := SubStr(SE1->E1_HIST,1,25)
				nAbatim := 0
				If mv_par13 == 2
					If mv_par14 == 1
						dOldData := dDataBase
						dDataBase := CTOD("31/12/40")
					Endif
					nAbatim := SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",mv_par02,,SE1->E1_CLIENTE,SE1->E1_LOJA,SE1->E1_FILIAL)

					If mv_par14 == 1
						dDataBase := dOldData
					Endif

				Endif
				nDescFin := FaDescFin("SE1",,SE1->E1_VALOR,SE1->E1_MOEDA)
				nSalDup -= nDescFin
				nDispon -= nDescFin
				nSalDup -= nAbatim
				nDispon -= nAbatim

				// Verifica se existe a taxa na data do vencimento do titulo, se nao existir, utiliza a taxa da database
				lTxMoeda := SM2->(MsSeek(dDataVenc)) .And. SM2->&("M2_MOEDA"+Alltrim(Str(mv_par02))) != 0
				aDados2[VL_ORIG] := xMoeda(SE1->E1_VALOR+SE1->E1_ACRESC-SE1->E1_DECRESC-nAbatim-nDescFin,SE1->E1_MOEDA,mv_par02,If(lTxMoeda,dDataVenc,dDataBase),,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))
				aDados2[VL_REC] := nSalDup
				aDados2[VL_DIS] := nDispon

				If mv_par02 != 1 .and. !lAchou
					aDados2[TAXA] := &('SM2->M2_MOEDA'+cSuf)
					dDataImp:=dDataVenc
				EndIf

				aDados2[FILORIG] := SE1->E1_FILORIG

				lBxFut := .T.
				lImpDev := .T.
				oSection2:PrintLine()
				aFill(aDados2,nil)

				lAchou:=.t.
				dbSelectArea("SE1")
				IF SE1->E1_TIPO $ MVABATIM+"/"+MV_CRNEG
					nTotTitR -= nSalDup
				Else
					nTotTitR += nSalDup
				End
				nPos += 1
			EndDo
		EndIf

		If cIpProj =="S"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se existe aplica‡„o a ser resgatada no dia				³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SEG")
			SE1->(DbGoTo(0)) //Desposiciona SE1 para não trazer informações desnecessárias quando relatório personalizado
			
			If mv_par03 == 1 .And. nLenSelFil == 0		/* GESTAO */
				dbSetOrder(2)
				dbSeek( cFilSEG + Dtos(dDataVenc) )
			Else
				dbSetOrder(nIndexSEG)
				dbSeek(Dtos(dDataVenc))
			Endif

			lAchou :=.f.
			While !Eof() .And. SEG->EG_DATARES == dDataVenc
				/*
				GESTAO - inicio */
				If nLenSelFil > 0
					cFilTmp := AllTrim(SEG->EG_FILIAL)
					nLenFil := Len(cFilTmp)
					If Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)}) == 0
						SEG->(DbSkip())
						Loop
					Endif
				ElseIF mv_par03 == 1 .and. SEG->EG_FILIAL != cFilSEG
					Exit
				Elseif mv_par03 == 2
					If lGestao .and. Substring(xFilial(),1,nTamEmp)!= Substring (SEG->EG_FILIAL,1,nTamEmp)
						SEG->(DbSkip())
						Loop
					EndIf
				Endif
				/* GESTAO - fim
				*/
				If SEG->EG_TIPO == "EMP"
					dbSkip( )
					Loop
				EndIf
				nDiasInt	:= EG_DATARES-EG_DATA	//Dias de Intervalo
				nJurDiario:= EG_TAXA/nDiasInt	  //Juros Diario
				nValJuros := EG_VALOR+((EG_VALOR*nJurDiario)/100)*nDiasInt
				nValGanho := nValJuros-EG_VALOR
				nValJuros -= nValGanho*EG_IMPOSTO/100 //Impostos
				IF mv_par02 == 1
					nDispon += nValJuros
				Else
					dbSelectArea("SM2")
					dbSeek( dDataVenc )
					nDispon += nValJuros/&('SM2->M2_MOEDA'+cSuf)
				EndIF
				dbSelectArea("SEG")

				IF !lAchou
					aDados2[DESC_TOTAL] := DtoC(EG_DATARES)
				EndIF

				aDados2[DESC_TOTAL] := PadR(aDados2[DESC_TOTAL], 11) + STR0021  // "Projecao de Resgate de Aplicacao "
				aDados2[DESC_TOTAL] += EG_TIPO + " - " + EG_BANCO
				aDados2[VL_ORIG] := If(mv_par02==1,EG_VALOR,EG_VALOR/&('SM2->M2_MOEDA'+cSuf))
				aDados2[VL_REC]  := If(mv_par02==1,nValJuros,nValJuros/&('SM2->M2_MOEDA'+cSuf))
				aDados2[VL_DIS]  := nDispon

				IF mv_par02!=1 .and. !lAchou
					dbSelectArea("SM2")
					dbSeek(dDataVenc)
					aDados2[TAXA] := &('SM2->M2_MOEDA'+cSuf)
				EndIF

				aDados2[FILORIG] := SEG->EG_FILIAL

				lAchou:=.T.

				HabiCel(.F.,oReport)
				lBxFut := .T.
				lImpDev := .T.
				oSection2:PrintLine()
				HabiCel(.T.,oReport)
				aFill(aDados2,nil)

				dbSelectArea("SEG")
				nTotTitR	+= IIF(mv_par02==1,nValJuros,nValJuros/&('SM2->M2_MOEDA'+cSuf))
				dbSkip()
			EndDo

			dbSelectArea("SEH")
			If mv_par03 == 1 .And. nLenSelFil == 0		/* GESTAO */
				dbSetOrder(2)
				dbSeek(xFilial("SEH")+"A")
			Else
				dbSetOrder(nIndexSEH)
				dbSeek("A")
			Endif

			lAchou := .f.
			While ( !Eof() .And.If((MV_PAR03==1 .And. nLenSelFil == 0),SEH->EH_FILIAL==xFilial("SEH"),.T.) .And.;
			SEH->EH_STATUS == "A" )

				If nLenSelFil > 0
					cFilTmp := AllTrim(SEH->EH_FILIAL)
					nLenFil := Len(cFilTmp)
					If Ascan(aSelFil, {|afil| cFilTmp == Substring(afil,1,nLenFil)}) == 0
						SEH ->(dbSkip())
						Loop
					Endif
				ElseIf mv_par03 == 2
					If lGestao .and. Substring(EH_FILIAL,1,nTamEmp)!=Substring(xFilial("SEH"),1,nTamEmp)
						SEH->(dbSkip())
						Loop
					Endif
				Endif

				If !(SEH->EH_DATA <= ( dDataBase + nDias)) // Verifica se esta no periodo solicitado
					SEH->(dbSkip())
					Loop
				Endif

				If ( SEH->EH_APLEMP != "EMP" )
					If ( Empty(SEH->EH_DATARES) .And. nY == 1 ) .Or. ((SEH->EH_DATARES < dDataVenc) .And. nY==1) .Or. ( SEH->EH_DATARES == dDataVenc )  
						nValJuros := SEH->EH_SALDO
						If !SEH->EH_TIPO $ cAplCotas
							aValAplic := Fa171Calc(	dDataVenc,,,,,,,, mv_par03 = 1)
							nValJuros += aValAplic[5]-aValAplic[2]-aValAplic[3]-aValAplic[4]
						Else
							aValAplic := {0,0,0,0,0,0}
						    nAscan := Ascan(aAplicSeh, {|e|	e[1] == SEH->EH_CONTRAT .And.;
							e[2] == SEH->EH_BCOCONT .And.;
							e[3] == SEH->EH_AGECONT})
							If nAscan > 0
								aValAplic :=	Fa171Calc(dDataVenc,SEH->EH_SLDCOTA,,,,SE9->E9_VLRCOTA,aAplicSeh[nAscan][6],(SEH->EH_SLDCOTA * aAplicSeh[nAscan][6]))
							Endif
							nValJuros := xMoeda(aValAplic[1]-(aValAplic[2]+aValAplic[3]+aValAplic[4]),nMoedaBco,nMoeda)
						Endif
					Else
						nValJuros := 0
					EndIf
					If ( nValJuros != 0 )
						nJurConv := xMoeda(nValJuros,SEH->EH_MOEDA,nMoeda,dDataVenc)
						nSalConv := xMoeda(SEH->EH_SALDO,SEH->EH_MOEDA,nMoeda,dDataVenc)
						nDispon  += nJurConv
						IF !lAchou
							aDados2[DESC_TOTAL] := DtoC(SEH->EH_DATARES)
						EndIF

						aDados2[DESC_TOTAL] := PadR(aDados2[DESC_TOTAL], 11) + STR0021  // "Projecao de Resgate de Aplicacao "
						aDados2[DESC_TOTAL] += SEH->(EH_TIPO + " - " + EH_BANCO)
						aDados2[VL_ORIG] := nSalConv
						aDados2[VL_REC]  := nJurConv
						aDados2[VL_DIS]  := nDispon

						IF ( MV_PAR02 != 1 .And. !lAchou )
							aDados2[TAXA] := RecMoeda(dDataVenc, nMoeda)
						EndIf

						aDados2[FILORIG] := SEH->EH_FILIAL

						HabiCel(.F.,oReport)
						lBxFut := .T.
						lImpDev := .T.
						oSection2:PrintLine()
						HabiCel(.T.,oReport)
						aFill(aDados2,nil)
					EndIf
					lAchou:=.T.
					nTotTitR	+= nJurConv

					If dDataVenc < SEH->EH_DATA
						dDataVenc := SEH->EH_DATA
					EndIf
				EndIf

				dbSelectArea("SEH")
				dbSkip()
			EndDo
		Endif

		dbSelectArea("SE2")
		SE1->(DbGoTo(0)) //Desposiciona SE1 para não trazer informações desnecessárias quando relatório personalizado
		If mv_par03 == 1 .And. nLenSelFil == 0		/* GESTAO */
			If lFirst
				RetIndex("SE2")
			End
			SE2->(dbSetOrder(3))
			SE2->(dbSeek( cFilSE2 + DTOS(dDataVenc) ,.t.) )
		Else
			dbSetOrder( nIndexSE2 )
			SE2->(dbSeek(DTOS(dDataVenc)),.t.)
		End

		lAchou := .f.
		While !Eof() .And. E2_VENCREA == dDataVenc
			/*
			GESTAO - inicio */
			If nLenSelFil > 0
				cFilTmp := AllTrim(SE2->E2_FILIAL)
				nLenFil := Len(cFilTmp)
				If Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)}) == 0
					SE2->(DbSkip())
					Loop
				Endif
			Else
				IF mv_par03 == 1 .and. E2_FILIAL != cFilSE2
					Exit
				EndIF
				If mv_par03 == 2
					If lGestao .and. Substring(E2_FILIAL,1,nTamEmp)!=Substring(cFilSE2,1,nTamEmp)
						SE2->(dbSkip())
						Loop
					EndIf
				EndIf
			Endif
			/* GESTAO - fim
			*/
			If SE2->E2_SALDO == 0 .and. IIf(mv_par11==1,SE2->E2_BAIXA <= dDataBase,.t.)
				SE2->(dbSkip())
				Loop
			End

			If mv_par12 = 2
				If SE2->E2_MOEDA != nMoeda
					SE2->(dbSkip())
					Loop
				EndIf
			EndIf

			If SE2->E2_BAIXA > dDataBase .And. mv_par11 == 1
				nSaldup  := SaldoTit(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_NATUREZ,"P",SE2->E2_FORNECE,mv_par02,SE2->E2_VENCREA,dDataBase,SE2->E2_LOJA,,If(cPaisLoc=="BRA",SE2->E2_TXMOEDA,0))

				// Calcula valores acessórios.
				nSaldup  += SE2->(FValAcess(E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA, E2_NATUREZ, /*lBaixados*/, /*cCodVa*/, "P", dDataBase, /*aValAces*/, E2_MOEDA, mv_par02, E2_TXMOEDA))
			Else
				// Verifica se existe a taxa na data do vencimento do titulo, se nao existir, utiliza a taxa da database
				lTxMoeda := SM2->(MsSeek(SE2->E2_VENCREA)) .And. SM2->&("M2_MOEDA"+Alltrim(Str(mv_par02))) != 0
				nSaldup  := xMoeda((SE2->E2_SALDO+SE2->E2_SDACRES-SE2->E2_SDDECRE),SE2->E2_MOEDA,mv_par02,,,If(cPaisLoc=="BRA",SE2->E2_TXMOEDA,0))

				// Calcula valores acessórios.
				nSaldup  += SE2->(FValAcess(E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA, E2_NATUREZ, /*lBaixados*/, /*cCodVa*/, "P", E2_VENCREA, /*aValAces*/, E2_MOEDA, mv_par02, E2_TXMOEDA))
			End

			IF mv_par13 == 2 .And. SE2->E2_TIPO $ MVABATIM
				dbSkip()
				Loop
			End
			If E2_TIPO $ MVPAGANT
				dbSkip( )
				Loop
			Endif

			IF SE2->E2_PREFIXO < mv_par09 .or. SE2->E2_PREFIXO > mv_par10  //Do Prefixo ao Prefixo
				SE2->(dbSkip())
				Loop
			EndIF

			If ! ( AllTrim(Str(SE2->E2_MOEDA,2)) $ mv_par08 )
				dbSkip()
				Loop
			End

			If SE2->E2_FLUXO == "N" .or. (SE2->E2_EMIS1 > dDataBase .and. mv_par14 == 2)
				dbSkip()
				Loop
			End

			dbSelectArea("SE2")
			If mv_par03 == 1 .And. nLenSelFil == 0		/* GESTAO */
				dbSetOrder(3)
			Endif

			IF E2_TIPO $ MVABATIM+"/"+MV_CPNEG
				nDispon+=nSalDup
			Else
				nDispon-=nSalDup
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se existe cheque sobre titulo e busca no  ³
			//³SEF para verificar se cheque esta liberado para    ³
			//³imprimir ou nao o titulo.                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SE2->E2_IMPCHEQ == "S" .And. lLibCheq
				aAreaSE2 := GetArea()
				dbSelectArea("SEF")
				SEF->(dbSetOrder(3))
				SEF->(MsSeek(xFilial("SEF")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO)))
				While SEF->(!Eof()) .And. lChqLiber .And.;
					SEF->(EF_FILIAL+EF_PREFIXO+EF_TITULO+EF_PARCELA+EF_TIPO) ==;
					xFilial("SEF")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO)


					If nLenSelFil > 0
						cFilTmp := AllTrim(SEF->EF_FILIAL)
						nLenFil := Len(cFilTmp)
						If Ascan(aSelFil, {|afil| cFilTmp == Substring(afil,1,nLenFil)}) == 0
							SEF ->(dbSkip())
							Loop
						Endif
					ElseIf mv_par03 == 2
						If lGestao .and. Substring(EF_FILIAL,1,nTamEmp)!=Substring(xFilial("SEF"),1,nTamEmp)
							SEF->(dbSkip())
							Loop
						Endif
					Endif

					If SEF->EF_ORIGEM = "FINA390TIT" .And. SEF->EF_LIBER == "S"
						lChqLiber := .F.
					EndIf
					SEF->(dbSkip())
				EndDo
				RestArea(aAreaSE2)
				If !lChqLiber
					SE2->(dbSkip())
					Loop
				EndIf
			EndIf

			IF !lAchou
				aDados2[DT_VENC] := dtoc(SE2->E2_VENCREA)
			EndIF

			aDados2[PREFIXO] := SE2->E2_PREFIXO
			aDados2[TITUL] := SE2->E2_NUM+(IIF(!EMPTY(SE2->E2_PARCELA),"-",""))+SE2->E2_PARCELA
			aDados2[TIPO] := SE2->E2_TIPO
			aDados2[EMISSAO] := DTOC(SE2->E2_EMISSAO)
			aDados2[FORNEC] := SE2->E2_FORNECE
			aDados2[LOJA] := SE2->E2_LOJA
			aDados2[NOM_FORNEC] := SubStr(SE2->E2_NOMFOR,1,25)
			aDados2[HISTORICO] := SubStr(SE2->E2_HIST,1,25)

			nAbatim := 0
			If mv_par13 == 2

				//Quando considerar Titulos com emissao futura, eh necessario
				//colocar-se a database para o futuro de forma que a Somaabat()
				//considere os titulos de abatimento
				If mv_par14 == 1
					dOldData := dDataBase
					dDataBase := CTOD("31/12/40")
				Endif

				nAbatim := SomaAbat(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,"P",mv_par02,,SE2->E2_FORNECE,SE2->E2_LOJA,SE2->E2_FILIAL)

				If mv_par14 == 1
					dDataBase := dOldData
				Endif

			Endif
			nSaldup -= nAbatim
			nDispon -= nAbatim
			If cPaisLoc <> "BRA" .And. (E2_TIPO $ MV_CPNEG	 .Or. ( SE2->E2_TIPO $ MVPAGANT .And. (!Empty(SE2->E2_ORDPAGO) .Or. cPaisLoc =="ARG")))
				nVlrImp:= (SE2->E2_VALOR+SE2->E2_ACRESC-SE2->E2_DECRESC-nAbatim) * -1
			Else
				nVlrImp:= (SE2->E2_VALOR+SE2->E2_ACRESC-SE2->E2_DECRESC-nAbatim)
			EndIf
			// Verifica se existe a taxa na data do vencimento do titulo, se nao existir, utiliza a taxa da database
			lTxMoeda := SM2->(MsSeek(dDataVenc)) .And. SM2->&("M2_MOEDA"+Alltrim(Str(mv_par02))) != 0

			aDados2[VL_ORIG] := xMoeda(nVlrImp,SE2->E2_MOEDA,mv_par02,If(lTxMoeda,dDataVenc,dDataBase),,If(cPaisLoc=="BRA",SE2->E2_TXMOEDA,0))
			IF cPaisLoc <> "BRA" .And. E2_TIPO $ MVPAGANT+"/"+MV_CPNEG
				aDados2[VL_PAG] := nSalDup * -1
			Else
				aDados2[VL_PAG] := nSalDup
			Endif
			aDados2[VL_DIS] := nDispon

			IF mv_par02!=1 .and. !lAchou
				aDados2[TAXA] := RecMoeda(dDataVenc, MV_PAR02)
			EndIF

			aDados2[FILORIG] := SE2->E2_FILORIG

			lBxFut := .T.
			lImpDev := .T.
			oSection2:PrintLine()
			aFill(aDados2,nil)

			lAchou:=.T.
			dbSelectArea("SE2")
			IF E2_TIPO $ MVABATIM+"/"+MV_CPNEG
				nTotTitP -= nSalDup
			Else
				nTotTitP += nSalDup
			End
			dbSkip()
		End

		If cIpProj =="S"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se existe emprestimo a pagar no dia.					  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea( "SEG" )
			If mv_par03 == 1 .And. nLenSelFil == 0
				dbSetOrder(2)
				dbSeek( cFilSEG + Dtos(dDataVenc) )
			Else
				dbSetOrder( nIndexSEG )
				dbSeek(Dtos(dDataVenc))
			Endif

			lAchou := .f.

			While !Eof() .And. EG_DATARES == dDataVenc
				/*
				GESTAO - inicio */
				If nLenSelFil > 0
					cFilTmp := AllTrim(SEG->EG_FILIAL)
					nLenFil := Len(cFilTmp)
					If Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)}) == 0
						SEG->(DbSkip())
						Loop
					Endif
				Else
					IF mv_par03 == 1 .and. EG_FILIAL != cFilSEG
						Exit
					EndIf
					If mv_par03 == 2
						If lGestao .and. Substring(EG_FILIAL,1,nTamEmp)!=Substring(cFilSEG,1,nTamEmp)
							SEG->(dbSkip())
							Loop
						EndIf
					EndIf
				Endif
				/* GESTAO - fim
				*/
				If SEG->EG_TIPO != "EMP"
					dbSkip( )
					Loop
				EndIf

				nDiasInt	:= EG_DATARES-EG_DATA	//Dias de Intervalo
				nJurDiario:= EG_TAXA/nDiasInt	  //Juros Diario
				nValJuros := EG_VALOR+((EG_VALOR*nJurDiario)/100)*nDiasInt
				nValGanho := nValJuros-EG_VALOR
				nValJuros -= nValGanho*EG_IMPOSTO/100 //Impostos
				IF mv_par02 == 1
					nDispon -= nValJuros
				Else
					dbSelectArea("SM2")
					dbSeek( dDataVenc )
					nDispon -= nValJuros/&('SM2->M2_MOEDA'+cSuf)
				EndIF
				dbSelectArea("SEG")

				IF !lAchou
					aDados2[DESC_TOTAL] := DtoC(EG_DATARES)
				EndIF

				aDados2[DESC_TOTAL] := PadR(aDados2[DESC_TOTAL], 11) + STR0022 + EG_TIPO + " - " + EG_BANCO  //"Projecao de Pagamento de Emprestimo "
				aDados2[VL_ORIG] := If(mv_par02==1,EG_VALOR,EG_VALOR/&('SM2->M2_MOEDA'+cSuf))
				aDados2[VL_PAG] := If(mv_par02==1,nValJuros,nValJuros/&('SM2->M2_MOEDA'+cSuf))
				aDados2[VL_DIS] := nDispon

				IF mv_par02!=1 .and. !lAchou
					dbSelectArea("SM2")
					dbSeek(dDataVenc)
					aDados2[TAXA] := &('SM2->M2_MOEDA'+cSuf)
				EndIF

				aDados2[FILORIG] := SEG->EG_FILIAL

				lAchou:=.T.

				HabiCel(.F.,oReport)
				lBxFut := .T.
				lImpDev := .T.
				oSection2:PrintLine()
				HabiCel(.T.,oReport)
				aFill(aDados2,nil)

				dbSelectArea("SEG")
				nTotTitP	+= IIF(mv_par02==1,nValJuros,nValJuros/ &('SM2->M2_MOEDA'+cSuf))
				dbSkip()
			End
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se existe emprestimo a pagar no dia.					  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SEH")
			If ( MV_PAR03 == 1 ) .And. nLenSelFil == 0		/* GESTAO */
				dbSetOrder(2)
				dbSeek(xFilial("SEH")+"A")
			Else
				dbSetOrder( nIndexSEH )
				dbSeek("A")
			Endif

			lAchou := .f.
			While ( !Eof() .And. If(MV_PAR03==1,SEH->EH_FILIAL==xFilial("SEH"), .T. ) .And.;
			SEH->EH_STATUS=="A" )
				/*
				GESTAO - inicio */
				If nLenSelFil > 0
					cFilTmp := AllTrim(SEH->EH_FILIAL)
					nLenFil := Len(cFilTmp)
					If Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)}) == 0
						SEH->(DbSkip())
						Loop
					Endif
				Else
					If mv_par03 == 2
						If lGestao .and. Substring(EH_FILIAL,1,nTamEmp)!=Substring(cFilSEH,1,nTamEmp)
							SEH->(dbSkip())
							Loop
						EndIf
					EndIf
				Endif
				/* GESTAO - fim
				*/
				If ( SEH->EH_APLEMP == "EMP" )
					If ( Empty(SEH->EH_DATARES) .And. nY == 1 ) .Or. ( SEH->EH_DATARES == dDataVenc )
						nValJuros := xMoeda(SEH->EH_SALDO,SEH->EH_MOEDA,nMoeda)
						aValAplic := Fa171Calc(dDataVenc,,,,,,,, mv_par03 = 1)
						If Len(aValAplic) > 0
							nValJuros += xMoeda(aValAplic[2,2],SEH->EH_MOEDA,nMoeda)
						Endif
					Else
						nValJuros := 0
					EndIf
					If ( nValJuros != 0 )

						IF !lAchou
							aDados2[DESC_TOTAL] := If( !Empty(SEH->EH_DATARES) , DtoC(SEH->EH_DATARES),nil )
						EndIf

						aDados2[DESC_TOTAL] := PadR(aDados2[DESC_TOTAL], 11) + STR0022 +SEH->EH_TIPO+" - "+SEH->EH_BANCO  //"Projecao de Pagamento de Emprestimo "
						aDados2[VL_ORIG] := nValJuros
						aDados2[VL_PAG] := nValJuros

						If ( MV_PAR02!=1 .And. !lAchou )
							aDados2[TAXA] := RecMoeda(dDataVenc, MV_PAR02)
						EndIf

						aDados2[FILORIG] := SEH->EH_FILIAL

						HabiCel(.F.,oReport)
						lBxFut := .T.
						lImpDev := .T.
						oSection2:PrintLine()
						HabiCel(.T.,oReport)
						aFill(aDados2,nil)
					EndIf

					lAchou:=.T.

					If dDataVenc < SEH->EH_DATA
						dDataVenc := SEH->EH_DATA
					EndIf
				EndIf
				dbSelectArea("SEH")
				dbSkip()
			EndDo
		Endif

		// Imprime os pedidos de venda.
		If Len(aVendas) > 0
			nEl := Ascan(aVendas, {|e| e[1] == dDataVenc})
			IF nEl > 0
				If nImprPV == 1  // Sintético.
					nX := 0
					nValor := 0
					Do While nEl <= Len(aVendas) .And. aVendas[nEl, 1] == dDataVenc
						nValor += aVendas[nEl, 2]
						nEl++
						nX++
					EndDo

					nDispon += nValor
					aDados2[DT_VENC]    := DtoC(dDataVenc)
					aDados2[DESC_TOTAL] := STR0023 + " - " + cValToChar(nX) + " " + STR0054 // "Pedidos de Vendas" "pedido(s)"
					aDados2[VL_REC]     := nValor
					aDados2[VL_DIS]     := nDispon

					IF mv_par02 != 1
						dbSelectArea("SM2")
						Seek dDataVenc
						aDados2[TAXA] := &('SM2->M2_MOEDA' + cSuf)
					EndIF

					aDados2[FILORIG] := ""

					lBxFut := .T.
					lImpDev := .T.
					HabiCel(.F.,oReport)
					oSection2:PrintLine()
					HabiCel(.T.,oReport)
					aFill(aDados2, nil)
					nTotTitR += nValor
				Else
					Do While nEl <= Len(aVendas) .And. aVendas[nEl, 1] == dDataVenc

						aDados2[DT_VENC] := DtoC(dDataVenc)
						aDados2[TITUL]   := If(Len(aSelFil) > 1, aVendas[nEl, 6] + " - ", "") + aVendas[nEl, 5]
						aDados2[TIPO]    := STR0052 // "PV"

						SC5->(dbSetOrder(1))  // C5_FILIAL, C5_NUM.
						If SC5->(dbSeek(aVendas[nEl, 6] + aVendas[nEl, 5], .F.))
							aDados2[EMISSAO] := DTOC(SC5->C5_EMISSAO)
							aDados2[FORNEC]  := SC5->C5_CLIENTE
							aDados2[LOJA]    := SC5->C5_LOJACLI
							If SC5->C5_TIPO $ "DB"
								SA2->(dbSetOrder(1))  // A2_FILIAL, A2_COD, A2_LOJA.
								If SA2->(msSeek(xFilial() + SC5->(C5_CLIENTE + C5_LOJACLI), .F.))
									aDados2[NOM_FORNEC] := AllTrim(SA2->A2_NOME)
								Endif
							Else
								SA1->(dbSetOrder(1))  // A1_FILIAL, A1_COD, A1_LOJA.
								If SA1->(msSeek(xFilial() + SC5->(C5_CLIENTE + C5_LOJACLI), .F.))
									aDados2[NOM_FORNEC] := AllTrim(SA1->A1_NOME)
								Endif
							Endif
							aDados2[FILORIG] := SC5->C5_FILIAL
						Endif

						nValor := aVendas[nEl, 2]
						nDispon += nValor
						aDados2[VL_REC] := nValor
						aDados2[VL_DIS] := nDispon

						IF mv_par02 != 1
							dbSelectArea("SM2")
							Seek dDataVenc
							aDados2[TAXA] := &('SM2->M2_MOEDA' + cSuf)
						EndIF

						lBxFut := .T.
						lImpDev := .T.
						oSection2:PrintLine()
						aFill(aDados2, nil)
						nTotTitR += nValor

						nEl++
					EndDo
				Endif
			EndIF
		EndIF

		// Imprime os pedidos de compra.
		IF Len(aCompras) > 0
			nEl := Ascan(aCompras, {|e| e[1] == dDataVenc})
			IF nEl > 0
				If nImprPC == 1  // Sintético.
					nX := 0
					nValor := 0
					Do While nEl <= Len(aCompras) .And. aCompras[nEl, 1] == dDataVenc
						nValor += aCompras[nEl, 2]
						nEl++
						nX++
					EndDo

					nDispon -= nValor
					aDados2[DT_VENC]    := DtoC(dDataVenc)
					aDados2[DESC_TOTAL] := STR0024 + " - " + cValToChar(nX) + " " + STR0054 // "Pedidos de Compras" "pedido(s)"
					aDados2[VL_PAG]     := nValor
					aDados2[VL_DIS]     := nDispon

					IF mv_par02 != 1
						dbSelectArea("SM2")
						Seek dDataVenc
						aDados2[TAXA] := &('SM2->M2_MOEDA' + cSuf)
					EndIF

					aDados2[FILORIG] := ""

					lBxFut := .T.
					lImpDev := .T.
					HabiCel(.F.,oReport)
					oSection2:PrintLine()
					HabiCel(.T.,oReport)
					aFill(aDados2, nil)
					nTotTitP += nValor
				Else
					Do While nEl <= Len(aCompras) .And. aCompras[nEl, 1] == dDataVenc

						aDados2[DT_VENC] := DtoC(dDataVenc)
						aDados2[TITUL]   := If(Len(aSelFil) > 1, aCompras[nEl, 6] + " - ", "") + aCompras[nEl, 5]
						aDados2[TIPO]    := STR0053 // "PC"

						SC7->(dbSetOrder(1))  // C7_FILIAL, C7_NUM, C7_ITEM, C7_SEQUEN.
						If SC7->(dbSeek(aCompras[nEl, 6] + aCompras[nEl, 5], .F.))
							aDados2[EMISSAO] := DTOC(SC7->C7_EMISSAO)
							aDados2[FORNEC]  := SC7->C7_FORNECE
							aDados2[LOJA]    := SC7->C7_LOJA
							SA2->(dbSetOrder(1))  // A2_FILIAL, A2_COD, A2_LOJA.
							If SA2->(msSeek(xFilial() + SC7->(C7_FORNECE + C7_LOJA), .F.))
								aDados2[NOM_FORNEC] := AllTrim(SA2->A2_NOME)
							Endif
							aDados2[FILORIG] := SC7->C7_FILIAL
						Endif

						nValor := aCompras[nEl, 2]
						nDispon -= nValor
						aDados2[VL_PAG] := nValor
						aDados2[VL_DIS] := nDispon

						IF mv_par02 != 1
							dbSelectArea("SM2")
							Seek dDataVenc
							aDados2[TAXA] := &('SM2->M2_MOEDA' + cSuf)
						EndIF

						lBxFut := .T.
						lImpDev := .T.
						oSection2:PrintLine()
						aFill(aDados2, nil)
						nTotTitP += nValor

						nEl++
					EndDo
				Endif
			EndIF
		EndIF

		//--------------------------------------------------------------
		// Solicitacoes de Fundo
		//--------------------------------------------------------------
		If lSolFund

			DbSelectArea("SA2")

			DbSelectArea("FJA")
			If MV_PAR03 == 1 .And. nLenSelFil == 0		//Imprime por - Filial		/* GESTAO */
				FJA->(DbSetOrder(5)) //FJA_FILIAL+FJA_DATAPR
				FJA->(DbSeek( cFilFJA + DToS(dDataVenc)) )
			Else //Imprime por - Empresa
				DbSetOrder(nIndexFJA)
				DbSeek(DToS(dDataVenc))
			Endif

			lAchou :=.F.
			While FJA->(!Eof()) .And. FJA_DATAPR == dDataVenc
				/*
				GESTAO - inicio */
				If nLenSelFil > 0
					cFilTmp := AllTrim(FJA->FJA_FILIAL)
					nLenFil := Len(cFilTmp)
					If Ascan(aSelFil,{|afil| cFilTmp == Substr(afil,1,nLenFil)}) == 0
						FJA->(DbSkip())
						Loop
					Endif
				Else
					If MV_PAR03 == 1 .And. FJA_FILIAL != cFilFJA
						Exit
					EndIf
					If mv_par03 == 2
						If lGestao .and. Substring(FJA_FILIAL,1,nTamEmp)!=Substring(cFilFJA,1,nTamEmp)
							FJA->(dbSkip())
							Loop
						EndIf
					EndIf
				Endif
				/* GESTAO - fim
				*/
				// Solicitacoes de fundo Pendentes ou Aprovadas sem OP associada
				If ( FJA->FJA_ESTADO <> "1" .AND. FJA->FJA_ESTADO <> "2" )
					DbSkip()
					Loop
				EndIf

				nDispon -= XMoeda(FJA->FJA_VALOR,Val(FJA->FJA_MOEDA),MV_PAR02,dDataVenc)

				If !lAchou .And. MV_PAR02 != 1 //Moeda
					DbSelectArea("SM2")
					DbSeek(dDataVenc)
					aDados2[TAXA] := &('SM2->M2_MOEDA'+cSuf)
				EndIf

				If !lAchou
					aDados2[DT_VENC] := dtoc(FJA->FJA_DATAPR)
				EndIf

				aDados2[PREFIXO]	:= ""
				aDados2[TITUL]		:= FJA->FJA_SOLFUN
				aDados2[EMISSAO]	:= DTOC(FJA->FJA_DATA)
				aDados2[FORNEC]		:= FJA->FJA_FORNEC
				aDados2[LOJA]       := FJA->FJA_LOJA
				aDados2[NOM_FORNEC]	:= SubStr(GetAdvFVal("SA2","A2_NOME",xFilial("SA2")+FJA->(FJA_FORNEC+FJA_LOJA),1,"",.T.),1,25)
				aDados2[HISTORICO]	:= SubStr(FJA->FJA_OBSERV,1,25)
				aDados2[VL_ORIG]	:= XMoeda(FJA->FJA_VALOR,Val(FJA->FJA_MOEDA),MV_PAR02,dDataVenc)
				aDados2[VL_PAG]		:= XMoeda(FJA->FJA_VALOR,Val(FJA->FJA_MOEDA),MV_PAR02,dDataVenc)
				aDados2[VL_DIS]		:= nDispon
				aDados2[FILORIG]    := FJA->FJA_FILIAL

				lBxFut := .T.
				lImpDev := .T.
				oSection2:PrintLine()

				aFill(aDados2,Nil)

				lAchou := .T.

				//----------------------------------------------
				// Adiciona o valor no total de titulos a pagar
				//----------------------------------------------
				nTotTitP += XMoeda(FJA->FJA_VALOR,Val(FJA->FJA_MOEDA),MV_PAR02,dDataVenc)

				FJA->(DbSkip())
			EndDo
		EndIf

		//------------------------
		// Imprime o total do dia
		//------------------------
		If nTotTitR !=0 .or. nTotTitP != 0
			oReport:SkipLine()
			aDados2[DESC_TOTAL] := STR0025 + DtoC(dDataVenc) // "Total Do Dia ---> "
			aDados2[VL_PAG] := nTotTitP
			aDados2[VL_REC] := nTotTitR
			aDados2[VL_DIS] := nDispon
			lBxFut := .T.
			lImpDev := .T.
			HabiCel(.F.,oReport)
			oSection2:PrintLine()
			HabiCel(.T.,oReport)
			aFill(aDados2,nil)
			oReport:SkipLine()
			nTotGTitR += nTotTitR
			nTotGTitP += nTotTitP
			nTotTitP := 0
			nTotTitR := 0
		Endif
	Next nY

	oReport:SkipLine()
	aDados2[DESC_TOTAL] := STR0026  //"Total Geral  --->"
	aDados2[VL_PAG] := nTotGTitP+nApagVenc
	aDados2[VL_REC] := nTotGTitR+nTotFutR+nArecVenc
	aDados2[VL_DIS] := nDispon

	HabiCel(.F.,oReport)
	lBxFut := .T.
	lImpDev := .T.
	oSection2:PrintLine()
	HabiCel(.T.,oReport)
	aFill(aDados2,nil)

	oSection2:Finish()
EndIf

/*
GESTAO - inicio */
If !Empty(aTmpFil)
	For nX := 1 To Len(aTmpFil)
		CtbTmpErase(aTmpFil[nX])
	Next
Endif
/* GESTAO - fim
*/

// Contas a receber
RetIndex("SE1")
dbSelectArea("SE1")
SE1->(dbSetOrder(1))
SE1->(dbClearFilter())

// Contas a pagar
RetIndex("SE2")
dbSelectArea("SE2")
SE2->(dbSetOrder(1))
SE2->(dbClearFilter())

// Comissao de vendas
RetIndex("SE3")
dbSelectArea("SE3")
SE3->(dbSetOrder(1))
SE3->(dbClearFilter())

// Movimentacao bancaria
RetIndex("SE5")
dbSelectArea("SE5")
SE5->(dbSetOrder(1))
SE5->(dbClearFilter())

// Contas Corrente
RetIndex("SA6")
dbSelectArea("SA6")
SA6->(dbSetOrder(1))
SA6->(dbClearFilter())

// Saldos bancarios
RetIndex("SE8")
dbSelectArea("SE8")
SE8->(dbSetOrder(1))
SE8->(dbClearFilter())

// Controle de aplicacoes
RetIndex("SEG")
dbSelectArea("SEG")
SEG->(dbSetOrder(1))
SEG->(dbClearFilter())

RetIndex("SEH")
dbSelectArea("SEH")
SEH->(dbSetOrder(1))
SEH->(dbClearFilter())

Ferase(cArqSEH+OrdBagExt())
Ferase(cArqSEG+OrdBagExt())
Ferase(cArqSE2+OrdBagExt())
Ferase(cArqSE1+OrdBagExt())
Ferase(cArqSE3+OrdBagExt())
Ferase(cArqSE8+OrdBagExt())
Ferase(cArqSA6+OrdBagExt())

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³HabiCel	³ Autor ³ Daniel Tadashi Batori ³ Data ³ 15/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³habilita ou desabilita celulas para imprimir totais.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ HabiCel()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lHabilit->.T. para habilitar e .F. para desabilitar		  ³±±
±±³			 ³ oReport ->objeto TReport que possui as celulas             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function HabiCel(lHabilit, oReport)

Local oSection2 := oReport:Section(2)

If Empty(MV_PAR20)
	If lHabilit
		oSection2:Cell("TOTAL"):Disable()
		oSection2:Cell("TOTAL2"):Disable()
		oSection2:Cell("E2_NOMFOR"):Enable()
		oSection2:Cell("E2_HIST"):Enable()
	Else
		oSection2:Cell("TOTAL"):Enable()
		oSection2:Cell("TOTAL2"):Enable()
		oSection2:Cell("E2_NOMFOR"):Disable()
		oSection2:Cell("E2_HIST"):Disable()
	EndIf
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR770   ºAutor  ³Microsiga           º Data ³  08/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que montara o arquivo temporario para impressao     º±±
±±º          ³ do relatorio com visao gerencial financeira                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FRVisaoGer(nDispon, cArqTmp, oReport, nMoeda,nDecs, aSelFil)

	Local dDataAnt 		As Date
	Local dDataAte 		As Date	
	Local dVencto		As Date
	Local cAliasTit 	As Character		
	Local cColuna 		As Character	
	Local cTable 		As Character
	Local cIdenti		As Character
	Local aStru 		As Array
	Local aVencto 		As Array
	Local nSaldo 		As Numeric
	Local nSaldoTit		As Numeric	

	dDataAnt 	:= dDataBase
	dDataAte 	:= dDataBase + MV_PAR01 
	dVencto 	:= CTOD("  /  /  ")
	cAliasTit	:= ""		
	cColuna 	:= ""
	cTable		:= ""
	cIdenti		:= ""
	aStru 	 	:= {}		
	aVencto 	:= {}
	nSaldo 		:= 0
	nSaldoTit	:= 0 	

	AADD(aStru,{"FILIAL"   ,"C",TAMSX3("E1_FILIAL")[1],0})
	AADD(aStru,{"NATUREZA" ,"C",TAMSX3("E1_NATUREZ")[1],0})
	AADD(aStru,{"RECPAG"   ,"C",1,0})
	AADD(aStru,{"VENCREA" ,"D",8,0})
	AADD(aStru,{"TITRECNO" ,"N",8,0})

	If __cSGBD == Nil
		__cSGBD := AllTrim(Upper(TcGetDb()))
	EndIf
	
	CriaTmpImp()
	dbSelectARea("cArqTmp")
	dbSetOrder(1)
	
	CriaTmpVis(@cColuna)
	
	CriaTMPTit(AClone(aStru))

	InsTmpTit(@cAliasTit, dDataAte, aSelFil)	
	
	FwFreeArray(aStru)
	
	cTable := _oFINR1402:GetRealName()

	FJ3->(dbGoTop())	
	FJ3->(DbSetOrder(2))

	If FJ3->(dbSeek(xFilial("FJ3") + mv_par20 ))
		While (FJ3->(!EOF()) .And. FJ3->FJ3_CODPLA == mv_par20 )			
			// Se for analitica -  busco por naturezas
			If (!Empty(FJ3->FJ3_SEDINI) .And. !Empty(FJ3->FJ3_SEDFIM))
				cIdenti := FJ3->FJ3_IDENT
				
				InsertNat( FJ3->FJ3_SEDINI, FJ3->FJ3_SEDFIM )
				(cAliasTit)->(DbGoTop())
				(cAliasTit)->(DbGoTo(Recno()))
				
				While (cAliasTit)->(!(EoF()))
					
					If (cAliasTit)->RECPAG == "R"
						SE1->(dbGoto((cAliasTit)->TITRECNO))
						dVencto 	:= SE1->E1_VENCREA	
						nSaldoTit 	:= SE1->E1_SALDO					
					Else 
						SE2->(dbGoto((cAliasTit)->TITRECNO))	
						dVencto 	:= SE2->E2_VENCREA
						nSaldoTit 	:= SE2->E2_SALDO							
					EndIf					

					If ASCAN(aVencto,dVencto ) == 0 
						AADD(aVencto,dVencto)
						InsTmpvis(dVencto, cColuna, cTable)
					EndIf			

					nSaldo := FGetSaldo((cAliasTit)->RECPAG, dVencto)

					TRB4->(dbSetOrder(2))
					If TRB4->(dbSeek(mv_par20 + FJ3->FJ3_CONTAG + DTOS(dVencto)))
						If nSaldoTit > 0							 
							
							If (((cAliasTit)->RECPAG == "R" .And. SE1->E1_TIPO $ (MVABATIM+"|"+MV_CRNEG)) .Or. ;
								(cAliasTit)->RECPAG == "P" .And. SE2->E2_TIPO $ (MVABATIM+"|"+MV_CPNEG))						
								RecLock("TRB4",.F.)
								If (cAliasTit)->RECPAG == "R"
									TRB4->FJ3_REC -= nSaldo									
								Else
									TRB4->FJ3_PAGO -= nSaldo	
								EndIf															
							Else
								RecLock("TRB4",.F.)
								If (cAliasTit)->RECPAG == "R"
									If cIdenti == "1"
										TRB4->FJ3_REC += nSaldo
									Else
										TRB4->FJ3_REC -= nSaldo
									EndIf
								Else
									If cIdenti == "1"	
										TRB4->FJ3_PAGO += nSaldo	
									Else
										TRB4->FJ3_PAGO -= nSaldo	
									EndIf
								EndIf									
							EndIf																	
							TRB4->(MsUnLock())									
						Endif	
					EndIf			
					(cAliasTit)->(DbSkip())
				End									
				ClrTmpNat()
			EndIf
			
			FJ3->(DbSkip())			
		End		

		//Atualiza sinteticas
		AtuSintet()	

		//Grava arquivo para impressão
		GrvArqImp(cArqTmp)
		
		//Atuliza disponivel 
		AtuDispon(nDispon,cArqTmp)	
		
		cArqTmp->(dbSetOrder(1))

		TRB4->(dbCloseArea())

		If _oFINR1402 <> Nil
			_oFINR1402:Delete()
			_oFINR1402 := Nil
		Endif
	EndIf

	If __oTitTMP <> Nil
		__oTitTMP:Delete()
		__oTitTMP := Nil
	Endif
	
	If __oTitNAT <> Nil
		__oTitNAT:Delete()
		__oTitNAT := Nil
	Endif		

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ListaES    ³ Autor ³ Andrea Verissimo      ³ Data ³17/12/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄ--ÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³Essa funcao checa se o registro tem algum movimento bancario ³±±
±±³          ³do tipo ES.                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³.F. - em caso de nao listar o titulo pq ele tem ESTORNO.     ³±±
±±³          ³.T. - listar o titulo pq nao tenho ESTORNO.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nro da Filial, Prefixo, Numero, Parcela                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ListaES(cChavES)
Local cRetorno := .T.
Local aArea    := GetArea()

Static cAliasListaES := Nil

If cAliasListaES == Nil
	cAliasListaES := Criatrab(,.F.)
Endif

Default cChavES := ""

If !Empty(cChavES)
	BeginSql Alias cAliasListaES
		SELECT SE5.E5_FILIAL, SE5.E5_PREFIXO, SE5.E5_NUMERO, SE5.E5_PARCELA
		FROM %table:SE5% SE5
		WHERE SE5.E5_FILIAL + SE5.E5_PREFIXO + SE5.E5_NUMERO + SE5.E5_PARCELA = %exp:cChavES%
		AND SE5.E5_TIPODOC = "ES"
		AND SE5.%notDel%
		ORDER BY %Order:SE5%
	EndSql

	If !(cAliasListaES)->(Eof())
		cRetorno := .F.
	EndIf

	(cAliasListaES)->(DbCloseArea())
Endif

RestArea(aArea)

Return (cRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR770   ºAutor  ³Microsiga           º Data ³  08/18/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Calcula saldo com base na formula digitada                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CNICalc140 ()

Local cSuperior := TRB4->FJ3_CTASUP // Conta Superior
Local nCont     := TRB4->(Recno())
Local nFator    := 0

//Procurar nas superiores e somar ou subtrair
Do While TRB4->(!Bof()) .And. (!Empty(cSuperior))

	//Ralizar calculo com a formula digitada pelo usuario
	If (cSuperior == TRB4->FJ3_CONTAG)
		If (Left(TRB4->FJ3_FORMUL, 7) == "ROTINA=")
			nFator := &(Subs(TRB4->FJ3_FORMUL, 8))

			RecLock("TRB4",.F.)
			TRB4->FJ3_DISP *= nFator
			TRB4->(MsUnLock())

		ElseIf Left(TRB4->FJ3_FORMUL, 6) == "FATOR="
			nFator := &(Subs(TRB4->FJ3_FORMUL, 7))

			RecLock("TRB4",.F.)
			TRB4->FJ3_DISP *= nFator
			TRB4->(MsUnLock())

		Elseif Left(TRB4->FJ3_FORMUL,6 ) == "SALDO="
			nFator := &(Subs(TRB4->FJ3_FORMUL, 7))

			RecLock("TRB4",.F.)
			TRB4->FJ3_DISP := nFator
			TRB4->(MsUnLock())

		EndIf
	EndIf

	cSuperior := TRB4->FJ3_CTASUP
	TRB4->(dbSkip(-1))
EndDo

TRB4->(dbGoto(nCont))// Posiciona no ultimo registro

Return

//-------------------------------------------------------------------------------
/*/{Protheus.doc} Finr140Emp
Retorna as empresas/unidades de negócios e filiais, pertencentes ao grupo de empresas de emissão do relatório

@author Pâmela Bernardo
@since 20/04/2021

@version P12
/*/
//-------------------------------------------------------------------------------
Static Function Finr140Emp() as Array

	local aSM0 		as Array
	Local nTamSM0 	as Numeric
	Local nx 		as Numeric
	Local aRet		as Array

	aSM0	:= FWLoadSM0()
	nTamSM0	:= len(aSM0)
	nx		:= 0
	aRet	:= {}

	For nx:= 1 to nTamSM0
		If aSM0 [nx, SM0_GRPEMP] == cEmpAnt
			aadd(aRet, aSM0 [nx])
		EndIf
	Next nx

Return aRet

/*/{Protheus.doc} InsertNat
Pesquisa os títulos (pagar/receber) conforme range de natureza informado.

@type 	Function
@author Simone Mie Sato Kakinoana
@since	24/10/2022
@param	cRecPag, character, R se carteira a receber, P se carteira a pagar
@param	cNatIni, character, natureza inicial do range
@param	cNatFim, character, natureza final do range
@param	lTitVenc, logical, indica se considera titulos vencidos
@return	Nil
/*/
Static Function InsertNat(cNatIni As Character, nNatFim As Character)

	Local cWhere	As Character

	cAliasTit := ""

	Default cNatIni		:= ""
	Default cNatFim		:= ""

	__cCposTit := "FILIAL, NATUREZA, RECPAG, VENCREA, TITRECNO  "

	If __cInsNat1 == Nil
		__cInsNat1 := " INSERT "
		If "ORACLE" $ __cSGBD
			__cInsNat1 += " /*+ APPEND */ "
		EndIf
		__cInsNat1 += " INTO " + __oTitNAT:GetRealName()  +   "( " +__cCposTit  +" ) "
		__cInsNat1 += " SELECT " + __cCposTit 
		__cInsNat1 += " FROM " + __oTitTMP:GetRealName() + " "
	EndIf
	cWhere := " WHERE NATUREZA BETWEEN '" + cNatIni + "' AND '" + nNatFim + "'"		
	cWhere += " ORDER BY NATUREZA, VENCREA"

	If TCSQLExec(__cInsNat1 + cWhere) < 0
		 UserException(TCSQLError())
	EndIf	

Return Nil

/*/{Protheus.doc} CriaTMPImp
Cria as tabelas temporárias para Impressão

@type 	Function
@author Simone Mie Sato Kakinoana
@since	26/10/2022

/*/
Static Function CriaTMPImp()

	Local aCampos		As Array
	
	aCampos := {{"CONTAG","C",TamSX3("FJ3_CONTAG")[1] ,0},;
	{"CODDESC","C",60 ,0},;
	{"CTASUP","C",TamSX3("FJ3_CTASUP")[1] ,0},;
	{"ENTRADAS","N",17,2},;
	{"SAIDAS","N",17,2},;
	{"DISPON","N",17,2},;
	{"DATAAN","D",8,0},;
	{"CLASSE","C",1 ,0},;
	{"ORDEM","C",17,0}}

	_oFINR1401 := FWTemporaryTable():New( "cArqTmp" )
	_oFINR1401:SetFields(aCampos)
	_oFINR1401:AddIndex("1", {"DATAAN","ORDEM"})
	_oFINR1401:AddIndex("2", {"DATAAN","CONTAG"})

	_oFINR1401:Create()

Return Nil

/*/{Protheus.doc} CriaTmpVis
Cria a tabela temporária da Visão

@type 	Function
@author Simone Mie Sato Kakinoana
@since	26/10/2022

/*/
Static Function CriaTMPVis(cColuna aS character)

	Local nTamFil    As Numeric
	Local nTamCodPla As Numeric
	Local nTamOrd    As Numeric
	Local nTamContag As Numeric
	Local nTamCtaSup As Numeric
	Local nTamDscCg  As Numeric
	Local nTamDetHcg As Numeric
	Local nTamNorm   As Numeric
	Local nTamCol    As Numeric
	Local nTamClas   As Numeric
	Local nTamIdent  As Numeric
	Local nTamNome   As Numeric
	Local nTamLin    As Numeric
	Local nTamSedIn  As Numeric
	Local nTamSedFm  As Numeric
	Local nTamForm   As Numeric
	Local nTamTvsIs  As Numeric
	Local nTamVisEnt As Numeric
	Local nTamSldEnt As Numeric
	Local nTamFatSld As Numeric
	Local nJ 		 As Numeric
	Local aEstruct	 As Array	

	Default cColuna := ""		
	
	nTamFil    := TamSX3("FJ3_FILIAL")[1]
	nTamCodPla := TamSX3("FJ3_CODPLA")[1]
	nTamOrd    := TamSX3("FJ3_ORDEM")[1]
	nTamContag := TamSX3("FJ3_CONTAG")[1]
	nTamCtaSup := TamSX3("FJ3_CTASUP")[1]
	nTamDscCg  := TamSX3("FJ3_DESCCG")[1]
	nTamDetHcg := TamSX3("FJ3_DETHCG")[1]
	nTamNorm   := TamSX3("FJ3_NORMAL")[1]
	nTamCol    := TamSX3("FJ3_COLUNA")[1]
	nTamClas   := TamSX3("FJ3_CLASSE")[1]
	nTamIdent  := TamSX3("FJ3_IDENT")[1]
	nTamNome   := TamSX3("FJ3_NOME")[1]
	nTamLin    := TamSX3("FJ3_LINHA")[1]
	nTamSedIn  := TamSX3("FJ3_SEDINI")[1]
	nTamSedFm  := TamSX3("FJ3_SEDFIM")[1]
	nTamForm   := TamSX3("FJ3_FORMUL")[1]
	nTamTvsIs  := TamSX3("FJ3_TOTVIS")[1]
	nTamVisEnt := TamSX3("FJ3_VISENT")[1]
	nTamSldEnt := TamSX3("FJ3_SLDENT")[1]
	nTamFatSld := TamSX3("FJ3_FATSLD")[1]

	aEstruct	:= {}
	
	//Define as colunas e suas propriedades para criar a tabela temporaria TRB4
	AADD(aEstruct,{"FJ3_REC"   ,"N",17,2})
	AADD(aEstruct,{"FJ3_PAGO"  ,"N",17,2})
	AADD(aEstruct,{"FJ3_DISP"  ,"N",17,2})
	AADD(aEstruct,{"FJ3_FILIAL","C",nTamFil,0})
	AADD(aEstruct,{"FJ3_CODPLA","C",nTamCodPla,0})
	AADD(aEstruct,{"FJ3_ORDEM" ,"C",nTamOrd,0})
	AADD(aEstruct,{"FJ3_CONTAG","C",nTamContag,0})
	AADD(aEstruct,{"FJ3_CTASUP","C",nTamCtaSup,0})
	AADD(aEstruct,{"FJ3_DESCCG","C",nTamDscCg,0})
	AADD(aEstruct,{"FJ3_DETHCG","C",nTamDetHcg,0})
	AADD(aEstruct,{"FJ3_NORMAL","C",nTamNorm,0})
	AADD(aEstruct,{"FJ3_COLUNA","N",nTamCol,0})
	AADD(aEstruct,{"FJ3_CLASSE","C",nTamClas,0})
	AADD(aEstruct,{"FJ3_IDENT" ,"C",nTamIdent,0})
	AADD(aEstruct,{"FJ3_NOME"  ,"C",nTamNome,0})
	AADD(aEstruct,{"FJ3_LINHA" ,"C",nTamLin,0})
	AADD(aEstruct,{"FJ3_SEDINI","C",nTamSedIn,0})
	AADD(aEstruct,{"FJ3_SEDFIM","C",nTamSedFm,0})
	AADD(aEstruct,{"FJ3_FORMUL","C",nTamForm,0})
	AADD(aEstruct,{"FJ3_TOTVIS","C",nTamTvsIs,0})
	AADD(aEstruct,{"FJ3_VISENT","C",nTamVisEnt,0})
	AADD(aEstruct,{"FJ3_SLDENT","C",nTamSldEnt,0})
	AADD(aEstruct,{"FJ3_FATSLD","C",nTamFatSld,0})
	AADD(aEstruct,{"FJ3_DATA"  ,"D",8,0})

	//Armazena colunas para utilizar no insert de dados na tabela temporaria TRB4
	for nJ := 1 to Len( aEstruct )
		If nJ  > 1 
			cColuna += "," + aEstruct[nJ][1]
		Else
			cColuna += aEstruct[nJ][1]
		EndIf
	next nJ

	_oFINR1402 := FWTemporaryTable():New( "TRB4" )
	_oFINR1402:SetFields(aEstruct)

	//Adiciono o índice da tabela temporária
	_oFINR1402:AddIndex("1",{"FJ3_CODPLA","FJ3_ORDEM"})
	_oFINR1402:AddIndex("2",{"FJ3_CODPLA","FJ3_CONTAG","FJ3_DATA"})
	_oFINR1402:AddIndex("3",{"FJ3_CODPLA","FJ3_DATA","FJ3_CONTAG"})

	_oFINR1402:Create()
	
Return Nil

/*/{Protheus.doc} InsTmpVis
Insere os dados na tabela da visão gerencial por data

@type 	Function
@author Simone Mie Sato Kakinoana
@since	27/10/2022

/*/
Static Function InsTmpvis( dVencto as Date, cColuna as Character, cTable as Character)

	Local cQueryVis  As Character	
	Local cInsert    As Character
	Local nProcQry   As Numeric
	
	Default dVencto := CTOD("  /  /  ")
	Default cColuna := ""	
	Default cTable	:= ""

	cQueryVis   := ""
	cInsert     := ""	
	nProcQry	:= 0
	
	If __oFJ3NAT == Nil
		cQueryVis := " SELECT 0 as FJ3_REC, 0 AS FJ3_PAGO, 0 AS FJ3_DISP,FJ3.FJ3_FILIAL,FJ3.FJ3_CODPLA,FJ3.FJ3_ORDEM,FJ3.FJ3_CONTAG,FJ3.FJ3_CTASUP,"
		cQueryVis += " FJ3.FJ3_DESCCG,FJ3.FJ3_DETHCG,FJ3.FJ3_NORMAL,FJ3.FJ3_COLUNA,FJ3.FJ3_CLASSE,FJ3.FJ3_IDENT,FJ3.FJ3_NOME,FJ3.FJ3_LINHA,"
		cQueryVis += " FJ3.FJ3_SEDINI,FJ3.FJ3_SEDFIM,FJ3.FJ3_FORMUL,FJ3.FJ3_TOTVIS,FJ3.FJ3_VISENT,FJ3.FJ3_SLDENT,FJ3.FJ3_FATSLD," 
		cQueryVis += " ?  FJ3_DATA "
		cQueryVis += " FROM " + RetSqlName("FJ3") + " FJ3 "
		cQueryVis += " WHERE FJ3_CODPLA = '" + MV_PAR20 + "' "
		cQueryVis += " AND FJ3.D_E_L_E_T_ = ' ' "
		cQueryVis := ChangeQuery(cQueryVis)	

		__oFJ3NAT := FWPreparedStatement():New(cQueryVis)
		
	EndIf 
	__oFJ3NAT:SetString(1, DTOS(dVencto) )
	cQueryVis := __oFJ3NAT:GetFixQuery()
	
	cInsert := " INSERT "
	If "ORACLE" $__cSGBD	
		cInsert += " /*+ APPEND */ "
	EndIf

	cInsert += " INTO " + cTable + " ("+cColuna+" ) " + cQueryVis

	//Executo o comando para alimentar a tabela temporária
	Processa({|| nProcQry := TcSQLExec(cInsert)})

	If nProcQry != 0
		UserException( TCSqlError() )
	EndIf

Return Nil

/*/{Protheus.doc} CriaTMPTit
Cria as tabelas temporárias para títulos a receber e pagar.

@type 	Function
@author Simone Mie Sato Kakinoana
@since	24/10/2022
@param 	aStru, array, campos a serem criados na tabela temporária

/*/
Static Function CriaTMPTit(aStru As Array)

	DEFAULT aStru := {}
	
	__oTitTMP  := FwTemporaryTable():New()
	__oTitNAT  := FwTemporaryTable():New()
	__oTitTMP:SetFields(aStru)
	__oTitNAT:SetFields(aStru)

	__oTitTMP:AddIndex("1", {"NATUREZA"})		
	__oTitNAT:AddIndex("1", {"NATUREZA"})
	
	__oTitTMP:Create()
	__oTitNAT:Create()

Return Nil

/*/{Protheus.doc} ClrTmpNat
Realiza a limpeza das tabela de títulos a receber/pagar por natureza

@type 	Function
@author Simone Mie Sato Kakinoana
@since	25/10/2022
/*/
Static Function ClrTmpNat()

	If TCSQLExec("TRUNCATE TABLE " + __oTitNAT:GetRealName()) < 0
		 UserException(TCSQLError())
	EndIf
	
	If __lMetric
		TCRefresh(__oTitNAT:GetTableNameForTCFunctions())
	Else
		TCRefresh(__oTitNAT:cTableName)
	EndIf

Return Nil

/*/{Protheus.doc} AtuDispon
Atualiza disponivel das analiticas

@type 	Function
@author Simone Mie Sato Kakinoana
@since	02/10/2022
Atuliza coluna disponivel das analiticas

@return	Nil
/*/
Static Function AtuDispon(nDispon as Numeric, cArqTmp As character)

	Local cQuery 		As Character
	Local cAliasDisp	As Character	
	Local cSuperior		As Character

	Default nDispon := 0
	Default cArqTmp := ""

	cAliaSDisp		:= GetNextAlias()
	cQuery 			:= ""
	cSuperior 		:= ""
	
	cQuery 			:= " SELECT DATAAN, CONTAG, CTASUP, ENTRADAS, SAIDAS, ORDEM, R_E_C_N_O_ RECDISP "
	cQuery 			+= " FROM "+ _oFINR1401:GetRealName() 
	cQuery			+= " WHERE CLASSE ='2' " 
	cQuery 			+= " ORDER BY DATAAN, ORDEM "		
	cQuery 			:= ChangeQuery( cQuery )

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasDisp, .F., .T. )

	cArqTmp->(dbSetOrder(2))	
	dbSelectArea(cAliasDisp)

	While (cAliasDisp)->(!Eof())

		cArqTmp->(dbGoto((cAliasDisp)->RECDISP))
		cSuperior := cArqTmp->CTASUP

		Reclock("cArqTmp",.F.)
		cArqTmp->DISPON	:= nDispon + (cAliasDisp)->ENTRADAS - (cAliasDisp)->SAIDAS
		cArqTmp->(MsUnlock())		
		nRecTmp := cArqTmp->(Recno())
		nDispon := cArqTmp->DISPON

		While cArqTmp->(!Eof())

			If cArqTmp->(DbSeek( (cAliasDisp)->DATAAN + cSuperior ))
				RecLock("cArqTmp",.F.)								
				cArqTmp->DISPON  := nDispon
				cArqTmp->(MsUnLock())			
			EndIf

			dbSelectArea("cArqTmp")
			If !Eof() .And. Empty(cArqTmp->CTASUP)
				dbSelectArea("cArqTmp")
				Exit
			EndIf
			cSuperior 	:= cArqTmp->CTASUP
		End	
		
		(cAliasDisp)->(dbSkip()) 
	End			

	If Select(cAliasDisp) > 0
		(cAliasDisp)->(dbCloseArea())
	Endif
	dbSelectarea("cArqTmp")	
Return

/*/{Protheus.doc} AtuSintet
Atualiza sintetica

@type 	Function
@author Simone Mie Sato Kakinoana
@since	26/10/2022
Chama função de Atualização de Natureza superior

@return	Nil
/*/
Static Function AtuSintet()

	Local cQuery 		As Character
	Local cAliaSint		As Character

	cQuery 			:= ""
	cAliaSint		:= GetNextAlias()	
	
	cQuery 			:= " SELECT FJ3_DATA, FJ3_CTASUP, FJ3_IDENT, SUM(FJ3_REC) FJ3_REC, SUM(FJ3_PAGO) FJ3_PAGO, SUM(FJ3_DISP) FJ3_DISP "
	cQuery 			+= " FROM "+ _oFINR1402:GetRealName() 
	cQuery			+= " WHERE FJ3_CLASSE ='2' " 	
	cQuery 			+= " AND ( FJ3_REC <> 0 OR FJ3_PAGO <> 0  )"
	cQuery 			+= " GROUP BY FJ3_DATA, FJ3_CTASUP, FJ3_IDENT "
	cQuery 			:= ChangeQuery( cQuery )

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliaSint, .F., .T. )

	dbSelectArea(cAliaSint)
	While (cAliaSint)->(!Eof())
		
		AtuNatSup(cAliaSint)

		(cAliaSint)->(dbSkip()) 
	End

	If Select(cAliaSint) > 0
		(cAliaSint)->(dbCloseArea())
	Endif
	
Return
/*/{Protheus.doc} AtuNatSup
Atualiza natureza superior

@type 	Function
@author Simone Mie Sato Kakinoana
@since	25/10/2022

@param	cAlias, character, alias para atualização da superior
/*/
Static Function AtuNatSup(cAlias)
	
	Local cSuperior As Character	
	Local cIdenti   As Character 	
	Local dDtVenc  	As Date	
	Local nCont 	As Numeric

	Default cAlias 	:= ""
	
	cSuperior := (cAlias)->FJ3_CTASUP 	
	cIdenti	  := (cAlias)->FJ3_IDENT
	dDtVenc   := (cAlias)->FJ3_DATA
	nCont     := (cAlias)->(Recno())	

	dbSelectArea("TRB4")
	dbSetOrder(2)			
	dbGotop()

	While TRB4->(!Eof())

		If TRB4->(MsSeek(mv_par20 + cSuperior + dDtVenc))
			TRB4->FJ3_DATA := STOD(dDtVenc)
			If (cIdenti == '1')
				RecLock("TRB4",.F.)								
				TRB4->FJ3_REC  += (cAlias)->FJ3_REC				
				TRB4->FJ3_PAGO += (cAlias)->FJ3_PAGO				
				TRB4->(MsUnLock())
			Else
				RecLock("TRB4",.F.)				
				TRB4->FJ3_REC  -= (cAlias)->FJ3_REC				
				TRB4->FJ3_PAGO -= (cAlias)->FJ3_PAGO				
				TRB4->(MsUnLock())
			EndIf			
		EndIf

		dbSelectArea("TRB4")
		If !Eof() .And. Empty(TRB4->FJ3_CTASUP)
			dbSelectArea("TRB4")
			Exit
		EndIf
		cSuperior 	:= TRB4->FJ3_CTASUP
	EndDo	

	(cAlias)->(DbGoTo(nCont))
	
Return

/*/{Protheus.doc} InsTmpTit
Insere dados na tabela temporária

@type 	Function
@author Simone Mie Sato Kakinoana
@since	29/10/2022

@param	cAliasTit, character, alias para inclusão dos títulos de acordo com o filtro
@param	dDataAte, date, Data final a ser considerada
@return	Nil
/*/
Static Function InsTmpTit(cAliasTit As Character, dDataAte As Date, aSelFil As Array)

	Local cTitTMP 		As Character
	Local cInsertTit 	As Character
	Local cFilFwSE2		As Character
	Local cFilFwSE1		As Character
	Local cLisFil 		As Character
	Local cQuery		As Character
	Local cRecAnt 		As Character
	Local cPagAnt 		As Character
	Local cListDesc 	As Character
	Local nTamEmp 		As Numeric

	Default cAliasTit := ""
	Default dDataAte  := dDataBase
	Default aSelFil	  := {}

	__cCposTit	 := " FILIAL, NATUREZA, RECPAG, VENCREA "

	cTitTMP 	:= __oTitTMP:GetRealName()
	cAliasTit	:= __oTitNAT:GetAlias()
	cRecAnt  	:= FormatIn( MVRECANT + "/" + MVIRF, "/" )
	cPagAnt  	:= FormatIn( MVPAGANT, "/" )
	cListDesc 	:= FN022LSTCB(2)
	nTamEmp 	:= Len(FwCodEmp())
	cInsertTit 	:= " INSERT "	
	cLisFil	    := SelectFil(aSelFil)

	If Right(cListDesc,1)== '|'
		cListDesc := Subs(cListDesc,1,Len(cListDesc)-1)
	EndIf

	IF lGestao
		cFilFwSE1	:= FwFilial("SE1") 
		cFilFwSE2	:= FwFilial("SE2") 
	Else
		cFilFwSE1	:= xFilial("SE1") 
		cFilFwSE2	:= xFilial("SE2")
	EndIf

	If "ORACLE" $ __cSGBD
		cInsertTit += " /*+ APPEND */ "
	EndIf

	cInsertTit += " INTO " + cTitTMP  + " (" + __cCposTit  + ", TITRECNO) "

	cQuery := " SELECT E1_FILIAL FILIAL, E1_NATUREZ NATUREZA, 'R' RECPAG, SE1.E1_VENCREA VENCREA, SE1.R_E_C_N_O_ TITRECNO "
	cQuery += " FROM " + RetSQLName("SE1") + " SE1 "
	cQuery += " WHERE  "
	If Empty( cFilFwSE1 )
		cQuery += "E1_FILORIG IN ("+cLisFil+")  "
	Else
		cQuery += "E1_FILIAL IN ("+cLisFil+") "
	EndIf		
	cQuery += " AND SE1.E1_PREFIXO BETWEEN '" + mv_par09 + "' AND '"+mv_par10 + "'"
	cQuery += " AND SE1.E1_MOEDA IN " + StrTran(FormatIn(AllTrim('0' + mv_par08),,1),"'","")
	If  mv_par06 == 1 .And. mv_par14 == 2 
		cQuery += " AND (SE1.E1_EMISSAO <= '" + Dtos(dDataBase) +"')"		 			 				
	ElseIf  mv_par06 == 2 .And. mv_par14 == 1 		
		cQuery += " AND (SE1.E1_VENCREA >= '" + Dtos(dDataBase) +"')"		 
	ElseIf mv_par06 == 2 .And. mv_par14 == 2
		cQuery += " AND (SE1.E1_EMISSAO <= '" + Dtos(dDataBase) +"')"		 			 
		cQuery += " AND (SE1.E1_VENCREA >= '" + Dtos(dDataBase) +"')"		 
	Endif
	cQuery += " AND (SE1.E1_VENCREA < '" + Dtos(dDataAte) +"')"	
	If  cPaisLoc=="BRA"
		cQuery += " AND SE1.E1_TIPO NOT IN " + cRecAnt
	EndIf
	cQuery += " AND SE1.E1_SITUACA NOT IN " + FormatIn(cListDesc,"|")			
	cQuery += " AND  ( SE1.E1_SALDO > 0 "
	If mv_par11 == 1
		cQuery += " OR SE1.E1_BAIXA > '" + DTOS(dDataBase) + "'" 		
	Endif
	cQuery += " ) "
	If mv_par12 == 2
		cQuery += " AND SE1.E1_MOEDA = " + Str(mv_par02,2)
	Endif
	If mv_par13 == 2
		cQuery += " AND SE1.E1_TIPO NOT IN " + FormatIn(MVABATIM + "|" + MV_CRNEG,"|") 
	End	
	cQuery += " AND SE1.E1_FLUXO <> 'N'"	
	cQuery += " AND SE1.D_E_L_E_T_ = ' '"
	cQuery += " UNION "
	cQuery += "SELECT E2_FILIAL FILIAL, E2_NATUREZ NATUREZA, 'P' RECPAG, SE2.E2_VENCREA VENCREA, SE2.R_E_C_N_O_ TITRECNO "
	cQuery += "FROM " + RetSQLName("SE2") + " SE2 "	
	cQuery += " WHERE "	
	If Empty( cFilFwSE2 )
		cQuery += "E2_FILORIG IN ("+cLisFil+") "
	Else
		cQuery += "E2_FILIAL IN ("+cLisFil+") "
	EndIf			
	cQuery += " AND SE2.E2_PREFIXO BETWEEN '" + mv_par09 + "' AND '"+mv_par10 + "'"
	cQuery += " AND SE2.E2_MOEDA IN " + StrTran(FormatIn(AllTrim('0' + mv_par08),,1),"'","")	
	If  mv_par06 == 1 .And. mv_par14 == 2 
		cQuery += " AND (SE2.E2_EMISSAO <= '" + Dtos(dDataBase) +"')"		 			 				
	ElseIf  mv_par06 == 2 .And. mv_par14 == 1 		
		cQuery += " AND (SE2.E2_VENCREA >= '" + Dtos(dDataBase) +"')"		 
	ElseIf mv_par06 == 2 .And. mv_par14 == 2
		cQuery += " AND (SE2.E2_EMISSAO <= '" + Dtos(dDataBase) +"')"		 			 
		cQuery += " AND (SE2.E2_VENCREA >= '" + Dtos(dDataBase) +"')"		 
	Endif
	cQuery += " AND (SE2.E2_VENCREA < '" + Dtos(dDataAte) +"')"	

	If  cPaisLoc=="BRA"
		cQuery += " AND SE2.E2_TIPO NOT IN " + cPagAnt
	EndIf
	cQuery += " AND  ( SE2.E2_SALDO > 0 "
	If mv_par11 == 1
		cQuery += " OR SE2.E2_BAIXA > '" + DTOS(dDataBase) + "'" 		
	Endif
	cQuery += " ) "
	If mv_par12 == 2
		cQuery += " AND SE2.E2_MOEDA = " + Str(mv_par02,2)
	Endif
	If mv_par13 == 2
		cQuery += " AND SE2.E2_TIPO NOT IN " + FormatIn(MVABATIM + "|" + MV_CPNEG,"|") 	
	End	
	cQuery += " AND SE2.E2_FLUXO <> 'N'"	
	cQuery += " AND SE2.D_E_L_E_T_ = ' '"
	cQuery += " ORDER BY VENCREA, NATUREZA "

	If TCSQLExec(cInsertTit + cQuery) < 0
	 	UserException(TCSQLError())
	Endif


Return

/*/{Protheus.doc} GrvArqImp
Grava arquivo para impressão

@type 	Function
@author Simone Mie Sato Kakinoana
@since	26/10/2022

@param	cArqTmp, Character, Arquivo para impressão
@return	Nil
/*/
Static Function GrvArqImp( cArqTmp As Character )

	Local cCodDesc	As character	
	Local dDataVenc	As Date

	Default cArqTmp := ""

	cCodDesc 	:= ""
	dDataVenc	:= dDataVenc := CTOD("  /  /  ")	

	cArqTmp->(dbSetOrder(2))
	TRB4->(DbSetOrder(3))
	TRB4->(dbGoTop())	
	Do While (TRB4->(!EOF()))				
		// Soh imprimir se a linha estiver como SIM no VISENT		
		If (TRB4->FJ3_VISENT == '1')	
			If TRB4->FJ3_DATA < dDataBase
				dDataVenc := CTOD("  /  /  ")	
				cCodDesc := "00/00/0000" + " " + Space(TRB4->FJ3_COLUNA) + TRB4->FJ3_DESCCG			
			Else 
				dDataVenc := TRB4->FJ3_DATA
				cCodDesc := DTOC(TRB4->FJ3_DATA ) + " " + Space(TRB4->FJ3_COLUNA) + TRB4->FJ3_DESCCG					
			EndIf			
				
			If cArqTmp->(!dbSeek(dtos(dDataVenc) + TRB4->FJ3_CONTAG))	
				RecLock("cArqTmp",.T.)
				CARQTMP->CONTAG    	:= TRB4->FJ3_CONTAG
				CARQTMP->CTASUP    	:= TRB4->FJ3_CTASUP
				CARQTMP->CODDESC    := cCodDesc			
				CARQTMP->DATAAN 	:= dDataVenc
				CARQTMP->ORDEM 		:= TRB4->FJ3_ORDEM
				CARQTMP->ENTRADAS   := TRB4->FJ3_REC
				CARQTMP->SAIDAS     := TRB4->FJ3_PAGO								
				CARQTMP->CLASSE 	:= TRB4->FJ3_CLASSE
			Else
				RecLock("cArqTmp",.F.)
				CARQTMP->ENTRADAS   += TRB4->FJ3_REC
				CARQTMP->SAIDAS     += TRB4->FJ3_PAGO
			EndIf
			CARQTMP->(MsUnLock())
		EndIf

		RecLock("TRB4",.F.)		
		TRB4->FJ3_REC  := 0
		TRB4->FJ3_PAGO := 0		
		TRB4->(MsUnLock())

		TRB4->(dbSkip())
	EndDo

Return Nil

/*/{Protheus.doc} FGetSaldo
Grava arquivo para impressão

@type 	Function
@author Simone Mie Sato Kakinoana
@since	29/10/2022

@param	cRecPag, Character, Identifica se é pagar ou receber
@param 	dVencto, Date, Data de vencimento
@return	nSaldo, Numeric, Valor a ser atualizado
/*/
Static Function fGetSaldo( cRecPag As Character, dVencto As Date ) 

	Local nSaldo 		As Numeric
	Local nTxMoeda		As Numeric
	Local lMvBr10925	As Logical
	Local lTxMoeda 		As Logical
	Local aAuxGem		As Array

	Default cRecPag := "R"
	Default dVencto := CTOD("  /  /  ")

	nSaldo 		:= 0 
	nTxMoeda 	:= 0 
	lMvBr10925 	:= .T.
	lTxMoeda	:= .T.
	aAuxGem		:= {}	
	
	If cPaisLoc == "BRA"
		 lMvBr10925 := GetMv("MV_BR10925") == "1" 
	EndIf

	If cRecPag == "R"
		If ( mv_par11 == 1 .And. dDataBase < SE1->E1_BAIXA ) .Or. ( mv_par11 == 2 .And. ( dVencto > dDataBase .Or. SE1->E1_BAIXA > dDataBase )) 			
			If cPaisLoc == "BRA"
				nTxMoeda := SE1->E1_TXMOEDA
			EndIf
			nSaldo := SaldoTit(SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_TIPO, SE1->E1_NATUREZ,;
								"R",SE1->E1_CLIENTE,mv_par02,dVencto,dDataBase,SE1->E1_LOJA,Nil,nTxMoeda, mv_par17)

			IF SE1->(E1_PIS+E1_CSLL+E1_COFINS) > 0 .AND. mv_par13 == 1 // Reteve impostos
				nSaldo -= SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",mv_par02,,SE1->E1_CLIENTE,SE1->E1_LOJA,SE1->E1_FILIAL,SE1->E1_EMISSAO)
			Endif

		Else
			// Verifica se existe a taxa na data do vencimento do titulo, se nao existir, utiliza a taxa da database
			lTxMoeda := SM2->(MsSeek(dVencto)) .And. SM2->&("M2_MOEDA"+Alltrim(Str(mv_par02))) != 0
			nSaldo   := xMoeda(SE1->E1_SALDO + SE1->E1_SDACRES - SE1->E1_SDDECRE, SE1->E1_MOEDA, mv_par02, If(lTxMoeda,SE1->E1_VENCREA,dDataBase) , , If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))			

			IF SE1->(E1_PIS+E1_CSLL+E1_COFINS) > 0 .AND. mv_par13 == 1 // Reteve impostos
				nSaldo -= SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",mv_par02,,SE1->E1_CLIENTE,SE1->E1_LOJA,SE1->E1_FILIAL,SE1->E1_EMISSAO)
			Endif
		Endif

	Else
		If ( mv_par11 == 1 .And. dDataBase < SE1->E1_BAIXA ) .Or. ( mv_par11 == 2 .And. ( dVencto > dDataBase .Or. SE1->E1_BAIXA > dDataBase )) 			
			nSaldo := SaldoTit(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_NATUREZ,"P",SE2->E2_FORNECE,mv_par02,SE2->E2_VENCREA,dDataBase,SE2->E2_LOJA,,If(cPaisLoc=="BRA",SE2->E2_TXMOEDA,0), mv_par17)
		Else
			// Verifica se existe a taxa na data do vencimento do titulo, se nao existir, utiliza a taxa da database
			lTxMoeda := SM2->(MsSeek(SE2->E2_VENCREA)) .And. SM2->&("M2_MOEDA"+Alltrim(Str(mv_par02))) != 0
			nSaldo	 := xMoeda((SE2->E2_SALDO+SE2->E2_SDACRES-SE2->E2_SDDECRE),SE2->E2_MOEDA,mv_par02, If(lTxMoeda,SE1->E1_VENCREA,dDataBase),,If(cPaisLoc=="BRA",SE2->E2_TXMOEDA,0))
		EndIf
	EndIf

Return nSaldo

//--------------------------------------------------------------------------------------------------
/*/{Protheus.doc} SelectFil
Separa as filiais, inserindo aspas simples e virgula, para ser usado na clausula IN do SQL

@type Function
@author Unknown
@since 04/09/2013
@version 12
/*/
//--------------------------------------------------------------------------------------------------
Static Function SelectFil(aSelFil)
Local cFilRet	:= ""
Local nX		:= 0
Local cReturn	:= ""

For nX := 1 to Len(aSelFil)

	cFilRet += "'"
	If Len( aSelFil ) > 0
		If aScan( aSelFil, { |x|x == aSelFil[1]} ) > 0
			cFilRet += aSelFil[nX]
		EndIf	
	EndIf

	cFilRet += "',"

Next nX

cReturn := SubStr( cFilRet, 1, Len( cFilRet ) - 1 )

Return cReturn
