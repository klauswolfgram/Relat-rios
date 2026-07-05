/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#INCLUDE "TECR013.CH"

Static cPerg := "TECR013"

User Function TECR013()
	U_TECR013()
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} TECR013

@author  Matheus Lando Raimundo
@version P12
@since 	 16/02/2017
@return 
/*/
//-------------------------------------------------/------------------------------------
user function TECR013()
	Local oReport
        
	If TRepInUse() 
		Pergunte(cPerg,.F.)	
		oReport := RepInit() 
		oReport:SetLandScape()
		oReport:PrintDialog()	
	EndIf
	
return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} RepInit
Função responsavel por elaborar o layout do relatorio a ser impresso

@version P12
/*/
//-------------------------------------------------------------------------------------
Static Function RepInit()
	Local oReport
	Local oSection1
	Local oSection2
	Local oBreak1 := Nil
	Local oBreak2 := Nil
	Local cPict   := PesqPict("ABX","ABX_VLMEDI")
	Local aTamTot := TamSx3("ABX_VLMEDI")
	Local nTam    := aTamTot[1]

	oReport := TReport():New("TECR013",STR0001,cPerg,{|oReport| PrintReport(oReport)},STR0001) //"Faturamento Antecipado"
	oSection1 := TRSection():New(oReport	,STR0002,{"ABX"},,,,,,,.T.) //"Competencia"
	oSection2 := TRSection():New(oSection1	,STR0003,{"TFJ","ABX"},,,,,,,.T.) //"Faturamento"

	/*[ <oSection> := ] TRSection():New(<oParent>, [ <cTitle> ], [ \{<cTable>\} ], [ <aOrder> ] ,;
								 [ <.lLoadCells.> ], 6, [ <cTotalText> ], [ !<.lTotalInCol.> ], [ <.lHeaderPage.> ],;
								 [ <.lHeaderBreak.> ], [ <.lPageBreak.> ], [ <.lLineBreak.> ], [ <nLeftMargin> ],;
								 [ <.lLineStyle.> ], [ <nColSpace> ], [<.lAutoSize.>], [<cSeparator>],;
								 [ <nLinesBefore> ], [ <nCols> ], [ <nClrBack> ], [ <nClrFore> ])
								 */

	TRCell():New(oSection1,"ABX_MESANO"   ,"ABX",STR0002) //"Competencia"

	TRCell():New(oSection2,"ABX_CONTRT"   ,"ABX",STR0004) //"Contrato"
	TRCell():New(oSection2,"ABX_CONREV"   ,"ABX",STR0005) //"Revisao"
	TRCell():New(oSection2,"ABX_CODPLA"   ,"ABX",STR0006) //"Nr Planilha"
	TRCell():New(oSection2,"ABX_VLMEDI"   ,"ABX",STR0007) //"Vlr Antecipado"
	TRCell():New(oSection2,"ABX_VLAPUR"   ,"ABX",STR0008) //"Vlr Apur Comp Ant"
	TRCell():New(oSection2,"ABX_VLTOT"    ,""   ,STR0009,cPict,nTam,,,"RIGHT",,"RIGHT") //"Vlr Total"
	TRCell():New(oSection2,"ABX_PEDMD"    ,"ABX",STR0010) //"Ped Medicao"
	TRCell():New(oSection2,"ABX_NOTAMD"   ,""   ,STR0011) //"NF Medicao"
	TRCell():New(oSection2,"ABX_SERIEMD"  ,""   ,STR0012) //"Serie Medicao"
	TRCell():New(oSection2,"ABX_PEDAPU"   ,""   ,STR0013) //"Pedido Apuracao"
	TRCell():New(oSection2,"ABX_NOTAAPU"  ,""   ,STR0014) //"NF Apuracao"
	TRCell():New(oSection2,"ABX_SERIEAPU" ,""   ,STR0015) //"Serie Apuracao"

	oBreak1 := TRBreak():New( oSection1,{|| QRY_COM->ABX_MESANO} )
	oBreak2 := TRBreak():New( oSection2,{|| QRY_COM->ABX_MESANO} )

Return oReport


//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

@author  Matheus Lando Raimundo
@version P12
@since 	 16/02/2017
@return 
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport(oReport)
	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(1):Section(1)
	Local cQry      := ""
	Local cContrDe	:= MV_PAR01
	Local cContrAte := MV_PAR02
	Local cCompDe   := MV_PAR03
	Local cCompAte  := MV_PAR04
	Local oExec     := Nil

	//Busca os dados da Secao principal
	cQry := "SELECT ABX.ABX_MESANO, ABX.ABX_CONTRT, ABX.ABX_CODPLA, ABX.ABX_CONREV, ABX.ABX_VLMEDI, ABX.ABX_VLAPUR, ABX.ABX_VLMEDI + ABX.ABX_VLAPUR ABX_VLTOT, "
	cQry += 	"C5.C5_NUM ABX_PEDMD, C5.C5_NOTA ABX_NOTAMD, C5.C5_SERIE ABX_SERIEMD, "
	cQry += 	"CASE "
	cQry += 		"WHEN ABX.ABX_CODTFV <> ' ' THEN ABX.ABX_PEDIDO "
	cQry += 		"ELSE ' ' "
	cQry += 	"END ABX_PEDAPU, "
	cQry += 	"D2.D2_DOC ABX_NOTAAPU, D2.D2_SERIE ABX_SERIEAPU "
	cQry += "FROM ? ABX "
	cQry += 	"LEFT JOIN ? D2 ON D2.D2_FILIAL = ? AND D2.D_E_L_E_T_ = ' ' AND ABX.ABX_CODTFV <> '' AND D2.D2_PEDIDO = ABX.ABX_PEDIDO AND D2.D2_ITEMPV = ABX.ABX_PEDITE "
	cQry += 	"LEFT JOIN ? C5 ON C5.C5_FILIAL = ? AND C5.D_E_L_E_T_ = ' ' AND ABX.ABX_NUMMED <> '' AND C5.C5_MDCONTR = ABX.ABX_CONTRT AND C5.C5_MDNUMED = ABX.ABX_NUMMED AND C5.C5_MDPLANI = ABX.ABX_CODPLA "
	cQry += "WHERE ABX.ABX_FILIAL = ? "
	cQry += "AND ABX.D_E_L_E_T_ = ' ' "
	cQry += "AND ABX.ABX_CONTRT BETWEEN ? AND ? "
	cQry += "AND ABX.ABX_MESANO BETWEEN ? AND ? "
	cQry += "AND ABX.ABX_CODPLA <> ' ' "
	cQry += "ORDER BY ABX_MESANO, ABX_CONTRT "

	cQry := ChangeQuery( cQry )
	oExec := FwExecStatement():New(cQry)

	oExec:SetUnsafe(  1, RetSqlName("ABX") )
	oExec:SetUnsafe(  2, RetSqlName("SD2") )
	oExec:SetString(  3, xFilial("SD2") )
	oExec:SetUnsafe(  4, RetSqlName("SC5") )
	oExec:SetString(  5, xFilial("SC5") )
	oExec:SetString(  6, xFilial("ABX") )
	oExec:SetString(  7, cContrDe )
	oExec:SetString(  8, cContrAte )
	oExec:SetString(  9, cCompDe )
	oExec:SetString( 10, cCompAte )

	cQry := oExec:GetFixQuery()
	oExec:OpenAlias("QRY_COM")

	oSection1:SetQuery("QRY_COM", cQry)
	oSection1:SetParentQuery(.F.)

	oSection1:Init()
	While QRY_COM->(!Eof())

	 	cCompet := QRY_COM->(ABX_MESANO)
	 	oSection1:PrintLine()

	 	oSection2:SetParentQuery(.F.)
	 	oSection2:Init()
	 	While cCompet == QRY_COM->(ABX_MESANO)
			oSection2:Cell("ABX_CONTRT"):SetBlock( {||QRY_COM->(ABX_CONTRT) } )
			oSection2:Cell("ABX_CONREV"):SetBlock( {||QRY_COM->(ABX_CONREV) } )
			oSection2:Cell("ABX_CODPLA"):SetBlock( {||QRY_COM->(ABX_CODPLA) } )
			oSection2:Cell("ABX_VLMEDI"):SetBlock( {||QRY_COM->(ABX_VLMEDI) } )
			oSection2:Cell("ABX_VLAPUR"):SetBlock( {||QRY_COM->(ABX_VLAPUR) } )
			oSection2:Cell("ABX_VLTOT"):SetBlock( {||QRY_COM->(ABX_VLTOT) } )
			oSection2:Cell("ABX_PEDMD"):SetBlock( {||QRY_COM->(ABX_PEDMD) } )
			oSection2:Cell("ABX_NOTAMD"):SetBlock( {||QRY_COM->(ABX_NOTAMD) } )
			oSection2:Cell("ABX_SERIEMD"):SetBlock( {||QRY_COM->(ABX_SERIEMD) } )
			oSection2:Cell("ABX_PEDAPU"):SetBlock( {||QRY_COM->(ABX_PEDAPU) } )
			oSection2:Cell("ABX_NOTAAPU"):SetBlock( {||QRY_COM->(ABX_NOTAAPU) } )
			oSection2:Cell("ABX_SERIEAPU"):SetBlock( {||QRY_COM->(ABX_SERIEAPU) } )
			oSection2:PrintLine()
			QRY_COM->(dbSkip())
		EndDo
	EndDo
	QRY_COM->(DbCloseArea())
	oExec:Destroy()
	FwFreeObj(oExec)
Return
