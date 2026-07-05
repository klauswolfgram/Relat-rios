/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR580.CH"
#INCLUDE "PROTHEUS.CH"

STATIC _oFINR5801 := Nil


//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} FinR580

Informe de Fechamento dos caixinhas

@Author	Daniel Tadashi Batori
@since	19/07/2006
/*/
//-----------------------------------------------------------------------------------------------------
User Function FinR580()
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return


//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef

Definicao do layout do Relatorio

@Author	Daniel Tadashi Batori
@since	19/07/2006
/*/
//-----------------------------------------------------------------------------------------------------
Static Function ReportDef()

Local oReport
Local oSection0
Local oSection1
Local oSection11
Local aTam0 //Gestão Corporativa
Local aTam1
Local aTam2
Local nTam0 //Gestão Corporativa
Local nTam1
Local nTam2
Local nTam3
Local cPValor

Pergunte("FIR580", .F.)

oReport := TReport():New("FINR580",STR0001,"FIR580",{|oReport| ReportPrint(oReport)},STR0001)
oReport:SetEdit(.F.)

aTam0 := TamSX3("EU_FILIAL") //Gestão Corporativa
aTam1 := TamSX3("ET_CODIGO")
aTam2 := TamSX3("ET_NOME")
nTam1 := Len(STR0012) + aTam1[1] + aTam2[1] + 1
nTam2 := Max( Len(STR0016), Len(STR0018) ) // STR0016:="Aberto -"   STR0018:="Fechado"
aTam1 := TamSX3("ET_SALDO")
nTam3 := Len(STR0017) + aTam1[1] + 1 //"Saldo: "
nTam0 := Len(STR0037) + aTam0[1] //Gestão Corporativa

oSection0 := TRSection():New(oReport,"",{"TRB"},) //Gestão Corporativa
TRCell():New(oSection0,"FILIAL",,,,nTam0,.F.,) //Gestão Corporativa

oSection1 := TRSection():New(oSection0,STR0030,{"TRB"},) //Gestão Corporativa - Alterado
TRCell():New(oSection1,"CAIXINHA",,,,nTam1,.F.,)  //definido por SetBlock
TRCell():New(oSection1,"SITUACAO",,,,nTam2,.F.,)  //definido por SetBlock
TRCell():New(oSection1,"SALDO",,,,nTam3,.F.,)  //definido por SetBlock

oSection0:SetHeaderSection(.F.) //Gestão Corporativa
oSection1:SetHeaderSection(.F.)

nTam1 := Max( Len(STR0011), Len(STR0015) ) //"Reposicao "    "Reposicao/Fechamento"
cPValor := PesqPict("SEU","EU_VALOR",16)
nTam2 := TamSX3("EU_VALOR")[1]

oSection11 := TRSection():New(oSection1,STR0031,{"TRB"},)
TRCell():New(oSection11,"DESCRIC",,STR0019,"@!",nTam1,.F.,)  //"Descricao"
TRCell():New(oSection11,"EU_DTDIGIT","SEU",STR0020+CRLF+STR0021,,,.F.,)  //"Data de"
TRCell():New(oSection11,"nVlrRep",,STR0022,cPValor,nTam2,.F.,)  //"Valor Reposicao"
TRCell():New(oSection11,"nVlrRnd",,STR0023,cPValor,nTam2,.F.,)  //"Valor Baixado"
TRCell():New(oSection11,"EU_VALOR",,STR0024,cPValor,nTam2,.F.,)  //"Vlr.Devolvido"
TRCell():New(oSection11,"QTDECOMP",,STR0025+CRLF+STR0026,"@E 999",3,.F.,)  //"Nro.Comprov."
TRCell():New(oSection11,"nVlrGst",,STR0027,cPValor,nTam2,.F.,)  //"Tot.Despesas"
TRCell():New(oSection11,"nTotAdia",,STR0028+CRLF+STR0029,cPValor,nTam2,.F.,)  //"Valor Total de"

//Gestão Corporativa - Início
oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0032,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0033,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0034,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0035,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"
//Gestão Corporativa - Fim

Return oReport


//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint

A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser 
agendados pelo usuario.

@Author	Daniel Tadashi Batori
@since	19/07/2006
/*/
//-----------------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)

Local oSection0		:= oReport:Section(1) //Gestão Corporativa
Local oSection1		:= oReport:Section(1):Section(1) //Gestão Corporativa - Alterado
Local oSection11 	:= oReport:Section(1):Section(1):Section(1) //Gestão Corporativa - Alterado
Local cQuery		:= ""
Local cAliasQry1	:= CriaTrab(,.F.)
Local aEstru		:= {}
Local aTam			:= {}
Local nTam			:= 0
Local cCaixa		:= ""
Local cSeqIni		:= ""
Local cSeqFim		:= ""
Local lRepos		:= .F.
Local nVlrRep		:= 0
Local nNrComp		:= 0 
Local nVlrRnd		:= 0 
Local nVlrGst		:= 0
Local nTotAdia		:= 0
Local cPict			:= ""
Local lGestao		:= ( FWSizeFilial() > 2 ) 	// Indica se usa Gestao Corporativa
Local lSETExcl		:= Iif( lGestao, FWModeAccess("SET",1) == "E", FWModeAccess("SET",3) == "E")
Local lSEUExcl		:= Iif( lGestao, FWModeAccess("SEU",1) == "E", FWModeAccess("SEU",3) == "E")
Local aTmpFil		:= {}
Local cTmpSETFil	:= ""
Local nX 			:= 1
Local oSecFil		:= oReport:Section("SECFIL")
Local cFilSET		:= ""
Local nRegSM0		:= SM0->(Recno())
Local aSelFil 		:= {}
Local cRngFilSET	:= ""
Local cFilSel		:= ""
Local cFilialAtu	:= cFilAnt

//Cria a tabela temporária
Fr580Trab()

//Gestao Corporativa - Início
nRegSM0 := SM0->(Recno())

If (lSETExcl .and. lSEUExcl .and. mv_par06 == 1) .or.;
	(!lSETExcl .and. lSEUExcl .and. mv_par06 == 1)
	aSelFil := FwSelectGC()
Endif

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Else
	aSort(aSelFil)
	SM0->(DbGoTo(nRegSM0))
EndIf

If  mv_par06 == 1
	cRngFilSET := GetRngFil( aSelFil, "SET", .T., @cTmpSETFil )
	aAdd(aTmpFil, cTmpSETFil)
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0036 + ")")	//"Filiais selecionadas para o relatorio"
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
	cFilSET := " ET_FILIAL "+ cRngFilSET + " AND "
Else
	cFilSET := " ET_FILIAL = '"+ xFilial("SET",aSelFil[1]) + "' AND "
Endif
cFilSET := "%"+cFilSET+"%"

//-----------------------------------------------------------------
// Filtra pela situacao do caixinha (parametro mv_par05)
//-----------------------------------------------------------------
If mv_par05 == 1	// abertas
	cQuery += " AND ET_SITUAC = 0 "
ElseIf mv_par05 == 2	// fechadas
	cQuery += " AND ET_SITUAC = 1 "
EndIf

cOrdem := SqlOrder(SET->(IndexKey(1)))
cQuery += " ORDER BY "+ cOrdem
cQuery := "%" + cQuery + "%"

BeginSql Alias cAliasQry1
		SELECT *
		FROM %table:SET% SE
		WHERE %exp:cFilSET% //Gestão Corporativa ET_FILIAL = %xFilial:SET% AND
		ET_CODIGO   >= %exp:mv_par01% AND
		ET_CODIGO   <= %exp:mv_par02% AND
		SE.%NotDel%
		%exp:cQuery%
EndSQL

nNrComp  := 0
nVlrRnd  := 0
nTotAdia := 0
nVlrRep  := 0
nVlrGst  := 0
lRepos  := .F.

For nX := 1 To Len(aSelFil)

	If xFilial("SET",aSelFil[nX]) != (cAliasQry1)->ET_FILIAL
		(cAliasQry1)->(DbSkip())
		If (cAliasQry1)->(EOF())
			(cAliasQry1)->(DbGoTop())
		Else
			nX--
		EndIf
		Loop
	EndIf

	cCaixa  := (cAliasQry1)->ET_CODIGO
	cFilAnt := aSelFil[nX]
	cFilAnt := cFilialAtu

	dbSelectArea("SEU")
	dbSetOrder(5)  // FILIAL+CAIXA+SEQUEN+NUMERO

	// Filtra movimentos do caixinha dentro do range parametrizado
	SET FILTER TO (SEU->EU_DTDIGIT >= mv_par03 .and. SEU->EU_DTDIGIT <= mv_par04)
	// Reposiciona registros apos a filtragem
	SEU->(dbGoTop())

	If !dbSeek(xFilial("SEU",aSelFil[nX])+cCaixa)
		(cAliasQry1)->(DbSkip())
		If (cAliasQry1)->(EOF())
			(cAliasQry1)->(DbGoTop())
		Else
			nX--
		EndIf
		Loop
	Else
		nNrComp  := 0
		nVlrRnd  := 0
		nTotAdia := 0
		nVlrRep  := 0
		nVlrGst  := 0
		lRepos  := .F.
	EndIf

	While !SEU->(Eof()) .and. SEU->EU_FILIAL == xFilial("SEU",aSelFil[nX]) .and. SEU->EU_CAIXA == cCaixa
		Do Case
			Case SEU->EU_TIPO == "00"
				nNrComp ++
				nVlrRnd += If( !Empty(SEU->EU_BAIXA), SEU->EU_VALOR, 0)
				nVlrGst += SEU->EU_VALOR
			Case SEU->EU_TIPO == "01"
				nTotAdia += SEU->EU_VALOR
			Case SEU->EU_TIPO == "02"
				nTotAdia -= SEU->EU_VALOR
			Case SEU->EU_TIPO $ "10|12|11|13"
				If lRepos
					RecLock( "TRB" , .T. )
					TRB->EU_CAIXA		:= SEU->EU_CAIXA
					TRB->ET_NOME		:= (cAliasQry1)->ET_NOME

					If (cAliasQry1)->ET_SITUAC == "0" //caixinha aberta
						TRB->SITUACAO	:= STR0016
						TRB->SALDO		:= (cAliasQry1)->ET_SALDO
					Else
						TRB->SITUACAO	:= STR0018
					EndIf

					TRB->EU_FILIAL		:= SEU->EU_FILIAL
					TRB->DESCRIC		:= STR0015 //"Reposicion/Cierre"
					TRB->EU_DTDIGIT		:= SEU->EU_DTDIGIT
					TRB->VlrRep			:= nVlrRep
					TRB->VlrRnd			:= nVlrRnd
					TRB->EU_VALOR		:= If(SEU->EU_TIPO $ "11|13", SEU->EU_VALOR, 0)
					TRB->QTDECOMP		:= nNrComp
					TRB->VlrGst	 		:= nVlrGst
					TRB->TotAdia		:= nTotAdia
					MsUnlock()
				EndIf
				If SEU->EU_TIPO$"10|12"
					nVlrRep  := SEU->EU_VALOR
					lRepos   := .T.
					dDtDigit := SEU->EU_DTDIGIT
				Else
					lRepos  := .F.
				EndIf
		Endcase
		SEU->(dbskip())
	EndDo

	If lRepos // reposicao sem fechamento ainda
		RecLock( "TRB" , .T. )
		TRB->EU_CAIXA		:= (cAliasQry1)->ET_CODIGO
		TRB->ET_NOME		:= (cAliasQry1)->ET_NOME

		If (cAliasQry1)->ET_SITUAC == "0" //caixinha aberta
			TRB->SITUACAO	:= STR0016
			TRB->SALDO		:= (cAliasQry1)->ET_SALDO
		Else
			TRB->SITUACAO	:= STR0018
		EndIf

		TRB->EU_FILIAL	:= aSelFil[nX]
		TRB->DESCRIC	:= STR0011 //"Reposicion"
		TRB->EU_DTDIGIT	:= dDtDigit
		TRB->VlrRep		:= nVlrRep
		TRB->VlrRnd		:= nVlrRnd
		TRB->QTDECOMP	:= nNrComp
		TRB->VlrGst		:= nVlrGst
		TRB->TotAdia	:= nTotAdia
		MsUnlock()
	EndIf

	If !SEU->(EOF()) .And. SEU->EU_FILIAL != xFilial("SEU",aSelFil[nX])
		(cAliasQry1)->(DbGoTop())
	EndIf

	If !SEU->(EOF()) .And. SEU->EU_FILIAL == xFilial("SEU",aSelFil[nX])
		nX--
		(cAliasQry1)->(DbSkip())
	EndIf

Next

SEU->(dbClearFilter())

Do Case
	Case mv_par05 = 1        // SITUACAO EM ABERTO
		oReport:SetTitle( STR0001 + " " + STR0005 )  //"Situacao: Em aberto"
	Case mv_par05 = 2    // SITUACAO FECHADO
		oReport:SetTitle( STR0001 + " " + STR0006 )  //"Sitaucao: Fechadas"
	Case mv_par05 = 3      // AMBAS SITUACOES
		oReport:SetTitle( STR0001 + " " + STR0007 )  //"Situacao: Todas"
EndCase


cPict := PesqPict("SET","ET_SALDO")

If (lQuery .and. lSETExcl .and. lSEUExcl .and. mv_par06 == 1) .or.;
   (lQuery .and. !lSETExcl .and. lSEUExcl .and. mv_par06 == 1)
	oSection1:SetParentFilter({|cParamA| TRB->EU_FILIAL == cParamA},{|| TRB->EU_FILIAL })
EndIf

oSection11:SetParentFilter({|cParamB| TRB->EU_FILIAL+TRB->EU_CAIXA == cParamB},{|| TRB->EU_FILIAL+TRB->EU_CAIXA })

If (lQuery .and. lSETExcl .and. lSEUExcl .and. mv_par06 == 1) .or.;
   (lQuery .and. !lSETExcl .and. lSEUExcl .and. mv_par06 == 1)
	oSection0:Cell("FILIAL"):SetBlock({|| STR0037 + TRB->EU_FILIAL})
EndIf

oSection1:Cell("CAIXINHA"):SetBlock(	{|| STR0012 + TRB->EU_CAIXA + " " + AllTrim(TRB->ET_NOME) } )
oSection1:Cell("SITUACAO"):SetBlock (	{|| TRB->SITUACAO } )
oSection1:Cell("SALDO"):SetBlock (		{|| If(TRB->SITUACAO = STR0018, " ",STR0017 + " " + AllTrim(Transform(TRB->SALDO,cPict)) ) } )
oSection11:Cell("DESCRIC"):SetBlock(	{|| TRB->DESCRIC } )
oSection11:Cell("EU_DTDIGIT"):SetBlock(	{|| TRB->EU_DTDIGIT } )
oSection11:Cell("nVlrRep"):SetBlock(	{|| TRB->VlrRep } )
oSection11:Cell("nVlrRnd"):SetBlock(	{|| TRB->VlrRnd } )
oSection11:Cell("EU_VALOR"):SetBlock(	{|| TRB->EU_VALOR } )
oSection11:Cell("QTDECOMP"):SetBlock(	{|| TRB->QTDECOMP } )
oSection11:Cell("nVlrGst"):SetBlock(	{|| TRB->VlrGst } )
oSection11:Cell("nTotAdia"):SetBlock(	{|| TRB->TotAdia } )

oSection0:Print()

If _oFINR5801 <> Nil
	_oFINR5801:Delete()
	_oFINR5801 := Nil
Endif

//Gestão Corporativa - Início
For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])
Next

Return


//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} FR580Fim

Retorna a ultima sequencia de fechamento para a data 

@Author	Leonardo Ruben
@since	04/07/2000
/*/
//-----------------------------------------------------------------------------------------------------
Static Function FR580Fim( cCaixa, dDtDigit)

Local aAreaAnt	:= GetArea()
Local cSeqFim	:= ""

DEFAULT dDtDigit := dDataBase

dbSelectArea("SEU")
dbSetOrder(4)  // filial+caixa+dtdigit
DbSeek(xFilial()+cCaixa+DTOS(dDtDigit+1),.T.)
dbSkip(-1)
cSeqFim := EU_SEQCXA
cSeqFim := Soma1(cSeqFim)

// Posiciona-se no ultimo registro (fechamento) dessa sequen. 
dbSetOrder(5)  // FILIAL+CAIXA+SEQCXA+NUMERO
DbSeek(xFilial()+mv_par01+cSeqFim,.T.)
dbSkip(-1)
cSeqFim := EU_SEQCXA

RestArea(aAreaAnt)
Return cSeqFim


//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} FR580Ini

Retorna a primeira sequencia de reposicao para a data 

@Author	Leonardo Ruben
@since	04/07/2000
/*/
//-----------------------------------------------------------------------------------------------------
Static Function FR580Ini( cCaixa, dDtDigit)
Local aAreaAnt	:= GetArea()
Local cSeqIni	:= ""

DEFAULT dDtDigit := dDataBase

dbSelectArea("SEU")
dbSetOrder(4)  // filial+caixa+dtdigit
DbSeek(xFilial()+cCaixa+DTOS(dDtDigit),.T.)
If Eof()
	dbSkip(-1)
EndIf
If Bof() .or. cCaixa <> EU_CAIXA  // nao ha registros para esse caixinha
	cSeqIni := "000001"
Else
	cSeqIni := EU_SEQCXA
EndIf

RestArea(aAreaAnt)
Return cSeqIni


//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Fr580Trab

Montagem da tabela temporária do relatório

@Author	Mauricio Pequim Jr
@since	04/06/2018
/*/
//-----------------------------------------------------------------------------------------------------
Static Function Fr580Trab()

Local nX		:= 0
Local nTam		:= 0
Local aEstru	:= {}
Local aTam		:= {}

aTam := TamSX3("EU_FILIAL")
Aadd(aEstru, { "EU_FILIAL"	, "C"	,	aTam[1]	,	aTam[2]	} )	// "FILIAL"
aTam := TamSX3("EU_CAIXA")
Aadd(aEstru, { "EU_CAIXA"	, "C"	,	aTam[1]	,	aTam[2]	} )	// "CAIXINHA"
aTam := TamSX3("ET_NOME")
Aadd(aEstru, { "ET_NOME"	, "C"	,	aTam[1]	,	aTam[2]	} )	// "CAIXINHA"
nTam := Max( Len(STR0016), Len(STR0018) )
Aadd(aEstru, { "SITUACAO"	, "C"	,	nTam		,	0 	} )	// "SITUACAO"
aTam := TamSX3("ET_SALDO")
Aadd(aEstru, { "SALDO"		, "N"	,	aTam[1]	,	aTam[2]	} )	// "SALDO"
nTam := Max( Len(STR0011), Len(STR0015) )
Aadd(aEstru, { "DESCRIC"	, "C"	,	nTam		,	0 	} )	// "DESCRIC"
aTam := TamSX3("EU_DTDIGIT")
Aadd(aEstru, { "EU_DTDIGIT"	, "D"	,	aTam[1]	,	aTam[2]	} )	// "EU_DTDIGIT"
aTam := TamSX3("ET_SALDO")
Aadd(aEstru, { "VLRREP"		, "N"	,	aTam[1]	,	aTam[2]	} )	// "nVlrRep"
Aadd(aEstru, { "VLRRND"		, "N"	,	aTam[1]	,	aTam[2]	} )	// "nVlrRnd"
Aadd(aEstru, { "EU_VALOR"	, "N"	,	aTam[1]	,	aTam[2]	} )	// "EU_VALOR"
Aadd(aEstru, { "QTDECOMP"	, "N"	,	3			,	0	} )	// "QTDECOMP"
Aadd(aEstru, { "VLRGST"		, "N"	,	aTam[1]	,	aTam[2]	} )	// "nVlrGst"
Aadd(aEstru, { "TOtADIA"	, "N"	,	aTam[1]	,	aTam[2]	} )	// "nTotAdia"

If _oFINR5801 <> Nil
	_oFINR5801:Delete()
	_oFINR5801 := Nil
Endif

// Criação da Tabela Temporßria >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_oFINR5801 := FWTemporaryTable():New( "TRB" )  
_oFINR5801:SetFields(aEstru) 
_oFINR5801:AddIndex("1", {"EU_FILIAL","EU_CAIXA"})

_oFINR5801:Create() 	

Return