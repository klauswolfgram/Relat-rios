/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "LOJR140.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ LOJR140	³ Autor ³ Gustavo Henrique      ³ Data ³ 08/11/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Emissao de NF de Entrada para credito de acrescimo         ³±±
±±³          | financeiro												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_LOJR140()												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGALOJA 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Lojr140()

Local cFornecedor
Local cLoja
Local cProduto
Local dDataAtual
Local dDataIni
Local dDataFim
Local aArea 	  := GetArea()
Local aItemNF     := {}          
Local aPdv		  := {}
Local aTotItens   := {}
Local aCab		  := {}
Local aItens	  := {}
Local nPos		  := 0
Local nVlrAcrsTot := 0			// Valor de acrescimo financeiro total no dia
Local nGeradas	  := 0			// Contador para indicar quantas NF's de Entrada foram geradas
Local lOk		  := .F.
Local lLJR140NF   := ExistBlock("LJR140NF")                       
Local cItem		  := ""
Local cNumNota    := Space(TamSx3("L1_DOC")[1])
Local cSerie      := ""

Private lScreen  	:= .T.		// Utilizada na funcao LjNota()
Private lMsErroAuto := .F.		// Utilizada na funcao MsExecAuto()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao utilizada para verificar a ultima versao dos fontes      ³
//³ SIGACUS.PRW, SIGACUSA.PRX e SIGACUSB.PRX, aplicados no rpo do   |
//| cliente, assim verificando a necessidade de uma atualizacao     |
//| nestes fontes. NAO REMOVER !!!							        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF !(FindFunction("SIGACUS_V") .and. SIGACUS_V() >= 20050512)
    Final("Atualizar SIGACUS.PRW !!!")
Endif
IF !(FindFunction("SIGACUSA_V") .and. SIGACUSA_V() >= 20050512)
    Final("Atualizar SIGACUSA.PRX !!!")
Endif
IF !(FindFunction("SIGACUSB_V") .and. SIGACUSB_V() >= 20050512)
    Final("Atualizar SIGACUSB.PRX !!!")
Endif

While ! lOk

	// mv_par01 - Data de emissao inicial
	// mv_par02 - Data de emissao final
	// mv_par03 - Fornecedor
	// mv_par04 - Loja
	// mv_par05 - Serie da NF de Entrada a ser gerada
	// mv_par06 - Produto referente ao item da NF de Entrada a ser gerada
	If ! Pergunte( "LJR140", .T. ) 
		Exit
	EndIf	

	// Atribui valores do pergunte para variaveis evitando perda dos dados das variaveis MV_?????
	dDataIni 	:= mv_par01
	dDataFim 	:= mv_par02
	cFornecedor	:= mv_par03
	cLoja		:= mv_par04
	cSerie		:= mv_par05
	cProduto	:= mv_par06
                     
	// Executa a validacao dos parametros
	lOk	:= Lj140Ok( mv_par01, mv_par02, mv_par03, mv_par04, mv_par06, @cSerie, @cNumNota )

	If !lOk 
		lMsErroAuto := !IsBlind() // Verifica se a rotina sera executada via execauto ou nao
    	Loop
    EndIf
	 	    
	dbSelectArea( "SF2" )
	SF2->( dbSetOrder( 1 ) )

	cInd	:= Criatrab(Nil,.F.)
    cKey	:= SF2->( IndexKey() )
	cFiltro := "DtoS( F2_EMISSAO ) >= '" + DtoS( dDataIni ) + "' .And. DtoS( F2_EMISSAO ) <= '" + DtoS( dDataFim ) + "' "
	cFiltro += ".And. F2_VALACRS > 0 "
	cFiltro += ".And. Empty( F2_NFEACRS )"
	
	IndRegua( "SF2", cInd, cKey,, cFiltro, OemtoAnsi( STR0022 ) )		// Selecionando registros ...

	// Processa todas as vendas no periodo para acumular o acrescimo financeiro a creditar
	SF2->( dbSetOrder( 1 ) )
	SF2->( dbGoTop() )
	
	If SF2->( EoF() )            
		// N„o h  vendas com acr‚scimo financeiro no per¡odo informado.
	    MsgInfo( OemToAnsi( STR0020 ) )
	    lOk := .F.
	    Loop
	EndIf   			
	
	While SF2->( ! EoF() )
                                                         
		dDataAtual := SF2->F2_EMISSAO
		                 
		// Inicia transacao da NF de Entrada do dia.
		
		While SF2->( ! EoF() .and. F2_EMISSAO == dDataAtual )
		        
			lGeraNFE    := .F.				// Indica se gera NFE
			nVlrAcrsTot	+= SF2->F2_VALACRS	// Acumula acrescimo financeiro das vendas do dia
	    	    
			// Apura o valor de acrescimo a creditar de todos os itens da venda
			SD2->( dbSetOrder( 3 ) )
			SD2->( dbSeek( xFilial( "SD2" ) + SF2->( F2_DOC + F2_SERIE + F2_CLIENTE + F2_LOJA ) ) )
	
			While SD2->( ! EoF() .and. D2_DOC == SF2->F2_DOC .and. D2_SERIE == SF2->F2_SERIE .and.;
				D2_CLIENTE == SF2->F2_CLIENTE .and. D2_LOJA == SF2->F2_LOJA )
	               
				If SD2->D2_VAC # 0
				                    
					// Se existe pelo menos um item com valor de credito de acrescimo entao 
					// gera a NFE.
					lGeraNFE := .T.
	        	
					nPos := SD2->( aScan( aItemNF, { |x| 	x[1] == D2_PDV 	.and.;
															x[2] == D2_PICM } ) )
	    	                                                                                
					// Acumula valor de acrescimo financeiro a creditar
					If nPos # 0
						aItemNF[ nPos, 3 ] += SD2->D2_VAC
						aItemNF[ nPos, 4 ] += SD2->( D2_VAC * D2_PICM / 100 )
					Else
						SD2->( AAdd( aItemNF, {	D2_PDV 		,;
												 	D2_PICM		,;
												 	SD2->D2_VAC	,;
												 	SD2->( D2_VAC * D2_PICM / 100 ) } ) )
					EndIf
	
				EndIf						
					
				SD2->( dbSkip() )
	
			EndDo 
                            
			If lGeraNFE

		   		// Acumula cupom fiscal inicial e final por PDV que sera enviado na emissao 
				// da Nota Fiscal de Entrada.
				nPos := aScan( aPdv, { |x| x[ 1 ] == SF2->F2_PDV } )
		    		
		   		If nPos == 0
				    SF2->( AAdd( aPdv, { F2_PDV, F2_DOC, F2_DOC } ) )
				Else     
		   			// Verifica se deve atualizar o numero do cupom fiscal inicial
				    If aPdv[ nPos, 2 ] > SF2->F2_DOC
		    	    	aPdv[ nPos, 2 ] := SF2->F2_DOC
		    	    EndIf
		    		// Verifica se deve atualizar o numero do cupom fiscal final
		    	    If aPdv[ nPos, 3 ] 	< SF2->F2_DOC
		    	    	aPdv[ nPos, 3 ] := SF2->F2_DOC
		    		EndIf
		  		EndIf   
		
		    	// Grava o numero da nota de credito de acrescimo financeiro que sera gerada
				RecLock( "SF2", .F. )
				SF2->F2_NFEACRS := cNumNota
				SF2->( MsUnLock() )                                   

			EndIf
			
			SF2->( dbSkip() )
	    
	    EndDo

		If Len( aItemNF ) > 0

			cItem		:= "01"
			aTotItens	:= {}           				
		
			// Campos e seus conteudos a serem gravados na tabela SF1
			aCab := {	{"F1_TIPO"   ,"N"        ,NIL},;
						{"F1_FORMUL" ,"S"        ,NIL},;
						{"F1_EMISSAO",dDataBase  ,NIL},;
						{"F1_FORNECE",cFornecedor,NIL},;
						{"F1_LOJA"   ,cLoja      ,NIL},;
						{"F1_SERIE"  ,cSerie     ,NIL},;
						{"F1_DOC"    ,cNumNota   ,NIL},;
						{"F1_ESPECIE","NFE"      ,NIL},;
						{"F1_COND"   ,""         ,NIL} }
					                                     
			For nPos := 1 to Len( aItemNF )
				    	                               
				SB1->( dbSetOrder( 1 ) )
				SB1->( dbSeek( xFilial( "SB1" ) + cProduto ) )
					
				SF4->( dbSetOrder( 1 ) )
				SF4->( dbSeek( xFilial( "SF4" ) + RetFldProd(SB1->B1_COD,"B1_TE") ) )
					    	                            
				// Campos e conteudos a serem gravados na tabela SD1								    	                                 
				aItens := {	{"D1_COD"    ,cProduto				,NIL},;
							{"D1_ITEM"   ,cItem					,NIL},;
							{"D1_UM"     ,SB1->B1_UM			,NIL},;
							{"D1_QUANT"  ,1						,NIL},;
							{"D1_VUNIT"  ,aItemNF[ nPos, 3 ]	,NIL},;
							{"D1_TOTAL"  ,aItemNF[ nPos, 3 ]	,NIL},;
							{"D1_PICM"   ,aItemNF[ nPos, 2 ]	,NIL},;
							{"D1_VALICM" ,aItemNF[ nPos, 4 ]	,NIL},;
							{"D1_TES"    ,SF4->F4_CODIGO       ,NIL},;
							{"D1_CF"     ,SF4->F4_CF			,NIL},;
							{"D1_RATEIO" ,"2"					,NIL},;
							{"D1_FORNECE",cFornecedor			,NIL},;
							{"D1_LOJA"   ,cLoja					,NIL},;
							{"D1_EMISSAO",dDataBase				,NIL},;
							{"D1_DTDIGIT",dDataBase				,NIL},;  
							{"D1_TIPO"   ,"N"					,NIL},;
							{"D1_TP"     ,SB1->B1_TIPO			,NIL},;
							{"D1_LOCAL"  ,RetFldProd(SB1->B1_COD,"B1_LOCPAD") ,NIL} }
		
				AAdd( aTotItens, aItens )								
				cItem := SomaIt(cItem)  
				
			Next nPos
		                                
			// Aguarde...Gerando nota fiscal de entrada.
			LjMsgRun( OemtoAnsi( STR0008 ) + cNumNota, , {|| MSExecAuto( {|x,y,z,w|;
				MATA103( x, y, z, w ) }, aCab, aTotItens, 3, .F. )})
		
			If lMsErroAuto
				MostraErro()
				lOk := .F.
				Exit					
			Else					
				If lLJR140NF
					ExecBlock( "LJR140NF", .F., .F., { nVlrAcrsTot, aPdv } )
				EndIf 
				aItemNF		:= {}		// Inicializa vetor de totais dos itens.
				aPdv   		:= {}		// Inicializa vetor de numero de cupom fiscal inicial e final por PDV 
				nVlrAcrsTot	:= 0		// Inicializa valor de acrescimo acumulado no dia
				nGeradas	++
			EndIf

		EndIf

	EndDo

	If nGeradas == 0               
		// N„o h  itens de venda com valor de cr‚dito de acr‚scimo financeiro no per¡odo informado.
	    MsgInfo( OemToAnsi( STR0021 ) )
    EndIf
	
EndDo

RestArea( aArea )

RetIndex( "SF2" )

Return( NIL )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ Lj140Ok	³ Autor ³ Gustavo Henrique      ³ Data ³ 08/11/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Validacao da data na janela.								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Lj140ok()												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parƒmetros³ [ <ExpD1> ] - Data inicial								  ³±±
±±³          ³ [ <ExpD2> ] - Data final									  ³±±
±±³          ³ [ <ExpC1> ] - Fornecedor									  ³±±
±±³          ³ [ <ExpC2> ] - Loja										  ³±±
±±³          ³ [ <ExpC3> ] - Produto									  ³±±
±±³          ³ [ <ExpC4> ] - Condicao de pagamento						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ LOJR140													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Lj140Ok( dDataIni, dDataFim, cFornecedor, cLoja, cProduto,;
cSerie, cNumNota )
Local lRet := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao utilizada para verificar a ultima versao dos fontes      ³
//³ SIGACUS.PRW, SIGACUSA.PRX e SIGACUSB.PRX, aplicados no rpo do   |
//| cliente, assim verificando a necessidade de uma atualizacao     |
//| nestes fontes. NAO REMOVER !!!							        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF !(FindFunction("SIGACUS_V") .and. SIGACUS_V() >= 20050512)
    Final("Atualizar SIGACUS.PRW !!!")
Endif
IF !(FindFunction("SIGACUSA_V") .and. SIGACUSA_V() >= 20050512)
    Final("Atualizar SIGACUSA.PRX !!!")
Endif
IF !(FindFunction("SIGACUSB_V") .and. SIGACUSB_V() >= 20050512)
    Final("Atualizar SIGACUSB.PRX !!!")
Endif

Do Case
	Case Empty( dDataIni )
		Help(" ","1","DATINIVAZ")
		lRet := .F.
	Case Empty( dDataFim )
		Help(" ","1","DATFIMVAZ")
		lRet := .F.
	Case dDataIni > dDataFim
		Help(" ","1","DATAMAIOR")
		lRet := .F.
	Case dDataFim < dDataIni
		Help(" ","1","DATAMENOR")
		lRet := .F.
	Case Empty( cFornecedor )  
		// Fornecedor n„o pode ser deixado em branco.
		MsgInfo( OemToAnsi( STR0009 ) )
		lRet := .F.	
	Case Empty( cLoja )
		// Loja n„o pode ser deixada em branco.
		MsgInfo( OemToAnsi( STR0011 ) )
		lRet := .F.	
	Case Empty( cProduto )
		// Produto n„o pode ser deixado em branco.
		MsgInfo( OemToAnsi( STR0010 ) )
		lRet := .F.	  
EndCase

If lRet .and. ! Empty( cFornecedor ) .and. ! Empty( cLoja )	
	SA2->( dbSetOrder( 1 ) )
	lRet := SA2->( dbSeek( xFilial( "SA2" ) + cFornecedor + cLoja ) )
	If ! lRet  
		// Fornecedor e loja n„o encontrados.
		MsgInfo( OemToAnsi( STR0012 ) )			
	EndIf
EndIf

If lRet .and. ! Empty( cProduto )
	SB1->( dbSetOrder( 1 ) )
	lRet := SB1->( dbSeek( xFilial( "SB1" ) + cProduto ) )
	If ! lRet  
		// Produto n„o encontrado.	
		MsgInfo( OemToAnsi( STR0014 ) )
	Else        
		SF4->( dbSetOrder( 1 ) )
		lRet := SF4->( dbSeek( xFilial( "SF4" ) + RetFldProd(SB1->B1_COD,"B1_TE") ) )
		If lRet
			lRet := (SF4->F4_DUPLIC # "S")
			If ! lRet
				// Produto com TES que Gera Duplicata n„o pode ser utilizado.
				MsgInfo( OemToAnsi( STR0016 ) )
			EndIf
		Else
			// Tipo de Entrada n„o definido para o produto: 
			MsgInfo( OemToAnsi( STR0019 ) + cProduto )
		EndIf
	EndIf
EndIf

If lRet
	// Valida serie informada e busca numero de NF
	lRet := LjNota( @cSerie, @cNumNota )
EndIf

Return( lRet )
