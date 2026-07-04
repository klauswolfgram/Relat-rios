/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER190.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GPER190  ³ Autor ³ RH - Marcos Stiefano       ³ Data ³  04/01/96  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio Contrato Experiencia / Exame Medico                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER190                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ FNC           ³  Motivo da Alteracao                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Mohanad Odeh³14/03/13  ³M12RH01  RQ4507³ Unificacao dos fontes - V12          ³±± 
±±³Raquel Hager³25/10/13  ³M12RH01  RQ4507³ Remocao de tratamentos para quando   ³±±
±±³            ³          ³               ³ nao for TopConnect.					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER190()
Local	oReport   
Local	aArea 	:= GetArea()
Private cTitulo	:= OemToAnsi(STR0001)
Private aOrd    := {OemToAnsi(STR0004),OemToAnsi(STR0005),OemToAnsi(STR0006)}	//"Matr¡cula"###"Centro de Custo"###"Nome"
Private cPerg   := "GP190R"
Private	cString	:= "SRA"		

	// Verifica as perguntas selecionadas
	Pergunte(cPerg,.F.) 
	
	oReport := ReportDef()
	oReport:PrintDialog()
	
	RestArea(aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef  ³ Autor ³ Tania Bronzeri        ³ Data ³ 30/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio de Vencto. Contrato Experiencia e Exame Medico     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER190                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport 
Local oSection1 
Local cDesc1	:= OemToAnsi(STR0001) + OemToAnsi(STR0002) + OemToAnsi(STR0003)	
//"Relatorio Exame M‚dico / Contrato Experiˆncia" ### "Ser  impresso de acordo com os parametros solicitados pelo"  ### "usu rio."

	// Criacao dos componentes de impressao                                    
	DEFINE REPORT oReport NAME "GPER190" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| R190Imp(oReport)} DESCRIPTION OemtoAnsi(STR0023) TOTAL IN COLUMN	 
	//"Este programa emite Relatorio de Vencimento de Contratos de Experiencia e de Exames Medicos."
	
		DEFINE SECTION oSection1 OF oReport TITLE OemToAnsi(STR0021) TABLES "SRA" TOTAL IN COLUMN ORDERS aOrd
	
			DEFINE CELL NAME "RA_FILIAL" 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_CC" 	 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_MAT" 	 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_NOME" 	 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_ADMISSA"	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_VCTOEXP"	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_VCTEXP2"	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_EXAMEDI"	OF oSection1 ALIAS cString
	
			DEFINE FUNCTION FROM oSection1:Cell("RA_MAT")		FUNCTION COUNT NO END SECTION 
	                                                                                              
Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ GPER190  ºAutor  ³ Equipe RH          º Data ³  11/14/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao do relatorio.                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER190                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R190Imp(oReport)
Local oSection	:= oReport:Section(1)
Local cFiltro 	:= "" 
Local cAliasQry	:= ""
Local cSitQuery	:= ""
Local cCatQuery	:= ""  
Local cTitCC	:= "" 
Local cTitFil	:= ""
Local cAuxPrc	:= ""
Local nReg		:= 0
Local nTamCod	:= 0
Local X			:= 0 
Local xQuebra
Local cUserFil  := ""

// Variaveis de Acesso do Usuario                               
Private cAcessaSRA	:= &( " { || " + ChkRH( "GPER190" , "SRA" , "2" ) + " } " )
Private nOrdem	:= oSection:GetOrder()

// Carregando variaveis mv_par?? para Variaveis do Sistema.     
// mv_par01        //  Filial                                   
// mv_par02        //  Centro de Custo                          
// mv_par03        //  Matricula                                
// mv_par04        //  Nome                                     
// mv_par05        //  Imprime C.Custo em outra pagina          
// mv_par06        //  Data De                                  
// mv_par07        //  Data Ate                                 
// mv_par08        //  Tipo Relat. 1=Exame Med. 2=Contr.Exper.  
// mv_par09        //  Situacoes                                
// mv_par10        //  Categorias                               
// mv_par11        //  Processos para Impressao                 
Private dDataDe    := mv_par06
Private dDataAte   := mv_par07
Private nTipRel    := mv_par08
Private cSituacao  := mv_par09
Private cCategoria := mv_par10
Private lSalta     := If( mv_par05 == 1 , .T. , .F. )
Private cProcessos := If( Empty(mv_par11),"*", AllTrim(mv_par11) )	//	Processos para Impressao
Private cRProc	   := ""
Private aInfo      := {}
	
	If	nTipRel == 1
		cTitulo  := If(AllTrim(oReport:Title())==AllTrim(cTitulo),OemToAnsi(STR0010),oReport:Title())		//" RELACAO DE EXAME MEDICO "
	Else
		cTitulo  := If(AllTrim(oReport:Title())==AllTrim(cTitulo),OemToAnsi(STR0024),oReport:Title())		//"RELACAO VENCIMENTOS CONTRATO DE EXPERIENCIA"
	EndIf                             

	// Altera o titulo do relatorio
	oReport:SetTitle(if(AllTrim(oReport:Title()) == AllTrim(cTitulo), OemToAnsi(cTitulo), oReport:Title()))

	If lSalta  
		// Quebrar  e Totalizar por Centro de Custo
		DEFINE BREAK oBreakCCusto OF oSection WHEN oSection:Cell("RA_CC") TITLE OemToAnsi(STR0017)	PAGE BREAK	//"TOTAL C.CUSTO -> "
		DEFINE FUNCTION FROM oSection:Cell("RA_MAT")		FUNCTION COUNT BREAK oBreakCCusto NO END SECTION // NO END REPORT  
	
		oBreakCCusto:OnBreak({|x,y|cTitCC:=OemToAnsi(STR0017)+x})	//"TOTAL C.CUSTO -> "
	    oBreakCCusto:SetTotalText({||cTitCC})
	    oBreakCCusto:OnPrintTotal({||xQuebra:=oBreakFil:GetLastValue(),	;
	    	If(xQuebra<>Nil.And.xQuebra<>(cAliasQry)->RA_FILIAL,	;
	    		oBreakCCusto:SetPageBreak(.F.),oBreakCCusto:SetPageBreak(.T.))})
	EndIf

	// Quebrar e Totalizar por Filial
	DEFINE BREAK oBreakFil OF oSection WHEN oSection:Cell("RA_FILIAL") TITLE OemToAnsi(STR0018)			// "TOTAL FILIAL -> "
	DEFINE FUNCTION FROM oSection:Cell("RA_MAT")		FUNCTION COUNT BREAK oBreakFil NO END REPORT NO END SECTION
	oBreakFil:OnBreak({|x,y|cTitFil:=OemToAnsi(STR0018)+x,fInfo(@aInfo,y)})	//"TOTAL FILIAL -> "
	oBreakFil:SetTotalText({||cTitFil})
	
	If lSalta
	    oBreakFil:OnPrintTotal({||oBreakCCusto:SetPageBreak(.T.),oBreakFil:SetPageBreak(.T.)})
	Else
		oBreakFil:SetPageBreak(.F.)
	EndIf

	// Condicao de impressao do Funcionario
	oSection:SetLineCondition({|| U_fGP190Cond(cAliasQry) }) 

	// Neste Relatorio foi utilizado o alias fixo com o mesmo nome da tabela SRA e nao GetNextAlias, conforme o 
	// padrao de programacao, devido a utilizacao do Controle de Acesso de Usuarios utilizar o alias da Tabela SRA.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Observacao: Este teste foi executado para comprovacao da divergencia.			³
	//³																					³
	//³ Linha ORIGINAL do Contr. Acesso do usuario - Tab. SRW - Filtro de Relat.:		³
	//³ 		LEFT(SRA->RA_CC,2) = '20' .AND. SRA->RA_FILIAL = 'D MG 01 '				³
	//³ 	RESULTADO: Nao ha relacionamento devido ao conflito com o alias da query.	³
	//³																					³
	//³ Linha ALTERADA do Contr. Acesso do usuario - Tab. SRW - Filtro de Relat.:		³
	//³ 		LEFT(RA_CC,2) = '20' .AND. RA_FILIAL = 'D MG 01 '						³
	//³ 	RESULTADO: Ao retirar o Alias, o relacionamento eh efetivado devido a 		³
	//³ 			   existencia do CAMPO e nao ha conflito com o Alias da query. 		³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cAliasQry := GetNextAlias()

	// Modifica variaveis para a Query 
	cSitQuery := ""
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
	ElseIf nOrdem == 3
		cOrdem := "%SRA.RA_FILIAL,SRA.RA_NOME%"
	EndIf

	//consiste filtro de usuário (layout personalizado)
	If !Empty(oSection:GetSqlExp("SRA"))
		cUserFil := "%SRA." + oSection:GetSqlExp("SRA") + "AND %"
	Else
		cUserFil := "%%"
	EndIf

	// NAO RETIRAR ESTA LINHA!
	// Este relatorio abre a query abaixo com o Alias "SRA" e como a tabela "SRA" eh utilizada
	// em varios outros programas, neste caso, o Controle de Acesso de Usuarios, e preciso
	// fechar primeiro a area para depois poder utiliza-la.
	SRA->( dbCloseArea() )

	BeginSql alias cAliasQry
		SELECT	SRA.RA_FILIAL,  SRA.RA_CC,      SRA.RA_MAT,     SRA.RA_NOME,   SRA.RA_SITFOLH, SRA.RA_CATFUNC, 
				SRA.RA_ADMISSA, SRA.RA_VCTOEXP, SRA.RA_VCTEXP2, SRA.RA_EXAMEDI, SRA.RA_PROCES
		FROM %table:SRA% SRA
		WHERE SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	AND
			  SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	AND
			  %exp:cUserFil%
	 	      SRA.%notDel%
		ORDER BY %exp:cOrdem%
	EndSql
	

	// Prepara relatorio para executar a query gerada pelo Embedded SQL passando como 
	// parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados 
	// pela funcao MakeSqlExpr para serem adicionados a query
	END REPORT QUERY oSection PARAM mv_par01, mv_par02, mv_par03, mv_par04

	// Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter( 100 )  
	
	If nTipRel == 1
		oSection:Cell("RA_VCTOEXP"):Disable()
		oSection:Cell("RA_VCTEXP2"):Disable()
	Else                     
		oSection:Cell("RA_EXAMEDI"):Disable()
	EndIf

	// Monta a string de Processos para Impressao                   
	If AllTrim(cProcessos) <> "*"
		cRProc := ""
		nTamCod := GetSx3Cache( "RCJ_CODIGO" , "X3_TAMANHO" )
		For X := 1 to Len(cProcessos) step 5
			If Len(Subs(cProcessos,X,5)) < nTamCod
				cAuxPrc := Subs(cProcessos,X,5) + Space(nTamCod - Len(Subs(cProcessos,X,5)))
			Else
				cAuxPrc := Subs(cProcessos,X,5)
			EndIf
			cRProc += cAuxPrc
			cRProc += "#"
		Next X
	Else
		cRProc := cProcessos
	EndIf
	
	oSection:Print()
	
	// Termino do Relatorio                                         
	// Fecha area da query utilizada como SRA para abrir a
	// Tabela SRA corretamente em alguma das proximas rotinas.
	(cAliasQry)->( DbCloseArea() )


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fGP190Cond    ³ Autor ³ Tania Bronzeri   ³ Data ³ 10/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Verifica Condicao para Impressao da Linha do Relatorio     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER190                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fGP190Cond(cAliasQry)
Local lRet	:= .T.            
Default cAliasQry	:= "SRA"                 

	// Consiste Filiais e Acessos                                             
	If !( (cAliasQry)->RA_FILIAL $ fValidFil() ) .Or. !Eval( cAcessaSRA )
		lRet	:= .F.			 	
	EndIf

	// Consiste Processos para Impressao                                      
	If !( (cAliasQry)->RA_PROCES $ cRProc ) .And. Substr(cRProc,1,1) <> "*" 
		lRet	:= .F.			 	
	EndIf

	// Verifica Data De / Ate da Data Exame - Data Vencimento       
	If  nTipRel == 1
		If  DtoS((cAliasQry)->RA_EXAMEDI) < DtoS(dDataDe) .Or. DtoS((cAliasQry)->RA_EXAMEDI) > DtoS(dDataAte)
			lRet	:= .F.
		EndIf    
	ElseIf nTipRel == 2
		If  (DtoS((cAliasQry)->RA_VCTOEXP) < DtoS(dDataDe) .Or. DtoS((cAliasQry)->RA_VCTOEXP) > DtoS(dDataAte)) 
		   	If (DtoS((cAliasQry)->RA_VCTEXP2) < DtoS(dDataDe) .Or. DtoS((cAliasQry)->RA_VCTEXP2) > DtoS(dDataAte))
				lRet	:= .F.
			EndIf
		 EndIf    
	EndIf

Return lRet

Static Function Scheddef()  
	Local aParam
	Local aOrd  := {OemToAnsi(STR0004),OemToAnsi(STR0005),OemToAnsi(STR0006)}	//"Matr¡cula"###"Centro de Custo"###"Nome"
	aParam := { "R",;      // Tipo R para relatorio P para processo   
				"GP190R",;	// Pergunte do relatorio, caso nao use passar ParamDef            
				"SRA",;  	// Alias            
   				aOrd,;   	// Array de ordens   
				OemToAnsi(STR0001) + OemToAnsi(STR0002) + OemToAnsi(STR0003)}	//" RELACAO DE ANIVERSARIANTES DO MES "  
				  
Return aParam  