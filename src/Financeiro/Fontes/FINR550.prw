/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR550.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RPTDEF.CH"
#TRANSLATE INSIDE(<cTp>) => If(mv_par11 != 1, .T.,<cTp> $ cTipos)

#DEFINE S1_DAT				1
#DEFINE S1_HISTORICO		2
#DEFINE S1_PREFIXO			3
#DEFINE S1_NUM				4
#DEFINE S1_PARCELA			5
#DEFINE S1_TIPO				6
#DEFINE S1_EMISSAO			7
#DEFINE S1_VENCIMENTO		8
#DEFINE S1_BAIXA			9
#DEFINE S1_DEBITO			10
#DEFINE S1_CREDITO			11
#DEFINE S1_SALDO_ATU		12
#DEFINE S1_DIGITO			13

#DEFINE S2_DESCRICAO		1
#DEFINE S2_SD_ANTERIOR		2
#DEFINE S2_DIG1				3
#DEFINE S2_DEB				4
#DEFINE S2_CRED				5
#DEFINE S2_SD_ATUAL			6
#DEFINE S2_DIG2				7


Static _oFINR5501
Static _oFINR5502
Static lFWCodFil	:= .T.
Static lPCCBaixa	:= NIL

//Controla o Pis Cofins e Csll na RA (1 = Controla retenção de impostos no RA; ou 2 = Não controla retenção de impostos no RA(default))
Static lRaRtImp		:= NIL
Static lIssBaixa	:= NIL
STATIC oPrepared	:= NIL
STATIC oPrepar2		:= NIL
STATIC oPreparR		:= NIL
STATIC oPreparC		:= NIL
STATIC __lFilial 	:= .F.
STATIC __lLoja	  	:= .F.
STATIC __oObjFO1 	 As Object

//-----------------------------------------------------------
/*/{Protheus.doc} FINR550
Razonete de Cliente/Fornecedores

@author	Daniel Tadashi Batori
@since		23.08.06
@version	P12.1.7
/*/
//-----------------------------------------------------------

User Function FINR550()

Local oReport		:= Nil

Private cAuxFoot	:= ""
Private lImprime	:= .F.
Private nSaldoAtu	:= 0
Private nPar		:= 0


STATIC cDBMS		:= UPPER(TcGetDb())

lPCCBaixa := SuperGetMv("MV_BX10925",.T.,"2") == "1" 
//Controla o Pis Cofins e Csll na RA (1 = Controla retenção de impostos no RA; ou 2 = Não controla retenção de impostos no RA(default))
lRaRtImp  := FRaRtImp()
lIssBaixa := SuperGetMv("MV_MRETISS",.T.,"1") == "2"

oReport := ReportDef()
oReport:PrintDialog()

oReport := NIL

Return

//-----------------------------------------------------------
/*/{Protheus.doc} ReportDef
Definicao do layout do Relatorio

@Sample	oReport := ReportDef()
@Return	oReport - Objeto do relatorio TReport
@author	Daniel Tadashi Batori
@since		23.08.06
@version	P12.1.7
/*/
//-----------------------------------------------------------

Static Function ReportDef()

Local oReport    := nil
Local oSection1  := nil
Local oSection2  := nil
Local nTamVal    := 0	/* GESTAO */

oReport := TReport():New("FINR550",STR0007,"FIN550", {|oReport| ReportPrint(oReport)},STR0001+STR0002+STR0003) //"RAZONETE DE CONTAS CORRENTES DE "
/*
GESTAO - inicio */
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/ 

Pergunte("FIN550",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ mv_par01            // A partir de                          ³
//³ mv_par02            // Ate a data                           ³
//³ mv_par03            // Carteira (Receber ou Pagar)          ³
//³ mv_par04            // Do Codigo                            ³
//³ mv_par05            // Ate o Codigo                         ³
//³ mv_par06            // Imprime Valores Financeiros (Sim/Nao)³
//³ mv_par07            // Impime (Todos,Normais,Adiantamentos) ³
//³ mv_par08            // Do Prefixo                           ³
//³ mv_par09            // Ate o Prefixo                        ³
//³ mv_par10            // Lista Por 1 - Filial     2 -Empresa  ³
//³ mv_par11            // Seleciona Tipos                      ³
//³ mv_par12            // Natureza de  ?                       ³
//³ mv_par13            // Natureza ate ?                       ³
//³ mv_par14            // Anal¡tico/Sint‚tico                  ³
//³ mv_par15            // Filtra Prefixo para Saldo Anterior   ³
//³ mv_par16            // Folha De ?                           ³
//³ mv_par17            // Folha Ate ?                          ³
//³ mv_par18            // Filtra Contas Contabeis              ³
//³ mv_par19            // Conta Inicial                        ³
//³ mv_par20            // Conta Final                          ³
//³ mv_par21            // Impr. Saldo Contabil                 ³
//³ mv_par22            // Impr. Cli/Forn s/ Movim.?            ³
//³ mv_par23 			// Linhas por Página ?                  ³
//| mv_par24            // Historico                            |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:SetPortrait(.T.)

nTamVal	:= Len(Transform(0,PesqPict("SE2","E2_VLCRUZ")))

oSection1 := TRSection():New(oReport,STR0068,{"cNomeArq"},) //"Analítico"
oSection1:SetAutoSize(.T.)
TRCell():New(oSection1,"E1_VENCTO","SE1",STR0056,,12,.F.,) //"DATA"
TRCell():New(oSection1,"E1_HIST","",STR0057,,25,.F.,,,.T.)	//"HISTORICO"
TRCell():New(oSection1,"E1_PREFIXO","",Upper(SX3->(RetTitle("E1_PREFIXO"))),,TamSx3("E1_PREFIXO")[1],.F.,)
TRCell():New(oSection1,"E1_NUM","",Upper(SX3->(RetTitle("E1_NUM"))),,TamSx3("E1_NUM")[1]+3,.F.,)
TRCell():New(oSection1,"E1_PARCELA","",Upper(SX3->(RetTitle("E1_PARCELA"))),,TamSx3("E1_PARCELA")[1]+3,.F.,)
TRCell():New(oSection1,"E1_TIPO","",Upper(SX3->(RetTitle("E1_TIPO"))),,TamSx3("E1_TIPO")[1],.F.,)
TRCell():New(oSection1,"E1_EMISSAO"	,"",STR0059,,12,.F.,)	 	//"EMISSAO"
TRCell():New(oSection1,"E1_VENCREA","",STR0060,,12,.F.,) 		//"VENCTO"
TRCell():New(oSection1,"E2_DTFATUR","",STR0061,,12,.F.,) 		//"BAIXA"
TRCell():New(oSection1,"E1_VLCRUZ","",STR0062,PesqPict("SE2","E2_VLCRUZ"),nTamVal,.F.,,,,"RIGHT",,,.T.) 	//"DEBITO"
TRCell():New(oSection1,"E2_VLCRUZ","",STR0063,PesqPict("SE2","E2_VLCRUZ"),nTamVal+3,.F.,,,,"RIGHT",,,.T.)	//"CREDITO"
TRCell():New(oSection1,"E1_SALDO","",STR0064,PesqPict("SE2","E2_VLCRUZ"),nTamVal+3,.F.,,,,"RIGHT",,,.T.)	//"SALDO ATUAL"
TRCell():New(oSection1,"DIGITO","","DC",,1,.F.,,,,"RIGHT",,,.T.)
oSection1:AutoSize()

// Seção de Totalização
// Celulas podem ser redefinidas (em ReportPrint()) após confirmação pelo usuário do método PrintDialog()
// devido a opção Analitico ou Sintetico

oSection2 := TRSection():New( oReport,IF(MV_PAR14 == 1, STR0068,STR0069), {"cNomeArq"},)	//Analítico##Sintético
DefSection(oSection2)

Return oReport

//-----------------------------------------------------------------------------
/*/{Protheus.doc} DefSection
Definição da seção de totalização

@type function
@author NORBERTOM
@since 15/02/2017
@version 1.0
@param oSection, Object, TRSection para totalização do relatório
@return NIL, Nenhum retorno
@example DefSection(oSection2)
/*/
//-----------------------------------------------------------------------------

Static Function DefSection(oSection2)

Local nTamVal    := Len(Transform(0,PesqPict("SE2","E2_VLCRUZ")))

	TRCell():New(oSection2,"DESCRICAO",,,,85.5,.F.,,,.T.)
	TRCell():New(oSection2,"FILLER2","","",,TamSx3("E1_NUM")[1],.F.,)
	TRCell():New(oSection2,"FILLER3","","",,TamSx3("E1_PARCELA")[1],.F.,)
	TRCell():New(oSection2,"FILLER4","","",,TamSx3("E1_TIPO")[1],.F.,)
	TRCell():New(oSection2,"FILLER5","","",,12,.F.,)
	TRCell():New(oSection2,"FILLER6","","",,12,.F.,)
	TRCell():New(oSection2,"FILLER7","","",,12,.F.,)
	TRCell():New(oSection2,"FILLER8","","",,12,.F.,)
	TRCell():New(oSection2,"FILLER9","","",,10,.F.,)
	TRCell():New(oSection2,"SALDO_ANT","   ",Alltrim(STR0067),PesqPict("SE2","E2_VLCRUZ"),nTamVal,.F.,,,,"RIGHT") //"SALDO ANTERIOR"
	TRCell():New(oSection2,"DIGITO1",,"DC1",,1,.F.,) 
	TRCell():New(oSection2,"TAM1"   ,,"",,12,.F.)
	TRCell():New(oSection2,"TAM2"   ,,"",,12,.F.)
	TRCell():New(oSection2,"TAM3"   ,,"",,12,.F.)
	TRCell():New(oSection2,"TAM4"   ,,"",,12,.F.)
	TRCell():New(oSection2,"TAM5"   ,,"",,12,.F.)
	TRCell():New(oSection2,"TAM6"   ,,"",,12,.F.)
	TRCell():New(oSection2,"DEBITO" ,"",STR0062,PesqPict("SE2","E2_VLCRUZ"),nTamVal,.F.,,,,"RIGHT",,,.F.) 	//"DEBITO"
	TRCell():New(oSection2,"CREDITO","",STR0063,PesqPict("SE2","E2_VLCRUZ"),nTamVal+2,.F.,,,,"RIGHT",,,.F.)	//"CREDITO"
	TRCell():New(oSection2,"SALDO"  ,"",STR0064,PesqPict("SE2","E2_VLCRUZ"),nTamVal+3,.F.,,,,"RIGHT",,,.F.)	//"SALDO ATUAL"
	TRCell():New(oSection2,"DIGITO2","","DC2",,1,.F.,,,,"RIGHT",,,.T.)
	
	oSection2:AutoSize() 

Return Nil                                                                              

//-----------------------------------------------------------
/*/{Protheus.doc} ReportPrint
A funcao estatica ReportDef devera ser criada para todos os 
relatorios que poderao ser agendados pelo usuario.

@Sample	oReport:PrintDialog()
@Param		oReport - Objeto Report do Relatório
@Return	Nil
@author	Daniel Tadashi Batori
@since		22.08.06
@version	P12.1.7
/*/
//-----------------------------------------------------------

Static Function ReportPrint(oReport As Object)
    Local oSection1		As Object
    Local oSection2		As Object
    Local aSec1         As Array
    Local aSec2         As Array
    Local cTexto        As Character
    Local cTitulo       As Character
    Local nQuebra		As Numeric
    Local lImprAnt		As Logical
    Local cNome			As Character
    Local nTotDeb		As Numeric
    Local nTotCrd		As Numeric
    Local nTotDebG		As Numeric
    Local nTotCrdG		As Numeric
    Local nSalAtuG		As Numeric
    Local nSalAntG		As Numeric
    Local dEmissao		As Date
    Local dVencto		As Date
    Local nValliq		As Numeric
    Local cCodigo		As Character
    Local cLoja			As Character
    Local lNoSkip		As Logical
    Local lFlag			As Logical
    Local nSaldoFinal	As Numeric
    Local aCampos		As Array
    Local aTam			As Array
    Local aInd			As Array
    Local nRegAtu       As Numeric
    Local bBlockDC		As Block
    Local nX			As Numeric
    Local aSdoContabil  As Array
    Local nI			As Numeric
    Local aDados		As Array
    Local aImp10925		As Array
    Local aDadosAbat	As Array
    Local nLinReport	As Numeric
    Local nLinPag		As Numeric
    Local nSaldoTra		As Numeric
    Local cCtContAnt	As Character
    Local cFilSE5		As Character 
    Local cFilSE1		As Character
    Local cFilSE2		As Character
    Local cFilSA1		As Character
    Local cFilSA2		As Character
    Local lSqlOracle	As Logical
    Local cCposSE5		As Character
    Local cWhereE5A		As Character
    Local cWhereE5B		As Character
    Local cWhereE5C		As Character
    Local cOrderBy      As Character
    Local cChvCliFor	As Character
    Local cLayoutSM0 	As Character
    Local lGestao	 	As Logical
    Local nTam			As Numeric
    Local cFilTemp		As Character
    Local aSelFil		As Array
    Local nRegSM0		As Numeric
    Local aSM0			As Array
    Local nTamEmp		As Numeric
    Local nTamUnNeg		As Numeric
    Local nTamTit		As Numeric
    Local nTamVal		As Numeric
    Local nPosFim		As Numeric
    Local cFilSel		As Character
    Local cTmpFil		As Character
    Local aTmpFil		As Array
    Local lAchou		As Logical
    Local oSecFil		As Object
    Local cSeqAnt		As Character
    Local cMoedaAnt		As Character
    Local cTipoAnt		As Character
    Local cRecPagAnt	As Character
    Local cSE5KeyAnt	As Character
    Local nCampo		As Numeric
    Local lCorrecao		As Logical
    Local nTamaDados	As Numeric
    Local nVa			As Numeric
    Local aAreaAnt		As Array
    Local lFxLoadFK6	As Logical
    Local cSTR47U		As Character
    Local cSTR50U		As Character
    Local cSTR51U		As Character
    Local cSTR52U		As Character
    Local cSTR53U		As Character
    Local cSTR75U		As Character
    Local lPrintTotal	As Logical
    Local lPrintCabec	As Logical
    Local nRecno		As Numeric
    Local cCompSA1   	As Character
    Local nTamFilSA1 	As Numeric
    Local cCompSA2   	As Character
    Local nTamFilSA2 	As Numeric
    local cBDname	 	As Character
    local nContFor		As Numeric
    local lPDF			As Logical
    local lCalcSldAnt	As Logical
    Local cFilOrig 		As Character
    Local nCentMd1		As Numeric
    Local nMoedaMov		As Numeric
    Local cCposFK6		As Character
    Local nTamFil		As Numeric
    Local nTamFilSE5	As Numeric
    Local lMovMdEs      As Logical
    Local lMovBcoBx     As Logical
    Local nValMov       As Numeric
    Local nMoedaTit     As Numeric
    Local cTbl 			As Character
    Local nValorFin     As Numeric
    Local nTxMovim		As Numeric
    Local cDC           As Character 
    Local cTableSGBD    As Character
    Local cChaveTit     As Character
    Local cChaveFK7     As Character
    Local cTipoTit      As Character
    Local cSeqBx        As Character
    Local nTotAbat      As Numeric
	Local cFilBkp		As Character
	
    Private oBulk       as Object 
    Private nTamPref    As Numeric
    Private nTamNro		As Numeric
    Private nTamParc	As Numeric
    Private nTamTipo	As Numeric
    Private nTamA1Nome  As Numeric
    Private nTamA2Nome  As Numeric
    Private nTamA1CGC   As Numeric
    Private nTamA2CGC   As Numeric
    Private nTamTitulo	As Numeric
    Private nTamHistor  As Numeric
    
    oSection1		:= oReport:Section(1)
    oSection2		:= oReport:Section(2)
    aSec1           := Array(13)
    aSec2           := Array(07)
    nQuebra         := 0
    lImprAnt		:= .F.
    cNome			:= ""
    nTotDeb	    	:= 0
    nTotCrd	    	:= 0
    nTotDebG		:= 0
    nTotCrdG		:= 0
    nSalAtuG		:= 0
    nSalAntG		:= 0
    dEmissao		:= CTOD("")
    dVencto		    := CTOD("")
    nValliq 		:= 0
    cCodigo 		:= ""
    cLoja			:= ""
    lNoSkip	    	:= .T.
    lFlag			:= .F.
    nSaldoFinal 	:=0
    aCampos	    	:={}
    aTam			:={}
    aInd			:={}
    bBlockDC		:= {| nNum | if(int(nNum*100)=0," ",if(nNum>0,"C","D")) }
    nX		    	:= 0
    nI			    := 0
    aDados  		:= {}
    aImp10925		:= {}
    aDadosAbat  	:= {}
    nLinReport  	:= 8
    nLinPag	    	:= 0
    nSaldoTra		:= 0
    cCtContAnt  	:= ""
    cFilSE5	    	:= xFilial("SE5") 
    cFilSE1	    	:= xFilial("SE1")
    cFilSE2	    	:= xFilial("SE2")
    cFilSA1	    	:= xFilial("SA1")
    cFilSA2	    	:= xFilial("SA2")
    lSqlOracle  	:= (TcGetDb() $ "MSSQL|MSSQL7|ORACLE|DB2")
    cCposSE5		:= ""
    cWhereE5A		:= ""
    cWhereE5B		:= ""
    cWhereE5C		:= ""
    cChvCliFor  	:= ""
    cLayoutSM0  	:= FWSM0Layout()
    lGestao	    	:= Substr(cLayoutSM0,1,1) $ "E|U"	// Indica se usa Gestao Corporativa
    nTam			:= 0
    cFilTemp		:= ""
    /*GESTAO - inicio */
    aSelFil	    	:= {}
    nRegSM0	    	:= 0 
    aSM0			:= {}
    nTamEmp	    	:= 0
    nTamUnNeg		:= 0
    nTamTit	    	:= 0
    nPosFim	    	:= 0
    cFilSel	    	:= ""
    cTmpFil	    	:= ""
    aTmpFil	    	:= {}
    lAchou	    	:= .T.
    oSecFil	    	:= Nil
    cSeqAnt	    	:= ""
    cMoedaAnt		:= ""
    cTipoAnt		:= ""
    cRecPagAnt  	:= ""
    cSE5KeyAnt  	:= ""
    nCampo	    	:= 0
    lCorrecao		:= .F.
    nTamaDados  	:= 0
    nVa		    	:= 0
    aAreaAnt		:= {}
    lFxLoadFK6  	:= ExistFunc('FxLoadFK6')
    cSTR47U	    	:= Upper(STR0047)
    cSTR50U	    	:= Upper(STR0050)
    cSTR51U	    	:= Upper(STR0051)
    cSTR52U	    	:= Upper(STR0052)
    cSTR53U	    	:= Upper(STR0053)
    cSTR75U	    	:= Upper(STR0075)
    lPrintTotal 	:= .T. 			// Variavel utilizada para controlar a impress?o do Total
    lPrintCabec 	:= .T. 			// Variavel utilizada para controlar a impress?o do cabe‡alho
    nRecno	    	:= 0 			// Numero de Registros selecionados no Periodo estipulado
    cCompSA1     	:= FWModeAccess( "SA1" , 1 ) + FWModeAccess( "SA1" , 2 ) + FWModeAccess( "SA1" , 3 )
    nTamFilSA1  	:= If( "E" $ cCompSA1, Len(Alltrim(xFilial("SA1"))) , 0 )
    cCompSA2    	:= FWModeAccess( "SA2" , 1 ) + FWModeAccess( "SA2" , 2 ) + FWModeAccess( "SA2" , 3 )
    nTamFilSA2  	:= If( "E" $ cCompSA2, Len(Alltrim(xFilial("SA2"))) , 0 )
    cBDname	    	:= Upper( TCGetDB() )
    nContFor		:= 0
    lPDF			:= IIF(oReport:nDevice == 6 , .T. , .F.)
    lCalcSldAnt 	:= .T.
    cFilOrig 		:= ""
    nCentMd1		:= MsDecimais(1)
    nMoedaMov		:= 1
    cCposFK6		:= ""
    nTamFil	    	:= TamSx3("E5_FILORIG")[1]
    nTamFilSE5  	:= Len(AllTrim(cFilSE5))
    lMovMdEs        := .F.
    lMovBcoBx       := .F.
    nValMov         := 0
    nMoedaTit       := 0
    cTbl 			:= ""
    nValorFin       := 0
    nTxMovim		:= 0
	cFilBkp			:= ""

    nTamPref        := TamSx3("E1_PREFIXO")[1]
    nTamNro	    	:= TamSx3("E1_NUM")[1]
    nTamParc    	:= TamSx3("E1_PARCELA")[1]
    nTamTipo    	:= TamSx3("E1_TIPO")[1]
    nTamA1Nome      := TamSx3("A1_NOME")[1]
    nTamA2Nome      := TamSX3("A2_NOME")[1]
    nTamA1CGC       := TamSx3("A1_CGC")[1]
    nTamA2CGC       := TamSx3("A2_CGC")[1]
    nTamTitulo      := nTamPref + nTamNro + nTamParc + 3 + nTamTipo
    nTamHistor      := TamSx3("E1_HIST")[1]

	nTamVal         := Len(Transform(0,PesqPict("SE2","E2_VLCRUZ")))
	nPosFim         := aScan(oSection1:aCell,{|x| x:cName == "E1_NUM"})
	nTam            := 0

	Default lPCCBaixa := SuperGetMv("MV_BX10925",.T.,"2") == "1"
	Default lRaRtImp  := FRaRtImp()
	Default lIssBaixa := SuperGetMv("MV_MRETISS",.T.,"1") == "2"

	For nX := 1 to nPosFim
		nTam += oSection1:Cell(oSection1:aCell[nX]:cName):GetSize()
		nTam += oReport:nColSpace
	Next nX

	//Definir tamanho do array aDados
	If lPccBaixa .Or. lRaRtImp
		nTamaDados := 18
	Else
		nTamaDados := 12
	Endif

	If lIssBaixa
		nTamaDados += 1
	Endif

	nTamaDados += 1 //Adiciona uma posicao para armazenar a FILENT
	nTamaDados += 1 //Considerar uma linha no array para o IRRF na baixa

	aDados := Array(nTamaDados)

	//Relacao das filiais selecionadas para compor o relatorio
	oSecFil := TRSection():New(oReport,"SECFIL")
	TRCell():New(oSecFil,"CODFIL",,STR0070,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
	TRCell():New(oSecFil,"EMPRESA",,STR0071,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Empresa"
	TRCell():New(oSecFil,"UNIDNEG",,STR0072,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Unidade de negócio"
	TRCell():New(oSecFil,"NOMEFIL",,STR0073,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Filial"

	If !IsBlind()
		If lGestao
			nRegSM0 := SM0->(Recno())
			aSelFil := AdmGetFil(.F.,.F.,"SE1")
			SM0->(DbGoTo(nRegSM0))
			If Empty(aSelFil)
				Aadd(aSelFil, cFilAnt)
			Endif
			Asort(aSelFil)
		Endif
	Else
		If FindFunction("GetParAuto")
			aRetAuto := GetParAuto("FINR550TestCase")
			aSelFil  := aRetAuto
			nRegSM0  := SM0->(Recno())
			SM0->(DbGoTo(nRegSM0))
		Endif
	EndIf

	/* GESTAO - fim
	*/
	oReport:SetMeter(0)
	oReport:IncMeter()

	//-----------------------------------------------------------
	//Indica a quebra de linha por Pagina
	//-----------------------------------------------------------
	If lPDF //Se for exportado por PDF, a quebra de Linha será 60
		nLinPag := If( MV_PAR23 >= 60 .or. MV_PAR23 == 0 , 60, MV_PAR23 )	
	ElseIf !Empty(mv_par23) //Para os demais formatos, o limite maximo por pagina será 70
		nLinPag := If( MV_PAR23 >= 70, 70, MV_PAR23 )
	Else
		nLinPag := 70	
	EndIf		

	lImprime := .F.

	cTipos := ""

	oSection1:Cell("E1_VENCTO"	):SetBlock(	{ || Iif( Empty( aSec1[S1_DAT] )		, CtoD( "  /  /  " ), aSec1[S1_DAT] ) })
	oSection1:Cell("E1_HIST"):SetBlock( { || aSec1[S1_HISTORICO] })
	oSection1:Cell("E1_PREFIXO"):SetBlock( { || aSec1[S1_PREFIXO] })
	oSection1:Cell("E1_NUM"):SetBlock( { || aSec1[S1_NUM] })
	oSection1:Cell("E1_PARCELA"):SetBlock( { || aSec1[S1_PARCELA] })
	oSection1:Cell("E1_TIPO"):SetBlock( { || aSec1[S1_TIPO] })
	oSection1:Cell("E1_EMISSAO"	):SetBlock(	{ || Iif( Empty( aSec1[S1_EMISSAO] )	, CtoD( "  /  /  " ), aSec1[S1_EMISSAO] ) })
	oSection1:Cell("E1_VENCREA"	):SetBlock(	{ || Iif( Empty( aSec1[S1_VENCIMENTO] )	, CtoD( "  /  /  " ), aSec1[S1_VENCIMENTO] ) })
	oSection1:Cell("E2_DTFATUR"	):SetBlock(	{ || Iif( Empty( aSec1[S1_BAIXA] )		, CtoD( "  /  /  " ), aSec1[S1_BAIXA] ) })
	oSection1:Cell("E1_VLCRUZ"	):SetBlock(	{ || Iif( Empty( aSec1[S1_DEBITO] )		, 0, aSec1[S1_DEBITO] ) })
	oSection1:Cell("E2_VLCRUZ"	):SetBlock(	{ || Iif( Empty( aSec1[S1_CREDITO] )	, 0, aSec1[S1_CREDITO] ) })
	oSection1:Cell("E1_SALDO"):SetBlock( { || aSec1[S1_SALDO_ATU] })
	oSection1:Cell("DIGITO"):SetBlock( { || aSec1[S1_DIGITO] })
	oSection1:Cell("DIGITO"):HideHeader()

	If MV_PAR14 == 1 // Analitico
		
		//Colunas destinadas ao formato sintetico
		oSection2:Cell("SALDO_ANT"):Disable()
		oSection2:Cell("DIGITO1"):Disable()
		oSection2:Cell("TAM1"):Disable()
		oSection2:Cell("TAM2"):Disable()
		oSection2:Cell("TAM3"):Disable()
		oSection2:Cell("TAM4"):Disable()
		oSection2:Cell("TAM5"):Disable()
		oSection2:Cell("TAM6"):Disable()
		
		If oReport:nDevice == IMP_EXCEL 
			oSection2:Cell("FILLER2"):Enable()
			oSection2:Cell("FILLER3"):Enable()
			oSection2:Cell("FILLER4"):Enable()
			oSection2:Cell("FILLER5"):Enable()
			oSection2:Cell("FILLER6"):Enable()
			oSection2:Cell("FILLER7"):Enable() 
			oSection2:Cell("FILLER8"):Enable() 
			oSection2:Cell("FILLER9"):Enable() 
		Else
			oSection2:Cell("FILLER2"):Disable()
			oSection2:Cell("FILLER3"):Disable()
			oSection2:Cell("FILLER4"):Disable()
			oSection2:Cell("FILLER5"):Disable()
			oSection2:Cell("FILLER6"):Disable()
			oSection2:Cell("FILLER7"):Disable() 
		EndIf

	Else //Sintetico
		
		//Colunas destinadas ao formato Analitico
		oSection2:Cell("FILLER2"):Disable()
		oSection2:Cell("FILLER3"):Disable()
		oSection2:Cell("FILLER4"):Disable()
		oSection2:Cell("FILLER5"):Disable()
		oSection2:Cell("FILLER6"):Disable()
		oSection2:Cell("FILLER7"):Disable()
		oSection2:Cell("FILLER8"):Disable()
		oSection2:Cell("FILLER9"):Disable()

		oSection2:Cell("SALDO_ANT"):SetBlock( { || aSec2[S2_SD_ANTERIOR]})
		oSection2:Cell("DIGITO1"):SetBlock( { || aSec2[S2_DIG1] })
		oSection2:Cell("DIGITO1"):HideHeader()

		If oReport:nDevice == IMP_EXCEL 
			oSection2:Cell("TAM1"):Enable() 
			oSection2:Cell("TAM2"):Enable()
			oSection2:Cell("TAM3"):Enable()
			oSection2:Cell("TAM4"):Enable() 
			oSection2:Cell("TAM5"):Enable()
			oSection2:Cell("TAM6"):Enable()
		Else
			oSection2:Cell("TAM1"):Disable() 
			oSection2:Cell("TAM2"):Disable()
			oSection2:Cell("TAM3"):Disable()
		EndIf
	Endif

	oSection2:SetAutoSize(.T.)
	oSection2:Cell("DESCRICAO"):SetBlock( { || aSec2[S2_DESCRICAO] })
	oSection2:Cell("DESCRICAO"):SetTitle(If(mv_par03==1,STR0008,STR0009))
	oSection2:Cell("DEBITO"		):SetBlock( { || aSec2[S2_DEB]})
	oSection2:Cell("CREDITO"	):SetBlock( { || aSec2[S2_CRED]})
	oSection2:Cell("SALDO"		):SetBlock( { ||aSec2[S2_SD_ATUAL]})
	oSection2:Cell("DIGITO2"):SetBlock( { || aSec2[S2_DIG2] })
	oSection2:Cell("DIGITO2"):HideHeader()

	If mv_par14 == 1  // Analitico
		oSection1:SetHeaderPage()
		oSection2:SetHeaderSection(.F.)
		oSection1:OnPrintLine({|| F550LinPag(nLinPag,@nLinReport,oReport,@nSaldoTra,  ,   , @nContFor)})
	Else
		oSection1:SetHeaderSection(.F.)
		oSection2:OnPrintLine({|| F550LinPag(nLinPag,@nLinReport,oReport,@nSaldoTra,  ,   , @nContFor)})
	EndIf

	//impressao do numero de pagina conforme pergunta 16 e 17
	MV_PAR16 := If(Empty(MV_PAR16),1,MV_PAR16)
	MV_PAR17 := If(Empty(MV_PAR17),999,MV_PAR17)
	If MV_PAR17 <= MV_PAR16
		MV_PAR17 := MV_PAR16 + 1
	Endif
	oReport:SetPageNumber(MV_PAR16)
	oReport:OnPageBreak({||	F550LinPag(nLinPag,@nLinReport,oReport,@nSaldoTra,.T.,  , @nContFor) })
	oReport:SetPageFooter( 2 , {|| IIF((lImprime .Or. (nSaldoAtu != 0)) , F550RODAPE(oReport,nSaldoTra,Eval(bBlockDC,nSaldoTra),aSec1) , nil ) } /*, .T.*/)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ponto de entrada para Filtrar os tipos sem entrar na tela do ³
	//³ FINRTIPOS(), localizacao Argentina.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF cPaisLoc # "BRA"
		IF EXISTBLOCK("FARGTIP")
			cTipos	:=	EXECBLOCK("FARGTIP")
		ENDIF
	ENDIF		

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Alimenta vetor com os impostos que devem gerar movimentos de historico ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aadd(aImp10925,{"TRBSE2->E2_VRETPIS","Pis"})
	aadd(aImp10925,{"TRBSE2->E2_VRETCOF","Cofins"})
	aadd(aImp10925,{"TRBSE2->E2_VRETCSL","Csll"})

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Referencia para imprimir descricao dos tipos de cliente A1_TIPO ³
	//ÀÄLocalizacoesÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cPaisLoc # "BRA"
		SX3->(dbSetOrder(2))
		SX3->(dbSeek("A1_TIPO"))
		If SX3->(Found())
			cTipoCli := AllTrim(SX3->(X3CBox()) )
			cTipoCli := '{"'+StrTran(cTipoCli,';','","')+'"}'
			aTipoCli := &(cTipoCli)
		Else            
			cTipoCli := ""
			aTipoCli := {}
		EndIf
	EndIf
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se seleciona tipos                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par11 == 1
		finRTipos()
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ For‡a ser por filial quando exista somente 1 filial,indepen- ³
	//³ dente da resposta                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	mv_par10 := If(SM0->(Reccount())==1,1,mv_par10) // Lista Por 1 - Filial     2 -Empresa

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definicao dos cabecalhos                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTitulo := oReport:Title() + " " + If(mv_par03==1,STR0008,STR0009)  //"RAZONETE DE CONTAS CORRENTES DE "###"CLIENTES"###"FORNECEDORES"
	oReport:SetTitle(cTitulo)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gera arquivo de Trabalho                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aTam:=TamSX3("E1_CLIENTE")
	aAdd(aCampos,{"CODIGO" ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_LOJA")
	aAdd(aCampos,{"LOJA"   ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_EMISSAO")
	aAdd(aCampos,{"DATAEM"   ,"D",aTam[1],aTam[2]})
	aAdd(aCampos,{"NUMERO" ,"C",nTamTitulo,0})
	aTam:=TamSX3("E1_TIPO")
	aAdd(aCampos,{"TIPO"   ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_PORTADO")
	aAdd(aCampos,{"BANCO"  ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_EMISSAO")
	aAdd(aCampos,{"EMISSAO","D",aTam[1],aTam[2]})
	aAdd(aCampos,{"BAIXA"  ,"D",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_VENCREA")
	aAdd(aCampos,{"VENCTO" ,"D",aTam[1],aTam[2]})
	aAdd(aCampos,{"VALOR"  ,"N",18,2})
	aAdd(aCampos,{"HISTOR" ,"C",Min(TamSX3("E1_HIST")[1],255),0})
	aAdd(aCampos,{"DC"     ,"C", 1,0})
	aAdd(aCampos,{"MOEDA"  ,"N", TamSX3("E1_MOEDA")[1],0}) // Utilizada para saldo contabil
	aAdd(aCampos,{"CONTA"	,"C", TamSX3(IIf(mv_par03 == 1, "A1_CONTA", "A2_CONTA"))[1],0})	//Incluido este campo para a aglutinacao por loja
	aTam:=TamSX3("E1_PREFIXO")
	aAdd(aCampos,{"PREFIXO" ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_PARCELA")
	aAdd(aCampos,{"PARCELA"   ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_FILIAL")
	aAdd(aCampos,{"FILIAL"   ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_FILORIG")
	aAdd(aCampos,{"FILORI"   ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("A1_FILIAL")
	aAdd(aCampos,{"FILENT"   ,"C",aTam[1],aTam[2]})	// Filial da entidade cliente/fornecedor

	If _oFINR5501 <> Nil
		_oFINR5501:Delete()
		_oFINR5501 := Nil
	Endif

	_oFINR5501 := FWTemporaryTable():New( "cNomeArq" )  
	_oFINR5501:SetFields(aCampos) 	

	If mv_par25 == 2 .OR. mv_par18 == 1	//Se usa filtro por conta ou nao aglutina por loja
		_oFINR5501:AddIndex("1", {"FILENT","CODIGO","LOJA","DATAEM","NUMERO"}) 
	Else 
		If  mv_par21 == 1	//saldo contabil
			//Aglutinado por loja. A conta contabil precede a loja, pois a aglutinacao das lojas somente sera permitida caso as contas sejam iguais
			_oFINR5501:AddIndex("1", {"FILENT","CODIGO","CONTA","LOJA","DATAEM","NUMERO"}) 
		Else  
			If mv_par25 = 1
				_oFINR5501:AddIndex("1", {"FILENT","CODIGO","DATAEM","NUMERO"}) 
			Else
				_oFINR5501:AddIndex("1", {"FILENT","CODIGO","LOJA","DATAEM","NUMERO"}) 
			EndIf
		EndIf
	Endif
	//- Esse indice ajudará na performance de buscas nas consultas por query
	_oFINR5501:AddIndex("2", {"CODIGO","LOJA","DATAEM","NUMERO","FILENT"}) 

	//------------------
	//Criação da tabela temporaria
	//------------------
	_oFINR5501:Create()	
	//Obtenho o nome "verdadeiro" da tabela no BD (criada como tempor ria)
	cTable := _oFINR5501:GetRealName()

	//- Inicia o objeto para inserção em blocos
	//- o segundo parâmetro refere-se a quantidade de registros incluídos
	//- esse numero não pode ser maior que 1000
	//- AJUSTA NOME DA TABELA 
	cTableSGBD := cTable
	If 'MSSQL' $ TcGetDb()
		cTableSGBD := _oFINR5501:cTableName
	EndIf 
	oBulk := FwBulk():New(cTableSGBD,900)
	oBulk:SetFields(aCampos)

	//Contas a Receber
	IF mv_par03 == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza e grava titulos a receber dentro dos parametros     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE1")
		dbSetOrder(2)
		
		cQuery := "SELECT "
		
		cQuery += "SE1.E1_FILIAL, SE1.E1_FILORIG,SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_EMISSAO, SE1.E1_PORTADO, SE1.E1_BAIXA, "
		cQuery += "SE1.E1_EMIS1, SE1.E1_VENCREA, SE1.E1_VLCRUZ, SE1.E1_MOEDA, SE1.E1_HIST, SE1.E1_FATURA, SE1.E1_DESDOBR, SA1.A1_FILIAL, SA1.A1_CONTA "
		
		cQuery += "FROM " + RetSqlName("SE1") + " SE1, " + RetSqlName("SA1") + " SA1 "
		cQuery += "WHERE "

		If !Empty(aSelFil) 		/* GESTAO */
			cQuery += " SE1.E1_FILIAL " + GetRngFil(aSelFil,"SE1",.T.,@cTmpFil)
			Aadd(aTmpFil,cTmpFil)
		Else
			If mv_par10 = 1 .Or. Empty(cFilSE1)
				cQuery += " SE1.E1_FILIAL = '" + cFilSE1 + "' "
			else   /* Impressão por empresa*/
				cQuery += " SE1.E1_FILIAL BETWEEN '  ' AND 'ZZ' "
			endif           
		Endif           
		
		// Nao adiciona filtro se pedir range de branco a ZZZ
		If mv_par04 == mv_par05                                                          
			cQuery += " AND SE1.E1_CLIENTE = '" + mv_par04 + "' "
		ElseIf ! ( Empty(mv_par04) .And. Upper( AllTrim(mv_par05) ) == Replicate( "Z", Len( AllTrim(mv_par05) ) ) )
			cQuery += " AND SE1.E1_CLIENTE BETWEEN '" + mv_par04 + "' AND '" + mv_par05 + "'"
		EndIf
		
		If dDataBase <= mv_par02
			cQuery += " AND SE1.E1_EMIS1 <= '" + DTOS(dDataBase) + "'"
		Else	
			//Le registros com data anterior a data inicial (para compor os saldos anteriores) ate a data final.                      ³
			cQuery += " AND SE1.E1_EMIS1 <= '" + dtos(mv_par02) + "'"																	
		EndIf	

		//Descarta Provisorios
		cQuery += " AND SE1.E1_TIPO NOT IN " + FormatIn( MVPROVIS, "/" )
		
		//Filtra prefixos para saldo anterior
		If mv_par15 == 1
			cQuery += " AND SE1.E1_PREFIXO BETWEEN '" + mv_par08 + "' AND '" + mv_par09 + "'"
		Endif

		//Filtra Naturezas
		If mv_par12 == mv_par13
			cQuery += " AND SE1.E1_NATUREZ = '" + mv_par12 + "' "			
		ElseIf ! ( Empty(mv_par12) .And. Upper( AllTrim(mv_par13) ) == Replicate( "Z", Len( AllTrim(mv_par13) ) ) )
			cQuery += " AND SE1.E1_NATUREZ BETWEEN '" + mv_par12 + "' AND '" + mv_par13 + "'"
		EndIf	

		//Filtra tipos de titulo determinados
		If mv_par11 == 1
			cQuery += " AND SE1.E1_TIPO IN " + FORMATIN(cTipos,"/")
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica quais serao impressos                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ						
		If mv_par07 == 2 // So'Normais
			cQuery += " AND SE1.E1_TIPO NOT IN " + FORMATIN(MVRECANT,"/") 
		Endif                                            
				
		If mv_par07 == 3 // So Adiantamentos
			cQuery += " AND SE1.E1_TIPO IN " + FORMATIN(MVRECANT,"/")
		End			
														
		cQuery += " AND SE1.D_E_L_E_T_ = ' ' "   

		// Relaciona tabela de clientes para buscar conta contabil
		If nTamFilSA1 > 0
			If cBDname $ "ORACLE|DB2|POSTGRES|INFORMIX"
				cQuery += 				" AND SUBSTR(SA1.A1_FILIAL,1," + str(nTamFilSA1) +" ) = SUBSTR(SE1.E1_FILORIG,1,"+Str(nTamFilSA1)+") "
			Else
				cQuery += 				" AND SUBSTRING(SA1.A1_FILIAL,1,"+ str(nTamFilSA1)+") = SUBSTRING(SE1.E1_FILORIG,1,"+Str(nTamFilSA1)+") "
			EndIf
		EndIf
		cQuery += " AND SA1.A1_COD = SE1.E1_CLIENTE " 
		cQuery += " AND SA1.A1_LOJA = SE1.E1_LOJA "
		If mv_par18 == 1 .And. lSqlOracle		// Seleciona clientes por conta contabil
			cQuery += "AND SA1.A1_CONTA BETWEEN '" + mv_par19 + "' AND '" + mv_par20 + "' "
		EndIf
		cQuery += " AND SA1.D_E_L_E_T_ = ' ' "    

		cQuery := ChangeQuery(cQuery)

		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'TRBSE1', .F., .T.)
		
		TCSetField( "TRBSE1", "E1_VLCRUZ", "N", TamSX3( "E1_VLCRUZ" )[1], TamSX3( "E1_VLCRUZ" )[2] )
		TCSetField( "TRBSE1", "E1_MOEDA" , "N", TamSX3( "E1_MOEDA" )[1] , TamSX3( "E1_MOEDA"  )[2] )

		TCSetField( "TRBSE1", "E1_EMISSAO", "D" )
		TCSetField( "TRBSE1", "E1_EMIS1"  , "D" )
		TCSetField( "TRBSE1", "E1_VENCREA", "D" )
		TCSetField( "TRBSE1", "E1_BAIXA"  , "D" )

		SE5->(dbSetOrder(7))	//E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ
		
		dbSelectArea( "TRBSE1" )

		While !Eof()

			If mv_par15 == 1 .Or. E1_EMISSAO >= mv_par01
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica prefixo caso a movimenta‡„o n„o seja interpretada   ³
				//³ para calculo do saldo anterior ou quando solicitado.         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If E1_PREFIXO < mv_par08 .Or. E1_PREFIXO > mv_par09
					dbSkip()
					Loop
				Endif
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Pesquisa de descarte de registros geradores de       ³
			//³desdobramento                                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If	TRBSE1->E1_DESDOBR == "1" .And. ! Empty( TRBSE1->E1_BAIXA ) .And. ;
				SE5->( MsSeek( FWxFilial("SE5") + TRBSE1->E1_PREFIXO + TRBSE1->E1_NUM + TRBSE1->E1_PARCELA + TRBSE1->E1_TIPO + TRBSE1->E1_CLIENTE + TRBSE1->E1_LOJA ) )
				If AllTrim(SE5->E5_MOTBX) == "DSD" .And. AllTrim(SE5->E5_TIPODOC) == "BA"
					dbSkip()
					Loop
				Endif
			Endif

			If E1_TIPO $ MVABATIM
				AAdd( aDadosAbat, {	E1_CLIENTE, E1_LOJA, E1_EMISSAO, E1_PREFIXO+E1_NUM+E1_PARCELA,;
									E1_PORTADO, E1_EMISSAO, E1_VENCREA, E1_VLCRUZ, E1_BAIXA } )
			EndIf		

			If cPaisLoc # "BRA"
				If TRBSE1->E1_TIPO $ MV_CRNEG
					cHistor := STR0030  //"NOTA DE CREDITO No. "
				ElseIf TRBSE1->E1_TIPO $ MV_CPNEG
					cHistor := STR0031  //"NOTA DE DEBITO No. "
				ElseIf AllTrim(TRBSE1->E1_TIPO) $ "NF|FT"
					cHistor := STR0032  //"FACTURA No. "
				ElseIf TRBSE1->E1_TIPO == "RA "
					cHistor := STR0033  //"ANTICIPO"
				ElseIf TRBSE1->E1_TIPO == "NCI"
					cHistor := STR0034  //"NOTA DE CRED. INTERNA"
				ElseIf TRBSE1->E1_TIPO == "NDI"
					cHistor := STR0035  //"NOTA DE DEB. INTERNA"
				Else
					cHistor := TRBSE1->E1_HIST	
				EndIf
			ElseIf Alltrim(TRBSE1->E1_FATURA) == "NOTFAT" .And. cPaisLoc == "BRA"
				cHistor := IIF(Empty(TRBSE1->E1_HIST),STR0029,TRBSE1->E1_HIST)  //"Pela Emissao da Fatura"
			Else
				cHistor := IIF(Empty(TRBSE1->E1_HIST),STR0012,TRBSE1->E1_HIST)  //"Pela Emissao do Titulo"
			Endif

			cDc := 'D'

			If TRBSE1->E1_TIPO $ MVRECANT+"/"+MVABATIM+"/"+MV_CRNEG+"/PIS#COF#CSL#IRF" //PIS/COF/CSL = PCC Baixa CR / IRRF na Baixa
				cDC := "C"
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava debito no arquivo de trabalho                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			oBulk:AddData({TRBSE1->E1_CLIENTE,;                                     //- CODIGO
			TRBSE1->E1_LOJA,;                                                       //- LOJA
			TRBSE1->E1_EMIS1,;                                                      //- DATAEM 
			TRBSE1->E1_PREFIXO+TRBSE1->E1_NUM+TRBSE1->E1_PARCELA+TRBSE1->E1_TIPO,;  //- NUMERO
			TRBSE1->E1_TIPO,;                                                       //- TIPO
			TRBSE1->E1_PORTADO,;                                                    //- BANCO
			TRBSE1->E1_EMISSAO,;                                                    //- EMISSAO
			CtoD(''),;                                                              //- BAIXA
			TRBSE1->E1_VENCREA,;                                                    //- VENCTO 
			TRBSE1->E1_VLCRUZ,;                                                     //- VALOR
			cHistor,;                                                               //- HISTOR 
			cDC,;                                                                   //- DC 
			TRBSE1->E1_MOEDA,;                                                      //- MOEDA
			TRBSE1->A1_CONTA,;                                                      //- CONTA
			TRBSE1->E1_PREFIXO,;                                                    //- PREFIXO 
			TRBSE1->E1_PARCELA,;                                                    //- PARCELA 
			TRBSE1->E1_FILIAL,;                                                     //- FILIAL 
			TRBSE1->E1_FILORIG,;                                                    //- FILORI
			TRBSE1->A1_FILIAL})							                            //- FILENT
			
			dbSelectArea( "TRBSE1" )
			dbSkip()
		Enddo          
		oBulk:Close()
			
		DBSelectArea("TRBSE1")
		DbCloseArea()

	Endif

	//Contas a Pagar
	IF mv_par03 == 2
		
		// Localiza e grava titulos a pagar dentro dos parametros
		dbSelectArea("SE2")
		dbSetOrder (6)

		cQuery := " SELECT "
		cQuery += "SE2.E2_FILIAL, SE2.E2_FILORIG, SE2.E2_PREFIXO, SE2.E2_NUM, SE2.E2_PARCELA, SE2.E2_TIPO, SE2.E2_FORNECE, SE2.E2_LOJA, "
		cQuery += "SE2.E2_NATUREZ, SE2.E2_EMIS1, SE2.E2_EMISSAO, SE2.E2_PORTADO, SE2.E2_VENCREA, SE2.E2_VLCRUZ, SE2.E2_VALOR, SE2.E2_MOEDA, "
		cQuery += "SE2.E2_HIST, SE2.E2_FATURA, SE2.E2_DTFATUR, SE2.E2_VRETPIS, SE2.E2_VRETCOF, SE2.E2_VRETCSL, SA2.A2_FILIAL, SA2.A2_CONTA, SE2.E2_DESDOBR, SE2.E2_BAIXA "
		
		cQuery += " FROM " + RetSqlName("SE2") + " SE2"
		
		// Relaciona tabela de clientes para buscar conta contabil
		// INNER JOIN SE2 com SA2
		cQuery += " INNER JOIN " + RetSqlName("SA2") + " SA2 ON "
		If nTamFilSA2 > 0
			If cBDname $ "ORACLE|DB2|POSTGRES|INFORMIX"
				cQuery += 				" SUBSTR(SA2.A2_FILIAL,1," + str(nTamFilSA2) +" ) = SUBSTR(SE2.E2_FILORIG,1,"+Str(nTamFilSA2)+") AND "
			Else
				cQuery += 				" SUBSTRING(SA2.A2_FILIAL,1,"+ str(nTamFilSA2)+") = SUBSTRING(SE2.E2_FILORIG,1,"+Str(nTamFilSA2)+") AND "
			EndIf
		EndIf
		cQuery +=					" SA2.A2_COD = SE2.E2_FORNECE AND " 
		cQuery +=					" SA2.A2_LOJA = SE2.E2_LOJA "
		If mv_par18 == 1 .And. lSqlOracle		// Seleciona clientes por conta contabil
			cQuery +=				" AND SA2.A2_CONTA BETWEEN '" + mv_par19 + "' AND '" + mv_par20 + "' "
		EndIf
		cQuery +=					" AND SA2.D_E_L_E_T_ = ' ' "
		
		cQuery += " WHERE "
		If !Empty(aSelFil) 		/* GESTAO */
			cQuery += " SE2.E2_FILIAL " + GetRngFil(aSelFil,"SE2",.T.,@cTmpFil)
			Aadd(aTmpFil,cTmpFil)
		Else
			If mv_par10 == 1 .Or. Empty( cFilSE2 )
				cQuery += " SE2.E2_FILIAL = '" + cFilSE2 + "' "
			Else
				cQuery += " SE2.E2_FILIAL BETWEEN '  ' AND 'ZZ' "
			EndIf
		Endif
		
		cQuery += " AND SE2.E2_TIPO NOT IN " + FormatIn( MVPROVIS, "/" )
		
		If mv_par07 == 2
			cQuery += " AND SE2.E2_TIPO NOT IN " + FormatIn( MVPAGANT, "/" )
		EndIf
		
		If mv_par07 == 3
			cQuery += " AND SE2.E2_TIPO IN " + FormatIn( MVPAGANT, "/" )
		EndIf
					
		// Nao adiciona filtro se pedir range de branco a ZZZ    
		If mv_par04 == mv_par05
			cQuery += " AND SE2.E2_FORNECE = '" + mv_par04 + "' "			
		ElseIf ! ( Empty(mv_par04) .And. Upper( AllTrim(mv_par05) ) == Replicate( "Z", Len( AllTrim(mv_par05) ) ) )
			cQuery += " AND SE2.E2_FORNECE BETWEEN '" + mv_par04 + "' AND '" + mv_par05 + "'"
		EndIf	
		
		If dDatabase <= mv_par02
			cQuery += " AND SE2.E2_EMIS1 <= '" + DTOS(dDataBase) + "'"
		Else	
			cQuery += " AND SE2.E2_EMIS1 <= '" + DTOS(mv_par02)  + "'"
		EndIf	
		
		If mv_par15 == 1
			cQuery += " AND SE2.E2_PREFIXO BETWEEN '" + mv_par08 + "' AND '" + mv_par09 + "'"
		Endif
		
		// Nao adiciona filtro se pedir range de branco a ZZZ
		If mv_par12 == mv_par13
			cQuery += " AND SE2.E2_NATUREZ = '" + mv_par12 + "' "
		ElseIf ! ( Empty(mv_par12) .And. Upper( AllTrim(mv_par13) ) == Replicate( "Z", Len( AllTrim(mv_par13) ) ) )
			cQuery += " AND SE2.E2_NATUREZ BETWEEN '" + mv_par12 + "' AND '" + mv_par13 + "'"
		EndIf	
		
		If mv_par11 == 1
			cQuery += " AND SE2.E2_TIPO IN " + FORMATIN(cTipos,"/")
		Endif
		
		cQuery += " AND SE2.D_E_L_E_T_ = ' '"
			
		// Verifica quais serao impressos

		cQuery := ChangeQuery(cQuery)

		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'TRBSE2', .F., .T.)

		TCSetField( "TRBSE2", "E2_VLCRUZ", "N", TamSX3( "E2_VLCRUZ" )[1], TamSX3( "E2_VLCRUZ" )[2] )
		TCSetField( "TRBSE2", "E2_MOEDA" , "N", TamSX3( "E2_MOEDA" )[1] , TamSX3( "E2_MOEDA"  )[2] )

		TCSetField( "TRBSE2", "E2_EMISSAO", "D" )
		TCSetField( "TRBSE2", "E2_EMIS1"  , "D" )
		TCSetField( "TRBSE2", "E2_VENCREA", "D" )
		TCSetField( "TRBSE2", "E2_DTFATUR", "D" )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posicionamento do SE5 neste ponto que servira para   ³
		//³pesquisa de descarte de registros geradores de       ³
		//³desdobramento                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SE5->(dbSetOrder(7))	//E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ

		dbSelectArea( "TRBSE2" )

		While TRBSE2->(!EoF())

			//Pesquisa de descarte de registros geradores de desdobramento
			If TRBSE2->E2_DESDOBR == "S" .And. !Empty( TRBSE2->E2_BAIXA ) 
				If SE5->( MsSeek( FWxFilial("SE5",TRBSE2->E2_FILORIG) + TRBSE2->E2_PREFIXO + TRBSE2->E2_NUM + TRBSE2->E2_PARCELA + TRBSE2->E2_TIPO + TRBSE2->E2_FORNECE + TRBSE2->E2_LOJA ) )
					If AllTrim(SE5->E5_TIPODOC) == "BA" .AND. AllTrim(SE5->E5_MOTBX) == "DSD"
						TRBSE2->(DbSkip())
						Loop
					Endif
				Endif
			Endif	

			If TRBSE2->E2_TIPO $ MVPAGANT // Gera cheque para Adiantamento = Não e Gera movimento bancário sem cheque = Não
				lAchou:= SE5->( MsSeek( FWxFilial("SE5",TRBSE2->E2_FILORIG) + TRBSE2->E2_PREFIXO + TRBSE2->E2_NUM + TRBSE2->E2_PARCELA + TRBSE2->E2_TIPO + TRBSE2->E2_FORNECE + TRBSE2->E2_LOJA ) )
				If !lAchou
					TRBSE2->(DbSkip())
					Loop
				Endif
			Endif

			If cPaisLoc <> "BRA"
				cHistor := ""
				If TRBSE2->E2_TIPO == "NCP"
					cHistor := STR0030  //"NOTA DE CREDITO No. "
				ElseIf TRBSE2->E2_TIPO == "NDP"
					cHistor := STR0031  //"NOTA DE DEBITO No. "
				ElseIf ALLTRIM(TRBSE2->E2_TIPO) $ "NF|FT"
					cHistor := STR0032  //"FACTURA No. "
				ElseIf TRBSE2->E2_TIPO == "NCE"
					cHistor := STR0036  //"NOTA DE CRED. EXTERNA"
				ElseIf TRBSE2->E2_TIPO == "NDE"
					cHistor := STR0037  //"NOTA DE DEB. EXTERNA"
				EndIf
				cHistor :=  IIF(Empty(TRBSE2->E2_HIST),cHistor,TRBSE2->E2_HIST)
			ElseIf Alltrim(TRBSE2->E2_FATURA) == "NOTFAT" .And. cPaisLoc == 'BRA'
				cHistor := IIF(Empty(TRBSE2->E2_HIST),STR0029,TRBSE2->E2_HIST)  //"Pela Emissao da Fatura"
			Else
				cHistor := IIF(Empty(TRBSE2->E2_HIST),STR0012,TRBSE2->E2_HIST)  //"Pela Emissao do Titulo"
			Endif
			cDC := 'C'
			IF TRBSE2->E2_TIPO$ MVPAGANT+"/"+MVABATIM+"/"+MV_CPNEG
				cDC := "D"
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava debito no arquivo de trabalho                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oBulk:AddData({TRBSE2->E2_FORNECE,;                       //- CODIGO
					TRBSE2->E2_LOJA,;                                 //- LOJA
					TRBSE2->E2_EMIS1,;                                //- DATAEM
					TRBSE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO),;  //- NUMERO
					TRBSE2->E2_TIPO,;                                 //- TIPO
					TRBSE2->E2_PORTADO,;                              //- BANCO
					TRBSE2->E2_EMISSAO,;                              //- EMISSAO 
					CtoD(''),;                                        //- BAIXA
					TRBSE2->E2_VENCREA,;                              //- VENCTO
					TRBSE2->E2_VLCRUZ,;                               //- VALOR
					cHistor,;                                         //- HISTOR
					cDC,;                                             //- DC
					TRBSE2->E2_MOEDA,;                                //- MOEDA 
					TRBSE2->A2_CONTA,;                                //- CONTA
					TRBSE2->E2_PREFIXO,;                              //- PREFIXO 
					TRBSE2->E2_PARCELA,;                              //- PARCELA 
					TRBSE2->E2_FILIAL,;                               //- FILIAL
					TRBSE2->E2_FILORIG,;                              //- FILORI
					TRBSE2->A2_FILIAL})                               //- FILENT
			
			//Abatimentos que fizeram parte da fatura
			IF TRBSE2->E2_TIPO $ MVABATIM .AND. !Empty(TRBSE2->E2_FATURA) .AND. ;
					Alltrim(TRBSE2->E2_FATURA) != "NOTFAT" .AND. TRBSE2->E2_DTFATUR <= mv_par02

				oBulk:AddData({TRBSE2->E2_FORNECE,;                       //- CODIGO
						TRBSE2->E2_LOJA,;                                 //- LOJA
						TRBSE2->E2_EMIS1,;                                //- DATAEM
						TRBSE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO),;  //- NUMERO
						TRBSE2->E2_TIPO,;                                 //- TIPO
						TRBSE2->E2_PORTADO,;                              //- BANCO
						TRBSE2->E2_EMISSAO,;                              //- EMISSAO 
						TRBSE2->E2_DTFATUR,;                              //- BAIXA
						TRBSE2->E2_VENCREA,;                              //- VENCTO
						TRBSE2->E2_VLCRUZ,;                               //- VALOR
						STR0013 + TRBSE2->E2_FATURA,;                     //- HISTOR  "BX EMIS FAT "
						'C',;                                             //- DC
						0,;                                               //- MOEDA 
						TRBSE2->A2_CONTA,;                                //- CONTA
						' ',;                                             //- PREFIXO 
						' ',;                                             //- PARCELA 
						TRBSE2->E2_FILIAL,;                               //- FILIAL
						TRBSE2->E2_FILORIG,;                              //- FILORI
						TRBSE2->A2_FILIAL})                               //- FILENT

			Endif	
			
			//Gera movimentos de histórico em casos de retenção de pis, cofins e csll
			If lPCCBaixa .And. TRBSE2->E2_TIPO $ MVPAGANT  //Verifico se eh PA para exibir tx's na emissao
				For nX:= 1 To Len(aImp10925)
					If &(aImp10925[nX][1]) > 0
						oBulk:AddData({TRBSE2->E2_FORNECE,;                       //- CODIGO
								TRBSE2->E2_LOJA,;                                 //- LOJA
								TRBSE2->E2_EMIS1,;                                //- DATAEM
								TRBSE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO),;  //- NUMERO
								' ',;                                             //- TIPO
								' ',;                                             //- BANCO
								TRBSE2->E2_EMISSAO,;                              //- EMISSAO 
								CtoD(''),;                                        //- BAIXA
								TRBSE2->E2_VENCREA,;                              //- VENCTO
								&(aImp10925[nX][1]),;                             //- VALOR
								STR0047 + " - " + aImp10925[nX][2],;              //- HISTOR - Desc.Imposto
								'D',;                                             //- DC
								0,;                                               //- MOEDA 
								TRBSE2->A2_CONTA,;                                //- CONTA
								' ',;                                             //- PREFIXO 
								' ',;                                             //- PARCELA 
								TRBSE2->E2_FILIAL,;                               //- FILIAL
								TRBSE2->E2_FILORIG,;                              //- FILORI
								TRBSE2->A2_FILIAL})                               //- FILENT

					Endif
				Next
			Endif
			
			TRBSE2->(DbSkip())
		Enddo
		oBulk:Close()

		TRBSE2->(DbCloseArea())

	Endif

	//Ordeno Array de abatimentos de C.Receber
	If Len(aDadosAbat) > 0
		aSort(aDadosAbat,,,{|x,y| x[1]+x[2]+x[4] > y[1]+y[2]+y[4]})
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Localiza na movimentacao bancaria, os titulos do periodo     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cCposSE5 := "SELECT "

	cCposSE5 += "SE5.E5_FILIAL, SE5.E5_PREFIXO, SE5.E5_NUMERO, SE5.E5_PARCELA, SE5.E5_TIPO, SE5.E5_CLIFOR, SE5.E5_LOJA, SE5.E5_TIPODOC, SE5.E5_NATUREZ, SE5.E5_RECPAG, SE5.E5_DTDIGIT, "
	cCposSE5 += "SE5.E5_DATA, SE5.E5_MOTBX, SE5.E5_BANCO,SE5.E5_AGENCIA,SE5.E5_CONTA, SE5.E5_HISTOR, SE5.E5_VALOR, SE5.E5_VLMOED2, SE5.E5_PRETPIS, SE5.E5_PRETCOF, SE5.E5_PRETCSL, SE5.E5_VRETPIS, SE5.E5_VRETCOF, SE5.E5_VRETCSL, "
	cCposSE5 += "SE5.E5_VRETCOF, SE5.E5_VRETCSL, SE5.E5_VRETISS, SE5.E5_VLJUROS, SE5.E5_VLMULTA, SE5.E5_VLCORRE, SE5.E5_VLDESCO, SE5.E5_SEQ, SE5.E5_FILORIG, SE5.E5_MOEDA, SE5.E5_TXMOEDA, SE5.E5_DOCUMEN, "
	cCposSE5 += "SE5.E5_VRETIRF, SE5.E5_PRETIRF, SE5.E5_TABORI, SE5.E5_IDORIG, E5_VLACRES, "

	cCposFK6 := " (SELECT COUNT(FK6.FK6_FILIAL) FROM " + RetSqlName("FK6") + " FK6 WHERE "
	cCposFK6 += " FK6.FK6_FILIAL = SE5.E5_FILIAL "
	cCposFK6 += " AND FK6.FK6_IDORIG = SE5.E5_IDORIG "	
	cCposFK6 += " AND FK6.FK6_TABORI = SE5.E5_TABORI "
	cCposFK6 += " AND FK6.FK6_TPDOC =  'VA' "
	cCposFK6 += " AND FK6.D_E_L_E_T_ = ' ') FK6_VA "

	cFromSE5A := " FROM " + RetSqlName("SE5") + " SE5 , "  + RetSqlName("SE1") + " SE1, " + RetSqlName("SA1") + " SA1 "	
	cFromSE5B := " FROM " + RetSqlName("SE5") + " SE5 , "  + RetSqlName("SE2") + " SE2, " + RetSqlName("SA2") + " SA2 "
	cWhereE5A := " WHERE "
				
	If !Empty(aSelFil) 		/* GESTAO */
		cWhereE5A += " SE5.E5_FILIAL " + GetRngFil(aSelFil,"SE5",.T.,@cTmpFil)
		Aadd(aTmpFil,cTmpFil)
	Else
		If mv_par10 == 1 .Or. Empty( FWxFilial( "SE5" ) )
			cWhereE5A += " SE5.E5_FILIAL = '" + cFilSE5 + "' "
		else
			cWhereE5A += " SE5.E5_FILIAL BETWEEN '  ' AND 'ZZ' "
		endif
	Endif
				
	cWhereE5A += " AND SE5.E5_NUMERO != '" +space(6)+"'"
	cWhereE5A += " AND SE5.E5_SITUACA != 'C'"
	cWhereE5A += " AND SE5.E5_SITUACA != 'X'"

	If dDataBase <= mv_par02		
		cWhereE5A += " AND SE5.E5_DTDIGIT <= '"+DTOS(dDataBase)+ "' "
	Else
		cWhereE5A += " AND SE5.E5_DTDIGIT <= '" + DTOS(mv_par02) + "' "
	EndIf	

	cWhereE5A += " AND NOT ( SE5.E5_TIPODOC = 'BA' AND SE5.E5_MOTBX = 'DSD' ) "

	If mv_par15 == 1
		cWhereE5A += " AND SE5.E5_PREFIXO BETWEEN '" + mv_par08 + "' AND '" + mv_par09 + "'"
	Endif
				
	If mv_par04 == mv_par05
		cWhereE5A += " AND SE5.E5_CLIFOR = '" + mv_par04 + "' "
	ElseIf ! ( Empty(mv_par04) .And. Upper( AllTrim(mv_par05) ) == Replicate( "Z", Len( AllTrim(mv_par05) ) ) )
		// Nao adiciona filtro se pedir range de branco a ZZZ		
		cWhereE5A += " AND SE5.E5_CLIFOR BETWEEN '" + mv_par04 + "' AND '" + mv_par05 + "'"
	EndIf	

	If mv_par12 == mv_par13
		cWhereE5A += " AND SE5.E5_NATUREZ = '" + mv_par12 + "' "
	ElseIf ! ( Empty(mv_par12) .And. Upper( AllTrim(mv_par13) ) == Replicate( "Z", Len( AllTrim(mv_par13) ) ) )
		// Nao adiciona filtro se pedir range de branco a ZZZ		
		cWhereE5A += " AND SE5.E5_NATUREZ BETWEEN '" + mv_par12 + "' AND '" + mv_par13 + "'"
	EndIf		       
		
	cWhereE5A += " AND SE5.E5_TIPO NOT IN " + FormatIn( MVPROVIS, "/" )

	If mv_par11 == 1
		cWhereE5A += " AND SE5.E5_TIPO IN " + FORMATIN(cTipos,"/")
	Endif
	cWhereE5A += " AND SE5.E5_TIPODOC IN ('VL','VM','BA','CP','LJ','V2','ES')" 

	If mv_par03 == 1

		cWhereE5A += " AND ((SE5.E5_RECPAG = 'R' AND SE5.E5_TIPODOC <> 'ES')"
		cWhereE5A += " OR (SE5.E5_TIPODOC = 'ES' AND SE5.E5_RECPAG = 'P')"
		cWhereE5A += " OR (SE5.E5_TIPO IN ('"+MV_CRNEG+"','"+MVRECANT+"')))"

		// Baixa de adiantamentos
		cWhereE5A += " AND NOT "
		cWhereE5A += "( SE5.E5_RECPAG = 'R' AND SE5.E5_TIPO IN " + FormatIn( MV_CPNEG + "|" + MVPAGANT, "|" )
		cWhereE5A += " AND SE5.E5_TIPODOC IN " + FormatIn( "VL/BA/DC/D2/MT/JR/J2/M2/CM/C2/CX", "/" ) + " ) "

	Endif

	If mv_par03 == 2

		cWhereE5A += " AND ((SE5.E5_RECPAG = 'P' AND SE5.E5_TIPODOC <> 'ES')"
		cWhereE5A += " OR  (SE5.E5_TIPODOC = 'ES' AND SE5.E5_RECPAG = 'R')"
		cWhereE5A += " OR (SE5.E5_TIPO IN (" +  FR550VldVar(MV_CPNEG) + ",'"+MVPAGANT +"')))"

		// Baixa de adiantamentos
		cWhereE5A += " AND NOT "
		cWhereE5A += "( SE5.E5_RECPAG = 'P' AND SE5.E5_TIPO IN " + FormatIn( MV_CRNEG + "/" + MVRECANT, "/" ) 
		cWhereE5A += " AND SE5.E5_TIPODOC IN " + FormatIn( "VL/BA/DC/D2/MT/JR/J2/M2/CM/C2/CX", "/" ) + " ) "
													
	Endif

	If mv_par03 == 1 .And. mv_par07 == 2 // Carteira a Receber e soh titulos normais
		cWhereE5A += "AND ( SE5.E5_RECPAG != 'R' OR ( SE5.E5_RECPAG = 'R' AND SE5.E5_TIPO NOT IN " + FormatIn( MVRECANT, "/" ) + " ) ) "
	EndIf	

	If mv_par03 == 1 .And. mv_par07 == 3	// Carteira a Receber e soh titulos de adiantamento
		cWhereE5A += "AND ( SE5.E5_RECPAG != 'R' OR ( SE5.E5_RECPAG = 'R' AND SE5.E5_TIPO IN " + FormatIn( MVRECANT, "/" ) + " ) ) "
	EndIf                                                                                      

	If mv_par03 == 2 .And. mv_par07 == 2	// Carteira a Pagar e soh titulos normais
		cWhereE5A += "AND ( SE5.E5_RECPAG != 'P' OR ( SE5.E5_RECPAG = 'P' AND SE5.E5_TIPO NOT IN " + FormatIn( MVPAGANT, "/" ) + " ) ) "
	EndIf	

	If mv_par03 == 2 .And. mv_par07 == 3	// Carteira a Pagar e soh titulos de adiantamento
		cWhereE5A += "AND ( SE5.E5_RECPAG != 'P' OR ( SE5.E5_RECPAG = 'P' AND SE5.E5_TIPO IN " + FormatIn( MVPAGANT, "/" ) + " ) ) "
	EndIf	                                        

	If mv_par03 == 2						//Carteira a Pagar Removendo Cancelamento de Cheques
		cWhereE5A += " AND NOT ( SE5.E5_TIPODOC = 'ES' AND SE5.E5_RECPAG = 'R' AND EXISTS ( "
	Else									//Carteira a Receber Removendo Cancelamento de Cheques
		cWhereE5A += " AND NOT ( SE5.E5_TIPODOC = 'ES' AND SE5.E5_RECPAG = 'P' AND EXISTS ( "
	EndIf
	cWhereE5A += " SELECT R_E_C_N_O_ "
	cWhereE5A += " FROM " + RetSqlName("SE5") + " "
	cWhereE5A += " WHERE "
	cWhereE5A += " E5_FILIAL = SE5.E5_FILIAL AND "
	cWhereE5A += " E5_PREFIXO = SE5.E5_PREFIXO AND "
	cWhereE5A += " E5_NUMERO = SE5.E5_NUMERO AND "
	cWhereE5A += " E5_PARCELA = SE5.E5_PARCELA AND "
	cWhereE5A += " E5_TIPO = SE5.E5_TIPO AND "
	cWhereE5A += " E5_TIPODOC = 'CH' AND "
	cWhereE5A += " D_E_L_E_T_ = ' ' ) ) "

	cWhereE5A += " AND SE5.D_E_L_E_T_ = ' ' "

	cOrderBy := " ORDER BY E5_FILIAL, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_SEQ "


	If mv_par03 == 1
		cWhereE5B := " AND "
		//INI Tratamento Filial SE1 x SE5
		cWhereE5B += "("
		cWhereE5B += "( SE1.E1_FILORIG = SE5.E5_FILORIG AND SE5.E5_FILORIG != '"+SPACE(nTamFil)+"') "		// Tratamento pelo filorig
		
		If Len(AllTrim(cFilSE1)) <> nTamFilSE5 .And. nTamFilSE5 > 0											//Verifica se não SE1 e SE5 possui o mesmo compartilhamento
			cWhereE5B +=  "OR ( Substring(SE1.E1_FILIAL, 1,"+str(nTamFilSE5,2)+") = Substring( SE5.E5_FILIAL,1,"+str(nTamFilSE5,2)+") ) " // Tratamento pelo compartilhamento da SE5, esse existe para base legado com FILORIG em branco
		EndIf

		cWhereE5B += " ) AND "
		//FIM Tratamento Filial SE1 x SE5
		cWhereE5B += " SE1.E1_PREFIXO = SE5.E5_PREFIXO AND "
		cWhereE5B += " SE1.E1_NUM = SE5.E5_NUMERO AND "
		cWhereE5B += " SE1.E1_PARCELA = SE5.E5_PARCELA AND "
		cWhereE5B += " SE1.E1_TIPO	= SE5.E5_TIPO AND "
		cWhereE5B += " SE1.E1_CLIENTE = SE5.E5_CLIFOR AND "
		cWhereE5B += " SE1.E1_LOJA = SE5.E5_LOJA AND "
		cWhereE5B += " SE1.D_E_L_E_T_ = ' ' "

		cQuery := cCposSE5 
		cQuery += "SE1.E1_EMISSAO EMISSAO, SE1.E1_VENCREA VENCREA, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_VALOR, SA1.A1_CONTA CONTA, SA1.A1_FILIAL FILENT, "
		cQuery += cCposFK6
		cQuery += cFromSE5A
		cQuery += cWhereE5A
		cQuery += cWhereE5B
		
		// Relaciona tabela de clientes para buscar conta contabil
		cQuery += " AND SA1.A1_FILIAL = '" + cFilSA1 + "' "
		cQuery += " AND SA1.A1_COD = SE1.E1_CLIENTE " 
		cQuery += " AND SA1.A1_LOJA = SE1.E1_LOJA "
		If mv_par18 == 1 .And. lSqlOracle		// Seleciona clientes por conta contabil
			cQuery += " AND SA1.A1_CONTA BETWEEN '" + mv_par19 + "' AND '" + mv_par20 + "' "
		Endif
		cQuery += " AND SA1.D_E_L_E_T_ = ' ' "          
		
	Else
		cWhereE5C := " AND "
		//INI Tratamento Filial SE2 x SE5
		cWhereE5C += "("
		cWhereE5C += "( SE2.E2_FILIAL = SE5.E5_FILORIG AND SE5.E5_FILORIG != '"+SPACE(nTamFil)+"') "		// Tratamento pelo filorig
		cWhereE5C += " OR ( SE2.E2_FILIAL = SE5.E5_FILIAL ) " 												//Mesmo compartilhamento 

		If Len(AllTrim(cFilSE2)) <> nTamFilSE5 .And. nTamFilSE5 > 0											//Verifica se não SE2 e SE5 possui o mesmo compartilhamento
			cWhereE5C +=  "OR ( Substring(SE2.E2_FILIAL, 1,"+str(nTamFilSE5,2)+") = Substring( SE5.E5_FILIAL,1,"+str(nTamFilSE5,2)+") ) " // Tratamento pelo compartilhamento da SE5, esse existe para base legado com FILORIG em branco
		EndIf

		cWhereE5C += " ) AND "
		//FIM Tratamento Filial SE2 x SE5

		cWhereE5C += " SE2.E2_PREFIXO = SE5.E5_PREFIXO AND "
		cWhereE5C += " SE2.E2_NUM = SE5.E5_NUMERO AND "
		cWhereE5C += " SE2.E2_PARCELA = SE5.E5_PARCELA AND "
		cWhereE5C += " SE2.E2_TIPO	= SE5.E5_TIPO AND "
		cWhereE5C += " SE2.E2_FORNECE = SE5.E5_CLIFOR AND "
		cWhereE5C += " SE2.E2_LOJA	= SE5.E5_LOJA AND "
		cWhereE5C += " SE2.D_E_L_E_T_ = ' ' "

		cQuery := cCposSE5
		cQuery += "SE2.E2_EMISSAO EMISSAO, SE2.E2_VENCREA VENCREA, ' ' E2_FORNECE, ' ' E2_LOJA, ' ' E2_PREFIXO, ' ' E2_NUM, ' ' E2_PARCELA, ' ' E2_TIPO, 0 E2_VALOR, SA2.A2_CONTA CONTA, SA2.A2_FILIAL FILENT, "
		cQuery += cCposFK6
		cQuery += cFromSE5B
		cQuery += cWhereE5A
		cQuery += cWhereE5C

		// Relaciona tabela de clientes para buscar conta contabil
		If nTamFilSA2 > 0
			If cBDname $ "ORACLE|DB2|POSTGRES|INFORMIX"
				cQuery += 				" AND SUBSTR(SA2.A2_FILIAL,1," + str(nTamFilSA2) +" ) = SUBSTR(SE2.E2_FILORIG,1,"+Str(nTamFilSA2)+") "
			Else
				cQuery += 				" AND SUBSTRING(SA2.A2_FILIAL,1,"+ str(nTamFilSA2)+") = SUBSTRING(SE2.E2_FILORIG,1,"+Str(nTamFilSA2)+") "
			EndIf
		Endif	
		cQuery += " AND SA2.A2_COD = SE2.E2_FORNECE " 
		cQuery += " AND SA2.A2_LOJA = SE2.E2_LOJA "
		// Seleciona clientes por conta contabil
		If mv_par18 == 1 .And. lSqlOracle		
			cQuery += " AND SA2.A2_CONTA BETWEEN '" + mv_par19 + "' AND '" + mv_par20 + "' "
		Endif
		cQuery += " AND SA2.D_E_L_E_T_ = ' ' "          

	EndIf
	cQuery += cOrderBy

	cQuery := ChangeQuery(cQuery)

	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'TRBSE5', .F., .T.)

	TCSetField( "TRBSE5", "E5_VALOR"   , "N", TamSX3( "E5_VALOR" )[1]  , TamSX3( "E5_VALOR" )[2] )
	TCSetField( "TRBSE5", "E5_VLMOED2" , "N", TamSX3( "E5_VLMOED2" )[1], TamSX3( "E5_VLMOED2" )[2] )
	TCSetField( "TRBSE5", "E5_VLJUROS" , "N", TamSX3( "E5_VLJUROS" )[1], TamSX3( "E5_VLJUROS" )[2] )
	TCSetField( "TRBSE5", "E5_VLMULTA" , "N", TamSX3( "E5_VLMULTA" )[1], TamSX3( "E5_VLMULTA" )[2] )
	TCSetField( "TRBSE5", "E5_VLCORRE" , "N", TamSX3( "E5_VLCORRE" )[1], TamSX3( "E5_VLCORRE" )[2] )
	TCSetField( "TRBSE5", "E5_VLDESCO" , "N", TamSX3( "E5_VLDESCO" )[1], TamSX3( "E5_VLDESCO" )[2] )
	TCSetField( "TRBSE5", "E5_VRETPIS" , "N", TamSX3( "E5_VRETPIS" )[1], TamSX3( "E5_VRETPIS" )[2] )
	TCSetField( "TRBSE5", "E5_VRETCOF" , "N", TamSX3( "E5_VRETCOF" )[1], TamSX3( "E5_VRETCOF" )[2] )
	TCSetField( "TRBSE5", "E5_VRETCSL" , "N", TamSX3( "E5_VRETCSL" )[1], TamSX3( "E5_VRETCSL" )[2] )
	TCSetField( "TRBSE5", "E5_VRETIRF" , "N", TamSX3( "E5_VRETIRF" )[1], TamSX3( "E5_VRETIRF" )[2] )
	TCSetField( "TRBSE5", "E5_VLACRES" , "N", TamSX3( "E5_VLACRES" )[1], TamSX3( "E5_VLACRES" )[2] )

	TCSetField( "TRBSE5", "E5_DTDIGIT", "D" )
	TCSetField( "TRBSE5", "E5_DATA"   , "D" )

	If TRBSE5->( FieldPos( "EMISSAO" ) > 0 )
		TCSetField( "TRBSE5", "EMISSAO", "D" )
	EndIf	

	If TRBSE5->( FieldPos( "VENCREA" ) > 0 )
		TCSetField( "TRBSE5", "VENCREA", "D" )
	EndIf

	If TRBSE5->( FieldPos( "E1_VALOR" ) > 0 )
		TCSetField( "TRBSE5", "E1_VALOR", "N", TamSX3( "E1_VALOR" )[1], TamSX3( "E1_VALOR" )[2] )
	EndIf	

	If TRBSE5->( FieldPos( "E2_VALOR" ) > 0 )
		TCSetField( "TRBSE5", "E2_VALOR", "N", TamSX3( "E2_VALOR" )[1], TamSX3( "E2_VALOR" )[2] )
	EndIf

	dbSelectArea( "SED" )
	SED->(DbSetOrder(1))

	dbSelectArea( "SA2" )
	SA2->(DbSetOrder(1))

	dbSelectArea( "SA6" )
	SA6->(DbSetOrder(1))

	dbSelectArea( "TRBSE5" )

	While !EoF()
		
		IF mv_par03 == 1 .and. E5_RECPAG != "R"
			If (!(E5_TIPO $ MVRECANT+"/"+MV_CRNEG ) .AND. E5_TIPODOC !="ES") .or. ; //Baixa de RA
				(E5_TIPO $ MVPAGANT+"/"+MV_CPNEG .AND. E5_TIPODOC =="ES") .or. ; //Estorno da Baixa de PA
				((E5_TIPO $ MVRECANT) .AND. MV_PAR07 == 2).or. ;
				(!(E5_TIPO $ MVRECANT) .AND. MV_PAR07 == 3)
				dbSkip()
				Loop
			Endif
		EndIF

		IF mv_par03 == 2 .and. E5_RECPAG != "P"
			If (!( E5_TIPO $ MVPAGANT+"/"+MV_CPNEG ) .AND. E5_TIPODOC !="ES") .or.;   //Baixa de PA
				(E5_TIPO $ MVRECANT+"/"+MV_CRNEG .AND. E5_TIPODOC =="ES") .or. ; //Estorno da Baixa de RA
				(( E5_TIPO $ MVPAGANT) .AND. mv_par07 == 2).or. ;
				(!(E5_TIPO $ MVPAGANT) .AND. mv_par07 == 3)
				dbSkip()
				Loop
			Endif
		Endif

		/*tratamento para não gerar duplicidade quando a PA for incluída com a conf (F12) Gera cheque para Adiantamento = Sim, 
		Gera movimento bancário sem cheque = Não e Não for informado número de cheque.*/
		If mv_par03 == 2 .and. E5_RECPAG == "P"
			If ( E5_TIPO $ MVPAGANT+"/"+MV_CPNEG ) .and. E5_MOTBX == "NOR" .and. E5_TIPODOC == "BA"
				dbSkip()
				Loop
			EndIf			
		EndIf

		//Baixa efetuada pelo loja que gera duas linhas na SE5, somente a receber
		If cSE5KeyAnt == E5_FILIAL + E5_PREFIXO + E5_NUMERO + E5_PARCELA + E5_TIPO + E5_CLIFOR + E5_LOJA .And. cSeqAnt == E5_SEQ .And. cMoedaAnt == E5_MOEDA .And. !(cTipoAnt $ "JR") .And. SubStr(E5_HISTOR,1,4) == "LOJ-" .And. E5_RECPAG == "R" .And. cRecPagAnt == E5_RECPAG .And. cTipoAnt <> E5_TIPODOC
			dbSkip()
			Loop
		EndIf

		//Verifica a carteira da movimentação (pagar/receber)
		If TRBSE5->E5_TIPO $ MVPAGANT .Or. ( !TRBSE5->E5_TIPO $ MVRECANT+"|"+MV_CRNEG .And.;
				(TRBSE5->E5_RECPAG == "P" .And. TRBSE5->E5_TIPODOC != "ES") .Or. ;
				(TRBSE5->E5_RECPAG == "R" .And. TRBSE5->E5_TIPODOC == "ES") )
			cTbl 	  := "SE2"
			cCarteira := "P" 
		Else
			cTbl 	  := "SE1"
			cCarteira := "R"
		EndIf		

		cChvCliFor := E5_CLIFOR + E5_LOJA

		dEmissao := TRBSE5->EMISSAO
		dVencto  := TRBSE5->VENCREA

		aDados[1] := TRBSE5->E5_CLIFOR
		aDados[2] := TRBSE5->E5_LOJA
		aDados[3] := TRBSE5->E5_DTDIGIT
		aDados[4] := TRBSE5->(E5_PREFIXO + E5_NUMERO + E5_PARCELA + E5_TIPO)
		aDados[5] := TRBSE5->E5_BANCO
		aDados[6] := TRBSE5->E5_DATA
		aDados[7] := TRBSE5->E5_HISTOR
		aDados[8] := TRBSE5->E5_RECPAG
		aDados[9] := TRBSE5->E5_TIPO
		aDados[10]:= TRBSE5->E5_TIPODOC

		nValMov   := TRBSE5->E5_VALOR	
		nMoedaMov := Val(TRBSE5->E5_MOEDA)
		lMovMdEs  := MovMoedEs( TRBSE5->E5_MOEDA, TRBSE5->E5_TIPODOC, TRBSE5->E5_MOTBX, Dtos(TRBSE5->E5_DATA), TRBSE5->E5_RECPAG )	

		If cTbl == "SE2"
			cChaveTit := FWxFilial(cTbl, TRBSE5->E5_FILORIG)+TRBSE5->E5_PREFIXO+TRBSE5->E5_NUMERO+TRBSE5->E5_PARCELA+TRBSE5->E5_TIPO+TRBSE5->E5_CLIFOR+TRBSE5->E5_LOJA
		Else
			cChaveTit := FWxFilial(cTbl, TRBSE5->E5_FILORIG)+TRBSE5->E5_PREFIXO+TRBSE5->E5_NUMERO+TRBSE5->E5_PARCELA+TRBSE5->E5_TIPO
		EndIf 

		(cTbl)->(DbSetOrder(1))
		(cTbl)->(MsSeek(cChaveTit))

		/* Converte movimentação feita em moeda estrangeira para a moeda forte */
		If nMoedaMov > 1 .or. lMovMdEs
			lMovBcoBx := MovBcoBx(TRBSE5->E5_MOTBX)
			If !lMovBcoBx .OR. (TRBSE5->E5_TIPODOC == "BA" .AND. TRBSE5->E5_MOTBX == "CMP")
				nValMov := TRBSE5->E5_VLMOED2
			Else				
				//Encontra a moeda do titulo
				nMoedaTit := If(cTbl == "SE1", SE1->E1_MOEDA, SE2->E2_MOEDA)			
				
				If nMoedaTit==1
					nValMov := TRBSE5->E5_VLMOED2
				Else
					SA6->(MsSeek(FWxFilial('SA6')+TRBSE5->(E5_BANCO+E5_AGENCIA+E5_CONTA)))
					//-- A baixa grava taxa 1,00000 quando moeda do banco é igual moeda da baixa (titulo)
					If nMoedaMov==SA6->A6_MOEDA .And. TRBSE5->E5_TXMOEDA==1 
						nTxMovim:= If(cTbl == "SE1", SE1->E1_TXMOEDA, SE2->E2_TXMOEDA)
						//-- Se nao possuir taxa no titulo utiliza taxa do dia do movimento
						nTxMovim:= If(nTxMovim > 0 , nTxMovim , RecMoeda(TRBSE5->E5_DATA, nMoedaMov))
						nValMov := Round(NoRound(xMoeda(TRBSE5->E5_VALOR,nMoedaMov,1,TRBSE5->E5_DATA,nCentMd1+2,nTxMovim),nCentMd1+1),nCentMd1)
					Else
						nValMov := Round(NoRound(xMoeda(TRBSE5->E5_VALOR,nMoedaMov,1,TRBSE5->E5_DATA,nCentMd1+2,TRBSE5->E5_TXMOEDA),nCentMd1+1),nCentMd1)
					EndIf
				Endif
			Endif
		Endif

		/*--------------------------------------------------------------------------------------------------|
		Ajusta o valor de movimentações a receber cuja NF possui abatimentos e o E5_VALOR é gravado com o 
		valor integral (sem subtrair os abatimentos). Necessário para que o saldo seja zerado no relatório.
		---------------------------------------------------------------------------------------------------*/
		If cCarteira=="R" .And. Len(aDadosAbat) > 0
			nTotAbat := 0
			cChaveFK7 := xFilial("SE1")+"|"+TRBSE5->E1_PREFIXO + "|" + TRBSE5->E1_NUM + "|" +  TRBSE5->E1_PARCELA + "|" + TRBSE5->E1_TIPO + "|" +  TRBSE5->E1_CLIENTE + "|" + TRBSE5->E1_LOJA
			IF Alltrim(TRBSE5->E5_MOTBX) $ "LIQ" //Liquidações a Receber
				If TitDestAbt(cChaveFK7, TRBSE5->E5_FILORIG, TRBSE5->E5_DATA, TRBSE5->E5_DOCUMEN)
					nTotAbat := RetAbatCr(aDadosAbat,TRBSE5->E1_CLIENTE,TRBSE5->E1_LOJA,TRBSE5->E1_PREFIXO,TRBSE5->E1_NUM,TRBSE5->E1_PARCELA)
					nValMov -= nTotAbat
				EndIf
			ElseIf Alltrim(TRBSE5->E5_MOTBX) $ "CMP" //Compensações a Receber
				cTipoTit := Substr(TRBSE5->E5_DOCUMEN,nTamPref + nTamNro + nTamParc + 1, nTamTipo)  
				cSeqBx := SeqBxFKs("FK1", TRBSE5->E5_FILORIG, TRBSE5->E1_PREFIXO, TRBSE5->E1_NUM, TRBSE5->E1_PARCELA, TRBSE5->E1_TIPO,TRBSE5->E1_CLIENTE, TRBSE5->E1_LOJA)
				If cTipoTit $ (MV_CRNEG + "/" + MVRECANT) .And. Empty((cTbl)->E1_SALDO) .And. TRBSE5->E5_SEQ == cSeqBx
					nTotAbat := RetAbatCr(aDadosAbat,TRBSE5->E1_CLIENTE,TRBSE5->E1_LOJA,TRBSE5->E1_PREFIXO,TRBSE5->E1_NUM,TRBSE5->E1_PARCELA)				
					IF (cTbl)->E1_VALOR == (cTbl)->E1_VALLIQ .And. nTotAbat > 0
						nValMov -= nTotAbat //Subtrai o abatimento quando o total compensado não considerou os abatimentos
					EndIf
				EndIf
			EndIf
		EndIf

		aDados[11]:= nValMov

		aDados[12]:= CONTA
		
		If lPccBaixa .AND. mv_par03 == 2 //Carteira a Pagar
			aDados[13]:= TRBSE5->E5_PRETPIS
			aDados[14]:= TRBSE5->E5_PRETCOF
			aDados[15]:= TRBSE5->E5_PRETCSL
			
			aDados[16]:= TRBSE5->E5_VRETPIS
			aDados[17]:= TRBSE5->E5_VRETCOF
			aDados[18]:= TRBSE5->E5_VRETCSL
		Endif 
		
		If lIssBaixa .AND. mv_par03 == 2 .And. TRBSE5->E5_MOTBX <> "ISS"        
			If (lPccBaixa .Or. lRaRtImp) .and. Len(aDados) > 18
				aDados[19]:= E5_VRETISS								
			Else
				aDados[13]:= E5_VRETISS
			EndIf
		EndIf	

		aDados[nTamaDados-1] := FILENT

		//irrf na baixa
		//Posiciona o Fornecedor, pois não está posicionado
		If	mv_par03 == 2 .and. SA2->(MsSeek(FWxFilial("SA2") + TRBSE5->E5_CLIFOR + TRBSE5->E5_LOJA)) 
			If SA2->A2_CALCIRF == "2" .And. TRBSE5->E5_VRETIRF > 0 .And. TRBSE5->E5_PRETIRF $ " |7"
				aDados[nTamaDados] := E5_VRETIRF								
			Else
				aDados[nTamaDados] := 0
			Endif			
		Endif

		nValliq := aDados[11]
		
		If mv_par06 == 2  //  Nao Imprime valor Financeiro
			If nTxMovim > 0 // Movimento titulo e banco mesma moeda, E5_TXMOEDA == 1 
				nValliq -=	Round(NoRound(xMoeda( TRBSE5->( E5_VLJUROS + E5_VLMULTA + E5_VLCORRE - E5_VLDESCO) ,nMoedaMov,1,TRBSE5->E5_DATA,nCentMd1+2,nTxMovim),nCentMd1+1),nCentMd1)				
			Else			
				nValliq -=	TRBSE5->(E5_VLJUROS + E5_VLMULTA + E5_VLCORRE - E5_VLDESCO)
			EndIf
		Endif
		
		If E5_TIPODOC == "VM" // Correcao Monetaria
			If E5_VALOR > 0
				cTipo  := "C"
			Else
				If E5_TIPO $ MVRECANT+"/"+MV_CRNEG+"/"+MVPAGANT+"/"+MV_CPNEG
					cTipo  := "D"			
				Else
					cTipo  := "C"			
				Endif			
			Endif
			GravaTrab(cTipo,dEmissao,dVencto,nValliq,aDados,aDadosAbat,,.T.,"TRBSE5",lPccBaixa,"TRBSE5", cSTR47U)  // Registro principal
		Else
			GravaTrab("B",dEmissao,dVencto,nValliq,aDados,aDadosAbat,.T.,,"TRBSE5",lPccBaixa,"TRBSE5", cSTR47U)  // Registro principal
		Endif

		If mv_par06 == 1  // Imprime valor financeiro
			For nX := 1 To 5
				lCorrecao := .F.
				Do Case
					Case nX == 1		
						nCampo := E5_VLJUROS
						cTipo  := "J"
						aDados[7] := cSTR50U //UPPER(STR0050) //"Juros s/ Baixa"
						
						If E5_VLACRES > 0 .and. E5_VLJUROS > E5_VALOR .And. E5_VLJUROS <> E5_VLACRES 
							nCampo := E5_VALOR
						EndIf
					Case nX == 2		
						nCampo := E5_VLMULTA
						cTipo  := "M"
						aDados[7] := cSTR51U// STR0051 //"Multa s/ Baixa"
					Case nX == 3		
						nCampo := E5_VLDESCO
						cTipo  := "D"
						aDados[7] := cSTR52U//STR0052 //"Desconto s/ Baixa"
					Case nX == 4		
						nCampo := E5_VLCORRE
						If nCampo > 0
							cTipo  := "C"
						Else
							cTipo  := "D"
						Endif
						aDados[7] := cSTR53U//STR0053 //"C.Monetaria s/ Baixa"
						lCorrecao := .T.
					Case nX == 5
						nVa := 0
						If lFxLoadFK6 .And. FK6_VA <> 0
							aAreaAnt := GetArea()
							SE5->(DbSetOrder(2))
							If SE5->(DbSeek(xFilial("SE5", TRBSE5->E5_FILORIG) + "VA" + TRBSE5->E5_PREFIXO + TRBSE5->E5_NUMERO + TRBSE5->E5_PARCELA + TRBSE5->E5_TIPO + Dtos(TRBSE5->E5_DATA) + TRBSE5->E5_CLIFOR + TRBSE5->E5_LOJA))
								cFilBkp := cFilAnt
								cFilAnt := SE5->E5_FILORIG

								nVa := FxLoadFK6(TRBSE5->E5_TABORI,TRBSE5->E5_IDORIG,"VA")[1][2]

								cFilAnt := cFilBkp
							EndIf

							RestArea(aAreaAnt) 
							aSize(aAreaAnt,0)
							aAreaAnt := nil 
							cTipo  := "V"
							aDados[7] := cSTR75U//STR0075 //"Valor acessório s/ Baixa"							
						EndIf
				EndCase
				If nX < 5 .and. (nCampo > 0 .or. (nX == 4 .and. nCampo != 0))
					nValorFin := nCampo
				Elseif nX == 5 .and. nVa <> 0 
					nValorFin := nVa 
				Endif
				If nValorFin <> 0
					If nMoedaMov > 1 .and. !(nX == 4) //Trata conversão de moeda estrangeira para a moeda forte
						If nTxMovim > 0
							nValorFin := Round(NoRound(xMoeda(nValorFin,nMoedaMov,1,TRBSE5->E5_DATA,nCentMd1+2,nTxMovim),nCentMd1+1),nCentMd1)
						Else
							nValorFin := Round(NoRound(xMoeda(nValorFin,nMoedaMov,1,TRBSE5->E5_DATA,nCentMd1+2,TRBSE5->E5_TXMOEDA),nCentMd1+1),nCentMd1)
						EndIf
					Endif
					GravaTrab(cTipo,dEmissao,dVencto,nValorFin,aDados,aDadosAbat,,lCorrecao,"TRBSE5",lPccBaixa,"TRBSE5", cSTR47U)  // Registro principal	
				Endif
				nValorFin  := 0
			Next nX
		Endif

		cSeqAnt    := E5_SEQ
		cMoedaAnt  := E5_MOEDA
		cTipoAnt   := E5_TIPODOC
		cRecPagAnt := E5_RECPAG
		cSE5KeyAnt := E5_FILIAL + E5_PREFIXO + E5_NUMERO + E5_PARCELA + E5_TIPO + E5_CLIFOR + E5_LOJA
		nVa		   := 0
		nTxMovim   := 0

		dbSelectArea( "TRBSE5" )
		TRBSE5->( dbSkip())
	EndDo

	dbSelectArea( "SE5" )

	TRBSE5->( DbCloseArea())
	//- fecha e força o flush com os registros pendentes 
	oBulk:Close()

	//- Elimina o objeto 
	oBulk:Destroy()
	oBulk := nil

	// Inicia rotina de impressao
	oSection1:Init()
	oSection2:Init()
	aFill(aSec1,nil)
	aFill(aSec2,nil)

	dbSelectArea("cNomeArq")
	dbSetOrder(1)
	dbGoTop()

	nTotDebG := 0
	nTotCrdG := 0
	nSalAtuG := 0
	/*
	GESTAO - inicio */
	/* imprime a lista de filiais selecionadas para o relatorio */
	If Len(aSelFil) > 1 .And. !Eof()
		oSection1:SetHeaderSection(.F.)
		aSM0 := FWLoadSM0()
		nTamEmp := Len(FWSM0LayOut(,1))
		nTamUnNeg := Len(FWSM0LayOut(,2))
		cTitulo := oReport:Title()
		oReport:SetTitle(cTitulo + " (" + Upper(STR0074) + ")")		//"Filiais selecionadas para o relatorio"
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
		Next nX
		oReport:SetTitle(cTitulo)
		oSecFil:Finish()
		oSection1:SetHeaderSection(.T.)
		oReport:EndPage()
	Endif
	/* GESTAO - fim
	*/
	DbSelectArea("SA1")
	SA1->(DbSetOrder(1))

	DbSelectArea("SA2")
	SA2->(DbSetOrder(1))

	SX5->(DbSetOrder(1))

	While cNomeArq->(!Eof())
		//Se o parametro de filtro por conta contabil estiver marcado como SIM, a opcao de aglutinar por loja sera desconsiderado
		If MV_PAR25 == 2 .OR. MV_PAR18 == 1
			cCodigo		:= cNomeArq->CODIGO
			cLoja		:= cNomeArq->LOJA
			cFilTemp	:= cNomeArq->FILENT
			cFilOrig	:= cNomeArq->FILORI
			nSaldoAtu	:= 0
			nSaldoTra	:= 0
			nTotDeb		:= 0
			nTotCrd		:= 0
			lPrintCabec	:= .T.
			lPrintTotal := .T.
			lCalcSldAnt	:= .T.
		
			nRegAtu := cNomeArq->(Recno())
			lImprime := .F.

			lImprime := F550Impr(cTable,cCodigo,cLoja)
			cNomeArq->(dbGoto(nRegAtu))
			aSdoContabil := {} // Saldo da conta contabil do fornecedor
			cConta := ""
			
			While cNomeArq->(!Eof()) .AND. cNomeArq->CODIGO == cCodigo .AND. cNomeArq->LOJA == cLoja .AND. cNomeArq->FILENT == cFilTemp
				
					// Loop para calculo do saldo anterior
					lNoSkip := .F.

					//Novo calculo de Saldo
					If lCalcSldAnt .AND. (mv_par22 == 1 .OR. lImprime) 
						lCalcSldAnt := .F.
						//Calculo do saldo a Credito
						nSaldoAtu := F550CalSld( cTable, cCodigo, cLoja, @nRecno, @lNoSkip, .F. , cFilTemp)
						If nRecno == 0 // Nao existe movimenta‡?o do Fornecedor no periodo selecionado
							lNoSkip := .T.
							If MV_PAR22 == 2 .Or. ( MV_PAR22 == 1 .And. nSaldoAtu == 0 ) // N?o imprime nada, Fornecedor sem movimentos no periodo
								lPrintCabec := .F.
								lImprime := .F.
								lPrintTotal := .F.
								nSaldoAtu := 0
							EndIf
						Endif
					Endif

					If lImprime .Or. nSaldoAtu != 0
						If cAuxFoot = "A TRANSPORTAR"
							
							If nQuebra == 1
								If mv_par03==1
									If nTamFilSA1 > 0
										cFilSA1 := FWxFilial("SA1",cFilOrig)
									EndIf
								
									SA1->(MsSeek(Iif(Empty(FWxFilial("SA1")), FWxFilial("SA1"), cFilSA1)+cCodigo+cLoja))
									
									If mv_par14 == 1  // Analitico
										If RetGlbLGPD("A1_NOME")
											cNome := Replicate("*", nTamA1Nome) +" "+ IIF(!Empty(SA1->A1_CGC),Transform(Replicate("*", nTamA1CGC ),PesqPict("SA1","A1_CGC")),Replicate("*", nTamA1CGC) )+" "+SA1->A1_CONTA
										Else
											cNome := SA1->A1_NOME+" "+ IIF(!Empty(SA1->A1_CGC),Transform(SA1->A1_CGC,PesqPict("SA1","A1_CGC")),SA1->A1_CGC)+" "+SA1->A1_CONTA
										Endif
									Else
										If RetGlbLGPD("A1_NOME")
											cNome := Replicate("*", 33)       +" "+ IIF(mv_par18 == 1, SA1->A1_CONTA, IIF(!Empty(SA1->A1_CGC),Transform(Replicate("*", nTamA1CGC) ,PesqPict("SA1","A1_CGC")), Replicate("*", nTamA1CGC)))
										Else
											cNome := Substr(SA1->A1_NOME,1,33)+" "+ IIF(mv_par18 == 1, SA1->A1_CONTA, IIF(!Empty(SA1->A1_CGC),Transform(SA1->A1_CGC                          ,PesqPict("SA1","A1_CGC")),SA1->A1_CGC))
										Endif
									Endif
									cConta := SA1->A1_CONTA
									If mv_par21 ==1 .And. Empty(aSdoContabil) .And. !Empty(SA1->A1_CONTA)
										// Obtem o saldo da conta do fornecedor
										aSdoContabil := U_SdoContabil(SA1->A1_CONTA,MV_PAR02,"01","1")
									Endif	
								Else
								
									If nTamFilSA2 > 0
										cFilSA2 := FWxFilial("SA2",cFilOrig)
									EndIf
								
									SA2->(MsSeek(Iif(Empty(FWxFilial()),FWxFilial(), cFilSA2)+ cCodigo+cLoja))
									If mv_par14 == 1  // Analitico
										If RetGlbLGPD("A2_NOME")
											cNome := Replicate("*", nTamA2Nome) +" "+ Replicate("*", nTamA2CGC)+" "+SA2->A2_CONTA
										Else
											cNome := SA2->A2_NOME+" "+IF(!Empty(SA2->A2_CGC),Transform(SA2->A2_CGC,PesqPict("SA2","A2_CGC")),SA2->A2_CGC)+" "+SA2->A2_CONTA
										Endif
									Else
										If RetGlbLGPD("A2_NOME")
											cNome := Replicate("*", 33) +" "+ IIF(mv_par18 == 1,SA2->A2_CONTA,IF(!Empty(SA2->A2_CGC),Transform(Replicate("*", nTamA2CGC),PesqPict("SA2","A2_CGC")),Replicate("*", nTamA2CGC)))
										Else
											cNome := Substr(SA2->A2_NOME,1,33)+" "+IIF(mv_par18 == 1,SA2->A2_CONTA,IF(!Empty(SA2->A2_CGC),Transform(SA2->A2_CGC,PesqPict("SA2","A2_CGC")),SA2->A2_CGC))
										Endif
									Endif
									cConta := SA2->A2_CONTA
									If mv_par21 == 1 .And. Empty(aSdoContabil) .And. !Empty(SA2->A2_CONTA)
										// Obtem o saldo da conta do fornecedor
										aSdoContabil := U_SdoContabil(SA2->A2_CONTA,MV_PAR02,"01","1")	
									Endif	
								EndIf
								
								If cPaisLoc == 'BRA'
									If mv_par14 == 1   // Analitico
										oReport:PrintText(cCodigo + "-" + cLoja + " " + cNome)
										dbSelectArea("cNomeArq")
										aSec1[S1_HISTORICO]	:= STR0028 //"DE TRANSPORTE : "
										aSec1[S1_SALDO_ATU]	:= Abs(nSaldoAtu)
										aSec1[S1_DIGITO]		:= Eval(bBlockDC,nSaldoAtu)
										F550Print(oReport,.F.,aSec1)
										oReport:SkipLine()
										aFill(aSec1,nil)
									Endif
								Else  //If cPaisLoc == "ARG"
									If mv_par03 == 1
										SA1->( MsSeek(FWxFilial("SA1")+cCodigo+cLoja) )
									Else
										SA2->( MsSeek(FWxFilial("SA2")+cCodigo+cLoja) )
									Endif
									
									If RetGlbLGPD("A1_NOME")
										cTexto := PadR( IIf(MV_PAR03 == 1, Replicate("*", 40), Replicate("*", 40) ),50) + ;
													PadR(cCodigo + "-" + cLoja,42) + ;
													PadR(STR0028,24) + ;  //"TRANSPORTAR : "
													Transform(Abs(nSaldoAtu),tm(Abs(nSaldoAtu),14)) + ;
													" " + Eval(bBlockDC,nSaldoAtu)
										oReport:PrintText(cTexto)
									Else
										cTexto := PadR(If(mv_par03==1,Subs(SA1->A1_NOME,1,40),Subs(SA2->A2_NOME,1,40) ),50) + ;
													PadR(cCodigo + "-" + cLoja,42) + ;
													PadR(STR0028,24) + ;  //"TRANSPORTAR : "
													Transform(Abs(nSaldoAtu),tm(Abs(nSaldoAtu),14)) + ;
													" " + Eval(bBlockDC,nSaldoAtu)
										oReport:PrintText(cTexto)
									Endif
										
									cPosTp := aScan( aTipoCli, {|x| Subs(x,1,1) == If(mv_par03==1,SA1->A1_TIPO,SA2->A2_TIPO)  } )
									cTipoCli := If( cPosTp>0 , aTipoCli[cPosTp] , "" )
									
									SX5->( MsSeek(FWxFilial("SX5")+"12"+If(mv_par03==1,SA1->A1_EST,SA2->A2_EST)) )
									
									If mv_par03 == 1 //Carteira (Receber ou Pagar)
										cTexto :=	PadR(SA1->A1_END,50) + ;
														PadR("Te: "+Subs(Alltrim(SA1->A1_TEL),1,36),42) + ;
														PadR(STR0038+SA1->A1_VEND,50) //"VENDEDOR: "
										oReport:PrintText(cTexto)
										
										cTexto := PadR(SA1->A1_CEP + " - " + SA1->A1_MUN,92) 
										If SX5->( Found() ) .or. !Empty(X5Descri())
											cTexto += AllTrim(X5Descri())
										EndIf
										oReport:PrintText(cTexto)
										
										cTexto :=	PadR(cTipoCli,50) + ;
														Trans(SA1->A1_CGC,PesqPict("SA1","A1_CGC"))
										oReport:PrintText(cTexto)
									Else
										cTexto :=	PadR(SA2->A2_END,50) + ;
														PadR("Te: "+ Subs(Alltrim(SA2->A2_TEL),1,36),42) + ;
														STR0039  //"COMPRADOR: "
										oReport:PrintText(cTexto)
										
										cTexto := PadR(SA2->A2_CEP+" - " +SA2->A2_MUN,42) 
										If SX5->( Found() ) .or. !Empty(X5Descri())
											cTexto += AllTrim(X5Descri())
										Endif
										oReport:PrintText(cTexto)
										
										cTexto :=	PadR(cTipoCli,50) + ;
														Trans(SA2->A2_CGC,PesqPict("SA2","A2_CGC"))
									EndIf
									oReport:SkipLine()
								EndIf
							EndIf
							cAuxFoot = "X"
						EndIf
					EndIf
					
					If ( nQuebra == 0 .and. (lImprime .Or. nSaldoAtu != 0 ) ) .or. lPrintCabec
						nQuebra  := 1
						lImprAnt := .F.
						lPrintCabec := .F.
						If mv_par03 == 1
						
							If nTamFilSA1 > 0
								cFilSA1 := FWxFilial("SA1",cFilOrig)
							EndIf
								
							SA1->(MsSeek(Iif(Empty(FWxFilial("SA1")), FWxFilial("SA1"), cFilSA1)+cCodigo+cLoja))
							
							If mv_par14 == 1  // Analitico
								If RetGlbLGPD("A1_NOME")
									cNome := Replicate("*",nTamA1Nome) +" "+ Replicate("*",nTamA1CGC)+" "+ SA1->A1_CONTA
								Else
									cNome := alltrim(SA1->A1_NOME)+" "+IF(!Empty(SA1->A1_CGC),Transform(SA1->A1_CGC,PesqPict("SA1","A1_CGC")),SA1->A1_CGC)+" "+SA1->A1_CONTA
								Endif
							Else	
								If RetGlbLGPD("A1_NOME")
									cNome := Replicate("*", 33) +" "+IIF(mv_par18 == 1,Replicate("*",nTamA1Nome),Replicate("*",nTamA1CGC))
								Else
									cNome := Substr(SA1->A1_NOME,1,33)+" "+IIF(mv_par18 == 1,SA1->A1_CONTA,IF(!Empty(SA1->A1_CGC),Transform(SA1->A1_CGC,PesqPict("SA1","A1_CGC")),SA1->A1_CGC))
								Endif
							EndIf
							cConta := SA1->A1_CONTA
							If mv_par21 == 1 .And. Empty(aSdoContabil) .And. !Empty(SA1->A1_CONTA)
								// Obtem o saldo da conta do fornecedor
								aSdoContabil := U_SdoContabil(SA1->A1_CONTA,MV_PAR02,"01","1",aSelFil)	
							EndIf	
						Else
							If nTamFilSA2 > 0
								cFilSA2 := FWxFilial("SA2",cFilOrig)
							EndIf
							SA2->(MsSeek(Iif(Empty(FWxFilial()),FWxFilial(), cFilSA2)+ cCodigo+cLoja))
							If mv_par14 == 1  // Analitico
								If RetGlbLGPD("A2_NOME")
									cNome := Replicate("*",nTamA2Nome)  +" "+ Replicate("*",nTamA2CGC)+" "+SA2->A2_CONTA
								Else	
									cNome := alltrim(SA2->A2_NOME)+" "+IF(!Empty(SA2->A2_CGC),Transform(SA2->A2_CGC,PesqPict("SA2","A2_CGC")),SA2->A2_CGC)+" "+SA2->A2_CONTA
								Endif
							Else
								If RetGlbLGPD("A2_NOME")
									cNome := Replicate("*",33) +" "+ IIF(mv_par18 == 1,SA2->A2_CONTA,Replicate("*",nTamA2CGC) )
								Else
									cNome := Substr(SA2->A2_NOME,1,33)+" "+IIF(mv_par18 == 1,SA2->A2_CONTA,IF(!Empty(SA2->A2_CGC),Transform(SA2->A2_CGC,PesqPict("SA2","A2_CGC")),SA2->A2_CGC))
								Endif
							EndIf
							cConta := SA2->A2_CONTA		
							If mv_par21 == 1 .And. Empty(aSdoContabil) .And. !Empty(SA2->A2_CONTA)
								// Obtem o saldo da conta do fornecedor
								aSdoContabil := U_SdoContabil(SA2->A2_CONTA,MV_PAR02,"01","1",aSelFil)	
							EndIf	
						EndIf
						
						If cPaisLoc == "BRA"
							If mv_par14 == 1  // Analitico
								oReport:PrintText(cCodigo + "-" + cLoja + " " + alltrim(cNome))
								dbSelectArea("cNomeArq")
								aSec1[S1_HISTORICO] := STR0016  //"SALDO ANTERIOR : "
								aSec1[S1_SALDO_ATU] := Abs(nSaldoAtu)
								aSec1[S1_DIGITO]:= Eval(bBlockDC,nSaldoAtu)
								F550Print(oReport,.F.,aSec1)  
								aFill(aSec1,nil)
								oReport:SkipLine()
								if lPDF
									nLinReport := nLinReport + 2
								EndIf
								
								nSalAntG += nSaldoAtu
							Else
								aSec2[S2_DESCRICAO] := Substr(cCodigo + "-" + cLoja + " " + cNome,1,64)
								aSec2[S2_SD_ANTERIOR] := Abs(nSaldoAtu)
								aSec2[S2_DIG1] := Eval(bBlockDC,nSaldoAtu)
								nSalAntG += nSaldoAtu
							EndIf	
						Else
							
							If mv_par03 == 1 // Carteira (Receber ou Pagar)
								SA1->( MsSeek(FWxFilial("SA1")+cCodigo+cLoja) )
							Else
								SA2->( MsSeek(FWxFilial("SA2")+cCodigo+cLoja) )
							EndIf
							
							If RetGlbLGPD("A1_NOME")
								cTexto :=	PadR( If(mv_par03==1, Replicate("*", 40 ) , Replicate("*", 40) ),50) + ;
												PadR( cCodigo + "-" + cLoja,42) + ;
												PadR( STR0016,24 ) + ;  //"SALDO ANTERIOR : "
												PadR( Transform(Abs(nSaldoAtu),tm(Abs(nSaldoAtu),14) ),15 ) + ;
												" " + Eval(bBlockDC,nSaldoAtu)
								oReport:PrintText(cTexto)
							Else
								cTexto :=	PadR( If(mv_par03==1, Replicate("*", 40 ) , Replicate("*", 40 ) ),50) + ;
												PadR( cCodigo + "-" + cLoja,42) + ;
												PadR( STR0016,24 ) + ;  //"SALDO ANTERIOR : "
												PadR( Transform(Abs(nSaldoAtu),tm(Abs(nSaldoAtu),14) ),15 ) + ;
												" " + Eval(bBlockDC,nSaldoAtu)
								oReport:PrintText(cTexto)
							Endif
							oReport:SkipLine()
							
							nSalAntG += nSaldoAtu
							
							cPosTp := aScan( aTipoCli, {|x| Subs(x,1,1) == Iif(mv_par03==1,SA1->A1_TIPO,SA2->A2_TIPO)  } )
							cTipoCli := Iif( cPosTp>0 , aTipoCli[cPosTp] , "" )
							
							SX5->( MsSeek(FWxFilial("SX5")+"12"+If(mv_par03==1,SA1->A1_EST,SA2->A2_EST)) )
							
							If mv_par03 == 1 // Carteira (Receber ou Pagar)
								cTexto :=	PadR(SA1->A1_END,50) + ;
												PadR("Te: "+Subs(Alltrim(SA1->A1_TEL),1,36),42) + ;
												STR0038+SA1->A1_VEND  // "VENDEDOR : "
								oReport:PrintText(cTexto)
			
								cTexto :=	PadR(SA1->A1_CEP+" - " +SA1->A1_MUN,92)
								If SX5->( Found() ) .or. !Empty(X5Descri())
									cTexto += AllTrim(X5Descri())   // Diego
								EndIf
								oReport:PrintText(cTexto)
								
								cTexto :=	PadR(cTipoCli,50) + Trans(SA1->A1_CGC,PesqPict("SA1","A1_CGC"))
								oReport:PrintText(cTexto)
								oReport:SkipLine()
							Else
								cTexto :=	PadR(SA2->A2_END,50) + ;
												PadR("Te: "+Subs(Alltrim(SA2->A2_TEL),1,36),42) + ;
												STR0039 // "COMPRADOR: "
								oReport:PrintText(cTexto)
								
								cTexto := PadR(SA2->A2_CEP+" - " +SA2->A2_MUN,92)
								If SX5->( Found() ) .or. !Empty(X5Descri())
									cTexto += AllTrim(X5Descri())
								EndIf
								oReport:PrintText(cTexto)
								
								cTexto :=	PadR(cTipoCli,50) + ;
												Trans(SA2->A2_CGC,PesqPict("SA2","A2_CGC"))
								oReport:PrintText(cTexto)
								oReport:SkipLine()
							EndIf
						EndIf
					EndIf
					
					If cNomeArq->DATAEM >= mv_par01 .And. !lNoSkip
						If cNomeArq->DC == "D"
							nSaldoAtu -= ABS(cNomeArq->VALOR)
							nTotDeb   += ABS(cNomeArq->VALOR)
							nTotDebG  += ABS(cNomeArq->VALOR)
							nSalAtuG  -= ABS(cNomeArq->VALOR)
						Else
							nSaldoAtu += ABS(cNomeArq->VALOR)
							nTotCrd   += ABS(cNomeArq->VALOR)
							nTotCrdG  += ABS(cNomeArq->VALOR)
							nSalAtuG  += ABS(cNomeArq->VALOR)
						EndIf
						If mv_par14 == 1  // Analitico
							//li++
						
							aSec1[S1_DAT] := cNomeArq->DATAEM
							If STR0040 $ cNomeArq->HISTOR  //"Recibo"/"Receipt"
								aSec1[S1_HISTORICO] := If(mv_par24=1,Substr(cNomeArq->HISTOR, At(STR0040,cNomeArq->HISTOR),20),cNomeArq->HISTOR)
							Else
								aSec1[S1_HISTORICO] := If(mv_par24=1,SubStr(cNomeArq->HISTOR,1,20),cNomeArq->HISTOR)
							EndIf
							aSec1[S1_PREFIXO] := SubStr(cNomeArq->NUMERO, 1,3)
							aSec1[S1_NUM] := SubStr(cNomeArq->NUMERO, 4,nTamNro)
							aSec1[S1_PARCELA] := SubStr(cNomeArq->NUMERO,nTamNro+4,nTamParc)
							aSec1[S1_TIPO] := SubStr(cNomeArq->NUMERO,nTamNro+nTamParc+4,nTamTipo)
							aSec1[S1_EMISSAO] := cNomeArq->EMISSAO
							aSec1[S1_VENCIMENTO] := cNomeArq->VENCTO
							If !Empty(cNomeArq->BAIXA)
								aSec1[S1_BAIXA] := cNomeArq->BAIXA
							EndIf
							If cNomeArq->DC=="D"
								aSec1[S1_DEBITO] := ABS(cNomeArq->VALOR)
							Else
								aSec1[S1_CREDITO] := ABS(cNomeArq->VALOR)
							EndIf
							aSec1[S1_SALDO_ATU] := Abs(nSaldoAtu)
							aSec1[S1_DIGITO] := Eval(bBlockDC,nSaldoAtu)
							F550Print(oReport,.F.,aSec1)
							nSaldoTra := nSaldoAtu
							aFill(aSec1,nil)
						EndIf
					EndIf
				lFlag := .T.
				If !lNoSkip
					cNomeArq->(dbSkip( ))
				EndIf
				lNoSkip := .F.

				//Caso seja PDF, devera validar a quebra de linha novamente durante o laço
				IF(lPDF)
					F550LinPag(nLinPag, @nLinReport ,oReport,@nSaldoTra, .F. , .F. ,@nContFor)
				EndIf

			EndDo

		Else //Aglutinar todas lojas de fornecedor / cliente
			
			cCodigo		:= cNomeArq->CODIGO
			cLoja		:= ""
			nSaldoAtu	:= 0
			nSaldoTra	:= 0		/* GESTAO */
			nTotDeb		:= 0
			nTotCrd		:= 0
			nRegAtu 	:= cNomeArq->(Recno())
			lImprime 	:= .F.
			lPrintCabec	:= .T.
			lPrintTotal := .T.
			lCalcSldAnt	:= .T.

			// Procura titulos no intervalo e se houver, dever  imprimir
			// Faço uma query escalar para melhorar a performance
			lImprime := F550RImpr( cTable, cCodigo, nRegAtu )
			cNomeArq->(dbGoto(nRegAtu))

			aSdoContabil := {} // Saldo da conta contabil do fornecedor
			cCtContAnt := cNomeArq->CONTA

			While !cNomeArq->(Eof()) .AND. cNomeArq->CODIGO == cCodigo

				// Loop para calculo do saldo anterior
				lNoSkip := .F.

				//Novo calculo de Saldo
				If lCalcSldAnt .AND. (mv_par22 == 1 .Or. lImprime) 
					lCalcSldAnt := .F.
					//Calculo do saldo a Credito
					nSaldoAtu := F550CalSld( cTable, cCodigo,cLoja, @nRecno, @lNoSkip, .T. )				
					If nRecno == 0 // Nao existe movimenta‡?o do Fornecedor no periodo selecionado
						lNoSkip := .T.
						If MV_PAR22 == 2 .Or. ( MV_PAR22 == 1 .And. nSaldoAtu == 0 ) // N?o imprime nada, Fornecedor sem movimentos no periodo
							lPrintCabec := .F.
							lImprime := .F.
							lPrintTotal := .F.
							nSaldoAtu	:= 0
						EndIf
					Endif
				Endif

				If mv_par21 == 1 .AND. (mv_par22 == 1 .OR. lImprime)
					//Pesquisar se o cliente / fornecedor esta utilizando um conta diferente entre as lojasss
					If FR550RetCF(cCodigo, cNomeArq->LOJA, IIf(mv_par03 == 1,"A1_CONTA","A2_CONTA")) # cCtContAnt
						//Sair
						Exit
					Endif
				Endif
				cCtContAnt := cNomeArq->CONTA
				
				If lImprime .Or. nSaldoAtu != 0
					If cAuxFoot = "A TRANSPORTAR"
						If nQuebra == 1
							If mv_par03==1
								
								cConta := SA1->A1_CONTA
								F550SA(cCodigo, cNomeArq->LOJA, cCtContAnt, @aSdoContabil, @cNome, @cConta)
							Else
								
								cConta := SA2->A2_CONTA
								F550SA(cCodigo, cNomeArq->LOJA, cCtContAnt, @aSdoContabil, @cNome, @cConta)
							EndIf
							
							If cPaisLoc == 'BRA'
								If mv_par14 == 1   // Analitico
									oReport:PrintText(cCodigo + "-" + cNome)
									dbSelectArea("cNomeArq")
									aSec1[S1_HISTORICO]	:= STR0028 //"DE TRANSPORTE : "
									aSec1[S1_SALDO_ATU]	:= Abs(nSaldoAtu)
									aSec1[S1_DIGITO]	:= Eval(bBlockDC,nSaldoAtu)
									F550Print(oReport,.F.,aSec1)
									oReport:SkipLine()
									aFill(aSec1,nil)
								Endif
							Else  //If cPaisLoc == "ARG"
								If mv_par03 == 1
									SA1->(MsSeek(FWxFilial("SA1")+cCodigo+cNomeArq->LOJA))
								Else
									SA2->(MsSeek(FWxFilial("SA2")+cCodigo+cNomeArq->LOJA))
								EndIf

								If RetGlbLGPD("A1_NOME")
									cTexto := PadR(If(mv_par03==1, Replicate("*", 40 ) , Replicate("*", 40 ) ),50) + ;
												PadR(cCodigo,42) + ;
												PadR(STR0028,24) + ;  //"TRANSPORTAR : "
												Transform(Abs(nSaldoAtu),tm(Abs(nSaldoAtu),14)) + ;
												" " + Eval(bBlockDC,nSaldoAtu)
									oReport:PrintText(cTexto)
								Else
									cTexto := PadR(If(mv_par03==1,Subs(SA1->A1_NOME,1,40),Subs(SA2->A2_NOME,1,40) ),50) + ;
												PadR(cCodigo,42) + ;
												PadR(STR0028,24) + ;  //"TRANSPORTAR : "
												Transform(Abs(nSaldoAtu),tm(Abs(nSaldoAtu),14)) + ;
												" " + Eval(bBlockDC,nSaldoAtu)
									oReport:PrintText(cTexto)
								Endif
									
								cPosTp := aScan(aTipoCli, {|x| Subs(x,1,1) == If(mv_par03==1,SA1->A1_TIPO,SA2->A2_TIPO)})
								cTipoCli := If(cPosTp>0 , aTipoCli[cPosTp] , "")
								
								SX5->( MsSeek(FWxFilial("SX5")+"12"+If(mv_par03==1,SA1->A1_EST,SA2->A2_EST)) )
								
								If mv_par03 == 1 //Carteira (Receber ou Pagar)
									cTexto :=	PadR(SA1->A1_END,50) + ;
													PadR("Te: "+Subs(Alltrim(SA1->A1_TEL),1,36),42) + ;
													PadR(STR0038+SA1->A1_VEND,50) //"VENDEDOR: "
									oReport:PrintText(cTexto)
									
									cTexto := PadR(SA1->A1_CEP + " - " + SA1->A1_MUN,92) 
									If SX5->( Found() ) .or. !Empty(X5Descri())
										cTexto += AllTrim(X5Descri())
									EndIf
									oReport:PrintText(cTexto)
									
									cTexto :=	PadR(cTipoCli,50) + ;
													Trans(SA1->A1_CGC,PesqPict("SA1","A1_CGC"))
									oReport:PrintText(cTexto)
								Else
									cTexto :=	PadR(SA2->A2_END,50) + ;
													PadR("Te: "+ Subs(Alltrim(SA2->A2_TEL),1,36),42) + ;
													STR0039  //"COMPRADOR: "
									oReport:PrintText(cTexto)
									
									cTexto := PadR(SA2->A2_CEP+" - " +SA2->A2_MUN,42) 
									If SX5->( Found() ) .or. !Empty(X5Descri())
										cTexto += AllTrim(X5Descri())
									Endif
									oReport:PrintText(cTexto)
									
									cTexto :=	PadR(cTipoCli,50) + ;
													Trans(SA2->A2_CGC,PesqPict("SA2","A2_CGC"))
								EndIf
							EndIf
							oReport:SkipLine()
						EndIf
						cAuxFoot = "X"
					Endif
				EndIf
				
				If (nQuebra == 0 .and. (lImprime .Or. nSaldoAtu != 0)) .or. lPrintCabec
					nQuebra  := 1
					lImprAnt := .F.
					lPrintCabec := .F.

					IF mv_par03 == 1 
						cConta := SA1->A1_CONTA
						F550SA(cCodigo, cNomeArq->LOJA, cCtContAnt, @aSdoContabil, @cNome, @cConta, aSelFil)
					Else
						cConta := SA2->A2_CONTA
						F550SA(cCodigo, cNomeArq->LOJA, cCtContAnt, @aSdoContabil, @cNome, @cConta, aSelFil)
					EndIF
					
					If cPaisLoc == "BRA"
						If mv_par14 == 1  // Analitico
							oReport:PrintText(cCodigo + "-" + alltrim(cNome))
							dbSelectArea("cNomeArq")
							aSec1[S1_HISTORICO] := STR0016  //"SALDO ANTERIOR : "
							aSec1[S1_SALDO_ATU] := Abs(nSaldoAtu)
							aSec1[S1_DIGITO]:= Eval(bBlockDC,nSaldoAtu)
							F550Print(oReport,.F.,aSec1)
							aFill(aSec1,nil)
							oReport:SkipLine()
							if lPDF
								nLinReport := nLinReport + 2
							EndIf
							
							nSalAntG += nSaldoAtu
						Else
							aSec2[S2_DESCRICAO] := Substr(cCodigo + "-" + cNome,1,64)
							aSec2[S2_SD_ANTERIOR] := Abs(nSaldoAtu)
							aSec2[S2_DIG1] := Eval(bBlockDC,nSaldoAtu)
							nSalAntG += nSaldoAtu
						Endif	
					Else
						
						If mv_par03 == 1 // Carteira (Receber ou Pagar)
							
							SA1->( MsSeek(FWxFilial("SA1")+cCodigo+cNomeArq->LOJA) )
						Else
							
							SA2->( MsSeek(FWxFilial("SA2")+cCodigo+cNomeArq->LOJA) )
						Endif
						
						If RetGlbLGPD("A1_NOME")
							cTexto :=	PadR( If(mv_par03==1, Replicate("*", 40 ) , Replicate("*", 40 )  ),50) + ;
											PadR( cCodigo,42) + ;
											PadR( STR0016,24 ) + ;  //"SALDO ANTERIOR : "
											PadR( Transform(Abs(nSaldoAtu),tm(Abs(nSaldoAtu),14) ),15 ) + ;
											" " + Eval(bBlockDC,nSaldoAtu)
							oReport:PrintText(cTexto)
						Else
							cTexto :=	PadR( If(mv_par03==1,Subs(SA1->A1_NOME,1,40),Subs(SA2->A2_NOME,1,40) ),50) + ;
											PadR( cCodigo,42) + ;
											PadR( STR0016,24 ) + ;  //"SALDO ANTERIOR : "
											PadR( Transform(Abs(nSaldoAtu),tm(Abs(nSaldoAtu),14) ),15 ) + ;
											" " + Eval(bBlockDC,nSaldoAtu)
							oReport:PrintText(cTexto)
						Endif

						oReport:SkipLine()
						nSalAntG += nSaldoAtu
						
						cPosTp := aScan( aTipoCli, {|x| Subs(x,1,1) == Iif(mv_par03==1,SA1->A1_TIPO,SA2->A2_TIPO)  } )
						cTipoCli := Iif( cPosTp>0 , aTipoCli[cPosTp] , "" )
						
						SX5->( MsSeek(xFilial("SX5")+"12"+If(mv_par03==1,SA1->A1_EST,SA2->A2_EST)) )
						
						If mv_par03 == 1 // Carteira (Receber ou Pagar)
							cTexto :=	PadR(SA1->A1_END,50) + ;
											PadR("Te: "+Subs(Alltrim(SA1->A1_TEL),1,36),42) + ;
											STR0038+SA1->A1_VEND  // "VENDEDOR : "
							oReport:PrintText(cTexto)
		
							cTexto :=	PadR(SA1->A1_CEP+" - " +SA1->A1_MUN,92)
							If SX5->( Found() ) .or. !Empty(X5Descri())
								cTexto += AllTrim(X5Descri())   // Diego
							EndIf
							oReport:PrintText(cTexto)
							
							cTexto :=	PadR(cTipoCli,50) + Trans(SA1->A1_CGC,PesqPict("SA1","A1_CGC"))
							oReport:PrintText(cTexto)
							oReport:SkipLine()
						Else
							cTexto :=	PadR(SA2->A2_END,50) + ;
											PadR("Te: "+Subs(Alltrim(SA2->A2_TEL),1,36),42) + ;
											STR0039 // "COMPRADOR: "
							oReport:PrintText(cTexto)
							
							cTexto := PadR(SA2->A2_CEP+" - " +SA2->A2_MUN,92)
							If SX5->( Found() ) .or. !Empty(X5Descri())
								cTexto += AllTrim(X5Descri())
							EndIf
							oReport:PrintText(cTexto)
							
							cTexto :=	PadR(cTipoCli,50) + ;
											Trans(SA2->A2_CGC,PesqPict("SA2","A2_CGC"))
							oReport:PrintText(cTexto)
							oReport:SkipLine()
						EndIf
					EndIf
				EndIf
			
				dbSelectArea("cNomeArq")
				
				If cNomeArq->DATAEM >= mv_par01 .And. !lNoSkip 
					If cNomeArq->DC == "D"
						nSaldoAtu -= ABS(cNomeArq->VALOR)
						nTotDeb   += ABS(cNomeArq->VALOR)
						nTotDebG  += ABS(cNomeArq->VALOR)
						nSalAtuG  -= ABS(cNomeArq->VALOR)
					Else
						nSaldoAtu += ABS(cNomeArq->VALOR)
						nTotCrd   += ABS(cNomeArq->VALOR)
						nTotCrdG  += ABS(cNomeArq->VALOR)
						nSalAtuG  += ABS(cNomeArq->VALOR)
					End
					If mv_par14 == 1  // Analitico
						
						aSec1[S1_DAT] := cNomeArq->DATAEM
						If STR0040 $ cNomeArq->HISTOR  //"Recibo"/"Receipt"
							aSec1[S1_HISTORICO] := If(mv_par24=1,Substr(cNomeArq->HISTOR, At(STR0040,cNomeArq->HISTOR),20),cNomeArq->HISTOR)
						Else
							aSec1[S1_HISTORICO] := If(mv_par24=1,SubStr(cNomeArq->HISTOR,1,20),cNomeArq->HISTOR)
						EndIf
						
						aSec1[S1_PREFIXO] := SubStr(cNomeArq->NUMERO, 1,3)
						aSec1[S1_NUM] := SubStr(cNomeArq->NUMERO, 4,nTamNro)
						aSec1[S1_PARCELA] := SubStr(cNomeArq->NUMERO,nTamNro+4,nTamParc)
						aSec1[S1_TIPO] := SubStr(cNomeArq->NUMERO,nTamNro+nTamParc+4,nTamTipo)
						
						aSec1[S1_EMISSAO] := cNomeArq->EMISSAO
						aSec1[S1_VENCIMENTO] := cNomeArq->VENCTO
						IF !Empty(cNomeArq->BAIXA)
							aSec1[S1_BAIXA] := cNomeArq->BAIXA
						End
						If cNomeArq->DC=="D"
							aSec1[S1_DEBITO] := ABS(cNomeArq->VALOR)
						Else
							aSec1[S1_CREDITO] := ABS(cNomeArq->VALOR)
						EndIf
						aSec1[S1_SALDO_ATU] := Abs(nSaldoAtu)
						aSec1[S1_DIGITO] := Eval(bBlockDC,nSaldoAtu)
						F550Print(oReport,.F.,aSec1)
						aFill(aSec1,nil)
					Endif
				Endif
				lFlag := .T.             
				If ! lNoSkip
					cNomeArq->(dbSkip())
				Endif
				lNoSkip := .f.
			Enddo
		Endif
		
		
		If lImprime .Or. nSaldoAtu != 0 .Or. lPrintTotal
			lPrintTotal := .F.		
			If mv_par14 == 1		// Analitico
				oReport:ThinLine()
				aSec2[S2_DESCRICAO] := STR0017 + If(mv_par03==1,STR0018,STR0019)  //"T o t a i s  d o  "###"C l i e n t e"###"F o r n e c e d o r"
			Endif
			aSec2[S2_DEB] := nTotDeb
			aSec2[S2_CRED] := nTotCrd
			aSec2[S2_SD_ATUAL] := Abs(nSaldoAtu)
			aSec2[S2_DIG2] := If( Int( nSaldoAtu * 100 ) = 0, " ", If(nSaldoAtu > 0, "C", "D")) //Eval(bBlockDC,nSaldoAtu)
			oSection2:PrintLine()
			aFill(aSec2,nil)
			
			If mv_par21 == 1 .And. !Empty(aSdoContabil) // Impr. Saldo Contabil
				// Verifica se deve imprimir o total da conta contabil do fornecedor
				cLoja := ""
				If FR550TotCta(cCtContAnt, cCodigo, cLoja ) .OR. (mv_par25 == 1 .AND. mv_par21 == 1) // Retorna se o saldo deve ser impresso 
					aSec2[S2_DESCRICAO] := STR0046+If(mv_par03==1,STR0018,STR0019) + If(!Empty(cCtContAnt)," ("+AllTrim(cCtContAnt)+") ","") // //"T o t a i s  d o  c o n t a"###"C l i e n t e"###"F o r n e c e d o r"
					aSec2[S2_DEB] := Abs(aSdoContabil[4])
					aSec2[S2_CRED] := Abs(aSdoContabil[5])
					aSec2[S2_SD_ATUAL] := Abs(aSdoContabil[1])
					aSec2[S2_DIG2] := Eval(bBlockDC,aSdoContabil[1])
					oSection2:PrintLine()
					oReport:SkipLine()
					aFill(aSec2,nil)
					if lPDF
						nLinReport := nLinReport + 2
					EndIf
				EndIf
			EndIf

			If mv_par14 == 1 // Anal¡tico/Sint‚tico
				oReport:SkipLine()
			EndIf

			if lPDF // Caso seja PDF o maximo que conseguira ser exportado por pagina são 11 fornecedores
				nLinReport := nLinReport + 2
				nContFor++
				If nContFor >= 10 .and. nLinReport >= nLinPag	
					oReport:EndPage()
					nContFor := 1
					nLinReport := 8
				EndIF
			EndIf

		EndIf	
		nQuebra:=0
	EndDo

	oReport:SetPageFooter(0 ,{||})
	If nQuebra # 0 .and.(lImprime .Or. nSaldoAtu != 0)
		If mv_par14 == 1		// Anal¡tico/Sint‚tico
			aSec2[S2_DESCRICAO] := STR0017+If(mv_par03==1,STR0018,STR0019)  //"T o t a i s  d o  "###"C l i e n t e"###"F o r n e c e d o r"
		Endif
		aSec2[S2_DEB] := nTotDeb
		aSec2[S2_CRED] := nTotCrd
		aSec2[S2_SD_ATUAL] := Abs(nSaldoAtu)
		aSec2[S2_DIG2] := Eval(bBlockDC,nSaldoAtu)
		oSection2:PrintLine()
		aFill(aSec2,nil)
	EndIf

	If lFlag
		oReport:SkipLine()
		oReport:ThinLine()
		nSaldoFinal := (nSalAntG-nTotDebG+nTotCrdG)
		aSec2[S2_DESCRICAO] := STR0020 + If(mv_par03==1,STR0021,STR0022)  //"T o t a l   G e r a l  d o s  "###"C l i e n t e s"###"F o r n e c e d o r e s"
		aSec2[S2_SD_ANTERIOR] := ABS(nSalAntG)
		aSec2[S2_DIG1] := Eval(bBlockDC,nSalAntG)
		aSec2[S2_DEB] := nTotDebG
		aSec2[S2_CRED] := nTotCrdG
		aSec2[S2_SD_ATUAL] := Abs(nSaldoFinal)
		aSec2[S2_DIG2] := Eval(bBlockDC,nSaldoFinal)
		oSection2:PrintLine()
		oReport:SkipLine(2)
		aFill(aSec2,nil)

		nSaldoFinal := (nSalAntG-nTotDebG+nTotCrdG)

		oReport:ThinLine()
		aSec2[S2_DESCRICAO] := 	STR0023  //"S a l d o   F i n a l   d o   R e l a t o r i o : "
		aSec2[S2_SD_ATUAL] := Abs(nSaldoFinal)
		aSec2[S2_DIG2] := Eval(bBlockDC,nSaldoFinal)
		oSection2:PrintLine()
		aFill(aSec2,nil)
	EndIf

	oSection1:Finish()
	oSection2:Finish()

	dbSelectArea("cNomeArq")
	DbCloseArea()

	//Deleta tabela temporária do banco de dados
	If _oFINR5501 <> Nil
		_oFINR5501:Delete()
		_oFINR5501 := Nil
	Endif

	//Apaga a Query da lImprime
	If oPrepared != NIL
		oPrepared:Destroy()
		oPrepared := NIL
	Endif
	//Apaga a Query da lImprime
	If oPreparC != NIL
		oPreparC:Destroy()
		oPreparC := NIL
		__lFilial:= .F.
		__lLoja	 := .F.
	Endif
	//Apaga a Query da lImprime
	If oPreparR != NIL
		oPreparR:Destroy()
		oPreparR := NIL
	Endif
	//Apaga a Query da F550SA
	If oPrepar2 != NIL
		oPrepar2:Destroy()
		oPrepar2 := NIL
	Endif

	dbSelectArea("SA1")
	RetIndex("SA1")
	dbSetOrder(1)
	Set Filter To

	dbSelectArea("SA2")
	RetIndex("SA2")
	dbSetOrder(1)
	Set Filter To

	dbSelectArea("SE1")
	dbCloseArea()
	ChKFile("SE1")
	dbSelectArea("SE1")
	dbSetOrder(1)

	dbSelectArea("SE2")
	dbCloseArea()
	ChKFile("SE2")
	dbSelectArea("SE2")
	dbSetOrder(1)

	dbSelectArea("SE5")
	dbCloseArea()
	ChKFile("SE5")
	dbSelectArea("SE5")
	dbSetOrder(1)

	If !Empty(aTmpFil)		/* GESTAO */
		For nX := 1 To Len(aTmpFil)
			CtbTmpErase(aTmpFil[nX])
		Next
	Endif

	For nI := 1 to Len(aInd)
		If Select(aInd[nI]) # 0
			dbSelectArea(aInd[nI])
			dbCloseArea()
			If File(aInd[nI] + OrdBagExt())
				fErase(aInd[nI] + OrdBagExt())
				fErase(aInd[nI] + GetDbExtension())
			Endif
		Endif
	Next

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³F550RODAPE³ Autor ³ Daniel Tadashi Batori ³ Data ³ 24.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ rotina de impressao dos totais na quebra da pagina R4      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ F551RODAPE                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Localizacoes Paises do ConeSul...                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F550RODAPE(oReport,nSaldoTra,cDigito,aSec1)

Local oSection1 := oReport:Section(1)
/*
GESTAO - inicio */
oReport:PrintText(STR0015,oReport:Row(),oSection1:Cell("E1_VLCRUZ"):ColPos()+1)
oReport:PrintText(Transform(Abs(nSaldoTra),tm(Abs(nSaldoTra),14))+" "+cDigito,oReport:Row(),oSection1:Cell("E1_SALDO"):ColPos()+1)
/* GESTAO - fim */
Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³F550Print ³Autor ³Marcel Borges Ferreira ³ Data ³ 07.11.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao da secao um, respeitando parametro mv_par24     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ F550Print(oReport)                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F550Print(oReport As Object,lQuebra As Logical,aSec1 As Array)
	
    Local oSection1 As Object

    oSection1 := oReport:Section(1)
        
    If mv_par24 == 2 .And. lQuebra

        oSection1:Cell("E1_HIST"):SetSize(20)
        oSection1:Cell("E1_HIST"):Hide()
        oSection1:PrintLine()
        oSection1:Cell("E1_HIST"):SetSize(40)
        oSection1:Cell("E1_HIST"):Show()
        oSection1:Cell("E1_VENCTO"):Hide()
        oSection1:Cell("E1_PREFIXO"):Hide()
        oSection1:Cell("E1_NUM"):Hide()
        oSection1:Cell("E1_PARCELA"):Hide()
        oSection1:Cell("E1_TIPO"):Hide()
        oSection1:Cell("E1_EMISSAO"):Hide()
        oSection1:Cell("E1_VENCREA"):Hide()
        oSection1:Cell("E2_DTFATUR"):Hide()
        oSection1:Cell("E1_VLCRUZ"):Hide()
        oSection1:Cell("E2_VLCRUZ"):Hide()
        oSection1:Cell("E1_SALDO"):Hide()
        oSection1:Cell("DIGITO"):Hide()
        oSection1:PrintLine()
        oSection1:Cell("E1_VENCTO"):Show()
        oSection1:Cell("E1_HIST"):Show()
        oSection1:Cell("E1_PREFIXO"):Show()
        oSection1:Cell("E1_NUM"):Show()
        oSection1:Cell("E1_PARCELA"):Show()
        oSection1:Cell("E1_TIPO"):Show()
        oSection1:Cell("E1_EMISSAO"):Show()
        oSection1:Cell("E1_VENCREA"):Show()
        oSection1:Cell("E2_DTFATUR"):Show()
        oSection1:Cell("E1_VLCRUZ"):Show()
        oSection1:Cell("E2_VLCRUZ"):Show()
        oSection1:Cell("E1_SALDO"):Show()
        oSection1:Cell("DIGITO"):Show()
        oSection1:Cell("E1_HIST"):SetSize(20)

    Else
        If nTamHistor > 25 // para não cortar o campo número do titulo
            oSection1:Cell("E1_HIST"):SetSize(25)
        EndIf	
		If oReport:nDevice == 6 //Se impressao em PDF, redimenciona colunas de data para nao cortar digitos
            oSection1:Cell("E1_VENCTO"):SetSize(15)
            oSection1:Cell("E1_EMISSAO"):SetSize(15)
            oSection1:Cell("E1_VENCREA"):SetSize(15)
            oSection1:Cell("E2_DTFATUR"):SetSize(15)
		EndIf
        // Faz tratamento para celulas com conteudo em branco - impressao em planilha Excel.
        F550ValExcel( oSection1, "E1_VENCTO"	, aSec1[S1_DAT]			, .F. )
        F550ValExcel( oSection1, "E1_EMISSAO"	, aSec1[S1_EMISSAO]		, .F. )
        F550ValExcel( oSection1, "E1_VENCREA"	, aSec1[S1_VENCIMENTO]	, .F. )
        F550ValExcel( oSection1, "E2_DTFATUR"	, aSec1[S1_BAIXA]		, .F. )
        F550ValExcel( oSection1, "E1_VLCRUZ"	, aSec1[S1_DEBITO]		, .F. )
        F550ValExcel( oSection1, "E2_VLCRUZ"	, aSec1[S1_CREDITO]		, .F. )

        oSection1:PrintLine() 

        F550ValExcel( oSection1, "E1_VENCTO"	, aSec1[S1_DAT]			, .T. )
        F550ValExcel( oSection1, "E1_EMISSAO"	, aSec1[S1_EMISSAO]		, .T. )
        F550ValExcel( oSection1, "E1_VENCREA"	, aSec1[S1_VENCIMENTO]	, .T. )
        F550ValExcel( oSection1, "E2_DTFATUR"	, aSec1[S1_BAIXA]		, .T. )
        F550ValExcel( oSection1, "E1_VLCRUZ"	, aSec1[S1_DEBITO]		, .T. )
        F550ValExcel( oSection1, "E2_VLCRUZ"	, aSec1[S1_CREDITO]		, .T. )
        
    EndIf
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  | F550LinPag   ºAutor ³ Marcio Menon	  º Data ³ 30/04/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Faz a quebra de pagina de acordo com o parametro "Linhas   º±±
±±º          ³ por Pagina?" (mv_par23)                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPL1 - Numero maximo de linhas definido no relatorio      º±±
±±º          ³ EXPL2 - Contador de linhas impressas no relatorio          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ nil                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR550                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F550LinPag(nLinPag,nLinReport,oReport,nSaldoTra, lLimpa , lSkip  , nContFor)
Default lLimpa := .F.
Default lSkip := .T.

If lLimpa
	nLinReport := 8
Else
	if lSkip	
		nLinReport++
	EndIF
	If nLinReport >= (nLinPag + 8)
		oReport:EndPage()
		nLinReport := 8
		nContFor := 1
	EndIf
EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ F550ValExcelºAutor ³ Gustavo Henrique º Data ³  31/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Faz tratamento para impressao de celulas tipo data e numeroº±±
±±º          ³ quando selecionada impressao em planilha Excel.            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR550                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F550ValExcel( oSection1, cNomeCel, xConteudo, lShow )

If Empty( xConteudo )
	If lShow
		oSection1:Cell( cNomeCel ):Show()
	Else	
		oSection1:Cell( cNomeCel ):Hide()
	EndIf
EndIf		

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GravaTrab ³ Autor ³ Wagner Xavier         ³ Data ³ 25.02.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Grava um registro no arquivo de trabalho para impressao     ³±±
±±³          ³do Razonete.                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³GravaTrab( ExpC1, ExpD1, ExpD2)                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GravaTrab( cTipo,dEmissao,dVencto,nValor,aDados,aDadosAbat,lPrincipal,lCm,cAliasSE5,lPccBaixa,cAliasSE1, cSTR47U) 
	Local cDCR,cDCP,cAlias:=Alias()
	Local nX := 0
	Local nTamaDados := Len(aDados)
	Local cDC     as character 
	Local cHistor as character 
	Local dBaixa := CtoD('') as date 

	DEFAULT cSTR47U		:= ""
	DEFAULT aDadosAbat	:= {}
	DEFAULT lPrincipal	:= .F.
	DEFAULT lCm			:= .F.
	DEFAULT cAliasSE5	:= "SE5"
	DEFAULT cAliasSE1	:= "SE1"
					
	If aDados[3] >= mv_par01 .OR. mv_par15 == 1
		// Verifica prefixo caso a movimenta‡„o n„o seja interpretada
		// para calculo do saldo anterior ou quando solicitado.
		If Substr(aDados[4],1,3) < mv_par08 .Or. Substr(aDados[4],1,3) > mv_par09
			Return NIL
		EndIf
	Endif

	nValor := Iif(nValor = Nil,aDados[11],nValor )

	cDCR :="D"
	cDCP :="C"

	If (cTipo $ "B#D" .And.  (lCm .Or. nValor >= 0)) .or. (cTipo $ "V" .And. nValor < 0)
		cDCR :="C"
		cDCP :="D"
	EndIf

	cHistor := If( Empty(aDados[7]) .Or.;
				aDados[7] = cSTR47U,;//Upper(STR0047),;  // "Valor recebido s/ Titulo"
				STR0048, aDados[7]) // "Baixa de Titulo"
	dBaixa := aDados[6] 

	If cPaisLoc == "BRA"
		If aDados[8] == "R"				// SE5->E5_RECPAG
			cDC := Iif((!(aDados[9] $ MVRECANT+"/"+MV_CRNEG) .or.;      //TIPO
			aDados[10]=="ES" ) .and. (!(aDados[9] $ MVPAGANT+"/"+MV_CPNEG .and. (cAliasSE5)->E5_MOTBX = "CMP" .and. aDados[10]=="ES")) ;  //Estorno de compensacao do adiantamento
			.and. aDados[11] >= 0 ,cDCR,cDCP)      //TIPODOC  VALOR
		Else
			cDC := Iif((!( aDados[9] $ MVPAGANT+"/"+MV_CPNEG) .or. ;
			aDados[10]=="ES" ) .and. (!( aDados[9] $ MVRECANT+"/"+MV_CRNEG .and. (cAliasSE5)->E5_MOTBX = "CMP" .and. aDados[10]=="ES")) ;   //Estorno de compensacao do adiantamento
			.and. aDados[11] >= 0 ,cDCP,cDCR)
		EndIf   

	Else  //If cPaisLoc == "ARG" // Microsiga Argentina 20/03/99 JLUCAS
		If aDados[8] == "R"
			cDC 	:= Iif( !(aDados[9] $ "RA /"+MV_CRNEG),cDCR,cDCP)
			dBaixa	:= Iif( cAliasSE1 == "SE1", SE1->E1_EMISSAO, (cAliasSE1)->EMISSAO )
		Else
			cDC 	:= Iif( !(aDados[9] $"PA /"+MV_CPNEG),cDCP,cDCR)
			dBaixa:= aDados[6]     //SE5->E5_DATA
		EndIf
	EndIf           

	oBulk:AddData({ aDados[1],;    //- CODIGO
			aDados[2],;            //- LOJA
			aDados[3],;            //- DATAEM
			aDados[4],;            //- NUMERO
			aDados[9],;            //- TIPO
			aDados[5],;            //- BANCO
			dEmissao,;             //- EMISSAO 
			dBaixa,;               //- BAIXA
			dVencto,;              //- VENCTO
			nValor,;               //- VALOR
			cHistor,;              //- HISTOR  
			cDC,;                  //- DC
			0,;                    //- MOEDA 
			aDados[12],;           //- CONTA
			' ',;                  //- PREFIXO 
			' ',;                  //- PARCELA 
			TRBSE5->E5_FILIAL,;    //- FILIAL
			' ',;                  //- FILORI
			aDados[nTamaDados-1]}) //- FILENT

	//Impostos do Brasil
	If cPaisLoc == "BRA"
		If (lPCCBaixa .Or. lIssBaixa) .and. !(cTipo $ 'M|J|D') .and. mv_par03 == 2  .OR. (lRaRtImp .AND. mv_par03 == 1) //Apenas PCC Carteira a Pagar
			//Gera movimentos de histórico em casos de retenção de pis, cofins e csll

			If lPCCBaixa .Or. lRaRtImp
				For nX := 1 To 3
					If (Len(aDados) > 13 .And. (Empty(aDados[12+nX]) .Or. aDados[12+nX] == '7'))
						If Len(aDados) > 13 .and. aDados[15+nX] <> nil .and. aDados[15+nX] > 0
							cHistor := STR0047 + " - " + If(nX=1,"Pis",If(nX=2,"Cofins","Csll")) //Desc.Imposto
							cDC     := IIf(aDados[8]=="R","C","D") //Verifico se o titulo eh a pagar ou a receber

							oBulk:AddData({ aDados[1],;    //- CODIGO
									aDados[2],;            //- LOJA
									aDados[3],;            //- DATAEM
									aDados[4],;            //- NUMERO
									aDados[9],;            //- TIPO
									aDados[5],;            //- BANCO
									dEmissao,;             //- EMISSAO 
									aDados[6],;            //- BAIXA
									dVencto,;              //- VENCTO
									aDados[15+nX],;        //- VALOR
									cHistor,;              //- HISTOR  
									cDC,;                  //- DC
									0,;                    //- MOEDA 
									aDados[12],;           //- CONTA
									' ',;                   //- PREFIXO 
									' ',;                   //- PARCELA 
									TRBSE5->E5_FILIAL,;    //- FILIAL //COMPARTILHAMENTO SE1-SE5 E/OU SE2-SE5 DEVEM SER IGUAIS    
									' ',;                   //- FILORI
									aDados[nTamaDados-1]}) //- FILENT

						Endif
					Endif
				Next
			EndIf
			If lIssBaixa  
				If Valtype (aDados[IIF(lPCCBaixa.Or.lRaRtImp, 19, 13)]) <> 'U' .AND. aDados[IIF(lPCCBaixa.Or.lRaRtImp, 19, 13)]  > 0

					cHistor  := STR0047 + " - Iss" //Desc.Imposto
					cDC      := IIf(aDados[8]=="R","C","D") //Verifico se o titulo eh a pagar ou a receber
					nValor   := aDados[IIF((lPCCBaixa.Or.lRaRtImp) .and. Len(aDados) > 13, 19, 13)]

					oBulk:AddData({ aDados[1],;     //- CODIGO
							aDados[2],;             //- LOJA
							aDados[3],;             //- DATAEM
							aDados[4],;             //- NUMERO
							aDados[9],;             //- TIPO
							aDados[5],;             //- BANCO
							dEmissao,;              //- EMISSAO 
							aDados[6],;             //- BAIXA
							dVencto,;               //- VENCTO
							nValor,;                //- VALOR
							cHistor,;               //- HISTOR  
							cDC,;                   //- DC
							0,;                     //- MOEDA 
							aDados[12],;            //- CONTA
							' ',;                    //- PREFIXO 
							' ',;                    //- PARCELA 
							TRBSE5->E5_FILIAL,;     //- FILIAL //COMPARTILHAMENTO SE1-SE5 E/OU SE2-SE5 DEVEM SER IGUAIS
							' ',;                    //- FILORI
							aDados[nTamaDados-1]})  //- FILENT

				EndIf
			EndIf  
		Endif
		
		//Irrf na Baixa
		If  mv_par03 == 2 .and. !(cTipo $ 'M|J|D') .and. aDados[nTamaDados] > 0
			cHistor  := STR0047 + " - Irrf" //Desc.Imposto
			cDC      := IIf(aDados[8]=="R","C","D") //Verifico se o titulo eh a pagar ou a receber
			nValor   := aDados[nTamaDados]
			oBulk:AddData({ aDados[1],;     //- CODIGO
					aDados[2],;             //- LOJA
					aDados[3],;             //- DATAEM
					aDados[4],;             //- NUMERO
					aDados[9],;             //- TIPO
					aDados[5],;             //- BANCO
					dEmissao,;              //- EMISSAO 
					aDados[6],;             //- BAIXA
					dVencto,;               //- VENCTO
					nValor,;                //- VALOR
					cHistor,;               //- HISTOR  
					cDC,;                   //- DC
					0,;                     //- MOEDA 
					aDados[12],;            //- CONTA
					' ',;                    //- PREFIXO 
					' ',;                    //- PARCELA 
					TRBSE5->E5_FILIAL,;     //- FILIAL //COMPARTILHAMENTO SE1-SE5 E/OU SE2-SE5 DEVEM SER IGUAIS
					' ',;                    //- FILORI
					aDados[nTamaDados-1]})  //- FILENT
		EndIf
	EndIf

	dbSelectArea(cAlias)

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ SdoContab³ Autor ³ Claudio D. de Souza   ³ Data ³ 25.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcular o saldo contabil CTB ou SIGACON              	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_SdoContabil(cConta,dData,cMoeda,cTpSald) 					     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function SdoContabil(cConta,dData,cMoeda,cTpSald,aSelFil)
Local aRet := {0,0,0,0,0,0,0,0}
Local aSavArea := GetArea()

DEFAULT cMoeda  := "01"
DEFAULT cTpSald := "1"
DEFAULT aSelFil := {}

If Val(cMoeda) == 0
	cMoeda := "01"
Endif

aRet := SaldoCQFil("CT1",cConta,/*cCCusto*/,/*cItem*/,/*cClasse*/,/*cIdent*/,dData,cMoeda,cTpSald,/*cRotina*/,/*lImpAntLP*/,/*dDataLP*/,aSelFil,/*lTodasFil*/)

RestArea(aSavArea)
aSize(aSavArea,0)
aSavArea := nil 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorno:                                             ³
//³ [1] Saldo Atual (com sinal)                          ³
//³ [2] Debito na Data                                   ³
//³ [3] Credito na Data                                  ³
//³ [4] Saldo Atual Devedor                              ³
//³ [5] Saldo Atual Credor                               ³
//³ [6] Saldo Anterior (com sinal)                       ³
//³ [7] Saldo Anterior Devedor                           ³
//³ [8] Saldo Anterior Credor                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//      [1]       [2]     [3]      [4]     [5]     [6]       [7]     [8]
Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FR550VldVar º Autor ³ Andrea Verissimo º Data ³  23/02/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Valida variaveis globais criadas pelo sistema              º±±
±±º          ³ cliente/fornecedor.                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Conteudo da variavel que vai ser utilizada no SQL  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro - Relatorio de Razonete                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR550VldVar( cTexto )
     
Local cRet			:= ""
Local nA				:=	0

If Len(cTexto) > 0 
	cRet	:=	"'"	// Inserindo aspas e virgulas para o select da query.
	For nA:=1 To Len(cTexto)
		If Subst(cTexto,nA,1) $ ";,-_|./" 				 
			cRet+="','"
		Else
			cRet+=Subst(cTexto,nA,1)  
		Endif
	Next nA
	cRet	:=	Alltrim(cRet)
	cRet	+=	"'"	
Endif

Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FR550TotCta º Autor ³ Gustavo Henrique º Data ³  23/10/09  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Define se deve imprimir o total da conta contabil do       º±±
±±º          ³ cliente/fornecedor.                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Codigo da conta contabil                           º±±
±±º          ³ EXPC2 - Codigo do cliente/fornecedor                       º±±
±±º          ³ EXPC3 - Codigo da loja                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro - Relatorio de Razonete                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR550TotCta( cConta, cCliFor, cLoja )
     
Local aArea			:= GetArea()
Local aAreaSA1		
Local aAreaSA2	 	
Local lRet			:= .T.

If mv_par03 == 1
	aAreaSA1 := SA1->( GetArea() )
	SA1->( dbSetOrder( 1 ) )
	SA1->( MsSeek( FWxFilial("SA1") + cNomeArq->CODIGO + cNomeArq->LOJA ) )
    // Se final de arquivo deve imprimir o total da conta, pois eh o ultimo cliente
	If cNomeArq->( !EoF() ) 
		// Imprime total por conta se mudou o cliente
		lRet := ( cNomeArq->CODIGO != cCliFor )
		If !lRet      
			If mv_par25 == 2
				// Se for o mesmo cliente e mudou a loja diferente e for uma nova conta contabil,
				// imprime o total, caso contrario nao imprime, retorna falso.
				lRet := (	cNomeArq->CODIGO == cCliFor	.And.;
							cNomeArq->LOJA	 != cLoja	.And.;
							cConta			 != SA1->A1_CONTA )
			Else 
				// Se for o mesmo cliente e for uma nova conta contabil,
				// imprime o total, caso contrario nao imprime, retorna falso.
				lRet := (	cNomeArq->CODIGO == cCliFor	.And.;
							cConta			 != SA1->A1_CONTA )			
			Endif
		EndIf
	EndIf				
	RestArea( aAreaSA1 )
	aSize(aAreaSA1,0)
	aAreaSA1 := nil 
Else
	aAreaSA2 := SA2->( GetArea() )
	SA2->( dbSetOrder( 1 ) )
	SA2->( MsSeek( FWxFilial("SA2") + cNomeArq->CODIGO + cNomeArq->LOJA ) )
    // Se final de arquivo deve imprimir o total por conta, pois eh o ultimo fornecedor
	If cNomeArq->( !EoF() )
		// Imprime total por conta se mudou o fornecedor
		lRet := ( cNomeArq->CODIGO != cCliFor )
		If !lRet
			If mv_par25 == 2
				// Se for o mesmo fornecedor e mudou a loja e for uma nova conta contabil, 
				// imprime o total, caso contrario nao imprime, retorna falso.
				lRet := (	cNomeArq->CODIGO == cCliFor	.And.;
							cNomeArq->LOJA	 != cLoja	.And.;
							cConta 			 != SA2->A2_CONTA )
			Else 
				// Se for o mesmo fornecedor e for uma nova conta contabil, 
				// imprime o total, caso contrario nao imprime, retorna falso.
				lRet := (	cNomeArq->CODIGO == cCliFor	.And.;
							cConta 			 != SA2->A2_CONTA )			
			Endif
		EndIf
	EndIf
	RestArea( aAreaSA2 )
	aSize(aAreaSA2,0)
	aAreaSA2 := nil 
EndIf
RestArea( aArea )
aSize(aArea,0)
aArea := nil 

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FR550RetCF  º Autor ³Pablo S.G.Carrerasº Data ³  10/12/09  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Retorna campos desejados do SA1 e SA2 para consultas sem   º±±
±±º          ³ o emprego da filial                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Codigo da conta contabil                           º±±
±±º          ³ EXPC2 - Codigo do cliente/fornecedor                       º±±
±±º          ³ EXPC3 - Codigo da loja                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro - Relatorio de Razonete                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function FR550RetCF(cCod, cLoja, cCMP)

Local aArea		:= Array(0)
Local aAreaCF	:= Array(0)
Local cRet		:= ""

aArea := GetArea()
If mv_par03 == 1	//Cliente
	aAreaCF := SA1->(GetArea())
	SA1->(dbSetOrder(1))
	If SA1->(MsSeek(FWxFilial("SA1")+cCod + cLoja))
		cRet := SA1->(&cCMP)
	Endif
Else	//Fornecedor
	aAreaCF := SA2->(GetArea())
	SA2->(dbSetOrder(1))
	If SA2->(MsSeek(FWxFilial("SA2")+cCod + cLoja))
		cRet := SA2->(&cCMP)
	Endif
Endif

RestArea(aAreaCF)
aSize(aAreaCF,0)
aAreaCF := nil 
RestArea(aArea)
aSize(aArea,0)
aArea := nil 

Return (cRet)

//-----------------------------------------------------------
/*/{Protheus.doc} FR550VldAgCF
Valida a selecao para aglutinacao de lojas de cliente/fornecedor.

@Sample	U_FR550VldAgCF(nOpc)
@Param		nOpc - opção escolhida na tela de parametros
@Return	Nil
@author	Pablo S.G.Carreras
@since		11/12/09
@version	P12.1.7
/*/
//-----------------------------------------------------------

User Function FR550VldAgCF(nOpc)

If mv_par18 == 1 .AND. mv_par25 == 1
	Do Case
		Case nOpc == 1		//mv_par18
			mv_par18 := 2
			MsgAlert(STR0076)// "A aglutinação de lojas não funciona com o filtro de contas contábeis. Filtro desativado!"
		Otherwise
			mv_par25 := 2
			MsgAlert(STR0077)//"A aglutinação de lojas não funciona com o filtro de contas contábeis. Aglutinação desativada!"
	EndCase
Endif

Return Nil

//-----------------------------------------------------------
/*/{Protheus.doc} F550SA
Carrega os dados da SA1 ou SA2 para imprimir na tela TopConnect

@Param		cCodigo - Código do fornecedor
@Param		LOJA - Código da Loja
@Param		cCtContAnt - código da conta contabil
@Param		aSdoContabil - array com o saldo contabil
@Param		cNome - 
@Param		cConta - 
@Return	Nil
@author	Rodrigo Oliveira
@since		13/03/14
@version	P12.1.7
/*/
//-----------------------------------------------------------

Static Function F550SA(cCodigo, LOJA, cCtContAnt, aSdoContabil, cNome, cConta, aSelFil)

Local cAliasTmp 		:= ""
Local cQry				:= ""

Default aSelFil := {}

If mv_par03 == 1
	If oPrepar2 == NIL

		If mv_par21 == 1
			
		If mv_par10 == 1
				cQry := "SELECT A1_FILIAL, A1_COD, A1_LOJA, A1_NOME, A1_CGC, A1_CONTA " 
				cQry +=  " FROM " + RetSqlName("SA1") + " SA1 "
				cQry +=  " WHERE "
				cQry +=  " SA1.A1_FILIAL = ? AND "
				cQry +=  " SA1.A1_COD = ? " 
				cQry +=  " AND SA1.A1_LOJA = ? " 
				cQry +=  " AND SA1.A1_CONTA = ? "
				cQry +=  " AND SA1.D_E_L_E_T_ = ' ' "
				cQry +=  " ORDER BY SA1.A1_FILIAL, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_CONTA "
			Else
				cQry := "SELECT A1_FILIAL, A1_COD, A1_LOJA, A1_NOME, A1_CGC, A1_CONTA " 
				cQry +=  " FROM " + RetSqlName("SA1") + " SA1 "
				cQry +=  " WHERE "
				cQry +=  " SA1.A1_COD = ? " 
				cQry +=  " AND SA1.A1_LOJA = ? " 
				cQry +=  " AND SA1.A1_CONTA = ? "
				cQry +=  " AND SA1.D_E_L_E_T_ = ' ' "
				cQry +=  " ORDER BY SA1.A1_FILIAL, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_CONTA "
			EndIf
		Else
			If mv_par10 == 1
				cQry := "SELECT A1_FILIAL, A1_COD, A1_LOJA, A1_NOME, A1_CGC, A1_CONTA "
				cQry +=  " FROM " + RetSqlName("SA1") + " SA1 "
				cQry +=  " WHERE "
				cQry +=  " SA1.A1_FILIAL = ? AND "
				cQry +=  " SA1.A1_COD = ? "
				cQry +=  " AND SA1.D_E_L_E_T_ = ' ' "
				cQry +=  " ORDER BY SA1.A1_FILIAL, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_CONTA "
			Else
				cQry := "SELECT A1_FILIAL, A1_COD, A1_LOJA, A1_NOME, A1_CGC, A1_CONTA "
				cQry +=  " FROM " + RetSqlName("SA1") + " SA1 "
				cQry +=  " WHERE "
				cQry +=  " SA1.A1_COD = ? "
				cQry +=  " AND SA1.D_E_L_E_T_ = ' ' "
				cQry +=  " ORDER BY SA1.A1_FILIAL, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_CONTA "
			EndIf
		EndIf
		
		cQry 	:= ChangeQuery(cQry)
		oPrepar2:= FWPreparedStatement():New(cQry)
	EndIf
	
	If mv_par21 == 1
		If mv_par10 == 1
			oPrepar2:SetString( 1, xFilial("SA1")	)
			oPrepar2:SetString( 2, cCodigo			)
			oPrepar2:SetString( 3, LOJA				)
			oPrepar2:SetString( 4, cCtContAnt		)
		Else
			oPrepar2:SetString( 1, cCodigo			)
			oPrepar2:SetString( 2, LOJA				)
			oPrepar2:SetString( 3, cCtContAnt		)
		EndIf
	Else
		If mv_par10 == 1
			oPrepar2:SetString( 1, xFilial("SA1")	)
			oPrepar2:SetString( 2, cCodigo			)
		Else
			oPrepar2:SetString( 1, cCodigo			)
		EndIf
	EndIf
	
	cQry		:= oPrepar2:GetFixQuery()
	cAliasTmp	:= MpSysOpenQuery(cQry)
	
	If mv_par21 == 1
		If mv_par14 == 1  // Analitico
			If RetGlbLGPD("A1_NOME")
				cNome := Replicate("*", nTamA1Nome) + " " + Replicate("*", nTamA1CGC) + " " + cCtContAnt
			Else
				cNome := alltrim((cAliasTmp)->A1_NOME) + " " + (cAliasTmp)->A1_CGC + " " + cCtContAnt
			Endif
		Else
			If RetGlbLGPD("A1_NOME")
				cNome := Replicate("*", 33) + " " + If( mv_par18 == 1, cCtContAnt, Replicate("*", nTamA1CGC ))
			Else
				cNome := Substr((cAliasTmp)->A1_NOME,1,33) + " " + If( mv_par18 == 1, cCtContAnt, (cAliasTmp)->A1_CGC )
			Endif
		EndIf
	Else 
		If mv_par14 == 1  // Analitico
			If RetGlbLGPD("A1_NOME")
				cNome := Replicate("*", nTamA1Nome) + " " + Replicate("*", nTamA1CGC) 
			Else
				cNome := alltrim((cAliasTmp)->A1_NOME) + " " + (cAliasTmp)->A1_CGC
			Endif
		Else
			If RetGlbLGPD("A1_NOME")
				cNome := Replicate("*", 33) + " " + Replicate("*", nTamA1CGC) 
			Else
				cNome := Substr((cAliasTmp)->A1_NOME,1,33) + " " + (cAliasTmp)->A1_CGC
			Endif
		EndIf
	EndIf

	cConta := (cAliasTmp)->A1_CONTA
	If mv_par21 == 1 .And. Empty(aSdoContabil) .And. !Empty(cCtContAnt)
		// Obtem o saldo da conta do fornecedor
		aSdoContabil := U_SdoContabil(cCtContAnt,MV_PAR02,"01","1",aSelFil)	
	EndIf
	(cAliasTmp)->( DbCloseArea() )	
Else
	
	If oPrepar2 == NIL

		If mv_par21 == 1
			
			If mv_par10 == 1
				cQry := "SELECT A2_FILIAL, A2_COD, A2_LOJA, A2_NOME, A2_CGC, A2_CONTA " 
				cQry +=  " FROM " + RetSqlName("SA2") + " SA2 "
				cQry +=  " WHERE "
				cQry +=  " SA2.A2_FILIAL = ? AND "
				cQry +=  " SA2.A2_COD = ? " 
				cQry +=  " AND SA2.A2_LOJA = ? " 
				cQry +=  " AND SA2.A2_CONTA = ? "
				cQry +=  " AND SA2.D_E_L_E_T_ = ' ' "
				cQry +=  " ORDER BY SA2.A2_FILIAL, SA2.A2_COD, SA2.A2_LOJA, SA2.A2_CONTA "
			Else
				cQry := "SELECT A2_FILIAL, A2_COD, A2_LOJA, A2_NOME, A2_CGC, A2_CONTA " 
				cQry +=  " FROM " + RetSqlName("SA2") + " SA2 "
				cQry +=  " WHERE "
				cQry +=  " SA2.A2_COD = ? " 
				cQry +=  " AND SA2.A2_LOJA = ? " 
				cQry +=  " AND SA2.A2_CONTA = ? "
				cQry +=  " AND SA2.D_E_L_E_T_ = ' ' "
				cQry +=  " ORDER BY SA2.A2_FILIAL, SA2.A2_COD, SA2.A2_LOJA, SA2.A2_CONTA "
			EndIf
			
		Else
			If mv_par10 == 1
				cQry := "SELECT A2_FILIAL, A2_COD, A2_LOJA, A2_NOME, A2_CGC, A2_CONTA "
				cQry +=  " FROM " + RetSqlName("SA2") + " SA2 "
				cQry +=  " WHERE "
				cQry +=  " SA2.A2_FILIAL = ? AND "
				cQry +=  " SA2.A2_COD = ? "
				cQry +=  " AND SA2.D_E_L_E_T_ = ' ' "
				cQry +=  " ORDER BY SA2.A2_FILIAL, SA2.A2_COD, SA2.A2_LOJA, SA2.A2_CONTA "
			Else
				cQry := "SELECT A2_FILIAL, A2_COD, A2_LOJA, A2_NOME, A2_CGC, A2_CONTA "
				cQry +=  " FROM " + RetSqlName("SA2") + " SA2 "
				cQry +=  " WHERE "
				cQry +=  " SA2.A2_COD = ? "
				cQry +=  " AND SA2.D_E_L_E_T_ = ' ' "
				cQry +=  " ORDER BY SA2.A2_FILIAL, SA2.A2_COD, SA2.A2_LOJA, SA2.A2_CONTA "
			EndIf
		EndIf
		
		cQry 	:= ChangeQuery(cQry)
		oPrepar2:= FWPreparedStatement():New(cQry)
	EndIf
	
	If mv_par21 == 1
		If mv_par10 == 1
			oPrepar2:SetString( 1, xFilial("SA2")	)
			oPrepar2:SetString( 2, cCodigo			)
			oPrepar2:SetString( 3, LOJA			)
			oPrepar2:SetString( 4, cCtContAnt		)
		Else
			oPrepar2:SetString( 1, cCodigo			)
			oPrepar2:SetString( 2, LOJA			)
			oPrepar2:SetString( 3, cCtContAnt		)
		EndIf
	Else
		If mv_par10 == 1
			oPrepar2:SetString( 1, xFilial("SA2")	)
			oPrepar2:SetString( 2, cCodigo			)
		Else
			oPrepar2:SetString( 1, cCodigo			)
		EndIf
	EndIf
	
	cQry		:= oPrepar2:GetFixQuery()
	cAliasTmp	:= MpSysOpenQuery(cQry)
												
	If mv_par21 == 1
		If mv_par14 == 1  // Analitico
			If RetGlbLGPD("A2_NOME")
				cNome := Replicate("*", nTamA2Nome) +" "+ Replicate("*", nTamA2CGC)  +" "+cCtContAnt
			Else
				cNome := alltrim((cAliasTmp)->A2_NOME)+" "+(cAliasTmp)->A2_CGC+" "+cCtContAnt
			Endif
		Else
			If RetGlbLGPD("A2_NOME")
				cNome := Replicate("*", 33 ) +" "+ IIF(mv_par18 == 1,cCtContAnt, Replicate("*", nTamA2CGC) )
			Else
				cNome := Substr((cAliasTmp)->A2_NOME,1,33)+" "+IIF(mv_par18 == 1,cCtContAnt,(cAliasTmp)->A2_CGC)
			Endif
		EndIf
	Else 
		If mv_par14 == 1  // Analitico
			If RetGlbLGPD("A2_NOME")
				cNome := Replicate("*", nTamA2Nome) +" "+ Replicate("*", nTamA2CGC)
			Else
				cNome := alltrim((cAliasTmp)->A2_NOME)+" "+(cAliasTmp)->A2_CGC
			Endif
		Else
			If RetGlbLGPD("A2_NOME")
				cNome := Replicate("*", 33 ) +" "+ Replicate("*", nTamA2CGC)
			Else
				cNome := Substr((cAliasTmp)->A2_NOME,1,33) +" "+ (cAliasTmp)->A2_CGC
			Endif
		EndIf
	EndIf
	
	cConta := (cAliasTmp)->A2_CONTA
	
	If mv_par21 == 1 .And. Empty(aSdoContabil) .And. !Empty(cCtContAnt)
		// Obtem o saldo da conta do fornecedor
		aSdoContabil := U_SdoContabil(cCtContAnt,MV_PAR02,"01","1",aSelFil)	
	EndIf
	
	(cAliasTmp)->( DbCloseArea() )	
EndIf

Return Nil

//-----------------------------------------------------------
/*/{Protheus.doc} F550Impr
Função para verificar se existem registros de acorodo com o 
código de fornecedor e loja passados via parâmetro

@Param		cTable - Tabela na qual deve ocorrer a pesquisa
@Param		cCodigo - Código do fornecedor
@Param		cLoja - Código da Loja
@Return	lRet - .T. se existir registros
@author	Mauricio Pequim Jr
@since		02/02/2017
@version	P12.1.7
/*/
//-----------------------------------------------------------

Static Function F550Impr(cTable,cCodigo,cLoja)

Local cQuery	:= ""
Local lRet		:= .F.

DEFAULT cTable	:= ""
DEFAULT cCodigo := ""
DEFAULT cLoja	:= ""

If !Empty(cCodigo)

	If oPrepared == nil

		cQuery 	:= "SELECT COUNT (NUMERO) QTDE FROM "+ cTable +" "
		cQuery 	+= "WHERE CODIGO = ? AND"
		cQuery 	+= " LOJA = ? AND"
		cQuery 	+= " DATAEM <= ?"

		cQuery 	:= ChangeQuery(cQuery)
		oPrepared:=FWPreparedStatement():New(cQuery)
	Endif

	oPrepared:SetString(1,cCodigo)
	oPrepared:SetString(2,cLoja)
	oPrepared:SetString(3,DTOS(mv_par01))
	
	cQuery := oPrepared:GetFixQuery()

	lRet := !Empty(MpSysExecScalar(cQuery,"QTDE"))

Endif

Return lRet

//-----------------------------------------------------------
/*/{Protheus.doc} F550CalSld
função para calculo do saldo anterior e primeiro registro 
que atenda a impressão (data emissão >= mv_par01)

@Param cTable Alias da tabela temporaria do banco de dados
@Param cCodigo Codigo do fornecedor
@Param cLoja Loja do Fornecedor
@Param nRecno R_E_C_N_O_ do registro na tabela Fisica
@Param lNoSkip Define se ira pular o registro ou nao
@Param lAglutina Se as lojas do fornecedor serão aglutinadas mv_par25 = 1
@Param cFilTemp Filial que sera considerada para o calculo do saldo anterior

@author Mauricio Pequim Jr
@since 02/02/2017
@version P12.1.7
/*/
//-----------------------------------------------------------

Static Function F550CalSld(cTable,cCodigo,cLoja,nRecno,lNoSkip,lAglutina, cFilTemp)	
	Local nSaldo := 0

	DEFAULT cTable 		:= ""
	DEFAULT cCodigo 	:= ""
	DEFAULT cLoja 		:= ""
	DEFAULT nRecno 		:= 0
	DEFAULT lNoSkip 	:= .T.
	DEFAULT lAglutina	:= .F.
	DEFAULT cFilTemp	:= ""

	nSaldo := F550SldC(cTable,cCodigo,cLoja,"C",lAglutina,cFilTemp)	//Saldo anterior Credito
	nSaldo -= F550SldC(cTable,cCodigo,cLoja,"D",lAglutina,cFilTemp)	//Saldo anterior Débito
	nRecno := F550Recno(cTable,cCodigo,cLoja,lAglutina)		//Numero de Registros selecionados no Periodo estipulado

Return nSaldo

//-----------------------------------------------------------
/*/{Protheus.doc} F550SldC
Função para calculo do saldo anterior

@Param cTable Alias da tabela temporaria do banco de dados
@Param cCodigo Codigo do fornecedor
@Param cLoja Loja do Fornecedor
@Param cDC Tipo de registro DEBITO ou CREDITO
@Param lAglutina Se as lojas do fornecedor serão aglutinadas mv_par25 = 1
@Param cFilTemp Filial que sera considerada para o calculo do saldo anterior

@author Mauricio Pequim Jr
@since 02/02/2017
@version P12.1.7
/*/
//-----------------------------------------------------------
Static Function F550SldC(cTable,cCodigo,cLoja,cDC,lAglutina,cFilTemp)
	Local cQuery	 := ""
	Local nValor	 := 0
	Local nPos       := 1

	DEFAULT cTable		:= ""
	DEFAULT cCodigo 	:= ""
	DEFAULT cLoja		:= ""
	DEFAULT	lAglutina	:= .F.
	DEFAULT cFilTemp	:= ""

	If !Empty(cCodigo)

		If oPreparC == nil
			cQuery 	:= "SELECT SUM(ABS(VALOR)) VLRX FROM "+ cTable +" "
			cQuery 	+= "WHERE CODIGO = ? AND"

			If !lAglutina
				cQuery 	+= " LOJA = ? AND"
				__lLoja := .T.
			Endif

			If !Empty(cFilTemp)	
				cQuery  += " FILENT = ? AND"
				__lFilial := .T.
			Endif

			cQuery 	+= " DATAEM < ? AND "
			cQuery 	+= " DC = ? "


			cQuery 	:= ChangeQuery(cQuery)
			oPreparC:= FWPreparedStatement():New(cQuery)
		Endif

		oPreparC:SetString(nPos,cCodigo)
		nPos ++
		If !lAglutina
			oPreparC:SetString(nPos,cLoja)
			nPos++
		EndIf 
		If !Empty(cFilTemp)	
			oPreparC:SetString(nPos,cFilTemp)
			nPos++
		EndIf 
		oPreparC:SetString(nPos,DTOS(MV_PAR01))
		nPos++

		oPreparC:SetString(nPos,cDC)

		cQuery := oPreparC:GetFixQuery()

		nValor := ABS(MpSysExecScalar(cQuery,"VLRX"))

		If ValType(nValor) != "N" 
			nValor := 0
		EndIf

	Endif

Return nValor

//-----------------------------------------------------------
/*/{Protheus.doc} F550Recno
//função para retorno do recno para posicionamento do TRB
da impressão do relatório que atenda o requisito para
imprimir a linha

@Param cTable Alias da tabela temporaria do banco de dados
@Param cCodigo Codigo do fornecedor
@Param cLoja Loja do Fornecedor
@Param lAglutina Se as lojas do fornecedor serão aglutinadas mv_par25 = 1

@author Mauricio Pequim Jr
@since 02/02/2017
@version P12.1.7
/*/
//-----------------------------------------------------------

Static Function F550Recno(cTable,cCodigo,cLoja,lAglutina)
	Local cQuery	 := ""
	Local nFirstRec  := 0
	Local cSelect    := ""
	Local cQueryPart := ""
	Local nPos       := 1 as numeric 

	DEFAULT cTable		:= ""
	DEFAULT cCodigo 	:= ""
	DEFAULT cLoja		:= ""
	DEFAULT lAglutina	:= .F.

	If !Empty(cCodigo)

		cSelect := " R_E_C_N_O_ NREGX "
		If oPreparR == nil
			cQueryPart 	:= " FROM "+ cTable
			cQueryPart 	+= " WHERE CODIGO = ? AND"
			If !lAglutina
				cQueryPart 	+= " LOJA = ? AND"
			Endif	
			cQueryPart 	+= " DATAEM >= ? "

			If cDBMS == 'DB2'
				cQuery := "SELECT "+ cSelect + cQueryPart + " FETCH FIRST 1 ROWS ONLY"
			ElseIf cDBMS == 'INFORMIX'
				cQuery := "SELECT FIRST 1 " + cSelect + cQueryPart
			ElseIf cDBMS == 'ORACLE'
				cQuery := "SELECT "+ cSelect + cQueryPart + " AND ROWNUM < 2"
			ElseIf cDBMS == 'MYSQL'
				cQuery := "SELECT "+ cSelect + cQueryPart + " AND LIMIT 1"
			ElseIf cDBMS == 'POSTGRES'
				cQuery := "SELECT "+ cSelect + cQueryPart + " LIMIT 1"
			Else
				cQuery := "SELECT TOP 1 " + cSelect + cQueryPart
			EndIf
			cQuery := ChangeQuery(cQuery)
			oPreparR:=FWPreparedStatement():New(cQuery)
		Endif

		oPreparR:SetString(nPos,cCodigo)
		nPos++
		If !lAglutina
			oPreparR:SetString(nPos,cLoja)
			nPos ++ 
		Endif	
		oPreparR:SetString(nPos,DTOS(MV_PAR01))
		cQuery := oPreparR:GetFixQuery()

		nFirstRec := MpSysExecScalar(cQuery,"NREGX")

	Endif

Return nFirstRec

//-----------------------------------------------------------
/*/{Protheus.doc} F550Impr
Função para verificar se existem registros de acorodo com o 
código de fornecedor e loja passados via parâmetro

@Param		cTable - Tabela na qual deve ocorrer a pesquisa
@Param		cCodigo - Código do fornecedor
@Param		cLoja - Código da Loja
@Return	lRet - .T. se existir registros
@author	Mauricio Pequim Jr
@since		02/02/2017
@version	P12.1.7
/*/
//-----------------------------------------------------------

Static Function F550RImpr( cTable, cCodigo, nRecno )

Local cQuery	:= ""
Local lRet		:= .F.

DEFAULT cTable	:= ""
DEFAULT cCodigo := ""
DEFAULT nRecno	:= 1

If !Empty(cCodigo)
	
	If oPrepared == NIL
		
		cQuery 	:= "SELECT COUNT (NUMERO) QTDE FROM "+ cTable +" "
		cQuery 	+= "WHERE CODIGO = ? AND "
		cQuery 	+= " DATAEM <= ? AND "
		cQuery 	+= " R_E_C_N_O_ >= ? "
		
		cQuery 	:= ChangeQuery(cQuery)
		oPrepared := FWPreparedStatement():New(cQuery)
	Endif
	
	oPrepared:SetString( 1, cCodigo			)
	oPrepared:SetString( 2, DTOS(MV_PAR01)	)
	oPrepared:SetNumeric( 3, nRecno	)
	
	cQuery:=oPrepared:GetFixQuery()
	
	lRet := !Empty(MpSysExecScalar(cQuery,"QTDE"))
	
EndIf

Return lRet

//-----------------------------------------------------------
/*/{Protheus.doc} RetAbatCr
Retorna os abatimentos do titulo a receber

@Param aDadosAbat - Array contendo os titulos com abatimento
@Param cCliente   - Código do cliente
@Param cLoja      - Código da Loja
@Param cPrefixo   - Prefixo do titulo
@Param cNumTit    - Numero do titulo
@Param cParc      - Parcela do titulo

@Return	nTotAbat  - Valor total de abatimento do titulo

@author	fabio.casagrande
@since		25/11/2021
@version	P12.1.33
/*/
//-----------------------------------------------------------

Static Function RetAbatCr(aDadosAbat As Array,cCliente As Char, cLoja As Char, cPrefixo As Char, cNumTit As Char, cParc As Char) As Numeric

	Local nTotAbat := 0
	Local nPos     := 0
	Local nY       := 0

	default aDadosAbat := {}
	default cCliente   := ""
	default cLoja      := ""
	default cPrefixo   := ""
	default cNumTit    := ""
	default cParc      := ""

	nPos := Ascan(aDadosAbat, { |x| x[1] + x[2] + x[4] == cCliente + cLoja + cPrefixo + cNumTit + cParc } )
	If nPos > 0
		For nY:=nPos to Len(aDadosAbat) 
			If aDadosAbat[nY][1]+aDadosAbat[nY][2]+aDadosAbat[nY][4] == cCliente+cLoja+cPrefixo+cNumTit+cParc
				nTotAbat += aDadosAbat[nY][8]
			Else
				Exit					
			Endif
		Next
	Endif	 	

Return nTotAbat

//-----------------------------------------------------------
/*/{Protheus.doc} TitDestAbt
Verifica se o título destino tem abatimentos.

@Param cChave	  - Chave da Nota fiscal
@Param cFilOrig   - Filial origem
@Param dDtDigit   - Data de Digitação
@Param cNumLiq    - Número da Liquidação

@Return	lRet  	  - Retorna se o título destino tem abatimento

@author	simone.mie
@since		24/10/2023

/*/
//-----------------------------------------------------------
Static Function TitDestAbt(cChave As Char , cFilOrig As Char, dDtDigit As Date, cNumLiq As Char ) As Logical

	Local aArea		As Array 
	
	Local cIdDoc 	As Character
	Local cQuery 	As Character
	Local nAbatFO1 	As Numeric	

	Default cChave 		:= ""
	Default cFilOrig	:= cFilAnt	
	Default dDtDigit	:= dDataBase
	Default cNumLiq		:= ""

	aArea		:= GetArea()
	nAbatFO1	:= 0 
	cQuery 		:= ""
	cIdDoc 		:= FinBuscaFK7( cChave, "SE1", cFilOrig )

	If __oObjFO1 == Nil
		cQuery := " SELECT FO1_VLABT  FROM ? FO1 "
		cQuery += " INNER JOIN ? FO0 ON FO0.FO0_FILIAL = FO1.FO1_FILIAL AND FO1.FO1_PROCES = FO0.FO0_PROCES AND FO1.FO1_VERSAO = FO0.FO0_VERSAO AND FO0.D_E_L_E_T_ = ' ' "
		cQuery += " AND FO0.FO0_NUMLIQ <> '' AND FO0_NUMLIQ =  ? "
		cQuery += " AND FO0.FO0_DATA = ?"
		cQuery += " WHERE FO1.FO1_FILIAL = ? AND FO1.FO1_IDDOC = ? AND FO1.D_E_L_E_T_ = ' ' "            
		cQuery := ChangeQuery(cQuery)
		__oObjFO1 := FWPreparedStatement():New(cQuery)        
	EndIf

	__oObjFO1:SetNumeric(1, RetSqlName("FO1"))
	__oObjFO1:SetNumeric(2, RetSqlName("FO0"))
	__oObjFO1:SetString(3, cNumLiq)
	__oObjFO1:SetString(4, DTOS(dDtDigit))
	__oObjFO1:SetString(5, xFilial("FO1"))
	__oObjFO1:SetString(6, cIdDoc)

	cQuery 		:= __oObjFO1:GetFixQuery()   
 	nAbatFO1 	:=MpSysExecScalar(cQuery, "FO1_VLABT")

	lRet := nAbatFO1 == 0 

	RestArea(aArea)
	FwFreeArray(aArea)

Return lRet
