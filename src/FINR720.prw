/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR720.CH"
#Include "PROTHEUS.CH"

#DEFINE COD_NATUREZA			1
#DEFINE NATUREZA				2
#DEFINE AREALIZAR				3
#DEFINE REALIZADO				4
#DEFINE ORCADO					5
#DEFINE PERC					6
#DEFINE AREALIZARAC			7
#DEFINE REALIZADOAC			8
#DEFINE ORCADOAC				9
#DEFINE PERCAC					10

#DEFINE REALIZARRECEBER		1
#DEFINE REALIZARPAGAR		2
#DEFINE REALIZARSALDOS		3
#DEFINE REALIZADORECEBER	4
#DEFINE REALIZADOPAGAR		5
#DEFINE REALIZADOSALDOS		6
#DEFINE TOTALRECEBER			7
#DEFINE TOTALPAGAR			8
#DEFINE TOTALSALDOS			9
#DEFINE ORCADORECEBER		10
#DEFINE ORCADOPAGAR			11
#DEFINE ORCADOSALDOS			12

#DEFINE REALIREC				1
#DEFINE REALIPAG				2
#DEFINE TOTREC					3
#DEFINE TOTPAG					4

Static lFWCodFil := .T.
Static __oFinr720

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} FINR720
Comparativo entre Valores Orçados x Reais Mensal

@sample	U_FINR720()
@return	Nil
@author Vinicius Barreira
@since 04/08/1995
@version MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

User Function FINR720()

oReport := ReportDef()
oReport:PrintDialog()

Return

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Definicao do layout do Relatorio

@sample		oReport := ReportDef()
@return		oReport, objeto do TReport
@author 	Daniel Batori
@since		11/08/2006
@version	MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

Static Function ReportDef()
Local oReport
Local oSection1, oTotalMes, oCompara
Local oFilial //Gestão Corporativa
Local oSecFil //Gestão Corporativa

oReport := TReport():New("FINR720",STR0055,"FIN720",{|oReport| ReportPrint(oReport)},STR0001+STR0002+STR0003)

oReport:SetPortrait(.T.)

pergunte("FIN720",.F.)
// Variaveis utilizadas para parƒmetros
//      Entradas
// mv_par01            // da Natureza
// mv_par02            // at‚ a Natureza
//      Saidas
// mv_par03            // da Natureza
// mv_par04            // at‚ a Natureza
//      Outros Parametros
// mv_par05            // Regime de Caixa/Competˆncia
// mv_par06            // Moeda
// mv_par07            // Imprime Acumulados ?
// mv_par08            // Data de Referencia ?
// mv_par09            // Outras moedas      ?
// mv_par10            // Considera Provisorios?
// mv_par11      	   // Data Base
// mv_par12      	   // Seleciona Filiais ?

oSection1 := TRSection():New(oReport,STR0054,{"SED"},)
TRCell():New(oSection1,"ED_CODIGO"	,"SED",STR0033,,,.F.,) //"Cod Natureza"
TRCell():New(oSection1,"ED_DESCRIC","SED",STR0034,,28,.F.,)  //"Descricao"
TRCell():New(oSection1,"AREALIZAR"	,,STR0035 + CRLF + PadC(STR0040,13),"@E 99,999,999.99",13,,) //"A Realizar" + "(A)"
TRCell():New(oSection1,"REALIZADO"	,,STR0036 + CRLF + PadC(STR0041,13),"@E 99,999,999.99",13,,) //"Realizado" + "(B)"
TRCell():New(oSection1,"ORCADO"		,,STR0037 + CRLF + PadC(STR0042,13),"@E 99,999,999.99",13,,) //"Orcado" + "(C)"
TRCell():New(oSection1,"PERC"			,,PadC(STR0038,20) + CRLF + STR0043,,20,,) //"%" + "(A+B)/C    B/C"
TRCell():New( oSection1,"AREALIZARAC",,STR0039 + CRLF + PadC(STR0044,13),"@E 99,999,999.99",13,,) //"Acumulado" + "Realizado (D)"
TRCell():New( oSection1,"REALIZADOAC",,STR0039 + CRLF + PadC(STR0045,13),"@E 99,999,999.99",13,,) //"Acumulado" + "Realizado (E)"
TRCell():New( oSection1,"ORCADOAC",,STR0039 + CRLF + PadC(STR0046,13),"@E 99,999,999.99",13,,) //"Acumulado" + "Orcado(F)"
TRCell():New( oSection1,"PERCAC",,PadC(STR0038,20) + CRLF + STR0047 ,,20,,) //"%" + "(D+E)/F    E/F"
oSection1:Cell("PERC"):SetHeaderAlign("CENTER")
oSection1:Cell("PERCAC"):SetHeaderAlign("CENTER")


oTotalMes := TRSection():New( oReport, STR0052, {"cArqTmp"}, ) //"Totais no Mês"
TRCell():New( oTotalMes,"RECEBER",,STR0011,,19,, {|| "" } ) //"Receber"
TRCell():New( oTotalMes,"PAGAR",,STR0012,,21,, {|| "" } ) //"Pagar  "
TRCell():New( oTotalMes,"SALDOS",,STR0013,,,,{|| "" } ) //"Saldos"
TRCell():New( oTotalMes,"REALIZARRECEBER",,Pad(STR0048,10,"."),"@E 9,999,999,999.99",16,,) //"A Realizar"
TRCell():New( oTotalMes,"REALIZARPAGAR",,Pad(STR0048,10,"."),"@E 9,999,999,999.99",16,,) //"A Realizar"
TRCell():New( oTotalMes,"REALIZARSALDOS",,Pad(STR0048,10,"."),,40,,) //"A Realizar"
TRCell():New( oTotalMes,"REALIZADORECEBER",,Pad(STR0049,10,"."),"@E 9,999,999,999.99",16,,) //"Realizado"
TRCell():New( oTotalMes,"REALIZADOPAGAR",,Pad(STR0049,10,"."),"@E 9,999,999,999.99",16,,) //"Realizado"
TRCell():New( oTotalMes,"REALIZADOSALDOS",,Pad(STR0049,10,"."),,40,,) //"Realizado"
TRCell():New( oTotalMes,"TOTALRECEBER",,Pad(STR0050,10,"."),"@E 9,999,999,999.99",16,,) //"Total"
TRCell():New( oTotalMes,"TOTALPAGAR",,Pad(STR0050,10,"."),"@E 9,999,999,999.99",16,,) //"Total"
TRCell():New( oTotalMes,"TOTALSALDOS",,Pad(STR0050,10,"."),,40,,) //"Total"
TRCell():New( oTotalMes,"ORCADORECEBER",,Pad(STR0051,10,"."),"@E 9,999,999,999.99",16,,) //"Orcado"
TRCell():New( oTotalMes,"ORCADOPAGAR",,Pad(STR0051,10,"."),"@E 9,999,999,999.99",16,,) //"Orcado"
TRCell():New( oTotalMes,"ORCADOSALDOS",,Pad(STR0051,10,"."),,40,,) //"Orcado"
oTotalMes:Cell("SALDOS"):SetCellBreak(.T.)
oTotalMes:Cell("REALIZARSALDOS"):SetCellBreak(.T.)
oTotalMes:Cell("REALIZADOSALDOS"):SetCellBreak(.T.)
oTotalMes:Cell("TOTALSALDOS"):SetCellBreak(.T.)
oTotalMes:Cell("ORCADOSALDOS"):SetCellBreak(.T.)
oTotalMes:SetLineStyle()
oTotalMes:SetNoFilter("cArqTmp")

oCompara := TRSection():New( oReport, STR0053, {"cArqTmp"}, ) //"Comparativo"
TRCell():New( oCompara,"RECEBER",,STR0011,,28,, {|| "" } ) //"Receber"
TRCell():New( oCompara,"PAGAR",,STR0012,,21,, {|| "" } ) //"Pagar"
TRCell():New( oCompara,"REALIZADORECEBER",,Pad(STR0022,10,"."),,25,,) //"Realizado"
TRCell():New( oCompara,"REALIZADOPAGAR",,Pad(STR0022,10,"."),,25,,) //"Realizado"
TRCell():New( oCompara,"TOTALRECEBER",,Pad(STR0023,10,"."),,25,,) //"Total"
TRCell():New( oCompara,"TOTALPAGAR",,Pad(STR0023,10,"."),,25,,) //"Total"
oCompara:Cell("PAGAR"):SetCellBreak(.T.)
oCompara:Cell("REALIZADOPAGAR"):SetCellBreak(.T.)
oCompara:Cell("TOTALPAGAR"):SetCellBreak(.T.)
oCompara:SetLineStyle()
oCompara:SetNoFilter("cArqTmp")

//Gestão Corporativa - Início
oFilial := TRSection():New(oReport,"",{"SE1"})
TRCell():New(oFilial,"Filial",,,,TamSx3("E1_FILIAL")[1] + Len(STR0056)) //"Filial : "
oFilial:SetHeaderSection(.F.)

oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0057,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0058,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0059,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0060,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

oReport:SetUseGC(.F.)
//Gestão Corporativa - Fim

Return oReport

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario.

@sample		...{|oReport| ReportPrint(oReport)}...
@return		oReport, objeto do TReport
@author 	Daniel Batori
@since		10/07/2006
@version	MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

Static Function ReportPrint(oReport)
Local oSection1		:= oReport:Section(1)
Local oTotalMes		:= oReport:Section(2)
Local oCompara		:= oReport:Section(3)
Local aDados[10]
Local aTotMes[12]
Local aCompara[4]
Local cTexto,cTitulo

LOCAL aNiveis		:= {}
LOCAL aQuebras		:= {}
LOCAL nLaco			:= 0
LOCAL nByte			:= 0
LOCAL cMapa			:= ""
LOCAL nLimite		:= 0
Local nOrcAcm		:= 0
Local nLaco2
Local aOacumu
Local aTotais 		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local cArqTmp 		:= ""
Local nQuebras
Local dOldDtBase	:= dDataBase
Local cFilt			:=""

//Gestão Corporativa - Início
Local aAreaSE1 := SE1->(GetArea())
Local aAreaSM0 := SM0->(GetArea())
Local aArea := GetArea()
Local lGestao   := Iif( lFWCodFil, FWSizeFilial() > 2, .F. )
Local lSE1Excl  := Iif( lGestao, FWModeAccess("SE1",1) == "E", FWModeAccess("SE1",3) == "E")
Local cSE1Fil  := FWModeAccess("SE1",3)
Local cSE1UN   := FWModeAccess("SE1",2)
Local cSE1Emp  := FWModeAccess("SE1",1)
Local nX 		:= 1
Local nCont     := 1
Local oSecFil	:= oReport:Section("SECFIL")
Local nRegSM0	:= SM0->(Recno())
Local aSelFil := {}
Local cUN	  := ""
Local cEmp	  := ""
Local cUNold := ""
Local cEmpOld := ""
Local cFilialAnt := cFilAnt
Local lPrtFil := .T.
Local oFilial		:= oReport:Section(4)
//Gestão Corporativa - Fim

Private nDecs		:= MsDecimais(mv_par06)

oSection1:Cell("ED_CODIGO"):SetBlock( { || aDados[COD_NATUREZA] })
oSection1:Cell("ED_DESCRIC"):SetBlock( { || aDados[NATUREZA] })
oSection1:Cell("AREALIZAR"):SetBlock( { || aDados[AREALIZAR] })
oSection1:Cell("REALIZADO"):SetBlock( { || aDados[REALIZADO] })
oSection1:Cell("ORCADO"):SetBlock( { || aDados[ORCADO] })
oSection1:Cell("PERC"):SetBlock( { || aDados[PERC] })
oSection1:Cell("AREALIZARAC"):SetBlock( { || aDados[AREALIZARAC] })
oSection1:Cell("REALIZADOAC"):SetBlock( { || aDados[REALIZADOAC] })
oSection1:Cell("ORCADOAC"):SetBlock( { || aDados[ORCADOAC] })
oSection1:Cell("PERCAC"):SetBlock( { || aDados[PERCAC] })

oTotalMes:Cell("REALIZARRECEBER"):SetBlock( { || aTotMes[REALIZARRECEBER] })
oTotalMes:Cell("REALIZARPAGAR"):SetBlock( { || aTotMes[REALIZARPAGAR] })
oTotalMes:Cell("REALIZARSALDOS"):SetBlock( { || aTotMes[REALIZARSALDOS] })
oTotalMes:Cell("REALIZADORECEBER"):SetBlock( { || aTotMes[REALIZADORECEBER] })
oTotalMes:Cell("REALIZADOPAGAR"):SetBlock( { || aTotMes[REALIZADOPAGAR] })
oTotalMes:Cell("REALIZADOSALDOS"):SetBlock( { || aTotMes[REALIZADOSALDOS] })
oTotalMes:Cell("TOTALRECEBER"):SetBlock( { || aTotMes[TOTALRECEBER] })
oTotalMes:Cell("TOTALPAGAR"):SetBlock( { || aTotMes[TOTALPAGAR] })
oTotalMes:Cell("TOTALSALDOS"):SetBlock( { || aTotMes[TOTALSALDOS] })
oTotalMes:Cell("ORCADORECEBER"):SetBlock( { || aTotMes[ORCADORECEBER] })
oTotalMes:Cell("ORCADOPAGAR"):SetBlock( { || aTotMes[ORCADOPAGAR] })
oTotalMes:Cell("ORCADOSALDOS"):SetBlock( { || aTotMes[ORCADOSALDOS] })

oCompara:Cell("REALIZADORECEBER"):SetBlock( { || aCompara[REALIREC] })
oCompara:Cell("REALIZADOPAGAR"):SetBlock( { || aCompara[REALIPAG] })
oCompara:Cell("TOTALRECEBER"):SetBlock( { || aCompara[TOTREC] })
oCompara:Cell("TOTALPAGAR"):SetBlock( { || aCompara[TOTPAG] })

If mv_par07 != 1
	oSection1:Cell("AREALIZARAC"):Disable()
	oSection1:Cell("REALIZADOAC"):Disable()
	oSection1:Cell("ORCADOAC"):Disable()
	oSection1:Cell("PERCAC"):Disable()
EndIf

//Gestão Corporativa - Alterado para não permitir 0
cTexto	:= GetMv("MV_MOEDA"+IIf(mv_par06==0,"1",Str(mv_par06,1)))
cTitulo	:= STR0005 + (cTexto + " " + MesExtenso( mv_par08 ) + "-" + Str(Year(mv_par08),4,0)) //"Mapa Comparativo - Valores Orcados x Reais em "

oReport:SetTitle(cTitulo)

Do Case
	Case mv_par02 < mv_par01
		HELP (" ",1,"R720NAT")
		Return
	Case mv_par04 < mv_par03
		HELP (" ",1,"R720NAT")
		Return
	Case mv_par01 == mv_par03
		HELP (" ",1,"R720NAT")
		Return
	Case mv_par01 > mv_par03 .and. (mv_par01 <= mv_par04 .or. mv_par02 <= mv_par03)
		HELP (" ",1,"R720NAT")
		Return
	Case mv_par01 < mv_par03 .and. (mv_par01 >= mv_par04 .or. mv_par02 >= mv_par03)
		HELP (" ",1,"R720NAT")
		Return
EndCase

dDataBase := mv_par11 // Altera data base conforme parametro

//Gestão Corporativa - Início

nRegSM0 := SM0->(Recno())

If (lSE1Excl .and. mv_par12 == 1) 	
		aSelFil := AdmGetFil(.F.,.F.,"SE1")	
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
	oReport:SetTitle(cTitulo + " (" + STR0061 +  ")")	//"Filiais selecionadas para o relatorio"
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
	cFilAnt := aSelFil[nCont]
	cUN  := FWUnitBusiness()
	cEmp := FWCodEmp()
	cUNold := cUN
	cEmpOld := cEmp
EndIf

// Esta matriz informa em que posi‡”es ser„o feitas as quebras.
// 1-Byte inicial da quebra, 2-Quantidade de caracteres.
aNiveis  := {}

// Esta matriz armazena as chaves de quebra e os totalizadores parciais.
// 1-Chave, 2-A Realizar, 3-Realizado e 4-Or‡ado
// 5-A Realizar Acum. 6-Realizado Acumulado e 7-Orcado acumulado
aQuebras := {}

// Le a formatação do código das naturezas
cMascNat := GetMV("MV_MASCNAT")
cMapa    := "123456789"

If Empty(cMascNat)
	cMascNat := "19"
	HELP (,,"FR720NAT")
EndIf

For nLaco := 1 to len( cMascNat )
	nByte := Val( Substr( cMascNat,nLaco,1 ) )
	If nByte > 0
		AAdd( aNiveis  , { Val(Left(cMapa,1)) , nByte} )
		AAdd( aQuebras , { "", 0, 0, 0 ,0 ,0 ,0} )
		cMapa := Subst(cMapa,nByte+1,Len(cMapa)-nByte)
	Endif
EndFor

nLimite := If(Len(aNiveis) > 1, Len(aNiveis)-1, 1)

For nCont := 1 To Len(aSelFil) Step 1

	If aSelFil[nCont] <> cFilAnt .And. mv_par12 == 1

		cFilAnt := aSelFil[nCont]
		cUN  := FWUnitBusiness()
		cEmp := FWCodEmp()
		If cSE1Emp == "E" .And. cSE1UN == "E" .And. cSE1Fil == "C" .And. mv_par12 == 1									
			If cUN == cUnOld 
				Loop
			EndIf
		EndIf

		If cSE1Emp == "E" .And. cSE1UN == "C" .And. cSE1Fil == "C" .And. mv_par12 == 1									
			If cEmp == cEmpOld
				Loop 
			EndIf
		EndIf

		If cSE1Emp == "C" .And. cSE1UN == "C" .And. cSE1Fil == "C" .And. mv_par12 == 1			
			Loop
		EndIf
		
		aOacumu	:= {}
		aTotais := {0,0,0,0,0,0,0,0,0,0,0,0}
		cArqTmp := ""
		nQuebras	:= 0
		dOldDtBase	:= dDataBase
		cFilt		:= ""

		cUNold := cUN
		cEmpOld := cEmp

		SE1->(dbSeek(xFilial("SE1")))
		SE2->(dbSeek(xFilial("SE2")))

		If SE1->(EOF()) .And. SE2->(EOF())
			Loop
		Else
			lPrtFil := .T.
		EndIf
	EndIf

	//Gestão Corporativa - Fim

	Processa( { || U_Fin720Cria(@cArqTmp,,,,,,,.T.,oSection1:GetAdvplExp("SED"))}, "Criando arquivo temporário de trabalho" )

	// Imprime o relat¢rio a partir do arquivo tempor rio
	dbSelectArea("cArqTmp")

	dbGoTop()

	oSection1:Init()
	aFill(aDados,nil)

	//Gestão Corporativa - Início
	If lPrtFil .And. !cArqTmp->(Eof())
		If mv_par12 == 1
			oReport:SkipLine()
			oFilial:Init()
			oFilial:Cell("Filial"):SetBlock({|| STR0056 + xFilial("SE1")}) //"Filial : "
			oFilial:PrintLine()
			oFilial:Finish()
			oReport:SkipLine()
		EndIf
		lPrtFil := .F.
	EndIf
	//Gestão Corporativa - Fim

	While !cArqTmp->( Eof() )

		//  Inicia a matriz acumuladora de quebras
		For nLaco := 1 to Len( aQuebras )
			aQuebras[nLaco,1] := Subst( cArqTmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )
		EndFor

		nOrcado := 0
		nOrcAcm := 0

		If SE7->(dbSeek(xFilial("SE7")+cArqTmp->NATUR+Str(Year(mv_par08),4)))
			nOrcado:=U_GetOrcado(month(mv_par08))
			//  Acumula orçados no Mes
			If ( cArqTmp-> Tipo == "R")
				aTotais[5] += nOrcado		// Acumula or‡ado no Mes (Receber)
			Else
				aTotais[6] += nOrcado		// Acumula or‡ado no Mes (Pagar)
			End
			//  Se calcula acumulados, Acumula orçados no Ano
			If mv_par07 == 1
				For nLaco2:=1 to month(mv_par08)
					nOrcAcm += U_GetOrcado(nLaco2)
				Next
				If ( cArqTmp-> Tipo == "R")
					aTotais[11] += nOrcAcm	// Acumula or‡ado no Ano (Receber)
				Else
					aTotais[12] += nOrcAcm	// Acumula or‡ado no Acno (Pagar)
				End
			Endif
		Endif

		aDados[COD_NATUREZA	] := Mascnat(cArqTmp->Natur)
		aDados[NATUREZA] := cArqTmp->DESCR
		aDados[AREALIZAR] := cArqTmp->aEntr+cArqTmp->aSaid
		aDados[REALIZADO] := cArqTmp->rEntr+cArqTmp->rSaid
		aDados[ORCADO] := nOrcado

	   If nOrcado # 0
		   If ( cArqTmp-> Tipo == "R" )
		   	aDados[PERC] := PadR(transform(((cArqTmp->aEntr+cArqTmp->rEntr) * 100 ) / nOrcado ,"@E 9999.99")+" %",10) + ;
		   							transform((cArqTmp->rEntr * 100 ) / nOrcado  ,"@E 9999.99") + " %"
		   Else
		   	aDados[PERC] := PadR(transform(((cArqTmp->aSaid+cArqTmp->rSaid) * 100 ) / nOrcado ,"@E 9999.99") + " %",10) + ;
		   							transform((cArqTmp->rSaid * 100 ) / nOrcado,"@E 9999.99") + " %"
			Endif
		Else
			//  Caso não exista or‡amento, calcula porporçao
			//  do Realizado para o Montante
		   If ( cArqTmp-> Tipo == "R" )
		   	aDados[PERC] := "B/(A+B) = "+ transform((cArqTmp->rEntr * 100 ) / (cArqTmp->aEntr+cArqTmp->rEntr),"@E 9999.99")+" %"
			Else
				aDados[PERC] := "B/(A+B) = "+ transform((cArqTmp->rSaid * 100 ) / (cArqTmp->aSaid+cArqTmp->rSaid),"@E 9999.99")+" %"
			Endif
	   Endif

		If mv_par07 == 1
			aDados[AREALIZARAC] := cArqTmp->AEACM+cArqTmp->ASACM
			aDados[REALIZADOAC] := cArqTmp->REACM+cArqTmp->RSACM
			aDados[ORCADOAC] := nOrcAcm

			If nOrcAcm # 0
				If ( cArqTmp-> Tipo == "R" )
				   	aDados[PERCAC] := PadR(transform(((cArqTmp->aEacm+cArqTmp->rEacm) * 100 ) / nOrcAcm ,"@E 9999.99")+" %",10) + ;
			   								transform((cArqTmp->rEacm * 100 ) / nOrcAcm  ,"@E 9999.99") + " %"
				Else
				   	aDados[PERCAC] := PadR(transform(((cArqTmp->aSacm+cArqTmp->rSacm) * 100 ) / nOrcAcm ,"@E 9999.99") + " %",10) + ;
			   								transform((cArqTmp->rSacm * 100 ) / nOrcAcm,"@E 9999.99") + " %"
				Endif
			Else
				//  Caso não exista or‡amento, calcula porporçao
				//  do Realizado para o Montante
			   If ( cArqTmp-> Tipo == "R" )
			   	aDados[PERCAC] := "E/(D+E) = "+ transform((cArqTmp->rEacm * 100 ) / (cArqTmp->aEacm+cArqTmp->rEacm),"@E 9999.99")+" %"
				Else
					aDados[PERCAC] := "E/(D+E) = "+ transform((cArqTmp->rSacm * 100 ) / (cArqTmp->aSacm+cArqTmp->rSacm),"@E 9999.99")+" %"
				Endif
		   Endif
		Endif

		oSection1:PrintLine()
		aFill(aDados,nil)

		If ( cArqTmp-> Tipo == "R" )
			*** Atualiza Totais RECEBER
			aTotais[1]  += cArqTmp->aEntr+cArqTmp->aSaid	// A Realizar
			aTotais[3]  += cArqTmp->rEntr+cArqTmp->rSaid	// Realizado
			aTotais[7]  += cArqTmp->aEacm+cArqTmp->aSacm	// A Realizar Acumulado
			aTotais[9]  += cArqTmp->rEacm+cArqTmp->rSacm	// Realizado Acumulado
		Else
			*** Atualiza Totais PAGAR
			aTotais[2]  += cArqTmp->aEntr+cArqTmp->aSaid	// A Realizar
			aTotais[4]  += cArqTmp->rEntr+cArqTmp->rSaid	// Realizado
			aTotais[8]  += cArqTmp->aEacm+cArqTmp->aSacm	// A Realizar Acumulado
			aTotais[10] += cArqTmp->rEacm+cArqTmp->rSacm	// Realizado Acumulado
		End

		//  Acumula os parciais
		For nLaco := 1 to Len(aQuebras)
			****** Parciais no Mes
			aQuebras[nLaco,2] += cArqTmp->aEntr+cArqTmp->aSaid
			aQuebras[nLaco,3] += cArqTmp->rEntr+cArqTmp->rSaid
			aQuebras[nLaco,4] += nOrcado
			****** Parciais Acumulados
			If mv_par07 == 1
				aQuebras[nLaco,5] += cArqTmp->AEACM+cArqTmp->ASACM
				aQuebras[nLaco,6] += cArqTmp->REACM+cArqTmp->RSACM
				aQuebras[nLaco,7] += nOrcAcm
			Endif
		EndFor

		dbSelectArea("cArqTmp")
		dbSkip()

		//  Verifica se houve quebra em algum nivel
		lQuebra := .F.

		For nLaco := 1 to nLimite

			If aQuebras[nLaco,1] # Subst( cArqTmp->NATUR, aNiveis[nLaco,1], aNiveis[nLaco,2] )
				*** Inicia as quebras de baixo para cima at‚ o ponto da quebra

				For nQuebras := nLimite to nLaco Step -1

					If aQuebras[nQuebras,2] == 0 .and. aQuebras[nQuebras,3] == 0 .and. ;
							aQuebras[nQuebras,4] == 0 .and. aQuebras[nQuebras,5] == 0 .and. ;
							aQuebras[nQuebras,6] == 0 .and. aQuebras[nQuebras,7] == 0
						Loop
					Endif

					oReport:SkipLine()
					aDados[NATUREZA] := STR0009+ aQuebras[nQuebras,1]  //"Total - "
					aDados[AREALIZAR] := aQuebras[nQuebras,2]
					aDados[REALIZADO] := aQuebras[nQuebras,3]
					aDados[ORCADO] := aQuebras[nQuebras,4]

					If aQuebras[nQuebras,4] # 0
						aDados[PERC] := PadR(transform(((aQuebras[nQuebras,2] + aQuebras[nQuebras,3]) * 100) / aQuebras[nQuebras,4] ,"@E 9999.99") + " %",10) + ;
												transform(( aQuebras[nQuebras,3] * 100) / aQuebras[nQuebras,4] ,"@E 9999.99")+" %"
					Else
						//  Caso não exista or‡amento, calcula porporçao
						//  do Realizado para o Montante
						aDados[PERC] := "B/(A+B) = "+transform(( (aQuebras[nQuebras][2]+aQuebras[nQuebras,3]) * 100) / aQuebras[nQuebras,3],"@E 9999.99")+" %"
					Endif

					//  Caso considera acumulados, imprime as quebras
					//  Acumuladas...

					If mv_par07 == 1
						aDados[AREALIZARAC] := aQuebras[nQuebras,5]
						aDados[REALIZADOAC] := aQuebras[nQuebras,6]
						aDados[ORCADOAC] := aQuebras[nQuebras,7]
						If aQuebras[nQuebras,7] # 0
							aDados[PERCAC] := PadR(Transform(((aQuebras[nQuebras,5]+aQuebras[nQuebras][6] ) * 100) / aQuebras[nQuebras,7] ,"@E 9999.99")+" %",10) + ;
														transform(((aQuebras[nQuebras,6] ) * 100) / aQuebras[nQuebras,7] ,"@E 9999.99")+" %"
						Else
							//  Caso não exista orçamento, calcula porporçao
							//  do Realizado para o Montante
							aDados[PERCAC] := "E/(D+E)"+transform(((aQuebras[nQuebras,5] +aQuebras[nQuebras][6])* 100) / (aQuebras[nQuebras,6] ) ,"@E 9999.99") + " %"
						Endif
					Endif
					//  Zera as quebras do nivel.
					aQuebras[nQuebras,2] := 0
					aQuebras[nQuebras,3] := 0
					aQuebras[nQuebras,4] := 0
					aQuebras[nQuebras,5] := 0
					aQuebras[nQuebras,6] := 0
					aQuebras[nQuebras,7] := 0

					oSection1:PrintLine()
					aFill(aDados,nil)

				EndFor

				oReport:SkipLine()
			Endif
		EndFor
	End

	oSection1:Finish()
	dbGoTop()

	oTotalMes:Init()
	oCompara:Init()
	aFill(aTotMes,nil)
	aFill(aCompara,nil)

	//  Impress„o dos Totalizadores

	oReport:PrintText( PadR(STR0010,132,"-")  )  //"[ TOTAIS NO MES ]"

	aATotal := DevCred( aTotais[1], aTotais[2] )

	aTotMes[REALIZARRECEBER] := aTotais[1]
	aTotMes[REALIZARPAGAR] := aTotais[2]
	aTotMes[REALIZARSALDOS] := Transform( aATotal[1], "@E 9,999,999,999.99" ) + aATotal[2]

	aRTotal := DevCred( aTotais[3], aTotais[4] )

	aTotMes[REALIZADORECEBER] := aTotais[3]
	aTotMes[REALIZADOPAGAR] := aTotais[4]
	aTotMes[REALIZADOSALDOS] := Transform( aRTotal[1], "@E 9,999,999,999.99" )  + aRTotal[2]

	nTotReceb := aTotais[1] + aTotais[3]
	nTotPagar := aTotais[2] + aTotais[4]

	aTotSaldo := DevCred( nTotReceb, nTotPagar )

	aTotMes[TOTALRECEBER] := nTotReceb
	aTotMes[TOTALPAGAR] := nTotPagar
	aTotMes[TOTALSALDOS] := Transform( aTotSaldo[1],"@E 9,999,999,999.99") + aTotSaldo[2]

	aSdoOrc := DevCred( aTotais[5], aTotais[6] )

	aTotMes[ORCADORECEBER] := aTotais[5]
	aTotMes[ORCADOPAGAR] := aTotais[6]
	aTotMes[ORCADOSALDOS] := Transform( aSdoOrc[1],"@E 9,999,999,999.99") + aSdoOrc[2]

	oTotalMes:PrintLine()
	aFill(aTotMes,nil)

	If ( aTotais[5] - aTotais[6] > 0 )

		oReport:PrintText( PadR(STR0021,132,"-")  )  // "[ COMPARATIVO - ORCADO / REAIS ]"
		nA := aTotais[5] - aTotais[3]
		nB := ( aTotais[3] / aTotais[5] ) * 100
		nC := aTotais[5] - nTotReceb
		nD := ( nTotReceb / aTotais[5] ) * 100
		nE := aTotais[4] - aTotais[6]
		nF := ( aTotais[4] / aTotais[6] ) * 100
		nG := nTotPagar - aTotais[6]
		nH := ( nTotPagar / aTotais[6] ) * 100
		aCompara[REALIREC] := Transform( nA, Tm(nA,16,2) ) + " " + Transform( nB, Tm(nB,7,2) ) + "%"
		aCompara[REALIPAG] := Transform( nE, Tm(nE,16,2) ) + " " + Transform( nF, Tm(nF,7,2) ) + "%"
		aCompara[TOTREC] := Transform( nC, Tm(nC,16,2) ) + " " + Transform( nD, Tm(nD,7,2) ) + "%"
		aCompara[TOTPAG] := Transform( nG, Tm(nG,16,2) ) + " " + Transform( nH, Tm(nH,7,2) ) + "%"
		oCompara:PrintLine()
		aFill(aCompara,nil)
	End

	//  Caso considera acumulados, imprime os totalizadores acumulados.
	If mv_par07 == 1

		oReport:PrintText( PadR(STR0028,132,"-")  )  //"[ TOTAIS ACUMULADOS ]"
		oReport:SkipLine()

		aAAcumu := DevCred( aTotais[7], aTotais[8] )

		aTotMes[REALIZARRECEBER] := aTotais[7]
		aTotMes[REALIZARPAGAR] := aTotais[8]
		aTotMes[REALIZARSALDOS] := Transform( aAAcumu[1], "@E 9,999,999,999.99" )  + aAAcumu[2]

		aRAcumu := DevCred( aTotais[9], aTotais[10] )

		aTotMes[REALIZADORECEBER] := aTotais[9]
		aTotMes[REALIZADOPAGAR] := aTotais[10]
		aTotMes[REALIZADOSALDOS] := Transform( aRAcumu[1], "@E 9,999,999,999.99" )  + aRAcumu[2]

		nACMReceb := aTotais[7] + aTotais[9]
		nACMPagar := aTotais[8] + aTotais[10]

		aACMSaldo := DevCred( nACMReceb, nACMPagar )

		aTotMes[TOTALRECEBER] := nACMReceb
		aTotMes[TOTALPAGAR] := nACMPagar
		aTotMes[TOTALSALDOS] := Transform( aACMSaldo[1],"@E 9,999,999,999.99") + aACMSaldo[2]

		aOAcumu := DevCred( aTotais[11], aTotais[12] )

		aTotMes[ORCADORECEBER] := aTotais[11]
		aTotMes[ORCADOPAGAR] := aTotais[12]
		aTotMes[ORCADOSALDOS] := Transform( aOAcumu[1], "@E 9,999,999,999.99" ) + aOAcumu[2]

		oTotalMes:PrintLine()
		aFill(aDados,nil)

		oReport:PrintText( PadR("",132,"-")  )

	Endif

	oCompara:Finish()
	oTotalMes:Finish()

	// Apaga arquivos tempor rios
	dbSelectarea("cArqTmp")
	cArqTmp->( dbCloseArea() )
	Ferase(cArqTmp+GetDBExtension())
	Ferase(cArqTmp+OrdBagExt())

Next

dbSelectArea("SE1")
dDataBase := dOldDtBase // Restaura Data base
cFilAnt := cFilialAnt //Gestão Corporativa
RestArea(aAreaSE1)
RestArea(aArea)

Return

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} FR720ChecF
Filtra o arquivo A Receber para analisar o "A Realizar"

@sample		cQuery +=   U_FR720ChecF()
@return		cFiltro, Filtro para ser aplicado na tabela SE1
@author 	Daniel Batori
@since		04/09/1994
@version	MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

User Function FR720ChecF()
Local cFiltro	:= 'E1_FILIAL="'+xFilial("SE1")+'" .AND. '
Local cDtAcum	:= dTos( ctod("01/01/" + str( year( MV_PAR08 ), 4 ), "ddmmyy" ) )
Local cDtRefIni	:= dTos( FirstDay( MV_PAR08 ) )
Local cDtRefFim	:= dTos( LastDay(  MV_PAR08 ) )

Local cDbMs

cDbMs	 := UPPER(TcGetDb())

cFiltro := ""
If mv_par07 == 1
	// Se calcula acumulado, pega emissoes ou vencimentos desde 01/01/ano_atual
	If mv_par05 == 2 // Regime Competencia
		cFiltro += " AND SE1.E1_EMISSAO >= '" + cDtAcum + "'"
	Else
		cFiltro += " AND SE1.E1_VENCREA >= '" + cDtAcum + "'"
	EndIf
Else
	// Sen„o, pega emissoes ou vencimentos apenas no mˆs
	If mv_par05 == 2 // Regime Competencia
		cFiltro += " AND SE1.E1_EMISSAO >= '" + cDtRefIni + "'"
	Else
		cFiltro += " AND SE1.E1_VENCREA >= '" + cDtRefIni + "'"
	EndIf
Endif
If mv_par05 == 2
	cFiltro += " AND SE1.E1_EMISSAO <= '" + cDtRefFim + "'"
Else
	cFiltro += " AND SE1.E1_VENCREA <= '" + cDtRefFim + "'"
EndIf
cFiltro += " AND SE1.E1_SALDO > 0 "

//CLAUSULA WHERE
cFiltro += " WHERE SED.ED_FILIAL = '"+xFilial("SED")+"'"
cFiltro +=   " AND SED.ED_CODIGO between '"+ mv_par01 + "' AND '" + mv_par02 + "'"
If cDbMs == "POSTGRES"
	cFiltro += "   AND SED.ED_CODIGO = SE1.E1_NATUREZ "
ElseIf !(cDbMs $ "DB2|MYSQL|MSSQL|MSSQL7|MSSQL5|INFORMIX|ORACLE")
	cFiltro += "   AND SED.ED_CODIGO *= SE1.E1_NATUREZ "
Endif
cFiltro += " AND SED.D_E_L_E_T_ <> '*'"
//CLAUSULA WHERE

Return cFiltro

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} FR721ChecF
Filtra o arquivo A Receber para analisar o "A Realizar"

@sample		cQuery +=   U_FR721ChecF()
@return		cFiltro, Filtro para ser aplicado na tabela SE2
@author 	Daniel Batori
@since		04/09/1994
@version	MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

User Function FR721ChecF()
Local cFiltro	:= 'E2_FILIAL="'+xFilial("SE2")+'" .And. '
Local cDtAcum	:= dTos( ctod( "01/01/" + str( year( mv_par08 ), 4 ), "ddmmyy" ) )
Local cDtRefIni	:= dTos( FirstDay( mv_par08 ) )
Local cDtRefFim	:= dTos( LastDay( mv_par08 ) )

Local cDbMs

	cDbMs	 := UPPER(TcGetDb())

	cFiltro := ""
	If mv_par07 == 1
		// Se calcula acumulado, pega vencimentos desde 01/01/ano_atual
		If mv_par05 == 2 // Regime Competencia
			cFiltro += " AND SE2.E2_EMIS1 >= '"   + cDtAcum + "'"
		Else
			cFiltro += " AND SE2.E2_VENCREA >= '" + cDtAcum + "'"
		EndIf
	Else
		// Sen„o, pega vencimentos apenas no mˆs
		If mv_par05 == 2 // Regime Competencia
			cFiltro += " AND SE2.E2_EMIS1 >= '"   + cDtRefIni + "'"
		Else
			cFiltro += " AND SE2.E2_VENCREA >= '" + cDtRefIni + "'"
		EndIf
	Endif
	If mv_par05 == 2 // Regime Competencia
		cFiltro += " AND SE2.E2_EMIS1 <= '"   + cDtRefFim + "'"
	Else
		cFiltro += " AND SE2.E2_VENCREA <= '" + cDtRefFim + "'"
	EndIf
	cFiltro += " AND SE2.E2_SALDO > 0 "
	
	//CLAUSULA WHERE
	cFiltro += " WHERE SED.ED_FILIAL = '"+xFilial("SED")+"'"
	cFiltro +=   " AND SED.ED_CODIGO between '"+ mv_par03 + "' AND '" + mv_par04 + "'"
	If cDbMs == "POSTGRES"
		cFiltro += "   AND SED.ED_CODIGO = SE2.E2_NATUREZ "
	ElseIf !(cDbMs $ "DB2|MYSQL|POSTGRES|MSSQL|MSSQL7|MSSQL5|INFORMIX|ORACLE")
		cFiltro += "   AND SED.ED_CODIGO *= SE2.E2_NATUREZ "
	Endif
	cFiltro += " AND SED.D_E_L_E_T_ <> '*'"
	//CLAUSULA WHERE


Return cFiltro

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} FR722ChecF
Filtra o arquivo de Movimenta‡„o Banc ria para analisar o Realizado.

@sample		IndRegua( "SE5", cIndex3, cChave, , U_FR722ChecF(), STR0008 ) 
@return		cFiltro, Filtro para ser aplicado na tabela SE5
@author 	Vinicius Barreira
@since		04/09/1994
@version	MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

User Function FR722ChecF()

Local cFiltro	:= ""

If mv_par07 == 1
	**** Se calcula acumulado, considera desde o in¡cio do ano
	cInicio := dTos( ctod("01/01/"+str(year(mv_par08),4),"ddmmyy") )
Else
	**** Sen„o, considera in¡cio do mes
	cInicio := dTos( FirstDay(mv_par08) )
Endif

cFim    := dTos( LastDay(mv_par08) )
cFiltro += 'SE5->E5_NATUREZ >= "' + IIf(mv_par01<mv_par03,mv_par01,mv_par03)  + '" .AND. '
cFiltro += 'SE5->E5_NATUREZ <= "' + IIf(mv_par02>mv_par04,mv_par02,mv_par04)  + '" .AND. '

If mv_par05 == 1 // Regime de caixa
	cFiltro += 'dTos(SE5->E5_DATA) >= "' + cInicio  + '" .AND. '
	cFiltro += 'dtos(SE5->E5_DATA) <= "' + cFim + '"'
Else
	cFiltro += 'dTos(SE5->E5_DTDIGIT) >= "' + cInicio  + '" .AND. '
	cFiltro += 'dtos(SE5->E5_DTDIGIT) <= "' + cFim + '"'
EndIf

Return cFiltro

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} FR722ChecF
Subtrai valor1 de valor2. Devolve um array com um valor positivo outro elemento com devedor ou credor

@sample		aTotal := DevCred( aTotais[1], aTotais[2] )
@param		nValor1, Valor a Receber
@param		nValor2, Valor a Pagar
@return		aRet, Array de retorno, Posição 1 Calculo, Posição 2 String
@author 	Vinicius Barreira
@since		27/03/1995
@version	MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

Static Function DevCred( nValor1, nValor2 )

Local aRet		:= {}
Local cDevCred	:= ""
Local nRTotal	:= nValor1 - nValor2

Do Case
	Case ( nRTotal < 0 )
		nRTotal := nRTotal * (-1)
		cDevCred := STR0024  //" (  Devedor   )"
	Case ( nRTotal > 0 )
		cDevCred := STR0025  //" (   Credor   )"
	OtherWise
		cDevCred := " "
EndCase

AAdd( aRet, nRTotal	)
AAdd( aRet, cDevCred)

Return( aRet )

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} GetOrcado
Retorna o orcamento registrado para a Natureza no Mes.

@sample		nOrcado := U_GetOrcado(month(mv_par08))
@param		nMes, Numero do Mês a obter o Orçamento 
@return		nValOrcado, Valor Orçado do mês
@author 	Julio Wittwer
@since		19/03/1999
@version	MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

User Function GetOrcado(nMes)

Local nValOrcado 	:= 0
Local dData         := mv_par08
Local lRestPerg		:= .F.
    
    If FwIsInCallStack("FINC730")
		SaveInter()
		Pergunte("FIN730",.F.)
		lRestPerg := .T.
        dData   := mv_par07
    EndIf

Do Case
	Case nMes == 1
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALJAN1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 2
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALFEV1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 3
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALMAR1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 4
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALABR1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 5
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALMAI1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 6
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALJUN1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 7
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALJUL1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 8
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALAGO1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 9
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALSET1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 10
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALOUT1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 11
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALNOV1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
	Case nMes == 12
		nValOrcado := Round(NoRound(xMoeda(SE7->E7_VALDEZ1,SE7->E7_MOEDA,mv_par06,dData,nDecs+1),nDecs+1),nDecs+1)
EndCase

	If lRestPerg
		RestInter()
	EndIf

Return nValOrcado

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Fin720Cria
Retorna o orcamento registrado para a Natureza no Mes.

@sample		...{ || U_Fin720Cria( @cArqTmp, @cIndex1, @cIndex2, @cIndex3, , , , .T., oSection1:GetAdvplExp("SED") ) }...
@param		cArqTmp, Nome do Arquivo temporario a ser criado
@param		cIndex1, Nome do indice temporario  Contas a Receber
@param		cIndex2, Nome do indice temporario  Contas a Pagar
@param		cIndex3, Nome do indice temporario  Movimento Bancario
@param		lRelato, Indica se e chamado via relatorio (Default .T.)
@param		aNivel, Array com nivels de quebra
@param		aQuebras, Array de Quebras baseado MV_MASCNAT
@param		lR4, logico para dizer se eh R4
@return		{ aTotais, aArrayQ, aArray }, Array com arrays de totais
@author 	Wagner Mobile Costa
@since		29/07/2002
@version	MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

User Function Fin720Cria(cArqTmp, cIndex1, cIndex2, cIndex3, lRelato, aNiveis, aQuebras, lR4,cFilt,aSelFil)

Local aTotais	:= {0,0,0,0,0,0,0,0,0,0,0,0}	// Vetor com 12 Totalizadores
Local nMoedaBco	:= 1, aArrayQ := {}
Local aArray 	:= { }, aTotal, aAcumu
Local cDbMs
Local nj := 0
Local ny := 0
Local aStruSED   := SED->(dbStruct())
Local nLaco
Local nQuebras
Local nLaco2
Local bProp
Local bWhile
Local nProp
Local lTemSev := .F.
Local nRecSed
Local aSaldoTit
Local lAchouEmp 	:= .T.
Local lAchouEst 	:= .F.
Local nTamEH 		:= TamSx3("EH_NUMERO")[1]
Local nTamEI 		:= TamSx3("EI_NUMERO")[1]+TamSx3("EI_REVISAO")[1]+TamSx3("EI_SEQ")[1]
Local cFiltro		:= " "

DEFAULT lRelato := .T.
DEFAULT lR4		 := .F.
Default cFilt	:=" "
Default aSelFil:= {}
Private cLisFil	 := ""

If lR4
	cFilterUser:=cFilt
Else
	cFilterUser:= Iif(Type("aReturn[7]") == "U"," ",aReturn[7])
EndIf

// Gera arquivo de Trabalho
aCampos:={ 	{"NATUR"  , "C" , Len(SED->ED_CODIGO),0},;	// Cod. da Natureza
			{"FILIAL" , "C" , IIf( lFWCodFil, FWGETTAMFILIAL, 2 ),0},;	// Codigo da Filial
			{"DESCR"  , "C" , 30,0},;	// Descricao da Natureza
			{"AENTR"  , "N" , 17,2},;	// A Realizar Entrada no Mes
			{"ASAID"  , "N" , 17,2},;	// A Realizar Saida no Mes
			{"RENTR"  , "N" , 17,2},;	// Realizado Entrada no Mes
			{"RSAID"  , "N" , 17,2},;	// Realizado Saida no Mes
			{"AEACM"  , "N" , 17,2},;	// A realizar Entrada ACuMulado
			{"ASACM"  , "N" , 17,2},;	// A realizar Saida   ACuMulado
			{"REACM"  , "N" , 17,2},;	// Realizado Entrada ACuMulado
			{"RSACM"  , "N" , 17,2},;	// Realizado Saida   ACuMulado
			{"TIPO"   , "C" , 01,0} }	// Tipo P ou R

If(__oFinr720 <> NIL)
	
	__oFinr720:Delete()
	__oFinr720 := NIL

EndIf

If Select("cArqTmp") > 0
	cArqTmp->(dbCloseArea())		  // Elimina arquivos de Trabalho
Endif

//Criando a tabela temporaria
__oFinr720 := FwTemporaryTable():New("cArqTmp")
//Setando as colunas
__oFinr720:SetFields(aCampos)
//Criando o indicie 
__oFinr720:AddIndex("1",{"NATUR"})
//Criando a Tabela Temporaria
__oFinr720:Create()

cDbMs	 := UPPER(TcGetDb())

// Query unindo SED, SE1 e SE2
cQuery := "SELECT "
For nj:= 1 to Len(aStruSED)
	cQuery += aStruSED[nj,1]+", "
Next
cQuery += "'R' CARTEIRA,"
cQuery += "SE1.E1_TIPO TIPO, SE1.E1_SALDO SALDO, SE1.E1_MOEDA MOEDA, SE1.E1_PREFIXO PREFIXO,"
cQuery += "SE1.E1_NUM NUM, SE1.E1_PARCELA PARCELA, SE1.E1_VENCREA VENCREA, SE1.E1_CLIENTE CLIFOR, "
cQuery += "SE1.E1_EMISSAO EMISSAO, SE1.E1_LOJA LOJA, SE1.R_E_C_N_O_ Recno "
cquery += " FROM "+RetSqlName("SED")+" SED "
If cDbMs $ "DB2|MYSQL|POSTGRES|MSSQL|MSSQL7|MSSQL5|INFORMIX|ORACLE"
	cQuery += " LEFT OUTER JOIN "+ RetSqlName("SE1") + " SE1 "
	cQuery += " ON ( SED.ED_CODIGO = SE1.E1_NATUREZ ) "
	If !Empty(aSelFil)
		cQuery += " AND SE1.E1_FILIAL IN("+SelectFil(aSelFil)+") "
	Else
		cQuery += " AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' "
	EndIf
	cQuery += " AND SE1.D_E_L_E_T_ = ' '"
Else
	cQuery += ", "+ RetSqlName("SE1") + " SE1 "
Endif
cQuery +=   U_FR720ChecF()
cQuery += " UNION ALL"
cQuery += " SELECT "
For ny:= 1 to Len(aStruSED)
	cQuery += aStruSED[ny,1]+", "
Next
cQuery += "'P' CARTEIRA,"
cQuery +=        "SE2.E2_TIPO TIPO, SE2.E2_SALDO SALDO, SE2.E2_MOEDA MOEDA, SE2.E2_PREFIXO PREFIXO,"
cQuery +=        "SE2.E2_NUM NUM, SE2.E2_PARCELA PARCELA, SE2.E2_VENCREA VENCREA, SE2.E2_FORNECE CLIFOR, "
cQuery +=        "SE2.E2_EMIS1 EMISSAO, SE2.E2_LOJA LOJA, SE2.R_E_C_N_O_ Recno "
cquery += " FROM "+RetSqlName("SED")+" SED "
If cDbMs $ "DB2|MYSQL|POSTGRES|MSSQL|MSSQL7|MSSQL5|INFORMIX|ORACLE"
   cQuery += " LEFT OUTER JOIN "+ RetSqlName("SE2") + " SE2 "
	cQuery += " ON ( SED.ED_CODIGO = SE2.E2_NATUREZ ) "
	If !Empty(aSelFil)
		cQuery += " AND SE2.E2_FILIAL IN("+SelectFil(aSelFil)+") "
	Else
		cQuery += " AND SE2.E2_FILIAL = '"+xFilial("SE2")+"' "
	EndIf
	cQuery += " AND SE2.D_E_L_E_T_ = ' '"
Else
	cQuery += ", "+ RetSqlName("SE2") + " SE2 "
Endif
cQuery +=  U_FR721ChecF()

If cDbMs == "INFORMIX" .OR. cDbMs == "ANYWHERE"
	cQuery += ' ORDER BY 1'
Else
	cQuery += ' ORDER BY ED_CODIGO'
EndIf

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB", "VENCREA", "D")
TcSetField("TRB", "EMISSAO", "D")

cNatureza := ' '
While TRB->(!Eof())
	
	If Empty( TRB->NUM )
		TRB->(dbSkip())
		Loop
	Endif
	
	dbSelectArea("TRB")
	If !Empty(cFilterUser).and.!(&cFilterUser)
		TRB->(dbSkip())
		Loop
	Endif

	dbSelectArea( "cArqTmp" )
	If ! cArqTmp->(MsSeek(TRB->ED_CODIGO))
		RecLock("cArqTmp",.T.)
		cArqTmp->NATUR := TRB->ED_CODIGO
		cArqTmp->FILIAL:= TRB->ED_FILIAL
		cArqTmp->DESCR := TRB->ED_DESCRIC
		cArqTmp->TIPO  := TRB->CARTEIRA
	Else
		RecLock("cArqTmp",.F.)
	EndIf

	If TRB->CARTEIRA == 'R'
		SE1->(MsGoto(TRB->Recno))
		
		//Se estiver utilizando multiplas naturezas, verifica o codigo da natureza
		//do arquivo de multiplas naturezas (SEV)
		If SE1->E1_MULTNAT == "1"
			If !PesqNatSev("SE1","E1", MV_PAR01, MV_PAR02)
				TRB->(DbSkip())
				Loop
			Endif
		Endif
	Else
		SE2->(MsGoto(TRB->Recno))
		
		//Se estiver utilizando multiplas naturezas, verifica o codigo da natureza
		//do arquivo de multiplas naturezas (SEV)
		If SE2->E2_MULTNAT == "1"
			If !PesqNatSev("SE2","E2", MV_PAR03, MV_PAR04)
				TRB->(DbSkip())
				Loop
			Endif
		Endif
	Endif

	If TRB->CARTEIRA == 'R'
		// Analiza as entradas daquela natureza A Realizar !!!
		// Titulos provisorios e IR ficam de fora
		If TRB->TIPO $ MVABATIM+"/"+MVRECANT+"/"+MV_CRNEG
			TRB->(dbSkip())
			Loop
		Endif

		If TRB->TIPO $ MVPROVIS .and. mv_par10 == 2
			TRB->(dbSkip())
			Loop
		Endif

		aSaldoTit := SdoTitNat(	TRB->PREFIXO	,;
									   TRB->NUM			,;
									  	TRB->PARCELA	,;
									  	TRB->TIPO		,;
									  	TRB->CLIFOR		,;
									  	TRB->LOJA  	,	,;
									 	"R"				,;
									  	"SE1"				,;
									  	MV_PAR06			,;
									  	.F.,,,"SE1")

		If mv_par05 == 2 // Regime Competencia
			lNoMes:= (TRB->EMISSAO >= FirstDay(mv_par08)) .and. ;
						(TRB->EMISSAO <= LastDay(mv_par08))
		Else
			lNoMes:= (TRB->VENCREA >= FirstDay(mv_par08)) .and. ;
						(TRB->VENCREA <= LastDay(mv_par08))
		EndIf

		For nLaco := 1 To Len( aSaldoTit )
			If ! cArqTmp->(MsSeek(aSaldoTit[nLaco][1]))
				RecLock("cArqTmp",.T.)
				cArqTmp->NATUR := aSaldoTit[nLaco][1]
				SED->(MsSeek(xFilial("SED")+cArqTmp->NATUR))
				cArqTmp->DESCR := SED->ED_DESCRIC
				cArqTmp->TIPO  := "R"
			Else
				RecLock("cArqTmp",.F.)
			Endif
			cArqTmp->aEacm += aSaldoTit[nLaco][2]	// Atualiza acumulado a realizar
			IF lNoMes
				cArqTmp->aEntr += aSaldoTit[nLaco][2]	// Atualiza a Realizar no mes
			Endif
		Next
	Else
		
		If Empty( TRB->NUM )
			TRB->(dbSkip())
			Loop
		Endif
		
		// Analiza as Saidas daquela natureza A Realizar !!!
		// Titulos provisorios ficam de fora
		If TRB->TIPO $ MVABATIM+"/"+MVPAGANT+"/"+MV_CPNEG
			TRB->(dbSkip())
			Loop
		Endif

		If TRB->TIPO $ MVPROVIS .and. mv_par10 == 2
			TRB->(dbSkip())
			Loop
		Endif
		
		// Se estiver utilizando multiplas naturezas, verifica o arquivo de multiplas
		// naturezas (SEV) e inclui diversos registros no temporario
		aSaldoTit := SdoTitNat(	TRB->PREFIXO	,;
									   TRB->NUM			,;
									  	TRB->PARCELA	,;
									  	TRB->TIPO		,;
									  	TRB->CLIFOR		,;
									  	TRB->LOJA  		,,;
									 	"P"				,;
									  	"SE2"				,;
									  	MV_PAR06			,;
									  	.F.,,, "SE2")

		If mv_par05 == 2 // Regime Competencia
			lNoMes:= (TRB->EMISSAO >= FirstDay(mv_par08)) .and. ;
						(TRB->EMISSAO <= LastDay(mv_par08))
		Else
			lNoMes:= (TRB->VENCREA >= FirstDay(mv_par08)) .and. ;
						(TRB->VENCREA <= LastDay(mv_par08))
		EndIf

		For nLaco := 1 To Len( aSaldoTit )
			If ! cArqTmp->(MsSeek(aSaldoTit[nLaco][1]))
				RecLock("cArqTmp",.T.)
				cArqTmp->NATUR := aSaldoTit[nLaco][1]
				SED->(MsSeek(xFilial("SED")+cArqTmp->NATUR))
				cArqTmp->DESCR := SED->ED_DESCRIC
				cArqTmp->TIPO  := "P"
			Else
				RecLock("cArqTmp",.F.)
			Endif
			cArqTmp->aSacm += aSaldoTit[nLaco][2]	// Atualiza acumulado a realizar
			IF lNoMes
				cArqTmp->aSaid += aSaldoTit[nLaco][2]	// Atualiza a Realizar no mes
			Endif
		Next
	Endif

	dbSelectArea("TRB")
	dbSkip()
Enddo

TRB->(dbCloseArea())

// Analisa Realizado no Mês em Epigrafe

// Seleciona o arquivo SE5 - Movimentação bancaria, para verificar
// o realizado.
dbSelectArea("SE5")
dbSetOrder(4) // Ordem por natureza
cFiltro	:= U_FR722ChecF()
nTregs:= SE5->(Reccount())
If lRelato .And. !lR4
	SetRegua(nTregs)
Else
	ProcRegua(nTregs)
Endif

dbGoTop()
DbSeek(xFilial("SE5"))

aTotais[1] := 0	// Total a Realizar no MEs (Receber)
aTotais[2] := 0	// Total a Realizar no Mes (Pagar)

aTotais[3] := 0	// Total Realizado no Mes (Receber)
aTotais[4] := 0	// Total Realizado no Mes (Pagar)

aTotais[5] := 0	// Total Or‡ado no Mes (Receber)
aTotais[6] := 0	// Total Or‡ado no Mes (Pagar)

aTotais[7] := 0	// Total a Realizar Acumulado (Receber)
aTotais[8] := 0	// Total a Realizar Acumulado (Pagar)

aTotais[9] := 0	// Total Realizado Acumulado (Receber)
aTotais[10] := 0	// Total Realizado Acumulado (Pagar)

aTotais[11] := 0	// Total Or‡ado Acumulado (Receber)
aTotais[12] := 0	// Total Or‡ado Acumulado (Pagar)

While SE5->(!Eof()) .and. SE5->E5_FILIAL==xFilial("SE5") 
	
	If &cFiltro
		lAchouEmp := .T.
		lAchouEst := .F.

		If lRelato .And. !lR4
			IncRegua()
		Else
			IncProc()
		Endif

		If cPaisLoc	# "BRA"
		SA6->(DbSetOrder(1))
		SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
		nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
		Endif

		// Verifica se existe estorno para esta baixa
		//
		// Verifico se os campos estão vazios para depois identificar se a origem do registro e então verifico se está estornado
		If Empty( SE5->( E5_PREFIXO + E5_NUMERO + E5_PARCELA + E5_TIPO + E5_CLIFOR + E5_LOJA + E5_SEQ ) )
			If AllTrim(SE5->E5_ORIGEM ) == "FINA100" .AND. SE5->E5_SITUACA $ "C|E|X"
				SE5->(DbSkip())
				Loop
			EndIf
		Else
			If TemBxCanc(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ))
				SE5->(DbSkip())
				Loop
			EndIf
		EndIf

		// Nao imprime os registros de emprestimos cancelados
		If SE5->E5_TIPODOC == "EP"
			aAreaSE5 := SE5->(GetArea())
			dbSelectArea("SEH")
			dbSetOrder(1)
			lAchouEmp := MsSeek(xFilial("SEH")+Substr(SE5->E5_DOCUMEN,1,nTamEH))
			RestArea(aAreaSE5)
			If !lAchouEmp
				SE5->(dbSkip())
				Loop
			EndIf
		EndIf

		// Nao imprime os registros de pagamento de emprestimos estornados
		If SE5->E5_TIPODOC == "PE"
			aAreaSE5 := SE5->(GetArea())
			dbSelectArea("SEI")
			dbSetOrder(1)
			If	MsSeek(xFilial("SEI")+"EMP"+Substr(SE5->E5_DOCUMEN,1,nTamEI))
				If SEI->EI_STATUS == "C"
					lAchouEst := .T.
				EndIf
			EndIf
			RestArea(aAreaSE5)
			If lAchouEst
				SE5->(dbSkip())
				Loop
			EndIf
		EndIf

		// Movimenta‡”es especiais ou canceladas n„o aparecem no relat¢rio
		IF SE5->E5_TIPODOC $ "DCüJRüMTüCM/D2/J2/M2/C2/TL/CP/BL" .or. SE5->E5_SITUACA $ "C/X/E"
			SE5->(dbSkip())
			Loop
		EndIF

		If SE5->E5_TIPODOC == "CH"
			
			IF FR720ChqCanc()
				SE5->(dbSkip())
				Loop		
			EndIf

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
			If !MovBcoBx(SE5->E5_MOTBX)
				SE5->(dbSkip())
				LOOP
			EndIf
		End

		If mv_par09 == 2
			If nMoedaBco <> mv_par06
				SE5->(DbSkip())
				Loop
			EndIf
		EndIf

		lNoMes :=.T.
		dVencto:=SE5->E5_DATA // Regime de Caixa

		lRet := .T.
		If mv_par05 == 2
			If !Empty(SE5->E5_NUMERO) // Regime de Competencia
				If SE5->E5_RECPAG == "R"
					If SE1->(dbSeek(xFilial("SE1")+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO))
						dVencto:=SE1->E1_EMIS1
						If SE1->E1_EMIS1 < if(mv_par07==2,FirstDay(dDataBase),ctod("01/01/"+str(year(dDataBase),4))) .OR. ;
							SE1->E1_EMIS1 > LastDay(dDatabase)
							lRet := .F.
						Endif
					Endif
				Else
					If SE2->(dbSeek(xFilial("SE2")+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR))
						dVencto:=SE2->E2_EMIS1
						If SE2->E2_EMIS1 < if(mv_par07==2,FirstDay(dDataBase),ctod("01/01/"+str(year(dDataBase),4))) .OR. ;
							SE2->E2_EMIS1 > LastDay(dDatabase)
							lRet := .F.
						Endif
					Endif
				Endif
			Else
				lRet := .F.
			Endif
		Endif

		// Checa se Movimento est  dentro do mes
		lNoMes:= (dVencto >= FirstDay(mv_par08)) .and. ;
					(dVencto <= LastDay(mv_par08))

		If lRet
			If SED->(dbSeek(xFilial("SED")+SE5->E5_NATUREZ)) .And.;
				((SE5->E5_NATUREZ >= mv_par01 .And. SE5->E5_NATUREZ <= mv_par02) .Or.;
				(SE5->E5_NATUREZ >= mv_par03 .And. SE5->E5_NATUREZ <= mv_par04))
				If !cArqTmp->(dbSeek(SE5->E5_NATUREZ))
					RecLock("cArqTmp",.T.)
					cArqTmp->NATUR := SE5->E5_NATUREZ
					cArqTmp->DESCR := SED->ED_DESCRIC
					cArqTmp->TIPO := IF(SED->ED_COND == "R","R","P")
				Endif

				RecLock("cArqTmp")
				// Atualiza Realizados no MES
				nValor := Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
				nValor *= If( SE5->E5_TIPODOC = "TE", -1,1)				
				lTemSEV := .F.

				SEV->(DBSetOrder(2))

				//Verifico se existe e processo rateio multiplas naturezas na baixa do titulo receber/pagar,
				// para ser considerado como total realizado
				If SEV->(MsSeek(xFilial("SEV")+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+"2"+E5_SEQ)))

					lTemSEV := .T.

					While	SEV->(!EoF()) .And.;
							xFilial("SEV")+SEV->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA+EV_IDENT+EV_SEQ) == ;
							SEV->EV_FILIAL + SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+"2"+E5_SEQ)

						// Processa regra de rateio por natureza de acordo com o valor da movimentacao (E5_VALOR)
						FR720ProcNat( nValor )
						SEV->(DbSkip())

					EndDo

				// Verifico se existe e processo o rateio multiplas naturezas na emissao do titulo receber/pagar,
				// que tiveram baixa (SE5), para ser considerado como total realizado
				ElseIf SEV->(MsSeek(xFilial("SEV")+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+"1"+E5_SEQ)))

					lTemSEV := .T.

					While	SEV->(!EoF()) .And.;
							xFilial("SEV")+SEV->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA+EV_IDENT+EV_SEQ) == ;
							SEV->EV_FILIAL + SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+"1"+E5_SEQ)

						// Processa regra de rateio por natureza de acordo com o valor da movimentacao (E5_VALOR)
						FR720ProcNat( nValor )
						SEV->(DbSkip())

					EndDo

				EndIf

				If !lTemSEV
					If lNoMes
						If cArqTmp->NATUR >= mv_par01 .and. cArqTmp->NATUR	<= mv_par02 .and. cArqTmp->TIPO == "R"
							IIF(SE5->E5_RECPAG == "R" .AND. AllTrim(SE5->E5_TIPO) $ "PA", cArqTmp->rEntr -= (nValor * 1),cArqTmp->rEntr += (nValor * 1))
						Else
							IIF(SE5->E5_RECPAG == "R" .AND. AllTrim(SE5->E5_TIPO) $ "PA", cArqTmp->rSaid -= (nValor * 1), cArqTmp->rSaid += (nValor * 1))
						EndIf
						// Atualiza Realizados Acumulados						

						If cPaisLoc = "BRA" .or. Empty(cArqTmp->Tipo)
							cArqTmp-> Tipo := SE5->E5_RECPAG
						EndIf
					EndIf

					If mv_par07 == 1
							If cArqTmp->NATUR >= mv_par01 .and. cArqTmp->NATUR	<= mv_par02 .and. cArqTmp->TIPO == "R" 
								IIF(SE5->E5_RECPAG == "R" .AND. AllTrim(SE5->E5_TIPO) $ "PA", cArqTmp->REACM -= (nValor * 1),cArqTmp->REACM += (nValor * 1))
							Else
								IIF(SE5->E5_RECPAG == "R" .AND. AllTrim(SE5->E5_TIPO) $ "PA", cArqTmp->RSACM -= (nValor * 1), cArqTmp->RSACM += (nValor * 1))
							Endif
					Endif
				EndIf

			Endif

		Endif
	EndIf	

	dbSelectArea("SE5")
	SE5->(dbSkip())

EndDo

If ! lRelato
	cArqTmp->( DbGoTop() )
	If aNiveis <> Nil
		nLimite := IIf(Len(aNiveis) > 1, Len(aNiveis)-1, 1)
	Endif
Endif

While ! lRelato .And. !cArqTmp->( Eof() )

	nOrcado := 0
	nOrcAcm := 0

	If SE7->(dbSeek(xFilial("SE7")+cArqTmp->NATUR+Str(Year(mv_par08),4)))
		nOrcado:=U_GetOrcado(month(mv_par08))
		//  Acumula or‡ados no Mes
		If ( cArqTmp-> Tipo == "R")
			aTotais[5] += nOrcado		// Acumula or‡ado no Mes (Receber)
		Else
			aTotais[6] += nOrcado		// Acumula or‡ado no Mes (Pagar)
		End
		// Se calcula acumulados, Acumula or‡ados no Ano
		If mv_par07 == 1
			For nLaco2:=1 to month(mv_par08)
				nOrcAcm += U_GetOrcado(nLaco2)
			Next
			If ( cArqTmp-> Tipo == "R")
				aTotais[11] += nOrcAcm	// Acumula or‡ado no Ano (Receber)
			Else
				aTotais[12] += nOrcAcm	// Acumula or‡ado no Acno (Pagar)
			End
		Endif
	Endif

	If ( cArqTmp-> Tipo == "R" )
		*** Atualiza Totais RECEBER
		aTotais[1]  += cArqTmp->aEntr+cArqTmp->aSaid	// A Realizar
		aTotais[3]  += cArqTmp->rEntr+cArqTmp->rSaid	// Realizado
		aTotais[7]  += cArqTmp->aEacm+cArqTmp->aSacm	// A Realizar Acumulado
		aTotais[9]  += cArqTmp->rEacm+cArqTmp->rSacm	// Realizado Acumulado
	Else
		*** Atualiza Totais PAGAR
		aTotais[2]  += cArqTmp->aEntr+cArqTmp->aSaid	// A Realizar
		aTotais[4]  += cArqTmp->rEntr+cArqTmp->rSaid	// Realizado
		aTotais[8]  += cArqTmp->aEacm+cArqTmp->aSacm	// A Realizar Acumulado
		aTotais[10] += cArqTmp->rEacm+cArqTmp->rSacm	// Realizado Acumulado
	End

	If aQuebras <> Nil
		//  Inicia a matriz acumuladora de quebras
		For nLaco := 1 to Len( aQuebras )
			aQuebras[nLaco,1] := Subst( cArqTmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )
		EndFor

		// Acumula os parciais
		For nLaco := 1 to Len(aQuebras)
			****** Parciais no Mes
			aQuebras[nLaco,2] += cArqTmp->aEntr+cArqTmp->aSaid
			aQuebras[nLaco,3] += cArqTmp->rEntr+cArqTmp->rSaid
			aQuebras[nLaco,4] += nOrcado
			****** Parciais Acumulados
			If mv_par07 == 1
				aQuebras[nLaco,5] += cArqTmp->AEACM+cArqTmp->ASACM
				aQuebras[nLaco,6] += cArqTmp->REACM+cArqTmp->RSACM
				aQuebras[nLaco,7] += nOrcAcm
			Endif
		EndFor

	Endif

	cArqTmp->(DbSkip())

	If aQuebras <> Nil
		//  Verifica se houve quebra em algum nivel
		lQuebra := .F.
		For nLaco := 1 to nLimite
			If aQuebras[nLaco,1] # Subst( cArqTmp->NATUR, aNiveis[nLaco,1], aNiveis[nLaco,2] )
				*** Inicia as quebras de baixo para cima at‚ o ponto da quebra
				For nQuebras := nLimite to nLaco Step -1
					If 	aQuebras[nQuebras,2] == 0 .and. aQuebras[nQuebras,3] == 0 .and. ;
						aQuebras[nQuebras,4] == 0 .and. aQuebras[nQuebras,5] == 0 .and. ;
						aQuebras[nQuebras,6] == 0 .and. aQuebras[nQuebras,7] == 0
						Loop
					Endif

					Aadd(aArrayQ, Aclone(aQuebras[nQuebras]))
					aArrayQ[Len(aArrayQ)][1] := STR0009+ aQuebras[nQuebras,1]

					//  Zera as quebras do nivel.
					aQuebras[nQuebras,2] := 0
					aQuebras[nQuebras,3] := 0
					aQuebras[nQuebras,4] := 0
					aQuebras[nQuebras,5] := 0
					aQuebras[nQuebras,6] := 0
					aQuebras[nQuebras,7] := 0
				EndFor
			Endif
		Next
	Endif
EndDo

If ! lRelato
	If mv_par07 = 1
		Aadd(aArray, { STR0011, STR0031, STR0032, STR0012, STR0031, STR0032, STR0013, STR0031, STR0032 }) //"Mes"###"Acumulado"###"Mes"###"Acumulado"###"Mes"###"Acumulado"
	Else
		Aadd(aArray, { STR0011, "", STR0012, "", STR0013, "" })
	Endif

	aTotal := DevCred( aTotais[1], aTotais[2] )
	aAcumu := DevCred( aTotais[7], aTotais[8] )

	If mv_par07 = 1
		Aadd(aArray, { 	StrTran(STR0014, ":", ""), Transform( aTotais[1], "@E 999,999,999,999.99" ),;	//"A Realizar  : "
						Transform( aTotais[7], "@E 999,999,999,999.99" ),;
						StrTran(STR0014, ":", ""), Transform( aTotais[2], "@E 999,999,999,999.99" ),;	//"A Realizar  : "
						Transform( aTotais[8], "@E 999,999,999,999.99" ),;
						StrTran(STR0014, ":", ""), Transform( aTotal[1], "@E 999,999,999,999.99" ) + ; //"A Realizar  : "
						aTotal[2],;
						Transform( aAcumu[1], "@E 999,999,999,999.99" ) + aAcumu[2] })
	Else
		Aadd(aArray, { 	StrTran(STR0014, ":", ""), Transform( aTotais[1], "@E 999,999,999,999.99" ),;	//"A Realizar  : "
						StrTran(STR0014, ":", ""), Transform( aTotais[2], "@E 999,999,999,999.99" ),;	//"A Realizar  : "
						StrTran(STR0014, ":", ""), Transform( aTotal[1] , "@E 999,999,999,999.99" ) +; 	//"A Realizar  : "
						aTotal[2] })
	Endif

	aTotal := DevCred( aTotais[3], aTotais[4] )
	aAcumu := DevCred( aTotais[9], aTotais[10] )

	If mv_par07 = 1
		Aadd(aArray, { 	StrTran(STR0015, ":", ""),  Transform( aTotais[3], "@E 999,999,999,999.99" ),;	//"Realizado   : "
						Transform( aTotais[9], "@E 999,999,999,999.99" ),;
						StrTran(STR0015, ":", ""),  Transform( aTotais[4], "@E 999,999,999,999.99" ),; //"Realizado   : "
						Transform( aTotais[10], "@E 999,999,999,999.99" ),;
						StrTran(STR0015, ":", ""),  Transform( aTotal[1], "@E 999,999,999,999.99" ) +;//"Realizado   : "
						aTotal[2], Transform( aAcumu[1], "@E 999,999,999,999.99" ) +;
						aAcumu[2] })
    Else
		Aadd(aArray, { 	StrTran(STR0015, ":", ""),  Transform( aTotais[3], "@E 999,999,999,999.99" ),;	//"Realizado   : "
						StrTran(STR0015, ":", ""),  Transform( aTotais[4], "@E 999,999,999,999.99" ),; //"Realizado   : "
						StrTran(STR0015, ":", ""),  Transform( aTotal[1], "@E 999,999,999,999.99" ) +;//"Realizado   : "
						aTotal[2] })
	Endif

	nTotReceb := aTotais[1] + aTotais[3]
	nTotPagar := aTotais[2] + aTotais[4]

	nAcuReceb := aTotais[7] + aTotais[9]
	nAcuPagar := aTotais[8] + aTotais[10]

	aTotal := DevCred( nTotReceb, nTotPagar )
	aAcumu := DevCred( nAcuReceb, nAcuPagar )

	If mv_par07 = 1
		Aadd(aArray, { 	StrTran(STR0016, ":", ""),  Transform( nTotReceb, "@E 999,999,999,999.99" ),;	//"Total       : "
						Transform( nAcuReceb, "@E 999,999,999,999.99" ),;
						StrTran(STR0016, ":", ""),  Transform( nTotPagar, "@E 999,999,999,999.99" ),;	//"Total       : "
						Transform( nAcuPagar, "@E 999,999,999,999.99" ),;
						StrTran(STR0016, ":", ""),  Transform( aTotal[1],"@E 999,999,999,999.99") +;	//"Total       : "
						aTotal[2], Transform( aAcumu[1],"@E 999,999,999,999.99") +;
						aAcumu[2] } )
	Else
		Aadd(aArray, { 	StrTran(STR0016, ":", ""),  Transform( nTotReceb, "@E 999,999,999,999.99" ),;	//"Total       : "
						StrTran(STR0016, ":", ""),  Transform( nTotPagar, "@E 999,999,999,999.99" ),;	//"Total       : "
						StrTran(STR0016, ":", ""),  Transform( aTotal[1],"@E 999,999,999,999.99")+;	//"Total       : "
						aTotal[2] })
	Endif

	aTotal := DevCred( aTotais[5], aTotais[6] )
	aAcumu := DevCred( aTotais[11], aTotais[12] )
	If mv_par07 = 1
		Aadd(aArray, { 	StrTran(STR0029, ":", ""),  Transform( aTotais[5], "@E 999,999,999,999.99"),;	//"Orcado      : "
						Transform( aTotais[11], "@E 999,999,999,999.99"),;
						StrTran(STR0029, ":", ""),  Transform( aTotais[6], "@E 999,999,999,999.99"),; 	//"Orcado      : "
						Transform( aTotais[12], "@E 999,999,999,999.99"),;
						StrTran(STR0029, ":", ""),  Transform( aTotal[1],"@E 999,999,999,999.99") +;  	//"Orcado      : "
						aTotal[2], Transform( aAcumu[1],"@E 999,999,999,999.99") +;
						aAcumu[2] })
	Else
		Aadd(aArray, { 	StrTran(STR0029, ":", ""),  Transform( aTotais[5], "@E 999,999,999,999.99"),;	//"Orcado      : "
						StrTran(STR0029, ":", ""),  Transform( aTotais[6], "@E 999,999,999,999.99"),; 	//"Orcado      : "
						StrTran(STR0029, ":", ""),  Transform( aTotal[1],"@E 999,999,999,999.99")+;  	//"Orcado      : "
						aTotal[2] })
	Endif
Endif

Return { aTotais, aArrayQ, aArray }

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} FR720ProcNat
Processa regra de rateio multi-naturezas e acumula os valores calculados na tabela temporaria.

@sample		FR720ProcNat( nValor )
@param		NIL, Valor da movimentacao bancaria com rateio multiplas naturezas a ser proporcionalizado 
				 e acumulado na tabela temporaria.
@return		NIL
@author 	Gustavo Henrique
@since		07/10/2008
@version	MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

Static Function FR720ProcNat( nValor )

Local nProp := SEV->EV_PERC

// Se foi distrubuido por multiplas naturezas, o percentual sera menor que 1
If !cArqTmp->(MsSeek(SEV->EV_NATUREZ))
	RecLock("cArqTmp",.T.)
	cArqTmp->NATUR := SEV->EV_NATUREZ
	SED->(MsSeek(xFilial("SED")+cArqTmp->NATUR))
	cArqTmp->DESCR := SED->ED_DESCRIC
Else
	RecLock("cArqTmp")
Endif

IF lNoMes
	If cArqTmp->NATUR >= mv_par01 .and. cArqTmp->NATUR	<= mv_par02
		cArqTmp->rEntr += (nValor * nProp)
	Else
		cArqTmp->rSaid += (nValor * nProp)
	Endif
Endif

// Atualiza Realizados Acumulados
If mv_par07 == 1
	If cArqTmp->NATUR >= mv_par01 .and. cArqTmp->NATUR	<= mv_par02
		cArqTmp->REACM += (nValor * nProp)
	Else
		cArqTmp->RSACM += (nValor * nProp)
	Endif
Endif

If cPaisLoc = "BRA" .or. Empty(cArqTmp->Tipo)
	cArqTmp-> Tipo := SE5->E5_RECPAG
EndIf

Return

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} SelectFil
Separa as filiais, inserindo aspas simples e virgula, Para ser usado na clausula IN do SQL

@sample		cQuery += " AND SE1.E1_FILIAL IN("+SelectFil(aSelFil)+") "
@param		aSelFil, Array contendo a filiais selecionadas
@return		NIL
@author 	Gustavo Henrique
@since		04/09/2013
@version	MP11.90
/*/
//-----------------------------------------------------------------------------------------------------

Static Function SelectFil(aSelFil)

Local cFil	:=""
Local nX	:= 0

For nX:= 1 to len(aSelFil)

	cFil+="'"
	If len(aSelFil) > 0
		If aScan( aSelFil, { |x|x == aSelFil[1]} ) > 0
			cFil+=aSelFil[nX]
		EndIf
	Else
		cFil+="'"
	EndIf
	cFil+="',"

Next nX

Return SubStr(cFil,1,Len(cFil)-1)

//-------------------------------------------------------------------
/*/{Protheus.doc} FR720ChqCanc
Valida se o cheque possui estorno

@author	Caio Quiqueto
@version P11.8
@since 29/05/2015
@return	lRet se possui um estorno ou não
/*/								         
//-------------------------------------------------------------------

Static Function FR720ChqCanc()
Local cQuery := ''
Local aAreaChq := GetArea()

	cQuery := "select E5_VALOR from " + RetSqlName("SE5")+ " SE5" 
	cQuery += 	" where E5_FILIAL = '" + xFilial("SE5") + "' "
	cQuery += 		"AND E5_BANCO = '" + SE5->(E5_BANCO) + "' " 
	cQuery += 		"AND E5_AGENCIA = '" + SE5->(E5_AGENCIA) +"' "
	cQuery += 		"AND E5_CONTA = '" + SE5->(E5_CONTA) + "' "
	cQuery += 		"AND E5_NUMCHEQ = '" + SE5->(E5_NUMCHEQ) + "' "
	cQuery += 		"AND E5_SEQ =  '" + SE5->(E5_SEQ)  + "' "
	cQuery += 		"AND E5_TIPODOC = 'EC'"
	cQuery += 		"AND D_E_L_E_T_ = ' '"
	
	cQuery := ChangeQuery(cQuery)
	
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'TMPCHQ', .F., .T.)
	
	IF TMPCHQ->E5_VALOR == SE5->E5_VALOR
		lRet := .T.
	Else
		lRet := .F.
	EndIf

	TMPCHQ->(dbCloseArea())	

RestArea(aAreaChq)

return lRet
