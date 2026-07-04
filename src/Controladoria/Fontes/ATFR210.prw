/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR210.CH"
#include "Protheus.ch"

Static _oATFR2101
STATIC lIsRussia	:= If(cPaisLoc$"RUS",.T.,.F.) // CAZARINI - Flag to indicate if is Russia location

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR210  ³ Autor ³Carlos A. Gomes Jr.    ³ Data ³ 02.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relacao de Bens  a Inventariar                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR210                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
Last change:  CIA   4 Jan 96    5:22 pm
*/
User Function ATFR210
Local oReport

Private cAliasSn3 := "SN3"

	oReport := ReportDef()
	oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR210   ºAutor  ³Carlos A. Gomes Jr. º Data ³  06/02/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport
Local oSection1
Local oSection2

Local cReport  := "ATFR210"
Local cAlias1  := "SN3"
Local cAlias2  := "SN1"
Local cTitulo  := Capital(OemToAnsi(STR0006)) // "Relacao de bens inventariados"
Local cDescri  := OemToAnsi(STR0001)+" "+OemToAnsi(STR0002)+" "+OemToAnsi(STR0003) // "Este programa ira' emitir a rela‡„o dos bens a inventar  de a-" ## "cordo com os parƒmetros escolhidos. O ajuste Contabil desses  " ##"bens deve ser feito antes do pr¢ximo c lculo"
Local cPicture := "@E 999,999,999,999"
Local nDecimal := MsDecimais(1)
Local nA       := 0
Local aOrdem   := { OemToAnsi(STR0007), OemToAnsi(STR0008), OemToAnsi(STR0019) } // "Codigo" // "C Custo"	//"Placa"
Local aHelpPor := {}
Local aHelpEng := {}
Local aHelpSpa := {}
Local aPergs   := {} 
Local aTamVal  := TAMSX3("N3_VORIG1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte( "ATR210" , .F. )

///////////////////////////////////////
// Acrescenta a qtde de casas decimais, 
// respeitando o configurado em MV_CENT
// Alteracao conforme BOPS 66.785
// Cristiano Denardi
For nA := 1 to nDecimal
	If ( nA = 1 ) 
		cPicture += "."
	Endif
	cPicture += "9"
Next nA
               
oReport  := TReport():New( cReport, cTitulo, "ATR210" , { |oReport| ATFR210Imp( oReport, cAlias1, cAlias2, aOrdem ) }, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0018+" -"+STR0011+STR0007+"/"+STR0008, {cAlias1,cAlias2} , aOrdem )		//"Bens/Saldos"##"Codigo"##"C Custo"

TRCell():New( oSection1, "N3_CBASE"   , cAlias1 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N3_CBASE")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Codigo
TRCell():New( oSection1, "N3_ITEM"    , cAlias1 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N3_ITEM")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Item
TRCell():New( oSection1, "N3_TIPO"    , cAlias1 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N3_TIPO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Tipo
TRCell():New( oSection1, "N1_CHAPA"   , cAlias2 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N1_CHAPA")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Chapa
TRCell():New( oSection1, "N1_DESCRIC" , cAlias2 ,/*X3Titulo*/,/*Picture*/,30         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Descricao
TRCell():New( oSection1, "N1_LOCAL"   , cAlias2 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N1_LOCAL")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Local
TRCell():New( oSection1, "N3_CCUSTO"  , cAlias1 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N3_CCUSTO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de Custo
TRCell():New( oSection1, "N1_GRUPO"   , cAlias2 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N1_GRUPO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Grupo
TRCell():New( oSection1, "N1_QUANTD"  , cAlias2 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N1_QUANTD")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Quantidade
TRCell():New( oSection1, "nVlrResid"  ,/*Alias*/,STR0014 , cPicture /*Picture*/,20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"CENTER")	//"Valor Resid"
TRCell():New( oSection1, "cQtdInvent" ,/*Alias*/,STR0015 ,/*Picture*/,12 ,/*lPixel*/,{|| "____________" } )		//"Qtd. Invent."
TRCell():New( oSection1, "cVldInvent" ,/*Alias*/,STR0016 ,/*Picture*/,12 ,/*lPixel*/,{|| "____________" } )		//"Vlr. Invent."
TRCell():New( oSection1, "cVisto"     ,/*Alias*/,STR0017 ,/*Picture*/,5  ,/*lPixel*/,{|| "_____" } )			//"Visto"

oSection1:SetNoFilter({cAlias2})		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 2a. secao do relatorio								³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New( oReport, STR0018+" -"+STR0011+STR0019, {"TRB",cAlias2})	//"Bens/Saldos"##"Placa"

TRCell():New( oSection2, "N3_CBASE"   , "TRB" ,/*X3Titulo*/,/*Picture*/,TAMSX3("N3_CBASE")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Codigo
TRCell():New( oSection2, "N3_ITEM"    , "TRB" ,/*X3Titulo*/,/*Picture*/,TAMSX3("N3_ITEM")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Item
TRCell():New( oSection2, "N3_TIPO"    , "TRB" ,/*X3Titulo*/,/*Picture*/,TAMSX3("N3_TIPO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Tipo
TRCell():New( oSection2, "N1_CHAPA"   , cAlias2 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N1_CHAPA")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Chapa
TRCell():New( oSection2, "N1_DESCRIC" , cAlias2 ,/*X3Titulo*/,/*Picture*/,30         ,/*lPixel*/,/*{|| code-block de impressao }*/)	// Descricao
TRCell():New( oSection2, "N1_LOCAL"   , cAlias2 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N1_LOCAL")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Local
TRCell():New( oSection2, "N3_CCUSTO"  , "TRB" ,/*X3Titulo*/,/*Picture*/,TAMSX3("N3_CCUSTO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de Custo
TRCell():New( oSection2, "N1_GRUPO"   , cAlias2 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N1_GRUPO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Grupo
TRCell():New( oSection2, "N1_QUANTD"  , cAlias2 ,/*X3Titulo*/,/*Picture*/,TAMSX3("N1_QUANTD")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Quantidade
TRCell():New( oSection2, "nVlrResid"  ,/*Alias*/,STR0014 , cPicture /*Picture*/, 20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"CENTER")	//"Valor Resid"
TRCell():New( oSection2, "cQtdInvent" ,/*Alias*/,STR0015 ,/*Picture*/,12 ,/*lPixel*/,{|| "____________" } )		//"Qtd. Invent."
TRCell():New( oSection2, "cVldInvent" ,/*Alias*/,STR0016 ,/*Picture*/,12 ,/*lPixel*/,{|| "____________" } )		//"Vlr. Invent."
TRCell():New( oSection2, "cVisto"     ,/*Alias*/,STR0017 ,/*Picture*/,5  ,/*lPixel*/,{|| "_____" } )			//"Visto"

oSection2:Disable()
oSection2:SetNoFilter({"TRB"})		

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR200ImpºAutor  ³Carlos A. Gomes Jr. º Data ³  06/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFR210Imp( oReport, cAlias1, cAlias2, aOrdem )

Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)

Local cQuery   := GetNextAlias()
Local cAliasSn1 := cQuery
Local cChave   := ""
Local cWhere   := ""
Local cN1TipoNeg := Alltrim(SuperGetMv("MV_N1TPNEG",.F.,"")) // Tipos de N1_PATRIM que aceitam Valor originais negativos
Local cN3TipoNeg := Alltrim(SuperGetMv("MV_N3TPNEG",.F.,"")) // Tipos de N3_TIPO que aceitam Valor originais negativos
Local cTipoN3	:= "'01','10','12','16','17'"

Local cTypes10	:= IIF(lIsRussia, AtfNValMod({1}, "|"),"") // CAZARINI - 29/03/2017 - If is Russia, add new valuations models - main models
Local cTypes17	:= IIF(lIsRussia, AtfNValMod({3}, "|"),"") // CAZARINI - 29/03/2017 - If is Russia, add new valuations models - 17 models
Local cTypes16	:= IIF(lIsRussia, AtfNValMod({4}, "|"),"") // CAZARINI - 29/03/2017 - If is Russia, add new valuations models - 16 models
Local cTypes12	:= IIF(lIsRussia, AtfNValMod({2}, "|"),"") // CAZARINI - 10/04/2017 - If is Russia, add new valuations models - recoverable models
Local cTypesNM	:= cTypes10 + Iif(!Empty(cTypes12),"|" + cTypes12,"")  + Iif(!Empty(cTypes17),"|" + cTypes17,"") + Iif(!Empty(cTypes16),"|" + cTypes16,"")
Local aTypesNM	:= {}
Local nTypesNM	:= 0

If "10" $ cN3TipoNeg
	cN3TipoNeg += "|" + cTypes10
Endif
If "17" $ cN3TipoNeg
	cN3TipoNeg += "|" + cTypes17
Endif
If "16" $ cN3TipoNeg
	cN3TipoNeg += "|" + cTypes16
Endif

aTypesNM := Separa(cTypesNM, '|', .f.)

If len(aTypesNM) > 0
	For nTypesNM := 1 to len(aTypesNM)
		cTipoN3 += ",'" + aTypesNM[nTypesNM] + "'"
	Next nTypesNM
Endif
If cPaisLoc == "COL"
	cTipoN3	+= ",'50','51','52','53','54'"
EndIf

oReport:SetTitle(Capital(STR0006)+OemToAnsi(STR0011)+; // " por "
				aOrdem[oSection1:GetOrder()]+OemToAnsi(STR0012) +; //" em "
				DTOC(mv_par10))

If oSection1:nOrder == 1
	cChave := "N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO+N3_BAIXA+N3_SEQ"
ElseIf oSection1:nOrder == 2
	cChave := "N3_FILIAL+N3_CCONTAB+N3_CBASE+N3_ITEM+N3_TIPO+N3_BAIXA"
ElseIf oSection1:nOrder == 3
	cChave := "N3_FILIAL+N1_CHAPA"
EndIf

If mv_par09 != 1
	oSection1:Cell("N1_QUANTD"):Disable()
	oSection1:Cell("nVlrResid"):Disable()
EndIf

If mv_par11 == 1 //Se for igual a (1) imprimir apenas o tipo 1
	cTipoN3	:= '01' //Quais tipos? (1)- Imprimir apenas o tipo 01 ou (2)Imprimir Todos
	cWhere := " AND SN3.N3_TIPO in ( " + cTipoN3 + " )"
EndIf


cChave := "%"+SqlOrder(cChave)+"%"
oSection1:BeginQuery()
cWhere := "%"+cWhere+"%"

BeginSql Alias cQuery
	SELECT
		N3_CBASE, N3_ITEM, N3_TIPO, N3_CCUSTO,
		N3_VORIG1,N3_VRCACM1,N3_AMPLIA1,N3_VRDACM1,N3_VRCDA1,
		N1_CHAPA, N1_DESCRIC, N1_GRUPO, N1_QUANTD, N1_PATRIM, N1_LOCAL
	FROM 
		%table:SN3% SN3, %table:SN1% SN1
	WHERE
		SN3.N3_FILIAL = %xfilial:SN3% AND
		SN3.N3_CBASE  >= %Exp:mv_par01% AND
		SN3.N3_CBASE  <= %Exp:mv_par02% AND
		SN1.N1_GRUPO  >= %Exp:mv_par03% AND 
		SN1.N1_GRUPO  <= %Exp:mv_par04% AND
		SN3.N3_CCUSTO >= %Exp:mv_par05% AND 
		SN3.N3_CCUSTO <= %Exp:mv_par06% AND
		SN1.N1_LOCAL  >= %Exp:mv_par07% AND 
		SN1.N1_LOCAL  <= %Exp:mv_par08% AND
		SN1.N1_CHAPA  >= %Exp:mv_par12% AND
		SN1.N1_CHAPA  <= %Exp:mv_par13% AND			
		SN3.N3_BAIXA  = '0' AND
		SN3.%notDel% AND
		SN1.N1_FILIAL = %xfilial:SN1%  AND
		SN1.N1_CBASE = SN3.N3_CBASE AND
		SN1.N1_ITEM = SN3.N3_ITEM AND
		SN1.%notDel%
		%Exp:cWhere%
	ORDER BY %Exp:cChave%
EndSql

oSection1:EndQuery()


oSection1:Cell("nVlrResid"):SetBlock( {|| Iif( N3_TIPO = "05" .Or. (cAliasSn1)->N1_PATRIM $ cN1TipoNeg .Or. N3_TIPO $ cN3TipoNeg,;
																N3_VORIG1+N3_VRCACM1+N3_AMPLIA1+Abs(N3_VRDACM1+N3_VRCDA1) , ;
																(N3_VORIG1+N3_VRCACM1+N3_AMPLIA1) - (N3_VRDACM1+N3_VRCDA1) ) } )	// Valor Residual

oSection1:Print()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ATR210TRB	º Autor ³ Marcio Menon		  º Data ³  23/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³Criar o arquivo temporário	                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ATFR210	                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ATR210TRB()

Local cArqTmp	:= ""
Local aChave   	:= {}          
Local aCampos  	:= {}
Local lLoop 	:= .F.
Local nI

Local cTypes10	:= IIF(lIsRussia,"*" + AtfNValMod({1}, "*"),"") // CAZARINI - 29/03/2017 - If is Russia, add new valuations models - main models
Local cTypesNM	:= IIF(lIsRussia,"*" + AtfNValMod({3,4}, "*"),"") // CAZARINI - 29/03/2017 - If is Russia, add new valuations models - 17 and 16 models
aCampos := SN3->(dbStruct())

aAdd(aCampos,{"N1_CHAPA","C",Len(SN1->N1_CHAPA),0})

If Select("TRB") > 0
	dbSelectArea("TRB")
	dbCloseArea()
Endif

aChave	:= {"N3_FILIAL","N1_CHAPA"}

_oATFR2101 := FWTemporaryTable():New("TRB")
_oATFR2101:SetFields( aCampos )

_oATFR2101:AddIndex("1", aChave)	
_oATFR2101:Create()

cArqTmp 		:= _oATFR2101:GetRealName()

dbSelectArea("SN3")
dbGotop()
	
While !SN3->(Eof()) .And. SN3->N3_FILIAL == xFilial("SN3")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Localiza item no SN1                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SN1")
	MsSeek(xFilial("SN1")+SN3->N3_CBASE+SN3->N3_ITEM)

	If SN1->N1_CHAPA  >= mv_par12 .And. SN1->N1_CHAPA  <= mv_par13
	
		lLoop := .F.
		lLoop := IIF(SN3->N3_CBASE  < mv_par01 .Or. SN3->N3_CBASE  > mv_par02, .T., lLoop)
		lLoop := IIF(SN3->N3_CCUSTO < mv_par05 .Or. SN3->N3_CCUSTO > mv_par06, .T., lLoop)
		lLoop := IIF(SN1->N1_GRUPO  < mv_par03 .Or. SN1->N1_GRUPO  > mv_par04, .T., lLoop)
		lLoop := IIF(SN1->N1_LOCAL  < mv_par07 .Or. SN1->N1_LOCAL  > mv_par08, .T., lLoop)
		lLoop := IIF(Val(SN3->N3_BAIXA) != 0, .T.,lLoop)

		If cPaisLoc == "COL"
			lLoop := IIF(mv_par11 == 1 .and. !( (cAliasSn3)->N3_TIPO $ "01*10*16*17" ) .and. (cAliasSn3)->N3_TIPO $ ("12/50/51/52/53/54"), .T.,lLoop)
		Else
			lLoop := IIF(mv_par11 == 1 .and. !( (cAliasSn3)->N3_TIPO $ ("01*10*16*17" + cTypes10 + cTypesNM) ), .T.,lLoop)
		EndIf

		If	lLoop
			SN3->(dbSkip())
			Loop
		EndIf
	
		dbSelectArea("TRB")
		RecLock("TRB", .T. )

		For nI := 1 To fCount()
			If TRB->(FieldName(nI)) != "N1_CHAPA"
				TRB->(FieldPut(nI,SN3->(FieldGet(nI)))) // Grava todos os campos do SN3 no TRB 
			Else	
				TRB->N1_CHAPA := SN1->N1_CHAPA
			Endif	  	
		Next
		TRB->(MsUnlock())
		SN3->(dbSkip())	
	Else
		SN3->(dbSkip())	
	EndIf
EndDo

Return cArqTmp
