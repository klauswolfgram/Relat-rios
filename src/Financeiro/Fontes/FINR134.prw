/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR134.CH"
#Include "PROTHEUS.Ch"

STATIC aSelFil	:= {}
Static _oFINR134


//-------------------------------------------------------------------
/*/{Protheus.doc} FINR134
Razonete de Fornecedores      

@author Ivan PC	
@since  26/01/2000
@version 12.1.7
/*/
//-------------------------------------------------------------------
User Function FINR134()
Local oReport

oReport	:= ReportDef()
oReport:PrintDialog()

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Razonete de Fornecedores      

@author Paulo Augusto   
@since  28/06/2000
@version 12.1.7
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

Local oReport	:= NIL
Local oSection1	:= NIL
Local oSection2	:= NIL
Local cReport	:= "FINR134"
Local cTitulo	:= OemToAnsi(STR0004) 
Local cDescri	:= OemToAnsi(STR0001)+" "+OemToAnsi(STR0002)+" "+OemToAnsi(STR0003)
Local nTamFor	:= TamSx3("A2_NREDUZ")[1] + TamSx3("A2_END")[1]
Local nTamEnd	:= TamSx3("A2_END")[1] + TamSx3("A2_MUN")[1] + TamSx3("A2_EST")[1]+TamSx3("A2_TEL")[1] + 22
Local oSecFil	:= Nil

Pergunte( "FIR134" , .F. )

oReport  := TReport():New( cReport, cTitulo, "FIR134" , { |oReport| ReportPrint( oReport ) }, cDescri )
oReport:SetLandScape()
oreport:DisableOrientation()

//GESTAO
oReport:SetUseGC(.F.)

// Define a 1a. secao do relatorio Valores nas Moedas
oSection1 := TRSection():New( oReport,STR0083 , { "cArqTemp","SA2"},{STR0073,STR0074,STR0075},/*Campos do SX3*/,/*Campos do SIX*/)                      

TRCell():New( oSection1, "A2_COD" ,"SA2" ,/*X3Titulo*/  ,/*Picture*/,TamSx3("A2_COD")[1]+TamSx3("A2_LOJA")[1]+1,/*lPixel*/,{||(cArqTemp)->CODIGO+"-"+(cArqTemp)->LOJA})

If RetGlbLGPD("A2_NREDUZ")
	TRCell():New( oSection1, "A2_NREDUZ","SA2" ,/*X3Titulo*/ ,/*Picture*/,nTamFor,/*lPixel*/,{||Replicate("*", TamSx3("A2_NREDUZ")[1])})
Else
	TRCell():New( oSection1, "A2_NREDUZ","SA2" ,/*X3Titulo*/ ,/*Picture*/,nTamFor,/*lPixel*/,{||SA2->A2_NREDUZ})
EndIf

If RetGlbLGPD("A2_END") .Or. RetGlbLGPD("A2_MUN") .Or. RetGlbLGPD("A2_TEL")
	TRCell():New( oSection1, "A2_END","SA2" ,/*X3Titulo*/ ,/*Picture*/,nTamEnd,/*lPixel*/,{||Replicate("*", TamSx3("A2_NREDUZ")[1] + TamSx3("A2_END")[1] + TamSx3("A2_TEL")[1] )})	
Else
	TRCell():New( oSection1, "A2_END","SA2" ,/*X3Titulo*/ ,/*Picture*/,nTamEnd,/*lPixel*/,{||Alltrim(SA2->A2_END) + " - "  +Alltrim(SA2->A2_MUN) + "-"+ SA2->A2_EST +"  "+OemtoAnsi(STR0051) +SA2->A2_TEL})	
EndIf

oSection2 := TRSection():New( oSection1,STR0086 , {"cArqTemp","SE2"} ) //"Titulos a pagar"  

// Relacao das filiais selecionadas para compor o relatorio
If cPaisLoc == 'RUS'
	oSecFil := TRSection():New(oReport,STR0095,{"SE1","SED"})
Else
	oSecFil := TRSection():New(oReport,"SECFIL",{"SE1","SED"})
EndIf
TRCell():New(oSecFil,"CODFIL" ,,STR0088,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0089,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0090,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"	
TRCell():New(oSecFil,"NOMEFIL",,STR0091,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

Return oReport


//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Razonete de Fornecedores      

@author Lucas   
@since  11/11/1999
@version 12.1.7
/*/
//-------------------------------------------------------------------
Static Function ReportPrint( oReport )

Local oSection1	:= oReport:Section(1)
Local oSection2	:= oSection1:Section(1)
Local oBreak1	:= NIL 
Local nOrder	:= oReport:Section(1):GetOrder()
Local aCampos	:={}
Local lPerg		:= .T.
Local lChkDRef	:= .F.
Local nI		:= 0
Local cImpSldChq:= "" 
Local nTotCheque:= 0
Local nAcumCh	:= 0
Local nVlCli00	:= 0	   
Local nVlCli01	:= 0	   
Local nVlCli02	:= 0	   
Local nVlCli03	:= 0
Local nVlCli04	:= 0	   
Local nVlCli05	:= 0
Local nVlCli06	:= 0
Local nVlCli07	:= 0
Local nVlCli08	:= 0
Local nVlCli09	:= 0
Local nVlCli10	:= 0
Local nVlCli11	:= 0
Local nRegSM0	:= SM0->(Recno())
Local lGestao   := AdmGetGest()		// Indica se usa Gestao Corporativa
Local lSE2Access:= Iif( lGestao, FWModeAccess("SE2",1) == "E", FWModeAccess("SE2",3) == "E")
Local aTmpFil	:= {}
Local cTmpSE2Fil:= ""
Local cRngFilSE2:= ""
Local nX		:= 0   
Local oSecFil	:= oReport:Section("SECFIL")
Local aRetAuto  := {}
Local aTitle	:= {}
Local nTamTit	:= TamSx3("E2_TIPO")[1] + TamSx3("E2_PREFIXO")[1] + TamSx3("E2_NUM")[1] + TamSx3("E2_PARCELA")[1] + 3

Private cCodForn
Private cLojaFor
Private cFornProv := ""
Private cLoja     := ""
Private cFornIni  := mv_par01
Private cFornFim  := mv_par02
Private dFechaIni := mv_par03
Private dFechaFim := mv_par04
Private nInforme  := mv_par05
Private nMoeda    := mv_par10
Private lConverte := (mv_par11==1)
Private nDecs     := MsDecimais(nMoeda)
Private dData01
Private dData02
Private dData03
Private dData04
Private dData05
Private dData06
Private dData07
Private dData08
Private dData09
Private dData10
Private dData11

// Verifica as perguntas selecionadas
Private dDataRef 	:= Iif(Empty(mv_par06), dDatabase, mv_par06)
Private nPeriodos 	:= Iif(mv_par09==0,1,mv_par09)
Private nTipoPer	:= mv_par08
Private nPerAnt		:= Iif(mv_par07 > 9,9,mv_par07)
Private nImpSldChq	:= mv_par12
Private cNomeArq
Private cArqTemp	:= GetNextAlias()

nRegSM0 := SM0->(Recno())

If lSE2Access .and. mv_par14 == 1	//filial nao totalmente compartilhada
	If !IsBlind()
		If FindFunction("FwSelectGC") .and. lGestao
			aSelFil := FwSelectGC()
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SE2")
		Endif
	Else
		If FindFunction("GetParAuto")
			aRetAuto := GetParAuto("FINR134TestCase") 
			aSelFil  := aRetAuto
		EndIf
	Endif
Endif
If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif
SM0->(DbGoTo(nRegSM0))

If Len(aSelFil) > 1
	cRngFilSE2 := GetRngFil( aSelFil, "SE2", .T., @cTmpSE2Fil )
	aAdd(aTmpFil, cTmpSE2Fil)
	// Imprime a lista de filiais selecionadas para o relatorio
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0092 + ")")		//"Filiais selecionadas para o relatorio"
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
Endif

cImpSldChq := IIF(nImpSldChq == 1,'nInforme == 1 .And. (cArqTemp)->TIPO <> "CH "',"nInforme == 1")
If cPaisloc == "CHI"
	nDecs:= 2
EndIf

If nTipoPer == 3 //Informado
	lOk	:=	.T.
	While lOk
		If Pergunte("FI134B",.T.)
			lPerg := .T.
			For nI:=1 to 10
				cData1 := ("mv_par"+StrZero(nI,2))
				cData2 := ("mv_par"+StrZero(nI+1,2))
				If  Dtos(&cData1) >= Dtos(&cData2)
					lPerg := .F.
					nI:=10
				Endif
			Next
			If lPerg
				For nI:=1 to 11
					cData1 := ("mv_par"+StrZero(nI,2))
					If Dtos(&cData1) == Dtos(dDataRef)
						lChkDRef := .T.
						nI := 11
					Endif
				Next
				If !lChkDRef
					MsgStop(OemToAnsi(STR0036)) //"Uma das datas deve coincidir com a Data de Referencia"
					Loop
				Endif
			Endif

			If lPerg
				dData01 := mv_par01
				dData02 := mv_par02
				dData03 := mv_par03
				dData04 := mv_par04
				dData05 := mv_par05
				dData06 := mv_par06
				dData07 := mv_par07
				dData08 := mv_par08
				dData09 := mv_par09
				dData10 := mv_par10
				dData11 := mv_par11
				//Para restaurar as perguntas originais. Bruno
				Pergunte("FIR134",.F.)
				lOk	:=	.F.
			Else
				MsgStop(OemToAnsi(STR0037)) //"Erro de sequencia nas datas"
			Endif
		Else
			Return .F.
		Endif
	Enddo
Else
	dData01 := Fr134Data(dDataRef,01,nPeriodos,nTipoPer,nPerAnt,dDataRef)
	dData02 := Fr134Data(dDataRef,02,nPeriodos,nTipoPer,nPerAnt,dData01)
	dData03 := Fr134Data(dDataRef,03,nPeriodos,nTipoPer,nPerAnt,dData02)
	dData04 := Fr134Data(dDataRef,04,nPeriodos,nTipoPer,nPerAnt,dData03)
	dData05 := Fr134Data(dDataRef,05,nPeriodos,nTipoPer,nPerAnt,dData04)
	dData06 := Fr134Data(dDataRef,06,nPeriodos,nTipoPer,nPerAnt,dData05)
	dData07 := Fr134Data(dDataRef,07,nPeriodos,nTipoPer,nPerAnt,dData06)
	dData08 := Fr134Data(dDataRef,08,nPeriodos,nTipoPer,nPerAnt,dData07)
	dData09 := Fr134Data(dDataRef,09,nPeriodos,nTipoPer,nPerAnt,dData08)
	dData10 := Fr134Data(dDataRef,10,nPeriodos,nTipoPer,nPerAnt,dData09)
	dData11 := Fr134Data(dDataRef,11,nPeriodos,nTipoPer,nPerAnt,dData10)
EndIf

// Definicao dos cabecalhos
Titulo := OemToAnsi(STR0004) //"DEUDAS VENCIDAS Y A VENCER A PROVEEDOR"
Titulo += Space(1)
Titulo += OemToAnsi(STR0038)+DToC(dFechaIni)+OemToAnsi(STR0039)+DToC(Min(dDataRef,dFechaFim))  //" De Emision: "###"  Hasta : "

AADD(aCampos,{"FILORIG" 	,"C",FWSizeFilial(),0})
AADD(aCampos,{"CODIGO"  	,"C",TamSx3('E2_FORNECE')[1],0})
AADD(aCampos,{"LOJA"    	,"C",TamSx3('E2_LOJA')[1],0})
AADD(aCampos,{"FORNECEDOR"	,"C",25,0})
AADD(aCampos,{"TELEFONE"	,"C",15,0})
AADD(aCampos,{"NOMEVEND"	,"C",25,0})
AADD(aCampos,{"TELEVEND"	,"C",15,0})
AADD(aCampos,{"NATUREZA"	,"C",10,0})
AADD(aCampos,{"PREFIXO" 	,"C",TamSx3('E2_PREFIXO')[1],0})
AADD(aCampos,{"NUMERO"  	,"C",TamSx3('E2_NUM')[1],0})
AADD(aCampos,{"TIPO"    	,"C",TamSx3('E2_TIPO')[1],0})
AADD(aCampos,{"PARCELA" 	,"C",TamSx3('E2_PARCELA')[1],0})
AADD(aCampos,{"BANCO"   	,"C",03,0})
AADD(aCampos,{"EMISSAO" 	,"D",08,0})
AADD(aCampos,{"BAIXA"   	,"D",08,0})
AADD(aCampos,{"VENCTO"  	,"D",08,0})
AADD(aCampos,{"VALOR"   	,"N",20,nDecs})
AADD(aCampos,{"DEBITO"  	,"N",20,nDecs})
AADD(aCampos,{"CREDITO" 	,"N",20,nDecs})
AADD(aCampos,{"SALDO"   	,"N",20,nDecs})
AADD(aCampos,{"SALTIT"  	,"N",20,nDecs})
AADD(aCampos,{"DC"      	,"C", 1,0})
AADD(aCampos,{"SIGLA"   	,"C",03,0})
AADD(aCampos,{"VALOR00" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR01" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR02" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR03" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR04" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR05" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR06" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR07" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR08" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR09" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR10" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR11" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR12" 	,"N",20,nDecs})
AADD(aCampos,{"VALOR13" 	,"N",20,nDecs})
AADD(aCampos,{"TOTCHEQ" 	,"N",20,nDecs})
AADD(aCampos,{"SALDOFIM"	,"N",20,nDecs})

If(_oFINR134 <> NIL)
	_oFINR134:Delete()
	_oFINR134 := NIL
EndIf

_oFINR134 := FwTemporaryTable():New(cArqTemp)
_oFINR134:SetFields(aCampos)

If nOrder	==	1
	_oFINR134:AddIndex("1",{"CODIGO","LOJA","VENCTO"})
ElseIf nOrder	==	2
	_oFINR134:AddIndex("1",{"CODIGO","LOJA","PREFIXO","NUMERO","PARCELA","TIPO"})
Else
	_oFINR134:AddIndex("1",{"CODIGO","LOJA","EMISSAO"})
Endif

_oFINR134:Create()
dbSelectArea(cArqTemp)

Processa({|lEnd| GeraTra(oSection1:GetAdvplExp('SE2'),oSection1:GetAdvplExp('SA2'),cRngFilSE2,cArqTemp)},,OemToAnsi(STR0041))  //"Preparando Transit¢rio..."

R134fechas()

// Inicia rotina de impressao
dbGoTop()

oSection2:SetParentFilter({|cParam| (cArqTemp)->CODIGO+(cArqTemp)->LOJA == cParam },{||SA2->A2_COD+SA2->A2_LOJA}) 
oBreak1 := TRBreak():New( oSection2,{||.T.},STR0042)
oSection1:SetOrder(1) 
oSection1:SetTotalInLine(.T.)
oReport:SetTotalInLine(.F.)

Trposition():New(oReport:Section(1),"SA2",1,"xfilial('SA2',(cArqTemp)->FILORIG)+(cArqTemp)->CODIGO+(cArqTemp)->LOJA")  

oSection2:SetLineCondition({||&cImpSldChq})

//-- Campos de oSection2 - "Titulos a pagar"  
Aadd(aTitle," " + CHR(13)+ CHR(10)+" " + CHR(13)+ CHR(10)+ STR0080+ CHR(13)+ CHR(10)+  dToc(dData01))//--VALO00
Aadd(aTitle,IIf(dDataRef==dData02 ,STR0084,Iif(dDataRef=dData01,STR0085," ")) + CHR(13)+ CHR(10)+dToc(dData01 +1)+ CHR(13)+ CHR(10)+STR0081+ CHR(13)+ CHR(10)+  dToc(dData02 ))//--VALO01
Aadd(aTitle,IIf(dDataRef==dData03 ,STR0084,Iif(dDataRef=dData02,STR0085," ")) + CHR(13)+ CHR(10)+dToc(dData02 +1)+ CHR(13)+ CHR(10)+STR0081+ CHR(13)+ CHR(10)+  dToc(dData03 ))//--VALO02
Aadd(aTitle,IIf(dDataRef==dData04 ,STR0084,Iif(dDataRef=dData03,STR0085," ")) + CHR(13)+ CHR(10)+dToc(dData03 +1)+ CHR(13)+ CHR(10)+STR0081+ CHR(13)+ CHR(10)+  dToc(dData04 ))//--VALO03
Aadd(aTitle,IIf(dDataRef==dData05 ,STR0084,Iif(dDataRef=dData04,STR0085," ")) + CHR(13)+ CHR(10)+dToc(dData04 +1)+ CHR(13)+ CHR(10)+STR0081+ CHR(13)+ CHR(10)+  dToc(dData05 ))//--VALO04
Aadd(aTitle,IIf(dDataRef==dData06 ,STR0084,Iif(dDataRef=dData05,STR0085," ")) + CHR(13)+ CHR(10)+dToc(dData05 +1)+ CHR(13)+ CHR(10)+STR0081+ CHR(13)+ CHR(10)+  dToc(dData06 ))//--VALO05
Aadd(aTitle,IIf(dDataRef==dData07 ,STR0084,Iif(dDataRef=dData06,STR0085," ")) + CHR(13)+ CHR(10)+dToc(dData06 +1)+ CHR(13)+ CHR(10)+STR0081+ CHR(13)+ CHR(10)+  dToc(dData07 ))//--VALO06
Aadd(aTitle,IIf(dDataRef==dData08 ,STR0084,Iif(dDataRef=dData07,STR0085," ")) + CHR(13)+ CHR(10)+dToc(dData07 +1)+ CHR(13)+ CHR(10)+STR0081+ CHR(13)+ CHR(10)+  dToc(dData08 ))//--VALO07
Aadd(aTitle,IIf(dDataRef==dData09 ,STR0084,Iif(dDataRef=dData08,STR0085," ")) + CHR(13)+ CHR(10)+dToc(dData08 +1)+ CHR(13)+ CHR(10)+STR0081+ CHR(13)+ CHR(10)+  dToc(dData09 ))//--VALO08
Aadd(aTitle,IIf(dDataRef==dData10 ,STR0084,Iif(dDataRef=dData09,STR0085," ")) + CHR(13)+ CHR(10)+dToc(dData09 +1)+ CHR(13)+ CHR(10)+STR0081+ CHR(13)+ CHR(10)+  dToc(dData10 ))//--VALO09
Aadd(aTitle," " + CHR(13)+ CHR(10)+dToc(dData10 +1)+ CHR(13)+ CHR(10)+STR0081+ CHR(13)+ CHR(10)+  dToc(dData11 )  )//--VALO10
Aadd(aTitle,"" + CHR(13)+ CHR(10)+"" + CHR(13)+ CHR(10)+STR0082+ CHR(13)+ CHR(10)+  dToc(dData11+1) )       //--VALO11

TRCell():New( oSection2, "VENCTO"	,""	, STR0087,/*Picture*/,8,/*lPixel*/,{|| dateCast((cArqTemp)->VENCTO)},,,,,1,.F.)	
TRCell():New( oSection2, "TITULO"	,""	, STR0093,/*Picture*/,nTamTit,/*lPixel*/,{||(cArqTemp)->TIPO+" "+(cArqTemp)->PREFIXO+" "+(cArqTemp)->NUMERO+" "+(cArqTemp)->PARCELA},,,,,,.F.)
TRCell():New( oSection2, "VALOR00" 	,"" , aTitle[1] ,PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR00 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR01" 	,"" , aTitle[2] ,PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR01 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR02" 	,"" , aTitle[3] ,PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR02 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR03" 	,"" , aTitle[4] ,PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR03 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR04" 	,"" , aTitle[5] ,PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR04 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR05" 	,"" , aTitle[6] ,PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR05 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR06" 	,"" , aTitle[7] ,PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR06 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR07" 	,"" , aTitle[8] ,PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR07 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR08" 	,"" , aTitle[9] ,PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR08 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR09" 	,"" , aTitle[10],PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR09 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR10" 	,"" , aTitle[11],PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR10 },,,,,0,.t.)
TRCell():New( oSection2, "VALOR11" 	,"" , aTitle[12],PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)->VALOR11 },,,,,0,.t.)
TRCell():New( oSection2, "SALDOFIM"	,"" , STR0079   ,PesqPict("SE2","E2_VALOR")/*Picture*/,TamSx3("E2_VALOR")[1],/*lPixel*/,{||(cArqTemp)-> SALDOFIM},,,"RIGHT",,1,.t.)
If cPaisLoc == 'RUS'
	TRCell():New( oSection2, "TPSALDO" 	,"" , STR0094/*X3Titulo()*/,/*Picture*/,1,/*lPixel*/,{||Iif((cArqTemp)->SALDOFIM<0,"C","D") })
Else
	TRCell():New( oSection2, "TPSALDO" 	,"" , "D/C"/*X3Titulo()*/,/*Picture*/,1,/*lPixel*/,{||Iif((cArqTemp)->SALDOFIM<0,"C","D") })
EndIf
oSection2:SetHeaderPage()


If mv_par05 == 1
	oBreak1 := TRBreak():New( oSection2,{||.T.},STR0042)
	TRFunction():New(oSection2:Cell("VALOR00")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR01")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR02")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR03")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR04")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR05")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR06")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR07")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR08")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR09")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR10")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR11")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("SALDOFIM")	, ,"SUM", oBreak1, , , , .F. ,)
Else
	//Totalizadores            
	TRFunction():New(oSection2:Cell("VALOR00")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR01")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR02")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR03")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR04")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR05")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR06")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR07")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR08")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR09")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR10")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR11")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("SALDOFIM")	, ,"SUM", , , , , .F. ,)			
	//oculta
	oSection2:Cell("VENCTO"):Hide()
	oSection2:Cell("TITULO"):Hide()
	
	//Define valores para as secoes
	oSection2:Cell("VALOR00"):SetBlock({|| nVlCli00 })
	oSection2:Cell("VALOR01"):SetBlock({|| nVlCli01 })
	oSection2:Cell("VALOR02"):SetBlock({|| nVlCli02 })
	oSection2:Cell("VALOR03"):SetBlock({|| nVlCli03 })
	oSection2:Cell("VALOR04"):SetBlock({|| nVlCli04 })
	oSection2:Cell("VALOR05"):SetBlock({|| nVlCli05 })
	oSection2:Cell("VALOR06"):SetBlock({|| nVlCli06 })
	oSection2:Cell("VALOR07"):SetBlock({|| nVlCli07 })
	oSection2:Cell("VALOR08"):SetBlock({|| nVlCli08 })
	oSection2:Cell("VALOR09"):SetBlock({|| nVlCli09 })
	oSection2:Cell("VALOR10"):SetBlock({|| nVlCli10 })
	oSection2:Cell("VALOR11"):SetBlock({|| nVlCli11 })
	oSection2:Cell("SALDOFIM"):SetBlock({|| nSalCliFim })	
EndIf

oSection1:SetOrder(1) 
oSection1:SetTotalInLine(.T.)
oReport:SetTotalInLine(.F.)

Trposition():New(oSection2,"SE2",1,{|| xFilial('SE2',(cArqTemp)->FILORIG)+(cArqTemp)->PREFIXO+(cArqTemp)->NUMERO+(cArqTemp)->PARCELA+(cArqTemp)->SIGLA+(cArqTemp)->CODIGO+(cArqTemp)->LOJA})  

oReport:SetTitle(titulo)

oReport:SetMeter(RecCount())
dbSelectArea(cArqTemp)
DbGotop()

oSection1:Init() 
nTotCheque:=0
While !(cArqTemp)->(EOF())  
    oSection1:PrintLine()      
 	oSection2:Init()
	cCliente:=(cArqTemp)->CODIGO+(cArqTemp)->LOJA
	If mv_par05 == 2 //Sintetico
		nVlCli00	   := 0
		nVlCli01	   := 0
		nVlCli02	   := 0
		nVlCli03	   := 0
		nVlCli04	   := 0
		nVlCli05	   := 0
		nVlCli06	   := 0
		nVlCli07	   := 0
		nVlCli08	   := 0
		nVlCli09	   := 0
		nVlCli10	   := 0
		nVlCli11	   := 0
		nSalCliFim	:= 0
	EndIf 	
    While cCliente==(cArqTemp)->CODIGO+(cArqTemp)->LOJA  .And. !(cArqTemp)->(EOF())
		oReport:IncMeter()    	
  		If mv_par05 == 2 //Sintetico
			nVlCli00	   += (cArqTemp)->VALOR00
			nVlCli01	   += (cArqTemp)->VALOR01
			nVlCli02	   += (cArqTemp)->VALOR02
			nVlCli03	   += (cArqTemp)->VALOR03
			nVlCli04	   += (cArqTemp)->VALOR04
			nVlCli05	   += (cArqTemp)->VALOR05
			nVlCli06	   += (cArqTemp)->VALOR06
			nVlCli07	   += (cArqTemp)->VALOR07
			nVlCli08	   += (cArqTemp)->VALOR08
			nVlCli09	   += (cArqTemp)->VALOR09
			nVlCli10	   += (cArqTemp)->VALOR10
			nVlCli11	   += (cArqTemp)->VALOR11
			nSalCliFim	+= (cArqTemp)->SALDOFIM
		EndIf
  		If &cImpSldChq .and. mv_par05 == 1 // analitico
	   		oSection2:PrintLine()	
	   	EndIf
   		nTotCheque:= nTotCheque + (cArqTemp)->TOTCHEQ
    
  		Dbskip()
  	EndDo               
 	If mv_par05 == 2 //Sintetico
  		oSection2:PrintLine()
  	EndIf               
  	If nTotCheque > 0
		oReport:ThinLine()
		oReport:PrintText(OemToAnsi(STR0043) + Space(01)+ Dtoc(dDataRef) + " :   " +Alltrim(Transf(nTotCheque,PesqPict("SE2","E2_VALOR"))))

	EndIf 
	oSection2:Finish()	
	oReport:ThinLine()
	nAcumCh := nAcumCh + nTotCheque
	nTotCheque := 0

EndDo     
If nAcumCh > 0
	oReport:PrintText(OemToAnsi(STR0045) + Space(01)+ Dtoc(dDataRef) + " :  " + Alltrim(Transf(nAcumCh,PesqPict("SE2","E2_VALOR"))))
	oReport:ThinLine()
EndIf 
oSection1:Finish()		

dbSelectArea(cArqTemp)
dbCloseArea()

If(_oFINR134 <> NIL)
	_oFINR134:Delete()
	_oFINR134 := NIL
EndIf

dbSelectArea("SA2")
RetIndex("SA2")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SE2")
RetIndex("SE2")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SE5")
RetIndex("SE5")
dbSetOrder(1)
DbClearFilter()

//Apago os TRBs criados no Banco (Filiais)
For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])   
Next

Return .T.       


//-------------------------------------------------------------------
/*/{Protheus.doc} R134Fechas
Grava um registro no arquivo de trabalho para impressao do Razonete.

@author Lucas   
@since  11/11/1999
@version 12.1.7
/*/
//-------------------------------------------------------------------
Static Function R134Fechas()

Local nValor 	 := 0.00
Local nSldTit 	 := 0.00
Local cImpSldChq := IIf(nImpSldChq == 1,'(cArqTemp)->TIPO <> "CH"',".T.")

dbSelectArea(cArqTemp)
dbGoTop()
While !Eof()
	nSldTit := (cArqTemp)->SALDO
	RecLock(cArqTemp,.F.)
	If (&cImpSldChq)
		If (cArqTemp)->VENCTO <= dData01
			Replace VALOR00    With VALOR00 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData01 .and. (cArqTemp)->VENCTO <= dData02
			Replace VALOR01   With VALOR01 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData02 .and. (cArqTemp)->VENCTO <= dData03
			Replace VALOR02   With VALOR02 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData03 .and. (cArqTemp)->VENCTO <= dData04
			Replace VALOR03   With VALOR03 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData04 .and. (cArqTemp)->VENCTO <= dData05
			Replace VALOR04   With VALOR04 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData05 .and. (cArqTemp)->VENCTO <= dData06
			Replace VALOR05   With VALOR05 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData06 .and. (cArqTemp)->VENCTO <= dData07
			Replace VALOR06   With VALOR06 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData07 .and. (cArqTemp)->VENCTO <= dData08
			Replace VALOR07   With VALOR07 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData08 .and. (cArqTemp)->VENCTO <= dData09
			Replace VALOR08   With VALOR08 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData09 .and. (cArqTemp)->VENCTO <= dData10
			Replace VALOR09   With VALOR09 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData10 .and. (cArqTemp)->VENCTO <= dData11
			Replace VALOR10   With VALOR10 + nSldTit
		ElseIf (cArqTemp)->VENCTO > dData11
			Replace VALOR11   With VALOR11 + nSldTit
		EndIf

		nValor := VALOR00+VALOR01+VALOR02+VALOR03+VALOR04+VALOR05+VALOR06
		nValor += VALOR11+VALOR10+VALOR09+VALOR08+VALOR07
		Replace SALDOFIM  With nValor
	Else
		Replace TOTCHEQ With nSldTit
	Endif
	MsUnLock()
	dbSkip()
End
Return( NIL )


//-------------------------------------------------------------------
/*/{Protheus.doc} GeraTra
Criação da tabela temporária

@author Lucas   
@since  11/11/1999
@version 12.1.7
/*/
//-------------------------------------------------------------------
Static Function GeraTra(cFltSE2,cFltSA2,cRngFilSE2,cArqTemp)
Local nSigno	:= ""
Local cTipos 	:= ""
Local nTaxa		:= 0     
Local cQuery	:= ""
Local cAliasSE2	:= ""
Local cFilOrig	:= ""
Local aArea		:= {} 
Local nSE2Rec	:= 0
Local cSE2Key	:= ''
Local nValorISS	:= 0 
Local lIssBaixa := (cPaisLoc == "BRA" .And. SuperGetMv("MV_MRETISS", .F., "1") == "2")
Local lOk 		:= .T.
Local aTmp 		:= {}
Local nVa		:= 0
Local lFValAcess:= ExistFunc('FValAcess')
Local lLGPD		:= RetGlbLGPD("A2_NREDUZ")
Local cFilTit	:= ""
Local cProveedor:= ""
Local cNumMov   := ""
Local lValPago  := .F.
 
Default cRngFilSE2 := ""
Default cArqTemp := ""

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

If ExistBlock("FR134TIP")
	cTipos   := ExecBlock("FR134TIP",.F.,.F.)
Endif

cFilOrig := cFilAnt
aArea := GetArea()
cQuery := "SELECT E2_FORNECE, R_E_C_N_O_ FROM " + RetSQLName("SE2") + " WHERE " 
If Len(aSelFil) > 1
	cQuery += " E2_FILIAL " + cRngFilSE2
Else
	cQuery += " E2_FILIAL = '" + xFilial("SE2",aSelFil[1]) + "'"
Endif
cQuery += " AND E2_FORNECE BETWEEN '" + cFornIni        + "' AND '" + cFornFim + "'"
cQuery += " AND E2_EMISSAO BETWEEN '" + DToS(dFechaIni) + "' AND '" + DToS(MIN(dDataRef,dFechaFim)) + "'"

If cPaisLoc == "ARG" .And. nMoeda <> 1
	cQuery += " AND E2_CONVERT != '" + 'N' + "'"
Endif

If !lConverte
	cQuery += "AND E2_MOEDA = " + AllTrim(Str(nMoeda))
Endif

If !Empty(cTipos)
	cQuery += "AND E2_TIPO NOT IN " + FinTipoIN(cTipos)
Endif

cQuery += " AND D_E_L_E_T_ = ' '"
cQuery += " ORDER BY E2_FORNECE" 

If cPaisLoc <> "BRA"
	cQuery += ", R_E_C_N_O_"
EndIf

cQuery := ChangeQuery(cQuery)

cAliasSE2 := CriaTrab(,.F.)
DbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasSE2,.F.,.T.)

nCount := 1000

ProcRegua( nCount )

While !(cAliasSE2)->(Eof()) .and. (cAliasSE2)->E2_FORNECE <= cFornFim
	If lOk
		aTmp := (cAliasSE2)->(GetArea()) 
		DbSelectArea( "SA2" )
		SA2->(DbSetOrder(1))
		DbSelectArea("SE2")
		SE2->(DbSetOrder(1))	
		RestArea(aTmp)
		lOk := .F.
	EndIf
	
	SE2->(DbGoTo((cAliasSE2)->R_E_C_N_O_))
	
	If !Empty(cFltSE2)	
		DbSelectArea("SE2")//Ativando Alias para aplicar o filtro
		If !(&(cFltSE2))
			(cAliasSE2)->(DbSkip())
			Loop
		Endif
	Endif
	
	If !Empty(cFltSA2)
		DbSelectArea("SA2")//Ativando Alias para aplicar o filtro
		If SA2->(MSSeek(xFilial("SA2", SE2->E2_FILORIG ) + SE2->E2_FORNECE + SE2->E2_LOJA ))
			If !(&(cFltSA2))
				(cAliasSE2)->( DbSkip() )
				Loop
			Endif	
		Endif
	Endif

    cFilTit := SE2->E2_FILIAL
	nTaxa   := IiF(MV_PAR13 == 1, 0, Iif(!Empty(SE2->E2_TXMOEDA),SE2->E2_TXMOEDA, RecMoeda(SE2->E2_EMISSAO,SE2->E2_MOEDA)))
	nSigno  := IIf(SE2->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG+"/"+MVABATIM, -1, 1)
	nSaldo  := 0
	nSaldo  := Round(SaldoTit(SE2->E2_PREFIXO, SE2->E2_NUM, SE2->E2_PARCELA, SE2->E2_TIPO, SE2->E2_NATUREZ, "P", SE2->E2_FORNECE, nMoeda, dDataRef, dDataRef, SE2->E2_LOJA, Iif( Empty( cFilTit), Nil , cFilTit), nTaxa ), nDecs )  

	If lFValAcess
		nVa := FValAcess( SE2->E2_PREFIXO, SE2->E2_NUM, SE2->E2_PARCELA, SE2->E2_TIPO, SE2->E2_FORNECE, SE2->E2_LOJA, SE2->E2_NATUREZ, Iif( Empty( SE2->E2_BAIXA),.F.,.T.),""    ,"P"      ,,, SE2->E2_MOEDA, , SE2->E2_TXMOEDA )
	EndIf
	
	nSaldo += nVa
	
	// Retenções de ISS
	If lIssBaixa .And. !Empty(SE2->E2_VRETISS)
		nSE2Rec := SE2->(RECNO())
		cSE2Key := SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM)
		SE2->(dbSeek(cSE2Key))
		
		While SE2->(!EOF()) .And. SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM) == cSE2Key
			If SE2->E2_TIPO $ MVISS .And. SE2->E2_EMISSAO <= dDataRef
				nValorISS += SE2->E2_VALOR
			EndIf
			SE2->(dbSkip())
		EndDo
		
		nSaldo -= nValorISS
		SE2->(dbGoTo(nSE2Rec))
	EndIf

	If cPaisloc <> "BRA" .And. FindFunction("Fn134VlPg")
		If Fn134VlPg(@cProveedor, @cNumMov, @lValPago, nSaldo, SE2->E2_FORNECE, SE2->E2_NUM, SE2->E2_TIPO, SE2->E2_VALOR)
			(cAliasSE2)->( DbSkip() )
			Loop
		EndIf
	EndIf

	IF nSaldo > 0
		If SA2->(DbSeek( xFilial( "SA2",SE2->E2_FILORIG ) + SE2->E2_FORNECE + SE2->E2_LOJA))

			If lLGPD
				IncProc(OemtoAnsi(STR0064) + Replicate("*", TamSx3("A2_NREDUZ")[1]))  //"Procesando proveedor "
			Else
				IncProc(OemtoAnsi(STR0064)+Subst(SA2->A2_NREDUZ,1,27))  //"Procesando proveedor "
			Endif

			dbSelectArea(cArqTemp)
			RecLock(cArqTemp,.T.)
			(cArqTemp)->FILORIG   :=  SE2->E2_FILORIG
			(cArqTemp)->CODIGO    :=  SE2->E2_FORNECE
			(cArqTemp)->LOJA      :=  SE2->E2_LOJA

			If RetGlbLGPD("A2_NOME")
				(cArqTemp)->FORNECEDOR :=  Replicate("*", TamSx3("A2_NOME")[1])
			Else
				(cArqTemp)->FORNECEDOR :=  SA2->A2_NOME
			Endif

			If RetGlbLGPD("A2_TEL")
				(cArqTemp)->TELEFONE  :=  Replicate("*", TamSx3("A2_TEL")[1])
			Else
				(cArqTemp)->TELEFONE  :=  SA2->A2_TEL
			Endif

			(cArqTemp)->NUMERO    :=  SE2->E2_NUM
			(cArqTemp)->TIPO      :=  SE2->E2_TIPO
			(cArqTemp)->SIGLA     :=  SE2->E2_TIPO
			(cArqTemp)->PARCELA   :=  SE2->E2_PARCELA
			(cArqTemp)->PREFIXO   :=  SE2->E2_PREFIXO
			(cArqTemp)->EMISSAO   :=  SE2->E2_EMISSAO
			(cArqTemp)->VENCTO    :=  SE2->E2_VENCREA
			(cArqTemp)->VALOR     :=  ( SE2->E2_VALOR + nVA ) * nSigno
			(cArqTemp)->SALDO     :=  nSaldo * nSigno
			MsUnLock()
		Endif
	EndIf
	(cAliasSE2)->(dbSkip())
EndDo

DbSelectArea(cAliasSE2)
DbCloseArea()
RestArea(aArea)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} Fr134Data
Retorna a data correta segundo os parametros informados

@author Mauricio Pequim Jr
@since  06/01/2016
@version 12.1.7
/*/
//-------------------------------------------------------------------
Static Function Fr134Data(dData,nColuna,nPeriodo,nTipo,nPeriodAnt,dDataAnt)
Local dRet
Local nPerAux := 0
Local nAnoAux := 0
Local lRet := .T.
Default dDataAnt := ""

If nTipo == 1 // Dia
	nRetPer  := nPeriodo * (nColuna - (nPeriodAnt + 1) )
	dRet 	 := dData + nRetPer

ElseIf nTipo == 2  //Mes
	nMonth   := Month(dData)
	nAno     := Year(dData)
	nRetPer  := nPeriodo * (nColuna - (nPeriodAnt + 1) )
	nMonth   := nMonth + nRetPer
	
	While nMonth <= 0
		nMonth += 12
		nAno -= 1
		If nMonth > 0
			Exit
		Endif
	Enddo

	If nPeriodo > 12 .And. nRetPer > 0
		
		While .T.
			nPerAux += 12
			nAnoAux += 1
			If nPerAux > nPeriodo
				nPerAux -= 12
				nAnoAux -= 1
				nMonth := Month(dDataAnt) + nPeriodo - nPerAux
				If nMonth > 12
					nMonth -= 12
					nAnoAux += 1
				Endif
				lRet := .F.
				Exit
			Elseif nPerAux == nPeriodo
				nMonth := Month(dDataAnt)
				lRet := .F.
				Exit
			Endif
		Enddo	

		nAno := Year(dDataAnt)+nAnoAux
	Endif

	While nMonth > 12 .And. lRet
		nMonth += -12

		If (Month(dDataAnt) + nPeriodo) > 12
			nMonth := (Month(dDataAnt) + nPeriodo) - 12 
			nAno := Year(dDataAnt) + 1
		Endif

		nAno := IIf(nAno < Year(dDataAnt),Year(dDataAnt),nAno)
	EndDo
	
	If Month(dData) <> Month(dData+1)
		dRet	:=	LastDay(Ctod("01/"+StrZero(nMonth,2)+"/"+Str(nAno,4)),0)
	Else
		cMonth   := Strzero(nMonth,2)
		cDay	 := Str(Day(dData),2)
		dRet     := CTOD(cDay+"/"+cMonth+"/"+Str(nAno,4))
	Endif
Endif

Return dRet

//-------------------------------------------------------------------
/*/{Protheus.doc} FinTipoIN
Monta a expressão do NOT IN da query

@author Mauricio Pequim Jr
@since  06/01/2016
@version 12.1.7
/*/
//-------------------------------------------------------------------
Static Function FinTipoIN(cTipos)

Default cTipos := MVPROVIS+"/"+MVRECANT+"/"+MV_CRNEG+"/"+MVABATIM+"/"+MVFUABT

cTipos	:=	StrTran(cTipos,',','/')
cTipos	:=	StrTran(cTipos,';','/')
cTipos	:=	StrTran(cTipos,'|','/')
cTipos	:=	StrTran(cTipos,'\','/')

cTipos := Formatin(cTipos,"/")

Return cTipos

//-------------------------------------------------------------------
/*/{Protheus.doc} dateCast
Converte a data em string para manipular a mascara e cortar o ano

@author Igor Nascimento
@since  25/06/2020
/*/
//-------------------------------------------------------------------
static function dateCast(dDate as date) as character

	local cDate   as character
	local cYear   as character
	local cMonth  as character
	local cDay    as character
	local cString as character

	default dDate := CtoD("")

	cString := DTOS(dDate)
	cYear   := SubStr(cString,3,2)
	cMonth  := SubStr(cString,5,2)
	cDay	:= SubStr(cString,7,2)
	cDate	:= cDay + "/" + cMonth + "/" + cYear

return cDate
