/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR180.CH"
#Include "Protheus.ch"

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.
Static lFWCodFil := .T.

// TRADUCAO DE CH'S PARA PORTUGAL
// TRADUCAO DE CH'S PARA PORTUGAL - 21/07/08

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR180    ³ Autor ³ Mario Angelo          ³ Data ³ 30.04.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de Bens Totalmente Depreciados                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR180()
Local oReport

PRIVATE cPerg    := PadR("ATR180", Len(SX1->X1_GRUPO) )

oReport:=ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³05/06/2006³±±
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
Local cReport := "ATFR180"
Local cAlias1 := "SN3"
Local cAlias2 := "SN1"
Local cTitulo := OemToAnsi(STR0003) // "Bens Depreciados"
Local cDescri := OemToAnsi(STR0001)+" "+OemToAnsi(STR0002) // "Este programa ir  emitir a rela‡„o dos Bens que j "  // "foram totalmente depreciados por %"
Local oSecFil	:= Nil

Pergunte( cPerg , .F. )

oReport  := TReport():New( cReport, cTitulo, "ATR180" , { |oReport| ReportPrint( oReport, cAlias1, cAlias2 ) }, cDescri )

oReport:SetUseGC(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0004, {cAlias1,cAlias2} )
oSection1:SetAutoSize(.T.)

TRCell():New( oSection1, "N3_CBASE"   , cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Codigo
TRCell():New( oSection1, "N3_ITEM"    , cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Item
TRCell():New( oSection1, "N3_TIPO"    , cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Item
TRCell():New( oSection1, "N3_TPSALDO" , cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Item
TRCell():New( oSection1, "N1_DESCRIC" , cAlias2 ,/*X3Titulo*/     ,/*Picture*/,,,,,.T.)	// Descricao
TRCell():New( oSection1, "N3_VORIG1"  , cAlias1 ,GetMV("MV_SIMB1"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Moeda 01
TRCell():New( oSection1, "N3_VORIG2"  , cAlias1 ,GetMV("MV_SIMB2"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Moeda 02
TRCell():New( oSection1, "N3_VORIG3"  , cAlias1 ,GetMV("MV_SIMB3"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Moeda 03
TRCell():New( oSection1, "N3_VORIG4"  , cAlias1 ,GetMV("MV_SIMB4"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Moeda 04
TRCell():New( oSection1, "N3_VORIG5"  , cAlias1 ,GetMV("MV_SIMB5"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Moeda 05
TRCell():New( oSection1, "N3_VRCACM1" , cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Correcao Acumulada
TRCell():New( oSection1, "N3_VRDACM1" , cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Depr Acumulada
TRCell():New( oSection1, "N3_VRCDA1"  , cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Corr Depr Acumul
TRCell():New( oSection1, "N3_AMPLIA1" , cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Vlr Ampliacao

/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SN3"})
TRCell():New(oSecFil,"CODFIL" ,,STR0021,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0022,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0023,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0024,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Filial"

oReport:SetLandScape()
oReport:DisableOrientation()

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
Local cQuery  := "SN3"
Local cAliasSn1 := "SN1"
Local cFiltro := ""
Local cChave  := ""
Local cWhere  := ""
Local cMoeda  := GetMv("MV_ATFMOED")
Local cN1TipoNeg := Alltrim(SuperGetMv("MV_N1TPNEG",.F.,"")) // Tipos de N1_PATRIM que aceitam Valor originais negativos
Local cN3TipoNeg := Alltrim(SuperGetMv("MV_N3TPNEG",.F.,"")) // Tipos de N3_TIPO que aceitam Valor originais negativos
Local cFilterUser:= ""
Local aClassif := {}
Local cClassif := ""
Local lAtfCusPrv := AFXAtCsPrv()
Local aSelFil	:= {}
Local aTmpFil	:= {}
Local cTmpFil	:= ""
Local cFilSN	:= ""
Local lSelFil	:= .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros       		³
//³ mv_par01            Do Bem                 		³
//³ mv_par02            Ate o Bem              		³
//³ mv_par03            Moeda 1                		³
//³ mv_par04            Moeda 2                		³
//³ mv_par05            Moeda 3                		³
//³ mv_par06            Moeda 4                		³
//³ mv_par07            Moeda 5                		³
//³ mv_par08            Cons. filiais abaixo ? 		³
//³ mv_par09                                   		³
//³ mv_par10            ZZ                     		³
//³ mv_par11            Selec Classif Patrimonial?	³
//³ mv_par12            Exibir Ativos Real. Provis?	³
//³ mv_par13            Seleciona filiais ?			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par11 == 1
	aClassif := AdmGetClass()
	If Len( aClassif ) <= 0
		Return
	EndIf
EndIf

	lSelFil := (FwSizeFilial() > 2)
	If lSelFil
		If MV_PAR13 == 1
			AdmSelecFil("ATR180",13,.F.,@aSelFil,"SN3",.F.)
		Endif
		If Empty(aSelFil)
			lSelFil := .F.
		Endif
	Endif

	cQuery := GetNextAlias()
	cAliasSn1 := cQuery
	cChave		:= "%" + SqlOrder( SN3->( IndexKey( 1 ) ) ) + "%"
	cWhere		:= "%"

	If lSelFil
		MsgRun(STR0026,STR0003,{|| cFilSN := GetRngFil(aSelFil,"SN3",.T.,@cTmpFil)}) //"Favor Aguardar..."###"Bens Depreciados"
		Aadd(aTmpFil,cTmpFil)
		cWhere += "SN3.N3_FILIAL " + cFilSN + " AND "
	Else
		If mv_par08 == 2
			cWhere += "SN3.N3_FILIAL = '" + xFilial("SN3") + "' AND "
		Else
			cWhere += "SN3.N3_FILIAL between '" + mv_par09 + "' AND '" + mv_par10 + "' AND "
		Endif
	Endif

	If Upper(AllTrim(mv_par01)) == Upper(AllTrim(mv_par02))
		cWhere += "SN3.N3_CBASE = '" + mv_par01 + "' AND "
	Else
		cWhere += "SN3.N3_CBASE BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' AND "
	EndIf
	cWhere += "SN3.N3_BAIXA = '0' AND "
	cWhere += "( SN3.N3_CDEPREC != ' ' OR SN3.N3_CDESP != ' ' OR SN3.N3_CCDEPR != ' ' ) AND "
	cWhere += "SN3.D_E_L_E_T_ = ' ' AND "
	cWhere += "SN1.N1_FILIAL = SN3.N3_FILIAL AND "

	//Filtra as classificações
	If Len(aClassif) > 0
			cWhere += " SN1.N1_PATRIM IN " + FORMATCLAS(aClassif,.T.) + " AND "
	EndIf

	If lAtfCusPrv .And. MV_PAR12 == 2
		cWhere += " SN3.N3_ATFCPR <> '1' AND "
	EndIf

	cWhere += "SN1.N1_CBASE = SN3.N3_CBASE AND "
	cWhere += "SN1.N1_ITEM = SN3.N3_ITEM AND "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cFilterUser := oSection1:GetSqlExp()
	If !Empty(cFilterUser)
		cWhere += cFilterUser + " AND "
	EndIf

	cWhere += "SN1.D_E_L_E_T_ = ' ' "
	cWhere += "%"

	oSection1:BeginQuery()

	BeginSql Alias cQuery
		SELECT
			SN3.N3_FILIAL, SN3.N3_CBASE, SN3.N3_ITEM, SN3.N3_TXDEPR1, SN3.N3_TIPO,
			SN3.N3_VORIG1, SN3.N3_VORIG2, SN3.N3_VORIG3, SN3.N3_VORIG4, SN3.N3_VORIG5,
			SN3.N3_VRCACM1, SN3.N3_VRDACM1, SN3.N3_VRDACM2, SN3.N3_VRDACM3, SN3.N3_VRDACM4,
			SN3.N3_VRDACM5, SN3.N3_VRCDA1, SN3.N3_AMPLIA1, SN3.N3_AMPLIA2, SN3.N3_AMPLIA3,
			SN3.N3_AMPLIA4,	SN3.N3_AMPLIA5, SN1.N1_DESCRIC, SN1.N1_PATRIM,SN3.N3_TPSALDO

		FROM
			%table:SN3% SN3, %table:SN1% SN1

		WHERE
			%Exp:cWhere%

		ORDER BY %Exp:cChave%
	EndSql

	oSection1:EndQuery()

oSection1:Cell("N3_VORIG1"):SetBlock( {|| (cQuery)->(N3_VORIG1+N3_AMPLIA1) })	// Moeda 01
oSection1:Cell("N3_VORIG2"):SetBlock( {|| (cQuery)->(N3_VORIG2+N3_AMPLIA2) })	// Moeda 02
oSection1:Cell("N3_VORIG3"):SetBlock( {|| (cQuery)->(N3_VORIG3+N3_AMPLIA3) })	// Moeda 03
oSection1:Cell("N3_VORIG4"):SetBlock( {|| (cQuery)->(N3_VORIG4+N3_AMPLIA4) })	// Moeda 04
oSection1:Cell("N3_VORIG5"):SetBlock( {|| (cQuery)->(N3_VORIG5+N3_AMPLIA5) })	// Moeda 05

oReport:SetTotalInLine(.F.)

If	mv_par03 != 1
	oSection1:Cell("N3_VORIG1"):Disable()
Else
	TRFunction():New ( oSection1:Cell("N3_VORIG1") , , "SUM" , , , , , .F. ,  )
EndIf
If	mv_par04 != 1
	oSection1:Cell("N3_VORIG2"):Disable()
Else
	TRFunction():New ( oSection1:Cell("N3_VORIG2") , , "SUM" , , , , , .F. ,  )
EndIf
If	mv_par05 != 1
	oSection1:Cell("N3_VORIG3"):Disable()
Else
	TRFunction():New ( oSection1:Cell("N3_VORIG3") , , "SUM" , , , , , .F. ,  )
EndIf
If	mv_par06 != 1
	oSection1:Cell("N3_VORIG4"):Disable()
Else
	TRFunction():New ( oSection1:Cell("N3_VORIG4") , , "SUM" , , , , , .F. ,  )
EndIf
If	mv_par07 != 1
	oSection1:Cell("N3_VORIG5"):Disable()
Else
	TRFunction():New ( oSection1:Cell("N3_VORIG5") , , "SUM" , , , , , .F. ,  )
EndIf

TRFunction():New ( oSection1:Cell("N3_VRCACM1") , , "SUM" , , , , , .F. ,  )
TRFunction():New ( oSection1:Cell("N3_VRDACM1") , , "SUM" , , , , , .F. ,  )
TRFunction():New ( oSection1:Cell("N3_VRCDA1" ) , , "SUM" , , , , , .F. ,  )
TRFunction():New ( oSection1:Cell("N3_AMPLIA1") , , "SUM" , , , , , .F. ,  )

oReport:Section(1):SetLineCondition({|| AfrSaldo(cQuery,cMoeda,cAliasSn1,cN1TipoNeg,cN3TipoNeg) <= 0 })

If lSelFil .And. Len(aSelFil) > 1
	oSection1:OnPrintLine({|| U_AFR180Fil(@aSelFil,oReport)})
Endif

oSection1:Print()

If !Empty(aTmpFil)
	MsgRun(STR0026,STR0003,{|| Aeval(aTmpFil,{|cTmpFil| CtbTmpErase(cTmpFil)})}) //"Favor Aguardar..."###"Bens Depreciados"
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AFR180FIL  ºAutor  ³                    º Data ³ 24/01/2014  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relacao das filiais selecionadas para o relatorio            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AFR180Fil(aSelFil,oReport)
Local oSecFil	:= Nil
Local aSM0		:= {}
Local nRegSM0	:= 0
Local nTamEmp	:= 0
Local nTamUnNeg	:= 0
Local nTamTit	:= 0
Local nX		:= 0
Local nLinha	:= 0
Local cTitulo 	:= ""

oReport:Section(1):OnPrintLine({|| })
oSecFil := oReport:Section("SECFIL")
nRegSM0 := SM0->(Recno())
aSM0 := FWLoadSM0()
SM0->(DbGoTo(nRegSM0))
nTamEmp := Len(FWSM0LayOut(,1))
nTamUnNeg := Len(FWSM0LayOut(,2))
cTitulo := oReport:Title()
oReport:SetTitle(cTitulo + " (" + STR0025 + ")")		//"Filiais selecionadas para o relatorio"
nTamTit := Len(oReport:Title())
oSecFil:Init()
oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})
For nX := 1 To Len(aSelFil)
	nLinha := Ascan(aSM0,{|sm0| sm0[SM0_GRPEMP] == cEmpAnt .And. sm0[SM0_CODFIL] == aSelFil[nX]})
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
Return()

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ AfrSaldo   ³ Autor ³ Claudio Donizete      ³ Data ³ 06.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ REtorna o saldo para impressao ou nao do bem                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AfrSaldo(cAliasSn3,cMoeda,cAliasSn1,cN1TipoNeg,cN3TipoNeg)
Local nSaldo := 0
	If cMoeda == "1"
		If (cAliasSn3)->N3_TIPO = "05" .Or. (cAliasSn1)->N1_PATRIM $ cN1TipoNeg .Or. (cAliasSn3)->N3_TIPO $ cN3TipoNeg
			nSaldo := (cAliasSn3)->(N3_VORIG1+N3_VRCACM1+N3_AMPLIA1+Abs(N3_VRDACM1+N3_VRCDA1))
		Else
			nSaldo := (cAliasSn3)->(N3_VORIG1+N3_VRCACM1+N3_AMPLIA1)-((cAliasSn3)->N3_VRDACM1+(cAliasSn3)->N3_VRCDA1)
		Endif
	Else
		If (cAliasSn3)->N3_TIPO = "05" .Or. (cAliasSn1)->N1_PATRIM $ cN1TipoNeg .Or. (cAliasSn3)->N3_TIPO $ cN3TipoNeg
			If cMoeda == "2"
				nSaldo := (cAliasSn3)->( N3_VORIG2 + N3_AMPLIA2 + Abs(N3_VRDACM2) )
			ElseIf cMoeda == "3"
				nSaldo := (cAliasSn3)->( N3_VORIG3 + N3_AMPLIA3 + Abs(N3_VRDACM3) )
			ElseIf cMoeda == "4"
				nSaldo := (cAliasSn3)->( N3_VORIG4 + N3_AMPLIA4 + Abs(N3_VRDACM4) )
			ElseIf cMoeda == "5"
				nSaldo := (cAliasSn3)->( N3_VORIG5 + N3_AMPLIA5 + Abs(N3_VRDACM5) )
			EndIf
		Else
			If cMoeda == "2"
				nSaldo :=(cAliasSn3)->( N3_VORIG2 + N3_AMPLIA2 - N3_VRDACM2 )
			ElseIf cMoeda == "3"
				nSaldo :=(cAliasSn3)->( N3_VORIG3 + N3_AMPLIA3 - N3_VRDACM3 )
			ElseIf cMoeda == "4"
				nSaldo :=(cAliasSn3)->( N3_VORIG4 + N3_AMPLIA4 - N3_VRDACM4 )
			ElseIf cMoeda == "5"
				nSaldo :=(cAliasSn3)->( N3_VORIG5 + N3_AMPLIA5 - N3_VRDACM5 )
			EndIf
		Endif
	Endif
Return nSaldo