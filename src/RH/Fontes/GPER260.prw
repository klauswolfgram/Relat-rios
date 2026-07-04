/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER260.CH"
#INCLUDE "report.ch"

/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao      ³ GPER260  ³ Autor ³ RH - Marcos Stiefano    ³ Data ³ 04/01/96       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao   ³ Relacao de Aniversariantes do Mes                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso         ³ Generico                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ FNC          ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Raquel Hager|12/04/2013³M12RH01 RQ3005³Unificacao das Folhas de Pagamento.       ³±± 
±±³Raquel Hager|22/10/2013³M12RH01 RQ3005³Remocao de tratamento sem ser TOP.        ³±±
±±³Esther V.   |13/11/2013³M_RH003       ³Ajuste para que quando houver schedule,   ³±±
±±³        	   ³          ³              ³o sistema não gere error.log              ³±± 
±±³Raquel Hager|10/07/2014³TPZUHT        ³Remocao de tratamento de paramento	    ³±±
±±³        	   ³          ³              ³MV_TREPORT.					            ³±± 
±³Flavio C.    |18/10/2016³TWHCK8        ³Descrição centro de custo         	    ³±±
±³Paulo O      ³02/03/2017³MRH-7789      ³Corrigida a ordenação por data de         ³±±
±³Inzonha      |                         ³ nascimento                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER260()       
Local	oReport   
Local	aArea 	:= GetArea()
Private	cString	:= "SRA"				// Alias do arquivo principal (Base)
Private cPerg	:= "GP260R"
Private aOrd    := {OemToAnsi(STR0004),OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008)}	
					//"Matricula"###"Centro de Custo"###"Nome"###"Chapa"###"Data Nascimento"
Private cTitulo	:= OemToAnsi(STR0011)	//" RELACAO DE ANIVERSARIANTES DO MES "
		
	// Verifica as perguntas selecionadas      
	Pergunte(cPerg,.F.) 	
    oReport := ReportDef()
    oReport:PrintDialog()     

RestArea( aArea )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef  ³ Autor ³ Tania Bronzeri        ³ Data ³12/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao de Aniversariantes do Mes                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER260 - Release 4                               			³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef() 
Local oReport 
Local oSection1 
Local cDesc1	:= OemToAnsi(STR0001) + OemToAnsi(STR0002) + OemToAnsi(STR0003)	
//"Relacao de Aniversariantes do Mes" ### "Ser  impresso de acordo com os parametros solicitados pelo" ### "usu rio."
	
	// Criacao dos componentes de impressao                                    
	DEFINE REPORT oReport NAME "GPER260" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| R260Imp(oReport)} DESCRIPTION OemtoAnsi(STR0024) TOTAL IN COLUMN	 
	//"Este programa emite Relacao de Aniversariantes do Mes."
	
		DEFINE SECTION oSection1 OF oReport TITLE OemToAnsi(STR0026)TABLES "SRA" TOTAL IN COLUMN ORDERS aOrd  //Funcionarios
	
			DEFINE CELL NAME "RA_FILIAL" 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_CC" 	 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "CTT_DESC01" 	OF oSection1 ALIAS "CTT"    TITLE OemToAnsi(STR0029)//"Descrição"
			DEFINE CELL NAME "RA_CHAPA"	 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_MAT" 	 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_NOME" 	 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_NASC"		OF oSection1 ALIAS cString
			DEFINE CELL NAME "DNASCIM"		OF oSection1 TITLE OemToAnsi(STR0025) PICTURE "99/99" ;	//	"Aniversario"
					BLOCK {||PadR(SubStr(oSection1:Cell("RA_NASC"):GetText(),1,5),14)}
			DEFINE CELL NAME "RA_ESTCIVI"	OF oSection1 ALIAS cString SIZE 15	;	//	"Estado Civil   "
					BLOCK{||Tabela("33",RA_ESTCIVI)}
			DEFINE CELL NAME "RA_SALARIO"	OF oSection1 ALIAS cString
	
	Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R260Imp    ³ Autor ³ Equipe RH             ³ Data ³--/--/----³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao de Aniversariantes do Mes                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER260 - Release 4                               			³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R260Imp(oReport)
Local oSection  := oReport:Section(1)
Local cFiltro 	:= "" 
Local cAliasQry	:= ""
Local cSitQuery	:= ""
Local cCatQuery	:= ""  
Local cArqNtx	:= ""
Local nReg		:= 0	
Local nOrdem	:= oSection:GetOrder()

// Variaveis utilizadas para parametros                         
// mv_par01        //  Filial                                   
// mv_par02        //  Centro de Custo                          
// mv_par03        //  Matricula                                
// mv_par04        //  Nome                                     
// mv_par05        //  Chapa                                    
// mv_par06        //  Data de Nascimento                       
// mv_par07        //  Mes De                                   
// mv_par08        //  Mes Ate                                  
// mv_par09        //  Situacoes                                
// mv_par10        //  Categorias                               
// mv_par11        //  Imprime Salario                          
// mv_par12        //  Imprime Ano de Nascimento                
// mv_par13        //  IMprime Estado Civil                     
// mv_par14        //  Salta Pagina por Filial                  

Local aCampos,cArqTrb
Local cSituacao  := mv_par09
Local cCategoria := mv_par10
Local lImpSal    := If( mv_par11 == 1 , .T. , .F. )
Local lAnoNas    := If( mv_par12 == 1 , .T. , .F. )
Local lImpEst    := If( mv_par13 == 1 , .T. , .F. )
Local lSalta     := If( mv_par14 == 1 , .T. , .F. )
Local cFilSRACTT := "%" + FWJoinFilial("SRA", "CTT") + "%"

Private cAcessaSRA	:= &( " { || " + ChkRH( "GPER260" , "SRA" , "2" ) + " } " )
Private nMesDe     := mv_par07
Private nMesAte    := mv_par08	
	
	SET CENTURY ON
	
	If nOrdem # 4
		oSection:Cell("RA_CHAPA"):Disable()
	EndIf
	
	If !lImpSal
		oSection:Cell("RA_SALARIO"):Disable()
	EndIf
	
	If !lImpEst
		oSection:Cell("RA_ESTCIVI"):Disable()
	EndIf	
		
	If lAnoNas
		oSection:Cell("DNASCIM"):Disable()
	Else
		oSection:Cell("RA_NASC"):Disable()
	EndIf
	
	If oReport:Cancel()
		If nTdata > 8
			SET CENTURY ON
		Else
			SET CENTURY OFF
		Endif
		Return
	EndIf               
	
	If lSalta
		//-- Quebrar por Filial
		DEFINE BREAK oBreakFil OF oSection WHEN oSection:Cell("RA_FILIAL") PAGE BREAK		
	EndIf
	
	//-- Condicao de impressao do Funcionario
	oSection:SetLineCondition({|| U_fGP260Cond(cAliasQry) }) 
	

	cAliasQry := GetNextAlias()

	//-- Modifica variaveis para a Query 
	cSitQuery := ""
	For nReg:=1 to Len(cSituacao)
		cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cSituacao)
			cSitQuery += "," 
		Endif
	Next nReg        
	cSitQuery := "%" + cSitQuery + "%"
	
	cCatQuery := ""
	For nReg:=1 to Len(cCategoria)
		cCatQuery += "'"+Subs(cCategoria,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cCategoria)
			cCatQuery += "," 
		Endif
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
		ElseIf nOrdem == 4
			cOrdem := "%SRA.RA_FILIAL,SRA.RA_CHAPA%"
		ElseIf nOrdem == 5
			if lAnoNas
				cOrdem := "%SRA.RA_FILIAL,SRA.RA_NASC%"
			else
				cOrdem := "%SRA.RA_FILIAL,SUBSTRING( SRA.RA_NASC, 5, 4)%"
			endIf
		EndIf
			
		
		If ("MSSQL"$tcGetDB())		
			BeginSql alias cAliasQry
				SELECT	SRA.RA_FILIAL, SRA.RA_CC,   SRA.RA_MAT,     SRA.RA_NOME,   SRA.RA_SITFOLH, SRA.RA_CATFUNC, 
						SRA.RA_CHAPA,  SUBSTRING( SRA.RA_NASC, 1, 4) AS ANO, SRA.RA_NASC, SRA.RA_SALARIO, SRA.RA_ESTCIVI,CTT.CTT_DESC01
				FROM %table:SRA% SRA
				LEFT JOIN %table:CTT% CTT on CTT.CTT_CUSTO = RA_CC AND CTT.%notDel%  AND %exp:cFilSRACTT%
				WHERE SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	AND
					  SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	AND
		   	 	      SRA.%notDel%    
				ORDER BY %exp:cOrdem%
			EndSql
		Else
			BeginSql alias cAliasQry
				SELECT	SRA.RA_FILIAL, SRA.RA_CC,   SRA.RA_MAT,     SRA.RA_NOME,   SRA.RA_SITFOLH, SRA.RA_CATFUNC, 
						SRA.RA_CHAPA,  SUBSTR( SRA.RA_NASC, 1, 4) AS ANO, SRA.RA_NASC, SRA.RA_SALARIO, SRA.RA_ESTCIVI,CTT.CTT_DESC01
				FROM %table:SRA% SRA
				LEFT JOIN %table:CTT% CTT on CTT.CTT_CUSTO = RA_CC AND CTT.%notDel%  AND %exp:cFilSRACTT%
				WHERE SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	AND
					  SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	AND
		   	 	      SRA.%notDel%    
				ORDER BY %exp:cOrdem%
			EndSql
		EndIf
		
	/*
	Prepara relatorio para executar a query gerada pelo Embedded SQL passando como 
	parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados 
	pela funcao MakeSqlExpr para serem adicionados a query
	*/
	END REPORT QUERY oSection PARAM mv_par01, mv_par02, mv_par03, mv_par04, mv_par05, mv_par06
	
	// Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter( 100 )  
	
	oSection:Print()	 // Imprimir
	
	// Termino do Relatorio                                        
	dbSelectArea( "SRA" )
	Set Filter to
	dbSetOrder(1)
	Set Device To Screen
	If nOrdem == 4 .Or. nOrdem == 5
		fErase( cArqNtx + OrdBagExt() )
	EndIf


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fGP260Cond    ³ Autor ³ Tania Bronzeri   ³ Data ³12/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Verifica Condicao para Impressao da Linha do Relatorio     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ A partir do Release 4                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fGP260Cond(cAliasQry)
Local lRet	:= .T.            
Default cAliasQry	:= "SRA"                 
	
	
	// Consiste Filiais e Acessos                                             
	If !( (cAliasQry)->RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA )
		lRet	:= .F.			 	
	EndIf
	
	// Verifica Mes de Nascimento                                   
	If Month((cAliasQry)->RA_NASC) < nMesDe .Or. Month((cAliasQry)->RA_NASC) > nMesAte
		lRet	:= .F.
	EndIf    

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Scheddef    ³ Autor ³ Mariana Moraes     ³ Data ³13/11/2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Trazer o grupo de perguntas GP260R quando houver schedule  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Scheddef()  

	Local aParam
	Local aOrd     := {OemToAnsi(" Por Codigo         "),OemToAnsi(" Alfabetica         ")}
	aParam := { "R",;      // Tipo R para relatorio P para processo   
				"GP260R",;	// Pergunte do relatorio, caso nao use passar ParamDef            
				"SRA",;  	// Alias            
   				aOrd,;   	// Array de ordens   
				OemToAnsi(STR0011)}	//" RELACAO DE ANIVERSARIANTES DO MES "  
				  
Return aParam                     

