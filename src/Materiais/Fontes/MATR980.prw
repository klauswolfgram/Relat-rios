/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Matr980.ch"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³Matr980   ³ Autor ³ Andressa Fagundes     ³ Data ³06/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao das Operacoes Com Retencao de ICMS por Estado      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Matr980()

Local oReport
Local lVerpesssen := Iif(FindFunction("Verpesssen"),Verpesssen(),.T.)
Local cRelease as character

Local cEndWeb		:= "https://tdn.totvs.com/display/PROT/Tabela+SFT+-+Livro+Fiscal+por+Item+de+NF"

cRelease 	:=  GetRPORelease()     

If !IsBlind() 
	If FindFunction("DlgRelVer")
		DlgRelVer("MATR980","Relatorio Lancamentos fiscais",cEndWeb )
	EndIf
EndIf
         

If lVerpesssen
	If TRepInUse()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport	:= ReportDef()
		oReport:PrintDialog()
	Else
		U_Matr980R3()
	EndIf
EndIf

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Andressa Fagundes      ³ Data ³06/06/2006³±±
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
Local oUf
Local oCep
Local oMun
Local oNfs
Local oTeste

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Componente de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("MATR980",STR0001,"MTR980", {|oReport| ReportPrint(oReport,oNfs,oMun,oUf)},STR0002+" "+STR0003)
oReport:SetTotalInLine(.F.) 
oReport:SetLandscape()
Pergunte("MTR980",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 1 - U.F					                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oUf := TRSection():New(oReport,"U.F",{"SA1"},,/*Campos do SX3*/,/*Campos do SIX*/)//
oUf:SetTotalInLine(.F.)
oUf:SetTotalText("TOTAL DO ESTADO")
TRCell():New(oUf,"A1_EST","SA1", "ESTADO",/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
                           
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 1/1 - Municipio					                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oMun := TRSection():New(oUF,"Municipio",{"SA1"},,/*Campos do SX3*/,/*Campos do SIX*/) // 
oMun:SetTotalInLine(.F.)
oMun:SetEdit(.F.)
oMun:SetTotalText("TOTAL DO MUNICIPIO")          
TRCell():New(oMun,"A1_MUN","SA1","MUNICIPIO",/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 1/1/1 - Cep				                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCep := TRSection():New(oMun,"Cep",{"SA1"},,/*Campos do SX3*/,/*Campos do SIX*/) // 
oCep:SetTotalInLine(.F.)
oCep:SetEdit(.F.)
oCep:SetTotalText("TOTAL DO CEP")
TRCell():New(oCep,"A1_CEP","SA1","CEP",/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 1/1/1/1 - Notas Fiscais   	                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oNfs:= TRSection():New(oCep,"Notas Fiscais",{"SF3","SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oNfs:SetTotalInLine(.F.)
oNfs:SetEdit(.F.)
oNfs:SetTotalText("TOTAL DO CEP")
TRCell():New(oNfs,"A1_NOME"		,"SA1"	,"RAZAO SOCIAL",/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"A1_INSCR"	,"SA1"	,"INSC.EST.","@!",13,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"F3_NFISCAL"	,"SF3"	,"NOTA"+CRLF+"FISCAL","@!",9,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,SerieNfId("SF3",3,"F3_SERIE")	,"SF3"	,"SERIE",/*Picture*/,3,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"F3_EMISSAO"	,"SF3"	,"DATA DE "+CRLF+"EMISSAO ",/*Picture*/,10,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"F3_BASERET"	,"SF3"	,"BASE ICMS"+CRLF+"RETIDO","@E 99,999,999.99",13,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"F3_BSRET"	,"SF3"	,"BASE ICMS"+CRLF+"RETIDO DEVOL.","@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"F3_ICMSRET"	,"SF3"	,"VALOR ICMS"+CRLF+"RETIDO","@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"F3_ICRET"	,"SF3"	,"VALOR ICMS"+CRLF+"RETIDO DEVOL.","@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"F3_BASEICM"	,"SF3"	,"BASE ICMS"+CRLF+"NORMAL","@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"F3_BSICM"	,"SF3"	,"BASE ICMS"+CRLF+"NORMAL DEVOL.","@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"F3_VALICM"	,"SF3"	,"VALOR ICMS"+CRLF+"NORMAL","@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfs,"F3_VLICM"	,"SF3"	,"VALOR ICMS"+CRLF+"NORMAL DEVOL.","@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Andressa Fagundes     ³ Data ³06/06/2006³±±
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
Static Function ReportPrint(oReport,oNfs,oMun,oUf)

Local cUF		:=	""
Local cCEP		:=	""
Local cMun	    :=	"" 
Local cAliasSF3	:= "SF3"             
Local cWhere    :=  ''
Local lquery	:= .F.
Local aQuery := {}
Local oFunction
Local oFunction1
Local oFunction2
Local cSelect:= ""

#IFNDEF TOP
	Local cCondicao := "" 
	Local cChave	:= ""
#ENDIF

If mv_par06 == 1 // Analitico
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Totalizadores --> Cep                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRFunction():New(oNfs:Cell("F3_BASERET"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_BSRET")	 ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_ICMSRET"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_ICRET")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_BASEICM"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_BSICM")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_VALICM") ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_VLICM")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/)
	//Valor Liquido
	oFunction:=TRFunction():New(oNfs:Cell("A1_INSCR"),/*cId*/,"ONPRINT",/*oBreak*/,"  "+CRLF+"VALOR LIQUIDO(SAIDAS-DEVOLUCOES):",,{||""},/*lEndSection*/,.F.,/*lEndPage*/)
	oFunction:ShowHeader()
	TRFunction():New(oNfs:Cell("F3_BASERET")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BASERET"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BSRET"):GetValue(.T.)},.T.,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_BSRET")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0 },/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_ICMSRET")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_ICMSRET"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_ICRET"):GetValue(.T.)},/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_ICRET")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0},/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_BASEICM")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BASEICM"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BSICM"):GetValue(.T.)},/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_BSICM")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0},/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_VALICM")   ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_VALICM"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_VLICM"):GetValue(.T.)},/*lEndSection*/,.F.,/*lEndPage*/)
	TRFunction():New(oNfs:Cell("F3_VLICM")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0},/*lEndSection*/,.F.,/*lEndPage*/)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Totalizadores --> Municipio                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRFunction():New(oNfs:Cell("F3_BASERET"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_BSRET")	 ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_ICMSRET"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_ICRET")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_BASEICM"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_BSICM")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_VALICM") ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_VLICM")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	//Valor Liquido
	oFunction1:=TRFunction():New(oNfs:Cell("A1_INSCR"),/*cId*/,"ONPRINT",/*oBreak*/,"  "+CRLF+"VALOR LIQUIDO(SAIDAS-DEVOLUCOES):",,{||""},/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	oFunction1:ShowHeader()
	TRFunction():New(oNfs:Cell("F3_BASERET")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BASERET"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BSRET"):GetValue(.T.)},.T.,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_BSRET")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0 },/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_ICMSRET")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_ICMSRET"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_ICRET"):GetValue(.T.)},/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_ICRET")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0},/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_BASEICM")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BASEICM"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BSICM"):GetValue(.T.)},/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_BSICM")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0},/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_VALICM")   ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_VALICM"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_VLICM"):GetValue(.T.)},/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	TRFunction():New(oNfs:Cell("F3_VLICM")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0},/*lEndSection*/,.F.,/*lEndPage*/,oMun)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Totalizadores --> U.F                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
	oUf:SetTotalInLine(.F.)
	TRFunction():New(oNfs:Cell("F3_BASERET"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_BSRET")	 ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_ICMSRET"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_ICRET")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_BASEICM"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_BSICM")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_VALICM") ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_VLICM")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oUf)
	//Valor Liquido
	oFunction2:=TRFunction():New(oNfs:Cell("A1_INSCR"),/*cId*/,"ONPRINT",/*oBreak*/,"  "+CRLF+"VALOR LIQUIDO(SAIDAS-DEVOLUCOES):",,{||""},/*lEndSection*/,.F.,/*lEndPage*/,oUf)
	oFunction2:ShowHeader()
	TRFunction():New(oNfs:Cell("F3_BASERET")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BASERET"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BSRET"):GetValue(.T.)},/*lEndSection*/,.T.,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_BSRET")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0 },/*lEndSection*/,.T.,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_ICMSRET")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_ICMSRET"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_ICRET"):GetValue(.T.)},/*lEndSection*/,.T.,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_ICRET")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0},/*lEndSection*/,.T.,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_BASEICM")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BASEICM"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BSICM"):GetValue(.T.)},/*lEndSection*/,.T.,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_BSICM")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0},/*lEndSection*/,.T.,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_VALICM")   ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_VALICM"):GetValue(.T.)-oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_VLICM"):GetValue(.T.)},/*lEndSection*/,.T.,/*lEndPage*/,oUf)
	TRFunction():New(oNfs:Cell("F3_VLICM")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",{|| 0},/*lEndSection*/,.T.,/*lEndPage*/,oUf)
Else
	oUf:SetTotalInLine(.T.)
	TRFunction():New(oNfs:Cell("F3_BASERET"),/*cId*/,"SUM",/*oBreak*/,"BASE ICMS RETIDO","@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,.F.,oUf)
	TRFunction():New(oNfs:Cell("F3_BSRET")	 ,/*cId*/,"SUM",/*oBreak*/,"BASE ICMS RETIDO DEVOL.","@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,.F.,oUf)
	TRFunction():New(oNfs:Cell("F3_ICMSRET"),/*cId*/,"SUM",/*oBreak*/,"VALOR ICMS RETIDO","@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,.F.,oUf)
	TRFunction():New(oNfs:Cell("F3_ICRET")  ,/*cId*/,"SUM",/*oBreak*/,"VALOR ICMS RETIDO DEVOL.","@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,.F.,oUf)
	TRFunction():New(oNfs:Cell("F3_BASEICM"),/*cId*/,"SUM",/*oBreak*/,"BASE ICMS NORMAL","@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,.F.,oUf)
	TRFunction():New(oNfs:Cell("F3_BSICM")  ,/*cId*/,"SUM",/*oBreak*/,"BASE ICMS NORMAL DEVOL.","@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,.F.,oUf)
	TRFunction():New(oNfs:Cell("F3_VALICM") ,/*cId*/,"SUM",/*oBreak*/,"VALOR ICMS NORMAL","@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,.F.,oUf)
	TRFunction():New(oNfs:Cell("F3_VLICM")  ,/*cId*/,"SUM",/*oBreak*/,"VALOR ICMS NORMAL DEVOL.","@E 999,999,999.99",/*uFormula*/,/*lEndSection*/,.F.,.F.,oUf)
EndIf

cSelect:="%"
cSelect+= "A1_EST, A1_MUN, A1_CEP, F3_FILIAL,F3_CLIEFOR,F3_LOJA, F3_NFISCAL, F3_SERIE,"
cSelect+= Iif(SerieNfId("SF3",3,"F3_SERIE")<>"F3_SERIE",SerieNfId("SF3",3,"F3_SERIE")+",","")
cSelect+= "F3_EMISSAO, F3_BASERET, F3_ICMSRET, F3_BASEICM, F3_VALICM, F3_ENTRADA, F3_TIPO,F3_CFO, F3_NRLIVRO, A1_NOME, A1_INSCR"
cSelect+= "%"

cWhere := "%"
If MV_PAR05 <> "*"
	cWhere += " AND F3_NRLIVRO = '" +%Exp:(MV_PAR05)% +"' "
EndIf
cWhere += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio filtro do relatorio                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF3")

#IFDEF TOP
    lquery := .T.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 1                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	oReport:Section(1):BeginQuery()	
	                        
	cAliasSF3 := GetNextAlias()
	
	BeginSql Alias cAliasSF3
		
	SELECT %Exp:cSelect% 

	FROM %table:SF3% SF3, %table:SA1% SA1
	
	WHERE F3_FILIAL = %xFilial:SF3%
	 AND F3_ENTRADA >= %Exp:Dtos(mv_par01)%
	 AND F3_ENTRADA <= %Exp:Dtos(mv_par02)%
     AND F3_DTCANC = ' '
     AND F3_ICMSRET >0 
     AND  ( (SUBSTRING(SF3.F3_CFO,1,1) >= '5' AND F3_TIPO <> 'D')
     		OR (SUBSTRING(SF3.F3_CFO,1,1) <= '4' AND F3_TIPO = 'D' ))
     AND A1_FILIAL = %xFilial:SA1%
     AND A1_LOJA = F3_LOJA
	  AND A1_COD = F3_CLIEFOR
	  AND A1_EST >= %Exp:(mv_par03)%
	  AND A1_EST <= %Exp:(mv_par04)%
	  AND SF3.%NotDel%
	  AND SA1.%NotDel%
	  %Exp:cWhere%           
	  
	ORDER BY A1_EST, A1_MUN, A1_CEP, F3_FILIAL,F3_EMISSAO, F3_NFISCAL, F3_SERIE,  F3_CLIEFOR, F3_LOJA
	
	EndSql

	aQuery := GetLastQuery()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

 	oReport:Section(1):Section(1):SetParentQuery()
	oReport:Section(1):Section(1):SetParentFilter( { |cParam| (cAliasSF3)->A1_EST == cParam},{ || (cAliasSF3)->A1_EST })
	oReport:Section(1):Section(1):Section(1):SetParentQuery()
	oReport:Section(1):Section(1):Section(1):SetParentFilter( { |cParam| (cAliasSF3)->A1_EST+(cAliasSF3)->A1_MUN ==cParam},{ || (cAliasSF3)->A1_EST+(cAliasSF3)->A1_MUN })
	oReport:Section(1):Section(1):Section(1):Section(1):SetParentQuery()
	oReport:Section(1):Section(1):Section(1):Section(1):SetParentFilter( { |cParam| (cAliasSF3)->A1_EST+(cAliasSF3)->A1_MUN+(cAliasSF3)->A1_CEP == cParam},{ || (cAliasSF3)->A1_EST+(cAliasSF3)->A1_MUN+(cAliasSF3)->A1_CEP})
	oReport:Section(1):Section(1):Section(1):Section(1):SetLineCondition({|| !((cAliasSF3)->F3_TIPO $ "SL") .OR. !(VAL(substr((cAliasSF3)->F3_CFO,1,1)) < 5 .And. (cAliasSF3)->F3_TIPO <> "D")})

#ELSE
	MakeAdvplExpr(oReport:uParam)

	cChave	  := "F3_FILIAL+F3_CLIEFOR+F3_LOJA"
	cCondicao := "F3_FILIAL == '"+xFilial("SF3")+"' .AND. "
	cCondicao += "Dtos(F3_ENTRADA)>= '"+Dtos(mv_par01)+"' .And. Dtos(F3_ENTRADA)<= '"+DTos(mv_par02)+"' .And. "
	cCondicao += "Empty(F3_DTCANC) .And. F3_ICMSRET > 0 "
	If mv_par05 <> "*"
		cCondicao += ".And. F3_NRLIVRO=='"+mv_par05+"'"
	Endif
    
	oReport:Section(1):Section(1):Section(1):Section(1):SetFilter(cCondicao,cChave)

	dbSelectArea("SA1")
	cChave	  := "A1_EST+A1_MUN+A1_CEP"
	cCondicao := "A1_FILIAL == '"+xFilial()+"' .AND. "
	cCondicao += "A1_EST >='"+mv_par03+"'.And. A1_EST<='"+mv_par04+"'"
      
	oReport:Section(1):SetFilter(cCondicao,cChave)
	oReport:Section(1):Section(1):SetParentFilter({|cParam| SA1->A1_EST == cParam },{|| SA1->A1_EST})
	oReport:Section(1):Section(1):Section(1):SetParentFilter({|cParam| SA1->A1_EST+SA1->A1_MUN == cParam},{|| SA1->A1_EST+SA1->A1_MUN})
	oReport:Section(1):Section(1):Section(1):Section(1):SetRelation({|| xFilial("SF3")+SA1->A1_COD+SA1->A1_LOJA},"SF3",4,.T.)
	oReport:Section(1):Section(1):Section(1):Section(1):SetParentFilter({|cParam| SF3->F3_FILIAL+SF3->F3_CLIEFOR+SF3->F3_LOJA == xFilial("SF3")+SA1->A1_COD+SA1->A1_LOJA .And. SA1->A1_EST+SA1->A1_MUN+SA1->A1_CEP == cParam},{|| SA1->A1_EST+SA1->A1_MUN+SA1->A1_CEP})
	oReport:Section(1):Section(1):Section(1):Section(1):SetLineCondition({|| !(SF3->F3_TIPO $ "SL" .OR. (VAL(substr(SF3->F3_CFO,1,1)) < 5 .And. SF3->F3_TIPO <> "D") .Or. SF3->F3_ICMSRET == 0.00)})

#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Alterando codeblocks para impressao		                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BASERET"):SetBlock({|| Iif((cAliasSF3)->F3_TIPO<>"D" .And. ((cAliasSF3)->F3_TIPO<>"B" .And. !((cAliasSF3)->F3_CFO $ "2918#1918")),(cAliasSF3)->F3_BASERET,0)})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BSRET"):SetBlock({|| Iif((cAliasSF3)->F3_TIPO<>"D" .And. ((cAliasSF3)->F3_TIPO<>"B" .And. !((cAliasSF3)->F3_CFO $ "2918#1918")),0,(cAliasSF3)->F3_BASERET)})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_ICMSRET"):SetBlock({|| Iif((cAliasSF3)->F3_TIPO<>"D" .And. ((cAliasSF3)->F3_TIPO<>"B" .And. !((cAliasSF3)->F3_CFO $ "2918#1918")),(cAliasSF3)->F3_ICMSRET,0)})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_ICRET"):SetBlock({|| Iif((cAliasSF3)->F3_TIPO<>"D" .And. ((cAliasSF3)->F3_TIPO<>"B" .And. !((cAliasSF3)->F3_CFO $ "2918#1918")),0,(cAliasSF3)->F3_ICMSRET)})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BASEICM"):SetBlock({|| Iif((cAliasSF3)->F3_TIPO<>"D" .And. ((cAliasSF3)->F3_TIPO<>"B" .And. !((cAliasSF3)->F3_CFO $ "2918#1918")),(cAliasSF3)->F3_BASEICM,0)})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_BSICM"):SetBlock({|| Iif((cAliasSF3)->F3_TIPO<>"D" .And. ((cAliasSF3)->F3_TIPO<>"B" .And. !((cAliasSF3)->F3_CFO $ "2918#1918")),0,(cAliasSF3)->F3_BASEICM)})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_VALICM"):SetBlock({|| Iif((cAliasSF3)->F3_TIPO<>"D" .And. ((cAliasSF3)->F3_TIPO<>"B" .And. !((cAliasSF3)->F3_CFO $ "2918#1918")),(cAliasSF3)->F3_VALICM,0)})
oReport:Section(1):Section(1):Section(1):Section(1):Cell("F3_VLICM"):SetBlock({|| Iif((cAliasSF3)->F3_TIPO<>"D" .And. ((cAliasSF3)->F3_TIPO<>"B" .And. !((cAliasSF3)->F3_CFO $ "2918#1918")),0,(cAliasSF3)->F3_VALICM)})
                                     
If mv_par06 == 2 //-- Sintetico
	oReport:Section(1):Section(1):SetHeaderSection(.F.)
	oReport:Section(1):Section(1):Hide()
	oReport:Section(1):Section(1):Section(1):SetHeaderSection(.F.)
	oReport:Section(1):Section(1):Section(1):Hide()
	oReport:Section(1):Section(1):Section(1):Section(1):SetHeaderSection(.F.)
	oReport:Section(1):Section(1):Section(1):Section(1):Hide()
	oReport:Section(1):Print()
Else
	oReport:Section(1):Print()
EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MATR980R3 ³ Autor ³ Gilson do Nascimento  ³ Data ³ 27.02.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao das Operacoes Com Retencao de ICMS por Estado       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR980R3 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cabec1,cabec2,cabec3,wnrel
LOCAL Titulo  		:=STR0001 //"** RELACAO DAS OPERACOES COM RETENCAO DE ICMS POR ESTADO **"
LOCAL cDesc1  		:=STR0002 //"Emissao dos Documentos Fiscais que obtiveram retencao de "
LOCAL cDesc2  		:=STR0003 //"ICMS que cada estado emissor.                            "
LOCAL cDesc3  		:=""   
PRIVATE Tamanho		:=	"G"
PRIVATE cString		:=	"SF3"
PRIVATE aReturn		:=	{ STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE aLinha		:=	{}
PRIVATE	nomeprog	:="MATR980"
PRIVATE	nLastKey 	:= 0
PRIVATE	cPerg  		:=	"MTR980"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // da Data                              ³
//³ mv_par02             // ate a Data                           ³
//³ mv_par03             // Estado Destino De                    ³
//³ mv_par04             // Estado Destino Ate                   ³
//³ mv_par05             // Livro Selecionado                    ³
//³ mv_par06             // Quanto Impr. 1-Analitico 2-Sintetico ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel	:=	"MATR980"   // nome default do relatorio em disco
wnrel	:=	SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

RptStatus({|lEnd| R980Imp(@lEnd,wnRel,titulo)},titulo)

Return NIL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R980IMP  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 27/02/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR980  			                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R980Imp(lEnd,WnRel,titulo)
Local CbCont
Local CbTxt
Local cUF  			:=	""
Local nPagina  		:= 	0
Local Li  			:= 	80
Local aBaseRet 		:= 	{}
Local aBaseRetD 	:= 	{}
Local aValRet		:= 	{}
Local aValRetD 		:= 	{}
Local aBase 		:= 	{}
Local aBaseD 		:= 	{}
Local aValICM 		:= 	{}
Local aValICMD 		:= 	{}
Local aLqBasRet		:=	{}
Local aLqValRet		:=	{}
Local aLqBase		:=	{}
Local aLqICMS		:=	{}
Local nI			:=	0   
Local cFilterUser	:= aReturn[7]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³1 = Totais por Estado   ³
//³2 = Totais por Municipio³
//³3 = Totais por CEP      ³
//³4 = Total Geral         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nI := 1 to 4
	aAdd(aBaseRet,0)
	aAdd(aBaseRetD,0)
	aAdd(aValRet,0)
	aAdd(aValRetD,0)
	aAdd(aBase,0)
	aAdd(aBaseD,0)
	aAdd(aValICM,0)
	aAdd(aValICMD,0)
	aAdd(aLqBasRet,0)
	aAdd(aLqValRet,0)
	aAdd(aLqBase,0)
	aAdd(aLqICMS,0)
Next
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cabec1  :=STR0006 //"RAZAO SOCIAL                              MUNICIPIO       UF INSC. ESTADUAL     NOTA   SER DATA DE        BASE ICMS     BASE ICMS      VALOR ICMS     VALOR ICMS      BASE ICMS      BASE ICMS     VALOR ICMS    VALOR ICMS"
Cabec2  :=STR0007 //"                                                                                FISCAL     EMISSAO           RETIDO  RETIDO DEVOL.         RETIDO  RETIDO DEVOL.         NORMAL  NORMAL DEVOL.         NORMAL NORMAL DEVOL."
//                   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XX XXXXXXXXXXXXXXXXXX 999999 XXX DD/MM/AA  999,999,999,99 999,999,999,99 999,999,999,99 999,999,999,99 999,999,999,99 999,999,999,99 999,999,999,99 999,999,999,99"
//	                 0         10        20        30        40        50        60        70        80       90        100       110       120       130       140       150       160       170       180       190       200       210        220
//                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acumuladores Fiscais e variaveis auxiliares                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cUF      := ""
nPagina  := 0
cbcont   := 0
m_pag    := 1
cbtxt    := Space(10)
nTipo    := 15

dbSelectArea("SF3")

cNomeArq1:=	CriaTrab("",.F.)
cFiltro	:=	"F3_FILIAL=='"+xFilial("SF3")+"' .and. empty(F3_DTCANC) .And. F3_ICMSRET > 0"	// COCACOLA
cFiltro	+=	" .and. ((Substr(F3_CFO,1,1) >= '5' .and. F3_TIPO <> 'D') .or. (Substr(F3_CFO,1,1) <= '4' .and. F3_TIPO = 'D' )) "

If mv_par05!="*"								// COCACOLA
	cFiltro	+=	".And.SF3->F3_NRLIVRO=='"+mv_par05+"'"
Endif  
If !Empty(cFilterUser)
	cFiltro := "(" + Alltrim(cFiltro) + ") .And. (" + Alltrim(cFilterUser) + ")"
Endif
IndRegua("SF3",cNomeArq1,"F3_FILIAL+F3_CLIEFOR+F3_LOJA",,cFiltro,STR0008) //"Selecionando Registros..."
dbGoTop()

dbSelectArea("SA1")
cNomeArq2:= Subs(cNomeArq1,1,6)+"A"
cFiltro	:=	"A1_FILIAL=='"+xFilial()+"'.And.A1_EST>='"+mv_par03+"'.And.A1_EST<='"+mv_par04+"'"
IndRegua("SA1",cNomeArq2,"A1_EST+A1_MUN+A1_CEP",,cFiltro,STR0008) //"Selecionando Registros..."
dbGotop()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas na regua de processamento               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(LastRec())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a  impressao do Relatorio       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While !Eof()
	If lEnd
		@ PROW()+1,001 PSAY STR0009 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	aBaseRet[01]	:= 0
	aBaseRetD[01]	:= 0
	aValRet[01]		:= 0
	aValRetD[01]	:= 0
	aBase[01]		:= 0
	aBaseD[01]		:= 0
	aValICM[01]		:= 0
	aValICMD[01]	:= 0
	aLqBasRet[01]	:= 0
	aLqValRet[01]	:= 0
	aLqBase[01]		:= 0
	aLqICMS[01]		:= 0
	cEst			:= A1_EST
	While !Eof().And.cEst==A1_EST
		aBaseRet[02]	:= 0
		aBaseRetD[02]	:= 0
		aValRet[02]		:= 0
		aValRetD[02]	:= 0
		aBase[02]		:= 0
		aBaseD[02]		:= 0
		aValICM[02]		:= 0
		aValICMD[02]	:= 0
		aLqBasRet[02]	:= 0
		aLqValRet[02]	:= 0
		aLqBase[02]		:= 0
		aLqICMS[02]		:= 0
		cMun 			:= A1_MUN                                         
		While !Eof().And.cEst+cMun == A1_EST+A1_MUN
			aBaseRet[03]	:= 0
			aBaseRetD[03]	:= 0
			aValRet[03]		:= 0
			aValRetD[03]	:= 0
			aBase[03]		:= 0
			aBaseD[03]		:= 0
			aValICM[03]		:= 0
			aValICMD[03]	:= 0
			aLqBasRet[03]	:= 0
			aLqValRet[03]	:= 0
			aLqBase[03]		:= 0
			aLqICMS[03]		:= 0
			cCep			:= A1_CEP
			While !Eof().And.cEst+cMun+cCep == A1_EST+A1_MUN+A1_CEP
				IncRegua()
				dbSelectArea("SF3")
				cChave:=xFilial("SF3")+SA1->A1_COD+SA1->A1_LOJA
				dbSeek(cChave)
				While !Eof() .And. cChave==F3Filial("SF3")+F3_CLIEFOR+F3_LOJA
					If (SF3->F3_ENTRADA < mv_par01 .or. SF3->F3_ENTRADA > mv_par02);
						.OR. SF3->F3_TIPO $ "SL" .OR. (VAL(substr(SF3->F3_CFO,1,1)) < 5 .And. SF3->F3_TIPO <> "D") .OR.;
						SF3->F3_ICMSRET == 0.00
						dbSkip()
						Loop
					Endif                                                 
					
					
					If li > 55
						cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
						li	:=	Prow()
					EndIF
					If mv_par06 == 1
						li++
						@ li,000 PSAY Alltrim(SA1->A1_NOME)
						@ li,039 PSAY SA1->A1_MUN
						@ li,055 PSAY SA1->A1_EST
						@ li,058 PSAY SA1->A1_INSCR
						@ li,077 PSAY SF3->F3_NFISCAL
						@ li,087 PSAY SF3->&(SerieNfId("SF3",3,"F3_SERIE"))
						@ li,093 PSAY SF3->F3_EMISSAO
						@ li,101 PSAY Iif(SF3->F3_TIPO<>"D",SF3->F3_BASERET,0)  Picture PesqPict("SF3","F3_BASERET",14)
						@ li,116 PSAY Iif(SF3->F3_TIPO<>"D",0,SF3->F3_BASERET)  Picture PesqPict("SF3","F3_BASERET",14)
						@ li,131 PSAY Iif(SF3->F3_TIPO<>"D",SF3->F3_ICMSRET,0)  Picture PesqPict("SF3","F3_ICMSRET",14)
						@ li,146 PSAY Iif(SF3->F3_TIPO<>"D",0,SF3->F3_ICMSRET)  Picture PesqPict("SF3","F3_ICMSRET",14)						
						@ li,161 PSAY Iif(SF3->F3_TIPO<>"D",SF3->F3_BASEICM,0)  Picture PesqPict("SF3","F3_BASEICM",14)
						@ li,176 PSAY Iif(SF3->F3_TIPO<>"D",0,SF3->F3_BASEICM0) Picture PesqPict("SF3","F3_BASEICM",14)						
						@ li,191 PSAY Iif(SF3->F3_TIPO<>"D",SF3->F3_VALICM,0)   Picture PesqPict("SF3","F3_VALICM",14)
						@ li,206 PSAY Iif(SF3->F3_TIPO<>"D",0,SF3->F3_VALICM)   Picture PesqPict("SF3","F3_VALICM",14)						
					Endif
					aBaseRet[03]	+= Iif(SF3->F3_TIPO<>"D",SF3->F3_BASERET,0)
					aBaseRetD[03]	+= Iif(SF3->F3_TIPO<>"D",0,SF3->F3_BASERET)
					aValRet[03]		+= Iif(SF3->F3_TIPO<>"D",SF3->F3_ICMSRET,0)
					aValRetD[03]	+= Iif(SF3->F3_TIPO<>"D",0,SF3->F3_ICMSRET)
					aBase[03]		+= Iif(SF3->F3_TIPO<>"D",SF3->F3_BASEICM,0)
					aBaseD[03]		+= Iif(SF3->F3_TIPO<>"D",0,SF3->F3_BASEICM)
					aValICM[03]		+= Iif(SF3->F3_TIPO<>"D",SF3->F3_VALICM,0)
					aValICMD[03]	+= Iif(SF3->F3_TIPO<>"D",0,SF3->F3_VALICM)
					aLqBasRet[03]	+= Iif(SF3->F3_TIPO<>"D",SF3->F3_BASERET,SF3->F3_BASERET * -1)
					aLqValRet[03]	+= Iif(SF3->F3_TIPO<>"D",SF3->F3_ICMSRET,SF3->F3_ICMSRET * -1)
					aLqBase[03]		+= Iif(SF3->F3_TIPO<>"D",SF3->F3_BASEICM,SF3->F3_BASEICM * -1)
					aLqICMS[03]		+= Iif(SF3->F3_TIPO<>"D",SF3->F3_VALICM,SF3->F3_VALICM * -1)
					dbSkip()
				EndDo
				dbSelectArea("SA1")
				dbSkip()
			EndDo
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime total por CEP.              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Abs((aBaseRet[03] + aBaseRetD[03] + aValRet[03] + aValRetD[03] + aBase[03] + aBaseD[03] + aValICM[03] + aValICMD[03])) > 0
				If li > 55
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
					li	:=	Prow()
				Endif
				If mv_par06 == 1
					li++
					@ li,000 PSAY STR0010+cCep //"Total do Cep -> "
					@ li,101 PSAY aBaseRet[03] Picture PesqPict("SF3","F3_BASERET",14)
					@ li,116 PSAY aBaseRetD[03] Picture PesqPict("SF3","F3_BASERET",14)
					@ li,131 PSAY aValRet[03] Picture PesqPict("SF3","F3_ICMSRET",14)
					@ li,146 PSAY aValRetD[03] Picture PesqPict("SF3","F3_ICMSRET",14)		
					@ li,161 PSAY aBase[03] Picture PesqPict("SF3","F3_BASEICM",14)
					@ li,176 PSAY aBaseD[03] Picture PesqPict("SF3","F3_BASEICM",14)
					@ li,191 PSAY aValICM[03] Picture PesqPict("SF3","F3_VALICM",14)		
					@ li,206 PSAY aValICMD[03] Picture PesqPict("SF3","F3_VALICM",14)
					li++ 
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Imprime o Total Liquido => Saidas - Devolucoes³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					@ li,000 PSAY STR0014 //"Valor Liquido (SAIDAS - DEVOLUCOES)"
					@ li,101 PSAY aLqBasRet[03] Picture PesqPict("SF3","F3_BASERET",14)
					@ li,116 PSAY 0 Picture PesqPict("SF3","F3_BASERET",14)
					@ li,131 PSAY aLqValRet[03] Picture PesqPict("SF3","F3_ICMSRET",14)
					@ li,146 PSAY 0 Picture PesqPict("SF3","F3_ICMSRET",14)		
					@ li,161 PSAY aLqBase[03] Picture PesqPict("SF3","F3_BASEICM",14)
					@ li,176 PSAY 0 Picture PesqPict("SF3","F3_BASEICM",14)
					@ li,191 PSAY aLqICMS[03] Picture PesqPict("SF3","F3_VALICM",14)		
					@ li,206 PSAY 0 Picture PesqPict("SF3","F3_VALICM",14)
					li++
					@ li,000 PSAY Repli("-",220)
				Endif
			Endif
			aBaseRet[02] 	+= aBaseRet[03]
			aBaseRetD[02] 	+= aBaseRetD[03]
			aValRet[02] 	+= aValRet[03]
			aValRetD[02] 	+= aValRetD[03]
			aBase[02]  		+= aBase[03]
			aBaseD[02] 		+= aBaseD[03]
			aValICM[02] 	+= aValICM[03]
			aValICMD[02] 	+= aValICMD[03]
			aLqBasRet[02]	+= aLqBasRet[03]
			aLqValRet[02] 	+= aLqValRet[03]
			aLqBase[02] 	+= aLqBase[03]
			aLqICMS[02] 	+= aLqICMS[03]
		EndDo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime total por municipio.        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Abs((aBaseRet[02] + aBaseRetD[02] + aValRet[02] + aValRetD[02] + aBase[02] + aBaseD[02] + aValICM[02] + aValICMD[02])) > 0 .And. mv_par06 == 1
			IF li > 55
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				li	:=	Prow()
			EndIF
			li++
			@ li,000 PSAY STR0011+cMun //"Total do Municipo -> "
			@ li,101 PSAY aBaseRet[02] Picture PesqPict("SF3","F3_BASERET",14)
			@ li,116 PSAY aBaseRetD[02] Picture PesqPict("SF3","F3_BASERET",14)
			@ li,131 PSAY aValRet[02] Picture PesqPict("SF3","F3_ICMSRET",14)
			@ li,146 PSAY aValRetD[02] Picture PesqPict("SF3","F3_ICMSRET",14)		
			@ li,161 PSAY aBase[02] Picture PesqPict("SF3","F3_BASEICM",14)
			@ li,176 PSAY aBaseD[02] Picture PesqPict("SF3","F3_BASEICM",14)
			@ li,191 PSAY aValICM[02] Picture PesqPict("SF3","F3_VALICM",14)		
			@ li,206 PSAY aValICMD[02] Picture PesqPict("SF3","F3_VALICM",14)
			li++ 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Imprime o Total Liquido => Saidas - Devolucoes³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			@ li,000 PSAY STR0014 //"Valor Liquido (SAIDAS - DEVOLUCOES)"
			@ li,101 PSAY aLqBasRet[02] Picture PesqPict("SF3","F3_BASERET",14)
			@ li,116 PSAY 0 Picture PesqPict("SF3","F3_BASERET",14)
			@ li,131 PSAY aLqValRet[02] Picture PesqPict("SF3","F3_ICMSRET",14)
			@ li,146 PSAY 0 Picture PesqPict("SF3","F3_ICMSRET",14)		
			@ li,161 PSAY aLqBase[02] Picture PesqPict("SF3","F3_BASEICM",14)
			@ li,176 PSAY 0 Picture PesqPict("SF3","F3_BASEICM",14)
			@ li,191 PSAY aLqICMS[02] Picture PesqPict("SF3","F3_VALICM",14)		
			@ li,206 PSAY 0 Picture PesqPict("SF3","F3_VALICM",14)
			li++
			@ li,000 PSAY Repli("-",220)
		Endif
		aBaseRet[01] 	+= aBaseRet[02]
		aBaseRetD[01] 	+= aBaseRetD[02]
		aValRet[01] 	+= aValRet[02]
		aValRetD[01] 	+= aValRetD[02]
		aBase[01]  		+= aBase[02]
		aBaseD[01] 		+= aBaseD[02]
		aValICM[01] 	+= aValICM[02]
		aValICMD[01] 	+= aValICMD[02]
		aLqBasRet[01]	+= aLqBasRet[02]
		aLqValRet[01] 	+= aLqValRet[02]
		aLqBase[01] 	+= aLqBase[02]
		aLqICMS[01] 	+= aLqICMS[02]
	EndDo
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime total por estado.           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Abs((aBaseRet[01] + aBaseRetD[01] + aValRet[01] + aValRetD[01] + aBase[01] + aBaseD[01] + aValICM[01] + aValICMD[01])) > 0
		IF li > 55
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			li	:=	Prow()
		EndIF
		li++
		@ li,000 PSAY STR0012+cEst //"Total do Estado -> "
		@ li,101 PSAY aBaseRet[01] Picture PesqPict("SF3","F3_BASERET",14)
		@ li,116 PSAY aBaseRetD[01] Picture PesqPict("SF3","F3_BASERET",14)
		@ li,131 PSAY aValRet[01] Picture PesqPict("SF3","F3_ICMSRET",14)
		@ li,146 PSAY aValRetD[01] Picture PesqPict("SF3","F3_ICMSRET",14)		
		@ li,161 PSAY aBase[01] Picture PesqPict("SF3","F3_BASEICM",14)
		@ li,176 PSAY aBaseD[01] Picture PesqPict("SF3","F3_BASEICM",14)
		@ li,191 PSAY aValICM[01] Picture PesqPict("SF3","F3_VALICM",14)		
		@ li,206 PSAY aValICMD[01] Picture PesqPict("SF3","F3_VALICM",14)
		li++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime o Total Liquido => Saidas - Devolucoes³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ li,000 PSAY STR0014 //"Valor Liquido (SAIDAS - DEVOLUCOES)"
		@ li,101 PSAY aLqBasRet[01] Picture PesqPict("SF3","F3_BASERET",14)
		@ li,116 PSAY 0 Picture PesqPict("SF3","F3_BASERET",14)
		@ li,131 PSAY aLqValRet[01] Picture PesqPict("SF3","F3_ICMSRET",14)
		@ li,146 PSAY 0 Picture PesqPict("SF3","F3_ICMSRET",14)		
		@ li,161 PSAY aLqBase[01] Picture PesqPict("SF3","F3_BASEICM",14)
		@ li,176 PSAY 0 Picture PesqPict("SF3","F3_BASEICM",14)
		@ li,191 PSAY aLqICMS[01] Picture PesqPict("SF3","F3_VALICM",14)		
		@ li,206 PSAY 0 Picture PesqPict("SF3","F3_VALICM",14)
		li++
		@ li,000 PSAY Repli("-",220)
	Endif
	aBaseRet[04] 	+= aBaseRet[01]
	aBaseRetD[04] 	+= aBaseRetD[01]
	aValRet[04] 	+= aValRet[01]
	aValRetD[04] 	+= aValRetD[01]
	aBase[04]  		+= aBase[01]
	aBaseD[04] 		+= aBaseD[01]
	aValICM[04] 	+= aValICM[01]
	aValICMD[04] 	+= aValICMD[01]
	aLqBasRet[04]	+= aLqBasRet[01]
	aLqValRet[04] 	+= aLqValRet[01]
	aLqBase[04] 	+= aLqBase[01]
	aLqICMS[04] 	+= aLqICMS[01]
EndDo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime total geral.                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Abs((aBaseRet[04] + aBaseRetD[04] + aValRet[04] + aValRetD[04] + aBase[04] + aBaseD[04] + aValICM[04] + aValICMD[04])) > 0
	IF li > 55
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		li	:=	Prow()
	EndIF
	li++
	@ li,000 PSAY STR0013 //"Total Geral ->"
	@ li,101 PSAY aBaseRet[04] Picture PesqPict("SF3","F3_BASERET",14)
	@ li,116 PSAY aBaseRetD[04] Picture PesqPict("SF3","F3_BASERET",14)
	@ li,131 PSAY aValRet[04] Picture PesqPict("SF3","F3_ICMSRET",14)
	@ li,146 PSAY aValRetD[04] Picture PesqPict("SF3","F3_ICMSRET",14)		
	@ li,161 PSAY aBase[04] Picture PesqPict("SF3","F3_BASEICM",14)
	@ li,176 PSAY aBaseD[04] Picture PesqPict("SF3","F3_BASEICM",14)
	@ li,191 PSAY aValICM[04] Picture PesqPict("SF3","F3_VALICM",14)		
	@ li,206 PSAY aValICMD[04] Picture PesqPict("SF3","F3_VALICM",14)
	li++
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o Total Liquido => Saidas - Devolucoes³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ li,000 PSAY STR0014 //"Valor Liquido (SAIDAS - DEVOLUCOES)"
	@ li,101 PSAY aLqBasRet[04] Picture PesqPict("SF3","F3_BASERET",14)
	@ li,116 PSAY 0 Picture PesqPict("SF3","F3_BASERET",14)
	@ li,131 PSAY aLqValRet[04] Picture PesqPict("SF3","F3_ICMSRET",14)
	@ li,146 PSAY 0 Picture PesqPict("SF3","F3_ICMSRET",14)		
	@ li,161 PSAY aLqBase[04] Picture PesqPict("SF3","F3_BASEICM",14)
	@ li,176 PSAY 0 Picture PesqPict("SF3","F3_BASEICM",14)
	@ li,191 PSAY aLqICMS[04] Picture PesqPict("SF3","F3_VALICM",14)		
	@ li,206 PSAY 0 Picture PesqPict("SF3","F3_VALICM",14)
	li++
	@ li,000 PSAY Repli("=",220)
Endif
If li < 60
	roda(cbcont,cbtxt,Tamanho)
Endif

dbSelectArea("SF2")
dbClearFilter()
dbSetOrder(1)

dbSelectArea("SA1")
dbClearFilter()
RetIndex("SA1")
dbSetOrder(1)

dbSelectArea("SF3")
dbClearFilter()
RetIndex("SF3")
dbSetOrder(1)

If File(cNomeArq1+OrdBagExt())
	fErase(cNomeArq1+OrdBagExt())
Endif

If File(cNomeArq2+OrdBagExt())
	fErase(cNomeArq2+OrdBagExt())
Endif

If aReturn[5] == 1
	Set Printer TO
	dbcommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return
