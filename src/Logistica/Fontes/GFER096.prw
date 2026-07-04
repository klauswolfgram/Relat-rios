/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

Static cPicVlr := "@E 999,999,999,999,999.99"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER096
Relatório de Contabilização de Fretes.

@author Elynton Fellipe Bazzo
@since 30/12/16
--------------------------------------------------------------------------------------------------/*/
User Function GFER096()

	Local oReport
	
	If AllTrim(SuperGetMv('MV_TPEST',, '1')) == "1" //Se o parâmetro que define o tipo de estorno de provisão estiver setado como 'Estorno Total'.
		Alert( "Relatório disponível apenas para Provisão com Estorno Parcial." )
		Return .F.
	EndIf

	Pergunte( "GFER096",.F. )
		
	If TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
 	
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Relatório de Contabilização de Fretes.

@author Elynton Fellipe Bazzo
@since 27/12/16
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
	Local oReport
	Local oSection1
	
	oReport:= TReport():New("GFER096", "Contabilização Fretes","GFER096", {|oReport| ReportPrint(oReport)}, "Contabilização Fretes")
	oReport:HideParamPage()
	
	oSection1 := TRSection():New(oReport,"Contabilização Fretes",{"cTabGWA"}, {"Contabilização Fretes"})
	oSection1:SetHeaderSection(.T.)
	oSection1:lHeaderVisible := .F.
	
	TRCell():New(oSection1, "(cTabGWA)->FILIAL", "(cTabGWA)", "Filial"											 	, "@!"   ,If(FwSizeFilial()<6,8,FwSizeFilial()+2),, ,,,,,,) 
	TRCell():New(oSection1, "(cTabGWA)->PRVEST", "(cTabGWA)", "Prov.S/Estorno"+CHR(13)+CHR(10)+"Ate Mes Anterior"	, cPicVlr,28,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->PRVSSA", "(cTabGWA)", "Provisao DC"+CHR(13)+CHR(10)+"s/Saida"				, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->PRVNFC", "(cTabGWA)", "Provisao DC"+CHR(13)+CHR(10)+"MA c/Saida"			, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->PRVCSA", "(cTabGWA)", "Provisao DC"+CHR(13)+CHR(10)+"Atu c/Saida"			, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->PRVTOT", "(cTabGWA)", "Provisao"+CHR(13)+CHR(10)+"Total"					, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->REALMS", "(cTabGWA)", "Realizado"+CHR(13)+CHR(10)+"Mes Anterior"			, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->REALMA", "(cTabGWA)", "Realizado"+CHR(13)+CHR(10)+"Mes Atual"				, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->REALTO", "(cTabGWA)", "Realizado"+CHR(13)+CHR(10)+"Total"					, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->ESTCPR", "(cTabGWA)", "Estorno com"+CHR(13)+CHR(10)+"nova Provisao"			, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->ESTREL", "(cTabGWA)", "Estorno Prov"+CHR(13)+CHR(10)+"Realizada"			, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->TOTPRV", "(cTabGWA)", "Provisao"+CHR(13)+CHR(10)+"Estornada"				, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->VLICMS", "(cTabGWA)", "ICMS"												, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->COFINS", "(cTabGWA)", "PIS/COFINS"											, cPicVlr,20,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->FRECTB", "(cTabGWA)", "Frete Contabil"										, cPicVlr,24,, ,,,"RIGHT",,,)
	TRCell():New(oSection1, "(cTabGWA)->TOTFRE", "(cTabGWA)", "Total Frete Contabil"				                , cPicVlr,32,, ,,,"RIGHT",,,)
	
	oSection2 := TRSection():New(oReport,"Totalizadores",{""}, {"Totalizadores"})
	oSection2:SetHeaderSection(.F.)
	TRCell():New(oSection2, "pFilial",,"Filial"											 	, "@!"   ,If(FwSizeFilial()<6,6,FwSizeFilial()),, {|| "Total:"},,,,,,       ) 
	TRCell():New(oSection2, "pPRVEST",,"Prov.S/Estorno"+CHR(13)+CHR(10)+"Ate Mes Anterior"	, cPicVlr,28,, {|| pPRVEST },,,"RIGHT",,,)
	TRCell():New(oSection2, "pPRVSSA",,"Provisao DC"+CHR(13)+CHR(10)+"s/Saida"				, cPicVlr,20,, {|| pPRVSSA },,,"RIGHT",,,)
	TRCell():New(oSection2, "pPRVNFC",,"Provisao DC"+CHR(13)+CHR(10)+"MA c/Saida"			, cPicVlr,20,, {|| pPRVNFC },,,"RIGHT",,,)
	TRCell():New(oSection2, "pPRVCSA",,"Provisao DC"+CHR(13)+CHR(10)+"Atu c/Saida"			, cPicVlr,20,, {|| pPRVCSA },,,"RIGHT",,,)
	TRCell():New(oSection2, "pPRVTOT",,"Provisao"+CHR(13)+CHR(10)+"Total"					, cPicVlr,20,, {|| pPRVTOT },,,"RIGHT",,,)
	TRCell():New(oSection2, "pREALMS",,"Realizado"+CHR(13)+CHR(10)+"Mes Anterior"			, cPicVlr,20,, {|| pREALMS },,,"RIGHT",,,)
	TRCell():New(oSection2, "pREALMA",,"Realizado"+CHR(13)+CHR(10)+"Mes Atual"				, cPicVlr,20,, {|| pREALMA },,,"RIGHT",,,)
	TRCell():New(oSection2, "pREALTO",,"Realizado"+CHR(13)+CHR(10)+"Total"					, cPicVlr,20,, {|| pREALTO },,,"RIGHT",,,)
	TRCell():New(oSection2, "pESTCPR",,"Estorno com"+CHR(13)+CHR(10)+"nova Provisao"		, cPicVlr,20,, {|| pESTCPR },,,"RIGHT",,,)
	TRCell():New(oSection2, "pESTREL",,"Estorno Prov"+CHR(13)+CHR(10)+"Realizada"			, cPicVlr,20,, {|| pESTREL },,,"RIGHT",,,)
	TRCell():New(oSection2, "pTOTPRV",,"Provisao"+CHR(13)+CHR(10)+"Estornada"				, cPicVlr,20,, {|| pTOTPRV },,,"RIGHT",,,)
	TRCell():New(oSection2, "pVLICMS",,"ICMS"												, cPicVlr,20,, {|| pVLICMS },,,"RIGHT",,,)
	TRCell():New(oSection2, "pCOFINS",,"PIS/COFINS"											, cPicVlr,20,, {|| pCOFINS },,,"RIGHT",,,)
	TRCell():New(oSection2, "pFRECTB",,"Frete Contabil"										, cPicVlr,24,, {|| pFRECTB },,,"RIGHT",,,)
	TRCell():New(oSection2, "pTOTFRE",,"Total"+CHR(13)+CHR(10)+"Frete Contabil"				, cPicVlr,32,, {|| pTOTFRE },,,"RIGHT",,,)
	
	//Forçado a orientação em Paisagem
	oReport:LDISABLEORIENTATION	:= .T.	
	oReport:oPage:lPorTrait := .F.
	oReport:oPage:lLandscape := .T.
	
Return( oReport )

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportPrint
Relatório de Contabilização de Fretes.

@author Elynton Fellipe Bazzo
@since 27/12/16
--------------------------------------------------------------------------------------------------/*/
Static Function ReportPrint( oReport )

	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(2)
	
	Private cTabGWA
	Private pPRVEST := 0
	Private pPRVSSA := 0
	Private pPRVNFC := 0
	Private pPRVCSA := 0
	Private pPRVTOT := 0
	Private pREALMS := 0
	Private pREALMA := 0
	Private pREALTO := 0
	Private pESTCPR := 0
	Private pESTREL := 0
	Private pTOTPRV := 0
	Private pVLICMS := 0
	Private pCOFINS := 0
	Private pFRECTB := 0
	Private pTOTFRE := 0
	
	cTabGWA := DefTabGWA()
	
	CarregaDado( oReport, MV_PAR01, MV_PAR02, MV_PAR03 )

	oSection1:Init()
	
	dbSelectArea( cTabGWA )
	( cTabGWA )->( dbGoTop() )
	While (cTabGWA)->( !Eof() ) .And. !oReport:Cancel() 
		oSection1:PrintLine()
		( cTabGWA )->( dbSkip() )
	EndDo
	
	oSection1:Finish()
	
	If pPRVEST + pPRVSSA +	pPRVNFC +	pPRVCSA +	pPRVTOT +	pREALMS +	pREALMA +	pREALTO +	pESTCPR +	pESTREL +	pTOTPRV +	pVLICMS +;
	pCOFINS +	pFRECTB +	pTOTFRE  > 0
		oSection2:Init()
		oSection2:PrintLine()
		oSection2:Finish()
	EndIf
	GFEDelTab( cTabGWA )
	
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaDado
Relatório de Contabilização de Fretes.

@author Elynton Fellipe Bazzo
@since 27/12/16
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaDado( oReport, cPeriodo, cFilialIni, cFilialFim )

	Local cQuery  := ""
	Local aGCList := oReport:GetGCList()// Função retorna array com filiais que o usuário tem acesso
	Local cAnoMes := SUBSTR( cPeriodo, 4, 6 ) + SUBSTR( cPeriodo, 1, 2 )
	Local cGXEPeriod := SUBSTR( cPeriodo, 4, 6 ) + '/' + SUBSTR( cPeriodo, 1, 2 )
	Local dPeriod := STOD( cAnoMes + "01")
	Local nCont := 0
	Local cProvCon := SuperGetMV("MV_PROVCON",, "1")
	Local lConsDSCTB := IIF( SuperGetMv('MV_DSCTB',, '1') == "1", .T., .F. )
	
	// Faz a busca dos dados dos movimentos, movimentos contábeis e cálculo de frete
	cAliasQry := GetNextAlias()
	cQuery := " SELECT GWA_FILIAL FROM " + RetSQLName( "GWA" ) + " GWA "
	cQuery += " WHERE GWA_FILIAL >= '" + cFilialIni + "' AND GWA_FILIAL <= '" + cFilialFim + "' AND "
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
	cQuery += " AND D_E_L_E_T_ = ' ' "
	cQuery += "	GROUP BY GWA_FILIAL "
	cQuery := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasQry, .F., .T.)
	
	dbSelectArea((cAliasQry))
	(cAliasQry)->( dbGoTop() )
	oReport:SetMeter((cAliasQry)->(LastRec()))

	While !oReport:Cancel() .AND. !(cAliasQry)->( Eof() )
		oReport:IncMeter()
		
    	RecLock( cTabGWA, .T. )
    	
    	(cTabGWA)->FILIAL := (cAliasQry)->GWA_FILIAL
    	
    	//Prov.S/Estorno Até Mês Anterior ----------------------------------------------------------
    	cEstMesAnt := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXE" ) + " GXE ON GWA.GWA_FILIAL = GXE.GXE_FILIAL AND GWA.GWA_CODLOT = GXE.GXE_CODLOT "
		cQuery += " WHERE GWA.GWA_CODEST = '' AND GWA.GWA_TPMOV = '2' AND GXE.GXE_PERIOD < '"+ cGXEPeriod +"' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GXE.GXE_SIT <> '6' AND "		
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXE.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cEstMesAnt, .F., .T.)
		
		dbSelectArea( cEstMesAnt )
		If !(cEstMesAnt)->( Eof() )
			(cTabGWA)->PRVEST := (cEstMesAnt)->VALOR
		EndIf
		(cEstMesAnt)->(dbCloseArea())
		
		//Provisao NF s/ Saída ----------------------------------------------------------
    	cPrvSSaida := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GWH" ) + " GWH ON GWH.GWH_FILIAL = GWA.GWA_FILIAL AND GWH.GWH_NRCALC = GWA.GWA_NRDOC "
		cQuery += " AND NOT EXISTS(SELECT GWH2.GWH_NRCALC FROM " + RetSQLName( "GWH" ) + " GWH2 "
		cQuery += " INNER JOIN " + RetSQLName( "GWH" ) + " ON GWH2.GWH_FILIAL = GWH.GWH_FILIAL AND GWH2.GWH_NRDC = GWH.GWH_NRDC AND "
		cQuery += " GWH2.GWH_CDTPDC = GWH.GWH_CDTPDC AND GWH2.GWH_EMISDC = GWH.GWH_EMISDC AND GWH2.GWH_SERDC = GWH.GWH_SERDC AND "
		cQuery += " GWH2.GWH_NRCALC <> GWA.GWA_NRDOC) "
		cQuery += " WHERE GWA.GWA_CODLOT != ' ' AND GWA.GWA_TPDOC = '4' AND GWA.GWA_TPMOV = '2' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND "
		cQuery += " GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%' AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GWH.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cPrvSSaida, .F., .T.)
		
		dbSelectArea( cPrvSSaida )
		If !(cPrvSSaida)->( Eof() )
			(cTabGWA)->PRVSSA := (cPrvSSaida)->VALOR
		EndIf
		(cPrvSSaida)->(dbCloseArea())
		
		
		//Provisao NF s/ Saída ---------------------------------------------------------- ICMS
    	cPrvSSICMS := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GWH" ) + " GWH ON GWH.GWH_FILIAL = GWA.GWA_FILIAL AND GWH.GWH_NRCALC = GWA.GWA_NRDOC "
		cQuery += " AND NOT EXISTS(SELECT GWH2.GWH_NRCALC FROM " + RetSQLName( "GWH" ) + " GWH2 "
		cQuery += " INNER JOIN " + RetSQLName( "GWH" ) + " ON GWH2.GWH_FILIAL = GWH.GWH_FILIAL AND GWH2.GWH_NRDC = GWH.GWH_NRDC AND "
		cQuery += " GWH2.GWH_CDTPDC = GWH.GWH_CDTPDC AND GWH2.GWH_EMISDC = GWH.GWH_EMISDC AND GWH2.GWH_SERDC = GWH.GWH_SERDC AND "
		cQuery += " GWH2.GWH_NRCALC <> GWA.GWA_NRDOC) "
		cQuery += " WHERE GWA.GWA_CODLOT != ' ' AND GWA.GWA_TPDOC = '4' AND GWA.GWA_TPMOV = '2' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND "
		cQuery += " GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%' AND GWA.GWA_CDTRAN = '301' AND"
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GWH.D_E_L_E_T_ = ' '"
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cPrvSSICMS, .F., .T.)
		
		dbSelectArea( cPrvSSICMS )
		If !(cPrvSSICMS)->( Eof() )
			(cTabGWA)->VLICMS += (cPrvSSICMS)->VALOR
		EndIf
		(cPrvSSICMS)->(dbCloseArea())
		
		//Provisao NF s/ Saída ---------------------------------------------------------- COFINS
    	cPSSCofins := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GWH" ) + " GWH ON GWH.GWH_FILIAL = GWA.GWA_FILIAL AND GWH.GWH_NRCALC = GWA.GWA_NRDOC "
		cQuery += " AND NOT EXISTS(SELECT GWH2.GWH_NRCALC FROM " + RetSQLName( "GWH" ) + " GWH2 "
		cQuery += " INNER JOIN " + RetSQLName( "GWH" ) + " ON GWH2.GWH_FILIAL = GWH.GWH_FILIAL AND GWH2.GWH_NRDC = GWH.GWH_NRDC AND "
		cQuery += " GWH2.GWH_CDTPDC = GWH.GWH_CDTPDC AND GWH2.GWH_EMISDC = GWH.GWH_EMISDC AND GWH2.GWH_SERDC = GWH.GWH_SERDC AND "
		cQuery += " GWH2.GWH_NRCALC <> GWA.GWA_NRDOC) "
		cQuery += " WHERE GWA.GWA_CODLOT != ' ' AND GWA.GWA_TPDOC = '4' AND GWA.GWA_TPMOV = '2' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND "
		cQuery += " GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%' AND GWA.GWA_CDTRAN IN ('302','303') AND"
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GWH.D_E_L_E_T_ = ' '"
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cPSSCofins, .F., .T.)
		
		dbSelectArea( cPSSCofins )
		If !(cPSSCofins)->( Eof() )
			(cTabGWA)->COFINS += (cPSSCofins)->VALOR
		EndIf
		(cPSSCofins)->(dbCloseArea())
	
		
		//Provisao NF MA c/ Saida ----------------------------------------------------------
		cPrvNFSaid := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM(GWM.GWM_VLFRET) AS VALOR, GWF.GWF_CRDICM, SUM(GWM.GWM_VLICMS) GWM_VLICMS, GWF.GWF_CRDPC, "
		cQuery += " SUM(GWM.GWM_VLPIS) GWM_VLPIS, SUM(GWM.GWM_VLCOFI) GWM_VLCOFI "
		cQuery += " FROM " + RetSQLName( "GWM" ) + " GWM "
		cQuery += " INNER JOIN " + RetSQLName( "GWF" ) + " GWF ON GWF.GWF_FILIAL = GWM.GWM_FILIAL AND 
		cQuery += " GWF.GWF_NRCALC = GWM.GWM_NRDOC AND GWM.GWM_TPDOC = '1' AND  GWF.D_E_L_E_T_ = ' ' "
		cQuery += " WHERE EXISTS( SELECT GWA.GWA_NRDOC FROM " + RetSQLName( "GWA" ) + " GWA WHERE GWA.GWA_FILIAL = GWM.GWM_FILIAL AND "
		cQuery += " GWA.GWA_NRDOC = GWM.GWM_NRDOC AND GWA.GWA_CODLOT != ' ' AND GWA.GWA_TPDOC = '1' AND GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%'  AND  "
		cQuery += " GWA.GWA_TPMOV = '2' AND D_E_L_E_T_ = ' ' ) AND "
		cQuery += " GWM.GWM_TPDOC = '1' AND GWM.GWM_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GWM.D_E_L_E_T_ = ' ' AND "
		cQuery += " GWM.GWM_DTEMDC < '"+ DTOS(dPeriod) +"' "
		cQuery += " GROUP BY GWF.GWF_CRDICM, GWF.GWF_CRDPC "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cPrvNFSaid, .F., .T.)
		
		dbSelectArea( cPrvNFSaid )
		While !(cPrvNFSaid)->( Eof() )
			
			If cProvCon == "3"
				If (cPrvNFSaid)->GWF_CRDICM == '1'
					(cTabGWA)->PRVNFC += (cPrvNFSaid)->VALOR - (cPrvNFSaid)->GWM_VLICMS
				EndIf
								        	
				If (cPrvNFSaid)->GWF_CRDPC == '1'
					(cTabGWA)->PRVNFC += (cPrvNFSaid)->VALOR - ((cPrvNFSaid)->GWM_VLPIS + (cPrvNFSaid)->GWM_VLCOFI)
				EndIf
			Else
				(cTabGWA)->PRVNFC += (cPrvNFSaid)->VALOR
			EndIf
			
			(cTabGWA)->VLICMS += (cPrvNFSaid)->GWM_VLICMS
			(cTabGWA)->COFINS += (cPrvNFSaid)->GWM_VLPIS + (cPrvNFSaid)->GWM_VLCOFI 
			
			(cPrvNFSaid)->( dbSkip() )
		EndDo
		(cPrvNFSaid)->(dbCloseArea())
		
		
		//Provisao NF Atu c/ Saida ----------------------------------------------------------
		cPrvNFCSd := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM(GWM.GWM_VLFRET) AS VALOR, GWF.GWF_CRDICM, SUM(GWM.GWM_VLICMS) GWM_VLICMS, GWF.GWF_CRDPC, "
		cQuery += " SUM(GWM.GWM_VLPIS) GWM_VLPIS, SUM(GWM.GWM_VLCOFI) GWM_VLCOFI "
		cQuery += " FROM " + RetSQLName( "GWM" ) + " GWM "
		cQuery += " INNER JOIN " + RetSQLName( "GWF" ) + " GWF ON GWF.GWF_FILIAL = GWM.GWM_FILIAL AND 
		cQuery += " GWF.GWF_NRCALC = GWM.GWM_NRDOC AND GWM.GWM_TPDOC = '1' AND  GWF.D_E_L_E_T_ = ' ' "
		cQuery += " WHERE EXISTS( SELECT GWA.GWA_NRDOC FROM " + RetSQLName( "GWA" ) + " GWA WHERE GWA.GWA_FILIAL = GWM.GWM_FILIAL AND "
		cQuery += " GWA.GWA_NRDOC = GWM.GWM_NRDOC AND GWA.GWA_CODLOT != ' ' AND GWA.GWA_TPDOC = '1' AND GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%'  AND  "
		cQuery += " GWA.GWA_TPMOV = '2' AND D_E_L_E_T_ = ' ' ) AND "
		cQuery += " GWM.GWM_TPDOC = '1' AND GWM.GWM_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GWM.D_E_L_E_T_ = ' ' AND "
		cQuery += " GWM.GWM_DTEMDC LIKE '"+ cAnoMes +"%' "
		cQuery += " GROUP BY GWF.GWF_CRDICM, GWF.GWF_CRDPC "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cPrvNFCSd, .F., .T.)
		
		dbSelectArea( cPrvNFCSd )
		While !(cPrvNFCSd)->( Eof() )
			
			If cProvCon == "3"
				If (cPrvNFCSd)->GWF_CRDICM == '1'
					(cTabGWA)->PRVCSA += (cPrvNFCSd)->VALOR - (cPrvNFCSd)->GWM_VLICMS
				EndIf
								        	
				If (cPrvNFCSd)->GWF_CRDPC == '1'
					(cTabGWA)->PRVCSA += (cPrvNFCSd)->VALOR - ((cPrvNFCSd)->GWM_VLPIS + (cPrvNFCSd)->GWM_VLCOFI)
				EndIf
			Else
				(cTabGWA)->PRVCSA += (cPrvNFCSd)->VALOR
			EndIF
			
			(cTabGWA)->VLICMS += (cPrvNFCSd)->GWM_VLICMS
			(cTabGWA)->COFINS += (cPrvNFCSd)->GWM_VLPIS + (cPrvNFCSd)->GWM_VLCOFI
			
			(cPrvNFCSd)->( dbSkip() )
			
		EndDo
		
		(cPrvNFCSd)->(dbCloseArea())
		
		//Soma das colunas de provisão ----------------------------------------------------------
		(cTabGWA)->PRVTOT := (cTabGWA)->PRVCSA + (cTabGWA)->PRVNFC + (cTabGWA)->PRVSSA
		
		//Realizado Mês Anterior ----------------------------------------------------------
		cRealMAnt := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSqlName( "GW3" ) + " GW3 ON GW3.GW3_FILIAL = GWA.GWA_FILIAL AND GW3.GW3_CDESP = GWA.GWA_CDESP AND "
		cQuery += " GW3.GW3_EMISDF = GWA.GWA_CDEMIT AND GW3.GW3_SERDF = GWA.GWA_SERIE AND GW3.GW3_NRDF = GWA.GWA_NRDOC AND "
		cQuery += " GW3.GW3_DTEMIS = GWA.GWA_DTEMIS "
		If lConsDSCTB
			cQuery += " INNER JOIN " + RetSqlName( "GW6" ) + " GW6 ON GW6.GW6_FILIAL = GW3.GW3_FILFAT AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT AND " 
			cQuery += " GW6.GW6_SERFAT = GW3.GW3_SERFAT  AND GW6.GW6_NRFAT = GW3.GW3_NRFAT AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA and GW6.GW6_SITFIN = '4' "
		Else
			cQuery += " AND GW3.GW3_SITFIS = '4' "
		EndIf
		cQuery += " WHERE EXISTS(SELECT GWM.GWM_TPDOC FROM " + RetSQLName( "GWM" ) + " GWM "
		cQuery += " WHERE GWA.GWA_FILIAL = GWM.GWM_FILIAL AND GWA.GWA_TPDOC = GWM.GWM_TPDOC AND "
		cQuery += " GWA.GWA_CDESP = GWM.GWM_CDESP AND GWA.GWA_CDEMIT = GWM.GWM_CDTRP AND GWA.GWA_SERIE = GWM.GWM_SERDOC AND "
		cQuery += " GWA.GWA_NRDOC = GWM.GWM_NRDOC AND GWA.GWA_DTEMIS = GWM.GWM_DTEMIS AND GWM.GWM_DTEMDC < '"+ cAnoMes +"%' AND " 
		cQuery += " GWM.D_E_L_E_T_ = ' ' ) AND (GWA.GWA_TPDOC = '2' OR GWA.GWA_TPDOC = '3') AND GWA.GWA_TPMOV = '1' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%' AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GW3.D_E_L_E_T_ = ' ' "
		If lConsDSCTB
			cQuery += " AND GW6.D_E_L_E_T_ = ' ' "
		EndIf
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cRealMAnt, .F., .T.)
				
		dbSelectArea( cRealMAnt )
		If !(cRealMAnt)->( Eof() )
			(cTabGWA)->REALMS := (cRealMAnt)->VALOR
		EndIf
		(cRealMAnt)->(dbCloseArea())
		
		//Realizado Mês Anterior ----------------------------------------------------------ICMS
		cRlAntICMS := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSqlName( "GW3" ) + " GW3 ON GW3.GW3_FILIAL = GWA.GWA_FILIAL AND GW3.GW3_CDESP = GWA.GWA_CDESP AND "
		cQuery += " GW3.GW3_EMISDF = GWA.GWA_CDEMIT AND GW3.GW3_SERDF = GWA.GWA_SERIE AND GW3.GW3_NRDF = GWA.GWA_NRDOC AND "
		cQuery += " GW3.GW3_DTEMIS = GWA.GWA_DTEMIS "
		If lConsDSCTB
			cQuery += " INNER JOIN " + RetSqlName( "GW6" ) + " GW6 ON GW6.GW6_FILIAL = GW3.GW3_FILFAT AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT AND " 
			cQuery += " GW6.GW6_SERFAT = GW3.GW3_SERFAT  AND GW6.GW6_NRFAT = GW3.GW3_NRFAT AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA and GW6.GW6_SITFIN = '4' "
		Else
			cQuery += " AND GW3.GW3_SITFIS = '4' "
		EndIf
		cQuery += " WHERE EXISTS(SELECT GWM.GWM_TPDOC FROM " + RetSQLName( "GWM" ) + " GWM "
		cQuery += " WHERE GWA.GWA_FILIAL = GWM.GWM_FILIAL AND GWA.GWA_TPDOC = GWM.GWM_TPDOC AND "
		cQuery += " GWA.GWA_CDESP = GWM.GWM_CDESP AND GWA.GWA_CDEMIT = GWM.GWM_CDTRP AND GWA.GWA_SERIE = GWM.GWM_SERDOC AND "
		cQuery += " GWA.GWA_NRDOC = GWM.GWM_NRDOC AND GWA.GWA_DTEMIS = GWM.GWM_DTEMIS AND GWM.GWM_DTEMDC < '"+ cAnoMes +"%' AND " 
		cQuery += " GWM.D_E_L_E_T_ = ' ' ) AND (GWA.GWA_TPDOC = '2' OR GWA.GWA_TPDOC = '3') AND GWA.GWA_TPMOV = '1' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%' AND GWA.GWA_CDTRAN = '311' AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GW3.D_E_L_E_T_ = ' ' "
		If lConsDSCTB
			cQuery += " AND GW6.D_E_L_E_T_ = ' ' "
		EndIf
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cRlAntICMS, .F., .T.)
		
		dbSelectArea( cRlAntICMS )
		If !(cRlAntICMS)->( Eof() )
			(cTabGWA)->VLICMS += (cRlAntICMS)->VALOR
		EndIf
		(cRlAntICMS)->(dbCloseArea())
		
		//Realizado Mês Anterior ----------------------------------------------------------COFINS
		cRlAntCofins := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSqlName( "GW3" ) + " GW3 ON GW3.GW3_FILIAL = GWA.GWA_FILIAL AND GW3.GW3_CDESP = GWA.GWA_CDESP AND "
		cQuery += " GW3.GW3_EMISDF = GWA.GWA_CDEMIT AND GW3.GW3_SERDF = GWA.GWA_SERIE AND GW3.GW3_NRDF = GWA.GWA_NRDOC AND "
		cQuery += " GW3.GW3_DTEMIS = GWA.GWA_DTEMIS "
		If lConsDSCTB
			cQuery += " INNER JOIN " + RetSqlName( "GW6" ) + " GW6 ON GW6.GW6_FILIAL = GW3.GW3_FILFAT AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT AND " 
			cQuery += " GW6.GW6_SERFAT = GW3.GW3_SERFAT  AND GW6.GW6_NRFAT = GW3.GW3_NRFAT AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA and GW6.GW6_SITFIN = '4' "
		Else
			cQuery += " AND GW3.GW3_SITFIS = '4' "
		EndIf
		cQuery += " WHERE EXISTS(SELECT GWM.GWM_TPDOC FROM " + RetSQLName( "GWM" ) + " GWM "
		cQuery += " WHERE GWA.GWA_FILIAL = GWM.GWM_FILIAL AND GWA.GWA_TPDOC = GWM.GWM_TPDOC AND "
		cQuery += " GWA.GWA_CDESP = GWM.GWM_CDESP AND GWA.GWA_CDEMIT = GWM.GWM_CDTRP AND GWA.GWA_SERIE = GWM.GWM_SERDOC AND "
		cQuery += " GWA.GWA_NRDOC = GWM.GWM_NRDOC AND GWA.GWA_DTEMIS = GWM.GWM_DTEMIS AND GWM.GWM_DTEMDC < '"+ cAnoMes +"%' AND " 
		cQuery += " GWM.D_E_L_E_T_ = ' ' ) AND (GWA.GWA_TPDOC = '2' OR GWA.GWA_TPDOC = '3') AND GWA.GWA_TPMOV = '1' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%' AND GWA.GWA_CDTRAN IN ('312', '313') AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GW3.D_E_L_E_T_ = ' ' "
		If lConsDSCTB
			cQuery += " AND GW6.D_E_L_E_T_ = ' ' "
		EndIf
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cRlAntCofins, .F., .T.)
		
		dbSelectArea( cRlAntCofins )
		If !(cRlAntCofins)->( Eof() )
			(cTabGWA)->COFINS += (cRlAntCofins)->VALOR
		EndIf
		(cRlAntCofins)->(dbCloseArea())
		
		//Realizado Mês Atual ----------------------------------------------------------
		cRealAtual := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSqlName( "GW3" ) + " GW3 ON GW3.GW3_FILIAL = GWA.GWA_FILIAL AND GW3.GW3_CDESP = GWA.GWA_CDESP AND "
		cQuery += " GW3.GW3_EMISDF = GWA.GWA_CDEMIT AND GW3.GW3_SERDF = GWA.GWA_SERIE AND GW3.GW3_NRDF = GWA.GWA_NRDOC AND "
		cQuery += " GW3.GW3_DTEMIS = GWA.GWA_DTEMIS "
		If lConsDSCTB
			cQuery += " INNER JOIN " + RetSqlName( "GW6" ) + " GW6 ON GW6.GW6_FILIAL = GW3.GW3_FILFAT AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT AND " 
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
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cRealAtual, .F., .T.)
		
		dbSelectArea( cRealAtual )
		If !(cRealAtual)->( Eof() )
			(cTabGWA)->REALMA := (cRealAtual)->VALOR
		EndIf
		(cRealAtual)->(dbCloseArea())
		
		//Realizado Mês Atual ----------------------------------------------------------ICMS
		cRealAICMS := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSqlName( "GW3" ) + " GW3 ON GW3.GW3_FILIAL = GWA.GWA_FILIAL AND GW3.GW3_CDESP = GWA.GWA_CDESP AND "
		cQuery += " GW3.GW3_EMISDF = GWA.GWA_CDEMIT AND GW3.GW3_SERDF = GWA.GWA_SERIE AND GW3.GW3_NRDF = GWA.GWA_NRDOC AND "
		cQuery += " GW3.GW3_DTEMIS = GWA.GWA_DTEMIS "
		If lConsDSCTB
			cQuery += " INNER JOIN " + RetSqlName( "GW6" ) + " GW6 ON GW6.GW6_FILIAL = GW3.GW3_FILFAT AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT AND " 
			cQuery += " GW6.GW6_SERFAT = GW3.GW3_SERFAT  AND GW6.GW6_NRFAT = GW3.GW3_NRFAT AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA and GW6.GW6_SITFIN = '4' "
		Else
			cQuery += " AND GW3.GW3_SITFIS = '4' "
		EndIf
		cQuery += " WHERE EXISTS(SELECT GWM.GWM_TPDOC FROM " + RetSQLName( "GWM" ) + " GWM "
		cQuery += " WHERE GWA.GWA_FILIAL = GWM.GWM_FILIAL AND GWA.GWA_TPDOC = GWM.GWM_TPDOC AND "
		cQuery += " GWA.GWA_CDESP = GWM.GWM_CDESP AND GWA.GWA_CDEMIT = GWM.GWM_CDTRP AND GWA.GWA_SERIE = GWM.GWM_SERDOC AND "
		cQuery += " GWA.GWA_NRDOC = GWM.GWM_NRDOC AND GWA.GWA_DTEMIS = GWM.GWM_DTEMIS AND GWM.GWM_DTEMDC LIKE '"+ cAnoMes +"%' AND " 
		cQuery += " GWM.D_E_L_E_T_ = ' ' ) AND (GWA.GWA_TPDOC = '2' OR GWA.GWA_TPDOC = '3') AND GWA.GWA_TPMOV = '1' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%' AND GWA.GWA_CDTRAN = '311' AND"
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GW3.D_E_L_E_T_ = ' ' "
		If lConsDSCTB
			cQuery += " AND GW6.D_E_L_E_T_ = ' ' "
		EndIf
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cRealAICMS, .F., .T.)
		
		dbSelectArea( cRealAICMS )
		If !(cRealAICMS)->( Eof() )
			(cTabGWA)->VLICMS += (cRealAICMS)->VALOR
		EndIf
		(cRealAICMS)->(dbCloseArea())
		
		//Realizado Mês Atual ----------------------------------------------------------COFINS
		cRMACofins := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSqlName( "GW3" ) + " GW3 ON GW3.GW3_FILIAL = GWA.GWA_FILIAL AND GW3.GW3_CDESP = GWA.GWA_CDESP AND "
		cQuery += " GW3.GW3_EMISDF = GWA.GWA_CDEMIT AND GW3.GW3_SERDF = GWA.GWA_SERIE AND GW3.GW3_NRDF = GWA.GWA_NRDOC AND "
		cQuery += " GW3.GW3_DTEMIS = GWA.GWA_DTEMIS "
		If lConsDSCTB
			cQuery += " INNER JOIN " + RetSqlName( "GW6" ) + " GW6 ON GW6.GW6_FILIAL = GW3.GW3_FILFAT AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT AND " 
			cQuery += " GW6.GW6_SERFAT = GW3.GW3_SERFAT  AND GW6.GW6_NRFAT = GW3.GW3_NRFAT AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA and GW6.GW6_SITFIN = '4' "
		Else
			cQuery += " AND GW3.GW3_SITFIS = '4' "
		EndIf
		cQuery += " WHERE EXISTS(SELECT GWM.GWM_TPDOC FROM " + RetSQLName( "GWM" ) + " GWM "
		cQuery += " WHERE GWA.GWA_FILIAL = GWM.GWM_FILIAL AND GWA.GWA_TPDOC = GWM.GWM_TPDOC AND "
		cQuery += " GWA.GWA_CDESP = GWM.GWM_CDESP AND GWA.GWA_CDEMIT = GWM.GWM_CDTRP AND GWA.GWA_SERIE = GWM.GWM_SERDOC AND "
		cQuery += " GWA.GWA_NRDOC = GWM.GWM_NRDOC AND GWA.GWA_DTEMIS = GWM.GWM_DTEMIS AND GWM.GWM_DTEMDC LIKE '"+ cAnoMes +"%' AND " 
		cQuery += " GWM.D_E_L_E_T_ = ' ' ) AND (GWA.GWA_TPDOC = '2' OR GWA.GWA_TPDOC = '3') AND GWA.GWA_TPMOV = '1' AND "
		cQuery += " GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND GWA.GWA_DTMOV LIKE '"+ cAnoMes +"%' AND  GWA.GWA_CDTRAN IN ('312','313') AND"
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GW3.D_E_L_E_T_ = ' ' "
		If lConsDSCTB
			cQuery += " AND GW6.D_E_L_E_T_ = ' ' "
		EndIf
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cRMACofins, .F., .T.)
		
		dbSelectArea( cRMACofins )
		If !(cRMACofins)->( Eof() )
			(cTabGWA)->COFINS += (cRMACofins)->VALOR
		EndIf
		(cRMACofins)->(dbCloseArea())

		//Realizado Total ----------------------------------------------------------
		(cTabGWA)->REALTO := (cTabGWA)->REALMS + (cTabGWA)->REALMA
		
		//Estorno com nova Provisão -------------------------------------------------
		cEstNPrv := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXN" ) + " GXN ON GXN.GXN_FILIAL = GWA.GWA_FILIAL AND GXN.GXN_CODLOT = GWA.GWA_CODLOT AND " 
		cQuery += " GXN.GXN_CODEST = GWA.GWA_CODEST "
		cQuery += " WHERE GWA.GWA_TPDOC = '4' AND GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND "
		cQuery += " GXN.GXN_PERIES = '" + cGXEPeriod + "' AND GXN.GXN_SIT IN('2','4') AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXN.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cEstNPrv, .F., .T.)
		
		dbSelectArea( cEstNPrv )
		If !(cEstNPrv)->( Eof() )
			(cTabGWA)->ESTCPR := (cEstNPrv)->VALOR
		EndIf
		(cEstNPrv)->(dbCloseArea())
		
		//Estorno com nova Provisão -------------------------------------------------ICMS
		cEstPrICMS := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXN" ) + " GXN ON GXN.GXN_FILIAL = GWA.GWA_FILIAL AND GXN.GXN_CODLOT = GWA.GWA_CODLOT AND "
		cQuery += " GXN.GXN_CODEST = GWA.GWA_CODEST "
		cQuery += " WHERE GWA.GWA_TPDOC = '4' AND GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND "
		cQuery += " GXN.GXN_PERIES = '" + cGXEPeriod + "' AND GWA.GWA_CDTRAN = '301' AND GXN.GXN_SIT IN('2','4') AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXN.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cEstPrICMS, .F., .T.)
		
		dbSelectArea( cEstPrICMS )
		If !(cEstPrICMS)->( Eof() )
			(cTabGWA)->VLICMS -= (cEstPrICMS)->VALOR
		EndIf
		(cEstPrICMS)->(dbCloseArea())
		
		//Estorno com nova Provisão -------------------------------------------------COFINS
		cEstPvCfns := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXN" ) + " GXN ON GXN.GXN_FILIAL = GWA.GWA_FILIAL AND GXN.GXN_CODLOT = GWA.GWA_CODLOT AND "
		cQuery += " GXN.GXN_CODEST = GWA.GWA_CODEST "
		cQuery += " WHERE GWA.GWA_TPDOC = '4' AND GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND "
		cQuery += " GXN.GXN_PERIES = '" + cGXEPeriod + "' AND GWA.GWA_CDTRAN IN ('302','303') AND GXN.GXN_SIT IN('2','4') AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXN.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cEstPvCfns, .F., .T.)
		
		dbSelectArea( cEstPvCfns )
		If !(cEstPvCfns)->( Eof() )
			(cTabGWA)->COFINS -= (cEstPvCfns)->VALOR
		EndIf
		(cEstPvCfns)->(dbCloseArea())
		
		//Estorno Prov Realizada -------------------------------------------------
		cEstPrvR := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXN" ) + " GXN ON GXN.GXN_FILIAL = GWA.GWA_FILIAL AND GXN.GXN_CODLOT = GWA.GWA_CODLOT AND "
		cQuery += " GXN.GXN_CODEST = GWA.GWA_CODEST "
		cQuery += " WHERE GWA.GWA_TPDOC = '1' AND GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND "
		cQuery += " GXN.GXN_PERIES = '" + cGXEPeriod + "' AND GXN.GXN_SIT IN('2','4') AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXN.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cEstPrvR, .F., .T.)
		
		dbSelectArea( cEstPrvR )
		If !(cEstPrvR)->( Eof() )
			(cTabGWA)->ESTREL := (cEstPrvR)->VALOR
		EndIf
		(cEstPrvR)->(dbCloseArea())
		
		//Estorno Prov Realizada -------------------------------------------------ICMS
		cPrvICMS := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXN" ) + " GXN ON GXN.GXN_FILIAL = GWA.GWA_FILIAL AND GXN.GXN_CODLOT = GWA.GWA_CODLOT AND "
		cQuery += " GXN.GXN_CODEST = GWA.GWA_CODEST "
		cQuery += " WHERE GWA.GWA_TPDOC = '1' AND GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND "
		cQuery += " GXN.GXN_PERIES = '" + cGXEPeriod + "' AND GWA.GWA_CDTRAN = '301' AND GXN.GXN_SIT IN('2','4') AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXN.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cPrvICMS, .F., .T.)
		
		dbSelectArea( cPrvICMS )
		If !(cPrvICMS)->( Eof() )
			(cTabGWA)->VLICMS -= (cPrvICMS)->VALOR
		EndIf
		(cPrvICMS)->(dbCloseArea())
		
		//Estorno Prov Realizada -------------------------------------------------COFINS
		cPrvCofins := GetNextAlias()
		cQuery := ""
		cQuery := " SELECT SUM( GWA.GWA_VLMOV ) AS VALOR FROM " + RetSQLName( "GWA" ) + " GWA "
		cQuery += " INNER JOIN " + RetSQLName( "GXN" ) + " GXN ON GXN.GXN_FILIAL = GWA.GWA_FILIAL AND GXN.GXN_CODLOT = GWA.GWA_CODLOT AND GXN.GXN_CODEST = GWA.GWA_CODEST"
		cQuery += " WHERE GWA.GWA_TPDOC = '1' AND GWA.GWA_FILIAL = '" + (cAliasQry)->GWA_FILIAL + "' AND "
		cQuery += " GXN.GXN_PERIES = '" + cGXEPeriod + "' AND GWA.GWA_CDTRAN IN ('302','303') AND GXN.GXN_SIT IN('2','4') AND "
		cQuery += " GWA.D_E_L_E_T_ = ' ' AND "
		cQuery += " GXN.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cPrvCofins, .F., .T.)
		
		dbSelectArea( cPrvCofins )
		If !(cPrvCofins)->( Eof() )
			(cTabGWA)->COFINS -= (cPrvCofins)->VALOR
		EndIf
		(cPrvCofins)->(dbCloseArea())
		
		//Provisão Estornada -------------------------------------------------
		(cTabGWA)->TOTPRV := (cTabGWA)->ESTCPR + (cTabGWA)->ESTREL
		
		(cTabGWA)->TOTFRE := (cTabGWA)->PRVTOT + (cTabGWA)->REALTO - (cTabGWA)->TOTPRV //Total Frete Contab: Provisão + Realizado - Estorno
		
		(cTabGWA)->FRECTB := (cTabGWA)->TOTFRE - ABS((cTabGWA)->VLICMS) - ABS((cTabGWA)->COFINS) //Total Frete Contab - Impostos
		
		MsUnLock( cTabGWA )

		//Totalizadores
		pPRVEST += (cTabGWA)->PRVEST
		pPRVSSA += (cTabGWA)->PRVSSA
		pPRVNFC += (cTabGWA)->PRVNFC
		pPRVCSA += (cTabGWA)->PRVCSA
		pPRVTOT += (cTabGWA)->PRVTOT
		pREALMS += (cTabGWA)->REALMS
		pREALMA += (cTabGWA)->REALMA
		pREALTO += (cTabGWA)->REALTO
		pESTCPR += (cTabGWA)->ESTCPR
		pESTREL += (cTabGWA)->ESTREL
		pTOTPRV += (cTabGWA)->TOTPRV
		pVLICMS += (cTabGWA)->VLICMS
		pCOFINS += (cTabGWA)->COFINS
		pFRECTB += (cTabGWA)->FRECTB
		pTOTFRE += (cTabGWA)->TOTFRE
		
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
			   {"PRVEST", "N", 18,2},;
			   {"PRVSSA", "N", 18,2},;
			   {"PRVNFC", "N", 18,2},;
			   {"PRVCSA", "N", 18,2},;
			   {"PRVTOT", "N", 18,2},;
			   {"REALMS", "N", 18,2},;
			   {"REALMA", "N", 18,2},;
			   {"REALTO", "N", 18,2},;
			   {"ESTCPR", "N", 18,2},;
			   {"ESTREL", "N", 18,2},;
			   {"TOTPRV", "N", 18,2},;
			   {"VLICMS", "N", 18,2},;
			   {"COFINS", "N", 18,2},;
			   {"FRECTB", "N", 18,2},;
			   {"TOTFRE", "N", 18,2}}
			   
Return GFECriaTab({ aTT,{"FILIAL"} })
