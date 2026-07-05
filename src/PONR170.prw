/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR170.CH"
#INCLUDE "REPORT.CH"

/*/{Protheus.doc} PONR170
Relatório de horas de sobreaviso
@type Function
@author Allyson Mesashi
@since 10/03/2021
/*/
User Function PONR170()

Local	aArea 		:= GetArea()
Local	oReport   

Private cPerg		:= "PN170R"

If !ChkFile("RRS")
	Help( Nil, Nil, 'HELP', Nil, OemToAnsi(STR0013), 1, 0) //"Tabela RRS não encontrada. Execute o UPDDISTR - atualizador de dicionário e base de dados."
	Return
EndIf

Pergunte(cPerg, .F.) 

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
±±³Sintaxe   ³ PONR170                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR170 - Generico                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local aOrd 		:= {STR0001, STR0002, STR0003 } // "Filial"###"Centro de Custo"###"Departamento"
Local bBlkFil 	:= { || If ( cCodFilial != (cAliasQry)->RA_FILIAL, Eval( { || fInfo(@aInfo,(cAliasQry)->RA_FILIAL), aInfo[3] } ), aInfo[1] ) }
Local oReport 
Local oSection1 

Private cTitulo	:= OemToAnsi(STR0004)// "Relatório de Horas de Sobreaviso"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao dos componentes de impressao                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "PONR170" TITLE cTitulo PARAMETER cPerg ACTION { |oReport| PN170Imp(oReport) } DESCRIPTION OemtoAnsi(STR0005) TOTAL IN COLUMN // "Contabilização de horas"

	oSection1 := TRSection():New( oReport, OemToAnsi(STR0006), {"SRA", "SPH"}, aOrd) // "Funcionários"

	TRCell():New(oSection1,"RA_FILIAL","SRA",,/*Picture*/,8,/*lPixel*/,{|| 	If(!Empty((cAliasQry)->RA_FILIAL),;
																							cCodFilial:= (cAliasQry)->RA_FILIAL,;
																							NIL),;
																							cCodFilial}	)
	TRCell():New(oSection1,"FILIAL","",OemToAnsi(STR0007),/*Picture*/,20,/*lPixel*/,{|| Eval( bBlkFil ) })	// "Desc.Filial"

	TRCell():New(oSection1,"RA_MAT"		,"SRA",,,6)
	TRCell():New(oSection1,"RA_NOME"	,"SRA",,,30,,,,.T.)
	TRCell():New(oSection1,"RA_CC"		,"SRA",OemToAnsi(STR0008),,10)	// "C.Custo"
	TRCell():New(oSection1,"RA_DEPTO"	,"SRA",,,23,,,,.T.)
	TRCell():New(oSection1,"RA_TNOTRAB"	,"SRA",OemToAnsi(STR0009),,5)	// "Turno"
	TRCell():New(oSection1,"DATA"		,""  ,STR0010,,12,,,,)//"Data"
	TRCell():New(oSection1,"HORAS"		,""  ,STR0011,'@E 999999.99',13,,,,.T.)//"Horas"

Return(oReport)

Static Function PN170Imp(oReport)

Local aDet 			:= {}
Local cAcessaSRA	:= &( " { || " + ChkRH( "PONR170" , "SRA" , "2" ) + " } " )
Local cAliasMarc	:= ""
Local cCat     		:= ""
Local cCatQuery		:= ""  
Local cFilSPCSP9	:= ""
Local cFilSPHSP9	:= ""
Local cFiltroSPC 	:= ""
Local cFiltroSPH 	:= ""
Local cFiltroSRA	:= ""
Local cOrdem	 	:= ""
Local cSit     		:= ""
Local cSitQuery		:= ""
Local nI			:= 1
Local nOrdem		:= 1
Local nReg			:= 0
Local nSexaCent 	:= 0
Local nTipo	 		:= 1
Local nVal1 		:= 0
Local oBreakCc
Local oBreakFil
Local oSection  	:= oReport:Section(1)

Private aInfo		:= {}
Private cAliasQry 	:= GetNextAlias()
Private cCodFilial	:= "##"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        //  Filial                                   ³
//³ MV_PAR02        //  Centro de Custo                          ³
//³ MV_PAR03        //  Departamento                             ³
//³ MV_PAR04        //  Matricula                                ³
//³ MV_PAR05        //  Relatorio 1=Analitico;2=Sintetico        ³
//³ MV_PAR06        //  Data de ate                              ³
//³ MV_PAR07        //  Categoria   							 ³
//³ MV_PAR08        //  Situacao                                 ³
//³ MV_PAR09        //  Horas em                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo   	:= MV_PAR05
nSexaCent  	:= MV_PAR09
cCat     	:= MV_PAR07
cSit     	:= MV_PAR08

SRA->( dbSetOrder(1) )

//-- Modifica variaveis para a Query
For nReg := 1 To Len(cSit)
	cSitQuery += "'" + Subs(cSit, nReg, 1) + "'"
	If ( nReg+1 ) <= Len(cSit)
		cSitQuery += "," 
	Endif
Next nReg        
cSitQuery := "%" + cSitQuery + "%"

cCatQuery := ""
For nReg := 1 To Len(cCat)
	cCatQuery += "'" + Subs(cCat, nReg, 1) + "'"
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

If !Empty(cFiltroSPH)
	cFiltroSPH := "%" + cFiltroSPH + "%"
Else
	cFiltroSPH := "%%"
EndIf

If !Empty(cFiltroSPC)
	cFiltroSPC := "%" + cFiltroSPC + "%"
Else
	cFiltroSPC := "%%"
EndIf

If !Empty(cFiltroSRA)
	cFiltroSRA := "%" + cFiltroSRA + "%"
Else
	cFiltroSRA := "%%"
EndIf

BEGIN REPORT QUERY oSection

cFilSPHSP9	:= "%" + FWJoinFilial("SPH", "SP9") + "%"
cFilSPCSP9	:= "%" + FWJoinFilial("SPC", "SP9") + "%"

nOrdem		:= oSection:GetOrder()
If nOrdem == 1
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_MAT%"
ElseIf nOrdem == 2
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_MAT%"
ElseIf nOrdem == 3
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_DEPTO,SRA.RA_MAT%"
Endif

If nTipo == 1
	oSection:Cell("DATA"):Enable()
Else
	oSection:Cell("DATA"):Disable()
EndIf

BeginSql alias cAliasQry
	SELECT SRA.RA_FILIAL,SRA.RA_NOME,RA_TNOTRAB,RA_DEPTO,RA_CC,RA_MAT
	FROM %table:SRA% SRA
	WHERE SRA.D_E_L_E_T_ =' '
	%exp:cFiltroSRA% 
	AND SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%) 	
    AND SRA.RA_CATFUNC IN (%exp:Upper(cCatQuery)%)	
    ORDER BY %exp:cOrdem%
EndSql
	
END REPORT QUERY oSection 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Quebra de pagina C.Custo                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 2
	DEFINE BREAK oBreakCc OF oSection WHEN { || (cAliasQry)->RA_CC } TITLE OemToansi(STR0002)//Centro de Custo
	DEFINE FUNCTION FROM oSection:Cell("HORAS") FUNCTION TIMESUM BREAK oBreakCc NO END SECTION NO END REPORT 

	oBreakCc:SetPageBreak(.F.) 
	oBreakCc:SetHeaderBreak(.F.) 
ElseIf nOrdem == 3
	DEFINE BREAK oBreakCc OF oSection WHEN { || (cAliasQry)->RA_DEPTO } TITLE OemToansi(STR0003)//"Departamento"
	DEFINE FUNCTION FROM oSection:Cell("HORAS") FUNCTION TIMESUM BREAK oBreakCc NO END SECTION NO END REPORT 

	oBreakCc:SetPageBreak(.F.) 
	oBreakCc:SetHeaderBreak(.F.) 
EndIf 

DEFINE BREAK oBreakFil OF oSection WHEN { || (cAliasQry)->RA_FILIAL }  TITLE OemToansi(STR0012) //"Total Filial"
DEFINE FUNCTION FROM oSection:Cell("HORAS") FUNCTION TIMESUM BREAK oBreakFil //NO END SECTION

oBreakFil:SetHeaderBreak(.F.) 
oBreakFil:SetPageBreak(.F.)

oSection:SetHeaderSection(.T.)
oSection:SetHeaderBreak(.F.) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a variavel aInfo com a filial Logada              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
fInfo(@aInfo, (cAliasQry)->RA_FILIAL)

//-- Define o total da regua da tela de processamento do relatorio
oReport:SetMeter( 100 )  
oSection:Init(.F.)        
While !(cAliasQry)->( EoF() ) 
	oReport:IncMeter( 1 )   

	//-- Verifica se o usuário cancelou a impressão do relatorio
	If oReport:Cancel()
		Exit
	EndIf               

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Consiste Filiais e Acessos                                             ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If !( (cAliasQry)->RA_FILIAL $ fValidFil() ) .Or. !Eval( cAcessaSRA )
		(cAliasQry)->(DbSkip())
	   	Loop
	EndIf
	
	cAliasMarc := GetNextAlias()
	BeginSql Alias cAliasMarc
		SELECT PC_FILIAL,PC_MAT,PC_CC,PC_DEPTO,PC_DATA,PC_QUANTC,PC_QUANTI,PC_QTABONO,PC_PD,PC_PDI,P9_IDPON
			FROM %table:SPC% SPC
				INNER JOIN %table:SP9% SP9 ON %exp:cFilSPCSP9% AND SP9.P9_CODIGO = SPC.PC_PD AND SP9.D_E_L_E_T_ = ' ' AND SP9.P9_IDPON IN ('044A')
			WHERE SPC.D_E_L_E_T_ = ' '
				%exp:cFiltroSPC% 
				AND PC_MAT = %exp:(cAliasQry)->RA_MAT% 
				AND PC_FILIAL = %exp:(cAliasQry)->RA_FILIAL% 
		UNION ALL
		SELECT PH_FILIAL,PH_MAT,PH_CC,PH_DEPTO,PH_DATA,PH_QUANTC,PH_QUANTI,PH_QTABONO,PH_PD,PH_PDI,P9_IDPON
			FROM %table:SPH% SPH
				INNER JOIN %table:SP9% SP9 ON %exp:cFilSPHSP9% AND SP9.P9_CODIGO = SPH.PH_PD AND SP9.D_E_L_E_T_ = ' ' AND SP9.P9_IDPON IN ('044A')
			WHERE SPH.D_E_L_E_T_ = ' '
				%exp:cFiltroSPH% 
				AND PH_MAT = %exp:(cAliasQry)->RA_MAT% 
				AND PH_FILIAL = %exp:(cAliasQry)->RA_FILIAL% 
		ORDER BY PC_FILIAL,PC_MAT,PC_CC,PC_DEPTO,PC_DATA
	EndSql
	
	aDet := {}
	While !(cAliasMarc)->( EoF() ) 
		nVal1 := 0
		nVal1 := Iif( Empty((cAliasMarc)->PC_PDI), (cAliasMarc)->PC_QUANTC, PC_QUANTI )
		If nTipo == 1 //Analitico
			nRet  := aScan( aDet, { |x| x[1] == (cAliasMarc)->PC_DATA } )   
		Else
			nRet  := aScan( aDet, { |x| x[1] == (cAliasMarc)->PC_MAT } )   
		EndIf
		
		If nRet == 0
		    If nTipo == 1 //Analitico
		   		aAdd(aDet, { (cAliasMarc)->PC_DATA, nVal1 } )// se nao cria elemento
		   	Else
		   		aAdd(aDet, { (cAliasMarc)->PC_MAT, nVal1 } )// se nao cria elemento
		   	EndIf
		Else                                        
		    aDet[nRet, 2] := SomaHoras(aDet[nRet,2], nVal1)
		EndIf
		(cAliasMarc)->( dbSkip() ) 
	EndDo
	(cAliasMarc)->(dbCloseArea())
	
	For nI := 1 To Len(aDet)
		If nTipo == 1 //Analitico
			oSection:Cell("DATA"):SetValue( dToC( sToD(aDet[nI][1]) ) )
		EndIf		
		oSection:Cell("HORAS"):SetValue( Iif( nSexaCent == 2, fConvHr(aDet[nI][2], 'D'), aDet[nI][2] ) )
	
		oSection:PrintLine()
	Next nI
	(cAliasQry)->( dbSkip() ) 
EndDo

If Select(cAliasQry) > 0
	(cAliasQry)->(dbCloseArea())
EndIf

Return
