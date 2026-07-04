/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR070.CH"
#INCLUDE "REPORT.CH"

Static cPerg		:= "PN070R"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PONR070  ³ Autor ³ R.H. - J. Ricardo     ³ Data ³ 23.08.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Controle de Refeicoes                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR070(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ FNC  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Leandro Dr. ³14/04/14³      ³Retirada de ajustes, database e FieldPos  ³±±
±±³            ³        ³      ³que nao serao utilizados na P12.		  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PONR070()
Local	oReport   
Local	aArea 		:= GetArea()

Pergunte(cPerg,.F.) 

oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ ReportDef  ³ Autor ³ Totvs IP RH           ³ Data ³24/04/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Controle de Refeicoes					                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PONR070                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR070 - Generico                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport 
Local oSection1 
Local oSection2 
Local oSection3
Local bBlkFil := { || If ( cCodFilial != (cAliasQry)->RA_FILIAL, Eval( { || fInfo(@aInfo,(cAliasQry)->RA_FILIAL), aInfo[3] } ), aInfo[1] ) }
Local aOrd       := {STR0004 , STR0005 , STR0006 , STR0007 , STR0021 } // 'Matricula'###'Centro de Custo'###'Nome'###'Turno'###'C.Custo+Nome'
Private cTitulo	:= OemToAnsi(STR0001)			// 'Relatorio de Refeicoes'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao dos componentes de impressao                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "PONR070" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PN070Imp(oReport)} DESCRIPTION OemtoAnsi(STR0036) TOTAL IN COLUMN // "Este programa emite Relatorio para Controle de Refeicoes"

	oSection1 := TRSection():New( oReport, OemToAnsi(STR0045), {"SRA","CTT","SR6"}, aOrd,,,,,.F.,.F.,.F.) // "Funcionarios"


		TRCell():New(oSection1,"RA_FILIAL","SRA",,/*Picture*/,8,/*lPixel*/,{|| 	If(!Empty((cAliasQry)->RA_FILIAL),;
																								cCodFilial:= (cAliasQry)->RA_FILIAL,;
																								NIL),;
																								cCodFilial}	)
		TRCell():New(oSection1,"FILIAL","",OemToAnsi(STR0046),/*Picture*/,20,/*lPixel*/,{|| Eval( bBlkFil ) })	// "Desc.Filial"

		TRCell():New(oSection1,"RA_MAT"		,"SRA",OemToAnsi(STR0056),,6)				// "Matric."
		TRCell():New(oSection1,"RA_NOME"	,"SRA",,,30,,,,.T.)
		TRCell():New(oSection1,"RA_CC"		,"SRA",OemToAnsi(STR0039),,9)				// "C.Custo"
		TRCell():New(oSection1,"CTT_DESC01"	,"CTT",OemToAnsi(STR0044),,25,,,,.T.) 		// "Descricao"
		TRCell():New(oSection1,"RA_TNOTRAB"	,"SRA",OemToAnsi(STR0041),,3)				// "Tno"
		TRCell():New(oSection1,"R6_DESC"	,"SR6",,,20,,,,.T.)

	oSection2 := TRSection():New( oSection1, OemToAnsi(STR0042),,,,,,,.F.,.F.,.F. )	 //"Refeicoes"
                                                                              
		TRCell():New( oSection2, "DATA"     	, "" ,OemToAnsi(STR0043),,10)			// "Data 
		TRCell():New( oSection2, "HORA"     	, "" ,OemToAnsi(STR0044),,5) 			// "Hora" 
		TRCell():New( oSection2, "TIPOREF"		, "" ,OemToAnsi(STR0045),,4) 			// "Tipo"
		TRCell():New( oSection2, "DESCRICAO"   	, "" ,OemToAnsi(STR0040),,30) 			// "Descricao" 
		TRCell():New( oSection2, "VALORREF"		, "" ,OemToAnsi(STR0046),,14,,,,,"RIGHT") 	// "Valor Ref"
		TRCell():New( oSection2, "DESCFUNC"		, "" ,OemToAnsi(STR0047),,14,,,,,"RIGHT") 	// "Desc.Func."
		TRCell():New( oSection2, "CUSTOEMPRESA"	, "" ,OemToAnsi(STR0048),,14,,,,,"RIGHT") 	// "Custo Empresa"

	oSection3 := TRSection():New( oReport, OemToAnsi(STR0049),,,,,,,.F.,.F.,.F. )	 //"Total Funcionario"
                                                                              
		TRCell():New( oSection3, "TIPO"     	, "" ,OemToAnsi(STR0045),,10)			// "Tipo" 
		TRCell():New( oSection3, "DESCRICAO"   	, "" ,OemToAnsi(STR0040),,45,,,,.T.) 			// "Descricao" 
		TRCell():New( oSection3, "QTDE"			, "" ,OemToAnsi(STR0050),,8,,,,,"RIGHT") 			// "Qtde"
		TRCell():New( oSection3, "VALORREF"		, "" ,OemToAnsi(STR0046),,14,,,,,"RIGHT") 			// "Valor Ref"
		TRCell():New( oSection3, "DESCFUNC"		, "" ,OemToAnsi(STR0047),,14,,,,,"RIGHT") 			// "Desc.Func."
		TRCell():New( oSection3, "CUSTOEMPRESA"	, "" ,OemToAnsi(STR0048),,14,,,,,"RIGHT") 			// "Custo Empresa"

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PN070Imp   ³ Autor ³ Totvs IP RH           ³ Data ³24/04/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao do relatorio em TReport                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PN070Imp(oReport)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oReport                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR070 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PN070Imp(oReport)

Local oSection  := oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1)
Local oSection2 := oReport:Section(2)
Local cSitQuery	:= ""    
Local cCatQuery	:= ""  
Local nReg		:= 0
Local nOrdem	:= 1
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis de Acesso do Usuario                               ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
//-- Inicializa Variaveis Locais
Local nFor       := 0

Local cAcessaSRA := &("{ || " + ChkRH("PONR070","SRA","2") + "}")

Local cFilSRACTT	:= ""
Local cFilSRASR6	:= ""

Local oBreakCc
Local oBreakFil
Local oBreakFun

Local lHeaderMar	:= .T.

Private aRefFunc   	:= 	{} 
Private aTipos	 	:=	{}  
Private aTipoCC	 	:=	{}  
Private aTipoFil	:=	{}  
Private aTipoEmp	:=	{}  

Private cCodFilial	:= "##"
Private aInfo      := {}
Private cFilAnte   := ""
Private cTnoAnte   := ""
Private cCccAnte   := ""
Private cSit       := ''
Private cCat       := ''
Private dInicio    := CtoD('  /  /  ')
Private dFim       := CtoD('  /  /  ')
Private lSintetico := .F. 
Private lDiaDia    := .F.
Private nHoraDe    := 00.00
Private nHoraAte   := 23.59

Private cMV_PAR145 := .F.   
Private cMV_PAR14N := .F.   

Private cAliasQry 	:= GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        //  Filial  De                               ³
//³ MV_PAR02        //  Centro de Custo De                       ³
//³ MV_PAR03        //  Turno De                                 ³
//³ MV_PAR04        //  Matricula De                             ³
//³ MV_PAR05        //  Nome De                                  ³
//³ MV_PAR06        //  Situacao                                 ³
//³ MV_PAR07        //  Categoria                                ³
//³ MV_PAR08        //  Dia Inicial                              ³
//³ MV_PAR09        //  Dia Final                                ³
//³ MV_PAR10        //  sintetico/Analitico                      ³
//³ MV_PAR11        //  Dia a Dia ou somente total               ³  
//³ MV_PAR12        //  Hora Ref. Inicio                         ³
//³ MV_PAR13        //  Hora Ref. Fim                            ³ 
//³ MV_PAR14        //  Tipo Ref.                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis MV_PAR?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSit       := MV_PAR06
cCat       := MV_PAR07
dInicio    := MV_PAR08
dFim       := MV_PAR09
lSintetico := If(MV_PAR10=1,.F.,.T.)
lDiaDia    := If(MV_PAR11=1,.T.,.F.) 
nHoraDe    := MV_PAR12
nHoraAte   := MV_PAR13 
nTpRef     := MV_PAR14

If dInicio > dFim
	Help(' ',1,'PNR050DATA')
	Return Nil
Endif

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
MakeAdvplExpr(cPerg)
If !Empty(MV_PAR14)
	cMV_PAR145   := MV_PAR14
	cMV_PAR14N   := STRTRAN(MV_PAR14,"P5_TIPOREF","PN_TIPOREF")
Endif

//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada na Query
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

cQryProcesso := "%(SRA.RA_DEMISSA = '          ' OR (SRA.RA_DEMISSA >= '"+DTOS(dInicio) + "' AND  SRA.RA_DEMISSA <> '          '))%"
	
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

END REPORT QUERY oSection PARAM mv_par01,mv_par02,mv_par03,mv_par04,mv_par05

DEFINE BREAK oBreakFil OF oSection WHEN {|| (cAliasQry)->RA_FILIAL }  TITLE OemToansi(STR0001) 
oBreakFil:SetPageBreak(.T.)
oBreakFil:SetHeaderBreak(.T.) 

DEFINE BREAK oBreakFun OF oSection WHEN {|| (cAliasQry)->RA_MAT }  TITLE OemToansi(STR0001) 
oBreakFun:SetHeaderBreak(.T.) 
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Quebra de pagina C.Custo                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (nOrdem = 2 .or. nOrdem = 5) 
	DEFINE BREAK oBreakCc OF oSection WHEN {|| (cAliasQry)->RA_CC } TITLE OemToansi(STR0001) 
	oBreakCc:SetPageBreak(.T.) 
	oBreakCc:SetHeaderBreak(.T.) 
ElseIf (nOrdem = 4) 
	DEFINE BREAK oBreakCc OF oSection WHEN {|| (cAliasQry)->RA_TNOTRAB } TITLE OemToansi(STR0001) 
	oBreakCc:SetPageBreak(.T.) 
	oBreakCc:SetHeaderBreak(.T.) 
Endif 

oSection:SetHeaderSection(.T.)
oSection:SetHeaderBreak(.T.) 

oSection1:SetHeaderSection(.F.)
oSection1:SetHeaderBreak(.F.) 

oSection2:SetHeaderBreak(.F.) 
oSection2:SetHeaderSection(.F.)

oSection:lHeaderPage:=.F. 
oSection1:lHeaderPage:=.F. 
oSection2:lHeaderPage:=.F. 

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
cTnoAnte := (cAliasQry)->RA_TNOTRAB
cCccAnte := (cAliasQry)->RA_CC

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a variavel aInfo com a filial Logada              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
fInfo(@aInfo,(cAliasQry)->RA_FILIAL)

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

		If !fInfo(@aInfo,(cAliasQry)->RA_FILIAL)
			Exit
		Endif	

		// Imprime os totais por Centro de Custo ou Turno de Trabalho
		If nOrdem == 2 .Or. nOrdem == 4 .Or. nOrdem == 5
			F070RCabTipo(oReport,oSection2,@aTipoCC,nOrdem)
		Endif

		// Imprime os totais da filial
		oReport:EndPage()
		F070RCabTipo(oReport,oSection2,@aTipoFil,9)		

		cFilAnte := (cAliasQry)->RA_FILIAL
		cTnoAnte := (cAliasQry)->RA_TNOTRAB
		cCccAnte := (cAliasQry)->RA_CC

	Endif

	//-- Processa quebra de Filial.
	If (nOrdem == 4 .And. (cAliasQry)->RA_TNOTRAB != cTnoAnte) .Or. ;
		(( nOrdem == 2 .Or. nOrdem == 5) .And. (cAliasQry)->RA_CC != cCccAnte	)
		F070RCabTipo(oReport,oSection2,@aTipoCC,nOrdem)		
		cTnoAnte := (cAliasQry)->RA_TNOTRAB
		cCccAnte := (cAliasQry)->RA_CC
	Endif

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Consiste Filiais e Acessos                                             ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF !( (cAliasQry)->RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA )
		(cAliasQry)->(DbSkip())
	   	Loop
	EndIF

	/*
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³*** Processa Marcacoes de Refeicoes ***³
	//³    do Funcionario Corrente            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	*/                                      

    //-- Zera Acumuladores do Funcionario
	aTipos		:={}
	aRefFunc	:={}                   
	
	//-- Obtem Marcacoes do Movimento e Acumulado (SP5 e SPN)
	U_fObtemMarc(@aRefFunc,@aTipos)
   
    //--Se houve Marcacoes
    If Len(aTipos) > 0

	   	//-- Atualiza Matrizes Somatorias      
		fSomaMat(@aTipoCC ,@aTipos,1,{4,5,6,7}) //CC ou Turno  
		fSomaMat(@aTipoFil,@aTipos,1,{4,5,6,7}) //Filial
		fSomaMat(@aTipoEmp,@aTipos,1,{4,5,6,7}) //Empresa
  
	 	//-- Imprime Marcacoes do Funcionario  e Zera a Tipos
		
	    If Len(aRefFunc) > 0 .And. !lSintetico

			oSection:PrintLine()
			oReport:SkipLine()

			If lDiaDia
				oSection1:Init(.F.) 
			
				If lHeaderMar .Or. !lSintetico // Imprime cabecalho das marcacoes caso seja analitico
					oSection1:SetHeaderSection(.T.)
					oSection1:PrintHeader() 
					oSection1:SetHeaderSection(.F.)
					lHeaderMar := .F.
				Endif

				dDataFunc :=Ctod(Space(8))
				For nFor := 1 To Len(aRefFunc)

					//-- Verifica Quebra de Data
					If DTOS(dDataFunc)<>DTOS(aRefFunc[nFor,1]) 
					   //-- Iguala Variavel Verificadora de quebra
					   dDataFunc:=aRefFunc[nFor,1]  
						oSection1:Cell( "DATA"):SetValue(aRefFunc[nFor,1])
					Else    
						//-- Inicio das Linhas Seguintes contem data em branco
						oSection1:Cell( "DATA"):SetValue(Space(10))
						cDet:= SPACE(11)  
					Endif
					   
				    //--Monta Linha Detalhe   
				    //-- Data + Hora + Tipo Ref + Valor Ref + Desc.Func. + Custo Empresa
		
					oSection1:Cell( "HORA"):SetValue(StrTran(aRefFunc[nFor,2],'.',':'))
					oSection1:Cell( "TIPOREF"):SetValue(aRefFunc[nFor,3])
					oSection1:Cell( "DESCRICAO"):SetValue(aRefFunc[nFor,4])
					oSection1:Cell( "VALORREF"):SetValue(Transform(aRefFunc[nFor,5],'@E 999,999,999.99'))
					oSection1:Cell( "DESCFUNC"):SetValue(Transform(aRefFunc[nFor,6],'@E 999,999,999.99'))			
					oSection1:Cell( "CUSTOEMPRESA"):SetValue(Transform(aRefFunc[nFor,7],'@E 999,999,999.99') )

					//-- Imprime os conteudos da Section
				   	oSection1:PrintLine()
					oReport:SkipLine()

				Next nFor                         
			
				oSection1:Finish()
				oReport:ThinLine()
			Endif

			//Imprime totais dos Tipos do funcionario

			F070RCabTipo(oReport,oSection2,aTipos,0)
			
		Endif
    Endif
    
	(cAliasQry)->(DbSkip())

EndDo

// Imprime os totais por Centro de Custo ou Turno de Trabalho
If Len(aTipoCC) > 0 .And. (nOrdem == 2 .Or. nOrdem == 4 .Or. nOrdem == 5)
	F070RCabTipo(oReport,oSection2,@aTipoCC,nOrdem)
Endif

// Imprime os totais por Filial
If Len(aTipoFil) > 0
	oReport:EndPage()
	F070RCabTipo(oReport,oSection2,@aTipoFil,9)
Endif

// Imprime os totais por Empresa
If Len(aTipoEmp) > 0
	oReport:EndPage()
	F070RCabTipo(oReport,oSection2,@aTipoEmp,99)
Endif

// aqui imprimir total geral

oSection:Finish()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Select(cAliasQry) > 0
	(cAliasQry)->(dbCloseArea())
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³F070RCabTipo³Autor³ Totvs IP-RH 		    ³ Data ³ 24.04.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de totalizadores para TReport                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ F070RCabTipo(oReport,oSection ,aTipos)                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oReport     - objeto principal                             ³±±
±±³          ³ oSection    - objeto da secao                              ³±±
±±³          ³ aTipos      - Array contendo o conteudo a ser impresso     ³±±
±±³          ³ nOrdem      - Numero da Ordem de impressao                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR070                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/			
Static Function F070RCabTipo(oReport,oSectionTotal,aTipos,nOrdem)
Local cDescTot	:= ""
Local nFor 		:= 1
Local aTotTipo	:= {}
Local aTot		:= {}

If Len(aTipos) == 0
	Return
Endif

//-- Ordena Tipos em Ordem Crescente 
aSort(aTipos,,,{|x,y| x[1]<y[1]})

//-- Totaliza Colunas dos Tipos
aTotTipo:=fSoma(@aTipos ,{4,5,6,7})         

//-- Preenche 1.o Elemento da array Total dos Tipos com "Total: "
If nOrdem == 0
	cDescTot := STR0049	// "Total Funcionario" 
Elseif nOrdem == 9
	cDescTot := STR0051	// "Total Filial" 
	cDescTot += " " + Posicione("SM0",1,cEmpAnt+cFilAnte,"M0_NOME")
Elseif nOrdem == 2
	cDescTot := STR0052	// "Total C.Custo" 
	cDescTot += " " + Posicione("CTT",1,fFilFunc("CTT")+cCccAnte,"CTT_DESC01")
Elseif nOrdem == 4
	cDescTot := STR0053	// "Total Turno" 
	cDescTot += " " + Posicione("SR6",1,fFilFunc("SR6")+cTnoAnte,"R6_DESC")
Elseif nOrdem == 5
	cDescTot := STR0052	// "Total C.Custo" 
	cDescTot += " " + Posicione("CTT",1,fFilFunc("CTT")+cCccAnte,"CTT_DESC01")
Elseif nOrdem == 99
	cDescTot := STR0054	// "Total Empresa" 
Endif

aTot:= {Space(2),PADR(ALLTRIM(UPPER(cDescTot)),60),0}

//-- Preenche os demais elementos com a totalizacao das Colunas dos Tipos
Aeval(aTotTipo,{ |x| AADD(aTot, x) })
	   
//-- Adiciona o array totalizador ao array dos Tipos que o Originou
//-- Para ser impresso como ultimo elemento
AADD(aTipos,aTot)

oSectionTotal:SetHeaderSection(.T.)
oSectionTotal:Init(.F.)
oSectionTotal:PrintHeader() 
oSectionTotal:SetHeaderSection(.F.)

For nFor := 1 To Len(aTipos) 

	oSectionTotal:Cell( "TIPO"):SetValue(aTipos[nFor,1])
	oSectionTotal:Cell( "DESCRICAO"):SetValue(aTipos[nFor,2])
	oSectionTotal:Cell( "QTDE"):SetValue(Transform(aTipos[nFor,4],'@E 9999,999'))
	oSectionTotal:Cell( "VALORREF"):SetValue(Transform(aTipos[nFor,5],'@E 999,999,999.99'))
	oSectionTotal:Cell( "DESCFUNC"):SetValue(Transform(aTipos[nFor,6],'@E 999,999,999.99'))			
	oSectionTotal:Cell( "CUSTOEMPRESA"):SetValue(Transform(aTipos[nFor,7],'@E 999,999,999.99') )
	oSectionTotal:PrintLine()

Next nFor

oSectionTotal:Finish()
oReport:ThinLine()

aTipos := {}

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fObtemMarc³ Autor ³ Mauricio MR           ³ Data ³ 25/08/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Obtem Marcacoes de Refeicoes do Funcionario                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ POR070IMP                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fObtemMarc(aRefFunc,aTipos)
Local cTipoRef	:= ""
Local cDescRef  := ""
Local cQuery	:= ""
Local cHoraDe	:= "00.00"
Local cHoraAte	:= "23.59"
Local cTpRefSP5	:= ""
Local cTpRefSPN	:= ""
Local cAlias	:= GetNextAlias()
Local cDataIni	:= dToS(Date())
Local cDataFim	:= dToS(Date())

Static oStSP5

If (!Empty(dInicio), cDataIni := dToS(dInicio), Nil)
If (!Empty(dFim), cDataFim := dToS(dFim), Nil)
If (!Empty(nHoraDe), cHoraDe := cValToChar(nHoraDe), Nil)
If (!Empty(nHoraAte), cHoraAte := cValToChar(nHoraAte), Nil)

If !Empty(AllTrim(MV_PAR14))
	cTpRefSP5 := MV_PAR14
	cTpRefSPN := StrTran(MV_PAR14,"P5_TIPOREF","PN_TIPOREF")
EndIf

If oStSP5 == Nil
	oStSP5 := FWPreparedStatement():New()
	
	cQuery := "SELECT"
	cQuery += "  P5_FILIAL,"
	cQuery += "  P5_MAT,"
	cQuery += "  P5_DATA,"
	cQuery += "  P5_HORA,"
	cQuery += "  P5_TIPOREF,"
	cQuery += "  P5_VALREF,"
	cQuery += "  P5_DESCFUN,"
	cQuery += "  P5_PROCES,"
	cQuery += "  P5_PERIODO,"
	cQuery += "  P5_ROTEIR,"
	cQuery += "  P5_NUMPAG "
	cQuery += "FROM " + RetSqlName("SP5") + " SP5 "
	cQuery += "WHERE SP5.P5_FILIAL = ? "
	cQuery += "  AND SP5.P5_MAT = ? "
	cQuery += "  AND (SP5.P5_DATA >= '" + cDataIni + "' AND SP5.P5_DATA <= '" + cDataFim + "') "
	cQuery += "  AND (SP5.P5_HORA >= " + cHoraDe + " AND SP5.P5_HORA <= " + cHoraAte + ") "
	If (!Empty(cTpRefSP5), cQuery += " AND " + cTpRefSP5 + " ", Nil)
	cQuery += "  AND SP5.D_E_L_E_T_ = ' ' "
	cQuery += "UNION ALL "
	cQuery += "SELECT "
	cQuery += "  PN_FILIAL,"
	cQuery += "  PN_MAT,"
	cQuery += "  PN_DATA,"
	cQuery += "  PN_HORA,"
	cQuery += "  PN_TIPOREF,"
	cQuery += "  PN_VALREF,"
	cQuery += "  PN_DESCFUN,"
	cQuery += "  PN_PROCES,"
	cQuery += "  PN_PERIODO,"
	cQuery += "  PN_ROTEIR,"
	cQuery += "  PN_NUMPAG "
	cQuery += "FROM " + RetSqlName("SPN") + " SPN "
	cQuery += "WHERE SPN.PN_FILIAL = ?"
	cQuery += "  AND SPN.PN_MAT = ?"
	cQuery += "  AND (SPN.PN_DATA >= '" + cDataIni + "' AND SPN.PN_DATA <= '" + cDataFim + "')"
	cQuery += "  AND (SPN.PN_HORA >= " + cHoraDe + " AND SPN.PN_HORA <= " + cHoraAte + ")"
	If (!Empty(cTpRefSPN), cQuery += " AND " + cTpRefSPN + " ", Nil)
	cQuery += "  AND SPN.D_E_L_E_T_ = ' ' "
	cQuery += " ORDER BY P5_DATA"
	
	cQuery := ChangeQuery(cQuery)
	
	oStSP5:SetQuery(cQuery)
EndIf

oStSP5:SetString(1,SRA->RA_FILIAL)
oStSP5:SetString(2,SRA->RA_MAT)
oStSP5:SetString(3,SRA->RA_FILIAL)
oStSP5:SetString(4,SRA->RA_MAT)

cQuery := oStSP5:getFixQuery()

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias)

// Corre Refeições do Funcionário
While !(cAlias)->(Eof())
	// Se Houve Quebra de Tipo de Refeição
    If (cAlias)->P5_TIPOREF <> cTipoRef 
        // Para Tipos Novos 	Obtem	: 	Descricao, Perc.Desc.Func.
        //	     				Reserva :	Qtde,Vlr da Refeição ,Part Func., Part. Empresa
       	If (nPosTipo := aScan( aTipos,{ |xtipo| xtipo[1] == (cAlias)->P5_TIPOREF})) == 0.00
		    cDescRef:= fDesc("SPM",(cAlias)->P5_TIPOREF,"PM_DESCREF")
		    
		    // Alerta para Tipo de Refeição Nao Cadastrado
		    If Empty(cDescRef)
		    	cDescRef	:= STR0026   //** Nao Cadastrado **	
		    EndIf    
		    
		    aAdd(aTipos, {;
				(cAlias)->P5_TIPOREF,;													// Tipo 
		       	cDescRef,;																// Descrição
		        Posicione("SPM",1,fFilFunc("SPM")+(cAlias)->P5_TIPOREF,"PM_PERCFUN"),;	// Perc. 
		        0,;  																	// Qtde
		        0.00,;  																// Vlr Refeição
		        0.00,;																	// Part. Func.
		        0.00;																	// Part. Empresa
		        })
			nPosTipo := Len(aTipos)
		EndIf
		// Iguala variável verificadora de quebra de Tipo
		cTipoRef := (cAlias)->P5_TIPOREF
	EndIf

	// Soma Valores Referentes ao Tipo Refeição Lido
	aTipos[nPosTipo][4] := aTipos[nPosTipo][4] + 1   										// Qtde
	aTipos[nPosTipo][5] := aTipos[nPosTipo][5] + (cAlias)->P5_VALREF						// Valor da Refeição 
	aTipos[nPosTipo][6] := aTipos[nPosTipo][6] + (cAlias)->P5_DESCFUN						// Desc.Ref.Funcionário
	aTipos[nPosTipo][7] := aTipos[nPosTipo][7] + (cAlias)->P5_VALREF - (cAlias)->P5_DESCFUN	// Desc.Ref.Empresa					
	
	// Armazena Linhas Detalhes de Refeição Por Funcionário
	Aadd(aRefFunc, {;
		sToD((cAlias)->P5_DATA),;													// Data
		Strzero((cAlias)->P5_HORA,5,2),; 											// Hora 
		(cAlias)->P5_TIPOREF,;														// Tipo Refeição
		Posicione("SPM", 1, fFilFunc("SPM") + (cAlias)->P5_TIPOREF, "PM_DESCREF"),;	// Descrição Refeição
		(cAlias)->P5_VALREF,;														// Valor da Refeição 
		(cAlias)->P5_DESCFUN,;														// Desc.Ref.Funcionario
		(cAlias)->P5_VALREF - (cAlias)->P5_DESCFUN,;								// Desc.Ref.Empresa	
		(cAlias)->P5_PROCES,;														// Processo
		(cAlias)->P5_PERIODO,;														// Período
		(cAlias)->P5_ROTEIR,;														// Roteiro
		(cAlias)->P5_NUMPAG;														// Num Pagto	
	})

	(cAlias)->(DbSkip())
EndDo

(cAlias)->(DbCloseArea())
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fSomaMat  ³ Autor ³ Mauricio MR           ³ Data ³ 15/08/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Soma duas Matrizes                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fSomarMat(aMatrizSoma,aMatriz,nColuna do Identificador)    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ POR070IMP                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fSomaMat(aTot,aElem,nIdentificador,aColunas,nnada)
Local nJ		:=	0                                       
Local nI		:=	0        
Local naElem	:=	Len(aElem)
Local nPos		:=	0  
Local naColunas	:=Len(aColunas)


//Se esta vazio o aTot
If Empty(Len(aTot))           
   //Faz Copia de aElem
   aTot:=Aclone(aElem)
Else
 	//Corre Todas as Linhas de aElem
 	For nI:=1 to naElem          
 	    //Procura Identificador correspondente em aTot
		nPos:=Ascan(aTot,{|xIdent| xIdent[nIdentificador]==aElem[nI][nIdentificador]})
		//Se Encontrou
		If nPos>0
		   //Soma cada uma das Colunas do mesmo Identificador
		   For nJ:=1 To naColunas
		       aTot[nPos, aColunas[nJ] ]+=aElem[nI, aColunas[nJ] ]
		   Next nJ
		Else                       
		   //Se nao encontrou o Identificador adiciona-o a aTot
		   AADD(aTot,aClone(aElem[nI]))
		Endif
	Next nI
EndIf	

Return (nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fSoma     ³ Autor ³ Mauricio MR           ³ Data ³ 25/08/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Soma Matriz                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Fsoma(Matriz,Colunas). Ex. aRefeicoes{ {a,b,c}...{x,y,z}}  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ POR070IMP                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FSoma(aMatriz, aCol)
Local nCol	:=Len(aCol)
Local aSoma := Array(nCol)

//Inicializa aSoma
aFill(aSoma, 0)

If nCol > 1
	aEval(aMatriz,{ |x| fSomarCol(x, aCol, @aSoma) })
EndIf
	
Return (aSoma) 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fSomarCol ³ Autor ³ Mauricio MR           ³ Data ³ 15/08/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Soma Colunas das Matrizes                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fSomarCol(aMatrizFilha,aColunas,aMatrizSomatoria)          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ POR070IMP                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fSomarCol(aMatriz,aColunas,aSomatoria)
	Local naCol	:=	Len(aColunas)                                       
	Local nI	:=	0

	//-- Corre Cada Coluna da Matriz 
	For nI:=1 TO naCol                                
		//-- Soma Cada uma das Colunas Especificadas na matriz aSomatoria
		aSomatoria[nI]+= aMatriz[aColunas[nI]]
	Next nI
Return (aSomatoria)
