/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR040.CH"
#INCLUDE "PONCALEN.CH"
#INCLUDE "report.ch"

Static cPerg		:= "PN040R"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ PONR040  ³ Autor ³ R.H. - J. Ricardo     ³ Data ³ 10.04.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Divergencias nas marcacoes                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR040(void)                                              ³±±
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
±±³Eduardo K.  ³21/07/16³      ³Ajuste no carregamento das perguntas      ³±±
±±³            ³        ³      ³quando agendado no schedule.    		  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function PONR040()
Local	oReport   
Local	aArea 		:= GetArea()
Private nColPro	:= 0

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
±±³Descri‡ao ³ Divergencias nas marcacoes                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PONR040                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR040 - Generico                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport 
Local oSection1 
Local oSection2 

Private aOrd    	:= {STR0004 , STR0005 , STR0006 , STR0007 , STR0030 } // 'Matricula'###'Centro de Custo'###'Nome'###'Turno'###'C.Custo+Nome'
Private cTitulo		:= OemToAnsi(STR0001)			//'Divergencias nas Marcacoes'

//-- Criacao dos componentes de impressao
DEFINE REPORT oReport NAME "PONR040" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PN040Imp(oReport)} DESCRIPTION OemtoAnsi(STR0043) TOTAL IN COLUMN // "Este programa emite Relacao dos Funcionarios com Divergencias de Marcacoes"

	oSection1 := TRSection():New( oReport, OemToAnsi(STR0044), {"SRA","CTT","SR6"}, aOrd,,,,,.F.,.F.,.F.) // "Funcionarios"

		TRCell():New(oSection1,"RA_FILIAL"	,"SRA")
		TRCell():New(oSection1,"RA_CHAPA"	,"SRA",,,5)
		TRCell():New(oSection1,"RA_MAT"		,"SRA",,,6)
		TRCell():New(oSection1,"RA_NOME"	,"SRA",,,30,,,,.T.)
		TRCell():New(oSection1,"RA_CC"		,"SRA",OemToAnsi(STR0048),,9)	// "C.Custo"
		TRCell():New(oSection1,"CTT_DESC01"	,"CTT",,,25,,,,.T.)
		TRCell():New(oSection1,"RA_TNOTRAB"	,"SRA",OemToAnsi(STR0049),,3)	// "Tno"
		TRCell():New(oSection1,"R6_DESC"	,"SR6",,,20,,,,.T.)

	oSection2 := TRSection():New( oSection1, OemToAnsi(STR0046),,,,,,,.F.,.F.,.F. )	 //"Marcações"

		TRCell():New( oSection2, "DATA"			, "" ,OemToAnsi(STR0047),,10)		// "Data"
		TRCell():New( oSection2, "MARCACOES"	, "" ,OemToAnsi(STR0046),,80)		// "Marcações"
		TRCell():New( oSection2, "OCORRENCIAS"	, "" ,OemToAnsi(STR0045),,50)		// "Ocorrencias"

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PN040Imp   ³ Autor ³ Totvs IP RH           ³ Data ³12/04/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao do relatorio em TReport                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PN040Imp(oReport)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oReport                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR040 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PN040Imp(oReport)

Local oSection  := oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1)
Local cSitQuery	:= ""    
Local cCatQuery	:= ""  
Local nReg		:= 0
Local nOrdem	:= 1

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis de Acesso do Usuario                               ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Local cAcessaSRA	:= &( " { || " + ChkRH( "PONR040" , "SRA" , "2" ) + " } " )

//-- Variaveis Locais
// Caracter
Local cKey       := ''
Local cDet       := ''
Local cOrdem     := ''
Local cTraba     := '' 

// Data
Local dDataOk    := CtoD('  /  /  ')
Local dData      := CtoD('  /  /  ')

// Array
Local aTabPadrao := {}
Local aTabCalend := {}
Local aNewMarc	 := {}
Local aMarcacoes := {}
Local aMotivo    := {}
Local aTurnos    := {}
Local aHENA      := {}
Local aIntervalo := {}
Local aSiglaMarc := {}
Local aPeriodos	 := {}

// Logico
Local lIntMaior	 := .F.
Local lIntMenor  := .F.

// Numerico
Local nX         := 0
Local nY         := 0
Local nZ         := 0
Local nQuant     := 0   
Local nHrReal	 := 0
Local nIntProg   := 0
Local nIntReal   := 0
Local nPos1E     := 0
Local nW         := 0
Local nLenMarc	 := 0
Local nLenCalend := 0
Local nPosOrdem	 := 0  
Local nTolInt	 := 0
Local nI		 := 0

Local oBreakCc
Local oBreakFil
Local oBreakFun

Private cAliasQry 	:= GetNextAlias()

Private cFilAnte   := ''
Private cTnoAnt    := ''

Private cSit     := ""
Private cCat     := ""
Private lCC      := .F.
Private lNMarc   := .F.
Private lHExtr   := .F.
Private lInter   := .F.
Private lSitfu   := .F.
Private dDataIni := CTOD("  /  /  ")
Private dDataFim := CTOD("  /  /  ")
Private dPerIni  := CTOD('  /  /  ')
Private dPerFim  := CTOD('  /  /  ')

TabMarc('SPJ',@aSiglaMarc)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        //  Filial                                   ³
//³ MV_PAR02        //  Centro de Custo                          ³
//³ MV_PAR03        //  Turno                                    ³
//³ MV_PAR04        //  Matricula                                ³
//³ MV_PAR05        //  Nome                                     ³
//³ MV_PAR06        //  Situacao                                 ³
//³ MV_PAR07        //  Categoria                                ³
//³ MV_PAR08        //  Imprime C.C em outra Pagina              ³
//³ MV_PAR09        //  Imprime Mensagem No. Marca‡”es           ³
//³ MV_PAR10        //  Imprime Mensagem H. Extra                ³
//³ MV_PAR11        //  Imprime Intervalo                        ³
//³ MV_PAR12        //  Imprime Situa‡„o do Funcion rio          ³
//³ MV_PAR13        //  Data Inicial                             ³
//³ MV_PAR14        //  Data Final                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cSit     := MV_PAR06
cCat     := MV_PAR07
lCC      := If(MV_PAR08 == 1,.T.,.F.)
lNMarc   := If(MV_PAR09 == 1,.T.,.F.)
lHExtr   := If(MV_PAR10 == 1,.T.,.F.)
lInter   := If(MV_PAR11 == 1,.T.,.F.)
lSitfu   := If(MV_PAR12 == 1,.T.,.F.)
dDataIni := MV_PAR13
dDataFim := MV_PAR14

SP4->(dbSetOrder(1))
SRA->(dbSetOrder(1))

If Empty(dDataFim) .And. dDataBase > dDataIni
	dDataFim := dDataBase
EndIf

dDataBase := If(!Empty(dDataFim), dDataFim, dDataBase)

//-- Define o periodo de Apuracao, de acordo com MV_PAPONTA
If !PerAponta(@dPerIni, @dPerFim)
	Return( NIL )
Endif

// Se não for passado o período busca as informações do período aberto
If Empty(dDataIni) .Or. Empty(dDataFim)
	dDataIni := dPerIni
	dDataFim := dPerFim
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

cQryProcesso := "%(SRA.RA_DEMISSA = '          ' OR (SRA.RA_DEMISSA >= '"+DTOS(dDataIni) + "' AND  SRA.RA_DEMISSA <> '          '))%"
	
BeginSql alias cAliasQry
	SELECT SRA.RA_FILIAL, SRA.RA_CC, SRA.RA_MAT, SRA.RA_NOME, SRA.RA_TNOTRAB, SRA.RA_DEMISSA,SRA.RA_ADMISSA,SRA.RA_SITFOLH,SRA.RA_CHAPA,SRA.RA_SEQTURN,
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
	
//-- Quebra de pagina C.Custo
If (nOrdem = 2 .or. nOrdem = 5) 
	DEFINE BREAK oBreakCc OF oSection WHEN {|| (cAliasQry)->RA_CC } TITLE OemToansi(STR0001) 
	If lCC 
		oBreakCc:SetPageBreak(.T.) 
	Endif 
ElseIf (nOrdem = 4) 
	DEFINE BREAK oBreakCc OF oSection WHEN {|| (cAliasQry)->RA_TNOTRAB } TITLE OemToansi(STR0001) 
	If lCC 
		oBreakCc:SetPageBreak(.T.) 
	Endif 
Endif 
oSection:SetHeaderSection(.T.)
oSection:SetHeaderBreak(.T.) 

oSection:lHeaderPage:=.F. 
oSection1:lHeaderPage:=.F. 

oReport:OnPageBreak( {|| oReport:lOnPageBreak:= .F.,;
							If(oSection1:lPrinting,;
							(oSection:PrintLine(),	oReport:SkipLine());
							,);
					 },.F. )

//-- Carrega Codigos de Hora Extra Nao Autorizada
cKey  := ''
aHENA := {}
If SP4->(dbSeek(fFilFunc('SP4') + Space(Len((cAliasQry)->RA_TNOTRAB)), .F.)) .Or. ;
	SP4->(dbSeek(fFilFunc('SP4') + (cAliasQry)->RA_TNOTRAB, .F.)) .Or. ;
	SP4->(dbSeek(Space(Len((cAliasQry)->RA_FILIAL)) + (cAliasQry)->RA_TNOTRAB, .F.)) .Or. ;
	SP4->(dbSeek(Space(Len((cAliasQry)->RA_FILIAL)) + Space(Len((cAliasQry)->RA_TNOTRAB)), .F.))
	cKey := SP4->P4_FILIAL + SP4->P4_TURNO
	While !SP4->(Eof()) .And. SP4->P4_FILIAL + SP4->P4_TURNO == cKey
		If Len(aHena) == 0 .Or. aScan(aHENA, SP4->P4_CODNAUT) == 0
			aAdd(aHENA, SP4->P4_CODNAUT)
		EndIf	
		SP4->(dbSkip())
	EndDo								
EndIf

cFilAnte	:= (cAliasQry)->RA_FILIAL
cTnoAnt		:= (cAliasQry)->RA_TNOTRAB
nTolInt 	:= __Min2Hrs( ( SuperGetMv("MV_DIVTINT",NIL,0, (cAliasQry)->RA_FILIAL) ) )   //-- Minutos para Tolerancia de Intervalo

//-- Define o total da regua da tela de processamento do relatorio
oReport:SetMeter( 100 )  

//-- Incializa impressao   
oSection:Init(.F.)                                                  

While !(cAliasQry)->( EOF() ) 

	
	//-- Movimenta Regua de Processamento
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
   		cTnoAnt := (cAliasQry)->RA_TNOTRAB
		nTolInt := __Min2Hrs( ( SuperGetMv("MV_DIVTINT",NIL,0, (cAliasQry)->RA_FILIAL) ) )   //-- Minutos para Tolerancia de Intervalo
		
		//-- Carrega C¢digos de Hora Extra N„o Autorizada (Filial)
		cKey  := ''
		If SP4->(dbSeek(fFilFunc('SP4') + Space(Len((cAliasQry)->RA_TNOTRAB)), .F.)) .Or. ;
			SP4->(dbSeek(fFilFunc('SP4') + (cAliasQry)->RA_TNOTRAB, .F.)) .Or. ;
			SP4->(dbSeek(Space(Len((cAliasQry)->RA_FILIAL)) + (cAliasQry)->RA_TNOTRAB, .F.)) .Or. ;
			SP4->(dbSeek(Space(Len((cAliasQry)->RA_FILIAL)) + Space(Len((cAliasQry)->RA_TNOTRAB)), .F.))
			cKey := SP4->P4_FILIAL + SP4->P4_TURNO
			While !SP4->(Eof()) .And. SP4->P4_FILIAL + SP4->P4_TURNO == cKey
				If Len(aHena) == 0 .Or. aScan(aHENA, SP4->P4_CODNAUT) == 0
					aAdd(aHENA, SP4->P4_CODNAUT)
				EndIf	
				SP4->(dbSkip())
			EndDo								
		EndIf
	Endif
	
	If cFilAnte + cTnoAnt <> (cAliasQry)->RA_FILIAL +(cAliasQry)->RA_TNOTRAB
		cFilAnte	:= (cAliasQry)->RA_FILIAL
		cTnoAnt		:= (cAliasQry)->RA_TNOTRAB
		
		//-- Carrega C¢digos de Hora Extra N„o Autorizada (Turno)
		cKey  := ''
		If SP4->(dbSeek(fFilFunc('SP4') + Space(Len((cAliasQry)->RA_TNOTRAB)), .F.)) .Or. ;
			SP4->(dbSeek(fFilFunc('SP4') + (cAliasQry)->RA_TNOTRAB, .F.)) .Or. ;
			SP4->(dbSeek(Space(Len((cAliasQry)->RA_FILIAL)) + (cAliasQry)->RA_TNOTRAB, .F.)) .Or. ;
			SP4->(dbSeek(Space(Len((cAliasQry)->RA_FILIAL)) + Space(Len((cAliasQry)->RA_TNOTRAB)), .F.))
			cKey := SP4->P4_FILIAL + SP4->P4_TURNO
			While !SP4->(Eof()) .And. SP4->P4_FILIAL + SP4->P4_TURNO == cKey
				If Len(aHena) == 0 .Or. aScan(aHENA, SP4->P4_CODNAUT) == 0
					aAdd(aHENA, SP4->P4_CODNAUT)
				EndIf	
				SP4->(dbSkip())
			EndDo								
		EndIf
	Endif
	
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Consiste Filiais e Acessos                                             ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF !( (cAliasQry)->RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA )
		(cAliasQry)->(DbSkip())
		Loop
	EndIF
	
	aImp := {}
	
	// Carrega todos os períodos de apontamento das datas selecionadas
	aPeriodos := Monta_Per( dDataIni, dDataFim, (cAliasQry)->RA_FILIAL, (cAliasQry)->RA_MAT, dPerIni, dPerFim)
	
	For nI := 1 To Len(aPeriodos)
		//-- Reinicializa Variaveis do Funcionario
		aTabCalend	:= {} 
		aTurnos		:= {}
		aMarcacoes	:= {}
		
		//-- Carrega as Marcacoes do Periodo
		IF !GetMarcacoes( @aMarcacoes				,;	//Marcacoes dos Funcionarios
						  @aTabCalend				,;	//Calendario de Marcacoes
						  @aTabPadrao				,;	//Tabela Padrao
						  @aTurnos					,;	//Turnos de Trabalho
						  aPeriodos[ nI, 1]			,;	//Periodo Inicial
						  aPeriodos[ nI, 2]			,;	//Periodo Final
						  (cAliasQry)->RA_FILIAL	,;	//Filial
						  (cAliasQry)->RA_MAT		,;	//Matricula
						  (cAliasQry)->RA_TNOTRAB	,;	//Turno
						  (cAliasQry)->RA_SEQTURN	,;	//Sequencia de Turno
						  (cAliasQry)->RA_CC		,;	//Centro de Custo
						  "SP8"						,;	//Alias para Carga das Marcacoes
						  .F.    					,;	//Se carrega Recno em aMarcacoes
						  .T.      					,;	//Se considera Apenas Ordenadas
					      .T. 						,;	//Se Verifica as Folgas Automaticas
						  .F.    			 		,;	//Se Grava Evento de Folga Automatica Periodo Anterior
						  Nil						,;	//17 -> Se Carrega as Marcacoes Automaticas
						  Nil	    				,;	//18 -> Registros de Marcacoes Automaticas que deverao ser Desprezadas
						  Nil						,;	//19 -> Bloco para avaliar as Marcacoes Automaticas que deverao ser Desprezadas
						  Nil						,;	//20 -> Se Considera o Periodo de Apontamento das Marcacoes
						  Nil						,;	//21 -> Se Efetua o Sincronismo dos Horarios na Criacao do Calendario
						  Nil						,;  //22 -> Se carrega as marcacoes desconsideradas (Uso com lPort1510)
						  .T.						 ;  //23 -> Se carrega as marcacoes das duas tabelas SP8 e SPG
						)
			(cAliasQry)->(dbSkip())
			Loop
		EndIF
		
		aNewMarc := {}
		nLenMarc := Len( aMarcacoes )
		For nX := 1 To nLenMarc
			IF ( cOrdem := aMarcacoes[ nX , 03 ] ) == "ZZ"
				Loop
			EndIF	
			aAdd( aNewMarc , {} )
			For nY := nX To nLenMarc
				IF aMarcacoes[ nY , 03 ] == cOrdem .and. aMarcacoes[ nY , 03 ] != "ZZ"
					aAdd( aNewMarc[Len(aNewMarc)] , aClone( aMarcacoes[ nY ] ) )
					aMarcacoes[ nY , 03 ] := "ZZ"
				Else
					Exit
				EndIF
			Next nY
		Next nX
		
		aMarcacoes := aClone( aNewMarc )
		
		//-- Monta o Array aImp com as ocorrências do per¡odo
		nLenMarc := Len(aMarcacoes)
		nLenCalend:=Len(aTabCalend)
		
		For nX := 1 to nLenMarc
			dData  := aMarcacoes[nX, 1, 1]
			cOrdem := aMarcacoes[nX, 1, 3]
			
		    //-- Limita as Marcacoes ao Periodo Solicitado
			dDataOk := If( ( nPos1E := aScan(aTabCalend, { |x| x[2] == cOrdem .And. x[4] == '1E' }) ) > 0, aTabCalend[nPos1E,1], dData)
			If Abs(dData - dDataOk) > 2  .OR. ;
				(Abs(dData - dDataOk) <= 2 .And. dDataOk < dDataIni) .Or. ;
				(Abs(dData - dDataOk) <= 2 .And. dDataOk > dDataFim)
				Loop
			EndIf	
			
		  	//--Se Existe Calendario para a Ordem Obtem Numero de Marcacoes Possiveis
			If nPos1E>0  
				
				//-- Calcula a Quantidade de Marcacoes possiveis de acordo com o 
				//--Calendario do Funcionario
				nTabMarc:=0
				For nPosOrdem:=nPos1E to nLenCalend
					If aTabCalend[nPosOrdem,2] <> cOrdem
						Exit
					Endif
					nTabMarc++
				Next nPosOrdem
			Endif
			
			//-- Procura por Excecoes na Data
			cTraba := ''
			nQuant := 0
			aIntervalo := {}
			If nPos1E > 0
				cTraba := aTabCalend[nPos1E, 6]
			  	//-- Corre Todas as Marcacoes realizadas de acordo com a Ordem
				For nW := nPos1E to nLenCalend
					If aTabCalend[nW,2] <> cOrdem
						Exit
					Endif
					nQuant ++                                                
					//-- Se segundo a Tabela Padrao Existir Intervalo
					//-- Armazena-o para posterior verificacao
					If aTabCalend[nW,9] > 0
						aAdd(aIntervalo, { fNsToDh(fDhToNs(aTabCalend[nW + 1, CALEND_POS_DATA], aTabCalend[nW + 1, CALEND_POS_HORA]) - fDHtoNS(aTabCalend[nW, CALEND_POS_DATA], aTabCalend[nW, CALEND_POS_HORA]),"H"),aTabCalend[nW,4] })
					Endif
				Next nW
			EndIf
			
			//-- Reinicializa Variaveis
			dDtAfas  := CtoD('  /  /  ')
			dDtRet   := CtoD('  /  /  ')
			cTipAfas := ''
			aMotivo  := {}
			
			If nPos1E == 0
				aAdd(aMotivo, STR0015 ) // '** Nao existe Calendario           '
			EndIf	
			
			//-- MSG n£mero de Marca‡”es
			If lNMarc						
				//-- Marca‡”es Impares
				If Len(aMarcacoes[nX])%2 > 0
					aAdd(aMotivo, STR0016 ) // '** Numero de Marcacoes Impar       '
				EndIf
				
				//-- Menos ou Mais marca‡”es que o programado
				If Len(aMarcacoes[nX]) < nQuant
					aAdd(aMotivo, STR0017 ) // '** Menos Marcacoes que o Programado'
				ElseIf Len(aMarcacoes[nX]) > nQuant .And. nQuant > 0
					aAdd(aMotivo, STR0018 ) // '** Mais Marcacoes que o Programado '
				EndIf	
			EndIf
			
			//-- MSG Hora Extra n„o autorizada
			If lHExtr .And. Len(aHENA) > 0
				For nY := 1 to Len(aHENA)
					If SPC->(dbSeek(fFilFunc('SPC')+(cAliasQry)->RA_MAT+aHENA[nY]+DtoS(dData), .F.))
						aAdd(aMotivo, STR0019 ) // '** Hora Extra Nao Autorizada       '
						Exit
					EndIf
				Next nY
			EndIf
			
			//-- MSG Intervalo
			If lInter
				//-- Intervalo Menor ou Maior que o Programado
				nW := 0
				For nW := 1 To Len(aIntervalo)
					nIntReal := 0
					nIntProg := 0 
					nHrReal	 := 0
					//-- Obtem o numero de horas/minutos de intervalo
					
					//-- Localiza o numero da posicao da marcacao pela sigla.
					nPosInt := Ascan(aSiglaMarc, { |x| x == aIntervalo[nW,2] })
					
					lIntMaior:=lIntMenor:= .F.		 				
					If nPosInt+1 <= Len(aMarcacoes[nX])
						
						If  Empty(nTolInt)
							nIntReal := fDhToNs(aMarcacoes[nX, nPosInt+1, 1], aMarcacoes[nX, nPosInt+1, 2]) - fDhToNs(aMarcacoes[nX, nPosInt, 1], aMarcacoes[nX, nPosInt, 2])
							nIntProg := fDhToNs(,aIntervalo[nW,1])
							lIntMenor:= (nIntReal) < (nIntProg)  
							lIntMaior:=	(nIntReal) > (nIntProg)
						Else 
							
	                    	CalcHours(  aMarcacoes[nX, nPosInt+1, 1]		,;	//01 -> Data 1
										aMarcacoes[nX, nPosInt+1, 2]		,;	//02 -> Hora 1
										aMarcacoes[nX, nPosInt, 1]			,;	//03 -> Data 2
										aMarcacoes[nX, nPosInt, 2]			,;	//04 -> Hora 2
										@nHrReal							,;	//05 -> <@>Horas Normais Apontadas
										NIL									,;	//06 -> <@>Horas Noturnas Apontadas
										.F.									;	//07 -> Apontar Horas Noturnas
									)  
							If nHrReal > SomaHoras(aIntervalo[nW,1],nTolInt)
								lIntMaior:=.T.
							ElseIf aIntervalo[nW,1] > SomaHoras(nHrReal,nTolInt)
								lIntMenor:=.T.
							Endif							 
						Endif
						
					Endif
					
					If lIntMenor
					   	aAdd(aMotivo, '** '+Trim(Str(nW,2))+'o.'+STR0020) // ' Intervalo Menor que o Programado'
					ElseIf   lIntMaior
						aAdd(aMotivo, '** '+Trim(Str(nW,2))+'o.'+STR0021) // ' Intervalo Maior que o Programado'
					EndIf
				Next nW
			EndIf
			
			//-- MSG Situa‡„o do Funcion rio
			If lSitFu
				//-- Marca‡”es Anteriores a Admiss„o ou Posteriores a Demiss„o
				If !Empty((cAliasQry)->RA_ADMISSA) .And. dData < (cAliasQry)->RA_ADMISSA
					aAdd(aMotivo, STR0022 ) // '** Marcacoes antes da Admisssao    '
				ElseIf !Empty((cAliasQry)->RA_DEMISSA) .And. dData > (cAliasQry)->RA_DEMISSA
					aAdd(aMotivo, STR0023 ) // '** Marcacoes apos Demissao         '
				EndIf
				
				//-- Marca‡”es durante Ferias ou Afastamentos
				If fAfasta( (cAliasQry)->RA_FILIAL,(cAliasQry)->RA_Mat,dData,@dDtafas,@dDtRet,@cTipAfas) .And. aTabCalend[nPos1E,10] # 'E'
					If cTipAfas == 'F'
						aAdd(aMotivo, STR0024 ) // '** Marcacoes durante as Ferias     '
					Else
						aAdd(aMotivo, STR0025 ) // '** Marcacoes durante Afastamento   '
					EndIf
				EndIf		
			EndIf
			
			If Len(aMotivo) > 0
				cDet := Subs(Dtos(dData),7,2)+'/' + Subs(Dtos(dData),5,2) + Space(2)
				For nZ := 1 to Len(aMarcacoes[nX])
					cDet += StrZero(aMarcacoes[nX, nZ, 2], 5, 2) + Space(1)
				Next nZ
				cDet := If(Len(cDet)>=87,Left(cDet,87),cDet+Space(87-Len(cDet)))
				aAdd(aImp, cDet)
				For nZ := 1 to Len(aMotivo)
					If nZ == 1
						aImp[Len(aImp)] += aMotivo[nZ]
					Else	
						aAdd(aImp, Space(87) + aMotivo[nZ])
					EndIf
				Next nZ
			EndIf
		Next nX
	Next nI
	
	// Verifica se não carregou as marcações e salta para o proximo funcionario
	If Len(aImp) == 0
		(cAliasQry)->(DbSkip())
		Loop
	Endif
	
	oSection:PrintLine()
	oReport:SkipLine()
	oSection1:Init(.F.) 
	oSection1:PrintHeader() 
	
	For nX := 1 to Len( aImp )
		//-- Altera valores da Section
		oSection1:Cell( "DATA"):SetValue(SubStr(aImp[nX],1,5))
		oSection1:Cell( "MARCACOES"):SetValue(SubStr( aImp[nX],8,79))
		oSection1:Cell( "OCORRENCIAS"):SetValue(LTrim(SubStr(aImp[nX],80)))
		
		//-- Imprime os conteudos da Section
		oSection1:PrintLine()
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
EndIf

Return

Static Function Scheddef()						// Carrega perguntas no schedule

Local aParam

Local aOrd     := {"Filial ","Centro de Custo ","Turno ","Matricula ",;
	               "Nome ","Situacao ","Categoria ","Imprime C.C em outra Pagina ",;
	               "Imprime Mensagem No. Marcações","Imprime Mensagem H. Extra "," Imprime Intervalo  ",;
	               "Imprime Situação do Funcionário","Data Inicial  ","Data Final "}

aParam := { "R"," PN040R","SRA", aOrd,"Divergencias nas Marcacoes"}    

Return aParam

/*/{Protheus.doc} Monta_Per
Cria Array com os Periodos de apontamento conforme as datas passadas
@type  Static Function
@author Cícero Alves
@since 21/03/2022
@param dDataIni, Data, Data inicial para montagem dos períodos
@param dDataFim, Data, Data final para montagem dos períodos
@param cFil, Caractere, Filial do funcionário
@param cMat, Caractere, Matrícula do funcionário
@param dIniAtu, Data, Data inicial do período de apontamento atual 
@param dFimAtu, Data, Data final do período de apontamento atual 
@return aPeriodos, Array, Array com os períodos de apontamento
/*/
Static Function Monta_Per( dDataIni, dDataFim, cFil, cMat, dIniAtu, dFimAtu )
	
	Local aPeriodos := {}
	Local cFilSPO	:= xFilial( "SPO", cFil )
	Local dAdmissa	:= SRA->RA_ADMISSA
	Local dPerIni   := Ctod("//")
	Local dPerFim   := Ctod("//")
	Local cPaponta	:= SuperGetMv("MV_PAPONTA", , "")
	Local nDiasPer	:= 0
	
	SPO->( dbSetOrder( 1 ))
	SPO->( dbSeek( cFilSPO, .F. ))
	
	While SPO->( !Eof() .And. PO_FILIAL == cFilSPO )
		
		dPerIni := SPO->PO_DATAINI
		dPerFim := SPO->PO_DATAFIM  
		
	    //-- Filtra Periodos de Apontamento a Serem considerados em funcao do Periodo Solicitado
		IF dPerFim < dDataIni .Or. dPerIni > dDataFim                                                      
			SPO->( dbSkip() )  
			LOOP
		Endif
		
	    //-- Somente Considera Periodos de Apontamentos com Data Final Superior a Data de Admissao
		If dPerFim >= dAdmissa
			aAdd( aPeriodos, { dPerIni, dPerFim, Max( dPerIni, dDataIni ), Min( dPerFim, dDataFim )})
		Else
			EXIT
		EndIf
		
		SPO->(dbSkip())
		
	EndDo
	
	If dDataIni < dIniAtu // O período anterior não foi fechado
		
		PerAponta(@dPerIni, @dPerFim, dDataIni)
		If aScan( aPeriodos, { |x| x[1] == dPerIni .And. x[2] == dPerFim } ) == 0.00
			aAdd(aPeriodos, { dPerIni, dPerFim, dPerIni, Min(dPerFim, dDataFim)})
		EndIf
		
	EndIf
	
	If ( aScan( aPeriodos, { |x| x[1] == dIniAtu .And. x[2] == dFimAtu } ) == 0.00 ) // Período atual
		dPerIni := dIniAtu
		dPerFim	:= dFimAtu 
		
		IF !(dPerFim < dDataIni .Or. dPerIni > dDataFim)
			IF ( dPerFim >= dAdmissa )
				aAdd(aPeriodos, { dIniAtu, dFimAtu, Max(dPerIni, dDataIni), Min(dPerFim, dDataFim)})
			EndIF
		ElseIf dDataIni > dPerFim // Período futuro
			If Len(cPaponta) > 5
				nDiasPer := DateDiffDay(dPerIni, dPerFim)
				dPerIni := DaySum(dPerFim, 1) // O próximo período começa no dia seguinte ao termino do período atual
				dPerFim := DaySum(dPerIni, nDiasPer) // O período seguite terá a mesma quantidade de dias do período atual
			Else
				dPerIni := MonthSum(dPerIni, 1)
				dPerFim := MonthSum(dPerFim, 1)
			EndIf
			
			aAdd(aPeriodos, { dPerIni, dPerFim, Max(dPerIni, dDataIni), Min(dPerFim, dDataFim)})
		Endif
	EndIF
	
Return( aPeriodos )
