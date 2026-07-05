/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "ATFR431.CH"
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

STATIC lIsRussia	:= If(cPaisLoc$"RUS",.T.,.F.) // CAZARINI - Flag to indicate if is Russia location

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATFR431     บAutor  ณAlvaro Camillo Netoบ Dataณ  14/12/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Demonstrativo de deprecia็ใo de projeto 12 meses           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ATFR431()
Local oReport

Private cPerg   := "AFR431"
Private aSelFil	:= {} 
Private aPeriodo:= {}

__cChave := ""
__aSaldo := {}

lRet := Pergunte( cPerg , .T. )

If lRet
	If mv_par09 == 1 .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Return
		EndIf
	EndIf
	
	If !VldTpSald( MV_PAR08, .T. )
		Return
	EndIf
	
	If MV_PAR01 != FirstDay(MV_PAR01) .Or. MV_PAR02 != LastDay(MV_PAR02)
		Help("  ",1,"AFR431DT",,STR0003,1,0)//"A data inicial deve ser o primeiro dia de um m๊s e a data final deve ser o ultimo dia de um m๊s"
		Return
	Else
		aPeriodo := AFXPeriodo(MV_PAR01,MV_PAR02) 
		If Len(aPeriodo) < 2 .Or. Len(aPeriodo)  > 12
			Help("  ",1,"AFR431PER",,STR0004,1,0)//"O intervalo mํnimo de datas sใo 2 meses e o perํodo mแximo 12 meses "
			Return
		EndIf
	EndIf
	
	oReport := ReportDef()
	oReport:PrintDialog()	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณAlvaro Camillo Neto บ Data ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Defini็ใo de layout do relat๓rio analํtico                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
Local cReport  := "ATFR431"
Local cTitulo  := STR0005
Local cDescri  := STR0006 
Local aOrd	   := {}
Local cCpoAux  := ""
Local cDescAux := ""
Local cMesAux  := ""
Local nPeriodo := 0
Local cAliasPrj := GetNextAlias()
Local lTotalPrj	:= .F.
Local lTotalFil	:= .F.
Local oReport	:= nil
Local oFNB   	:= nil
Local oFNC		:= nil

Pergunte(cPerg,.F.)

lTotalPrj	:= MV_PAR10 == 1
lTotalFil	:= MV_PAR11 == 1

DEFINE REPORT oReport NAME cReport TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport,cPerg,cAliasPrj)} DESCRIPTION cDescri TOTAL IN COLUMN

oReport:SetLandScape()
oReport:ParamReadOnly()
oReport:DisableOrientation()

DEFINE SECTION oFNB OF oReport TITLE STR0007 TABLES "FNB" //"Projeto do Imobilizado" 
	DEFINE CELL NAME "FNB_FILIAL" OF oFNB ALIAS "FNB" SIZE TamSX3("FNB_FILIAL")[1]
	DEFINE CELL NAME "FNB_CODPRJ" OF oFNB ALIAS "FNB" SIZE TamSX3("FNB_CODPRJ")[1] 
	DEFINE CELL NAME "FNB_REVIS"  OF oFNB ALIAS "FNB" SIZE TamSX3("FNB_REVIS")[1]
	DEFINE CELL NAME "FNB_DESC"   OF oFNB ALIAS "FNB" SIZE TamSX3("FNB_DESC")[1]
	DEFINE CELL NAME "FNB_DTREV"  OF oFNB ALIAS "FNB" SIZE TamSX3("FNB_DTREV")[1]
	DEFINE CELL NAME "FNB_DTENCR"  OF oFNB ALIAS "FNB" SIZE TamSX3("FNB_DTENCR")[1]

	DEFINE SECTION oFNC OF oFNB TITLE STR0008 TABLES "FNC","FND","FNE" //"Etapa do Projeto"
   		DEFINE CELL NAME "FND_ETAPA"  OF oFNC ALIAS "FND" SIZE TamSX3("FND_ETAPA")[1]
   		DEFINE CELL NAME "FND_ITEM"   OF oFNC ALIAS "FND" SIZE TamSX3("FND_ITEM")[1]
   		DEFINE CELL NAME "FND_DSCITE"   OF oFNC ALIAS "FND" SIZE TamSX3("FND_DSCITE")[1]
       
		//Cria็ใo dos campos de perํodo
		For nPeriodo := 1 to Len(aPeriodo)
			dDataIni := aPeriodo[nPeriodo][1] 
			dDataFim := aPeriodo[nPeriodo][2]
			cCpoAux  := "VLPER" + STRZERO(nPeriodo,2)
			cMesAux  := Alltrim( MesExtenso( Month(aPeriodo[nPeriodo][2]) ) )
			cDescAux := Alltrim( Left(cMesAux,3) + "/"+cValToChar(Year(aPeriodo[nPeriodo][2])) )
			cBloco   := "{|| U_AFR431Per((cAliasPrj)->FNB_FILIAL, (cAliasPrj)->FNB_CODPRJ,(cAliasPrj)->FNB_REVIS,(cAliasPrj)->FND_ETAPA,(cAliasPrj)->FND_ITEM,"+cValtoChar(nPeriodo)+","+cValtoChar(MV_PAR07)+",'"+MV_PAR08+"' )   }" 
			bBlock   := &(cBloco)
			DEFINE CELL NAME cCpoAux OF oFNC TITLE cDescAux SIZE TamSX3("FNE_VRDACM")[1] PICTURE PesqPict("FNE","FNE_VRDACM", TamSX3("FNE_VRDACM")[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK bBlock
		Next nX        

	    DEFINE CELL NAME "SALDOTOT"   OF oFNC TITLE STR0009 SIZE TamSX3("FNE_VRDACM")[1] PICTURE PesqPict("FNE","FNE_VRDACM", TamSX3("FNE_VRDACM")[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| U_AF431SAL(oFNC)   } //"Total"
                       
		DEFINE BREAK oBreakFil OF oReport WHEN oFNB:Cell("FNB_FILIAL") TITLE OemToAnsi(STR0010  ) //"Total Por Filial"
		
        If lTotalPrj 
                                                       
	        DEFINE BREAK oBreakPrj OF oFNB WHEN oFNB:Cell("FNB_CODPRJ") TITLE OemToAnsi(STR0011) //"Total Projeto"
			//Cria็ใo dos campos de perํodo
			For nPeriodo := 1 to Len(aPeriodo)
				cCpoAux  := "VLPER" + STRZERO(nPeriodo,2)
				DEFINE FUNCTION oTPrj1 FROM oFNC:Cell(cCpoAux)  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION 
			Next nX
			
			DEFINE FUNCTION oTPrj1 FROM oFNC:Cell("SALDOTOT")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION           
		EndIf
		
		If lTotalFil
			For nPeriodo := 1 to Len(aPeriodo)
				cCpoAux  := "VLPER" + STRZERO(nPeriodo,2)
				DEFINE FUNCTION oTFil FROM oFNC:Cell(cCpoAux)  FUNCTION SUM BREAK oBreakFil NO END REPORT NO END SECTION 
			Next nX                                                                                                     
			
			DEFINE FUNCTION oTFil FROM oFNC:Cell("SALDOTOT")  FUNCTION SUM BREAK oBreakFil NO END REPORT NO END SECTION 
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
Local cTypes10 := IIF(lIsRussia,"|" + AtfNValMod({1}, "|"),"") // CAZARINI - 30/03/2017 - If is Russia, add new valuations models - main models

Pergunte( cPerg , .F. )

cProjDe  := MV_PAR03
cProjAte := MV_PAR04
lRevAtv  := MV_PAR05 == 1
cRevis   := MV_PAR06
cTipo	 := IIF(MV_PAR07 == 1 , "01" , "10" + cTypes10)
cTipo    := "FNE_TPATF IN " + FormatIn( cTipo, "|" )
cTpSLD   := MV_PAR08

If lRevAtv
	cCondRev := " ((FNB_STATUS = '1') OR (FNB_STATUS = '2' AND FNB_DTENCR > '"+DTOS(MV_PAR01)+"')) 
Else 
	cCondRev := " FNB_REVIS = '"+cRevis+"' "
EndIf

cCondFil := "FNB_FILIAL " + GetRngFil( aSelfil , "FNB" )

cCondRev   := "%" + cCondRev + "%" 
cCondFil   := "%" + cCondFil + "%" 
cTipo      := "%" + cTipo + "%"

BEGIN REPORT QUERY oFNB

BeginSql alias cAliasPrj
	SELECT 
	    	FNB_FILIAL  ,
			FNB_CODPRJ  ,
			FNB_REVIS   ,
			FNB_DESC    ,
			FNB_DTREV   ,
			FNB_DTENCR  ,
	    	FNC_FILIAL  ,
	    	FNC_CODPRJ  ,
	    	FNC_REVIS   ,
			FND_ETAPA	,
			FND_ITEM	,
			FNE_TPATF   ,
			FNE_TPSALD  ,
			FND_ETAPA	,
			FND_ITEM	,
			FND_DSCITE

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

oFNB:Print()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAF431SAL   บAutor  ณAlvaro Camillo Neto บ Data ณ  05/28/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a soma das colunas                                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AF431SAL(oFNC)

Local nRet     := 0
Local nPeriodo := 0
Local cCpoAux  := ""

For nPeriodo := 1 to Len(aPeriodo)
	cCpoAux  := "VLPER" + STRZERO(nPeriodo,2)
	nRet     += oFNC:Cell(cCpoAux):GetValue(.T.) 
Next nX  

Return nRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAFR431Per บAutor  ณMicrosiga           บ Data ณ  05/28/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o valor da deprecia็ใo do periodo                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AFR431Per(cFilX , cCodPrj,cRevis,cEtapa,cItemPrj ,nPeriodo,nTipoAtf,cTipoSld)

Local nDeprec := 0
Local dDataIni := STOD("")  
Local dDataFim := STOD("")
Local aArea       := GetArea()
Local aAreaSN1    := SN1->(GetArea())
Local cTypes10    := IIF(lIsRussia,"|" + AtfNValMod({1}, "|"),"") // CAZARINI - 30/03/2017 - If is Russia, add new valuations models - main models
Local cTipoAtf    := IIF(nTipoAtf == 1 ,"01","10" + cTypes10)
Local cTipoFiscal := ATFXTpBem(1)
Local lGerencial  := .F.
Local nX          := 0
Local aTipoAtf    := {}

dDataIni := IIF(nPeriodo != 1 , aPeriodo[nPeriodo][1], Nil )
dDataFim := aPeriodo[nPeriodo][2]

SN1->(dbSetOrder(9)) //N1_FILIAL+N1_PROJETO+N1_PROJREV+N1_PROJETP+N1_PROJITE+N1_CBASE+N1_ITEM

If SN1->(MSSeek( cFilX + cCodPrj + cRevis + cEtapa + cItemPrj )) 
	nDeprec := AFR431Mov(cFilX, SN1->N1_CBASE,SN1->N1_ITEM,cTipoAtf,cTipoSld,dDataIni,dDataFim)
		
	aTipoAtf := Separa(cTipoAtf, "|", .f.) 
	For nX := 1 to len( aTipoAtf )	
		If !(aTipoAtf[nX] $ cTipoFiscal) // Se o bem for gerencial busca a informa็ใo do tipo 14
			lGerencial := .t.
			Exit
		Endif
	Next nX
	   
	If lGerencial // Se o bem for gerencial busca a informa็ใo do tipo 14
		nDeprec += AFR431Mov(cFilX, SN1->N1_CBASE,SN1->N1_ITEM,"14",cTipoSld,dDataIni,dDataFim)
	EndIf
EndIf

RestArea(aAreaSN1)
RestArea(aArea)

Return nDeprec

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
Static Function AFR431Mov(cFilX, cBase,cItem,cTipoAtf,cTipoSld,dDataIni,dDataFim)

Local aArea       := GetArea()
Local cQuery      := ""
Local cAliasTrb   := ""
Local cFilBem     := ""
Local cCodBase    := ""
Local cTipo       := ""
Local cSeq        := ""
Local cSeqReav    := ""
Local nDeprec	  := 0
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
cQuery	+= "		AND SN3.N3_FILIAL 	= '" + cFilX + "'"
cQuery	+= "		AND SN3.N3_CBASE	= '" + cBase + "'"
cQuery	+= "		AND SN3.N3_ITEM		= '" + cItem  + "'"
cQuery	+= "		AND SN3.N3_TIPO		IN " + FormatIn( cTipoAtf, "|" ) 
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
	cItemN3 := (cAliasTrb)->N3_ITEM
	cTipo   := (cAliasTrb)->N3_TIPO
	cSeq    := (cAliasTrb)->N3_SEQ
	cSeqReav:= (cAliasTrb)->N3_SEQREAV
	
	aSldAux := SaldoSN4( cFilBem,cCodBase,cItem,cTipo,cSeq,cSeqReav,,dDataFim,,dDataIni,cTipoSld)
	           
	If Len(aSldAux) > 0
		If (cAliasTrb)->N3_TIPO $ cTipoFiscal
			nDeprec	:= aSldAux[1][2][POS_DEPR_FISCAL]
		Else
			nDeprec	:= aSldAux[1][2][POS_DEPR_GERENCIAL]
		EndIf
	EndIf
	
EndIf

RestArea(aArea)  

Return nDeprec