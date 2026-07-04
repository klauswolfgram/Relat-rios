/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR721.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE CRLF Chr(13)+Chr(10)

Static __oFinr721

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FINR721  ³ Autor ³ Claudio D. de Souza   ³ Data ³ 29.10.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Comparativo entre Valores Or‡ados x Reais Mensal por C.C   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR721(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Financeiro                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR721()
Local oReport

oReport:=ReportDef()
oReport:PrintDialog()

RETURN NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³23/06/2006³±±
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
Static Function ReportDef
Local oReport, oSection1, oSection11, oSubtotal, oAcumulado
Local cReport := "FINR721"
Local cTitulo := STR0045	//"Mapa Comparativo - Valores Orcados x Reais "
Local cDescri :=	STR0001 + " " +;	//"Emiss„o do relat¢rio comparativo entre Or‡ados x Reais."
					  	STR0002 + " "   	//"Ser  analisado o mˆs de referˆncia da data base"
					  	

Local aOrd			:= {}
Local cDescCust	:= CTBSAYAPRO("CTT")
Local i,nTamEdCod := 0
Local cMascEd 		:= Getmv("MV_MASCNAT")

//Calcular o nro de elementos da mascara da natureza
nTamEdCod	:=	0	
For i:= 1 To Len(cMascEd)
   nTamEdCod += Val(Substr(cMascEd,i,1))+1
Next

Pergunte( "FIN721" , .F. )

oReport  := TReport():New( cReport, cTitulo, "FIN721" , {|oReport| ReportPrint(oReport)}, cDescri )

oSection1 := TRSection():New( oReport, cDescCust, {"cArqTmp"}, aOrd )
TRCell():New( oSection1, "CTT_CUSTO"	, "CTT", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "CTT_DESC01"	, "CTT", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oSection1:SetNoFilter("cArqTmp")

oSection11 := TRSection():New( oSection1, STR0046+cDescCust, {"cArqTmp"}, aOrd )   //"Naturezas do "
TRCell():New( oSection11, "ED_CODIGO"	, "SED", /*X3Titulo*/, /*Picture*/, nTamEdCod ,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "ED_DESCRIC"	, "SED", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "AREALIZAR"	,		 , STR0037 + CRLF + PadC("(A)",14) /*X3Titulo*/, "@E 99,999,999.99" /*Picture*/, 14 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "A Realizar"
TRCell():New( oSection11, "REALIZADO"	,		 , STR0038 + CRLF + PadC("(B)",14) /*X3Titulo*/, "@E 99,999,999.99"/*Picture*/, 14 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Realizado"
TRCell():New( oSection11, "ORCADO"		,		 , STR0040 + CRLF + PadC("(C)",14) /*X3Titulo*/, "@E 99,999,999.99"/*Picture*/, 14/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Orçado"
TRCell():New( oSection11, "PERC"			,		 , PadC("%",20) + CRLF + "(A/B)/C" + Space(5) + "B/C" /*X3Titulo*/, /*Picture*/, 20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oSection11:Cell("PERC"):SetHeaderAlign("CENTER")


TRCell():New( oSection11, "AREALIZARAC"	,		 , STR0041 + CRLF + PadC(STR0042,14) /*X3Titulo*/, "@E 99,999,999.99" /*Picture*/, 14 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Acumulado"
TRCell():New( oSection11, "REALIZADOAC"	,		 , STR0041 + CRLF + PadC(STR0043,14) /*X3Titulo*/, "@E 99,999,999.99"/*Picture*/, 14 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Acumulado"
TRCell():New( oSection11, "ORCADOAC"		,		 , STR0041 + CRLF + PadC(STR0044,14) /*X3Titulo*/, "@E 99,999,999.99"/*Picture*/, 14/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Acumulado"
TRCell():New( oSection11, "PERCAC"			,		 , PadC("%",20) + CRLF + "(D+E)/F" + Space(5) + "E/F" /*X3Titulo*/, /*Picture*/, 20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oSection11:Cell("PERCAC"):SetHeaderAlign("CENTER")
oSection11:SetNoFilter("cArqTmp")

oSubtotal := TRSection():New( oSection1, STR0047, {"cArqTmp"}, aOrd )  //"Sub-total da Natureza"
TRCell():New( oSubtotal, "HISTORICO"	, 		 , STR0039 /*X3Titulo*/, /*Picture*/, Len(SED->ED_CODIGO)+Len(SED->ED_DESCRIC) + 2 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Total "
TRCell():New( oSubtotal, "AREALIZAR"	,		 , STR0037 + CRLF + PadC("(A)",14) /*X3Titulo*/, "@E 99,999,999.99" /*Picture*/, 14 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"A Realizar"
TRCell():New( oSubtotal, "REALIZADO"	,		 , STR0038 + CRLF + PadC("(B)",14) /*X3Titulo*/, "@E 99,999,999.99"/*Picture*/, 14 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Realizado"
TRCell():New( oSubtotal, "ORCADO"		,		 , STR0040 + CRLF + PadC("(C)",14) /*X3Titulo*/, "@E 99,999,999.99"/*Picture*/, 14/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Orçado"
TRCell():New( oSubtotal, "PERC"			,		 , PadC("%",20) + CRLF + "(A+B)/C" + Space(5) + "B/C" /*X3Titulo*/, /*Picture*/, 20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oSubtotal:Cell("PERC"):SetHeaderAlign("CENTER")

TRCell():New( oSubtotal, "AREALIZARAC"	,		 , STR0041 + CRLF + PadC(STR0042,14) /*X3Titulo*/, "@E 99,999,999.99" /*Picture*/, 14 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Acumulado" ## "A Realizar (D)"
TRCell():New( oSubtotal, "REALIZADOAC"	,		 , STR0041 + CRLF + PadC(STR0043,14) /*X3Titulo*/, "@E 99,999,999.99"/*Picture*/, 14 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Acumulado" ## "Realizado (E)"
TRCell():New( oSubtotal, "ORCADOAC"		,		 , STR0041 + CRLF + PadC(STR0044,14) /*X3Titulo*/, "@E 99,999,999.99"/*Picture*/, 14/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Acumulado" ## "Orçado (F)"
TRCell():New( oSubtotal, "PERCAC"		,		 , PadC("%",20) + CRLF + "(D+E)/F" + Space(5) + "E/F" /*X3Titulo*/, /*Picture*/, 20 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oSubtotal:SetHeaderSection(.F.)
oSubtotal:SetNoFilter("cArqTmp")


oTotalMes := TRSection():New( oReport, STR0048 , {"cArqTmp"}, aOrd )  //"Totais no Mês"
TRCell():New( oTotalMes, "RECEBER"	,		 , STR0034 /*X3Titulo*/, ""/*Picture*/, 19/*Tamanho*/,/*lPixel*/, {|| "" } )  //"Receber"
TRCell():New( oTotalMes, "PAGAR"		,		 , STR0035 /*X3Titulo*/, ""/*Picture*/, 21/*Tamanho*/,/*lPixel*/, {|| "" } ) //"Pagar "
TRCell():New( oTotalMes, "SALDOS"	,		 , STR0036 /*X3Titulo*/, ""/*Picture*/, /*Tamanho*/,/*lPixel*/, {|| "" } )  //"Saldos "
oTotalMes:Cell("SALDOS"):SetCellBreak(.T.)

TRCell():New( oTotalMes, "REALIZARRECEBER"	,		 , Pad(STR0037,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"A Realizar"
TRCell():New( oTotalMes, "REALIZARPAGAR"		,		 , Pad(STR0037,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"A Realizar"
TRCell():New( oTotalMes, "REALIZARSALDOS"		,		 , Pad(STR0037,10,".") /*X3Titulo*/, ""/*Picture*/, 40/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"A Realizar"
oTotalMes:Cell("REALIZARSALDOS"):SetCellBreak(.T.)

TRCell():New( oTotalMes, "REALIZADORECEBER"	,		 , Pad(STR0038,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Realizado"
TRCell():New( oTotalMes, "REALIZADOPAGAR"		,		 , Pad(STR0038,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Realizado"
TRCell():New( oTotalMes, "REALIZADOSALDOS"	,		 , Pad(STR0038,10,".") /*X3Titulo*/, ""/*Picture*/, 40 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Realizado"
oTotalMes:Cell("REALIZADOSALDOS"):SetCellBreak(.T.)                 

TRCell():New( oTotalMes, "TOTALRECEBER"		,		 , Pad(STR0039,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Total"
TRCell():New( oTotalMes, "TOTALPAGAR"			,		 , Pad(STR0039,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Total"
TRCell():New( oTotalMes, "TOTALSALDOS"			,		 , Pad(STR0039,10,".") /*X3Titulo*/, ""/*Picture*/, 40 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Total"
oTotalMes:Cell("TOTALSALDOS"):SetCellBreak(.T.)

TRCell():New( oTotalMes, "ORCADORECEBER"		,		 , Pad(STR0040,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Orçado"
TRCell():New( oTotalMes, "ORCADOPAGAR"			,		 , Pad(STR0040,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Orçado"
TRCell():New( oTotalMes, "ORCADOSALDOS"		,		 , Pad(STR0040,10,".") /*X3Titulo*/, ""/*Picture*/, 40 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Orçado"
oTotalMes:Cell("ORCADOSALDOS"):SetCellBreak(.T.)
oTotalMes:SetNoFilter("cArqTmp")
oTotalMes:SetLineStyle()

oCompara := TRSection():New( oReport, STR0049, {"cArqTmp"}, aOrd )  //"Comparativo"
TRCell():New( oCompara, "RECEBER"	,		 , "Receber" /*X3Titulo*/, ""/*Picture*/, 28/*Tamanho*/,/*lPixel*/, {|| "" } ) 
TRCell():New( oCompara, "PAGAR"		,		 , "Pagar  " /*X3Titulo*/, ""/*Picture*/, 21/*Tamanho*/,/*lPixel*/, {|| "" } ) 
oCompara:Cell("PAGAR"):SetCellBreak(.T.)

TRCell():New( oCompara, "REALIZADORECEBER"	,		 , Pad("Realizado",10,".") /*X3Titulo*/, ""/*Picture*/, 25/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oCompara, "REALIZADOPAGAR"		,		 , Pad("Realizado",10,".") /*X3Titulo*/, ""/*Picture*/, 25/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oCompara:Cell("REALIZADOPAGAR"):SetCellBreak(.T.)                 

TRCell():New( oCompara, "TOTALRECEBER"		,		 , Pad("Total",10,".") /*X3Titulo*/, "" /*Picture*/, 25/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oCompara, "TOTALPAGAR"		,		 , Pad("Total",10,".") /*X3Titulo*/, "" /*Picture*/, 25 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
oCompara:Cell("TOTALPAGAR"):SetCellBreak(.T.)
oCompara:SetNoFilter("cArqTmp")
oCompara:SetLineStyle()

oAcumulado := TRSection():New( oReport, STR0050 , {"cArqTmp"}, aOrd )  //"Totais Acumulados"
TRCell():New( oAcumulado, "RECEBER"	,		 , STR0034 /*X3Titulo*/, ""/*Picture*/, 19/*Tamanho*/,/*lPixel*/, {|| "" } )  // "Receber"
TRCell():New( oAcumulado, "PAGAR"	,		 , STR0035 /*X3Titulo*/, ""/*Picture*/, 21/*Tamanho*/,/*lPixel*/, {|| "" } )  // "Pagar  "
TRCell():New( oAcumulado, "SALDOS"	,		 , STR0036 /*X3Titulo*/, ""/*Picture*/, /*Tamanho*/,/*lPixel*/, {|| "" } )  // "Saldos "
oAcumulado:Cell("SALDOS"):SetCellBreak(.T.)

TRCell():New( oAcumulado, "REALIZARRECEBER"	,		 , Pad(STR0037,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "A Realizar"
TRCell():New( oAcumulado, "REALIZARPAGAR"		,		 , Pad(STR0037,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "A Realizar"
TRCell():New( oAcumulado, "REALIZARSALDOS"	,		 , Pad(STR0037,10,".") /*X3Titulo*/, ""/*Picture*/, 40/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "A Realizar"
oAcumulado:Cell("REALIZARSALDOS"):SetCellBreak(.T.)

TRCell():New( oAcumulado, "REALIZADORECEBER"	,		 , Pad(STR0038,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Realizado"
TRCell():New( oAcumulado, "REALIZADOPAGAR"	,		 , Pad(STR0038,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Realizado"
TRCell():New( oAcumulado, "REALIZADOSALDOS"	,		 , Pad(STR0038,10,".") /*X3Titulo*/, ""/*Picture*/, 40 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Realizado"
oAcumulado:Cell("REALIZADOSALDOS"):SetCellBreak(.T.)                 

TRCell():New( oAcumulado, "TOTALRECEBER"		,		 , Pad(STR0039,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Total"
TRCell():New( oAcumulado, "TOTALPAGAR"			,		 , Pad(STR0039,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Total"
TRCell():New( oAcumulado, "TOTALSALDOS"		,		 , Pad(STR0039,10,".") /*X3Titulo*/, ""/*Picture*/, 40 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Total"
oAcumulado:Cell("TOTALSALDOS"):SetCellBreak(.T.)

TRCell():New( oAcumulado, "ORCADORECEBER"		,		 , Pad(STR0040,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  // "Orçado"
TRCell():New( oAcumulado, "ORCADOPAGAR"		,		 , Pad(STR0040,10,".") /*X3Titulo*/, "@E 9,999,999,999.99"/*Picture*/, 16 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Orçado"
TRCell():New( oAcumulado, "ORCADOSALDOS"		,		 , Pad(STR0040,10,".") /*X3Titulo*/, ""/*Picture*/, 40 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Orçado"
oAcumulado:Cell("ORCADOSALDOS"):SetCellBreak(.T.)
oAcumulado:SetNoFilter("cArqTmp")
oAcumulado:SetLineStyle()

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Claudio D. de Souza º Data ³  09/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao do relatorio                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR200                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
Local oSection1		:= oReport:Section(1)
Local oSection11	:= oReport:Section(1):Section(1)
Local oSubTotal		:= oReport:Section(1):Section(2)
Local oTotalMes		:= oReport:Section(2)
Local oCompara		:= oReport:Section(3)
Local oAcumulado	:= oReport:Section(4)
Local cArqTmp 		:= ""
Local nOrcado 		:= 0
Local nLaco			:= 0
Local cMascNat		:= GetMV("MV_MASCNAT")
Local nByte			:= 0
Local cMapa			:= "123456789"
Local aNiveis		:= {}
Local aQuebras		:= {}
Local cCcusto		:= ""
Local nLimite		:= 0
Local nLaco2		:= 0
Local nQuebras		:= 0
Local aTotais 		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local nOrcAcm		:= 0
Local cTexto		:= ""
Local cTitulo		:=""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Esta matriz informa em que posi‡”es ser„o feitas as quebras.   ³
//³ 1-Byte inicial da quebra, 2-Quantidade de caracteres.          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aNiveis  := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Esta matriz armazena as chaves de quebra e os totalizadores parciais.  ³
//³ 1-Chave, 2-A Realizar, 3-Realizado e 4-Or‡ado                          ³
//³ 5-A Realizar Acum. 6-Realizado Acumulado e 7-Orcado acumulado 			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aQuebras := {}

If Empty(cMascNat)
	cMascNat := "19"
	HELP (,,"FR720NAT")
EndIf

For nLaco := 1 to len( cMascNat )
	nByte := Val( Substr( cMascNat,nLaco,1 ) )
	If nByte > 0
		AAdd( aNiveis  , { Val(Left(cMapa,1)) , nByte} )
		AAdd( aQuebras , { "", 0, 0, 0 ,0 ,0 ,0} )
		cMapa := Subst(cMapa,nByte+1,Len(cMapa)-nByte)
	Endif
Next
nLimite := IIf(Len(aNiveis) > 1, Len(aNiveis)-1, 1)

Processa( { || U_Fin721Cria(@cArqTmp,,,,,,, .T.) }, STR0033 ) // "Criando arquivo temporário de trabalho"

oSection11:Cell( "ED_CODIGO" ):SetBlock( { || Mascnat(cArqTmp->Natur) } )
oSection11:Cell( "ED_DESCRIC"):SetBlock( { || cArqTmp->DESCR } )
oSection11:Cell( "AREALIZAR" ):SetBlock( { || cArqTmp->aEntr+cArqTmp->aSaid } )	
oSection11:Cell( "REALIZADO" ):SetBlock( { || cArqTmp->rEntr+cArqTmp->rSaid } )	
oSection11:Cell( "ORCADO" ):SetBlock( { || nOrcado } )	
oSection11:Cell( "PERC" ):SetBlock( { || If( nOrcado != 0,;
														If(cArqTmp->Tipo == "R",	Transform(((cArqTmp->aEntr+cArqTmp->rEntr) * 100 ) / nOrcado ,"@E 9999.99")+" %" + Space(1) + Transform((cArqTmp->rEntr * 100 ) / nOrcado,"@E 9999.99") + " %",;
														 									Transform(((cArqTmp->aSaid+cArqTmp->rSaid) * 100 ) / nOrcado ,"@E 9999.99")+" %" + Space(1) + transform((cArqTmp->rSaid * 100 ) / nOrcado,"@E 9999.99") + " %"),;
														If(cArqTmp->Tipo == "R","B/(A+B) = "+ Transform((cArqTmp->rEntr * 100 ) / (cArqTmp->aEntr+cArqTmp->rEntr),"@E 9999.99")+" %" ,"B/(A+B) = "+Transform((cArqTmp->rSaid * 100 ) / (cArqTmp->aSaid+cArqTmp->rSaid),"@E 9999.99")+" %")) } )

oSection11:Cell( "AREALIZARAC" ):SetBlock( { || cArqTmp->AEACM+cArqTmp->ASACM } )	
oSection11:Cell( "REALIZADOAC" ):SetBlock( { || cArqTmp->REACM+cArqTmp->RSACM } )	
oSection11:Cell( "ORCADOAC" ):SetBlock( { || nOrcAcm } )	
oSection11:Cell( "PERCAC" ):SetBlock( { || If( nOrcAcm != 0,;
														If(cArqTmp->Tipo == "R",	Transform(((cArqTmp->aEacm+cArqTmp->rEacm) * 100 ) / nOrcAcm ,"@E 9999.99")+" %" + Space(1) + Transform((cArqTmp->rEacm * 100 ) / nOrcAcm,"@E 9999.99") + " %",;
														 									Transform(((cArqTmp->aSacm+cArqTmp->rSacm) * 100 ) / nOrcAcm ,"@E 9999.99")+" %" + Space(1) + transform((cArqTmp->rSacm * 100 ) / nOrcAcm,"@E 9999.99") + " %"),;
														If(cArqTmp->Tipo == "R","E/(D+E) = "+ Transform((cArqTmp->rEacm * 100 ) / (cArqTmp->aEacm+cArqTmp->rEacm),"@E 9999.99")+" %" ,"E/(D+E) = "+Transform((cArqTmp->rSacm * 100 ) / (cArqTmp->aSacm+cArqTmp->rSacm),"@E 9999.99")+" %")) } )

If mv_par07 == 2
	oSection11:Cell( "AREALIZARAC" ):Disable()
	oSection11:Cell( "REALIZADOAC" ):Disable()
	oSection11:Cell( "ORCADOAC" ):Disable()
	oSection11:Cell( "PERCAC" ):Disable()
	
	oSubTotal:Cell( "AREALIZARAC" ):Disable()
	oSubTotal:Cell( "REALIZADOAC" ):Disable()
	oSubTotal:Cell( "ORCADOAC" ):Disable()
	oSubTotal:Cell( "PERCAC" ):Disable()
Endif	

cTexto	:= GetMv("MV_MOEDA"+IIf(mv_par06==0,"1",Str(mv_par06,1)))
cTitulo	:= STR0005 + (cTexto + " " + MesExtenso( mv_par08 ) + "-" + Str(Year(mv_par08),4,0)) //"Mapa Comparativo - Valores Orcados x Reais em "

oReport:SetTitle(cTitulo)

cArqTmp->(dbGotop())
oReport:SetMeter(cArqTmp->(LastRec()))	

While !cArqTmp->( Eof() ) .And. !oReport:Cancel()

	// Guarda Centro de Custo
	cCcusto := 	cArqTmp->CCUSTO
	CTT->(MsSeek(xFilial("CTT")+cCcusto))
	
	oSection1:Init()
	oSection1:PrintLine()
	oSection1:Finish()
	
	oSection11:Init()
	
	// Processa centro de custo
	While !cArqTmp->( Eof() )	.And.;
			cArqTmp->CCUSTO == cCcusto .And.;
			!oReport:Cancel()
			
		oReport:IncMeter()
		
		nOrcado := 0
		nOrcAcm := 0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Inicia a matriz acumuladora de quebras  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nLaco := 1 to Len( aQuebras )
			aQuebras[nLaco,1] := Subst( cArqTmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )+cCcusto
			****** Parciais no Mes
			aQuebras[nLaco,2] += cArqTmp->aEntr+cArqTmp->aSaid
			aQuebras[nLaco,3] += cArqTmp->rEntr+cArqTmp->rSaid
			aQuebras[nLaco,4] += nOrcado
			****** Parciais Acumulados
			If mv_par07 == 1
				aQuebras[nLaco,5] += cArqTmp->AEACM+cArqTmp->ASACM
				aQuebras[nLaco,6] += cArqTmp->REACM+cArqTmp->RSACM
				aQuebras[nLaco,7] += nOrcAcm
			Endif
		Next
		
		nOrcado:=U_GetOrcadoCC(Year(mv_par08),Month(mv_par08),MV_PAR06,cArqTmp->NATUR,cArqTmp->CCUSTO)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Acumula or‡ados no Mes                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( cArqTmp-> Tipo == "R")
			aTotais[5] += nOrcado		// Acumula or‡ado no Mes (Receber)
		Else
			aTotais[6] += nOrcado		// Acumula or‡ado no Mes (Pagar)
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Se calcula acumulados, Acumula or‡ados no Ano  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par07 == 1
			For nLaco2:=1 to month(mv_par08)
				nOrcAcm += U_GetOrcadoCC(Year(mv_par08),nLaco2,MV_PAR06,cArqTmp->NATUR,cArqTmp->CCUSTO)
			Next
			If ( cArqTmp-> Tipo == "R")
				aTotais[11] += nOrcAcm	// Acumula or‡ado no Ano (Receber)
			Else
				aTotais[12] += nOrcAcm	// Acumula or‡ado no Acno (Pagar)
			End
		Endif
		                                                                   		
	   oSection11:PrintLine()
	
		If ( cArqTmp-> Tipo == "R" )	
			*** Atualiza Totais RECEBER
			aTotais[1]  += cArqTmp->aEntr+cArqTmp->aSaid	// A Realizar
			aTotais[3]  += cArqTmp->rEntr+cArqTmp->rSaid	// Realizado
			aTotais[7]  += cArqTmp->aEacm+cArqTmp->aSacm	// A Realizar Acumulado
			aTotais[9]  += cArqTmp->rEacm+cArqTmp->rSacm	// Realizado Acumulado
		Else	
			*** Atualiza Totais PAGAR
			aTotais[2]  += cArqTmp->aEntr+cArqTmp->aSaid	// A Realizar
			aTotais[4]  += cArqTmp->rEntr+cArqTmp->rSaid	// Realizado
			aTotais[8]  += cArqTmp->aEacm+cArqTmp->aSacm	// A Realizar Acumulado
			aTotais[10] += cArqTmp->rEacm+cArqTmp->rSacm	// Realizado Acumulado
		End
		
		dbSelectArea("cArqTmp")
		dbSkip()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Verifica se houve quebra em algum n¡vel ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lQuebra := .F.
		For nLaco := 1 to nLimite
			If aQuebras[nLaco,1] # Subst(cArqTmp->NATUR, aNiveis[nLaco,1], aNiveis[nLaco,2] )+cArqTmp->CCUSTO
				*** Inicia as quebras de baixo para cima at‚ o ponto da quebra
				For nQuebras := nLimite to nLaco Step -1
					If aQuebras[nQuebras,2] == 0 .and. aQuebras[nQuebras,3] == 0 .and. ;
							aQuebras[nQuebras,4] == 0 .and. aQuebras[nQuebras,5] == 0 .and. ;
							aQuebras[nQuebras,6] == 0 .and. aQuebras[nQuebras,7] == 0
						Loop
					Endif
					oSubTotal:Init()
					oSubtotal:Cell("HISTORICO"):SetBlock( { || STR0009+ Subst(aQuebras[nQuebras,1],aNiveis[nLaco,1], aNiveis[nLaco,2]) } )
					oSubtotal:Cell("AREALIZAR"):SetBlock( { || aQuebras[nQuebras,2] } )
					oSubtotal:Cell("REALIZADO"):SetBlock( { || aQuebras[nQuebras,3] } )
					oSubtotal:Cell("ORCADO"):SetBlock( { || aQuebras[nQuebras,4] } )
					oSubtotal:Cell("PERC"):SetBlock( { ||	If( aQuebras[nQuebras,4] # 0,;
																		Transform(((aQuebras[nQuebras,2] + aQuebras[nQuebras,3]) * 100) / aQuebras[nQuebras,4] ,"@E 9999.99") + " %" + Space(1) + ;
																		Transform(( aQuebras[nQuebras,3] * 100) / aQuebras[nQuebras,4] ,"@E 9999.99")+" %",;
																		"B/(A+B) = "+ Transform(( (aQuebras[nQuebras][2]+aQuebras[nQuebras,3]) * 100) / aQuebras[nQuebras,3],"@E 9999.99")+" %" ) } )
	
					oSubtotal:Cell("AREALIZARAC"):SetBlock( { || aQuebras[nQuebras,5] } )
					oSubtotal:Cell("REALIZADOAC"):SetBlock( { || aQuebras[nQuebras,6] } )
					oSubtotal:Cell("ORCADOAC"):SetBlock( { || aQuebras[nQuebras,7] } )
					oSubtotal:Cell("PERCAC"):SetBlock( { ||	If( aQuebras[nQuebras,7] # 0,;
																		Transform(((aQuebras[nQuebras,5] + aQuebras[nQuebras,6]) * 100) / aQuebras[nQuebras,7] ,"@E 9999.99") + " %" + Space(1) + ;
																		Transform(( aQuebras[nQuebras,6] * 100) / aQuebras[nQuebras,7] ,"@E 9999.99")+" %",;
																		"E/(D+E) = "+ Transform(( (aQuebras[nQuebras][5]+aQuebras[nQuebras,6]) * 100) / aQuebras[nQuebras,6],"@E 9999.99")+" %" ) } )
					oSubTotal:PrintLine()
					oReport:SkipLine()
					oSubTotal:Finish()
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³  Zera as quebras do n¡vel.               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aQuebras[nQuebras,2] := 0
					aQuebras[nQuebras,3] := 0
					aQuebras[nQuebras,4] := 0
					aQuebras[nQuebras,5] := 0
					aQuebras[nQuebras,6] := 0
					aQuebras[nQuebras,7] := 0
				Next
			Endif
		Next
	End
	oSection11:Finish()
End

oTotalMes:Cell("REALIZARRECEBER"):SetBlock( { || aTotais[1] } )
oTotalMes:Cell("REALIZARPAGAR"):SetBlock( { || aTotais[2] } )
oTotalMes:Cell("REALIZARSALDOS"):SetBlock( { || Transform(  DevCred( aTotais[1], aTotais[2] )[1], "@E 9,999,999,999.99" ) + DevCred( aTotais[1], aTotais[2] )[2] } )

oTotalMes:Cell("REALIZADORECEBER"):SetBlock( { ||  aTotais[3] } )
oTotalMes:Cell("REALIZADOPAGAR"):SetBlock( { || aTotais[4] } )
oTotalMes:Cell("REALIZADOSALDOS"):SetBlock( { || Transform( DevCred( aTotais[3], aTotais[4] )[1], "@E 9,999,999,999.99" ) + DevCred( aTotais[3], aTotais[4] )[2] } )

oTotalMes:Cell("TOTALRECEBER"):SetBlock( { || aTotais[1] + aTotais[3] } )
oTotalMes:Cell("TOTALPAGAR"):SetBlock( { || aTotais[2] + aTotais[4] } )
oTotalMes:Cell("TOTALSALDOS"):SetBlock( { || Transform( DevCred( aTotais[1] + aTotais[3], aTotais[2] + aTotais[4] )[1],"@E 9,999,999,999.99") + DevCred( aTotais[1] + aTotais[3], aTotais[2] + aTotais[4] )[2] } )

oTotalMes:Cell("ORCADORECEBER"):SetBlock( { || aTotais[5] } )
oTotalMes:Cell("ORCADOPAGAR"):SetBlock( { || aTotais[6] } )
oTotalMes:Cell("ORCADOSALDOS"):SetBlock( { || Transform( DevCred( aTotais[5], aTotais[6] )[1],"@E 9,999,999,999.99") + DevCred( aTotais[5], aTotais[6] )[2] } )

oCompara:Cell("REALIZADORECEBER"):SetBlock( { ||	Transform( aTotais[5] - aTotais[3],"@E 9,999,999,999.99") + " " + ;
																	Transform( ( aTotais[3] / aTotais[5] ) * 100, "@E 9999.99" ) + "%" } )
																	
oCompara:Cell("REALIZADOPAGAR"):SetBlock( { || Transform( aTotais[4] - aTotais[6],"@E 9,999,999,999.99") + " " + ;
																Transform( ( aTotais[4] / aTotais[6] ) * 100, "@E 9999.99" ) + "%"} )

oCompara:Cell("TOTALRECEBER"):SetBlock( { ||	Transform( aTotais[5] - (aTotais[1] + aTotais[3]), "@E 9,999,999,999.99" ) + " " + ; 
															Transform( ( (aTotais[1] + aTotais[3]) / aTotais[5] ) * 100, "@E 9999.99" ) + "%" } )
															
oCompara:Cell("TOTALPAGAR"):SetBlock( { ||	Transform( (aTotais[2] + aTotais[4]) - aTotais[6], "@E 9,999,999,999.99" ) + " " + ;
															Transform( ( (aTotais[2] + aTotais[4]) / aTotais[6] ) * 100, "@E 9999.99" ) + "%" } )

oAcumulado:Cell("REALIZARRECEBER"):SetBlock( { || aTotais[7] } )
oAcumulado:Cell("REALIZARPAGAR"):SetBlock( { || aTotais[8] } )
oAcumulado:Cell("REALIZARSALDOS"):SetBlock( { || Transform(  DevCred( aTotais[7], aTotais[8] )[1], "@E 9,999,999,999.99" ) + DevCred( aTotais[7], aTotais[8] )[2] } )

oAcumulado:Cell("REALIZADORECEBER"):SetBlock( { ||  aTotais[9] } )
oAcumulado:Cell("REALIZADOPAGAR"):SetBlock( { || aTotais[10] } )
oAcumulado:Cell("REALIZADOSALDOS"):SetBlock( { || Transform( DevCred( aTotais[9], aTotais[10] )[1], "@E 9,999,999,999.99" ) + DevCred( aTotais[9], aTotais[10] )[2] } )

oAcumulado:Cell("TOTALRECEBER"):SetBlock( { || aTotais[7] + aTotais[9] } )
oAcumulado:Cell("TOTALPAGAR"):SetBlock( { || aTotais[8] + aTotais[10] } )
oAcumulado:Cell("TOTALSALDOS"):SetBlock( { || Transform( DevCred( aTotais[7] + aTotais[9], aTotais[8] + aTotais[10] )[1],"@E 9,999,999,999.99") + DevCred( aTotais[7] + aTotais[9], aTotais[8] + aTotais[10] )[2] } )

oAcumulado:Cell("ORCADORECEBER"):SetBlock( { || aTotais[11] } )
oAcumulado:Cell("ORCADOPAGAR"):SetBlock( { || aTotais[12] } )
oAcumulado:Cell("ORCADOSALDOS"):SetBlock( { || Transform( DevCred( aTotais[11], aTotais[12] )[1],"@E 9,999,999,999.99") + DevCred( aTotais[11], aTotais[12] )[2] } )

oReport:PrintText( PadC( STR0010, 260, "-" ) )  //"[ TOTAIS NO MES ]"
oTotalMes:Init()
oTotalMes:PrintLine()
oTotalMes:Finish()

If ( aTotais[5] - aTotais[6] > 0 )
	oReport:PrintText( PadC( STR0021, 260, "-" ) )  // "[ COMPARATIVO - ORCADO / REAIS ]"
	oCompara:Init()
	oCompara:PrintLine()
	oCompara:Finish()
Endif

If mv_par07 == 1	
	oReport:PrintText( PadC( STR0028, 260, "-" ) )  //"[ TOTAIS ACUMULADOS ]"
	oAcumulado:Init()
	oAcumulado:PrintLine()
	oAcumulado:Finish()
Endif
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga arquivos tempor rios  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("cArqTmp")
cArqTmp->( dbCloseArea() )
Ferase(cArqTmp+GetDBExtension())
Ferase(cArqTmp+OrdBagExt())

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fr721Se5  ³ Autor ³ Claudio D. de Souza   ³ Data ³ 28/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Filtra o arquivo de Movimenta‡„o Banc ria para analisar o  ³±±
±±³          ³ Realizado.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Fr721Se5()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR721                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FR721Se5()

Local cFiltro := ""

If mv_par07 == 1
	**** Se calcula acumulado, considera desde o in¡cio do ano 
	cInicio := dTos( ctod("01/01/"+str(year(mv_par08),4),"ddmmyy") )
Else
	**** Sen„o, considera in¡cio do mes
	cInicio := dTos( FirstDay(mv_par08) )
Endif
cFim    := dTos( LastDay(mv_par08) )
cFiltro += 'E5_NATUREZ >= "' + IIf(mv_par01<mv_par03,mv_par01,mv_par03)  + '" .AND. '
cFiltro += 'E5_NATUREZ <= "' + IIf(mv_par02>mv_par04,mv_par02,mv_par04)  + '" .AND. '
If mv_par05 == 1 // Regime de caixa
	cFiltro += 'dTos(E5_DATA) >= "' + cInicio  + '" .AND. '
	cFiltro += 'dtos(E5_DATA) <= "' + cFim + '"'
Else
	cFiltro += 'dTos(E5_DTDIGIT) >= "' + cInicio  + '" .AND. '
	cFiltro += 'dtos(E5_DTDIGIT) <= "' + cFim + '"'
EndIf

Return cFiltro

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ DevCred  ³ Autor ³ Claudio D. de Souza   ³ Data ³ 28/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Subtrai valor1 de valor2. Devolve um array com um valor    ³±±
±±³          ³ positivo outro elemento com devedor ou credor              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ DevCred( nExp1, nExp2 )                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³  nExp1 = a receber nExp2 = a Pagar                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR721                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DevCred( nValor1, nValor2 )
Local aRet := {}, cDevCred
nRTotal := nValor1-nValor2
Do Case
	Case ( nRTotal < 0 )
		nRTotal := nRTotal * (-1)
		cDevCred := STR0024  //" (  Devedor   )"
	Case ( nRTotal > 0 )
		cDevCred := STR0025  //" (   Credor   )"
	OtherWise
		cDevCred := " "
EndCase
AAdd( aRet, nRTotal )
AAdd( aRet, cDevCred)
Return( aRet )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GetOrcadoCC ³ Autor ³ Claudio D. de Souza ³ Data ³ 28/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Retorna o orcamento registrado para a Natureza no Mes/Ano/CC³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GerOrcadoCc(nAno,nMes,nMoeda,cNatur,cCcusto)               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nMes   : Numero do Mes a obter o Or‡amento                 ³±±
±±³          ³ nAno   : Numero do Ano a obter o Or‡amento                 ³±±
±±³          ³ nMoeda : Numero do Moeda a obter o Or‡amento               ³±±
±±³          ³ cNatur : Codigo da natureza a obter o Or‡amento            ³±±
±±³          ³ cCCusto: Codigo do Centro de Custo a obter o Or‡amento     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR721                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GetOrcadoCC(nAno,nMes,nMoeda,cNatur,cCcusto,dDtRef)	
Local nValOrcado := 0
Local aArea	:= GetArea()
Local aAreaSEW := SEW->(GetArea())
Local nDecs := MsDecimais(mv_par06)
LOCAL bValMoeda := {|value| IF(!EMPTY(value) .AND. TYPE(value) == "N",VAL(value),1)}
LOCAL dDtConversao := dDataBase

IF !EMPTY(dDtRef) .AND. VALTYPE(dDtRef) == "D"
	dDtConversao := dDtRef
ELSEIF !EMPTY(MV_PAR08) .AND. VALTYPE(MV_PAR08) == "D"
	dDtConversao := MV_PAR08
ENDIF

DbSelectArea("SEW")
DbSetOrder(1)
SEW->(MsSeek(xFilial("SEW")+Str(nAno,4)+StrZero(nMes,2)+StrZero(nMoeda,2)+cNatur+cCcusto))
nValOrcado := Round(NoRound(xMoeda(SEW->EW_VALOR,EVAL(bValMoeda,SEW->EW_MOEDA),mv_par06,dDtConversao,nDecs+1),nDecs+1),nDecs+1)

SEW->(RestArea(aAreaSew))
RestArea(aArea)

Return nValOrcado

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fin721Cria³ Autor ³ Claudio D. de Souza   ³ Data ³ 28/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Monta arquivo temporario para apresentacao orcado x real CC³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Fin721Cria(cArqTmp,cIndex1,cIndex2,cIndex3,lRelato)        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cArqTmp - Nome do Arquivo temporario a ser criado          ³±±
±±³          ³ cIndex1 - Nome do indice temporario  Contas a Receber      ³±±
±±³          ³ cIndex2 - Nome do indice temporario  Contas a Pagar        ³±±
±±³          ³ cIndex3 - Nome do indice temporario  Movimento Bancario    ³±±
±±³          ³ lRelato - Indica se e chamado via relatorio (Default .T.)  ³±±
±±³          ³ aNivel   - Array com nivels de quebra                      ³±±
±±³          ³ aQuebras - Array de Quebras baseado MV_MASCNAT             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaFin                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fin721Cria(cArqTmp, cIndex1, cIndex2, cIndex3, lRelato, aNiveis, aQuebras, lR4)

Local aTotais		:= {0,0,0,0,0,0,0,0,0,0,0,0}	// Vetor com 12 Totalizadores
Local nMoedaBco	:= 1, aArrayQ := {}
Local aArray		:= { }, aTotal, aAcumu
Local nLaco			:= 0
Local nQuebras		:= 0
Local nLaco2		:= 0
LOCAL nTregs
LOCAL nTotAbat		:= 0
LOCAL nSaldoTit	:= 0
LOCAL lNoMes		:= .F.
Local dVencto		:= .F.
Local cTipo
Local nDecs     	:= MsDecimais(mv_par06)
Local cSituaca		:= ""
Local cFiltro		:= ""

DEFAULT lRelato := .T.
DEFAULT lR4		 := .F.

cFilterUser:= Iif(Type("aReturn[7]") == "U"," ",aReturn[7])

//Seleciona situacoes de cobrança
If MV_PAR13 == 1
	cSituaca := FinSitCob()		//Lista com as situacoes de cobranca selecionada pelo usuario
Endif
If Empty(cSituaca)
	cSituaca := FN022LstCb(0)	//Lista com todas as situacoes de cobranca	
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera arquivo de Trabalho      						  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCampos:={ 	{"NATUR"  , "C" , Len(SED->ED_CODIGO),0},;	// Cod. da Natureza
				{"CCUSTO" , "C" , Len(CTT->CTT_CUSTO),0},;	// Cod. Centro de Custo
				{"DESCR"  , "C" , 30,0},;	// Descricao da Natureza
				{"AENTR"  , "N" , 17,2},;	// A Realizar Entrada no Mes
				{"ASAID"  , "N" , 17,2},;	// A Realizar Saida no Mes
				{"RENTR"  , "N" , 17,2},;	// Realizado Entrada no Mes
				{"RSAID"  , "N" , 17,2},;	// Realizado Saida no Mes
				{"AEACM"  , "N" , 17,2},;	// A realizar Entrada ACuMulado
				{"ASACM"  , "N" , 17,2},;	// A realizar Saida   ACuMulado
				{"REACM"  , "N" , 17,2},;	// Realizado Entrada ACuMulado
				{"RSACM"  , "N" , 17,2},;	// Realizado Saida   ACuMulado
				{"TIPO"   , "C" , 01,0} }	// Tipo P ou R

If(__oFinr721 <> NIL)
	
	__oFinr721:Delete()
	__oFinr721 := NIL

EndIf

//Criando a tabela temporaria
__oFinr721 := FwTemporaryTable():New("cArqTmp")
//Setando as colunas
__oFinr721:SetFields(aCampos)
//Criando o indicie 
__oFinr721:AddIndex("1",{"CCUSTO","NATUR"})
//Criando a Tabela Temporaria
__oFinr721:Create()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona o arquivo SE1 - Contas a Receb, selecionando os registros ³
	//³ desejados. Veja a fun‡„o de filtragem.                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SE1")
	dbSetOrder(1) 
	dbGoTop()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona o arquivo SE2 - Contas a pagar, selecionando os registros ³
	//³ desejados. Veja a fun‡„o de filtragem.                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SE2")
	dbSetOrder(1) // Ordem por natureza
	dbGoTop()


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Varre o arquivo de naturezas localizando os titulos selecionados  ³
	//³ pelo ¡ndice condicional.                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SED")
	dbSetOrder(1)

	nTregs := 	SED->(Reccount()) + SE1->(Reccount()) + SE2->(Reccount()) + ;
					SE5->(Reccount())

   If lRelato .And. !lR4
		SetRegua(nTregs)
	Else
		ProcRegua(nTregs)
	Endif

	DbSelectArea("CTT")
	DbSetOrder(1)
	MsSeek(xFilial("CTT")+mv_par11,.T.)	
	// Processa todos os centros de custo
	While CTT->(!Eof()) .And.;
			CTT->CTT_CUSTO <= mv_par12
		
		If !Empty(mv_par01) .or. !Empty(mv_par03)
			SED->(MsSeek( xFilial("SED") + Iif(mv_par01 < mv_par03,mv_par01,mv_par03) ,.t. ))
		Else
			SED->(MsSeek(xFilial("SED")))
		Endif
		
		// Processa todas as naturezas do intervalo
		While SED->(!Eof()) .And.;
				SED->ED_FILIAL==xFilial("SED") .And.;
				SED->ED_CODIGO <= IIf(mv_par02 > mv_par04,mv_par02,mv_par04)
	
	    	If lRelato .And. !lR4
				IncRegua()
			Else
				IncProc()
			Endif
			
			IF SED->ED_CODIGO >= mv_par01 .and. SED->ED_CODIGO <= mv_par02
				cTIPO := "R"
			ElseIF SED->ED_CODIGO >= mv_par03 .and. SED->ED_CODIGO <= mv_par04
				cTIPO := "P"
			Else
				dbSelectArea("SED")
				dbSkip()
				Loop
			Endif
			
			dbSelectArea( "cArqTmp" )
			If !cArqTmp->(dbSeek(CTT->CTT_CUSTO+SED->ED_CODIGO))
				RecLock("cArqTmp",.T.)
				cArqTmp->NATUR := SED->ED_CODIGO
				cArqTmp->CCUSTO:= CTT->CTT_CUSTO
				cArqTmp->DESCR := SED->ED_DESCRIC
				cArqTmp->TIPO  := cTipo
			Else
				RecLock("cArqTmp",.F.)
			Endif	
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Analiza as entradas daquela natureza ³
			//³ A Realizar !!!                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SEZ")
			dbSetOrder(2)
			SEZ->(MsSeek(xFilial("SEZ")+"1"+SED->ED_CODIGO+CTT->CTT_CUSTO))
			If SED->ED_CODIGO >= mv_par01 .and. SED->ED_CODIGO <= mv_par02
				While SEZ->(!Eof()) .And.;
						SEZ->EZ_FILIAL==xFilial("SEZ") .And.;
						SEZ->EZ_NATUREZ==SED->ED_CODIGO .And.;
						SEZ->EZ_CCUSTO ==CTT->CTT_CUSTO .And.;
						SEZ->EZ_IDENT  == "1"           .And.; // Inclusao do titulo no SEZ
						cArqTmp->TIPO == "R"
				
			    	// Localiza o titulo
			    	If SE1->(MsSeek(xFilial("SE1")+SEZ->(EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO)))
			    	
				    	If lRelato .And. !lR4
							IncRegua()
						Else
							IncProc()
						Endif
					
						// T¡tulos de abatimento e antecipados ficam de fora
						If SE1->E1_TIPO $ MVABATIM+"/"+MVRECANT+"/"+MV_CRNEG
							SEZ->(dbSkip())
							Loop
						Endif
						
						If ! SE1->E1_SITUACA $ cSituaca		//mv_par13
							SEZ->(dbSkip())
							Loop
						Endif	
		
						// Titulos provisoris, verifica parametro
						If SE1->E1_TIPO $ MVPROVIS .and. mv_par10 == 2
							SEZ->(dbSkip())
							Loop
						Endif
				
						If mv_par09 == 2
							If SE1->E1_MOEDA <> mv_par06
								SEZ->(DbSkip())
								Loop
							EndIf
						EndIf    
					
						nSaldoTit := Round(NoRound(xMoeda(SEZ->EZ_VALOR,SE1->E1_MOEDA,mv_par06,mv_par08,nDecs+1),nDecs+1),nDecs+1)
						// Soma Abatimentos do Titulo
						nTotAbat  := SomaAbat(SEZ->EZ_PREFIXO,SEZ->EZ_NUM,SEZ->EZ_PARCELA,"R",1)
						nSaldoTit -= nTotAbat
					
						lNoMes:= (SE1->E1_VENCREA >= FirstDay(mv_par08)) .and. ;
									(SE1->E1_VENCREA <= LastDay(mv_par08))
		
						cArqTmp->aEacm += nSaldoTit	// Atualiza acumulado a realizar
						IF lNoMes
							cArqTmp->aEntr += nSaldoTit	// Atualiza a Realizar no mes
						Endif
					EndIf
					dbSelectArea("SEZ")
					dbSkip()
				End
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Analiza as Saidas daquela natureza ³
			//³ A Realizar !!!                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			ElseIf SED->ED_CODIGO >= mv_par03 .and. SED->ED_CODIGO <= mv_par04
				While SEZ->(!Eof()) .And.;
						SEZ->EZ_FILIAL==xFilial("SEZ") .And.;
						SEZ->EZ_NATUREZ==SED->ED_CODIGO .And.;
						SEZ->EZ_CCUSTO ==CTT->CTT_CUSTO .And.;
						SEZ->EZ_IDENT  == "1"           .And.; // Inclusao do titulo no SEZ
						cArqTmp->TIPO == "P"
	
					// Localiza o titulo
			    	If SE2->(MsSeek(xFilial("SE2")+SEZ->(EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA)))
			    	
					   If lRelato .And. !lR4
							IncRegua()
						Else
							IncProc()
						Endif
					
						// T¡tulos de abatimento e adiantamento ficam de fora
						If SE2->E2_TIPO $ MVABATIM+"/"+MVPAGANT+"/"+MV_CPNEG
							SEZ->(dbSkip())
							Loop
						Endif
						// Titulos provisoris, verifica paramentro
						If SE2->E2_TIPO $ MVPROVIS .and. mv_par10 == 2
							SEZ->(dbSkip())
							Loop
						Endif
		                      		        
						If mv_par09 == 2
							If SE2->E2_MOEDA <> mv_par06
								SEZ->(DbSkip())
								Loop
							EndIf
						EndIf    
		                		
						nSaldoTit := Round(NoRound(xMoeda(SEZ->EZ_VALOR,SE2->E2_MOEDA,mv_par06,mv_par08,nDecs+1),nDecs+1),nDecs+1)
						
						// Soma abatimentos do titulo
						nTotAbat  := SomaAbat(SEZ->EZ_PREFIXO,SEZ->EZ_NUM,SEZ->EZ_PARCELA,"P",1,mv_par08,SEZ->EZ_CLIFOR)
						nSaldoTit -= nTotAbat
					
						lNoMes:= (SE2->E2_VENCREA >= FirstDay(mv_par08)) .and. ;
									(SE2->E2_VENCREA <= LastDay(mv_par08))
		
						cArqTmp->aSacm += nSaldoTit	// Atualiza acumulado a realizar
						IF lNoMes
							cArqTmp->aSaid += nSaldoTit	// Atualiza a Realizar no mes
						Endif
					Endif	
					dbSelectArea("SEZ")
					dbSkip()
				End
			Endif
			dbSelectArea("SED")
			dbSkip()
		End
	 	DbSelectArea("CTT")
	 	DbSkip()
   End
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Restaura os arquivos de contas a receber / pagar para auxiliar ³
	//³ an lise do se5 caso seja escolhido regime de caixa             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RetIndex("SE1")
	Set Filter To
	RetIndex("SE2")
	Set Filter To

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Analisa Realizado no Mˆs em Ep¡grafe ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo SEZ - Movimenta‡„o banc ria, para verificar     ³
//³ o realizado.                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE5")
dbSetOrder(4) // Ordem por natureza
cFiltro	:= U_FR721Se5()
dbSelectArea("SE5")
If TcSrvType() != "AS/400"
	nTregs:= SE5->(Reccount())
	If lRelato .And. !lR4
		SetRegua(nTregs)
	Else
		ProcRegua(nTregs)
	Endif
Endif

dbGoTop()

aTotais[1] := 0	// Total a Realizar no MEs (Receber)
aTotais[2] := 0	// Total a Realizar no Mes (Pagar)

aTotais[3] := 0	// Total Realizado no Mes (Receber)
aTotais[4] := 0	// Total Realizado no Mes (Pagar)

aTotais[5] := 0	// Total Or‡ado no Mes (Receber)
aTotais[6] := 0	// Total Or‡ado no Mes (Pagar)

aTotais[7] := 0	// Total a Realizar Acumulado (Receber)
aTotais[8] := 0	// Total a Realizar Acumulado (Receber)

aTotais[9] := 0	// Total Realizado Acumulado (Receber)
aTotais[10] := 0	// Total Realizado Acumulado (Pagar)

aTotais[11] := 0	// Total Or‡ado Acumulado (Receber)
aTotais[12] := 0	// Total Or‡ado Acumulado (Pagar)
SEZ->(DbSetOrder(3))

While SE5->(!Eof()) .and. SE5->E5_FILIAL==xFilial("SE5") .And. &cFiltro

   If lRelato  .And. !lR4
		IncRegua()
	Else
		IncProc()
	Endif
	
	If cPaisLoc	# "BRA"
	   SA6->(DbSetOrder(1))
	   SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
	   nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe estorno para esta baixa                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TemBxCanc(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ))
		SE5->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta‡”es especiais ou canceladas n„o aparecem no relat¢rio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF SE5->E5_TIPODOC $ "DCüJRüMTüCM/D2/J2/M2/C2/TL/CP/BL" .or. SE5->E5_SITUACA $ "C/X/E"
		SE5->(dbSkip())
		Loop
	EndIF

	If SE5->E5_TIPODOC == "CH"
		dbSelectArea("SEF")
		dbSetOrder(1)
		If dbSeek(xFilial("SEF")+SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ))
			If SEF->EF_ORIGEM != "FINA390AVU"
			   dbSelectArea("SE5")
				SE5->(dbSkip())
				Loop
			Endif
		Endif
	Endif
	
	If !Empty(SE5->E5_MOTBX)
		If !MovBcoBx(SE5->E5_MOTBX)
			SE5->(dbSkip())
			LOOP
		EndIf
	End

   If mv_par09 == 2
      If nMoedaBco <> mv_par06
         SE5->(DbSkip())
         Loop
      EndIf
   EndIf    

	lNoMes :=.T.			
	dVencto:=SE5->E5_DATA // Regime de Caixa

	lRet := .T.
	If mv_par05 == 2 
		If !Empty(SE5->E5_NUMERO) // Regime de competˆncia
			If SE5->E5_RECPAG == "R"
				If SE1->(dbSeek(xFilial("SE1")+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO))
					dVencto:=SE1->E1_EMIS1
					If SE1->E1_EMIS1 < if(mv_par07==2,FirstDay(dDataBase),ctod("01/01/"+str(year(dDataBase),4))) .OR. ;
						SE1->E1_EMIS1 > LastDay(dDatabase)
						lRet := .F.
					Endif
				Endif
			Else
				If SE2->(dbSeek(xFilial("SE2")+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR))
					dVencto:=SE2->E2_EMIS1
					If SE2->E2_EMIS1 < if(mv_par07==2,FirstDay(dDataBase),ctod("01/01/"+str(year(dDataBase),4))) .OR. ;
						SE2->E2_EMIS1 > LastDay(dDatabase)
						lRet := .F.
					Endif
				Endif
			Endif
		Else	
			lRet := .F.
		Endif	
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Checa se Movimento est  dentro do mes          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lNoMes:= (dVencto >= FirstDay(mv_par08)) .and. ;
				(dVencto <= LastDay(mv_par08))
	If lRet
		If SE5->E5_MULTNAT == "1" .And.;
			((SE5->E5_NATUREZ >= mv_par01 .And. SE5->E5_NATUREZ <= mv_par02) .Or.;
			 (SE5->E5_NATUREZ >= mv_par03 .And. SE5->E5_NATUREZ <= mv_par04)) .And.;
			SEZ->(MsSeek(xFilial("SEZ")+"2"+SE5->(E5_SEQ+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)))
			// Para todos os centros de custo da natureza, processa o rateio da baixa 
			While SEZ->(!Eof()) .And.;
					SEZ->(EZ_FILIAL+EZ_IDENT+EZ_SEQ+EZ_PREFIXO+EZ_NUM+EZ_PARCELA+EZ_TIPO+EZ_CLIFOR+EZ_LOJA) == ;
					xFilial("SEZ")+"2"+SE5->(E5_SEQ+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)
                If  SEZ->EZ_CCUSTO >= mv_par11 .And. SEZ->EZ_CCUSTO <= mv_par12 
				If !cArqTmp->(dbSeek(SEZ->EZ_CCUSTO+SE5->E5_NATUREZ))
					RecLock("cArqTmp",.T.)
					cArqTmp->NATUR		:= SE5->E5_NATUREZ
					cArqTmp->CCUSTO	:= SEZ->EZ_CCUSTO
					cArqTmp->DESCR		:= SED->ED_DESCRIC
				Else
					RecLock("cArqTmp")
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atualiza Realizados no MES                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IF lNoMes
					If cArqTmp->NATUR >= mv_par01 .and. cArqTmp->NATUR	<= mv_par02
						cArqTmp->rEntr += Round(NoRound(xMoeda(SEZ->EZ_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Else
						cArqTmp->rSaid += Round(NoRound(xMoeda(SEZ->EZ_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Endif			
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atualiza Realizados Acumulados                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				if mv_par07 == 1
					If cArqTmp->NATUR >= mv_par01 .and. cArqTmp->NATUR	<= mv_par02
						cArqTmp->REACM += Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Else
						cArqTmp->RSACM += Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par06,SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
					Endif			
				Endif
				cArqTmp-> Tipo := SE5->E5_RECPAG
				EndIf
				SEZ->(DbSkip())	
			End
		Endif
	Endif
	dbSelectArea("SE5")
	dbSkip()
End

If ! lRelato
	cArqTmp->( DbGoTop() )
	If aNiveis <> Nil
		nLimite := IIf(Len(aNiveis) > 1, Len(aNiveis)-1, 1)
	Endif
Endif

While ! lRelato .And. !cArqTmp->( Eof() )
	
	nOrcado := 0
	nOrcAcm := 0
	
	nOrcado:=U_GetOrcadoCC(Year(mv_par08),Month(mv_par08),MV_PAR06,cArqTmp->NATUR,cArqTmp->CCUSTO)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Acumula or‡ados no Mes                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( cArqTmp-> Tipo == "R")
		aTotais[5] += nOrcado		// Acumula or‡ado no Mes (Receber)
	Else
		aTotais[6] += nOrcado		// Acumula or‡ado no Mes (Pagar)
	End
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Se calcula acumulados, Acumula or‡ados no Ano  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 1
		For nLaco2:=1 to month(mv_par08)
			nOrcAcm += U_GetOrcadoCC(Year(mv_par08),nLaco2,MV_PAR06,cArqTmp->NATUR,cArqTmp->CCUSTO)
		Next
		If ( cArqTmp-> Tipo == "R")
			aTotais[11] += nOrcAcm	// Acumula or‡ado no Ano (Receber)
		Else
			aTotais[12] += nOrcAcm	// Acumula or‡ado no Acno (Pagar)
		End
	Endif
	
	If ( cArqTmp-> Tipo == "R" )	
		*** Atualiza Totais RECEBER
		aTotais[1]  += cArqTmp->aEntr+cArqTmp->aSaid	// A Realizar
		aTotais[3]  += cArqTmp->rEntr+cArqTmp->rSaid	// Realizado
		aTotais[7]  += cArqTmp->aEacm+cArqTmp->aSacm	// A Realizar Acumulado
		aTotais[9]  += cArqTmp->rEacm+cArqTmp->rSacm	// Realizado Acumulado
	Else	
		*** Atualiza Totais PAGAR
		aTotais[2]  += cArqTmp->aEntr+cArqTmp->aSaid	// A Realizar
		aTotais[4]  += cArqTmp->rEntr+cArqTmp->rSaid	// Realizado
		aTotais[8]  += cArqTmp->aEacm+cArqTmp->aSacm	// A Realizar Acumulado
		aTotais[10] += cArqTmp->rEacm+cArqTmp->rSacm	// Realizado Acumulado
	End

	If aQuebras <> Nil
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Inicia a matriz acumuladora de quebras  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nLaco := 1 to Len( aQuebras )
			aQuebras[nLaco,1] := Subst( cArqTmp->Natur,aNiveis[nLaco,1],aNiveis[nLaco,2] )+cArqTmp->CCusto
		Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Acumula os parciais  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nLaco := 1 to Len(aQuebras)
			****** Parciais no Mes
			aQuebras[nLaco,2] += cArqTmp->aEntr+cArqTmp->aSaid
			aQuebras[nLaco,3] += cArqTmp->rEntr+cArqTmp->rSaid
			aQuebras[nLaco,4] += nOrcado
			****** Parciais Acumulados
			If mv_par07 == 1
				aQuebras[nLaco,5] += cArqTmp->AEACM+cArqTmp->ASACM
				aQuebras[nLaco,6] += cArqTmp->REACM+cArqTmp->RSACM
				aQuebras[nLaco,7] += nOrcAcm
			Endif
		Next
	
	Endif
	
	cArqTmp->(DbSkip())

	If aQuebras <> Nil
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Verifica se houve quebra em algum n¡vel ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lQuebra := .F.
		For nLaco := 1 to nLimite
			If aQuebras[nLaco,1] # Subst( cArqTmp->NATUR, aNiveis[nLaco,1], aNiveis[nLaco,2] )+cArqTmp->CCusto
				*** Inicia as quebras de baixo para cima at‚ o ponto da quebra
				For nQuebras := nLimite to nLaco Step -1
					If aQuebras[nQuebras,2] == 0 .and. aQuebras[nQuebras,3] == 0 .and. ;
						aQuebras[nQuebras,4] == 0 .and. aQuebras[nQuebras,5] == 0 .and. ;
						aQuebras[nQuebras,6] == 0 .and. aQuebras[nQuebras,7] == 0
						Loop
					Endif
					
					Aadd(aArrayQ, Aclone(aQuebras[nQuebras]))
					aArrayQ[Len(aArrayQ)][1] := STR0009+ aQuebras[nQuebras,1]

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³  Zera as quebras do n¡vel.               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aQuebras[nQuebras,2] := 0
					aQuebras[nQuebras,3] := 0
					aQuebras[nQuebras,4] := 0
					aQuebras[nQuebras,5] := 0
					aQuebras[nQuebras,6] := 0
					aQuebras[nQuebras,7] := 0
				Next
			Endif
		Next
	Endif		
End

If ! lRelato
	If mv_par07 = 1
		Aadd(aArray, { STR0011, STR0031, STR0032, STR0012, STR0031, STR0032, STR0013, STR0031, STR0032 }) //"Mes"###"Acumulado"###"Mes"###"Acumulado"###"Mes"###"Acumulado"
	Else
		Aadd(aArray, { STR0011, "", STR0012, "", STR0013, "" })
	Endif

	aTotal := DevCred( aTotais[1], aTotais[2] )
	aAcumu := DevCred( aTotais[7], aTotais[8] )

	If mv_par07 = 1
		Aadd(aArray, { 	StrTran(STR0014, ":", ""), Transform( aTotais[1], "@E 9,999,999,999.99" ),;	//"A Realizar  : "
						Transform( aTotais[7], "@E 9,999,999,999.99" ),;
						StrTran(STR0014, ":", ""), Transform( aTotais[2], "@E 9,999,999,999.99" ),;	//"A Realizar  : "
						Transform( aTotais[8], "@E 9,999,999,999.99" ),;
						StrTran(STR0014, ":", ""), Transform( aTotal[1], "@E 9,999,999,999.99" ) + ; //"A Realizar  : "
						aTotal[2],;
						Transform( aAcumu[1], "@E 9,999,999,999.99" ) + aAcumu[2] })
	Else
		Aadd(aArray, { 	StrTran(STR0014, ":", ""), Transform( aTotais[1], "@E 9,999,999,999.99" ),;	//"A Realizar  : "
						StrTran(STR0014, ":", ""), Transform( aTotais[2], "@E 9,999,999,999.99" ),;	//"A Realizar  : "
						StrTran(STR0014, ":", ""), Transform( aTotal[1] , "@E 9,999,999,999.99" ) +; 	//"A Realizar  : "
						aTotal[2] }) 
	Endif
	    	
	aTotal := DevCred( aTotais[3], aTotais[4] )
	aAcumu := DevCred( aTotais[9], aTotais[10] )
    	
	If mv_par07 = 1
		Aadd(aArray, { 	StrTran(STR0015, ":", ""),  Transform( aTotais[3], "@E 9,999,999,999.99" ),;	//"Realizado   : "
						Transform( aTotais[9], "@E 9,999,999,999.99" ),;
						StrTran(STR0015, ":", ""),  Transform( aTotais[4], "@E 9,999,999,999.99" ),; //"Realizado   : "
						Transform( aTotais[10], "@E 9,999,999,999.99" ),;
						StrTran(STR0015, ":", ""),  Transform( aTotal[1], "@E 9,999,999,999.99" ) +;//"Realizado   : "
						aTotal[2], Transform( aAcumu[1], "@E 9,999,999,999.99" ) +;
						aAcumu[2] })
    Else
		Aadd(aArray, { 	StrTran(STR0015, ":", ""),  Transform( aTotais[3], "@E 9,999,999,999.99" ),;	//"Realizado   : "
						StrTran(STR0015, ":", ""),  Transform( aTotais[4], "@E 9,999,999,999.99" ),; //"Realizado   : "
						StrTran(STR0015, ":", ""),  Transform( aTotal[1], "@E 9,999,999,999.99" ) +;//"Realizado   : "
						aTotal[2] })
	Endif
	
	nTotReceb := aTotais[1] + aTotais[3]
	nTotPagar := aTotais[2] + aTotais[4]

	nAcuReceb := aTotais[7] + aTotais[9]
	nAcuPagar := aTotais[8] + aTotais[10]

	aTotal := DevCred( nTotReceb, nTotPagar )
	aAcumu := DevCred( nAcuReceb, nAcuPagar )
	
	If mv_par07 = 1
		Aadd(aArray, { 	StrTran(STR0016, ":", ""),  Transform( nTotReceb, "@E 9,999,999,999.99" ),;	//"Total       : "
						Transform( nAcuReceb, "@E 9,999,999,999.99" ),;
						StrTran(STR0016, ":", ""),  Transform( nTotPagar, "@E 9,999,999,999.99" ),;	//"Total       : "
						Transform( nAcuPagar, "@E 9,999,999,999.99" ),;
						StrTran(STR0016, ":", ""),  Transform( aTotal[1],"@E 9,999,999,999.99") +;	//"Total       : "
						aTotal[2], Transform( aAcumu[1],"@E 9,999,999,999.99") +; 
						aAcumu[2] } )
	Else
		Aadd(aArray, { 	StrTran(STR0016, ":", ""),  Transform( nTotReceb, "@E 9,999,999,999.99" ),;	//"Total       : "
						StrTran(STR0016, ":", ""),  Transform( nTotPagar, "@E 9,999,999,999.99" ),;	//"Total       : "
						StrTran(STR0016, ":", ""),  Transform( aTotal[1],"@E 9,999,999,999.99")+;	//"Total       : "
						aTotal[2] })
	Endif
	
	aTotal := DevCred( aTotais[5], aTotais[6] )
	aAcumu := DevCred( aTotais[11], aTotais[12] )
	If mv_par07 = 1
		Aadd(aArray, { 	StrTran(STR0029, ":", ""),  Transform( aTotais[5], "@E 9,999,999,999.99"),;	//"Orcado      : "
						Transform( aTotais[11], "@E 9,999,999,999.99"),;
						StrTran(STR0029, ":", ""),  Transform( aTotais[6], "@E 9,999,999,999.99"),; 	//"Orcado      : "
						Transform( aTotais[12], "@E 9,999,999,999.99"),;
						StrTran(STR0029, ":", ""),  Transform( aTotal[1],"@E 9,999,999,999.99") +;  	//"Orcado      : "
						aTotal[2], Transform( aAcumu[1],"@E 9,999,999,999.99") +;
						aAcumu[2] })
	Else
		Aadd(aArray, { 	StrTran(STR0029, ":", ""),  Transform( aTotais[5], "@E 9,999,999,999.99"),;	//"Orcado      : "
						StrTran(STR0029, ":", ""),  Transform( aTotais[6], "@E 9,999,999,999.99"),; 	//"Orcado      : "
						StrTran(STR0029, ":", ""),  Transform( aTotal[1],"@E 9,999,999,999.99")+;  	//"Orcado      : "
						aTotal[2] })
	Endif
Endif
	
Return { aTotais, aArrayQ, aArray }
