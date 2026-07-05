/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'Protheus.ch'
#Include 'WMSR401.CH'

//-----------------------------------------------------------
/*/{Protheus.doc} WmsR401
Lista dos mapas de separacao de uma carga

@author  Alex Egydio
@since   29/06/06
/*/
//-----------------------------------------------------------
User Function WmsR401()
Local oReport
	If !SuperGetMV("MV_WMSNEW", .F., .F.)
		Return WMSR400()
	EndIf

	// Interface de impressao
	oReport:= ReportDef()
	oReport:PrintDialog()
Return NIL
//------------------------------------------------------------
//  Definições do relatório
//------------------------------------------------------------
Static Function ReportDef()
Local cAliasNew := 'D12'
Local cTitle    := OemToAnsi(STR0001) // Lista dos mapas de uma carga
Local lNomCar   := DAK->(FieldPos('DAK_NOMCAR'))>0
Local oReport
Local oSection1
	DbSelectArea(cAliasNew)
	DbSetOrder(1)
	cAliasNew := GetNextAlias()
	// Criacao do componente de impressao
	oReport := TReport():New('WMSR401',cTitle,'WMR400',{|oReport| ReportPrint(oReport,cAliasNew)},STR0001) // Lista dos mapas de uma carga
	//--------------------------------------
	// Variaveis utilizadas para parametros
	// mv_par01 - Carga     De  ?
	// mv_par02 - Carga     Ate ?
	//--------------------------------------
	Pergunte(oReport:uParam,.F.)
	// Criacao da secao utilizada pelo relatorio
	oSection1:= TRSection():New(oReport,STR0002,{'D12'},/*aOrdem*/) // Movimentos por endereco
	TRCell():New(oSection1,'D12_CARGA' ,'D12')
	TRCell():New(oSection1,'D12_MAPSEP','D12')
	TRCell():New(oSection1,'LACUNA1'   ,'',STR0003,,3,,{||'( )'}) // Lacuna 1
	If lNomCar
		TRCell():New(oSection1,'DAK_NOMCAR','DAK')
	EndIf
Return(oReport)
//-----------------------------------------------------------
// Impressão do relatório
//-----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasNew)
Local oSection1 := oReport:Section(1)
Local cQuebra   := ''
Local cSemCarga := Space(Len(DCF->DCF_CARGA))
Local cSemMpSep := Space(Len(D12->D12_MAPSEP))
Local lNomCar   := DAK->(FieldPos('DAK_NOMCAR'))>0

	oSection1:Cell('LACUNA1'):HideHeader()

	If lNomCar
		oSection1:Cell('DAK_NOMCAR'):HideHeader()
	EndIf

	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	oSection1:BeginQuery()
	BeginSql Alias cAliasNew
		SELECT D12_CARGA,D12_MAPSEP
		FROM %table:D12% D12
		WHERE D12.D12_FILIAL = %xFilial:D12%
		  AND D12.D12_ORIGEM = 'SC9'
		  AND D12.D12_CARGA  <> %Exp:cSemCarga%
		  AND D12.D12_MAPSEP <> %Exp:cSemMpSep%
		  AND D12.D12_CARGA  BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
		  AND D12.%NotDel%
		GROUP BY D12_CARGA,D12_MAPSEP
		ORDER BY D12_CARGA,D12_MAPSEP
	EndSql
	// Metodo EndQuery ( Classe TRSection )
	// Prepara o relatório para executar o Embedded SQL.
	// ExpA1 : Array com os parametros do tipo Range
	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)

	oReport:SetMeter(D12->(RecCount()))
	DbSelectArea(cAliasNew)
	oSection1:Init()
	While !oReport:Cancel() .And. !(cAliasNew)->(Eof())
		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf
		If cQuebra != (cAliasNew)->(D12_CARGA)
			cQuebra := (cAliasNew)->(D12_CARGA)
			oReport:EndPage()
			oSection1:Cell('D12_CARGA'):Show()
			If lNomCar
				DAK->(DbSetOrder(1))
				If DAK->(MsSeek(xFilial('DAK')+(cAliasNew)->D12_CARGA))
					oSection1:Cell('DAK_NOMCAR'):SetValue(DAK->DAK_NOMCAR)
					oSection1:Cell('DAK_NOMCAR'):Show()
				EndIf
			EndIf
		EndIf
		oSection1:PrintLine()
		oSection1:Cell('D12_CARGA'):Hide()
		If lNomCar
			oSection1:Cell('DAK_NOMCAR'):Hide()
		EndIf

		(cAliasNew)->(dbSkip())
	EndDo
	oSection1:Finish()
Return NIL
