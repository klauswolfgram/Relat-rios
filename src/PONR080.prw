/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR080.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PONR080  ³ Autor ³ R.H. - J. Ricardo     ³ Data ³ 07.11.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Apuracoes Percentuais                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR080(void)                                              ³±±
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
±±³Luis Artuso ³21/01/15³01076/³Ajuste na clausula where da query que gera³±±
±±³            ³        ³  2015³o relatorio personalizado, para considerar³±±
±±³            ³        ³      ³as filiais das tabelas CTT e SR6.         ³±±
±±³Matheus M.  ³25/07/16³TVRI41³Ajuste na exibição da coluna Tot. Hr.	  ³±±
±±³Matheus M.  ³18/08/16³TVVYBH³Ajuste na exibição das colunas em planilha³±±
±±³            ³        ³      ³e formato tabela.				          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function PONR080()
Local	oReport   
Local	aArea 		:= GetArea()
Private	cString		:= "SRA"				// alias do arquivo principal 
Static cPerg		:= "PN080R"
Static aOrd     	:= { STR0004 , STR0005 , STR0006 , STR0007 , STR0033  } // 'Matricula'###'Centro de Custo'###'Nome'###'Turno'###'C.Custo+Nome'
Static cTitulo		:= OemToAnsi(STR0001)			//'Apuracao das Marcacoes'
Static cAliasQry	:= ""

Pergunte(cPerg,.F.) 

oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ ReportDef  ³ Autor ³ Totvs IP RH           ³ Data ³26/04/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Apuracao das Marcacoes                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PONR080                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR080 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport 
Local oSection1 
Local oSection2 
Local oSection3 
Local bBlkFil := { || If ( cCodFilial != (cAliasQry)->RA_FILIAL, Eval( { || fInfo(@aInfo,(cAliasQry)->RA_FILIAL), aInfo[3] } ), aInfo[1] ) }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao dos componentes de impressao                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "PONR080" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PN080Imp(oReport)} DESCRIPTION OemtoAnsi(STR0043) TOTAL IN COLUMN LANDSCAPE // "Este programa emite Relacao Apuracao das Marcacoes"

	oSection1 := TRSection():New( oReport, OemToAnsi(STR0045), {"SRA","CTT","SR6"}, aOrd,,,,,.F.,.F.) // "Funcionarios"

		TRCell():New(oSection1,"RA_FILIAL","SRA",,/*Picture*/,8,/*lPixel*/,{|| 	If(!Empty((cAliasQry)->RA_FILIAL),;
																								cCodFilial:= (cAliasQry)->RA_FILIAL,;
																								NIL),;
																								cCodFilial}	)
		TRCell():New(oSection1,"FILIAL","",OemToAnsi(STR0046),/*Picture*/,20,/*lPixel*/,{|| Eval( bBlkFil ) })	// "Desc.Filial"

		TRCell():New(oSection1,"RA_MAT"		,"SRA",,,6)
		TRCell():New(oSection1,"RA_NOME"	,"SRA")
		TRCell():New(oSection1,"RA_CC"		,"SRA",,,9)
		TRCell():New(oSection1,"CTT_DESC01"	,"CTT",OemToAnsi(STR0044),,35,,,,.T.) 		// "Descricao"
		TRCell():New(oSection1,"RA_TNOTRAB"	,"SRA",OemToAnsi(STR0047),,3)				// "Tno"
		TRCell():New(oSection1,"R6_DESC"	,"SR6",,,30,,,,.T.)								

		TRCell():New( oSection1, "TOTHORAS"			, "" ,OemToAnsi(STR0048),"@e 999.99",5,,,"RIGHT",,"RIGHT")	//	"Tot.Hr"
		TRCell():New( oSection1, "INTERVALO"		, "" ,OemToAnsi(STR0049),"@e 999.99",5,,,"RIGHT",,"RIGHT")	//	"Interv" 
		TRCell():New( oSection1, "HORASTRAB"		, "" ,OemToAnsi(STR0050),"@e 999.99",5,,,"RIGHT",,"RIGHT")	//	"H.Trab" 
		TRCell():New( oSection1, "HORASABONADAS"	, "" ,OemToAnsi(STR0051),"@e 999.99",5,,,"RIGHT",,"RIGHT")	//	"H.Abon"
		TRCell():New( oSection1, "HORASDIFERENCA"	, "" ,OemToAnsi(STR0052),"@e 9999.99",7,,,"RIGHT",,"RIGHT")	//	"Hr.Dif."
		TRCell():New( oSection1, "PERCDIFERENCA"	, "" ,OemToAnsi(STR0053),"@e 9999.99",7,,,"RIGHT",,"RIGHT")	//	"% Dif."

	oSection2 := TRSection():New( oSection1, OemToAnsi(STR0057) )	 //"Marcações"

		TRCell():New( oSection2, "DATA"		, "" ,OemToAnsi(STR0054)      ,,10)	// "Data"

		TRCell():New( oSection2, "PREVISTA"			, "" ,OemToAnsi(STR0055),,48)	// "Ent.1 Sai.1 Ent.2 Sai.2 Ent.3 Sai.3 Ent.4 Sai.4"
		TRCell():New( oSection2, "REALIZADA"		, "" ,OemToAnsi(STR0056),,72)	// "Ent.1 Sai.1 Ent.2 Sai.2 Ent.3 Sai.3 Ent.4 Sai.4 Ent.5 Sai.5 Ent.6 Sai.6"

		TRCell():New( oSection2, "TOTHORAS"			, "" ,OemToAnsi(STR0048),"@e 999.99",5)	//	"Tot.Hr"
		TRCell():New( oSection2, "INTERVALO"		, "" ,OemToAnsi(STR0049),"@e 999.99",5)	//	"Interv" 
		TRCell():New( oSection2, "HORASTRAB"		, "" ,OemToAnsi(STR0050),"@e 999.99",5)	//	"H.Trab" 
		TRCell():New( oSection2, "HORASABONADAS"	, "" ,OemToAnsi(STR0051),"@e 999.99",5)	//	"H.Abon"
		TRCell():New( oSection2, "HORASDIFERENCA"	, "" ,OemToAnsi(STR0052),"@e 9999.99",7)	//	"Hr.Dif."
		TRCell():New( oSection2, "PERCDIFERENCA"	, "" ,OemToAnsi(STR0053),"@e 9999.99",7)	//	"% Dif."

	oSection3 := TRSection():New( oReport, OemToAnsi(STR0061) )	 //"Totalizadores"

		TRCell():New( oSection3, "DESCRICAO"		, "" ,OemToAnsi(STR0061),,70)	//	"Totalizadores"
		TRCell():New( oSection3, "TOTHORAS"			, "" ,OemToAnsi(STR0048),"@e 999999999.99",12,,,"RIGHT",,"RIGHT")	//	"Tot.Hr" 
		TRCell():New( oSection3, "INTERVALO"		, "" ,OemToAnsi(STR0049),"@e 999999999.99",12,,,"RIGHT",,"RIGHT")	//	"Interv" 
		TRCell():New( oSection3, "HORASTRAB"		, "" ,OemToAnsi(STR0050),"@e 999999999.99",12,,,"RIGHT",,"RIGHT")	//	"H.Trab" 
		TRCell():New( oSection3, "HORASABONADAS"	, "" ,OemToAnsi(STR0051),"@e 999999999.99",12,,,"RIGHT",,"RIGHT")	//	"H.Abon"
		TRCell():New( oSection3, "HORASDIFERENCA"	, "" ,OemToAnsi(STR0052),"@e 999999999.99",12,,,"RIGHT",,"RIGHT")	//	"Hr.Dif."
		TRCell():New( oSection3, "PERCDIFERENCA"	, "" ,OemToAnsi(STR0053),"@e 999999999.99",12,,,"RIGHT",,"RIGHT")	//	"% Dif."
                                           
Return(oReport)                          


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PN080Imp   ³ Autor ³ Totvs IP RH           ³ Data ³26/04/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao do relatorio em TReport                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PN080Imp(oReport)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oReport                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR080 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PN080Imp(oReport)

Local oSection  := oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1)
Local oSection2 := oReport:Section(2)
Local cFiltro 	:= "" 
Local cSitQuery	:= ""    
Local cCatQuery	:= ""  
Local nReg		:= 0
Local cOrdem 	 := ""
Local cFilSRACTT:= ""
Local cFilSRASR6:= ""
Local nPre 		:= 0
Local nHr 		:= 0

Local lHeaderMar	:= .T.

Local aPrevisto  	:= {}
Local aRealizado   	:= {}
Local aFun          := {}
Local cPrevisto  	:= ''
Local cRealizado 	:= '' 
Local cDet       	:= ''
Local dDtAfas    	:= CtoD('  /  /  ')
Local dDtRet     	:= CtoD('  /  /  ')

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
Local aHorarios     := {}
Local lOcorr		:= .F.
Local lAfastado		:= .F.
Local lMod			:= .F.
Local lPar			:= .F.
Local cFunRegra		:= ""
Local lPrintHeader 	:= .F.

Local aAbonos    := {}
Local aImp       := {}
Local aMarcacoes := {}
Local aTabCalend := {}
Local aTabPadrao := {}
Local cDescrAfa  := ""
Local cAcessaSRA := &("{ || " + ChkRh("PONR080","SRA","2") + "}")
Local dDataOk    := Ctod("//")
Local dRef       := Ctod("//")
Local dData      := Ctod("//")
Local dIniPonMes := Ctod("//")
Local dFimPonMes := Ctod("//")
Local lAfasta    := .F.
Local lImpAcum   := .F.
Local lImpFunc   := .F.
Local lNaoLista  := .F.
Local nFor       := 0
Local nFor1		 := 0
Local nFor2		 := 0
Local nPos       := 0
Local nPosCalend := 0	
Local nAbono     := 0
Local nDifHor    := 0
Local nIntReal   := 0
Local nIntProg   := 0
Local nMarcacoes := 0
Local nEfeTotHor := 0
Local nEfeTotInt := 0
Local nEfeTotTra := 0
Local nPerDifHor := 0
Local nPreTotTra := 0
Local nX		 := 0
Local lImpar	 := .F.

//-- Acumuladores
Private aEfeTotHor := { 0,0,0,0 }
Private aEfeTotInt := { 0,0,0,0 }
Private aEfeTotTra := { 0,0,0,0 }
Private aDifHor    := { 0,0,0,0 }
Private aPerDifHor := { 0,0,0,0 }
Private aPreTotTra := { 0,0,0,0 }
Private aAboTot    := { 0,0,0,0 }

Private cInicio	 := ""
Private cFim	 := ""		

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
Private nPagAtu    := 1
Private lUmDia	   := .F.      
Private nAjusteFol := 0

Private	cFilAnte	:= Replicate("ú", GetSx3Cache("RA_FILIAL", "X3_TAMANHO"))
Private	cFilPer		:= Replicate("ú", GetSx3Cache("RA_FILIAL", "X3_TAMANHO"))
Private	cTnoAnte	:= Replicate("ú", GetSx3Cache("RA_TNOTRAB", "X3_TAMANHO"))
Private	cCcAnte 	:= Replicate("!", GetSx3Cache("RA_CC", "X3_TAMANHO"))
Private	cTnoDesc 	:= Replicate("!", GetSx3Cache("R6_DESC", "X3_TAMANHO"))
Private	cCcDesc 	:= Replicate("!", GetSx3Cache("CTT_DESC01", "X3_TAMANHO"))
Private aProvis		:= {}

SRA->(dbSetOrder(1))

//-- Parƒmetro MV_PAPONTA
dPerIni := CtoD('  /  /  ')
dPerFim := CtoD('  /  /  ')
If !PerAponta(@dPerIni, @dPerFim )
	Return Nil
Endif	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        //  Filial                                   ³
//³ MV_PAR02        //  Centro de Custo                          ³
//³ MV_PAR03        //  Turno                                    ³
//³ MV_PAR04        //  Matricula                                ³
//³ MV_PAR05        //  Nome                                     ³
//³ MV_PAR06        //  Data Inicial                             ³
//³ MV_PAR07        //  Data Final                               ³
//³ MV_PAR08        //  Situacao                                 ³
//³ MV_PAR09        //  Categoria                                ³
//³ MV_PAR10        //  Sintetico/Analitico                  	 ³
//³ MV_PAR11        //  Intervalo Previsto ou Realizado          ³
//³ MV_PAR12        //  Considerar Feriado                		 ³
//³ MV_PAR13        //  C.C. em outra pagina		     		 ³
//³ MV_PAR14        //  Func. em outra pagina                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dDataIni   := Max( MV_PAR06 , dPerIni )	//  Data De
dDataFim   := Min( MV_PAR07 , dPerFim )	//  Data Ate
cSituacao  := MV_PAR08					//  Situacao
cCategoria := MV_PAR09					//  Categoria
lSint      := (MV_PAR10==1)				//  Sintetico ou Analitico
lIntMenPre := (MV_PAR11==1)				//  Intervalo Previsto ou Realizado
lFeriado   := (MV_PAR12==1)				//  Considerar Feriado	
lCC        := (MV_PAR13==1)				//  C.C. outra pagina
lFunc      := (MV_PAR14==1)				//  Func.outra pagina

cTitulo := OemToAnsi(STR0001) + " " + OemToAnsi(STR0032) + DTOC(dDataIni) + " - " + DTOC(dDataFim) // "Apuracao das Marcacoes" ### 'Periodo: '

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

cFilSRACTT	:= "% CTT.CTT_FILIAL = " + "'" + xFilial("CTT") + "'" + "%"
cFilSRASR6	:= "% SR6.R6_FILIAL = " + "'" + xFilial("SR6") + "'" + "%"

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
	SELECT SRA.RA_FILIAL, SRA.RA_CC, SRA.RA_MAT, SRA.RA_NOME, SRA.RA_TNOTRAB, SRA.RA_SEQTURN, SRA.RA_DEMISSA,SRA.RA_ADMISSA,SRA.RA_SITFOLH,SRA.RA_RESCRAI,
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


DEFINE BREAK oBreakFil OF oSection WHEN {|| (cAliasQry)->RA_FILIAL }  TITLE OemToansi(STR0001) 
oBreakFil:SetPageBreak(.T.)
oBreakFil:SetHeaderBreak(.T.) 

DEFINE BREAK oBreakFun OF oSection WHEN {|| (cAliasQry)->RA_MAT }  TITLE OemToansi(STR0001) 
oBreakFun:SetHeaderBreak(.T.) 
If lFunc  
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

If !lSint
	oSection:SetHeaderSection(.T.)
	oSection:SetHeaderBreak(.T.) 
Else
	oSection:SetHeaderSection(.F.)
	oSection:SetHeaderBreak(.F.) 
Endif

oSection1:SetHeaderSection(.F.)
oSection1:SetHeaderBreak(.F.) 

oSection:lHeaderPage:=.F. 
oSection1:lHeaderPage:=.F. 

// Na quebra de pagina executa: Impressao da Linha do funcionario,pula linha,impressão do cabecalho das marcacoes, pula linha
oReport:OnPageBreak( {|| oReport:lOnPageBreak:= .F.,;
							If(lSint,(oSection:SetHeaderSection(.T.),oSection:PrintHeader(),oSection:SetHeaderSection(.F.)),),;
							If((oSection1:lPrinting ),;
								(	oSection:PrintLine(),	;
									oReport:SkipLine(),;
									oReport:PrintText( Space(12) + PADC(OemToAnsi(STR0058),52) + PADC(OemToAnsi(STR0059),80) + PADC(OemToAnsi(STR0060),60) ) ,;
									oReport:SkipLine(),;
									oSection1:SetHeaderSection(.T.),;
									oSection1:PrintHeader(),;
									oSection1:SetHeaderSection(.F.),;
									oReport:SkipLine();
								);
							,);
					 },.F. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a variavel aInfo com a filial Logada              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
fInfo(@aInfo,(cAliasQry)->RA_FILIAL)

cFilAnte	:= (cAliasQry)->RA_FILIAL
cCcAnte		:= (cAliasQry)->RA_CC
cTnoAnte	:= (cAliasQry)->RA_TNOTRAB
cTnoDesc 	:= (cAliasQry)->R6_DESC 
cCcDesc 	:= (cAliasQry)->CTT_DESC01 

If !lSint .And. !(oReport:nDevice == 4 .And. (oReport:nExcelPrintType == 3))
	oSection:Cell("TOTHORAS"):Disable()	
	oSection:Cell("INTERVALO"):Disable()	
	oSection:Cell("HORASTRAB"):Disable()		
	oSection:Cell("HORASABONADAS"):Disable()	
	oSection:Cell("HORASDIFERENCA"):Disable()	
	oSection:Cell("PERCDIFERENCA"):Disable()			
Endif

//-- Define que o formato da impressao sera em paisagem
oReport:SetLandscape()

//-- Define o total da regua da tela de processamento do relatorio
oReport:SetMeter( 100 )  

//-- Incializa impressao   
oSection:Init()                              

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

	//-- Reinicializa Variaveis do Funcionario
	aTabCalend	:= {} 
	aTurnos		:= {}
	aMarcacoes	:= {}

	aFun		:= {}

	If (cAliasQry)->RA_FILIAL != cFilPer
		GetPonMesDat( @dIniPonMes, @dFimPonMes, (cAliasQry)->RA_FILIAL )
		cFilPer 	:= (cAliasQry)->RA_FILIAL
		lImpAcum 	:= dPerIni < dIniPonMes
	EndIf

    /*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Carrega Arrays com as Marca‡”es do Periodo (aMarcacoes), com³
	³o Calendario de Marca‡”es do Periodo (aTabCalend) e com    as³	
	³Trocas de Turno do Funcionario (aTurnos)					  ³	
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF !SRA->( GetMarcacoes(	@aMarcacoes		,;	//Marcacoes dos Funcionarios
			   					@aTabCalend		,;	//Calendario de Marcacoes
								@aTabPadrao		,;	//Tabela Padrao
								@aTurnos		,;	//Turnos de Trabalho
								dPerIni 		,;	//Periodo Inicial
								dPerFim			,;	//Periodo Final
								(cAliasQry)->RA_FILIAL		,;	//Filial
								(cAliasQry)->RA_MAT	  		,;	//Matricula
								(cAliasQry)->RA_TNOTRAB		,;	//Turno
								(cAliasQry)->RA_SEQTURN		,;	//Sequencia de Turno
								(cAliasQry)->RA_CC		,;	//Centro de Custo
								IiF(lImpAcum, "SPG", "SP8")	,;	//Alias para Carga das Marcacoes
								NIL				,;	//Se carrega Recno em aMarcacoes
								.T.				,;	//Se considera Apenas Ordenadas
							    .T.    			,;	//Se Verifica as Folgas Automaticas
					  			.F.    			 ;	//Se Grava Evento de Folga Automatica Periodo Anterior
					 		);
			  )	 		
		(cAliasQry)->(DbSkip())
		Loop
	EndIF					 

	//-- Processa quebra de Filial.
	If (cAliasQry)->RA_FILIAL != cFilAnte 
	    //--Somente "Zera" as variaveis se jah foi impresso algo para nao pula 
	    //--de pagina na primeira vez

		// Imprime os totais por Centro de Custo ou Turno de Trabalho
		If nOrdem == 2 .Or. nOrdem == 4 .Or. nOrdem == 5
			F080RCabTot(oReport,oSection2,nOrdem)
			cTnoAnte := (cAliasQry)->RA_TNOTRAB 
			cTnoDesc := (cAliasQry)->R6_DESC 
			cCcAnte := (cAliasQry)->RA_CC 
			cCcDesc := (cAliasQry)->CTT_DESC01 
		Endif

		// Imprime os totais da filial
		F080RCabTot(oReport,oSection2,9)		
		
		cFilAnte := (cAliasQry)->RA_FILIAL

		If !fInfo(@aInfo,(cAliasQry)->RA_FILIAL)
			Exit
		Endif	

	Endif

	//-- Processa quebra de Filial.
	If 	(nOrdem == 4 .And. (cAliasQry)->RA_TNOTRAB != cTnoAnte) .Or. 	(( nOrdem == 2 .Or. nOrdem == 5) .And. (cAliasQry)->RA_CC != cCcAnte	)
		F080RCabTot(oReport,oSection2,nOrdem)
		cTnoAnte := (cAliasQry)->RA_TNOTRAB 
		cTnoDesc := (cAliasQry)->R6_DESC 
		cCcAnte := (cAliasQry)->RA_CC 
		cCcDesc := (cAliasQry)->CTT_DESC01 
	Endif

    /*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Verifica o Numero de Elementos de aMarcacoes  			  ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	nLenMarc := Len( aMarcacoes )

	//-- Verifica se deveria existir marcacoes no dia (dRef)
	dRef := Ctod("//")
	aFun := {}
	aEfeTotHor[1] := 0
	aEfeTotInt[1] := 0
	aEfeTotTra[1] := 0
	aPreTotTra[1] := 0
	aDifHor[1]    := 0
	aAboTot[1]    := 0
	
    /*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Percorre Todas as Ordens do Calendario					  ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	For nFor1 := 1 To Val(aTabCalend[Len(aTabCalend),2])
	
		aAbonos := {}
		cOrdem := StrZero(nFor1,2)

		If (nPosCalend := aScan( aTabCalend, { |x| x[2] == cOrdem .And. x[4] == '1E'  } ) ) > 0

			dRef := aTabCalend[nPosCalend,1] //-- Encontra a Data de referencia

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica os Abonos na Data									³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF ( nPos := Ascan( aAbonos, { |x| x[1] == dRef } ) ) > 0
				aAbonos[nPos,2] := __TimeSum(aAbonos[nPos,2],fAbonos(dRef))
			Else
				aAdd(aAbonos,{dRef,fAbonos(dRef)})
			EndIF

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ N„o deve gerar marca‡”es em feriados que nao sejam excecoes.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !lFeriado
				If aTabCalend[nPosCalend,19]
					Loop
				Endif
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ N„o Considera Data Fora do Periodo                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If dRef < dDataIni .Or. dRef > dDataFim
				Loop
			EndIf	
		Else
			Loop
		EndIf
		
		//-- Reinicializa Variaveis
		cPrevisto  := ''
		aPrevisto  := {}
		nMarcacoes := 0
		nEfeTotHor := 0
		nEfeTotInt := 0
		nEfeTotTra := 0
		nPreTotTra := 0
		nAbono     := 0
		nDifHor    := 0
		nPerDifHor := 0

		//-- Dia Normal
		//-- Encontra a 1a marca‡„o da Data de referencia
		If (nPosCalend := Ascan( aTabCalend, { |x| x[2] == cOrdem .And. x[4] == '1E'  } ) ) > 0
			
			//-- Guarda o Tipo do dia Segundo a Tabela Padrao Posicionada logo acima
	    	cTipoDia	:= aTabCalend[nPosCalend,6]  
			
			For nFor2 := nPosCalend To Len(aTabCalend)
				//-- N„o Permite a apura‡„o de mais de 8 marca‡”es !!!
				If aTabCalend[nFor2,2] # cOrdem .Or. nMarcacoes > 8
					Exit
				Endif
				nMarcacoes ++
				If !lFeriado .Or. (lFeriado .And. !aTabCalend[nPosCalend,19])
					Aadd(aPrevisto,{aTabCalend[nFor2,3],aTabCalend[nFor2,1]})
					If nMarcacoes <= 8
						cPrevisto += StrZero(aTabCalend[nFor2,3],5,2) + " "
					Endif
				Else
					Aadd(aPrevisto,{0,00,aTabCalend[nFor2,1]})
					cPrevisto += If( nMarcacoes <= 8,StrZero(0,5,2) + " ",)
				Endif
			Next nFor2	
		Else
			Loop
		EndIf

		//-- Busca as marcacoes
		cEfetivo   := ''
		aEfetivo   := {}
		nMarcacoes := 0
		lNaoLista  := .F.
		lImpar	   := .F.
		
		IF ( nPos := aScan( aMarcacoes , { |x| x[3] == cOrdem } ) ) > 0.00
			For nX := nPos To nLenMarc
				IF aMarcacoes[ nX , 03 ] != cOrdem
					Exit
				EndIF
				IF aScan( aEfetivo, { |x| x[1] == aMarcacoes[nX,2] .and. x[2] == aMarcacoes[nX,1] } ) == 0
					nMarcacoes++
					Aadd(aEfetivo,{aMarcacoes[nX,2], aMarcacoes[nX,1]})
					IF nMarcacoes <= 12 		// Marcacoes realizadas ficam limitadas a doze
						cEfetivo += StrZero(aMarcacoes[nX,2],5,2) + Space(1)
					EndIF
				EndIF
			Next nX	
			//-- Verifica se Marcacoes Impares
			If nMarcacoes%2 # 0
				cEfetivo += STR0022  // '     ** MARC.IMPAR **'
			   lImpar:=.T.
			Endif
		Else
			If !lFeriado .or. (lFeriado .and. !aTabCalend[nPosCalend,19])
				lNaoLista := .T.
			Endif
			For nFor := 1 To Len(aPrevisto)
				If aPrevisto[nFor,1] # 0.00
					lNaoLista := .F.
				Endif
			Next nFor
		Endif

		If !lFeriado
			//-- N„o lista quando houver Feriados sem Excecoes.
			If aTabCalend[nFor1,19] .And. aTabCalend[nFor1,10] # "E"
				lNaoLista := .T.
			EndIf
		Endif

		If lNaoLista
			Loop
		Endif

		cTipAfas := Space(1)
		lAfasta  := .F.
		cMotivo  := ''
		dDtaFas  := CtoD('  /  /  ')
		dDtRet   := CtoD('  /  /  ')

		If Len(aEfetivo) == 0  
			//-- Para Dia na Tabela como sendo DSR ou Compensado ou Nao trabalhado(mesmo com horarios)
			//-- Desconsidera se Nao Ocorreram Marcacoes.
			If cTipoDia $ 'D.C.N'
			   Loop
			Endif  
			
			//-- Afastamentos
			If fAfasta( (cAliasQry)->RA_FILIAL,(cAliasQry)->RA_Mat,dRef,@dDtafas,@dDtRet,@cTipAfas) .Or. ;
				(cAliasQry)->RA_SitFolh $ 'DúT' .And. dRef > (cAliasQry)->RA_DEMISSA
				lAfasta := .T.
				cDescrAfa := fDescAfast(If(!Empty(cTipAfas),cTipAfas,fDemissao((cAliasQry)->RA_SITFOLH, (cAliasQry)->RA_RESCRAI) ), Nil, Nil, SRA->( (cAliasQry)->RA_SITFOLH == 'D' .and. dRef > (cAliasQry)->RA_DEMISSA ))
				cMotivo := PADC('** '  + AllTrim(cDescrAfa) + ' **',71) +' | '
			EndIf
			//-- Per¡odo anterior a Admiss„o
			If dRef < (cAliasQry)->RA_ADMISSA
				lAfasta := .T.
				cMotivo := STR0024      // '                     ** DATA ANTERIOR A ADMISSAO **                      | '
			EndIf
            //-- Funcionario sem Marcacao
			IF Empty(cMotivo)
				cMotivo := STR0025      // '                         ** SEM MARCACOES **                            | '
			EndIF
		Else
		    //-- Elimina o Ultimo Elemento das marcacoes impares
			If lImpar
				aDel(aEfetivo,Len(aEfetivo))
				aSize(aEfetivo,Len(aEfetivo)-1)
			Endif
		Endif
        
		cEfetivo := StrTran(cEfetivo,'.',':')
		cEfetivo := Left(cEfetivo+Space(71),71)

		cPrevisto := StrTran(cPrevisto,'.',':')
		cPrevisto := Left(cPrevisto+Space(47),47)

		If lSint
			cDet := Space(84) + '| '
		Else
			cDet := StrZero(Day(dRef),2) + '/' + StrZero(Month(dRef),2) + Space(1) + DiaSemana(dRef,3)+ ' | '
			cDet += cPrevisto + ' | '
			If Len(cMotivo) > 0
				cDet += cMotivo
			Else
				cDet += cEfetivo + ' | '
			Endif
		Endif

		//-- Apura Total de Horas
		nPreTotHor := If(Len(aPrevisto)>0,__fNStoDH(__fDHtoNS(aPrevisto[Len(aPrevisto),2],aPrevisto[Len(aPrevisto),1])-__fDHtoNS(aPrevisto[1,2],aPrevisto[1,1]),'H'), 0)
		nEfeTotHor := If(Len(aEfetivo )>0,__fNStoDH(__fDHtoNS(aEfetivo [Len(aEfetivo ),2],aEfetivo [Len(aEfetivo ),1])-__fDHtoNS(aEfetivo [1,2],aEfetivo [1,1]),'H'), 0)

		//-- Apura Total dos Intervalos Efetivos
		nPreTotInt := 0
		For nFor := 2 To Len(aPrevisto) Step 2
			If Len(aPrevisto) >= nFor + 1
				nPreTotInt := __TimeSum(nPreTotInt,__fNStoDH(__fDHtoNS(aPrevisto[nFor+1,2],aPrevisto[nFor+1,1])-__fDHtoNS(aPrevisto[nFor,2],aPrevisto[nFor,1]),'H') )
			Endif
		Next nFor

		//-- N„o Considera Horas a Menos em Afastamentos
		If !lAfasta
			For nFor := 2 To Len(aEfetivo) Step 2
				If Len(aEfetivo) >= nFor + 1
					nEfeTotInt := __TimeSum(nEfeTotInt, __fNStoDH(__fDHtoNS(aEfetivo[nFor+1,2],aEfetivo[nFor+1,1])-__fDHtoNS(aEfetivo[nFor,2],aEfetivo[nFor,1]),'H') )
				Endif
			Next nFor

			//-- Busca os abonos do dia 
			nAbono := 0
			If ( nPos := Ascan(aAbonos,{|x| x[1] == dRef }) ) > 0
				nAbono := aAbonos[nPos,2]
			Endif

			If nPreTotInt > nEfeTotInt .And. nEfeTotInt > 0.00
				If !lIntMenPre //-- Considerar intervalos menores que o programado
					nEfeTotInt := nPreTotInt
				EndIf					
			Endif

			//-- Total de Horas Trabalhadas
			nEfeTotTra := __TimeSub(nEfeTotHor,nEfeTotInt)
			nPreTotTra := __TimeSub(nPreTotHor,nPreTotInt)

			nDifHor := __TimeSum(nEfeTotTra,nAbono)
			nDifHor := __TimeSub(nDifHor,nPreTotTra)

			If nPreTotTra > 0
				nPerDifHor := ((((Int(ABS(nDifHor))*60)  +  ((ABS(nDifHor)-Int(ABS(nDifHor))))*100))*100) / ;
					( ( Int( fConvHr( nPreTotTra, "D", .T. ) * 60 ) ) + ( (nPreTotTra - Int( nPreTotTra ) ) ) )
			Else
				If nEfeTotTra > 0
					nPerDifHor := 100
				Endif
			Endif

			If nDifHor < 0.00
				nPerDifHor *= -1
			Endif
		EndIf

		If !lSint
			cDet += Transform(nEfeTotHor, '@E 999.99' ) + " "
			cDet += Transform(nEfeTotInt, '@E 999.99' ) + " "
			cDet += Transform(nEfeTotTra, '@E 999.99' ) + " "
			cDet += Transform(nAbono    , '@E 999.99' ) + " "
			cDet += Transform(nDifHor   , '@R 9999.99') + " "
			cDet += Transform(nPerDifHor, '@R 9999.99') + ' |'
		Endif

		For nFor := 1 To 4
			aEfeTotHor[nFor] := __TimeSum(nEfeTotHor,aEfeTotHor[nFor])
			aEfeTotInt[nFor] := __TimeSum(nEfeTotInt,aEfeTotInt[nFor])
			aEfeTotTra[nFor] := __TimeSum(nEfeTotTra,aEfeTotTra[nFor])
			aPreTotTra[nFor] := __TimeSum(nPreTotTra,aPreTotTra[nFor])
			aDifHor[nFor]    := __TimeSum(nDifHor   ,aDifHor[nFor]   )
			aAboTot[nFor]    := __TimeSum(nAbono    ,aAboTot[nFor]   )
		Next

		If !lSint
			aAdd(aFun,cDet)
		Endif
		
	Next nFor1

	// Verifica se não carregou as marcações e salta para o proximo funcionario
	If Len(aFun) == 0 .And. !lSint
		(cAliasQry)->(DbSkip())
		Loop
	Endif

	// Caso o relatorio seja sintetico imprimir apenas os totais do funcionario
	If lSint
		oSection:Cell( "TOTHORAS" ):SetValue(aEfeTotHor[1])
		oSection:Cell( "INTERVALO" ):SetValue(aEfeTotInt[1])		
		oSection:Cell( "HORASTRAB" ):SetValue(aEfeTotTra[1])
		oSection:Cell( "HORASABONADAS" ):SetValue(aAboTot[1])
		oSection:Cell( "HORASDIFERENCA" ):SetValue(aDifHor[1])

		nPerDifHor := ((((Int(ABS(aDifHor[1]))*60)  +  ((ABS(aDifHor[1])-Int(ABS(aDifHor[1]))))*100))*100) / ;
		((Int(aPreTotTra[1])*60)+(((aPreTotTra[1]-Int(aPreTotTra[1])))*100))
		If aDifHor[1] < 0.00
			nPerDifHor *= -1
		Endif

		oSection:Cell( "PERCDIFERENCA" ):SetValue(nPerDifHor)

	Endif
	
	oSection:PrintLine()

	// Caso seja analitico imprimi as marcacoes previstas e realizadas
	If !lSint

		oSection1:Init(.F.) 
		oReport:SkipLine()
		oReport:PrintText( Space(12) + PADC(OemToAnsi(STR0058),52) + PADC(OemToAnsi(STR0059),80) + PADC(OemToAnsi(STR0060),60) ) 
		oReport:SkipLine()

		oSection1:SetHeaderSection(.T.)
		oSection1:PrintHeader() 
		oSection1:SetHeaderSection(.F.)

		For nFor := 1 to Len( aFun )
	
			// Colunas do aFun
			// DATA 		-  1 a   9 - 99/99 xxx
			// PREVISTA 	- 13 a  59 - 99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99
			// REALIZADA	- 63 a 133 - 99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99
			// TOTHORAS 	- 137 a 142 - 999.99       
	        // INTERVALO	- 144 a 149 - 999.99       
	        // HORASTRAB	- 151 a 156 - 999.99       
	        // HORASABONADAS- 158 a 163 - 999.99       
			// HORASDIFERENCA-165 a 171 - 9999.99
			// PERCDIFERENCA- 173 a 179 - 9999.99
			//         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7                        
			//123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
			//01/02 Ter   08:00 12:00                                                                  ** TRANSFERIDO **                                0.00   0.00   0.00   0.00    0.00    0.00 |
			//99/99 xxx   08:00 12:00 99:99 99:99 99:99 99:99 99:99 99:99   99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99 99:99   999.99 999.99 999.99 999.99 9999.99 9999.99 |
	
			oSection1:Cell( "DATA" ):SetValue(SubStr(aFun[nFor],1,9))
			oSection1:Cell( "PREVISTA" ):SetValue(SubStr(aFun[nFor],13,48))
			oSection1:Cell( "REALIZADA" ):SetValue(SubStr(aFun[nFor],63,72))
			oSection1:Cell( "TOTHORAS" ):SetValue(Val(Transform(SubStr(aFun[nFor],137,6), '@E 999.99' )))
			oSection1:Cell( "INTERVALO" ):SetValue(Val(Transform(SubStr(aFun[nFor],144,6), '@E 999.99')))		
			oSection1:Cell( "HORASTRAB" ):SetValue(Val(Transform(SubStr(aFun[nFor],151,6), '@E 999.99' )))
			oSection1:Cell( "HORASABONADAS" ):SetValue(Val(Transform(SubStr(aFun[nFor],158,6), '@E 999.99' )))
			oSection1:Cell( "HORASDIFERENCA" ):SetValue(Val(Transform(SubStr(aFun[nFor],165,7), '@E 9999.99' )))
			oSection1:Cell( "PERCDIFERENCA" ):SetValue(Val(Transform(SubStr(aFun[nFor],173,7), '@E 9999.99' )))
	
			//-- Imprime os conteudos da Section
		   	oSection1:PrintLine()
		Next
		//-- Imprime Total por Funcionario
		oReport:ThinLine()
		oSection1:Cell( "DATA" ):SetValue(Space(1))
		oSection1:Cell( "PREVISTA" ):SetValue(OemToAnsi(STR0029))
		oSection1:Cell( "REALIZADA" ):SetValue(Space(1))
		oSection1:Cell( "TOTHORAS" ):SetValue(Transform(aEfeTotHor[1], "@E 999.99"))
		oSection1:Cell( "INTERVALO" ):SetValue(Transform(aEfeTotInt[1], '@E 999.99'))		
		oSection1:Cell( "HORASTRAB" ):SetValue(Transform(aEfeTotTra[1], '@E 999.99'))
		oSection1:Cell( "HORASABONADAS" ):SetValue(Transform(aAboTot[1], '@E 999.99' ))
		oSection1:Cell( "HORASDIFERENCA" ):SetValue(Transform(aDifHor[1], '@E 9999.99' ))

		nPerDifHor := ((((Int(ABS(aDifHor[1]))*60)  +  ((ABS(aDifHor[1])-Int(ABS(aDifHor[1]))))*100))*100) / ;
		((Int(aPreTotTra[1])*60)+(((aPreTotTra[1]-Int(aPreTotTra[1])))*100))
		If aDifHor[1] < 0.00
			nPerDifHor *= -1
		Endif

		oSection1:Cell( "PERCDIFERENCA" ):SetValue(nPerDifHor)
	
		//-- Imprime os conteudos da Section
	   	oSection1:PrintLine()
		oReport:SkipLine()
		oSection1:Finish()
	Endif	

	oReport:ThinLine()

	(cAliasQry)->(DbSkip())
	
EndDo

// Imprime os totais por Centro de Custo ou Turno de Trabalho
If (lSint .Or. aEfeTotHor[2]<> 0 .Or. aEfeTotInt[2]<> 0 .Or. aEfeTotTra[2] <> 0 .Or. aPreTotTra[2] <> 0 .Or. aDifHor[2] <> 0 .Or. aAboTot[2] <> 0) .And. (nOrdem == 2 .Or. nOrdem == 4 .Or. nOrdem == 5)
	F080RCabTot(oReport,oSection2,nOrdem)
Endif

// Imprime os totais por Filial
If lSint .Or. aEfeTotHor[3]<> 0 .Or. aEfeTotInt[3]<> 0 .Or. aEfeTotTra[3] <> 0 .Or. aPreTotTra[3] <> 0 .Or. aDifHor[3] <> 0 .Or. aAboTot[3] <> 0
	F080RCabTot(oReport,oSection2,9)
Endif

// Imprime os totais por Empresa
F080RCabTot(oReport,oSection2,99)		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza impressao inicializada pelo metodo Init             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection:Finish()

If Select(cAliasQry) > 0
	(cAliasQry)->(dbCloseArea())
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³F080RCabTot ³Autor³ Totvs IP-RH 		    ³ Data ³ 27.04.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de totalizadores para TReport                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ F080RCabTot (oReport,oSection ,nOrdem)                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oReport     - objeto principal                             ³±±
±±³          ³ oSection    - objeto da secao                              ³±±
±±³          ³ nOrdem      - Numero da Ordem de impressao                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR080                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/			
Static Function F080RCabTot(oReport,oSectionTotal,nOrdem)
Local cDescTot		:= ""
Local nTipo			:= 0
Local nPerDifHor	:= 0

//-- Configuracao dos tipos
// 2-Total Centro de Custo ou Turno de Trabalho
// 3-Total Filial
// 4-Total Empresa

If (nOrdem <> 2 .And. nOrdem <> 4 .And. nOrdem <> 5 )
	oReport:EndPage()	// Salta uma pagina para a impressão dos totais
Endif

//-- Preenche 1.o Elemento do array Total dos Tipos com "Total: "
If nOrdem == 2 
	cDescTot := STR0020	+ " " + cCcAnte + "-" + cCcDesc // "Total do Centro de Custo"
	nTipo := 2
Elseif nOrdem == 4
	cDescTot := STR0062	+ " " + cTnoAnte + "-" + cTnoDesc// "Total Turno de Trabalho" 
	nTipo := 2
Elseif nOrdem == 5
	cDescTot := STR0020	+ " " + cCcAnte + "-" + cCcDesc // "Total do Centro de Custo"
	nTipo := 2
ElseIf nOrdem == 9
	cDescTot := STR0063 + " " + cFilAnte + "-" + aInfo[1]	// "Total Filial" 
	nTipo := 3
Elseif nOrdem == 99
	cDescTot := STR0064	// "Total Empresa" 
	nTipo := 4
Endif

oSectionTotal:SetHeaderSection(.T.)
oSectionTotal:Init(.F.)
oSectionTotal:PrintHeader() 
oSectionTotal:SetHeaderSection(.F.)

oSectionTotal:Cell( "DESCRICAO" ):SetValue(Padr(cDescTot,70))
oSectionTotal:Cell( "TOTHORAS" ):SetValue(aEfeTotHor[nTipo])
oSectionTotal:Cell( "INTERVALO" ):SetValue(aEfeTotInt[nTipo])		
oSectionTotal:Cell( "HORASTRAB" ):SetValue(aEfeTotTra[nTipo])
oSectionTotal:Cell( "HORASABONADAS" ):SetValue(aAboTot[nTipo])
oSectionTotal:Cell( "HORASDIFERENCA" ):SetValue(aDifHor[nTipo])

nPerDifHor := ((((Int(ABS(aDifHor[nTipo]))*60)  +  ((ABS(aDifHor[nTipo])-Int(ABS(aDifHor[nTipo]))))*100))*100) / ;
((Int(aPreTotTra[nTipo])*60)+((aPreTotTra[nTipo]-Int(aPreTotTra[nTipo]))))
If aDifHor[nTipo] < 0.00
	nPerDifHor *= -1
Endif
oSectionTotal:Cell( "PERCDIFERENCA" ):SetValue(nPerDifHor)

oReport:SkipLine()

oSectionTotal:PrintLine()
oSectionTotal:Finish()

oReport:SkipLine()
oReport:ThinLine()

aEfeTotHor[nTipo] := 0
aEfeTotInt[nTipo] := 0
aEfeTotTra[nTipo] := 0
aPreTotTra[nTipo] := 0
aDifHor[nTipo]    := 0
aAboTot[nTipo]    := 0
// Verifica se o total eh por filial e zera tambem o total por Centro de Custo ou Turno de Trabalho

If nTipo == 3	// Filial
	aEfeTotHor[2] := 0
	aEfeTotInt[2] := 0
	aEfeTotTra[2] := 0
	aPreTotTra[2] := 0
	aDifHor[2]    := 0
	aAboTot[2]    := 0
Endif

Return
