/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR801.ch"
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'REPORT.CH'

//------------------------------------------------------------------------------
/*/{Protheus.doc} TECR801
	Relatório TReport para impressão de Detalhamento da Fatura 

@sample 	U_TECR801() 

@since		30/12/2013       
@version	P12   
/*/
//------------------------------------------------------------------------------
User Function TECR801()

Local oReport := Nil
Local oCabec  := Nil
Local oSum	:= Nil
Local aCods := {}

Private cPerg := 'TECR801'

Private cQryRep801 := ''

Pergunte('TECR801',.F.)

DEFINE REPORT oReport NAME 'TECR801' TITLE STR0001 PARAMETER 'TECR801' ACTION {|oReport| PrintReport(oReport)} //"Detalhamento da Fatura"
	oReport:HideParamPage()  // inibe a impressão da página de parâmetros
	oReport:SetLandscape() //Escolher o padrão de Impressao como Paisagem 

	DEFINE SECTION oCabec OF oReport TITLE STR0001 TABLE 'SM0', 'SB1', 'TFI', 'SA1', 'TFZ', 'SE1', 'TEW' //LINE STYLE COLUMNS 3 //"Detalhamento da Fatura"
	DEFINE CELL NAME 'TFI_PERINI' OF oCabec TITLE STR0002 ALIAS 'TFI' ; //"Período"
		SIZE  TamSX3('TFI_PERINI')[1]+TamSX3('TFI_PERFIM')[1] + 16 ;
		BLOCK { | oCell | DtoC(TFI_PERINI) + ' - ' + DtoC(TFI_PERFIM) }
	DEFINE CELL NAME 'TFZ_NUMMED' OF oCabec TITLE STR0003 ALIAS 'TFZ'; //"Medição"
		SIZE  TamSX3('TFZ_NUMMED')[1]+TamSX3('TFZ_NUMMED')[1] + 1	
	DEFINE CELL NAME 'TFI_CONTRT' OF oCabec ALIAS 'TFI';
		SIZE  TamSX3('TFI_CONTRT')[1]+TamSX3('TFI_CONTRT')[1] + 1
	DEFINE CELL NAME 'A1_NOME'    OF oCabec ALIAS 'SA1'
	DEFINE CELL NAME 'TEW_BAATD' OF oCabec ALIAS 'TEW';
		SIZE  TamSX3('TEW_BAATD')[1]+TamSX3('TEW_BAATD')[1] + 1
	DEFINE CELL NAME 'B1_DESC'   OF oCabec ALIAS 'SB1'
	DEFINE CELL NAME 'TFI_TOTAL' OF oCabec ALIAS 'TFI'
	DEFINE CELL NAME 'TIP_VLRMED' OF oCabec ALIAS 'TIP' 
	DEFINE CELL NAME 'TIP_QTDMED' OF oCabec TITLE STR0005 ALIAS 'TIP'; //"Dias Util."
		SIZE TamSX3('TIP_QTDMED')[1] + 3 ;
		BLOCK{|oCell| TFI_PERFIM - TFI_PERINI + 1 }
	DEFINE CELL NAME 'TEV_SLD' OF oCabec TITLE STR0006 ALIAS 'TEV'; //"Sld. a Fat."
		SIZE TamSX3('TEV_SLD')[1] + TamSX3('TEV_SLD')[2] + 1 ;
		BLOCK {|oCell| (cQryRep801)->TEV_SLD/(cQryRep801)->TFI_QTDVEN }
	DEFINE CELL NAME 'E1_NUM' OF oCabec TITLE STR0007 ALIAS 'SE1' ; //"Título"
		SIZE 20;
		BLOCK { | oCell | RetNumTit() }
	DEFINE CELL NAME 'TEW_DTRINI' OF oCabec ALIAS 'TEW'
	DEFINE CELL NAME 'STATUS' OF oCabec TITLE STR0008 SIZE 12 ; //"Status"
		BLOCK { | oCell | RetStat() }
		
oReport:PrintDialog()

Return 

//------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
	Função que faz o controle de impressão do relatório 

@sample 	U_TECR801() 

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

cQryRep801 := GetNextAlias()

MakeSqlExp('TECR801')

BEGIN REPORT QUERY oReport:Section(1)

BeginSql alias cQryRep801
	SELECT TFZ_NUMMED, TFZ_ITMED, TFI_PERINI, TFI_PERFIM, TFI_CONTRT, TFI_TOTAL, TFI_COD
		, A1_NOME, B1_DESC, TEW_BAATD, TEW_DTRINI, TEW_DTRFIM, TEW_MOTIVO, TIP_VLRMED, TIP_QTDMED, SUM(TEV_SLD) TEV_SLD
		, CNE_PEDTIT, SUM(TEV_QTDE) TEV_QTDE, TFI_QTDVEN
		
	FROM %Table:TFZ% TFZ
		INNER JOIN %Table:TFI% TFI ON TFI.TFI_FILIAL = %xFilial:TFI% AND TFI.TFI_COD = TFZ.TFZ_CODTFI  
			AND TFI.TFI_CONTRT = %Exp:mv_par01% AND TFI.TFI_CONREV = %Exp:mv_par02% AND TFI.%NotDel%
		INNER JOIN %Table:CN9% CN9 ON CN9.CN9_FILIAL = %xFilial:CN9% AND CN9.CN9_NUMERO = TFI.TFI_CONTRT
			AND CN9.CN9_REVISA = TFI.TFI_CONREV AND CN9.%NotDel%
		INNER JOIN %Table:CNC% CNC ON CNC.CNC_FILIAL = %xFilial:CNC% AND CNC.CNC_NUMERO = CN9.CN9_NUMERO
			AND CNC.CNC_REVISA = CN9.CN9_REVATU AND CNC.%NotDel%
		LEFT OUTER /*INNER*/ JOIN %Table:SA1% SA1 ON SA1.A1_FILIAL = %xFilial:SA1% AND SA1.A1_COD = CNC.CNC_CLIENT 
			AND SA1.A1_LOJA = CNC.CNC_LOJACL AND SA1.%NotDel%
		INNER JOIN %Table:TEW% TEW ON TEW.TEW_FILIAL = %xFilial:TEW% AND TEW.TEW_CODEQU = TFI.TFI_COD
			AND TEW.%NotDel%
		INNER JOIN %Table:SB1% SB1 ON SB1.B1_FILIAL = %xFilial:SB1% AND SB1.B1_COD = TEW.TEW_PRODUT AND SB1.%NotDel%
		INNER JOIN %Table:TFV% TFV ON TFV.TFV_FILIAL = %xFilial:TFV% AND TFV.TFV_CODIGO = TFZ.TFZ_APURAC AND TFV.%NotDel%
		LEFT OUTER JOIN %Table:TIP% TIP ON TIP.TIP_FILIAL = %xFilial:TIP% AND TIP.TIP_ITAPUR = TFV.TFV_CODIGO and TIP.%NotDel%
		INNER JOIN %Table:TEV% TEV ON TEV.TEV_FILIAL = %xFilial:TEV% AND TEV.TEV_CODLOC = TFI.TFI_COD AND TEV.%NotDel%
		INNER JOIN %Table:CNE% CNE ON CNE.CNE_FILIAL = %xFilial:CNE% AND CNE.CNE_NUMMED = TFZ.TFZ_NUMMED 
			AND CNE.CNE_ITEM = TFZ.TFZ_ITMED AND CNE.%NotDel% 
	
	WHERE TFZ.TFZ_FILIAL = %xFilial:TFZ% AND TFZ.TFZ_NUMMED = %Exp:mv_par03% AND TFZ.%NotDel%  

	GROUP BY TFZ_NUMMED, TFZ_ITMED, TFI_PERINI, TFI_PERFIM, TFI_CONTRT, TFI_TOTAL, TFI_COD
			, A1_NOME, B1_DESC, TEW_BAATD, TEW_DTRINI, TEW_DTRFIM, TEW_MOTIVO, TIP_VLRMED, TIP_QTDMED
			, CNE_PEDTIT, TFI_QTDVEN

EndSql

END REPORT QUERY oReport:Section(1)

oCabec := oReport:Section(1)

oReport:Section(1):Print()

Return

//-------------------------------------
Static Function RetStat()

Local cRet := ''
Local cMotivo := (cQryRep801)->TEW_MOTIVO
Local dFim := (cQryRep801)->TEW_DTRFIM

If cMotivo == '2'
	cRet := STR0015 //"CANCELADO"
ElseIf cMotivo == '1'
	cRet := STR0016 //"SUBSTITUIDO"
ElseIf !Empty(dFim)
	cRet := STR0017 //"ENCERRADO"
Else
	cRet := STR0018 //"EM ANDAMENTO"
EndIf

Return cRet

//-----------------------------------------
Static Function RetNumTit()

Local cRet := ''
Local aArea := GetArea()
Local cAliasQry := GetNextAlias()
Local cQuery := ''

If (cQryRep801)->CNE_PEDTIT == '1' 

	cQuery := "Select E1_NUM, E1_PARCELA, E1_PREFIXO "
	cQuery += "  From " + RetSqlName('SE1') + " SE1 "
	cQuery += " Inner Join " + RetSqlName('SC6') + " SC6 "
	cQuery += "    On C6_FILIAL = '" + xFilial('SC6') + "' "
	cQuery += "   And C6_NOTA = E1_NUM "
	cQuery += "   And C6_ITEMED = '" + (cQryRep801)->TFZ_ITMED + "' "
	cQuery += "   And SC6.D_E_L_E_T_ = ' ' "
	cQuery += " Inner Join " + RetSqlName('SC5') + " SC5 "
	cQuery += "    On C5_FILIAL = '" + xFilial('SC5') + "' "
	cQuery += "   And C5_NUM = C6_NUM "
	cQuery += "   And C5_MDNUMED = '" + (cQryRep801)->TFZ_NUMMED + "' "
	cQuery += "   And SC5.D_E_L_E_T_ = ' ' "
	cQuery += " Where E1_FILIAL = '" + xFilial('SE1') + "' "
	
	cQuery += "   And E1_SERIE = C6_SERIE "			
	
	cQuery += "   And E1_TIPO = 'NF ' "
	cQuery += "   And SE1.D_E_L_E_T_ = ' ' "

Else

	cQuery := "Select E1_NUM, E1_PARCELA, E1_PREFIXO "
	cQuery += "  From " + RetSqlName('SE1') + " SE1 "
	cQuery += " Inner Join " + RetSqlName('CND') + " CND "
	cQuery += "    On CND_FILIAL = '" + xFilial('CND') + "' "
	cQuery += "   And CND_NUMTIT = E1_NUM "
	cQuery += "   And CND_NUMMED = '" + (cQryRep801)->TFZ_NUMMED + "' "
	cQuery += "   And CND.D_E_L_E_T_ = ' ' "
	cQuery += " Where E1_FILIAL = '" + xFilial('SE1') + "' "
	cQuery += "   And E1_PREFIXO = '" + GetNewPar('MV_CNPREMD') + "' "
	cQuery += "   And E1_TIPO = '" + GetNewPar('MV_CNTPTMD') + "' "
	cQuery += "   And E1_NATUREZ = '" + GetNewPar('MV_CNNATMD') + "' "
	cQuery += "   And SE1.D_E_L_E_T_ = ' ' "

EndIf
	
cQuery := ChangeQuery(cQuery)

If Select(cAliasQry) > 0
	(cAliasQry)->(DbCloseArea())
EndIf

DbUseArea(.T., "TOPCONN",TcGenQry(,,cQuery), cAliasQry, .T., .T.)

If (cAliasQry)->(!Eof())
	cRet := (cAliasQry)->(E1_NUM + '-' + E1_PREFIXO)
EndIf

(cAliasQry)->(DbCloseArea())

RestArea(aArea)

Return cRet
