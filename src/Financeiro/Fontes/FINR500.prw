/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR500.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FILEIO.CH"

Static __oFINR5001
Static __lMotInDb

//-------------------------------------------------------------------
/*/{Protheus.doc} U_FinR500()
Relatorio de Liquidacoes Financeiras

@Return	Nil
@sample	U_FinR500()
@author	Daniel Tadashi Batori
@since		10/07/06
@version	1.0
/*/
//-------------------------------------------------------------------

User Function FinR500()

Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Definicao do layout do Relatorio

@Return	oReport - Objeto TReport
@sample	oReport := ReportDef()
@author	Daniel Batori
@since		10/07/06
@version	1.0
/*/
//-------------------------------------------------------------------

Static Function ReportDef()

Local oReport
Local oSection1
Local oSection11
Local aTam1, aTam2, aTam3, nTamLiq
Local aTamCHQ := {}
Local nTamCHQ := 0
Local oSecFil	:= Nil

oReport := TReport():New("FINR500",STR0003,"FIN500",{|oReport| ReportPrint(oReport)},STR0001+STR0002)
oReport:SetUseGC(.F.)

Pergunte("FIN500", .F.)

aTam1 := TamSX3("E1_NUMLIQ")
aTam2 := TamSX3("E1_CLIENTE")
aTam3 := TamSX3("E1_LOJA")
nTamLiq :=	LEN(STR0007) + aTam1[1] + aTam2[1] + aTam3[1] + 15

nTamCHQ := 2 // considerar os 2 tracos
aTamCHQ := TamSX3("E1_BCOCHQ")
nTamCHQ += aTamCHQ[1]
aTamCHQ := TamSX3("E1_AGECHQ")
nTamCHQ += aTamCHQ[1]
aTamCHQ := TamSX3("E1_CTACHQ")
nTamCHQ += aTamCHQ[1]

oSection1 := TRSection():New(oReport,STR0025,{"Trb"},)
TRCell():New(oSection1,"LIQUIDA" ,,STR0025,,nTamLiq,.F.,)  //definido por SetBlock
oSection1:SetHeaderSection(.F.)

nTamStat := 12 //Max(Len(STR0008),Len(STR0009))

oSection11 := TRSection():New(oSection1,STR0027,{"Trb"},) // "Titulos Liquidados"
TRCell():New(oSection11,"FILORIG","",Upper(SX3->(RetTitle("E5_FILORIG"))),,FWSizeFilial() + 3,.F.,)		/* GESTAO */
TRCell():New(oSection11,"CLIFOR","",Upper(SX3->(RetTitle("E5_CLIFOR"))),,,.F.,)							/* GESTAO */
TRCell():New(oSection11,"LOJA","",Upper(SX3->(RetTitle("E5_LOJA"))),,,.F.,)								/* GESTAO */
TRCell():New(oSection11,"E1_PREFIXO" ,"SE1",STR0012,,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_NUM" ,"SE1",STR0013,,TamSX3("E1_NUM")[1]+3,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_PARCELA" ,"SE1",STR0014,,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_TIPO" ,"SE1",STR0015,,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_EMISSAO" ,"SE1",STR0016,,TamSX3("E1_EMISSAO")[1]+5,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_EMITCHQ" ,"SE1",STR0017,,TamSX3("E1_EMITCHQ")[1]-5,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"VALOR",,STR0018,"@E 9,999,999,999.99",16,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"JUROS",,STR0019,"@E 9,999,999.99",12,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"DESCONTOS",,STR0020,"@E 9,999,999.99",12,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_BCOCHQ" ,"SE1",STR0021+"-"+STR0022+"-"+STR0023,,nTamCHQ+5,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"STATUS" ,,STR0024,,nTamStat,.F.,)  //definido por SetBlock

/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SE1","SED"})
TRCell():New(oSecFil,"CODFIL",,STR0035,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)				//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0036,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)				//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0037,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)				//"Unidade de negocio"
TRCell():New(oSecFil,"NOMEFIL",,STR0038,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)				//"Filial"

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
A funcao estatica ReportDef devera ser criada para todos os
relatorios que poderao ser agendados pelo usuario.

@param		oReport - Objeto Report do Relatório
@Return	Nil
@sample	Fr500MotBx( "LIQ", "LIQUIDACAO", "ANSN" )
@author	Daniel Batori
@since		10/07/06
@version	1.0
/*/
//-------------------------------------------------------------------

Static Function ReportPrint(oReport)

Local oSection1  	:= oReport:Section(1)
Local oSection11 	:= oReport:Section(1):Section(1)
Local cAlias1 		:= GetNextAlias()
Local cAlias2 		:= GetNextAlias()
Local cAlias3 		:= GetNextAlias()
Local cWhere 		:= ""
Local aCampos		:= {}
Local aTam			:= {}
Local nTaxa			:= 1
Local nValor		:= 0
Local lParcial		:= .F.
Local aSelFil		:= {}
Local aTmpFil		:= {}
Local aSM0			:= {}
Local nTamEmp		:= 0
Local nTamUnNeg		:= 0
Local nTamTit		:= 0
Local nX			:= 0
Local cTmpFil		:= ""
Local cFilSel		:= ""
Local cTitulo		:= ""
Local cFilSE		:= ""
Local oSecFil		:= oReport:Section("SECFIL")
local nTamLiq 		:= TamSx3("E1_NUMLIQ")[1]
Local lFilOrig		:= getComp("SE1")=="CCC"
Local cFilSE1		:= ""
local cFilSE2		:= ""

Fr500MotBx("LIQ","LIQUIDACAO","ANSN") // Cria motivo de baixa LIQ 

If MV_PAR11 == 1
	AdmSelecFil("FIN500",11,.F.,@aSelFil,"SE1",.F.)
Endif
If Empty(aSelFil)
	Aadd(aSelFil, cFilAnt)
Endif

cFilSE := if(lFilOrig,"E5_FILORIG ","E5_FILIAL ") + GetRngFil(aSelFil,"SE5",.T., @cTmpFil, NIL, lFilOrig) + " AND "
Aadd(aTmpFil,cTmpFil)
cFilSE := "%" + cFilSE + "%"

cWhere := " AND E5_DOCUMEN >= '"+ PADR(MV_PAR01, TamSx3("E5_DOCUMEN")[1]) + "' "
cWhere += " AND E5_DOCUMEN <= '"+ PADR(MV_PAR02, TamSx3("E5_DOCUMEN")[1]) + "' "
cWhere += " AND E5_DOCUMEN <> '"+ Space(TamSx3("E5_DOCUMEN")[1]) + "'"
cWhere := "%" + cWhere + "%"

//baixado
if lFilOrig 

	cFilSE1 := Replace(cFilSE, "E5", "E1")
	cFilSE2 := Replace(cFilSE, "E5", "E2")

	BeginSql Alias cAlias1
		SELECT SE5.*
		FROM %table:SE5% SE5
		JOIN %table:FI7% FI7
			ON E5_FILIAL = FI7_FILIAL
			AND E5_PREFIXO = FI7_PRFORI
			AND E5_NUMERO = FI7_NUMORI
			AND E5_PARCELA = FI7_PARORI
			AND E5_TIPO = FI7_TIPORI
			AND E5_CLIFOR = FI7_CLIORI
			AND E5_LOJA = FI7_LOJORI
			AND FI7.%notDel%
		JOIN %table:SE1% SE1
			ON FI7_FILDES = E1_FILIAL
			AND FI7_PRFDES = E1_PREFIXO
			AND FI7_NUMDES = E1_NUM
			AND FI7_PARDES = E1_PARCELA
			AND FI7_TIPDES = E1_TIPO
			AND FI7_CLIDES = E1_CLIENTE
			AND FI7_LOJDES = E1_LOJA
			AND SE1.%notDel%
		WHERE %exp:cFilSE1%
				E5_CLIFOR >= %exp:MV_PAR03% AND
				E5_CLIFOR <= %exp:MV_PAR04% AND
				E5_MOTBX = 'LIQ' AND
				E5_SITUACA <> 'C' AND
				E5_TIPODOC = 'BA' AND
				SE5.%NotDel%
				%Exp:cWhere%

		UNION

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
				E5_TIPODOC = 'BA' AND
				SE5.%NotDel%
				%Exp:cWhere%

	EndSQL
else
	BeginSql Alias cAlias1
		//column E1_VENCREA as Date
		SELECT SE5.*
		FROM %table:SE5% SE5
		WHERE %exp:cFilSE%
				E5_CLIFOR >= %exp:MV_PAR03% AND
				E5_CLIFOR <= %exp:MV_PAR04% AND
				E5_MOTBX = 'LIQ' AND
				E5_SITUACA <> 'C' AND
				E5_TIPODOC = 'BA' AND
				SE5.%NotDel%
				%Exp:cWhere%
	EndSQL
endIf

cWhere := " AND NOT (E1_NUMLIQ  = '"+ Space(TamSx3("E1_NUMLIQ")[1]) + "')"
cWhere := "%" + cWhere + "%"

cFilSE := if(lFilOrig,"E1_FILORIG ","E1_FILIAL ") + GetRngFil(aSelFil,"SE1",.T., @cTmpFil, NIL, lFilOrig) + " AND "
Aadd(aTmpFil,cTmpFil)
cFilSE := "%" + cFilSE + "%"

//gerado SE1
BeginSql Alias cAlias2
	column E1_EMISSAO as Date
	SELECT SE1.*
	FROM %table:SE1% SE1
	WHERE %exp:cFilSE%
			E1_CLIENTE >= %exp:MV_PAR03% AND
			E1_CLIENTE <= %exp:MV_PAR04% AND
			E1_NUMLIQ >=  %exp:MV_PAR01% AND
			E1_NUMLIQ <= %exp:MV_PAR02% AND
			SE1.%NotDel%
			%Exp:cWhere%
EndSQL

cWhere := " AND NOT (E2_NUMLIQ = '"+ Space(TamSx3("E2_NUMLIQ")[1]) + "')"
cWhere := "%" + cWhere + "%"

cFilSE := if(lFilOrig,"E2_FILORIG ","E2_FILIAL ") + GetRngFil(aSelFil,"SE2",.T., @cTmpFil, NIL, lFilOrig) + " AND "
Aadd(aTmpFil,cTmpFil)
cFilSE := "%" + cFilSE + "%"

//gerado SE2
BeginSql Alias cAlias3
	column E2_EMISSAO as Date
	SELECT SE2.*
	FROM %table:SE2% SE2
	WHERE %exp:cFilSE%
			E2_FORNECE >= %exp:MV_PAR06% AND
			E2_FORNECE <= %exp:MV_PAR07% AND
			E2_NUMLIQ >=  %exp:MV_PAR01% AND
			E2_NUMLIQ <= %exp:MV_PAR02% AND
			SE2.%NotDel%
			%Exp:cWhere%
EndSQL

aTam:=TamSX3("E1_CLIENTE")
AADD(aCampos,{"CLIENTE" ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("E1_LOJA")
AADD(aCampos,{"LOJA"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("E1_NUMLIQ")
AADD(aCampos,{"NUMLIQ" ,"C",aTam[1],aTam[2]})
AADD(aCampos,{"PREFIXO","C",3,0})
aTam:=TamSX3("E1_NUM")
AADD(aCampos,{"NUMTIT" ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("E1_PARCELA")
AADD(aCampos,{"PARCELA","C",aTam[1],aTam[2]})
aTam:=TamSX3("E1_TIPO")
AADD(aCampos,{"TIPO"   ,"C",aTam[1],aTam[2]})
AADD(aCampos,{"MOEDA"  ,"N",2,0})
aTam:=TamSX3("E1_EMISSAO")
AADD(aCampos,{"EMISSAO","D",aTam[1],aTam[2]})
AADD(aCampos,{"EMITENTE","C",35,0})
AADD(aCampos,{"VALOR"  ,"N",18,2})
AADD(aCampos,{"JUROS"  ,"N",18,2})
AADD(aCampos,{"DESCONT","N",18,2})
aTam:=TamSX3("E1_BCOCHQ")
AADD(aCampos,{"BANCO","C",aTam[1],aTam[2]})
aTam:=TamSX3("E1_AGECHQ")
AADD(aCampos,{"AGENCIA","C",aTam[1],aTam[2]})
aTam:=TamSX3("E1_CTACHQ")
AADD(aCampos,{"CONTA","C",aTam[1],aTam[2]})
AADD(aCampos,{"BG"     ,"C", 1,0}) // Baixado ou Gerado
AADD(aCampos,{"CART"   ,"C", 1,0}) // Tipo Carteira
AADD(aCampos,{"TIPOBX"  ,"C",1,0})
AADD(aCampos,{"FILORIG" ,"C",FwSizeFilial(),0})		/* GESTAO */
AADD(aCampos,{"FILIAL" ,"C",FwSizeFilial(),0})		/* GESTAO */

If __oFINR5001 <> Nil
	__oFINR5001:Delete()
	__oFINR5001 := Nil
Endif

Trb		:= GetNextAlias()
				
__oFINR5001 	:= FWTemporaryTable():New("Trb")
__oFINR5001:SetFields( aCampos )

cChave	:= "CART+NUMLIQ+BG+PREFIXO+NUMTIT+PARCELA+TIPO"
aChave	:= StrToKarr(cChave,"+")

__oFINR5001:AddIndex("1", aChave)
__oFINR5001:Create()
				
// Titulos Gerados na liquidacao - SE1
If mv_par05 != 2
	// Filtra o tipo de carteira conforme o parametro
	If MV_PAR10 == 3 .OR. MV_PAR10 == 1
		While (cAlias2)->(!Eof())
			If MV_PAR08 <> 1
				DbSelectArea( "SM2" )
				SM2->( DbSetOrder( 1 ) )
				If SM2->( DbSeek( DtoS( IIf( MV_PAR08 == 2, DDATABASE, (cAlias2)->E1_EMISSAO ) ) ) )
					If FieldPos( "M2_MOEDA" + MV_PAR09 ) > 0
						nTaxa := SM2->&( "M2_MOEDA" + MV_PAR09 )
					EndIf
				EndIf
			EndIf

			DBSelectArea("Trb")
			RecLock("Trb",.T.)
				Trb->FILIAL		:= (cAlias2)->E1_FILIAL	/* GESTAO */
				Trb->FILORIG	:= (cAlias2)->E1_FILORIG		/* GESTAO */
				Trb->CLIENTE	:= (cAlias2)->E1_CLIENTE
				Trb->LOJA		:= (cAlias2)->E1_LOJA
				Trb->NUMLIQ	:= (cAlias2)->E1_NUMLIQ
				Trb->PREFIXO	:= (cAlias2)->E1_PREFIXO
				Trb->NUMTIT	:= (cAlias2)->E1_NUM
				Trb->PARCELA	:= (cAlias2)->E1_PARCELA
				Trb->TIPO		:= (cAlias2)->E1_TIPO
				Trb->EMISSAO	:= (cAlias2)->E1_EMISSAO
				Trb->VALOR		:= iif( MV_PAR08 == 1, (cAlias2)->E1_VALOR, xMoeda((cAlias2)->E1_VALOR, (cAlias2)->E1_MOEDA, Val(MV_PAR09), IIf( MV_PAR08 == 2, DDATABASE, (cAlias2)->E1_EMISSAO ) ) )
				Trb->JUROS		:= (cAlias2)->E1_ACRESC
				Trb->BANCO		:= (cAlias2)->E1_BCOCHQ
				Trb->AGENCIA	:= (cAlias2)->E1_AGECHQ
				Trb->CONTA		:= (cAlias2)->E1_CTACHQ
				Trb->EMITENTE	:= Substr((cAlias2)->E1_EMITCHQ,1,35)
				Trb->BG		:= "G"	// Gerado
				Trb->CART     := "R"
				Trb->TIPOBX	:= ""
			MsUnlock()
			(cAlias2)->(dbSkip())
		Enddo
	EndIf
Endif

// Titulos Gerados na liquidacao - SE2
If mv_par05 != 2
	// Filtra o tipo de carteira conforme o parametro
	If MV_PAR10 == 2 .OR. MV_PAR10 == 1
		While (cAlias3)->(!Eof())
			If MV_PAR08 <> 1
				DbSelectArea( "SM2" )
				SM2->( DbSetOrder( 1 ) )
				If SM2->( DbSeek( DtoS( IIf( MV_PAR08 == 2, DDATABASE, (cAlias3)->E2_EMISSAO ) ) ) )
					If FieldPos( "M2_MOEDA" + MV_PAR09 ) > 0
						nTaxa := SM2->&( "M2_MOEDA" + MV_PAR09 )
					EndIf
				EndIf
			EndIf

			DBSelectArea("Trb")
			RecLock("Trb",.T.)
			Trb->FILIAL		:= (cAlias3)->E2_FILIAL		/* GESTAO */
			Trb->FILORIG	:= (cAlias3)->E2_FILORIG	/* GESTAO */
			Trb->CLIENTE	:= (cAlias3)->E2_FORNECE
			Trb->LOJA		:= (cAlias3)->E2_LOJA
			Trb->NUMLIQ		:= (cAlias3)->E2_NUMLIQ
			Trb->PREFIXO	:= (cAlias3)->E2_PREFIXO
			Trb->NUMTIT		:= (cAlias3)->E2_NUM
			Trb->PARCELA	:= (cAlias3)->E2_PARCELA
			Trb->TIPO		:= (cAlias3)->E2_TIPO
			Trb->EMISSAO	:= (cAlias3)->E2_EMISSAO
			Trb->VALOR		:= iif( MV_PAR08 == 1, (cAlias3)->E2_VALOR, xMoeda((cAlias3)->E2_VALOR, (cAlias3)->E2_MOEDA,  Val(MV_PAR09), IIf( MV_PAR08 == 2, DDATABASE, (cAlias3)->E2_EMISSAO ) ) )
			Trb->JUROS		:= (cAlias3)->E2_ACRESC
			Trb->BANCO		:= (cAlias3)->E2_BCOCHQ
			Trb->AGENCIA	:= (cAlias3)->E2_AGECHQ
			Trb->CONTA		:= (cAlias3)->E2_CTACHQ
			Trb->EMITENTE 	:= SPACE(35)
			Trb->BG			:= "G"	// Gerado
			Trb->CART       := "P"
	   		Trb->TIPOBX		:= ""
			MsUnlock()
			(cAlias3)->(dbSkip())
		Enddo
	EndIf
Endif

// Titulos Baixados na liquidacao
If mv_par05 != 3
	While (cAlias1)->(!Eof())
		If MV_PAR08 <> 1
			DbSelectArea( "SM2" )
			SM2->( DbSetOrder( 1 ) )
			If SM2->( DbSeek( IIf( MV_PAR08 == 2, DtoS( DDATABASE ), (cAlias1)->E5_DATA ) ) )
				If FieldPos( "M2_MOEDA" + MV_PAR09 ) > 0
					nTaxa := SM2->&( "M2_MOEDA" + MV_PAR09 )
				EndIf
			EndIf
		EndIf

		//Filtra o tipo de carteira conforme o parametro
		If MV_PAR10 == 2 .AND. Alltrim((cAlias1)->E5_RECPAG) <> "P"
			(cAlias1)->(dbSkip())
			Loop
		ElseIf MV_PAR10 == 3 .AND. Alltrim((cAlias1)->E5_RECPAG) <> "R"
			(cAlias1)->(dbSkip())
			Loop
		EndIf

		If (cAlias1)->E5_RECPAG == "R"
			SE1->(dbSetOrder(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
			SE1->(MsSeek(xFilial("SE1",(cAlias1)->E5_FILORIG)+(cAlias1)->(E5_CLIFOR+E5_LOJA+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))		/* GESTAO */
		Else
  			SE2->(dbSetOrder(6))//E2_FILIAL+E2_FORNECE+E2_LOJA+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO
			SE2->(MsSeek(xFilial("SE2",(cAlias1)->E5_FILORIG)+(cAlias1)->(E5_CLIFOR+E5_LOJA+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))		/* GESTAO */
		EndIf

		If (cAlias1)->E5_RECPAG == "R"
			DBSelectArea("Trb")
			RecLock("Trb",.T.)
			Trb->FILIAL		:= (cAlias1)->E5_FILIAL			/* GESTAO */
			Trb->FILORIG	:= (cAlias1)->E5_FILORIG		/* GESTAO */
			Trb->CLIENTE	:= (cAlias1)->E5_CLIFOR
			Trb->LOJA		:= (cAlias1)->E5_LOJA
			Trb->NUMLIQ		:= Substr((cAlias1)->E5_DOCUMEN,1,nTamLiq)
			Trb->PREFIXO	:= (cAlias1)->E5_PREFIXO
			Trb->NUMTIT		:= (cAlias1)->E5_NUMERO
			Trb->PARCELA	:= (cAlias1)->E5_PARCELA
			Trb->TIPO		:= (cAlias1)->E5_TIPO
			Trb->EMISSAO	:= SE1->E1_EMISSAO
			nValor 			:= iif( MV_PAR08 == 1, SE1->E1_VALOR, xMoeda( SE1->E1_VALOR, SE1->E1_MOEDA,  Val(MV_PAR09), IIf( MV_PAR08 == 2, DDATABASE, SE1->E1_EMISSAO ) ) )
			Trb->VALOR		:= nValor
			Trb->JUROS		:= (cAlias1)->E5_VLJUROS
			Trb->DESCONT	:= (cAlias1)->E5_VLDESCO
			Trb->EMITENTE 	:= SUBSTR(SE1->E1_EMITCHQ,1,35)
			Trb->BG			:= "B"	// Baixado
			Trb->CART      	:= Alltrim((cAlias1)->E5_RECPAG)
		Else
			DBSelectArea("Trb")
			RecLock("Trb",.T.)
			Trb->FILIAL		:= (cAlias1)->E5_FILIAL			/* GESTAO */
			Trb->FILORIG	:= (cAlias1)->E5_FILORIG		/* GESTAO */
			Trb->CLIENTE	:= (cAlias1)->E5_CLIFOR
			Trb->LOJA		:= (cAlias1)->E5_LOJA
			Trb->NUMLIQ		:= Substr((cAlias1)->E5_DOCUMEN,1,nTamLiq)
			Trb->PREFIXO	:= (cAlias1)->E5_PREFIXO
			Trb->NUMTIT		:= (cAlias1)->E5_NUMERO
			Trb->PARCELA	:= (cAlias1)->E5_PARCELA
			Trb->TIPO		:= (cAlias1)->E5_TIPO
			Trb->EMISSAO	:= SE2->E2_EMISSAO
			nValor 			:= iif( MV_PAR08 == 1, SE2->E2_VALOR, xMoeda( SE2->E2_VALOR, SE2->E2_MOEDA,  Val(MV_PAR09), IIf( MV_PAR08 == 2, DDATABASE, SE2->E2_EMISSAO ) ) )
			Trb->VALOR		:= nValor
			Trb->JUROS		:= (cAlias1)->E5_VLJUROS
			Trb->DESCONT	:= (cAlias1)->E5_VLDESCO
			Trb->EMITENTE 	:= SPACE(35)
			Trb->BG			:= "B"	// Baixado
			TRB->CART      	:= Alltrim((cAlias1)->E5_RECPAG)
		EndIf


		//Verifica Baixas Parciais
		aAreaSE5 := SE5->(GetArea())
		dbSelectArea("SE5")
		dbSetOrder(7)

		If dbSeek(xFilial("SE5",(cAlias1)->E5_FILIAL)+(cAlias1)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR))
			While SE5->(!Eof()) .And. SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR) == xFilial("SE5",(cAlias1)->E5_FILIAL)+(cAlias1)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR)
				If SE5->E5_TIPODOC == "BA" .And.;
				   nValor > (SE5->E5_VALOR - (cAlias1)->E5_VLJUROS + (cAlias1)->E5_VLDESCO) .And. ! SE5->E5_SITUACA $ "C,E,X"
					lParcial := .T.
				Endif
				SE5->(dbSkip())
			Enddo
		Endif

		If lParcial
			Trb->TIPOBX := "P" //Parcial
		Else
			Trb->TIPOBX := "T" //Total
		Endif

		lParcial  := .F.
		SE5->(RestArea(aAreaSE5))
		MsUnlock()
		(cAlias1)->(dbSkip())
	Enddo
Endif
oReport:SetPageFooter(4,{|| If(!oSection11:Printing(),F500Legenda(oReport),"")})

oSection1:Cell("LIQUIDA"):SetBlock		({|| STR0007 + Trb->NUMLIQ + " - " + If(TRB->CART == "P",STR0028,STR0029) })
oSection11:Cell("E1_PREFIXO"):SetBlock	({|| Trb->PREFIXO })
oSection11:Cell("E1_NUM"):SetBlock		({|| Trb->NUMTIT })
oSection11:Cell("E1_PARCELA"):SetBlock	({|| Trb->PARCELA })
oSection11:Cell("E1_TIPO"):SetBlock		({|| Trb->TIPO })
oSection11:Cell("E1_EMISSAO"):SetBlock	({|| Trb->EMISSAO })
oSection11:Cell("E1_EMITCHQ"):SetBlock	({|| Trb->EMITENTE })
oSection11:Cell("VALOR"):SetBlock		({|| Trb->VALOR })
oSection11:Cell("JUROS"):SetBlock		({|| Trb->JUROS })
oSection11:Cell("DESCONTOS"):SetBlock	({|| Trb->DESCONT })
oSection11:Cell("E1_BCOCHQ"):SetBlock	({|| If (Empty(Trb->(BANCO+AGENCIA+CONTA))," ", Trb->BANCO+"-"+Trb->AGENCIA+"-"+Trb->CONTA) })
oSection11:Cell("STATUS"):SetBlock		({|| If(Trb->BG == "B",Iif(Trb->TIPOBX == "P",STR0030,STR0008),STR0009) })
oSection11:Cell("FILORIG"):SetBlock		({|| Trb->FILORIG })		/* GESTAO */
oSection11:Cell("CLIFOR"):SetBlock		({|| Trb->CLIENTE })		/* GESTAO */
oSection11:Cell("LOJA"):SetBlock		({|| Trb->LOJA })			/* GESTAO */

//Faz o alinhamento do cabecalho das celulas
oSection11:Cell("E1_PREFIXO"):SetHeaderAlign("LEFT")
oSection11:Cell("E1_NUM" 	):SetHeaderAlign("LEFT")
oSection11:Cell("E1_PARCELA"):SetHeaderAlign("LEFT")
oSection11:Cell("E1_TIPO"	):SetHeaderAlign("LEFT")
oSection11:Cell("E1_EMISSAO"):SetHeaderAlign("CENTER")
oSection11:Cell("E1_EMITCHQ"):SetHeaderAlign("CENTER")
oSection11:Cell("VALOR"		):SetHeaderAlign("RIGHT")
oSection11:Cell("JUROS" 	):SetHeaderAlign("RIGHT")
oSection11:Cell("DESCONTOS"	):SetHeaderAlign("RIGHT")
oSection11:Cell("E1_BCOCHQ"	):SetHeaderAlign("LEFT")
oSection11:Cell("STATUS" 	):SetHeaderAlign("LEFT")

oSection11:SetHeaderPage(.T.)

oSection11:SetParentFilter({|cParam| Trb->CART + Trb->NUMLIQ == cParam},{|| Trb->CART + Trb->NUMLIQ})

TRFunction():New(oSection11:Cell("VALOR")		,"T_VAL" ,"SUM",,Iif(mv_par05 == 1,STR0031,STR0010),,{|| Fr500TotLiq( "TRB", 1 ) },.T.,.F.)
TRFunction():New(oSection11:Cell("JUROS")		,"T_JUR" ,"SUM",,Iif(mv_par05 == 1,STR0031,STR0010),,{|| Fr500TotLiq( "TRB", 2 ) },.T.,.F.)
TRFunction():New(oSection11:Cell("DESCONTOS")	,"T_DESC","SUM",,Iif(mv_par05 == 1,STR0031,STR0010),,{|| Fr500TotLiq( "TRB", 3 ) },.T.,.F.)

/* imprime a lista de filiais selecionadas para o relatorio */
If Len(aSelFil) > 1 .And. !(TRB->(EOF()))
	oSection11:SetHeaderSection(.F.)
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0039 + ")")			//"Filiais selecionadas para o relatorio"
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
	oSection11:SetHeaderSection(.T.)
	oReport:EndPage()
Endif

oSection11:SetTotalInLine(.F.)
oSection11:SetTotalText(Iif(mv_par05 == 1,STR0031,STR0010)) // Totais
oSection1:Print()

Trb->(dbCloseArea())

If !Empty(aTmpFil)
	For nX := 1 To Len(aTmpFil)
		CtbTmpErase(aTmpFil[nX])
	Next
Endif

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} Fr500MotBx
Funcao criar automaticamente o motivo de baixa LIQ na tabela Mot baixas

@param nRecno    Recno do título da SE2 (Contas a pagar)

@param		cMot - Motivo de Baixa
@param		cNomMot - Descrição do Motivo
@param		cConfMot - 
@Return	Nil
@sample	Fr500MotBx( "LIQ", "LIQUIDACAO", "ANSN" )
@author	Marcelo Celi Marques
@since		23/01/09
@version	1.0
/*/
//-------------------------------------------------------------------

Static Function Fr500MotBx(cMot,cNomMot, cConfMot)
	Local lMotBxEsp	:= .F.
	Local aMotbx 	:= ReadMotBx(@lMotBxEsp)
	Local nHdlMot	:= 0
	Local I			:= 0
	Local cFile 	:= "SIGAADV.MOT"
	Local nTamLn	:= 19

	If __lMotInDb == NIL
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
		Endif
	EndIf

	FwFreeArray(aMotBx)
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} F500Legenda
Legenda do relatorio.

@param nRecno    Recno do título da SE2 (Contas a pagar)

@param		oReport - Objeto do TReport
@Return	Nil
@sample	If( !oSection11:Printing(), F500Legenda(oReport), "" )
@author	Microsiga
@since		06/02/09
@version	1.0
/*/
//-------------------------------------------------------------------

Static Function F500Legenda(oReport)

oReport:PrintText(STR0032) //"Observações: "
oReport:PrintText(STR0033) //"- Os títulos baixados são impressos com o valor original, independente da forma da baixa. "
oReport:PrintText(STR0034) //"- Os totalizadores consideram o valor total da liquidação ou dos títulos gerados/baixados."

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} FR500TotLiq
Realiza totalizacao do valor liquido.

@param nRecno    Recno do título da SE2 (Contas a pagar)

@param		nRecno	- Alias da tabela temporaria
@Return	nTotal - Total do valor liquido
@sample	{ || Fr500TotLiq( "TRB" ) }
@author	Gustavo Henrique
@since		14/05/10
@version	1.0
/*/
//-------------------------------------------------------------------

Static Function FR500TotLiq( cAlias, nTipo )

Local nTotal := 0

If nTipo = 1
	nTotal := (cAlias)->VALOR
ElseIf nTipo = 2
	If (cAlias)->JUROS > 0
		nTotal := (cAlias)->JUROS
	EndIf
Else
	If (cAlias)->DESCONT > 0
		nTotal := (cAlias)->DESCONT
	EndIf
EndIf

Return nTotal


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
