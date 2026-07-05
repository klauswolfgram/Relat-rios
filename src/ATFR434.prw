/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "ATFR434.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATFR434	บAutor  ณRodrigo Gimenes     บ Data ณ  03/08/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Demonstrativo de realiza็ใo de projeto imobilizado         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ATFR434()
Local oReport
Local lTReport	:= FindFunction("TRepInUse") .And. TRepInUse()
Local lDefTop 	:= IIF( FindFunction("IfDefTopCTB"), IfDefTopCTB(), .F.) // verificar se pode executar query (TOPCONN)

Private cPerg   := "AFR434"
Private aSelFil	:= {} 
Private aPeriodo:= {}


__cChave := ""
__aSaldo := {}

If !lDefTop
	Help("  ",1,"AFR434TOP",,STR0001 ,1,0) //"Fun็ใo disponํvel apenas para ambientes TopConnect"
	Return
EndIf

If !lTReport
	Help("  ",1,"AFR434R4",,STR0002,1,0) //"Fun็ใo disponํvel apenas para TReport, por favor atualizar ambiente e verificar parametro MV_TREPORT"
	Return
ENdIf

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
	
	If MV_PAR05 > MV_PAR06 
		Help("  ",1,"AFR434DT",,STR0003,1,0)//"A data inicial deve ser menor que a data final"
		Return
	Else
		aPeriodo := AFXPeriodo(MV_PAR05,MV_PAR06) 
	EndIf
	
	oReport := ReportDef()
	oReport:PrintDialog()	
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณRodrigo Gimenes     บ Data ณ  03/08/12   บฑฑ
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
Local cReport  := "ATFR434"
Local cTitulo  := STR0004
Local cDescri  := STR0005 
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
Local oFNE		:= nil
Local oFNJ		:= nil
Local oEtp1		:= nil
Local oBreakEtp	:= nil
Local oTEtp1	:= Nil 
Local oTPrj1	:= Nil  


Pergunte(cPerg,.F.)

lTotalPrj	:= MV_PAR10 == 1
lTotalFil	:= MV_PAR11 == 1

DEFINE REPORT oReport NAME cReport TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport,cPerg,cAliasPrj)} DESCRIPTION cDescri TOTAL IN COLUMN

oReport:SetLandScape()
oReport:ParamReadOnly()
oReport:DisableOrientation()       




DEFINE SECTION oFNB OF oReport TITLE STR0006 TABLES "FNB","FNE" //"Projeto do Imobilizado"

	DEFINE CELL NAME "FNB_FILIAL" OF oFNB ALIAS "FNB"   //Filial
	DEFINE CELL NAME "FNB_CODPRJ" OF oFNB ALIAS "FNB"   //C๓digo
	DEFINE CELL NAME "FNB_REVIS"  OF oFNB ALIAS "FNB"   //Revisใo
	DEFINE CELL NAME "FNB_DESC"   OF oFNB ALIAS "FNB"  	//Descri็ใo   
 	


	DEFINE SECTION oFNE OF oFNB TITLE STR0007 TABLES "FND","FNE" //"Etapa do Projeto" 
   		DEFINE CELL NAME "FNE_ETAPA"  	OF oFNE ALIAS "FNE"   		//Etapa
 		DEFINE CELL NAME "FNE_ITEM"   	OF oFNE ALIAS "FNE"    		//Item                        
 		DEFINE CELL NAME "FND_DSCITE"   OF oFNE ALIAS "FND"    		//Item                        
   		DEFINE CELL NAME "FND_TIPO" 	OF oFNE ALIAS "FND"    		//Tipo
   		DEFINE CELL NAME "FNE_TPSALD" 	OF oFNE ALIAS "FNE"    		//Tipo Saldo
   		DEFINE CELL NAME "FNE_ENT01B" 	OF oFNE ALIAS "FNE"     	//Entidade 1
   		DEFINE CELL NAME "FNE_ENT02B" 	OF oFNE ALIAS "FNE"     	//Entidade 2
   		DEFINE CELL NAME "FNE_ENT03B" 	OF oFNE ALIAS "FNE"     	//Entidade 3
   		DEFINE CELL NAME "FNE_ENT04B" 	OF oFNE ALIAS "FNE"     	//Entidade 4
		DEFINE CELL NAME "FNE_VORIG" 	OF oFNE ALIAS "FNE"    		//Valor Original
		DEFINE CELL NAME "FNE_VLRRLZ" 	OF oFNE TITLE "" ALIAS "FNE"    		//Valor Realizado 
		DEFINE CELL NAME "TOTVLRRLZ"  	OF oFNE TITLE STR0013 SIZE TamSX3("FNE_VLRRLZ")[1] PICTURE PesqPict("FNE","FNE_VLRRLZ", TamSX3("FNE_VLRRLZ")[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN CENTER BLOCK {||oFNE:Cell("FNE_VORIG"):GetValue(.T.)-oFNE:Cell("FNE_VLRRLZ"):GetValue(.T.) }		
        oFNE:Cell("FNE_VLRRLZ"):Hide()

 	DEFINE SECTION oFNJ OF oFNE TITLE STR0008 TABLES "FNJ","SN1" //"Execu็๕es do Projeto"  

   		DEFINE CELL NAME "FNJ_CBAEXE"  	OF oFNJ ALIAS "FNJ"   				//C๓digo da Execu็ใo
   		DEFINE CELL NAME "FNJ_ITEXE"  	OF oFNJ ALIAS "FNJ"    				//Item
   		DEFINE CELL NAME "FNJ_TAFEXE" 	OF oFNJ ALIAS "FNJ"    				//Tipo
   		DEFINE CELL NAME "FNJ_SLDEXE" 	OF oFNJ ALIAS "FNJ"    				//Tipo Saldo
   		DEFINE CELL NAME "N1_FORNEC" 	OF oFNJ ALIAS "SN1"    				//Fornecedor
   		DEFINE CELL NAME "N1_LOJA" 		OF oFNJ ALIAS "SN1"    				//Loja
   		DEFINE CELL NAME "N1_NFISCAL" 	OF oFNJ ALIAS "SN1"    				//Nota Fiscal
   		DEFINE CELL NAME "N1_NSERIE" 	OF oFNJ ALIAS "SN1"    				//S้rie
		DEFINE CELL NAME "FNJ_VLREXE" 	OF oFNJ TITLE STR0014 ALIAS "FNJ"   //Valor Realizado
   		DEFINE CELL NAME "FNJ_DTCONT" 	OF oFNJ ALIAS "FNJ"    				//Dt. Contabiliza็ใo

   			  

   			
		DEFINE BREAK oBreakEtp OF oReport WHEN {|| oFNB:Cell("FNB_CODPRJ"):GetText()+oFNE:Cell("FNE_ETAPA"):GetText()}     TITLE OemToAnsi(STR0012) //"Total da Etapa" 
		DEFINE FUNCTION oTEtp1 FROM oFNE:Cell("TOTVLRRLZ")  FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION 
		DEFINE FUNCTION oTEtp2 FROM oFNJ:Cell("FNJ_VLREXE")  FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION 
		
		DEFINE BREAK oBreakPrj OF oReport WHEN oFNB:Cell("FNB_CODPRJ") TITLE OemToAnsi(STR0011) //"Total do Projeto"
		DEFINE BREAK oBreakFil OF oReport WHEN oFNB:Cell("FNB_FILIAL") TITLE OemToAnsi(STR0010  ) //"Total da Filial"
		oFNB:SetLineCondition({|| oFNB:Cell("FNB_CODPRJ"):GetText() <> (cAliasPrj)->(FNE_CODPRJ)  })  

        If lTotalPrj
			DEFINE FUNCTION oTPrj1 FROM oFNE:Cell("TOTVLRRLZ")  FUNCTION SUM BREAK oBreakPrj  NO END REPORT NO END SECTION           
			DEFINE FUNCTION oTPrj2 FROM oFNJ:Cell("FNJ_VLREXE")  FUNCTION SUM BREAK oBreakPrj  NO END REPORT NO END SECTION           
			oBreakPrj:OnPrintTotal({||oReport:SkipLine(), oReport:SkipLine(),oReport:SkipLine()})
		EndIf
		                                                                                                                             
		If lTotalFil
			DEFINE FUNCTION oTFil1 FROM oFNE:Cell("TOTVLRRLZ")  FUNCTION SUM BREAK oBreakFil NO END REPORT NO END SECTION           
			DEFINE FUNCTION oTFil2 FROM oFNJ:Cell("FNJ_VLREXE")  FUNCTION SUM BREAK oBreakFil NO END REPORT NO END SECTION           
        EndIf    
           		
oFNB:SetAutoSize()
oFNE:SetAutoSize()
oFNJ:SetAutoSize()


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
Local oFNE     := oReport:Section(1):Section(1)
Local oFNJ     := oReport:Section(1):Section(1):Section(1)
Local dDataRef := cTod("")
Local cProjDe  := ""
Local cProjAte := ""
Local lRevAtv  := .F.
Local lFilCtb  := .F.

Local cRevis   := ""
Local cTipo	   := ""
Local cTpSLD   := ""
Local cCondRev := ""
Local cCondFil := "" 
Local cDataIni	:= ""
Local cDataFim	:= ""
Local cTmpFil

Pergunte( cPerg , .F. )


cProjDe		:= MV_PAR01
cProjAte	:= MV_PAR02
lRevAtv		:= MV_PAR03 == 1
cRevis		:= MV_PAR04
cDataIni	:= MV_PAR05
cDataFim	:= MV_PAR06
cTipo		:= If(MV_PAR07 == 1 , "01" , "10" )
cTpSLD		:= MV_PAR08
lFilCtb		:= MV_PAR12 <> 1

If lRevAtv
	cCondRev := " ((FNB_STATUS = '1') OR (FNB_STATUS = 'A') OR  (FNB_STATUS = '2' AND FNB_DTENCR > '"+DTOS(MV_PAR05)+"')) 
Else 
	cCondRev := " FNB_REVIS = '"+cRevis+"' "
EndIf

If lFilCtb  
	cCondRev += " AND FNJ_DTCONT <> ' ' "
EndIf

cCondFil := "FNB_FILIAL " + GetRngFil( aSelfil , "FNB", .T., @cTmpFil )

cCondRev   := "%" + cCondRev + "%" 
cCondFil   := "%" + cCondFil + "%" 

BEGIN REPORT QUERY oFNB

BeginSql alias cAliasPrj
	SELECT 
	    FNB_FILIAL	,
	    FNB_CODPRJ	,
	    FNB_REVIS	,
	    FNB_DESC	,
	    FND_FILIAL	,
	    FND_CODPRJ	,
	    FND_REVIS	,
		FND_ETAPA	,	    
		FND_DSCITE	,	    
	    FND_TIPO	,
   	    FND_VLRPLN	,
		FNE_FILIAL	,
	    FNE_CODPRJ	,
	    FNE_REVIS	,	     
	    FNE_ETAPA	,
	    FNE_LINHA   ,
	    FNE_TPATF	,
		FNE_TPSALD	,
   	    FNE_ITEM	,
   		FNE_TPSALD	,
   		FNE_ENT01B	,
   		FNE_ENT02B	,
   		FNE_ENT03B	,
   		FNE_ENT04B	,
   		FNE_VLRRLZ	,
   		FNE_VORIG	,
	    FNJ_FILIAL	,
	    FNJ_CODPRJ	,
   	    FNJ_ITEM	,
	    FNJ_REVIS	,	     
	    FNJ_ETAPA	,
   		FNJ_CBAEXE	,
   		FNJ_ITEXE	,
	   	FNJ_TAFEXE	,
   		FNJ_SLDEXE	,
   		FNJ_VLREXE	,
   		FNJ_DTCONT	,
		N1_FORNEC	,
		N1_LOJA		,
		N1_NFISCAL	,
		N1_NSERIE	,
		N1_ITEM       
		
	FROM %table:FNB% FNB INNER JOIN %table:FND% FND  ON
	    FNB_FILIAL = FND_FILIAL AND
	    FNB_CODPRJ = FND_CODPRJ AND
	    FNB_REVIS  = FND_REVIS
	
		INNER JOIN %table:FNE% FNE  ON
	    FND_FILIAL = FNE_FILIAL AND
	    FND_CODPRJ = FNE_CODPRJ AND
	    FND_REVIS  = FNE_REVIS  AND
	    FND_ETAPA  = FNE_ETAPA  AND 
	    FND_ITEM   = FNE_ITEM 
	    
   	    INNER JOIN %table:FNJ% FNJ  ON
	    FNE_FILIAL = FNJ_FILIAL AND
  	    FNE_CODPRJ = FNJ_CODPRJ AND
	    FNE_REVIS  = FNJ_REVIS  AND
	    FNE_ETAPA  = FNJ_ETAPA  AND 
	    FNE_ITEM   = FNJ_ITEM   AND
	    FNE_LINHA  = FNJ_LINHA  AND
	    FNE_TPATF  = FNJ_TAFPRJ AND 
	    FNE_TPSALD = FNJ_SLDPRJ                                                                   
	    
   	    INNER JOIN %table:SN1% SN1  ON
   	    FNJ_FILIAL = N1_FILIAL AND
   	    FNJ_CBAEXE = N1_CBASE  AND 
   	    FNJ_ITEXE  = N1_ITEM
	
	WHERE
	   
		FNB_CODPRJ >= %exp:cProjDe%  AND
		FNB_CODPRJ <= %exp:cProjAte% AND
		%exp:cCondRev%               AND
		%exp:cCondFil%               AND
		FNJ_TAFPRJ  = %exp:cTipo%     AND
		FNJ_SLDPRJ = %exp:cTpSLD%    AND
		FNJ_DTCONT >= %exp:cDataIni%	AND
		FNJ_DTCONT <= %exp:cDataFim%	AND
 		FNB.%notDel% AND
		FND.%notDel% AND
		FNE.%notDel% AND
		FNJ.%notDel% AND
		SN1.%notDel%                                       
		
	ORDER BY FNB_FILIAL,FNB_CODPRJ,FNB_REVIS,FND_ETAPA,FND_ITEM,FNJ_CBAEXE,FNJ_ITEM
	


EndSql

END REPORT QUERY oFNB
 
oFNJ:SetParentQuery()
oFNE:SetParentQuery()

oFNE:SetParentFilter({|cParam| (cAliasPrj)->(FND_FILIAL+FND_CODPRJ+FND_REVIS) == cParam},{|| FNE_FILIAL+FNE_CODPRJ+FNE_REVIS})                    
oFNJ:SetParentFilter({|cParam| (cAliasPrj)->(FNE_FILIAL+FNE_CODPRJ+FNE_REVIS+FNE_ETAPA+FNE_ITEM) == cParam},{|| (cAliasPrj)->(FNJ_FILIAL+FNJ_CODPRJ+FNJ_REVIS+FNJ_ETAPA+FNJ_ITEM) })
CtbTmpErase(cTmpFil)
oFNB:Print()

Return
