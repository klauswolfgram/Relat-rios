/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "TECR800A.ch"
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'REPORT.CH'

//------------------------------------------------------------------------------
/*/{Protheus.doc} TECR800
Relatório TReport para impressão de apurações

@sample 	U_TECR800A()
@author     Matheus Lando Raimundo
@since		24/04/2018
@version	P12
/*/
//------------------------------------------------------------------------------
User Function TECR800A()

	Local oBreakTFV := Nil
	Local oBreakTIP := Nil
	Local oReport   := Nil
	Local oSection1 := Nil
	Local oSection2 := Nil

	Pergunte('TECR800A',.F.)

	DEFINE REPORT oReport NAME 'TECR800A' TITLE STR0001 PARAMETER 'TECR800A' ACTION {|oReport| PrintReport(oReport)}

		oReport:HideParamPage() //inibe a impressão da página de parâmetros
		oReport:SetLandscape()  //Escolher o padrão de Impressao como Paisagem

		oSection1 := TRSection():New(oReport   ,STR0001,  {"TFV"},,,,,,,.T.) //"Apurações"
		oSection2 := TRSection():New(oSection1 ,STR0002,  {"TIP"},,,,,,,.T.) //"Bases de atendimento"


		DEFINE CELL NAME 'TFV_CONTRT' OF oSection1 ALIAS 'TFV'
		DEFINE CELL NAME 'TFV_REVISA' OF oSection1 ALIAS 'TFV' TITLE STR0007
		DEFINE CELL NAME 'TFV_CODIGO' OF oSection1 ALIAS 'TFV'
		DEFINE CELL NAME 'TFV_DTINI'  OF oSection1 ALIAS 'TFV' TITLE STR0003 //'Dt início Apuração'
		DEFINE CELL NAME 'TFV_DTFIM'  OF oSection1 ALIAS 'TFV' TITLE STR0004 //'Dt fim Apuração'
		DEFINE CELL NAME 'B1_COD'     OF oSection1 ALIAS 'SB1' TITLE STR0005 //'Produto'
		DEFINE CELL NAME 'B1_DESC'    OF oSection1 ALIAS 'SB1'
		DEFINE CELL NAME 'TFZ_MODCOB' OF oSection1 ALIAS 'TFZ'
		DEFINE CELL NAME 'TFZ_TOTAL'  OF oSection1 ALIAS 'TFZ'
		DEFINE CELL NAME 'TIP_CODEQU' OF oSection2 ALIAS 'TIP' TITLE STR0006 //'Equipamento(s)'

		oBreakTFV := TRBreak():New( oSection1,{|| (cAliasTFV)->RECTFZ } )
		oBreakTIP := TRBreak():New( oSection2,{|| (cAliasTFV)->RECTFZ  } )

		TRFunction():New(oSection1:Cell("TFZ_TOTAL"),/*cID*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

	oReport:PrintDialog()

Return

//------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Função que faz o controle de impressão do relatório
Relatório TReport para impressão de apurações

@sample 	U_TECR800A()
@author     Matheus Lando Raimundo
@since		24/04/2018
@version	P12
/*/
//------------------------------------------------------------------------------
Static Function PrintReport(oReport)

	Static cAliasTFV := ""
	Local cAliasTIP  := ""
	Local cExpFil    := " "
	Local cQry       := ""
	Local cQry2      := ""
	Local nNum       := 1
	Local oExec      := Nil
	Local oSection1  := oReport:Section(1)
	Local oSection2  := oReport:Section(1):Section(1)


	If !Empty(MV_PAR01) //Cliente de
		cExpFil += " AND ABS.ABS_ENTIDA = '1' AND ABS.ABS_CODIGO >= '" + MV_PAR01 + "' "
	EndIf

	If !Empty(MV_PAR02) //Loja de
		cExpFil += " AND ABS.ABS_ENTIDA = '1' AND ABS.ABS_LOJA >= '" + MV_PAR02  + "' "
	EndIf

	If !Empty(MV_PAR03) //Cliente até
		cExpFil += " AND ABS.ABS_ENTIDA = '1' AND ABS.ABS_CODIGO <= '" + MV_PAR03 + "' "
	EndIf

	If !Empty(MV_PAR04) //Loja até
		cExpFil += " AND ABS.ABS_ENTIDA = '1' AND ABS.ABS_LOJA <= '" + MV_PAR04  + "' "
	EndIf

	If !Empty(MV_PAR05) //Contrato de
		cExpFil +=  " AND TFV.TFV_CONTRT >= '" + MV_PAR05 + "' "
	EndIf

	If !Empty(MV_PAR06) //Contrato até
		cExpFil += " AND TFV.TFV_CONTRT <= '" + MV_PAR06 + "' "
	EndIf

	If !Empty(MV_PAR07) //Data de
		cExpFil += " AND TFV.TFV_DTINI >= '" + DToS(MV_PAR07) + "' "
	EndIf

	If !Empty(MV_PAR08) //Data até
		cExpFil +=  " AND TFV.TFV_DTFIM <= '" + DToS(MV_PAR08) + "' "
	EndIf

	If !Empty(MV_PAR09) //Produto de
		cExpFil +=  " AND TFI_PRODUT >= '" + MV_PAR09 + "' "
	EndIf

	If !Empty(MV_PAR10) //Produto até
		cExpFil +=  " AND TFI_PRODUT <= '" + MV_PAR10 + "' "
	EndIf

		cQry := "SELECT "
		cQry += "	TFZ.R_E_C_N_O_ RECTFZ, "
		cQry += "	TFV.TFV_CONTRT, "
		cQry += "	TFV.TFV_REVISA, "
		cQry += "	TFV.TFV_CODIGO, "
		cQry += "	TFV.TFV_DTINI, "
		cQry += "	TFV.TFV_DTFIM, "
		cQry += "	B1_COD, "
		cQry += "	B1_DESC, "
		cQry += "	TFZ_MODCOB, "
		cQry += "	TFZ_TOTAL "
		cQry += "FROM ? TFZ "
		cQry += "	INNER JOIN ? TFV ON TFV_FILIAL = ? "
		cQry += "		AND TFZ.TFZ_APURAC = TFV.TFV_CODIGO "
		cQry += "		AND TFV.D_E_L_E_T_ = ' ' "
		cQry += "	INNER JOIN ? TFI ON TFI_FILIAL = ? "
		cQry += "		AND TFZ.TFZ_CODTFI = TFI.TFI_COD "
		cQry += "		AND TFI.D_E_L_E_T_ = ' ' "
		cQry += "	INNER JOIN ? TFL ON TFL_FILIAL = ? "
		cQry += "		AND TFI.TFI_CODPAI = TFL.TFL_CODIGO "
		cQry += "		AND TFL.D_E_L_E_T_ = ' ' "
		cQry += "	INNER JOIN ? ABS ON ABS_FILIAL = ? "
		cQry += "		AND TFL.TFL_LOCAL = ABS.ABS_LOCAL "
		cQry += "		AND ABS.D_E_L_E_T_ = ' ' "
		cQry += "	INNER JOIN ? SB1 ON B1_FILIAL = ? "
		cQry += "		AND TFI.TFI_PRODUT = B1_COD "
		cQry += "		AND SB1.D_E_L_E_T_ = ' ' "
		cQry += "WHERE "
		cQry += "	TFZ.TFZ_FILIAL = ? "
		cQry += "	AND TFZ_TOTAL > 0 "
		cQry += " ? "
		cQry += "	AND TFV.D_E_L_E_T_ = ' ' "
		cQry += "ORDER BY "
		cQry += "	TFV.TFV_CONTRT, "
		cQry += "	TFV.TFV_REVISA, "
		cQry += "	TFV.TFV_DTINI, "
		cQry += "	TFV.TFV_DTFIM "

	oExec := FwExecStatement():New( cQry )
	oExec:SetUnsafe( nNum++, RetSqlName("TFZ") )
	oExec:SetUnsafe( nNum++, RetSqlName("TFV") )
	oExec:SetString( nNum++, FwxFilial("TFV") )
	oExec:SetUnsafe( nNum++, RetSqlName("TFI") )
	oExec:SetString( nNum++, FwxFilial("TFI") )
	oExec:SetUnsafe( nNum++, RetSqlName("TFL") )
	oExec:SetString( nNum++, FwxFilial("TFL") )
	oExec:SetUnsafe( nNum++, RetSqlName("ABS") )
	oExec:SetString( nNum++, FwxFilial("ABS") )
	oExec:SetUnsafe( nNum++, RetSqlName("SB1") )
	oExec:SetString( nNum++, FwxFilial("SB1") )
	oExec:SetString( nNum++, FwxFilial("TFZ") )
	oExec:SetUnsafe( nNum++, cExpFil )

	cAliasTFV := oExec:OpenAlias()
	oExec:Destroy()
	FreeObj(oExec)
	(cAliasTFV)->(DbGoTop())

	oSection1:SetParentQuery(.F.)
	oSection1:Init()

	While (cAliasTFV)->(!Eof())

		oSection1:PrintLine()

		If MV_PAR11 == 1
			oSection2:SetParentQuery(.F.)
			oSection2:Init()

			cQry2 := "SELECT TIP_CODEQU "
			cQry2 += "FROM ? TIP "
			cQry2 += "	INNER JOIN ? AA3 ON AA3_FILIAL = ? "
			cQry2 += "	AND AA3_CODPRO = ? "
			cQry2 += "	AND AA3_NUMSER = TIP_CODEQU "
			cQry2 += "	AND AA3.D_E_L_E_T_ = ' ' "
			cQry2 += "WHERE "
			cQry2 += "TIP_FILIAL = ? "
			cQry2 += "AND TIP_ITAPUR = ? " 
			cQry2 += "AND TIP_CODEQU <> ' ' "
			cQry2 += "AND TIP.D_E_L_E_T_ = ' ' "

			oExec := FwExecStatement():New( cQry2 )
			oExec:SetUnsafe( 1, RetSqlName("TIP") )
			oExec:SetUnsafe( 2, RetSqlName("AA3") )
			oExec:SetString( 3, FwxFilial("AA3") )
			oExec:SetString( 4, (cAliasTFV)->B1_COD )
			oExec:SetString( 5, FwxFilial("TIP") )
			oExec:SetString( 6, (cAliasTFV)->TFV_CODIGO )

			cAliasTIP := oExec:OpenAlias()
			oExec:Destroy()
			FreeObj(oExec)
			(cAliasTIP)->(DbGoTop())

			While (cAliasTIP)->(!Eof())
				oSection2:PrintLine()
				(cAliasTIP)->(dbSkip())
			EndDo
		EndIf
		(cAliasTFV)->(dbSkip())
	EndDo

Return
