/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'Protheus.ch'
#include 'WMSR371.ch'

//-----------------------------------------------------------
/*/{Protheus.doc} WMSR371
Geração e impressão do mapa de separação embalado

@version	P11
@since   03/05/06 - revisão 17/09/14
/*/
//-----------------------------------------------------------
User Function WmsR371()
Local oReport
	If !SuperGetMV("MV_WMSNEW", .F., .F.)
		Return WmsR370()
	EndIf
	// Interface de impressão
	oReport := ReportDef()
	oReport:PrintDialog()
Return
//-----------------------------------------------------------
// Definições do relatório
//-----------------------------------------------------------
Static Function ReportDef()
Local oReport, oSection1, oSection2, oBreak
Local cAliasRel  := GetNextAlias()
Local aTamConv   := TamSx3("B1_CONV")

	// Definição do relatório
	oReport := TReport():New('WMSR371', STR0001,'WMSR371',{|oReport| ReportPrint(oReport,cAliasRel)},STR0030) // Mapa de Separação Embalado ## Este relatório tem por objetivo Gerar e Imprimir ou apenas Imprimir um Mapa de Separação para quantidades em unidades agrupadoras (caixas, por exemplo), de acordo com os parâmetros informados.
	oReport:SetColSpace(2)
	oReport:lParamPage := .F.
	// Verifica os parâmetros selecionados via Pergunte
	Pergunte(oReport:GetParam(),.F.)

	// Seção 1 - Informações do mapa de separação e documento
	// TRSection:New(oParent,cTitle,uTable,aOrder,lLoadCells,lLoadOrder,uTotalText,lTotalInLine,lHeaderPage,lHeaderBreak,lPageBreak,lLineBreak,nLeftMargin,lLineStyle,nColSpace,lAutoSize,cCharSeparator,nLinesBefore,nCols,nClrBack,nClrFore,nPercentage)
	oSection1 := TRSection():New(oReport,STR0031,{'D12','D0T','DA3'},,,,,,,,,,,.T.,,,,,3) // Cabeçalho Mapa de Separação
	TRCell():New(oSection1,'D12_MAPSEP','D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'D12_CARGA' ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'D12_DOC'   ,'D12', STR0032  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,  {|| Iif(WmsCarga((cAliasRel)->D12_CARGA),'',(cAliasRel)->D12_DOC)}  ) // Pedido
	TRCell():New(oSection1,'D12_ENDDES','D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'D12_IDUNIT','D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	If WmsX312118("D0T","D0T_DESUNI",.T.)
		TRCell():New(oSection1,'D0T_DESUNI','D0T',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	EndIf
	TRCell():New(oSection1,'DA3_PLACA' ,'DA3', STR0028  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,  {|| W381Placa()             }  ) // Placa do Veiculo
	TRCell():New(oSection1,'D12_CLIFOR','D12', STR0019  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'D12_LOJA'  ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

	// Seção 2 - Itens do mapa de separação
	oSection2 := TRSection():New(oSection1,STR0033,{'D12','SB1'},,,,,,,,,,,.F.,0) // Itens do Mapa de Separação
	TRCell():New(oSection2,'D12_LOCORI','D12')
	TRCell():New(oSection2,'D12_ENDORI','D12',/*Titulo*/,/*Picture*/,  20       ,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D12_IDUNIT','D12')
	TRCell():New(oSection2,'D12_PRODUT','D12')
	TRCell():New(oSection2,'B1_DESC'   ,'SB1')
	TRCell():New(oSection2,'D12_LOTECT','D12')
	TRCell():New(oSection2,'D12_NUMLOT','D12')
	TRCell():New(oSection2,'D12_QTDMOV','D12', STR0020  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'B1_UM'     ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D12_QTDMO2','D12', STR0021  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Qtde Emb
	TRCell():New(oSection2,'B1_SEGUM'  ,'SB1',/*Titulo*/,/*Picture*/,TamSx3("B1_SEGUM")[1]+4+aTamConv[1],/*lPixel*/,{|| (cAliasRel)->B1_SEGUM + ' ' + STR0022 + ' ' + LTrim(Str((cAliasRel)->B1_CONV,aTamConv[1],aTamConv[2])) })
	TRCell():New(oSection2,'D12_CLIFOR','D12', STR0019  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D12_LOJA'  ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

	// Cabeçalhos e células que não devem aparecer no relatório
	oSection2:Cell('B1_UM'   ):HideHeader()
	oSection2:Cell('B1_SEGUM'):HideHeader()

	// Definição das quebras e totalizadores que serão impressos
	oBreak := TRBreak():New(oSection1,oSection1:Cell('D12_MAPSEP'),STR0029,.T.) // 'Totais'
	TRFunction():New(oSection2:Cell('D12_PRODUT'),NIL,'COUNT',oBreak, STR0023   ,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.) // Nr. Itens
	TRFunction():New(oSection2:Cell('D12_QTDMO2'),NIL,'SUM'  ,oBreak,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oSection2:Cell('D12_PRODUT'),Nil,'SUM'  ,oBreak, STR0024   ,PesqPictQt('B1_PESO'),{|| ((cAliasRel)->D12_QTDMOV * (cAliasRel)->B1_PESO) },.F.,.F.,.F.)
	TRFunction():New(oSection2:Cell('D12_PRODUT'),Nil,'SUM'  ,oBreak, STR0025   ,"@E 999,999,999.9999",{|| ((cAliasRel)->D12_QTDMOV * (cAliasRel)->B5_ALTURLC * (cAliasRel)->B5_LARGLC * (cAliasRel)->B5_COMPRLC) },.F.,.F.,.F.)
Return oReport
//-----------------------------------------------------------
// Impressão do relatório
//-----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasRel)
Local oSection1 := oReport:Section(1)
Local oSection2 := oSection1:Section(1)
Local cSemMpSep := Space(TamSX3("D12_MAPSEP")[1])
Local cWhere    := ''
Local cMapa     := ''
Local cCodUni   := ''
Local cDesUni   := ''
Local cCodCFG   := ""
Local cPicCFG   := ""
Local cSeekQry  := ''
Local bSeekQry  := {||.T.}

	If WmsX112118("WMSR371","10") .And. mv_par10 == 2 // Imprime Lote ? 2=Não
		oSection2:Cell("D12_LOTECT"):Disable()
		oSection2:Cell("D12_NUMLOT"):Disable()
	EndIf
	If WmsX112118("WMSR371","11") .And. mv_par11 == 2 // Imprime Unitizador ? 2=Não
		oSection2:Cell("D12_IDUNIT"):Disable()
	EndIf

	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())

	If mv_par01 == 1
		cWhere := "% D12.D12_STATUS = '4'"
		cWhere += " AND D12.D12_CARGA BETWEEN '"+mv_par02+"' AND '"+mv_par03+"'"
		cWhere += " AND D12.D12_DOC BETWEEN '"+mv_par04+"' AND '"+mv_par05+"'"
		If mv_par09 == 1
			cWhere += " AND D12.D12_MAPSEP  BETWEEN '"+mv_par06+"' AND '"+mv_par07+"' %"
		Else
			cWhere += " AND D12.D12_MAPSEP = '"+cSemMpSep+"' %"
		EndIf
	Else
		cWhere := "% D12.D12_MAPSEP BETWEEN '"+mv_par06+"' AND '"+mv_par07+"'"
		cWhere += " AND D12.D12_MAPSEP <> '"+cSemMpSep+"'"
		cWhere += " AND D12.D12_STATUS IN ('4','3','2','-')"
		cWhere += " AND D12.D12_ATUEST = '1' %"
	EndIf

	// Query do relatorio
	oSection1:BeginQuery()
		BeginSql Alias cAliasRel
		SELECT D12.D12_CARGA, D12.D12_SEQCAR, D12.D12_DOC, D12.D12_SERIE, D12.D12_CLIFOR, D12.D12_LOJA,
				 D12.D12_PRODUT, D12.D12_LOTECT, D12.D12_NUMLOT, D12.D12_QTDMOV, D12.D12_QTDMO2, D12.D12_LOCORI, D12.D12_ENDORI, 
				 D12.D12_IDUNIT, D12.D12_ENDDES, D12.D12_MAPSEP, D12.D12_IDMOV,  D12.R_E_C_N_O_ RECNOD12, D12.D12_ATUEST, SB1.B1_CONV,
				 SB1.B1_DESC, SB1.B1_UM, SB1.B1_SEGUM, SB1.B1_PESO, SB5.B5_ALTURLC, SB5.B5_LARGLC, SB5.B5_COMPRLC, SBE.BE_CODCFG
		  FROM %table:D12% D12
		 INNER JOIN %table:SB1% SB1
			 ON SB1.B1_FILIAL = %xFilial:SB1%
			AND SB1.B1_COD = D12.D12_PRODUT
			AND SB1.%NotDel%
		 INNER JOIN %table:SB5% SB5
			 ON SB5.B5_FILIAL = %xFilial:SB5%
			AND SB5.B5_COD = D12.D12_PRODUT
			AND SB5.B5_WMSEMB = '1'
			AND SB5.%NotDel%
		INNER JOIN %table:SBE% SBE
			ON SBE.BE_FILIAL  = %xFilial:SBE%
		  AND SBE.BE_LOCAL   = D12.D12_LOCORI
		  AND SBE.BE_LOCALIZ = D12.D12_ENDORI
		  AND SBE.%NotDel%
		 WHERE D12.D12_FILIAL = %xFilial:D12%
			AND D12.D12_ORIGEM = 'SC9'
			AND D12.D12_MAPTIP = '2'
			AND %Exp:cWhere%
			AND D12.%NotDel%
		 ORDER BY D12.D12_CARGA,D12.D12_SEQCAR,D12.D12_CLIFOR,D12.D12_LOJA,D12.D12_DOC,
			       D12.D12_SERIE,D12.D12_ENDDES,D12.D12_ENDORI,D12.D12_IDUNIT
		EndSql
	oSection1:EndQuery()

	// Definindo as secoes filhas para utilizarem a query da secao pai
	oSection2:SetParentQuery()

	// Fluxo de impressão do relatório
	oReport:SetMeter((cAliasRel)->(LastRec()))

	While !oReport:Cancel() .And. !(cAliasRel)->(Eof())

		If mv_par01 == 1
			cMapa := WMSProxSeq("MV_WMSMPSP","D12_MAPSEP")
		Else
			cMapa := (cAliasRel)->D12_MAPSEP
		EndIf

		// Busca código e descrição do unitizador
		If WmsArmUnit((cAliasRel)->D12_LOCORI)
			W381DesUni((cAliasRel)->D12_LOCORI,(cAliasRel)->D12_ENDORI,(cAliasRel)->D12_PRODUT,@cCodUni,@cDesUni)
		EndIf

		oSection1:Init()

		// Início da impressão das informações do mapa de separação e documento
		oSection1:Cell('D12_MAPSEP' ):SetValue(cMapa)
		oSection1:Cell('D12_IDUNIT' ):SetValue(cCodUni)
		If WmsX312118("D0T","D0T_DESUNI",.T.)
			oSection1:Cell('D0T_DESUNI'):SetValue(cDesUni)
		EndIf

		// Impressão do código de barras
		oReport:PrintText('')
		oReport:SkipLine(5)

		MSBAR3("CODE128",2,0.5,Trim(cMapa),@oReport:oPrint,Nil,Nil,Nil,Nil ,1 ,Nil,Nil,Nil,.F.,,,.F.)

		// Guarda as informações para controlar a geração e impressão de uma CARGA por mapa de separação, se utilizar carga
		// Ou um PEDIDO por mapa de separação, se não utilizar carga
		// Independente da quebra escolhida, deverá agrupar primeiro pelo número do mapa
		// Pois pode ser que a geração tenha sido feita por um agrupamento a impressão seja por outra
		// Desta forma deverá quebrar por mapa cada página a ser impressa
		// Quando não tem mapa gerado este campo está em branco não influenciando na quebra
		If WmsCarga((cAliasRel)->D12_CARGA)
			oSection1:Cell('D12_CLIFOR'):Disable()
			oSection1:Cell('D12_LOJA'):Disable()
			oSection2:Cell('D12_CLIFOR'):Enable()
			oSection2:Cell('D12_LOJA'):Enable()
			cSeekQry := (cAliasRel)->D12_MAPSEP+(cAliasRel)->D12_CARGA+(cAliasRel)->D12_SEQCAR+(cAliasRel)->D12_ENDDES
			bSeekQry := {|| cSeekQry == (cAliasRel)->D12_MAPSEP+(cAliasRel)->D12_CARGA+(cAliasRel)->D12_SEQCAR+(cAliasRel)->D12_ENDDES}
		Else
			oSection1:Cell('D12_CLIFOR'):Enable()
			oSection1:Cell('D12_LOJA'):Enable()
			oSection2:Cell('D12_CLIFOR'):Disable()
			oSection2:Cell('D12_LOJA'):Disable()
			cSeekQry := (cAliasRel)->D12_MAPSEP+(cAliasRel)->D12_DOC+(cAliasRel)->D12_CLIFOR+(cAliasRel)->D12_ENDDES
			bSeekQry := {|| cSeekQry == (cAliasRel)->D12_MAPSEP+(cAliasRel)->D12_DOC+(cAliasRel)->D12_CLIFOR+(cAliasRel)->D12_ENDDES}
		EndIf

		oSection1:PrintLine()
		oReport:PrintText(STR0007) // Nr.Separador     : _______________
		oReport:PrintText(STR0008) // Nr.Conferente    : _______________
		oReport:PrintText(STR0009) // Nr.Embalador     : _______________

		oSection2:Init()
		While !oReport:Cancel() .And. (cAliasRel)->(!Eof()) .And. Eval(bSeekQry)

			If cCodCFG <> (cAliasRel)->BE_CODCFG // Verifica se o codigo mudou
				cCodCFG := (cAliasRel)->BE_CODCFG // Atualiza flag
				cPicCFG := DLXPicEnd((cAliasRel)->BE_CODCFG) // Atualiza Picture
				oSection2:Cell('D12_ENDORI'):SetPicture(cPicCFG)
			EndIf
			// Somente imprime a atividade que movimenta estoque
			If (cAliasRel)->D12_ATUEST == "1"
				oSection2:PrintLine()
			EndIf

			// Se gera e imprime, atualiza registro D12
			If mv_par01 == 1
				D12->(DbGoTo((cAliasRel)->RECNOD12))
				RecLock('D12')
				D12->D12_MAPSEP := cMapa
				D12->(MsUnlock())
			EndIf
			oReport:IncMeter()
			(cAliasRel)->(DbSkip())
		EndDo
		oSection2:Finish()
		oSection1:Finish()
		oReport:EndPage()
	EndDo
	(cAliasRel)->(DbCloseArea())
Return
