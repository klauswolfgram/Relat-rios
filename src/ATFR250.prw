/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR250.CH"
#INCLUDE "Protheus.ch"

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATFR250   บAutor  ณCarlos A. Gomes Jr. บ Data ณ  06/06/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelacao de aquisicoes por transferencia                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAATF                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ATFR250
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATFR260   บAutor  ณCarlos A. Gomes Jr. บ Data ณ  06/06/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Definicao do objeto do relatorio personalizavel e das      บฑฑ
ฑฑบ          ณ secoes que serao utilizadas                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAATF                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

Local oReport,oSectionT,oSection1,oSectionA
Local lCtb    := CtbInUse()
Local cReport := "ATFR250"
Local cTitulo := OemToAnsi(STR0004)  //"Aquis por Transferencia"
Local cDescri := OemToAnsi(STR0001) + OemToAnsi(STR0002) + OemToAnsi(STR0003) //"Este relatorio ira imprimir as Aquisicoes por Transf den- " ##"tro dos parametros especificados" ##"Aquisicoes Por Transf"

Local cAliasCTB := Iif(lCtb,"CT1","SI1")
Local cCpoCTB   := Iif(lCtb,"CT1_DESC01","I1_DESC")

Pergunte( "AFR250" , .F. )

oReport  := TReport():New( cReport, cTitulo, "AFR250" , { |oReport| ReportPrint( oReport, lCtb , cAliasCTB ) }, cDescri )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define a secao Origem / Destino                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSectionT := TRSection():New( oReport, STR0029, {"SN4","SN3","SN1",cAliasCTB} ) // "Origem/Destino"
TRCell():New( oSectionT, "cTipoMov"   ,/*Alias*/,STR0029,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)					// Origem ou Destino
TRCell():New( oSectionT, "cTxt1"      ,/*Alias*/,StrTran(STR0011,"  -  ",""),/*Picture*/,15,/*lPixel*/,{|| OemToAnsi(STR0011) } )							// Moveimento no.
TRCell():New( oSectionT, "N4_CODBAIX" , "SN4"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Movimento
TRCell():New( oSectionT, "cTxt2"      ,/*Alias*/,STR0030,/*Picture*/,10,/*lPixel*/,{|| OemToAnsi(STR0012) })	// "Texto da Data"
TRCell():New( oSectionT, "N4_DATA" 		, "SN4"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Movimento
oSectionT:SetHeaderSection(.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define a 1a. secao - Dados do Ativo                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection1 := TRSection():New( oSectionT, STR0031 ) // "Dados do Ativo"
TRCell():New( oSection1, "N4_CBASE"   , "SN4"   ,/*X3Titulo*/,/*Picture*/,TamSx3('N4_CBASE')[1]+5,/*lPixel*/,/*{|| code-block de impressao }*/)	// Codigo
TRCell():New( oSection1, "N4_ITEM"    , "SN4"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Item
TRCell():New( oSection1, "N3_TIPO"    , "SN3"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Item
TRCell():New( oSection1, "N3_TPSALDO" , "SN3"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Item
TRCell():New( oSection1, "N1_DESCRIC" , "SN1"   ,/*X3Titulo*/,/*Picture*/,35         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// DescricaoTRCell():New( oSection1, "N1_AQUISIC" , "SN1"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Data Aquisicao
TRCell():New( oSection1, "N1_AQUISIC" , "SN1"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// DescricaoTRCell():New( oSection1, "N1_AQUISIC" , "SN1"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Data Aquisicao
TRCell():New( oSection1, "N1_CHAPA"   , "SN1"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Chapa
TRCell():New( oSection1, "N3_CUSTBEM" , "SN3"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de Custo
TRCell():New( oSection1, "N3_CCONTAB" , "SN3"   ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Conta contabil
TRCell():New( oSection1, cCpoCTB      ,cAliasCTB,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Descricao conta
oSection1:SetHeaderPage(.T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define a secao "A" - Valor Original                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSectionA := TRSection():New( oSection1, STR0037  ) // "A - Valor Original"
TRCell():New( oSectionA, "cDescValor" ,/*Alias*/,OemtoAnsi(STR0027),/*Picture*/,27,/*lPixel*/,{|| OemtoAnsi(STR0014) } )			//"Valor Original         --->"
TRCell():New( oSectionA, "nValMoeda1" ,/*Alias*/,STR0032,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// "*** MOEDA 1 ***"
TRCell():New( oSectionA, "nValMoeda2" ,/*Alias*/,STR0033,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// "*** MOEDA 2 ***"
TRCell():New( oSectionA, "nValMoeda3" ,/*Alias*/,STR0034,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// "*** MOEDA 3 ***"
TRCell():New( oSectionA, "nValMoeda4" ,/*Alias*/,STR0035,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// "*** MOEDA 4 ***"
TRCell():New( oSectionA, "nValMoeda5" ,/*Alias*/,STR0036,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// "*** MOEDA 5 ***"
oSectionA:SetHeaderPage(.T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define a secao "B" - Depreciacao Acumulada           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSectionB := TRSection():New( oSection1, STR0038 ) // "B - Depreciacao Acumulada"
TRCell():New( oSectionB, "cDescValor" ,/*Alias*/,OemtoAnsi(STR0027),/*Picture*/,27,/*lPixel*/,{|| OemtoAnsi(STR0015) } )			//"Depreciacao Acumulada  --->"
TRCell():New( oSectionB, "nValMoeda1" ,/*Alias*/,STR0032,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda1
TRCell():New( oSectionB, "nValMoeda2" ,/*Alias*/,STR0033,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda2
TRCell():New( oSectionB, "nValMoeda3" ,/*Alias*/,STR0034,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda3
TRCell():New( oSectionB, "nValMoeda4" ,/*Alias*/,STR0035,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda4
TRCell():New( oSectionB, "nValMoeda5" ,/*Alias*/,STR0036,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda5
oSectionB:SetHeaderSection(.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define a secao "C" - Correcao                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSectionC := TRSection():New( oSection1, STR0039  ) // "C - Correcao"
TRCell():New( oSectionC, "cDescValor" ,/*Alias*/,OemtoAnsi(STR0027),/*Picture*/,27,/*lPixel*/,{|| OemtoAnsi(STR0016) } )			//"Correcao               --->"
TRCell():New( oSectionC, "nValMoeda1" ,/*Alias*/,STR0032,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda1
oSectionC:SetHeaderSection(.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define a secao "D" - Residual                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSectionD := TRSection():New( oSection1, STR0040  ) // "D - Residual"
TRCell():New( oSectionD, "cDescValor" ,/*Alias*/,OemtoAnsi(STR0027),/*Picture*/,27,/*lPixel*/,{|| OemtoAnsi(STR0017) } )			//"Residual               --->"
TRCell():New( oSectionD, "nValMoeda1" ,/*Alias*/,STR0032,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda1
TRCell():New( oSectionD, "nValMoeda2" ,/*Alias*/,STR0033,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda2
TRCell():New( oSectionD, "nValMoeda3" ,/*Alias*/,STR0034,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda3
TRCell():New( oSectionD, "nValMoeda4" ,/*Alias*/,STR0035,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda4
TRCell():New( oSectionD, "nValMoeda5" ,/*Alias*/,STR0036,/*Picture*/,16         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda5
oSectionD:SetHeaderSection(.F.)

oReport:SetTotalInLine(.F.)
oSectionT:SetNoFilter({"SN1", "SN3","CT1"})

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrintบAutor  ณCarlos A. Gomes Jr. บ Data ณ 06/05/06   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณQuery de impressao do relatorio                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAATF                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint( oReport , lCtb , cAliasCTB )

Local oSectionT := oReport:Section(1)
Local oSection1 := oSectionT:Section(1)
Local oSectionA := oSection1:Section(1)
Local oSectionB := oSection1:Section(2)
Local oSectionC := oSection1:Section(3)
Local oSectionD := oSection1:Section(4)

Local oBreakA,oBreakB,oBreakC,oBreakD

Local cChave    := ""

Local cAliasSN3 := "SN3"
Local cAliasSN4 := "SN4"
Local cAliasSN1 := "SN1"

Local cTpReg    := ""
Local cCpoCTB   := Iif(lCtb,"CT1_DESC01","I1_DESC")

Local nOrDesAn  := 1
Local nOrDesAt  := 1
Local lAtfCusPrv := AFXAtCsPrv()

Local cQuery := ""
Local cFrom  := ""
Local cWhere := ""
Local cFiltro := ""

Local cMovim   := ""
Local cN1TipoNeg := Alltrim(SuperGetMv("MV_N1TPNEG",.F.,"")) // Tipos de N1_PATRIM que aceitam Valor originais negativos
Local cN3TipoNeg := Alltrim(SuperGetMv("MV_N3TPNEG",.F.,"")) // Tipos de N3_TIPO que aceitam Valor originais negativos

Local aClassif := {}
Local cClassif := ""


oSectionA:Cell("cDescValor"):SetTitle("")
oSectionB:Cell("cDescValor"):SetTitle("")
oSectionC:Cell("cDescValor"):SetTitle("")
oSectionD:Cell("cDescValor"):SetTitle("")

If mv_par06 == 1
	aClassif := AdmGetClass()
	If Len( aClassif ) <= 0
		Return
	EndIf
EndIf

	cFrom  := "%"+RetSqlName(cAliasCTB)+" "+cAliasCTB+"%"

	If lCtb
		cWhere := "CT1.CT1_FILIAL = '"+xFilial("CT1")+"'  AND "
		cWhere += "SN3.N3_CCONTAB = CT1.CT1_CONTA AND "
		cWhere += "SN1.D_E_L_E_T_ = ' '"
	Else
		cWhere := "SI1.SI1_FILIAL = '"+xFilial("CT1")+"'  AND "
		cWhere += "SN3.N3_CCONTAB = SI1.I1_CODIGO AND "
		cWhere += "SI1.D_E_L_E_T_ = ' '"
	EndIf
	//Filtra as classifica็๕es
	If Len(aClassif) > 0
		cWhere += " AND SN1.N1_PATRIM IN " + FORMATCLAS(aClassif,.T.)
	EndIf

	If lAtfCusPrv .And. MV_PAR07 == 2
		cWhere += " AND SN3.N3_ATFCPR <> '1' "
	EndIf

	cWhere := "%"+cWhere+"%"

	If mv_par05 == 2
		cTpReg := "(N4_OCORR = '01' OR N4_OCORR = '05') AND N4_TIPOCNT = '1'"
	ElseIf mv_par05 == 3
		cTpReg := "(N4_OCORR = '15' OR N4_OCORR = '16' OR N4_OCORR = '01' OR N4_OCORR = '05') AND N4_TIPOCNT = '1'"
	Else
		cTpReg := "(N4_OCORR = '15' OR N4_OCORR = '16')"
	Endif
	cTpReg := "%"+cTpReg+"%"

	cChave    := "N4_FILIAL + N4_DATA + N4_CONTA + N4_CODBAIX + N4_OCORR"
	cChave	 := "%" + SqlOrder(cChave) + "%"

	cQuery    := GetNextAlias()
	cAliasSN4 := cQuery
	cAliasSN3 := cQuery
	cAliasSN1 := cQuery
	cAliasCTB := cQuery
	cCpoCTB   := "%"+cCpoCTB+"%"

	oSectionT:BeginQuery()
	BeginSql Alias cQuery
		SELECT
			N4_CBASE, N4_ITEM, N4_OCORR, N4_CODBAIX, N4_DATA,
			N3_CUSTBEM, N3_CCONTAB, N3_VRCACM1, N3_TIPO,N3_TPSALDO,
			N3_VORIG1, N3_VORIG2, N3_VORIG3, N3_VORIG4, N3_VORIG5,
			N3_VRDACM1, N3_VRDACM2, N3_VRDACM3, N3_VRDACM4, N3_VRDACM5,
			N3_AMPLIA1, N3_AMPLIA2, N3_AMPLIA3, N3_AMPLIA4, N3_AMPLIA5,
			N1_DESCRIC, N1_AQUISIC, N1_PATRIM, N1_CHAPA,
			%Exp:cCpoCTB%
		FROM
			%table:SN4% SN4, %table:SN3% SN3, %table:SN1% SN1, %Exp:cFrom%
		WHERE
			SN4.N4_FILIAL = %xfilial:SN4% AND
			N4_CONTA BETWEEN %Exp:mv_par03% AND %Exp:mv_par04% AND
			N4_DATA BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
			%Exp:cTpReg% AND
			N4_CODBAIX <> ' ' AND
			SN4.%notDel% AND
			SN3.N3_FILIAL = %xfilial:SN3% AND
			SN3.N3_CBASE  = SN4.N4_CBASE AND
			SN3.N3_ITEM   = SN4.N4_ITEM AND
			SN3.N3_TIPO   = SN4.N4_TIPO AND
			SN3.%notDel% AND
			SN1.N1_FILIAL = %xfilial:SN1%  AND
			SN1.N1_CBASE = SN4.N4_CBASE AND
			SN1.N1_ITEM  = SN4.N4_ITEM AND
			SN1.%notDel% AND
			%Exp:cWhere%
		ORDER BY %Exp:cChave%
	EndSql
	oSectionT:EndQuery()

	oSection1:SetParentQuery()
	oSectionA:SetParentQuery()
	oSectionB:SetParentQuery()
	oSectionC:SetParentQuery()
	oSectionD:SetParentQuery()

oSectionA:Cell("nValMoeda1"):SetPicture(PesqPict("SN3","N3_VORIG1",16,1))
oSectionA:Cell("nValMoeda2"):SetPicture(PesqPict("SN3","N3_VORIG2",16,1))
oSectionA:Cell("nValMoeda3"):SetPicture(PesqPict("SN3","N3_VORIG3",16,1))
oSectionA:Cell("nValMoeda4"):SetPicture(PesqPict("SN3","N3_VORIG4",16,1))
oSectionA:Cell("nValMoeda5"):SetPicture(PesqPict("SN3","N3_VORIG5",16,1))

oSectionB:Cell("nValMoeda1"):SetPicture(PesqPict("SN3","N3_VRDACM1",16,1))
oSectionB:Cell("nValMoeda2"):SetPicture(PesqPict("SN3","N3_VRDACM2",16,1))
oSectionB:Cell("nValMoeda3"):SetPicture(PesqPict("SN3","N3_VRDACM3",16,1))
oSectionB:Cell("nValMoeda4"):SetPicture(PesqPict("SN3","N3_VRDACM4",16,1))
oSectionB:Cell("nValMoeda5"):SetPicture(PesqPict("SN3","N3_VRDACM5",16,1))

oSectionC:Cell("nValMoeda1"):SetPicture(PesqPict("SN3","N3_VRCACM1",16,1))

oSectionD:Cell("nValMoeda1"):SetPicture(PesqPict("SN3","N3_VRDACM1",16,1))
oSectionD:Cell("nValMoeda2"):SetPicture(PesqPict("SN3","N3_VRDACM2",16,1))
oSectionD:Cell("nValMoeda3"):SetPicture(PesqPict("SN3","N3_VRDACM3",16,1))
oSectionD:Cell("nValMoeda4"):SetPicture(PesqPict("SN3","N3_VRDACM4",16,1))
oSectionD:Cell("nValMoeda5"):SetPicture(PesqPict("SN3","N3_VRDACM5",16,1))

oSectionA:Cell("nValMoeda1"):SetBlock({|| (cAliasSN3)->(N3_VORIG1 + N3_AMPLIA1)  })
oSectionA:Cell("nValMoeda2"):SetBlock({|| (cAliasSN3)->(N3_VORIG2 + N3_AMPLIA2)  })
oSectionA:Cell("nValMoeda3"):SetBlock({|| (cAliasSN3)->(N3_VORIG3 + N3_AMPLIA3)  })
oSectionA:Cell("nValMoeda4"):SetBlock({|| (cAliasSN3)->(N3_VORIG4 + N3_AMPLIA4)  })
oSectionA:Cell("nValMoeda5"):SetBlock({|| (cAliasSN3)->(N3_VORIG5 + N3_AMPLIA5)  })

oSectionB:Cell("nValMoeda1"):SetBlock({|| (cAliasSN3)->N3_VRDACM1  })
oSectionB:Cell("nValMoeda2"):SetBlock({|| (cAliasSN3)->N3_VRDACM2  })
oSectionB:Cell("nValMoeda3"):SetBlock({|| (cAliasSN3)->N3_VRDACM3  })
oSectionB:Cell("nValMoeda4"):SetBlock({|| (cAliasSN3)->N3_VRDACM4  })
oSectionB:Cell("nValMoeda5"):SetBlock({|| (cAliasSN3)->N3_VRDACM5  })

oSectionC:Cell("nValMoeda1"):SetBlock({|| (cAliasSN3)->N3_VRCACM1  })

oSectionD:Cell("nValMoeda1"):SetBlock({|| (cAliasSN3)->(N3_VORIG1 + N3_AMPLIA1 + (N3_VRDACM1 * Iif(N3_TIPO = "05" .Or. (cAliasSn1)->N1_PATRIM $ cN1TipoNeg .Or. N3_TIPO $ cN3TipoNeg,1,(-1)) ) + N3_VRCACM1 )  })
oSectionD:Cell("nValMoeda2"):SetBlock({|| (cAliasSN3)->(N3_VORIG2 + N3_AMPLIA2 + (N3_VRDACM2 * Iif(N3_TIPO = "05" .Or. (cAliasSn1)->N1_PATRIM $ cN1TipoNeg .Or. N3_TIPO $ cN3TipoNeg,1,(-1)) ) )  })
oSectionD:Cell("nValMoeda3"):SetBlock({|| (cAliasSN3)->(N3_VORIG3 + N3_AMPLIA3 + (N3_VRDACM3 * Iif(N3_TIPO = "05" .Or. (cAliasSn1)->N1_PATRIM $ cN1TipoNeg .Or. N3_TIPO $ cN3TipoNeg,1,(-1)) ) )  })
oSectionD:Cell("nValMoeda4"):SetBlock({|| (cAliasSN3)->(N3_VORIG4 + N3_AMPLIA4 + (N3_VRDACM4 * Iif(N3_TIPO = "05" .Or. (cAliasSn1)->N1_PATRIM $ cN1TipoNeg .Or. N3_TIPO $ cN3TipoNeg,1,(-1)) ) )  })
oSectionD:Cell("nValMoeda5"):SetBlock({|| (cAliasSN3)->(N3_VORIG5 + N3_AMPLIA5 + (N3_VRDACM5 * Iif(N3_TIPO = "05" .Or. (cAliasSn1)->N1_PATRIM $ cN1TipoNeg .Or. N3_TIPO $ cN3TipoNeg,1,(-1)) ) )  })

oBreakA := TRBreak():New ( oSectionT , { || (cAliasSN4)->N4_DATA } , OemtoAnsi(STR0028) + StrTran(OemtoAnsi(STR0014), "--->", ""))
oBreakB := TRBreak():New ( oSectionT , { || (cAliasSN4)->N4_DATA } , OemtoAnsi(STR0028) + StrTran(OemtoAnsi(STR0015), "--->", ""))
oBreakC := TRBreak():New ( oSectionT , { || (cAliasSN4)->N4_DATA } , OemtoAnsi(STR0028) + StrTran(OemtoAnsi(STR0016), "--->", ""))
oBreakD := TRBreak():New ( oSectionT , { || (cAliasSN4)->N4_DATA } , OemtoAnsi(STR0028) + StrTran(OemtoAnsi(STR0017), "--->", ""))

TRFunction():New ( oSectionA:Cell("nValMoeda1") , , "SUM" , oBreakA , , , , .F. , .F. )
TRFunction():New ( oSectionA:Cell("nValMoeda2") , , "SUM" , oBreakA , , , , .F. , .F. )
TRFunction():New ( oSectionA:Cell("nValMoeda3") , , "SUM" , oBreakA , , , , .F. , .F. )
TRFunction():New ( oSectionA:Cell("nValMoeda4") , , "SUM" , oBreakA , , , , .F. , .F. )
TRFunction():New ( oSectionA:Cell("nValMoeda5") , , "SUM" , oBreakA , , , , .F. , .F. )

TRFunction():New ( oSectionB:Cell("nValMoeda1") , , "SUM" , oBreakB , , , , .F. , .F. )
TRFunction():New ( oSectionB:Cell("nValMoeda2") , , "SUM" , oBreakB , , , , .F. , .F. )
TRFunction():New ( oSectionB:Cell("nValMoeda3") , , "SUM" , oBreakB , , , , .F. , .F. )
TRFunction():New ( oSectionB:Cell("nValMoeda4") , , "SUM" , oBreakB , , , , .F. , .F. )
TRFunction():New ( oSectionB:Cell("nValMoeda5") , , "SUM" , oBreakB , , , , .F. , .F. )

TRFunction():New ( oSectionC:Cell("nValMoeda1") , , "SUM" , oBreakC , , , , .F. , .F. )

TRFunction():New ( oSectionD:Cell("nValMoeda1") , , "SUM" , oBreakD , , , , .F. , .F. )
TRFunction():New ( oSectionD:Cell("nValMoeda2") , , "SUM" , oBreakD , , , , .F. , .F. )
TRFunction():New ( oSectionD:Cell("nValMoeda3") , , "SUM" , oBreakD , , , , .F. , .F. )
TRFunction():New ( oSectionD:Cell("nValMoeda4") , , "SUM" , oBreakD , , , , .F. , .F. )
TRFunction():New ( oSectionD:Cell("nValMoeda5") , , "SUM" , oBreakD , , , , .F. , .F. )


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicio da impressao do fluxo do relat๓rio                               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport:SetMeter((cAliasSN4)->(RecCount()))

Do While !oReport:Cancel() .And. !(cAliasSN4)->( Eof() )

	If (cAliasSN4)->(N4_OCORR == "15" .Or. N4_OCORR == "01")
		oSectionT:Cell("cTipoMov"):SetBlock({|| OemtoAnsi(STR0010)  })
		nOrDesAn := 1
		nOrDesAt := 1
	Else
		oSectionT:Cell("cTipoMov"):SetBlock({|| OemtoAnsi(STR0013) })
		nOrDesAn := 2
		nOrDesAt := 2
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณAbre a secao totalizadora do relatorio                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oSectionT:Init()
	oReport:ThinLine ( )
	oSectionT:PrintLine()
	oReport:ThinLine ( )

	cMovim := (cAliasSN4)->N4_CODBAIX
	oSection1:Init()
	oSectionA:Init()
	oSectionB:Init()
	oSectionC:Init()
	oSectionD:Init()

	Do While !oReport:Cancel() .And. !(cAliasSN4)->( Eof() ) .And. (cAliasSN4)->N4_CODBAIX == cMovim .And. nOrDesAn == nOrDesAt

		oReport:IncMeter()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime a 1a. secao do relatorio                                        ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oSection1:PrintLine()
		oReport:SkipLine()
		oSectionA:PrintLine()
		oSectionB:PrintLine()
		oSectionC:PrintLine()
		oSectionD:PrintLine()
		oReport:SkipLine()

		(cAliasSN4)->(dbSkip())
		If lOrDes := (cAliasSN4)->(N4_OCORR == "15" .Or. N4_OCORR == "01")
			nOrDesAt := 1
		Else
			nOrDesAt := 2
		EndIf
	EndDo

	oSection1:Finish()
	oSectionA:Finish()
	oSectionB:Finish()
	oSectionC:Finish()
	oSectionD:Finish()
	oSectionT:Finish()

EndDo

Return
