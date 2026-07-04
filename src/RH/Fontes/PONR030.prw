/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR030.CH"
#INCLUDE "PONCALEN.CH"
#INCLUDE "report.ch"

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programador  ³ Data     ³ FNC            ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±³Leandro Dr.  ³14/04/2014³      			³Retirada de ajustes, database e FieldPos   ³±±
±±³             ³          ³      			³que nao serao utilizados na P12.	    	³±± 
±±³Christiane V.³11/04/2014³ M_RH003/003252 ³Retirada da impressão em R3 e inclusão de  ³±±
±±³			    ³          ³                ³AllTrim para a impressão da descrição do   ³±±
±±³			    ³          ³                ³afastamento 							    ³±±
ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PONR030()
Local	oReport   
Local	aArea 		:= GetArea()
Private cString		:= "SRA"				// alias do arquivo principal 
Static	aOrd    	:= { STR0004 , STR0005 , STR0006 , STR0007 , STR0024 } // 'Matricula'###'Centro de Custo'###'Nome'###'Turno'###'C.Custo+Nome'
Static	cAliasQry	:= ""
Static 	cPerg		:= "PN030R"
Static 	cTitulo		:= OemToAnsi(STR0011)			//'Relatorio de Presentes ou Ausentes'

pergunte(cPerg,.F.) 

oReport := ReportDef()
oReport:PrintDialog()


RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ ReportDef  ³ Autor ³ Totvs IP RH           ³ Data ³29/03/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatorio de Presentes/ Ausentes                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PONR030                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR030 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport 
Local oSection1 
Local oSection2 
Local bBlkFil := { || If ( cCodFilial != (cAliasQry)->RA_FILIAL, Eval( { || fInfo(@aInfo,(cAliasQry)->RA_FILIAL), aInfo[3] } ), aInfo[1] ) }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao dos componentes de impressao                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "PONR030" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PN030Imp(oReport)} DESCRIPTION OemtoAnsi(STR0056) TOTAL IN COLUMN // "Este programa emite Relacao dos Funcionarios Presentes ou Ausentes."

	oSection1 := TRSection():New( oReport, OemToAnsi(STR0057), {"SRA","CTT","SR6"}, aOrd,,,,,.F.,.F.) // "Funcionarios"

		TRCell():New(oSection1,"RA_FILIAL","SRA",,/*Picture*/,8,/*lPixel*/,{|| 	If(!Empty((cAliasQry)->RA_FILIAL),;
																								cCodFilial:= (cAliasQry)->RA_FILIAL,;
																								NIL),;
																								cCodFilial}	)
		TRCell():New(oSection1,"FILIAL","",OemToAnsi(STR0058),/*Picture*/,20,/*lPixel*/,{|| Eval( bBlkFil ) })	// "Desc.Filial"

		TRCell():New(oSection1,"RA_MAT"		,"SRA",,,6)
		TRCell():New(oSection1,"RA_NOME"	,"SRA")
		TRCell():New(oSection1,"RA_CC"		,"SRA",,,9)
		TRCell():New(oSection1,"CTT_DESC01"	,"CTT",,,20)
		TRCell():New(oSection1,"RA_TNOTRAB"	,"SRA","Cod.",,3)
		TRCell():New(oSection1,"R6_DESC"	,"SR6",,,20)								

	oSection2 := TRSection():New( oSection1, OemToAnsi(STR0059) )	 //"Marcações"

		TRCell():New( oSection2, "DATA"		, "" ,OemToAnsi(STR0060)      ,,10)	// "Data"

		TRCell():New( oSection2, "HP1"		, "" ,OemToAnsi(STR0061),,11)	// "1a.E. 1a.S."
		TRCell():New( oSection2, "HP2"		, "" ,OemToAnsi(STR0062),,11)	// "2a.E. 2a.S."
		TRCell():New( oSection2, "HP3"		, "" ,OemToAnsi(STR0063),,11)	// "3a.E. 3a.S."
		TRCell():New( oSection2, "HP4"		, "" ,OemToAnsi(STR0064),,11)	// "4a.E. 4a.S."

		TRCell():New( oSection2, "HR1"		, "" ,OemToAnsi(STR0065),,11)	// "1a.E. 1a.S."
		TRCell():New( oSection2, "HR2"		, "" ,OemToAnsi(STR0066),,11)	// "2a.E. 2a.S."
		TRCell():New( oSection2, "HR3"		, "" ,OemToAnsi(STR0067),,11)	// "3a.E. 3a.S."
		TRCell():New( oSection2, "HR4"		, "" ,OemToAnsi(STR0068),,11)	// "4a.E. 4a.S."
		TRCell():New( oSection2, "HR5"		, "" ,OemToAnsi(STR0069),,11)	// "5a.E. 5a.S."

		TRCell():New( oSection2, "CRACHA"	, "" ,OemToAnsi(STR0070),,6)	// "Cracha"

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PN030Imp   ³ Autor ³ Totvs IP RH           ³ Data ³29/03/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao do relatorio em TReport                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PN030Imp(oReport)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oReport                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR030 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PN030Imp(oReport)

Local oSection  := oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1)
Local cFiltro 	:= "" 
Local cSitQuery	:= ""    
Local cCatQuery	:= ""  
Local nReg		:= 0

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis de Acesso do Usuario                               ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Local cAcessaSRA	:= &( " { || " + ChkRH( "PONR030" , "SRA" , "2" ) + " } " )
Local aPerAberto    := {}
Local aPerFechado   := {}
Local aVerbasFunc   := {}
Local aVerbas       := {}
Local x				:= 0

Local cArqMov	:= cAliasMov := cAliasRI := cArqMovRI := ""
Local nInss 	:= nSalAte   := nSalAci  := 0
Local cTitCC	:= "" 
Local cTitFil	:= ""
Local aOrdBag	:= {}
Local aOrdBagRI	:= {}
Local aTInss	:= {}   
Local aSortTinss:= {}
Local aCodFol	:= {}
Local nRcValor	:= 0
Local xQuebra
Local cOrdem 	:= ""
Local cFilSRACTT:= ""
Local cFilSRASR6:= ""
Local nPre 		:= 0
Local nHr 		:= 0

Local aPrevisto  	:= {}
Local aRealizado   	:= {}
Local aFun          := {}
Local nCal       	:= 1
Local nX            := 0
Local cPrevisto  	:= ''
Local cRealizado 	:= '' 
Local cDet       	:= ''
Local dDtAfas    	:= CtoD('  /  /  ')
Local dDtRet     	:= CtoD('  /  /  ')
Local nLenCalend	:= 0
Local nLenMarc 	    := 0
Local nLenPrev		:= 0 
Local nLenaJornada  := 0
Local nOcorr		:= 0 
Local aOcorr		:=	{}
Local aJornada		:=	{}
Local nPosjrn		:=	0
Local nPosocor		:=	0
Local cOcorr		:=	''
Local nNumMarc		:=	0
Local cTipoDia      :=  ''
Local nQtdeHoras    :=  0
Local dData			:= Ctod('')
Local aHorarios     := {}
Local lOcorr		:= .F.
Local lAfastado		:= .F.
Local lMod			:= .F.
Local lPar			:= .F.
Local cFunRegra		:= ""
Local lPrintHeader 	:= .F.

Private nOrdem		:= oSection:GetOrder()
Private aInfo		:= {}
Private cCodFilial	:= "##"

Private cSituacao	:= ""
Private cCategoria	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cFor       := ''
Private cIndCond   := ''
Private dPerIni    := CtoD('  /  /  ')
Private dPerFim    := CtoD('  /  /  ')
Private aTurnos    := {}
Private aTabPadrao := {}
Private nPagAtu    := 1
Private lUmDia	   := .F.      
Private nAjusteFol := 0

Private	cTnoAnt 	:= Replicate("ú", GetSx3Cache("RA_TNOTRAB", "X3_TAMANHO"))
Private	cCcAnt  	:= Replicate("!", GetSx3Cache("RA_CC", "X3_TAMANHO"))
Private aProvis		:= {}

Private aTabCalend	:= {} 
Private aMarcacoes	:= {}

SRA->(dbSetOrder(1))

//-- Parƒmetro MV_PAPONTA
dPerIni := CtoD('  /  /  ')
dPerFim := CtoD('  /  /  ')
If !PerAponta(@dPerIni, @dPerFim )
	Return Nil
Endif	

cSituacao		:= MV_PAR06
cCategoria		:= MV_PAR07
dRefDe    		:= If(MV_PAR08<dPerIni,dPerIni,MV_PAR08)
dRefAte   		:= If(MV_PAR09>dPerFim,dPerFim,MV_PAR09)
lAusente  		:= If(MV_PAR10 == 1,.T.,.F.)
lCCTur    		:= If(MV_PAR11 == 1,.T.,.F.)
lNaoVerifJrn	:= If(MV_PAR12==1,.T.,.F.) // .T. - Nao Verifica Jornadas
cJornadas 		:= MV_PAR13  //-- Jornadas Escolhidas para verificacao
lTodasJrn 		:= If(MV_PAR14 ==1 .AND. Len(Alltrim(StrTran(MV_PAR13,"*","")))>3,.T.,.F.) // .T. Considerar Ocorrencia de Ausencia/Presenca em Todas as Jornadas(Valido apenas para escolha de 2 ou mais jornadas a serem verificadas)
lCracha   		:= If(MV_PAR15 == 1,.T.,.F.) //.T. Imprime Cracha
lCkIniJorn		:= If(MV_PAR16 == 1,.T.,.F.) //.T. Checa inicio de jornada
nSerHoraCk		:= fDHtoNS(dRefAte,MV_PAR17)  // Hora inicio de Jornadas
nAfast	  		:= MV_PAR18   //1 - Ferias, 2 - Afastamento, 3 - Ambos

lUmdia	  		:= If(dRefDe==dRefAte,.T.,.F.) //.T. verifica 1 (um) Dia Apenas

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        //  Filial                                   ³
//³ MV_PAR02        //  Centro de Custo                          ³
//³ MV_PAR03        //  Turno                                    ³
//³ MV_PAR04        //  Matricula                                ³
//³ MV_PAR05        //  Nome                                     ³
//³ MV_PAR06        //  Situacao                                 ³
//³ MV_PAR07        //  Categoria                                ³
//³ MV_PAR08        //  Data a listar De                         ³
//³ MV_PAR09        //  Data a listar Ate                        ³
//³ MV_PAR10        //  Presentes ou Ausentes                	 ³
//³ MV_PAR11        //  Listar CC em outra pagina                ³
//³ MV_PAR12        //  Verificar as Jornadas do Dia      		 ³
//³ MV_PAR13        //  Quais as Jornadas 			     		 ³
//³ MV_PAR14        //  Presenca/Ausencia (Em Todas ou Pelo - 1) ³
//³ MV_PAR15        //  Listar Crachas Provisorios               ³
//³ MV_PAR16        //  Verificar Inicio de Jornadas             ³
//³ MV_PAR17        //  Hora limite para checar Inicio Jornadas  ³
//³ MV_PAR18        //  Lista Funcionairo em Férias				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cTitulo := OemToAnsi(STR0014 + If(lAusente,STR0015 ,STR0016 )) // 'Relatorio de '###'Ausentes'###'Presentes'

//-- Altera o titulo do relatorio
oReport:SetTitle(cTitulo)

cAliasQry := GetNextAlias()

//-- Modifica variaveis para a Query
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

//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
MakeSqlExpr(cPerg)
	
BEGIN REPORT QUERY oSection

cFilSRACTT	:= "%" + FWJoinFilial("SRA", "CTT") + "%"
cFilSRASR6	:= "%" + FWJoinFilial("SRA", "SR6") + "%"	

If nOrdem == 1
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_MAT%"
ElseIf nOrdem == 2
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_MAT%"
ElseIf nOrdem == 3
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_NOME%"
ElseIf nOrdem == 4
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_TNOTRAB%"
ElseIf nOrdem == 5
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_NOME%"
Endif
	
BeginSql alias cAliasQry
	SELECT SRA.RA_FILIAL, SRA.RA_CC, SRA.RA_MAT, SRA.RA_NOME, SRA.RA_TNOTRAB, SRA.RA_SEQTURN, SRA.RA_DEMISSA,SRA.RA_ADMISSA,SRA.RA_REGRA,SRA.RA_SITFOLH,SRA.R_E_C_N_O_ as RECNO,
		CTT.CTT_FILIAL, CTT.CTT_CUSTO, CTT.CTT_DESC01,
		SR6.R6_TURNO, SR6.R6_DESC
	FROM %table:SRA% SRA
	INNER JOIN %table:CTT% CTT ON RA_CC = CTT_CUSTO AND CTT.%NotDel% AND %exp:cFilSRACTT%
	INNER JOIN %table:SR6% SR6 ON RA_TNOTRAB = R6_TURNO AND SR6.%NotDel% AND %exp:cFilSRASR6%
	WHERE SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	AND
		  SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	AND
 	      SRA.%notDel%   
	ORDER BY %exp:cOrdem%
EndSql

/*
Prepara relatorio para executar a query gerada pelo Embedded SQL passando como 
parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados 
pela funcao MakeSqlExpr para serem adicionados a query
*/
END REPORT QUERY oSection PARAM mv_par01, mv_par02, mv_par03, mv_par04, mv_par05

//-- Define o total da regua da tela de processamento do relatorio
oReport:SetMeter( 100 )  

// Imprime o cabecalho da section1 quando for apenas um dia de intervalo
If lUmdia
	oReport:onPageBreak({|| oReport:ThinLine(), ;
							oReport:PrintText(Space(10)+PADC(STR0071,50) + PADC(STR0072,80)),;
							oReport:ThinLine(),;
							oReport:SkipLine(),;
							oSection1:PrintHeader() ,;
							oReport:SkipLine()   }) 		// "Horario Programado" ### "Horario Realizado" 
Endif

If !lCracha
	oSection1:Cell("CRACHA"):Disable()
Endif

//-- Incializa impressao   
oSection:Init()                              

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a variavel aInfo com a filial Logada              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
fInfo(@aInfo,(cAliasQry)->RA_FILIAL)

cFilAnte	:= (cAliasQry)->RA_FILIAL
cCcAnt		:= (cAliasQry)->RA_CC
cTnoAnt		:= (cAliasQry)->RA_TNOTRAB

While !(cAliasQry)->( EOF() ) 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua de Processamento                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:IncMeter( 1 )   

	//-- Verifica se o usuário cancelou a impressão do relatorio
	If oReport:Cancel()
		Exit
	EndIf               

	SRA->( dbGoTo( (cAliasQry)->RECNO ) )

	If lCCTur 
		If (nOrdem == 2 .Or. nOrdem == 5) .And. cFilAnte + cCcAnt <> (cAliasQry)->RA_FILIAL +(cAliasQry)->RA_CC
			cFilAnte	:= (cAliasQry)->RA_FILIAL
			cCcAnt		:= (cAliasQry)->RA_CC
			oReport:EndPage()
			lPrintHeader := .F.
		Elseif nOrdem == 4 .And. cFilAnte + cTnoAnt <> (cAliasQry)->RA_FILIAL +(cAliasQry)->RA_TNOTRAB
			cFilAnte	:= (cAliasQry)->RA_FILIAL
			cTnoAnt		:= (cAliasQry)->RA_TNOTRAB
			oReport:EndPage()
			lPrintHeader := .F.
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

		cFilAnte := SRA->RA_FILIAL
		
	    If !Empty(cTnoAnt)
	   		cTnoAnt := (cAliasQry)->RA_TNOTRAB
			cCcAnt  := (cAliasQry)->RA_CC
			If lCCTur .And. (nOrdem == 2 .Or. nOrdem == 4)
				oReport:EndPage()
				lPrintHeader := .F.
			Endif
		Endif
		
		If !fInfo(@aInfo,(cAliasQry)->RA_FILIAL)
			Exit
		Endif	
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Carrega Crachas Provisorios                   			  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If lCracha
			//-- Se For Exclusivo, carrega crachas provisorios para a Filial Lida 
			If !( xFilial("SPE") == space(FWGETTAMFILIAL) )
			    aProvis:={}
			    LoadCracha(@aProvis,(cAliasQry)->RA_FILIAL)
			Else
	            //-- Se compartilhado, carrega Todos os Registros se estiver vazio
			    If Len(aProvis)==0
			       LoadCracha(@aProvis)
			    Endif
			Endif
		Endif

	Endif

	If cTnoAnt != (cAliasQry)->RA_TNOTRAB
		If !Empty(cTnoAnt)
			cTnoAnt := (cAliasQry)->RA_TNOTRAB
			If lCCTur .And. nOrdem == 4
				oReport:EndPage()
				lPrintHeader := .F.
			Endif
		Endif
		cSeqAnt := (cAliasQry)->RA_SEQTURN
	Endif

	//-- Reinicializa Variaveis do Funcionario
	aTabCalend	:= {} 
	aTurnos		:= {}
	aMarcacoes	:= {}

	aHP 		:= {}
	aHR 		:= {}

	aFun		:= {}
	
	//-- Carrega as Marcacoes do Periodo
	IF !GetMarcacoes( @aMarcacoes		,;	//Marcacoes dos Funcionarios
					  @aTabCalend		,;	//Calendario de Marcacoes
					  @aTabPadrao		,;	//Tabela Padrao
					  @aTurnos			,;	//Turnos de Trabalho
					  dPerIni 			,;	//Periodo Inicial
					  dPerFim			,;	//Periodo Final
					  (cAliasQry)->RA_FILIAL	,;	//Filial
					  (cAliasQry)->RA_MAT		,;	//Matricula
					  (cAliasQry)->RA_TNOTRAB	,;	//Turno
					  (cAliasQry)->RA_SEQTURN	,;	//Sequencia de Turno
					  (cAliasQry)->RA_CC		,;	//Centro de Custo
					  "SP8"				,;	//Alias para Carga das Marcacoes
					  .F.    			,;	//Se carrega Recno em aMarcacoes
					  .T.      			,;	//Se considera Apenas Ordenadas
					  .T.      			,;	//Se Verifica as Folgas Automaticas
					  .F.      			 ;	//Se Grava Evento de Folga Automatica Periodo Anterior
					)
		
		If Alltrim((cAliasQry)->RA_REGRA)== ""			
			Iif(cFunRegra == "","","/")		
			cFunRegra := cFunRegra+" / "+Alltrim((cAliasQry)->RA_MAT)
	    EndIf
    EndIF

	//-- Monta Array com Marcacoes Previstas.
	nCal 		:= aScan( aTabCalend, { |x| x[4] == '1E' .and. x[1] >= Max( dPerIni , (cAliasQry)->RA_ADMISSA ) } )
	nCal 		:= If(nCal>0,nCal,1)
	aPrevisto 	:= {}	
	aJornada	:= {}    
	nLenCalend	:= Len(aTabCalend)
	
	//-- Corre Todas as Previsoes de Horarios
	While nCal <= nLenCalend	
		//-- Desconsidera Datas Fora do Periodo
		If (aTabCalend[nCal,1] < dRefDe .Or. aTabCalend[nCal,1] > dRefAte).OR.;
		   aTabCalend[nCal,4]<>"1E"
		   nCal ++
		   Loop
		EndIf

		//-- Desconsidera as datas quando o funcionário é isento de marcações
		If Len(aTabCalend[nCal]) >= 56 .And. aTabCalend[nCal, 56]
			nCal++
			Loop
		EndIf
		
		cOrdem     := aTabCalend[nCal,2] //-- Ordem
		dData	   := aTabCalend[nCal,1] //-- Data da Tabela Hor. Padrao	
		cTipoDia   := aTabCalend[nCal,6] //-- Tipo do Dia
		nQtdeHoras := aTabCalend[nCal,7] //-- Qtde de Horas trab. no Dia
		lAfastado  := aTabCalend[nCal,24] //-- Afastamento
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Para dias de Afastamento verifica se deve considerar ou nao  ³
		//³ o dia conforme o tipo de afastamento.						 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAfastado   
		    //-- Se o tipo de afastamento não for ferias e não se deve considerar afastamentos diferentes de férias ou ambos 
		    //-- ou 
		    //-- Se o tipo de afastamento é ferias e não se deve considerar afastamentos de ferias ou ambos
		    //-- o dia não eh valido, caso contrario considera o dia.
			If ( 	(nAfast == 4 ) .or.  ;
					( aTabCalend[nCal,CALEND_POS_TIP_AFAST] <> "F"  .AND. (nAfast <> 2 .AND. nAfast <> 3)  ) .or.  ;
			   		( aTabCalend[nCal,CALEND_POS_TIP_AFAST] == "F"  .AND. (nAfast <> 1 .AND. nAfast <> 3)  )       ;
			   	)
			   	  nCal ++
			   Loop
			EndIf
		Endif
	    //-- Se Verifica Jornada e deve checar Inicio Jornada e a
	    //-- Hora inicial da Tabela for superior/igual a hora de checagem
		If !lNaoVerifJrn .AND. lCkIniJorn .AND. nSerHoraCk < fDhtoNs(dData,aTabCalend[nCal,3]) 
		   nCal ++
		   Loop
		Endif 
	    cPrevisto  :=''  
	    aHorarios  :={}
	    
		//-- Corre as Previsoes de mesma Ordem
		While cOrdem == aTabCalend[nCal,2]
			//-- Cria String com os Horarios Previstos
			cPrevisto+= StrZero(aTabCalend[nCal,3],5,2) + Space(1)
		    //-- Somente Para Entradas Considera Inicio de Jornadas
		    If Substr(aTabCalend[nCal,4],2,1)='E'
		   	   aAdd(aHorarios,	;
		   	                 Jornadas(aTabCalend[nCal,4],;	//1e/2e/3e/4e 
		   	                 aTabCalend[nCal,1],;    		//Data de Referencia Lim Inferior
		          			 aTabCalend[nCal,3],;	 		//Limite Inferior da Jornada em Serial
		          			 aTabCalend[nCal+1,1],;    		//Data de Referencia Lim Sup
		          			 aTabCalend[nCal+1,3]))			//Limite Superior da Jornada em Serial
		    				
		    Endif      			 
			nCal ++                  
			If	nCal > nLenCalend
			    Exit
			Endif    
		EndDo
		//-- Cria Elemento com Data/Horario/Ordem/Tipo do Dia/Afastado
		aAdd( aPrevisto, {dData, cPrevisto, cOrdem, cTipoDia, lAfastado})
		//-- Cria Elemento com os Horarios das Jornadas como SubArray
		aAdd(aJornada, {cOrdem, Aclone(aHorarios), nQtdeHoras})
	EndDo

	//-- Monta Array com Marcacoes Realizadas.
	nPosJrn		:=0
	aRealizado 	:= {}
	nNumMarc   	:=0
	nLenMarc	:=Len(aMarcacoes)
	nLenaJornada:=Len(aJornada)
	
	//-- Se Existirem Marcacoes
	If !EMPTY(nLenMarc)
		//Corre Todas as Ordens (Cada Elemento em aJornada contem todas as Jornadas de mesma ordem)  
		For nX:=1 To nLenaJornada
			cOrdem := aJornada[nX,1]
					
			//-- Obtem a 1a das Marcacoes Segunda a Ordem Lida
			nPosJrn:= Ascan(aMarcacoes,{|x| x[3]==cOrdem})
			//-- Se Nao Existir Marcacao para a Ordem despreza 
			If Empty(nPosJrn)
			   Loop
			Endif
			//-- Corre as Marcacoes da ordem
		    nNumMarc	:=0
		    cRealizado	:=''
			nMarc		:=nPosJrn
			While cOrdem == aMarcacoes[nMarc,3]
				If (nMarc > 0 .and. nMarc <= nLenMarc)
					If nMarc < nLenMarc
						If SubStr( aMarcacoes[nMarc,AMARC_TIPOMARC],1,1 )  == SubStr( aMarcacoes[nMarc+1,AMARC_TIPOMARC],1,1 ) .and. ;
							aMarcacoes[nMarc,AMARC_ORDEM] == aMarcacoes[nMarc+1,AMARC_ORDEM]
							lMod := .T.
							lPar := .T.
						Else
							If nMarc > 1
								If SubStr( aMarcacoes[nMarc-1,AMARC_TIPOMARC],1,1 )  == SubStr( aMarcacoes[nMarc,AMARC_TIPOMARC],1,1 ) .and. ;
									aMarcacoes[nMarc-1,AMARC_ORDEM] == aMarcacoes[nMarc,AMARC_ORDEM]
									lMod := .T.
									lPar := .T.
								Else
									If( aMarcacoes[nMarc-1,AMARC_ORDEM] == aMarcacoes[nMarc,AMARC_ORDEM], lMod := .F., lMod := .T. )
									lPar := .F.
								EndIf
							Else
								lMod := .T.
								lPar := .T.
							EndIf
						EndIf
					Else
						If (nMarc == 1 .and. nLenMarc == 1)
							lMod := .F.
							lPar := .F.
						Else
							If SubStr( aMarcacoes[nMarc-1,AMARC_TIPOMARC],1,1 )  != SubStr( aMarcacoes[nMarc,AMARC_TIPOMARC],1,1 ) .and. ;
								aMarcacoes[nMarc-1,AMARC_ORDEM] != aMarcacoes[nMarc,AMARC_ORDEM]
								lMod := .F.
							Else
								lMod := .F.
							EndIf
						EndIf
					EndIf
				EndIf
				nNumMarc++
				cRealizado += StrZero(aMarcacoes[nMarc,2],5,2) + Space(1)
			    //-- Verifica Ausencia/Presenca nas Jornadas conforme Marcacao
				Classifica(aMarcacoes[nMarc,1], aMarcacoes[nMarc,2],@aJornada,nX,nNumMarc,lMod,nMarc,lPar)
				nMarc++
				//-- Se o contador ultrapassar o total de Marcacoes abandona loop
				If nMarc>nLenMarc
					Exit
				Endif   
			EndDo
			//-- Cria Elemento que conterah as marcacoes realizadas
			aAdd(aRealizado, {aMarcacoes[nPosJrn,1], cRealizado, cOrdem})
		Next nX
	Endif 
	
	//-- Para Jornadas Sem Classificacao Considera que Houve Ausencia do Funcionario
	//-- Y[4]:= A1E OU A2E OU A3E ....
	AEVAL(aJornada, {|x| Aeval( x[2], {|y| if(Empty(y[4]), y[4] := 'A' + Y[3], Nil) })})
	nPosJrn	:=0
	//-- Monta array com as Marcacoes a serem impressas.
	
	nLenPrev	:=Len(aPrevisto)
	cRealizado	:=''
	For nPre := 1 to nLenPrev		
		cPrevisto  := ''
		cRealizado := '' 
		cDet       := ''
		cTipAfas   := ''
		dDtAfas    := CtoD('  /  /  ')
		dDtRet     := CtoD('  /  /  ')		
		
		cPrevisto := StrTran(aPrevisto[nPre,2],'.',':')
		cPrevisto += Space(24-Len(cPrevisto))
		If ( nPos := aScan( aRealizado, { |x| x[3] == aPrevisto[nPre,3] } ) ) > 0
			cRealizado := StrTran(aRealizado[nPos,2],'.',':')
		EndIf
		
		aAdd(aFun, {PADR(DtoC(aPrevisto[nPre,1]),10),Space(11),Space(11),Space(11),Space(11),Space(11),Space(11),Space(11),Space(11),Space(11),Space(11)})
		
		aHP := DetHorario(cPrevisto, 4 )
		If Len(aHP) < 4
			For nHr := Max(Len(aHP),1)+1 to 4
				aAdd(aHP,Space(11))
			Next
		Endif
		For nHr := 1 to Len(aHP)
			aFun[Len(aFun),nHr+1] := aHP [ nHr ]	// Horarios Programados
		Next
				
		//-- Procura pelas Jornadas da Ordem
		nPosJrn:=Ascan(aJornada,{|x|x[1]==aPrevisto[nPre,3]})
		
		//-- Verifica se houve Ausencia em alguma das Jornadas da Ordem
		nPosOcor:=Ascan(aJornada[nPosJrn,2],{|x|Substr(x[4],1,1)=='A'}) 
		
		If !lAusente //-- Presentes 
			
			//-- Se nao Houve Marcacoes ou (se Ocorreu Alguma Ausencia e o usuario
			//-- deseja presenca no dia todo)
		    //-- Desconsidera Marcacoes do dia para Relacao de Presentes
			If Len(cRealizado) <= 0 
				aDel(aFun,Len(aFun))
				aFun := aSize(aFun,Len(aFun)-1)
				Loop
			EndIf  
			//-- Se Nao Verifica Jornadas
			If lNaoVerifJrn 		        
		        //-- Alimenta String com as Marcacoes Ocorridas
				cOcorr:=cRealizado
			Else    
			    //-- Carrega Presencas nas Jornadas do Dia Lido
				aOcorr:={}
				Aeval(aJornada[nPosJrn,2], {|x|iF(Substr(x[4],1,1)=='P' .AND. !Empty(Substr(x[4],2,1)),aAdd(aOcorr,Substr(x[4],2,2)),Nil)})
			    //-- Para Dias sem horario a Tabela Padrao Gera uma Jornada com horarios Zerados
		        //-- a Funcao Classifica acusa presenca para funcionarios com marcacoes nesse dia
		        //-- colocando no 4o. Elemento a letra 'P' sem a definicao da entrada (1E/2E...)
		        //-- Deste modo adotamos que, para dias sem horario mas com marcacao, o funcionario
		        //-- este presente em todas as jornadas. 
				
		        //-- Se Nao houver a identificacao da jornada 
				If Empty(Len(aOcorr))
		            //-- Se Nao ocorreram ausencias
		            //-- funcionario fez horario em dia NAO TRABALHADO
					If Empty(nPosOcor)
						cOcorr:=cRealizado
					Else
		        	   //-- Funcionario Nao Veio nas Jornadas Solicitadas, embora
		        	   //-- Possa ter realizado marcacoes em outro horario(Fora da Tabela)
						aDel(aFun,Len(aFun))
						aFun := aSize(aFun,Len(aFun)-1)
						Loop
					Endif   
				Else
					cOcorr:=''
				    //-- Se Deve Verificar Presenca em Todas as Jornadas
				    //-- Verifica se houve Presenca Parcial
					If lTodasJrn
						//-- Se o Func. teve Presenca Parcial (Total de Presenca <> Total de Jornadas)
						//-- e Escolheu mais que uma Jornada
						If Len(aOcorr)#Len(aJornada[nPosJrn,2]) 
							aDel(aFun,Len(aFun))
							aFun := aSize(aFun,Len(aFun)-1)
							Loop
						Endif
						cOcorr := cRealizado
					Else
					    //-- Imprime Jornadas com Presenca 
						For nOcorr := 1 To Len(aOcorr)
							//--Verifica se a Ocorrencia existiu em uma das Jornadas Selecionadas
							If aOcorr[nOcorr] $ cjornadas
								cOcorr := cRealizado
								Exit
							Endif	
						Next nOcorr              
					Endif
					
				    //-- Para as Jornadas selecionadas o func nao esteve presente
				    //-- embora tenha marcacao para outras jornadas do dia.
					If Empty(cOcorr)
						aDel(aFun,Len(aFun))
						aFun := aSize(aFun,Len(aFun)-1)
						Loop
					Endif   
				Endif
			Endif
			
			//-- Imprime Jornadas com Presenca 
			aHR := DetHorario(cOcorr, 5, aOcorr)
			If Len(aHR) < 5
				For nHr := Max(Len(aHr),1)+1 to 5
					aAdd(aHR,Space(11))
				Next
			Endif
			For nHr := 1 to Len(aHR)
				aFun[Len(aFun),nHr+5] := aHR [ nHr ]	// Horarios Realizados
			Next
			
		Else //-- Ausentes
			//-- Se Nao Houve Ausencias
			//-- Ou Tipo de Dia Diferente de Trabalhado/Feriado ou
			//-- situacao de Transferido/ferias e demissao
			If	Empty(nPosOcor) .OR. ;
				(aPrevisto[nPre,4] # 'S' .And. !aPrevisto[nPre,5])  .Or. ;
				(fFeriado((cAliasQry)->RA_FILIAL,aPrevisto[nPre,1]) .And. aPrevisto[nPre,4] != 'S')  .Or. ;
				(cAliasQry)->RA_SitFolh $ 'DúT' .And. aPrevisto[nPre,1] > (cAliasQry)->RA_Demissa
				aDel(aFun,Len(aFun))
				aFun := aSize(aFun,Len(aFun)-1)
				Loop
			EndIf
			
			//-- Carrega as Ocorrencias de Ausencias nas Jornadas do Dia Lido
			aOcorr:={}
			Aeval(aJornada[nPosJrn,2],{|x|iF(Substr(x[4],1,1)=='A',aAdd(aOcorr,Substr(x[4],2,2)),Nil)})		   		    
			
		    //-- Se Nao Verifica Jornadas
			if lNaoVerifJrn     
		       //-- Se ocorreu marcacoes desconsidera o dia
				If Len(cRealizado) > 0 
					aDel(aFun,Len(aFun))
					aFun := aSize(aFun,Len(aFun)-1)
					Loop
				EndIf  
				If fAfasta( (cAliasQry)->RA_FILIAL,(cAliasQry)->RA_Mat,aPrevisto[nPre,1],@dDtafas,@dDtRet,@cTipAfas) .Or. ;
					(cAliasQry)->RA_SitFolh $ 'DúT' .And. aPrevisto[nPre,1] > (cAliasQry)->RA_DEMISSA
					//-- Imprime Jornadas com Presenca 
					aFun[Len(aFun),6] := AllTrim(PADC(If(cTipAfas=='F',STR0018,STR0019 ),50))		 // '           ** Ferias **            '###'          ** Afastado **           '
					
					For nHr := 1 to 4
						aFun[Len(aFun),nHr+6] := Space(11)
					Next
					
				Else   
					
					aHR := DetAusencia(aOcorr,Len(aJornada[nPosJrn,2]),.T.)
					If Len(aHR) < 5
						For nHr := Max(Len(aHR),1)+1 to 5
							aAdd(aHP,Space(11))
						Next
					Endif
					For nHr := 1 to Len(aHR)
						aFun[Len(aFun),nHr+5] := aHR [ nHr ]	// Horarios Realizados
					Next
					
				Endif 
			Else
				//-- Se optou por Verificar Jornadas
			    //-- Verifica Afastamentos
				If fAfasta( (cAliasQry)->RA_FILIAL, (cAliasQry)->RA_MAT, aPrevisto[nPre, 1], @dDtafas, @dDtRet, @cTipAfas) .Or. ;
					(cAliasQry)->RA_SITFOLH $ 'DúT' .And. aPrevisto[nPre,1] > (cAliasQry)->RA_DEMISSA
					
					aFun[Len(aFun),6] := AllTrim(PADC(If(cTipAfas=='F',STR0018,STR0019 ),50))						 // '           ** Ferias **            '###'          ** Afastado **           '
					
					For nHr := 1 to 4
						aFun[Len(aFun),nHr+6] := Space(11)
					Next
					
				Else
					lOcorr := .F.
				    //-- Se Deve Verificar Ausencia em Todas as Jornadas
				    //-- Verifica se houve Ausencia Parcial
					If lTodasJrn
				     	//-- Se o Func. teve Ausencia Parcial (Total de ausencia <> Total de Jornadas)
						If Len(aOcorr) # Len(aJornada[nPosJrn, 2]) 
							aDel(aFun, Len(aFun))
							aFun := aSize(aFun, Len(aFun) - 1)
							Loop
						Endif 
						lOcorr:= .T.
					Else	
					    //-- Imprime Jornadas com Presenca 
						For nOcorr := 1 To Len(aOcorr)
							//--Verifica se a Ocorrencia existiu em uma das Jornadas Selecionadas
							If aOcorr[nOcorr] $ cjornadas
								lOcorr:= .T.
								Exit
							Endif	
						Next nOcorr  
					Endif                
			        //-- Para as Jornadas selecionadas o func nao esteve presente
			        //-- embora tenha marcacao para outras jornadas do dia.
					If !lOcorr
						aDel(aFun,Len(aFun))
						aFun := aSize(aFun,Len(aFun)-1)
						Loop
					Endif  
					
					aHR := DetAusencia(aOcorr, Len(aJornada[nPosJrn, 2]), .T.)
					If Len(aHR) < 5
						For nHr := Max(Len(aHR), 1) + 1 to 5
							aAdd(aHR, Space(11))
						Next
					Endif
					For nHr := 1 to Len(aHR)
						aFun[Len(aFun), nHr + 5] := aHR [ nHr ]
					Next
					
				Endif
			Endif   	   
		EndIf           
		
		aFun[Len(aFun),11] := If(lCracha,GetCracha(aPrevisto[nPre,1],aProvis)," ")	// Horarios Programados
		
		aOcorr:={}
	Next nPre
	
	// Verifica se não carregou as marcações e salta para o proximo funcionario
	If Len(aFun) == 0
		(cAliasQry)->(DbSkip())
		Loop
	Endif
	
	If lPrintHeader
		oSection:PrintHeader() 
	Endif		
	oSection:PrintLine()
	
	lPrintHeader := .T.
	oReport:SkipLine()
	If !lUmDia
		oReport:ThinLine()
		oReport:PrintText(Space(10)+PADC(STR0071,50) + PADC(STR0072,80))	// "Horario Programado" ### "Horario Realizado" 
		oReport:ThinLine()
	Endif
	oSection1:Init(.F.) 
	
	If !lUmDia
		oSection1:PrintHeader() 
	Endif
	
	For nPre := 1 to Len( aFun )
		//-- Altera valores da Section
		oSection1:Cell( "DATA"):SetValue(aFun[nPre,1])

		oSection1:Cell( "HP1"):SetValue(aFun[nPre,2])
		oSection1:Cell( "HP2"):SetValue(aFun[nPre,3])
		oSection1:Cell( "HP3"):SetValue(aFun[nPre,4])
		oSection1:Cell( "HP4"):SetValue(aFun[nPre,5])

		oSection1:Cell( "HR1"):SetValue(aFun[nPre,6])
		oSection1:Cell( "HR2"):SetValue(aFun[nPre,7])
		oSection1:Cell( "HR3"):SetValue(aFun[nPre,8])
		oSection1:Cell( "HR4"):SetValue(aFun[nPre,9])
		oSection1:Cell( "HR5"):SetValue(aFun[nPre,10])

		If lCracha
			oSection1:Cell( "CRACHA"):SetValue(aFun[nPre,11])
		Endif
		
	   	oSection1:PrintLine()
	Next

	oSection1:Finish()
	oReport:ThinLine()
	oReport:SkipLine()		

	(cAliasQry)->(DbSkip())
	
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza impressao inicializada pelo metodo Init             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection:Finish()

If cFunRegra <> ""  
	MsgAlert(STR0053+STR0054+alltrim(cFunRegra))
	//"Atencao" ### "Os seguintes funcionarios estao sem regras de apontamento cadastradas:" ##Matricula dos Funcionarios## ### "OK" ###
EndIf

If Select(cAliasQry) > 0
	(cAliasQry)->(dbCloseArea())
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³DetHorario  ³ Autor ³ Mauricio MR           ³ Data ³26/10/01³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Linha Detalhe de Marcacoes                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ DetHorario(cHorario,nTam)                                  ³±±
±±³          ³ cHorario -> Texto com as marcacoes 08:00 12:00 13:00 17:00 ³±±
±±³          ³ nTam     -> Numero de jornadas (Pares de horarios)         ³±± 
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ cTexto   -> Jornadas Delimitadas por '|'                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Ponr030                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function DetHorario(cHorario, nTam, aOcorr)
	
	Local nPos		:= 1 
	Local cHora		:= ''
	Local nHorario	:=	0
	Local aHorarios := {}

	Default aOcorr	:= {}
	
	cHorario := ALLTRIM(cHorario)
	
	//-- Corre Todas as Jornadas (Max de 5 conforme cabecalho) 
	For nHorario := 1 To nTam
		cHora := Substr(cHorario, npos, 11)
		If Empty(aOcorr) .Or. Ascan(aOcorr, {|x| Val(substr(x, 1, 1)) == nHorario}) > 0 .And. !Empty(cHora)
			aAdd(aHorarios, PADR(cHora, 11))
			npos += 12
		Else
			aAdd(aHorarios, Space(11))
		Endif
		
	Next nHorario    
	
Return aHorarios


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³DetAusencia ³ Autor ³ Mauricio MR           ³ Data ³26/10/01³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Linha Detalhe de Marcacoes                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ DetAusencia(aOcorr,nNumJrn)                                ³±±
±±³          ³ aOcorr    -> Array com as Ocorrencias: A1e / A2e ...       ³±±
±±³          ³ nNumJrn   -> Qtde de Jornadas Previstas                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ cTexto   -> 1a Letra de cada Ocorrencia Centralizada e     ³±±
±±³          ³             Delimitada por '|'                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Ponr030                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function DetAusencia(aOcorr, nNumJrn, lTReport)

Local nJornada 	:= 0
Local cTexto	:='|'
Local nPos		:= 0 
Local aHorarios	:= {}

Default lTReport := .F.

If lTReport
	
	//-- Corre Todas as Jornadas (Max de 5 conforme cabecalho) 
	For nJornada := 1 To 5
		
		cTexto := ""
		 //-- Se Nao Verifica Jornadas
		if lNaoVerifJrn
			cTexto += If(nJornada <= nNumJrn, Space(5) + 'A' + Space(5), Space(11)) 	
		Else
			//Verifica se Ocorrencia estah entre as Jornadas Solicitadas
			npos := Ascan(aOcorr, {|x| Val(substr(x, 1, 1)) == nJornada})
			If !Empty(nPos) .AND. nJornada <= nNumJrn  
				cTexto += Space(5) + 'A' + Space(5) 
			Else
				cTexto += Space(11)
			Endif	             
		Endif
		aAdd(aHorarios, cTexto)
	Next nJornada    
	
	Return aHorarios
Else
	//-- Corre Todas as Jornadas (Max de 5 conforme cabecalho) 
	For nJornada:=1 To 5
		 //-- Se Nao Verifica Jornadas
		if lNaoVerifJrn     
			cTexto+=If(nJornada<=nNumJrn,Space(5) +'A'+Space(5),Space(11)) 	
		Else
			//Verifica se Ocorrencia estah entre as Jornadas Solicitadas
			npos:=Ascan(aOcorr,{|x| Val(substr(x,1,1))==nJornada})
			If !Empty(nPos) .AND. nJornada<=nNumJrn  
				cTexto+=Space(5) +'A'+Space(5) 
			Else
				cTexto+=Space(11)
			Endif	             
		Endif
		cTexto+='|'
	Next nJornada    
	
	Return cTexto             
Endif



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fValidJorn  ³ Autor ³Equipe Advanced RH     ³ Data ³22/10/01³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Validar a multipla escolha do tipo de marcacao 1E/2E/3E/4E  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_fValidJorn( l1Elem , cTipo )                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observa‡„o³ Retorna Marcacoes de Entrada para Escolha de Jornada       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Ponr030                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function fValidJorn( l1Elem , cTipo )

Local aMarc		:= {}
Local cMarc		:= ""
Local cTitulo	:= STR0034 // Selecione as Jornadas com Inicio na: 
Local MvParDef	:= ""
Local MvPar		:= &( Alltrim( ReadVar() ) )
Local nX		:= 0.00
Local nCampos	:= SPJ->( fCount() )
Local lRet	    := .T.

l1Elem			:= IF( l1Elem == NIL .and. ValType( l1Elem ) != "L" , .F. , .T. )
MvRet			:= Alltrim( ReadVar() )

IF cTipo != 'I'       

	For nX := 1 To nCampos
		cCampo := SPJ->( FieldName( nX ) )
		IF Subs(cCampo,1,8) == "PJ_ENTRA" 
			cMarc := Subs( cCampo , 9 , 1) + Subs( cCampo , 4 , 1 )
			MvParDef += ( cMarc + "-" )
			aAdd( aMarc , cMarc += ( "-" + GetDescMarc( cMarc  ) ) )
		EndIF
	Next nX
Else
	aAdd( aMarc , "I1-" + GetDescMarc( "I1" ) )
	aAdd( aMarc , "I2-" + GetDescMarc( "I2" ) )
	aAdd( aMarc , "I3-" + GetDescMarc( "I3" ) )
	MvParDef := "I1-I2-I3-"
EndIF

IF MvPar != NIL
	f_Opcoes(@MvPar,cTitulo,aMarc,MvParDef,12,49,l1Elem,3)
EndIF	

lRet:=.T.
&(MvRet) := MvPar
if Empty(&(MvRet))
   lRet:=.F.
Endif


Return( lRet )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Classifica³ Autor ³ Mauricio MR           ³ Data ³ 26/10/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Classifica ARRAY aJornadas de Acordo com Existencia de     ³±±
±±³          ³ Marcacoes nas respectivas Jornadas.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ classifica(dMarc,hMarc,aJornada,nPos,nMarc)                ³±±
±±³          ³ dMarc     -> Data da Marcacao                              ³±±
±±³          ³ hMarc     -> Hora da Marcacao                              ³±±
±±³          ³ aJornada  -> Array com a Estrutura:                        ³±±
±±³          ³              [1] Ordem do Dia                              ³±±
±±³          ³              [2] [1] Hora Inicial Jornada em No.Serial     ³±±
±±³          ³              [2] [2] Hora Final                            ³±±
±±³          ³              [2] [3] Tipo de Entrada: 1e/2e/3e...          ³±±
±±³          ³              [2] [4] Ausencia/Presenca: A/P ou A1e/P1e...  ³±±
±±³          ³              [3] Total de Horas da Jornada                 ³±±
±±³          ³ nPos      -> Posicao da Jornada Lida                       ³±±
±±³          ³ nMarc     -> Numero da Marcacao da Ordem                   ³±±
±±³          ³ Retorna   -> aJornada[2][4] com A-Ausencia/P-Presenca      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Ponr030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function classifica(dMarc,hMarc,aJornada,nPos,nMarc,lMod,nNumMarc,lPar)
	
	Local nSerMarc	:= 0
	Local nW     	:= 0
	Local nFim 		:= 0
	
	Default lMod  := .F.
	
	//-- Obtem o numero de horas/minutos da Marcacao
	nSerMarc := 0
	nSerMarc := NoRound(fDHtoNS(dMarc, hMarc))
	//-- Corre todas as Jornadas do Dia
	nW := 0     
	nFim := Len(aJornada[nPos, 2])
	
	For nW := 1 To nFim
		nIniJrn := aJornada[nPos, 2, nW, 1] //Limite Inferior da Jornada
		nFimJrn := aJornada[nPos, 2, nW, 2] //Limite Superior da Jornada
		
		If nSerMarc < nFimJrn .OR. (nSerMarc = nFimJrn .AND. nMarc > 1)
			//-- Funcionario Presente na Jornada 
			If Empty(aJornada[nPos, 2, nW, 4])
				aJornada[nPos, 2, nW, 4] := 'P' + aJornada[nPos, 2, nW, 3]  //Presente na Jornada
			Endif
			Exit
		EndIf
	Next
	
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Jornadas  ³ Autor ³ Mauricio MR           ³ Data ³ 26/10/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria ARRAY aJornadas a partir das Marcacoes de Entrada     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Jornadas(cTipo, dDataInf, LimInf,dDataSup,LimSuper)        ³±±
±±³          ³ cTipo     -> Tipo da Entrada : 1e/2e/3e...                 ³±±
±±³          ³ dDataInf  -> Data da Jornada Lim Inf                       ³±±
±±³          ³ LimInf    -> Hora Inicial da Jornada                       ³±±
±±³          ³ dDataSup  -> Data da Jornada Lim Sup                       ³±±
±±³          ³ LimSuper  -> Hora Final da Jornada                         ³±±
±±³          ³ Retorna   -> aRet Array aJornada                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Ponr030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/


static function Jornadas(cTipo,dDataInf,LimInf,dDataSup,LimSuper)
Local aRet:={}


If Substr(cTipo,2,1)='E'
	
	aret:={NoRound(fDhToNs(dDataInf,LimInf))	,;	//Limite Inferior da Jornada em Serial
		   NoRound(fDhToNs(dDataSup,LimSuper))	,;	//Limite Superior da Jornada em Serial
		   cTipo		   						,;	//Jornada com Inicio na 1e/2e/...
		   {}}                	 					//Reservado para Conter Ocorrencias
Endif

Return aRet

   
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GetCracha ³ Autor ³ Mauricio MR           ³ Data ³ 11/12/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Obtem o Cracha do funcionario em determinada data          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GetCracha(dData)                                           ³±±
±±³          ³ Retorna   -> cCracha do Dia                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Ponr030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/


Static Function GetCracha(dData,aProvis,cCracha,cMat)

DEFAULT cCracha	:=SRA->RA_CRACHA 
DEFAULT cMat	:=SRA->RA_MAT

nPos:=Ascan(aProvis,{|x| x[1]<=dData .AND. x[2]>=dData .And. x[4]==cMat})
If nPos>0
   cCracha:=aProvis[nPos,3]
Endif

Return cCracha


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³LoadCracha³ Autor ³ Mauricio MR           ³ Data ³ 11/12/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega Crachas da Filial(Exclusivo) ou Todos(Compartilhado³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ LoadCracha(@aCracha,cFil)                                  ³±±
±±³          ³ Retorna   -> aCracha                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Ponr030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/


Static Function LoadCracha(aCracha,cFil)
Local aArea:=GetArea()
Local aAreaSPE:=SPE->(GetArea())
Local cRefDE:=Dtos(dRefDE),cRefATE:=Dtos(dRefATE),cdIni,cdFim
DEFAULT cFil := fFilFunc("SPE") 

SPE->(dbsetorder(1))
SPE->(Dbseek(cFil))

//-- Carrega crachas da filial (se Exclusivo) ou Todos (caso contrario)
While !SPE->(Eof()) .AND. SPE->PE_FILIAL == cFil                          
    cdIni:=Dtos(SPE->PE_DATAINI)
    cdFim:=Dtos(SPE->PE_DATAFIM)
    //-- Somente Considera Intervalos que compreende o Periodo Solicitado
    If (cRefDE  >= cdIni   .AND. cRefDE  <= cdFim   ) .OR.;
       (cRefATE >= cdIni   .AND. cRefATE <= cdFim   ) .OR. ;
       (cdIni   >= cRefDE  .AND. cdIni   <= cRefATE )  .OR.;
       (cdFim   >= cRefDE  .AND. cdFim   <= cRefATE )         
       aAdd(aCracha,{SPE->PE_DATAINI,SPE->PE_DATAFIM,SPE->PE_MATPROV,SPE->PE_MAT})
	Endif
	SPE->(dbSkip())
Enddo

RestArea(aAreaSPE)
RestArea(aArea)

Return aCracha
