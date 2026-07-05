/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Matr210.ch"
#Include "Protheus.Ch"

Static lLGPD  := FindFunction("SuprLGPD") .And. SuprLGPD()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR210  ³ Autor ³ Alexandre Inacio Lemes³ Data ³08/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡„o de Analise das Cota‡oes.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR210(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr210() 
Local lSigaCusOk := .T.
Local oReport

If lSigaCusOk 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:= ReportDef()
	oReport:PrintDialog()
	
EndIf
                                               
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Alexandre Inacio Lemes ³Data  ³08/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡„o de Analise das Cota‡oes.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nExp01: nReg = Registro posicionado do SC3 apartir Browse  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport 
Local oSection1 
Local oSection2 
Local oSection3 
Local cTitle    := STR0002	//"Relacao de Analise das Cotacoes"
Local cAliasTRB := GetNextAlias()
Local cTitDtNec	:= GetSx3Cache("C8_DATPRF",'X3_TITULO')

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                           ³
//³ mv_par01            // Da cotacao                              ³
//³ mv_par02            // Ate a cotacao                           ³
//³ mv_par03            // Lista por Fornecedor ou Valores         ³
//³ mv_par04            // Sugere TE Padrao (S/N)                  ³
//³ mv_par05            // Lista Encerradas (S/N)                  ³
//³ mv_par06            // Descricao do produto                    ³
//³ mv_par07            // Imprime Aliquota ICMS (Produtos/Cotação)³
//³ mv_par08            // IMprime Aliquota IPI  (Produtos/Cotação)³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("MTR210",.F.)
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
oReport := TReport():New("MTR210",cTitle,"MTR210",{|oReport| ReportPrint(oReport,cAliasTRB)},STR0001) //"Emissao da Relacao de Analise das Cotacoes"
oReport:SetLandscape() 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1:= TRSection():New(oReport,STR0032,{cAliasTRB,"SC8"},/*aOrdem*/) //"Relacao de Analise das Cotacoes"
TRCell():New(oSection1,"TB_NUM"    ,cAliasTRB,STR0011,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:SetTotalInLine(.F.)
oSection1:SetTotalText(STR0031) // "TOTAIS DA COTACAO"

oSection2:= TRSection():New(oSection1,STR0033,{cAliasTRB,"SC8","SB1"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Carga"
TRCell():New(oSection2,"C8_PRODUTO","SC8"   ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"TB_DESCPRO",cAliasTRB,STR0024,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection2:Cell("TB_DESCPRO"):SetLineBreak()

oSection3:= TRSection():New(oSection2,STR0034,{cAliasTRB,"SC8","SB1","SA2"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Carga"
TRCell():New(oSection3,"C8_FORNECE","SC8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"C8_LOJA"   ,"SC8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"TB_NOMEFOR",cAliasTRB,STR0025,/*Picture*/,TamSX3("A2_NREDUZ")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection3,"C8_COND"   ,"SC8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"TB_DESCOND",cAliasTRB,STR0024,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"TB_PRAZO"  ,cAliasTRB,STR0026,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"TB_VLPRES" ,cAliasTRB,STR0027,PesqPict("SC8","C8_TOTAL"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"TB_CREDICM",cAliasTRB,STR0028,PesqPict("SC8","C8_VALICM"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"TB_CREDIPI",cAliasTRB,STR0029,PesqPict("SC8","C8_VALIPI"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"TB_JUROS"  ,cAliasTRB,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"TB_DTENTR" ,cAliasTRB,STR0030,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"TB_DTNECES",cAliasTRB,cTitDtNec,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"A2_DESVIO" ,"SA2"    ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
oSection3:SetHeaderPage()
oSection3:Cell("TB_JUROS"):GetFieldInfo("C8_TAXAFIN") 

TRFunction():New(oSection3:Cell("TB_VLPRES"),NIL,"SUM",/*oBreak*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1)
If cPaisLoc=="BRA"
	TRFunction():New(oSection3:Cell("TB_CREDICM"),NIL,"SUM",/*oBreak*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1) 
	TRFunction():New(oSection3:Cell("TB_CREDIPI"),NIL,"SUM",/*oBreak*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1) 
EndIf                       

oSection2:SetNoFilter("SB1")   
oSection2:SetNoFilter("SC8")
oSection3:SetNoFilter("SA2") 
oSection3:SetNoFilter("SB1")   

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Alexandre Inacio Lemes ³Data  ³09/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡„o de Analise das Cota‡oes.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasTRB)

Local oSection1 	:= oReport:Section(1) 
Local oSection2 	:= oReport:Section(1):Section(1) 
Local oSection3 	:= oReport:Section(1):Section(1):Section(1) 
Local oTempTable	:= NIL
Local aRelImp   	:= MaFisRelImp("MT150",{"SC8"})
Local aCampos  	:= {}
Local aTam	    	:= {}
Local cTes      	:= ""
Local cIcm      	:= ""
Local cIpi      	:= ""
Local cDescPro  	:= ""   
Local cFilUser  	:= ""
Local nJuros    	:= GetMV("MV_JUROS")
Local nY        	:= 0
Local nValIPI   	:= 0
Local nValICMS  	:= 0

If mv_par03 == 1
	oReport:SetTitle(oReport:Title() + " " + STR0022) //"RELACAO DE ANALISE DAS COTACOES POR FORNECEDOR"
Else
	oReport:SetTitle(oReport:Title() + " " + STR0023) //"RELACAO DE ANALISE DAS COTACOES POR VALORES"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria array para gerar arquivo de trabalho                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:= TamSX3("C8_NUM")
AADD(aCampos,{"TB_NUM"    ,"C",aTam[1],aTam[2] } )
aTam:= TamSX3("C8_PRODUTO")
AADD(aCampos,{"TB_PRODUTO","C",aTam[1],aTam[2] } )
aTam:= TamSX3("C8_FORNECE")
AADD(aCampos,{"TB_FORNECE","C",aTam[1],aTam[2] } )
aTam:= TamSX3("C8_FORNOME")
AADD(aCampos,{"TB_FORNOME","C",aTam[1],aTam[2] } )
aTam:= TamSX3("C8_FORNOME")
AADD(aCampos,{"TB_NOMEFOR","C",aTam[1],aTam[2] } )
aTam:= TamSX3("C8_LOJA")
AADD(aCampos,{"TB_LOJA"   ,"C",aTam[1],aTam[2] } )
aTam:= TamSX3("A2_NOME")
AADD(aCampos,{"TB_NOME"   ,"C",aTam[1],aTam[2] } )
aTam:= TamSX3("C8_COND")
AADD(aCampos,{"TB_COND"   ,"C",aTam[1],aTam[2] } )
aTam:= TamSX3("E4_DESCRI")
AADD(aCampos,{"TB_DESCOND","C",aTam[1],aTam[2] } )
aTam:= TamSX3("C8_PRAZO")
AADD(aCampos,{"TB_PRAZO"  ,"N",aTam[1],aTam[2] } )
AADD(aCampos,{"TB_VLPRES" ,"N",14,2 } )
AADD(aCampos,{"TB_CREDICM","N",14,2 } )
AADD(aCampos,{"TB_CREDIPI","N",14,2 } )
AADD(aCampos,{"TB_JUROS"  ,"N",08,4 } )
AADD(aCampos,{"TB_DTENTR" ,"D",08,0 } )
AADD(aCampos,{"TB_DTNECES","D",08,0 } )
aTam:= TamSX3("A2_DESVIO")
AADD(aCampos,{"TB_DESVIO" ,"N",aTam[1],aTam[2] } )
aTam:= TamSX3("C8_ITEM")
AADD(aCampos,{"TB_ITEM"   ,"C",aTam[1],aTam[2] } )
aTam:= TamSX3("C8_NUMPRO")
AADD(aCampos,{"TB_NUMPRO" ,"C",aTam[1],aTam[2] } )
If AllTrim(mv_par06) == "B5_CEME"
	aTam:= TamSX3("B5_CEME")
	AADD(aCampos,{"TB_DESCPRO"   ,"C",aTam[1],aTam[2] } )	
Else
	aTam:= TamSX3("B1_DESC")
	AADD(aCampos,{"TB_DESCPRO"   ,"C",aTam[1],aTam[2] } )	
Endif

oTempTable := FWTemporaryTable():New( cAliasTRB )
oTempTable:SetFields( aCampos )
IF mv_par03 == 1
	oTempTable:AddIndex("indice1", {"TB_NUM","TB_PRODUTO","TB_FORNECE"} )
Else
	oTempTable:AddIndex("indice1", {"TB_NUM","TB_PRODUTO","TB_VLPRES"} )
EndIF

oTempTable:Create() 

cFilUser:=oSection1:GetAdvplExp()

dbSelectArea("SC8")
dbSetOrder(1)
dbSeek(xFilial("SC8") + mv_par01,.T.)
While !Eof() .And. SC8->C8_FILIAL = xFilial("SC8") .And. SC8->C8_NUM <= mv_par02
	
	If SC8->C8_TOTAL > 0 .And. !Empty(SC8->C8_COND) .And. (Empty(SC8->C8_NUMPED) .Or. mv_par05 == 1) 
		
		SB1->(dbSetOrder(1))
		SB1->(dbSeek(xFilial("SB1") + SC8->C8_PRODUTO))
		
		SA2->(dbsetOrder(1))
		SA2->(dbSeek(xFilial("SA2")+SC8->C8_FORNECE+SC8->C8_LOJA))
		
		cTes := IIF( mv_par04 == 1 .And. !SB1->(Eof()) , RetFldProd(SB1->B1_COD,"B1_TE") , SC8->C8_TES )
		If cPaisLoc == "BRA"
			cIcm := IIF( mv_par07 == 1 , SB1->B1_PICM , SC8->C8_PICM   )
			cIpi := IIF( mv_par08 == 1 , SB1->B1_IPI  , SC8->C8_ALIIPI )
		Endif	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calculo do custo da Cotacao                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MaFisIni(SC8->C8_FORNECE,SC8->C8_LOJA,"F","N","R",aRelImp)
		MaFisIniLoad(1)
		For nY := 1 To Len(aRelImp)
			MaFisLoad(aRelImp[nY][3],SC8->(FieldGet(FieldPos(aRelImp[nY][2]))),1)
		Next nY
		MaFisEndLoad(1)
		MaFisAlt("IT_TES"    ,cTes,1)
		If cPaisLoc == "BRA"
			MaFisAlt("IT_ALIQICM",cIcm,1)
			MaFisAlt("IT_ALIQIPI",cIpi,1)
		Endif	

		nValPres := Ma160Custo("SC8",1)
		
		If cPaisLoc == "BRA"			
			nValIPI   := xMoeda(MaFisRet(1,"IT_VALIPI"),SC8->C8_MOEDA,1,SC8->C8_EMISSAO,,SC8->C8_TXMOEDA)
			nValICMS  := xMoeda(MaFisRet(1,"IT_VALICM"),SC8->C8_MOEDA,1,SC8->C8_EMISSAO,,SC8->C8_TXMOEDA)			
		Endif		
		
		SF4->(dbSetOrder(1))
		SF4->(dbSeek(xFilial("SF4")+cTes))

		SE4->(dbSetOrder(1))
		SE4->(dbSeek(xFilial("SE4")+SC8->C8_COND))
		
		cDescPro := ""
		If AllTrim(mv_par06) == "C1_DESCRI"
			SC1->(dbSetOrder(5))
			If SC1->(dbSeek( xFilial("SC1")+SC8->C8_NUM+SC8->C8_PRODUTO ))
				cDescPro := Alltrim(SC1->C1_DESCRI)
			EndIf
		ElseIf AllTrim(mv_par06) == "B5_CEME"
			SB5->(dbSetOrder(1))
			If SB5->(dbSeek( xFilial("SB5")+SC8->C8_PRODUTO ))
				cDescPro := Alltrim(SB5->B5_CEME)
			EndIf
		Else
			mv_par06 := "B1_DESC"
			SB1->(dbSetOrder(1))
			SB1->(dbSeek( xFilial("SB1")+SC8->C8_PRODUTO ))
			cDescPro := Alltrim(SB1->B1_DESC)
		EndIf
	
		If Empty(cDescPro)
			SB1->(dbSetOrder(1))
			SB1->(dbSeek( xFilial("SB1")+SC8->C8_PRODUTO ))
			cDescPro := Alltrim(SB1->B1_DESC)
		EndIf
		          
		If !Empty(cFilUser) 
			DbSelectArea("SC8")
		    If !(&(cFilUser)) 
	     	   dbSkip()
	    	   Loop
    		EndIf   
		EndIf
	
		RecLock( cAliasTRB , .T. )

		(cAliasTRB)->TB_NUM     := SC8->C8_NUM
		(cAliasTRB)->TB_PRODUTO := SC8->C8_PRODUTO
		(cAliasTRB)->TB_DESCPRO := cDescPro
		(cAliasTRB)->TB_FORNECE := SC8->C8_FORNECE
		(cAliasTRB)->TB_FORNOME := SC8->C8_FORNOME
		(cAliasTRB)->TB_NOMEFOR := If(lLGPD,RetTxtLGPD(SC8->C8_FORNOME,"C8_FORNOME"), SC8->C8_FORNOME)
		(cAliasTRB)->TB_LOJA    := SC8->C8_LOJA
		(cAliasTRB)->TB_NOME    := SA2->A2_NOME
		(cAliasTRB)->TB_COND    := SC8->C8_COND    
		(cAliasTRB)->TB_DESCOND :=	Substr(SE4->E4_DESCRI,1,15)
		(cAliasTRB)->TB_PRAZO   := SC8->C8_PRAZO
		(cAliasTRB)->TB_VLPRES  := nValPres
		(cAliasTRB)->TB_JUROS   := If(Empty(SC8->C8_TAXAFIN),nJuros,SC8->C8_TAXAFIN)
		(cAliasTRB)->TB_DESVIO  := SA2->A2_DESVIO
		If cPaisLoc == "BRA"
			(cAliasTRB)->TB_CREDICM := If( SF4->F4_CREDICM == "N", 0 , nValICMS)
			(cAliasTRB)->TB_CREDIPI := If( SF4->F4_CREDIPI == "N", 0 , nValIPI )
		EndIf
		(cAliasTRB)->TB_DTENTR  := SC8->C8_EMISSAO + SC8->C8_PRAZO
		(cAliasTRB)->TB_DTNECES := SC8->C8_DATPRF
		(cAliasTRB)->TB_ITEM    := SC8->C8_ITEM
		(cAliasTRB)->TB_NUMPRO  := SC8->C8_NUMPRO
		
		MsUnlock()
		
		MaFisEnd()

	Endif
	
	dbSelectArea("SC8")
	dbSkip()

EndDo

(cAliasTRB)->(DbGotop())

TRPosition():New(oSection1,"SC8",1,{|| xFilial("SC8")+(cAliasTRB)->TB_NUM+(cAliasTRB)->TB_FORNECE+(cAliasTRB)->TB_LOJA+(cAliasTRB)->TB_ITEM+(cAliasTRB)->TB_NUMPRO })
TRPosition():New(oSection2,"SC8",1,{|| xFilial("SC8")+(cAliasTRB)->TB_NUM+(cAliasTRB)->TB_FORNECE+(cAliasTRB)->TB_LOJA+(cAliasTRB)->TB_ITEM+(cAliasTRB)->TB_NUMPRO })
TRPosition():New(oSection2,"SB1",1,{|| xFilial("SB1")+(cAliasTRB)->TB_PRODUTO })
TRPosition():New(oSection3,"SC8",1,{|| xFilial("SC8")+(cAliasTRB)->TB_NUM+(cAliasTRB)->TB_FORNECE+(cAliasTRB)->TB_LOJA+(cAliasTRB)->TB_ITEM+(cAliasTRB)->TB_NUMPRO })
TRPosition():New(oSection3,"SA2",1,{|| xFilial("SA2")+(cAliasTRB)->TB_FORNECE+(cAliasTRB)->TB_LOJA })
TRPosition():New(oSection3,"SB1",1,{|| xFilial("SB1")+(cAliasTRB)->TB_PRODUTO })

oSection2:SetParentFilter( { |cParam| (cAliasTRB)->TB_NUM == cParam },{ || (cAliasTRB)->TB_NUM })
oSection3:SetParentFilter( { |cParam| (cAliasTRB)->TB_NUM+(cAliasTRB)->TB_PRODUTO == cParam },{ || (cAliasTRB)->TB_NUM+(cAliasTRB)->TB_PRODUTO })

If cPaisLoc<>"BRA"
	oSection3:Cell("TB_CREDICM"):Disable()
	oSection3:Cell("TB_CREDIPI"):Disable()
EndIf

oSection1:Print()

oTempTable:Delete()

Return Nil
