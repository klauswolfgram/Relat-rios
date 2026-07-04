/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Matr945.ch"
#INCLUDE "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Matr945   ³ Autor ³ Andressa Fagundes     ³ Data ³18/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao para Contribuicao Seguridade Social                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Vogas Junior  ³04/05/18³DSERFIS2-3535 Alinhamento do cabecalho e altera³±±
±±³				 ³        ³cao na forma de selecao da aliquota da operacao³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Matr945()

Local oReport
Local lVerpesssen 	:= Iif(FindFunction("Verpesssen"),Verpesssen(),.T.)

Private aFilsCalc := {}
Private lAutomato := IsBlind()

If lVerpesssen
	If TRepInUse()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport	:= ReportDef()
		oReport:PrintDialog()
	Else
		U_Matr945R3()
	EndIf
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Andressa Fagundes      ³ Data ³17/05/2006³±±
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
Local oBreak1
Local oNfEntr
Local oNfSaid

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Componente de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Este programa tem como objetivo,emitir uma relaçäo dos valores referentes a Contribuiçäo Seguridade Social
oReport := TReport():New("MATR945",STR0020,"MTR945", {|oReport| ReportPrint(oReport)},STR0002+" "+STR0003)
oReport:SetLandScape(.T.)
Pergunte("MTR945",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 1 - Movimentos de Entrada                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oNfEntr:= TRSection():New(oReport,STR0041,{"SF1","SA2","SA1"},{STR0051},/*Campos do SX3*/,/*Campos do SIX*/)
oNfEntr:SetPageBreak()
oNfEntr:SetNoFilter({"SA2","SA1"})
TRCell():New(oNfEntr,"FT_FILIAL"	,"SFT"	,STR0052 ,/*Picture*/,Len(FWGETCODFILIAL)+3,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"FT_EMISSAO"	,"SFT"	,STR0021 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"FT_ENTRADA"	,"SFT"	,STR0022 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"FT_NFISCAL"	,"SFT"	,STR0023 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,SerieNfId("SFT",3,"FT_SERIE") ,"SFT"	,STR0024 ,/*Picture*/,SerieNfId("SFT",6,"FT_SERIE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"FT_CLIEFOR"	,"SFT"	,STR0025 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"FT_LOJA"		,"SFT"	,STR0026 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"A2_NOME"		,"SA2"	,STR0027 ,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"A2_TPRUR"		,"SA2"	,STR0028 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"A2_CGC"		,"SA2"	,STR0029 ,/*"@R 99.999.999/9999-99"*/,/*20*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"FT_VALCONT"	,"SFT"	,STR0030 ,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"D1_VALFUN"	,"SD1"	,STR0031 ,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"FT_VALINS"	,"SDT"	,STR0056 ,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"FT_VLSENAR"	,"SDT"	,STR0057 ,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfEntr,"FT_TIPO"		,"SFT"	,STR0048 ,"@!",1,/*lPixel*/,/*{|| code-block de impressao }*/)
//Quebra por Data de Emissao
oBreak1 := TRBreak():New(oNfEntr,{ || FT_FILIAL + DtoS(FT_EMISSAO) },STR0053,.F.)
//oBreak1 := TRBreak():New(oNfEntr,oNfEntr:Cell("FT_EMISSAO"),STR0032,.F.)

//Totalizadores
TRFunction():New(oNfEntr:Cell("FT_VALCONT")	,Nil,"SUM",oBreak1,STR0039,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
TRFunction():New(oNfEntr:Cell("D1_VALFUN")	,Nil,"SUM",oBreak1,STR0040,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
TRFunction():New(oNfEntr:Cell("FT_VALINS")	,Nil,"SUM",oBreak1,STR0058,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
TRFunction():New(oNfEntr:Cell("FT_VLSENAR")	,Nil,"SUM",oBreak1,STR0059,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
oReport:Section(1):SetTotalText(STR0033)
                   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 2 - Movimentos de Saida                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oNfSaid:= TRSection():New(oReport,STR0042,{"SF2","SA1","SA2"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oNfSaid:SetPageBreak()            
oNfSaid:SetNoFilter({"SA2","SA1"})
TRCell():New(oNfSaid,"FT_FILIAL"	,"SFT"	,STR0052 ,/*Picture*/,Len(FWGETCODFILIAL)+3,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"FT_EMISSAO"	,"SFT"	,STR0021 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"FT_EMISSAO"	,"SFT"	,STR0022 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"FT_NFISCAL"	,"SFT"	,STR0023 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,SerieNfId("SFT",3,"FT_SERIE") ,"SFT"	,STR0024 ,/*Picture*/,SerieNfId("SFT",6,"FT_SERIE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"FT_CLIEFOR"	,"SFT"	,STR0034 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"FT_LOJA"		,"SFT"	,STR0026 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"A1_NOME"		,"SA1"	,STR0035 ,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"A1_TIPO"		,"SA1"	,STR0036 ,/*Picture*/,10,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"A1_CGC"		,"SA1"	,STR0029 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"D2_ALIQFUN"	,"SD2"	,STR0028 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"FT_VALCONT"	,"SFT"	,STR0030 ,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"D2_VALFUN"	,"SD2"	,STR0031 ,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"FT_VALINS"	,"SFT"	,STR0056 ,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"FT_VLSENAR"	,"SFT"	,STR0057 ,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"FT_TIPO"		,"SFT"	,STR0048 ,"@!",1,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)
               
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Andressa Fagundes     ³ Data ³18/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aAliqFunR)

Local cAliasSF2	:= "SFT"
Local cAliasSFT	:= "SFT" 
Local cCnpj		:= ""
Local cNome		:= ""
Local cTpRur	:= ""
Local lFirst 	:= .F.
Local oNfEntr	:= oReport:Section(1)
Local oNfSaid	:= oReport:Section(2)
Local oTotaliz
Local oBreak2
Local oBreak3
Local cSelectFT:=""
Local cSelectF2:=""
Local nForFilial
Local cFilBack 	:= cFilAnt
Local aFilAtiv	:= {}
Local nPosFil	:= 0 
Local cFilSF1	:= ''
Local cFilSF2	:= ''
Local cFilSD1   := ''
Local cFilSA2   := ''
Local cFilSD2   := ''
Local cFilPerSF1   := '' //Filtro personalizado Documento de Entrada
Local cFilPerSF2   := '' //Filtro personalizado Documento de Saída
Local lMTR94501 := ExistBlock("MTR94501")

#IFNDEF TOP
	Local cCondicao :=	""
#ENDIF

Default aAliqFunR := {}

Private aPFunRur 	:= FunRur()
Private cTpCliFor	:= ""

//ÃšÃ„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Â¿
//Â³ Tratamento para GestÃ£o Corporativa                           Â³
//Ã€Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã™
aFilsCalc := MatFilCalc( MV_PAR06 == 1 , , , , , 1 )
If Empty( aFilsCalc )
	Return
Endif

// Guarda as filiais dos arquivos para uso posterior
If MV_PAR06 == 1
	For nForFilial := 1 to Len( aFilsCalc )
		If aFilsCalc[ nForFilial, 1 ]
			cFilAnt := aFilsCalc[ nForFilial, 2 ]
			aAdd( aFilAtiv, { cFilAnt, xFilial('SF1'), xFilial('SF2'), xFilial('SA1'), xFilial('SA2') } )
		EndIf
	Next
Else
	aAdd( aFilAtiv, { cFilAnt, xFilial('SF1'), xFilial('SF2'), xFilial('SA1'), xFilial('SA2') } )
EndIf

cFilAnt	:= aFilAtiv[1,1]
		
oNfEntr	:= oReport:Section(1)
oNfSaid	:= oReport:Section(2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona Movimentacao de Entrada                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par03 == 1 .Or. mv_par03 == 3 // Notas Fiscais de Entrada

	cFilSF1	:= ''
	For nPosFil := 1 to Len(aFilAtiv)
		cFilSF1	+= IIf(nPosFil==1,"('","'")+aFilAtiv[nPosFil,2]+IIf(nPosFil==Len(aFilAtiv),"')","',")
		cFilSA2	+= IIf(nPosFil==1,"('","'")+aFilAtiv[nPosFil,4]+IIf(nPosFil==Len(aFilAtiv),"')","',")
	Next

	dbSelectArea("SFT")
	dbSetOrder(1)
	
	#IFDEF TOP
			
		cSelectFT:="%"
		cSelectFT+="DISTINCT SFT.FT_FILIAL, SFT.FT_TIPO, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SD1.D1_ALIQFUN, "
		cSelectFT+="SFT.FT_ENTRADA,SFT.FT_CLIEFOR, SFT.FT_LOJA, SUM(SFT.FT_VALCONT) FT_VALCONT,SUM(SD1.D1_TOTAL) D1_TOTAL,SUM(SD1.D1_VALFUN) D1_VALFUN, SUM(SFT.FT_VALINS) FT_VALINS ,SUM(SFT.FT_VLSENAR) FT_VLSENAR, SFT.FT_ITEM "
		cSelectFT+="%"
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Transforma parametros Range em expressao SQL   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MakeSqlExpr(oReport:uParam)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Query do relatório da secao 1                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:Section(1):BeginQuery()	
	
		cFilSD1 := "% SD1.D1_FILIAL = SFT.FT_FILIAL %"
		cFilSF1	:= "% SFT.FT_FILIAL IN "+cFilSF1+" %"
		cFilSA2	:= "% SA2.A2_FILIAL IN "+cFilSA2+" %"
				
		cAliasSFT := GetNextAlias()                 
		If !Empty(mv_par04) .And. !Empty(mv_par05)  // Tambem filtra pela data de entrada 
						
			BeginSql Alias cAliasSFT 
			
			SELECT %Exp:cSelectFT%
			
			FROM %table:SFT% SFT
			INNER JOIN %table:SD1% SD1 ON ( %Exp:cFilSD1%  
											AND SD1.D1_DOC     = SFT.FT_NFISCAL 
											AND SD1.D1_SERIE   = SFT.FT_SERIE 
											AND SD1.D1_FORNECE = SFT.FT_CLIEFOR 
											AND SD1.D1_LOJA    = SFT.FT_LOJA 
											AND SD1.D1_COD     = SFT.FT_PRODUTO 
											AND SD1.D1_ITEM    = SFT.FT_ITEM 
											AND (SD1.D1_VALFUN > 0 OR SD1.D1_VALINS > 0 OR SD1.D1_VLSENAR > 0 OR SD1.D1_ALIQFUN > 0)
											AND SD1.%NotDel%)
			INNER JOIN %table:SA2% SA2 ON ( %Exp:cFilSA2%  
											AND SD1.D1_FORNECE = SA2.A2_COD 
											AND SD1.D1_LOJA    = SA2.A2_LOJA 
											AND SA2.A2_TIPORUR <> '' 
											AND SA2.%NotDel% )

			WHERE %Exp:cFilSF1%
			  AND SFT.FT_EMISSAO >= %Exp:Dtos(mv_par01)%
			  AND SFT.FT_EMISSAO <= %Exp:Dtos(mv_par02)%
			  AND SFT.FT_TIPOMOV = 'E'
			  AND SFT.FT_TIPO    <> "S"
			  AND SFT.FT_ENTRADA >= %Exp:Dtos(mv_par04)%
			  AND SFT.FT_ENTRADA <= %Exp:Dtos(mv_par05)%
			  AND SFT.%NotDel%

			  GROUP BY SFT.FT_FILIAL, SFT.FT_TIPO, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SD1.D1_ALIQFUN ,SFT.FT_ENTRADA,SFT.FT_CLIEFOR, SFT.FT_LOJA, SFT.FT_ITEM
			  ORDER BY  SFT.FT_FILIAL,SFT.FT_NFISCAL,SFT.FT_SERIE ,SFT.FT_CLIEFOR,SFT.FT_LOJA 			  
			  
			EndSql

			
		Else	// Nao filtra pela data de entrada 
			
			BeginSql Alias cAliasSFT
			
			SELECT %Exp:cSelectFT%
			
			FROM %table:SFT% SFT
			INNER JOIN %table:SD1% SD1 ON ( %Exp:cFilSD1%  
											AND SD1.D1_DOC     = SFT.FT_NFISCAL 
											AND SD1.D1_SERIE   = SFT.FT_SERIE 
											AND SD1.D1_FORNECE = SFT.FT_CLIEFOR 
											AND SD1.D1_LOJA    = SFT.FT_LOJA 
											AND SD1.D1_COD     = SFT.FT_PRODUTO 
											AND SD1.D1_ITEM    = SFT.FT_ITEM 
											AND (SD1.D1_VALFUN > 0 OR SD1.D1_VALINS > 0 OR SD1.D1_VLSENAR > 0 OR SD1.D1_ALIQFUN > 0)
											AND SD1.%NotDel%)
			INNER JOIN %table:SA2% SA2 ON ( %Exp:cFilSA2% 
										    AND SD1.D1_FORNECE = SA2.A2_COD 
											AND SD1.D1_LOJA    = SA2.A2_LOJA 
											AND SA2.A2_TIPORUR <> '' 
											AND SA2.%NotDel%   )

			WHERE %Exp:cFilSF1%
			  AND SFT.FT_EMISSAO >= %Exp:Dtos(mv_par01)%
			  AND SFT.FT_EMISSAO <= %Exp:Dtos(mv_par02)%
			  AND SFT.FT_TIPOMOV = 'E' 
			  AND SFT.FT_TIPO <> 'S'
			  AND SFT.%NotDel%

			  GROUP BY SFT.FT_FILIAL, SFT.FT_TIPO, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SD1.D1_ALIQFUN ,SFT.FT_ENTRADA,SFT.FT_CLIEFOR, SFT.FT_LOJA, SFT.FT_ITEM
			  ORDER BY  SFT.FT_FILIAL,SFT.FT_NFISCAL,SFT.FT_SERIE ,SFT.FT_CLIEFOR,SFT.FT_LOJA 
			  
			EndSql    
			
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Metodo EndQuery ( Classe TRSection )                                    ³
		//³                                                                        ³
		//³Prepara o relatório para executar o Embedded SQL.                       ³
		//³                                                                        ³
		//³ExpA1 : Array com os parametros do tipo Range                           ³
		//³                                                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
		
	#ELSE
		MakeAdvplExpr(oReport:uParam)                                              
		
		cCondicao := "FT_FILIAL == '"+cFilSF1+"' .AND. "
		cCondicao += "Dtos(F1_EMISSAO)>= '"+Dtos(mv_par01)+"' .AND. Dtos(FT_EMISSAO)<= '"+Dtos(mv_par02)+"' .And. "
		cCondicao += "(SD1.D1_VALFUN > 0 OR SD1.D1_VALINS > 0 OR SD1.D1_VLSENAR > 0 OR D1_ALIQFUN > 0) AND "

		If !Empty(mv_par04) .And. !Empty(mv_par05)
			cCondicao 	+= " .And. DTOS(FT_ENTRADA) >='"+DTOS(mv_par04)+"'"
			cCondicao 	+= " .And. DTOS(FT_ENTRADA) <='"+DTOS(mv_par05)+"'"
		EndIf	                                                        

		oReport:Section(1):SetFilter(cCondicao,IndexKey())

	#ENDIF
	
Endif	

If mv_par03 == 2 .Or. mv_par03 == 3 // Notas Fiscais de Saida

	For nPosFil := 1 to Len(aFilAtiv)
		cFilSF2	+= IIf(nPosFil==1,"('","'")+aFilAtiv[nPosFil,3]+IIf(nPosFil==Len(aFilAtiv),"')","',")
		cFilSD2 := IIf(nPosFil==1,"('"," ")+aFilAtiv[nPosFil,3]+IIf(nPosFil==Len(aFilAtiv),"')","',")
	Next

	dbSelectArea("SFT")
	dbSetOrder(1)
	
	#IFDEF TOP
		cSelectF2:="%"
		cSelectF2+="FT_FILIAL, FT_EMISSAO, FT_NFISCAL, FT_SERIE, D2_ALIQFUN, " 
		cSelectF2+="FT_CLIEFOR,FT_LOJA, SUM(FT_VALCONT) FT_VALCONT, SUM(FT_TOTAL) FT_TOTAL, SUM(D2_VALFUN) D2_VALFUN, FT_TIPO, FT_FORMUL, SUM(FT_VLSENAR) FT_VLSENAR, SUM(FT_VALINS) FT_VALINS, SFT.FT_ITEM "		
		cSelectF2+="%"
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Transforma parametros Range em expressao SQL   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MakeSqlExpr(oReport:uParam)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Query do relatório da secao 1                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:Section(2):BeginQuery()	
		
		cFilSD2 := "% SD2.D2_FILIAL = SFT.FT_FILIAL %"
		cFilSF2	:= "% FT_FILIAL IN "+cFilSF2+" %"
		cAliasSF2 := GetNextAlias()
		BeginSql Alias cAliasSF2
		
		SELECT %EXP:cSelectF2%
		
		FROM %table:SFT% SFT
		INNER JOIN %table:SD2% SD2 ON ( %Exp:cFilSD2%  AND SD2.D2_DOC    = SFT.FT_NFISCAL AND SD2.D2_SERIE = SFT.FT_SERIE AND SD2.D2_CLIENTE = SFT.FT_CLIEFOR AND SD2.D2_LOJA = SFT.FT_LOJA AND SD2.D2_COD = SFT.FT_PRODUTO AND SD2.D2_ITEM = SFT.FT_ITEM AND  SD2.%NotDel%)
		
		WHERE %Exp:cFilSF2%
		  AND FT_EMISSAO >= %Exp:Dtos(mv_par01)%
		  AND FT_EMISSAO <= %Exp:Dtos(mv_par02)%
		  AND ( SD2.D2_VALFUN > 0 OR SFT.FT_VALINS > 0 OR SFT.FT_VLSENAR > 0 )
		  AND SFT.FT_TIPOMOV = 'S'
		  AND SFT.FT_TIPO <> "S"
		  AND SFT.%NotDel%

		GROUP BY FT_FILIAL, FT_TIPO, FT_EMISSAO, FT_NFISCAL, FT_SERIE, D2_ALIQFUN , FT_CLIEFOR, FT_LOJA, FT_TIPO, FT_FORMUL, SFT.FT_ITEM 
		ORDER BY  FT_FILIAL,FT_NFISCAL,FT_SERIE ,FT_CLIEFOR,FT_LOJA
		
		  
		EndSql

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Metodo EndQuery ( Classe TRSection )                                    ³
		//³                                                                        ³
		//³Prepara o relatório para executar o Embedded SQL.                       ³
		//³                                                                        ³
		//³ExpA1 : Array com os parametros do tipo Range                           ³
		//³                                                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)
		oNfSaid:SetParentQuery()
		
	#ELSE
		MakeAdvplExpr(oReport:uParam) 

		cChave	  := "DTOS(FT_EMISSAO)+FT_FILIAL+FT_NFISCAL+FT_SERIE+FT_CLIEFOR,FT_LOJA"
		cCondicao := "FT_FILIAL == '"+xFilial("SFT")+"' .AND. "
		cCondicao += "Dtos(FT_EMISSAO)>= '"+Dtos(mv_par01)+"' .AND. Dtos(FT_EMISSAO)<= '"+Dtos(mv_par02)+"' .And. "
		cCondicao += "( SD2.D2_VALFUN > 0 .OR. SFT.FT_VALINS > 0 .OR.  SFT.FT_VLSENAR > 0 ) "

		oReport:Section(2):SetFilter(cCondicao,IndexKey())

	#ENDIF

Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Campos a serem impressos - cliente/fornecedor³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oNfEntr:Cell("A2_NOME"):SetBlock({|| cNome }) 
oNfEntr:Cell("A2_TPRUR"):SetBlock({|| cTpRur })
oNfEntr:Cell("A2_CGC"):SetBlock({|| cCnpj })
oNfSaid:Cell("A1_NOME"):SetBlock({|| cNome })
oNfSaid:Cell("A1_TIPO"):SetBlock({|| cTpRur })
oNfSaid:Cell("A1_CGC"):SetBlock({|| cCnpj })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Totalizadores³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Quebra por Data de Emissao
oBreak2 := TRBreak():New(oNfSaid,oNfSaid:Cell("FT_EMISSAO"),STR0037,.F.) //"TOTAL DO DIA CONSUMIDOR"
oBreak3 := TRBreak():New(oNfSaid,oNfSaid:Cell("FT_EMISSAO"),STR0038,.F.) //"TOTAL DO DIA NAO CONSUMIDOR"

//Totalizadores
oTotaliz:=TRFunction():New(oNfSaid:Cell("FT_VALCONT"),Nil,"SUM",oBreak2,STR0044,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
oTotaliz:SetCondition({ || cTpCliFor == "F" })
oTotaliz:=TRFunction():New(oNfSaid:Cell("FT_VALCONT"),Nil,"SUM",oBreak3,STR0045,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
oTotaliz:SetCondition({ || cTpCliFor <> "F" })
oTotaliz:=TRFunction():New(oNfSaid:Cell("D2_VALFUN"),Nil,"SUM",oBreak2,STR0046,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
oTotaliz:SetCondition({ || cTpCliFor == "F" })
oTotaliz:=TRFunction():New(oNfSaid:Cell("D2_VALFUN"),Nil,"SUM",oBreak3,STR0047,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
oTotaliz:SetCondition({ || cTpCliFor <> "F" })
oTotaliz:=TRFunction():New(oNfSaid:Cell("FT_VALINS"),Nil,"SUM",oBreak2,STR0060,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
oTotaliz:SetCondition({ || cTpCliFor == "F" })
oTotaliz:=TRFunction():New(oNfSaid:Cell("FT_VALINS"),Nil,"SUM",oBreak3,STR0061,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
oTotaliz:SetCondition({ || cTpCliFor <> "F" })
oTotaliz:=TRFunction():New(oNfSaid:Cell("FT_VLSENAR"),Nil,"SUM",oBreak2,STR0062,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
oTotaliz:SetCondition({ || cTpCliFor == "F" })
oTotaliz:=TRFunction():New(oNfSaid:Cell("FT_VLSENAR"),Nil,"SUM",oBreak3,STR0063,"@E 999,999,999.99",/*uFormula*/,.T.,.F.)
oTotaliz:SetCondition({ || cTpCliFor <> "F" })

oNfSaid:SetTotalText(STR0043)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nfs Entrada         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par03 == 1 .Or. mv_par03 == 3

	oReport:SetMeter((cAliasSFT)->(LastRec()))
	dbSelectArea(cAliasSFT)
	oReport:Section(1):Init()
	oReport:PrintText(STR0041)
	oReport:SkipLine()

	cFilPerSF1 := oNfEntr:GetAdvplExp("SF1")

	While !oReport:Cancel() .And. !(cAliasSFT)->(Eof());
		 .And. (cAliasSFT)->FT_EMISSAO >= mv_par01;
		 .And. (cAliasSFT)->FT_EMISSAO <= mv_par02
		
		If !(Empty(cFilPerSF1)) .And. !(fFilPerso((cAliasSFT)->FT_NFISCAL + (cAliasSFT)->FT_SERIE + (cAliasSFT)->FT_CLIEFOR + (cAliasSFT)->FT_LOJA, "E"))//Testo o filtro personalizado
			(cAliasSFT)->(dbSkip())
		Else
			nPosFil := aScan( aFilAtiv, { |x| x[2]== (cAliasSFT)->FT_FILIAL } )
			If !(cAliasSFT)->FT_TIPO $ "D/B"
				SA2->(dbSetOrder(1))
				SA2->(dbSeek(xFilial("SA2")+(cAliasSFT)->FT_CLIEFOR+(cAliasSFT)->FT_LOJA))
				cCnpj	:= SA2->A2_CGC
				cNome	:= SA2->A2_NOME 
				aPFunRur[1] := ALLTRIM(STR((cAliasSFT)->D1_ALIQFUN))
				aPFunRur[2] := (cAliasSFT)->D1_ALIQFUN
				//Criado novo Ponto de Entrada: MTR94501 
				If (lMTR94501)
					aAliqFunR := Execblock("MTR94501",.F.,.F.,{(cAliasSFT)->FT_CLIEFOR,(cAliasSFT)->FT_LOJA, SA2->A2_TIPORUR, SM0->M0_PRODRUR})
					aPFunRur[2] := aAliqFunR[1]
				EndIf
				cTpRur	:= Iif(at(SA2->A2_TIPORUR,"FLJ") > 0 ,aPFunRur[at(SA2->A2_TIPORUR,"FLJ")],"")
				cTpCliFor := SA2->A2_TIPORUR
			Else                                                                                                                
				SA1->(dbSetOrder(1))
				SA1->(dbSeek(xFilial("SA1")+(cAliasSFT)->FT_CLIEFOR+(cAliasSFT)->FT_LOJA))
				cCnpj 	:= SA1->A1_CGC
				cNome 	:= SA1->A1_NOME
				aPFunRur[1] := ALLTRIM(STR((cAliasSFT)->D1_ALIQFUN))
				aPFunRur[2] := (cAliasSFT)->D1_ALIQFUN
				//Criado novo Ponto de Entrada: MTR94501
				If (lMTR94501)
					aAliqFunR := Execblock("MTR94501",.F.,.F.,{(cAliasSFT)->FT_CLIEFOR,(cAliasSFT)->FT_LOJA, SA2->A2_TIPORUR, SM0->M0_PRODRUR})
					aPFunRur[2] := aAliqFunR[1]
				EndIf
				cTpRur	:= Iif(at(SA1->A1_TIPO,"FLJ") > 0 ,aPFunRur[at(SA1->A1_TIPO,"FLJ")],"")
				cTpCliFor := SA1->A1_TIPO
			Endif	

			If oReport:Cancel() 
				Exit
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Mascara para impressao - CNPJ/CPF³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If RetPessoa(cCnpj) == "J"
				oNfEntr:Cell("A2_CGC"):SetPicture("@R! NN.NNN.NNN/NNNN-99")
			Else
				oNfEntr:Cell("A2_CGC"):SetPicture("@R 999.999.999-99")
			Endif                            
			
			oNfEntr:Init()
			oReport:IncMeter()
			lFirst := .T.
			
			If lFirst
				oNfEntr:Cell("FT_FILIAL"):Show()
				oNfEntr:Cell("FT_EMISSAO"):Show()
				oNfEntr:Cell("FT_ENTRADA"):Show()
				oNfEntr:Cell("FT_NFISCAL"):Show()
				oNfEntr:Cell("FT_SERIE"):Show()
				oNfEntr:Cell("FT_CLIEFOR"):Show()
				oNfEntr:Cell("FT_LOJA"):Show()
				oNfEntr:Cell("A2_NOME"):Show()
				oNfEntr:Cell("A2_TPRUR"):Show()
				oNfEntr:Cell("A2_CGC"):Show()
				oNfEntr:Cell("FT_VALCONT"):Show()
				oNfEntr:Cell("D1_VALFUN"):Show()
				oNfEntr:Cell("FT_VALINS"):Show()
				oNfEntr:Cell("FT_VLSENAR"):Show()
				If FT_TIPO == "D"
					oNfEntr:Cell("FT_TIPO"):Show()
				Else
					oNfEntr:Cell("FT_TIPO"):Hide()
				Endif
				lFirst := .F.
			Else
				oNfEntr:Cell("FT_FILIAL"):HIDE()
				oNfEntr:Cell("FT_EMISSAO"):Hide()
				oNfEntr:Cell("FT_ENTRADA"):Hide()
				oNfEntr:Cell("FT_NFISCAL"):Hide()
				oNfEntr:Cell("FT_SERIE"):Hide()
				oNfEntr:Cell("FT_CLIEFOR"):Hide()
				oNfEntr:Cell("FT_LOJA"):Hide()
				oNfEntr:Cell("A2_NOME"):Hide()
				oNfEntr:Cell("A2_TPRUR"):Hide()
				oNfEntr:Cell("A2_CGC"):Hide()
				oNfEntr:Cell("FT_VALCONT"):Hide()
				oNfEntr:Cell("D1_VALFUN"):Hide()
				oNfEntr:Cell("FT_VALINS"):Hide()
				oNfEntr:Cell("FT_VLSENAR"):Hide()
				oNfEntr:Cell("F1_TIPO"):Hide()
			Endif
			oNfEntr:PrintLine()
			dbSkip()
		EndIf		
	Enddo
		oReport:Section(1):Finish()
		oNfEntr:Finish()
		oReport:SkipLine()
		oReport:ThinLine() 
		oReport:IncMeter()

	(cAliasSFT)->(DbCloseArea())
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nfs Saida           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ          
If mv_par03 == 2 .Or. mv_par03 == 3

	oReport:SetMeter((cAliasSF2)->(LastRec()))
	dbSelectArea(cAliasSF2) 
	(cAliasSF2)->(DbGotop())  
	oReport:Section(2):Init()                   
	oReport:PrintText(STR0042)
	oReport:SkipLine()

	cFilPerSF2 := oNfSaid:GetAdvplExp("SF2")

	While !oReport:Cancel() .And. !(cAliasSF2)->(Eof());
		.And. (cAliasSF2)->FT_EMISSAO >= mv_par01;
		.And. (cAliasSF2)->FT_EMISSAO <= mv_par02

		If oReport:Cancel()
			Exit
		EndIf

		If !(Empty(cFilPerSF2)) .And. !(fFilPerso((cAliasSF2)->FT_NFISCAL + (cAliasSF2)->FT_SERIE + (cAliasSF2)->FT_CLIEFOR + (cAliasSF2)->FT_LOJA, "S"))//Testo o filtro personalizado
			(cAliasSF2)->(dbSkip())
		Else
			nPosFil := aScan( aFilAtiv, { |x| x[3]== (cAliasSF2)->FT_FILIAL } )
			If (cAliasSF2)->FT_TIPO $ "D/B"
				SA2->(dbSetOrder(1))
				SA2->(dbSeek(xFilial("SA2")+(cAliasSF2)->FT_CLIEFOR+(cAliasSF2)->FT_LOJA))
				cCnpj 	:= SA2->A2_CGC
				cNome	:= SA2->A2_NOME
				cTpRur	:= Iif(SA2->A2_TIPO != "F",STR0013,STR0014)
				cTpCliFor := SA2->A2_TIPORUR
			Else                                                                                                       
				SA1->(dbSetOrder(1))
				SA1->(dbSeek(xFilial("SA1")+(cAliasSF2)->FT_CLIEFOR+(cAliasSF2)->FT_LOJA))
				cCnpj 	:= SA1->A1_CGC
				cNome	:= SA1->A1_NOME
				cTpRur	:= Iif(SA1->A1_TIPO != "F",STR0013,STR0014)
				cTpCliFor := SA1->A1_TIPO
			Endif	

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Mascara para impressao - CNPJ/CPF³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If RetPessoa(cCnpj) == "J"
				oNfSaid:Cell("A1_CGC"):SetPicture("@R! NN.NNN.NNN/NNNN-99")
			Else
				oNfSaid:Cell("A1_CGC"):SetPicture("@R 999.999.999-99")
			Endif                            

			oNfSaid:Init()
			oReport:IncMeter()
			lFirst := .T.

			If lFirst
				oNfSaid:Cell("FT_FILIAL"):Show()
				oNfSaid:Cell("FT_EMISSAO"):Show()
				oNfSaid:Cell("FT_EMISSAO"):Show()
				oNfSaid:Cell("FT_NFISCAL"):Show()
				oNfSaid:Cell("FT_SERIE"):Show()
				oNfSaid:Cell("FT_CLIEFOR"):Show()
				oNfSaid:Cell("FT_LOJA"):Show()
				oNfSaid:Cell("A1_NOME"):Show()
				oNfSaid:Cell("A1_TIPO"):Show()
				oNfSaid:Cell("A1_CGC"):Show()
				oNfSaid:Cell("D2_ALIQFUN"):Show()
				oNfSaid:Cell("FT_VALCONT"):Show()
				oNfSaid:Cell("D2_VALFUN"):Show()
				oNfSaid:Cell("FT_VALINS"):Show()
				oNfSaid:Cell("FT_VLSENAR"):Show()
				If FT_TIPO == "D"
					oNfSaid:Cell("FT_TIPO"):Show()
				Else
					oNfSaid:Cell("FT_TIPO"):Hide()
				Endif
				lFirst := .F.
			Else
				oNfSaid:Cell("FT_FILIAL"):Hide()
				oNfSaid:Cell("FT_EMISSAO"):Hide()
				oNfSaid:Cell("FT_EMISSAO"):Hide()
				oNfSaid:Cell("FT_NFISCAL"):Hide()
				oNfSaid:Cell("FT_SERIE"):Hide()
				oNfSaid:Cell("FT_CLIEFOR"):Hide()
				oNfSaid:Cell("FT_LOJA"):Hide()
				oNfSaid:Cell("A1_NOME"):Hide()
				oNfSaid:Cell("D2_ALIQFUN"):Hide()
				oNfSaid:Cell("A1_TIPO"):Hide()
				oNfSaid:Cell("A1_CGC"):Hide()
				oNfSaid:Cell("D2_ALIQFUN"):Hide()
				oNfSaid:Cell("FT_VALCONT"):Hide()
				oNfSaid:Cell("D2_VALFUN"):Hide()
				oNfSaid:Cell("FT_VALINS"):Hide()
				oNfSaid:Cell("FT_VLSENAR"):Hide()
				oNfSaid:Cell("FT_TIPO"):Hide()
			Endif
			oNfSaid:PrintLine()
			(cAliasSF2)->(dbSkip())
		EndIf	
	Enddo

	oReport:Section(1):Finish()
	oNfSaid:Finish()           
	oReport:SkipLine()
	oReport:ThinLine() 
	oReport:IncMeter()               
	(cAliasSF2)->(DbCloseArea())

Endif    

// Restaura a filial corrente
cFilAnt := cFilBack

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Matr945R3 ³ Autor ³ Juan Jose Pereira     ³ Data ³ 13.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao para Contribuicao Seguridade Social                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Marcos Simidu³11/02/98³XXXXXX³ Variavel nao existe - NomeProg.        ³±±
±±³ Marcos Simidu³04/11/98³XXXXXX³ Ano com 4 bytes.                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Matr945R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel
Local aFilsCalc := {}

Private titulo	:= STR0001,; //"Contribui‡„o Seguridade Social - ENTRADAS"
		cDesc1  := STR0002,; //"Este programa tem como objetivo,emitir uma rela‡„o dos"
		cDesc2  := STR0003,; //"valores referentes a Contribui‡„o Seguridade Social"
		cDesc3  := "",;
		cString := "SF2",;
		nomeprog:= "MATR945",;
		cTitulo := STR0020

Private	aReturn	:= { STR0004, 1,STR0005, 2, 2, 1, "",1 },; //"Zebrado"###"Administra‡„o"
		aLinha	:= { }  , nLastKey := 0,;
		cPerg	:= "MTR945",;
		Tamanho	:= "G"
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR945",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01              Data de                                ³
//³ mv_par02              Data Ate                               ³
//³ mv_par03              Movimentos                             ³
//³ mv_par04              Data de digitacao de                   ³
//³ mv_par05              Data de digitacao ate                  ³
//³ mv_par06              Seleciona Filiais?                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "MATR945"
wnrel := SetPrint(cString,wnrel,cPerg,@ctitulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho,,.F.)
If nLastKey == 27
	dbClearFilter()
	Return
Endif

aFilsCalc := MatFilCalc( mv_par06 == 1 .AND. !lAutomato )
If Empty( aFilsCalc )
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	dbClearFilter()
	Return
Endif

RptStatus( { |lEnd| R945Imp( @lEnd, wnRel, cString, Tamanho, aFilsCalc ) }, cTitulo )

dbClearFilter()

If aReturn[5]==1
	dbCommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R945Imp  ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do Relatorio.                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R945Imp(lEnd,WnRel,cString,Tamanho,aFilsCalc,aAliqFunR)

Local nTotDiaNf	:= 0,;
	  nTotDiafu := 0,;
  	  nTotDiaNfC:= 0,;
	  nTotDiaFuC:= 0,;
	  nTotDiaNfn:= 0,;
	  nTotDiaFun:= 0,;
	  nTotEntNf := 0,;
	  nTotEntFu := 0,;
	  nTotSaiNfN:= 0,;
	  nTotSaiFuN:= 0,;
	  nTotSaiNfC:= 0,;
	  nTotSaiFuC:= 0,;
	  lPassa	:= .T.,;
	  dEmissao	:= Ctod("  /  /  "),;
	  ccFilial   := ""
	  
Local aPFunRur  := {}
Local nPosPer   := 0
Local cAliasSF2	:= "SFT"
Local cAliasSFT	:= "SFT"
Local cTipoRur  := "" 
Local lFlag     := .F.
Local nTotDiaIn := 0
Local nTotDiaSe := 0
Local nTotEntIn := 0
Local nTotEntSe := 0
Local nTotDiaInN := 0
Local nTotDiaSeN := 0
Local nTotSaiInN := 0
Local nTotSaiSeN := 0
Local nTotDiaInC := 0
Local nTotDiaSeC := 0	
Local nTotSaiInC := 0
Local nTotSaiSeC := 0

Local lMTR94501 := ExistBlock("MTR94501")

#IFDEF TOP
	Local cQuery	:=	""
	Local aStruSF2	:=	{}
	Local aStruSFT	:=	{}
	Local nX		:=	0
#ELSE
	Local cIndex    :=	""
	Local cCondicao :=	""
#ENDIF

Local nForFilial
Local cFilBack := cFilAnt
Local nPosFil	:= 0 

Local aFilAtiv	:= {}

Local cFilSF	:= ''

Default aAliqFunR := {}

Private cbtxt  	:= SPACE(10)
Private cbcont 	:= 00
Private li     	:= 80
Private m_pag  	:= 01 
                                                       
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cabec1 := STR0006 //"FILIAL     DATA       DATA        NF/SERIE      CODIGO      NOME                   PERC.DA     CNPJ                           VALOR TOTAL          VALOR           VALOR          VALOR          DEV.    "
cabec2 := STR0007 //"           EMISSAO    CONTABIL                  CLI/FOR     CLIENTE/FORNECEDOR     OPERACAO                                   NOTA FISCAL          GILRAT          INSS           SENAR        "

nTipo:=IIF(aReturn[4]==1,15,18)

For nForFilial := 1 to Len( aFilsCalc )

	If aFilsCalc[ nForFilial, 1 ]
	
		cFilAnt := aFilsCalc[ nForFilial, 2 ] 
		titulo	:= STR0001 + Space(01) + STR0050 + cFilAnt //"Contribui‡„o Seguridade Social - ENTRADAS" + "- Filial "

		// Guarda as filiais dos arquivos para uso posterior
		If MV_PAR06 == 1
			For nForFilial := 1 to Len( aFilsCalc )
				If aFilsCalc[ nForFilial, 1 ]
					cFilAnt := aFilsCalc[ nForFilial, 2 ]
					aAdd( aFilAtiv, { cFilAnt, xFilial('SF1'), xFilial('SF2'), xFilial('SA1'), xFilial('SA2') } )
				EndIf
			Next
		Else
			aAdd( aFilAtiv, { cFilAnt, xFilial('SF1'), xFilial('SF2'), xFilial('SA1'), xFilial('SA2') } )
		EndIf
		cFilAnt	:= aFilAtiv[1,1]

		If mv_par03 == 1 // Notas Fiscais de Entrada
			
			cFilSF	:= ''
			For nPosFil := 1 to Len(aFilAtiv)
				cFilSF	+= IIf(nPosFil==1,"('","'")+aFilAtiv[nPosFil,2]+IIf(nPosFil==Len(aFilAtiv),"')","',")
			Next
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Cria Indice de Trabalho       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SFT")
			dbSetOrder(1)
			ProcRegua(LastRec())
		
			#IFDEF TOP
			    If TcSrvType()<>"AS/400"
				    lQuery 		:= .T.
					cAliasSFT	:= "SFT_MTR945"
					aStruSFT	:= SFT->(dbStruct())
					cQuery		:= "SELECT DISTINCT SFT.FT_FILIAL, SFT.FT_TIPOMOV, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SD1.D1_ALIQFUN,SFT.FT_ENTRADA,"
					cQuery		+= "SFT.FT_CLIEFOR, SFT.FT_LOJA, FT_TIPO, SUM(SFT.FT_VALCONT) FT_VALCONT, SUM(SD1.D1_TOTAL) D1_TOTAL, SUM(SD1.D1_VALFUN) D1_VALFUN,  SUM(SFT.FT_VALINS) FT_VALINS , SUM(SFT.FT_VLSENAR) FT_VLSENAR, SFT.FT_ITEM "
					cQuery 		+= "FROM " + RetSqlName("SFT") + " SFT "
					cQuery 		+= "INNER JOIN " + RetSqlName("SD1") + " SD1 ON (SD1.D1_FILIAL  IN " + cFilSF + " AND SD1.D1_DOC    = SFT.FT_NFISCAL AND SD1.D1_SERIE = SFT.FT_SERIE AND SD1.D1_FORNECE = SFT.FT_CLIEFOR AND SD1.D1_LOJA = SFT.FT_LOJA AND SD1.D1_COD = SFT.FT_PRODUTO AND SD1.D1_ITEM = SFT.FT_ITEM AND SD1.D_E_L_E_T_ = ' ') "
					cQuery 		+= "WHERE SFT.FT_FILIAL IN " +cFilSF + " AND "
					cQuery 		+= "SFT.FT_EMISSAO >= '" + Dtos(mv_par01) + "' AND "
					cQuery 		+= "SFT.FT_EMISSAO <= '" + Dtos(mv_par02) + "' AND "
					cQuery 		+= "(SD1.D1_VALFUN > 0 OR SD1.D1_VALINS > 0 OR SD1.D1_VLSENAR > 0 OR SD1.D1_ALIQFUN > 0) AND "
					cQuery 		+= "SFT.FT_TIPOMOV = 'E' AND "
					cQuery		+= "SFT.FT_DTCANC = ' ' AND "
					cQuery		+= "SFT.FT_TIPO <> 'S' AND "
					cQuery		+= "SFT.D_E_L_E_T_ = ' ' AND "
					cQuery		+= "SD1.D_E_L_E_T_ = ' ' "
					If !Empty(mv_par04) .And. !Empty(mv_par05)
						cQuery 		+= " AND SFT.FT_ENTRADA >= '" + Dtos(mv_par04) + "' "
						cQuery 		+= " AND SFT.FT_ENTRADA <= '" + Dtos(mv_par05) + "' "
					Endif
					
					cQuery 		+= " GROUP BY SFT.FT_FILIAL, SFT.FT_TIPOMOV, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SD1.D1_ALIQFUN, SFT.FT_ENTRADA,SFT.FT_CLIEFOR, SFT.FT_LOJA, SFT.FT_TIPO, SFT.FT_ITEM"
					cQuery 		+= " ORDER BY  SFT.FT_FILIAL,SFT.FT_NFISCAL,SFT.FT_SERIE ,SFT.FT_CLIEFOR,SFT.FT_LOJA "
					cQuery 		:= ChangeQuery(cQuery)
					
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSFT)
					For nX := 1 To len(aStruSFT)
						If aStruSFT[nX][2] <> "C"
							TcSetField(cAliasSFT,aStruSFT[nX][1],aStruSFT[nX][2],aStruSFT[nX][3],aStruSFT[nX][4])
						EndIf
					Next nX
					dbSelectArea(cAliasSFT)	
				Else
			#ENDIF
				    cIndex    		:= CriaTrab(NIL,.F.)
				    cCondicao 		:= 'FT_FILIAL == "' + cFilSF + '" .And. '
				   	cCondicao 		+= 'DTOS(FT_EMISSAO) >= "' + DTOS(mv_par01) + '" .And. DTOS(FT_EMISSAO) <= "' + DTOS(mv_par02) + '" .And. '
					cCondicao 		+= '(SD1.D1_VALFUN > 0 OR SD1.D1_VALINS > 0 OR SD1.D1_VLSENAR > 0 OR D1_ALIQFUN > 0) AND  '
					If !Empty(mv_par04) .And. !Empty(mv_par05)
						cCondicao 	+= ' .And. DTOS(FT_ENTRADA) >="'+DTOS(mv_par04)+'"'
						cCondicao 	+= ' .And. DTOS(FT_ENTRADA) <="'+DTOS(mv_par05)+'"'
					EndIf	                                                        
				    IndRegua(cAliasSFT,cIndex,SFT->(IndexKey()),,cCondicao)
				    dbSelectArea(cAliasSFT)
				    ProcRegua(LastRec())
				    dbGoTop()
			#IFDEF TOP
				Endif
			#ENDIF          
			
		ElseIf mv_par03 == 2 // Notas Fiscais de Saida

			cFilSF	:= ''
			For nPosFil := 1 to Len(aFilAtiv)
				cFilSF	+= IIf(nPosFil==1,"('","'")+aFilAtiv[nPosFil,3]+IIf(nPosFil==Len(aFilAtiv),"')","',")
			Next

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Cria Indice de Trabalho       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SFT")
			dbSetOrder(1)
			ProcRegua(LastRec())
		
			#IFDEF TOP
			    If TcSrvType()<>"AS/400"
				    lQuery 		:= .T.
					cAliasSF2	:= "SF2_MTR945"
					aStruSF2	:= SFT->(dbStruct())
					cQuery		:= "SELECT SFT.FT_FILIAL, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SFT.FT_FORMUL, SD2.D2_ALIQFUN, " 
					cQuery		+= " SFT.FT_TIPO, SFT.FT_CLIEFOR, SFT.FT_LOJA, SUM(SFT.FT_VALCONT) FT_VALCONT, SUM(SFT.FT_TOTAL) FT_TOTAL, SUM(SD2.D2_VALFUN) D2_VALFUN, SUM(SFT.FT_VALINS) FT_VALINS, SUM(SFT.FT_VLSENAR) FT_VLSENAR, SFT.FT_ITEM "
					cQuery 		+= "FROM " + RetSqlName("SFT") + " SFT "
				    cQuery 		+= "INNER JOIN " + RetSqlName("SD2") + " SD2 ON (SD2.D2_FILIAL  IN " + cFilSF + " AND SD2.D2_DOC    = SFT.FT_NFISCAL AND SD2.D2_SERIE = SFT.FT_SERIE AND SD2.D2_CLIENTE = SFT.FT_CLIEFOR AND SD2.D2_LOJA = SFT.FT_LOJA AND SD2.D2_COD = SFT.FT_PRODUTO AND SD2.D2_ITEM = SFT.FT_ITEM AND SD2.D_E_L_E_T_ = ' ') "
					cQuery 		+= "WHERE SFT.FT_FILIAL IN " + cFilSF + " AND "
					cQuery 		+= "SFT.FT_EMISSAO >= '" + Dtos(mv_par01) + "' AND "
					cQuery 		+= "SFT.FT_EMISSAO <= '" + Dtos(mv_par02) + "' AND "
					cQuery 		+= "SFT.FT_TIPOMOV = 'S' AND "					
					cQuery		+= "SFT.FT_TIPO <> 'S' AND "
					cQuery 		+= "( SD2.D2_VALFUN > 0 OR SFT.FT_VALINS > 0 OR SFT.FT_VLSENAR > 0 ) AND "
					cQuery		+= "SFT.D_E_L_E_T_ = ' ' " 
					cQuery 		+= "GROUP BY SFT.FT_FILIAL, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SD2.D2_ALIQFUN, "
					cQuery 		+= "SFT.FT_CLIEFOR, SFT.FT_LOJA, SFT.FT_TIPO, SFT.FT_FORMUL, SFT.FT_ITEM "
					cQuery 		+= "ORDER BY  SFT.FT_FILIAL,SFT.FT_NFISCAL,SFT.FT_SERIE ,SFT.FT_CLIEFOR,SFT.FT_LOJA "
					cQuery 		:= ChangeQuery(cQuery)
					
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSF2)
					For nX := 1 To len(aStruSF2)
						If aStruSF2[nX][2] <> "C"
							TcSetField(cAliasSF2,aStruSF2[nX][1],aStruSF2[nX][2],aStruSF2[nX][3],aStruSF2[nX][4])
						EndIf
					Next nX
					dbSelectArea(cAliasSF2)	
				Else
			#ENDIF
				    cIndex    		:= CriaTrab(NIL,.F.)
				    cCondicao 		:= 'FT_FILIAL == "' + cFilSF + '" .And. '
				   	cCondicao 		+= 'DTOS(FT_EMISSAO) >= "' + DTOS(mv_par01) + '" .And. DTOS(FT_EMISSAO) <= "' + DTOS(mv_par02) + '" .And. '
					cCondicao 		+= '( SD2.D2_VALFUN > 0 .OR. SFT.FT_VALINS > 0 .OR. SFT.FT_VLSENAR > 0 ) '
				    IndRegua(cAliasSF2,cIndex,SFT->(IndexKey()),,cCondicao)
				    dbSelectArea(cAliasSF2)
				    ProcRegua(LastRec())
				    dbGoTop()
			#IFDEF TOP
				Endif
			#ENDIF
			
		Else // // Notas Fiscais de Entrada e Saida

			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Cria Indice de Trabalho       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			cFilSF	:= ''
			For nPosFil := 1 to Len(aFilAtiv)
				cFilSF	+= IIf(nPosFil==1,"('","'")+aFilAtiv[nPosFil,3]+IIf(nPosFil==Len(aFilAtiv),"')","',")
			Next
			
			dbSelectArea("SFT")
			dbSetOrder(1)
			ProcRegua(LastRec())
		
			#IFDEF TOP
			    If TcSrvType()<>"AS/400"
				    lQuery 		:= .T.
					cAliasSFT	:= "SFT_MTR945"
					aStruSFT	:= SFT->(dbStruct())
					cQuery		:= "SELECT DISTINCT SFT.FT_FILIAL, SFT.FT_TIPOMOV, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SD1.D1_ALIQFUN, SFT.FT_ENTRADA, "
					cQuery		+= "SFT.FT_CLIEFOR, SFT.FT_LOJA, FT_TIPO, SUM(SFT.FT_VALCONT) FT_VALCONT,SUM(SD1.D1_TOTAL) D1_TOTAL,SUM(SD1.D1_VALFUN) D1_VALFUN, SUM(SFT.FT_VALINS) FT_VALINS ,SUM(SFT.FT_VLSENAR) FT_VLSENAR, SFT.FT_ITEM "
					cQuery 		+= "FROM " + RetSqlName("SFT") + " SFT "
					cQuery 		+= "INNER JOIN " + RetSqlName("SD1") + " SD1 ON (SD1.D1_FILIAL  IN " + cFilSF + " AND SD1.D1_DOC    = SFT.FT_NFISCAL AND SD1.D1_SERIE = SFT.FT_SERIE AND SD1.D1_FORNECE = SFT.FT_CLIEFOR AND SD1.D1_LOJA = SFT.FT_LOJA AND SD1.D1_COD = SFT.FT_PRODUTO AND SD1.D1_ITEM = SFT.FT_ITEM AND SD1.D_E_L_E_T_ = ' ') "
					cQuery 		+= "WHERE SFT.FT_FILIAL IN " + cFilSF + " AND "
					cQuery 		+= "SFT.FT_EMISSAO >= '" + Dtos(mv_par01) + "' AND "
					cQuery 		+= "SFT.FT_EMISSAO <= '" + Dtos(mv_par02) + "' AND "
					cQuery 		+= "(SD1.D1_VALFUN > 0 OR SD1.D1_VALINS > 0 OR SD1.D1_VLSENAR > 0 OR SD1.D1_ALIQFUN > 0) AND "
					cQuery 		+= "SFT.FT_TIPOMOV = 'E' AND "
					cQuery		+= "SFT.FT_DTCANC = ' ' AND "
					cQuery		+= "SFT.FT_TIPO <> 'S' AND "
					cQuery		+= "SFT.D_E_L_E_T_ = ' ' AND "
					cQuery		+= "SD1.D_E_L_E_T_ = ' ' "
					If !Empty(mv_par04) .And. !Empty(mv_par05)
						cQuery 	+= " AND SFT.FT_ENTRADA >= '" + Dtos(mv_par04) + "' "
						cQuery 	+= " AND SFT.FT_ENTRADA <= '" + Dtos(mv_par05) + "' "
					Endif

					cQuery      += " GROUP BY SFT.FT_FILIAL, SFT.FT_TIPOMOV, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SD1.D1_ALIQFUN, SFT.FT_ENTRADA,SFT.FT_CLIEFOR, SFT.FT_LOJA, SFT.FT_TIPO, SFT.FT_ITEM "
					cQuery 		+= " ORDER BY  SFT.FT_FILIAL,SFT.FT_NFISCAL,SFT.FT_SERIE ,SFT.FT_CLIEFOR,SFT.FT_LOJA "
					cQuery 		:= ChangeQuery(cQuery)
					
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSFT)
					For nX := 1 To len(aStruSFT)
						If aStruSFT[nX][2] <> "C"
							TcSetField(cAliasSFT,aStruSFT[nX][1],aStruSFT[nX][2],aStruSFT[nX][3],aStruSFT[nX][4])
						EndIf
					Next nX
					dbSelectArea(cAliasSFT)	
				Else
			#ENDIF
				    cIndex    		:= CriaTrab(NIL,.F.)
				    cCondicao 		:= 'FT_FILIAL == "' + cFilSF + '" .And. '
				   	cCondicao 		+= 'DTOS(FT_EMISSAO) >= "' + DTOS(mv_par01) + '" .And. DTOS(FT_EMISSAO) <= "' + DTOS(mv_par02) + '" .And. '
					cCondicao 		+= '(SD1.D1_VALFUN > 0 OR SD1.D1_VALINS > 0 OR SD1.D1_VLSENAR > 0 OR D1_ALIQFUN > 0) AND  '

					If !Empty(mv_par04) .And. !Empty(mv_par05)
						cCondicao 	+= ' .And. DTOS(FT_ENTRADA) >="'+DTOS(mv_par04)+'"'
						cCondicao 	+= ' .And. DTOS(FT_ENTRADA) <="'+DTOS(mv_par05)+'"'
					EndIf	                                                        
				    IndRegua(cAliasSFT,cIndex,SFT->(IndexKey()),,cCondicao)
				    dbSelectArea(cAliasSFT)
				    ProcRegua(LastRec())
				    dbGoTop()
			#IFDEF TOP
		Endif
			#ENDIF
		
			dbSelectArea("SFT")
			dbSetOrder(1)
			ProcRegua(LastRec())
		
			#IFDEF TOP
			    If TcSrvType()<>"AS/400"
				    lQuery 		:= .T.
					cAliasSF2	:= "SF2_MTR945"
					aStruSF2	:= SFT->(dbStruct())
					cQuery		:= "SELECT DISTINCT SFT.FT_FILIAL, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SFT.FT_FORMUL, SD2.D2_ALIQFUN, " 
					cQuery		+= " SFT.FT_TIPO, SFT.FT_CLIEFOR, SFT.FT_LOJA, SUM(SFT.FT_VALCONT) FT_VALCONT, SUM(SFT.FT_TOTAL) FT_TOTAL, SUM(SD2.D2_VALFUN) D2_VALFUN, SUM(SFT.FT_VALINS) FT_VALINS, SUM(SFT.FT_VLSENAR) FT_VLSENAR, SFT.FT_ITEM "
					cQuery 		+= "FROM " + RetSqlName("SFT") + " SFT "
					cQuery 		+= "INNER JOIN " + RetSqlName("SD2") + " SD2 ON (SD2.D2_FILIAL  IN  " + cFilSF + " AND SD2.D2_DOC    = SFT.FT_NFISCAL AND SD2.D2_SERIE = SFT.FT_SERIE AND SD2.D2_CLIENTE = SFT.FT_CLIEFOR AND SD2.D2_LOJA = SFT.FT_LOJA AND SD2.D2_COD = SFT.FT_PRODUTO AND SD2.D2_ITEM = SFT.FT_ITEM AND SD2.D_E_L_E_T_ = ' ') "

					cQuery 		+= "WHERE SFT.FT_FILIAL IN  " + cFilSF + " AND "
					cQuery 		+= "SFT.FT_EMISSAO >= '" + Dtos(mv_par01) + "' AND "
					cQuery 		+= "SFT.FT_EMISSAO <= '" + Dtos(mv_par02) + "' AND "
					cQuery 		+= "SFT.FT_TIPOMOV = 'S' AND "
					cQuery		+= "SFT.FT_TIPO <> 'S' AND "
					cQuery 		+= "( SD2.D2_VALFUN > 0 OR SFT.FT_VALINS > 0 OR SFT.FT_VLSENAR > 0 ) AND "
					cQuery		+= "SFT.D_E_L_E_T_ = ' ' "
					cQuery 		+= " GROUP BY SFT.FT_FILIAL, SFT.FT_EMISSAO, SFT.FT_NFISCAL, SFT.FT_SERIE, SD2.D2_ALIQFUN, "
					cQuery 		+= "SFT.FT_CLIEFOR, SFT.FT_LOJA, SFT.FT_TIPO, SFT.FT_FORMUL, SFT.FT_ITEM "
					cQuery 		+= " ORDER BY  SFT.FT_FILIAL,SFT.FT_NFISCAL,SFT.FT_SERIE ,SFT.FT_CLIEFOR,SFT.FT_LOJA " 
					cQuery 		:= ChangeQuery(cQuery)
					
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSF2)
					For nX := 1 To len(aStruSF2)
						If aStruSF2[nX][2] <> "C" 
							TcSetField(cAliasSF2,aStruSF2[nX][1],aStruSF2[nX][2],aStruSF2[nX][3],aStruSF2[nX][4])
						EndIf
					Next nX
					dbSelectArea(cAliasSF2)
				Else
			#ENDIF
				    cIndex    		:= CriaTrab(NIL,.F.)
				    cCondicao 		:= 'FT_FILIAL == "' + cFilSF + '" .And. '
				   	cCondicao 		+= 'DTOS(FT_EMISSAO) >= "' + DTOS(mv_par01) + '" .And. DTOS(FT_EMISSAO) <= "' + DTOS(mv_par02) + '" .And. '
					cCondicao 		+= ' ( SD2.D2_VALFUN > 0 .OR. SFT.FT_VALINS > 0 .OR. SFT.FT_VLSENAR > 0 ) '
				    IndRegua(cAliasSF2,cIndex,SF2->(IndexKey()),,cCondicao)
				    dbSelectArea(cAliasSF2)
				    ProcRegua(LastRec())
				    dbGoTop()
			#IFDEF TOP
				Endif
			#ENDIF
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona Arquivos e seleciona Ordens.                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SA2")
		dbSetOrder(1)
		
		dbSelectArea("SA1")
		dbSetOrder(1)
		
		dbSelectArea(cAliasSFT)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis da regua.                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTamReg:=(mv_par02-mv_par01)*2
		nTamReg:=IIf(nTamReg>0,nTamReg,2)
		SetRegua(nTamReg)
		nDiaAnt:=mv_par01
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nfs Entrada         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		// While !((cAliasSFT)->(Eof())) .And. (cAliasSFT)->FT_FILIAL == xFilial("SFT") .And. (cAliasSFT)->FT_EMISSAO >= mv_par01 .And. (cAliasSFT)->FT_EMISSAO <= mv_par02 .And. mv_par03 != 2
		While !((cAliasSFT)->(Eof())) .And. (cAliasSFT)->FT_FILIAL $ cFilSF .And. (cAliasSFT)->FT_EMISSAO >= mv_par01 .And. (cAliasSFT)->FT_EMISSAO <= mv_par02 .And. mv_par03 != 2

			IncRegua()
			
			If Interrupcao(@lEnd)
				Exit
			EndIf
			
			If nDiaAnt<> (cAliasSFT)->FT_EMISSAO
				nDiaAnt:= (cAliasSFT)->FT_EMISSAO
			Endif
			
   			Somalinha(0)
			
			@ li,000 PSAY (cAliasSFT)->FT_FILIAL
			@ li,011 PSAY (cAliasSFT)->FT_EMISSAO
			@ li,022 PSAY (cAliasSFT)->FT_ENTRADA
			@ li,034 PSAY alltrim((cAliasSFT)->FT_NFISCAL) + "/" + Alltrim((cAliasSFT)->&(SerieNfId("SFT",3,"FT_SERIE")))
			@ li,048 PSAY (cAliasSFT)->FT_CLIEFOR  + " " + (cAliasSFT)->FT_LOJA
			
			If (cAliasSFT)->FT_TIPO$"D/B"
				dbSelectArea("SA1")
				dbSeek(xFilial()+(cAliasSFT)->FT_CLIEFOR  + (cAliasSFT)->FT_LOJA)
			Else
				dbSelectArea("SA2")
		   		dbSeek(xFilial()+(cAliasSFT)->FT_CLIEFOR  + (cAliasSFT)->FT_LOJA)
			End If
			
			@ li,060 PSAY Iif((cAliasSFT)->FT_TIPO$"D/B",Substr(SA1->A1_NOME,1,20),Substr(SA2->A2_NOME,1,20))
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³
			//³Retorna a aliquota do FunRural³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³
			cTipoRur :=SA2->A2_TIPORUR
			aPFunRur := FunRur()
			aPFunRur[1] := ALLTRIM(STR((cAliasSFT)->D1_ALIQFUN))
			aPFunRur[2] := (cAliasSFT)->D1_ALIQFUN
			//Criado novo Ponto de Entrada: MTR94501
			If (lMTR94501)
				aAliqFunR := Execblock("MTR94501",.F.,.F.,{(cAliasSFT)->FT_CLIEFOR,(cAliasSFT)->FT_LOJA, SA2->A2_TIPORUR, SM0->M0_PRODRUR})
				aPFunRur[2] := aAliqFunR[1]
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³aPFunRur[1]  == "F"³
			//³aPFunRur[2]  == "L"³
			//³aPFunRur[3]  == "J"³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			nPosPer  := at(cTipoRur,"FLJ")
			@ li,076 PSAY Iif(nPosPer > 0 ,aPFunRur[nPosPer],"")
			
			@ li,099 PSAY Iif((cAliasSFT)->FT_TIPO$"D/B",Transform(SA1->A1_CGC,PicPesFJ(IIF(Len(alltrim(SA1->A1_CGC))<14,"F","J"))),Transform(SA2->A2_CGC,PicPesFJ(IIF(Len(alltrim(SA2->A2_CGC))<14,"F","J"))))	
			@ li,128 PSAY (cAliasSFT)->D1_TOTAL   PICTURE "@E 999,999,999.99" 
			@ li,144 PSAY (cAliasSFT)->D1_VALFUN  PICTURE "@E 999,999,999.99" 
			@ li,159 PSAY (cAliasSFT)->FT_VALINS  PICTURE "@E 999,999,999.99"
			@ li,174 PSAY (cAliasSFT)->FT_VLSENAR PICTURE "@E 999,999,999.99"
			@ li,189 PSAY Iif((cAliasSFT)->FT_TIPO == "D","D","")
			
			Somalinha()
		
			dbSelectArea(cAliasSFT)
			
			nTotDiaNf	+= (cAliasSFT)->D1_TOTAL
			nTotDiaFu	+= (cAliasSFT)->D1_VALFUN
			nTotDiaIn	+= (cAliasSFT)->FT_VALINS
			nTotDiaSe	+= (cAliasSFT)->FT_VLSENAR
			nTotEntNf	+= (cAliasSFT)->D1_TOTAL
			nTotEntFu	+= (cAliasSFT)->D1_VALFUN
			nTotEntIn	+= (cAliasSFT)->FT_VALINS
			nTotEntSe	+= (cAliasSFT)->FT_VLSENAR
			dEmissao	:= (cAliasSFT)->FT_EMISSAO
			ccFilial    := (cAliasSFT)->FT_FILIAL
			
			(cAliasSFT)->(dbSkip())
			
			If dEmissao != (cAliasSFT)->FT_EMISSAO .OR. ccFilial != (cAliasSFT)->FT_FILIAL
				Somalinha()
				@ li,000 PSAY STR0009 //"TOTAL DO DIA....................................................................................."
				@ li,123 PSAY nTotDiaNf PICTURE "@E 999,999,999.99"
				@ li,139 PSAY nTotDiaFu PICTURE "@E 999,999,999.99"
				@ li,154 PSAY nTotDiaIn PICTURE "@E 999,999,999.99"
				@ li,169 PSAY nTotDiaSe PICTURE "@E 999,999,999.99"

				Somalinha(2)
				nTotDiaNf:=0
				nTotDiaFu:=0
				nTotDiaIn:=0
				nTotDiaSe:=0				
			Endif
			lFlag := .T.
		Enddo
		
		titulo	:= STR0010 //"Contribuicao Seguridade Social - SAIDAS"
		cabec1	:= STR0011 //"FILIAL     DATA       DATA        NF/SERIE      CODIGO      NOME                     TIPO DO         CNPJ               PERC.OPER           VALOR TOTAL            VALOR            VALOR          VALOR          DEV.   "
		cabec2	:= STR0012 //"           EMISSAO    CONTABIL                  CLI/FOR     CLIENTE/FORNECEDOR       CLIENTE                                                NOTA FISCAL            GILRAT           INSS           SENAR        "
 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nfs Saida           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		dbSelectArea(cAliasSF2)
		
		While !((cAliasSF2)->(Eof())) .And. (cAliasSF2)->FT_FILIAL $ cFilSF .And. (cAliasSF2)->FT_EMISSAO >= mv_par01 .And. (cAliasSF2)->FT_EMISSAO <= mv_par02 .And. mv_par03 != 1 .and. !lEnd
			
			IncRegua()
			If Interrupcao(@lEnd)
				Exit
			Endif
			
			If nDiaAnt<>(cAliasSF2)->FT_EMISSAO
				nDiaAnt:=(cAliasSF2)->FT_EMISSAO
			Endif
			
			If lPassa
				li := 80
				lPassa := .F.
			Endif
			
			If (cAliasSF2)->FT_TIPO$"D/B"
				dbSelectArea("SA2")
				dbSeek(xFilial()+(cAliasSF2)->FT_CLIEFOR+(cAliasSF2)->FT_LOJA)
			Else
				dbSelectArea("SA1")
				dbSeek(xFilial()+(cAliasSF2)->FT_CLIEFOR+(cAliasSF2)->FT_LOJA)
			End If
			
			Somalinha(0)
			
			@ li,000 PSAY (cAliasSF2)->FT_FILIAL
			@ li,011 PSAY (cAliasSF2)->FT_EMISSAO
			@ li,022 PSAY (cAliasSF2)->FT_EMISSAO
			@ li,034 PSAY (cAliasSF2)->FT_NFISCAL + "/" + ALLTRIM((cAliasSF2)->&(SerieNfId("SFT",3,"FT_SERIE")))
			@ li,048 PSAY (cAliasSF2)->FT_CLIEFOR + " " + (cAliasSF2)->FT_LOJA
			
			@ li,060 PSAY Iif ((cAliasSF2)->FT_TIPO$"D/B", Substr(SA2->A2_NOME,1,20),Substr(SA1->A1_NOME,1,20))
			
			@ li,084 PSAY Iif(SA1->A1_TIPO != "F",STR0013,STR0014) //"Nao Cons."###"Consum."
			@ li,098 PSAY Iif((cAliasSF2)->FT_TIPO$"D/B",Transform(SA2->A2_CGC,PicPesFJ(IIF(Len(alltrim(SA2->A2_CGC))<14,"F","J"))),Transform(SA1->A1_CGC,PicPesFJ(IIF(Len(alltrim(SA1->A1_CGC))<14,"F","J"))))	

			@ li,122 PSAY (cAliasSF2)->D2_ALIQFUN PICTURE "@E 99.99"	

			@ li,137 PSAY (cAliasSF2)->FT_VALCONT PICTURE "@E 999,999,999.99"
			@ li,156 PSAY (cAliasSF2)->D2_VALFUN PICTURE "@E 999,999,999.99"
			@ li,171 PSAY (cAliasSF2)->FT_VALINS PICTURE "@E 999,999,999.99"
			@ li,186 PSAY (cAliasSF2)->FT_VLSENAR PICTURE "@E 999,999,999.99"
			@ li,199 PSAY Iif((cAliasSF2)->FT_TIPO == "D","D","")
			
			Somalinha()
			dbSelectArea(cAliasSF2)
			
			If SA1->A1_TIPO != "F"
				nTotDiaNfN	+= (cAliasSF2)->FT_VALCONT     // totais Nao Consumidor
				nTotDiaFuN	+= (cAliasSF2)->D2_VALFUN 
				nTotDiaInN	+= (cAliasSF2)->FT_VALINS
				nTotDiaSeN	+= (cAliasSF2)->FT_VLSENAR
				nTotSaiNfN	+= (cAliasSF2)->FT_VALCONT
				nTotSaiFuN	+= (cAliasSF2)->D2_VALFUN
				nTotSaiInN	+= (cAliasSF2)->FT_VALINS
				nTotSaiSeN	+= (cAliasSF2)->FT_VLSENAR
				dEmissao	:= (cAliasSF2)->FT_EMISSAO
			Else
				nTotDiaNfC	+= (cAliasSF2)->FT_VALCONT      //totais Consumidor
				nTotDiaFuC	+= (cAliasSF2)->D2_VALFUN
				nTotDiaInC	+= (cAliasSF2)->FT_VALINS
				nTotDiaSeC	+= (cAliasSF2)->FT_VLSENAR
				nTotSaiNfC	+= (cAliasSF2)->FT_VALCONT
				nTotSaiFuC	+= (cAliasSF2)->D2_VALFUN
				nTotSaiInC	+= (cAliasSF2)->FT_VALINS
				nTotSaiSeC	+= (cAliasSF2)->FT_VLSENAR
				dEmissao	:= (cAliasSF2)->FT_EMISSAO
			Endif
	
			(cAliasSF2)->(dbSkip())
			
			If dEmissao != (cAliasSF2)->FT_EMISSAO
				Somalinha()
				@ li,000 PSAY STR0015 //"TOTAL DO DIA CONSUMIDOR.........................................................................."
				@ li,137 PSAY nTotDiaNfC PICTURE "@E 999,999,999.99"
				@ li,156 PSAY nTotDiaFuC PICTURE "@E 999,999,999.99"
				@ li,171 PSAY nTotDiaInC PICTURE "@E 999,999,999.99"
				@ li,186 PSAY nTotDiaSeC PICTURE "@E 999,999,999.99"
				Somalinha()
				nTotDiaNfC:=0
				nTotDiaFuC:=0
				@ li,000 PSAY STR0016 //"TOTAL DO DIA NAO CONSUMIDOR......................................................................"
				@ li,137 PSAY nTotDiaNfN PICTURE "@E 999,999,999.99"
				@ li,156 PSAY nTotDiaFuN PICTURE "@E 999,999,999.99"
				@ li,171 PSAY nTotDiaInN PICTURE "@E 999,999,999.99"
				@ li,186 PSAY nTotDiaSeN PICTURE "@E 999,999,999.99"

				Somalinha(2)
				nTotDiaNfN:=0
				nTotDiaFuN:=0
				nTotDiaInN:=0
				nTotDiaSeN:=0
			Endif
			lFlag := .T.
		Enddo
		
		If !lEnd  .And. lFlag
			
			If MV_PAR03 == 1
				Somalinha()
				@ li,000 PSAY STR0017 //"TOTAL GERAL ENTRADAS............................................................................."
				@ li,123 PSAY nTotEntNf PICTURE "@E 999,999,999.99" 
				@ li,139 PSAY nTotEntFu PICTURE "@E 999,999,999.99"
				@ li,154 PSAY nTotEntIn PICTURE "@E 999,999,999.99"
				@ li,169 PSAY nTotEntSe PICTURE "@E 999,999,999.99"
				Somalinha()
			Else
				Somalinha()
				@ li,000 PSAY STR0017 //"TOTAL GERAL ENTRADAS............................................................................."
				@ li,137 PSAY nTotEntNf PICTURE "@E 999,999,999.99" 
				@ li,156 PSAY nTotEntFu PICTURE "@E 999,999,999.99"
				@ li,171 PSAY nTotEntIn PICTURE "@E 999,999,999.99"
				@ li,186 PSAY nTotEntSe PICTURE "@E 999,999,999.99"
				Somalinha()
			Endif
			
			If MV_PAR03 # 1
				Somalinha()
				@ li,000 PSAY STR0018 //"TOTAL GERAL SAIDAS CONSUMIDOR...................................................................."
				@ li,137 PSAY nTotSaiNfC PICTURE "@E 999,999,999.99"
				@ li,156 PSAY nTotSaiFuC PICTURE "@E 999,999,999.99"
				@ li,171 PSAY nTotSaiInC PICTURE "@E 999,999,999.99"
				@ li,186 PSAY nTotSaiSeC PICTURE "@E 999,999,999.99"
				Somalinha()
				@ li,000 PSAY STR0019 //"TOTAL GERAL SAIDAS NAO CONSUMIDOR................................................................."
				@ li,137 PSAY nTotSaiNfN PICTURE "@E 999,999,999.99"
				@ li,156 PSAY nTotSaiFuN PICTURE "@E 999,999,999.99"
				@ li,171 PSAY nTotSaiInN PICTURE "@E 999,999,999.99"
				@ li,186 PSAY nTotSaiSeN PICTURE "@E 999,999,999.99"
				Somalinha()
			Endif

		Endif
		
		
		If Li != 80 .And. !lEnd .And. lFlag
			roda(cbcont,cbtxt,Tamanho)
		EndIF
		

		If lFlag
			Li  := 80 //Quebra pagina por filial
			lFlag := .F.
		Endif
			
		dbSelectArea("SB1")
		dbSetOrder(1)

		// Zera os totalizadores para ser utilizado na proxima filial			
		nTotEntNf  := 0
		nTotEntFu  := 0
		nTotEntIn  := 0
		nTotEntSe  := 0
		nTotSaiNfC := 0
		nTotSaiFuC := 0
		nTotSaiInC := 0
		nTotSaiSeC := 0
		nTotSaiNfN := 0
		nTotSaiFuN := 0
		nTotSaiInN := 0
		nTotSaiSeN := 0			
		
		If mv_par03 == 1
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Excluindo as areas de trabalho SF1 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lQuery
				dbSelectArea(cAliasSFT)
				dbCloseArea()
			Else
				dbSelectArea("SFT")
				RetIndex("SFT")
				dbClearFilter()
				Ferase(cIndex+OrdBagExt())
			Endif	
		ElseIf mv_par03 == 2
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Excluindo as areas de trabalho SF2 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lQuery
				dbSelectArea(cAliasSFT)
				dbCloseArea()
				dbSelectArea(cAliasSF2)
				dbCloseArea()
			Else
				dbSelectArea("SFT")
				RetIndex("SFT")
				dbClearFilter()
				Ferase(cIndex+OrdBagExt())
			Endif	
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Excluindo as areas de trabalho SF1/SF2   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lQuery
				dbSelectArea(cAliasSFT)
				dbCloseArea()
				dbSelectArea(cAliasSF2)
				dbCloseArea()
			Else
			   	dbSelectArea("SFT")
				RetIndex("SFT")
				dbClearFilter()
				Ferase(cIndex+OrdBagExt())
			   	dbSelectArea("SF2")
				RetIndex("SF2")
				dbClearFilter()
				Ferase(cIndex+OrdBagExt())
			Endif
		Endif
	Endif	
Next nForFilial

// Restaura a filial corrente
cFilAnt := cFilBack	
	
Return


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha ³ Autor ³ Luciana Pires        ³ Data ³ 03/10/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa linha e controla quebra de pagina               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAFIS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Somalinha(nInc)

DEFAULT nInc := 1

Li	+=	nInc
If Li > 58
	Cabec(titulo,cabec1,cabec2,nomeprog,Tamanho,nTipo)
EndIf

Return

//-----------------------------------------------------------------------
/*/{Protheus.doc}  fFilPerso
Valida Formula de filtro customizado do relatorio personalizado
@param		cChave		Chave de busca nas tabelas SF1 e SF2
@param		cTipo		Tipo de Nota - E=Entrada S=Saida
@return		lRet		Se encontrou registro filtrado na tabela SF1 para entrada ou SF2 saida
@author Thiago Yoshiaki Miyabara Nascimento - Shiny
@since 22/10/2019
@version 1.0
/*/
//-----------------------------------------------------------------------
Static Function fFilPerso(cChave, cTipo)

Local aArea		:= GetArea()
Local aAreaSF1	:= {}
Local aAreaSF2	:= {}
Local lRet		:= .T.

	If cTipo == "E"
		aAreaSF1	:= SF1->(GetArea())
			dbSelectArea("SF1")
			SF1->(DbSetOrder(1))//F1_FILIAL, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_TIPO, R_E_C_N_O_, D_E_L_E_T_
			lRet := SF1->(dbSeek(xFilial("SF1") + cChave))
		RestArea(aAreaSF1)
	Else
		aAreaSF2	:= SF2->(GetArea())
			dbSelectArea("SF2")
			SF2->(DbSetOrder(1))//F2_FILIAL, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_FORMUL, F2_TIPO, R_E_C_N_O_, D_E_L_E_T_
			lRet := SF2->(dbSeek(xFilial("SF2") + cChave))
		RestArea(aAreaSF2)
	EndIf
	RestArea(aArea)
Return lRet
