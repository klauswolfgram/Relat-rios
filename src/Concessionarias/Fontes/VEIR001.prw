/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"
#Include "VEIR000.CH"

/*/{Protheus.doc} VEIR001
	Impressao do Resumo das Propriedades Agricolas

	@author Andre Luis Almeida
	@since 26/01/2021
/*/
User Function VEIR001( cGruNeg , cCodCli , cLojCli , cRegPAg , cMunPAg , cUFMPAg , cCodPAg )
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
Private aCulturas := VR0000021_Levanta("VK1",cAnoIni) // Culturas do ano corrente e anterior
Private aEspecies := VR0000021_Levanta("VK2",cAnoIni) // Especies do ano corrente e anterior
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
Local oSection2
Local oSection3
Local oSection4
//
oReport := TReport():New("VEIR001",STR0009,IIf(lFazPerg,"VEIR000",nil),{|oReport| VR0010011_Impressao(oReport)}) // Resumo das Propriedades Agricolas
//
VR0010021_ColunasImpressao( @oReport , @oSection1 , STR0009 , STR0010 ) // Resumo das Propriedades Agricolas / Total Geral
VR0010021_ColunasImpressao( @oReport , @oSection2 , STR0011 , STR0012 ) // Resumo das Propriedades Agricolas por Regiao / Regiao
VR0010021_ColunasImpressao( @oReport , @oSection3 , STR0013 , STR0014 ) // Resumo das Propriedades Agricolas por UF / UF
VR0010021_ColunasImpressao( @oReport , @oSection4 , STR0015 , STR0016 ) // Resumo das Propriedades Agricolas por Municipio UF / Municipio UF
//
oReport:SetTotalInLine(.f.)
oReport:SetLandScape()
oReport:DisableOrientation()
//
Return oReport

/*/{Protheus.doc} VR0010011_Impressao
	Carrega variaveis para serem utilizadas nos Filtros dos Browse's para a Consulta

	@author Andre Luis Almeida
	@since 11/01/2021
/*/
Static Function VR0010011_Impressao( oReport )
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
Local oSection4 := oReport:Section(4)
Local cQuery    := ""
Local cQAlias   := "SQLVJY"
Local cQuebReg  := "INICIAL"
Local cQuebUFM  := "INICIAL"
Local cQuebMun  := "INICIAL"
Local cTitRel   := VR0000051_CarregaVariaveisFiltros()
Private nPosTOT := 0
Private nPosReg := 0
Private nPosUFM := 0
Private nPosMun := 0
Private aVetTOT := {}
Private aVetReg := {}
Private aVetUFM := {}
Private aVetMun := {}
//
If !Empty(cTitRel)
	oReport:SetTitle( cTitRel )
EndIf
//
nPosTOT := VR0010031_Posiciona_e_Add_Vetor( @aVetTOT , STR0001 , "" ) // Propriedades Agricolas
//
cQuery := "SELECT VJY.VJY_REGIAO , VAM.VAM_ESTADO , VAM.VAM_DESCID , "
cQuery += "       VJY.VJY_CODIGO , VJY.VJY_AREPRO , VJY.VJY_AREARR , VJY.VJY_ARETOT "
cQuery += "  FROM "+RetSqlName("VJY")+" VJY "
cQuery += "  JOIN "+RetSqlName("VAM")+" VAM ON VAM.VAM_FILIAL='"+xFilial("VAM")+"' AND VAM.VAM_IBGE=VJY.VJY_IBGE AND VAM.D_E_L_E_T_=' '"
cQuery += VR0000061_Monta_WHERE_SQL() // Monta WHERE com Filtros no SQL de levantamento das Propriedades Agricolas
cQuery += " ORDER BY VJY.VJY_REGIAO , VAM.VAM_ESTADO , VAM.VAM_DESCID , VJY.VJY_CODIGO"
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlias, .F., .T. )
oReport:SetMeter((cQAlias)->(RecCount()))
While !((cQAlias)->(Eof())) .and. !oReport:Cancel()
	oReport:IncMeter()
	If cQuebReg <> (cQAlias)->( VJY_REGIAO )
		cQuebReg := (cQAlias)->( VJY_REGIAO )
		nPosReg := VR0010031_Posiciona_e_Add_Vetor( @aVetReg , (cQAlias)->( VJY_REGIAO ) , left(FM_SQL("SELECT X5_DESCRI FROM "+RetSQLName("SX5")+" WHERE X5_FILIAL='"+xFilial("SX5")+"' AND X5_TABELA='A2' AND X5_CHAVE='"+(cQAlias)->( VJY_REGIAO )+"' AND D_E_L_E_T_=' '"),30) )
	EndIf
	If cQuebUFM <> (cQAlias)->( VAM_ESTADO )
		cQuebUFM := (cQAlias)->( VAM_ESTADO )
		nPosUFM := VR0010031_Posiciona_e_Add_Vetor( @aVetUFM , (cQAlias)->( VAM_ESTADO ) , "" )
	EndIf
	If cQuebMun <> (cQAlias)->( VAM_DESCID )+(cQAlias)->( VAM_ESTADO )
		cQuebMun := (cQAlias)->( VAM_DESCID )+(cQAlias)->( VAM_ESTADO )
		nPosMun := VR0010031_Posiciona_e_Add_Vetor( @aVetMun , (cQAlias)->( VAM_DESCID ) , (cQAlias)->( VAM_ESTADO ) )
	EndIf
	VR0010041_Totaliza_Vetores( (cQAlias)->( VJY_CODIGO ) , (cQAlias)->( VJY_AREPRO ) , (cQAlias)->( VJY_AREARR ) , (cQAlias)->( VJY_ARETOT ) )
	(cQAlias)->(dbSkip())
EndDo
(cQAlias)->(dbCloseArea())
//
VR0010051_Imprime_Vetores(@oSection1,aVetTOT)
VR0010051_Imprime_Vetores(@oSection2,aVetReg)
VR0010051_Imprime_Vetores(@oSection3,aVetUFM)
VR0010051_Imprime_Vetores(@oSection4,aVetMun)
//
DbSelectArea("VJY")
//
Return Nil

/*/{Protheus.doc} VR0010021_ColunasImpressao
	Colunas de Impressao

	@author Andre Luis Almeida
	@since 29/01/2021
/*/
Static Function VR0010021_ColunasImpressao( oReport , oSection , cDesc , cTit )

oSection := TRSection():New(oReport,cDesc,{}) // Resumo das Propriedades Agricolas
TRCell():New(oSection,"TOT_DESCRI",,cTit,"@!",30,, {|| cTOT_DESCRI } )
TRCell():New(oSection,"TOT_QTDPRO",,STR0017,"@E 9999999",7,, {|| nTOT_QTDPRO } ) // Quantidade
TRCell():New(oSection,"TOT_AREPRO",,GetSX3Cache("VJY_AREPRO","X3_TITULO"),GetSX3Cache("VJY_AREPRO","X3_PICTURE"),GetSX3Cache("VJY_AREPRO","X3_TAMANHO"),, {|| nTOT_AREPRO } )
TRCell():New(oSection,"TOT_AREARR",,GetSX3Cache("VJY_AREARR","X3_TITULO"),GetSX3Cache("VJY_AREARR","X3_PICTURE"),GetSX3Cache("VJY_AREARR","X3_TAMANHO"),, {|| nTOT_AREARR } )
TRCell():New(oSection,"TOT_ARETOT",,GetSX3Cache("VJY_ARETOT","X3_TITULO"),GetSX3Cache("VJY_ARETOT","X3_PICTURE"),GetSX3Cache("VJY_ARETOT","X3_TAMANHO"),, {|| nTOT_ARETOT } )
VR0000031_MontaColunas(@oSection,aCulturas,"C","VK1_ARECUL",.f.) // Culturas
VR0000031_MontaColunas(@oSection,aEspecies,"E","VK2_QTDANI",.f.) // Especies Pecuaria

Return

/*/{Protheus.doc} VR0010031_Posiciona_e_Add_Vetor
	Posiciona ou Adiciona linha em branco no Vetor correspondente

	@author Andre Luis Almeida
	@since 01/02/2021
/*/
Static Function VR0010031_Posiciona_e_Add_Vetor( aVet , cQueb1 , cQueb2 )
Local nPos    := aScan(aVet,{ |x| x[1]+x[2] == cQueb1 + cQueb2 })
Local nCntFor := 0 
If nPos == 0
	aAdd(aVet,{	cQueb1 ,;
				cQueb2 ,;
				{ 0 , 0 , 0 , 0 } ,;
				array(len(aCulturas)) ,;
				array(len(aEspecies)) })
	nPos := len(aVet)
	For nCntFor := 1 to len(aCulturas)
		aVet[nPos,4,nCntFor] := 0
	Next
	For nCntFor := 1 to len(aEspecies)
		aVet[nPos,5,nCntFor] := 0
	Next
EndIf
Return nPos

/*/{Protheus.doc} VR0010041_Totaliza_Vetores
	Totaliza no Vetor

	@author Andre Luis Almeida
	@since 01/02/2021
/*/
Static Function VR0010041_Totaliza_Vetores( cCodVJY , nArePro , nAreArr , nAreTot )
Local nCntFor := 0
Local cAnoIni := strzero(year(dDatabase)-1,4) // Ano corrente e anterior
Local cQuery  := ""
Local cQAlAux := "SQLAUX"
//
aVetTOT[nPosTOT,3,1]++
aVetTOT[nPosTOT,3,2] += nArePro
aVetTOT[nPosTOT,3,3] += nAreArr
aVetTOT[nPosTOT,3,4] += nAreTot
//
aVetReg[nPosReg,3,1]++
aVetReg[nPosReg,3,2] += nArePro
aVetReg[nPosReg,3,3] += nAreArr
aVetReg[nPosReg,3,4] += nAreTot
//
aVetUFM[nPosUFM,3,1]++
aVetUFM[nPosUFM,3,2] += nArePro
aVetUFM[nPosUFM,3,3] += nAreArr
aVetUFM[nPosUFM,3,4] += nAreTot
//
aVetMun[nPosMun,3,1]++
aVetMun[nPosMun,3,2] += nArePro
aVetMun[nPosMun,3,3] += nAreArr
aVetMun[nPosMun,3,4] += nAreTot
//
For nCntFor := 1 to len(aCulturas)
	&("nC"+strzero(nCntFor,5)) := 0
Next
For nCntFor := 1 to len(aEspecies)
	&("nE"+strzero(nCntFor,5)) := 0
Next
//
cQuery := "SELECT VK1_CULTUR , VK1_ARECUL "
cQuery += "  FROM "+RetSqlName("VK1")
cQuery += " WHERE VK1_FILIAL='"+xFilial("VK1")+"'"
cQuery += "   AND VK1_PROAGR='"+cCodVJY+"'"
cQuery += "   AND VK1_SAFRA>='"+cAnoIni+"'"
cQuery += "   AND D_E_L_E_T_=' '"
cQuery += " ORDER BY VK1_SAFRA DESC , VK1_ANO DESC"
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
While !((cQAlAux)->(Eof()))
	nCntFor := ascan(aCulturas,{ |x| x[1] == (cQAlAux)->( VK1_CULTUR ) })
	If nCntFor > 0 .and. &("nC"+strzero(nCntFor,5)) == 0
		&("nC"+strzero(nCntFor,5)) := (cQAlAux)->( VK1_ARECUL )
		aVetTOT[nPosTOT,4,nCntFor] += (cQAlAux)->( VK1_ARECUL )
		aVetReg[nPosReg,4,nCntFor] += (cQAlAux)->( VK1_ARECUL )
		aVetUFM[nPosUFM,4,nCntFor] += (cQAlAux)->( VK1_ARECUL )
		aVetMun[nPosMun,4,nCntFor] += (cQAlAux)->( VK1_ARECUL )
	EndIf
	(cQAlAux)->(dbSkip())
EndDo
(cQAlAux)->(dbCloseArea())
//
cQuery := "SELECT VK2_ESPECI , VK2_QTDANI "
cQuery += "  FROM "+RetSqlName("VK2")
cQuery += " WHERE VK2_FILIAL='"+xFilial("VK2")+"'"
cQuery += "   AND VK2_PROAGR='"+cCodVJY+"'"
cQuery += "   AND VK2_ANO>='"+cAnoIni+"'"
cQuery += "   AND D_E_L_E_T_=' '"
cQuery += " ORDER BY VK2_ANO DESC"
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
While !((cQAlAux)->(Eof()))
	nCntFor := ascan(aEspecies,{ |x| x[1] == (cQAlAux)->( VK2_ESPECI ) })
	If nCntFor > 0 .and. &("nE"+strzero(nCntFor,5)) == 0
		&("nE"+strzero(nCntFor,5)) := (cQAlAux)->( VK2_QTDANI )
		aVetTOT[nPosTOT,5,nCntFor] += (cQAlAux)->( VK2_QTDANI )
		aVetReg[nPosReg,5,nCntFor] += (cQAlAux)->( VK2_QTDANI )
		aVetUFM[nPosUFM,5,nCntFor] += (cQAlAux)->( VK2_QTDANI )
		aVetMun[nPosMun,5,nCntFor] += (cQAlAux)->( VK2_QTDANI )
	EndIf
	(cQAlAux)->(dbSkip())
EndDo
(cQAlAux)->(dbCloseArea())
//
Return

/*/{Protheus.doc} VR0010051_Imprime_Vetores
	Imprime Vetores

	@author Andre Luis Almeida
	@since 01/02/2021
/*/
Static Function VR0010051_Imprime_Vetores(oSec,aVet)
Local nPos    := 0
Local nCntFor := 0
Private cTOT_DESCRI := ""
Private nTOT_QTDPRO := 0
Private nTOT_AREPRO := 0
Private nTOT_AREARR := 0
Private nTOT_ARETOT := 0
oSec:Init()
For nPos := 1 to len(aVet)
	cTOT_DESCRI := Alltrim(aVet[nPos,1])+IIf(!Empty(aVet[nPos,2])," - "+aVet[nPos,2],"")
	nTOT_QTDPRO := aVet[nPos,3,1]
	nTOT_AREPRO := aVet[nPos,3,2]
	nTOT_AREARR := aVet[nPos,3,3]
	nTOT_ARETOT := aVet[nPos,3,4]
	For nCntFor := 1 to len(aCulturas)
		&("nC"+strzero(nCntFor,5)) := aVet[nPos,4,nCntFor]
	Next
	For nCntFor := 1 to len(aEspecies)
		&("nE"+strzero(nCntFor,5)) := aVet[nPos,5,nCntFor]
	Next
	oSec:PrintLine()
Next
oSec:Finish()
Return