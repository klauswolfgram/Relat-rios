/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"
#Include "VEIR000.CH"

/*/{Protheus.doc} VEIR000
	Impressao das Propriedades Agricolas

	@author Andre Luis Almeida
	@since 26/01/2021
/*/
User Function VEIR000( cGruNeg , cCodCli , cLojCli , cRegPAg , cMunPAg , cUFMPAg , cCodPAg )
Local oReport
Local aArea   := GetArea()
Local cAnoIni := strzero(year(dDatabase)-1,4) // Ano corrente e anterior
Default cGruNeg := ""
Default cCodCli := ""
Default cLojCli := ""
Default cRegPAg := ""
Default cMunPAg := ""
Default cUFMPAg := ""
Default cCodPAg := ""
Private cP_GruNeg := cGruNeg // Parametros para filtro
Private cP_CodCli := cCodCli // Parametros para filtro
Private cP_LojCli := cLojCli // Parametros para filtro
Private cP_RegPAg := cRegPAg // Parametros para filtro
Private cP_MunPAg := cMunPAg // Parametros para filtro
Private cP_UFMPAg := cUFMPAg // Parametros para filtro
Private cP_CodPAg := cCodPAg // Parametros para filtro
Private lFazPerg  := Empty( cP_GruNeg + cP_CodCli + cP_LojCli + cP_RegPAg + cP_MunPAg + cP_UFMPAg + cP_CodPAg ) // Se não passou parametro, faz a pergunte
Private aCulturas := U_VR0000021_Levanta("VK1",cAnoIni) // Culturas do ano corrente e anterior
Private aEspecies := U_VR0000021_Levanta("VK2",cAnoIni) // Especies do ano corrente e anterior
//
If lFazPerg
	Pergunte("VEIR000",.f.)
EndIf
oReport := ReportDef()
oReport:PrintDialog()
RestArea( aArea )
//
Return

/*/{Protheus.doc} ReportDef
	ReportDef

	@author Andre Luis Almeida
	@since 26/01/2021
/*/
Static Function ReportDef()
Local oReport
Local oSection1
//
oReport := TReport():New("VEIR000",STR0001,IIf(lFazPerg,"VEIR000",nil),{|oReport| VR0000011_Impressao(oReport)}) // Propriedades Agricolas
//
oSection1 := TRSection():New(oReport,STR0001,{"VJY","VAM"}) // Propriedades Agricolas
TRCell():New(oSection1,"VJY_CODIGO","VJY",,,)
TRCell():New(oSection1,"VJY_NOME"  ,"VJY",,,)
TRCell():New(oSection1,"VJY_REGIAO","VJY",,,)
TRCell():New(oSection1,"VAM_DESCID","VAM",,,)
TRCell():New(oSection1,"VAM_ESTADO","VAM",,,)
TRCell():New(oSection1,"VJY_AREPRO","VJY",,,)
TRCell():New(oSection1,"VJY_AREARR","VJY",,,)
TRCell():New(oSection1,"VJY_ARETOT","VJY",,,)
TRFunction():New(oSection1:Cell("VJY_CODIGO"),NIL,"COUNT") // Totalizadores - Qtde de Propriedades Agricolas
TRFunction():New(oSection1:Cell("VJY_AREPRO"),NIL,"SUM") // Totalizadores - Area Propria
TRFunction():New(oSection1:Cell("VJY_AREARR"),NIL,"SUM") // Totalizadores - Area Arrendada
TRFunction():New(oSection1:Cell("VJY_ARETOT"),NIL,"SUM") // Totalizadores - Area Total
U_VR0000031_MontaColunas(@oSection1,aCulturas,"C","VK1_ARECUL",.t.) // Culturas
U_VR0000031_MontaColunas(@oSection1,aEspecies,"E","VK2_QTDANI",.t.) // Especies Pecuaria
oReport:SetTotalInLine(.f.)
oReport:SetLandScape()
oReport:DisableOrientation()
//
Return oReport

/*/{Protheus.doc} VR0000011_Impressao
	Carrega variaveis para serem utilizadas nos Filtros dos Browse's para a Consulta

	@author Andre Luis Almeida
	@since 11/01/2021
/*/
Static Function VR0000011_Impressao( oReport )
Local oSection1 := oReport:Section(1)
Local nCntFor   := 0
Local cQuery    := ""
Local cQAlias   := "SQLVJY"
Local cQAlAux   := "SQLAUX"
Local cAnoIni   := strzero(year(dDatabase)-1,4) // ano corrente e anterior
Local cTitRel   := U_VR0000051_CarregaVariaveisFiltros()
//
If !Empty(cTitRel)
	oReport:SetTitle( cTitRel )
EndIf
//
cQuery := "SELECT VJY.R_E_C_N_O_ AS RECVJY,"
cQuery += "       VAM.R_E_C_N_O_ AS RECVAM "
cQuery += "  FROM "+RetSqlName("VJY")+" VJY"
cQuery += "  JOIN "+RetSqlName("VAM")+" VAM ON VAM.VAM_FILIAL='"+xFilial("VAM")+"' AND VAM.VAM_IBGE=VJY.VJY_IBGE AND VAM.D_E_L_E_T_=' '"
cQuery += U_VR0000061_Monta_WHERE_SQL() // Monta WHERE com Filtros no SQL de levantamento das Propriedades Agricolas
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlias, .F., .T. )
oReport:SetMeter((cQAlias)->(RecCount()))
oSection1:Init()
While !((cQAlias)->(Eof())) .and. !oReport:Cancel()
	oReport:IncMeter()
	VJY->(DbGoto( (cQAlias)->( RECVJY ) ))
	VAM->(DbGoto( (cQAlias)->( RECVAM ) ))
	For nCntFor := 1 to len(aCulturas)
		&("nC"+strzero(nCntFor,5)) := 0
	Next
	For nCntFor := 1 to len(aEspecies)
		&("nE"+strzero(nCntFor,5)) := 0
	Next
	cQuery := "SELECT VK1_CULTUR , VK1_ARECUL "
	cQuery += "  FROM "+RetSqlName("VK1")
	cQuery += " WHERE VK1_FILIAL='"+xFilial("VK1")+"'"
	cQuery += "   AND VK1_PROAGR='"+VJY->VJY_CODIGO+"'"
	cQuery += "   AND VK1_SAFRA>='"+cAnoIni+"'"
	cQuery += "   AND D_E_L_E_T_=' '"
	cQuery += " ORDER BY VK1_SAFRA DESC , VK1_ANO DESC"
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
	While !((cQAlAux)->(Eof()))
		nPos := ascan(aCulturas,{ |x| x[1] == (cQAlAux)->( VK1_CULTUR ) })
		If nPos > 0 .and. &("nC"+strzero(nPos,5)) == 0
			&("nC"+strzero(nPos,5)) += (cQAlAux)->( VK1_ARECUL )
		EndIf
		(cQAlAux)->(dbSkip())
	EndDo
	(cQAlAux)->(dbCloseArea())
	cQuery := "SELECT VK2_ESPECI , VK2_QTDANI "
	cQuery += "  FROM "+RetSqlName("VK2")
	cQuery += " WHERE VK2_FILIAL='"+xFilial("VK2")+"'"
	cQuery += "   AND VK2_PROAGR='"+VJY->VJY_CODIGO+"'"
	cQuery += "   AND VK2_ANO>='"+cAnoIni+"'"
	cQuery += "   AND D_E_L_E_T_=' '"
	cQuery += " ORDER BY VK2_ANO DESC"
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
	While !((cQAlAux)->(Eof()))
		nPos := ascan(aEspecies,{ |x| x[1] == (cQAlAux)->( VK2_ESPECI ) })
		If nPos > 0 .and. &("nE"+strzero(nPos,5)) == 0
			&("nE"+strzero(nPos,5)) := (cQAlAux)->( VK2_QTDANI )
		EndIf
		(cQAlAux)->(dbSkip())
	EndDo
	(cQAlAux)->(dbCloseArea())
	oSection1:PrintLine()
	(cQAlias)->(dbSkip())
EndDo
(cQAlias)->(dbCloseArea())
DbSelectArea("VJY")
oSection1:Finish()
//
Return Nil

/*/{Protheus.doc} VR0000021_Levanta
	Levanta registros ( VK1 e VK2 )

	@author Andre Luis Almeida
	@since 28/01/2021
/*/
User Function VR0000021_Levanta(cTab,cAnoIni)
Local aRet    := {}
Local cQuery  := ""
Local cQAlAux := "SQLAUX"
Local aOpcAux := {}
Local cCampoVX5 := IIf(FindFunction("OA5600011_Campo_Idioma"),OA5600011_Campo_Idioma(),"VX5_DESCRI")
Do Case
	Case cTab == "VK1"
		cQuery := "SELECT DISTINCT VK1.VK1_CULTUR , "+cCampoVX5+" AS DESCRI "
		cQuery += "  FROM "+RetSqlName("VK1")+" VK1"
		cQuery += "  JOIN "+RetSqlName("VX5")+" VX5 ON VX5.VX5_FILIAL='"+xFilial("VX5")+"' AND VX5.VX5_CHAVE='003' AND VX5.VX5_CODIGO=VK1.VK1_CULTUR AND VX5.D_E_L_E_T_=' '"
		cQuery += " WHERE VK1.VK1_FILIAL='"+xFilial("VK1")+"'"
		cQuery += "   AND VK1.VK1_SAFRA>='"+cAnoIni+"'"
		cQuery += "   AND VK1.D_E_L_E_T_=' '"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
		While !((cQAlAux)->(Eof()))
			aAdd(aRet,{ (cQAlAux)->( VK1_CULTUR ) , (cQAlAux)->( DESCRI ) })
			(cQAlAux)->(dbSkip())
		EndDo
		(cQAlAux)->(dbCloseArea())
	Case cTab == "VK2"
		aOpcAux := X3CBOXAVET("VK2_ESPECI","0")
		cQuery := "SELECT DISTINCT VK2_ESPECI"
		cQuery += "  FROM "+RetSqlName("VK2")
		cQuery += " WHERE VK2_FILIAL='"+xFilial("VK2")+"'"
		cQuery += "   AND VK2_ANO>='"+cAnoIni+"'"
		cQuery += "   AND D_E_L_E_T_=' '"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
		While !((cQAlAux)->(Eof()))
			aAdd(aRet,{ (cQAlAux)->( VK2_ESPECI ) , X3CBOXDESC("VK2_ESPECI", (cQAlAux)->( VK2_ESPECI ), aOpcAux) })
			(cQAlAux)->(dbSkip())
		EndDo
		(cQAlAux)->(dbCloseArea())
EndCase
DbSelectArea("VJY")
Return aClone(aRet)

/*/{Protheus.doc} VR0000031_MontaColunas
	Monta colunas dinamicas do relatorio ( dependendo dos registros do VK1 - Culturas e VK2 - Especies Pecuaria )

	@author Andre Luis Almeida
	@since 28/01/2021
/*/
User Function VR0000031_MontaColunas(oSec,aAux,cTp,cCpo,lTotaliza)
Local nCntFor := 0
Local cPictur := GetSX3Cache(cCpo,"X3_PICTURE")
Local nTamanh := GetSX3Cache(cCpo,"X3_TAMANHO")
For nCntFor := 1 to len(aAux)
	TRCell():New(oSec,cTp+strzero(nCntFor,5),,aAux[nCntFor,2],cPictur,nTamanh,,&("{|| n"+cTp+strzero(nCntFor,5)+" } ") )
	If lTotaliza
		TRFunction():New(oSec:Cell(cTp+strzero(nCntFor,5)),NIL,"SUM") // Totalizadores por Coluna
	EndIf
Next
Return

/*/{Protheus.doc} VR0000041_ValidPerg
	Validacao dos Parametros da Pergunte VEIR000 - Necessario limpar os demais parametros 
	
	@author Andre Luis Almeida
	@since 29/01/2021
/*/
User Function VR0000041_ValidPerg(cValid)
Local lRet     := .f.
Local lLimpa01 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa02 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa03 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa04 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa05 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa06 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa07 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
If Empty(&(readvar()))
	Return .t.
EndIf
Do Case
	Case cValid == "VJW" // Grupo de Negocio
		lRet := !Empty(FM_SQL("SELECT VJW_CODIGO FROM "+RetSQLName("VJW")+" WHERE VJW_FILIAL='"+xFilial("VJW")+"' AND VJW_CODIGO='"+MV_PAR01+"' AND D_E_L_E_T_=' '"))
		lLimpa01 := .f.
	Case cValid == "SA11" // Codigo do Cliente
		lRet := !Empty(FM_SQL("SELECT A1_COD FROM "+RetSQLName("SA1")+" WHERE A1_FILIAL='"+xFilial("SA1")+"' AND A1_COD='"+MV_PAR02+"' AND A1_LOJA='"+MV_PAR03+"' AND D_E_L_E_T_=' '"))
		lLimpa02 := lLimpa03 := .f.
		If !lRet
			lLimpa03 := .t.
			lRet := !Empty(FM_SQL("SELECT A1_COD FROM "+RetSQLName("SA1")+" WHERE A1_FILIAL='"+xFilial("SA1")+"' AND A1_COD='"+MV_PAR02+"' AND D_E_L_E_T_=' '"))
		EndIf
	Case cValid == "SA12" // Loja do Cliente
		lRet := !Empty(FM_SQL("SELECT A1_COD FROM "+RetSQLName("SA1")+" WHERE A1_FILIAL='"+xFilial("SA1")+"' AND A1_COD='"+MV_PAR02+"' AND A1_LOJA='"+MV_PAR03+"' AND D_E_L_E_T_=' '"))
		lLimpa02 := lLimpa03 := .f.
	Case cValid == "SX5A2" // Regiao da Propriedade Agricola
		lRet := !Empty(FM_SQL("SELECT X5_DESCRI FROM "+RetSQLName("SX5")+" WHERE X5_FILIAL='"+xFilial("SX5")+"' AND X5_TABELA='A2' AND X5_CHAVE='"+MV_PAR04+"' AND D_E_L_E_T_=' '"))
		lLimpa04 := .f.
	Case cValid == "VAM" // Codigo do IBGE da Propriedade Agricola
		lRet := !Empty(FM_SQL("SELECT VAM_IBGE FROM "+RetSQLName("VAM")+" WHERE VAM_FILIAL='"+xFilial("VAM")+"' AND VAM_IBGE='"+MV_PAR05+"' AND D_E_L_E_T_=' '"))
		lLimpa05 := .f.
	Case cValid == "SX512" // UF do Municipio da Propriedade Agricola
		lRet := !Empty(FM_SQL("SELECT X5_DESCRI FROM "+RetSQLName("SX5")+" WHERE X5_FILIAL='"+xFilial("SX5")+"' AND X5_TABELA='12' AND X5_CHAVE='"+MV_PAR06+"' AND D_E_L_E_T_=' '"))
		lLimpa06 := .f.
	Case cValid == "VJY" // Codigo da Propriedade Agricola
		lRet := !Empty(FM_SQL("SELECT VJY_CODIGO FROM "+RetSQLName("VJY")+" WHERE VJY_FILIAL='"+xFilial("VJY")+"' AND VJY_CODIGO='"+MV_PAR07+"' AND D_E_L_E_T_=' '"))
		lLimpa07 := .f.
EndCase
IIf(lLimpa01,MV_PAR01:=space(GetSX3Cache("VJW_CODIGO","X3_TAMANHO")),.t.)
IIf(lLimpa02,MV_PAR02:=space(GetSX3Cache("A1_COD"    ,"X3_TAMANHO")),.t.)
IIf(lLimpa03,MV_PAR03:=space(GetSX3Cache("A1_LOJA"   ,"X3_TAMANHO")),.t.)
IIf(lLimpa04,MV_PAR04:=space(GetSX3Cache("X5_CHAVE"  ,"X3_TAMANHO")),.t.)
IIf(lLimpa05,MV_PAR05:=space(GetSX3Cache("VAM_IBGE"  ,"X3_TAMANHO")),.t.)
IIf(lLimpa06,MV_PAR06:=space(GetSX3Cache("A1_EST"    ,"X3_TAMANHO")),.t.)
IIf(lLimpa07,MV_PAR07:=space(GetSX3Cache("VJY_CODIGO","X3_TAMANHO")),.t.)
Return lRet

/*/{Protheus.doc} VR0000051_CarregaVariaveisFiltros
	Carrega Variaveis para serem utilizados nos Filtros (parametros)
	
	@author Andre Luis Almeida
	@since 29/01/2021
/*/
User Function VR0000051_CarregaVariaveisFiltros()
Local cTitRel := ""
If lFazPerg // Utilizou a Pergunte ? --> Se sim, utilizar os Parametros / Se não, utilizar os Parametros passados na chamada do Relatorio
	cP_GruNeg := MV_PAR01 // Grupo de Negocio
	cP_CodCli := MV_PAR02 // Codigo do Cliente
	cP_LojCli := MV_PAR03 // Loja do Cliente
	cP_RegPAg := MV_PAR04 // Regiao
	cP_MunPAg := MV_PAR05 // Municipio (IBGE)
	cP_UFMPAg := MV_PAR06 // UF
	cP_CodPAg := MV_PAR07 // Codigo da Prop.Agricola
EndIf
Do Case
	Case !Empty(cP_GruNeg)
		cTitRel := STR0002+": "+cP_GruNeg // Propr.Agricolas do Grupo de Negocio
	Case !Empty(cP_CodCli+cP_LojCli)
		cTitRel := STR0003+": "+cP_CodCli // Propr.Agricolas do Cliente
		If !Empty(cP_LojCli)
			cTitRel += "-"+cP_LojCli
		Else
			cTitRel += " ("+STR0004+")" // todas lojas
		EndIf
	Case !Empty(cP_RegPAg)
		cTitRel := STR0005+": "+Alltrim(cP_RegPAg)+" - "+FM_SQL("SELECT X5_DESCRI FROM "+RetSQLName("SX5")+" WHERE X5_FILIAL='"+xFilial("SX5")+"' AND X5_TABELA='A2' AND X5_CHAVE='"+cP_RegPAg+"' AND D_E_L_E_T_=' '") // Propr.Agricolas da Regiao
	Case !Empty(cP_MunPAg)
		VAM->(DbSetOrder(1))
		VAM->(Dbseek(xFilial("VAM")+cP_MunPAg))
		cTitRel := STR0006+" - "+Alltrim(left(VAM->VAM_DESCID,30))+" - "+VAM->VAM_ESTADO // Propr.Agricolas
	Case !Empty(cP_UFMPAg)
		cTitRel := STR0007+" - "+cP_UFMPAg // Propr.Agricolas do Estado
	Case !Empty(cP_CodPAg)
		cTitRel := STR0008+": "+cP_CodPAg // Propr.Agricola
EndCase
Return cTitRel

/*/{Protheus.doc} VR0000061_Monta_WHERE_SQL
	Monta WHERE com Filtros no SQL de levantamento das Propriedades Agricolas
	
	@author Andre Luis Almeida
	@since 29/01/2021
/*/
User Function VR0000061_Monta_WHERE_SQL()
Local cQuery := ""
cQuery += " WHERE VJY.VJY_FILIAL='"+xFilial("VJY")+"'"
cQuery += IIf(!Empty(cP_CodPAg)," AND VJY.VJY_CODIGO='"+cP_CodPAg+"'","")
cQuery += IIf(!Empty(cP_RegPAg)," AND VJY.VJY_REGIAO='"+cP_RegPAg+"'","")
cQuery += IIf(!Empty(cP_MunPAg)," AND VJY.VJY_IBGE='"  +cP_MunPAg+"'","")
cQuery += IIf(!Empty(cP_UFMPAg)," AND VAM.VAM_ESTADO='"+cP_UFMPAg+"'","")
cQuery += "   AND VJY.D_E_L_E_T_=' '"
If !Empty(cP_CodCli+cP_LojCli)
	cQuery += " AND EXISTS ("
	cQuery += "     SELECT VJZ.VJZ_PROAGR "
	cQuery += "       FROM "+RetSQLName("VJZ")+" VJZ "
	cQuery += "      WHERE VJZ.VJZ_FILIAL='"+xFilial("VJZ")+"'"
	cQuery += "        AND VJZ.VJZ_PROAGR=VJY.VJY_CODIGO"
	cQuery += IIf(!Empty(cP_CodCli)," AND VJZ.VJZ_CODCLI='"+cP_CodCli+"'","")
	cQuery += IIf(!Empty(cP_LojCli)," AND VJZ.VJZ_LOJCLI='"+cP_LojCli+"'","")
	cQuery += "        AND VJZ.D_E_L_E_T_=' ' )"
ElseIf !Empty(cP_GruNeg)
	cQuery += " AND EXISTS ("
	cQuery += "     SELECT VJZ.VJZ_PROAGR "
	cQuery += "       FROM "+RetSqlName("VJX")+" VJX "
	cQuery += "       JOIN "+RetSqlName("VJZ")+" VJZ ON VJZ.VJZ_FILIAL='"+xFilial("VJZ")+"' AND VJZ.VJZ_PROAGR=VJY.VJY_CODIGO AND VJZ.VJZ_CODCLI=VJX.VJX_CODCLI AND VJZ.VJZ_LOJCLI=VJX.VJX_LOJCLI AND VJZ.D_E_L_E_T_=' '"
	cQuery += "      WHERE VJX.VJX_FILIAL='"+xFilial("VJX")+"'"
	cQuery += "        AND VJX.VJX_GRUNEG='"+cP_GruNeg+"'"
	cQuery += "        AND VJX.D_E_L_E_T_=' ' )"
EndIf
Return cQuery