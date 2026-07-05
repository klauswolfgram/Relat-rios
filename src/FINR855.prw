/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.ch"
#INCLUDE "Finr855.ch"

Static lIsIssBx := FindFunction("IsIssBx")
Static nTamCodFor	:= TamSx3('A2_COD')[1]
Static nTamCodLoj	:= TamSx3('A2_LOJA')[1]
Static nTamParcel	:= TamSx3('E2_PARCELA')[1]

STATIC _oFR855TR1   := NIL
STATIC _oFR855TR2	:= NIL
STATIC _oFR855TR3	:= NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR855  ³ Autor ³Marcel Borges Ferreira ³ Data ³ 08/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio para impressao do titulo principal x titulos de  ³±±
±±³          ³ impostos gerados.                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr855()

Local oReport

oReport:=ReportDef()
oReport:PrintDialog()

F855DelTRB(.T.)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Marcel Borges Ferreira ³ Data ³ 08/08/06 ³±±
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

Local oReport
Local lAglPCC 	  := SuperGetMv("MV_AG10925",.F.,"2") == "1"
Local cPisNat	  := SuperGetMv("MV_PISNAT")
Local aAreaSM0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria as Perguntas caso ainda nao exista..                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAreaSM0 := SM0->(GetArea())
Pergunte("FIN855",.F.)
RestArea(aAreaSM0)

oReport := TReport():New("FINR855",STR0004,"FIN855",{|oReport| ReportPrint(oReport)},STR0001+STR0002+STR0003) //"Este programa tem como objetivo imprimir relatorio com a relação Titulo Principal X Impostos, de acordo com os parametros informados pelo usuario."
oReport:SetLandscape()                            

//ÚÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Secao 1  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport,STR0028, ("TR1","SA2","SED","SE2"),{OemToAnsi(STR0013),OemToAnsi(STR0014)})  //"Titulo principal"##"Por Codigo Fornecedor" - "Por Nome Fornecedor" 
TRCell():New( oSection1, "TR1_COD"		,,STR0029,,nTamCodFor,,)  //"Fornecedor"
TRCell():New( oSection1, "TR1_LOJA"		,,STR0030,,nTamCodLoj,,)  //"Loja"
TRCell():New( oSection1, "A2_NOME"		,,STR0016,,50,,) //"Nome Fornecedor"
TRCell():New( oSection1, "A2_CGC" 		,,STR0017,,26,,) //"CNPJ"
TRCell():New( oSection1, "TR1_PREFIXO"	,,STR0018,,5 ,,) //"Pref"
TRCell():New( oSection1, "TR1_NUM"		,,STR0019,,15,,) //"Numero"
TRCell():New( oSection1, "TR1_PARCELA"	,,STR0020,,10,,) //"Parc"
TRCell():New( oSection1, "TR1_TIPO"		,,STR0021,,5 ,,) //"Tipo"
TRCell():New( oSection1, "TR1_NATUREZ"	,,STR0022,,10,,) //"Natureza"
TRCell():New( oSection1, "TR1_EMISSAO"	,,STR0023,,15,,) //"Emissao"
TRCell():New( oSection1, "TR1_VENCREA"	,,STR0024,,15,,) //"Vencimento"
TRCell():New( oSection1, "TR1_VALBASE"	,,STR0025,"@E 99999,999.99",15,,,"RIGHT",,"RIGHT") //"Valor Bruto"
TRCell():New( oSection1, "TR1_VALIMP"	,,STR0026,"@E 99999,999.99",15,,,"RIGHT",,"RIGHT") //"Impostos"
TRCell():New( oSection1, "TR1_VALLIQ"	,,STR0027,"@E 99999,999.99",15,,,"RIGHT",,"RIGHT") //"Valor Lq"

oSection1:SetHeaderPage()

//ÚÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Secao 2  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oReport,STR0026, {"TR2","SE2","SA2","SED"} )   //"Impostos"
TRCell():New( oSection2, "TR2_COD"		,,STR0029,,nTamCodFor,,)  //"Fornecedor"
TRCell():New( oSection2, "TR2_LOJA"		,,STR0030,,nTamCodLoj,,)  //"Loja"
TRCell():New( oSection2, "A2_NOME"		,,STR0016,,50,,)//"Nome Fornecedor"
TRCell():New( oSection2, "A2_CGC" 		,,STR0017,,26,,)//"CNPJ"
TRCell():New( oSection2, "TR2_PREFIXO"	,,STR0018,,5 ,,)//"Pref"
TRCell():New( oSection2, "TR2_NUM"		,,STR0019,,15,,)//"Numero"
TRCell():New( oSection2, "TR2_PARCELA"	,,STR0020,,10,,)//"Parc"
TRCell():New( oSection2, "TR2_TIPO"		,,STR0021,,5 ,,)//"Tipo"
TRCell():New( oSection2, "TR2_NATUREZ"	,,STR0022,,10,,)//"Natureza"
TRCell():New( oSection2, "TR2_EMISSAO"	,,STR0023,,15,,)//"Emissao"
TRCell():New( oSection2, "TR2_VENCREA"	,,STR0024,,15,,)//"Vencimento"
TRCell():New( oSection2, "TR2_VALBASE"	,,STR0025,"@E 99999,999.99",15,,,"RIGHT",,"RIGHT")//"Valor Bruto"
TRCell():New( oSection2, "TR2_VALIMP"	,,STR0026,"@E 99999,999.99",15,,,"RIGHT",,"RIGHT")//"Impostos"
TRCell():New( oSection2, "TR2_VALLIQ"	,,STR0027,"@E 99999,999.99",15,,,"RIGHT",,"RIGHT")//"Valor Lq"

oSection2:SetTotalInLine(.F.)
oSection2:SetTotalText(STR0031) //"Totais :"

oSection2:SetHeaderSection(.F.)

TRFunction():New(oSection2:Cell("TR2_VALBASE") ,/*"oTotal"*/ ,"ONPRINT", /*oBreak */,,/*[ cPicture ]*/,{||TR1->VALBASE }/*[ uFormula ]*/,.T.,.F.,,oSection2)
TRFunction():New(oSection2:Cell("TR2_VALIMP" ) ,/*"oTotal"*/ ,"ONPRINT", /*oBreak */,,/*[ cPicture ]*/,{||nValImp}      /*[ uFormula ]*/,.T.,.F.,,oSection2)
TRFunction():New(oSection2:Cell("TR2_VALLIQ")  ,/*"oTotal"*/ ,"ONPRINT", /*oBreak */,,/*[ cPicture ]*/,{||nValLiq}      /*[ uFormula ]*/,.T.,.F.,,oSection2)

//ÚÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Secao 3  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3 := TRSection():New( oReport,STR0032, {"TR3","SE2","SA2","SED"}) //"Total Impostos"
TRCell():New( oSection3, "TR3_DESCR"  , /*cAlias1*/,"DESCR" ,                 ,20,,,"RIGHT",,"RIGHT")
TRCell():New( oSection3, "TR3_TSEST"  , /*cAlias1*/,STR0033  ,"@E 9999999,999.99",15,,,"RIGHT",,"RIGHT")//"SEST
TRCell():New( oSection3, "TR3_TIRRF"  , /*cAlias1*/,STR0034  ,"@E 9999999,999.99",15,,,"RIGHT",,"RIGHT")//"IRRF
TRCell():New( oSection3, "TR3_TISS"   , /*cAlias1*/,STR0035  ,"@E 9999999,999.99",15,,,"RIGHT",,"RIGHT")//"ISS"
TRCell():New( oSection3, "TR3_TINSS"  , /*cAlias1*/,STR0036  ,"@E 9999999,999.99",15,,,"RIGHT",,"RIGHT")//"INSS"

If lAglPCC
	TRCell():New( oSection3, "TR3_TPIS"   , /*cAlias1*/,cPisNat ,"@E 9999999,999.99",15,,,"RIGHT",,"RIGHT")//"PIS"
Else
	TRCell():New( oSection3, "TR3_TPIS"   , /*cAlias1*/,STR0037   ,"@E 9999999,999.99",15,,,"RIGHT",,"RIGHT")//"PIS
	TRCell():New( oSection3, "TR3_TCOFINS",/*cAlias1*/ ,STR0038	  ,"@E 9999999,999.99",15,,,"RIGHT",,"RIGHT")//"COFINS
	TRCell():New( oSection3, "TR3_TCSLL"  , /*cAlias1*/,STR0039   ,"@E 9999999,999.99",15,,,"RIGHT",,"RIGHT")//"CSLL
EndIf	

oSection3:SetLeftMargin(35)

//Gestão Corporativa - Início
oFilial := TRSection():New(oReport,"",{"SE2"})
TRCell():New(oFilial,"Filial",,,,TamSx3("E2_FILIAL")[1] + Len(STR0041)) //"Filial : "
oFilial:SetHeaderSection(.F.)

oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0042,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0043,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0044,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0045,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

oReport:SetUseGC(.F.)
//Gestão Corporativa - Fim

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Marcel Borges Ferreira ³ Data ³ 23/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos os³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local oSection1 := oReport:Section(1) 
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
Local cIndexSe2 := ""
Local cChaveSe2 := ""   
Local cArqTrab1 := ""
Local cArqTrab2 := ""

Local lContrRet := .T.

//Controla o Pis Cofins e Csll na baixa
Local lPCCBaixa := SuperGetMv("MV_BX10925",.T.,"2") == "1"  
Local lAglPCC := SuperGetMv("MV_AG10925",.F.,"2") == "1"
Local cPisNat := SuperGetMv("MV_PISNAT")
Local cCofins := SuperGetMv("MV_COFINS")
Local cCsll   := SuperGetMv("MV_CSLL")
Local cIrf    := SuperGetMv("MV_IRF")
Local cInss   := SuperGetMv("MV_INSS")
Local cIss    := SuperGetMv("MV_ISS")
Local cSest   := SuperGetMv("MV_SEST")

Local oTRP01
Local oTRP02

//Variaveis Totalizadores Impostos
Local nValSest 	:= 0    
Local nValIRRF 	:= 0
Local nValISS 	:= 0
Local nValInss 	:= 0
Local nValPis 	:= 0
Local nValCof 	:= 0
Local nValCsl 	:= 0

Local nValSestG 	:= 0    
Local nValIRRFG 	:= 0
Local nValISSG 	:= 0
Local nValInssG 	:= 0
Local nValPisG 	:= 0
Local nValCofG 	:= 0
Local nValCslG 	:= 0

Local nC := 0
Local lGestao   := ( FWSizeFilial() > 2 )
Local lSE2Excl  := Iif( lGestao, FWModeAccess("SE2",1) == "E", FWModeAccess("SE2",3) == "E")
Local nX 		:= 1
Local oSecFil	:= oReport:Section("SECFIL")
Local nRegSM0	:= SM0->(Recno())
Local aSelFil := {}
Local cUNold := ""
Local cEmpOld := ""
Local cFilialAtu := cFilAnt
Local oFilial		:= oReport:Section(4)
Local lPrtFil := .T.
Local lPrint := .F.
Local lPrintG := .F.  
Local cAspas	:= CHR(34)

aAreaSM0 := SM0->(GetArea())
nRegSM0 := SM0->(Recno())

If (lSE2Excl .and. mv_par09 == 1)
	If lGestao
		aSelFil := FwSelectGC()
	Else
		aSelFil := AdmGetFil(.F.,(MV_PAR09 == 1),"SE2")
	EndIf
Endif

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

If mv_par09 == 1
	SM0->(DbGoTo(nRegSM0))
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0046 +  ")")	//"Filiais selecionadas para o relatorio"
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
	RestArea(aAreaSM0)
Endif

If Len(aSelFil) > 1
	aSort(aSelFil)
EndIf

For nC := 1 To Len(aSelFil) Step 1

	cFilAnt := aSelFil[nC]
	cUN  := FWUnitBusiness()
	cEmp := FWCodEmp()
	cUNold := cUN
	cEmpOld := cEmp

cIndexSe2 := ""
cChaveSe2 := ""   
cArqTrab1 := ""
cArqTrab2 := ""
lContrRet := .T.

//Controla o Pis Cofins e Csll na baixa
lPCCBaixa := SuperGetMv("MV_BX10925",.T.,"2") == "1" 
nValSest 	:= 0    
nValIRRF 	:= 0
nValISS 	:= 0
nValInss 	:= 0
nValPis 	:= 0
nValCof 	:= 0
nValCsl 	:= 0
lPrtFil := .T.

//Monta os arquivos de trabalho
U_Fa855TRB(@cIndexSe2,@cChaveSe2,@cArqTrab1,@cArqTrab2,.T.,oReport)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Emprego da classe TRPosition para posicionar a tabela SE2   ³
//³em toda execucao do metodo PrintLine, para possibilitar com ³
//³que os campos customizados no layout de impressão           ³
//³alterados pelo usuário, sejam devidamente impressos de      ³
//³acordo com o registro da tabela temporária, que baseia-se   ³
//³exclusivamente no titulo principal em sua construcao e nao  ³
//³nos titulos dos impostos                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTRP01 := TRPosition():New(oSection1,"SE2",1,{||xFilial("SE2")+TR1->(PREFIXO+NUM+PARCELA+TIPO+CODIGO+LOJA)})
oTRP02 := TRPosition():New(oSection2,"SE2",1,{||xFilial("SE2")+TRB2->(PREFIXO+NUM+PARCELA+TIPO)})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Define valores da Secao 1  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Cell("TR1_COD"	):SetBlock({||TR1->CODIGO})
oSection1:Cell("TR1_LOJA"	):SetBlock({||TR1->LOJA})
oSection1:Cell("A2_NOME"	):SetBlock({||TR1->NOMEFOR})
oSection1:Cell("A2_CGC"		):SetBlock({||TR1->CGC})
oSection1:Cell("TR1_PREFIXO"):SetBlock({||TR1->PREFIXO})
oSection1:Cell("TR1_NUM"	):SetBlock({||TR1->NUM})
oSection1:Cell("TR1_PARCELA"):SetBlock({||TR1->PARCELA})
oSection1:Cell("TR1_TIPO"	):SetBlock({||TR1->TIPO})
oSection1:Cell("TR1_NATUREZ"):SetBlock({||TR1->NATUREZ})
oSection1:Cell("TR1_EMISSAO"):SetBlock({||TR1->EMISSAO})
oSection1:Cell("TR1_VENCREA"):SetBlock({||TR1->VENCTO})
oSection1:Cell("TR1_VALBASE"):SetBlock({||TR1->VALBASE})
oSection1:Cell("TR1_VALLIQ"	):Hide()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Define valores da Secao 2  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF oReport:nDevice == 4 //EXCEL
	oSection2:Cell("TR2_COD"	):SetBlock({||TRB2->CODIGO})
	oSection2:Cell("TR2_LOJA"	):SetBlock({||TRB2->LOJA})
	oSection2:Cell("A2_NOME"	):SetBlock({||TRB2->NOMEFOR})
	oSection2:Cell("A2_CGC"		):SetBlock({||TRB2->CGC})
ELSE
	oSection2:Cell("TR2_COD"	):Hide()
	oSection2:Cell("TR2_LOJA"	):Hide()
	oSection2:Cell("A2_NOME"	):Hide()
	oSection2:Cell("A2_CGC"		):Hide()
ENDIF
oSection2:Cell("TR2_PREFIXO"):SetBlock({||TRB2->PREFIXO})
oSection2:Cell("TR2_NUM"	):SetBlock({||TRB2->NUM})
oSection2:Cell("TR2_PARCELA"):SetBlock({||TRB2->PARCELA})
oSection2:Cell("TR2_TIPO"	):SetBlock({||TRB2->TIPO})
oSection2:Cell("TR2_NATUREZ"):SetBlock({||TRB2->NATUREZ})
oSection2:Cell("TR2_EMISSAO"):SetBlock({||TRB2->EMISSAO})
oSection2:Cell("TR2_VENCREA"):SetBlock({||TRB2->VENCTO})
oSection2:Cell("TR2_VALIMP"	):SetBlock({||TRB2->VALBASE})
oSection2:Cell("TR2_VALLIQ"	):Hide()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desconsidera tamanho do header da Secao 1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Cell("TR1_COD"	):lHeaderSize := .F.
oSection1:Cell("TR1_LOJA"	):lHeaderSize := .F.
oSection1:Cell("A2_NOME"	):lHeaderSize := .F.
oSection1:Cell("A2_CGC"		):lHeaderSize := .F.

oReport:SetMeter(TR1->(RecCount()))

oSection1:NoUserFilter()
oSection2:NoUserFilter()

SE2->(DbSetOrder(1))

While TR1->(!EOF()) .AND. !oReport:Cancel()
	SE2->(DbSeek(xFilial("SE2")+TR1->(PREFIXO+NUM+PARCELA+TIPO+CODIGO+LOJA)))

	If oReport:Cancel()
		Exit
	EndIf              

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica se a emissao dos Tx's estao ocorrendo na baixa.            ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(Alltrim(TR1->CGC)) == 11
		oSection1:Cell("A2_CGC"):SetPicture("@R 999.999.999-99")
		oSection2:Cell("A2_CGC"):SetPicture("@R 999.999.999-99")
	Else
		oSection1:Cell("A2_CGC"):SetPicture("@R 99.999.999/9999-99")
		oSection2:Cell("A2_CGC"):SetPicture("@R 99.999.999/9999-99")
	EndIf
	
	cChaveTRB2	:= TR1->TITPAI

	If TRB2->(MSSEEK(cChaveTRB2))
		If mv_par09 == 1 .And. lPrtFil
			oReport:SkipLine()
			oFilial:Init()
			oFilial:Cell("Filial"):SetBlock({|| STR0041 + cFilAnt}) //"Filial : "
			oFilial:PrintLine()
			oFilial:Finish()
			lPrtFil := .F.
		EndIf

		lPrint := .T.
		lPrintG := .T.
		oTRP01:Execute()
		oSection1:Init()
		oReport:ThinLine()
		oSection1:PrintLine()
		oReport:ThinLine()
		oSection1:Finish()
	
	   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   //³ Faz a busca/impressao do titulo de imposto                          ³
	   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 		oTRP02:Execute()
   		oSection2:Init()   

		nValImp := 0

		While TRB2->(!EOF()) .and. TRB2->TITPAI = cChaveTRB2
			oSection2:PrintLine()
			If TRB2->TIPO $ "CID"
			    TRB2->(DBSKIP())
			Else 
				nValImp+= TRB2->VALBASE
				
				If Alltrim(TRB2->NATUREZ) == cSest
					nValSest += TRB2->VALBASE
				EndIf
								
				If cAspas+Alltrim(TRB2->NATUREZ)+cAspas == cIrf
					nValIRRF += TRB2->VALBASE
				EndIf

				If cAspas+Alltrim(TRB2->NATUREZ)+cAspas == cIss
					nValISS += TRB2->VALBASE
				EndIf                            
				
				If cAspas+Alltrim(TRB2->NATUREZ)+cAspas == cInss
					nValINSS += TRB2->VALBASE
				EndIf
				

				If !lAglPCC
					If Alltrim(TRB2->NATUREZ) == cPisNat
						nValPis += TRB2->VALBASE
					EndIf
					
					If Alltrim(TRB2->NATUREZ) == cCofins
						nValCof += TRB2->VALBASE
					EndIf
					
					If Alltrim(TRB2->NATUREZ) == cCsll
						nValCsl += TRB2->VALBASE		
					EndIf
				Else
					If Alltrim(TRB2->NATUREZ) == cPisNat
						nValPis += TRB2->VALBASE
					EndIf
				EndIf				
				TRB2->(DBSKIP())				
			Endif
		Enddo

		nValLiq := TR1->VALBASE - nValImp
											
		oSection2:Finish()
		oReport:SkipLine()
         
	Endif
    TR1->(dbSkip()) // Avanca o ponteiro do registro no arquivo		     
  	oReport:IncMeter()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Define valores da Secao 3  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//If nValSestG != 0 .Or. nValIRRFG != 0 .Or. nValISSG != 0 .Or. nValINSSG != 0 .Or. nValPisG != 0 .Or. nValCofG != 0 .Or. nValCslG != 0

If lPrint
nValSestG 	+= nValSest    
nValIRRFG 	+= nValIRRF
nValISSG 	+= nValISS
nValInssG 	+= nValInss
nValPisG 	+= nValPis
nValCofG 	+= nValCof
nValCslG 	+= nValCsl

oReport:SkipLine()
oSection3:Init()  

oSection3:Cell("TR3_DESCR"):HideHeader()
oSection3:Cell("TR3_DESCR"	):SetBlock({|| STR0040 }) //'Total Impostos......'
oSection3:Cell("TR3_TSEST"	):SetBlock({|| nValSest })
oSection3:Cell("TR3_TIRRF"	):SetBlock({|| nValIRRF })
oSection3:Cell("TR3_TISS"	):SetBlock({|| nValISS })
oSection3:Cell("TR3_TINSS"	):SetBlock({|| nValINSS })
If lAglPCC
	oSection3:Cell("TR3_TPIS"	):SetBlock({|| nValPis })
Else
	oSection3:Cell("TR3_TPIS"	):SetBlock({|| nValPis })
	oSection3:Cell("TR3_TCOFINS"):SetBlock({|| nValCof })
	oSection3:Cell("TR3_TCSLL"	):SetBlock({|| nValCsl })
EndIf

oSection3:PrintLine()    
oSection3:Finish()
lPrint := .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TR1->(dbCloseArea())
TRB2->(dbCloseArea())

fErase( cArqTrab1 + GetDBExtension() )
fErase( cArqTrab1 + OrdBagExt() )
fErase( cArqTrab2 + GetDBExtension() )
fErase( cArqTrab2 + OrdBagExt() )

dbSelectArea("SE2")
Next


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Define valores da Secao 3  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If lPrintG .And. mv_par09 == 1

oReport:SkipLine()
oSection3:Init()  

oSection3:Cell("TR3_DESCR"):HideHeader()
oSection3:Cell("TR3_DESCR"	):SetBlock({|| STR0047 }) //'Total Geral Impostos......'
oSection3:Cell("TR3_TSEST"	):SetBlock({|| nValSestG })
oSection3:Cell("TR3_TIRRF"	):SetBlock({|| nValIRRFG })
oSection3:Cell("TR3_TISS"	):SetBlock({|| nValISSG })
oSection3:Cell("TR3_TINSS"	):SetBlock({|| nValINSSG })
If lAglPCC
	oSection3:Cell("TR3_TPIS"	):SetBlock({|| nValPisG })
Else
	oSection3:Cell("TR3_TPIS"	):SetBlock({|| nValPisG })
	oSection3:Cell("TR3_TCOFINS"):SetBlock({|| nValCofG })
	oSection3:Cell("TR3_TCSLL"	):SetBlock({|| nValCslG })
EndIf

oSection3:PrintLine()    
oSection3:Finish()
EndIf

cFilAnt := cFilialAtu
Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR855   º Autor ³ Nilton Pereira     º Data ³  04/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio para impressao do titulo principal x titulos de  º±±
±±º          ³ impostos gerados                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Finr855R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1         := STR0001 //"Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := STR0002 //"com a relação Titulo Principal X Impostos, de "
Local cDesc3         := STR0003 //"acordo com os parametros informados pelo usuario."
Local Titulo       	 := STR0004 //"Relacao - Titulo Principal X Impostos"
Local nLin         	 := 80
                                                                         
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Regua para impressao                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//                                 10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
//                       01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local cabec1         := STR0005  //" Codigo/Loja     Nome Fornecedor                               CNPJ                 Pref    Numero   Parc           Tipo   Natureza            Emissao   Vencimento            Valor Bruto       Impostos       Valor Lq"

Local Cabec2       	 := ""
Local aOrd 			 := {STR0013,STR0014} //"Por Codigo Fornecedor"###"Por Nome Fornecedor"}
Local cPerg			 := "FIN855"      

Private lEnd		 := .F.
Private lAbortPrint	 := .F.
Private CbTxt		 := ""
Private limite		 := 220
Private tamanho		 := "G"
Private nomeprog     := "Finr855" 
Private nTipo        := 18
Private aReturn      := { STR0006, 1, STR0007, 2, 2, 1, "", 1} //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private cbcont  	 := 00
Private CONTFL   	 := 01
Private m_pag    	 := 01
Private wnrel    	 := "Finr855"
Private cString 	 := "SE2"

dbSelectArea("SE2")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria as Perguntas caso ainda nao exista..                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("FIN855",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|| Fa855Imp(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³Fa855Imp  º Autor ³ Nilton Pereira     º Data ³  04/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Fa855Imp(Cabec1,Cabec2,Titulo,nLin)

Local cIndexSe2	:= ""
Local cChaveSe2	:= ""   
Local cArqTrab1	:= ""
Local cArqTrab2	:= ""
Local nValImp  	:= 0
Local nValLiq  	:= 0
Local lAglPCC 	:= SuperGetMv("MV_AG10925",.F.,"2") == "1"
Local cPisNat  	:= SuperGetMv("MV_PISNAT")
Local cCofins	:= SuperGetMv("MV_COFINS")
Local cCsll		:= SuperGetMv("MV_CSLL")
Local cIrf		:= SuperGetMv("MV_IRF")
Local cInss		:= SuperGetMv("MV_INSS")
Local cIss		:= SuperGetMv("MV_ISS")
Local cSest		:= SuperGetMv("MV_SEST")
Local cAspas	:= CHR(34)

//Variaveis Totalizadores Impostos
Local nValSest 	:= 0    
Local nValIRRF 	:= 0
Local nValISS 	:= 0
Local nValInss 	:= 0
Local nValPis 	:= 0
Local nValCof 	:= 0
Local nValCsl 	:= 0

//Monta os arquivos de trabalho
U_Fa855TRB(@cIndexSe2,@cChaveSe2,@cArqTrab1,@cArqTrab2,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(TR1->(RecCount()))

While TR1->(!EOF())

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica o cancelamento pelo usuario...                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If lAbortPrint
      @nLin,00 PSAY STR0009 //"*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Impressao do cabecalho do relatorio. . .                            ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If nLin > 58 // Salto de Pagina. Neste caso o formulario tem 58 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Se o titulo nao tiver impostos, nao imprime o titulo principal      ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cChaveTRB2	:= TR1->TITPAI

   If TRB2->(MSSEEK(cChaveTRB2))
	   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   //³ Inicia impressao do titulo principal . .                            ³
	   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@nLin,000 PSAY __PrtfatLine()
		nLin++		
		
		@nLin, 001 PSAY TR1->CODIGO+" "+TR1->LOJA     
		@nLin, 017 PSAY TR1->NOMEFOR   
		@nLin, 063 PSAY TR1->CGC       Picture IIF(Len(Alltrim(TR1->CGC)) == 11 , "@R 999.999.999-99","@R 99.999.999/9999-99")
		@nLin, 084 PSAY TR1->PREFIXO   
		@nLin, 092 PSAY TR1->NUM       
		@nLin, 104 PSAY TR1->PARCELA   
		@nLin, 119 PSAY TR1->TIPO      
		@nLin, 126 PSAY TR1->NATUREZ   
		@nLin, 146 PSAY TR1->EMISSAO   
		@nLin, 158 PSAY TR1->VENCTO    
		@nLin, 174 PSAY TR1->VALBASE   Picture Tm(TR1->VALBASE ,15) 
	
	    nLin := nLin + 1 // Avanca a linha de impressao
	        
		@nLin,000 PSAY  __PrtfatLine()
		nLin++		

		//Impressao dos impostos
	  	@nLin, 000 PSAY STR0010      //"Impostos ---->"		
        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	    //³ Faz a busca/impressao do titulo de imposto                          ³
	    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
		nValImp := 0

		While TRB2->(!EOF()) .and. TRB2->TITPAI = cChaveTRB2
		   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		   //³ Impressao do cabecalho do relatorio. . .                            ³
		   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		    If nLin > 58 // Salto de Pagina. Neste caso o formulario tem 58 linhas...
		        Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		        nLin := 8                      
	     	  	@nLin, 000 PSAY STR0010      //"Impostos ---->"
		    Endif   
		   
			@nLin, 084 PSAY TRB2->PREFIXO   
			@nLin, 092 PSAY TRB2->NUM       
			@nLin, 104 PSAY TRB2->PARCELA   
			@nLin, 119 PSAY TRB2->TIPO      
			@nLin, 126 PSAY TRB2->NATUREZ   
			@nLin, 146 PSAY TRB2->EMISSAO   
			@nLin, 158 PSAY TRB2->VENCTO    
			@nLin, 189 PSAY TRB2->VALBASE   Picture Tm(TRB2->VALBASE ,15) 
			nLin++
			
			If TRB2->TIPO $ "CID"
			    TRB2->(DBSKIP())
			Else 
				nValImp+= TRB2->VALBASE
				
				If Alltrim(TRB2->NATUREZ) == cSest
					nValSest += TRB2->VALBASE
				EndIf
								
				If cAspas+Alltrim(TRB2->NATUREZ)+cAspas == cIrf
					nValIRRF += TRB2->VALBASE
				EndIf

				If cAspas+Alltrim(TRB2->NATUREZ)+cAspas == cIss
					nValISS += TRB2->VALBASE
				EndIf                            
				
				If cAspas+Alltrim(TRB2->NATUREZ)+cAspas == cInss
					nValINSS += TRB2->VALBASE
				EndIf
				

				If !lAglPCC
					If Alltrim(TRB2->NATUREZ) == cPisNat
						nValPis += TRB2->VALBASE
					EndIf
					
					If Alltrim(TRB2->NATUREZ) == cCofins
						nValCof += TRB2->VALBASE
					EndIf
					
					If Alltrim(TRB2->NATUREZ) == cCsll
						nValCsl += TRB2->VALBASE		
					EndIf
				Else
					If Alltrim(TRB2->NATUREZ) == cPisNat
						nValPis += TRB2->VALBASE
					EndIf
				EndIf				
				
				TRB2->(DBSKIP())
			Endif
        Enddo
		
	    If nLin > 58 // Salto de Pagina. Neste caso o formulario tem 57 linhas...
	       Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	       nLin := 8
	    Endif
	
		@nLin,000 PSAY __PrtThinLine()
		nLin++			                  
	                  
		nValLiq := TR1->VALBASE - nValImp
	
		@nLin, 000 PSAY STR0011 //"Totais ------>"
		@nLin, 174 PSAY TR1->VALBASE Picture Tm(TR1->VALBASE,15)
		@nLin, 189 PSAY nValImp Picture Tm(TR1->VALBASE,15)
		@nLin, 204 PSAY nValLiq Picture Tm(TR1->VALBASE,15)
		nLin++			                  
		   
		@nLin,000 PSAY __PrtThinLine()
		nLin++			                  
	Endif
   TR1->(dbSkip()) // Avanca o ponteiro do registro no arquivo
EndDo


//Variaveis Totalizadores IMpostos

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// Totalizador de Impostos
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
nLin++
nLin++
@nLin,000 PSAY __PrtThinLine()
If !lAglPCC
	@nLin, 050 PSAY STR0033 	//"Valor SEST
	@nLin, 070 PSAY STR0034 	//"Valor IRRF"
	@nLin, 090 PSAY STR0035 	//"Valor ISS"
	@nLin, 110 PSAY STR0036 	//"Valor INSS"
	@nLin, 130 PSAY STR0037 	//"Valor PIS"
	@nLin, 150 PSAY STR0038 	//"Valor COFINS"
	@nLin, 170 PSAY STR0039 	//"Valor CSLL"
	nLin++

	@nLin, 000 PSAY STR0032 //"Total Impostos ------>"
	@nLin, 040 PSAY nValSest Picture Tm(TR1->VALBASE,15)
	@nLin, 060 PSAY nValIRRF Picture Tm(TR1->VALBASE,15)
	@nLin, 080 PSAY nValISS  Picture Tm(TR1->VALBASE,15)
	@nLin, 100 PSAY nValInss Picture Tm(TR1->VALBASE,15)
	@nLin, 120 PSAY nValPis  Picture Tm(TR1->VALBASE,15)
	@nLin, 140 PSAY nValCof  Picture Tm(TR1->VALBASE,15)
	@nLin, 160 PSAY nValCsl  Picture Tm(TR1->VALBASE,15)
Else
	@nLin, 046 PSAY STR0033 	//"Valor SEST
	@nLin, 066 PSAY STR0035 	//"Valor IRRF"
	@nLin, 086 PSAY STR0035 	//"Valor ISS"
	@nLin, 106 PSAY STR0036 	//"Valor INSS"
	@nLin, 126 PSAY cPisNat		//"Valor PIS"
	nLin++   
	
	@nLin, 000 PSAY STR0032 //"Total Impostos ------>"	
	@nLin, 040 PSAY nValSest Picture Tm(TR1->VALBASE,15)
	@nLin, 060 PSAY nValIRRF Picture Tm(TR1->VALBASE,15)
	@nLin, 080 PSAY nValISS  Picture Tm(TR1->VALBASE,15)
	@nLin, 100 PSAY nValInss Picture Tm(TR1->VALBASE,15)
	@nLin, 120 PSAY nValPis  Picture Tm(TR1->VALBASE,15)
EndIf		
nLin++
@nLin,000 PSAY __PrtThinLine()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TR1->(dbCloseArea())
TRB2->(dbCloseArea())
fErase( cArqTrab1 + GetDBExtension() )
fErase( cArqTrab1 + OrdBagExt() )
fErase( cArqTrab2 + GetDBExtension() )
fErase( cArqTrab2 + OrdBagExt() )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA855TRB  ³Autor  ³Mauricio Pequim Jr  ³ Data ³  21/11/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cria e alimenta os arquivos TRB do relatorio               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fa855TRB(cIndexSe2,cChaveSe2,cArqTrab1,cArqTrab2,lIsR4,oReport,cAlias)
Local nX			:= 0   
Local nValImp	  	:= 0
Local nOrdem 		:= 1   
Local cFilterUser   := ""
Local aTamNum		:= TAMSX3("E2_NUM")
Local aTps 			:= {}
Local nTamTit		:= TamSX3("E2_PREFIXO")[1]+TamSX3("E2_NUM")[1]+nTamParcel+TamSX3("E2_TIPO")[1]+TamSX3("E2_FORNECE")[1]+TamSX3("E2_LOJA")[1]
Local nTamTitPai	:= TamSX3("E2_TITPAI")[1]
Local lCIDE			:= cPaisLoc == "BRA"

Local aCampos1		:= {	{"CODIGO"	,"C",nTamCodFor,0 },; 
							{"LOJA"		,"C",nTamCodLoj,0 },; 
							{"NOMEFOR"	,"C",40,0 },;
							{"CGC"		,"C",14,0 },;
							{"PREFIXO"	,"C",03,0 },;
							{"NUM"		,"C",aTamNum[1],0 },;
							{"PARCELA"	,"C",nTamParcel,0 },;
							{"TIPO"		,"C",03,0 },;
							{"NATUREZ"	,"C",10,0 },;							
							{"EMISSAO"	,"D",10,0 },;
							{"VENCTO"	,"D",10,0 },;
							{"VALBASE"  ,"N",17,2 },;
							{"VALINSS"	,"N",17,2 },;
							{"VALPIS"	,"N",17,2 },;
							{"VALCOF"	,"N",17,2 },;
							{"VALCSLL"	,"N",17,2 },;
							{"VALIRFF"	,"N",17,2 },;
							{"VALISS"	,"N",17,2 },;
							{"VALSEST"	,"N",17,2 },;
							{"VALCIDE"	,"N",17,2 },;
							{"PARCSES"	,"C",nTamParcel,0 },;
							{"PARCCID"	,"C",nTamParcel,0 },;
							{"PARCIR"	,"C",nTamParcel,0 },;
							{"PARCISS"	,"C",nTamParcel,0 },;
							{"PARCINS"	,"C",nTamParcel,0 },;
							{"PARCCSS"	,"C",nTamParcel,0 },;
							{"PARCCOF"	,"C",nTamParcel,0 },;
							{"PARCPIS"	,"C",nTamParcel,0 },;
							{"PARCSLL"	,"C",nTamParcel,0 },;
							{"VALLIQ"	,"N",17,2 },;
							{"TITPAI"	,"C",nTamTitPai,0 },;							
							{"VAL10925V1","N",17,2 }}
							
Local aCampos2		:= {	{"CODIGO"	,"C",nTamCodFor,0 },; 
							{"LOJA"		,"C",nTamCodLoj,0 },; 
							{"NOMEFOR"	,"C",40,0 },;
							{"CGC"		,"C",14,0 },;
							{"TITPAI"	,"C",nTamTitPai,0 },;							
							{"PREFIXO"	,"C",03,0 },;
							{"NUM"		,"C",aTamNum[1],0 },;
							{"PARCELA"	,"C",nTamParcel,0 },;
							{"TIPO"		,"C",03,0 },;
							{"NATUREZ"	,"C",10,0 },;							
							{"EMISSAO"	,"D",10,0 },;
							{"VENCTO"	,"D",10,0 },;
							{"VALBASE"  ,"N",17,2 } }

Local lPCCBaixa := SuperGetMv("MV_BX10925",.T.,"2") == "1"  
Local lAglPCC 		:= SuperGetMv("MV_AG10925",.F.,"2") == "1"
Local lTitPai 		:= .T.
Local cTitPai 		:= ""
Local cTipos  		:= MVISS+"/"+MVINSS+"/"+"SES/"+"/"+"CID/"+MVTXA+"/"+MVTAXA+"/"+"INA"
Local cFilterSA2	:=	""
Local cFilterSED	:=	""
Local cFilterSE2	:=	""
Local cFilterImp	:=	""
Local cAliasSE2		:= "SE2"
Local cFiltro		:= ""
Local lCalcIssBx	:=	IIF(lIsIssBx, IsIssBx("P"), SuperGetMv("MV_MRETISS",.F.,"1") == "2" )
Local oSection1		:= NIL
Local oSection2		:= NIL
Local lIRPFBaixa	:= .T.
Local lIRPFBxAux	:= .F.
Local cQuery2		:= ''
Local nVlrIrfAcu	:= 0

If !lIsR4
	nOrdem 		:= aReturn[8]   
	cFilterUser := aReturn[7]
Else
	oSection1	:= oReport:Section(1) 
	oSection2	:= oReport:Section(2)
	nOrdem 		:= oSection1:GetOrder()
	cFilterSA2	:=	oSection1:GetAdvplExp("SA2")
	cFilterSED	:=	oSection1:GetAdvplExp("SED")
	cFilterSE2	:=	oSection1:GetAdvplExp("SE2")
	cFilterImp	:=	oSection2:GetAdvplExp("SE2")
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abre o SE2 com outro alias para ser localizado o titulo     ³
//³ do imposto                   							    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !( ChkFile("SE2",.F.,"NEWSE2") )
	Return(Nil)
EndIf



dbSelectArea("SE2")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Efetua filtro              								   		    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFiltro := "SELECT R_E_C_N_O_ RECNO "
cFiltro += "  FROM " + RetSqlName("SE2")
cFiltro += " WHERE E2_FILIAL   =  '" + xFilial("SE2") + "'"
cFiltro += "   AND E2_FORNECE  >= '"+mv_par01+"' AND E2_FORNECE <= '"+mv_par02+"'"
cFiltro += "   AND E2_LOJA     >= '"+mv_par03+"' AND E2_LOJA    <= '"+mv_par04+"'"
// Nao inclui os titulos de impostos
cFiltro += "   AND E2_TIPO NOT IN " + FormatIn(MVISS,"|")
cFiltro += "   AND E2_TIPO NOT IN " + FormatIn(MVTAXA,"|")
cFiltro += "   AND E2_TIPO NOT IN " + FormatIn(MVTXA ,"|")
cFiltro += "   AND E2_TIPO NOT IN " + FormatIn(MVINSS+"|"+"INA","|")
cFiltro += "   AND E2_TIPO NOT IN ('SES')"
cFiltro += "   AND E2_TIPO NOT IN ('CID')"
cFiltro += "   AND E2_EMISSAO >= '"+DTOS(mv_par05) +"' AND E2_EMISSAO <= '"+DTOS(mv_par06)+"'"
cFiltro += "   AND E2_EMISSAO <= '"+DTOS(dDataBase)+"'"
cFiltro += "   AND E2_VENCREA >= '"+DTOS(mv_par07) +"' AND E2_VENCREA <= '"+DTOS(mv_par08)+"'"
cFiltro += "   AND D_E_L_E_T_=' ' "

cFiltro := ChangeQuery( cFiltro )

If AllTrim(TcGetDb()) == "DB2"
	cFiltro := STRTRAN( cFiltro, "FOR READ ONLY", "" )
EndIf

// Cria Arquivo temporario 1 -------------------------------------------
F855DelTRB(.F.,1)
_oFR855TR1 := FWTemporaryTable():New( 'TRBSE2', {{"RECNO","N",16,0}} )
_oFR855TR1:Create()
cQuery2 := " INSERT "
If ALLTRIM(tcGetdb()) == "ORACLE"
	cQuery2 += " /*+ APPEND */ "
Endif
cQuery2 += " INTO " + _oFR855TR1:GetRealName() + " (RECNO) " + cFiltro
Processa({|| nTcSql := TcSQLExec(cQuery2)})
cAliasSE2 := "TRBSE2"
// Cria Arquivo temporario 2 -------------------------------------------
F855DelTRB(.F.,2)
_oFR855TR2 := FWTemporaryTable():New( 'TR1', aCampos1 )
If nOrdem == 1
	_oFR855TR2:AddIndex('1',{"CODIGO","LOJA","PREFIXO","NUM","PARCELA"})
Else
	_oFR855TR2:AddIndex('1',{"NOMEFOR","PREFIXO","NUM","PARCELA"})
Endif
_oFR855TR2:Create()
// Cria arquivo temporario 3 -------------------------------------------
F855DelTRB(.F.,3)
_oFR855TR3 := FWTemporaryTable():New( 'TRB2', aCampos2 )
_oFR855TR3:AddIndex('1',{"TITPAI"})
_oFR855TR3:Create()
// ---------------------------------------------------------------------

dbSelectArea("SA2")			
dbSetOrder(1)                                                                         
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega arquivo temporario 1	e 2								    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE2")

(cAliasSE2)->(DbGoTop())

While (cAliasSE2)->(!Eof())   // SE2        

	SE2->(DBGOTO((cAliasSE2)->RECNO))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega arquivo temporario 1	e 2							  	    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se o titulo for o principal alimenta o arquivo temporario 1 		³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If SA2->(dbSeek(xFilial("SA2")+SE2->(E2_FORNECE+E2_LOJA)))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lIsR4
			If !Empty(cFilterSA2) .And. SA2->(!&(cFilterSA2))
				(cAliasSE2)->(DbSkip())		
				Loop
			Endif		
			If !Empty(cFilterSE2) .And. SE2->(!&(cFilterSE2))
				(cAliasSE2)->(DbSkip())		
				Loop
			Endif		
			If !Empty(cFilterSED)                       
				SED->(DbSetOrder(1))
				SED->(MsSeek(xFilial()+SE2->E2_NATUREZ)) 
				If SED->(!&(cFilterSED))
					(cAliasSE2)->(DbSkip())		
					Loop
				Endif
			Endif		
		Else
			If !Empty(cFilterUser).and. SE2->(!(&cFilterUser))
				(cAliasSE2)->(dbSkip())		
				Loop
			Endif		
   		Endif
   	
		dbSelectArea("TR1")
		RecLock("TR1",.T.)	
			TR1->CODIGO		:= SA2->A2_COD
			TR1->LOJA		:= SA2->A2_LOJA
			TR1->NOMEFOR	:= SA2->A2_NOME 
			TR1->CGC		:= SA2->A2_CGC
			TR1->PREFIXO	:= SE2->E2_PREFIXO
			TR1->NUM		:= SE2->E2_NUM
			TR1->PARCELA	:= SE2->E2_PARCELA
			TR1->TIPO		:= SE2->E2_TIPO
			TR1->NATUREZ	:= SE2->E2_NATUREZ
			TR1->EMISSAO	:= SE2->E2_EMISSAO
			TR1->VENCTO		:= SE2->E2_VENCREA
			TR1->TITPAI		:= SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)

			lIRPFBAux  := lIRPFBaixa
			If cPaisLoc == "BRA"
				lIRPFBxAux := lIRPFBAux .And. ( SA2->A2_CALCIRF == "2" )
			Else
				lIRPFBxAux := .F.
			EndIf
			
			//Valor Bruto - O relatório é expresso em moeda 1 - Portanto E2_VLCRUZ já contém a conversão pelo ato da emissão
			TR1->VALBASE := SE2->E2_VLCRUZ + SE2->E2_VRETINS + SE2->E2_SEST
			
			If SE2->E2_PRETPIS <> "2" .or. SE2->E2_PRETCOF <> "2" .or. SE2->E2_PRETCSL <> "2"
				TR1->VALPIS := If(Empty(SE2->E2_VRETPIS), SE2->E2_PIS, SE2->E2_VRETPIS)
				TR1->VALCOF := If(Empty(SE2->E2_VRETCOF), SE2->E2_COFINS, SE2->E2_VRETCOF)
				TR1->VALCSLL := If(Empty(SE2->E2_VRETCSL), SE2->E2_CSLL, SE2->E2_VRETCSL)						
				
				If SE2->E2_PRETPIS $ "3#4" .or. SE2->E2_PRETCOF $ "3#4" .or. SE2->E2_PRETCSL $ "3#4"
					If SE2->E2_VRETPIS + SE2->E2_VRETCOF + SE2->E2_VRETCSL > 0
						TR1->VAL10925V1 := SE2->E2_VRETPIS + SE2->E2_VRETCOF + SE2->E2_VRETCSL
					Else
						TR1->VAL10925V1 := 0
					Endif 
				Endif
			Else				
				TR1->VALPIS := SE2->E2_PIS
				TR1->VALCOF := SE2->E2_COFINS
				TR1->VALCSLL := SE2->E2_CSLL 
			Endif	
			
			If !lPCCBaixa
				TR1->VALBASE += TR1->VALPIS + TR1->VALCOF + TR1->VALCSLL
			EndIf
			
			If !lCalcIssBx
				TR1->VALBASE += SE2->E2_VRETISS
			EndIf
			
			If !lIRPFBxAux
				nVlrIrfAcu	:= SE2->E2_VRETIRF - SE2->E2_IRRF

				If nVlrIrfAcu == 0
					TR1->VALBASE += SE2->E2_VRETIRF
				ElseIf nVlrIrfAcu < 0 
					TR1->VALBASE += SE2->E2_IRRF
				Endif
			EndIF
	
			TR1->PARCPIS	:= SE2->E2_PARCPIS
			TR1->PARCCOF	:= SE2->E2_PARCCOF
			TR1->PARCSLL	:= SE2->E2_PARCSLL
			TR1->VALIRFF	:= SE2->E2_IRRF
			TR1->PARCIR		:= SE2->E2_PARCIR
			TR1->VALISS		:= SE2->E2_ISS        
			TR1->PARCISS	:= SE2->E2_PARCISS
			TR1->VALINSS	:= SE2->E2_INSS
			TR1->PARCINS	:= SE2->E2_PARCINS
			TR1->PARCCSS	:= SE2->E2_PARCCSS
			TR1->VALSEST	:= SE2->E2_SEST
			If lCIDE
				TR1->VALCIDE := SE2->E2_CIDE		  
				TR1->PARCCID := SE2->E2_PARCCID
			EndIf
			TR1->PARCSES     := SE2->E2_PARCSES
		MSUnlock()
	Endif
	cTitPai		:= PAD(SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),nTamTitPai)
	DbSelectArea("NEWSE2")
	
	// Procura o titulo de imposto no alias alternativo.
	NEWSE2->(dbSetOrder(17)) //E2_FILIAL+E2_TITPAI                                                                                                                                                                                                                                                
	If NEWSE2->(Dbseek(xFilial("SE2")+cTitPai))
		
		cChaveSE2	:= SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM) 

		While NEWSE2->(!EOF()) .AND. NEWSE2->(E2_FILIAL+E2_PREFIXO+E2_NUM) == cChaveSE2 .AND. !(NEWSE2->E2_TIPO $ MVABATIM)
			
			While !NEWSE2->(EOF()) .and. cTitPai == NEWSE2->E2_TITPAI
				//Filtro do usuario R4
				If lIsR4
					If !Empty(cFilterImp) .And. NEWSE2->(!&(cFilterImp)) 	
						NEWSE2->(DbSkip())
						Loop
					Else 
						Exit	
					Endif		
				Endif
			Enddo
						
			lPcc := .F.
			cParcPai := ""			

			IF NEWSE2->E2_TIPO $ MVISS
				cParcPai := "SE2->E2_PARCISS"
			ElseIf NEWSE2->E2_TIPO $ MVINSS+"/"+"INA"
				cParcPai := "SE2->E2_PARCINS"
			ElseIf NEWSE2->E2_TIPO $ "SES"
				cParcPai := "SE2->E2_PARCSES"
			ElseIf NEWSE2->E2_TIPO $ "CID"
				cParcPai := "SE2->E2_PARCCID"
			ElseIf NEWSE2->E2_TIPO $ MVTAXA+"/"+MVTXA
				If NEWSE2->E2_FORNECE == GetMv("MV_MUNIC")
					cParcPai := "SE2->E2_PARCISS"
				Else
					Do Case
						Case Alltrim(NEWSE2->E2_NATUREZ) $ AllTrim(GetMv("MV_PISNAT"))
							cParcPai := "SE2->E2_PARCPIS"
							If lPccBaixa
								lPCC := .T.
							Endif
						Case Alltrim(NEWSE2->E2_NATUREZ) $ AllTrim(GetMv("MV_COFINS"))
							cParcPai := "SE2->E2_PARCCOF"
							If lPccBaixa
								lPCC := .T.
							Endif
						Case Alltrim(NEWSE2->E2_NATUREZ) $ AllTrim(GetMv("MV_CSLL"))
							cParcPai := "SE2->E2_PARCSLL"
							If lPccBaixa
								lPCC := .T.
							Endif
						OtherWise
							cParcPai := "SE2->E2_PARCIR"
					EndCase
				Endif
			Endif

			//Se possuir o campo E2_TITPAI, verifico se os dados do campo sao iguais a chave do titulo pai
			//Se nao possuir o campo E2_TITPAI ou o mesmo estiver em branco (base antiga
			//verifico pelo tipo e se for titulo de IRRF, INSS ou ISS verifico a parcela
			//Para os titulos PCC nao sera verificada a parcela pois posso ter mais de um TX do mesmo imposto
			//ligado ao titulo. Exemplo: baixas parciais com retencao de PCC
			If (lTitPai .and. NEWSE2->E2_TITPAI == cTitPai) .or. ;
				( IIF(lTitPai,Empty(NEWSE2->E2_TITPAI),.T.) .and. ; //Se tem o campo, tem que estar vazio para validar aqui
				NEWSE2->E2_TIPO	$ cTipos .and. IIF(!lPCC,NEWSE2->E2_PARCELA	== &(cParcPai) .and. AllTrim(NEWSE2->E2_PARCELA) <> "",.T.) )

				dbSelectArea("TRB2")
				RecLock("TRB2",.T.)	
					TRB2->CODIGO	:= SA2->A2_COD
					TRB2->LOJA		:= SA2->A2_LOJA
					TRB2->NOMEFOR	:= SA2->A2_NOME 
					TRB2->CGC		:= SA2->A2_CGC
					TRB2->TITPAI	:= cTitPai
					TRB2->PREFIXO	:= NEWSE2->E2_PREFIXO
					TRB2->NUM		:= NEWSE2->E2_NUM
					TRB2->PARCELA	:= NEWSE2->E2_PARCELA
					TRB2->TIPO		:= NEWSE2->E2_TIPO
					TRB2->NATUREZ	:= NEWSE2->E2_NATUREZ
					TRB2->EMISSAO	:= NEWSE2->E2_EMISSAO
					TRB2->VENCTO	:= NEWSE2->E2_VENCREA
					TRB2->VALBASE	:= NEWSE2->E2_VALOR
				MSUnlock()
			Endif
			NEWSE2->(DBSKIP())
		Enddo
	Endif			
	dbSelectArea(cAliasSE2)
	(cAliasSE2)->(dbSkip())
EndDo

dbSelectArea("NEWSE2")
DbCloseArea()

dbSelectArea(cAliasSE2)
dbCloseArea()
dbSelectArea("SE2")
dbSetOrder(1)

dbSelectArea("TR1")
TR1->(dbGoTop())
TRB2->(dbGoTop())

Return()

/*/{Protheus.doc} F855DelTRB
//Função estática que libera as tabelas no banco e as variávis de instância.
@author norbertom
@since 11/10/2018
@version P12

@return NIL, Nenhum retorno
@example
F855DelTRB(.T.,NIL)	// Libera todas as tabelas e variáveis de instância
F855DelTRB(.F.,2)	// Libera a tabela indicada no segundo o parâmetro
/*/
Static Function F855DelTRB(lAll,nTRB)
DEFAULT lAll := .F.
DEFAULT nTRB := 0
	
	IF (lAll .or. nTRB == 1) .AND. !EMPTY(_oFR855TR1)
		_oFR855TR1:Delete()
		_oFR855TR1 := NIL
	ENDIF
	IF (lAll .or. nTRB == 2) .AND. !EMPTY(_oFR855TR2)
		_oFR855TR2:Delete()
		_oFR855TR2 := NIL
	ENDIF
	IF (lAll .or. nTRB == 3) .AND. !EMPTY(_oFR855TR3)
		_oFR855TR3:Delete()
		_oFR855TR3 := NIL
	ENDIF
	
Return NIL
