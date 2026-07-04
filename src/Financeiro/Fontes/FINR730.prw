/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR730.CH"
#Include "PROTHEUS.CH"

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

STATIC cSituaca		:= ""	//Lista das situacoes de cobranca a serem demonstradas no relatorio
STATIC __oFinr730

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR730  ³ Autor ³ Daniel Tadashi Batori ³ Data ³ 31.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Comparativo entre Valores Or‡ados x Reais II			      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR730(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR730()
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

ZeraStatic()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 31.08.06 ³±±
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
Local oSection1, oResumo
Local oFilial //Gestão Corporativa
Local oSecFil //Gestão Corporativa

oReport := TReport():New("FINR730",STR0037,"FIN730", {|oReport| ReportPrint(oReport)},STR0001+STR0002)

pergunte("FIN730",.F.)
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
//³ mv_par11      	    // Data Base	 				        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:SetLandScape(.T.)

oSection1 := TRSection():New(oReport,STR0019,{"SED"},) //"Mapa"
TRCell():New(oSection1,"ED_CODIGO","SED",STR0020,,,.F.,) //"Cod Natureza"
TRCell():New(oSection1,"CTT_DESC01","CTT",STR0021,,16,.F.,)  //"Descricao"
TRCell():New(oSection1,"META",,,,10,.F.,) 
TRCell():New(oSection1,"Janeiro"	,,STR0022,"@E 99,999,999.99",13,.F.,) //"Janeiro"
TRCell():New(oSection1,"Fevereiro",,STR0023,"@E 99,999,999.99",13,.F.,) //"Fevereiro"
TRCell():New(oSection1,"Marco",,STR0024,"@E 99,999,999.99",13,.F.,) //"Marco"
TRCell():New(oSection1,"Abril",,STR0025,"@E 99,999,999.99",13,.F.,) //"Abril"
TRCell():New(oSection1,"Maio"	,,STR0026,"@E 99,999,999.99",13,.F.,) //"Maio"
TRCell():New(oSection1,"Junho",,STR0027,"@E 99,999,999.99",13,.F.,) //"Junho"
TRCell():New(oSection1,"Julho",,STR0028,"@E 99,999,999.99",13,.F.,) //"Julho"
TRCell():New(oSection1,"Agosto",,STR0029,"@E 99,999,999.99",13,.F.,) //"Agosto"
TRCell():New(oSection1,"Setembro",,STR0030,"@E 99,999,999.99",13,.F.,) //"Setembro"
TRCell():New(oSection1,"Outubro",,STR0031,"@E 99,999,999.99",13,.F.,) //"Outubro"
TRCell():New(oSection1,"Novembro",,STR0032,"@E 99,999,999.99",13,.F.,) //"Novembro"
TRCell():New(oSection1,"Dezembro",,STR0033,"@E 99,999,999.99",13,.F.,) //"Dezembro"
oSection1:SetHeaderPage()

oResumo := TRSection():New( oReport,STR0011, {"cArqTmp"}, ) //"Resumo"
TRCell():New(oResumo,"ED_CODIGO"	,"SED",STR0020,,,.F.,) //"Cod Natureza"
TRCell():New(oResumo,"CTT_DESC01","CTT",STR0021,,16,.F.,)  //"Descricao"
TRCell():New(oResumo,"META",,,,10,.F.,) 
TRCell():New(oResumo,"Janeiro",,STR0022,"@E 99,999,999.99",13,.F.,) //"Janeiro"
TRCell():New(oResumo,"Fevereiro",,STR0023,"@E 99,999,999.99",13,.F.,) //"Fevereiro"
TRCell():New(oResumo,"Marco",,STR0024,"@E 99,999,999.99",13,.F.,) //"Marco"
TRCell():New(oResumo,"Abril",,STR0025,"@E 99,999,999.99",13,.F.,) //"Abril"
TRCell():New(oResumo,"Maio",,STR0026,"@E 99,999,999.99",13,.F.,) //"Maio"
TRCell():New(oResumo,"Junho",,STR0027,"@E 99,999,999.99",13,.F.,) //"Junho"
TRCell():New(oResumo,"Julho",,STR0028,"@E 99,999,999.99",13,.F.,) //"Julho"
TRCell():New(oResumo,"Agosto",,STR0029,"@E 99,999,999.99",13,.F.,) //"Agosto"
TRCell():New(oResumo,"Setembro",,STR0030,"@E 99,999,999.99",13,.F.,) //"Setembro"
TRCell():New(oResumo,"Outubro",,STR0031,"@E 99,999,999.99",13,.F.,) //"Outubro"
TRCell():New(oResumo,"Novembro",,STR0032,"@E 99,999,999.99",13,.F.,) //"Novembro"
TRCell():New(oResumo,"Dezembro",,STR0033,"@E 99,999,999.99",13,.F.,) //"Dezembro"
oResumo:SetHeaderSection(.F.)

oSection1:Cell("Janeiro"):SetHeaderAlign("RIGHT")
oSection1:Cell("Fevereiro"):SetHeaderAlign("RIGHT")
oSection1:Cell("Marco"):SetHeaderAlign("RIGHT")
oSection1:Cell("Abril"):SetHeaderAlign("RIGHT")
oSection1:Cell("Maio"):SetHeaderAlign("RIGHT")
oSection1:Cell("Junho"):SetHeaderAlign("RIGHT")
oSection1:Cell("Julho"):SetHeaderAlign("RIGHT")
oSection1:Cell("Agosto"):SetHeaderAlign("RIGHT")
oSection1:Cell("Setembro"):SetHeaderAlign("RIGHT")
oSection1:Cell("Outubro"):SetHeaderAlign("RIGHT")
oSection1:Cell("Novembro"):SetHeaderAlign("RIGHT")
oSection1:Cell("Dezembro"):SetHeaderAlign("RIGHT")

oResumo:Cell("Janeiro"):SetHeaderAlign("RIGHT")
oResumo:Cell("Fevereiro"):SetHeaderAlign("RIGHT")
oResumo:Cell("Marco"):SetHeaderAlign("RIGHT")
oResumo:Cell("Abril"):SetHeaderAlign("RIGHT")
oResumo:Cell("Maio"):SetHeaderAlign("RIGHT")
oResumo:Cell("Junho"):SetHeaderAlign("RIGHT")
oResumo:Cell("Julho"):SetHeaderAlign("RIGHT")
oResumo:Cell("Agosto"):SetHeaderAlign("RIGHT")
oResumo:Cell("Setembro"):SetHeaderAlign("RIGHT")
oResumo:Cell("Outubro"):SetHeaderAlign("RIGHT")
oResumo:Cell("Novembro"):SetHeaderAlign("RIGHT")
oResumo:Cell("Dezembro"):SetHeaderAlign("RIGHT")

//Gestão Corporativa - Início
oFilial := TRSection():New(oReport,"",{"SE1"})
TRCell():New(oFilial,"Filial",,,,TamSx3("E1_FILIAL")[1] + Len(STR0038)) //"Filial : "
oFilial:SetHeaderSection(.F.)

oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0039,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0040,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0041,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0042,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

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
Local oSection1	:= oReport:Section(1)
Local oResumo		:= oReport:Section(2)
Local aDados[15]

Local	cTexto
Local dOldDtBase := dDataBase

Local cTit
LOCAL aNiveis  	:= {}
LOCAL aQuebR 	:= {}
LOCAL aQuebO 	:= {}
LOCAL aQuebA 	:= {}
LOCAL nLaco 	:= 0
LOCAL nByte 	:= 0
LOCAL cMapa 	:= ""
LOCAL nLimite 	:= 0
LOCAL nMeses 	:= 0
LOCAL aTotais 	:= {}
LOCAL aOrcado 	:= {}
Local cArqTmp 	:= ""
Local cNatur	:= ""
Local nQuebras

//Gestão Corporativa - Início
Local aAreaSE1 := SE1->(GetArea())
Local aAreaSM0 := SM0->(GetArea())
Local aArea := GetArea()
Local lGestao   := ( FWSizeFilial() > 2 )
Local lSE1Excl  := Iif( lGestao, FWModeAccess("SE1",1) == "E", FWModeAccess("SE1",3) == "E")
Local nX 		:= 1
Local nC := 1
Local oSecFil	:= oReport:Section("SECFIL")
Local nRegSM0	:= SM0->(Recno())
Local aSelFil := {}
Local cFilAtu	:= ""
Local lPrtFil := .T.
Local oFilial		:= oReport:Section(3)
//Gestão Corporativa - Fim

Private nDecs	:= MsDecimais(mv_par06)


oSection1:Cell("ED_CODIGO"):SetBlock( { || aDados[NATUREZ] } )
oSection1:Cell("CTT_DESC01"):SetBlock( { || aDados[DESCRIC] } )
oSection1:Cell("META"):SetBlock		( { || aDados[META] } )
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
oResumo:Cell("META"):SetBlock			( { || aDados[META] } )
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
cTit	:= oReport:Title() + (cTexto + " de " + Str(Year(mv_par07),4,0))
oReport:SetTitle(cTit)

IF mv_par03 > mv_par01
	IF mv_par02 >= mv_par03 .or. mv_par02 < mv_par01 .or. mv_par04 < mv_par03
		HELP (" ",1,"R720NAT")
		Return
	Endif 
Else
	IF mv_par04 < mv_par01 .or. mv_par02 < mv_par01 .or. mv_par04 < mv_par03  
		HELP (" ",1,"R720NAT")
		Return
	Endif 
Endif 

dDataBase := mv_par11 // Altera data base conforme parametro

nRegSM0 := SM0->(Recno())

If (lSE1Excl .and. mv_par12 == 1)
	If lGestao
		aSelFil := FwSelectGC()
	Else
		aSelFil := AdmGetFil(.F.,.F.,"SE1")
	EndIf
Endif

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

SM0->(DbGoTo(nRegSM0))

If Len(aSelFil) > 1
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0043 +  ")")	//"Filiais selecionadas para o relatorio"
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
RestArea(aAreaSM0)

If Len(aSelFil) > 1
	aSort(aSelFil)
	cFilAnt := aSelFil[nC]
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Esta matriz informa em que posi‡”es ser„o feitas as quebras.   ³
//³ 1-Byte inicial da quebra, 2-Quantidade de caracteres.          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aNiveis  := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Esta matriz armazena as chaves de quebra e os totalizadores parciais.  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aQuebR := {}    // Realizado
aQuebO := {}    // Or‡ado
aQuebA 	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lˆ a formata‡„o do c¢digo das naturezas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMascNat := GetMV("MV_MASCNAT")
cMapa    := "123456789"

If Empty(cMascNat)
	cMascNat := "19"
	HELP (,,"FR730NAT")
EndIf

For nLaco := 1 to len( cMascNat )
	nByte := Val( Substr( cMascNat,nLaco,1 ) )
	If nByte > 0
		AAdd( aNiveis  , { Val(Left(cMapa,1)) , nByte} )
		AAdd( aQuebR   , { "", 0,0,0,0,0,0,0,0,0,0,0,0 } )
		AAdd( aQuebO   , { "", 0,0,0,0,0,0,0,0,0,0,0,0 } )
		AAdd( aQuebA   , { "", 0,0,0,0,0,0,0,0,0,0,0,0 } )
		cMapa := Subst(cMapa,nByte+1,Len(cMapa)-nByte)
	Endif
Next

nLimite := IIf(Len(aNiveis) > 1, Len(aNiveis)-1, 1)

oSection1:Init()

//Backup da filial logada
cFilAtu := cFilAnt

For nC := 1 To Len(aSelFil) Step 1
    nMeses 	:= 0
    aOrcado 	:= {}
    cArqTmp := ""
    nQuebras := 0
    cFilAnt := aSelFil[nC]

	SE1->(dbSeek(xFilial("SE1")))
	SE2->(dbSeek(xFilial("SE2")))

	If SE1->(EOF()) .And. SE2->(EOF())
		Loop
	Else
		lPrtFil := .T.
	EndIf
	//Gestão Corporativa - Fim

	//Seleciona situacoes de cobrança
	If MV_PAR09 == 1
		cSituaca := FinSitCob()		//Lista com as situacoes de cobranca selecionada pelo usuario
	Endif
	
	If Empty(cSituaca)
		cSituaca := FN022LstCb(0)	//Lista com todas as situacoes de cobranca	
	Endif
	
	Processa( { || U_Fin730Cria(@cArqTmp,,,,,,,,,.T.,oReport) }, STR0036 ) //"Criando arquivo temporário de trabalho"

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³	Defini‡„o das linhas da matriz aTotais. As colunas se referem aos		³
	³	Meses do Ano.																			³
	³	Linha 01 - A Realizar - Entradas													³	
	³	Linha 02 - Realizado  - Entradas													³	
	³	Linha 03 - A Realizar - Sa¡das													³	
	³	Linha 04 - Realizado  - Sa¡das													³
	³	Linha 05 - Or‡ado     - Entradas													³
	³	Linha 06 - Or‡ado     - Sa¡das													³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	*/
	aTotais := { 	{0,0,0,0,0,0,0,0,0,0,0,0} ,;
					{0,0,0,0,0,0,0,0,0,0,0,0} ,;
					{0,0,0,0,0,0,0,0,0,0,0,0} ,;
					{0,0,0,0,0,0,0,0,0,0,0,0} ,;
					{0,0,0,0,0,0,0,0,0,0,0,0} ,;
					{0,0,0,0,0,0,0,0,0,0,0,0}  }

	oReport:SetMeter(cArqTmp->(RecCount()))

	aFill(aDados,nil)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o relat¢rio a partir do arquivo tempor rio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("cArqTmp")
	dbGoTop()

  If cArqTmp->(EOF())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apaga arquivos temporarios  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectarea("cArqTmp")
		cArqTmp->( dbCloseArea() )
		Ferase(cArqTmp+GetDBExtension())
		Ferase(cArqTmp+OrdBagExt())
		Loop
  Else
    lPrtFil := .T.
  EndIf

	//Gestão Corporativa - Início
	If lPrtFil .And. !cArqTmp->(Eof())
		If mv_par12 == 1
			oReport:SkipLine()
			oFilial:Init()
			oFilial:Cell("Filial"):SetBlock({|| STR0038 + cFilAnt }) //"Filial : "
			oFilial:PrintLine()
			oFilial:Finish()
			oReport:SkipLine()
		EndIf
		lPrtFil := .F.
	EndIf
	//Gestão Corporativa - Fim

	While !cArqTmp->( Eof() )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Inicia a matriz acumuladora de quebras  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nLaco := 1 to Len( aQuebR )
			 aQuebR[nLaco,1] := Subst( cArqtmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )
			 aQuebO[nLaco,1] := Subst( cArqtmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )
			 aQuebA[nLaco,1] := Subst( cArqtmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )
		Next

		aOrcado := { 0,0,0,0,0,0,0,0,0,0,0,0 }
		If SE7->(dbSeek(xFilial("SE7")+cArqTmp->NATUR+Str(Year(mv_par07),4,0)))
			aOrcado[01] += Round(NoRound(xMoeda(SE7->E7_VALJAN1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[02] += Round(NoRound(xMoeda(SE7->E7_VALFEV1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[03] += Round(NoRound(xMoeda(SE7->E7_VALMAR1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[04] += Round(NoRound(xMoeda(SE7->E7_VALABR1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[05] += Round(NoRound(xMoeda(SE7->E7_VALMAI1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[06] += Round(NoRound(xMoeda(SE7->E7_VALJUN1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[07] += Round(NoRound(xMoeda(SE7->E7_VALJUL1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[08] += Round(NoRound(xMoeda(SE7->E7_VALAGO1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[09] += Round(NoRound(xMoeda(SE7->E7_VALSET1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[10] += Round(NoRound(xMoeda(SE7->E7_VALOUT1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[11] += Round(NoRound(xMoeda(SE7->E7_VALNOV1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
			aOrcado[12] += Round(NoRound(xMoeda(SE7->E7_VALDEZ1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		Endif

		cNatur := cArqTmp->Natur
		aDados[NATUREZ] := Mascnat(cArqtmp->Natur)
		aDados[DESCRIC] := Left(cArqTmp->DESCR,16)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Este For avan‡a blocos de 12 em 12 registros  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aRealizado := {0,0,0,0,0,0,0,0,0,0,0,0}
		aARealizar := {0,0,0,0,0,0,0,0,0,0,0,0}
		For nMeses := 1 to 12
			aRealizado[nMeses] := cArqtmp->rEntr+cArqtmp->rSaid
			aARealizar[nMeses] := cArqtmp->aEntr+cArqtmp->aSaid

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³  Acumula os totais e os parciais  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aTotais[1,nMeses] += cArqTmp->aEntr
			aTotais[2,nMeses] += cArqtmp->rEntr
			aTotais[3,nMeses] += cArqTmp->aSaid
			aTotais[4,nMeses] += cArqtmp->rSaid

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Armazena em separado o or‡ado para naturezas de entrada   ³
			//³ e naturezas de sa¡da. o Usu rio n„o deve misturar as      ³
			//³ naturezas.                                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cArqTmp->ENTR == "S"
				aTotais[5,nMeses] += aOrcado[nMeses]
			Else			
				aTotais[6,nMeses] += aOrcado[nMeses]
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Lan‡a em todos os n¡veis da quebra, pois estaremos        ³
			//³ trabalhando sempre com n¡veis hier rquicos de um bra‡o    ³
			//³ principal £nico da raiz.                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nLaco := 1 to Len(aQuebR) // Todos os n¡veis
				 aQuebR[nLaco,nMeses+1] += cArqtmp->rEntr+cArqtmp->rSaid
				 aQuebA[nLaco,nMeses+1] += cArqtmp->aEntr+cArqtmp->aSaid
				 aQuebO[nLaco,nMeses+1] += aOrcado[nMeses]
			Next

			dbSkip()
		Next

		aDados[META] := STR0008 //"    ORCADO"
	
		For nMeses := 1 to 12
			aDados[3 + nMeses] := aOrcado[nMeses]
		Next

		oSection1:PrintLine()
		aFill(aDados,nil)
		oReport:IncMeter()

		aDados[META] := STR0009 //" REALIZADO"

		For nMeses := 1 to 12
			 aDados[3 + nMeses] := aRealizado[nMeses]
		Next

		oSection1:PrintLine()
		aFill(aDados,nil)
		oReport:IncMeter()

		aDados[META] := STR0010 //"A REALIZAR"

		For nMeses := 1 to 12
			 aDados[3 + nMeses] := aARealizar[nMeses]
		Next

		oSection1:PrintLine()
		aFill(aDados,nil)
		oReport:IncMeter()

		aDados[META] := STR0011 //"      REAL" 

		For nMeses := 1 to 12
			aDados[3 + nMeses] := aARealizar[nMeses]+aRealizado[nMeses]
		Next

		oSection1:PrintLine()
		aFill(aDados,nil)	
		oReport:IncMeter()

		aDados[META] := STR0012 //"% VARIACAO"

		For nMeses := 1 to 12
			If aOrcado[nMeses] # 0
				aDados[3 + nMeses] := ( (aRealizado[nMeses]+aArealizar[nMeses]) / aOrcado[nMeses]) * 100
			Else
			   aDados[3 + nMeses] := aOrcado[nMeses]
			Endif
		Next

		oSection1:PrintLine()
		aFill(aDados,nil)	
		oReport:IncMeter()
		oReport:SkipLine()

		dbSelectArea("cArqTmp")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Verifica se houve quebra em algum n¡vel ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lQuebra := .F.
		For nLaco := 1 to nLimite
			If aQuebR[nLaco,1] # Subst( cArqTmp->NATUR, aNiveis[nLaco,1], aNiveis[nLaco,2] )
				For nQuebras := nLimite to nLaco Step -1
					cQuebra := Left(cNatur, aNiveis[nQuebras,1] + aNiveis[nQuebras,2] - 1 )
					cQuebra := MascNat( cQuebra )
					While right(cQuebra,1) == "."
						cQuebra := Left(cQuebra,Len(cQuebra)-1)
					End

					aDados[DESCRIC] := STR0013  //"T O T A L "

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Inicia as quebras de baixo para cima at‚ o ponto da quebra  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aDados[META] := STR0008  //"    ORCADO"

					For nMeses := 2 to 13
						aDados[2 + nMeses] := aQuebO[nQuebras,nMeses]
					Next

					oSection1:PrintLine()
					aFill(aDados,nil)
					oReport:IncMeter()

					aDados[META] := STR0009  //" REALIZADO"

					For nMeses := 2 to 13
						aDados[2 + nMeses] := aQuebR[nQuebras,nMeses]
					Next

					oSection1:PrintLine()
					aFill(aDados,nil)
					oReport:IncMeter()

					aDados[META] := STR0010  //"A REALIZAR"

					For nMeses := 2 to 13
						aDados[2 + nMeses] := aQuebA[nQuebras,nMeses]
					Next

					oSection1:PrintLine()
					aFill(aDados,nil)
					oReport:IncMeter()

					aDados[META] := STR0011  //"      REAL"

					For nMeses := 2 to 13
						aDados[2 + nMeses] := aQuebA[nQuebras,nMeses]+aQuebr[nQuebras,nMeses]
					Next

					oSection1:PrintLine()
					aFill(aDados,nil)
					oReport:IncMeter()

					aDados[META] := STR0012  //"% VARIACAO"

					For nMeses := 2 to 13
						If aQuebO[nQuebras,nMeses] > 0
							aDados[2 + nMeses] := ((aQuebR[nQuebras,nMeses]+aQuebA[nQuebras,nMeses])/aQuebO[nQuebras,nMeses])*100 
						Else
							aDados[2 + nMeses] := aQuebO[nQuebras,nMeses]
						Endif
					Next

					oSection1:PrintLine()
					aFill(aDados,nil)
					oReport:IncMeter()
					oReport:SkipLine()

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Limpa os n¡veis de quebra somente ap¢s a impress„o  ³
					//³ pois caso contr rio n„o haveria como calcular o %.  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					For nMeses := 2 To 13
						aQuebR[nQuebras,nMeses] := 0
						aQuebO[nQuebras,nMeses] := 0
						aQuebA[nQuebras,nMeses] := 0
					Next
				Next
				Exit
			Endif
		Next
		If cArqTmp->(Eof())
			Exit
		Endif
	End

	oReport:SkipLine()

	oResumo:Init()
	aFill(aDados,nil)

	oReport:ThinLine()
	oReport:PrintText(STR0014)  //"RESUMO"
	oReport:ThinLine()

	aDados[DESCRIC] := STR0015  //"Entradas"
	aDados[META] := STR0008   //"    ORCADO"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[5,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0009  //" REALIZADO"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[2,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0010  //"A REALIZAR"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[1,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0011  //"      REAL"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[1,nMeses]+aTotais[2,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0012  //"% VARIACAO"

	For nMeses := 1 to 12
		If aTotais[5,nMeses] > 0
			aDados[3 + nMeses] := ( (aTotais[1,nMeses]+aTotais[2,nMeses])/ aTotais[5,nMeses])*100 
		Else
			aDados[3 + nMeses] := aTotais[5,nMeses]
		Endif
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os totais relacionados … sa¡das. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:ThinLine()
	aDados[DESCRIC] := STR0016  //"Saidas"
	aDados[META] := STR0008   //"    ORCADO"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[6,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0009  //" REALIZADO"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[4,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0010  //"A REALIZAR"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[3,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0011  //"      REAL"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[3,nMeses]+aTotais[4,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0012  //"% VARIACAO"

	For nMeses := 1 to 12
		If aTotais[6,nMeses] > 0
			nVar := aTotais[4,nMeses]+aTotais[3,nMeses]
			nVar /= aTotais[6,nMeses]
			nVar *= 100
			aDados[3 + nMeses] := nVar
		Else
			aDados[3 + nMeses] := aTotais[6,nMeses]
		Endif
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz o Balan‡o e apresenta o saldo.  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:ThinLine()
	aDados[DESCRIC] := STR0017  //"Saldos"
	aDados[META] := STR0008   //"    ORCADO"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[5,nMeses]-aTotais[6,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0009  //" REALIZADO"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[2,nMeses]-aTotais[4,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0010  //"A REALIZAR"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[1,nMeses]-aTotais[3,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0011  //"      REAL"

	For nMeses := 1 to 12
		aDados[3 + nMeses] := aTotais[1,nMeses]-aTotais[3,nMeses]+aTotais[2,nMeses]-aTotais[4,nMeses]
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)

	aDados[META] := STR0012//"% VARIACAO"

	For nMeses := 1 to 12
		 nVar := aTotais[1,nMeses]-aTotais[3,nMeses]+aTotais[2,nMeses]-aTotais[4,nMeses]
		 nVar /= aTotais[5,nMeses]+aTotais[6,nMeses]
		 nVar *= 100
		 aDados[3 + nMeses] := nVar
	Next

	oResumo:PrintLine()
	aFill(aDados,nil)
	oReport:ThinLine()

	oResumo:Finish()

	dbSelectArea("SE5")
	RetIndex("SE5")
	Set Filter To

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apaga arquivos tempor rios  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectarea("cArqTmp")
	cArqTmp->( dbCloseArea() )
	Ferase(cArqTmp+GetDBExtension())
	Ferase(cArqTmp+OrdBagExt())

	dbSelectArea("SE1")

Next

oSection1:Finish()
dDataBase := dOldDtBase // Restaura Data base
cFilAnt := cFilAtu //Gestão Corporativa
RestArea(aAreaSE1)
RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³U_BegOfYea()³ Autor ³ Vin¡cius Barreira     ³ Data ³ 05/09/94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o primeiro dia do ano daquela data.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ dData := U_BegOfYea(dDataRef)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ dDataRef: data de referˆncia                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function BegOfYea(dData)
If ValType( dData ) # "D"
	 dData := mv_par07
Endif
Return cTod("01/01" + "/" + StrZero(Year(dData),4,0),"ddmmyy" )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³U_EndOfYea()³ Autor ³ Vin¡cius Barreira     ³ Data ³ 05/09/94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o £ltimo   dia do ano     daquela data.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ dData := U_EndOfYea(dDataRef)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ dDataRef: data de referˆncia                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function EndOfYea(dData)
If ValType( dData ) # "D"
	dData := mv_par07
Endif
Return cTod("31/12" + "/" + StrZero(Year(dData),4,0),"ddmmyy" )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ Fr733Pos ³ Autor ³ Vin¡cius Barreira     ³ Data ³ 22/09/94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Posiciona o arquivo tempor rio de acordo com a natureza    ³±±
±±³          ³ e data (mˆs) passado como parƒmetro.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Fr733Pos(cNatureza,dData)                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Natureza e Data                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function fr733Pos(cNaturez,dData,cEntr,cSaid)
Local cMes := "  "
Local nMeses := 0        

Default cEntr := ""
Default cSaid := ""

cMes := StrZero(Month(dData),2,0)
dbSelectArea("cArqTmp")
If !cArqTmp->(dbSeek(cNaturez + cMes))
	SED->(MsSeek(xFilial("SED")+cNaturez))
	For nMeses := 1 to 12
		If (!cArqTmp->(dbSeek(cNaturez + StrZero(nMeses,2,0)))) .And.;
			(cNaturez >= mv_par01 .And. cNaturez <= mv_par02) .Or.;
			(cNaturez >= mv_par03 .And. cNaturez <= mv_par04)
			RecLock("cArqTmp",.T.)
			cArqTmp->NATUR := cNaturez
			cArqTmp->DESCR := SED->ED_DESCRIC
			cArqTmp->MES   := StrZero(nMeses,2,0)
			cArqTmp->ENTR  := cEntr
			cArqTmp->SAID  := cSaid
		Endif	
	Next
	dbSeek(cNaturez + cMes)
Endif
RecLock("cArqTmp")
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fin730Cria³ Autor ³ Wagner Mobile Costa   ³ Data ³ 30/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Monta arquivo temporario para apresentacao orcado x real   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Fin730Cria(cArqTmp,cIndex1,cIndex2,cIndex3,lRelato,lR4)    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cArqTmp - Nome do Arquivo temporario a ser criado          ³±±
±±³          ³ cIndex1 - Nome do indice temporario  Contas a Receber      ³±±
±±³          ³ cIndex2 - Nome do indice temporario  Contas a Pagar        ³±±
±±³          ³ cIndex3 - Nome do indice temporario  Movimento Bancario    ³±±
±±³          ³ lRelato - Indica se e chamado via relatorio (Default .T.)  ³±±
±±³          ³ aNivel   - Array com nivels de quebra                      ³±±
±±³          ³ aQuebras - Array de Quebras baseado MV_MASCNAT             ³±±
±±³          ³ lR4		- logico para dizer se eh R4			          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaFin                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fin730Cria(cArqTmp As Character, cIndex1 As Character, cIndex2 As Character, cIndex3 As Character, lRelato As Logical, ;
			aNiveis As Array, aQuebR As Array, aQuebO As Array, aQuebA As Array, lR4 As Logical, oReport As Object, cSitua As Character) As Array

Local nMoedaBco	As Numeric
Local aOrcado	As Array
Local aArrayQ 	As Array
Local aTotais 	As Array
Local cNatur	As Character 
Local aTotal 	As Array
Local aStru 	As Array
Local nMeses	As Numeric
Local nLaco		As Numeric
Local nQuebras	As Numeric
Local nX		As Numeric
Local nTamSit	As Numeric
Local lTemSev 	As Logical
Local oSection1	As Object

DEFAULT cArqTmp := ""
DEFAULT cIndex1 := ""
DEFAULT cIndex2 := ""
DEFAULT cIndex3 := ""
DEFAULT lRelato	:= .T.
DEFAULT aNiveis := {}
DEFAULT aQuebR 	:= {}
DEFAULT aQuebO 	:= {}
DEFAULT aQuebA 	:= {}
DEFAULT lR4		:= .F.
DEFAULT oReport := Nil
DEFAULT cSitua  := ""


nMoedaBco	:= 1
aOrcado		:= {}
aArrayQ 	:= {}
aTotais 	:= { 	{Capital(STR0009),0,0,0,0,0,0,0,0,0,0,0,0} ,;
	  	  					{Capital(STR0010),0,0,0,0,0,0,0,0,0,0,0,0} ,;
							{Capital(STR0009),0,0,0,0,0,0,0,0,0,0,0,0} ,;
							{Capital(STR0010),0,0,0,0,0,0,0,0,0,0,0,0} ,;
							{Capital(STR0008),0,0,0,0,0,0,0,0,0,0,0,0} ,;
							{Capital(STR0008),0,0,0,0,0,0,0,0,0,0,0,0}  }
aTotal		:= {}
aStru 		:= SE5->(dbStruct())
lTemSev 	:= .F.
nTamSit		:= TamSX3("E1_SITUACA")[1]

If !lRelato .And. Empty(cSituaca)
	If !Empty(cSitua)
		If "|" $ cSitua
			cSituaca	:=	cSitua
		Else
			For nX := 1 To Len(AllTrim(cSitua))
				cSituaca	+= SubStr(cSitua,nX, nTamSit) + "|"
			Next nX
		EndIf
	Else
		cSituaca	:= FN022LstCb(0)
	EndIf
EndIf

cFilterUser:= Iif(Type("aReturn[7]") == "U"," ",aReturn[7])

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera arquivo de Trabalho      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCampos:={ 	{"NATUR"  , "C" , Len(SED->ED_CODIGO),0},;
			{"MES"    , "C" , 03,0},;
			{"ENTR"   , "C" , 01,0},;
			{"SAID"   , "C" , 01,0},;
			{"DESCR"  , "C" , 30,0},;
			{"AENTR"  , "N" , 17,2},;
			{"ASAID"  , "N" , 17,2},;
			{"RENTR"  , "N" , 17,2},;
			{"RSAID"  , "N" , 17,2} }

If(__oFinr730 <> NIL)
	
	__oFinr730:Delete()
	__oFinr730 := NIL

EndIf

//Criando a tabela temporaria
__oFinr730 := FwTemporaryTable():New("cArqTmp")
//Setando as colunas
__oFinr730:SetFields(aCampos)
//Criando o indicie 
__oFinr730:AddIndex("1",{"NATUR","MES"})
//Criando a Tabela Temporaria

If Type("cArqTmp->NATUR") == "C" 
	cArqTmp->(DbCloseArea())
	__oFinr730:Create()
Else
	__oFinr730:Create()
EndIf

If lR4
	oSection1	:= oReport:Section(1)
	cFilterUser := oSection1:GetAdvplExp("SED")
Endif	

Processa({|lEnd| GeraTmp(lEnd)} )
	
cQuery := "SELECT *"
cquery += " FROM "+RetSqlName("SE5")+" SE5 "
cQuery += " WHERE SE5.E5_FILORIG = '"+ cFilAnt +"'"

//NATUREZAS DE ENTRADA
cQuery += " AND ( SE5.E5_NATUREZ BETWEEN '"+ mv_par01 + "' AND '" + mv_par02 + "'"
//NATUREZAS DE SAÍDA
cQuery += " OR  SE5.E5_NATUREZ BETWEEN '"+ mv_par03 + "' AND '" + mv_par04 + "' )"

If mv_par05 == 1 // Regime de caixa
	cQuery += " AND SE5.E5_DATA >= '" + Dtos(U_BegOfYea(mv_par07)) + "'"
	cQuery += " AND SE5.E5_DATA <= '" + Dtos(U_EndOfYea(mv_par07)) + "'"
Else
	cQuery += " AND SE5.E5_DTDIGIT >= '" + Dtos(U_BegOfYea(mv_par07)) + "'"
	cQuery += " AND SE5.E5_DTDIGIT <= '" + Dtos(U_EndOfYea(mv_par07)) + "'"
EndIf
cQuery += " AND SE5.E5_TIPODOC NOT IN ('DC','JR','MT','CM','D2','J2','M2','C2','TL','CP','BL')"
cQuery += " AND SE5.E5_SITUACA NOT IN ('C','E','X')"
cQuery += " AND SE5.D_E_L_E_T_ <> '*'"
cQuery := ChangeQuery(cQuery)

DbSelectArea("SE5")
DbCloseArea()

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"SE5",.T.,.T.)
aEval(aStru, {|e| If(e[2]!= "C", TCSetField("SE5", e[1], e[2],e[3],e[4]),Nil)})
	
If lRelato .And. !lR4
	SetRegua( Reccount())
Else
	ProcRegua( Reccount())
Endif

dbGoTop()		
While SE5->(!Eof()) .and. SE5->E5_FILIAL==xFilial("SE5")

    If lRelato .And. !lR4
		IncRegua()
    Else
		IncProc()
	Endif

	//Aplico Filtro do usuario
	If SED->(dbSeek(xFilial("SED")+SE5->E5_NATUREZ))
		dbSelectArea("SED")
		If !Empty(cFilterUser).and.!(&cFilterUser)
			dbSelectArea("SE5")
			SE5->(dbskip())
			Loop
		Endif
	Else
		SE5->(dbskip())
		Loop
	Endif

	dbSelectArea("SE5")

	// Para transferencias bancarias ou estorno de transferencia apenas verifico se
	// esta dentro das naturezas solicitadas, pois com o estorno de transferencia
	// a natureza de movimentos a receber, recebe um movimento a pagar que deve 
	// ser considerado para que se verifique a nao realizacao (o estorno!)
	If (SE5->E5_NATUREZ < mv_par01 .or. SE5->E5_NATUREZ > mv_par02) .and. ;
		(SE5->E5_NATUREZ < mv_par03 .or. SE5->E5_NATUREZ > mv_par04)
		SE5->(dbskip())
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta‡”es especiais ou canceladas n„o aparecem no relat¢rio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF SE5->E5_TIPODOC $ "DC|JR|MT|CM|D2|J2|M2|C2|TL|CP|BL" .or. SE5->E5_SITUACA $ "C|E|X"
		SE5->(dbSkip())
		Loop
	EndIF

	If SE5->E5_TIPODOC == "CH"
		dbSelectArea("SEF")
		dbSetOrder(1)
		If dbSeek(xFilial("SEF")+SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ))
			If SEF->EF_ORIGEM != "FINA390AVU"
            dbSelectArea("SE5")
				SE5->(dbSkip())
				Loop
			Endif
		Endif
	Endif

	If !Empty(SE5->E5_MOTBX)	
		If !MovBcoBx(SE5->E5_MOTBX) .OR. (SE5->E5_MOTBX == 'LIQ') 
			SE5->(dbSkip())
			LOOP
		EndIf
	EndIf

	If !Empty(SE5->E5_NUMERO)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se existe estorno para esta baixa                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If TemBxCanc(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ)
			SE5->(dbSkip())
			Loop
		EndIf
	Endif
    
	If cPaisLoc	# "BRA"
	   SA6->(DbSetOrder(1))
	   SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
	   nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
	Endif

    If mv_par08 == 2
       If nMoedaBco <> mv_par06
          SE5->(DbSkip())
          Loop
       EndIf
    EndIf    

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Armazena a data que ser  usada pelo arquivo tempor rio. Caso       ³
	//³ a op‡„o de data for competˆncia, ent„o ser  usado o campo VENCREA  ³
	//³ do SE1 ou do SE2.                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dDataTemp := SE5->E5_DATA
	cSaid := " "
	cEntr := " "

	lRet := .T.
	If mv_par05 == 2 
		If !Empty(SE5->E5_NUMERO) // Regime de competˆncia
			If SE5->E5_RECPAG == "R"
				If SE1->(dbSeek(xFilial("SE1")+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))
					If SE1->E1_EMIS1 < U_BegOfYea(mv_par07) .OR. ;
						SE1->E1_EMIS1 > U_EndOfYea(mv_par07)
						lRet := .F.
					Else
						cEntr := "S"
						dDataTemp := SE1->E1_EMIS1
					Endif
				Endif
			Else
				If SE2->(dbSeek(xFilial("SE2")+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR)))
					If SE2->E2_EMIS1 < U_BegOfYea(mv_par07) .OR. ;
						SE2->E2_EMIS1 > U_EndOfYea(mv_par07)
						lRet := .F.
					Else
						dDataTemp := SE2->E2_EMIS1
						cSaid := "S"
					Endif
				Endif
			Endif
		Else
			lRet := .F.
		Endif	
	Endif
	If lRet
	 
 		lTemSEV := .F.
			
		SEV->(DBSetOrder(2))
		If SEV->(MsSeek(xFilial("SEV")+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+"2")))
			lTemSev := .T.
			
			While 	SEV->(!Eof()) .And.;
				xFilial("SEV")+SEV->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA+EV_IDENT) ==;
			 	SEV->EV_FILIAL + SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+"2") 
								
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona o arquivo tempor rio na natureza/mes  ³
				//³ correspondente … aquele registro                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If ((SEV->EV_NATUREZ >= mv_par01 .And. SEV->EV_NATUREZ <= mv_par02) .Or.;
				(SEV->EV_NATUREZ >= mv_par03 .And. SEV->EV_NATUREZ <= mv_par04))			
					U_fr733Pos(SEV->EV_NATUREZ,dDataTemp,cEntr)
					FR730ProcNat(nMoedaBco,nDecs)
				EndIf 
	  			SEV->(DbSkip()) 
			EndDo
			
		ElseIf SEV->(MsSeek(xFilial("SEV")+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+"1")))
			lTemSev := .T.
		
			While 	SEV->(!Eof()) .And.;
				xFilial("SEV")+SEV->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA+SEV->EV_IDENT) ==;
			 	SEV->EV_FILIAL + SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+"1") 
								
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona o arquivo tempor rio na natureza/mes  ³
				//³ correspondente … aquele registro                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If ((SEV->EV_NATUREZ >= mv_par01 .And. SEV->EV_NATUREZ <= mv_par02) .Or.;
				(SEV->EV_NATUREZ >= mv_par03 .And. SEV->EV_NATUREZ <= mv_par04))			
					U_fr733Pos(SEV->EV_NATUREZ,dDataTemp,cEntr)
					FR730ProcNat(nMoedaBco,nDecs)
				EndIf 
				SEV->(DbSkip()) 
			EndDo
		
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona o arquivo tempor rio na natureza/mes  ³
			//³ correspondente … aquele registro                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		  	U_fr733Pos(SE5->E5_NATUREZ,dDataTemp,cEntr)
			If !(SE5->E5_TIPODOC $ "TR/TE")		//Se nao for transferencia e estorno
				if SE5->E5_TIPODOC != "ES"	// Estorno
					If SE5->E5_RECPAG == "R"
						cArqTmp->rEntr += Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Else
						cArqTmp->rSaid += Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Endif
				Else
					If SE5->E5_RECPAG == "P"
						cArqTmp->rEntr -= Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Else
						cArqTmp->rSaid -= Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Endif
				ENDIF
			Else
				If SE5->E5_TIPODOC == "TR"		//Transferencia
					If SE5->E5_RECPAG == "R"
						cArqTmp->rEntr += Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Else
						cArqTmp->rSaid += Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Endif
				ElseIf SE5->E5_TIPODOC == "TE"	//Estorno de transferencia
					If SE5->E5_RECPAG == "R"
						cArqTmp->rEntr -= Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Else
						cArqTmp->rSaid -= Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Endif
				Endif				
			Endif
			cArqTmp->(MsUnlock())
		Endif
	Endif
	dbSelectArea("SE5")
	dbSkip()
Enddo

dbSelectArea("SE5")
dbCloseArea()
ChKFile("SE5")
dbSelectArea("SE5")
dbSetOrder(1)

If ! lRelato
	cArqTmp->( DbGoTop() )
	If aNiveis <> Nil
		nLimite := IIf(Len(aNiveis) > 1, Len(aNiveis)-1, 1)
	Endif
Endif

While ! lRelato .And. !cArqTmp->( Eof() )

	cNatur := cArqTmp->Natur
	For nLaco := 1 to Len( aQuebR )
		 aQuebR[nLaco,1] := Subst( cArqtmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )
		 aQuebO[nLaco,1] := Subst( cArqtmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )
		 aQuebA[nLaco,1] := Subst( cArqtmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )
	Next

	aOrcado := { 0,0,0,0,0,0,0,0,0,0,0,0 }
	If SE7->(dbSeek(xFilial("SE7")+cArqTmp->NATUR+Str(Year(mv_par07),4,0)))
		aOrcado[01] += Round(NoRound(xMoeda(SE7->E7_VALJAN1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[02] += Round(NoRound(xMoeda(SE7->E7_VALFEV1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[03] += Round(NoRound(xMoeda(SE7->E7_VALMAR1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[04] += Round(NoRound(xMoeda(SE7->E7_VALABR1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[05] += Round(NoRound(xMoeda(SE7->E7_VALMAI1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[06] += Round(NoRound(xMoeda(SE7->E7_VALJUN1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[07] += Round(NoRound(xMoeda(SE7->E7_VALJUL1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[08] += Round(NoRound(xMoeda(SE7->E7_VALAGO1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[09] += Round(NoRound(xMoeda(SE7->E7_VALSET1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[10] += Round(NoRound(xMoeda(SE7->E7_VALOUT1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[11] += Round(NoRound(xMoeda(SE7->E7_VALNOV1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
		aOrcado[12] += Round(NoRound(xMoeda(SE7->E7_VALDEZ1,SE7->E7_MOEDA,mv_par06,mv_par07,nDecs+1),nDecs+1),nDecs+1)
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Este For avan‡a blocos de 12 em 12 registros  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nMeses := 1 to 12
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Acumula os totais e os parciais  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aTotais[1,nMeses+1] += cArqTmp->aEntr
		aTotais[2,nMeses+1] += cArqtmp->rEntr
		aTotais[3,nMeses+1] += cArqTmp->aSaid
		aTotais[4,nMeses+1] += cArqtmp->rSaid

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Armazena em separado o or‡ado para naturezas de entrada   ³
		//³ e naturezas de sa¡da. o Usu rio n„o deve misturar as      ³
		//³ naturezas.                                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cArqTmp->ENTR == "S"
			aTotais[5,nMeses+1] += aOrcado[nMeses]
		Else			
			aTotais[6,nMeses+1] += aOrcado[nMeses]
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Lan‡a em todos os n¡veis da quebra, pois estaremos        ³
		//³ trabalhando sempre com n¡veis hier rquicos de um bra‡o    ³
		//³ principal £nico da raiz.                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nLaco := 1 to Len(aQuebR) // Todos os n¡veis
			 aQuebR[nLaco,nMeses+1] += cArqtmp->rEntr+cArqtmp->rSaid
			 aQuebA[nLaco,nMeses+1] += cArqtmp->aEntr+cArqtmp->aSaid
			 aQuebO[nLaco,nMeses+1] += aOrcado[nMeses]
		Next

		cArqTmp->( dbSkip() )
	Next
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Verifica se houve quebra em algum n¡vel ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lQuebra := .F.
	For nLaco := 1 to nLimite
		If aQuebR[nLaco,1] # Subst( cArqTmp->NATUR, aNiveis[nLaco,1], aNiveis[nLaco,2] )
			For nQuebras := nLimite to nLaco Step -1
				cQuebra := Left(cNatur, aNiveis[nQuebras,1] + aNiveis[nQuebras,2] - 1 )
				cQuebra := MascNat( cQuebra )
				While right(cQuebra,1) == "."
					cQuebra := Left(cQuebra,Len(cQuebra)-1)
				End

				Aadd(aArrayQ, { STR0013 + cQuebra, "", "", "", "", "", "", "", "", "", "", "", "" } )
				Aadd(aArrayQ, { Capital(STR0008), 	Trans(aQuebO[nQuebras,2], TM(0,14,nDecs)),; 
											Trans(aQuebO[nQuebras,3], TM(0,14,nDecs)),;
											Trans(aQuebO[nQuebras,4], TM(0,14,nDecs)),;
											Trans(aQuebO[nQuebras,5], TM(0,14,nDecs)),;
											Trans(aQuebO[nQuebras,6], TM(0,14,nDecs)),;
											Trans(aQuebO[nQuebras,7], TM(0,14,nDecs)),;
											Trans(aQuebO[nQuebras,8], TM(0,14,nDecs)),;
											Trans(aQuebO[nQuebras,9], TM(0,14,nDecs)),;
											Trans(aQuebO[nQuebras,10], TM(0,14,nDecs)),;
											Trans(aQuebO[nQuebras,11], TM(0,14,nDecs)),;
											Trans(aQuebO[nQuebras,12], TM(0,14,nDecs)),;
											Trans(aQuebO[nQuebras,13], TM(0,14,nDecs)) } )

				Aadd(aArrayQ, { Capital(STR0009), 	Trans(aQuebR[nQuebras,2], TM(0,14,nDecs)),; 
											Trans(aQuebR[nQuebras,3], TM(0,14,nDecs)),;
											Trans(aQuebR[nQuebras,4], TM(0,14,nDecs)),;
											Trans(aQuebR[nQuebras,5], TM(0,14,nDecs)),;
											Trans(aQuebR[nQuebras,6], TM(0,14,nDecs)),;
											Trans(aQuebR[nQuebras,7], TM(0,14,nDecs)),;
											Trans(aQuebR[nQuebras,8], TM(0,14,nDecs)),;
											Trans(aQuebR[nQuebras,9], TM(0,14,nDecs)),;
											Trans(aQuebR[nQuebras,10], TM(0,14,nDecs)),;
											Trans(aQuebR[nQuebras,11], TM(0,14,nDecs)),;
											Trans(aQuebR[nQuebras,12], TM(0,14,nDecs)),;
											Trans(aQuebR[nQuebras,13], TM(0,14,nDecs)) } )

				Aadd(aArrayQ, { Capital(STR0010), 	Trans(aQuebA[nQuebras,2], TM(0,14,nDecs)),; 
											Trans(aQuebA[nQuebras,3], TM(0,14,nDecs)),;
											Trans(aQuebA[nQuebras,4], TM(0,14,nDecs)),;
											Trans(aQuebA[nQuebras,5], TM(0,14,nDecs)),;
											Trans(aQuebA[nQuebras,6], TM(0,14,nDecs)),;
											Trans(aQuebA[nQuebras,7], TM(0,14,nDecs)),;
											Trans(aQuebA[nQuebras,8], TM(0,14,nDecs)),;
											Trans(aQuebA[nQuebras,9], TM(0,14,nDecs)),;
											Trans(aQuebA[nQuebras,10], TM(0,14,nDecs)),;
											Trans(aQuebA[nQuebras,11], TM(0,14,nDecs)),;
											Trans(aQuebA[nQuebras,12], TM(0,14,nDecs)),;
											Trans(aQuebA[nQuebras,13], TM(0,14,nDecs)) } )

				Aadd(aArrayQ, { "", "", "", "", "", "", "", "", "", "", "", "", "" } )
				For nMeses := 2 To 13
					aQuebR[nQuebras,nMeses] := 0
					aQuebO[nQuebras,nMeses] := 0
					aQuebA[nQuebras,nMeses] := 0
				Next
			Next
			Exit
		Endif
	Next
	If cArqTmp->(Eof())
		Exit
	Endif
EndDo

Aadd(aTotal, { STR0015, "", "", "", "", "", "", "", "", "", "", "", "" } )

// aTotais[5] - Orcado Entradas

Aadd(aTotal, AClone(aTotais[5]))
For nMeses := 2 To 13
	aTotal[2][nMeses] := Trans(aTotal[2][nMeses], Tm(0,14,nDecs))
Next

// aTotais[2] - Realizado Entradas

Aadd(aTotal, AClone(aTotais[2]))
aTotal[3][1] := Capital(STR0009) // "Realizado"
For nMeses := 2 To 13
	aTotal[3][nMeses] := Trans(aTotal[3][nMeses], Tm(0,14,nDecs))
Next

// aTotais[1] - A Realizar Entradas

Aadd(aTotal, AClone(aTotais[1]))
aTotal[4][1] := Capital(STR0010) // "A Realizar"
For nMeses := 2 To 13
	aTotal[4][nMeses] := Trans(aTotal[4][nMeses], Tm(0,14,nDecs))
Next

Aadd(aTotal, AClone(aTotais[2]))
aTotal[5][1] := Capital(STR0011) // Real
For nMeses := 2 To 13
	aTotal[5][nMeses] := Trans(aTotal[5][nMeses] + aTotais[1][nMeses], Tm(0,14,nDecs))
Next

Aadd(aTotal, { STR0016, "", "", "", "", "", "", "", "", "", "", "", "" } )

// aTotais[6] - Orcado Saidas

Aadd(aTotal, AClone(aTotais[6]))
For nMeses := 2 To 13
	aTotal[7][nMeses] := Trans(aTotal[7][nMeses], Tm(0,14,nDecs))
Next

// aTotais[4] - Realizado Saidas

Aadd(aTotal, AClone(aTotais[4]))
aTotal[8][1] := Capital(STR0009) // "Realizado"
For nMeses := 2 To 13
	aTotal[8][nMeses] := Trans(aTotal[8][nMeses], Tm(0,14,nDecs))
Next

// aTotais[3] - A Realizar Saidas

Aadd(aTotal, AClone(aTotais[3]))
aTotal[9][1] := Capital(STR0010) // "A Realizar"
For nMeses := 2 To 13
	aTotal[9][nMeses] := Trans(aTotal[9][nMeses], Tm(0,14,nDecs))
Next

Aadd(aTotal, AClone(aTotais[4]))
aTotal[10][1] := Capital(STR0011) // Real
For nMeses := 2 To 13
	aTotal[10][nMeses] := Trans(aTotal[10][nMeses] + aTotais[3][nMeses], Tm(0,14,nDecs))
Next

Aadd(aTotal, { 	STR0017, "", "", "", "", "", "", "", "", "", "", "", "" } )
Aadd(aTotal, { 	Capital(STR0008),;
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
				Trans(aTotais[5][13] - aTotais[6][13], Tm(0,14,nDecs)) } )

Aadd(aTotal, { 	Capital(STR0009),;
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
				Trans(aTotais[2][13] - aTotais[4][13], Tm(0,14,nDecs)) } )

Aadd(aTotal, { 	Capital(STR0010),;
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
				Trans(aTotais[1][13] - aTotais[3][13], Tm(0,14,nDecs)) } )

Aadd(aTotal, { 	Capital(STR0011),;
				Trans(	(aTotais[2][2] - aTotais[4][2]) +;
						(aTotais[1][2] - aTotais[3][2]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][3] - aTotais[4][3]) +; 
						(aTotais[1][3] - aTotais[3][3]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][4] - aTotais[4][4]) +; 
						(aTotais[1][4] - aTotais[3][4]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][5] - aTotais[4][5]) +; 
						(aTotais[1][5] - aTotais[3][5]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][6] - aTotais[4][6]) +; 
						(aTotais[1][6] - aTotais[3][6]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][7] - aTotais[4][7]) +; 
						(aTotais[1][7] - aTotais[3][7]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][8] - aTotais[4][8]) +; 
						(aTotais[1][8] - aTotais[3][8]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][9] - aTotais[4][9]) +; 
						(aTotais[1][9] - aTotais[3][9]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][10] - aTotais[4][10]) +; 
						(aTotais[1][10] - aTotais[3][10]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][11] - aTotais[4][11]) +; 
						(aTotais[1][11] - aTotais[3][11]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][12] - aTotais[4][12]) +; 
						(aTotais[1][12] - aTotais[3][12]), Tm(0,14,nDecs)),;
				Trans(	(aTotais[2][13] - aTotais[4][13]) +; 
						(aTotais[1][2] - aTotais[3][2]), Tm(0,14,nDecs)) } )

Return { aTotal, aArrayQ, aTotais }

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GeraTmp   ³ Autor ³ Claudio D. de Souza   ³ Data ³ 30/01/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Monta arquivo temporario de trabalho para SQL              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GeraTmp                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR730 - SigaFin                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GeraTmp(lEnd)
Local aStruSEx	:= {}
Local cChave	:= ""
Local cOrder	:= ""
Local nDecs     := MsDecimais(mv_par06)
Local cQuery	:= ""
Local cStringMV	:= ""
Local cNatAnt 	:= ""
Local cDbMs	 	:= UPPER(TcGetDb())
Local nMeses	:= 0	
Local aSaldoTit	:= {}
Local nX		:= 0

cFilterUser:= Iif(Type("cFilterUser") == "U", If(Type("aReturn[7]")=="U"," ", aReturn[7]), cFilterUser)

ProcRegua((SE1->(RecCount())+SE2->(RecCount())))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria String com os parametros utilizados nos filtros dos arquivos SE1 e SE2 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par10 == 2 // Nao considera titulos provisorios
	cStringMV := FormatSep(MVPROVIS,"|")+","  // A Funcao FORMATSEP e igual a FORMATIN mas sem os parenteses e aspas
Endif
cStringMV += FormatSep(MVABATIM,"|")+","
cStringMV += FormatSep(MVRECANT,"/")+","  // Como e usado para o campo tipo nao influencia tratar o PAG e o REC para SE1 e SE2
cStringMV += FormatSep(MVPAGANT,"/")+","  
cStringMV += FormatSep(MV_CRNEG,",")+","
cStringMV += FormatSep(MV_CPNEG,"|")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo SE1 - Contas a Receber                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE1")
dbSetOrder(3) // Ordem por natureza
aStruSEx	:= dbStruct()
cChave	:= IndexKey()
cOrder	:= SqlOrder(cChave)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Query unindo SED, SE1 e SE2                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQuery := "SELECT SED.ED_CODIGO ED_CODIGO, SED.ED_DESCRIC, 'R' ED_TIPO,"
cQuery +=        "SE1.E1_TIPO TIPO, SE1.E1_SALDO SALDO, SE1.E1_MOEDA MOEDA, SE1.E1_PREFIXO PREFIXO," 
cQuery +=        "SE1.E1_NUM NUM, SE1.E1_PARCELA PARCELA, SE1.E1_VENCREA VENCREA, SE1.E1_CLIENTE CLIFOR, SE1.E1_LOJA LOJA, SE1.R_E_C_N_O_ Recno "
cQuery += " FROM " +	RetSqlName("SED")+" SED "
If cDbMs $ "DB2|MYSQL|POSTGRES|MSSQL|MSSQL7|MSSQL5|INFORMIX|ORACLE"
	cQuery += " RIGHT OUTER JOIN "+ RetSqlName("SE1") + " SE1 "
	cQuery += " ON ( SED.ED_CODIGO = SE1.E1_NATUREZ ) "
	cQuery += " AND SE1.E1_FILORIG = '" + cFilAnt + "'"
	cQuery += " AND SE1.E1_SITUACA IN " + FormatIN(cSituaca,"|")
	cQuery += " AND SE1.E1_TIPO NOT IN " + FormatIN(cStringMV,",") // cStringMV definida no inicio da FR731IMP
	cQuery += " AND SE1.E1_VENCREA >= '" + dTos(U_BegOfYea(mv_par07)) + "'"
	cQuery += " AND SE1.E1_VENCREA <= '" + dTos(U_EndOfYea(mv_par07)) + "'"
	cQuery += " AND SE1.E1_SALDO > 0 "
	cQuery += " AND SE1.D_E_L_E_T_ = ' '"		
Else
	cQuery += ", "+ RetSqlName("SE1") + " SE1 "
Endif
cQuery += " WHERE SED.ED_FILIAL = '"+xFilial("SED")+"'"
cQuery += " AND SED.ED_CODIGO between '"+ mv_par01 + "' AND '" + mv_par02 + "'"

If !(cDbMs $ "DB2|MYSQL|POSTGRES|MSSQL|MSSQL7|MSSQL5|INFORMIX|ORACLE")
	cQuery += "   AND SED.ED_CODIGO *= SE1.E1_NATUREZ "
	cQuery += " AND SE1.E1_FILORIG = '" + cFilAnt + "'"
	cQuery += " AND SE1.E1_SITUACA IN " + FormatIN(cSituaca,"|")
	cQuery += " AND SE1.E1_TIPO NOT IN " + FormatIN(cStringMV,",") // cStringMV definida no inicio da FR731IMP
	cQuery += " AND SE1.E1_VENCREA >= '" + dTos(U_BegOfYea(mv_par07)) + "'"
	cQuery += " AND SE1.E1_VENCREA <= '" + dTos(U_EndOfYea(mv_par07)) + "'"
	cQuery += " AND SE1.E1_SALDO > 0 "
Endif

If mv_par08 == 2
	cQuery += " AND SE1.E1_MOEDA = " + ALLTRIM(STR(mv_par06))
EndIf    

cQuery += " AND SED.D_E_L_E_T_ <> '*'"

If !(cDbMs $ "DB2|MYSQL|POSTGRES|MSSQL|MSSQL7|MSSQL5|INFORMIX|ORACLE")
	cQuery += " AND SE1.D_E_L_E_T_ <> '*'"
EndIf	

cQuery += " UNION ALL"
cQuery += " SELECT SED.ED_CODIGO ED_CODIGO, SED.ED_DESCRIC, 'P' ED_TIPO,"
cQuery += "SE2.E2_TIPO TIPO, SE2.E2_SALDO SALDO, SE2.E2_MOEDA MOEDA, SE2.E2_PREFIXO PREFIXO," 
cQuery += "SE2.E2_NUM NUM, SE2.E2_PARCELA PARCELA, SE2.E2_VENCREA VENCREA, SE2.E2_FORNECE CLIFOR, SE2.E2_LOJA LOJA, SE2.R_E_C_N_O_ Recno "
cQuery += " FROM " +	RetSqlName("SED")+" SED "

If cDbMs $ "DB2|MYSQL|POSTGRES|MSSQL|MSSQL7|MSSQL5|INFORMIX|ORACLE"
	cQuery += " RIGHT OUTER JOIN "+ RetSqlName("SE2") + " SE2 "
	cQuery += " ON ( SED.ED_CODIGO = SE2.E2_NATUREZ ) "
	cQuery += " AND SE2.E2_FILORIG = '" + cFilAnt + "'"
	cQuery += " AND SE2.E2_TIPO NOT IN " + FormatIN(cStringMV,",") // cStringMV definida no inicio da FR731IMP
	cQuery += " AND SE2.E2_VENCREA >= '" + dTos(U_BegOfYea(mv_par07)) + "'"
	cQuery += " AND SE2.E2_VENCREA <= '" + dTos(U_EndOfYea(mv_par07)) + "'"
	cQuery += " AND SE2.E2_SALDO > 0 "
	cQuery += " AND SE2.D_E_L_E_T_ = ' '"	
Else
	cQuery += ", "+ RetSqlName("SE2") + " SE2 "
Endif

cQuery += " WHERE SED.ED_FILIAL = '"+xFilial("SED")+"'"
cQuery += " AND SED.ED_CODIGO between '"+ mv_par03 + "' AND '" + mv_par04 + "'"

If !(cDbMs $ "DB2|MYSQL|POSTGRES|MSSQL|MSSQL7|MSSQL5|INFORMIX|ORACLE")
	cQuery += " AND SED.ED_CODIGO *= SE2.E2_NATUREZ "
	cQuery += " AND SE2.E2_FILORIG = '" + cFilAnt + "'"
	cQuery += " AND SE2.E2_TIPO NOT IN " + FormatIN(cStringMV,",") // cStringMV definida no inicio da FR731IMP
	cQuery += " AND SE2.E2_VENCREA >= '" + dTos(U_BegOfYea(mv_par07)) + "'"
	cQuery += " AND SE2.E2_VENCREA <= '" + dTos(U_EndOfYea(mv_par07)) + "'"
	cQuery += " AND SE2.E2_SALDO > 0 "
Endif

If mv_par08 == 2
	cQuery += " AND SE2.E2_MOEDA = " + ALLTRIM(STR(mv_par06))
EndIf    

cQuery += " AND SED.D_E_L_E_T_ <> '*'"

If !(cDbMs $ "DB2|MYSQL|POSTGRES|MSSQL|MSSQL7|MSSQL5|INFORMIX|ORACLE")
	cQuery += " AND SE2.D_E_L_E_T_ <> '*'"
EndIf	

If cDbMs == "INFORMIX" .OR. cDbMs == "ANYWHERE"
	cQuery += ' ORDER BY 1'
Else
	cQuery += ' ORDER BY ED_CODIGO'
EndIf

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB", "VENCREA", "D")
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza o arquivo temporario com as entradas previstas - SE1       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cNatAnt := ""

While TRB->(!EOF())

	IncProc(STR0036) // "Criando arquivo temporário de trabalho"
	
	//Aplico Filtro do usuario
	If SED->(dbSeek(xFilial("SED")+TRB->ED_CODIGO))
		dbSelectArea("SED")
		If !Empty(cFilterUser).and.!(&cFilterUser)
			dbSelectArea("TRB")
			TRB->(dbSkip())
			Loop
		Endif	
		dbSelectArea("TRB")
	Else
		dbSelectArea("TRB")
		TRB->(dbSkip())
		Loop
	Endif	
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria-se espa‡o para os 12 meses, facilitando assim todo o processo  ³
	//³ de grava‡„o do arquivo temporario e da pr¢pria impress„o.           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->ED_CODIGO != cNatAnt
		cNatAnt := TRB->ED_CODIGO
		dbSelectArea( "cArqTmp" )
		For nMeses := 1 to 12
			If !DbSeek(TRB->ED_CODIGO+StrZero(nMeses,2,0)) 
				RecLock("cArqTmp",.T.)
				cArqTmp->NATUR := TRB->ED_CODIGO
				cArqTmp->DESCR := TRB->ED_DESCRIC
				cArqTmp->MES   := StrZero(nMeses,2,0)
				cArqTmp->ENTR	:= If(TRB->ED_TIPO=="R","S","")
				cArqTmp->SAID	:= If(TRB->ED_TIPO!="R","S","")
				MsUnLock()
			Endif
		Next
	Endif
	
	IF !EMPTY(TRB->RECNO)
		If TRB->ED_TIPO == 'R'
			SE1->(MsGoto(TRB->Recno))
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Se estiver utilizando multiplas naturezas, verifica o codigo da natureza³
			//³do arquivo de multiplas naturezas (SEV)                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			*/
			If SE1->E1_MULTNAT == "1"
				If !PesqNatSev("SE1","E1", MV_PAR01, MV_PAR02)
					TRB->(DbSkip())
					Loop
				Endif
			Endif
		Else
			SE2->(MsGoto(TRB->Recno))
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Se estiver utilizando multiplas naturezas, verifica o codigo da natureza³
			//³do arquivo de multiplas naturezas (SEV)                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			*/
			If SE2->E2_MULTNAT == "1"
				If !PesqNatSev("SE2","E2", MV_PAR03, MV_PAR04)
					TRB->(DbSkip())
					Loop
				Endif
			Endif
		Endif
	ENDIF
	
	IF !EMPTY(TRB->(PREFIXO+NUM+PARCELA+TIPO+CLIFOR+LOJA))
		If TRB->ED_TIPO == 'R'
			aSaldoTit := SdoTitNat(	TRB->PREFIXO	,;
									TRB->NUM		,;
									TRB->PARCELA	,;
									TRB->TIPO		,;
									TRB->CLIFOR		,;
									TRB->LOJA		,;
													,;
									"R"				,;
									"SE1"			,;
									MV_PAR06		,;
									.F.,,,"SE1")
			For nX := 1 To Len( aSaldoTit )
				U_fr733Pos(aSaldoTit[nX][1],TRB->VENCREA,If(TRB->ED_TIPO=="R","S",""),If(TRB->ED_TIPO!="R","S",""))
				IF !cArqTmp->(EOF())
					cArqTmp->aEntr += aSaldoTit[nX][2]
					cArqTmp->(MsUnlock())
				ENDIF
			Next
		Else
			aSaldoTit := SdoTitNat(	TRB->PREFIXO	,;
									TRB->NUM		,;
									TRB->PARCELA	,;
									TRB->TIPO		,;
									TRB->CLIFOR		,;
									TRB->LOJA		,;
													,;
									"P"				,;
									"SE2"			,;
									MV_PAR06		,;
									.F.,,,"SE2")
			For nX := 1 To Len( aSaldoTit )
				U_fr733Pos(aSaldoTit[nX][1],TRB->VENCREA,If(TRB->ED_TIPO=="R","S",""),If(TRB->ED_TIPO!="R","S",""))
				IF !cArqTmp->(EOF())
					cArqTmp->aSaid += aSaldoTit[nX][2]	// Atualiza a Realizar
					cArqTMP->(MsUnlock())
				ENDIF
			Next
		Endif
	ENDIF
	DbSelectArea("TRB")
	DbSkip()
End
TRB->(dbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura os arquivos     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE1")
dbCloseArea()
ChkFile("SE1")
dbSelectArea("SE2")
dbCloseArea()
ChkFile("SE2")
dbSelectArea("SED")
dbCloseArea()
ChkFile("SED")

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FORMATSEP³ Autor ³ --------------------  ³ Data ³ --/--/-- ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ INCLUI UM SEPARADOR "," OU ALTERA O SEPARADOR EXISNTENTE   ³±±
±±³          ³ EM UMA STRING DE ITENS                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FORMATSEP(CSTRING,CSEP,NTAM)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ CSTRING - ITENS DA LISTA                                   ³±±
±±³          ³ CSEP    - SEPARADOR ATUAL                                  ³±±
±±³          ³ NTAM    - TAMANHO DOS ITENS PARA CASO NAO EXISTA SEPARADOR ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FormatSep(cString,cSep,nTam)
Local cRet   := ""
Local nPoSep
Default nTam := 0

While .T.
// localiza a posicao do separador e separa a string encontrada
	If nTam > 0  
		nPoSep := nTam
	Else
		nPoSep := AT(cSep,cString)
	Endif 

	cRet   += IF(nPoSep#0, LEFT(cString,nPoSep-If(nTam>0,0,1))+",", cString)
    
    // verifica se existem mais separadores
	IF nPoSep#0 
		If Len(cString) > nTam
			cString := SUBSTR(cString,nPoSep+1)
		Else
			cRet := Left(cRet,Len(cRet)-3)
			EXIT
		Endif	
	Else		
		EXIT
	ENDIF
ENDDO

RETURN cRet

Static Function FR730ProcNat(nMoedaBco,nDecs)
Local nProp := SEV->EV_PERC  
Local lTemSEV := .T.

If !(SE5->E5_TIPODOC $ "TR/TE")            
	If SE5->E5_RECPAG == "R"
		If !(SEV->EV_SITUACA $ "XE")
			cArqTmp->rEntr += Round(NoRound(xMoeda(SE5->E5_VALOR*nProp,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
		EndIf	
	Else
		If lTemSEV
			If !(SEV->EV_SITUACA $ "XE")
				cArqTmp->rSaid += Round(NoRound(xMoeda(SE5->E5_VALOR*nProp,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)				
			Endif
		Else
			cArqTmp->rSaid += Round(NoRound(xMoeda(SE5->E5_VALOR*nProp,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
		EndIf
	Endif
Else
	If SE5->E5_TIPODOC == "TR"
		If SE5->E5_RECPAG == "R"
			cArqTmp->rEntr += Round(NoRound(xMoeda(SE5->E5_VALOR*nProp,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
		Else
			If lTemSEV
				cArqTmp->rSaid += Round(NoRound(xMoeda(SE5->E5_VALOR*nProp,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
			Else
				cArqTmp->rSaid += Round(NoRound(xMoeda(SE5->E5_VALOR*nProp,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
			EndIf
		Endif
	ElseIf SE5->E5_TIPODOC == "TE"
		If SE5->E5_RECPAG == "R"
			cArqTmp->rEntr -= Round(NoRound(xMoeda(SE5->E5_VALOR*nProp,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
		Else
			cArqTmp->rSaid -= Round(NoRound(xMoeda(SE5->E5_VALOR*nProp,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
		Endif
	Endif				
Endif

cArqTmp->(MsUnlock()) 

Return	

//-------------------------------------------------------------------
/*/{Protheus.doc} FINR730
Função responsável por zerar as variáveis estáticas    

@author Rodrigo Oliveira
@since 26/11/2019
@version P12
/*/
//-------------------------------------------------------------------
Static Function ZeraStatic()
	cSituaca	:= ""
Return