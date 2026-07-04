/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PMSR370.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ PMSR360  ³ Autor ³ Daniel Tadashi Batori     ³ Data ³ 30.01.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Analitico do Fluxo de Caixa                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_PMSR370(void)                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³cPeriodo : periodo a ser detalhado                              ³±±
±±³          ³aCol1 := array com os registros de Pedidos de Compra            ³±±
±±³          ³aCol2 : array com os registros de Documentos de Entrada         ³±±
±±³          ³aCol3 : array com os registros de Títulos a Pagar               ³±±
±±³          ³aCol4 : array com os registros de Mov.Bancaria a Pagar          ³±±
±±³          ³aCol5 : array com os registros de Pedidos de Venda              ³±±
±±³          ³aCol6 : array com os registros de Notas Fiscais                 ³±±
±±³          ³aCol7 : array com os registros de Títulos a Receber             ³±±
±±³          ³aCol8 : array com os registros de Mov.Bancaria a Receber        ³±±
±±³          ³sHeadTReport : string a ser utilizada no header do TReport      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PMSR370(cPeriodo,aCol1,aCol2,aCol3,aCol4,aCol5,aCol6,aCol7,aCol8,sHeadTReport)
Local oReport

oReport := ReportDef(cPeriodo,aCol1,aCol2,aCol3,aCol4,aCol5,aCol6,aCol7,aCol8,sHeadTReport)
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 30/01/2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do layout do Relatorio									    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³cPeriodo : periodo a ser detalhado                            ³±±
±±³          ³aCol1 := array com os registros de Pedidos de Compra          ³±±
±±³          ³aCol2 : array com os registros de Documentos de Entrada       ³±±
±±³          ³aCol3 : array com os registros de Títulos a Pagar             ³±±
±±³          ³aCol4 : array com os registros de Mov.Bancaria a Pagar        ³±±
±±³          ³aCol5 : array com os registros de Pedidos de Venda            ³±±
±±³          ³aCol6 : array com os registros de Notas Fiscais               ³±±
±±³          ³aCol7 : array com os registros de Títulos a Receber           ³±±
±±³          ³aCol8 : array com os registros de Mov.Bancaria a Receber      ³±±
±±³          ³sHeadTReport : string a ser utilizada no header do TReport    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(cPeriodo,aCol1,aCol2,aCol3,aCol4,aCol5,aCol6,aCol7,aCol8,sHeadTReport)
Local oReport  
Local oSec1,oSec2,oSec3,oSec4,oSec5,oSec6,oSec7,oSec8

oReport := TReport():New("PMSR370",STR0001+" - "+cPeriodo,"PMR370",{|oReport| ReportPrint(oReport,aCol1,aCol2,aCol3,aCol4,aCol5,aCol6,aCol7,aCol8,sHeadTReport)},STR0002)
// "Fluxo de Caixa Analítico"

oReport:ParamReadOnly()
oReport:HideParamPage() 
oReport:SetPortrait()

oSec1 := TRSection():New(oReport,STR0002,{"SC7","SA2"},,.F.,.F.) //"Pedidos de Compra"
TRCell():New(oSec1,"C7_DATPRF","SC7",,,,.F., )
TRCell():New(oSec1,"C7_NUM","SC7",,,,.F., )
TRCell():New(oSec1,"C7_ITEM","SC7",,,,.F., )
TRCell():New(oSec1,"C7_TOTAL","SC7",,,,.F., )
oSec1:SetLeftMargin(5)
oSec1:SetLinesBefore(0)
TRFunction():New(oSec1:Cell("C7_TOTAL"),"TOT_PEDI","SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oSec1:SetTotalInLine(.F.)

oSec2 := TRSection():New(oReport,STR0003,{"SD1","SA2"},,.F.,.F.) //"Documento de Entrada"
TRCell():New(oSec2,"E2_VENCREA","SE2",,,,.F., )
TRCell():New(oSec2,"D1_DOC","SD1",,,,.F., )
TRCell():New(oSec2,SerieNfId('SD1',3,"D1_SERIE"),"SD1",,,,.F., )
TRCell():New(oSec2,"D1_FORNECE","SD1",,,,.F., )
TRCell():New(oSec2,"D1_LOJA","SD1",,,,.F., )
TRCell():New(oSec2,"D1_ITEM","SD1",,,,.F., )
TRCell():New(oSec2,"D1_COD","SD1",,,,.F., )
TRCell():New(oSec2,"D1_TOTAL","SD1",,,,.F., )
oSec2:SetLeftMargin(5)
oSec2:SetLinesBefore(0)
TRFunction():New(oSec2:Cell("D1_TOTAL"),"TOT_NFE","SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oSec2:SetTotalInLine(.F.)

oSec3 := TRSection():New(oReport,STR0004,{"SE2","SA2"},,.F.,.F.) //"Títulos a Pagar"
TRCell():New(oSec3,"E2_VENCREA","SE2",,,,.F., )
TRCell():New(oSec3,"E2_PREFIXO","SE2",,,,.F., )
TRCell():New(oSec3,"E2_NUM","SE2",,,,.F., )
TRCell():New(oSec3,"E2_PARCELA","SE2",,,,.F., )
TRCell():New(oSec3,"E2_TIPO","SE2",,,,.F., )
TRCell():New(oSec3,"E2_FORNECE","SE2",,,,.F., )
TRCell():New(oSec3,"E2_LOJA","SE2",,,,.F., )
TRCell():New(oSec3,"E2_VALOR","SE2",,,,.F., )
oSec3:SetLeftMargin(5)
oSec3:SetLinesBefore(0)
TRFunction():New(oSec3:Cell("E2_VALOR"),"TOT_PAG","SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oSec3:SetTotalInLine(.F.)

oSec4 := TRSection():New(oReport,STR0008,{"SE5"},,.F.,.F.) //Mov.Bancaria a Pagar
TRCell():New(oSec4,"E5_DTDISPO","SE5",,,,.F., )
TRCell():New(oSec4,"E5_MOEDA","SE5",,,,.F., )
TRCell():New(oSec4,"E5_NATUREZ","SE5",,,,.F., )
TRCell():New(oSec4,"E5_BANCO","SE5",,,,.F., )
TRCell():New(oSec4,"E5_AGENCIA","SE5",,,,.F., )
TRCell():New(oSec4,"E5_CONTA","SE5",,,,.F., )
TRCell():New(oSec4,"AJE_VALOR","AJE",,,,.F., )
oSec4:SetLeftMargin(5)
oSec4:SetLinesBefore(0)
TRFunction():New(oSec4:Cell("AJE_VALOR"),"T_MOVPAG","SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oSec4:SetTotalInLine(.F.)

oSec5 := TRSection():New(oReport,STR0005,{"SC6","SA1"},,.F.,.F.) //"Pedidos de Venda"
TRCell():New(oSec5,"C6_ENTREG","SC6",,,,.F., )
TRCell():New(oSec5,"C6_NUM","SC6",,,,.F., )
TRCell():New(oSec5,"C6_ITEM","SC6",,,,.F., )
TRCell():New(oSec5,"C6_VALOR","SC6",,,,.F., )
oSec5:SetLeftMargin(5)
oSec5:SetLinesBefore(0)
TRFunction():New(oSec5:Cell("C6_VALOR"),"TOT_VEND","SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oSec5:SetTotalInLine(.F.)

oSec6 := TRSection():New(oReport,STR0006,{"SD2","SA1"},,.F.,.F.) //"Notas Fiscais"
TRCell():New(oSec6,"E1_VENCREA","SE1",,,,.F., )
TRCell():New(oSec6,"D2_DOC","SD2",,,,.F., )
TRCell():New(oSec6,SerieNfId('SD2',3,"D2_SERIE"),"SD2",,,,.F., )
TRCell():New(oSec6,"D2_CLIENTE","SD2",,,,.F., )
TRCell():New(oSec6,"D2_LOJA","SD2",,,,.F., )
TRCell():New(oSec6,"D2_ITEM","SD2",,,,.F., )
TRCell():New(oSec6,"D2_COD","SD2",,,,.F., )
TRCell():New(oSec6,"D2_TOTAL","SD2",,,,.F., )
oSec6:SetLeftMargin(5)
oSec6:SetLinesBefore(0)
TRFunction():New(oSec6:Cell("D2_TOTAL"),"TOT_NF","SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oSec6:SetTotalInLine(.F.)

oSec7 := TRSection():New(oReport,STR0007,{"SE1","SA1"},,.F.,.F.) //"Títulos a Receber"
TRCell():New(oSec7,"E1_VENCREA","SE1",,,,.F., )
TRCell():New(oSec7,"E1_PREFIXO","SE1",,,,.F., )
TRCell():New(oSec7,"E1_NUM","SE1",,,,.F., )
TRCell():New(oSec7,"E1_PARCELA","SE1",,,,.F., )
TRCell():New(oSec7,"E1_TIPO","SE1",,,,.F., )
TRCell():New(oSec7,"E1_CLIENTE","SE1",,,,.F., )
TRCell():New(oSec7,"E1_LOJA","SE1",,,,.F., )
TRCell():New(oSec7,"E1_VALOR","SE1",,,,.F., )
oSec7:SetLeftMargin(5)
oSec7:SetLinesBefore(0)
TRFunction():New(oSec7:Cell("E1_VALOR"),"TOT_RECE","SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oSec7:SetTotalInLine(.F.)

oSec8 := TRSection():New(oReport,STR0009,{"SE5"},,.F.,.F.) //Mov.Bancaria a Receber
TRCell():New(oSec8,"E5_DTDISPO","SE5",,,,.F., )
TRCell():New(oSec8,"E5_MOEDA","SE5",,,,.F., )
TRCell():New(oSec8,"E5_NATUREZ","SE5",,,,.F., )
TRCell():New(oSec8,"E5_BANCO","SE5",,,,.F., )
TRCell():New(oSec8,"E5_AGENCIA","SE5",,,,.F., )
TRCell():New(oSec8,"E5_CONTA","SE5",,,,.F., )
TRCell():New(oSec8,"AJE_VALOR","AJE",,,,.F., )
oSec8:SetLeftMargin(5)
oSec8:SetLinesBefore(0)
TRFunction():New(oSec8:Cell("AJE_VALOR"),"T_MOVREC","SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oSec8:SetTotalInLine(.F.)

Return oReport                                                                              

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³10/01/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³oReport : Objeto Report do Relatório                         ³±±
±±³          ³aCol1 := array com os registros de Pedidos de Compra         ³±±
±±³          ³aCol2 : array com os registros de Documentos de Entrada      ³±±
±±³          ³aCol3 : array com os registros de Títulos a Pagar            ³±± 
±±³          ³aCol4 : array com os registros de Mov.Bancaria a Pagar       ³±±
±±³          ³aCol5 : array com os registros de Pedidos de Venda           ³±±
±±³          ³aCol6 : array com os registros de Notas Fiscais              ³±±
±±³          ³aCol7 : array com os registros de Títulos a Receber          ³±±
±±³          ³aCol8 : array com os registros de Mov.Bancaria a Receber     ³±±
±±³          ³sHeadTReport : string a ser utilizada no header do TReport   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport,aCol1,aCol2,aCol3,aCol4,aCol5,aCol6,aCol7,aCol8,sHeadTReport)
Local oSec1 := oReport:Section(1)
Local oSec2 := oReport:Section(2)
Local oSec3 := oReport:Section(3)
Local oSec4 := oReport:Section(4)
Local oSec5 := oReport:Section(5)
Local oSec6 := oReport:Section(6)
Local oSec7 := oReport:Section(7)
Local oSec8 := oReport:Section(8)
Local n := 0

oReport:OnPageBreak({||oReport:PrintText(sHeadTReport) , oReport:SkipLine() })

// Pedidos de Compra
If !Empty(aCol1[1,1]) .And. oReport:aSection[1]:lUservisible==.T.
	oSec1:Cell("C7_DATPRF"):SetBlock({|| aCol1[n,1] })
	oSec1:Cell("C7_NUM"):SetBlock   ({|| aCol1[n,3] })
	oSec1:Cell("C7_ITEM"):SetBlock  ({|| aCol1[n,4] })
	oSec1:Cell("C7_TOTAL"):SetBlock ({|| aCol1[n,5] })
	TRPosition():New(oSec1,"SC7",1,{|| aCol1[n,2]+aCol1[n,3]+aCol1[n,4] })
	TRPosition():New(oSec1,"SA2",1,{|| xFilial("SA2")+SC7->(C7_FORNECE+C7_LOJA) })

	oSec1:Init()

	oReport:PrintText(STR0002) //"Pedidos de Compra"
	oReport:FatLine()

	For n := 1 to Len(aCol1)
		oSec1:PrintLine()
	Next n
	oSec1:Finish()
	oReport:SkipLine()
EndIf

// Documentos de Entradas
If !Empty(aCol2[1,1]) .And. oReport:aSection[2]:lUservisible==.T.
	oSec2:Cell("E2_VENCREA"):SetBlock({|| aCol2[n,1] })
	oSec2:Cell("D1_DOC"):SetBlock    ({|| aCol2[n,3] })
	oSec2:Cell(SerieNfId('SD1',3,"D1_SERIE")):SetBlock  ({|| aCol2[n,4] })
	oSec2:Cell("D1_FORNECE"):SetBlock({|| aCol2[n,8] })
	oSec2:Cell("D1_LOJA"):SetBlock   ({|| aCol2[n,9] })
	oSec2:Cell("D1_ITEM"):SetBlock   ({|| aCol2[n,5] })
	oSec2:Cell("D1_COD"):SetBlock    ({|| aCol2[n,6] })
	oSec2:Cell("D1_TOTAL"):SetBlock  ({|| aCol2[n,7] })
	TRPosition():New(oSec2,"SD1",1,{|| aCol2[n,2]+aCol2[n,3]+aCol2[n,4]+aCol2[n,8]+aCol2[n,9]+aCol2[n,6]+aCol2[n,5] })
	TRPosition():New(oSec2,"SA2",1,{|| xFilial("SA2")+aCol2[n,8]+aCol2[n,9] })

	oSec2:Init()

	oReport:PrintText(STR0003) //"Documento de Entrada"
	oReport:FatLine()

	For n := 1 to Len(aCol2)
		oSec2:PrintLine()
	Next n
	oSec2:Finish()
	oReport:SkipLine()
EndIf

// Titulos a Pagar
If !Empty(aCol3[1,1]) .And. oReport:aSection[3]:lUservisible==.T.
	oSec3:Cell("E2_VENCREA"):SetBlock({|| aCol3[n,1] })
	oSec3:Cell("E2_PREFIXO"):SetBlock({|| aCol3[n,3] })
	oSec3:Cell("E2_NUM"):SetBlock    ({|| aCol3[n,4] })
	oSec3:Cell("E2_PARCELA"):SetBlock({|| aCol3[n,5] })
	oSec3:Cell("E2_TIPO"):SetBlock   ({|| aCol3[n,6] })
	oSec3:Cell("E2_FORNECE"):SetBlock({|| aCol3[n,7] })
	oSec3:Cell("E2_LOJA"):SetBlock   ({|| aCol3[n,8] })
	oSec3:Cell("E2_VALOR"):SetBlock  ({|| aCol3[n,9] })
	TRPosition():New(oSec3,"SE2",1,{|| aCol3[n,2]+aCol3[n,3]+aCol3[n,4]+aCol3[n,5]+aCol3[n,6]+aCol3[n,7]+aCol3[n,8] })
	TRPosition():New(oSec3,"SA2",1,{|| xFilial("SA2")+aCol3[n,7]+aCol3[n,8] })

	oSec3:Init()

	oReport:PrintText(STR0004) //"Títulos a Pagar"
	oReport:FatLine()

	For n := 1 to Len(aCol3)
		oSec3:PrintLine()
	Next n
	oSec3:Finish()
	oReport:SkipLine()
EndIf

// Mov.Bancaria a Pagar
If !Empty(aCol4[1,1]) .And. oReport:aSection[4]:lUservisible==.T.
	oSec4:Cell("E5_DTDISPO"):SetBlock({|| aCol4[n,1] })
	oSec4:Cell("E5_MOEDA"):SetBlock  ({|| aCol4[n,2] })
	oSec4:Cell("E5_NATUREZ"):SetBlock({|| aCol4[n,3] })
	oSec4:Cell("E5_BANCO"):SetBlock  ({|| aCol4[n,4] })
	oSec4:Cell("E5_AGENCIA"):SetBlock({|| aCol4[n,5] })
	oSec4:Cell("E5_CONTA"):SetBlock  ({|| aCol4[n,6] })
	oSec4:Cell("AJE_VALOR"):SetBlock ({|| aCol4[n,7] })

	oSec4:Init()

	oReport:PrintText(STR0008) //"Mov.Bancaria a Pagar"
	oReport:FatLine()

	For n := 1 to Len(aCol4)
		oSec4:PrintLine()
	Next n
	oSec4:Finish()
	oReport:SkipLine()
EndIf

// Pedidos de Venda
If !Empty(aCol5[1,1]) .And. oReport:aSection[5]:lUservisible==.T.
	oSec5:Cell("C6_ENTREG"):SetBlock({|| aCol5[n,1] })
	oSec5:Cell("C6_NUM"):SetBlock   ({|| aCol5[n,3] })
	oSec5:Cell("C6_ITEM"):SetBlock  ({|| aCol5[n,4] })
	oSec5:Cell("C6_VALOR"):SetBlock ({|| aCol5[n,5] })
	TRPosition():New(oSec5,"SC6",1,{|| aCol5[n,2]+aCol5[n,3]+aCol5[n,4] })
	TRPosition():New(oSec5,"SA1",1,{|| xFilial("SA1")+SC6->(C6_CLI+C6_LOJA) })

	oSec5:Init()

	oReport:PrintText(STR0005) //"Pedidos de Venda"
	oReport:FatLine()

	For n := 1 to Len(aCol5)
		oSec5:PrintLine()
	Next n
	oSec5:Finish()
	oReport:SkipLine()
EndIf

// "Notas Fiscais"
If !Empty(aCol6[1,1]) .And. oReport:aSection[6]:lUservisible==.T.
	oSec6:Cell("E1_VENCREA"):SetBlock({|| aCol6[n,1] })
	oSec6:Cell("D2_DOC"):SetBlock    ({|| aCol6[n,3] })
	oSec6:Cell(SerieNfId('SD2',3,"D2_SERIE")):SetBlock  ({|| aCol6[n,4] })
	oSec6:Cell("D2_CLIENTE"):SetBlock({|| aCol6[n,8] })
	oSec6:Cell("D2_LOJA"):SetBlock   ({|| aCol6[n,9] })
	oSec6:Cell("D2_ITEM"):SetBlock   ({|| aCol6[n,5] })
	oSec6:Cell("D2_COD"):SetBlock    ({|| aCol6[n,6] })
	oSec6:Cell("D2_TOTAL"):SetBlock  ({|| aCol6[n,7] })
	TRPosition():New(oSec6,"SD2",3,{|| aCol6[n,2]+aCol6[n,3]+aCol6[n,4]+aCol6[n,8]+aCol6[n,9]+aCol6[n,6]+aCol6[n,5] })
	TRPosition():New(oSec6,"SA1",1,{|| xFilial("SA1")+aCol6[n,8]+aCol6[n,9] })

	oSec6:Init()

	oReport:PrintText(STR0006) //"Notas Fiscais"
	oReport:FatLine()

	For n := 1 to Len(aCol6)
		oSec6:PrintLine()
	Next n
	oSec6:Finish()
	oReport:SkipLine()
EndIf

// Titulos a Receber
If !Empty(aCol7[1,1]) .And. oReport:aSection[7]:lUservisible==.T.
	oSec7:Cell("E1_VENCREA"):SetBlock({|| aCol7[n,1] })
	oSec7:Cell("E1_PREFIXO"):SetBlock({|| aCol7[n,3] })
	oSec7:Cell("E1_NUM"):SetBlock    ({|| aCol7[n,4] })
	oSec7:Cell("E1_PARCELA"):SetBlock({|| aCol7[n,5] })
	oSec7:Cell("E1_TIPO"):SetBlock   ({|| aCol7[n,6] })
	oSec7:Cell("E1_CLIENTE"):SetBlock({|| aCol7[n,7] })
	oSec7:Cell("E1_LOJA"):SetBlock   ({|| aCol7[n,8] })
	oSec7:Cell("E1_VALOR"):SetBlock  ({|| aCol7[n,9] })
	TRPosition():New(oSec7,"SE1",1,{|| aCol7[n,2]+aCol7[n,3]+aCol7[n,4]+aCol7[n,5]+aCol7[n,6]+aCol7[n,7]+aCol7[n,8] })
	TRPosition():New(oSec7,"SA1",1,{|| xFilial("SA1")+aCol7[n,7]+aCol7[n,8] })

	oSec7:Init()

	oReport:PrintText(STR0007) //"Títulos a Receber"
	oReport:FatLine()

	For n := 1 to Len(aCol7)
		oSec7:PrintLine()
	Next n
	oSec7:Finish()
	oReport:SkipLine()
EndIf

// Mov.Bancaria a Receber
If !Empty(aCol8[1,1]) .And. oReport:aSection[8]:lUservisible==.T.
	oSec8:Cell("E5_DTDISPO"):SetBlock({|| aCol8[n,1] })
	oSec8:Cell("E5_MOEDA"):SetBlock  ({|| aCol8[n,2] })
	oSec8:Cell("E5_NATUREZ"):SetBlock({|| aCol8[n,3] })
	oSec8:Cell("E5_BANCO"):SetBlock  ({|| aCol8[n,4] })
	oSec8:Cell("E5_AGENCIA"):SetBlock({|| aCol8[n,5] })
	oSec8:Cell("E5_CONTA"):SetBlock  ({|| aCol8[n,6] })
	oSec8:Cell("AJE_VALOR"):SetBlock ({|| aCol8[n,7] })

	oSec8:Init()

	oReport:PrintText(STR0009) //"Mov.Bancaria a Receber"
	oReport:FatLine()

	For n := 1 to Len(aCol8)
		oSec8:PrintLine()
	Next n
	oSec8:Finish()
	oReport:SkipLine()
EndIf

Return