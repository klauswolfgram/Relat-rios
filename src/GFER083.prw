/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER083
Relatorio de Despesa de Frete por Item

@sample


@author Gustavo H. Baptista
@since 09/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER083()

	Local oReport
	Local aArea := GetArea()

	Private cDados
	Private cFilialIni
	Private cFilialFim
	Private dDataIni
	Private dDataFim
	Private cItemIni
	Private cItemFim
	Private cImpRecup
	Private cImpAuton
	Private cDctSemDesp
	Private cTipDesp
	Private cCritRat
	Private nVlFret
	Private nVlIss
	Private nVlIBM
	Private nVlIrrf
	Private nVlInau
	Private nVlInem
	Private nVlSest
	Private nVlIcms
	Private nVlIBS
	Private nVlCofi
	Private nVlPis
	Private nVlCBS

	Private cAliasRel, cAliasTot
	/*
	If !Pergunte("GFER083")
		Return Nil
	EndIf
	*/

	/*
	aParam[1] - Filial de
	aParam[2] - Filial até
	aParam[3] - Data Emis de
	aParam[4] - Data Emis até
	aParam[5] - Item Ini
	aParam[6] - Item Fim
	aParam[7] - Impost Recup
	aParam[8] - Impost Auton
	aParam[9] - cDctSemDesp
	aParam[10] - Tipo Despesa
	aParam[11] - Critério de Rateio
	*/

	If TRepInUse() // teste padrão
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

	GFEDelTab(cAliasRel)
	GFEDelTab(cAliasTot)
	RestArea( aArea )

Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CriaTabela
Cria tabelas auxiliares para a geração do relatório.

@sample


@author Gustavo Baptista
@since 09/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/

Static Function CriaTabela()

	// Criacao da tabela temporaria p/ imprimir o relat
	aTT :={ {"ITEM"     ,"C",TamSX3("GW8_ITEM"  )[1],0},;
			{"DSITEM"   ,"C",TamSX3("GW8_DSITEM")[1],0},;
			{"PESO"     ,"N",20,TamSX3("GW8_PESOR"  )[2]},;
			{"VALOR"    ,"N",20,TamSX3("GW8_VALOR"  )[2]},;
			{"VOLUME"   ,"N",20,TamSX3("GW8_VOLUME" )[2]},;
			{"QTDE"     ,"N",20,TamSX3("GW8_QTDE"   )[2]},;
			{"DESPFRETE","N",20,TamSX3("GWM_VLFRET" )[2]},;
			{"FRPESO"   ,"N",20,TamSX3("GWM_VLFRET" )[2]},;
			{"FRVAL"    ,"N",20,TamSX3("GWM_VLFRET" )[2]},;
			{"FRVOL"    ,"N",20,TamSX3("GWM_VLFRET" )[2]},;
			{"FRQTD"    ,"N",20,TamSX3("GWM_VLFRET" )[2]}}

	cAliasRel := GFECriaTab({aTT, {"ITEM"}})

	aTotalTable := {{"TPESO"  ,"N",20,TamSX3("GW8_PESOR"  )[2]},;
					{"TVAL"   ,"N",20,TamSX3("GW8_VALOR"  )[2]},;
					{"TVOL"   ,"N",20,TamSX3("GW8_VOLUME" )[2]},;
					{"TQTD"   ,"N",20,TamSX3("GW8_QTDE"   )[2]},;
					{"TFRETE" ,"N",20,TamSX3("GWM_VLFRET" )[2]},;
					{"TFRPESO","N",20,TamSX3("GWM_VLFRET" )[2]},;
					{"TFRVAL" ,"N",20,TamSX3("GWM_VLFRET" )[2]},;
					{"TFRVOL" ,"N",20,TamSX3("GWM_VLFRET" )[2]},;
					{"TFRQTD" ,"N",20,TamSX3("GWM_VLFRET" )[2]}}

	cAliasTot := GFECriaTab({aTotalTable, {"TPESO"}})
Return
/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Monta a estrutura do relatório

@sample


@author Gustavo Baptista
@since 09/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
	Local oReport := Nil
	Local aOrdem  := {}
	Local cTotal  := "Total: "

	CriaTabela()

	oReport := TReport():New("GFER083","Relatório de Frete por Item","GFER083", {|oReport| ReportPrint(oReport)},"Despesa de Frete por Item")
	oReport:SetLandscape()    // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	oReport:NDEVICE := 4

	Pergunte("GFER083",.F.)

	Aadd( aOrdem, "Despesa de Frete por Item" )

	oSection1 := TRSection():New(oReport,"Despesa de Frete por Item",{"(cAliasRel)"},aOrdem)
	oSection1:SetTotalInLine(.F.)

	TRCell():New(oSection1,"(cAliasRel)->ITEM"     ,(cAliasRel),"Cod. Item"       ,"@!"                   , TamSX3("GW8_ITEM" )[1]  )
	TRCell():New(oSection1,"(cAliasRel)->DSITEM"   ,(cAliasRel),"Descrição Item"  ,"@!"                   , TamSX3("GW8_DSITEM" )[1])
	TRCell():New(oSection1,"(cAliasRel)->PESO"     ,(cAliasRel),"Peso Total"      ,"@E 999,999,999,999.99", 20                      )
	TRCell():New(oSection1,"(cAliasRel)->VALOR"    ,(cAliasRel),"Valor Total"     ,"@E 999,999,999,999.99", 20                      )
	TRCell():New(oSection1,"(cAliasRel)->VOLUME"   ,(cAliasRel),"Volume Total"    ,"@E 999,999,999,999.99", 20                      )
	TRCell():New(oSection1,"(cAliasRel)->QTDE"     ,(cAliasRel),"Qtde Total"      ,"@E 999,999,999,999.99", 20                      )
	TRCell():New(oSection1,"(cAliasRel)->DESPFRETE",(cAliasRel),"Despesa Frete"   ,"@E 999,999,999,999.99", 20                      )
	TRCell():New(oSection1,"(cAliasRel)->FRPESO"   ,(cAliasRel),"$ Frete x Peso"  ,"@E 999,999,999,999.99", 20                      )
	TRCell():New(oSection1,"(cAliasRel)->FRVAL"    ,(cAliasRel),"% Frete x Valor" ,"@E 999,999,999,999.99", 20                      )
	TRCell():New(oSection1,"(cAliasRel)->FRVOL"    ,(cAliasRel),"$ Frete x Volume","@E 999,999,999,999.99", 20                      )
	TRCell():New(oSection1,"(cAliasRel)->FRQTD"    ,(cAliasRel),"$ Frete x Qtde"  ,"@E 999,999,999,999.99", 20                      )

	oSection2 := TRSection():New(oSection1,"Total",{"cAliasTot"},aOrdem) // Totalizadores
	oSection2:SetTotalInLine(.F.)
	oSection2:SetHeaderSection(.F.)
	TRCell():New(oSection2,"cTotal"              ,""         ,""                      ,"@!"                   , TamSX3("GW8_ITEM")[1]  ,/*lPixel*/,{||cTotal})
	TRCell():New(oSection2,"cTotal"              ,""         ,""                      ,"@!"                   , TamSX3("GW8_DSITEM")[1],/*lPixel*/)
	TRCell():New(oSection2,"(cAliasTot)->TPESO"  ,(cAliasTot),"Total Peso"            ,"@E 999,999,999,999.99", 20                     ,/*lPixel*/)
	TRCell():New(oSection2,"(cAliasTot)->TVAL"   ,(cAliasTot),"Total Valor"           ,"@E 999,999,999,999.99", 20                     ,/*lPixel*/)
	TRCell():New(oSection2,"(cAliasTot)->TVOL"   ,(cAliasTot),"Total Volume"          ,"@E 999,999,999,999.99", 20                     ,/*lPixel*/)
	TRCell():New(oSection2,"(cAliasTot)->TQTD"   ,(cAliasTot),"Total Quantidade"      ,"@E 999,999,999,999.99", 20                     ,/*lPixel*/)
	TRCell():New(oSection2,"(cAliasTot)->TFRETE" ,(cAliasTot),"Total Frete"           ,"@E 999,999,999,999.99", 20                     ,/*lPixel*/)
	TRCell():New(oSection2,"(cAliasTot)->TFRPESO",(cAliasTot),"Total $ Frete x Peso"  ,"@E 999,999,999,999.99", 20                     ,/*lPixel*/)
	TRCell():New(oSection2,"(cAliasTot)->TFRVAL" ,(cAliasTot),"Total % Frete x Valo"  ,"@E 999,999,999,999.99", 20                     ,/*lPixel*/)
	TRCell():New(oSection2,"(cAliasTot)->TFRVOL" ,(cAliasTot),"Total $ Frete x Volume","@E 999,999,999,999.99", 20                     ,/*lPixel*/)
	TRCell():New(oSection2,"(cAliasTot)->TFRQTD" ,(cAliasTot),"Total $ Frete x Qtde"  ,"@E 999,999,999,999.99", 20                     ,/*lPixel*/)

Return(oReport)

Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)

	oReport:SetMeter(0)

	CarregaDados(oReport)

	dbSelectArea((cAliasRel))
	oReport:SetMeter((cAliasRel)->( LastRec() ))
	(cAliasRel)->( dbGoTop() )

	oSection1:Init()

	While !((cAliasRel)->(Eof()))
		oSection1:PrintLine()
		(cAliasRel)->(DbSkip())
	EndDo
	oSection2:Init()
	oSection2:PrintLine()
	oSection2:Finish()

	oSection1:Finish()
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaDados
Realiza a busca dos dados da seleção e cria a tabela temporária de impressão
Generico.

@sample
CarregaDados()

@author Gustavo Baptista
@since 09/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaDados(oReport)
Local cAliasGW1  := GetNextAlias()
Local cAliasItDc := ""
Local nFrete     := 0

	cFilialIni  := MV_PAR01
	cFilialFim  := MV_PAR02
	dDataIni    := MV_PAR03
	dDataFim    := MV_PAR04
	cItemIni    := MV_PAR05
	cItemFim    := MV_PAR06
	cImpRecup   := MV_PAR07
	cImpAuton   := MV_PAR08
	cDctSemDesp := MV_PAR09
	cTipDesp    := MV_PAR10
	cCritRat    := MV_PAR11

	cQuery := "SELECT GW1_FILIAL, GW1_CDTPDC, GW1_EMISDC, GW1_SERDC, GW1_NRDC"
	cQuery +=  " FROM "+RetSqlName('GW1')+" GW1"
	cQuery += " WHERE GW1.GW1_FILIAL >= '"+cFilialIni+"'"
	cQuery +=   " AND GW1.GW1_FILIAL <= '"+cFilialFim+"'"
	cQuery +=   " AND GW1.GW1_DTEMIS >= '"+DtoS(dDataIni)+"'"
	cQuery +=   " AND GW1.GW1_DTEMIS <= '"+DtoS(dDataFim)+"'"
	cQuery +=   " AND GW1.D_E_L_E_T_ = ' '"
	cQuery += " ORDER BY GW1_FILIAL, GW1_CDTPDC, GW1_EMISDC, GW1_SERDC, GW1_NRDC"
	cQuery := ChangeQuery(cQuery)
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasGW1,.F.,.T.)

	While !oReport:Cancel() .And. !(cAliasGW1)->(Eof())

		oReport:IncMeter()

		cAliasItDc := GFERMntQry(cAliasGW1)

		// Caso seja parametrizado para imprimir os dois tipos de despesas (opção 3 - Realizada/Prevista),
		// primeiramente o Sistema verifica se o documento de carga possui rateios de frete gerados a partir
		// de documentos de frete ou contratos com autônomo (GWM_TPDOC = 2 ou 3, ou seja, despesa Realizada).
		// Caso não tenha encontrado, irá realizar a busca de rateios gerados a partir de cálculo de frete
		// (GWM_TPDOC = 1, ou seja, despesa Prevista).
		If (cAliasItDc)->(Eof()) .And. cTipDesp == 3
			(cAliasItDc)->(DbCloseArea()) // Fecha o cursor anterior
			cAliasItDc := GFERMntQry(cAliasGW1,.F.)
		EndIf

		// Caso não encontre com despesa de frete
		If (cAliasItDc)->(Eof()) .And. cDctSemDesp == 1
			(cAliasItDc)->(DbCloseArea()) // Fecha o cursor anterior
			cAliasItDc := GFERMntQry(cAliasGW1,,.F.)
		EndIf

		While !(cAliasItDc)->(Eof())

			(cAliasRel)->(DbSetOrder(1))
			// Verifica se o item existe na tabela temporária
			If (cAliasRel)->(DbSeek((cAliasItDc)->GW8_ITEM))
				// Altera o registro corrente
				RecLock((cAliasRel),.F.)
			Else
				// Cria um novo registro com o novo item
				RecLock((cAliasRel),.T.)
				(cAliasRel)->ITEM   := (cAliasItDc)->GW8_ITEM
				(cAliasRel)->DSITEM := (cAliasItDc)->GW8_DSITEM
			EndIf
			(cAliasRel)->PESO   += (cAliasItDc)->GW8_PESOR
			(cAliasRel)->VALOR  += (cAliasItDc)->GW8_VALOR
			(cAliasRel)->VOLUME += (cAliasItDc)->GW8_VOLUME
			(cAliasRel)->QTDE   += (cAliasItDc)->GW8_QTDE

			If (cAliasItDc)->(FieldPos("GWM_FILIAL")) > 0

				CarregaImpostos(cAliasItDc)

				nFrete := nVlFret

				// Impostos a recuperar
				// 1 = Descontar - Deve-se subtrair o valor de ICMS, PIS e COFINS do valor do frete
				If cImpRecup == 1
					If AllTrim((cAliasItDc)->GWM_TPDOC) == '1' // Cálculo Frete
						nFrete := FretePrevisto(nFrete,cAliasItDc)
					ElseIf AllTrim((cAliasItDc)->GWM_TPDOC) == '2' // CTRC/NFS
						nFrete := FreteRealizado(nFrete,cAliasItDc)
					EndIf
				EndIf

				// Impostos dos Autônomos = 2 - Adicionar
				If cImpAuton == 2 .And. AllTrim((cAliasItDc)->GWM_TPDOC) == '3'
					nFrete += nVlIss + nVlIrrf + nVlInau + nVlInem + nVlSest + nVlIBM
				EndIf

				(cAliasRel)->DESPFRETE += nFrete
			EndIf
			(cAliasRel)->(MsUnlock())

			(cAliasItDc)->(DbSkip())
		EndDo
		(cAliasItDc)->(DbCloseArea())

		(cAliasGW1)->(DbSkip())
	EndDo

	// Atualiza a tabela com os valores que precisam ser calculados
	(cAliasRel)->( DbGoTop() )
	RecLock((cAliasTot), .T.)
	While !((cAliasRel)->(Eof()))
		RecLock((cAliasRel), .F.)
		(cAliasRel)->FRPESO := ((cAliasRel)->DESPFRETE / (cAliasRel)->PESO )
		(cAliasRel)->FRVAL  := ((cAliasRel)->DESPFRETE / (cAliasRel)->VALOR ) * 100
		(cAliasRel)->FRVOL  := ((cAliasRel)->DESPFRETE / (cAliasRel)->VOLUME )
		(cAliasRel)->FRQTD  := ((cAliasRel)->DESPFRETE / (cAliasRel)->QTDE )
		(cAliasRel)->(MsUnlock())

		// Gera totalizadores
		(cAliasTot)->TPESO   += (cAliasRel)->PESO
		(cAliasTot)->TVAL    += (cAliasRel)->VALOR
		(cAliasTot)->TVOL    += (cAliasRel)->VOLUME
		(cAliasTot)->TQTD    += (cAliasRel)->QTDE
		(cAliasTot)->TFRETE  += (cAliasRel)->DESPFRETE
		(cAliasTot)->TFRPESO += (cAliasRel)->FRPESO
		(cAliasTot)->TFRVAL  += (cAliasRel)->FRVAL
		(cAliasTot)->TFRVOL  += (cAliasRel)->FRVOL
		(cAliasTot)->TFRQTD  += (cAliasRel)->FRQTD

		(cAliasRel)->(DbSkip())
	EndDo
	(cAliasTot)->(MsUnlock())

	(cAliasGW1)->(DbCloseArea())

Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFERMntQry
Retorna um cursor com os itens do documento de carga e os respectivos rateios contábeis

@author  Guilherme A. Metzger
@since   16/11/2015
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function GFERMntQry(cAliasGW1,lFirst,lDespesa)
Local cAliasQry := GetNextAlias()
Local cQuery    := ""

Default lFirst   := .T.
Default lDespesa := .T.

	// Busca itens do documento com despesa
	If lDespesa
		cQuery := "SELECT GW8_ITEM, GW8_DSITEM, GW8_PESOR, GW8_VALOR, GW8_VOLUME, GW8_QTDE,"
		cQuery += " GWM_FILIAL, GWM_CDESP, GWM_CDTRP, GWM_SERDOC, GWM_NRDOC, GWM_TPDOC, GWM_DTEMIS,"
		If cCritRat == 1 // Peso Carga
			cQuery += " GWM_VLFRET, GWM_VLISS, GWM_VLIRRF, GWM_VLINAU, GWM_VLINEM, GWM_VLSEST, GWM_VLICMS, GWM_VLCOFI, GWM_VLPIS"
			If GFXCP2510('GWM_VLIBS') .And. GFXCP2510('GWM_VLIBM') .And. GFXCP2510('GWM_VLCBS')
				cQuery += ", GWM.GWM_VLIBS GWM_VLIBS, GWM.GWM_VLIBM GWM_VLIBM, GWM.GWM_VLCBS GWM_VLCBS"
			EndIf
		ElseIf cCritRat == 2 // Valor Carga
			cQuery += " GWM_VLFRE1, GWM_VLISS1, GWM_VLIRR1, GWM_VLINA1, GWM_VLINE1, GWM_VLSES1, GWM_VLICM1, GWM_VLCOF1, GWM_VLPIS1"
			If GFXCP2510('GWM_VLIBS1') .And. GFXCP2510('GWM_VLIBM1') .And. GFXCP2510('GWM_VLCBS1')
				cQuery += ", GWM.GWM_VLIBS1 GWM_VLIBS, GWM.GWM_VLIBM1 GWM_VLIBM, GWM.GWM_VLCBS1 GWM_VLCBS "
			EndIf
		ElseIf cCritRat == 3 //Quantidade Itens
			cQuery += " GWM_VLFRE2, GWM_VLISS2, GWM_VLIRR2, GWM_VLINA2, GWM_VLINE2, GWM_VLSES2, GWM_VLICM2, GWM_VLCOF2, GWM_VLPIS2"
			If GFXCP2510('GWM_VLIBS2') .And. GFXCP2510('GWM_VLIBM2') .And. GFXCP2510('GWM_VLCBS2')
				cQuery += ", GWM.GWM_VLIBS2 GWM_VLIBS, GWM.GWM_VLIBM2 GWM_VLIBM, GWM.GWM_VLCBS2 GWM_VLCBS "
			EndIf
		ElseIf cCritRat == 4 // Volume Carga
			cQuery += " GWM_VLFRE3, GWM_VLISS3, GWM_VLIRR3, GWM_VLINA3, GWM_VLINE3, GWM_VLSES3, GWM_VLICM3, GWM_VLCOF3, GWM_VLPIS3"
			If GFXCP2510('GWM_VLIBS3') .And. GFXCP2510('GWM_VLIBM3') .And. GFXCP2510('GWM_VLCBS3')
				cQuery += ", GWM.GWM_VLIBS3 GWM_VLIBS, GWM.GWM_VLIBM3 GWM_VLIBM, GWM.GWM_VLCBS3 GWM_VLCBS "
			EndIf
		EndIf
		cQuery +=  " FROM "+RetSqlName('GW8')+" GW8"
		cQuery +=   " INNER JOIN "+RetSqlName('GWM')+" GWM"
		cQuery +=    " ON GWM.GWM_FILIAL = GW8.GW8_FILIAL"
		cQuery +=   " AND GWM.GWM_CDTPDC = GW8.GW8_CDTPDC"
		cQuery +=   " AND GWM.GWM_EMISDC = GW8.GW8_EMISDC"
		cQuery +=   " AND GWM.GWM_SERDC  = GW8.GW8_SERDC"
		cQuery +=   " AND GWM.GWM_NRDC   = GW8.GW8_NRDC"
		cQuery +=   " AND GWM.GWM_SEQGW8 = GW8.GW8_SEQ"
		If cTipDesp == 1 .Or. !lFirst
			cQuery += " AND GWM.GWM_TPDOC = '1'" // Despesa prevista
			// Se for cTipDesp == 3 buscando por despesa prevista quer dizer
			// que não encontrou realizada, então não precisa dessa validação
			If cTipDesp == 1
				cQuery += " AND NOT EXISTS (SELECT 1"
				cQuery +=                   " FROM "+RetSqlName('GWM')+" GWMB"
				cQuery +=                  " WHERE GWMB.GWM_FILIAL  = GWM.GWM_FILIAL"
				cQuery +=                     " AND GWMB.GWM_CDTPDC = GWM.GWM_CDTPDC"
				cQuery +=                     " AND GWMB.GWM_EMISDC = GWM.GWM_EMISDC"
				cQuery +=                     " AND GWMB.GWM_SERDC  = GWM.GWM_SERDC"
				cQuery +=                     " AND GWMB.GWM_NRDC   = GWM.GWM_NRDC"
				cQuery +=                     " AND GWMB.GWM_SEQGW8 = GWM.GWM_SEQGW8"
				cQuery +=                     " AND (GWMB.GWM_TPDOC = '2' OR GWMB.GWM_TPDOC = '3')"
				cQuery +=                     " AND GWMB.D_E_L_E_T_ = ' ')"
			EndIf
		Else
			cQuery += " AND (GWM.GWM_TPDOC = '2' OR GWM.GWM_TPDOC = '3')" // Despesa realizada
		EndIf
		cQuery +=   " AND GWM.D_E_L_E_T_ = ' '"
		cQuery += " WHERE GW8.GW8_FILIAL = '"+(cAliasGW1)->GW1_FILIAL+"'"
		cQuery +=   " AND GW8.GW8_CDTPDC = '"+(cAliasGW1)->GW1_CDTPDC+"'"
		cQuery +=   " AND GW8.GW8_EMISDC = '"+(cAliasGW1)->GW1_EMISDC+"'"
		cQuery +=   " AND GW8.GW8_SERDC  = '"+(cAliasGW1)->GW1_SERDC+"'"
		cQuery +=   " AND GW8.GW8_NRDC   = '"+(cAliasGW1)->GW1_NRDC+"'"
		cQuery +=   " AND GW8.GW8_ITEM  >= '"+cItemIni+"'"
		cQuery +=   " AND GW8.GW8_ITEM  <= '"+cItemFim+"'"
		cQuery +=   " AND GW8.D_E_L_E_T_ = ' '"
		cQuery += " ORDER BY GW8.GW8_SEQ"
		cQuery := ChangeQuery(cQuery)
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.F.,.T.)
	Else
		// Busca itens do documento sem despesa
		cQuery := "SELECT GW8_ITEM, GW8_DSITEM, GW8_PESOR, GW8_VALOR, GW8_VOLUME, GW8_QTDE"
		cQuery +=  " FROM "+RetSqlName('GW8')+" GW8"
		cQuery += " WHERE GW8.GW8_FILIAL = '"+(cAliasGW1)->GW1_FILIAL+"'"
		cQuery +=   " AND GW8.GW8_CDTPDC = '"+(cAliasGW1)->GW1_CDTPDC+"'"
		cQuery +=   " AND GW8.GW8_EMISDC = '"+(cAliasGW1)->GW1_EMISDC+"'"
		cQuery +=   " AND GW8.GW8_SERDC  = '"+(cAliasGW1)->GW1_SERDC+"'"
		cQuery +=   " AND GW8.GW8_NRDC   = '"+(cAliasGW1)->GW1_NRDC+"'"
		cQuery +=   " AND GW8.GW8_ITEM  >= '"+cItemIni+"'"
		cQuery +=   " AND GW8.GW8_ITEM  <= '"+cItemFim+"'"
		cQuery +=   " AND GW8.D_E_L_E_T_ = ' '"
		If cTipDesp == 1 .Or. cTipDesp == 2
			cQuery += " AND NOT EXISTS (SELECT 1"
			cQuery +=                   " FROM "+RetSqlName('GWM')+" GWM"
			cQuery +=                  " WHERE GWM.GWM_FILIAL  = GW8.GW8_FILIAL"
			cQuery +=                     " AND GWM.GWM_CDTPDC = GW8.GW8_CDTPDC"
			cQuery +=                     " AND GWM.GWM_EMISDC = GW8.GW8_EMISDC"
			cQuery +=                     " AND GWM.GWM_SERDC  = GW8.GW8_SERDC"
			cQuery +=                     " AND GWM.GWM_NRDC   = GW8.GW8_NRDC"
			cQuery +=                     " AND GWM.GWM_SEQGW8 = GW8.GW8_SEQ"
			cQuery +=                     " AND GWM.D_E_L_E_T_ = ' ')"
		EndIf
		cQuery += " ORDER BY GW8.GW8_SEQ"
		cQuery := ChangeQuery(cQuery)
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.F.,.T.)
	EndIf

Return cAliasQry

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} FretePrevisto
Efetua os descontos do frete previsto ( se for possível)

@author Gustavo H. Baptista
@since 10/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function FretePrevisto(nFrete,cAliasItDc)
	// Busca o cálculo de frete relacionado ao Movimento Contábil
	GWF->(DbSetOrder(1))
	If GWF->(DbSeek((cAliasItDc)->GWM_FILIAL+(cAliasItDc)->GWM_NRDOC))
		// Descontar impostos recuperáveis
		// Retira o ICMS
		If GWF->GWF_CRDICM == "1"
			nFrete -= (nVlIcms + nVlIBS)
		EndIf
		// Retira o PIS e COFINS
		If GWF->GWF_CRDPC == "1"
			nFrete -= (nVlCofi + nVlPis + nVlCBS)
		EndIf
	EndIf
Return nFrete

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} FreteRealizado
Efetua os descontos do frete realizado ( se for possível)

@author Gustavo H. Baptista
@since 10/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function FreteRealizado(nFrete,cAliasItDc)
	// Busca o cálculo de frete relacionado ao Movimento Contábil
	GW3->(DbSetOrder(1))
	If GW3->(DbSeek((cAliasItDc)->GWM_FILIAL+(cAliasItDc)->GWM_CDESP+(cAliasItDc)->GWM_CDTRP+(cAliasItDc)->GWM_SERDOC+(cAliasItDc)->GWM_NRDOC+(cAliasItDc)->GWM_DTEMIS))
		// Descontar impostos recuperáveis
		// Retira o ICMS
		If GW3->GW3_CRDICM == "1"
			nFrete -= (nVlIcms + nVlIBS)
		EndIf
		// Retira o PIS e COFINS
		If GW3->GW3_CRDPC == "1"
			nFrete -= (nVlCofi + nVlPis + nVlCBS)
		EndIf
	EndIf
Return nFrete

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaImpostos
Carrega os valores de impostos que devem ser considerados no cálculo do frete

@author Gustavo H. Baptista
@since 19/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaImpostos(cAliasItDc)

	If cCritRat == 1 //Peso Carga
		nVlFret  := (cAliasItDc)->GWM_VLFRET
		nVlIss   := (cAliasItDc)->GWM_VLISS
		nVlIrrf  := (cAliasItDc)->GWM_VLIRRF
		nVlInau  := (cAliasItDc)->GWM_VLINAU
		nVlInem  := (cAliasItDc)->GWM_VLINEM
		nVlSest  := (cAliasItDc)->GWM_VLSEST
		nVlIcms  := (cAliasItDc)->GWM_VLICMS
		nVlCofi  := (cAliasItDc)->GWM_VLCOFI
		nVlPis   := (cAliasItDc)->GWM_VLPIS
		nVlIBS   := Iif(GFXCP2510("GWM_VLIBS"), (cAliasItDc)->GWM_VLIBS, 0)
		nVlIBM   := Iif(GFXCP2510("GWM_VLIBM"), (cAliasItDc)->GWM_VLIBM, 0)
		nVlCBS   := Iif(GFXCP2510("GWM_VLCBS"), (cAliasItDc)->GWM_VLCBS, 0)
	ElseIf cCritRat == 2 //Valor Carga
		nVlFret  := (cAliasItDc)->GWM_VLFRE1
		nVlIss   := (cAliasItDc)->GWM_VLISS1
		nVlIrrf  := (cAliasItDc)->GWM_VLIRR1
		nVlInau  := (cAliasItDc)->GWM_VLINA1
		nVlInem  := (cAliasItDc)->GWM_VLINE1
		nVlSest  := (cAliasItDc)->GWM_VLSES1
		nVlIcms  := (cAliasItDc)->GWM_VLICM1
		nVlCofi  := (cAliasItDc)->GWM_VLCOF1
		nVlPis   := (cAliasItDc)->GWM_VLPIS1
		nVlIBS   := Iif(GFXCP2510("GWM_VLIBS1"), (cAliasItDc)->GWM_VLIBS, 0)
		nVlIBM   := Iif(GFXCP2510("GWM_VLIBM1"), (cAliasItDc)->GWM_VLIBM, 0)
		nVlCBS   := Iif(GFXCP2510("GWM_VLCBS1"), (cAliasItDc)->GWM_VLCBS, 0)
	ElseIf cCritRat == 3 //Quantidade Itens
		nVlFret  := (cAliasItDc)->GWM_VLFRE2
		nVlIss   := (cAliasItDc)->GWM_VLISS2
		nVlIrrf  := (cAliasItDc)->GWM_VLIRR2
		nVlInau  := (cAliasItDc)->GWM_VLINA2
		nVlInem  := (cAliasItDc)->GWM_VLINE2
		nVlSest  := (cAliasItDc)->GWM_VLSES2
		nVlIcms  := (cAliasItDc)->GWM_VLICM2
		nVlCofi  := (cAliasItDc)->GWM_VLCOF2
		nVlPis   := (cAliasItDc)->GWM_VLPIS2
		nVlIBS   := Iif(GFXCP2510("GWM_VLIBS2"), (cAliasItDc)->GWM_VLIBS, 0)
		nVlIBM   := Iif(GFXCP2510("GWM_VLIBM2"), (cAliasItDc)->GWM_VLIBM, 0)
		nVlCBS   := Iif(GFXCP2510("GWM_VLCBS2"), (cAliasItDc)->GWM_VLCBS, 0)
	ElseIf cCritRat == 4 //Volume Carga
		nVlFret  := (cAliasItDc)->GWM_VLFRE3
		nVlIss   := (cAliasItDc)->GWM_VLISS3
		nVlIrrf  := (cAliasItDc)->GWM_VLIRR3
		nVlInau  := (cAliasItDc)->GWM_VLINA3
		nVlInem  := (cAliasItDc)->GWM_VLINE3
		nVlSest  := (cAliasItDc)->GWM_VLSES3
		nVlIcms  := (cAliasItDc)->GWM_VLICM3
		nVlCofi  := (cAliasItDc)->GWM_VLCOF3
		nVlPis   := (cAliasItDc)->GWM_VLPIS3
		nVlIBS   := Iif(GFXCP2510("GWM_VLIBS3"), (cAliasItDc)->GWM_VLIBS, 0)
		nVlIBM   := Iif(GFXCP2510("GWM_VLIBM3"), (cAliasItDc)->GWM_VLIBM, 0)
		nVlCBS   := Iif(GFXCP2510("GWM_VLCBS3"), (cAliasItDc)->GWM_VLCBS, 0)
	EndIf
Return

