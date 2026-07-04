/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'PROTHEUS.ch'
#Include 'FINR405.ch'

Static oFINR4051 := Nil
Static aRecnos := {}

User Function FINR405(aRecFon)
Local oReport := Nil

Private aSelFil := {}
Default aRecFon := {}

aRecnos := Aclone(aRecFon)

oReport := ReportDef()

If Len(aRecnos) > 0
	oReport:HideParamPage()
EndIf

oReport:PrintDialog()
Return

/*/{Protheus.doc} ReportDef
Definição do relatório
@author    Totvs SA
@version   12.1.17
@since     07/2017
/*/
Static Function ReportDef()
Local oReport := Nil
Local oSec1 := Nil
Local oSec2 := Nil
Local cPergunt := "FIN405"

oReport := TReport():New("FINR405", OemToAnsi(STR0001), cPergunt, {|oReport| ReportPrint(oReport)}, (STR0001)) 

pergunte("FIN405",.F.)

//Section 1
oSec1 := TRSection():New(oReport, "", {"SA2"})
TRCell():New(oSec1, "FORN_LOJA",,,, TamSx3("A2_COD")[1]+TamSx3("A2_LOJA")[1] + 20,.F.,{||OemToAnsi(STR0002) + AllTrim(TMP450->FOM_FORNEC)+'-'+ AllTrim(TMP450->FOM_LOJA)})
TRCell():New(oSec1, "NOME_REDUZ",,,,TamSx3("A2_NREDUZ")[1] + 5, .F., {||TMP450->FOM_NREDUZ})
TRCell():New(oSec1, "CPF_CGC",,,,30, .F., {||OemToAnsi(STR0003) + TMP450->FOM_CGC})
TRCell():New(oSec1, "ANO_CALEND",,,,30, .F., {||OemToAnsi(STR0004) + TMP450->FOM_ANO})
TRCell():New(oSec1, "COD_RETENC",,,,30, .F., {||OemToAnsi(STR0005) + TMP450->FOM_CODRET})

oBreak := TRBreak():New(oSec1, {||TMP450->(FOM_FILIAL+FOM_FORNEC+FOM_LOJA+FOM_ANO+FOM_CODRET)},,.F.)
oBreak:OnPrintTotal({||oReport:SkipLine(1)})
oSec1:SetHeaderSection(.F.)
oSec1:Setnofilter("FOM")
oSec1:Setnofilter("FON")
oSec1:Setnofilter("SA2")

//Section 2
oSec2 := TRSection():New(oReport, "", {"FOM", "FON", "SA2"})
TRCell():New(oSec2, 		"FON_MES",    "FON", OemToAnsi(STR0006), "@!", TamSx3("FON_MES")[1] + 2,    .F.)
TRCell():New(oSec2, 		"FON_RNDBRT", "FON", OemToAnsi(STR0007), PesqPict("FON","FON_RNDBRT"), TamSx3("FON_RNDBRT")[1] + 1, .F.)
TRCell():New(oSec2, 		"FON_BASE",   "FON", OemToAnsi(STR0008), PesqPict("FON", "FON_BASE"), TamSx3("FON_BASE")[1] + 1,   .F.)
TRCell():New(oSec2, 		"FON_IMPREC", "FON", OemToAnsi(STR0009), PesqPict("FON", "FON_IMPREC"), TamSx3("FON_IMPREC")[1] + 1, .F.)
TRCell():New(oSec2, 		"FON_DIRF", "FON", OemToAnsi(STR0010), "", 3, .F.,{||TMP450->FON_DIRF})

TRFunction():New(oSec2:Cell("FON_RNDBRT"),,"SUM",oBreak,,,,.F.,.F.)
TRFunction():New(oSec2:Cell("FON_BASE"),, "SUM",oBreak,,,,.F.,.F.)
TRFunction():New(oSec2:Cell("FON_IMPREC"),,"SUM",oBreak,,,,.F.,.F.)

oSec2:Cell("FON_RNDBRT"):SetHeaderAlign("RIGHT")
oSec2:Cell("FON_BASE"):SetHeaderAlign("RIGHT")
oSec2:Cell("FON_IMPREC"):SetHeaderAlign("RIGHT") 
Return oReport

/*/{Protheus.doc} ReportPrint
Impressão do relatório
@author    Totvs SA
@version   12.1.17
@since     07/2017
/*/
Static Function ReportPrint(oReport)
Local oSec1 := oReport:Section(1)
Local oSec2 := oReport:Section(2)
Local cTmpFil := ""
Local cCodAnt := ""
Local cMes 	  := ""
Local cMesAnt := ""
Local lGetParAut := ExistFunc("GetParAuto")

CriaTmp(.T.)

If Len(aRecnos) == 0 .and. MV_PAR08 == 1 
	If Empty(aSelFil)
		AdmSelecFil("FIN405", 8, .F., @aSelFil, "FOM", .F.)
	Endif
Else
	Aadd(aSelFil, cFilAnt)
Endif

If lGetParAut .And. IsBlind()
	aRetAuto := GetParAuto("FINR460ATestCase")
	aSelFil  := Iif(ValType(aRetAuto) == "A", aRetAuto, aSelFil)	
EndIf

GravaTmp(@aSelFil, @cTmpFil)

oSec1:Init()

While TMP450->(!EOF())					
	oSec2:Init()
			
	If TMP450->(FOM_FILIAL+FOM_FORNEC+FOM_LOJA+FOM_ANO+FOM_CODRET) <> cCodAnt				
		cCodAnt := TMP450->(FOM_FILIAL+FOM_FORNEC+FOM_LOJA+FOM_ANO+FOM_CODRET)
		oSec1:PrintLine()
		oReport:ThinLine()
	EndIf

	If cMesAnt <> TMP450->FON_MES 
		cMesAnt := TMP450->FON_MES
		cMes := Mes(AllTrim(TMP450->FON_MES))
	EndIf
	
	oSec2:Cell("FON_MES" ):SetBlock({||cMes})
	oSec2:Cell("FON_RNDBRT" ):SetBlock({||TMP450->FON_RNDBRT})
	oSec2:Cell("FON_BASE" ):SetBlock({||TMP450->FON_BASE})
	oSec2:Cell("FON_IMPREC" ):SetBlock({||TMP450->FON_IMPREC})
	oSec2:PrintLine()
				
	TMP450->(DbSkip())
	
	If TMP450->(FOM_FILIAL+FOM_FORNEC+FOM_LOJA+FOM_ANO+FOM_CODRET) <> cCodAnt
		oSec2:Finish()
	EndIf	
EndDo

oSec1:Finish()
CriaTmp(.F.)
Return Nil 

/*/{Protheus.doc} GravaTmp
Seleção dos registros para impressão
@author    Totvs SA
@version   12.1.17
@since     07/2017
/*/
Static Function GravaTmp(aSelFil, cTmpFil)
Local cQuery := ""
Local aArea := GetArea()
Local cArqTmp := GetNextAlias()
Local cChave := ""
Local cChaveSA2 := ""
Local nX := 0
Local nQuant := 0

nQuant := Len(aRecnos)
 
cQuery := "SELECT FOM.FOM_FILIAL,FOM.FOM_FORNEC,FOM.FOM_LOJA,FOM.FOM_ANO,FOM.FOM_CODRET, "
cQuery += "FOM.FOM_FILORI,FOM.FOM_IDDOC,FON.FON_MES,FON.FON_RNDBRT,FON.FON_BASE,FON.FON_IMPREC, FON.FON_DIRF "
cQuery += "FROM " + RetSqlName("FOM") + " FOM "
cQuery += "INNER JOIN " + RetSqlName("FON") + " FON "
cQuery += "ON FOM.FOM_IDDOC = FON.FON_IDDOC AND "
cQuery += "FOM.FOM_FILIAL = FON.FON_FILIAL "
cQuery += "WHERE "

If nQuant == 0
	cQuery += "FOM.FOM_ANO = '" + mv_par01 + "' AND "
	cQuery += "FOM.FOM_FORNEC BETWEEN '" + mv_par02 + "' AND '" + mv_par03 + "' AND "
	cQuery += "FOM.FOM_LOJA BETWEEN '" + mv_par04 + "' AND '" + mv_par05 + "' AND "
	cQuery += "FON.FON_MES BETWEEN '" + mv_par06 + "' AND '" + mv_par07 + "' AND "
	
	If (FwModeAccess("FOM", 1) == "C" .Or. Len(aSelFil) == 1)
		cQuery += "FOM.FOM_FILIAL = '" + xFilial("FOM", aSelFil[1]) + "' AND "
	Else
		cQuery += "FOM.FOM_FILIAL " + GetRngFil(aSelFil, "FOM", .T., @cTmpFil) + " AND "
	EndIf
	
	If mv_par09 < 3
		cQuery += "FON.FON_DIRF = '" + CValToChar(mv_par09) + "' AND "
	Else
		cQuery += "FON.FON_DIRF IN ('1', '2', '3') AND "	
	EndIf 
	
	cQuery += "FOM.D_E_L_E_T_ = ' ' AND FON.D_E_L_E_T_ = ' ' "
Else
	cQuery += "FON.R_E_C_N_O_ IN ("
	
	For nX := 1 To nQuant
		If nX < nQuant 
			cQuery += "'" + CValToChar(aRecnos[nX]) + "', "
		Else
			cQuery += "'" + CValToChar(aRecnos[nX]) + "') "	
		EndIf 	  
	Next nX	
EndIf

cQuery += "ORDER BY FOM.FOM_FILIAL, FOM.FOM_FORNEC, FOM.FOM_LOJA, FOM.FOM_ANO, FOM.FOM_CODRET, FON.FON_MES "   
cQuery := ChangeQuery(cQuery)

DbSelectArea("SA2")
SA2->(DbSetOrder(1))
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cArqTmp, .T., .T.) 

While !((cArqTmp)->(Eof()))
	RecLock("TMP450", .T.)
	TMP450->FOM_FILIAL	:= (cArqTmp)->FOM_FILIAL
	TMP450->FOM_FORNEC	:= (cArqTmp)->FOM_FORNEC 
	TMP450->FOM_LOJA		:= (cArqTmp)->FOM_LOJA
	TMP450->FOM_ANO 		:= (cArqTmp)->FOM_ANO
	TMP450->FOM_CODRET 	:= (cArqTmp)->FOM_CODRET
	TMP450->FON_MES 		:= (cArqTmp)->FON_MES
	TMP450->FON_RNDBRT 	:= (cArqTmp)->FON_RNDBRT
	TMP450->FON_BASE 	   	:= (cArqTmp)->FON_BASE
	TMP450->FON_IMPREC 	:= (cArqTmp)->FON_IMPREC
	TMP450->FON_DIRF		:= Iif( (cArqTmp)->FON_DIRF == "1", STR0011,STR0012 ) //"Sim" - "Não"
	
	cChaveSA2 := xFilial("SA2",(cArqTmp)->FOM_FILORI) + TMP450->(FOM_FORNEC + FOM_LOJA)  
	
	If cChave <> cChaveSA2
		cChave := cChaveSA2
		 
		If SA2->(DbSeek(cChaveSA2))  
			TMP450->FOM_NREDUZ := SA2->A2_NREDUZ
			TMP450->FOM_CGC := SA2->A2_CGC 
		EndIf
	Else
		TMP450->FOM_NREDUZ := SA2->A2_NREDUZ
		TMP450->FOM_CGC := SA2->A2_CGC 	
	EndIf
		
	TMP450->(MsUnLock())
	(cArqTmp)->(DbSkip())
EndDo

If !Empty(cTmpFil)
	CtbTmpErase(cTmpFil)
Endif

DbSelectArea(cArqTmp)
RestArea(aArea)
TMP450->(DbGotop())
Return Nil 

/*/{Protheus.doc} CriaTmp 
Criação e deleção do arquivos temporário
@author    Totvs SA
@version   12.1.17
@since     07/2017
/*/
Static Function CriaTmp(lCriaTmp)
Local aCampos := {}
Local aBruto := TamSx3("FON_RNDBRT")
Local aBase := TamSx3("FON_BASE")
Local aImpRec := TamSx3("FON_IMPREC")
   
If lCriaTmp
	Aadd(aCampos, {"FOM_FILIAL", "C", TamSx3("FOM_FILIAL")[1], 0})
	Aadd(aCampos, {"FOM_FORNEC", "C", TamSx3("FOM_FORNEC")[1], 0})
	Aadd(aCampos, {"FOM_LOJA", 	 "C", TamSx3("FOM_LOJA")[1], 0})	
	Aadd(aCampos, {"FOM_NREDUZ", "C", TamSx3("A2_NREDUZ")[1], 0})
	Aadd(aCampos, {"FOM_CGC",    "C", TamSx3("A2_CGC")[1], 0})	
	Aadd(aCampos, {"FOM_ANO",    "C", 4, 0})
	Aadd(aCampos, {"FOM_CODRET", "C", 4, 0})
	Aadd(aCampos, {"FON_MES",    "C", 2, 0})
	Aadd(aCampos, {"FON_RNDBRT", "N", aBruto[1], aBruto[2]})
	Aadd(aCampos, {"FON_BASE",   "N", aBase[1], aBase[2]})
	Aadd(aCampos, {"FON_IMPREC", "N", aImpRec[1], aImpRec[2]})
	Aadd(aCampos, {"FON_DIRF", "C", 3, 0})
	
	If(oFINR4051 <> Nil)
		oFINR4051:Delete()
		oFINR4051 := Nil
	EndIf
	
	oFINR4051 := FwTemporaryTable():New("TMP450")
	oFINR4051:SetFields(aCampos)
	oFINR4051:AddIndex("1", {"FOM_FILIAL", "FOM_FORNEC", "FOM_LOJA", "FOM_ANO", "FOM_CODRET", "FON_MES"})
	oFINR4051:Create()
	dbSelectArea("TMP450")
ElseIf oFINR4051 <> Nil
	oFINR4051:Delete()
	oFINR4051 := Nil
EndIf

Return Nil

Static Function Mes(cMes)
Do Case
	Case cMes == "01"
		cMes := STR0013
	Case cMes == "02"
		cMes := STR0014
	Case cMes == "03"
		cMes := STR0015
	Case cMes == "04"
		cMes := STR0016
	Case cMes == "05"
		cMes := STR0017
	Case cMes == "06"
		cMes := STR0018
	Case cMes == "07"
		cMes := STR0019
	Case cMes == "08"
		cMes := STR0020
	Case cMes == "09"
		cMes := STR0021
	Case cMes == "10"
		cMes := STR0022
	Case cMes == "11"
		cMes := STR0023
	OTHERWISE
		cMes := STR0024	
EndCase
Return cMes