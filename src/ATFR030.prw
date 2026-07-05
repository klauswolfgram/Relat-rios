/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR030.CH"
#include "Protheus.ch"
#include "fwcommand.ch"
//#Include "FWLIBVERSION.CH"

#DEFINE VLR_RESIDUAL			1
#DEFINE VLR_ORIGINAL			2
#DEFINE VLR_CORRECAO			3
#DEFINE VLR_DEP_MES 			4
#DEFINE VLR_COR_DEP 			5
#DEFINE VLR_COR_EXE  		6
#DEFINE VLR_DEP_EXE     	7
#DEFINE VLR_COR_DEP_EXE		8
#DEFINE VLR_COR_ACU  		9
#DEFINE VLR_DEP_ACU     	10
#DEFINE VLR_COR_DEP_ACU		11

#DEFINE TAM_HIST		40

// TRADUCAO DE CH'S PARA PORTUGAL
// TRADUCAO DE CH'S PARA PORTUGAL - 21/07/08 

Static _aPictRel := NIL
Static __lMetric	:= .T. //FwLibVersion() >= "20210517" .And. GetSrvVersion() >= "19.3.0.6"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR030   ºAutor  ³Carlos A. Gomes Jr. º Data ³  06/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ficha do Ativo                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR030
Local oReport
Private dUltDepr	:= GetMV("MV_ULTDEPR")


	oReport := ReportDef()
	oReport:PrintDialog()

	_aPictRel := NIL

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Carlos A. Gomes Jr. º Data ³  06/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport,oSectionT,oSectionD
Local oSectionM1,oSectionM2,oSectionM3,oSectionM4,oSectionM5

Local cNomeSec := ""

Local cReport := "ATFR030"
Local cTitulo := OemToAnsi(STR0004) // "Ficha do Ativo Imobilizado"
Local cDescri := OemToAnsi(STR0001) + " " + OemToAnsi(STR0002) + " " + OemToAnsi(STR0003) // "Este programa ir  emitir a ficha dos ativos" ## "imobilizados, apresentando todas as ocorrˆncias" ## "desde sua aquisi‡„o."
Local aOrdem  := { OemtoAnsi(STR0032), OemtoAnsi(STR0033), OemtoAnsi(STR0034), OemToAnsi(STR0047), OemToAnsi(STR0048) } //" Por Bem"," Por Conta"," Por C.Custo" } 

Local nMoeda   := 1
Local cMoeda   := ""
Local cMSimbol := ""

Pergunte( "AFR030" , .F. )

oReport  := TReport():New( cReport, cTitulo, "AFR030" , { |oReport| ATFR030Imp( oReport ) }, cDescri )
/*
GESTAO - inicio */
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao Dados do Ativo                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionT := TRSection():New( oReport, STR0068, {"SN3","SN1","SN2","SA2"} , aOrdem ) // "Dados do Ativo"
TRCell():New( oSectionT, "N1_CBASE"   , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_ITEM"    , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_DESCRIC" , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_CHAPA"   , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_GRUPO"   , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_LOCAL"   , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_AQUISIC" , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_BAIXA"   , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_PROJETO" , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_NFISCAL" , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_NSERIE"  , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_QUANTD"  , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_PLACA"   , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_CSEGURO" , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_APOLICE" , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_DTVENC"  , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_TIPOSEG" , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_FORNEC"  , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N1_LOJA"    , "SN1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "A2_NOME"    , "SA2" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "N2_HISTOR"  , "SN2" ,/*X3Titulo*/,/*Picture*/,TAM_HIST/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.)  //DEIXAR FIXO EM 40 (TAMANHO PADRAO) E COLOCAR INSTRUCAO PARA QUEBRAR LINHA QDO ACIMA DE 40 POSICOES 

oSectionT:SetLineBreak()
oSectionT:SetHeaderPage()

oSectionT:SetNoFilter({"SN1","SN2","SA2"})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao Movimentacao                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionD := TRSection():New( oSectionT, STR0049, {"SN3","SN1","SN2","SA2"} , aOrdem ) //"Movimentação"
TRCell():New( oSectionD, "N3_TIPO"    , "SN3" ,/*X3Titulo*/,/*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
//TRCell():New( oSectionD, "cOcorr"     , /* */ ,"Desc."     ,/*Picture*/,14         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionD, "N3_HISTOR"  , "SN3" ,/*X3Titulo*/,/*Picture*/,40         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionD, "N3_CCONTAB" , "SN3" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionD, "N3_CCORREC" , "SN3" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionD, "N3_CDEPREC" , "SN3" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionD, "N3_CCDEPR"  , "SN3" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionD, "N3_CDESP"   , "SN3" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionD, "N3_CCUSTO"  , "SN3" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionD, "N3_DINDEPR" , "SN3" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionD, "N3_DTBAIXA" , "SN3" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionD, "N4_QUANTD"  , "SN4" ,STR0050 /*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Quant. Baixa"
TRCell():New( oSectionD, "N3_CODIND"  , "SN3" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSectionD:SetNoFilter({"SN1","SN2","SA2"})

For nMoeda := 1 To 5
	cMoeda := StrZero(nMoeda,1)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao Moedas                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNomeSec := "oSectionM"+cMoeda

	&(cNomeSec) := TRSection():New( oSectionD, STR0051 + SuperGetMV("MV_SIMB"+cMoeda), {"SN3","SN1","SN2","SA2"} , aOrdem ) // "Valores na moeda "

	cMSimbol := '{|| "' + SuperGetMV("MV_SIMB"+cMoeda)+'" }'
    // "MOEDA"
	TRCell():New( &(cNomeSec), "cMoeda"           , /* */  ,	Capital(OemToAnsi(STR0017))	,/*Picture*/,  6 ,/*lPixel*/, &cMSimbol )
	// "Vl Orig.+Ampliacao"
	TRCell():New( &(cNomeSec), "nCalc001"         , /* */  ,	STR0052 /*X3Titulo*/	,/*Picture*/, 19 ,/*lPixel*/,/*{|| code-block de impressao }*/)
	// "Tx. Depr"
	TRCell():New( &(cNomeSec), "N3_TXDEPR"+cMoeda , "SN3" ,	STR0053 /*X3Titulo*/	,/*Picture*/,  8 ,/*lPixel*/,/*{|| code-block de impressao }*/)
	// "Indice"
	TRCell():New( &(cNomeSec), "N3_INDICE"+cMoeda , "SN3" ,	STR0054 /*X3Titulo*/	,/*Picture*/,  8 ,/*lPixel*/,/*{|| code-block de impressao }*/)
	// "Correcao no mes"
	TRCell():New( &(cNomeSec), "N3_VRCMES1"       , "SN3" ,	STR0055+CRLF+;
																STR0056 /*X3Titulo*/	,/*Picture*/, 17 ,/*lPixel*/, Iif( nMoeda != 1 , {|| 0 } , ) )
	// "Depreciacao no mes"
	TRCell():New( &(cNomeSec), "N3_VRDMES"+cMoeda , "SN3" ,	STR0057+CRLF+;
																STR0056 /*X3Titulo*/	,/*Picture*/, 17 ,/*lPixel*/,/*{|| code-block de impressao }*/)
	// "Correcao da Deprec. no mes"
	TRCell():New( &(cNomeSec), "N3_VRCDM1"        , "SN3" ,	STR0058+CRLF+;
																STR0059 /*X3Titulo*/	,/*Picture*/, 16 ,/*lPixel*/, Iif( nMoeda != 1 , {|| 0 } , ) )
	// "Correcao no Exercicio"
	TRCell():New( &(cNomeSec), "N3_VRCBAL1"       , "SN3" ,	STR0060+CRLF+;
																STR0061 /*X3Titulo*/	,/*Picture*/, 20 ,/*lPixel*/, Iif( nMoeda != 1 , {|| 0 } , ) )
	// "Depreciacao no Exercício"
	TRCell():New( &(cNomeSec), "N3_VRDBAL"+cMoeda , "SN3" ,	STR0057+CRLF+;
																STR0061 /*X3Titulo*/	,/*Picture*/, 20 ,/*lPixel*/,/*{|| code-block de impressao }*/)
	// "Correcao da Deprec. no Exerc"
	TRCell():New( &(cNomeSec), "N3_VRCDB1"        , "SN3" ,	STR0062+CRLF+; 
																STR0063 /*X3Titulo*/	,/*Picture*/, 18 ,/*lPixel*/, Iif( nMoeda != 1 , {|| 0 } , ) )
	// "Correcao Acumulada"
	TRCell():New( &(cNomeSec), "N3_VRCACM1"       , "SN3" ,	STR0055+CRLF+;
																STR0064 /*X3Titulo*/	,/*Picture*/, 21 ,/*lPixel*/, /*{|| code-block de impressao }*/ )
	// "Depreciacao Acumulada"
	TRCell():New( &(cNomeSec), "N3_VRDACM"+cMoeda , "SN3" ,	STR0057+CRLF+;
																STR0064 /*X3Titulo*/	,/*Picture*/, 21 ,/*lPixel*/, /*{|| code-block de impressao }*/ )
	// "Correcao da Depreciação Acum."
	TRCell():New( &(cNomeSec), "N3_VRCDA1"        , "SN3" ,	STR0058+CRLF+;
																STR0065 /*X3Titulo*/	,/*Picture*/, 19 ,/*lPixel*/,/*{|| code-block de impressao }*/)


	If nMoeda != 1
		&(cNomeSec):SetHeaderSection(.F.)	
	EndIf
	&(cNomeSec):SetNoFilter({"SN1","SN2","SA2"})
	&(cNomeSec):SetColSpace(1)
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao "D" - Residual                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionR := TRSection():New( oSectionD, OemToAnsi(STR0031)  )
TRCell():New( oSectionR, "cDescValor" ,/*Alias*/	,OemToAnsi(STR0031)	,/*Picture*/, 01,/*lPixel*/,/*{|| code-block de impressao }*/)			// Vlr Residual
oSectionR:Cell("cDescValor"):SetAlign("LEFT")
oSectionR:Cell("cDescValor"):SetCellBreak(.T.)

For nMoeda := 1 To 5
	TRCell():New( oSectionR, "nValMoeda" + AllTrim( Str( nMoeda ) ),/*Alias*/, " "/*SuperGetMV("MV_SIMB" + AllTrim( Str( nMoeda ) ) )*/,""/*Picture*/,27,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda1
	oSectionR:Cell( "nValMoeda" + AllTrim( Str( nMoeda ) ) ):lAutoSize := .F.
	oSectionR:Cell( "nValMoeda" + AllTrim( Str( nMoeda ) ) ):SetCellBreak(.T.)
	oSectionR:Cell( "nValMoeda" + AllTrim( Str( nMoeda ) ) ):SetAlign("RIGHT")
	oSectionR:Cell( "nValMoeda" + AllTrim( Str( nMoeda ) ) ):SetHeaderAlign("LEFT")
Next

oSectionR:SetColSpace( 1 )
oSectionR:SetLineStyle()
oSectionR:SetCharSeparator("") 

oReport:SetTotalInLine(.F.)
oReport:SetLandScape()
oReport:DisableOrientation()

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR250ImpºAutor  ³Carlos A. Gomes Jr. º Data ³  06/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFR030Imp( oReport )

Local oSectionT  := oReport:Section(1)
Local oSectionD  := oSectionT:Section(1)
Local oSectionR  := oSectionD:Section(6)

Local cNomeSec := ""
Local cNomeBrk := ""

Local cAliasSN3 := "SN3"
Local cAliasSN1 := "SN1"
Local cAliasSA2 := "SA2"

Local nMoeda    := 1
Local cMoeda    := ""
Local cMoPar    := ""
Local cBCalc

Local aContab		:= {"N3_CCORREC","N3_CDEPREC","N3_CCDEPR","N3_CDESP"}
Local nTroca		:= 0
Local nOrdem		:= oSectionT:GetOrder()
Local aOcor			:= {}
Local nAscan
Local lImpTot		:= .F.
Local lTotBS		:= .F.
Local aTotBs		:= Array(5, 11)
Local aTotal		:= Array(5, 11)
Local cFilDe		:= cFilAnt
Local cFilAte		:= cFilAnt
Local cFilOld		:= cFilAnt
Local cTitAux
Local aOrdem		:= { OemtoAnsi(STR0032), OemtoAnsi(STR0033), OemtoAnsi(STR0034), OemToAnsi(STR0047), OemToAnsi(STR0048) } //" Por Bem"," Por Conta"," Por C.Custo" }
Local cFilterUser	:= oSectionT:GetAdvplExp("SN3")
Local nVlBase		:= 0
Local nInc			:= 0
Local aSM0			:= AdmAbreSM0()
Local aClassif		:= {}
Local cClassif		:= ""
Local cFilProc		:= ""
Local lExclusivo	:= AdmTabExc("SN3") //Analisa se a tabela esta exclusiva
Local lRealProv	:= .F. 
Local cTipGerInc	:= ATFXTpBem(2,.F.) + "/" + ATFXTpBem(3,.F.) // Tipo de bens gerenciais e incentivada. 
Local nReg			:= 0
Local nQtdReg 		:= 0
/*
GESTAO - inicio */
Local aSelFil		:= {}
Local nRegSM0		:= 0
/* GESTAO - fim
*/
Private oSectionM1 := oSectionD:Section(1)
Private oSectionM2 := oSectionD:Section(2)
Private oSectionM3 := oSectionD:Section(3)
Private oSectionM4 := oSectionD:Section(4)
Private oSectionM5 := oSectionD:Section(5)

If __lMetric
	nStart := Seconds()
EndIf

If oReport:lXlsTable
	Alert(STR0070)  //"Formato de impressão tabela não suportado neste relatório"
	oReport:CancelPrint()
	Return
Endif

If mv_par22 == 1
	aClassif := AdmGetClass()
	If Len( aClassif ) <= 0
		Return
	EndIf
EndIf

If mv_par16 <= 4 .and. mv_par17 <= 4 .and. mv_par16 == mv_par17
	MsgInfo(STR0067) // "As colunas para Item Contabil e Classe de Valor não podem ser iguais !"
	Return
EndIf
     
If oSectionT:GetOrder() == 1
	cChave := "N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO+N3_BAIXA+N3_SEQ"
ElseIf oSectionT:GetOrder() == 2
	cChave := "N3_FILIAL+N3_CCONTAB+N3_CBASE+N3_ITEM+N3_TIPO+N3_BAIXA"
ElseIf oSectionT:GetOrder() == 3
	cChave := "N3_FILIAL+N3_CCUSTO+N3_CBASE+N3_ITEM+N3_TIPO+N3_BAIXA"
ElseIf oSectionT:GetOrder() == 4
	cChave := "N3_FILIAL+N3_SUBCTA+N3_CCUSTO+N3_CCONTAB+N3_CBASE+N3_ITEM+N3_TIPO"
Else
	cChave := "N3_FILIAL+N3_CLVL+N3_SUBCTA+N3_CCUSTO+N3_CCONTAB+N3_CBASE+N3_ITEM+N3_TIPO"
EndIf

aOcor := {}
// Carrega tabela de tipos
SX5->(MsSeek(xFilial("SX5")+"G1"))
While SX5->X5_FILIAL == xFilial("SX5") .And. Alltrim(SX5->X5_TABELA) == "G1"
	Aadd(aOcor, { Alltrim(SX5->X5_CHAVE), AllTrim(X5Descri()) + If(Alltrim(SX5->X5_CHAVE) == "05", "  (-)","") } )
	SX5->(DbSkip())
End
	
TRPosition():New(oSectionT,"SN1",1,{|| xFilial("SN1") + SN3->(N3_CBASE+N3_ITEM) })
TRPosition():New(oSectionT,"SA2",1,{|| xFilial("SA2") + SN1->(N1_FORNEC+N1_LOJA) })
TRPosition():New(oSectionT,"SN2",1,{|| xFilial("SN2") + SN3->(N3_CBASE+N3_ITEM+N3_TIPO) })
TRPosition():New(oSectionT,"SN4",1,{|| xFilial("SN4") + SN3->(N3_CBASE+N3_ITEM+N3_TIPO)+DtoS(SN3->N3_DTBAIXA)+"01" })

If mv_par16 <= 4
	/// POSSIBILIDADES DA PERGUNTA: 1=Cta.Correção, 2=Cta.Depreciacao, 3=Cta.Corr.Depreciacao., 4=Desp.Deprec, 5=Nenhuma
	oSectionD:Cell(aContab[mv_par16]):SetTitle(STR0045)						/// A COLUNA SERA SUBSTITUÍDA PELO ITEM
	oSectionD:Cell(aContab[mv_par16]):SetBlock( {|| (cAliasSN3)->N3_SUBCTA } )
EndIf
If mv_par17 <= 4
	/// POSSIBILIDADES DA PERGUNTA: 1=Cta.Correção, 2=Cta.Depreciacao, 3=Cta.Corr.Depreciacao., 4=Desp.Deprec, 5=Nenhuma
	oSectionD:Cell(aContab[mv_par17]):SetTitle(STR0046)					/// A COLUNA SERA SUBSTITUÍDA PELA CLASSE DE VALOR
	oSectionD:Cell(aContab[mv_par17]):SetBlock( {|| (cAliasSN3)->N3_CLVL } )
EndIf

oSectionT:Cell("N1_FORNEC"):SetBlock({|| If(!Empty((cAliasSN1)->N1_FORNEC),(cAliasSA2)->A2_NOME,"")  })

If mv_par15 = 1
	If oSectionT:GetOrder() != 1
		MsgAlert(STR0066) // 'Só é possível sub-totalizar na ordem de codigo base.'
		mv_par15 := 2
	EndIF
EndIf

If mv_par09 != 1
	oSectionR:Cell("nValMoeda1"):Disable()
Endif
If mv_par10 != 1
	oSectionR:Cell("nValMoeda2"):Disable()
Endif
If mv_par11 != 1
	oSectionR:Cell("nValMoeda3"):Disable()
Endif
If mv_par12 != 1
	oSectionR:Cell("nValMoeda4"):Disable()
Endif
If mv_par13 != 1
	oSectionR:Cell("nValMoeda5"):Disable()
Endif
oSectionD:Cell("N4_QUANTD"):SetPicture("@Z"+AFPesqPict("SN4","N4_QUANTD",12))
oSectionR:Cell("nValMoeda1"):SetAlign("RIGHT")
oReport:NoUserFilter()

/*
 * Verificação do campo para ativos de custo de provisão
 */

lRealProv := AFXAtCsPrv()
	
For nMoeda := 1 To 5
	cMoeda := StrZero(nMoeda,1)
	cMoPar := StrZero(nMoeda+8,2)

	cNomeSec := "oSectionM"+cMoeda
	cNomeBrk := "oBreakM"+cMoeda
	
	&(cNomeSec):Cell("nCalc001"        ):SetPicture(AFPesqPict("SN3", "N3_VORIG"+cMoeda , 19, nMoeda))
	&(cNomeSec):Cell("N3_VRCMES1"      ):SetPicture(AFPesqPict("SN3", "N3_VRCMES1"      , 17, nMoeda))
	&(cNomeSec):Cell("N3_VRDMES"+cMoeda):SetPicture(AFPesqPict("SN3", "N3_VRDMES"+cMoeda, 17, nMoeda))
	&(cNomeSec):Cell("N3_VRCDM1"       ):SetPicture(AFPesqPict("SN3", "N3_VRCDM1"       , 16, nMoeda))
	&(cNomeSec):Cell("N3_VRCBAL1"      ):SetPicture(AFPesqPict("SN3", "N3_VRCBAL1"      , 20, nMoeda))
	&(cNomeSec):Cell("N3_VRDBAL"+cMoeda):SetPicture(AFPesqPict("SN3", "N3_VRDBAL"+cMoeda, 20, nMoeda))
	&(cNomeSec):Cell("N3_VRCDB1"       ):SetPicture(AFPesqPict("SN3", "N3_VRCDB1"       , 18, nMoeda))
	&(cNomeSec):Cell("N3_VRCACM1"      ):SetPicture(AFPesqPict("SN3", "N3_VRCACM1"      , 21, nMoeda))
	&(cNomeSec):Cell("N3_VRDACM"+cMoeda):SetPicture(AFPesqPict("SN3", "N3_VRDACM"+cMoeda, 21, nMoeda))
	&(cNomeSec):Cell("N3_VRCDA1"       ):SetPicture(AFPesqPict("SN3", "N3_VRCDA1"       , 19, nMoeda))
Next
/*
GESTAO - inicio */
If MV_PAR24 == 1
	nRegSM0 := SM0->(Recno())
	If  FindFunction("AdmSelecFil")
		AdmSelecFil("AFR030",24,.F.,@aSelFil,"SN3",.F.)
	Else
		aSelFil := AdmGetFil(.F.,.F.,"SN3")
	Endif
	SM0->(DbGoTo(nRegSM0))
Endif
If Empty(aSelFil)
	Aadd(aSelFil,cFilAnt)
Endif
Asort(aSelFil)
cFilDe := aSelFil[1]
cFilAte := aSelFil[Len(aSelFil)]
nInc := 0
/* Deixo na aSM0 somente as filiais selecionas para impressao. */
For nReg := Len(aSM0) To 1 Step(-1)
	If  Ascan(aSelFil,aSM0[nReg,SM0_CODFIL]) == 0
		Adel(aSM0,nReg)
		nInc++
	Endif
Next
If nInc > 0
	Asize(aSM0,Len(aSM0) - nInc)
Endif

/* GESTAO - fim
*/
cTitAux := oReport:Title()

For nMoeda := 1 To Len(aTotal)
	Afill(aTotal[nMoeda], 0.00)
	Afill(aTotBs[nMoeda], 0.00)
Next

For nInc := 1 To Len( aSM0 )
	If aSM0[nInc][1] == cEmpAnt .AND. aSM0[nInc][2] >= cFilDe .AND. aSM0[nInc][2] <= cFilAte
		cFilAnt := aSM0[nInc][2]

		//Tratamento Gestao Corporativa
		If Len(AllTrim(xFilial("SN3")) ) > 2
			If Alltrim(cFilProc) != Alltrim(xFilial("SN3"))
				cFilProc:= xFilial("SN3")
			Else
				Loop
			EndIf
		EndIf

		oReport:SetTitle(Alltrim(cTitAux + " - " + Alltrim(aOrdem[nOrdem])))
		
		If nOrdem <= 3
			SN3 -> ( dbSetOrder ( nOrdem ) )
		Else
			If nOrdem == 4
				SN3->(dbSetOrder(6))	/// POR ITEM CONTABIL
			Else
				SN3->(dbSetOrder(7))	/// POR CLASSE DE VALOR
			EndIf
		EndIf
		
		DbSelectArea("SN3")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza registro inicial                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nOrdem == 1
			SN3->( dbSeek(xFilial("SN3")+mv_par01 ,.T.) )
			cCond1 := "N3_CBASE >= mv_par01 .And. N3_CBASE <= mv_par02"
		ElseIf nOrdem == 2
			SN3->( dbSeek(xFilial("SN3")+mv_par07+mv_par01,.T.) )
			cCond1 := "N3_CCONTAB >= mv_par07 .And. N3_CCONTAB <= mv_par08"
		ElseIf nOrdem == 3
			SN3->( dbSeek(xFilial("SN3")+mv_par05+mv_par01,.T.) )
			cCond1 := "N3_CCUSTO >= mv_par05 .And. N3_CCUSTO <= mv_par06"
		Else
			SN3->( dbSeek(xFilial("SN3"),.T.) )
			cCond1 := "N3_CBASE >= mv_par01 .And. N3_CBASE <= mv_par02 "
			cCond1 += " .and. N3_CCONTAB >= mv_par07 .And. N3_CCONTAB <= mv_par08 "
			cCond1 += " .and. N3_CCUSTO >= mv_par05 .And. N3_CCUSTO <= mv_par06 "
		EndIf
		
		
		oReport:SetMeter(SN3->(RecCount()))
		
		cN3_Filant := Replicate('X',Len(cFilAnt))
		cN3_Basant := 'XXXXXXXXXX'
		cN3_Iteant := 'XXXX'
		
		For nMoeda:=2 To 5
			cPar   :=StrZero(nMoeda+8,2)
			cMoeda :=Str(nMoeda,1)
			cNomeSec := "oSectionM"+cMoeda
			&(cNomeSec):Init()
		Next

		//Verifica se filtra as classificações patrimoniais
		If Len(aClassif) > 0
			cClassif := FormatClass(aClassif,.F.)
		EndIf
		
		While !oReport:Cancel() .And.;
				SN3->(!Eof()) .And.  ;
				SN3->N3_FILIAL = xFilial("SN3")  .And.;
				If(nOrdem <= 3,&cCond1,.T.)
			   
			If SN3->N3_TIPO == '33'
				SN3->( dbSkip() )
				Loop
			EndIf
			
			//Para Metrica de quantidade de registros.
			If __lMetric
				nQtdReg ++
			Endif

			Begin Sequence
				// Incrementa regua
				oReport:IncMeter()
		
				If nOrdem > 3
					If !(&cCond1)
						SN3->(dbSkip())
						Break
					EndIf
				EndIf
				If !Empty(cFilterUser) .AND. !SN3->((&cFilterUser))		  	
					Break	
				Endif

				/*
				 * Verificação do campo para ativos de custo de provisão e se os bens de custo de provisão
				 * devem ser inibidos no relatório.
				 */
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Localiza item no SN1                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea("SN1")
				SN1->( dbSeek(xFilial("SN1")+SN3->N3_CBASE+SN3->N3_ITEM) )
				dbSelectArea("SN3")
		
				//Adiciona espacos em branco, pois possui bens normais sem preenchimento no campo de penhora.
				If ALLTRIM( SN1->N1_PENHORA ) == '' .and. !SN1->N1_PENHORA $ ALLTRIM( mv_par21 )
					mv_par21 := ALLTRIM( mv_par21 ) + SN1->N1_PENHORA
				EndIf
		
				If !SN1->N1_PENHORA $ mv_par21
					Break
				Endif
				
					
				lLoop := .F.
				lLoop := IIF(N3_CBASE   < mv_par01 .Or. N3_CBASE   > mv_par02, .T., lLoop)
				lLoop := IIF(N3_ITEM    < mv_par03 .Or. N3_ITEM    > mv_par04, .T., lLoop)
				lLoop := IIF(N3_CCUSTO  < mv_par05 .Or. N3_CCUSTO  > mv_par06, .T., lLoop)
				lLoop := IIF(N3_CCONTAB < mv_par07 .Or. N3_CCONTAB > mv_par08, .T., lLoop)
				lLoop := IIF(mv_par14 = 2 .and. Val(N3_BAIXA) != 0, .T.,lLoop)
				
				//Verifica se filtra as classificações patrimoniais
				If Len(aClassif) > 0
					lLoop := IIf(!(SN1->N1_PATRIM $ cClassif),.T.,lLoop)
				EndIf
				 
				If lRealProv
					If MV_PAR23 == 2 .AND. SN3->N3_ATFCPR == "1"
						lLoop := .T.
					EndIf
				EndIf
				
				If lLoop
					Break
				Endif
			    nReg := SN3->( RECNO() )
				oSectionD:Init()
				oSectionT:Init()        
				SN3->( dbGoto( nReg) )
			  	//SN3->( dbSeek(xFilial("SN3")+SN1->N1_CBASE+SN1->N1_ITEM) )
		
				IF	cN3_Filant != SN3->N3_FILIAL .Or. cN3_Basant != SN3->N3_CBASE .Or. cN3_Iteant != SN3->N3_ITEM
	
					cN3_Filant := SN3->N3_FILIAL
					cN3_Basant := SN3->N3_CBASE
					cN3_Iteant := SN3->N3_ITEM
					cHistor  := AFR030Texto(xFilial("SN2")+SN1->(N1_CBASE+N1_ITEM))
	
					oSectionT:Cell("N1_CBASE"):SetBlock( { || SN1->N1_CBASE } )
					oSectionT:Cell("N1_ITEM"):SetBlock( { || SN1->N1_ITEM } )
					oSectionT:Cell("N1_DESCRIC"):SetBlock( { || SubS(SN1->N1_DESCRIC, 1,40) } )
					oSectionT:Cell("N1_CHAPA"):SetBlock( { || SubS(SN1->N1_CHAPA  , 1,10) } )
					oSectionT:Cell("N1_GRUPO"):SetBlock( { || SubS(SN1->N1_GRUPO  , 1, 6) } )
					oSectionT:Cell("N1_LOCAL"):SetBlock( { || SubS(SN1->N1_LOCAL  , 1,15) } )
					oSectionT:Cell("N1_AQUISIC"):SetBlock( { || SN1->N1_AQUISIC } )
					oSectionT:Cell("N1_BAIXA"):SetBlock( { || SN1->N1_BAIXA } )
					oSectionT:Cell("N1_PROJETO"):SetBlock( { || 	SubS(SN1->N1_PROJETO, 1,12) } )
					oSectionT:Cell("N1_NFISCAL"):SetBlock( { || SN1->N1_NFISCAL } )
					oSectionT:Cell("N1_NSERIE"):SetBlock( { || &('SN1->'+SerieNfId('SN1',3,'N1_NSERIE')) } )
					oSectionT:Cell("N1_QUANTD"):SetBlock( { || SN1->N1_QUANTD  } )
					oSectionT:Cell("N1_PLACA"):SetBlock( { || SN1->N1_PLACA } )
					oSectionT:Cell("N1_CSEGURO"):SetBlock( { || SubS(SN1->N1_CSEGURO,1,30) } )
					oSectionT:Cell("N1_APOLICE"):SetBlock( { || SN1->N1_APOLICE } )
					oSectionT:Cell("N1_DTVENC"):SetBlock( { || SN1->N1_DTVENC } )
					oSectionT:Cell("N1_TIPOSEG"):SetBlock( { || SN1->N1_TIPOSEG } )
					oSectionT:Cell("N1_FORNEC"):SetBlock( { || SN1->N1_FORNEC } )
					oSectionT:Cell("N1_LOJA"):SetBlock( { || SN1->N1_LOJA } )
					oSectionT:Cell("A2_NOME"):SetBlock( { || SA2->A2_NREDUZ } )
					oSectionT:Cell("N2_HISTOR"):SetBlock( { || cHistor } )
					oSectionT:PrintLine()
					
				Endif
		
				dbSelectArea("SN3")
			
				IF	Val( SN3->N3_BAIXA ) # 0
					dbSelectArea("SN4")
					SN4->( dbSeek(xFilial("SN4")+SN3->N3_CBASE+SN3->N3_ITEM+SN3->N3_TIPO+DtoS(SN3->N3_DTBAIXA)+"01") )
					dbSelectArea("SN3")
				Endif
			
				oSectionD:Cell("N3_TIPO"):SetBlock( { ||	SN3->N3_TIPO + "-" + (nAscan := Ascan(aOcor, {|e| e[1] == SN3->N3_TIPO } ) ,;
					If(nAscan > 0, aOcor[nAscan][2], STR0069)) } )//"Não encontrado"
				oSectionD:Cell("N3_TIPO"):SetLineBreak()
				oSectionD:Cell("N3_HISTOR"):SetBlock( { || Subst(SN3->N3_HISTOR,1,40) } )
				oSectionD:Cell("N3_HISTOR"):SetLineBreak()
				oSectionD:Cell("N3_CCONTAB"):SetBlock( { || SN3->N3_CCONTAB } )
				oSectionD:Cell("N3_CCORREC"):SetBlock( { || &(aContab[1]) } )
				oSectionD:Cell("N3_CDEPREC"):SetBlock( { || &(aContab[2]) } )
				oSectionD:Cell("N3_CCDEPR"):SetBlock( { || &(aContab[3]) } )
				oSectionD:Cell("N3_CDESP"):SetBlock( { || &(aContab[4]) } )
				oSectionD:Cell("N3_CCUSTO"):SetBlock( { || SN3->N3_CCUSTO } )
				oSectionD:Cell("N3_DINDEPR"):SetBlock( { || SN3->N3_DINDEPR } )
				oSectionD:Cell("N3_DTBAIXA"):SetBlock( { || IF(	Val( SN3->N3_BAIXA ) # 0, SN3->N3_DTBAIXA, "" ) } )
				oSectionD:Cell("N4_QUANTD"):SetBlock( { || IF(	Val( SN3->N3_BAIXA ) # 0, SN4->N4_QUANTD, 0 ) } )
				oSectionD:Cell("N3_CODIND"):SetBlock( { || SN3->N3_CODIND } )
				oSectionD:PrintLine()
	
				oReport:SkipLine()
				oSectionM1:Init()
				oSectionM2:Init()
				oSectionM3:Init()
				oSectionM4:Init()
				oSectionM5:Init()
			
				For nMoeda:=1 To 5
				
					cPar   :=StrZero(nMoeda+8,2)
					cMoeda :=Str(nMoeda,1)
					cNomeSec := "oSectionM"+cMoeda
				
					If	MV_PAR&cPar = 1
						&(cNomeSec):Cell("cMoeda"):SetBlock({ || SuperGetMV("MV_SIMB"+cMoeda) } )
	
						If (MesAnoAtf( N3_DINDEPR ) <> MesAnoAtf( dUltDepr )) .AND.(MesAnoAtf( N3_DINDEPR )<>MesAnoAtf( dUltDepr+1 ))
							//Calcula o custo de aquisicao atualizado
							nVlBase := ( N3_VORIG1 + N3_AMPLIA1 + N3_VRCACM1 ) + ( N3_VRCMES1 * (-1) )
							nVlBase := xMoeda(nVlBase, 1, Val(cMoeda), dUltDepr)
						Else
							nVlBase := N3_VORIG1 + N3_AMPLIA1
							nVlBase := xMoeda(nVlBase, 1, Val(cMoeda), N3_DINDEPR)
						Endif
	
						&(cNomeSec):Cell("nCalc001"):SetBlock({ || N3_VORIG&cMoeda + N3_AMPLIA&cMoeda } )
						&(cNomeSec):Cell("N3_TXDEPR"+cMoeda):SetBlock({ || N3_TXDEPR&cMoeda } )
						&(cNomeSec):Cell("N3_INDICE"+cMoeda):SetBlock({ || N3_INDICE&cMoeda } )
	
						// Valores de Depreciacao
						&(cNomeSec):Cell("N3_VRDMES"+cMoeda):SetBlock({ || N3_VRDMES&cMoeda } )
						&(cNomeSec):Cell("N3_VRDBAL"+cMoeda):SetBlock({ || N3_VRDBAL&cMoeda + xMoeda(SN3->N3_VRCDB1, 1, Val(cMoeda), dUltDepr) } )
						&(cNomeSec):Cell("N3_VRDACM"+cMoeda):SetBlock({ || N3_VRDACM&cMoeda + xMoeda(SN3->N3_VRCDA1, 1, Val(cMoeda), dUltDepr) } )
	
						// Valores da Correcao Monetaria
						&(cNomeSec):Cell("N3_VRCMES1"):SetBlock({ || xMoeda(SN3->N3_VRCMES1, 1, Val(cMoeda), dUltDepr) } )
						&(cNomeSec):Cell("N3_VRCBAL1"):SetBlock({ || xMoeda(SN3->N3_VRCBAL1, 1, Val(cMoeda), dUltDepr) } )
						&(cNomeSec):Cell("N3_VRCACM1"):SetBlock({ || xMoeda(SN3->N3_VRCACM1, 1, Val(cMoeda), dUltDepr) } )
	
						// Valores da Correcao s/Depreciacao Acumulada
						&(cNomeSec):Cell("N3_VRCDM1"):SetBlock({ || xMoeda(SN3->N3_VRCDM1, 1, Val(cMoeda), dUltDepr) } )
						&(cNomeSec):Cell("N3_VRCDB1"):SetBlock({ || xMoeda(SN3->N3_VRCDB1, 1, Val(cMoeda), dUltDepr) } )
						&(cNomeSec):Cell("N3_VRCDA1"):SetBlock({ || xMoeda(SN3->N3_VRCDA1, 1, Val(cMoeda), dUltDepr) } )
						
						nValResid1 := (SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1)-(SN3->N3_VRDACM1+SN3->N3_VRCDA1)
						If cMoeda <> "1"
							//nValResid&cMoeda :=&('SN3->N3_VORIG'+cMoeda)+&('SN3->N3_AMPLIA'+cMoeda)-&('SN3->N3_VRDACM'+cMoeda)
							If (MesAnoAtf( N3_DINDEPR ) <> MesAnoAtf( dUltDepr )) .AND.(MesAnoAtf( N3_DINDEPR )<>MesAnoAtf( dUltDepr+1 ))
								nValResid&cMoeda :=(N3_VORIG&cMoeda + N3_VRCACM&cMoeda + N3_AMPLIA&cMoeda)-( N3_VRDACM&cMoeda + xMoeda(SN3->N3_VRCDA1, 1, Val(cMoeda), dUltDepr) )
							Else
								nValResid&cMoeda :=(N3_VORIG&cMoeda + N3_VRCACM&cMoeda + N3_AMPLIA&cMoeda)-( N3_VRDACM&cMoeda + xMoeda(SN3->N3_VRCDA1, 1, Val(cMoeda), N3_DINDEPR) )
							Endif
						Endif
		
						// Totalizacao para apresentacao de resumo
						If ! N3_TIPO $ "07/" + cTipGerInc // Não considerar o item de depreciação acelerada incentivada
							aTotal[nMoeda][VLR_ORIGINAL] 		+= N3_VORIG&cMoeda + N3_AMPLIA&cMoeda
						Endif
	
						If ! N3_TIPO $ "07/" + cTipGerInc // Não considerar o item de depreciação acelerada incentivada
							aTotal[nMoeda][VLR_RESIDUAL] 		+= nValResid&cMoeda
	                        // Valores de Depreciacao
							aTotal[nMoeda][VLR_DEP_MES] 		+= N3_VRDMES&cMoeda
							aTotal[nMoeda][VLR_DEP_EXE] 		+= ( N3_VRDBAL&cMoeda + xMoeda(SN3->N3_VRCDB1, 1, Val(cMoeda), dUltDepr) )
							aTotal[nMoeda][VLR_DEP_ACU] 		+= ( N3_VRDACM&cMoeda + xMoeda(SN3->N3_VRCDA1, 1, Val(cMoeda), dUltDepr) )
	                        // Valores da Correcao Monetaria
							aTotal[nMoeda][VLR_CORRECAO] 		+= xMoeda(SN3->N3_VRCMES1, 1, Val(cMoeda), dUltDepr)
							aTotal[nMoeda][VLR_COR_EXE] 		+= xMoeda(SN3->N3_VRCBAL1, 1, Val(cMoeda), dUltDepr)
							aTotal[nMoeda][VLR_COR_ACU] 		+= xMoeda(SN3->N3_VRCACM1, 1, Val(cMoeda), dUltDepr)
	                        // Valores da Correcao s/Depreciacao Acumulada
							aTotal[nMoeda][VLR_COR_DEP] 		+= xMoeda(SN3->N3_VRCDM1, 1, Val(cMoeda), dUltDepr)
							aTotal[nMoeda][VLR_COR_DEP_EXE] 	+= xMoeda(SN3->N3_VRCDB1, 1, Val(cMoeda), dUltDepr)
							aTotal[nMoeda][VLR_COR_DEP_ACU] 	+= xMoeda(SN3->N3_VRCDA1, 1, Val(cMoeda), dUltDepr)
						Endif
						
						If mv_par15 = 1
							If ! N3_TIPO $ "07/" + cTipGerInc // Não considerar o item de depreciação acelerada incentivada
								aTotBs[nMoeda][VLR_ORIGINAL] 	+= N3_VORIG&cMoeda + N3_AMPLIA&cMoeda
							Endif
	
							If ! N3_TIPO $ "07/" + cTipGerInc // Não considerar o item de depreciação acelerada incentivada
								aTotBs[nMoeda][VLR_RESIDUAL] 		+= nValResid&cMoeda
	                            // Valores da Depreciacao
								aTotBs[nMoeda][VLR_DEP_MES] 		+= N3_VRDMES&cMoeda
								aTotBs[nMoeda][VLR_DEP_EXE] 		+= ( N3_VRDBAL&cMoeda + xMoeda(SN3->N3_VRCDB1, 1, Val(cMoeda), dUltDepr) )
								aTotBs[nMoeda][VLR_DEP_ACU] 		+= ( N3_VRDACM&cMoeda + xMoeda(SN3->N3_VRCDA1, 1, Val(cMoeda), dUltDepr) )
								// Valores da Correcao Monetaria
								aTotBs[nMoeda][VLR_CORRECAO] 		+= xMoeda(SN3->N3_VRCMES1, 1, Val(cMoeda), dUltDepr)
								aTotBs[nMoeda][VLR_COR_EXE] 		+= xMoeda(SN3->N3_VRCBAL1, 1, Val(cMoeda), dUltDepr)
								aTotBs[nMoeda][VLR_COR_ACU] 		+= xMoeda(SN3->N3_VRCACM1, 1, Val(cMoeda), dUltDepr)
								// Valores da Correcao s/Depreciacao Acumulada
								aTotBs[nMoeda][VLR_COR_DEP] 		+= xMoeda(SN3->N3_VRCDM1, 1, Val(cMoeda), dUltDepr)
								aTotBs[nMoeda][VLR_COR_DEP_EXE] 	+= xMoeda(SN3->N3_VRCDB1, 1, Val(cMoeda), dUltDepr)
								aTotBs[nMoeda][VLR_COR_DEP_ACU] 	+= xMoeda(SN3->N3_VRCDA1, 1, Val(cMoeda), dUltDepr)
							Endif
						Endif
	
						&(cNomeSec):PrintLine()
						lTotBS := .T.
						lImpTot := .T.
					End
				Next
			
				oSectionR:Init()
		
				If mv_par09 == 1
					oSectionR:Cell("nValMoeda1"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB1") ), 8 ) + Pad(Transform(nValResid1, AFPesqPict("SN3","N3_VORIG1",19, 1)),19) } )
				Endif
				If mv_par10 == 1
					oSectionR:Cell("nValMoeda2"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB2") ), 8 ) + Pad(Transform(nValResid2, AFPesqPict("SN3","N3_VORIG2",19, 2)),19) } )
				Endif
				If mv_par11 == 1
					oSectionR:Cell("nValMoeda3"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB3") ), 8 ) + Pad(Transform(nValResid3, AFPesqPict("SN3","N3_VORIG3",19, 3)),19) } )
				Endif
				If mv_par12 == 1
					oSectionR:Cell("nValMoeda4"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB4") ), 8 ) + Pad(Transform(nValResid4, AFPesqPict("SN3","N3_VORIG4",19, 4)),19) } )
				Endif
				If mv_par13 == 1
					oSectionR:Cell("nValMoeda5"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB5") ), 8 ) + Pad(Transform(nValResid5, AFPesqPict("SN3","N3_VORIG5",19, 5)),19) } )
				Endif
	
				oSectionR:PrintLine()
				oSectionR:Finish()
				oSectionD:Finish()
				oSectionT:Finish()
				oSectionM1:Finish()
				oReport:ThinLine()
		
			End Sequence
			
			SN3->( dbSkip() )

			// Somente imprimo o total do codigo base se tiver o que ser impresso eh
			// For impresso por ordem de bem
			If lTotBS .And. nOrdem = 1 .And. mv_par15 = 1 .And. cN3_Basant != SN3->N3_CBASE
			
				lTotBS := .F.
			   
				oReport:SkipLine()
	
				oReport:PrintText(STR0038 + cN3_Basant) //"TOTAL DO CODIGO BASE - "
				
				oReport:SkipLine()
				oSectionM1:Init()
				oSectionM2:Init()
				oSectionM3:Init()
				oSectionM4:Init()
				oSectionM5:Init()
				For nMoeda:=1 To 5
						
					cPar   :=StrZero(nMoeda+8,2)
					cMoeda :=Str(nMoeda,1)
					cNomeSec := "oSectionM"+cMoeda
					
					If	MV_PAR&cPar = 1
						&(cNomeSec):Cell("N3_TXDEPR"+cMoeda):SetPicture("@Z"+AFPesqPict("SN3","N3_TXDEPR"+cMoeda) )
						&(cNomeSec):Cell("N3_INDICE"+cMoeda):SetPicture("@Z"+AFPesqPict("SN3","N3_INDICE"+cMoeda) )
						&(cNomeSec):Cell("cMoeda"):SetBlock({ || GETMV("MV_SIMB"+cMoeda) } )
						&(cNomeSec):Cell("nCalc001"):SetBlock({ || aTotBs[nMoeda][VLR_ORIGINAL] } )
						&(cNomeSec):Cell("N3_TXDEPR"+cMoeda):SetBlock({ || 0 } )
						&(cNomeSec):Cell("N3_INDICE"+cMoeda):SetBlock({ || 0 } )
						&(cNomeSec):Cell("N3_VRCMES1"):SetBlock({ || aTotBs[nMoeda][VLR_CORRECAO] } )
						&(cNomeSec):Cell("N3_VRDMES"+cMoeda):SetBlock({ || aTotBs[nMoeda][VLR_DEP_MES] } )
						&(cNomeSec):Cell("N3_VRCDM1"):SetBlock({ ||  aTotBs[nMoeda][VLR_COR_DEP] } )
						&(cNomeSec):Cell("N3_VRCBAL1"):SetBlock({ || aTotBs[nMoeda][VLR_COR_EXE] } )
						&(cNomeSec):Cell("N3_VRDBAL"+cMoeda):SetBlock({ || aTotBs[nMoeda][VLR_DEP_EXE] } )
						&(cNomeSec):Cell("N3_VRCDB1"):SetBlock({ ||  aTotBs[nMoeda][VLR_COR_DEP_EXE]} )
						&(cNomeSec):Cell("N3_VRCACM1"):SetBlock({ || aTotBs[nMoeda][VLR_COR_ACU] } )
						&(cNomeSec):Cell("N3_VRDACM"+cMoeda):SetBlock({ || aTotBs[nMoeda][VLR_DEP_ACU] } )
						&(cNomeSec):Cell("N3_VRCDA1"):SetBlock({ || aTotBs[nMoeda][VLR_COR_DEP_ACU] } )
						&(cNomeSec):PrintLine()
						&(cNomeSec):Cell("N3_TXDEPR"+cMoeda):SetPicture(AFPesqPict("SN3","N3_TXDEPR"+cMoeda) )
						&(cNomeSec):Cell("N3_INDICE"+cMoeda):SetPicture(AFPesqPict("SN3","N3_INDICE"+cMoeda) )
					Endif
				Next
				oSectionM1:Finish()
				oSectionM2:Finish()
				oSectionM3:Finish()
				oSectionM4:Finish()
				oSectionM5:Finish()
				oSectionR:Init()
				oSectionR:Cell("nValMoeda1"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB1") ), 8 ) + Pad(Transform(aTotBs[1][VLR_RESIDUAL], AFPesqPict("SN3","N3_VORIG1",19, 1)),19) } )
				oSectionR:Cell("nValMoeda2"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB2") ), 8 ) + Pad(Transform(aTotBs[2][VLR_RESIDUAL], AFPesqPict("SN3","N3_VORIG2",19, 2)),19) } )
				oSectionR:Cell("nValMoeda3"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB3") ), 8 ) + Pad(Transform(aTotBs[3][VLR_RESIDUAL], AFPesqPict("SN3","N3_VORIG3",19, 3)),19) } )
				oSectionR:Cell("nValMoeda4"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB4") ), 8 ) + Pad(Transform(aTotBs[4][VLR_RESIDUAL], AFPesqPict("SN3","N3_VORIG4",19, 4)),19) } )
				oSectionR:Cell("nValMoeda5"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB5") ), 8 ) + Pad(Transform(aTotBs[5][VLR_RESIDUAL], AFPesqPict("SN3","N3_VORIG5",19, 5)),19) } )
				oSectionR:PrintLine()
				oSectionR:Finish()
				oReport:ThinLine()
				For nMoeda := 1 To Len(aTotBs)
					Afill(aTotBs[nMoeda], 0.00)
				Next
			Endif
		End
		
		For nMoeda:=1 To 5
			cPar   :=StrZero(nMoeda+8,2)
			cMoeda :=Str(nMoeda,1)
			cNomeSec := "oSectionM"+cMoeda
			&(cNomeSec):Finish()
		Next
		// Se o arquivo for compartilhado, processa apenas uma vez
		If !lExclusivo
			Exit
		Endif
	EndIf
Next

cFilAnt := cFilOld

oSectionM1:Init()
oSectionM1:Init()
oSectionM2:Init()
oSectionM3:Init()
oSectionM4:Init()
oSectionM5:Init()

If lImpTot
//	Fr030Total(aTotal, STR0039) //"RESUMO GERAL"

	oReport:SkipLine()
	oReport:PrintText(STR0039)
	oReport:SkipLine()
	
	For nMoeda:=1 To 5
			
		cPar   :=StrZero(nMoeda+8,2)
		cMoeda :=Str(nMoeda,1)
		cNomeSec := "oSectionM"+cMoeda
		
		If	MV_PAR&cPar = 1
			&(cNomeSec):Cell("N3_TXDEPR"+cMoeda):SetPicture("@Z"+AFPesqPict("SN3","N3_TXDEPR"+cMoeda) )
			&(cNomeSec):Cell("N3_INDICE"+cMoeda):SetPicture("@Z"+AFPesqPict("SN3","N3_INDICE"+cMoeda) )
			&(cNomeSec):Cell("cMoeda"):SetBlock({ || GETMV("MV_SIMB"+cMoeda) } )
			&(cNomeSec):Cell("nCalc001"):SetBlock({ || aTotal[nMoeda][VLR_ORIGINAL] } )
			&(cNomeSec):Cell("N3_TXDEPR"+cMoeda):SetBlock({ || 0 } )
			&(cNomeSec):Cell("N3_INDICE"+cMoeda):SetBlock({ || 0 } )
			&(cNomeSec):Cell("N3_VRCMES1"):SetBlock({ || aTotal[nMoeda][VLR_CORRECAO] } )
			&(cNomeSec):Cell("N3_VRDMES"+cMoeda):SetBlock({ || aTotal[nMoeda][VLR_DEP_MES] } )
			&(cNomeSec):Cell("N3_VRCDM1"):SetBlock({ ||  aTotal[nMoeda][VLR_COR_DEP] } )
			&(cNomeSec):Cell("N3_VRCBAL1"):SetBlock({ || aTotal[nMoeda][VLR_COR_EXE] } )
			&(cNomeSec):Cell("N3_VRDBAL"+cMoeda):SetBlock({ || aTotal[nMoeda][VLR_DEP_EXE] } )
			&(cNomeSec):Cell("N3_VRCDB1"):SetBlock({ ||  aTotal[nMoeda][VLR_COR_DEP_EXE]} )
			&(cNomeSec):Cell("N3_VRCACM1"):SetBlock({ || aTotal[nMoeda][VLR_COR_ACU] } )
			&(cNomeSec):Cell("N3_VRDACM"+cMoeda):SetBlock({ || aTotal[nMoeda][VLR_DEP_ACU] } )
			&(cNomeSec):Cell("N3_VRCDA1"):SetBlock({ || aTotal[nMoeda][VLR_COR_DEP_ACU] } )
			&(cNomeSec):PrintLine()
			&(cNomeSec):Cell("N3_TXDEPR"+cMoeda):SetPicture(AFPesqPict("SN3","N3_TXDEPR"+cMoeda) )
			&(cNomeSec):Cell("N3_INDICE"+cMoeda):SetPicture(AFPesqPict("SN3","N3_INDICE"+cMoeda) )
		Endif
	Next
Endif
oSectionM1:Finish()
oSectionM2:Finish()
oSectionM3:Finish()
oSectionM4:Finish()
oSectionM5:Finish()
oSectionR:Init()
oSectionR:Cell("nValMoeda1"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB1") ), 8 ) + Pad(Transform(aTotal[1][VLR_RESIDUAL], AFPesqPict("SN3","N3_VORIG1",19, 1)),19) } )
oSectionR:Cell("nValMoeda2"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB2") ), 8 ) + Pad(Transform(aTotal[2][VLR_RESIDUAL], AFPesqPict("SN3","N3_VORIG2",19, 2)),19) } )
oSectionR:Cell("nValMoeda3"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB3") ), 8 ) + Pad(Transform(aTotal[3][VLR_RESIDUAL], AFPesqPict("SN3","N3_VORIG3",19, 3)),19) } )
oSectionR:Cell("nValMoeda4"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB4") ), 8 ) + Pad(Transform(aTotal[4][VLR_RESIDUAL], AFPesqPict("SN3","N3_VORIG4",19, 4)),19) } )
oSectionR:Cell("nValMoeda5"):SetBlock( { || PadR( AllTrim( SuperGetMV("MV_SIMB5") ), 8 ) + Pad(Transform(aTotal[5][VLR_RESIDUAL], AFPesqPict("SN3","N3_VORIG5",19, 5)),19) } )
oSectionR:PrintLine()
oSectionR:Finish()

dbClearFilter( )

SN3 -> ( DbSetOrder ( 1 ) )
SN1 -> ( DbSetOrder ( 1 ) )

//Metrica - Qtd Registros e tempo medio
If __lMetric
	//Chamar metrica passando nQtdReg e nStart pra capturar apenas a qtd de registros
	ATR030Metrics("01" /*cEvent*/, nStart, "001" /*cSubEvent*/, Alltrim(ProcName()) /*cSubRoutine*/) //Metrica tempo medio
	ATR030Metrics("02" /*cEvent*/, /* nStart */, "001" /*cSubEvent*/, Alltrim(ProcName()) /*cSubRoutine*/, nQtdReg /* nQtdReg */)  // Metrica Qtd de registros
	nStart := 0
EndIf	

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AdmAbreSM0³ Autor ³ Orizio                ³ Data ³ 22/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna um array com as informacoes das filias das empresas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AdmAbreSM0()
	Local aArea			:= SM0->( GetArea() )
	Local aAux			:= {}
	Local aRetSM0		:= {}
	Local lFWLoadSM0	:= .T.
	Local lFWCodFilSM0 	:= .T.

	If lFWLoadSM0
		aRetSM0	:= FWLoadSM0()
	Else
		DbSelectArea( "SM0" )
		SM0->( DbGoTop() )
		While SM0->( !Eof() )
			aAux := { 	SM0->M0_CODIGO,;
						IIf( lFWCodFilSM0, FWGETCODFILIAL, SM0->M0_CODFIL ),;
						"",;
						"",;
						"",;
						SM0->M0_NOME,;
						SM0->M0_FILIAL }

			aAdd( aRetSM0, aClone( aAux ) )
			SM0->( DbSkip() )
		End
	EndIf

	RestArea( aArea )
Return aRetSM0 

//-------------------------------------------------------------------
/*/{Protheus.doc}AFR030Texto
Recupera um texto do arquivo de descrição extendidas
@author William Matos Gundim Junior
@since  09/01/2014
@version 12
/*/
//-------------------------------------------------------------------
Static Function AFR030Texto(cChave)
Local cTexto 	:= ""
Local aArea   	:= GetArea()
Local aSN2    	:= SN2->(GetArea())
Local aSX5    	:= SX5->(GetArea())
Local cTp		:= ""
Local cHist		:= ""

	// ajusta o indice da SN2
	SN2->(DbSetOrder(2))
	If SN2->( dbSeek(cChave) )
		// se encontrada a descricao pega todos os historicos
		While SN2->( !Eof() .And. N2_FILIAL+N2_CBASE+N2_ITEM == cChave )

			If Empty(cTp) .or. SN2->N2_TIPO  == cTp
				If Empty(cTp)
					cHist += PadR("Tp : "+SN2->N2_TIPO+"-"+Posicione("SX5",1,xFilial("SX5")+"G1"+SN2->N2_TIPO,"X5Descri()"), TAM_HIST )
				EndIf
				cHist += SN2->N2_HISTOR
				cTp := SN2->N2_TIPO
			Else
				cHist += Chr(13) + Chr(10) 
				cHist += PadR("Tp : "+SN2->N2_TIPO+"-"+Posicione("SX5",1,xFilial("SX5")+"G1"+SN2->N2_TIPO,"X5Descri()"), TAM_HIST )
				cHist += SN2->N2_HISTOR
				cTp := SN2->N2_TIPO
			EndIf

			SN2->( DbSkip() )	

		EndDo

		cTexto := Transform(cHist, X3Picture('N2_HISTOR '))
			
	EndIf

	// restaura ambiente
	SN2->(RestArea(aSN2))
	RestArea(aSX5)
	RestArea(aArea)

Return AllTrim(cTexto)


//-------------------------------------------------------------------
/*/{Protheus.doc}AFPesqPict
Recupera a picture e coloca em array static para melhorar performance
@author Totvs
@since  19/11/2019
@version 12
/*/
//-------------------------------------------------------------------
Static Function AFPesqPict(cAlias, cCampo, nTamanho, nMoeda)

Local cPicture := ""
Local nPosPict := 0

If _aPictRel == NIL
	_aPictRel := {}
EndIf

nPosPict := aScan(_aPictRel, {|x| x[1] == cAlias .And. x[2] == cCampo .And. x[3] == nTamanho .And. x[4] == nMoeda })

If nPosPict == 0  //se nao encontrou no array faz pesquisa picture - funcao de lib
	cPicture := PesqPict(cAlias, cCampo, nTamanho, nMoeda)
	aAdd(_aPictRel, {cAlias, cCampo, nTamanho, nMoeda, cPicture})
Else
	cPicture := _aPictRel[nPosPict, 5]
EndIf

Return(cPicture)


/*/{Protheus.doc} ATR030Metrics
	
	ATR030Metrics - Funç?o utilizada para metricas no CTBR400

	@type  Static Function
	@author user
	@since date
	@version version
	@param param, param_type, param_descr
	@return return, return_type, return_description
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function ATR030Metrics(cEvent, nStart, cSubEvent, cSubRoutine, nQtdReg)

Local cFunBkp	:= ""
Local cFunMet	:= ""

Local nFim := 0

Local cIdMetric  := ""
Local dDateSend := CtoD("") 
Local nLapTime := 0
Local cTotal := ""

Default cEvent := ""
Default nStart := Seconds()
Default cSubEvent := ""
Default cSubRoutine := Alltrim(ProcName(1))
Default nQtdReg := 0

//Só capturar metricas se a vers?o da lib for superior a 20210517
If __lMetric .And. !Empty(cEvent)
	
	//grava funname atual na variavel cFunBkp
	cFunBkp := FunName()

	If cEvent == "01" //Evento 01 - Metrica de tempo médio

		
		If cSubEvent == '001' // 001 = R4
			
			cFunMet := Iif(AllTrim(cFunBkp)=='RPC',"RPCATFR030",cFunBkp)
			SetFunName(cFunMet)

			nFim := Seconds() - nStart // Capturar tempo final | Diferença com o tempo inicial
			
			//atribuicao das variaveis que serao utilizadas pelo FwCustomMetrics
			
			cSubRoutine := Alltrim(cSubRoutine)
			cIdMetric  := "ativo-fixo--protheus_ficha-do-ativo-tempo-total-_seconds"
			cTotal := "1"
			dDateSend := LastDay( Date() )
			nLapTime := nFim

			// Metrica
			FWCustomMetrics():SetMetric(cSubRoutine, cIdMetric, cTotal, dDateSend, nLapTime)

		EndIf

	//Evento 02 - Metrica de quantidade total
	ElseIf cEvent == "02" .And. nQtdReg > 0 

		If cSubEvent == '001'

			cFunMet := Iif(AllTrim(cFunBkp)=='RPC',"RPCATFR030",cFunBkp)
			
			//atribuicao das variaveis que serao utilizadas pelo FwCustomMetrics
			SetFunName(cFunMet)
			cSubRoutine := Alltrim(cSubRoutine)			
			cIdMetric  := "ativo-fixo--protheus_ficha-do-ativo-qtd-_total"
			cTotal := cValToChar(nQtdReg) //cTotal na funç?o SetMetric espera parametro do tipo caractere						
			dDateSend := LastDay( Date() )
			FWCustomMetrics():SetMetric(cSubRoutine, cIdMetric, cTotal, dDateSend)
		EndIf
	EndIf

	//Restaura setfunname a partir da variavel salva cFunBkp
	SetFunName(cFunBkp)
EndIf

Return 
