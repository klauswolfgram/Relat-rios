/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "SIGAWIN.CH"
#include "FINR089.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFUNCAO    ³FINR089   ºAutor ³B.Sobieski/M.Hernadezº Data ³  02/16/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impresion de los cheques emitidos aun no ingresados en la   º±±
±±º          ³Movimentacion bancaria de siga (no depositados).            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR089()

	Local oReport := Nil
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport	:= ReportDef()
	oReport:PrintDialog()

	DbSelectArea("SE2")
	Set Filter To

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef  ºAutor  ³Paulo Augusto       º Data ³  11/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Definicao do relatorio       		                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

	Local oReport	:= Nil
	Local oSection1	:= Nil
	Local cReport	:= "FINR089"
	Local cTitulo	:= OemToAnsi(STR0001) //"Listado de Cheques Pendientes de Pago"
	Local cDescri	:= OemToAnsi(STR0002)+OemToAnsi(STR0003) //"Este programa emite un informe de los cheq." - "pendientes de depos."
	Local aMes		:= {OemToAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013),; //"ENERO" - "FEBRERO" - "MARZO"
						OemToAnsi(STR0014),OemToAnsi(STR0015),OemToAnsi(STR0016),; //"ABRIL" - "MAYO" - "JUNIO"
						OemToAnsi(STR0017),OemToAnsi(STR0018),OemToAnsi(STR0019),; //"JULIO" - "AGOSTO" - "SEPTIEMB"
						OemToAnsi(STR0020),OemToAnsi(STR0021),OemToAnsi(STR0022)} //"OCTUBRE" - "NOVIEMBR" - "DICIEMBR"

	Pergunte( "FIR089" , .F. )

	oReport  := TReport():New( cReport, cTitulo, "FIR089" , { |oReport| ReportPrint( oReport  ) }, cDescri )

	oSection1 := TRSection():New( oReport,OemToAnsi(STR0043) , {"SE2"},{OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009),OemToAnsi(STR0010)},/*Campos do SX3*/,/*Campos do SIX*/) //"Titul. p/ Pagar" - "Vencim." - "Proveedor" - "Orden de Pago" - "Numero de Cheque" - "Emision" 
	oSection1:SetTotalInLine(.T.)
	oReport:SetTotalInLine(.F.)


	TRCell():New( oSection1, "E2_FORNECE" 	,"SE2",/*X3Titulo*/    	,/*Picture*/,TAMSX3("E2_FORNECE" )[1] +TAMSX3("E2_LOJA" )[1],/*lPixel*/,{||SE2->E2_FORNECE+SE2->E2_LOJA})
	TRCell():New( oSection1, "A2_NOME" 		,"SA2",/*X3Titulo*/  	,/*Picture*/,20,/*lPixel*/,{||FIR089DFOR(SE2->E2_FORNECE,SE2->E2_LOJA)})
	TRCell():New( oSection1, "E2_NUM" 		,"SE2",/*X3Titulo*/  	,/*Picture*/,TamSx3("E2_ORDPAGO" )[1] + 2 + TamSx3("E2_NUM")[1]/*Tamanho*/,/*lPixel*/,{|| Iif(!Empty(SE2->E2_ORDPAGO),SE2->E2_ORDPAGO+"/"+ SE2->E2_NUM,SE2->E2_NUM)})
	TRCell():New( oSection1, "E2_EMISSAO" 	,"SE2",/*X3Titulo()*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||SE2->E2_EMISSAO })
	TRCell():New( oSection1, "MES" 			,"   ",OemToAnsi(STR0042),/*Picture*/,20			,/*lPixel*/,{||aMes[Month(SE2->E2_VENCTO)] }) //"Mes"
	TRCell():New( oSection1, "E2_VENCTO"  	,"SE2",/*X3Titulo()*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf(SE2->E2_VENCTO<dDataBase,OemToAnsi(STR0031),OemToAnsi(STR0032))}) //"Vencido" - "En Fch"
	TRCell():New( oSection1, "E2_VENCREA"	,"SE2",/*X3Titulo()*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||SE2->E2_VENCTO  })
	TRCell():New( oSection1, "E2_VALOR" 	,"SE2",/*X3Titulo()*/	,/*Picture*/,20			,/*lPixel*/,{||Iif(SE2->E2_MOEDA <> MV_PAR07,xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,MV_PAR07),SE2->E2_VALOR) })
	TRCell():New( oSection1, "E2_BCOCHQ" 	,"   ",/*X3Titulo()*/	,/*Picture*/,TamSX3("E2_BCOCHQ")[1]+ 2 +TamSX3("E2_AGECHQ")[1]+ 2 +TamSx3("E2_CTACHQ")[1]/*Tamanho*/,/*lPixel*/,{||Fa089BCO()})
	TRCell():New( oSection1, "E2_MOEDA" 	,"SE2",/*X3Titulo()*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||SE2->E2_MOEDA})
	oSection1:SetNofilter({"SE2"})

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Augusto       º Data ³  27/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao do relatorio    		                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )

	Local oSection1	:= oReport:Section(1)
	Local oBreak1	:= Nil
	Local nOrdem	:= oReport:Section(1):GetOrder()

	DbSelectArea("SA2")
	DbSetOrder(1) //A2_FILIAL+A2_COD+A2_LOJA

	DbSelectArea("SA6")
	DbSetOrder(1) //A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON 

	DbSelectArea("SEK")
	DbSetOrder(1) //EK_FILIAL+EK_ORDPAGO+EK_TIPODOC+EK_PREFIXO+EK_NUM+EK_PARCELA+EK_TIPO+EK_SEQ

	DbSelectArea("SE2")

	cCond := "E2_EMISSAO>=MV_PAR03.AND.E2_EMISSAO<=MV_PAR04.AND.E2_FORNECE>=MV_PAR01.AND.E2_FORNECE<=MV_PAR02.AND.E2_FILIAL==xFILIAL('SE2').AND.Alltrim(E2_TIPO)$'CH|TF|" +GetSESTipos({|| alltrim(ES_TIPORIG) $ "CH|TF|"})+" '.AND.E2_SALDO>0"

	cCond	:=	cCond	+	".And.E2_VENCTO>=MV_PAR05.AND.E2_VENCTO<=MV_PAR06"

	If MV_PAR08 == 2
		cCond	:=	cCond	+ ".AND.E2_MOEDA=MV_PAR07"//Carrega a variavel com o tipo
	EndIf                                             //moeda que foi escolhida nas perguntas.
	Do Case
		Case nOrdem==1
		cCHAVE := "DTOS(E2_VENCTO)+E2_FORNECE+E2_LOJA+E2_PREFIXO+E2_NUM+E2_PARCELA"
		Case nOrdem==2
		cCHAVE := "E2_FORNECE+E2_LOJA+DTOS(E2_VENCTO)+E2_PREFIXO+E2_NUM+E2_PARCELA"
		Case nOrdem==3
		cCHAVE := "E2_ORDPAGO+DTOS(E2_VENCTO)+E2_NUM+E2_PARCELA"
		Case nOrdem==4
		cCHAVE := "E2_PREFIXO+E2_NUM+E2_PARCELA+E2_FORNECE+E2_LOJA"
		Case nOrdem==5
		cCHAVE := "DTOS(E2_EMISSAO)+E2_FORNECE+E2_LOJA+E2_PREFIXO+E2_NUM+E2_PARCELA"
	EndCase

	oSection1:SetFilter(cCond,cCHAVE)

	DbGotop()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Llena el archivo temporario con los datos pedidos           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄDiegoÄÄÄÄÄÄÙ
	If nOrdem==1
		oBreak1 := TRBreak():New( oSection1,oSection1:Cell("MES"),,.T.)
	ElseIf nOrdem==2
		oBreak1 := TRBreak():New( oSection1,oSection1:Cell("E2_FORNECE"), OemToAnsi(STR0030) ,.T.) //"Total a entrar del proveedor  "
	EndIf

	TRFunction():New(oSection1:Cell("E2_VALOR")	,, "SUM" , oBreak1,OemToAnsi(STR0044), , ,.f.  , ) //"Total del mes"
	oReport:SetTitle(OemToAnsi(STR0001)+" ( "+ GetMV("MV_MOEDAP"+STR(MV_PAR07,1) )+" ) " ) //"Listado de Cheques Pendientes de Pago"

	oSection1:Print()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Fa089BCO   ºAutor  ³Paulo Augusto       º Data ³  11/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Pesquisa Banco            		                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fa089BCO()

	Local cBanco	:= ""
	Local aArea		:= GetArea()

	dbSelectArea("SEK")
	DbSetOrder(1) //EK_FILIAL+EK_ORDPAGO+EK_TIPODOC+EK_PREFIXO+EK_NUM+EK_PARCELA+EK_TIPO+EK_SEQ
	DbSeek(xFILIAL("SEK")+SE2->E2_ORDPAGO+"CH"+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA)

	If Found().AND. SEK->EK_TIPO $ "TF~CH"
		cBANCO := SUBS(TABELA("95",SEK->EK_BANCO,.F.),1,20)
		cBanco := If(Empty(cBanco),If(Empty(SEK->EK_OBSBCO),SEK->EK_BANCO+"/" +SEK->EK_AGENCIA+"/"+Right(Alltrim(SEK->EK_CONTA),10),SEK->EK_OBSBCO),cBanco)
	Else
		cBANCO := SUBS(TABELA("95",SE2->E2_BCOCHQ,.F.),1,20)
		cBanco := If(Empty(cBanco),SE2->E2_BCOCHQ+"/" +SE2->E2_AGECHQ+"/"+Right(Alltrim(SE2->E2_CTACHQ),10),cBanco)
	Endif
	RestArea(aArea)

Return (cBanco)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FIR089DFOR ºAutor  ³Paulo Augusto       º Data ³  11/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Busca nombre del Proveedor                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FIR089DFOR(cfornec,cloja)
	
	Local cDescr	:= ""
	Local aArea		:= GetArea()

	DbSelectArea("SA2")
	DbSetOrder(1) //A2_FILIAL+A2_COD+A2_LOJA
	DbSeek(xFilial("SA2") + cfornec + cloja)
	cDescr := SUBS(SA2->A2_NOME,1,20)
	RestArea(aArea)
	
Return (cDescr)
