/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³  DATA  ³ BOPS ³Program.³					ALTERACAO 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³        ³      ³        ³                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
#INCLUDE "ATFR280.CH"
//#Include "FiveWin.ch"
#include "totvs.ch"
#Include "Protheus.ch"
#Include "fwcommand.ch"
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR280    ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 12.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de Lancamentos por Classe de valor                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR280()

oReport:=ReportDef()
oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³09/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport,oSection1
Local cReport := "ATFR280"
Local cAlias1 := "SN3"
Local cAlias2 := "SN1"
Local cMoeda  := GetMv("MV_ATFMOED")

Local cTitulo := OemToAnsi(STR0003) // "Lancamentos por Classe de Valor"
Local cDescri := OemToAnsi(STR0001)+" "+OemToAnsi(STR0002) // "Este programa ira emitir a relacao de Lancamentos por Classe de Valor"

Local oFilial //Gestao Corporativa
Local oSecFil //Gestao Corporativa

Pergunte( "ATR280" , .F. )
                   
oReport  := TReport():New( cReport, cTitulo, "ATR280" , { |oReport| ReportPrint( oReport, cAlias1, cAlias2 ) }, cDescri )
oReport:SetLandscape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0008 + Subst(GetMv("MV_SIMB1"),1,5), {cAlias1,cAlias2} )	//"Valor em "

TRCell():New( oSection1, "N3_CLVL"    , cAlias1 ,/*X3Titulo*/,/*Picture*/,Len(SN3->N3_CLVL) + 5 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de custo
TRCell():New( oSection1, "N3_SUBCTA"  , cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de custo
TRCell():New( oSection1, "N3_CCUSTO"  , cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de custo
TRCell():New( oSection1, "N3_CCONTAB" , cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Conta contabil
TRCell():New( oSection1, "SIMBMOEDA1" , 			 , STR0009 	  ,/*Picture*/,10 /*Tamanho*/,/*lPixel*/, {|| Subst(GetMv("MV_SIMB"+alltrim(str(mv_par09))),1,5) } )	//"Simbolo da Moeda"
TRCell():New( oSection1, "N3_VORIG1"  , cAlias1 ,STR0011,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor atual
TRCell():New( oSection1, "N3_VRDACM1" , cAlias1 ,STR0012,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. Acumul
TRCell():New( oSection1, "N3_VRDMES1" , cAlias1 ,STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. nos Mes
TRCell():New( oSection1, "N3_VRCDA1"  , cAlias1 ,STR0014,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Correc. Depr. Acumul
TRCell():New( oSection1, "N3_VRCACM1" , cAlias1 ,STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Correc. Monet. Acumulada

oSection1:SetHeaderPage()
oSection1:SetNoFilter({cAlias1,cAlias2})

oSection2 := TRSection():New( oReport, STR0008 + Subst(GetMv("MV_SIMB"+cMoeda),1,5), {cAlias1,cAlias2} )	//"Valor em "
TRCell():New( oSection2, "ESPACO"       		, 			 ,"" /*STR0010*/    ,/*Picture*/, (Len(SN3->(N3_CLVL+N3_SUBCTA+N3_CCUSTO+N3_CCONTAB)) + 12) /*Tamanho*/,/*lPixel*/, {||  } )	//"Espaco"
TRCell():New( oSection2, "SIMBMOEDA2"   		, 			 ,"" /*STR0009*/    ,/*Picture*/,10 /*Tamanho*/,/*lPixel*/, {|| GetMv("MV_SIMB"+cMoeda) } )	//"Simbolo da Moeda"
TRCell():New( oSection2, "N3_VORIG" +cMoeda , cAlias1 ,"" /*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor atual
TRCell():New( oSection2, "N3_VRDACM"+cMoeda , cAlias1 ,"" /*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. Acumul
TRCell():New( oSection2, "N3_VRDMES"+cMoeda , cAlias1 ,"" /*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. nos Mes
oSection2:SetLinesBefore(0)

//Gestão Corporativa - Início
oFilial := TRSection():New(oReport,"",{"SN3"})
TRCell():New(oFilial,"Filial",,,,TamSx3("N3_FILIAL")[1] + Len(STR0018)) //"Filial : "
oFilial:SetHeaderSection(.F.)

oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0020,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0021,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0022,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0023,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

oReport:SetUseGC(.F.)
//Gestão Corporativa - Fim

oSection2:SetHeaderPage()
oSection2:SetNoFilter({cAlias1,cAlias2})
oSection2:Cell("ESPACO"):Hide()

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Claudio D. de Souza º Data ³  05/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport, cAlias1, cAlias2 )
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)

Local cQuery    := ""
Local cAliasSN1 := ""
Local cFiltro  := ""
Local cChave   := ""
Local cWhere   := ""
Local cMoeda   := GetMv("MV_ATFMOED")
Local dUltDepr := GetMv("MV_ULTDEPR")

// Acumuladores de Conta
LOCAL nCtaVlOri1	:=nCtaDpAcm1:=nCtaDpMes1:=nCtaCrDep1:=nCtaCrMon1:= 0
LOCAL nCtaVlOri2	:=nCtaDpAcm2:=nCtaDpMes2:=nCtaCrDep2:=nCtaCrMon2:= 0

// Acumuladores de Item
LOCAL nValOri1	:=nDepAcm1:=nDepMes1:=nCorDep1:=nCorMon1:= 0
LOCAL nValOri2	:=nDepAcm2:=nDepMes2:=nCorDep2:=nCorMon2:= 0

// Acumuladores Gerais
LOCAL nGerOri1	:=nGerDepA1:=nGerDepM1:=nGerCD1:=nGerCMon1:= 0
LOCAL nGerOri2	:=nGerDepA2:=nGerDepM2:=nGerCD2:=nGerCMon2:= 0

LOCAL cEntidade	:= cSubCta := cCentroCus := cConta := Space(1)

// Verificação da classificação de Ativo se sofre depreciação
Local lAtClDepr := .F. 


Local aClassif := {}
Local cClassif := ""

//Ativo Custo/Provisao
Local lAtfCusPrv := AFXAtCsPrv()
//Gestao Corporativa - Inicio
Local oFilial := oReport:Section(3)
Local oSecFil := oReport:Section(4)
Local lGestao := ( FWSizeFilial() > 2 )
Local lSN3Excl := Iif( lGestao, FWModeAccess("SN3",1) == "E", FWModeAccess("SN3",3) == "E")
Local cSN3Fil  := FWModeAccess("SN3",3)
Local cSN3UN   := FWModeAccess("SN3",2)
Local cSN3Emp  := FWModeAccess("SN3",1)
Local nRegSM0 := SM0->(Recno())
Local aSM0 := {}
Local aSelFil := {}
Local cFilSel := ""
Local nLinha := 0
Local nX := 0
Local nTamEmp := Len(FWSM0LayOut(,1))
Local nTamUnNeg := Len(FWSM0LayOut(,2))
Local nTamFil := Len(FWSM0LayOut(,3))
Local nTamTit := 0
Local cEmp := ""
Local cUN := ""
Local cEmpOld := ""
Local cUNOld := ""
Local lPrtFil := .T.
Local cFilialAtu := cFilAnt
Local cFilSN3 := ""
Local cRngFilSN3 := ""
Local aTmpFil := {}
Local cTmpSN3Fil := ""
Local cCTHEmp := FWModeAccess("CTH",1)
Local cCTHUN := FWModeAccess("CTH",2)
Local cCTHFil := FWModeAccess("CTH",3)
Local cFilQryAnt := ""

// Acumuladores Total Geral
Local nGerOri1T := 0
Local nGerDepA1T := 0
Local nGerDepM1T := 0
Local nGerCD1T := 0
Local nGerCMon1T := 0
Local nGerOri2T := 0
Local nGerDepA2T := 0
Local nGerDepM2T := 0
Local nGerCD2T := 0
Local nGerCMon2T := 0
//Gestao Corporativa - Fim

If (lSN3Excl .and. mv_par12 == 1)
	If FindFunction("AdmSelecFil")
		AdmSelecFil("ATR280",12,.F.,@aSelFil,"SN3",.F.)
	Else
		aSelFil := AdmGetFil(.F.,.F.,"SN3")
	Endif
Endif

If mv_par12 == 1 .And. !Empty(aSelFil)
	aSort(aSelFil)
	oSection1:SetHeaderSection(.F.)
	SM0->(DbGoTo(nRegSM0))
	aSM0 := FWLoadSM0()
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0019 +  ")")	//"Filiais selecionadas para o relatorio"
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
	cFilSN3 := " N3_FILIAL = '"+ xFilial("SN3") + "' AND "
Else
	cRngFilSN3 := GetRngFil(aSelFil,"SN3",.T.,@cTmpSN3Fil)
	aAdd(aTmpFil,cTmpSN3Fil)
	cFilSN3 := " N3_FILIAL "+ cRngFilSN3 + " AND "
Endif

cFilSN3 := "%"+cFilSN3+"%"

If mv_par10 == 1
	aClassif := AdmGetClass()	
	If Len( aClassif ) <= 0
		Return
	EndIf 		
EndIf


cQuery 	 := GetNextAlias()
cAliasSN1 := cQuery
cChave 	:= SqlOrder(SN3->(IndexKey(7)))

If cCTHEmp == "E" .And. cCTHUN == "E" .And. cCTHFil == "C" 
	If ( nTamEmp+nTamUnNeg ) > 0
		cChave 	:= "SUBSTRING(N3_FILIAL,1,"+cValToChar(nTamEmp+nTamUnNeg)+")"+Substr(cChave,10,Len(cChave))
	Else
		cChave 	:= "N3_FILIAL"+Substr(cChave,10,Len(cChave))
	Endif
EndIf

If cCTHEmp == "E" .And. cCTHUN == "C" .And. cCTHFil == "C"
	If nTamEmp > 0
		cChave 	:= "SUBSTRING(N3_FILIAL,1,"+cValToChar(nTamEmp)+")"+Substr(cChave,10,Len(cChave))
	Else
		cChave 	:= "N3_FILIAL"+Substr(cChave,10,Len(cChave))
	Endif

EndIf

If cCTHEmp == "C" .And. cCTHUN == "C" .And. cCTHFil == "C"
	cChave 	:= Substr(cChave,11,Len(cChave))
EndIf

cChave 	:= "%"+cChave+"%"

oSection1:BeginQuery()

cWhere := "(SN3.N3_BAIXA < '1' OR (SN3.N3_BAIXA >= '1' AND SN3.N3_DTBAIXA LIKE '" + Left(Dtos(dUltDepr), 6) + "%'))"  
//Verifica se filtra as classificações patrimoniais
If Len(aClassif) > 0
	cWhere += " And  (N1_PATRIM IN " + FORMATCLAS(aClassif,.T.) + ") "
EndIf

//NÃO mostra ativo Custo/Provisao
If lAtfCusPrv .and. MV_PAR11 == 2
	cWhere += " And SN3.N3_ATFCPR <> '1' "
Endif

cWhere := "%"+ cWhere + "%"

BeginSql Alias cQuery
	SELECT     * 
	FROM 
		%table:SN3% SN3, %table:SN1% SN1
	WHERE %exp:cFilSN3%
		SN3.N3_CLVL   >= %Exp:mv_par01% AND 
		SN3.N3_CLVL   <= %Exp:mv_par02% AND
		SN3.N3_SUBCTA >= %Exp:mv_par03% AND 
		SN3.N3_SUBCTA <= %Exp:mv_par04% AND
		SN3.N3_CCUSTO >= %Exp:mv_par05% AND 
		SN3.N3_CCUSTO <= %Exp:mv_par06% AND
		SN3.N3_CCONTAB >= %Exp:mv_par07% AND 
		SN3.N3_CCONTAB <= %Exp:mv_par08% AND
		(SN3.N3_CLVL <> ' ' AND SN3.N3_CDEPREC <> ' ' AND SN3.N3_CCDEPR <> ' ') AND
		%Exp:cWhere% AND
		SN3.%notDel% AND
		SN1.N1_FILIAL = SN3.N3_FILIAL  AND
		SN1.N1_CBASE = SN3.N3_CBASE AND
		SN1.N1_ITEM = SN3.N3_ITEM AND
		SN1.%notDel%
	ORDER BY %Exp:cChave%
EndSql

oSection1:EndQuery()


oSection1:Cell("SIMBMOEDA1"):SetTitle("")
oSection2:Cell("SIMBMOEDA2"):SetTitle("")

While (cQuery)->(!Eof()) .And. !oReport:Cancel()

	If mv_par12 == 1 .And. lPrtFil .And. cCTHEmp=="E"
		If nGerOri1+nGerDepA1+nGerDepM1+nGerCD1+nGerCMon1+nGerOri2+nGerDepA2+nGerDepM2 > 0
			oSection1:Init()
			oSection2:Init()
			oReport:SkipLine()
			oReport:ThinLine()
			oSection1:Cell("N3_CLVL"):SetBlock({|| STR0016 } ) 	//"TOTAL FILIAL : "
			oSection1:Cell("N3_SUBCTA"):SetBlock({|| "" } )
			oSection1:Cell("N3_CCUSTO"):SetBlock({|| ""  } )
			oSection1:Cell("N3_CCONTAB"):SetBlock({|| ""  } )
			oSection1:Cell("N3_VORIG1"):SetBlock({|| nGerOri1 } )
			oSection1:Cell("N3_VRDACM1"):SetBlock({|| nGerDepA1 } )
			oSection1:Cell("N3_VRDMES1"):SetBlock({|| nGerDepM1 } )
			oSection1:Cell("N3_VRCDA1"):SetBlock({|| nGerCD1 } )
			oSection1:Cell("N3_VRCACM1"):SetBlock({|| nGerCMon1 } )
			oSection2:Cell("N3_VORIG"+cMoeda):SetBlock( { || nGerOri2 } )
			oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nGerDepA2 } )
			oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nGerDepM2 } )
			oSection1:PrintLine()
			oSection2:PrintLine()
			oReport:ThinLine()
			oReport:SkipLine()
			oSection1:Finish()
			oSection2:Finish()
			nGerOri1:=nGerDepA1:=nGerDepM1:=nGerCD1:=nGerCMon1:=nGerOri2:=nGerDepA2:=nGerDepM2:=nGerCD2:=nGerCMon2 := 0
		EndIf
		oReport:SkipLine()
		oFilial:Init()
		oFilial:Cell("Filial"):SetBlock({|| STR0018 + xFilial("CTH",(cQuery)->N3_FILIAL)}) //"Filial : "
		oFilial:PrintLine()
		oFilial:Finish()
		oReport:SkipLine()
		lPrtFil := .F.
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula por Classe de Valor ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cEntidade := (cQuery)->N3_CLVL

	While (cQuery)->(!Eof()) .And. ;
			(cQuery)->N3_CLVL == cEntidade .And.;
			! oReport:Cancel()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Acumula pela Conta Contabil do Bem ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cSubCta     := (cQuery)->N3_SUBCCON
		cCentroCus  := (cQuery)->N3_CUSTBEM
		cConta 		:= (cQuery)->N3_CCONTAB

		While (cQuery)->(!Eof()) .And.;
			 	(cQuery)->N3_CLVL == cEntidade .And.;
			 	(cQuery)->N3_SUBCCON == cSubCta .And.;
				(cQuery)->N3_CUSTBEM == cCentroCus .And.;
				(cQuery)->N3_CCONTAB == cConta .And.;
				! oReport:Cancel()
            
            // Verificação da classificação de Ativo se sofre depreciação
			lAtClDepr := AtClssVer((cAliasSn1)->N1_PATRIM)
			     
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Conta em Moeda 1    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliasSn1)->N1_PATRIM $ " P"
				nCtaVlOri1+= &((cQuery)+"->N3_VORIG"+alltrim(str(mv_par09)))
				nCtaDpAcm1+= &((cQuery)+"->N3_VRDACM"+alltrim(str(mv_par09)))
				nCtaDpMes1+= &((cQuery)+"->N3_VRDMES"+alltrim(str(mv_par09))) 
				nCtaCrDep1+= (cQuery)->N3_VRCDA1  
				nCtaCrMon1+= (cQuery)->N3_VRCACM1 
			Else
				nCtaVlOri1-= &((cQuery)+"->N3_VORIG"+alltrim(str(mv_par09)))
				nCtaDpAcm1-= &((cQuery)+"->N3_VRDACM"+alltrim(str(mv_par09)))
				nCtaDpMes1-= &((cQuery)+"->N3_VRDMES"+alltrim(str(mv_par09))) 
				nCtaCrDep1-= (cQuery)->N3_VRCDA1  
				nCtaCrMon1-= (cQuery)->N3_VRCACM1 
			Endif
                 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Conta em Moeda do Ativo³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliasSn1)->N1_PATRIM $ " P"
				nCtaVlOri2+= &((cQuery)+"->N3_VORIG"+cMoeda)
				nCtaDpAcm2+= &((cQuery)+"->N3_VRDACM"+cMoeda)
				nCtaDpMes2+= &((cQuery)+"->N3_VRDMES"+cMoeda)
				nCtaCrDep2+= IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)  
				nCtaCrMon2+= IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0) 
			Else
				nCtaVlOri2-= &((cQuery)+"->N3_VORIG"+cMoeda)
				nCtaDpAcm2-= &((cQuery)+"->N3_VRDACM"+cMoeda)
				nCtaDpMes2-= &((cQuery)+"->N3_VRDMES"+cMoeda)
				nCtaCrDep2-= IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)  
				nCtaCrMon2-= IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0) 
			Endif
                 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Centro de Custo em Moeda 1 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliasSn1)->N1_PATRIM $ " P"
				nValOri1 += &((cQuery)+"->N3_VORIG"+alltrim(str(mv_par09)))
				nDepAcm1 += &((cQuery)+"->N3_VRDACM"+alltrim(str(mv_par09)))
				nDepMes1 += &((cQuery)+"->N3_VRDMES"+alltrim(str(mv_par09))) 
				nCorDep1 += (cQuery)->N3_VRCDA1 
				nCorMon1 += (cQuery)->N3_VRCACM1
			Else
				nValOri1 -= &((cQuery)+"->N3_VORIG"+alltrim(str(mv_par09)))
				nDepAcm1 -= &((cQuery)+"->N3_VRDACM"+alltrim(str(mv_par09)))
				nDepMes1 -= &((cQuery)+"->N3_VRDMES"+alltrim(str(mv_par09))) 
				nCorDep1 -= (cQuery)->N3_VRCDA1 
				nCorMon1 -= (cQuery)->N3_VRCACM1
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Centro de Custo em Moeda do Ativo ³ 
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliasSn1)->N1_PATRIM $ " P"
				nValOri2 += &((cQuery)+"->N3_VORIG"+cMoeda)
				nDepAcm2 += &((cQuery)+"->N3_VRDACM"+cMoeda)
				nDepMes2 += &((cQuery)+"->N3_VRDMES"+cMoeda)
				nCorDep2 += IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)
				nCorMon2 += IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0)
			Else
				nValOri2 -= &((cQuery)+"->N3_VORIG"+cMoeda)
				nDepAcm2 -= &((cQuery)+"->N3_VRDACM"+cMoeda)
				nDepMes2 -= &((cQuery)+"->N3_VRDMES"+cMoeda)
				nCorDep2 -= IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)
				nCorMon2 -= IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0)
			Endif
			dbSelectArea(cQuery)
			cFilQryAnt := xFilial("CTH",(cQuery)->N3_FILIAL)
			dbSkip()
			If xFilial("CTH",(cQuery)->N3_FILIAL) <> cFilQryAnt
				lPrtFil := .T.
			EndIf
		End

		oSection1:Init()
		oSection2:Init()
		oSection1:Cell("N3_CLVL"):SetBlock({|| cEntidade } )
		oSection1:Cell("N3_SUBCTA"):SetBlock({|| cSubCta } )
		oSection1:Cell("N3_CCUSTO"):SetBlock({|| cCentroCus } )
		oSection1:Cell("N3_CCONTAB"):SetBlock({|| cConta  } )
		oSection1:Cell("N3_VORIG1"):SetBlock({|| nCtaVlOri1 } )
		oSection1:Cell("N3_VRDACM1"):SetBlock({|| nCtaDpAcm1 } )
		oSection1:Cell("N3_VRDMES1"):SetBlock({|| nCtaDpMes1 } )
		oSection1:Cell("N3_VRCDA1"):SetBlock({|| nCtaCrDep1 } )
		oSection1:Cell("N3_VRCACM1"):SetBlock({|| nCtaCrMon1 } )
		oSection2:Cell("N3_VORIG"+cMoeda):SetBlock( { || nCtaVlOri2 } )
		oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nCtaDpAcm2 } )
		oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nCtaDpMes2 } )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ ImpressÆo dos dados em questÆo  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection1:PrintLine()
		oSection2:PrintLine()

		oSection1:Finish()
		oSection2:Finish()

		dbSelectArea(cQuery)
		nCtaVlOri1:=nCtaDpAcm1:=nCtaDpMes1:=nCtaCrDep1:=nCtaCrMon1:= 0
		nCtaVlOri2:=nCtaDpAcm2:=nCtaDpMes2:=nCtaCrDep2:=nCtaCrMon2:= 0
	End

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Mostra Total da Entidade Base ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nValOri1 != 0 .Or. nDepAcm1 != 0 .Or. nValOri2 != 0 .Or. nDepAcm2 != 0
		oSection1:Init()
		oSection2:Init()
		oReport:SkipLine()
		oReport:ThinLine()
		oSection1:Cell("N3_CLVL"):SetBlock({|| "Tot " + CtbSayApro("CTH") } )
		oSection1:Cell("N3_SUBCTA"):SetBlock({|| "" } )
		oSection1:Cell("N3_CCUSTO"):SetBlock({|| cEntidade  } )
		oSection1:Cell("N3_CCONTAB"):SetBlock({|| ""  } )
		oSection1:Cell("N3_VORIG1"):SetBlock({|| nValOri1 } )
		oSection1:Cell("N3_VRDACM1"):SetBlock({|| nDepAcm1 } )
		oSection1:Cell("N3_VRDMES1"):SetBlock({|| nDepMes1 } )
		oSection1:Cell("N3_VRCDA1"):SetBlock({|| nCorDep1 } )
		oSection1:Cell("N3_VRCACM1"):SetBlock({|| nCorMon1 } )
		oSection2:Cell("N3_VORIG"+cMoeda):SetBlock( { || nValOri2 } )
		oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nDepAcm2 } )
		oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nDepMes2 } )
		oSection1:PrintLine()
		oSection2:PrintLine()
		oReport:SkipLine()
		oSection1:Finish()
		oSection2:Finish()
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula Total Filial/Geral em Moeda 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nGerOri1  += nValOri1
	nGerDepA1 += nDepAcm1
	nGerDepM1 += nDepMes1
	nGerCD1   += nCorDep1
	nGerCMon1 += nCorMon1
      
	nGerOri1T  += nValOri1
	nGerDepA1T += nDepAcm1
	nGerDepM1T += nDepMes1
	nGerCD1T   += nCorDep1
	nGerCMon1T += nCorMon1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula Total Filial/Geral em Moeda do Ativo³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nGerOri2  += nValOri2
	nGerDepA2 += nDepAcm2
	nGerDepM2 += nDepMes2
	nGerCD2   += nCorDep2
	nGerCMon2 += nCorMon2
      
	nGerOri2T  += nValOri2
	nGerDepA2T += nDepAcm2
	nGerDepM2T += nDepMes2
	nGerCD2T   += nCorDep2
	nGerCMon2T += nCorMon2

	nValOri1:=nDepAcm1:=nDepMes1:=nCorDep1:=nCorMon1:= 0
	nValOri2:=nDepAcm2:=nDepMes2:=nCorDep2:=nCorMon2:= 0

End

If nGerOri1+nGerDepA1+nGerDepM1+nGerCD1+nGerCMon1+nGerOri2+nGerDepA2+nGerDepM2 > 0 .And. mv_par12 == 1
	oSection1:Init()
	oSection2:Init()
	oReport:SkipLine()
	oReport:ThinLine()
	oSection1:Cell("N3_CLVL"):SetBlock({|| STR0016 } ) 	//"TOTAL FILIAL : "
	oSection1:Cell("N3_SUBCTA"):SetBlock({|| "" } )
	oSection1:Cell("N3_CCUSTO"):SetBlock({|| ""  } )
	oSection1:Cell("N3_CCONTAB"):SetBlock({|| ""  } )
	oSection1:Cell("N3_VORIG1"):SetBlock({|| nGerOri1 } )
	oSection1:Cell("N3_VRDACM1"):SetBlock({|| nGerDepA1 } )
	oSection1:Cell("N3_VRDMES1"):SetBlock({|| nGerDepM1 } )
	oSection1:Cell("N3_VRCDA1"):SetBlock({|| nGerCD1 } )
	oSection1:Cell("N3_VRCACM1"):SetBlock({|| nGerCMon1 } )
	oSection2:Cell("N3_VORIG"+cMoeda):SetBlock( { || nGerOri2 } )
	oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nGerDepA2 } )
	oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nGerDepM2 } )
	oSection1:PrintLine()
	oSection2:PrintLine()
	oReport:ThinLine()
	oSection1:Finish()
	oSection2:Finish()
EndIf

If nGerOri1T+nGerDepA1T+nGerDepM1T+nGerCD1T+nGerCMon1T+nGerOri2T+nGerDepA2T+nGerDepM2T > 0
	oSection1:Init()
	oSection2:Init()
	oReport:SkipLine(2)
	oReport:ThinLine()
	oSection1:Cell("N3_CLVL"):SetBlock({|| STR0007 } ) 	//"TOTAL GERAL       : "
	oSection1:Cell("N3_SUBCTA"):SetBlock({|| "" } )
	oSection1:Cell("N3_CCUSTO"):SetBlock({|| ""  } )
	oSection1:Cell("N3_CCONTAB"):SetBlock({|| ""  } )
	oSection1:Cell("N3_VORIG1"):SetBlock({|| nGerOri1T } )
	oSection1:Cell("N3_VRDACM1"):SetBlock({|| nGerDepA1T } )
	oSection1:Cell("N3_VRDMES1"):SetBlock({|| nGerDepM1T } )
	oSection1:Cell("N3_VRCDA1"):SetBlock({|| nGerCD1T } )
	oSection1:Cell("N3_VRCACM1"):SetBlock({|| nGerCMon1T } )
	oSection2:Cell("N3_VORIG"+cMoeda):SetBlock( { || nGerOri2T } )
	oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nGerDepA2T } )
	oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nGerDepM2T } )
	oSection1:PrintLine()
	oSection2:PrintLine()
	oReport:ThinLine()
	oSection1:Finish()
	oSection2:Finish()
Else
	oSection1:SetHeaderSection(.F.)
	oReport:PrintText(STR0017) //"Não há dados a serem Exibidos"
EndIf

//Gestão Corporativa - Início
For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])   
Next
//Gestão Corporativa - Fim

Return Nil