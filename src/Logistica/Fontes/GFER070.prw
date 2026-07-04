/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFER070.ch"
/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER070
Relatório de Faturas de Frete
    
@sample
U_GFER070()

@author Fabiane Schulze
@since 07/06/2010
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER070()
	Local oReport  := Nil  //objeto que contém o relatório
	
	If TRepInUse() // teste padrão 
		//-- Interface de impressão
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf  
Return
/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Relatório de Documentos de Frete

@sample
ReportDef()

@author Fabiane Schulze
@since 07/06/2010
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
	Local oReport   := Nil
	Local oSection1 := Nil
	Local oSection2 := Nil
	Local oSection3 := Nil
	Local oSection4 := Nil
	Local aOrdem    := {}
	
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
	
	oReport:= TReport():New("GFER070",STR0002,"GFER070", {|oReport| ReportPrint(oReport)},STR0003)  //"Faturas de Frete"###"Emite Faturas de Frete conforme os parâmetros informados."
	oReport:SetLandscape()   // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	Pergunte("GFER070",.F.)
	
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
	
	
	Aadd( aOrdem, STR0004 ) // "Sequência" //"Codigo"
	
	oSection1 := TRSection():New(oReport,STR0002,{"(cAliasQry)","GW6"},aOrdem)  //"Faturas de Frete"
	oSection1:SetLineStyle() //Define a impressao da secao em linha
	oSection1:SetTotalInLine(.F.)
	
	TRCell():New(oSection1," cFilEmit "	,""	,"Filial"			,/*Picture*/,		02		,/*lPixel*/,{||cFilEmit})
	TRCell():New(oSection1," cNumEmit "	,""	,"Emissor"			,/*Picture*/,		14		,/*lPixel*/,{||cNumEmit})
	TRCell():New(oSection1," cNomeEmit "	,""	,"Nome"			,/*Picture*/,		50		,/*lPixel*/,{||cNomeEmit})
	TRCell():New(oSection1," cSerFat "		,""	,"Série"			,/*Picture*/,		05		,/*lPixel*/,{||cSerFat})
	TRCell():New(oSection1," cNrFat "		,""	,"Nr. Fat"			,/*Picture*/,		16		,/*lPixel*/,{||cNrFat})
	TRCell():New(oSection1," cDTEMIS "		,""	,"Data Emissão"	,/*Picture*/,		10		,/*lPixel*/,{||cDTEMIS})
	TRCell():New(oSection1," cVLFATU "		,""	,"Vl Fatura"		,"@E 999,999.99",	10		,/*lPixel*/,{||cVLFATU})
	TRCell():New(oSection1," cVLDESC "		,""	,"Vl Desconto"	,"@E 999,999.99",	10		,/*lPixel*/,{||cVLDESC})
	TRCell():New(oSection1," cVLISS  "		,""	,"ISS "			,"@E 999,999.99",	10		,/*lPixel*/,{||cVLISS })
	TRCell():New(oSection1," cVLICMS "		,""	,"ICMS"			,"@E 999,999.99",	10		,/*lPixel*/,{||cVLICMS})
	TRCell():New(oSection1," cVLICRE "		,""	,"ICMS Ret"		,"@E 999,999.99",	10		,/*lPixel*/,{||cVLICRE})
	TRCell():New(oSection1," cVLJURO "		,""	,"Juros"			,"@E 999,999.99",	10		,/*lPixel*/,{||cVLJURO})
	TRCell():New(oSection1," cDTCRIA "		,""	,"Data Criação"	,/*Picture*/,		10		,/*lPixel*/,{||cDTCRIA})
	TRCell():New(oSection1," cDTVENC "		,""	,"Data Venc"		,/*Picture*/,		10		,/*lPixel*/,{||cDTVENC})
	TRCell():New(oSection1," cORIGEM "		,""	,"Origem"			,/*Picture*/,		10		,/*lPixel*/,{||cORIGEM})
	TRCell():New(oSection1," cDTBLOQ "		,""	,"Dt Desbloqueio"	,/*Picture*/,		08		,/*lPixel*/,{||cDTBLOQ})
	TRCell():New(oSection1," cUSUBLO "		,""	,"Usuário"			,/*Picture*/,		50		,/*lPixel*/,{||cUSUBLO})
	TRCell():New(oSection1," cMotBloq "	,""	,"Motivo Bloq"	,/*Picture*/,		50		,/*lPixel*/,{||cMotBloq})
	TRCell():New(oSection1," cSITAPR " 		,""	,"Sit Aprovação"	,/*Picture*/,		50		,/*lPixel*/,{||cSITAPR})
	TRCell():New(oSection1," cDTAPR  " 		,""	,"Data Aprov"		,/*Picture*/,		10		,/*lPixel*/,{||cDTAPR })
	TRCell():New(oSection1," cUSUAPR " 		,""	,"Usuario Aprov"	,/*Picture*/,		50		,/*lPixel*/,{||cUSUAPR})
	TRCell():New(oSection1," cMotDBlo "	,""	,"Motivo Desbl"	,/*Picture*/,		50		,/*lPixel*/,{||cMotDBlo})
	TRCell():New(oSection1," cSITFIN " 		,""	,"Sit Financeiro"	,/*Picture*/,		10		,/*lPixel*/,{||cSITFIN})
	TRCell():New(oSection1," cDTFIN  " 		,""	,"Data Finan"		,/*Picture*/,		10		,/*lPixel*/,{||cDTFIN})
	TRCell():New(oSection1," cUSUFIN " 		,""	,"Usuário Finan"	,/*Picture*/,		50		,/*lPixel*/,{||cUSUFIN})
	TRCell():New(oSection1," cObs "			,""	,"Obsrvação"		,/*Picture*/,		50		,/*lPixel*/,{||cObs})
	
	/***************************************************************************/
	
	oSection2 := TRSection():New(oSection1,STR0005,{"GW3","GU3"},aOrdem) //  //"Documentos de Frete"
	oSection2:SetTotalInLine(.F.)
	oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection2,"GW3_CDESP" ,"GW3",,/*cTitle*/,/*Picture*/,/*Tamanho*//*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW3_EMISDF","GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW3_SERDF" ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW3_NRDF"  ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW3_DTEMIS","GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW3_CDREM" ,"GW3",STR0016,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Rem"
	TRCell():New(oSection2,"GW3_CDDEST","GW3",STR0017,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW3_TPDF"  ,"GW3",/*cTitle*/,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW3_VLDF"  ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW3_FRPESO","GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW3_FRVAL" ,"GW3" ,/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW3_TAXAS" ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

	oSection3 := TRSection():New(oSection1,STR0006,{"GWJ"},aOrdem) //  //"Pré-Faturas de Frete"
	oSection3:SetTotalInLine(.F.)
	oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection3,"GWJ_NRPF"  ,"GWJ",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GWJ_CDTRP" ,"GWJ",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GWJ_SIT"   ,"GWJ",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GWJ_DTVCTO","GWJ",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GWJ_DTIMPL","GWJ",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GWJ_USUIMP","GWJ",/*cTitle*/,/*Picture*/,40,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GWJ_DTAPR" ,"GWJ",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GWJ_DTENV" ,"GWJ",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GWJ_DTCANC","GWJ",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	oSection4 := TRSection():New(oSection1,STR0007,{"(cAliConf)"},aOrdem)  //"Conferência"
	oSection4:SetTotalInLine(.F.)
	oSection4:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection4,"(cAliConf)->DTINFORM","(cAliConf)",STR0008,,08,/*lPixel*/,/*{|| code-block de impressao }*/)   //"Data Venc Inform"
	TRCell():New(oSection4,"(cAliConf)->DTCALC"  ,"(cAliConf)",STR0009,,10,/*lPixel*/,/*{|| code-block de impressao }*/) //"Data Venc Calc"
	TRCell():New(oSection4,"(cAliConf)->VLFATURA","(cAliConf)",STR0010,"@E 999,999,999.99"	,14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Vl Fatura"
	TRCell():New(oSection4,"(cAliConf)->VLDOCTO" ,"(cAliConf)","Vl Dctos Frete    ","@E 999,999,999.99"	,14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Vl Dctos Frete"
	TRCell():New(oSection4,"(cAliConf)->VLVARDF" ,"(cAliConf)","Variação    ","@E 999,999,999.99"	,14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Variação"
	TRCell():New(oSection4,"(cAliConf)->VLPREFAT","(cAliConf)",STR0013,"@E 999,999,999.99"	,14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Vl Pré-faturas"
	TRCell():New(oSection4,"(cAliConf)->VLVARPF" ,"(cAliConf)",STR0012,"@E 999,999,999.99"	,14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Variação"
	TRCell():New(oSection4,"(cAliConf)->VLCALC"  ,"(cAliConf)",STR0014,"@E 999,999,999.99"	,14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Vl Cálculo"
	TRCell():New(oSection4,"(cAliConf)->DIFEREN" ,"(cAliConf)",STR0015,"@E 999,999,999.99"	,14,/*lPixel*/,/*{|| code-block de impressao }*/)        
	
	oSection5 := TRSection():New(oSection1,"Rateio Contábil",{"GW7"},aOrdem)  //"Conferência"
	oSection5:SetTotalInLine(.F.)
	oSection5:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection5,"GW7_SEQ"   ,"GW7",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"GW7_CTACTB","GW7",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"GW7_CCUSTO","GW7",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"GW7_LANCTO","GW7",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"GW7_TRANS" ,"GW7",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
Return(oReport)
/*************************************************************************************************************************************/   
/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportPrint
Relatório de Faturas de Frete
Generico.

@sample
ReportPrint(oReport,cAliasQry)

@author Fabiane Schulze
@since 07/06/2010                              
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportPrint(oReport)
	Local lVLDocF     := .T.
	Local lMV_PAR14   := !Empty(MV_PAR14)
	Local aArea       := GetArea()
	Local aAreaGW3    := GW3->(GetArea())
	Local aAreaGWJ    := GWJ->(GetArea())
	Local aAreaGWF    := GWF->(GetArea())
	Local aAreaGW6    := GW6->(GetArea())
	Local aAreaGW7    := GW7->(GetArea())
	Local oSection1   := Nil
	Local oSection2   := Nil
	Local oSection3   := Nil
	Local oSection4   := Nil
	Local oSection5   := Nil
	Local cUserFilter := ""
	Local cNrCalc     := ""
	Local cFilialIni  := MV_PAR01
	Local cFilialFim  := MV_PAR02
	Local cTranspIni  := MV_PAR07
	Local cTranspFim  := MV_PAR08
	Local cSerieIni   := MV_PAR03
	Local cSerieFim   := MV_PAR04
	Local cNumeroIni  := MV_PAR05
	Local cNumeroFim  := MV_PAR06
	Local cAliasQry   := Nil
	Local cAliasGW3   := Nil
	Local cAliasGWJ   := Nil
	Local cAliasGW4   := Nil
	Local cAliasGWF   := Nil
	Local cAliasGW7   := Nil
	Local cSit        := ""
	Local nVLPFat     := 0  
	Local nVLDFret    := 0
	Local nVlImpDF    := 0
	Local nVLDocF     := 0
	Local nI          := 0
	Local dDtVencM    := Date()
	Local dDtVencM1   := Date()
	Local dDtVencC    := Date()
	Local dDtEmisIni  := MV_PAR09
	Local dDtEmisFim  := MV_PAR10
	Local dDtCriaIni  := MV_PAR11
	Local dDtCriaFim  := MV_PAR12
	Local aConf       := {}

	Private cNomeEmit := ""
	Private cMotBloq  := ""
	Private cMotDBlo  := ""
	Private cObs      := ""
	Private cFilEmit  := ""
	Private cNumEmit  := ""
	Private cSerFat   := ""
	Private cNrFat    := ""
	Private cDTEMIS   := ""
	Private cVLFATU   := ""
	Private cVLDESC   := ""
	Private cVLISS    := ""
	Private cVLICMS   := ""
	Private cVLICRE   := ""
	Private cVLJURO   := ""
	Private cDTCRIA   := ""
	Private cDTVENC   := ""
	Private cORIGEM   := ""
	Private cDTBLOQ   := ""
	Private cUSUBLO   := ""
	Private cSITAPR   := ""
	Private cDTAPR    := ""
	Private cUSUAPR   := ""
	Private cSITFIN   := ""
	Private cDTFIN    := ""
	Private cUSUFIN   := ""
	Private cAliConf := ""

	oSection1   := oReport:Section(1)
	oSection2   := oReport:Section(1):Section(1)
	oSection3   := oReport:Section(1):Section(2)
	oSection4   := oReport:Section(1):Section(3) 
	oSection5   := oReport:Section(1):Section(4) 


	aConf :=   {{"DTINFORM","D",08,0},;
				{"DTCALC"  ,"D",08,0},;
				{"VLFATURA","N",TamSx3("GW6_VLFATU")[1],2},;
				{"VLDOCTO" ,"N",TamSx3("GW6_VLFATU")[1],2},;
				{"VLVARDF" ,"N",TamSx3("GW6_VLFATU")[1],2},;
				{"VLPREFAT","N",TamSx3("GW6_VLFATU")[1],2},;
				{"VLVARPF" ,"N",TamSx3("GW6_VLFATU")[1],2},;
				{"VLCALC"  ,"N",TamSx3("GW6_VLFATU")[1],2},;
				{"DIFEREN" ,"N",TamSx3("GW6_VLFATU")[1],2}}	

	cAliConf := GFECriaTab({ aConf,{"DTINFORM"} })
	
	oReport:SetMeter(GW6->(LastRec()))
	//Secção 1
	oSection1:Init()
	
	cUserFilter := ""
	If ValType(oSection1:aUserFilter) == "A"
		For nI := 1 To Len(oSection1:aUserFilter)
			If oSection1:aUserFilter[nI][1] == "GW6"
				If !Empty(cUserFilter)
					cUserFilter := " AND " + cUserFilter
				EndIf
				cUserFilter += oSection1:aUserFilter[nI][3]
			EndIf
		Next
	EndIf
	
	GFEConout("INFO",cUserFilter)

	cQuery := " SELECT GW6.GW6_FILIAL,"
	cQuery +=        " GW6.GW6_EMIFAT," 
	cQuery +=        " GW6.GW6_SERFAT," 
	cQuery +=        " GW6.GW6_NRFAT," 
	cQuery +=        " GW6.GW6_DTEMIS," 
	cQuery +=        " GW6.GW6_VLFATU," 
	cQuery +=        " GW6.GW6_VLDESC," 
	cQuery +=        " GW6.GW6_VLICMS," 
	cQuery +=        " GW6.GW6_VLICRE," 
	cQuery +=        " GW6.GW6_VLISS," 
	cQuery +=        " GW6.GW6_VLJURO," 
	cQuery +=        " GW6.GW6_DTCRIA,"
	cQuery +=        " GW6.GW6_DTVENC," 
	cQuery +=        " GW6.GW6_ORIGEM," 
	cQuery +=        " GW6.GW6_DTBLOQ," 
	cQuery +=        " GW6.GW6_USUBLO," 
	cQuery +=        " GW6.GW6_SITAPR,"
	cQuery +=        " GW6.GW6_DTAPR," 
	cQuery +=        " GW6.GW6_USUAPR," 
	cQuery +=        " GW6.GW6_SITFIN," 
	cQuery +=        " GW6.GW6_DTFIN," 
	cQuery +=        " GW6.GW6_HRFIN," 
	cQuery +=        " GW6.GW6_USUFIN," 
	cQuery +=        " GW6.GW6_VLISRE,"
	cQuery +=        " GU3.GU3_NMEMIT,"
	cQuery +=        " GW6.R_E_C_N_O_ RECNOGW6"
	cQuery +=   " FROM "+RetSQLName("GW6")+" GW6"
	cQuery +=  " INNER JOIN "+RetSqlName("GU3")+" GU3"
	cQuery +=     " ON GU3.GU3_FILIAL = '"+ xFilial("GU3") + "'"
	cQuery +=    " AND GU3.GU3_CDEMIT = GW6.GW6_EMIFAT"
	cQuery +=    " AND GU3.GU3_SIT = '1'"
	cQuery +=    " AND GU3.D_E_L_E_T_ = ' '"
	cQuery +=  " WHERE GW6.GW6_FILIAL >= '" + cFilialIni + "'"
	cQuery +=    " AND GW6.GW6_FILIAL <= '" + cFilialFim + "'"
	cQuery +=    " AND GW6.GW6_SERFAT >= '" + cSerieIni + "'"
	cQuery +=    " AND GW6.GW6_SERFAT <= '" + cSerieFim + "'"
	cQuery +=    " AND GW6.GW6_NRFAT >= '" + cNumeroIni + "'"
	cQuery +=    " AND GW6.GW6_NRFAT <= '" + cNumeroFim + "'"
	cQuery +=    " AND GW6.GW6_EMIFAT >= '" + cTranspIni + "'"
	cQuery +=    " AND GW6.GW6_EMIFAT <= '" + cTranspFim + "'"
	cQuery +=    " AND GW6.GW6_DTEMIS >= '" + DTOS(dDtEmisIni) + "'"
	cQuery +=    " AND GW6.GW6_DTEMIS <= '" + DTOS(dDtEmisFim) + "'"
	cQuery +=    " AND GW6.GW6_DTCRIA >= '" + DTOS(dDtCriaIni) + "'"
	cQuery +=    " AND GW6.GW6_DTCRIA <= '" + DTOS(dDtCriaFim) + "'"

	If !Empty(cUserFilter)
		cQuery += " AND (" + cUserFilter + ") "
	EndIf

	// Situação
	If !lMV_PAR14
		If MV_PAR13 == 1
			cQuery += " AND GW6_SITAPR = '1'"
		ElseIf MV_PAR13 == 2
			cQuery += " AND GW6_SITAPR = '2'"
		ElseIf MV_PAR13 == 3
			cQuery += " AND GW6_SITAPR = '3'"
		ElseIf MV_PAR13 == 4  
			cQuery += " AND GW6_SITAPR = '4'"
		EndIf
	Else
		If MV_PAR13 == 1
			cQuery += " AND GW6_SITAPR = '1'"
		ElseIf MV_PAR13 == 2
			cQuery += " AND GW6_SITAPR = '2'"
		ElseIf MV_PAR13 == 3
			cQuery += " AND GW6_SITAPR IN ('3','4')"
		EndIf
	EndIf

	// Situação fiscal
	If lMV_PAR14
		If MV_PAR14 == 1
			cQuery += " AND GW6.GW6_SITFIN = '4'"
		ElseIf MV_PAR14 == 2
			cQuery += " AND GW6.GW6_SITFIN <> '4'"
		EndIf
	EndIf
	cQuery += " AND GW6.D_E_L_E_T_ =  ' '"
	cQuery := ChangeQuery(cQuery)
	cAliasQry := GetNextAlias()
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasQry, .F., .T.)
	
	Do While !oReport:Cancel() .And. (cAliasQry)->(!Eof())
		
		oReport:IncMeter()
	
		cFilEmit   := (cAliasQry)->GW6_FILIAL
		cNumEmit   := (cAliasQry)->GW6_EMIFAT
		cNomeEmit  := (cAliasQry)->GU3_NMEMIT
		cSerFat    := (cAliasQry)->GW6_SERFAT
		cNrFat     := (cAliasQry)->GW6_NRFAT
		cDTEMIS    := STOD((cAliasQry)->GW6_DTEMIS)
		cVLFATU    := (cAliasQry)->GW6_VLFATU
		cVLDESC    := (cAliasQry)->GW6_VLDESC
		cVLISS     := (cAliasQry)->GW6_VLISS
		cVLICMS    := (cAliasQry)->GW6_VLICMS
		cVLICRE    := (cAliasQry)->GW6_VLICRE
		cVLJURO    := (cAliasQry)->GW6_VLJURO
		cDTCRIA    := STOD((cAliasQry)->GW6_DTCRIA)
		cDTVENC    := STOD((cAliasQry)->GW6_DTVENC)
		lVLDocF    := .T.
	
		//1=EDI;2=Usuario;3=Sistema
		cOrigem1   := (cAliasQry)->GW6_ORIGEM
		If cOrigem1 == '1'
			cORIGEM := "EDI"
		elseIf  cOrigem1 =='2'
			cORIGEM := "Usuario"
		else
			cORIGEM := "Sistema"
		Endif
	
		cDTBLOQ := STOD((cAliasQry)->GW6_DTBLOQ)
		cUSUBLO := (cAliasQry)->GW6_USUBLO  
		
		//1=Recebida;2=Bloqueada;3=Aprovada Sistema;4=Aprovada Usuario
		cSit:= (cAliasQry)->GW6_SITAPR
		If cSit == '1'
			cSITAPR := "Recebida"
		elseIf cSit =='2'
			cSITAPR := "Bloqueada"
		elseIf cSit =='3'
			cSITAPR := "Aprovada Sistema"
		else
			cSITAPR	:= "Aprovada Usuario"
		Endif
	
		cDTAPR  := STOD((cAliasQry)->GW6_DTAPR)
		cUSUAPR := (cAliasQry)->GW6_USUAPR
	 
		//1=Nao Enviada;2=Pendente;3=Rejeitada;4=Atualizada;5=Pendente Desatualizacao                                                     
		cSitf :=(cAliasQry)->GW6_SITFIN
		If cSitf =='1'
			cSITFIN := "Nao Enviada"
		elseIf cSitf =='2'
			cSITFIN := "Pendente"
		elseIf cSitf =='3'
			cSITFIN := "Rejeitada"
		elseIf cSitf =='4'
			cSITFIN := "Atualizada"
		else
			cSITFIN := "Pendente Desatualizacao"
		Endif
	
		cDTFIN   := STOD((cAliasQry)->GW6_DTFIN)
		cUSUFIN  := (cAliasQry)->GW6_USUFIN
		cMotBloq := ""
		cMotDBlo := ""
		cObs     := ""
		
		If !Empty((cAliasQry)->RECNOGW6)
			GW6->(dbGoTo((cAliasQry)->RECNOGW6)) //-- Posiciona para pegar campos memo
		
			cMotBloq := GW6->GW6_MOTBLO
			cMotDBlo := GW6->GW6_MOTDES
			cObs     := GW6->GW6_OBS
		EndIf

		oSection1:PrintLine()
		//Secção 2  
		oSection2:Init()
		
		cAliasGW3 := GetNextAlias()
		BeginSql Alias cAliasGW3
			SELECT GW3.R_E_C_N_O_ RECNOGW3,
					GW3.GW3_VLDF
			FROM %Table:GW3% GW3
			WHERE GW3.GW3_FILFAT = %Exp:(cAliasQry)->GW6_FILIAL%
			AND GW3.GW3_EMIFAT = %Exp:(cAliasQry)->GW6_EMIFAT%
			AND GW3.GW3_SERFAT = %Exp:(cAliasQry)->GW6_SERFAT%
			AND GW3.GW3_NRFAT = %Exp:(cAliasQry)->GW6_NRFAT%
			AND GW3.GW3_DTEMFA = %Exp:(cAliasQry)->GW6_DTEMIS%
			AND GW3.%NotDel%
		EndSql
		Do While (cAliasGW3)->(!Eof())
			GW3->(dbGoTo((cAliasGW3)->RECNOGW3))
			nVLDFret   := nVLDFret + GW3->GW3_VLDF // valor documento de frete
			oSection2:PrintLine() 
				
			(cAliasGW3)->(dbSkip())
		EndDo 
		(cAliasGW3)->(dbCloseArea())
		oSection2:Finish()
		
		//Secção 3  
		oSection3:Init()
		cAliasGWJ := GetNextAlias()
		BeginSql Alias cAliasGWJ
			SELECT GWJ.R_E_C_N_O_ RECNOGWJ
			FROM %Table:GWJ% GWJ 
			WHERE GWJ.GWJ_FILFAT = %Exp:(cAliasQry)->GW6_FILIAL%
			AND GWJ.GWJ_EMIFAT = %Exp:(cAliasQry)->GW6_EMIFAT%
			AND GWJ.GWJ_SERFAT = %Exp:(cAliasQry)->GW6_SERFAT%
			AND GWJ.GWJ_NRFAT = %Exp:(cAliasQry)->GW6_NRFAT%
			AND GWJ.GWJ_DTEMFA = %Exp:(cAliasQry)->GW6_DTEMIS%
			AND GWJ.%NotDel%
		EndSql
		Do While (cAliasGWJ)->(!Eof())
			GWJ->(dbGoTo((cAliasGWJ)->RECNOGWJ))
			oSection3:PrintLine()
			(cAliasGWJ)->(dbSkip())
		EndDo
		(cAliasGWJ)->(dbCloseArea())
		oSection3:Finish()
	
		//Secção 4
		oSection4:Init()
	
		dbSelectArea(cAliConf)
		dbSetOrder(01)
		dbGoTop()
		
		cAliasGWJ := GetNextAlias()
		BeginSql Alias cAliasGWJ
			SELECT GWJ.GWJ_NRPF,
					GWJ.GWJ_CDTRP, 
					GWJ.GWJ_SIT,
					GWJ.GWJ_DTVCTO,
					GWJ.GWJ_DTIMPL,
					GWJ.GWJ_USUIMP,
					GWJ.GWJ_DTAPR, 
					GWJ.GWJ_DTENV, 
					GWJ.GWJ_DTCANC
			FROM %Table:GWJ% GWJ 
			WHERE GWJ.GWJ_FILFAT = %Exp:(cAliasQry)->GW6_FILIAL%
			AND GWJ.GWJ_EMIFAT = %Exp:(cAliasQry)->GW6_EMIFAT%
			AND GWJ.GWJ_SERFAT = %Exp:(cAliasQry)->GW6_SERFAT%
			AND GWJ.GWJ_NRFAT = %Exp:(cAliasQry)->GW6_NRFAT%
			AND GWJ.GWJ_DTEMFA = %Exp:(cAliasQry)->GW6_DTEMIS%
			AND GWJ.%NotDel%
		EndSql
		//Caso existam pré-faturas relacionadas à fatura, a data de vencimento da fatura deve ser 
		// igual ou posterior à menor das datas de vencimento das pré-faturas, caso contrário deve ser bloqueada.
		If (cAliasGWJ)->(!Eof())
			Do While (cAliasGWJ)->(!Eof())
				If Empty(dDtVencM)
					dDtVencM  := GWJ->GWJ_DTVCTO
					dDtVencM1 := GWJ->GWJ_DTVCTO // Data Venc inform
				ElseIf dDtVencM > GWJ->GWJ_DTVCTO
					dDtVencM  := GWJ->GWJ_DTVCTO
					dDtVencM1 := GWJ->GWJ_DTVCTO 
				EndIf
				(cAliasGWJ)->(dbSkip())
			EndDo
		Else
			dDtVencM1 := STOD((cAliasQry)->GW6_DTVENC)
			dDtVencC  := GFECalcVc(STOD((cAliasQry)->GW6_DTEMIS),(cAliasQry)->GW6_EMIFAT)
		EndIf
		(cAliasGWJ)->(dbcloseArea())

		nVlImpDF := 0
		nVLDFret := 0
		nVLDocF  := 0
		
		cAliasGW3 := GetNextAlias()
		BeginSql Alias cAliasGW3
			SELECT GW3.GW3_VLDF,
					GW3.GW3_VLIMP,
					GW3.GW3_FILIAL,
					GW3.GW3_EMISDF,
					GW3.GW3_CDESP,
					GW3.GW3_SERDF,
					GW3.GW3_NRDF,
					GW3.GW3_DTEMIS,
					GW3.GW3_TPDF
			FROM %Table:GW3% GW3
			WHERE GW3.GW3_FILFAT = %Exp:(cAliasQry)->GW6_FILIAL%
			AND GW3.GW3_EMIFAT = %Exp:(cAliasQry)->GW6_EMIFAT%
			AND GW3.GW3_SERFAT = %Exp:(cAliasQry)->GW6_SERFAT%
			AND GW3.GW3_NRFAT = %Exp:(cAliasQry)->GW6_NRFAT%
			AND GW3.GW3_DTEMFA = %Exp:(cAliasQry)->GW6_DTEMIS%
			AND GW3.%NotDel%
		EndSql
		Do While (cAliasGW3)->(!Eof())
			nVLDFret += (cAliasGW3)->GW3_VLDF
			nVlImpDF += (cAliasGW3)->GW3_VLIMP
			
			cAliasGW4 := GetNextAlias()
			BeginSql Alias cAliasGW4
				SELECT GWH.GWH_FILIAL,
						GWH.GWH_NRCALC,
						GW4.GW4_NRDF
				FROM %Table:GW4% GW4
				INNER JOIN %Table:GWH% GWH
				ON GWH.GWH_FILIAL = GW4.GW4_FILIAL
				AND GWH.GWH_CDTPDC = GW4.GW4_TPDC
				AND GWH.GWH_EMISDC = GW4.GW4_EMISDC
				AND GWH.GWH_SERDC = GW4.GW4_SERDC
				AND GWH.GWH_NRDC = GW4.GW4_NRDC
				AND GWH.%NotDel%
				WHERE GW4.GW4_FILIAL = %Exp:(cAliasGW3)->GW3_FILIAL%
				AND GW4.GW4_EMISDF = %Exp:(cAliasGW3)->GW3_EMISDF%
				AND GW4.GW4_CDESP = %Exp:(cAliasGW3)->GW3_CDESP%
				AND GW4.GW4_SERDF = %Exp:(cAliasGW3)->GW3_SERDF%
				AND GW4.GW4_NRDF = %Exp:(cAliasGW3)->GW3_NRDF%
				AND GW4.GW4_DTEMIS = %Exp:(cAliasGW3)->GW3_DTEMIS%
				AND GW4.%NotDel%
			EndSql
			Do While (cAliasGW4)->(!Eof())
				If !((cAliasGW4)->GWH_NRCALC == cNrCalc) .And. (cAliasGW3)->GW3_NRDF == (cAliasGW4)->GW4_NRDF
					lVLDocF := .T.
				Endif

				cAliasGWF := GetNextAlias()
				BeginSql Alias cAliasGWF
					SELECT GWF.R_E_C_N_O_ RECNOGWF
					FROM %Table:GWF% GWF
					WHERE GWF.GWF_FILIAL = %Exp:(cAliasGW4)->GWH_FILIAL%
					AND GWF.GWF_NRCALC = %Exp:(cAliasGW4)->GWH_NRCALC%
					AND GWF.GWF_TPCALC = %Exp:(cAliasGW3)->GW3_TPDF%
					AND GWF.GWF_TPCALC <> '8'
					AND GWF.%NotDel%
				EndSql
				If (cAliasGWF)->(!Eof()) .And. !(cNrCalc == (cAliasGW4)->GWH_NRCALC) .And. lVLDocF
					GWF->(dbGoTo((cAliasGWF)->RECNOGWF))
					nVLDocF += VLTOTFRET()
					cNrCalc := (cAliasGW4)->GWH_NRCALC
				EndIf
				(cAliasGWF)->(dbCloseArea())
				lVLDocF := .F.

				(cAliasGW4)->(dbSkip())
			EndDo
			(cAliasGW4)->(dbCloseArea())
			(cAliasGW3)->(dbSkip())
		EndDo
		(cAliasGW3)->(dbCloseArea())
		
		nVLPFat := 0
		cAliasGWJ := GetNextAlias()
		BeginSql Alias cAliasGWJ
			SELECT GWF.R_E_C_N_O_ RECNOGWF
			FROM %Table:GWJ% GWJ
			INNER JOIN %Table:GWF% GWF
			ON GWF.GWF_FILPRE = GWJ.GWJ_FILIAL
			AND GWF.GWF_NRPREF = GWJ.GWJ_NRPF
			AND GWF.%NotDel%
			WHERE GWJ.GWJ_FILFAT = %Exp:(cAliasQry)->GW6_FILIAL%
			AND GWJ.GWJ_EMIFAT = %Exp:(cAliasQry)->GW6_EMIFAT%
			AND GWJ.GWJ_SERFAT = %Exp:(cAliasQry)->GW6_SERFAT%
			AND GWJ.GWJ_NRFAT = %Exp:(cAliasQry)->GW6_NRFAT%
			AND GWJ.GWJ_DTEMFA = %Exp:(cAliasQry)->GW6_DTEMIS%
			AND GWJ.%NotDel%
		EndSql
		Do While (cAliasGWJ)->(!Eof())
			GWF->(dbGoTo((cAliasGWJ)->RECNOGWF))
			nVLPFat += VLTOTFRET()  //- valor pré-fatura
			
			(cAliasGWJ)->( dbSkip() )
		EndDo
		(cAliasGWJ)->(dbCloseArea())

		nVlFat := (cAliasQry)->GW6_VLFATU //valor total da fatura  - valor fatura
		
		dbSelectArea(cAliConf)
		ZAP
		
		RecLock((cAliConf),.T.)
		(cAliConf)->DTINFORM := dDtVencM1
		
		If !(Empty((cAliasQry)->GW6_DTVENC))
			(cAliConf)->DTCALC := STOD((cAliasQry)->GW6_DTVENC)
		Else
			(cAliConf)->DTCALC := dDtVencC
		EndIf
		
		(cAliConf)->DTCALC   := dDtVencC
		(cAliConf)->VLFATURA := (cAliasQry)->GW6_VLFATU
		(cAliConf)->VLDOCTO  := nVLDFret
		(cAliConf)->VLVARDF  := (nVlFat-nVLDFret)
		(cAliConf)->VLPREFAT := nVLPFat
		(cAliConf)->VLVARPF  := (nVlFat-nVLPFat)
		(cAliConf)->VLCALC   := nVLDocF
		(cAliConf)->DIFEREN  :=	(nVLDFret-nVLDocF)
	
		(cAliConf)->(MsUnLock())
			
		oSection4:PrintLine()
		oSection4:Finish()

		//Secção 5
		cAliasGW7 := GetNextAlias()
		BeginSql Alias cAliasGW7
			SELECT GW7.R_E_C_N_O_ RECNOGW7
			FROM %Table:GW7% GW7
			WHERE GW7.GW7_FILIAL = %Exp:(cAliasQry)->GW6_FILIAL%
			AND GW7.GW7_EMIFAT = %Exp:(cAliasQry)->GW6_EMIFAT%
			AND GW7.GW7_SERFAT = %Exp:(cAliasQry)->GW6_SERFAT%
			AND GW7.GW7_NRFAT = %Exp:(cAliasQry)->GW6_NRFAT%
			AND GW7.GW7_DTEMIS = %Exp:(cAliasQry)->GW6_DTEMIS%
			AND GW7.%NotDel%
		EndSql
		If (cAliasGW7)->(!Eof())
			oSection5:Init()
			oReport:PrintText("Rateio Contábil",,300) /*Imprime o identificador dos Rateio Contábil*/
			Do While !oReport:Cancel() .And. (cAliasGW7)->(!Eof())
				GW7->(dbGoTo((cAliasGW7)->RECNOGW7))
				oSection5:PrintLine()
				(cAliasGW7)->(dbSkip())
			EndDo
			oSection5:Finish()
		EndIf 
		(cAliasGW7)->(dbCloseArea())
		(cAliasQry)->(dbSkip())
		oReport:Skipline()
	End
	oSection1:Finish()
	(cAliasQry)->(dbCloseArea())
	
	GFEDelTab(cAliConf) 
	
	RestArea(aArea)
	RestArea(aAreaGW3)
	RestArea(aAreaGWJ)
	RestArea(aAreaGWF)
	RestArea(aAreaGW6)
	RestArea(aAreaGW7)
Return
