/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFER055.ch"
#INCLUDE "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} GFER055

Relátorio Pré-faturas

@author Jorge Matos Valcanaia
@since 27/11/09
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFER055()

	Local oReport
	Local aArea := GetArea()

	Private cAliasGWJ
	Private aGWJSit    := {}
	Private aGWJSitFin := {}
	Private aGW1Sit    := {}
	Private aGW1TpFret := {}
	Private aGW1EnvEDI := {}
	Private aGW1Uso    := {}
	Private aGW1ICMSDC := {}
	Private aGW1AutSEF := {}
	Private aGW1CalcAt := {}
	Private aGW1SitFt  := {}
	Private lIsMsSQL   := "MSSQL" $ Upper(TcGetDB()) // Verifica se o Banco é SQLServer

	If TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

	RestArea( aArea )

Return

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os
//          relatorios que poderao ser agendados pelo usuario.
//
//Uso       GFER055
//---------------------------------------------------------------------------

Static Function ReportDef()
Local oReport, oSection1
Local aOrdem    := {}
Local oFldHid

//--------------------------------------------------------------------------
//Criacao do componente de impressao
//--------------------------------------------------------------------------
//TReport():New
//ExpC1 : Nome do relatorio
//ExpC2 : Titulo
//ExpC3 : Pergunte
//ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
//ExpC5 : Descricao
//--------------------------------------------------------------------------

oReport:= TReport():New("GFER055",STR0001,"GFER055", {|oReport| ReportPrint(oReport)},STR0002)  //"Relatório de Pré-fatura"###"Emite relatório das pré-faturas conforme parâmetros informados."
oReport:SetLandscape()
oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
oReport:SetTotalInLine(.F.)
Pergunte("GFER055",.F.)
//--------------------------------------------------------------------------
//Criacao da secao utilizada pelo relatorio
//--------------------------------------------------------------------------
//TRSection():New
//ExpO1 : Objeto TReport que a secao pertence
//ExpC2 : Descricao da seçao
//ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
//        sera considerada como principal para a seção.
//ExpA4 : Array com as Ordens do relatório
//ExpL5 : Carrega campos do SX3 como celulas
//        Default : False
//ExpL6 : Carrega ordens do Sindex
//        Default : False
//--------------------------------------------------------------------------
//Criacao da celulas da secao do relatorio
//
//TRCell():New
//ExpO1 : Objeto TSection que a secao pertence
//ExpC2 : Nome da celula do relatório. O SX3 será consultado
//ExpC3 : Nome da tabela de referencia da celula
//ExpC4 : Titulo da celula
//        Default : X3Titulo()
//ExpC5 : Picture
//        Default : X3_PICTURE
//ExpC6 : Tamanho
//        Default : X3_TAMANHO
//ExpL7 : Informe se o tamanho esta em pixel
//        Default : False
//ExpB8 : Bloco de código para impressao.
//        Default : ExpC2
//--------------------------------------------------------------------------

Aadd( aOrdem, STR0003 ) // "Sequência" //"Codigo"


oSection1 := TRSection():New(oReport,STR0004,{"GWJ"},aOrdem) // "Pré-fatura" //"Pré-fatura"
oSection1:SetLineStyle() //Define a impressao da secao em linha
oSection1:SetTotalInLine(.F.)
TRCell():New(oSection1,"GWJ_FILIAL","GWJ",/*" Filial"*/        ,/*Picture*/        ,TamSX3("GWJ_FILIAL")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GWJ_FILIAL})
TRCell():New(oSection1,"GWJ_NRPF"  ,"GWJ",/*" Pré-fatura"*/    ,/*Picture*/        ,TamSX3("GWJ_NRPF"  )[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GWJ_NRPF  })
TRCell():New(oSection1,"GWJ_CDTRP" ,"GWJ",/*" Transp"*/        ,/*Picture*/        ,TamSX3("GWJ_CDTRP" )[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GWJ_CDTRP })
TRCell():New(oSection1,"GU3_NMEMIT","GWJ",/*" Transportadora"*/,/*Picture*/        ,TamSX3("GU3_NMEMIT")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GU3_NMEMIT})
TRCell():New(oSection1,"GWJ_SIT"   ,"GWJ",/*" Situação"*/      ,/*Picture*/        ,11                       ,/*lPixel*/,{|| GetSX3cBox("GWJ_SIT",(cAliasGWJ)->GWJ_SIT)})
TRCell():New(oSection1,"GWJ_DTIMPL","GWJ",/*" Dt Criação"*/    ,/*Picture*/        ,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_DTIMPL})
TRCell():New(oSection1,"GWJ_HRIMPL","GWJ",/*" Hr Criação"*/    ,/*Picture*/        ,6                        ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_HRIMPL})
TRCell():New(oSection1,"GWJ_DTCANC","GWJ",/*" Data Cancel"*/   ,/*Picture*/        ,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_DTCANC})
TRCell():New(oSection1,"GWJ_HRCAN" ,"GWJ",/*" Hora Cancel"*/   ,/*Picture*/        ,6                        ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_HRCAN })
TRCell():New(oSection1,"GWJ_USUCAN","GWJ",/*" Usuário Cancel"*/,/*Picture*/        ,TamSX3("GWJ_USUCAN")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GWJ_USUCAN})
TRCell():New(oSection1,"VLTOTAL"   ,"GWJ",STR0005              ,"@E 999,999,999.99",15                       ,/*lPixel*/,{|| (cAliasGWJ)->VLTOTAL   },"LEFT") //"Valor Total"

oFldHid := TRCell():New(oSection1,"GWJ_DTVCTO","GWJ",/*" Nome"*/       ,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_DTVCTO })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_USUIMP","GWJ",/*" Nome"*/       ,/*Picture*/,TamSX3("GWJ_USUIMP")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GWJ_USUIMP })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_DTAPR" ,"GWJ",/*" Nome"*/       ,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_DTAPR  })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_HRAPR" ,"GWJ",/*" Nome"*/       ,/*Picture*/,6                        ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_HRAPR  })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_USUAPR","GWJ",/*" Nome"*/       ,/*Picture*/,TamSX3("GWJ_USUAPR")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GWJ_USUAPR })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_DTENV" ,"GWJ",/*" Nome"*/       ,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_DTENV  })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_HRENV" ,"GWJ",/*" Nome"*/       ,/*Picture*/,6                        ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_HRENV  })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_USUENV","GWJ",/*" Nome"*/       ,/*Picture*/,TamSX3("GWJ_USUENV")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GWJ_USUENV })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_EMIFAT","GWJ",/*" Nome"*/       ,/*Picture*/,TamSX3("GWJ_EMIFAT")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GWJ_EMIFAT })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_SERFAT","GWJ",/*" Nome"*/       ,/*Picture*/,TamSX3("GWJ_SERFAT")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GWJ_SERFAT })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_NRFAT" ,"GWJ",/*" Nome"*/       ,/*Picture*/,TamSX3("GWJ_NRFAT")[1]+1 ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_NRFAT  })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_DTEMFA","GWJ",/*" Nome"*/       ,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_DTEMFA })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_FILFAT","GWJ",/*" Nome"*/       ,/*Picture*/,TamSX3("GWJ_FILFAT")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GWJ_FILFAT })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_SITFIN","GWJ",/*" Nome"*/       ,/*Picture*/,24                       ,/*lPixel*/,{|| GetSX3cBox("GWJ_SITFIN",(cAliasGWJ)->GWJ_SITFIN) })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_DTFIN" ,"GWJ",/*" Nome"*/       ,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_DTFIN  })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_MOTFIN" ,"GWJ",/*" Motivo fin"*/,/*Picture*/,100                      ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_MOTFIN})
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection1,"GWJ_MOTCAN","GWJ",/*" Motivo can"*/,/*Picture*/, 100                      ,/*lPixel*/,{|| (cAliasGWJ)->GWJ_MOTCAN})
oFldHid:lUserEnabled := .F.

oSection2 := TRSection():New(oSection1,STR0006,{"GWF"},aOrdem) // "Cálculos de Frete"  //"Cálculos de Frete"
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
TRCell():New(oSection2,"GWF_NRCALC" ,"GWF",/*cTitle*/,/*Picture*/        ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GWF_TPCALC" ,"GWF",/*cTitle*/,/*Picture*/        ,/*Tamanho*/,/*lPixel*/,/*{|| Tabela("L4",(cAliasQry)->DTW_SERVIC,.F.) }*/ )
TRCell():New(oSection2,"GWF_DTCRIA" ,"GWF",/*cTitle*/,/*Picture*/        ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"cVlFrt"     ,""   ,STR0005   ,"@E 999,999,999.99",14         ,/*lPixel*/,  {||cVlFrt                   },,,"RIGHT"  )//"Valor Total"

oSection3 := TRSection():New(oSection1,STR0007,{"GW1"},aOrdem) // "Documento de carga" //"Documento de Carga"
oSection3:SetTotalInLine(.F.)
oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
TRCell():New(oSection3,"GW1_SERDC"  ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||(cAliasGWJ)->GW1_SERDC })
TRCell():New(oSection3,"GW1_NRDC"   ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||(cAliasGWJ)->GW1_NRDC  })
TRCell():New(oSection3,"GW1_EMISDC" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||(cAliasGWJ)->GW1_EMISDC})
TRCell():New(oSection3,"EMISDC"     ,""   ,STR0008   ,/*Picture*/,25         ,/*lPixel*/,{||(cAliasGWJ)->EMISDC    }) //"Emissor Dc"
TRCell():New(oSection3,"GW1_CDTPDC" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||(cAliasGWJ)->GW1_CDTPDC})
TRCell():New(oSection3,"GW1_CDREM"  ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||(cAliasGWJ)->GW1_CDREM })
TRCell():New(oSection3,"DSREM"      ,""   ,STR0009   ,/*Picture*/,25         ,/*lPixel*/,{||(cAliasGWJ)->DSREM     }) //"Nome Remetente"
TRCell():New(oSection3,"GW1_CDDEST" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||(cAliasGWJ)->GW1_CDDEST})
TRCell():New(oSection3,"DSDEST"     ,""   ,STR0010   ,/*Picture*/,25         ,/*lPixel*/,{||(cAliasGWJ)->DSDEST    }) //"Nome Destinatario"
TRCell():New(oSection3,"GW1_DTIMPL" ,"GW1",/*cTitle*/,/*Picture*/,10         ,/*lPixel*/,{||(cAliasGWJ)->GW1_DTIMPL})
TRCell():New(oSection3,"CDCIDREM"  ,""    ,STR0011   ,/*Picture*/,10         ,/*lPixel*/,{||(cAliasGWJ)->CDCIDREM  }) //"Nr Rem"
TRCell():New(oSection3,"NMCIDREM"  ,""    ,STR0012   ,/*Picture*/,25         ,/*lPixel*/,{||(cAliasGWJ)->NMCIDREM  }) //"Cidade Rem"
TRCell():New(oSection3,"UFREM"     ,""    ,STR0013   ,/*Picture*/,2          ,/*lPixel*/,{||(cAliasGWJ)->UFREM     }) //"UF Rem"
TRCell():New(oSection3,"CDCIDDEST" ,""    ,STR0014   ,/*Picture*/,10         ,/*lPixel*/,{||(cAliasGWJ)->CDCIDDEST }) //"Nr Dest"
TRCell():New(oSection3,"NMCIDDEST" ,""    ,STR0015   ,/*Picture*/,25         ,/*lPixel*/,{||(cAliasGWJ)->NMCIDDEST }) //"Cidade Dest"
TRCell():New(oSection3,"UFDEST"    ,""    ,STR0016   ,/*Picture*/,2          ,/*lPixel*/,{||(cAliasGWJ)->UFDEST    }) //"UF Dest"

// Campos somente visíveis para personalizar
oFldHid := TRCell():New(oSection3,"GW1_FILIAL","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_FILIAL")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_FILIAL })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_DTEMIS","GW1",/*cTitle*/,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GW1_DTEMIS })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_SIT"   ,"GW1",/*cTitle*/,/*Picture*/,11                       ,/*lPixel*/,{|| GetSX3cBox("GW1_SIT", (cAliasGWJ)->GW1_SIT)})
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_NRROM" ,"GW1",/*cTitle*/,/*Picture*/,TamSx3("GW1_NRROM" )[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_NRROM })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ORIGEM","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_ORIGEM")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_ORIGEM })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_NRREG", "GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_NRREG" )[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_NRREG })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_TPFRET","GW1",/*cTitle*/,/*Picture*/,16                       ,/*lPixel*/,{|| GetSX3cBox("GW1_TPFRET", (cAliasGWJ)->GW1_TPFRET) })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_HRIMPL","GW1",/*cTitle*/,/*Picture*/,6                        ,/*lPixel*/,{|| (cAliasGWJ)->GW1_HRIMPL })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ENVEDI","GW1",/*cTitle*/,/*Picture*/,4                        ,/*lPixel*/,{|| GetSX3cBox("GW1_ENVEDI",(cAliasGWJ)->GW1_ENVEDI) })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_USO",   "GW1",/*cTitle*/,/*Picture*/,23                       ,/*lPixel*/,{|| GetSX3cBox("GW1_USO",(cAliasGWJ)->GW1_USO) })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_DSESP", "GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_DSESP" )[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_DSESP })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_QTVOL", "GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_QTVOL" )[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_QTVOL })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_CARREG","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_CARREG")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_CARREG })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_REGCOM","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_REGCOM")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_REGCOM })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_REPRES","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_REPRES")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_REPRES })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ICMSDC","GW1",/*cTitle*/,/*Picture*/,4                        ,/*lPixel*/,{|| GetSX3cBox("GW1_ICMSDC",(cAliasGWJ)->GW1_ICMSDC) })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ORINR", "GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_ORINR" )[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_ORINR })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ORISER","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_ORISER")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_ORISER })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ENTEND","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_ENTEND")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_ENTEND })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ENTBAI","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_ENTBAI")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_ENTBAI })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ENTCEP","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_ENTCEP")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_ENTCEP })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ENTNRC","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_ENTNRC")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_ENTNRC })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_USUIMP","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_USUIMP")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_USUIMP })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_DTLIB", "GW1",/*cTitle*/,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GW1_DTLIB })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_HRLIB", "GW1",/*cTitle*/,/*Picture*/,6                        ,/*lPixel*/,{|| (cAliasGWJ)->GW1_HRLIB })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_DTPSAI","GW1",/*cTitle*/,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GW1_DTPSAI })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_HRPSAI","GW1",/*cTitle*/,/*Picture*/,6                        ,/*lPixel*/,{|| (cAliasGWJ)->GW1_HRPSAI })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_DTPENT","GW1",/*cTitle*/,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GW1_DTPENT })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_DTALT", "GW1",/*cTitle*/,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GW1_DTALT })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_HRALT", "GW1",/*cTitle*/,/*Picture*/,6                        ,/*lPixel*/,{|| (cAliasGWJ)->GW1_HRALT })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_USUALT","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_USUALT")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_USUALT })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_DTCAN", "GW1",/*cTitle*/,/*Picture*/,11                       ,/*lPixel*/,{|| (cAliasGWJ)->GW1_DTCAN })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_HRCAN", "GW1",/*cTitle*/,/*Picture*/,6                        ,/*lPixel*/,{|| (cAliasGWJ)->GW1_HRCAN })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_USUCAN","GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_USUCAN")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_USUCAN })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_HRPENT","GW1",/*cTitle*/,/*Picture*/,6                        ,/*lPixel*/,{|| (cAliasGWJ)->GW1_HRPENT })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_AUTSEF","GW1",/*cTitle*/,/*Picture*/,15                       ,/*lPixel*/,{|| GetSX3cBox("GW1_AUTSEF",(cAliasGWJ)->GW1_AUTSEF) })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_DANFE", "GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_DANFE")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_DANFE })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_CALCAT","GW1",/*cTitle*/,/*Picture*/,22                      ,/*lPixel*/,{|| GetSX3cBox("GW1_CALCAT",(cAliasGWJ)->GW1_CALCAT) })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ROMTV", "GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_ROMTV")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_ROMTV })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ROMCF", "GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_ROMCF")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_ROMCF })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_ROMTO", "GW1",/*cTitle*/,/*Picture*/,TamSX3("GW1_ROMTO")[1]+1,/*lPixel*/,{|| (cAliasGWJ)->GW1_ROMTO })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_SITFT", "GW1",/*cTitle*/,/*Picture*/,24                      ,/*lPixel*/,{|| GetSX3cBox("GW1_SITFT",(cAliasGWJ)->GW1_SITFT)  })
oFldHid:lUserEnabled := .F.
oFldHid := TRCell():New(oSection3,"GW1_MOTFT", "GW1",/*cTitle*/,/*Picture*/,100                     ,/*lPixel*/,{|| (cAliasGWJ)->GW1_MOTFT })
oFldHid:lUserEnabled := .F.


oSection4 := TRSection():New(oSection1,"Rateio Contábil",{"GWK"},aOrdem) //
oSection4:SetTotalInLine(.F.)
oSection4:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
TRCell():New(oSection4,"GWK_SEQ"    ,"GWK",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"GWK_CTACTB" ,"GWK",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"GWK_CCUSTO" ,"GWK",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"GWK_VLMOV"  ,"GWK",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"GWK_LANCTO" ,"GWK",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"GWK_TRANS"  ,"GWK",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os
//          relatorios que poderao ser agendados pelo usuario.
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório
//---------------------------------------------------------------------------
//Uso  GFER055
//---------------------------------------------------------------------------

Static Function ReportPrint(oReport)
	Local oSection1  := oReport:Section(1)
	Local oSection2  := oReport:Section(1):Section(1)
	Local oSection3  := oReport:Section(1):Section(2)
	Local oSection4  := oReport:Section(1):Section(3)
	Local aNRDC      := {}
	Local aSelFil    := {}
	Local cCount     := ""
	Local cSelect    := ""
	Local cOrderBy   := ""
	Local cQuery     := ""
	Local cAliasTot  := ""
	Local cGWJFilAnt := '' //filial da pre-fatura para dados impressos antes dos DC
	Local cGWJPFAnt  := '' //número filial da pre-fatura para dados impressos antes dos DC
	Private cVlFrt   := 0

	//Carrega o array com as situações
	CrtSX3cBox()

	aSelFil := oReport:GetGCList() //Utilizado pelo botão gestão de empresas, caso houver

	oSection1:Init()

	// O select principal reunirá as tabelas de pré-fatura, de cálculo e de documentos de carga,
	// além das tabelas de emitente e cidade usadas para impressão dos nomes.
	// Como existem tabelas/impressão 1-N, foram colocados controles para pré-fatura já impressas.

	cAliasGWJ := GetNextAlias()
	cAliasTot := GetNextAlias()

	cCount  += "SELECT COUNT(*) NCOUNT"

	If lIsMsSQL
		cSelect += "SELECT GWJ.*,"
		cSelect += " ISNULL(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047), GWJ_MOTFIN)),'') AS GWJ_MOTFIN,"
		cSelect += " ISNULL(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047), GWJ_MOTCAN)),'') AS GWJ_MOTCAN,"
	Else
		cSelect += "SELECT " + GetSX3CampoNMemo("GWJ")
		cSelect += " GWJ.R_E_C_N_O_ RECNOGWJ,"
	EndIf

	cSelect += " TRANSP.GU3_NMEMIT,"
	//Se a função GFEXFUNA.VLTOTFRET for modificada, esse SUM precisará ser revisto, pois foi feito baseado na função
	cSelect += " ("
	cSelect += " (SELECT SUM (GWF.GWF_VLAJUS)"
	cSelect +=    " FROM " + RetSQLName("GWF") + " GWF"
	cSelect +=   " WHERE GWF.GWF_FILPRE = GWJ.GWJ_FILIAL"
	cSelect +=     " AND GWF.GWF_NRPREF = GWJ.GWJ_NRPF"
	cSelect +=     " AND GWF.D_E_L_E_T_ = ' ') +"
	cSelect += " (SELECT SUM (GWI.GWI_VLFRET)"
	cSelect +=    " FROM " + RetSQLName("GWF") + " GWF, " + RetSQLName("GWI") + " GWI"
	cSelect +=   " WHERE GWF.GWF_FILPRE = GWJ.GWJ_FILIAL"
	cSelect +=     " AND GWF.GWF_NRPREF = GWJ.GWJ_NRPF"
	cSelect +=     " AND GWF.D_E_L_E_T_ = ' '"
	cSelect +=     " AND GWI.GWI_FILIAL = GWF.GWF_FILIAL"
	cSelect +=     " AND GWI.GWI_NRCALC = GWF.GWF_NRCALC"
	cSelect +=     " AND GWI.D_E_L_E_T_ = ' ')) VLTOTAL,"

	If lIsMsSQL
		cSelect += " GW1.*,"
		cSelect += " ISNULL(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047), GW1_MOTFT)),'') AS GW1_MOTFT,"
	Else
		cSelect += GetSX3CampoNMemo("GW1")
		cSelect += " GW1.R_E_C_N_O_ RECNOGW1,"
	EndIf

	cSelect += " EMIS.GU3_NMEMIT EMISDC, REM.GU3_NMEMIT DSREM, DEST.GU3_NMEMIT DSDEST,"
	cSelect += " CIDREM.GU7_NRCID CDCIDREM, CIDREM.GU7_NMCID NMCIDREM, CIDREM.GU7_CDUF UFREM,"
	cSelect += " CIDDEST.GU7_NRCID CDCIDDEST, CIDDEST.GU7_NMCID NMCIDDEST, CIDDEST.GU7_CDUF UFDEST"

	cQuery :=   " FROM "+RetSqlName("GWJ")+" GWJ"

	cQuery +=  " INNER JOIN "+RetSqlName("GU3")+" TRANSP"
	cQuery +=    " ON TRANSP.GU3_FILIAL = '"+xFilial("GU3")+"'"
	cQuery +=   " AND TRANSP.GU3_CDEMIT = GWJ.GWJ_CDTRP"
	cQuery +=   " AND TRANSP.D_E_L_E_T_ = ' '"

	cQuery +=  " LEFT JOIN "+RetSqlName("GWF")+" GWF"
	cQuery +=    " ON GWF.GWF_FILPRE = GWJ.GWJ_FILIAL"
	cQuery +=   " AND GWF.GWF_NRPREF = GWJ.GWJ_NRPF"
	cQuery +=   " AND GWF.D_E_L_E_T_ = ' '"

	cQuery +=  " LEFT JOIN "+RetSqlName("GWH")+" GWH"
	cQuery +=    " ON GWH.GWH_FILIAL = GWF.GWF_FILIAL"
	cQuery +=   " AND GWH.GWH_NRCALC = GWF.GWF_NRCALC"
	cQuery +=   " AND GWH.D_E_L_E_T_ = ' '"

	cQuery +=  " LEFT JOIN "+RetSqlName("GW1")+" GW1"
	cQuery +=    " ON GW1.GW1_CDTPDC = GWH.GWH_CDTPDC"
	cQuery +=   " AND GW1.GW1_EMISDC = GWH.GWH_EMISDC"
	cQuery +=   " AND GW1.GW1_SERDC  = GWH.GWH_SERDC"
	cQuery +=   " AND GW1.GW1_NRDC   = GWH.GWH_NRDC"
	cQuery +=   " AND GW1.D_E_L_E_T_ = ' '"

	cQuery +=  " LEFT JOIN "+RetSqlName("GU3")+" EMIS"
	cQuery +=    " ON EMIS.GU3_FILIAL = '"+xFilial("GU3")+"'"
	cQuery +=   " AND EMIS.GU3_CDEMIT = GW1.GW1_EMISDC"
	cQuery +=   " AND EMIS.D_E_L_E_T_ = ' '"

	cQuery +=  " LEFT JOIN "+RetSqlName("GU3")+" REM"
	cQuery +=    " ON REM.GU3_FILIAL = '"+xFilial("GU3")+"'"
	cQuery +=   " AND REM.GU3_CDEMIT = GW1.GW1_CDREM"
	cQuery +=   " AND REM.D_E_L_E_T_ = ' '"

	cQuery +=  " LEFT JOIN "+RetSqlName("GU3")+" DEST"
	cQuery +=    " ON DEST.GU3_FILIAL = '"+xFilial("GU3")+"'"
	cQuery +=   " AND DEST.GU3_CDEMIT = GW1.GW1_CDDEST"
	cQuery +=   " AND DEST.D_E_L_E_T_ = ' '"

	cQuery +=  " LEFT JOIN "+RetSqlName("GU7")+" CIDREM"
	cQuery +=    " ON CIDREM.GU7_FILIAL = '"+xFilial("GU7")+"'"
	cQuery +=   " AND CIDREM.GU7_NRCID  = REM.GU3_NRCID"
	cQuery +=   " AND CIDREM.D_E_L_E_T_ = ' '"

	cQuery +=  " LEFT JOIN " + RetSQLName("GU7") + " CIDDEST"
	cQuery +=    " ON CIDDEST.GU7_FILIAL = '" + xFilial("GU7") + "'"
	cQuery +=   " AND CIDDEST.GU7_NRCID  = DEST.GU3_NRCID"
	cQuery +=   " AND CIDDEST.D_E_L_E_T_ = ' '"

	cQuery +=  " WHERE GWJ.GWJ_FILIAL >= '"+MV_PAR01      +"' AND GWJ.GWJ_FILIAL <= '"+MV_PAR02      + "'"
	cQuery +=   " AND GWJ.GWJ_NRPF    >= '"+MV_PAR03      +"' AND GWJ.GWJ_NRPF   <= '"+MV_PAR04      + "'"
	cQuery +=   " AND GWJ.GWJ_DTIMPL  >= '"+DTOS(MV_PAR06)+"' AND GWJ.GWJ_DTIMPL <= '"+DTOS(MV_PAR07)+ "'"
	cQuery +=   " AND GWJ.GWJ_CDTRP   >= '"+MV_PAR08      +"' AND GWJ.GWJ_CDTRP  <= '"+MV_PAR09      + "'"
	cQuery +=   " AND GWJ.GWJ_DTENV   >= '"+DTOS(MV_PAR10)+"' AND GWJ.GWJ_DTENV  <= '"+DTOS(MV_PAR11)+ "'"
	cQuery +=   " AND GWJ.GWJ_DTVCTO  >= '"+DTOS(MV_PAR12)+"' AND GWJ.GWJ_DTVCTO <= '"+DTOS(MV_PAR13)+ "'"
	cQuery +=   " AND GWJ.D_E_L_E_T_   = ' '"

	If MV_PAR05 != 5
		cQuery += " AND GWJ.GWJ_SIT = '"+cValToChar(MV_PAR05)+"'"
	EndIf

	If !Empty(aSelFil)
		cQuery += " AND GWJ.GWJ_FILIAL = '"+xFilial("GWJ")+"'"
	EndIf

	cOrderBy += " ORDER BY GWJ.GWJ_FILIAL, GWJ.GWJ_NRPF, GW1.GW1_CDTPDC, GW1.GW1_EMISDC, GW1.GW1_SERDC, GW1.GW1_NRDC"

	//Seta regua de processamento
	cCount := cCount + cQuery
	ChangeQuery(cCount)
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cCount),cAliasTot,.F.,.T.)
	TcSetField(cAliasTot,'NCOUNT','N',6,0)
	oReport:SetMeter ((cAliasTot)->NCOUNT)
	(cAliasTot)->(DbCloseArea())

	cSelect := cSelect + cQuery + cOrderBy
	ChangeQuery(cSelect)
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSelect),cAliasGWJ,.F.,.T.)
	TcSetField(cAliasGWJ,"GWJ_DTIMPL","D",8,0)
	TcSetField(cAliasGWJ,"GWJ_DTCANC","D",8,0)
	TcSetField(cAliasGWJ,"GWJ_DTVCTO","D",8,0)
	TcSetField(cAliasGWJ,"GWJ_DTAPR" ,"D",8,0)
	TcSetField(cAliasGWJ,"GWJ_DTENV" ,"D",8,0)
	TcSetField(cAliasGWJ,"GWJ_DTEMFA","D",8,0)
	TcSetField(cAliasGWJ,"GWJ_DTFIN" ,"D",8,0)
	TcSetField(cAliasGWJ,"GW1_DTIMPL","D",8,0)
	TcSetField(cAliasGWJ,"GW1_DTEMIS","D",8,0)
	TcSetField(cAliasGWJ,"GW1_DTLIB" ,"D",8,0)
	TcSetField(cAliasGWJ,"GW1_DTPSAI","D",8,0)
	TcSetField(cAliasGWJ,"GW1_DTPENT","D",8,0)
	TcSetField(cAliasGWJ,"GW1_DTALT" ,"D",8,0)
	TcSetField(cAliasGWJ,"GW1_DTCAN" ,"D",8,0)

	While !oReport:Cancel() .AND. !(cAliasGWJ)->(Eof())
		oReport:IncMeter()

		//O select principal replica a pré-fatura para cada um dos documentos de carga.
		//Por isso, imprime apenas uma vez a pré-fatura e os cálculos dela.
		If cGWJFilAnt <> (cAliasGWJ)->GWJ_FILIAL .Or. cGWJPFAnt <> (cAliasGWJ)->GWJ_NRPF
			cGWJFilAnt := (cAliasGWJ)->GWJ_FILIAL
			cGWJPFAnt  := (cAliasGWJ)->GWJ_NRPF

			//Inicializa o array de documento da pré-fatura. Evita impressão repetida do DC na PF
			aNRDC := {}

			If !lIsMsSQL
				GWJ->(DbGoTo((cAliasGWJ)->RECNOGWJ))
			EndIf

			oSection1:PrintLine()

			//Início da impressão dos cálculos da pré-fatura.
			oSection2:Init()

			dbSelectArea("GWF")
			GWF->( dbSetOrder(3) )
			GWF->( dbSeek((cAliasGWJ)->GWJ_FILIAL + (cAliasGWJ)->GWJ_NRPF) )
			While !oReport:Cancel() .And. !GWF->( Eof() ) .And. ;
				GWF->GWF_FILPRE + GWF->GWF_NRPREF ==  (cAliasGWJ)->GWJ_FILIAL + (cAliasGWJ)->GWJ_NRPF

				cVlFrt := VLTOTFRET()

				oSection2:PrintLine()

				dbSelectArea("GWF")
				GWF->( dbSkip() )
			EndDo

			oSection2:Finish()
			//Fim da impressão dos cálculos da pré-fatura.

			//Início da impressão dos documentos de carga
			oSection3:Init()
		EndIf

		If !Empty((cAliasGWJ)->GW1_NRDC)
			If ASCAN(aNRDC,(cAliasGWJ)->GW1_NRDC) == 0
				AADD(aNRDC,(cAliasGWJ)->GW1_NRDC)
				If !lIsMsSQL
					GW1->(DbGoTo((cAliasGWJ)->RECNOGW1))
				EndIf
				oSection3:PrintLine()
			EndIf
		EndIf

		dbSelectArea((cAliasGWJ))
		(cAliasGWJ)->(dbSkip())

		//Caso tenha passado para a próxima pré-fatura ou seja fim do relatório, encerra os DC eimprime o contábil.
		If cGWJFilAnt <> (cAliasGWJ)->GWJ_FILIAL .Or. cGWJPFAnt <> (cAliasGWJ)->GWJ_NRPF .Or. (cAliasGWJ)->(Eof())

			oSection3:Finish()

			dbSelectArea("GWK")
			dbSetOrder(1)
			If dbSeek( cGWJFilAnt + cGWJPFAnt)

				oSection4:Init()

				oReport:PrintText("",,0)
				oReport:PrintText("Rateio Contábil",,300)	/*Imprime o identificador dos Rateios Contábil*/

				While !oReport:Cancel() .And. !EOF() .AND. GWK->GWK_FILIAL == cGWJFilAnt .AND. GWK->GWK_NRPF == cGWJPFAnt

					oSection4:PrintLine()

					dbSelectArea("GWK")
					dbSkip()

				EndDo

				oSection4:Finish()
			EndIf

			oReport:SkipLine()
			oReport:SkipLine()
		EndIf
	EndDo

//----------------------------------------------------------
// Finaliza utilizacao das sections e fecha area temporaria
//----------------------------------------------------------

	oSection1 :Finish()

	(cAliasGWJ)->(DbCloseArea())

Return


/*/--------------------------------------------------------------------------------------------------
Função criada para carregar em arrays os campos que são código/descrição.
Isso evita de fazer um select para cada DC impresso.
--------------------------------------------------------------------------------------------------/*/
Static Function CrtSX3cBox()
Local cBox

	cBox := GetSx3Cache("GWJ_SIT","X3_CBOX")
	aGWJSit := StrToKArr(cBox, ";")
	cBox := GetSx3Cache("GWJ_SITFIN","X3_CBOX")
	aGWJSitFin := StrToKArr(cBox, ";")
	cBox := GetSx3Cache("GW1_SIT","X3_CBOX")
	aGW1Sit := StrToKArr(cBox, ";")
	cBox := GetSx3Cache("GWU_PAGAR","X3_CBOX")
	aGWUPagar := StrToKArr(cBox, ";")
	cBox := GetSx3Cache("GW1_TPFRET","X3_CBOX")
 	aGW1TpFret := StrToKArr(cBox, ";")
	cBox := GetSx3Cache("GW1_ENVEDI","X3_CBOX")
 	aGW1EnvEDI := StrToKArr(cBox, ";")
	cBox := GetSx3Cache("GW1_USO","X3_CBOX")
 	aGW1Uso    := StrToKArr(cBox, ";")
	cBox := GetSx3Cache("GW1_ICMSDC","X3_CBOX")
 	aGW1ICMSDC := StrToKArr(cBox, ";")
	cBox := GetSx3Cache("GW1_AUTSEF","X3_CBOX")
 	aGW1AutSEF := StrToKArr(cBox, ";")
	cBox := GetSx3Cache("GW1_CALCAT","X3_CBOX")
 	aGW1CalcAt := StrToKArr(cBox, ";")
	cBox := GetSx3Cache("GW1_SITFT","X3_CBOX")
 	aGW1SitFt  := StrToKArr(cBox, ";")

Return nil

/*/--------------------------------------------------------------------------------------------------
Função criada para ler a descrição de um campo a partir do código para um determinado campo.
Isso evita de fazer um select para cada DC impresso.
--------------------------------------------------------------------------------------------------/*/
Static Function GetSX3cBox(cCampo, cValor)

	Do Case
		Case Upper(cCampo) == "GWJ_SIT"
			Return GetArVal(aGWJSit, cValor)
		Case Upper(cCampo) == "GWJ_SITFIN"
			Return GetArVal(aGWJSitFin, cValor)
		Case Upper(cCampo) == "GW1_SIT"
			Return GetArVal(aGW1Sit, cValor)
		Case Upper(cCampo) == "GWU_PAGAR"
			Return GetArVal(aGWUPagar, cValor)
		Case Upper(cCampo) == "GW1_TPFRET"
			Return GetArVal(aGW1TpFret, cValor)
		Case Upper(cCampo) == "GW1_ENVEDI"
			Return GetArVal(aGW1EnvEDI, cValor)
		Case Upper(cCampo) == "GW1_USO"
			Return GetArVal(aGW1Uso, cValor)
		Case Upper(cCampo) == "GW1_ICMSDC"
			Return GetArVal(aGW1ICMSDC, cValor)
		Case Upper(cCampo) == "GW1_AUTSEF"
			Return GetArVal(aGW1AutSEF, cValor)
		Case Upper(cCampo) == "GW1_CALCAT"
			Return GetArVal(aGW1CalcAt, cValor)
		Case Upper(cCampo) == "GW1_SITFT"
			Return GetArVal(aGW1SitFt, cValor)
	EndCase

Return ''

/*/--------------------------------------------------------------------------------------------------
Função criada para procurar um código em um array passado por parâmetro e retornar a descrição.
Permite a reutilização de código.
--------------------------------------------------------------------------------------------------/*/
Static Function GetArVal(aArray, cValor)
Local nInd

	For nInd := 1 To Len(aArray)
		If Substr(aArray[nInd], 1, At("=",aArray[nInd]) - 1) == cValor
			Return Substr(aArray[nInd], At("=",aArray[nInd]) + 1, Len(aArray[nInd]))
		EndIf
	Next nInd

Return '' 

/*/--------------------------------------------------------------------------------------------------
Função criada para efetuar montagem de SELECT de campos de uma tabela excluindo campos memo.
--------------------------------------------------------------------------------------------------/*/
Static Function GetSX3CampoNMemo(cTabela)
	Local nX		
	Local aStructSX
	Local oStructX3	:= GFESeekSX():New()

	Local cCampos := ''

	aStructSX	:= FWFormStruct(3,cTabela)[1] //Todos os Campos

	For nX := 1 to Len(aStructSX)
		
		oStructX3:SeekX3(aStructSX[nX,3],.T.,.F.,.F.)

		If aStructSX[nX,4]  == "M"
			cCampos += "' ' " + aStructSX[nX,3] + ","
		Else
			If GetSx3Cache(aStructSX[nX,3],"X3_CONTEXT") != "V"
				cCampos += cTabela + "." + aStructSX[nX,3] + ","
			EndIf
		EndIf

	Next nX
	oStructX3:Destroy()
	
Return cCampos
