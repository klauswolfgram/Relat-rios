/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR050.CH"
#INCLUDE "PONCALEN.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PONR050  ³ Autor ³ R.H. - J. Ricardo     ³ Data ³ 10.04.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio para Abono                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR050(void)                                              ³±±
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
User Function PONR050()
Local	oReport   
Local	aArea 		:= GetArea()
Private nColPro	:= 0
Static cPerg	:= "PN050R"

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
±±³Descri‡ao ³ Relatorio para Abono                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PONR050                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR050 - Generico                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport 
Local oSection1 
Local oSection2 
Local bBlkFil := { || If ( cCodFilial != (cAliasQry)->RA_FILIAL, Eval( { || fInfo(@aInfo,(cAliasQry)->RA_FILIAL), aInfo[3] } ), aInfo[1] ) }

Local aOrd 		:= {STR0004 ,STR0005 ,STR0006 ,STR0007 ,STR0020 } // "Matricula"###"Centro de Custo"###"Nome"###"Turno"###"C.Custo+Nome"
Private cTitulo		:= OemToAnsi(STR0001)			// "Relatorio para Abono"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao dos componentes de impressao                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "PONR050" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PN050Imp(oReport)} DESCRIPTION OemtoAnsi(STR0045) TOTAL IN COLUMN // "Este programa emite Relacao dos Funcionarios para Abonos de Horas"
	
	oSection1 := TRSection():New( oReport, OemToAnsi(STR0041), {"SRA","CTT","SR6"}, aOrd,,,,,.F.,.F.,.F.) // "Funcionarios"
		
		TRCell():New(oSection1,"RA_FILIAL","SRA",,/*Picture*/,8,/*lPixel*/,{|| 	If(!Empty((cAliasQry)->RA_FILIAL),;
																								cCodFilial:= (cAliasQry)->RA_FILIAL,;
																								NIL),;
																								cCodFilial}	)
		TRCell():New(oSection1,"FILIAL","",OemToAnsi(STR0035),/*Picture*/,20,/*lPixel*/,{|| Eval( bBlkFil ) })	// "Desc.Filial"
		
		TRCell():New(oSection1,"RA_CHAPA"	,"SRA",,,5)
		TRCell():New(oSection1,"RA_MAT"		,"SRA",,,6)
		TRCell():New(oSection1,"RA_NOME"	,"SRA",,,30,,,,.T.)
		TRCell():New(oSection1,"RA_CC"		,"SRA",OemToAnsi(STR0043),,9)	// "C.Custo"
		TRCell():New(oSection1,"CTT_DESC01"	,"CTT",,,25,,,,.T.)
		TRCell():New(oSection1,"RA_TNOTRAB"	,"SRA",OemToAnsi(STR0044),,3)	// "Tno"
		TRCell():New(oSection1,"R6_DESC"	,"SR6",,,20,,,,.T.)
		
	oSection2 := TRSection():New( oSection1, OemToAnsi(STR0042),,,,,,,.F.,.F.,.F. )	 //"Marcações"
		
		TRCell():New( oSection2, "PREVISTO"    	, "" ,OemToAnsi(STR0024),,24,,,,.T.) // "Previsto" 
		TRCell():New( oSection2, "REALIZADO"   	, "" ,OemToAnsi(STR0025),,24,,,,.T.) // "Realizado" 
		TRCell():New( oSection2, "DATA"     	, "" ,OemToAnsi(STR0046),,5) // "Data 
		
		TRCell():New( oSection2, "ABONO"     	, "" ,OemToAnsi(STR0036),,3) // "Abn" 
		TRCell():New( oSection2, "DESCABONO"	, "" ,OemToAnsi(STR0037),,20,,,,.T.) // "Descricao"
		TRCell():New( oSection2, "HORAS"		, "" ,OemToAnsi(STR0038),,6) // "Horas"
		TRCell():New( oSection2, "ABONADAS"		, "" ,OemToAnsi(STR0052),,6) // "Horas Abonadas"
		TRCell():New( oSection2, "HRSNABO"		, "" ,OemToAnsi(STR0053),,6) // "Horas Não abonadas"
		TRCell():New( oSection2, "JUSTIFICATIVA", "" ,OemToAnsi(STR0039),,30) // "Justificativa"
		TRCell():New( oSection2, "VISTO"		, "" ,OemToAnsi(STR0040),,20) // "Visto"
		
Return(oReport)


Static Function PN050Imp(oReport)

Local oSection  := oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1)
Local cSitQuery	:= ""    
Local cCatQuery	:= ""  
Local nReg		:= 0
Local nOrdem	:= 1
Local cCodAut 	:= "008,010,012,014,018,020,022,032,034" //-- Codigos Autorizados
Local cCodNAut 	:= "007,009,011,013,017,019,021,033,035" //-- Codigos Nao Autorizados

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis de Acesso do Usuario                               ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Local cAcessaSRA	:= &( " { || " + ChkRH( "PONR050" , "SRA" , "2" ) + " } " )
Local cAcessaSPC 	:= &( " { || " + ChkRH( "PONR050" , "SPC" , "2" ) + " } " )

Local aAutorizado  := {}
Local aJustifica   := {}	//-- retorno Justificativa de abono
Local xQuant       := 0
Local nPos         := 0
Local cPD          := Space(03)
Local nTab	     :=0
Local nPosTab	 :=0
Local nLenCalend :=0
Local aPrevFun   :={}
Local cOrdem	 :=''
Local nLimite    := 0
Local nX		 := 0
Local cCol1      := ''
Local cCol2      := ''
Local nFor		 := 0
Local cPrevDet   := ""
Local cRealDet   := ""

Local oBreakCc
Local oBreakFil
Local oBreakFun

Local lHeaderMar	:= .T.

Private aInfo		:= {}
Private cCodFilial	:= "##"
Private cDet	 := ''
Private cDet1  	 := ''
Private cDet2	 := ''
Private cDet3	 := ''
Private nVez	 := 0
Private cItem    := ''
Private lImpLinhas:= '' 

Private aDet       := {}
Private lCabec     := .F.
Private lCabecCC   := .F.
Private lCabecTT   := .F.
Private lPrimeira  := .T.
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
Private lNMarc   := .F.
Private lHExtr   := .F.
Private lInter   := .F.
Private lSitfu   := .F.
Private dPerIni  := CTOD('  /  /  ')
Private dPerFim  := CTOD('  /  /  ')

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o periodo de Apura‡„o, de acordo com MV_PAPONTA ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !PerAponta(@dPerIni,@dPerFim)
	Return( NIL )
Endif

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
//³ MV_PAR09        //  Dia Inicial                              ³
//³ MV_PAR10        //  Dia Final                                ³
//³ MV_PAR11        //  Imprimir Abonados                        ³
//³ MV_PAR12        //  Imprimir Autorizados/Nao Autorizados/Ambo³
//³ MV_PAR13        //  Relatorio Sintetico/Analitico            ³
//³ MV_PAR14        //  Quebra Func.Pag. Sim/Nao                 ³
//³ MV_PAR15        //  Imprimir Motivo Abono                    ³
//³ MV_PAR16        //  Imprimir Marca‡äes                       ³
//³ MV_PAR17        //  Regra De                                 ³
//³ MV_PAR18        //  Listar Previsao                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cSit     := MV_PAR06
cCat     := MV_PAR07
lCC      := If(MV_PAR08 == 1,.T.,.F.)
dInicio  := MV_PAR09
dFim     := MV_PAR10
lImpAbon := If(MV_PAR11 == 1,.T.,.F.)  
nTipo    := MV_PAR12
nSinAna  := MV_PAR13
lImpFol	 := If(MV_PAR14 == 1,.T.,.F.)
lImpMot  := IF(MV_PAR15 == 1,.T.,.F.)
lImpMar  := IF(MV_PAR16 == 1,.T.,.F.)
lPrevisao:= IF(MV_PAR18 == 1,.T.,.F.)  //.T. - Lista Horario Previsto

If MV_PAR09 > MV_PAR10
   Help(" ",1,"PNR050DATA")
   Return Nil
Endif

SRA->(dbSetOrder(1))

//-- Para Relatorio Sintetico nao imprime Previsao e/ou Marcacao
If nSinAna==1
   lPrevisao:=.F.
   lImpMar	:=.F.
Endif

// Identificadores de Ponto
If nTipo = 1 
	cCodigos := cCodaut
Elseif nTipo = 2
	cCodigos := cCodNAut
ElseIf nTipo = 3
	cCodigos := cCodAut+','+cCodNAut
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

END REPORT QUERY oSection PARAM mv_par01,mv_par02,mv_par03,mv_par04,mv_par05,mv_par17

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

// Verifica a existencia da tabela de Eventos para classificacao dos Abonos
DbSelectArea("SP9")
dbSetOrder(1)
If !DbSeek(xFilial("SP9",cFilAnte))
	If !DbSeek(Space(FWGETTAMFILIAL))
		(cAliasQry)->(DbSkip())
	   	Return
	Endif
Endif

// Carrega a tabela de Eventos para auxiliar a classificacao dos Abonos
cFilCompara := SP9->P9_FILIAL
aAutorizado := {}
While ! Eof() .AND. SP9->P9_FILIAL == cFilCompara
	If Subs(P9_IDPON,1,3) $ cCodigos
		Aadd(aAutorizado, {Left(P9_CODIGO,3), P9_DESC})
	Endif
	DbSkip()
EndDo

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

		cFilAnte := (cAliasQry)->RA_FILIAL

		// Carrega a tabela de Eventos para auxiliar a classificacao dos Abonos
		DbSelectArea("SP9")
		If !DbSeek(xFilial("SP9",cFilAnte))
			If !DbSeek(Space(FWGETTAMFILIAL))
			   	Exit
			Endif
		Endif

		// Carrega a tabela de Eventos para auxiliar a classificacao dos Abonos
		cFilCompara := SP9->P9_FILIAL
		aAutorizado := {}
		While ! Eof() .AND. SP9->P9_FILIAL == cFilCompara
			If Subs(P9_IDPON,1,3) $ cCodigos
				Aadd(aAutorizado, {Left(P9_CODIGO,3), P9_DESC})
			Endif
			SP9->(DbSkip())
		EndDo
		
		If Len(aAutorizado) == 0
			Exit
		Endif
		
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
	aMarcacoes	:= {}
	aTabCalend	:= {}	
	//-- Carrega as Marcacoes do Periodo
	IF !GetMarcacoes( @aMarcacoes		,;	//01 -> Marcacoes dos Funcionarios
					  @aTabCalend		,;	//02 -> Calendario de Marcacoes
					  @aTabPadrao		,;	//03 -> Tabela Padrao
					  NIL				,;	//04 -> Turnos de Trabalho
					  dPerIni 			,;	//05 -> Periodo Inicial
					  dPerFim			,;	//06 -> Periodo Final
					  (cAliasQry)->RA_FILIAL	,;	//07 -> Filial
					  (cAliasQry)->RA_MAT		,;	//08 -> Matricula
					  (cAliasQry)->RA_TNOTRAB	,;	//09 -> Turno
					  (cAliasQry)->RA_SEQTURN	,;	//10 -> Sequencia de Turno
					  (cAliasQry)->RA_CC		,;	//11 -> Centro de Custo
					  "SP8"				,;	//12 -> Alias para Carga das Marcacoes
					  .F.    			,;	//13 -> Se carrega Recno em aMarcacoes
					  .T.      			,;	//14 -> Se considera Apenas Ordenadas
					  .T.      			,;	//15 -> Se Verifica as Folgas Automaticas
					  .F.      			,;	//16 -> Se Grava Evento de Folga Automatica Periodo Anterior
					  NIL				,;	//17 -> Se Carrega as Marcacoes Automaticas
					  NIL				,;	//18 -> Registros de Marcacoes Automaticas que deverao ser Desprezadas
					  NIL				,;	//19 -> Bloco para avaliar as Marcacoes Automaticas que deverao ser Desprezadas
					  NIL				,;	//20 -> Se Considera o Periodo de Apontamento das Marcacoes
					  .F.				 ;	//21 -> Se Efetua o Sincronismo dos Horarios na Criacao do Calendario
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
	// 4 - Descricao do Abono
	// 5 - Descricao do Abono
	// 6 - Quantidade de horas Abonadas
	// 7 - Marcacoes

	dbSelectArea( "SPC" )
	If DbSeek((cAliasQry)->RA_FILIAL + (cAliasQry)->RA_Mat )
		While !Eof() .And. SPC->PC_FILIAL+SPC->PC_Mat == (cAliasQry)->RA_FILIAL+(cAliasQry)->RA_Mat

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Consiste controle de acessos e filiais validas               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Eval(cAcessaSPC)
				SPC->(dbSkip())
				Loop
			EndIf

			//-- Verifica o Periodo Solicitado
			If Empty(SPC->PC_DATA) .OR. SPC->PC_DATA < dInicio .OR. SPC->PC_DATA > dFim
				DbSkip()
				Loop
			Endif

			//-- Verifica se Deve Imprimir os Abonados
			If !lImpAbon .And. SPC->PC_QTABONO > 0
				dbSkip()
				Loop
			Endif

			//-- Utiliza o codigo informado qdo houver
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
				
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Obtem as Previsoes Cadastradas p/a Ordem Lida  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aPrevFun:={}
					If lPrevisao 
					    nLenCalend:=Len(aTabCalend)
					    nPosTab:=nTab
						//-- Corre as Previsoes de mesma Ordem
						While cOrdem == aTabCalend[nPosTab,CALEND_POS_ORDEM]
						    Aadd(aPrevFun,StrTran(StrZero(aTabCalend[nPosTab,CALEND_POS_HORA],5,2),'.',':'))
							//-- Obtem novo Horario	          			 
							nPosTab ++                  
							If	nPosTab > nLenCalend
							    Exit
							Endif    
						EndDo	
					Endif                                              
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Obtem as Marcacoes Realizadas para a Ordem Lida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aMarcFun:={}
					If lImpMar
						//-- A aMarcacoes ‚ setado para a 1a Marca‡„o do dia em quest„o.
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

				aJustifica := {}
				If lImpMot
					//-- Verifica se existe abonos e posiciona registro de abono
					fAbonos(SPC->PC_DATA, aAutorizados[nPos,1],,@aJustifica,SPC->PC_TPMARCA,SPC->PC_CC)
        		Endif

				If nSinAna == 1	// Sintetica                  
				    //-- Sintetiza por Evento
					If (nPosDet:=Ascan(aDet,{ |x| x[2] = cPD })) > 0
						aDet[nPosDet,4]:=SomaHoras(aDet[nPosDet,4],xQuant)
						//-- Acumula Abonado somente se Nao for imprimir os motivos do mesmo
						aDet[nPosDet,6]		:=If(Empty(aDet[nPosDet,6]),SomaHoras(aDet[nPosDet,6],SPC->PC_QTABONO),aDet[nPosDet,6])
						aDet[nPosDet,12]	:='A' //Ordem para Obrigar que esse seja o primeiro elemento
												  //apos o Sort do aDet	
				    Endif
 					//-- Acrescenta os motivos de abono para o evento
					If Len(aJustifica) > 0 .And. lImpMot
						For nX := 1 To Len(aJustifica)
							//-- Totaliza cada motivo para o mesmo evento
							If (nPosDet:=Ascan(aDet,{ |x| x[2] = cPD .AND. x[11]==aJustifica[nX,1]})) > 0
								//-- Totaliza Abonos para mesmo motivo
								aDet[nPosDet,6]:=SomaHoras(aDet[nPosDet,6],aJustifica[nX,2])
							Else
								aAdd(aDet,{ SPC->PC_DATA, aAutorizado[nPos,1], aAutorizado[nPos,2] ,xQuant,;
								PADR(DescAbono(aJustifica[nX,1],'C'),25),;
								aJustifica[nX,2],aMarcFun,aPrevFun,SPC->PC_TPMARCA,SPC->PC_CC,	aJustifica[nX,1],'Z'})
							Endif
						Next nX
					Else
							If nPosDet==0
							   aAdd(aDet,{ SPC->PC_DATA, aAutorizado[nPos,1], aAutorizado[nPos,2] ,	xQuant,;
						       	SPACE(25),0,aMarcFun,aPrevFun,SPC->PC_TPMARCA,SPC->PC_CC,SPACE(3),'Z'})
						    Endif   	
					Endif
				Else
					If Len(aJustifica) > 0 .And. lImpMot
						For nX := 1 To Len(aJustifica)
		    	    	    aAdd(aDet,{ SPC->PC_DATA, aAutorizado[nPos,1], aAutorizado[nPos,2] , xQuant,;
							PADR(DescAbono(aJustifica[nX,1],'C'),25),aJustifica[nX,2],aMarcFun,aPrevFun,SPC->PC_TPMARCA,SPC->PC_CC,SPACE(3),'A' })
						Next nX
					Else
						aAdd(aDet,{ SPC->PC_DATA, aAutorizado[nPos,1], aAutorizado[nPos,2] ,	xQuant,;
						SPACE(25),0,aMarcFun,aPrevFun,SPC->PC_TPMARCA,SPC->PC_CC,SPACE(3),'A'  })
					Endif
				Endif
			Endif
			DbSkip()
		EndDo

	Endif

	// Verifica se não carregou as marcações e salta para o proximo funcionario
	If Len(aDet) == 0
		(cAliasQry)->(DbSkip())
		Loop
	Endif

	//-- O Sort para Analitico e por Data e ordem 
	If nSinAna==2
  	   aSort(aDet,,,{|x,y| Dtos(x[1])+x[12] < Dtos(y[1])+y[12]}) //Data+ordem de leitura
	Else 
		//-- O Sorte no Sintetico e por Evento 
		aSort(aDet,,,{|x,y|x[2]+x[12] < y[2]+y[12]}) //Data+ordem de leitura			
	Endif                  

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

		cPrevDet := ""
		cRealDet := ""
		
		nLimite := Max(Len(aDet[nFor,7]),Len(aDet[nFor,8]))
		
	    If dDtMarc <> aDet[nFor,1]
		    dDtMarc := aDet[nFor,1]
			//-- Altera valores da Section
			For nX := 1 to nLimite
				If Len(aDet[nFor,8]) >= nX
					cPrevDet += aDet [ nFor , 8 , nX ] + Space(1)
				Endif
				If Len(aDet[nFor,7]) >= nX
					cRealDet += aDet [ nFor , 7 , nX ] + Space(1)
				Endif
			Next
		Endif
		
		If (lPrevisao  .AND. lImpMar)
			oSection1:Cell( "REALIZADO"):SetValue(cRealDet)
			oSection1:Cell( "PREVISTO"):SetValue(cPrevDet)
			oSection1:Cell( "DATA"):SetValue( SubStr( Dtos(aDet[nFor,1]),7,2) + "/" + SubStr(Dtos(aDet[nFor,1]),5,2) )
		ElseIf (lPrevisao  .AND. !lImpMar)
			oSection1:Cell( "REALIZADO"):SetValue(Space(24))
			oSection1:Cell( "PREVISTO"):SetValue(cPrevDet)
			oSection1:Cell( "DATA"):SetValue( SubStr( Dtos(aDet[nFor,1]),7,2) + "/" + SubStr(Dtos(aDet[nFor,1]),5,2) )
		ElseIf (!lPrevisao .AND.  lImpMar)
			oSection1:Cell( "REALIZADO"):SetValue(cRealDet)
			oSection1:Cell( "PREVISTO"):SetValue(Space(24))
			oSection1:Cell( "DATA"):SetValue( SubStr( Dtos(aDet[nFor,1]),7,2) + "/" + SubStr(Dtos(aDet[nFor,1]),5,2) )
		ElseIf (!lPrevisao  .AND. !lImpMar)
			oSection1:Cell( "PREVISTO"):SetValue(Space(24))
			oSection1:Cell( "REALIZADO"):SetValue(Space(24))
			oSection1:Cell( "DATA"):SetValue(Space(5))
		Endif
		
		oSection1:Cell( "ABONO"):SetValue(aDet[nFor,2])
		oSection1:Cell( "DESCABONO"):SetValue(aDet[nFor,3])
		oSection1:Cell( "HORAS"):SetValue(STRTRAN(StrZero(aDet[nFor,4],6,2),".",":"))				
		
		If lImpMot // Imprime Motivo 
			
			If !Empty(aDet[nFor,5]) //-- Evento Com Abonos a Imprimir na Data Lida
				//-- Motivo do Abono
				If nSinAna == 2 // relatório for Analitico
					oSection1:Cell( "JUSTIFICATIVA"):SetValue(aDet[nFor, 5])
				EndIf
				
				If aDet[nFor,6] > 0
					oSection1:Cell("ABONADAS"):SetValue(STRTRAN(StrZero(aDet[nFor,6], 6, 2), ".", ":"))
					oSection1:Cell("HRSNABO"):SetValue(STRTRAN(StrZero(SubHoras(aDet[nFor, 4], aDet[nFor, 6]), 6, 2), ".", ":"))
				Endif
			Else
				oSection1:Cell( "JUSTIFICATIVA"):SetValue(Repl("_", 30))
				oSection1:Cell( "ABONADAS"):SetValue("___:__")
				oSection1:Cell( "HRSNABO"):SetValue("___:__")
			Endif
		Else
			oSection1:Cell( "JUSTIFICATIVA"):SetValue(Repl("_", 30))
			oSection1:Cell( "ABONADAS"):SetValue("___:__")
			oSection1:Cell( "HRSNABO"):SetValue("___:__")
		Endif
		
		oSection1:Cell( "VISTO"):SetValue(Repl("_", 20))				
		
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
