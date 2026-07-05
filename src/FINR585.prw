/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma pr�tica e de f�cil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR585.CH"     
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} FINR585
Relatorio que formaliza a liberacao para pagamento de um titulo a pagar.

@sample		U_FINR585()
@Return		
@author		Fabricio Romera
@since		07/24/10
@version	12
/*/
//-------------------------------------------------------------------

User Function FINR585()

	Local oReport	:= Nil

	oReport := ReportDef()
	oReport:PrintDialog()
	
	cAlias := ""

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define relatorio de liberação de documentos.

@sample		oReport := ReportDef()
@Return		oReport - objeto do TRepot
@author		Fabricio Romera
@since		07/24/10
@version	12
/*/
//-------------------------------------------------------------------

Static Function ReportDef()

	Local oReport	:= Nil
	Local oSection1	:= Nil
	Local oSection2	:= Nil
	Local oSection3	:= Nil
	Local oBreak1	:= Nil
	Local bValorLib	:= {|| If(Empty(E2_DATALIB), 0, E2_VALOR) }
	Local bValorCan	:= {|| If(Empty(E2_DATACAN), 0, E2_VALOR) }
	Local bHistorLib:= {|| GetHistFI2(E2_NUMBOR,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_FORNECE,E2_LOJA, "E2_DATALIB") }
	Local bHistorCan:= {|| GetHistFI2(E2_NUMBOR,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_FORNECE,E2_LOJA, "E2_DATACAN") }

	Pergunte("FINR585R01",.F.)
	
	oReport := TReport():New( "FINR585", STR0001, "FINR585R01", { |oReport| PrintReport(oReport) }, , , , , , , .T., )
	
	oSection1 := TRSection():New(	oReport, STR0003, { "SE2" }, , , , , , , , .T., , 2, , , , , 0, , , , )

	TRCell():New( oSection1,	"E2_FILIAL",	,	STR0006, PesqPict("SE2","E2_FILIAL"),	TamSX3("E2_FILIAL")[1],			.F., {|| (cAlias)->E2_FILIAL }			) //"FILIAL"
	TRCell():New( oSection1,	"E2_PREFIXO",	,	STR0007, PesqPict("SE2","E2_PREFIXO"),	TamSX3("E2_PREFIXO")[1],		.F., {|| (cAlias)->E2_PREFIXO }			) //"PREFIXO"
	TRCell():New( oSection1,	"E2_NUM",		,	STR0008, PesqPict("SE2","E2_NUM"),		TamSX3("E2_NUM")[1],			.F., {|| (cAlias)->E2_NUM }				) //"NUMERO"
	TRCell():New( oSection1,	"E2_PARCELA",	,	STR0009, PesqPict("SE2","E2_PARCELA"),	TamSX3("E2_PARCELA")[1],		.F., {|| (cAlias)->E2_PARCELA }			) //"PARCELA"
	TRCell():New( oSection1,	"E2_TIPO",		,	STR0010, PesqPict("SE2","E2_TIPO"),		TamSX3("E2_TIPO")[1],			.F., {|| (cAlias)->E2_TIPO }			) //"TIPO"
	TRCell():New( oSection1,	"E2_FORNECE",	,	STR0011, PesqPict("SE2","E2_FORNECE"),	TamSX3("E2_FORNECE")[1],		.F., {|| (cAlias)->E2_FORNECE }			) //"FORNECEDOR"
	TRCell():New( oSection1,	"E2_LOJA",		,	STR0012, PesqPict("SE2","E2_LOJA"),		TamSX3("E2_LOJA")[1],			.F., {|| (cAlias)->E2_LOJA }			) //"LOJA"
	TRCell():New( oSection1,	"E2_MDCONTR",	,	STR0014, PesqPict("SE2","E2_MDCONTR"),	TamSX3("E2_MDCONTR")[1],		.F., {|| (cAlias)->E2_MDCONTR }			) //"CONTRATO"
	TRCell():New( oSection1,	"E2_EMISSAO",	,	STR0015, PesqPict("SE2","E2_EMISSAO"),	TamSX3("E2_EMISSAO")[1] + 5,	.F., {|| SToD( (cAlias)->E2_EMISSAO ) }	) //"EMISSAO"
	TRCell():New( oSection1,	"E2_VENCTO",	,	STR0016, PesqPict("SE2","E2_VENCTO"),	TamSX3("E2_VENCTO")[1] + 5,		.F., {|| SToD( (cAlias)->E2_VENCTO ) }	) //"VENCTO"
	TRCell():New( oSection1,	"E2_VENCREA",	,	STR0017, PesqPict("SE2","E2_VENCREA"),	TamSX3("E2_VENCREA")[1] + 5,	.F., {|| SToD( (cAlias)->E2_VENCREA ) }	) //"VENCTO REAL"
	TRCell():New( oSection1,	"E2_MOEDA",		,	STR0018, PesqPict("SE2","E2_MOEDA"),	TamSX3("E2_MOEDA")[1],			.F., {|| (cAlias)->E2_MOEDA }			) //"MOEDA"
	TRCell():New( oSection1,	"E2_VALOR",		,	STR0019, PesqPict("SE2","E2_VALOR"),	TamSX3("E2_VALOR")[1],			.F., {|| (cAlias)->E2_VALOR }			) //"VALOR"
	
	oBreak1 := TRBreak():New( oSection1, oSection1:Cell("E2_NUM"), , .T., , .F. )
	
	//DADOS AUTORIZACAO
	oSection2 := TRSection():New(	oSection1, STR0003, , , , , , , , , , , 2, , , , , 2, , , , )

	TRCell():New( oSection2,	"E2_DATALIB",	,	STR0020, PesqPict("SE2","E2_DATALIB"),	TamSX3("E2_DATALIB")[1] + 5,	.F.,	{|| SToD( (cAlias)->E2_DATALIB ) }	) //"DATA AUTORIZAÇÃO"
	TRCell():New( oSection2,	"E2_VALOR",		,	STR0021, PesqPict("SE2","E2_VALOR"),	TamSX3("E2_VALOR")[1], 			.F.,	bValorLib							) //"VALOR LIBERADO"
	TRCell():New( oSection2,	"E2_USUALIB",	,	STR0023, PesqPict("SE2","E2_USUALIB"),	TamSX3("E2_USUALIB")[1],		.F.,	{|| (cAlias)->E2_USUALIB }			) //"USUÁRIO"
	TRCell():New( oSection2,	"E2_APROVA",	,	STR0024, PesqPict("SE2","E2_APROVA"),	TamSX3("E2_APROVA")[1],			.F.,	{|| (cAlias)->E2_APROVA }			) //"APROVADOR"
	TRCell():New( oSection2,	"E2_STATUS",	,	STR0025, PesqPict("SE2","E2_STATUS"),	TamSX3("E2_STATUS")[1],			.F.,	{|| (cAlias)->E2_STATUS }			) //"STATUS"
	TRCell():New( oSection2,	"FI2_HISTOR",	,	STR0026, PesqPict("FI2","FI2_HISTOR"),	TamSX3("FI2_HISTOR")[1],		.F.,	bHistorLib							) //"COMENTARIOS AUTORIZAÇÃO"

	//DADOS CANCELAMENTO
	oSection3 := TRSection():New( oSection2, STR0005, , , , , , , , , , , 2, , , , , 2, , , , )

	TRCell():New( oSection3,	"E2_DATACAN",	,	STR0027, PesqPict("SE2","E2_DATACAN"),	TamSX3("E2_DATACAN")[1] + 5,	.F.,	{|| SToD( (cAlias)->E2_DATACAN ) }	) //"DATA CANCELAMENTO"
	TRCell():New( oSection3,	"E2_VALOR",		,	STR0028, PesqPict("SE2","E2_VALOR"),	TamSX3("E2_VALOR")[1],			.F.,	bValorCan							) //"VALOR CANCELADO"
	TRCell():New( oSection3,	"E2_USUACAN",	,	STR0029, PesqPict("SE2","E2_USUACAN"),	TamSX3("E2_USUACAN")[1],		.F.,	{|| (cAlias)->E2_USUACAN }			) //"USUÁRIO"
	TRCell():New( oSection3,	"E2_APROVA",	,	STR0030, PesqPict("SE2","E2_APROVA"),	TamSX3("E2_APROVA")[1],			.F.,	{|| (cAlias)->E2_APROVA }			) //"APROVADOR"
	TRCell():New( oSection3,	"E2_HIST",		,	STR0031, PesqPict("SE2","E2_HIST"),		TamSX3("E2_HIST")[1],			.F.,	bHistorCan							) //"COMENTARIOS CANCELAMENTO"
	
Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Traz dados do relatorio de liberacao de documentos.

@sample		Local bHistorLib := { || GetHistFI2(E2_NUMBOR,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_FORNECE,E2_LOJA, "E2_DATALIB") }
@Return		
@author		Fabricio Romera
@since		07/24/10
@version	12
/*/
//-------------------------------------------------------------------

Static Function PrintReport(oReport)

	Local oSection1	:= oReport:Section(1)
	Local oSection2	:= oReport:Section(1):Section(1)
	Local oSection3	:= oReport:Section(1):Section(1):Section(1)
	Local cStatus	:= MV_PAR11
	Local cFiliali	:= If( MV_PAR12 == 1, MV_PAR13, xFilial("SE2") )
	Local cFilialf	:= If( MV_PAR12 == 1, MV_PAR14, xFilial("SE2") )
	Local cCampos	:= ""
	Local cQuery	:= ""
	Local cDtCan	:= Space( TamSX3("E2_DATACAN")[1] )
	Local cDtLib	:= Space( TamSX3("E2_DATALIB")[1] )
	Local nCont		:= 0
	Local cUserFltr	:= ""
	Local cAlias	:= GetNextAlias()
	
	If !Empty(oSection1:aUserFilter) // filtro de usuário
		cUserFltr := " AND " + StrTran( oSection1:aUserFilter[1][3], "E2_", "SE2.E2_" )
	EndIf
	
	For nCont := 1 To Len(oSection1:aCell)
		oSection1:aCell[nCont]:cAlias := cAlias
		If oSection1:aCell[nCont]:lUserField
			cCampos += ", SE2." + oSection1:aCell[nCont]:cName
		EndIf
	Next nCont

	For nCont := 1 To Len(oSection2:aCell)
		oSection2:aCell[nCont]:cAlias := cAlias
		If oSection2:aCell[nCont]:lUserField
			cCampos += ", SE2." + oSection2:aCell[nCont]:cName
		EndIf
	Next nCont

	For nCont := 1 To Len(oSection3:aCell)
		oSection3:aCell[nCont]:cAlias := cAlias
		If oSection3:aCell[nCont]:lUserField
			cCampos += ", SE2." + oSection3:aCell[nCont]:cName
		EndIf
	Next nCont

	cQuery := " SELECT "
	cQuery += " E2_FILIAL, E2_PREFIXO, E2_NUM, E2_PARCELA, "
	cQuery += " E2_TIPO, E2_FORNECE, E2_LOJA, E2_MDCONTR, "
	cQuery += " E2_EMISSAO, E2_VENCTO, E2_VENCREA, E2_MOEDA, "
	cQuery += " E2_VALOR, E2_DATALIB, E2_USUALIB, E2_STATUS, "
	cQuery += " E2_DATACAN, E2_USUACAN, E2_APROVA, E2_HIST, E2_NUMBOR "

	cQuery += cCampos

	cQuery += " FROM " + RetSQLName("SE2") + " SE2 "

	cQuery += " WHERE SE2.E2_FILIAL BETWEEN '" + cFiliali + "' AND '" + cFilialf + "'"
	cQuery += 	" AND SE2.E2_PREFIXO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'"
	cQuery += 	" AND SE2.E2_NUM BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'"
	cQuery += 	" AND SE2.E2_FORNECE BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "'"
	cQuery += 	" AND SE2.E2_EMISSAO BETWEEN '" + DToS(MV_PAR07) + "' AND '" + DToS(MV_PAR08) + "'"
	cQuery += 	" AND SE2.E2_VENCTO BETWEEN '" + DToS(MV_PAR09) + "' AND '" + DToS(MV_PAR10) + "'"
	
	If cStatus == 1 //Aguardando liberação
		cQuery += 	" AND SE2.E2_SALDO > 0 "
		cQuery += 	" AND SE2.E2_DATALIB = '" + cDtLib + "' "
		cQuery += 	" AND SE2.E2_DATACAN = '" + cDtCan + "' "

	ElseIf cStatus == 2 //Liberados
		cQuery += 	" AND SE2.E2_SALDO >= 0 "
		cQuery += 	" AND SE2.E2_DATALIB != '" + cDtLib + "' "
		cQuery += 	" AND SE2.E2_DATACAN = '" + cDtCan + "' "

	ElseIf cStatus == 3 //Cancelados
		cQuery += 	" AND SE2.E2_SALDO >= 0
		cQuery += 	" AND SE2.E2_DATACAN != '" + cDtCan + "' "
	EndIf

	If !Empty(cUserFltr)
		cQuery += 	cUserFltr
	EndIf

	cQuery +=			" AND SE2.D_E_L_E_T_ = ' ' "

	cQuery +=		" ORDER BY SE2.E2_NUM "
	
	cQuery := ChangeQuery(cQuery)

	DbUseArea( .T., "TOPCONN", TCGenQry( , , cQuery ), cAlias, .F., .T. )

	(cAlias)->( DbGoTop() )

	oSection2:SetParentQuery()
	oSection2:SetParentFilter( { |cParam| (cAlias)->( E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA) == cParam },;
												{ || (cAlias)->( E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA ) } )

    oSection3:SetParentQuery()
    oSection3:SetParentFilter( { |cParam| (cAlias)->( E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA) == cParam },;
												{ || (cAlias)->( E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA ) } )
	
	While (cAlias)->( !Eof() )

		oSection1:Init()
		oSection2:Init()
		oSection3:Init()
		
		oSection1:PrintLine()
		oSection2:PrintLine()
		oSection3:PrintLine()

		oSection3:Finish()
		oSection2:Finish()
		oSection1:Finish()

		oReport:SkipLine(4)
		
		(cAlias)->( DbSkip() )

	EndDo

	(cAlias)->( DbCloseArea() )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetHistFI2
Retorna string com o historico (FI2) de um titulo

@sample		Local bHistorLib := { || GetHistFI2(E2_NUMBOR,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_FORNECE,E2_LOJA, "E2_DATALIB") }
@Return		
@author		Fabricio Romera
@since		07/24/10
@version	12
/*/
//-------------------------------------------------------------------

Static Function GetHistFI2( cNumBor, cPrefixo, cTitulo, cParcela, cTipo, cFornec, cLoja, cCampo )

	Local aArea	:= GetArea()
	Local cChave:= ""
	Local cHist	:= ""
					
	cChave := xFilial("FI2") + "2" + cNumBor + cPrefixo + cTitulo + cParcela + cTipo + cFornec + cLoja

	DbSelectArea( "FI2" )
	FI2->( DbSetOrder( 3 ) )
	FI2->( DbSeek( cChave ) )

	While FI2->(!Eof()) .And. FI2->( FI2_FILIAL + "2" + FI2_NUMBOR + FI2_PREFIX + FI2_TITULO + FI2_PARCEL + FI2_TIPO + FI2_CODFOR + FI2_LOJFOR ) == cChave 

		If FI2->FI2_CAMPO = cCampo
			cHist += MSMM(FI2_HISTOR) + chr(10) + chr(13)
		End If           
		
		FI2->( DbSkip() )
	End

	RestArea(aArea)

Return AllTrim(cHist)