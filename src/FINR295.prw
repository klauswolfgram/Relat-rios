/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR295.ch"
#include 'protheus.ch'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Fina295	³ Autor ³ Bruno Sobieski 	    ³ Data ³ 20/03/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao e detalhe de faturas            					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_Finr295()										    	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 										    	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FinR295()
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Bruno Sobieski        ³ Data ³ 20.03.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do relatorio                                     ³±±
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
Local aTam0 := {}
Local nTam0 := 0

oReport := TReport():New("FINR295",STR0005,"FINR295",;  //"Relacao de faturas"
{|oReport| ReportPrint(oReport)},STR0006) //"Este programa ira emitir a Relacao das faturas a pagar, e o detalhe dos titulos que compoem cada fatura. "

oReport:lDynamic := .T.

oReport:SetPortrait(.T.)
pergunte("FINR295",.F.)

//Gestão Corporativa - Início
aTam0 := TamSX3("E2_FILIAL")
nTam0 := Len(STR0011) + aTam0[1] //"Filial : "

oSection0 := TRSection():New(oReport,"",{"SE2"},{STR0008,STR0009})  //"Faturas"###"Fornecedor"###"Prefixo+Num"
TRCell():New(oSection0,"Filial",,,,nTam0,.F.,)

oSection0:SetHeaderSection(.F.)
//Gestão Corporativa - Fim

oSection1 := TRSection():New(oReport,STR0007,{"SE2"})
TRCell():New(oSection1,"E2_FORNECE","SE2",,,,.F.)
TRCell():New(oSection1,"E2_LOJA"	  ,"SE2",,,,.F.)
TRCell():New(oSection1,"E2_NATUREZ","SE2",,,,.F.)
TRCell():New(oSection1,"E2_NOMFOR" ,"SE2",,,,.F.)
TRCell():New(oSection1,"E2_PREFIXO","SE2",,,,.F.)
TRCell():New(oSection1,"E2_NUM"	  ,"SE2",,,,.F.)
TRCell():New(oSection1,"E2_PARCELA","SE2",,,,.F.)
TRCell():New(oSection1,"E2_TIPO"   ,"SE2",,,,.F.)
TRCell():New(oSection1,"E2_EMIS1"  ,"SE2",,,,.F.)
TRCell():New(oSection1,"E2_VENCREA","SE2",,,,.F.)
TRCell():New(oSection1,"E2_VLCRUZ" ,"SE2",,,13,.F.)
TRCell():New(oSection1,"E2_MOEDA"  ,"SE2",,,13,.F.)                          
TRCell():New(oSection1,"E2_VALOR"  ,"SE2",,,13,.F.)
TRCell():New(oSection1,"E2_SALDO"  ,"SE2",,,13,.F.)
oSection1:SetTotalInLine(.T.)

oSection2 := TRSection():New(oReport,STR0010,{"SE2"})  //"Composicao da Fatura"
TRCell():New(oSection2,"E2_PREFIXO","SE2",,,,.F.)
TRCell():New(oSection2,"E2_NUM"	  ,"SE2",,,,.F.)
TRCell():New(oSection2,"E2_PARCELA","SE2",,,,.F.)
TRCell():New(oSection2,"E2_TIPO"   ,"SE2",,,,.F.)
TRCell():New(oSection2,"E2_EMIS1"  ,"SE2",,,,.F.)
TRCell():New(oSection2,"E2_VENCTO" ,"SE2",,,,.F.)
TRCell():New(oSection2,"E2_VENCREA","SE2",,,,.F.) 
TRCell():New(oSection2,"E2_VLCRUZ" ,"SE2",,,13,.F.)
TRCell():New(oSection2,"Abatimento","SE2",,PesqPict("SE2","E2_VALOR"),13,.F.,,"RIGHT",,"RIGHT")
TRCell():New(oSection2,"E2_MOEDA"  ,"SE2",,,13,.F.)
TRCell():New(oSection2,"E2_VALOR"  ,"SE2",,,13,.F.)
TRCell():New(oSection2,"VlMovto"  ,"SE5",,PesqPict("SE5","E5_VALOR"),13,.F.,,"RIGHT",,"RIGHT")

//Gestão Corporativa - Início
oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0012,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0013,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0014,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0015,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"
//Gestão Corporativa - Fim

oSection2:SetNoFilter({"SE2"})
oSection2:LHEADERVISIBLE := .T.
oSection2:nLeftMargin := 10    

oReport:SetUseGC(.F.) //Gestão Corporativa

Return oReport                                         

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Bruno Sobieski         ³ Data ³  20.03.08³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
Local lGetParAut 	As Logical
Local lGestao	 	As Logical
Local lQuery 	 	As Logical
Local lSE2Excl   	As Logical
Local lFilOrig 	 	As Logical

Local cQuery	 	As Character
Local cAliasQry1 	As Character
Local cAliasQry2 	As Character
Local cAliasQry3 	As Character
Local cFilterUser 	As Character
Local cFilQry1  	As Character
Local cPreQry1  	As Character
Local cNumQry1  	As Character
Local cForQry1  	As Character
Local cLojQry1  	As Character
Local cTipQry1  	As Character
Local cParQry1  	As Character
Local cMdaQry1  	As Character
Local cPreAux   	As Character
Local cTipAux   	As Character
Local cNumAux   	As Character
Local cFilOrg   	As Character
Local cFatQry1  	As Character
Local cLojas 		As Character
Local cFilSE2		As Character
Local cRngFilSE2 	As Character
Local cFilSel 		As Character
Local cTmpSE2Fil 	As Character
Local cOrderSQL		as character

Local nX 			As Numeric
Local nRegSM0		As Numeric
Local nVlAbat 		As Numeric

Local aTmpFil		As Array
Local aSelFil 		As Array
Local aFilFat 		As Array

Local oSection0	:= oReport:Section(1)
Local oSection1	:= oReport:Section(2)
Local oSection2	:= oReport:Section(3)
Local oSecFil	:= oReport:Section("SECFIL")

cQuery		:= ""
cAliasQry1	:= GetNextAlias()
cAliasQry2	:= GetNextAlias()
cAliasQry3	:= ""
cFilterUser := oSection1:GetSqlExp()

lGestao   := ( FWSizeFilial() > 2 ) 	// Indica se usa Gestao Corporativa
lQuery 	:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
lSE2Excl  := Iif( lGestao, FWModeAccess("SE2",1) == "E", FWModeAccess("SE2",3) == "E")
aTmpFil	:= {}
cTmpSE2Fil := ""
nX 		:= 1

cFilSE2	:= ""
nRegSM0	:= SM0->(Recno())
aSelFil := {}
cRngFilSE2 := ""
cFilSel := ""

cFilQry1 := ""
cPreQry1 := ""
cNumQry1 := ""
cForQry1 := ""
cLojQry1 := ""
cTipQry1 := ""
cParQry1 := ""
cMdaQry1 := ""
cPreAux  := ""
cTipAux  := ""
cNumAux  := ""
cFilOrg  := ""
cFatQry1 := ""
cOrderSQL:= ""

nVlAbat := 0
cLojas := ""
aFilFat := {}
lFilOrig := SE5->( FieldPos( "E5_FILORIG" ) ) >0 .And. SE2->( FieldPos( "E2_FILORIG" ) ) > 0

lGetParAut := FindFunction("GetParAuto")

nRegSM0 := SM0->(Recno())

If mv_par12 == 1 .and. IsBlind() .and. lGetParAut
	aRetAuto	:= GetParAuto("FINR295TestCase")
	aSelFil		:= Iif(ValType(aRetAuto) == "A", aRetAuto, aSelFil)
Else
	If (lQuery .and. lSE2Excl .and. mv_par12 == 1)
		If FindFunction("FwSelectGC") .And. lGestao 
			aSelFil := FwSelectGC()
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SA2")
		Endif
	Endif
EndIf

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

SM0->(DbGoTo(nRegSM0))

If Len(aSelFil) > 1
	cRngFilSE2 := GetRngFil(aSelFil,"SE2",.T.,@cTmpSE2Fil)
	aAdd(aTmpFil,cTmpSE2Fil)
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0016 + ")")	//"Filiais selecionadas para o relatorio"
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
	cFilSE2 := " E2_FILIAL "+ cRngFilSE2 + " AND "
Else
	cFilSE2 := " E2_FILIAL = '"+ xFilial("SE2",aSelFil[1]) + "' AND "
Endif

cFilSE2 := "%"+cFilSE2+"%"

If oSection1:GetOrder()==1
	cOrder := "E2_FILIAL,E2_FORNECE,E2_LOJA,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO"
Else
	cOrder := "E2_FILIAL,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_FORNECE,E2_LOJA"
EndIf

//Baixados?
If mv_par11 == 1
	cQuery += " AND E2_SALDO = 0 "
Elseif mv_par11 == 2
	cQuery += " AND E2_SALDO <> 0 "	
EndIf
If !Empty(cFilterUser)
	cQuery += " AND ("+cFilterUser+") "
Endif	
cQuery += " ORDER BY "+cOrder
cQuery := "%" + cQuery + "%"
cLojas := "% between " + Iif(AllTrim(mv_par03) == "", "''", "'"+mv_par03+"'") + " AND " +;
	Iif(AllTrim(mv_par04) == "", "''", "'"+mv_par04+"'") + "%" 

oSection0:Init()

oSection1:BeginQuery()

BeginSql Alias cAliasQry1
SELECT SE2.*
	FROM  %table:SE2% SE2
	WHERE %exp:cFilSE2%
			E2_FORNECE	between %exp:mv_par01% AND %exp:mv_par02% AND
			E2_LOJA	between %exp:mv_par03% AND %exp:mv_par04% AND
			E2_EMIS1  	between %exp:mv_par05% AND %exp:mv_par06% AND
			E2_PREFIXO	between %exp:mv_par07% AND %exp:mv_par08% AND
			E2_NATUREZ	between %exp:mv_par09% AND %exp:mv_par10% AND
			E2_FATURA = 'NOTFAT' AND
			SE2.%NotDel% 
			%Exp:cQuery%
EndSql

oSection1:EndQuery()	

If !(cAliasQry1)->(Eof()) .And. mv_par12 == 1
	oSection0:Cell("Filial"):SetBlock( {|| STR0011 + (cAliasQry1)->E2_FILIAL})
	oSection0:PrintLine()
EndIf

cFilQry1 := (cAliasQry1)->E2_FILIAL
cForQry1 := (cAliasQry1)->E2_FORNECE
cLojQry1 := (cAliasQry1)->E2_LOJA
cPreQry1 := (cAliasQry1)->E2_PREFIXO
cNumQry1 := (cAliasQry1)->E2_NUM
cTipQry1 := (cAliasQry1)->E2_TIPO
cParQry1 := (cAliasQry1)->E2_PARCELA
cMdaQry1 := (cAliasQry1)->E2_MOEDA

oSection1:Init()

While !(cAliasQry1)->(Eof())

	If lFilOrig
		cFilOrg := (cAliasQry1)->E2_FILORIG
	EndIf 

	If (cFilQry1+cForQry1+cLojQry1+cPreQry1+cNumQry1+cTipQry1);
	== ((cAliasQry1)->E2_FILIAL+	(cAliasQry1)->E2_FORNECE+(cAliasQry1)->E2_LOJA;
	 +  (cAliasQry1)->E2_PREFIXO+(cAliasQry1)->E2_NUM;
	 +  (cAliasQry1)->E2_TIPO) .Or.;
	 	(cFilQry1+cPreQry1+cNumQry1+cTipQry1+cForQry1+cLojQry1);
	== ((cAliasQry1)->E2_FILIAL+	(cAliasQry1)->E2_PREFIXO+(cAliasQry1)->E2_NUM;
	 +  (cAliasQry1)->E2_TIPO+(cAliasQry1)->E2_FORNECE+(cAliasQry1)->E2_LOJA)
		oSection1:PrintLine()
		(cAliasQry1)->(dBSkip())
	EndIf

	If (cFilQry1+cForQry1+cLojQry1+cPreQry1+cNumQry1+cTipQry1);
	<> ((cAliasQry1)->E2_FILIAL+	(cAliasQry1)->E2_FORNECE+(cAliasQry1)->E2_LOJA;
	 +  (cAliasQry1)->E2_PREFIXO+(cAliasQry1)->E2_NUM;
	 +  (cAliasQry1)->E2_TIPO) .Or.;
	 	(cFilQry1+cPreQry1+cNumQry1+cTipQry1+cForQry1+cLojQry1);
	<> ((cAliasQry1)->E2_FILIAL+	(cAliasQry1)->E2_PREFIXO+(cAliasQry1)->E2_NUM;
	 +  (cAliasQry1)->E2_TIPO+(cAliasQry1)->E2_FORNECE+(cAliasQry1)->E2_LOJA) .Or.;
	 	(cAliasQry1)->(Eof())

		oSection2:Init()
		oSection2:BeginQuery()

		cOrderSQL := "%"+ cOrder +"%"

		BeginSql Alias cAliasQry2
			SELECT SE2.*
			FROM  %table:SE2% SE2
			JOIN %table:FI8% FI8
				ON FI8.%NotDel% AND
				E2_FILIAL = FI8_FILIAL AND
				E2_PREFIXO = FI8_PRFORI AND
				E2_NUM = FI8_NUMORI AND
				E2_PARCELA = FI8_PARORI AND
				E2_TIPO = FI8_TIPORI AND
				E2_FORNECE = FI8_FORORI AND
				E2_LOJA = FI8_LOJORI
			WHERE 	
				SE2.%NotDel% AND
				FI8_FILDES = %exp:cFilQry1% AND
				FI8_PRFDES = %exp:cPreQry1% AND
				FI8_NUMDES = %exp:cNumQry1% AND
				FI8_PARDES = %exp:cParQry1% AND
				FI8_TIPDES = %exp:cTipQry1% AND
				FI8_FORDES = %exp:cForQry1% AND
				FI8_LOJDES = %exp:cLojQry1%
			ORDER BY %exp:cOrderSQL%
		EndSql

		oSection2:EndQuery()

		cPreAux := cPreQry1
		cTipAux := cTipQry1
		cNumAux := cNumQry1
		cParAux := cParQry1

		While !(cAliasQry2)->(Eof())
		
			cPreQry1 := (cAliasQry2)->E2_PREFIXO
			cNumQry1 := (cAliasQry2)->E2_NUM
			cParQry1 := (cAliasQry2)->E2_PARCELA
			cTipQry1 := (cAliasQry2)->E2_TIPO
			cFatQry1 := (cAliasQry2)->E2_FORNECE
				
			nVlAbat :=SomaAbat(cPreQry1,cNumQry1,cParQry1,"P",cMdaQry1,,cFatQry1)
			oSection2:Cell("Abatimento"):SetBlock({|| nVlAbat})
			cAliasQry3	:= GetNextAlias()

			cAlias := Alias()

			BeginSql Alias cAliasQry3
			SELECT SE5.E5_VALOR
				FROM  %table:SE5% SE5
				WHERE 	E5_FILIAL	= %exp:xFilial("SE5",cFilQry1)% AND
						E5_PREFIXO = %exp:cPreQry1% AND
						E5_NUMERO	= %exp:cNumQry1% AND
						E5_PARCELA	= %exp:cParQry1% AND
						E5_TIPO    = %exp:cTipQry1% AND
						E5_CLIFOR	= %exp:cFatQry1% AND
						E5_FORNECE	= %exp:cFatQry1% AND
						E5_LOJA %exp:cLojas% AND
						E5_MOTBX	= 'FAT' AND
						E5_RECPAG	= 'P' AND
						SE5.%NotDel%
			EndSql

			oSection2:Cell("VlMovto"):SetBlock({|| (cAliasQry3)->E5_VALOR})
			oSection2:PrintLine()
			(cAliasQry3)->(DbCloseArea())
			dBSelectArea(cAlias)
			(cAliasQry2)->(dBSkip())
		EndDo

		oSection1:Finish()
		oSection2:Finish()
		oReport:SkipLine(2)
		oSection1:Init()
	EndIf	

	If cFilQry1 <> (cAliasQry1)->E2_FILIAL .And. !(cAliasQry1)->(Eof()) .And. mv_par12 == 1
		oSection0:Cell("Filial"):SetBlock( {|| STR0011 + (cAliasQry1)->E2_FILIAL})
		oSection0:PrintLine()
		oReport:SkipLine()
	EndIf

	cFilQry1 := (cAliasQry1)->E2_FILIAL
	cForQry1 := (cAliasQry1)->E2_FORNECE
	cLojQry1 := (cAliasQry1)->E2_LOJA
	cPreQry1 := (cAliasQry1)->E2_PREFIXO
	cNumQry1 := (cAliasQry1)->E2_NUM
	cTipQry1 := (cAliasQry1)->E2_TIPO
	cParQry1 := (cAliasQry1)->E2_PARCELA
	cMdaQry1 := (cAliasQry1)->E2_MOEDA

EndDo

oSection0:Finish()
oSection1:Finish()

For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])   
Next

aSize( aFilFat , 0 )
aFilFat := Nil

Return
