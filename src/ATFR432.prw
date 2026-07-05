/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "ATFR432.CH"
#INCLUDE "REPORT.CH"

#DEFINE POS_VLR_ORGINIAL	    1
#DEFINE POS_AMPLIACAO           2
#DEFINE POS_DEPR_FISCAL         3
#DEFINE POS_DEPR_INCENTIVADA    4
#DEFINE POS_DEPR_GERENCIAL      5
#DEFINE POS_CORREC_BEM          6
#DEFINE POS_CORREC_DEPR         7
#DEFINE POS_BAIXAS              8
#DEFINE POS_QUANTD              9
#DEFINE POS_VENDA               10  

Static __cChave := ""
Static __aSaldo := {} 

STATIC lIsRussia	:= If(cPaisLoc$"RUS",.T.,.F.) // CAZARINI - Flag to indicate if is Russia location

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATFR432     บAutor  ณAlvaro Camillo Netoบ Dataณ  14/12/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Demonstrativo: Provisใo e realizado da deprecia็ใo         บฑฑ
ฑฑบ          ณ acumulada de projeto de imobilizado                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ATFR432()

Local oReport

Private cPerg   := "AFR432"
Private aSelFil	:= {}  
Private aSelClass := {}

__cChave := ""
__aSaldo := {}

lRet := Pergunte( cPerg , .T. )

If lRet
	If mv_par08 == 1 .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Return
		EndIf
	EndIf
	If mv_par11 == 1 .And. FindFunction("AdmGetClass")
		aSelClass := AdmGetClass(,.T.)	 
		If Len( aSelClass ) <= 0
			Return
		EndIf 		
	EndIf
	
	oReport:= ReportDef()
	oReport:PrintDialog()
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณAlvaro Camillo Neto บ Data ณ  14/12/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDefini็ใo do Relatorio                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR432                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

Local oReport	:= nil
Local oFNB   	:= nil
Local oFNC		:= nil
Local oFNE		:= nil
Local cDesc		:= STR0003 //"Este relat๓rio tem o objetivo de demonstrar o valor de aquisi็ใo e deprecia็ใo dos ativos relacionados aos projetos do imobilizado "
Local cTitulo	:= STR0004 //"Demonstrativo de deprecia็ใo de Projeto de Imobilizado"
Local cAliasPrj := GetNextAlias()
Local lTotalPrj	:= .F.
Local lTotalFil	:= .F.
Local cTypes10	:= IIF(lIsRussia,"|" + AtfNValMod({1}, "|"),"") // CAZARINI - 30/03/2017 - If is Russia, add new valuations models - main models

Pergunte(cPerg,.F.)

lTotalPrj	:= MV_PAR09 == 1
lTotalFil	:= MV_PAR10 == 1
cTipo	 	:= IIF(MV_PAR06 == 1 , "01" , "10" + cTypes10)

DEFINE REPORT oReport NAME "ATFR432" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport,cPerg,cAliasPrj)} DESCRIPTION cDesc TOTAL IN COLUMN

oReport:SetLandScape()
oReport:ParamReadOnly()
oReport:DisableOrientation()

DEFINE SECTION oFNB OF oReport TITLE STR0005 TABLES "FNB" //"Projeto do Imobilizado"
	DEFINE CELL NAME "FNB_FILIAL" OF oFNB ALIAS "FNB"
	DEFINE CELL NAME "FNB_CODPRJ" OF oFNB ALIAS "FNB"
	DEFINE CELL NAME "FNB_REVIS"  OF oFNB ALIAS "FNB"
	DEFINE CELL NAME "FNB_DESC"   OF oFNB ALIAS "FNB"
	DEFINE CELL NAME "FNB_DTREV"  OF oFNB ALIAS "FNB"
	DEFINE CELL NAME "FNB_DTENCR"  OF oFNB ALIAS "FNB"

	DEFINE SECTION oFNC OF oFNB TITLE STR0006 TABLES "FNC","FND","FNE" //"Etapa do Projeto"
   		DEFINE CELL NAME "FND_ETAPA"  OF oFNC ALIAS "FND"
   		DEFINE CELL NAME "FND_ITEM"   OF oFNC ALIAS "FND"
   		DEFINE CELL NAME "MESANO"     OF oFNC TITLE STR0010  SIZE 8  BLOCK {|| cValtoChar(Month(MV_PAR01)) + "/" + cValtoChar(Year(MV_PAR01))  } //"M๊s/Ano" 
 	 	DEFINE CELL NAME "FNE_TPDEPR" OF oFNC ALIAS "FNE" AUTO SIZE
		DEFINE CELL NAME 'FNE_PERDEP' OF oFNC ALIAS "FNE" AUTO SIZE
		DEFINE CELL NAME 'FNE_TAXA'   OF oFNC ALIAS "FNE" AUTO SIZE
		DEFINE CELL NAME 'FNE_CODIND' OF oFNC ALIAS "FNE" AUTO SIZE 
   		DEFINE CELL NAME "FNE_VORIG"  OF oFNC ALIAS "FNE" TITLE STR0014 AUTO SIZE BLOCK {|| U_AFR432SLD( (cAliasPrj)->FNB_FILIAL, (cAliasPrj)->FNB_CODPRJ,(cAliasPrj)->FNB_REVIS,(cAliasPrj)->FND_ETAPA,(cAliasPrj)->FND_ITEM,(cAliasPrj)->FNE_TPATF,(cAliasPrj)->FNE_TPSALD, MV_PAR01 , 1 ,(cAliasPrj)->FNB_DTREV)  }//"Vlr Orig"
   		DEFINE CELL NAME "FNE_VRDACM" OF oFNC ALIAS "FNE" TITLE STR0015 AUTO SIZE BLOCK {|| U_AFR432SLD( (cAliasPrj)->FNB_FILIAL, (cAliasPrj)->FNB_CODPRJ,(cAliasPrj)->FNB_REVIS,(cAliasPrj)->FND_ETAPA,(cAliasPrj)->FND_ITEM,(cAliasPrj)->FNE_TPATF,(cAliasPrj)->FNE_TPSALD, MV_PAR01 , 2 ,(cAliasPrj)->FNB_DTREV)  }//"Dep Acm"
	    DEFINE CELL NAME "SALDODEPRF"  OF oFNC TITLE STR0007 SIZE TamSX3("FNE_VRDACM")[1] PICTURE PesqPict("FNE","FNE_VRDACM", TamSX3("FNE_VRDACM")[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN CENTER BLOCK {|| oFNC:Cell("FNE_VORIG"):GetValue(.T.) - oFNC:Cell("FNE_VRDACM"):GetValue(.T.)   } //"Saldo"
        
        If '10' $ cTipo
	   		DEFINE CELL NAME "VORIGAVP"  OF oFNC TITLE STR0011 SIZE TamSX3("FNE_VORIG")[1] PICTURE PesqPict("FNE","FNE_VORIG", TamSX3("FNE_VORIG")[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN CENTER BLOCK {|| U_AFR432SLD( (cAliasPrj)->FNB_FILIAL, (cAliasPrj)->FNB_CODPRJ,(cAliasPrj)->FNB_REVIS,(cAliasPrj)->FND_ETAPA,(cAliasPrj)->FND_ITEM,(cAliasPrj)->FNE_TPATF,(cAliasPrj)->FNE_TPSALD, MV_PAR01 , 3  ,(cAliasPrj)->FNB_DTREV) } //"Vlr Ori AVP"
	   		DEFINE CELL NAME "VRDACMAVP" OF oFNC TITLE STR0012 SIZE TamSX3("FNE_VRDACM")[1] PICTURE PesqPict("FNE","FNE_VRDACM", TamSX3("FNE_VRDACM")[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN CENTER BLOCK {|| U_AFR432SLD( (cAliasPrj)->FNB_FILIAL, (cAliasPrj)->FNB_CODPRJ,(cAliasPrj)->FNB_REVIS,(cAliasPrj)->FND_ETAPA,(cAliasPrj)->FND_ITEM,(cAliasPrj)->FNE_TPATF,(cAliasPrj)->FNE_TPSALD, MV_PAR01 , 4,(cAliasPrj)->FNB_DTREV  ) }//"Dep Acm AVP"
	   		DEFINE CELL NAME "SALDOPAVP" OF oFNC TITLE STR0007 SIZE TamSX3("FNE_VRDACM")[1] PICTURE PesqPict("FNE","FNE_VRDACM", TamSX3("FNE_VRDACM")[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN CENTER BLOCK {|| oFNC:Cell("VORIGAVP"):GetValue(.T.) - oFNC:Cell("VRDACMAVP"):GetValue(.T.) } //"Saldo"

			DEFINE CELL NAME "SOMAVORIGAVP"  OF oFNC TITLE STR0016 SIZE TamSX3("FNE_VORIG")[1] PICTURE PesqPict("FNE","FNE_VORIG", TamSX3("FNE_VORIG")[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN CENTER BLOCK {|| oFNC:Cell("FNE_VORIG"):GetValue(.T.) + oFNC:Cell("VORIGAVP"):GetValue(.T.)  } //"Total Orig"
	   		DEFINE CELL NAME "SOMAVRDACMAVP" OF oFNC TITLE STR0017 SIZE TamSX3("FNE_VRDACM")[1] PICTURE PesqPict("FNE","FNE_VRDACM", TamSX3("FNE_VRDACM")[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN CENTER BLOCK {|| oFNC:Cell("FNE_VRDACM"):GetValue(.T.) + oFNC:Cell("VRDACMAVP"):GetValue(.T.) }//"Total Dep"
	   		DEFINE CELL NAME "SOMASALDOPAVP" OF oFNC TITLE STR0018 SIZE TamSX3("FNE_VRDACM")[1] PICTURE PesqPict("FNE","FNE_VRDACM", TamSX3("FNE_VRDACM")[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN CENTER BLOCK {|| oFNC:Cell("SALDODEPRF"):GetValue(.T.) + oFNC:Cell("SALDOPAVP"):GetValue(.T.) } //"Saldo Total"
        
        EndIf
                
		DEFINE BREAK oBreakFil OF oReport WHEN oFNB:Cell("FNB_FILIAL") TITLE OemToAnsi(STR0008)// "Total Por Filial"  

		
        If lTotalPrj 
                                                       
	        DEFINE BREAK oBreakPrj OF oFNB WHEN oFNB:Cell("FNB_CODPRJ") TITLE OemToAnsi(STR0009)//"Total Projeto" 
			DEFINE FUNCTION oTPrjVorig FROM oFNC:Cell("FNE_VORIG")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION 
			DEFINE FUNCTION oTPrjDepAc FROM oFNC:Cell("FNE_VRDACM") FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
			DEFINE FUNCTION oTPrjSald  FROM oFNC:Cell("SALDODEPRF")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
			If '10' $ cTipo
				DEFINE FUNCTION oTPrjVAVP FROM oFNC:Cell("VORIGAVP")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION 
				DEFINE FUNCTION oTPrjDAVP FROM oFNC:Cell("VRDACMAVP") FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
				DEFINE FUNCTION oTPrjSAVP  FROM oFNC:Cell("SALDOPAVP")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
				
				DEFINE FUNCTION oTPrjVSOMA FROM oFNC:Cell("SOMAVORIGAVP")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION 
				DEFINE FUNCTION oTPrjDSOMA FROM oFNC:Cell("SOMAVRDACMAVP") FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
				DEFINE FUNCTION oTPrjSSOMA  FROM oFNC:Cell("SOMASALDOPAVP")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
			EndIf  
		EndIf
		
		If lTotalFil
			DEFINE FUNCTION oTFilVorig FROM oFNC:Cell("FNE_VORIG")  FUNCTION SUM BREAK oBreakFil NO END SECTION
			DEFINE FUNCTION oTFilDepAc FROM oFNC:Cell("FNE_VRDACM") FUNCTION SUM BREAK oBreakFil NO END SECTION
			DEFINE FUNCTION oTFilSald  FROM oFNC:Cell("SALDODEPRF") FUNCTION SUM BREAK oBreakFil NO END SECTION
			If '10' $ cTipo
				DEFINE FUNCTION oTFilVAVP FROM oFNC:Cell("VORIGAVP")   FUNCTION SUM BREAK oBreakFil NO END SECTION
				DEFINE FUNCTION oTFilDAVP FROM oFNC:Cell("VRDACMAVP")  FUNCTION SUM BREAK oBreakFil NO END SECTION
				DEFINE FUNCTION oTFilSAVP  FROM oFNC:Cell("SALDOPAVP") FUNCTION SUM BREAK oBreakFil NO END SECTION
				
				DEFINE FUNCTION oTFilVSOMA FROM oFNC:Cell("SOMAVORIGAVP")   FUNCTION SUM BREAK oBreakFil NO END SECTION
				DEFINE FUNCTION oTFilDSOMA FROM oFNC:Cell("SOMAVRDACMAVP")  FUNCTION SUM BREAK oBreakFil NO END SECTION
				DEFINE FUNCTION oTFilSSOMA  FROM oFNC:Cell("SOMASALDOPAVP") FUNCTION SUM BREAK oBreakFil NO END SECTION
			EndIf 
        EndIf    
           	
oFNB:SetHeaderPage(.T.)   			   		
oFNC:SetHeaderPage(.T.)   			   		
oFNB:SetAutoSize()
oFNC:SetAutoSize()

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrintReportบAutor  ณAlvaro Camillo Neto บ Data ณ  14/12/11  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina de Impressใo de dados                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintReport(oReport,cPerg,cAliasPrj)
Local oFNB     := oReport:Section(1)
Local oFNC     := oReport:Section(1):Section(1)
Local dDataRef := cTod("")
Local cProjDe  := ""
Local cProjAte := ""
Local lRevAtv  := .F.
Local cRevis   := ""
Local cTipo	   := ""
Local cTpSLD   := ""
Local cCondRev := ""
Local cCondFil := ""  
Local lFilClass:= (MV_PAR11 == 1 .And. Len(aSelClass) > 0 .And. FindFunction("FormatClass") .And. FindFunction("ClasSn1Fnb"))
Local cTmpFil
Local cTypes10 := IIF(lIsRussia,"|" + AtfNValMod({1}, "|"),"") // CAZARINI - 30/03/2017 - If is Russia, add new valuations models - main models

Pergunte( cPerg , .F. )

dDataRef := MV_PAR01
cProjDe  := MV_PAR02
cProjAte := MV_PAR03
lRevAtv  := MV_PAR04 == 1
cRevis   := MV_PAR05
cTpSLD   := MV_PAR07
cTipo	 	:= IF(MV_PAR06 == 1 , "01" , "10" + cTypes10)
cTipo    	:= "% FNE_TPATF IN " + FormatIn( cTipo, "|" ) + "%"

If lRevAtv
	cCondRev := " ((FNB_STATUS = '1') OR (FNB_STATUS = '2' AND FNB_DTENCR > '"+DTOS(dDataRef)+"')) "
Else 
	cCondRev := " FNB_REVIS = '"+cRevis+"' "
EndIf   

//Filtra Classifica็๕es patrimoniais
If lFilClass 
	cCondRev += "AND  FND_SBTIPO IN " + FormatClass(ClasSn1Fnb(aSelClass), .T.)
EndIf

cCondFil := "FNB_FILIAL " + GetRngFil( aSelfil , "FNB", .T., @cTmpFil )

cCondRev   := "%" + cCondRev + "%" 
cCondFil   := "%" + cCondFil + "%" 

BEGIN REPORT QUERY oFNB

BeginSql alias cAliasPrj
	SELECT 
	    FNB_FILIAL  ,
	    FNB_CODPRJ  ,
	    FNB_REVIS   ,
		FNB_DESC	,
		FNB_DTREV	,
		FNB_DTENCR	,
	    FNC_FILIAL  ,
	    FNC_CODPRJ  ,
	    FNC_REVIS   ,
		FND_ETAPA	,
		FND_ITEM	,
	    FNE_TPDEPR	,
	    FNE_VORIG	,
	    FNE_VRDACM	,               
		FNE_PERDEP	,
		FNE_TAXA	,	
		FNE_VLMXDP	,
		FNE_VLSALV	,
		FNE_PRDEST	,
		FND_DTPROV	,
		FNE_CODIND	,
		FNE_TPATF   ,
		FNE_TPSALD  ,
		FNB_DTREV   ,
		FNB_DTENCR
		
	FROM %table:FNB% FNB INNER JOIN %table:FNC% FNC  ON
	    FNB_FILIAL = FNC_FILIAL AND
	    FNB_CODPRJ = FNC_CODPRJ AND
	    FNB_REVIS  = FNC_REVIS
	
	    INNER JOIN %table:FND% FND  ON
	    FNC_FILIAL = FND_FILIAL AND
	    FNC_CODPRJ = FND_CODPRJ AND
	    FNC_REVIS  = FND_REVIS  AND
	    FNC_ETAPA  = FND_ETAPA 
	 
	    INNER JOIN %table:FNE% FNE  ON
	    FND_FILIAL = FNE_FILIAL AND
	    FND_CODPRJ = FNE_CODPRJ AND
	    FND_REVIS  = FNE_REVIS  AND
	    FND_ETAPA  = FNE_ETAPA  AND 
	    FND_ITEM   = FNE_ITEM 
	
	WHERE
	   
       FNB_DTINIC <= %exp:dDataRef%  AND
		FNB_CODPRJ >= %exp:cProjDe%  AND
		FNB_CODPRJ <= %exp:cProjAte% AND
		%exp:cCondRev%               AND
		%exp:cCondFil%               AND
		%exp:cTipo%                  AND
		FNE_TPSALD = %exp:cTpSLD%    AND
 		FNB.%notDel% AND
		FNC.%notDel% AND
		FND.%notDel% AND
		FNE.%notDel% 
		
	ORDER BY FNB_FILIAL,FNB_CODPRJ,FNB_REVIS

EndSql

END REPORT QUERY oFNB 

oFNC:SetParentQuery()
oFNC:SetParentFilter({|cParam| (cAliasPrj)->(FNC_FILIAL+FNC_CODPRJ+FNC_REVIS) == cParam},{|| (cAliasPrj)->(FNB_FILIAL+FNB_CODPRJ+FNB_REVIS) })
CtbTmpErase(cTmpFil)
oFNB:Print()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAFR432SLD บAutor  ณAlvaro Camillo Neto บ Data ณ  16/12/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina que retorna o valor original e depreciacao do Ativo บฑฑ
ฑฑบ          ณ nTipoVal == 1 - Valor Original                             บฑฑ
ฑฑบ          ณ nTipoVal == 2 - Depreciacao                                บฑฑ
ฑฑบ          ณ nTipoVal == 3 - Valor de AVP                             บฑฑ
ฑฑบ          ณ nTipoVal == 4 - Deprec ACM AVP                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AFR432SLD(cXFil ,cCodPrj, cRevis, cEtapa ,cItemPrj,cTipoAtf,cTipoSld, dDataRef , nTipoVal , dDataRev  )
Local nRetValor   := 0
Local aArea       := GetArea()
Local aAreaSN1    := SN1->(GetArea())
Local cTipoFiscal := ""
Local aAux        := {}

SN1->(dbSetOrder(9)) //N1_FILIAL+N1_PROJETO+N1_PROJREV+N1_PROJETP+N1_PROJITE+N1_CBASE+N1_ITEM

If __cChave != cXFil + cCodPrj + cRevis + cEtapa + cItemPrj + cTipoAtf + cTipoSld
	
	cTipoFiscal := ATFXTpBem(1)
	__aSaldo    := Array(4)
	aFill(__aSaldo,0)
	
	__cChave    := cXFil + cCodPrj + cRevis + cEtapa + cItemPrj + cTipoAtf + cTipoSld
	
	If SN1->(MSSeek( cXFil + cCodPrj + cRevis + cEtapa + cItemPrj )) .And. dDataRev <= dDataRef 
		aAux := AFR432Mov(cXFil,SN1->N1_CBASE,SN1->N1_ITEM,cTipoAtf,cTipoSld,dDataRef)
		__aSaldo[1] := aAux[1]
		__aSaldo[2] := aAux[2]
		
		If !(cTipoAtf $ cTipoFiscal) // Se o bem for gerencial busca a informa็ใo do tipo 14   
			aAux := AFR432Mov(cXFil,SN1->N1_CBASE,SN1->N1_ITEM,"14",cTipoSld,dDataRef)
			__aSaldo[3] := aAux[1]
			__aSaldo[4] := aAux[2]
		EndIf
	EndIf
EndIf

__aSaldo := IIF(Empty(__aSaldo),{0,0,0,0},__aSaldo)

nRetValor := __aSaldo[nTipoVal]

RestArea(aAreaSN1)
RestArea(aArea)
Return nRetValor


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAFR432MovบAutor  ณAlvaro Camillo Neto บ Data ณ  12/19/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o valor original e a depreciacao acumulada de um    บฑฑ
ฑฑบ          ณbem atrelado a um projeto                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AFR432Mov(cXFil,cBase,cItem,cTipoAtf,cTipoSld,dDataRef)
Local aRet        := {0,0}
Local aArea       := GetArea()
Local cQuery      := ""
Local cAliasTrb   := ""
Local cFilBem     := ""
Local cCodBase    := ""
Local cTipo       := ""
Local cSeq        := ""
Local cSeqReav    := ""
Local nDeprec	  := 0
Local nVOrig	  := 0
Local aSldAux	  := {}
Local cTipoFiscal := ATFXTpBem(1) 
Local cItemN3     := ""

cQuery	+= "	SELECT	"
cQuery	+= "		N3_FILIAL,	"
cQuery	+= "		N3_CBASE,	"
cQuery	+= "		N3_ITEM,	"
cQuery	+= "		N3_TIPO,	"
cQuery	+= "		N3_SEQREAV,	"
cQuery	+= "		N3_SEQ  	"
cQuery	+= "	FROM " + RetSqlTab("SN3")
cQuery	+= "	WHERE	"
cQuery	+= "		SN3.D_E_L_E_T_ = ''	"
cQuery	+= "		AND SN3.N3_FILIAL 	= '" + cXFil + "'"
cQuery	+= "		AND SN3.N3_CBASE	= '" + cBase + "'"
cQuery	+= "		AND SN3.N3_ITEM		= '" + cItem  + "'"
cQuery	+= "		AND SN3.N3_TIPO		= '" + cTipoAtf  + "'"
cQuery	+= "		AND SN3.N3_TPSALDO	= '" + cTipoSld  + "'"

//Executa a query
cAliasTrb := GetNextAlias()
cQuery := ChangeQuery(cQuery )
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTrb , .T. , .F.)
(cAliasTrb)->(dbGoTop())


//Verifica se retornou algum registro e armazena na variแvel
If (cAliasTrb)->(!EOF())
	cFilBem := (cAliasTrb)->N3_FILIAL
	cCodBase:= (cAliasTrb)->N3_CBASE
	cItemN3   := (cAliasTrb)->N3_ITEM
	cTipo   := (cAliasTrb)->N3_TIPO
	cSeq    := (cAliasTrb)->N3_SEQ
	cSeqReav:= (cAliasTrb)->N3_SEQREAV
	
	aSldAux := SaldoSN4( cFilBem,cCodBase,cItem,cTipo,cSeq,cSeqReav,,dDataRef,,,cTipoSld)
	
	If Len(aSldAux) > 0
		nVOrig	:= aSldAux[1][2][POS_VLR_ORGINIAL]
		If (cAliasTrb)->N3_TIPO $ cTipoFiscal
			nDeprec	:= aSldAux[1][2][POS_DEPR_FISCAL]
		Else
			nDeprec	:= aSldAux[1][2][POS_DEPR_GERENCIAL]
		EndIf
    EndIf
	aRet[1] := nVOrig
	aRet[2] := nDeprec
EndIf

RestArea(aArea)
Return aRet
