/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFER065.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE QTVOL 1
#DEFINE PESOR 2
#DEFINE PESOC 3
#DEFINE VOLUM 4
#DEFINE VALDC 5
#DEFINE FRTUN 6
#DEFINE FRTVL 7
#DEFINE TAXAS 8
#DEFINE VLPED 9
#DEFINE VLTOT 10
#DEFINE ALQTA 11
#DEFINE VLIMP 12

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER065
Relatório de Documentos de Frete

@sample
U_GFER065()

@author Fabiane Schulze
@since 21/05/2010
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER065()
	Local oReport := Nil // Objeto que contém o relatório

	Private cAliasGW3  := ""
	Private cAliasGWA  := ""
	Private aConferen  := {}
	Private nInd       := 1
	Private aAuxTaxas  := {}
	Private nTxInd     := 0

	If TRepInUse() // teste padrão
		Pergunte("GFER065", .F.)
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
	@since 21/05/2010
	@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
	Local oReport, oSection1, oSection2, oSection3, oSection4, oSection5
	Local aBoxSCtb := RetSx3Box(Posicione('SX3',2,'GWA_SITCTB','X3CBox()'),,,1)

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
	oReport:= TReport():New("GFER065",STR0002,"GFER065", {|oReport| ReportPrint(oReport)},STR0003)  //"Documentos de Frete"###"Emite Conhecimentos de Frete conforme os parâmetros informados."
	oReport:SetLandscape()   // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	oReport:SetColSpace(2,.F.)

	//Pergunte("GFER065",.F.)
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

	oSection1 := TRSection():New(oReport,STR0002,{"GW3"})  //"Documentos de Frete"
	oSection1:SetLineStyle() //Define a impressao da secao em linha
	oSection1:SetTotalInLine(.F.)
	TRCell():New(oSection1,"GW3_FILIAL"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_FILIAL})
	TRCell():New(oSection1,"GW3_CDESP"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_CDESP})
	TRCell():New(oSection1,"GW3_EMISDF"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_EMISDF})
	TRCell():New(oSection1,"EMISSOR"      ,"GW3",STR0005   ,"@!"       ,50         ,/*lPixel*/, {|| (cAliasGW3)->EMISSOR}) // Nome Emis.
	TRCell():New(oSection1,"GW3_SERDF"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_SERDF})
	TRCell():New(oSection1,"GW3_NRDF"     ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_NRDF})
	TRCell():New(oSection1,"GW3_DTEMIS"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_DTEMIS})
	TRCell():New(oSection1,"GW3_CDREM"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_CDREM})
	TRCell():New(oSection1,"REMETENTE"    ,"GW3",STR0006   ,"@!"       ,50         ,/*lPixel*/, {|| (cAliasGW3)->REMETENTE}) // Nome Remet.
	TRCell():New(oSection1,"GW3_CDDEST"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_CDDEST})
	TRCell():New(oSection1,"DESTINATARIO" ,"GW3",STR0007   ,"@!"       ,50         ,/*lPixel*/, {|| (cAliasGW3)->DESTINATARIO}) // Nome Dest.
	TRCell():New(oSection1,"GW3_TPDF"     ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {||GetStrCbox(GetSx3Inf("GW3_TPDF")[2],AllTrim((cAliasGW3)->GW3_TPDF))})
	TRCell():New(oSection1,"GW3_DTENT"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_DTENT})
	TRCell():New(oSection1,"GW3_CFOP"     ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_CFOP})
	TRCell():New(oSection1,"GW3_SIT"      ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {||GetStrCbox(GetSx3Inf("GW3_SIT")[2],AllTrim((cAliasGW3)->GW3_SIT))})
	TRCell():New(oSection1,"GW3_QTVOL"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_QTVOL})
	TRCell():New(oSection1,"GW3_PESOR"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_PESOR})
	TRCell():New(oSection1,"GW3_VLCARG"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_VLCARG})
	TRCell():New(oSection1,"GW3_VOLUM"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_VOLUM})
	TRCell():New(oSection1,"GW3_PESOC"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_PESOC})
	TRCell():New(oSection1,"GW3_QTDCS"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_QTDCS})
	TRCell():New(oSection1,"GW3_FRPESO"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_FRPESO})
	TRCell():New(oSection1,"GW3_FRVAL"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_FRVAL})
	TRCell():New(oSection1,"GW3_TAXAS"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_TAXAS})
	TRCell():New(oSection1,"GW3_PEDAG"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_PEDAG})
	TRCell():New(oSection1,"GW3_PDGFRT"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {||GetStrCbox(GetSx3Inf("GW3_PDGFRT")[2],AllTrim((cAliasGW3)->GW3_PDGFRT))})
	TRCell():New(oSection1,"GW3_ICMPDG"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {||GetStrCbox(GetSx3Inf("GW3_ICMPDG")[2],AllTrim((cAliasGW3)->GW3_ICMPDG))})
	TRCell():New(oSection1,"GW3_PDGPIS"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {||GetStrCbox(GetSx3Inf("GW3_PDGPIS")[2],AllTrim((cAliasGW3)->GW3_PDGPIS))})
	TRCell():New(oSection1,"GW3_VLDF"     ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_VLDF})
	TRCell():New(oSection1,"GW3_TRBIMP"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {||GetStrCbox(GetSx3Inf("GW3_TRBIMP")[2],AllTrim((cAliasGW3)->GW3_TRBIMP))})
	TRCell():New(oSection1,"GW3_PCIMP"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_PCIMP})
	TRCell():New(oSection1,"GW3_BASIMP"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_BASIMP})
	TRCell():New(oSection1,"GW3_VLIMP"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_VLIMP})

	If GFXCP2510("GW3_PCIBS") .And. GFXCP2510("GW3_BASIBS") .And. GFXCP2510("GW3_VLIBS")
		TRCell():New(oSection1,"GW3_PCIBS"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_PCIBS})
		TRCell():New(oSection1,"GW3_BASIBS"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_BASIBS})
		TRCell():New(oSection1,"GW3_VLIBS"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_VLIBS})
	EndIf
	
	TRCell():New(oSection1,"GW3_DTBLQ"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_DTBLQ})
	TRCell():New(oSection1,"GW3_MOTBLQ"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| GW3->GW3_MOTBLQ})
	TRCell():New(oSection1,"GW3_USUBLQ"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_USUBLQ})
	TRCell():New(oSection1,"GW3_DTAPR"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_DTAPR})
	TRCell():New(oSection1,"GW3_MOTAPR"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| GW3->GW3_MOTAPR})
	TRCell():New(oSection1,"GW3_USUAPR"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_USUAPR})
	TRCell():New(oSection1,"GW3_EMIFAT"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_EMIFAT})
	TRCell():New(oSection1,"GW3_SERFAT"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_SERFAT})
	TRCell():New(oSection1,"GW3_NRFAT"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_NRFAT})
	TRCell():New(oSection1,"GW3_DTEMFA"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_DTEMFA})
	TRCell():New(oSection1,"GW3_FILFAT"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_FILFAT})
	TRCell():New(oSection1,"GW3_CDCONS"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_CDCONS})
	TRCell():New(oSection1,"CONSIGNATARIO","GW3",STR0008   ,"@!"       ,50         ,/*lPixel*/, {|| (cAliasGW3)->CONSIGNATARIO}) // Nome Cons.
	TRCell():New(oSection1,"GW3_ORINR"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_ORINR})
	TRCell():New(oSection1,"GW3_SITFIS"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {||GetStrCbox(GetSx3Inf("GW3_SITFIS")[2],AllTrim((cAliasGW3)->GW3_SITFIS))})
	TRCell():New(oSection1,"GW3_DTFIS"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_DTFIS})
	TRCell():New(oSection1,"GW3_SITREC"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {||GetStrCbox(GetSx3Inf("GW3_SITREC")[2],AllTrim((cAliasGW3)->GW3_SITREC))})
	TRCell():New(oSection1,"GW3_DTREC"    ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_DTREC})
	TRCell():New(oSection1,"GW3_USUIMP"   ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW3_USUIMP})
	TRCell():New(oSection1,"GW3_OBS"      ,"GW3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| GW3->GW3_OBS})
	/***************************************************************************/

	oSection2 := TRSection():New(oReport,STR0009,{"GW1"}) //  //"Documentos de Carga"
	oSection2:SetTotalInLine(.F.)
	oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection2,"GW1_EMISDC","GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW1_EMISDC})
	TRCell():New(oSection2,"EMISSORDC" ,"GW1",STR0005   ,"@!"       , 50        ,/*lPixel*/, {|| (cAliasGW3)->EMISSORDC}) // Nome Emis.
	TRCell():New(oSection2,"GW1_CDTPDC","GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW1_CDTPDC})
	TRCell():New(oSection2,"GW1_NRDC"  ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW1_NRDC})
	TRCell():New(oSection2,"GW1_SERDC" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW1_SERDC})
	TRCell():New(oSection2,"GW1_DTEMIS","GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW1_DTEMIS})
	TRCell():New(oSection2,"GW1_CDREM" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW1_CDREM})
	TRCell():New(oSection2,"GW1_CDDEST","GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasGW3)->GW1_CDDEST})
	/*************************************************************************************************************************************/
	oSection3 := TRSection():New(oReport,STR0010) // //"Conferência"
	oSection3:SetTotalInLine(.F.)
	oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection3,"CAMPO"  ,,STR0011,"@!"                  ,20,/*lPixel*/,{|| aConferen[nInd,1] }) //"Campo"
	TRCell():New(oSection3,"VALOR1" ,,STR0034,"@E 999,999,999.99999",14,/*lPixel*/,{|| aConferen[nInd,2] }) //"Informado"
	TRCell():New(oSection3,"VALOR2" ,,STR0012,"@E 999,999,999.99999",14,/*lPixel*/,{|| aConferen[nInd,3] }) //"Calculado"
	TRCell():New(oSection3,"DIFEREN",,STR0013,"@E 999,999,999.99999",14,/*lPixel*/,{|| aConferen[nInd,2] - aConferen[nInd,3] }) //"Diferença"
	/**************************************************************************/

	oSection4 := TRSection():New(oReport,STR0014,{"GWA"})  //"Grade Contábil"
	oSection4:SetTotalInLine(.F.)
	oSection4:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection4,"GWA_FILIAL","GWA","Filial Doc."  ,/*Picture*/        ,/*Tamanho*/,/*lPixel*/,{|| (cAliasGWA)->GWA_FILIAL })
	TRCell():New(oSection4,"GWA_NRDOC" ,"GWA","Nr Doc. Frete",/*Picture*/        ,/*Tamanho*/,/*lPixel*/,{|| (cAliasGWA)->GWA_NRDOC  })
	TRCell():New(oSection4,"GWA_CDESP" ,"GWA","Especie Doc." ,/*Picture*/        ,/*Tamanho*/,/*lPixel*/,{|| (cAliasGWA)->GWA_CDESP  })
	TRCell():New(oSection4,"GWA_CDEMIT","GWA","Emissor Doc." ,/*Picture*/        ,/*Tamanho*/,/*lPixel*/,{|| (cAliasGWA)->GWA_CDEMIT })
	TRCell():New(oSection4,"GWA_SERIE" ,"GWA","Serie Doc."   ,/*Picture*/        ,/*Tamanho*/,/*lPixel*/,{|| (cAliasGWA)->GWA_SERIE  })
	TRCell():New(oSection4,"GWA_DTMOV" ,"GWA",STR0015        ,/*Picture*/        ,10		 ,/*lPixel*/,{|| (cAliasGWA)->GWA_DTMOV  }) //"Data Mov"
	TRCell():New(oSection4,"GWA_CDTRAN","GWA",STR0016        ,"@!"               ,10         ,/*lPixel*/,{|| (cAliasGWA)->GWA_CDTRAN }) //"Transação"
	TRCell():New(oSection4,"GWA_CTACRE","GWA",STR0017        ,"@!"               ,20         ,/*lPixel*/,{|| (cAliasGWA)->GWA_CTACRE }) //"Conta Crédito"
	TRCell():New(oSection4,"GWA_CTADEB","GWA",STR0018        ,"@!"               ,20         ,/*lPixel*/,{|| (cAliasGWA)->GWA_CTADEB }) //"Conta Débito"
	TRCell():New(oSection4,"GWA_VLMOV" ,"GWA",STR0019        ,"@E 999,999,999.99",16         ,/*lPixel*/,{|| (cAliasGWA)->GWA_VLMOV  }) //"Valor Movimento"
	TRCell():New(oSection4,"GWA_SITCTB","GWA",STR0021        ,"@!"               ,15         ,/*lPixel*/,{|| aBoxSCtb[Val((cAliasGWA)->GWA_SITCTB),3] }) //"Enviado ERP"
	TRCell():New(oSection4,"GWA_DSHIST","GWA",STR0035        ,"@!"               ,250        ,/*lPixel*/,{|| (cAliasGWA)->GWA_DSHIST }) //"Histórico"
	/**************************************************************************/

	oSection5 := TRSection():New(oReport,"TAXAS") // Descrição das Taxas
	oSection5:SetTotalInLine(.F.)
	oSection5:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection5,"TXDESC",,"Taxas","@!"                       ,20,/*lPixel*/,{|| aAuxTaxas[nTxInd,1] })  //"Campo"
	TRCell():New(oSection5,"TXVLR1",,"Informado","@E 999,999,999.99999" ,14,/*lPixel*/,{|| aAuxTaxas[nTxInd,2] })  //"Informado"
	TRCell():New(oSection5,"TXVLR2" ,,"Calculado","@E 999,999,999.99999",14,/*lPixel*/,{|| aAuxTaxas[nTxInd,3]})   //"Calculado"
	TRCell():New(oSection5,"DIFEREN",,"Diferença","@E 999,999,999.99999",14,/*lPixel*/,{|| aAuxTaxas[nTxInd,2] -  aAuxTaxas[nTxInd,3]}) //"Diferença"

Return oReport
/*************************************************************************************************************************************/

/*/--------------------------------------------------------------------------------------------------
	{Protheus.doc} ReportPrint
	Relatório de Documentos de Frete
	Generico.

	@sample
	ReportPrint(oReport,cAliasQry)

	@author  Guilherme A. Metzger
	@since   21/04/2016
	@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportPrint(oReport)
	Local oSection1  := oReport:Section(1)
	Local oSection2  := oReport:Section(2)
	Local oSection3  := oReport:Section(3)
	Local oSection4  := oReport:Section(4)
	Local oSection5  := oReport:Section(5)
	Local cExpFil    := MntExpFil(oReport:GetGCList())
	Local cExpSit    := MntExpSit()
	Local cExpTpDf   := MntExpTpDf()
	Local cQuery     := ""
	Local cAliasCof  := ""
	Local cAliasCal  := ""
	Local cOrder     := SqlOrder(GW3->(IndexKey(1))) + "," + SqlOrder(GW1->(IndexKey(1)))
	Local cFilDF     := ""
	Local cEspDF     := ""
	Local cEmiDF     := ""
	Local cSerDF     := ""
	Local cNumDF     := ""
	Local cDtEDF     := ""
	Local aCalcRel   := {}
	Local lFirstCalc := .T.
	Local lTrpNota   := SuperGetMV('MV_VLCNPJ',,'1') == "1" // 1 - Somente transportador da nota; 2 - Considera mesma raiz
	Local nI         := 1
	Local nRegs      := 0
	Local cComp      := "(cAliasGW3)->GW3_FILIAL+(cAliasGW3)->GW3_CDESP+(cAliasGW3)->GW3_EMISDF+(cAliasGW3)->GW3_SERDF+(cAliasGW3)->GW3_NRDF+DtoS((cAliasGW3)->GW3_DTEMIS)"
	Local aAreaGWA   := GWA->( GetArea() )
	Local nCod 		 := 0
	Local nITx       := 1
	Local cCpoGw3 	 := ""
	Local cCpoGWF 	 := ""

	cAliasGW3 := GetNextAlias()

	cExpFil := "%" + cExpFil + "%"

	cQuery := ""

	If !Empty(cExpSit)
		cQuery +=   " AND GW3_SIT"  + cExpSit
	EndIf
	If !Empty(cExpTpDf)
		cQuery +=   " AND GW3_TPDF" + cExpTpDf
	EndIf

	If len(oSection1:AUSERFILTER) > 0
		If oSection1:AUSERFILTER[1][3] <> ''
			/// Obtém o comando sql do filtro
			cFiltro := oSection1:GetSQLExp('GW3')
			cQuery += " AND (" + cFiltro + ")"
		EndIf
	EndIf
	cQuery += " ORDER BY " + cOrder

	cQuery := "%" + cQuery + "%"

	If GFXCP2510("GW3_BASIBS") .And. GFXCP2510("GW3_PCIBS") .And. GFXCP2510("GW3_VLIBS")
		cCpoGw3 := "GW3_BASIBS, GW3_PCIBS, GW3_VLIBS,"
	EndIf

	cCpoGw3 := "%" + cCpoGw3 + "%"

	BeginSQL Alias cAliasGW3
		SELECT GW3_FILIAL, 
			   GW3_CDESP,
			   GW3_EMISDF,
			   GW3_SERDF,
			   GW3_NRDF,
			   GW3_DTEMIS,
			   GW3_QTVOL,
			   GW3_PESOR,
			   GW3_PESOC,
			   GW3_VOLUM,
			   GW3_VLCARG,
			   GW3_FRPESO,
			   GW3_FRVAL,
			   GW3_TAXAS,
			   GW3_PEDAG,
			   GW3_VLDF,
			   GW3_BASIMP,
			   GW3_PCIMP,
			   GW3_VLIMP,
			   GW3_CDREM,
			   GW3_CDDEST,
			   GW3_TPDF,
			   GW3_DTENT,
			   GW3_CFOP,
			   GW3_SIT,
			   GW3_QTDCS,
			   GW3_PDGFRT,
			   GW3_ICMPDG,
			   GW3_PDGPIS,
			   GW3_TRBIMP,
			   GW3_DTBLQ,
			   GW3_USUBLQ,
			   GW3_DTAPR,
			   GW3_USUAPR,
			   GW3_EMIFAT,
			   GW3_SERFAT,
			   GW3_NRFAT,
			   GW3_DTEMFA,
			   GW3_FILFAT,
			   GW3_CDCONS,
			   GW3_ORINR,
			   GW3_SITFIS,
			   GW3_DTFIS,
			   GW3_SITREC,
			   GW3_DTREC,
			   GW3_USUIMP,
			   CASE WHEN GW3_ICMPDG = '' THEN '2' ELSE GW3_ICMPDG END GW3_ICMPDG,
			   GW1_FILIAL,
			   GW1_CDTPDC,
			   GW1_EMISDC,
			   GW1_SERDC,
			   GW1_NRDC,
			   GW1_DTEMIS,
			   GW1_CDREM,
			   GW1_CDDEST,
			   %Exp:cCpoGw3%
			   EMISSDF.GU3_NMEMIT EMISSOR,
			   REMET.GU3_NMEMIT REMETENTE,
			   DEST.GU3_NMEMIT DESTINATARIO,
			   CONS.GU3_NMEMIT CONSIGNATARIO,
			   EMISSDC.GU3_NMEMIT EMISSORDC,
			   GW3.R_E_C_N_O_ RECNOGW3,
			   GW1.R_E_C_N_O_ RECNOGW1
		FROM %Table:GW3% GW3
		LEFT JOIN %Table:GW4% GW4
		ON GW4_FILIAL = GW3_FILIAL
		AND GW4_EMISDF = GW3_EMISDF
		AND GW4_CDESP  = GW3_CDESP
		AND GW4_SERDF  = GW3_SERDF
		AND GW4_NRDF   = GW3_NRDF
		AND GW4_DTEMIS = GW3_DTEMIS
		AND GW4.%NotDel%
		LEFT JOIN %Table:GW1% GW1
		ON GW1_FILIAL = GW4_FILIAL
		AND GW1_CDTPDC = GW4_TPDC
		AND GW1_EMISDC = GW4_EMISDC
		AND GW1_SERDC  = GW4_SERDC
		AND GW1_NRDC   = GW4_NRDC
		AND GW1.%NotDel%
		INNER JOIN %Table:GU3% EMISSDF
		ON EMISSDF.GU3_FILIAL = %xFilial:GU3%
		AND EMISSDF.GU3_CDEMIT = GW3_EMISDF
		AND EMISSDF.%NotDel%
		LEFT JOIN %Table:GU3% REMET
		ON REMET.GU3_FILIAL = %xFilial:GU3%
		AND REMET.GU3_CDEMIT = GW3_CDREM
		AND REMET.%NotDel%
		LEFT JOIN %Table:GU3% DEST
		ON DEST.GU3_FILIAL = %xFilial:GU3%
		AND DEST.GU3_CDEMIT = GW3_CDDEST
		AND DEST.%NotDel%
		LEFT JOIN %Table:GU3% CONS
		ON CONS.GU3_FILIAL = %xFilial:GU3%
		AND CONS.GU3_CDEMIT = GW3_CDCONS
		AND CONS.%NotDel%
		LEFT JOIN %Table:GU3% EMISSDC
		ON EMISSDC.GU3_FILIAL = %xFilial:GU3%
		AND EMISSDC.GU3_CDEMIT = GW1_EMISDC
		AND EMISSDC.%NotDel%
		WHERE %Exp:cExpFil%
		GW3_CDESP  >= %Exp:MV_PAR01%
		AND GW3_CDESP  <= %Exp:MV_PAR02%
		AND GW3_EMISDF >= %Exp:MV_PAR07%
		AND GW3_EMISDF <= %Exp:MV_PAR08%
		AND GW3_SERDF  >= %Exp:MV_PAR03%
		AND GW3_SERDF  <= %Exp:MV_PAR04%
		AND GW3_NRDF   >= %Exp:MV_PAR05%
		AND GW3_NRDF   <= %Exp:MV_PAR06%
		AND GW3_DTEMIS >= %Exp:DtoS(MV_PAR09)%
		AND GW3_DTEMIS <= %Exp:DtoS(MV_PAR10)%
		AND GW3_DTENT  >= %Exp:DtoS(MV_PAR11)%
		AND GW3_DTENT  <= %Exp:DtoS(MV_PAR12)%
		AND GW3.%NotDel%
		%Exp:cQuery%
	EndSQL

	TcSetField(cAliasGW3,'GW3_DTEMIS','D',8,0)
	TcSetField(cAliasGW3,'GW3_DTENT' ,'D',8,0)
	TcSetField(cAliasGW3,'GW3_DTBLQ' ,'D',8,0)
	TcSetField(cAliasGW3,'GW3_DTAPR' ,'D',8,0)
	TcSetField(cAliasGW3,'GW3_DTEMFA','D',8,0)
	TcSetField(cAliasGW3,'GW3_DTFIS' ,'D',8,0)
	TcSetField(cAliasGW3,'GW3_DTREC' ,'D',8,0)
	TcSetField(cAliasGW3,'GW1_DTEMIS','D',8,0)

	(cAliasGW3)->(DbGoTop())

	oSection1:Init() // Início da seção 1

	While !oReport:Cancel() .And. !(cAliasGW3)->(Eof())
		GW3->(dbGoTo((cAliasGW3)->RECNOGW3))	//-- Posiciona para leitura dos campos memo
		GW1->(dbGoTo((cAliasGW3)->RECNOGW1))	//-- Posiciona para leitura correta de dados dos campos customizaveis

		oSection1:PrintLine() // Imprime as informações do documento de frete

		cFilDF := (cAliasGW3)->GW3_FILIAL
		cEspDF := (cAliasGW3)->GW3_CDESP
		cEmiDF := (cAliasGW3)->GW3_EMISDF
		cSerDF := (cAliasGW3)->GW3_SERDF
		cNumDF := (cAliasGW3)->GW3_NRDF
		cDtEDF := DtoS((cAliasGW3)->GW3_DTEMIS)

		aConferen := {{STR0022,(cAliasGW3)->GW3_QTVOL ,0},;
					  {STR0023,(cAliasGW3)->GW3_PESOR ,0},;
					  {STR0024,(cAliasGW3)->GW3_PESOC ,0},;
					  {STR0025,(cAliasGW3)->GW3_VOLUM ,0},;
					  {STR0026,(cAliasGW3)->GW3_VLCARG,0},;
					  {STR0027,(cAliasGW3)->GW3_FRPESO,0},;
					  {STR0028,(cAliasGW3)->GW3_FRVAL ,0},;
					  {STR0029,(cAliasGW3)->GW3_TAXAS ,0},;
					  {STR0030,(cAliasGW3)->GW3_PEDAG ,0},;
					  {STR0031,(cAliasGW3)->GW3_VLDF  ,0},;
					  {STR0032,(cAliasGW3)->GW3_PCIMP + Iif(GFXCP2510("GW3_PCIBS"), (cAliasGW3)->GW3_PCIBS, 0) ,0},;
					  {STR0033,(cAliasGW3)->GW3_VLIMP + Iif(GFXCP2510("GW3_VLIBS"), (cAliasGW3)->GW3_VLIBS, 0) ,0}}

		aCalcRel := {}

		oSection2:Init()

		// Como o SQL já traz os documentos de carga relacionados ao documento de frete,
		// neste momento imprime os doctos de carga e calcula os valores para os dados da
		// conferência. Faz isso enquanto existirem registros do mesmo documento de frete.
		While !oReport:Cancel() .And. !(cAliasGW3)->(Eof()) .And. cFilDF+cEspDF+cEmiDF+cSerDF+cNumDF+cDtEDF  == &cComp

			oSection2:PrintLine() // Imprime os documentos de carga relacionados ao documento de frete

			cAliasCof := GetNextAlias()

			cQuery := ""

			If Len(oSection2:AUSERFILTER) > 0
				If oSection2:AUSERFILTER[1][3] <> ''
					cQuery += " AND ( " + oSection2:AUSERFILTER[1][3] + " )"
				EndIf
			EndIf

			cQuery := "%" + cQuery + "%"

			BeginSQL Alias cAliasCof
				SELECT SUM(GWB_QTDE)   GWB_QTDE,
					   SUM(GUG_VOLUME) GUG_VOLUME,
					   SUM(GW8_PESOR)  GW8_PESOR,
					   SUM(GW8_PESOC)  GW8_PESOC,
					   SUM(GW8_VALOR)  GW8_VALOR,
					   SUM(GW8_QTDE)   GW8_QTDE,
					   SUM(GW8_VOLUME) GW8_VOLUME
				FROM %Table:GW1% GW1
				LEFT JOIN %Table:GWB% GWB
				ON GWB_FILIAL = GW1_FILIAL
				AND GWB_CDTPDC = GW1_CDTPDC
				AND GWB_EMISDC = GW1_EMISDC
				AND GWB_SERDC  = GW1_SERDC
				AND GWB_NRDC   = GW1_NRDC
				AND GWB.%NotDel%
				LEFT JOIN %Table:GUG% GUG
				ON GUG_FILIAL = ''
				AND GUG_CDUNIT = ''
				AND GUG.%NotDel%
				INNER JOIN %Table:GW8% GW8
				ON GW8_FILIAL = GW1_FILIAL
				AND GW8_CDTPDC = GW1_CDTPDC
				AND GW8_EMISDC = GW1_EMISDC
				AND GW8_SERDC  = GW1_SERDC
				AND GW8_NRDC   = GW1_NRDC
				AND GW8.%NotDel%
				WHERE GW1_FILIAL = %Exp:(cAliasGW3)->GW1_FILIAL%
				AND GW1_CDTPDC = %Exp:(cAliasGW3)->GW1_CDTPDC%
				AND GW1_EMISDC = %Exp:(cAliasGW3)->GW1_EMISDC%
				AND GW1_SERDC  = %Exp:(cAliasGW3)->GW1_SERDC%
				AND GW1_NRDC   = %Exp:(cAliasGW3)->GW1_NRDC%
				AND GW1.%NotDel%
				%Exp:cQuery%
			EndSQL

			If !(cAliasCof)->(Eof())
				aConferen[PESOR,3] += (cAliasCof)->GW8_PESOR
				aConferen[PESOC,3] += (cAliasCof)->GW8_PESOC
				aConferen[VALDC,3] += (cAliasCof)->GW8_VALOR

				If (cAliasCof)->GWB_QTDE > 0
					aConferen[QTVOL,3] += (cAliasCof)->GWB_QTDE
					aConferen[VOLUM,3] += (cAliasCof)->GUG_VOLUME * (cAliasCof)->GWB_QTDE
				Else
					aConferen[QTVOL,3] += (cAliasCof)->GW8_QTDE
					aConferen[VOLUM,3] += (cAliasCof)->GW8_VOLUME
				EndIf
			EndIf

			(cAliasCof)->(DbCloseArea())

			cAliasCal := GetNextAlias()

			If lTrpNota
				cQuery := " AND GWF_TRANSP = '" + GW3->GW3_EMISDF + "' "

				cQuery := "%" + cQuery + "%"
			EndIf

			cCpoGWF := "%SUM(GWF_PCIBS) GWF_PCIBS, SUM(GWF_VLRIBS) GWF_VLRIBS,%"

			BeginSQL Alias cAliasCal
				SELECT GWH_NRCALC,
					   SUM(GWF_VLISS)  GWF_VLISS,
					   SUM(GWF_PCICMS) GWF_PCICMS,
					   SUM(GWF_VLICMS) GWF_VLICMS,
					   SUM(GWI_VLFRET) GWI_VLFRET,
						%Exp:cCpoGWF%
					   GWF_CIDORI,
					   GWF_CIDDES,
					   GV2_CATVAL,
					   GV2_CDCOMP
				FROM %Table:GWH% GWH
				INNER JOIN %Table:GWF% GWF
				ON GWF_FILIAL = GWH_FILIAL
				AND GWF_NRCALC = GWH_NRCALC
				AND GWF_TPCALC = %Exp:GW3->GW3_TPDF%
				AND GWF.%NotDel%
				%Exp:cQuery%
				LEFT JOIN %Table:GWI% GWI
				ON GWI_FILIAL = GWH_FILIAL
				AND GWI_NRCALC = GWH_NRCALC
				AND GWI_TOTFRE = '1'
				AND GWI.%NotDel%
				LEFT JOIN %Table:GV2% GV2
				ON GV2_FILIAL = %xFilial:GV2%
				AND GWI_CDCOMP = GV2_CDCOMP
				AND GV2.%NotDel%
				WHERE GWH_FILIAL = %Exp:(cAliasGW3)->GW1_FILIAL%
				AND GWH_CDTPDC = %Exp:(cAliasGW3)->GW1_CDTPDC%
				AND GWH_EMISDC = %Exp:(cAliasGW3)->GW1_EMISDC%
				AND GWH_SERDC  = %Exp:(cAliasGW3)->GW1_SERDC%
				AND GWH_NRDC   = %Exp:(cAliasGW3)->GW1_NRDC%
				AND GWH.%NotDel%
				GROUP BY GWH_NRCALC,GWF_CIDORI,GWF_CIDDES,GV2_CATVAL,GV2_CDCOMP
			EndSQL

			lFirstCalc := .T.
			aAuxTaxas  := TaxaList(cFilDF,cEspDF,cEmiDF,cSerDF,cNumDF)

			While !(cAliasCal)->(Eof())

				// Deve realizar a somatória apenas uma vez por cálculo e tipo para não duplicar os valores
				If AScan(aCalcRel, {|x| x == (cAliasCal)->GWH_NRCALC+(cAliasCal)->GV2_CATVAL}) > 0
					(cAliasCal)->(DbSkip())
					Loop
				EndIf

				AAdd(aCalcRel,(cAliasCal)->GWH_NRCALC+(cAliasCal)->GV2_CATVAL)

				If lFirstCalc
					If (cAliasCal)->GWF_CIDORI == (cAliasCal)->GWF_CIDDES
						aConferen[ALQTA,3] := aConferen[ALQTA,2] // Recebe do próprio documento de frete
						aConferen[VLIMP,3] += (cAliasCal)->GWF_VLISS + Iif(GFXCP2510("GWF_VLRIBS"), (cAliasCal)->GWF_VLRIBS, 0)
					Else
						aConferen[ALQTA,3] := (cAliasCal)->GWF_PCICMS + Iif(GFXCP2510("GWF_PCIBS"), (cAliasCal)->GWF_PCIBS, 0)
						aConferen[VLIMP,3] += (cAliasCal)->GWF_VLICMS + Iif(GFXCP2510("GWF_VLRIBS"), (cAliasCal)->GWF_VLRIBS, 0)
					EndIf
				EndIf

				aConferen[VLTOT,3] += (cAliasCal)->GWI_VLFRET

				Do Case
				Case (cAliasCal)->GV2_CATVAL == "1"  // Frete Unidade
					aConferen[FRTUN,3] += (cAliasCal)->GWI_VLFRET
				Case (cAliasCal)->GV2_CATVAL == "2"  // Frete Valor
					aConferen[FRTVL,3] += (cAliasCal)->GWI_VLFRET
				Case (cAliasCal)->GV2_CATVAL == "3"  // Taxas
					aConferen[TAXAS,3] += (cAliasCal)->GWI_VLFRET
					nCod := ASCAN(aAuxTaxas,{|x| AllTrim(x[1]) == AllTrim((cAliasCal)->GV2_CDCOMP)})
					If nCod > 0
						aAuxTaxas[nCod][3] := (cAliasCal)->GWI_VLFRET
					Else
						AADD(aAuxTaxas,{(cAliasCal)->GV2_CDCOMP, 0, (cAliasCal)->GWI_VLFRET})
					EndIf
				Case (cAliasCal)->GV2_CATVAL == "4"  // Valor do Pedagio
					aConferen[VLPED,3] += (cAliasCal)->GWI_VLFRET
				EndCase

				lFirstCalc := .F.

				(cAliasCal)->(DbSkip())
			EndDo

			(cAliasCal)->(DbCloseArea())

			(cAliasGW3)->(DbSkip())
		EndDo

		oSection2:Finish()

		// Imprime dados da conferência
		oSection3:Init()

		For nI := 1 To Len(aConferen)
			nInd := nI
			oSection3:PrintLine()
		Next

		oSection3:Finish()

		cAliasGWA := GetNextAlias()
		cQuery := "% '2'" // CTRC/NFS
		If Len(oSection4:AUSERFILTER) > 0
			If oSection4:AUSERFILTER[1][3] <> ''
				cQuery += " AND ( " + oSection4:AUSERFILTER[1][3] + " )"
			EndIf
		EndIf

		cQuery += " ORDER BY " + SqlOrder(GWA->(IndexKey(1))) // GWA_FILIAL+GWA_TPDOC+GWA_CDESP+GWA_CDEMIT+GWA_SERIE+GWA_NRDOC+DTOS(GWA_DTEMIS)
		cQuery += "%"

		BeginSql Alias cAliasGWA
			SELECT  GWA.GWA_FILIAL,
			 		GWA.GWA_CDESP,
					GWA.GWA_CDEMIT,
					GWA.GWA_SERIE,
					GWA.GWA_NRDOC,
					GWA.GWA_DTMOV,
					GWA.GWA_CDTRAN,
					GWA.GWA_CTACRE,
					GWA.GWA_CTADEB,
					GWA.GWA_VLMOV,
					GWA.GWA_DSHIST,
					GWA.GWA_SITCTB,
					GWA.R_E_C_N_O_ AS GWARecno
			FROM %Table:GWA% GWA
			WHERE GWA.GWA_FILIAL = %Exp:cFilDF%
			AND GWA.GWA_CDESP = %Exp:cEspDF%
			AND GWA.GWA_CDEMIT = %Exp:cEmiDF%
			AND GWA.GWA_SERIE = %Exp:cSerDF%
			AND GWA.GWA_NRDOC = %Exp:cNumDF%
			AND GWA.GWA_DTEMIS = %Exp:cDtEDF%
			AND GWA.%NotDel% 
			AND GWA.GWA_TPDOC = %Exp:cQuery%
		EndSql

		TcSetField(cAliasGWA,'GWA_DTMOV','D',8,0)
		oSection4:Init()

		While !(cAliasGWA)->(Eof())
			GWA->(DbGoTo( (cAliasGWA)->GWARecno ))
			oSection4:PrintLine() // Imprime a grade contábil

			(cAliasGWA)->(DbSkip())
		EndDo

		oSection4:Finish()

/****************************************************************************************/
		// Imprime dados de taxas
		oSection5:Init()

		For nITx := 1 To Len(aAuxTaxas)
			nTxInd ++
			oSection5:PrintLine()
		Next nITx

		nTxInd := 0
		oSection5:Finish()
		(cAliasGWA)->(DbCloseArea())
		oReport:Skipline()
	EndDo

	If oReport:Cancel()
		oReport:CancelPrint()
	EndIf

	oSection1:Finish()

	(cAliasGW3)->(DbCloseArea())
	RestArea(aAreaGWA)
Return

// -----------------------------------------------------------
/*/{Protheus.doc} MntExpFil
Monta expressão utilizada para filtrar filial no SQL principal
do relatório

@param   aSelFil  Array retornado pela função GetGCList()

@author  Guilherme A. Metzger
@since   17/03/2016
@version 1.0
@obs     Para os casos em que se utiliza Gestão de Empresas
/*/
// -----------------------------------------------------------
Static Function MntExpFil(aSelFil)
	Local cExpFil := ""

	If !Empty(aSelFil)
		If Len(aSelFil) > 1
			AEval(aSelFil, { | x | cExpFil += Iif(cExpFil=="",x,"','"+x) } )
			cExpFil := "GW3_FILIAL IN ('" + cExpFil + "') AND"
		Else
			cExpFil := "GW3_FILIAL = '" + aSelFil[1] + "' AND"
		EndIf
	EndIf

Return cExpFil

// -----------------------------------------------------------
/*/{Protheus.doc} MntExpSit
Monta expressão utilizada para filtrar as situações do documento
de frete parametrizados na impressão do relatório

@author  Guilherme A. Metzger
@since   17/03/2016
@version 1.0
/*/
// -----------------------------------------------------------
Static Function MntExpSit()
	Local cExpSit := AllTrim(Str(MV_PAR13))

	If cExpSit == "5" // Todos
		cExpSit := ""
	ElseIf cExpSit == "3" // Aprovação sistema / usuario
		cExpSit := " IN ('3','4')"
	ElseIf cExpSit == "4" // Bloqueado por Entrega
		cExpSit := " = '5'"
	Else
		cExpSit := " = '"+cExpSit+"'"
	EndIf

Return cExpSit

// -----------------------------------------------------------
/*/{Protheus.doc} MntExpTpDf
Monta expressão utilizada para filtrar os tipos de documento
de frete parametrizados na impressão do relatório

@author  Guilherme A. Metzger
@since   17/03/2016
@version 1.0
/*/
// -----------------------------------------------------------
Static Function MntExpTpDf()
	Local cExpTpDf := ""
	Local cTipos   := ""
	Local nI       := 1

	cTipos += Iif(MV_PAR14==1,"1","")
	cTipos += Iif(MV_PAR15==1,"2","")
	cTipos += Iif(MV_PAR16==1,"3","")
	cTipos += Iif(MV_PAR17==1,"4","")
	cTipos += Iif(MV_PAR18==1,"5","")
	cTipos += Iif(MV_PAR19==1,"6","")
	cTipos += Iif(MV_PAR20==1,"7","")

	If Len(cTipos) > 1
		For nI := 1 To Len(cTipos)
			If cExpTpDf == ""
				cExpTpDf += SubStr(cTipos,nI,1)
			Else
				cExpTpDf += "','" + SubStr(cTipos,nI,1)
			EndIf
		Next
		cExpTpDf := " IN ('" + cExpTpDf + "')"
	Else
		cExpTpDf := " = '" + cTipos + "'"
	EndIf

Return cExpTpDf

// Funções genéricas presentes em diversos relatórios
// Está sendo repetida nesse fonte para não necessitar o commit dos demais fontes de relatório
Static Function GetSx3Inf(cCampo,aRetorno)
	Local nCont := 1
	Local aArea := GetArea("SX3")

	Default aRetorno := {"","","",""}

	For nCont := 1 to 4-Len(aRetorno)
		aAdd(aRetorno,"")
	Next

	dbSelectArea("SX3")
	dbSetOrder(2)

	If dbSeek( cCampo )
		aRetorno[1] := X3Titulo()
		aRetorno[2] := X3Cbox()
		aRetorno[3] := X3Picture()
		aRetorno[4] := X3DESCRIC()
	EndIf

	RestArea(aArea)
Return aRetorno

Static Function GetStrCbox(cBox,cVal)
	Local aArr := STRTOKARR(cBox,";")
	Local aArr2 := {}
	Local nCont,nPos,cRet:=""

	For nCont :=1 to Len(aArr)
		aAdd(aArr2,STRTOKARR(aArr[ncont],"="))
	Next nCont

	If Len(aArr2) > 0
		nPos := aScan(aArr2,{|x|x[1]==cVal})
		If nPos > 0
			cRet := aArr2[nPos][2]
		EndIf
	EndIf

Return cRet

Static Function TaxaList(cFilDF,cEspDF,cEmiDF,cSerDF,cNumDF)
	Local aArea     := FWGetArea()
	Local aDados    := {}
	Local cAliasGZZ := GetNextAlias()

	BeginSql Alias cAliasGZZ
		SELECT GZZ_TAXA  AS TXDESC,
			   GZZ_VALOR AS TXVLR1
		FROM %Table:GZZ% GZZ
		WHERE GZZ_FILIAL     = %Exp:cFilDF%
			  AND GZZ_CDESP  = %Exp:cEspDF%
			  AND GZZ_EMISDF = %Exp:cEmiDF%
			  AND GZZ_SERDF  = %Exp:cSerDF%
			  AND GZZ_NRDF   = %Exp:cNumDF%
		      AND GZZ.%NotDel%
	EndSql

	While !(cAliasGZZ)->(Eof())
		AADD(aDados, {(cAliasGZZ)->TXDESC, (cAliasGZZ)->TXVLR1,0})
		(cAliasGZZ)->(DBSKIP())
	EndDo

	(cAliasGZZ)->(DbCloseArea())
	FWRestArea(aArea)
Return aDados
