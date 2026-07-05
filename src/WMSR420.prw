/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "RWMAKE.CH"
#INCLUDE "WMSR420.CH"


//-----------------------------------------------------------
/*/{Protheus.doc} WMSR420
Relatório Sintético e Analítico das Embalagens

@author  Alex Egydio
@since   29/06/06
/*/
//-----------------------------------------------------------
User Function WMSR420()
Local oReport
	If !Pergunte('WMR420',.T.)
		Return
	EndIf
	//Interface de impressão
	oReport := ReportDef()
	oReport:PrintDialog()
Return
//------------------------------------------------------------
//  Definições do relatório
//------------------------------------------------------------
Static Function ReportDef()
Local oReport, oSection1, oSection2, oSection3
	oReport := TReport():New('WMSR420', STR0001,'',{|oReport| ReportPrint(oReport)},STR0002 + ' ' + STR0003) // CHECK-OUT DO PROCESSO DE EMBALAGEM // Este programa tem como objetivo imprimir relatorio //de acordo com os parametros informados pelo usuario.
	// oSection 1 (Documentos na Montagem de Volume e as outras duas seções)
	oSection1 := TRSection():New(oReport,STR0032,,,,,,,/*.T.*/,/*.T.*/,,,,,3,,,2) //Carga/Pedido
	TRCell():New(oSection1,'DCS_CARGA' ,'DCS',/*Titulo*/,/*Picture*/     ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*Alinhamento*/)
	TRCell():New(oSection1,'DCS_PEDIDO','DCS',/*Titulo*/,/*Picture*/     ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*Alinhamento*/)
	TRCell():New(oSection1,'DCS_STATUS','DCS',/*Titulo*/,/*Picture*/     ,15         ,/*lPixel*/,/*{|| code-block de impressao }*/,/*Alinhamento*/)
	TRCell():New(oSection1,'DCS_QTDITE',     ,STR0008,                ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,'LEFT') //Qtd. Itens
	TRCell():New(oSection1,'DCS_QTDVOL',     ,STR0009,                ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,'LEFT',,,,,.T.) //Qtd. Volumes
	// oSection 2 (Volumes e a seção de itens do volume)
	oSection2 := TRSection():New(oSection1,STR0038,,,,,STR0004,,,,,,,.T.,10) //Volumes # Total
	TRCell():New(oSection2,'DCU_CODVOL','DCU',STR0033  ,/*Picture*/     ,  ,/*lPixel*/,/*{|| code-block de impressao }*/) //Volume
	TRCell():New(oSection2,'DCU_QTDITE',     ,STR0008,'@e 999,999,999',10,/*lPixel*/,/*{|| code-block de impressao }*/,'LEFT') //Qtd. Itens
	TRCell():New(oSection2,'DCU_NOMOPE','DCU',STR0034,/*Picture*/     ,  ,/*lPixel*/,{|| Posicione('DCD',1,xFilial('DCD')+DCU->DCU_OPERAD,'DCD_NOMFUN')}) //Operador
	// oSection 3 (Itens do Volume)
	oSection3 := TRSection():New(oSection2, STR0035,,,,,,,,,,,,,3,,,0) //Itens do Volume
	TRCell():New(oSection3,'DCV_CODPRO','DCV',STR0036   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //Produto
	TRCell():New(oSection3,'DCV_DESCR' ,'DCV',/*Titulo*/  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| Posicione('SB1',1,xFilial('SB1')+DCV->DCV_CODPRO,'B1_DESC')})
	TRCell():New(oSection3,'DCV_QUANT' ,'DCV',STR0037,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //Quantidade
	TRCell():New(oSection3,'DCV_LOTE'  ,'DCV',/*Titulo*/  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,'DCV_SUBLOT','DCV',/*Titulo*/  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,'DCV_PRDORI','DCV',/*Titulo*/  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	// Totalizador: total de volumes e total geral de volumes
	TRFunction():New(oSection2:Cell('DCU_CODVOL'),'DCU_QTDVOL','COUNT',,STR0038,'@E 999,999,999',/*uFormula*/,.T.,.T.,.F.,/*oParent*/,/*bCondition*/,/*lDisable*/,{|| Iif(mv_par06 == 1,.T.,.F.)}) //Totalizador Volumes
Return(oReport)
//-----------------------------------------------------------
// Impressão do relatório
//-----------------------------------------------------------
Static Function ReportPrint(oReport)
Local aAreaDCS  := DCS->(GetArea())
Local aAreaDCT  := DCT->(GetArea())
Local aAreaDCU  := DCU->(GetArea())
Local aAreaDCV  := DCV->(GetArea())
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(1):Section(1)
Local cAliasDCS := Nil
Local cAliasQry := Nil
Local cAliasQr1 := Nil
Local cWhere    := ''
Local nQtdItens := 0
Local nQtdVols  := 0
Local nItens    := 0
Local nSumItens := 0
Local nColPos   := 0
	// Inicio do filtro do relatório - Transforma parâmetros Range em expressão SQL
	MakeSqlExpr(oReport:GetParam())

	// Query do relatório
	oSection1:BeginQuery()
		If mv_par05 <> 4
			cWhere := " AND DCS.DCS_STATUS IN ('"+Str(mv_par05,1)+"')"
		EndIf
		cWhere := '%'+cWhere+"%"
		cAliasDCS := GetNextAlias()
		BeginSql Alias cAliasDCS
			SELECT DCS.DCS_CODMNT,
					DCS.DCS_CARGA,
					DCS.DCS_PEDIDO,
					DCS.DCS_STATUS
			FROM %table:DCS% DCS
			WHERE DCS.DCS_FILIAL = %xFilial:DCS%
			AND DCS.DCS_CARGA >= %Exp:mv_par01% 
			AND DCS.DCS_CARGA <= %Exp:mv_par02%
			AND DCS.DCS_PEDIDO >= %Exp:mv_par03%
			AND DCS.DCS_PEDIDO <= %Exp:mv_par04%
			AND DCS.%NotDel%
			%Exp:cWhere%
			ORDER BY DCS.DCS_CODMNT,
						DCS.DCS_CARGA,
						DCS.DCS_PEDIDO
		EndSql
	oSection1:EndQuery()
	// Régua de progressão
	oReport:SetMeter((cAliasDCS)->(LastRec()))
	If (cAliasDCS)->(!Eof())
		Do While !oReport:Cancel() .And. (cAliasDCS)->(!Eof())
			// Início da Seção 1
			oSection1:Init()
			// Soma dos Itens dos Documentos na Montagem de Volumes que será atribuida à celula Qtde. Itens
			nQtdItens := 0
			cAliasQry := GetNextAlias()
			BeginSql Alias cAliasQry
				SELECT COUNT(*) NRITENS
				FROM %Table:DCT% DCT
				WHERE DCT.DCT_FILIAL = %xFilial:DCT% 
				AND DCT.DCT_CODMNT = %Exp:(cAliasDCS)->DCS_CODMNT%
				AND DCT.DCT_CARGA = %Exp:(cAliasDCS)->DCS_CARGA%
				AND DCT.DCT_PEDIDO = %Exp:(cAliasDCS)->DCS_PEDIDO%
				AND DCT.%NotDel%
			EndSql
			If (cAliasQry)->(!Eof())
				nQtdItens := (cAliasQry)->NRITENS
			EndIf
			(cAliasQry)->(dbCloseArea())
			// Soma dos Volumes que será atribuida à celula Qtde. Volumes
			nQtdVols := 0
			cAliasQry := GetNextAlias()
			BeginSql Alias cAliasQry
				SELECT COUNT(*) NRVOLS
				FROM %Table:DCU% DCU
				WHERE DCU.DCU_FILIAL = %xFilial:DCU%
				AND DCU.DCU_CARGA = %Exp:(cAliasDCS)->DCS_CARGA%
				AND DCU.DCU_PEDIDO = %Exp:(cAliasDCS)->DCS_PEDIDO%
				AND DCU.DCU_CODMNT = %Exp:(cAliasDCS)->DCS_CODMNT%
				AND DCU.%NotDel%
			EndSql
			If (cAliasQry)->(!Eof())
				nQtdVols := (cAliasQry)->NRVOLS
			EndIf
			(cAliasQry)->(dbCloseArea())
			// Atribuindo manualmente os valores para as células
			oSection1:Cell('DCS_QTDITE'):SetValue(PadL(nQtdItens,5,'0'))
			oSection1:Cell('DCS_QTDVOL'):SetValue(PadL(nQtdVols,5,'0'))
			oSection1:PrintLine()
			// Se é relatório Analítico
			If mv_par06 == 1
				oSection2:Init()
				cAliasQry := GetNextAlias()
				BeginSql Alias cAliasQry
					SELECT DCU.R_E_C_N_O_ RECNODCU
					FROM %Table:DCU% DCU
					WHERE DCU.DCU_FILIAL = %xFilial:DCU%
					AND DCU.DCU_CARGA = %Exp:(cAliasDCS)->DCS_CARGA%
					AND DCU.DCU_PEDIDO = %Exp:(cAliasDCS)->DCS_PEDIDO%
					AND DCU.DCU_CODMNT = %Exp:(cAliasDCS)->DCS_CODMNT%
					AND DCU.%NotDel% 
				EndSql
				If (cAliasQry)->(!Eof())
					Do While (cAliasQry)->(!Eof())
						DCU->(dbGoTo((cAliasQry)->RECNODCU))
						// Soma dos Itens do Volume que atribuida à celula Qtde de Itens
						nItens := 0
						cAliasQr1 := GetNextAlias()
						BeginSql Alias cAliasQr1
							SELECT COUNT(*) NRITENS
							FROM %Table:DCV% DCV
							WHERE DCV.DCV_FILIAL = %xFilial:DCV%
							AND DCV.DCV_CODMNT = %Exp:DCU->DCU_CODMNT%
							AND DCV.DCV_CODVOL = %Exp:DCU->DCU_CODVOL%
							AND DCV.%NotDel%
						EndSql
						If (cAliasQr1)->(!Eof())
							nItens := (cAliasQr1)->NRITENS
						EndIf
						(cAliasQr1)->(dbCloseArea())
						oSection2:Cell('DCU_QTDITE'):SetValue(nItens)
						oSection2:PrintLine()
						// Início da seção 3
						oSection3:Init()
						nSumItens := 0
						cAliasQr1 := GetNextAlias()
						BeginSql Alias cAliasQr1
							SELECT DCV.R_E_C_N_O_ RECNODCV
							FROM %Table:DCV% DCV
							WHERE DCV.DCV_FILIAL = %xFilial:DCV%
							AND DCV.DCV_CODMNT = %Exp:DCU->DCU_CODMNT%
							AND DCV.DCV_CODVOL = %Exp:DCU->DCU_CODVOL%
							AND DCV.%NotDel%
						EndSql
						Do While (cAliasQr1)->(!Eof())
							DCV->(dbGoTo((cAliasQr1)->RECNODCV))
							nSumItens += DCV->DCV_QUANT // Quantidade total de itens de cada volume
							oSection3:PrintLine()
							(cAliasQr1)->(dbSkip())
						EndDo
						(cAliasQr1)->(dbCloseArea())
						// Impressão do total das quantidades dos itens
						nColPos := oSection3:Cell('DCV_QUANT'):ColPos()
						oReport:PrintText(Replicate('-',11),,nColPos+55)
						oReport:PrintText(Transform(nSumItens,'@E 999,999,999.99'),,nColPos)
						// Final da seção 3
						oSection3:Finish()
						// Pular uma linha
						oReport:SkipLine()
						(cAliasQry)->(dbSkip())
					EndDo
				Else
					oReport:SkipLine()
				EndIf
				(cAliasQry)->(dbCloseArea())
				oSection2:Finish()
			EndIf
			// Incrementa a régua de progressão
			oReport:IncMeter()
			oSection1:Finish()
			(cAliasDCS)->(dbSkip())
		EndDo
	Else
		oReport:PrintText(STR0014) // NAO EXISTEM DADOS PARA ESTA SELECAO
	EndIf
	oSection1:CloseQuery()
	RestArea(aAreaDCS)
	RestArea(aAreaDCT)
	RestArea(aAreaDCU)
	RestArea(aAreaDCV)
Return