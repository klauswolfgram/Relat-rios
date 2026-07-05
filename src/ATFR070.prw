/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR070.CH"
#Include "Protheus.ch"

Static AFCachePict := NIL

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.   
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR070    ³ Autor ³ Cesar C S Prado       ³ Data ³ 05.08.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Posi‡„o Valorizada dos Bens                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR070                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR070()
Local oReport
Private aSelFil	:= {}
Private aSelClass := {}   
PRIVATE cPerg   := "AFR070"   

Pergunte( "AFR070" , .T. )

If mv_par15 == 1 .And. Len( aSelFil ) <= 0 
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		Return
	EndIf 
EndIf 

If mv_par16 == 1
	aSelClass := AdmGetClass()	
	If Len( aSelClass ) <= 0
		Return
	EndIf 
EndIf

/*
* Validação feita quando selecionado multifiliais é preciso que todos os MV_ULTDEPR estejam com a mesma data.
*/
If MV_PAR15 == 1 .and. len(aSelfil) > 1 .and. !VldUltDepr(aSelFil)
	Help(,,"ULTDEPRC",,STR0064,1,0) // "Umas das filiais selecionadas está com a data de última depreciação divergente."
	Return
EndIf

oReport:=ReportDef()
oReport:PrintDialog()

AFCachePict := NIL

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³23/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef
Local oReport
Local oSection1 
Local oSection11
Local oSection12
Local oSubtotal 
Local oTxtBaixa
Local oBaixa
Local oTxtTotBx
Local oTotBaixa
Local oTxtTotGer
Local oTotalGeral
Local oTxtTotGBx
Local oTotGerBx
Local oTxtTotal
Local oTotal
Local cReport := "ATFR070"
Local cTitulo :=	OemToAnsi(STR0003)	//"Posicao Valorizada dos Bens"
Local cDescri :=	OemToAnsi(STR0001) + " " +;	// "Este programa ir  emitir a posi‡„o valorizada dos"
						OemToAnsi(STR0002) + " "   	//"bens em ate 5 (cinco) moedas."
Local aOrd	  := { OemToAnsi(STR0016), OemToAnsi(STR0017), OemToAnsi(STR0021), OemToAnsi(STR0022) }   //"Conta"###"C Custo"
Local bReport := { |oReport|	oReport:SetTitle( oReport:Title() + OemtoAnsi(STR0018) + aOrd[oSection1:GetOrder()] ),;
										ReportPrint( oReport ) }

Local cPerg   := "AFR070"   
Local nTamConta := TamSx3('CT1_CONTA')[1] + 6
Local nTamCT1Desc := TamSx3('CT1_DESC01')[1]
oReport  := TReport():New( cReport, cTitulo, cPerg, bReport, cDescri )

oSection1 := TRSection():New( oReport, STR0035,,aOrd ) // "Entidade Contabil"
TRCell():New( oSection1, "ENTIDADES"	, "",STR0063 /*X3Titulo*/, /*Picture*/, nTamConta /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Código Entidade"
TRCell():New( oSection1, "DESCENTID"	, "",STR0060 /*X3Titulo*/, /*Picture*/, nTamCT1Desc/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //Desc Moeda1
oSection1:SetHeaderSection(.F.)

oSection11 := TRSection():New( oSection1, STR0036 , {"SN3"}) // "Dados da Entidade"
TRCell():New( oSection11, "N3_FILIAL"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "CT1_CONTA"	, "CT1", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "CTT_CUSTO"	, "CTT", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N3_CBASE"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N3_ITEM"		, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N3_TIPO"		, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N1_DESCRIC"	, "SN1", /*X3Titulo*/, /*Picture*/, 35 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 

//Incluido por Jair Ribeiro em 28/04/11
TRCell():New( oSection11, "TPDEPR"		,""		,OEMTOANSI("Tipo Depr."),	,20,,,,.T.,,,,.T.)    		//TIPO DEPRECIACAO

TRCell():New( oSection11, "N1_AQUISIC"	, "SN1", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N3_DTBAIXA"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N1_QUANTD"	, "SN1", /*X3Titulo*/, AFPesqPict("SN1","N1_QUANTD",11) /*Picture*/, 11 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N1_CHAPA"	, "SN1", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N3_CCUSTO"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N3_SUBCTA"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N3_CLVL"		, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oSection11:SetHeaderPage(.T.)

oSection12 := TRSection():New( oSection1, STR0037,{"SN3"}) // "Valores"
TRCell():New( oSection12, "SIMBMOEDA"		, ""	 , STR0038 /*X3Titulo*/, "" /*Picture*/, 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Simbolo Moeda"
TRCell():New( oSection12, "N3_AMPLIA"		, "SN3"	, STR0058, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 	//"Vl Ampliac.1"
TRCell():New( oSection12, "N3_VORIG"		, "", STR0025/*X3Titulo*/,/*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Original"
TRCell():New( oSection12, "VLATUALIZADO"	, "SN3", STR0026 /*X3Titulo*/, AFPesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oSection12, "N3_VRDMES"		, "", STR0027 /*X3Titulo*/, /*Picture*/, 18    /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no mês"
TRCell():New( oSection12, "N3_VRDBAL"		, "", STR0028 /*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no Exerc."
TRCell():New( oSection12, "N3_VRDACM"		, "", STR0029 /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. Acumulada"
TRCell():New( oSection12, "N3_VRCMES1"		, "SN3", /*X3Titulo*/, /*Picture*/, 15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection12, "N3_VRCBAL1"		, "SN3", /*X3Titulo*/, /*Picture*/, 17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection12, "N3_VRCACM1"		, "SN3", /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection12, "N3_VRCDM1"		, "SN3", /*X3Titulo*/, /*Picture*/,  15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection12, "N3_VRCDB1"		, "SN3", /*X3Titulo*/, /*Picture*/,  17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection12, "N3_VRCDA1"		, "SN3", /*X3Titulo*/, /*Picture*/,  19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oSection12:SetHeaderPage(.T.)
oSection12:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")

oTxtSubTot  := TRSection():New( oSection1, STR0039 ) //"Texto Sub-total"
TRCell():New( oTxtSubTot, "FILIAL"		, "",  STR0057 /*X3Titulo*/, /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTxtSubTot, "ENTIDADE"	, "" , STR0042 /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Entidade"
TRCell():New( oTxtSubTot, "QUANTIDADE"	, "" , STR0043 /*X3Titulo*/, "" /*Picture*/, 20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // Quantidade
oTxtSubTot:SetHeaderSection(.F.)
oTxtSubTot:SetLeftMargin(7)

oSubTotal  := TRSection():New( oSection1, STR0040 ) //"Valores Sub-total"
TRCell():New( oSubTotal, "SIMBMOEDA"		, "", STR0038 /*X3Titulo*/, "" /*Picture*/, 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSubTotal, "N3_AMPLIA"		, "SN3", STR0058, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 	//"Vl Ampliac.1"
TRCell():New( oSubTotal, "N3_VORIG"			, "", STR0025/*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Original"
TRCell():New( oSubTotal, "VLATUALIZADO"	, "SN3", STR0026 /*X3Titulo*/, AFPesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oSubTotal, "N3_VRDMES"		, "", STR0027 /*X3Titulo*/, /*Picture*/, 18    /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no mês"
TRCell():New( oSubTotal, "N3_VRDBAL"		, "", STR0028 /*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no Exerc."
TRCell():New( oSubTotal, "N3_VRDACM"		, "", STR0029 /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. Acumulada"
TRCell():New( oSubTotal, "N3_VRCMES1"		, "SN3", /*X3Titulo*/, /*Picture*/, 15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSubTotal, "N3_VRCBAL1"		, "SN3", /*X3Titulo*/, /*Picture*/, 17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSubTotal, "N3_VRCACM1"		, "SN3", /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSubTotal, "N3_VRCDM1"		, "SN3", /*X3Titulo*/, /*Picture*/,  15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSubTotal, "N3_VRCDB1"		, "SN3", /*X3Titulo*/, /*Picture*/,  17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSubTotal, "N3_VRCDA1"		, "SN3", /*X3Titulo*/, /*Picture*/,  19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oSubTotal:SetHeaderSection(.F.)

oTxtBaixa   := TRSection():New( oReport, STR0041 ) // "Texto Baixa"
TRCell():New( oTxtBaixa, "TEXTO"	, ""	 , STR0044 /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Baixa"
TRCell():New( oTxtBaixa, "QUANTIDADE"	 , ""	 , STR0043 /*X3Titulo*/, "" /*Picture*/, 20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oTxtBaixa:SetHeaderSection(.F.)
oTxtBaixa:SetLeftMargin(7)

oBaixa  := TRSection():New( oReport, STR0045 ) // "Valores de baixa"
TRCell():New( oBaixa, "SIMBMOEDA"		, "", STR0038 /*X3Titulo*/, "" /*Picture*/, 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oBaixa, "N3_AMPLIA"		, "SN3", STR0058, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 	//"Vl Ampliac.1"
TRCell():New( oBaixa, "N3_VORIG"			, "", STR0025/*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Original"
TRCell():New( oBaixa, "VLATUALIZADO"	, "SN3", STR0026 /*X3Titulo*/, AFPesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oBaixa, "N3_VRDMES"		, "", STR0027 /*X3Titulo*/, /*Picture*/, 18    /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no mês"
TRCell():New( oBaixa, "N3_VRDBAL"		, "", STR0028 /*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no Exerc."
TRCell():New( oBaixa, "N3_VRDACM"		, "", STR0029 /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. Acumulada"
TRCell():New( oBaixa, "N3_VRCMES1"		, "SN3", /*X3Titulo*/, /*Picture*/, 15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oBaixa, "N3_VRCBAL1"		, "SN3", /*X3Titulo*/, /*Picture*/, 17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oBaixa, "N3_VRCACM1"		, "SN3", /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oBaixa, "N3_VRCDM1"		, "SN3", /*X3Titulo*/, /*Picture*/,  15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oBaixa, "N3_VRCDB1"		, "SN3", /*X3Titulo*/, /*Picture*/,  17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oBaixa, "N3_VRCDA1"		, "SN3", /*X3Titulo*/, /*Picture*/,  19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oBaixa:SetHeaderSection(.F.)

oTxtTotBx   := TRSection():New( oReport, STR0046 ) // "Texto Total de Baixa"
TRCell():New( oTxtTotBx, "TEXTO"	, "", STR0055 /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Total de Baixas"
oTxtTotBx:SetHeaderSection(.F.)
oTxtTotBx:SetLeftMargin(7)

oTotBaixa  := TRSection():New( oReport, STR0047 ) // "Valores do Total de Baixas"
TRCell():New( oTotBaixa, "SIMBMOEDA"		, "", STR0038 /*X3Titulo*/, "" /*Picture*/, 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotBaixa, "N3_AMPLIA"		, "SN3", STR0058, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 	//"Vl Ampliac.1"
TRCell():New( oTotBaixa, "N3_VORIG"			, "", STR0025/*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Original"
TRCell():New( oTotBaixa, "VLATUALIZADO"	, "SN3", STR0026 /*X3Titulo*/, AFPesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oTotBaixa, "N3_VRDMES"		, "", STR0027 /*X3Titulo*/, /*Picture*/, 18    /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no mês"
TRCell():New( oTotBaixa, "N3_VRDBAL"		, "", STR0028 /*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no Exerc."
TRCell():New( oTotBaixa, "N3_VRDACM"		, "", STR0029 /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. Acumulada"
TRCell():New( oTotBaixa, "N3_VRCMES1"		, "SN3", /*X3Titulo*/, /*Picture*/, 15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotBaixa, "N3_VRCBAL1"		, "SN3", /*X3Titulo*/, /*Picture*/, 17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotBaixa, "N3_VRCACM1"		, "SN3", /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotBaixa, "N3_VRCDM1"		, "SN3", /*X3Titulo*/, /*Picture*/,  15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotBaixa, "N3_VRCDB1"		, "SN3", /*X3Titulo*/, /*Picture*/,  17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotBaixa, "N3_VRCDA1"		, "SN3", /*X3Titulo*/, /*Picture*/,  19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oTotBaixa:SetHeaderSection(.F.)

oTxtTotGer  := TRSection():New( oReport, STR0048 ) // "Texto Total Geral"
TRCell():New( oTxtTotGer, "TEXTO"	, "", STR0056 /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Total Geral"
TRCell():New( oTxtTotGer, "QUANTIDADE"	 , ""	 , STR0043 /*X3Titulo*/, "" /*Picture*/, 20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oTxtTotGer:SetHeaderSection(.F.)
oTxtTotGer:SetLeftMargin(7)

oTotalGeral := TRSection():New( oReport, STR0049) // "Valores do Total Geral"
TRCell():New( oTotalGeral , "SIMBMOEDA"		, "", STR0038 /*X3Titulo*/, "" /*Picture*/, 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotalGeral , "N3_AMPLIA"		, "SN3", STR0058, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 	//"Vl Ampliac.1"
TRCell():New( oTotalGeral , "N3_VORIG"			, "", STR0025/*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Original"
TRCell():New( oTotalGeral , "VLATUALIZADO"	, "SN3", STR0026 /*X3Titulo*/, AFPesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oTotalGeral , "N3_VRDMES"		, "", STR0027 /*X3Titulo*/, /*Picture*/, 18    /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no mês"
TRCell():New( oTotalGeral , "N3_VRDBAL"		, "", STR0028 /*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no Exerc."
TRCell():New( oTotalGeral , "N3_VRDACM"		, "", STR0029 /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. Acumulada"
TRCell():New( oTotalGeral , "N3_VRCMES1"		, "SN3", /*X3Titulo*/, /*Picture*/, 15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotalGeral , "N3_VRCBAL1"		, "SN3", /*X3Titulo*/, /*Picture*/, 17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotalGeral , "N3_VRCACM1"		, "SN3", /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotalGeral , "N3_VRCDM1"		, "SN3", /*X3Titulo*/, /*Picture*/,  15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotalGeral , "N3_VRCDB1"		, "SN3", /*X3Titulo*/, /*Picture*/,  17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotalGeral , "N3_VRCDA1"		, "SN3", /*X3Titulo*/, /*Picture*/,  19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oTotalGeral:SetHeaderSection(.F.)

oTxtTotGBx  := TRSection():New( oReport, STR0050) // "Texto Total Geral de Baixa"
TRCell():New( oTxtTotGBx, "TEXTO"	, ""	 , STR0051 /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Total Geral de Baixa"
TRCell():New( oTxtTotGBx, "QUANTIDADE"	 , ""	 , STR0043 /*X3Titulo*/, "" /*Picture*/, 20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oTxtTotGBx:SetHeaderSection(.F.)
oTxtTotGBx:SetLeftMargin(7)

oTotGerBx := TRSection():New( oReport, STR0030 ) //"Valores de Total Geral de Baixa"
TRCell():New( oTotGerBx , "SIMBMOEDA"		, "" , STR0038 /*X3Titulo*/, "" /*Picture*/, 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotGerBx , "N3_AMPLIA"		, "SN3", STR0058, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 	//"Vl Ampliac.1"
TRCell():New( oTotGerBx , "N3_VORIG"			, "", STR0025/*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Original"
TRCell():New( oTotGerBx , "VLATUALIZADO"	, "SN3", STR0026 /*X3Titulo*/, AFPesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oTotGerBx , "N3_VRDMES"		, "", STR0027 /*X3Titulo*/, /*Picture*/, 18    /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no mês"
TRCell():New( oTotGerBx , "N3_VRDBAL"		, "", STR0028 /*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no Exerc."
TRCell():New( oTotGerBx , "N3_VRDACM"		, "", STR0029 /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. Acumulada"
TRCell():New( oTotGerBx , "N3_VRCMES1"		, "SN3", /*X3Titulo*/, /*Picture*/, 15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotGerBx , "N3_VRCBAL1"		, "SN3", /*X3Titulo*/, /*Picture*/, 17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotGerBx , "N3_VRCACM1"		, "SN3", /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotGerBx , "N3_VRCDM1"		, "SN3", /*X3Titulo*/, /*Picture*/,  15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotGerBx , "N3_VRCDB1"		, "SN3", /*X3Titulo*/, /*Picture*/,  17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotGerBx , "N3_VRCDA1"		, "SN3", /*X3Titulo*/, /*Picture*/,  19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oTotGerBx:SetHeaderSection(.F.)

oTxtTotal   := TRSection():New( oReport, STR0052 )
TRCell():New( oTxtTotal, "TEXTO"	, "", STR0053 /*X3Titulo*/, "" /*Picture*/, 70 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oTxtTotal:SetHeaderSection(.F.)
oTxtTotal:SetLeftMargin(7)

oTotal  := TRSection():New( oReport, STR0054 ) // 
TRCell():New( oTotal, "SIMBMOEDA"		, "", STR0038 /*X3Titulo*/, "" /*Picture*/, 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotal, "N3_AMPLIA"		, "SN3", STR0058, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 	//"Vl Ampliac.1"
TRCell():New( oTotal, "N3_VORIG"			, "", STR0025/*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Original"
TRCell():New( oTotal, "VLATUALIZADO"	, "SN3", STR0026 /*X3Titulo*/, AFPesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Valor Atualizado"
TRCell():New( oTotal, "N3_VRDMES"		, "", STR0027 /*X3Titulo*/, /*Picture*/, 18    /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no mês"
TRCell():New( oTotal, "N3_VRDBAL"		, "", STR0028 /*X3Titulo*/, /*Picture*/, 18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. no Exerc."
TRCell():New( oTotal, "N3_VRDACM"		, "", STR0029 /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Deprec. Acumulada"
TRCell():New( oTotal, "N3_VRCMES1"		, "SN3", /*X3Titulo*/, /*Picture*/, 15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotal, "N3_VRCBAL1"		, "SN3", /*X3Titulo*/, /*Picture*/, 17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotal, "N3_VRCACM1"		, "SN3", /*X3Titulo*/, /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotal, "N3_VRCDM1"		, "SN3", /*X3Titulo*/, /*Picture*/,  15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotal, "N3_VRCDB1"		, "SN3", /*X3Titulo*/, /*Picture*/,  17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oTotal, "N3_VRCDA1"		, "SN3", /*X3Titulo*/, /*Picture*/,  19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 

oTotal:SetHeaderSection(.F.)

oSection11:SetColSpace(2)
oSection12:SetColSpace(0)
oSubTotal:SetColSpace(0)
oBaixa:SetColSpace(0)
oTotBaixa:SetColSpace(0)
oTotalGeral:SetColSpace(0)
oTotGerBx:SetColSpace(0)
oTotal:SetColSpace(0)
oReport:SetLandScape()

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Claudio D. de Souza º Data ³  24/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao do relatorio                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ATFR070                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport as object)
Local oSection1			as object
Local oSection11		as object
Local oSection12		as object
Local oTxtSubtotal		as object
Local oSubtotal			as object
Local oTxtBaixa			as object
Local oBaixa			as object
Local oTxtTotBx			as object
Local oTotBaixa			as object
Local oTxtTotGer		as object
Local oTotalGeral		as object
Local oTxtTotGBx		as object
Local oTotGerBx			as object
Local oTxtTotal			as object
Local oTotal			as object
Local aTotGeral			as array
Local aTQuebra1  		as array
Local aTotBaixa	 		as array
Local aTotGBx	 		as array
Local nSuf       		as numeric
Local nMoedas    		as numeric
Local lDescricao 		as logical
Local cMoedas    		as character
Local nQuantidade 		as numeric
Local nQuantBx			as numeric
Local nTotal 	 		as numeric
Local nTotBx 	 		as numeric
Local nOrdem 			as numeric
Local dUltDepr   		as date
Local cGrupoPass 		as character
Local lCtb 		 		as logical
Local cAliasQry			as character
Local nCount        	as numeric
Local cAtfCont	 		as character
Local cQuery			as character
Local cOrdem			as character
Local nCpo				as numeric
Local cSuf				as character
Local nVlrAtual			as numeric
Local cCabCond1 		as character
Local cCabCond2 		as character
Local cFilQbr1			as character
Local cEntQbr1  		as character
Local n_pag 			as numeric
Local cTmpSN3Fi1		as character
Local cCampSn3 			as character
Local lAtClDepr 		as logical
Local lRealProv			as logical

Default oReport			:= Nil

oSection1	 	:= oReport:Section(1)
oSection11	 	:= oReport:Section(1):Section(1)
oSection12	 	:= oReport:Section(1):Section(2)
oTxtSubtotal 	:= oReport:Section(1):Section(3)
oSubtotal 	 	:= oReport:Section(1):Section(4)
oTxtBaixa	 	:= oReport:Section(2)
oBaixa	 	 	:= oReport:Section(3)
oTxtTotBx	 	:= oReport:Section(4)
oTotBaixa	 	:= oReport:Section(5)
oTxtTotGer	 	:= oReport:Section(6)
oTotalGeral	 	:= oReport:Section(7)
oTxtTotGBx	 	:= oReport:Section(8)
oTotGerBx	 	:= oReport:Section(9)
oTxtTotal	 	:= oReport:Section(10)
oTotal	 	 	:= oReport:Section(11)
aTotGeral  		:= {}
aTQuebra1  		:= {}
aTotBaixa	 	:= {}
aTotGBx	  		:= {}
nSuf       		:= 0
nMoedas    		:= 1
lDescricao 		:= .F.
cMoedas    		:= "S"
nQuantidade 	:= 0
nQuantBx		:= 0
nTotal 	 		:= 0
nTotBx 	 		:= 0
nOrdem 			:= 0
dUltDepr   		:= SuperGetMv("MV_ULTDEPR")
cGrupoPass 		:= SuperGetMv("MV_GRPASS")
lCtb 		 	:= CtbInUse()
cAliasQry		:= ""
nCount        	:= 0
cAtfCont	 	:= SuperGetMv("MV_ATFCONT")
cQuery			:= ""
cOrdem			:= ""
nCpo			:= 0
cSuf			:= ""
nVlrAtual		:= 0
cCabCond1 		:= ""
cCabCond2 		:= ""
cFilQbr1		:= ""
cEntQbr1  		:= ""  
n_pag 			:= mv_par11
cTmpSN3Fi1		:= ""
cCampSn3 		:= ""

// Verificação da classificação de Ativo se sofre depreciação
lAtClDepr 		:= .F.
lRealProv		:= .F.

oReport:SetPageNumber(n_pag)

//Controle de reincio da numeracao de paginas
oReport:OnPageBreak( {|| If((n_pag+1) > mv_par12, (n_pag := mv_par13,oReport:SetPageNumber(n_pag-1)),n_pag += 1) } ) 



oSection11:Cell("CT1_CONTA"):Disable()
oSection11:Cell("CTT_CUSTO"):Disable()
oSection11:Cell("N3_CCUSTO"):Disable()
oSection11:Cell("N3_SUBCTA"):Disable()
oSection11:Cell("N3_CLVL"):Disable()

oSection12:Cell("SIMBMOEDA"):SetTitle("")
oSubTotal:Cell("SIMBMOEDA"):SetTitle("")
oBaixa:Cell("SIMBMOEDA"):SetTitle("")
oTotBaixa:Cell("SIMBMOEDA"):SetTitle("")
oTotalGeral:Cell("SIMBMOEDA"):SetTitle("")
oTotGerBx:Cell("SIMBMOEDA"):SetTitle("")
oTotal:Cell("SIMBMOEDA"):SetTitle("")


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Zera os arquivos de acumulado                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCount := 1 To 5
	AAdd(aTotGeral, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} )
	AAdd(aTQuebra1, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} )
	AAdd(aTotBaixa, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} )
	AAdd(aTotGBx, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} )
Next

cMoedas += IIF(MV_PAR06 == 1, "S", "N");    nMoedas += IIF(MV_PAR06 == 1, 1, 0)
cMoedas += IIF(MV_PAR07 == 1, "S", "N");    nMoedas += IIF(MV_PAR07 == 1, 1, 0)
cMoedas += IIF(MV_PAR08 == 1, "S", "N");    nMoedas += IIF(MV_PAR08 == 1, 1, 0)
cMoedas += IIF(MV_PAR09 == 1, "S", "N");    nMoedas += IIF(MV_PAR09 == 1, 1, 0)

IF oSection1:GetOrder() == 1
	nOrdem := 4
	cCabCond1 := OemToAnsi(STR0007) //"Conta   : "
	cCabCond2 := OemToAnsi(STR0008) //"C.Custo : "
ElseIf oSection1:GetOrder() == 2
	nOrdem := 5
	cCabCond1 := OemToAnsi(STR0008) //"C.Custo : "
	cCabCond2 := OemToAnsi(STR0007) //"Conta   : "
ElseIf oSection1:GetOrder() == 3
	nOrdem := 6
	cCabCond1 := OemToAnsi(STR0021) //"Item Contabil"
	cCabCond2 := OemToAnsi(STR0008) //"C.Custo : "	
ElseIf oSection1:GetOrder() == 4
	nOrdem := 7
	cCabCond1 := OemToAnsi(STR0022) //"Classe de Valor"
	cCabCond2 := OemToAnsi(STR0021) //"Item Contabil"
End

dbSelectArea("SN3")
dbSetOrder( nOrdem )
cOrdem	:= IndexKey()

/*
 * Verificação do campo para ativos de custo de provisão
 */
lRealProv := .T.

cAliasQry := GetNextAlias()
aCpos := SN3->(dbStruct())

cQuery := " SELECT "
	For  nCount := 1 to len(aCpos)
			cCampSn3 += aCpos[nCount][1] +","	  	
	Next nCount
	cCampSn3 := substr(cCampSn3,1,len(cCampSn3)-1)
cQuery += cCampSn3
cQuery += " , R_E_C_N_O_ "
cQuery += "  FROM "+RetSqlName("SN3")+" "
If MV_PAR15 == 1 .and. len(aSelfil) > 1
cQuery += " WHERE N3_FILIAL " + GetRngFil( aSelFil ,"SN3", .T., @cTmpSN3Fi1) +" AND "
else
	cQuery += " WHERE N3_FILIAL = '" + xFilial('SN3') + "' AND "
EndIf
cQuery += " N3_CCONTAB >= '"+mv_par01+"' AND "
cQuery += " N3_CCONTAB <= '"+mv_par02+"' AND "
cQuery += " N3_CCUSTO >= '"+mv_par03+"' AND "
cQuery += " N3_CCUSTO <= '"+mv_par04+"' AND "
cQuery += " N3_TIPO <> '33' AND "
If lRealProv .AND. MV_PAR17 == 2
	cQuery += " N3_ATFCPR IN ('2', ' ') AND "
EndIf
cQuery += " D_E_L_E_T_ = ' ' "
cOrdem	:= SqlOrder(cOrdem)
cQuery += " ORDER BY "+cOrdem
cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

For nCpo := 1 To Len(aCpos)
	// Avalia a estrutura do arquivo a ser aberto. Se o campo estiver na query e for diferente 
	// de caracter, altera o atributo do campo.
	If aCpos[nCpo][2] <> "C" .And. (cAliasQry)->(FieldPos(aCpos[nCpo][1])) > 0
		TCSetField(cAliasQry,aCpos[nCpo][1],aCpos[nCpo][2],aCpos[nCpo][3], aCpos[nCpo][4])
	Endif
Next

IF oSection1:GetOrder() == 1
	oSection11:Cell("CTT_CUSTO"):SetBlock({|| (cAliasQry)->N3_CCUSTO })
	oSection11:Cell("CTT_CUSTO"):Enable()
Else
	oSection11:Cell("CT1_CONTA"):SetBlock({|| (cAliasQry)->N3_CCONTAB })
	oSection11:Cell("CT1_CONTA"):Enable()
EndIf
If oSection1:GetOrder() == 3
	oSection11:Cell("N3_CCUSTO"):Enable()
Else
	oSection11:Cell("N3_SUBCTA"):Enable()
EndIf
If oSection1:GetOrder() == 4
	oSection11:Cell("N3_CCUSTO"):Enable()
Else
	oSection11:Cell("N3_CLVL"):Enable()
EndIf

cFilterUser := oSection1:GetAdvplExp("SN3")

ATFAdjFil(@cFilterUser)

While (cAliasQry)->(!Eof()) .And. !oReport:Cancel()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica a parametriza‡„o antes mesmo de entrar no detalhe ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nQuantidade := 0
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If !Empty(cFilterUser).and.!(&cFilterUser)
		dbSelectArea(cAliasQry)
		dbSkip()
		Loop
	Endif
	
	SN3->(dbGoto((cAliasQry)->R_E_C_N_O_ )) //POSICIONA NA SN3 para personalizado o SN3 precisa estar posicionado

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Controla a quebra no 1o. nivel                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cFilQbr1 := (cAliasQry)->N3_FILIAL
	IF oSection1:GetOrder() == 1
		cEntQbr1 := (cAliasQry)->N3_CCONTAB
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->N3_FILIAL +" + cAliasQry + "->N3_CCONTAB == cQuebra1"
	ElseIf oSection1:GetOrder() == 2
		cEntQbr1 := (cAliasQry)->N3_CCUSTO
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->N3_FILIAL +" + cAliasQry + "->N3_CCUSTO == cQuebra1"
	ElseIf oSection1:GetOrder() == 3
		cEntQbr1 := (cAliasQry)->N3_SUBCTA
		cQuebra1 :=  cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->N3_FILIAL +" + cAliasQry + "->N3_SUBCTA == cQuebra1"
	ElseIf oSection1:GetOrder() == 4
		cEntQbr1 := (cAliasQry)->N3_CLVL
		cQuebra1 := cFilQbr1 + cEntQbr1
		cCond1   := cAliasQry + "->N3_FILIAL +" + cAliasQry + "->N3_CLVL == cQuebra1"
	EndIf
	
	dbSelectArea(cAliasQry)
    
	IF Empty(cEntQbr1)
		dbSkip()
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ No caso de considerar baixas, Dever  somar³
	//³ somente os valores de deprecia‡ao mensal, ³
	//³ para que o relat¢rio fique 'batido' com o ³
	//³ razao.                                    ³
	//³ Desconsidera os Bens Baixados. Mas os bens³
	//³ baixados no mes do ultimo calculo devem a-³
	//³ parecer no relatorio.                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par10 == 2  .and. mv_par14 <> 1// Nao considera nenhuma baixa e não imprime baixas
		If	Val((cAliasQry)->N3_BAIXA) != 0
			dbSkip()
			Loop
		Endif
	Elseif mv_par10 == 3	// Baixas ate o calculo
		If !Empty((cAliasQry)->N3_DTBAIXA) .And. (cAliasQry)->N3_DTBAIXA > dUltDepr
			dbSkip()
			Loop
		EndIf
	Elseif mv_par10 == 4 	// Baixas apos o calculo
		If !Empty((cAliasQry)->N3_DTBAIXA) .And. (cAliasQry)->N3_DTBAIXA <= dUltDepr
			dbSkip()
			Loop
		EndIf
	Endif
    
	lDescricao := .F.
    
	While (cAliasQry)->(!Eof()) .AND. &cCond1 .And. !oReport:Cancel()
        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFilterUser).and.!(&cFilterUser)
			dbSelectArea(cAliasQry)
			dbSkip()
			Loop
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza item no SN1                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SN1->(MsSeek(xFilial("SN1", (cAliasQry)->(N3_FILIAL) ) +(cAliasQry)->N3_CBASE+(cAliasQry)->N3_ITEM))
		
		SN3->(dbGoto((cAliasQry)->R_E_C_N_O_ )) //POSICIONA NA SN3 para personalizado o SN3 precisa estar posicionado
		//Filtra as classificações patrimoniais. Não fiz na query pra não alterar a estrutura
		If Len(aSelClass) > 0
			If !(SN1->N1_PATRIM $ FORMATCLAS(aSelClass))
				dbSelectArea(cAliasQry)
				dbSkip()
				Loop
			EndIf
		EndIf

		If !lDescricao
			AFR070R4Cab(oSection1:GetOrder(),cFilQbr1,cEntQbr1, oReport)
			lDescricao := .T.
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ No caso de considerar baixas, Dever  somar³
		//³ somente os valores de deprecia‡ao mensal, ³
		//³ para que o relat¢rio fique 'batido' com o ³
		//³ razao.                                    ³
		//³ Desconsidera os Bens Baixados. Mas os bens³
		//³baixados no mes do ultimo calculo devem a- ³
		//³parecer no relatorio.                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If	Val((cAliasQry)->N3_BAIXA) != 0
			If (mv_par10 == 2 .Or. mv_par10 == 4) .and.;
				((cAliasQry)->N3_DTBAIXA > dUltDepr) .and. (cAtfCont != 'O')
				
				// MV_PAR10 - Quanto as baixas:
				// 1 - Todas
				// 2 - Nenhuma
				// 3 - Ate o Calculo
				// 4 - Apos o Calculo
				// 5 - Més do Calculo
				// Elimina os bens baixados em datas anteriores ao mes do ultimo calculo
				
				// Para que os valores de depreciacao no Razao e o Posicao Valorizada
				// fiquem coerentes devem ser analizados:
				// 1- Se a data da baixa do Bem foi apos o ultimo calculo da deprecicao
				// 2- Se o paramentro MV_ATFCONT esta como "0" - Online
				// Nestas situacoes, os saldos das contas de depreciacao exibidos no Razao ja estao atualizados,
				// portanto o Posicao Valorizada deve refletir estes valores
				
				For nSuf := 1 To 5
					IF SubStr(cMoedas,nSuf,1) == "S"
						cSuf      := Str(nSuf,1)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Totaliza para quebra no 1o. Nivel                             ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						// Ajusta o totalizador da depreciacao acumulada e do exercicio quando houver
						// baixa. Se nao fizer este ajuste, a soma da depreciacao do mes anterior mais
						// a depreciacao do mes atual nao conferem com a depreciacao do exercicio, quando
						// houver baixa.
						aTquebra1[nSuf][04] += (&(cAliasQry+'->N3_VRDBAL'+cSuf)-&(cAliasQry+'->N3_VRDMES'+cSuf))
						If &(cAliasQry+'->N3_VRDMES'+cSuf) > 0
							aTquebra1[nSuf][05] += (&(cAliasQry+'->N3_VRDACM'+cSuf)-&(cAliasQry+'->N3_VRDMES'+cSuf))
						Endif
					Endif
				Next
			Endif
			// Imprime totais para comparação com o Razão (ATFR130)
			If mv_par14 == 1
				If  mv_par10 == 2 .or. mv_par10 == 4
					For nSuf := 1 To 5
						If SubStr(cMoedas,nSuf,1) == "S"
							cSuf      := Str(nSuf,1)
							// Verificação da classificação de Ativo se sofre depreciação
							lAtClDepr := AtClssVer(SN1->N1_PATRIM)
					
							If lAtClDepr .OR. SN1->N1_PATRIM $ "P "
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ Totaliza para quebra no 1o. Nivel                             ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								// Tem de somar as depreciações de baixas do mês
								If Month((cAliasQry)->N3_DTBAIXA) == Month(dUltDepr) .AND. Year((cAliasQry)->N3_DTBAIXA) == Year(dUltDepr)
									aTotBaixa[nSuf][03] += IIf (Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr),&(cAliasQry + '->N3_VRDMES'+cSuf),0)
									IF cSuf == "1"
										aTotBaixa[nSuf][09] += &(cAliasQry + '->N3_VRCDM'+cSuf)
									EndIf
								EndIf
								If mv_par10 == 4
									If (cAliasQry)->N3_DTBAIXA > dUltDepr
										aTotBaixa[nSuf][01] -= &(cAliasQry + '->N3_VORIG'+cSuf)
										aTotBaixa[nSuf][02] -= (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_VRCACM1 + (cAliasQry)->N3_AMPLIA1
										aTotBaixa[nSuf][04] -= &(cAliasQry + '->N3_VRDBAL'+cSuf)
										aTotBaixa[nSuf][05] -= &(cAliasQry + '->N3_VRDACM'+cSuf)
										aTotBaixa[nSuf][13] -= &(cAliasQry + '->N3_AMPLIA'+cSuf)
										If cSuf == "1"
											aTotBaixa[nSuf][06] -= &(cAliasQry + '->N3_VRCMES'+cSuf)
											aTotBaixa[nSuf][07] -= &(cAliasQry + '->N3_VRCBAL'+cSuf)
											aTotBaixa[nSuf][08] -= &(cAliasQry + '->N3_VRCACM'+cSuf)
											aTotBaixa[nSuf][10] -= &(cAliasQry + '->N3_VRCDB'+cSuf)
											aTotBaixa[nSuf][11] -= &(cAliasQry + '->N3_VRCDA'+cSuf)
										EndIf
									EndIf
								EndIf
								aTotBaixa[nSuf][12] += 1
							Else
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ Totaliza para quebra no 1o. Nivel                             ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								If Month((cAliasQry)->N3_DTBAIXA) == Month(dUltDepr) .AND. Year((cAliasQry)->N3_DTBAIXA) == Year(dUltDepr)
									aTotBaixa[nSuf][03] -= IIf(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr),&(cAliasQry + '->N3_VRDMES'+cSuf),0)
									If cSuf == "1"
										aTotBaixa[nSuf][09] -= &(cAliasQry + '->N3_VRCDM'+cSuf)
									EndIf
								EndIf
								If mv_par10 == 4
									If (cAliasQry)->N3_DTBAIXA > dUltDepr
										aTotBaixa[nSuf][01] += &(cAliasQry + '->N3_VORIG'+cSuf)
										aTotBaixa[nSuf][02] += (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_VRCACM1 + (cAliasQry)->N3_AMPLIA1
										aTotBaixa[nSuf][04] += &(cAliasQry + '->N3_VRDBAL'+cSuf)
										aTotBaixa[nSuf][05] += &(cAliasQry + '->N3_VRDACM'+cSuf)
										aTotBaixa[nSuf][13] += &(cAliasQry + '->N3_AMPLIA'+cSuf)
										If cSuf == "1"
											aTotBaixa[nSuf][06] += &(cAliasQry + '->N3_VRCMES'+cSuf)
											aTotBaixa[nSuf][07] += &(cAliasQry + '->N3_VRCBAL'+cSuf)
											aTotBaixa[nSuf][08] += &(cAliasQry + '->N3_VRCACM'+cSuf)
											aTotBaixa[nSuf][10] += &(cAliasQry + '->N3_VRCDB'+cSuf)
											aTotBaixa[nSuf][11] += &(cAliasQry + '->N3_VRCDA'+cSuf)
										EndIf
									EndIf
								EndIf
								aTotBaixa[nSuf][12] += 1
							EndIf
						EndIf
					Next
				ElseIf  mv_par10 == 1 .or. mv_par10 == 3 .or. mv_par10 == 5
					For nSuf := 1 To 5
						If SubStr(cMoedas,nSuf,1) == "S"
							cSuf      := Str(nSuf,1)
							// Verificação da classificação de Ativo se sofre depreciação
							lAtClDepr := AtClssVer(SN1->N1_PATRIM)
					
							If lAtClDepr .OR. SN1->N1_PATRIM $ "P "
								If mv_par10 ==1 // Considera Todas as Baixas
									//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
									//³ Totaliza para quebra no 1o. Nivel                             ³
									//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
									aTotBaixa[nSuf][01] -= &(cAliasQry + '->N3_VORIG'+cSuf)
									aTotBaixa[nSuf][02] -= (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_VRCACM1 + (cAliasQry)->N3_AMPLIA1
									aTotBaixa[nSuf][04] -= &(cAliasQry + '->N3_VRDBAL'+cSuf)
									aTotBaixa[nSuf][05] -= &(cAliasQry + '->N3_VRDACM'+cSuf)
									aTotBaixa[nSuf][13] -= &(cAliasQry + '->N3_AMPLIA'+cSuf)
									If cSuf == "1"
										aTotBaixa[nSuf][06] -= &(cAliasQry + '->N3_VRCMES'+cSuf)
										aTotBaixa[nSuf][07] -= &(cAliasQry + '->N3_VRCBAL'+cSuf)
										aTotBaixa[nSuf][08] -= &(cAliasQry + '->N3_VRCACM'+cSuf)
										aTotBaixa[nSuf][10] -= &(cAliasQry + '->N3_VRCDB'+cSuf)
										aTotBaixa[nSuf][11] -= &(cAliasQry + '->N3_VRCDA'+cSuf)
									EndIf
									// Para a Depreciação do mês tem de tirar as diferentes do mes da última depreciação calculada
									If !(Month((cAliasQry)->N3_DTBAIXA) == Month(dUltDepr) .AND. Year((cAliasQry)->N3_DTBAIXA) == Year(dUltDepr))
										aTotBaixa[nSuf][03] -= IIf(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr),&(cAliasQry + '->N3_VRDMES'+cSuf),0)
										If cSuf == "1"
											aTotBaixa[nSuf][09] -= &(cAliasQry + '->N3_VRCDM'+cSuf)
										EndIf
									EndIf
								ElseIf mv_par10 == 3	// Baixas ate o calculo
									If (cAliasQry)->N3_DTBAIXA <= dUltDepr
										//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
										//³ Totaliza para quebra no 1o. Nivel                             ³
										//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
										aTotBaixa[nSuf][01] -= &(cAliasQry + '->N3_VORIG'+cSuf)
										aTotBaixa[nSuf][02] -= (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_VRCACM1 + (cAliasQry)->N3_AMPLIA1
										aTotBaixa[nSuf][04] -= &(cAliasQry + '->N3_VRDBAL'+cSuf)
										aTotBaixa[nSuf][05] -= &(cAliasQry + '->N3_VRDACM'+cSuf)
										aTotBaixa[nSuf][13] -= &(cAliasQry + '->N3_AMPLIA'+cSuf)
										If cSuf == "1"
											aTotBaixa[nSuf][06] -= &(cAliasQry + '->N3_VRCMES'+cSuf)
											aTotBaixa[nSuf][07] -= &(cAliasQry + '->N3_VRCBAL'+cSuf)
											aTotBaixa[nSuf][08] -= &(cAliasQry + '->N3_VRCACM'+cSuf)
											aTotBaixa[nSuf][10] -= &(cAliasQry + '->N3_VRCDB'+cSuf)
											aTotBaixa[nSuf][11] -= &(cAliasQry + '->N3_VRCDA'+cSuf)
										EndIf
										// Para a Depreciação do mês tem de tirar as diferentes do mes da última depreciação calculada
										If !(Month((cAliasQry)->N3_DTBAIXA) == Month(dUltDepr) .AND. Year((cAliasQry)->N3_DTBAIXA) == Year(dUltDepr))
											aTotBaixa[nSuf][03] -= IIf(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr),&(cAliasQry + '->N3_VRDMES'+cSuf),0)
											If cSuf == "1"
												aTotBaixa[nSuf][09] -= &(cAliasQry + '->N3_VRCDM'+cSuf)
											EndIf
										EndIf
									EndIf
								ElseIf mv_par10 == 5 	// Mes do Calculo
									If (Month((cAliasQry)->N3_DTBAIXA) == Month(dUltDepr) .AND. Year((cAliasQry)->N3_DTBAIXA) == Year(dUltDepr))
										//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
										//³ Totaliza para quebra no 1o. Nivel                             ³
										//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
										aTotBaixa[nSuf][01] -= &(cAliasQry + '->N3_VORIG'+cSuf)
										aTotBaixa[nSuf][02] -= (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_VRCACM1 + (cAliasQry)->N3_AMPLIA1
										aTotBaixa[nSuf][04] -= &(cAliasQry + '->N3_VRDBAL'+cSuf)
										aTotBaixa[nSuf][05] -= &(cAliasQry + '->N3_VRDACM'+cSuf)
										aTotBaixa[nSuf][13] -= &(cAliasQry + '->N3_AMPLIA'+cSuf)
										If cSuf == "1"
											aTotBaixa[nSuf][06] -= &(cAliasQry + '->N3_VRCMES'+cSuf)
											aTotBaixa[nSuf][07] -= &(cAliasQry + '->N3_VRCBAL'+cSuf)
											aTotBaixa[nSuf][08] -= &(cAliasQry + '->N3_VRCACM'+cSuf)
											aTotBaixa[nSuf][10] -= &(cAliasQry + '->N3_VRCDB'+cSuf)
											aTotBaixa[nSuf][11] -= &(cAliasQry + '->N3_VRCDA'+cSuf)
										EndIf
									EndIf
								EndIf
								aTotBaixa[nSuf][12] += 1
							Else
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ Totaliza para quebra no 1o. Nivel                             ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								If mv_par10 == 1
									aTotBaixa[nSuf][01] += &(cAliasQry + '->N3_VORIG'+cSuf)
									aTotBaixa[nSuf][02] += (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_VRCACM1 + (cAliasQry)->N3_AMPLIA1
									aTotBaixa[nSuf][04] += &(cAliasQry + '->N3_VRDBAL'+cSuf)
									aTotBaixa[nSuf][05] += &(cAliasQry + '->N3_VRDACM'+cSuf)
									aTotBaixa[nSuf][13] += &(cAliasQry + '->N3_AMPLIA'+cSuf)
									If cSuf == "1"
										aTotBaixa[nSuf][06] += &(cAliasQry + '->N3_VRCMES'+cSuf)
										aTotBaixa[nSuf][07] += &(cAliasQry + '->N3_VRCBAL'+cSuf)
										aTotBaixa[nSuf][08] += &(cAliasQry + '->N3_VRCACM'+cSuf)
										aTotBaixa[nSuf][10] += &(cAliasQry + '->N3_VRCDB'+cSuf)
										aTotBaixa[nSuf][11] += &(cAliasQry + '->N3_VRCDA'+cSuf)
									EndIf
									// Para a Depreciação do mês tem de tirar as diferentes do mes da última depreciação calculada
									If !(Month((cAliasQry)->N3_DTBAIXA) == Month(dUltDepr) .AND. Year((cAliasQry)->N3_DTBAIXA) == Year(dUltDepr))
										aTotBaixa[nSuf][03] += IIf(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr),&(cAliasQry + '->N3_VRDMES'+cSuf),0)
										If cSuf == "1"
											aTotBaixa[nSuf][09] += &(cAliasQry + '->N3_VRCDM'+cSuf)
										EndIf
									EndIf
								ElseIf mv_par10 == 3	// Baixas ate o calculo
									If (cAliasQry)->N3_DTBAIXA <= dUltDepr
										aTotBaixa[nSuf][01] += &(cAliasQry + '->N3_VORIG'+cSuf)
										aTotBaixa[nSuf][02] += (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_VRCACM1 + (cAliasQry)->N3_AMPLIA1
										aTotBaixa[nSuf][04] += &(cAliasQry + '->N3_VRDBAL'+cSuf)
										aTotBaixa[nSuf][05] += &(cAliasQry + '->N3_VRDACM'+cSuf)
										aTotBaixa[nSuf][13] += &(cAliasQry + '->N3_AMPLIA'+cSuf)
										If cSuf == "1"
											aTotBaixa[nSuf][06] += &(cAliasQry + '->N3_VRCMES'+cSuf)
											aTotBaixa[nSuf][07] += &(cAliasQry + '->N3_VRCBAL'+cSuf)
											aTotBaixa[nSuf][08] += &(cAliasQry + '->N3_VRCACM'+cSuf)
											aTotBaixa[nSuf][10] += &(cAliasQry + '->N3_VRCDB'+cSuf)
											aTotBaixa[nSuf][11] += &(cAliasQry + '->N3_VRCDA'+cSuf)
										EndIf
										// Para a Depreciação do mês tem de tirar as diferentes do mes da última depreciação calculada
										If !(Month((cAliasQry)->N3_DTBAIXA) == Month(dUltDepr) .AND. Year((cAliasQry)->N3_DTBAIXA) == Year(dUltDepr))
											aTotBaixa[nSuf][03] += IIf(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr),&(cAliasQry + '->N3_VRDMES'+cSuf),0)
											If cSuf == "1"
												aTotBaixa[nSuf][09] += &(cAliasQry + '->N3_VRCDM'+cSuf)
											EndIf
										EndIf
									EndIf
								ElseIf mv_par10 == 5 	// Mes do Calculo
									If (Month((cAliasQry)->N3_DTBAIXA) == Month(dUltDepr) .AND. Year((cAliasQry)->N3_DTBAIXA) == Year(dUltDepr))
										aTotBaixa[nSuf][01] += &(cAliasQry + '->N3_VORIG'+cSuf)
										aTotBaixa[nSuf][02] += (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_VRCACM1 + (cAliasQry)->N3_AMPLIA1
										aTotBaixa[nSuf][04] += &(cAliasQry + '->N3_VRDBAL'+cSuf)
										aTotBaixa[nSuf][05] += &(cAliasQry + '->N3_VRDACM'+cSuf)
										aTotBaixa[nSuf][13] += &(cAliasQry + '->N3_AMPLIA'+cSuf)
										If cSuf == "1"
											aTotBaixa[nSuf][06] += &(cAliasQry + '->N3_VRCMES'+cSuf)
											aTotBaixa[nSuf][07] += &(cAliasQry + '->N3_VRCBAL'+cSuf)
											aTotBaixa[nSuf][08] += &(cAliasQry + '->N3_VRCACM'+cSuf)
											aTotBaixa[nSuf][10] += &(cAliasQry + '->N3_VRCDB'+cSuf)
											aTotBaixa[nSuf][11] += &(cAliasQry + '->N3_VRCDA'+cSuf)
										EndIf
									EndIf
								EndIf
								aTotBaixa[nSuf][12] += 1
							EndIf
						EndIf
					Next
				EndIf
			EndIf
			If mv_par10 == 1
				nQuantBx ++
			EndIf
			If mv_par10 == 2   // Nao considera nenhuma baixa
				nQuantBx ++
				dbSelectArea(cAliasQry)
				dbSkip()
				Loop
			Elseif mv_par10 == 3	// Baixas ate o calculo
				
				If (cAliasQry)->N3_DTBAIXA <= dUltDepr
					nQuantBx ++
				EndIf

				If (cAliasQry)->N3_DTBAIXA > dUltDepr
					dbSelectArea(cAliasQry)
					dbSkip()
					Loop
				EndIf
				
			Elseif mv_par10 == 4 	// Baixas apos o calculo

				If (cAliasQry)->N3_DTBAIXA > dUltDepr
					nQuantBx ++
				EndIf	

				If (cAliasQry)->N3_DTBAIXA <= dUltDepr
					dbSelectArea(cAliasQry)
					dbSkip()
					Loop
				EndIf

			ElseIf mv_par10 == 5 	// Mes do Calculo
				If !(Month((cAliasQry)->N3_DTBAIXA) == Month(dUltDepr) .AND. Year((cAliasQry)->N3_DTBAIXA) == Year(dUltDepr))
					nQuantBx ++
					dbSelectArea(cAliasQry)
					dbSkip()
					Loop
				Endif
			Endif
		Endif
        
		dbSelectArea(cAliasQry)
		nQuantidade ++
        
		If mv_par05 == 1  // 1=Analitico, 2=Sintetico
			oSection11:Init()
			oSection11:Cell("N3_FILIAL"):SetBlock({|| (cAliasQry)->N3_FILIAL } )
			oSection11:Cell("N3_CBASE"):SetBlock({|| (cAliasQry)->N3_CBASE } )
			oSection11:Cell("N3_ITEM"):SetBlock({|| (cAliasQry)->N3_ITEM } )
			oSection11:Cell("N3_TIPO"):SetBlock({|| (cAliasQry)->N3_TIPO  } )
			oSection11:Cell("N1_DESCRIC"):SetBlock({|| SubStr(SN1->N1_DESCRIC,1,35) } )

			//Incluido por Jair Ribeiro em 28/04/11
			oSection11:Cell("TPDEPR"):SetBlock({|| GetAdvFVal("SN0","N0_DESC01",xFilial("SN0")+"04"+(cAliasQry)->N3_TPDEPR)})  
			
			oSection11:Cell("N1_AQUISIC"):SetBlock({|| SN1->N1_AQUISIC } )
			oSection11:Cell("N3_DTBAIXA"):SetBlock({|| (cAliasQry)->N3_DTBAIXA } )
			oSection11:Cell("N1_QUANTD"):SetPicture( AFPesqPict("SN1","N1_QUANTD",11) )
			oSection11:Cell("N1_CHAPA"):SetBlock({|| SN1->N1_CHAPA } )
			oSection11:Cell("N3_CCUSTO"):SetBlock({|| (cAliasQry)->N3_CCUSTO } )
			oSection11:Cell("N3_SUBCTA"):SetBlock({|| (cAliasQry)->N3_SUBCTA } )
			oSection11:Cell("N3_CLVL"):SetBlock({|| (cAliasQry)->N3_CLVL } )
			oSection11:PrintLine()
			oSection11:Finish()
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Efetua a impressao dos valores conforme moedas selecionadas      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection12:Init()
		For nSuf := 1 To 5
			cSuf      := Str(nSuf,1)
			IF SubStr(cMoedas,nSuf,1) == "S"
				
				oSection12:Cell("SIMBMOEDA"):SetBlock( { || SuperGetMv("MV_SIMB"+cSuf) } )
				oSection12:Cell("N3_AMPLIA"):SetBlock( { || &(cAliasQry + '->N3_AMPLIA'+cSuf) } )
				oSection12:Cell("N3_AMPLIA"):SetPicture( AFPesqPict("SN3","N3_AMPLIA"+cSuf ,14, nSuf) )
				
				oSection12:Cell("N3_VORIG"):SetBlock( { || &(cAliasQry + '->N3_VORIG'+cSuf) } )
				oSection12:Cell("N3_VORIG"):SetPicture( AFPesqPict("SN3","N3_VORIG" +cSuf ,18, nSuf) )
				
				oSection12:Cell("VLATUALIZADO"):SetBlock( { || If( cSuf == "1", nVlrAtual, 0 ) } )
				oSection12:Cell("VLATUALIZADO"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VORIG1" ,19,nSuf) )
				
				oSection12:Cell("N3_VRDMES"):SetBlock( { || If( Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), &(cAliasQry + '->N3_VRDMES'+cSuf), 0 ) } )
				oSection12:Cell("N3_VRDMES"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRDMES"+cSuf,18,nSuf) )
				
				oSection12:Cell("N3_VRDBAL"):SetBlock( { || &(cAliasQry + '->N3_VRDBAL'+cSuf) } )
				oSection12:Cell("N3_VRDBAL"):SetPicture( AFPesqPict("SN3","N3_VRDBAL"+cSuf,18,nSuf) )
				
				oSection12:Cell("N3_VRDACM"):SetBlock( { || &(cAliasQry + '->N3_VRDACM'+cSuf) } )
				oSection12:Cell("N3_VRDACM"):SetPicture( AFPesqPict("SN3","N3_VRDACM"+cSuf,19,nSuf) )
				
				oSection12:Cell("N3_VRCMES1"):SetBlock( { || If( cSuf == "1", &(cAliasQry + '->N3_VRCMES'+cSuf), 0 ) } )
				oSection12:Cell("N3_VRCMES1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCMES1",15,1) )
				
				oSection12:Cell("N3_VRCBAL1"):SetBlock( { || If( cSuf == "1", &(cAliasQry + '->N3_VRCBAL'+cSuf), 0 ) } )
				oSection12:Cell("N3_VRCBAL1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCBAL1",17,1) )
				
				oSection12:Cell("N3_VRCACM1"):SetBlock( { || If( cSuf == "1", &(cAliasQry + '->N3_VRCACM'+cSuf), 0 ) } )
				oSection12:Cell("N3_VRCACM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCACM1",19,1) )
				
				oSection12:Cell("N3_VRCDM1"):SetBlock( { || If( cSuf == "1", &(cAliasQry + '->N3_VRCDM'+cSuf), 0 ) } )
				oSection12:Cell("N3_VRCDM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDM1",15,1) )
				
				oSection12:Cell("N3_VRCDB1"):SetBlock( { || If( cSuf == "1", &(cAliasQry + '->N3_VRCDB'+cSuf), 0 ) } )
				oSection12:Cell("N3_VRCDB1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDB1",17,1) )
				
				oSection12:Cell("N3_VRCDA1"):SetBlock( { || If( cSuf == "1", &(cAliasQry + '->N3_VRCDA'+cSuf), 0 ) } )
				oSection12:Cell("N3_VRCDA1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDA1",19,1) )
				nVlrAtual := (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_VRCACM1 + (cAliasQry)->N3_AMPLIA1
				
				If mv_par05 == 1  // 1=Analitico, 2=Sintetico
					oSection12:PrintLine()
				Endif

				// Verificação da classificação de Ativo se sofre depreciação
				lAtClDepr := AtClssVer(SN1->N1_PATRIM)
				
				If lAtClDepr .OR. SN1->N1_PATRIM $ "P "
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totaliza para quebra no 1o. Nivel                             ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aTquebra1[nSuf][01] += &(cAliasQry + '->N3_VORIG'+cSuf)
					aTquebra1[nSuf][02] += nVlrAtual
					aTquebra1[nSuf][03] += IIf (Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr),&(cAliasQry + '->N3_VRDMES'+cSuf),0)
					aTquebra1[nSuf][04] += &(cAliasQry + '->N3_VRDBAL'+cSuf)
					aTquebra1[nSuf][05] += &(cAliasQry + '->N3_VRDACM'+cSuf)
					aTquebra1[nSuf][13] += &(cAliasQry + '->N3_AMPLIA'+cSuf)
					IF cSuf == "1"
						aTquebra1[nSuf][06] += &(cAliasQry + '->N3_VRCMES'+cSuf)
						aTquebra1[nSuf][07] += &(cAliasQry + '->N3_VRCBAL'+cSuf)
						aTquebra1[nSuf][08] += &(cAliasQry + '->N3_VRCACM'+cSuf)
						aTquebra1[nSuf][09] += &(cAliasQry + '->N3_VRCDM'+cSuf)
						aTquebra1[nSuf][10] += &(cAliasQry + '->N3_VRCDB'+cSuf)
						aTquebra1[nSuf][11] += &(cAliasQry + '->N3_VRCDA'+cSuf)
					EndIf
					aTquebra1[nSuf][12] += 1
				Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totaliza para quebra no 1o. Nivel                             ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aTquebra1[nSuf][01] -= &(cAliasQry + '->N3_VORIG'+cSuf)
					aTquebra1[nSuf][02] -= nVlrAtual
					aTquebra1[nSuf][03] -= IIf(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr),&(cAliasQry + '->N3_VRDMES'+cSuf),0)
					aTquebra1[nSuf][04] -= &(cAliasQry + '->N3_VRDBAL'+cSuf)
					aTquebra1[nSuf][05] -= &(cAliasQry + '->N3_VRDACM'+cSuf)
					aTquebra1[nSuf][13] -= &(cAliasQry + '->N3_AMPLIA'+cSuf)
					IF cSuf == "1"
						aTquebra1[nSuf][06] -= &(cAliasQry + '->N3_VRCMES'+cSuf)
						aTquebra1[nSuf][07] -= &(cAliasQry + '->N3_VRCBAL'+cSuf)
						aTquebra1[nSuf][08] -= &(cAliasQry + '->N3_VRCACM'+cSuf)
						aTquebra1[nSuf][09] -= &(cAliasQry + '->N3_VRCDM'+cSuf)
						aTquebra1[nSuf][10] -= &(cAliasQry + '->N3_VRCDB'+cSuf)
						aTquebra1[nSuf][11] -= &(cAliasQry + '->N3_VRCDA'+cSuf)
					EndIf
					aTquebra1[nSuf][12] += 1
				EndIf
			EndIf
		Next
		oSection12:Finish()
		dbSelectArea(cAliasQry)
		DbSkip()
	EndDo
    
	lQuebra := .F.
	
	If aTQuebra1[1][12] != 0
		lQuebra := .T.
		
		cDescr 	:= Afr070desc( oSection1:GetOrder(), cFilQbr1 , cEntQbr1 )
		cDescrFil:= GetAdvFval("SM0","M0_FILIAL",cEmpAnt + cFilQbr1 )
		oTxtSubtotal:Cell("FILIAL"):SetBlock({|| OemToAnsi(STR0057) + " : " + cFilQbr1 + " - " + cDescrFil } )
		oTxtSubtotal:Cell("ENTIDADE"):SetBlock( { || OemToAnsi(STR0010) + cCabCond1 + cDescr } )
		oTxtSubtotal:Cell("QUANTIDADE"):SetBlock( { || OemToAnsi(STR0011) + Str(nQuantidade,7,0) } )
		
		oTxtSubtotal:Init()
		oTxtSubtotal:PrintLine()

		nTotal += nQuantidade
		nQuantidade := 0
		
		If lCtb
			dbSelectArea("CT1")
			MsSeek(xFilial("CT1",cFilQbr1)+cEntQbr1)
		Else
			dbSelectArea("SI1")
			MsSeek(xFilial("SI1",cFilQbr1)+cEntQbr1)
		EndIf
		
		oSubTotal:Init()
		
		For nSuf := 1 To 5
		
			cSuf := Str(nSuf,1)
			
			IF SubStr(cMoedas,nSuf,1) == "S"
				oSubTotal:Cell("SIMBMOEDA"):SetBlock( { || SuperGetMv("MV_SIMB"+cSuf) } )
				oSubTotal:Cell("N3_AMPLIA"):SetBlock( { || aTQuebra1[nSuf][13] } )
				oSubTotal:Cell("N3_AMPLIA"):SetPicture( AFPesqPict("SN3","N3_AMPLIA"+cSuf ,14, nSuf) )
				
				oSubTotal:Cell("N3_VORIG"):SetBlock( { || aTQuebra1[nSuf][01] } )
				oSubTotal:Cell("N3_VORIG"):SetPicture( AFPesqPict("SN3","N3_VORIG" +cSuf ,18, nSuf) )
				
				oSubTotal:Cell("VLATUALIZADO"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][02], 0 ) } )
				oSubTotal:Cell("VLATUALIZADO"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VORIG1" ,19,nSuf) )
				
				oSubTotal:Cell("N3_VRDMES"):SetBlock( { || aTQuebra1[nSuf][03] } )
				oSubTotal:Cell("N3_VRDMES"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRDMES"+cSuf,18,nSuf) )
				
				oSubTotal:Cell("N3_VRDBAL"):SetBlock( { || aTQuebra1[nSuf][04] } )
				oSubTotal:Cell("N3_VRDBAL"):SetPicture( AFPesqPict("SN3","N3_VRDBAL"+cSuf,18,nSuf) )
				
				oSubTotal:Cell("N3_VRDACM"):SetBlock( { || aTQuebra1[nSuf][05] } )
				oSubTotal:Cell("N3_VRDACM"):SetPicture( AFPesqPict("SN3","N3_VRDACM"+cSuf,19,nSuf) )
				
				oSubTotal:Cell("N3_VRCMES1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][06], 0 ) } )
				oSubTotal:Cell("N3_VRCMES1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCMES1",15,1) )
				
				oSubTotal:Cell("N3_VRCBAL1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][07], 0 ) } )
				oSubTotal:Cell("N3_VRCBAL1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCBAL1",17,1) )
				
				oSubTotal:Cell("N3_VRCACM1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][08], 0 ) } )
				oSubTotal:Cell("N3_VRCACM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCACM1",19,1) )
				
				oSubTotal:Cell("N3_VRCDM1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][09], 0 ) } )
				oSubTotal:Cell("N3_VRCDM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDM1",15,1) )
				
				oSubTotal:Cell("N3_VRCDB1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][10], 0 ) } )
				oSubTotal:Cell("N3_VRCDB1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDB1",17,1) )
				
				oSubTotal:Cell("N3_VRCDA1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][11], 0 ) } )
				oSubTotal:Cell("N3_VRCDA1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDA1",19,1) )
				If oSection1:GetOrder() == 1
					If lCtb
						If SubStr(CT1->CT1_CONTA,1,1) $ cGrupoPass .And. CT1->CT1_NORMAL == "1"
							aTQuebra1[nSuf][ 1] := aTQuebra1[nSuf][ 1] * -1
							aTQuebra1[nSuf][ 2] := aTQuebra1[nSuf][ 2] * -1
						Endif
					Else
						If SubStr(SI1->I1_CODIGO,1,1) $ cGrupoPass .And. SI1->I1_NORMAL == "D"
							aTQuebra1[nSuf][ 1] := aTQuebra1[nSuf][ 1] * -1
							aTQuebra1[nSuf][ 2] := aTQuebra1[nSuf][ 2] * -1
						Endif
					EndIf
				Endif
				oSubTotal:PrintLine()
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Totaliza para quebra no 1o. Nivel                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				aTotGeral[nSuf][01] += aTQuebra1[nSuf][01]
				aTotGeral[nSuf][02] += aTQuebra1[nSuf][02]
				aTotGeral[nSuf][03] += aTQuebra1[nSuf][03]
				aTotGeral[nSuf][04] += aTQuebra1[nSuf][04]
				aTotGeral[nSuf][05] += aTQuebra1[nSuf][05]
				aTotGeral[nSuf][13] += aTQuebra1[nSuf][13]
				IF cSuf == "1"
					aTotGeral[nSuf][06] += aTQuebra1[nSuf][06]
					aTotGeral[nSuf][07] += aTQuebra1[nSuf][07]
					aTotGeral[nSuf][08] += aTQuebra1[nSuf][08]
					aTotGeral[nSuf][09] += aTQuebra1[nSuf][09]
					aTotGeral[nSuf][10] += aTQuebra1[nSuf][10]
					aTotGeral[nSuf][11] += aTQuebra1[nSuf][11]
				Endif
				aTotGeral[nSuf][12] -= aTQuebra1[nSuf][12]
			Endif
		Next
		oSubTotal:Finish()
		oTxtSubtotal:Finish()
		lDescricao := .F.
	EndIf
	// Imprime totais para comparação com o Razão (ATFR130)
	If mv_par14 == 1	//Imprime total de baixas
		If aTotBaixa[1][12] != 0
			
			lQuebra := .T.
			oTxtBaixa:Cell("TEXTO"):SetBlock( { || STR0033 } ) //"BAIXAS"
			oTxtBaixa:Cell("QUANTIDADE"):SetBlock( { || OemToAnsi(STR0011) + Str(nQuantBx,7,0) } )
			
			oTxtBaixa:Init()
			oTxtBaixa:PrintLine()
			
			nTotBx += nQuantBx
			nQuantBx := 0
			If lCtb
				dbSelectArea("CT1")
				MsSeek(xFilial("CT1",cFilQbr1)+cEntQbr1)
			Else
				dbSelectArea("SI1")
				MsSeek(xFilial("SI1",cFilQbr1)+cEntQbr1)
			EndIf
			oBaixa:Init()
			For nSuf := 1 To 5
				cSuf      := Str(nSuf,1)
				If SubStr(cMoedas,nSuf,1) == "S"
					oBaixa:Cell("SIMBMOEDA"):SetBlock( { || SuperGetMv("MV_SIMB"+cSuf) } )
					oBaixa:Cell("N3_AMPLIA"):SetBlock( { || aTotBaixa[nSuf][13] } )
					oBaixa:Cell("N3_AMPLIA"):SetPicture( AFPesqPict("SN3","N3_AMPLIA"+cSuf ,14, nSuf) )
					
					oBaixa:Cell("N3_VORIG"):SetBlock( { || aTotBaixa[nSuf][01] } )
					oBaixa:Cell("N3_VORIG"):SetPicture( AFPesqPict("SN3","N3_VORIG" +cSuf ,18, nSuf) )
					
					oBaixa:Cell("VLATUALIZADO"):SetBlock( { || If( cSuf == "1", aTotBaixa[nSuf][02], 0 ) } )
					oBaixa:Cell("VLATUALIZADO"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VORIG1" ,19,nSuf) )
					
					oBaixa:Cell("N3_VRDMES"):SetBlock( { || aTotBaixa[nSuf][03] } )
					oBaixa:Cell("N3_VRDMES"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRDMES"+cSuf,18,nSuf) )
					
					oBaixa:Cell("N3_VRDBAL"):SetBlock( { || aTotBaixa[nSuf][04] } )
					oBaixa:Cell("N3_VRDBAL"):SetPicture( AFPesqPict("SN3","N3_VRDBAL"+cSuf,18,nSuf) )
					
					oBaixa:Cell("N3_VRDACM"):SetBlock( { || aTotBaixa[nSuf][05] } )
					oBaixa:Cell("N3_VRDACM"):SetPicture( AFPesqPict("SN3","N3_VRDACM"+cSuf,19,nSuf) )
					
					oBaixa:Cell("N3_VRCMES1"):SetBlock( { || If( cSuf == "1", aTotBaixa[nSuf][06], 0 ) } )
					oBaixa:Cell("N3_VRCMES1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCMES1",15,1) )
					
					oBaixa:Cell("N3_VRCBAL1"):SetBlock( { || If( cSuf == "1", aTotBaixa[nSuf][07], 0 ) } )
					oBaixa:Cell("N3_VRCBAL1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCBAL1",17,1) )
					
					oBaixa:Cell("N3_VRCACM1"):SetBlock( { || If( cSuf == "1", aTotBaixa[nSuf][08], 0 ) } )
					oBaixa:Cell("N3_VRCACM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCACM1",19,1) )
					
					oBaixa:Cell("N3_VRCDM1"):SetBlock( { || If( cSuf == "1", aTotBaixa[nSuf][09], 0 ) } )
					oBaixa:Cell("N3_VRCDM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDM1",15,1) )
					
					oBaixa:Cell("N3_VRCDB1"):SetBlock( { || If( cSuf == "1", aTotBaixa[nSuf][10], 0 ) } )
					oBaixa:Cell("N3_VRCDB1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDB1",17,1) )
					
					oBaixa:Cell("N3_VRCDA1"):SetBlock( { || If( cSuf == "1", aTotBaixa[nSuf][11], 0 ) } )
					oBaixa:Cell("N3_VRCDA1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDA1",19,1) )
					If nOrdem == 1
						If lCtb
							If SubStr(CT1->CT1_CONTA,1,1) $ cGrupoPass .And. CT1->CT1_NORMAL == "1"
								aTotBaixa[nSuf][ 1] := aTotBaixa[nSuf][ 1] * -1
								aTotBaixa[nSuf][ 2] := aTotBaixa[nSuf][ 2] * -1
							EndIf
						Else
							If SubStr(SI1->I1_CODIGO,1,1) $ cGrupoPass .And.	SI1->I1_NORMAL == "D"
								aTotBaixa[nSuf][ 1] := aTotBaixa[nSuf][ 1] * -1
								aTotBaixa[nSuf][ 2] := aTotBaixa[nSuf][ 2] * -1
							EndIf
						EndIf
					EndIf
					oBaixa:PrintLine()
					
					aTotGBx[nSuf][01] += aTotBaixa[nSuf][01]
					aTotGBx[nSuf][02] += aTotBaixa[nSuf][02]
					aTotGBx[nSuf][03] += aTotBaixa[nSuf][03]
					aTotGBx[nSuf][04] += aTotBaixa[nSuf][04]
					aTotGBx[nSuf][05] += aTotBaixa[nSuf][05]
					aTotGBx[nSuf][13] += aTotBaixa[nSuf][13]
					If cSuf == "1"
						aTotGBx[nSuf][06] += aTotBaixa[nSuf][06]
						aTotGBx[nSuf][07] += aTotBaixa[nSuf][07]
						aTotGBx[nSuf][08] += aTotBaixa[nSuf][08]
						aTotGBx[nSuf][09] += aTotBaixa[nSuf][09]
						aTotGBx[nSuf][10] += aTotBaixa[nSuf][10]
						aTotGBx[nSuf][11] += aTotBaixa[nSuf][11]
					EndIf
					aTotGBx[nSuf][12] -= -aTotBaixa[nSuf][12]
				EndIf
			Next
			oBaixa:Finish()
			oTxtBaixa:Finish()
		EndIf
		
		If aTotBaixa[1][12] != 0
			lQuebra := .T.
			oTxtTotBx:Cell("TEXTO"):SetBlock( { || STR0034 } ) //"TOTAL"
			
			oTxtTotBx:Init()
			oTxtTotBx:PrintLine()
			
			If lCtb
				dbSelectArea("CT1")
				MsSeek(xFilial("CT1",cFilQbr1)+cEntQbr1)
			Else
				dbSelectArea("SI1")
				MsSeek(xFilial("SI1",cFilQbr1)+cEntQbr1)
			EndIf
			
			oTotBaixa:Init()
			For nSuf := 1 To 5
				cSuf      := Str(nSuf,1)
				If SubStr(cMoedas,nSuf,1) == "S"
					oTotBaixa:Cell("SIMBMOEDA"):SetBlock( { || SuperGetMv("MV_SIMB"+cSuf) } )
					oTotBaixa:Cell("N3_AMPLIA"):SetBlock( { || aTQuebra1[nSuf][13]+aTotBaixa[nSuf][13] } )
					oTotBaixa:Cell("N3_AMPLIA"):SetPicture( AFPesqPict("SN3","N3_AMPLIA"+cSuf ,14, nSuf) )
					
					oTotBaixa:Cell("N3_VORIG"):SetBlock( { || aTQuebra1[nSuf][01]+aTotBaixa[nSuf][01] } )
					oTotBaixa:Cell("N3_VORIG"):SetPicture( AFPesqPict("SN3","N3_VORIG" +cSuf ,18, nSuf) )
					
					oTotBaixa:Cell("VLATUALIZADO"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][02]+aTotBaixa[nSuf][02], 0 ) } )
					oTotBaixa:Cell("VLATUALIZADO"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VORIG1" ,19,nSuf) )
					
					oTotBaixa:Cell("N3_VRDMES"):SetBlock( { || aTQuebra1[nSuf][03]+aTotBaixa[nSuf][03] } )
					oTotBaixa:Cell("N3_VRDMES"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRDMES"+cSuf,18,nSuf) )
					
					oTotBaixa:Cell("N3_VRDBAL"):SetBlock( { || aTQuebra1[nSuf][04]+aTotBaixa[nSuf][04] } )
					oTotBaixa:Cell("N3_VRDBAL"):SetPicture( AFPesqPict("SN3","N3_VRDBAL"+cSuf,18,nSuf) )
					
					oTotBaixa:Cell("N3_VRDACM"):SetBlock( { || aTQuebra1[nSuf][05]+aTotBaixa[nSuf][05] } )
					oTotBaixa:Cell("N3_VRDACM"):SetPicture( AFPesqPict("SN3","N3_VRDACM"+cSuf,19,nSuf) )
					
					oTotBaixa:Cell("N3_VRCMES1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][06]+aTotBaixa[nSuf][06], 0 ) } )
					oTotBaixa:Cell("N3_VRCMES1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCMES1",15,1) )
					
					oTotBaixa:Cell("N3_VRCBAL1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][07]+aTotBaixa[nSuf][07], 0 ) } )
					oTotBaixa:Cell("N3_VRCBAL1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCBAL1",17,1) )
					
					oTotBaixa:Cell("N3_VRCACM1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][08]+aTotBaixa[nSuf][08], 0 ) } )
					oTotBaixa:Cell("N3_VRCACM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCACM1",19,1) )
					
					oTotBaixa:Cell("N3_VRCDM1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][09]+aTotBaixa[nSuf][09], 0 ) } )
					oTotBaixa:Cell("N3_VRCDM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDM1",15,1) )
					
					oTotBaixa:Cell("N3_VRCDB1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][10]+aTotBaixa[nSuf][10], 0 ) } )
					oTotBaixa:Cell("N3_VRCDB1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDB1",17,1) )
					
					oTotBaixa:Cell("N3_VRCDA1"):SetBlock( { || If( cSuf == "1", aTQuebra1[nSuf][11]+aTotBaixa[nSuf][11], 0 ) } )
					oTotBaixa:Cell("N3_VRCDA1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDA1",19,1) )
					oTotBaixa:PrintLine()
				EndIf
			Next
			oTotBaixa:Finish()
			oTxtTotBx:Finish()
			lDescricao := .F.
		EndIf
	EndIf
	If lQuebra
		For nSuf := 1 To 13
			aTQuebra1[1][nSuf] := 0
			aTQuebra1[2][nSuf] := 0
			aTQuebra1[3][nSuf] := 0
			aTQuebra1[4][nSuf] := 0
			aTQuebra1[5][nSuf] := 0
			// Imprime totais para comparação com o Razão (ATFR130)
			If mv_par14 == 1	//Imprime total de baixas
				aTotBaixa[1][nSuf] := 0
				aTotBaixa[2][nSuf] := 0
				aTotBaixa[3][nSuf] := 0
				aTotBaixa[4][nSuf] := 0
				aTotBaixa[5][nSuf] := 0
			EndIf
		Next
		oReport:SkipLine()
		oReport:ThinLine()
	EndIf
	dbSelectArea(cAliasQry)
EndDO
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Efetua a impressao da totalizacao na quebra do segundo nivel        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTxtTotGer:Cell("TEXTO"):SetBlock( { || OemToAnsi(STR0012) } ) // "* * *   T O T A L   G E R A L   * * *"
oTxtTotGer:Cell("QUANTIDADE"):SetBlock( { || OemToAnsi(STR0013) + Str(nTotal,7,0) } ) // "QUANTIDADE"
			
oTxtTotGer:Init()
oTxtTotGer:PrintLine()

oTotalGeral:Init()

For nSuf := 1 To 5
	cSuf      := Str(nSuf,1)
	IF SubStr(cMoedas,nSuf,1) == "S"
		oTotalGeral:Cell("SIMBMOEDA"):SetBlock( { || SuperGetMv("MV_SIMB"+cSuf) } )
		oTotalGeral:Cell("N3_AMPLIA"):SetBlock( { || aTotGeral[nSuf][13] } )
		oTotalGeral:Cell("N3_AMPLIA"):SetPicture( AFPesqPict("SN3","N3_AMPLIA"+cSuf ,18, nSuf) )
		
		oTotalGeral:Cell("N3_VORIG"):SetBlock( { || aTotGeral[nSuf][01] } )
		oTotalGeral:Cell("N3_VORIG"):SetPicture( AFPesqPict("SN3","N3_VORIG" +cSuf ,18, nSuf) )
		
		oTotalGeral:Cell("VLATUALIZADO"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][02], 0 ) } )
		oTotalGeral:Cell("VLATUALIZADO"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VORIG1" ,19,nSuf) )
		
		oTotalGeral:Cell("N3_VRDMES"):SetBlock( { || aTotGeral[nSuf][03] } )
		oTotalGeral:Cell("N3_VRDMES"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRDMES"+cSuf,18,nSuf) )
		
		oTotalGeral:Cell("N3_VRDBAL"):SetBlock( { || aTotGeral[nSuf][04] } )
		oTotalGeral:Cell("N3_VRDBAL"):SetPicture( AFPesqPict("SN3","N3_VRDBAL"+cSuf,18,nSuf) )
		
		oTotalGeral:Cell("N3_VRDACM"):SetBlock( { || aTotGeral[nSuf][05] } )
		oTotalGeral:Cell("N3_VRDACM"):SetPicture( AFPesqPict("SN3","N3_VRDACM"+cSuf,19,nSuf) )
		
		oTotalGeral:Cell("N3_VRCMES1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][06], 0 ) } )
		oTotalGeral:Cell("N3_VRCMES1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCMES1",15,1) )
		
		oTotalGeral:Cell("N3_VRCBAL1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][07], 0 ) } )
		oTotalGeral:Cell("N3_VRCBAL1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCBAL1",17,1) )
		
		oTotalGeral:Cell("N3_VRCACM1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][08], 0 ) } )
		oTotalGeral:Cell("N3_VRCACM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCACM1",19,1) )
		
		oTotalGeral:Cell("N3_VRCDM1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][09], 0 ) } )
		oTotalGeral:Cell("N3_VRCDM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDM1",15,1) )
		
		oTotalGeral:Cell("N3_VRCDB1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][10], 0 ) } )
		oTotalGeral:Cell("N3_VRCDB1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDB1",17,1) )
		
		oTotalGeral:Cell("N3_VRCDA1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][11], 0 ) } )
		oTotalGeral:Cell("N3_VRCDA1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDA1",19,1) )
		oTotalGeral:PrintLine()
	EndIf
Next
oTotalGeral:Finish()
oTxtTotGer:Finish()
// Imprime totais para comparação com o Razão (ATFR130)
If mv_par14 == 1	//Imprime total de baixas
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua a impressao da totalizacao na quebra do segundo nivel        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oTxtTotGBx:Cell("TEXTO"):SetBlock( { || STR0031 } ) //"* * *  B A I X A S  * * *"
	oTxtTotGBx:Cell("QUANTIDADE"):SetBlock( { || OemToAnsi(STR0013) + Str(nTotBx,7,0) } ) // "QUANTIDADE"
				
	oTxtTotGBx:Init()
	oTxtTotGBx:PrintLine()
	
	oTotGerBx:Init()
	
	For nSuf := 1 To 5
		If SubStr(cMoedas,nSuf,1) == "S"
			cSuf      := Str(nSuf,1)
			oTotGerBx:Cell("SIMBMOEDA"):SetBlock( { || SuperGetMv("MV_SIMB"+cSuf) } )
			oTotGerBx:Cell("N3_AMPLIA"):SetBlock( { || aTotGBx[nSuf][13] } )
			oTotGerBx:Cell("N3_AMPLIA"):SetPicture( AFPesqPict("SN3","N3_AMPLIA"+cSuf ,18, nSuf) )
			
			oTotGerBx:Cell("N3_VORIG"):SetBlock( { || aTotGBx[nSuf][01] } )
			oTotGerBx:Cell("N3_VORIG"):SetPicture( AFPesqPict("SN3","N3_VORIG" +cSuf ,18, nSuf) )
			
			oTotGerBx:Cell("VLATUALIZADO"):SetBlock( { || If( cSuf == "1", aTotGBx[nSuf][02], 0 ) } )
			oTotGerBx:Cell("VLATUALIZADO"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VORIG1" ,19,nSuf) )
			
			oTotGerBx:Cell("N3_VRDMES"):SetBlock( { || aTotGBx[nSuf][03] } )
			oTotGerBx:Cell("N3_VRDMES"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRDMES"+cSuf,18,nSuf) )
			
			oTotGerBx:Cell("N3_VRDBAL"):SetBlock( { || aTotGBx[nSuf][04] } )
			oTotGerBx:Cell("N3_VRDBAL"):SetPicture( AFPesqPict("SN3","N3_VRDBAL"+cSuf,18,nSuf) )
			
			oTotGerBx:Cell("N3_VRDACM"):SetBlock( { || aTotGBx[nSuf][05] } )
			oTotGerBx:Cell("N3_VRDACM"):SetPicture( AFPesqPict("SN3","N3_VRDACM"+cSuf,19,nSuf) )
			
			oTotGerBx:Cell("N3_VRCMES1"):SetBlock( { || If( cSuf == "1", aTotGBx[nSuf][06], 0 ) } )
			oTotGerBx:Cell("N3_VRCMES1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCMES1",15,1) )
			
			oTotGerBx:Cell("N3_VRCBAL1"):SetBlock( { || If( cSuf == "1", aTotGBx[nSuf][07], 0 ) } )
			oTotGerBx:Cell("N3_VRCBAL1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCBAL1",17,1) )
			
			oTotGerBx:Cell("N3_VRCACM1"):SetBlock( { || If( cSuf == "1", aTotGBx[nSuf][08], 0 ) } )
			oTotGerBx:Cell("N3_VRCACM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCACM1",19,1) )
			
			oTotGerBx:Cell("N3_VRCDM1"):SetBlock( { || If( cSuf == "1", aTotGBx[nSuf][09], 0 ) } )
			oTotGerBx:Cell("N3_VRCDM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDM1",15,1) )
			
			oTotGerBx:Cell("N3_VRCDB1"):SetBlock( { || If( cSuf == "1", aTotGBx[nSuf][10], 0 ) } )
			oTotGerBx:Cell("N3_VRCDB1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDB1",17,1) )
			
			oTotGerBx:Cell("N3_VRCDA1"):SetBlock( { || If( cSuf == "1", aTotGBx[nSuf][11], 0 ) } )
			oTotGerBx:Cell("N3_VRCDA1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDA1",19,1) )
			oTotGerBx:PrintLine()
		EndIf
	Next
	oTxtTotal:Cell("TEXTO"):SetBlock( { || STR0032 } ) //"* * *   T O T A L   * * *"
	oTxtTotal:Init()
	oTxtTotal:PrintLine()
	oTotal:Init()
	For nSuf := 1 To 5
		If SubStr(cMoedas,nSuf,1) == "S"
			cSuf      := Str(nSuf,1)
			oTotal:Cell("SIMBMOEDA"):SetBlock( { || SuperGetMv("MV_SIMB"+cSuf) } )
			oTotal:Cell("N3_AMPLIA"):SetBlock( { || aTotGeral[nSuf][13]+aTotGBx[nSuf][13] } )
			oTotal:Cell("N3_AMPLIA"):SetPicture( AFPesqPict("SN3","N3_AMPLIA"+cSuf ,18, nSuf) )
			
			oTotal:Cell("N3_VORIG"):SetBlock( { || aTotGeral[nSuf][01]+aTotGBx[nSuf][01] } )
			oTotal:Cell("N3_VORIG"):SetPicture( AFPesqPict("SN3","N3_VORIG" +cSuf ,18, nSuf) )
			
			oTotal:Cell("VLATUALIZADO"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][02]+aTotGBx[nSuf][02], 0 ) } )
			oTotal:Cell("VLATUALIZADO"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VORIG1" ,19,nSuf) )
			
			oTotal:Cell("N3_VRDMES"):SetBlock( { || aTotGeral[nSuf][03]+aTotGBx[nSuf][03] } )
			oTotal:Cell("N3_VRDMES"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRDMES"+cSuf,18,nSuf) )
			
			oTotal:Cell("N3_VRDBAL"):SetBlock( { || aTotGeral[nSuf][04]+aTotGBx[nSuf][04] } )
			oTotal:Cell("N3_VRDBAL"):SetPicture( AFPesqPict("SN3","N3_VRDBAL"+cSuf,18,nSuf) )
			
			oTotal:Cell("N3_VRDACM"):SetBlock( { || aTotGeral[nSuf][05]+aTotGBx[nSuf][05] } )
			oTotal:Cell("N3_VRDACM"):SetPicture( AFPesqPict("SN3","N3_VRDACM"+cSuf,19,nSuf) )
			
			oTotal:Cell("N3_VRCMES1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][06]+aTotGBx[nSuf][06], 0 ) } )
			oTotal:Cell("N3_VRCMES1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCMES1",15,1) )
			
			oTotal:Cell("N3_VRCBAL1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][07]+aTotGBx[nSuf][07], 0 ) } )
			oTotal:Cell("N3_VRCBAL1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCBAL1",17,1) )
			
			oTotal:Cell("N3_VRCACM1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][08]+aTotGBx[nSuf][08], 0 ) } )
			oTotal:Cell("N3_VRCACM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCACM1",19,1) )
			
			oTotal:Cell("N3_VRCDM1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][09]+aTotGBx[nSuf][09], 0 ) } )
			oTotal:Cell("N3_VRCDM1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDM1",15,1) )
			
			oTotal:Cell("N3_VRCDB1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][10]+aTotGBx[nSuf][10], 0 ) } )
			oTotal:Cell("N3_VRCDB1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDB1",17,1) )
			
			oTotal:Cell("N3_VRCDA1"):SetBlock( { || If( cSuf == "1", aTotGeral[nSuf][11]+aTotGBx[nSuf][11], 0 ) } )
			oTotal:Cell("N3_VRCDA1"):SetPicture( If( cSuf != "1", "@Z", "" ) + AFPesqPict("SN3","N3_VRCDA1",19,1) )
			oTotal:PrintLine()
		EndIf
	Next
	oTotal:Finish()
	oTxtTotal:Finish()
EndIf

CtbTmpErase(cTmpSN3Fi1)
aSize(aCpos,0)//limpa o array SN3

Return

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ AFR070Cab  ³ Autor ³ Cesar C S Prado       ³ Data ³ 09.08.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressao do cabecalho do relatorio (Nivel 1 de quebra)      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ AFR070Cab(cPar01,nPar01,@nPar02)                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cPar01 - Cabecalho a ser impresso                            ³±±
±±³          ³ nPar01 - Ordem da impressao do relatorio (1-Conta/2-C.Custo) ³±±
±±³          ³ nPar02 - Linha corrente                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR070                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AFR070R4Cab(nOrdem,cFilCab,cChave, oReport)
Local oSection1 := oReport:Section(1)

IF nOrdem == 1
	
	oSection1:Cell("ENTIDADES"):Enable()
	oSection1:Cell("DESCENTID"):Enable()
	oSection1:Cell("ENTIDADES"):SetTitle(STR0059)
	oSection1:Cell("ENTIDADES"):SetBlock( { || MascaraCTB(cChave) } )

	dbSelectArea("CT1")
	dbSetOrder(1)
	CT1->(MsSeek(xFilial("CT1",cFilCab) + cChave))
	oSection1:Cell("DESCENTID"):SetBlock( { || CT1->CT1_DESC01 } )

ElseIf nOrdem == 2
	oSection1:Cell("ENTIDADES"):SetTitle(STR0017)
	oSection1:Cell("ENTIDADES"):Enable()
	oSection1:Cell("DESCENTID"):Enable()
	oSection1:Cell("ENTIDADES"):SetBlock( {|| cChave })
	
	dbSelectAre("CTT")
	dbSetOrder(1)
	CTT->( MsSeek(xFilial("CTT",cFilCab) +cChave ) )
	oSection1:Cell("DESCENTID"):SetBlock( {|| CTT->CTT_DESC01 })

ElseIf nOrdem == 3
	oSection1:Cell("ENTIDADES"):SetTitle(STR0061)

	oSection1:Cell("ENTIDADES"):Enable()
	oSection1:Cell("DESCENTID"):Enable()
	oSection1:Cell("ENTIDADES"):SetBlock( {|| cChave })

	dbSelectAre("CTD")
	dbSetOrder(1)
	CTD->( MsSeek(xFilial("CTD",cFilCab) +cChave ) )
	oSection1:Cell("DESCENTID"):SetBlock( {|| CTD->CTD_DESC01 })

ElseIf nOrdem == 4
	oSection1:Cell("ENTIDADES"):SetTitle(STR0062)
	oSection1:Cell("ENTIDADES"):Enable()
	oSection1:Cell("DESCENTID"):Enable()
	oSection1:Cell("ENTIDADES"):SetBlock( {|| cChave })
	
	dbSelectAre("CTH")
	dbSetOrder(1)
	CTH->( MsSeek(xFilial("CTH",cFilCab) +cChave ) )
	oSection1:Cell("DESCENTID"):SetBlock( {|| CTH->CTH_DESC01 })

EndIf
oSection1:Init()
oSection1:PrintLine()
oSection1:Finish()
Return NIL
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ AFR070Desc ³ Autor ³ Cesar C S Prado       ³ Data ³ 09.08.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Busca a descricao a ser impressa para subtotal / total       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ AFR070Desc(nPar01)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nPar01 - Ordem da impressao do relatorio (1-Conta/2-C.Custo) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR070                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AFR070Desc(nOrdem, cFilCab ,cChave )
Local cAlias  := Alias()
Local cDescr  := ""
Local lCtb     := CtbInUse()

If lCtb
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
Else
	dbSelectArea( Iif( nOrdem == 1, "SI1", "SI3" ) )
	IF MsSeek(cFilial+cChave)
		cDescr := Iif( nOrdem==1,MascaraCTB(cChave),cChave) + " " + Iif(nOrdem==1,SI1->I1_DESC,SI3->I3_DESC)
	Endif
EndIf

dbSelectArea( cAlias )
Return (cDescr)


//------------------------------------------------------------------------------------------------------
/*{Protheus.doc} AFPesqPict

Cache para pictures utilizada no relatorio

@params:
	
@return: cRetorno (Picture)

@sample:
	
@author Totvs

@since 24/04/2019
@version 1.0
*/
//------------------------------------------------------------------------------------------------------
Static Function AFPesqPict(cAlias /*"SN3"*/, cCampo /*"N3_VORIG1"*/ , nTam /*19*/,nSuf)
Local cRetorno := ""
Local nPosRet  := 0

If AFCachePict == NIL
	AFCachePict := {}
EndIf

If ( nPosRet := aScan(AFCachePict, {|x| x[1] == cAlias .And. x[2] == cCampo .And. x[3]== nTam .And. x[4] == nSuf }) ) == 0
	cRetorno := PesqPict(cAlias /*"SN3"*/, cCampo /*"N3_VORIG1"*/ , nTam /*19*/,nSuf)
	aAdd(AFCachePict, {cAlias , cCampo, nTam, nSuf, cRetorno })
Else
	cRetorno := AFCachePict[nPosRet, 5]
EndIf

Return(cRetorno)
/*/{Protheus.doc} VldUltDepr
	Irá validar se todas as filiais selecionadas estão com a mesma data no MV_ULTDEPR
	@type  Static Function
	@author wilton.santos
	@since 02/02/2023
	@version 1.0
	@param aSelFil
	@return lRet
	/*/
Static Function VldUltDepr(aSelfil)
Local lRet     := .T.
Local cFilbkp  := cFilAnt
Local nX   	   := 0
Local aValid   := {}
Local dUltDepr := ''

For nX:= 1 to len(aSelfil)
		cFilAnt  := aSelfil[nX]
		dUltDepr := SuperGetMV('MV_ULTDEPR', .F., '19800101')
		If valtype(dUltDepr) == 'D'
			aAdd(aValid, dUltDepr) 
		else
			lRet := .F.
			Exit
		EndIf	
Next nX

if lRet
	dUltDepr := aValid[1]
	For nX:= 2 to len(aValid)
		if dUltDepr != aValid[nX]
			lRet := .F.
			Exit
		EndIF
	Next nX
EndIf	

cFilAnt := cFilbkp

Return lRet
