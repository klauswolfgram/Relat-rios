/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'Protheus.ch'
#Include 'WMSR401.CH' 

//-----------------------------------------------------------
/*/{Protheus.doc} WMSR400
Lista dos mapas de separacao de uma carga

@author  Alex Egydio
@since   29/06/06
/*/
//-----------------------------------------------------------
User Function WmsR400()
Local oReport
	If SuperGetMv("MV_WMSNEW",.F.,.F.)
		Return WMSR401()
	EndIf	
	// Interface de impressao
	oReport:= ReportDef()
	oReport:PrintDialog()
Return NIL
//------------------------------------------------------------
//  Definições do relatório
//------------------------------------------------------------
Static Function ReportDef()
Local cAliasNew := 'SDB'
Local cTitle    := OemToAnsi(STR0001) // Lista dos mapas de uma carga
Local oReport 
Local oSection1
DbSelectArea(cAliasNew)
DbSetOrder(1)
	cAliasNew := GetNextAlias()
	// Criacao do componente de impressao
oReport := TReport():New('WMSR400',cTitle,'WMR400',{|oReport| ReportPrint(oReport,cAliasNew)},'Lista dos mapas de uma carga')
	//------------------------------------
	// Variaveis utilizadas para parametros
	// mv_par01 - Carga     De  ?
	// mv_par02 - Carga     Ate ?
	//------------------------------------
Pergunte(oReport:uParam,.F.)
	// Criacao da secao utilizada pelo relatorio
oSection1:= TRSection():New(oReport,'Movimentos por endereco',{'SDB'},/*aOrdem*/)
TRCell():New(oSection1,'DB_CARGA' ,'SDB')
TRCell():New(oSection1,'DB_UNITIZ',	'SDB')
TRCell():New(oSection1,'DB_MAPSEP',	'SDB')
TRCell():New(oSection1,'LACUNA1'  ,	'','Lacuna 1',,3,,{||'( )'})
	TRCell():New(oSection1,'DAK_NOMCAR','DAK')

Return(oReport)
//-----------------------------------------------------------
// Impressão do relatório
//-----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasNew)
Local oSection1 := oReport:Section(1)
Local cQuebra   := ''
Local cSemCarga := Space(Len(DCF->DCF_CARGA))
Local cSemMpSep := Space(Len(SDB->DB_MAPSEP))

oSection1:Cell('LACUNA1'):HideHeader()

	oSection1:Cell('DAK_NOMCAR'):HideHeader()
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	oSection1:BeginQuery()
	BeginSql Alias cAliasNew
	SELECT DB_CARGA,DB_UNITIZ,DB_MAPSEP
	FROM %table:SDB% SDB
	WHERE SDB.DB_FILIAL = %xFilial:SDB%
	AND   DB_ESTORNO = ' '
	AND   DB_ATUEST  = 'N'
	AND   DB_TM      > '500'
	AND   DB_CARGA  <> %Exp:cSemCarga%
	AND   DB_MAPSEP <> %Exp:cSemMpSep%
	AND   DB_CARGA  BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
	AND   SDB.%NotDel%
	GROUP BY DB_CARGA,DB_UNITIZ,DB_MAPSEP
	ORDER BY DB_CARGA,DB_UNITIZ,DB_MAPSEP
	EndSql
	// Metodo EndQuery ( Classe TRSection )
	// Prepara o relatório para executar o Embedded SQL.
	// ExpA1 : Array com os parametros do tipo Range
	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)
oReport:SetMeter(SDB->(RecCount()))
DbSelectArea(cAliasNew)
oSection1:Init()
While !oReport:Cancel() .And. !(cAliasNew)->(Eof())
	oReport:IncMeter()
	If	oReport:Cancel()
		Exit
	EndIf
	If	cQuebra != (cAliasNew)->(DB_CARGA+DB_UNITIZ)
		cQuebra := (cAliasNew)->(DB_CARGA+DB_UNITIZ)
		oReport:EndPage()
		oSection1:Cell('DB_CARGA'):Show()
		oSection1:Cell('DB_UNITIZ'):Show()
			DAK->(DbSetOrder(1))
			If	DAK->(MsSeek(xFilial('DAK')+(cAliasNew)->DB_CARGA))
				oSection1:Cell('DAK_NOMCAR'):SetValue(DAK->DAK_NOMCAR)
				oSection1:Cell('DAK_NOMCAR'):Show()
			EndIf
	    EndIf
	oSection1:PrintLine()
	oSection1:Cell('DB_CARGA'):Hide()
	oSection1:Cell('DB_UNITIZ'):Hide()
		oSection1:Cell('DAK_NOMCAR'):Hide()
	(cAliasNew)->(dbSkip())
EndDo
oSection1:Finish()
Return NIL
