/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR800.ch"
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'REPORT.CH'

//------------------------------------------------------------------------------
/*/{Protheus.doc} TECR800
	Relatório TReport para impressão de Conferência de Faturamento

@sample 	U_TECR800()

@since		30/12/2013
@version	P12
/*/
//------------------------------------------------------------------------------
User Function TECR800()

Local oReport := Nil
Local oCabec  := Nil
Local aOrd := {STR0001,STR0002,STR0003} //"Contrato"###"Cliente"###"Número de Série"

Private cPerg := 'TECR800'

Private cQryRep800 := ''

Pergunte('TECR800',.F.)

DEFINE REPORT oReport NAME 'TECR800' TITLE STR0004 PARAMETER 'TECR800' ACTION {|oReport| PrintReport(oReport)} //"Conferência de Faturamento"

	oReport:HideParamPage()  // inibe a impressão da página de parâmetros
	oReport:SetLandscape() //Escolher o padrão de Impressao como Paisagem
	DEFINE SECTION oCabec OF oReport TITLE STR0004 ORDERS aOrd TABLE 'SM0', 'SB1', 'TFI', 'SA1', 'TFZ', 'SE1', 'TEW', 'TFL' //LINE STYLE COLUMNS 3 //"Conferência de Faturamento"

		DEFINE CELL NAME 'STATUS' OF oCabec TITLE STR0005 SIZE 16 ; //"Status"
			BLOCK { | oCell | RetStat() }
		DEFINE CELL NAME 'TFI_CONTRT' OF oCabec ALIAS 'TFI'
		DEFINE CELL NAME 'TFJ_CODENT'    OF oCabec TITLE STR0006 ALIAS 'TFJ' ; //"Cod. Cliente"
			SIZE TamSX3('A1_COD')[1]+TamSX3('A1_LOJA')[1] + 3 ;
			BLOCK {|oCell| (cQryRep800)->TFJ_CODENT+'-'+(cQryRep800)->TFJ_LOJA }
		DEFINE CELL NAME 'A1_NOME' OF oCabec ALIAS 'SA1'
		DEFINE CELL NAME 'TIP_CODEQU' OF oCabec ALIAS 'TIP'
		DEFINE CELL NAME 'B1_DESC'   OF oCabec ALIAS 'SB1'
		DEFINE CELL NAME 'TIP_VLRAPR' OF oCabec ALIAS 'TIP'
		DEFINE CELL NAME 'TEW_DTSEPA' OF oCabec ALIAS 'TEW'
		DEFINE CELL NAME 'TFV_DTAPUR' OF oCabec ALIAS 'TFV'
		DEFINE CELL NAME 'TEW_DTRFIM' OF oCabec ALIAS 'TEW'
		DEFINE CELL NAME 'QTDMED' OF oCabec TITLE STR0008 ; //"Qtd.Medições"
			SIZE 8 PICTURE '99999' BLOCK { |oCell| QtdMed() }

oReport:PrintDialog()

Return

//------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
	Função que faz o controle de impressão do relatório

@sample 	U_TECR800()

@since		30/12/2013
@version	P12

@param  	oReport, Objeto, objeto da classe TReport para construção da consulta
	de busca e impressão dos dados
/*/
//------------------------------------------------------------------------------
Static Function PrintReport(oReport)

Local oCabec  := Nil
Local oItens  := Nil
Local oMens   := Nil
Local oEnd    := Nil
Local cSituac := ''
Local nOrder   := oReport:Section(1):GetOrder()
Local cOrder	:= ''

cQryRep800 := GetNextAlias()

MakeSqlExp('TECR800')


If mv_par13 == 1
	cSituac := " TEW_DTSEPA <> ' ' AND TEW_DTRINI = ' ' "
ElseIf mv_par13 == 2

	cSituac := " TEW_DTRINI <> ' ' AND TEW_DTRFIM = ' ' "
ElseIf mv_par13 == 3

	cSituac := " TEW_DTRFIM <> ' ' "
ElseIf mv_par13 == 4

	cSituac := " 1 = 1 "
EndIf

If nOrder == 1
	cOrder := ' TFI_CONTRT '
ElseIf nOrder == 2
	cOrder := ' TFJ_CODENT '
ElseIf nOrder == 3
	cOrder := ' TEW_BAATD '
EndIf

cOrder := '%'+cOrder+'%'
cSituac := '%'+cSituac+'%'

BEGIN REPORT QUERY oReport:Section(1)

BeginSql alias cQryRep800
	SELECT TFI_PERINI, TFI_PERFIM, TFI_CONTRT, TFI_TOTAL, TFI_COD, TFL_DTINI, TFV_DTAPUR, TFJ_CODENT, TFJ_LOJA
		, A1_NOME, B1_DESC, TIP_CODEQU, TEW_DTRINI, TEW_DTRFIM, TEW_MOTIVO, TEW_DTSEPA, TIP_VLRAPR, TIP_QTDE
		, SUM(TEV_SLD) TEV_SLD, SUM(TEV_QTDE) TEV_QTDE, TFI_QTDVEN, TEW.TEW_BAATD
	FROM %Table:TFI% TFI
		INNER JOIN %Table:TFZ% TFZ ON TFZ.TFZ_FILIAL = %xFilial:TFZ% AND TFZ.TFZ_CODTFI = TFI.TFI_COD AND TFZ.%NotDel%
		INNER JOIN %Table:TFL% TFL ON TFL.TFL_FILIAL = %xFilial:TFL% AND TFL.TFL_CODIGO = TFI.TFI_CODPAI AND TFL.%NotDel%
		INNER JOIN %Table:TFJ% TFJ ON TFJ.TFJ_FILIAL = %xFilial:TFJ% AND TFJ.TFJ_CODIGO = TFL.TFL_CODPAI
			AND TFJ.TFJ_CONTRT = TFI.TFI_CONTRT AND TFJ.TFJ_CONREV = TFI.TFI_CONREV
			AND TFJ.TFJ_CODENT BETWEEN %Exp:mv_par01% AND %Exp:mv_par03%
			AND TFJ.TFJ_LOJA BETWEEN %Exp:mv_par02% AND %Exp:mv_par04%
			AND TFJ.%NotDel%
		INNER JOIN %Table:SA1% SA1 ON SA1.A1_FILIAL = %xFilial:SA1% AND SA1.A1_COD = TFJ.TFJ_CODENT
			AND SA1.A1_LOJA = TFJ.TFJ_LOJA AND SA1.%NotDel%


		INNER JOIN %Table:TEV% TEV ON TEV.TEV_FILIAL = %xFilial:TEV% AND TEV.TEV_CODLOC = TFI.TFI_COD AND TEV.%NotDel%
		INNER JOIN %Table:TFV% TFV ON TFV.TFV_CONTRT = TFI.TFI_CONTRT AND TFV.TFV_REVISA = TFI.TFI_CONREV
			AND TFV.TFV_DTAPUR BETWEEN %Exp:mv_par11% AND %Exp:mv_par12%
			AND TFV.%NotDel%
		LEFT OUTER JOIN %Table:TIP% TIP ON TIP.TIP_FILIAL = %xFilial:TIP% AND TIP.TIP_ITAPUR = TFV.TFV_CODIGO AND TIP.TIP_CODEQU <> '' and TIP.%NotDel%

		INNER JOIN %Table:TEW% TEW ON TEW.TEW_FILIAL = %xFilial:TEW% AND TEW.TEW_CODEQU = TFI.TFI_COD AND TEW.TEW_BAATD = TIP.TIP_CODEQU
			AND TEW.TEW_PRODUT BETWEEN %Exp:mv_par05% AND %Exp:mv_par06%
			AND TEW.TEW_BAATD BETWEEN %Exp:mv_par07% AND %Exp:mv_par08%
			AND %Exp:cSituac%
			AND TEW.%NotDel%

	    INNER JOIN %Table:SB1% SB1 ON SB1.B1_FILIAL = %xFilial:SB1% AND SB1.B1_COD = TEW.TEW_PRODUT AND SB1.%NotDel%

	WHERE  TFI.TFI_FILIAL = %xFilial:TFI% AND TFI.%NotDel%

	GROUP BY TFI_PERINI, TFI_PERFIM, TFI_CONTRT, TFI_TOTAL, TFI_COD, TFL_DTINI, TFV_DTAPUR, TFJ_CODENT, TFJ_LOJA
		, A1_NOME, B1_DESC, TIP_CODEQU, TEW_DTRINI, TEW_DTRFIM, TEW_MOTIVO, TEW_DTSEPA, TIP_VLRAPR, TIP_QTDE, TFI_QTDVEN, TEW.TEW_BAATD

	ORDER BY %Exp:cOrder%

EndSql

END REPORT QUERY oReport:Section(1)

oCabec := oReport:Section(1)

oReport:Section(1):Print()

Return

//-------------------------------------
Static Function RetStat()

Local cRet := ' '
Local dIni := (cQryRep800)->TEW_DTRINI
Local dFim := (cQryRep800)->TEW_DTRFIM

If !Empty(dFim)
	cRet := 'FINALIZADO'
ElseIf !Empty(dIni)
	cRet := 'EM ANDAMENTO'
EndIf

Return cRet

//----------------------------------------
Static Function QtdMed()

Local nRet := 0
Local aArea := GetArea()
Local cQuery := ''
Local cAliasQry := GetNextAlias()

cQuery := "SELECT DISTINCT TFZ_NUMMED"
cQuery += 	" FROM " + RetSqlName('TFZ') + " TFZ"
cQuery += " WHERE TFZ_FILIAL='" + xFilial('TFZ') + "'"
cQuery += 	" AND TFZ_CODTFI='" + (cQryRep800)->TFI_COD + "'"
cQuery += 	" AND D_E_L_E_T_=' '"

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., "TOPCONN", TCGenQry(,,cQuery), cAliasQry, .F., .T.)

DbSelectArea(cAliasQry)

COUNT TO nRet

(cAliasQry)->(DbCloseArea())

RestArea(aArea)

Return nRet
