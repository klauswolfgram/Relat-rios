/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR870.CH"
#Include "PROTHEUS.CH"

#DEFINE NUMERO			1
#DEFINE NBANCO			2
#DEFINE DT_EMPR			3
#DEFINE DT_PAGTO		4
#DEFINE SALDO			5
#DEFINE TARIFA			6
#DEFINE JUROS			7
#DEFINE PAGAMENTO		8

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR870  ³ Autor ³ Daniel Tadashi Batori ³ Data ³ 28.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao relatorio de Emprestimos Financeiros		      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR870(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR870()
Local oReport

	oReport := ReportDef()
	oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 28.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do layout do Relatorio									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2 //Gestão Corporativa
Local nTamNum
Local cPictVal
Local oSecFil //Gestão Corporativa

oReport := TReport():New("FINR870",STR0003,"FIR870", {|oReport| ReportPrint(oReport)},STR0001+STR0002)

pergunte("FIR870",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					     ³
//³ mv_par01				// Data de Referencia ?              ³
//³ mv_par02            // Banco de           ?                  ³
//³ mv_par03            // Banco Ate          ?                  ³
//³ mv_par04            // Moeda              ?                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nTamNum	:= TamSX3("EH_NUMERO")[1] + TamSX3("EH_REVISAO")[1] + 1
cPictVal	:= PesqPict("SEH","EH_SALDO")

oSection1 := TRSection():New(oReport,STR0011,{"SEH"},) //"Registros"
TRCell():New(oSection1,"NUMERO",,STR0012,,nTamNum,.F.,) //"Numero"
TRCell():New(oSection1,"EH_NBANCO","SEH",STR0013,,20,.F.,)//"Instituicao"
TRCell():New(oSection1,"EH_TIPO","SEH",STR0014,,,.F.,{||SEH->EH_TIPO})//"Mod"
TRCell():New(oSection1,"EH_DATA"	,"SEH",STR0015,,,.F.,)//"Dt.Empre"
TRCell():New(oSection1,"EH_DATARES","SEH",STR0016,,,.F.,)//"Dt.Pgto."
TRCell():New(oSection1,"EH_SALDO",,STR0017,,,.F.,)//"Principal"
TRCell():New(oSection1,"EH_TAXA","SEH",STR0018,,,.F.,{||SEH->EH_TAXA}) //"Taxa Nominal"
TRCell():New(oSection1,"EH_TARIFA","SEH",STR0019,,,.F.,) //"Tar.Contratual"
TRCell():New(oSection1,"JUROS",,STR0020,cPictVal,11,.F.,) //"Juros"
TRCell():New(oSection1,"PAGAMENTO",,STR0021,cPictVal,16,.F.,) //"Pagamento"

oSection1:Cell("JUROS"):SetHeaderAlign("RIGHT")
oSection1:Cell("PAGAMENTO"):SetHeaderAlign("RIGHT")

//Gestão Corporativa - Início
oSection2 := TRSection():New(oReport,"",{"SEH"})
TRCell():New(oSection2,"Filial",,,,TamSx3("EH_FILIAL")[1] + Len(STR0023)) //"Filial : "
oSection2:SetHeaderSection(.F.)

oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0024,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0025,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0026,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0027,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

oReport:SetUseGC(.F.)
//Gestão Corporativa - Fim

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³22.08.06	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2) //Gestão Corporativa
Local aDados[8]
Local nSaldo
LOCAL aCalculo := {}
LOCAL aTotal   := { 0,0,0,0 }

//Gestão Corporativa - Início
Local aTotalF  := { 0,0,0,0 }
Local lGestao   :=  AdmGetGest() 	// Indica se usa Gestao Corporativa
Local lSEHExcl  := Iif( lGestao, FWModeAccess("SEH",1) == "E", FWModeAccess("SEH",3) == "E")
Local cSEHFil  := FWModeAccess("SEH",3)
Local cSEHUN   := FWModeAccess("SEH",2)
Local cSEHEmp  := FWModeAccess("SEH",1)
Local nX 		:= 1
Local oSecFil	:= oReport:Section("SECFIL")
Local nRegSM0	:= SM0->(Recno())
Local aSelFil := {}
Local cFilSel := ""
Local nC := 1
Local cUNold := ""
Local cEmpOld := ""
Local cFilialAnt := cFilAnt
Local lPrtFil 	:= .T.
Local lCarencia	:= .F.

//Gestão Corporativa - Fim

PRIVATE nA181VlMoed
PRIVATE nA181SPCP2
PRIVATE nA181SPLP2
PRIVATE nA181SPCP1
PRIVATE nA181SPLP1
PRIVATE nA181SJUR2
PRIVATE nA181SJUR1
PRIVATE nA181SVCLP
PRIVATE nA181SVCCP
PRIVATE nA181SVCJR
PRIVATE nA181VPLP1
PRIVATE nA181VPCP1
PRIVATE nA181VJUR1
PRIVATE nA181VVCLP
PRIVATE nA181VVCCP
PRIVATE nA181VVCJR
PRIVATE nA181VPLP2 := 0.00
PRIVATE dA181DtApr := MV_PAR01

oSection1:Cell("NUMERO"):SetBlock( { || aDados[NUMERO] })
oSection1:Cell("EH_NBANCO"):SetBlock( { || aDados[NBANCO] })
oSection1:Cell("EH_DATA"):SetBlock( { || aDados[DT_EMPR] })
oSection1:Cell("EH_DATARES"):SetBlock( { || aDados[DT_PAGTO] })
oSection1:Cell("EH_SALDO"):SetBlock( { || aDados[SALDO] })
oSection1:Cell("JUROS"):SetBlock( { || aDados[JUROS] })
oSection1:Cell("EH_TARIFA"):SetBlock( { || aDados[TARIFA] })
oSection1:Cell("PAGAMENTO"):SetBlock( { || aDados[PAGAMENTO] })

nRegSM0 := SM0->(Recno())

If (lSEHExcl .and. mv_par05 == 1)
	aSelFil := AdmGetFil()
EndIf

If Empty(aSelFil)
	aSelFil := {cFilAnt}
EndIf

SM0->(DbGoTo(nRegSM0))

If mv_par05 == 1
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0028 +  ")")	//"Filiais selecionadas para o relatorio"
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
EndIf

oReport:SetPortrait()
oReport:SetMeter(SEH->(RecCount()))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³	Moeda do Emprestimo														³
//³	-------------------														³
//³	aCalculo[1][1] -> Valor Atualizado na Moeda do Emprestimo			³
//³	aCalculo[1][2] -> Valor Acumulado Juros na Moeda do Emprestimo		³
//³	aCalculo[1][3]															³
//³	aCalculo[1][4]															³
//³	aCalculo[1][5]															³
//³	aCalculo[1][6] -> Valor Juros na Moeda do Emprestimo					³
//³	aCalculo[1][7]															³
//³	aCalculo[1][8]															³
//³	aCalculo[1][9]															³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³	Moeda 1																	³
//³	-------																	³
//³	aCalculo[2][1] -> Valor Atualizado										³
//³	aCalculo[2][2] -> Acumulado Juros 										³
//³	aCalculo[2][3] -> Acumulado Variacao Cambial Longo Prazo			³
//³	aCalculo[2][4] -> Acumulado Variacao Cambial Curto Prazo			³
//³	aCalculo[2][5] -> Acumulado Variacao Cambial Juros 					³
//³	aCalculo[2][6] -> Juros 													³
//³	aCalculo[2][7] -> Variacao Cambial Longo Prazo						³
//³	aCalculo[2][8] -> Variacao Cambial Curto Prazo						³
//³	aCalculo[2][9] -> Variacao Cambial Juros								³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	aSort(aSelFil)
	cFilAnt := aSelFil[nC]
	cUN  := FWUnitBusiness()
	cEmp := FWCodEmp()
	cUNold := cUN
	cEmpOld := cEmp

dbSelectArea("SEH")
dbSetOrder(1)
dbSeek(xFilial("SEH"))

For nC := 1 To Len(aSelFil) Step 1

	aFill(aDados,nil)

	If aSelFil[nC] <> cFilAnt .And. mv_par05 == 1
		If cSEHEmp == "E" .And. cSEHUN == "E" .And. cSEHFil == "C" .And. mv_par05 == 1
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

		If cSEHEmp == "E" .And. cSEHUN == "C" .And. cSEHFil == "C" .And. mv_par05 == 1
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

		If cSEHEmp == "C" .And. cSEHUN == "C" .And. cSEHFil == "C" .And. mv_par05 == 1
			nC := Len(aSelFil) + 1
		EndIf

		If nC > Len(aSelFil)
			Loop
		EndIf

		cFilAnt := aSelFil[nC]
		cUN  := FWUnitBusiness()
		cEmp := FWCodEmp()
		cUNold := cUN
		cEmpOld := cEmp
		lPrtFil := .T.
		dbSelectArea("SEH")
		dbSetOrder(1)
		dbSeek(xFilial("SEH"))
	EndIf

	oReport:IncMeter()

	While !EOF() .And. SEH->EH_FILIAL == xFilial("SEH")
		If ( SEH->EH_BANCO >= MV_PAR02 .And. SEH->EH_BANCO <= MV_PAR03 ) .And. SEH->EH_APLEMP == "EMP" .And. SEH->EH_SALDO > 0
			lCarencia:= .F.
			nA181VlMoed:= RecMoeda(dA181DtApr,SEH->EH_MOEDA)
			nA181SPCP2	:= 0
			nA181SPLP2	:= 0
			nA181SPCP1	:= 0
			nA181SPLP1	:= 0
			nA181SJUR2	:= 0
			nA181SJUR1	:= 0
			nA181SVCLP	:= 0
			nA181SVCCP	:= 0
			nA181SVCJR	:= 0
			nA181VPLP1 	:= 0
			nA181VPCP1 	:= 0
			nA181VJUR1 	:= 0
			nA181VVCLP 	:= 0
			nA181VVCCP 	:= 0
			nA181VVCJR 	:= 0
			nA181VPLP2 	:= 0
			nA181VlDeb	:= 0
			aCalculo	  := Fa171Calc(MV_PAR01,SEH->EH_SALDO,.F.) // Data de Referencia ?
			nA181SPCP2 := Round(SEH->EH_SALDO * SEH->EH_PERCPLP/100 , TamSX3("EH_SALDO")[2])
			nA181SPLP2 := SEH->EH_SALDO - nA181SPCP2
			nA181SPLP1 := SEH->EH_VLCRUZ
			nA181SPCP1 := Round(SEH->EH_VLCRUZ * SEH->EH_PERCPLP/100,TamSX3("EH_SALDO")[2])
			nA181SPLP1 := SEH->EH_VLCRUZ - nA181SPCP1
			nA181SJUR2 := aCalculo[1,2]
			nA181SJUR1 := aCalculo[2,2]
			nA181SVCLP := aCalculo[2,3]
			nA181SVCCP := aCalculo[2,4]
			nA181SVCJR := aCalculo[2,5]
			nA181VlIRF := 0
			nA181VLDES := 0
			nA181VLGAP := 0
			nA181STOT1 := nA181SPLP1+nA181SPCP1+nA181SJUR1+nA181SVCLP+nA181SVCCP+nA181SVCJR
			nA181STOT2 := nA181SPLP2+nA181SPCP2+nA181SJUR2
			nA181VPLP1 := nA181SPLP1
			nA181VPCP1 := nA181SPCP1
			nA181VPLP2 := nA181SPLP2
			nA181VPCP2 := nA181SPCP2
			nA181VJUR1 := nA181SJUR1
			nA181VJUR2 := nA181SJUR2
			nA181VVCLP := nA181SVCLP
			nA181VVCCP := nA181SVCCP
			nA181VVCJR := nA181SVCJR
			nA181VTOT1 := nA181STOT1
			nA181VTOT2 := nA181STOT2
			Fa181Valor(,"DA181DTAPR")
			nSaldo 		:= xMoeda(SEH->EH_SALDO,SEH->EH_MOEDA,mv_par04)
			nVlEmpJur2	:= xMoeda(nA181SJUR2 ,SEH->EH_MOEDA,mv_par04)
			nVlEmpAtu2	:= xMoeda(nA181VlDeb,1,mv_par04,mv_par01)

			If lPrtFil
				If mv_par05 == 1
					oReport:SkipLine()
					oSection2:Init()
					oSection2:Cell("Filial"):SetBlock({|| STR0023 + xFilial("SEH")}) //"Filial : "
					oSection2:PrintLine()
					oSection2:Finish()
				EndIf
				lPrtFil := .F.
				oSection1:Init()
			EndIf

			// Verifica se emprestimo tem carência
			If !Empty(SEH->EH_CARENCI)
				lCarencia:= .T.
			EndIf
			If !Empty (dA181DtApr).and. !Empty (EH_DATARES)
				aDados[NUMERO] := SEH->EH_NUMERO+"/"+SEH->EH_REVISAO
				aDados[NBANCO] := SubStr(SEH->EH_NBANCO,1,20)
				aDados[DT_EMPR] := SEH->EH_DATA
				aDados[DT_PAGTO] := SEH->EH_DATARES
				aDados[SALDO] := Fa870VlDt(dA181DtApr,lCarencia, aCalculo[1,2])
				aDados[TARIFA] := SEH->EH_TARIFA
				aDados[JUROS] := nVlEmpJur2
				aDados[PAGAMENTO] := nVlEmpAtu2
				oSection1:PrintLine()
			Else
   	    		aDados[NUMERO] := SEH->EH_NUMERO+"/"+SEH->EH_REVISAO
				aDados[NBANCO] := SubStr(SEH->EH_NBANCO,1,20)
				aDados[DT_EMPR] := SEH->EH_DATA
				aDados[DT_PAGTO] := SEH->EH_DATARES
				aDados[SALDO] := Fa870VlDt(dA181DtApr,lCarencia, aCalculo[1,2])
				aDados[TARIFA] := SEH->EH_TARIFA
				aDados[JUROS] := nVlEmpJur2
				aDados[PAGAMENTO] := nVlEmpAtu2
				oSection1:PrintLine()
			Endif

			If !Empty (dA181DtApr)
			    aTotal[1] += IIf(dA181DtApr < SEH->EH_DATARES,SEH->EH_VALOR,nA181VTOT1)
			    aTotalF[1] += IIf(dA181DtApr < SEH->EH_DATARES,SEH->EH_VALOR,nA181VTOT1)
				aTotal[2] += nVlEmpJur2
				aTotalF[2] += nVlEmpJur2
				aTotal[3] += nVlEmpAtu2
				aTotalF[3] += nVlEmpAtu2
				aTotal[4] += SEH->EH_TARIFA
				aTotalF[4] += SEH->EH_TARIFA
			Else
			    aTotal[1] += IIf(dDataBase < SEH->EH_DATARES,SEH->EH_VALOR,nSaldo)
				aTotalF[1] += IIf(dDataBase < SEH->EH_DATARES,SEH->EH_VALOR,nSaldo)
				aTotal[2] += nVlEmpJur2
				aTotalF[2] += nVlEmpJur2
				aTotal[3] += nVlEmpAtu2
				aTotalF[3] += nVlEmpAtu2
				aTotal[4] += SEH->EH_TARIFA
				aTotalF[4] += SEH->EH_TARIFA
			Endif
		EndIf
		aFill(aDados,nil)
		dbSelectArea("SEH")
		DbSkip()
	EndDo

	If ( aTotalF[1]+aTotalF[2]+aTotalF[3] > 0 )
		oSection1:Cell("EH_TIPO"):SetBlock({||""})
		oSection1:Cell("EH_TAXA"):SetBlock({||""})
		oReport:SkipLine()
		aDados[NBANCO] := STR0022 //"Total Filial...:"
		aDados[SALDO] := aTotalF[1]
		aDados[TARIFA] := aTotalF[4]
		aDados[JUROS] := aTotalF[2]
		aDados[PAGAMENTO] := aTotalF[3]
		oSection1:PrintLine()
		aTotalF := { 0,0,0,0 }
		oSection1:Finish()
		oSection1:Cell("EH_TIPO"):SetBlock({||SEH->EH_TIPO})
		oSection1:Cell("EH_TAXA"):SetBlock({||SEH->EH_TAXA})
	EndIf
Next

   If ( aTotal[1]+aTotal[2]+aTotal[3] > 0 ) .And. mv_par05 == 1
		aFill(aDados,nil)
		oSection1:Cell("EH_TIPO"):SetBlock({||""})
		oSection1:Cell("EH_TAXA"):SetBlock({||""})
		oReport:SkipLine()
		oSection1:SetHeaderSection(.F.)
		oSection1:Init()
		aDados[NBANCO] := STR0010 //"Total Geral...:"
		aDados[SALDO] := aTotal[1]
		aDados[TARIFA] := aTotal[4]
		aDados[JUROS] := aTotal[2]
		aDados[PAGAMENTO] := aTotal[3]
		oSection1:PrintLine()
		aFill(aDados,nil)
		aFill(aTotalF,nil)
		aFill(aTotal,nil)
		oSection1:Finish()
	EndIf

dbCloseArea()
cFilAnt := cFilialAnt

Return( .T. )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ Fa870VlDt ³ Autor ³ Jose Gavetti         ³ Data ³ 10/12/13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressao relatorio                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA870VlDt()                								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR870													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Fa870VlDt(dA181DtApr As Date, lCarencia As Logical, nValJuros As Numeric) As Numeric

Local nSaldo	As Numeric // Valor respectivo a Data de Referencia MV_PAR01
Local nI		As Numeric
Local nCont		As Numeric
Local nValAmor 	As Numeric
Local nValCorr	As Numeric
Local lSEHBase 	As Logical
Local cTPCaren 	As Character
Local aAreaEH	As Array
Local lJurCar  	As Logical

nSaldo		:= 0
nI			:= 0
nCont		:= 0
nValAmor 	:= 0
nValCorr	:= 0
lSEHBase 	:= SEH->(ColumnPos("EH_BASEDES")) > 0
cTPCaren 	:= SuperGetMV("MV_TPCAREN",.F.,"1")
aAreaEH		:= SEH->(GetArea())
lJurCar  	:= SEH->EH_JURCAR == "1"

// Valor do debito inicial
If lSEHBase
	If SEH->EH_BASEDES == "1" //Compôe taxas e despesas na base de calculo dos juros
		nSaldo := SEH->EH_SALDO+SEH->EH_VALIOF+SEH->EH_TARIFA+SEH->EH_DESPESA+SEH->EH_SPREAD
	Else
		nSaldo := SEH->EH_SALDO
	EndIf
Else 
	nSaldo := SEH->EH_SALDO
EndIf

// Considera o valor informado no campo de amortização
If !Empty(SEH->EH_VLAMORP)
	nValAmor := SEH->EH_VLAMORP
Else
	// Calcula valor da amortização
	nValAmor := Round(nSaldo/SEH->EH_PRAZO,2)
EndIf

	/*********************************************************************************/
	/*********************************************************************************/
	/*Calcula os valores com base no prazo informado no campo EH_PRAZO					*/
	/*********************************************************************************/
	
	nCont := IIF(cTPCaren=="1",SEH->EH_PRAZO - SEH->EH_CARENCI, SEH->EH_PRAZO) //Determina se a carência é considera dentro ou fora do prazo informado

	For nI := 1 to nCont
			
		/**************/
		/* Tabela SAC */
		/**************/
		If SEH->EH_AMORTIZ == "2"	
		
			/*********** Emprestimo com Carência***********/
			If lCarencia
						
				//Calcula o valor corrigido, considerando ou não os juros na carencia conforme definido no campo EH_JURCAR
				nValCorr := IIF(lJurCar, nSaldo, nSaldo+nValJuros)
					
				nSaldo  := nValCorr //Atualiza coluna valor debito com o valor corrigido, para assim exibir o valor debito correto na proxima parcela
					
				Loop
			/***********Calculo sem Carência***********/		
			Else
				
				If cTPCaren == "1"					
					nValAmor := nSaldo/(SEH->EH_PRAZO-SEH->EH_CARENCI)
				ElseIf cTPCaren == "2"
					// Carencia fora do prazo do emprestimo
					nValAmor := nSaldo/SEH->EH_PRAZO
				EndIf
					
				// Calcula o valor do debito
				nSaldo := nSaldo - nValAmor		
					
			EndIf
			
		/****************/
		/* Tabela PRICE */	
		/****************/
		Else
			
			/*********** Emprestimo com Carência***********/
			If lCarencia
				//Calcula o valor corrigido, considerando ou não os juros na carencia conforme definido no campo EH_JURCAR
				nValCorr := IIF(lJurCar, nSaldo, nSaldo+nValJuros)
						
				nSaldo  := nValCorr //Atualiza coluna valor debito com o valor corrigido, para assim exibir o valor debito correto na proxima parcela
					
				Loop
			/***********Calculo sem Carência***********/
			Else
					
				// Calcula o valor do debito
				nSaldo := nSaldo - nValAmor
					
			EndIf
		EndIf			
		
	Next

RestArea(aAreaEH)

Return (nSaldo)
