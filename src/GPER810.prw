/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"     
#INCLUDE "GPER810.CH"
#INCLUDE "REPORT.CH"     
                                     
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER810  ³ Autor ³ Alceu Pereira             ³ Data ³ 25.08.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Exercico de Cargos Superiores                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER810()                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³                     ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ BOPS ³  Motivo da Alteracao                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³          ³      ³											  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programador  ³ Data     ³ FNC            ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±³Rogerio R.   ³29/07/2009³00000018278/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±³Luis Enríquez³26/01/2017³SERINN001-848   ³-Se realiza merge contra 12.1.15 para hacer³±±
±±³             ³          ³                ³ cambio en creación de tabla temporal se   ³±±
±±³             ³          ³                ³ utiliza clase FWTemporary CTRE.           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER810()  

	Local	oReport   
	Local	aArea 	:= GetArea()
	Private	cString	:= "SRA"				// alias do arquivo principal (Base)
	Private cPosit	:= "SRJ"
	Private cPerg	:= "GPR810"
	Private aOrd	:= {OemToAnsi(STR0007),OemToAnsi(STR0001)} //Filial + Matricula ####  //Filial + Nome
	Private cTitulo	:= OemToAnsi(STR0002)	//"RELA€ŽO DE EXERCICIO DE FUNCAO SUPERIOR"
	Private oTmpTable := Nil
	Private aOrdem := {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	pergunte(cPerg,.F.) 

	oReport := ReportDef()
	oReport:PrintDialog()

	RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ ReportDef  ³ Autor ³ Alceu Pereira         ³ Data ³ 25/08/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatorio de Exercicio de Funcao Superior                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ReportDef()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GPER810 - Generico 											³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()   
	Local oReport 
	Local oSection 
	Local cDesc1	:= OemToAnsi(STR0001) + OemToAnsi(STR0002) 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criacao dos componentes de impressao                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE REPORT oReport NAME "GPER810" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| Imp810R(oReport)} DESCRIPTION OemtoAnsi(STR0004) TOTAL IN COLUMN	 
	//"Este programa emite Relação de Exercício de Função Superior."
	DEFINE SECTION oSection OF oReport TITLE OemToAnsi(STR0005)TABLES "SRA", "RGL","SRJ", "TRA" TOTAL IN COLUMN ORDERS aOrd	

	DEFINE CELL NAME "RA_FILIAL" 	OF oSection ALIAS cString BLOCK {||TRA->FILIAL}
	DEFINE CELL NAME "RA_MAT" 	 	OF oSection ALIAS cString BLOCK {||TRA->MAT}
	DEFINE CELL NAME "RA_NOME" 	 	OF oSection ALIAS cString BLOCK {||TRA->NOME}           
	DEFINE CELL NAME "RGL_CODFUN"	OF oSection ALIAS cString BLOCK {||TRA->CODFUNC}
	DEFINE CELL NAME "RJ_DESC"		OF oSection ALIAS cString BLOCK {||TRA->DESCFUNC}
	DEFINE CELL NAME "RGL_SALARI"	OF oSection ALIAS cString BLOCK {||TRA->SALARIO}
	DEFINE CELL NAME "RGL_DTINI"	OF oSection ALIAS cString BLOCK {||TRA->INIFUNCAO}
	DEFINE CELL NAME "RGL_DTFIM"	OF oSection ALIAS cString BLOCK {||TRA->FIMFUNCAO}
	DEFINE CELL NAME "RGL_DIAS"		OF oSection ALIAS cString BLOCK {||TRA->DIAS} 

	DEFINE BREAK oBreakFil OF oSection WHEN oSection:Cell("RA_FILIAL") TITLE OemToAnsi(STR0006) // "Total de Registros "	
	oBreakFil:OnBreak({|x,y|cTitFil:=OemToAnsi(STR0006)+x})   

	DEFINE FUNCTION FROM oSection:Cell("RA_MAT") FUNCTION COUNT NO END SECTION   

	oSection:SetAutoSize()
	                                                                                              
Return(oReport)      


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ Imp810R    ³ Autor ³ Alceu Pereira         ³ Data ³ 25/08/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatorio de Exercicio de Funcao Superior                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Imp810R(oReport)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef - Generico 										³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Imp810R(oReport)

	Local oSection	:= oReport:Section(1)
	Local cFiltro 	:= "" 
	Local cAliasQry	:= ""
	Local cAcessaSRA:= &("{ || " + ChkRH("GPER810","SRA","2") + "}")
	Local cArqNtx   := cIndCond := ""  
	Local cTrbRGL   := ""
	Local cFilialDe	:= ""
	Local cCCustoDe	:= ""
	Local cMatDe	:= ""
	Local dDataDe   := CTOD("01/01/1900")
	Local dDataAte	:= CTOD("01/01/1900")
	Local cFuncDe 	:= ""
	Local cNomDe	:= ""

	Private nOrdem	:= oSection:GetOrder()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carregando variaveis mv_par para Variaveis do Sistema.	     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cFilialDe		:= mv_par01  //Filial
	CCCustoDe		:= mv_par02  //C. Custo
	cMatDe			:= mv_par03  //Matricula
	dDataDe			:= mv_par04  //Data Inicial
	dDataAte		:= mv_par05  //Data Final
	cFuncDe 		:= mv_par06  //Funcao
	cNomDe			:= mv_par07  //Nome
	     
	If Empty(dDataDe)   
		dDataDe := CTOD("01/01/1900")
	Endif 

	If Empty(dDataAte)
		dDataAte := CTOD("01/01/1900")
	Endif	

	DbSelectarea("SRJ")

	#IFDEF TOP
		cAliasQry := "SRA"
	
		//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
		MakeSqlExpr(cPerg)
	
		BEGIN REPORT QUERY oSection                 
	
			If nOrdem == 1
				cOrdem := "%SRA.RA_FILIAL, SRA.RA_MAT%" 
			ElseIf nOrdem == 2  
				cOrdem := "%SRA.RA_FILIAL, SRA.RA_NOME%"           
			Endif
	
			BeginSql alias cAliasQry   
			SELECT 
			SRA.RA_FILIAL,
			SRA.RA_MAT,
			SRA.RA_NOME,
			RGL.RGL_CODFUN,
			RJ.RJ_DESC,
			RGL.RGL_SALARI,
			RGL.RGL_DTINI,        
			RGL.RGL_DTFIM,
			RGL.RGL_DIAS
			FROM %table:RGL% RGL 
			INNER JOIN %table:SRA% SRA
			ON	SRA.RA_FILIAL = RGL.RGL_FILIAL AND SRA.RA_MAT = RGL.RGL_MAT
			INNER JOIN %table:SRJ% RJ
			ON RJ.RJ_FUNCAO  = RGL.RGL_CODFUN 	
			WHERE                                              
			RGL.%notDel%  
			AND
			SRA.%notDel%   
			ORDER BY %exp:cOrdem%							
			EndSql
	
		END REPORT QUERY oSection PARAM mv_par01, mv_par02, mv_par03, mv_par06, mv_par07
		cPosit	:= cAliasQry                                                            

	#ELSE             

		cAliasQry := "SRA"
	
		//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
		MakeAdvplExpr(cPerg)
		dbSelectArea(cAliasQry)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica a ordem selecionada                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nOrdem == 1
			cIndCond := "SRA.RA_FILIAL + SRA.RA_MAT"    
			dbSetOrder(1)
		ElseIf nOrdem == 2
			cIndCond := "SRA.RA_FILIAL + SRA.RA_NOME"    
			dbSetOrder(3)	  
		Endif
	
		If !Empty(mv_par01)
			cFiltro += mv_par01 
		EndIf
	
		If !Empty(mv_par02)
			cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
			cFiltro += mv_par02 
		EndIf
	
		If !Empty(mv_par03)
			cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
			cFiltro += mv_par03
		EndIf
	
		If !Empty(mv_par07)
			cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
			cFiltro += mv_par07     
		EndIf                                             
	
		oSection:SetFilter(cFiltro) 
		(cAliasQry)->( DbGoTop() )

	#ENDIF	
	
	If nOrdem == 1
		cTitulo += CHR(13) + OemToAnsi(STR0008)		//"(Filial + Matricula)"
	ElseIf nOrdem == 2  
		cTitulo +=	CHR(13) + OemToAnsi(STR0003)		//"(Filial + Nome)"		
	Endif			
											
	oReport:SetTitle(cTitulo)  
	
	aCampos := {}
	AADD(aCampos,{"FILIAL"   	,"C",TamSX3("RA_FILIAL")[1],0}) //02
	AADD(aCampos,{"MAT"      	,"C",06,0})
	AADD(aCampos,{"NOME"     	,"C",30,0})
	AADD(aCampos,{"CODFUNC"  	,"C",05,0})
	AADD(aCampos,{"DESCFUNC" 	,"C",TamSX3("RJ_DESC")[1],0}) //05
	AADD(aCampos,{"SALARIO"     ,"N",TamSX3("RGL_SALARI")[1],2})    
	AADD(aCampos,{"INIFUNCAO"  	,"D",08,0})   
	AADD(aCampos,{"FIMFUNCAO"  	,"D",08,0})   
	AADD(aCampos,{"DIAS"      	,"N",03,0})   

	oTmpTable := FWTemporaryTable():New("TRA")
	oTmpTable:SetFields( aCampos )
	
	If nOrdem == 1
		aOrdem	:=	{"FILIAL","MAT"} 
	ElseIf nOrdem == 2
		aOrdem	:=	{"FILIAL","NOME"}  
	EndIf

	oTmpTable:AddIndex("IN1", aOrdem)

	oTmpTable:Create()
	dbSelectArea( cAliasQry )

	//-- Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter( 100 )

	//-- Incializa impressao   
	oSection:Init()                              

	If !(cAliasQry)->( EOF() ) 
		DbSelectArea("RGL")				
		cTrbRGL := CriaTrab(,.F.)
		IndRegua("RGL",cTrbRGL,"RGL_FILIAL+RGL_MAT+DTOS(RGL_DTINI)+DTOS(RGL_DTFIM)",,DBFilter())
		#IFNDEF TOP
			dbSetIndex(cTrbRGL+OrdBagExt())
		#ENDIF
		("RGL")->( dbSetOrder( 1 ) )
		DbSelectArea("SRJ")         
		("SRJ")->( DbGoTop() )		
		("SRJ")->( dbSetOrder( 1 ) )
	Endif	

	While !(cAliasQry)->( EOF() ) 
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta Regua de Processamento                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:IncMeter( 1 )   

		//-- Verifica se o usuário cancelou a impressão do relatorio
		If oReport:Cancel()
			Exit
		EndIf               
		
		dbSelectArea( cAliasQry )

		RGL->(dbSeek( xFilial(cAliasQry) + (cAliasQry)->RA_MAT))  

		While !RGL-> ( EOF() ) .AND. ( RGL->RGL_FILIAL + RGL->RGL_MAT = xFilial(cAliasQry)+(cAliasQry)->RA_MAT ) .AND. RGL->RGL_DTINI >= dDataDe .AND. RGL->RGL_DTFIM <= dDataAte  
			SRJ->(dbSeek( xFilial("SRJ") + RGL->RGL_CODFUN)) 
			RecLock("TRA",.T.)
			Replace FILIAL    With (cAliasQry)->RA_FILIAL
			Replace MAT       With (cAliasQry)->RA_MAT
			Replace NOME      With (cAliasQry)->RA_NOME
			Replace CODFUNC   With RGL->RGL_CODFUN
			Replace DESCFUNC  With SRJ->RJ_DESC
			Replace SALARIO   With RGL->RGL_SALARI
			Replace INIFUNCAO With RGL->RGL_DTINI        
			Replace FIMFUNCAO With RGL->RGL_DTFIM
			Replace DIAS      With RGL->RGL_DIAS
			MsUnLock()   
			dbSelectArea("RGL") 	
			RGL->(dbSkip())    

		EndDo  

		dbSelectArea( cAliasQry )
		dbSkip()
	EndDo

	#IFDEF TOP
		dbSelectArea(cString)
		dbCloseArea()
	#Endif	

	oSection:CloseQuery()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ EMISSAO DO RELATORIO   								 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("TRA")  
	dbGotop()

		
	While !Eof()
                            
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a linha                                    	 	     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection:PrintLine()

		dbSelectArea( "TRA" )
		dbSkip() 
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Termino do relatorio									     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter To

	dbSelectArea("TRA")
	dbCloseArea()


	If File(cTrbRGL+OrdBagExt())
		Ferase(cTrbRGL+OrdBagExt())
	EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza impressao inicializada pelo metodo Init             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection:Finish()  

	If oTmpTable <> Nil
		oTmpTable:Delete()
		oTmpTable := Nil 
	EndIf
Return Nil
