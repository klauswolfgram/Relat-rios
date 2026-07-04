/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR200.CH"
#Include "Protheus.ch"

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.  
// TRADUCAO DE CH'S PARA PORTUGAL     
// TRADUCAO DE CH'S PARA PORTUGAL - 21/07/08
/*
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ ATFR200    ณ Autor ณ Carlos A. Gomes Jr.   ณ Data ณ 01.06.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Relatorio de Bens Totalmente Depreciados                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ SIGAATF                                                      ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ATFR200()
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATFR200   บAutor  ณCarlos A. Gomes Jr. บ Data ณ  06/01/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Definicao do objeto do relatorio personalizavel e das      บฑฑ
ฑฑบ          ณ secoes que serao utilizadas                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAATF                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

Local oReport,oSection1,oSection2
Local cReport := "ATFR200"
Local cAlias1 := "SN3"
Local cAlias2 := "SN1"
Local cTitulo := OemToAnsi(STR0003) // "Bens Depreciados Por %"
Local cDescri := OemToAnsi(STR0001)+" "+OemToAnsi(STR0002) // "Este programa ir  emitir a relao dos Bens que j "  // "foram totalmente depreciados por %"
Local oSecFil	:= Nil

Pergunte( "ATR200" , .F. )

oReport  := TReport():New( cReport, cTitulo, "ATR200" , { |oReport| ATFR200Imp( oReport, cAlias1, cAlias2 ) }, cDescri,.T.,,,,,,0)

oReport:SetUseGC(.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define a 1a. secao do relatorio Valores nas Moedas   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection1 := TRSection():New( oReport, cTitulo, {cAlias1,cAlias2},,,,,,,,,,,,,.T. )
oSection1:SetAutoSize(.T.)
oSection1:SetLinesBefore(2)
TRCell():New( oSection1, "N3_TXDEPR1"	, cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Taxa Anual Deprec
TRCell():New( oSection1, "N3_CBASE"		, cAlias1 ,STR0021			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //"Codigo"
TRCell():New( oSection1, "N3_ITEM"		, cAlias1 ,STR0022			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //"Item"
TRCell():New( oSection1, "N3_FILIAL"	, cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Taxa Anual Deprec
TRCell():New( oSection1, "N3_TIPO"		, cAlias1 ,STR0023			,/*Picture*/,/*nTam*/	,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //"Tipo"
TRCell():New( oSection1, "N3_TPSALDO"	, cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Tipo de Saldo
TRCell():New( oSection1, "N1_DESCRIC"	, cAlias2 ,/*X3Titulo*/     ,/*Picture*/,20			,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,.T.			) //Descricao
TRCell():New( oSection1, "N3_VORIG1"	, cAlias1 ,GetMV("MV_SIMB1"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Moeda 01
TRCell():New( oSection1, "N3_VORIG2"	, cAlias1 ,GetMV("MV_SIMB2"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Moeda 02
TRCell():New( oSection1, "N3_VORIG3"	, cAlias1 ,GetMV("MV_SIMB3"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Moeda 03
TRCell():New( oSection1, "N3_VORIG4"	, cAlias1 ,GetMV("MV_SIMB4"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Moeda 04
TRCell():New( oSection1, "N3_VORIG5"	, cAlias1 ,GetMV("MV_SIMB5"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Moeda 05
TRCell():New( oSection1, "N3_VRCACM1"	, cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Correcao Acumulada
TRCell():New( oSection1, "N3_VRDACM1"	, cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Depr Acumulada
TRCell():New( oSection1, "N3_VRCDA1"	, cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Corr Depr Acumul
TRCell():New( oSection1, "N3_AMPLIA1"	, cAlias1 ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/	) //Vlr Ampliacao

/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SN3"})
TRCell():New(oSecFil,"CODFIL" ,,STR0024,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)			//"C๓digo"
TRCell():New(oSecFil,"EMPRESA",,STR0025,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0026,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Unidade de neg๓cio"	
TRCell():New(oSecFil,"NOMEFIL",,STR0027,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Filial"

oReport:SetTotalInLine(.F.)
oReport:DisableOrientation()

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATFR200ImpบAutor  ณCarlos A. Gomes Jr. บ Data ณ  06/01/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณQuery de impressao do relatorio                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAATF                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ATFR200Imp( oReport, cAlias1, cAlias2 )
Local oBreak		:= Nil
Local oSection1		:= oReport:Section(1)
Local cQuery		:= "SN3"
Local cChave		:= ""
Local cMoeda		:= GetMv("MV_ATFMOED")
Local cWhere		:= ""        
Local aClassif		:= {}
Local cClassif		:= ""
Local lAtfCusPrv	:= AFXAtCsPrv()
Local cFiltro		:= ""
/*-*/
Local aSelFil		:= {}
Local cTmpFil		:= ""
Local cFilSN1		:= ""
Local cFilSN3		:= ""
Local lSelFil		:= .F.

If mv_par11 == 1
	aClassif := AdmGetClass()	
	If Len( aClassif ) <= 0
		Return
	EndIf 		
EndIf

If mv_par10 = 1
	cChave  := "N3_FILIAL+STR(N3_TXDEPR1,8,4)"
Else
	cChave  := "N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO"
EndIf

	lSelFil := (FwSizeFilial() > 2)
	If lSelFil
		If mv_par10 = 1
			cChave  := "STR(N3_TXDEPR1,8,4)"
		Else
			cChave  := "N3_CBASE+N3_ITEM+N3_TIPO"
		EndIf
		oSection1:Cell("N1_DESCRIC"):SetSize(If(MV_PAR10 == 1,20,30))
		If MV_PAR13 == 1 
			AdmSelecFil("ATR200",13,.F.,@aSelFil,"SN3",.F.)
		Endif
		If Empty(aSelFil)
			Aadd(aSelFil,cFilAnt)
		Endif
	Else
		oSection1:Cell("N3_FILIAL"):Disable()
	Endif
	cQuery := GetNextAlias()			
	If lSelFil
		MsgRun(STR0028,STR0003,{|| cFilSN1 := GetRngFil(aSelFil,"SN1",.T.,@cTmpFil)}) //"Favor Aguardar..."###"Bens Depreciados"
		cFilSN3 := "%SN3.N3_FILIAL " + cFilSN1 + "%"
		cFilSN1 := "%SN1.N1_FILIAL " + cFilSN1 + "%"
	Else
		cFilSN1 := "%SN1.N1_FILIAL = '" + xFilial("SN1") + "'%"
		cFilSN3 := "%SN3.N3_FILIAL = '" + xFilial("SN3") + "'%"
	Endi
	
	cWhere := "% AND (ABS(N3_VORIG"+cMoeda+") + N3_AMPLIA"+cMoeda+") - ABS(N3_VRDACM"+cMoeda+") <= 0 "	
	//Filtra as classifica็๕es
	If Len(aClassif) > 0 
		cWhere += " AND SN1.N1_PATRIM IN " + FORMATCLAS(aClassif,.T.) 
	EndIf
	
	If lAtfCusPrv .And. MV_PAR12 == 2
		cWhere += " AND N3_ATFCPR <> '1' "
	EndIf 
	
	cWhere += " %"	
	cChave := "%" + SqlOrder( cChave ) + "%"
	
	oSection1:BeginQuery()

	BeginSql Alias cQuery
		SELECT
			N3_FILIAL,N3_CBASE, N3_ITEM, N3_TXDEPR1, 
			N3_VORIG1, N3_VORIG2, N3_VORIG3, N3_VORIG4, N3_VORIG5,
			N3_AMPLIA1, N3_AMPLIA2, N3_AMPLIA3, N3_AMPLIA4, N3_AMPLIA5, 
			N3_VRCACM1, N3_VRDACM1, N3_VRCDA1, N3_AMPLIA1,      
			N1_DESCRIC,N3_TPSALDO,N3_TIPO
		FROM 
			%table:SN3% SN3, %table:SN1% SN1
		WHERE
			%Exp:cFilSN3% AND
			 ( SN3.N3_FIMDEPR >= %Exp:DTOS(mv_par01)% AND 
			    SN3.N3_FIMDEPR <= %Exp:DTOS(mv_par02)% ) AND 
			  ( N3_VORIG1 <= ( N3_VRDACM1 + N3_AMPLIA1 + N3_VRCACM1 ) ) AND
			SN3.N3_CBASE >= %Exp:mv_par03% AND 
			SN3.N3_CBASE <= %Exp:mv_par04% AND
			SN3.N3_CDEPREC <> ' ' AND
			SN3.N3_CCDEPR <> ' ' AND
			SN3.N3_BAIXA = '0' AND
			SN3.%notDel% AND
			%Exp:cFilSN1% AND
			SN1.N1_CBASE = SN3.N3_CBASE AND
			SN1.N1_ITEM = SN3.N3_ITEM AND
			SN1.%notDel%
			%Exp:cWhere%
		ORDER BY %Exp:cChave%
	EndSql

	oSection1:EndQuery()

oSection1:Cell("N3_VORIG1"):SetBlock({|| (cQuery)->(N3_VORIG1+N3_AMPLIA1) })
oSection1:Cell("N3_VORIG2"):SetBlock({|| (cQuery)->(N3_VORIG2+N3_AMPLIA2) })
oSection1:Cell("N3_VORIG3"):SetBlock({|| (cQuery)->(N3_VORIG3+N3_AMPLIA3) })
oSection1:Cell("N3_VORIG4"):SetBlock({|| (cQuery)->(N3_VORIG4+N3_AMPLIA4) })
oSection1:Cell("N3_VORIG5"):SetBlock({|| (cQuery)->(N3_VORIG5+N3_AMPLIA5) })

If mv_par10 == 1
	oBreak := TRBreak():New ( oSection1 , oSection1:Cell("N3_TXDEPR1") , OemToAnsi(STR0008))//+Str(oSection1:Cell("N3_TXDEPR1"):GetValue(),8,2), )
Else
	oSection1:Cell("N3_TXDEPR1"):Disable()
EndIf

If	mv_par05 != 1
	oSection1:Cell("N3_VORIG1"):Disable()
Else
	TRFunction():New ( oSection1:Cell("N3_VORIG1") , , "SUM" , Iif(mv_par10 == 1,oBreak,) , , , , .F. ,  )
EndIf
If	mv_par06 != 1
	oSection1:Cell("N3_VORIG2"):Disable()
Else
	TRFunction():New ( oSection1:Cell("N3_VORIG2") , , "SUM" , Iif(mv_par10 == 1,oBreak,) , , , , .F. ,  )
EndIf
If	mv_par07 != 1
	oSection1:Cell("N3_VORIG3"):Disable()
Else
	TRFunction():New ( oSection1:Cell("N3_VORIG3") , , "SUM" , Iif(mv_par10 == 1,oBreak,) , , , , .F. ,  )
EndIf
If	mv_par08 != 1
	oSection1:Cell("N3_VORIG4"):Disable()
Else
	TRFunction():New ( oSection1:Cell("N3_VORIG4") , , "SUM" , Iif(mv_par10 == 1,oBreak,) , , , , .F. ,  )
EndIf
If	mv_par09 != 1
	oSection1:Cell("N3_VORIG5"):Disable()
Else
	TRFunction():New ( oSection1:Cell("N3_VORIG5") , , "SUM" , Iif(mv_par10 == 1,oBreak,) , , , , .F. ,  )
EndIf

TRFunction():New ( oSection1:Cell("N3_VRCACM1") , , "SUM" , Iif(mv_par10 == 1,oBreak,) , , , , .F. ,  )
TRFunction():New ( oSection1:Cell("N3_VRDACM1") , , "SUM" , Iif(mv_par10 == 1,oBreak,) , , , , .F. ,  )
TRFunction():New ( oSection1:Cell("N3_VRCDA1" ) , , "SUM" , Iif(mv_par10 == 1,oBreak,) , , , , .F. ,  )
TRFunction():New ( oSection1:Cell("N3_AMPLIA1") , , "SUM" , Iif(mv_par10 == 1,oBreak,) , , , , .F. ,  )

If lSelFil .And. Len(aSelFil) > 1
	oSection1:OnPrintLine({|| U_AFR200Fil(@aSelFil,oReport)})
Endif

oSection1:Print()

If !Empty(cTmpFil)
	MsgRun(STR0028,STR0003,{|| CtbTmpErase(cTmpFil)}) //"Favor Aguardar..."###"Bens Depreciados"
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAFR200FIL  บAutor  ณ                    บ Data ณ 24/01/2014  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelacao das filiais selecionadas para o relatorio            บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAATF                                                     บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AFR200Fil(aSelFil,oReport)
Local oSecFil	:= Nil
Local aSM0		:= {}
Local nRegSM0	:= 0
Local nTamEmp	:= 0
Local nTamUnNeg	:= 0
Local nTamTit	:= 0
Local nX		:= 0
Local nLinha	:= 0
Local cTitulo 	:= ""

oReport:Section(1):OnPrintLine({|| })
oSecFil := oReport:Section("SECFIL")
nRegSM0 := SM0->(Recno())
aSM0 := FWLoadSM0()
SM0->(DbGoTo(nRegSM0))
nTamEmp := Len(FWSM0LayOut(,1))
nTamUnNeg := Len(FWSM0LayOut(,2))
cTitulo := oReport:Title()
oReport:SetTitle(cTitulo + " (" + STR0029 + ")")		//"Filiais selecionadas para o relatorio"
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
Return()