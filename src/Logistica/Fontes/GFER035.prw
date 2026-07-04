/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

/*---------------------------------------------------------
{Protheus.doc} GFER035
	   
@author Hercilio H. Neto
@since 17/04/2018
@version 1.0

@description
Relatório de registro dos dados de entrega e cálculo das indenizações

-------------------------------------------------------------*/
User Function GFER035()
	Local oReport
	Local aArea := GetArea()

	Private cAliTrec := GetNextAlias()
	Private aStruTrec := {}
	
	If !GFXCP12121("GWD_PESO")
		Help( ,, 'HELP',, "Relatório disponível a partir da aplicação do Dicionário de Dados da release 12.1.17 Agosto/2018", 1, 0)	
		Return .F.
	EndIf
	
	If TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea( aArea )

	GFEDelTab(cAliTrec)
Return

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.          
//
//Uso       GFER041                                                    
//---------------------------------------------------------------------------

Static Function ReportDef()                                                                      	
	Local oReport, oSection0, oSection1
	Local aOrdem := {}

	
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
	
	oReport:= TReport():New("GFER035","Quebras de Peso","GFER035", {|oReport| ReportPrint(oReport)},"Emite relatório de Quebras de Peso conforme os parâmetros informados.") //"Movimentação Doc Carga"
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
	
	Aadd( aOrdem, "Quebra de Peso" ) // "Movimentação Doc Carga"
	
	/*
		Seção "Oculta" necessária pois o botão "Gestão de Empresas" somente aprece se houver uma tabela padrão do dicionário.
	*/
	oSection0 := TRSection():New(oReport,"-",{"GWU"},{"-"}) 
	oSection0:Hide()
	oSection0:Disable()
	oSection0:lReadOnly := .T.
	oSection0:lUserVisible := .F.
	
	oSection1 := TRSection():New(oReport,"Quebra de Peso",{"(cAliTrec)"},aOrdem) 
	oSection1:SetTotalInLine(.T.)
	oSection1:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	
	nTamData	:= TamSX3("GW1_DTEMIS")[1]+2
	nTamHr	:= TamSX3("GWU_HRENT")[1]+1
	
	TRCell():New(oSection1,"(cAliTrec)->GWU_FILIAL"		,"(cAliTrec)","Filial"/*cTitle*/,"@!"/*Picture*/, TamSX3("GW8_FILIAL")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GWU_CDTPDC"		,"(cAliTrec)","Tipo do Documento"/*cTitle*/,"@!"/*Picture*/, TamSX3("GW8_CDTPDC")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GWU_SERDC"		,"(cAliTrec)","Série"/*cTitle*/,"@!"/*Picture*/, TamSX3("GW8_SERDC")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GWU_NRDC"		,"(cAliTrec)","Numero"/*cTitle*/,"@!"/*Picture*/, TamSX3("GW8_NRDC")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"DtoC((cAliTrec)->GW1_DTEMIS)","(cAliTrec)","Data de Emissão"/*cTitle*/,/*Picture*/,  nTamData/*Tamanho*/,/*lPixel*/,/*{|| If ( Empty( (cTabTemp)->DTSAI ), '', DtoC(StoD( (cTabTemp)->DTSAI )) ) }*/)
	TRCell():New(oSection1,"(cAliTrec)->SITUACAO"		,"(cAliTrec)","Situação Docto"/*cTitle*/,/*Picture*/,  20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->PEDIDO"			,"(cAliTrec)","Pedido"/*cTitle*/,/*Picture*/,  20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW8_ITEM"		,"(cAliTrec)","Cód Item"/*cTitle*/,/*Picture*/, TamSX3("GW8_ITEM")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW8_DSITEM"		,"(cAliTrec)","Desc Item"/*cTitle*/,/*Picture*/, TamSX3("GW8_DSITEM")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW8_PESOR"		,"(cAliTrec)","Peso KG"/*cTitle*/,/*Picture*/,  TamSX3("GW8_PESOR")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW8_VALOR"		,"(cAliTrec)","Valor"/*cTitle*/,/*Picture*/,  TamSX3("GW8_VALOR")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->VALORKG"		,"(cAliTrec)","Valor/KG"/*cTitle*/,/*Picture*/,  TamSX3("GW8_VALOR")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW3_VLDF"		,"(cAliTrec)","Frete"/*cTitle*/,/*Picture*/,  TamSX3("GW3_VLDF")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW3_VLDFKG"		,"(cAliTrec)","Frete/KG"/*cTitle*/,/*Picture*/,  TamSX3("GW3_VLDF")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GWN_NRROM"		,"(cAliTrec)","Romaneio"/*cTitle*/,/*Picture*/,  TamSX3("GWN_NRROM")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GWN_CDTRP"		,"(cAliTrec)","Cod Transp Romaneio"/*cTitle*/,/*Picture*/,  TamSX3("GWN_CDTRP")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GU3_NMEMIT"		,"(cAliTrec)","Nome Trans Romaneio"/*cTitle*/,/*Picture*/,  TamSX3("GU3_NMEMIT")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"DtoC((cAliTrec)->GWU_DTENT)","(cAliTrec)","Data Entrega"/*cTitle*/,/*Picture*/,  nTamData/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GWU_HRENT"		,"(cAliTrec)","Hora Entrega"/*cTitle*/,/*Picture*/,  nTamHr/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GWD_PESO"		,"(cAliTrec)","Peso KG Entrega"/*cTitle*/,/*Picture*/,  TamSX3("GWD_PESO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	If GFXCP12121("GWD_NMREC")	
	   TRCell():New(oSection1,"(cAliTrec)->GWD_NMREC"		,"(cAliTrec)","Recebedor"/*cTitle*/,/*Picture*/,  TamSX3("GWD_NMREC")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	Endif   
	
	TRCell():New(oSection1,"(cAliTrec)->GWD_NROCO"		,"(cAliTrec)","Ocorrência"/*cTitle*/,/*Picture*/,  TamSX3("GWD_NROCO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GWD_DSCSIT"		,"(cAliTrec)","Situação Ocorrência"/*cTitle*/,/*Picture*/,  10/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GU5_DSINDE"		,"(cAliTrec)","Tipo Indenização"/*cTitle*/,/*Picture*/,  25/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->PERCQUEBRA"		,"(cAliTrec)","% Quebra"/*cTitle*/,/*Picture*/,  TamSX3("GUN_MAXQBR")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->QBRPESO"		,"(cAliTrec)","Quebra Peso KG"/*cTitle*/,/*Picture*/,  TamSX3("GWD_PESO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GUN_MAXQBR"		,"(cAliTrec)","% Tolerância"/*cTitle*/,/*Picture*/,  TamSX3("GUN_MAXQBR")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->TOLERANKG"		,"(cAliTrec)","Tolerância KG"/*cTitle*/,/*Picture*/,  TamSX3("GWD_PESO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->QBREXED"		,"(cAliTrec)","Quebra Excedente"/*cTitle*/,/*Picture*/,  TamSX3("GWD_PESO")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GWD_VALIND"		,"(cAliTrec)","Valor Indenização"/*cTitle*/,/*Picture*/,  TamSX3("GWD_VALIND")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW3_SERDF"		,"(cAliTrec)","Série Docto Frete"/*cTitle*/,/*Picture*/,  TamSX3("GW3_SERDF")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW3_NRDF"		,"(cAliTrec)","Docto Frete"/*cTitle*/,/*Picture*/,  TamSX3("GW3_NRDF")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW6_FILIAL"		,"(cAliTrec)","Filial Fatura"/*cTitle*/,/*Picture*/,  TamSX3("GW6_FILIAL")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW6_NRFAT"		,"(cAliTrec)","Fatura"/*cTitle*/,/*Picture*/,  TamSX3("GW6_NRFAT")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW6_VLFATU"		,"(cAliTrec)","Valor Total Fatura"/*cTitle*/,/*Picture*/,  TamSX3("GW6_VLFATU")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW6_DINDEN"		,"(cAliTrec)","Desconto Indenizatório"/*cTitle*/,/*Picture*/,  TamSX3("GW6_DINDEN")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliTrec)->GW6_DSCSFI"		,"(cAliTrec)","Situação Fatura"/*cTitle*/,/*Picture*/,  25/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	

Return(oReport)

Static Function ReportPrint(oReport)
	Local oSection1 	:= oReport:Section(2)
	Local aGCList 	:= {}

	aGCList := oReport:GetGCList()	// Função retorna array com filiais que o usuário tem acesso

	CarregaDados(aGCList)
	
	//----------------------------------------------------------
	//Seta regua de processamento
	//----------------------------------------------------------
	(cAliTrec)->(dbGoTop())
	oReport:SetMeter((cAliTrec)->(LastRec()))

	oSection1:Init()
	
	While !oReport:Cancel() .And. (cAliTrec)->(!Eof())
		
		oSection1:PrintLine()
		(cAliTrec)->(dbSkip())
		
	EndDo

	oSection1:Finish()
Return


//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CarregaDados
A funcao estatica CarregaDados Alimentam as tabelas temporárias cTabOc e cTabTotOc 
Faz a leitura do Pergunte GFER034
@author siegklenes.beulke
@version 1.0
@since 22/07/2013
@return Nil

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CarregaDados(aGCList)
	
	Local cQuery := ""
	Local cLstFil := ""
	Local aTpDc := {}
	Local aTransp := {}
	Local cLstTran := ""
	Local cLstTpdc := ""
	Local cFiltro := ""
	Local nCount
	Local nMV_CRIRAT := SuperGetMv("MV_CRIRAT",,"1")
	
	CriaTabTemp()
	
	//Filtro de Filial
	For nCount := 1 To Len(aGCList)
		If cLstFil == ""
			cLstFil := aGCList[nCount]
		Else
			cLstFil += ","+ aGCList[nCount]
		EndIf
	Next nCount
	
	If !Empty( cLstFil )
		cFiltro += " AND GWU.GWU_FILIAL IN ("+ cLstFil +")"
	EndIf
	
	//Filtro tpdc
	aTpDc := Iif(!Empty(MV_PAR01),Str2Arr(Upper(MV_PAR01), ";"),{})
	
	For nCount := 1 To Len(aTpDc)
		If cLstTpdc == ""
			cLstTpdc := aTpDc[nCount]
		Else
			cLstTpdc += "," + aTpDc[nCount] 
		EndIf
	Next nCount
	
	If !Empty( cLstTpdc )
		cFiltro += " AND GWU.GWU_CDTPDC IN ("+ cLstTpdc +")"
	EndIf
	
	//Filtro transportador
	aTransp := Iif(!Empty(MV_PAR09),Str2Arr(Upper(MV_PAR10), ";"),{})
	
	For nCount := 1 To Len(aTransp)
		If cLstTran == ""
			cLstTran := aTransp[nCount]
		Else
			cLstTran += ","+ aTransp[nCount]
		EndIf
	Next nCount
	
	If !Empty( cLstTran )
		cFiltro += " AND GWU.GWU_CDTRP IN ("+ cLstTran +")"
	EndIf
	
	//Filtros de Data
	cFiltro += " AND GW1.GW1_DTEMIS >= '"
	If !Empty(MV_PAR02)
	    cFiltro +=  DtoS(MV_PAR02) 	   
	EndIf
	
	cFiltro += "' AND GW1.GW1_DTEMIS <= '"
	If !Empty(MV_PAR03)   
	    cFiltro += DtoS(MV_PAR03)
	EndIf
	
	cFiltro += "' AND ( GWU.GWU_DTPENT >= '"
	If !Empty(MV_PAR04) 
	   cFiltro += DtoS(MV_PAR04) 
	EndIf
	
	cFiltro +=  "' AND GWU.GWU_DTPENT <= '"
	If !Empty(MV_PAR05) 
	   cFiltro += DtoS(MV_PAR05) 
	EndIf
	
	If  !Empty(MV_PAR06) .And. MV_PAR06 == 1 //Considerar sem entrega.
		cFiltro += "' OR  GWU.GWU_DTPENT = '' ) "
	Else 
		cFiltro += "' ) "
	EndIf
	
	cFiltro += " AND ( GWU.GWU_DTENT >= '"
	If !Empty(MV_PAR07)
	   cFiltro += DtoS(MV_PAR07)
	EndIf
	
	cFiltro += "' AND GWU.GWU_DTENT <= '" 
	If !Empty(MV_PAR08)
	   cFiltro += DtoS(MV_PAR08)
	EndIf   
	
	If  !Empty(MV_PAR09) .And. MV_PAR09 == 1 //Considerar sem entrega.
		cFiltro += "' OR  GWU.GWU_DTENT = '' ) "
	Else 
		cFiltro += "' ) "
	EndIf
	
	//------------------------------------------------------------------------------------------------------------------//
	cQuery += "SELECT GWU.GWU_FILIAL, GWU.GWU_EMISDC, GWU.GWU_CDTPDC, GWU.GWU_SERDC, GWU.GWU_NRDC, GW1.GW1_DTEMIS, '' AS SITUACAO, GW1.GW1_DTSAI, "
	cQuery += "GW1.GW1_PEDCLI AS PEDIDO, GW8.GW8_ITEM, GW8.GW8_DSITEM, GW8.GW8_PESOR, GW8.GW8_VALOR, 0 AS VALORKG, GWN.GWN_NRROM, GWN.GWN_CDTRP, GWD.GWD_SIT, " 
	
	If GFXCP12121("GWD_VALIND")
	   cQuery += "GWD.GWD_VALIND, "
	EndIf   
	
	cQuery += "'' AS GU3_NMEMIT, GWU.GWU_DTENT, GWU.GWU_HRENT, GWD.GWD_PESO, "
	
	If GFXCP12121("GWD_CDREC")  
	   cQuery += "GWD.GWD_CDREC, "
	EndIf	
	   
	cQuery += "'' AS GWD_NMREC, GWD.GWD_NROCO, "  
	
	If GFXCP12121("GWD_MAXQBR")
	   cQuery +=  "GWD.GWD_MAXQBR AS GUN_MAXQBR, "
	EndIf   
	
	cQuery += "0 AS PERCQUEBRA, 0 AS QBRPESO, 0 AS TOLERANKG, 0 AS QBREXED, 0 AS GW3_VLDF, '' AS GW3_SERDF, '' AS GW3_NRDF, GW8.GW8_SEQ, 0 AS GW3_VLDFKG, "
	cQuery += "'' AS GW6_FILIAL, '' AS GW6_NRFAT, 0 AS GW6_VLFATU, 0 AS GW6_DINDEN, '' AS GW6_SITFIN, GWD.GWD_CDTIPO, '' AS GU5_DSINDE "
	cQuery += "FROM " + RetSQLName("GWU") + " GWU "
	cQuery += "INNER JOIN " + RetSQLName("GW1") + " GW1"
	cQuery += " ON GW1.GW1_FILIAL = GWU.GWU_FILIAL"
	cQuery += " AND GW1.GW1_CDTPDC = GWU.GWU_CDTPDC"
	cQuery += " AND GW1.GW1_SERDC = GWU.GWU_SERDC" 
	cQuery += " AND GW1.GW1_EMISDC = GWU.GWU_EMISDC"
	cQuery += " AND GW1.GW1_NRDC = GWU.GWU_NRDC"
	cQuery += " AND GW1.D_E_L_E_T_ = '' "
	cQuery += "INNER JOIN " + RetSQLName("GW8") + " GW8"
	cQuery += " ON GW8.GW8_FILIAL = GWU.GWU_FILIAL"
	cQuery += " AND GW8.GW8_CDTPDC = GWU.GWU_CDTPDC"
	cQuery += " AND GW8.GW8_SERDC = GWU.GWU_SERDC"
	cQuery += " AND GW8.GW8_EMISDC = GWU.GWU_EMISDC"
	cQuery += " AND GW8.GW8_NRDC = GWU.GWU_NRDC"
	cQuery += " AND GW8.D_E_L_E_T_ = '' "
	cQuery += "LEFT JOIN " + RetSQLName("GWN") + " GWN"
	If GFXCP1212210('GW1_FILROM')
		cQuery += " ON GW1.GW1_FILROM = GWN.GWN_FILIAL"
	Else
		cQuery += " ON GW1.GW1_FILIAL = GWN.GWN_FILIAL"
	EndIf
	cQuery += " AND GW1.GW1_NRROM = GWN.GWN_NRROM"
	cQuery += " AND GWN.D_E_L_E_T_ = ''"
	cQuery += "LEFT JOIN " + RetSQLName("GWL") + " GWL ON "
	cQuery += "GWL.GWL_FILDC = GW1.GW1_FILIAL AND "
	cQuery += "GWL.GWL_TPDC = GW1.GW1_CDTPDC AND "
	cQuery += "GWL.GWL_EMITDC = GW1.GW1_EMISDC AND "
	cQuery += "GWL.GWL_SERDC = GW1.GW1_SERDC AND "
	cQuery += "GWL.GWL_NRDC = GW1.GW1_NRDC AND "
	cQuery += "GWL.D_E_L_E_T_ = '' "
	cQuery += "LEFT JOIN " + RetSQLName("GWD") + " GWD ON "
	cQuery += "GWL.GWL_FILIAL = GWD.GWD_FILIAL AND "
	cQuery += "GWL.GWL_NROCO = GWD.GWD_NROCO AND "
	cQuery += "GWD.D_E_L_E_T_ = '' "
	cQuery += "WHERE GWU.D_E_L_E_T_ = '' "
	cQuery += cFiltro
	
	cQuery := ChangeQuery(cQuery)
	
	SqlToTrb(cQuery, aStruTrec, cAliTrec)
	
	dbSelectArea((cAliTrec))
	(cAliTrec)->( dbGoTop() )
	
	While !(cAliTrec)->(Eof())
		
		RecLock((cAliTrec), .F.)
			If !Empty((cAliTrec)->GW1_DTSAI) .And. !Empty((cAliTrec)->GWU_DTENT)
				(cAliTrec)->SITUACAO := 'Entregue'
			Else
				If !Empty((cAliTrec)->GW1_DTSAI) .And. Empty((cAliTrec)->GWU_DTENT)
					(cAliTrec)->SITUACAO := 'Em trânsito'
				Else
					(cAliTrec)->SITUACAO := 'Pendente'
				EndIf
			EndIf
			
			(cAliTrec)->GU3_NMEMIT := Posicione("GU3",1,xFilial("GU3")+(cAliTrec)->GWN_CDTRP,"GU3_NMEMIT")
			(cAliTrec)->GWD_NMREC := Posicione("GU3",1,xFilial("GU3")+(cAliTrec)->GWD_CDREC,"GU3_NMEMIT")
			
			//Situação Ocorrência
			Do Case
				Case (cAliTrec)->GWD_SIT == '1'
					(cAliTrec)->GWD_DSCSIT := "Pendente"
				Case (cAliTrec)->GWD_SIT == '2'
					(cAliTrec)->GWD_DSCSIT := "Aprovada"
				Case (cAliTrec)->GWD_SIT == '3'
					(cAliTrec)->GWD_DSCSIT := "Reprovada"
			EndCase
			
			//Valor por KG
			(cAliTrec)->VALORKG := NoRound((cAliTrec)->GW8_VALOR / (cAliTrec)->GW8_PESOR, 2 )
					
			//Posiciona na GU5 para verificar se calcula indenização.
			GU5->(dbSetOrder(1))
			If GU5->(dbSeek(xFilial("GU5")+(cAliTrec)->GWD_CDTIPO))
				If GU5->GU5_INDEN $ "2;3" .And. (cAliTrec)->GWD_SIT == '2'
					
					//Quebra Peso
					(cAliTrec)->QBRPESO 	:= (cAliTrec)->GW8_PESOR - (cAliTrec)->GWD_PESO
					//% Quebra
					(cAliTrec)->PERCQUEBRA  := NoRound(((cAliTrec)->QBRPESO * 100) / (cAliTrec)->GW8_PESOR, 2)
					//Peso Tolerância
					(cAliTrec)->TOLERANKG   := ((cAliTrec)->GUN_MAXQBR / 100 ) * (cAliTrec)->GW8_PESOR
					//Peso Excedente a Tolerância
					(cAliTrec)->QBREXED 	:= If((cAliTrec)->QBRPESO <= (cAliTrec)->TOLERANKG, 0, (cAliTrec)->QBRPESO - (cAliTrec)->TOLERANKG )
				
				EndIf
				
				Do Case
					Case GU5->GU5_INDEN == '0'
						(cAliTrec)->GU5_DSINDE := "Não se aplica"
					Case GU5->GU5_INDEN == '1'
						(cAliTrec)->GU5_DSINDE := "Informado"
					Case GU5->GU5_INDEN == '2'
						(cAliTrec)->GU5_DSINDE := "Calculado - Carga"
					Case GU5->GU5_INDEN == '3'
						(cAliTrec)->GU5_DSINDE := "Calculado - Carga e Frete"	
				EndCase
				
			EndIf
			
			GW4->(dbSetOrder(2))
			If GW4->(dbSeek((cAliTrec)->(GWU_FILIAL+GWU_EMISDC+GWU_SERDC+GWU_NRDC+GWU_CDTPDC)))
				GW3->(dbSetOrder(1))
				If GW3->(dbSeek(GW4->(GW4_FILIAL+GW4_CDESP+GW4_EMISDF+GW4_SERDF+GW4_NRDF+DTOS(GW4_DTEMIS))))
				
					(cAliTrec)->GW3_SERDF := GW3->GW3_SERDF
					(cAliTrec)->GW3_NRDF  := GW3->GW3_NRDF
					
					GWM->(dbSetOrder(1))
					If GWM->(dbSeek(xFilial("GWM")+"2"+GW3->GW3_CDESP+GW3->GW3_EMISDF+GW3->GW3_SERDF+GW3->GW3_NRDF+DTOS(GW3->GW3_DTEMIS)+GW4->GW4_TPDC+GW4->GW4_EMISDC+GW4->GW4_SERDC+GW4->GW4_NRDC+(cAliTrec)->GW8_SEQ)) 
					
						If nMV_CRIRAT == "1" 
							(cAliTrec)->GW3_VLDF := GWM->GWM_VLFRET
						ElseIf nMV_CRIRAT == "2"
							(cAliTrec)->GW3_VLDF := GWM->GWM_VLFRE1
						ElseIf nMV_CRIRAT == "3"
							(cAliTrec)->GW3_VLDF := GWM->GWM_VLFRE3
						ElseIf nMV_CRIRAT == "4"
							(cAliTrec)->GW3_VLDF := GWM->GWM_VLFRE2
						EndIf
						
					EndIf
					
					(cAliTrec)->GW3_VLDFKG := (cAliTrec)->GW3_VLDF / (cAliTrec)->GW8_PESOR
					
					GW6->(dbSetOrder(1))
					If GW6->(dbSeek(GW3->(GW3_FILFAT+GW3_EMIFAT+GW3_SERFAT+GW3_NRFAT+DTOS(GW3_DTEMFA))))
						
						(cAliTrec)->GW6_FILIAL := GW6->GW6_FILIAL
						(cAliTrec)->GW6_NRFAT  := GW6->GW6_NRFAT
						(cAliTrec)->GW6_VLFATU := GW6->GW6_VLFATU
						(cAliTrec)->GW6_DINDEN := GW6->GW6_DINDEN
						(cAliTrec)->GW6_SITFIN := GW6->GW6_SITFIN
						
						//Situação Fatura
						Do Case
							Case (cAliTrec)->GW6_SITFIN == '1'
								(cAliTrec)->GW6_DSCSFI := "Não Enviada"
							Case (cAliTrec)->GW6_SITFIN == '2'
								(cAliTrec)->GW6_DSCSFI := "Pendente"
							Case (cAliTrec)->GW6_SITFIN == '3'
								(cAliTrec)->GW6_DSCSFI := "Rejeitada"
							Case (cAliTrec)->GW6_SITFIN == '4'
								(cAliTrec)->GW6_DSCSFI := "Atualizada"
							Case (cAliTrec)->GW6_SITFIN == '5'
								(cAliTrec)->GW6_DSCSFI := "Pendente Desatualização"
						EndCase
					EndIf
				EndIf
				
			EndIf
			
		MsUnlock()
		
		(cAliTrec)->(dbSkip())
	EndDo
	
Return

Static Function CriaTabTemp()
	Local aStruTrec	:= {}
	
	aStruTrec 	:= { 	{"GWU_FILIAL","C",TamSX3("GWU_FILIAL")[1],0},; 
						{"GWU_EMISDC","C",TamSX3("GWU_EMISDC")[1],0},; 
						{"GWU_CDTPDC","C",TamSX3("GWU_CDTPDC")[1],0},; 
						{"GWU_SERDC","C",TamSX3("GWU_SERDC")[1],0},; 
						{"GWU_NRDC","C",TamSX3("GWU_NRDC")[1],0},; 
						{"GW1_DTEMIS","D",TamSX3("GW1_DTEMIS")[1],0},; 
						{"SITUACAO","C",30,0},; 
						{"PEDIDO","C",TamSX3("GW1_PEDCLI")[1],0},; 
						{"GW8_ITEM","C",TamSX3("GW8_ITEM")[1],0},; 
						{"GW8_DSITEM","C",TamSX3("GW8_DSITEM")[1],0},; 
						{"GW8_PESOR","N",TamSX3("GW8_PESOR")[1],TamSX3("GW8_PESOR")[2]},; 
						{"GW8_VALOR","N",TamSX3("GW8_VALOR")[1],TamSX3("GW8_VALOR")[2]},; 
						{"GW8_SEQ","C",TamSX3("GW8_SEQ")[1],0},; 
						{"VALORKG","N",TamSX3("GW8_VALOR")[1],TamSX3("GW8_VALOR")[2]},; 
						{"GWN_NRROM","C",TamSX3("GWN_NRROM")[1],0},; 
						{"GWN_CDTRP","C",TamSX3("GWN_CDTRP")[1],0},; 
						{"GU3_NMEMIT","C",TamSX3("GU3_NMEMIT")[1],0},; 
						{"GWU_DTENT","D",TamSX3("GWU_DTENT")[1],0},; 
						{"GW1_DTSAI","D",TamSX3("GW1_DTSAI")[1],0},; 
						{"GWU_HRENT","C",TamSX3("GWU_HRENT")[1],0},;
						{"GWD_PESO","N",TamSX3("GWD_PESO")[1],TamSX3("GWD_PESO")[2]},;  
						{"GWD_NROCO","C",TamSX3("GWD_NROCO")[1],0},;
						{"GWD_CDTIPO","C",TamSX3("GWD_CDTIPO")[1],0},;  
						{"GWD_SIT","C",TamSX3("GWD_SIT")[1],0},; 
						{"GWD_DSCSIT","C",10,0},; 
						{"GU5_DSINDE","C",25,0},; 
						{"PERCQUEBRA","N",6,TamSX3("GUN_MAXQBR")[2]},; 
						{"QBRPESO","N",TamSX3("GWD_PESO")[1],TamSX3("GWD_PESO")[2]},; 
						{"GUN_MAXQBR","N",TamSX3("GUN_MAXQBR")[1],TamSX3("GUN_MAXQBR")[2]},; 
						{"TOLERANKG","N",TamSX3("GWD_PESO")[1],TamSX3("GWD_PESO")[2]},; 
						{"QBREXED","N",TamSX3("GWD_PESO")[1],TamSX3("GWD_PESO")[2]},;
						{"GWD_VALIND","N",TamSX3("GWD_VALIND")[1],TamSX3("GWD_VALIND")[2]},; 						 
						{"GW3_VLDF","N",TamSX3("GW3_VLDF")[1],TamSX3("GW3_VLDF")[2]},; 
						{"GW3_VLDFKG","N",TamSX3("GW3_VLDF")[1],TamSX3("GW3_VLDF")[2]},; 
						{"GW3_SERDF","C",TamSX3("GW3_SERDF")[1],0},; 
						{"GW3_NRDF","C",TamSX3("GW3_NRDF")[1],0},; 
						{"GW6_FILIAL","C",TamSX3("GW6_FILIAL")[1],0},; 
						{"GW6_NRFAT","C",TamSX3("GW6_NRFAT")[1],0},;  
						{"GW6_SITFIN","C",TamSX3("GW6_SITFIN")[1],0},; 
						{"GW6_DSCSFI","C",25,0},; 
						{"GW6_VLFATU","N",TamSX3("GW6_VLFATU")[1],TamSX3("GW6_VLFATU")[2]};												 
					}
					
	
	If GFXCP12121("GWD_CDREC") .And. GFXCP12121("GWD_NMREC") .And. GFXCP12121("GW6_DINDEN")	    
		aAdd(aStruTrec,{"GWD_CDREC","C",TamSX3("GWD_CDREC")[1],0})
		aAdd(aStruTrec,{"GWD_NMREC","C",TamSX3("GWD_NMREC")[1],0})
        aAdd(aStruTrec,{"GW6_DINDEN","N",TamSX3("GW6_DINDEN")[1],TamSX3("GW6_DINDEN")[2]})
	EndIf					
	
	cAliTrec :=  GFECriaTab({aStruTrec,{"GWU_FILIAL+GWU_CDTPDC+GWU_SERDC+GWU_NRDC"}})
	(cAliTrec)->(dbSetOrder(1))
Return {aStruTrec}
