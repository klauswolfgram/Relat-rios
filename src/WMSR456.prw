/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "WMSR456.CH"
#INCLUDE "PROTHEUS.CH"

//------------------------------------------------------------
/*/{Protheus.doc} WMSR456
Kardex p/ Lote Sobre o D13
@author felipe.m
@since 25/03/2015
@version 1.0
/*/
//------------------------------------------------------------
User Function WMSR456()
Local oReport
	// Permite efetuar validações, apresentar mensagem e abortar o programa quando desejado
	If !WMSChkPrg(FunName(),"3")
		Return Nil
	EndIf
	
	// Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
Return
//------------------------------------------------------------
//  Definições do relatório
//------------------------------------------------------------
Static Function ReportDef()
Local oReport, oSection
Local cTamQtd := TamSX3('D13_QTDEST')[1]
Local cPicQtd := PesqPict("D13","D13_QTDEST",14)
Local cTitLot := RTrim(Posicione('SX3',2,'D13_LOTECT','X3Titulo()'))
Local cTitEnd := RTrim(Posicione('SX3',2,'D13_ENDER','X3Titulo()'))
Local aOrdem  := {cTitEnd+' + '+cTitLot,cTitLot+' + '+cTitEnd}

	// Criacao do componente de impressao
	// TReport():New
	// ExpC1 : Nome do relatorio
	// ExpC2 : Titulo
	// ExpC3 : Pergunte
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	// ExpC5 : Descricao
	oReport := TReport():New("WMSR456",STR0001,"WMSR456", {|oReport| ReportPrint(oReport)},STR0002) // "Kardex Enderecamento"  // Este programa permite emitir um Kardex com todas as movimentações do estoque por endereço diariamente.

	oReport:lParamPage := .F.

	Pergunte(oReport:GetParam(),.F.)
	// Variaveis utilizadas para parametros
	// MV_PAR01 Armazem De?
	// MV_PAR02 Armazem Ate?
	// MV_PAR03 Produto De?
	// MV_PAR04 Produto Ate?
	// MV_PAR05 Lote De?
	// MV_PAR06 Lote Ate?
	// MV_PAR07 Sub-Lote De?
	// MV_PAR08 Sub-Lote Ate?
	// MV_PAR09 Data De?
	// MV_PAR10 Data Ate?
	// MV_PAR11 Endereço De?
	// MV_PAR12 Endereço Ate?
	// MV_PAR13 Num Serie De?
	// MV_PAR14 Num Serie Ate?
	// MV_PAR15 Exibe Quantidades em qual UM?
	// MV_PAR16 Lista Produtos sem movimento ?(1=Sim/2=Nao)
	// MV_PAR17 Sequência Impressão (1=Digitação/2=Cálculo)
	oSection := TRSection():New(oReport,STR0003,{"SB2","SB1","D13"},aOrdem,,,,,,,,,,,0) // Movimentos por Endereco
	oSection:SetHeaderPage()
	// oSection:SetNoFilter("SB1")

	TRCell():New(oSection,"B2_COD"     ,"SB2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"B1_DESC"    ,"SB1",/*Titulo*/,/*Picture*/,50,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.)
	TRCell():New(oSection,"B2_LOCAL"   ,"SB2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"D13_ENDER"  ,"D13",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,1)
	TRCell():New(oSection,"D13_IDUNIT" ,"D13",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.)
	TRCell():New(oSection,"D13_LOTECT" ,"D13",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,1)
	TRCell():New(oSection,"D13_DTESTO" ,"D13",STR0010/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,1)
	TRCell():New(oSection,"D13_DOC"    ,"D13",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,1)
	TRCell():New(oSection,"D13_SERIE"  ,"D13",STR0004   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Série
	TRCell():New(oSection,"D13_SLDINI" ,""   ,STR0005   ,cPicQtd,cTamQtd,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT") // Saldo inicial
	TRCell():New(oSection,"D13_QTDENT" ,""   ,STR0006   ,cPicQtd,cTamQtd,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT") // Entrada 
	TRCell():New(oSection,"D13_QTDSAI" ,""   ,STR0007   ,cPicQtd,cTamQtd,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT") // Saida
	TRCell():New(oSection,"D13_QTDSLD" ,""   ,STR0008   ,cPicQtd,cTamQtd,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT") // Saldo

Return(oReport)
//-----------------------------------------------------------
// Impressão do relatório
//-----------------------------------------------------------
Static Function ReportPrint(oReport)
Local oSection  := oReport:Section(1)
Local nOrdem    := oSection:GetOrder()
Local nSaldoIni := 0
Local nEntrada  := 0
Local nSaida    := 0
Local cProdAnt  := ""
Local lCtrlWms  := .T.
Local lMovtoProd:= .F.
Local cKeyAnt   := ""
Local cOrderBy  := Iif(nOrdem == 1, "%D13.D13_ENDER,D13.D13_LOTECT,D13.D13_NUMLOT%", "%D13.D13_LOTECT,D13.D13_NUMLOT,D13.D13_ENDER%")
Local cAliasD13 := GetNextAlias()
Local cLoteVazio:= Space(TamSX3("D13_LOTECT")[1])
Local cNumLotVaz:= Space(TamSX3("D13_NUMLOT")[1])
Local cWhereSBZ := ""
Local cJoinSBZ := "% %"

	oReport:NoUserFilter() // Desabilita a aplicacao do filtro do usuario no filtro/query das secoes
	// Query do relatório da secao 1
	oSection:BeginQuery()

	If SuperGetMV("MV_ARQPROD",.F.,"SB1") == "SB1"
		cWhereSBZ := "%	AND SB1.B1_LOCALIZ = 'S' %"
	Else
		cWhereSBZ := "% AND CASE WHEN SBZ.BZ_LOCALIZ IS NULL THEN SB1.B1_LOCALIZ ELSE SBZ.BZ_LOCALIZ END = 'S' %"
		cJoinSBZ := "% LEFT JOIN " + RetSqlName("SBZ") + " SBZ "
		cJoinSBZ += "  ON SBZ.BZ_FILIAL = '" + xFilial("SBZ")  + "' "
		cJoinSBZ += " AND SBZ.BZ_COD    = SB2.B2_COD"
		cJoinSBZ += " AND SBZ.D_E_L_E_T_ = ' ' %" 
	EndIf

	BeginSql Alias cAliasD13
		SELECT D13.D13_FILIAL, SB2.B2_LOCAL,   D13.D13_ENDER,  D13.D13_PRDORI, D13.D13_PRODUT, D13.D13_LOTECT,
		       D13.D13_NUMLOT, D13.D13_NUMSER, D13.D13_DTESTO, D13.D13_NUMSEQ, D13.D13_IDOPER, D13.D13_DOC,
		       D13.D13_SERIE,  D13.D13_TM,     SB2.B2_COD,     SB1.B1_DESC,    D13.D13_IDUNIT, D13.D13_QTDEST
		  FROM %table:SB2% SB2
		 INNER JOIN %table:SB1% SB1 
		    ON SB1.B1_FILIAL  = %xFilial:SB1%
		   AND SB1.B1_COD     = SB2.B2_COD
		   AND SB1.%NotDel%
		   %Exp:cJoinSBZ%
		  LEFT JOIN %table:D13% D13
		    ON D13.D13_FILIAL = %xFilial:D13%
		   AND D13.D13_LOCAL  = SB2.B2_LOCAL
		   AND D13.D13_PRDORI = SB2.B2_COD
		   AND ((SB1.B1_RASTRO = 'N' AND D13.D13_LOTECT = %Exp:cLoteVazio%)
		     OR (D13.D13_LOTECT >= %Exp:MV_PAR05% AND D13.D13_LOTECT <= %Exp:MV_PAR06%))
		   AND ((SB1.B1_RASTRO = 'S' AND D13.D13_NUMLOT >= %Exp:MV_PAR07% AND D13.D13_NUMLOT <= %Exp:MV_PAR08%)
		     OR (D13.D13_NUMLOT = %Exp:cNumLotVaz%))
		   AND D13.D13_DTESTO >= %Exp:MV_PAR09%
		   AND D13.D13_DTESTO <= %Exp:MV_PAR10%
		   AND D13.D13_ENDER  >= %Exp:MV_PAR11%
		   AND D13.D13_ENDER  <= %Exp:MV_PAR12%
		   AND D13.D13_NUMSER >= %Exp:MV_PAR13%
		   AND D13.D13_NUMSER <= %Exp:MV_PAR14%
		   AND D13.%NotDel%
		 WHERE SB2.B2_FILIAL  = %xFilial:SB2%
		   %Exp:cWhereSBZ%
		   AND SB2.B2_LOCAL   >= %Exp:MV_PAR01%
		   AND SB2.B2_LOCAL   <= %Exp:MV_PAR02%
		   AND SB2.B2_COD     >= %Exp:MV_PAR03%
		   AND SB2.B2_COD     <= %Exp:MV_PAR04%
		   AND SB2.%NotDel%
		 ORDER BY SB2.B2_COD,SB2.B2_LOCAL,%Exp:cOrderBy%,D13.D13_DTESTO,D13.R_E_C_N_O_
	EndSql
	// Metodo EndQuery ( Classe TRSection )
	// Prepara o relatório para executar o Embedded SQL.
	// ExpA1 : Array com os parametros do tipo Range
	oSection:EndQuery(/*Array com os parametros do tipo Range*/)

	// Inicio da impressao do fluxo do relatório
	oReport:SetMeter( D13->(LastRec()) )
	oSection:Init()
	While !oReport:Cancel() .And. !(cAliasD13)->(Eof())

		nSaldoIni := nEntrada := nSaida := 0
		
		If Empty(cProdAnt) .Or. !(cProdAnt == (cAliasD13)->B2_COD)
			// Se o produto anterior controlava WMS 
			If !Empty(cProdAnt) .And. lCtrlWms .And. (lMovtoProd .Or. (!lMovtoProd .And. MV_PAR16 == 1))
				oReport:ThinLine()
				oReport:SkipLine(1)
			EndIf
			lCtrlWms := IntWms((cAliasD13)->B2_COD)
			lMovtoProd := .F.
		EndIf
		cProdAnt := (cAliasD13)->B2_COD
		// Se o produto não é contolado pelo WMS, não lista no relatório
		If !lCtrlWms
			oReport:IncMeter()
			(cAliasD13)->(DbSkip())
			Loop
		EndIf

		// Mostra as células com informação do produto para listar como cabeçalho
		oSection:Cell("B2_COD"):Show()
		oSection:Cell("B1_DESC"):Show()
		oSection:Cell("B2_LOCAL"):Show()
		oSection:Cell("D13_ENDER"):Show()
		oSection:Cell("D13_LOTECT"):Show()
		oSection:Cell("D13_SLDINI"):Show()
		// Esconde as células com informação de saldo do kardex
		oSection:Cell("D13_IDUNIT"):Hide()
		oSection:Cell("D13_DOC"):Hide()
		oSection:Cell("D13_SERIE"):Hide()
		oSection:Cell("D13_QTDENT"):Hide()
		oSection:Cell("D13_QTDSAI"):Hide()
		oSection:Cell("D13_QTDSLD"):Hide()

		// Se não tem data de movimentação de estoque na D13, indica que não teve movimentação deste produto
		If Empty((cAliasD13)->D13_DTESTO)
			// Se lista produto sem movimentação
			If MV_PAR16 == 1
				nSaldoIni := CalcEst((cAliasD13)->B2_COD,(cAliasD13)->B2_LOCAL,MV_PAR09,,,)[1]
			EndIf
		Else
			nSaldoIni := CalcEstEnd((cAliasD13)->B2_COD,(cAliasD13)->B2_LOCAL,MV_PAR09,(cAliasD13)->D13_ENDER,(cAliasD13)->D13_LOTECT,(cAliasD13)->D13_NUMLOT,(cAliasD13)->D13_NUMSER,(cAliasD13)->D13_PRDORI)
		EndIf

		// Converte o saldo inicial para segunda unidade de medida
		If MV_PAR15 == 2
			nSaldoIni := ConvUM((cAliasD13)->B2_COD, nSaldoIni, 0, 2)
		EndIf
		oSection:Cell("D13_DTESTO"):SetValue(MV_PAR09)
		oSection:Cell("D13_SLDINI"):SetValue(nSaldoIni)

		// Lista produtos sem movimento 1=Sim;2=Não
		If Empty((cAliasD13)->D13_DTESTO)
			If MV_PAR16 == 1
				oReport:IncMeter()
				oSection:PrintLine()
				oReport:PrintText(STR0009) //"Não houve movimentação para este produto"
				oReport:SkipLine(1)
			EndIf
			(cAliasD13)->(dbSkip())
			Loop
		Else
			oSection:PrintLine()
			lMovtoProd := .T.
		EndIf

		// Esconde as células com informação do produto para não listar o cabeçalho
		oSection:Cell("B2_COD"):Hide()
		oSection:Cell("B1_DESC"):Hide()
		oSection:Cell("B2_LOCAL"):Hide()
		oSection:Cell("D13_ENDER"):Hide()
		oSection:Cell("D13_LOTECT"):Hide()
		oSection:Cell("D13_SLDINI"):Hide()
		// Mostra as células com informação de saldo do kardex
		oSection:Cell("D13_IDUNIT"):Show()
		oSection:Cell("D13_DTESTO"):Show()
		oSection:Cell("D13_DOC"):Show()
		oSection:Cell("D13_SERIE"):Show()
		oSection:Cell("D13_QTDSLD"):Show()
		
		oSection:Cell("D13_DTESTO"):SetValue(Nil) // Para voltar a imprimir com base na query

		cKeyAnt := (cAliasD13)->(B2_COD+B2_LOCAL+D13_ENDER+D13_LOTECT+D13_NUMLOT+D13_NUMSER+D13_PRDORI)

		Do While !oReport:Cancel() .And. (cAliasD13)->(!Eof() .And. B2_COD+B2_LOCAL+D13_ENDER+D13_LOTECT+D13_NUMLOT+D13_NUMSER+D13_PRDORI == cKeyAnt)

			oReport:IncMeter()

			If (cAliasD13)->D13_TM <= "500"
				oSection:Cell("D13_QTDENT"):Show()
				If MV_PAR15 == 1
					nEntrada += (cAliasD13)->D13_QTDEST
					oSection:Cell("D13_QTDENT"):SetValue((cAliasD13)->D13_QTDEST)
				Else
					// Converte as Entradas para a 2a Unidade de Medida
					nEntrada += ConvUM((cAliasD13)->B2_COD, (cAliasD13)->D13_QTDEST, 0, 2)
					oSection:Cell("D13_QTDENT"):SetValue(ConvUM((cAliasD13)->B2_COD, (cAliasD13)->D13_QTDEST, 0, 2))
				EndIf
				oSection:Cell("D13_QTDSAI"):Hide()
				oSection:Cell("D13_QTDSAI"):SetValue(0)
			Else
				oSection:Cell("D13_QTDSAI"):Show()
				If MV_PAR15 == 1
					nSaida += (cAliasD13)->D13_QTDEST
					oSection:Cell("D13_QTDSAI"):SetValue((cAliasD13)->D13_QTDEST)
				Else
					// Converte as Saidas para a 2a Unidade de Medida
					nSaida += ConvUM((cAliasD13)->B2_COD, (cAliasD13)->D13_QTDEST, 0, 2)
					oSection:Cell("D13_QTDSAI"):SetValue(ConvUM((cAliasD13)->B2_COD, (cAliasD13)->D13_QTDEST, 0, 2))
				EndIf
				oSection:Cell("D13_QTDENT"):Hide()
				oSection:Cell("D13_QTDENT"):SetValue(0)
			EndIf
			oSection:Cell("D13_QTDSLD"):SetValue((nSaldoIni+nEntrada) - nSaida)
			oSection:PrintLine()

			(cAliasD13)->(dbSkip())
		EndDo

	EndDo

	oSection:Finish()
Return Nil

Static Function CalcEstEnd(cProduto,cArmazem,dDataOri,cEndereco,cLoteCtl,cNumLote,cNumSerie,cPrdOri)
Static aTamQtd  := TamSX3('D13_QTDEST')
Local aAreaAnt  := GetArea()
Local cQuery    := ""  
Local cAliasQry := ""
Local nSaldoIni := 0
Local dDataFech := CtoD("01/01/1900","dd/mm/yyyy")

	// Pega o saldo inicial do último fechamento de estoque antes da data inicial origem do kardex 
	cQuery := "SELECT D15.D15_DATA,"
	cQuery +=       " D15.D15_QINI"
	cQuery +=  " FROM (SELECT MAX(D152.R_E_C_N_O_) D15RECNO"
	cQuery +=          " FROM "+RetSqlName("D15")+" D152"
	cQuery +=         " WHERE D152.D15_FILIAL = '"+xFilial("D15")+"'"
	cQuery +=           " AND D152.D15_LOCAL  = '"+cArmazem+"'"
	cQuery +=           " AND D152.D15_ENDER  = '"+cEndereco+"'"
	cQuery +=           " AND D152.D15_PRDORI = '"+cPrdOri+"'"
	cQuery +=           " AND D152.D15_PRODUT = '"+cProduto+"'"
	cQuery +=           " AND D152.D15_LOTECT = '"+cLoteCtl+"'"
	cQuery +=           " AND D152.D15_NUMLOT = '"+cNumLote+"'"
	cQuery +=           " AND D152.D15_NUMSER = '"+cNumSerie+"'"
	cQuery +=           " AND D152.D15_DATA   < '"+DtoS(dDataOri)+"'"
	cQuery +=           " AND D152.D_E_L_E_T_ = ' ') D152"
	cQuery +=  " INNER JOIN "+RetSqlName("D15")+" D15"
	cQuery +=     " ON D15.R_E_C_N_O_ = D152.D15RECNO"
	cAliasQry := GetNextAlias()
	DbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAliasQry,.F.,.T.)
	TCSetField(cAliasQry,'D15_DATA','D',10,0)
	TCSetField(cAliasQry,'D15_QINI','N',aTamQtd[1],aTamQtd[2])
	If (cAliasQry)->(!Eof())
		dDataFech := (cAliasQry)->D15_DATA
		nSaldoIni := (cAliasQry)->D15_QINI
	EndIf 
	(cAliasQry)->(DbCloseArea())
	
	If dDataFech < (dDataOri-1)
		// Pega a soma das entradas do ultimo fechamento até a data inicial do kardex
		cQuery := "SELECT Sum(D13.D13_QTDEST) D13_QTDENT"
		cQuery +=  " FROM "+RetSqlName("D13")+" D13"
		cQuery += " WHERE D13.D13_FILIAL = '"+xFilial("D13")+"'"
		cQuery +=   " AND D13.D13_LOCAL  = '"+cArmazem+"'"
		cQuery +=   " AND D13.D13_PRDORI = '"+cPrdOri+"'"
		cQuery +=   " AND D13.D13_PRODUT = '"+cProduto+"'"
		cQuery +=   " AND D13.D13_ENDER  = '"+cEndereco+"'"
		cQuery +=   " AND D13.D13_LOTECT = '"+cLoteCtl+"'"
		cQuery +=   " AND D13.D13_NUMLOT = '"+cNumLote+"'"
		cQuery +=   " AND D13.D13_NUMSER = '"+cNumSerie+"'"
		cQuery +=   " AND D13.D13_TM    <= '500'"
		cQuery +=   " AND D13.D13_DTESTO > '"+DtoS(dDataFech)+"'"
		cQuery +=   " AND D13.D13_DTESTO < '"+DtoS(dDataOri)+"'"
		cQuery +=   " AND D13.D_E_L_E_T_ = ' '"
		cAliasQry := GetNextAlias()
		DbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAliasQry,.F.,.T.)
		TCSetField(cAliasQry,'D13_QTDENT','N',aTamQtd[1],aTamQtd[2])
		If (cAliasQry)->(!Eof())
			nSaldoIni += (cAliasQry)->D13_QTDENT
		EndIf 
		(cAliasQry)->(DbCloseArea())

		// Pega a soma das saídas do ultimo fechamento até a data inicial do kardex
		cQuery := "SELECT Sum(D13.D13_QTDEST) D13_QTDSAI"
		cQuery +=  " FROM "+RetSqlName("D13")+" D13"
		cQuery += " WHERE D13.D13_FILIAL = '"+xFilial("D13")+"'"
		cQuery +=   " AND D13.D13_LOCAL  = '"+cArmazem+"'"
		cQuery +=   " AND D13.D13_PRDORI = '"+cPrdOri+"'"
		cQuery +=   " AND D13.D13_PRODUT = '"+cProduto+"'"
		cQuery +=   " AND D13.D13_ENDER  = '"+cEndereco+"'"
		cQuery +=   " AND D13.D13_LOTECT = '"+cLoteCtl+"'"
		cQuery +=   " AND D13.D13_NUMLOT = '"+cNumLote+"'"
		cQuery +=   " AND D13.D13_NUMSER = '"+cNumSerie+"'"
		cQuery +=   " AND D13.D13_TM     > '500'"
		cQuery +=   " AND D13.D13_DTESTO > '"+DtoS(dDataFech)+"'"
		cQuery +=   " AND D13.D13_DTESTO < '"+DtoS(dDataOri)+"'"
		cQuery +=   " AND D13.D_E_L_E_T_ = ' '"
		cAliasQry := GetNextAlias()
		DbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAliasQry,.F.,.T.)
		TCSetField(cAliasQry,'D13_QTDSAI','N',aTamQtd[1],aTamQtd[2])
		If (cAliasQry)->(!Eof())
			nSaldoIni -= (cAliasQry)->D13_QTDSAI
		EndIf 
		(cAliasQry)->(DbCloseArea())
	EndIf

	RestArea(aAreaAnt)
Return nSaldoIni
