/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "FINR820.CH"
#Include "PROTHEUS.CH"

#DEFINE TOTSALDO	1
#DEFINE TOTJUROS	2
#DEFINE TOTIOF		3
#DEFINE TOTIR		4
#DEFINE TOTAPL		5

#DEFINE APLCONTR	1	// Número do Contrato
#DEFINE APLBANCO	2	// Número do Banco
#DEFINE APLAGENC	3	// Número da Agência
#DEFINE APLCOTVR	4	// Valor da Cota Contrato
#DEFINE APLSALDO	5	// Saldo do Contrato
#DEFINE APLVCDIA	6	// Valor da Cota em determinada data
#DEFINE APLCONTA	7	// Número da Conta

/*/{Protheus.doc} Finr820
Impressao relatorio de Aplicacoes Financeiras

@author Eduardo Riera
@since 03/04/98
/*/
User Function FinR820()
	Local oReport

	oReport:=ReportDef()
	oReport:PrintDialog()

Return

/*/{Protheus.doc} ³ReportDef
A funcao estatica ReportDef devera ser criada para todos os
relatorios que poderao ser agendados pelo usuario. 

@author Claudio D. de Souza
@since 24/07/2006
@return ExpO1: Objeto do relatório     
/*/
Static Function ReportDef()

	Local oReport 	As Object
	Local oSection1 As Object 
	Local oSection2 As Object	//Gestão Corporativa
	Local oSecFil   As Object	//Gestão Corporativa
	Local cReport 	As Character
	Local cAlias1 	As Character
	Local cTitulo 	As Character
	Local cDescri 	As Character
	Local bReport 	As Block 

	cReport := "FINR820"
	cAlias1 := "SEH"
	cTitulo := STR0003 // "Demonstrativo de Aplicacoes"
	cDescri := STR0001 + " " + " " + STR0003 // "Este programa tem como objetivo imprimir o valor atualizado das aplicacoes financeiras, conforme os parametros solicitados. "
	bReport := { |oReport|	ReportPrint( oReport ) }

	Pergunte("FIR820",.F.)

	oReport  := TReport():New( cReport, cTitulo, "FIR820" , bReport, cDescri )
	oReport:DisableOrientation()
	oReport:SetLandScape(.T.)
	//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
	oSection1 := TRSection():New( oReport,STR0025, {cAlias1} )

	TRCell():New(oSection1,"EH_NUMERO","SEH",,,TamSx3("EH_NUMERO")[1]+2)
	TRCell():New(oSection1,"EH_REVISAO","SEH",,,TamSx3("EH_REVISAO")[1])
	TRCell():New(oSection1,"EH_NBANCO","SEH",,,TamSx3("EH_NBANCO")[1])
	TRCell():New(oSection1,"EH_TIPO","SEH",,,TamSx3("EH_TIPO")[1])
	TRCell():New(oSection1,"EH_DATA","SEH",,,TamSx3("EH_DATA")[1])
	TRCell():New(oSection1,"EH_DATARES","SEH",,,TamSx3("EH_DATARES")[1])
	TRCell():New(oSection1,"EH_SALDO","SEH",,,TamSx3("EH_SALDO")[1])
	TRCell():New(oSection1,"EH_VLRCOTA","SEH",STR0018,PesqPict("SEH","EH_VLRCOTA"),TamSx3("EH_VLRCOTA")[1]) // "Cota Util. Apl"
	TRCell():New(oSection1,"COTA ATUAL","SEH",STR0019,PesqPict("SEH","EH_QUOTAS"),TamSx3("EH_QUOTAS")[1]+1) // "Cota atual"
	TRCell():New(oSection1,"RENDIMENTO BRUTO","SEH",STR0020,TM(SEH->EH_VALCRED,14,2),TamSx3("EH_VALCRED")[1]) // "Rendimento Bruto"
	TRCell():New(oSection1,"PERC REND BRUTO","SEH",STR0021,"@E 999.999999%",12) // "Perc."
	TRCell():New(oSection1,"EH_TAXAIOF","SEH",STR0022,"@E 99.99%",TamSx3("EH_TAXAIOF")[1]) // "Taxa de IOF"
	TRCell():New(oSection1,"EH_VALIOF","SEH",STR0023,PesqPict("SEH","EH_VALIOF")/*"@E@Z 999,999,999.99"*/,15) // "Valor do IOF"
	TRCell():New(oSection1,"EH_TAXAIRF","SEH",,PesqPict("SEH","EH_TAXAIRF"),TamSx3("EH_TAXAIRF")[1])
	TRCell():New(oSection1,"EH_VALIRF","SEH",,PesqPict("SEH","EH_VALIRF"),TamSx3("EH_VALIRF")[1])
	TRCell():New(oSection1,"EH_VALCRED","SEH",STR0024,PesqPict("SEH","EH_VALCRED"),TamSx3("EH_VALCRED")[1]) // "Resgate liquido"

	//Gestão Corporativa - Início
	oSection2 := TRSection():New(oReport,"",{cAlias1})
	TRCell():New(oSection2,"Filial",,,,TamSx3("EH_FILIAL")[1]+Len(STR0026)) //"Filial : "
	oSection2:SetHeaderSection(.F.)

	oSecFil := TRSection():New(oReport,"SECFIL",{})
	TRCell():New(oSecFil,"CODFIL" ,,STR0027,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
	TRCell():New(oSecFil,"EMPRESA",,STR0028,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
	TRCell():New(oSecFil,"UNIDNEG",,STR0029,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
	TRCell():New(oSecFil,"NOMEFIL",,STR0030,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

	oReport:SetUseGC(.F.)
	//Gestão Corporativa - Fim

Return oReport

/*/{Protheus.doc} ³ReportPrint
Query de impressao do relatorio

@author Claudio D. de Souza
@since 24/07/2006   
/*/
Static Function ReportPrint( oReport )
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2) //Gestão Corporativa
Local cQuery		:= "SEH"
Local cWhere		:= ""
Local cAplCotas   	:= GetMv("MV_APLCAL4")
Local nDias
Local aAplic 		:= {}
Local cTabIrf		:= "AR"
Local aTabIrf		:= {    { 180, 22.5 },;
							{ 360, 20.0 },;
							{ 720, 17.5 },;
							{ 1000000, 15.0 } }
//Gestão Corporativa - Início
Local lGestao   	:= AdmGetGest() 	// Indica se usa Gestao Corporativa
Local lQuery 		:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
Local lSEHExcl  	:= Iif( lGestao, FWModeAccess("SEH",1) == "E", FWModeAccess("SEH",3) == "E")
Local cSEHFil  		:= FWModeAccess("SEH",3)
Local cSEHUN   		:= FWModeAccess("SEH",2)
Local cSEHEmp  		:= FWModeAccess("SEH",1)
Local aTmpFil		:= {}
Local cTmpSEHFil 	:= ""
Local nX 			:= 1
Local oSecFil		:= oReport:Section("SECFIL")
Local nRegSM0		:= SM0->(Recno())
Local aSelFil 		:= {}
Local cRngFilSEH 	:= ""
Local cFilSel 		:= ""
Local cOrder 		:= ""
Local nC 			:= 1
Local cUNold 		:= ""
Local cEmpOld 		:= ""
Local cFilialAnt 	:= cFilAnt
Local aValDtRef		:= {}
Local lRecalc       := .F.
Local dDtRef		:= Iif(Empty(MV_PAR01), dDatabase, MV_PAR01)
local cMvAplica1	:= SuperGetMV("MV_APLCAL1", .F., "")
Local aValores      															as	array
Local nQtdCotasResgate															as	numeric
Local nVlrLiquidoCr 															as	numeric
Local nRendimentoMes															as	numeric
Local nVlrfr820CSaldo															as	numeric
Local dDtResg																	as	date
Local lProcAPLCAL4																as	logical	
Local nIofAplAtu																as	numeric
Local nIRRdBruto																as	numeric
Local nPercRendimento   														as	numeric

nRegSM0 			:= 	SM0->(Recno())
aValores      		:= 	{}
nQtdCotasResgate	:= 	0
nVlrLiquidoCr 		:=	0
nRendimentoMes		:=	0
nVlrfr820CSaldo		:=	0
dDtResg				:=	CToD( '  /  /  ' )
lProcAPLCAL4		:=	.F.	
nIofAplAtu			:=	0
nIRRdBruto			:=	0
nPercRendimento   	:= 	0

If (lQuery .and. lSEHExcl .and. mv_par07 == 1)
	If !IsBlind() .And. (FindFunction("FwSelectGC") .AND. lGestao)
		aSelFil := FwSelectGC()	
	ElseIf FindFunction("GetParAuto")
		aSelFil := GetParAuto("FINR610TestCase")
	Else
		aSelFil := AdmGetFil(.F.,.F.,"SEH")
	Endif
	aSort(aSelFil)
Endif

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

SM0->(DbGoTo(nRegSM0))

If Len(aSelFil) > 1
	cRngFilSEH := GetRngFil(aSelFil,"SEH",.T.,@cTmpSEHFil)
	aAdd(aTmpFil,cTmpSEHFil)
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0031 + ")")	//"Filiais selecionadas para o relatorio"
	nTamTit := Len(oReport:Title())
	oSecFil:Init()
	oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
	oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
	oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
	oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})

	For nX := 1 To Len(aSelFil)
		nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[nX]})
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
Endif

cQuery := GetNextAlias()

If MV_PAR06 == 2
	if mv_par05 = 1
		cWhere += "(EH_MOEDA = " + Alltrim(Str(mv_par05)) + " OR EH_TIPO in "+ FormatIn(StrTran(cMvAplica1,'"',''),'|/,') +") AND "	
	else
		cWhere := "EH_MOEDA = " + Alltrim(Str(mv_par05)) + " AND "	
	endIf 
Endif

If !Empty(mv_par01)
	cWhere += "EH_DATA <= '" + DToS(mv_par01) + "' AND "
EndIf

cWhere := "%" + cWhere + "%"
cOrder := "%" + "ORDER BY EH_FILIAL,EH_NUMERO,EH_REVISAO" + "%"

oBreak := TRBreak():New(oSection1,{|| (cQuery)->EH_FILIAL},STR0033,.F.) //"Total Filial : "

TRFunction():New(oSection1:Cell("EH_SALDO"),,"SUM",oBreak,,,,.F.,.T.)
TRFunction():New(oSection1:Cell("RENDIMENTO BRUTO"),,"SUM",oBreak,,,,.F.,.T.)
TRFunction():New(oSection1:Cell("EH_VALIOF"),,"SUM",oBreak,,,,.F.,.T.)
TRFunction():New(oSection1:Cell("EH_VALIRF"),,"SUM",oBreak,,,,.F.,.T.)
TRFunction():New(oSection1:Cell("EH_VALCRED"),,"SUM",oBreak,,,,.F.,.T.)

oReport:SkipLine()

For nC := 1 To Len(aSelFil) Step 1
	cFilAnt := aSelFil[nC]
	cFil := FWCodFil()
	cUN  := FWUnitBusiness()
	cEmp := FWCodEmp()
	cUNold := cUN
	cEmpOld := cEmp
	cXFil := xFilial("SEH",cFilAnt)

	oSection1:BeginQuery()
	BeginSql Alias cQuery
		SELECT
			SEH.*
		FROM %table:SEH% SEH
		WHERE SEH.EH_FILIAL = %Exp:cXFil% AND
			SEH.EH_BANCO >= %Exp:mv_par03% AND
			SEH.EH_BANCO <= %Exp:mv_par04% AND
			SEH.EH_APLEMP = 'APL' AND
			%Exp:cWhere%
			SEH.%notDel%
			%Exp:cOrder%
	EndSql
	oSection1:EndQuery()

	bOnPrintLine := { || SEH->(MsGoto((cQuery)->R_E_C_N_O_)),;
		lProcAPLCAL4 := SEH->EH_TIPO $ cAplCotas,;
		nDias := Iif(Empty(MV_PAR01),dDataBase,MV_PAR01) - SEH->EH_DATA,;
		nTaxaIrf := If(Empty(SEH->EH_TAXAIRF), If(SX5->(MsSeek(xFilial("SX5")+"AR")),;
			Val(TabelaIrf(cTabIrf,nDias)),aTabIrf[Ascan( aTabIrf, { |e| e[1] >= nDias } )][2]),SEH->EH_TAXAIRF),;
		lRecalc	:= !Empty(SEH->EH_DATARES) .and. SEH->EH_DATARES > dDtRef,;
		aValDtRef := iif(lRecalc,F820DtRf((cQuery)->EH_APLEMP, (cQuery)->EH_NUMERO, (cQuery)->EH_REVISAO),{}),;
		aValores := iif(!lProcAPLCAL4,aValDtRef,( nVlrfr820CSaldo := fr820CSaldo( cAplCotas, SEH->EH_SALDO, @dDtResg, @nQtdCotasResgate, @nVlrLiquidoCr, @nRendimentoMes, nTaxaIrf, nDias, @nIofAplAtu, @nIRRdBruto, @nPercRendimento ), { nVlrfr820CSaldo, dDtResg, nQtdCotasResgate, nVlrLiquidoCr, nRendimentoMes, nIofAplAtu, nIRRdBruto, nPercRendimento } ) ),;
		aCalculo := Fr820Calc( cAplCotas, @aAplic, iif(lRecalc .And. !lProcAPLCAL4, aValDtRef[1], SEH->EH_SALDO ) ) }

	If mv_par07 == 1 .And. !(cQuery)->(EOF())
		oSection2:Init()
		oSection2:Cell("Filial"):SetBlock({|| STR0032 + xFilial("SEH")}) //Gestão Corporativa - "Filial : "
		oSection2:PrintLine()
		oReport:SkipLine()
		oSection2:Finish()
	EndIf

	If !(cQuery)->(EOF())		

		oSection1:Init()
		oSection1:OnPrintLine(bOnPrintLine)
		oSection1:Cell("EH_DATARES"):SetBlock(       {|| Iif( lProcAPLCAL4, aValores[ 2 ], iif( lRecalc, aValDtRef[ 2 ], SEH->EH_DATARES ) ) } )
		oSection1:Cell("EH_SALDO"):SetBlock(         {|| Iif( lProcAPLCAL4, aValores[ 1 ], iif( lRecalc, xMoeda( aValDtRef[ 1 ], 1, MV_PAR05 ), SEH->EH_SALDO ) ) } )   
		oSection1:Cell("EH_VLRCOTA"):SetBlock(       {|| Iif( SEH->EH_TIPO $ cAplCotas, SEH->EH_VLRCOTA, 0 ) } )
		oSection1:Cell("COTA ATUAL"):SetBlock(       {|| Iif( SEH->EH_TIPO $ cAplCotas, Fr820Cota( aAplic ), 0 ) } )
		oSection1:Cell("EH_TAXAIOF"):SetBlock(       {|| Iif( Empty( SEH->EH_TAXAIOF ) .And. nDias > 0 .And. nDias < 30, Val( TABELA( "A0", StrZero( nDias, 2 ) ) ), SEH->EH_TAXAIOF ) } )
		oSection1:Cell("EH_VALIOF"):SetBlock(        {|| Iif( lProcAPLCAL4, aValores[ 6 ], xMoeda(aCalculo[ 3 ], 1, MV_PAR05 ) ) } )
		oSection1:Cell("EH_TAXAIRF"):SetBlock(       {|| nTaxaIrf })
		oSection1:Cell("EH_VALIRF"):SetBlock(        {|| Iif( lProcAPLCAL4, aValores[ 7 ], xMoeda( aCalculo[ 2 ], 1, MV_PAR05 ) ) } )
		oSection1:Cell("RENDIMENTO BRUTO"):SetBlock( {|| Iif( lProcAPLCAL4, aValores[ 5 ], xMoeda( aCalculo[ 5 ], 1, MV_PAR05 ) ) } )
		oSection1:Cell("PERC REND BRUTO"):SetBlock(  {|| Iif( lProcAPLCAL4, aValores[ 8 ], ( xMoeda( aCalculo[5], 1, MV_PAR05 ) / aCalculo[ 1 ] ) * 100 ) } )
		oSection1:Cell("EH_VALCRED"):SetBlock(       {|| Iif( lProcAPLCAL4, aValores[ 4 ], iif(lRecalc, xMoeda( aValDtRef[ 1 ], 1, MV_PAR05 ) + xMoeda( aCalculo[ 5 ], 1, MV_PAR05 ), xMoeda( aCalculo[ 1 ], 1, MV_PAR05 ) ) - ( xMoeda( aCalculo[ 2 ] + aCalculo[ 3 ] + aCalculo[ 4 ], 1, mv_par05 ) ) ) } )// Resgate líquido = Saldo + rendimento bruto - impostos		
		oReport:SetTotalInLine(.F.)
		oSection1:SetLineBreak(.T.)
		oSection1:Print()
		oSection1:Finish()
	EndIf

	If cSEHEmp == "E" .And. cSEHUN == "E" .And. cSEHFil == "C" .And. MV_PAR07 == 1
		While cUN == cUNold
			nC += 1
			If nC > Len(aSelFil)
				cUN := ""
			Else
				cFilAnt := aSelFil[nC]
				cUN := FWUnitBusiness()
			EndIf
		EndDo
	EndIf

	If cSEHEmp == "E" .And. cSEHUN == "C" .And. cSEHFil == "C" .And. MV_PAR07 == 1
		While cEmp == cEmpOld
			nC += 1
			If nC > Len(aSelFil)
				cEmp := ""
			Else
				cFilAnt := aSelFil[nC]
				cEmp := FWCodEmp()
			EndIf
		EndDo
	EndIf

	If cSEHEmp == "C" .And. cSEHUN == "C" .And. cSEHFil == "C" .And. MV_PAR07 == 1
		nC := Len(aSelFil) + 2
	EndIf

	If cSEHEmp == "E" .And. cSEHUN == "E" .And. cSEHFil == "E" .And. MV_PAR07 == 1
		Loop
	Else
		If Len(aSelFil) > 1
			nC -= 1
		EndIf
	EndIF
Next

For nX := 1 To Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])
Next

cFilAnt := cFilialAnt

Return

/*/{Protheus.doc} ³ReportPrint
Calculo dos valores a serem impressos  

@author Claudio D. de Souza
@since 24/07/2006   
/*/
Static Function Fr820Calc(cAplCotas,aAplic,nValorBase)
Local aRet			:= {0,0,0,0,0,0,0}
Local aArea			:= GetArea()
Local aAreaSE9		:= SE9->(GetArea())
Local cAliasSE0		:= GetNextAlias()
Local cData			:= ""

If !(SEH->EH_TIPO $ cAplCotas)	
	aRet := Fa171Calc(IIf(!Empty(MV_PAR01),MV_PAR01,SEH->EH_DATARES),nValorBase,MV_PAR02==1,,SEH->EH_ULTAPR,,,,,,,.T.)

	//Arredondando para as casas decimais esperadas nos casos de testes e relatorio, pois em situacoes que retornam mais que o previsto apresenta erro nessas funcionaldiades
	If Len( aRet ) >= 11
		aRet[ 2 ]	:=	Round( aRet[ 2 ], 6 )
		aRet[ 6 ]	:=	Round( aRet[ 6 ], 6 )

	EndIf
	
Else
	aRet := {0,0,0,0,0,0,0}
	SE9->(DbSetOrder(1))
	SE9->(MsSeek(xFilial()+SEH->(EH_CONTRAT+EH_BCOCONT+EH_AGECONT+EH_CTACONT)))
	cData := Dtos(IIf(!Empty(MV_PAR01),MV_PAR01,dDatabase))

	BeginSQL Alias cAliasSE0
		SELECT SE0.E0_DATA,SE0.E0_VALOR
		FROM	%Table:SE0% SE0
		WHERE	SE0.E0_FILIAL = %XFilial:SE0%
		AND SE0.E0_BANCO = %Exp:SE9->E9_BANCO%
		AND SE0.E0_AGENCIA = %Exp:SE9->E9_AGENCIA%
		AND SE0.E0_CONTA = %Exp:SE9->E9_CONTA%
		AND SE0.E0_CONTRAT = %Exp:SE9->E9_NUMERO%
		AND SE0.E0_DATA <= %Exp:cData%
		AND SE0.%NotDel%
		ORDER BY SE0.E0_DATA DESC
	EndSQL

	If !(cAliasSE0)->(Eof())
		Aadd(aAplic,{	SEH->EH_CONTRAT,SEH->EH_BCOCONT,SEH->EH_AGECONT, (cAliasSE0)->E0_VALOR,0,0,SEH->EH_CTACONT})
	EndIf

	(cAliasSE0)->(DbCloseArea())
EndIf

SE9->(RestArea(aAreaSE9))
RestArea(aArea)

Return aRet

/*/{Protheus.doc} ³ReportPrint
Calculo dos valor da cota a ser impressa 

@author Claudio D. de Souza
@since 24/07/2006   
/*/
Static Function Fr820Cota(aAplic)
Local nAscan
Local nRet

nAscan := Ascan(aAplic, {|e|	e[APLCONTR] == SEH->EH_CONTRAT .AND.;
								e[APLBANCO] == SEH->EH_BCOCONT .AND.;
								e[APLAGENC] == SEH->EH_AGECONT .AND.;
								e[APLCONTA] == SEH->EH_CTACONT })

nRet := If(nAscan > 0, aAplic[nAscan][APLCOTVR], 0)


Return nRet

/*/{Protheus.doc} F820DtRf
Função para recompor valores quando data de referencia anterior ao ultimo resgate
@type  Function
@author Sidney Santos
@since 06/07/2021
@version 1.0	
@return aValDtRef, array, array com valores referentes ao resgate na data
/*/
Static Function F820DtRf(cAplEmp as Character, cNumero as Character, cRevisao as Character ) As Array
Local aAreaSEI			as	array
Local nSaldo 			as	numeric
Local nResgate			as	numeric
local nResgCota 		as	numeric
local nCotas			as	numeric
Local dDtRef			as	date
Local dDtResg			as	date
Local aValDtRef			as	array
Local cAplCal4			as	character	//Fundos de aplicações por Cotas
Local lAplCota			as	logical
Local nUltVlCota		as	numeric

Default cAplEmp			:= 	SEH->EH_APLEMP
Default cNumero			:= 	SEH->EH_NUMERO
Default cRevisao		:= 	SEH->EH_REVISAO

aAreaSEI				:= 	SEI->(GetArea())
nSaldo 					:= 	0
nResgate				:= 	0
nResgCota 				:= 	0
nCotas					:= 	0
dDtRef					:= 	Iif(Empty(MV_PAR01), dDatabase, MV_PAR01)
dDtResg					:= 	CToD("  /  /  ")
aValDtRef				:=	{}
cAplCal4				:= 	GetNewPar("MV_APLCAL4")
lAplCota				:= 	SEH->EH_TIPO $ cAplCal4
nUltVlCota				:= 	1

If !lAplCota
	DbSelectArea("SEI")
	DbSetOrder(1)
	DbSeek(xFilial("SEI") + SEH->EH_APLEMP + SEH->EH_NUMERO + SEH->EH_REVISAO)
	While ( !Eof() .And. xFilial("SEI") == xFilial("SEH") .And.;
					SEI->EI_APLEMP 		== cAplEmp .And.;
					SEI->EI_NUMERO 		== cNumero .And.;
					SEI->EI_REVISAO		== cRevisao )
		
		If dDtRef >= SEI->EI_DATA .And. Alltrim(SEI->EI_MOTBX) == "NOR" 
			If Alltrim(SEI->EI_TIPODOC) $ iif(lAplCota,"RG","BP")
				nResgate += SEI->EI_VALOR
				if lAplCota
					nCotas := iif(SEI->EI_QTDCOTA <> 0, SEI->EI_QTDCOTA, SEI->EI_VALOR / SEI->EI_VLRQTA)
					nResgCota += iif(SEI->EI_VALOR >= 0, nCotas, nCotas*-1) //estorno
					nUltVlCota := SEI->EI_VLRQTA
				endif	
			Endif

			dDtResg := SEI->EI_DATA
		Endif
		SEI->(dbSkip())
	EndDo	
	SEI->(RestArea(aAreaSEI))

	// Saldo na data de referência
	if lAplCota
		nSaldo := (SEH->EH_QUOTAS - nResgCota) * GetAdvFVal("SE9","E9_VLRCOTA",xFilial("SE9")+SEH->EH_CONTRAT+SEH->EH_BCOCONT+SEH->EH_AGECONT,1,nUltVlCota,.T.)
	else
		nSaldo := SEH->EH_VALOR - nResgate
	endIf

	aAdd( aValDtRef, nSaldo )
	aAdd( aValDtRef, dDtResg )

EndIf

Return aValDtRef
/*/{Protheus.doc} fr820CSaldo
funcao responsavel por gerar o saldo correto da aplicacao FAF conforme apropriacoes e resgates, o saldo varia conforme a data referencia do processamento,
pois computa os valores ate a data solicitada no parametro MV_PAR01 ou database
@type function
@version  P12
@author Gustavo G. Rueda
@since 8/16/2023
@param cAplCotas, character, conteudo do parametro MV_APLCAL4
@param nSaldo, numeric, saldo padrao passado para retornar o mesmo valor as condicoes de processamento da funcao nao sejam atendidas;
@param dDtResg, date, data do ultimo resgate
@param nQtdCotasResgate, numeric, qtde de cotas resgatadas
@param nVlrLiquidoCr, numeric, valor total liquido do credito
@param nRendimentoMes, numeric, valor 
@param nTaxaIrf, numeric, taxa do IR recebida para fazer o calculo do liquido
@param nDias, numeric, quantidade de dias da data da inclusão da aplicação até a data de referencia
@param nIofAplAtu, numeric, valor do IOF com base no valor atual da aplicação
@param nIRRdBruto, numeric,  valor do IR com base no valor atual da aplicação
@param nPercRendimento, numeric, coeficiente do percentual de rendimento
@return numeric, valor do saldo calculado
/*/
static function fr820CSaldo( cAplCotas as character, nSaldo as numeric, dDtResg as date, nQtdCotasResgate as numeric, nVlrLiquidoCr as numeric, nRendimentoMes as numeric, nTaxaIrf as numeric, nDias as numeric, nIofAplAtu as numeric, nIRRdBruto as numeric, nPercRendimento as numeric ) as numeric
Local 	nRet									as	numeric
Local 	dDtRef									as	date
Local	aAreaSEI								as	array
Local 	nIRAprop								as	numeric
Local 	aAplic									as	array
Local 	lConsRendCrLiq							as	logical
Local	nCotacaoAtual							as	numeric
Local 	nQtdCotasRestantes						as	numeric

Default	nSaldo			:=	0
Default	dDtResg			:=	CToD( '  /  /  ' )
Default	nQtdCotasResgate:=	0
Default	nVlrLiquidoCr	:=	0
Default nRendimentoMes	:=	0
Default	nTaxaIrf		:=	0
Default	nDias 			:= 	Iif( Empty( MV_PAR01 ), dDataBase, MV_PAR01 ) - SEH->EH_DATA
Default nIofAplAtu		:=	0
Default nIRRdBruto		:=	0
Default nPercRendimento := 	0

nRet					:=	nSaldo
dDtRef					:=	CToD( '  /  /  ' )
aAreaSEI				:=	{}
nIRAprop				:=	0
aAplic					:=	{}
lConsRendCrLiq			:=	.F.
nCotacaoAtual			:=	0
nQtdCotasRestantes		:=	0

//Tratamento somente para FAF, os outros casos, retorna o mesmo valor de saldo recebido pela funcao
If SEH->EH_TIPO $ cAplCotas
	aAreaSEI		:=	SEI->( GetArea() )
	nRet			:=	SEH->( EH_QUOTAS * EH_VLRCOTA )					//para calcular conforme data de referencia, preciso encontrar o valor principal do contrato
	dDtRef			:=	Iif( Empty( MV_PAR01 ), dDataBase, MV_PAR01 )	//tratamento padrao da rotina para quando nao for informado data de referencia no pergunte

	//Variaveis recebidas como referencia que devem ser zeradas para retornar o valor calculado
	dDtResg			:=	CToD( '  /  /  ' )
	nQtdCotasResgate:=	0
	nVlrLiquidoCr	:=	0
	nRendimentoMes	:=	0
	nIofAplAtu		:=	0
	nIRRdBruto		:=	0
	nPercRendimento	:=	0

	//leitura da SEI para obter os valores de apropriacao do mes referencia ou de qualquer resgate que tenha ocorrido na aplicacao
	SEI->( dbSetOrder( 1 ) )
	SEI->( MsSeek( xFilial( 'SEI' ) + SEH->EH_APLEMP + SEH->EH_NUMERO + SEH->EH_REVISAO ) )
	while SEI->( !Eof() .And. SEI->EI_FILIAL == xFilial("SEI") .And.;
								SEI->EI_APLEMP == SEH->EH_APLEMP .And.;
								SEI->EI_NUMERO == SEH->EH_NUMERO .And.;
								SEI->EI_REVISAO	== SEH->EH_REVISAO )
		
		//nao considero processos cancelados
		If SEI->EI_STATUS != "C"
			If SEI->EI_DATA <= dDtRef .And. Alltrim( SEI->EI_MOTBX ) == "NOR" .And. SEI->EI_TIPODOC == 'RG' //RG significa resgate; neste ponto abato os valores resgatados do total para gerar o saldo correto
				If !Empty( SEH->EH_DATARES )	//.And. !Empty( SEH->EH_DATARES ) foi implementado para tratar o legado, que por algum motivo existia SEI como RG mais o  EH_DATARES esava em brando, e para nao gerar o um relatorio diferente, foi implementado essa condicao
					dDtResg				:=	SEI->EI_DATA

				EndIf

				nQtdCotasResgate	+=	SEI->EI_QTDCOTA

			EndIf

		Endif

		SEI->( dbSkip() )

	end
	
	RestArea( aAreaSEI )

	Fr820Calc( cAplCotas, @aAplic )
	nCotacaoAtual		:=	Fr820Cota( aAplic )

	nQtdCotasRestantes	:=	SEH->( EH_QUOTAS - nQtdCotasResgate )
	nRet				:=	SEH->( nQtdCotasRestantes * EH_VLRCOTA ) 
	If nCotacaoAtual # 0
		nRendimentoMes		:=	( nRet - SEH->( nQtdCotasRestantes * nCotacaoAtual ) ) * -1

	EndIf
	nRet			:=	xMoeda( nRet, 1, MV_PAR05 )

	//Tratamento abaixo eh para incluir o valor do rendimento no saldo para calcular o %, nos casos que nao possui nenhum SEI, e o valor da cotacao eh diferente, precisa ter esse tratamento para manter o legado 
	If nQtdCotasRestantes == SEH->EH_QUOTAS
		nPercRendimento	:=	( nRendimentoMes / ( nRet + nRendimentoMes ) ) * 100
		lConsRendCrLiq	:=	.T.

	Else
		nPercRendimento	:=	( nRendimentoMes / nRet ) * 100

	EndIf

	nIofAplAtu 		:= 	FIN_IOF( SEH->EH_APLEMP, nRendimentoMes, nDias)
	nIofAplAtu		:=	Max( nIofAplAtu, 0 )
	nIRRdBruto 		:=	RoundFIN(( ( nRendimentoMes - nIofAplAtu ) * ( nTaxaIrf / 100 ) ), 2, .T. ) - RoundFIN( nIRAprop, 2, .T. )
	nIRRdBruto		:=	Max( nIRRdBruto, 0 )

	FA181Imune( @nIofAplAtu, @nIRRdBruto ) 

	If nCotacaoAtual # 0
		nVlrLiquidoCr	:=	nRet

		//Tratamento para uma situacao especifica acima, onde atribui essa variavel, tratamento para o caso de teste FIR820_004
		If lConsRendCrLiq
			nVlrLiquidoCr	+=	nRendimentoMes

		Else
			nVlrLiquidoCr	-=	nRendimentoMes * -1
		
		EndIf
		
		nVlrLiquidoCr	-=	( nIofAplAtu + nIRRdBruto )

	EndIf

	nRet			:=	Round( nRet, 2 )
	nRet			:=	xMoeda( nRet, 1, mv_par05 )

	nRendimentoMes	:=	Round( nRendimentoMes, 2 )
	nRendimentoMes	:=	xMoeda( nRendimentoMes, 1, mv_par05 )

	nVlrLiquidoCr	:=	Round( nVlrLiquidoCr, 2 )
	nVlrLiquidoCr	:=	xMoeda( nVlrLiquidoCr, 1, mv_par05 )

	nIofAplAtu		:=	Round( nIofAplAtu, 2 )
	nIofAplAtu		:=	xMoeda( nIofAplAtu, 1, mv_par05 )
	
	nIRRdBruto		:=	Round( nIRRdBruto, 2 )
	nIRRdBruto		:=	xMoeda( nIRRdBruto, 1, mv_par05 )

EndIf

return nRet
