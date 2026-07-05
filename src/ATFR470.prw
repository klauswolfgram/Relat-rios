/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR470.ch"

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR470   ºAutor  ³Alexandre Circenis  º Data ³  25/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório de Processamento da Capitalização do Custo       º±±
±±º          ³ de Empréstimo                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR470()
Local oReport	:= Nil
Local cPerg		:= "AFR470"

Local lContinua	:= .T.
Local lTReport	:= FindFunction("TRepInUse") .and. TRepInUse()
Local lTopConn 	:= IiF(FindFunction("IfDefTopCTB"),IfDefTopCTB(),.F.)

Private cAliasAvp	:= GetNextAlias()


// Verifique as tabelas auxiliares existem
If !AliasInDic( "FN1" ) .OR. !AliasInDic( "FN2" ) .OR. !AliasInDic( "FN3" ) .OR. !AliasInDic( "FN4" ) .OR. !AliasInDic( "FN5" ) 
	Help( " ", 1, "AF480NaoTab",, STR0025, 1, 0 )  //"As tabelas FN1, FN2, FN3 e FN4 são fundamentais para execucao da rotina nao estão atualizadas no ambiente. Por favor executar a ultima versão do Atualizador UPDATF."
	Return
EndIf

If !lTReport
	Help("  ",1,"AFR470TR4",,OEMTOANSI(STR0001),1,0) // //"Função disponível apenas em TReport"
	lContinua := .F.
EndIf
If !lTopConn
	Help("  ",1,"AFR470TOP",,OEMTOANSI(STR0002),1,0) // //"Rotina disponível apenas para ambientes TopConnect"
	lContinua := .F.
EndIf

If lContinua
	oReport:= ReportDef(cPerg)
	oReport:PrintDialog()
EndIf 

Return Nil
/*

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Carlos A. Gomes Jr. º Data ³  06/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(cPerg)

Local oReport,oSectionT,oSectionD
Local oSectionM1,oSectionM2,oSectionM3,oSectionM4,oSectionM5

Local cNomeSec := ""

Local cReport := "ATFR470"
Local cTitulo := STR0003 // //"Processamento do Custo de Empréstimo"
Local cDescri := STR0004 // //"Este programa ir  emitir as informacoes dos processos de capitalizacao dos custos de emprestimo conforme os parametros

oReport  := TReport():New( cReport, cTitulo, "AFR470" , { |oReport| ATFR470Imp( oReport, cPerg ) }, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao Dados do Processo                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionP := TRSection():New( oReport, STR0005 )  //"Dados do Processo"
TRCell():New( oSectionP, "FN1_FILIAL" , "FN1" ,/*X3Titulo*/,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionP, "FN1_PROC"   , "FN1" ,/*X3Titulo*/,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionP, "FN1_DATA"   , "FN1" ,/*X3Titulo*/,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionP, "FN1_DESC"   , "FN1" ,/*X3Titulo*/,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionP, "FN1_STATUS" , "FN1" ,/*X3Titulo*/,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)
oSectionP:SetPageBreak(.T.)
//oSectionP:SetHeaderBreak()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao Dados dos Financiamentos              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionF := TRSection():New( oSectionP, STR0006 )  //"Dados dos Financiamentos"
TRCell():New( oSectionF, "FN2_LINHA"  , "FN2" ,/*X3Titulo*/,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionF, "FN2_IDCONT" , "FN2" ,/*X3Titulo*/,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionF, "FN2_DESC"   , "FN2" ,/*X3Titulo*/,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionF, "FN2_VLRCON" , "FN2" ,STR0012,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionF, "FN2_VLRSAL" , "FN2" ,STR0013,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionF, "FN2_JURCOM" , "FN2" ,STR0014,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
//oSectionF:SetHeaderBreak(.T.)
//oSectionF:SetHeaderSection(.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao Dados das Transaçoes                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionT := TRSection():New( oSectionP, STR0007 )  //"Dados das Transaçoes"
TRCell():New( oSectionT, "FN3_LINHA"  , "FN3" ,/*X3Titulo*/,/*Picture*/, ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "FN3_CBASE"  , "FN3" ,STR0027,/*Picture*/,            ,/*lPixel*/,/*{|| code-block de impressao }*/)//"Código Base Custo Transação"
TRCell():New( oSectionT, "FN3_ITEM"   , "FN3" ,STR0028,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Item Custo Transação"
TRCell():New( oSectionT, "FN3_TIPO"   , "FN3" ,STR0029 ,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Tipo Custo Transação"
TRCell():New( oSectionT, "FN3_TPSALD" , "FN3" ,STR0030,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Tipo de Saldo Custo Transação"
TRCell():New( oSectionT, "FN3_AMORT"  , "FN3" ,STR0016,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Valor da Amortização"
//oSectionT:SetHeaderBreak(.T.)
//oSectionT:SetHeaderSection(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao Dados dos Rendimentos                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionR := TRSection():New( oSectionP, STR0008 )  //"Dados dos Rendimentos"
TRCell():New( oSectionR, "FN4_LINHA"  , "FN4" ,/*X3Titulo*/,/*Picture*/, ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionR, "FN4_DESC"   , "FN4" ,STR0032,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Descrição do Rendimento"
TRCell():New( oSectionR, "FN4_VALOR"  , "FN4" ,STR0033,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Valor do Rendimento"
///oSectionR:SetHeaderBreak(.T.)
///oSectionR:SetHeaderSection(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao Custo dos Emprestimos                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionC := TRSection():New( oSectionP, STR0009 )  //"Custos dos Empréstimos"
TRCell():New( oSectionC, "FN5_LINHA"  , "FN5" ,/*X3Titulo*/,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionC, "FN5_CBAORI" , "FN5" ,STR0034,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Código Base Origem"
TRCell():New( oSectionC, "FN5_ITEORI" , "FN5" ,STR0035,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Item Origem"
TRCell():New( oSectionC, "N1_DESCRIC" , "SN1" ,/*X3Titulo*/,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//,,.T.,,,,.T.) 
TRCell():New( oSectionC, "FN5_VLRORI" , "FN5" ,STR0040,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//
TRCell():New( oSectionC, "FN5_CBACEM" , "FN5" ,STR0036,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Código Base Custo Empréstimo"
TRCell():New( oSectionC, "FN5_ITECEM" , "FN5" ,STR0037,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Item Custo Empréstimo"
TRCell():New( oSectionC, "FN5_TXCAP"  , "FN5" ,STR0038,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Taxa de Capitalização"
TRCell():New( oSectionC, "FN5_VLRAPR" , "FN5" ,STR0026,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)//"Valor de Apropriação"
//oSectionC:SetHeaderBreak(.T.)
//oSectionC:SetHeaderSection(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao Total Processo                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionTP := TRSection():New( oSectionP, STR0010 )  //"Total Processo"
TRCell():New( oSectionTP, "cProcesso"  , "" ,STR0011   ,"@!",20,/*lPixel*/,/*{|| code-block de impressao }*/) // //"Total do Processo"
TRCell():New( oSectionTP, "nValContPr" , "" ,STR0012   ,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Vlr Contrato"
TRCell():New( oSectionTP, "nSldContPr" , "" ,STR0013   ,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Sld Contrato"
TRCell():New( oSectionTP, "nJurCompPr" , "" ,STR0014,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //    //"Juros Comp"
TRCell():New( oSectionTP, "nVlAmortPr" , "" ,STR0016,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //    //"Amortização"   
TRCell():New( oSectionTP, "nVlRendiPr" , "" ,STR0033,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //    //"Rendimento"   
TRCell():New( oSectionTP, "nVlOrigPr"  , "" ,STR0040,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //    "Aquisic Orig"    
TRCell():New( oSectionTP, "nVlAproptPr", "",STR0026,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //     //"Apropriação"   

//oSectionTP:SetHeaderBreak(.T.)
//oSectionTP:SetHeaderSection(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao Total Filial                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionTF := TRSection():New( oReport, STR0017 )// //"Total Filial"
TRCell():New( oSectionTF, "nFilProc"   , "" ,STR0018   ,"@!",20,/*lPixel*/,/*{|| code-block de impressao }*/) // //"Total da Filial"
TRCell():New( oSectionTF, "nValContFl" , "" ,STR0012   ,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Valor do Contrato"
TRCell():New( oSectionTF, "nSldContFl" , "" ,STR0013   ,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Saldo do Contrato"
TRCell():New( oSectionTF, "nJurCompFl" , "" ,STR0014,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Juros da Competencia"
TRCell():New( oSectionTF, "nVlAmortFl" , "" ,STR0016,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Valor da Amortização"   
TRCell():New( oSectionTF, "nVlRendiFl" , "" ,STR0033,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //""Valor do Rendimento"   
TRCell():New( oSectionTF, "nVlOrigFl"  , "" ,STR0040,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // "Valor de Aquisição Origem"   
TRCell():New( oSectionTF, "nVlAproptFl", "",STR0026,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Valor da Apropriação"   

//oSectionTF:SetHeaderBreak(.T.)
//oSectionTF:SetHeaderSection(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao Total Geral                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionTG := TRSection():New( oReport, STR0019 )  // //"Total Geral"
TRCell():New( oSectionTG, "    "       , "" ,STR0019   ,"@!",20,/*lPixel*/,/*{|| code-block de impressao }*/) // //"Total Geral"
TRCell():New( oSectionTG, "nValContGr" , "" ,STR0012   ,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Valor do Contrato"
TRCell():New( oSectionTG, "nSldContGr" , "" ,STR0013   ,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Saldo do Contrato"
TRCell():New( oSectionTG, "nJurCompGr" , "" ,STR0014,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Juros da Competencia"
TRCell():New( oSectionTG, "nVlAmortGr" , "" ,STR0016,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Valor da Amortização"   
TRCell():New( oSectionTG, "nVlRendiGr" , "" ,STR0033,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //""Valor do Rendimento"   
TRCell():New( oSectionTG, "nVlOrigGr"  , "" ,STR0040,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //  "Valor de Aquisição Origem"    
TRCell():New( oSectionTG, "nVlAproptGr", "",STR0026,"@E 999,999,999,999,999.99",23,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // //"Valor da Apropriação"   


oReport:SetLandScape()
oReport:DisableOrientation()

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR470ImpºAutor  ³Alexandre Circenis  º Data ³  25/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFR470Imp( oReport, cPerg )
Local oSecFN1     := oReport:Section(1)
Local oSecFN2     := oReport:Section(1):Section(1)
Local oSecFN3     := oReport:Section(1):Section(2)
Local oSecFN4     := oReport:Section(1):Section(3)
Local oSecFN5     := oReport:Section(1):Section(4)
Local oSecTotPrc  := oReport:Section(1):Section(5)
Local oSecTotFil  := oReport:Section(2)
Local oSecTotGer  := oReport:Section(3)


Local cProcDe		:= ""
Local cProcAte		:= ""
Local dDataDe		:= CToD("")
Local dDataAte		:= CToD("")
Local nSeleFil  	:= 2
Local nTotFil   	:= 2
Local nTotProc  	:= 2
Local cQlSaldo		:= ""
Local nImprime		:= 0
Local nSelFili		:= 0
Local cSelFili		:= ""
Local cCondFil		:= ""
Local cWhereAux		:= ""
Local aTotProc      := {"",0,0,0,0,0,0,0}
Local aTotFilial    := {"",0,0,0,0,0,0,0}
Local aTotGeral     := {"",0,0,0,0,0,0,0}
Local oBreak

Private aSelFil   := {cFilAnt} 

Pergunte( cPerg , .F. )

cProcDe     := MV_PAR01
cProcAte    := MV_PAR02
dDataDe     := MV_PAR03
dDataAte    := MV_PAR04
nSeleFil    := MV_PAR05
nTotProc    := MV_PAR06
nTotFil     := MV_PAR07
nSelStatus  := MV_PAR08


If nSeleFil == 1
	aSelFil := AdmGetFil()
    If Len( aSelFil ) <= 0
         Return
    EndIf
EndIf
//Tratamento filial
cWhereAux += " FN1_FILIAL " + GetRngFil( aSelfil , "FN1" )

If nSelStatus == 1
	cWhereAux += " AND FN1_STATUS = '1' "
ElseIf nSelStatus == 2
	cWhereAux += " AND FN1_STATUS = '2' " 
EndIf 

cWhereAux := "%" + cWhereAux + "%"

BEGIN REPORT QUERY oSecFN1

	BeginSql alias cAliasAvp

		SELECT	FN1_FILIAL ,FN1_PROC, FN1_DATA, FN1_DESC, FN1_STATUS
		
		FROM %table:FN1% FNF 

		WHERE 	FN1_PROC >= %Exp:cProcDe% AND FN1_PROC <= %Exp:cProcAte%
				AND FN1_DATA >= %Exp:DTOS(dDataDe)% AND FN1_DATA <= %Exp:DTOS(dDataAte)%
				AND %Exp:cWhereAux%
				AND %notDel%

		ORDER BY FN1_FILIAL ,FN1_PROC, FN1_DATA, FN1_DESC, FN1_STATUS

	EndSql

END REPORT QUERY oSecFN1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posicionamento das tabelas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aTotFilial[1] := (cAliasAvp)->FN1_FILIAL
aTotProc[1]   := (cAliasAvp)->FN1_PROC

While !oReport:Cancel() .And. !(cAliasAvp)->(Eof())

	aTotProc      := {"",0,0,0,0,0,0,0} // Zerar o totalizador do processo ao iniciar a impressão
   	oSecFN1:Init()                          
	oSecFN1:Cell("FN1_FILIAL"):SetValue((cAliasAvp)->FN1_FILIAL)
	oSecFN1:Cell("FN1_PROC"):SetValue((cAliasAvp)->FN1_PROC)
	oSecFN1:Cell("FN1_DATA"):SetValue((cAliasAvp)->FN1_DATA)
	oSecFN1:Cell("FN1_DESC"):SetValue((cAliasAvp)->FN1_DESC)
	oSecFN1:Cell("FN1_STATUS"):SetValue(X3COMBO('FN1_STATUS',(cAliasAvp)->FN1_STATUS))

	//Impressao da Section 1
	oSecFN1:PrintLine()
	oReport:IncMeter()  
	
	dbSelectArea("FN2")
	dbSetOrder(1)
	dbSeek((cAliasAvp)->(FN1_FILIAL+FN1_PROC))
	oSecFN2:Init()
	while !FN2->(Eof()) .and. (cAliasAvp)->(FN1_FILIAL+FN1_PROC) = FN2->(FN2_FILIAL+FN2_PROC)
		oSecFN2:Cell("FN2_LINHA"):SetValue(FN2->FN2_LINHA)
		oSecFN2:Cell("FN2_IDCONT"):SetValue(FN2->FN2_IDCONT)
		oSecFN2:Cell("FN2_DESC"):SetValue(FN2->FN2_DESC)
		oSecFN2:Cell("FN2_VLRCON"):SetValue(FN2->FN2_VLRCON)
		oSecFN2:Cell("FN2_VLRSAL"):SetValue(FN2->FN2_VLRSAL)
		oSecFN2:Cell("FN2_JURCOM"):SetValue(FN2->FN2_JURCOM)
		aTotProc[2] += FN2->FN2_VLRCON
		aTotProc[3] += FN2->FN2_VLRSAL
		aTotProc[4] += FN2->FN2_JURCOM
		oSecFN2:PrintLine()
		FN2->(dbSkip())
	enddo
	oSecFN2:Finish()
	oReport:IncMeter()  

	dbSelectArea("FN3")
	dbSetOrder(1)
	dbSeek((cAliasAvp)->(FN1_FILIAL+FN1_PROC))
	oSecFN3:Init()
	while !FN3->(Eof()) .and. (cAliasAvp)->(FN1_FILIAL+FN1_PROC) = FN3->(FN3_FILIAL+FN3_PROC)
		If FN3->FN3_AMORT > 0
			oSecFN3:Cell("FN3_LINHA"):SetValue(FN3->FN3_LINHA)
			oSecFN3:Cell("FN3_CBASE"):SetValue(FN3->FN3_CBASE)
			oSecFN3:Cell("FN3_ITEM"):SetValue(FN3->FN3_ITEM)
			oSecFN3:Cell("FN3_TIPO"):SetValue(FN3->FN3_TIPO)
			oSecFN3:Cell("FN3_TPSALD"):SetValue(X3COMBO('N3_TPSALD',FN3->FN3_TPSALD))
			oSecFN3:Cell("FN3_AMORT"):SetValue(FN3->FN3_AMORT)
			aTotProc[5] += FN3->FN3_AMORT
			oSecFN3:PrintLine()
		EndIf
		FN3->(dbSkip())
	enddo
	oSecFN3:Finish()
	oReport:IncMeter()  

	dbSelectArea("FN4")
	dbSetOrder(1)
	dbSeek((cAliasAvp)->(FN1_FILIAL+FN1_PROC))
	oSecFN4:Init()
	while !FN4->(Eof()) .and. (cAliasAvp)->(FN1_FILIAL+FN1_PROC) = FN4->(FN4_FILIAL+FN4_PROC)
		If FN4->FN4_VALOR > 0 
			oSecFN4:Cell("FN4_LINHA"):SetValue(FN4->FN4_LINHA)
			oSecFN4:Cell("FN4_DESC"):SetValue(FN4->FN4_DESC)
			oSecFN4:Cell("FN4_VALOR"):SetValue(FN4->FN4_VALOR)
			aTotProc[6] += FN4->FN4_VALOR
			oSecFN4:PrintLine()
		EndIf
		FN4->(dbSkip())
	enddo
	oSecFN4:Finish()
	oReport:IncMeter()  

	dbSelectArea("FN5")
	dbSetOrder(1)
	dbSeek((cAliasAvp)->(FN1_FILIAL+FN1_PROC))
	oSecFN5:Init()
	while !FN5->(Eof()) .and. (cAliasAvp)->(FN1_FILIAL+FN1_PROC) = FN5->(FN5_FILIAL+FN5_PROC)
		oSecFN5:Cell("FN5_LINHA"):SetValue(FN5->FN5_LINHA)
		oSecFN5:Cell("FN5_CBAORI"):SetValue(FN5->FN5_CBAORI)
		oSecFN5:Cell("FN5_ITEORI"):SetValue(FN5->FN5_ITEORI)
		oSecFN5:Cell("N1_DESCRIC"):SetValue(GetAdvFval("SN1","N1_DESCRIC",xFilial("SN1") + FN5->FN5_CBAORI + FN5->FN5_ITEORI  ,1,""))
		oSecFN5:Cell("FN5_VLRORI"):SetValue(FN5->FN5_VLRORI)
		oSecFN5:Cell("FN5_CBACEM"):SetValue(FN5->FN5_CBACEM)
		oSecFN5:Cell("FN5_ITECEM"):SetValue(FN5->FN5_ITECEM)
		oSecFN5:Cell("FN5_TXCAP"):SetValue(FN5->FN5_TXCAP)
		oSecFN5:Cell("FN5_VLRAPR"):SetValue(FN5->FN5_VLRAPR)
		aTotProc[7]+= FN5->FN5_VLRORI
		aTotProc[8]+= FN5->FN5_VLRAPR
		oSecFN5:PrintLine()
		FN5->(dbSkip())
	enddo
	oSecFN5:Finish()
	oReport:IncMeter()  
 
if nTotFil == 1
	oSecTotFil:Init()
endif 
	if nTotProc == 1
	   	oSecTotPrc:Init()
		oSecTotPrc:Cell("nValContPr" ):SetValue(aTotProc[2])
		oSecTotPrc:Cell("nSldContPr" ):SetValue(aTotProc[3])
		oSecTotPrc:Cell("nJurCompPr" ):SetValue(aTotProc[4])
		oSecTotPrc:Cell("nVlAmortPr" ):SetValue(aTotProc[5])
		oSecTotPrc:Cell("nVlRendiPr" ):SetValue(aTotProc[6])
		oSecTotPrc:Cell("nVlOrigPr"  ):SetValue(aTotProc[7])
		oSecTotPrc:Cell("nVlAproptPr" ):SetValue(aTotProc[8])
		oSecTotPrc:PrintLine()                 
		oSecTotPrc:Finish()
	EndIf
	
	// Total Geral
	aTotFilial[2] += aTotProc[2]
	aTotFilial[3] += aTotProc[3]
	aTotFilial[4] += aTotProc[4]
	aTotFilial[5] += aTotProc[5]
	aTotFilial[6] += aTotProc[6]
	aTotFilial[7] += aTotProc[7]
	aTotFilial[8] += aTotProc[8]


	// Total Geral
	aTotGeral[2] += aTotProc[2]
	aTotGeral[3] += aTotProc[3]
	aTotGeral[4] += aTotProc[4]
	aTotGeral[5] += aTotProc[5]
	aTotGeral[6] += aTotProc[6]
	aTotGeral[7] += aTotProc[7]
	aTotGeral[8] += aTotProc[8]


	(cAliasAvp)->(dbSkip())
	
 	if (cAliasAvp)->(Eof()) .or. aTotFilial[1] <> (cAliasAvp)->FN1_FILIAL
		// Total Filial
		If nTotFil == 1
	   		oSecTotFil:Init()                                   
			oSecTotFil:Cell("nFilProc"   ):SetValue(aTotFilial[1])
			oSecTotFil:Cell("nValContFl" ):SetValue(aTotFilial[2])
			oSecTotFil:Cell("nSldContFl" ):SetValue(aTotFilial[3])
			oSecTotFil:Cell("nJurCompFl" ):SetValue(aTotFilial[4])
			oSecTotFil:Cell("nVlAmortFl" ):SetValue(aTotFilial[5])
			oSecTotFil:Cell("nVlRendiFl" ):SetValue(aTotFilial[6])
			oSecTotFil:Cell("nVlOrigFl"  ):SetValue(aTotFilial[7])
			oSecTotFil:Cell("nVlAproptFl" ):SetValue(aTotFilial[8])
			oSecTotFil:PrintLine() 
			oSecTotFil:Finish()
		EndIf                                          
		aTotFilial:= {(cAliasAvp)->FN1_FILIAL,0,0,0,0,0,0,0}
	endif	 
	
	oReport:SkipLine()

	// Total Geral
	If (cAliasAvp)->(Eof())
		oSecTotGer:Init()
		oSecTotGer:Cell("nValContGr" ):SetValue(aTotGeral[2])
		oSecTotGer:Cell("nSldContGr" ):SetValue(aTotGeral[3])
		oSecTotGer:Cell("nJurCompGr" ):SetValue(aTotGeral[4])
		oSecTotGer:Cell("nVlAmortGr" ):SetValue(aTotGeral[5])
		oSecTotGer:Cell("nVlRendiGr" ):SetValue(aTotGeral[6])
		oSecTotGer:Cell("nVlOrigGr"  ):SetValue(aTotGeral[7])
		oSecTotGer:Cell("nVlAproptGr" ):SetValue(aTotGeral[8])
		oSecTotGer:PrintLine()
		oSecTotGer:Finish()
	EndIf
	oSecFN1:Finish()
		 
Enddo


(cAliasAvp)->(DbCloseArea())

Return
