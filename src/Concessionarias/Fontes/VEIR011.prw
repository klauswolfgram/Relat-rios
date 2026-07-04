/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"
#Include "VEIR010.CH"

/*/{Protheus.doc} VEIR011
	Impressao do Resumo de Frotas

	@author Andre Luis Almeida
	@since 02/02/2021
/*/
User Function VEIR011( cGruNeg , cCodCli , cLojCli , cRegCli , cMunCli , cUFMCli )
Local oReport
Local aArea   := GetArea()
Default cGruNeg := ""
Default cCodCli := ""
Default cLojCli := ""
Default cRegCli := ""
Default cMunCli := ""
Default cUFMCli := ""
Private cP_GruNeg  := cGruNeg // Parametros para filtro
Private cP_CodCli  := cCodCli // Parametros para filtro
Private cP_LojCli  := cLojCli // Parametros para filtro
Private cP_RegCli  := cRegCli // Parametros para filtro
Private cP_MunCli  := cMunCli // Parametros para filtro
Private cP_UFMCli  := cUFMCli // Parametros para filtro
Private lFazPerg   := Empty( cP_GruNeg + cP_CodCli + cP_LojCli + cP_RegCli + cP_MunCli + cP_UFMCli ) // Se não passou parametro, faz a pergunte
Private lVC3SEGMOD := ( VC3->(ColumnPos("VC3_SEGMOD")) > 0 )
Private cCodMarca  := FMX_RETMAR(GetNewPar("MV_MIL0006","")) // 28 da VX5
Private aFrotas    := VR0100021_Levanta() // Frotas ativas -> [1] Grupos de Modelos da Marca Pricipal / [2] Totalizadores Marca Principal, Outras Marcas e Total
//
If lFazPerg
	Pergunte("VEIR010",.f.)
EndIf
oReport := ReportDef()
oReport:PrintDialog()
RestArea( aArea )
//
Return

/*/{Protheus.doc} ReportDef
	ReportDef

	@author Andre Luis Almeida
	@since 02/02/2021
/*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local oSection4
//
oReport := TReport():New("VEIR011",STR0001,IIf(lFazPerg,"VEIR010",nil),{|oReport| VR0100011_Impressao(oReport)}) // Frotas
//
VR0110021_ColunasImpressao( @oReport , @oSection1 , STR0009 , STR0010 ) // Resumo de Frotas / Total Geral
VR0110021_ColunasImpressao( @oReport , @oSection2 , STR0011 , STR0012 ) // Resumo de Frotas por Regiao / Regiao
VR0110021_ColunasImpressao( @oReport , @oSection3 , STR0013 , STR0014 ) // Resumo de Frotas por UF / UF
VR0110021_ColunasImpressao( @oReport , @oSection4 , STR0015 , STR0016 ) // Resumo de Frotas por Municipio UF / Municipio UF
//
oReport:SetTotalInLine(.f.)
oReport:SetLandScape()
oReport:DisableOrientation()
//
Return oReport

/*/{Protheus.doc} VR0100011_Impressao
	Carrega variaveis para serem utilizadas nos Filtros dos Browse's para a Consulta

	@author Andre Luis Almeida
	@since 02/02/2021
/*/
Static Function VR0100011_Impressao( oReport )
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
Local oSection4 := oReport:Section(4)
Local cQuery    := ""
Local cQAlias   := "SQLVC3"
Local cQuebReg  := "INICIAL"
Local cQuebUFM  := "INICIAL"
Local cQuebMun  := "INICIAL"
Local cTitRel   := VR0100051_CarregaVariaveisFiltros()
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
nPosTOT := VR0110031_Posiciona_e_Add_Vetor( @aVetTOT , STR0001 , "" ) // Frotas
//
cQuery := "SELECT SA1.A1_REGIAO , VAM.VAM_ESTADO , VAM.VAM_DESCID ,"
cQuery += "       VC3.VC3_CODMAR , VC3.VC3_MODVEI ,"
If lVC3SEGMOD
	cQuery += "   VC3.VC3_SEGMOD ,"
EndIf
cQuery += "       SUM(VC3.VC3_QTDFRO) AS QTD "
cQuery += "  FROM "+RetSqlName("VC3")+" VC3"
cQuery += "  JOIN "+RetSqlName("SA1")+" SA1 ON SA1.A1_FILIAL='"+xFilial("SA1")+"' AND SA1.A1_COD=VC3.VC3_CODCLI AND SA1.A1_LOJA=VC3.VC3_LOJA AND SA1.D_E_L_E_T_=' '"
cQuery += "  JOIN "+RetSqlName("VAM")+" VAM ON VAM.VAM_FILIAL='"+xFilial("VAM")+"' AND VAM.VAM_IBGE=SA1.A1_IBGE AND VAM.D_E_L_E_T_=' '"
cQuery += VR0100061_Monta_WHERE_SQL() // Monta WHERE com Filtros no SQL de levantamento das Frotas
cQuery += " GROUP BY SA1.A1_REGIAO , VAM.VAM_ESTADO , VAM.VAM_DESCID ,"
cQuery += "          VC3.VC3_CODMAR , VC3.VC3_MODVEI "
If lVC3SEGMOD
	cQuery += "    , VC3.VC3_SEGMOD "
EndIf
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlias, .F., .T. )
oReport:SetMeter((cQAlias)->(RecCount()))
While !((cQAlias)->(Eof())) .and. !oReport:Cancel()
	oReport:IncMeter()
	If cQuebReg <> (cQAlias)->( A1_REGIAO )
		cQuebReg := (cQAlias)->( A1_REGIAO )
		nPosReg := VR0110031_Posiciona_e_Add_Vetor( @aVetReg , (cQAlias)->( A1_REGIAO ) , left(FM_SQL("SELECT X5_DESCRI FROM "+RetSQLName("SX5")+" WHERE X5_FILIAL='"+xFilial("SX5")+"' AND X5_TABELA='A2' AND X5_CHAVE='"+(cQAlias)->( A1_REGIAO )+"' AND D_E_L_E_T_=' '"),30) )
	EndIf
	If cQuebUFM <> (cQAlias)->( VAM_ESTADO )
		cQuebUFM := (cQAlias)->( VAM_ESTADO )
		nPosUFM := VR0110031_Posiciona_e_Add_Vetor( @aVetUFM , (cQAlias)->( VAM_ESTADO ) , "" )
	EndIf
	If cQuebMun <> (cQAlias)->( VAM_DESCID )+(cQAlias)->( VAM_ESTADO )
		cQuebMun := (cQAlias)->( VAM_DESCID )+(cQAlias)->( VAM_ESTADO )
		nPosMun := VR0110031_Posiciona_e_Add_Vetor( @aVetMun , (cQAlias)->( VAM_DESCID ) , (cQAlias)->( VAM_ESTADO ) )
	EndIf
	If cCodMarca == (cQAlias)->( VC3_CODMAR ) // Marca Principal
		FGX_VV2( (cQAlias)->( VC3_CODMAR ) ,  (cQAlias)->( VC3_MODVEI ) , IIF( lVC3SEGMOD ,  (cQAlias)->( VC3_SEGMOD ) , "" ) )
		VR0110041_Totaliza_Vetores( .t. , VV2->VV2_GRUMOD , (cQAlias)->( QTD ) )
	Else // Outras Marcas
		VR0110041_Totaliza_Vetores( .f. , "" , (cQAlias)->( QTD ) )
	EndIf
	(cQAlias)->(dbSkip())
EndDo
(cQAlias)->(dbCloseArea())
//
VR0110051_Imprime_Vetores(@oSection1,aVetTOT)
VR0110051_Imprime_Vetores(@oSection2,aVetReg)
VR0110051_Imprime_Vetores(@oSection3,aVetUFM)
VR0110051_Imprime_Vetores(@oSection4,aVetMun)
//
DbSelectArea("VC3")
//
Return Nil

/*/{Protheus.doc} VR0110021_ColunasImpressao
	Colunas de Impressao

	@author Andre Luis Almeida
	@since 02/02/2021
/*/
Static Function VR0110021_ColunasImpressao( oReport , oSection , cDesc , cTit )

oSection := TRSection():New(oReport,cDesc,{}) // Resumo de Frotas
TRCell():New(oSection,"TOT_DESCRI",,cTit,"@!",30,, {|| cTOT_DESCRI } )
VR0100031_MontaColunas(@oSection,aFrotas,.f.) // Frotas

Return

/*/{Protheus.doc} VR0110031_Posiciona_e_Add_Vetor
	Posiciona ou Adiciona linha em branco no Vetor correspondente

	@author Andre Luis Almeida
	@since 02/02/2021
/*/
Static Function VR0110031_Posiciona_e_Add_Vetor( aVet , cQueb1 , cQueb2 )
Local nPos    := aScan(aVet,{ |x| x[1]+x[2] == cQueb1 + cQueb2 })
Local nCntFor := 0 
If nPos == 0
	aAdd(aVet,{	cQueb1 ,;
				cQueb2 ,;
				array(len(aFrotas[1])) ,;
				array(len(aFrotas[2])) })
	nPos := len(aVet)
	For nCntFor := 1 to len(aFrotas[1])
		aVet[nPos,3,nCntFor] := 0
	Next
	For nCntFor := 1 to len(aFrotas[2])
		aVet[nPos,4,nCntFor] := 0
	Next
EndIf
Return nPos

/*/{Protheus.doc} VR0110041_Totaliza_Vetores
	Totaliza no Vetor

	@author Andre Luis Almeida
	@since 02/02/2021
/*/
Static Function VR0110041_Totaliza_Vetores( lMarcaPrinc , cGruMod , nQtd )
Local nPos := 0
If lMarcaPrinc
	nPos := aScan(aFrotas[1],{ |x| x[1] == cGruMod })
	If nPos > 0
		aVetTOT[nPosTOT,3,nPos] += nQtd
		aVetReg[nPosReg,3,nPos] += nQtd
		aVetUFM[nPosUFM,3,nPos] += nQtd
		aVetMun[nPosMun,3,nPos] += nQtd
	EndIf
	nPos := 1 // Marca Principal
	aVetTOT[nPosTOT,4,nPos] += nQtd
	aVetReg[nPosReg,4,nPos] += nQtd
	aVetUFM[nPosUFM,4,nPos] += nQtd
	aVetMun[nPosMun,4,nPos] += nQtd
Else
	nPos := 2 // Outras Marcas
	aVetTOT[nPosTOT,4,nPos] += nQtd
	aVetReg[nPosReg,4,nPos] += nQtd
	aVetUFM[nPosUFM,4,nPos] += nQtd
	aVetMun[nPosMun,4,nPos] += nQtd
EndIf
nPos := 3 // Total Geral
aVetTOT[nPosTOT,4,nPos] += nQtd
aVetReg[nPosReg,4,nPos] += nQtd
aVetUFM[nPosUFM,4,nPos] += nQtd
aVetMun[nPosMun,4,nPos] += nQtd
//
Return

/*/{Protheus.doc} VR0110051_Imprime_Vetores
	Imprime Vetores

	@author Andre Luis Almeida
	@since 02/02/2021
/*/
Static Function VR0110051_Imprime_Vetores(oSec,aVet)
Local nPos    := 0
Local nCntFor := 0
Private cTOT_DESCRI := ""
oSec:Init()
For nPos := 1 to len(aVet)
	cTOT_DESCRI := Alltrim(aVet[nPos,1])+IIf(!Empty(aVet[nPos,2])," - "+aVet[nPos,2],"")
	For nCntFor := 1 to len(aFrotas[1])
		&("nGRP"+strzero(nCntFor,4)) := aVet[nPos,3,nCntFor]
	Next
	For nCntFor := 1 to len(aFrotas[2])
		&("nTOT"+strzero(nCntFor,4)) := aVet[nPos,4,nCntFor]
	Next
	oSec:PrintLine()
Next
oSec:Finish()
Return