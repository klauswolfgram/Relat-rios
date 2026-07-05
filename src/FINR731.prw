/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR731.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE NATUREZ		1
#DEFINE DESCRIC		2
#DEFINE META		3
#DEFINE JANEIRO		4
#DEFINE FEVEREIRO	5
#DEFINE MARCO		6
#DEFINE ABRIL		7
#DEFINE MAIO		8
#DEFINE JUNHO		9
#DEFINE JULHO		10
#DEFINE AGOSTO		11
#DEFINE SETEMBRO	12
#DEFINE OUTUBRO		13
#DEFINE NOVEMBRO	14
#DEFINE DEZEMBRO	15

Static cSituaca		:= ""	//Lista das situacoes de cobranca a serem demonstradas no relatorio
Static __oFinr731
Static __oFWTMeses
Static __MESES := {'Janeiro','Fevereiro','Marco','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'}

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR731  ³ Autor ³ Daniel Tadashi Batori ³ Data ³ 22.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Comparativo entre Valores Or‡ados x Reais Ano C.C.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR731(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR731()

Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 22.08.06 ³±±
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
Local oFilial //Gestão Corporativa
Local oSecFil //Gestão Corporativa

oReport := TReport():New("FINR731",STR0005,"FIN731", {|oReport| ReportPrint(oReport)},STR0001+STR0002)
pergunte("FIN731",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parƒmetros                        ³
//³      Entradas                                               ³
//³ mv_par01            // da Natureza                          ³
//³ mv_par02            // at‚ a Natureza                       ³
//³      Saidas                                                 ³
//³ mv_par03            // da Natureza                          ³
//³ mv_par04            // at‚ a Natureza                       ³
//³      Outros Parƒmetros                                      ³
//³ mv_par05            // Regime de Caixa/Competˆncia          ³
//³ mv_par06            // Moeda                                ³
//³ mv_par07            // Data de Referˆncia                   ³ 
//³ mv_par08            // Outras Moedas                        ³
//³ mv_par09            // Seleciona Situacao cobranca          ³
//³ mv_par10            // Considera Provisorios?               ³
//³ mv_par11            // Do Centro de Custo?                  ³
//³ mv_par12            // Ate o Centro de Custo?               ³
//³ mv_par13            // Seleciona Filiais ?                  ³ //Gestão Corporativa
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:SetLAndScape(.T.)

oSection1 := TRSection():New(oReport,STR0019,{"SE2"},) //"Mapa"
TRCell():New(oSection1,"ED_CODIGO"	,"SED",STR0020,,,.F.,) //"Cod Natureza"
TRCell():New(oSection1,"CTT_DESC01","CTT",STR0021,,16,.F.,)  //"Descricao"
TRCell():New(oSection1,"META",,,,10,.F.,) 
TRCell():New(oSection1,"Janeiro"	,, STR0022 , "@E 99,999,999.99",13,.F.,) //"Janeiro"
TRCell():New(oSection1,"Fevereiro",, STR0023 , "@E 99,999,999.99",13,.F.,) //"Fevereiro"
TRCell():New(oSection1,"Marco",, STR0024 , "@E 99,999,999.99",13,.F.,) //"Marco"
TRCell():New(oSection1,"Abril",, STR0025 , "@E 99,999,999.99",13,.F.,) //"Abril"
TRCell():New(oSection1,"Maio"	,, STR0026 , "@E 99,999,999.99",13,.F.,) //"Maio"
TRCell():New(oSection1,"Junho",, STR0027 , "@E 99,999,999.99",13,.F.,) //"Junho"
TRCell():New(oSection1,"Julho"	,, STR0028 , "@E 99,999,999.99",13,.F.,) //"Julho"
TRCell():New(oSection1,"Agosto",, STR0029 , "@E 99,999,999.99",13,.F.,) //"Agosto"
TRCell():New(oSection1,"Setembro",, STR0030 , "@E 99,999,999.99",13,.F.,) //"Setembro"
TRCell():New(oSection1,"Outubro",, STR0031 , "@E 99,999,999.99",13,.F.,) //"Outubro"
TRCell():New(oSection1,"Novembro",, STR0032 , "@E 99,999,999.99",13,.F.,) //"Novembro"
TRCell():New(oSection1,"Dezembro",, STR0033	, "@E 99,999,999.99",13,.F.,) //"Dezembro"
oSection1:SetHeaderPage()

oResumo := TRSection():New( oReport,STR0011, {"cArqTmp"}, ) //"Resumo"
TRCell():New(oResumo,"ED_CODIGO"	,"SED",STR0020,,,.F.,) //"Cod Natureza"
TRCell():New(oResumo,"CTT_DESC01","CTT",STR0021,,16,.F.,)  //"Descricao"
TRCell():New(oResumo,"META",,,,10,.F.,) 
TRCell():New(oResumo,"Janeiro"	,, STR0022 , "@E 99,999,999.99",13,.F.,) //"Janeiro"
TRCell():New(oResumo,"Fevereiro",, STR0023 , "@E 99,999,999.99",13,.F.,) //"Fevereiro"
TRCell():New(oResumo,"Marco",, STR0024 , "@E 99,999,999.99",13,.F.,) //"Marco"
TRCell():New(oResumo,"Abril",, STR0025 , "@E 99,999,999.99",13,.F.,) //"Abril"
TRCell():New(oResumo,"Maio"	,, STR0026 , "@E 99,999,999.99",13,.F.,) //"Maio"
TRCell():New(oResumo,"Junho",, STR0027 , "@E 99,999,999.99",13,.F.,) //"Junho"
TRCell():New(oResumo,"Julho"	,, STR0028 , "@E 99,999,999.99",13,.F.,) //"Julho"
TRCell():New(oResumo,"Agosto",, STR0029 , "@E 99,999,999.99",13,.F.,) //"Agosto"
TRCell():New(oResumo,"Setembro",, STR0030 , "@E 99,999,999.99",13,.F.,) //"Setembro"
TRCell():New(oResumo,"Outubro",, STR0031 , "@E 99,999,999.99",13,.F.,) //"Outubro"
TRCell():New(oResumo,"Novembro",, STR0032 , "@E 99,999,999.99",13,.F.,) //"Novembro"
TRCell():New(oResumo,"Dezembro",, STR0033	, "@E 99,999,999.99",13,.F.,) //"Dezembro"
oResumo:SetHeaderSection(.F.)

//Gestão Corporativa - Início
oFilial := TRSection():New(oReport,"",{"SE1"})
TRCell():New(oFilial,"Filial",,,,TamSx3("E1_FILIAL")[1] + Len(STR0037)) //"Filial : "
oFilial:SetHeaderSection(.F.)

oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0038,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0039,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0040,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0041,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

oReport:SetUseGC(.F.)
//Gestão Corporativa - Fim

Return oReport                                                                              

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³22.08.06	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao eStatica ReportDef devera ser criada para todos os  ³±±
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
Local oSection1	:= oReport:Section(1)
Local oResumo		:= oReport:Section(2)

Local aDados[15]
Local cTexto
Local cTitulo := STR0005

Local aNiveis	:= {}
Local aQuebR 	:= {}
Local aQuebO 	:= {}
Local aQuebA 	:= {}
Local nLaco 	:= 0
Local nByte 	:= 0
Local cMapa 	:= ""
Local nLimite 	:= 0
Local nMeses 	:= 0
Local aTotais 	:= {}
Local aOrcado 	:= {}
Local nResult	:= 0
Local cArqTmp 	:= "" 
Local cNatur	:= ""
Local nQuebras := 0

//Gestão Corporativa - Início
Local aAreaSE1 := SE1->(GetArea())
Local aAreaSM0 := SM0->(GetArea())
Local aArea := GetArea()
Local lGestao   := ( FWSizeFilial() > 2 )
Local lSE1Excl  := IIf( lGestao, FWModeAccess("SE1",1) == "E", FWModeAccess("SE1",3) == "E")
Local cSE1Fil  := FWModeAccess("SE1",3)
Local cSE1UN   := FWModeAccess("SE1",2)
Local cSE1Emp  := FWModeAccess("SE1",1)
Local nX 		:= 1
Local nC := 1
Local oSecFil	:= oReport:Section("SECFIL")
Local nRegSM0	:= SM0->(Recno())
Local aSelFil := {}
Local cUNold := ""
Local cEmpOld := ""
Local cFilialAnt := cFilAnt
Local lPrtFil := .T.
Local oFilial		:= oReport:Section(3)
//Gestão Corporativa - Fim

Private nDecs	:= MsDecimais(mv_par06)

oSection1:Cell("ED_CODIGO"):SetBlock( { || aDados[NATUREZ] } )
oSection1:Cell("CTT_DESC01"):SetBlock( { || aDados[DESCRIC] } )
oSection1:Cell("META"):SetBlock( { || aDados[META] } )
oSection1:Cell("Janeiro"):SetBlock	( { || aDados[JANEIRO] } )
oSection1:Cell("Fevereiro"):SetBlock( { || aDados[FEVEREIRO] } )
oSection1:Cell("Marco"):SetBlock		( { || aDados[MARCO] } )
oSection1:Cell("Abril"):SetBlock		( { || aDados[ABRIL] } )
oSection1:Cell("Maio"):SetBlock		( { || aDados[MAIO] } )
oSection1:Cell("Junho"):SetBlock		( { || aDados[JUNHO] } )
oSection1:Cell("Julho"):SetBlock		( { || aDados[JULHO] } )
oSection1:Cell("Agosto"):SetBlock	( { || aDados[AGOSTO] } )
oSection1:Cell("Setembro"):SetBlock	( { || aDados[SETEMBRO] } )
oSection1:Cell("Outubro"):SetBlock	( { || aDados[OUTUBRO] } )
oSection1:Cell("Novembro"):SetBlock	( { || aDados[NOVEMBRO] } )
oSection1:Cell("Dezembro"):SetBlock	( { || aDados[DEZEMBRO] } )

oResumo:Cell("ED_CODIGO"):SetBlock	( { || aDados[NATUREZ] } )
oResumo:Cell("CTT_DESC01"):SetBlock	( { || aDados[DESCRIC] } )
oResumo:Cell("META"):SetBlock( { || aDados[META] } )
oResumo:Cell("Janeiro"):SetBlock		( { || aDados[JANEIRO] } )
oResumo:Cell("Fevereiro"):SetBlock	( { || aDados[FEVEREIRO] } )
oResumo:Cell("Marco"):SetBlock		( { || aDados[MARCO] } )
oResumo:Cell("Abril"):SetBlock		( { || aDados[ABRIL] } )
oResumo:Cell("Maio"):SetBlock			( { || aDados[MAIO] } )
oResumo:Cell("Junho"):SetBlock		( { || aDados[JUNHO] } )
oResumo:Cell("Julho"):SetBlock		( { || aDados[JULHO] } )
oResumo:Cell("Agosto"):SetBlock		( { || aDados[AGOSTO] } )
oResumo:Cell("Setembro"):SetBlock	( { || aDados[SETEMBRO] } )
oResumo:Cell("Outubro"):SetBlock		( { || aDados[OUTUBRO] } )
oResumo:Cell("Novembro"):SetBlock	( { || aDados[NOVEMBRO] } )
oResumo:Cell("Dezembro"):SetBlock	( { || aDados[DEZEMBRO] } )

//Gestão Corporativa - Alterado para não permitir 0
cTexto	:= GetMv("MV_MOEDA"+IIf(mv_par06==0,"1",Str(mv_par06,1)))
cTitulo	+= (cTexto + STR0035 + Str(Year(mv_par07),4,0)) //" de "

oReport:SetTitle(cTitulo)

If mv_par03 > mv_par01
	If mv_par02 >= mv_par03 .or. mv_par02 < mv_par01 .or. mv_par04 < mv_par03
		HELP (" ",1,"R720NAT")
		Return
	EndIf 
ElseIf mv_par04 >= mv_par01 .or. mv_par02 < mv_par01 .or. mv_par04 < mv_par03  
	HELP (" ",1,"R720NAT")
	Return
EndIf 

//Gestão Corporativa - Início
nRegSM0 := SM0->(Recno())

If (lSE1Excl .And. mv_par13 == 1)
	aSelFil := FwSelectGC()
EndIf

If Empty(aSelFil)
	aSelFil := {cFilAnt}
EndIf

SM0->(DbGoto(nRegSM0))

If Len(aSelFil) > 1
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0042 +  ")")	//"Filiais selecionadas para o relatorio"
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
		EndIf
	Next nX
	
	oReport:SetTitle(cTitulo)
	oSecFil:Finish()
	oReport:EndPage()
EndIf

RestArea(aAreaSM0)

If Len(aSelFil) > 1
	aSort(aSelFil)
	cFilAnt := aSelFil[nC]
	cUN     := FWUnitBusiness()
	cEmp    := FWCodEmp()
	cUNold  := cUN
	cEmpOld := cEmp
EndIf

//Esta matriz informa em que posi‡”es ser„o feitas as quebras 1-Byte inicial da quebra, 2-Quantidade de caracteres.          
aNiveis := {}

//Esta matriz armazena as chaves de quebra e os totalizadores parciais
aQuebR 	:= {} //Realizado
aQuebO 	:= {} //Orçado
aQuebA 	:= {}

//Lê a formatação dos códigos das naturezas
cMascNat := GetMV("MV_MASCNAT")
cMapa    := "123456789"

If Empty(cMascNat)
	cMascNat := "19"
	HELP (,,"FR720NAT")
EndIf

For nLaco := 1 to len(cMascNat)
	nByte := Val( Substr( cMascNat,nLaco,1 ) )
	
	If nByte > 0
		AAdd(aNiveis  , { Val(Left(cMapa,1)) , nByte} )
		AAdd(aQuebR   , { "", 0,0,0,0,0,0,0,0,0,0,0,0 } )
		AAdd(aQuebO   , { "", 0,0,0,0,0,0,0,0,0,0,0,0 } )
		AAdd(aQuebA   , { "", 0,0,0,0,0,0,0,0,0,0,0,0 } )
		
		cMapa := Subst(cMapa,nByte+1,Len(cMapa)-nByte)
	EndIf
Next nLaco 

nLimite := IIf(Len(aNiveis) > 1, Len(aNiveis)-1, 1)

oSection1:Init()

For nC := 1 To Len(aSelFil) Step 1
	If aSelFil[nC] <> cFilAnt .And. mv_par13 == 1
		If cSE1Emp == "E" .And. cSE1UN == "E" .And. cSE1Fil == "C" .And. mv_par13 == 1
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
		
		If cSE1Emp == "E" .And. cSE1UN == "C" .And. cSE1Fil == "C" .And. mv_par13 == 1
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
		
		If cSE1Emp == "C" .And. cSE1UN == "C" .And. cSE1Fil == "C" .And. mv_par13 == 1
			nC := Len(aSelFil) + 1
			Loop
		EndIf
		
		aOrcado  := {}
		nResult  := 0
		cArqTmp  := ""
		cNatur   := ""
		nQuebras := 0
		cFilAnt  := aSelFil[nC]
		cUN      := FWUnitBusiness()
		cEmp     := FWCodEmp()
		cUNold   := cUN
		cEmpOld  := cEmp
		
		SE1->(DbSeek(xFilial("SE1")))
		SE2->(DbSeek(xFilial("SE2")))
		
		If SE1->(EOF()) .And. SE2->(EOF())
			Loop
		EndIf
		
		lPrtFil := .T.
	EndIf
	
	//Seleciona situacoes de cobrança
	If MV_PAR09 == 1
		cSituaca := FinSitCob()		//Lista com as situacoes de cobranca selecionada pelo usuario
	EndIf
	
	If Empty(cSituaca)
		cSituaca := FN022LstCb(0)	//Lista com todas as situacoes de cobranca	
	EndIf
	
	Processa( { || U_Fin731Cria(@cArqTmp,,,,,,,,,.T.) }, STR0036 ) //CriAndo arquivo temporário de trabalho
	/*
	Defini‡„o das linhas da matriz aTotais. As colunas se referem aos	
	Meses do Ano.														
	Linha 01 - A Realizar - Entradas									
	Linha 02 - Realizado  - Entradas									
	Linha 03 - A Realizar - Saídas										
	Linha 04 - Realizado  - Saídas										
	Linha 05 - Or‡ado     - Entradas									
	Linha 06 - Or‡ado     - Saídas										
	*/
	aTotais := {{0,0,0,0,0,0,0,0,0,0,0,0} ,;
			 	{0,0,0,0,0,0,0,0,0,0,0,0} ,;
				{0,0,0,0,0,0,0,0,0,0,0,0} ,;
				{0,0,0,0,0,0,0,0,0,0,0,0} ,;
				{0,0,0,0,0,0,0,0,0,0,0,0} ,;
				{0,0,0,0,0,0,0,0,0,0,0,0}  }
	
	aFill(aDados,nil)
	
	//Imprime o relat¢rio a partir do arquivo temporário
	DbSelectArea("cArqTmp")
	cArqTmp->(DbGotop())
	
	//Gestão Corporativa - Início
	If lPrtFil .And. !cArqTmp->(Eof())
		If mv_par13 == 1
			oReport:SkipLine()
			oFilial:Init()
			oFilial:Cell("Filial"):SetBlock({|| STR0037 + xFilial("SE1")}) //"Filial : "
			oFilial:PrintLine()
			oFilial:Finish()
			oReport:SkipLine()
		EndIf
		lPrtFil := .F.
	EndIf
	
	While !cArqTmp->(Eof())
		cCcusto := 	cArqTmp->CCUSTO
		oReport:PrintText( AllTrim(cArqTmp->CCusto + " - " + cArqTmp->DescCC) )
		oReport:SkipLine()
		
		While !cArqTmp->(Eof())	.And. cArqTmp->CCUSTO == cCcusto
			//Inicia a matriz acumuladora de quebras
			For nLaco := 1 to Len(aQuebR)
				 aQuebR[nLaco,1] := Subst(cArqtmp->Natur, aNiveis[nLaco,1], aNiveis[nLaco,2]) + cCcusto
				 aQuebO[nLaco,1] := Subst(cArqtmp->Natur, aNiveis[nLaco,1], aNiveis[nLaco,2]) + Ccusto
				 aQuebA[nLaco,1] := Subst(cArqtmp->Natur, aNiveis[nLaco,1], aNiveis[nLaco,2]) + cCcusto
			Next nLaco
			
			aOrcado := { 0,0,0,0,0,0,0,0,0,0,0,0 }
			
			For nLaco := 1 To 12
				aOrcado[nLaco] += GetOrcadoCC(Year(mv_par07), nLaco, MV_PAR06, cArqTmp->NATUR, cArqTmp->CCUSTO, MV_PAR07)
			Next nLaco
			
			cNatur := cArqTmp->Natur
			aDados[NATUREZ] := Mascnat(cArqtmp->Natur)
			aDados[DESCRIC] := Left(cArqTmp->DESCR,16)
			
			//Este For avan‡a blocos de 12 em 12 registros
			aRealizado := {0,0,0,0,0,0,0,0,0,0,0,0}
			aARealizar := {0,0,0,0,0,0,0,0,0,0,0,0}
			
			For nMeses := 1 to 12
				aRealizado[nMeses] := cArqtmp->rEntr+cArqtmp->rSaid
				aARealizar[nMeses] := cArqtmp->aEntr+cArqtmp->aSaid
				
				//Acumula os totais e os parciais
				aTotais[1,nMeses] += cArqTmp->aEntr
				aTotais[2,nMeses] += cArqtmp->rEntr
				aTotais[3,nMeses] += cArqTmp->aSaid
				aTotais[4,nMeses] += cArqtmp->rSaid
				
				/*Armazena em separado o orcado para naturezas de entrada
				e naturezas de sa¡da. o Usu rio n„o deve misturar as naturezas*/				
				If cArqTmp->ENTR == "E"
					aTotais[5,nMeses] += aOrcado[nMeses]
				ElseIf cArqTmp->SAID == "S"
					aTotais[6,nMeses] += aOrcado[nMeses]
				EndIf
				
				/*Lança em todos os niveis da quebra, pois estaremos trabalhando sempre com niveis 
				hieraquicos de um braço principal inico da raiz*/
				For nLaco := 1 to Len(aQuebR) // Todos os niveis
					 aQuebR[nLaco,nMeses+1] += cArqtmp->rEntr+cArqtmp->rSaid
					 aQuebA[nLaco,nMeses+1] += cArqtmp->aEntr+cArqtmp->aSaid
					 aQuebO[nLaco,nMeses+1] += aOrcado[nMeses]
				Next nLaco
				
				DbSkip()
			Next nMeses
			
			aDados[META] := STR0008 //ORCADO
			
			For nMeses := 1 to 12
				aDados[3 + nMeses] := aOrcado[nMeses]
			Next nMeses
			
			oSection1:PrintLine()
			aFill(aDados,nil)
			aDados[META] := STR0009 //REALIZADO
			
			For nMeses := 1 to 12
				aDados[3 + nMeses] := aRealizado[nMeses]
			Next nMeses
			
			oSection1:PrintLine()
			aFill(aDados,nil)

			aDados[META] := STR0010 //A REALIZAR
			
			For nMeses := 1 to 12
				aDados[3 + nMeses] := aARealizar[nMeses]
			Next nMeses
			
			oSection1:PrintLine()
			aFill(aDados,nil)
			aDados[META] := STR0011 //REAL

			For nMeses := 1 to 12
				aDados[3 + nMeses] := aARealizar[nMeses]+aRealizado[nMeses]
			Next nMeses
			
			oSection1:PrintLine()
			aFill(aDados,nil)
			
			aDados[META] := STR0012 //% VARIACAO
			
			For nMeses := 1 to 12
				If aOrcado[nMeses] # 0
					aDados[3 + nMeses] := ( (aRealizado[nMeses]+aArealizar[nMeses]) / aOrcado[nMeses]) * 100
				Else
					aDados[3 + nMeses] := aOrcado[nMeses]
				EndIf
			Next nMeses
			
			oSection1:PrintLine()
			aFill(aDados,nil)
			oReport:SkipLine()
			
			DbSelectArea("cArqTmp")
			
			//VerIfica se houve quebra em algum nível
			lQuebra := .F.
			
			For nLaco := 1 to nLimite
				If aQuebR[nLaco,1] # Subst(cArqTmp->NATUR, aNiveis[nLaco,1], aNiveis[nLaco,2] ) + cArqTmp->CCUSTO
					For nQuebras := nLimite to nLaco Step -1
						cQuebra := Left(cNatur, aNiveis[nQuebras,1] + aNiveis[nQuebras,2] - 1 )
						cQuebra := MascNat( cQuebra )
						
						While right(cQuebra,1) == "."
							cQuebra := Left(cQuebra,Len(cQuebra)-1)
						EndDo
						
						aDados[DESCRIC] := STR0013 + cQuebra //T O T A L
						
						//Inicia as quebras de baixo para cima at‚ o ponto da quebra
						aDados[META] := STR0008  //ORCADO
						For nMeses := 2 to 13
							aDados[2 + nMeses] := aQuebO[nQuebras,nMeses]
						Next

						oSection1:PrintLine()
						aFill(aDados,nil)
						aDados[META] := STR0009  //REALIZADO
						
						For nMeses := 2 to 13
							aDados[2 + nMeses] := aQuebR[nQuebras,nMeses]
						EndFor
						
						oSection1:PrintLine()
						aFill(aDados,nil)

						aDados[META] := STR0010  //A REALIZAR

						For nMeses := 2 to 13
							aDados[2 + nMeses] := aQuebA[nQuebras,nMeses]
						Next
						
						oSection1:PrintLine()
						aFill(aDados,nil)
						aDados[META] := STR0011  //REAL
						
						For nMeses := 2 to 13
							aDados[2 + nMeses] := aQuebA[nQuebras,nMeses]+aQuebr[nQuebras,nMeses]
						Next
						
						oSection1:PrintLine()
						aFill(aDados,nil)
						aDados[META] := STR0012  //% VARIACAO

						For nMeses := 2 to 13
							If aQuebO[nQuebras,nMeses] > 0
								aDados[2 + nMeses] := ((aQuebR[nQuebras,nMeses]+aQuebA[nQuebras,nMeses])/aQuebO[nQuebras,nMeses])*100 
							Else
								aDados[2 + nMeses] := aQuebO[nQuebras,nMeses]
							EndIf
						Next
						
						oSection1:PrintLine()
						aFill(aDados,nil)
						oReport:SkipLine()
						
						/*Limpa os n¡veis de quebra somente apção a impressão pois caso contrário
						não haveria como calcular o %.*/
						For nMeses := 2 To 13
							aQuebR[nQuebras,nMeses] := 0
							aQuebO[nQuebras,nMeses] := 0
							aQuebA[nQuebras,nMeses] := 0
						Next
					Next
					
					Exit
				EndIf
			Next
			
			If cArqTmp->(Eof())
				Exit
			EndIf
		EndDo	
	EndDo
	
	oReport:SkipLine()
	oResumo:Init()
	aFill(aDados,nil)
	oReport:ThinLine()
	oReport:PrintText(STR0014)  //RESUMO
	oReport:ThinLine()
	
	//Imprime os totais relacionados as entradas 
	aDados[DESCRIC] := STR0015  //Entradas
	aDados[META] := STR0008   //ORCADO
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[5,nMeses]
	Next nMeses
	
	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0009  //REALIZADO
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[2,nMeses]
	Next nMeses
	
	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0010  //A REALIZAR
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[1,nMeses]
	Next nMeses

	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0011 //REAL
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[1,nMeses]+aTotais[2,nMeses]
	Next nMeses

	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0012  //% VARIACAO
	
	For nMeses := 1 to 12
		If aTotais[5,nMeses] > 0
			aDados[3 + nMeses] := ( (aTotais[1,nMeses]+aTotais[2,nMeses])/ aTotais[5,nMeses])*100 
		Else
			aDados[3 + nMeses] := aTotais[5,nMeses]
		EndIf
	Next nMeses
	
	oResumo:PrintLine()
	aFill(aDados,nil)
	
	//Imprime os totais relacionados as saídas
	oReport:ThinLine()
	aDados[DESCRIC] := STR0016  //Saidas
	aDados[META] := STR0008   //ORCADO
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[6,nMeses]
	Next nMeses
	
	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0009  //REALIZADO
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[4,nMeses]
	Next nMeses
	
	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0010  //A REALIZAR
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[3,nMeses]
	Next nMeses
	
	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0011  //REAL
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[3,nMeses]+aTotais[4,nMeses]
	Next nMeses
	
	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0012  //% VARIACAO
	
	For nMeses := 1 to 12
		If aTotais[6,nMeses] > 0
			nVar := aTotais[4,nMeses]+aTotais[3,nMeses]
			nVar /= aTotais[6,nMeses]
			nVar *= 100
			aDados[3 + nMeses] := nVar
		Else
			aDados[3 + nMeses] := aTotais[6,nMeses]
		EndIf
	Next nMeses
	
	oResumo:PrintLine()
	aFill(aDados,nil)
	
	//Faz o Balan‡o e apresenta o saldo.
	oReport:ThinLine()
	aDados[DESCRIC] := STR0017  //Saldos
	aDados[META] := STR0008   //ORCADO
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[5,nMeses]-aTotais[6,nMeses]
	Next nMeses

	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0009  //REALIZADO
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[2,nMeses]-aTotais[4,nMeses]
	Next nMeses

	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0010  //A REALIZAR
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[1,nMeses]-aTotais[3,nMeses]
	Next nMeses

	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0011 //REAL
	
	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[1,nMeses]-aTotais[3,nMeses]+aTotais[2,nMeses]-aTotais[4,nMeses]
	Next nMeses
	
	oResumo:PrintLine()
	aFill(aDados,nil)
	aDados[META] := STR0012 //% VARIACAO
	
	For nMeses := 1 to 12
		nVar := aTotais[1,nMeses]-aTotais[3,nMeses]+aTotais[2,nMeses]-aTotais[4,nMeses]
		nVar /= aTotais[5,nMeses]+aTotais[6,nMeses]
		nVar *= 100
		aDados[3 + nMeses] := nVar
	Next nMeses
	
	oResumo:PrintLine()
	aFill(aDados,nil)
	oReport:ThinLine()
	oResumo:Finish()
	
	DbSelectArea("SE5")
	RetIndex("SE5")
	DbSelectArea("cArqTmp")
	cArqTmp->(DbCloseArea())
	Ferase(cArqTmp+GetDBExtension())
	Ferase(cArqTmp+OrdBagExt())
Next

oSection1:Finish()

cFilAnt := cFilialAnt
RestArea(aAreaSE1)
RestArea(aArea)
Return

//--------------------------------------------
/*/{Protheus.doc} U_FR731SE5()
Cria tabela temporária com os movimentos que 
foram rateados no momento da baixa para gerar
o realizado

@param nRecCount, Numeric, Quant. de registros encontrados
@Return cTmpSE5, Char, Alias da tabela temporária

@author Vinícius Barreira
@since 04/09/94
/*/
//--------------------------------------------
User Function FR731SE5(nRecCount As Char, cFilialSE5 As Char) As Char
	Local cTmpSE5 As Char
	Local cQuery  As Char
	
	Default nRecCount  := 0
	Default cFilialSE5 := xFilial("SE5")
	
	//Inicializa variáveis
	cTmpSE5 := ""
	
	cQuery := "SELECT DISTINCT SE5.R_E_C_N_O_ SE5RECNO "
	cQuery += "FROM " + RetSqlName("SE5") + " SE5 "
	cQuery += "INNER JOIN " + RetSqlName("SEV") + " SEV "
	cQuery += "ON (SEV.EV_FILIAL = SE5.E5_FILIAL AND SEV.EV_IDDOC = SE5.E5_IDORIG) "
	cQuery += "INNER JOIN " + RetSqlName("SEZ") + " SEZ "
	cQuery += "ON (SEZ.EZ_FILIAL = SE5.E5_FILIAL AND SEZ.EZ_IDDOC = SE5.E5_IDORIG) "
	cQuery += "WHERE SE5.E5_FILIAL = '" + cFilialSE5 + "' "
	
	If MV_PAR05 == 1 //Regime de caixa
		cQuery += "AND SE5.E5_DATA BETWEEN '" + DTOS(BegOfYea(MV_PAR07)) + "' AND '" + DTOS(MV_PAR07) + "' "
	Else //Regime de Competência
		cQuery += "AND SE5.E5_DTDIGIT BETWEEN '" + DTOS(BegOfYea(MV_PAR07)) + "' AND '" + DTOS(MV_PAR07) + "' "
	EndIf

	cQuery += "AND SE5.E5_MULTNAT = '1' "
	cQuery += "AND (E5_TIPODOC NOT IN ('DC','JR','MT','CM','D2','J2','M2','C2','TL','CP','BL') OR E5_SITUACA NOT IN('C','E','X')) "
	cQuery += "AND SE5.D_E_L_E_T_ = ' ' "
	
	If !Empty(MV_PAR02) .And. !Empty(MV_PAR04)
		cQuery += "AND ((SEV.EV_NATUREZ BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "') " 
		cQuery += "OR (SEV.EV_NATUREZ BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "')) "
	ElseIf Empty(MV_PAR02) .And. !Empty(MV_PAR04)
		cQuery += "AND SEV.EV_NATUREZ BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
	ElseIf !Empty(MV_PAR02) .And. Empty(MV_PAR04)
		cQuery += "AND SEV.EV_NATUREZ BETWEEN '" + MV_PAR01 + "' And '" + MV_PAR02 + "' "
	EndIf	
	
	cQuery += "AND SEV.EV_IDENT = '2' AND SEV.D_E_L_E_T_ = ' ' "
	cQuery += "AND SEZ.EZ_CCUSTO BETWEEN '" + MV_PAR11 + "' AND '" + MV_PAR12 + "' "
	cQuery += "AND SEZ.EZ_IDENT = '2' AND SEZ.D_E_L_E_T_ = ' ' "
	cQuery  := ChangeQuery(cQuery)
	cTmpSE5 := MpSysOpenQuery(cQuery)
	
	If (cTmpSE5)->(!Eof())
		(cTmpSE5)->(DbEval({|| nRecCount++}, {|| .T.}))
		(cTmpSE5)->(DbGotop())
	EndIf
Return cTmpSE5

//--------------------------------------------
/*/{Protheus.doc} ListaCCust()
Cria tabela temporária de centro de custo, 
filtrada pelo range de centro de custos
configurados nos parâmetros: mv_par011 e mv_par02

@param nRecCount, Numeric, Quant. de registros encontrados
@Return cTmpCTT, Char, Alias da tabela temporária

@author Norberto M de Melo
@since 07/09/2021
/*/
//--------------------------------------------
Static Function ListaCCust(nRecCount As Numeric) As Char
	Local cTmpCTT  As Char
	Local cQuery   As Char
	Local cFromWhe As Char
	
	Default nRecCount := 0
	
	//Inicializa variáveis
	cTmpCTT  := ""
	cFromWhe := ""
	
	cQuery   := "SELECT CTT_FILIAL, CTT_CUSTO, R_E_C_N_O_ CTTRECNO "
	cFromWhe := "FROM " + RetSqlName("CTT") + " WHERE "
	cFromWhe += "CTT_FILIAL = '" + xFilial("CTT") + "' "
	cFromWhe += "AND CTT_CUSTO BETWEEN '" + MV_PAR11 + "' AND '" + MV_PAR12 + "' " 
	cFromWhe += "AND D_E_L_E_T_ = ' ' "
	cQuery   := ChangeQuery(cQuery+cFromWhe)
	cTmpCTT  := MpSysOpenQuery(cQuery)	
	
	If !(cTmpCTT)->(Eof())
		nRecCount := MpSysExecScalar("SELECT COUNT(CTT_CUSTO) TOTALREG " + cFromWhe, "TOTALREG")
	EndIf
Return cTmpCTT

//--------------------------------------------
/*/{Protheus.doc} ListaNatur()
Cria tabela temporária (SED), filtrada
pelo range de naturezas de entrada 
e saídas

@param cFilialSED, Char, Filial corrente/logada da natureza
@Return cTmpSED, Char, Alias da tabela temporária

@param cAlias - Alias da tabela 
@author Norberto M de Melo
@since 07/09/2021
@type Static Function
/*/
//--------------------------------------------
Static Function ListaNatur(cFilialSED) As Char
	Local cTmpSED As Char
	Local cQuery  As Char
	
	Default cFilialSED := xFilial("SED")
	
	//Inicializa variáveis
	cTmpSED := ""	
	
	//Consulta responsável pela criação da tabela SED temporária
	cQuery := "SELECT SED.ED_FILIAL, SED.ED_CODIGO, SED.R_E_C_N_O_ SEDRECNO, SED.ED_DESCRIC "
	cQuery += "FROM " + RetSqlName("SED") + " SED "
	cQuery += "WHERE SED.ED_FILIAL = '" + cFilialSED + "' "
	
	If !Empty(MV_PAR02) .And. !Empty(MV_PAR04)
		cQuery += "AND (ED_CODIGO BETWEEN '" + MV_PAR01 + "' And '" + MV_PAR02 + "' " 
		cQuery += "OR ED_CODIGO BETWEEN '" + MV_PAR03 + "' And '" + MV_PAR04 + "') "
	ElseIf Empty(MV_PAR02) .And. !Empty(MV_PAR04)
		cQuery += "AND ED_CODIGO BETWEEN '" + MV_PAR03 + "' And '" + MV_PAR04 + "' "
	ElseIf !Empty(MV_PAR02) .And. Empty(MV_PAR04)
		cQuery += "AND ED_CODIGO BETWEEN '" + MV_PAR01 + "' And '" + MV_PAR02 + "' "
	EndIf
	
	cQuery += "AND SED.D_E_L_E_T_ = ' ' "
	cQuery  := ChangeQuery(cQuery)
	cTmpSED := MpSysOpenQuery(cQuery)
Return cTmpSED

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ Fr733Pos ³ Autor ³ Claudio D. de Souza   ³ Data ³ 28/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Posiciona o arquivo tempor rio de acordo com a natureza    ³±±
±±³          ³ e data (mˆs) passado como parƒmetro.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Fr733Pos(cNatureza,dData)                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Natureza e Data                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR731                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fr733Pos(cNaturez, dData, cCCusto, cDescCC, cTipoMov, cDescNat)
	Local cMes   As Char	
	Local cTpMov As Char
	Local nMeses As Numeric
	Local nMes   As Numeric
	Local aArea  As Array
	
	Default cNaturez :=  "" 
	Default dData    := dDataBase
	Default cCCusto  := ""
	Default cDescCC  := ""
	Default cTipoMov := ""	
	Default cDescNat := ""
	
	//Inicializa variáveis
	cMes   := StrZero(Month(dData), 2, 0)
	cTpMov := If(cTipoMov == "E", " E ", "  S")
	nMeses := 12
	nMes   := 1
	aArea  := GetArea()
	
	DbSelectArea("cArqTmp")
	
	If !cArqTmp->(DbSeek(cCCusto+cNaturez+cMes+cTpMov))
		For nMes := 1 To nMeses
			If !cArqTmp->(DbSeek(cCusto+cNaturez+StrZero(nMes, 2, 0)))
				RecLock("cArqTmp",.T.)
				cArqTmp->NATUR := cNaturez
				cArqTmp->CCUSTO:= cCCusto
				cArqTmp->DESCCC:= cDescCC
				cArqTmp->DESCR := cDescNat
				cArqTmp->MES   := StrZero(nMes, 2, 0)
				
				If cTipoMov == "E"
					cArqTmp->ENTR := "E"
				ELSE
					cArqTmp->SAID := "S"
				EndIf
			EndIf	
		Next nMes
		
		cArqTmp->(DbSeek(cCCusto+cNaturez+cMes))
	EndIf
	
	RecLock("cArqTmp")
	RestArea(aArea)
	FwFreeArray(aArea)
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fin731Cria³ Autor ³ Claudio D. de Souza   ³ Data ³ 28/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Monta arquivo temporario para apresentacao orcado x real   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Fin731Cria(cArqTmp,cIndex1,cIndex2,cIndex3,lRelato)        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cArqTmp - Nome do Arquivo temporario a ser criado          ³±±
±±³          ³ cIndex1 - Nome do indice temporario  Contas a Receber      ³±±
±±³          ³ cIndex2 - Nome do indice temporario  Contas a Pagar        ³±±
±±³          ³ cIndex3 - Nome do indice temporario  Movimento Bancario    ³±±
±±³          ³ lRelato - Indica se e chamado via relatorio (Default .T.)  ³±±
±±³          ³ aNivel   - Array com nivels de quebra                      ³±±
±±³          ³ aQuebras - Array de Quebras baseado MV_MASCNAT             ³±±
±±³          ³ lR4		- logico para dizer se eh R4				           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaFin                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fin731Cria(cArqTmp, cIndex1, cIndex2, cIndex3, lRelato, aNiveis, aQuebR,aQuebO, aQuebA, lR4)
	Local nMoedaBco	:= 1
	Local nSaldoTit := 0
	Local aOrcado	:= {}
	Local aArrayQ   := {}
	Local aTotais 	:= { {Capital(STR0009),0,0,0,0,0,0,0,0,0,0,0,0} ,;
								{Capital(STR0010),0,0,0,0,0,0,0,0,0,0,0,0} ,;
								{Capital(STR0009),0,0,0,0,0,0,0,0,0,0,0,0} ,;
								{Capital(STR0010),0,0,0,0,0,0,0,0,0,0,0,0} ,;
								{Capital(STR0008),0,0,0,0,0,0,0,0,0,0,0,0} ,;
								{Capital(STR0008),0,0,0,0,0,0,0,0,0,0,0,0}  }, cNatur, aTotal := {}

	Local nMeses       := 12
	Local nLaco        := 0
	Local nQuebras     := 0
	Local nContador    := 0
	Local dDataTemp    := CTOD("")
	Local cTmpSE5   := ""
	Local aSaldoTit    := {}
	Local nI           := 0
	Local cFWT         := GetNextAlias()
	Local cCommAnd     := ""
	Local cInsert      := ""
	Local nPosNatureza := 0
	Local nPosCCusto   := 0
	Local cSE5Key      := ""
	Local cTmpCTT      := ""
	Local cTmpSED      := ""
	Local cPrefTit     := ""
	Local cNumeTit     := ""
	Local cParcTit     := ""
	Local cTipoTit     := ""
	Local cClieFor     := ""
	Local cLojaTit     := ""
	Local dDtEmissao   := CTOD("//")
	Local dDtVencRea   := dDtEmissao
	Local nMoedaTit    := 1
	Local cTblSE1SE2   := "SE1"
	Local cTipoNatur   := "E"
	Local cChaveSEZ    := ""
	Local cFilialSEZ   := ""	
	Local cFilialSE1   := ""
	Local cFilialSE2   := ""
	Local cFilialSE5   := ""
	Local cFilialSEF   := ""
	Local cFilialCTT   := ""
	
	Default lRelato	:= .T.
	Default lR4 := .F.
	
	//Gera arquivo de Trabalho
	aCampos := { {"NATUR", "C", Len(SED->ED_CODIGO), 0},;  // Cod. da Natureza
				{"CCUSTO", "C", Len(CTT->CTT_CUSTO), 0},;	// Cod. Centro de Custo
				{"DESCCC", "C", Len(CTT->CTT_DESC01), 0},;	// Desc. Centro de Custo
				{"MES",    "C", 03, 0},;
				{"ENTR",   "C", 01, 0},;
				{"SAID",   "C", 01, 0},;
				{"DESCR",  "C", 30, 0},;
				{"AENTR",  "N", 17, 2},;
				{"ASAID",  "N", 17, 2},;
				{"RENTR",  "N", 17, 2},;
				{"RSAID",  "N", 17, 2}}

	aCamposFWT := {{"MES", "C", 02, 0}, {"DESCRICAO", "C", 20, 0}}
	
	If (__oFinr731 <> NIL)
		__oFinr731:Delete()
		__oFinr731 := NIL
	EndIf
	
	If (__oFWTMeses <> NIL)
		__oFWTMeses:Delete()
		__oFWTMeses := NIL
	EndIf
	
	//CriAndo a tabela temporaria
	__oFinr731 := FwTemporaryTable():New("cArqTmp")
	__oFWTMeses := FwTemporaryTable():New(cFWT)
	__oFinr731:SetFields(aCampos)
	__oFWTMeses:SetFields(aCamposFWT)
	__oFinr731:AddIndex("1",{"CCUSTO","NATUR","MES","ENTR","SAID"})
	__oFWTMeses:AddIndex("1",{"MES"})
	__oFinr731:Create()
	__oFWTMeses:Create()
	
	cInsert := " INSERT "
	
	If AllTrim(UPPER(TCGetDB())) == "ORACLE"
		cInsert += " /*+ APPEND */ "
	EndIf
	
	For nI := 1 To nMeses
		cCommAnd := cInsert + " INTO " + __oFWTMeses:GetRealName() + " (MES,DESCRICAO) VALUES ('"+ STRZERO(nI,2) + "','" + __MESES[nI] +"')"
		If !Empty(nErrorSQL := TCSqlExec(cCommAnd))
			Exit
		EndIf
	Next nI
	
	If Empty(nErrorSQL)
		cQuery := "SELECT DISTINCT ED_CODIGO, CTT_CUSTO, CTT_DESC01, MES, ED_DESCRIC, "
		cQuery += "CASE WHEN ED_CODIGO BETWEEN '" + MV_PAR01 + "' And '" + MV_PAR02 + "' THEN 'E' ELSE ' ' END ENTR, "
		cQuery += "CASE WHEN ED_CODIGO BETWEEN '" + MV_PAR03 + "' And '" + MV_PAR04 + "' THEN 'S' ELSE ' ' END SAID "
		cQuery += "FROM " + RetSQLName("SED") + " SED "
		cQuery += "INNER JOIN " + RetSQLName("CTT") + " CTT ON (CTT.CTT_NORMAL IN (' ','0','1') And SED.ED_COND IN (' ','D') OR CTT.CTT_NORMAL IN (' ','0','2') And SED.ED_COND IN (' ','R')) "
		cQuery += "INNER JOIN " + __oFWTMeses:GetRealName() + " MESES ON 1 = 1 "
		cQuery += "WHERE "
		cQuery += "ED_FILIAL = '" + xFilial("SED") + "' And "
		cQuery += "CTT_FILIAL = '" + xFilial("CTT") + "' And "
		
		If !Empty(MV_PAR02) .And. !Empty(MV_PAR04)
			cQuery += "(ED_CODIGO BETWEEN '" + MV_PAR01 + "' And '" + MV_PAR02 + "' OR ED_CODIGO BETWEEN '" + MV_PAR03 + "' And '" + MV_PAR04 + "') "
		ElseIf Empty(MV_PAR03) .And. Empty(MV_PAR04)
			cQuery += "ED_CODIGO BETWEEN '" + MV_PAR01 + "' And '" + MV_PAR02 + "' "
		ElseIf Empty(MV_PAR01) .And. Empty(MV_PAR02)
			cQuery += "ED_CODIGO BETWEEN '" + MV_PAR03 + "' And '" + MV_PAR04 + "' "
		EndIf
		
		If !Empty(MV_PAR12)
			cQuery += "And (CTT_CUSTO BETWEEN '" + MV_PAR11 + "' And '" + MV_PAR12 + "') "
		EndIf
		
		cQuery += "And SED.D_E_L_E_T_ = ' ' "
		cQuery += "And CTT.D_E_L_E_T_ = ' ' "
		// Cláusula ORDER BY
		cQuery += "ORDER BY CTT_CUSTO,ED_CODIGO "

		cCommAnd := cInsert + " INTO " + __oFinr731:GetRealName() + " (NATUR,CCUSTO,DESCCC,MES,DESCR,ENTR,SAID) " + cQuery
		nErrorSQL := TCSqlExec(cCommAnd)
	EndIf
	
	If !Empty(nErrorSQL)
		MsgAlert(STR0007 + ':[' + TCSQLError() + ']','TCSQLError ') // "SelecionAndo Registros..."###"TCSQLError"
		Return .F.
	EndIf
	
	DbSelectArea("SE1")
	SE1->(DbSetOrder(1))
	DbSelectArea("SE2")
	SE2->(DbSetOrder(1))
	DbSelectArea("SED")
	SED->(DbSetOrder(1))
	DbSelectArea("SEZ")
	SEZ->(DbSetOrder(2))
	DbSelectArea("CTT")
	
	//Processa todos os Centros de Custo da Faixa Selecionada
	nContador  := 0
	cTmpCTT    := ListaCCust(@nContador)
	cFilialSED := xFilial("SED")
	cFilialSEZ := xFilial("SEZ")
	cFilialSE1 := xFilial("SE1")
	cFilialSE2 := xFilial("SE2")	
	ProcRegua(nContador)
	
	While (cTmpCTT)->(!Eof()) .And. (cTmpCTT)->CTT_CUSTO <= mv_par12
		CTT->(DbGoto((cTmpCTT)->CTTRECNO))
		IncProc()
		
		If Empty(cTmpSED)
			cTmpSED := ListaNatur(cFilialSED)
		EndIf
		
		(cTmpSED)->(DbGotop())
		
		While (cTmpSED)->(!Eof())
			cChaveSEZ := (cFilialSEZ + "1" + (cTmpSED)->ED_CODIGO + CTT->CTT_CUSTO)
			
			If !SEZ->(MsSeek(cChaveSEZ)) .Or. Empty(SEZ->EZ_RECPAG) 
				(cTmpSED)->(DbSkip())
				Loop
			EndIf
			
			nEntr     := 0
			nSaid     := 0
			nRealEntr := 0
			nRealSaid := 0
			nSaldoTit := 0
			
			While SEZ->(!Eof()) .And. SEZ->(EZ_FILIAL+EZ_IDENT+EZ_NATUREZ+EZ_CCUSTO) == cChaveSEZ
				nSaldoTit := 0
				
				If SEZ->EZ_RECPAG == "R"
					If ((SEZ->EZ_NATUREZ < MV_PAR01) .Or. (SEZ->EZ_NATUREZ > MV_PAR02))
						SEZ->(DbSkip())
						Loop						
					EndIf
					
					If !SE1->(MsSeek(cFilialSE1+SEZ->(EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO)))
						SEZ->(DbSkip())
						Loop
					EndIf
					
					If !SE1->E1_SITUACA $ cSituaca
						SEZ->(DbSkip())
						Loop
					EndIf					
					
					cPrefTit   := SE1->E1_PREFIXO
					cNumeTit   := SE1->E1_NUM
					cParcTit   := SE1->E1_PARCELA
					cTipoTit   := SE1->E1_TIPO 
					cClieFor   := SE1->E1_ClIENTE
					cLojaTit   := SE1->E1_LOJA					
					dDtEmissao := SE1->E1_EMISSAO
					dDtVencRea := SE1->E1_VENCREA
					nMoedaTit  := SE1->E1_MOEDA
					cTblSE1SE2 := "SE1"
					cTipoNatur := "E"					
				Else
					If ((SEZ->EZ_NATUREZ < MV_PAR03) .Or. (SEZ->EZ_NATUREZ > MV_PAR04))
						SEZ->(DbSkip())
						Loop						
					EndIf					
					
					If !SE2->(MsSeek(cFilialSE2+SEZ->(EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA)))
						SEZ->(DbSkip())
						Loop						
					EndIf
					
					cPrefTit   := SE2->E2_PREFIXO
					cNumeTit   := SE2->E2_NUM
					cParcTit   := SE2->E2_PARCELA
					cTipoTit   := SE2->E2_TIPO 
					cClieFor   := SE2->E2_FORNECE
					cLojaTit   := SE2->E2_LOJA					
					dDtEmissao := SE2->E2_EMISSAO
					dDtVencRea := SE2->E2_VENCREA
					nMoedaTit  := SE2->E2_MOEDA
					cTblSE1SE2 := "SE2"
					cTipoNatur := "S"
				EndIf
				
				If (dDtEmissao > mv_par07) .Or. (mv_par08 == 2 .And. nMoedaTit != mv_par06)
					SEZ->(DbSkip())
					Loop
				EndIf
				
				If (cTipoTit $ MVABATIM +"|" + MVPAGANT + "|" + MVRECANT + "|" + MV_CRNEG)
					SEZ->(DbSkip())
					Loop
				EndIf
				
				If (mv_par10 == 2 .And. cTipoTit $ MVPROVIS)
					SEZ->(DbSkip())
					Loop				
				EndIf
				
				aSaldoTit := SdoTitNat(cPrefTit, cNumeTit, cParcTit, cTipoTit, cClieFor, cLojaTit, Nil, SEZ->EZ_RECPAG, cTblSE1SE2, MV_PAR06, .T., MV_PAR07, MV_PAR07)				
				
				If Len(aSaldoTit) > 0 .And. (nPosNatureza := AScan(aSaldoTit,{|e| E[1] == SEZ->EZ_NATUREZ})) > 0
					If nPosNatureza > 0 .And. !Empty(nPosCCusto := AScan(aSaldoTit[nPosNatureza][6], {|E| E[1] == SEZ->EZ_CCUSTO}))
						nSaldoTit := aSaldoTit[nPosNatureza,6][nPosCCusto][2]
					EndIf		
				EndIf
				
				//Posiciona o arquivo temporário na natureza/mes correspondente ao registro
				fr733Pos(SEZ->EZ_NATUREZ, dDtVencRea, CTT->CTT_CUSTO, CTT->CTT_DESC01, cTipoNatur, (cTmpSED)->ED_DESCRIC)
				
				If SEZ->EZ_RECPAG == "R"
					cArqTmp->aEntr += nSaldoTit
				Else
					cArqTmp->aSaid += nSaldoTit
				EndIf			
				
				SEZ->(DbSkip())
			EndDo
			
			(cTmpSED)->(DbSkip())
		EndDo		
		
		(cTmpCTT)->(DbSkip())
	EndDo
	
	nMeses := 0
	
	If !Empty(cTmpCTT) .And. Select(cTmpCTT) > 0
		(cTmpCTT)->(DbCloseArea())
	EndIf
	
	If !Empty(cTmpSED) .And. Select(cTmpSED) > 0
		(cTmpSED)->(DbCloseArea())
	EndIf
	
	//Restaura os arquivos de contas a receber / pagar para auxiliar an lise do se5 caso seja escolhido regime de caixa
	RetIndex("SE1")
	Set Filter To
	RetIndex("SE2")
	Set Filter To
	
	DbSelectArea("SEF")
	DbSelectArea("SE5")
	SEF->(DbSetOrder(1))
	SEZ->(DbSetOrder(3))
	SA6->(DbSetOrder(1))

	nContador  := 0	
	cFilialSE5 := xFilial("SE5")
	cFilialSEF := xFilial("SEF")	
	cFilialCTT := xFilial("CTT")
	cTmpSE5 := U_FR731Se5(@nContador, cFilialSE5)
	ProcRegua(nContador)
	
	While (cTmpSE5)->(!Eof())
		SE5->(DbGoto((cTmpSE5)->SE5RECNO))
		IncProc()
		
		If SE5->E5_TIPODOC == "CH"
			If SEF->(DbSeek(cFilialSEF+SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ))) .And. SEF->EF_ORIGEM != "FINA390AVU"
				(cTmpSE5)->(DbSkip())
				Loop
			EndIf
		EndIf
		
		If !Empty(SE5->E5_MOTBX) .And. !MovBcoBx(SE5->E5_MOTBX)
			(cTmpSE5)->(DbSkip())
			Loop
		EndIf
		
		If !Empty(SE5->E5_NUMERO) .And. TemBxCanc(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ)
			(cTmpSE5)->(DbSkip())
			Loop
		EndIf
		
		If cPaisLoc	# "BRA"
			SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
			nMoedaBco := Max(SA6->A6_MOEDA,1)
		EndIf		
		
		If mv_par08 == 2 .And. nMoedaBco <> mv_par06
			(cTmpSE5)->(DbSkip())
			Loop
		EndIf
		
		/*Armazena a data que será usada pelo arquivo temporário. Caso
		a opção de data for competência, então será usado o campo VENCREA do SE1 ou do SE2.*/
		dDataTemp := SE5->E5_DATA
		cSaid     := " "
		cEntr     := " "
		lRet      := .T.
		
		//Regime de competência
		If mv_par05 == 2 .And. (lRet := !Empty(SE5->E5_NUMERO))
			If SE5->E5_RECPAG == "R"
				If SE1->(DbSeek(cFilialSE1+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))
					If ((SE1->E1_EMIS1 < BegOfYea(mv_par07)) .Or. (SE1->E1_EMIS1 > EndOfYea(mv_par07)))
						lRet := .F.
					Else
						cEntr     := "S"
						dDataTemp := SE1->E1_EMIS1
					EndIf
				EndIf
			Else
				If SE2->(DbSeek(cFilialSE2+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR)))
					If ((SE2->E2_EMIS1 < BegOfYea(mv_par07)) .Or. (SE2->E2_EMIS1 > EndOfYea(mv_par07)))
						lRet := .F.
					Else
						cSaid     := "S"
						dDataTemp := SE2->E2_EMIS1
					EndIf
				EndIf
			EndIf
		EndIf
		
		If lRet			
			cSE5Key := (cFilialSEZ + "2" + SE5->(E5_SEQ+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA))
			
			If SEZ->(MsSeek(cSE5Key))
				While SEZ->(!Eof()) .And. SEZ->(EZ_FILIAL+EZ_IDENT+EZ_SEQ+EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA) == cSE5Key
					If !SE5->E5_RECPAG $ "R|P"
						SEZ->(DbSkip())
						Loop
					EndIf
					
					If SE5->E5_RECPAG == "R" .And. ((SEZ->EZ_NATUREZ < MV_PAR01) .Or. (SEZ->EZ_NATUREZ > MV_PAR02))
						SEZ->(DbSkip())
						Loop					
					EndIf
					
					If SE5->E5_RECPAG == "P" .And. (SEZ->EZ_NATUREZ < MV_PAR03 .Or. SEZ->EZ_NATUREZ > MV_PAR04)
						SEZ->(DbSkip())
						Loop					
					EndIf
					
					If !CTT->(DbSeek(cFilialCTT+SEZ->EZ_CCUSTO))
						SEZ->(DbSkip())
						Loop						
					EndIf
					
					//Posiciona o arquivo temporário na natureza/mes correspondente aquele registro
					fr733Pos(SEZ->EZ_NATUREZ, dDataTemp, CTT->CTT_CUSTO, CTT->CTT_DESC01, IIf(SE5->E5_RECPAG == "R", "E", "S"))
					
					If SE5->E5_RECPAG == "R"
						cArqTmp->rEntr += Round(NoRound(xMoeda(SEZ->EZ_VALOR, nMoedaBco, mv_par06, SE5->E5_DATA, nDecs+1), nDecs+1), nDecs+1)
					Else
						cArqTmp->rSaid += Round(NoRound(xMoeda(SEZ->EZ_VALOR, nMoedaBco, mv_par06, SE5->E5_DATA, nDecs+1), nDecs+1), nDecs+1)
					EndIf
					
					SEZ->(DbSkip())
				EndDo
			EndIf	
		EndIf
		
		(cTmpSE5)->(DbSkip())
	EndDo
	
	(cTmpSE5)->(DbCloseArea())
	
	If !lRelato
		cArqTmp->(DbGotop())
		
		If aNiveis <> Nil
			nLimite := IIf(Len(aNiveis) > 1, Len(aNiveis)-1, 1)
		EndIf
		
		While !cArqTmp->(Eof())
			cNatur := cArqTmp->Natur
			
			For nLaco := 1 to Len( aQuebR )
				aQuebR[nLaco,1] := Subst( cArqtmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )+cArqTmp->CCusto
				aQuebO[nLaco,1] := Subst( cArqtmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )+cArqTmp->CCusto
				aQuebA[nLaco,1] := Subst( cArqtmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )+cArqTmp->CCusto
			Next nLaco
			
			aOrcado := { 0,0,0,0,0,0,0,0,0,0,0,0 }
			
			For nLaco := 1 To 12
				aOrcado[nLaco] += GetOrcadoCC(Year(mv_par07),nLaco,MV_PAR06,cArqTmp->NATUR,cArqTmp->CCUSTO)
			Next nLaco
			
			//Este For avançaa blocos de 12 em 12 registros
			For nMeses := 1 to 12
				//Acumula os totais e os parciais
				aTotais[1,nMeses+1] += cArqTmp->aEntr
				aTotais[2,nMeses+1] += cArqtmp->rEntr
				aTotais[3,nMeses+1] += cArqTmp->aSaid
				aTotais[4,nMeses+1] += cArqtmp->rSaid
				
				/*Armazena em separado o or‡ado para naturezas de entrada
				e naturezas de saída. O usuário não deve misturar as naturezas.*/
				If cArqTmp->ENTR == "E"
					aTotais[5,nMeses+1] += aOrcado[nMeses]
				ElseIf cArqTmp->SAID == "S"
					aTotais[6,nMeses+1] += aOrcado[nMeses]
				EndIf
				
				/*Lançaa em todos os n¡veis da quebra, pois estaremos trabalhAndo sempre com niveis 
				hieraquicos de um braço principal único da raiz.*/
				For nLaco := 1 to Len(aQuebR) //Todos os níveis
					aQuebR[nLaco,nMeses+1] += cArqtmp->rEntr+cArqtmp->rSaid
					aQuebA[nLaco,nMeses+1] += cArqtmp->aEntr+cArqtmp->aSaid
					aQuebO[nLaco,nMeses+1] += aOrcado[nMeses]
				Next
				
				cArqTmp->(DbSkip() )
			Next nMeses
			
			//VerIfica se houve quebra em algum nível
			lQuebra := .F.
			
			For nLaco := 1 to nLimite
				If aQuebR[nLaco,1] # Subst( cArqTmp->NATUR, aNiveis[nLaco,1], aNiveis[nLaco,2] )+cArqTmp->CCusto
					For nQuebras := nLimite to nLaco Step -1
						cQuebra := Left(cNatur, aNiveis[nQuebras,1] + aNiveis[nQuebras,2] - 1 )
						cQuebra := MascNat( cQuebra )
						
						While right(cQuebra,1) == "."
							cQuebra := Left(cQuebra,Len(cQuebra)-1)
						EndDo
						
						Aadd(aArrayQ, { STR0013 + cQuebra, "", "", "", "", "", "", "", "", "", "", "", "" } )
						
						Aadd(aArrayQ, {Capital(STR0008), Trans(aQuebO[nQuebras,2], TM(0,14,nDecs)),; 
							Trans(aQuebO[nQuebras,3],  TM(0,14,nDecs)),;
							Trans(aQuebO[nQuebras,4],  TM(0,14,nDecs)),;
							Trans(aQuebO[nQuebras,5],  TM(0,14,nDecs)),;
							Trans(aQuebO[nQuebras,6],  TM(0,14,nDecs)),;
							Trans(aQuebO[nQuebras,7],  TM(0,14,nDecs)),;
							Trans(aQuebO[nQuebras,8],  TM(0,14,nDecs)),;
							Trans(aQuebO[nQuebras,9],  TM(0,14,nDecs)),;
							Trans(aQuebO[nQuebras,10], TM(0,14,nDecs)),;
							Trans(aQuebO[nQuebras,11], TM(0,14,nDecs)),;
							Trans(aQuebO[nQuebras,12], TM(0,14,nDecs)),;
							Trans(aQuebO[nQuebras,13], TM(0,14,nDecs))})
						
						Aadd(aArrayQ, {Capital(STR0009), Trans(aQuebR[nQuebras,2], TM(0,14,nDecs)),; 
							Trans(aQuebR[nQuebras,3],  TM(0,14,nDecs)),;
							Trans(aQuebR[nQuebras,4],  TM(0,14,nDecs)),;
							Trans(aQuebR[nQuebras,5],  TM(0,14,nDecs)),;
							Trans(aQuebR[nQuebras,6],  TM(0,14,nDecs)),;
							Trans(aQuebR[nQuebras,7],  TM(0,14,nDecs)),;
							Trans(aQuebR[nQuebras,8],  TM(0,14,nDecs)),;
							Trans(aQuebR[nQuebras,9],  TM(0,14,nDecs)),;
							Trans(aQuebR[nQuebras,10], TM(0,14,nDecs)),;
							Trans(aQuebR[nQuebras,11], TM(0,14,nDecs)),;
							Trans(aQuebR[nQuebras,12], TM(0,14,nDecs)),;
							Trans(aQuebR[nQuebras,13], TM(0,14,nDecs))})
						
						Aadd(aArrayQ, {Capital(STR0010), Trans(aQuebA[nQuebras,2], TM(0,14,nDecs)),; 
							Trans(aQuebA[nQuebras,3],  TM(0,14,nDecs)),;
							Trans(aQuebA[nQuebras,4],  TM(0,14,nDecs)),;
							Trans(aQuebA[nQuebras,5],  TM(0,14,nDecs)),;
							Trans(aQuebA[nQuebras,6],  TM(0,14,nDecs)),;
							Trans(aQuebA[nQuebras,7],  TM(0,14,nDecs)),;
							Trans(aQuebA[nQuebras,8],  TM(0,14,nDecs)),;
							Trans(aQuebA[nQuebras,9],  TM(0,14,nDecs)),;
							Trans(aQuebA[nQuebras,10], TM(0,14,nDecs)),;
							Trans(aQuebA[nQuebras,11], TM(0,14,nDecs)),;
							Trans(aQuebA[nQuebras,12], TM(0,14,nDecs)),;
							Trans(aQuebA[nQuebras,13], TM(0,14,nDecs))})
						
						Aadd(aArrayQ, { "", "", "", "", "", "", "", "", "", "", "", "", "" } )
						
						For nMeses := 2 To 13
							aQuebR[nQuebras,nMeses] := 0
							aQuebO[nQuebras,nMeses] := 0
							aQuebA[nQuebras,nMeses] := 0
						Next nMeses
					Next nQuebras
					
					Exit
				EndIf
			Next nLaco
			
			If cArqTmp->(Eof())
				Exit
			EndIf
		EndDo
	EndIf
	
	Aadd(aTotal, {STR0015, "", "", "", "", "", "", "", "", "", "", "", "" })
	
	//aTotais[5] - Orcado Entradas
	Aadd(aTotal, AClone(aTotais[5]))
	
	For nMeses := 2 To 13
		aTotal[2][nMeses] := Trans(aTotal[2][nMeses], Tm(0,14,nDecs))
	Next nMeses
	
	//aTotais[2] - Realizado Entradas
	Aadd(aTotal, AClone(aTotais[2]))
	
	For nMeses := 2 To 13
		aTotal[3][nMeses] := Trans(aTotal[3][nMeses], Tm(0,14,nDecs))
	Next nMeses
	
	//aTotais[1] - A Realizar Entradas
	Aadd(aTotal, AClone(aTotais[1]))
	
	For nMeses := 2 To 13
		aTotal[4][nMeses] := Trans(aTotal[4][nMeses], Tm(0,14,nDecs))
	Next nMeses
	
	Aadd(aTotal, AClone(aTotais[2]))
	aTotal[5][1] := Capital(STR0011)
	
	For nMeses := 2 To 13
		aTotal[5][nMeses] := Trans(aTotal[5][nMeses] + aTotais[1][nMeses], Tm(0,14,nDecs))
	Next nMeses
	
	Aadd(aTotal, { STR0016, "", "", "", "", "", "", "", "", "", "", "", "" } )

	//aTotais[6] - Orcado Saidas
	Aadd(aTotal, AClone(aTotais[6]))
	
	For nMeses := 2 To 13
		aTotal[7][nMeses] := Trans(aTotal[7][nMeses], Tm(0,14,nDecs))
	Next nMeses

	//aTotais[4] - Realizado Saidas
	Aadd(aTotal, AClone(aTotais[4]))
	
	For nMeses := 2 To 13
		aTotal[8][nMeses] := Trans(aTotal[8][nMeses], Tm(0,14,nDecs))
	Next nMeses
	
	//aTotais[3] - A Realizar Saidas
	Aadd(aTotal, AClone(aTotais[3]))
	
	For nMeses := 2 To 13
		aTotal[9][nMeses] := Trans(aTotal[9][nMeses], Tm(0,14,nDecs))
	Next nMeses
	
	Aadd(aTotal, AClone(aTotais[4]))
	aTotal[10][1] := Capital(STR0011)
	
	For nMeses := 2 To 13
		aTotal[10][nMeses] := Trans(aTotal[10][nMeses] + aTotais[3][nMeses], Tm(0,14,nDecs))
	Next nMeses
	
	Aadd(aTotal, { STR0017, "", "", "", "", "", "", "", "", "", "", "", "" } )
	
	Aadd(aTotal, {Capital(STR0008),;
		Trans(aTotais[5][2] - aTotais[6][2], Tm(0,14,nDecs)),;
		Trans(aTotais[5][3] - aTotais[6][3], Tm(0,14,nDecs)),;
		Trans(aTotais[5][4] - aTotais[6][4], Tm(0,14,nDecs)),;
		Trans(aTotais[5][5] - aTotais[6][5], Tm(0,14,nDecs)),;
		Trans(aTotais[5][6] - aTotais[6][6], Tm(0,14,nDecs)),;
		Trans(aTotais[5][7] - aTotais[6][7], Tm(0,14,nDecs)),;
		Trans(aTotais[5][8] - aTotais[6][8], Tm(0,14,nDecs)),;
		Trans(aTotais[5][9] - aTotais[6][9], Tm(0,14,nDecs)),;
		Trans(aTotais[5][10] - aTotais[6][10], Tm(0,14,nDecs)),;
		Trans(aTotais[5][11] - aTotais[6][11], Tm(0,14,nDecs)),;
		Trans(aTotais[5][12] - aTotais[6][12], Tm(0,14,nDecs)),;
		Trans(aTotais[5][13] - aTotais[6][13], Tm(0,14,nDecs)) })

	Aadd(aTotal, {Capital(STR0009),;
		Trans(aTotais[2][2] - aTotais[4][2], Tm(0,14,nDecs)),;
		Trans(aTotais[2][3] - aTotais[4][3], Tm(0,14,nDecs)),;
		Trans(aTotais[2][4] - aTotais[4][4], Tm(0,14,nDecs)),;
		Trans(aTotais[2][5] - aTotais[4][5], Tm(0,14,nDecs)),;
		Trans(aTotais[2][6] - aTotais[4][6], Tm(0,14,nDecs)),;
		Trans(aTotais[2][7] - aTotais[4][7], Tm(0,14,nDecs)),;
		Trans(aTotais[2][8] - aTotais[4][8], Tm(0,14,nDecs)),;
		Trans(aTotais[2][9] - aTotais[4][9], Tm(0,14,nDecs)),;
		Trans(aTotais[2][10] - aTotais[4][10], Tm(0,14,nDecs)),;
		Trans(aTotais[2][11] - aTotais[4][11], Tm(0,14,nDecs)),;
		Trans(aTotais[2][12] - aTotais[4][12], Tm(0,14,nDecs)),;
		Trans(aTotais[2][13] - aTotais[4][13], Tm(0,14,nDecs)) })

	Aadd(aTotal, {Capital(STR0010),;
		Trans(aTotais[1][2] - aTotais[3][2], Tm(0,14,nDecs)),;
		Trans(aTotais[1][3] - aTotais[3][3], Tm(0,14,nDecs)),;
		Trans(aTotais[1][4] - aTotais[3][4], Tm(0,14,nDecs)),;
		Trans(aTotais[1][5] - aTotais[3][5], Tm(0,14,nDecs)),;
		Trans(aTotais[1][6] - aTotais[3][6], Tm(0,14,nDecs)),;
		Trans(aTotais[1][7] - aTotais[3][7], Tm(0,14,nDecs)),;
		Trans(aTotais[1][8] - aTotais[3][8], Tm(0,14,nDecs)),;
		Trans(aTotais[1][9] - aTotais[3][9], Tm(0,14,nDecs)),;
		Trans(aTotais[1][10] - aTotais[3][10], Tm(0,14,nDecs)),;
		Trans(aTotais[1][11] - aTotais[3][11], Tm(0,14,nDecs)),;
		Trans(aTotais[1][12] - aTotais[3][12], Tm(0,14,nDecs)),;
		Trans(aTotais[1][13] - aTotais[3][13], Tm(0,14,nDecs)) })
	
	Aadd(aTotal, {Capital(STR0011),;
		Trans((aTotais[2][2]  - aTotais[4][2])  + (aTotais[1][2]  - aTotais[3][2]),  Tm(0,14,nDecs)),;
		Trans((aTotais[2][3]  - aTotais[4][3])  + (aTotais[1][3]  - aTotais[3][3]),  Tm(0,14,nDecs)),;
		Trans((aTotais[2][4]  - aTotais[4][4])  + (aTotais[1][4]  - aTotais[3][4]),  Tm(0,14,nDecs)),;
		Trans((aTotais[2][5]  - aTotais[4][5])  + (aTotais[1][5]  - aTotais[3][5]),  Tm(0,14,nDecs)),;
		Trans((aTotais[2][6]  - aTotais[4][6])  + (aTotais[1][6]  - aTotais[3][6]),  Tm(0,14,nDecs)),;
		Trans((aTotais[2][7]  - aTotais[4][7])  + (aTotais[1][7]  - aTotais[3][7]),  Tm(0,14,nDecs)),;
		Trans((aTotais[2][8]  - aTotais[4][8])  + (aTotais[1][8]  - aTotais[3][8]),  Tm(0,14,nDecs)),;
		Trans((aTotais[2][9]  - aTotais[4][9])  + (aTotais[1][9]  - aTotais[3][9]),  Tm(0,14,nDecs)),;
		Trans((aTotais[2][10] - aTotais[4][10]) + (aTotais[1][10] - aTotais[3][10]), Tm(0,14,nDecs)),;
		Trans((aTotais[2][11] - aTotais[4][11]) + (aTotais[1][11] - aTotais[3][11]), Tm(0,14,nDecs)),;
		Trans((aTotais[2][12] - aTotais[4][12]) + (aTotais[1][12] - aTotais[3][12]), Tm(0,14,nDecs)),;
		Trans((aTotais[2][13] - aTotais[4][13]) + (aTotais[1][2]  - aTotais[3][2]),  Tm(0,14,nDecs))})
Return {aTotal, aArrayQ, aTotais}
