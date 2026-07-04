/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR502.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "fwcommand.ch"

Static cPerg := "FIN502"
Static _oFIRN5021
Static __cAliasTrb := ""
Static __lMotInDb

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FIRN502  ³ Autor ³ Alvaro Camillo Neto   ³ Data ³ 14.02.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Liquidacoes Financeiras (Contas a Pagar)    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR502(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FinR502()
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

__cAliasTrb := ""

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 10.07.06 ³±±
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
Local oReport := Nil
Local oSection0 := Nil //Gestão Corporativa
Local oSection1 := Nil
Local oSection11 := Nil
Local aTam0 := {} //Gestão Corporativa
Local aTam1 := {}
Local aTam2 := {}
Local aTam3 := {}
Local nTam0 //Gestão Corporativa
Local nTamLiq := 0
Local aTamCHQ := {}
Local nTamCHQ := 0
Local oSecFil	:= Nil

Pergunte(cPerg, .F.)

oReport := TReport():New("FINR502",STR0001,cPerg,;//"Liquidacoes Financeiras"
{|oReport| ReportPrint(oReport)},STR0002+STR0003)//"Este relatorio irá imprimir o extrato de Liquidacoes "##"Financeiras."

aTam0 := TamSX3("E2_FILIAL") //Gestão Corporativa
aTam1 := TamSX3("E2_NUMLIQ")
aTam2 := TamSX3("E2_FORNECE")
aTam3 := TamSX3("E2_LOJA")
nTamLiq :=	LEN(STR0004) + aTam1[1] + aTam2[1] + aTam3[1] + 15 //"LIQUIDACAO : "

nTamCHQ := 2 // considerar os 2 tracos
aTamCHQ := TamSX3("E2_BCOCHQ")
nTamCHQ += aTamCHQ[1]
aTamCHQ := TamSX3("E2_AGECHQ")
nTamCHQ += aTamCHQ[1]
aTamCHQ := TamSX3("E2_CTACHQ")
nTamCHQ += aTamCHQ[1]
nTam0 := Len(STR0035) + aTam0[1] //Gestão Corporativa

__cAliasTrb := GetNextAlias()

oSection0 := TRSection():New(oReport,"",{__cAliasTrb,"SE2"},) //Gestão Corporativa
TRCell():New(oSection0,"FILIAL",,,,nTam0,.F.,) //Gestão Corporativa

oSection1 := TRSection():New(oSection0,STR0005,{__cAliasTrb,"SE2"},)//"No. da Liquidação"
TRCell():New(oSection1,"LIQUIDA" ,,STR0005,,nTamLiq,.F.,)//"No. da Liquidação"

oSection0:SetHeaderSection(.F.) //Gestão Corporativa
oSection1:SetHeaderSection(.F.)

nTamStat := 15

oSection11 := TRSection():New(oSection1,STR0006,{__cAliasTrb,"SE2"},) // "Titulos Liquidados"
TRCell():New(oSection11,"E2_PREFIXO" ,"SE2",STR0007,,,.F.,)  //"PRF"
TRCell():New(oSection11,"E2_NUM" ,"SE2",STR0008,,,.F.,)  //"NUMERO"
TRCell():New(oSection11,"E2_PARCELA" ,"SE2",STR0009,,,.F.,)  //"PARCELA"
TRCell():New(oSection11,"E2_TIPO" ,"SE2",STR0010,,,.F.,)  //"TIPO"
TRCell():New(oSection11,"E2_EMISSAO" ,"SE2",STR0011,,12,.F.,)  //"EMISSAO"
TRCell():New(oSection11,"VALOR",,STR0013,"@E 9,999,999,999.99",16,.F.,)  //"VALOR"
TRCell():New(oSection11,"JUROS",,STR0014,"@E 9,999,999.99",12,.F.,)  //"JUROS"
TRCell():New(oSection11,"DESCONTOS",,STR0015,"@E 9,999,999.99",12,.F.,)  //"DESCONTOS"
TRCell():New(oSection11,"ACESSORIO",,STR0036,"@E 9,999,999.99",12,.F.,)  //"Vlr. Acessorio"
TRCell():New(oSection11,"E2_BCOCHQ" ,"SE2",STR0016+"-"+STR0017+"-"+STR0018,,nTamCHQ,.F.,)  //"BANCO"##"AGENCIA"##"CONTA"
TRCell():New(oSection11,"STATUS" ,,STR0029,,nTamStat,.F.,)  //"STATUS"

/*
GESTAO - inicio
Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SE2","SE5"})
TRCell():New(oSecFil,"CODFIL" ,,STR0030,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0031,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0032,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0033,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"
/* GESTAO - fim
*/

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³10.07.06	³±±
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
Local oSection0  := oReport:Section(1)
Local oSection1  := oReport:Section(1):Section(1)
Local oSection11 := oReport:Section(1):Section(1):Section(1)
Local cAlias1 := GetNextAlias()
Local cAlias2 := GetNextAlias()
Local cWhere := ""
Local aCampos:={}
Local aTam:={}
Local nTaxa		:= 1
Local nValor	:= 0
Local lParcial	:= .F.
Local cChvTit	:= ""
Local nJurDesc	:= 0
//Gestao
Local cLayout   := FWSM0Layout()
Local lGestao	:= "E" $ cLayout .Or. "U" $ cLayout
Local lSE2Excl  := Iif( lGestao, FWModeAccess("SE2",1) == "E", FWModeAccess("SE2",3) == "E")
Local lSE5Excl  := Iif( lGestao, FWModeAccess("SE5",1) == "E", FWModeAccess("SE5",3) == "E")
Local aTmpFil	:= {}
Local cTmpSE2Fil := ""
Local cTmpSE5Fil := ""
Local nX 		:= 0
Local oSecFil	:= oReport:Section("SECFIL")
Local cFilSE2	:= ""
Local cFilSE5	:= ""
Local nRegSM0	:= SM0->(Recno())
Local aSelFil := {}
Local cRngFilSE2 := NIL
Local cRngFilSE5 := NIL
Local cFilSel := ""
local nTamLiq := TamSx3("E2_NUMLIQ")[1]
Local lFilOrig	:= getComp("SE2")=="CCC"
Local aRetAuto As Array

aRetAuto := {} //Array utilizado no teste automatizado 

Fr502MotBx("LIQ","LIQUIDACAO","ANSS")// Cria motivo de baixa LIQ 

//Gestao
//Selecao de filiais
nRegSM0 := SM0->(Recno())
If mv_par08 == 1 .And. !IsBlind() 
	AdmSelecFil("FIN502",8,.F.,@aSelFil,"SE2",.F.)
Else
	If FindFunction("GetParAuto")
		aRetAuto := GetParAuto("FINR502TestCase") 
		aSelFil  := aRetAuto
	EndIf
EndIf

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

cRngFilSE2 := GetRngFil( aSelFil, "SE2", .T., @cTmpSE2Fil, NIL, lFilOrig )
aAdd(aTmpFil, cTmpSE2Fil)

cRngFilSE5 := GetRngFil( aSelFil, "SE5", .T., @cTmpSE5Fil, NIL, lFilOrig )
aAdd(aTmpFil, cTmpSE5Fil)

SM0->(DbGoTo(nRegSM0))

If Len(aSelFil) > 1
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0034 + ")")		//"Filiais selecionadas para o relatorio"
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

cFilSE2 := if(lFilOrig," E2_FILORIG "," E2_FILIAL ") + cRngFilSE2 + " AND "
cFilSE2 := "%" + cFilSE2 + "%"

cFilSE5 := " E5_FILIAL " + cRngFilSE5 + " AND "
cFilSE5 := "%" + cFilSE5 + "%"

cWhere := " AND E5_DOCUMEN >= '"+ PADR(mv_par01,TamSx3("E5_DOCUMEN")[1]) + "' "
cWhere += " AND E5_DOCUMEN <= '"+ PADR(mv_par02,TamSx3("E5_DOCUMEN")[1]) + "' "
cWhere += " AND E5_DOCUMEN <> '"+ Space(TamSx3("E5_DOCUMEN")[1]) + "' "
cWhere := "%" + cWhere + "%"

//baixado
if lFilOrig
	BeginSql Alias cAlias1
	
		SELECT SE5.*
		FROM %table:SE5% SE5
		JOIN %table:FI8% FI8
			ON E5_FILIAL = FI8_FILIAL
			AND E5_PREFIXO = FI8_PRFORI
			AND E5_NUMERO = FI8_NUMORI
			AND E5_PARCELA = FI8_PARORI
			AND E5_TIPO = FI8_TIPORI
			AND E5_CLIFOR = FI8_FORORI
			AND E5_LOJA = FI8_LOJORI
			AND FI8.%notDel%
		JOIN %table:SE2% SE2
			ON FI8_FILDES = E2_FILIAL
			AND FI8_PRFDES = E2_PREFIXO
			AND FI8_NUMDES = E2_NUM
			AND FI8_PARDES = E2_PARCELA
			AND FI8_TIPDES = E2_TIPO
			AND FI8_FORDES = E2_FORNECE
			AND FI8_LOJDES = E2_LOJA
			AND SE2.%notDel%
		WHERE %exp:cFilSE2%
				E5_CLIFOR >= %exp:MV_PAR03% AND
				E5_CLIFOR <= %exp:MV_PAR04% AND
				E5_MOTBX = 'LIQ' AND
				E5_SITUACA <> 'C' AND
				E5_RECPAG = 'P' AND
				E5_TIPODOC = 'BA' AND
				SE5.%NotDel%
				%Exp:cWhere%

	EndSQL
else
	BeginSql Alias cAlias1
		//column E2_VENCREA as Date
		SELECT SE5.*
		FROM %table:SE5% SE5
		WHERE %exp:cFilSE5%
				E5_CLIFOR >= %exp:mv_par03% AND
				E5_CLIFOR <= %exp:mv_par04% AND
				E5_MOTBX = 'LIQ' AND
				E5_SITUACA <> 'C' AND
				E5_RECPAG = 'P' AND
				E5_TIPODOC = 'BA' AND
				SE5.%NotDel%
				%exp:cWhere%
	EndSQL
endIf

cWhere := " AND E2_NUMLIQ <> '"+ Space(TamSx3("E2_NUMLIQ")[1]) + "'"
cWhere := "%" + cWhere + "%"

//gerado SE2
BeginSql Alias cAlias2
	column E2_EMISSAO as Date
	SELECT SE2.*
	FROM %table:SE2% SE2
	WHERE %exp:cFilSE2%
			E2_FORNECE >= %exp:mv_par03% AND
			E2_FORNECE <= %exp:mv_par04% AND
			E2_NUMLIQ >=  %exp:mv_par01% AND
			E2_NUMLIQ <= %exp:mv_par02% AND
			(E2_BCOCHQ <> ' ' OR E2_TIPO = 'NCC') AND
			SE2.%NotDel%
			%exp:cWhere%
EndSQL

aTam:=TamSX3("E2_FILIAL")
Aadd(aCampos,{"FILIAL","C",aTam[1],aTam[2]})
aTam:=TamSX3("E2_FORNECE")
AADD(aCampos,{"FORNECEDOR" ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("E2_LOJA")
AADD(aCampos,{"LOJA"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("E2_NUMLIQ")
AADD(aCampos,{"NUMLIQ" ,"C",aTam[1],aTam[2]})
AADD(aCampos,{"PREFIXO","C",3,0})
aTam:=TamSX3("E2_NUM")
AADD(aCampos,{"NUMTIT" ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("E2_PARCELA")
AADD(aCampos,{"PARCELA","C",aTam[1],aTam[2]})
aTam:=TamSX3("E2_TIPO")
AADD(aCampos,{"TIPO"   ,"C",aTam[1],aTam[2]})
AADD(aCampos,{"MOEDA"  ,"N",2,0})
aTam:=TamSX3("E2_EMISSAO")
AADD(aCampos,{"EMISSAO","D",aTam[1],aTam[2]})
AADD(aCampos,{"VALOR"  ,"N",18,2})
AADD(aCampos,{"JUROS"  ,"N",18,2})
AADD(aCampos,{"DESCONT","N",18,2})
aTam:=TamSX3("E2_BCOCHQ")
AADD(aCampos,{"BANCO","C",aTam[1],aTam[2]})
aTam:=TamSX3("E2_AGECHQ")
AADD(aCampos,{"AGENCIA","C",aTam[1],aTam[2]})
aTam:=TamSX3("E2_CTACHQ")
AADD(aCampos,{"CONTA","C",aTam[1],aTam[2]})
AADD(aCampos,{"BG"     ,"C", 1,0}) // Baixado ou Gerado
AADD(aCampos,{"TIPOBX"  ,"C",1,0})
AADD(aCampos,{"IDORIG"  ,"C",50,0})

//------------------
//Criação da tabela temporaria 
//------------------
If _oFIRN5021 <> Nil
	_oFIRN5021:Delete()
	_oFIRN5021 := Nil
Endif

_oFIRN5021 := FWTemporaryTable():New( __cAliasTrb )  
_oFIRN5021:SetFields(aCampos) 	
_oFIRN5021:AddIndex("1", {"FILIAL","NUMLIQ","BG","PREFIXO","NUMTIT","PARCELA","TIPO","FORNECEDOR","LOJA"}) 	
_oFIRN5021:Create()	

// Titulos Gerados na liquidacao - SE2
If mv_par05 != 2
	While (cAlias2)->(!Eof())
		If MV_PAR06 <> 1
			DbSelectArea( "SM2" )
			SM2->( DbSetOrder( 1 ) )
			If SM2->( DbSeek( DtoS( IIf( MV_PAR06 == 2, DDATABASE, (cAlias2)->E2_EMISSAO ) ) ) )
				If FieldPos( "M2_MOEDA" + cValToChar(MV_PAR07) ) > 0
					nTaxa := SM2->&( "M2_MOEDA" + cValToChar(MV_PAR07) )
				EndIf
			EndIf
		EndIf

		DBSelectArea(__cAliasTrb)
		RecLock(__cAliasTrb,.T.)
		(__cAliasTrb)->FILIAL		:= (cAlias2)->E2_FILIAL
		(__cAliasTrb)->FORNECEDOR	:= (cAlias2)->E2_FORNECE
		(__cAliasTrb)->LOJA			:= (cAlias2)->E2_LOJA
		(__cAliasTrb)->NUMLIQ		:= (cAlias2)->E2_NUMLIQ
		(__cAliasTrb)->PREFIXO		:= (cAlias2)->E2_PREFIXO
		(__cAliasTrb)->NUMTIT		:= (cAlias2)->E2_NUM
		(__cAliasTrb)->PARCELA		:= (cAlias2)->E2_PARCELA
		(__cAliasTrb)->TIPO			:= (cAlias2)->E2_TIPO
		(__cAliasTrb)->EMISSAO		:= (cAlias2)->E2_EMISSAO
		(__cAliasTrb)->VALOR		:= iif( MV_PAR06 == 1, (cAlias2)->E2_VALOR, xMoeda((cAlias2)->E2_VALOR,(cAlias2)->E2_MOEDA,Iif(ValType(MV_PAR07) != "N",Val(MV_PAR07),MV_PAR07), IIf( MV_PAR06 == 2, DDATABASE, (cAlias2)->E2_EMISSAO ) ) )
		(__cAliasTrb)->JUROS		:= (cAlias2)->E2_ACRESC
		(__cAliasTrb)->BANCO		:= (cAlias2)->E2_BCOCHQ
		(__cAliasTrb)->AGENCIA		:= (cAlias2)->E2_AGECHQ
		(__cAliasTrb)->CONTA		:= (cAlias2)->E2_CTACHQ		
		(__cAliasTrb)->BG			:= "G"	// Gerado
		(__cAliasTrb)->TIPOBX		:= ""
		MsUnlock()
		(cAlias2)->(dbSkip())
	Enddo
Endif

// Titulos Baixados na liquidacao
If mv_par05 != 3
	While (cAlias1)->(!Eof())
		If MV_PAR06 <> 1
			DbSelectArea( "SM2" )
			SM2->( DbSetOrder( 1 ) )
			If SM2->( DbSeek( IIf( MV_PAR06 == 2, DtoS( DDATABASE ), (cAlias1)->E5_DATA ) ) )
				If FieldPos( "M2_MOEDA" + cValToChar(MV_PAR07) ) > 0
					nTaxa := SM2->&( "M2_MOEDA" + cValToChar(MV_PAR07))
				EndIf
			EndIf
		EndIf

		SE2->(dbSetOrder(6))//E2_FILIAL+E2_FORNECE+E2_LOJA+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO
		SE2->(MsSeek(xFilial("SE2",(cAlias1)->E5_FILORIG)+(cAlias1)->(E5_CLIFOR+E5_LOJA+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))

		DBSelectArea(__cAliasTrb)
		RecLock(__cAliasTrb,.T.)
		(__cAliasTrb)->FILIAL		:= (cAlias1)->E5_FILIAL
		(__cAliasTrb)->FORNECEDOR	:= (cAlias1)->E5_CLIFOR
		(__cAliasTrb)->LOJA			:= (cAlias1)->E5_LOJA
		(__cAliasTrb)->NUMLIQ		:= Substr((cAlias1)->E5_DOCUMEN,1,nTamLiq)
		(__cAliasTrb)->PREFIXO		:= (cAlias1)->E5_PREFIXO
		(__cAliasTrb)->NUMTIT		:= (cAlias1)->E5_NUMERO
		(__cAliasTrb)->PARCELA		:= (cAlias1)->E5_PARCELA
		(__cAliasTrb)->TIPO			:= (cAlias1)->E5_TIPO
		(__cAliasTrb)->EMISSAO		:= SE2->E2_EMISSAO
		nValor 	:= iif( MV_PAR06 == 1, SE2->E2_VALOR, xMoeda( SE2->E2_VALOR, SE2->E2_MOEDA,Iif(ValType(MV_PAR07) != "N",Val(MV_PAR07),MV_PAR07), IIf( MV_PAR06 == 2, DDATABASE, SE2->E2_EMISSAO ) ) )
		(__cAliasTrb)->VALOR		:= nValor
		(__cAliasTrb)->JUROS		:= (cAlias1)->E5_VLJUROS
		(__cAliasTrb)->DESCONT		:= (cAlias1)->E5_VLDESCO		
		(__cAliasTrb)->BG			:= "B"	// Baixado
		If (cAlias1)->E5_SITUACA <> 'C' .AND. (cAlias1)->E5_MOTBX == 'LIQ'
			(__cAliasTrb)->IDORIG		:= (cAlias1)->E5_IDORIG
		EndIF

		//Verifica Baixas Parciais
		cChvTit  := xFilial("SE5",(cAlias1)->E5_FILORIG)+(cAlias1)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR)
		nJurDesc := (cAlias1)->E5_VLJUROS + (cAlias1)->E5_VLDESCO

		aAreaSE5 := SE5->(GetArea())
		dbSelectArea("SE5")
		SE5->(dbSetOrder(7))

		If SE5->(MsSeek(cChvTit))
			While SE5->( !EoF() .And. E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR == cChvTit )
				If SE5->E5_TIPODOC == "BA"		.And.;
				   ! SE5->E5_SITUACA $ "C,E,X"	.And.;
				   nValor > (SE5->E5_VALOR - nJurDesc)
				   If SE2-> E2_SALDO != 0
						lParcial := .T.
						Exit
					EndIf
				Endif
				SE5->(dbSkip())
			Enddo
		Endif

		If lParcial
			(__cAliasTrb)->TIPOBX := "P" //Parcial
		Else
			(__cAliasTrb)->TIPOBX := "T" //Total
		Endif
		(__cAliasTrb)->( MsUnlock() )

		lParcial := .F.

		SE5->(RestArea(aAreaSE5))

		(cAlias1)->(dbSkip())
	Enddo
Endif

oReport:SetPageFooter(4,{|| If(!oSection11:Printing(),F502Legenda(oReport),"")})

If (lSE2Excl .and. lSE5Excl .and. mv_par08 == 1) .or.;
   (!lSE2Excl .and. lSE5Excl .and. mv_par08 == 1)
	oSection1:SetParentFilter({|cParam| (__cAliasTrb)->FILIAL == cParam},{|| (__cAliasTrb)->FILIAL })
EndIf

If (lSE2Excl .and. lSE5Excl .and. mv_par08 == 1) .or.;
   (!lSE2Excl .and. lSE5Excl .and. mv_par08 == 1)
	oSection0:Cell("FILIAL"):SetBlock({|| STR0035 + (__cAliasTrb)->FILIAL})
EndIf

oSection1:Cell("LIQUIDA"):SetBlock( {|| STR0004 + (__cAliasTrb)->NUMLIQ + "-" + (__cAliasTrb)->FORNECEDOR + "-" + (__cAliasTrb)->LOJA + " - " + STR0020}) //"LIQUIDACAO : "##"A Pagar"
TRPosition():New( oSection1, "SA2", 1, {|| xFilial("SA2") + (__cAliasTrb)->FORNECEDOR + (__cAliasTrb)->LOJA   })
TRPosition():New( oSection11, "SE2", 1, {|| xFilial("SE2") + (__cAliasTrb)->PREFIXO + (__cAliasTrb)->NUMTIT + (__cAliasTrb)->PARCELA + (__cAliasTrb)->TIPO + (__cAliasTrb)->FORNECEDOR + (__cAliasTrb)->LOJA}) 

oSection11:Cell("E2_PREFIXO"):SetBlock(	{|| (__cAliasTrb)->PREFIXO })
oSection11:Cell("E2_NUM"):SetBlock(			{|| (__cAliasTrb)->NUMTIT })
oSection11:Cell("E2_PARCELA"):SetBlock(	{|| (__cAliasTrb)->PARCELA })
oSection11:Cell("E2_TIPO"):SetBlock(		{|| (__cAliasTrb)->TIPO })
oSection11:Cell("E2_EMISSAO"):SetBlock(	{|| (__cAliasTrb)->EMISSAO })
oSection11:Cell("VALOR"):SetBlock(			{|| (__cAliasTrb)->VALOR })
oSection11:Cell("JUROS"):SetBlock(			{|| (__cAliasTrb)->JUROS })
oSection11:Cell("DESCONTOS"):SetBlock(		{|| (__cAliasTrb)->DESCONT })
oSection11:Cell("ACESSORIO"	):SetBlock(	{|| CalcVA((__cAliasTrb)->PREFIXO , (__cAliasTrb)->NUMTIT , (__cAliasTrb)->PARCELA , (__cAliasTrb)->TIPO , (__cAliasTrb)->FORNECEDOR , (__cAliasTrb)->LOJA, (__cAliasTrb)->IDORIG) })
oSection11:Cell("E2_BCOCHQ"):SetBlock(		{|| If (Empty((__cAliasTrb)->(BANCO+AGENCIA+CONTA))," ", (__cAliasTrb)->BANCO+"-"+(__cAliasTrb)->AGENCIA+"-"+(__cAliasTrb)->CONTA) })
oSection11:Cell("STATUS"):SetBlock(			{|| If((__cAliasTrb)->BG == "B",Iif((__cAliasTrb)->TIPOBX == "P",STR0021,STR0022),STR0023) })//"Baixa Parc. "##"Baixado"##"Gerado"

//Faz o alinhamento do cabecalho das celulas
oSection11:Cell("E2_PREFIXO"):SetHeaderAlign("CENTER")
oSection11:Cell("E2_NUM" 	):SetHeaderAlign("CENTER")
oSection11:Cell("E2_PARCELA"):SetHeaderAlign("CENTER")
oSection11:Cell("E2_TIPO"	):SetHeaderAlign("CENTER")
oSection11:Cell("E2_EMISSAO"):SetHeaderAlign("CENTER")
oSection11:Cell("VALOR"		):SetHeaderAlign("RIGHT")
oSection11:Cell("JUROS" 	):SetHeaderAlign("RIGHT")
oSection11:Cell("ACESSORIO" ):SetHeaderAlign("RIGHT")
oSection11:Cell("DESCONTOS"	):SetHeaderAlign("RIGHT")
oSection11:Cell("E2_BCOCHQ"	):SetHeaderAlign("RIGHT")
oSection11:Cell("STATUS" 	):SetHeaderAlign("LEFT")

oSection11:SetHeaderPage(.T.)

oSection11:SetParentFilter({|cParam| (__cAliasTrb)->(NUMLIQ+FORNECEDOR+LOJA) == cParam},{|| (__cAliasTrb)->(NUMLIQ+FORNECEDOR+LOJA)})

TRFunction():New(oSection11:Cell("VALOR")		,"T_VAL" ,"SUM",,Iif(mv_par05 == 1,STR0024,STR0025),,{|| If(mv_par05==1,If((__cAliasTrb)->BG=="G",(__cAliasTrb)->VALOR,Iif((__cAliasTrb)->JUROS>0,(__cAliasTrb)->JUROS*(-1),0)), (__cAliasTrb)->VALOR) },.T.,.F.) //"Total Liq. "##"Totais "
TRFunction():New(oSection11:Cell("JUROS")		,"T_JUR" ,"SUM",,Iif(mv_par05 == 1,STR0024,STR0025),,,.T.,.F.)//"Total Liq. "##"Totais "
TRFunction():New(oSection11:Cell("DESCONTOS") 	,"T_DESC" ,"SUM",,Iif(mv_par05 == 1,STR0024,STR0025),,,.T.,.F.)//"Total Liq. "##"Totais "
TRFunction():New(oSection11:Cell("ACESSORIO")	,"T_ACES" ,"SUM",,Iif(mv_par05 == 1,STR0024,STR0025),,,.T.,.F.)//"Total Liq. "##"Totais "

oSection11:SetTotalInLine(.F.)
oSection11:SetTotalText(Iif(mv_par05 == 1,STR0024,STR0025)) //"Total Liq. "##"Totais "
oSection0:Print()

(__cAliasTrb)->(dbCloseArea())
__cAliasTrb := ""

//Deleta tabela temporária no banco de dados
If _oFIRN5021 <> Nil
	_oFIRN5021:Delete()
	_oFIRN5021 := Nil
Endif

//Gestao
//Apagar o arquivo temporario de filiais criados no banco
For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])
Next

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³FR502MotBXºAutor  ³Marcelo Celi Marquesº Data ³  23/01/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao criar automaticamente o motivo de baixa LIQ na      º±±
±±º          ³ tabela Mot baixas                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR502                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fr502MotBx(cMot,cNomMot, cConfMot)
	Local lMotBxEsp	:= .F.
	Local aMotbx 	:= ReadMotBx(@lMotBxEsp)
	Local nHdlMot	:= 0
	Local I			:= 0
	Local cFile 	:= "SIGAADV.MOT"
	Local nTamLn	:= 19

	If __lMotInDb == Nil
		__lMotInDb := AliasInDic("F7G")
	Endif
	If !__lMotInDb
		If lMotBxEsp
			nTamLn	:= 20
			cConfMot	:= cConfMot + "N"
		EndIf
		If ExistBlock("FILEMOT")
			cFile := ExecBlock("FILEMOT",.F.,.F.,{cFile})
		Endif

		If Ascan(aMotbx, {|x| Substr(x,1,3) == Upper(cMot)}) < 1
			nHdlMot := FOPEN(cFile,FO_READWRITE)
			If nHdlMot <0
				HELP(" ",1,"SIGAADV.MOT")
				Final("SIGAADV.MOT")
			Endif

			nTamArq:=FSEEK(nHdlMot,0,2)	// VerIfica tamanho do arquivo
			FSEEK(nHdlMot,0,0)			// Volta para inicio do arquivo

			For I:= 0 to  nTamArq step nTamLn // Processo para ir para o final do arquivo
				xBuffer:=Space(nTamLn)
				FREAD(nHdlMot,@xBuffer,nTamLn)
	    	Next

			fWrite(nHdlMot,cMot+cNomMot+cConfMot+chr(13)+chr(10))
			fClose(nHdlMot)
		EndIf
	Endif

	FwFreeArray(aMotBx)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F502LegendaºAutor  ³Microsiga           º Data ³  06/02/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Legenda do relatorio.                                       º±±
±±º          ³                                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F502Legenda(oReport)

oReport:PrintText(STR0026)//"Observações: "
oReport:PrintText(STR0027)//"- Os títulos baixados são impressos com o valor original, independente da forma da baixa. "
oReport:PrintText(STR0028)//"- Os totalizadores consideram o valor total da liquidação ou dos títulos gerados/baixados."

Return

//----------------------------------------------------------------------------
/*/{Protheus.doc} CalcVA
Função responsavel por somar os valores acessorios de acordo com a FxLoadFK6

@author Marcos Gomes
@since 24/07/2018
@param cPrefixo
@param cNum
@param cParcela
@param cTipo
@param cCliente
@param cLoja
@param cIdOrig
@return nValorAce - Valor acessorio calculado
/*/
//----------------------------------------------------------------------------
Static Function CalcVA(cPrefixo,cNum,cParcela,cTipo,cFornece,cLoja,cIDORIG)

	Local nValorAces As Numeric 
	Local lFxLoadFK6 As Logical 

	Default cPrefixo := ""
	Default cNum := ""
	Default cParcela := ""
	Default cTipo := ""
	Default cFornece := ""
	Default cLoja := ""
	Default cIDORIG := ""
		
	nValorAces	:= 0
	lFxLoadFK6	:= ExistFunc('FxLoadFK6')

	aAreaSE5 := SE5->(GetArea())

	DbSelectArea("SE5")
	SE5->( dbGoTop() ) 	
	DBSetOrder(21) //E5_FILIAL,E5_IDORGI		
		
	If DBSeek(xFilial("SE5") + cIDORIG )
		nValorAces += ( IIf(lFxLoadFK6, FxLoadFK6("FK2",SE5->E5_IDORIG,"VA")[1,2], 0) )
	EndIf
		
	RestArea( aAreaSE5 )
	
Return nValorAces

/*/{Protheus.doc} getComp
	Retorna string de três posições indicando o comportilhamento da tabela em questão, 
	sendo as posições na ordem: EMPRESA, UNIDADE, FILIAL
	@type  Function
	@author guilherme.sordi
	@since 03/03/2022
	@version 12.1.33
	@param cAlias, character, Alias da tabela em questão
	@return cComp, character, String indicando o compartilhamento. Exemplos: EEE, EEC, CCC
/*/
static function getComp(cAlias as character) as character
	local cComp as character
	local lQuery as logical

	if cAlias == NIL
		return ""
	endIf

	lQuery := .T.
	aComp := FwSX2Util():GetSX2Data(cAlias, {"X2_MODOEMP", "X2_MODOUN", "X2_MODO"}, lQuery)
	cComp := aComp[1][2] + aComp[2][2] + aComp[3][2]
return cComp
