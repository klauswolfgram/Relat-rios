/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'
#INCLUDE "FWMVCDEF.CH"

/*/{Protheus.doc} OFAGCR03

	8.2.3. Relatórios itens com pedidos em aberto

    * Número de itens com pedidos em aberto para itens originais e paralelos
    * Por loja para itens originais e paralelos
    * Por item para itens originais e paralelos


	@type function
	@author Vinicius Gati
	@since 06/10/2017
/*/
User Function OFAGCR03()
	Local oMdlAtual   := FWModelActive()
	FWExecView("Consulta de itens com pedidos em aberto", "OFAGCR03", MODEL_OPERATION_UPDATE) // Levantamento Automático
	FWModelActive(oMdlAtual)
return


Static Function ViewDef()
	Local oModel  := Modeldef()
	Local oStr    := getView01()
	Local oStr2   := getView02()

	oView := FWFormView():New()
	oView:SetModel(oModel)

	oView:CreateHorizontalBox('BOXFORM1', 25)
	oView:CreateHorizontalBox('BOXFORM2', 75)

	oView:AddField('FORM1', oStr, 'MASTER')
	oView:SetOwnerView('FORM1','BOXFORM1')

	oView:AddGrid('FORM2', oStr2, "DETAIL")
	oView:SetOwnerView('FORM2','BOXFORM2')

	oView:EnableTitleView('FORM2' , 'Movimentação de Arquivo' )
Return oView


Static Function Modeldef()
	Local oModel
	Local oStr  := getModel01()
	Local oStr2 := getModel02()
	oModel := MPFormModel():New('MLDNOSXS',,,{|oModel| conout('confirmar') })
	oModel:SetDescription('Consulta de pedidos pendentes')
	
	oModel:AddFields("MASTER",,oStr,,,{|| LoadFiltro() })
	oModel:AddGrid("DETAIL", "MASTER", oStr2,,,,, {|| LoadDados(nil) })
	oModel:getModel("MASTER"):SetDescription("Filtro")
	oModel:getModel("DETAIL"):SetDescription("Detalhes")
	oModel:SetPrimaryKey({})
Return oModel

/*/{Protheus.doc} getModelStruct
	Cria o model na maneta
	
	@type function
	@author Vinicius Gati
	@since 09/10/2017
/*/
Static Function getModel01()
	Local oStruct  := FWFormModelStruct():New()
	Local bValid   := { || .T.}
	Local bWhen    := { || .T.}
	Local bRelac   := { || }

	//----------Estrutura do campo tipo Model----------------------------
	// [01] C Titulo do campo
	// [02] C ToolTip do campo
	// [03] C identificador (ID) do Field
	// [04] C Tipo do campo
	// [05] N Tamanho do campo
	// [06] N Decimal do campo
	// [07] B Code-block de validação do campo
	// [08] B Code-block de validação When do campo
	// [09] A Lista de valores permitido do campo
	// [10] L Indica se o campo tem preenchimento obrigatório
	// [11] B Code-block de inicializacao do campo
	// [12] L Indica se trata de um campo chave
	// [13] L Indica se o campo pode receber valor em uma operação de update.
	// [14] L Indica se o campo é virtual
	oStruct:AddField("Num. Pedido","Num. Pedido", "FLD_1", "C", 50, 0, , ,,, , .F.,,,)
	oStruct:AddField("Item"       ,"Item"       , "FLD_2", "C", 50, 0, bValid, bWhen,,, bRelac, .F.,,,)
	oStruct:AddField("Filial"     ,"Filial"     , "FLD_3", "C", 50, 0, bValid, bWhen,,, bRelac, .F.,,,)
	oStruct:AddField('Buscar'     ,'Buscar'     , 'BTN'  , 'BT', 1, 0, { |oMdl| loadDados(oMdl), .T. }, bWhen,,, bRelac, .F.,,,)
Return oStruct

Static Function getModel02()
	Local oStruct  := FWFormModelStruct():New()
	Local bValid   := { || .T.}
	Local bWhen    := { || .T.}
	Local bRelac   := { || }

	oStruct:AddField("Filial"         , "Filial"         , "GRID_3", "C", 50, 0, bValid, bWhen,,, bRelac, .F.,,,)
	oStruct:AddField("Num. Pedido"    , "Num. Pedido"    , "GRID_1", "C", 10, 0, bValid, bWhen,,, bRelac, .F.,,,)
	oStruct:AddField("Item"           , "Item"           , "GRID_2", "C", 10, 0, bValid, bWhen,,, bRelac, .F.,,,)
	oStruct:AddField("Qtd Em Aberto"  , "Qtd Em Aberto"  , "GRID_4", "C", 10, 0, bValid, bWhen,,, bRelac, .F.,,,)
	oStruct:AddField("Original"       , "Original"       , "GRID_5", "C", 10, 0, bValid, bWhen,,, bRelac, .F.,,,)
Return oStruct

Static Function getView01()
	Local oStru := FWFormViewStruct():New()
	Local bValid   := { || .T. }
	Local bWhen    := { || .T.}
	Local bRelac   := { || }

	//----------------Estrutura para criação do campo-----------------------------
	// [01] C Nome do Campo
	// [02] C Ordem
	// [03] C Titulo do campo
	// [04] C Descrição do campo
	// [05] A Array com Help
	// [06] C Tipo do campo
	// [07] C Picture
	// [08] B Bloco de Picture Var
	// [09] C Consulta F3
	// [10] L Indica se o campo é evitável
	// [11] C Pasta do campo
	// [12] C Agrupamento do campo
	// [13] A Lista de valores permitido do campo (Combo)
	// [14] N Tamanho Maximo da maior opção do combo
	// [15] C Inicializador de Browse
	// [16] L Indica se o campo é virtual
	// [17] C Picture Variável

	oStru:AddField('FLD_1','1','Filial'    ,'Filial'   ,, 'C'  ,'@!',,'C',.T.,,,,,,,,)
	oStru:AddField('FLD_2','2','Pedido'    ,'Pedido'   ,, 'Get','@!',,'C',.T.,,,,,,,,)
	oStru:AddField('FLD_3','3','Item'      ,'Item'     ,, 'C'  ,'@!',,'C',.T.,,,,,,,,)
	oStru:AddField('BTN'  ,'4','Buscar'    ,'Buscar'   ,, 'BT' ,,,,,,,,,,,,)
Return oStru

Static Function getView02()
	Local oStru := FWFormViewStruct():New()
	Local bValid   := { || .T. }
	Local bWhen    := { || .T.}
	Local bRelac   := { || }

	oStru:AddField('GRID_1','1','Filial'    ,'Filial'   ,,'Get',,,'C',.F.,,,,,,,,)
	oStru:AddField('GRID_2','2','Pedido'    ,'Pedido'   ,,'Get',,,'C',.F.,,,,,,,,)
	oStru:AddField('GRID_3','3','Item'      ,'Item'     ,,'Get',,,'C',.F.,,,,,,,,)
	oStru:AddField('GRID_4','4','Em aberto' ,'Em aberto',,'Get',,,'C',.F.,,,,,,,,)
	oStru:AddField('GRID_5','5','Original'  ,'Original' ,,'Get',,,'C',.F.,,,,,,,,)
Return oStru

Static Function LoadFiltro()
return { {'', '', '', ''} , 0 }

/*/{Protheus.doc} LoadDados
	(long_description)
	@type  Function
	@author Vinicius Gati
	@since 09/10/2017
	@version undefined
/*/
Static Function LoadDados(oField)
	Local cQuery  := ""
	Local oSql    := DMS_SqlHelper():New()
	Local aRes    := {}
	Local aRet    := {}
	Local nX      := 1 
	Local cFi     := IF((oField != nil), AllTrim(oField:GetValue("FLD_1")), "")
	Local cPedido := IF((oField != nil), AllTrim(oField:GetValue("FLD_2")), "")
	Local cItem   := IF((oField != nil), AllTrim(oField:GetValue("FLD_3")), "")

	// Local oVmiPars := OFAGVmiParametros():New()

	cQuery += "      SELECT C7_FILIAL, C7_NUM, C7_PRODUTO, C7_QUANT - C7_QUJE as QTDENC,  CASE WHEN BM_PROORI = '1' THEN 'Original' ELSE 'Paralelo' END "
	cQuery += "        FROM " + RetSqlName('SC7') + " SC7 "
	cQuery += "   LEFT JOIN " + RetSqlName('SB1') + " SB1 ON B1_FILIAL = '"+xFilial('SB1')+"' AND B1_COD   = C7_PRODUTO AND SB1.D_E_L_E_T_ = ' ' "
	cQuery += "   LEFT JOIN " + RetSqlName('SBM') + " SBM ON BM_FILIAL = '"+xFilial('SBM')+"' AND BM_GRUPO = B1_GRUPO   AND SBM.D_E_L_E_T_ = ' ' "
	//cQuery += "  WHERE SC7.C7_ENCER   = ' ' "
	//cQuery += "    AND SC7.C7_QUANT   > C7_QUJE "
	//cQuery += "    AND SC7.C7_RESIDUO = ' ' "
	//cQuery += "    AND SBM.BM_GRUPO IN () "
	cQuery += "         AND SC7.D_E_L_E_T_ = ' ' "
	
	
	If !EMPTY(cFi)
		cQuery += " AND SC7.C7_FILIAL = '"+cFi+"' "
	else
		cQuery += " AND SC7.C7_FILIAL  = '"+xFilial('SC7')+"' "
	EndIf
	
	If !EMPTY(cItem)
		cQuery += " AND SC7.C7_ITEM = '"+cItem+"' "
	EndIf

	If !EMPTY(cPedido)
		cQuery += " AND SC7.C7_NUM = '"+cPedido+"' "
	EndIf
	
	aRes := oSql:GetSelectArray(cQuery, 5)

	For nX:= 1 to Len(aRes)
		AADD(aRet, {0, aRes[nX]})
	Next

Return aRet
