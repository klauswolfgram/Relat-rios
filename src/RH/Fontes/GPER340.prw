/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER340.CH"
#INCLUDE "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao      ³ GPER340  ³ Autor          ³ RH - Marcos Stiefano ³ Data ³ 15.04.96     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao   ³ Relacao de Cargos e Salarios                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe     ³ U_GPER340(void)                                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso         ³ Generico                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±  
±±³		      	   ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL     		        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³Data      ³ FNC            ³ Motivo da alteracao 				        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Raquel Hager³12/04/13  |M12RH01         |RQ002 - Unificacao da Folha de Pagamento.   ³±±
±±³Sidney O.   ³22/04/14  |M_RH003   295105|Replica / compatibilizacao de fonte para a  ³±±
±±³            ³          |                | versao 12.                                 ³±±
±±³Sidney O.   ³28/05/14  |M_RH003   295105|Alteracao para utilizar periodo com a funcao³±±
±±³            ³          |                |fsalario().                                 ³±±  
±±³Sidney O.   ³06/06/14  |M_RH003   295105|Ajuste para o erro da variavel cAnoMes      ³±±
±±³            ³          |                |quando MV_MODFOL == "2"                     ³±±
±±³Jônatas A.  ³12/04/17  |DRHPAG-242      |Substituição das funções de criação de      ³±±
±±³            ³          |                |tabelas temporárias pela classe             ³±±
±±³            ³          |                |FWTemporaryTable().                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/    
User Function GPER340()      
Local	aArea 	:= GetArea() 
Local	oReport
Private	cString	:= "SRA"					// Alias do arquivo primario
Private cPosit	:= "SRJ"					// Alias do arquivo secundario 
Private cPerg	:= "GP340R"
Private aOrd    := {OemToAnsi(STR0001),;	// Centro De Custo + Matricula
					OemToAnsi(STR0002),;	// Centro de Custo + Nome
					OemToAnsi(STR0003),;	// Centro de Custo + Funcao
					OemToAnsi(STR0029),	;	// Nome
					OemToAnsi(STR0030),;	// Matricula
					OemToAnsi(STR0031)	}	// Funcao	  
Private cTitulo	:= OemToAnsi(STR0009)		// "RELACAO DE CARGOS E SALARIOS"
	                       
	Pergunte(cPerg,.F.)
    oReport := ReportDef()
	
	oReport:PrintDialog()
   	
	RestArea( aArea )
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef  ³ Autor ³ Tania Bronzeri        ³ Data ³14/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio de Cargos e Salarios.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER340 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef() 

	Local oReport 
	Local oSection1       
	Local oSection2
	Local nTamCC	:= If( TamSX3("CTT_CUSTO")[1] > 15, 22, 17 )
	Local cDesc1	:= OemToAnsi(STR0004) + OemToAnsi(STR0005) + OemToAnsi(STR0006)	
	                   //"Relacao de Cargos e Salarios."###"Sera impresso de acordo com os parametros solicitados pelo"###"usuario."

	Local DescMO		:= ""
	Local nTamData		:= TamSX3("RA_ADMISSA")[1] + 7
	Local nTamDesFun	:= TamSX3("RJ_DESC")[1] + 3
	Local nTamFil		:= TamSX3("RA_FILIAL")[1]
	Local nTamMat		:= TamSX3("RA_MAT")[1]
	
	DEFINE REPORT oReport NAME "GPER340" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION OemtoAnsi(STR0037) TOTAL IN COLUMN	
	
	DEFINE SECTION oSection1 OF oReport TITLE OemToAnsi(STR0042) TABLES "SRA","SRJ" TOTAL IN COLUMN ORDERS aOrd	
	
	DEFINE CELL NAME "RA_FILIAL" 	OF oSection1 SIZE nTamFil 		ALIAS cString 
	DEFINE CELL NAME "RA_CC" 	 	OF oSection1 SIZE nTamCC		ALIAS cString 
	DEFINE CELL NAME "RA_MAT" 	 	OF oSection1 SIZE nTamMat		ALIAS cString 
	DEFINE CELL NAME "RA_NOME" 	 	OF oSection1 					ALIAS cString 
	DEFINE CELL NAME "RA_ADMISSA"	OF oSection1 SIZE nTamData		ALIAS cString 
	DEFINE CELL NAME "RA_CODFUNC"	OF oSection1 					ALIAS cString 
	DEFINE CELL NAME "RJ_DESC"		OF oSection1 SIZE nTamDesFun	ALIAS cString BLOCK {||DESCFUN( (cAliasQry)->RA_CODFUNC, (cAliasQry)->RA_FILIAL, nTamDesFun)} LINE BREAK
	DEFINE CELL NAME "RJ_MAOBRA"	OF oSection1 					ALIAS "SRJ"   SIZE 15 BLOCK {||FBuscaSRJ(xFilial("SRJ", (cAliasQry)->RA_FILIAL), (cAliasQry)->RA_CODFUNC,@DescMO), DescMO}
	
	DEFINE CELL NAME "RA_SALARIO"	OF oSection1 SIZE TamSX3("RA_SALARIO")[1]	TITLE OemToAnsi(STR0038) PICTURE X3Picture( "RA_SALARIO" )	//	"SALARIO NOMINAL"
	DEFINE CELL NAME "NPERCCCUSTO"	OF oSection1 SIZE TamSX3("RA_SALARIO")[1]	TITLE OemtoAnsi(STR0039) PICTURE X3Picture( "RA_SALARIO" )	//	"PERC.C.CUSTO"			
	DEFINE CELL NAME "NPERCFILIAL"	OF oSection1 SIZE TamSX3("RA_SALARIO")[1]	TITLE OemToAnsi(STR0040) PICTURE X3Picture( "RA_SALARIO" )	//	"PERC.FILIAL"
	DEFINE CELL NAME "NPERCEMPRESA"	OF oSection1 SIZE TamSX3("RA_SALARIO")[1]	TITLE OemToAnsi(STR0041) PICTURE X3Picture( "RA_SALARIO" )	//	"PERC.EMPRESA"
	
	DEFINE SECTION oSection2 OF oReport TABLES "SRA","SRJ" /*TOTAL IN COLUMN */ORDERS aOrd	
	
	DEFINE FUNCTION FROM oSection1:Cell("RA_MAT")		FUNCTION COUNT NO END SECTION 
	DEFINE FUNCTION FROM oSection1:Cell("RA_SALARIO")	FUNCTION SUM   PICTURE "@E 999,999,999,999.99"  NO END SECTION
	DEFINE FUNCTION FROM oSection1:Cell("NPERCCCUSTO")	FUNCTION SUM   PICTURE "@E 999,999,999,999.999" NO END SECTION
	DEFINE FUNCTION FROM oSection1:Cell("NPERCFILIAL")	FUNCTION SUM   PICTURE "@E 999,999,999,999.999" NO END SECTION
	DEFINE FUNCTION FROM oSection1:Cell("NPERCEMPRESA")	FUNCTION SUM   PICTURE "@E 999,999,999,999.999" NO END SECTION
	
Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport ³ Autor ³ Tania Bronzeri       ³ Data ³14/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatorio de Cargos e Salarios.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(oReport)                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER340 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)
//-- Objeto
Local oSection1	:= oReport:Section(1)  
Local oSection2 := oReport:Section(2)
//-- String
Local cFiltro 	:= "" 
Local cSitQuery	:= ""
Local cCatQuery	:= "" 
Local cTitCC	:= "" 
Local cTitFil	:= ""
Local cFilSRJ   := ""
Local cSemana	:= ""  
Local cFilialAnt:= Replicate("!", FwSizeFilial()) 
Local cFANT 	:= Replicate("!", FwSizeFilial())
Local cCANT 	:= Space(20)
Local cAcessaSRA:= &("{ || " + ChkRH("GPER340","SRA","2") + "}")
Local cOrdem	:= "" 
//-- Numerico
Local nReg		:= 0
Local nSalario  := 0
Local nSalMes   := 0
Local nSalDia   := 0 
Local nSalHora  := 0
Local nX        := 0
Local nTamCC	:= TamSX3("CTT_CUSTO")[1]    
//-- Array
Local aTCC      := {}
Local aTCCF		:= {}
Local aTFIL 	:= {}
Local aTFILF 	:= {}

Local aPerAtual := {}

Local cDescMO	:= ''
Local cXLSX     := STR0046  //"Devido ao seu modelo, para o Tipo de Planilha em Formato de Tabela, o Relatório de Cargos e Salários no modo Sintético é apresentado em branco! Favor escolher outro formato de Impressão."

//-- Carregando variaveis mv_par?? para Variaveis do Sistema 
Private cSituacao   := mv_par06							//  Situacao Funcionario
Private cCategoria  := mv_par07							//  Categoria Funcionario
Private lSalta	    := If( mv_par08 == 1 , .T. , .F. )	//  Salta Pagina Quebra C.Custo
Private lImpTFilEmp := If( mv_par09 == 1 , .T. , .F. )	//  Imprime Total Filial/Empresa
Private nQualSal    := mv_par10							//  Sobre Salario Mes ou Hora
Private nBase       := mv_par11                         //  Sobre Salario Composto Base
Private nTipoRel    := mv_par12                         //  Imprime Analitico Sintetico  
//-- Define Variaveis Private(Programa)                           
Private aInfo     	:= {}
Private aCodFol   	:= {}
Private aRoteiro 	:= {} 
Private nOrdem	
Private cAnoMes 	:= ""
Private oTmpTbl
Private cAliasQry	:= ""
	
	//--Seta e Carrega os Mnemonicos.
	SetMnemonicos(NIL,NIL,.T.)

	nOrdem := oReport:GetOrder()



	// Validação de Tipo Planilha no Formato de tabela.
	// Sempre imprimir totalizador filial quando for sintetico
	If nTipoRel  == 2
		lImpTFilEmp := .T.

        If(oReport:lXlstable) 
            Help( , , 'HELP', , OemToAnsi(cXLSX), 1, 0)
            Return Nil
        Endif
	EndIf


	If nOrdem < 4  // Quebrar e Totalizar por Centro de Custo
		
        DEFINE BREAK oBreakCCusto OF oReport WHEN {|| SRA->RA_FILIAL + SRA->RA_CC }   TITLE OemToAnsi(STR0017) //"TOTAL CENTRO DE CUSTO " 
		DEFINE FUNCTION FROM oSection1:Cell("RA_MAT")		FUNCTION COUNT BREAK oBreakCCusto NO END REPORT NO END SECTION
		DEFINE FUNCTION FROM oSection1:Cell("RA_SALARIO")	FUNCTION SUM   BREAK oBreakCCusto PICTURE "@E 999,999,999,999.99"  NO END REPORT NO END SECTION
		DEFINE FUNCTION FROM oSection1:Cell("NPERCCCUSTO")	FUNCTION SUM   BREAK oBreakCCusto PICTURE "@E 999,999,999,999.999" NO END REPORT NO END SECTION
		DEFINE FUNCTION FROM oSection1:Cell("NPERCFILIAL")	FUNCTION SUM   BREAK oBreakCCusto PICTURE "@E 999,999,999,999.999" NO END REPORT NO END SECTION
		DEFINE FUNCTION FROM oSection1:Cell("NPERCEMPRESA")	FUNCTION SUM   BREAK oBreakCCusto PICTURE "@E 999,999,999,999.999" NO END REPORT NO END SECTION
		
        oBreakCCusto:OnBreak({|x,y|cTitCC:= OemToAnsi(STR0017)+FBuscaCDC(x)}) 
		oBreakCCusto:SetTotalText({||cTitCC})
		oBreakCCusto:SetPageBreak(lSalta)	//  Se .T. Salta Pagina Quebra C.Custo  
		If nTipoRel == 2
			oBreakCCusto:SetTotalInLine(.T.)
		EndIf
	EndIf
	
	If lImpTFilEmp 	// Quebrar e Totalizar por Filial
		
		DEFINE BREAK oBreakFil OF oReport WHEN oSection1:Cell("RA_FILIAL") TITLE OemToAnsi(STR0019)	 // "Total Filial"
		
			DEFINE FUNCTION FROM oSection1:Cell("RA_MAT")		FUNCTION COUNT BREAK oBreakFil NO END REPORT NO END SECTION
			DEFINE FUNCTION FROM oSection1:Cell("RA_SALARIO")	FUNCTION SUM   BREAK oBreakFil PICTURE "@E 999,999,999,999.99" NO END REPORT NO END SECTION
			DEFINE FUNCTION FROM oSection1:Cell("NPERCEMPRESA")	FUNCTION SUM   BREAK oBreakFil PICTURE "@E 999,999,999,999.999" NO END REPORT NO END SECTION
			
			oBreakFil:OnBreak({|x,y| cTitFil := OemToAnsi(STR0019)+x}) // "Total Filial" 
			oBreakFil:SetTotalText({||cTitFil}) 
			If nTipoRel == 2
				oBreakFil:SetTotalInLine(.T.)
			EndIf
	EndIf
	
	If nTipoRel == 2
		oReport:SetTotalInLine(.T.)             
	EndIf
	
	cAliasQry := GetNextAlias()
	
	// Modifica variaveis para a Query 
	cSitQuery := ""
	For nReg := 1 to Len(cSituacao)
		cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cSituacao)
			cSitQuery += "," 
		Endif
	Next nReg        
	cSitQuery := "%" + cSitQuery + "%"
	
	cCatQuery := ""
	For nReg := 1 to Len(cCategoria)
		cCatQuery += "'"+Subs(cCategoria,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cCategoria)
			cCatQuery += "," 
		Endif
	Next nReg        
	cCatQuery := "%" + cCatQuery + "%"
	
	// Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr(cPerg)
	
	// Retirado o bloqueio ao filtro de usuario - 07/2008	   				
		If nOrdem == 1
			cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_MAT%"
		ElseIf nOrdem == 2
			cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_NOME%"
		ElseIf nOrdem == 3
			cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_CODFUNC%"
		ElseIf nOrdem == 4
			cOrdem := "%SRA.RA_FILIAL,SRA.RA_NOME%"
		ElseIf nOrdem == 5
			cOrdem := "%SRA.RA_FILIAL,SRA.RA_MAT%"
		ElseIf nOrdem == 6
			cOrdem := "%SRA.RA_FILIAL,SRA.RA_CODFUNC%"
		Endif
			
		cFilSRJ := "% AND " + FWJoinFilial("SRA", "SRJ") + " %" 
		
	BEGIN REPORT QUERY oSection1
		
		BeginSql alias cAliasQry
			SELECT	SRA.RA_FILIAL, SRA.RA_CC, SRA.RA_HRSMES, SRA.RA_MAT, SRA.RA_NOME, SRA.RA_SITFOLH, SRA.RA_CATFUNC,
					SRA.RA_ADMISSA, SRJ.RJ_FUNCAO, SRJ.RJ_DESC, SRJ.RJ_MAOBRA, SRA.RA_CODFUNC, SRA.RA_SALARIO
			FROM %table:SRA% SRA
			LEFT JOIN %table:SRJ% SRJ
				ON	SRA.RA_CODFUNC	= 	SRJ.RJ_FUNCAO
				%exp:cFilSrj%
			WHERE SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	AND
					SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	AND
					SRA.%notDel%  AND
					SRJ.%notDel%  
			ORDER BY %exp:cOrdem%
		EndSql
	// Prepara relatorio para executar a query gerada pelo Embedded SQL passando como 
	// parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados 
	// pela funcao MakeSqlExpr para serem adicionados a query
	END REPORT QUERY oSection1 PARAM mv_par01, mv_par02, mv_par03, mv_par04, mv_par05
	
	oSection1:SetParentQuery()
    
	cPosit	:= cAliasQry     
	
	oSection2:SetParentQuery()
	
	TRPosition():New(oSection1,"SRA",1,{|| TRA->FILIAL+TRA->MAT},.T.)
	
	cTitulo := oReport:Title() + " "
	
	If nOrdem == 1    
		cTitulo += If(AllTrim(oReport:Title())==AllTrim(cTitulo),OemToAnsi(STR0013),oReport:Title())	//"(C.CUSTO + MATRICULA)"
	ElseIf nOrdem == 2
		cTitulo += If(AllTrim(oReport:Title())==AllTrim(cTitulo),OemToAnsi(STR0014),oReport:Title())	//"(C.CUSTO + NOME)"
	ElseIf nOrdem== 3 
		cTitulo += If(AllTrim(oReport:Title())==AllTrim(cTitulo),OemToAnsi(STR0015),oReport:Title())	//"(C.CUSTO + FUNCAO)"
	ElseIf nOrdem == 4		
		cTitulo += If(AllTrim(oReport:Title())==AllTrim(cTitulo),OemToAnsi(STR0034),oReport:Title())	//"(NOME)"
	ElseIf nOrdem == 5		
		cTitulo += If(AllTrim(oReport:Title())==AllTrim(cTitulo),OemToAnsi(STR0035),oReport:Title())	//"(MATRICULA)"
	ElseIf nOrdem == 6		
		cTitulo += If(AllTrim(oReport:Title())==AllTrim(cTitulo),OemToAnsi(STR0036),oReport:Title())	//"(FUNCAO)"
	EndIf		
	
	//-- Altera o titulo do relatorio acrescentando a ordem impressa     
	oReport:SetTitle( If( AllTrim(oReport:Title()) == AllTrim(cTitulo), cTitulo, oReport:Title() ) )
	
	aCampos := {}
	AADD(aCampos,{"FILIAL"   ,"C",FwSizeFilial(),0})
	AADD(aCampos,{"MAT"      ,"C",TamSX3("RA_MAT")[1],0})
	AADD(aCampos,{"CC"       ,"C",TamSX3("RA_CC")[1],0})
	AADD(aCampos,{"SALMES"   ,"N",TamSX3("RA_SALARIO")[1],2})
	AADD(aCampos,{"SALHORA"  ,"N",TamSX3("RA_SALARIO")[1],2})
	AADD(aCampos,{"CODFUNC"  ,"C",TamSX3("RA_CODFUNC")[1],0})
	AADD(aCampos,{"NOME"     ,"C",TamSX3("RA_NOME")[1],0})
	AADD(aCampos,{"ADMISSA"  ,"D",TamSX3("RA_ADMISSA")[1],0})
	
	oTmpTbl := FWTemporaryTable():New( "TRA" )
	oTmpTbl:SetFields( aCampos )
	oTmpTbl:AddIndex( "01", { "FILIAL", "MAT" } )
	
	If nOrdem == 1
		oTmpTbl:AddIndex( "FILCCMAT", { "FILIAL", "CC", "MAT" } )
	ElseIf nOrdem == 2
		oTmpTbl:AddIndex( "FILCCNOM", { "FILIAL", "CC", "NOME" } )
	ElseIf nOrdem == 3
		oTmpTbl:AddIndex( "FILCCFUN", { "FILIAL", "CC", "CODFUNC" } )
	ElseIf nOrdem == 4
		oTmpTbl:AddIndex( "FILNOM", { "FILIAL", "NOME" } )
	ElseIf nOrdem == 6
		oTmpTbl:AddIndex( "FILFUN", { "FILIAL", "CODFUNC" } )
	EndIf
	
	oTmpTbl:Create()
	
	// Sempre na ordem de Centro de Custo + Matricula para totalizar
	dbSelectArea( cAliasQry )

	// Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter( 100 )  
	
	// Incializa impressao   
	oSection1:Init() 
	
	If nTipoRel == 2   
		oSection1:Hide() 
	EndIf                          
	
	TPAGINA	 := TEMPRESA := TFILIAL := TCCTO := FL1 := 0
	TEMPRESAF := TFILIALF := TCCTOF	:= 0
	
	While !(cAliasQry)->( Eof() ) 
		
		// Movimenta Regua de Processamento                             
		oReport:IncMeter( 1 )   
		
		// Verifica se o usuario cancelou a impressao do relatorio
		If oReport:Cancel()
			Exit
		EndIf               
		
		// Verifica Quebra de Filial 	 	 	 	 	 	 	 	     
		If (cAliasQry)->RA_FILIAL # cFilialAnt
			If !Fp_CodFol(@aCodFol,(cAliasQry)->RA_FILIAL) .Or.;
				!fInfo(@aInfo,(cAliasQry)->RA_FILIAL)
				dbSelectArea(cAliasQry)
				dbSkip()
				If Eof()
					Exit
				EndIf	
				Loop
			Endif
			dbSelectArea( cAliasQry )
			cFilialAnt := (cAliasQry)->RA_FILIAL
		EndIf
		
		
		// Posiciona SRA para chamada das funcoes do GPEXCAL1
		dbSelectArea(cString)
		dbSetOrder(1)
		dbSeek((cAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT)
		dbSelectArea( cAliasQry )
		
		// Consiste controle de acessos e filiais validas               
		If !((cAliasQry)->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
			dbSkip()
			Loop
		EndIf
		nSalario	:= 0
		nSalMes		:= 0
		nSalDia		:= 0
		nSalHora	:= 0  
		
	    // Modelo 2 nao usa funcao fSalInc
		If nBase == 1  .And. MV_MODFOL <> '2'						  // 1 Composto
			// Calcula Salario Incorporado Mes , Dia , Hora do Funcionario  
			fSalInc(@nSalario,@nSalMes,@nSalHora,@nSalDia,.T.)
		Else
			If Type("cAnoMes") == "U" .OR. Empty(cAnoMes) 
				If Type("aPerAtual") == "U" .OR. Empty(aPerAtual) .OR. !(aPerAtual[1,8] == SRA_RA_PROCES)
					fGetPerAtual( @aPerAtual, xFilial("RCH"), SRA->RA_PROCES, fGetRotOrdinar() )
					If Empty(aPerAtual)
						fGetPerAtual( @aPerAtual, xFilial("RCH"), SRA->RA_PROCES, fGetCalcRot('9') )
					EndIf
				EndIf
				
				If !Empty(aPerAtual)
					cAnoMes := AnoMes(aPerAtual[1,6])
					cSemana := aPerAtual[1,2]
				Else
					dbSelectArea(cAliasQry)
					dbSkip()
					Loop				
				EndIf
			EndIf
			
			cTipoRot := ""
			
			fSalario(@nSalario,@nSalHora,@nSalDia,@nSalMes,"A",cAnoMes, cSemana)      // 2 Base
			
			If nQualSal == 1	    	// 1-Mes
				nSalMes := nSalario			
			Else						// 2-Hora
				nSalHora := Round(nSalario / (cAliasQry)->RA_HRSMES,MsDecimais(1))
			EndIf
		EndIf
		
		dbSelectArea( cAliasQry )
		RecLock("TRA",.T.)
		Replace FILIAL    With (cAliasQry)->RA_FILIAL
		Replace MAT       With (cAliasQry)->RA_MAT  
		Replace CC        With (cAliasQry)->RA_CC 
		Replace CODFUNC   With (cAliasQry)->RA_CODFUNC
		Replace ADMISSA   With (cAliasQry)->RA_ADMISSA
		Replace NOME      With (cAliasQry)->RA_NOME
		If nQualSal == 1
			Replace SALMES    With nSalMes         
		Else
			Replace SALHORA   With nSalHora    
		EndIf	
		MsUnLock()
		
		If cFANT == Replicate("!",FwSizeFilial())
			cFANT := (cAliasQry)->RA_FILIAL
			cCANT := Substr((cAliasQry)->RA_CC+Space(20),1,20)
		EndIf
		
		TEMPRESA  += If( nQualSal == 1 , nSalMes , nSalHora )
		TEMPRESAF ++
		
		If (cAliasQry)->RA_FILIAL = cFANT
			TFILIAL	+= If( nQualSal == 1 , nSalMes , nSalHora )
			TFILIALF ++
		Else
			AADD(aTFIL ,{cFANT ,TFILIAL})
			AADD(aTFILF,{cFANT ,TFILIALF})
			TFILIAL	:= If( nQualSal == 1 , nSalMes , nSalHora )
			TFILIALF := 1
		EndIf
				
		If (cAliasQry)->RA_FILIAL + Substr((cAliasQry)->RA_CC+Space(20),1,20) = cFANT + cCANT
			TCCTO  += If( nQualSal == 1 , nSalMes , nSalHora )
			TCCTOF ++
		Else
			AADD(aTCC ,{cFANT+cCANT,TCCTO })
			AADD(aTCCF,{cFANT+cCANT,TCCTOF })
			TCCTO  := If( nQualSal == 1 , nSalMes , nSalHora )
			TCCTOF := 1
		EndIf
			
		cCANT := Substr((cAliasQry)->RA_CC+Space(20),1,20)
		cFANT := (cAliasQry)->RA_FILIAL
		dbSelectArea( cAliasQry )
		dbSkip()
	EndDo
	
	If Eof() .And. TFILIAL > 0
		AADD(aTFIL , {cFANT ,TFILIAL})
		AADD(aTFILF, {cFANT ,TFILIALF})
		AADD(aTCC  , {cFANT + cCANT ,TCCTO})
		AADD(aTCCF , {cFANT + cCANT ,TCCTOF})
	EndIf
	
	dbSelectArea(cString)
	(cString)->(dbCloseArea())
	
	// EMISSAO DO RELATORIO   								 
	If TFILIALF > 0
		dbSelectArea(cAliasQry)
		(cAliasQry)->(dbGotop())
		
		cFANT := (cAliasQry)->RA_FILIAL
		cCANT := Substr((cAliasQry)->RA_CC+Space(20),1,20)
			
		While (cAliasQry)->(!Eof())
			
			dbSelectArea("TRA")
			TRA->(dbSetOrder(1))
			TRA->(dbSeek((cAliasQry)->(RA_FILIAL + RA_MAT)))
			
			oSection1:cell("RA_FILIAL"):SetValue(TRA->FILIAL)			
			oSection1:cell("RA_CC"):SetValue(TRA->CC)	
			oSection1:cell("RA_MAT"):SetValue(TRA->MAT)
			oSection1:cell("RA_NOME"):SetValue(TRA->NOME)	
			oSection1:cell("RA_ADMISSA"):SetValue(TRA->ADMISSA)				
			oSection1:cell("RA_CODFUNC"):SetValue(TRA->CODFUNC)	
			oSection1:cell("RJ_DESC"):SetValue(DESCFUN( TRA->CODFUNC, TRA->FILIAL, TamSX3("RJ_DESC")[1]))
			FBuscaSRJ(xFilial("SRJ", TRA->FILIAL),TRA->CODFUNC,@cDescMO)
			oSection1:cell("RJ_MAOBRA"):SetValue(cDescMO)
			
			If nQualSal == 1
				oSection1:Cell("RA_SALARIO"):SetValue(TRA->SALMES)
			Else
				oSection1:Cell("RA_SALARIO"):SetValue(TRA->SALHORA)
			EndIf
			
			For nX := 1 To Len(aTCC)
				If aTCC[nX,1] = TRA->FILIAL+Substr(TRA->CC+Space(20),1,20)
					If nQualSal == 1
						oSection1:Cell("NPERCCCUSTO"):SetValue(( TRA->SALMES / aTCC[nX,2] )*100)
					Else
						oSection1:Cell("NPERCCCUSTO"):SetValue(( TRA->SALHORA / aTCC[nX,2] )*100)
					EndIf
					TOTCC := aTCC[nX,2]
					TOTCCF:= aTCCF[nX,2]
				EndIf
			Next nX
			
			If lImpTFilEmp  // Se Imprimir Totais Filial/Empresa
				For nX := 1 To Len(aTFIL)
					If aTFIL[nX,1] = TRA->FILIAL
						If nQualSal == 1
							oSection1:Cell("NPERCFILIAL"):SetValue(( TRA->SALMES / aTFIL[nX,2] )*100)
						Else
							oSection1:Cell("NPERCFILIAL"):SetValue(( TRA->SALHORA / aTFIL[nX,2] )*100)
						EndIf
						If nQualSal == 1
							oSection1:Cell("NPERCEMPRESA"):SetValue(( TRA->SALMES / TEMPRESA )* 100)
						Else
							oSection1:Cell("NPERCEMPRESA"):SetValue(( TRA->SALHORA / TEMPRESA )* 100)
						EndIf
					EndIf
				Next nX
			EndIF
			
			cFANT := TRA->FILIAL
			cCANT := Substr(TRA->CC+Space(20),1,20) 
			
			For nX := 1 To Len(aTCC)
				If aTCC[nX,1] == TRA->FILIAL+Substr(TRA->CC+Space(20),1,20)
					TOTCC := aTCC[nX,2]
					TOTCCF:= aTCCF[nX,2]
				EndIf
			Next nX
			
			For nX := 1 To Len(aTFIL)
				If aTFIL[nX,1] == TRA->FILIAL
					TOTFIL := aTFIL[nX,2]
					TOTFILF:= aTFILF[nX,2]
				EndIf
			Next nX
			
			oSection1:PrintLine()
			
			(cAliasQry)->( dbSkip())
		EndDo
		
		aTCC	:={}
		aTFIL	:={}
	EndIf
	
	oSection1:CloseQuery()
	
	// Termino do relatorio									     
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter To
	
	dbSelectArea("TRA")
	dbCloseArea()
	
	If oTmpTbl <> Nil
		oTmpTbl:Delete()
		oTmpTbl := Nil
	Endif
	
	// Finaliza impressao inicializada pelo metodo Init             
	oSection1:Finish()

Return Nil

/*    
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fBuscaSRJ ³ Autor ³ Equipe RH           ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Busca descricao de funcao.                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fBuscaSRJ(cFil, cCodigo, DescMO)                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fBuscaSRJ( cFil , cCodigo , DescMO )
Local cAlias := Alias()
	
	dbSelectArea( "SRJ" )  
	
	If ( cFil # Nil .And. cFilial == Space(FwSizeFilial())) .Or. cFil == Nil
		cFil := cFilial
	EndIf  
	
	If dbSeek( cFil + cCodigo )
		If Left(RJ_MAOBRA ,1 ) == "D"
			DescMO := STR0027		//"DIR"
		Elseif Left(RJ_MAOBRA ,1 ) == "I"
			DescMO := STR0028		//"IND"
		Else
			DescMO := "   "
		Endif
	Else
		DescMO := "***"
	EndIf
		
	dbSelectArea(cAlias)

Return( .T. )  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GPER340  ³ Autor ³ RH - Luciana Silveira     ³ Data ³ 07/04/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Busca descricao de Centro de Custo.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FBuscaCDC(cCodCC)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FBuscaCDC(cCodCC)

Local aArea 		:= GetArea()
Local cDescCc       := ""
Local cCodFil		:= Left(cCodcc,FwGetTamFilial)
Local cCodCCusto	:= Substr(cCodcc,FwGetTamFilial+1)

dbSelectArea("CTT")
dbSetOrder(1)

IF CTT->(dbSeek(xFilial("CTT",cCodFil) + cCodCCusto))
    cDescCc := allTrim(cCodCCusto)+" - "+CTT->CTT_DESC01
EndIf  

RestArea( aArea )

Return(cDescCc)          
