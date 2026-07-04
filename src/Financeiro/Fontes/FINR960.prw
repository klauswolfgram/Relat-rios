/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "PROTHEUS.CH"
#include "FINR960.CH"

Static __cAliasTmp	:= ''

//-------------------------------------------------------------------
/*/{Protheus.doc} FINR960
Relatorio DME (Declaração de Operações Liquidadas com Moeda em Espécie)

@author francisco.carmo
@since 09/03/2018
@version 12.1.20
/*/
//-------------------------------------------------------------------

User Function FINR960()
	Local oReport As Object

	Private aSelFil As Array

	If FR960VlDic()
		Help( Nil, Nil, STR0020, Nil, STR0021, 1, 0 )
		Return
	EndIf

	oReport := ReportDef()
	
	If !Empty( oReport:uParam ) .And. !IsBlind()
		Pergunte( oReport:uParam, .F. )
	EndIf
	
	oReport:PrintDialog()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Relatorio DME (Declaração de Operações Liquidadas com Moeda em Espécie)

@author francisco.carmo
@since 09/03/2018
@version 12.1.20
/*/
//-------------------------------------------------------------------

Static Function ReportDef() As Object
	Local oReport	As Object
	Local oCliente	As Object
	Local oDeclar	As Object
	Local oMovEsp	As Object

	//**************************************************************************
	//Criacao do componente de impressao                                      **
	//                                                                        **
	//TReport():New                                                           **
	//ExpC1 : Nome do relatorio                                               **
	//ExpC2 : Titulo                                                          **
	//ExpC3 : Pergunte                                                        **
	//ExpB4 : Bloco de codigo que sera executado na admin da impressao        **
	//ExpC5 : Descricao                                                       **
	//                                                                        **
	//**************************************************************************

	__cAliasTmp := GetNextAlias()

	Pergunte("FINR960",.F.)

	//"Este programa ir  emitir o relatório de movimentaçõs"
	//"bancárias de Moedas em Espécies"
	oReport := TReport():New("FINR960",STR0001,"FINR960", {|oReport| ReportPrint(oReport)}, STR0002)

	oReport:SetUseGC( .T. )

	oReport:DisableOrientation( .T. )
	oReport:SetLandScape( .T. )

	//Dados do Declarante
	oDeclar := TRSection():New(oReport, STR0003, {"SM0"}, )			//"Dados do Declarante"
	TRCell():New(oDeclar,"M0_NOMECOM"	, "SM0", STR0003,,23,.F.)	//"Declarante"
	TRCell():New(oDeclar,"CGC"			, "SM0", STR0004,,20,.F.)	//"CNPJ Declarante"

	TRBreak():New( oDeclar, {|| SM0->M0_CODIGO + SM0->M0_CODFIL }, /**/, .F., /**/, .T., .F., .T. )

	//Dados do Declarado
	oCliente := TRSection():New(oDeclar, STR0005, {"SA1"} )			//"Dados do Declarado"
	TRCell():New(oCliente,"A1_NOME"		, "SA1", STR0005,,23,.F.)	//"Declarado"
	TRCell():New(oCliente,"A1_CGC"		, "SA1", STR0006,,20,.F.)	//"CNPJ/CPF Declarado"
	TRCell():New(oCliente,"A1_PESSOA"	, "SA1", STR0007,,20,.F.)	//"Tipo de Pessoa "
	TRCell():New(oCliente,"A1_PAISDES"	, "SA1", STR0008)			//"País"

	TRBreak():New( oCliente, {||iIf( (__cAliasTmp)->E1_TIPO != MVRECANT,(__cAliasTmp)->FK1_FILORI , (__cAliasTmp)->E1_FILORIG ) + (__cAliasTMP)->E1_CLIENTE + (__cAliasTMP)->E1_LOJA }, /**/, .F., /**/, .F., .F., .T. )

	oCliente:SetHeaderBreak( .T. )

	//Dados do Movimento
	oMovEsp := TRSection():New(oCliente,STR0009,{"FK1"})		//"Movimentos Espécies"
	TRCell():New(oMovEsp,"DTBAIXA"	, "SE1", STR0010)			//"Data da baixa"
	TRCell():New(oMovEsp,"E1_VALOR" , "SE1", STR0011)			//"Valor Operação"
	TRCell():New(oMovEsp,"E1_VALES" , "SE1", STR0012)			//"Valor Espécie"
	TRCell():New(oMovEsp,"MOEDA"	, "SE1", STR0013)			//"Moeda"
	TRCell():New(oMovEsp,"E1_HIST"	, "SE1", STR0014)			//"Histórico"
	TRCell():New(oMovEsp,"CODBEM"	, "SE1", STR0018,,56,.F.)	//"Código do Bem"
	TRCell():New(oMovEsp,"CODSER"	, "SE1", STR0019,,56,.F.)	//"Código do Serviço"

	TRBreak():New( oMovEsp, {||iIf( (__cAliasTmp)->E1_TIPO != MVRECANT,(__cAliasTmp)->FK1_FILORI , (__cAliasTmp)->E1_FILORIG ) + (__cAliasTMP)->E1_CLIENTE + (__cAliasTMP)->E1_LOJA }, /**/, .F., /**/, .F., .F., .T. )

	oMovEsp:SetHeaderBreak( .T. )

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Relatorio DME (Declaração de Operações Liquidadas com Moeda em Espécie)

@author francisco.carmo
@since 09/03/2018
@version 12.1.20
/*/
//-------------------------------------------------------------------

Static Function ReportPrint( oReport As Object)
	Local nX			As Numeric
	Local nCont			As Numeric
	Local nLinReport	As Numeric
	Local nLinPag		As Numeric
	Local nVlrDME		As Numeric
	Local nIndArray		As Numeric
	Local oDeclar		As Object
	Local oCliente		As Object
	Local oMovEsp		As Object
	Local oTempTable	As Object
	Local aMotBx		As Array
	Local aEmpSM0		As Array
	Local aRecon		As Array
	Local aStruct		As Array
	Local aTotCli		As Array
	Local aSelFil		As Array
	Local cChave		As Character
	Local cFilImp		As Character
	Local cQryImp		As Character
	Local cBxFK1		As Character
	Local cDBtype		As Character
	Local cPicture		As Character
	Local cFil		    As Character
	Local cCliFil		As Character
	Local cFilAnter     As Character
	Local cCliAnter     As Character
	Local lSkiped		As Logical
	Local lFirst		As Logical
	Local lImprime		As Logical
	Local cOrigem		As Character
	Local cCPF 		  	As Character 

	Private nTxMoedBc	As Numeric
	Private nMoedaBco	As Numeric

	nX			:= 0
	nCont 		:= 0
	nLinReport	:= 8
	nLinPag 	:= 80
	nVlrDME		:= SuperGetMv("MV_VLRMDME",,"")
	nIndArray	:= 0
	oDeclar		:= oReport:Section(1)
	oCliente	:= oReport:Section(1):Section(1)
	oMovEsp		:= oReport:Section(1):Section(1):Section(1)
	aMotBx	 	:= MotBxEsp()
	aEmpSM0		:= SM0->(GetArea())
	aRecon 		:= {}
	aStruct		:= {}
	aTotCli		:= {}
	aSelFil		:= {}
	cChave		:= ""
	cFilImp		:= ""
	cQryImp		:= ""
	cBxFK1		:= ""
	cCliFil  	:= ""
	cPicture	:= X3Picture("A1_CGC" )
	cCPF 		:= "@R 999.999.999-99"
	cDBtype 	:= AllTrim(Upper(TCGetDB()))
	lSkiped		:= .F.
	lFirst		:= .T.
	lImprime    := .F.
	cFil     := ""
	cFilAnter  := ""
	cCliAnter  := ""
	
	nTxMoedBc	:= 0
	nMoedaBco	:= 1
	cOrigem:= "FINA100"
	
	//Ajusto as variáveis para uso na query
	If mv_par03 == 1
		aSelFil := AdmGetFil( .F., .T., "FK1" )
		If Empty( aSelFil )
			aAdd( aSelFil, cFilAnt )
		EndIf
	Else
		aAdd( aSelFil, cFilAnt )
	EndIf
	
	//Seleciono os tipos de baixa que são espécie
	For nX := 1 To Len(aMotBx)
		If nX == Len(aMotBx)
			cBxFK1	+=  aMotBx[nX,1]
		Else
			cBxFK1	+=  aMotBx[nX,1] + "','"
		EndIf
	Next nX
	
	AAdd( aRecon, {0,0,0,0} )

	SM0->(DbGoTop())
	
	cFilialSE1 := GetRngFil( aSelFil, "SE1", .T. )

	//Query do relatório	
	aAdd( aStruct, {'E1_FILIAL'	,'C',TamSX3('E1_FILIAL')[1]	,0						} )
	aAdd( aStruct, {'E1_PREFIXO','C',TamSX3('E1_PREFIXO')[1],0						} )
	aAdd( aStruct, {'E1_NUM'	,'C',TamSX3('E1_NUM')[1]	,0						} )
	aAdd( aStruct, {'E1_PARCELA','C',TamSX3('E1_PARCELA')[1],0						} )
	aAdd( aStruct, {'E1_TIPO'	,'C',TamSX3('E1_TIPO')[1]	,0						} )
	aAdd( aStruct, {'E1_CLIENTE','C',TamSX3('E1_CLIENTE')[1],0						} )
	aAdd( aStruct, {'E1_LOJA'	,'C',TamSX3('E1_LOJA')[1]	,0						} )
	aAdd( aStruct, {'E1_NOMCLI'	,'C',TamSX3('E1_NOMCLI')[1]	,0						} )
	aAdd( aStruct, {'E1_VALOR'	,'N',TamSX3('E1_VALOR')[1]	,TamSX3('E1_VALOR')[2]	} )
	aAdd( aStruct, {'E1_MOEDA'	,'N',TamSX3('E1_MOEDA')[1]	,0						} )
	aAdd( aStruct, {'E1_VENCTO'	,'D',TamSX3('E1_VENCTO')[1]	,0						} )
	aAdd( aStruct, {'E1_FILORIG','C',TamSX3('E1_FILORIG')[1],0						} )
	aAdd( aStruct, {'FK1_IDDOC'	,'C',TamSX3('FK1_IDDOC')[1]	,0						} )
	aAdd( aStruct, {'FK1_DATA'	,'D',TamSX3('FK1_DATA')[1]	,0						} )
	aAdd( aStruct, {'FK1_VALOR'	,'N',TamSX3('FK1_VALOR')[1]	,TamSX3('FK1_VALOR')[2]	} )
	aAdd( aStruct, {'FK1_HISTOR','C',TamSX3('FK1_HISTOR')[1],0						} )
	aAdd( aStruct, {'FK1_FILORI','C',TamSX3('FK1_FILORI')[1],0						} )
	aAdd( aStruct, {'FKF_CODBEM','C',TamSX3('FKF_CODBEM')[1],0						} )
	aAdd( aStruct, {'FKF_CODSER','C',TamSX3('FKF_CODSER')[1],0						} )
	aAdd( aStruct, {'DTBAIXA'	,'D',TamSX3('FK1_DATA')[1]	,0						} )
	aAdd( aStruct, {'ORIGEM'	,'C',TamSX3('E1_ORIGEM')[1],0						} )

    cQryImp := " SELECT SE1.E1_FILIAL AS E1_FILIAL, SE1.E1_PREFIXO AS E1_PREFIXO, SE1.E1_NUM AS E1_NUM, SE1.E1_PARCELA AS E1_PARCELA, SE1.E1_TIPO AS E1_TIPO, SE1.E1_CLIENTE AS E1_CLIENTE, SE1.E1_LOJA AS E1_LOJA, SE1.E1_NOMCLI, SE1.E1_VALOR, "
    cQryImp += " SE1.E1_MOEDA, SE1.E1_VENCTO, SE1.E1_FILORIG, FK1.FK1_IDDOC, FK1.FK1_DATA, FK1.FK1_VALOR, FK1.FK1_HISTOR, FK1.FK1_FILORI, FKF.FKF_CODBEM, FKF.FKF_CODSER,SE1.E1_ORIGEM AS ORIGEM,"
	cQryImp += " CASE WHEN FK1.FK1_MOTBX IN ('"+cBxFK1+"') AND FK1.FK1_TPDOC = 'VL' THEN FK1.FK1_DATA WHEN E1_TIPO = 'RA ' AND FKF_ESPEC = 'S' THEN SE1.E1_EMISSAO END AS DTBAIXA"
	cQryImp += " FROM " + RetSqlName('SE1') + " SE1	LEFT JOIN " + RetSqlName('FK7') + " FK7 ON SE1.E1_FILIAL = FK7.FK7_FILIAL AND FK7.FK7_ALIAS = 'SE1' "
	cQryImp += " AND RTRIM(FK7.FK7_CHAVE) = SE1.E1_FILIAL || '|' || SE1.E1_PREFIXO || '|' || SE1.E1_NUM || '|' || SE1.E1_PARCELA || '|' || SE1.E1_TIPO || '|' || SE1.E1_CLIENTE || '|' || SE1.E1_LOJA  "	
	cQryImp += " LEFT JOIN "
	cQryImp += " (SELECT FK1B.FK1_FILIAL, FK1B.FK1_IDDOC, FK1B.FK1_DATA, FK1B.FK1_VALOR, FK1B.FK1_HISTOR, FK1B.FK1_FILORI, FK1B.FK1_TPDOC, FK1B.FK1_MOTBX, FK1B.D_E_L_E_T_ "
	cQryImp += " FROM " + RetSqlName('FK1') + " FK1B "
	cQryImp += " WHERE FK1B.FK1_TPDOC = 'VL' AND FK1B.FK1_VALOR > 0 AND FK1B.D_E_L_E_T_= ' ' "
	cQryImp += " AND FK1B.FK1_FILIAL || '|' || FK1B.FK1_IDDOC || '|' || FK1B.FK1_SEQ NOT IN (SELECT FK1A.FK1_FILIAL || '|' || FK1A.FK1_IDDOC || '|' || FK1A.FK1_SEQ "
	cQryImp += " FROM " + RetSqlName('FK1') + " FK1A "
	cQryImp += " WHERE FK1A.FK1_TPDOC = 'ES' AND FK1A.FK1_FILIAL = FK1B.FK1_FILIAL AND FK1A.FK1_IDDOC = FK1B.FK1_IDDOC AND FK1A.FK1_SEQ = FK1B.FK1_SEQ AND FK1A.D_E_L_E_T_= ' ') " 
	cQryImp += " ) FK1 ON FK1.FK1_FILIAL = FK7.FK7_FILIAL AND FK1.FK1_IDDOC = FK7.FK7_IDDOC " 	
	cQryImp += " LEFT JOIN " + RetSqlName('FKF') + " FKF ON FK7.FK7_FILIAL = FKF.FKF_FILIAL AND FK7.FK7_IDDOC = FKF.FKF_IDDOC " 
	cQryImp += " WHERE SE1.E1_FILIAL " + cFilialSE1 

	If AliasInDic("FKF") .and. FKF->(ColumnPos("FKF_ESPEC")) > 0
		cQryImp += " AND ((FK1.FK1_MOTBX IN ('" + cBxFK1 + "') AND FK1.FK1_TPDOC = 'VL' " 
		cQryImp += " AND FK1.FK1_DATA BETWEEN '" + DtoS( MV_PAR01 ) + "' AND '" + DtoS( MV_PAR02 ) + "' AND FK1.D_E_L_E_T_= ' ') OR (E1_TIPO = '" +MVRECANT+ "' and FKF_ESPEC = 'S' "
		cQryImp += " AND SE1.E1_EMISSAO BETWEEN '" + DtoS( MV_PAR01 ) + "' AND '" + DtoS( MV_PAR02 ) +"' )) "
		cQryImp += " AND SE1.D_E_L_E_T_= ' ' AND FK7.D_E_L_E_T_= ' ' AND FKF.D_E_L_E_T_= ' ' " 
	Else
		cQryImp += " AND FK1.FK1_MOTBX IN ('" + cBxFK1 + "') AND FK1.FK1_TPDOC = 'VL' " 
		cQryImp += " AND FK1.FK1_DATA BETWEEN '" + DtoS( MV_PAR01 ) + "' AND '" + DtoS( MV_PAR02 ) + "' "
		cQryImp += " AND SE1.D_E_L_E_T_= ' ' AND FK1.D_E_L_E_T_= ' ' AND FK7.D_E_L_E_T_= ' ' AND FKF.D_E_L_E_T_= ' ' " 
	EndIf

	// CONSIDERA TAMBEM MOVIMENTOS EM DINHEIRO (r$) INSERIDOS DIRETAMENTE PELO FINA100
	cQryImp += " UNION ALL "
	cQryImp += " SELECT SE5P.E5_FILIAL AS E1_FILIAL, SE5P.E5_PREFIXO AS E1_PREFIXO, SE5P.E5_DOCUMEN AS E1_NUM, SE5P.E5_PARCELA AS E1_PARCELA, SE5P.E5_TIPO AS E1_TIPO,SE5P.E5_CLIFOR AS E1_CLIENTE,"
	cQryImp += " SE5P.E5_LOJA AS E1_LOJA, SE5P.E5_BENEF, SE5P.E5_VALOR, CAST(1 AS NUMERIC ),"
    cQryImp += " SE5P.E5_VENCTO, SE5P.E5_FILORIG,SE5P.E5_IDORIG,SE5P.E5_DATA,SE5P.E5_VALOR,SE5P.E5_HISTOR,SE5P.E5_FILORIG,'','',SE5P.E5_ORIGEM AS ORIGEM, SE5P.E5_DATA AS DTBAIXA"
	cQryImp += " FROM " + RetSqlName('SE5') +" SE5P "
	cQryImp += "WHERE SE5P.E5_FILIAL " + cFilialSE1 + " AND SE5P.E5_TIPODOC <> 'TR' AND "
	cQryImp += "SE5P.E5_ORIGEM='"+cOrigem+"' AND SE5P.E5_SITUACA='' AND "
	cQryImp += "SE5P.E5_MOEDA IN ('R$') AND SE5P.E5_RECPAG = 'R' AND " 
	cQryImp += "SE5P.E5_DATA BETWEEN '" + DtoS( MV_PAR01 ) + "' AND '" + DtoS( MV_PAR02 ) +"' AND "
	cQryImp += "SE5P.D_E_L_E_T_= ' ' "

	cQryImp += " UNION ALL "
	cQryImp += " SELECT SE1.E1_FILIAL AS E1_FILIAL, SE1.E1_PREFIXO AS E1_PREFIXO, SE1.E1_NUM AS E1_NUM, SE1.E1_PARCELA AS E1_PARCELA, SE1.E1_TIPO AS E1_TIPO, SE1.E1_CLIENTE AS E1_CLIENTE, SE1.E1_LOJA AS E1_LOJA, SE1.E1_NOMCLI, SE1.E1_VALOR "
	cQryImp += " , SE1.E1_MOEDA, SE1.E1_VENCTO, SE1.E1_FILORIG, FK1.FK1_IDDOC, FK1.FK1_DATA, FK1.FK1_VALOR, FK1.FK1_HISTOR, FK1.FK1_FILORI, FKF.FKF_CODBEM, FKF.FKF_CODSER,SE1.E1_ORIGEM AS ORIGEM"
	cQryImp += " , CASE WHEN ((FK1.FK1_MOTBX = 'LOJ' AND FK1.FK1_TPDOC = 'BA') OR (FK1.FK1_MOTBX = 'NOR' AND FK1.FK1_TPDOC = 'LJ')) THEN FK1.FK1_DATA WHEN E1_TIPO = 'RA ' AND FKF_ESPEC = 'S' THEN SE1.E1_EMISSAO END AS DTBAIXA"
	cQryImp += " FROM " + RetSqlName('SE1') + " SE1 LEFT JOIN " + RetSqlName('FK7') + " FK7 ON SE1.E1_FILIAL = FK7.FK7_FILIAL AND FK7.FK7_ALIAS = 'SE1'  "
	cQryImp += " AND RTRIM(FK7.FK7_CHAVE) = SE1.E1_FILIAL || '|' || SE1.E1_PREFIXO || '|' || SE1.E1_NUM || '|' || SE1.E1_PARCELA || '|' || SE1.E1_TIPO || '|' || SE1.E1_CLIENTE || '|' || SE1.E1_LOJA "
	cQryImp += " LEFT JOIN  "
	cQryImp += " (SELECT FK1B.FK1_FILIAL, FK1B.FK1_IDDOC, FK1B.FK1_DATA, FK1B.FK1_VALOR, FK1B.FK1_HISTOR, FK1B.FK1_FILORI, FK1B.FK1_TPDOC, FK1B.FK1_MOTBX, FK1B.D_E_L_E_T_  "
	cQryImp += " FROM " + RetSqlName('FK1') + " FK1B "
	cQryImp += " INNER JOIN " + RetSqlName('FKA') + " FKA1  ON FKA1.FKA_FILIAL = FK1B.FK1_FILIAL AND FKA1.FKA_IDORIG = FK1B.FK1_IDFK1 "
	cQryImp += " INNER JOIN " + RetSqlName('FKA') + " FKA2  ON FKA2.FKA_FILIAL = FK1B.FK1_FILIAL AND FKA2.FKA_IDPROC = FKA1.FKA_IDPROC AND FKA2.FKA_TABORI = 'FK5' "
	cQryImp += " INNER JOIN " + RetSqlName('FK5') + " FK5   ON FK5.FK5_FILIAL = FK1B.FK1_FILIAL AND FK5.FK5_IDMOV  = FKA2.FKA_IDORIG "
	cQryImp += " WHERE ((FK1B.FK1_MOTBX = 'LOJ' AND FK1B.FK1_TPDOC = 'BA') OR (FK1B.FK1_MOTBX = 'NOR' AND FK1B.FK1_TPDOC = 'LJ')) AND FK1B.FK1_VALOR > 0 AND FK5.FK5_MOEDA IN ('R$','01') AND FK1B.D_E_L_E_T_= ' '  "
	cQryImp += " AND FK1B.FK1_FILIAL || '|' || FK1B.FK1_IDDOC || '|' || FK1B.FK1_SEQ NOT IN (SELECT FK1A.FK1_FILIAL || '|' || FK1A.FK1_IDDOC || '|' || FK1A.FK1_SEQ  "
	cQryImp += " FROM " + RetSqlName('FK1') + " FK1A WHERE FK1A.FK1_TPDOC = 'ES' AND FK1A.FK1_FILIAL = FK1B.FK1_FILIAL AND FK1A.FK1_IDDOC = FK1B.FK1_IDDOC AND FK1A.FK1_SEQ = FK1B.FK1_SEQ AND FK1A.D_E_L_E_T_= ' ')  )  FK1 ON FK1.FK1_FILIAL = FK7.FK7_FILIAL AND FK1.FK1_IDDOC = FK7.FK7_IDDOC "
	cQryImp += " LEFT JOIN " + RetSqlName('FKF') + " FKF ON FK7.FK7_FILIAL = FKF.FKF_FILIAL AND FK7.FK7_IDDOC = FKF.FKF_IDDOC "
	cQryImp += " WHERE  SE1.E1_FILIAL " + cFilialSE1
	cQryImp += " AND ((FK1.FK1_MOTBX = 'LOJ' AND FK1.FK1_TPDOC = 'BA') OR (FK1.FK1_MOTBX = 'NOR' AND FK1.FK1_TPDOC = 'LJ')) AND FK1.FK1_DATA BETWEEN '" + DtoS( MV_PAR01 ) + "' AND '" + DtoS( MV_PAR02 ) + "' "
	cQryImp += " AND FK1.D_E_L_E_T_= ' ' AND SE1.D_E_L_E_T_= ' ' AND FK7.D_E_L_E_T_= ' ' AND FKF.D_E_L_E_T_= ' ' "
	cQryImp += " ORDER BY E1_FILIAL, E1_CLIENTE, E1_LOJA, DTBAIXA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO "

	cQryImp := ChangeQuery( cQryImp )
	oTempTable := FwTemporaryTable():New( __cAliasTmp )

	oTempTable:SetFields( aStruct )

	oTempTable:AddIndex('1', {'E1_FILIAL', 'E1_PREFIXO', 'E1_NUM', 'E1_PARCELA', 'E1_TIPO', 'E1_CLIENTE', 'E1_LOJA'})

	oTempTable:Create()
		
	SqlToTrb( cQryImp, aStruct, __cAliasTmp )
	DbSetOrder(0) // Fica na ordem da query

	( __cAliasTmp )->( DbGoTop() )

	If ( __cAliasTmp )->( Eof() )

		oTempTable:Delete()

		Return

	EndIf

	//Faço a "separação" dos valores de cada filial|cliente para verificação posterior
	While !( __cAliasTmp )->( Eof() )

		If cCliFil != (iIf(( __cAliasTmp )->E1_TIPO != MVRECANT,( __cAliasTmp )->FK1_FILORI , ( __cAliasTmp )->E1_FILORIG) + ( __cAliasTmp )->E1_CLIENTE + ( __cAliasTmp )->E1_LOJA )
			cCliFil := ( iIf(( __cAliasTmp )->E1_TIPO != MVRECANT,( __cAliasTmp )->FK1_FILORI , ( __cAliasTmp )->E1_FILORIG) + ( __cAliasTmp )->E1_CLIENTE + ( __cAliasTmp )->E1_LOJA  )
			aAdd( aTotCli, { cCliFil, 0 } )
		EndIf
		
		If ( __cAliasTmp )->E1_TIPO = MVRECANT
			aTotCli[Len( aTotCli )][2] += ( __cAliasTmp )->E1_VALOR
		Else
			aTotCli[Len( aTotCli )][2] += ( __cAliasTmp )->FK1_VALOR
		EndIf
		
		( __cAliasTmp )->( DbSkip() )

	EndDo

	( __cAliasTmp )->( DbGoTop() )

	oDeclar:Init()

	While !( __cAliasTmp )->( Eof() ) 

		cFil := (iIf(( __cAliasTmp )->E1_TIPO != MVRECANT,( __cAliasTmp )->FK1_FILORI , ( __cAliasTmp )->E1_FILORIG))
		SM0->( DbSeek( cEmpAnt + cFil ) )
		
		// Mesmo cCliFil quando acumulou por cliente acima para comparação
		cCliFil := ( iIf(( __cAliasTmp )->E1_TIPO != MVRECANT,( __cAliasTmp )->FK1_FILORI , ( __cAliasTmp )->E1_FILORIG) + ( __cAliasTmp )->E1_CLIENTE + ( __cAliasTmp )->E1_LOJA  )
		nIndArray := aScan( aTotCli , {|x| x[1] == cCliFil } )

		lImprime := aTotCli[ nIndArray ][2] >= nVlrDME
				
		If lImprime

			If cFilAnter <> cFil
				
				oReport:SetTitle(STR0015)

				oDeclar:Cell("M0_NOMECOM"):SetPicture(X3Picture("M0_NOMECOM"))
				oDeclar:Cell("CGC"):SetPicture( cPicture )

				oDeclar:Cell('M0_NOMECOM'):SetBlock({|| SM0->M0_NOMECOM})
				oDeclar:Cell('CGC'):SetBlock({|| SM0->M0_CGC })

				oDeclar:PrintLine( .T. )
				
			EndIf

			If (cFilAnter + cCliAnter) <> (cFil + ( __cAliasTmp )->E1_CLIENTE + ( __cAliasTmp )->E1_LOJA)

				oReport:SkipLine()

				oCliente:Init()
				If Alltrim((__cAliasTmp)->ORIGEM) == cOrigem .And. Empty((__cAliasTmp)->E1_CLIENTE)
					oCliente:Cell("A1_NOME"  	):SetBlock({|| STR0022})
					oCliente:Cell("A1_PESSOA"	):Hide()
				Else

					oCliente:Cell("A1_NOME"  	):SetPicture(X3Picture("A1_NOME"  ))
					oCliente:Cell("A1_PESSOA"	):SetPicture(X3Picture("A1_PESSOA"))
					oCliente:Cell("A1_PAISDES"	):SetPicture(X3Picture("A1_PAISDES"))
					
					SA1->( DbSetOrder( 1 ) )
					SA1->( MsSeek( xFilial( 'SA1', cFil) + ( __cAliasTmp )->E1_CLIENTE + ( __cAliasTmp )->E1_LOJA ) )
					
					SYA->( DbsetOrder( 1 ) )
					SYA->( MsSeek( xFilial( 'SYA', cFil ) + SA1->A1_PAIS ) )
					

					oCliente:Cell("A1_CGC"		):SetPicture(cPicture)

					If SA1->A1_PESSOA = "F"
						oCliente:Cell("A1_CGC"	):SetPicture(cCPF)
					EndIf
				
					oCliente:Cell("A1_NOME"  	):SetBlock({|| SA1->A1_NOME  })
					oCliente:Cell("A1_CGC"   	):SetBlock({|| SA1->A1_CGC})
					oCliente:Cell("A1_PESSOA"	):SetBlock({|| Iif( SA1->A1_PESSOA == "J", STR0016, STR0017 ) } )
					oCliente:Cell("A1_PAISDES"	):SetBlock({|| SYA->YA_DESCR  })
				EndIf
				oCliente:PrintLine( .T. )

			EndIf

			oMovEsp:Init()

			oMovEsp:Cell("DTBAIXA"):SetPicture(X3Picture("FK1_DATA"))
			oMovEsp:Cell("E1_VALOR" ):SetPicture(X3Picture("E1_VALOR"))
			If ( __cAliasTmp )->E1_TIPO = MVRECANT
				oMovEsp:Cell("E1_VALES" ):SetPicture(X3Picture("E1_VALOR"))
			Else
				oMovEsp:Cell("E1_VALES" ):SetPicture(X3Picture("FK1_VALOR"))
			EndIf
			oMovEsp:Cell("E1_HIST"  ):SetPicture(X3Picture("E1_HIST"))

			oMovEsp:Cell("DTBAIXA"):SetBlock({|| ( __cAliasTmp )->DTBAIXA})
			oMovEsp:Cell("E1_VALOR" ):SetBlock({|| ( __cAliasTmp )->E1_VALOR})
			If ( __cAliasTmp )->E1_TIPO = MVRECANT
				oMovEsp:Cell("E1_VALES" ):SetBlock({|| ( __cAliasTmp )->E1_VALOR})
			Else
				oMovEsp:Cell("E1_VALES" ):SetBlock({|| ( __cAliasTmp )->FK1_VALOR})
			EndIf
			oMovEsp:Cell("MOEDA" ):SetBlock({|| DescMoeda( ( __cAliasTmp )->E1_MOEDA )})
			oMovEsp:Cell("E1_HIST"  ):SetBlock({|| ( __cAliasTmp )->FK1_HISTOR})
			oMovEsp:Cell("CODBEM"):SetBlock({|| FR960SX5( 1, ( __cAliasTmp )->FKF_CODBEM ) })
			oMovEsp:Cell("CODSER"):SetBlock({|| FR960SX5( 2, ( __cAliasTmp )->FKF_CODSER ) })						

			oMovEsp:PrintLine( .T. )

			cFilAnter := cFil
			cCliAnter := ( __cAliasTmp )->E1_CLIENTE + ( __cAliasTmp )->E1_LOJA

		EndIf

		( __cAliasTmp )->( DbSkip() )

	EndDo

	oMovEsp:Finish()

	oCliente:Finish()

	oDeclar:Finish()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} DescMoeda
Função que retorna a descrição da moeda conforme parametros MV_SIMB

@author francisco.carmo
@since 09/03/2018
@version 12.1.20
/*/
//-------------------------------------------------------------------
Static Function DescMoeda( nMoeda As Numeric ) As Character
	Local cDescMoe As Character

	cDescMoe := ''

	If nMoeda > 0
		cDescMoe := SuperGetMv( "MV_SIMB" + AllTrim( Str( nMoeda, 2 ) ) )
	EndIf

Return cDescMoe

//-------------------------------------------------------------------
/*/{Protheus.doc} FR960SX5
Retorna a descrição da tabela SX5

@author Pedro Pereira Lima
@since 06/04/2018
@version 12.1.20
/*/
//-------------------------------------------------------------------
Static Function FR960SX5( nOpc As Numeric, cCodTab As Character ) As Character
	Local cRet As Character

	cRet := ''

	If SX5->( MsSeek( xFilial("SX5") + IIf( nOpc == 1, '0I', '0H' ) + cCodTab ) )
		cRet := SX5->( Alltrim( X5Descri() ) )
	EndIf

Return cRet

//-------------------------------------------------------------------
/*/{Protheus.doc} FR960VlDic
Função para validação do dicionário de dados, evitando que ocorra erro
se o dicionário estiver desatualizado (FUNÇÃO TEMPORÁRIA)

@author Pedro Pereira Lima
@since 06/04/2018
@version 12.1.20
/*/
//-------------------------------------------------------------------
Static Function FR960VlDic() As Logical
	Local lRet As Logical

	lRet := .F.

	If !SX1->( DbSeek('FINR960') ) .Or. !FKF->( ColumnPos('FKF_CODBEM') ) > 0 .Or. !FKF->( ColumnPos('FKF_CODSER') ) > 0		
		lRet := .T.
	EndIf

Return lRet

