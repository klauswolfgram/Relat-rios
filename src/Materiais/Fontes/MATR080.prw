/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR080.CH"
#INCLUDE "PROTHEUS.CH"          
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR080  ³ Autor ³ Nereu Humberto Junior ³ Data ³  06/07/2006     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o da Rela‡„o de Notas Fiscais                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Matr080()

Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Nereu Humberto Junior  ³ Data ³06.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oSection1
Local oSection2
Local oSection3 
Local oSection4	
      
Local aOrdem := {}
Local cTamVlr := TamSX3('D1_TOTAL')[1]
Local cTamImp := TamSX3('F1_VALIMP1')[1]
Local cAliasSD1 := GetNextAlias()

oReport:= TReport():New("MATR080",STR0001,"MTR080", {|oReport| ReportPrint(oReport,cAliasSD1)},STR0002+" "+STR0003+" "+STR0004) //"Rela‡„o de Notas Fiscais"##"Emiss„o da Rela‡„o de Notas de Compras"##"A op‡„o de filtragem deste relat¢rio s¢ ‚ v lida na op‡„o que lista os"##"itens. Os parƒmetros funcionam normalmente em qualquer op‡„o."
oReport:SetTotalInLine(.F.)
If TamSX3("D1_COD")[1] > 15 
	oReport:SetLandScape()
Else
	oReport:SetPortrait()
EndIf

Pergunte("MTR080",.F.)

Aadd( aOrdem, STR0005 ) // Por Nota
Aadd( aOrdem, STR0006 ) // Por Produto 
Aadd( aOrdem, STR0043 ) // Por Data Digitacao
Aadd( aOrdem, STR0059 ) // Por Data Emissao
Aadd( aOrdem, STR0062 ) // Por Fornecedor

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Sessao 1                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport,STR0073,{"SD1","SF1","SA1","SA2","SB1"},aOrdem) //"Rela‡„o de Notas Fiscais"
oSection1 :SetTotalInLine(.F.)
oSection1 :SetReadOnly()

//--------- Celulas utilizadas para ordem de Produto --------
TRCell():New(oSection1,"D1_COD","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cDescri","   ",STR0067,"@!",28,/*lPixel*/,/*{|| code-block de impressao }*/) //Descricao
TRCell():New(oSection1,"B1_GRUPO","SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
//--------- Celulas utilizadas para ordem de Nota --------
TRCell():New(oSection1,"D1_DOC","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection1,SerieNfId("SD1",3,"D1_SERIE"),"SD1",SerieNfId("SD1",7,"D1_SERIE"),/*Picture*/,SerieNfId("SD1",6,"D1_SERIE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_EMISSAO","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_DTDIGIT","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_TIPO","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_FORNECE","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_LOJA","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_NOME","   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_QUANT","SD1",/*Titulo*/,Pesqpict("SD1","D1_QUANT")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("A2_NOME"):GetFieldInfo("A2_NOME")
oSection1:Cell("A2_NOME"):SetSize(30)

TRCell():New(oSection1,"A2_MUN","   ",STR0068,"@!",15,/*lPixel*/,/*{|| code-block de impressao }*/) //"Praca"
TRCell():New(oSection1,"F1_COND","SF1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If cPaisLoc == "BRA"
	TRCell():New(oSection1,"nValIcm1","   ","Tot. ICMS",Pesqpict("SF1","F1_VALICM"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"nValIpi1","   ","Tot. IPI",Pesqpict("SF1","F1_VALIPI"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
Else
	TRCell():New(oSection1,"nImpNoInc1","   ",STR0069,Pesqpict("SF1","F1_VALIMP1"),cTamVlr,/*lPixel*/,/*{|| code-block de impressao }*/) //"INI"
	TRCell():New(oSection1,"nImpInc1","   ",STR0070,Pesqpict("SF1","F1_VALIMP1"),cTamVlr,,,,,"RIGHT")	//"IPI"
Endif	
TRCell():New(oSection1,"nTotNF1","   ","Tot.Geral",Pesqpict("SF1","F1_VALMERC"),TamSX3("F1_VALMERC")[1],,,,,"RIGHT")
If cPaisLoc == "BRA"
	TRCell():New(oSection1,"D1_CF","SD1",STR0085/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Cd.Fisc."
EndIf
TRCell():New(oSection1,"D1_TES","SD1",STR0086/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"TES"
If cPaisLoc == "BRA"
	TRCell():New(oSection1,"D1_PICM","SD1",STR0087/*Titulo*/,Pesqpict("SD1","D1_PICM")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"%ICMS"
	TRCell():New(oSection1,"D1_IPI","SD1",STR0088/*Titulo*/,Pesqpict("SD1","D1_IPI")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"%IPI"
Else 
	TRCell():New(oSection1,"nImpNoInc","   ",STR0071,Pesqpict("SD1","D1_PICM")/*Picture*/,cTamVlr,/*lPixel*/,/*{|| code-block de impressao }*/) //"Imp.N.Inc"
	TRCell():New(oSection1,"nImpInc","   ",STR0072,Pesqpict("SD1","D1_IPI")/*Picture*/,cTamVlr,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Imp.Inc"
Endif	

oSection1:SetNoFilter("SF1")
oSection1:SetNoFilter("SA1")
oSection1:SetNoFilter("SA2")
oSection1:SetNoFilter("SB1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Sessao 2                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,STR0074,{"SD1","SF1","SA1","SA2","SB1"}) 
oSection2 :SetTotalInLine(.F.)
oSection2 :SetReadOnly()

//--------- Celulas utilizadas para ordem de Produto -----
TRCell():New(oSection2,"D1_DOC","SD1",/*Titulo*/,/*Picture*/,12,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection2,"D1_EMISSAO","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D1_DTDIGIT","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D1_FORNECE","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"A2_NOME","   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection2:Cell("A2_NOME"):GetFieldInfo("A2_NOME")   
oSection2:Cell("A2_NOME"):SetSize(30)

//--------- Celulas utilizadas para ordem de Nota --------
TRCell():New(oSection2,"D1_COD","SD1",/*Titulo*/,/*Picture*/,40,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"cDescri","   ",STR0067,"@!",28,/*lPixel*/,/*{|| code-block de impressao }*/)
If cPaisLoc == "BRA"
	TRCell():New(oSection2,"D1_CF","SD1",STR0085/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Cd.Fisc."
EndIf
TRCell():New(oSection2,"D1_TES","SD1",STR0086/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"TES"
If cPaisLoc == "BRA"
	TRCell():New(oSection2,"D1_PICM","SD1",STR0087/*Titulo*/,Pesqpict("SD1","D1_PICM")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"%ICMS"
	TRCell():New(oSection2,"D1_IPI","SD1",STR0088/*Titulo*/,Pesqpict("SD1","D1_IPI")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"%IPI"
Else 
	TRCell():New(oSection2,"nImpNoInc","   ",STR0071,Pesqpict("SD1","D1_PICM")/*Picture*/,cTamVlr,/*lPixel*/,/*{|| code-block de impressao }*/) //"Imp.N.Inc"
	TRCell():New(oSection2,"nImpInc","   ",STR0072,Pesqpict("SD1","D1_IPI")/*Picture*/,cTamVlr,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Imp.Inc"
Endif	
TRCell():New(oSection2,"D1_LOCAL","SD1",STR0089/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Amz"
//--------- Celulas utilizadas para ordem de Produto -----
TRCell():New(oSection2,"D1_TIPO","SD1",STR0090/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Tp.Doc."
//--------------------------------------------------------
TRCell():New(oSection2,"D1_QUANT","SD1",/*Titulo*/,Pesqpict("SD1","D1_QUANT")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If cPaisLoc == 'MEX'
	TRCell():New(oSection2,"D1_VALADI","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf
TRCell():New(oSection2,"nVunit","   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection2:Cell("nVunit"):GetFieldInfo("D1_VUNIT")
TRCell():New(oSection2,"nVtotal","   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection2:Cell("nVtotal"):GetFieldInfo("D1_TOTAL")  
oSection2:Cell("nVtotal"):SetTitle(STR0091)
TRCell():New(oSection2,"D1_VALICM","SD1",/*Titulo*/,Pesqpict("SD1","D1_VALICM")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D1_VALIPI","SD1",/*Titulo*/,Pesqpict("SD1","D1_VALIPI")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D1_VALFRE","SD1",/*Titulo*/,Pesqpict("SD1","D1_VALFRE")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D1_DESPESA","SD1",/*Titulo*/,Pesqpict("SD1","D1_DESPESA")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D1_VALDESC","SD1",/*Titulo*/,Pesqpict("SD1","D1_VALDESC")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D1_SEGURO","SD1",/*Titulo*/,Pesqpict("SD1","D1_SEGURO")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection2:SetNoFilter("SF1")
oSection2:SetNoFilter("SA1")
oSection2:SetNoFilter("SA2")
oSection2:SetNoFilter("SB1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Sessao 3                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3 := TRSection():New(oSection2,STR0075,{"SD1","SF1","SB1"}) 
oSection3 :SetTotalInLine(.F.)
oSection3 :SetReadOnly()

//--------- Celulas utilizadas para ordem de Nota --------
TRCell():New(oSection3,"F1_COND","SF1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If cPaisLoc == "BRA"
	TRCell():New(oSection3,"nValIcm","   ","Tot. Icms",Pesqpict("SF1","F1_VALICM"),/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"nValIpi","   ","Tot. IPI",Pesqpict("SF1","F1_VALIPI"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	//--------- Celulas utilizadas para ordem de Produto -----
	TRCell():New(oSection3,"nTotImp","   ",STR0066,Pesqpict("SF1","F1_VALMERC"),cTamVlr,/*lPixel*/,/*{|| code-block de impressao }*/)
Else
	TRCell():New(oSection3,"nValImpNoInc","   ",STR0051,Pesqpict("SF1","F1_VALIMP1"),cTamImp,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"nValImpInc","   ",STR0056,Pesqpict("SF1","F1_VALIMP1"),cTamImp,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"nTotImp","   ",STR0025,Pesqpict("SF1","F1_VALMERC"),cTamVlr,/*lPixel*/,/*{|| code-block de impressao }*/)
Endif	

oSection3:SetNoFilter("SF1")
oSection3:SetNoFilter("SB1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Sessao 4                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection4 := TRSection():New(oSection3,STR0076,{"SD1","SF1","SB1"}) 
oSection4 :SetTotalInLine(.F.)
oSection4 :SetReadOnly()
If cPaisLoc == 'MEX'
	TRCell():New(oSection4,"nF1Vldi","   ",/*Titulo*/,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	oSection4:Cell("nF1Vldi"):GetFieldInfo("F1_VALADI")
EndIF
TRCell():New(oSection4,"nFrete","   ","Tot.Frete",Pesqpict("SF1","F1_FRETE"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"nDespesa","   ","Tot.Despesa",Pesqpict("SF1","F1_DESPESA"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"nDesconto","   ","Tot.Desconto",Pesqpict("SF1","F1_DESCONT"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"nTotNF","   ","Tot.Geral",Pesqpict("SF1","F1_VALMERC"),TamSX3("F1_VALMERC")[1],,,,,"RIGHT")
		
oSection4:SetNoFilter("SF1")
oSection4:SetNoFilter("SB1")


oSection3:SetEdit(.T.)
oSection4:SetEdit(.T.)

oSection1:SetEditCell(.T.)
oSection2:SetEditCell(.T.) 

Return(oReport)  

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³16.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasSD1,nReg)

Local oSection1 := oReport:Section(1) 
Local oSection2 := oReport:Section(1):Section(1)  
Local oSection3 := oReport:Section(1):Section(1):Section(1)  
Local oSection4 := oReport:Section(1):Section(1):Section(1):Section(1)   

Local nOrdem    := oReport:Section(1):GetOrder() 
Local aCampos   := {}                     
Local cFilUsrSD1:= ""
Local cSelect   := ""
Local cSelect1  := ""
Local cSelect2  := "%%"
Local cSelect3  := "%%"
Local cSelect4  := ""
Local cFrom     := "%%"
Local cWhereSF1 := ""
Local cWhereSB1 := "%%"
Local cOrder    := ""
LOCAL cDocAnt     := ""
LOCAL cCodAnt     := ""
LOCAL cAliasSF1   := "SF1"
LOCAL cAliasSB1   := "SB1"
LOCAL cAliasSA1   := "SA1"
LOCAL cAliasSA2   := "SA2"
LOCAL cAliasSF4   := "SF4"
LOCAL cForCli     := ""
LOCAL cMuni       := ""
LOCAL cFornF1     := ""
LOCAL cLojaF1     := ""
LOCAL cDocF1      := ""
LOCAL cSerieF1    := ""
LOCAL cCondF1     := ""
LOCAL cTipoF1     := ""
LOCAL cDescri     := ""
LOCAL cFornAnt    := ""
LOCAL cName       := ""
LOCAL nMoedaF1    := 0
LOCAL nTxMoedaF1  := 0
LOCAL nFreteF1    := 0
LOCAL nDespesaF1  := 0
LOCAL nSeguroF1   := 0
LOCAL nValTotF1   := 0
LOCAL nValMerc    := 0
LOCAL nValDesc    := 0
LOCAL nValIcm     := 0
LOCAL nValIpi     := 0
LOCAL nValImpInc  := 0
LOCAL nValImpNoInc:= 0
LOCAL nTotGeral   := 0
LOCAL nTotGerImp  := 0
LOCAL nTotDesco   := 0
LOCAL nTotFrete   := 0
LOCAL nTotSeguro  := 0
LOCAL nTotDesp    := 0
LOCAL nTotProd    := 0
LOCAL nTotQger    := 0
LOCAL nTotData    := 0
LOCAL nTotForn    := 0
LOCAL nTotquant   := 0
LOCAL nTGerIcm    := 0
LOCAL nTGerIpi    := 0
LOCAL nTGImpInc   := 0
LOCAL nTGImpNoInc := 0
LOCAL nImpInc     := 0
LOCAL nImpNoInc   := 0
LOCAL nImpos      := 0
LOCAL nCount      := 0
LOCAL nTaxa       := 1
LOCAL nMoeda      := 1
LOCAL nTpImp	  := IIF(ValType(oReport:nDevice)!=Nil,oReport:nDevice,0)	// Tipo de Impressao
LOCAL nPageWidth  := oReport:PageHeight(.F.)								// Altura da pagina
LOCAL nDecs       := Msdecimais(mv_par18)
LOCAL lQuery      := .F.
LOCAL lImp	      := .F.
LOCAL lFiltro     := .T.
LOCAL lDescLine   := .T.
LOCAL lPrintLine  := .F.
LOCAL lEasy       := If(GetMV("MV_EASY")=="S",.T.,.F.)
LOCAL lPlanTab    := oReport:lXlsTable
LOCAL aImpostos   := {} 
LOCAL dDtDig      := dDataBase
LOCAL dDataAnt    := dDataBase
LOCAL dEmissaoF1  := dDataBase
LOCAL dDtDigitF1  := dDataBase
LOCAL nX       := 0
Local nY       := 0
LOCAL aStrucSD1   := {}
Local cIdWhere := ""
Local nF1VldC  := 0
Local nTotQtd  := 0

GetValImp(@aCampos)

If cPaisLoc <> "BRA"
		oSection1:Cell("nImpNoInc1"):Enable()
   		oSection1:Cell("nImpInc1"):Enable()
Endif	

cIdWhere := "%"
cIdWhere += "SD1." + SerieNfId("SD1",3,"D1_SERIE") + " >= '" + mv_par14 + "'	AND "		
cIdWhere += "SD1." + SerieNfId("SD1",3,"D1_SERIE") + " <= '" + mv_par15 + "'	AND "
cIdWhere += "%"

	If mv_par05 == 2 .and. nOrdem <> 2
		oSection1:Cell("D1_COD"):Hide()
		oSection1:Cell("cDescri"):Hide()
		oSection1:Cell("B1_GRUPO"):Hide()
	Endif
If nOrdem == 1
	oReport:SetTitle( oReport:Title()+" - "+STR0005) //"Por Nota"

	oSection1:Cell("D1_COD"):Disable()
	oSection1:Cell("cDescri"):Disable()
	oSection1:Cell("B1_GRUPO"):Disable()
	oSection1:Cell("D1_QUANT"):Disable()
	If cPaisLoc == "BRA"
		oSection1:Cell("D1_CF"):Disable()
		oSection1:Cell("D1_TES"):Disable()		
		oSection1:Cell("D1_PICM"):Disable()	
		oSection1:Cell("D1_IPI"):Disable()	
	Endif
	oSection2:Cell("D1_DOC"):Disable()
	oSection2:Cell("D1_EMISSAO"):Disable()
	oSection2:Cell("D1_DTDIGIT"):Disable()
	oSection2:Cell("D1_FORNECE"):Disable()
	oSection2:Cell("A2_NOME"):Disable()
	oSection2:Cell("D1_TIPO"):Disable()
	If !lPlanTab
		oSection2:Cell("D1_VALICM"):Disable()
		oSection2:Cell("D1_VALIPI"):Disable()
		oSection2:Cell("D1_VALFRE"):Disable()
		oSection2:Cell("D1_DESPESA"):Disable()
		oSection2:Cell("D1_VALDESC"):Disable()		
		oSection2:Cell("D1_SEGURO"):Disable()			
	Endif
	
	oSection3:Cell("nTotImp"):Disable()
	
	If cPaisLoc <> "BRA"
		oSection1:Cell("nImpNoInc1"):Disable()
		oSection1:Cell("nImpInc1"):Enable()
	Endif
	
ElseIf nOrdem == 2
	oReport:SetTitle( oReport:Title()+" - "+STR0006) //"Por Produto"
	
	oSection1:Cell("D1_DOC"):Disable()
	oSection1:Cell(SerieNfId("SD1",3,"D1_SERIE")):Disable()
	oSection1:Cell("D1_EMISSAO"):Disable()
	oSection1:Cell("D1_DTDIGIT"):Disable()
	oSection1:Cell("D1_TIPO"):Disable()
	oSection1:Cell("D1_FORNECE"):Disable()
	oSection1:Cell("D1_LOJA"):Disable()
	oSection1:Cell("A2_NOME"):Disable()
	oSection1:Cell("A2_MUN"):Disable()
	oSection1:Cell("F1_COND"):Disable()
	If cPaisLoc == "BRA"
		oSection1:Cell("nValIcm1"):Disable()
		oSection1:Cell("nValIpi1"):Disable()
		oSection1:Cell("D1_CF"):Disable()
		oSection1:Cell("D1_TES"):Disable()		
		oSection1:Cell("D1_PICM"):Disable()	
		oSection1:Cell("D1_IPI"):Disable()			
	Else
		oSection1:Cell("nImpNoInc1"):Disable()
		oSection1:Cell("nImpInc1"):Disable()
	Endif	
	oSection1:Cell("nTotNF1"):Disable()
	
	oSection2:Cell("D1_COD"):Disable()
	oSection2:Cell("cDescri"):Disable()
	oSection2:Cell("D1_DTDIGIT"):Disable()
	
	If !lPlanTab
		oSection2:Cell("D1_VALICM"):Disable()
		oSection2:Cell("D1_VALIPI"):Disable()
		oSection2:Cell("D1_VALFRE"):Disable()
		oSection2:Cell("D1_DESPESA"):Disable()
		oSection2:Cell("D1_VALDESC"):Disable()
		oSection2:Cell("D1_SEGURO"):Disable()	
	ElseIf cPaisLoc == "BRA"
		oSection1:Cell("D1_CF"):Enable()
		oSection1:Cell("D1_TES"):Enable()		
		oSection1:Cell("D1_PICM"):Enable()	
		oSection1:Cell("D1_IPI"):Enable()	
	Endif

	oSection3:Cell("F1_COND"):Disable()
	
ElseIf nOrdem == 3 .Or. nOrdem == 4
	If nOrdem == 3
		oReport:SetTitle( oReport:Title()+" - "+STR0043) //"Por Data Digitacao"
		oSection1:Cell("D1_EMISSAO"):Disable()
	Else
		oReport:SetTitle( oReport:Title()+" - "+STR0059) //"Por Data Emissao"
		oSection1:Cell("D1_DTDIGIT"):Disable()
	Endif	
	oSection1:Cell("D1_COD"):Disable()
	oSection1:Cell("cDescri"):Disable()
	oSection1:Cell("B1_GRUPO"):Disable()	
	oSection1:Cell("D1_TIPO"):Disable()
	oSection1:Cell("D1_LOJA"):Disable()
	oSection1:Cell("D1_QUANT"):Disable()
	If cPaisLoc == "BRA"
		oSection1:Cell("D1_CF"):Disable()
		oSection1:Cell("D1_TES"):Disable()		
		oSection1:Cell("D1_PICM"):Disable()	
		oSection1:Cell("D1_IPI"):Disable()		
	Endif
	If mv_par05 == 1
		oSection1:Cell("D1_DOC"):Disable()
		oSection1:Cell(SerieNfId("SD1",3,"D1_SERIE")):Disable()
		oSection1:Cell("D1_FORNECE"):Disable()
		oSection1:Cell("A2_NOME"):Disable()
		oSection1:Cell("A2_MUN"):Disable()
		oSection1:Cell("F1_COND"):Disable()
		If cPaisLoc == "BRA"
			oSection1:Cell("nValIcm1"):Disable()
			oSection1:Cell("nValIpi1"):Disable()
		Else
			oSection1:Cell("nImpNoInc1"):Disable()
			oSection1:Cell("nImpInc1"):Disable()
		Endif	
		oSection1:Cell("nTotNF1"):Disable()
	Else
		oSection1:Cell("D1_DOC"):Enable()
		oSection1:Cell(SerieNfId("SD1",3,"D1_SERIE")):Enable()
		oSection1:Cell("D1_FORNECE"):Enable()
		oSection1:Cell("A2_NOME"):Enable()
		oSection1:Cell("A2_MUN"):Enable()
		oSection1:Cell("F1_COND"):Enable()
		If cPaisLoc == "BRA"
			oSection1:Cell("nValIcm1"):Enable()
			oSection1:Cell("nValIpi1"):Enable()
		Else
			oSection1:Cell("nImpNoInc1"):Enable()
			oSection1:Cell("nImpInc1"):Enable()
		Endif	
		oSection1:Cell("nTotNF1"):Enable()
	Endif
	oSection2:Cell("D1_EMISSAO"):Disable()
	oSection2:Cell("D1_DTDIGIT"):Disable()
	oSection2:Cell("cDescri"):Disable()	
	oSection3:Cell("F1_COND"):Disable()

ElseIf nOrdem == 5
	oReport:SetTitle( oReport:Title()+" - "+STR0062) //"Por Fornecedor"	
	
	oSection1:Cell("D1_COD"):Disable()
	oSection1:Cell("cDescri"):Disable()
	oSection1:Cell("B1_GRUPO"):Disable()	
	oSection1:Cell("D1_TIPO"):Disable()
	oSection1:Cell("D1_QUANT"):Disable()
	If cPaisLoc == "BRA"
		oSection1:Cell("D1_CF"):Disable()
		oSection1:Cell("D1_TES"):Disable()		
		oSection1:Cell("D1_PICM"):Disable()	
		oSection1:Cell("D1_IPI"):Disable()		
	Endif
	If mv_par05 == 1
		oSection1:Cell("D1_DOC"):Disable()
		oSection1:Cell(SerieNfId("SD1",3,"D1_SERIE")):Disable()
		oSection1:Cell("D1_EMISSAO"):Disable()
		oSection1:Cell("D1_DTDIGIT"):Disable()
		oSection1:Cell("A2_MUN"):Disable()
		oSection1:Cell("F1_COND"):Disable()
		If cPaisLoc == "BRA"
			oSection1:Cell("nValIcm1"):Disable()
			oSection1:Cell("nValIpi1"):Disable()
		Else
			oSection1:Cell("nImpNoInc1"):Disable()
			oSection1:Cell("nImpInc1"):Disable()
		Endif	
		oSection1:Cell("nTotNF1"):Disable()
	Else
		oSection1:Cell("D1_DOC"):Enable()
		oSection1:Cell(SerieNfId("SD1",3,"D1_SERIE")):Enable()
		oSection1:Cell("D1_FORNECE"):Enable()
		oSection1:Cell("A2_NOME"):Enable()
		oSection1:Cell("A2_MUN"):Enable()
		oSection1:Cell("F1_COND"):Enable()
		IF lPlanTab
			oSection2:Cell("D1_VALICM"):Enable()		
			oSection2:Cell("D1_VALIPI"):Enable()
			oSection2:Cell("D1_VALFRE"):Enable()
			oSection2:Cell("D1_DESPESA"):Enable()
			oSection2:Cell("D1_VALDESC"):Enable()		
			oSection2:Cell("D1_SEGURO"):Enable()		
		Endif
		If cPaisLoc == "BRA"
			oSection1:Cell("nValIcm1"):Enable()
			oSection1:Cell("nValIpi1"):Enable()
		Else
			oSection1:Cell("nImpNoInc1"):Enable()
			oSection1:Cell("nImpInc1"):Enable()
		Endif	
		oSection1:Cell("nTotNF1"):Enable()
	Endif
	oSection2:Cell("cDescri"):Disable()	
	oSection2:Cell("D1_FORNECE"):Disable()	
	oSection2:Cell("A2_NOME"):Disable()	
	oSection3:Cell("F1_COND"):Disable()	
	
Endif

If mv_par05 == 1
	oSection1:Cell("A2_MUN"):Disable()
	oSection1:Cell("F1_COND"):Disable()
	If cPaisLoc == "BRA"
		oSection1:Cell("nValIcm1"):Disable()
		oSection1:Cell("nValIpi1"):Disable()
	Else	
		oSection1:Cell("nImpNoInc1"):Disable()
		oSection1:Cell("nImpInc1"):Disable()
	Endif	
	oSection1:Cell("nTotNF1"):Disable()
Else
	If nOrdem <> 2
		oSection1:SetHeaderPage()
	Endif	
	If nOrdem == 1 .Or. nOrdem == 4 .Or. nOrdem == 5
		oSection1:Cell("D1_DTDIGIT"):Disable()
	Endif	
	If nOrdem == 3 
		oSection1:Cell("D1_EMISSAO"):Disable()
	Endif		
	oSection1:Cell("D1_TIPO"):Disable()
	oSection1:Cell("D1_LOJA"):Disable()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona a Ordem de todos os Arquivos usados no Relatorio   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SA1")
dbSetOrder(1)
dbSelectArea("SA2")
dbSetOrder(1)
dbSelectArea("SB1")
dbSetOrder(1)
dbSelectArea("SF4")
dbSetOrder(1)
dbselectarea("SF1")
dbsetorder(1)
dbSelectArea("SD1")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cALiasSF1 := cAliasSD1
cALiasSB1 := IIF(!lEasy,cAliasSD1,"SB1")
cALiasSA1 := cAliasSD1
cALiasSA2 := cAliasSD1
lQuery :=.T.
aStrucSD1 := SD1->(dbStruct())     
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Composicao do Select Inicial de acordo com a ordem escolhida            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSelect := "%"
 	If nOrdem == 1
    	cSelect += "SD1.D1_FILIAL,SD1.D1_DOC,SD1.D1_SERIE," + Iif(SerieNfId("SD1",3,"D1_SERIE")<>"D1_SERIE","SD1.D1_SDOC,","")
    	cSelect += "SD1.D1_FORNECE,SD1.D1_LOJA,SD1.D1_COD,SD1.D1_ITEM,"
    ElseIf nOrdem == 2 
		cSelect += "SD1.D1_FILIAL,SD1.D1_COD,SD1.D1_DOC,SD1.D1_SERIE," + Iif(SerieNfId("SD1",3,"D1_SERIE")<>"D1_SERIE","SD1.D1_SDOC,","")
		cSelect += "SD1.D1_FORNECE,SD1.D1_LOJA,"
	ElseIf nOrdem == 3 
		cSelect += "SD1.D1_FILIAL,SD1.D1_DTDIGIT,SD1.D1_DOC,SD1.D1_SERIE," + Iif(SerieNfId("SD1",3,"D1_SERIE")<>"D1_SERIE","SD1.D1_SDOC,","")
		cSelect += "SD1.D1_FORNECE,SD1.D1_LOJA,"
    ElseIf nOrdem == 4 
    	cSelect += "SD1.D1_FILIAL,SD1.D1_EMISSAO,SD1.D1_DOC,SD1.D1_SERIE," + Iif(SerieNfId("SD1",3,"D1_SERIE")<>"D1_SERIE","SD1.D1_SDOC,","")
    	cSelect += "SD1.D1_FORNECE,SD1.D1_LOJA,"
    ElseIf nOrdem == 5 
    	cSelect += "SD1.D1_FILIAL,SD1.D1_FORNECE,SD1.D1_LOJA,SD1.D1_DOC,SD1.D1_SERIE," + Iif(SerieNfId("SD1",3,"D1_SERIE")<>"D1_SERIE","SD1.D1_SDOC,","") + "SD1.D1_ITEM,"
    Endif    
cSelect += "%"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Composicao do Select dos impostos variaveis                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cSelect1 := "%"

	 If cPaisLoc == 'MEX'
    	cSelect1 += "F1_VALADI,D1_VALADI,"
    EndIf
    
    For nX := 1 To Len(acampos)
	cSelect1 +=acampos[nX]+"," 		 		
    Next nX	
cSelect1 += "%"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Composicao do Select da tabela SB1 quando nao for integrado com o EIC   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
If !lEasy        
	cSelect2 := "%"
		 cSelect2 += Iif(SerieNfId("SF1",3,"F1_SERIE")<>"F1_SERIE","F1_SDOC,","")
        cSelect2 += "B1_DESC,B1_GRUPO,"
        cSelect2 += "%"
    EndIf	
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³Esta rotina foi escrita para adicionar no select os campos         ³
    //³usados no filtro do usuario quando houver, a rotina acrecenta      ³
    //³somente os campos que forem adicionados ao filtro testando         ³
    //³se os mesmo já existem no select ou se forem definidos novamente   ³
    //³pelo o usuario no filtro, esta rotina acrecenta o minimo possivel  ³
    //³de campos no select pois pelo fato da tabela SD1 ter muitos campos |
    //³e a query ter UNION ao adicionar todos os campos do SD1 estava     |
    //³derrubando o TOP CONNECT e abortando o sistema.                    |
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   	
   	cFilUsrSD1:= oSection1:GetAdvplExp()
    If !Empty(cFilUsrSD1)
	cSelect4 := "D1_FILIAL,D1_DOC,D1_SERIE," + Iif(SerieNfId("SD1",3,"D1_SERIE")<>"D1_SERIE","D1_SDOC,","")
	cSelect4 += "D1_FORNECE,D1_LOJA,D1_COD,D1_DTDIGIT,D1_QUANT,D1_TES,D1_IPI,"
	cSelect4 += "D1_VUNIT,D1_TOTAL,D1_VALFRE,D1_DESPESA,D1_SEGURO,D1_PEDIDO,D1_ITEMPC,D1_PICM,D1_TIPO,D1_CF," 
 	cSelect4 += "D1_GRUPO,D1_LOCAL,D1_ITEM,D1_EMISSAO,D1_VALDESC,D1_ICMSRET,D1_VALICM,D1_VALIPI"				    
	cSelect3 := "%"   
	For nX := 1 To SD1->(FCount())
		cName := SD1->(FieldName(nX))
	 	If AllTrim( cName ) $ cFilUsrSD1
      		If aStrucSD1[nX,2] <> "M"  
      			If !cName $ cSelect .And. !cName $ cSelect1 .And. !cName $ cSelect4
	        		cSelect3 += cName +","
	          	Endif 	
	       	EndIf
		EndIf 			       	
	Next nX 
	cSelect3 += "%"
    Endif    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Composicao do From da tabela SB1 quando nao for integrado com o EIC     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
If !lEasy        	  
	cFrom := "%"
    	cFrom += ","
    	cFrom += RetSqlName("SB1")+" SB1 "
    	cFrom += "%"
    EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Composicao do Where para Remito                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
cWhereSF1 := "%"
cWhereSF1 += "NOT ("+IsRemito(3,'SF1.F1_TIPODOC')+ ") " 
cWhereSF1 += "%"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Composicao do Where para tabela SB1 quando nao for integrado com o EIC  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
If !lEasy        	        
	cWhereSB1 := "%"
        cWhereSB1 += "SB1.B1_FILIAL ='"+xFilial("SB1")+"' AND "
        cWhereSB1 += "SB1.B1_COD = SD1.D1_COD AND "
        cWhereSB1 += "SB1.D_E_L_E_T_ <> '*' AND "
        cWhereSB1 += "%"	
    EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Composicao do Order By de acordo com a ordem escolhida                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
cOrder := "%"
 	If nOrdem == 1
    	cOrder += "1,2,3,4,5,6,7"		
    Else
    cOrder += "1,2,3,4,5,6"		
    Endif	
cOrder += "%"

BeginSql Alias cAliasSD1

	SELECT %Exp:cSelect%
	 	  	D1_DTDIGIT,D1_COD,D1_QUANT,D1_VUNIT,D1_TOTAL,D1_VALFRE,D1_DESPESA,D1_SEGURO,D1_PEDIDO,D1_ITEMPC,
	 	  	%Exp:cSelect3%	 			
 			D1_TES,D1_IPI,D1_PICM,D1_TIPO,D1_CF,D1_GRUPO,D1_LOCAL,D1_ITEM,D1_EMISSAO,D1_VALDESC,D1_ICMSRET,D1_VALICM,D1_VALIPI,
 			%Exp:cSelect1%
 		    F1_FILIAL,F1_MOEDA,F1_TXMOEDA,F1_DTDIGIT,F1_TIPO,F1_COND,F1_VALICM,F1_VALIPI,F1_VALIMP1,
		    F1_FRETE,F1_DESPESA,F1_SEGURO,F1_DESCONT,F1_VALMERC,F1_DOC,F1_SERIE,F1_EMISSAO,F1_FORNECE,F1_LOJA,F1_VALBRUT,
		    %Exp:cSelect2%
		    A1_NOME RAZAO,A1_MUN RAZMUNI,SD1.R_E_C_N_O_ SD1RECNO 

	FROM %table:SF1% SF1,%table:SD1% SD1,%table:SA1% SA1 %Exp:cFrom%

	WHERE 	SF1.F1_FILIAL  =  %xFilial:SF1% 	AND
	      	%Exp:cWhereSF1%	  	    	        AND			
	      	SF1.%NotDel%          		        AND						   		  
	      	SD1.D1_FILIAL  =  	%xFilial:SD1%  	AND
	      	SD1.D1_DOC     = 	SF1.F1_DOC     	AND
	      	SD1.D1_SERIE   = 	SF1.F1_SERIE    AND
			SD1.D1_FORNECE = 	SF1.F1_FORNECE  AND
			SD1.D1_LOJA    = 	SF1.F1_LOJA     AND
			SD1.D1_TIPO IN ('D','B') 			AND 
			SD1.D1_TIPODOC = SF1.F1_TIPODOC 	AND 
			SD1.%NotDel%          		        AND						   		  
			%Exp:cWhereSB1%		    	           							
			SA1.A1_FILIAL  =  %xFilial:SA1% 	AND
			SA1.A1_COD     = 	 SD1.D1_FORNECE 	AND
			SA1.A1_LOJA    =  SD1.D1_LOJA    	AND 
			SA1.%NotDel%          		        AND						   		  
			SD1.D1_COD     >= %Exp:mv_par01%	AND		
			SD1.D1_COD     <= %Exp:mv_par02%	AND
			SD1.D1_DTDIGIT >= %Exp:Dtos(mv_par03)% AND 
			SD1.D1_DTDIGIT <= %Exp:Dtos(mv_par04)% AND 
			SD1.D1_GRUPO   >= %Exp:mv_par06%	AND		
			SD1.D1_GRUPO   <= %Exp:mv_par07%	AND                      
   			SD1.D1_FORNECE >= %Exp:mv_par08%	AND		
			SD1.D1_FORNECE <= %Exp:mv_par09%	AND
			SD1.D1_LOCAL   >= %Exp:mv_par10%	AND		
			SD1.D1_LOCAL   <= %Exp:mv_par11%	AND		
			SD1.D1_DOC     >= %Exp:mv_par12%	AND		
			SD1.D1_DOC     <= %Exp:mv_par13%	AND
			%Exp:cIdWhere%	
			SD1.D1_TES     >= %Exp:mv_par16%	AND		
			SD1.D1_TES     <= %Exp:mv_par17%	   		

    UNION
    
	SELECT %Exp:cSelect%
	 	  	D1_DTDIGIT,D1_COD,D1_QUANT,D1_VUNIT,D1_TOTAL,D1_VALFRE,D1_DESPESA,D1_SEGURO,D1_PEDIDO,D1_ITEMPC,
 			%Exp:cSelect3%		 	  	
 			D1_TES,D1_IPI,D1_PICM,D1_TIPO,D1_CF,D1_GRUPO,D1_LOCAL,D1_ITEM,D1_EMISSAO,D1_VALDESC,D1_ICMSRET,D1_VALICM,D1_VALIPI,
 			%Exp:cSelect1%
 		    F1_FILIAL,F1_MOEDA,F1_TXMOEDA,F1_DTDIGIT,F1_TIPO,F1_COND,F1_VALICM,F1_VALIPI,F1_VALIMP1,
		    F1_FRETE,F1_DESPESA,F1_SEGURO,F1_DESCONT,F1_VALMERC,F1_DOC,F1_SERIE,F1_EMISSAO,F1_FORNECE,F1_LOJA,F1_VALBRUT,
		    %Exp:cSelect2%
		    A2_NOME RAZAO,A2_MUN RAZMUNI,SD1.R_E_C_N_O_ SD1RECNO 
		    
	FROM %table:SF1% SF1,%table:SD1% SD1,%table:SA2% SA2 %Exp:cFrom%

	WHERE 	SF1.F1_FILIAL  =  %xFilial:SF1% 	AND
	      	%Exp:cWhereSF1%	  	    	        AND			
	      	SF1.%NotDel%          		        AND						   		  
	      	SD1.D1_FILIAL  = %xFilial:SD1%  	AND
	      	SD1.D1_DOC     = 	SF1.F1_DOC     	AND
	      	SD1.D1_SERIE   = 	SF1.F1_SERIE    AND
			SD1.D1_FORNECE = 	SF1.F1_FORNECE  AND
			SD1.D1_LOJA    = 	SF1.F1_LOJA     AND
			SD1.D1_TIPO NOT IN ('D','B') 		AND 
			SD1.D1_TIPODOC = SF1.F1_TIPODOC 	AND 
			SD1.%NotDel%          		        AND						   		  
			%Exp:cWhereSB1%	  	    	           							
			SA2.A2_FILIAL  =  %xFilial:SA2% 	AND
			SA2.A2_COD     = 	SD1.D1_FORNECE 	AND
			SA2.A2_LOJA    =   	SD1.D1_LOJA    	AND 
			SA2.%NotDel%          		        AND						   		  
			SD1.D1_COD     >= %Exp:mv_par01%	AND		
			SD1.D1_COD     <= %Exp:mv_par02%	AND
			SD1.D1_DTDIGIT >= %Exp:Dtos(mv_par03)% AND 
			SD1.D1_DTDIGIT <= %Exp:Dtos(mv_par04)% AND 
			SD1.D1_GRUPO   >= %Exp:mv_par06%	AND		
			SD1.D1_GRUPO   <= %Exp:mv_par07%	AND                      
   			SD1.D1_FORNECE >= %Exp:mv_par08%	AND		
			SD1.D1_FORNECE <= %Exp:mv_par09%	AND
			SD1.D1_LOCAL   >= %Exp:mv_par10%	AND		
			SD1.D1_LOCAL   <= %Exp:mv_par11%	AND		
			SD1.D1_DOC     >= %Exp:mv_par12%	AND		
			SD1.D1_DOC     <= %Exp:mv_par13%	AND
			%Exp:cIdWhere%	
			SD1.D1_TES     >= %Exp:mv_par16%	AND		
			SD1.D1_TES     <= %Exp:mv_par17%	   			   		  

	ORDER BY %Exp:cOrder%		
		
EndSql 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

oSection2:SetParentQuery()
oSection3:SetParentQuery()
oSection4:SetParentQuery()

cFilUsrSD1:= oSection1:GetAdvplExp()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbselectArea(cAliasSD1)
oReport:SetMeter(SD1->(LastRec()))

If !lquery
	(cAliasSF1)->(dbseek( xFilial("SF1") + (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA)) //posiciona o cabecalho da nota
Endif

nTaxa   := (cAliasSF1)->F1_TXMOEDA
nMoeda  := (cAliasSF1)->F1_MOEDA
dDtDig  := (cAliasSF1)->F1_DTDIGIT
cDocAnt := (cAliasSD1)->D1_FILIAL + (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA

While !oReport:Cancel() .And. (cAliasSD1)->(!Eof()) .And. (cAliasSD1)->D1_FILIAL == xFilial("SD1") 

	lFiltro := .T.  
	nCount++
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se cancelado pelo usuario                            	     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If oReport:Cancel()
		Exit
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica moeda nao imprimir com moeda diferente da escolhida  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par19 == 2
		if if((cAliasSF1)->F1_MOEDA == 0,1,(cAliasSF1)->F1_MOEDA) != mv_par18
			lFiltro := .F.
		Endif
	Endif
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Despreza Nota Fiscal sem TES de acordo com parametro         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par22 == 2 .And. Empty(D1_TES)
		lFiltro := .F.
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro escolhido                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cAliasSD1)
	If !Empty(cFilUsrSD1)
	    If !(&(cFilUsrSD1))
			lFiltro := .F.
    	EndIf   
	EndIf

	If lFiltro
		
		lImp := .T.
		cDescri := ""
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o parametro para imprimir a descricao do produto    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Empty(mv_par21)
			mv_par21 := "B1_DESC"
		ElseIf AllTrim(mv_par21) == "B5_CEME" // Impressao da descricao cientifica do Produto.
			dbSelectArea("SB5")
			dbSetOrder(1)
			If SB5->(dbSeek( xFilial("SB5")+(cAliasSD1)->D1_COD ))
				cDescri := Alltrim(SB5->B5_CEME)
			EndIf
		ElseIf AllTrim(mv_par21) == "C7_DESCRI" // Impressao da descricao do Produto no pedido de compras.
			dbSelectArea("SC7")
			dbSetOrder(4)
			If SC7->(dbSeek( xFilial("SC7")+(cAliasSD1)->D1_COD+(cAliasSD1)->D1_PEDIDO+(cAliasSD1)->D1_ITEMPC ))
				cDescri := Alltrim(SC7->C7_DESCRI)
			EndIf
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a Quebra da Linha de descricao para todas ordens do Rela.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lDescLine == .T.

			// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
			If nTpImp == 6
				If oReport:Row() > (nPageWidth-500)
					oSection1:SetPageBreak(.T.)
				Else
					oSection1:SetPageBreak(.F.)
				EndIf
			EndIf

			If nOrdem == 1 .And. mv_par05 == 1
				
				If (cAliasSD1)->D1_TIPO $ "BD"
					If !lQuery
						(cAliasSA1)->(dbSeek(xFilial("SA1") + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA))
						oSection1:Cell("A2_NOME"):SetValue((cAliasSA1)->A1_NOME)
                    Else
						oSection1:Cell("A2_NOME"):SetValue((cAliasSA1)->RAZAO)
					Endif                                                       
				Else
					If !lQuery
						(cAliasSA2)->(dbSeek(xFilial("SA2") + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA))
						oSection1:Cell("A2_NOME"):SetValue((cAliasSA2)->A2_NOME)
					Else
						oSection1:Cell("A2_NOME"):SetValue((cAliasSA1)->RAZAO)
					Endif
				EndIf

				oSection1:Init() 
				oSection1:PrintLine()
				
			Elseif nOrdem == 2
				
				// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
				If nTpImp == 6
					If oReport:Row() > (nPageWidth-500)
						oSection1:SetPageBreak(.T.)
					Else
						oSection1:SetPageBreak(.F.)
					EndIf
				EndIf

				 If !lPlanTab 
							If !lQuery .Or. lEasy
						 		(cAliasSB1)->(dbSeek(xFilial("SB1") + (cAliasSD1)->D1_COD))
							EndIf
						 	
							If Empty(cDescri) .Or. AllTrim(mv_par21) == "B1_DESC" // Impressao da descricao generica do Produto.
								cDescri := Alltrim((cAliasSB1)->B1_DESC)
							EndIf
							 
							oSection1:Cell("cDescri"):SetValue(cDescri)
			
							oSection1:Init() 
							oSection1:PrintLine()
							
							cCodAnt   := (cAliasSD1)->D1_COD
							nTotProd  := 0
							nTotQuant := 0
					
				 Else          
							While (cAliasSD1)->(!EOF())

								If !lQuery .Or. lEasy
									(cAliasSB1)->(dbSeek(xFilial("SB1") + (cAliasSD1)->D1_COD))
								EndIf			 	
	
								If Empty(cDescri) .Or. AllTrim(mv_par21) == "B1_DESC" // Impressao da descricao generica do Produto.
									cDescri := Alltrim((cAliasSB1)->B1_DESC)
								EndIf
								
								oSection1:Cell("cDescri"):SetValue(cDescri)
								oSection1:Cell("A2_NOME"):SetValue((cAliasSA1)->RAZAO)
								If cPaisLoc == "BRA"
									oSection1:Cell("nValIcm1"):SetValue((cAliasSD1)->D1_VALICM)
									oSection1:Cell("nValIpi1"):SetValue((cAliasSD1)->D1_VALIPI)
								Endif	
								oSection1:Cell("nTotNF1"):SetValue((cAliasSD1)->D1_TOTAL)
								if cPaisLoc == 'BRA'
									oSection1:Cell("D1_CF"):SetValue((cAliasSD1)->D1_CF)
									oSection1:Cell("D1_TES"):SetValue((cAliasSD1)->D1_TES)
									oSection1:Cell("D1_PICM"):SetValue((cAliasSD1)->D1_PICM)
									oSection1:Cell("D1_IPI"):SetValue((cAliasSD1)->D1_IPI)					              
								Endif
								oSection1:Init() 
								oSection1:PrintLine()
					
								cCodAnt   := (cAliasSD1)->D1_COD
								nTotProd  := 0
								nTotQuant := 0
														
							(cAliasSD1)->(DbSkip())
						   					   				    
							EndDo
							oSection1:Finish()
				 EndIf
				
			Elseif nOrdem == 3 .Or. nOrdem == 4

				// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
				If nTpImp == 6
					If oReport:Row() > (nPageWidth-500)
						oSection1:SetPageBreak(.T.)
					Else
						oSection1:SetPageBreak(.F.)
					EndIf
				EndIf

				If mv_par05 == 1
				   	oSection1:Cell("A2_NOME"):SetValue((cAliasSA2)->RAZAO)
					oSection1:Cell("A2_NOME"):SetValue((cAliasSA1)->RAZAO)
					oSection1:Init() 
					oSection1:PrintLine()
				Endif	
				
				dDataAnt := IIf(nOrdem == 3,(cAliasSD1)->D1_DTDIGIT,(cAliasSD1)->D1_EMISSAO)
			Elseif nOrdem == 5
				If mv_par05 == 1

					// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
					If nTpImp == 6
						If oReport:Row() > (nPageWidth-500)
							oSection1:SetPageBreak(.T.)
						Else
							oSection1:SetPageBreak(.F.)
						EndIf
					EndIf

					If (cAliasSD1)->D1_TIPO $ "BD"
						If !lquery
							(cAliasSA1)->(dbSeek(xFilial("SA1") + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA))
							oSection1:Cell("A2_NOME"):SetValue((cAliasSA1)->A1_NOME)
        	            Else
							oSection1:Cell("A2_NOME"):SetValue((cAliasSA1)->RAZAO)
						Endif
					Else
						If !lquery
							(cAliasSA2)->(dbSeek(xFilial("SA2") + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA))
							oSection1:Cell("A2_NOME"):SetValue((cAliasSA2)->A2_NOME)
						Else
							oSection1:Cell("A2_NOME"):SetValue((cAliasSA1)->RAZAO)
						Endif
					EndIf

					oSection1:Init() 
					oSection1:PrintLine()
				Endif
				cFornAnt := (cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA
			Endif
			lDescLine := .F.
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciona o F4 para todas as ordens quando nao for query TES  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		(cAliasSF4)->(dbSeek(xFilial("SF4") + (cAliasSD1)->D1_TES))
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Impressao do corpo do relatorio para todas as ordens          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nOrdem == 1 .Or. nOrdem == 3 .Or. nOrdem == 4 .Or. nOrdem ==5
			
			If mv_par05 == 1
				
				If !lQuery .Or. lEasy
					(cAliasSB1)->(dbSeek(xFilial("SB1") + (cAliasSD1)->D1_COD))
				EndIf
				
				If Empty(cDescri) .Or. AllTrim(mv_par21) == "B1_DESC" // Impressao da descricao generica do Produto.
					cDescri := Alltrim((cAliasSB1)->B1_DESC)
				EndIf
				
				If Empty(cDescri) 
					cDescri := Space(28)
				Endif
				
				oSection2:Cell("cDescri"):SetValue(cDescri)

				If cPaisLoc <> "BRA"
					
					nImpInc	  := 0
					nImpNoInc := 0
					nImpos	  := 0
					
					aImpostos := TesImpInf((cAliasSD1)->D1_TES)
					For nY := 1 to Len(aImpostos)
						cCampImp := (cAliasSD1)+"->" + (aImpostos[nY][2])
						nImpos   := &cCampImp
						nImpos   := xmoeda(nImpos,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
						If ( aImpostos[nY][3] == "1" )
							nImpInc	+= nImpos
						Else
							If aImpostos[nY][3] == "2" 
								nImpinc -= nImpos
							Else
								nImpNoInc += nImpos
							Endif
						EndIf
					Next
					oSection2:Cell("nImpNoInc"):SetPicture(TM(nImpNoInc,9))
					oSection2:Cell("nImpInc"):SetPicture(TM(nImpInc,9))
					
					oSection2:Cell("nImpNoInc"):SetValue(nImpNoInc)
					oSection2:Cell("nImpInc"):SetValue(nImpInc)
					
					nValImpInc	+= nImpInc
					nValImpNoInc+= nImpNoInc
					nValMerc 	:= nValMerc + xmoeda((cAliasSD1)->D1_TOTAL,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
					
					nTgImpInc 	+= nImpInc
					nTgImpNoInc += nImpNoInc
					nTotGeral 	:= nTotGeral + xmoeda((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
					
					nValMerc    += nImpInc
					nTotGeral   += nImpInc
 				Else
                    nValIcm   += (cAliasSD1)->D1_VALICM
                    nValIpi   += (cAliasSD1)->D1_VALIPI						
                    nTgerIcm  += (cAliasSD1)->D1_VALICM
                    nTgerIpi  += (cAliasSD1)->D1_VALIPI

					// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
					If nTpImp == 6
						If oReport:Row() > (nPageWidth-500)
							oSection2:SetPageBreak(.T.)
						Else
							oSection2:SetPageBreak(.F.)
						EndIf
					EndIf

					If (cAliasSF4)->F4_AGREG != "N"
						nValMerc  := nValMerc + (cAliasSD1)->D1_TOTAL + IIF(!(cAliasSF4)->F4_INCSOL$"A|N",(cAliasSD1)->D1_ICMSRET,0)
						nTotGeral := nTotGeral + (cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC + IIF(!(cAliasSF4)->F4_INCSOL$"A|N",(cAliasSD1)->D1_ICMSRET,0)
			            If (cAliasSF4)->F4_AGREG = "I"
				           nValMerc  += (cAliasSD1)->D1_VALICM
				           nTotGeral += (cAliasSD1)->D1_VALICM
                        Endif 
					Else 
						nTotGeral := nTotGeral - (cAliasSD1)->D1_VALDESC + IIF((cAliasSF4)->F4_INCSOL!="A",(cAliasSD1)->D1_ICMSRET,0)
					Endif
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Soma valor do IPI caso a nota nao seja compl. de IPI    	 ³
					//³ e o TES Calcula IPI nao seja "R"                             ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If (cAliasSF4)->(dbSeek(xFilial("SF4") + (cAliasSD1)->D1_TES))
						If (cAliasSD1)->D1_TIPO != "P" .And. (cAliasSF4)->F4_IPI != "R"
							nValMerc  += (cAliasSD1)->D1_VALIPI
							nTotGeral += (cAliasSD1)->D1_VALIPI
						EndIf
					Else
						If (cAliasSD1)->D1_TIPO != "P"
							nValMerc  += (cAliasSD1)->D1_VALIPI
							nTotGeral += (cAliasSD1)->D1_VALIPI
						EndIf
					EndIf
				EndIf

				oSection2:Cell("nVunit"):SetValue(xmoeda((cAliasSD1)->D1_VUNIT,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa))
				oSection2:Cell("nVtotal"):SetValue(xmoeda((cAliasSD1)->D1_TOTAL,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa))
				oSection2:Cell("D1_VALIPI"):SetValue((cAliasSD1)->D1_VALIPI)
				oSection2:Cell("D1_VALFRE"):SetValue((cAliasSD1)->D1_VALFRE)
				oSection2:Cell("D1_DESPESA"):SetValue((cAliasSD1)->D1_DESPESA)
				oSection2:Cell("D1_VALDESC"):SetValue((cAliasSD1)->D1_VALDESC)		
				oSection2:Cell("D1_SEGURO"):SetValue((cAliasSD1)->D1_SEGURO)																	

				nValDesc  += xmoeda((cAliasSD1)->D1_VALDESC,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
				nTotDesco += xmoeda((cAliasSD1)->D1_VALDESC,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
				oSection2:Cell("A2_NOME"):SetValue((cAliasSA2)->RAZAO)
				oSection2:Cell("A2_NOME"):SetValue((cAliasSA1)->RAZAO)
				oSection2:Init() 
				oSection2:PrintLine()
				
			ElseIf mv_par05 == 2
				
				If cPaisLoc <> "BRA"
					aImpostos := TesImpInf((cAliasSD1)->D1_TES)
					For nY := 1 to Len(aImpostos)
						cCampImp := (cAliasSD1)+"->" + (aImpostos[nY][2])
						nImpos   := &cCampImp
						nImpos   := xmoeda(nImpos,(cAliasSF1)->F1_MOEDA,mv_par18,(cAliasSF1)->F1_DTDIGIT,nDecs+1,(cAliasSF1)->F1_TXMOEDA)
						If cPaisLoc == "PER"
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Se for Peru, realiza os calculos de impostos como no         ³
							//³ relatorio em modelo nao personalizado (R3)                   ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If ( aImpostos[nY][3] == "1" )
								nImpInc	+= nImpos
							Else
								If aImpostos[nY][3] == "2" 
									nImpInc -= nImpos
								Else
									nImpNoInc += nImpos
								Endif
							EndIf
						Else
							If ( aImpostos[nY][3] == "1" )
								If Len(aImpostos[nY]) >= 12
									If( aImpostos[nY][1] == "IVA" .Or. aImpostos[nY][12] == "IVA" )
										nImpInc	+= nImpos
									EndIf
								Else
									nImpInc	+= nImpos
								EndIf
							Else
								If aImpostos[nY][3] == "2"
									If Len(aImpostos[nY]) >= 12 
										If( aImpostos[nY][1] == "IVA" .Or. aImpostos[nY][12] == "IVA" )
											nImpInc -= nImpos
										EndIf
									Else
										nImpInc -= nImpos
									EndIf
								Else
									If Len(aImpostos[nY]) >= 12
										If( aImpostos[nY][1] == "IVA" .Or. aImpostos[nY][12] == "IVA" )
											nImpNoInc += nImpos
										EndIf
									Else
										nImpNoInc += nImpos
									EndIf
								Endif
							EndIf
						EndIf	
					Next
					nValMerc := nValMerc + xmoeda((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC,(cAliasSF1)->F1_MOEDA,mv_par18,(cAliasSF1)->F1_DTDIGIT,nDecs+1,(cAliasSF1)->F1_TXMOEDA)
				Else

                    nValIcm  += (cAliasSD1)->D1_VALICM
                    nValIpi  += (cAliasSD1)->D1_VALIPI
					nTotQtd   += (cAliasSD1)->D1_QUANT
					If (cAliasSF4)->F4_AGREG != "N"
						nValMerc := nValMerc + (cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC + IIF((cAliasSF4)->F4_INCSOL!="A",(cAliasSD1)->D1_ICMSRET,0)
			            If (cAliasSF4)->F4_AGREG = "I"
				            nValMerc += (cAliasSD1)->D1_VALICM
                        Endif 
					Else	
						nValMerc := nValMerc - (cAliasSD1)->D1_VALDESC + IIF((cAliasSF4)->F4_INCSOL!="A",(cAliasSD1)->D1_ICMSRET,0)
					Endif
					
					If (cAliasSF4)->(dbSeek(xFilial("SF4") + (cAliasSD1)->D1_TES))
						nValMerc += IF((cAliasSF1)->F1_TIPO != "P" .And. (cAliasSF4)->F4_IPI != "R",(cAliasSD1)->D1_VALIPI,0)
					Else
						nValMerc += IF((cAliasSF1)->F1_TIPO != "P",(cAliasSD1)->D1_VALIPI,0)
					EndIf
				EndIf
			Endif
		Else
			If nOrdem <> 5 .and. (!lPlanTab .AND. nOrdem == 2)			
				If (cAliasSD1)->D1_TIPO $ "BD"
					If !lquery
						(cAliasSA1)->(dbSeek(xFilial("SA1") + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA))
						oSection2:Cell("A2_NOME"):SetValue((cAliasSA1)->A1_NOME)
      				Else
						oSection2:Cell("A2_NOME"):SetValue((cAliasSA1)->RAZAO)
					Endif
				Else
					If !lquery
					(cAliasSA2)->(dbSeek(xFilial("SA2") + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA))
						oSection2:Cell("A2_NOME"):SetValue((cAliasSA2)->A2_NOME)
					Else
						oSection2:Cell("A2_NOME"):SetValue((cAliasSA1)->RAZAO)
					Endif
				EndIf	
			EndIf
			   If !lPlanTab .AND. nOrdem == 2			
					oSection2:Cell("nVunit"):SetValue(xmoeda((cAliasSD1)->D1_VUNIT,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa))
					oSection2:Cell("nVtotal"):SetValue(xmoeda((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC + IIF(!(cAliasSF4)->F4_INCSOL$"A|N",(cAliasSD1)->D1_ICMSRET,0),nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa))			
					If (cAliasSF4)->F4_AGREG != "N"
						nTotProd  += xmoeda((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC + IIF(!(cAliasSF4)->F4_INCSOL$"A|N",(cAliasSD1)->D1_ICMSRET,0),nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
						nTotQuant += (cAliasSD1)->D1_QUANT
						nTotData  += xmoeda((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC + IIF(!(cAliasSF4)->F4_INCSOL$"A|N",(cAliasSD1)->D1_ICMSRET,0),nMoeda,mv_par18,,nDecs+1,nTaxa)
						nTotForn  += xmoeda((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC + IIF(!(cAliasSF4)->F4_INCSOL$"A|N",(cAliasSD1)->D1_ICMSRET,0),nMoeda,mv_par18,,nDecs+1,nTaxa)
					    If (cAliasSF4)->F4_AGREG = "I"
						    nTotProd  += xmoeda((cAliasSD1)->D1_VALICM,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
						    nTotData  += xmoeda((cAliasSD1)->D1_VALICM,nMoeda,mv_par18,,nDecs+1,nTaxa)
						    nTotForn  += xmoeda((cAliasSD1)->D1_VALICM,nMoeda,mv_par18,,nDecs+1,nTaxa)
		                Endif 
					Else
						nTotProd  -= xmoeda((cAliasSD1)->D1_VALDESC + IIF(!(cAliasSF4)->F4_INCSOL$"A|N",(cAliasSD1)->D1_ICMSRET,0),nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
						nTotData  -= xmoeda((cAliasSD1)->D1_VALDESC + IIF(!(cAliasSF4)->F4_INCSOL$"A|N",(cAliasSD1)->D1_ICMSRET,0),nMoeda,mv_par18,,nDecs+1,nTaxa)				
						nTotForn  -= xmoeda((cAliasSD1)->D1_VALDESC + IIF(!(cAliasSF4)->F4_INCSOL$"A|N",(cAliasSD1)->D1_ICMSRET,0),nMoeda,mv_par18,,nDecs+1,nTaxa)				
					Endif
				EndIf
			If cPaisLoc <> "BRA" // Inserido BOPS 92436
				aImpostos := TesImpInf((cAliasSD1)->D1_TES)
				For nY := 1 to Len(aImpostos)
					cCampImp := (cAliasSD1)+"->" + (aImpostos[nY][2])
					nImpos   := &cCampImp
					nImpos   := xmoeda(nImpos,(cAliasSF1)->F1_MOEDA,mv_par18,(cAliasSF1)->F1_DTDIGIT,nDecs+1,(cAliasSF1)->F1_TXMOEDA)
					If ( aImpostos[nY][3] == "1" )
						nImpInc	+= nImpos
					Else
						If aImpostos[nY][3] == "2" 
							nImpInc -= nImpos
						Else
							nImpNoInc += nImpos
						Endif
					EndIf
				Next
				nValMerc := nValMerc + xmoeda(D1_TOTAL - D1_VALDESC,(cAliasSF1)->F1_MOEDA,mv_par18,(cAliasSF1)->F1_DTDIGIT,nDecs+1,(cAliasSF1)->F1_TXMOEDA)
			Else
                nValIcm  += (cAliasSD1)->D1_VALICM
                nValIpi  += (cAliasSD1)->D1_VALIPI
			
 				If (cAliasSF4)->F4_AGREG != "N"
					nValMerc := nValMerc + (cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC + IIF((cAliasSF4)->F4_INCSOL!="A",(cAliasSD1)->D1_ICMSRET,0)
		            If (cAliasSF4)->F4_AGREG = "I"
			            nValMerc += (cAliasSD1)->D1_VALICM
                    Endif 
				Else	
					nValMerc := nValMerc - (cAliasSD1)->D1_VALDESC + IIF((cAliasSF4)->F4_INCSOL!="A",(cAliasSD1)->D1_ICMSRET,0)
				Endif
					
				If (cAliasSF4)->(dbSeek(xFilial("SF4") + (cAliasSD1)->D1_TES))
					nValMerc += IF((cAliasSF1)->F1_TIPO != "P" .And. (cAliasSF4)->F4_IPI != "R",(cAliasSD1)->D1_VALIPI,0)
				Else
					nValMerc += IF((cAliasSF1)->F1_TIPO != "P",(cAliasSD1)->D1_VALIPI,0)
				EndIf
			EndIf
            lPrintLine:= .T.

			// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
			If nTpImp == 6
				If oReport:Row() > (nPageWidth-500)
					oSection2:SetPageBreak(.T.)
				Else
					oSection2:SetPageBreak(.F.)
				EndIf
			EndIf
         If !lPlanTab .AND. nOrdem == 2
			oSection2:Init() 
			oSection2:PrintLine()
         EndIf

		Endif
  		
		nTotFrete += xmoeda((cAliasSD1)->D1_VALFRE,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
		nTotSeguro+= xmoeda((cAliasSD1)->D1_SEGURO ,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
		nTotDesp  += xmoeda((cAliasSD1)->D1_DESPESA,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
			  		
		cFornF1     := (cAliasSF1)->F1_FORNECE
		cLojaF1     := (cAliasSF1)->F1_LOJA
		cDocF1      := (cAliasSF1)->F1_DOC
		cSerieF1    := Alltrim((cAliasSF1)->&(SerieNfId("SF1",3,"F1_SERIE")))
		cTipoF1     := (cAliasSF1)->F1_TIPO
		cCondF1     := (cAliasSF1)->F1_COND
		nMoedaF1    := (cAliasSF1)->F1_MOEDA
		nTxMoedaF1  := (cAliasSF1)->F1_TXMOEDA
		nFreteF1    := (cAliasSF1)->F1_FRETE
		nDespesaF1  := (cAliasSF1)->F1_DESPESA
		nSeguroF1   := (cAliasSF1)->F1_SEGURO
		nValTotF1   := (cAliasSF1)->F1_VALBRUT
		dEmissaoF1  := (cAliasSF1)->F1_EMISSAO
		dDtDigitF1  := (cAliasSF1)->F1_DTDIGIT
		If cPaisLoc == 'MEX'
			nF1VldC := (cAliasSF1)->F1_VALADI
		EndIf
		
		If lQuery
			cForCli  := (cAliasSF1)->RAZAO
			cMuni    := (cAliasSF1)->RAZMUNI
		Endif
	ElseIf nOrdem == 5 .And. "D1_TOTAL" $ cFilUsrSD1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Limpa os registros que não serao filtrados  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cFornAnt := (cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA

		lDescLine := .F.
		
		cFornF1     := ""
		cLojaF1     := ""
		cDocF1      := ""
		cSerieF1    := ""
		cTipoF1     := ""
		cCondF1     := ""
		nMoedaF1    := 0
		nTxMoedaF1  := 0
		nFreteF1    := 0
		nDespesaF1  := 0
		nSeguroF1   := 0
		nValTotF1   := 0
		dEmissaoF1  := ctod("  /  /  ")
		dDtDigitF1  := ctod("  /  /  ")
		
		If lQuery
			cForCli  := ""
			cMuni    := ""
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Incrementa a Regua de processamento no salto do registro      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cAliasSD1)
	dbSkip()

	oReport:IncMeter()
	
	If nOrdem == 1 .Or. nOrdem == 3 .Or. nOrdem == 4 .Or. nOrdem == 5
		
		If ((cAliasSD1)->D1_FILIAL + (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA <> cDocAnt) .Or. ( lPlanTab .And. nCount == 1 .And. MV_PAR05 == 1)
			
			If (nValIcm + nValMerc + nValIpi + nValImpInc + nValImpNoInc) > 0
				If mv_par05 == 1 //lista itens = Sim

					// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
					If nTpImp == 6
						If oReport:Row() > (nPageWidth-500)
							oSection3:SetPageBreak(.T.)
						Else
							oSection3:SetPageBreak(.F.)
						EndIf
					EndIf

					oSection3:Init() 
					oSection3:Cell("F1_COND"):SetValue(cCondF1)
					If cPaisLoc == "BRA"
						oSection3:Cell("nValIcm"):SetValue(nValIcm)
						oSection3:Cell("nValIpi"):SetValue(nValIpi)	
					Else
						oSection3:Cell("nValImpNoInc"):SetValue(nValImpNoInc)
						oSection3:Cell("nValImpInc"):SetValue(nValImpInc)						
					EndIf
					If lPlanTab
						If nCount == 1 .And. ((cAliasSD1)->D1_FILIAL + (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA) == cDocAnt
							oSection3:Cell("F1_COND"):Hide()
							If cPaisLoc == "BRA"
								oSection3:Cell("nValIcm"):Hide()
								oSection3:Cell("nValIpi"):Hide()	
							Else
								oSection3:Cell("nValImpNoInc"):Hide()
								oSection3:Cell("nValImpInc"):Hide()						
							EndIf	
						Else
							oSection3:Cell("F1_COND"):Show()
							If cPaisLoc == "BRA"
								oSection3:Cell("nValIcm"):Show()
								oSection3:Cell("nValIpi"):Show()	
							Else
								oSection3:Cell("nValImpNoInc"):Show()
								oSection3:Cell("nValImpInc"):Show()						
							EndIf
						EndIf
					EndIf
					oSection3:PrintLine()
					IF cPaisLoc == 'MEX'
						oSection4:Cell("nF1Vldi"):SetValue(nF1VldC)
						oSection2:Cell("D1_VALADI"):SetValue((cAliasSD1)->D1_VALADI)
					EndIF
					oSection4:Cell("nFrete"):SetValue(nTotFrete)
					oSection4:Cell("nDespesa"):SetValue(nTotDesp+nTotSeguro)
					oSection4:Cell("nDesconto"):SetValue(nValDesc)
					If mv_par20 == 2
						oSection4:Cell("nTotNF"):SetValue((nValMerc - nValDesc) + nTotDesp + nTotFrete + nTotSeguro)
						nTotGeral := nTotGeral + nTotDesp + nTotFrete + nTotSeguro
					Else
						oSection4:Cell("nTotNF"):SetValue(xmoeda(nValTotF1,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa))
						nTotGeral := nTotGeral - (nValMerc - nValDesc) + xmoeda( nValTotF1 ,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
					EndIf
					If lPlanTab
						If nCount == 1 .And. ((cAliasSD1)->D1_FILIAL + (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA) == cDocAnt
							oSection4:Cell("nFrete"):Hide()
							oSection4:Cell("nDespesa"):Hide()
							oSection4:Cell("nDesconto"):Hide()
							oSection4:Cell("nTotNF"):Hide()
						Else
							oSection4:Cell("nFrete"):Show()
							oSection4:Cell("nDespesa"):Show()
							oSection4:Cell("nDesconto"):Show()
							oSection4:Cell("nTotNF"):Show()
						EndIf
					EndIf

					oSection4:Init()
					oSection4:PrintLine()
					oReport:SkipLine()
					oReport:FatLine()

					oSection1:Finish()
					oSection2:Finish()
					oSection3:Finish()
					oSection4:Finish()

				ElseIf mv_par05 == 2
					
						// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
						If nTpImp == 6
							If oReport:Row() > (nPageWidth-500)
								oSection1:SetPageBreak(.T.)
							Else
								oSection1:SetPageBreak(.F.)
							EndIf
						EndIf

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Imprime a linha da nota fiscal                               ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						oSection1:Cell("D1_DOC"):SetValue(cDocF1)
						oSection1:Cell(SerieNfId("SD1",3,"D1_SERIE")):SetValue(cSerieF1)
						oSection1:Cell("D1_EMISSAO"):SetValue(dEmissaoF1)
						oSection1:Cell("D1_DTDIGIT"):SetValue(dDtDigitF1)
						oSection1:Cell("D1_FORNECE"):SetValue(cFornF1)
						oSection1:Cell("F1_COND"):SetValue(cCondF1)
						oSection1:Cell("D1_TIPO"):SetValue(cTipoF1)
						oSection1:Cell("D1_LOJA"):SetValue(cLojaF1)
						oSection1:Cell("D1_QUANT"):SetValue(nTotQtd)

						/* Neste trecho (lista itens = Não)
						 Só exibirá os itens abaixo se a impressão da planilha tem ordem = 2 (Por produto)*/
						If lPlanTab .AND. nOrdem != 2 .AND. cPaisLoc == 'BRA'
							oSection1:Cell("D1_CF"):Hide()
							oSection1:Cell("D1_TES"):Hide()
							oSection1:Cell("D1_PICM"):Hide()
							oSection1:Cell("D1_IPI"):Hide()
						EndIf
						
						If cPaisLoc == "BRA"
							oSection1:Cell("nValIcm1"):SetValue(nValIcm)
							oSection1:Cell("nValIpi1"):SetValue(nValIpi)
						Else
							oSection1:Cell("nImpInc1"):SetValue(nImpInc+nImpNoInc)
						Endif	
						If mv_par20 == 2
							oSection1:Cell("nTotNF1"):SetValue((nValMerc + nTotDesp + nTotFrete + nTotSeguro))
						Else
				   			oSection1:Cell("nTotNF1"):SetValue(xmoeda(nValTotF1,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa))
				 		Endif
						If cTipoF1 $ "BD"
							If !lQuery
								(cAliasSA1)->(dbSeek( xFilial("SA1") + (cAliasSF1)->F1_FORNECE + (cAliasSF1)->F1_LOJA ))
								oSection1:Cell("A2_NOME"):SetValue((cAliasSA1)->A1_NOME)
								oSection1:Cell("A2_MUN"):SetValue((cAliasSA1)->A1_MUN)
							Else
								oSection1:Cell("A2_NOME"):SetValue(cForCli)
								oSection1:Cell("A2_MUN"):SetValue(cMuni)
							Endif
						Else
							If !lQuery
								(cAliasSA2)->(dbSeek( xFilial("SA2") + (cAliasSF1)->F1_FORNECE + (cAliasSF1)->F1_LOJA))
								oSection1:Cell("A2_NOME"):SetValue((cAliasSA2)->A2_NOME)
								oSection1:Cell("A2_MUN"):SetValue((cAliasSA2)->A2_MUN)
							Else
								oSection1:Cell("A2_NOME"):SetValue(cForCli)
								oSection1:Cell("A2_MUN"):SetValue(cMuni)							
							Endif
						EndIf
						If ( cPaisLoc == "BRA" )
							nTgerIcm += nValIcm
							nTgerIpi += nValIpi
						Else
							nTgImpInc   += nImpInc
							nTgImpNoInc += nImpNoInc
						EndIf

	  					oSection1:Init() 
	  					oSection1:PrintLine()
					
						If mv_par20 == 2
							nTotGeral:= nTotGeral + nValMerc + ( nTotDesp + nTotFrete + nTotSeguro )
							nTotData := nTotData + nValMerc + ( nTotDesp + nTotFrete + nTotSeguro )
							nTotForn := nTotForn + nValMerc + ( nTotDesp + nTotFrete + nTotSeguro )
						Else
							nTotGeral:= nTotGeral + xmoeda(nValTotF1,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
							nTotData := nTotData + xmoeda(nValTotF1,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
							nTotForn := nTotForn + xmoeda(nValTotF1,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
						EndIf
                   
				   If nOrdem == 5
						If cFornAnt != (cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA 
							lDescLine := .T.
							oReport:SkipLine()
							nLin := oReport:Row()
							oReport:PrintText(STR0065,nLin)	//"TOTAL DO FORNECEDOR :"
							oReport:PrintText(TransForm(nTotForn,Pesqpict("SD1","D1_TOTAL")),nLin,oSection1:Cell('nTotNF1'):ColPos()-30)											
							oReport:SkipLine()
							oReport:FatLine()							
							oReport:SkipLine()
							nTotForn := 0
						Endif				
				   Else                                                      
						If (dDataAnt != (cAliasSD1)->D1_DTDIGIT) .And. nOrdem == 3 .Or. (dDataAnt != (cAliasSD1)->D1_EMISSAO) .And. nOrdem == 4 
							lDescLine := .T.
							oReport:SkipLine()
							nLin := oReport:Row()
							oReport:PrintText(STR0046,nLin)	//"TOTAL NA DATA : "
							oReport:PrintText(TransForm(nTotData,Pesqpict("SD1","D1_TOTAL")),nLin,oSection1:Cell('nTotNF1'):ColPos()-35)
							oReport:SkipLine()
							oReport:FatLine()
							oReport:SkipLine()
							nTotData := 0
						Endif	
					   EndIf
					
				Endif
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a linha totalizadora considerando as notas que nao   ³
			//³ filtradas considerando a soma do valor 0 ao total            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !lFiltro .And. nOrdem == 5 .And. "D1_TOTAL" $ cFilUsrSD1
				If mv_par20 == 2
					nTotGeral:= nTotGeral + nValMerc + ( nTotDesp + nTotFrete + nTotSeguro )
					nTotData := nTotData + nValMerc + ( nTotDesp + nTotFrete + nTotSeguro )
					nTotForn := nTotForn + nValMerc + ( nTotDesp + nTotFrete + nTotSeguro )
				Else
					nTotGeral:= nTotGeral + xmoeda(nValTotF1,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
					nTotData := nTotData + xmoeda(nValTotF1,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
					nTotForn := nTotForn + xmoeda(nValTotF1,nMoeda,mv_par18,dDtDig,nDecs+1,nTaxa)
				EndIf
	                    
              If nOrdem == 5
             		If nTotForn > 0
						If cFornAnt != (cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA 
							lDescLine := .T.
							oReport:SkipLine()
							nLin := oReport:Row()
							oReport:PrintText(STR0065,nLin)	//"TOTAL DO FORNECEDOR :"
							oReport:PrintText(TransForm(nTotForn,Pesqpict("SD1","D1_TOTAL")),nLin,oSection1:Cell('nTotNF1'):ColPos()-30)											
							oReport:SkipLine()
							oReport:FatLine()							
							oReport:SkipLine()
							nTotForn := 0
						Endif	
					EndIf			
              Else        
              		If nTotData > 0                                               
						If (dDataAnt != (cAliasSD1)->D1_DTDIGIT) .And. nOrdem == 3 .Or. (dDataAnt != (cAliasSD1)->D1_EMISSAO) .And. nOrdem == 4 
							lDescLine := .T.
							oReport:SkipLine()
							nLin := oReport:Row()
							oReport:PrintText(STR0046,nLin)	//"TOTAL NA DATA : "
							oReport:PrintText(TransForm(nTotData,Pesqpict("SD1","D1_TOTAL")),nLin,oSection1:Cell('nTotNF1'):ColPos()-35)
							oReport:SkipLine()
							oReport:FatLine()
							oReport:SkipLine()
					       nTotData := 0
						Endif
					EndIf	
              EndIf
           EndIf

			If ((cAliasSD1)->D1_FILIAL + (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA <> cDocAnt)
				nValIpi     := 0
				nValMerc    := 0
				nValDesc    := 0
				nTotDesp    := 0
				nTotFrete   := 0
				nTotSeguro  := 0
				nValIcm     := 0
				nValImpInc	:= 0
				nValImpNoInc:= 0
				nImpInc		:= 0
				nImpNoInc	:= 0
				nTotQtd     := 0
				If nOrdem <> 3 .Or. nOrdem <> 4 .Or. nOrdem <> 5
					lDescLine  := .T.
				EndIf
			EndIf

			cDocAnt := (cAliasSD1)->D1_FILIAL + (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA

		EndIf

	Elseif nOrdem == 2 .AND. !lPlanTab 
		
		If cCodant != (cAliasSD1)->D1_COD .And. lPrintLine
			lDescLine := .T.
			nLin := oReport:Row()
			oReport:PrintText(STR0041)	//"TOTAL DO PRODUTO : "
		   	oReport:PrintText(TransForm(nTotQuant,Pesqpict("SD1","D1_QUANT",15)),nLin,oSection2:Cell('D1_QUANT'):ColPos()-53)	
			oReport:PrintText(TransForm(nTotProd,Pesqpict("SD1","D1_TOTAL")),nLin,oSection2:Cell('nVtotal'):ColPos()-73)	

			// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
			If nTpImp == 6
				If oReport:Row() > (nPageWidth-500)
					oSection3:SetPageBreak(.T.)
				Else
					oSection3:SetPageBreak(.F.)
				EndIf
			EndIf

			oSection3:Init() 
			If ( cPaisLoc == "BRA" )
				oSection3:Cell("nValIcm"):SetValue(nValIcm)
				oSection3:Cell("nValIpi"):SetValue(nValIpi)	
				oSection3:Cell("nTotImp"):SetValue(nValMerc + nTotDesp + nTotFrete + nTotSeguro)					
				
				nTgerIcm += nValIcm
				nTgerIpi += nValIpi
			Else
				oSection3:Cell("nValImpNoInc"):SetValue(nImpNoInc)
				oSection3:Cell("nValImpInc"):SetValue(nImpInc)						
				oSection3:Cell("nTotImp"):SetValue(nValMerc + nTotDesp + nTotFrete + nTotSeguro)					
				
				nTgImpInc   += nImpInc
				nTgImpNoInc += nImpNoInc
			EndIf
			nTotGerImp += nValMerc + ( nTotDesp + nTotFrete + nTotSeguro )

			oSection3:PrintLine()
			oReport:FatLine()
			
            oSection1:Finish() 
            oSection2:Finish() 
            oSection3:Finish() 
		 	
			nTotQger   += nTotQuant
			nTotGeral  += nTotProd
			nValIpi     := 0
			nValMerc    := 0
			nValDesc    := 0
			nTotDesp    := 0
			nTotFrete   := 0
			nTotSeguro  := 0
			nValIcm     := 0
			nValImpInc	:= 0
			nValImpNoInc:= 0
			nImpInc		:= 0
			nImpNoInc	:= 0
	        lPrintLine := .F.
		Endif
		
	Elseif nOrdem == 3 .Or. nOrdem == 4 
		
		If dDataAnt != Iif(nOrdem == 3,(cAliasSD1)->D1_DTDIGIT,(cAliasSD1)->D1_EMISSAO) .And. lPrintLine // nTotData > 0 
			lDescLine := .T.
			oReport:SkipLine()
			nLin := oReport:Row()
			oReport:PrintText(STR0046,nLin)	//"TOTAL NA DATA : "
			oReport:PrintText(TransForm(nTotData,Pesqpict("SD1","D1_TOTAL")),nLin,oSection2:Cell('nVtotal'):ColPos()-80)				
			oReport:SkipLine()

			// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
			If nTpImp == 6
				If oReport:Row() > (nPageWidth-500)
					oSection3:SetPageBreak(.T.)
				Else
					oSection3:SetPageBreak(.F.)
				EndIf
			EndIf

			oSection3:Init() 
			If ( cPaisLoc == "BRA" )
				oSection3:Cell("nValIcm"):SetValue(nValIcm)
				oSection3:Cell("nValIpi"):SetValue(nValIpi)	
				oSection3:Cell("nTotImp"):SetValue(nValMerc + nTotDesp + nTotFrete + nTotSeguro)					
				
				nTgerIcm += nValIcm
				nTgerIpi += nValIpi
			Else
				oSection3:Cell("nValImpNoInc"):SetValue(nImpNoInc)
				oSection3:Cell("nValImpInc"):SetValue(nImpInc)						
				oSection3:Cell("nTotImp"):SetValue(nValMerc + nTotDesp + nTotFrete + nTotSeguro)									
				
				nTgImpInc   += nImpInc
				nTgImpNoInc += nImpNoInc
			EndIf
			nTotGerImp += nValMerc + ( nTotDesp + nTotFrete + nTotSeguro )

			oSection3:PrintLine()
			oReport:FatLine()
			oReport:SkipLine()
			
            oSection1:Finish() 
            oSection2:Finish() 
            oSection3:Finish() 			
			
			nTotGeral += nTotData
			dDataAnt := Iif(nOrdem == 3,(cAliasSD1)->D1_DTDIGIT,(cAliasSD1)->D1_EMISSAO)
			nTotData := 0
			nValIpi     := 0
			nValMerc    := 0
			nValDesc    := 0
			nTotDesp    := 0
			nTotFrete   := 0
			nTotSeguro  := 0
			nValIcm     := 0
			nValImpInc	:= 0
			nValImpNoInc:= 0
			nImpInc		:= 0
			nImpNoInc	:= 0
            lPrintLine := .F.
		Endif

	Elseif nOrdem == 5 
		
		If cFornAnt != (cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA .And. lPrintLine // nTotForn > 0 
			lDescLine := .T.
			oReport:SkipLine()
			nLin := oReport:Row()
			oReport:PrintText(STR0065,nLin)	//"TOTAL DO FORNECEDOR :"
			oReport:PrintText(TransForm(nTotForn,Pesqpict("SD1","D1_TOTAL")),nLin,oSection2:Cell('nVtotal'):ColPos()-30)											
			oReport:SkipLine()

			// Para impressao em PDF inicia nova pagina antes de chegar ao fim de cada pagina para que as ultimas linhas nao fiquem cortadas
			If nTpImp == 6
				If oReport:Row() > (nPageWidth-500)
					oSection3:SetPageBreak(.T.)
				Else
					oSection3:SetPageBreak(.F.)
				EndIf
			EndIf

			oSection3:Init() 
			If ( cPaisLoc == "BRA" )
				oSection3:Cell("nValIcm"):SetValue(nValIcm)
				oSection3:Cell("nValIpi"):SetValue(nValIpi)	
				oSection3:Cell("nTotImp"):SetValue(nValMerc + nTotDesp + nTotFrete + nTotSeguro)									
				nTgerIcm += nValIcm
				nTgerIpi += nValIpi
			Else
				oSection3:Cell("nValImpNoInc"):SetValue(nImpNoInc)
				oSection3:Cell("nValImpInc"):SetValue(nImpInc)						
				oSection3:Cell("nTotImp"):SetValue(nValMerc + nTotDesp + nTotFrete + nTotSeguro)													
				nTgImpInc   += nImpInc
				nTgImpNoInc += nImpNoInc
			EndIf
			nTotGerImp += nValMerc + ( nTotDesp + nTotFrete + nTotSeguro )

			oSection3:PrintLine()
			oReport:FatLine()
			
            oSection1:Finish() 
            oSection2:Finish() 
            oSection3:Finish() 						
			
			nTotGeral += nTotForn
			cFornAnt := (cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA
			nTotForn := 0
			nValIpi     := 0
			nValMerc    := 0
			nValDesc    := 0
			nTotDesp    := 0
			nTotFrete   := 0
			nTotSeguro  := 0
			nValIcm     := 0
			nValImpInc	:= 0
 			nValImpNoInc:= 0
			nImpInc		:= 0
			nImpNoInc	:= 0
	  		lPrintLine := .F.
		Endif
		
	Endif
	
	If !lquery
		(cAliasSF1)->(dbseek( xFilial("SF1") + (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA)) //posiciona o cabecalho da nota
	Endif
	
	nTaxa  := (cAliasSF1)->F1_TXMOEDA
	nMoeda := (cAliasSF1)->F1_MOEDA
	dDtDig := (cAliasSF1)->F1_DTDIGIT
	
EndDo
oSection1:Finish()
If lImp	
	If nOrdem == 1 .And. MV_PAR05 == 1
		If (nTgerIcm + nTgerIpi + nTotGeral + nTgImpInc + nTgImpNoInc) > 0
			oReport:FatLine()			
			If cPaisLoc=="BRA"
				oReport:PrintText(STR0042+"    "+STR0022+TransForm(nTgerIcm,tm(nTGerIcm,15))+"    "+STR0023+TransForm(nTGerIpi,tm(nTGerIpi,15))+"    "+STR0024+TransForm(nTotDesco,tm(nTotDesco,13,nDecs))+"    "+STR0025+TransForm(nTotGeral,tm(nTotGeral,17,nDecs)))	
			Else
				oReport:PrintText(STR0042+"    "+STR0071+":"+TransForm(nTgImpNoInc,tm(nTGImpNoInc,15,nDecs))+"    "+STR0072+":"+TransForm(nTgImpInc,tm(tm(nTGImpInc,15,nDecs),15))+"    "+STR0024+TransForm(nTotDesco,tm(nTotDesco,13,nDecs))+"    "+STR0025+TransForm(nTotGeral,tm(nTotGeral,17,nDecs)))	
			Endif	
		Endif
	ElseIf (nOrdem == 1 .Or. nOrdem == 3 .Or. nOrdem == 4 .Or. nOrdem == 5) .And. MV_PAR05 == 2
		If (cPaisLoc == "BRA")
			oReport:SkipLine()
			nLin := oReport:Row()
			oReport:PrintText(STR0042,nLin)	
			oReport:PrintText(TransForm(nTgerIcm,tm(nTGerIcm,14)),nLin,oSection1:Cell('nValIcm1'):ColPos()-20)	
			oReport:PrintText(TransForm(nTgerIpi,tm(nTgerIpi,14)),nLin,oSection1:Cell('nValIpi1'):ColPos()-25)	
			oReport:PrintText(TransForm(nTotGeral,PesqPict("SF1","F1_VALMERC",17)),nLin,oSection1:Cell('nTotNF1'):ColPos()-25)	
		Else
			nLin := oReport:Row()
			oReport:PrintText(STR0042,nLin)	
			oReport:PrintText(TransForm(nTgImpInc+nTgImpNoInc,Pesqpict("SF1","F1_VALIMP1",16)),nLin,oSection1:Cell('nImpInc1'):ColPos()-36)	
			oReport:PrintText(TransForm(nTotGeral,PesqPict("SF1","F1_VALMERC",17)),nLin,oSection1:Cell('nTotNF1'):ColPos()-36)				
		Endif
		oReport:SkipLine()
	ElseIf nOrdem == 2 .AND. !lPlanTab 
		oReport:FatLine()
		nLin := oReport:Row()
		oReport:PrintText(STR0042)	
		oReport:PrintText(TransForm(nTotQger,pesqpict("SD1","D1_QUANT",15)),nLin,oSection2:Cell('D1_QUANT'):ColPos()-85)	
		oReport:PrintText(TransForm(nTotGeral,PesqPict("SF1","F1_VALMERC",17)),nLin,oSection2:Cell('nVtotal'):ColPos()-75)				
	ElseIf (nOrdem == 3 .Or. nOrdem == 4 .Or. nOrdem == 5) .And. MV_PAR05 == 1
		oReport:SkipLine()
		nLin := oReport:Row()
		oReport:PrintText(STR0042,nLin)	
		oReport:PrintText(TransForm(nTotGeral,PesqPict("SF1","F1_VALMERC",17)),nLin,oSection2:Cell('nVtotal'):ColPos()-IIF(nOrdem==5,30,80))				
		oReport:SkipLine()
	Endif	
	
	If nOrdem == 2 .Or. ( (nOrdem == 3 .Or. nOrdem == 4 .Or. nOrdem ==5) .And. MV_PAR05 == 1)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Linha de total adicional p/ a quebra, com totais de Impostos ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (nTgerIcm + nTgerIpi + nTotGerImp + nTgImpInc + nTgImpNoInc) > 0
			oReport:SkipLine()
			If ( cPaisLoc=="BRA" )
				oReport:PrintText(STR0015+TransForm(nTgerIcm,tm(nTGerIcm,15))+"     "+STR0016+TransForm(nTgerIpi,tm(nTGerIpi,15))+"     "+STR0066+TransForm(nTotGerImp,tm(nTotGerImp,17,nDecs)))	
			Else
				oReport:PrintText(STR0051+TransForm(nTgImpNoInc,tm(nTGImpNoInc,15,nDecs))+"     "+STR0056+TransForm(nTgImpInc,tm(nTGImpInc,15,nDecs))+"     "+STR0066+TransForm(nTotGerImp,tm(nTotGerImp,17,nDecs)))	
			EndIf                     
		Endif
    EndIf
    If mv_par05 == 2 .And. nOrdem == 1
	    oSection1:Finish()
    Endif
Endif	

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GetValImp ³ Autor ³ Suprimentos           ³ Data ³09/08/2018³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna os campos de imposto variavel                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetValImp(aCampos)

Local aStru := FWFormStruct(3,"SD1")[1]
Local nX

// Retorno da FWFormStruct = 3
//[01][03] ExpC:idField
//[01][14] ExpL:Campo virtual?

For nX := 1 To Len(aStru)
	If "D1_VALIMP" $ aStru[nX][3]
		AAdd(aCampos,aStru[nX][3])
	EndIf
Next nX

Return
