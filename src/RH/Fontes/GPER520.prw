/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GPER520.CH"
#include "report.ch"
#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER520  ³ Autor ³ R.H. - Pedro Eloy     ³ Data ³ 12.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Seguro de Vida                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER520(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS  ³  Motivo da Alteracao                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Carlos E. O.³04/10/13³M12RH01³Liberacao pra versao 12, inclusao de per-³±±
±±³        	   ³        ³RQ0317 ³guntas de relatório.                     ³±±     
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GPER520()

	Local oReport 
	Private cAlias := "SRA"

	Private cProcesso   := ""
	Private cRot := ""
	
	Private aFldRot 	:= {'RA_NOME'}
	Private aOfusca	 	:= If(FindFunction('ChkOfusca'), ChkOfusca(), {.T.,.F.}) //[1] Acesso; [2]Ofusca
	Private lOfuscaNom 	:= .F. 
	Private aFldOfusca	:= {} 

	If aOfusca[2]
		aFldOfusca := FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRot ) // CAMPOS SEM ACESSO
		IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_NOME" } ) > 0
			lOfuscaNom := FwProtectedDataUtil():IsFieldInList( "RA_NOME" )
		ENDIF
	ENDIF

	//-- Interface de impressao
	Pergunte("GP0520R",.F.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         ³
	//³--------------------------------------------------------------³		
	//³ mv_par01        //  Processo                                 ³
	//³ mv_par02        //  Roteiro                                  ³
	//³ mv_par03        //  Periodo                                  ³
	//³ mv_par04        //  Numero Pagamento                         ³
	//³ mv_par05        //  Filial                                   ³		
	//³ mv_par06        //  Centro Custo                             ³		
	//³ mv_par07        //  Matricula                                ³
	//³ mv_par08        //  Nome                                     ³
	//³ mv_par09        //  Situacoes                                ³
	//³ mv_par10        //  Categorias                               ³
	//³ mv_par11        //  CC em Outra Pag.                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cProcesso := mv_par01
	cRot := mv_par02
	
   	oReport := ReportDef()
	oReport:PrintDialog()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER520   ºAutor  ³Equipe - RH         º Data ³  12/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
	
Static Function ReportDef()

	Local oReport 
	Local oSection
	Local oBreakCc
	Local cDesc		:=	STR0001 + STR0002 + STR0003 		//"Rela‡„o de Liquidos." # 
	Local aOrd  	:= {STR0005,STR0004,STR0014,STR0015}	//"Matr¡cula"###"Centro de Custo"###"Nome"###"Centro de Custo + Nome"//
	
	DEFINE REPORT oReport NAME "GPER520" TITLE OemToAnsi(STR0009) PARAMETER "GP0520R" ACTION {|oReport| R520Imp(oReport)}  DESCRIPTION OemtoAnsi(STR0022) TOTAL IN COLUMN //"Ser  impresso de acordo com os parametros solicitados pelo" # //"usu rio."	
	DEFINE SECTION oSRA OF oReport TITLE OemToAnsi(STR0023) ORDERS aOrd TABLES "SRA" TOTAL IN COLUMN TOTAL  TEXT STR0021 

	DEFINE CELL NAME "FILIAL" 		OF oSRA TITLE "FILIAL" 								SIZE 12
	DEFINE CELL NAME "CC" 			OF oSRA TITLE "C.CUSTO"								SIZE 12
	DEFINE CELL NAME "MAT" 			OF oSRA TITLE "MATRICULA"							SIZE 12
	DEFINE CELL NAME "NOME" 		OF oSRA TITLE "NOME"								SIZE 25	
	DEFINE CELL NAME "BASE" 		OF oSRA TITLE STR0017 	PICTURE "@E 999,999.99" 	SIZE 12 
	DEFINE CELL NAME "BENEF" 		OF oSRA TITLE STR0018  	PICTURE "@E 999,999.99" 	SIZE 12 
	DEFINE CELL NAME "EMPRESA" 		OF oSRA TITLE STR0013 	PICTURE "@E 999,999.99" 	SIZE 12 
	DEFINE CELL NAME "CUSTO" 		OF oSRA TITLE STR0019	PICTURE "@E 999,999.99" 	SIZE 12

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER520   ºAutor  ³Microsiga           º Data ³  09/13/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R520Imp(oReport)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Declaracao de variaveis                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//-- Objeto
	Local oSection 	:= oReport:Section(1)    
	Local oBreakCc
	
	//-- Array
	Local aCodFol		:= {}
	Local aPerAberto    := {}
	Local aPerFechado   := {}
	Local aPerTodos     := {}
	
	//-- String
	Local cOrdem		:= ""
	Local cSitQuery		:= ""
	Local cCatQuery		:= ""
	Local cWhere		:= ""  	
	Local cTitCC		:= ""
	Local cJoinMov		:= ""
	Local cMoviment		:= ""
	Local cCpoAdic		:= ""
	Local cFilialAnt	:= ""
	Local cCCustoAnt	:= ""
	Local cMatAnt		:= ""
	Local cNomeAnt		:= ""	
	Local cMes			:= ""
	Local cAno			:= ""
	Local cNameDB		:= Upper(TcGetDb())
	Local cCampo		:= ""
	Local cCpoPD		:= ""
	 

	//-- Numerico
	Local nReg			:= 0
	Local nRegs			:= 0   	   
	Local nOrdem		:= oSection:GetOrder()
	Local nBasSeg	 	:= 0
	Local nCusBen 		:= 0
	Local nCusEmp   	:= 0
	Local nPosAb		:= 0 
	Local nPosFc		:= 0
	Local nLinha		:= 0	
	Local nCont			:= 0	
	
	//-- Logicas (booleanas)
	Local lEndReport	:= .T.
	Local lPagAtual		:= .T.	

	// Variaveis auxiliares
	Private lAberto		:= .T.
	Private lFechado	:= .T.
	Private cAliasMov 	:= ""
			
	//-- Private Array
	Private aInfo		:= {}
	
	//-- Variaveis de Acesso do Usuario                               
	Private cAcessaSRA	:= &( " { || " + ChkRH( "GPER520" , "SRA" , "2" ) + " } " )
	
	//-- Pega conteudo das perguntas do grupo GP0520R
	Private cProcesso	:= MV_PAR01		//Processo
	Private cRot	:= MV_PAR02		//Roteiro
	Private cPeriodo	:= MV_PAR03		//Periodo
	Private cNrPagto	:= MV_PAR04     //Nro. Pagamento
	Private cFil		:= MV_PAR05		//Filial			
	Private cCCusto		:= MV_PAR06		//Centro Custo
	Private cMatricula	:= MV_PAR07		//Matricula Funcionario
	Private cNome		:= MV_PAR08		//Nome Funcionario
	Private cSituacao	:= MV_PAR09		//Situacao Funcionario 
	Private cCategoria	:= MV_PAR10		//Categoria Funcionario
	Private lSalta		:= If( MV_PAR11 == 1 , .T. , .F. ) //Salta Pagina Quebra C.Custo
		
	//----------- Trabalhando com a quebra
	If nOrdem == 2 .Or. nOrdem == 4 
		lPagAtual := lSalta // centro de custo
	
		DEFINE BREAK oBreakCc  OF oSection   WHEN  oSection:Cell("CC" ) TITLE OemToAnsi(STR0016) + " " + OemToAnsi(STR0020) //"Total do Centro de Custo "		
		oBreakCc:SetpageBreak(lPagAtual)
	
	Endif
	
	DEFINE FUNCTION FROM oSection:Cell("BASE") 		FUNCTION SUM  BREAK oBreakCC  TITLE STR0017 PICTURE "@E 999,999,999.99"  //NO END SECTION  NO END REPORT
	DEFINE FUNCTION FROM oSection:Cell("BENEF") 	FUNCTION SUM  BREAK oBreakCC  TITLE STR0018 PICTURE "@E 999,999,999.99"  //NO END SECTION  NO END REPORT
	DEFINE FUNCTION FROM oSection:Cell("EMPRESA") 	FUNCTION SUM  BREAK oBreakCC  TITLE STR0013	PICTURE "@E 999,999,999.99"  //NO END SECTION  NO END REPORT 
	DEFINE FUNCTION FROM oSection:Cell("CUSTO") 	FUNCTION SUM  BREAK oBreakCC  TITLE STR0019 PICTURE "@E 999,999,999.99"  //NO END SECTION  NO END REPORT
		
	cAno	:= SubStr(cPeriodo,1,4)		
    cMes	:= SubStr(cPeriodo,5,2) 
    fRetPerComp( 	cMes		  ,;	// Obrigatorio - Mes para localizar as informacoes
					cAno		  ,;	// Obrigatorio - Ano para localizar as informacoes
					xFilial("RCH"),;	// Opcional - Filial a Pesquisar
					cProcesso	  ,;	// Opcional - Filtro por Processo
				   	cRot	  ,;	// Opcional - Filtro por Roteiro
				   	@aPerAberto	  ,;	// Por Referencia - Array com os periodos Abertos
					@aPerFechado, ;		// Por Referencia - Array com os periodos Fechados
					@aPerTodos    ;		// Por Referencia - Array com os periodos Abertos e Fechados em Ordem Crescente
				)  
    nPosAb	:= 	aScan(aPerAberto, {|x|  x[1]+x[2]+x[7]+x[8] == cPeriodo + cNrPagto + cProcesso + cRot })
    lAberto	:= 	If(nPosAb == 0, .F., .T.)
    nPosFc	:=	aScan(aPerFechado, {|x|  x[1]+x[2]+x[7]+x[8] == cPeriodo + cNrPagto + cProcesso + cRot })
    lFechado:= 	If(nPosFc == 0, .F., .T.)
	// Verifica se existe o arquivo do periodo 
  	If  !lAberto .And. !lFechado		 
		MsgAlert( OemToAnsi( STR0025 ), OemToAnsi( STR0024 ) ) //"Periodo nao calculado!"###"Atencao"  		
		Return (.F.) 
	EndIf  
	
	If( lAberto, cAliasMov	:= "SRC", cAliasMov := "SRD")
	   
	If lAberto
		cAcessa := &("{ || " + ChkRH("GPER520","SRC","2") + "}") 
	Else 
		cAcessa := &("{ || " + ChkRH("GPER520","SRD","2") + "}") 
	EndIf
	
	//-- Modifica variaveis para a Query
	For nReg:=1 to Len(Trim(cSituacao))
		cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
		If ( nReg+1 ) <= Len(Trim(cSituacao))
			cSitQuery += "," 
		Endif
	Next nReg     
	
	For nReg:=1 to Len(Trim(cCategoria))
		cCatQuery += "'"+Subs(cCategoria,nReg,1)+"'"
		If ( nReg+1 ) <= Len(Trim(cCategoria))
			cCatQuery += "," 
		Endif
	Next nReg
	
	cJoinMov := "% INNER JOIN " + RetSQLName(cAliasMov) + " " + cAliasMov + " ON "

	If cAliasMov == "SRC"
		cCpoAdic := "%, SRC.RC_PD, SRC.RC_VALOR %"
		cJoinMov += " SRA.RA_MAT = SRC.RC_MAT "
		cJoinMov += " AND SRA.RA_FILIAL = SRC.RC_FILIAL "
	Else
		cCpoAdic := "%, SRD.RD_PD, SRD.RD_VALOR %"	
		cJoinMov += " SRA.RA_MAT = SRD.RD_MAT"
		cJoinMov += " AND SRA.RA_FILIAL = SRD.RD_FILIAL "
	Endif
	
	cJoinMov += " INNER JOIN " + RetSqlName("SRV") + " SRV ON "
	
	If cAliasMov == "SRC"
		cJoinMov += " SRV.RV_COD = SRC.RC_PD AND SRV.RV_CODFOL IN ('0153','0154','0155') AND "
		cJoinMov += FwJoinFilial("SRV","SRC")
	Else
		cJoinMov += " SRV.RV_COD = SRD.RD_PD AND SRV.RV_CODFOL IN ('0153','0154','0155') AND "
		cJoinMov += FwJoinFilial("SRV","SRD")
	EndIf
	cJoinMov += " %"
		
	If !Empty(AllTrim(cProcesso))
		cWhere := " SRA.RA_PROCES ='" + cProcesso + "' "
		
		If !Empty(AllTrim(cSitQuery))
			cWhere += "AND SRA.RA_SITFOLH IN (" + cSitQuery + ")" 	
		Endif
		
		If !Empty(AllTrim(cCatQuery))
			cWhere += "AND SRA.RA_CATFUNC IN (" + cCatQuery + ")"	
		Endif
		
		If !Empty(AllTrim(cRot))
			cWhere += "AND "	

			If cAliasMov == "SRC"
				cWhere += "SRC.RC_ROTEIR='" + cRot + "'"
				cWhere += " AND "	
				cWhere += "SRC.RC_PERIODO='" + cPeriodo + "'"
				cWhere += " AND "
				cWhere += "SRC.RC_SEMANA='" + cNrPagto + "'"
				
			Else
				cWhere += "SRD.RD_ROTEIR='" + cRot + "'"
				cWhere += " AND "	
				cWhere += "SRD.RD_PERIODO='" + cPeriodo + "'"
				cWhere += " AND "	
				cWhere += "SRD.RD_SEMANA='" + cNrPagto + "'"
			Endif
		Endif
				  
	Endif
	cWhere := "%" + cWhere + "%"
	
	//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr("GP0520R")					
		
	//"Matr¡cula"###"Centro de Custo"###"Nome"###"Centro de Custo + Nome"//
	If nOrdem == 1
		cOrdem := "%RA_FILIAL,RA_MAT%"
	ElseIf nOrdem == 2
		cOrdem := "%RA_FILIAL,RA_CC,RA_MAT%"
	ElseIf nOrdem == 3
		cOrdem := "%RA_FILIAL,RA_NOME%"
	Elseif nOrdem == 4
		cOrdem := "%RA_FILIAL,RA_CC,RA_NOME%"
	Endif	
			
	cMoviment := GetNextAlias()	
	BEGIN REPORT QUERY oSection

		//Trazer todos movimentos da SRC/SRD conforme parametros
	 	//selecionados (Processo/Roteiro/Periodo/Nro Pagto	
		BeginSql Alias cMoviment
		
			%noparser%              
	
			SELECT SRA.RA_FILIAL, SRA.RA_MAT, SRA.RA_NOME, SRA.RA_CC %exp:cCpoAdic% 
			FROM %table:SRA% SRA
			%exp:cJoinMov% /*AND %exp:FWxFilial("SQB")%*/
			WHERE %exp:cWhere%
				AND SRA.%notDel%
			ORDER BY %exp:cOrdem%
					 
		EndSql       
	
	END REPORT QUERY oSection PARAM MV_PAR05, MV_PAR06, MV_PAR07, MV_PAR08

	(cMoviment)->(dbGoTop())
	While !(cMoviment)->(Eof())
		nRegs++
		(cMoviment)->(dbSkip())
	Enddo
		
	//-- Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter(nRegs)  
	
	cFilialAnt := cFilAnt
	
	Fp_CodFol( @aCodFol, cFilialAnt, .T. )

	oSection:Init()

	(cMoviment)->(dbGoTop())	
	
	If !(cMoviment)->(EOF())
		cCCustoAnt := (cMoviment)->(RA_CC)		
		cMatAnt := (cMoviment)->RA_MAT
		cNomeAnt := If(lOfuscaNom,Replicate('*',15),(cMoviment)->(RA_NOME))
		
		oSection:Cell("FILIAL"):SetValue(cFilialAnt)
		oSection:Cell("CC"):SetValue(cCCustoAnt)					
	Endif
	
	While !(cMoviment)->(EOF())
	
		//-- Incrementa a régua da tela de processamento do relatório
	  	oReport:IncMeter()
	                                
		//-- Verifica se o usuário cancelou a impressão do relatorio
		If oReport:Cancel()
			Exit
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Consiste controle de acessos e filiais validas               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !((cMoviment)->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA) .Or. !Eval(cAcessa)
			(cMoviment)->( dbSkip() )
			Loop
		EndIf		
		
		If (cMoviment)->(RA_MAT) != cMatAnt .Or. (cMoviment)->RA_FILIAL != cFilialAnt
					  
			oSection:Cell("FILIAL"):SetValue(cFilialAnt)
			oSection:Cell("CC"):SetValue(cCCustoAnt)			
			oSection:Cell("MAT"):SetValue(cMatAnt)
			oSection:Cell("NOME"):SetValue(cNomeAnt)									
			oSection:Cell("BASE"):SetValue(nBasSeg)
			oSection:Cell("EMPRESA"):SetValue(nCusEmp)		  
			oSection:Cell("BENEF"):SetValue(nCusBen)
			oSection:Cell("CUSTO"):SetValue(nCusEmp+nCusBen)			
			nBasSeg := 0
			nCusEmp := 0
			nCusBen := 0
			oSection:PrintLine()
			
			If (cMoviment)->(RA_MAT) != cMatAnt //Mudou o funcionario				
				cMatAnt := (cMoviment)->(RA_MAT)
				cNomeAnt := If(lOfuscaNom,Replicate('*',15),(cMoviment)->(RA_NOME))			
			Endif
			
			If (cMoviment)->RA_FILIAL != cFilialAnt //Mudou a filial
				Fp_CodFol( @aCodFol, (cMoviment)->RA_FILIAL, .T. )
				cFilialAnt := (cMoviment)->RA_FILIAL
				//-- Finaliza impressão											
				oSection:Finish()
				//-- Incializa impressão				
				oSection:Init()				
			Endif						
		Endif						               	    
	    
	    cCampo := If(cAliasMov == "SRC", "RC_VALOR", "RD_VALOR")
	    cCpoPD := If(cAliasMov == "SRC", "RC_PD", "RD_PD")
	                            	
		If (cMoviment)->&cCampo > 0
			Do Case 
				Case Trim((cMoviment)->&cCpoPD) == aCodFol[155,1]
					nBasSeg += (cMoviment)->&cCampo
				Case Trim((cMoviment)->&cCpoPD) == aCodFol[153,1]
					nCusBen += (cMoviment)->&cCampo
				Case Trim((cMoviment)->&cCpoPD) == aCodFol[154,1]
					nCusEmp += (cMoviment)->&cCampo
			EndCase
		Endif
	  
		cCCustoAnt := (cMoviment)->(RA_CC)
		(cMoviment)->(dbSkip())  
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza impressao inicializada pelo metodo Init             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection:Cell("FILIAL"):SetValue(cFilialAnt)
	oSection:Cell("CC"):SetValue(cCCustoAnt)			
	oSection:Cell("MAT"):SetValue(cMatAnt)
	oSection:Cell("NOME"):SetValue(cNomeAnt)									
	oSection:Cell("BASE"):SetValue(nBasSeg)
	oSection:Cell("EMPRESA"):SetValue(nCusEmp)		  
	oSection:Cell("BENEF"):SetValue(nCusBen)
	oSection:Cell("CUSTO"):SetValue(nCusEmp+nCusBen)
	oSection:PrintLine()					
	oSection:Finish()
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Termino do relatorio                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( cAliasMov )
	dbSetOrder(1)
	
Return Nil
