/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "PROTHEUS.CH"
#include "FINR917.CH"
#include "topconn.ch"

Static __cAliasTmp	As Character 
Static __cIDProc	As Character
Static __lQtdAlt    As Logical

//-------------------------------------------------------------------
/*/{Protheus.doc} FINR917
Relatorio Log de Importação SITEF

@author Igor Fricks
@since 10/04/2019
@version 12.1.17
/*/
//-------------------------------------------------------------------

User Function FINR917(cIDProc)

	Local oReport As Object

	Default cIDProc := ""

	oReport := NIL

	oReport := ReportDef()

	__cIDProc := cIDProc

	If Empty(Alltrim(__cIDProc))
		Pergunte( oReport:uParam, .F. )
	Else
		oReport:lParamReadOnly := .T.  //Desabilita a janela de parâmetros em outras ações
		oReport:HideParamPage() //Desabilita impressão de parâmetros
	End

	oReport:PrintDialog()
	oReport := NIL

	Return


	//-------------------------------------------------------------------
	/*/{Protheus.doc} ReportDef
	Relatorio Log de Importação SITEF

	@author Igor Fricks
	@since 10/04/2019
	@version 12.1.17
	/*/
	//-------------------------------------------------------------------

Static Function ReportDef() As Object

	Local oReport	As Object
	Local oDetalhe	As Object
	Local oLogImp	As Object
	
	__lQtdAlt		:= ( FVR->(ColumnPos( 'FVR_QTDALT' ) ) > 0 )
	__cAliasTmp := GetNextAlias()
	
	Pergunte("FINR917",.F.)

	//"Este programa ir  emitir o Log das Importações de Arquivos"
	oReport := TReport():New("FINR917",STR0001,"FINR917", {|oReport| ReportPrint(oReport)}, STR0002)

	oReport:SetUseGC( .T. )

	oReport:DisableOrientation( .T. )
	oReport:SetLandScape( .T. )

	//Dados da FVR
	oLogImp := TRSection():New(oReport, STR0003,,,,,,.T.) //"Dados do Log"
	TRCell():New(oLogImp,"MDE_DESC"	    , "FVR", AllTrim(RetTitle("FVR_NOMADM")),PesqPict("FVR","FVR_NOMADM"),TAMSX3("FVR_NOMADM")[1],.F.)	        //"Nome da Operadora"
	TRCell():New(oLogImp,"FVR_NOMARQ"	, "FVR", AllTrim(RetTitle("FVR_NOMARQ")),PesqPict("FVR","FVR_NOMARQ"),TAMSX3("FVR_NOMARQ")[1],.F.)	        //"Nome do Arquivo"
	TRCell():New(oLogImp,"FVR_DTPROC"	, "FVR", AllTrim(RetTitle("FVR_DTPROC")),PesqPict("FVR","FVR_DTPROC"),TAMSX3("FVR_DTPROC")[1],.F.)	        //"Data de Processamento"
	TRCell():New(oLogImp,"FVR_HRPROC"	, "FVR", AllTrim(RetTitle("FVR_HRPROC")),PesqPict("FVR","FVR_HRPROC"),TAMSX3("FVR_HRPROC")[1],.F.)	        //"Hora de Processamento"
	TRCell():New(oLogImp,"FVR_QTDPRO"	, "FVR", AllTrim(RetTitle("FVR_QTDPRO")),PesqPict("FVR","FVR_QTDPRO"),TAMSX3("FVR_QTDPRO")[1],,,,,"RIGHT")	//"Qtd de Registros Processadas"
	If __lQtdAlt
		TRCell():New(oLogImp,"FVR_QTDALT"	, "FVR", AllTrim(RetTitle("FVR_QTDALT")),PesqPict("FVR","FVR_QTDALT"),TAMSX3("FVR_QTDALT")[1],,,,,"RIGHT")	//"Qtd de Registros Editados"
	EndIf
	TRCell():New(oLogImp,"FVR_QTDINC"	, "FVR", AllTrim(RetTitle("FVR_QTDINC")),PesqPict("FVR","FVR_QTDINC"),TAMSX3("FVR_QTDINC")[1],,,,,"RIGHT")	//"Qtd de Registros não Processadas"
	TRCell():New(oLogImp,"FVR_QTDLIN"	, "FVR", AllTrim(RetTitle("FVR_QTDLIN")),PesqPict("FVR","FVR_QTDLIN"),TAMSX3("FVR_QTDLIN")[1],,,,,"RIGHT")	//"Qtd de Registros não Processadas"
	TRCell():New(oLogImp,"FVR_QTDTOT"	, "FVR", AllTrim(RetTitle("FVR_QTDTOT")),PesqPict("FVR","FVR_QTDTOT"),TAMSX3("FVR_QTDTOT")[1],,,,,"RIGHT")	//"Qtd de Registros não Processadas"
	TRCell():New(oLogImp,"NOMUSU"    	,      , AllTrim(RetTitle("FVR_NOMUSU")),PesqPict("FVR","FVR_NOMUSU"),TAMSX3("FVR_NOMUSU")[1],.F.)	        //"Nome do Usuário"
	TRCell():New(oLogImp,"FVR_DESCLE"	, "FVR", AllTrim(RetTitle("FVR_DESCLE")),PesqPict("FVR","FVR_DESCLE"),TAMSX3("FVR_DESCLE")[1],.F.,,,,"LEFT",.T.)//"Descrição da Legenda"

	TRBreak():New( oLogImp, {|| (__cAliasTmp)->FVR_IDPROC }, /**/, .F., /**/, .F., .F., .T. )
	oLogImp:SetHeaderBreak( .T. )

	//Dados do Filho FV3
	oDetalhe := TRSection():New(oLogImp, STR0004, {"FV3"} )			//"Detalhe do Log"
	TRCell():New(oDetalhe,"FV3_LINARQ"	, "FV3", AllTrim(RetTitle("FV3_LINARQ")),PesqPict("FV3","FV3_LINARQ"),23,.F.)	//"Linha do Arquivo"
	TRCell():New(oDetalhe,"FV3_CODEST"	, "FV3", AllTrim(RetTitle("FV3_CODEST")),PesqPict("FV3","FV3_CODEST"),20,.F.)	//"Código do Estabelecimento"
	TRCell():New(oDetalhe,"FV3_NUCOMP"	, "FV3", AllTrim(RetTitle("FV3_NUCOMP")),PesqPict("FV3","FV3_NUCOMP"),20,.F.)	//"Numero do Comprovante"
	TRCell():New(oDetalhe,"FV3_MOTIVO"	, "FV3", AllTrim(RetTitle("FV3_MOTIVO")),PesqPict("FV3","FV3_MOTIVO"),,,,,,"LEFT",.T.)			//"Motivo"

	TRBreak():New( oDetalhe, {||(__cAliasTmp)->FV3_IDPROC }, /**/, .F., /**/, .F., .F., .T. )
	oDetalhe:SetHeaderBreak( .T. )

	oLogImp:SetAutoSize()
	oLogImp:Cell("FVR_DESCLE"):SetLineBreak(.T.)

	Return oReport


	//-------------------------------------------------------------------
	/*/{Protheus.doc} ReportDef
	Relatorio Log de Importação SITEF

	@author Igor Fricks
	@since 10/04/2019
	@version 12.1.17
	/*/
	//-------------------------------------------------------------------

Static Function ReportPrint( oReport As Object)

	Local oLogImp		As Object
	Local oDetalhe		As Object
	Local cQryImp		As Character
	Local cIDProcAnt    As Character
	Local cAdmFinan     As Character
	Local cUserImp      As Character
	Local aStruct		As Array

	aStruct		:= {}
	oLogImp		:= oReport:Section(1)
	oDetalhe	:= oReport:Section(1):Section(1)
	cIDProcAnt	:= ""

	If Empty(Alltrim(__cIDProc))
		MakeSqlExpr(oReport:uParam) // Transforma parametros Range em expressao SQL
	EndIf

	cAdmFinan	:= Iif(!Empty(Alltrim(MV_PAR03)), FormatIn(Alltrim(MV_PAR03), ";"), "")
	cUserImp    := MV_PAR06

	//Query do relatório
	aAdd( aStruct, {'FVR_IDPROC','C',TamSX3('FVR_NOMARQ')[1],0						} )
	aAdd( aStruct, {'FVR_NOMARQ','C',TamSX3('FVR_NOMARQ')[1],0						} )
	aAdd( aStruct, {'FVR_DTPROC','D',TamSX3('FVR_DTPROC')[1],0						} )
	aAdd( aStruct, {'FVR_HRPROC','C',TamSX3('FVR_HRPROC')[1],0						} )
	aAdd( aStruct, {'FVR_QTDPRO','N',TamSX3('FVR_QTDPRO')[1],TamSX3('FVR_QTDPRO')[2]} )
	aAdd( aStruct, {'FVR_QTDINC','N',TamSX3('FVR_QTDINC')[1],TamSX3('FVR_QTDINC')[2]} )
	If __lQtdAlt
		aAdd( aStruct, {'FVR_QTDALT','N',TamSX3('FVR_QTDALT')[1],TamSX3('FVR_QTDALT')[2]} )
	EndIf
	aAdd( aStruct, {'FVR_QTDLIN','N',TamSX3('FVR_QTDLIN')[1],TamSX3('FVR_QTDLIN')[2]} )
	aAdd( aStruct, {'FVR_QTDTOT','N',TamSX3('FVR_QTDTOT')[1],TamSX3('FVR_QTDTOT')[2]} )
	aAdd( aStruct, {'MDE_DESC'  ,'C',TamSX3('FVR_NOMADM')[1],0						} )
	aAdd( aStruct, {'NOMUSU'    ,'C',TamSX3('FVR_NOMUSU')[1],0						} )
	aAdd( aStruct, {'FVR_DESCLE','C',TamSX3('FVR_DESCLE')[1],0						} )
	aAdd( aStruct, {'FV3_IDPROC','C',TamSX3('FV3_IDPROC')[1],0						} )
	aAdd( aStruct, {'FV3_LINARQ','C',TamSX3('FV3_LINARQ')[1],0						} )
	aAdd( aStruct, {'FV3_CODEST','C',TamSX3('FV3_CODEST')[1],0						} )
	aAdd( aStruct, {'FV3_NUCOMP','C',TamSX3('FV3_NUCOMP')[1],0						} )
	aAdd( aStruct, {'FV3_MOTIVO','C',TamSX3('FV3_MOTIVO')[1],0						} )

	cQryImp := " SELECT FVR_IDPROC, FVR_NOMARQ, FVR_DTPROC, FVR_HRPROC, FVR_QTDPRO, FVR_QTDINC,FVR_QTDLIN,FVR_QTDTOT, FVR_CODADM, FVR_DESCLE, FVR_CODUSU NOMUSU, FV3_IDPROC, FV3_LINARQ, FV3_CODEST, FV3_NUCOMP, FV3_MOTIVO, MDE_DESC "
	If __lQtdAlt
		cQryImp += " ,FVR_QTDALT " 
	EndIf
	cQryImp += " FROM (" + RetSqlName('FVR') + " FVR LEFT JOIN  " + RetSqlName('FV3') + " FV3 ON FVR_FILIAL = FV3_FILIAL AND FVR_IDPROC = FV3_IDPROC AND FV3.D_E_L_E_T_= ' ' ) "
	cQryImp += "  INNER JOIN " + AllTrim(RetSqlName("MDE")) + " MDE "
	cQryImp += "   ON MDE_FILIAL = '" + xFilial("MDE") + "' "
	cQryImp += "   AND MDE_CODIGO = FVR_CODADM "
	cQryImp += "   AND MDE_TIPO = 'RD' "
	cQryImp += "   AND MDE.D_E_L_E_T_ = ' ' "

	cQryImp += " WHERE FVR.D_E_L_E_T_= ' ' "

	If Empty(Alltrim(__cIDProc))
		cQryImp += "   AND FVR_NOMARQ BETWEEN '" + ALLTRIM(MV_PAR01) + "' AND '" + MV_PAR02 + "' "
		cQryImp += "   AND FVR_DTPROC BETWEEN '" + DTOS(MV_PAR03)+ "' AND '"+ DTOS(MV_PAR04) + "' "

		If !Empty(cAdmFinan) //MV_PAR05
			cQryImp += " AND FVR_CODADM IN " + cAdmFinan
		EndIf

		If !Empty(cUserImp)  //MV_PAR06
			cQryImp += "   AND " + cUserImp
		EndIf
	Else
		cQryImp += "   AND FVR_IDPROC = '" + __cIDProc	+ "' "
	EndIf

	cQryImp += " ORDER BY FVR_CODADM, FVR_NOMARQ, FV3_LINARQ "

	cQryImp := ChangeQuery( cQryImp )

	oTempTable := FwTemporaryTable():New( __cAliasTmp )

	oTempTable:SetFields( aStruct )
	oTempTable:AddIndex('1', {'FVR_IDPROC', 'FV3_LINARQ'})
	oTempTable:Create()

	SqlToTrb( cQryImp, aStruct, __cAliasTmp )

	DbSetOrder(0) // Fica na ordem da query

	( __cAliasTmp )->( DbGoTop() )

	If ( __cAliasTmp )->( Eof() )

		oTempTable:Delete()

	Else

		( __cAliasTmp )->( DbGoTop() )

		oLogImp:Init()
		oReport:SetTitle(STR0005)

		oReport:SetMeter(0)

		While !( __cAliasTmp )->( Eof() )

			If cIDProcAnt <> ( __cAliasTmp )->FVR_IDPROC

				If !Empty(cIDProcAnt)
					oReport:SkipLine(3)
				EndIf

				oLogImp:Cell("MDE_DESC"   	):SetPicture(X3Picture("MDE_DESC"))
				oLogImp:Cell("FVR_NOMARQ" 	):SetPicture(X3Picture("FVR_NOMARQ"))
				oLogImp:Cell("FVR_DTPROC"	):SetPicture(X3Picture("FVR_DTPROC"))
				oLogImp:Cell("FVR_HRPROC"	):SetPicture(X3Picture("FVR_HRPROC"))
				oLogImp:Cell("FVR_QTDPRO"	):SetPicture(X3Picture("FVR_QTDPRO"))
				If __lQtdAlt
					oLogImp:Cell("FVR_QTDALT"	):SetPicture(X3Picture("FVR_QTDALT"))
				EndIf
				oLogImp:Cell("FVR_QTDINC"	):SetPicture(X3Picture("FVR_QTDINC"))
				oLogImp:Cell("FVR_QTDLIN"	):SetPicture(X3Picture("FVR_QTDLIN"))
				oLogImp:Cell("FVR_QTDTOT"	):SetPicture(X3Picture("FVR_QTDTOT"))
				oLogImp:Cell("FVR_DESCLE"	):SetPicture(X3Picture("FVR_DESCLE"))

				oLogImp:Cell("MDE_DESC"	    ):SetValue(( __cAliasTmp )->MDE_DESC)
				oLogImp:Cell("FVR_NOMARQ" 	):SetValue(( __cAliasTmp )->FVR_NOMARQ)
				oLogImp:Cell("FVR_DTPROC"	):SetValue(DTOC(( __cAliasTmp )->FVR_DTPROC))
				oLogImp:Cell("FVR_HRPROC"	):SetValue(( __cAliasTmp )->FVR_HRPROC)
				oLogImp:Cell("FVR_QTDPRO"	):SetValue(( __cAliasTmp )->FVR_QTDPRO)
				If __lQtdAlt
					oLogImp:Cell("FVR_QTDALT"	):SetValue(( __cAliasTmp )->FVR_QTDALT)
				EndIf				
				oLogImp:Cell("FVR_QTDINC"	):SetValue(( __cAliasTmp )->FVR_QTDINC)
				oLogImp:Cell("FVR_QTDLIN"	):SetValue(( __cAliasTmp )->FVR_QTDLIN)
				oLogImp:Cell("FVR_QTDTOT"	):SetValue(( __cAliasTmp )->FVR_QTDTOT)
				oLogImp:Cell("NOMUSU"	    ):SetValue(UsrRetName(( __cAliasTmp )->NOMUSU))
				oLogImp:Cell("FVR_DESCLE"	):SetValue(( __cAliasTmp )->FVR_DESCLE)

				oLogImp:PrintLine( .T. )

			EndIf

			If !Empty(Alltrim(( __cAliasTmp )->FV3_IDPROC))

				oDetalhe:Init()

				oDetalhe:Cell("FV3_LINARQ"	):SetPicture(X3Picture("FV3_LINARQ"))
				oDetalhe:Cell("FV3_CODEST"	):SetPicture(X3Picture("FV3_CODEST"))
				oDetalhe:Cell("FV3_NUCOMP"	):SetPicture(X3Picture("FV3_NUCOMP"))
				oDetalhe:Cell("FV3_MOTIVO"	):SetPicture(X3Picture("FV3_MOTIVO"))

				oDetalhe:Cell("FV3_LINARQ"	):SetValue(( __cAliasTmp )->FV3_LINARQ)
				oDetalhe:Cell("FV3_CODEST"	):SetValue(( __cAliasTmp )->FV3_CODEST)
				oDetalhe:Cell("FV3_NUCOMP"	):SetValue(( __cAliasTmp )->FV3_NUCOMP)
				oDetalhe:Cell("FV3_MOTIVO"	):SetValue(( __cAliasTmp )->FV3_MOTIVO)

				If cIDProcAnt <> ( __cAliasTmp )->FVR_IDPROC
					oDetalhe:PrintLine( .T. )
				Else
					oDetalhe:PrintLine( .F. )
				EndIf

			EndIf

			cIDProcAnt := ( __cAliasTmp )->FVR_IDPROC

			( __cAliasTmp )->( DbSkip() )

			oReport:IncMeter()

		EndDo

		oDetalhe:Finish()

		oLogImp:Finish()
	EndIf

	Return