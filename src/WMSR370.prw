/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'Protheus.ch'  
#include 'WMSR370.ch'

//-----------------------------------------------------------
/*/{Protheus.doc} WMSR370
Geração e impressão do mapa de separação embalado                     

@version	P11
@since   03/05/06 - revisão 17/09/14
/*/
//-----------------------------------------------------------
User Function WmsR370()
Local oReport
	If SuperGetMv("MV_WMSNEW",.F.,.F.)
		Return WMSR371()
	EndIf
	// Interface de impressão
	oReport := ReportDef()
	oReport:PrintDialog()
Return 
//-----------------------------------------------------------
//  Definições do relatório
//-----------------------------------------------------------
Static Function ReportDef()
Local oReport, oSection1, oSection2, oBreak
Local cQryRel  := GetNextAlias()
Local cTitle   := STR0001 // Mapa de Separação Embalado
Local cPictQtd := PesqPict("SDB","DB_QUANT")     
Local nTamQtd  := TamSx3("DB_QUANT")[1]          
Local cPictUM  := PesqPict("SB1","B1_UM")    
	// Definição do relatório
	oReport := TReport():New('WMSR370', cTitle,'WMR370',{|oReport| ReportPrint(oReport,cQryRel)},STR0030) // Este relatório tem por objetivo Gerar e Imprimir ou apenas Imprimir um Mapa de Separação para quantidades em unidades agrupadoras (caixas, por exemplo), de acordo com os parâmetros informados. 
	
	// Verifica os parâmetros selecionados via Pergunte
	Pergunte(oReport:GetParam(),.F.)    
	
	// Seção 1 - Informações do mapa de separação e documento
	If WmsX212118("D0T")
		oSection1 := TRSection():New(oReport,STR0031,{'SDB','D0T','DA3'},,,,,,,,,,,.T.,,,,,3) // Cabeçalho Mapa de Separação
	Else
		oSection1 := TRSection():New(oReport,STR0031,{'SDB','DA3'},,,,,,,,,,,.T.,,,,,3) // Cabeçalho Mapa de Separação
	EndIf
	TRCell():New(oSection1,'DB_MAPSEP' ,'SDB'    ,/*Titulo*/,/*Picture*/            ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'DB_CARGA'  ,'SDB'    ,/*Titulo*/,/*Picture*/            ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'DB_DOC'    ,'SDB'    , STR0032  ,/*Picture*/            ,/*Tamanho*/,/*lPixel*/,  {|| Iif(WmsCarga((cQryRel)->DB_CARGA),'',(cQryRel)->DB_DOC)}  ) // Pedido
	TRCell():New(oSection1,'DB_ENDDES' ,'SDB'    ,/*Titulo*/,/*Picture*/            ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,'DB_UNITIZ' ,'SDB'    ,/*Titulo*/,/*Picture*/            ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	If WmsX312118("D0T","D0T_DESUNI",.T.)
		TRCell():New(oSection1,'D0T_DESUNI','D0T'    ,/*Titulo*/,/*Picture*/            ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	EndIf
	TRCell():New(oSection1,'DA3_PLACA' ,'DA3'    , STR0028  ,/*Picture*/            ,/*Tamanho*/,/*lPixel*/,  {|| W380Placa()             }  ) // Placa do Veiculo
	
	// Seção 2 - Itens do mapa de separação
	oSection2 := TRSection():New(oSection1,STR0033,{'SDB','SB1'},,,,,,,,,,,,2) // Itens do Mapa de Separação
	TRCell():New(oSection2,'DB_CLIFOR' ,'SDB'    , STR0019  ,/*Picture*/           ,/*Tamanho*/       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) 
	TRCell():New(oSection2,'DB_LOJA'   ,'SDB'    ,/*Titulo*/,/*Picture*/           ,/*Tamanho*/       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) 
	TRCell():New(oSection2,'DB_PRODUTO','SDB'    ,/*Titulo*/,/*Picture*/           ,/*Tamanho*/       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) 
	TRCell():New(oSection2,'B1_DESC'   ,'SB1'    ,/*Titulo*/,/*Picture*/           ,/*Tamanho*/       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) 
	TRCell():New(oSection2,'DB_QUANT'  ,'SDB'    , STR0020  ,/*Picture*/           ,/*Tamanho*/       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) 
	TRCell():New(oSection2,'B1_UM'     ,'SB1'    ,/*Titulo*/,/*Picture*/           ,/*Tamanho*/       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) 
	TRCell():New(oSection2,'DB_QTSEGUM','SDB'    , STR0021  ,/*Picture*/           ,/*Tamanho*/       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) // Qtde Emb
	TRCell():New(oSection2,'B1_SEGUM'  ,'SB1'    ,/*Titulo*/,/*Picture*/           ,/*Tamanho*/       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.) 
	TRCell():New(oSection2,'C/'        ,'SDB'    ,/*Titulo*/,/*Picture*/           ,  2               ,/*lPixel*/, {|| STR0022                  }  ,,,,,,.F.) // C/
	TRCell():New(oSection2,'B1_CONV'   ,'SB1'    ,/*Titulo*/,/*Picture*/           ,/*Tamanho*/       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) 
	TRCell():New(oSection2,'B1_UM2'    ,'SB1'    ,/*Titulo*/, PesqPictQt('B1_UM')  ,TamSX3('B1_UM')[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) 
	TRCell():New(oSection2,'DB_LOCAL'  ,'SDB'    ,/*Titulo*/,/*Picture*/           ,/*Tamanho*/       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) 
	TRCell():New(oSection2,'DB_LOCALIZ','SDB'    ,/*Titulo*/,/*Picture*/           ,  20              ,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.) 
	TRCell():New(oSection2,'PSTOTAL'   ,/*Alias*/, STR0024  , cPictQtd             , nTamQtd          ,/*lPixel*/, {|| ((cQryRel)->DB_QUANT * (cQryRel)->B1_PESO)                                                   },,,,,,.T.) // Peso Total (KG)
	TRCell():New(oSection2,'CUBAGEM'   ,/*Alias*/, STR0025  , PesqPictQt('B1_PESO'), nTamQtd          ,/*lPixel*/, {|| ((cQryRel)->DB_QUANT * (cQryRel)->B5_ALTURLC * (cQryRel)->B5_LARGLC * (cQryRel)->B5_COMPRLC) },,,,,,.T.) // Cubagem
	
	// Cabeçalhos e células que não devem aparecer no relatório
	oSection2:Cell('B1_UM'   ):HideHeader()
	oSection2:Cell('B1_SEGUM'):HideHeader()
	oSection2:Cell('C/'      ):HideHeader()
	oSection2:Cell('B1_CONV' ):HideHeader()
	oSection2:Cell('B1_UM2'  ):HideHeader()
	oSection2:Cell('PSTOTAL' ):HideHeader()
	oSection2:Cell('CUBAGEM' ):HideHeader()
	oSection2:Cell('PSTOTAL' ):Hide()
	oSection2:Cell('CUBAGEM' ):Hide()
	
	TRPosition():New(oSection2,'SB1',1,{|| xFilial('SB1')+SDB->DB_PRODUTO})
	
	// Definição das quebras e totalizadores que serão impressos
	oBreak := TRBreak():New(oSection1,oSection1:Cell('DB_MAPSEP'),STR0029,.T.) // 'Totais'
	TRFunction():New(oSection2:Cell('DB_PRODUTO'),NIL,'COUNT',oBreak, STR0023   ,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.) // Nr. Itens
	TRFunction():New(oSection2:Cell('DB_QTSEGUM'),NIL,'SUM'  ,oBreak,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oSection2:Cell('PSTOTAL')   ,NIL,'SUM'  ,oBreak,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oSection2:Cell('CUBAGEM')   ,NIL,'SUM'  ,oBreak,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.)
Return oReport
//-----------------------------------------------------------
//  Impressão do relatório
//-----------------------------------------------------------
Static Function ReportPrint(oReport,cQryRel)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local cSemMpSep := Space(Len(SDB->DB_MAPSEP))
Local cStatAExe := '4'
Local cWhere01  := ''
Local cWhere02  := ''
Local cMapa     := ''
Local cSeekQry  := ''
Local cCodUni   := ''
Local cDesUni   := ''
Local cDesEnd	  := ''
Local cPictEnd  := ''
Local aEndereco := {}
Local aAtiv     := {}
Local nSeek     := 0
Local bSeekQry
Local nRow      := Iif(oReport:nDevice == 6,   2,   1)
Local nCol      := Iif(oReport:nDevice == 6, 0.5, 0.2)

	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	
	cWhere01 := "%'"+CriaVar("DB_ESTORNO",.F.)+"'%"
	
	If	mv_par01 == 1
		cWhere02 := "% SDB.DB_STATUS = '"+cStatAExe+"'"
		cWhere02 += " AND SDB.DB_CARGA BETWEEN '"+mv_par02+"' AND '"+mv_par03+"'"
		cWhere02 += " AND SDB.DB_DOC BETWEEN '"+mv_par04+"' AND '"+mv_par05+"'"
		If	mv_par09 == 1
			cWhere02 += " AND DB_MAPSEP  BETWEEN '"+mv_par06+"' AND '"+mv_par07+"' %"
		Else
			cWhere02 += " AND DB_MAPSEP = '"+cSemMpSep+"' %"
		EndIf
	Else
		cWhere02 := "% SDB.DB_MAPSEP BETWEEN '"+mv_par06+"' AND '"+mv_par07+"'"
		cWhere02 += " AND SDB.DB_MAPSEP <> ' '"
		cWhere02 += " AND SDB.DB_STATUS IN ('4','3','2','-') %"
	EndIf
	
	// Query do relatorio 
	oSection1:BeginQuery()
		BeginSql Alias cQryRel		
			SELECT SDB.DB_FILIAL, SDB.DB_CARGA, SDB.DB_SEQCAR, SDB.DB_DOC, SDB.DB_SERIE, SDB.DB_CLIFOR, SDB.DB_LOJA,
		          SDB.DB_PRODUTO, SDB.DB_QUANT, SDB.DB_LOCAL, SDB.DB_LOCALIZ, SDB.DB_UNITIZ,       
		          SDB.DB_ENDDES, SDB.DB_MAPSEP, SDB.DB_IDMOVTO, SDB.R_E_C_N_O_ RECSDB, 
		          SB1.B1_PESO, SB5.B5_ALTURLC, SB5.B5_LARGLC, SB5.B5_COMPRLC                                                    
		          
			FROM %table:SDB% SDB
			
			JOIN %table:SB1% SB1 ON SB1.B1_FILIAL = %xFilial:SB1% AND SB1.B1_COD = SDB.DB_PRODUTO AND SB1.%NotDel%
			
			JOIN %table:SB5% SB5 ON SB5.B5_FILIAL = %xFilial:SB5% AND SB5.B5_COD = SDB.DB_PRODUTO AND SB5.%NotDel% AND
			SB5.B5_WMSEMB = '1'
			
			WHERE SDB.DB_FILIAL  = %xFilial:SDB% AND
					SDB.DB_ESTORNO = %Exp:cWhere01% AND
					SDB.DB_ATUEST  = 'N' AND
					SDB.DB_TM      > '500' AND
					SDB.DB_TIPO    = 'E' AND
					%Exp:cWhere02% And
					SDB.%NotDel%
			
			ORDER BY SDB.DB_FILIAL,SDB.DB_CARGA,SDB.DB_SEQCAR,SDB.DB_CLIFOR,SDB.DB_LOJA,SDB.DB_DOC,SDB.DB_SERIE,SDB.DB_ENDDES,SDB.DB_UNITIZ,SDB.DB_LOCALIZ
		EndSql
	oSection1:EndQuery()
	
	// Fluxo de impressão do relatório
	oReport:SetMeter((cQryRel)->(LastRec()))
	
	While !oReport:Cancel() .And. !(cQryRel)->(Eof())
		
		If	mv_par01 == 1
			cMapa := WMSProxSeq("MV_WMSMPSP","DB_MAPSEP")
		ElseIf mv_par01 == 2
			cMapa := (cQryRel)->DB_MAPSEP
		EndIf
		
		// Busca o código de configuração de endereço e formata sua descrição
		// (assumindo que todos os endereços possuam a mesma configuração)
		aEndereco := {}
		W380DesEnd(@cDesEnd,@cPictEnd,aEndereco,cQryRel)
		
		// Busca código e descrição do unitizador
		If WmsArmUnit((cQryRel)->DB_LOCAL)
			W380DesUni(@cCodUni,@cDesUni)
		EndIf
	
		oSection1:Init()
		
		// Início da impressão das informações do mapa de separação e documento	
		oSection1:Cell('DB_MAPSEP' ):SetValue(cMapa)
		oSection1:Cell('DB_UNITIZ' ):SetValue(cCodUni)
		If WmsX312118("D0T","D0T_DESUNI",.T.)
			oSection1:Cell('D0T_DESUNI'):SetValue(cDesUni)
		EndIf
		
		// Impressão do código de barras	
		oReport:PrintText('')
		oReport:SkipLine(5)
	
		MSBAR3("CODE128",nRow,nCol,Trim(cMapa),@oReport:oPrint,Nil,Nil,Nil,Nil ,1 ,Nil,Nil,Nil,.F.,,,.F.)
		
		oSection1:PrintLine()
	
		oReport:PrintText(STR0007) // Nr.Separador     : _______________              Nr. Erros        : __________
		oReport:PrintText(STR0008) // Nr.Conferente    : _______________              Nr. Erros        : __________
		oReport:PrintText(STR0009) // Nr.Embalador     : _______________              Nr. Erros        : __________
		
		oSection2:Init()
		
		// Alteração do título e picture da célula
		If !Empty(aEndereco)
			oSection2:Cell('DB_LOCALIZ'):SetTitle(cDesEnd)
			oSection2:Cell('DB_LOCALIZ'):SetPicture(cPictEnd)
		EndIf
			
		// Guarda as informações para controlar a geração e impressão de uma CARGA por mapa de separação, se utilizar carga
		// Ou um PEDIDO por mapa de separação, se não utilizar carga
		lCarga := WmsCarga((cQryRel)->DB_CARGA)
		If lCarga
			cSeekQry := (cQryRel)->DB_FILIAL+(cQryRel)->DB_CARGA+(cQryRel)->DB_SEQCAR+(cQryRel)->DB_ENDDES+(cQryRel)->DB_UNITIZ
			bSeekQry := {|| cSeekQry == (cQryRel)->DB_FILIAL+(cQryRel)->DB_CARGA+(cQryRel)->DB_SEQCAR+(cQryRel)->DB_ENDDES+(cQryRel)->DB_UNITIZ}
		Else
			cSeekQry := (cQryRel)->DB_FILIAL+(cQryRel)->DB_DOC+(cQryRel)->DB_CLIFOR+(cQryRel)->DB_ENDDES+(cQryRel)->DB_UNITIZ
			bSeekQry := {|| cSeekQry == (cQryRel)->DB_FILIAL+(cQryRel)->DB_DOC+(cQryRel)->DB_CLIFOR+(cQryRel)->DB_ENDDES+(cQryRel)->DB_UNITIZ}
		EndIf
		
		aAtiv := {}
		While !(cQryRel)->(Eof()) .And. EVal(bSeekQry)
		
			SDB->(DbGoTo((cQryRel)->RECSDB))
			
			// Deve tratar o caso de uma mesma tarefa possuir mais de uma atividade
			// Ex: movimento horizontal - movimento vertical
			// Neste caso, deve imprimir a primeira atividade e pular a impressão das demais
			nSeek := AScan(aAtiv,{|x| x == (cQryRel)->DB_IDMOVTO})
			If nSeek <= 0
			   AAdd(aAtiv, (cQryRel)->DB_IDMOVTO)
			   oSection2:PrintLine()
			EndIf
			
			// Se gera e imprime, atualiza registro SDB
			If mv_par01 == 1
				RecLock('SDB')
				SDB->DB_MAPSEP := cMapa
				SDB->(MsUnlock())
			EndIf
			
			oReport:IncMeter()
			(cQryRel)->(DbSkip())
		EndDo
		
		oSection2:Finish()
		oSection1:Finish()
		oReport:EndPage()
	EndDo
	
	(cQryRel)->(DbCloseArea())
Return
