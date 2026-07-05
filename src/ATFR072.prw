/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.ch"
#Include "ATFR072.ch"
#INCLUDE "DBINFO.CH"
// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres .  

STATIC aComboATF

/*
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ ATFR072    ณ Autor ณ Alvaro Camillo Neto   ณ Data ณ 22.09.10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Posicao Valorizada dos Bens na Data                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe e ณ ATFR072                                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ SIGAATF                                                      ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ATFR072()
Local oReport
Local lTReport	:= TRepInUse()
Local lDefTop 	:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
Private aSelFil	:= {}
Private aSelMoed:= {} 
Private aSelClass:= {} 
Private lTodasFil:= .F.
PRIVATE cPerg   := "AFR072"

If !lDefTop
	Help("  ",1,"AFR072TOP",,STR0001 ,1,0) //"Fun็ใo disponํvel apenas para ambientes TopConnect"
	Return
EndIf

If !lTReport
	Help("  ",1,"AFR072R4",,STR0043,1,0) //"Fun็ใo disponํvel apenas para ambientes TopConnect"
	Return
ENdIf

lRet := Pergunte( cPerg , .T. )

If lRet
	If mv_par20 == 1 .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil(@lTodasFil)
		If Len( aSelFil ) <= 0
			Return
		EndIf
	EndIf
	
	If mv_par03 == 1 .And. Len( aSelMoed ) <= 0
		aSelMoed := ADMGETMOED()
		If Len( aSelMoed ) <= 0
			Return
		EndIf
		If Len( aSelMoed ) > 5
			Help(" ",1,"ATR072MOE",,STR0002,1,0)//"Deve ser selecionado no mแximo 5 moedas "
			Return
		EndIf
	EndIf
	
	//Seleciona as classifica็๕es patrimoniais
	If mv_par26 == 1 .And. Len( aSelClass ) <= 0
		aSelClass := AdmGetClas()
		If Len( aSelClass ) <= 0
			Return
		EndIf 
	EndIf

	//Valida o Tipo de Saldo
	If !VldTpSald( MV_PAR25, .T. )
		Return
	EndIf

	
	oReport := ReportDef()
	oReport:PrintDialog()
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณAlvaro Camillo Neto บ Data ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Defini็ใo de layout do relat๓rio analํtico                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
Local oReport
Local oSecEntCtb
Local oSecBem
Local oSecValores

Local oTotalGeral
Local oSubtotal

Local oTxtSubtotal
Local oTxtTotGer

Local oTxtFiscal
Local oTxtGerencial
Local oTxtIncentivada
Local oTxtFilial

Local cReport := "ATFR072"
Local cTitulo :=	OemToAnsi(STR0003)	//"Posicao Valorizada dos Bens na Data"
Local cDescri :=	OemToAnsi(STR0004) + " " +;	// "Este programa ir  emitir a posio valorizada dos"
OemToAnsi(STR0005) + " "   	//"bens em ate 5 (cinco) moedas."
Local aOrd	  := { OemToAnsi(STR0006), OemToAnsi(STR0007), OemToAnsi(STR0008), OemToAnsi(STR0009) }//"Conta"##"C Custo"##"Item Contแbil"##"Classe de Valor"
Local bReport := {}

cPerg := IIf(Type('cPerg') == 'C', cPerg, 'AFR072')

If MV_PAR02 == 1 // Analํtico
	bReport := { |oReport|	oReport:SetTitle( oReport:Title() + OemtoAnsi(STR0010) + aOrd[oSecEntCtb:GetOrder()] + STR0011 ),;//" por "##" Analํtico "
	PrtAnalitico( oReport ) }
ElseIf MV_PAR02 == 2 // Sintetico por COnta
	bReport := { |oReport|	oReport:SetTitle( oReport:Title() + OemtoAnsi(STR0010) + aOrd[oSecEntCtb:GetOrder()] + STR0012 ),;//" por "##" Sint้tico por Conta "
	PrtSintConta( oReport ) }
Else // Sintetico por Bem
	bReport := { |oReport|	oReport:SetTitle( oReport:Title() + OemtoAnsi(STR0010) + aOrd[oSecEntCtb:GetOrder()] + STR0013 ),;//" por "##" Sint้tico por Bem "
	PrtSintBem( oReport ) }
EndIf

oReport  := TReport():New( cReport, cTitulo, cPerg, bReport, cDescri )

oSecEntCtb := TRSection():New( oReport, STR0014 ,{}, aOrd ) // "Entidade Contabil"
TRCell():New( oSecEntCtb, "ENTIDADES"	, "", "C๓digo Entidade" /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecEntCtb, "DESCENTID"	, "", "Descri็ใo"/*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,,.T.)
oSecEntCtb:SetHeaderSection(.F.)

oSecBem := TRSection():New( oSecEntCtb,  STR0015 ) // "Dados da Entidade"
TRCell():New( oSecBem, "N3_FILIAL"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_CBASE"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_ITEM"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_TIPO"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_TIPODESC", "", STR0016, /*Picture*/,14,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,,.T.,,,) //"Descri็ใo Tipo"

//Incluido por Jair Ribeiro em 29/04/11
TRCell():New( oSecBem, "N3_TPDEPR"	,""		,OEMTOANSI(STR0044)	,									,14,,,,.T.,,,,.T.) 

TRCell():New( oSecBem, "N1_PATRIM"	, "SN1", /*X3Titulo*/, /*Picture*/, 14 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,,.T.)
TRCell():New( oSecBem, "N1_DESCRIC"	, "SN1", /*X3Titulo*/, /*Picture*/, 14 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,,.T.)
TRCell():New( oSecBem, "N1_AQUISIC"	, "SN1", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N1_BAIXA"	, "SN1", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N1_QUANTD"	, "SN1", /*X3Titulo*/, PesqPict("SN1","N1_QUANTD",11) /*Picture*/, 11 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N1_CHAPA"	, "SN1", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_TPSALDO"	, "SN3", /*X3Titulo*/, /*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_CCONTAB"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_CUSTBEM"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_SUBCCON"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_CLVLCON"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSecBem:SetHeaderPage(.T.)

oSecValores := TRSection():New( oSecEntCtb, "Valores") // "Valores"
TRCell():New( oSecValores, "SIMBMOEDA"		, ""	 , STR0027 /*X3Titulo*/, "" /*Picture*/, 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Moeda"
TRCell():New( oSecValores, "N3_VORIG1"	   	, "", STR0017/*X3Titulo*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Original"
TRCell():New( oSecValores, "N3_AMPLIA1"		, "SN3", STR0018 /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)// "Val Amplia"
TRCell():New( oSecValores, "VLATUALIZADO"	, "", STR0019 /*X3Titulo*/, PesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oSecValores, "N3_VRDACM1"		, "", STR0020 /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. Acumulada"
TRCell():New( oSecValores, "VLRESIDUAL"		, "", STR0021 /*X3Titulo*/, PesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oSecValores, "N3_VRCDA1"		, "SN3", /*X3Titulo*/, /*Picture*/, 17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecValores, "N3_VRCACM1"		, "SN3", /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSecValores:SetHeaderPage(.T.)
oSecValores:Cell("N3_VORIG1"):SetHeaderAlign("RIGHT")
oSecValores:Cell("N3_AMPLIA1"):SetHeaderAlign("RIGHT")
oSecValores:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")
oSecValores:Cell("N3_VRDACM1"):SetHeaderAlign("RIGHT")
oSecValores:Cell("VLRESIDUAL"):SetHeaderAlign("RIGHT")
oSecValores:Cell("N3_VRCDA1"):SetHeaderAlign("RIGHT")
oSecValores:Cell("N3_VRCACM1"):SetHeaderAlign("RIGHT")


oTxtSubtotal  := TRSection():New( oSecEntCtb, STR0022 ) //"Texto Sub-total"
TRCell():New( oTxtSubtotal, "FILIAL"		, "",  STR0023 /*X3Titulo*/, /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTxtSubtotal, "ENTIDADE"	, "" ,  STR0024 /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Entidade"
TRCell():New( oTxtSubtotal, "QUANTIDADE"	, "" , STR0025 /*X3Titulo*/, "" /*Picture*/, 20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // Quantidade
oTxtSubtotal:SetHeaderSection(.F.)
oTxtSubtotal:SetLeftMargin(7)

oSubTotal  := TRSection():New( oSecEntCtb, STR0026) //"Valores Sub-total"
TRCell():New( oSubTotal, "SIMBMOEDA"		, ""	 , STR0027 /*X3Titulo*/, "" /*Picture*/, 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Moeda"
TRCell():New( oSubTotal, "N3_VORIG1"	   	, "", STR0017/*X3Titulo*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Original"
TRCell():New( oSubTotal, "N3_AMPLIA1"		, "SN3", STR0018/*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSubTotal, "VLATUALIZADO"	, "", STR0019 /*X3Titulo*/, PesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oSubTotal, "N3_VRDACM1"		, "", STR0020 /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. Acumulada"
TRCell():New( oSubTotal, "VLRESIDUAL"		, "", STR0021 /*X3Titulo*/, PesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oSubTotal, "N3_VRCDA1"		, "SN3", /*X3Titulo*/, /*Picture*/, 17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSubTotal, "N3_VRCACM1"		, "SN3", /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSubTotal:SetHeaderSection(.F.)
oSubTotal:Cell("N3_VORIG1"):SetHeaderAlign("RIGHT")
oSubTotal:Cell("N3_AMPLIA1"):SetHeaderAlign("RIGHT")
oSubTotal:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")
oSubTotal:Cell("N3_VRDACM1"):SetHeaderAlign("RIGHT")
oSubTotal:Cell("VLRESIDUAL"):SetHeaderAlign("RIGHT")
oSubTotal:Cell("N3_VRCDA1"):SetHeaderAlign("RIGHT")
oSubTotal:Cell("N3_VRCACM1"):SetHeaderAlign("RIGHT")

oTxtTotGer  := TRSection():New( oReport, STR0028 ) // "Texto Total Geral"
TRCell():New( oTxtTotGer, "TEXTO"	, "", STR0029  /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Total Geral"
TRCell():New( oTxtTotGer, "QUANTIDADE"	 , ""	 , STR0025 /*X3Titulo*/, "" /*Picture*/, 20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Quantidade"
oTxtTotGer:SetHeaderSection(.F.)
oTxtTotGer:SetLeftMargin(7)

oTotalGeral := TRSection():New( oReport, STR0030) // "Valores do Total Geral"
TRCell():New( oTotalGeral, "SIMBMOEDA"		, ""	 , STR0027 /*X3Titulo*/, "" /*Picture*/, 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Moeda"
TRCell():New( oTotalGeral, "N3_VORIG1"	   	, "", STR0017/*X3Titulo*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Original"
TRCell():New( oTotalGeral, "N3_AMPLIA1"		, "SN3", STR0018/*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotalGeral, "VLATUALIZADO"	, "", STR0019 /*X3Titulo*/, PesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oTotalGeral, "N3_VRDACM1"		, "", STR0020 /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. Acumulada"
TRCell():New( oTotalGeral, "VLRESIDUAL"		, "", STR0021 /*X3Titulo*/, PesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oTotalGeral, "N3_VRCDA1"		, "SN3", /*X3Titulo*/, /*Picture*/, 17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotalGeral, "N3_VRCACM1"		, "SN3", /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oTotalGeral:SetHeaderSection(.F.)
oTotalGeral:Cell("N3_VORIG1"):SetHeaderAlign("RIGHT")
oTotalGeral:Cell("N3_AMPLIA1"):SetHeaderAlign("RIGHT")
oTotalGeral:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")
oTotalGeral:Cell("N3_VRDACM1"):SetHeaderAlign("RIGHT")
oTotalGeral:Cell("VLRESIDUAL"):SetHeaderAlign("RIGHT")
oTotalGeral:Cell("N3_VRCDA1"):SetHeaderAlign("RIGHT")
oTotalGeral:Cell("N3_VRCACM1"):SetHeaderAlign("RIGHT")

oTxtFiscal   := TRSection():New( oReport, STR0031 )//"Total Fiscal"
TRCell():New( oTxtFiscal, "TEXTO"	, "", STR0031 /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)//"Total Fiscal"
oTxtFiscal:SetHeaderSection(.F.)
oTxtFiscal:SetLeftMargin(7)

oTxtGerencial   := TRSection():New( oReport, STR0032 )//"Total Gerencial"
TRCell():New( oTxtGerencial, "TEXTO"	, "",  STR0032 /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)//"Total Gerencial"
oTxtGerencial:SetHeaderSection(.F.)
oTxtGerencial:SetLeftMargin(7)

oTxtIncentivada   := TRSection():New( oReport, STR0033 )//"Total Por Filial"
TRCell():New( oTxtIncentivada, "TEXTO"	, "", STR0033  /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)//"Total Por Filial"
oTxtIncentivada:SetHeaderSection(.F.)
oTxtIncentivada:SetLeftMargin(7)

oTxtFilial   := TRSection():New( oReport, STR0033 )//"Total Incentivada"
TRCell():New( oTxtFilial, "TEXTO"	, "", STR0033  /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)//"Total Incentivada"
oTxtFilial:SetHeaderSection(.F.)
oTxtFilial:SetLeftMargin(7)

oSecEntCtb:SetColSpace(2)
oSecValores:SetColSpace(0)
oSubTotal:SetColSpace(0)
oTotalGeral:SetColSpace(0)
oReport:SetLandScape()
oReport:ParamReadOnly()
oReport:DisableOrientation()

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrtSintContaบAutor  ณAlvaro Camillo Neto บ Data ณ  28/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImpressใo do relat๓rio Sint้tico por Conta                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR072                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrtSintConta( oReport )
Local oSecEntCtb	 := oReport:Section(1)
Local oSecBem		 := oReport:Section(1):Section(1)
Local oSecValores	 := oReport:Section(1):Section(2)
Local oTxtSubtotal 	 := oReport:Section(1):Section(3)
Local oSubtotal 	 := oReport:Section(1):Section(4)
Local oTxtTotGer	 := oReport:Section(2)
Local oTotalGeral	 := oReport:Section(3)
Local oTxtFiscal	 := oReport:Section(4)
Local oTxtGerencial	 := oReport:Section(5)
Local oTxtIncentivada:= oReport:Section(6)

Local oMeter
Local oText
Local oDlg
Local lEnd
Local cTabName := ""
Local cAliasQry 	:= GetNextAlias()
Local cAliasTRB 	:= CriaTrab(,.F.)
Local dDataSLD  	:= MV_PAR01
Local dAquIni		:= MV_PAR04
Local dAquFim   	:= MV_PAR05
Local cBemIni   	:= MV_PAR06
Local cBemFim   	:= MV_PAR08
Local cItemIni  	:= MV_PAR07
Local cItemFim  	:= MV_PAR09
Local cContaIni 	:= MV_PAR12
Local cContaFim 	:= MV_PAR13
Local cCCIni   		:= MV_PAR14
Local cCCFim   		:= MV_PAR15
Local cItCtbIni		:= MV_PAR16
Local cItCtbFim		:= MV_PAR17
Local cClvlIni		:= MV_PAR18
Local cClVlFim		:= MV_PAR19
Local cGrupoIni		:= MV_PAR10
Local cGrupoFim		:= MV_PAR11
Local n_pagini 		:= MV_PAR21
Local n_pagFim		:= MV_PAR22
Local n_pagRes		:= MV_PAR23
Local nTipoTotal	:= MV_PAR24
Local cTipoSLD		:= MV_PAR25
Local cChave		:= ""
Local cCond			:= ""
Local aGerFiscal 	:= {}
Local aGerGerencial := {}
Local aGerIncentivada:= {}
Local nX			:= 0
Local cCabCond1 	:= ""
Local cQuery		:= ""
Local cArqAux

Local nTipoEnt 		:= oSecEntCtb:GetOrder()
Local aValorFis		:= {}
Local aValorGer		:= {}
Local aValorInc		:= {}
Local aTipo			:= {}
Local cTipoFiscal	:= ATFXTpBem(1)
Local cTipoGerenc	:= ATFXTpBem(2)
Local cTipoIncent	:= ATFXTpBem(3)

Local lRealProv	:= .T.

aSelMoed := IIF(Empty(aSelMoed), {"01"} , aSelMoed )

If nTipoTotal == 1 //Fiscal
	aTipo := ATFXTpBem(1,.T.)
ElseIf nTipoTotal == 2 //Gerencial
	aTipo := ATFXTpBem(2,.T.)
ElseIf nTipoTotal == 3 //Incentivada
	aTipo := ATFXTpBem(3,.T.)
EndIf

oSecValores:Cell("SIMBMOEDA"):SetTitle("")
oSubTotal:Cell("SIMBMOEDA"):SetTitle("")
oTotalGeral:Cell("SIMBMOEDA"):SetTitle("")

//Ordem do Arquivo
IF nTipoEnt == 1
	cChave := "FILIAL+CONTA+CCUSTO+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("Conta   : ") //"Conta   : "
	cCpoEnt := "CONTA"
ElseIf nTipoEnt == 2
	cChave := "FILIAL+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("C.Custo : ") //"C.Custo : "
	cCpoEnt := "CCUSTO"
ElseIf nTipoEnt == 3
	cChave := "FILIAL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("It.Ctb. : ") //"It.Ctb. : "
	cCpoEnt := "SUBCTA"
ElseIf nTipoEnt == 4
	cChave := "FILIAL+CLVL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("Clv.Vlr. : ") //"Clv.Vlr. : "
	cCpoEnt := "CLVL"
End

//Controle de reincio da numeracao de paginas
oReport:SetPageNumber(n_pagini)
oReport:OnPageBreak( {|| If((n_pagini+1) > n_pagFim, (n_pagini := n_pagRes,oReport:SetPageNumber(n_pagini-1)),n_pagini += 1) } )

/*
 * Verifica็ใo do campo para ativos de custo de provisใo
 */
DbSelectArea("SN3")

lRealProv := MV_PAR27 == 1

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao						 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
ATFGERSLDM(oMeter,oText,oDlg,lEnd,@cAliasTRB,dAquIni,dAquFim,dDataSLD,cBemIni,cBemFim,cItemIni,cItemFim,cContaIni,cContaFim,;
cCCIni,cCCFim,cItCtbIni,cItCtbFim,cClvlIni,cClVlFim,cGrupoIni,cGrupoFim,aSelMoed,aSelFil,lTodasFil,cChave,.T.,aTipo,Nil,Nil,cTipoSLD,aSelClass,lRealProv,@cTabName) },;
OemToAnsi(OemToAnsi(STR0034)),; //"Criando Arquivo Temporแrio..."
OemToAnsi(STR0035))//"Posicao Valorizada dos Bens na Data"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ฟ
//ณEstrutura do Arquivoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ู
/*
FILIAL CBASE ITEM MOEDA	CLASSIF TIPO DESC_SINT AQUISIC DTBAIXA DTSALDO CHAPA GRUPO CONTA CCUSTO SUBCTA CLVL QUANTD ORIGINAL AMPLIACAO ATUALIZ DEPRECACM
RESIDUAL CORRECACM CORDEPACM VLBAIXAS
*/
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณSele็ใo do arquivo agrupando por bemณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cTabName := strTran(cTabName,"dbo.","")

cQuery += " SELECT "
cQuery += " 	FILIAL, "
cQuery += cCpoEnt

cQuery += " FROM " + cTabName

cQuery += " GROUP BY   "
cQuery += " 	FILIAL,  "
cQuery += cCpoEnt

cQuery := ChangeQuery(cQuery )
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasQry , .T. , .F.)


// Orderna de acordo com a Ordem do relatorio
(cAliasQry)->(dbGoTop())
While (cAliasQry)->(!EOF()) .And. !oReport:Cancel()
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Controla a quebra no 1o. nivel                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cFilQbr1 := (cAliasQry)->FILIAL
	
	IF nTipoEnt == 1
		cEntidade := (cAliasQry)->CONTA
	ElseIf nTipoEnt == 2
		cEntidade := (cAliasQry)->CCUSTO
	ElseIf nTipoEnt == 3
		cEntidade := (cAliasQry)->SUBCTA
	ElseIf nTipoEnt == 4
		cEntidade :=  (cAliasQry)->CLVL
	EndIf
	
	aValorFis 	:= {}
	aValorGer	:= {}
	aValorInc	:= {}
	
	If nTipoTotal == 1 .Or. nTipoTotal == 4
		aValorFis		:= TotalCtb(cTabName,(cAliasQry)->FILIAL,nTipoEnt,cEntidade,cTipoFiscal)
	EndIf
	If nTipoTotal == 2 .Or. nTipoTotal == 4
		aValorGer		:= TotalCtb(cTabName,(cAliasQry)->FILIAL,nTipoEnt,cEntidade,cTipoGerenc)
	EndIf
	If nTipoTotal == 3 .Or. nTipoTotal == 4
   		aValorInc		:= TotalCtb(cTabName,(cAliasQry)->FILIAL,nTipoEnt,cEntidade,cTipoIncent)
	EndIf
	
	If Empty(aValorFis) .And. Empty(aValorGer) .And. Empty(aValorInc)
		(cAliasQry)->(dbSkip())
		Loop
	EndIf
	
	cDescr 	:= AFR072Desc( nTipoEnt, cFilQbr1 , cEntidade )
	cDescrFil:= GetAdvFval("SM0","M0_FILIAL",cEmpAnt + cFilQbr1 )
	oTxtSubtotal:Cell("FILIAL"):SetBlock({|| OemToAnsi(STR0035) + " : " + cFilQbr1 + " - " + cDescrFil } )//"Filial"
	oTxtSubtotal:Cell("ENTIDADE"):SetBlock( { || OemToAnsi(STR0036) + cCabCond1 + cDescr } )//"TOTAL "
	oTxtSubtotal:Finish()
	
	
	If Len(aValorFis) > 0
		oTxtFiscal:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0037) } )//"TOTAL FISCAL "
		
		oTxtFiscal:Init()
		oTxtFiscal:PrintLine()
		oSecValores:Init()
		
		For nX := 1 To Len(aValorFis)
			cMoeda	:= aValorFis[nX][1]
			cSuf 	:= CValtoChar(Val( cMoeda ))
			oSecValores:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
			oSecValores:Cell("N3_VORIG1"):SetBlock( 	{ || aValorFis[nX][2] } )
			oSecValores:Cell("N3_AMPLIA1"):SetBlock( 	{ || aValorFis[nX][3] } )
			oSecValores:Cell("VLATUALIZADO"):SetBlock(	{ || aValorFis[nX][4] } )
			oSecValores:Cell("N3_VRDACM1"):SetBlock( 	{ || aValorFis[nX][5] } )
			oSecValores:Cell("VLRESIDUAL"):SetBlock( 	{ || aValorFis[nX][6] } )
			oSecValores:Cell("N3_VRCDA1"):SetBlock( 	{ || aValorFis[nX][8] } )
			oSecValores:Cell("N3_VRCACM1"):SetBlock( 	{ || aValorFis[nX][7] } )
			oSecValores:PrintLine()
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
			//ณSoma os totais da quebraณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
			nPos := aScan(aGerFiscal,{ |x| Alltrim(x[1]) == Alltrim(cMoeda)})
			If nPos == 0
				AAdd(aGerFiscal, { "", 0, 0, 0, 0, 0, 0, 0 } )
				nPos := Len(aGerFiscal)
				aGerFiscal[nPos][1] := cMoeda
			EndIf
			aGerFiscal[nPos][2] += aValorFis[nX][2]
			aGerFiscal[nPos][3] += aValorFis[nX][3]
			aGerFiscal[nPos][4] += aValorFis[nX][4]
			aGerFiscal[nPos][5] += aValorFis[nX][5]
			aGerFiscal[nPos][6] += aValorFis[nX][6]
			aGerFiscal[nPos][7] += aValorFis[nX][8]
			aGerFiscal[nPos][8] += aValorFis[nX][7]
		Next
		oTxtFiscal:Finish()
		oSecValores:Finish()
	EndIf
	
	
	If Len(aValorGer) > 0
		oTxtGerencial:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0038) } )//"TOTAL GERENCIAL "
		
		oTxtGerencial:Init()
		oTxtGerencial:PrintLine()
		oSecValores:Init()
		
		For nX := 1 To Len(aValorGer)
			cMoeda	:= aValorGer[nX][1]
			cSuf 	:= CValtoChar(Val( cMoeda ))
			oSecValores:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
			oSecValores:Cell("N3_VORIG1"):SetBlock( 	{ || aValorGer[nX][2] } )
			oSecValores:Cell("N3_AMPLIA1"):SetBlock( 	{ || aValorGer[nX][3] } )
			oSecValores:Cell("VLATUALIZADO"):SetBlock(	{ || aValorGer[nX][4] } )
			oSecValores:Cell("N3_VRDACM1"):SetBlock( 	{ || aValorGer[nX][5] } )
			oSecValores:Cell("VLRESIDUAL"):SetBlock( 	{ || aValorGer[nX][6] } )
			oSecValores:Cell("N3_VRCDA1"):SetBlock( 	{ || aValorGer[nX][8] } )
			oSecValores:Cell("N3_VRCACM1"):SetBlock( 	{ || aValorGer[nX][7] } )
			oSecValores:PrintLine()
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
			//ณSoma os totais da quebraณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
			nPos := aScan(aGerGerencial,{ |x| Alltrim(x[1]) == Alltrim(cMoeda)})
			If nPos == 0
				AAdd(aGerGerencial, { "", 0, 0, 0, 0, 0, 0, 0 } )
				nPos := Len(aGerGerencial)
				aGerGerencial[nPos][1] := cMoeda
			EndIf
			aGerGerencial[nPos][2] += aValorGer[nX][2]
			aGerGerencial[nPos][3] += aValorGer[nX][3]
			aGerGerencial[nPos][4] += aValorGer[nX][4]
			aGerGerencial[nPos][5] += aValorGer[nX][5]
			aGerGerencial[nPos][6] += aValorGer[nX][6]
			aGerGerencial[nPos][7] += aValorGer[nX][8]
			aGerGerencial[nPos][8] += aValorGer[nX][7]
			
		Next
		oTxtGerencial:Finish()
		oSecValores:Finish()
	EndIf
	
	If Len(aValorInc) > 0
		
		oTxtIncentivada:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0039) } )//"TOTAL INCENTIVADA "
		
		oTxtIncentivada:Init()
		oTxtIncentivada:PrintLine()
		oSecValores:Init()
		
		For nX := 1 To Len(aValorInc)
			cMoeda	:= aValorInc[nX][1]
			cSuf 	:= CValtoChar(Val( cMoeda ))
			oSecValores:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
			oSecValores:Cell("N3_VORIG1"):SetBlock( 	{ || aValorInc[nX][2] } )
			oSecValores:Cell("N3_AMPLIA1"):SetBlock( 	{ || aValorInc[nX][3] } )
			oSecValores:Cell("VLATUALIZADO"):SetBlock(	{ || aValorInc[nX][4] } )
			oSecValores:Cell("N3_VRDACM1"):SetBlock( 	{ || aValorInc[nX][5] } )
			oSecValores:Cell("VLRESIDUAL"):SetBlock( 	{ || aValorInc[nX][6] } )
			oSecValores:Cell("N3_VRCDA1"):SetBlock( 	{ || aValorInc[nX][8] } )
			oSecValores:Cell("N3_VRCACM1"):SetBlock( 	{ || aValorInc[nX][7] } )
			oSecValores:PrintLine()
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
			//ณSoma os totais da quebraณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
			nPos := aScan(aGerIncentivada,{ |x| Alltrim(x[1]) == Alltrim(cMoeda)})
			If nPos == 0
				AAdd(aGerIncentivada, { "", 0, 0, 0, 0, 0, 0, 0 } )
				nPos := Len(aGerIncentivada)
				aGerIncentivada[nPos][1] := cMoeda
			EndIf
			aGerIncentivada[nPos][2] += aValorInc[nX][2]
			aGerIncentivada[nPos][3] += aValorInc[nX][3]
			aGerIncentivada[nPos][4] += aValorInc[nX][4]
			aGerIncentivada[nPos][5] += aValorInc[nX][5]
			aGerIncentivada[nPos][6] += aValorInc[nX][6]
			aGerIncentivada[nPos][7] += aValorInc[nX][8]
			aGerIncentivada[nPos][8] += aValorInc[nX][7]
		Next
		oTxtIncentivada:Finish()
		oSecValores:Finish()
	EndIf
	
	oTxtSubtotal:Init()
	oTxtSubtotal:PrintLine()
	
	(cAliasQry)->(dbSKip())
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Efetua a impressao da totalizacao na quebra do segundo nivel        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If Len(aGerFiscal) > 0 .Or. Len(aGerGerencial) > 0  .Or. Len(aGerIncentivada) > 0
	oReport:SkipLine()
	oReport:ThinLine()
	oTxtTotGer:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0040) } ) // "* * *   T O T A L   G E R A L   * * *"
	
	oTxtTotGer:Init()
	oTxtTotGer:PrintLine()
	
	If Len(aGerFiscal) > 0
		oTxtFiscal:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0037) } )//"TOTAL FISCAL "
		oTxtFiscal:Init()
		oTxtFiscal:PrintLine()
		
		oTotalGeral:Init()
		For nX := 1 To Len(aGerFiscal)
			cMoeda	:= aGerFiscal[nX][1]
			cSuf 	:= CValtoChar(Val( cMoeda ))
			
			oTotalGeral:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
			oTotalGeral:Cell("N3_VORIG1"):SetBlock( 	{ || aGerFiscal[nX][2] } )
			oTotalGeral:Cell("N3_AMPLIA1"):SetBlock( 	{ || aGerFiscal[nX][3] } )
			oTotalGeral:Cell("VLATUALIZADO"):SetBlock({ || aGerFiscal[nX][4] } )
			oTotalGeral:Cell("N3_VRDACM1"):SetBlock( 	{ || aGerFiscal[nX][5] } )
			oTotalGeral:Cell("VLRESIDUAL"):SetBlock( 	{ || aGerFiscal[nX][6] } )
			oTotalGeral:Cell("N3_VRCDA1"):SetBlock( 	{ || aGerFiscal[nX][7] } )
			oTotalGeral:Cell("N3_VRCACM1"):SetBlock( 	{ || aGerFiscal[nX][8] } )
			
			oTotalGeral:PrintLine()
		Next
		oTotalGeral:Finish()
	EndIf
	
	If Len(aGerGerencial) > 0
		oTxtGerencial:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0038) } ) //"TOTAL GERENCIAL "
		oTxtGerencial:Init()
		oTxtGerencial:PrintLine()
		
		oTotalGeral:Init()
		For nX := 1 To Len(aGerGerencial)
			cMoeda	:= aGerGerencial[nX][1]
			cSuf 	:= CValtoChar(Val( cMoeda ))
			
			oTotalGeral:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
			oTotalGeral:Cell("N3_VORIG1"):SetBlock( 	{ || aGerGerencial[nX][2] } )
			oTotalGeral:Cell("N3_AMPLIA1"):SetBlock( 	{ || aGerGerencial[nX][3] } )
			oTotalGeral:Cell("VLATUALIZADO"):SetBlock({ || aGerGerencial[nX][4] } )
			oTotalGeral:Cell("N3_VRDACM1"):SetBlock( 	{ || aGerGerencial[nX][5] } )
			oTotalGeral:Cell("VLRESIDUAL"):SetBlock( 	{ || aGerGerencial[nX][6] } )
			oTotalGeral:Cell("N3_VRCDA1"):SetBlock( 	{ || aGerGerencial[nX][7] } )
			oTotalGeral:Cell("N3_VRCACM1"):SetBlock( 	{ || aGerGerencial[nX][8] } )
			
			oTotalGeral:PrintLine()
		Next
		oTotalGeral:Finish()
	EndIf
	
	If Len(aGerIncentivada) > 0
		oTxtIncentivada:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0039) } )//"TOTAL INCENTIVADA "
		oTxtIncentivada:Init()
		oTxtIncentivada:PrintLine()
		
		oTotalGeral:Init()
		For nX := 1 To Len(aGerIncentivada)
			cMoeda	:= aGerIncentivada[nX][1]
			cSuf 	:= CValtoChar(Val( cMoeda ))
			
			oTotalGeral:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
			oTotalGeral:Cell("N3_VORIG1"):SetBlock( 	{ || aGerIncentivada[nX][2] } )
			oTotalGeral:Cell("N3_AMPLIA1"):SetBlock( 	{ || aGerIncentivada[nX][3] } )
			oTotalGeral:Cell("VLATUALIZADO"):SetBlock({ || aGerIncentivada[nX][4] } )
			oTotalGeral:Cell("N3_VRDACM1"):SetBlock( 	{ || aGerIncentivada[nX][5] } )
			oTotalGeral:Cell("VLRESIDUAL"):SetBlock( 	{ || aGerIncentivada[nX][6] } )
			oTotalGeral:Cell("N3_VRCDA1"):SetBlock( 	{ || aGerIncentivada[nX][7] } )
			oTotalGeral:Cell("N3_VRCACM1"):SetBlock( 	{ || aGerIncentivada[nX][8] } )
			
			oTotalGeral:PrintLine()
			
		Next
		oTotalGeral:Finish()
	EndIf
	oTxtTotGer:Finish()
EndIf

If Select(cAliasTRB) > 0
	dbSelectArea(cAliasTRB)
	cArqAux := (cAliasTRB)->(dbInfo(DBI_FULLPATH))
	cArqAux := AllTrim(Substr(cArqAux,RAT("\",cArqAux)+1))
	DbCloseArea()
	MsErase(cArqAux)
EndIf

(cAliasQry)->(dbCloseArea())

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrtSintBemบAutor  ณAlvaro Camillo Neto บ Data ณ  28/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImpressใo do relat๓rio Sint้tico por Bem                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR072                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrtSintBem( oReport )
Local oSecEntCtb	 := oReport:Section(1)
Local oSecBem		 := oReport:Section(1):Section(1)
Local oSecValores	 := oReport:Section(1):Section(2)
Local oTxtSubtotal 	 := oReport:Section(1):Section(3)
Local oSubtotal 	 := oReport:Section(1):Section(4)
Local oTxtTotGer	 := oReport:Section(2)
Local oTotalGeral	 := oReport:Section(3)
Local oTxtFiscal	 := oReport:Section(4)
Local oTxtGerencial	 := oReport:Section(5)
Local oTxtIncentivada:= oReport:Section(6)

Local oMeter
Local oText
Local oDlg
Local lEnd
Local cAliasQry 	:= GetNextAlias()
Local dDataSLD  	:= MV_PAR01
Local dAquIni		:= MV_PAR04
Local dAquFim   	:= MV_PAR05
Local cBemIni   	:= MV_PAR06
Local cBemFim   	:= MV_PAR08
Local cItemIni  	:= MV_PAR07
Local cItemFim  	:= MV_PAR09
Local cContaIni 	:= MV_PAR12
Local cContaFim 	:= MV_PAR13
Local cCCIni   		:= MV_PAR14
Local cCCFim   		:= MV_PAR15
Local cItCtbIni		:= MV_PAR16
Local cItCtbFim		:= MV_PAR17
Local cClvlIni		:= MV_PAR18
Local cClVlFim		:= MV_PAR19
Local cGrupoIni		:= MV_PAR10
Local cGrupoFim		:= MV_PAR11
Local n_pagini 		:= MV_PAR21
Local n_pagFim		:= MV_PAR22
Local n_pagRes		:= MV_PAR23
Local nTipoTotal	:= MV_PAR24
Local cTipoSLD		:= MV_PAR25
Local cChave		:= ""
Local cCond			:= ""
Local aFiscal		:= {}
Local aGerencial	:= {}
Local aIncentivada	:= {}
Local aGerFiscal 	:= {}
Local aGerGerencial := {}
Local aGerIncentivada:= {}
Local aSubFiscal 	:= {}
Local aSubGerencial := {}
Local aSubIncentivada:= {}
Local aFilFiscal	:= {}
Local aFilGerencial	:= {}
Local aFilIncentivada:= {}
Local aDadosBem		:= {}
Local nX			:= 0
Local nTotal 	 	:= 0
Local nQuantidade 	:= 0
Local nQtdFil	 	:= 0
Local cCabCond1 	:= ""
Local nTipoEnt		:= oSecEntCtb:GetOrder()
Local aTipo			:= {}   
Local cChaveBem		:= ""
Local cTipoFiscal	:= ATFXTpBem(1)
Local cTipoGerenc   := ATFXTpBem(2)
Local cTipoIncent	:= ATFXTpBem(3)   
Local cDescSld		:= ""
Local cArqAux      := ""
Local lRealProv	:= .T.

aSelMoed := IIF(Empty(aSelMoed), {"01"} , aSelMoed )

If nTipoTotal == 1 //Fiscal
	aTipo := ATFXTpBem(1,.T.)
ElseIf nTipoTotal == 2 //Gerencial
	aTipo := ATFXTpBem(2,.T.)
ElseIf nTipoTotal == 3 //Incentivada
	aTipo := ATFXTpBem(3,.T.)
EndIf

oSecValores:Cell("SIMBMOEDA"):SetTitle("")
oSubTotal:Cell("SIMBMOEDA"):SetTitle("")

oTotalGeral:Cell("SIMBMOEDA"):SetTitle("")

//Ordem do Arquivo
IF nTipoEnt == 1
	cChave := "FILIAL+CONTA+CCUSTO+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("Conta   : ") //"Conta   : "
ElseIf nTipoEnt == 2
	cChave := "FILIAL+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("C.Custo : ") //"C.Custo : "
ElseIf nTipoEnt == 3
	cChave := "FILIAL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("It.Ctb. : ") //"It.Ctb. : "
ElseIf nTipoEnt == 4
	cChave := "FILIAL+CLVL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("Clv.Vlr. : ") //"Clv.Vlr. : "
End

//Controle de reincio da numeracao de paginas
oReport:SetPageNumber(n_pagini)
oReport:OnPageBreak( {|| If((n_pagini+1) > n_pagFim, (n_pagini := n_pagRes,oReport:SetPageNumber(n_pagini-1)),n_pagini += 1) } )

/*
 * Verifica็ใo do campo para ativos de custo de provisใo
 */
DbSelectArea("SN3")
If .T.
	lRealProv := MV_PAR27 == 1
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao						 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
ATFGERSLDM(oMeter,oText,oDlg,lEnd,cAliasQry,dAquIni,dAquFim,dDataSLD,cBemIni,cBemFim,cItemIni,cItemFim,cContaIni,cContaFim,;
cCCIni,cCCFim,cItCtbIni,cItCtbFim,cClvlIni,cClVlFim,cGrupoIni,cGrupoFim,aSelMoed,aSelFil,lTodasFil,cChave,.T.,aTipo,Nil,Nil,cTipoSLD,aSelClass,lRealProv) },;
OemToAnsi(OemToAnsi(STR0034)),; //"Criando Arquivo Temporแrio..."
OemToAnsi(STR0035))//"Posicao Valorizada dos Bens na Data"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ฟ
//ณEstrutura do Arquivoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ู
/*
FILIAL CBASE ITEM MOEDA	CLASSIF TIPO DESC_SINT AQUISIC DTBAIXA DTSALDO CHAPA GRUPO CONTA CCUSTO SUBCTA CLVL QUANTD ORIGINAL AMPLIACAO ATUALIZ DEPRECACM
RESIDUAL CORRECACM CORDEPACM VLBAIXAS
*/


//Descri็ใo do tipo de saldo
SX5->(MsSeek(xFilial("SX5") + "SL"+ IIF(Empty(cTipoSLD),'1',cTipoSLD) ))
cDescSld := Alltrim(SX5->(X5Descri()))


// Orderna de acordo com a Ordem do relatorio
(cAliasQry)->(dbGoTop())
While (cAliasQry)->(!EOF()) .And. !oReport:Cancel()
	
	nQuantidade := 0
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Controla a quebra no 1o. nivel                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cFilQbr1 := (cAliasQry)->FILIAL
	IF nTipoEnt == 1
		cEntQbr1 := (cAliasQry)->CONTA
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->( FILIAL + CONTA ) == cQuebra1"
	ElseIf nTipoEnt == 2
		cEntQbr1 := (cAliasQry)->CCUSTO
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->( FILIAL + CCUSTO ) == cQuebra1"
	ElseIf nTipoEnt == 3
		cEntQbr1 := (cAliasQry)->SUBCTA
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->( FILIAL + SUBCTA ) == cQuebra1"
	ElseIf nTipoEnt == 4
		cEntQbr1 :=  (cAliasQry)->CLVL
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->( FILIAL + CLVL ) == cQuebra1"
	EndIf
	
	dbSelectArea(cAliasQry)
	
	IF Empty(cEntQbr1)
		(cAliasQry)->(dbSkip())
		Loop
	EndIf
	
	lDescricao 		:= .F.
	aSubFiscal 		:= {}
	aSubGerencial 	:= {}
	aSubIncentivada := {}
	
	While (cAliasQry)->(!Eof()) .AND. &cCond1 .And. !oReport:Cancel()
		aFiscal 	:= {}
		aGerencial	:= {}
		aIncentivada:= {}
		
		If !lDescricao
			AFR072Cab(nTipoEnt,cFilQbr1,cEntQbr1, oReport)
			lDescricao := .T.
		EndIf
		
		If AllTrim(cChaveBem) != AllTrim((cAliasQry)->FILIAL + (cAliasQry)->CBASE + (cAliasQry)->ITEM)  
			cChaveBem := (cAliasQry)->FILIAL + (cAliasQry)->CBASE + (cAliasQry)->ITEM   
			nQuantidade += (cAliasQry)->QUANTD  
			nQtdFil+= (cAliasQry)->QUANTD   
		EndIf

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Controla a quebra no 2o. nivel                                         ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		aDadosBem := {}
		aAdd(aDadosBem, (cAliasQry)->FILIAL ) 
		aAdd(aDadosBem, (cAliasQry)->CBASE ) 
		aAdd(aDadosBem, (cAliasQry)->ITEM ) 
		aAdd(aDadosBem, X3ATF('N1_PATRIM',(cAliasQry)->CLASSIF)  ) 
		aAdd(aDadosBem, (cAliasQry)->DESC_SINT  ) 
		aAdd(aDadosBem,  (cAliasQry)->AQUISIC) 
		aAdd(aDadosBem, (cAliasQry)->DTBAIXA  ) 
		aAdd(aDadosBem, (cAliasQry)->QUANTD  ) 
		aAdd(aDadosBem, (cAliasQry)->CHAPA  ) 
		aAdd(aDadosBem, (cAliasQry)->CONTA  ) 
		aAdd(aDadosBem, (cAliasQry)->CCUSTO ) 
		aAdd(aDadosBem,  (cAliasQry)->SUBCTA ) 
		aAdd(aDadosBem, (cAliasQry)->CLVL ) 
		aAdd(aDadosBem, cDescSld  ) 		

		IF nTipoEnt == 1
			cQuebra2 :=  (cAliasQry)->( FILIAL+CONTA+CCUSTO+CBASE+ITEM )
			cCond2   := cAliasQry + "->( FILIAL+CONTA+CCUSTO+CBASE+ITEM ) == cQuebra2"
		ElseIf nTipoEnt == 2
			cQuebra2 :=  (cAliasQry)->( FILIAL+CCUSTO+CONTA+CBASE+ITEM )
			cCond2   := cAliasQry + "->( FILIAL+CCUSTO+CONTA+CBASE+ITEM ) == cQuebra2"
		ElseIf nTipoEnt == 3
			cQuebra2 :=  (cAliasQry)->( FILIAL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM )
			cCond2   := cAliasQry + "->( FILIAL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM ) == cQuebra2"
		ElseIf nTipoEnt == 4
			cQuebra2 := (cAliasQry)->( FILIAL+CLVL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM )
			cCond2   := cAliasQry + "->( FILIAL+CLVL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM ) == cQuebra2"
		EndIf

		While (cAliasQry)->(!Eof()) .AND. &cCond2 .And. !oReport:Cancel()
			If (nTipoTotal == 1 .Or. nTipoTotal == 4) .And. ( (cAliasQry)->TIPO $ cTipoFiscal )
				nPos := aScan(aFiscal,{ |x| Alltrim(x[1]) == Alltrim((cAliasQry)->MOEDA)})
				If nPos == 0
					AAdd(aFiscal, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aFiscal)
					aFiscal[nPos][1] := (cAliasQry)->MOEDA
				EndIf
				aFiscal[nPos][2] += (cAliasQry)->ORIGINAL
				aFiscal[nPos][3] += (cAliasQry)->AMPLIACAO
				aFiscal[nPos][4] += (cAliasQry)->ATUALIZ
				aFiscal[nPos][5] += (cAliasQry)->DEPRECACM
				aFiscal[nPos][6] += (cAliasQry)->RESIDUAL
				aFiscal[nPos][7] += (cAliasQry)->CORDEPACM
				aFiscal[nPos][8] += (cAliasQry)->CORRECACM
			EndIf
			
			If nTipoTotal == 2 .Or. nTipoTotal == 4 .And. (cAliasQry)->TIPO $ cTipoGerenc
				nPos := aScan(aGerencial,{ |x| Alltrim(x[1]) == Alltrim((cAliasQry)->MOEDA)})
				If nPos == 0
					AAdd(aGerencial, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aGerencial)
					aGerencial[nPos][1] := (cAliasQry)->MOEDA
				EndIf
				aGerencial[nPos][2] += (cAliasQry)->ORIGINAL
				aGerencial[nPos][3] += (cAliasQry)->AMPLIACAO
				aGerencial[nPos][4] += (cAliasQry)->ATUALIZ
				aGerencial[nPos][5] += (cAliasQry)->DEPRECACM
				aGerencial[nPos][6] += (cAliasQry)->RESIDUAL
				aGerencial[nPos][7] += (cAliasQry)->CORDEPACM
				aGerencial[nPos][8] += (cAliasQry)->CORRECACM
			EndIf
			
			If nTipoTotal == 3 .Or. nTipoTotal == 4 .And. ( (cAliasQry)->TIPO $ cTipoIncent )
				nPos := aScan(aIncentivada,{ |x| Alltrim(x[1]) == Alltrim((cAliasQry)->MOEDA)})
				If nPos == 0
					AAdd(aIncentivada, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aIncentivada)
					aIncentivada[nPos][1] := (cAliasQry)->MOEDA
				EndIf
				aIncentivada[nPos][2] += (cAliasQry)->ORIGINAL
				aIncentivada[nPos][3] += (cAliasQry)->AMPLIACAO
				aIncentivada[nPos][4] += (cAliasQry)->ATUALIZ
				aIncentivada[nPos][5] += (cAliasQry)->DEPRECACM
				aIncentivada[nPos][6] += (cAliasQry)->RESIDUAL
				aIncentivada[nPos][7] += (cAliasQry)->CORDEPACM
				aIncentivada[nPos][8] += (cAliasQry)->CORRECACM
			EndIf
			(cAliasQry)->(dbSkip())
		EndDo
		
		If Empty(aFiscal) .And. Empty(aGerencial) .And. Empty(aIncentivada)
			(cAliasQry)->(dbSkip())
			Loop
		Else
			oSecBem:Init()
			oSecBem:Cell("N3_FILIAL"):SetBlock({|| aDadosBem[1] } )
			oSecBem:Cell("N3_CBASE"):SetBlock({||  aDadosBem[2]  } )
			oSecBem:Cell("N3_ITEM"):SetBlock({||   aDadosBem[3]  } )
			oSecBem:Cell("N1_PATRIM"):SetBlock({|| aDadosBem[4]    } )
			oSecBem:Cell("N1_DESCRIC"):SetBlock({||aDadosBem[5]  } )
			oSecBem:Cell("N1_AQUISIC"):SetBlock({||aDadosBem[6]  } )
			oSecBem:Cell("N1_BAIXA"):SetBlock({||  aDadosBem[7]  } )
			oSecBem:Cell("N1_QUANTD"):SetBlock({|| aDadosBem[8]  } )
			oSecBem:Cell("N1_CHAPA"):SetBlock({||  aDadosBem[9]  } )
			oSecBem:Cell("N3_TPSALDO"):SetBlock({||aDadosBem[14]  } )
			oSecBem:Cell("N3_CCONTAB"):SetBlock({||aDadosBem[10]  } )
			oSecBem:Cell("N3_CUSTBEM"):SetBlock({||aDadosBem[11] } )
			oSecBem:Cell("N3_SUBCCON"):SetBlock({||aDadosBem[12]  } )
			oSecBem:Cell("N3_CLVLCON"):SetBlock({||aDadosBem[13]  } )
			oSecBem:Cell("N3_TIPO"):SetBlock({|| "" } )
			oSecBem:PrintLine()
			oSecBem:Finish()
		EndIf
		
		If Len(aFiscal) > 0
			oTxtFiscal:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0037) } )//"TOTAL FISCAL "
			
			oTxtFiscal:Init()
			oTxtFiscal:PrintLine()
			oSecValores:Init()
			
			For nX := 1 To Len(aFiscal)
				cMoeda	:= aFiscal[nX][1]
				cSuf 	:= CValtoChar(Val( cMoeda ))
				oSecValores:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
				oSecValores:Cell("N3_VORIG1"):SetBlock( 	{ || aFiscal[nX][2] } )
				oSecValores:Cell("N3_AMPLIA1"):SetBlock( 	{ || aFiscal[nX][3] } )
				oSecValores:Cell("VLATUALIZADO"):SetBlock(	{ || aFiscal[nX][4] } )
				oSecValores:Cell("N3_VRDACM1"):SetBlock( 	{ || aFiscal[nX][5] } )
				oSecValores:Cell("VLRESIDUAL"):SetBlock( 	{ || aFiscal[nX][6] } )
				oSecValores:Cell("N3_VRCDA1"):SetBlock( 	{ || aFiscal[nX][7] } )
				oSecValores:Cell("N3_VRCACM1"):SetBlock( 	{ || aFiscal[nX][8] } )
				oSecValores:PrintLine()
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
				//ณSoma os totais da quebraณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
				nPos := aScan(aSubFiscal,{ |x| Alltrim(x[1]) == Alltrim(cMoeda)})
				If nPos == 0
					AAdd(aSubFiscal, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aSubFiscal)
					aSubFiscal[nPos][1] := cMoeda
				EndIf
				aSubFiscal[nPos][2] += aFiscal[nX][2]
				aSubFiscal[nPos][3] += aFiscal[nX][3]
				aSubFiscal[nPos][4] += aFiscal[nX][4]
				aSubFiscal[nPos][5] += aFiscal[nX][5]
				aSubFiscal[nPos][6] += aFiscal[nX][6]
				aSubFiscal[nPos][7] += aFiscal[nX][7]
				aSubFiscal[nPos][8] += aFiscal[nX][8]
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
				//ณSoma os totais da filial ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
				nPos := aScan(aFilFiscal,{ |x| Alltrim(x[1]) == Alltrim(cMoeda)})
				If nPos == 0
					AAdd(aFilFiscal, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aFilFiscal)
					aFilFiscal[nPos][1] := cMoeda
				EndIf
				aFilFiscal[nPos][2] += aFiscal[nX][2]
				aFilFiscal[nPos][3] += aFiscal[nX][3]
				aFilFiscal[nPos][4] += aFiscal[nX][4]
				aFilFiscal[nPos][5] += aFiscal[nX][5]
				aFilFiscal[nPos][6] += aFiscal[nX][6]
				aFilFiscal[nPos][7] += aFiscal[nX][7]
				aFilFiscal[nPos][8] += aFiscal[nX][8]
			Next
			oTxtFiscal:Finish()
			oSecValores:Finish()
		EndIf
		
		
		If Len(aGerencial) > 0
			oTxtGerencial:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0038) } )//"TOTAL GERENCIAL "
			
			oTxtGerencial:Init()
			oTxtGerencial:PrintLine()
			oSecValores:Init()
			
			For nX := 1 To Len(aGerencial)
				cMoeda	:= aGerencial[nX][1]
				cSuf 	:= CValtoChar(Val( cMoeda ))
				oSecValores:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
				oSecValores:Cell("N3_VORIG1"):SetBlock( 	{ || aGerencial[nX][2] } )
				oSecValores:Cell("N3_AMPLIA1"):SetBlock( 	{ || aGerencial[nX][3] } )
				oSecValores:Cell("VLATUALIZADO"):SetBlock(	{ || aGerencial[nX][4] } )
				oSecValores:Cell("N3_VRDACM1"):SetBlock( 	{ || aGerencial[nX][5] } )
				oSecValores:Cell("VLRESIDUAL"):SetBlock( 	{ || aGerencial[nX][6] } )
				oSecValores:Cell("N3_VRCDA1"):SetBlock( 		{ || aGerencial[nX][7] } )
				oSecValores:Cell("N3_VRCACM1"):SetBlock( 	{ || aGerencial[nX][8] } )
				oSecValores:PrintLine()
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
				//ณSoma os totais da quebraณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
				nPos := aScan(aSubGerencial,{ |x| Alltrim(x[1]) == Alltrim(cMoeda)})
				If nPos == 0
					AAdd(aSubGerencial, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aSubGerencial)
					aSubGerencial[nPos][1] := cMoeda
				EndIf
				aSubGerencial[nPos][2] += aGerencial[nX][2]
				aSubGerencial[nPos][3] += aGerencial[nX][3]
				aSubGerencial[nPos][4] += aGerencial[nX][4]
				aSubGerencial[nPos][5] += aGerencial[nX][5]
				aSubGerencial[nPos][6] += aGerencial[nX][6]
				aSubGerencial[nPos][7] += aGerencial[nX][7]
				aSubGerencial[nPos][8] += aGerencial[nX][8]
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
				//ณSoma os totais da filial ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
				nPos := aScan(aFilGerencial,{ |x| Alltrim(x[1]) == Alltrim(cMoeda)})
				If nPos == 0
					AAdd(aFilGerencial, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aFilGerencial)
					aFilGerencial[nPos][1] := cMoeda
				EndIf
				aFilGerencial[nPos][2] += aGerencial[nX][2]
				aFilGerencial[nPos][3] += aGerencial[nX][3]
				aFilGerencial[nPos][4] += aGerencial[nX][4]
				aFilGerencial[nPos][5] += aGerencial[nX][5]
				aFilGerencial[nPos][6] += aGerencial[nX][6]
				aFilGerencial[nPos][7] += aGerencial[nX][7]
				aFilGerencial[nPos][8] += aGerencial[nX][8]
			Next
			oTxtGerencial:Finish()
			oSecValores:Finish()
		EndIf
		
		If Len(aIncentivada) > 0
			
			oTxtIncentivada:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0039) } )//"TOTAL INCENTIVADA "
			
			oTxtIncentivada:Init()
			oTxtIncentivada:PrintLine()
			oSecValores:Init()
			
			For nX := 1 To Len(aIncentivada)
				cMoeda	:= aIncentivada[nX][1]
				cSuf 	:= CValtoChar(Val( cMoeda ))
				oSecValores:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
				oSecValores:Cell("N3_VORIG1"):SetBlock( 	{ || aIncentivada[nX][2] } )
				oSecValores:Cell("N3_AMPLIA1"):SetBlock( 	{ || aIncentivada[nX][3] } )
				oSecValores:Cell("VLATUALIZADO"):SetBlock(	{ || aIncentivada[nX][4] } )
				oSecValores:Cell("N3_VRDACM1"):SetBlock( 	{ || aIncentivada[nX][5] } )
				oSecValores:Cell("VLRESIDUAL"):SetBlock( 	{ || aIncentivada[nX][6] } )
				oSecValores:Cell("N3_VRCDA1"):SetBlock( 	{ || aIncentivada[nX][7] } )
				oSecValores:Cell("N3_VRCACM1"):SetBlock( 	{ || aIncentivada[nX][8] } )
				oSecValores:PrintLine()
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
				//ณSoma os totais da quebraณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
				nPos := aScan(aSubIncentivada,{ |x| Alltrim(x[1]) == Alltrim(cMoeda)})
				If nPos == 0
					AAdd(aSubIncentivada, { "", 0, 0, 0, 0, 0, 0, 0} )
					nPos := Len(aSubIncentivada)
					aSubIncentivada[nPos][1] := cMoeda
				EndIf
				aSubIncentivada[nPos][2] += aIncentivada[nX][2]
				aSubIncentivada[nPos][3] += aIncentivada[nX][3]
				aSubIncentivada[nPos][4] += aIncentivada[nX][4]
				aSubIncentivada[nPos][5] += aIncentivada[nX][5]
				aSubIncentivada[nPos][6] += aIncentivada[nX][6]
				aSubIncentivada[nPos][7] += aIncentivada[nX][7]
				aSubIncentivada[nPos][8] += aIncentivada[nX][8]
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
				//ณSoma os totais da filial ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
				nPos := aScan(aFilIncentivada,{ |x| Alltrim(x[1]) == Alltrim(cMoeda)})
				If nPos == 0
					AAdd(aFilIncentivada, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aFilIncentivada)
					aFilIncentivada[nPos][1] := cMoeda
				EndIf
				aFilIncentivada[nPos][2] += aIncentivada[nX][2]
				aFilIncentivada[nPos][3] += aIncentivada[nX][3]
				aFilIncentivada[nPos][4] += aIncentivada[nX][4]
				aFilIncentivada[nPos][5] += aIncentivada[nX][5]
				aFilIncentivada[nPos][6] += aIncentivada[nX][6]
				aFilIncentivada[nPos][7] += aIncentivada[nX][7]
				aFilIncentivada[nPos][8] += aIncentivada[nX][8]
				
			Next
			oTxtIncentivada:Finish()
			oSecValores:Finish()
		EndIf
	EndDo
	
	If Len(aSubFiscal) > 0 .Or. Len(aSubGerencial) > 0  .Or. Len(aSubIncentivada) > 0
		dbSelectArea("CT1")
		dbSeek(xFilial("CT1",cFilQbr1)+cEntQbr1)
		
		cDescr 	:= AFR072Desc( nTipoEnt, cFilQbr1 , cEntQbr1 )
		cDescrFil:= GetAdvFval("SM0","M0_FILIAL",cEmpAnt + cFilQbr1 )
		oTxtSubtotal:Cell("FILIAL"):SetBlock({|| OemToAnsi(STR0035) + " : " + cFilQbr1 + " - " + cDescrFil } )//"Filial"
		oTxtSubtotal:Cell("ENTIDADE"):SetBlock( { || OemToAnsi("TOTAL ") + cCabCond1 + cDescr } )
		oTxtSubtotal:Cell("QUANTIDADE"):SetBlock( { || OemToAnsi(STR0041) + ": " + cValtoChar(nQuantidade) } )
		
		oTxtSubtotal:Init()
		oTxtSubtotal:PrintLine()
		
		nTotal += nQuantidade
		nQuantidade := 0
		
		If Len(aSubFiscal) > 0
			oTxtFiscal:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0037) } )//"TOTAL FISCAL "
			oTxtFiscal:Init()
			oTxtFiscal:PrintLine()
			
			oSubTotal:Init()
			For nX := 1 To Len(aSubFiscal)
				cMoeda	:= aSubFiscal[nX][1]
				cSuf 	:= CValtoChar(Val( cMoeda ))
				
				oSubTotal:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
				oSubTotal:Cell("N3_VORIG1"):SetBlock( 	{ || aSubFiscal[nX][2] } )
				oSubTotal:Cell("N3_AMPLIA1"):SetBlock( 	{ || aSubFiscal[nX][3] } )
				oSubTotal:Cell("VLATUALIZADO"):SetBlock({ || aSubFiscal[nX][4] } )
				oSubTotal:Cell("N3_VRDACM1"):SetBlock( 	{ || aSubFiscal[nX][5] } )
				oSubTotal:Cell("VLRESIDUAL"):SetBlock( 	{ || aSubFiscal[nX][6] } )
				oSubTotal:Cell("N3_VRCDA1"):SetBlock( 	{ || aSubFiscal[nX][7] } )
				oSubTotal:Cell("N3_VRCACM1"):SetBlock( 	{ || aSubFiscal[nX][8] } )
				
				oSubTotal:PrintLine()
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณSoma os totais do relat๓rioณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				nPos := aScan(aGerFiscal,{ |x| Alltrim(x[1]) == Alltrim(cMoeda) } )
				If nPos == 0
					AAdd(aGerFiscal, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aGerFiscal)
					aGerFiscal[nPos][1] := cMoeda
				EndIf
				aGerFiscal[nPos][2] += aSubFiscal[nX][2]
				aGerFiscal[nPos][3] += aSubFiscal[nX][3]
				aGerFiscal[nPos][4] += aSubFiscal[nX][4]
				aGerFiscal[nPos][5] += aSubFiscal[nX][5]
				aGerFiscal[nPos][6] += aSubFiscal[nX][6]
				aGerFiscal[nPos][7] += aSubFiscal[nX][7]
				aGerFiscal[nPos][8] += aSubFiscal[nX][8]
			Next
			oSubTotal:Finish()
		EndIf
		
		If Len(aSubGerencial) > 0
			oTxtGerencial:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0038) } )//"TOTAL GERENCIAL "
			oTxtGerencial:Init()
			oTxtGerencial:PrintLine()
			
			oSubTotal:Init()
			For nX := 1 To Len(aSubGerencial)
				cMoeda	:= aSubGerencial[nX][1]
				cSuf 	:= CValtoChar(Val( cMoeda ))
				
				oSubTotal:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
				oSubTotal:Cell("N3_VORIG1"):SetBlock( 	{ || aSubGerencial[nX][2] } )
				oSubTotal:Cell("N3_AMPLIA1"):SetBlock( 	{ || aSubGerencial[nX][3] } )
				oSubTotal:Cell("VLATUALIZADO"):SetBlock({ || aSubGerencial[nX][4] } )
				oSubTotal:Cell("N3_VRDACM1"):SetBlock( 	{ || aSubGerencial[nX][5] } )
				oSubTotal:Cell("VLRESIDUAL"):SetBlock( 	{ || aSubGerencial[nX][6] } )
				oSubTotal:Cell("N3_VRCDA1"):SetBlock( 	{ || aSubGerencial[nX][7] } )
				oSubTotal:Cell("N3_VRCACM1"):SetBlock( 	{ || aSubGerencial[nX][8] } )
				
				oSubTotal:PrintLine()
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณSoma os totais do relat๓rioณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				nPos := aScan(aGerGerencial,{ |x| Alltrim(x[1]) == Alltrim(cMoeda) } )
				If nPos == 0
					AAdd(aGerGerencial, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aGerGerencial)
					aGerGerencial[nPos][1] := cMoeda
				EndIf
				aGerGerencial[nPos][2] += aSubGerencial[nX][2]
				aGerGerencial[nPos][3] += aSubGerencial[nX][3]
				aGerGerencial[nPos][4] += aSubGerencial[nX][4]
				aGerGerencial[nPos][5] += aSubGerencial[nX][5]
				aGerGerencial[nPos][6] += aSubGerencial[nX][6]
				aGerGerencial[nPos][7] += aSubGerencial[nX][7]
				aGerGerencial[nPos][8] += aSubGerencial[nX][8]
			Next
			oSubTotal:Finish()
		EndIf
		
		If Len(aSubIncentivada) > 0
			oTxtIncentivada:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0039) } )//"TOTAL INCENTIVADA "
			oTxtIncentivada:Init()
			oTxtIncentivada:PrintLine()
			
			oSubTotal:Init()
			For nX := 1 To Len(aSubIncentivada)
				cMoeda	:= aSubIncentivada[nX][1]
				cSuf 	:= CValtoChar(Val( cMoeda ))
				
				oSubTotal:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
				oSubTotal:Cell("N3_VORIG1"):SetBlock( 	{ || aSubIncentivada[nX][2] } )
				oSubTotal:Cell("N3_AMPLIA1"):SetBlock( 	{ || aSubIncentivada[nX][3] } )
				oSubTotal:Cell("VLATUALIZADO"):SetBlock({ || aSubIncentivada[nX][4] } )
				oSubTotal:Cell("N3_VRDACM1"):SetBlock( 	{ || aSubIncentivada[nX][5] } )
				oSubTotal:Cell("VLRESIDUAL"):SetBlock( 	{ || aSubIncentivada[nX][6] } )
				oSubTotal:Cell("N3_VRCDA1"):SetBlock( 	{ || aSubIncentivada[nX][7] } )
				oSubTotal:Cell("N3_VRCACM1"):SetBlock( 	{ || aSubIncentivada[nX][8] } )
				
				oSubTotal:PrintLine()
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณSoma os totais do relat๓rioณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				nPos := aScan(aGerIncentivada,{ |x| Alltrim(x[1]) == Alltrim(cMoeda) } )
				If nPos == 0
					AAdd(aGerIncentivada, { "", 0, 0, 0, 0, 0, 0, 0 } )
					nPos := Len(aGerIncentivada)
					aGerIncentivada[nPos][1] := cMoeda
				EndIf
				aGerIncentivada[nPos][2] += aSubIncentivada[nX][2]
				aGerIncentivada[nPos][3] += aSubIncentivada[nX][3]
				aGerIncentivada[nPos][4] += aSubIncentivada[nX][4]
				aGerIncentivada[nPos][5] += aSubIncentivada[nX][5]
				aGerIncentivada[nPos][6] += aSubIncentivada[nX][6]
				aGerIncentivada[nPos][7] += aSubIncentivada[nX][7]
				aGerIncentivada[nPos][8] += aSubIncentivada[nX][8]
			Next
			oSubTotal:Finish()
		EndIf
		
		oTxtSubtotal:Finish()
		oReport:SkipLine()
		oReport:ThinLine()
		lDescricao := .F.
		
	EndIf
	
	If cFilQbr1  != (cAliasQry)->FILIAL .And. (Len(aFilFiscal) > 0 .Or. Len(aFilGerencial) > 0  .Or. Len(aFilIncentivada) > 0)
		
		oTxtTotGer:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0042) } )//"* * *   T O T A L   F I L I A L   * * *"
		oTxtTotGer:Init()
		oTxtTotGer:PrintLine()
		
		oTxtSubtotal:Cell("FILIAL"):SetBlock({|| OemToAnsi(STR0035) + " : " + cFilQbr1 + " - " + cDescrFil } )
		oTxtSubtotal:Cell("ENTIDADE"):Disable() // Esconde a informa็ใo dessa coluna em Texto Sub-total e Valores Sub-total.
		oTxtSubtotal:Cell("QUANTIDADE"):SetBlock( { || OemToAnsi(STR0041) + ": " + cValtoChar(nQtdFil) } )
		oTxtSubtotal:Init()
		oTxtSubtotal:PrintLine()
		nQtdFil := 0
		
		If Len(aFilFiscal) > 0
			oTxtFiscal:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0037) } )//"TOTAL FISCAL "
			oTxtFiscal:Init()
			oTxtFiscal:PrintLine()
			
			oSubTotal:Init()
			For nX := 1 To Len(aFilFiscal)
				cMoeda	:= aFilFiscal[nX][1]
				cSuf 	:= CValtoChar(Val( cMoeda ))
				
				oSubTotal:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
				oSubTotal:Cell("N3_VORIG1"):SetBlock( 	{ || aFilFiscal[nX][2] } )
				oSubTotal:Cell("N3_AMPLIA1"):SetBlock( 	{ || aFilFiscal[nX][3] } )
				oSubTotal:Cell("VLATUALIZADO"):SetBlock({ || aFilFiscal[nX][4] } )
				oSubTotal:Cell("N3_VRDACM1"):SetBlock( 	{ || aFilFiscal[nX][5] } )
				oSubTotal:Cell("VLRESIDUAL"):SetBlock( 	{ || aFilFiscal[nX][6] } )
				oSubTotal:Cell("N3_VRCDA1"):SetBlock( 	{ || aFilFiscal[nX][7] } )
				oSubTotal:Cell("N3_VRCACM1"):SetBlock( 	{ || aFilFiscal[nX][8] } )
				
				oSubTotal:PrintLine()
			Next
			oSubTotal:Finish()
			aFilFiscal := {}
		EndIf
		
		If Len(aFilGerencial) > 0
			oTxtGerencial:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0038) } )//"TOTAL GERENCIAL "
			oTxtGerencial:Init()
			oTxtGerencial:PrintLine()
			
			oSubTotal:Init()
			For nX := 1 To Len(aFilGerencial)
				cMoeda	:= aFilGerencial[nX][1]
				cSuf 	:= CValtoChar(Val( cMoeda ))
				
				oSubTotal:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
				oSubTotal:Cell("N3_VORIG1"):SetBlock( 	{ || aFilGerencial[nX][2] } )
				oSubTotal:Cell("N3_AMPLIA1"):SetBlock( 	{ || aFilGerencial[nX][3] } )
				oSubTotal:Cell("VLATUALIZADO"):SetBlock({ || aFilGerencial[nX][4] } )
				oSubTotal:Cell("N3_VRDACM1"):SetBlock( 	{ || aFilGerencial[nX][5] } )
				oSubTotal:Cell("VLRESIDUAL"):SetBlock( 	{ || aFilGerencial[nX][6] } )
				oSubTotal:Cell("N3_VRCDA1"):SetBlock( 	{ || aFilGerencial[nX][7] } )
				oSubTotal:Cell("N3_VRCACM1"):SetBlock( 	{ || aFilGerencial[nX][8] } )
				
				oSubTotal:PrintLine()
				
			Next
			oSubTotal:Finish()
			aFilGerencial := {}
		EndIf
		
		If Len(aFilIncentivada) > 0
			oTxtIncentivada:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0039) } )//"TOTAL INCENTIVADA "
			oTxtIncentivada:Init()
			oTxtIncentivada:PrintLine()
			
			oSubTotal:Init()
			For nX := 1 To Len(aFilIncentivada)
				cMoeda	:= aFilIncentivada[nX][1]
				cSuf 	:= CValtoChar(Val( cMoeda ))
				
				oSubTotal:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
				oSubTotal:Cell("N3_VORIG1"):SetBlock( 	{ || aFilIncentivada[nX][2] } )
				oSubTotal:Cell("N3_AMPLIA1"):SetBlock( 	{ || aFilIncentivada[nX][3] } )
				oSubTotal:Cell("VLATUALIZADO"):SetBlock({ || aFilIncentivada[nX][4] } )
				oSubTotal:Cell("N3_VRDACM1"):SetBlock( 	{ || aFilIncentivada[nX][5] } )
				oSubTotal:Cell("VLRESIDUAL"):SetBlock( 	{ || aFilIncentivada[nX][6] } )
				oSubTotal:Cell("N3_VRCDA1"):SetBlock( 	{ || aFilIncentivada[nX][7] } )
				oSubTotal:Cell("N3_VRCACM1"):SetBlock( 	{ || aFilIncentivada[nX][8] } )
				
				oSubTotal:PrintLine()
			Next
			oSubTotal:Finish()
			aFilIncentivada := {}
		EndIf
		
		oTxtSubtotal:Finish()
		oReport:SkipLine()
		oReport:ThinLine()
		oTxtSubtotal:Cell("ENTIDADE"):Enable()
	EndIF
	
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Efetua a impressao da totalizacao na quebra do segundo nivel        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Len(aGerFiscal) > 0 .Or. Len(aGerGerencial) > 0  .Or. Len(aGerIncentivada) > 0
	oTxtTotGer:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0040) } ) // "* * *   T O T A L   G E R A L   * * *"
	oTxtTotGer:Cell("QUANTIDADE"):SetBlock( { || OemToAnsi(STR0041) + ": " + cValToChar(nTotal) } ) // "QUANTIDADE"
	
	oTxtTotGer:Init()
	oTxtTotGer:PrintLine()
	
	If Len(aGerFiscal) > 0
		oTxtFiscal:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0037) } )//"TOTAL FISCAL "
		oTxtFiscal:Init()
		oTxtFiscal:PrintLine()
		
		oTotalGeral:Init()
		For nX := 1 To Len(aGerFiscal)
			cMoeda	:= aGerFiscal[nX][1]
			cSuf 	:= CValtoChar(Val( cMoeda ))
			
			oTotalGeral:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
			oTotalGeral:Cell("N3_VORIG1"):SetBlock( 	{ || aGerFiscal[nX][2] } )
			oTotalGeral:Cell("N3_AMPLIA1"):SetBlock( 	{ || aGerFiscal[nX][3] } )
			oTotalGeral:Cell("VLATUALIZADO"):SetBlock(	{ || aGerFiscal[nX][4] } )
			oTotalGeral:Cell("N3_VRDACM1"):SetBlock( 	{ || aGerFiscal[nX][5] } )
			oTotalGeral:Cell("VLRESIDUAL"):SetBlock( 	{ || aGerFiscal[nX][6] } )
			oTotalGeral:Cell("N3_VRCDA1"):SetBlock( 	{ || aGerFiscal[nX][7] } )
			oTotalGeral:Cell("N3_VRCACM1"):SetBlock( 	{ || aGerFiscal[nX][8] } )
			
			oTotalGeral:PrintLine()
		Next
		oTotalGeral:Finish()
	EndIf
	
	If Len(aGerGerencial) > 0
		oTxtGerencial:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0038) } )//"TOTAL GERENCIAL "
		oTxtGerencial:Init()
		oTxtGerencial:PrintLine()
		
		oTotalGeral:Init()
		For nX := 1 To Len(aGerGerencial)
			cMoeda	:= aGerGerencial[nX][1]
			cSuf 	:= CValtoChar(Val( cMoeda ))
			
			oTotalGeral:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
			oTotalGeral:Cell("N3_VORIG1"):SetBlock( 	{ || aGerGerencial[nX][2] } )
			oTotalGeral:Cell("N3_AMPLIA1"):SetBlock( 	{ || aGerGerencial[nX][3] } )
			oTotalGeral:Cell("VLATUALIZADO"):SetBlock({ || aGerGerencial[nX][4] } )
			oTotalGeral:Cell("N3_VRDACM1"):SetBlock( 	{ || aGerGerencial[nX][5] } )
			oTotalGeral:Cell("VLRESIDUAL"):SetBlock( 	{ || aGerGerencial[nX][6] } )
			oTotalGeral:Cell("N3_VRCDA1"):SetBlock( 	{ || aGerGerencial[nX][7] } )
			oTotalGeral:Cell("N3_VRCACM1"):SetBlock( 	{ || aGerGerencial[nX][8] } )
			
			oTotalGeral:PrintLine()
		Next
		oTotalGeral:Finish()
	EndIf
	
	If Len(aGerIncentivada) > 0
		oTxtIncentivada:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0039) } )//"TOTAL INCENTIVADA "
		oTxtIncentivada:Init()
		oTxtIncentivada:PrintLine()
		
		oTotalGeral:Init()
		For nX := 1 To Len(aGerIncentivada)
			cMoeda	:= aGerIncentivada[nX][1]
			cSuf 	:= CValtoChar(Val( cMoeda ))
			
			oTotalGeral:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
			oTotalGeral:Cell("N3_VORIG1"):SetBlock( 	{ || aGerIncentivada[nX][2] } )
			oTotalGeral:Cell("N3_AMPLIA1"):SetBlock( 	{ || aGerIncentivada[nX][3] } )
			oTotalGeral:Cell("VLATUALIZADO"):SetBlock({ || aGerIncentivada[nX][4] } )
			oTotalGeral:Cell("N3_VRDACM1"):SetBlock( 	{ || aGerIncentivada[nX][5] } )
			oTotalGeral:Cell("VLRESIDUAL"):SetBlock( 	{ || aGerIncentivada[nX][6] } )
			oTotalGeral:Cell("N3_VRCDA1"):SetBlock( 	{ || aGerIncentivada[nX][7] } )
			oTotalGeral:Cell("N3_VRCACM1"):SetBlock( 	{ || aGerIncentivada[nX][8] } )
			
			oTotalGeral:PrintLine()
			
		Next
		oTotalGeral:Finish()
		oTxtTotGer:Finish()
	EndIf
EndIf

If Select(cAliasQry) > 0
	dbSelectArea(cAliasQry)
	cArqAux := (cAliasQry)->(dbInfo(DBI_FULLPATH))
	cArqAux := AllTrim(Substr(cArqAux,RAT("\",cArqAux)+1))
	DbCloseArea()
	MsErase(cArqAux)
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrtAnaliticoบAutor  ณAlvaro Camillo Neto บ Data ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao do relatorio Analitico                            บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR072                                                     บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrtAnalitico( oReport )
Local oSecEntCtb	 := oReport:Section(1)
Local oSecBem		 := oReport:Section(1):Section(1)
Local oSecValores	 := oReport:Section(1):Section(2)
Local oTxtSubtotal 	 := oReport:Section(1):Section(3)
Local oSubtotal 	 := oReport:Section(1):Section(4)
Local oTxtTotGer	 := oReport:Section(2)
Local oTotalGeral	 := oReport:Section(3)
Local oTxtFiscal	 := oReport:Section(4)
Local oTxtGerencial	 := oReport:Section(5)
Local oTxtIncentivada:= oReport:Section(6)

Local oMeter
Local oText
Local oDlg
Local lEnd
Local cAliasQry 	:= GetNextAlias()
Local dDataSLD  	:= MV_PAR01
Local dAquIni		:= MV_PAR04
Local dAquFim   	:= MV_PAR05
Local cBemIni   	:= MV_PAR06
Local cBemFim   	:= MV_PAR08
Local cItemIni  	:= MV_PAR07
Local cItemFim  	:= MV_PAR09
Local cContaIni 	:= MV_PAR12
Local cContaFim 	:= MV_PAR13
Local cCCIni   		:= MV_PAR14
Local cCCFim   		:= MV_PAR15
Local cItCtbIni		:= MV_PAR16
Local cItCtbFim		:= MV_PAR17
Local cClvlIni		:= MV_PAR18
Local cClVlFim		:= MV_PAR19
Local cGrupoIni		:= MV_PAR10
Local cGrupoFim		:= MV_PAR11
Local n_pagini 		:= MV_PAR21
Local n_pagFim		:= MV_PAR22
Local n_pagRes		:= MV_PAR23
Local nTipoTotal	:= MV_PAR24
Local cTipoSLD		:= MV_PAR25
Local cChave		:= ""
Local cCond			:= ""
Local aTotGeral 	:= {}
Local aTQuebra1 	:= {}
Local aTFilial		:= {}
Local nX			:= 0
Local nTotal 	 	:= 0
Local nQuantidade 	:= 0
Local nQtdFil	 	:= 0
Local cCabCond1 	:= ""
Local nTipoEnt		:= oSecEntCtb:GetOrder() 
Local aTipo			:= {}                     
Local cChaveBem		:= ""
Local cTipoFiscal	:= ATFXTpBem(1)
Local cTipoGerenc	:= ATFXTpBem(2)
Local cTipoIncent	:= ATFXTpBem(3) 
Local cDescSld		:= ""
Local cArqAux		:= ""
Local lRealProv	:= .T.
Local cBaixa		:= cValToChar( MV_PAR28 ) 

If Empty(cBaixa)
	cBaixa := "1"
EndIf

aSelMoed := IIF(Empty(aSelMoed), {"01"} , aSelMoed )

If nTipoTotal == 1 //Fiscal
	aTipo := ATFXTpBem(1,.T.)
ElseIf nTipoTotal == 2 //Gerencial
	aTipo := ATFXTpBem(2,.T.)
ElseIf nTipoTotal == 3 //Incentivada
	aTipo := ATFXTpBem(3,.T.)
EndIf

oSecValores:Cell("SIMBMOEDA"):SetTitle("")
oSubTotal:Cell("SIMBMOEDA"):SetTitle("")
oTotalGeral:Cell("SIMBMOEDA"):SetTitle("")

//Ordem do Arquivo
IF nTipoEnt == 1
	cChave := "FILIAL+CONTA+CCUSTO+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("Conta   : ") //"Conta   : "
ElseIf nTipoEnt == 2
	cChave := "FILIAL+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("C.Custo : ") //"C.Custo : "
ElseIf nTipoEnt == 3
	cChave := "FILIAL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("It.Ctb. : ") //"It.Ctb. : "
ElseIf nTipoEnt == 4
	cChave := "FILIAL+CLVL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV+MOEDA"
	cCabCond1 := OemToAnsi("It.Ctb. : ") //"It.Ctb. : "
End

//Controle de reincio da numeracao de paginas
oReport:SetPageNumber(n_pagini)
oReport:OnPageBreak( {|| If((n_pagini+1) > n_pagFim, (n_pagini := n_pagRes,oReport:SetPageNumber(n_pagini-1)),n_pagini += 1) } )

/*
 * Verifica็ใo do campo para ativos de custo de provisใo
 */
DbSelectArea("SN3")
If .T.
	lRealProv := MV_PAR27 == 1
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao						 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
ATFGERSLDM(oMeter,oText,oDlg,lEnd,cAliasQry,dAquIni,dAquFim,dDataSLD,cBemIni,cBemFim,cItemIni,cItemFim,cContaIni,cContaFim,;
cCCIni,cCCFim,cItCtbIni,cItCtbFim,cClvlIni,cClVlFim,cGrupoIni,cGrupoFim,aSelMoed,aSelFil,lTodasFil,cChave,.T.,aTipo,Nil,cBaixa,cTipoSLD,aSelClass,lRealProv) },;
OemToAnsi(OemToAnsi(STR0034)),; //"Criando Arquivo Temporแrio..."
OemToAnsi(STR0035))//"Posicao Valorizada dos Bens na Data"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ฟ
//ณEstrutura do Arquivoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ู
/*
FILIAL CBASE ITEM MOEDA	CLASSIF TIPO DESC_SINT AQUISIC DTBAIXA DTSALDO CHAPA GRUPO CONTA CCUSTO SUBCTA CLVL QUANTD ORIGINAL AMPLIACAO ATUALIZ DEPRECACM
RESIDUAL CORRECACM CORDEPACM VLBAIXAS
*/

//Descri็ใo do tipo de saldo
SX5->(MsSeek(xFilial("SX5") + "SL"+ IIF(Empty(cTipoSLD),'1',cTipoSLD) ))
cDescSld := Alltrim(SX5->(X5Descri()))

// Orderna de acordo com a Ordem do relatorio
(cAliasQry)->(dbGoTop())
While (cAliasQry)->(!EOF()) .And. !oReport:Cancel()
	
	nQuantidade := 0
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Controla a quebra no 1o. nivel                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cFilQbr1 := (cAliasQry)->FILIAL
	IF nTipoEnt == 1
		cEntQbr1 := (cAliasQry)->CONTA
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->( FILIAL + CONTA ) == cQuebra1"
	ElseIf nTipoEnt == 2
		cEntQbr1 := (cAliasQry)->CCUSTO
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->( FILIAL + CCUSTO ) == cQuebra1"
	ElseIf nTipoEnt == 3
		cEntQbr1 := (cAliasQry)->SUBCTA
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->( FILIAL + SUBCTA ) == cQuebra1"
	ElseIf nTipoEnt == 4
		cEntQbr1 := (cAliasQry)->CLVL
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->( FILIAL + CLVL ) == cQuebra1"
	EndIf
	
	dbSelectArea(cAliasQry)
	
	IF Empty(cEntQbr1)
		(cAliasQry)->(dbSkip())
		Loop
	EndIf
	
	lDescricao := .F.
	aTQuebra1 := {}
	
	While (cAliasQry)->(!Eof()) .AND. &cCond1 .And. !oReport:Cancel()

		dBaixaAnt := (cAliasQry)->DTBAIXA 

		If !lDescricao
			AFR072Cab(nTipoEnt,cFilQbr1,cEntQbr1, oReport)
			lDescricao := .T.
		EndIf
		
		If AllTrim(cChaveBem) != AllTrim((cAliasQry)->FILIAL + (cAliasQry)->CBASE + (cAliasQry)->ITEM)  
			cChaveBem := (cAliasQry)->FILIAL + (cAliasQry)->CBASE + (cAliasQry)->ITEM   
			nQuantidade += (cAliasQry)->QUANTD  
			nQtdFil+= (cAliasQry)->QUANTD   
		EndIf
		

		oSecBem:Init()
		oSecBem:Cell("N3_FILIAL"):SetBlock({|| (cAliasQry)->FILIAL } )
		oSecBem:Cell("N3_CBASE"):SetBlock({|| (cAliasQry)->CBASE } )
		oSecBem:Cell("N3_ITEM"):SetBlock({|| (cAliasQry)->ITEM } )
		oSecBem:Cell("N3_TIPO"):SetBlock({|| (cAliasQry)->TIPO  } )
		SX5->(MsSeek(xFilial("SX5") + "G1"+ (cAliasQry)->TIPO ))
		oSecBem:Cell("N3_TIPODESC"):SetValue( X5Descri() )
		//Incluido tipo de depreciacao para relatorio analitico 
		//Incluido por Jair Ribeiro em 29/04/11
		oSecBem:Cell("N3_TPDEPR"):SetValue( GetAdvFVal("SN0","N0_DESC01",xFilial("SN0")+"04"+GetAdvFVal("SN3","N3_TPDEPR",(cAliasQry)->(FILIAL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ))) ) 
		oSecBem:Cell("N1_PATRIM"):SetBlock({|| X3ATF('N1_PATRIM',(cAliasQry)->CLASSIF)   } )
		oSecBem:Cell("N1_DESCRIC"):SetBlock({|| (cAliasQry)->DESC_SINT } )
		oSecBem:Cell("N1_AQUISIC"):SetBlock({|| (cAliasQry)->AQUISIC } )
		oSecBem:Cell("N1_BAIXA"):SetBlock({|| (cAliasQry)->DTBAIXA } )
		oSecBem:Cell("N1_QUANTD"):SetBlock({|| (cAliasQry)->QUANTD } )
		oSecBem:Cell("N1_CHAPA"):SetBlock({|| (cAliasQry)->CHAPA } )  
		oSecBem:Cell("N3_TPSALDO"):SetBlock({|| cDescSld  } )		
		oSecBem:Cell("N3_CCONTAB"):SetBlock({|| (cAliasQry)->CONTA } )
		oSecBem:Cell("N3_CUSTBEM"):SetBlock({|| (cAliasQry)->CCUSTO } )
		oSecBem:Cell("N3_SUBCCON"):SetBlock({|| (cAliasQry)->SUBCTA } )
		oSecBem:Cell("N3_CLVLCON"):SetBlock({|| (cAliasQry)->CLVL } )
		oSecBem:PrintLine()
		oSecBem:Finish()
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Controla a quebra no 2o. nivel                                         ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		IF nTipoEnt == 1
			cQuebra2 :=  (cAliasQry)->( FILIAL+CONTA+CCUSTO+CBASE+ITEM+TIPO+SEQ+SEQREAV )
			cCond2   := cAliasQry + "->( FILIAL+CONTA+CCUSTO+CBASE+ITEM+TIPO+SEQ+SEQREAV ) == cQuebra2"
		ElseIf nTipoEnt == 2
			cQuebra2 :=  (cAliasQry)->( FILIAL+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV )
			cCond2   := cAliasQry + "->( FILIAL+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV ) == cQuebra2"
		ElseIf nTipoEnt == 3
			cQuebra2 :=  (cAliasQry)->( FILIAL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV )
			cCond2   := cAliasQry + "->( FILIAL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV ) == cQuebra2"
		ElseIf nTipoEnt == 4
			cQuebra2 := (cAliasQry)->( FILIAL+CLVL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV )
			cCond2   := cAliasQry + "->( FILIAL+CLVL+SUBCTA+CCUSTO+CONTA+CBASE+ITEM+TIPO+SEQ+SEQREAV ) == cQuebra2"
		EndIf
		oSecValores:Init()
		While (cAliasQry)->(!Eof()) .AND. &cCond2 .And. !oReport:Cancel() .And. dBaixaAnt == (cAliasQry)->DTBAIXA 

			cSuf := CValtoChar(Val((cAliasQry)->MOEDA))
			oSecValores:Cell("SIMBMOEDA"):SetBlock( { || SuperGetMV("MV_SIMB"+cSuf) } )
			oSecValores:Cell("N3_VORIG1"):SetBlock( { || (cAliasQry)->ORIGINAL } )
			oSecValores:Cell("N3_AMPLIA1"):SetBlock( { || (cAliasQry)->AMPLIACAO } )
			oSecValores:Cell("VLATUALIZADO"):SetBlock( { || (cAliasQry)->ATUALIZ } )
			oSecValores:Cell("N3_VRDACM1"):SetBlock( { || (cAliasQry)->DEPRECACM } )
			oSecValores:Cell("VLRESIDUAL"):SetBlock( { || (cAliasQry)->RESIDUAL } )
			oSecValores:Cell("N3_VRCDA1"):SetBlock( { || (cAliasQry)->CORDEPACM } )
			oSecValores:Cell("N3_VRCACM1"):SetBlock( { || (cAliasQry)->CORRECACM } )
			oSecValores:PrintLine()
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
			//ณSoma os totais da quebraณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
			If cBaixa <> "3" .Or. EMPTY( (cAliasQry)->DTBAIXA ) 
			nPos := aScan(aTQuebra1,{ |x| Alltrim(x[1]) == Alltrim((cAliasQry)->MOEDA)})
			If nPos == 0
				AAdd(aTQuebra1, { "", 0, 0, 0, 0, 0, 0, 0, 0 } )
				nPos := Len(aTQuebra1)
				aTQuebra1[nPos][1] := (cAliasQry)->MOEDA
			EndIf
			aTQuebra1[nPos][2] += (cAliasQry)->ORIGINAL
			aTQuebra1[nPos][3] += (cAliasQry)->AMPLIACAO
			aTQuebra1[nPos][4] += (cAliasQry)->ATUALIZ
			aTQuebra1[nPos][5] += (cAliasQry)->DEPRECACM
			aTQuebra1[nPos][6] += (cAliasQry)->RESIDUAL
			aTQuebra1[nPos][7] += (cAliasQry)->CORDEPACM
			aTQuebra1[nPos][8] += (cAliasQry)->CORRECACM
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
			//ณSoma os totais da quebraณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
			nPos := aScan(aTFilial,{ |x| Alltrim(x[1]) == Alltrim((cAliasQry)->MOEDA)})
			If nPos == 0
				AAdd(aTFilial, { "", 0, 0, 0, 0, 0, 0, 0, 0 } )
				nPos := Len(aTFilial)
				aTFilial[nPos][1] := (cAliasQry)->MOEDA
			EndIf
			aTFilial[nPos][2] += (cAliasQry)->ORIGINAL
			aTFilial[nPos][3] += (cAliasQry)->AMPLIACAO
			aTFilial[nPos][4] += (cAliasQry)->ATUALIZ
			aTFilial[nPos][5] += (cAliasQry)->DEPRECACM
			aTFilial[nPos][6] += (cAliasQry)->RESIDUAL
			aTFilial[nPos][7] += (cAliasQry)->CORDEPACM
			aTFilial[nPos][8] += (cAliasQry)->CORRECACM
			EndIf	

			dBaixaAnt	:= (cAliasQry)->DTBAIXA

			(cAliasQry)->(dbSkip())
		EndDo
		oSecValores:Finish()
	EndDo
	cDescr 	:= AFR072Desc( nTipoEnt, cFilQbr1 , cEntQbr1 )
	cDescrFil:= GetAdvFval("SM0","M0_FILIAL",cEmpAnt + cFilQbr1 )
	oTxtSubtotal:Cell("FILIAL"):SetBlock({|| OemToAnsi(STR0035) + " : " + cFilQbr1 + " - " + cDescrFil } )
	oTxtSubtotal:Cell("ENTIDADE"):SetBlock( { || OemToAnsi(STR0036) + cCabCond1 + cDescr } )
	oTxtSubtotal:Cell("QUANTIDADE"):SetBlock( { || OemToAnsi(STR0041) + ": " + cValToChar(nQuantidade) } )

	oTxtSubtotal:Init()
	oTxtSubtotal:PrintLine()
	
	nTotal += nQuantidade
	nQuantidade := 0
	
	dbSelectArea("CT1")
	dbSeek(xFilial("CT1",cFilQbr1)+cEntQbr1)
	
	oSubTotal:Init()
	For nX := 1 To Len(aTQuebra1)
		
		cMoeda	:= aTQuebra1[nX][1]
		cSuf 	:= CValtoChar(Val( cMoeda ))
		
		oSubTotal:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
		oSubTotal:Cell("N3_VORIG1"):SetBlock( 	{ || aTQuebra1[nX][2] } )
		oSubTotal:Cell("N3_AMPLIA1"):SetBlock( 	{ || aTQuebra1[nX][3] } )
		oSubTotal:Cell("VLATUALIZADO"):SetBlock({ || aTQuebra1[nX][4] } )
		oSubTotal:Cell("N3_VRDACM1"):SetBlock( 	{ || aTQuebra1[nX][5] } )
		oSubTotal:Cell("VLRESIDUAL"):SetBlock( 	{ || aTQuebra1[nX][6] } )
		oSubTotal:Cell("N3_VRCDA1"):SetBlock( 	{ || aTQuebra1[nX][7] } )
		oSubTotal:Cell("N3_VRCACM1"):SetBlock( 	{ || aTQuebra1[nX][8] } )
		
		oSubTotal:PrintLine()
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณSoma os totais do relat๓rioณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		nPos := aScan(aTotGeral,{ |x| Alltrim(x[1]) == Alltrim(cMoeda) } )
		If nPos == 0
			AAdd(aTotGeral, { "", 0, 0, 0, 0, 0, 0, 0 } )
			nPos := Len(aTotGeral)
			aTotGeral[nPos][1] := cMoeda
		EndIf
		aTotGeral[nPos][2] += aTQuebra1[nX][2]
		aTotGeral[nPos][3] += aTQuebra1[nX][3]
		aTotGeral[nPos][4] += aTQuebra1[nX][4]
		aTotGeral[nPos][5] += aTQuebra1[nX][5]
		aTotGeral[nPos][6] += aTQuebra1[nX][6]
		aTotGeral[nPos][7] += aTQuebra1[nX][7]
		aTotGeral[nPos][8] += aTQuebra1[nX][8]
	Next
	oSubTotal:Finish()
	oTxtSubtotal:Finish()
	oReport:SkipLine()
	oReport:ThinLine()
	lDescricao := .F.
	If Len(aTFilial) > 0 .And. cFilQbr1  != (cAliasQry)->FILIAL

		oTxtTotGer:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0042) } ) //"* * *   T O T A L   F I L I A L   * * *"
		oTxtTotGer:Init()
		oTxtTotGer:PrintLine()
			
		oTxtSubtotal:Cell("FILIAL"):SetBlock({|| OemToAnsi(STR0035) + " : " + cFilQbr1 + " - " + cDescrFil } )
		oTxtSubtotal:Cell("ENTIDADE"):Disable() // Esconde a informa็ใo dessa coluna em Texto Sub-total e Valores Sub-total.		
		oTxtSubtotal:Cell("QUANTIDADE"):SetBlock( { || OemToAnsi(STR0041) + ": " + cValToChar(nQtdFil) } )//"QUANTIDADE"
		oTxtSubtotal:Init()
		oTxtSubtotal:PrintLine()
		
		oSubTotal:Init()
		For nX := 1 To Len(aTFilial)
			
			cMoeda	:= aTFilial[nX][1]
			cSuf 	:= CValtoChar(Val( cMoeda ))
			
			oSubTotal:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
			oSubTotal:Cell("N3_VORIG1"):SetBlock( 	{ || aTFilial[nX][2] } )
			oSubTotal:Cell("N3_AMPLIA1"):SetBlock( 	{ || aTFilial[nX][3] } )
			oSubTotal:Cell("VLATUALIZADO"):SetBlock({ || aTFilial[nX][4] } )
			oSubTotal:Cell("N3_VRDACM1"):SetBlock( 	{ || aTFilial[nX][5] } )
			oSubTotal:Cell("VLRESIDUAL"):SetBlock( 	{ || aTFilial[nX][6] } )
			oSubTotal:Cell("N3_VRCDA1"):SetBlock( 	{ || aTFilial[nX][7] } )
			oSubTotal:Cell("N3_VRCACM1"):SetBlock( 	{ || aTFilial[nX][8] } )
			
			oSubTotal:PrintLine()
		Next
		
		aTFilial := {}
		nQtdFil := 0
		oSubTotal:Finish()
		oTxtSubtotal:Finish()
		oTotalGeral:Finish()
		oReport:SkipLine()
		oReport:ThinLine()
		oTxtSubtotal:Cell("ENTIDADE"):Enable()
	EndIF
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Efetua a impressao da totalizacao na quebra do segundo nivel        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Len( aTotGeral ) > 0
	
	oTxtTotGer:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0040) } ) // "* * *   T O T A L   G E R A L   * * *"
	oTxtTotGer:Cell("QUANTIDADE"):SetBlock( { || OemToAnsi(STR0041) + ": " + cValToChar(nTotal) } ) // "QUANTIDADE"
	
	oTxtTotGer:Init()
	oTxtTotGer:PrintLine()
	
	oTotalGeral:Init()
	
	
	For nX := 1 To Len(aTotGeral)
		cMoeda	:= aTotGeral[nX][1]
		cSuf 	:= CValtoChar(Val( cMoeda ))
		oTotalGeral:Cell("SIMBMOEDA"):SetBlock( 	{ || SuperGetMV("MV_SIMB"+cSuf) } )
		oTotalGeral:Cell("N3_VORIG1"):SetBlock( 	{ || aTotGeral[nX][2] } )
		oTotalGeral:Cell("N3_AMPLIA1"):SetBlock( 	{ || aTotGeral[nX][3] } )
		oTotalGeral:Cell("VLATUALIZADO"):SetBlock({ || aTotGeral[nX][4] } )
		oTotalGeral:Cell("N3_VRDACM1"):SetBlock( 	{ || aTotGeral[nX][5] } )
		oTotalGeral:Cell("VLRESIDUAL"):SetBlock( 	{ || aTotGeral[nX][6] } )
		oTotalGeral:Cell("N3_VRCDA1"):SetBlock( 	{ || aTotGeral[nX][7] } )
		oTotalGeral:Cell("N3_VRCACM1"):SetBlock( 	{ || aTotGeral[nX][8] } )
		oTotalGeral:PrintLine()
	Next
	
	oTotalGeral:Finish()
	oTxtTotGer:Finish()
EndIf

If Select(cAliasQry) > 0
	dbSelectArea(cAliasQry)
	cArqAux := (cAliasQry)->(dbInfo(DBI_FULLPATH))
	cArqAux := AllTrim(Substr(cArqAux,RAT("\",cArqAux)+1))
	DbCloseArea()
	MsErase(cArqAux)
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTotalCtb  บAutor  ณAlvaro Camillo Neto บ Data ณ  28/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina que totaliza as informa็๕es pela entidade contabil  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR072                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TotalCtb(cTabName,cFilx,nTipoEnt,cEntidade,cTipoIn)
Local aValores 	:= {}
Local cQuery	:= ""
Local cAliasTRB := "TRBCTB"
Local cCPOEnt	:= ""

Default cTipoIn := ""

If nTipoEnt == 1 //Conta
	cCPOEnt := "CONTA"
ElseIf nTipoEnt == 2 //Centro de Custo
	cCPOEnt := "CCUSTO"
ElseIf nTipoEnt == 3 //Item Contabil
	cCPOEnt := "SUBCTA"
ElseIf nTipoEnt == 4 //Classe de Valor
	cCPOEnt := "CLVL"
EndIf

cQuery	+= " SELECT "
cQuery	+= cCPOEnt 	+",  "
cQuery	+= " 	MOEDA,  "
cQuery	+= " 	SUM(ORIGINAL) ORIGINAL , "
cQuery	+= " 	SUM(AMPLIACAO) AMPLIACAO , "
cQuery	+= " 	SUM(ATUALIZ) ATUALIZ ,  "
cQuery	+= " 	SUM(DEPRECACM) DEPRECACM , "
cQuery	+= " 	SUM(RESIDUAL) RESIDUAL , "
cQuery	+= " 	SUM(CORRECACM) CORRECACM , "
cQuery	+= " 	SUM(CORDEPACM) CORDEPACM , "
cQuery	+= " 	SUM(VLBAIXAS) VLBAIXAS  "
cQuery	+= " FROM  " +  cTabName
cQuery	+= " WHERE "

cQuery	+= " 	FILIAL = '" + cFilx + "'"
cQuery	+= " 	AND " +cCPOEnt+ " = '" + cEntidade + "' "

If !Empty(cTipoIn) 
	cQuery	+= " 	AND TIPO IN " + FormatIn(cTipoIn,"/")
EndIf 

cQuery	+= " GROUP BY  "
cQuery	+= cCPOEnt + " , "
cQuery	+= " MOEDA  "

cQuery := ChangeQuery(cQuery )
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTRB , .T. , .F.)

While (cAliasTRB)->(!EOF())
	AAdd(aValores, { "", 0, 0, 0, 0, 0, 0, 0 } )
	nPos := Len(aValores)
	aValores[nPos][1] := (cAliasTRB)->MOEDA
	aValores[nPos][2] += (cAliasTRB)->ORIGINAL
	aValores[nPos][3] += (cAliasTRB)->AMPLIACAO
	aValores[nPos][4] += (cAliasTRB)->ATUALIZ
	aValores[nPos][5] += (cAliasTRB)->DEPRECACM
	aValores[nPos][6] += (cAliasTRB)->RESIDUAL
	aValores[nPos][7] += (cAliasTRB)->CORRECACM
	aValores[nPos][8] += (cAliasTRB)->CORDEPACM
	(cAliasTRB)->(dbSKip())
EndDo

(cAliasTRB)->(dbCloseArea())
Return aValores

/*
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ AFR070Cab  ณ Autor ณ Cesar C S Prado       ณ Data ณ 09.08.94 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Impressao do cabecalho do relatorio (Nivel 1 de quebra)      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe e ณ AFR070Cab(cPar01,nPar01,@nPar02)                             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametro ณ cPar01 - Cabecalho a ser impresso                            ณฑฑ
ฑฑณ          ณ nPar01 - Ordem da impressao do relatorio (1-Conta/2-C.Custo) ณฑฑ
ฑฑณ          ณ nPar02 - Linha corrente                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ ATFR070                                                      ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AFR072Cab(nOrdem,cFilCab,cChave, oReport)

Local oSection1 := oReport:Section(1)
Local cDescEntd := ""

IF nOrdem == 1 //Conta
	dbSelectArea("CT1")
	dbSetOrder(1)
	If CT1->(dbSeek(xFilial("CT1",cFilCab) + cChave))
		cDescEntd := CT1->CT1_DESC01
	EndIf
	cChave := MascaraCTB(cChave)
ElseIf nOrdem == 2 //Centro de Custo
	dbSelectAre("CTT")
	dbSetOrder(1)
	If CTT->( dbSeek(xFilial("CTT",cFilCab) +cChave ) )
		cDescEntd :=  CTT->CTT_DESC01
	EndIf 	
ElseIf nOrdem == 3 //Item Contabil
	dbSelectAre("CTD")
	dbSetOrder(1)
	If CTD->( dbSeek(xFilial("CTD",cFilCab) +cChave ) )
		cDescEntd := CTD->CTD_DESC01
	EndIf
ElseIf nOrdem == 4 //Classe Valor
	dbSelectAre("CTH")
	dbSetOrder(1)
	If CTH->( dbSeek(xFilial("CTH",cFilCab) +cChave ) )
		cDescEntd := CTH->CTH_DESC01
	EndIf
EndIf

oSection1:Cell("ENTIDADES"):SetBlock( { || cChave } )
oSection1:Cell("DESCENTID"):SetBlock( { || cDescEntd } )

oSection1:Init()
oSection1:PrintLine()
oSection1:Finish()
Return NIL

/*
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ AFR072Desc ณ Autor ณ Alvaro Camillo Neto   ณ Data ณ 27.09.10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Busca a descricao a ser impressa para subtotal / total       ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe e ณ AFR072Desc(nPar01)                                           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametro ณ nPar01 - Ordem da impressao do relatorio (1-Conta/2-C.Custo) ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ ATFR072                                                      ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AFR072Desc(nOrdem, cFilCab ,cChave )
Local aArea  := GetArea()
Local cDescr  := ""

If nOrdem == 1
	dbSelectArea("CT1")
	IF MsSeek(xFilial("CT1",cFilCab)+cChave)
		cDescr := MascaraCTB(cChave) + " " + CT1->CT1_DESC01
	Endif
ElseIf nOrdem == 2
	dbSelectArea("CTT")
	IF MsSeek(xFilial("CTT",cFilCab)+cChave)
		cDescr := cChave + " " + CTT->CTT_DESC01
	EndIf
ElseIf  nOrdem == 3
	dbSelectArea("CTD")
	IF MsSeek(xFilial("CTD",cFilCab)+cChave)
		cDescr := cChave + " " + CTD->CTD_DESC01
	EndIf
ElseIf nOrdem == 4
	dbSelectArea("CTH")
	IF MsSeek(xFilial("CTH",cFilCab)+cChave)
		cDescr := cChave + " " + CTH->CTH_DESC01
	EndIf
EndIf

RestArea(aArea)
Return (cDescr)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณX3ATF บAutor  ณClovis Magenta	         บ Data ณ  18/01/2016 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo copiada da X3Combo() - TECXFUN.PRX - Pasta Materiaisบฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR072                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function X3ATF(cCampo, cCombo)
Local cDescription	:= ""
Local nPosicao1		:= 0

Default cCampo := ''
Default cCombo := ''

If aComboATF == NIL
	aComboATF := U_GetComboATF(cCampo, cCombo)
Endif

nPosicao1 := aScan(aComboATF,{|x| AllTrim(x[1]) == AllTrim(cCombo) })

If ( nPosicao1 <> 0 )
	cDescription := AllTrim(aComboATF[nPosicao1][2])
EndIf

Return cDescription


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetComboATF บAutor  ณClovis Magenta    บ Data ณ  18/01/2016 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ 															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR072                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetComboATF(cCampo, cCombo)
Local aArea    := GetArea()		//Guarda a area atual
Local cBox     := ""			//Conteudo do ComboBox
Local aBox     := {}			//Array com os dados do Combo
Local nPosicao1:= 0				//Posicao 1 no array aBox
Local nPosicao2:= 0				//Posicao do "=" na string

Default cCampo := ''
Default cCombo := ''

DbSelectArea("SX3")
DbSetOrder(2)
If ( DbSeek(cCampo) )
	cBox  := X3CBox()
	While ( !Empty(cBox) )
		nPosicao1   := At(";",cBox)
		If ( nPosicao1 == 0 )
			nPosicao1 := Len(cBox)+1
		EndIf
		nPosicao2   := At("=",cBox)
		aadd(aBox,{ StrTran(SubStr(cBox,1,nPosicao2-1),"&"),SubStr(cBox,nPosicao2+1,nPosicao1-nPosicao2-1) })
		cBox := SubStr(cBox,nPosicao1+1)
	EndDo
EndIf
DbSelectArea("SX3")
DbSetOrder(1)
RestArea(aArea)

Return(aBox)
