/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Protheus.ch"
#include "ATFR101.ch"

//+--------------------------------------------------------------------------
/*{Protheus.doc} NomeDaFuncao
Relatório de Tranasferências de Local
@owner      TOTVS
@author     ricardo.munhoz
@since      06/03/2014
@project    SIGAATF
@menu       Relatório/Transferência de Local
@version    P118
*/
//+--------------------------------------------------------------------------

User Function ATFR101()

Local aArea := GetArea()
Local oReport

If AliasInDic("SNL")
	If FindFunction("TRepInUse") .And. TRepInUse()
		oReport := ReportDef()
		oReport:PrintDialog()
	Else
		MsgAlert(OemToAnsi(STR0012)) //"Este relatório está disponível somente no modelo personalizável."
	EndIf
EndIf


RestArea(aArea)

Return


Static Function ReportDef()

Local oReport
Local oSection1
Local oSecFil
Local cTitulo := OemToAnsi(STR0001) //"Transferência de Local"

Pergunte("ATR101",.F.)

oReport := TReport():New("ATFR101",cTitulo,"ATR101",{|oReport|ReportPrint(oReport)},OemToAnsi(STR0002)) //"Emite relacao dos bens transferidos selecionados."

oReport:SetLandscape()

oSection1 := TRSection():New(oReport,OemToAnsi(STR0001),{"SN1","SN4","SNL"}) //"Transferência de Local"

TRCell():New(oSection1,"CBASE",,OemToAnsi(STR0013),,TamSX3("N4_CBASE")[1] + 5) //"Item"
TRCell():New(oSection1,"DATA",,OemToAnsi(STR0014),,15) //"Dt. Transf."
TRCell():New(oSection1,"CFILIALDE",,OemToAnsi(STR0015),,TamSX3("N4_FILIAL")[1] + 8) //"Filial Origem"
TRCell():New(oSection1,"CFILIALPARA",,OemToAnsi(STR0016),,TamSX3("N4_FILIAL")[1] + 8) //"Filial Destino"
TRCell():New(oSection1,"CCODLOCALORI",,OemToAnsi(STR0017),,TamSX3("N4_LOCAL")[1] + 10) //"Local Origem"
TRCell():New(oSection1,"CDESLOCALORI",,"",,TamSX3("NL_DESCRIC")[1])
TRCell():New(oSection1,"CCODLOCALDES",,OemToAnsi(STR0018),,TamSX3("N4_LOCAL")[1] + 10) //"Local Destino"
TRCell():New(oSection1,"CDESLOCALDES",,"",,TamSX3("NL_DESCRIC")[1])

oSection1:SetHeaderPage()

oSection1:Cell("CBASE"):lHeaderSize := .F.
oSection1:Cell("DATA"):lHeaderSize	:= .F.

oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,OemToAnsi(STR0019),,20) //"Código"
TRCell():New(oSecFil,"EMPRESA",,OemToAnsi(STR0020),,60) //"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,OemToAnsi(STR0021),,60) //"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,OemToAnsi(STR0022),,60) //"Filial"

oReport:SetUseGC(.F.)

Return oReport


Static Function ReportPrint(oReport)

Local aAreaSN1 := SN1->(GetArea())
Local aAreaSN4 := SN4->(GetArea())
Local aAreaSNL := SNL->(GetArea())

Local oSection1 := oReport:Section(1)

Local cFilialDe := ""
Local cFilialPara := ""
Local cCodLocalOri := ""
Local cDesLocalOri := ""
Local cCodLocalDes := ""
Local cDesLocalDes := ""

Local cAliasQry := GetNextAlias()
Local cWhere := " SN4.N4_OCORR = '03' AND " + " SN4.N4_TIPOCNT='1' AND "+"%"
Local cOrder := "%" + " SN4.N4_FILIAL , SN4.R_E_C_N_O_ " + "%"

Local oSecFil := oReport:Section(2)

Local lGestao := ( FWSizeFilial() > 2 )
Local lSN4Excl := Iif( lGestao, FWModeAccess("SN4",1) == "E", FWModeAccess("SN4",3) == "E")
Local nRegSM0 := SM0->(Recno())
Local aSM0 := {}
Local aSelFil := {}
Local cFilSel := ""
Local nLinha := 0
Local nX := 0
Local nTamEmp := Len(FWSM0LayOut(,1))
Local nTamUnNeg := Len(FWSM0LayOut(,2))
Local nTamTit := 0
Local cFilSN4 := ""
Local cRngFilSN4 := ""
Local aTmpFil := {}
Local cTmpSN4Fil := ""
Local cFilQuery	:= ""
Local lNoTransLo
Private cFilAux := ""

If (lSN4Excl .and. mv_par09 == 1)
	If FindFunction("AdmSelecFil")
		AdmSelecFil("ATFR101",09,.F.,@aSelFil,"SN4",.F.)
	Else
		aSelFil := AdmGetFil(.F.,.F.,"SN4")
	Endif
Endif

If mv_par09 == 1 .And. !Empty(aSelFil)
	aSort(aSelFil)
	oSection1:SetHeaderSection(.F.)
	SM0->(DbGoTo(nRegSM0))
	aSM0 := FWLoadSM0()
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + OemToAnsi(STR0024) +  ")")	//"Filiais selecionadas para o relatorio"
	nTamTit := Len(oReport:Title())
	oSecFil:Init()
	oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
	oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
	oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
	oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})
	For nX := 1 To Len(aSelFil)
		nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[nX] .And. sm0[SM0_GRPEMP] == cEmpAnt})
		If nLinha > 0
			cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
			oSecFil:PrintLine()
		Endif
	Next
	oReport:SetTitle(cTitulo)
	oSecFil:Finish()
	oReport:EndPage()
	oSection1:SetHeaderSection(.T.)
Endif

If Empty(aSelFil)
	aSelFil := {cFilAnt}
	cFilSN4 := "(N4_FILIAL = '" + xFilial("SN4") + "' OR N4_FILORIG = '" + xFilial("SN4") + "') AND " 
	cFilQuery := " N4_FILIAL = '" + xFilial("SN4") + "' AND "
Else
	cRngFilSN4 := GetRngFil(aSelFil,"SN4",.T.,@cTmpSN4Fil)
	aAdd(aTmpFil,cTmpSN4Fil)
	cFilSN4 := "(N4_FILIAL " + cRngFilSN4 + " OR N4_FILORIG " + cRngFilSN4 + ") AND "
	cFilQuery := " N4_FILIAL  " + cRngFilSN4 + " AND "
Endif

cFilQuery := "% " + cFilQuery + " %"
cFilSN4 := "%" + cFilSN4 + cWhere

oSection1:BeginQuery()
BeginSql alias cAliasQry
	SELECT
		 SN4.N4_FILIAL
		,SN4.N4_FILORIG
		,SN4.N4_CBASE
		,SN1.N1_DESCRIC
		,SN4.N4_ITEM
		,SN1.N1_GRUPO
		,SN4.N4_DATA
		,SN4.N4_LOCAL
		,SN4.N4_OCORR
		,SN4.R_E_C_N_O_
		,SN4.N4_IDMOV
	FROM %table:SN4% SN4
		LEFT JOIN %table:SN1% SN1 ON
			SN4.N4_FILIAL = SN1.N1_FILIAL AND
			SN4.N4_CBASE = SN1.N1_CBASE AND
			SN4.N4_ITEM = SN1.N1_ITEM
	WHERE %exp:cFilSN4%
			SN4.N4_CBASE >= %exp:mv_par01% AND
			SN4.N4_CBASE <= %exp:mv_par02% AND
			SN4.N4_ITEM >= %exp:mv_par03% AND
			SN4.N4_ITEM <= %exp:mv_par04% AND
			SN1.N1_GRUPO >= %exp:mv_par05% AND
			SN1.N1_GRUPO <= %exp:mv_par06% AND
			SN4.N4_DATA >= %exp:mv_par07% AND
			SN4.N4_DATA <= %exp:mv_par08% AND
			SN4.%notDel% AND
			SN1.%notDel%
	ORDER BY %exp:cOrder%
EndSql
oSection1:EndQuery()

If mv_par09 == 1
	cFilAux := (cAliasQry)->N4_FILIAL
	oReport:PrintText(OemToAnsi(STR0023) + cFilAux) //"Filial : "
	oReport:SkipLine()
	oBreak := TRBreak():New(oSection1,{|| cFilAux})
	oBreak:OnBreak({|| oReport:SkipLine(2)})
	oBreak:OnPrintTotal({|| IIf(!(cAliasQry)->(EOF()),oReport:PrintText(OemToAnsi(STR0023) + cFilAux),"")}) //"Filial : "
EndIf

oSection1:Init()

oReport:SetMeter(10)

While !(cAliasQry)->(EOF())
	oReport:IncMeter()
	If Empty((cAliasQry)->N4_FILORIG) .or. (cAliasQry)->N4_FILORIG == (cAliasQry)->N4_FILIAL //.And. !((cAliasQry)->N4_CBASE == )
		cFilialDe := ""
		If Empty((cAliasQry)->N4_LOCAL)
			cCodLocalOri := ""
			cDesLocalOri := ""
		Else
			cCodLocalOri := (cAliasQry)->N4_LOCAL
			cDesLocalOri := POSICIONE("SNL",1,xFilial("SNL",(cAliasQry)->N4_FILIAL) + cCodLocalOri,"NL_DESCRIC")
		EndIf

		cFilAux := (cAliasQry)->N4_FILIAL
		lNoTransLo := .F.

		If SeekSN4Dest((cAliasQry)->N4_IDMOV,(cAliasQry)->N4_DATA,cFilQuery) //Posicionar corretamente no proximo registro da SN4
			cFilialPara := ""
			
			If SN4->N4_FILORIG <> SN4->N4_FILIAL //Para quando tiver local transferido para outra filial
				cFilialPara := SN4->N4_FILIAL
				cFilialDe	:= SN4->N4_FILORIG
			Endif

			If Empty(SN4->N4_LOCAL)
				cCodLocalDes := ""
				cDesLocalDes := ""
				lNoTransLo	 := .T.
			Else
				cCodLocalDes := SN4->N4_LOCAL
				cDesLocalDes := POSICIONE("SNL",1,xFilial("SNL",SN4->N4_FILIAL) + cCodLocalDes,"NL_DESCRIC")
			EndIf
		Else
				cFilialPara 	:= ""
				cCodLocalDes	:= ""
				cDesLocalDes	:= STR0026 //"Não encontrado com as filiais selecionadas"
		Endif
		
	EndIf

	If  !lNoTransLo .And. cCodLocalDes <> STR0026
		oSection1:Cell("CBASE"):SetBlock({|| (cAliasQry)->N4_CBASE})
		oSection1:Cell("DATA"):SetBlock({|| (cAliasQry)->N4_DATA})
		oSection1:Cell("CFILIALDE"):SetBlock({|| cFilialDe})
		oSection1:Cell("CFILIALPARA"):SetBlock({|| cFilialPara})
		oSection1:Cell("CCODLOCALORI"):SetBlock({|| cCodLocalOri})
		oSection1:Cell("CDESLOCALORI"):SetBlock({|| cDesLocalOri})
		oSection1:Cell("CCODLOCALDES"):SetBlock({|| cCodLocalDes})
		oSection1:Cell("CDESLOCALDES"):SetBlock({|| cDesLocalDes})
		oSection1:PrintLine()
	Endif
	(cAliasQry)->(DbSkip())
End

oSection1:Finish()

(cAliasQry)->(dbclosearea())

For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])
Next

RestArea(aAreaSN1)
RestArea(aAreaSN4)
RestArea(aAreaSNL)

Return

//+--------------------------------------------------------------------------
/*{Protheus.doc} SeekSN4Dest
Relatório de Transferências de Local
@owner      TOTVS
@author     TOTVS
@since      28/10/2020
@project    SIGAATF
@menu       Relatório/Transferência de Local
@version    P12
*/
//+--------------------------------------------------------------------------
Static Function SeekSN4Dest(IdMov, dData, cWhereFiltro)

Local lRet := .F.
Local cAliasQry2 := GetNextAlias()
// Local lNoTransLo := .F.

BeginSql alias cAliasQry2
	SELECT SN4.R_E_C_N_O_
	FROM %table:SN4% SN4	
	WHERE %exp:cWhereFiltro%
		SN4.N4_IDMOV = %exp:IdMov% AND
		SN4.N4_TIPOCNT = '1' AND
		SN4.N4_DATA = %exp:dData% AND
		SN4.N4_OCORR = '04' AND
		SN4.%notDel%
EndSql

If !(cAliasQry2)->(Eof())
	lRet := .T.
	SN4->(DbGoTo( (cAliasQry2)->R_E_C_N_O_))
Endif

(cAliasQry2)->(dbclosearea())

Return lRet