/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER180.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GPER180  ³ Autor ³ RH - Marcos Stiefano    ³ Data ³ 04/01/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao Nominal do INSS Retido                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER180                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ FNC           ³Motivo da Alteracao              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Mohanad Odeh³15/03/2013³M12RH01  RQ4507³Unificacao dos fontes - V12      ³±±  
±±³Raquel Hager³24/10/2013³M12RH01  RQ4507³Remocao de tratamentos para      ³±±      
±±³            ³          ³               ³quando nao for TopConnect.       ³±±
±±³Matheus M.  ³07/10/2016³			TVYL64³Ajuste na impressão para roteiro ³±± 
±±³            ³          ³               ³AUT.       						³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER180()
Local	oReport   
Local	aArea 		:= GetArea() 

Private	cString		:= "SRA"				// alias do arquivo principal 
Private cPerg		:= "GP180R"
Private aOrd    	:= {OemToAnsi(STR0004),OemToAnsi(STR0005)}	//"Matricula,Centro de Custo"
Private cTitulo		:= OemToAnsi(STR0010)			//" RELAÇÄO NOMINAL DO I.N.S.S. RETIDO "
Private cAliasQry	:= ""
Private oBreakCCusto
Private oBreakFil

	//Verifica as perguntas selecionadas
	Pergunte(cPerg,.F.) 
	oReport := ReportDef()
	oReport:PrintDialog()
	
	RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef  ³ Autor ³ Tania Bronzeri        ³ Data ³ 29/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao Nominal do INSS Retido.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER180                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport 
Local oSection1 
Local cDesc1	:= OemToAnsi(STR0001) + OemToAnsi(STR0002) + OemToAnsi(STR0003)	
//"Relacao Nominal I.N.S.S. Retido " ### "Ser  impresso de acordo com os parametros solicitados pelo"  ### "usu rio."

// Criacao dos componentes de impressao                                    
DEFINE REPORT oReport NAME "GPER180" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| GP180Imp(oReport)} DESCRIPTION OemtoAnsi(STR0017) TOTAL IN COLUMN	 
//"Relacao Nominal I.N.S.S. Retido" ### "Este programa emite Relacao dos Salarios de Contribuicao ate o Limite e Acima, e do INSS retido."

	DEFINE SECTION oSection1 OF oReport TITLE OemToAnsi(STR0022) TABLES "SRA","SRC" TOTAL IN COLUMN ORDERS aOrd	//"Lancamentos" 

		DEFINE CELL NAME "RA_FILIAL" OF oSection1 ALIAS cString
		DEFINE CELL NAME "RA_CC" 	 OF oSection1  BLOCK {|| cCC} ALIAS cString 
		DEFINE CELL NAME "RA_MAT" 	 OF oSection1 ALIAS cString
		DEFINE CELL NAME "RA_NOME" 	 OF oSection1 ALIAS cString
		DEFINE CELL NAME "NSCONTLIM" OF oSection1 TITLE OemToAnsi(STR0018) PICTURE "@E 99,999,999.99" 	//	"SAL.CONT.ATE LIM."
		DEFINE CELL NAME "NSCONTACI" OF oSection1 TITLE OemtoAnsi(STR0019) PICTURE "@E 99,999,999.99" 	//	"SAL.CONT.ACIMA LIM."
		DEFINE CELL NAME "NSCONTTOT" OF oSection1 TITLE OemToAnsi(STR0020) PICTURE "@E 99,999,999.99" ;	//	"SAL.CONT.TOTAL"
				BLOCK {||oSection1:Cell("NSCONTLIM"):GetValue()+oSection1:Cell("NSCONTACI"):GetValue()}
		DEFINE CELL NAME "NINSSRET"	 OF oSection1 TITLE OemToAnsi(STR0021) PICTURE "@E 99,999,999.99" 	//	"INSS RETIDO"

		DEFINE FUNCTION FROM oSection1:Cell("NSCONTLIM") FUNCTION SUM NO END SECTION 
		DEFINE FUNCTION FROM oSection1:Cell("NSCONTACI") FUNCTION SUM NO END SECTION
		DEFINE FUNCTION FROM oSection1:Cell("NSCONTTOT") FUNCTION SUM NO END SECTION
		DEFINE FUNCTION FROM oSection1:Cell("NINSSRET")  FUNCTION SUM NO END SECTION

Return(oReport)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GP180Imp   ³ Autor ³ Equipe RH             ³ Data ³ 14/12/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao Nominal do INSS Retido.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER180 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GP180Imp(oReport)
Local oSection  := oReport:Section(1)
Local cFiltro 	:= "" 
Local cSitQuery	:= ""
Local cCatQuery	:= ""  
Local nReg		:= 0
// Variaveis de Acesso do Usuario                               
Local cAcessaSRA	:= &( " { || " + ChkRH( "GPER180" , "SRA" , "2" ) + " } " )
Local aPerAberto    := {}
Local aPerFechado   := {}
Local aVerbasFunc   := {}
Local aVerbas       := {}
Local x				:= 0
Local nInss 	:= nSalAte   := nSalAci  := 0
Local cTitCC	:= "" 
Local cTitFil	:= ""
Local xQuebra
Local cOrdem 	:= ""
Local cModFunc	:= ""
// Carregar os Mnemonicos 	                                   
SetMnemonicos(Nil,Nil,.T.)

Private nOrdem	:= oSection:GetOrder()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        //  Filial                                   ³
//³ mv_par02        //  Centro de Custo                          ³
//³ mv_par03        //  Matricula                                ³
//³ mv_par04        //  Relat.= 1-Folha/2-13§Salario/3-Totalizado³
//³ mv_par05        //  Situacoes                                ³
//³ mv_par06        //  Categorias                               ³
//³ mv_par07        //  Imprime C.C em Outra Pagina              ³
//³ mv_par08        //  Mes/Ano Competencia                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nTipRel    := mv_par04
Private cSituacao  := mv_par05
Private cCategoria := mv_par06
Private lSalta     := If( mv_par07 == 1 .and. nOrdem == 2, .T. , .F. )
Private cMesArqRef := mv_par08
Private dDtRefe	   := ctod( "01/" + SubStr(mv_par08,1,2)+"/"+SubStr(mv_par08,3,4), "DDMMYY" )
Private cMes       := StrZero(Month(dDtRefe),2)
Private cAno       := StrZero(Year(dDtRefe),4)
Private cCC		   := ""

	cTitulo := oReport:Title() + " "
	cTitulo += If(mv_par04==1,OemToAnsi(STR0011),If(mv_par04==2,OemToAnsi(STR0012),OemToAnsi(STR0013)))	
				// "FOLHA"###"13o SALARIO"###"TOTALIZADO"
	
	// Altera o titulo do relatorio
	oReport:SetTitle(cTitulo)
	
	If nOrdem == 2 
		//-- Quebrar  e Totalizar por Centro de Custo
		DEFINE BREAK oBreakCCusto OF oSection WHEN {||(cAliasQry)->RA_FILIAL+cCC} TITLE OemToAnsi(STR0014)	PAGE BREAK //"TOTAL C.CUSTO -> "
		DEFINE FUNCTION FROM oSection:Cell("NSCONTLIM") FUNCTION SUM BREAK oBreakCCusto NO END REPORT NO END SECTION
		DEFINE FUNCTION FROM oSection:Cell("NSCONTACI") FUNCTION SUM BREAK oBreakCCusto NO END REPORT NO END SECTION
		DEFINE FUNCTION FROM oSection:Cell("NSCONTTOT") FUNCTION SUM BREAK oBreakCCusto NO END REPORT NO END SECTION
		DEFINE FUNCTION FROM oSection:Cell("NINSSRET")  FUNCTION SUM BREAK oBreakCCusto NO END REPORT NO END SECTION
	
		oBreakCCusto:OnBreak({|x,y|cTitCC:=OemToAnsi(STR0014)+x})	//"TOTAL C.CUSTO -> "
		oBreakCCusto:SetTotalText({||cTitCC})
		
		If !lSalta
			oBreakCCusto:OnPrintTotal({||xQuebra:=oBreakCCusto:GetLastValue(), oBreakCCusto:SetPageBreak(.F.)})
		Else
			oBreakCCusto:OnPrintTotal({||xQuebra:=oBreakCCusto:GetLastValue(),   ;
				If( xQuebra<>Nil.And.xQuebra<>(cAliasQry)->RA_FILIAL+cCC,	;
				oBreakCCusto:SetPageBreak(.F.),oBreakCCusto:SetPageBreak(.T.))})
	   	EndIf
	
	EndIf

	// Quebrar e Totalizar por Filial
	DEFINE BREAK oBreakFil OF oSection WHEN oSection:Cell("RA_FILIAL") TITLE OemToAnsi(STR0015)	// "TOTAL FILIAL -> "
	DEFINE FUNCTION FROM oSection:Cell("NSCONTLIM") FUNCTION SUM BREAK oBreakFil NO END REPORT NO END SECTION
	DEFINE FUNCTION FROM oSection:Cell("NSCONTACI") FUNCTION SUM BREAK oBreakFil NO END REPORT NO END SECTION
	DEFINE FUNCTION FROM oSection:Cell("NSCONTTOT") FUNCTION SUM BREAK oBreakFil NO END REPORT NO END SECTION
	DEFINE FUNCTION FROM oSection:Cell("NINSSRET")  FUNCTION SUM BREAK oBreakFil NO END REPORT NO END SECTION

	oBreakFil:OnBreak({|x,y|cTitFil:=OemToAnsi(STR0015)+x})	//"TOTAL FILIAL -> "
   oBreakFil:SetTotalText({||cTitFil})

	If lSalta
	    oBreakFil:OnPrintTotal({||oBreakCCusto:SetPageBreak(.T.),oBreakFil:SetPageBreak(.T.)})
	Else
		oBreakFil:SetPageBreak(.F.)
	EndIf

	cAliasQry := GetNextAlias()

	// Modifica variaveis para a Query
	For nReg:=1 to Len(cSituacao)
		cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cSituacao)
			cSitQuery += "," 
		EndIf
	Next nReg        
	cSitQuery := "%" + cSitQuery + "%"
	
	cCatQuery := ""
	For nReg:=1 to Len(cCategoria)
		cCatQuery += "'"+Subs(cCategoria,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cCategoria)
			cCatQuery += "," 
		EndIf
	Next nReg        
	cCatQuery := "%" + cCatQuery + "%"

	// Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr(cPerg)
		
	BEGIN REPORT QUERY oSection
	
	If nOrdem == 1
		cOrdem := "%SRA.RA_FILIAL,SRA.RA_MAT%"
	ElseIf nOrdem == 2
		cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_MAT%"
	EndIf

	BeginSql alias cAliasQry
		SELECT SRA.RA_FILIAL, SRA.RA_CC, SRA.RA_MAT, SRA.RA_NOME, SRA.RA_SITFOLH, SRA.RA_CATFUNC, SRA.RA_PROCES,SRA.RA_REGIME
		FROM %table:SRA% SRA
		WHERE SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	AND
			  SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	AND
	 	      SRA.%notDel%   
		ORDER BY %exp:cOrdem%
	EndSql
		
	//Prepara relatorio para executar a query gerada pelo Embedded SQL passando como 
	//parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados 
	//pela funcao MakeSqlExpr para serem adicionados a query
	END REPORT QUERY oSection PARAM mv_par01, mv_par02, mv_par03

	// Carregar os periodos abertos (aPerAberto) e/ou os periodos   
	// fechados (aPerFechado), de acordo com uma determinada competencia                									   
	fRetPerComp( cMes, cAno, Nil, Nil, Nil, @aPerAberto, @aPerFechado)

	// Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter( 100 )  
	
	// Incializa impressao   
	oSection:Init()                              

	While !(cAliasQry)->( EOF() ) 
	
		// Movimenta Regua de Processamento                             
		oReport:IncMeter( 1 )   
	
		// Verifica se o usuário cancelou a impressão do relatorio
		If oReport:Cancel()
			Exit
		EndIf               
	
		// Consiste Filiais e Acessos                                             
		If !( (cAliasQry)->RA_FILIAL $ fValidFil() ) .Or. !Eval( cAcessaSRA )
			(cAliasQry)->(DbSkip())
		   	Loop
		EndIf
	
		nInss := nSalAte := nSalAci := 0
	
		nInss 		:= nSalAte := nSalAci := 0
		cProcesso	:= (cAliasQry)->RA_PROCES
		aVerbas		:= {}
		cModFunc 	:= If((cAliasQry)->RA_REGIME == "2","GFP","GPE") 
		
		If nTipRel == 1
			cRoteiro 	:= If((cAliasQry)->RA_CATFUNC $ "A*P", fGetCalcRot("9"), fGetCalcRot("1",cModFunc)) //"FOL","FPB"
			
			aAdd( aVerbas, {fGetCodFol("0064")} ) // Pega INSS da Folha
			aAdd( aVerbas, {fGetCodFol("0065")} ) // Pega INSS de F‚rias
			aAdd( aVerbas, {fGetCodFol("0013")} ) // Pega Salario Contribui‡„o Ate o Limite Base ( Folha )
			aAdd( aVerbas, {fGetCodFol("0014")} ) // Pega Salario Contribui‡„o Acima do Limite Base ( Folha )
			aAdd( aVerbas, {fGetCodFol("0221")} ) // Base Inss Aut./Pro-Labore 15%
			aAdd( aVerbas, {fGetCodFol("0225")} ) // Base Inss Aut./Pro-Labore 20%
			aAdd( aVerbas, {fGetCodFol("0070")} ) // Pega Inss 13o.
			aAdd( aVerbas, {fGetCodFol("0019")} ) // Pega Salario Contribui‡„o Ate o Limite Base ( 13§ Salario )
			aAdd( aVerbas, {fGetCodFol("0020")} ) // Pega Salario Contribui‡„o Acima do Limite Base (13§ Salario)
			// Retorna as verbas do funcionario, de acordo com os periodos selecionados
			aVerbasFunc	:= RetornaVerbasFunc(	(cAliasQry)->RA_FILIAL		,; 	// Filial do funcionario corrente
												(cAliasQry)->RA_MAT	  		,; 	// Matricula do funcionario corrente
												NIL					,; 	// Centro de Custo da verba (opcional)
												cRoteiro	  		,; 	// Roteiro selecionado na pergunte
												aVerbas				,; 	// Array com as verbas que deverão ser listadas. Se NIL retorna todas as verbas.
												aPerAberto	  		,; 	// Array com os Periodos e Numero de pagamento abertos
												aPerFechado	 ) 			// Array com os Periodos e Numero de pagamento fechados
	        
	        If Len(aVerbasFunc) > 0
	        	cCc := aVerbasFunc[1,12]
	        EndIf
	        For x:= 1 To Len( aVerbasFunc ) Step 1
	       		nInss  += Iif((aVerbasFunc[x,3] == fGetCodFol("0070") .Or. aVerbasFunc[x,3] == fGetCodFol("0064")) .Or. (aVerbasFunc[x,3] == fGetCodFol("0065")), aVerbasFunc[x,7], 0 )
	        	nSalAte+= Iif((aVerbasFunc[x,3] == fGetCodFol("0019") .Or. aVerbasFunc[x,3] $ fGetCodFol("0013")+"/"+fGetCodFol("0221")), aVerbasFunc[x,7], 0 )
	        	nSalAci+= Iif((aVerbasFunc[x,3] == fGetCodFol("0020") .Or. aVerbasFunc[x,3] $ fGetCodFol("0014")+"/"+fGetCodFol("0225")), aVerbasFunc[x,7], 0 )
	        Next x
	    Else //nTipRel == 2 .Or. nTipRel == 3
	        //cRoteiro	:= fGetCalcRot("6") //"132"
	        aVerbas		:= {}
			aAdd( aVerbas, {fGetCodFol("0070")} ) // Pega Inss 13o.
			aAdd( aVerbas, {fGetCodFol("0019")} ) // Pega Salario Contribui‡„o Ate o Limite Base ( 13§ Salario )
			aAdd( aVerbas, {fGetCodFol("0020")} ) // Pega Salario Contribui‡„o Acima do Limite Base (13§ Salario)
			
			If nTipRel == 3
				aAdd( aVerbas, {fGetCodFol("0064")} ) // Pega INSS da Folha
				aAdd( aVerbas, {fGetCodFol("0065")} ) // Pega INSS de F‚rias
				aAdd( aVerbas, {fGetCodFol("0013")} ) // Pega Salario Contribui‡„o Ate o Limite Base ( Folha )
				aAdd( aVerbas, {fGetCodFol("0014")} ) // Pega Salario Contribui‡„o Acima do Limite Base ( Folha )
				aAdd( aVerbas, {fGetCodFol("0221")} ) // Base Inss Aut./Pro-Labore 15%
				aAdd( aVerbas, {fGetCodFol("0225")} ) // Base Inss Aut./Pro-Labore 20%
			EndIf
			
			// Retorna as verbas do funcionario, de acordo com os periodos selecionados
			aVerbasFunc	:= RetornaVerbasFunc(	(cAliasQry)->RA_FILIAL		,; 	// Filial do funcionario corrente
												(cAliasQry)->RA_MAT	  		,; 	// Matricula do funcionario corrente
												NIL					,; 	// Centro de Custo da verba (opcional)
												cRoteiro	  		,; 	// Roteiro selecionado na pergunte
												aVerbas				,; 	// Array com as verbas que deverão ser listadas. Se NIL retorna todas as verbas.
												aPerAberto	  		,; 	// Array com os Periodos e Numero de pagamento abertos
												aPerFechado	 ) 			// Array com os Periodos e Numero de pagamento fechados
	        If Len(aVerbasFunc) > 0
	        	cCc := aVerbasFunc[1,12]
	        EndIf
	        For x:= 1 To Len( aVerbasFunc ) Step 1
	        	nInss  += Iif((aVerbasFunc[x,3] == fGetCodFol("0070") .Or. aVerbasFunc[x,3] == fGetCodFol("0064") .Or. aVerbasFunc[x,3] == fGetCodFol("0065")), aVerbasFunc[x,7], 0 )
	       		nSalAte+= Iif((aVerbasFunc[x,3] == fGetCodFol("0019") .Or. aVerbasFunc[x,3] == fGetCodFol("0013") .Or. aVerbasFunc[x,3] == fGetCodFol("0221")), aVerbasFunc[x,7], 0 )    	
	        	nSalAci+= Iif((aVerbasFunc[x,3] == fGetCodFol("0020") .Or. aVerbasFunc[x,3] == fGetCodFol("0014") .Or. aVerbasFunc[x,3] == fGetCodFol("0225")), aVerbasFunc[x,7], 0 )
	        Next x
		 EndIf
	
		// Atualiza campos de valor
		oSection:Cell("NSCONTLIM"):SetValue(nSalAte)
		oSection:Cell("NSCONTACI"):SetValue(nSalAci)
		oSection:Cell("NSCONTTOT"):SetValue(nSalAte + nSalAci)
		oSection:Cell("NINSSRET"):SetValue(nInss)
	        
	
		// Imprime a linha                                        		 
		If nInss > 0 .Or. nSalAci > 0 .Or. nSalAte > 0
			oSection:PrintLine()
		EndIf
		(cAliasQry)->(DbSkip())
	
	EndDo

	// Termino do Relatorio                                       
	// Finaliza impressao inicializada pelo metodo Init             
	oSection:Finish()

	If Select(cAliasQry) > 0
		(cAliasQry)->(dbCloseArea())
	EndIf

	dbSelectArea( "SRA" )
	Set Filter to
	dbSetOrder(1)

Return
