/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "ATFR471.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} ATFR471
Função do relatório/demonstrativo de custos de empréstimos
Implementação feita de acordo com a norma contábil CPC 20.

@author marylly.araujo
@since 18/09/2012
@version MP11
/*/
//-------------------------------------------------------------------

User Function ATFR471()

Local oReport		:= Nil
Local lTReport	:= TRepInUse()
Local lDefTop 	:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
Local lSelFil		:= .F.
Local aSM0Fils	:= AdmAbreSM0()

Private cPerg		:= "AFR471"
Private aSelFil	:= {}

If !lDefTop
	Help("  ",1,"AFR471TOP",,STR0001 ,1,0) //"Função disponível apenas para ambientes TopConnect"
	Return
EndIf

If !lTReport
	Help("  ",1,"AFR471R4",,STR0002,1,0) //"Função disponível apenas para TReport, por favor atualizar ambiente e verificar parametro MV_TREPORT"
	Return
ENdIf

lRet		:= Pergunte( cPerg , .T. )
lSelFil	:= (MV_PAR10 == 1)

If lRet
	If lSelFil .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Return
		EndIf
	EndIf

	oReport:= ReportDef(aSM0Fils)
	oReport:PrintDialog()
EndIf

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Função de definição do layout e formato do relatório

@param aSM0Fils	Array com as informações de todas as filiais do sistema
@return oReport	Objeto criado com o formato do relatório
@author marylly.araujo
@since 18/09/2012
@version MP11
/*/
//-------------------------------------------------------------------
Static Function ReportDef(aSM0Fils)

Local oReport		:= nil
Local oBemFil		:= nil
Local oBrkBemFil	:= nil
Local oBrkBase		:= nil
Local oBrkConta	:= nil
Local oBrkCusto	:= nil
Local oBrkCustEmp	:= nil
Local oBrkItem		:= nil
Local oBrkClass	:= nil
Local oBrkBmOrig	:= nil
Local oBemFilCel	:= nil
Local oTFilBem		:= nil
Local oTBase		:= nil
Local oTCusAc		:= nil
Local oTTotal		:= nil
Local oBemCust		:= nil
Local oTConta		:= nil
Local oTCusto		:= nil
Local oTCustEmp	:= nil
Local oTItem		:= nil
Local oTClass		:= nil
Local oTBmOrig		:= nil
Local cDesc		:= STR0004
Local cTitulo		:= STR0005
Local cAlsCust 	:= GetNextAlias()
Local lQuebras		:= (MV_PAR14 == 1)
Local cEntQuebra	:= MV_PAR11
Local lSelFil		:= (MV_PAR10 == 1)
Local lTotalQueb	:= (MV_PAR12 == 1)
Local lTotalAtOr	:= (MV_PAR13 == 1)
Local nTamCodBase	:= TamSX3("FN5_CBAORI")[1]
Local oCelEntid	:= Nil
Local oToBase		:= nil
Local oToCusAc		:= nil
Local oToTotal		:= nil

/*
 * Chamada do pergunte com os parâmetros para definir o comportamento e filtros
 * do relatório
 */
Pergunte(cPerg,.F.)

/*
 * Definição padrão do relatório TReport
 */
DEFINE REPORT oReport NAME "ATFR471" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport,cPerg,cAlsCust,aSM0Fils)} DESCRIPTION cDesc TOTAL IN COLUMN

/*
 * Desabilita o botão de parâmetros de customizações do relatório TReport
 */
oReport:ParamReadOnly()

/*
 * Seção dos dados principais do relatório
 */
DEFINE SECTION oBemFil OF oReport TITLE STR0006 TABLES (cAlsCust)  //"Custos de Empréstimos"
	oBemFilCel := TRCell():New( oBemFil, "FN5_FILIAL"	, "FN5", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| (cAlsCust)->FN5_FILIAL + GetFilDsc((cAlsCust)->FN5_FILIAL,aSM0Fils)})
If cEntQuebra == 1 .OR. cEntQuebra == 0
	TRCell():New( oBemFil, "FN5_CBAORI"	, "FN5", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| (cAlsCust)->FN5_CBAORI })
ElseIf cEntQuebra == 2
	TRCell():New( oBemFil, "N3_CCONTAB"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| AllTrim((cAlsCust)->ORIG_CCONTA) + " - " + AllTrim((cAlsCust)->ORIG_CT1DSC) })
ElseIf cEntQuebra == 3
	TRCell():New( oBemFil, "N3_CUSTBEM"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| AllTrim((cAlsCust)->ORIG_CCUSTO) + " - " + AllTrim((cAlsCust)->ORIG_CTTDSC) })
ElseIf cEntQuebra == 4
	TRCell():New( oBemFil, "N3_SUBCCON"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| AllTrim((cAlsCust)->ORIG_ITEMCN) + " - " + AllTrim((cAlsCust)->ORIG_CTDDSC) })
ElseIf cEntQuebra == 5
	TRCell():New( oBemFil, "N3_CLVLCON"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| AllTrim((cAlsCust)->ORIG_CLVL) + " - " + AllTrim((cAlsCust)->ORIG_CTHDSC)  })
EndIf

/*
 * Seção dos dados dos bens de origem do relatório
 */
DEFINE SECTION oBemOrig OF oBemFil TITLE STR0007 TABLES "FN5" //"Bens de Origem"
	TRCell():New( oBemOrig, "FN5_CBAORI"	, "FN5", /*X3Titulo*/, /*Picture*/, /*TamSX3("FN5_CBAORI")[1]*/,/*lPixel*/.F.,{|| (cAlsCust)->FN5_CBAORI },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oBemOrig, "FN5_ITEORI"	, "FN5", /*X3Titulo*/, /*Picture*/, /*TamSX3("FN5_ITEORI")[1]*/,/*lPixel*/.F.,{|| (cAlsCust)->FN5_ITEORI },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oBemOrig, "N1_DESCRIC"	, "SN1", /*X3Titulo*/, /*Picture*/, /*TamSX3("N1_DESCRIC")[1]*/,/*lPixel*/.F.,{|| (cAlsCust)->ORIG_DESCR },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oBemOrig, "ORIG_AQUIS"	, "SN1", Atf012x3titulo("N1_AQUISIC"), /*Picture*/, /*TamSX3("N1_AQUISIC")[1]*/,/*lPixel*/.F.,{|| STOD((cAlsCust)->ORIG_AQUIS) },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oBemOrig, "ORIG_VORIG1"	, "SN3", Atf012x3titulo("N3_VORIG1"), PesqPict("SN3","N3_VORIG1" ,19,1), /*Tamanho*/,/*lPixel*/,{|| (cAlsCust)->ORIG_VORIG1 },/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
If cEntQuebra == 2
	oCelEntid := TRCell():New( oBemOrig, "N3_CCONTAB"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| AllTrim((cAlsCust)->ORIG_CCONTA) + " - " + AllTrim((cAlsCust)->ORIG_CT1DSC) })
ElseIf cEntQuebra == 3
	oCelEntid := TRCell():New( oBemOrig, "N3_CUSTBEM"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| AllTrim((cAlsCust)->ORIG_CCUSTO) + " - " + AllTrim((cAlsCust)->ORIG_CTTDSC) })
ElseIf cEntQuebra == 4
	oCelEntid := TRCell():New( oBemOrig, "N3_SUBCCON"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| AllTrim((cAlsCust)->ORIG_ITEMCN) + " - " + AllTrim((cAlsCust)->ORIG_CTDDSC) })
ElseIf cEntQuebra == 5
	oCelEntid := TRCell():New( oBemOrig, "N3_CLVLCON"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| AllTrim((cAlsCust)->ORIG_CLVL) + " - " + AllTrim((cAlsCust)->ORIG_CTHDSC)  })
EndIf

	oBemOrig:SetHeaderBreak(.T.)

/*
 * Seção dos dados dos bens de custos de empréstimos
 */
DEFINE SECTION oBemCust OF oBemOrig TITLE STR0008 TABLES "FN5" //"Bens de Custos"
	TRCell():New( oBemCust, "FN5_CBACEM"	, "FN5", /*X3Titulo*/, /*Picture*/, /*TamSX3("FN5_CBAORI")[1]*/ 10,/*lPixel*/.F.,{|| (cAlsCust)->FN5_CBACEM },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oBemCust, "FN5_ITECEM"	, "SN3", /*X3Titulo*/, /*Picture*/, /*TamSX3("FN5_ITEORI")[1]*/ 10,/*lPixel*/.F.,{|| (cAlsCust)->FN5_ITECEM },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oBemCust, "N1_DESCRIC"	, "SN1", /*X3Titulo*/, /*Picture*/, TamSX3("N1_DESCRIC")[1],/*lPixel*/,{|| (cAlsCust)->CUST_DESCR },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oBemCust, "CUST_AQUIS"	, "SN1", Atf012x3titulo("FN1_DATA"), /*Picture*/, TamSX3("FN1_DATA")[1],/*lPixel*/,{|| STOD((cAlsCust)->CUST_AQUIS) },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oBemCust, "FN5_VLRAPR"	, "FN5", /*X3Titulo*/, PesqPict("SN3","N3_VORIG1" ,19,1), /*Tamanho*/,/*lPixel*/,{|| (cAlsCust)->FN5_VLRAPR },/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )

/*
 * Construção das quebra do relatório por entidade contábil
 * Se definido para totalizar na quebra por entidade contábil, os valores serão acumulados.
 */
If cEntQuebra == 2
	oCelEntid:Disable()

	/*
	 * Quebra do relatório por filial
	 */
	oBrkBemFil:= TRBreak():New(oReport, {|| (cAlsCust)->FN5_FILIAL + (cAlsCust)->CT1_CONTA },/**/,/*lTotalInLine*/.T.,/*cNameBrk*/,lQuebras,.F.,lQuebras) //"TOTAL FILIAL:

	/*
	 * Quebra por conta contábil
	 */
	oBrkConta	:= TRBreak():New(oReport, {|| (cAlsCust)->FN5_FILIAL + (cAlsCust)->CT1_CONTA },{|| STR0011 + oCelEntid:GetText()},/*lTotalInLine*/.T.,/*cNameBrk*/,lQuebras) // "Total Conta Contábil: "

	/*
	 * Totalizador dos valores na quebra por conta contábil
	 */
	If lTotalQueb
		oTCusAc	:= TRFunction():New(oBemCust:Cell("FN5_VLRAPR")	,, "SUM",oBrkConta ,STR0017,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oBemOrig)
		oTBase		:= TRFunction():New(oBemOrig:Cell("ORIG_VORIG1")	,, "SUM",oBrkConta ,STR0018,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oBemOrig)
		oTTotal	:= TRFunction():New(oBemOrig:Cell("ORIG_VORIG1")	,, "ONPRINT",oBrkConta ,STR0019,PesqPict("SN3","N3_VORIG1"),{|| oTCusAc:GetValue(.T.)+oTBase:GetValue(.T.) },.F.,.F.,.F.,oBemOrig)

		oTCusAc:SetTotalInLine(.T.)
		oTBase:SetTotalInLine(.T.)
		oTTotal:SetTotalInLine(.T.)
	EndIf
ElseIf cEntQuebra == 3
	oCelEntid:Disable()

	/*
	 * Quebra do relatório por filial
	 */
	oBrkBemFil:= TRBreak():New(oReport, {|| (cAlsCust)->FN5_FILIAL+(cAlsCust)->CTT_CUSTO },/**/,/*lTotalInLine*/.T.,/*cNameBrk*/,lQuebras,.F.,lQuebras) //"TOTAL FILIAL:

	/*
	 * Quebra por centro de custo
	 */
	oBrkCusto	:= TRBreak():New(oReport, {|| (cAlsCust)->FN5_FILIAL+(cAlsCust)->CTT_CUSTO },{|| STR0012 + oCelEntid:GetText()},/*lTotalInLine*/.T.,/*cNameBrk*/,lQuebras) //"Total Centro de Custo: "

	/*
	 * Totalizador dos valores na quebra por centro de custo
	 */
	If lTotalQueb
		oTCusAc	:= TRFunction():New(oBemCust:Cell("FN5_VLRAPR")	,, "SUM",oBrkCusto ,STR0017,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oBemOrig)
		oTCusto	:= TRFunction():New(oBemOrig:Cell("ORIG_VORIG1")	,, "SUM",oBrkCusto ,STR0018,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oBemOrig)
		oTTotal	:= TRFunction():New(oBemOrig:Cell("ORIG_VORIG1")	,, "ONPRINT",oBrkCusto ,STR0019,PesqPict("SN3","N3_VORIG1"),{|| oTCusto:GetValue(.T.)+oTCusAc:GetValue(.T.) },.F.,.F.,.F.,oBemOrig)

		oTCusAc:SetTotalInLine(.T.)
		oTCusto:SetTotalInLine(.T.)
		oTTotal:SetTotalInLine(.T.)
	EndIf
ElseIf cEntQuebra == 4
	oCelEntid:Disable()
	/*
	 * Quebra do relatório por filial
	 */
	oBrkBemFil:= TRBreak():New(oReport, {|| (cAlsCust)->FN5_FILIAL+(cAlsCust)->CTD_ITEM },/**/,/*lTotalInLine*/.T.,/*cNameBrk*/,lQuebras,.F.,lQuebras) //"TOTAL FILIAL:

	/*
	 * Quebra por item contábil
	 */
	oBrkItem	:= TRBreak():New(oReport, {|| (cAlsCust)->FN5_FILIAL+(cAlsCust)->CTD_ITEM },{|| STR0013 + oCelEntid:GetText()},/*lTotalInLine*/.T.,/*cNameBrk*/,lQuebras) //"Total Item Contábil: "

	/*
	 * Totalizador dos valores na quebra por item contábil
	 */
	If lTotalQueb
		oTCusAc	:= TRFunction():New(oBemCust:Cell("FN5_VLRAPR")	,, "SUM",oBrkItem ,STR0017,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oBemOrig)
		oTItem		:= TRFunction():New(oBemOrig:Cell("ORIG_VORIG1")	,, "SUM",oBrkItem ,STR0018,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oBemOrig)
		oTTotal	:= TRFunction():New(oBemOrig:Cell("ORIG_VORIG1")	,, "ONPRINT",oBrkItem ,STR0019,PesqPict("SN3","N3_VORIG1"),{|| oTCusAc:GetValue(.T.)+oTItem:GetValue(.T.) },.F.,.F.,.F.,oBemOrig)

		oTCusAc:SetTotalInLine(.T.)
		oTItem:SetTotalInLine(.T.)
		oTTotal:SetTotalInLine(.T.)
	EndIf
ElseIf cEntQuebra == 5
	oCelEntid:Disable()
	/*
	 * Quebra do relatório por filial
	 */
	oBrkBemFil:= TRBreak():New(oReport, {|| (cAlsCust)->FN5_FILIAL+(cAlsCust)->CTH_CLVL },/**/,/*lTotalInLine*/.T.,/*cNameBrk*/,lQuebras,.F.,lQuebras) //"TOTAL FILIAL:
	/*
	 * Quebra por classe de valor
	 */
	oBrkClass	:= TRBreak():New(oReport, {|| (cAlsCust)->FN5_FILIAL+(cAlsCust)->CTH_CLVL  },{|| STR0014 + oCelEntid:GetText()},/*lTotalInLine*/.T.,/*cNameBrk*/,lQuebras) //"Total Classe Valor: "

	/*
	 * Totalizador dos valores na quebra por classe de valor
	 */
	If lTotalQueb
		oTCusAc	:= TRFunction():New(oBemCust:Cell("FN5_VLRAPR")	,, "SUM",oBrkClass ,STR0017,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oBemOrig)
		oTClass	:= TRFunction():New(oBemOrig:Cell("ORIG_VORIG1")	,, "SUM",oBrkClass ,STR0018,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oBemOrig)
		oTTotal	:= TRFunction():New(oBemOrig:Cell("ORIG_VORIG1")	,, "ONPRINT",oBrkClass ,STR0019,PesqPict("SN3","N3_VORIG1"),{|| oTCusAc:GetValue(.T.)+oTClass:GetValue(.T.)  },.F.,.F.,.F.,oBemOrig)

		oTCusAc:SetTotalInLine(.T.)
		oTClass:SetTotalInLine(.T.)
		oTTotal:SetTotalInLine(.T.)
	EndIf
ElseIf cEntQuebra == 1 .OR. cEntQuebra == 0
	/*
	 * Quebra do relatório por filial
	 */

	oBrkBemFil:= TRBreak():New(oReport, {|| (cAlsCust)->FN5_FILIAL },/*{|| STR0009 + (cAlsCust)->FN5_FILIAL + GetFilDsc((cAlsCust)->FN5_FILIAL,aSM0Fils)}*/,.T.,,lQuebras) //"TOTAL FILIAL:

	/*
	 * Quebra por código base de origem
	 */
	oBrkBase	:= TRBreak():New(oBemFil, {|| (cAlsCust)->FN5_FILIAL + (cAlsCust)->(FN5_CBAORI) },{|| STR0010 + SUBSTR(oBemFil:Cell("FN5_CBAORI"):GetText(),1,nTamCodBase)},/*lTotalInLine*/.T.,/*cNameBrk*/,lQuebras,lQuebras,lQuebras) //"Total Base Origem: "
	oBrkBase:SetTotalInLine(.T.)

	 /*
	  * Quebra do relatórios por Bens de Origem
	  */
	If lTotalQueb
		oTCusAc	:= TRFunction():New(oBemCust:Cell("FN5_VLRAPR")	,, "SUM",oBrkBase ,STR0017,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oBemFil)
		oTBase		:= TRFunction():New(oBemOrig:Cell("ORIG_VORIG1")	,, "SUM",oBrkBase ,STR0018,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oBemFil)
		oTTotal	:= TRFunction():New(oBemOrig:Cell("ORIG_VORIG1")	,, "ONPRINT",oBrkBase ,STR0019,PesqPict("SN3","N3_VORIG1"),{ || oTCusAc:GetValue(.T.)+oTBase:GetValue(.T.) },.F.,.F.,.F.,oBemFil)
		oTCusAc:SetTotalInLine(.T.)
		oTBase:SetTotalInLine(.T.)
		oTTotal:SetTotalInLine(.T.)
	EndIf
EndIf

 /*
  * Quebra do relatórios por Bens de Custos
  */
If lTotalAtOr
	oTCustEmp := TRFunction():New(oBemCust:Cell("FN5_VLRAPR"),,"SUM",/*oBreak*/,STR0016/*cTitle*/,/*cPicture*/,{|| (cAlsCust)->FN5_VLRAPR},.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oBemCust,/*bCondition*/,/*lDisable*/,/*bCanPrint*/)
	oTCustEmp:SetTitle(STR0016)
	oTCustEmp:SetHeaderAlign("RIGHT")
EndIf

oBemFil:SetHeaderSection(.T.)
oBemFil:SetAutoSize()
oBemOrig:SetAutoSize()
oBemCust:SetAutoSize()

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Função para busca das informações que serão impressas no relatório

@param oReport	Objeto para manipulação das seções, atributos e dados do relatório.
@param cPerg		Identificação do Grupo de Perguntas do relatório
@param cAlsCust	Nome de Identificação do RecordSet das informaões do relatório.
@param aSM0Fils	Array com as informações de todas as filiais do sistema.
@return void
@author marylly.araujo
@since 19/09/2012
@version MP11
/*/
//-------------------------------------------------------------------

Static Function PrintReport(oReport,cPerg,cAlsCust,aSM0Fils)

Local oBemFil		:= oReport:Section(1)
Local oBemOrig		:= oBemFil:Section(1)
Local oBemCust		:= oBemOrig:Section(1)
Local cTipo	 	:= ""
Local cCondFil		:= ""
Local cCodDe		:= MV_PAR01
Local cCodAte		:= MV_PAR03
Local cItemDe		:= MV_PAR02
Local cItemAte		:= MV_PAR04
Local cGrpDe		:= MV_PAR05
Local cGrpAte		:= MV_PAR06
Local cTpSaldo		:= MV_PAR07
Local dDtInCap		:= DTOS(MV_PAR08)
Local dDtFmCap		:= DTOS(MV_PAR09)
Local lSelFil		:= (MV_PAR10 == 1)
Local cCpoQry		:= "%%"
Local cJoinEnt		:= "%%"
Local cEntQuebra	:= MV_PAR11
Local nConsBaixas	:= MV_PAR15
Local cOrder		:= ""
Local cQryTpSld	:= "%%"
Local lFWModAc		:= .T.
Local lGestCorp	:= .F.
Local cStrBlCT1	:= "' '"
Local cStrBlFN5	:= "' '"
Local nTamEmp		:= 0
Local nTamUnit		:= 0
Local nTamFil		:= 0
Local nTamCTT		:= 0
Local nTamCTD		:= 0
Local nTamCTH		:= 0
Local lCmpEmpCT1	:= .F.
Local lCmpUniCT1	:= .F.
Local lCmpFilCT1	:= .F.
Local lCmpEmpCTT	:= .F.
Local lCmpUniCTT	:= .F.
Local lCmpFilCTT	:= .F.
Local lCmpEmpCTD	:= .F.
Local lCmpUniCTD	:= .F.
Local lCmpFilCTD	:= .F.
Local lCmpEmpCTH	:= .F.
Local lCmpUniCTH	:= .F.
Local lCmpFilCTH	:= .F.
Local cFunDB		:= ""
Local cFunNull		:= ""
Local cCpoQraCT1	:= ""
Local cCpoQraFN5	:= ""
Local cWhereCPO	:= "%%"
Local cBxWhere		:= "%%"
Local cTmpFil

/*
 * Verifica se o ambiente trabalha com a Gestão Corporativa
 */
lGestCorp := FWSizeFilial() > 2

/*
 * Tratamento da gestão de empresas para utilização na query do relatório de custos de empréstimos
 */
If lFWModAc .AND. lGestCorp
	nTamEmp	:= Len(FWCodEmp("CT1"))
	nTamUnit	:= Len(FWUnitBusiness("CT1"))
	nTamFil	:= Len(FWSM0Layout(FWGrpCompany(),3))
	lCmpEmpCT1	:= (FWModeAccess("CT1",1) == "E" .AND. FWModeAccess("SN3",1) == "E")
	lCmpUniCT1	:= (FWModeAccess("CT1",2) == "E" .AND. FWModeAccess("SN3",2) == "E")
	lCmpFilCT1	:= (FWModeAccess("CT1",3) == "E" .AND. FWModeAccess("SN3",3) == "E")
	lCmpEmpCTT	:= (FWModeAccess("CTT",1) == "E" .AND. FWModeAccess("SN3",1) == "E")
	lCmpUniCTT	:= (FWModeAccess("CTT",2) == "E" .AND. FWModeAccess("SN3",2) == "E")
	lCmpFilCTT	:= (FWModeAccess("CTT",3) == "E" .AND. FWModeAccess("SN3",3) == "E")
	lCmpEmpCTD	:= (FWModeAccess("CTD",1) == "E" .AND. FWModeAccess("SN3",1) == "E")
	lCmpUniCTD	:= (FWModeAccess("CTD",2) == "E" .AND. FWModeAccess("SN3",2) == "E")
	lCmpFilCTD	:= (FWModeAccess("CTD",3) == "E" .AND. FWModeAccess("SN3",3) == "E")
	lCmpEmpCTH	:= (FWModeAccess("CTH",1) == "E" .AND. FWModeAccess("SN3",1) == "E")
	lCmpUniCTH	:= (FWModeAccess("CTH",2) == "E" .AND. FWModeAccess("SN3",2) == "E")
	lCmpFilCTH	:= (FWModeAccess("CTH",3) == "E" .AND. FWModeAccess("SN3",3) == "E")
Else
	lCmpFilCT1 := (!EMPTY(FWXFILIAL("CT1")) .AND. !EMPTY(FWXFILIAL("SN3")))
	lCmpFilCTT := (!EMPTY(FWXFILIAL("CTT")) .AND. !EMPTY(FWXFILIAL("SN3")) .AND. CtbMovSaldo("CTT"))
	lCmpFilCTD := (!EMPTY(FWXFILIAL("CTD")) .AND. !EMPTY(FWXFILIAL("SN3")) .AND. CtbMovSaldo("CTD"))
	lCmpFilCTH := (!EMPTY(FWXFILIAL("CTH")) .AND. !EMPTY(FWXFILIAL("SN3")) .AND. CtbMovSaldo("CTH"))
EndIf

/*
 * Tratamento da função de substring do banco de dados que está sendo utilizado para a aplicação.
 */
If TcGetDb() $ "DB2*INFORMIX*ORACLE"  .OR. ( TcGetDb() == "DB2/400" .And. Upper(TcSrvType()) == "ISERIES" )
	cFunDB := "SUBSTR"
Else
	cFunDB := "SUBSTRING"
EndIf

/*
 * Tratamento da função de nulo do banco de dados que está sendo utilizado para a aplicação.
 */
If TcGetDb() $ "INFORMIX*ORACLE"
	cFunNull := "NVL"
ElseIf TcGetDb() $ "DB2*POSTGRES"  .OR. ( TcGetDb() == "DB2/400" .And. Upper(TcSrvType()) == "ISERIES" )
	cFunNull := "COALESCE"
Else
	cFunNull := "ISNULL"
EndIf

/*
 * Chamada do pergunte com os parâmetros para definir o comportamento e filtros
 * do relatório
 */
Pergunte( cPerg , .F. )

/*
 * Tratamento do Filtro de Filiais de acordo com Pergunte "Seleciona Filial ?"
 */
If lSelFil
	cCondFil 	:= "FN5.FN5_FILIAL " + GetRngFil( aSelfil , "FN5", .T., @cTmpFil ) + " AND "
	cCondFil 	+= "SN3ORIG.N3_FILIAL " + GetRngFil( aSelfil , "SN3" ) + " AND "
	cCondFil 	+= "SN1ORIG.N1_FILIAL " + GetRngFil( aSelfil , "SN1" ) + " AND "
	cCondFil 	+= "SN3CUST.N3_FILIAL " + GetRngFil( aSelfil , "SN3" ) + " AND "
	cCondFil 	+= "SN1CUST.N1_FILIAL " + GetRngFil( aSelfil , "SN1" )
	cCondFil 	:= "%" + cCondFil + "%"
Else
	cCondFil 	:= "% FN5.FN5_FILIAL = '" + XFILIAL("FN5") + "' AND "
	cCondFil 	+= " SN3ORIG.N3_FILIAL = '" + XFILIAL("SN3") + "' AND "
	cCondFil 	+= " SN1ORIG.N1_FILIAL = '" + XFILIAL("SN1") + "' AND "
	cCondFil 	+= " SN3CUST.N3_FILIAL = '" + XFILIAL("SN3") + "' AND "
	cCondFil 	+= " SN1CUST.N1_FILIAL = '" + XFILIAL("SN1") + "'%"
EndIf

/*
 * Tratamento do Filtro por tipo de saldo contábil (Para * considerando todos os tipos de saldo)
 */
If cTpSaldo != "*"
	cQryTpSld := "% SN3CUST.N3_TPSALDO = '" + cTpSaldo + "' AND %"
EndIf


/*
 * Tratamento de Filtro de bens de adiantamento com baixas
 */
If nConsBaixas != Nil .AND. nConsBaixas == 1
	cBxWhere := "% SN3ORIG.N3_BAIXA = '0' AND %"
ElseIf nConsBaixas != Nil .AND. nConsBaixas == 2
	cBxWhere :=  "% SN3ORIG.N3_BAIXA != '0' AND %"
EndIf

/*
 * Montagem do relacionamento na busca de dados de acordo com a quebra do
 * relatório de acordo com a entidade contábil selecionada.
 */
If cEntQuebra == 2
	cCpoQry	:= "%, CT1.CT1_FILIAL, CT1.CT1_CONTA, CT1.CT1_DESC01		ORIG_CT1DSC %"
	cJoinEnt	:= "%INNER JOIN " + RetSqlName("CT1")+ " CT1 ON SN3ORIG.N3_CCONTAB = CT1.CT1_CONTA "

	If lFWModAc .AND.lGestCorp
		If lCmpEmpCT1
			cJoinEnt += " AND " + cFunDB + "(CT1.CT1_FILIAL,1," + CVALTOCHAR(nTamEmp) + ") = " + cFunDB + "(FN5.FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + ") "
		EndIf

		If lCmpUniCT1
			cJoinEnt += " AND " + cFunDB + "(CT1.CT1_FILIAL, " + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + ") = " + cFunDB + "(FN5.FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + ") "
		EndIf
	EndIf

	If lCmpFilCT1
		If lFWModAc .AND. lGestCorp
			cJoinEnt += " AND " + cFunDB + "(CT1.CT1_FILIAL, " + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + ") = " + cFunDB + "(FN5.FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + ") "
		Else
			cJoinEnt += " AND CT1.CT1_FILIAL = FN5.FN5_FILIAL "
		EndIf
	EndIf

	cJoinEnt	+= "%"
	cWhereCPO := "% " + cFunNull + "(CT1.D_E_L_E_T_,' ') = ' ' AND %"
	cOrder		+= " CT1.CT1_CONTA, FN5.FN5_CBAORI, FN5.FN5_ITEORI, FN5.FN5_CBACEM, FN5.FN5_ITECEM "
ElseIf cEntQuebra == 3
	nTamCTT	:= TamSX3("CTT_CUSTO")[1]
	cCpoQry	:= "%, " + cFunNull +"(CTT.CTT_FILIAL,FN5.FN5_FILIAL) CTT_FILIAL, "
	cCpoQry	+= cFunNull +"(CTT.CTT_CUSTO,SN3ORIG.N3_CUSTBEM) CTT_CUSTO, "
	cCpoQry	+= cFunNull +"(CTT.CTT_DESC01,' ')	ORIG_CTTDSC %"
	cJoinEnt	:= "%LEFT JOIN " + RetSqlName("CTT")+ " CTT ON SN3ORIG.N3_CUSTBEM = " + cFunNull +"(CTT.CTT_CUSTO,SN3ORIG.N3_CUSTBEM) "

	If lFWModAc .AND.lGestCorp
		If lCmpEmpCTT
			cJoinEnt += " AND " + cFunDB + "(" + cFunNull + "(CTT.CTT_FILIAL,FN5.FN5_FILIAL),1," + CVALTOCHAR(nTamEmp) + ") = " + cFunDB + "(FN5.FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + ") "
		EndIf

		If lCmpUniCTT
			cJoinEnt += " AND " + cFunDB + "(" + cFunNull +"(CTT.CTT_FILIAL,FN5.FN5_FILIAL), " + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + ") = " + cFunDB + "(FN5.FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + ") "
		EndIf
	EndIf

	If lCmpFilCTT
		If lFWModAc .AND. lGestCorp
			cJoinEnt += " AND " + cFunDB + "(" + cFunNull +"(CTT.CTT_FILIAL,FN5.FN5_FILIAL), " + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + ") = " + cFunDB + "(FN5.FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + ") "
		Else
			cJoinEnt += " AND CTT.CTT_FILIAL = FN5.FN5_FILIAL "
		EndIf
	EndIf

	cJoinEnt	+= "%"
	cWhereCPO := "% " + cFunNull + "(CTT.D_E_L_E_T_,' ') = ' ' AND %"
	cOrder		+= " CTT_CUSTO, FN5.FN5_CBAORI, FN5.FN5_ITEORI, FN5.FN5_CBACEM, FN5.FN5_ITECEM"
ElseIf cEntQuebra == 4
	nTamCTD	:= TamSX3("CTD_ITEM")[1]
	cCpoQry	:= "%, " + cFunNull +"(CTD.CTD_FILIAL,FN5.FN5_FILIAL) CTD_FILIAL, "
	cCpoQry	+= cFunNull +"(CTD.CTD_ITEM,SN3ORIG.N3_SUBCCON) CTD_ITEM, "
	cCpoQry	+= cFunNull +"(CTD.CTD_DESC01,' ')		ORIG_CTDDSC %"
	cJoinEnt	:= "%LEFT JOIN " + RetSqlName("CTD")+ " CTD ON SN3ORIG.N3_SUBCCON = " + cFunNull +"(CTD.CTD_ITEM,SN3ORIG.N3_SUBCCON) "

	If lFWModAc .AND.lGestCorp
		If lCmpEmpCTD
			cJoinEnt += " AND " + cFunDB + "(" + cFunNull +"(CTD.CTD_FILIAL,FN5.FN5_FILIAL),1," + CVALTOCHAR(nTamEmp) + ") = " + cFunDB + "(FN5.FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + ") "
		EndIf

		If lCmpUniCTD
			cJoinEnt += " AND " + cFunDB + "(" + cFunNull +"(CTD.CTD_FILIAL,FN5.FN5_FILIAL), " + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + ") = " + cFunDB + "(FN5.FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + ") "
		EndIf
	EndIf

	If lCmpFilCTD
		If lFWModAc .AND. lGestCorp
			cJoinEnt += " AND " + cFunDB + "(" + cFunNull +"(CTD.CTD_FILIAL,FN5.FN5_FILIAL), " + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + ") = " + cFunDB + "(FN5.FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + ") "
		Else
			cJoinEnt += " AND CTD.CTD_FILIAL = FN5.FN5_FILIAL "
		EndIf
	EndIf

	cJoinEnt	+= "%"
	cWhereCPO := "% " + cFunNull + "(CTD.D_E_L_E_T_,' ') = ' ' AND %"
	cOrder		+= " CTD_ITEM, FN5.FN5_CBAORI, FN5.FN5_ITEORI, FN5.FN5_CBACEM, FN5.FN5_ITECEM "
ElseIf cEntQuebra == 5
	nTamCTH	:= TamSX3("CTH_CLVL")[1]
	cCpoQry	:= "%, " + cFunNull +"(CTH.CTH_FILIAL, FN5.FN5_FILIAL) CTH_FILIAL, "
	cCpoQry	+= cFunNull +"(CTH.CTH_CLVL,SN3ORIG.N3_CLVLCON) CTH_CLVL, "
	cCpoQry	+= cFunNull +"(CTH.CTH_DESC01,' ')		ORIG_CTHDSC %"
	cJoinEnt	:= "%LEFT JOIN " + RetSqlName("CTH")+ " CTH ON SN3ORIG.N3_CLVLCON = " + cFunNull +"(CTH.CTH_CLVL,SN3ORIG.N3_CLVLCON) "

	If lFWModAc .AND.lGestCorp
		If lCmpEmpCTH
			cJoinEnt += " AND " + cFunDB + "(" + cFunNull +"(CTH.CTH_FILIAL,FN5.FN5_FILIAL),1," + CVALTOCHAR(nTamEmp) + ") = " + cFunDB + "(FN5.FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + ") "
		EndIf

		If lCmpUniCTH
			cJoinEnt += " AND " + cFunDB + "(" + cFunNull +"(CTH.CTH_FILIAL,FN5.FN5_FILIAL), " + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + ") = " + cFunDB + "(FN5.FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + ") "
		EndIf
	EndIf

	If lCmpFilCTH
		If lFWModAc .AND. lGestCorp
			cJoinEnt += " AND " + cFunDB + "(" + cFunNull +"(CTH.CTH_FILIAL,FN5.FN5_FILIAL), " + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + ") = " + cFunDB + "(FN5.FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + ") "
		Else
			cJoinEnt += " AND CTH.CTH_FILIAL = FN5.FN5_FILIAL "
		EndIf
	EndIf

	cJoinEnt	+= "%"
	cWhereCPO := "% " + cFunNull + "(CTH.D_E_L_E_T_,' ') = ' ' AND %"
	cOrder		+= " CTH_CLVL, FN5.FN5_CBAORI, FN5.FN5_ITEORI, FN5.FN5_CBACEM, FN5.FN5_ITECEM "
Else
	cOrder		+= " FN5.FN5_CBAORI, FN5.FN5_ITEORI "
EndIf

cOrder := 	"%" + cOrder + "%"

/*
 * Seção Cabeçalho Inicial (Filial / Conta)
 */
BEGIN REPORT QUERY oBemFil

BeginSql alias cAlsCust
	SELECT
		FN5.FN5_FILIAL				,
		FN5.FN5_CBAORI				,
		FN5.FN5_ITEORI				,
		FN5.FN5_TIPEMP				,
		FN5.FN5_TIPORI				,
		FN5.FN5_SLDORI				,
		SN1ORIG.N1_FILIAL		ORIG_FILIAL,
		SN3ORIG.N3_CBASE		ORIG_CBASE,
		SN3ORIG.N3_ITEM		ORIG_ITEM,
		SN3ORIG.N3_TIPO		ORIG_TIPO,
		SN1ORIG.N1_DESCRIC	ORIG_DESCR,
		SN1ORIG.N1_AQUISIC	ORIG_AQUIS,
		SN1ORIG.N1_PATRIM		ORIG_CLPATR,
		SN3ORIG.N3_VORIG1		ORIG_VORIG1,
		SN3ORIG.N3_TPSALDO	ORIG_TPSALD,
		SN3ORIG.N3_CCONTAB	ORIG_CCONTA,
		SN3ORIG.N3_CUSTBEM	ORIG_CCUSTO,
		SN3ORIG.N3_SUBCCON	ORIG_ITEMCN,
		SN3ORIG.N3_CLVLCON	ORIG_CLVL,
		FN5.FN5_CBACEM			,
		FN5.FN5_ITECEM			,
		FN5.FN5_SLDEMP			,
		FN5.FN5_VLRAPR			,
		SN1CUST.N1_DESCRIC	CUST_DESCR,
		FN1.FN1_DATA			CUST_AQUIS,
		SN1CUST.N1_PATRIM		CUST_CLPATR,
		SN3CUST.N3_FILIAL		CUST_FILIAL,
		SN3CUST.N3_CBASE		CUST_CBASE,
		SN3CUST.N3_ITEM		CUST_ITEM,
		SN3CUST.N3_TIPO		CUST_TIPO,
		SN3CUST.N3_TPSALDO	CUST_TPSALD,
		SN3CUST.N3_CCONTAB	CUST_CCONTA
		%exp:cCpoQry%
	FROM %table:FN5% FN5

	INNER JOIN %table:FN1% FN1 ON
		FN5.FN5_FILIAL	= FN1.FN1_FILIAL AND
		FN5.FN5_PROC		= FN1.FN1_PROC

	INNER JOIN %table:SN3% SN3ORIG  ON
		FN5.FN5_FILIAL	= SN3ORIG.N3_FILIAL	AND
		FN5.FN5_CBAORI	= SN3ORIG.N3_CBASE	AND
		FN5.FN5_ITEORI  	= SN3ORIG.N3_ITEM		AND
    	FN5.FN5_TIPORI	= SN3ORIG.N3_TIPO		AND
    	FN5.FN5_SLDORI	= SN3ORIG.N3_TPSALDO

    INNER JOIN %table:SN1% SN1ORIG  ON
    	SN1ORIG.N1_FILIAL	= FN5.FN5_FILIAL		AND
    	SN1ORIG.N1_FILIAL	= SN3ORIG.N3_FILIAL	AND
    	SN1ORIG.N1_CBASE	= SN3ORIG.N3_CBASE	AND
    	SN1ORIG.N1_ITEM	= SN3ORIG.N3_ITEM		AND
		FN5.FN5_CBAORI	= SN1ORIG.N1_CBASE	AND
		FN5.FN5_ITEORI	= SN1ORIG.N1_ITEM

	INNER JOIN %table:SN3% SN3CUST  ON
		FN5.FN5_FILIAL = SN3CUST.N3_FILIAL AND
		FN5.FN5_CBACEM = SN3CUST.N3_CBASE	AND
		FN5.FN5_ITECEM = SN3CUST.N3_ITEM	AND
		FN5.FN5_TIPEMP = SN3CUST.N3_TIPO	AND
		FN5.FN5_SLDEMP = SN3CUST.N3_TPSALDO

	INNER JOIN %table:SN1% SN1CUST  ON
		SN1CUST.N1_FILIAL	= SN3CUST.N3_FILIAL	AND
		SN1CUST.N1_CBASE	= SN3CUST.N3_CBASE	AND
    	SN1CUST.N1_ITEM	= SN3CUST.N3_ITEM		AND
		FN5.FN5_CBACEM	= SN1CUST.N1_CBASE	AND
		FN5.FN5_ITECEM	= SN1CUST.N1_ITEM
	%exp:cJoinEnt%
	WHERE
		%exp:cCondFil%	AND
		FN1.%notDel%		AND
		FN1.FN1_STATUS = '1' AND
		%exp:cWhereCPO%
		FN5.%notDel%		AND
		SN1ORIG.%notDel%	AND
		SN3ORIG.%notDel%	AND
		SN1CUST.%notDel%	AND
		SN3CUST.%notDel%	AND
		%exp:cQryTpSld%
		SN1CUST.N1_PATRIM = 'E' AND
		%exp:cBxWhere%
		SN1ORIG.N1_CBASE BETWEEN %exp:cCodDe% AND %exp:cCodAte% AND
		SN1ORIG.N1_ITEM BETWEEN %exp:cItemDe% AND %exp:cItemAte% AND
		SN1ORIG.N1_GRUPO BETWEEN %exp:cGrpDe% AND %exp:cGrpAte% AND
		FN1.FN1_DATA BETWEEN %exp:dDtInCap% AND %exp:dDtFmCap%
		ORDER BY FN5.FN5_FILIAL, %exp:cOrder%
EndSql

END REPORT QUERY oBemFil

/*
 * Tratamento da filial para cada tipo de quebra do relatório de custos de empréstimos
 */

If cEntQuebra == 2
	If lFWModAc .AND. lGestCorp
		If lCmpEmpCT1
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CT1_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
		Else
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CT1_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CT1_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
		EndIf

		If lCmpUniCT1
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CT1_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
		Else
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CT1_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CT1_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
		EndIf
	EndIf

	If lCmpFilCT1
		If lFWModAc .AND. lGestCorp
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CT1_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
		Else
			cStrBlCT1 += " + CT1_FILIAL "
			cStrBlCT1 += " + FN5_FILIAL "
			cStrBlFN5 += " + CT1_FILIAL "
			cStrBlFN5 += " + FN5_FILIAL "
		EndIf
	Else
		If lFWModAc .AND. lGestCorp
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CT1_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CT1_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
		Else
			cStrBlCT1 += " + CT1_FILIAL "
			cStrBlCT1 += " + FN5_FILIAL "
			cStrBlFN5 += " + CT1_FILIAL "
			cStrBlFN5 += " + FN5_FILIAL "
		EndIf
	EndIf

	cStrBlCT1 += " + CT1_CONTA "
	cStrBlFN5 += " + ORIG_CCONTA "

	cCpoQraCT1	:= " CT1_CONTA "
	cCpoQraFN5	:= " ORIG_CCONTA "

	cStrBlCT1 += " + FN5_CBAORI + FN5_ITEORI "
	cStrBlFN5 += " + FN5_CBAORI + FN5_ITEORI "

	cStrBlCT1 := "AllTrim(" + cStrBlCT1 + ")"
	cStrBlFN5 := "AllTrim(" + cStrBlFN5 + ")"
ElseIf cEntQuebra == 3
	If lFWModAc .AND. lGestCorp
		If lCmpEmpCTT
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTT_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
		Else
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTT_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTT_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
		EndIf

		If lCmpUniCTT
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTT_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
		Else
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTT_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTT_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
		EndIf
	EndIf

	If lCmpFilCTT
		If lFWModAc .AND. lGestCorp
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTT_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
		Else
			cStrBlCT1 += " + CTT_FILIAL "
			cStrBlCT1 += " + FN5_FILIAL "
			cStrBlFN5 += " + CTT_FILIAL "
			cStrBlFN5 += " + FN5_FILIAL "
		EndIf
	Else
		If lFWModAc .AND. lGestCorp
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTT_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTT_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
		Else
			cStrBlCT1 += " + CTT_FILIAL "
			cStrBlCT1 += " + FN5_FILIAL "
			cStrBlFN5 += " + CTT_FILIAL "
			cStrBlFN5 += " + FN5_FILIAL "
		EndIf
	EndIf

	cStrBlCT1 += " + CTT_CUSTO "
	cStrBlFN5 += " + ORIG_CCUSTO "

	cCpoQraCT1	:= " CTT_CUSTO "
	cCpoQraFN5	:= " ORIG_CCUSTO "

	cStrBlCT1 += " + FN5_CBAORI + FN5_ITEORI "
	cStrBlFN5 += " + FN5_CBAORI + FN5_ITEORI "

	cStrBlCT1 := "AllTrim(" + cStrBlCT1 + ")"
	cStrBlFN5 := "AllTrim(" + cStrBlFN5 + ")"
ElseIf cEntQuebra == 4
	If lFWModAc .AND. lGestCorp
		If lCmpEmpCTD
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTD_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
		Else
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTD_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTD_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
		EndIf

		If lCmpUniCTD
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTD_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
		Else
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTD_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTD_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
		EndIf
	EndIf

	If lCmpFilCTD
		If lFWModAc .AND. lGestCorp
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTD_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
		Else
			cStrBlCT1 += " + CTD_FILIAL "
			cStrBlCT1 += " + FN5_FILIAL "
			cStrBlFN5 += " + CTD_FILIAL "
			cStrBlFN5 += " + FN5_FILIAL "
		EndIf
	Else
		If lFWModAc .AND. lGestCorp
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTD_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTD_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
		Else
			cStrBlCT1 += " + CTD_FILIAL "
			cStrBlCT1 += " + FN5_FILIAL "
			cStrBlFN5 += " + CTD_FILIAL "
			cStrBlFN5 += " + FN5_FILIAL "
		EndIf
	EndIf
	cStrBlCT1 += " + CTD_ITEM "
	cStrBlFN5 += " + ORIG_ITEMCN "

	cCpoQraCT1	:= " CTD_ITEM "
	cCpoQraFN5	:= " ORIG_ITEMCN "

	cStrBlCT1 += " + FN5_CBAORI + FN5_ITEORI "
	cStrBlFN5 += " + FN5_CBAORI + FN5_ITEORI "

	cStrBlCT1 := "AllTrim(" + cStrBlCT1 + ")"
	cStrBlFN5 := "AllTrim(" + cStrBlFN5 + ")"
ElseIf cEntQuebra == 5
	If lFWModAc .AND. lGestCorp
		If lCmpEmpCTH
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTH_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
		Else
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTH_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTH_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL,1," + CVALTOCHAR(nTamEmp) + " ) "
		EndIf

		If lCmpUniCTH
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTH_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
		Else
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTH_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTH_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+1) + "," + CVALTOCHAR(nTamUnit) + " ) "
		EndIf
	EndIf

	If lCmpFilCTH
		If lFWModAc .AND. lGestCorp
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTH_FILIAL," + CVALTOCHAR(nTamUnit) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamUnit) + "," + CVALTOCHAR(nTamFil) + " ) "
		Else
			cStrBlCT1 += " + CTH_FILIAL "
			cStrBlCT1 += " + FN5_FILIAL "
			cStrBlFN5 += " + CTH_FILIAL "
			cStrBlFN5 += " + FN5_FILIAL "
		EndIf
	Else
		If lFWModAc .AND. lGestCorp
			cStrBlCT1 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTH_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlCT1 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "

			cStrBlFN5 += If(!EMPTY(cStrBlCT1),"+"," ") + " SubStr(CTH_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
			cStrBlFN5 += If(!EMPTY(cStrBlFN5),"+"," ") + " SubStr(FN5_FILIAL," + CVALTOCHAR(nTamEmp+nTamUnit+1) + "," + CVALTOCHAR(nTamFil) + " ) "
		Else
			cStrBlCT1 += " + CTH_FILIAL "
			cStrBlCT1 += " + FN5_FILIAL "
			cStrBlFN5 += " + CTH_FILIAL "
			cStrBlFN5 += " + FN5_FILIAL "
		EndIf
	EndIf

	cStrBlCT1 += " + CTH_CLVL "
	cStrBlFN5 += " + ORIG_CLVL "

	cCpoQraCT1	:= " CTH_CLVL "
	cCpoQraFN5	:= " ORIG_CLVL "

	cStrBlCT1 += " + FN5_CBAORI + FN5_ITEORI "
	cStrBlFN5 += " + FN5_CBAORI + FN5_ITEORI "

	cStrBlCT1 := "AllTrim(" + cStrBlCT1 + ")"
	cStrBlFN5 := "AllTrim(" + cStrBlFN5 + ")"
EndIf

/*
 * Montagem do relacionamento entre as seções do relatório de custos de empréstimos de acordo com a quebra selecionada.
 */
If cEntQuebra == 0 .OR. cEntQuebra == 1
	/*
	 * Montagem do relacionamento na busca de dados de acordo com a quebra do
	 * relatório de acordo com a entidade contábil selecionada.
	 */
	oBemOrig:SetParentQuery()
	oBemOrig:SetParentFilter({|cParam| &(cStrBlCT1) + (cAlsCust)->FN5_CBAORI == cParam},{|| &(cStrBlFN5) + (cAlsCust)->FN5_CBAORI })
	oBemCust:SetParentQuery()
	oBemCust:SetParentFilter({|cParam| FN5_CBACEM+FN5_CBAORI+FN5_ITEORI == cParam},{|| CUST_CBASE+ORIG_CBASE+ORIG_ITEM})
Else
	/*
	 * Montagem do relacionamento na busca de dados de acordo com a quebra do
	 * relatório de acordo com a entidade contábil selecionada.
	 */
	oBemOrig:SetParentQuery()
	oBemOrig:SetParentFilter({|cParam| FN5_FILIAL + &(cCpoQraCT1) == cParam},{|| ORIG_FILIAL + &(cCpoQraFN5) })
	oBemCust:SetParentQuery()
	oBemCust:SetParentFilter({|cParam| &(cStrBlFN5) == cParam},{|| &(cStrBlCT1)})
EndIf

CtbTmpErase(cTmpFil)
oBemFil:Print()

Return()


//-------------------------------------------------------------------
/*/{Protheus.doc} GetFilDsc
Função para busca da descrição da filial da quebra do relatório

@param cSM0Fil	Código da Filial
@param aSM0Fils	Array com as informações de todas as filiais do sistema
@return cFilDsc	Descrição da Filial encontrada
@author marylly.araujo
@since 21/09/2012
@version MP11
/*/
//-------------------------------------------------------------------
Static Function GetFilDsc(cSM0Fil,aSM0Fils)
Local nFilPos := aScan(aSM0Fils,{|aSM0| aSM0[2] == cSM0Fil})
Local cFilDsc := ""

If nFilPos > 0
	cFilDsc := " - " + aSM0Fils[nFilPos][7]
EndIf

Return (cFilDsc)
