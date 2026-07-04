/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR160.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PONR160  ³ Autor ³ Flavio Correa         ³ Data ³ 10.06.16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Faltas                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR160(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ FNC          ³  Motivo da Alteracao             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Flavio Corr ³10/06/16³ RHRH001-105  ³Criação do relatório de faltas    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PONR160()
Local	oReport   
Local	aArea 		:= GetArea()
Private nColPro	:= 0
Private cPerg		:= "PN160R"

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
±±³Sintaxe   ³ PONR160                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR160 - Generico                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport 
Local oSection1 
Local bBlkFil 	:= { || If ( cCodFilial != (cAliasQry)->RA_FILIAL, Eval( { || fInfo(@aInfo,(cAliasQry)->RA_FILIAL), aInfo[3] } ), aInfo[1] ) }
Local aOrd 		:= {STR0001 ,STR0002 ,STR0003 } // "Filial"###"Centro de Custo"###"Departamento"

Private cTitulo	:= OemToAnsi(STR0004)// "Relatorio de Faltas"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao dos componentes de impressao                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "PONR160" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PN160Imp(oReport)} DESCRIPTION OemtoAnsi(STR0005) TOTAL IN COLUMN // "Contabilização de faltas"

	oSection1 := TRSection():New( oReport, OemToAnsi(STR0006), {"SRA","SPH"}, aOrd,,,,) // "Funcionarios"
		
		TRCell():New(oSection1,"RA_FILIAL","SRA",,/*Picture*/,8,/*lPixel*/,{|| 	If(!Empty((cAliasQry)->RA_FILIAL),;
																								cCodFilial:= (cAliasQry)->RA_FILIAL,;
																								NIL),;
																								cCodFilial}	)
		TRCell():New(oSection1,"FILIAL","",OemToAnsi(STR0007),/*Picture*/,20,/*lPixel*/,{|| Eval( bBlkFil ) })	// "Desc.Filial"
		
		TRCell():New(oSection1,"RA_MAT"		,"SRA",,,6)
		TRCell():New(oSection1,"RA_NOME"	,"SRA",,,30,,,,.T.)
		TRCell():New(oSection1,"RA_CC"		,"SRA",OemToAnsi(STR0008),,10)	// "C.Custo"
		TRCell():New(oSection1,"RA_DEPTO"	,"SRA",,,23,,,,.T.)
		TRCell():New(oSection1,"RA_TNOTRAB"	,"SRA",OemToAnsi(STR0009),,5)	// "Tno"
		TRCell():New(oSection1,"DATA"	    ,""  ,STR0010,,12,,,,)//"Data"
		TRCell():New(oSection1,"NAOAUT"		,""  ,OemToAnsi(STR0011),'@E 999999.99',13,,,,.T.)//"Não Autorizadas"
		TRCell():New(oSection1,"AUT"		,""  ,STR0012,'@E 999999.99',13,,,,.T.)//"Autorizadas"
		TRCell():New(oSection1,"ABONADAS"	,""  ,STR0013,'@E 999999.99',13,/*lPixel*/,/*{||  }*/,,.T.,)//"Abonadas"
		TRCell():New(oSection1,"SUSPENSAO"	,""  ,OemToAnsi(STR0015),'@E 999999.99',13,/*lPixel*/,/*{||  }*/,,.T.,)//"Suspensão"
Return(oReport)

Static Function PN160Imp(oReport)
Local cAcessaSRA	:= &( " { || " + ChkRH( "PONR160" , "SRA" , "2" ) + " } " )
Local oSection  	:= oReport:Section(1)
Local cSitQuery		:= ""    
Local cCatQuery		:= ""  
Local nReg			:= 0
Local nOrdem		:= 1
Local cOrdem	 	:= ""
Local cFilSPHSP9	:= ""
Local cFilSPCSP9	:= ""
Local cFilPHSP9I	:= ""
Local cFilPCSP9I	:= ""
Local cFiltroSPH 	:= ""
Local cFiltroSPC 	:= ""
Local cFiltroSRA	:= ""
Local cSit     		:= ""
Local cCat     		:= ""
Local nTipo	 		:= 1
Local oBreakCc
Local oBreakFil
Local cAliasMarc	
Local nVal1 		:= 0
Local nVal2 		:= 0
Local nVal3 		:= 0
Local nVal4			:= 0
Local aDet 			:= {}
Local nI, nJ		:= 1
Local lSexaCent 	:= 1
Local cCposSPH		:= "%"
Local cCposSPC		:= "%"
Local aCposSPH		:= {}
Local aCposSPC		:= {}
Local aAux			:= {}
Local cFilAnt		:= ""
Local cFilAtu		:= ""

Private aInfo		:= {}
Private cCodFilial	:= "##"
Private cAliasQry 	:= GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        //  Filial                                   ³
//³ MV_PAR02        //  Centro de Custo                          ³
//³ MV_PAR03        //  Departamento                             ³
//³ MV_PAR04        //  Matricula                                ³
//³ MV_PAR05        //  Relatorio 1=Analitico;2=Sintetico        ³
//³ MV_PAR06        //  Data de ate                              ³
//³ MV_PAR07        //  Categoria   
//³ MV_PAR08        //  Situacao                                 ³
//³ MV_PAR09        //  Horas em                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


nTipo   	 := MV_PAR05
lSexaCent  	:= MV_PAR09
cCat     	:= MV_PAR07
cSit     	:= MV_PAR08

SRA->(dbSetOrder(1))

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

cFiltroSPH := ""

If !Empty(MV_PAR01)
	cFiltroSRA += " AND " + MV_PAR01 
EndIf

If !Empty(MV_PAR02)
	cFiltroSRA += 	" AND " + MV_PAR02 
EndIf

If !Empty(MV_PAR03)
	cFiltroSRA += 	" AND " + MV_PAR03 
EndIf

If !Empty(MV_PAR04)
	cFiltroSRA += 	" AND " + MV_PAR04 
EndIf

If !Empty(MV_PAR06)
	cFiltroSPH += 	" AND " + MV_PAR06 
	cFiltroSPC += 	" AND " + Replace(MV_PAR06,"PH_","PC_") 
EndIf

If !Empty(cFiltroSRA)
	cFiltroSRA := "%" + cFiltroSRA + "%"
Else
	cFiltroSRA := "%%"
EndIf

BEGIN REPORT QUERY oSection

cFilSPHSP9	:= "%" + FWJoinFilial("SPH", "SP9") + "%"
cFilSPCSP9	:= "%" + FWJoinFilial("SPC", "SP9") + "%"
cFilPHSP9I	:= "%" + FWJoinFilial("SPH", "SP9",,"SP9I") + "%"
cFilPCSP9I	:= "%" + FWJoinFilial("SPC", "SP9",,"SP9I") + "%"

nOrdem		:= oSection:GetOrder()
If nOrdem == 1
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_MAT%"
ElseIf nOrdem == 2
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_MAT%"
ElseIf nOrdem == 3
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_DEPTO,SRA.RA_MAT%"
Endif

If nTipo == 1
	oSection:Cell( "DATA"):Enable()
Else
	oSection:Cell( "DATA"):Disable()
EndIf
BeginSql alias cAliasQry
	SELECT SRA.RA_FILIAL,SRA.RA_NOME,RA_TNOTRAB,RA_DEPTO,RA_CC,RA_MAT
	FROM %table:SRA% SRA
	WHERE SRA.D_E_L_E_T_ =' '
	%exp:cFiltroSRA% 
	AND SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	
    AND SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	
    ORDER BY %exp:cOrdem%
EndSql
	
END REPORT QUERY oSection 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Quebra de pagina C.Custo                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (nOrdem = 2 ) 
	DEFINE BREAK oBreakCc OF oSection WHEN {|| (cAliasQry)->RA_CC } TITLE OemToansi(STR0002) //Centro de Custo
	DEFINE FUNCTION FROM oSection:Cell("NAOAUT") 	FUNCTION TIMESUM BREAK oBreakCc NO END SECTION NO END REPORT 
	DEFINE FUNCTION FROM oSection:Cell("AUT") 		FUNCTION TIMESUM BREAK oBreakCc NO END SECTION NO END REPORT 
	DEFINE FUNCTION FROM oSection:Cell("ABONADAS") 	FUNCTION TIMESUM BREAK oBreakCc NO END SECTION NO END REPORT
	DEFINE FUNCTION FROM oSection:Cell("SUSPENSAO") FUNCTION TIMESUM BREAK oBreakCc NO END SECTION NO END REPORT
	oBreakCc:SetPageBreak(.F.) 
	oBreakCc:SetHeaderBreak(.F.) 
ElseIf (nOrdem = 3) 
	DEFINE BREAK oBreakCc OF oSection WHEN {|| (cAliasQry)->RA_DEPTO } TITLE OemToansi(STR0003) //"Departamento"
	DEFINE FUNCTION FROM oSection:Cell("NAOAUT") 	FUNCTION TIMESUM BREAK oBreakCc NO END SECTION NO END REPORT 
	DEFINE FUNCTION FROM oSection:Cell("AUT") 		FUNCTION TIMESUM BREAK oBreakCc NO END SECTION NO END REPORT 
	DEFINE FUNCTION FROM oSection:Cell("ABONADAS") 	FUNCTION TIMESUM BREAK oBreakCc NO END SECTION NO END REPORT
	DEFINE FUNCTION FROM oSection:Cell("SUSPENSAO")	FUNCTION TIMESUM BREAK oBreakCc NO END SECTION NO END REPORT
	oBreakCc:SetPageBreak(.F.) 
	oBreakCc:SetHeaderBreak(.F.) 
Endif 

DEFINE BREAK oBreakFil OF oSection WHEN {|| (cAliasQry)->RA_FILIAL }  TITLE OemToansi(STR0014) //"Total Filial"
DEFINE FUNCTION FROM oSection:Cell("NAOAUT") 	FUNCTION TIMESUM BREAK oBreakFil //NO END SECTION  
DEFINE FUNCTION FROM oSection:Cell("AUT") 		FUNCTION TIMESUM BREAK oBreakFil //NO END SECTION
DEFINE FUNCTION FROM oSection:Cell("ABONADAS") 	FUNCTION TIMESUM BREAK oBreakFil //NO END SECTION
DEFINE FUNCTION FROM oSection:Cell("SUSPENSAO") FUNCTION TIMESUM BREAK oBreakFil //NO END SECTION
oBreakFil:SetHeaderBreak(.F.) 
oBreakFil:SetPageBreak(.F.)

oSection:SetHeaderSection(.T.)
oSection:SetHeaderBreak(.F.) 

If nTipo == 1
	For nI := 1 To Len(oSection:aCell)
		If oSection:aCell[nI]:lUserField .And. oSection:aCell[nI]:cAlias == "SPH"
			Aadd(aCposSPH, oSection:aCell[nI]:cName)
			Aadd(aCposSPC, "PC" + subStr(oSection:aCell[nI]:cName, At("_", oSection:aCell[nI]:cName)))
			cCposSPH += "," + oSection:aCell[nI]:cName
			cCposSPC += ", PC" + subStr(oSection:aCell[nI]:cName, At("_", oSection:aCell[nI]:cName))
		EndIf
	Next
	
	For nI := 1 To Len(oSection:aUserFilter)
		If oSection:aUserFilter[nI,1] == "SPH" .And. !Empty(oSection:aUserFilter[nI,3])
			cFiltroSPH += " AND (" + oSection:aUserFilter[nI,3] + ")"
			cFiltroSPC += " AND (" + Replace(oSection:aUserFilter[nI,3], "PH_","PC_") + ")"
			aDel(oSection:aUserFilter, nI)
			aSize(oSection:aUserFilter, Len(oSection:aUserFilter) - 1)
			Exit
		EndIf
	Next
EndIf

cFiltroSPH := "%" + cFiltroSPH + "%"
cFiltroSPC := "%" + cFiltroSPC + "%"

cCposSPH += "%"
cCposSPC += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a variavel aInfo com a filial Logada              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
fInfo(@aInfo,(cAliasQry)->RA_FILIAL)

//-- Define o total da regua da tela de processamento do relatorio
oReport:SetMeter( 100 )  
oSection:Init(.F.)        
While !(cAliasQry)->( EOF() ) 
	
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
	cFilAtu := (cAliasQry)->RA_FILIAL

	If cFilAnt <> cFilAtu
		cFilAnt := cFilAtu
		fInfo(@aInfo,cFilAtu)
	EndIf
	
	cAliasMarc := GetNextAlias()
	BeginSql alias cAliasMarc
		SELECT PC_FILIAL, PC_MAT, PC_CC, PC_DEPTO, PC_DATA, PC_QUANTC, PC_QUANTI, PC_QTABONO, PC_PD, SP9.P9_IDPON, PC_PDI, SP9I.P9_IDPON as P9_IDPONI %exp:cCposSPC%
		FROM %table:SPC% SPC
		INNER JOIN %table:SP9% SP9 ON %exp:cFilSPCSP9% AND P9_CODIGO = PC_PD AND SP9.D_E_L_E_T_ = ' ' AND P9_IDPON IN('008A','010A','032A','034A','007N','009N','033N','035N','043A')
		LEFT JOIN %table:SP9% SP9I ON %exp:cFilPCSP9I% AND SP9I.P9_CODIGO = PC_PDI AND SP9I.D_E_L_E_T_ = ' ' AND SP9I.P9_IDPON IN('008A','010A','032A','034A','007N','009N','033N','035N','043A')
		WHERE SPC.D_E_L_E_T_ =' '
		%exp:cFiltroSPC% 
		AND PC_MAT = %exp:(cAliasQry)->RA_MAT% 
		AND PC_FILIAL = %exp:(cAliasQry)->RA_FILIAL% 
		UNION ALL
		SELECT PH_FILIAL, PH_MAT, PH_CC, PH_DEPTO, PH_DATA, PH_QUANTC, PH_QUANTI, PH_QTABONO, PH_PD, SP9.P9_IDPON, PH_PDI, SP9I.P9_IDPON as P9_IDPONI %exp:cCposSPH%
		FROM %table:SPH% SPH
		INNER JOIN %table:SP9% SP9 ON %exp:cFilSPHSP9% AND P9_CODIGO = PH_PD AND SP9.D_E_L_E_T_ = ' ' AND P9_IDPON IN('008A','010A','032A','034A','007N','009N','033N','035N','043A')
		LEFT JOIN %table:SP9% SP9I ON %exp:cFilPHSP9I% AND SP9I.P9_CODIGO = PH_PDI AND SP9I.D_E_L_E_T_ = ' ' AND SP9I.P9_IDPON IN('008A','010A','032A','034A','007N','009N','033N','035N','043A')
		WHERE SPH.D_E_L_E_T_ =' '
		%exp:cFiltroSPH% 
		AND PH_MAT = %exp:(cAliasQry)->RA_MAT% 
		AND PH_FILIAL = %exp:(cAliasQry)->RA_FILIAL% 
		ORDER BY PC_FILIAL, PC_MAT, PC_CC, PC_DEPTO, PC_DATA
	EndSql
	
	aDet := {}
	While !(cAliasMarc)->( EOF() ) 
		nVal1 := 0
		nVal2 := 0
		nVal3 := 0
		nVal4 := 0
		aAux := {}
		
		If (!Empty(PC_PDI) .And. P9_IDPONI == "043A") .Or. (Empty(P9_IDPONI) .And. P9_IDPON == "043A")
			nVal4 := If(!Empty(PC_PDI) .And. !Empty(P9_IDPONI), PC_QUANTI, PC_QUANTC)
		ElseIf (!Empty(PC_PDI) .And. Right(P9_IDPONI,1) == "N") .Or. (Empty(P9_IDPONI) .And. Right(P9_IDPON,1) == "N")
			nVal1 := If(!Empty(PC_PDI) .And. !Empty(P9_IDPONI), PC_QUANTI, PC_QUANTC)
		ElseIf (!Empty(PC_PDI) .And. Right(P9_IDPONI,1) == "A") .Or. (Empty(P9_IDPONI) .And. Right(P9_IDPON,1) == "A")
			nVal2 := If(!Empty(PC_PDI) .And. !Empty(P9_IDPONI), PC_QUANTI, PC_QUANTC)
		EndIf
		
		nVal3 := (cAliasMarc)->PC_QTABONO
		If nTipo == 1 //Analitico
			nRet  := aScan( aDet,{|X| x[1] == (cAliasMarc)->PC_DATA} )   
		Else
			nRet  := aScan( aDet,{|X| x[1] == (cAliasMarc)->PC_MAT} )   
		EndIf
		
		If nRet == 0
		    If nTipo == 1 //Analitico
				
				For nI := 1 To Len(aCposSPC) // Conteúdo dos campos incluídos pelo usuário
					Aadd(aAux, (cAliasMarc)->&(aCposSPC[nI]))
				Next
				
		   		Aadd(aDet, {(cAliasMarc)->PC_DATA, nVal1, nVal2, nVal3, nVal4, aAux})  // se nao cria elemento
			ELse
		   		Aadd(aDet, {(cAliasMarc)->PC_MAT, nVal1, nVal2, nVal3, nVal4})  // se nao cria elemento
			EndIf
		Else                                        
			aDet[nRet,2] := SomaHoras(aDet[nRet,2], nVal1)
			aDet[nRet,3] := SomaHoras(aDet[nRet,3], nVal2)
			aDet[nRet,4] := SomaHoras(aDet[nRet,4], nVal3)
			aDet[nRet,5] := SomaHoras(aDet[nRet,5], nVal4)
		Endif
		
		(cAliasMarc)->( dbSkip() ) 
	EndDo
	
	(cAliasMarc)->(dbCloseArea())
	
	For nI := 1 To Len(aDet)
		If nTipo == 1 //Analitico
			oSection:Cell( "DATA"):SetValue(dtoc(stod(aDet[nI][1])))
		EndIf
		oSection:Cell( "NAOAUT"):SetValue(If( lSexaCent==2, fConvHr(aDet[nI][2],'D'), aDet[nI][2] ))
		oSection:Cell( "AUT"):SetValue(If( lSexaCent==2, fConvHr(aDet[nI][3],'D'), aDet[nI][3] ))				
		oSection:Cell( "ABONADAS"):SetValue(If( lSexaCent==2, fConvHr(aDet[nI][4],'D'), aDet[nI][4] ))	
		oSection:Cell( "SUSPENSAO"):SetValue(If( lSexaCent==2, fConvHr(aDet[nI][5],'D'), aDet[nI][5] ))	
		
		If nTipo == 1
			For nJ := 1 To Len(aCposSPH)
				oSection:Cell(aCposSPH[nJ]):SetValue(aDet[nI][6][nJ])
			Next
		EndIf
		
		oSection:PrintLine()
	Next nI
	(cAliasQry)->( dbSkip() ) 
EndDo

If Select(cAliasQry) > 0
	(cAliasQry)->(dbCloseArea())
Endif

Return
