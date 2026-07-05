/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR180.CH"
#Include "PROTHEUS.Ch"

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR180  ³ Autor ³ Adrianne Furtado      ³ Data ³ 02.09.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡„o das baixas por lote                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR180(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR180()

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
±±³Programa  ³ReportDef ³ Autor ³Adrianne Furtado       ³ Data ³14.09.2006³±±
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

Local oReport

/*
GESTAO - inicio */
Local oSecFil	:= Nil
/* GESTAO - fim
*/
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
oReport := TReport():New("FINR180",OemToAnsi(STR0011),"FIN180", {|oReport| ReportPrint(oReport)},STR0001+" "+STR0002) //"Relacao de Baixas por Lote"##"Este programa ira emitir a relacao dos titulos baixados"##"por Lote."
Pergunte("FIN180",.F.)

oBaixas := TRSection():New(oReport,"Baixas",{"SE5"},{},,,STR0031)		//"Total"
oBaixas:SetHeaderPage()
oBaixas:SetTotalInLine(.F.)
/*
GESTAO - inicio */
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/
TRCell():New(oBaixas,"E5_LOTE"		,, STR0012,,Tamsx3("E5_LOTE")[1],.F.)	//"Lote"
TRCell():New(oBaixas,"E5_FILORIG"	,, SX3->(RetTitle("E5_FILORIG")),,,.F.)
TRCell():New(oBaixas,"E5_PREFIXO"	,, STR0013,,TamSX3("E5_PREFIXO")[1],.F.)	//"Prf"
TRCell():New(oBaixas,"E5_NUMERO" 	,, STR0014,,TamSX3("E5_NUMERO")[1]+2,.F.)	//"Numero"
TRCell():New(oBaixas,"E5_PARCELA"	,, STR0015,,TamSX3("E5_PARCELA")[1]+2,.F.)	//"PC"
TRCell():New(oBaixas,"CLIENTE/FORN"	,, STR0016,,20,.F.)	//"Cliente/Forn"
TRCell():New(oBaixas,"E5_VALOR"		,, STR0017,,20,/*lPixel*/,,,,,,,.T.)	//"Valor Original"
TRCell():New(oBaixas,"E5_DATA"		,, STR0018,,12,.F.,,,,,,,.T.)	//"Data Baixa"
TRCell():New(oBaixas,"DESCONTO"		,, STR0019,,8,/*lPixel*/,,,,,,,.T.)	//"Descontos"
TRCell():New(oBaixas,"JUROS"		,, STR0020,,8,/*lPixel*/,,,,,,,.T.)	//"Juros"
TRCell():New(oBaixas,"MULTA"		,, STR0021,,8,/*lPixel*/,,,,,,,.T.)	//"Multas"
TRCell():New(oBaixas,"CORRECAO"		,, STR0022,,8,/*lPixel*/,,,,,,,.T.)	//"Corr Monet"
TRCell():New(oBaixas,"ABATIMENTO"	,, STR0023,,8,/*lPixel*/,,,,,,,.T.)	//"Abatimentos"
TRCell():New(oBaixas,"VL_PG/VL_RCB"	,, ""	  ,,20 ,/*lPixel*/,,,,,,,.T.)	//"Valor Recebido"

oReport:NoUserFilter()
/*
GESTAO - inicio */
/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SE1","SED"})
TRCell():New(oSecFil,"CODFIL",,STR0026,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)					//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0027,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)					//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0028,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)					//"Unidade de negocio"
TRCell():New(oSecFil,"NOMEFIL",,STR0029,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)					//"Filial"
/* GESTAO - fim
*/
Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³16.05.2006³±±
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
Local oBaixas	:= oReport:Section(1)
//Local cAliasSE5	:= "SE5"
Local cTitulo 	:= ""
Local oBreak1
Local aRelat	:={}
Local nI
/*
GESTAO - inicio */
Local aSelFil		:= {}
Local aSM0			:= {}
Local nTamEmp		:= 0
Local nTamUnNeg		:= 0
Local nTamTit		:= 0
Local nX			:= 0
Local cFiLSel		:= ""
Local oSecFil		:= oReport:Section("SECFIL")
Local cPictVal		:= PesqPict("SE5","E5_VALOR",16,MV_PAR04)
/* GESTAO - fim
*/
Private cFilterUser := oBaixas:GetAdvplExp("SE5")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par03==1
	cTitulo:=OemToAnsi(STR0005)+ mv_par01+OemToAnsi(STR0006)+mv_par02  //"Relacao dos Titulos Recebidos do Lote "### " a "
	oBaixas:Cell("VL_PG/VL_RCB"):SetTitle(STR0024)
Else
	cTitulo:=OemToAnsi(STR0007)+mv_par01+OemToAnsi(STR0006)+mv_par02  //"Relacao dos Titulos Pagos do Lote "###" a "
	oBaixas:Cell("VL_PG/VL_RCB"):SetTitle(STR0025)
EndIF

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³aRelat[x][01]: "Lote"			³
//³         [02]: "Prf" 			³
//³         [03]: "Numero"			³
//³         [04]: "PC"				³
//³         [05]: "Cliente/Forn"	³
//³         [06]: "Valor Original"	³
//³         [07]: "Data Baixa"      ³
//³         [08]: "Descontos"       ³
//³         [09]: "Juros"       	³
//³         [10]: "Multas"    		³
//³         [11]: "Corr Monet"   	³
//³         [12]: "Abatimentos"    	³
//³         [13]: "Valor Recebido" 	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
/*
GESTAO - inicio */
#IFDEF TOP
	If MV_PAR06 == 1
		AdmSelecFil(,,.F.,@aSelFil,"SE1",.F.)
	Endif
	If Empty(aSelFil)
		Aadd(aSelFil,cFilAnt)
	Endif
#ELSE
	aSelFil := {}
#ENDIF
/* GESTAO - fim
*/
aRelat := FA180ImpR4(@aSelFil)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oBaixas:Cell("E5_LOTE")		:SetBlock( { || aRelat[nI,01] } )
oBaixas:Cell("E5_PREFIXO")	:SetBlock( { || aRelat[nI,02] } )
oBaixas:Cell("E5_NUMERO")	:SetBlock( { || aRelat[nI,03] } )
oBaixas:Cell("E5_PARCELA")	:SetBlock( { || aRelat[nI,04] } )
oBaixas:Cell("CLIENTE/FORN"):SetBlock( { || aRelat[nI,05] } )
oBaixas:Cell("E5_VALOR")	:SetBlock( { || aRelat[nI,06] } )
oBaixas:Cell("E5_DATA")		:SetBlock( { || aRelat[nI,07] } )
oBaixas:Cell("DESCONTO")	:SetBlock( { || aRelat[nI,08] } )
oBaixas:Cell("JUROS")		:SetBlock( { || aRelat[nI,09] } )
oBaixas:Cell("MULTA")		:SetBlock( { || aRelat[nI,10] } )
oBaixas:Cell("CORRECAO")	:SetBlock( { || aRelat[nI,11] } )
oBaixas:Cell("ABATIMENTO")	:SetBlock( { || aRelat[nI,12] } )
oBaixas:Cell("VL_PG/VL_RCB"):SetBlock( { || aRelat[nI,13] } )
oBaixas:Cell("E5_FILORIG")  :SetBlock( { || aRelat[nI,14] } )

oBreak1 := TRBreak():New( oBaixas, oBaixas:Cell("E5_LOTE"), "")
TRFunction():New(oBaixas:Cell("DESCONTO")	 	,/*[cID*/, "SUM", oBreak1  , "", cPictVal, /*[ uFormula ]*/ , .T., .F.)
TRFunction():New(oBaixas:Cell("JUROS")			,/*[cID*/, "SUM", oBreak1  , "", cPictVal, /*[ uFormula ]*/ , .T., .F.)
TRFunction():New(oBaixas:Cell("MULTA")	 		,/*[cID*/, "SUM", oBreak1  , "", cPictVal, /*[ uFormula ]*/ , .T., .F.)
TRFunction():New(oBaixas:Cell("CORRECAO")	 	,/*[cID*/, "SUM", oBreak1  , "", cPictVal, /*[ uFormula ]*/ , .T., .F.)
TRFunction():New(oBaixas:Cell("ABATIMENTO") 	,/*[cID*/, "SUM", oBreak1  , "", cPictVal, /*[ uFormula ]*/ , .T., .F.)
TRFunction():New(oBaixas:Cell("VL_PG/VL_RCB")	,/*[cID*/, "SUM", oBreak1  , "", cPictVal, /*[ uFormula ]*/ , .T., .F.)

oBaixas:Cell("E5_VALOR")	:SetPicture(cPictVal)
oBaixas:Cell("DESCONTO")	:SetPicture(cPictVal)
oBaixas:Cell("JUROS")		:SetPicture(cPictVal)
oBaixas:Cell("MULTA")		:SetPicture(cPictVal)
oBaixas:Cell("CORRECAO")	:SetPicture(cPictVal)
oBaixas:Cell("ABATIMENTO")	:SetPicture(cPictVal)
oBaixas:Cell("VL_PG/VL_RCB"):SetPicture(cPictVal)

oReport:SetTitle(cTitulo)
oReport:SetMeter(Len(aRelat))
/*
GESTAO - inicio */
/* imprime a lista de filiais selecionadas para o relatorio */
If Len(aSelFil) > 1 .And. !Empty(aRelat)
	oBaixas:SetHeaderSection(.F.)
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0030 + ")")		//"Filiais selecionadas para o relatorio"
	nTamTit := Len(oReport:Title())
	oSecFil:Init()
	oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
	oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
	oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
	oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})
	For nX := 1 To Len(aSelFil)
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
	oBaixas:SetHeaderSection(.T.)
	oReport:EndPage()
Endif
/* GESTAO - fim
*/
oBaixas:Init()
nI := 1
While nI <= Len(aRelat)
	If oReport:Cancel()
		Exit
	EndIf
	oReport:IncMeter()
	oBaixas:PrintLine()
	nI++
EndDo
oBaixas:Finish()

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR180R4³ Autor ³ Adrianne Furtado      ³ Data ³ 14.09.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao dos titulos baixados por lote                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR180()				             		                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FA180ImpR4(aSelFil)

LOCAL nValor:=0,nDesc:=0,nJuros:=0,nMulta:=0,nCM:=0
LOCAL nTotValor:=0,nTotDesc:=0,nTotJuros:=0,nTotMulta:=0,nTotCM:=0
LOCAL cNumero,cPrefixo,cParcela,dBaixa,cLote:="",cLoteQuebra
Local nAbat := nTotAbat := 0
Local cTipo := cCliFor  := cLoja := ""
LOCAL nLotValor:=0,nLotDesc:=0,nLotJuros:=0,nLotMulta:=0,nLotCM:=0,nLotAbat:=0
Local ndecs:=Msdecimais(mv_par04)
Local aRet := {}

//Controla o Pis Cofins e Csll na baixa (1-Retem PCC na Baixa ou 2-Retem PCC na Emissão(default))
Local lPccBxCr	:= FPccBxCr()
Local nPccBxCr := 0

Local lIrPjBxCr := .f.
Local nIrPjBxCr  := 0

//Controla o Pis Cofins e Csll na RA (1 = Controla retenção de impostos no RA; ou 2 = Não controla retenção de impostos no RA(default))
Local lRaRtImp  := FRaRtImp()
/*
GESTAO - inicio */
Local cQuery	:= ""
Local cTmpFil	:= ""
Local cAliasSE5	:= ""
Local cFilOrig	:= ""
Local cFilSE5	:= ""

Default aSelFil	:= {}

li       := 1
m_pag    := 1

dbSelectArea("SE5")
dbSetOrder(5)

If (lSelFil := (!Empty(aSelFil)))
	cFilOrig := cFilAnt
	cAliasSE5 := GetNextAlias()
	cQuery := "select E5_LOTE,E5_FILORIG,E5_PREFIXO,E5_NUMERO,E5_PARCELA,E5_TIPO,E5_DATA,E5_CLIFOR,E5_LOJA,E5_SEQ,"
	cQuery += "E5_VALOR,E5_TXMOEDA,E5_PRETPIS,E5_VRETPIS,E5_PRETCOF,E5_VRETCOF,E5_PRETCSL,E5_VRETCSL, E5_VRETIRF, E5_BANCO,
	cQuery += "E5_AGENCIA,E5_CONTA,E5_TIPODOC,R_E_C_N_O_"
	cQuery += " from " + RetSQLName("SE5")
	cQuery += " where E5_FILIAL " + GetRngFil(aSelFil,"SE5",.T.,@cTmpFil)
	cQuery += " and D_E_L_E_T_ = ' '"
	cQuery += " and not (E5_SITUACA = 'C')"
	cQuery += " and not (E5_LOTE = '" + Space(Len(SE5->E5_LOTE)) + "')"
	cQuery += " and E5_LOTE >= '" + MV_PAR01 + "'"
	cQuery += " and E5_LOTE <= '" + MV_PAR02 + "'"
	IF mv_par03 == 1
		cQuery += " and E5_RECPAG = 'R'"
	Else
		cQuery += " and E5_RECPAG = 'P'"
	Endif
	cQuery += " and not (E5_DATA = '" + Space(TamSX3("E5_DATA")[1]) + "')"
	cQuery += " and not (E5_NUMERO = '" + Space(Len(SE5->E5_NUMERO)) + "')"
	If !(cPaisLoc == "BRA")
		If mv_par05 == 2
			cQuery += "E5_MOEDA = '" + StrZero(mv_par04,TamSX3("E5_MOEDA")[1]) + "'"
		Endif
	Endif
	cQuery += " order by E5_LOTE,E5_FILORIG,E5_PREFIXO,E5_NUMERO,E5_PARCELA,E5_TIPO,E5_DATA"
	cQuery := ChangeQuery(cQuery)
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSE5,.F.,.T.)
Else
	cAliasSE5 := "SE5"
	dbSeek(cFilial+mv_par01,.T.)
Endif
/*-*/
While !(cAliasSE5)->(Eof()) .And. (lSelFil .Or. (SE5->E5_FILIAL==cFilial .And. SE5->E5_LOTE >= mv_par01 .And. SE5->E5_LOTE <= mv_par02))

	IF lSelFil
		SE5->(DbGoTo((cAliasSE5)->R_E_C_N_O_))
		cFilAnt := SE5->E5_FILORIG
	Else
		If Empty(SE5->E5_LOTE) .or. SE5->E5_SITUACA == "C"
			(cAliasSE5)->(dbSkip())
			Loop
		EndIF
	Endif

	//Considera Filtro de usuario
	If !empty(cFilterUser) .AND. !(&cFilterUser)
		(cAliasSE5)->(dbSkip())
		Loop
	EndIf

	cLoteQuebra := (cAliasSE5)->E5_LOTE

	While !((cAliasSE5)->(Eof())) .and. (cAliasSE5)->E5_LOTE == cLoteQuebra .and. (lSelFil .Or. (cAliasSE5)->E5_FILIAL == xFilial())

		If lSelFil
			SE5->(DbGoTo((cAliasSE5)->R_E_C_N_O_))
			cFilAnt := SE5->E5_FILORIG
		Else
			IF Empty(SE5->E5_LOTE) .or. SE5->E5_SITUACA == "C"
				Skip
				Loop
			EndIF

			If cPaisLoc <> "BRA"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se deve imprimir outras moedas³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par05 == 2 // nao imprime
					If Val(SE5->E5_MOEDA) != mv_par04 //verifica moeda do campo=moeda parametro
						dbSkip()
						Loop
					Endif
				Endif
			Endif

			IF mv_par03 == 1 .and. SE5->E5_RECPAG = "P"    //N„o ‚ recebimento
				DbSkip()
				Loop
			EndIF

			IF mv_par03 == 2 .and. SE5->E5_RECPAG = "R"    //Nao ‚ pagamento
				DbSkip()
				Loop
			EndIF
		Endif

		cNumero  := (cAliasSE5)->E5_NUMERO
		cPrefixo := (cAliasSE5)->E5_PREFIXO
		cParcela := (cAliasSE5)->E5_PARCELA
		dBaixa   := Iif(!Empty((cAliasSE5)->E5_DATA), STOD((cAliasSE5)->E5_DATA), (cAliasSE5)->E5_DATA)
		cLote    := (cAliasSE5)->E5_LOTE
		cTipo    := (cAliasSE5)->E5_TIPO
		cCliFor  := (cAliasSE5)->E5_CLIFOR
		cLoja    := (cAliasSE5)->E5_LOJA
		cFilSE5  := (cAliasSE5)->E5_FILORIG

		Store 0 To nDesc,nCM,nJuros,nValor,nMulta

		
		If mv_par03 == 1
			SA1->(DbSetOrder(1))			
			If SA1->(MsSeek(xFilial("SA1")+ cCliFor + cLoja))
				lIrPjBxCr := FIrPjBxCr(.T.) //Define se a retenção do IR do contas a receber será na baixa quando o cliente for PJ empresas mistas ou publicas.
			EndIf
		else
			DbSelectArea("SA2")
			DbSetOrder(1)
			MsSeek(xFilial("SA2") +cCliFor + cLoja)
		EndIf

		While !((cAliasSE5)->(EOF())) .and. If(lSelFil,(cAliasSE5)->E5_FILORIG == cFilSE5,.T.) .and. (cAliasSE5)->E5_PREFIXO + (cAliasSE5)->E5_NUMERO + (cAliasSE5)->E5_PARCELA + (cAliasSE5)->E5_TIPO + (cAliasSE5)->E5_CLIFOR + (cAliasSE5)->E5_LOJA == cPrefixo+cNumero+cParcela+cTipo+cCliFor+cLoja

			If lSelFil
				cFilAnt := (cAliasSE5)->E5_FILORIG
				SE5->(DbGoTo((cAliasSE5)->R_E_C_N_O_))
			Else
				IF Empty(SE5->E5_DATA) .or. Empty(SE5->E5_NUMERO) .or. SE5->E5_SITUACA == "C" .or. Empty(SE5->E5_LOTE)
					DbSkip()
					Loop
				EndIF

				IF mv_par03 == 1 .and. SE5->E5_RECPAG = "P"    //Nao ‚ recebimento
					DbSkip()
					Loop
				EndIF

				IF mv_par03 == 2 .and. SE5->E5_RECPAG = "R"    //Nao ‚ pagamento
					DbSkip()
					Loop
				EndIF
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se existe baixas estornadas           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If TemBxCanc(SE5->E5_PREFIXO + SE5->E5_NUMERO + SE5->E5_PARCELA + SE5->E5_TIPO + SE5->E5_CLIFOR + SE5->E5_LOJA + SE5->E5_SEQ)
				(cAliasSE5)->(dbskip())
				loop
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Quebra por lote: quando um t¡tulo possuia baixas parciais em dois  ³
			//³ lotes diferentes causavam problemas de recupera‡„o de dados, por   ³
			//³ isso foi instalado esta quebra por lote. Bops 04990-A              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cLote # (cAliasSE5)->E5_LOTE
				Exit
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Pega a moeda do Banco para utiliza-la no segundo parametro da      ³
			//³ fun‡„o Xmoeda quando o Pa¡s <> de Brasil ou controla saldos        ³
			//³ bancarios em multiplas moedas                                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cPaisLoc <> "BRA" .OR. FXMultSld()
				dbSelectArea("SA6")
				dbSetOrder(1)
				dbSeek(xFilial("SA6",(cAliasSE5)->E5_FILORIG) + (cAliasSE5)->E5_BANCO + (cAliasSE5)->E5_AGENCIA + (cAliasSE5)->E5_CONTA)		/* GESTAO */
				nMoedabco := max(SA6->A6_MOEDA,1)
				dbSelectArea("SE5")
				dbSetOrder(5)
			Else
				nMoedabco := 1
			Endif

			Do Case

				Case (cAliasSE5)->E5_TIPODOC $ "DC/D2"
					nTotDesc += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
					nLotDesc += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
					nDesc += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
				Case (cAliasSE5)->E5_TIPODOC $ "JR/J2/TL"
					nTotJuros += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
					nLotJuros += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
					nJuros += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
				Case (cAliasSE5)->E5_TIPODOC $ "MT/M2"
					nTotMulta += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
					nLotMulta += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
					nMulta += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
				Case (cAliasSE5)->E5_TIPODOC $ "CM/C2"
					nTotCm += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
					nLotCm += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
					nCM += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
				Case (cAliasSE5)->E5_TIPODOC $ "VL/V2/BA"
					nLotValor += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
					nValor += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))
					nTotValor += xMoeda((cAliasSE5)->E5_VALOR,nMoedabco,mv_par04,,ndecs+1,,If(cPaisLoc=="BRA",(cAliasSE5)->E5_TXMOEDA,0))

					//Pcc Baixa CR - Ir Baixa CR
					If mv_par03 == 1 .and. cPaisLoc == "BRA" .and. IiF(lRaRtImp,(cAliasSE5)->E5_TIPO $ MVRECANT,.T.)
						
						If lPccBxCr 
							If Empty((cAliasSE5)->E5_PRETPIS)
								nPccBxCr += xMoeda((cAliasSE5)->E5_VRETPIS,nMoedabco,mv_par04,,ndecs+1,,(cAliasSE5)->E5_TXMOEDA)
							Endif
							If Empty((cAliasSE5)->E5_PRETCOF)
								nPccBxCr += xMoeda((cAliasSE5)->E5_VRETCOF,nMoedabco,mv_par04,,ndecs+1,,(cAliasSE5)->E5_TXMOEDA)
							Endif
							If Empty((cAliasSE5)->E5_PRETCSL)
								nPccBxCr += xMoeda((cAliasSE5)->E5_VRETCSL,nMoedabco,mv_par04,,ndecs+1,,(cAliasSE5)->E5_TXMOEDA)
							Endif
						EndIf

						If lIrPjBxCr
							nIrPjBxCr += xMoeda((cAliasSE5)->E5_VRETIRF,nMoedabco,mv_par04,,ndecs+1,,(cAliasSE5)->E5_TXMOEDA)
						EndIf

					Endif

			Endcase

			(cAliasSE5)->(dbSkip())
		EndDO

		IF (nDesc+nValor+nJuros+nMulta) > 0
			AAdd(aRet, Array(14))
			
			IF mv_par03==1
				DbSelectArea("SE1")
			Else
				DbSelectArea("SE2")
			EndIF
			
			dbSeek(cFilial+cPrefixo+cNumero+cParcela+cTipo+cCliFor+cLoja)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calculo do Abatimento						                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par03 == 2				
				nRecno := Recno()
				nAbat  := SomaAbat(cPrefixo,cNumero,cParcela,"P",mv_par04)
				dbSelectArea("SE2")
				dbGoTo(nRecno)
			Else
				nRecno := Recno()
				nAbat  := SomaAbat(cPrefixo,cNumero,cParcela,"R",mv_par04) //Função só abate titulos gerados pela emissão
				nAbat  += nPccBxCr + nIrPjBxCr
				dbSelectArea("SE1")
				dbGoTo(nRecno)
			EndIf

			aRet[li][01] := cLote
			aRet[li][02] := cPrefixo
			aRet[li][03] := cNumero
			aRet[li][04] := cParcela


			IF mv_par03==2
				aRet[li][05] := Left(GetLGPDValue("SA2","A2_NREDUZ"),19)
				aRet[li][06] := xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,mv_par04,,ndecs+1,If(cPaisLoc=="BRA",SE2->E2_TXMOEDA,0))
			Else
				aRet[li][05] := Left(GetLGPDValue("SA1","A1_NREDUZ"),19)
				aRet[li][06] := xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,mv_par04,,ndecs+1,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))
			EndIF

			aRet[li][07] := dBaixa
			aRet[li][08] := nDesc
			aRet[li][09] := nJuros
			aRet[li][10] := nMulta
			aRet[li][11] := nCM
			aRet[li][12] := nAbat
			aRet[li][13] := nValor
			aRet[li][14] := cFilSE5
			li++
			nTotAbat +=nAbat
			nLotAbat +=nAbat
			nAbat := 0
			nPccBxCr := 0
			nIrPjBxCr := 0
		EndIF
		dbSelectArea("SE5")
	Enddo
	nLotDesc:=0
	nLotJuros:=0
	nLotMulta:=0
	nLotCm:=0
	nLotAbat:=0
	nLotValor:=0
	dbSelectArea("SE5")
EndDO
/*-*/
If lSelFil
	cFilAnt := cFilOrig
	DbSelectArea(cAliasSE5)
	DbCloseArea()
	If !Empty(cTmpFil)
		CtbTmpErase(cTmpFil)
	Endif
Endif
/* GESTAO - fim
*/
dbSelectArea("SE5")
dbSetOrder(1)
Set Filter To

Return aRet

