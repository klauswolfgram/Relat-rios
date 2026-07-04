/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR120.CH"
#INCLUDE "PONCALEN.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PONR120  ³ Autor ³ MAURICIO MR           ³ Data ³ 20.12.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Controle de Visitantes                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR120(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia C.  ³21/05/14³TPQAN3³Incluido o fonte da 11 para a 12 e efetua-³±± 
±±³            ³        ³      ³da a limpeza.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PONR120()

Private aInfo      := {}
Private cFAnt		 := ""
Private cAliasSRA	 := "SRA"
Private cAliasSPW  := "SPW"
Private cAliasSPY  := "SPY"
Private cAliasSPZ  := "SPZ"
Private nTamMat   := GetSx3Cache( "PY_MAT", "X3_TAMANHO" )    

 	//-- Interface de impressao
	Pergunte("PN120R",.F.)
  	oReport := ReportDef()
	oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ R.H. - Tatiane Matias ³ Data ³ 11.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do relatorio                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
                                  
//-- Objeto Relatorio
Local oReport  

//-- Objeto Section
Local oSection1
Local oSection2
Local oSection3
Local oSection4

Local aOrd	:= {STR0004 , STR0005 } // 'Visitante'###'Nome+Sobrenomes'
Local cDesc	:=	STR0001 + " "+STR0002+" "+ STR0003 // 'Relatorio de Visitantes' # "Ser  impresso de acordo com os parametros solicitados pelo" # "usuario."

Local nTamNome	:= GetSx3Cache( "PY_NOME", "X3_TAMANHO" )    
Local nDataE	:= GetSx3Cache( "PY_DATAE", "X3_TAMANHO" )
Local nTitDtE  := Len(GetSx3Cache( "PY_DATAE", "X3_TITULO" ))
Local nTam		:= If(nDataE < nTitDtE , nTitDtE, nDataE)

	//-- Inicio definicao do Relatorio
	DEFINE REPORT oReport NAME "PONR120" TITLE OemToAnsi(STR0001) PARAMETER "PN120R" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION cDesc TOTAL IN COLUMN
                                     
		//-- Section de Empresa e Filial
		DEFINE SECTION oSection1 OF oReport TITLE STR0020 ORDERS aOrd TOTAL IN COLUMN
		oSection1:SetHeaderBreak(.T.)
 		oSection1:SetLineStyle(.T.)

			DEFINE CELL NAME "M0_NOME" OF oSection1  TITLE STR0020 BLOCK {||SM0->M0_NOME} SIZE 20
			DEFINE CELL NAME "FILIAL" 	OF oSection1  TITLE STR0016 BLOCK {|| AllTrim(cFAnt) + ' - ' + AllTrim(ainfo[1])} SIZE 40

			oSection1:Cell("M0_NOME"):SetCellBreak(.T.)

		//-- Section de Visitantes
		DEFINE SECTION oSection2 OF oReport TABLES "SPW" TITLE STR0017 TOTAL IN COLUMN
		oSection2:SetHeaderBreak(.T.)
				                                                   
			DEFINE CELL NAME "PW_VISITA" 	OF oSection2 ALIAS "SPW"
			DEFINE CELL NAME "PW_NOMFULL" OF oSection2 ALIAS "SPW"
			
			//-- Section de Cracha e data
			DEFINE SECTION oSection3 OF oSection2 TABLES "SPY" TITLE STR0027 TOTAL IN COLUMN
				                                                   
				DEFINE CELL NAME "PY_CRACHA" 	OF oSection3 ALIAS "SPY"
				DEFINE CELL NAME "PY_DTVISIT" OF oSection3 ALIAS "SPY"

				//-- Section de Visitas
				DEFINE SECTION oSection4 OF oSection3 TABLES "SPY","SRA", "CTT" TITLE STR0024 TOTAL IN COLUMN
	  			oSection4:SetHeaderPage()
				                                                   
					DEFINE CELL NAME "PY_CRACHA" 	OF oSection4 ALIAS "SPY" 
					DEFINE CELL NAME "PY_DTVISIT" OF oSection4 ALIAS "SPY" 
					DEFINE CELL NAME "PY_DATAE" 	OF oSection4 ALIAS "SPY" 
					DEFINE CELL NAME "PY_ENTRADA"	OF oSection4 ALIAS "SPY" BLOCK {|| StrTran(StrZero((cAliasSPY)->PY_ENTRADA,5,2),'.',':') } PICTURE "" 
					DEFINE CELL NAME "PY_DATAS"	OF oSection4 ALIAS "SPY"
					DEFINE CELL NAME "PY_SAIDA"	OF oSection4 ALIAS "SPY" BLOCK {|| StrTran(StrZero((cAliasSPY)->PY_SAIDA,5,2),'.',':') } PICTURE ""
					DEFINE CELL NAME "PY_DTBAIXA"	OF oSection4 ALIAS "SPY"
					DEFINE CELL NAME "PY_MAT"		OF oSection4 ALIAS "SPY" BLOCK {|| If(Empty((cAliasSPY)->PY_MAT), Replicate('X',nTamMat), (cAliasSPY)->PY_MAT )}
					DEFINE CELL NAME "RA_NOME"		OF oSection4 ALIAS "SRA" BLOCK {|| If(Empty((cAliasSPY)->PY_MAT), Replicate('X',13), (cAliasSRA)->RA_NOME)} SIZE nTamNome
					DEFINE CELL NAME "RA_CC"		OF oSection4 ALIAS "SRA" BLOCK {|| If(Empty((cAliasSPY)->PY_MAT), (cAliasSPY)->PY_CC, (cAliasSRA)->RA_CC)}
					DEFINE CELL NAME "CTT_DESC01"	OF oSection4 ALIAS "CTT" BLOCK {|| If(Empty((cAliasSPY)->PY_MAT), fDesc("CTT",(cAliasSPY)->PY_CC,"CTT_DESC01",,(cAliasSPW)->PW_FILIAL ) , CTT->CTT_DESC01)}
			                       
					//-- Posiciona a tabela de funcionarios
					TRPosition():New(oSection4, "SRA", 1, {|| fFilfunc('SRA') + (cAliasSPY)->PY_MAT })
					TRPosition():New(oSection4, "CTT", 1, {|| RHFilial('CTT',(cAliasSRA)->RA_FILIAL) + (cAliasSRA)->RA_CC})

					//-- Section de Acessos
					DEFINE SECTION oSection5 OF oSection4 TABLES "SPZ" TITLE STR0025 TOTAL IN COLUMN
					oSection5:SetLeftMargin(25)
					
						DEFINE CELL NAME "PZ_DATA"		OF oSection5 ALIAS "SPZ" TITLE STR0025 SIZE nTam
						DEFINE CELL NAME "PZ_HORA"		OF oSection5 ALIAS "SPZ" TITLE ""		BLOCK {|| StrTran(StrZero((cAliasSPZ)->PZ_HORA,5,2),'.',':') } PICTURE ""
						DEFINE CELL NAME "PZ_RELOGIO"	OF oSection5 ALIAS "SPZ" TITLE STR0026

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrintReport³ Autor ³ R.H. - Tatiane Matias   ³ Data ³ 08.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Liquidos - Relatorio Personalizavel                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis Locais                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- Numerico
Local nOrdem   	 := oReport:Section(1):GetOrder()
Local nCont			 := 0

//-- Objeto
Local oSection1 	 := oReport:Section(1)		//Empresa e Filial
Local oSection2 	 := oReport:Section(2)	  	//Visitantes
Local oSection3 	 := oSection2:Section(1)	//Cracha e Data
Local oSection4 	 := oSection3:Section(1)	//Visitas
Local oSection5 	 := oSection4:Section(1)	//Acessos

//-- String
Local cFiltro		 := ""
Local oBreakFil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis Privates                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- String
Private cSit       := ''
Private cTpVis     := ''

//-- Logica
Private lAcessos   := .F.

//-- Numerico
Private nHoraDe    := 00.00
Private nHoraAte   := 23.59
Private nStatusVis := 3
Private nTamVis  	 := GetSx3Cache( "PY_VISITA ", "X3_TAMANHO" )
Private nSerIni	 := 0
Private nSerFim	 := 0
Private lCond      := .T.

	cSit       := MV_PAR04                   
	lAcessos   := If(MV_PAR06=1,.T.,.F.) 
	nHoraDe    := MV_PAR07
	nHoraAte   := MV_PAR08   
	cTpVis     := Alltrim(Str(MV_PAR09))
	nStatusVis := MV_PAR10

	If !(oReport:nDevice == 4 .And. cValToChar(oReport:nExcelPrintType) $ "3*4")
		//-- Quebrar por Filial
		DEFINE BREAK oBreakFil OF oReport WHEN {||(cAliasSPW)->PW_FILIAL} 
		oBreakFil:SetPageBreak()
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz filtro no arquivo...                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cAliasSPW := GetNextAlias()
	cAliasSPY := cAliasSPW
	cAliasSPZ := cAliasSPW

	//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr("PN120R")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Modifica variaveis para a Query                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//-- Situacao do Funcionario
	cSitQuery := "" 
	For nCont:=1 to Len(cSit)
		cSitQuery += "'"+Subs(cSit,nCont,1)+"'"
		If ( nCont+1 ) <= Len(cSit)
			cSitQuery += "," 
		Endif
	Next nCont     
	cSitQuery := "%" + cSitQuery + "%"
	
	cFiltro := ""
	If cTpVis <> '3'
		cFiltro += "SPY.PY_TIPOVIS = '" + cTpVis + "' AND "
	Endif 
			
	//-- Verifica Status da Visita
	If nStatusVis == 1
		cFiltro += " SPY.PY_DTBAIXA = ' ' AND "  
	ElseIf nStatusVis == 2
		cFiltro += " SPY.PY_DTBAIXA <> ' ' AND "  
	EndIf
             
	//-- Verifica Horarios (ATENCAO: Nao Fazer Data + Horas)
	cFiltro += "SPY.PY_ENTRADA >= " + Alltrim(Str(nHoraDe)) + " AND "
	cFiltro += "SPY.PY_SAIDA   <= " + Alltrim(Str(nHoraAte))

	cFiltro := "%" + cFiltro + "%"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta string de ordenacao                                          		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOrdem == 1
		cOrdem := "%PW_FILIAL, PW_VISITA, PY_DTVISIT, PY_CRACHA, PY_NUMERO, PZ_DATA, PZ_HORA%"
	Else
		cOrdem := "%PW_FILIAL, PW_NOMFULL, PY_DTVISIT, PY_CRACHA, PY_NUMERO, PZ_DATA, PZ_HORA%"
	EndIf
	
	BEGIN REPORT QUERY oSection2
                   
		BeginSql alias cAliasSPW   
		
			SELECT PW_FILIAL, PW_VISITA, PW_NOMFULL, PW_SITVIST, PY_FILIAL, PY_CRACHA, PY_VISITA, 
			       PY_DTVISIT, PY_DATAE, PY_ENTRADA, PY_DATAS, PY_SAIDA, PY_DTBAIXA, PY_MAT, 
					 PY_CC, PZ_FILIAL, PZ_CRACHA, PZ_DATA, PZ_HORA, PZ_RELOGIO
			FROM %table:SPW% SPW
			INNER JOIN %table:SPY% SPY
			ON		SPW.PW_FILIAL = SPY.PY_FILIAL AND
   					SPW.PW_VISITA = SPY.PY_VISITA
			LEFT JOIN %table:SPZ% SPZ
			ON 	SPW.PW_FILIAL = SPZ.PZ_FILIAL AND
   					SPY.PY_CRACHA = SPZ.PZ_CRACHA AND
   					SPZ.PZ_DATA between SPY.PY_DATAE AND SPY.PY_DATAS AND
				 	SPZ.%notDel%
			WHERE
		   		SPW.PW_SITVIST IN (%exp:Upper(cSitQuery)%) 	AND
			    	%exp:cFiltro%		AND
				 	SPW.%notDel% 		AND 
				 	SPY.%notDel% 		
			ORDER BY %exp:cOrdem%
			
  		EndSql

	/*
	Prepara relatorio para executar a query gerada pelo Embedded SQL passando como 
	parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados 
	pela funcao MakeSqlExpr para serem adicionados a query
	*/
	END REPORT QUERY oSection2 PARAM MV_PAR01, MV_PAR02, MV_PAR03, MV_PAR05
                    
	oSection3:SetParentQuery()
	oSection4:SetParentQuery()
	oSection5:SetParentQuery()

	//-- Condicao de relacionamento da secao filha em relacao a sua secao pai
	//-- Filial e visitante da tabela de visitantes (SPW) com a tabela de visitas (SPY)
	oSection3:SetParentFilter({|cParam| (cAliasSPY)->PY_FILIAL + (cAliasSPY)->PY_VISITA == cParam},{|| (cAliasSPW)->PW_FILIAL + (cAliasSPW)->PW_VISITA})

	//-- Condicao de relacionamento da secao filha em relacao a sua secao pai
	//-- Filial e visitante da tabela de visitantes (SPW) com a tabela de visitas (SPY)
	oSection4:SetParentFilter({|cParam| (cAliasSPY)->PY_FILIAL + (cAliasSPY)->PY_VISITA + DTOS((cAliasSPY)->PY_DTVISIT) + (cAliasSPY)->PY_CRACHA == cParam},{|| (cAliasSPY)->PY_FILIAL + (cAliasSPY)->PY_VISITA + DTOS((cAliasSPY)->PY_DTVISIT) + (cAliasSPY)->PY_CRACHA})
                                                                                          
	//-- Condicao de relacionamento da secao filha em relacao a sua secao pai
	//-- Filial e cracha da tabela de visitas (SPY) com a tabela de acessos (SPZ)
	oSection5:SetParentFilter({|cParam| (cAliasSPZ)->PZ_FILIAL + (cAliasSPZ)->PZ_CRACHA == cParam},{|| (cAliasSPY)->PY_FILIAL + (cAliasSPY)->PY_CRACHA })

	oSection3:Hide()
	If lAcessos                    
		oSection5:Enable()
	Else
		oSection5:Hide()
	EndIf

	cFAnt 	:= (cAliasSPW)->PW_FILIAL

	//-- Impressao na quebra de pagina - Impressao das informacoes da Empresa e Filial
	fInfo( @aInfo , cFAnt )

	//-- Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter((cAliasSPW)->( RecCount() ))  

	oSection1:SetIdxOrder(1)
 	oReport:OnPageBreak({|| oReport:SkipLine(), oSection1:Init(),oSection1:PrintLine(),oSection1:Finish(), oReport:ThinLine(), oReport:SkipLine() },.T.)

	oSection2:SetLineCondition({|| fCondSPW() })

	If lAcessos                    
		oSection4:SetLineCondition({|| fCondSPY() })
		oSection5:SetLineCondition({|| fCondSPZ() })
	EndIf

	//-- Impressao do Relatorio
	oSection2:Print()

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCondSPW   ³ Autor ³ R.H. - Tatiane Matias   ³ Data ³ 11.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se a linha deve ser impressa                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCondSPW()                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCondSPW()

Local lRetorno	:= .T.
Local cAcessaSPW 	:= &("{ || " + ChkRH("PONR120",'SPW',"2") + "}")

	 //-- Verifica a quebra de Filial
	IF !( cFAnt == (cAliasSPW)->PW_FILIAL ) .And. lRetorno
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Atualiza o Filial Anterior								   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		cFAnt := (cAliasSPW)->PW_FILIAL  
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Incrementa a Barra de Gauge      					     	   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/ 
		fInfo( @aInfo , cFAnt )
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas				 |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If !((cAliasSPW)->PW_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSPW)
    	lRetorno := .F.
    EndIf

Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCondSPZ   ³ Autor ³ R.H. - Tatiane Matias   ³ Data ³ 16.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se a linha deve ser impressa                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCondSPZ()                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCondSPZ()

Local lRetorno	:= .T.

	( cAliasSPZ )->(	nSerAcess := __fDHtoNS( &( "PZ_DATA" ),&( "PZ_HORA" ) ))

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Obtem todas as Marcacoes Posteriores a Data de Entrada para o³
	³ Cracha corrente se Nao foi dada a Baixa da Visita			   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If Empty(nSerFim) 
		If !(nSerAcess >=nSerIni)		
			lRetorno := .F.
		Endif	
	Else                                                              
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Obtem todas as Marcacoes do Cracha Para o Periodo de Duracao ³
		³ da Visita													   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If (nSerAcess < nSerIni .OR. nSerAcess > nSerfim)		
			lRetorno := .F.
		EndIF
	EndIF

Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCondSPY   ³ Autor ³ R.H. - Tatiane Matias   ³ Data ³ 16.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se a linha deve ser impressa                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCondSPY()                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCondSPY()

Local lRetorno	:= .T.
Local dPerFim
Local nHorFim
	                                                                    
	dPerFim := If(Empty((cAliasSPY)->PY_DATAS), dDataBase, (cAliasSPY)->PY_DATAS) 
   nHorFim := If(Empty((cAliasSPY)->PY_DATAS), VAL(StrTran(Substr(time(),1,5),":",".")), (cAliasSPY)->PY_SAIDA)
	
	nSerIni:= __fDHtoNS((cAliasSPY)->PY_DATAE, (cAliasSPY)->PY_ENTRADA)
	nSerFim:= __fDHtoNS(dPerFim, nHorFim)

Return lRetorno
