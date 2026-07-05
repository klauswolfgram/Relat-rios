/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR260.CH"
#Include "Protheus.ch"


// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR260  ³ Autor ³Carlos A. Gomes Jr.    ³ Data ³ 05.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relat¢rio de Amplia‡”es                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR260                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR260
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR210   ºAutor  ³Carlos A. Gomes Jr. º Data ³  06/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport,oSection1
Local cReport  := "ATFR260"
Local cTitulo  := OemToAnsi(STR0003) // "AMPLIACOES"
Local cDescri  := OemToAnsi(STR0001)+" "+OemToAnsi(STR0002) // "Este relatorio ir   imprimir as ampliacoes dos bens dentro" ## "dos parametros especificados."
Local oSecFil //Gestao Corporativa
Local nTamMasc :=Len(GetMV("MV_MASCARA"))//PARA CASO O TAMANHO SEJA DIFERENTE CONCATENAR Tamanho_Campo+Tamanho_Mascara
Pergunte( "AFR260" , .F. )

cMoedaDesc:=GetMV("MV_MOEDA"+StrZero(MV_PAR07+1,1))

oReport  := TReport():New( cReport, cTitulo, "AFR260" , { |oReport| ATFR260Imp( oReport ) }, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0011 , {"SN4","SN3","SN1"} )		//"Bens Ampliados"
TRCell():New( oSection1, "N4_CBASE"   , "SN4"   ,/*X3Titulo*/      	,/*Picture*/,TamSx3("N4_CBASE")[1],/*lPixel*/,/*{|| code-block de impressao }*/)	// Codigo
TRCell():New( oSection1, "N4_ITEM"    , "SN4"   ,/*X3Titulo*/      	,/*Picture*/,TamSx3("N4_ITEM")[1],/*lPixel*/,/*{|| code-block de impressao }*/)	// Item
TRCell():New( oSection1, "N4_TIPO"    , "SN4"   ,/*X3Titulo*/      	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Tipo
TRCell():New( oSection1, "N1_DESCRIC" , "SN1"   ,/*X3Titulo*/      	,/*Picture*/,TamSx3("N1_DESCRIC")[1]-10/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Descricao
TRCell():New( oSection1, "N4_DATA"    , "SN4"   ,/*X3Titulo*/      	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Data
TRCell():New( oSection1, "N3_CCONTAB" , "SN4"   ,/*X3Titulo*/      	,/*Picture*/,TamSx3("N3_CCONTAB")[1] + nTamMasc,/*lPixel*/,/*{|| code-block de impressao }*/)	// Conta Contabil
TRCell():New( oSection1, "N4_VLROC1"  , "SN4"   ,/*X3Titulo*/      	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	//Valor da Ampliacao
TRCell():New( oSection1, "nValAtual"  ,/*Alias*/,STR0008					,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Atualizado
TRCell():New( oSection1, "nVLROC"     ,/*Alias*/,STR0009+CRLF+cMoedaDesc ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"RIGHT",,,.F.)	// Valor Ampliacao outra moeda
TRCell():New( oSection1, "nVORIG"     ,/*Alias*/,STR0010+CRLF+cMoedaDesc ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"RIGHT",,,.F.)	// Valor Atualizado outra moeda
oSection1:SetHeaderPage()
oSection1:SetColSpace(1)

//Gestão Corporativa - Início
oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0013,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0014,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0015,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0016,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

oReport:SetUseGC(.F.)
//Gestão Corporativa - Fim

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR260ImpºAutor  ³Carlos A. Gomes Jr. º Data ³  06/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFR260Imp( oReport )

Local oSection1 := oReport:Section(1)
Local cQuery := ""
Local cChave := ""

Local cAliasSN3 := "SN3"
Local cAliasSN4 := "SN4"


Local nMoeda     := mv_par07 + 1
Local cMoeda     := StrZero(nMoeda,1)
Local cMoedaDesc := SuperGetMV("MV_MOEDA"+cMoeda)

//Gestao Corporativa - Inicio
Local oBreak
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

If (lSN4Excl .and. mv_par08 == 1)
	If FindFunction("AdmSelecFil")
		AdmSelecFil("ATR260",8,.F.,@aSelFil,"SN4",.F.)
	Else
		aSelFil := AdmGetFil(.F.,.F.,"SN4")
	Endif
Endif

If mv_par08 == 1 .And. !Empty(aSelFil)
	aSort(aSelFil)
	oSection1:SetHeaderSection(.F.)
	SM0->(DbGoTo(nRegSM0))
	aSM0 := FWLoadSM0()
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0017 +  ")")	//"Filiais selecionadas para o relatorio"
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
	cFilSN4 := " N4_FILIAL = '"+ xFilial("SN4") + "' AND "
Else
	cRngFilSN4 := GetRngFil(aSelFil,"SN4",.T.,@cTmpSN4Fil)
	aAdd(aTmpFil,cTmpSN4Fil)
	cFilSN4 := " N4_FILIAL "+ cRngFilSN4 + " AND "
Endif

cFilSN4 := "%"+cFilSN4+"%"
//Gestao Corporativa - Fim

cChave    := "%"+SqlOrder("N4_FILIAL+N4_CBASE+N4_ITEM+N4_TIPO+N4_DATA")+"%"
cQuery    := GetNextAlias()
cAliasSN3 := cQuery
cAliasSN4 := cQuery

oSection1:BeginQuery()
BeginSql Alias cQuery
	SELECT
		N4_FILIAL, N4_CBASE, N4_ITEM, N4_TIPO, N4_DATA,
		N4_VLROC1, N4_VLROC2, N4_VLROC3, N4_VLROC4, N4_VLROC5,
		N3_CCONTAB, N3_VRCACM1, N3_AMPLIA1,
		N3_VORIG1, N3_VORIG2, N3_VORIG3, N3_VORIG4, N3_VORIG5,
		N1_DESCRIC
	FROM
		%table:SN4% SN4, %table:SN3% SN3, %table:SN1% SN1
	WHERE %exp:cFilSN4%
		SN4.N4_CBASE  >= %Exp:mv_par01% AND
		SN4.N4_CBASE  <= %Exp:mv_par02% AND
		SN4.N4_DATA   >= %Exp:mv_par03% AND
		SN4.N4_DATA   <= %Exp:mv_par04% AND
		SN4.N4_CONTA  >= %Exp:mv_par05% AND
		SN4.N4_CONTA  <= %Exp:mv_par06% AND
		SN4.N4_OCORR  = '09' AND
		SN4.%notDel% AND
		SN3.N3_FILIAL = SN4.N4_FILIAL AND
		SN3.N3_CBASE  = SN4.N4_CBASE AND
		SN3.N3_ITEM   = SN4.N4_ITEM AND
		SN3.N3_TIPO   = SN4.N4_TIPO AND
		SN3.N3_SEQ    = SN4.N4_SEQ AND
        (SN3.N3_AMPLIA1 <> 0 OR SN3.N3_TIPO = '11') AND 
		SN3.%notDel% AND
		SN1.N1_FILIAL = SN4.N4_FILIAL AND
		SN1.N1_CBASE = SN4.N4_CBASE AND
		SN1.N1_ITEM  = SN4.N4_ITEM AND
		SN1.%notDel%
	ORDER BY %Exp:cChave%
EndSql
oSection1:EndQuery()

If mv_par08 == 1
	oReport:PrintText(STR0012 + (cAliasSN4)->N4_FILIAL) //"Filial : "
	oReport:SkipLine()
	oBreak := TRBreak():New(oSection1,{|| (cAliasSN4)->N4_FILIAL})
	oBreak:OnBreak({|| oReport:SkipLine(2)})
	oBreak:OnPrintTotal({|| IIf(!(cAliasSN4)->(EOF()),oReport:PrintText(STR0012 + (cAliasSN4)->N4_FILIAL),"")}) //"Filial : "
EndIf

oSection1:Init()
cChaveant :=  (cAliasSN4)->N4_FILIAL + (cAliasSN4)->N4_CBASE + (cAliasSN4)->N4_ITEM
nValorOriginal := 0
nValorOutraMoeda := 0
nAmpAcumul := 0
Do While !(cAliasSN4)->(EOF()) .And. !oReport:Cancel()

	If (cAliasSN4)->N4_TIPO =='11'  
		IF nValorOriginal == 0
			SN3->(dbSetOrder(1))//N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO+N3_BAIXA+N3_SEQ
			If SN3->(MsSeek( (cAliasSN4)->N4_FILIAL + (cAliasSN4)->N4_CBASE + (cAliasSN4)->N4_ITEM +'01'+"0" ))
				nValorOriginal := SN3->N3_VORIG1
				nValorOutraMoeda := &("SN3->N3_VORIG" + cMoeda ) 
			EndIF
		EndIf
	ELSE	
		nAmpAcumul := N3_AMPLIA1
	EndIF

	oSection1:Cell("N3_CCONTAB"):SetBlock({|| Mascara((cAliasSN3)->N3_CCONTAB) })
	oSection1:Cell("nValAtual"):SetBlock({|| (cAliasSN3)->( N3_VORIG1 + N3_VRCACM1 + If( (cAliasSN4)->N4_TIPO =='11',nValorOriginal+nAmpAcumul, N3_AMPLIA1 )) })
	oSection1:Cell("N4_VLROC1"):SetPicture( PesqPict("SN4","N4_VLROC1",18,1) ) //Valor da Ampliacao 
	oSection1:Cell("nValAtual"):SetPicture( PesqPict("SN3","N3_VORIG1",18,1) )

	oSection1:Cell("nVLROC"):SetBlock({|| &( cAliasSN4 + "->N4_VLROC" + cMoeda ) })
	oSection1:Cell("nVLROC"):SetTitle( OemToAnsi(STR0009)+CRLF+cMoedaDesc )
	oSection1:Cell("nVLROC"):SetPicture( PesqPict("SN4","N4_VLROC"+cMoeda,18,nMoeda) )

	oSection1:Cell("nVORIG"):SetBlock({||If((cAliasSN4)->N4_TIPO =='11' , nValorOutraMoeda ,&( cAliasSN3 + "->N3_VORIG" + cMoeda )) }) 
	oSection1:Cell("nVORIG"):SetTitle( OemToAnsi(STR0010)+CRLF+cMoedaDesc )
	oSection1:Cell("nVORIG"):SetPicture( PesqPict("SN3","N3_VORIG"+cMoeda,18,nMoeda) )

	oSection1:PrintLine() 
	
	If (cAliasSN4)->N4_TIPO =='11'
		nAmpAcumul += (cAliasSN3)->N3_VORIG1 
	EndIF

	(cAliasSN4)->(dbSkip())
	If cChaveant != (cAliasSN4)->N4_FILIAL + (cAliasSN4)->N4_CBASE + (cAliasSN4)->N4_ITEM
		cChaveant :=  (cAliasSN4)->N4_FILIAL + (cAliasSN4)->N4_CBASE + (cAliasSN4)->N4_ITEM
		nValorOriginal := 0
		nValorOutraMoeda := 0
		nAmpAcumul := 0
	EndIF
EndDo

oSection1:Finish()

//Gestão Corporativa - Início
For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])
Next
//Gestão Corporativa - Fim

Return
