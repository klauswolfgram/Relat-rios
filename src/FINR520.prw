/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR520.CH"
#INCLUDE "PROTHEUS.CH"

Static __oRecEST  := NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR520  ³ Autor ³ Daniel Tadashi Batori ³ Data ³ 14.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Compensacoes entre carteiras                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR520(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FinR520()

Local oReport
Private cTitulo := STR0003

oReport := ReportDef()
oReport:PrintDialog()



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 14.07.06 ³±±
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
Local oSection11
Local aTam1
Local nTamIden
Local nTamData
Local nTamSitu
Local nTamPref As Numeric
Local nTamNum  As Numeric	
Local cPictTit As Char
Local oFilial //Gestão Corporativa
Local oSecFil //Gestão Corporativa

pergunte("AFI520",.F.)

oReport := TReport():New("FINR520",cTitulo,"AFI520",;
{|oReport| ReportPrint(oReport)},STR0001+STR0002)

oReport:SetLandScape(.T.)

aTam1		:= TamSX3("E5_IDENTEE")
nTamIden	:=	LEN(STR0007) + aTam1[1]
nTamData	:=	LEN(STR0012) + 10
nTamSitu	:=	LEN(STR0008)
nTamPref	:=	TAMSX3("E5_PREFIXO")[1] + 1
nTamNum		:=	TAMSX3("E5_NUMERO")[1] + 5

oSection1 := TRSection():New(oReport,STR0026,{"SE5"},)
TRCell():New(oSection1,"IDENTEE" ,,,,nTamIden,.F.,)  //definido por SetBlock
TRCell():New(oSection1,"DATA" ,,,,nTamData,.F.,)  //definido por SetBlock
TRCell():New(oSection1,"SITUACA" ,,,,nTamSitu,.F.,)  //definido por SetBlock

oSection1:SetHeaderSection(.F.)

aTam1	:= TamSX3("E5_CLIFOR")
aTam2	:= TamSX3("E5_LOJA")
aTam3	:= TamSX3("A1_NREDUZ")
nTam	:=	aTam1[1] + aTam2[1] + aTam3[1] + 2
cPictTit:= PesqPict("SE1","E1_VALOR")

oSection11 := TRSection():New(oSection1,STR0027,{"SE5","SE1"},)
TRCell():New(oSection11,"E5_PREFIXO" ,"SE5",STR0015,,nTamPref,.F.,)  //"PRF"
TRCell():New(oSection11,"E5_NUMERO","SE5",STR0016,,nTamNum,.F.,)  //"NUMERO"
TRCell():New(oSection11,"E5_PARCELA" ,"SE5",STR0017,,,.F.,)  //"PC"
TRCell():New(oSection11,"E5_TIPO" ,"SE5",STR0018,,,.F.,)  //"TIPO"
TRCell():New(oSection11,"E5_CLIFOR","SE5",STR0019,,nTam,.F.,)  //"CLIENTE/FORNECEDOR"
TRCell():New(oSection11,"VLRCOMP","",STR0028,,25,.F.,)  //"VALOR DO COMPENSADO"
TRCell():New(oSection11,"E1_VALOR","SE1",STR0020,cPictTit,25,.F.,)  //"VALOR DO TITULO"
TRCell():New(oSection11,"E5_VLJUROS","SE5",STR0021,,,.F.,)  //"JUROS"
TRCell():New(oSection11,"E5_VLMULTA","SE5",STR0022,,,.F.,)  //"MULTA"
TRCell():New(oSection11,"E5_VLDESCO","SE5",STR0023,,,.F.,)  //"DESCONTO"
TRCell():New(oSection11,"VALACESS","",STR0036,"@E 999,999,999.99",,.F.,)  //"VALOR ACESSÓRIO"
TRCell():New(oSection11,"E5_VALOR","SE5",STR0024,cPictTit,25,.F.,)  //"COMPENSADO"
TRCell():New(oSection11,"E5_RECPAG","SE5",STR0025,,4,.F.,)  //"P/R"

oSection11:Cell("VLRCOMP"	 ):SetHeaderAlign("RIGHT")
oSection11:Cell("E1_VALOR"	 ):SetHeaderAlign("RIGHT")
oSection11:Cell("E5_VLJUROS"):SetHeaderAlign("RIGHT")
oSection11:Cell("E5_VLMULTA"):SetHeaderAlign("RIGHT")
oSection11:Cell("E5_VLDESCO"):SetHeaderAlign("RIGHT")
oSection11:Cell("VALACESS"):SetHeaderAlign("CENTER")
oSection11:Cell("E5_VALOR"):SetHeaderAlign("RIGHT")

oSection11:SetHeaderPage(.T.)		//Define o cabecalho da secao como padrao
oSection11:SetAutoSize(.T.)

//Gestão Corporativa - Início
oFilial := TRSection():New(oReport,"",{"SE5"})
TRCell():New(oFilial,"Filial",,,,TamSx3("E5_FILIAL")[1] + Len(STR0029)) //"Filial : "
oFilial:SetHeaderSection(.F.)

oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0030,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0031,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0032,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0033,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

oReport:SetUseGC(.F.)
//Gestão Corporativa - Fim

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
Local oSection1		:= oReport:Section(1)
Local oSection11	:= oReport:Section(1):Section(1)
Local cAliasQry1	:= GetNextAlias()
Local cQuery		:= ""
Local nTamId		:= TAMSX3("E5_IDENTEE")[1]
Local cChave		:= "E5_FILIAL+E5_IDENTEE+E5_RECPAG+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO"
Local cNomeCF		:= ""
Local nTotGeral		:= {{0,0,0,0,0,""},{0,0,0,0,0,""}}
Local nValTitulo	:= 0
Local nValJUROS		:= 0
Local nValMULTA		:= 0
Local nValDESCO		:= 0
Local nValVALOR		:= 0
Local nVa			:= 0
Local nTotSec		:= 0
Local nTit			:= 0
Local nTitRel		:= 0
Local cPictTit		:= ""
Local nTotCmp		:= 0
Local nContAnt		:= 0
//Gestão Corporativa - Início
Local aAreaSE5		:= SE5->(GetArea())
Local aAreaSM0		:= SM0->(GetArea())
Local aArea			:= GetArea()
Local aTmpFil		:= {}
Local cTmpSE5Fil	:= ""
Local cRngFilSE5	:= NIL
Local lGestao		:= AdmGetGest()
Local lSE5Excl		:= Iif( lGestao, FWModeAccess("SE5",1) == "E", FWModeAccess("SE5",3) == "E")
Local cSE5Fil		:= FWModeAccess("SE5",3)
Local cSE5UN		:= FWModeAccess("SE5",2)
Local cSE5Emp		:= FWModeAccess("SE5",1)
Local nX			:= 1
Local nC			:= 1
Local oSecFil		:= oReport:Section("SECFIL")
Local nRegSM0		:= SM0->(Recno())
Local aSelFil		:= {}
Local cUNold		:= ""
Local cEmpOld		:= ""
Local cFilialAnt	:= cFilAnt
Local lPrtFil		:= .T.
Local oFilial		:= oReport:Section(2)
Local cFilSE5		:= ""
Local nTit2			:= 0
Local nTotSec2		:= 0
//Gestão Corporativa - Fim
Local lFxLoadFK6	:= ExistFunc('FxLoadFK6')
Local lLandsCape 	as Logical

lLandsCape := Iif(oReport:GetOrientation() == 2 ,.T.,.F.)

//Correcao de Base
A520ResCmp()

//Gestão Corporativa - Início
nRegSM0 := SM0->(Recno())

If (lSE5Excl .and. mv_par08 == 1)
	If FindFunction("FwSelectGC") .and. lGestao
		aSelFil := FwSelectGC()
	Else
		aSelFil := AdmGetFil(.F.,.F.,"SE5")
	Endif
Endif

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

If Len(aSelFil) > 1
	SM0->(DbGoTo(nRegSM0))
	cRngFilSE5 := GetRngFil( aSelFil, "SE5", .T., @cTmpSE5Fil )
	aAdd(aTmpFil, cTmpSE5Fil)
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0034 +  ")")	//"Filiais selecionadas para o relatorio"
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
	RestArea(aAreaSM0)
	cFilSE5 := " E5_FILIAL "+ cRngFilSE5 + " AND "
Else
	cFilSE5 := " E5_FILIAL = '"+ xFilial("SE5",aSelFil[1]) + "' AND "
Endif
cFilSE5 := "%"+cFilSE5+"%"

oSection1:BeginQuery()
	If mv_par05 == 3  // Ativas
		cQuery += " AND E5_SITUACA NOT IN ('C','X') "
	ElseIf mv_par05 == 2  // Canceladas
		cQuery += " AND (E5_SITUACA = 'C' OR E5_SITUACA = 'X') "
	Endif

	cQuery += " ORDER BY " + SqlOrder(cChave)
	cQuery := "%" + cQuery + "%"

	BeginSql Alias cAliasQry1
		SELECT  *
		FROM %table:SE5% SE5
		WHERE	%exp:cFilSE5%
				E5_MOTBX = 'CEC' AND
				E5_IDENTEE >= %exp:mv_par01% AND
				E5_IDENTEE <= %exp:mv_par02% AND
				E5_IDENTEE <> %exp:Space(nTamId)% AND
				E5_DATA BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04% AND
				E5_TIPODOC = 'BA' AND
				SE5.%NotDel%
				%Exp:cQuery%
	EndSQL
oSection1:EndQuery()
oSection11:SetParentQuery()

cPictTit := PesqPict("SE1","E1_VALOR")
cTitulo  += " - "+GetMv("MV_MOEDA"+IIf(mv_par06==0,"1",Alltrim(Str(mv_par06,1))))
oReport:SetTitle(cTitulo)

oSection11:SetParentFilter({|cParam| (cAliasQry1)->E5_IDENTEE == cParam},{|| (cAliasQry1)->E5_IDENTEE })

oSection1:Cell("IDENTEE"):SetBlock( { || STR0007 + (cAliasQry1)->E5_IDENTEE })
oSection1:Cell("DATA"):SetBlock( { || STR0012 + DTOC((cAliasQry1)->E5_DATA) })
oSection1:Cell("SITUACA"):SetBlock( { || If((cAliasQry1)->E5_SITUACA=="C", STR0008, If((cAliasQry1)->E5_SITUACA=="X",STR0014,nil)) })

oSection11:Cell("E5_PREFIXO"):SetBlock(	{ || (cAliasQry1)->E5_PREFIXO })
oSection11:Cell("E5_NUMERO") :SetBlock(	{ || (cAliasQry1)->E5_NUMERO })
oSection11:Cell("E5_PARCELA"):SetBlock(	{ || (cAliasQry1)->E5_PARCELA })
oSection11:Cell("E5_TIPO")   :SetBlock(	{ || (cAliasQry1)->E5_TIPO })

oSection11:Cell("E5_CLIFOR") :SetBlock(	{ || cNomeCF })
oSection11:Cell("E1_VALOR")  :SetBlock(	{ || nValTitulo })
oSection11:Cell("E5_VLJUROS"):SetBlock(	{ || nValJUROS  })
oSection11:Cell("E5_VLMULTA"):SetBlock(	{ || nValMULTA  })
oSection11:Cell("E5_VLDESCO"):SetBlock(	{ || nValDESCO  })
oSection11:Cell("VALACESS"):SetBlock({||nVa})
oSection11:Cell("E5_VALOR")  :SetBlock(	{ || nValVALOR  })
oSection11:Cell("E5_RECPAG") :SetBlock(	{ || (cAliasQry1)->E5_RECPAG } )

//Totalizadores
If lLandScape
	oReport:SetTotalText({||STR0013 + SPACE(3) + Transform(nTitRel,"@E 999") + STR0010 + SPACE(43)+ Transform(nTotCmp,"@E 9,999,999,999.99")})	
else
	If oReport:nDevice == 6 
		oReport:SetTotalText({||STR0013 + SPACE(1) + Transform(nTitRel,"@E 999") + STR0010 + SPACE(25)+ Transform(nTotCmp,"@E 9,999,999,999.99")})
	else
		oReport:SetTotalText({||STR0013 + SPACE(1) + Transform(nTitRel,"@E 999") + STR0010 + SPACE(29) + Transform(nTotCmp,"@E 9,999,999,999.99")})
	EndIF
EndIf
oReport:SetTotalInLine(.F.)

TRFunction():New(oSection11:Cell("E1_VALOR"),,"SUM",,,,,.F.,)
TRFunction():New(oSection11:Cell("E5_VLJUROS"),,"SUM",,,,,.F.,)
TRFunction():New(oSection11:Cell("E5_VLMULTA"),,"SUM",,,,,.F.,)
TRFunction():New(oSection11:Cell("E5_VLDESCO"),,"SUM",,,,,.F.,)
TRFunction():New(oSection11:Cell("VALACESS"),,"SUM",,,,,.F.,)
TRFunction():New(oSection11:Cell("E5_VALOR"),,"SUM",,,,,.F.,)

SA1->(dbSetOrder(1))
SA2->(dbSetOrder(1))
SE1->(dbSetOrder(1))
SE2->(dbSetOrder(1))

(cAliasQry1)->(dbGoTop())

If Len(aSelFil) > 1
	aSort(aSelFil)
	cFilAnt := aSelFil[nC]
	cUN  := FWUnitBusiness()
	cEmp := FWCodEmp()
	cUNold := cUN
	cEmpOld := cEmp
EndIf

oSection1:Init()
oSection11:Init()

For nC := 1 To Len(aSelFil) Step 1
	nContAnt := nC
	If aSelFil[nC] <> cFilAnt .And. mv_par08 == 1

		If cSE5Emp == "E" .And. cSE5UN == "E" .And. cSE5Fil == "C" .And. mv_par08 == 1
			While cUN == cUNold
				nC += 1
				If nC > Len(aSelFil)
					cUN := ""
				Else
					cFilAnt := aSelFil[nC]
					cUN := FWUnitBusiness()
				EndIf
			EndDo
			nC := nContAnt
		EndIf

		If cSE5Emp == "E" .And. cSE5UN == "C" .And. cSE5Fil == "C" .And. mv_par08 == 1
			While cEmp == cEmpOld
				nC += 1
				If nC > Len(aSelFil)
					cEmp := ""
				Else
					cFilAnt := aSelFil[nC]
					cEmp := FWCodEmp()
				EndIf
			EndDo
			nC := nContAnt
		EndIf

		If cSE5Emp == "C" .And. cSE5UN == "C" .And. cSE5Fil == "C" .And. mv_par08 == 1
			nC := Len(aSelFil) + 1
			Loop
		EndIf

		cFilAnt := aSelFil[nC]
		cUN  := FWUnitBusiness()
		cEmp := FWCodEmp()
		cUNold := cUN
		cEmpOld := cEmp

		SE5->(dbSeek(xFilial("SE5")))

		If SE5->(EOF())
			Loop
		Else
			lPrtFil := .T.
		EndIf
	EndIf
//Gestão Corporativa - Fim

	While !(cAliasQry1)->(Eof()) .And. (cAliasQry1)->E5_FILIAL == xFilial("SE5",aSelFil[nC])

		If (cAliasQry1)->E5_RECPAG == "R"
			SE1->(MsSeek(xFilial("SE1")+(cAliasQry1)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))
			If mv_par07 == 2 .And. SE1->E1_MOEDA != mv_par06
				(cAliasQry1)->(dbSkip())
				Loop
			EndIf
		Else
			SE2->(MsSeek(xFilial("SE2")+(cAliasQry1)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)))
			If mv_par07 == 2 .And. SE2->E2_MOEDA != mv_par06
				(cAliasQry1)->(dbSkip())
				Loop
			EndIf
		Endif

		//Gestão Corporativa - Início
		If lPrtFil
			If mv_par08 == 1
				oReport:SkipLine()
				oFilial:Init()
				oFilial:Cell("Filial"):SetBlock({|| STR0029 + xFilial("SE5")}) //"Filial : "
				oFilial:PrintLine()
				oFilial:Finish()
			EndIf
			lPrtFil := .F.
		EndIf
		//Gestão Corporativa - Fim

		oReport:SkipLine()
		oSection1:PrintLine()
		cIdentAnt := (cAliasQry1)->E5_IDENTEE

		While !(cAliasQry1)->(Eof()) .And. cIdentAnt == (cAliasQry1)->E5_IDENTEE ;
                                         .And. (cAliasQry1)->E5_FILIAL == xFilial("SE5",aSelFil[nC])
            nVa	:= 0
			If (cAliasQry1)->E5_RECPAG == "P"
				If (cAliasQry1)->E5_TIPO $ MVRECANT+"/"+MV_CRNEG
					SA1->(MsSeek(xFilial("SA1")+(cAliasQry1)->(E5_CLIFOR+E5_LOJA)))
					cNomeCF := (cAliasQry1)->E5_CLIFOR+"-"+(cAliasQry1)->E5_LOJA+"-"+SA1->A1_NREDUZ
					SE1->(MsSeek(xFilial("SE1")+(cAliasQry1)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))
					nValTitulo := xMoeda((SE1->E1_VALOR),SE1->E1_MOEDA,MV_PAR06,(cAliasQry1)->E5_data)
				Else
					SA2->(MsSeek(xFilial("SA2")+(cAliasQry1)->(E5_CLIFOR+E5_LOJA)))
					cNomeCF := (cAliasQry1)->E5_CLIFOR+"-"+(cAliasQry1)->E5_LOJA+"-"+SA2->A2_NREDUZ
					SE2->(MsSeek(xFilial("SE2")+(cAliasQry1)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)))
					nValTitulo := xMoeda((SE2->E2_VALOR),SE2->E2_MOEDA,MV_PAR06,(cAliasQry1)->E5_data)
					//------------------------------------
					// Incluido Valor Acessorio CP
					// Marcos Favaro - Totvs Serra do Mar
					nVa	:= IIf( lFxLoadFK6, FxLoadFK6((cAliasQry1)->E5_TABORI,(cAliasQry1)->E5_IDORIG,"VA")[1][2], 0 )

					If mv_par06 > 1
						nVa := xMoeda(nVa,1,MV_PAR06,(cAliasQry1)->E5_data)
					EndIf
					// 17/05/2018
					//------------------------------------
				Endif
			Else
				If (cAliasQry1)->E5_TIPO $ MVPAGANT+"/"+MV_CPNEG
					SA2->(MsSeek(xFilial("SA2")+(cAliasQry1)->(E5_CLIFOR+E5_LOJA)))
					cNomeCF := (cAliasQry1)->E5_CLIFOR+"-"+(cAliasQry1)->E5_LOJA+"-"+SA2->A2_NREDUZ
					SE2->(MsSeek(xFilial("SE2")+(cAliasQry1)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)))
					nValTitulo := xMoeda((SE2->E2_VALOR),SE2->E2_MOEDA,MV_PAR06,(cAliasQry1)->E5_data)
					nVa := xMoeda(nVa,MV_PAR06,SE2->E2_MOEDA,(cAliasQry1)->E5_data)
				Else
					SA1->(MsSeek(xFilial("SA1")+(cAliasQry1)->(E5_CLIFOR+E5_LOJA)))
					cNomeCF := (cAliasQry1)->E5_CLIFOR+"-"+(cAliasQry1)->E5_LOJA+"-"+SA1->A1_NREDUZ
					SE1->(MsSeek(xFilial("SE1")+(cAliasQry1)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))
					nValTitulo := xMoeda((SE1->E1_VALOR),SE1->E1_MOEDA,MV_PAR06,(cAliasQry1)->E5_data)

					nVa	:= IIf( lFxLoadFK6, FxLoadFK6((cAliasQry1)->E5_TABORI,(cAliasQry1)->E5_IDORIG,"VA")[1][2], 0 )

					If mv_par06 > 1
						nVa := xMoeda(nVa,1,MV_PAR06,(cAliasQry1)->E5_data)
					EndIf

				Endif
			Endif

			nTotSec += If((cAliasQry1)->E5_RECPAG == "P",xMoeda(((cAliasQry1)->E5_VALOR),1,MV_PAR06,(cAliasQry1)->E5_data),0)
			nTotCmp += If((cAliasQry1)->E5_RECPAG == "P",xMoeda(((cAliasQry1)->E5_VALOR),1,MV_PAR06,(cAliasQry1)->E5_data),0)
			nTit++

			nValJUROS := xMoeda(((cAliasQry1)->E5_VLJUROS),1,MV_PAR06,(cAliasQry1)->E5_data)
			nValMULTA := xMoeda(((cAliasQry1)->E5_VLMULTA),1,MV_PAR06,(cAliasQry1)->E5_data)
			nValDESCO := xMoeda(((cAliasQry1)->E5_VLDESCO),1,MV_PAR06,(cAliasQry1)->E5_data)
			nValVALOR := xMoeda(((cAliasQry1)->E5_VALOR)  ,1,MV_PAR06,(cAliasQry1)->E5_data)

			nTotGeral[1][1] += nValTitulo
			nTotGeral[1][2] += nValJUROS
			nTotGeral[1][3] += nValMULTA
			nTotGeral[1][4] += nValDESCO
			nTotGeral[1][5] += nValVALOR
			nTotGeral[1][6] := (cAliasQry1)->E5_RECPAG

			nTitRel++

			oSection11:PrintLine()
			(cAliasQry1)->(dbSkip())
		EndDo

		oReport:SkipLine()
		If lLandScape
			oReport:PrintText( STR0009 + cIdentAnt + " -> " +Transform(nTit,"@E 999") + STR0010 + "-" + SPACE(22) + Transform(nTotSec,cPictTit) ) //"Total da Compensação ##### -> #### Títulos			
		Else
			If oReport:nDevice == 6 
				oReport:PrintText( STR0009 + cIdentAnt + " -> " +Transform(nTit,"@E 999") + STR0010 + "-" + SPACE(2) + Transform(nTotSec,cPictTit) ) //"Total da Compensação ##### -> #### Títulos
			else
				oReport:PrintText( STR0009 + cIdentAnt + " -> " +Transform(nTit,"@E 999") + STR0010 + "-" + SPACE(6) + Transform(nTotSec,cPictTit) ) //"Total da Compensação ##### -> #### Títulos
			EndIf
		EndIf

		nTit2 += nTit
		nTotSec2 += nTotSec
		nTit := 0
		nTotSec := 0

		oReport:ThinLine()
		oReport:SkipLine()
	EndDo
	If nTit2 != 0 .And. mv_par08 == 1
		oReport:SkipLine()
		If lLandScape			
			oReport:PrintText( STR0035 + Transform(nTit2,"@E 999") + STR0010 + SPACE(39) + Transform(nTotSec2,cPictTit) ) //"Total Filial:  " #### Títulos
		Else
			If oReport:nDevice == 6 
				oReport:PrintText( STR0035 + Transform(nTit2,"@E 999") + STR0010 + SPACE(19) + Transform(nTotSec2,cPictTit) ) //"Total Filial:  " #### Títulos
			Else
				oReport:PrintText( STR0035 + Transform(nTit2,"@E 999") + STR0010 + SPACE(23) + Transform(nTotSec2,cPictTit) ) //"Total Filial:  " #### Títulos
			EndIF
		EndIf
		nTit2 := 0
		nTotSec2 := 0
		oReport:ThinLine()
	EndIf
Next nC

oReport:SkipLine()
oReport:SkipLine()
oSection11:Finish()
oSection1:Finish()

acFilAnt := cFilialAnt //Gestão Corporativa

//Gestão Corporativa - Início
For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])
Next

RestArea(aAreaSE5)
RestArea(aArea)
//Gestão Corporativa - Fim

Return


//-------------------------------------------------------------------
/*{Protheus.doc} A520ResCmp

Ajuste de base historica para gravação dos campos IDENTEE (SE5)
e IDPROC (FK1 e FK2).

@author Vinicius do Prado
@version 12
@since 16/06/2020
@Obs Possivel retirada apos o release 12.1.27
*/
//-------------------------------------------------------------------
Static Function A520ResCmp()
	Local aAreaAnt  as Array
	Local nTotPagar as Numeric
	Local nTotRec   as Numeric
	Local cQuery    as Character
	Local aRecFK2   as Array
	Local aRecFK1   as Array
	Local aRecSE5   as Array

	aAreaAnt  := GetArea()
	nTotPagar := 0
	nTotRec   := 0
	cQuery    := ""
	aRecFK2   := {}
	aRecFK1   := {}
	aRecSE5   := {}

	cQuery := " SELECT E5_FILIAL, E5_TABORI, E5_IDORIG, E5_SITUACA, R_E_C_N_O_ RECNO FROM " + RetSqlName("SE5")
	cQuery += " WHERE E5_MOTBX = 'CEC' AND "
	cQuery += " E5_IDENTEE = ' ' AND "
	cQuery += " E5_TIPODOC NOT IN ('ES','DC','MT','JR','CM','VA') AND "
	cQuery += " D_E_L_E_T_ = ' ' "

	cQuery := ChangeQuery(cQuery)
	MpSysOpenQuery(cQuery,"E5TRB")

	BEGIN TRANSACTION

		WHILE E5TRB->(!EOF())

			FKA->(DBSetOrder(3))
			FKA->(DBSeek(E5TRB->E5_FILIAL + E5TRB->E5_TABORI + E5TRB->E5_IDORIG))
			
			SE5->(DBSetOrder(21))
			
			aReSE5    := {}
			aRecFK2   := {}
			aRecFK1   := {}
			nTotPagar := 0
			nTotRec	  := 0

			FKA->(DBSetOrder(2))
			FKA->(DBSEEK(FKA->FKA_FILIAL+FKA->FKA_IDPROC))

			While FKA->(!EOF())
				If FKA->FKA_TABORI == 'FK2' .And. nTotRec == 0
					If FK2->(dbseek(FKA->FKA_FILIAL+FKA->FKA_IDORIG))
						If FK2->FK2_MOTBX == 'CEC'

							Aadd(aRecFK2, FK2->(RECNO()))
							nTotPagar += FK2->FK2_VALOR

							If FK2->FK2_TPDOC == 'BA'
								If SE5->(dbseek(FK2->FK2_FILIAL+FK2->FK2_IDFK2))
									Aadd(aReSE5, SE5->(RECNO()))

									If SE5->E5_SITUACA == 'X'
										Aadd(aReSE5, A520GrvEst())
									EndIf
									E5TRB->(dbSkip())
								EndIf
							EndIf
						EndIf
						FKA->(DBSKIP())
					ELSE
						Exit
					ENDIF
				ELSEIF FKA->FKA_TABORI == 'FK1' .And. nTotPagar > 0
					If FK1->(dbseek(FKA->FKA_FILIAL+FKA->FKA_IDORIG))
						
						If nTotRec > nTotPagar
							Exit
						EndIf
						If FK1->FK1_MOTBX == 'CEC'

							Aadd(aRecFK1, FK1->(RECNO()))
							nTotRec += FK1->FK1_VALOR

							If FK1->FK1_TPDOC == 'BA'
								If SE5->(dbseek(FK1->FK1_FILIAL+FK1->FK1_IDFK1))
									Aadd(aReSE5, SE5->(RECNO()))

									If SE5->E5_SITUACA == 'X'
										Aadd(aReSE5, A520GrvEst())
									EndIf
									E5TRB->(dbSkip())
								EndIf
							EndIf

							If nTotRec == nTotPagar
								A520GrvCmp(aReSE5, aRecFK2, aRecFK1)
								Exit
							EndIf
						ENDIF
					ELSE
						Exit
					ENDIF
					FKA->(DBSKIP())
				Else
					Exit
				EndIF
			EndDo
			If nTotPagar == 0 .And. nTotRec == 0
				E5TRB->(dbSkip())
			EndIf
		EndDo

	END TRANSACTION

	If __oRecEST != Nil
		__oRecEST:Destroy()
		__oRecEST := Nil
	Endif

	RestArea(aAreaAnt)

Return Nil


//-------------------------------------------------------------------
/*{Protheus.doc} A520GrvEst

Retorna o recno da tabela SE5 referente ao estorno da compensacao, para
ajuste de base. Utilizada pela função A520ResCmp.

@author Vinicius do Prado
@version 12
@since 16/06/2020
@Obs Possivel retirada apos o release 12.1.27
*/
//-------------------------------------------------------------------
Static Function A520GrvEst() as Numeric
	Local aAreaAnt as Array
	Local nRecSE5  as Numeric
	Local cQuery   as Character

	aAreaAnt := GETAREA()
	nRecSE5  := 0
	cQuery   := ""

	If __oRecEST == Nil
		cQuery := " SELECT R_E_C_N_O_ RECNO FROM " + RetSqlName("SE5")
		cQuery += " WHERE E5_FILIAL = ? AND "
		cQuery += " E5_PREFIXO = ? AND "
		cQuery += " E5_NUMERO  = ? AND "
		cQuery += " E5_PARCELA = ? AND "
		cQuery += " E5_TIPO    = ? AND "
		cQuery += " E5_CLIFOR  = ? AND "
		cQuery += " E5_LOJA    = ? AND "
		cQuery += " E5_SEQ     = ? AND "
		cQuery += " E5_MOTBX   = 'CEC' AND "
		cQuery += " E5_TIPODOC = 'ES' AND "
		cQuery += " D_E_L_E_T_ = ' ' "

		cQuery := ChangeQuery(cQuery)
		__oRecEST := FWPreparedStatement():New(cQuery)
	EndIF	

	__oRecEST:SetString(1,SE5->E5_FILIAL)
	__oRecEST:SetString(2,SE5->E5_PREFIXO)
	__oRecEST:SetString(3,SE5->E5_NUMERO)
	__oRecEST:SetString(4,SE5->E5_PARCELA)
	__oRecEST:SetString(5,SE5->E5_TIPO)
	__oRecEST:SetString(6,SE5->E5_CLIFOR)
	__oRecEST:SetString(7,SE5->E5_LOJA)
	__oRecEST:SetString(8,SE5->E5_SEQ)

	cQuery := __oRecEST:GetFixQuery()
	nRecSE5 := MpSysExecScalar(cQuery,"RECNO")

	RESTAREA(aAreaAnt)

Return nRecSE5



//-------------------------------------------------------------------
/*{Protheus.doc} A520GrvCmp

Realiza a gravação de um novo numero da compensacao nas tabelas 
SE5, FK1 e FK2. Utilizada pela função A520ResCmp.

@author Vinicius do Prado
@version 12
@since 16/06/2020
@Obs Possivel retirada apos o release 12.1.27
*/
//-------------------------------------------------------------------
Static Function A520GrvCmp(aRecSE5 as Array, aRecFK2 as Array, aRecFK1 as Array) 
	Local nI		  := 1
	Local cNumComp    := Soma1(GetMv("MV_NUMCOMP"),6)
	Local aAreaAnt    := GETAREA()
	Local cTitSE5     := ""

	While !MayIUseCode("IDENTEE"+xFilial("SE1")+cNumComp)  	
		cNumComp := Soma1(cNumComp)								
	EndDo

	DBSelectArea("SE5")
	DBSelectArea("FK2")
	DBSelectArea("FK1")
	DBSelectArea("SE2")
	DBSelectArea("FK7")

	For nI := 1 To Len(aRecSE5)
		SE5->(dbGoTo(aRecSE5[nI]))

		SE5->(RecLock("SE5",.F.))
		SE5->E5_IDENTEE := cNumComp
		SE5->(MsUnlock())
		cTitSE5 := SE5->E5_FILIAL+SE5->E5_IDORIG

		While SE5->(E5_FILIAL+E5_IDORIG) == cTitSE5
			If SE5->E5_TIPODOC $ "DC|MT|JR|CM|VA"
				SE5->(RecLock("SE5",.F.))
				SE5->E5_IDENTEE := cNumComp
				SE5->(MsUnlock())
			EndIf
			SE5->(DBSkip())
		EndDo
	Next nI

	
	For nI := 1 To Len(aRecFK2)
		FK2->(dbGoTo(aRecFK2[nI]))

		FK2->(RecLock("FK2",.F.))
		FK2->FK2_IDPROC := cNumComp
		FK2->(MsUnlock())

	Next nI

	
	For nI := 1 To Len(aRecFK1)
		FK1->(dbGoTo(aRecFK1[nI]))

		FK1->(RecLock("FK1",.F.))
		FK1->FK1_IDPROC := cNumComp
		FK1->(MsUnlock())

	Next nI

	FreeUsedCode()
	PutMV("MV_NUMCOMP", cNumComp)
	RESTAREA(aAreaAnt)

Return Nil
