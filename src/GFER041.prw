/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} GFER041 - Movimentação Doc Carga - Commit nova ferramenta

@author Helder Fuckner dos Santos
@since 10/11/14
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFER041()
	Local oReport
	Local aArea := GetArea()

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
//Uso       GFER041                                                    
//---------------------------------------------------------------------------
Static Function ReportDef()                                                                      	
	Local oReport    := Nil
	Local oSection0  := Nil
	Local oSection1  := Nil
	Local oFldHid    := Nil
	Local aOrdem     := {}

	Private nTamValor  := TamSX3("GWF_VLAJUS")[1]+TamSX3("GWF_VLAJUS")[2]
	Private nTamCdEmis := TamSX3("GU3_CDEMIT")[1]
	Private nTamCid    := TamSX3("GW1_ENTCID")[1]
	Private nTamData   := TamSX3("GW1_DTEMIS")[1]
	Private nTamNmEmis := TamSX3("GU3_NMEMIT")[1]
	Private nTamUF     := 2

	//Tamanhos padrão
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

	oReport:= TReport():New("GFER041","Relatório de Movimentação de Cargas","GFER041", {|oReport| ReportPrint(oReport)},"Emite relatório de Movimentação Doc Carga conforme os parâmetros informados.") //"Movimentação Doc Carga"
	oReport:SetLandscape(.T.)   //Define a orientação de página do relatório como paisagem  ou retrato. .F.=Retrato; .T.=Paisagem
	oReport:SetTotalInLine(.T.) //Define se os totalizadores serão impressos em linha ou coluna
	oReport:HideParamPage()   	// Desabilita a impressao da pagina de parametros

	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf

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
	
	Aadd( aOrdem, "Movimentação Doc Carga" ) // "Movimentação Doc Carga"
	
	/*
		Seção "Oculta" necessária pois o botão "Gestão de Empresas" somente aprece se houver uma tabela padrão do dicionário.
	*/
	oSection0 := TRSection():New(oReport,"-",{"GW1"},{"-"}) //"Movimentação Doc Carga"
	oSection0:Hide()
	oSection0:Disable()
	oSection0:lReadOnly := .T.
	oSection0:lUserVisible := .F.
	
	oSection1 := TRSection():New(oReport,"Movimentação Doc Carga",{"(cTabTemp)"},aOrdem) //"Movimentação Doc Carga"
	oSection1:SetTotalInLine(.T.)
	oSection1:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	
	TRCell():New(oSection1,"(cTabTemp)->FILIAL"     ,"(cTabTemp)","Filial","@!"/*Picture*/, TamSX3("GW1_FILIAL")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->GW1_DTEMIS"	,"(cTabTemp)","Dt Nota Fiscal",/*Picture*/, nTamData,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->GW1_CDTPDC" ,"(cTabTemp)","Tipo NF",/*Picture*/,  TamSX3("GW1_CDTPDC")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->GW1_EMISDC" ,"(cTabTemp)","Cod Emissor",/*Picture*/,  nTamCdEmis,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->NMEMISNF"   ,"(cTabTemp)","Nome Emissor",/*Picture*/,  nTamNmEmis,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->GW1_SERDC"  ,"(cTabTemp)","Serie NF",/*Picture*/,  TamSX3("GW1_SERDC")[1],/*lPixel*/,/*{|| code-block de impressao }*/)	
	TRCell():New(oSection1,"(cTabTemp)->GW1_NRDC"   ,"(cTabTemp)","Número",/*Picture*/,  TamSX3("GW1_NRDC")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->VLR_NF"     ,"(cTabTemp)","Valor Doc Carga",/*Picture*/,  TamSX3("GW8_VALOR")[1]+TamSX3("GW8_VALOR")[2],/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLR_NF,"@E 999,999,999.99")) })
	TRCell():New(oSection1,"(cTabTemp)->PESO_NF"    ,"(cTabTemp)","Peso (kg) Doc Carga",/*Picture*/,  TamSX3("GW8_PESOR")[1]+TamSX3("GW8_PESOR")[2],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->VOLUME_NF"  ,"(cTabTemp)","Volume (m3) Doc Carga",/*Picture*/,  TamSX3("GW8_VOLUME")[1]+TamSX3("GW8_VOLUME")[2],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->CDDEST"     ,"(cTabTemp)","Cod Destinatário",/*Picture*/,  nTamCdEmis,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->NMDEST"     ,"(cTabTemp)","Destinatário",/*Picture*/,  nTamNmEmis,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->CIDDEST"    ,"(cTabTemp)","Cidade Destino",/*Picture*/,  nTamCid,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->ESTDEST"    ,"(cTabTemp)","Estado Destino",/*Picture*/,  nTamUF,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->ROMANEIO"   ,"(cTabTemp)","Nr Romaneio",/*Picture*/,  TamSX3("GW1_NRROM")[1],/*lPixel*/,/*{|| code-block de impressao }*/)	
	TRCell():New(oSection1,"(cTabTemp)->CDTRANSP"   ,"(cTabTemp)","Cod Transportador",/*Picture*/,  nTamCdEmis,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->NMTRANSP"   ,"(cTabTemp)","Transportador",/*Picture*/,  nTamNmEmis,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->DTSAI"    	,"(cTabTemp)","Data de Saída",/*Picture*/,  nTamData,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->DTENTREG" 	,"(cTabTemp)","Data de Entrega",/*Picture*/, nTamData,/*lPixel*/,{|| DtoC((cTabTemp)->DTENTREG) })
	TRCell():New(oSection1,"(cTabTemp)->TPFRETE"    ,"(cTabTemp)","Tipo de Frete",/*Picture*/,  20,/*lPixel*/,{|| R041TPFRE( (cTabTemp)->TPFRETE ) } )
	TRCell():New(oSection1,"(cTabTemp)->VLFRETRAT"  ,"(cTabTemp)","Valor Calc",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLFRETRAT,"@E 999,999,999.99")) })
	TRCell():New(oSection1,"(cTabTemp)->NRDOCRAT"   ,"(cTabTemp)","Nr Calc",/*Picture*/,  80,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->VLICMSRAT"  ,"(cTabTemp)","ICMS Calc",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLICMSRAT,"@E 999,999,999.99")) })
	TRCell():New(oSection1,"(cTabTemp)->CRDICMS"    ,"(cTabTemp)","Cred ICMS",/*Picture*/,  10,/*lPixel*/,{|| R041SIMNAO( (cTabTemp)->CRDICMS ) })
	TRCell():New(oSection1,"(cTabTemp)->VLPISRAT"   ,"(cTabTemp)","Pis Calc",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLPISRAT,"@E 999,999,999.99")) })
	TRCell():New(oSection1,"(cTabTemp)->VLCOFIRAT"  ,"(cTabTemp)","Cofins Calc",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLCOFIRAT,"@E 999,999,999.99")) })
	TRCell():New(oSection1,"(cTabTemp)->CRDPC"      ,"(cTabTemp)","Cred Pis/Cofins",/*Picture*/,  10,/*lPixel*/,{|| R041SIMNAO( (cTabTemp)->CRDPC ) })
	TRCell():New(oSection1,"(cTabTemp)->VLISSRAT"   ,"(cTabTemp)","ISS Calc",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLISSRAT,"@E 999,999,999.99")) })	
	
	If GFXCP2510('GWF_VLRIBS') .And. GFXCP2510('GWF_VLRCBS')
		TRCell():New(oSection1,"(cTabTemp)->VLIBSRAT"   ,"(cTabTemp)","IBS Est. Calc",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLIBSRAT,"@E 999,999,999.99")) })	
		TRCell():New(oSection1,"(cTabTemp)->VLIBMRAT"   ,"(cTabTemp)","IBS Mun. Calc",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLIBMRAT,"@E 999,999,999.99")) })	
		TRCell():New(oSection1,"(cTabTemp)->VLCBSRAT"   ,"(cTabTemp)","CBS Calc",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLCBSRAT,"@E 999,999,999.99")) })	
	EndIf

	TRCell():New(oSection1,"(cTabTemp)->VLCTRC"     ,"(cTabTemp)","Valor Doc Frete",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLCTRC,"@E 999,999,999.99")) })
	TRCell():New(oSection1,"(cTabTemp)->NRDOCFRE"   ,"(cTabTemp)","Nr Doc Frete",/*Picture*/, 80,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->GW3_CDESP"	,"(cTabTemp)","Cod Esp Doc Frete",/*Picture*/, TamSX3("GW3_CDESP")[1],/*lPixel*/,/*{||}*/)
	TRCell():New(oSection1,"(cTabTemp)->GW3_EMISDF"	,"(cTabTemp)","Emissor Doc Frete",/*Picture*/, TamSX3("GW3_EMISDF")[1],/*lPixel*/,/*{||}*/)
	TRCell():New(oSection1,"(cTabTemp)->GW3_SERDF"	,"(cTabTemp)","Serie Doc Frete",/*Picture*/, TamSX3("GW3_SERDF")[1],/*lPixel*/,/*{||}*/)
	TRCell():New(oSection1,"(cTabTemp)->GW3_DTEMIS"	,"(cTabTemp)","Dt Emis Doc Frete",/*Picture*/, nTamData,/*lPixel*/,{|| dtoc((cTabTemp)->GW3_DTEMIS) })
	TRCell():New(oSection1,"(cTabTemp)->GW3_DTENT" 	,"(cTabTemp)","Dt Entrada Doc Frete",/*Picture*/,  nTamData,/*lPixel*/,{|| dtoc((cTabTemp)->GW3_DTENT) })
	TRCell():New(oSection1,"(cTabTemp)->GW3_SITFIS" ,"(cTabTemp)","Sit Fis Doc Frete",/*Picture*/,  20,/*lPixel*/,{|| If(!Empty((cTabTemp)->GW3_SITFIS),GFEFldInfo("GW3_SITFIS",(cTabTemp)->GW3_SITFIS,2),) })
	TRCell():New(oSection1,"(cTabTemp)->GW3_DTFIS" 	,"(cTabTemp)","Dt Atu Doc Frete",/*Picture*/,  nTamData,/*lPixel*/,{|| dtoc((cTabTemp)->GW3_DTFIS) })
	TRCell():New(oSection1,"(cTabTemp)->VLICMSFRE"  ,"(cTabTemp)","ICMS Doc Frete",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLICMSFRE,"@E 999,999,999.99")) })
	TRCell():New(oSection1,"(cTabTemp)->GW3_CRDICM" ,"(cTabTemp)","Cred ICMS",/*Picture*/,  10,/*lPixel*/,{|| R041SIMNAO( (cTabTemp)->GW3_CRDICM ) }/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->VLPISFRE"   ,"(cTabTemp)","Pis Doc Frete",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLPISFRE,"@E 999,999,999.99")) })
	TRCell():New(oSection1,"(cTabTemp)->VLCOFIFRE"  ,"(cTabTemp)","Cofins Doc Frete",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLCOFIFRE,"@E 999,999,999.99")) })
	TRCell():New(oSection1,"(cTabTemp)->GW3_CRDPC"  ,"(cTabTemp)","Credt Pis/Cofins",/*Picture*/,  3,/*lPixel*/,{|| R041SIMNAO( (cTabTemp)->GW3_CRDPC ) }/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->VLISSFRE"   ,"(cTabTemp)","ISS Doc Frete",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLISSFRE,"@E 999,999,999.99")) })
	
	If GFXCP2510('GW3_VLIBS') .And. GFXCP2510('GW3_VLCBS')
		TRCell():New(oSection1,"(cTabTemp)->VLIBSFRE"  ,"(cTabTemp)","IBS Est. Doc Frete",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLIBSFRE,"@E 999,999,999.99")) })
		TRCell():New(oSection1,"(cTabTemp)->VLIBMFRE"  ,"(cTabTemp)","IBS Mun. Doc Frete",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLIBMFRE,"@E 999,999,999.99")) })
		TRCell():New(oSection1,"(cTabTemp)->VLCBSFRE"  ,"(cTabTemp)","CBS Doc Frete",/*Picture*/,  nTamValor,/*lPixel*/,{|| AllTrim(Transform((cTabTemp)->VLCBSFRE,"@E 999,999,999.99")) })
	EndIf

	TRCell():New(oSection1,"(cTabTemp)->GW3_CDTPSE" ,"(cTabTemp)","Tp Servico",/*Picture*/,  TamSX3("GW3_CDTPSE")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->GVU_DSTPSE" ,"(cTabTemp)","Desc Tp Serv",/*Picture*/,  TamSX3("GVU_DSTPSE")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->TPPROVIS"   ,"(cTabTemp)","Tipo Provisão",/*Picture*/,  10,/*lPixel*/,/*{|| R041TPPROV( (cTabTemp)->TPPROVIS ) }*/)
	TRCell():New(oSection1,"(cTabTemp)->NRDOCPROV"  ,"(cTabTemp)","Doc Provisão",/*Picture*/,  80,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->DTEMIPROV"	,"(cTabTemp)","Dt Emis Provisão",/*Picture*/,  nTamData,/*lPixel*/,{|| dtoc((cTabTemp)->DTEMIPROV) })
	TRCell():New(oSection1,"(cTabTemp)->SITFINPROV" ,"(cTabTemp)","Sit Fin Provisão",/*Picture*/,  10,/*lPixel*/, {||R041SITPROV((cTabTemp)->TPPROVIS, (cTabTemp)->SITFINPROV) })
	TRCell():New(oSection1,"(cTabTemp)->DTATUPROV" 	,"(cTabTemp)","Dt Atu Provisão",/*Picture*/,  nTamData,/*lPixel*/,{|| dtoc((cTabTemp)->DTATUPROV) })
	TRCell():New(oSection1,"(cTabTemp)->SITPREFAT"  ,"(cTabTemp)","Sit Pré-fat",/*Picture*/,  10,/*lPixel*/,{|| R041SITPF( (cTabTemp)->SITPREFAT ) })	
	TRCell():New(oSection1,"(cTabTemp)->TPDOCCOB"   ,"(cTabTemp)","Tipo Doc Cobrança",/*Picture*/,  10,/*lPixel*/,/*{|| code-block de impressao }*/)	
	TRCell():New(oSection1,"(cTabTemp)->DOCCOBRAN"  ,"(cTabTemp)","Doc Cobrança",/*Picture*/,  80,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cTabTemp)->DTEMICOB"  	,"(cTabTemp)","Dt Emis Cobrança",/*Picture*/,  nTamData,/*lPixel*/,{|| dtoc((cTabTemp)->DTEMICOB) })
	TRCell():New(oSection1,"(cTabTemp)->SITFINCOB"  ,"(cTabTemp)","Sit Financeiro",/*Picture*/, 10,/*lPixel*/, {||R041SITCOB((cTabTemp)->TPDOCCOB, (cTabTemp)->SITFINCOB) })
	TRCell():New(oSection1,"(cTabTemp)->DTATUCOB"  	,"(cTabTemp)","Dt Atu Cobrança",/*Picture*/,  nTamData,/*lPixel*/,{|| dtoc((cTabTemp)->DTATUCOB) })

	// Campos somente visíveis para personalizar
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->GW1_REGCOM" ,"(cTabTemp)","Região Comercial",/*Picture*/,  TamSX3("GW1_REGCOM")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	oFldHid:lUserEnabled := .F. 	
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->REPRES"     ,"(cTabTemp)","Representante",/*Picture*/,  TamSX3("GW1_REPRES")[1],/*lPixel*/,/*{|| code-block de impressao }*/)	
	oFldHid:lUserEnabled := .F.
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->PESO_CUB"   ,"(cTabTemp)","Peso Cubado (kg/m3) Doc Carga",/*Picture*/,  TamSX3("GW8_PESOC")[1]+TamSX3("GW8_PESOC")[2],/*lPixel*/,/*{|| code-block de impressao }*/)
	oFldHid:lUserEnabled := .F.
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->GWN_CDCLFR" ,"(cTabTemp)","Cl Frete Romaneio",/*Picture*/,  TamSX3("GWN_CDCLFR")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	oFldHid:lUserEnabled := .F.
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->GUB_DSCLFR" ,"(cTabTemp)","Desc Cl Frete",/*Picture*/,  TamSX3("GUB_DSCLFR")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	oFldHid:lUserEnabled := .F.
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->GWN_CDTPOP" ,"(cTabTemp)","Tp Oper Romaneio",/*Picture*/,  TamSX3("GWN_CDTPOP")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	oFldHid:lUserEnabled := .F.
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->GV4_DSTPOP" ,"(cTabTemp)","Desc Tp Oper",/*Picture*/,  TamSX3("GV4_DSTPOP")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	oFldHid:lUserEnabled := .F.
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->CDREMET"    ,"(cTabTemp)","Cod Remetente",/*Picture*/, nTamCdEmis ,/*lPixel*/,/*{|| code-block de impressao }*/)
	oFldHid:lUserEnabled := .F.
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->NMREMET"    ,"(cTabTemp)","Nome Remetente",/*Picture*/,  nTamNmEmis,/*lPixel*/,/*{|| code-block de impressao }*/)
	oFldHid:lUserEnabled := .F.
	
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->CIDREMET"   ,"(cTabTemp)","Cidade Origem",/*Picture*/,  nTamCid,/*lPixel*/,/*{|| code-block de impressao }*/)
	oFldHid:lUserEnabled := .F.
	oFldHid := TRCell():New(oSection1,"(cTabTemp)->ESTREMET"   ,"(cTabTemp)","Estado Origem",/*Picture*/,  nTamUF,/*lPixel*/,/*{|| code-block de impressao }*/)
	oFldHid:lUserEnabled := .F.
Return(oReport)

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.         
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório
//---------------------------------------------------------------------------
//Uso  GFER041                                                    
//---------------------------------------------------------------------------

Static Function ReportPrint(oReport)
	Local oSection1 	:= oReport:Section(2)
	Local cAliasGW1 	:= ""
	Local cAliasGWF		:= ""
	Local oTabTemp  	:= ""
	Local cWhereGW1		:= ""
	Local cJoinGWU		:= ""
	Local cWhereGWF		:= ""
	Local cWhereGW3		:= ""
	Local cTipos		:= ""
	Local cJoinGU3TRP	:= ""
	Local cAliasGWM		:= ""
	Local cCriRat 	 	:= SuperGetMV("MV_CRIRAT",,"1")
	Local aGCList   	:= {}
	Local aRet			:= {}

	Private cTabTemp	:= ""

	If !Empty(MV_PAR03)
		cWhereGW1 := "AND GW1.GW1_CDTPDC = '" + AllTrim(MV_PAR03) + "'"
	EndIf

	cJoinGWU := "%"
	If MV_PAR04 == 1
		cJoinGWU += "AND GWU.GWU_PAGAR = '1'"	
	EndIf
	cJoinGWU += "%"

	cWhereGWF := "%AND GWF.GWF_TPCALC IN ("
	cWhereGW3 := "%AND GW3.GW3_TPDF IN (" 

	If MV_PAR05 == 1
		cTipos += "'1'" 
	EndIf

	If MV_PAR06 == 1
		If Empty(cTipos)
			cTipos += "'2'"
		Else
			cTipos += ",'2'"
		EndIf
	EndIf

	If MV_PAR07 == 1
		If Empty(cTipos)
			cTipos += "'3'"
		Else
			cTipos += ",'3'"
		EndIf
	EndIf

	If MV_PAR08 == 1
		If Empty(cTipos)
			cTipos += "'4'"
		Else
			cTipos += ",'4'"
		EndIf
	EndIf

	If MV_PAR09 == 1
		If Empty(cTipos)
			cTipos += "'5'"
		Else
			cTipos += ",'5'"
		EndIf
	EndIf

	If MV_PAR10 == 1
		If Empty(cTipos)
			cTipos += "'6'"
		Else
			cTipos += ",'6'"
		EndIf
	EndIf

	If MV_PAR11 == 1
		If Empty(cTipos)
			cTipos += "'7'"
		Else
			cTipos += ",'7'"
		EndIf
	EndIf

	If !Empty(cTipos)
		cWhereGWF += cTipos + ")"
		cWhereGW3 += cTipos + ")"

		If !Empty(cWhereGW1)
			cWhereGWF += cWhereGW1
			cWhereGW3 += cWhereGW1
		EndIf

		cWhereGW3 += " AND ((GW3.GW3_TPDF = '1' AND GWU.GWU_SEQ = '01') OR (GW3.GW3_TPDF = '6' AND GWU.GWU_SEQ >= '02') OR GW3.GW3_TPDF NOT IN ('1','6'))"

		cWhereGWF += "%"
		cWhereGW3 += "%"
		cWhereGW1 := "%" + cWhereGW1 + "%"
	Else
		cWhereGWF := "%" + cWhereGW1 + "%"
		cWhereGW3 := "%" + cWhereGW1 + "%"
		cWhereGW1 := "%" + cWhereGW1 + "%"
	EndIf	

	cJoinGU3TRP := "%"
	If MV_PAR12 == 2
		cJoinGU3TRP += "AND GU3TRP.GU3_AUTON = '1'"
	ElseIf MV_PAR12 == 3
		cJoinGU3TRP += "AND GU3TRP.GU3_AUTON = '2'"
	EndIf
	cJoinGU3TRP += "%"

	cCmpRat := "%"
	Do Case
		Case cCriRat == "1"
			cCmpRat += " SUM(GWM.GWM_VLFRET) GWM_VLFRET,"
			cCmpRat += " SUM(GWM.GWM_VLICMS) GWM_VLICMS,"
			cCmpRat += " SUM(GWM.GWM_VLPIS) GWM_VLPIS,"
			cCmpRat += " SUM(GWM.GWM_VLCOFI) GWM_VLCOFI,"
			cCmpRat += " SUM(GWM.GWM_VLISS) GWM_VLISS,"
			cCmpRat += Iif(GFXCP2510("GWM_VLIBS"), " SUM(GWM.GWM_VLISS) GWM_VLIBS,", "")
			cCmpRat += Iif(GFXCP2510("GWM_VLIBM"), " SUM(GWM.GWM_VLIBM) GWM_VLIBM,", "")
			cCmpRat += Iif(GFXCP2510("GWM_VLCBS"), " SUM(GWM.GWM_VLCBS) GWM_VLCBS,", "")
		Case cCriRat == "2"
			cCmpRat += " SUM(GWM.GWM_VLFRE1) GWM_VLFRET,"
			cCmpRat += " SUM(GWM.GWM_VLICM1) GWM_VLICMS,"
			cCmpRat += " SUM(GWM.GWM_VLPIS1) GWM_VLPIS,"
			cCmpRat += " SUM(GWM.GWM_VLCOF1) GWM_VLCOFI,"
			cCmpRat += " SUM(GWM.GWM_VLISS1) GWM_VLISS,"
			cCmpRat += Iif(GFXCP2510("GWM_VLIBS1"), " SUM(GWM.GWM_VLISS1) GWM_VLIBS,", "")
			cCmpRat += Iif(GFXCP2510("GWM_VLIBM1"), " SUM(GWM.GWM_VLIBM1) GWM_VLIBM,", "")
			cCmpRat += Iif(GFXCP2510("GWM_VLCBS1"), " SUM(GWM.GWM_VLCBS1) GWM_VLCBS,", "")
		Case cCriRat == "3"
			cCmpRat += " SUM(GWM.GWM_VLFRE3) GWM_VLFRET,"
			cCmpRat += " SUM(GWM.GWM_VLICM3) GWM_VLICMS,"
			cCmpRat += " SUM(GWM.GWM_VLPIS3) GWM_VLPIS,"
			cCmpRat += " SUM(GWM.GWM_VLCOF3) GWM_VLCOFI,"
			cCmpRat += " SUM(GWM.GWM_VLISS3) GWM_VLISS,"
			cCmpRat += Iif(GFXCP2510("GWM_VLIBS3"), " SUM(GWM.GWM_VLISS3) GWM_VLIBS,", "")
			cCmpRat += Iif(GFXCP2510("GWM_VLIBM3"), " SUM(GWM.GWM_VLIBM3) GWM_VLIBM,", "")
			cCmpRat += Iif(GFXCP2510("GWM_VLCBS3"), " SUM(GWM.GWM_VLCBS3) GWM_VLCBS,", "")
		Case cCriRat == "4"
			cCmpRat += " SUM(GWM.GWM_VLFRE2) GWM_VLFRET,"
			cCmpRat += " SUM(GWM.GWM_VLICM2) GWM_VLICMS,"
			cCmpRat += " SUM(GWM.GWM_VLPIS2) GWM_VLPIS,"
			cCmpRat += " SUM(GWM.GWM_VLCOF2) GWM_VLCOFI,"
			cCmpRat += " SUM(GWM.GWM_VLISS2) GWM_VLISS,"
			cCmpRat += Iif(GFXCP2510("GWM_VLIBS2"), " SUM(GWM.GWM_VLISS2) GWM_VLIBS,", "")
			cCmpRat += Iif(GFXCP2510("GWM_VLIBM2"), " SUM(GWM.GWM_VLIBM2) GWM_VLIBM,", "")
			cCmpRat += Iif(GFXCP2510("GWM_VLCBS2"), " SUM(GWM.GWM_VLCBS2) GWM_VLCBS,", "")
	EndCase
	cCmpRat += "%"

	aGCList := oReport:GetGCList() // Função retorna array com filiais que o usuário tem acesso

	cAliasGW1 := GetNextAlias()

	BeginSQL Alias cAliasGW1
		SELECT GW1.GW1_FILIAL,
			   GW1.GW1_DTEMIS,
			   GW1.GW1_CDTPDC,
			   GW1.GW1_EMISDC,
			   GU3EMIS.GU3_NMEMIT NMEMIS,
			   GW1.GW1_SERDC,
			   GW1.GW1_NRDC,
			   SUM(GW8.GW8_VALOR) GW8_VALOR,
			   SUM(GW8.GW8_PESOR) GW8_PESOR,
			   SUM(GW8.GW8_VOLUME) GW8_VOLUME,
			   GW1.GW1_CDDEST,
			   GU3DES.GU3_NMEMIT NMDES,
			   CASE WHEN GU7A.GU7_NMCID IS NOT NULL THEN GU7A.GU7_NMCID ELSE GU7.GU7_NMCID END AS GU7_NMCID,
     		   CASE WHEN GU7A.GU7_CDUF IS NOT NULL THEN GU7A.GU7_CDUF ELSE GU7.GU7_CDUF END AS GU7_CDUF,
			   GW1.GW1_NRROM,
			   GWU.GWU_CDTRP,
			   GU3TRP.GU3_NMEMIT NMTRP,
			   GW1.GW1_DTSAI,
			   GWU.GWU_DTENT,
			   GWU.GWU_SEQ,
			   GW1.GW1_REGCOM,
			   GW1.GW1_REPRES,
			   GW1.GW1_CDREM,
			   GU3REM.GU3_NMEMIT NMREM,
			   GWN.GWN_CDCLFR,
			   GUB.GUB_DSCLFR,
			   GWN.GWN_CDTPOP,
			   GV4.GV4_DSTPOP,
			   GU7H.GU7_NMCID AS CIDREMET,
			   GU7H.GU7_CDUF AS ESTREMET
		FROM %Table:GW1% GW1
		INNER JOIN %Table:GU3% GU3EMIS
		ON GU3EMIS.GU3_FILIAL = %xFilial:GU3%
		AND GU3EMIS.GU3_CDEMIT = GW1.GW1_EMISDC
		AND GU3EMIS.%NotDel%
		INNER JOIN %Table:GW8% GW8
		ON GW8.GW8_FILIAL = GW1.GW1_FILIAL
		AND GW8.GW8_CDTPDC = GW1.GW1_CDTPDC
		AND GW8.GW8_EMISDC = GW1.GW1_EMISDC
		AND GW8.GW8_SERDC = GW1.GW1_SERDC
		AND GW8.GW8_NRDC = GW1.GW1_NRDC
		AND GW8.%NotDel%
		INNER JOIN %Table:GU3% GU3DES
		ON GU3DES.GU3_FILIAL = %xFilial:GU3%
		AND GU3DES.GU3_CDEMIT = GW1.GW1_CDDEST
		AND GU3DES.%NotDel%
		INNER JOIN %Table:GU3% GU3RE
		ON GU3RE.GU3_FILIAL = %xFilial:GU3%
		AND GU3RE.GU3_CDEMIT = GW1.GW1_CDREM
		AND GU3RE.%NotDel%
		INNER JOIN %Table:GU7% GU7
		ON GU7.GU7_FILIAL = %xFilial:GU7%
		AND GU7.GU7_NRCID = GU3DES.GU3_NRCID
		AND GU7.%NotDel%
		LEFT JOIN %Table:GU7% GU7A
		ON GU7A.GU7_FILIAL = %xFilial:GU7%
		AND GU7A.GU7_NRCID = GW1.GW1_ENTNRC
		AND GU7A.%NotDel%		
		LEFT JOIN %Table:GU7% GU7H
		ON GU7H.GU7_NRCID = GU3RE.GU3_NRCID
		AND GU7H.%NotDel%
		INNER JOIN %Table:GWU% GWU
		ON GWU.GWU_FILIAL = GW1.GW1_FILIAL
		AND GWU.GWU_CDTPDC = GW1.GW1_CDTPDC
		AND GWU.GWU_EMISDC = GW1.GW1_EMISDC
		AND GWU.GWU_SERDC = GW1.GW1_SERDC
		AND GWU.GWU_NRDC = GW1.GW1_NRDC
		AND GWU.%NotDel%
		%Exp:cJoinGWU%
		INNER JOIN %Table:GU3% GU3TRP
		ON GU3TRP.GU3_FILIAL = %xFilial:GU3%
		AND GU3TRP.GU3_CDEMIT = GWU.GWU_CDTRP
		AND GU3TRP.%NotDel%
		%Exp:cJoinGU3TRP%	
		INNER JOIN %Table:GU3% GU3REM
		ON GU3REM.GU3_FILIAL = %xFilial:GU3%
		AND GU3REM.GU3_CDEMIT = GW1.GW1_CDREM
		AND GU3REM.%NotDel%
		LEFT JOIN %Table:GWN% GWN
		ON GWN.GWN_FILIAL = GW1.GW1_FILIAL
		AND GWN.GWN_NRROM = GW1.GW1_NRROM
		AND GWN.%NotDel%
		LEFT JOIN %Table:GUB% GUB
		ON GUB.GUB_FILIAL = %xFilial:GUB%
		AND GUB.GUB_CDCLFR = GWN.GWN_CDCLFR
		AND GUB.%NotDel%
		LEFT JOIN %Table:GV4% GV4
		ON GV4.GV4_FILIAL = %xFilial:GV4%
		AND GV4.GV4_CDTPOP = GWN.GWN_CDTPOP
		AND GV4.%NotDel%	
		WHERE GW1.GW1_DTEMIS >= %Exp:DTOS(MV_PAR01)%
		AND GW1.GW1_DTEMIS <= %Exp:DTOS(MV_PAR02)%
		AND GW1.%NotDel%
		%Exp:cWhereGW1%
		GROUP BY GW1.GW1_FILIAL,
				 GW1.GW1_DTEMIS,
		 		 GW1.GW1_CDTPDC,
		 		 GW1.GW1_EMISDC,
		 		 GU3EMIS.GU3_NMEMIT,
		 		 GW1.GW1_SERDC,
		 		 GW1.GW1_NRDC,
		 		 GW1.GW1_CDDEST,
	     		 GU3DES.GU3_NMEMIT,
		 		 GU7.GU7_NMCID,
		 		 GU7A.GU7_NMCID,
		 		 GU7.GU7_CDUF,
		 		 GU7A.GU7_CDUF,
	     		 GW1.GW1_NRROM,
		 		 GWU.GWU_CDTRP,
		 		 GU3TRP.GU3_NMEMIT,
	     		 GW1.GW1_DTSAI,
	     		 GWU.GWU_DTENT,
				 GWU.GWU_SEQ,
				 GW1.GW1_REGCOM,
				 GW1.GW1_REPRES,
				 GW1.GW1_CDREM,
				 GU3REM.GU3_NMEMIT,
				 GWN.GWN_CDCLFR,
			     GUB.GUB_DSCLFR,
			     GWN.GWN_CDTPOP,
			     GV4.GV4_DSTPOP,
			     GU7H.GU7_NMCID,
			     GU7H.GU7_CDUF
	EndSQL

	aRet := CriaTab()
	cTabTemp := aRet[1]
	oTabTemp := aRet[2]

	dbSelectArea(cTabTemp)
	ZAP

	(cAliasGW1)->(dbGoTop())

	Do While !((cAliasGW1)->(EoF()))
		RecLock(cTabTemp, .T.)
			(cTabTemp)->FILIAL 		:= (cAliasGW1)->GW1_FILIAL
			(cTabTemp)->GW1_DTEMIS 	:= SToD((cAliasGW1)->GW1_DTEMIS)
			(cTabTemp)->GW1_CDTPDC 	:= (cAliasGW1)->GW1_CDTPDC
			(cTabTemp)->GW1_EMISDC 	:= (cAliasGW1)->GW1_EMISDC
			(cTabTemp)->NMEMISNF 	:= (cAliasGW1)->NMEMIS
			(cTabTemp)->GW1_SERDC 	:= (cAliasGW1)->GW1_SERDC
			(cTabTemp)->GW1_NRDC 	:= (cAliasGW1)->GW1_NRDC
			(cTabTemp)->VLR_NF 		:= (cAliasGW1)->GW8_VALOR
			(cTabTemp)->PESO_NF 	:= (cAliasGW1)->GW8_PESOR
			(cTabTemp)->VOLUME_NF 	:= (cAliasGW1)->GW8_VOLUME
			(cTabTemp)->CDDEST 		:= (cAliasGW1)->GW1_CDDEST
			(cTabTemp)->NMDEST 		:= (cAliasGW1)->NMDES
			(cTabTemp)->CIDDEST 	:= (cAliasGW1)->GU7_NMCID
			(cTabTemp)->ESTDEST 	:= (cAliasGW1)->GU7_CDUF
			(cTabTemp)->ROMANEIO 	:= (cAliasGW1)->GW1_NRROM
			(cTabTemp)->CDTRANSP 	:= (cAliasGW1)->GWU_CDTRP
			(cTabTemp)->NMTRANSP 	:= (cAliasGW1)->NMTRP
			(cTabTemp)->DTSAI 		:= SToD((cAliasGW1)->GW1_DTSAI)
			(cTabTemp)->DTENTREG 	:= SToD((cAliasGW1)->GWU_DTENT)
			(cTabTemp)->GW1_REGCOM	:= (cAliasGW1)->GW1_REGCOM
			(cTabTemp)->REPRES		:= (cAliasGW1)->GW1_REPRES
			(cTabTemp)->CDREMET		:= (cAliasGW1)->GW1_CDREM
			(cTabTemp)->NMREMET		:= (cAliasGW1)->NMREM
			(cTabTemp)->GWN_CDCLFR	:= (cAliasGW1)->GWN_CDCLFR
			(cTabTemp)->GUB_DSCLFR	:= (cAliasGW1)->GUB_DSCLFR
			(cTabTemp)->GWN_CDTPOP	:= (cAliasGW1)->GWN_CDTPOP
			(cTabTemp)->GV4_DSTPOP	:= (cAliasGW1)->GV4_DSTPOP
			(cTabTemp)->CIDREMET    := (cAliasGW1)->CIDREMET
			(cTabTemp)->ESTREMET    := (cAliasGW1)->ESTREMET
		(cTabTemp)->(MsUnlock())

		(cAliasGW1)->(dbSkip())
	EndDo	

	(cAliasGW1)->(dbCloseArea())

	cAliasGWF := GetNextAlias()

	BeginSQL Alias cAliasGWF
		SELECT GW1.GW1_FILIAL,
			   GW1.GW1_DTEMIS,
			   GW1.GW1_CDTPDC,
			   GW1.GW1_EMISDC,
			   GU3EMIS.GU3_NMEMIT NMEMIS,
			   GW1.GW1_SERDC,
			   GW1.GW1_NRDC,
			   SUM(GW8.GW8_VALOR) GW8_VALOR,
			   SUM(GW8.GW8_PESOR) GW8_PESOR,
			   SUM(GW8.GW8_VOLUME) GW8_VOLUME,
			   GW1.GW1_CDDEST,
			   GU3DES.GU3_NMEMIT NMDES,
			   GU7.GU7_NMCID,
			   GU7.GU7_CDUF,
			   GW1.GW1_NRROM,
			   GWU.GWU_CDTRP,
			   GWU.GWU_SEQ,
			   GU3TRP.GU3_NMEMIT NMTRP,
			   GW1.GW1_DTSAI,
			   GWU.GWU_DTENT,
			   GW1.GW1_REGCOM,
			   GW1.GW1_REPRES,
			   GW1.GW1_CDREM,
			   GU3REM.GU3_NMEMIT NMREM,
			   GWF.GWF_TPCALC,
			   GWF.GWF_NRCALC, 
			   GWF.GWF_CRDICM,
			   GWF.GWF_CRDPC,
			   %Exp:cCmpRat%
			   GWF.GWF_CDESP,
			   GWF.GWF_EMISDF,
			   GWF.GWF_SERDF,
			   GWF.GWF_NRDF,
			   GWF.GWF_DTEMDF,
			   GWJ.GWJ_NRPF,
			   GWJ.GWJ_DTIMPL,
			   GWJ.GWJ_SITFIN,
			   GWJ.GWJ_DTFIN,
			   GWJ.GWJ_SIT,
			   GXE.GXE_CODLOT,
			   GXE.GXE_DTCRIA,
			   GXE.GXE_SIT,
			   GXE.GXE_DTSIT,
			   GW2.GW2_NRCONT,
			   GW2.GW2_DTCRIA,
			   GW2.GW2_SITFIN,
			   GW2.GW2_DTFIN,
			   GU3GWM.GU3_CDEMIT CDTRPGWM,
			   GU3GWM.GU3_NMEMIT NMTRPGWM,
			   GWN.GWN_CDCLFR,
			   GUB.GUB_DSCLFR,
			   GWN.GWN_CDTPOP,
			   GV4.GV4_DSTPOP,
			   GU7H.GU7_NMCID AS CIDREMET,
			   GU7H.GU7_CDUF AS ESTREMET
		FROM %Table:GW1% GW1
		INNER JOIN %Table:GU3% GU3EMIS
		ON GU3EMIS.GU3_FILIAL = %xFilial:GU3%
		AND GU3EMIS.GU3_CDEMIT = GW1.GW1_EMISDC
		AND GU3EMIS.%NotDel%
		INNER JOIN %Table:GW8% GW8
		ON GW8.GW8_FILIAL = GW1.GW1_FILIAL
		AND GW8.GW8_CDTPDC = GW1.GW1_CDTPDC
		AND GW8.GW8_EMISDC = GW1.GW1_EMISDC
		AND GW8.GW8_SERDC = GW1.GW1_SERDC
		AND GW8.GW8_NRDC = GW1.GW1_NRDC
		AND GW8.%NotDel%
		INNER JOIN %Table:GU3% GU3DES
		ON GU3DES.GU3_FILIAL = %xFilial:GU3%
		AND GU3DES.GU3_CDEMIT = GW1.GW1_CDDEST
		AND GU3DES.%NotDel%
		INNER JOIN %Table:GU3% GU3RE
		ON GU3RE.GU3_FILIAL = %xFilial:GU3%
		AND GU3RE.GU3_CDEMIT = GW1.GW1_CDREM
		AND GU3RE.%NotDel%
		INNER JOIN %Table:GU7% GU7
		ON GU7.GU7_FILIAL = %xFilial:GU7%
		AND GU7.GU7_NRCID = GU3DES.GU3_NRCID
		AND GU7.%NotDel%
		LEFT JOIN %Table:GU7% GU7H
		ON GU7H.GU7_NRCID = GU3RE.GU3_NRCID
		AND GU7H.%NotDel%
		INNER JOIN %Table:GWU% GWU
		ON GWU.GWU_FILIAL = GW1.GW1_FILIAL
		AND GWU.GWU_CDTPDC = GW1.GW1_CDTPDC
		AND GWU.GWU_EMISDC = GW1.GW1_EMISDC
		AND GWU.GWU_SERDC = GW1.GW1_SERDC
		AND GWU.GWU_NRDC = GW1.GW1_NRDC
		AND GWU.%NotDel%
		%Exp:cJoinGWU%
		INNER JOIN %Table:GU3% GU3TRP
		ON GU3TRP.GU3_FILIAL = %xFilial:GU3%
		AND GU3TRP.GU3_CDEMIT = GWU.GWU_CDTRP
		AND GU3TRP.%NotDel%
		%Exp:cJoinGU3TRP%	
		INNER JOIN %Table:GU3% GU3REM
		ON GU3REM.GU3_FILIAL = %xFilial:GU3%
		AND GU3REM.GU3_CDEMIT = GW1.GW1_CDREM
		AND GU3REM.%NotDel%		
		LEFT JOIN %Table:GWN% GWN
		ON GWN.GWN_FILIAL = GW1.GW1_FILIAL
		AND GWN.GWN_NRROM = GW1.GW1_NRROM
		AND GWN.%NotDel%
		LEFT JOIN %Table:GUB% GUB
		ON GUB.GUB_FILIAL = %xFilial:GUB%
		AND GUB.GUB_CDCLFR = GWN.GWN_CDCLFR
		AND GUB.%NotDel%
		LEFT JOIN %Table:GV4% GV4
		ON GV4.GV4_FILIAL = %xFilial:GV4%
		AND GV4.GV4_CDTPOP = GWN.GWN_CDTPOP
		AND GV4.%NotDel%
		INNER JOIN %Table:GWH% GWH
		ON GWH.GWH_FILIAL = GW1.GW1_FILIAL
		AND GWH.GWH_CDTPDC = GW1.GW1_CDTPDC
		AND GWH.GWH_EMISDC = GW1.GW1_EMISDC
		AND GWH.GWH_SERDC = GW1.GW1_SERDC
		AND GWH.GWH_NRDC = GW1.GW1_NRDC
		AND GWH.GWH_TRECHO = GWU.GWU_SEQ
		AND GWH.%NotDel%
		INNER JOIN %Table:GWF% GWF
		ON GWF.GWF_FILIAL = GWH.GWH_FILIAL
		AND GWF.GWF_NRCALC = GWH.GWH_NRCALC
		AND GWF.%NotDel%
		INNER JOIN %Table:GWM% GWM
		ON GWM.GWM_FILIAL = GW1.GW1_FILIAL
		AND GWM.GWM_CDTPDC = GW1.GW1_CDTPDC
		AND GWM.GWM_EMISDC = GW1.GW1_EMISDC
		AND GWM.GWM_SERDC = GW1.GW1_SERDC
		AND GWM.GWM_NRDC = GW1.GW1_NRDC
		AND GWM.GWM_SEQGW8 = GW8.GW8_SEQ
		AND GWM.GWM_TPDOC = '1'
		AND GWM.GWM_NRDOC = GWF.GWF_NRCALC
		AND GWM.%NotDel%
		INNER JOIN %Table:GU3% GU3GWM
		ON GU3GWM.GU3_FILIAL = %xFilial:GU3%
		AND GU3GWM.GU3_CDEMIT = GWM.GWM_CDTRP
		AND GU3GWM.%NotDel%
		LEFT JOIN %Table:GWJ% GWJ
		ON GWJ.GWJ_FILIAL = GWF.GWF_FILPRE
		AND GWJ.GWJ_NRPF = GWF.GWF_NRPREF
		AND GWJ.%NotDel%
		LEFT JOIN %Table:GXD% GXD
		ON GXD.GXD_FILIAL = GWF.GWF_FILIAL
		AND GXD.GXD_NRCALC = GWF.GWF_NRCALC
		AND GXD.%NotDel%
		LEFT JOIN %Table:GXE% GXE
		ON GXE.GXE_FILIAL = GXD.GXD_FILIAL
		AND GXE.GXE_CODLOT = GXD.GXD_CODLOT
		AND GXE.%NotDel%
		LEFT JOIN %Table:GW2% GW2
		ON GW2.GW2_FILIAL = GWF.GWF_FILIAL
		AND GW2.GW2_NRCONT = GWF.GWF_NRCONT
		AND GW2.%NotDel%
		WHERE GW1.GW1_DTEMIS >= %Exp:DTOS(MV_PAR01)%
		AND GW1.GW1_DTEMIS <= %Exp:DTOS(MV_PAR02)%
		AND GW1.%NotDel%
		%Exp:cWhereGWF%
		GROUP BY GW1.GW1_FILIAL,
				 GW1.GW1_DTEMIS,
		 		 GW1.GW1_CDTPDC,
		 		 GW1.GW1_EMISDC,
		 		 GU3EMIS.GU3_NMEMIT,
		 		 GW1.GW1_SERDC,
		 		 GW1.GW1_NRDC,
		 		 GW1.GW1_CDDEST,
	     		 GU3DES.GU3_NMEMIT,
		 		 GU7.GU7_NMCID,
		 		 GU7.GU7_CDUF,
	     		 GW1.GW1_NRROM,
		 		 GWU.GWU_CDTRP,
		 		 GU3TRP.GU3_NMEMIT,
	     		 GW1.GW1_DTSAI,
	     		 GWU.GWU_DTENT,
				 GWU.GWU_SEQ,
				 GW1.GW1_REGCOM,
				 GW1.GW1_REPRES,
				 GW1.GW1_CDREM,
				 GU3REM.GU3_NMEMIT,
				 GWF.GWF_TPCALC,
		  	     GWF.GWF_NRCALC,
				 GWF.GWF_CRDICM,
				 GWF.GWF_CRDPC,
				 GWF.GWF_CDESP,
			   	 GWF.GWF_EMISDF,
			     GWF.GWF_SERDF,
			     GWF.GWF_NRDF,
			     GWF.GWF_DTEMDF,
				 GWJ.GWJ_NRPF,
			   	 GWJ.GWJ_DTIMPL,
			   	 GWJ.GWJ_SITFIN,
			     GWJ.GWJ_DTFIN,
			     GWJ.GWJ_SIT,
			     GXE.GXE_CODLOT,
			     GXE.GXE_DTCRIA,
			     GXE.GXE_SIT,
			     GXE.GXE_DTSIT,
			     GW2.GW2_NRCONT,
				 GW2.GW2_DTCRIA,
				 GW2.GW2_SITFIN,
				 GW2.GW2_DTFIN,
				 GU3GWM.GU3_CDEMIT,
			     GU3GWM.GU3_NMEMIT,
				 GWN.GWN_CDCLFR,
			     GUB.GUB_DSCLFR,
			     GWN.GWN_CDTPOP,
			     GV4.GV4_DSTPOP,
			     GU7H.GU7_NMCID,
			     GU7H.GU7_CDUF
	EndSQL

	(cAliasGWF)->(dbGoTop())

	Do While !((cAliasGWF)->(EoF()))
		(cTabTemp)->(dbSetOrder(1))
		If (cTabTemp)->(dbSeek((cAliasGWF)->GW1_FILIAL+(cAliasGWF)->GW1_CDTPDC+(cAliasGWF)->GW1_EMISDC+;
							   (cAliasGWF)->GW1_SERDC+(cAliasGWF)->GW1_NRDC+(cAliasGWF)->GW1_DTEMIS))
			If Empty((cTabTemp)->TPFRETE )
				RecLock(cTabTemp,.F.)
					(cTabTemp)->TPFRETE 	:= (cAliasGWF)->GWF_TPCALC
					(cTabTemp)->VLFRETRAT 	:= (cAliasGWF)->GWM_VLFRET
					(cTabTemp)->NRDOCRAT 	:= (cAliasGWF)->GWF_NRCALC
					(cTabTemp)->VLICMSRAT 	:= (cAliasGWF)->GWM_VLICMS
					(cTabTemp)->CRDICMS 	:= (cAliasGWF)->GWF_CRDICM
					(cTabTemp)->VLPISRAT 	:= (cAliasGWF)->GWM_VLPIS
					(cTabTemp)->VLCOFIRAT 	:= (cAliasGWF)->GWM_VLCOFI
					(cTabTemp)->CRDPC 		:= (cAliasGWF)->GWF_CRDPC
					(cTabTemp)->VLISSRAT 	:= (cAliasGWF)->GWM_VLISS
					(cTabTemp)->CDTRANSP	:= (cAliasGWF)->CDTRPGWM
			   		(cTabTemp)->NMTRANSP	:= (cAliasGWF)->NMTRPGWM				
					
					(cTabTemp)->VLIBSRAT 	:= Iif(GFXCP2510("GWM_VLIBS"), (cAliasGWF)->GWM_VLIBS, 0)
					(cTabTemp)->VLIBMRAT 	:= Iif(GFXCP2510("GWM_VLIBM"), (cAliasGWF)->GWM_VLIBM, 0)
					(cTabTemp)->VLCBSRAT 	:= Iif(GFXCP2510("GWM_VLCBS"), (cAliasGWF)->GWM_VLCBS, 0)
						
					If !Empty((cAliasGWF)->GWF_NRDF)
						(cTabTemp)->GW3_CDESP	:= (cAliasGWF)->GWF_CDESP
						(cTabTemp)->GW3_EMISDF	:= (cAliasGWF)->GWF_EMISDF
						(cTabTemp)->GW3_SERDF	:= (cAliasGWF)->GWF_SERDF
						(cTabTemp)->NRDOCFRE	:= (cAliasGWF)->GWF_NRDF
						(cTabTemp)->GW3_DTEMIS	:= SToD((cAliasGWF)->GWF_DTEMDF)
					ElseIf !Empty((cAliasGWF)->GW2_NRCONT)
						(cTabTemp)->NRDOCFRE	:= (cAliasGWF)->GW2_NRCONT
						(cTabTemp)->GW3_DTEMIS	:= SToD((cAliasGWF)->GW2_DTCRIA)
						(cTabTemp)->TPDOCCOB	:= "Contrato"
						(cTabTemp)->DOCCOBRAN	:= (cAliasGWF)->GW2_NRCONT
						(cTabTemp)->DTEMICOB	:= SToD((cAliasGWF)->GW2_DTCRIA)
						(cTabTemp)->SITFINCOB	:= (cAliasGWF)->GW2_SITFIN
						(cTabTemp)->DTATUCOB	:= SToD((cAliasGWF)->GW2_DTFIN)
					EndIf
						
					If !Empty((cAliasGWF)->GWJ_NRPF)
						(cTabTemp)->TPPROVIS	:= "Pré-Fatura"
						(cTabTemp)->NRDOCPROV	:= (cAliasGWF)->GWJ_NRPF
						(cTabTemp)->DTEMIPROV	:= SToD((cAliasGWF)->GWJ_DTIMPL)
						(cTabTemp)->SITFINPROV	:= (cAliasGWF)->GWJ_SITFIN
						(cTabTemp)->DTATUPROV	:= SToD((cAliasGWF)->GWJ_DTFIN)
						(cTabTemp)->SITPREFAT	:= (cAliasGWF)->GWJ_SIT
					ElseIf !Empty((cAliasGWF)->GXE_CODLOT)
						(cTabTemp)->TPPROVIS	:= "Lote de Provisão"
						(cTabTemp)->NRDOCPROV	:= (cAliasGWF)->GXE_CODLOT
						(cTabTemp)->DTEMIPROV	:= SToD((cAliasGWF)->GXE_DTCRIA)
						(cTabTemp)->SITFINPROV	:= (cAliasGWF)->GXE_SIT
						(cTabTemp)->DTATUPROV	:= SToD((cAliasGWF)->GXE_DTSIT)
					EndIf
				(cTabTemp)->(MsUnlock())
			Else
				RecLock(cTabTemp, .T.)
					(cTabTemp)->FILIAL 		:= (cAliasGWF)->GW1_FILIAL
					(cTabTemp)->GW1_DTEMIS 	:= SToD((cAliasGWF)->GW1_DTEMIS)
					(cTabTemp)->GW1_CDTPDC 	:= (cAliasGWF)->GW1_CDTPDC
					(cTabTemp)->GW1_EMISDC 	:= (cAliasGWF)->GW1_EMISDC
					(cTabTemp)->NMEMISNF 	:= (cAliasGWF)->NMEMIS
					(cTabTemp)->GW1_SERDC 	:= (cAliasGWF)->GW1_SERDC
					(cTabTemp)->GW1_NRDC 	:= (cAliasGWF)->GW1_NRDC
					(cTabTemp)->VLR_NF 		:= (cAliasGWF)->GW8_VALOR
					(cTabTemp)->PESO_NF 	:= (cAliasGWF)->GW8_PESOR
					(cTabTemp)->VOLUME_NF 	:= (cAliasGWF)->GW8_VOLUME
					(cTabTemp)->CDDEST 		:= (cAliasGWF)->GW1_CDDEST
					(cTabTemp)->NMDEST 		:= (cAliasGWF)->NMDES
					(cTabTemp)->CIDDEST 	:= (cAliasGWF)->GU7_NMCID
					(cTabTemp)->ESTDEST 	:= (cAliasGWF)->GU7_CDUF
					(cTabTemp)->ROMANEIO 	:= (cAliasGWF)->GW1_NRROM
					(cTabTemp)->CDTRANSP	:= (cAliasGWF)->CDTRPGWM
			   		(cTabTemp)->NMTRANSP	:= (cAliasGWF)->NMTRPGWM
					(cTabTemp)->DTSAI 		:= SToD((cAliasGWF)->GW1_DTSAI)
					(cTabTemp)->DTENTREG 	:= SToD((cAliasGWF)->GWU_DTENT)
					(cTabTemp)->GW1_REGCOM	:= (cAliasGWF)->GW1_REGCOM
					(cTabTemp)->REPRES		:= (cAliasGWF)->Gw1_REPRES
					(cTabTemp)->CDREMET		:= (cAliasGWF)->GW1_CDREM
					(cTabTemp)->NMREMET		:= (cAliasGWF)->NMREM
					(cTabTemp)->GWN_CDCLFR	:= (cAliasGWF)->GWN_CDCLFR
					(cTabTemp)->GUB_DSCLFR	:= (cAliasGWF)->GUB_DSCLFR
					(cTabTemp)->GWN_CDTPOP	:= (cAliasGWF)->GWN_CDTPOP
					(cTabTemp)->GV4_DSTPOP	:= (cAliasGWF)->GV4_DSTPOP
					(cTabTemp)->TPFRETE 	:= (cAliasGWF)->GWF_TPCALC
					(cTabTemp)->VLFRETRAT 	:= (cAliasGWF)->GWM_VLFRET
					(cTabTemp)->NRDOCRAT 	:= (cAliasGWF)->GWF_NRCALC
					(cTabTemp)->VLICMSRAT 	:= (cAliasGWF)->GWM_VLICMS
					(cTabTemp)->CRDICMS 	:= (cAliasGWF)->GWF_CRDICM
					(cTabTemp)->VLPISRAT 	:= (cAliasGWF)->GWM_VLPIS
					(cTabTemp)->VLCOFIRAT 	:= (cAliasGWF)->GWM_VLCOFI
					(cTabTemp)->CRDPC 		:= (cAliasGWF)->GWF_CRDPC
					(cTabTemp)->VLISSRAT 	:= (cAliasGWF)->GWM_VLISS
					(cTabTemp)->CIDREMET    := (cAliasGWF)->CIDREMET
					(cTabTemp)->ESTREMET    := (cAliasGWF)->ESTREMET

					(cTabTemp)->VLIBSRAT 	:= Iif(GFXCP2510("GWM_VLIBS"), (cAliasGWF)->GWM_VLIBS, 0)
					(cTabTemp)->VLIBMRAT 	:= Iif(GFXCP2510("GWM_VLIBM"), (cAliasGWF)->GWM_VLIBM, 0)
					(cTabTemp)->VLCBSRAT 	:= Iif(GFXCP2510("GWM_VLCBS"), (cAliasGWF)->GWM_VLCBS, 0)
						
					If !Empty((cAliasGWF)->GWF_NRDF)
						(cTabTemp)->GW3_CDESP	:= (cAliasGWF)->GWF_CDESP
						(cTabTemp)->GW3_EMISDF	:= (cAliasGWF)->GWF_EMISDF
						(cTabTemp)->GW3_SERDF	:= (cAliasGWF)->GWF_SERDF
						(cTabTemp)->NRDOCFRE	:= (cAliasGWF)->GWF_NRDF
						(cTabTemp)->GW3_DTEMIS	:= SToD((cAliasGWF)->GWF_DTEMDF)
					ElseIf !Empty((cAliasGWF)->GW2_NRCONT)
						(cTabTemp)->GW3_DTEMIS	:= SToD((cAliasGWF)->GW2_DTCRIA)
						(cTabTemp)->TPDOCCOB	:= "Contrato"
						(cTabTemp)->DOCCOBRAN	:= (cAliasGWF)->GW2_NRCONT
						(cTabTemp)->DTEMICOB	:= SToD((cAliasGWF)->GW2_DTCRIA)
						(cTabTemp)->SITFINCOB	:= (cAliasGWF)->GW2_SITFIN
						(cTabTemp)->DTATUCOB	:= SToD((cAliasGWF)->GW2_DTFIN)
					EndIf
						
					If !Empty((cAliasGWF)->GWJ_NRPF)
						(cTabTemp)->TPPROVIS	:= "Pré-Fatura"
						(cTabTemp)->NRDOCPROV	:= (cAliasGWF)->GWJ_NRPF
						(cTabTemp)->DTEMIPROV	:= SToD((cAliasGWF)->GWJ_DTIMPL)
						(cTabTemp)->SITFINPROV	:= (cAliasGWF)->GWJ_SITFIN
						(cTabTemp)->DTATUPROV	:= SToD((cAliasGWF)->GWJ_DTFIN)
						(cTabTemp)->SITPREFAT	:= (cAliasGWF)->GWJ_SIT
					ElseIf !Empty((cAliasGWF)->GXE_CODLOT)
						(cTabTemp)->TPPROVIS	:= "Lote de Provisão"
						(cTabTemp)->NRDOCPROV	:= (cAliasGWF)->GXE_CODLOT
						(cTabTemp)->DTEMIPROV	:= SToD((cAliasGWF)->GXE_DTCRIA)
						(cTabTemp)->SITFINPROV	:= (cAliasGWF)->GXE_SIT
						(cTabTemp)->DTATUPROV	:= SToD((cAliasGWF)->GXE_DTSIT)
					EndIf
				(cTabTemp)->(MsUnlock())
			EndIf
		EndIf

		(cAliasGWF)->(dbSkip())
	EndDo

	(cAliasGWF)->(dbCloseArea())

	cAliasGW3 := GetNextAlias()

	BeginSQL Alias cAliasGW3
		SELECT GW1.GW1_FILIAL,
			   GW1.GW1_DTEMIS,
			   GW1.GW1_CDTPDC,
			   GW1.GW1_EMISDC,
			   GU3EMIS.GU3_NMEMIT NMEMIS,
			   GW1.GW1_SERDC,
			   GW1.GW1_NRDC,
			   SUM(GW8.GW8_VALOR) GW8_VALOR,
			   SUM(GW8.GW8_PESOR) GW8_PESOR,
			   SUM(GW8.GW8_VOLUME) GW8_VOLUME,
			   GW1.GW1_CDDEST,
			   GU3DES.GU3_NMEMIT NMDES,
			   GU7.GU7_NMCID,
			   GU7.GU7_CDUF,
			   GW1.GW1_NRROM,
			   GWU.GWU_CDTRP,
			   GU3TRP.GU3_NMEMIT NMTRP,
			   GW1.GW1_DTSAI,
			   GWU.GWU_DTENT,
			   GWU.GWU_SEQ,
			   GW1.GW1_REGCOM,
			   GW1.GW1_REPRES,
			   GW1.GW1_CDREM,
			   GU3REM.GU3_NMEMIT NMREM,
			   GW3.GW3_CDESP,
			   GW3.GW3_EMISDF,
			   GW3.GW3_SERDF,
			   GW3.GW3_NRDF,
			   GW3.GW3_DTEMIS,
			   GW3.GW3_DTENT,
			   GW3.GW3_SITFIS,
			   GW3.GW3_DTFIS,
			   GW3.GW3_CRDICM,
			   GW3.GW3_CRDPC,
			   %Exp:cCmpRat%
			   GW3.GW3_CDTPSE,
			   GVU.GVU_DSTPSE,
			   GW6.GW6_NRFAT,
			   GW6.GW6_DTEMIS,
			   GW6.GW6_SITFIN,
			   GW6.GW6_DTFIN,
			   GW3.GW3_TPDF,
			   GU3GWM.GU3_CDEMIT CDTRPGWM,
			   GU3GWM.GU3_NMEMIT NMTRPGWM,
			   GWN.GWN_CDCLFR,
			   GUB.GUB_DSCLFR,
			   GWN.GWN_CDTPOP,
			   GV4.GV4_DSTPOP,
			   GU7H.GU7_NMCID AS CIDREMET,
			   GU7H.GU7_CDUF AS ESTREMET
		FROM %Table:GW1% GW1
		INNER JOIN %Table:GU3% GU3EMIS
		ON GU3EMIS.GU3_FILIAL = %xFilial:GU3%
		AND GU3EMIS.GU3_CDEMIT = GW1.GW1_EMISDC
		AND GU3EMIS.%NotDel%
		INNER JOIN %Table:GW8% GW8
		ON GW8.GW8_FILIAL = GW1.GW1_FILIAL
		AND GW8.GW8_CDTPDC = GW1.GW1_CDTPDC
		AND GW8.GW8_EMISDC = GW1.GW1_EMISDC
		AND GW8.GW8_SERDC = GW1.GW1_SERDC
		AND GW8.GW8_NRDC = GW1.GW1_NRDC
		AND GW8.%NotDel%
		INNER JOIN %Table:GU3% GU3DES
		ON GU3DES.GU3_FILIAL = %xFilial:GU3%
		AND GU3DES.GU3_CDEMIT = GW1.GW1_CDDEST
		AND GU3DES.%NotDel%
		INNER JOIN %Table:GU3% GU3RE
		ON GU3RE.GU3_FILIAL = %xFilial:GU3%
		AND GU3RE.GU3_CDEMIT = GW1.GW1_CDREM
		AND GU3RE.%NotDel%
		INNER JOIN %Table:GU7% GU7
		ON GU7.GU7_FILIAL = %xFilial:GU7%
		AND GU7.GU7_NRCID = GU3DES.GU3_NRCID
		AND GU7.%NotDel%
		LEFT JOIN %Table:GU7% GU7H
		ON GU7H.GU7_NRCID = GU3RE.GU3_NRCID
		AND GU7H.%NotDel%
		INNER JOIN %Table:GWU% GWU
		ON GWU.GWU_FILIAL = GW1.GW1_FILIAL
		AND GWU.GWU_CDTPDC = GW1.GW1_CDTPDC
		AND GWU.GWU_EMISDC = GW1.GW1_EMISDC
		AND GWU.GWU_SERDC = GW1.GW1_SERDC
		AND GWU.GWU_NRDC = GW1.GW1_NRDC
		AND GWU.%NotDel%
		%Exp:cJoinGWU%
		INNER JOIN %Table:GU3% GU3TRP
		ON GU3TRP.GU3_FILIAL = %xFilial:GU3%
		AND GU3TRP.GU3_CDEMIT = GWU.GWU_CDTRP
		AND GU3TRP.%NotDel%
		%Exp:cJoinGU3TRP%	
		INNER JOIN %Table:GU3% GU3REM
		ON GU3REM.GU3_FILIAL = %xFilial:GU3%
		AND GU3REM.GU3_CDEMIT = GW1.GW1_CDREM
		AND GU3REM.%NotDel%		
		LEFT JOIN %Table:GWN% GWN
		ON GWN.GWN_FILIAL = GW1.GW1_FILIAL
		AND GWN.GWN_NRROM = GW1.GW1_NRROM
		AND GWN.%NotDel%
		LEFT JOIN %Table:GUB% GUB
		ON GUB.GUB_FILIAL = %xFilial:GUB%
		AND GUB.GUB_CDCLFR = GWN.GWN_CDCLFR
		AND GUB.%NotDel%
		LEFT JOIN %Table:GV4% GV4
		ON GV4.GV4_FILIAL = %xFilial:GV4%
		AND GV4.GV4_CDTPOP = GWN.GWN_CDTPOP
		AND GV4.%NotDel%
		INNER JOIN %Table:GW4% GW4
		ON GW4.GW4_FILIAL = GW1.GW1_FILIAL
		AND GW4.GW4_EMISDC = GW1.GW1_EMISDC
		AND GW4.GW4_SERDC = GW1.GW1_SERDC
		AND GW4.GW4_NRDC = GW1.GW1_NRDC
		AND GW4.GW4_TPDC = GW1.GW1_CDTPDC
		AND GW4.%NotDel%
		INNER JOIN %Table:GW3% GW3
		ON GW3.GW3_FILIAL = GW4.GW4_FILIAL
		AND GW3.GW3_CDESP = GW4.GW4_CDESP
		AND GW3.GW3_EMISDF = GW4.GW4_EMISDF
		AND GW3.GW3_SERDF = GW4.GW4_SERDF
		AND GW3.GW3_NRDF = GW4.GW4_NRDF
		AND GW3.GW3_DTEMIS = GW4.GW4_DTEMIS
		AND GW3.%NotDel%
		INNER JOIN %Table:GWM% GWM
		ON GWM.GWM_FILIAL = GW1.GW1_FILIAL
		AND GWM.GWM_CDTPDC = GW1.GW1_CDTPDC
		AND GWM.GWM_EMISDC = GW1.GW1_EMISDC
		AND GWM.GWM_SERDC = GW1.GW1_SERDC
		AND GWM.GWM_NRDC = GW1.GW1_NRDC
		AND GWM.GWM_SEQGW8 = GW8.GW8_SEQ
		AND GWM.GWM_TPDOC = '2'
		AND GWM.GWM_NRDOC = GW3.GW3_NRDF
		AND GWM.%NotDel%
		INNER JOIN %Table:GU3% GU3GWM
		ON GU3GWM.GU3_FILIAL = %xFilial:GU3%
		AND GU3GWM.GU3_CDEMIT = GWM.GWM_CDTRP
		AND GU3GWM.%NotDel%
		LEFT JOIN %Table:GVU% GVU
		ON GVU.GVU_FILIAL = %xFilial:GVU%
		AND GVU.GVU_CDTPSE = GW3.GW3_CDTPSE
		AND GVU.%NotDel%
		LEFT JOIN %Table:GW6% GW6
		ON GW6.GW6_FILIAL = GW3.GW3_FILFAT
		AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT
		AND GW6.GW6_SERFAT = GW3.GW3_SERFAT
		AND GW6.GW6_NRFAT = GW3.GW3_NRFAT
		AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA
		AND GW6.%NotDel%
		WHERE GW1.GW1_DTEMIS >= %Exp:DTOS(MV_PAR01)%
		AND GW1.GW1_DTEMIS <= %Exp:DTOS(MV_PAR02)%
		AND GW1.%NotDel%
		%Exp:cWhereGW3%
		GROUP BY GW1.GW1_FILIAL,
				 GW1.GW1_DTEMIS,
		 		 GW1.GW1_CDTPDC,
		 		 GW1.GW1_EMISDC,
		 		 GU3EMIS.GU3_NMEMIT,
		 		 GW1.GW1_SERDC,
		 		 GW1.GW1_NRDC,
		 		 GW1.GW1_CDDEST,
	     		 GU3DES.GU3_NMEMIT,
		 		 GU7.GU7_NMCID,
		 		 GU7.GU7_CDUF,
	     		 GW1.GW1_NRROM,
		 		 GWU.GWU_CDTRP,
		 		 GU3TRP.GU3_NMEMIT,
	     		 GW1.GW1_DTSAI,
	     		 GWU.GWU_DTENT,
				 GWU.GWU_SEQ,
				 GW1.GW1_REGCOM,
				 GW1.GW1_REPRES,
				 GW1.GW1_CDREM,
				 GU3REM.GU3_NMEMIT,
				 GW3.GW3_CDESP,
			   	 GW3.GW3_EMISDF,
			     GW3.GW3_SERDF,
			     GW3.GW3_NRDF,
			     GW3.GW3_DTEMIS,
			     GW3.GW3_DTENT,
			     GW3.GW3_SITFIS,
			     GW3.GW3_DTFIS,
			     GW3.GW3_CRDICM,
			     GW3.GW3_CRDPC,
			     GW3.GW3_CDTPSE,
			     GVU.GVU_DSTPSE,
				 GW6.GW6_NRFAT,
				 GW6.GW6_DTEMIS,
				 GW6.GW6_SITFIN,
				 GW6.GW6_DTFIN,
				 GW3.GW3_TPDF,
				 GU3GWM.GU3_CDEMIT,
			     GU3GWM.GU3_NMEMIT,
				 GWN.GWN_CDCLFR,
			     GUB.GUB_DSCLFR,
			     GWN.GWN_CDTPOP,
			     GV4.GV4_DSTPOP,
			     GU7H.GU7_NMCID,
			     GU7H.GU7_CDUF
	EndSQL

	(cAliasGW3)->(dbGoTop())

	While (cAliasGW3)->(!EoF())
		(cTabTemp)->(dbSetOrder(2))
		If (cTabTemp)->(dbSeek((cAliasGW3)->GW1_FILIAL+(cAliasGW3)->GW1_CDTPDC+(cAliasGW3)->GW1_EMISDC+;
							   (cAliasGW3)->GW1_SERDC+(cAliasGW3)->GW1_NRDC+(cAliasGW3)->GW1_DTEMIS+;
							   (cAliasGW3)->GW3_NRDF+(cAliasGW3)->GW3_CDESP+(cAliasGW3)->GW3_EMISDF+(cAliasGW3)->GW3_SERDF))
		
			RecLock(cTabTemp,.F.)
				(cTabTemp)->VLCTRC		:= (cAliasGW3)->GWM_VLFRET
				(cTabTemp)->VLICMSFRE	:= (cAliasGW3)->GWM_VLICMS
				(cTabTemp)->VLPISFRE	:= (cAliasGW3)->GWM_VLPIS
				(cTabTemp)->VLCOFIFRE	:= (cAliasGW3)->GWM_VLCOFI
				(cTabTemp)->VLISSFRE	:= (cAliasGW3)->GWM_VLISS
				(cTabTemp)->GW3_DTENT 	:= SToD((cAliasGW3)->GW3_DTENT)
				(cTabTemp)->GW3_SITFIS 	:= (cAliasGW3)->GW3_SITFIS
				(cTabTemp)->GW3_DTFIS 	:= SToD((cAliasGW3)->GW3_DTFIS)
				(cTabTemp)->GW3_CRDICM 	:= (cAliasGW3)->GW3_CRDICM
				(cTabTemp)->GW3_CRDPC 	:= (cAliasGW3)->GW3_CRDPC
				(cTabTemp)->GW3_CDTPSE 	:= (cAliasGW3)->GW3_CDTPSE
				(cTabTemp)->GVU_DSTPSE 	:= (cAliasGW3)->GVU_DSTPSE

				(cTabTemp)->VLIBSFRE 	:= Iif(GFXCP2510("GWM_VLIBS"), (cAliasGW3)->GWM_VLIBS, 0)
				(cTabTemp)->VLIBMFRE 	:= Iif(GFXCP2510("GWM_VLIBM"), (cAliasGW3)->GWM_VLIBM, 0)
				(cTabTemp)->VLCBSFRE 	:= Iif(GFXCP2510("GWM_VLCBS"), (cAliasGW3)->GWM_VLCBS, 0)

				If !Empty((cAliasGW3)->GW6_NRFAT)
					(cTabTemp)->TPDOCCOB	:= "Fatura"
					(cTabTemp)->DOCCOBRAN	:= (cAliasGW3)->GW6_NRFAT
					(cTabTemp)->DTEMICOB	:= SToD((cAliasGW3)->GW6_DTEMIS)
					(cTabTemp)->SITFINCOB	:= (cAliasGW3)->GW6_SITFIN
					(cTabTemp)->DTATUCOB	:= SToD((cAliasGW3)->GW6_DTFIN)
				EndIf
			(cTabTemp)->(MsUnlock())
		Else
			(cTabTemp)->(dbSetOrder(1))
			If (cTabTemp)->(dbSeek((cAliasGW3)->GW1_FILIAL+(cAliasGW3)->GW1_CDTPDC+(cAliasGW3)->GW1_EMISDC+;
								   (cAliasGW3)->GW1_SERDC+(cAliasGW3)->GW1_NRDC+(cAliasGW3)->GW1_DTEMIS+(cAliasGW3)->GW3_TPDF))
				If Empty((cTabTemp)->NRDOCFRE)				
					RecLock(cTabTemp,.F.)
						(cTabTemp)->VLCTRC		:= (cAliasGW3)->GWM_VLFRET
						(cTabTemp)->VLICMSFRE	:= (cAliasGW3)->GWM_VLICMS
						(cTabTemp)->VLPISFRE	:= (cAliasGW3)->GWM_VLPIS
						(cTabTemp)->VLCOFIFRE	:= (cAliasGW3)->GWM_VLCOFI
						(cTabTemp)->VLISSFRE	:= (cAliasGW3)->GWM_VLISS
						(cTabTemp)->GW3_DTENT 	:= SToD((cAliasGW3)->GW3_DTENT)
						(cTabTemp)->GW3_SITFIS 	:= (cAliasGW3)->GW3_SITFIS
						(cTabTemp)->GW3_DTFIS 	:= SToD((cAliasGW3)->GW3_DTFIS)
						(cTabTemp)->GW3_CRDICM 	:= (cAliasGW3)->GW3_CRDICM
						(cTabTemp)->GW3_CRDPC 	:= (cAliasGW3)->GW3_CRDPC
						(cTabTemp)->GW3_CDTPSE 	:= (cAliasGW3)->GW3_CDTPSE
						(cTabTemp)->GVU_DSTPSE 	:= (cAliasGW3)->GVU_DSTPSE
						(cTabTemp)->GW3_CDESP	:= (cAliasGW3)->GW3_CDESP
						(cTabTemp)->GW3_EMISDF	:= (cAliasGW3)->GW3_EMISDF
						(cTabTemp)->GW3_SERDF	:= (cAliasGW3)->GW3_SERDF
						(cTabTemp)->NRDOCFRE	:= (cAliasGW3)->GW3_NRDF
						(cTabTemp)->GW3_DTEMIS	:= SToD((cAliasGW3)->GW3_DTEMIS)

						(cTabTemp)->VLIBSFRE 	:= Iif(GFXCP2510("GWM_VLIBS"), (cAliasGW3)->GWM_VLIBS, 0)
						(cTabTemp)->VLIBMFRE 	:= Iif(GFXCP2510("GWM_VLIBM"), (cAliasGW3)->GWM_VLIBM, 0)
						(cTabTemp)->VLCBSFRE 	:= Iif(GFXCP2510("GWM_VLCBS"), (cAliasGW3)->GWM_VLCBS, 0)

						If !Empty((cAliasGW3)->GW6_NRFAT)
							(cTabTemp)->TPDOCCOB	:= "Fatura"
							(cTabTemp)->DOCCOBRAN	:= (cAliasGW3)->GW6_NRFAT
							(cTabTemp)->DTEMICOB	:= SToD((cAliasGW3)->GW6_DTEMIS)
							(cTabTemp)->SITFINCOB	:= (cAliasGW3)->GW6_SITFIN
							(cTabTemp)->DTATUCOB	:= SToD((cAliasGW3)->GW6_DTFIN)
						EndIf
					(cTabTemp)->(MsUnlock())
				Else
					RecLock(cTabTemp,.T.)
						(cTabTemp)->FILIAL 		:= (cAliasGW3)->GW1_FILIAL
						(cTabTemp)->GW1_DTEMIS 	:= SToD((cAliasGW3)->GW1_DTEMIS)
						(cTabTemp)->GW1_CDTPDC 	:= (cAliasGW3)->GW1_CDTPDC
						(cTabTemp)->GW1_EMISDC 	:= (cAliasGW3)->GW1_EMISDC
						(cTabTemp)->NMEMISNF 	:= (cAliasGW3)->NMEMIS
						(cTabTemp)->GW1_SERDC 	:= (cAliasGW3)->GW1_SERDC
						(cTabTemp)->GW1_NRDC 	:= (cAliasGW3)->GW1_NRDC
						(cTabTemp)->VLR_NF 		:= (cAliasGW3)->GW8_VALOR
						(cTabTemp)->PESO_NF 	:= (cAliasGW3)->GW8_PESOR
						(cTabTemp)->VOLUME_NF 	:= (cAliasGW3)->GW8_VOLUME
						(cTabTemp)->CDDEST 		:= (cAliasGW3)->GW1_CDDEST
						(cTabTemp)->NMDEST 		:= (cAliasGW3)->NMDES
						(cTabTemp)->CIDDEST 	:= (cAliasGW3)->GU7_NMCID
						(cTabTemp)->ESTDEST 	:= (cAliasGW3)->GU7_CDUF
						(cTabTemp)->ROMANEIO 	:= (cAliasGW3)->GW1_NRROM
						(cTabTemp)->CDTRANSP	:= (cAliasGW3)->CDTRPGWM
			   			(cTabTemp)->NMTRANSP	:= (cAliasGW3)->NMTRPGWM
						(cTabTemp)->DTSAI 		:= SToD((cAliasGW3)->GW1_DTSAI)
						(cTabTemp)->DTENTREG 	:= SToD((cAliasGW3)->GWU_DTENT)
						(cTabTemp)->GW1_REGCOM	:= (cAliasGW3)->GW1_REGCOM
						(cTabTemp)->REPRES		:= (cAliasGW3)->Gw1_REPRES
						(cTabTemp)->CDREMET		:= (cAliasGW3)->GW1_CDREM
						(cTabTemp)->NMREMET		:= (cAliasGW3)->NMREM
						(cTabTemp)->GWN_CDCLFR	:= (cAliasGW3)->GWN_CDCLFR
						(cTabTemp)->GUB_DSCLFR	:= (cAliasGW3)->GUB_DSCLFR
						(cTabTemp)->GWN_CDTPOP	:= (cAliasGW3)->GWN_CDTPOP
						(cTabTemp)->GV4_DSTPOP	:= (cAliasGW3)->GV4_DSTPOP
						(cTabTemp)->TPFRETE		:= (cAliasGW3)->GW3_TPDF
						(cTabTemp)->VLCTRC		:= (cAliasGW3)->GWM_VLFRET
						(cTabTemp)->VLICMSFRE	:= (cAliasGW3)->GWM_VLICMS
						(cTabTemp)->VLPISFRE	:= (cAliasGW3)->GWM_VLPIS
						(cTabTemp)->VLCOFIFRE	:= (cAliasGW3)->GWM_VLCOFI
						(cTabTemp)->VLISSFRE	:= (cAliasGW3)->GWM_VLISS
						(cTabTemp)->GW3_DTENT 	:= SToD((cAliasGW3)->GW3_DTENT)
						(cTabTemp)->GW3_SITFIS 	:= (cAliasGW3)->GW3_SITFIS
						(cTabTemp)->GW3_DTFIS 	:= SToD((cAliasGW3)->GW3_DTFIS)
						(cTabTemp)->GW3_CRDICM 	:= (cAliasGW3)->GW3_CRDICM
						(cTabTemp)->GW3_CRDPC 	:= (cAliasGW3)->GW3_CRDPC
						(cTabTemp)->GW3_CDTPSE 	:= (cAliasGW3)->GW3_CDTPSE
						(cTabTemp)->GVU_DSTPSE 	:= (cAliasGW3)->GVU_DSTPSE	
						(cTabTemp)->GW3_CDESP	:= (cAliasGW3)->GW3_CDESP
						(cTabTemp)->GW3_EMISDF	:= (cAliasGW3)->GW3_EMISDF
						(cTabTemp)->GW3_SERDF	:= (cAliasGW3)->GW3_SERDF
						(cTabTemp)->NRDOCFRE	:= (cAliasGW3)->GW3_NRDF
						(cTabTemp)->GW3_DTEMIS	:= SToD((cAliasGW3)->GW3_DTEMIS)
						(cTabTemp)->CIDREMET    := (cAliasGW3)->CIDREMET
						(cTabTemp)->ESTREMET    := (cAliasGW3)->ESTREMET

						(cTabTemp)->VLIBSFRE 	:= Iif(GFXCP2510("GWM_VLIBS"), (cAliasGW3)->GWM_VLIBS, 0)
						(cTabTemp)->VLIBMFRE 	:= Iif(GFXCP2510("GWM_VLIBM"), (cAliasGW3)->GWM_VLIBM, 0)
						(cTabTemp)->VLCBSFRE 	:= Iif(GFXCP2510("GWM_VLCBS"), (cAliasGW3)->GWM_VLCBS, 0)

						If !Empty((cAliasGW3)->GW6_NRFAT)
							(cTabTemp)->TPDOCCOB	:= "Fatura"
							(cTabTemp)->DOCCOBRAN	:= (cAliasGW3)->GW6_NRFAT
							(cTabTemp)->DTEMICOB	:= SToD((cAliasGW3)->GW6_DTEMIS)
							(cTabTemp)->SITFINCOB	:= (cAliasGW3)->GW6_SITFIN
							(cTabTemp)->DTATUCOB	:= SToD((cAliasGW3)->GW6_DTFIN)
						EndIf
					(cTabTemp)->(MsUnlock())
				EndIf
			Else
				If (cTabTemp)->(dbSeek((cAliasGW3)->GW1_FILIAL+(cAliasGW3)->GW1_CDTPDC+(cAliasGW3)->GW1_EMISDC+;
								   (cAliasGW3)->GW1_SERDC+(cAliasGW3)->GW1_NRDC+(cAliasGW3)->GW1_DTEMIS))
					If Empty((cTabTemp)->TPFRETE)
						RecLock(cTabTemp,.F.)
							(cTabTemp)->TPFRETE		:= (cAliasGW3)->GW3_TPDF
							(cTabTemp)->VLCTRC		:= (cAliasGW3)->GWM_VLFRET
							(cTabTemp)->VLICMSFRE	:= (cAliasGW3)->GWM_VLICMS
							(cTabTemp)->VLPISFRE	:= (cAliasGW3)->GWM_VLPIS
							(cTabTemp)->VLCOFIFRE	:= (cAliasGW3)->GWM_VLCOFI
							(cTabTemp)->VLISSFRE	:= (cAliasGW3)->GWM_VLISS
							(cTabTemp)->GW3_DTENT 	:= SToD((cAliasGW3)->GW3_DTENT)
							(cTabTemp)->GW3_SITFIS 	:= (cAliasGW3)->GW3_SITFIS
							(cTabTemp)->GW3_DTFIS 	:= SToD((cAliasGW3)->GW3_DTFIS)
							(cTabTemp)->GW3_CRDICM 	:= (cAliasGW3)->GW3_CRDICM
							(cTabTemp)->GW3_CRDPC 	:= (cAliasGW3)->GW3_CRDPC
							(cTabTemp)->GW3_CDTPSE 	:= (cAliasGW3)->GW3_CDTPSE
							(cTabTemp)->GVU_DSTPSE 	:= (cAliasGW3)->GVU_DSTPSE
							(cTabTemp)->GW3_CDESP	:= (cAliasGW3)->GW3_CDESP
							(cTabTemp)->GW3_EMISDF	:= (cAliasGW3)->GW3_EMISDF
							(cTabTemp)->GW3_SERDF	:= (cAliasGW3)->GW3_SERDF
							(cTabTemp)->NRDOCFRE	:= (cAliasGW3)->GW3_NRDF
							(cTabTemp)->GW3_DTEMIS	:= SToD((cAliasGW3)->GW3_DTEMIS)

							(cTabTemp)->VLIBSFRE 	:= Iif(GFXCP2510("GWM_VLIBS"), (cAliasGW3)->GWM_VLIBS, 0)
							(cTabTemp)->VLIBMFRE 	:= Iif(GFXCP2510("GWM_VLIBM"), (cAliasGW3)->GWM_VLIBM, 0)
							(cTabTemp)->VLCBSFRE 	:= Iif(GFXCP2510("GWM_VLCBS"), (cAliasGW3)->GWM_VLCBS, 0)

							If !Empty((cAliasGW3)->GW6_NRFAT)
								(cTabTemp)->TPDOCCOB	:= "Fatura"
								(cTabTemp)->DOCCOBRAN	:= (cAliasGW3)->GW6_NRFAT
								(cTabTemp)->DTEMICOB	:= SToD((cAliasGW3)->GW6_DTEMIS)
								(cTabTemp)->SITFINCOB	:= (cAliasGW3)->GW6_SITFIN
								(cTabTemp)->DTATUCOB	:= SToD((cAliasGW3)->GW6_DTFIN)
							EndIf
						(cTabTemp)->(MsUnlock())
					Else
						RecLock(cTabTemp,.T.)
							(cTabTemp)->FILIAL 		:= (cAliasGW3)->GW1_FILIAL
							(cTabTemp)->GW1_DTEMIS 	:= SToD((cAliasGW3)->GW1_DTEMIS)
							(cTabTemp)->GW1_CDTPDC 	:= (cAliasGW3)->GW1_CDTPDC
							(cTabTemp)->GW1_EMISDC 	:= (cAliasGW3)->GW1_EMISDC
							(cTabTemp)->NMEMISNF 	:= (cAliasGW3)->NMEMIS
							(cTabTemp)->GW1_SERDC 	:= (cAliasGW3)->GW1_SERDC
							(cTabTemp)->GW1_NRDC 	:= (cAliasGW3)->GW1_NRDC
							(cTabTemp)->VLR_NF 		:= (cAliasGW3)->GW8_VALOR
							(cTabTemp)->PESO_NF 	:= (cAliasGW3)->GW8_PESOR
							(cTabTemp)->VOLUME_NF 	:= (cAliasGW3)->GW8_VOLUME
							(cTabTemp)->CDDEST 		:= (cAliasGW3)->GW1_CDDEST
							(cTabTemp)->NMDEST 		:= (cAliasGW3)->NMDES
							(cTabTemp)->CIDDEST 	:= (cAliasGW3)->GU7_NMCID
							(cTabTemp)->ESTDEST 	:= (cAliasGW3)->GU7_CDUF
							(cTabTemp)->ROMANEIO 	:= (cAliasGW3)->GW1_NRROM
							(cTabTemp)->CDTRANSP	:= (cAliasGW3)->CDTRPGWM
			   				(cTabTemp)->NMTRANSP	:= (cAliasGW3)->NMTRPGWM
							(cTabTemp)->DTSAI 		:= SToD((cAliasGW3)->GW1_DTSAI)
							(cTabTemp)->DTENTREG 	:= SToD((cAliasGW3)->GWU_DTENT)
							(cTabTemp)->GW1_REGCOM	:= (cAliasGW3)->GW1_REGCOM
							(cTabTemp)->REPRES		:= (cAliasGW3)->Gw1_REPRES
							(cTabTemp)->CDREMET		:= (cAliasGW3)->GW1_CDREM
							(cTabTemp)->NMREMET		:= (cAliasGW3)->NMREM
							(cTabTemp)->GWN_CDCLFR	:= (cAliasGW3)->GWN_CDCLFR
							(cTabTemp)->GUB_DSCLFR	:= (cAliasGW3)->GUB_DSCLFR
							(cTabTemp)->GWN_CDTPOP	:= (cAliasGW3)->GWN_CDTPOP
							(cTabTemp)->GV4_DSTPOP	:= (cAliasGW3)->GV4_DSTPOP
							(cTabTemp)->TPFRETE		:= (cAliasGW3)->GW3_TPDF
							(cTabTemp)->VLCTRC		:= (cAliasGW3)->GWM_VLFRET
							(cTabTemp)->VLICMSFRE	:= (cAliasGW3)->GWM_VLICMS
							(cTabTemp)->VLPISFRE	:= (cAliasGW3)->GWM_VLPIS
							(cTabTemp)->VLCOFIFRE	:= (cAliasGW3)->GWM_VLCOFI
							(cTabTemp)->VLISSFRE	:= (cAliasGW3)->GWM_VLISS
							(cTabTemp)->GW3_DTENT 	:= SToD((cAliasGW3)->GW3_DTENT)
							(cTabTemp)->GW3_SITFIS 	:= (cAliasGW3)->GW3_SITFIS
							(cTabTemp)->GW3_DTFIS 	:= SToD((cAliasGW3)->GW3_DTFIS)
							(cTabTemp)->GW3_CRDICM 	:= (cAliasGW3)->GW3_CRDICM
							(cTabTemp)->GW3_CRDPC 	:= (cAliasGW3)->GW3_CRDPC
							(cTabTemp)->GW3_CDTPSE 	:= (cAliasGW3)->GW3_CDTPSE
							(cTabTemp)->GVU_DSTPSE 	:= (cAliasGW3)->GVU_DSTPSE	
							(cTabTemp)->GW3_CDESP	:= (cAliasGW3)->GW3_CDESP
							(cTabTemp)->GW3_EMISDF	:= (cAliasGW3)->GW3_EMISDF
							(cTabTemp)->GW3_SERDF	:= (cAliasGW3)->GW3_SERDF
							(cTabTemp)->NRDOCFRE	:= (cAliasGW3)->GW3_NRDF
							(cTabTemp)->GW3_DTEMIS	:= SToD((cAliasGW3)->GW3_DTEMIS)
							(cTabTemp)->CIDREMET    := (cAliasGW3)->CIDREMET
							(cTabTemp)->ESTREMET    := (cAliasGW3)->ESTREMET

							(cTabTemp)->VLIBSFRE 	:= Iif(GFXCP2510("GWM_VLIBS"), (cAliasGW3)->GWM_VLIBS, 0)
							(cTabTemp)->VLIBMFRE 	:= Iif(GFXCP2510("GWM_VLIBM"), (cAliasGW3)->GWM_VLIBM, 0)
							(cTabTemp)->VLCBSFRE 	:= Iif(GFXCP2510("GWM_VLCBS"), (cAliasGW3)->GWM_VLCBS, 0)

							If !Empty((cAliasGW3)->GW6_NRFAT)
								(cTabTemp)->TPDOCCOB	:= "Fatura"
								(cTabTemp)->DOCCOBRAN	:= (cAliasGW3)->GW6_NRFAT
								(cTabTemp)->DTEMICOB	:= SToD((cAliasGW3)->GW6_DTEMIS)
								(cTabTemp)->SITFINCOB	:= (cAliasGW3)->GW6_SITFIN
								(cTabTemp)->DTATUCOB	:= SToD((cAliasGW3)->GW6_DTFIN)
							EndIf
						(cTabTemp)->(MsUnlock())
					EndIf
				EndIf
			EndIf
		EndIf

		(cAliasGW3)->(dbSkip())
	EndDo

	(cAliasGW3)->(dbCloseArea())

	cAliasGWM := GetNextAlias()

	BeginSQL Alias cAliasGWM
		SELECT GWM.GWM_FILIAL,
			   GWM.GWM_CDTRP,
			   GWM.GWM_NRDOC,
			   GWM.GWM_DTEMIS,
			   GWM.GWM_CDTPDC,
			   GWM.GWM_EMISDC,
			   GWM.GWM_SERDC,
			   GWM.GWM_NRDC,
			   %Exp:cCmpRat%
			   GWM.GWM_DTEMDC
		FROM %Table:GWM% GWM
		WHERE GWM.GWM_TPDOC = '3'
		AND GWM.GWM_DTEMDC >= %Exp:MV_PAR01%
		AND GWM.GWM_DTEMDC <= %Exp:MV_PAR02%
		AND GWM.%NotDel%
		GROUP BY GWM.GWM_FILIAL,
			   	 GWM.GWM_CDTRP,
			   	 GWM.GWM_NRDOC,
			     GWM.GWM_DTEMIS,
			     GWM.GWM_CDTPDC,
			     GWM.GWM_EMISDC,
			     GWM.GWM_SERDC,
			     GWM.GWM_NRDC,
			     GWM.GWM_DTEMDC
	EndSQL

	While !((cAliasGWM)->(EoF()))
		(cTabTemp)->(dbSetOrder(2))
		If (cTabTemp)->(dbSeek((cAliasGWM)->GWM_FILIAL+(cAliasGWM)->GWM_CDTPDC+(cAliasGWM)->GWM_EMISDC+;
							   (cAliasGWM)->GWM_SERDC+(cAliasGWM)->GWM_NRDC+(cAliasGWM)->GWM_DTEMDC+(cAliasGWM)->GWM_NRDOC))

			RecLock(cTabTemp, .F.)
				(cTabTemp)->VLCTRC		:= (cAliasGWM)->GWM_VLFRET
				(cTabTemp)->VLICMSFRE	:= (cAliasGWM)->GWM_VLICMS
				(cTabTemp)->VLPISFRE	:= (cAliasGWM)->GWM_VLPIS
				(cTabTemp)->VLCOFIFRE	:= (cAliasGWM)->GWM_VLCOFI
				(cTabTemp)->VLISSFRE	:= (cAliasGWM)->GWM_VLISS

				(cTabTemp)->VLIBSFRE 	:= Iif(GFXCP2510("GWM_VLIBS"), (cAliasGWM)->GWM_VLIBS, 0)
				(cTabTemp)->VLIBMFRE 	:= Iif(GFXCP2510("GWM_VLIBM"), (cAliasGWM)->GWM_VLIBM, 0)
				(cTabTemp)->VLCBSFRE 	:= Iif(GFXCP2510("GWM_VLCBS"), (cAliasGWM)->GWM_VLCBS, 0)
			(cTabTemp)->(MsUnlock())
		EndIf

		(cAliasGWM)->(dbSkip())
	EndDo

	(cAliasGWM)->(dbCloseArea())

	//----------------------------------------------------------
	//Seta regua de processamento
	//----------------------------------------------------------
	(cTabTemp)->(dbGoTop())
	oReport:SetMeter((cTabTemp)->(LastRec()))

	oSection1:Init()

	Do While !oReport:Cancel() .And. (cTabTemp)->(!Eof())
		
		oSection1:PrintLine()
		(cTabTemp)->(dbSkip())
	EndDo

	oSection1:Finish()
	GFEDelTab(cTabTemp)
Return

Static Function CriaTab()
	Local cAlias  		:= ""
	Local oAlias  		:= Nil
	Local nTamCdEmis 	:= TamSX3("GU3_CDEMIT")[1]
	Local nTamCid    	:= TamSX3("GW1_ENTCID")[1]
	Local nTamData   	:= TamSX3("GW1_DTEMIS")[1] //+ 2
	Local nTamNmEmis 	:= TamSX3("GU3_NMEMIT")[1]
	Local nTamUF     	:= 2
	
	Local aCampos 		:= {}

	aadd(aCampos, {"FILIAL"     , "C", TamSX3("GW1_FILIAL")[1]							, 0})
	aadd(aCampos, {"GW1_DTEMIS" , "D", nTamData				  							, 0})
	aadd(aCampos, {"GW1_CDTPDC" , "C", TamSX3("GW1_CDTPDC")[1]							, 0})
	aadd(aCampos, {"GW1_EMISDC" , "C", nTamCdEmis			  							, 0})
	aadd(aCampos, {"NMEMISNF"   , "C", nTamNmEmis										, 0})
	aadd(aCampos, {"GW1_SERDC"  , "C", TamSX3("GW1_SERDC")[1]							, 0})
	aadd(aCampos, {"GW1_NRDC"   , "C", TamSX3("GW1_NRDC")[1]							, 0})
	aadd(aCampos, {"VLR_NF"     , "N", TamSX3("GW8_VALOR")[1]							, TamSX3("GW8_VALOR")[2]})
	aadd(aCampos, {"PESO_NF"    , "N", TamSX3("GW8_PESOR")[1]							, TamSX3("GW8_PESOR")[2]})
	aadd(aCampos, {"VOLUME_NF"  , "N", TamSX3("GW8_VOLUME")[1]							, TamSX3("GW8_VOLUME")[2]})
	aadd(aCampos, {"CDDEST"     , "C", nTamCdEmis										, 0})
	aadd(aCampos, {"NMDEST"     , "C", nTamNmEmis										, 0})
	aadd(aCampos, {"CIDDEST"    , "C", nTamCid											, 0})
	aadd(aCampos, {"ESTDEST"    , "C", nTamUF											, 0})
	aadd(aCampos, {"ROMANEIO"   , "C", TamSX3("GW1_NRROM")[1]							, 0})
	aadd(aCampos, {"CDTRANSP"   , "C", nTamCdEmis										, 0})
	aadd(aCampos, {"NMTRANSP"   , "C", nTamNmEmis										, 0})
	aadd(aCampos, {"DTSAI"   	, "D", nTamData											, 0})
	aadd(aCampos, {"DTENTREG"	, "D", nTamData											, 0})
	aadd(aCampos, {"TPFRETE"   	, "C", 20												, 0})
	aadd(aCampos, {"VLFRETRAT"  , "N", TamSX3("GWM_VLFRET")[1]							, TamSX3("GWM_VLFRET")[2]})
	aadd(aCampos, {"NRDOCRAT"   , "C", 80												, 0})
	aadd(aCampos, {"VLICMSRAT"  , "N", TamSX3("GWM_VLICMS")[1]							, TamSX3("GWM_VLICMS")[2]})
	aadd(aCampos, {"CRDICMS"    , "C", 3												, 0})
	aadd(aCampos, {"VLPISRAT"   , "N", TamSX3("GWM_VLPIS")[1]							, TamSX3("GWM_VLPIS")[2]})
	aadd(aCampos, {"VLCOFIRAT"  , "N", TamSX3("GWM_VLCOFI")[1]							, TamSX3("GWM_VLCOFI")[2]})
	aadd(aCampos, {"CRDPC"      , "C", 3												, 0})
	aadd(aCampos, {"VLISSRAT"   , "N", TamSX3("GWM_VLISS")[1]							, TamSX3("GWM_VLISS")[2]})
	aadd(aCampos, {"VLCTRC"     , "N", TamSX3("GWM_VLFRET")[1]							, TamSX3("GWM_VLFRET")[2]})
	aadd(aCampos, {"VLICMSFRE"  , "N", TamSX3("GWM_VLICMS")[1]							, TamSX3("GWM_VLICMS")[2]})
	aadd(aCampos, {"VLPISFRE"   , "N", TamSX3("GWM_VLPIS")[1]							, TamSX3("GWM_VLPIS")[2]})
	aadd(aCampos, {"VLCOFIFRE"  , "N", TamSX3("GWM_VLCOFI")[1]							, TamSX3("GWM_VLCOFI")[2]})
	aadd(aCampos, {"VLISSFRE"   , "N", TamSX3("GWM_VLISS")[1]							, TamSX3("GWM_VLISS")[2]})
	aadd(aCampos, {"GW3_CDESP"  , "C", TamSX3("GW3_CDESP")[1]							, 0})
	aadd(aCampos, {"GW3_EMISDF" , "C", TamSX3("GW3_EMISDF")[1]							, 0})
	aadd(aCampos, {"GW3_SERDF"  , "C", TamSX3("GW3_SERDF")[1]							, 0})
	aadd(aCampos, {"NRDOCFRE"   , "C", TamSX3("GW3_NRDF")[1]							, 0})
	aadd(aCampos, {"GW3_DTEMIS"	, "D", nTamData											, 0})
	aadd(aCampos, {"GW3_DTENT" 	, "D", nTamData											, 0})
	aadd(aCampos, {"GW3_SITFIS" , "C", 20												, 0})
	aadd(aCampos, {"GW3_DTFIS" 	, "D", nTamData											, 0})
	aadd(aCampos, {"GW3_CRDICM" , "C", 3												, 0})
	aadd(aCampos, {"GW3_CRDPC"  , "C", 3												, 0})
	aadd(aCampos, {"GW3_CDTPSE" , "C", TamSX3("GW3_CDTPSE")[1]							, 0})
	aadd(aCampos, {"GVU_DSTPSE" , "C", TamSX3("GVU_DSTPSE")[1]							, 0})
	aadd(aCampos, {"TPPROVIS"   , "C", 15												, 0})
	aadd(aCampos, {"NRDOCPROV"  , "C", 80												, 0})
	aadd(aCampos, {"DTEMIPROV"  , "D", nTamData											, 0})
	aadd(aCampos, {"SITFINPROV" , "C", 10												, 0})
	aadd(aCampos, {"DTATUPROV"  , "D", nTamData											, 0})
	aadd(aCampos, {"SITPREFAT"  , "C", 10												, 0})
	aadd(aCampos, {"TPDOCCOB"   , "C", 10												, 0})
	aadd(aCampos, {"DOCCOBRAN"  , "C", TamSX3("GW6_NRFAT")[1]							, 0})
	aadd(aCampos, {"DTEMICOB"   , "D", nTamData											, 0})
	aadd(aCampos, {"SITFINCOB"  , "C", 10												, 0})
	aadd(aCampos, {"DTATUCOB"   , "D", nTamData											, 0})
	aadd(aCampos, {"GW1_REGCOM" , "C", TamSX3("GW1_REGCOM")[1]							, 0})
	aadd(aCampos, {"REPRES"     , "C", TamSX3("GW1_REPRES")[1]							, 0})
	aadd(aCampos, {"PESO_CUB"   , "N", TamSX3("GW8_PESOC")[1]							, TamSX3("GW8_PESOC")[2]})
	aadd(aCampos, {"GWN_CDCLFR" , "C", TamSX3("GWN_CDCLFR")[1]							, 0})
	aadd(aCampos, {"GUB_DSCLFR" , "C", TamSX3("GUB_DSCLFR")[1]							, 0})
	aadd(aCampos, {"GWN_CDTPOP" , "C", TamSX3("GWN_CDTPOP")[1]							, 0})
	aadd(aCampos, {"GV4_DSTPOP" , "C", TamSX3("GV4_DSTPOP")[1]							, 0})
	aadd(aCampos, {"CDREMET"    , "C", nTamCdEmis										, 0})
	aadd(aCampos, {"NMREMET"    , "C", nTamNmEmis										, 0})
	aadd(aCampos, {"CIDREMET"   , "C", nTamCid											, 0})
	aadd(aCampos, {"ESTREMET"   , "C", nTamUF											, 0})
	aadd(aCampos, {"GWU_SEQ"    , "C", TamSX3("GWU_SEQ")[1]							    , 0})
	aadd(aCampos, {"GWM_TPDOC"  , "C", TamSX3("GWM_TPDOC")[1]							, 0})

	aadd(aCampos, {"VLIBSRAT"  , "N", TamSX3("GWM_VLICMS")[1]							, TamSX3("GWM_VLICMS")[2]})
	aadd(aCampos, {"VLIBMRAT"  , "N", TamSX3("GWM_VLICMS")[1]							, TamSX3("GWM_VLICMS")[2]})
	aadd(aCampos, {"VLCBSRAT"  , "N", TamSX3("GWM_VLICMS")[1]							, TamSX3("GWM_VLICMS")[2]})
	aadd(aCampos, {"VLIBSFRE"  , "N", TamSX3("GWM_VLICMS")[1]							, TamSX3("GWM_VLICMS")[2]})
	aadd(aCampos, {"VLIBMFRE"  , "N", TamSX3("GWM_VLICMS")[1]							, TamSX3("GWM_VLICMS")[2]})
	aadd(aCampos, {"VLCBSFRE"  , "N", TamSX3("GWM_VLICMS")[1]							, TamSX3("GWM_VLICMS")[2]})
	
	cAlias := GFECriaTab({aCampos,{"FILIAL+GW1_CDTPDC+GW1_EMISDC+GW1_SERDC+GW1_NRDC+DTOS(GW1_DTEMIS)+TPFRETE",;
								   "FILIAL+GW1_CDTPDC+GW1_EMISDC+GW1_SERDC+GW1_NRDC+DTOS(GW1_DTEMIS)+NRDOCFRE+GW3_CDESP+GW3_EMISDF+GW3_SERDF+DTOS(GW3_DTEMIS)"}}, @oAlias)

Return {cAlias, oAlias}

Static Function R041TPFRE(TpFrete)
	Local cRet := ""

	Do Case
		Case TpFrete = '1'
			cRet := 'Normal'
		Case TpFrete = '2'
			cRet := 'Complementar Valor'
		Case TpFrete = '3'	
			cRet := 'Complementar Imposto'
		Case TpFrete = '4'	
			cRet := 'Reentrega'
		Case TpFrete = '5'	
			cRet := 'Devolução'
		Case TpFrete = '6'	
			cRet := 'Redespacho'
		Case TpFrete = '7'
			cRet := 'Serviço'
	EndCase
Return cRet

Static Function R041SIMNAO(cResult)
	Local cRet := ""

	Do Case
		Case cResult = '1'
			cRet := 'Sim'
		Case cResult = '2'
			cRet := 'Não'
	EndCase
Return cRet

Static Function R041SITPF(cSitPF)
	Local cRet := ""

	Do Case
		Case cSitPF = '1'
			cRet := 'Pendente'
		Case cSitPF = '2'
			cRet := 'Enviada'
		Case cSitPF = '3'	
			cRet := 'Confirmada'
		Case cSitPF = '4'	
			cRet := 'Cancelada'
	EndCase
Return cRet

Static Function R041SITPROV(cTpProvis, cSitFinProv)
	Local cRet   := ''
	Local cCampo := ''

	If !Empty(cSitFinProv)
		cCampo := If(AllTrim(cTpProvis) == "Pré-Fatura", "GWJ_SITFIN", "GXE_SIT")
		cRet   := GFEFldInfo(cCampo,cSitFinProv,2)
	EndIf
Return cRet

Static Function R041SITCOB(cTpCob, cSitFinCob)
	Local cRet   := ''
	Local cCampo := ''

	If !Empty(cSitFinCob)
		cCampo := If(AllTrim(cTpCob) == "Fatura", "GW6_SITFIN", "GW2_SITFIN")
		cRet   := GFEFldInfo(cCampo,cSitFinCob,2)
	EndIf
Return cRet
