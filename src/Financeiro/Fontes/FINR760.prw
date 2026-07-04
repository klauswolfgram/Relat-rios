/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR760.CH"
#INCLUDE "PROTHEUS.CH"

Static _oFr760TRB := NIL
Static oPrepared  := NIL

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} FINR760

Eficiência da Contas a Pagar.  	

@Author	Marcio Menon 
@since	18/08/2006
/*/
//-----------------------------------------------------------------------------------------------------
User Function FINR760()

Local oReport	:= NIL
Local aArea		:= GetArea()

oReport := ReportDef()
oReport:PrintDialog()

If _oFr760TRB <> Nil
	_oFr760TRB:Delete()
	_oFr760TRB := Nil
Endif

RestArea(aArea)

Return


//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef

Definicao do objeto do relatorio personalizavel e das secoes que serao utilizadas.

@Author	Marcio Menon 
@since	18/08/2006
/*/
//-----------------------------------------------------------------------------------------------------
Static Function ReportDef()

Local oReport	:= NIL
Local aAreaSM0	:= {}
Local oSection1	:= NIL
Local oSection2	:= NIL
Local oFilial	:= NIL
Local oSecFil	:= NIL
Local cReport 	:= "FINR760" 				// Nome do relatorio
Local cDescri 	:= STR0001 + " " + STR0002	//"Este programa ir  emitir um resumo referente ao contas a pagar"###//"referente aos ultimos 30 dias."
Local cTitulo 	:= STR0009  				//"Eficiencia do Contas a Pagar"
Local cPerg		:= "FIN760"					// Nome do grupo de perguntas

//-------------------------------------------------------------------------
// Verifica as perguntas selecionadas
//-------------------------------------------------------------------------
aAreaSM0 := SM0->(GetArea())
pergunte("FIN760",.F.)
RestArea(aAreaSM0)

//-------------------------------------------------------------------------
// Variaveis utilizadas para parametros
// mv_par01            // Prefixo de
// mv_par02            // Prefixo ate
// mv_par03            // Natureza de
// mv_par04            // Natureza ate
// mv_par05            // Seleciona tipos
// mv_par06            // Qual Moeda
// mv_par07            // Outras Moedas
// mv_par08            // Seleciona Filiais?
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
//Criacao do componente de impressao
//
//TReport():New
//ExpC1 : Nome do relatorio
//ExpC2 : Titulo
//ExpC3 : Pergunte
//ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
//ExpC5 : Descricao
//-------------------------------------------------------------------------
oReport := TReport():New(cReport, cTitulo, cPerg, {|oReport| ReportPrint(oReport)}, cDescri)
oReport:SetLandscape()	//Imprime o relatorio no formato paisagem

//-------------------------------------------------------------------------
//                      Definicao das Secoes
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
// Secao 01
//-------------------------------------------------------------------------
oSection1 := TRSection():New(oReport, STR0039, "cNomeArq")

TRCell():New(oSection1,"TXTSALDO","", ,/*Picture*/,24,/*lPixel*/,{|| STR0012 + DtoC(cNomeArq->DATAX) })					//"ANTERIOR A "
TRCell():New(oSection1,"DESCO_A" ,"", STR0013+CRLF+STR0014+CRLF+STR0015,Tm(0,14),14,/*lPixel*/,/*CodeBlock*/) 			//"VLS. PAGOS" "S/ATRASO" "DESCONTO"
TRCell():New(oSection1,"ACRES_A" ,"", STR0013+CRLF+STR0014+CRLF+STR0017,Tm(0,14),14,/*lPixel*/,/*CodeBlock*/) 			//"VLS. PAGOS" "S/ATRASO" "ACRESCIMO"
TRCell():New(oSection1,"VALOR_C" ,"", STR0013+CRLF+STR0014+CRLF+STR0018,Tm(0,14),14,/*lPixel*/,/*CodeBlock*/) 			//"VLS. PAGOS" "S/ATRASO" "TOTAL PAGO"
TRCell():New(oSection1,"DESCO_B" ,"", STR0013+CRLF+STR0016+CRLF+STR0015,Tm(0,14),14,/*lPixel*/,{|| cNomeArq->DESCO_B }) //"VLS. PAGOS" "C/ATRASO" "DESCONTO"
TRCell():New(oSection1,"ACRES_B" ,"", STR0013+CRLF+STR0016+CRLF+STR0017,Tm(0,14),14,/*lPixel*/,{|| cNomeArq->ACRES_B }) //"VLS. PAGOS" "C/ATRASO" "DESCONTO" "ACRESCIMO"
TRCell():New(oSection1,"VALOR_D" ,"", STR0013+CRLF+STR0016+CRLF+STR0018,Tm(0,14),14,/*lPixel*/,{|| cNomeArq->VALOR_D }) //"VLS. PAGOS" "C/ATRASO" "TOTAL PAGO"
TRCell():New(oSection1,"NVALORE" ,"", STR0019+CRLF+STR0020+CRLF+STR0021,Tm(0,14),14,/*lPixel*/,/*CodeBlock*/) 			//"VALOR NAO PAGO" "NO DIA DO" "VENCIMENTO"
TRCell():New(oSection1,"EFICIEN" ,"", STR0022+CRLF+STR0023, Tm(0,08),08,/*lPixel*/,/*CodeBlock*/) 						//"EFICIEN" "CIA (%)"
TRCell():New(oSection1,"VALOR_G" ,"", STR0024+CRLF+STR0025, Tm(0,16),16,/*lPixel*/,{|| cNomeArq->VALOR_G })				//"SALDO PENDENTE" "EM "

//Oculta as celulas
oSection1:Cell("DESCO_A"):Hide()
oSection1:Cell("ACRES_A"):Hide()
oSection1:Cell("VALOR_C"):Hide()
oSection1:Cell("NVALORE"):Hide()
oSection1:Cell("EFICIEN"):Hide()
oSection1:SetNoFilter("cNomeArq")
oSection1:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao

//-------------------------------------------------------------------------
// Secao 02
//-------------------------------------------------------------------------
oSection2 := TRSection():New(oSection1, STR0038, "cNomeArq")

TRCell():New(oSection2,"DATAX"  ,"",  STR0026+CRLF+STR0027              ,/*Picture*/,10,/*lPixel*/,{|| cNomeArq->DATAX } ) //"DATA" "VENCTO"
TRCell():New(oSection2,"VALOR_B" ,"", STR0028+CRLF+STR0029              ,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->VALOR_B } ) //"VALOR DOS" "TITULOS"
TRCell():New(oSection2,"DESCO_A" ,"", STR0013+CRLF+STR0014+CRLF+STR0015 ,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->DESCO_A } )//"VLS. PAGOS" "S/ATRASO" "DESCONTO"
TRCell():New(oSection2,"ACRES_A" ,"", STR0013+CRLF+STR0014+CRLF+STR0017	,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->ACRES_A } ) //"VLS. PAGOS" "S/ATRASO" "ACRESCIMO"
TRCell():New(oSection2,"VALOR_C" ,"", STR0013+CRLF+STR0014+CRLF+STR0018 ,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->VALOR_C } ) //"VLS. PAGOS" "S/ATRASO" "TOTAL PAGO"
TRCell():New(oSection2,"DESCO_B" ,"", STR0013+CRLF+STR0016+CRLF+STR0015	,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->DESCO_B } ) //"VLS. PAGOS" "C/ATRASO" "DESCONTO"
TRCell():New(oSection2,"ACRES_B" ,"", STR0013+CRLF+STR0016+CRLF+STR0017	,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->ACRES_B } ) //"VLS. PAGOS" "C/ATRASO" "ACRESCIMO"
TRCell():New(oSection2,"VALOR_D" ,"", STR0013+CRLF+STR0016+CRLF+STR0018 ,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->VALOR_D } ) //"VLS. PAGOS" "C/ATRASO" "TOTAL PAGO"
TRCell():New(oSection2,"NVALORE" ,"", STR0019+CRLF+STR0020+CRLF+STR0021 ,Tm(0,14)	,14,/*lPixel*/,/*CodeBlock*/) //"VALOR NAO PAGO" "NO DIA DO" "VENCIMENTO"
TRCell():New(oSection2,"EFICIEN" ,"", STR0022+CRLF+STR0023				,Tm(0,08)	,08,/*lPixel*/,/*CodeBlock*/) //"EFICIEN" "CIA (%)"
TRCell():New(oSection2,"VALOR_G" ,"", STR0024+CRLF+STR0025				,Tm(0,16)	,16,/*lPixel*/,{|| cNomeArq->VALOR_G } )//"SALDO PENDENTE" "EM "
TRCell():New(oSection2,"ATUAL"   ,"", STR0030+CRLF+STR0031				,Tm(0,08)	,08,/*lPixel*/,/*CodeBlock*/)//"ATUAL" "(%)"
TRCell():New(oSection2,"PGTDI_H" ,"", STR0032+CRLF+STR0033+CRLF+STR0034	,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->PGTDI_H } )//"ATUAL VLR." "DEBITADO" "NO DIA"
TRCell():New(oSection2,"BAIXADIA","", STR0035+CRLF+STR0034 			 	,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->BAIXADIA } )//"VALOR BAIXADO" "NO DIA"
TRCell():New(oSection2,"NOCREDIT","", STR0035+CRLF+STR0036+CRLF+STR0037	,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->NOCREDIT } )//"VALOR BAIXADO" "SEM DEBITO" "APOS "

//Faz o alinhamento do cabecalho das celulas
oSection2:Cell("VALOR_B"):SetHeaderAlign("CENTER")
oSection2:Cell("DESCO_A"):SetHeaderAlign("CENTER")
oSection2:Cell("ACRES_A"):SetHeaderAlign("CENTER")
oSection2:Cell("VALOR_C"):SetHeaderAlign("CENTER")
oSection2:Cell("DESCO_B"):SetHeaderAlign("CENTER")
oSection2:Cell("ACRES_B"):SetHeaderAlign("CENTER")
oSection2:Cell("VALOR_D"):SetHeaderAlign("CENTER")
oSection2:Cell("NVALORE"):SetHeaderAlign("CENTER")
oSection2:Cell("EFICIEN"):SetHeaderAlign("CENTER")
oSection2:Cell("VALOR_G"):SetHeaderAlign("CENTER")
oSection2:Cell("ATUAL"	):SetHeaderAlign("CENTER")
oSection2:Cell("PGTDI_H"):SetHeaderAlign("CENTER")
oSection2:Cell("BAIXADIA"):SetHeaderAlign("CENTER")
oSection2:Cell("NOCREDIT"):SetHeaderAlign("CENTER")
oSection2:SetNoFilter("cNomeArq")
oSection2:SetTotalInLine (.F.) 	//O totalizador da secao sera impresso em coluna

oFilial := TRSection():New(oReport,"",{"SE2"})
TRCell():New(oFilial,"Filial",,,,TamSx3("E2_FILIAL")[1] + Len(STR0041)) //"Filial : "
oFilial:SetHeaderSection(.F.)

oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0042,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0043,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0044,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0045,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

oReport:SetUseGC(.F.)

Return oReport


//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint

Imprime o objeto oReport definido na funcao ReportDef

@param oReport - Objeto TReport do relatorio 

@Author	Marcio Menon 
@since	18/08/2006
/*/
//-----------------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(1):Section(1)
Local cNomeArq		:=""
Local nDias			:= 0
Local dDtSeek		:= CTOD("//")
Local dDtDispo		:= CTOD("//")
Local nI			:= 0
Local nValorSe5		:= 0
Local nTValorE		:= 0
Local nValorTitulo	:= 0
Local nTotValB		:= 0
Local nTotValG		:= 0
Local lFirst  		:= .T.
Local nTotAbat		:= 0
Local nTotDescoA	:= 0
Local nTotAcresA	:= 0
Local nTotValorC	:= 0
Local nTotDescoB	:= 0
Local nTotAcresB	:= 0
Local nTotValorD	:= 0
Local nTotPgtdi_h	:= 0
Local nTotBaixa 	:= 0
Local nTotNoCred	:= 0
Local lAnterior 	:= .F.
Local nValAdto  	:= 0
Local nMoeda		:= mv_par06
Local nDecs			:= MsDecimais(mv_par06)
Local nMoedaBco		:= 1
Local aAreaSM0		:= {}
Local aTmpFil		:= {}
Local lGestao		:= (FWSizeFilial() > 2)
Local cCompFil      := FWModeAccess("SE2", 3)
Local lSE2Excl		:= Iif(lGestao, FWModeAccess("SE2",1) == "E", cCompFil == "E")
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
Local cTipodoc 		:= "VL|BA|V2|PA"
Local cMovBcoBx		:= Fr760Mot()
Local nLenSelFil	:= 0
Local cTmpFil		:= ""
Local lNewFil 		:= .T.
Local cLstTipos     := "NF |DP |CC"
Local lBlind	    := IsBlind()
Local aStruArq      := {}
Local nStruArq      := 0
Local cFilAtu       := cFilAnt
Local lAchou        := .T.
Local cFil          := ""

Private cTipos := ""

aAreaSM0 := SM0->(GetArea())
nRegSM0 := SM0->(Recno())

If (lSE2Excl .and. mv_par08 == 1)
	If FindFunction("FwSelectGC")
		aSelFil := FwSelectGC()
	Else
		aSelFil := AdmGetFil(.F.,.F.,"SE2")
	Endif
Endif

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

nLenSelFil := Len(aSelFil)
If nLenSelFil > 1
	SM0->(DbGoTo(nRegSM0))
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0040 +  ")")	//"Filiais selecionadas para o relatorio"
	nTamTit := Len(oReport:Title())
	oSecFil:Init()
	oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
	oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
	oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
	oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})
	For nX := 1 To nLenSelFil
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

	aSort(aSelFil)
	cFilAnt := aSelFil[nC]
	cUN		:= FWUnitBusiness()
	cEmp	:= FWCodEmp()
	cUNold	:= cUN
	cEmpOld	:= cEmp
EndIf

//-------------------------------------------------------------------------
// Verifica se seleciona tipos para total faturamento
//-------------------------------------------------------------------------
If mv_par05 == 1
	If lBlind
		cTipos := GetParAuto("FINR760TestCase")
	Else
		finaTipos()
	EndIf
	
	If !Empty(cTipos)
		cTipos := StrTran(cTipos, "/", "|") 
	EndIf
	
	cLstTipos := cTipos
Endif

//Cria TRB para impressao do relatório
Fr760Trab()

//-------------------------------------------------------------------------
// Cria IndRegua com filtragem do SE2 
//-------------------------------------------------------------------------
dbSelectArea("SE2")
cAliasQry := CriaTrab(nil,.f.)

cCampos := "E2_FILIAL,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_NATUREZ,E2_FORNECE,E2_LOJA,E2_VENCREA,E2_EMISSAO,E2_VALOR,E2_MOEDA,E2_TXMOEDA,E2_FILORIG, SE2.R_E_C_N_O_ RECSE2, "
cCampos += "FK2_FILIAL,FK2_IDFK2,FK2_DATA,FK2_VALOR,FK2_MOEDA,FK2_VENCTO,FK2_RECPAG,FK2_TPDOC,FK2_VLMOE2,FK2_MOTBX,FK2_FILORI,FK2_SEQ,FK2_IDDOC,FK2_DOC,FK2_TXMOED, "
cCampos += "FKA_IDPROC "

aStruArq := Fr760Stru(cCampos)

//Filtra TITULOS A PAGAR 
cQuery := "SELECT  "
cQuery += cCampos
cQuery += "FROM " + RetSqlName("SE2") + " SE2 "

cQuery += "LEFT JOIN " + RetSqlName("FK7") + " FK7 ON ( SE2.E2_FILIAL = FK7_FILIAL "
cQuery += "AND FK7.FK7_ALIAS = 'SE2' "
cQuery += "AND FK7.FK7_CHAVE = SE2.E2_FILIAL || '|' || SE2.E2_PREFIXO || '|' || SE2.E2_NUM || '|' || SE2.E2_PARCELA || '|' ||  SE2.E2_TIPO || '|' ||  SE2.E2_FORNECE || '|' ||  SE2.E2_LOJA ) AND FK7.D_E_L_E_T_ = ' ' "

//Filtra BAIXAS DE TITULOS A PAGAR
cQuery += "LEFT JOIN " + RetSqlName("FK2") + " FK2 ON ( FK2.FK2_IDDOC = FK7.FK7_IDDOC) "
If nLenSelFil > 0
	cQuery += " AND FK2_FILIAL " + GetRngFil( aSelFil, "FK2", .T., @cTmpFil)
	Aadd(aTmpFil,cTmpFil)
Else
	cQuery += " AND FK2_FILIAL = '" + xFilial("FK2") + "'"
Endif
cQuery += " AND FK2.FK2_NATURE between '" + mv_par03 + "' AND '" + mv_par04 + "'"
cQuery += " AND FK2.FK2_DATA >= '"   + DTOS(dDataBase-33)  + "'"
cQuery += " AND FK2.FK2_TPDOC IN "		  + Formatin(cTipodoc,"|") 
cQuery += " AND FK2.FK2_TPDOC <> 'ES'  "   			// apenas Baixas realizadas e não registros estornados
cQuery += " AND FK2.D_E_L_E_T_ = ' ' "
cQuery += " AND FK7.D_E_L_E_T_ = ' ' "
cQuery += " AND NOT EXISTS ("
cQuery += "SELECT A.FK2_IDDOC "
cQuery += "FROM "+ RetSqlName("FK2")+" A "
cQuery += "WHERE "
cQuery += "A.FK2_FILIAL = FK2.FK2_FILIAL AND "
cQuery += "A.FK2_IDDOC = FK2.FK2_IDDOC AND "
cQuery += "A.FK2_SEQ = FK2.FK2_SEQ AND "
cQuery += "A.FK2_TPDOC = 'ES' AND "
cQuery += "A.FK2_RECPAG = 'R' AND "
cQuery += "A.D_E_L_E_T_ = ' ') "

cQuery += "LEFT JOIN  " + RetSqlName("FKA") + " FKA ON (FKA_IDORIG = FK2_IDFK2) "

If nLenSelFil > 0
	cQuery += " WHERE E2_FILIAL " + GetRngFil( aSelFil, "SE2", .T., @cTmpFil)
	Aadd(aTmpFil,cTmpFil)
Else
	cQuery += " WHERE E2_FILIAL = '" + xFilial("SE2") + "'"
Endif
cQuery += " AND SE2.E2_PREFIXO between '" + mv_par01 + "' AND '" + mv_par02 + "'"
cQuery += " AND SE2.E2_NATUREZ between '" + mv_par03 + "' AND '" + mv_par04 + "'"
cQuery += " AND SE2.E2_TIPO IN "		  + FormatIn(cLstTipos,"|")
cQuery += " AND SE2.E2_EMISSAO <= '"	  + DTOS(dDataBase) + "'"
cQuery += " AND SE2.E2_VENCREA <= '"	  + DTOS(dDatabase) + "'"
cQuery += " AND SE2.E2_STATUS <> 'D'"

If mv_par07 == 2
	cQuery += " AND SE2.E2_MOEDA = " + Alltrim(Str(nMoeda))
EndIf

cQuery += " AND SE2.D_E_L_E_T_ = ' '"

cQuery += "ORDER BY " + SQLOrder("E2_FILIAL+DTOS(E2_VENCREA)+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA")
cQuery := ChangeQuery(cQuery)

MPSysOpenQuery(cQuery, cAliasQry)
(cAliasQry)->(DbGoTop())

If (cAliasQry)->(!Eof()) .And. (cAliasQry)->(!Bof())
	lNewFil   := .T.	
	nStruArq  := Len(aStruArq)
	cDataBase := DTOS(dDataBase)
	SA6->(DbSetOrder(1))
	FK6->(DbSetOrder(2))
	
	For nI := 1 to nStruArq 
		If aStruArq[nI,2] != 'C'
			TCSetField(cAliasQry, aStruArq[nI,1], aStruArq[nI,2], aStruArq[nI,3], aStruArq[nI,4])
		Endif
	Next
	
	oReport:SetMeter((cAliasQry)->(RecCount()) + SE5->(RecCount()))
	oSection2:SetHeaderPage(.T.) //Define o cabecalho da secao como padrao	
	FwFreeArray(aStruArq)	
	
	While (cAliasQry)->(!Eof())
		If oReport:Cancel()
			Exit
		EndIf		
		
		SE2->(dbGoTo((cAliasQry)->RECSE2))		
		oReport:IncMeter()
		
		If lNewFil
			If Empty(SE2->E2_FILORIG)
				If cCompFil == "E"
					cFilAnt := SE2->E2_FILIAL
				Else
					If SM0->(DbSeek(cEmpAnt+AllTrim(SE2->E2_FILIAL),.F.))
						cFilAnt	:= SM0->M0_CODFIL
					EndIf
					SM0->(DbGoTo(nRegSM0))
				EndIf
			Else
				cFilAnt := SE2->E2_FILORIG
			EndIf
			
			cUN			:= FWUnitBusiness()
			cEmp		:= FWCodEmp()
			cUNold		:= cUN
			cEmpOld		:= cEmp
			lPrtFil		:= .T.
			nDias		:= 0
			dDtSeek		:= ""
			dDtDispo	:= ""
			nValorSe5	:= 0
			nTValorE	:= 0
			nValorTitulo:= 0
			nTotValB	:= 0
			nTotValG	:= 0
			lFirst		:= .T.
			nTotAbat 	:= 0
			nTotDescoA	:= 0
			nTotAcresA	:= 0
			nTotValorC	:= 0
			nTotDescoB	:= 0
			nTotAcresB	:= 0
			nTotValorD	:= 0
			nTotPgtdi_h	:= 0
			nTotBaixa 	:= 0
			nTotNoCred	:= 0
			lAnterior 	:= .F.
			nValAdto  	:= 0
			lNewFil		:= .F.
		Endif
		
		cFil      := xFilial("FK2")
		nSaldoTit := Round(SaldoTit(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_NATUREZ,"P",SE2->E2_FORNECE,1,dDataBase,dDataBase,SE2->E2_LOJA,,If(cPaisLoc=="BRA",SE2->E2_TXMOEDA,0)), 2)
		nTotAbat  := SomaAbat(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,"P",1)
		nSaldoTit -= nTotAbat
		nValorSe5 := 0
		
		//Verifica se o atraso e' maior que 30 dias
		dbSelectArea("cNomeArq")
		
		If (dDataBase - SE2->E2_VENCREA) > 30    //Atrasados anterior
			nDias := 31			
		Else
			nDias := dDataBase - SE2->E2_VENCREA //Titulos do periodo
		EndIf
		
		lAchou := !cNomeArq->(DbSeek(SE2->E2_FILIAL + DTOS(dDataBase-nDias)))
		
		Reclock("cNomeArq", lAchou)
		cNomeArq->FILIALX := cFil
		cNomeArq->FILORIG := cFilAnt
		cNomeArq->DATAX   := (dDataBase - nDias)
		cNomeArq->VALOR_G += nSaldoTit
		
		If nDias < 31
			If cPaisLoc == "BRA"
				nValorTitulo := xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,1,,,SE2->E2_TXMOEDA)-nTotAbat
			Else
				nValorTitulo := xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,nMoeda,SE2->E2_EMISSAO,nDecs+1)-nTotAbat
			EndIf				
			
			cNomeArq->VALOR_B += nValorTitulo //Grava valor original
		EndIf		
		cNomeArq->(MsUnlock())
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf

		// Verifica se foi pago com atraso
		If !Empty((cAliasQry)->FK2_IDFK2)
			If (lMovBcoBx := (cAliasQry)->FK2_MOTBX $ cMovBcoBx)
				nValorSe5 := xMoeda((cAliasQry)->FK2_VALOR,nMoedaBco,nMoeda,(cAliasQry)->FK2_DATA,nDecs+1,,If(cPaisLoc=="BRA",(cAliasQry)->FK2_TXMOED,0))
			Endif			
			
			dDtSeek   := Iif((cAliasQry)->E2_VENCREA < dDatabase-30, dDatabase-31, (cAliasQry)->E2_VENCREA)
			lAnterior := .F.					
			dDtDispo  := Fr760Disp() //Acho a data de disponibilidade
			
			//Pagamentos ref a vencimentos anteriores a data inicial do periodo
			If dDtDispo > (dDataBase-31) .and. (cAliasQry)->FK2_DATA <= dDataBase .and. (cAliasQry)->E2_VENCREA <= (dDataBase-31)
				lAnterior := .T.
				lAchou := !cNomeArq->(MsSeek((cAliasQry)->FK2_FILIAL + DtoS(dDtSeek)))
				
				Reclock("cNomeArq", lAchou)
				cNomeArq->FILIALX := cFil
				cNomeArq->FILORIG := cFilAnt
				cNomeArq->DATAX	  := dDtSeek
				cNomeArq->VALOR_D += nValorSe5 //Valor pago com atraso
				cNomeArq->(MsUnlock())
			EndIf
			
			//Vencimentos anteriores a database
			If (cAliasQry)->E2_VENCREA <= dDataBase
				lAchou := !cNomeArq->(MsSeek((cAliasQry)->FK2_FILIAL + DtoS(dDtSeek)))
				
				Reclock("cNomeArq", lAchou)				
				cNomeArq->FILIALX := cFil
				cNomeArq->FILORIG := cFilAnt
				cNomeArq->DATAX	  := dDtSeek				
				
				If (cAliasQry)->E2_VENCREA >= dDtDispo				     	//Pagamentos SEM atraso
					cNomeArq->VALOR_C += nValorSe5
				ElseIf !lAnterior											//Pagamentos COM atraso
					cNomeArq->VALOR_D += nValorSe5
				EndIf
				cNomeArq->(MsUnlock())
			EndIf
			
			If FK6->(MsSeek(xFilial("FK6") + (cAliasQry)->FK2_IDFK2 )) ////Valores acessórios
				While FK6->(!EOF()) .and. FK6->(FK6_FILIAL+FK6_IDORIG) == xFilial("FK6") + (cAliasQry)->FK2_IDFK2 
					If FK6->FK6_TPDOC $ "DC!D2"				//DESCONTOS
						If (cAliasQry)->E2_VENCREA >= dDtDispo
							cNomeArq->DESCO_A += FK6->FK6_VALMOV
						Else
							cNomeArq->DESCO_B += FK6->FK6_VALMOV
						Endif
					Elseif FK6->FK6_TPDOC $ "JR|J2|MT|M2"	//JUROS E MULTA
						If (cAliasQry)->E2_VENCREA >= dDtDispo
							cNomeArq->ACRES_A += FK6->FK6_VALMOV
						Else
							cNomeArq->ACRES_B += FK6->FK6_VALMOV
						Endif
					ElseIf FK6->FK6_TPDOC $ "VA"		//VALORES ACESSÓRIOS
						If (cAliasQry)->E2_VENCREA >= dDtDispo
							If FK6->FK6_VALMOV < 0
								cNomeArq->DESCO_A += FK6->FK6_VALMOV
							Else	
								cNomeArq->ACRES_A += FK6->FK6_VALMOV
							Endif
						Else	
							If FK6->FK6_VALMOV < 0
								cNomeArq->DESCO_B += FK6->FK6_VALMOV
							Else	
								cNomeArq->ACRES_B += FK6->FK6_VALMOV
							Endif
						EndIf
					Endif
					FK6->(dbSkip())
				EndDo
			Endif
			
			//BAIXAS
			If dDtDispo > (dDatabase-31) //Receitas do dia)
				lAchou := !cNomeArq->(MsSeek((cAliasQry)->FK2_FILIAL + DtoS(dDtDispo)))
				
				Reclock("cNomeArq", lAchou)
				cNomeArq->FILIALX := cFil
				cNomeArq->FILORIG := cFilAnt
				cNomeArq->DATAX	  := dDtDispo
				
				If (cAliasQry)->E2_VENCREA > dDtDispo .AND. (cAliasQry)->E2_VENCREA > dDataBase
					cNomeArq->VALADTO += xMoeda((cAliasQry)->FK2_VALOR,nMoedaBco,nMoeda,(cAliasQry)->FK2_DATA,nDecs+1,,If(cPaisLoc=="BRA",(cAliasQry)->FK2_TXMOED,0))
				EndIf
				
				If lMovBcoBx
					cNomeArq->PGTDI_H  += xMoeda((cAliasQry)->FK2_VALOR,nMoedaBco,nMoeda,(cAliasQry)->FK2_DATA,nDecs+1,,If(cPaisLoc=="BRA",(cAliasQry)->FK2_TXMOED,0))
					cNomeArq->BAIXADIA += xMoeda((cAliasQry)->FK2_VALOR,nMoedaBco,nMoeda,(cAliasQry)->FK2_DATA,nDecs+1,,If(cPaisLoc=="BRA",(cAliasQry)->FK2_TXMOED,0))
				Else
					cNomeArq->NOCREDIT += xMoeda((cAliasQry)->FK2_VALOR,nMoedaBco,nMoeda,(cAliasQry)->FK2_DATA,nDecs+1,,If(cPaisLoc=="BRA",(cAliasQry)->FK2_TXMOED,0))
				Endif
				cNomeArq->(MsUnlock())
			EndIf			
		Endif
		
		(cAliasQry)->(dbSkip())
		
		//Grava Movimentação zerada se data nao houver registro
		If ((cAliasQry)->(Eof()) .Or. cFilAtu != cFilAnt)
			For nI := 0 TO 30
				If cNomeArq->(DbSeek(cFil+DtoS(dDataBase-nI)))
					Loop
				EndIf
				
				Reclock("cNomeArq", .T. )
				cNomeArq->FILIALX := cFil
				cNomeArq->FILORIG := cFilAnt
				cNomeArq->DATAX   := dDataBase - nI
				cNomeArq->(MsUnlock())
			Next nI
			
			cFilAtu := cFilAnt
			lNewFil	:= .T.
		Endif
	EndDo
	
	//Inicio da impressão dos dados
	cNomeArq->(dbGoTop())
	cFilAtu := 	cNomeArq->FILIALX
	
	//Executa a impressao do relatorio
	While cNomeArq->(!Eof())
		If lNewFil
			oSection2:Cell("DATAX"):Show()

			oSection2:Cell("VALOR_B"):SetTitle(STR0028+CRLF+STR0029)	//"VALOR DOS"###"TITULOS"
			oSection2:Cell("VALOR_B"):SetPicture(Tm(0,14))
			oSection2:Cell("VALOR_B"):SetSize(14)
			oSection2:Cell("VALOR_B"):SetBlock( { || cNomeArq->VALOR_B })

			oSection2:Cell("DESCO_A"):SetTitle(STR0013+CRLF+STR0014+CRLF+STR0015) //"VLS. PAGOS"###"S/ATRASO"###"DESCONTO"
			oSection2:Cell("DESCO_A"):SetPicture(Tm(0,14))
			oSection2:Cell("DESCO_A"):SetSize(14)
			oSection2:Cell("DESCO_A"):SetBlock( { || cNomeArq->DESCO_A })

			oSection2:Cell("ACRES_A"):SetTitle(STR0013+CRLF+STR0014+CRLF+STR0017)	//"ACRESCIMO"
			oSection2:Cell("ACRES_A"):SetPicture(Tm(0,14))
			oSection2:Cell("ACRES_A"):SetSize(14)
			oSection2:Cell("ACRES_A"):SetBlock( { || cNomeArq->ACRES_A })

			oSection2:Cell("VALOR_C"):SetTitle(STR0013+CRLF+STR0014+CRLF+STR0018)	//"TOTAL PAGO"
			oSection2:Cell("VALOR_C"):SetPicture(Tm(0,14))
			oSection2:Cell("VALOR_C"):SetSize(14)
			oSection2:Cell("VALOR_C"):SetBlock( { || cNomeArq->VALOR_C })

			oSection2:Cell("DESCO_B"):SetTitle(STR0013+CRLF+STR0016+CRLF+STR0015)		//"VLS. PAGOS"###"C/ATRASO"###"DESCONTO"
			oSection2:Cell("DESCO_B"):SetPicture(Tm(0,14))
			oSection2:Cell("DESCO_B"):SetSize(14)
			oSection2:Cell("DESCO_B"):SetBlock( { || cNomeArq->DESCO_B })

			oSection2:Cell("ACRES_B"):SetTitle(STR0013+CRLF+STR0016+CRLF+STR0017)		//"VLS. PAGOS"###"C/ATRASO"###"ACRESCIMO"
			oSection2:Cell("ACRES_B"):SetPicture(Tm(0,14))
			oSection2:Cell("ACRES_B"):SetSize(14)
			oSection2:Cell("ACRES_B"):SetBlock( { || cNomeArq->ACRES_B })

			oSection2:Cell("VALOR_D"):SetTitle(STR0013+CRLF+STR0016+CRLF+STR0018)		//"VLS. PAGOS"###"C/ATRASO"###"TOTAL PAGO"
			oSection2:Cell("VALOR_D"):SetPicture(Tm(0,14))
			oSection2:Cell("VALOR_D"):SetSize(14)
			oSection2:Cell("VALOR_D"):SetBlock( { || cNomeArq->VALOR_D })

			oSection2:Cell("NVALORE"):SetTitle(STR0019+CRLF+STR0020+CRLF+STR0021)		//"VALOR NAO PAGO"###"NO DIA DO"###"VENCIMENTO"
			oSection2:Cell("NVALORE"):SetPicture(Tm(0,14))
			oSection2:Cell("NVALORE"):SetSize(14)
			oSection2:Cell("NVALORE"):SetBlock( { || nValorE })

			oSection2:Cell("EFICIEN"):SetTitle(STR0022+CRLF+STR0023)					//"EFICIEN"###"CIA (%)"
			oSection2:Cell("EFICIEN"):SetPicture(Tm(0,08))
			oSection2:Cell("EFICIEN"):SetSize(08)
			oSection2:Cell("EFICIEN"):SetBlock( { || (1-(nValorE/cNomeArq->VALOR_B))*100 } )

			oSection2:Cell("VALOR_G"):SetTitle(STR0024+CRLF+STR0025+DtoC(dDataBase))	//"SALDO PENDENTE" "EM "
			oSection2:Cell("VALOR_G"):SetPicture(Tm(0,16))
			oSection2:Cell("VALOR_G"):SetSize(16)
			oSection2:Cell("VALOR_G"):SetBlock( { || cNomeArq->VALOR_G })

			oSection2:Cell("ATUAL"):SetTitle(STR0030+CRLF+STR0031)						//"ATUAL" ###"%"
			oSection2:Cell("ATUAL"):SetPicture(Tm(0,08))
			oSection2:Cell("ATUAL"):SetSize(08)
			oSection2:Cell("ATUAL"):SetBlock( { || (1-(cNomeArq->VALOR_G/cNomeArq->VALOR_B))*100 } )

			oSection2:Cell("PGTDI_H"):SetTitle(STR0032+CRLF+STR0033+CRLF+STR0034)		//"ATUAL VLR."###"DEBITADO"###"NO DIA"
			oSection2:Cell("PGTDI_H"):SetPicture(Tm(0,14))
			oSection2:Cell("PGTDI_H"):SetSize(14)
			oSection2:Cell("PGTDI_H"):SetBlock( { || cNomeArq->PGTDI_H })

			oSection2:Cell("BAIXADIA"):SetTitle(STR0035+CRLF+STR0034)					//"VALOR BAIXADO"###"NO DIA"
			oSection2:Cell("BAIXADIA"):SetPicture(Tm(0,14))
			oSection2:Cell("BAIXADIA"):SetSize(14)
			oSection2:Cell("BAIXADIA"):SetBlock( { || cNomeArq->BAIXADIA })

			oSection2:Cell("NOCREDIT"):SetTitle(STR0035+CRLF+STR0036+CRLF+STR0037+DtoC(dDataBase))	//"VALOR BAIXADO" "SEM DEBITO" "APOS "
			oSection2:Cell("NOCREDIT"):SetPicture(Tm(0,14))
			oSection2:Cell("NOCREDIT"):SetSize(14)
			oSection2:Cell("NOCREDIT"):SetBlock( { || cNomeArq->NOCREDIT })

			oSection1:Cell("VALOR_G"):SetTitle(STR0024+CRLF+STR0025+DtoC(dDataBase))	//"SALDO PENDENTE" "EM "

			cFilAnt 	:= cNomeArq->FILORIG
			cUN			:= FWUnitBusiness()
			cEmp		:= FWCodEmp()
			cUNold		:= cUN
			cEmpOld		:= cEmp
			
			lPrtFil		:= .T.
			lFirst		:= .T.
			lNewFil		:= .F.
			nValorE		:= 0
			nTValorE	:= 0
			nTotValB	:= 0
			nTotValG	:= 0
			nTotDescoA	:= 0
			nTotAcresA	:= 0
			nTotValorC	:= 0
			nTotDescoB	:= 0
			nTotAcresB	:= 0
			nTotValorD	:= 0
			nTotPgtdi_h	:= 0
			nTotBaixa	:= 0
			nTotNoCred	:= 0
		Endif

		// Executa a impressao do relatorio
		While  cNomeArq->(!Eof()) .and. cFilAtu == cNomeArq->FILIALX .And. !oReport:Cancel()
			If lPrtFil
				If mv_par08 == 1
					oReport:SkipLine()
					oFilial:Init()
					oFilial:Cell("Filial"):SetBlock({|| STR0041 + cFilAtu}) //"Filial : "
					oFilial:PrintLine()
					oFilial:Finish()
				EndIf
				lPrtFil := .F.
				oSection1:Init()
			EndIf

			If oReport:Cancel()
				Exit
			EndIf

			If lFirst	//Imprime o Saldo Anterior
				oSection1:PrintLine()
				oSection1:Finish()
				If lNewFil
					oReport:SkipLine()
				Endif
				oSection2:Init()
				cNomeArq->(dbSkip())
				lFirst := .F.
				Loop
			EndIf
			
			nValorE		:= cNomeArq->VALOR_B - cNomeArq->(VALOR_C-ACRES_A+DESCO_A)
			nTValorE 	+= nValorE
			nTotValB	+= cNomeArq->VALOR_B
			nTotValG	+= cNomeArq->VALOR_G
			nTotDescoA	+= cNomeArq->DESCO_A
			nTotAcresA	+= cNomeArq->ACRES_A
			nTotValorC	+= cNomeArq->VALOR_C
			nTotDescoB	+= cNomeArq->DESCO_B
			nTotAcresB	+= cNomeArq->ACRES_B
			nTotValorD	+= cNomeArq->VALOR_D
			nTotPgtdi_h	+= cNomeArq->PGTDI_H
			nTotBaixa	+= cNomeArq->BAIXADIA
			nTotNoCred	+= cNomeArq->NOCREDIT

			oSection2:PrintLine()
			oReport:IncMeter()
			cNomeArq->(dbSkip())		
		EndDo

		//---------------------------------------------
		// Faz a impressao do Total Geral da filial
		//---------------------------------------------
		oReport:PrintText("")
		oSection2:Cell("DATAX"   ):Hide()
		oSection2:Cell("VALOR_B" ):SetBlock( { || nTotValB } )
		oSection2:Cell("DESCO_A" ):SetBlock( { || nTotDescoA } )
		oSection2:Cell("ACRES_A" ):SetBlock( { || nTotAcresA } )
		oSection2:Cell("ACRES_A" ):Picture( PesqPict("FK2","FK2_VALOR")) 
		oSection2:Cell("VALOR_C" ):SetBlock( { || nTotValorC } )
		oSection2:Cell("DESCO_B" ):SetBlock( { || nTotDescoB } )
		oSection2:Cell("DESCO_B" ):Picture( PesqPict("FK2","FK2_VALOR")) 
		oSection2:Cell("ACRES_B" ):SetBlock( { || nTotAcresB } )
		oSection2:Cell("ACRES_B" ):Picture( PesqPict("FK2","FK2_VALOR")) 
		oSection2:Cell("VALOR_D" ):SetBlock( { || nTotValorD } )
		oSection2:Cell("NVALORE" ):SetBlock( { || nTValorE } )
		oSection2:Cell("EFICIEN" ):SetBlock( { || (1-(nTValorE/nTotValB))*100 } )
		oSection2:Cell("VALOR_G" ):SetBlock( { || nTotValG } )
		oSection2:Cell("ATUAL"	 ):SetBlock( { || (1-(nTotValG/nTotValB))*100 } )
		oSection2:Cell("PGTDI_H" ):SetBlock( { || nTotPgtdi_h } )
		oSection2:Cell("BAIXADIA"):SetBlock( { || nTotBaixa } )
		oSection2:Cell("NOCREDIT"):SetBlock( { || nTotNoCred } )

		oSection2:PrintLine()
		oSection2:Finish()

		cFilAtu := 	cNomeArq->FILIALX
		lNewFil := .T.
		lPrtFil := .T.
		lFirst  := .T.
	EndDo

Endif

If _oFr760TRB <> Nil
	_oFr760TRB:Delete()
	_oFr760TRB := Nil
Endif

cFilAnt := cFilialAnt

Return


//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Fr760Trab

Montagem da tabela temporária do relatório

@Author	Mauricio Pequim Jr
@since	30/05/2018
/*/
//-----------------------------------------------------------------------------------------------------
Static Function Fr760Trab()

//-------------------------------------------------------------------------
// Cria arquivo de trabalho
//-------------------------------------------------------------------------
Local aCampos:={{"FILIALX" ,"C",FwSizeFilial(),0},;
				{"FILORIG" ,"C",FwSizeFilial(),0},;
				{"DATAX"   ,"D",10,0},;
				{"VALOR_B" ,"N",16,2},;
				{"VALOR_C" ,"N",16,2},;
				{"VALOR_D" ,"N",16,2},;
				{"VALOR_E" ,"N",16,2},;
				{"VALOR_F" ,"N",16,2},;
				{"VALOR_G" ,"N",16,2},;
				{"DESCO_A" ,"N",16,2},;
				{"ACRES_A" ,"N",16,2},;
				{"DESCO_B" ,"N",16,2},;
				{"PGTDI_H" ,"N",16,2},;
				{"ACRES_B" ,"N",16,2},;
				{"BAIXADIA","N",16,2},;
				{"NOCREDIT","N",16,2} }

If _oFr760TRB <> Nil
	_oFr760TRB:Delete()
	_oFr760TRB := Nil
Endif

// Criação da Tabela Temporaria
_oFr760TRB := FWTemporaryTable():New( "cNomeArq" )
_oFr760TRB:SetFields(aCampos)
_oFr760TRB:AddIndex("1", {"FILIALX","DATAX"})

_oFr760TRB:Create()

Return 


//-------------------------------------------------------------------
/*/{Protheus.doc} FinTipoIN
Monta a expressão do NOT IN da query

@author Mauricio Pequim Jr
@since  06/01/2016
@version 12.1.7
/*/
//-------------------------------------------------------------------
User Function FinTipoIN(cTipos As Character)

	Default cTipos := MVPROVIS+"/"+MVRECANT+"/"+MV_CPNEG+"/"+MVABATIM

	cTipos	:=	StrTran(cTipos,',','/')
	cTipos	:=	StrTran(cTipos,';','/')
	cTipos	:=	StrTran(cTipos,'|','/')
	cTipos	:=	StrTran(cTipos,'\','/')

	cTipos := Formatin(cTipos,"/")

Return cTipos


//-------------------------------------------------------------------
/*/{Protheus.doc} Fr760Mot
Monta a expressão do IN da query para os motivos de baixa que 
movimentem banco

@author Mauricio Pequim Jr
@since  07/06/2018
@version 12.1.17
/*/
//-------------------------------------------------------------------
Static Function Fr760Mot()

Local aMotBx:= ReadMotBx()
Local nX := 0
Local cMotBx := ""

For nX := 1 to Len(aMotBx)
	If Substr(aMotBx[nX],19,1) == "S"
		cMotBx += "|" + Substr(aMotBx[nX],1,3)
	Endif
Next

cMotBx := Substr(cMotBx,2,Len(cMotBx))

Return cMotBx


//-------------------------------------------------------------------
/*/{Protheus.doc} Fr760Stru
Monta a estrutura dos campos da query que para uso do TcSetField

@author Mauricio Pequim Jr
@since  07/06/2018
@version 12.1.17
/*/
//-------------------------------------------------------------------
Static Function Fr760Stru(cCampos) 

Local aCampos := Strtokarr2( cCampos, ",", .F.)
Local aStru	:= {}
Local nY := 0 

SX3->(dbSetOrder(2))

For nY := 1 to Len(aCampos)
	If SX3->(MsSeek(aCampos[nY])) .and. SX3->X3_TIPO != 'C'
		AADD(aStru, {SX3->X3_CAMPO, SX3->X3_TIPO, SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	Endif
Next

SX3->(dbSetOrder(1))

Return aStru


//-------------------------------------------------------------------
/*/{Protheus.doc} Fr760Disp
Obtém a data de disponibilidade do movimento bancário

@author Mauricio Pequim Jr
@since  22/06/2018
@version 12.1.17
/*/
//-------------------------------------------------------------------
Static Function Fr760Disp()

Local dDtDispo := (cAliasQry)->FK2_DATA

If !Empty((cAliasQry)->FKA_IDPROC)
	
	If oPrepared == NIL
		
		cQuery 	:= "SELECT FKA_IDORIG IDORIG FROM "+ RetSqlName("FKA") 
		cQuery 	+= " WHERE FKA_FILIAL = ? " 
		cQuery 	+= " AND FKA_IDPROC = ? "
		cQuery 	+= " AND FKA_TABORI = 'FK5' "
		cQuery 	+= " AND D_E_L_E_T_ = ' ' "
		
		cQuery 	:= ChangeQuery(cQuery)
		oPrepared := FWPreparedStatement():New(cQuery)
	Endif
	
	oPrepared:SetString( 1, (cAliasQry)->FK2_FILIAL	)
	oPrepared:SetString( 2, (cAliasQry)->FKA_IDPROC	)
	
	cQuery:=oPrepared:GetFixQuery()
	
	cIdOrig := (MpSysExecScalar(cQuery,"IDORIG"))

	If !Empty(cIdOrig)
		FK5->(dbSetOrder(1))		//FK5_FILIAL+FK5_IDMOV
		If FK5->(MsSeek(xFilial("FK5", (cAliasQry)->FK2_FILORI) + cIdOrig))
			dDtDispo := FK5->FK5_DTDISP
		EndIf
	Endif
EndIf

Return dDtDispo