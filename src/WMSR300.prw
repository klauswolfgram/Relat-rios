/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'WMSR300.CH'  
#INCLUDE 'FIVEWIN.CH'

//----------------------------------------------------------
/*/{Protheus.doc} WMSR300
Romaneio de Separação

@author  Felipe Nunes Toledo
@version	P11
@since   18/10/06 - revisão 30/09/14
/*/
//----------------------------------------------------------
User Function WMSR300()
Local oReport	
	If !SuperGetMV("MV_WMSNEW", .F., .F.)
		Return dlgr300()
	EndIf	
	// Interface de impressão
	oReport:= ReportDef()
	oReport:PrintDialog()
Return
//----------------------------------------------------------
// Definições do relatório
//----------------------------------------------------------
Static Function ReportDef()
Local oReport
Local oSection1, oSection2, oSection3
Local cTitle   := STR0001 // Romaneio de Separacao por Carga
Local cPerg    := "DLR300"
Local cPictQtd := PesqPict("D12","D12_QTDMOV")
	oReport:= TReport():New("WMSR300",cTitle,cPerg, {|oReport| ReportPrint(oReport)},STR0002+STR0003+STR0004) // Emite Relatorio de Romaneio de Separacao ordenado por'##'Carga+Sequencia de Carga. Em cada Carga os itens sao // ordenados por Pedido+Cliente/Fornecedor+Loja+Item
	
	Pergunte(oReport:GetParam(),.F.)
	// Seção 1 - Informações Genéricas da Carga
	oSection1 := TRSection():New(oReport,STR0034,{"D12","DA3","DA4","DAK"},/*Ordem*/) // Cargas
	oSection1:SetLineStyle()
	oSection1:SetCols(4)
	TRCell():New(oSection1,'D12_CARGA' ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'D12_SEQCAR','D12',STR0037   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Seq
	TRCell():New(oSection1,'CHEGADA'   ,'D12',STR0029   ,/*Picture*/,12         ,/*lPixel*/, {|| '[______]' }         		  ) // Chegada
	TRCell():New(oSection1,'SAIDA'     ,'D12',STR0030   ,/*Picture*/,12         ,/*lPixel*/, {|| '[______]' }        		  ) // Saida
	TRCell():New(oSection1,'DA3_DESC'  ,'DA3',STR0038   ,/*Picture*/,27         ,/*lPixel*/,/*{|| code-block de impressao }*/) // Veiculo
	TRCell():New(oSection1,'DA4_NOME'  ,'DA4',/*Titulo*/,/*Picture*/,28         ,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'DAK_PESO'  ,'DAK',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'DAK_VALOR' ,'DAK',STR0039   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Valor
	TRCell():New(oSection1,'DAK_DATA'  ,'DAK',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'DAK_HORA'  ,'DAK',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'D12_ENDDES','D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	oSection1:Cell('DA4_NOME' ):SetCellBreak()
	oSection1:Cell('DAK_VALOR'):SetCellBreak()
	// Seção 2 - Itens da Carga
	oSection2 := TRSection():New(oSection1,STR0035,{"D12","SA1","SA2","DAI"},/*Ordem*/,,,,,,,,,,,5) // Itens da Carga
	oSection2:SetLineStyle()
	TRCell():New(oSection2,'D12_DOC'   ,'D12',STR0040   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Pedido
	TRCell():New(oSection2,'D12_CLIFOR','D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D12_LOJA'  ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'A1_NOME'   ,'SA1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'A2_NOME'   ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'DAI_PESO'  ,'DAI',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	oSection2:SetNoFilter({"SA1","SA2","DAI"})
	// Seção 3 - Movimentos por Endereço
	oSection3 := TRSection():New(oSection2,STR0036,{"D12","SB1"},/*Ordem*/,,,,,,,,,,,2) // Movimentos por Endereço
	TRCell():New(oSection3,'D12_SERIE' ,'D12', STR0041  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Item
	TRCell():New(oSection3,'D12_PRODUT','D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,'B1_DESC'   ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,'D12_LOTECT','D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,'D12_NUMLOT','D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,'D12_ENDORI','D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,'UNITIZADA' ,'D12', STR0031  ,cPictQtd   ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Unitizada
	TRCell():New(oSection3,'D12_QTDMO2','D12', STR0033  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // 2aUM
	TRCell():New(oSection3,'D12_QTDMOV','D12', STR0032  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // 1aUM
	oSection3:SetNoFilter({"SB1"})
Return(oReport)
//----------------------------------------------------------
// Impressão do relatório
//----------------------------------------------------------
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(1):Section(1)
Local cQryRel   := GetNextAlias()
Local cCompSec2 := ""
Local cCompSec3 := ""
Local cWhere01  := ""
Local cWhere02  := ""
Local cWhere03  := ""
Local aQtds     := {}
	// Inibindo Celulas conforme parametro mv_par09
	If mv_par09 == 1 // 1aUM
		oSection3:Cell('UNITIZADA' ):Disable()
		oSection3:Cell('D12_QTDMO2'):DiSable()
	ElseIf mv_par09 == 2 // 2aUM
		oSection3:Cell('UNITIZADA' ):Disable()
		oSection3:Cell('D12_QTDMOV'):Disable()
	ElseIf mv_par09 == 4 // Nao Imprime Quantidades
		oSection3:Cell('UNITIZADA' ):Disable()
		oSection3:Cell('D12_QTDMOV'):Disable()
		oSection3:Cell('D12_QTDMO2'):DiSable()
	EndIf
	
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	
	cWhere02 := "%'"+CriaVar("D12_CARGA"  ,.F.)+"'%"
	
	cWhere03 := "% (SELECT DC5_ORDEM"+;
	                " FROM "+RetSqlName('DC5')+" DC5"+;
					 " WHERE DC5.DC5_FILIAL = '"+xFilial('DC5')+"'"+;
					   " AND DC5.DC5_SERVIC = D12.D12_SERVIC"+;
					   " AND DC5.DC5_TAREFA = D12.D12_TAREFA"+;
					   " AND DC5.DC5_OPERAC IN ('3','4')"+;
					   " AND DC5.D_E_L_E_T_ = ' ') %"
	
	// Query do relatório
	oSection1:BeginQuery()
	BeginSql Alias cQryRel
	SELECT D12.D12_FILIAL, D12.D12_CARGA, D12.D12_SEQCAR, D12.D12_SERVIC, D12.D12_TAREFA, D12.D12_ATIVID,
	       D12.D12_ENDDES, D12.D12_DOC, D12.D12_CLIFOR, D12.D12_LOJA, D12.D12_SERIE, D12.D12_PRODUT, D12.D12_LOTECT,
	       D12.D12_NUMLOT, D12.D12_ENDORI, D12.D12_QTDMOV, D12.D12_QTDMO2, D12.D12_DTGERA, D12.D12_ORIGEM,
	       D12.D12_ORDTAR, D12.D12_ORDATI, D12.D12_LOCORI
	FROM %table:D12% D12
	WHERE D12.D12_FILIAL  =  %xFilial:D12%
	  AND D12.D12_DOC     Between %Exp:mv_par01% AND %Exp:mv_par02%
	  AND D12.D12_CARGA   Between %Exp:mv_par03% AND %Exp:mv_par04%
	  AND D12.D12_SEQCAR  Between %Exp:mv_par05% AND %Exp:mv_par06%
	  AND D12.D12_DTGERA  Between %Exp:mv_par07% AND %Exp:mv_par08%
	  AND D12.D12_CARGA   <> %Exp:cWhere02%
	  AND D12.D12_ORDTAR  =  %Exp:cWhere03%
	  AND D12.D12_ORDMOV  IN ('1','4')
	  AND D12.D12_ORIGEM  = 'SC9'
	  AND D12.D12_QTDMOV  >  0
	  AND D12.D12_STATUS <> 0
	  AND D12.%NotDel%
	ORDER BY D12.D12_FILIAL, D12.D12_CARGA, D12.D12_SEQCAR, D12.D12_DOC
	EndSql
	oSection1:EndQuery()
	// Posicionamento das tabelas
	TRPosition():New(oSection1,"DAK",1,{|| xFilial("DAK") + (cQryRel)->(D12_CARGA + D12_SEQCAR)           })
	TRPosition():New(oSection1,"DA3",1,{|| xFilial("DA3") + DAK->DAK_CAMINH                               })
	TRPosition():New(oSection1,"DA4",1,{|| xFilial("DA4") + DAK->DAK_MOTORI                               })
	TRPosition():New(oSection1,"DAI",4,{|| xFilial("DAI") + (cQryRel)->(D12_DOC + D12_CARGA + D12_SEQCAR) })
	TRPosition():New(oSection2,"SA1",1,{|| xFilial("SA1") + (cQryRel)->(D12_CLIFOR+D12_LOJA)              })
	TRPosition():New(oSection2,"SA2",1,{|| xFilial("SA2") + (cQryRel)->(D12_CLIFOR+D12_LOJA)              })
	TRPosition():New(oSection2,"SC5",1,{|| xFilial("SC5") + (cQryRel)->D12_DOC                            })
	TRPosition():New(oSection3,"SB1",1,{|| xFilial("SB1") + (cQryRel)->D12_PRODUT                         })

	oSection2:SetParentQuery()
	oSection3:SetParentQuery()
	// Fluxo de Impressao do Relatorio
	oReport:SetMeter( D12->(LastRec()) )
	
	While !oReport:Cancel() .And. !(cQryRel)->(Eof())
	   oSection1:Init()
		// Impressão da seção 1
		oSection1:PrintLine()
		oReport:ThinLine()
		
		cCompSec2 := (cQryRel)->(D12_FILIAL + D12_CARGA + D12_SEQCAR)
		While !oReport:Cancel() .And. !(cQryRel)->(Eof()) .And. (cQryRel)->(D12_FILIAL + D12_CARGA + D12_SEQCAR) == cCompSec2
	
		   oSection2:Init()
	
		   // Dependendo do tipo do pedido de venda, apresenta o nome do cliente ou fornecedor
			Iif(SC5->C5_TIPO $ 'NCIPSTO',oSection2:Cell('A2_NOME'):Disable(),oSection2:Cell('A1_NOME'):Disable())
	
			// Impressão da seção 2
			oSection2:PrintLine()
	
			// Dependendo do tipo do pedido de venda, apresenta o nome do cliente ou fornecedor
			Iif(SC5->C5_TIPO $ 'NCIPSTO',oSection2:Cell('A2_NOME'):Enable(),oSection2:Cell('A1_NOME'):Enable())
	
			oSection3:Init()
	
			cCompSec3 := (cQryRel)->(D12_FILIAL + D12_CARGA + D12_SEQCAR + D12_DOC)
			While !oReport:Cancel() .And. (cQryRel)->(D12_FILIAL+D12_CARGA+D12_SEQCAR+D12_DOC) == cCompSec3
	
				oReport:IncMeter()
				If mv_par09 == 3
					// Calcula as quantidades em unitizador, 2aUM e 1aUM e preenche as células correspondentes
					aQtds := W300Qtd((cQryRel)->D12_PRODUT,(cQryRel)->D12_LOCORI,(cQryRel)->D12_ENDORI,(cQryRel)->D12_QTDMOV)
					oSection3:Cell('UNITIZADA' ):SetValue(aQtds[1])
					oSection3:Cell('D12_QTDMO2'):SetValue(aQtds[2])
					oSection3:Cell('D12_QTDMOV'):SetValue(aQtds[3])
				EndIf
				// Impressão da seção 3
				oSection3:PrintLine()
				(cQryRel)->(DbSkip())
			EndDo
			oSection3:Finish()
			oSection2:Finish()
			oReport:SkipLine()
		EndDo
		oSection1:Finish()
		If MV_PAR10 == 1
			oReport:EndPage()
		EndIf
	EndDo
	(cQryRel)->(DbCloseArea())
Return Nil
//-------------------------------------------------------------
// Calcula a quantidade de produtos em unitizadores, 2a unidade
// de medida e 1a unidade de medida
//-------------------------------------------------------------
Static Function W300Qtd(cProduto, cLocal, cEnder, nQuant)
Local aAreaAnt  := GetArea()
Local cAliasQry := GetNextAlias()
Local cQuery    := ''
Local aRet      := {0,0,0}
Local QtdUni    := 0
Local Qtd2UM    := 0
Local Qtd1UM    := 0
	cQuery := " SELECT (DC2.DC2_LASTRO * DC2.DC2_CAMADA) AS NORMA, " 
	cQuery +=        " SB5.B5_UMIND "
	cQuery +=   " FROM "+RetSqlName("DC2")+" DC2 "
	cQuery +=  " INNER JOIN "+RetSqlName("DC3")+" DC3 "
	cQuery +=     " ON DC3.DC3_CODNOR = DC2.DC2_CODNOR "
	cQuery +=    " AND DC3.DC3_FILIAL = '"+xFilial("DC3")+"' "
	cQuery +=    " AND DC3.D_E_L_E_T_ = '' "
	cQuery +=    " AND DC3.DC3_LOCAL  = '"+cLocal+"' "
	cQuery +=    " AND DC3.DC3_CODPRO = '"+cProduto+"' "
	cQuery +=    " AND DC3.DC3_TPESTR = ( SELECT SBE.BE_ESTFIS "
	cQuery +=                             " FROM "+RetSqlName("SBE")+" SBE "
	cQuery +=                            " WHERE SBE.BE_FILIAL   = '"+xFilial("SBE")+"' "
	cQuery +=                              " AND SBE.D_E_L_E_T_  = '' "
	cQuery +=                              " AND SBE.BE_LOCALIZ  = '"+cEnder+"' "
	cQuery +=                              " AND SBE.BE_LOCAL = DC3.DC3_LOCAL"
	cQuery +=                              " AND ( SBE.BE_CODPRO = '' OR SBE.BE_CODPRO = DC3.DC3_CODPRO ) ) "
	cQuery +=  " INNER JOIN "+RetSqlName("SB5")+" SB5 "
	cQuery +=     " ON SB5.B5_COD     = DC3.DC3_CODPRO "
	cQuery +=    " AND SB5.B5_FILIAL  = '"+xFilial("SB5")+"' "
	cQuery +=    " AND SB5.D_E_L_E_T_ = '' "
	cQuery +=  " WHERE DC2.DC2_FILIAL = '"+xFilial("DC2")+"' "
	cQuery +=    " AND DC2.D_E_L_E_T_ = '' "
	cQuery := ChangeQuery(cQuery)
	DbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAliasQry,.T.,.F.)
	If (cAliasQry)->(!Eof())
		QtdUni := Int(nQuant / (cAliasQry)->NORMA)
		nQuant -= (QtdUni * (cAliasQry)->NORMA)
		Qtd2UM := Int(ConvUm(cProduto,nQuant,0,2))
		Qtd1UM := nQuant - ConvUm(cProduto,0,Qtd2UM,1)
		aRet   := {QtdUni, Qtd2UM, Qtd1UM}
	EndIf
	(cAliasQry)->(DbCloseArea())
	RestArea(aAreaAnt)
Return aRet
