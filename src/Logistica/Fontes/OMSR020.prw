/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH" 
#INCLUDE "OMSR020.CH"

Static lFilPad := OsVlEntCom() == 1  //Indica se busca filial através do método padrão

/*/{Protheus.doc} OMSR020
Relatório de Cargas
@author amanda.vieira
@since 13/09/2018
@version 1.0
@type function
/*/
User Function OMSR020()
Local oReport := Nil

	If FindFunction("OMSMsgRelD")
		OMSMsgRelD()
	EndIf

	oReport := ReportDef()
	oReport:PrintDialog()

Return

/*/{Protheus.doc} ReportDef
Definição do Relatório
@author amanda.vieira
@since 13/09/2018
@version 1.0
@type function
/*/
Static Function ReportDef()
Local oReport    := Nil
Local oCarga     := Nil
Local oItCarga   := Nil
Local oItCarNF   := Nil
Local oPrdCarga  := Nil
Local oItPedido  := Nil
Local oItNotFis  := Nil
Local cAliasSC9  := GetNextAlias()
Local cAliasSD2  := GetNextAlias()
Local lDaiRedesp  := DAI->( ColumnPos( "DAI_REDESP" ) ) > 0
Local aSizeSec1 := {TamSx3("DAK_COD")[1],4,TamSx3("DAK_CAMINH")[1],0,8,0,7,7,7,15,10,8} //largura das colunas do relatório
Local nX := 0
Local nSizeRem := 0

	For nX := 1 to Len(aSizeSec1)
		nSizeRem += aSizeSec1[nX]
	Next nX

	//Para evitar de imprimir informações incompletas, o tamanho do nome do motorista e a descrição do veículo serão variáveis
	nSizeRem := 132 - nSizeRem
	aSizeSec1[4] := Int(nSizeRem*0.4)
	aSizeSec1[6] := Int(nSizeRem*0.6)

	oReport := TReport():New("OMSR020",STR0001,"OMR020", {|oReport| ReportPrint(oReport,cAliasSC9,cAliasSD2)},STR0002+" "+STR0003) // Listagem de Cargas // Este relatorio ira imprimir a listagem de cargas de acordo com os parametros informados pelo usuario
	oReport:SetLandscape()
	oReport:SetTotalInLine(.F.)
	oReport:SetColSpace(3,.F.) /*nColSpace*/ /*lPixel*/
	Pergunte(oReport:uParam,.F.)

	//Seção 1 - Cargas - Deve respeitar o limite de 132 colunas para o modo retrato não cortar informação.
	oCarga:= TRSection():New(oReport,STR0026,{"DAK","DA3","DA4"},{STR0027,STR0028},/*Campos do SX3*/,/*Campos do SIX*/) // Carga // Pedido/Item // Produto
	oCarga:SetTotalInLine(.F.)
	TRCell():New(oCarga , "DAK_COD"    , "DAK" , STR0026    , PesqPict("DAK","DAK_COD")   	, /*Tamanho*/   , /*lPixel*/ , /*{|| code-block de impressao }*/) // Carga
	TRCell():New(oCarga , "DAK_SEQCAR" , "DAK" , STR0037    , PesqPict("DAK","DAK_SEQCAR")	, /*Tamanho*/  	, /*lPixel*/ , /*{|| code-block de impressao }*/) // Seq.
	TRCell():New(oCarga , "DAK_CAMINH" , "DAK" , /*Titulo*/ , PesqPict("DAK","DAK_CAMINH")	, /*Tamanho*/   , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oCarga , "DA3_DESC"   , "DA3" , /*Titulo*/ , /*Picture*/					, aSizeSec1[4]	, /*lPixel*/ , /*{|| code-block de impressao }*/,,.T./*lLineBreak*/,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,.T.)
	TRCell():New(oCarga , "DAK_MOTORI" , "DAK" , /*Titulo*/ , /*Picture*/					, /*Tamanho*/ 	, /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oCarga , "DA4_NOME"   , "DA4" , ""         , /*Picture*/					, aSizeSec1[6]	, /*lPixel*/ , /*{|| code-block de impressao }*/,,.T./*lLineBreak*/,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,.T.)
	TRCell():New(oCarga , "DAK_PESO"   , "DAK" , /*Titulo*/ , '@E 999,999'          		, /*Tamanho*/ 	, /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oCarga , "DAK_CAPVOL" , "DAK" , /*Titulo*/ , '@E 999,999'          		, /*Tamanho*/ 	, /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oCarga , "DAK_PTOENT" , "DAK" , STR0042    , '@E 999,999' 	             	, /*Tamanho*/ 	, /*lPixel*/ , /*{|| code-block de impressao }*/) //Pt.Ent.
	TRCell():New(oCarga , "DAK_VALOR"  , "DAK" , /*Titulo*/ , '@E 999,999,999.99'           , /*Tamanho*/ 	, /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oCarga , "DAK_DATA"   , "DAK" , /*Titulo*/ , /*Picture*/					, /*Tamanho*/ 	, /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oCarga , "DAK_HORA"   , "DAK" , /*Titulo*/ , /*Picture*/		 			, /*Tamanho*/ 	, /*lPixel*/ , /*{|| code-block de impressao }*/)

	//Seção 2 - Itens da Carga // Ordem por pedido
	oItCarga:= TRSection():New(oCarga,STR0004,{"DAI","SA1"},/*{Array com as ordens do relatorio}*/,/*Campos do SX3*/,/*Campos do SIX*/) // Pedidos de Venda da Carga
	oItCarga:SetTotalInLine(.F.)
	TRCell():New(oItCarga , "DAI_SEQUEN" ,"DAI" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarga , "DAI_PEDIDO" ,"DAI" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarga , "DAI_NFISCA" ,"DAI" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarga , "DAI_CLIENT" ,"DAI" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarga , "DAI_LOJA"   ,"DAI" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarga , "NREDUZ"     ,      , STR0008    , PesqPict("SA1","A1_NREDUZ")  , TamSx3("A1_NREDUZ")[1]  , /*lPixel*/ ,   {|| NomeReduz()             }  )
	TRCell():New(oItCarga , "DAI_PESO"   ,"DAI" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarga , "DAI_CAPVOL" ,"DAI" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	If lDaiRedesp
		TRCell():New(oItCarga , "DAI_REDESP" ,"DAI" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
		TRCell():New(oItCarga , "A4_NREDUZ"  ,"SA4" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	EndIf

	//Seção 2 - Itens da Carga // Ordem por nota fiscal
	oItCarNF:= TRSection():New(oCarga,STR0005,{"SF2","SD2","SA1"},/*{Array com as ordens do relatorio}*/,/*Campos do SX3*/,/*Campos do SIX*/) // Notas Fiscais da Carga
	oItCarNF:SetTotalInLine(.F.)
	TRCell():New(oItCarNF , "F2_SEQENT"  ,"SF2" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarNF , "F2_DOC"     ,"SF2" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarNF , "F2_SERIE"   ,"SF2" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarNF , "F2_CLIENTE" ,"SF2" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarNF , "F2_LOJA"    ,"SF2" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarNF , "NREDUZ"     ,      , STR0008    , PesqPict("SA1","A1_NREDUZ")  , TamSx3("A1_NREDUZ")[1]  , /*lPixel*/ ,   {|| NomeReduz()             }  )
	TRCell():New(oItCarNF , "F2_PLIQUI"  ,"SF2" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)
	TRCell():New(oItCarNF , "D2_PEDIDO"  ,"SD2" , /*Titulo*/ , /*Picture*/                  , /*Tamanho*/             , /*lPixel*/ , /*{|| code-block de impressao }*/)

	//Seção 2 - Produtos da Carga // Ordem por produto
	oPrdCarga:= TRSection():New(oCarga,STR0039,{"SC9","SB1","SF2"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) // Produtos da Carga
	oPrdCarga:SetTotalInLine(.F.)
	TRCell():New(oPrdCarga , "C9_ITEM"    , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "C9_PRODUTO" , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "B1_DESC"    , "SB1" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "C9_LOTECTL" , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "C9_NUMLOTE" , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "C9_QTDLIB"  , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "B1_UM"      , "SB1" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "C9_QTDLIB2" , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "B1_SEGUM"   , "SB1" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "C9_VALOR"   , "SC9" , STR0038    ,PesqPict("SC6","C6_VALOR")  , TamSx3("C6_VALOR")[1]   , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "C9_PESO"    , "SC9" , STR0031    ,PesqPict("DAI","DAI_PESO")  , TamSx3("DAI_PESO")[1]   , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "C9_VOLUME"  , "SC9" , STR0032    ,PesqPict("DAI","DAI_CAPVOL"), TamSx3("DAI_CAPVOL")[1] , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "F2_DOC"     , "SF2" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oPrdCarga , "F2_SERIE"   , "SF2" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)

	//Seção 3 - Pedidos dos Itens da Carga
	oItPedido:= TRSection():New(oItCarga,STR0006,{"SC9","SB1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) // Itens do Pedido de Venda
	oItPedido:SetTotalInLine(.F.)
	TRCell():New(oItPedido , "C9_ITEM"    , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "C9_PRODUTO" , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "B1_DESC"    , "SB1" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "C9_LOTECTL" , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "C9_NUMLOTE" , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "C9_QTDLIB"  , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "B1_UM"      , "SB1" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "C9_QTDLIB2" , "SC9" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "B1_SEGUM"   , "SB1" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "C9_VALOR"   , "SC9" , STR0038    ,PesqPict("SC6","C6_VALOR")  , TamSx3("C6_VALOR")[1]   , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "C9_PESO"    , "SC9" , STR0031    ,PesqPict("DAI","DAI_PESO")  , TamSx3("DAI_PESO")[1]   , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItPedido , "C9_VOLUME"  , "SC9" , STR0032    ,PesqPict("DAI","DAI_CAPVOL"), TamSx3("DAI_CAPVOL")[1] , /*lPixel*/  , /*{|| code-block de impressao }*/)

	//Seção 3 - Notas Fiscais dos Itens da Carga
	oItNotFis:= TRSection():New(oItCarNF,STR0007,{"SD2","SB1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) // Itens da Nota Fiscal
	oItNotFis:SetTotalInLine(.F.)
	TRCell():New(oItNotFis , "D2_ITEM"    , "SD2" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "D2_COD"     , "SD2" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "B1_DESC"    , "SB1" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "D2_LOTECTL" , "SD2" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "D2_NUMLOTE" , "SD2" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "D2_QUANT"   , "SD2" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "B1_UM"      , "SB1" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "D2_QTSEGUM" , "SD2" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "B1_SEGUM"   , "SB1" , /*Titulo*/ , /*Picture*/                , /*Tamanho*/             , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "D2_TOTAL"   , "SD2" , STR0038    ,PesqPict("SC6","C6_VALOR")  , TamSx3("C6_VALOR")[1]   , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "D2_PESO"    , "SD2" , STR0031    ,PesqPict("DAI","DAI_PESO")  , TamSx3("DAI_PESO")[1]   , /*lPixel*/  , /*{|| code-block de impressao }*/)
	TRCell():New(oItNotFis , "D2_VOLUME"  , "SD2" , STR0032    ,PesqPict("DAI","DAI_CAPVOL"), TamSx3("DAI_CAPVOL")[1] , /*lPixel*/  , /*{|| code-block de impressao }*/)

Return oReport

/*/{Protheus.doc} ReportPrint
Impressão do Relatório
@author amanda.vieira
@since 13/09/2018
@version 1.0
@param oReport, objeto, objeto report
@param cAliasSC9, caracter, alias da query de pedido de venda
@type function
/*/
Static Function ReportPrint(oReport,cAliasSC9,cAliasSD2)
Local oCarga   := oReport:Section(1)
Local lOrdPrd  := oCarga:nOrder == 2 //Indica se o relatório possui ordem por produto
Local lNotaFis := MV_PAR13 == 2      //Indica se o relatório deve apresentar apenas cargas faturadas
	If lOrdPrd
		ReportPrd(oReport,cAliasSC9)
	Else
		If lNotaFis
			ReportNF(oReport,cAliasSD2)
		Else
			ReportPed(oReport,cAliasSC9)
		EndIf
	EndIf
Return

/*/{Protheus.doc} ReportPed
Impressão do Relatório da Ordem por Pedido
@author amanda.vieira
@since 13/09/2018
@version 1.0
@param oReport, objeto, objeto report
@type function
/*/
Static Function ReportPed(oReport,cAliasSC9)
Local oCarga     := oReport:Section(1)
Local oItCarga   := oCarga:Section(1)
Local oItCarNF   := oCarga:Section(2)
Local oPrdCarga  := oCarga:Section(3)
Local oItPedido  := oItCarga:Section(1)
Local oBreakPed  := Nil
Local cRegAnt    := ""
Local lLote      := MV_PAR14 == 1      //Indica se imprime lote
Local lAnalitico := MV_PAR11 == 2      //Indica se o relatório é do tipo analítico
Local lNotaFis   := MV_PAR13 == 2      //Indica se o relatório deve apresentar apenas cargas faturadas
Local lDaiRedesp  := DAI->( ColumnPos( "DAI_REDESP" ) ) > 0

	//Habilita ou desabilita campos, seções e quebras conforme o tipo de relatório
	If lAnalitico
		oBreakPed := TRBreak():New(oCarga,{||oCarga:Cell("DAK_COD")},STR0036,.F.) // Total da Carga
		TRFunction():New(oItPedido:Cell("C9_QTDLIB") ,/* cID */,"SUM",oBreakPed,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
		TRFunction():New(oItPedido:Cell("C9_QTDLIB2"),/* cID */,"SUM",oBreakPed,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
		TRFunction():New(oItPedido:Cell("C9_VALOR")  ,/* cID */,"SUM",oBreakPed,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
		TRFunction():New(oItPedido:Cell("C9_PESO")   ,/* cID */,"SUM",oBreakPed,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
		TRFunction():New(oItPedido:Cell("C9_VOLUME") ,/* cID */,"SUM",oBreakPed,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
	Else
		//Desabilita seção dos pedidos de venda
		oItPedido:Disable()
		FreeObj(oItPedido)
		oItCarga:aSection := {}
	EndIf
	//Desabilita seção dos produtos da carga e NFs
	oItCarNF:Disable()
	oPrdCarga:Disable()
	//Desabilita células de lote
	If lAnalitico .And. !lLote
		oItPedido:Cell("C9_LOTECTL"):Disable()
		oItPedido:Cell("C9_NUMLOTE"):Disable()
	EndIf
	//Aplica filtro à seção principal
	oCarga:SetFilter(FiltraDAK(lNotaFis))
	//Relaciona a carga com os itens da carga
	oItCarga:SetRelation({||xFilial('DAI')+DAK->(DAK_COD+DAK_SEQCAR)},"DAI",1,.T.)
	oItCarga:SetParentFilter({|cParam|DAI->(DAI_FILIAL+DAI_COD+DAI_SEQCAR) == cParam},{||xFilial('DAI')+DAK->(DAK_COD+DAK_SEQCAR)})
	If lAnalitico
		//Realiza relacionamento entre DAI e DAK
		oItCarga:OnPrintLine({||cRegAnt := "",QuerySC9(oItPedido,cAliasSC9,.T.,lNotaFis,lAnalitico)})
		//Valida se a linha do pedido será impressa e agrupa linhas que não serão exibidas
		oItPedido:SetLineCondition({||ValLinSC9(cAliasSC9,oItPedido,lLote,.T.,lNotaFis,lAnalitico,@cRegAnt)} )
	EndIf
	//Posiciona nas tabelas secundárias da seção 1 (Cargas)
	TRPosition():New(oCarga,"SC5",1,{|| Iif(lFilPad,xFilial('SC5'),OsFilial("SC5",DAI->DAI_FILPV))+DAI->DAI_PEDIDO})
	TRPosition():New(oCarga,"DA3",1,{|| xFilial("DA3")+DAK->DAK_CAMINH })
	TRPosition():New(oCarga,"DA4",1,{|| xFilial("DA4")+DAK->DAK_MOTORI })
	//Posiciona nas tabelas secundárias da seção 2 (Itens da Carga)
	TRPosition():New(oItCarga,"SF2",1,{||Iif(lFilPad,xFilial('SF2'),OsFilial("SF2",DAI->DAI_FILPV))+DAI->(DAI_NFISCA+DAI_SERIE)+SC5->(C5_CLIENTE+C5_LOJACLI)}) //NF
	TRPosition():New(oItCarga,"SA1",1,{||Iif(lFilPad,xFilial('SA1'),OsFilial("SA1",DAI->DAI_FILPV))+DAI->(DAI_CLIENT+DAI_LOJA)}) //Cliente
	TRPosition():New(oItCarga,"SA2",1,{||Iif(lFilPad,xFilial('SA2'),OsFilial("SA2",DAI->DAI_FILPV))+DAI->(DAI_CLIENT+DAI_LOJA)}) //Fornecedor - Necessário para tipos de documento B e D
	If lDaiRedesp
		TRPosition():New(oItCarga,"SA4",1,{||Iif(lFilPad,xFilial('SA4'),OsFilial("SA4",DAI->DAI_FILPV))+DAI->(DAI_REDESP)}) //Redespachante
	EndIf
	If lAnalitico
		//Posiciona nas tabelas secundárias da seção 3 (Pedidos dos Itens da Carga)
		TRPosition():New(oItPedido,"SC9",1,{||(cAliasSC9)->(C9_FILIAL+C9_PEDIDO+C9_ITEM)}) //Pedido
		TRPosition():New(oItPedido,"SB1",1,{||Iif(lFilPad,xFilial('SB1'),OsFilial("SB1",DAI->DAI_FILPV))+(cAliasSC9)->C9_PRODUTO}) //Produto
	EndIf
	If MV_PAR12 == 1
		oCarga:SetPageBreak(.T.)
	EndIf
	oCarga:Print()
Return oReport

/*/{Protheus.doc} ReportNF
Impressão do Relatório da Carga por Nota Fiscal
@author  guilherme.metzger
@since   27/11/2018
@version 1.0
@param oReport, objeto, objeto report
@type function
/*/
Static Function ReportNF(oReport,cAliasSD2)
Local oCarga     := oReport:Section(1)
Local oItCarga   := oCarga:Section(1)
Local oItCarNF   := oCarga:Section(2)
Local oPrdCarga  := oCarga:Section(3)
Local oItNotFis  := oItCarNF:Section(1)
Local oBreakNF   := Nil
Local cRegAnt    := ""
Local lLote      := MV_PAR14 == 1      //Indica se imprime lote
Local lAnalitico := MV_PAR11 == 2      //Indica se o relatório é do tipo analítico
Local lNotaFis   := MV_PAR13 == 2      //Indica se o relatório deve apresentar apenas cargas faturadas
	//Habilita ou desabilita campos, seções e quebras conforme o tipo de relatório
	If lAnalitico
		oBreakNF := TRBreak():New(oCarga,{||oCarga:Cell("DAK_COD")},STR0036,.F.) // Total da Carga
		TRFunction():New(oItNotFis:Cell("D2_QUANT")  ,/* cID */,"SUM",oBreakNF,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
		TRFunction():New(oItNotFis:Cell("D2_QTSEGUM"),/* cID */,"SUM",oBreakNF,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
		TRFunction():New(oItNotFis:Cell("D2_TOTAL")  ,/* cID */,"SUM",oBreakNF,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
		TRFunction():New(oItNotFis:Cell("D2_PESO")   ,/* cID */,"SUM",oBreakNF,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
		TRFunction():New(oItNotFis:Cell("D2_VOLUME") ,/* cID */,"SUM",oBreakNF,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
	Else
		//Desabilita seção dos pedidos de venda
		oItNotFis:Disable()
		FreeObj(oItNotFis)
		oItCarNF:aSection := {}
	EndIf
	//Desabilita seção dos itens da carga e produtos da carga
	oItCarga:Disable()
	oPrdCarga:Disable()
	//Desabilita células de lote
	If lAnalitico .And. !lLote
		oItNotFis:Cell("D2_LOTECTL"):Disable()
		oItNotFis:Cell("D2_NUMLOTE"):Disable()
	EndIf
	//Aplica filtro à seção principal
	oCarga:SetFilter(FiltraDAK(lNotaFis))
	//Relaciona a carga com os itens da carga
	oItCarNF:SetRelation({||xFilial('SF2')+DAK->(DAK_COD+DAK_SEQCAR)},"SF2",5,.T.)
	oItCarNF:SetParentFilter({|cParam|SF2->(F2_FILIAL+F2_CARGA+F2_SEQCAR) == cParam},{||xFilial('SF2')+DAK->(DAK_COD+DAK_SEQCAR)})
	If lAnalitico
		//Realiza relacionamento entre DAI e DAK
		oItCarNF:OnPrintLine({||cRegAnt := "",QuerySD2(oItNotFis,cAliasSD2)})
		//Valida se a linha do pedido será impressa e agrupa linhas que não serão exibidas
		oItNotFis:SetLineCondition({||ValLinSD2(cAliasSD2,oItNotFis,lLote,@cRegAnt)} )
	EndIf
	//Posiciona nas tabelas secundárias da seção 1 (Cargas)
	TRPosition():New(oCarga,"DA3",1,{|| xFilial("DA3")+DAK->DAK_CAMINH })
	TRPosition():New(oCarga,"DA4",1,{|| xFilial("DA4")+DAK->DAK_MOTORI })
	//Posiciona nas tabelas secundárias da seção 2 (Itens da Carga)
	TRPosition():New(oItCarNF,"SD2",3,{||Iif(lFilPad,xFilial('SD2'),OsFilial("SD2",SF2->F2_FILIAL))+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)}) //NF
	TRPosition():New(oItCarNF,"SA1",1,{||Iif(lFilPad,xFilial('SA1'),OsFilial("SA1",SF2->F2_FILIAL))+SF2->(F2_CLIENTE+F2_LOJA)}) //Cliente
	TRPosition():New(oItCarNF,"SA2",1,{||Iif(lFilPad,xFilial('SA2'),OsFilial("SA2",SF2->F2_FILIAL))+SF2->(F2_CLIENTE+F2_LOJA)}) //Fornecedor - Necessário para tipos de documento B e D
	If lAnalitico
		//Posiciona nas tabelas secundárias da seção 3 (Pedidos dos Itens da Carga)
		TRPosition():New(oItNotFis,"SD2",3,{||(cAliasSD2)->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM)}) //Pedido
		TRPosition():New(oItNotFis,"SB1",1,{||Iif(lFilPad,xFilial('SB1'),OsFilial("SB1",SF2->F2_FILIAL))+(cAliasSD2)->D2_COD}) //Produto
	EndIf
	If MV_PAR12 == 1
		oCarga:SetPageBreak(.T.)
	EndIf
	oCarga:Print()
Return oReport

/*/{Protheus.doc} ReportPrd
Impressão do Relatório da Ordem por Produto
@author amanda.vieira
@since 13/09/2018
@version 1.0
@param oReport, objeto, objeto report
@type function
/*/
Static Function ReportPrd(oReport,cAliasSC9)
Local oCarga     := oReport:Section(1)
Local oItCarga   := oCarga:Section(1)
Local oItCarNF   := oCarga:Section(2)
Local oPrdCarga  := oCarga:Section(3)
Local oBreak     := Nil
Local cRegAnt    := ""
Local lLote      := MV_PAR14 == 1      //Indica se imprime lote
Local lAnalitico := MV_PAR11 == 2      //Indica se o relatório é do tipo analítico
Local lNotaFis   := MV_PAR13 == 2      //Indica se o relatório deve apresentar apenas cargas faturadas
	//Totalizadores
	oBreak := TRBreak():New(oCarga,oCarga:Cell("DAK_COD"),STR0036,.F.) // Total da Carga
	TRFunction():New(oPrdCarga:Cell("C9_QTDLIB") ,/* cID */,"SUM",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
	TRFunction():New(oPrdCarga:Cell("C9_QTDLIB2"),/* cID */,"SUM",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
	TRFunction():New(oPrdCarga:Cell("C9_VALOR")  ,/* cID */,"SUM",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
	TRFunction():New(oPrdCarga:Cell("C9_PESO")   ,/* cID */,"SUM",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
	TRFunction():New(oPrdCarga:Cell("C9_VOLUME") ,/* cID */,"SUM",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F.,.F./*lEndPage*/)
	//Desabilita seção dos itens da carga e das NFs
	oItCarga:Disable()
	oItCarNF:Disable()
	//Desabilita células de lote
	If !lLote
		oPrdCarga:Cell("C9_LOTECTL"):Disable()
		oPrdCarga:Cell("C9_NUMLOTE"):Disable()
	EndIf
	//Desabilita células da nota fiscal
	If !lNotaFis
		oPrdCarga:Cell("C9_ITEM"):Disable()
		oPrdCarga:Cell("F2_DOC"):Disable()
		oPrdCarga:Cell("F2_SERIE"):Disable()
	EndIf
	//Aplica filtro à seção principal
	oCarga:SetFilter(FiltraDAK(lNotaFis))
	//Realiza relacionamento entre SC9 e DAK
	oCarga:OnPrintLine({||cRegAnt := "",QuerySC9(oPrdCarga,cAliasSC9,.F.,lNotaFis,lAnalitico)})
	//Valida se a linha do pedido será impressa e agrupa linhas que não serão exibidas
	oPrdCarga:SetLineCondition({||ValLinSC9(cAliasSC9,oPrdCarga,lLote,.F.,lNotaFis,lAnalitico,@cRegAnt)} )
	//Posiciona nas tabelas secundárias da seção 1 (Cargas)
	TRPosition():New(oCarga,"DA3",1,{|| xFilial("DA3")+DAK->DAK_CAMINH })
	TRPosition():New(oCarga,"DA4",1,{|| xFilial("DA4")+DAK->DAK_MOTORI })
	//Posiciona nas tabelas secundárias da seção 2 (Produtos da Carga)
	TRPosition():New(oPrdCarga,"SC9",1,{||(cAliasSC9)->(C9_FILIAL+C9_PEDIDO+C9_ITEM)}) //Pedido
	TRPosition():New(oPrdCarga,"SB1",1,{||Iif(lFilPad,xFilial('SB1'),OsFilial("SB1",(cAliasSC9)->C9_FILIAL))+(cAliasSC9)->C9_PRODUTO}) //Produto
	TRPosition():New(oPrdCarga,"SF2",1,{||Iif(lFilPad,xFilial('SF2'),OsFilial("SF2",(cAliasSC9)->C9_FILIAL))+(cAliasSC9)->(C9_NFISCAL+C9_SERIENF+C9_CLIENTE+C9_LOJA)}) //NF
	If MV_PAR12 == 1
		oCarga:SetPageBreak(.T.)
	EndIf
	oCarga:Print()
Return oReport

/*/{Protheus.doc} QuerySC9
Realiza query buscar pedidos de venda
@author amanda.vieira
@since 13/09/2018
@version 1.0
@param oItPedido, objeto, objeto de itens do pedido
@param cAliasSC9, caracter, alias do pedido de venda
@param lOrdPed, lógico, indica se a ordem do relatório é por pedido
@param lNotaFis lógico, indica se o relatório deve apresentar apenas cargas faturadas
@param lAnalitico lógico, indica se o relatório é do tipo analítico
@type function
/*/
Static Function QuerySC9(oItPedido,cAliasSC9,lOrdPed,lNotaFis,lAnalitico)
Local cWhere  := ""
Local cOrder  := ""
Local cFilSC9 := Iif(lFilPad, xFilial("SC9"),"%"+OsFilQry("SC9","DAI.DAI_FILPV")+"%" )
	cWhere := "%"
	If lOrdPed //Se o relatório for por ordem de produto não há quebra por pedido de venda
		cWhere += " SC9.C9_PEDIDO = '"+DAI->DAI_PEDIDO+"' AND"
		cWhere += " SC9.C9_SEQCAR = '"+DAI->DAI_SEQCAR+"' AND "
		cWhere += " SC9.C9_SEQENT = '"+DAI->DAI_SEQUEN+"' AND"
	EndIf
	cWhere += "%"
	cOrder := "%"
	If lNotaFis
		cOrder += " SC9.C9_PRODUTO,"
		cOrder += " SC9.C9_LOTECTL,"
		cOrder += " SC9.C9_NUMLOTE,"
		cOrder += " SC9.C9_NFISCAL,"
		cOrder += " SC9.C9_SERIENF,"
		cOrder += " SC9.C9_ITEM"
	Else
		cOrder += " SC9.C9_PRODUTO,"
		cOrder += " SC9.C9_LOTECTL,"
		cOrder += " SC9.C9_NUMLOTE,"
		cOrder += " SC9.C9_ITEM"
	EndIf
	cOrder += "%"
	oItPedido:BeginQuery()
	BeginSQL Alias cAliasSC9
		SELECT SC9.C9_FILIAL,
			SC9.C9_PEDIDO,
			SC9.C9_ITEM,
			SC9.C9_SEQUEN,
			SC9.C9_PRODUTO,
			SC9.C9_LOTECTL,
			SC9.C9_NUMLOTE,
			SC9.C9_QTDLIB,
			SC9.C9_QTDLIB2,
			SC9.C9_PRCVEN,
			SC9.C9_NFISCAL,
			SC9.C9_SERIENF,
			SC9.C9_CLIENTE,
			SC9.C9_LOJA,
			SC9.C9_CARGA,
			SC9.C9_SEQCAR
		FROM %table:SC9% SC9
	   INNER JOIN %table:DAI% DAI
		  ON DAI.DAI_FILIAL = %xFilial:DAI%
		 AND DAI.DAI_PEDIDO = SC9.C9_PEDIDO
		 AND DAI.DAI_COD    = SC9.C9_CARGA
		 AND DAI.DAI_SEQCAR = SC9.C9_SEQCAR
		 AND DAI.DAI_SEQUEN = SC9.C9_SEQENT
		 AND DAI.%NotDel%
	   WHERE SC9.C9_FILIAL = %exp:cFilSC9% AND
		     SC9.C9_CARGA  = %exp:DAK->DAK_COD% AND
		     SC9.C9_SEQCAR = %exp:DAK->DAK_SEQCAR% AND
		     %Exp:cWhere%
		     SC9.%NotDel%
		ORDER BY %Exp:cOrder%
	EndSql
	oItPedido:EndQuery(/*Array com os parametros do tipo Range*/)
Return

/*/{Protheus.doc} ValLinSC9
Verifica se a linha do pedido será impressa.
Soma as linhas as quantidades das linhas que não serão apresentadas.
@author amanda.vieira
@since 13/09/2018
@version 1.0
@param cAliasSC9, caracter, alias do pedido de venda
@param oSection, objeto, objeto de itens do pedido
@param lLote, lógico, indica se imprime a informação do lote
@param lOrdPed, lógico, indica se a ordem do relatório é por pedido
@param lNotaFis lógico, indica se o relatório deve apresentar apenas cargas faturadas
@param lAnalitico lógico, indica se o relatório é do tipo analítico
@param cRegAnt, caracter, informação do registro anterior
@type function
/*/
Static Function ValLinSC9(cAliasSC9,oSection,lLote,lOrdPed,lNotaFis,lAnalitico,cRegAnt)
Local lRet     := .F.
Local aValores := {}
Local nQtdLib  := 0
Local nQtdLib2 := 0
Local nValor   := 0
Local nPeso    := 0
Local nVolume  := 0
	If lOrdPed .And. lAnalitico .And. !lNotaFis//Ordem = Pedido, Tipo = Analítico, Carga por = Pedidos
		If lLote
			If !((cAliasSC9)->(C9_PRODUTO+C9_LOTECTL+C9_NUMLOTE+C9_ITEM) == cRegAnt)
				cRegAnt := (cAliasSC9)->(C9_PRODUTO+C9_LOTECTL+C9_NUMLOTE+C9_ITEM)
				lRet := .T.
			EndIf
		Else
			If !((cAliasSC9)->(C9_PRODUTO+C9_ITEM) == cRegAnt)
				cRegAnt := (cAliasSC9)->(C9_PRODUTO+C9_ITEM)
				lRet := .T.
			EndIf
		EndIf
	ElseIf !lOrdPed .And. !lNotaFis //Ordem = Produto, Tipo = Analítico ou Sintético, Carga por = Pedidos
		If lLote
			If !((cAliasSC9)->(C9_PRODUTO+C9_LOTECTL+C9_NUMLOTE) == cRegAnt)
				cRegAnt := (cAliasSC9)->(C9_PRODUTO+C9_LOTECTL+C9_NUMLOTE)
				lRet := .T.
			EndIf
		Else
			If !((cAliasSC9)->(C9_PRODUTO) == cRegAnt)
				cRegAnt := (cAliasSC9)->(C9_PRODUTO)
				lRet := .T.
			EndIf
		EndIf
	ElseIf !lOrdPed .And. lNotaFis //Ordem = Produto, Tipo = Analítico ou Sintético, Carga por = Nota Fiscal
		If lLote
			If !((cAliasSC9)->(C9_PRODUTO+C9_LOTECTL+C9_NUMLOTE+C9_NFISCAL+C9_SERIENF+C9_ITEM) == cRegAnt)
				cRegAnt := (cAliasSC9)->(C9_PRODUTO+C9_LOTECTL+C9_NUMLOTE+C9_NFISCAL+C9_SERIENF+C9_ITEM)
				lRet := .T.
			EndIf
		Else
			If !((cAliasSC9)->(C9_PRODUTO+C9_NFISCAL+C9_SERIENF+C9_ITEM) == cRegAnt)
				cRegAnt := (cAliasSC9)->(C9_PRODUTO+C9_NFISCAL+C9_SERIENF+C9_ITEM)
				lRet := .T.
			EndIf
		EndIf
	EndIf
	//Se a linha será impressa seta valores sumarizados às celulas
	If lRet
		aValores := QtdSumSC9(cAliasSC9,lLote,lOrdPed,lAnalitico,lNotaFis)
		nQtdLib  := aValores[1]
		nQtdLib2 := aValores[2]
		nValor   := aValores[3]
		nVolume  := aValores[4]
		nPeso    := aValores[5]
		oSection:Cell("C9_QTDLIB"):SetValue(nQtdLib)
		oSection:Cell("C9_QTDLIB2"):SetValue(nQtdLib2)
		oSection:Cell("C9_VALOR"):SetValue(nValor)
		oSection:Cell("C9_PESO"):SetValue(nPeso)
		oSection:Cell("C9_VOLUME"):SetValue(nVolume)
	EndIf
Return lRet

/*/{Protheus.doc} FiltraDAK
Monta filtro para a tabela DAK
@author amanda.vieira
@since 13/09/2018
@version 1.0
@param lNotaFis lógico, indica se o relatório deve apresentar apenas cargas faturadas
@type function
/*/
Static Function FiltraDAK(lNotaFis)
Local cFiltroDAK := ""
	cFiltroDAK :=       " DAK->DAK_FILIAL = '"+xFilial('DAK')+"'"
	cFiltroDAK += " .And. DAK->DAK_COD    >= '"+MV_PAR01+"'"
	cFiltroDAK += " .And. DAK->DAK_COD    <= '"+MV_PAR02+"'"
	cFiltroDAK += " .And. DAK->DAK_SEQCAR >= '"+MV_PAR03+"'"
	cFiltroDAK += " .And. DAK->DAK_SEQCAR <= '"+MV_PAR04+"'"
	cFiltroDAK += " .And. DAK->DAK_CAMINH >= '"+MV_PAR05+"'"
	cFiltroDAK += " .And. DAK->DAK_CAMINH <= '"+MV_PAR06+"'"
	cFiltroDAK += " .And. DAK->DAK_MOTORI >= '"+MV_PAR07+"'"
	cFiltroDAK += " .And. DAK->DAK_MOTORI <= '"+MV_PAR08+"'"
	cFiltroDAK += " .And. DtoS(DAK->DAK_DATA) >= '"+DtoS(MV_PAR09)+"'"
	cFiltroDAK += " .And. DtoS(DAK->DAK_DATA) <= '"+DtoS(MV_PAR10)+"'"
	If lNotaFis
		cFiltroDAK += " .And. DAK->DAK_FEZNF = '1'"
	EndIf
Return cFiltroDAK

/*/{Protheus.doc} QtdSumSC9
Retorna quantidades sumarizadas da SC9
@author amanda.vieira
@since 13/09/2018
@version 1.0
@param cAliasSC9, caracter, alias do pedido de venda
@param lLote, lógico, indica se imprime a informação do lote
@param lOrdPed, lógico, indica se a ordem do relatório é por pedido
@param lAnalitico lógico, indica se o relatório é do tipo analítico
@param lNotaFis lógico, indica se o relatório deve apresentar apenas cargas faturadas
@type function
/*/
Static Function QtdSumSC9(cAliasSC9,lLote,lOrdPed,lAnalitico,lNotaFis)
Local aValores := {}
Local lPesoLiq := Getmv("MV_PESOCAR") == "L"
Local cQuery   := ""
Local cAliasQry:= GetNextAlias()
Local cFilSB5  := Iif(lFilPad, xFilial("SB5"),OsFilial("SB5",(cAliasSC9)->C9_FILIAL))
Local cFilSB1  := Iif(lFilPad, xFilial("SB1"),OsFilial("SB1",(cAliasSC9)->C9_FILIAL))
	cQuery := " SELECT SUM(SC9.C9_QTDLIB) C9_QTDLIB, "
	cQuery +=        " SUM(SC9.C9_QTDLIB2) C9_QTDLIB2,"
	cQuery +=        " SUM(SC9.C9_PRCVEN * SC9.C9_QTDLIB) C9_VALOR,"
	cQuery +=        " SUM((SB5.B5_ALTURLC * SB5.B5_LARGLC * SB5.B5_COMPRLC)* SC9.C9_QTDLIB) C9_VOLUME,"
	If lPesoLiq
		cQuery +=    " SUM(SB1.B1_PESO * SC9.C9_QTDLIB) C9_PESO"
	Else
		cQuery +=    " SUM(SB1.B1_PESBRU * SC9.C9_QTDLIB) C9_PESO"
	EndIf
	cQuery +=   " FROM "+RetSqlName('SC9')+" SC9"
	cQuery +=   " LEFT JOIN "+RetSqlName('SB5')+" SB5"
	cQuery +=     " ON SB5.B5_FILIAL  = '"+cFilSB5+"'"
	cQuery +=    " AND SB5.B5_COD     = SC9.C9_PRODUTO"
	cQuery +=    " AND SB5.D_E_L_E_T_ = ' '"
	cQuery +=  " INNER JOIN "+RetSqlName('SB1')+" SB1"
	cQuery +=     " ON SB1.B1_FILIAL = '"+cFilSB1+"'"
	cQuery +=    " AND SB1.B1_COD     = SC9.C9_PRODUTO"
	cQuery +=    " AND SB1.D_E_L_E_T_ = ' '"
	cQuery +=  " WHERE SC9.C9_FILIAL  = '"+(cAliasSC9)->C9_FILIAL+"'"
	cQuery +=    " AND SC9.C9_CARGA   = '"+(cAliasSC9)->C9_CARGA+"'"
	cQuery +=    " AND SC9.C9_SEQCAR  = '"+(cAliasSC9)->C9_SEQCAR+"'"
	If lOrdPed
		cQuery +=    " AND SC9.C9_CLIENTE= '"+(cAliasSC9)->C9_CLIENTE+"'"
		cQuery +=    " AND SC9.C9_LOJA   = '"+(cAliasSC9)->C9_LOJA+"'"
		cQuery +=    " AND SC9.C9_PEDIDO = '"+(cAliasSC9)->C9_PEDIDO+"'"
		cQuery +=    " AND SC9.C9_ITEM   = '"+(cAliasSC9)->C9_ITEM+"'"
	ElseIf lNotaFis
		cQuery +=    " AND SC9.C9_ITEM   = '"+(cAliasSC9)->C9_ITEM+"'"
		cQuery +=    " AND SC9.C9_SERIENF = '"+(cAliasSC9)->C9_SERIENF+"'"
		cQuery +=    " AND SC9.C9_NFISCAL = '"+(cAliasSC9)->C9_NFISCAL+"'"
	EndIf
	If lAnalitico .Or. !lOrdPed //Se tipo = analítico ou ordem = produto
		cQuery +=    " AND SC9.C9_PRODUTO = '"+(cAliasSC9)->C9_PRODUTO+"'"
		If lLote
			cQuery += " AND SC9.C9_LOTECTL = '"+(cAliasSC9)->C9_LOTECTL+"'"
			cQuery += " AND SC9.C9_NUMLOTE = '"+(cAliasSC9)->C9_NUMLOTE+"'"
		EndIf
	EndIf
	cQuery +=    " AND SC9.D_E_L_E_T_ = ' '"
	cQuery := ChangeQuery(cQuery)
	DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),cAliasQry,.F.,.T.)
	If (cAliasQry)->(!EoF())
		aValores := {(cAliasQry)->C9_QTDLIB,(cAliasQry)->C9_QTDLIB2,(cAliasQry)->C9_VALOR,(cAliasQry)->C9_VOLUME,(cAliasQry)->C9_PESO}
	EndIf
	(cAliasQry)->(DbCloseArea())
Return aValores

/*/{Protheus.doc} QuerySD2
Realiza query buscar pedidos de venda
@author  guilherme.metzger
@since   28/11/2018
@version 1.0
@param oItNotFis, objeto, objeto de itens da nota fiscal
@param cAliasSD2, caracter, alias da nota fiscal
@type function
/*/
Static Function QuerySD2(oItNotFis,cAliasSD2)
	oItNotFis:BeginQuery()
	BeginSQL Alias cAliasSD2
		SELECT D2_FILIAL,
		       D2_DOC,
		       D2_SERIE,
		       D2_CLIENTE,
		       D2_LOJA,
		       D2_ITEM,
		       D2_COD,
		       D2_LOTECTL,
		       D2_NUMLOTE
		FROM %table:SD2% SD2
	   WHERE SD2.D2_FILIAL  = %xFilial:SD2% AND
		     SD2.D2_DOC     = %exp:SF2->F2_DOC% AND
		     SD2.D2_SERIE   = %exp:SF2->F2_SERIE% AND
		     SD2.D2_CLIENTE = %exp:SF2->F2_CLIENTE% AND
		     SD2.D2_LOJA    = %exp:SF2->F2_LOJA% AND
		     SD2.%NotDel%
		ORDER BY SD2.D2_ITEM,
		         SD2.D2_COD,
		         SD2.D2_LOTECTL,
		         SD2.D2_NUMLOTE
	EndSql
	oItNotFis:EndQuery(/*Array com os parametros do tipo Range*/)
Return

/*/{Protheus.doc} ValLinSD2
Verifica se a linha da nota fiscal será impressa.
Soma as linhas as quantidades das linhas que não serão apresentadas.
@author  guilherme.metzger
@since   28/11/2018
@version 1.0
@param cAliasSC9, caracter, alias do pedido de venda
@param oSection, objeto, objeto de itens do pedido
@param lLote, lógico, indica se imprime a informação do lote
@param cRegAnt, caracter, informação do registro anterior
@type function
/*/
Static Function ValLinSD2(cAliasSD2,oSection,lLote,cRegAnt)
Local lRet     := .F.
Local aValores := {}
Local nQtdLib  := 0
Local nQtdLib2 := 0
Local nValor   := 0
Local nPeso    := 0
Local nVolume  := 0
	If lLote
		If !((cAliasSD2)->(D2_COD+D2_LOTECTL+D2_NUMLOTE+D2_DOC+D2_SERIE+D2_ITEM) == cRegAnt)
			cRegAnt := (cAliasSD2)->(D2_COD+D2_LOTECTL+D2_NUMLOTE+D2_DOC+D2_SERIE+D2_ITEM)
			lRet := .T.
		EndIf
	Else
		If !((cAliasSD2)->(D2_COD+D2_DOC+D2_SERIE+D2_ITEM) == cRegAnt)
			cRegAnt := (cAliasSD2)->(D2_COD+D2_DOC+D2_SERIE+D2_ITEM)
			lRet := .T.
		EndIf
	EndIf
	//Se a linha será impressa seta valores sumarizados às celulas
	If lRet
		aValores := QtdSumSD2(cAliasSD2,lLote)
		nQtdLib  := aValores[1]
		nQtdLib2 := aValores[2]
		nValor   := aValores[3]
		nVolume  := aValores[4]
		nPeso    := aValores[5]
		oSection:Cell("D2_QUANT"):SetValue(nQtdLib)
		oSection:Cell("D2_QTSEGUM"):SetValue(nQtdLib2)
		oSection:Cell("D2_TOTAL"):SetValue(nValor)
		oSection:Cell("D2_PESO"):SetValue(nPeso)
		oSection:Cell("D2_VOLUME"):SetValue(nVolume)
	EndIf
Return lRet

/*/{Protheus.doc} QtdSumSD2
Retorna quantidades sumarizadas da SD2
@author  guilherme.metzger
@since   28/11/2018
@version 1.0
@param cAliasSD2, caracter, alias do pedido de venda
@param lLote, lógico, indica se imprime a informação do lote
@type function
/*/
Static Function QtdSumSD2(cAliasSD2,lLote)
Local aValores  := {}
Local lPesoLiq  := Getmv("MV_PESOCAR") == "L"
Local cQuery    := ""
Local cAliasQry := GetNextAlias()
Local cFilSB5   := Iif(lFilPad, xFilial("SB5"),OsFilial("SB5",(cAliasSD2)->D2_FILIAL))
Local cFilSB1   := Iif(lFilPad, xFilial("SB1"),OsFilial("SB1",(cAliasSD2)->D2_FILIAL))
	cQuery := " SELECT SUM(SD2.D2_QUANT) D2_QUANT, "
	cQuery +=        " SUM(SD2.D2_QTSEGUM) D2_QTSEGUM,"
	cQuery +=        " SUM(SD2.D2_PRCVEN * SD2.D2_QUANT) D2_TOTAL,"
	cQuery +=        " SUM((SB5.B5_ALTURLC * SB5.B5_LARGLC * SB5.B5_COMPRLC)* SD2.D2_QUANT) D2_VOLUME,"
	If lPesoLiq
		cQuery +=    " SUM(SB1.B1_PESO * SD2.D2_QUANT) D2_PESO"
	Else
		cQuery +=    " SUM(SB1.B1_PESBRU * SD2.D2_QUANT) D2_PESO"
	EndIf
	cQuery +=   " FROM "+RetSqlName('SD2')+" SD2"
	cQuery +=  " INNER JOIN "+RetSqlName('SB1')+" SB1"
	cQuery +=     " ON SB1.B1_FILIAL = '"+cFilSB1+"'"
	cQuery +=    " AND SB1.B1_COD     = SD2.D2_COD"
	cQuery +=    " AND SB1.D_E_L_E_T_ = ' '"
	cQuery +=   " LEFT JOIN "+RetSqlName('SB5')+" SB5"
	cQuery +=     " ON SB5.B5_FILIAL  = '"+cFilSB5+"'"
	cQuery +=    " AND SB5.B5_COD     = SD2.D2_COD"
	cQuery +=    " AND SB5.D_E_L_E_T_ = ' '"
	cQuery +=  " WHERE SD2.D2_FILIAL  = '"+(cAliasSD2)->D2_FILIAL+"'"
	cQuery +=    " AND SD2.D2_DOC     = '"+(cAliasSD2)->D2_DOC+"'"
	cQuery +=    " AND SD2.D2_SERIE   = '"+(cAliasSD2)->D2_SERIE+"'"
	cQuery +=    " AND SD2.D2_CLIENTE = '"+(cAliasSD2)->D2_CLIENTE+"'"
	cQuery +=    " AND SD2.D2_LOJA    = '"+(cAliasSD2)->D2_LOJA+"'"
	cQuery +=    " AND SD2.D2_ITEM    = '"+(cAliasSD2)->D2_ITEM+"'"
	cQuery +=    " AND SD2.D2_COD     = '"+(cAliasSD2)->D2_COD+"'"
	If lLote
		cQuery += " AND SD2.D2_LOTECTL = '"+(cAliasSD2)->D2_LOTECTL+"'"
		cQuery += " AND SD2.D2_NUMLOTE = '"+(cAliasSD2)->D2_NUMLOTE+"'"
	EndIf
	cQuery +=    " AND SD2.D_E_L_E_T_ = ' '"
	cQuery := ChangeQuery(cQuery)
	DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),cAliasQry,.F.,.T.)
	If (cAliasQry)->(!EoF())
		aValores := {(cAliasQry)->D2_QUANT,(cAliasQry)->D2_QTSEGUM,(cAliasQry)->D2_TOTAL,(cAliasQry)->D2_VOLUME,(cAliasQry)->D2_PESO}
	EndIf
	(cAliasQry)->(DbCloseArea())
Return aValores

/*/{Protheus.doc} NomeReduz
Retorna o nome reduzido do Cliente ou Fornecedor, dependendo do tipo do documento
@author  guilherme.metzger
@since   05/02/2019
@version 1.0
@type function
/*/
Static Function NomeReduz()
Local cTipoDoc   := ""
Local cNomeReduz := ""
Local cFilSC5    := ""

	// Se a impressão do relatório é por pedido
	If MV_PAR13 == 1
		cFilSC5 := Iif(lFilPad,xFilial("SC5"),DAI->DAI_FILPV)
		SC5->(DbSetOrder(1))
		If SC5->(DbSeek(cFilSC5+DAI->DAI_PEDIDO))
			cTipoDoc := SC5->C5_TIPO
		EndIf
	Else
		cTipoDoc := SF2->F2_TIPO
	EndIf

	// Se o tipo do documento for B - Utiliza Fornecedor ou D - Dev. Compras
	If cTipoDoc $ "B|D"
		cNomeReduz := SA2->A2_NREDUZ
	Else
		cNomeReduz := SA1->A1_NREDUZ
	EndIf

Return cNomeReduz
