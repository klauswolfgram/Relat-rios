/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR120.CH"
#include "Protheus.ch"      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR120  ³ Autor ³ Wagner Xavier         ³ Data ³ 03.08.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relacao dos Bens Baixados                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR120                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
Last change:  CIA   5 Jan 96    9:16 am
*/
User Function ATFR120()
Local oReport
/* GESTAO - inicio */
Private _aSelFil	:= {}
/* GESTAO - fim */
oReport:=ReportDef()
oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³28/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport,oSection1
Local cReport := "ATFR120"
Local cAlias1 := "SN3"
Local cAlias2 := "SN1"
Local cAlias3 := "SN4"
Local cAlias4 := "SA2"
Local cTitulo := STR0004 // "RELACAO DOS BENS BAIXADOS"
Local cDescri := STR0001 + " " + STR0002 + " " + STR0003 // "Este relatorio ira' imprimir a rela‡„o bens baixados entre um determinado periodo. Podera' ser impresso por Conta ou Centro de Custo."
Local bReport := { |oReport|	cMoeda := Str(mv_par07,1),;
										oReport:SetTitle( oReport:Title() + OemToAnsi(STR0009)+; // " por " 
																aOrd[oSection1:GetOrder()] + OemToAnsi(STR0010)+; // " em " 
																Getmv("MV_MOEDA"+cMoeda)+;
																OemToAnsi(STR0011)+; // " entre "
																DTOC(mv_par05) + OemToAnsi(STR0012) + DTOC(mv_par06)),; // " a "
									 	ReportPrint( oReport ) }
Local aOrd := {}
Local cMoeda 

cAlias1 := cAlias2 := cAlias3 := cAlias4 := "TRB"

aOrd  := {	OemToAnsi(STR0005),; // "Conta"
				OemToAnsi(STR0006)} // "C Custo"

Pergunte( "AFR120" , .F. )
cMoeda := Str(mv_par07,1)
                  
oReport  := TReport():New( cReport, cTitulo, "AFR120" , bReport, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0020, {"SN1","SN3","SN4"}, aOrd ) // "Dados do Bem"

TRCell():New( oSection1, "N3_FILIAL"		, cAlias1	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCONTAB"		, cAlias1	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCUSTO" 		, cAlias1	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CBASE"  		, cAlias1	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_ITEM"   		, cAlias1	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_TIPO"   		, cAlias1	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_DESCRIC"		, cAlias2	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_AQUISIC"		, cAlias2	,/*X3Titulo*/    	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection1, "N4_DATA"			, cAlias3	,STR0021     		,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// "Data da Baixa"
TRCell():New( oSection1, "N4_NOTA"			, cAlias3	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection1, "N4_SERIE"			, cAlias3	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection1, "N4_MOTIVO"		, cAlias3	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_FORNEC" 		, cAlias2	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_LOJA"   		, cAlias2	,/*X3Titulo*/       ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A2_NREDUZ" 		, cAlias4	,/*X3Titulo*/       ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N4_QUANTD" 		, cAlias3	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "VALOR ATUAL"		, cAlias3	,STR0022			,PesqPict("SN3","N3_VRDMES"+cMoeda, 17,mv_par07),17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Valor Atual"
TRCell():New( oSection1, "N3_VRDACM"		, cAlias1	,STR0030		    ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection1, "N3_VRCDA1"		, cAlias1	,/*X3Titulo*/     	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "VALOR RESIDUAL"	, cAlias3	,STR0023			,PesqPict("SN3","N3_VRDACM"+cMoeda, 17,mv_par07),17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Valor Residual"
TRCell():New( oSection1, "N4_VLROC"			, cAlias3	,STR0031        	,PesqPict("SN4","N4_VLROC" +cMoeda, 17,mv_par07),17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "LUCRO/PREJUIZO"	, cAlias3	,STR0024      		,PesqPict("SN4","N4_VLROC" +cMoeda, 17,mv_par07),17 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Lucro/Prejuizo"
TRCell():New( oSection1, "N3_AMPLIA"		, cAlias1	,STR0032    		,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection1:SetLineBreak()
oSection1:SetTotalInLine(.T.)
oSection1:SetHeaderPage(.T.)
oReport:SetLandscape()
/*
GESTAO - inicio */
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Claudio D. de Souza º Data ³  23/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )

Local oSection1		:= oReport:Section(1)
Local cChave
Local cSQLChave
Local cQuery		:= ""
Local cAliasSn4		:= "SN4"
Local cAliasSn1		:= "SN1"
Local nOrder		:= oSection1:GetOrder()
Local cMoeda		:= Str(mv_par07,1)
Local cWhere		:= ""
Local oBreak1
Local oBreak2
Local oTotConta
Local oTotFil
Local bValorAtual
Local bResidual
Local bLucroPreju
Local cCampos
Local aMotBaixa		:= {}
Local nMaxLen		:= 2
Local cN1TipoNeg	:= Alltrim(SuperGetMv("MV_N1TPNEG",.F.,"")) // Tipos de N1_PATRIM que aceitam Valor originais negativos
Local cN3TipoNeg	:= Alltrim(SuperGetMv("MV_N3TPNEG",.F.,"")) // Tipos de N3_TIPO que aceitam Valor originais negativos
Local cFilDe  		:= "  "
Local cFilAte 		:= "  "
Local cFilPos		:= "  "
Local cQuebra		:= ""
Local aCont			:= {}
Local nCont			:= 0
Local aClassif		:= {}
Local cClassif		:= ""
Local cFilterUser	:= ""
Local lAtfCusPrv := AFXAtCsPrv()
Local aCampos := {}
Local cUserFlds := ''
Local _lUserFlt	:= .T.
/*
GESTAO - inicio */
Local oBrkEmp		:= Nil
Local nTamEmp		:= 0
Local nLenSelFil	:= 0
Local nX			:= 0
Local cNomEmp		:= ""
Local cTmpFil		:= ""
Local lTotEmp		:= .F.
Local lTotFil		:= .F.
Local aTmpFil		:= {}
Local aSN3       := {}
Local aSN4       := {}
Local cChvSN4	 := ""
Local nI         := 0

If MV_PAR13 == 1
	If Empty(_aSelFil)
		If  FindFunction("AdmSelecFil")
			AdmSelecFil("AFR120",13,.F.,@_aSelFil,"SN3",.F.)
		Else
			_aSelFil := AdmGetFil(.F.,.F.,"SN3")
			If Empty(_aSelFil)
				Aadd(_aSelFil,cFilAnt)
			Endif
		Endif
	Endif
Else
	If MV_PAR08 == 1 
		If !Empty(mv_par09) .And. Upper(mv_par10) <> Replicate("Z",Len(cFilAnt))
			nTipo := 1 //caso seja colocado entre filiais Ex: D MG 01 / D  RJ 01
		else
			nTipo := 2 //caso de branco a zzzzzzz
		endif
		_aSelFil	:= fMontaFil(nTipo)
	Else
		Aadd(_aSelFil,cFilAnt)
	Endif

Endif
//Proteção para não gerar error log
iF Len( _aSelFil ) <=0
	Return
endIf
nLenSelFil := Len(_aSelFil)
cFilDe := _aSelFil[1]
cFilAte := _aSelFil[nLenSelFil]
nTamEmp := Len(FWSM0LayOut(,1))
lTotEmp := .F.
lTotFil := (nLenSelFil > 1)
If lTotFil
	nX := 1 
	While nX < nLenSelFil .And. !lTotEmp
		nX++
		lTotEmp := !(Substr(_aSelFil[nX-1],1,nTamEmp) == Substr(_aSelFil[nX],1,nTamEmp))
	Enddo
Endif
/* GESTAO - fim
*/ 
SN1->(DbSetOrder(1)) //indice utilizado no seek para filtro de usuario

// Cria array com os motivos de baixa (Tabela 16)
SX5->(DbSetOrder(1))
SX5->(MsSeek(xFilial("SX5")+"16"))
SX5->(DbEval(	{ ||	Aadd(aMotBaixa, SubStr(SX5->X5_CHAVE,1,2 ) + "-" + SubStr(Capital(X5Descri()),1,12 )),;
	nMaxLen := Max(nMaxLen,Len(aMotBaixa[Len(aMotBaixa)])) },,;
	{ || SX5->(X5_FILIAL+X5_TABELA) == xFilial("SX5")+"16" } ) )

If mv_par11 == 1
	aClassif := AdmGetClass()
	If Len( aClassif ) <= 0
		Return
	EndIf
EndIf

// Obter os campos do Usuario
	aCampos:= oReport:Section(1):aCell
	For nX := 1 to Len(aCampos)
		If aCampos[nX]:cFormula == "I" .And. aCampos[nX]:lUserField .And. aCampos[nX]:lUserEnabled
			aCampos[nX]:cFormula := Nil
			cUserFlds +=", "+aCampos[nX]:cName+" "
			aCampos[nX]:cAlias := "TRB"
		EndIf
	Next 

	If mv_par08 == 2
		cFilDe	:= cFilAnt
		cFilAte	:= cFilAnt
	ELSE
		cFilDe	:= mv_par09	// Todas as filiais
		cFilAte	:= Upper(mv_par10)
		If Empty(cFilDe) .AND. cFilAte == Replicate("Z",Len(cFilAnt)) .And. mv_par08 == 1
			nLenSelFil:= 0
		EndIf
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Localiza registro inicial                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF nOrder == 1
		cChave		:= "N3_FILIAL+N3_CCONTAB" //+N3_CBASE+N3_ITEM"
		SN3->(dbSetOrder(4))
		cWhere 		:= "SN3.N3_CCONTAB <> ' ' AND "
		cSQLChave 	:= "SN3.N3_FILIAL,SN3.N3_CCONTAB,SN3.N3_CBASE,SN3.N3_ITEM"

	ElseIF nOrder == 2
		cChave 		:= "N3_FILIAL+N3_CCUSTO" //+N3_CBASE+N3_ITEM"
		SN3->(dbSetOrder(5))
		cWhere 		:= "SN3.N3_CCUSTO <> ' ' AND "
		cSQLChave 	:= "SN3.N3_FILIAL,SN3.N3_CCUSTO,SN3.N3_CBASE,SN3.N3_ITEM"

	EndIf

	cQuery := "SELECT SN3.N3_FILIAL,SN3.N3_CBASE,SN3.N3_ITEM,SN3.N3_TIPO,"
	
	cQuery += " SN1.N1_DESCRIC, SN1.N1_FORNEC, SN1.N1_LOJA   , SN1.N1_AQUISIC, SN1.N1_PATRIM, "
	cQuery += " SN1.R_E_C_N_O_ RECSN1, "
	
	cQuery += " SN3.N3_BAIXA,SN3.N3_CCONTAB,SN3.N3_VRDMES1,"
	cQuery += " SN3.N3_CCUSTO,SN3.N3_TXDEPR1,SN3.N3_CDEPREC,SN3.N3_CDESP,SN3.N3_CCDEPR,"
	cQuery += " SN3.N3_VORIG1,SN3.N3_VRCACM1,SN3.N3_AMPLIA1,SN3.N3_VRDACM1,SN3.N3_VRCDA1,"
	cQuery += " SN3.N3_VORIG2,SN3.N3_AMPLIA2,SN3.N3_VRDACM2,"
	cQuery += " SN3.N3_VORIG3,SN3.N3_AMPLIA3,SN3.N3_VRDACM3,"
	cQuery += " SN3.N3_VORIG4,SN3.N3_AMPLIA4,SN3.N3_VRDACM4,"
	cQuery += " SN3.N3_VORIG5,SN3.N3_AMPLIA5,SN3.N3_VRDACM5,"
	cQuery += " SN3.R_E_C_N_O_ RECSN3, "
	
	cQuery += " SN4.N4_FILIAL,SN4.N4_CBASE,SN4.N4_ITEM,SN4.N4_TIPO,SN4.N4_DATA ,"
	cQuery += " SN4.N4_SEQ,SN4.N4_VENDA,SN4.N4_TXMEDIA,SN4.N4_NOTA,SN4.N4_SERIE,"
	cQuery += " SN4.N4_MOTIVO,N4_OCORR, SN4.N4_QUANTD,"
	cQuery += " SN4.N4_VLROC1,SN4.N4_VLROC2,SN4.N4_VLROC3,SN4.N4_VLROC4,SN4.N4_VLROC5"		
	
	cQuery +=  cUserFlds  // Adicionar campos incluidos pelo usuario
	
	cQuery += " FROM "+RetSQLNAme("SN1")+" SN1 INNER JOIN "+RetSQLName("SN3")+" SN3 ON"
	cQuery += " SN1.N1_FILIAL = SN3.N3_FILIAL AND"
	cQuery += " SN1.N1_CBASE = SN3.N3_CBASE AND"
	cQuery += " SN1.N1_ITEM = SN3.N3_ITEM AND"
	cQuery += " SN1.D_E_L_E_T_ = ' '"
	cQuery += " LEFT JOIN "+RetSQLName("SN4")+" SN4 ON"
	cQuery += " SN4.N4_FILIAL = SN3.N3_FILIAL AND"
	cQuery += " SN4.N4_CBASE = SN3.N3_CBASE AND"
	cQuery += " SN4.N4_ITEM = SN3.N3_ITEM AND"
	cQuery += " SN4.N4_TIPO = SN3.N3_TIPO AND"
	cQuery += " SN4.N4_DATA = SN3.N3_DTBAIXA AND"
	cQuery += " SN4.N4_SEQ = SN3.N3_SEQ AND"
	
	cQuery += "	SN4.N4_OCORR IN('01','15') AND"
	cQuery += "	SN4.N4_TIPOCNT = '1' AND"
	
	cQuery += " SN4.D_E_L_E_T_ = ' '"
	/* 		GESTAO - inicio */
	If nLenSelFil == 0
		If cFilAte == cFilDe
			cQuery += " WHERE SN3.N3_FILIAL = '"+ XFilial("SN3",cFilDe)	+"' AND"
		Else
			If Empty(cFilDe) .AND. cFilAte == Replicate("Z",Len(cFilAnt))
				cQuery += " WHERE "
			Else
				cQuery += " WHERE SN3.N3_FILIAL  BETWEEN '"+ XFilial("SN3",cFilDe) +"' AND '"+	XFilial("SN3",cFilAte)	+"' AND"
			EndIf
		EndIf
	Else
		cQuery += " WHERE SN3.N3_FILIAL " + GetRngFil( _aSelFil, "SN3", .T., @cTmpFil) + " AND"
		Aadd(aTmpFil,cTmpFil)
	Endif
	/* GESTAO - fim 		*/

	If !Empty(mv_par01) .AND. UPPER(mv_par02) != Replicate( "Z",Len(mv_par02) )
		If mv_par02 == mv_par01
			cQuery += " SN3.N3_CCONTAB = '"+ mv_par01+"' AND"
		Else
			cQuery += " SN3.N3_CCONTAB BETWEEN '"+ mv_par01		+"' AND '"+	mv_par02		+"' AND"
		EndIf
	EndIf
		
	If !Empty(mv_par03) .AND. UPPER(mv_par04) != Replicate( "Z",Len(mv_par04) )
		If mv_par04 == mv_par03
			cQuery += " SN3.N3_CCUSTO  = '"+ mv_par03 +"' AND"
		Else
			cQuery += " SN3.N3_CCUSTO  BETWEEN '"+ mv_par03 +"' AND '"+ mv_par04 +"' AND"
		EndIf
	EndIf
	
	If mv_par06 == mv_par05
		cQuery += " SN3.N3_DTBAIXA = '"+ DTOS(mv_par06) +"' AND"
	Else
		cQuery += " SN3.N3_DTBAIXA BETWEEN '"+ DTOS(mv_par05)	+"' AND '"+	DTOS(mv_par06) +"' AND"
	EndIf
	
	cQuery += " SN3.N3_BAIXA   <> '0' AND"
	cQuery += " " + cWhere
	cQuery += " SN3.D_E_L_E_T_ = ' '"
	 
	 //Filtra as classificações
	If Len(aClassif) > 0
		If FindFunction("FORMATCLAS")
			cQuery += " AND SN1.N1_PATRIM IN " + FORMATCLAS(aClassif,.T.)
		EndIf
	EndIf
	
	If lAtfCusPrv .And. MV_PAR12 == 2
		cQuery += " AND SN3.N3_ATFCPR <> '1'  "
	EndIf
	
	cQuery += " ORDER BY "+cSQLChave

	cQuery := ChangeQuery(cQuery)
	
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),"TRB", .F., .T.)

	TCSetField("TRB","N4_DATA"   , "D",8,0)
	TCSetField("TRB","N1_AQUISIC", "D",8,0)

	IF nOrder == 1
		oBreak1:= TRBreak():New(oSection1, {|| TRB->N3_FILIAL + TRB->N3_CCONTAB}, {|| STR0027 } )		/* GESTAO */
	Else
		oBreak1:= TRBreak():New(oSection1, {|| TRB->N3_FILIAL + TRB->N3_CCUSTO}, {|| STR0028 } )		/* GESTAO */
	EndIf
	oBreak1:OnPrintTotal( { || oReport:SkipLine(2)} )		/* GESTAO */

	oBreak2:= TRBreak():New(oSection1, {|| cFilPos}, {|| STR0026 } )		/* GESTAO */
	oBreak2:OnPrintTotal( { || oReport:SkipLine(2)} )

	bValorAtual := { || TRB->&("N3_VORIG"+cMoeda) + TRB->&("N3_AMPLIA"+cMoeda) /*+ If(mv_par07 == 1, TRB->N3_VRCACM1, 0)*/ }
	
	bResidual	:= { ||	If( cMoeda == "1", If( (TRB->N3_TIPO = "05" .Or.;
		TRB->N1_PATRIM $ cN1TipoNeg .Or.;
		TRB->N3_TIPO $ cN3TipoNeg) .and. (TRB->(N3_VORIG1+N3_VRCACM1+N3_AMPLIA1)) < 0.0,	(TRB->(N3_VORIG1+N3_VRCACM1+N3_AMPLIA1))+Abs((TRB->(N3_VRDACM1+N3_VRCDA1))),;
		(TRB->(N3_VORIG1+N3_VRCACM1+N3_AMPLIA1))-(TRB->(N3_VRDACM1+N3_VRCDA1))),;
		If( (TRB->N3_TIPO = "05" .Or.;
		TRB->N1_PATRIM $ cN1TipoNeg .Or.;
		TRB->N3_TIPO $ cN3TipoNeg) .and. (TRB->(N3_VORIG1+N3_VRCACM1+N3_AMPLIA1)) < 0.0,	 TRB->&("N3_VORIG"+cMoeda)+TRB->&("N3_AMPLIA"+cMoeda)+Abs(TRB->&("N3_VRDACM"+cMoeda)),;
		TRB->&("N3_VORIG"+cMoeda)+TRB->&("N3_AMPLIA"+cMoeda)-TRB->&("N3_VRDACM"+cMoeda) ) ) }
	
	bLucroPreju	:= { ||	If( cMoeda == "1", (TRB->N4_VENDA - Eval(bResidual)),;
		If( cMoeda == Getmv("MV_ATFMOED"), ((TRB->N4_VENDA / TRB->N4_TXMEDIA) - Eval(bResidual)),;
		If( SM2->(MsSeek(TRB->N4_DATA)), (TRB->N4_VENDA / SM2->&("M2_MOEDA"+cMoeda) - Eval(bResidual)), 0))) }
	
	/* 	GESTAO - inicio */
	oSection1:Cell("A2_NREDUZ"):SetBlock( { || SA2->A2_NREDUZ } )
	/*GESTAO - fim 	*/
	oSection1:Cell("LUCRO/PREJUIZO"):SetTitle(STR0029)
	oSection1:Cell("N3_VRDACM"):SetPicture(PesqPict("SN3","N3_VRDACM"+cMoeda, 17, mv_par07))
	oSection1:Cell("N3_VRDACM"):SetBlock( { || &("N3_VRDACM"+cMoeda) } )

	oSection1:Cell("N3_VRDACM"):SetTitle(STR0030)
	oSection1:Cell("N3_VRDACM"):SetPicture(PesqPict("SN3","N3_VRDACM"+cMoeda, 17, mv_par07))
	oSection1:Cell("N3_VRDACM"):SetBlock( { || &("N3_VRDACM"+cMoeda) } )
	
	oSection1:Cell("N4_VLROC"):SetTitle(STR0031)
	oSection1:Cell("N4_VLROC"):SetPicture(PesqPict("SN4","N4_VLROC" +cMoeda, 17, mv_par07))
	oSection1:Cell("N4_VLROC"):SetBlock( { || &("N4_VLROC"+cMoeda) } )
	
	oSection1:Cell("N3_AMPLIA"):SetTitle(STR0032)
	oSection1:Cell("N3_AMPLIA"):SetPicture(PesqPict("SN3","N3_AMPLIA" +cMoeda, 17, mv_par07))
	oSection1:Cell("N3_AMPLIA"):SetBlock( { || &("N3_AMPLIA"+cMoeda) } )

	oSection1:Cell("N4_MOTIVO"):SetSize(nMaxLen)
	oSection1:Cell("VALOR ATUAL"):SetBlock(bValorAtual)
	oSection1:Cell("VALOR RESIDUAL"):SetBlock(bResidual)
	oSection1:Cell("LUCRO/PREJUIZO"):SetBlock(bLucroPreju)
	oSection1:Cell("N4_MOTIVO"):SetBlock( { ||	AtfGetMtvo( aMotBaixa, TRB->N4_MOTIVO ) } )

	oTotConta:= TRFunction():New(oSection1:Cell("VALOR ATUAL"	)	,, "SUM",oBreak1 ,,, bValorAtual	,.F.,.F.,.F.,oSection1 )
	oTotConta:= TRFunction():New(oSection1:Cell("N3_VRDACM"		)	,, "SUM",oBreak1 ,,, 				,.F.,.F.,.F.,oSection1 )
	oTotConta:= TRFunction():New(oSection1:Cell("N3_VRCDA1"		)	,, "SUM",oBreak1 ,,, 				,.F.,.F.,.F.,oSection1 )
	oTotConta:= TRFunction():New(oSection1:Cell("VALOR RESIDUAL")	,, "SUM",oBreak1 ,,, bResidual		,.F.,.F.,.F.,oSection1 )
	oTotConta:= TRFunction():New(oSection1:Cell("N4_VLROC"		)	,, "SUM",oBreak1 ,,, 				,.F.,.F.,.F.,oSection1 )
	oTotConta:= TRFunction():New(oSection1:Cell("LUCRO/PREJUIZO")	,, "SUM",oBreak1 ,,, bLucroPreju	,.F.,.F.,.F.,oSection1 )
	oTotConta:= TRFunction():New(oSection1:Cell("N3_AMPLIA"		)	,, "SUM",oBreak1 ,,, 				,.F.,.F.,.F.,oSection1 )
         
	oTotFil:= TRFunction():New(oSection1:Cell("VALOR ATUAL"	    )	,, "SUM",oBreak2 ,,, bValorAtual	, .F. , lTotFil , .F.)
	oTotFil:= TRFunction():New(oSection1:Cell("N3_VRDACM"		)	,, "SUM",oBreak2 ,,, 		    	, .F. , lTotFil , .F.)
	oTotFil:= TRFunction():New(oSection1:Cell("N3_VRCDA1"		)	,, "SUM",oBreak2 ,,, 			    , .F. , lTotFil , .F.)
	oTotFil:= TRFunction():New(oSection1:Cell("VALOR RESIDUAL"  )	,, "SUM",oBreak2 ,,, bResidual		, .F. , lTotFil , .F.)
	oTotFil:= TRFunction():New(oSection1:Cell("N4_VLROC"		)	,, "SUM",oBreak2 ,,, 				, .F. , lTotFil , .F.)
	oTotFil:= TRFunction():New(oSection1:Cell("LUCRO/PREJUIZO"  )	,, "SUM",oBreak2 ,,, bLucroPreju	, .F. , lTotFil , .F.)
	oTotFil:= TRFunction():New(oSection1:Cell("N3_AMPLIA"		)	,, "SUM",oBreak2 ,,, 				, .F. , lTotFil , .F.)
	/* 	GESTAO - inicio */
	/* quebra por empresa */
	If lTotEmp
		oBrkEmp := TRBreak():New(oSection1,{|| Substr(TRB->N3_FILIAL,1,nTamEmp)},{|| STR0038 + " " + cNomEmp })		//"Total empresa"
		oBrkEmp:OnPrintTotal( { || oReport:SkipLine(2)} )
		TRFunction():New(oSection1:Cell("VALOR ATUAL"	),,"SUM",oBrkEmp,,,,.F.,.F.)
		TRFunction():New(oSection1:Cell("N3_VRDACM"		),,"SUM",oBrkEmp,,,,.F.,.F.)
		TRFunction():New(oSection1:Cell("N3_VRCDA1"		),,"SUM",oBrkEmp,,,,.F.,.F.)
		TRFunction():New(oSection1:Cell("VALOR RESIDUAL"),,"SUM",oBrkEmp,,,,.F.,.F.)
		TRFunction():New(oSection1:Cell("N4_VLROC"		),,"SUM",oBrkEmp,,,,.F.,.F.)
		TRFunction():New(oSection1:Cell("LUCRO/PREJUIZO"),,"SUM",oBrkEmp,,,,.F.,.F.)
		TRFunction():New(oSection1:Cell("N3_AMPLIA"		),,"SUM",oBrkEmp,,,,.F.,.F.)
	Endif
	/* GESTAO - fim 	*/
	       
	oReport:SetMeter(RecCount())

	oReport:SetTotalText(STR0037)		//"TOT.GERAL:"
	oReport:SetTotalInLine(.F.)
	
	aSN3 := SN3->(GetArea())
	SN3->(DbSetOrder(1))

	aSN4 := SN4->(GetArea())
	SN4->(DbSetOrder(1))
		
	While !TRB->(Eof())		

		If oReport:Cancel()
			Exit
		EndIf
	
		oSection1:Init()
		SN4->(DbClearFilter())

		cFilPos := TRB->N3_FILIAL
		While !TRB->(Eof()) .And. cFilPos == TRB->N3_FILIAL

			cQuebra := TRB->(&cChave)
			While !TRB->(Eof()) .AND. cQuebra == TRB->(&cChave)

				_lUserFlt := .T.
				cChvSN4 := TRB->N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO+Dtos(N4_DATA)+N4_OCORR+N4_SEQ
				// posiciona as areas para o filtro do usuario
				SN1->( DbGoto(TRB->RECSN1) )
				SN3->( DbGoto(TRB->RECSN3) )
				SN4->( MsSeek(cChvSN4))
				SA2->( MsSeek(xFilial("SA2",TRB->N3_FILIAL)+TRB->(N1_FORNEC+N1_LOJA)) )   // compartilhado SA2

				// para cada um dos alias da section (que permitem filtro)
				For nI := 1 To Len(oSection1:aTable)
					cFilterUser := oSection1:GetAdvplExp(oSection1:aTable[nI])
					
					// caso tenha algum filtro
					If !Empty( cFilterUser )
						// vai testar a expressao como !alias->(regra)
						// ex. ! SN3->(N3_TIPO == "01" .And. N3_BAIXA == 1)
						If &( "!"+oSection1:aTable[nI]+"->("+(cFilterUser)+")" )
							_lUserFlt := .F.
							Loop
						EndIf
					EndIf
				Next nI
				If _lUserFlt
					oSection1:PrintLine()
				EndIf

				TRB->(DbSkip())
			EndDo
		EndDo
		oReport:IncMeter()
	EndDo
	
	RestArea(aSN3)
	RestArea(aSN4)
	oSection1:Finish()

	DbSelectArea("TRB")
	DbCloseArea()

	/*
	GESTAO - inicio */
	If !Empty(aTmpFil)
		For nX := 1 To Len(aTmpFil)
			CtbTmpErase(aTmpFil[nX])
		Next
	Endif
	/* GESTAO - fim 	*/

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Af120PoSn4³ Autor ³ Claudio Donizete      ³ Data ³ 07.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Posiciona o SN4 para verificar o movimento da baixa        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ Af120PoSn4                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Af120PoSn4

SN4->(dbSetOrder(1))
SN4->(MsSeek(xFilial("SN4")+SN3->(N3_CBASE+N3_ITEM+N3_TIPO+Dtos(N3_DTBAIXA)+"01"+N3_SEQ)))
While	SN4->(!Eof()) .And.;
		SN4->N4_FILIAL	== xFilial("SN4") .And.;
		SN3->(N3_CBASE+N3_ITEM+N3_TIPO+Dtos(N3_DTBAIXA)+"01"+N3_SEQ)==;
		SN4->(N4_CBASE+N4_ITEM+N4_TIPO+Dtos(N4_DATA)+N4_OCORR+N4_SEQ) 
		If SN4->N4_TIPOCNT = "1"
			Exit
		Endif
		SN4->(dbSkip())
EndDo

Return Nil 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³AtfGetMtvo³ Autor ³ Totvs                 ³ Data ³ 03.09.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna a descricao do motivo da baixa                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AtfGetMtvo( aMotBaixa, cMotivo )
	Local cReturn 	:= STR0025 // "Motivo não cadastrado"
	Local nPos		:= aScan( aMotBaixa, { |x| Left( x, 02 ) == cMotivo } )

	If nPos > 0
		cReturn := aMotBaixa[ nPos ]
	EndIf	
Return cReturn




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fMontaFil  ³ Autor ³ Pedro Eloy           ³ Data ³ 19/02/20 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna a faixa de Filial de - ate para contemplar no rel.  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fMontaFil(nTipo)
Local aArea			:= SM0->( GetArea() )
Local _aEmpFil		:= {}

DbSelectArea("SM0")
DbSetOrder(1)  //empresa + filial
SM0->(DbGoTop())
If nTipo == 1 // Filiais informadas
	DbSeek(cEmpAnt+MV_PAR09)

	While SM0->( !Eof() .And. M0_CODIGO+M0_CODFIL <= cEmpAnt+MV_PAR10)
		Aadd(_aEmpFil,SM0->M0_CODFIL)
		dbSkip()
	EndDo
Else // Filiais branco a ZZZ....
	DbSeek(cEmpAnt)
	While SM0->( !Eof() .and. M0_CODIGO == cEmpAnt )
		Aadd(_aEmpFil,SM0->M0_CODFIL)
		dbSkip()
	EndDo

EndIf

RestArea( aArea )
RETURN(_aEmpFil)

