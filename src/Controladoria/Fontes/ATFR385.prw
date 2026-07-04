/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "ATFR385.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} ATFR385
Função do relatório de Processos de Ajuste Valor Positivo/Negativo Societario

@author pauloc
@since 13/06/2014
@version MP11
/*/
//-------------------------------------------------------------------

User Function ATFR385( aParamAuto )

Local lRet      := .T.
Local oReport	:= Nil
Local lTReport	:= FindFunction("TRepInUse") .And. TRepInUse()
Local lDefTop 	:= IIF( FindFunction("IfDefTopCTB"), IfDefTopCTB(), .F.) // verificar se pode executar query (TOPCONN)
Local lSelFil	:= .F.
Local aSM0Fils	:= AdmAbreSM0()
Local nX 		:= 0
Local cVarParam := ""
Local lAuto     := .F.

Private cPerg	:= "AFR385"
Private aSelFil	:= {}   
Private cFilAux := ""

If !lDefTop
	Help("  ",1,"AFR385TOP",, STR0001 ,1,0) //"Função disponível apenas para ambientes TopConnect"
	Return
EndIf

If !lTReport
	Help("  ",1,"AFR385R4",, STR0002,1,0) //"Função disponível apenas para TReport, por favor atualizar ambiente e verificar parametro MV_TREPORT"
	Return
ENdIf

If !AliasInDic("FNY")
	Help("  ",1,"AFR385FNY",,STR0003,1,0)  //'Para utilizar este relatório, é necessário executar o compatibilizador U_UPDATF. Por favor, atualize o ambiente'
	Return
EndIf

If !AliasInDic("FNZ")
	Help("  ",1,"AFR385FNZ",,STR0003,1,0)  //'Para utilizar este relatório, é necessário executar o compatibilizador U_UPDATF. Por favor, atualize o ambiente'
	Return
EndIf

dbSelectArea("FNY")
dbSelectArea("FNZ")

If aParamAuto != NIL  //chamado por outra rotina

	If ValType(aParamAuto) == "A"
		For nX := 1 to Len(aParamAuto)
			cVarParam := Alltrim(Upper(aParamAuto[nX][1]))
			If "MV_PAR" $ cVarParam
				&(cVarParam) := aParamAuto[nX][2]
			EndIf
		Next nX
		lAuto := .T.
	EndIf

Else

	lRet		:= Pergunte( cPerg , .T. )

EndIf

lSelFil		:= ( MV_PAR08 == 1 )

If lRet

	If lSelFil .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Return
		EndIf
	Else
		aSelFil := { cFilAnt }	
	EndIf
	
	oReport:= ReportDef(aSM0Fils, lAuto)
	oReport:PrintDialog()
	
EndIf

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} ATFR385
relatório de Processos de Ajuste Valor Positivo/Negativo Societario
Função de definição do layout e formato do relatório

@param aSM0Fils	Array com as informações de todas as filiais do sistema
@return oReport	Objeto criado com o formato do relatório

@author pauloc
@since 13/06/2014
@version MP11
/*/
//-------------------------------------------------------------------

Static Function ReportDef(aSM0Fils, lAuto)

Local oReport		:= nil
Local cDesc			:= STR0004 //"RELATORIO PROCESSOS AJUSTE VALOR POSITIVO/NEGATIVO SOCIETARIO"
Local cTitulo		:= STR0004 //"RELATORIO PROCESSOS AJUSTE VALOR POSITIVO/NEGATIVO SOCIETARIO"
Local lTotProc		:= (MV_PAR06 == 1)
Local lTotFil		:= (MV_PAR07 == 1)
Local lSelFil		:= (MV_PAR08 == 1)
Local oCabFNY
Local oDetFNZ
Local oBrkProc
Local oBrkFil
Local oFuncProc
Local oFuncFil
/*
 * Chamada do pergunte com os parâmetros para definir o comportamento e filtros
 * do relatório
 */
If !lAuto
	Pergunte(cPerg,.F.)
EndIf

/*
 * Definição padrão do relatório TReport
 */
DEFINE REPORT oReport NAME "ATFR385" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport,cPerg,aSM0Fils)} DESCRIPTION cDesc TOTAL IN COLUMN

/*
 * Desabilita o botão de parâmetros de customizações do relatório TReport
 */
oReport:ParamReadOnly()

/*
 * Seção dos dados principais do relatório
 */
DEFINE SECTION oCabFNY OF oReport TITLE STR0005 TABLES "FNY"   //"PROCESSOS DE AJUSTES "

TRCell():New( oCabFNY, "FNY_FILIAL"	, "FNY", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNY->FNY_FILIAL 	})
TRCell():New( oCabFNY, "FNY_PROCID"	, "FNY", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNY->FNY_PROCID 	})
TRCell():New( oCabFNY, "FNY_DESC"	, "FNY", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNY->FNY_DESC 	})
TRCell():New( oCabFNY, "FNY_DTEMIS"	, "FNY", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNY->FNY_DTEMIS 	})
TRCell():New( oCabFNY, "FNY_DTAJST"	, "FNY", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNY->FNY_DTAJST 	})
TRCell():New( oCabFNY, "FNY_STATUS"	, "FNY", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNY->FNY_STATUS 	})
oCabFNY:SetHeaderPage(.T.)

/*
 * Seção dos dados dos bens que sofrerao ajuste
 */

DEFINE SECTION oDetFNZ OF oCabFNY TITLE STR0006 TABLES "FNZ"   //STR0006
TRCell():New( oDetFNZ, "FNZ_ITEM"	, "FNZ", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNZ->FNZ_ITEM 	})
TRCell():New( oDetFNZ, "FNZ_BEM"	, "FNZ", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNZ->FNZ_BEM 	})
TRCell():New( oDetFNZ, "FNZ_ITBEM"	, "FNZ", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNZ->FNZ_ITBEM 	})
TRCell():New( oDetFNZ, "FNZ_TIPO"	, "FNZ", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNZ->FNZ_TIPO 	})
TRCell():New( oDetFNZ, "FNZ_TPSALD"	, "FNZ", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNZ->FNZ_TPSALD	})
TRCell():New( oDetFNZ, "FNZ_VLORI1"	, "FNZ", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNZ->FNZ_VLORI1 	})
TRCell():New( oDetFNZ, "FNZ_VLAJS1"	, "FNZ", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNZ->FNZ_VLAJS1 	})
TRCell():New( oDetFNZ, "FNZ_VLTAX1"	, "FNZ", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNZ->FNZ_VLTAX1 	})
TRCell():New( oDetFNZ, "FNZ_VLACM1"	, "FNZ", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,{|| FNZ->FNZ_VLACM1 	})


If lTotProc

	oBreakProc	:= TRBreak():New(oDetFNZ, {|| FNY->FNY_FILIAL+FNY->FNY_PROCID },{|| STR0007 + FNY->FNY_FILIAL+"/"+FNY->FNY_PROCID },/*lTotalInLine*/,/*cNameBrk*/,) //"Filial / Processo: "
	
	/*
	 * Totalizador dos valores de ajuste na quebra por processo
	 */
	oFuncProc	:= TRFunction():New(oDETFNZ:Cell("FNZ_VLAJS1")	,, "SUM",oBreakProc ,STR0008,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.)  //"Total Processo: "

EndIf

If lTotFil

	oBreakFil	:= TRBreak():New(oCabFNY, {|| FNY->FNY_FILIAL },{|| STR0009 + cFilAux },/*lTotalInLine*/,/*cNameBrk*/,) //"Filial : "
	
	/*
	 * Totalizador dos valores de ajuste na quebra por processo
	 */
	oFuncFil	:= TRFunction():New(oDETFNZ:Cell("FNZ_VLAJS1")	,, "SUM",oBreakFil ,STR0010,PesqPict("SN3","N3_VORIG1"), ,.F.,.F.,.F.,oCabFNY)  //"Total Filial: "


EndIf

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Função para busca das informações que serão impressas no relatório

@param oReport	Objeto para manipulação das seções, atributos e dados do relatório.
@param cPerg		Identificação do Grupo de Perguntas do relatório
@param cAlsCust	Nome de Identificação do RecordSet das informaões do relatório.
@param aSM0Fils	Array com as informações de todas as filiais do sistema.
@return void
@author pauloc
@since 16/06/2014
@version MP11
/*/
//-------------------------------------------------------------------

Static Function PrintReport(oReport,cPerg,aSM0Fils)

Local oCabFNY		:= oReport:Section(1)
Local oDetFNZ		:= oCabFNY:Section(1)

Local lSelFil		:= (MV_PAR08 == 1)
Local cFilOld 		:= cFilAnt

Local nX

For nX := 1 TO Len(aSelFil)
	cFilAnt := aSelFil[nX]

	AFR385Print(oReport, cPerg, aSM0Fils, oCabFNY, oDetFNZ, lSelFil)
	
Next

cFilAnt := cFilOld

Return

Static Function AFR385Print(oReport, cPerg, aSM0Fils, oCabFNY, oDetFNZ, lSelFil)

dbSelectArea("FNY")
dbSetOrder(1)

dbSeek( xFilial("FNY") + MV_PAR01 , .T. )

oCabFNY:Init()

While FNY->( !Eof() .And. FNY_FILIAL+FNY_PROCID >= xFilial("FNY") + MV_PAR01 .And. FNY_FILIAL+FNY_PROCID <= xFilial("FNY") + MV_PAR02 )
	
	cFilAux := FNY->FNY_FILIAL
	
	If FNY->FNY_DTEMIS < MV_PAR03 .OR. FNY->FNY_DTEMIS > MV_PAR04
		FNY->( dbSkip() )
		Loop
	EndIf
	If ( MV_PAR05 == 2 .AND. FNY_STATUS == "2" ) .OR. ( MV_PAR05 == 3 .AND. FNY_STATUS == "1" )
		FNY->( dbSkip() )
		Loop
	EndIf
  
	oCabFNY:PrintLine()
	
	dbSelectArea("FNZ")
	dbSetOrder(1)
	
	dbSeek( xFilial("FNZ") + FNY->FNY_PROCID )

	oDetFNZ:Init()
	While FNZ->( !Eof() .And. FNZ_FILIAL+FNZ_PROCID == xFilial("FNZ") + FNY->FNY_PROCID )
	
		oDetFNZ:PrintLine()
		
		FNZ->( dbSkip() )
		
	EndDo
	oDetFNZ:Finish()
			
	FNY->( dbSkip() )
EndDo

oCabFNY:Finish()

Return()
