/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR501.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "fwcommand.ch"

Static _oFINR5011
Static __lExFO0 := .F.
Static __lMotInDb

//-------------------------------------------------------------------
/*/{Protheus.doc} FINR501
Relatório de Liquidações Financeiras (Contas a Receber)

@author Alvaro Camillo Neto
@since 04/02/2010
/*/
//-------------------------------------------------------------------
User Function FinR501()
Local oReport
Private cPerg := "FIN501"

oReport := ReportDef()
oReport:PrintDialog()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Definição do layout do relatório

@author Daniel Batori
@since  10/07/2006
/*/
//-------------------------------------------------------------------
Static Function ReportDef()
Local oReport		:= Nil
Local oSection1		:= Nil
Local oSection11	:= Nil
Local aTam1			:= {}
Local aTam2			:= {}
Local aTam3			:= {}
Local nTamLiq		:= 0
Local aTamCHQ		:= {}
Local nTamCHQ		:= 0
Local oSecFil		:= Nil
Local nTamE1NUM		:= 0

oReport := TReport():New("FINR501",STR0001,"FIN501",;//"Liquidacoes Financeiras"
{|oReport| ReportPrint(oReport)},STR0002+STR0003)//"Este relatorio irá imprimir o extrato de Liquidacoes "##"Financeiras."

Pergunte("FIN501", .F.)

aTam1 := TamSX3("E1_NUMLIQ")
aTam2 := TamSX3("E1_CLIENTE")
aTam3 := TamSX3("E1_LOJA")
nTamLiq :=	LEN(STR0004) + aTam1[1] + aTam2[1] + aTam3[1] + 15 //"LIQUIDACAO : "

nTamCHQ := 2 // considerar os 2 tracos
aTamCHQ := TamSX3("E1_BCOCHQ")
nTamCHQ += aTamCHQ[1]
aTamCHQ := TamSX3("E1_AGECHQ")
nTamCHQ += aTamCHQ[1]
aTamCHQ := TamSX3("E1_CTACHQ")
nTamCHQ += aTamCHQ[1]
nTamE1NUM := TamSX3("E1_NUM")[1]+2//Margem

oSection1 := TRSection():New(oReport,STR0005,{"TRB","SE1","SA1"},)//"No. da Liquidação"
TRCell():New(oSection1,"LIQUIDA" ,,STR0005,,nTamLiq,.F.,)//"No. da Liquidação"
oSection1:SetHeaderSection(.F.)

nTamStat := 15

oSection11 := TRSection():New(oSection1,STR0006,{"TRB","SE1","SA1"},) // "Titulos Liquidados"
TRCell():New(oSection11,"E1_PREFIXO" ,"SE1",STR0007,,,.F.,)  //"PRF"
TRCell():New(oSection11,"E1_NUM" ,"SE1",STR0008,,nTamE1NUM,.F.,)  //"NUMERO"
TRCell():New(oSection11,"E1_PARCELA" ,"SE1",STR0009,,,.F.,)  //"PARCELA"
TRCell():New(oSection11,"E1_TIPO" ,"SE1",STR0010,,,.F.,)  //"TIPO"
TRCell():New(oSection11,"E1_EMISSAO" ,"SE1",STR0011,,,.F.,)  //"EMISSAO"
TRCell():New(oSection11,"E1_EMITCHQ" ,"SE1",STR0012,,,.F.,)  //"EMITENTE"
TRCell():New(oSection11,"VALOR",,STR0013,"@E 9,999,999,999.99",16,.F.,)  //"VALOR"
TRCell():New(oSection11,"VALORLIQ",,STR0035,"@E 9,999,999,999.99",16,.F.,)  //"VALOR LIQUIDADO"
TRCell():New(oSection11,"JUROS",,STR0014,"@E 9,999,999.99",12,.F.,)  //"JUROS"
TRCell():New(oSection11,"DESCONTOS",,STR0015,"@E 9,999,999.99",12,.F.,)  //"DESCONTOS"
TRCell():New(oSection11,"ACESSORIO",,STR0036,"@E 9,999,999.99",12,.F.,)  //"Vlr. Acessorio"
TRCell():New(oSection11,"E1_BCOCHQ" ,"SE1",STR0016+"-"+STR0017+"-"+STR0018,,nTamCHQ,.F.,)  //"BANCO"##"AGENCIA"##"CONTA"
TRCell():New(oSection11,"STATUS" ,,STR0029,,nTamStat,.F.,)  //"STATUS"

oSection11:Cell("E1_EMISSAO"):SetSize(15)

//GESTAO - inicio
//Relacao das filiais selecionadas para compor o relatorio
oSecFil := TRSection():New(oReport,"SECFIL",{"SE1","SED"})
TRCell():New(oSecFil,"CODFIL" ,,STR0030,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0031,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0032,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0033,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Filial"
//GESTAO - fim

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³10.07.06  ³±±
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
Local oSection1		as Object
Local oSection11	as Object
Local cAlias1		as Character
Local cAlias2		as Character
Local cWhere		as Character
Local aCampos		as Array
Local aTam			as Array
Local cCondE5		as Character
Local cIndexSE5		as Character
Local cChaveSE5		as Character
Local nIndex		as Numeric
Local cCondE1		as Character
Local nTaxa			as Numeric
Local nValor		as Numeric
Local lParcial		as Logical
Local cChvTit		as Character
Local nJurDesc		as Numeric
//Gestao
Local cFilAtu		as Character
Local lGestao		as Logical
Local aSelFil		as Array
Local aTmpFil		as Array
Local cTmpSE1Fil	as Character
Local cTmpSE5Fil 	as Character
Local bWhile 		as Block
Local nX 			as Numeric
Local oSecFil		as Object
Local cFilSE1		as Character
Local cFilSE5		as Character
Local nVAcess		as Numeric
Local cChaveTit 	as Character
Local aIDORIG		as Array
Local i 			as Numeric
local nTamLiq 		as Numeric
Local lFilOrig		as Logical
Local cRngFilSE1	as Character
Local cRngFilSE5 	as Character
Local aSM0			as Array
Local nTamEmp		as Numeric
Local nTamUnNeg		as Numeric
Local cTitulo		as Character
Local nTamTit		as Numeric
Local cFilSel		as Character
Local nLinha		as Numeric

oSection1	:= oReport:Section(1)
oSection11	:= oReport:Section(1):Section(1)
cAlias1		:= GetNextAlias()
cAlias2		:= GetNextAlias()
cWhere		:= ""
aCampos		:= {}
aTam		:= {}
cCondE5		:= ""
cIndexSE5	:= ""
cChaveSE5	:= ""
nIndex		:= 0
cCondE1		:= ""
nTaxa		:= 1
nValor		:= 0
lParcial	:= .F.
cChvTit		:= ""
nJurDesc	:= 0
//Gestao
cFilAtu		:= cFilAnt
lGestao		:= ( FWSizeFilial() > 2 ) 	// Indica se usa Gestao Corporativa
aSelFil		:= {}
aTmpFil		:= {}
cTmpSE1Fil	:= ""
cTmpSE5Fil 	:= ""
bWhile 		:= {|| .T. }
nX 			:= 0
oSecFil		:= oReport:Section("SECFIL")
cFilSE1		:= ""
cFilSE5		:= ""
nVAcess		:= 0
cChaveTit 	:= ""
aIDORIG		:= {}
i 			:= 0
nTamLiq 	:= TamSx3("E1_NUMLIQ")[1]
lFilOrig	:= getComp("SE1")=="CCC"
cRngFilSE1	:= ""
cRngFilSE5	:= ""
aSM0		:= {}
nTamEmp		:= 0
nTamUnNeg	:= 0
cTitulo		:= ""
nTamTit		:= 0
cFilSel		:= ""

Pergunte(cPerg,.F.)

__lExFO0 := TableInDic('FO0') .And. TableInDic('FO1') .And. TableInDic('FO2')

Fr501MotBx("LIQ","LIQUIDACAO","ANSS")// Cria motivo de baixa LIQ 

//Gestao
//Selecao de filiais
If mv_par08 == 1
	AdmSelecFil("FIN501",8,.F.,@aSelFil,"SE1",.F.)
EndIf

If Empty(aSelFil)
	aSelFil := {cFilAnt}
EndIf

cRngFilSE1 := GetRngFil( aSelFil, "SE1", .T., @cTmpSE1Fil, NIL, lFilOrig )
aAdd(aTmpFil, cTmpSE1Fil)
cRngFilSE5 := GetRngFil( aSelFil, "SE5", .T., @cTmpSE5Fil, NIL, lFilOrig )
aAdd(aTmpFil, cTmpSE5Fil)

//Gestao
//Imprime a lista de filiais selecionadas para o relatorio
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
		EndIf
	Next nX
	oReport:SetTitle(cTitulo)
	oSecFil:Finish()
	oReport:EndPage()
EndIf

dbSelectArea("SE5")
//Gestao
//Monto expressao para Query

cFilSE5 := " E5_FILIAL "+ cRngFilSE5 + " AND "
cFilSE5 := "%" + cFilSE5 + "%"

dbSelectArea("SE1")
//Gestao
//Monto expressao para Query
cFilSE1 := if(lFilOrig," E1_FILORIG "," E1_FILIAL ") + cRngFilSE1 + " AND "
cFilSE1 := "%" + cFilSE1 + "%"

cWhere := " AND E5_DOCUMEN >= '"+ PADR(mv_par01,TamSx3("E5_DOCUMEN")[1]) + "' "
cWhere += " AND E5_DOCUMEN <= '"+ PADR(mv_par02,TamSx3("E5_DOCUMEN")[1]) + "' "
cWhere += " AND E5_DOCUMEN <> '"+ Space(TamSx3("E5_DOCUMEN")[1]) + "'"
cWhere := "%" + cWhere + "%"

//baixados
if lFilOrig
	BeginSql Alias cAlias1
		
		SELECT DISTINCT SE5.*
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
				E5_RECPAG = 'R' AND
				E5_TIPODOC = 'BA' AND
				SE5.%NotDel%
				%Exp:cWhere%

	EndSQL
else
	BeginSql Alias cAlias1

		SELECT SE5.*
		FROM %table:SE5% SE5
		WHERE
				%exp:cFilSE5%
				E5_CLIFOR >= %exp:mv_par03% AND
				E5_CLIFOR <= %exp:mv_par04% AND
				E5_MOTBX = 'LIQ' AND
				E5_SITUACA <> 'C' AND
				E5_RECPAG = 'R' AND
				E5_TIPODOC = 'BA' AND
				SE5.%NotDel%
				%Exp:cWhere%
	EndSQL
end

cWhere := " AND E1_NUMLIQ <> '"+ Space(TamSx3("E1_NUMLIQ")[1]) + "'"
If !__lExFO0
	cWhere := "AND  (E1_BCOCHQ <> ' ' OR E1_TIPO = 'NCC') "
EndIf
cWhere := "%" + cWhere + "%"
//gerados SE1
BeginSql Alias cAlias2
	column E1_EMISSAO as Date
	SELECT SE1.*
	FROM %table:SE1% SE1
	WHERE
			%exp:cFilSE1%
			E1_CLIENTE >= %exp:mv_par03% AND
			E1_CLIENTE <= %exp:mv_par04% AND
			E1_NUMLIQ >=  %exp:mv_par01% AND
			E1_NUMLIQ <= %exp:mv_par02% AND
			SE1.%NotDel%
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
AADD(aCampos,{"EMITENTE","C",40,0})
AADD(aCampos,{"VALOR"  ,"N",18,2})
AADD(aCampos,{"VALORLIQ"  ,"N",18,2})
AADD(aCampos,{"JUROS"  ,"N",18,2})
AADD(aCampos,{"DESCONT","N",18,2})
aTam:=TamSX3("E1_BCOCHQ")
AADD(aCampos,{"BANCO","C",aTam[1],aTam[2]})
aTam:=TamSX3("E1_AGECHQ")
AADD(aCampos,{"AGENCIA","C",aTam[1],aTam[2]})
aTam:=TamSX3("E1_CTACHQ")
AADD(aCampos,{"CONTA","C",aTam[1],aTam[2]})
AADD(aCampos,{"BG"     ,"C", 1,0}) // Baixado ou Gerado
AADD(aCampos,{"TIPOBX"  ,"C",1,0})
AADD(aCampos,{"IDORIG"  ,"C",50,0})

If _oFINR5011 <> Nil
	_oFINR5011:Delete()
	_oFINR5011 := Nil
Endif

_oFINR5011 := FWTemporaryTable():New( "Trb" )  
_oFINR5011:SetFields(aCampos) 	
_oFINR5011:AddIndex("1", {"NUMLIQ","BG","PREFIXO","NUMTIT","PARCELA","TIPO"}) 

//------------------
//Criação da tabela temporaria
//------------------
_oFINR5011:Create()				

// Titulos Gerados na liquidacao - SE1
If mv_par05 != 2
	While (cAlias2)->(!Eof())
		If MV_PAR06 <> 1
			DbSelectArea( "SM2" )
			SM2->( DbSetOrder( 1 ) )
			If SM2->( DbSeek( DtoS( IIf( MV_PAR06 == 2, DDATABASE, (cAlias2)->E1_EMISSAO ) ) ) )
				If FieldPos( "M2_MOEDA" + MV_PAR07 ) > 0
					nTaxa := SM2->&( "M2_MOEDA" + MV_PAR07 )
				EndIf
			EndIf
		EndIf

		DBSelectArea("Trb")
		RecLock("Trb",.T.)
		Trb->CLIENTE	:= (cAlias2)->E1_CLIENTE
		Trb->LOJA		:= (cAlias2)->E1_LOJA
		Trb->NUMLIQ		:= (cAlias2)->E1_NUMLIQ
		Trb->PREFIXO	:= (cAlias2)->E1_PREFIXO
		Trb->NUMTIT		:= (cAlias2)->E1_NUM
		Trb->PARCELA	:= (cAlias2)->E1_PARCELA
		Trb->TIPO		:= (cAlias2)->E1_TIPO
		Trb->EMISSAO	:= (cAlias2)->E1_EMISSAO
		Trb->VALOR		:= iif( MV_PAR06 == 1, (cAlias2)->E1_VALOR, xMoeda((cAlias2)->E1_VALOR, (cAlias2)->E1_MOEDA, val(MV_PAR07), IIf( MV_PAR06 == 2, DDATABASE, (cAlias2)->E1_EMISSAO ) ) )
		Trb->JUROS		:= (cAlias2)->E1_ACRESC
		Trb->BANCO		:= (cAlias2)->E1_BCOCHQ
		Trb->AGENCIA	:= (cAlias2)->E1_AGECHQ
		Trb->CONTA		:= (cAlias2)->E1_CTACHQ
		Trb->EMITENTE 	:= Substr((cAlias2)->E1_EMITCHQ,1,40)
		Trb->BG			:= "G"	// Gerado
		Trb->TIPOBX		:= ""
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
				If FieldPos( "M2_MOEDA" + MV_PAR07 ) > 0
					nTaxa := SM2->&( "M2_MOEDA" + MV_PAR07 )
				EndIf
			EndIf
		EndIf

		SE1->(dbSetOrder(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
		SE1->(DbSeek(xFilial("SE1",(cAlias1)->E5_FILORIG)+(cAlias1)->(E5_CLIFOR+E5_LOJA+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))

		DBSelectArea("Trb")
		RecLock("Trb",.T.)
		Trb->CLIENTE	:= (cAlias1)->E5_CLIFOR
		Trb->LOJA		:= (cAlias1)->E5_LOJA
		Trb->NUMLIQ		:= Substr((cAlias1)->E5_DOCUMEN,1,nTamLiq)
		Trb->PREFIXO	:= (cAlias1)->E5_PREFIXO
		Trb->NUMTIT		:= (cAlias1)->E5_NUMERO
		Trb->PARCELA	:= (cAlias1)->E5_PARCELA
		Trb->TIPO		:= (cAlias1)->E5_TIPO
		Trb->EMISSAO	:= SE1->E1_EMISSAO
		nValor			:= IIf( MV_PAR06 == 1, SE1->E1_VALOR, xMoeda( SE1->E1_VALOR, SE1->E1_MOEDA, VAL(MV_PAR07), IIf( MV_PAR06 == 2, DDATABASE, SE1->E1_EMISSAO ) ) )	
		Trb->VALOR		:= nValor
		Trb->VALORLIQ	:= (cAlias1)->E5_Valor
		Trb->JUROS		:= (cAlias1)->E5_VLJUROS
		Trb->DESCONT	:= (cAlias1)->E5_VLDESCO
		Trb->EMITENTE 	:= SUBSTR(SE1->E1_EMITCHQ,1,40)
		Trb->BG			:= "B"	// Baixado
		
		If (cAlias1)->E5_SITUACA <> 'C' .AND. (cAlias1)->E5_MOTBX == 'LIQ'
			Trb->IDORIG		:= (cAlias1)->E5_IDORIG
		EndIF
		
		//Verifica Baixas Parciais
		cChvTit  := xFilial("SE5",(cAlias1)->E5_FILORIG)+(cAlias1)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR)
		nJurDesc := (cAlias1)->E5_VLJUROS + (cAlias1)->E5_VLDESCO

		aAreaSE5 := SE5->(GetArea())
		dbSelectArea("SE5")
		dbSetOrder(7)

		If dbSeek(cChvTit)
			While SE5->( ! EoF() .And. E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR == cChvTit )
				If SE5->E5_TIPODOC == "BA" 		.And. ;
				   ! SE5->E5_SITUACA $ "C,E,X" 	.And. ;
				   nValor > (SE5->E5_VALOR - nJurDesc)
					If SE1-> E1_SALDO != 0
						lParcial := .T.
						Exit
					EndIf
				EndIf
				SE5->(dbSkip())
			Enddo
		EndIf

		If lParcial
			Trb->TIPOBX := "P" //Parcial
		Else
			Trb->TIPOBX := "T" //Total
		EndIf

		Trb->( MsUnlock() )

		lParcial := .F.

		SE5->(RestArea(aAreaSE5))

		(cAlias1)->(dbSkip())
	EndDo
EndIf

oReport:SetPageFooter(4,{|| If(!oSection11:Printing(),F501Legenda(oReport),"")})

oSection1:Cell("LIQUIDA"):SetBlock( {|| STR0004 + Trb->NUMLIQ + "-" + Trb->CLIENTE + "-" + Trb->LOJA + " - " + STR0020}) //"LIQUIDACAO : "##"A Receber"
TRPosition():New( oSection1, "SA1", 1, {|| xFilial("SA1") + Trb->CLIENTE + Trb->LOJA   })
TRPosition():New( oSection11, "SE1", 1, {|| xFilial("SE1") + Trb->PREFIXO + Trb->NUMTIT + Trb->PARCELA + Trb->TIPO})

oSection11:Cell("E1_PREFIXO"):SetBlock(	{|| Trb->PREFIXO })
oSection11:Cell("E1_NUM"	):SetBlock(	{|| Alltrim(Trb->NUMTIT) })
oSection11:Cell("E1_PARCELA"):SetBlock(	{|| Trb->PARCELA })
oSection11:Cell("E1_TIPO"	):SetBlock(	{|| Trb->TIPO })
oSection11:Cell("E1_EMISSAO"):SetBlock(	{|| Trb->EMISSAO })
oSection11:Cell("E1_EMITCHQ"):SetBlock(	{|| Trb->EMITENTE })
oSection11:Cell("VALOR"	   	):SetBlock(	{|| Trb->VALOR })
oSection11:Cell("VALORLIQ" 	):SetBlock(	{|| Trb->VALORLIQ })
oSection11:Cell("JUROS"	   	):SetBlock(	{|| Trb->JUROS })
oSection11:Cell("DESCONTOS"	):SetBlock(	{|| Trb->DESCONT })
oSection11:Cell("ACESSORIO"	):SetBlock(	{|| CalcVA(Trb->PREFIXO , Trb->NUMTIT , Trb->PARCELA , Trb->TIPO , Trb->CLIENTE , Trb->LOJA, Trb->IDORIG) })
oSection11:Cell("E1_BCOCHQ"	):SetBlock(	{|| If (Empty(Trb->(BANCO+AGENCIA+CONTA))," ", Trb->BANCO+"-"+Trb->AGENCIA+"-"+Trb->CONTA) })
oSection11:Cell("STATUS"   	):SetBlock(	{|| If(Trb->BG == "B",Iif(Trb->TIPOBX == "P",STR0021,STR0022),STR0023) })//"Baixa Parc. "##"Baixado"##"Gerado"

//Faz o alinhamento do cabecalho das celulas
oSection11:Cell("E1_PREFIXO"):SetHeaderAlign("CENTER")
oSection11:Cell("E1_NUM" 	):SetHeaderAlign("CENTER")
oSection11:Cell("E1_PARCELA"):SetHeaderAlign("CENTER")
oSection11:Cell("E1_TIPO"	):SetHeaderAlign("CENTER")
oSection11:Cell("E1_EMISSAO"):SetHeaderAlign("CENTER")
oSection11:Cell("E1_EMITCHQ"):SetHeaderAlign("CENTER")
oSection11:Cell("VALOR"		):SetHeaderAlign("RIGHT")
oSection11:Cell("VALORLIQ"	):SetHeaderAlign("RIGHT")
oSection11:Cell("JUROS" 	):SetHeaderAlign("RIGHT")
oSection11:Cell("ACESSORIO" ):SetHeaderAlign("RIGHT")
oSection11:Cell("DESCONTOS"	):SetHeaderAlign("RIGHT")
oSection11:Cell("E1_BCOCHQ"	):SetHeaderAlign("RIGHT")
oSection11:Cell("STATUS" 	):SetHeaderAlign("LEFT")

oSection11:SetHeaderPage(.T.)

oSection11:SetParentFilter({|cParam| Trb->(NUMLIQ+CLIENTE+LOJA) == cParam},{|| Trb->(NUMLIQ+CLIENTE+LOJA)})

TRFunction():New(oSection11:Cell("VALOR")		,"T_VAL" ,"SUM",,Iif(mv_par05 == 1,STR0024,STR0025),,{|| If(mv_par05==1,If(Trb->BG=="G",Trb->VALOR,Iif(Trb->JUROS>0,Trb->JUROS*(-1),0)), Trb->VALOR) },.T.,.F.) //"Total Liq. "##"Totais "
TRFunction():New(oSection11:Cell("JUROS")		,"T_JUR" ,"SUM",,Iif(mv_par05 == 1,STR0024,STR0025),,,.T.,.F.)//"Total Liq. "##"Totais "
TRFunction():New(oSection11:Cell("DESCONTOS")	,"T_DESC" ,"SUM",,Iif(mv_par05 == 1,STR0024,STR0025),,,.T.,.F.)//"Total Liq. "##"Totais "
TRFunction():New(oSection11:Cell("ACESSORIO")	,"T_ACES" ,"SUM",,Iif(mv_par05 == 1,STR0024,STR0025),,,.T.,.F.)//"Total Liq. "##"Totais "

oSection11:SetTotalInLine(.F.)
oSection11:SetTotalText(Iif(mv_par05 == 1,STR0024,STR0025)) //"Total Liq. "##"Totais "
oSection1:Print()

Trb->(dbCloseArea())

//Deleta tabela temporária do banco de dados
If _oFINR5011 <> Nil
	_oFINR5011:Delete()
	_oFINR5011 := Nil
Endif

//Gestao
//Apagar o arquivo temporario de filiais criados no banco
For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])
Next nX

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³FR501MotBXºAutor  ³Marcelo Celi Marquesº Data ³  23/01/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao criar automaticamente o motivo de baixa LIQ na      º±±
±±º          ³ tabela Mot baixas                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR501                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fr501MotBx(cMot,cNomMot, cConfMot)
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
		EndIf
	Endif

	FwFreeArray(aMotBx)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F501LegendaºAutor  ³Microsiga           º Data ³  06/02/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Legenda do relatorio.                                       º±±
±±º          ³                                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F501Legenda(oReport)

oReport:PrintText( STR0026 ) //"Observações: "
oReport:PrintText( STR0027 ) //"- Os títulos baixados são impressos com o valor original, independente da forma da baixa. "
oReport:PrintText( STR0028 ) //"- Os totalizadores consideram o valor total da liquidação ou dos títulos gerados/baixados."

Return

//----------------------------------------------------------------------------
/*/{Protheus.doc} CalcVA
Função responsavel por somar os valores acessorios de acordo com a FxLoadFK6

@author jose.aribeiro
@since 28/09/2016
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
Static Function CalcVA(cPrefixo,cNum,cParcela,cTipo,cCliente,cLoja,cIDORIG)
Local cChaveFK7		:= ""
Local cChave		:= ""
Local nValorAces	:= 0
Local lFxLoadFK6	:= ExistFunc('FxLoadFK6')
	
cChave := xFilial("SE1") + "|" + cPrefixo + "|" +  cNum + "|" + cParcela + "|" + cTipo + "|" +  cCliente + "|" + cLoja
cChaveFK7 := FINGRVFK7("SE1", cChave)

aAreaSE5 := SE5->(GetArea())

DbSelectArea("SE5")
SE5->( dbGoTop() ) 	
DBSetOrder(21) //E5_FILIAL,E5_IDORGI		
	
If DBSeek(xFilial("SE5") + cIDORIG )
	nValorAces += ( IIf(lFxLoadFK6, FxLoadFK6("FK1",SE5->E5_IDORIG,"VA")[1,2], 0) )
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
