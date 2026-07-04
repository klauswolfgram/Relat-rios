/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.ch"
#Include "Report.ch"
#Include "TECR271.ch"       

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTERC270   บAutor  ณMicrosiga           บ Data ณ  12/13/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de Vistoria Tecnica                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

User Function TECR271(oView)

Local aArea		:= GetArea()
Local oReport 

Private cTitulo := STR0001 //Relat๓rio de Vistoria Tecnica
Private aOrdem	:= {STR0004}	//"Vistoria"
Private cQry	:= GetNextAlias()

oReport := ReportDef()
oReport:PrintDialog()

RestArea(aArea)

Return      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณMicrosiga           บ Data ณ  12/13/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ReportDef()   

Local oReport
Local oSection
Local oSection1   
Local oSection2
Local nX	:= 0

Define Report oReport Name STR0002 Title cTitulo Action {|oReport| ReportPrint(oReport)} Description STR0003 //"Este programa emite a Impressใo de Relat๓rio vistoria tecnica."

Define Section oSection Of oReport Title cTitulo Tables "AAT" Total In Column Orders aOrdem

Define Cell Name "AAT_CODVIS" Of oSection Alias "AAT" Block {|| M->AAT_CODVIS } 
Define Cell Name "AAT_OPORTU" Of oSection Alias "AAT" Block {|| M->AAT_OPORTU }
Define Cell Name "AAT_OREVIS" Of oSection Alias "AAT" Block {|| M->AAT_OREVIS }
Define Cell Name "AAT_ENTIDA" Of oSection Alias "AAT" Block {|| M->AAT_ENTIDA }  
Define Cell Name "AAT_CODENT" Of oSection Alias "AAT" Block {|| M->AAT_CODENT }
Define Cell Name "AAT_LOJENT" Of oSection Alias "AAT" Block {|| M->AAT_LOJENT }
Define Cell Name "AAT_NOMENT" Of oSection Alias "AAT" Block {|| FsVerif(M->AAT_ENTIDA)} 
Define Cell Name "AAT_PROPOS" Of oSection Alias "AAT" Block {|| M->AAT_PROPOS }
Define Cell Name "AAT_PREVIS" Of oSection Alias "AAT" Block {|| M->AAT_PREVIS }
Define Cell Name "AAT_EMISSA" Of oSection Alias "AAT" Block {|| M->AAT_EMISSA }
Define Cell Name "AAT_TABELA" Of oSection Alias "AAT" Block {|| M->AAT_TABELA }
Define Cell Name "AAT_DTINI" Of oSection Alias "AAT" Block {|| M->AAT_DTINI }   
Define Cell Name "AAT_HRINI" Of oSection Alias "AAT" Block {|| M->AAT_HRINI }
Define Cell Name "AAT_DTFIM" Of oSection Alias "AAT" Block {|| M->AAT_DTFIM }
Define Cell Name "AAT_HRFIM" Of oSection Alias "AAT" Block {|| M->AAT_HRFIM }
Define Cell Name "AAT_STATUS" Of oSection Alias "AAT" Block {|| M->AAT_STATUS }

Define Section oSection1 Of oSection Title cTitulo Tables "AAT" Total In Column Orders aOrdem

Define Cell Name "AAT_REGIAO" Of oSection1 Alias "AAT" Block {|| M->AAT_REGIAO }
Define Cell Name STR0005 Of oSection1 Alias "AAT" Block {|| Posicione("SX5",1,xFilial("SX5")+"A2"+M->AAT_REGIAO,"X5_DESCRI") }	//"Local" 
Define Cell Name "AAT_CODVIS" Of oSection1 Alias "AAT" Block {|| M->AAT_CODVIS } 
Define Cell Name "AAT_CODABT" Of oSection1 Alias "AAT" Title STR0007 Block {|| M->AAT_CODABT }	//"Visita"
Define Cell Name STR0006 Of oSection1 Alias "AAT" Block {|| Posicione("ABT",1,xFilial("ABT")+M->AAT_CODABT,"ABT_DESCRI")}	//"Descri็ใo Visita"
Define Cell Name "AAT_VEND" Of oSection1 Alias "AAT" Block {|| M->AAT_VEND }
Define Cell Name "AAT_NOMVEN" Of oSection1 Alias "AAT" Block {|| M->AAT_NOMVEN }
Define Cell Name "AAT_VISTOR" Of oSection1 Alias "AAT" Block {|| M->AAT_VISTOR }
Define Cell Name "AAT_NOMVIS" Of oSection1 Alias "AAT" Block {|| Posicione("AA1",1,xFilial("AA1")+ M->AAT_VISTOR,"AA1_NOMTEC") } Title STR0008	//"Nome Vistoriador"
Define Cell Name "AAT_OBSVIS" Of oSection1 Alias "AAT" Block {|| M->AAT_OBSVIS } 

Define Section oSection2 Of oReport Tables "AAU" total In Column Orders aOrdem

Define Cell Name "AAU_ITEM" Of oSection2 Alias "AAU" Block {|| (cQry)->AAU_ITEM }
Define Cell Name "AAU_PRODUT" Of oSection2 Alias "AAU"  Block {|| (cQry)->AAU_PRODUT }
Define Cell Name "AAU_DESCRI" Of oSection2 Alias "AAU" Block {|| Posicione("SB1",1,xFilial("SB1")+(cQry)->AAU_PRODUT,"B1_DESC") }
Define Cell Name "AAU_UM" Of oSection2 Alias "AAU"  Block {|| (cQry)->AAU_UM }
Define Cell Name "AAU_MOEDA" Of oSection2 Alias "AAU"   Block {|| (cQry)->AAU_MOEDA }
Define Cell Name "AAU_QTDVEN" Of oSection2 Alias "AAU"  Block {|| (cQry)->AAU_QTDVEN }
Define Cell Name "AAU_PRCVEN" Of oSection2 Alias "AAU"  Block {|| (cQry)->AAU_PRCVEN }
Define Cell Name "AAU_PRCTAB" Of oSection2 Alias "AAU"  Block {|| (cQry)->AAU_PRCTAB }
Define Cell Name "AAU_VLRTOT" Of oSection2 Alias "AAU"  Block {|| (cQry)->AAU_VLRTOT }
Define Cell Name "AAU_TPPROD" Of oSection2 Alias "AAU"  Block {|| Iif(Empty((cQry)->AAU_TPPROD),"",FsCmbTpP((cQry)->AAU_TPPROD)) }
Define Cell Name "AAU_OBSPRD" Of oSection2 Alias "AAU"  
Define Cell Name "AAU_PMS" Of oSection2 Alias "AAU"  Block {|| (cQry)->AAU_PMS }
Define Cell Name "AAU_CODVIS" Of oSection2 Alias "AAU" Block {|| (cQry)->AAU_CODVIS }
Define Cell Name "AAU_FOLDER" Of oSection2 Alias "AAU" Block {|| (cQry)->AAU_FOLDER }

TRPosition():New(oSection2,"AAU",1,{|| xFilial("AAU") + (cQry)->AAU_CODVIS + "1" + (cQry)->AAU_ITEM },.T.)

Define Section oSection3 Of oReport Tables "AAU" total In Column Orders aOrdem
 
Define Cell Name "AAU_ITEM" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_ITEM }
Define Cell Name "AAU_PRODUT" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_PRODUT }
Define Cell Name "AAU_DESCRI" Of oSection3 Alias "AAU" Block {|| Posicione("SB1",1,xFilial("SB1")+(cQry)->AAU_PRODUT,"B1_DESC") }
Define Cell Name "AAU_UM" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_UM } 
Define Cell Name "AAU_MOEDA" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_MOEDA }
Define Cell Name "AAU_QTDVEN" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_QTDVEN }
Define Cell Name "AAU_PRCVEN" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_PRCVEN }
Define Cell Name "AAU_PRCTAB" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_PRCTAB }
Define Cell Name "AAU_VLRTOT" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_VLRTOT } 
Define Cell Name "AAU_TPPROD" Of oSection3 Alias "AAU" Block {|| Iif(Empty((cQry)->AAU_TPPROD),"",FsCmbTpP((cQry)->AAU_TPPROD)) }
Define Cell Name "AAU_OBSPRD" Of oSection3 Alias "AAU"
Define Cell Name "AAU_ITPAI" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_ITPAI }
Define Cell Name "AAU_CODVIS" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_CODVIS }
Define Cell Name "AAU_FOLDER" Of oSection3 Alias "AAU" Block {|| (cQry)->AAU_FOLDER }
 
TRPosition():New(oSection3,"AAU",2,{|| xFilial("AAU") + (cQry)->AAU_CODVIS + "2" + (cQry)->AAU_ITEM },.T.)
 
oReport:DisableOrientation()
oReport:SetLandscape()

Return(oReport)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrintบAutor  ณMicrosiga           บ Data ณ  12/13/12   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                             บฑฑ
ฑฑบ          ณ                                                             บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                          บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ReportPrint(oReport)

Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1) 
Local oSection3 := oReport:Section(2)
Local oSection4 := oReport:Section(3)
Local cPr		:= STR0009	//"Produto"
Local cAc		:= STR0010	//"Acessorios"
Local cCodVis	:= M->AAT_CODVIS
Local lUnic		:= .T.      


BEGIN REPORT QUERY oSection3
	
	BeginSQL Alias cQry    
	
		SELECT AAU.AAU_PRODUT,AAU.* 
		FROM %Table:AAU% AAU 
		WHERE AAU.AAU_CODVIS = %Exp:cCodVis% 
	 	AND AAU.%notdel% 
	 	Order By AAU.AAU_FILIAL,AAU.AAU_CODVIS,AAU_FOLDER
	EndSQL    

END REPORT QUERY oSection3               

oSection2:Cell("AAT_CODVIS"):Disable()
oSection3:Cell("AAU_CODVIS"):Disable() 
oSection4:Cell("AAU_CODVIS"):Disable()
oSection3:Cell("AAU_FOLDER"):Disable() 
oSection4:Cell("AAU_FOLDER"):Disable()
oSection3:Cell("AAU_PMS"):Disable()
oSection4:Cell("AAU_ITPAI"):Disable() 

oSection1:Init(.T.)
oSection1:PrintLine() 
oSection1:Finish()
oReport:SkipLine()
oSection2:Init(.T.)  
oSection2:PrintLine()
oReport:SkipLine()
oSection2:Finish()
             
oReport:SkipLine()  
oReport:PrintText(cPr)
oReport:FatLine() 

DbSelectArea(cQry)

If (cQry)->(EOF())
    oReport:SkipLine()
    oSection3:PrintHeader()
    oReport:SkipLine()
    oReport:SkipLine() 
	oReport:PrintText(cAc)
	oReport:FatLine()
	oReport:SkipLine() 
	oSection4:PrintHeader()
	oReport:SkipLine()  
EndIf   

oSection3:Init(.T.)
While (cQry)->(!EOF())
  
	If (cQry)->AAU_FOLDER == "1"

		oSection3:PrintLine()
   
	Else                  
		If lUnic	      
			oReport:SkipLine()
			oReport:PrintText(cAc)
			oReport:FatLine()
			lUnic := .F.
			oSection4:Init(.T.)
		EndIf
		
		oSection4:PrintLine()

	EndIf	
	      
(cQry)->(DbSKip())
END
oSection3:Finish() 
oSection4:Finish()
oReport:SkipLine()  

Return             
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFsVerif   บAutor  ณMicrosiga           บ Data	ณ  12/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o Nome da Entidade (Cliente ou Prospect)            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function FsVerif(cEntid)

Local cNomEnt := ""

DbSelectArea("AAT")

If cEntid == "1"
	cNomEnt := Alltrim( Posicione("SA1",1,xFilial("SA1")+M->AAT_CODENT+M->AAT_LOJENT,"A1_NOME") )
Else
	cNomEnt := Alltrim( Posicione("SUS",1,xFilial("SUS")+M->AAT_CODENT+M->AAT_LOJENT,"US_NOME") )
EndIf

Return (cNomEnt)      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFsCmbTpP  บAutor  ณMicrosiga           บ Data	ณ  12/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o nome do tipo de produto					          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function FsCmbTpP(cTpprod)

Local cTp 
Local nY := 0       
Local cCampo := "AAU_TPPROD"

DbSelectArea("SX3")
dbSetOrder(2)
If dbSeek( cCampo )
   cTp := X3Cbox()
EndIf    

aTpProd := StrTokArr(cTp,";")         

For nY:= 1 To Len(aTpProd)
	aTpProd[nY] = StrTokArr(aTpProd[nY],"=")
Next

Return aTpProd[&cTpprod][2]