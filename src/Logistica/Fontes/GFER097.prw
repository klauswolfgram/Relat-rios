/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

Static cPicVlr := "@E 999,999,999.99"
 
/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER097
Relatório de Contabilização de Fretes Consolidados.

@author Elynton Fellipe Bazzo
@since 27/12/16
--------------------------------------------------------------------------------------------------/*/
User Function GFER097()

	Local oReport
	
	If AllTrim(SuperGetMv('MV_TPEST',, '1')) == "1" //Se o parâmetro que define o tipo de estorno de provisão estiver setado como 'Estorno Total'.
		Alert( "Relatório disponível apenas para Provisão com Estorno Parcial." )
		Return .F.
	EndIf

	Pergunte( "GFER097",.F. )
	 
	If TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Relatório de Contabilização de Fretes Consolidados.

@author Elynton Fellipe Bazzo
@since 27/12/16
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()

	Local oReport
	Local oSection1,oSection2
	
	oReport:= TReport():New("GFER097", "Contabilização Fretes Consolidados","GFER097", {|oReport| ReportPrint(oReport)}, "Contabilização Fretes Consolidados")
	oReport:HideParamPage()
	
	oSection1 := TRSection():New(oReport,"Contabilização Fretes Consolidados",{"cTabGWA"}, {"Contabilização Fretes Consolidados"})
	oSection1:SetHeaderSection(.T.)
	oSection1:lHeaderVisible := .F.
	TRCell():New(oSection1, "(cTabGWA)->FILIAL", "(cTabGWA)", "Filial"       	  , "@!",8,,)
	TRCell():New(oSection1, "(cTabGWA)->SALABT", "(cTabGWA)", "Saldo em Aberto"   , cPicVlr,32,, ,,,"RIGHT")
	TRCell():New(oSection1, "(cTabGWA)->SALTMS", "(cTabGWA)", "Saldo Inicial"	  , cPicVlr,32,, ,,,"RIGHT")
	TRCell():New(oSection1, "(cTabGWA)->VLMOV" , "(cTabGWA)", "Provisoes do Mes"  , cPicVlr,32,, ,,,"RIGHT")
	TRCell():New(oSection1, "(cTabGWA)->RELMES", "(cTabGWA)", "Realizado do Mes"  , cPicVlr,32,, ,,,"RIGHT")
	TRCell():New(oSection1, "(cTabGWA)->AJSPRV", "(cTabGWA)", "Ajuste de Provisao", cPicVlr,32,, ,,,"RIGHT")
	TRCell():New(oSection1, "(cTabGWA)->ESTMES", "(cTabGWA)", "Estorno do Mes"    , cPicVlr,32,, ,,,"RIGHT")
	TRCell():New(oSection1, "(cTabGWA)->TOTMES", "(cTabGWA)", "Resultado do Mes"  , cPicVlr,32,, ,,,"RIGHT")
	TRCell():New(oSection1, "(cTabGWA)->TOTPRO", "(cTabGWA)", "Saldo de Provisao" , cPicVlr,32,, ,,,"RIGHT")
	                                                                                           
	oSection2 := TRSection():New(oReport,"Totalizadores",{""}, {"Totalizadores"})              
	oSection2:SetHeaderSection(.F.)                                                            
	TRCell():New(oSection2, "pFilial",, "Filial"       	    , "@!",If(FwSizeFilial()<6,6,FwSizeFilial()),, {|| "Total:"},,,,,,) 
	TRCell():New(oSection2, "pSALABT",, "Saldo em Aberto"   , cPicVlr,35,, {|| pSALABT },,,"RIGHT",,,)
	TRCell():New(oSection2, "pSALTMS",, "Saldo Inicial"   	, cPicVlr,32,, {|| pSALTMS },,,"RIGHT",,,)
	TRCell():New(oSection2, "pVLMOV" ,, "Provisões do Mês"  , cPicVlr,32,, {|| pVLMOV  },,,"RIGHT",,,)
	TRCell():New(oSection2, "pRELMES",, "Realizado do Mês"  , cPicVlr,32,, {|| pRELMES },,,"RIGHT",,,)
	TRCell():New(oSection2, "pAJSPRV",, "Ajuste de Provisão", cPicVlr,32,, {|| pAJSPRV },,,"RIGHT",,,)
	TRCell():New(oSection2, "pESTMES",, "Estorno do Mês"    , cPicVlr,32,, {|| pESTMES },,,"RIGHT",,,)
	TRCell():New(oSection2, "pTOTMES",, "Resultado do Mês"  , cPicVlr,32,, {|| pTOTMES },,,"RIGHT",,,)
	TRCell():New(oSection2, "pTOTPRO",, "Saldo de Provisão" , cPicVlr,32,, {|| pTOTPRO },,,"RIGHT",,,)
	
	//Forçado a orientação em Paisagem
	oReport:LDISABLEORIENTATION	:= .T.	
	oReport:oPage:lPorTrait := .F.
	oReport:oPage:lLandscape := .T.
	
Return( oReport )

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportPrint
Relatório de Contabilização de Fretes Consolidados.

@author Elynton Fellipe Bazzo
@since 27/12/16
--------------------------------------------------------------------------------------------------/*/
Static Function ReportPrint( oReport )

	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(2)
	
	Private pSALABT := 0
	Private pSALTMS := 0
	Private pVLMOV  := 0
	Private pRELMES := 0
	Private pAJSPRV := 0
	Private pESTMES := 0
	Private pTOTMES := 0
	Private pTOTPRO := 0
	
	Private cTabGWA
	
	cTabGWA := DefTabGWA()
	
	CarregaDado( oReport, MV_PAR01, MV_PAR02, MV_PAR03  )

	oSection1:Init()
	
	dbSelectArea( cTabGWA )
	( cTabGWA )->( dbGoTop() )
	While (cTabGWA)->( !Eof() ) .And. !oReport:Cancel() 
		oSection1:PrintLine()
		( cTabGWA )->( dbSkip() )
	EndDo
	
	oSection1:Finish()
	
	If pSALABT + pSALTMS + pVLMOV + pRELMES + pAJSPRV + pESTMES + pTOTMES + pTOTPRO > 0
		oSection2:Init()
		oSection2:PrintLine()
		oSection2:Finish()
	EndIf
	
	GFEDelTab( cTabGWA )
	
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaDado
Relatório de Contabilização de Fretes Consolidados.

@author Elynton Fellipe Bazzo
@since 27/12/16
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaDado( oReport, cPeriodo, cFilialIni, cFilialFim )

	Local cQuery  := ""
	Local nCont	  := 0
	Local aGCList := oReport:GetGCList()// Função retorna array com filiais que o usuário tem acesso
	Local cAnoMes := SUBSTR( cPeriodo, 4, 6 ) + SUBSTR( cPeriodo, 1, 2 )
	Local cGXEPeriod := SUBSTR( cPeriodo, 4, 6 ) + '/' + SUBSTR( cPeriodo, 1, 2 )
	Local lConsDSCTB := IIF( SuperGetMv('MV_DSCTB',, '1') == "1", .T., .F. )
	
	// Faz a busca dos dados dos movimentos, movimentos contábeis e cálculo de frete
	cAliasQry := GetNextAlias()
	cQuery := " SELECT GWA_FILIAL FROM " + RetSQLName( "GWA" ) + " GWA " 
	cQuery += " WHERE GWA.GWA_FILIAL >= '" + cFilialIni + "' AND GWA.GWA_FILIAL <= '" + cFilialFim + "' AND "
	cQuery += " GWA_DTMOV LIKE '" + cAnoMes + "%' AND "
	If Empty(aGCList)
		cQuery += " GWA_FILIAL >= '"+cFilialIni+"'"
		cQuery += IIF(!Empty(cFilialFim)," AND GWA_FILIAL <= '"+cFilialFim+"'", "")
	Else
		cFiliais += '('
		For nCont := 1 To Len(aGCList)
			If nCont != 1
				cFiliais += ","
			EndIf
			cFiliais += "'"+aGCList[nCont]+"'" 
	 	Next nCont
		cFiliais += ")"
		cQuery += " GWA_FILIAL IN " + cFiliais 
	EndIf
	cQuery += " AND D_E_L_E_T_ = ' '"
	cQuery += "	GROUP BY GWA_FILIAL "
	cQuery := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasQry, .F., .T.)

	dbSelectArea((cAliasQry))
	(cAliasQry)->( dbGoTop() )

	oReport:SetMeter((cAliasQry)->(LastRec()))

	While !oReport:Cancel() .AND. !(cAliasQry)->( Eof() )
		oReport:IncMeter()
		
    	RecLock( cTabGWA, .T. )
    	
    	//FILIAL --------------------------------------------------------------------------
    	(cTabGWA)->FILIAL := (cAliasQry)->GWA_FILIAL
    	
    	//SALDO EM ABERTO --------------------------------------------------------------------------
    	cSaldoAber := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXE" ) + " GXE ON GWA.GWA_FILIAL = GXE.GXE_FILIAL AND GWA.GWA_CODLOT = GXE.GXE_CODLOT "
		cQuery += " WHERE GWA.GWA_CODEST = '' AND GWA.GWA_TPMOV = '2' AND GXE.GXE_PERIOD < '"+ cGXEPeriod +"' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GXE.GXE_SIT <> '6' AND "		
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXE.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cSaldoAber, .F., .T.)
		
		dbSelectArea( cSaldoAber )
		If !(cSaldoAber)->( Eof() )
			(cTabGWA)->SALABT := (cSaldoAber)->VALOR
		EndIf
		(cSaldoAber)->(dbCloseArea())
		
		//SALDO INIC. TMS --------------------------------------------------------------------------
		cSaldoMes := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXE" ) + " GXE ON GWA.GWA_FILIAL = GXE.GXE_FILIAL AND GWA.GWA_CODLOT = GXE.GXE_CODLOT "
		cQuery += " LEFT JOIN " + RetSQLName( "GXN" ) + " GXN ON GWA.GWA_FILIAL = GXN.GXN_FILIAL AND GWA.GWA_CODLOT = GXN.GXN_CODLOT AND GXN.GXN_CODEST = GWA.GWA_CODEST "
		cQuery += " WHERE (GWA.GWA_CODEST = ' ' OR (GWA.GWA_CODEST <> ' ' AND GXN.GXN_PERIES <> '" + cGXEPeriod + "' AND GXE.GXE_PERIOD < '"+ cGXEPeriod +"' ))"
		cQuery += " AND GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GWA.GWA_TPMOV = '2' AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXE.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXN.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cSaldoMes, .F., .T.)
				
		dbSelectArea( cSaldoMes )
		If !(cSaldoMes)->( Eof() )
			(cTabGWA)->SALTMS := (cSaldoMes)->VALOR
		EndIf
		(cSaldoMes)->(dbCloseArea())
		
		//PROVISÕES DO MÊS --------------------------------------------------------------------------
		cProvMes := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXE" ) + " GXE ON GWA.GWA_FILIAL = GXE.GXE_FILIAL AND GWA.GWA_CODLOT = GXE.GXE_CODLOT "
		cQuery += " WHERE GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%' AND "
		cQuery += " (GWA.GWA_TPDOC = '1' OR GWA.GWA_TPDOC = '4') AND GWA.GWA_TPMOV = '2' AND GXE.GXE_PERIOD = '" + cGXEPeriod + "' AND " 
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXE.D_E_L_E_T_ = ' '"
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cProvMes, .F., .T.)
		
		dbSelectArea( cProvMes )
		If !(cProvMes)->( Eof() )
			(cTabGWA)->VLMOV := (cProvMes)->VALOR
		EndIf
		(cProvMes)->(dbCloseArea())
		
		//REALIZADO DO MÊS --------------------------------------------------------------------------
		cRealMes := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSqlName( "GW3" ) + " GW3 ON GW3.GW3_FILIAL = GWA.GWA_FILIAL AND GW3.GW3_CDESP = GWA.GWA_CDESP AND "
		cQuery += " GW3.GW3_EMISDF = GWA.GWA_CDEMIT AND GW3.GW3_SERDF = GWA.GWA_SERIE AND GW3.GW3_NRDF = GWA.GWA_NRDOC AND "
		cQuery += " GW3.GW3_DTEMIS = GWA.GWA_DTEMIS "
		If lConsDSCTB
			cQuery += " INNER JOIN " + RetSqlName( "GW6" ) + " GW6 ON GW6.GW6_FILIAL = GW3.GW3_FILIAL AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT AND "
			cQuery += " GW6.GW6_SERFAT = GW3.GW3_SERFAT  AND GW6.GW6_NRFAT = GW3.GW3_NRFAT AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA and GW6.GW6_SITFIN = '4' "
		Else
			cQuery += " AND GW3.GW3_SITFIS = '4' "
		EndIf
		cQuery += " WHERE EXISTS(SELECT GWM.GWM_TPDOC FROM " + RetSQLName( "GWM" ) + " GWM "
		cQuery += " WHERE GWA.GWA_FILIAL = GWM.GWM_FILIAL AND GWA.GWA_TPDOC = GWM.GWM_TPDOC AND "
		cQuery += " GWA.GWA_CDESP = GWM.GWM_CDESP AND GWA.GWA_CDEMIT = GWM.GWM_CDTRP AND GWA.GWA_SERIE = GWM.GWM_SERDOC AND "
		cQuery += " GWA.GWA_NRDOC = GWM.GWM_NRDOC AND GWA.GWA_DTEMIS = GWM.GWM_DTEMIS AND GWM.GWM_DTEMDC LIKE '"+ cAnoMes +"%' AND " 
		cQuery += " GWM.D_E_L_E_T_ = ' ' ) AND (GWA.GWA_TPDOC = '2' OR GWA.GWA_TPDOC = '3') AND GWA.GWA_TPMOV = '1' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%' AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GW3.D_E_L_E_T_ = ' ' "
		If lConsDSCTB
			cQuery += " AND GW6.D_E_L_E_T_ = ' ' "
		EndIf
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cRealMes, .F., .T.)
		
		dbSelectArea( cRealMes )
		If !(cRealMes)->( Eof() )
			(cTabGWA)->RELMES := (cRealMes)->VALOR
		EndIf
		(cRealMes)->(dbCloseArea())
 
		//AJUSTE DE PROVISÃO --------------------------------------------------------------------------
		cAjusProv := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXN" ) + " GXN ON GWA.GWA_FILIAL = GXN.GXN_FILIAL AND GWA.GWA_CODLOT = GXN.GXN_CODLOT AND "
		cQuery += " GXN.GXN_CODEST = GWA.GWA_CODEST "
		cQuery += " WHERE GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND EXISTS( SELECT GXD_FILIAL FROM " + RetSQLName( "GXD" ) + " GXD "
		cQuery += " WHERE GXN.GXN_FILIAL = GXD.GXD_FILIAL AND GXN.GXN_CODLOT = GXD.GXD_CODLOT AND GXN.GXN_CODEST = GXD.GXD_CODEST AND " 
		cQuery += " GXD.GXD_MOTIES = '05' AND GXD.D_E_L_E_T_ = ' ') AND GXN.GXN_PERIES = '" + cGXEPeriod + "' AND GXN.GXN_SIT IN('2','4') AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXN.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAjusProv, .F., .T.)
		
		dbSelectArea( cAjusProv )
		If !(cAjusProv)->( Eof() )
			(cTabGWA)->AJSPRV := (cAjusProv)->VALOR
		EndIf
		(cAjusProv)->(dbCloseArea())
		
		//ESTORNO DO MÊS --------------------------------------------------------------------------
		cEstMes := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXN" ) + " GXN ON GWA.GWA_FILIAL = GXN.GXN_FILIAL AND GWA.GWA_CODLOT = GXN.GXN_CODLOT AND "
		cQuery += " GXN.GXN_CODEST = GWA.GWA_CODEST "
		cQuery += " WHERE GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND EXISTS( SELECT GXD_FILIAL FROM " + RetSQLName( "GXD" ) + " GXD "
		cQuery += " WHERE GXN.GXN_FILIAL = GXD.GXD_FILIAL AND GXN.GXN_CODLOT = GXD.GXD_CODLOT AND GXN.GXN_CODEST = GXD.GXD_CODEST AND " 
		cQuery += " GXD.GXD_MOTIES IN ('01','02','03','04') AND GXD.D_E_L_E_T_ = ' ') AND GXN.GXN_PERIES = '" + cGXEPeriod + "' AND GXN.GXN_SIT IN('2','4') AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXN.D_E_L_E_T_ = ' ' "		
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cEstMes, .F., .T.)
		
		dbSelectArea( cEstMes )
		If !(cEstMes)->( Eof() )
			(cTabGWA)->ESTMES := (cEstMes)->VALOR
		EndIf
		(cEstMes)->(dbCloseArea())
		
		//Provisões do Mês + Realizado do Mês - Ajuste de Provisão - Estorno do Mês
		(cTabGWA)->TOTMES := (cTabGWA)->VLMOV + (cTabGWA)->RELMES - (cTabGWA)->AJSPRV - (cTabGWA)->ESTMES
		
		// Saldo Inic. TMS + Provisões do Mês - Ajuste de Provisão - Estorno do Mês
		(cTabGWA)->TOTPRO := (cTabGWA)->SALTMS + (cTabGWA)->VLMOV - (cTabGWA)->AJSPRV - (cTabGWA)->ESTMES
		
		MsUnLock( cTabGWA )
		
		//Totalizadores
		pSALABT += (cTabGWA)->SALABT
		pSALTMS += (cTabGWA)->SALTMS
		pVLMOV  += (cTabGWA)->VLMOV
		pRELMES += (cTabGWA)->RELMES
		pAJSPRV += (cTabGWA)->AJSPRV
		pESTMES += (cTabGWA)->ESTMES
		pTOTMES += (cTabGWA)->TOTMES
		pTOTPRO += (cTabGWA)->TOTPRO
	
    	(cAliasQry)->(dbSkip())
    EndDo
    
    (cAliasQry)->(dbCloseArea())

Return

/*/------------------------------------------------------------
DefTabGWA

Retorna a definição da tabela temporária.
--------------------------------------------------------------/*/
Static Function DefTabGWA()

	Local aTT := {}
	
	aTT   :=  {{"FILIAL", "C", FwSizeFilial(),0},;
			   {"SALABT", "N", 12,2},;
			   {"SALTMS", "N", 12,2},;
			   {"VLMOV" , "N", 12,2},;
			   {"RELMES", "N", 12,2},;
			   {"AJSPRV", "N", 12,2},;
			   {"ESTMES", "N", 12,2},;
			   {"TOTMES", "N", 12,2},;
			   {"TOTPRO", "N", 12,2}}
			   
Return GFECriaTab({ aTT,{"FILIAL"} })
