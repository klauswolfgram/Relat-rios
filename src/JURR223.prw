/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PARMTYPE.CH"
#INCLUDE "JURR223.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} JURR223
Relatório com todos os processos que estão cadastrados para receber andamentos de forma automática

@author Rafael Tenorio da Costa
@since 02/08/2016
@version 1.0
/*/
//-------------------------------------------------------------------
User Function JURR223()

	Local oReport := ReportDef()
	
	oReport:PrintDialog()

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Definição do relatorio

@author Rafael Tenorio da Costa
@since 02/08/2016
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

	Local oReport	:= Nil
	Local oSecCli	:= Nil
	Local oSecPro	:= Nil
	Local cTabela	:= GetNextAlias()
	Local nEspaco	:= 5
	Local nMargem	:= 3
	
	oReport := TReport():New("JURR223", STR0001, /*cPergunta*/	,;	//"Uso Andamentos Automáticos"
							{|oReport| ReportPrint(@oReport, cTabela, @oSecCli, @oSecPro)},;
							STR0002)	//"Este programa emitira um relatório com todos os processos que estão cadastrados para receber andamentos de forma automática."
  
  //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------							
			 //TRSection():New(oParent, cTitle	, uTable		, aOrder, lLoadCells , lLoadOrder, uTotalText, lTotalInLine	, lHeaderPage, lHeaderBreak , lPageBreak, lLineBreak, nLeftMargin,lLineStyle,nColSpace,lAutoSize,cCharSeparator,nLinesBefore,nCols,nClrBack,nClrFore,nPercentage)
  //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	oSecCli := TRSection():New(oReport, STR0003	, {"NSZ","SA1"}	,		,			 , .T.		 , 		 	 , 				, 			 , 				, 			, 			, nMargem)	//"Dados do Cliente"
	
  //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //TRCell():New(/*oSection*/,/*Campo*/		,/*Alias*/	,/*Titulo*/	,/*Picture*/					,/*Tamanho*/						,/*lPixel*/	,/*{|| code-block de impressao }*/, cAlign, lLineBreak, cHeaderAlign, lCellBreak, nColSpace, lAutoSize)
  //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	TRCell():New(oSecCli	,"NSZ_CCLIEN"	,"NSZ"		,			,								, TamSX3("NSZ_CCLIEN")[1] + nEspaco	, .F.		,{|| (cTabela)->NSZ_CCLIEN	})
	TRCell():New(oSecCli	,"NSZ_LCLIEN"	,"NSZ"		,			,								, TamSX3("NSZ_LCLIEN")[1] + nEspaco	, .F.		,{|| (cTabela)->NSZ_LCLIEN	})
	TRCell():New(oSecCli	,"A1_NOME"	 	,"SA1"		,			,								, TamSX3("A1_NOME")[1] 	  + nEspaco	, .F.		,{|| (cTabela)->A1_NOME		}	  ,		  ,			  ,				, 			, 		   , .T.)
	nMargem += 3
	
	oSecPro := TRSection():New(oSecCli, STR0004, {"NUQ"},,, .T.,,,,,,, nMargem)	//"Dados do Processo"
	
	TRCell():New(oSecPro	,"NUQ_NUMPRO"	,"NUQ"		,			,								, TamSX3("NUQ_NUMPRO")[1] + nEspaco	, .F.		,{|| Transform((cTabela)->NUQ_NUMPRO, "@R XXXXXXX-XX.XXXX.X.XX.XXXX")}	)
	TRCell():New(oSecPro	,"NUQ_INSATU"	,"NUQ"		, STR0005	,								, TamSX3("NUQ_INSATU")[1] + nEspaco	, .F.		,{|| IIF((cTabela)->NUQ_INSATU == "1", STR0006, STR0007)}					)	//"Instancia Atual"		//"Sim"		//"Não"
	
Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Impressão do relatorio

@author Rafael Tenorio da Costa
@since 08/05/2015
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ReportPrint(oReport, cTabela, oSecCli, oSecPro)

	Local aArea		:= GetArea()
	Local cCondicao	:= ""
	Local cChave	:= ""
	Local nCliente	:= 0
	Local nTotal	:= 0
	Local nPagina	:= 0	
	Local oFontCab 	:= TFont():New( "Arial"/*cName*/, /*uPar2*/, 8.5/*nHeight*/, /*uPar4*/, .T./*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F./*lUnderline*/, .F./*lItalic*/)
	Local oFontItens:= TFont():New( "Arial"/*cName*/, /*uPar2*/, 08/*nHeight*/ , /*uPar4*/, .F./*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F./*lUnderline*/, .F./*lItalic*/)
  
	BeginSql Alias cTabela
		SELECT NSZ_CCLIEN, NSZ_LCLIEN, A1_NOME, NUQ_CAJURI, NUQ_NUMPRO, NUQ_INSATU 
		FROM %table:NSZ% NSZ 
		INNER JOIN %table:NUQ% NUQ ON
			NSZ_FILIAL = NUQ_FILIAL AND 
			NSZ_COD = NUQ_CAJURI AND 
			NSZ.D_E_L_E_T_ = NUQ.D_E_L_E_T_
		LEFT JOIN %table:SA1% SA1 ON
			A1_FILIAL = %xFilial:SA1% AND 
			NSZ_CCLIEN = A1_COD AND 
			NSZ_LCLIEN = A1_LOJA AND 
			NSZ.D_E_L_E_T_ = SA1.D_E_L_E_T_
		WHERE NSZ_FILIAL = %xFilial:NSZ% 
		AND NUQ_ANDAUT = %Exp:'1'%
		AND NSZ.%NotDel%	
		ORDER BY NSZ_CCLIEN, NSZ_LCLIEN, A1_NOME, NUQ_CAJURI, NUQ_NUMPRO
	EndSQL
	
	If !(cTabela)->( Eof() )
	
		//Imprime seção de cliente no inicio das paginas
		oReport:OnPageBreak( {||oSecCli:Init(), oSecCli:PrintLine(), oReport:SkipLine()} )
  
		//Altera as fontes
		oReport:oFontHeader := oFontCab  
		oReport:oFontBody 	:= oFontItens
	
		While !oReport:Cancel() .And. !(cTabela)->( Eof() )
	
			nCliente  := 0
			cChave	  := (cTabela)->( NSZ_CCLIEN + NSZ_LCLIEN )
			cCondicao := (cTabela)->( NSZ_CCLIEN + NSZ_LCLIEN )
			nPagina++

			//Na primeira pagina não utiliza, habilita porque o OnPageBreak ja faz isso			
			If nPagina > 1
				oSecCli:Init()
				oSecCli:PrintLine()
			EndIf
			
			//Inicializa seção de processo
			oSecPro:Init()
			
			oReport:SetMeter( (cTabela)->( LastRec() ) )
			While !oReport:Cancel() .And. !(cTabela)->( Eof() ) .And. cChave == cCondicao
			
				//Incrementar a barra de progresso
				oReport:IncMeter()		
			
				cCondicao := (cTabela)->( NSZ_CCLIEN + NSZ_LCLIEN )
			
				oSecPro:PrintLine()
			
				nCliente++
				(cTabela)->( DbSkip() )
			EndDo
			
			nTotal += nCliente
			
			//Finaliza seções
			oSecPro:Finish()
			oSecCli:Finish()
			
			//Imprime total de cliente
			oReport:SkipLine()
			oReport:PrintText(STR0008 + cValToChar( nCliente ) )	//"T O T A L   C L I E N T E   ---->   "
			oReport:SkipLine()
		EndDo
		
		//Imprime total
		oReport:PrintText(STR0009 + cValToChar( nTotal ) )		//"T O T A L   ---->   "
	EndIf
	
	(cTabela)->( DbCloseArea() )
	RestArea( aArea )
	
Return Nil