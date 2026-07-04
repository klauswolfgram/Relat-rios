/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR060.CH"
#INCLUDE "PONCALEN.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ PONR060  ³ Autor ³ R.H. - J. Ricardo     ³ Data ³ 12.08.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Autorizacao do Pagamento de Horas Extras                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR060(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Leandro Dr. ³14/04/14³      ³Retirada de ajustes, database e FieldPos  ³±±
±±³            ³        ³      ³que nao serao utilizados na P12.		  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PONR060()
Local	oReport   
Local	aArea 		:= GetArea()
Private cPerg		:= "PN060R"

Pergunte(cPerg,.F.) 

oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ ReportDef  ³ Autor ³ Totvs IP RH           ³ Data ³12/04/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Autorizacao do Pagamento de Horas Extras                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PONR060                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR060 - Generico                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport 
Local oSection1 
Local oSection2 
Local bBlkFil := { || If ( cCodFilial != (cAliasQry)->RA_FILIAL, Eval( { || fInfo(@aInfo,(cAliasQry)->RA_FILIAL), aInfo[3] } ), aInfo[1] ) }
Local aOrd    := {STR0004 ,STR0005 ,STR0006 ,STR0007, STR0020 } // 'Matricula'###'Centro de Custo'###'Nome'###'Turno'###'C.Custo+Nome'
Private cTitulo		:= OemToAnsi(STR0001)			// 'Relatorio para Autorizacao do Pagamento de Horas Extras'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao dos componentes de impressao                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "PONR060" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PN060Imp(oReport)} DESCRIPTION OemtoAnsi(STR0038) TOTAL IN COLUMN // "Este programa emite Relatorio para Autorizacao do Pagamento de Horas Extras"

	oSection1 := TRSection():New( oReport, OemToAnsi(STR0030), {"SRA","CTT","SR6"}, aOrd,,,,,.F.,.F.,.F.) // "Funcionarios"


		TRCell():New(oSection1,"RA_FILIAL","SRA",,/*Picture*/,8,/*lPixel*/,{|| 	If(!Empty((cAliasQry)->RA_FILIAL),;
																								cCodFilial:= (cAliasQry)->RA_FILIAL,;
																								NIL),;
																								cCodFilial}	)
		TRCell():New(oSection1,"FILIAL","",OemToAnsi(STR0031),/*Picture*/,20,/*lPixel*/,{|| Eval( bBlkFil ) })	// "Desc.Filial"

		TRCell():New(oSection1,"RA_CHAPA"	,"SRA",,,5)
		TRCell():New(oSection1,"RA_MAT"		,"SRA",,,6)
		TRCell():New(oSection1,"RA_NOME"	,"SRA",,,30,,,,.T.)
		TRCell():New(oSection1,"RA_CC"		,"SRA",OemToAnsi(STR0032),,9)				// "C.Custo"
		TRCell():New(oSection1,"CTT_DESC01"	,"CTT",OemToAnsi(STR0035),,25,,,,.T.) 		// "Descricao"
		TRCell():New(oSection1,"RA_TNOTRAB"	,"SRA",OemToAnsi(STR0033),,3)				// "Tno"
		TRCell():New(oSection1,"R6_DESC"	,"SR6",,,20,,,,.T.)

	oSection2 := TRSection():New( oSection1, OemToAnsi(STR0034),,,,,,,.F.,.F.,.F. )	 //"Marcações"
                                                                              
		TRCell():New( oSection2, "MARCACOES"   	, "" ,OemToAnsi(STR0034),,48,,,,.T.) 	// "Marcações"
		TRCell():New( oSection2, "DATA"     	, "" ,OemToAnsi(STR0040),,5)			// "Data 
		TRCell():New( oSection2, "CODIGO"     	, "" ,OemToAnsi(STR0039),,3) 			// "Cod" 
		TRCell():New( oSection2, "DESCRICAO"	, "" ,OemToAnsi(STR0035),,20,,,,.T.) 	// "Descricao"
		TRCell():New( oSection2, "HORAS"		, "" ,OemToAnsi(STR0036),,6) 			// "Horas"
		TRCell():New( oSection2, "VISTO"		, "" ,OemToAnsi(STR0037),,20) 			// "Visto"

		
Return(oReport)


Static Function PN060Imp(oReport)

Local oSection  := oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1)
Local cSitQuery := ""    
Local cCatQuery	:= ""  
Local nReg		:= 0
Local nOrdem	:= 1
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis de Acesso do Usuario                               ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Local cAcessaSRA	:= &( " { || " + ChkRH( "PONR060" , "SRA" , "2" ) + " } " )
Local cAcessaSPC 	:= &( " { || " + ChkRH( "PONR060" , "SPC" , "2" ) + " } " )
Local cCod029A	   	:= ''
Local cCod025A	   	:= ''
Local cCod038N		:= ''

Local aAutorizado  	:= {}
Local xQuant       	:= 0
Local nPos         	:= 0
Local cPD          	:= Space(03)
Local nTab	     	:= 0
Local nX		 	:= 0
Local nFor		 	:= 0
Local nPosCalend	:= 0
Local cOrdem	 	:= ""
Local cRealDet   	:= ""
Local cFilialAnt 	:= ""
Local cMatAnt	 	:= ""
Local cTurnoAnt	 	:= ""
Local cFilSRACTT	:= ""
Local cFilSRASR6	:= ""
Local lValdSP4		:= .F.

Local oBreakCc
Local oBreakFil
Local oBreakFun

Local lHeaderMar	:= .T.

Private aInfo		:= {}
Private cCodFilial	:= "##"

Private aDet       := {}
Private aMarcFun   := {}
Private aTabPadrao := {}
Private aTabCalend := {}
Private aMarcacoes := {}
Private nPosMarc   := 0 
Private nLenMarc   := 0

Private cAliasQry 	:= GetNextAlias()

Private cFilAnte   := ''
Private cSit     := ""
Private cCat     := ""
Private lCC      := .F.
Private dPerIni  := CTOD('  /  /  ')
Private dPerFim  := CTOD('  /  /  ')

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o periodo de Apura‡„o, de acordo com MV_PAPONTA ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !PerAponta(@dPerIni,@dPerFim)
	Return( NIL )
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        //  Filial  De                               ³
//³ MV_PAR02        //  Centro de Custo De                       ³
//³ MV_PAR03        //  Turno De                                 ³
//³ MV_PAR04        //  Matricula De                             ³
//³ MV_PAR05        //  Nome De                                  ³
//³ MV_PAR06        //  Situacao                                 ³
//³ MV_PAR07        //  Categoria                                ³
//³ MV_PAR08        //  Imprime C.C em outra Pagina              ³
//³ MV_PAR09        //  Dia Inicial                              ³
//³ MV_PAR10        //  Dia Final                                ³
//³ MV_PAR11        //  Autorizadas/Nao Autorizadas/Ambas        ³
//³ MV_PAR12        //  Relatorio Sintetico/Analitico            ³
//³ MV_PAR13        //  Quebra Func.Pag. Sim/Nao                 ³
//³ MV_PAR14        //  Imprimir Marca‡äes                       ³
//³ MV_PAR15        //  Regra De                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cSit      := MV_PAR06
cCat      := MV_PAR07
lCC       := If(MV_PAR08 == 1, .T., .F.)
dInicio   := MV_PAR09
dFim      := MV_PAR10
nTipHoras := MV_PAR11
nSinAna   := MV_PAR12
lImpFol	  := If(MV_PAR13 == 1,.T.,.F.)
lImpMar   := IF(MV_PAR14 == 1,.T.,.F.)

If MV_PAR09 > MV_PAR10
	Help(' ', 1, 'PNR050DATA')
	Return 
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega todas as tabelas de hor rio                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !fTabTurno(aTabPadrao)
	Return
EndIf

//-- Modifica variaveis para a Query
For nReg:=1 to Len(cSit)
	cSitQuery += "'"+Subs(cSit,nReg,1)+"'"
	If ( nReg+1 ) <= Len(cSit)
		cSitQuery += "," 
	Endif
Next nReg        
cSitQuery := "%" + cSitQuery + "%"

cCatQuery := ""
For nReg:=1 to Len(cCat)
	cCatQuery += "'"+Subs(cCat,nReg,1)+"'"
	If ( nReg+1 ) <= Len(cCat)
		cCatQuery += "," 
	Endif
Next nReg        
cCatQuery := "%" + cCatQuery + "%"

//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
MakeSqlExpr(cPerg)
	
BEGIN REPORT QUERY oSection

cFilSRACTT	:= "%" + FWJoinFilial("SRA", "CTT") + "%"
cFilSRASR6	:= "%" + FWJoinFilial("SRA", "SR6") + "%"	

nOrdem		:= oSection:GetOrder()
If nOrdem == 1
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_MAT%"
ElseIf nOrdem == 2
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_MAT%"
ElseIf nOrdem == 3
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_NOME,SRA.RA_MAT%"
ElseIf nOrdem == 4
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_TNOTRAB%"
ElseIf nOrdem == 5
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_NOME%"
Endif

cQryProcesso := "%(SRA.RA_DEMISSA = '          ' OR (SRA.RA_DEMISSA >= '"+DTOS(dPerIni) + "' AND  SRA.RA_DEMISSA <> '          '))%"
	
BeginSql alias cAliasQry
	SELECT SRA.RA_FILIAL, SRA.RA_CC, SRA.RA_MAT, SRA.RA_NOME, SRA.RA_TNOTRAB, SRA.RA_DEMISSA,SRA.RA_ADMISSA,SRA.RA_SITFOLH,
			SRA.RA_CHAPA,SRA.RA_SEQTURN,SRA.RA_REGRA,
		CTT.CTT_FILIAL, CTT.CTT_CUSTO, CTT.CTT_DESC01,
		SR6.R6_TURNO, SR6.R6_DESC
	FROM %table:SRA% SRA
	INNER JOIN %table:CTT% CTT ON RA_CC = CTT_CUSTO AND CTT.%NotDel% AND %exp:cFilSRACTT%
	INNER JOIN %table:SR6% SR6 ON RA_TNOTRAB = R6_TURNO AND SR6.%NotDel% AND %exp:cFilSRASR6%
	WHERE SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	AND
		  SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	AND
	      %exp:cQryProcesso% AND 
 	      SRA.%notDel%   
	ORDER BY %exp:cOrdem%
EndSql

END REPORT QUERY oSection PARAM mv_par01,mv_par02,mv_par03,mv_par04,mv_par05,mv_par15

DEFINE BREAK oBreakFil OF oSection WHEN {|| (cAliasQry)->RA_FILIAL }  TITLE OemToansi(STR0001) 
oBreakFil:SetPageBreak(.T.)
oBreakFil:SetHeaderBreak(.T.) 

DEFINE BREAK oBreakFun OF oSection WHEN {|| (cAliasQry)->RA_MAT }  TITLE OemToansi(STR0001) 
oBreakFun:SetHeaderBreak(.T.) 
If lImpFol
	oBreakFun:SetPageBreak(.T.) 
Endif
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Quebra de pagina C.Custo                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (nOrdem = 2 .or. nOrdem = 5) 
	DEFINE BREAK oBreakCc OF oSection WHEN {|| (cAliasQry)->RA_CC } TITLE OemToansi(STR0001) 
	If lCC 
		oBreakCc:SetPageBreak(.T.) 
		oBreakCc:SetHeaderBreak(.T.) 
	Endif 
ElseIf (nOrdem = 4) 
	DEFINE BREAK oBreakCc OF oSection WHEN {|| (cAliasQry)->RA_TNOTRAB } TITLE OemToansi(STR0001) 
	If lCC 
		oBreakCc:SetPageBreak(.T.) 
		oBreakCc:SetHeaderBreak(.T.) 
	Endif 
Endif 
oSection:SetHeaderSection(.T.)
oSection:SetHeaderBreak(.T.) 

oSection1:SetHeaderSection(.F.)
oSection1:SetHeaderBreak(.F.) 

oSection:lHeaderPage:=.F. 
oSection1:lHeaderPage:=.F. 

// Na quebra de pagina executa: Impressao da Linha do funcionario,pula linha,impressão do cabecalho das marcacoes, pula linha
oReport:OnPageBreak( {|| oReport:lOnPageBreak:= .F.,lHeaderMar := .T.,;
							If((oSection1:lPrinting ),;
								(oSection:PrintLine(),	;
									oReport:SkipLine(),;
									oSection1:SetHeaderSection(.T.),;
									oSection1:PrintHeader(),;
									oSection1:SetHeaderSection(.F.),;
									oReport:SkipLine();
								);
							,);
					 },.F. )

cFilAnte := (cAliasQry)->RA_FILIAL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a variavel aInfo com a filial Logada              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
fInfo(@aInfo,(cAliasQry)->RA_FILIAL)

aTabOPadrao  := {}
aTabOrigin   := {}
aTabCalend   := {}

If nSinAna == 1
	osection1:ACELL[1]:cTitle:=space(1)
	osection1:ACELL[2]:cTitle:=space(1)
Endif

//-- Define o total da regua da tela de processamento do relatorio
oReport:SetMeter( 100 )  

//-- Incializa impressao   
oSection:Init(.F.)                                                  

While !(cAliasQry)->( EOF() ) 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua de Processamento                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:IncMeter( 1 )   
	
	//-- Verifica se o usuário cancelou a impressão do relatorio
	If oReport:Cancel()
		Exit
	EndIf               
	
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Posiciona o registro da query na tabela de Funcionarios                ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If !SRA->(dbSeek( (cAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT ))
		(cAliasQry)->(DbSkip())
		Loop
	Endif
	
	//-- Processa quebra de Filial.
	If (cAliasQry)->RA_FILIAL != cFilAnte 
	    //--Somente "Zera" as variaveis se jah foi impresso algo para nao pula 
	    //--de pagina na primeira vez
		
		cFilAnte := (cAliasQry)->RA_FILIAL
		
		If !fInfo(@aInfo,(cAliasQry)->RA_FILIAL)
			Exit
		Endif	
		
	Endif
	
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Consiste Filiais e Acessos                                             ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF !( (cAliasQry)->RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA )
		(cAliasQry)->(DbSkip())
		Loop
	EndIF
	
	//-- Cria Calendario com o periodo completo com Trocas de Turno
	aTabCalend := {} ; aTurnos   := {} ; aMarcacoes := {}
	
	//-- Carrega as Marcacoes do Periodo
	IF !GetMarcacoes( @aMarcacoes		,;	//Marcacoes dos Funcionarios
					  @aTabCalend		,;	//Calendario de Marcacoes
					  @aTabPadrao		,;	//Tabela Padrao
					  @aTurnos			,;	//Turnos de Trabalho
					  dPerIni 			,;	//Periodo Inicial
					  dPerFim			,;	//Periodo Final
					  SRA->RA_FILIAL	,;	//Filial
					  SRA->RA_MAT		,;	//Matricula
					  SRA->RA_TNOTRAB	,;	//Turno
					  SRA->RA_SEQTURN	,;	//Sequencia de Turno
					  SRA->RA_CC		,;	//Centro de Custo
					  "SP8"				,;	//Alias para Carga das Marcacoes
					  .F.    			,;	//Se carrega Recno em aMarcacoes
					  .T.      			,;	//Se considera Apenas Ordenadas
					  .T.      			,;	//Se Verifica as Folgas Automaticas
					  .F.      			 ;	//Se Grava Evento de Folga Automatica Periodo Anterior
					)
		(cAliasQry)->(dbSkip())
		Loop
    EndIF
	
	//-- Obtem Qtde de Marcacoes
	nLenMarc:=Len(aMarcacoes)
	
	aDet := {}
	
	// 1 - Data
	// 2 - Codigo do Evento
	// 3 - Descricao do Evento
	// 4 - Quantidade de horas Abonadas
	// 5 - Marcacoes
	
	dRef:=CTOD("  /  /  ")
	
	cTiposTurno := TiposTurno(SRA->RA_TNOTRAB,  SRA->RA_FILIAL)
	
	dbSelectArea( "SPC" )
	dbSetOrder(2) // Filial + Matricula + Data
	If SPC->(DbSeek((cAliasQry)->RA_FILIAL + (cAliasQry)->RA_Mat ))
		While SPC->(!Eof()) .And. SPC->(PC_FILIAL + PC_MAT) == (cAliasQry)->(RA_FILIAL + RA_MAT)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Consiste controle de acessos e filiais validas               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SPC->( !Eval(cAcessaSPC) )
				SPC->(dbSkip())
				Loop
			EndIf
			
			//-- Verifica o Periodo Solicitado
			If Empty(SPC->PC_DATA) .OR. SPC->PC_DATA < dInicio .OR. SPC->PC_DATA > dFim
				DbSkip()
				Loop
			Endif
			
			If dRef != SPC->PC_DATA
				dRef := SPC->PC_DATA

				nPosCalend := Ascan(aTabCalend,{ |x| DtoS(x[CALEND_POS_DATA_APO]) == DtoS(dRef) })

				If nPosCalend > 0 .And. aTabCalend[nPosCalend, CALEND_POS_TURNO] <> cTurnoAnt
					cTurnoAnt := aTabCalend[nPosCalend, CALEND_POS_TURNO]
					lValdSP4 := .T.
				Else
					lValdSP4 := .F.
				EndIf

				If cMatAnt != (cAliasQry)->RA_MAT .Or. cFilialAnt != (cAliasQry)->RA_FILIAL .Or. lValdSP4
					If cMatAnt != (cAliasQry)->RA_MAT .Or. cFilialAnt != (cAliasQry)->RA_FILIAL
						cMatAnt   	:= (cAliasQry)->RA_MAT
						cFilialAnt	:= (cAliasQry)->RA_FILIAL
						aAutorizado	:= {}
					EndIf
					
					If SP4->(dbSeek(cFilSP4 := xFilial('SP4', SRA->RA_FILIAL)))
						While ! SP4->(Eof()) .And. cFilSP4 == SP4->P4_FILIAL 
							If(SP4->P4_TIPO $ cTiposTurno .And. !Empty(SP4->P4_TURNO) .And. SP4->P4_TURNO != cTurnoAnt)
								SP4->(dbSkip())	
								LOOP
							EndIf
							If nTipHoras == 1
								Aadd(aAutorizado, {SP4->P4_CODAUT, If(SP9->(dbSeek(fFilFunc('SP9') + SP4->P4_CODAUT)), SP9->P9_DESC, Space(20))})
							ElseIf nTipHoras == 2
								Aadd(aAutorizado, {SP4->P4_CODNAUT, If(SP9->(DbSeek(fFilFunc('SP9') + SP4->P4_CODNAUT)), SP9->P9_DESC, Space(20))})
							ElseIf nTipHoras == 3
								Aadd(aAutorizado, {SP4->P4_CODAUT, If(SP9->(dbSeek(fFilFunc('SP9') + SP4->P4_CODAUT)), SP9->P9_DESC, Space(20))})
								Aadd(aAutorizado, {SP4->P4_CODNAUT, If(SP9->(DbSeek(fFilFunc('SP9') + SP4->P4_CODNAUT)), SP9->P9_DESC, Space(20))})
							Endif	 
							SP4->(dbSkip())
						EndDo
					Endif    
					
					If nTipHoras == 1 .Or. nTipHoras == 3
						cCod029A := PosSP9("029A", SRA->RA_FILIAL,"P9_IDPON", 2)
						If !Empty(cCod029A)
							Aadd(aAutorizado, {SP9->P9_CODIGO,SP9->P9_DESC})
						Endif
						cCod025A := PosSP9("025A", SRA->RA_FILIAL, "P9_IDPON", 2)
						If !Empty(cCod025A)
							Aadd(aAutorizado, {SP9->P9_CODIGO, SP9->P9_DESC})
						Endif	
					EndIf
					
					If nTipHoras == 2 .Or. nTipHoras == 3
						cCod038N := PosSP9("038N", SRA->RA_FILIAL, "P9_IDPON", 2)
						If !Empty(cCod038N)
							Aadd(aAutorizado, {SP9->P9_CODIGO, SP9->P9_DESC})
						Endif
					EndIf
				EndIf
			Endif
			
			//-- Quando houver codigo informado, este sera utilizado
			//-- em substituicao ao codigo apontado
			cPD := If(Empty(SPC->PC_PDI),SPC->PC_PD,SPC->PC_PDI)
			
			//-- Verifica se e um codigo contido na relacao de codigos 
			//-- definidas segundo avariavel cCodigos
			nPos := Ascan(aAutorizado,{ |x| x[1] = cPD })
            //-- Se o Codigo do Evento apontado  eh Valido
			If nPos > 0
				//-- Obtem a quantidade do evento apontando
				xQuant := If(SPC->PC_QUANTI>0,SPC->PC_QUANTI,SPC->PC_QUANTC)
                //-- Posiciona na TabCalend para a Data Lida
                nTab := aScan(aTabCalend, {|x| x[CALEND_POS_DATA] == SPC->PC_DATA .And. x[CALEND_POS_TIPO_MARC] == '1E' })
				
				//-- Se existir calendario para o apontamento
				//-- Obs.: Se um apontamento for digitado pode ocorrer de nao ter
				//--       uma data correspondente na TabCalend ???
				If nTab>0
			  		//-- Obtem a Ordem para a Data Lida
			  		cOrdem    := aTabCalend[nTab,CALEND_POS_ORDEM] //-- Ordem		
					
					aMarcFun:={}
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Obtem as Marcacoes Realizadas para a Ordem Lida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lImpMar
						//-- o Arquivo ‚ setado para a 1a Marca‡„o do dia em quest„o.
						//-- de acordo com a ordem da tabela
						nPosMarc:=Ascan(aMarcacoes,{|x| x[3]==cOrdem})
						//-- Se Existir Marcacao para o Dia
						If !Empty(nPosMarc)
							//--  Corre Todas as marcacoes enquanto a mesma ordem
							While cOrdem == aMarcacoes[nPosMarc,3]
								//-- Monta o array com as Marcacoes do funcionario para a ordem.
								Aadd(aMarcFun,StrTran(StrZero(aMarcacoes[nPosMarc,2],5,2),'.',':'))
								nPosMarc++
								//-- Se o contador ultrapassar o total de Marcacoes abandona loop
								If nPosMarc>nLenMarc
									Exit
								Endif   
							EndDo
					    Endif
				   Endif
				Endif
				
				If nSinAna == 1	// Sintetica
					If (nPosDet:=Ascan(aDet,{ |x| x[2] =  cPD })) > 0
						aDet[nPosDet,4]:=SomaHoras(aDet[nPosDet,4],xQuant)
					Else
						aAdd(aDet,{ SPC->PC_DATA, aAutorizado[nPos,1], aAutorizado[nPos,2] ,	xQuant, aMarcFun })	
					Endif			
				Else
					aAdd(aDet,{ SPC->PC_DATA, aAutorizado[nPos,1], aAutorizado[nPos,2] , xQuant, aMarcFun })	
				Endif
			Endif
			SPC->(DbSkip())
		EndDo
	Endif

	// Verifica se não carregou as marcações e salta para o proximo funcionario
	If Len(aDet) == 0
		(cAliasQry)->(DbSkip())
		cTurnoAnt := ""
		Loop
	Endif

	//-- O Sort para Analitico e por Data e ordem 
	aSort(aDet,,,{|x,y| x[1] < y[1] })
	
	oSection:PrintLine()
	oReport:SkipLine()
	oSection1:Init(.F.) 

	If nSinAna == 2	.Or. lHeaderMar // Imprime cabecalho das marcacoes caso seja analitico
		oSection1:SetHeaderSection(.T.)
		oSection1:PrintHeader() 
		oSection1:SetHeaderSection(.F.)
		lHeaderMar := .F.
	Endif
		
	dDtMarc := CTOD(" / / ")
	For nFor := 1 to Len( aDet )

		cRealDet := ""
		
		If lImpMar
		    If dDtMarc <> aDet[nFor,1]
			    dDtMarc := aDet[nFor,1]
				//-- Altera valores da Section
				For nX := 1 to Len(aDet [ nFor , 5])
					cRealDet += aDet [ nFor , 5 , nX ] + Space(1)
				Next
			Endif
		Endif
		
		If nSinAna == 1	// Sintetico
			oSection1:Cell( "MARCACOES"):SetValue(Space(48))
			oSection1:Cell( "DATA"):SetValue(Space(5))
		Else
			if lImpMar
				oSection1:Cell( "MARCACOES"):SetValue(cRealDet)
				oSection1:Cell( "DATA"):SetValue( SubStr( Dtos(aDet[nFor,1]),7,2) + "/" + SubStr(Dtos(aDet[nFor,1]),5,2) )
			Endif
		Endif
		
		oSection1:Cell( "CODIGO"):SetValue(aDet[nFor,2])
		oSection1:Cell( "DESCRICAO"):SetValue(aDet[nFor,3])
		oSection1:Cell( "HORAS"):SetValue(STRTRAN(StrZero(aDet[nFor,4],6,2),".",":"))				

		oSection1:Cell( "VISTO"):SetValue(Repl("_",30))

		//-- Imprime os conteudos da Section
	   	oSection1:PrintLine()
		oReport:SkipLine()
	Next

	oSection1:Finish()
	oReport:ThinLine()
	oReport:SkipLine()		

	(cAliasQry)->(DbSkip())

EndDo

oSection:Finish()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Select(cAliasQry) > 0
	(cAliasQry)->(dbCloseArea())
Endif

Return


/*/{Protheus.doc} TiposTurno
Busca os tipos de hora extra que tem o turno preenchido
@author Cícero Alves
@since 13/05/2019
/*/
Static Function TiposTurno(cTurnoFunc, cFilialFunc)
	
	Local aArea		:= GetArea()
	Local cAliasSP4 := GetNextAlias()
	Local cTipos 	:= ""
	
	cLastTurno := cTurnoFunc
	cTipos := ""
	
	BeginSQL Alias cAliasSP4
		
		SELECT SP4.P4_TIPO
		FROM %table:SP4% SP4
		WHERE SP4.P4_FILIAL = %Exp:xFilial("SP4", cFilialFunc)% AND
		P4_TURNO = %Exp:cTurnoFunc% AND
		SP4.%NotDel%
		
	EndSQL
	
	While (cAliasSP4)->(! Eof())
		cTipos += (cAliasSP4)->P4_TIPO + "/"
		(cAliasSP4)->(dbSkip())
	End
	
	(cAliasSP4)->(dbCloseArea())
	
	RestArea(aArea)
	
Return cTipos
