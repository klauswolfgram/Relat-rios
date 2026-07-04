/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR310.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR310  ³ Autor ³ Nereu Humberto Junior ³ Data ³ 03/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao dos Produtos Vendidos                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MATR310
Local oReport
Private aRelImp	 := MaFisRelImp("MT100",{ "SD1" })
Private aRelImp2 := MaFisRelImp("MT100",{ "SD2" })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= ReportDef()
oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Nereu Humberto Junior  ³ Data ³03.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oSection1
Local oBreak
Local cTamVlr  := TamSX3('D2_TOTAL')[1] + 2
Local cTamCust := TamSX3('D2_CUSTO1')[1] + 2
Local nTamQuant:= TamSX3('D2_QUANT')[1]
Local nTamCustd:= TamSX3('B1_CUSTD')[1]
Local nTamCOD  := TamSX3('B1_COD')[1]
Local cPictVl  := X3Picture('D2_TOTAL')
Local cPicCust := X3Picture('D2_CUSTO1')
Local cPicCustd:= PesqPictQt("B1_CUSTD")
Local cPicQuant:= PesqPictQt("D2_QUANT",16)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New("MATR310",STR0001,"MTR310", {|oReport| ReportPrint(oReport)},STR0002+" "+STR0003+" "+STR0004) //"Relacao dos Produtos Vendidos"##"Este relatorio apresenta o valor total das vendas de cada produto,"##"calculando sua participacao dentro do total das vendas.Mostra tam-"##"bem o custo de cada venda e o custo de reposicao do produto."
oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // Almoxarifado inicial                         ³
//³ mv_par02     // Almoxarifado final                           ³
//³ mv_par03     // Data de emissao inicial                      ³
//³ mv_par04     // Data de emissao final                        ³
//³ mv_par05     // tipo inicial                                 ³
//³ mv_par06     // tipo final                                   ³
//³ mv_par07     // produto inicial                              ³
//³ mv_par08     // produto final                                ³
//³ mv_par09     // moeda selecionada ( 1 a 5 )                  ³
//³ mv_par10     // Considera Valor IPI Sim N„o                  ³
//³ mv_par11     // Considera Devolucao NF Orig/NF Devl/Nao Cons.³
//³ mv_par12     // Quanto a Estoque Movimenta/Nao Movta/Ambos   ³
//³ mv_par13     // Quanto a Duplicata Gera/Nao Gera/Ambos       ³
//³ mv_par14     // Considera Valor ICMS Sim N„o                 ³
//³ mv_par15     // Abate Impostos Nao Faturados ?               ³
//³ mv_par16     // Perc. Abatimento ?                           ³
//³ mv_par17     // Inclui Devolucao de Compra?                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR310",.F.)

oSection1 := TRSection():New(oReport,STR0039,{"SD2","SB1","SD1"}) //"Produtos" 
oSection1:SetTotalInLine(.F.)
oSection1 :SetReadOnly()
oSection1:SetHeaderPage(.F.)

TRCell():New(oSection1,"cTipant"	,"   ",STR0019					,"@!"						,2			,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,, .F. )
TRCell():New(oSection1,"cCodAnt"	,"   ",STR0020					,"@!"						,nTamCOD	,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,, .T. )
TRCell():New(oSection1,"B1_DESC"	,"SB1",/*Titulo*/				,/*Picture*/				,40			,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,, .T. )
TRCell():New(oSection1,"nAp1"		,"   ",STR0021					,cPicQuant					,nTamQuant	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"nMov"		,"   ",STR0041+CRLF+STR0042     ,cPicQuant				    ,nTamQuant  ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"B1_UM"		,"SB1",/*Titulo*/				,/*Picture*/				,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.F. )
TRCell():New(oSection1,"nAp2"		,"   ",STR0022+CRLF+STR0023		,cPicCust					,cTamCust	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"nCusto"		,"   ",STR0024+CRLF+STR0025		,cPicCust					,cTamCust	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"nAp5"		,"   ",STR0026+CRLF+STR0027		,cPictVl					,cTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"nAp3"		,"   ",STR0028+CRLF+STR0029		,cPictVl					,cTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"nImpnFat"	,"   ",STR0030+CRLF+STR0031		,cPictVl					,cTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"nValFat"	,"   ",STR0026+"-"+CRLF+STR0032 ,cPictVl					,cTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"nMargem"	,"   ",STR0033					,"9999999.9"				,9			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"nMixMar"	,"   ",STR0034+CRLF+STR0035		,"999999.9"					,8			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"cSinal"		,"   ",""						,"@X"						,2   		,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.F. )
TRCell():New(oSection1,"nMix"		,"   ",STR0034					,"999999.9"					,8			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"nAp4"		,"   ",STR0036+CRLF+STR0037		,cPicCustd					,nTamCustd	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )
TRCell():New(oSection1,"nVar"		,"   ",STR0038					,"999999.9"					,10			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.F. )

oBreak := TRBreak():New(oSection1,oSection1:Cell("cTipant"),STR0012,.F.)

TRFunction():New(oSection1:Cell("nAp1"),"CALC_AP1","SUM",oBreak,"",PesqPictQt("D2_QUANT",16),/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nMov"),"CALC_MOV","SUM",oBreak,"",PesqPictQt("D2_QUANT",16),/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nAp2"),"CALC_AP2","SUM",oBreak,"",cPicCust,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nCusto"),NIL,"ONPRINT",oBreak,"",cPicCust,{|| oSection1:GetFunction("CALC_AP2"):GetLastValue()/oSection1:GetFunction("CALC_MOV"):GetLastValue() },.F.,.T.)
TRFunction():New(oSection1:Cell("nAp5"),NIL,"SUM",oBreak,"",cPictVl,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nAp3"),"CALC_AP3","SUM",oBreak,"",cPictVl,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nImpnFat"),NIL,"SUM",oBreak,"",cPictVl,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nValFat"),NIL,"SUM",oBreak,"",cPictVl,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nMargem"),NIL,"ONPRINT",oBreak,"","9999999.9",{|| 100*((oSection1:GetFunction("CALC_AP3"):GetLastValue()-oSection1:GetFunction("CALC_AP2"):GetLastValue())/oSection1:GetFunction("CALC_AP3"):GetLastValue())},.F.,.T.)
TRFunction():New(oSection1:Cell("nMixMar"),NIL,"SUM",oBreak,"","999999.9",/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nMix"),NIL,"SUM",oBreak,"","999999.9",/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nAp4"),"CALC_AP4","SUM",oBreak,"",cPicCustd,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nVar"),NIL,"ONPRINT",oBreak,"","999999.9",{|| (100*oSection1:GetFunction("CALC_AP4"):GetLastValue()/oSection1:GetFunction("CALC_AP2"):GetLastValue())-100},.F.,.T.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³21.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local oSection1:= oReport:Section(1)
Local lDevolucao := .F.
Local nAp1,nAp1Cus,nAp2,nAp3,nAp4,nAp5
Local cCodAnt := "",cTipant := "",nTotFat:=0,nTotLuc:=0
Local nMoeda
Local cArqSD1:=cArqSD2:=cArqTrab:=cKeySD2:=sKeySD1:=cFilSD1:=cFilSD2:=""
Local cEstoq := If( (mv_par12 == 1),"S",If( (mv_par12 == 2),"N","SN" ) )
Local cDupli := If( (mv_par13 == 1),"S",If( (mv_par13 == 2),"N","SN" ) )
Local nValCus := 0
Local aTam:={}
Local aStruct := {}
Local nIndSd1:= 0
Local nCpo
Local aImpVar := {}
Local cFormula := ""
Local cAliasTop := "SD2"
Local cEspecieLoja := "CF"
Local cEspSAT		:= "SATCE"
Local cEspNFCE	:= "NFCE"
Local oTempTable:= NIL
Local aIndex	  := {}
Local cPictVl := X3Picture('D2_CUSTO1')
Local cMoeda := ""

Private lVEIC	:= UPPER(GETMV("MV_VEICULO"))=="S"
Private aCampos := {}
Private cCampImp

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Se for o estado de Piaui, Pega Loja ECF³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If LjAnalisaLeg(18)[1]
	cEspecieLoja := "ECF"
EndIf

nMoeda := mv_par09
oReport:SetTitle( oReport:Title()+" - "+GetMv("MV_SIMB"+Alltrim(Str(nMoeda))))

If mv_par15 == 1
	cFormula := "Formula da Margem" +" => (( B - A ) / B ) * 100"
Else
	cFormula := "Formula da Margem" + " =>  C = B - "+Str(mv_par16,5,2)+"%  => (( C - A ) / C ) * 100"
EndIf

dbSelectArea("SF4")
dbSetOrder(1)

dbSelectArea("SF2")
dbSetOrder(1)

dbSelectArea("SF1")
dbSetOrder(1)

dbSelectArea("SD2")
dbSetOrder(1)

dbSelectArea("SD1")
dbSetOrder(1)

dbSelectArea("SB1")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria arquivo temporario para impressao                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam := TamSx3("D2_FILIAL")
Aadd(aCampos,{"D2_FILIAL","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_COD")
Aadd(aCampos,{"D2_COD","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_LOCAL")
Aadd(aCampos,{"D2_LOCAL","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_SERIE")
Aadd(aCampos,{"D2_SERIE","C",aTam[1],SerieNfId("SD2",6,"D2_SERIE")})
aTam := TamSx3("D2_TES")
Aadd(aCampos,{"D2_TES","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_TP")
Aadd(aCampos,{"D2_TP","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_EMISSAO")
Aadd(aCampos,{"D2_EMISSAO","D",aTam[1],aTam[2]})
aTam := TamSx3("D2_TIPO")
Aadd(aCampos,{"D2_TIPO","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_DOC")
Aadd(aCampos,{"D2_DOC","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_QUANT")
Aadd(aCampos,{"D2_QUANT","N",aTam[1],aTam[2]})
aTam := TamSx3("D2_TOTAL")
Aadd(aCampos,{"D2_TOTAL","N",aTam[1],aTam[2]})
aTam := TamSx3("D2_CUSTO"+Str(mv_par09,1))
Aadd(aCampos,{"D2_CUSTO","N",aTam[1],aTam[2]})
aTam := TamSx3("D2_VALIPI")
Aadd(aCampos,{"D2_VALIPI","N",aTam[1],aTam[2]})
aTam := TamSx3("D2_VALICM")
Aadd(aCampos,{"D2_VALICM","N",aTam[1],aTam[2]})
aTam := TamSx3("D2_ITEM")
Aadd(aCampos,{"D2_ITEM","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_ORIGLAN")
Aadd(aCampos,{"D2_ORIGLAN","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_CLIENTE")
Aadd(aCampos,{"D2_CLIENTE","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_LOJA")
Aadd(aCampos,{"D2_LOJA","C",aTam[1],aTam[2]})

aStruct:=SD2->(dbStruct())

For nCpo := 1 to Len(aStruct)
	If Substr(aStruct[nCpo][1],1,9)=="D2_VALIMP" .or. Substr(aStruct[nCpo][1],1,9)=="D2_BASIMP"
		aTam := TamSx3(aStruct[nCpo][1])
		Aadd(aCampos,{aStruct[nCpo][1],"N",aTam[1],aTam[2]})
		Aadd(aImpVar,aStruct[nCpo][1])
	EndIf
Next

aIndex := {"D2_FILIAL","D2_TP","D2_COD","D2_DOC","D2_SERIE"}

oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", aIndex )
oTempTable:Create()

cArqTrab := oTempTable:GetRealName()


If (mv_par11 # 3)

	dbSelectArea( "SD1" )
	cArqSD1 := CriaTrab( NIL,.F. )
	cKeySD1 := "D1_FILIAL+D1_COD+D1_SERIORI+D1_NFORI+D1_ITEMORI"

	cFilSD1 := "D1_FILIAL = '" + xFilial("SD1") + "'"
	cFilSD1 += " .And. D1_TIPO = 'D'"
	cFilSD1 += " .And. D1_COD >= '" + MV_PAR07 + "'"
	cFilSD1 += " .And. D1_COD <= '" + MV_PAR08 + "'"
	cFilSD1 += " .And. D1_LOCAL >= '" + MV_PAR01 + "'"
	cFilSD1 += " .And. D1_LOCAL <= '" + MV_PAR02 + "'"
	cFilSD1 += " .And. DTOS(D1_DTDIGIT) >= '" + DTOS(MV_PAR03) + "'"
	cFilSD1 += " .And. DTOS(D1_DTDIGIT) <= '" + DTOS(MV_PAR04) + "'"
	cFilSD1 += " .And. D1_TP >= '" + MV_PAR05 + "'"
	cFilSD1 += " .And. D1_TP <= '" + MV_PAR06 + "'"

	IndRegua("SD1",cArqSD1,cKeySD1,,cFilSD1,STR0010)			//"Selecionando Registros..."

	nIndSd1:=RetIndex("SD1")

	dbSetOrder(nIndSd1 + 1)
	dbGoTop()

EndIf

dbSelectArea("SD2")
dbSetOrder(2)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)

	cAliasTop := GetNextAlias()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 1                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):BeginQuery()

	cSelect := "%"
	cSelect += "D2_CUSTO"+Str(mv_par09,1)
	//Adicao a query dos campos de impostos

	For nCpo := 1 to Len(aImpVar)
			cSelect += ","+aImpVar[nCpo]
	Next

	cSelect += "%"

	cWhere := "%"
	IF ! lVeic
		cWhere += " AND D2_COD >= '" + MV_PAR07 + "'"
		cWhere += " AND D2_COD <= '" + MV_PAR08 + "'"
	Endif
	If mv_par17 == 2
		cWhere += " And D2_TIPO <> 'D'"
	Endif

	//Adicao de filtro para nao considerar REMITOS
	If cPaisLoc<>"BRA"
		cWhere += " AND NOT ("+IsRemito(2,"D2_TIPODOC")+")"
	Endif

	cWhere += "%"

	BeginSql Alias cAliasTop

		SELECT D2_FILIAL,D2_TP,D2_COD,D2_DOC,D2_SERIE,D2_LOCAL,D2_TES,D2_EMISSAO,D2_TIPO,D2_QUANT,
 		       D2_TOTAL,D2_VALIPI,D2_VALICM,D2_ORIGLAN,D2_CLIENTE,D2_ITEM,D2_LOJA,%Exp:cSelect%

		FROM %table:SD2% SD2,%table:SF2% SF2

		WHERE	SD2.D2_FILIAL    = %xFilial:SD2%        AND
				SD2.D2_TP       >= %Exp:mv_par05%       AND
				SD2.D2_TP       <= %Exp:mv_par06%       AND
				SD2.D2_LOCAL    >= %Exp:mv_par01%       AND
				SD2.D2_LOCAL    <= %Exp:mv_par02%       AND
				SD2.D2_EMISSAO  >= %Exp:Dtos(mv_par03)% AND
				SD2.D2_EMISSAO  <= %Exp:Dtos(mv_par04)% AND
				SF2.F2_FILIAL    = %xFilial:SF2%        AND
				SF2.F2_DOC       = SD2.D2_DOC           AND
				SF2.F2_SERIE     = SD2.D2_SERIE         AND
    			SF2.F2_LOJA      = SD2.D2_LOJA          AND
				(NOT (SF2.F2_ESPECIE <> %Exp:cEspNFCE% AND SF2.F2_ESPECIE <> %Exp:cEspSAT% AND SF2.F2_ESPECIE <> %Exp:cEspecieLoja% AND SF2.F2_NFCUPOM <> ' ')) AND
				SF2.%NotDel%						    AND
				SD2.%NotDel%
				%Exp:cWhere%

		ORDER BY 1,2,3

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

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAliasTop)
oReport:SetMeter(SD2->(LastRec()))

GeraTrab("SD2",cAliasTop,.T.)

SB1->(dbSetOrder(1))

If mv_par11 != 3
	dbSelectArea("SD1")
	dbGoTop()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Filtragem do relatório somente para notas de Devolução                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Transforma parametros Range em expressao SQL                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MakeSqlExpr(oReport:uParam)

		cAliasTop := GetNextAlias()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Query do relatório da secao SD1                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:Section(1):BeginQuery()

		cWhere := "%"
		IF ! lVeic
			cWhere += " AND D1_COD >= '" + MV_PAR07 + "'"
			cWhere += " AND D1_COD <= '" + MV_PAR08 + "'"
		Endif

		cWhere += " AND D1_TIPO = 'D'"

		//Adicao de filtro para nao considerar REMITOS
		If cPaisLoc<>"BRA"
			cWhere += " AND NOT ("+IsRemito(2,"D1_TIPODOC")+")"
		Endif
		If mv_par11 = 1
			cWhere += " AND D1_DATORI >= '"+Dtos(mv_par03)+"' "
			cWhere += " AND D1_DATORI <= '"+Dtos(mv_par04)+"' "
		Else
			cWhere += " AND D1_DTDIGIT >= '"+Dtos(mv_par03)+"' "
			cWhere += " AND D1_DTDIGIT <= '"+Dtos(mv_par04)+"' "
		EndIf		
		cWhere += "%"

	    cMoeda := "%"+"D1_CUSTO"+If((mv_par09==1),"",Str(mv_par09,1))+"%"

		BeginSql Alias cAliasTop

			SELECT D1_FILIAL,D1_TP,D1_COD,D1_DOC,D1_SERIE,D1_LOCAL,D1_TES,D1_EMISSAO,D1_TIPO,D1_QUANT,
	 		       D1_TOTAL,D1_VALIPI,D1_VALICM,D1_ORIGLAN,D1_ITEM,D1_LOJA,D1_SERIORI,D1_ITEMORI,D1_NFORI,%EXP:cMoeda%,
					D1_VALDESC,D1_CUSTO,D1_FORNECE,D1_CUSTO2

			FROM %table:SD1% SD1

			WHERE	D1_FILIAL   = %xFilial:SD1% AND
					D1_TP      >= %Exp:mv_par05% AND
					D1_TP      <= %Exp:mv_par06%AND
					D1_LOCAL   >= %Exp:mv_par01% AND
					D1_LOCAL   <= %Exp:mv_par02%AND
					SD1.%NotDel%
					%Exp:cWhere%


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


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAliasTop)
oReport:SetMeter(SD1->(LastRec()))
	GeraTrab("SD1",cAliasTop)
EndIf

dbSelectArea("TRB")
dbGoTop()

While !oReport:Cancel() .And. !TRB->(Eof())

	If oReport:Cancel()
		Exit
	EndIf

	oReport:IncMeter()

	If !(cCodAnt == TRB->D2_COD)
		cCodAnt    := TRB->D2_COD
		oSection1:Cell("cCodAnt"):SetValue(cCodAnt)
		lDevolucao := .T.
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
	//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(TRB->D2_ORIGLAN == "LF") .And. AvalTes(TRB->D2_TES,cEstoq,cDupli)

		If !(SB1->(MsSeek( xFilial("SB1") + TRB->D2_COD, .F. ))) // pode haver filtro de usuario na SB1
			dbSkip()
			Loop
		EndIf

		If TRB->D2_TIPO != "D"
			If (mv_par09 > 1)
				nValCus := TRB->D2_CUSTO
				If nValCus > 0
					nTotLuc += nValCus
				Else
					nTotLuc += xMoeda( TRB->D2_CUSTO, Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, TRB->D2_EMISSAO )
				EndIf
			Else
				nTotLuc += TRB->D2_CUSTO
			EndIf
			If cPaisLoc<>"BRA"
				nTotFat +=  ValSD2()
			Else
				If (mv_par09 > 1)
					nTotFat += xMoeda( ValSD2(), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, TRB->D2_EMISSAO )
				Else
					nTotFat += ValSD2()
				EndIf
			EndIf
		Else
			If (mv_par09 > 1)
				nValCus := TRB->D2_CUSTO
				If nValCus > 0
					nTotLuc -= nValCus
				Else
					nTotLuc -= xMoeda( TRB->D2_CUSTO, Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, TRB->D2_EMISSAO )
				EndIf
			Else
				nTotLuc -= TRB->D2_CUSTO
			EndIf
			If cPaisLoc<>"BRA"
				nTotFat -=  ValSD2()
			Else
				If (mv_par09 > 1)
					nTotFat -= xMoeda( ValSD2(), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, TRB->D2_EMISSAO )
				Else
					nTotFat -= ValSD2()
				EndIf
			EndIf
		Endif
		Do Case
		Case (mv_par11 == 1)
			DbSelectArea( "SD1" )
			If DbSeek( xFilial("SD1") + TRB->D2_COD + TRB->D2_SERIE + TRB->D2_DOC + TRB->D2_ITEM,.F. )
				While !SD1->(Eof()) .And. (SD1->D1_COD == TRB->D2_COD) .And. (TRB->D2_SERIE+TRB->D2_DOC+TRB->D2_ITEM == SD1->D1_SERIORI+SD1->D1_NFORI+AllTrim(SD1->D1_ITEMORI))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
					//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !(D1_ORIGLAN == "LF") .And. AvalTes(D1_TES,cEstoq,cDupli)

						If (mv_par09 > 1)
							nValCus :=  &("D1_CUSTO"+If((mv_par09==1),"",Str(mv_par09,1)) )
							if nValCus > 0
								nTotLuc -= nValCus
							else
								nTotLuc -= xMoeda( D1_CUSTO, Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, D1_DTDIGIT )
							endif
						Else
							nTotLuc -=  &("D1_CUSTO"+If((mv_par09==1),"",Str(mv_par09,1)) )
						EndIf

						If (mv_par09 > 1)
							nTotFat -= xMoeda( ValSD1(), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, D1_DTDIGIT )
						Else
							nTotFat -= ValSD1()
						EndIf
					EndIf
					dbSelectArea('SD1')
					DbSkip( 1 )
				EndDo
			EndIf
		Case (mv_par11 == 2) .And. lDevolucao
			DbSelectArea( "SD1" )
			If DbSeek( xFilial("SD1") + TRB->D2_COD + TRB->D2_SERIE + TRB->D2_DOC + TRB->D2_ITEM,.F. )
				While !SD1->(Eof()) .And. (SD1->D1_COD == TRB->D2_COD) .And. (TRB->D2_SERIE+TRB->D2_DOC+TRB->D2_ITEM  == SD1->D1_SERIORI+SD1->D1_NFORI+AllTrim(SD1->D1_ITEMORI))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
					//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !(D1_ORIGLAN == "LF") .And. AvalTes(D1_TES,cEstoq,cDupli)

						If (mv_par09 > 1)
							nValCus :=  &("D1_CUSTO"+If((mv_par09==1),"",Str(mv_par09,1)) )
							if nValCus > 0
								nTotLuc -= nValCus
							else
								nTotLuc -= xMoeda( D1_CUSTO, Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, D1_DTDIGIT )
							endif
						Else
							nTotLuc -=  &("D1_CUSTO"+If((mv_par09==1),"",Str(mv_par09,1)) )
						EndIf

						If (mv_par09 > 1)
							nTotFat -= xMoeda( ValSD1(), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, D1_DTDIGIT )
						Else
							nTotFat -= ValSD1()
						EndIf
					EndIf
					dbSelectArea('SD1')
					DbSkip( 1 )
				EndDo
			EndIf
		EndCase
	EndIf

	DbSelectArea( "TRB" )
	DbSkip( 1 )
	lDevolucao := !(TRB->D2_TIPO == 'D')
EndDo

nTotLuc := c310AbaVal(nTotFat)-nTotLuc

TRB->(DbGoTop())

cCodAnt := ""

oSection1:Init()

If oReport:lXlsTable

oSection1:Cell("nMargem"):SetPicture(cPictVl)
oSection1:Cell("nMixMar"):SetPicture(cPictVl)
oSection1:Cell("nMix"):SetPicture(cPictVl)

EndIf

dbSelectArea("TRB")
While !oReport:Cancel() .And. !TRB->(Eof())

	If oReport:Cancel()
		Exit
	EndIf

	cTipant := TRB->D2_TP
	oSection1:Cell("cTipant"):SetValue(cTipant)

	While !oReport:Cancel() .And. !TRB->(Eof()) .And. (TRB->D2_TP == cTipant)

		If oReport:Cancel()
			Exit
		EndIf

		If !(SB1->(MsSeek( xFilial("SB1") + TRB->D2_COD, .F. ))) // pode haver filtro de usuario na SB1
			dbSkip()
			Loop
		EndIf

		nAp1 	:= 0
		nAp1Cus	:= 0
		nAp2	:= 0
		nAp3	:= 0
		nAp4	:= 0
		nAp5	:= 0

		If !(cCodAnt == TRB->D2_COD)
			cCodAnt    := TRB->D2_COD
			oSection1:Cell("cCodAnt"):SetValue(cCodAnt)
			lDevolucao := !(TRB->D2_TIPO == 'D')
		EndIf

		While !oReport:Cancel() .And. !TRB->(Eof()) .And.  TRB->D2_TP+TRB->D2_COD == cTipant+cCodAnt

			If oReport:Cancel()
				Exit
			EndIf

			oReport:IncMeter()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
			//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !(TRB->D2_ORIGLAN == "LF") .And. AvalTes(TRB->D2_TES,cEstoq,cDupli)
				If !(TRB->D2_TIPO == "D")
					If AvalTes(TRB->D2_TES,"S")
						nAp1Cus+=TRB->D2_QUANT
					Endif
					nAp1 += TRB->D2_QUANT
					If (mv_par09 > 1)
						nValCus := TRB->D2_CUSTO
						if nValCus > 0
							nAp2 += nValCus
						else
							nAp2 += xMoeda( TRB->D2_CUSTO, Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, TRB->D2_EMISSAO )
						endif
					Else
						nAp2 += TRB->D2_CUSTO
					EndIf

					If (mv_par09 > 1)
						nAp3 += Iif(cPaisLoc<>"BRA",ValSD2(),xMoeda( ValSD2(), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, TRB->D2_EMISSAO ))
						If cPaisLoc=="BRA"
							nAp5 += xMoeda( TRB->D2_TOTAL+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",TRB->D2_VALIPI,0), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, TRB->D2_EMISSAO )
						Else
							nAp5 += SumTaxSD2(.F.)
						EndIf
					Else
						nAp3 += ValSD2()
						If cPaisLoc=="BRA"
							nAp5 += TRB->D2_TOTAL+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",TRB->D2_VALIPI,0)
						Else
							nAp5 += SumTaxSD2(.F.)
						EndIf
					EndIF

					If mv_par09 > 1
						nAp4 += (TRB->D2_QUANT*xMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, RetFldProd(SB1->B1_COD,"B1_DATREF") ))
					Else
						If RetFldProd(SB1->B1_COD,"B1_MCUSTD") > "1" .and. !Empty(RetFldProd(SB1->B1_COD,"B1_MCUSTD"))
							nAp4 += (TRB->D2_QUANT*(XMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"),Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),1,dDataBase)))
						Else
							nAp4 += (TRB->D2_QUANT*RetFldProd(SB1->B1_COD,"B1_CUSTD"))
						EndIf
					EndIF
				Else
					If AvalTes(TRB->D2_TES,"S")
						nAp1Cus-=TRB->D2_QUANT
					Endif
					nAp1 -= TRB->D2_QUANT
					If (mv_par09 > 1)
						nValCus := TRB->D2_CUSTO
						if nValCus > 0
							nAp2 -= nValCus
						else
							nAp2 -= xMoeda( TRB->D2_CUSTO, Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, TRB->D2_EMISSAO )
						endif
					Else
						nAp2 -= TRB->D2_CUSTO
					EndIf

					If (mv_par09 > 1)
						If cPaisLoc<>"BRA" .And. nMoeda==mv_par09 
							nAp3 -= ValSD2()
						Else
							nAp3 -= xMoeda( ValSD2(), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, TRB->D2_EMISSAO )
						EndIf

						If cPaisLoc=="BRA"
							nAp5 -= xMoeda( TRB->D2_TOTAL+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",TRB->D2_VALIPI,0), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, TRB->D2_EMISSAO )
						Else
							nAp5 -=  SumTaxSD2(.F.)
						EndIf
					Else
						nAp3 -= ValSD2()
						If cPaisLoc=="BRA"
							nAp5 -= TRB->D2_TOTAL+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",TRB->D2_VALIPI,0)
						Else
							nAp5 -= SumTaxSD2(.F.)
						EndIf
					EndIF

					If mv_par09 > 1
						If cPaisLoc<>"BRA" .And. nMoeda==mv_par09 
								If Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")) > 1
									nAp4 -= (TRB->D2_QUANT*(XMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"),Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),1,dDataBase)))
								Else
									nAp4 -= (TRB->D2_QUANT*RetFldProd(SB1->B1_COD,"B1_CUSTD"))
								EndIf
						Else
							nAp4 -= (TRB->D2_QUANT*xMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, RetFldProd(SB1->B1_COD,"B1_DATREF") ))
						EndIf
					Else
						If RetFldProd(SB1->B1_COD,"B1_MCUSTD") > "1" .and. !Empty(RetFldProd(SB1->B1_COD,"B1_MCUSTD"))
							nAp4 -= (TRB->D2_QUANT*(XMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"),Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),1,dDataBase)))
						Else
							nAp4 -= (TRB->D2_QUANT*RetFldProd(SB1->B1_COD,"B1_CUSTD"))
						EndIf
					EndIF
				Endif
				Do Case
				Case (mv_par11 == 1)
					DbSelectArea( "SD1" )
					If DbSeek( xFilial("SD1") + TRB->D2_COD+TRB->D2_SERIE+TRB->D2_DOC+TRB->D2_ITEM,.F. )
						While !SD1->(Eof()) .And. (D1_COD == cCodAnt) .And. (TRB->D2_SERIE+TRB->D2_DOC+TRB->D2_ITEM == SD1->D1_SERIORI+SD1->D1_NFORI+AllTrim(SD1->D1_ITEMORI))
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
							//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If !(SD1->D1_ORIGLAN == "LF") .And. AvalTes(SD1->D1_TES,cEstoq,cDupli)
								If AvalTes(D1_TES,"S")
									nAp1Cus -= D1_QUANT
								Endif
								nAp1 -= SD1->D1_QUANT
								If (mv_par09 > 1)
									nValCus :=  &("D1_CUSTO"+If((mv_par09==1),"",Str(mv_par09,1)) )
									if nValCus > 0
										nAP2 -= nValCus
									else
										nAp2 -= xMoeda(SD1->D1_CUSTO, Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),nMoeda, SD1->D1_DTDIGIT )
									endif
								Else
									nAp2 -=  &("D1_CUSTO"+If((mv_par09==1),"",Str(mv_par09,1)) )
								EndIf

								If (mv_par09 > 1)
									nAp3 -= xMoeda( ValSD1(), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, SD1->D1_DTDIGIT )
									If cPaisLoc = "BRA"
										nAp5 -= xMoeda( SD1->D1_TOTAL-SD1->D1_VALDESC+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",SD1->D1_VALIPI,0), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, SD1->D1_DTDIGIT )
									Else
										nAp5 -= SumTaxSD1(.F.)
									EndIf
								Else
									nAp3 -= ValSD1()
									If cPaisLoc="BRA"
										nAp5 -= SD1->D1_TOTAL-SD1->D1_VALDESC+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",SD1->D1_VALIPI,0)
									Else
										nAp5 -= SumTaxSD1(.F.)
									EndIf
								EndIF

								If mv_par09 > 1
									nAp4 -= (SD1->D1_QUANT*xMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, RetFldProd(SB1->B1_COD,"B1_DATREF") ))
								Else
									If RetFldProd(SB1->B1_COD,"B1_MCUSTD") > "1" .and. !Empty(RetFldProd(SB1->B1_COD,"B1_MCUSTD"))
										nAp4 -= (SD1->D1_QUANT*(XMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"),Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),1,dDataBase)))
									Else
										nAp4 -= (SD1->D1_QUANT*RetFldProd(SB1->B1_COD,"B1_CUSTD"))
									EndIf
								EndIF
							EndIf
							dbSelectArea('SD1')
							DbSkip( 1 )
						EndDo
					EndIf
				Case (mv_par11 == 2) .And. lDevolucao
			 		DbSelectArea( "SD1" )
					If DbSeek( xFilial("SD1") +TRB->D2_COD+TRB->D2_SERIE+TRB->D2_DOC + TRB->D2_ITEM,.F. )
						While !SD1->(Eof()) .And. (D1_COD == cCodAnt) .And. (TRB->D2_SERIE+TRB->D2_DOC+TRB->D2_ITEM == SD1->D1_SERIORI+SD1->D1_NFORI+AllTrim(SD1->D1_ITEMORI))
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
							//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If !(D1_ORIGLAN == "LF") .And. AvalTes(D1_TES,cEstoq,cDupli)
								If AvalTes(D1_TES,"S")
									nAp1Cus -= D1_QUANT
								Endif
								nAp1 -= D1_QUANT
								If (mv_par09 > 1)
									nValCus :=  &("D1_CUSTO"+If((mv_par09==1),"",Str(mv_par09,1)) )
									if nValCus > 0
										nAp2 -= nValCus
									else
										nAp2 -= xMoeda( D1_CUSTO, Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, D1_DTDIGIT )
									endif
								Else
									nAp2 -=  &("D1_CUSTO"+If((mv_par09==1),"",Str(mv_par09,1)) )
								EndIf

								If (mv_par09 > 1)
									nAp3 -= xMoeda( ValSD1(), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, D1_DTDIGIT )
									If cPaisLoc = "BRA"
										nAp5 -= xMoeda( SD1->D1_TOTAL-SD1->D1_VALDESC+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",SD1->D1_VALIPI,0), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),nMoeda,D1_DTDIGIT )
									Else
										nAp5 -=  SumTaxSD1(.F.)
									EndIf
								Else
									nAp3 -= ValSD1()
									If cPaisLoc = "BRA"
										nAp5 -= SD1->D1_TOTAL-SD1->D1_VALDESC+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",SD1->D1_VALIPI,0)
									Else
										nAp5 -= SumTaxSD1(.F.)
									EndIf
								EndIF

								If mv_par09 > 1
									nAp4 -= (D1_QUANT*xMoeda( RetFldProd(SB1->B1_COD,"B1_CUSTD"), Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, RetFldProd(SB1->B1_COD,"B1_DATREF") ))
								Else
									If RetFldProd(SB1->B1_COD,"B1_MCUSTD") > "1" .and. !Empty(RetFldProd(SB1->B1_COD,"B1_MCUSTD"))
										nAp4 -= (D1_QUANT*(XMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"),Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),1,dDataBase)))
									Else
										nAp4 -= (D1_QUANT*RetFldProd(SB1->B1_COD,"B1_CUSTD"))
									EndIf
								EndIF
							EndIf
							dbSelectArea('SD1')
							DbSkip( 1 )
						EndDo
					EndIf
				EndCase

			EndIf
			DbSelectArea( "TRB" )
			dbSkip()
			lDevolucao := !(TRB->D2_TIPO == 'D')
		EndDo

		If nAp1 != 0 .Or. nAp2 != 0 .Or. nAp3 != 0 .Or. nAp4 != 0 .And. lDevolucao

			oSection1:Cell("nAp1"):SetValue(nAp1)
			oSection1:Cell("nMov"):SetValue(nAp1Cus)
			oSection1:Cell("nAp2"):SetValue(nAp2)
			oSection1:Cell("nCusto"):SetValue(Iif(nAp1Cus<>0,nAp2/nAp1Cus,0))
			oSection1:Cell("nAp5"):SetValue(nAp5)
			oSection1:Cell("nAp3"):SetValue(nAp3)
			If nAp3 != 0
				oSection1:Cell("nImpnFat"):SetValue(nAp5-(c310AbaVal(nAp5)))
				oSection1:Cell("nValFat"):SetValue(nAp3-(nAp5-(c310AbaVal(nAp5))))
				oSection1:Cell("nMargem"):SetValue(100*(c310AbaVal(nAp3)-nAp2)/c310AbaVal(nAp3))
			Else
				oSection1:Cell("nImpnFat"):SetValue(0)
				oSection1:Cell("nValFat"):SetValue(0)
				oSection1:Cell("nMargem"):SetValue(0)
			Endif
			If nTotFat != 0
				oSection1:Cell("nMixMar"):SetValue(100*c310AbaVal(nAp3)/c310AbaVal(nTotFat))
			Else
				oSection1:Cell("nMixMar"):SetValue(0)
			Endif
			If nTotLuc != 0
				oSection1:Cell("nMix"):SetValue(100*(c310AbaVal(nAp3)-nAp2)/nTotLuc)
			Else
				oSection1:Cell("nMix"):SetValue(0)
			EndIf
			oSection1:Cell("nAp4"):SetValue(nAp4)
			If nAp2 != 0
				oSection1:Cell("nVar"):Show()
				oSection1:Cell("nVar"):SetValue((100*nAp4/nAp2)-100)
			Else
				oSection1:Cell("nVar"):SetValue(0)
				oSection1:Cell("nVar"):Hide()
			EndIf

	      	If lVeic .And. !Empty(SB1->B1_CODITE)
				oReport:PrintText('[ ' + SB1->B1_CODITE + ' ] GRUPO : [ ' + SB1->B1_GRUPO + ' ]')
			EndIf

			oSection1:Cell("cSinal"):SetValue(IIF(nAp3-nAp2>0,"+","-"))
			oSection1:PrintLine()

		Endif
		DbSelectArea( "TRB" )
	EndDo
	DbSelectArea( "TRB" )
EndDo

oSection1:Finish()

oReport:PrintText(" " + cFormula, oReport:Row()+ ( 4 * oReport:LineHeight()) ,oSection1:Cell("cTipant"):ColPos(),,,,.F.)

IF "" <> ALLTRIM(cArqSD1)
   IF File(cArqSD1+OrdBagExt())
		Ferase(cArqSD1+OrdBagExt())
	ENDIF
Endif

IF "" <> ALLTRIM(cArqSD2)
	IF File(cArqSD2+OrdBagExt())
		FErase(cArqSD2+OrdBagExt())
	ENDIF
Endif

oTempTable:Delete()

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  ValSD1  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 20/05/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Soma os valores de acordo com os parametros no arquivo SD1 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR310                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValSD1()
Local nValRet	:=0, nImpInc:=0,nImpNoInc:=0
Local aImpostos:={}
Local nY := 0

If ( cPaisLoc=="BRA" )
	nValRet:=D1_TOTAL-SD1->D1_VALDESC+IF(mv_par10 == 1 .And. D1_TIPO <> "P",D1_VALIPI,0)-IF(mv_par14 == 1,0,D1_VALICM)-IF(mv_par18 == 1,0,PisCofins("SD1",1,2,1) + PisCofins("SD1",2,2,1))
ElseIf (mv_par10==1.Or.mv_par14<>1)
	aImpostos:=TesImpInf(SD1->D1_TES)
	For nY:=1 to Len(aImpostos)
		cCampImp:="SD1->D1_"+(Substr(aImpostos[nY][2],4))
		If ( aImpostos[nY][3]=="1" )
			nImpInc  += &cCampImp
		Else
			nImpNoInc+= &cCampImp
		EndIf
	Next
	nValRet:=D1_TOTAL-D1_VALDESC+IF(mv_par10 == 1,nImpInc,0)-IF(mv_par14 == 1,0,nImpNoInc)-IF(mv_par18 == 1,0,PisCofins("SD1",1,2,1) + PisCofins("SD1",2,2,1))
Else
	nValRet:=D1_TOTAL-D1_VALDESC
EndIf

If cPaisLoc<>"BRA"
	If D1_TIPO == "D" 
		nValRet := CalcMoed("SF2",nValRet)//Calcular la tasa de la moneda para las devoluciones
	Else
		nValRet := CalcMoed("SF1",nValRet)//Calcula a taxa da moeda de acordo com a venda
	EndIf 

EndIf
RETURN nValRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  ValSD2  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 20/05/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Soma os valores de acordo com os parametros no arquivo SD2 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR310			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValSD2()
Local nValRet	:=0, nImpInc:=0,nImpNoInc:=0
Local aImpostos:={}
Local nY := 0

If ( cPaisLoc=="BRA" )
 	nValRet:=TRB->D2_TOTAL+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",TRB->D2_VALIPI,0)-IF(mv_par14 == 1,0,TRB->D2_VALICM)- IF(mv_par18 == 1,0,PisCofins("TRB",1,2,2) + PisCofins("TRB",2,2,2))
ElseIf (mv_par10==1.Or.mv_par14<>1)
	aImpostos:=TesImpInf(TRB->D2_TES)
	For nY:=1 to Len(aImpostos)
		cCampImp:="TRB->D2_"+(Substr(aImpostos[nY][2],4))
		If ( aImpostos[nY][3]=="1" )
			nImpInc  += &cCampImp
		Else
			nImpNoInc+= &cCampImp
		EndIf
	Next
	nValRet:=TRB->D2_TOTAL+IF(mv_par10 == 1,nImpInc,0)-IF(mv_par14 == 1,0,nImpNoInc) - IF(mv_par18 == 1,0,PisCofins("TRB",1,2,2) + PisCofins("TRB",2,2,2))
Else
	nValRet:=TRB->D2_TOTAL
EndIf

If cPaisLoc<>"BRA"
	If TRB->D2_TIPO == "D" 
		nValRet := CalcMoed("SF1",nValRet)//Calcula a taxa da moeda de acordo com a venda
	Else
		nValRet := CalcMoed("SF2",nValRet)//Calcula a taxa da moeda de acordo com a venda
	EndIf 			
EndIf
RETURN nValRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³c310AbaVal³Autor³Patricia A. Salomao       ³ Data ³17.11.00  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³Abate % dos Impostos nao Faturados do Valor da Venda         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro³ExpN1	: Valor Base p/ Abatimento                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³MATR310                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function c310AbaVal(nValor)
LOCAL perc := mv_par16
If mv_par15 == 2
	nValor := nValor - (nValor * perc /100)
EndIf
Return(nValor)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTrab  ³ Autor ³Patricia A. Salomao    ³ Data ³ 11/01/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera Arquivo de Trabalho                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GeraTrab(cAlias,cAliasTrb,lGrafico)
Local nPosFirst, lSeek
Local nCpo      := 0
Local lRetPE    := .T.
Local lMR110FIL := ExistBlock("MR110FIL")
Default lGrafico := .F.

cAliasTrb := IIF(cAliasTrb==Nil,cAlias,cAliasTrb)

dbSelectArea(cAliasTrb)
dbGoTop()
While !Eof() .And. &(Subs(cAlias,2,2)+"_FILIAL") == xFilial(cAlias)
	dbSelectArea(cAliasTrb)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ CONTROLE para SIGAVEI, SIGAPEC e SIGAOFI       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If LVEIC
	   lT := .T.
	   DBSELECTAREA("SB1")
	   MsSeek( xFilial("SB1") + &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_COD"))
		IF !EOF()
		   IF (SB1->B1_CODITE >= mv_par07 .and. SB1->B1_CODITE <= mv_par08)
			   lT := .F.
			ENDIF
		ENDIF
		dbSelectArea(cAliasTrb)
		if lT
		   DBSKIP()
		   LOOP
	   endif
	ENDIF

   If cAlias == "SD2"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Executa a validacao do filtro do usuario           	         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !lGrafico
			If !Empty(aReturn[7]) .And. !&(aReturn[7])
				dbSkip()
				Loop
			EndIf
		Endif

	EndIf
	//  So' deverao entrar no "Arquivo de Trabalho", as NF's de Devolucao, que nao tenham suas NF's Originais emitidas no mesmo periodo.
	If cAlias == "SD1" .And. TRB->(lSeek:=(dbSeek((cAliasTrb)->D1_FILIAL+(cAliasTrb)->D1_TP+(cAliasTrb)->D1_COD+(cAliasTrb)->D1_NFORI+(cAliasTrb)->D1_SERIORI))) .And. TRB->D2_TIPO == "N"
		dbSkip()
		loop
	EndIf
	If cAlias == "SD1" .And. MV_PAR11 == 3 .And. (cAliasTrb)->D1_TIPO == 'D'
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ ExecBlock - Filtro no SD1                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cAlias == "SD1" .And. lMR110FIL .And. !lGrafico
        lRetPe := ExecBlock("MR110FIL", .F., .F., { cAliasTrb } )
        If ValType(lRetPE)=="L" .And. lRetPe==.F.
			dbSkip()
			Loop
        EndIf
	EndIf

	dbSelectArea("TRB")
	Reclock("TRB",.T.)
	Replace TRB->D2_FILIAL  With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_FILIAL")
	Replace TRB->D2_COD     With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_COD")
	Replace TRB->D2_LOCAL   With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_LOCAL")
	If cAlias == "SD2"
		Replace TRB->D2_SERIE   With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_SERIE")
	Else
		Replace TRB->D2_SERIE   With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_SERIORI")
		If cAlias == "SD1" .And. cPaisLoc<>"BRA" .And. rtrim(TRB->D2_SERIE)=='' .And. (cAliasTrb)->D1_TIPO == 'D'
			Replace TRB->D2_SERIE   With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_SERIE")
		EndIf
	Endif
	Replace TRB->D2_TES     With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_TES")
	Replace TRB->D2_TP      With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_TP")
	Replace TRB->D2_EMISSAO With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_EMISSAO")
	Replace TRB->D2_TIPO    With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_TIPO")
	If cAlias == "SD2"
		Replace TRB->D2_DOC With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_DOC")
	Else
		Replace TRB->D2_DOC With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_NFORI")
		If cAlias == "SD1" .And. cPaisLoc<>"BRA" .And.  rtrim(TRB->D2_DOC)=='' .And. (cAliasTrb)->D1_TIPO == 'D'
			Replace TRB->D2_DOC With &(cAliasTrb+"->"+(Subs(cAlias,2,2)+"_DOC"))
		EndIf

	Endif
	Replace TRB->D2_QUANT   With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_QUANT")
	Replace TRB->D2_TOTAL   With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_TOTAL")
	If cAlias == "SD1" .And. MV_PAR11 == 2 .And. (cAliasTrb)->D1_TIPO == 'D'
		Replace TRB->D2_TOTAL   With TRB->D2_TOTAL - &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_VALDESC")
    EndIf
	Replace TRB->D2_VALIPI  With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_VALIPI")
	Replace TRB->D2_VALICM  With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_VALICM")
	If cAlias == "SD2"
		Replace TRB->D2_ITEM With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_ITEM")
	Else
		Replace TRB->D2_ITEM With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_ITEMORI")
		If cAlias == "SD1" .And. cPaisLoc<>"BRA" .And. rtrim(TRB->D2_ITEM)=='' .And. (cAliasTrb)->D1_TIPO == 'D'
			Replace TRB->D2_ITEM With Subs(&(cAliasTrb+"->"+ Subs(cAlias,2,2)+"_ITEM"),3,2)
		EndIf
	Endif	
	Replace TRB->D2_ORIGLAN With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_ORIGLAN")
	Replace TRB->D2_LOJA    With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_LOJA")

	If cAlias == "SD2"
		Replace TRB->D2_CUSTO   With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_CUSTO"+Str(mv_par09,1))
		Replace TRB->D2_CLIENTE With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_CLIENTE")
	Else
		Replace TRB->D2_CUSTO  With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_CUSTO"+If((mv_par09==1),"",Str(mv_par09,1)))
	EndIf

	If cAlias == "SD1" .And. cPaisLoc<>"BRA" .And. rtrim(TRB->D2_CLIENTE)=='' .And. (cAliasTrb)->D1_TIPO == 'D'
		Replace TRB->D2_CLIENTE With &(cAliasTrb+"->"+Subs(cAlias,2,2)+"_FORNECE")
	EndIf
	If cAlias == "SD2"
		nPosFirst := AScan(aCampos,{|x| "D2_VALIMP"$Alltrim(x[1]) .or. "D2_BASIMP"$AllTrim(x[1])})
		For nCpo := nPosFirst to Len(aCampos)
			If "D2_VALIMP"$aCampos[nCpo][1] .or. "D2_BASIMP"$aCampos[nCpo][1]
				Replace TRB->&(aCampos[nCpo][1]) With &(cAliasTrb+"->"+Substr(cAlias,2,2)+Substr(aCampos[nCpo][1],3,8))
			EndIf
		Next
	EndIf
	 
	MsUnlock()
	dbSelectArea(cAliasTrb)
	dbSkip()
EndDo
TRB->(dbGoTop())
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SumTaxSD2 ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 20/05/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Soma os valores de acordo com os parametros no arquivo SD2 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR310			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SumTaxSD2(lNoInc)
Local nValRet	:=0, nImpInc:=0,nImpNoInc:=0
Local aImpostos:={}
Local nY := 0

If ( cPaisLoc=="BRA" )
	If lNoInc
		nValRet:=TRB->D2_TOTAL+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",TRB->D2_VALIPI,0)-IF(mv_par14 == 1,0,TRB->D2_VALICM)
	Else
		nValRet:=TRB->D2_TOTAL+IF(mv_par10 == 1 .And. TRB->D2_TIPO <> "P",TRB->D2_VALIPI,0)
	EndIf
Else
	aImpostos:=TesImpInf(TRB->D2_TES)
	For nY:=1 to Len(aImpostos)
		cCampImp:="TRB->D2_"+(Substr(aImpostos[nY][2],4))
		If ( aImpostos[nY][3]=="1" )
			nImpInc  += &cCampImp
		Else
			nImpNoInc+= &cCampImp
		EndIf
	Next
	If lNoInc
		nValRet:=TRB->D2_TOTAL+IF(mv_par10 == 1,nImpInc,0)-IF(mv_par14 == 1,0,nImpNoInc)
	Else
		nValRet:=TRB->D2_TOTAL+IF(mv_par10 == 1,nImpInc,0)
	EndIf
EndIf
If cPaisLoc<>"BRA"
	If TRB->D2_TIPO == "D"
		nValRet := CalcMoed("SF1",nValRet)//Calcula a tasa de la noneda del documento 
	Else
		nValRet := CalcMoed("SF2",nValRet)//Calcula a taxa da moeda de acordo com a venda.
	EndIf 	

EndIf
RETURN nValRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SumTaxSD1 ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 20/05/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Soma os valores de acordo com os parametros no arquivo SD1 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR310			                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SumTaxSD1(lNoInc)
Local nValRet	:=0, nImpInc:=0,nImpNoInc:=0
Local aImpostos:={}
Local nY :=0

If ( cPaisLoc=="BRA" )
	If lNoInc
		nValRet:=D1_TOTAL+IF(mv_par10 == 1 .And. D1_TIPO <> "P",D1_VALIPI,0)-IF(mv_par14 == 1,0,D1_VALICM)
	Else
		nValRet:=D1_TOTAL+IF(mv_par10 == 1 .And. D1_TIPO <> "P",D1_VALIPI,0)
	EndIf
Else
	aImpostos:=TesImpInf(SD1->D1_TES)
	For nY:=1 to Len(aImpostos)
		cCampImp:="SD1->D1_"+(Substr(aImpostos[nY][2],4))
		If ( aImpostos[nY][3]=="1" )
			nImpInc  += &cCampImp
		Else
			nImpNoInc+= &cCampImp
		EndIf
	Next
	If lNoInc
		nValRet:=D1_TOTAL+IF(mv_par10 == 1,nImpInc,0)-IF(mv_par14 == 1,0,nImpNoInc)
	Else
		nValRet:=D1_TOTAL+IF(mv_par10 == 1,nImpInc,0)
	EndIf
EndIf

If cPaisLoc<>"BRA"
	If( TRB->D2_TIPO == "D" .or. D1_TIPO=="D") 
		nValRet := CalcMoed("SF2",nValRet)//Calculo la tasa de la moneda del doc. origen
	Else
		nValRet := CalcMoed("SF1",nValRet)//Calcula a taxa da moeda de acordo com a venda
	EndIf 

EndIf
RETURN nValRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PISCOFINS ºAutor  ³Marcos Vinicius     º Data ³  12/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorno Pis ou Cofins                                      º±±
±±º          ³                                                            º±±
±±ºParametros³cAliasNew - Tabela de Trabalho (SD1,SD2)                    º±±
±±º          ³nPisConf  - Deseja o Valor ou Base do Pis(1) ou do Cofins(2)º±±
±±º          ³nBasVal   - Deseja a Base(1) ou o Valor(2)                  º±±
±±º          ³nEntrSai  - Notas Entrada(1)/Saida(2)                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MATR310                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PisCofins(cAliasNew,nPisCof,nBasVal,nEntrSai)

Local cAliasSB1  := "SB1"
Local cAliasSF4  := "SF4"
Local cAliasSF2  := "SF2"
Local cAliasSF1  := "SF1"
Local cCpVlPisEn := ""
Local cCpBsPisEn := ""
Local cCpVlPisSa := ""
Local cCpBsPisSa := ""
Local cCpVlCofEn :=  ""
Local cCpBsCofEn :=  ""
Local cCpVlCofSa :=  ""
Local cCpBsCofSa :=  ""
Local nRedPis	 := 1
Local nRedCOF	 := 1
Local nPsVlPisEn := 0
Local nPsBsPisEn := 0
Local nPsVlPisSa := 0
Local nPsBsPisSa := 0
Local nPsVlCofEn := 0
Local nPsBsCofEn := 0
Local nPsVlCofSa := 0
Local nPsBsCofSa := 0
Local nScanPis   := 0
Local nScanCof   := 0
Local nTxPIS     := 0
Local nTxCOF     := 0
Local nRetorno   := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento de Notas de Entrada                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If nEntrSai == 1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratamento para os campos do PIS - Entrada                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty( nScanPis := aScan(aRelImp,{|x| x[1]=="SD1" .And. x[3]=="IT_BASEPS2"} ) )
		cCpBsPisEn := aRelImp[nScanPis,2]
		nPsBsPisEn := SD1->(FieldPos(cCpBsPisEn))
	EndIf
	If !Empty( nScanPis := aScan(aRelImp,{|x| x[1]=="SD1" .And. x[3]=="IT_VALPS2"} ) )
		cCpVlPisEn := aRelImp[nScanPis,2]
		nPsVlPisEn := SD1->(FieldPos(cCpVlPisEn))
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratamento para os campos do COF - Entrada                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty( nScanCof := aScan(aRelImp,{|x| x[1]=="SD1" .And. x[3]=="IT_BASECF2"} ) )
		cCpBsCofEn := aRelImp[nScanCof,2]
		nPsBsCofEn := SD1->(FieldPos(cCpBsCofEn))
	EndIf
	If !Empty( nScanCof := aScan(aRelImp,{|x| x[1]=="SD1" .And. x[3]=="IT_VALCF2"} ) )
		cCpVlCofEn := aRelImp[nScanCof,2]
		nPsVlCofEn := SD1->(FieldPos(cCpVlCofEn))
	EndIf

	dbSelectArea(cAliasNew)

	// Posiciona Registros
	SF4->(dbSetOrder(1))
	SF4->(MsSeek(xFilial("SF4") + (cAliasNew)->D1_TES))
	SB1->(dbSetOrder(1))
	SB1->(MsSeek(xFilial("SB1") + (cAliasNew)->D1_COD))
	SF1->(dbSetOrder(1))
	SF1->(MsSeek(xFilial("SF1") +(cAliasNew)->D1_DOC+(cAliasNew)->D1_SERIE+(cAliasNew)->D1_FORNECE+(cAliasNew)->D1_LOJA+(cAliasNew)->D1_TIPO))

	If (cAliasSF4)->F4_AGREG <> "N"
		If SB1->(FieldPos("B1_PPIS")) >0
			nTxPIS	:= 	if((cAliasSB1)->B1_PPIS <> 0,(cAliasSB1)->B1_PPIS , GetMv("MV_TXPIS"))
		Endif
		If SB1->(FieldPos("B1_REDPIS")) > 0
			nRedPIS	:= 	Iif((cAliasSB1)->B1_REDPIS > 0,1-((cAliasSB1)->B1_REDPIS / 100 ), 1 )
		Endif
		If SF4->(FieldPos("F4_BASEPIS")) > 0
			nRedPIS	*= 	Iif((cAliasSF4)->F4_BASEPIS > 0,1-((cAliasSF4)->F4_BASEPIS / 100 ), 1 )
		Endif
		If SB1->(FieldPos("B1_REDCOF")) > 0
			nRedCOF	:= 	Iif((cAliasSB1)->B1_REDCOF > 0,1-((cAliasSB1)->B1_REDCOF / 100 ), 1 )
		Endif
		If SF4->(FieldPos("F4_BASECOF")) > 0
			nRedCOF	*= 	Iif((cAliasSF4)->F4_BASECOF > 0,1-((cAliasSF4)->F4_BASECOF / 100 ), 1 )
		EndIf
		If SB1->(FieldPos("B1_PCOFINS")) > 0
			nTxCOF	:=	if((cAliasSB1)->B1_PCOFINS <> 0,(cAliasSB1)->B1_PCOFINS , GetMv("MV_TXCOFIN"))
		Endif

		If SF4->(FieldPos("F4_PISCOF")) >0

			If (cAliasSF4)->F4_PISCOF $ "13" .And. nPisCof == 1 //1-PIS

				If SF4->(FieldPos("F4_PISCRED")) >0
					nRetorno := 0
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se existem os campos para gravacao do valor/base do PIS  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !Empty( nPsVlPisEn ) .And. !Empty( nPsBsPisEn )
						If nBasVal == 2
							nRetorno := ( cAliasNew )->( FieldGet( nPsVlPisEn ) )
						Else
							nRetorno := ( cAliasNew )->( FieldGet( nPsBsPisEn ) )
						Endif
					EndIf

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se existe algum valor gravado, se nao, calcula           ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !Empty( nRetorno )
						If (cAliasSF4)->F4_PISCRED =="1"  //1-Credita;2-Debita
							If nBasVal == 2
								nRetorno := ( cAliasNew )->( FieldGet( nPsVlPisEn ) )
							Else
								nRetorno := ( cAliasNew )->( FieldGet( nPsBsPisEn ) )
							Endif
						ElseIf (cAliasSF4)->F4_PISCRED =="2"
							If nBasVal == 2
								nRetorno := ( cAliasNew )->( FieldGet( nPsVlPisEn ) )
							Else
								nRetorno := ( cAliasNew )->( FieldGet( nPsBsPisEn ) )
							Endif
						Endif

					Else

						If (cAliasSF4)->F4_PISCRED =="1"  //1-Credita;2-Debita
							If nBasVal == 2
								nRetorno  := ( ( (cAliasNew)->D1_TOTAL+((cAliasNew)->D1_TOTAL*((cAliasSF1)->F1_SEGURO+(cAliasSF1)->F1_DESPESA+(cAliasSF1)->F1_FRETE)/(cAliasSF1)->F1_VALMERC)-(cAliasNew)->D1_VALDESC) * nRedPis) * (nTxPIS/100)
							Else
								nRetorno := ( (cAliasNew)->D1_TOTAL+((cAliasNew)->D1_TOTAL*((cAliasSF1)->F1_SEGURO+(cAliasSF1)->F1_DESPESA+(cAliasSF1)->F1_FRETE)/(cAliasSF1)->F1_VALMERC)-(cAliasNew)->D1_VALDESC )  * nRedPis
							Endif
						ElseIf (cAliasSF4)->F4_PISCRED =="2"
							If nBasVal == 2
								nRetorno := ( ( (cAliasNew)->D1_TOTAL+((cAliasNew)->D1_TOTAL*((cAliasSF1)->F1_SEGURO+(cAliasSF1)->F1_DESPESA+(cAliasSF1)->F1_FRETE)/(cAliasSF1)->F1_VALMERC)-(cAliasNew)->D1_VALDESC) * nRedPis) * (nTxPIS/100)
							Else
								nRetorno := ( (cAliasNew)->D1_TOTAL+((cAliasNew)->D1_TOTAL*((cAliasSF1)->F1_SEGURO+(cAliasSF1)->F1_DESPESA+(cAliasSF1)->F1_FRETE)/(cAliasSF1)->F1_VALMERC)-(cAliasNew)->D1_VALDESC  ) * nRedPis
							Endif
						Endif

					EndIf

				EndIf

			ElseIf (cAliasSF4)->F4_PISCOF $ "23" .And. nPisCof == 2 // 2-Cofins

				If SF4->(FieldPos("F4_PISCRED")) >0

					nRetorno := 0

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se existem os campos para gravacao do valor/base da COFINS ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !Empty( nPsVlCofEn ) .And. !Empty( nPsBsCofEn )
						If nBasVal == 2
							nRetorno := ( cAliasNew )->( FieldGet( nPsVlCofEn ) )
						Else
							nRetorno := ( cAliasNew )->( FieldGet( nPsBsCofEn ) )
						Endif
					EndIf

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se existe algum valor gravado, se nao, calcula           ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !Empty( nRetorno )

						If (cAliasSF4)->F4_PISCRED =="1"  //1-Credita;2-Debita
							If nBasVal == 2
								nRetorno := ( cAliasNew )->( FieldGet( nPsVlCofEn ) )
							Else
								nRetorno := ( cAliasNew )->( FieldGet( nPsBsCofEn ) )
							Endif
						ElseIf (cAliasSF4)->F4_PISCRED =="2"
							If nBasVal == 2
								nRetorno := ( cAliasNew )->( FieldGet( nPsVlCofEn ) )
							Else
								nRetorno := ( cAliasNew )->( FieldGet( nPsBsCofEn ) )
							Endif
						Endif

					Else

						If (cAliasSF4)->F4_PISCRED =="1"  //1-Credita ;2-Debita
							If nBasVal == 2
								nRetorno := ( ( (cAliasNew)->D1_TOTAL+((cAliasNew)->D1_TOTAL*((cAliasSF1)->F1_SEGURO+(cAliasSF1)->F1_DESPESA+(cAliasSF1)->F1_FRETE)/(cAliasSF1)->F1_VALMERC)-(cAliasNew)->D1_VALDESC )  * nRedCOF) * (nTxCOF/100)
							Else
								nRetorno := ( (cAliasNew)->D1_TOTAL+((cAliasNew)->D1_TOTAL*((cAliasSF1)->F1_SEGURO+(cAliasSF1)->F1_DESPESA+(cAliasSF1)->F1_FRETE)/(cAliasSF1)->F1_VALMERC)-(cAliasNew)->D1_VALDESC  ) * nRedCOF
							Endif

						ElseIf	(cAliasSF4)->F4_PISCRED =="2"

							If nBasVal == 2
								nRetorno := ( ( (cAliasNew)->D1_TOTAL+((cAliasNew)->D1_TOTAL*((cAliasSF1)->F1_SEGURO+(cAliasSF1)->F1_DESPESA+(cAliasSF1)->F1_FRETE)/(cAliasSF1)->F1_VALMERC)-(cAliasNew)->D1_VALDESC )  * nRedCOF) * (nTxCOF/100)
							Else
								nRetorno := ( (cAliasNew)->D1_TOTAL+((cAliasNew)->D1_TOTAL*((cAliasSF1)->F1_SEGURO+(cAliasSF1)->F1_DESPESA+(cAliasSF1)->F1_FRETE)/(cAliasSF1)->F1_VALMERC)-(cAliasNew)->D1_VALDESC  ) * nRedCOF
							Endif

						Endif

					Endif

				Endif

			Endif

		EndIf

	EndIf

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento de Notas de Saida                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If nEntrSai == 2

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratamento para os campos do PIS - Saida                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty( nScanPis := aScan(aRelImp2,{|x| x[1]=="SD2" .And. x[3]=="IT_BASEPS2"} ) )
		cCpBsPisSa := aRelImp2[nScanPis,2]
		nPsBsPisSa := (cAliasNew)->(FieldPos(cCpBsPisSa))
	EndIf
	If !Empty( nScanPis := aScan(aRelImp2,{|x| x[1]=="SD2" .And. x[3]=="IT_VALPS2"} ) )
		cCpVlPisSa := aRelImp2[nScanPis,2]
		nPsVlPisSa := (cAliasNew)->(FieldPos(cCpVlPisSa))
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratamento para os campos do COF - Saida                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty( nScanCof := aScan(aRelImp2,{|x| x[1]=="SD2" .And. x[3]=="IT_BASECF2"} ) )
		cCpBsCofSa := aRelImp2[nScanCof,2]
		nPsBsCofSa := (cAliasNew)->(FieldPos(cCpBsCofSa))
	EndIf
	If !Empty( nScanCof := aScan(aRelImp2,{|x| x[1]=="SD2" .And. x[3]=="IT_VALCF2"} ) )
		cCpVlCofSa := aRelImp2[nScanCof,2]
		nPsVlCofSa := (cAliasNew)->(FieldPos(cCpVlCofSa))
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processamento das Notas de Saida                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	dbSelectArea(cAliasNew)

	// Posiciona Registros
	SF4->(dbSetOrder(1))
	SF4->(MsSeek(xFilial("SF4") + (cAliasNew)->D2_TES))
	SB1->(dbSetOrder(1))
	SB1->(MsSeek(xFilial("SB1") + (cAliasNew)->D2_COD))
	SF2->(dbSetOrder(1))
	SF2->(MsSeek(xFilial("SF2") + (cAliasNew)->D2_DOC+(cAliasNew)->D2_SERIE+(cAliasNew)->D2_CLIENTE+(cAliasNew)->D2_LOJA))

	If (cAliasSF4)->F4_AGREG <> "N"

		If SB1->(FieldPos("B1_PPIS")) >0
			nTxPIS	:= 	if((cAliasSB1)->B1_PPIS <> 0,(cAliasSB1)->B1_PPIS , GetMv("MV_TXPIS"))
		Endif
		If SB1->(FieldPos("B1_REDPIS")) > 0
			nRedPIS	:= 	Iif((cAliasSB1)->B1_REDPIS > 0,1-((cAliasSB1)->B1_REDPIS / 100 ), 1 )
		Endif
		If SF4->(FieldPos("F4_BASEPIS")) > 0
			nRedPIS	*= 	Iif((cAliasSF4)->F4_BASEPIS > 0,1-((cAliasSF4)->F4_BASEPIS / 100 ), 1 )
		Endif
		If SB1->(FieldPos("B1_REDCOF")) > 0
			nRedCOF	:= 	Iif((cAliasSB1)->B1_REDCOF > 0,1-((cAliasSB1)->B1_REDCOF / 100 ), 1 )
		EndIf
		If SF4->(FieldPos("F4_BASECOF")) > 0
			nRedCOF	*= 	Iif((cAliasSF4)->F4_BASECOF > 0,1-((cAliasSF4)->F4_BASECOF / 100 ), 1 )
		EndIf
		If SB1->(FieldPos("B1_PCOFINS")) > 0
			nTxCOF	:=	if((cAliasSB1)->B1_PCOFINS <> 0,(cAliasSB1)->B1_PCOFINS , GetMv("MV_TXCOFIN"))
		Endif
		
		If SF4->(FieldPos("F4_PISCOF")) > 0

			If (cAliasSF4)->F4_PISCOF $ "13" .And. nPisCof == 1 //1-PIS
				nRetorno := 0

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se existem os campos para gravacao do valor/base do PIS  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !Empty( nPsVlPisSa ) .And. !Empty( nPsBsPisSa )
					If nBasVal == 2
						nRetorno := ( cAliasNew )->( FieldGet( nPsVlPisSa ) )
					Else
						nRetorno := ( cAliasNew )->( FieldGet( nPsBsPisSa ) )
					Endif
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se existe algum valor gravado, se nao, calcula           ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !Empty( nRetorno )

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Sempre efetua o debito na saida                                   ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If nBasVal == 2
						nRetorno := ( cAliasNew )->( FieldGet( nPsVlPisSa ) )
					Else
						nRetorno := ( cAliasNew )->( FieldGet( nPsBsPisSa ) )
					Endif

					If SF4->(FieldPos("F4_PISCRED")) >0
						If (cAliasSF4)->F4_PISCRED =="1"  //1-Credita;2-Debita
							If nBasVal == 2
								nRetorno := ( cAliasNew )->( FieldGet( nPsVlPisSa ) )
							Else
								nRetorno := ( cAliasNew )->( FieldGet( nPsBsPisSa ) )
							Endif
						Endif
					Endif

				Else

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Sempre efetua o debito na saida                                   ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If nBasVal == 2
						nRetorno := ( ( (cAliasNew)->D2_TOTAL+((cAliasNew)->D2_TOTAL*((cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_DESPESA+(cAliasSF2)->F2_FRETE)/(cAliasSF2)->F2_VALMERC) ) * nRedPis ) * (nTxPIS/100)
					Else
						nRetorno := ( (cAliasNew)->D2_TOTAL+((cAliasNew)->D2_TOTAL*((cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_DESPESA+(cAliasSF2)->F2_FRETE)/(cAliasSF2)->F2_VALMERC)  ) * nRedPis
					Endif

					If SF4->(FieldPos("F4_PISCRED")) >0
						If (cAliasSF4)->F4_PISCRED =="1"  //1-Credita;2-Debita
							If nBasVal == 2
								nRetorno  := ( ( (cAliasNew)->D2_TOTAL+((cAliasNew)->D2_TOTAL*((cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_DESPESA+(cAliasSF2)->F2_FRETE)/(cAliasSF2)->F2_VALMERC) )  * nRedPis) * (nTxPIS/100)
							Else
								nRetorno  := ( (cAliasNew)->D2_TOTAL+((cAliasNew)->D2_TOTAL*((cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_DESPESA+(cAliasSF2)->F2_FRETE)/(cAliasSF2)->F2_VALMERC)  ) * nRedPis
							Endif
						Endif
					Endif

				EndIf

			ElseIf (cAliasSF4)->F4_PISCOF $ "23" .And. nPisCof == 2 // 2-Cofins

				nRetorno := 0

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se existem os campos para gravacao do valor/base do COFINS ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !Empty( nPsVlCofSa ) .And. !Empty( nPsBsCofSa )
					If nBasVal == 2
						nRetorno :=( cAliasNew )->( FieldGet( nPsVlCofSa ) )
					Else
						nRetorno :=( cAliasNew )->( FieldGet( nPsBsCofSa ) )
					Endif
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se existe algum valor gravado, se nao, calcula           ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !Empty( nRetorno )
					If nBasVal == 2
						nRetono := ( cAliasNew )->( FieldGet( nPsVlCofSa ) )
					Else
						nRetorno:= ( cAliasNew )->( FieldGet( nPsBsCofSa ) )
					Endif

					If SF4->(FieldPos("F4_PISCRED")) >0
						If (cAliasSF4)->F4_PISCRED =="1"  //1-Credita;2-Debita
							If nBasVal == 2
								nRetono := ( cAliasNew )->( FieldGet( nPsVlCofSa ) )
							Else
								nRetorno:= ( cAliasNew )->( FieldGet( nPsBsCofSa ) )
							Endif
						Endif
					Endif

				Else
					If nBasVal == 2
						nRetorno := ( ( (cAliasNew)->D2_TOTAL+((cAliasNew)->D2_TOTAL*((cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_DESPESA+(cAliasSF2)->F2_FRETE)/(cAliasSF2)->F2_VALMERC) ) * nRedCOF) * (nTxCOF/100)
					Else
						nRetorno := ( (cAliasNew)->D2_TOTAL+((cAliasNew)->D2_TOTAL*((cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_DESPESA+(cAliasSF2)->F2_FRETE)/(cAliasSF2)->F2_VALMERC)  ) * nRedCOF
					Endif

					If SF4->(FieldPos("F4_PISCRED")) >0
						If (cAliasSF4)->F4_PISCRED =="1"  //1-Credita ;2-Debita
							If nBasVal == 2
								nRetorno := ( ( (cAliasNew)->D2_TOTAL+((cAliasNew)->D2_TOTAL*((cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_DESPESA+(cAliasSF2)->F2_FRETE)/(cAliasSF2)->F2_VALMERC) )  * nRedCOF) * (nTxCOF/100)
							Else
								nRetorno := ( (cAliasNew)->D2_TOTAL+((cAliasNew)->D2_TOTAL*((cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_DESPESA+(cAliasSF2)->F2_FRETE)/(cAliasSF2)->F2_VALMERC)  ) * nRedCOF
							Endif
						Endif
					Endif

				Endif

			EndIf

		EndIf

	Endif
Endif

RETURN(nRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CalcMoed  ºRafael P. Rizzatto  ³Microsiga  º Data ³  07/10/04    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de localizacoes que calcula a taxa da moeda de acordo    º±±
±±º          ³ com a  venda do produto. Nota de Credito/Cliente (Entrada)      º±±
±±º          ³ e Venda/Fatutamento (Saida).                                    º±±
±±º          ³                                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7                                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CalcMoed(cTab,nVal)
Local nValor :=0
Local aArea:={}
Local aAreaSF2:={}
Local aAreaSF1:={}
Local nMoedaOri:= 0

If cTab == "SF2"
	aArea:=GetArea()
	aAreaSF2:=SF2->(GetArea())
	SF2->(dbSetOrder(1))
	SF2->(MsSeek(xFilial("SF2") + TRB->D2_DOC+TRB->D2_SERIE+TRB->D2_CLIENTE+TRB->D2_LOJA))
	nMoedaOri:=SF2->F2_MOEDA
	RestArea(aArea)
	SF2->(RestArea(aAreaSF2))
	nValor := xMoeda( nVal, nMoedaOri, mv_par09, TRB->D2_EMISSAO )
ElseIf cTab == "SF1"
	aArea:=GetArea()
	aAreaSF1:=SF1->(GetArea())
	SF1->(dbSetOrder(1))
	SF1->(MsSeek(xFilial("SF1")+TRB->D2_DOC+TRB->D2_SERIE+TRB->D2_CLIENTE+TRB->D2_LOJA+TRB->D2_TIPO,.F.))
	nMoedaOri:=SF1->F1_MOEDA
	RestArea(aArea)
	SF1->(RestArea(aAreaSF1))
	nValor := xMoeda( nVal, nMoedaOri, mv_par09, TRB->D2_EMISSAO )
EndIf

Return nValor
