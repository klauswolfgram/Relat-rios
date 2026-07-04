/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"        
//-------------------------------------------------------------------
//Inclusão Pátios 12.1.4
//-------------------------------------------------------------------
/*/{Protheus.doc} GFER520

Relátorio de Indicadores por Operação

@author Helder Fuckner dos Santos
@since 13/03/14
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFER520()
	Local oReport
	Local aArea := GetArea()
	Private cTabTotMD
	Private cAliasIO 		// Registros referente a consultaSQL
	Private nTmpMedMov	:= 0
	Private nContMed		:= 0
	Private nTmpEspera	:= 0
	Private nQtdReprov	:= 0
	Private nQtdCanc		:= 0
	Private cCdOper 		:= ""
	Private cSeqOper 		:= ""
	Private cDsConf 		:= ""
	Private cFilMov		:= ""
	Private cNrMov		:= ""
	
	If TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

	RestArea( aArea )

	GFEDelTab(cTabTotMD)
	If !Empty(cAliasIO)
		(cAliasIO)->(dbCloseArea())
	EndIf

Return

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.          
//
//Uso       GFER520                                                    
//---------------------------------------------------------------------------

Static Function ReportDef()                                                                      	
	Local oReport, oSection1
	Local aOrdem    	:= {}
	
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
	
	oReport:= TReport():New("GFER520","Indicadores por Operação","GFER520", {|oReport| ReportPrint(oReport)},"Emite relatório de Indicadores por Operação conforme os parâmetros informados.") //"Indicadores por Operação"
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
	
	Aadd( aOrdem, "Indicadores por Operação" ) // "Indicadores por Operação"
	
	oSection1 := TRSection():New(oReport,"Indicadores por Operação",{"(cAliasIO)"},aOrdem) //"Indicadores por Operação"
	oSection1:SetTotalInLine(.T.)
	oSection1:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
 	TRCell():New(oSection1,"cCdOper"	,"GVI"	,"Operação"				,"@!",16,/*lPixel*/,	{|| cCdOper })
	TRCell():New(oSection1,"cSeqOper"	,"GVI"	,"Seq"						,"@!",5,/*lPixel*/,	{|| cSeqOper })
	TRCell():New(oSection1,"cDsConf"	,"GVI"	,"Desc"					,"@!",30,/*lPixel*/,	{|| cDsConf })
	TRCell():New(oSection1,"nTmpMedMov",""		,"Tempo Médio Mov.(hr)"	,"@E 9999.99",7,/*lPixel*/,{|| NoRound(nTmpMedMov,2) })
	TRCell():New(oSection1,"nTmpEspera",""		,"Tempo Espera (hr)"		,"@!",7,/*lPixel*/,	{|| Transform(nTmpEspera,"@E 9999.99") })
	TRCell():New(oSection1,"nQtdReprov",""		,"Reprovações"			,"@!",7,/*lPixel*/,	{|| Transform(nQtdReprov,"@E 9999999") })
	TRCell():New(oSection1,"nQtdCanc"	,""		,"Cancelamentos"			,"@!",7,/*lPixel*/,	{|| Transform(nQtdCanc,  "@E 9999999") })

Return(oReport)

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.         
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório
//---------------------------------------------------------------------------
//Uso  GFER520                                                    
//---------------------------------------------------------------------------

Static Function ReportPrint(oReport)
	Local oSection1 	:= oReport:Section(1)
	Local dtCria		:= ""
	Local hrCria		:= ""
	Local dtEnt		:= ""
	Local hrEnt		:= ""
	Local dtSai		:= ""
	Local hrSai		:= ""
	Local dtEntOper	:= ""
	Local hrEntOper	:= ""
	Local dtSaiOper	:= ""
	Local hrSaiOper	:= ""
	Local cFilMovQt	:= ""
	Local cNrMovQt	:= ""
	Local cOpSeq  	:= ""
	Local nContEsp	:= 0
	Local nTmpMed 	:= 0
	

	CarregaDados()

	//----------------------------------------------------------
	//Seta regua de processamento
	//----------------------------------------------------------
	oReport:SetMeter((cAliasIO)->(LastRec()))

	oSection1:Init()
	
	While !oReport:Cancel() .And. (cAliasIO)->(!Eof())
		
		nTmpMed:= 0
		dtEnt	:= StoD((cAliasIO)->GX4_DTENTR)
		hrEnt	:= (cAliasIO)->GX4_HRENTR 
		dtSai	:= StoD((cAliasIO)->GX4_DTSAI)
		hrSai	:= (cAliasIO)->GX4_HRSAI
		dtCria	:= StoD((cAliasIO)->GX3_DTCRIA)
		hrCria	:= (cAliasIO)->GX3_HRCRIA
		
		// Primeira Vez
		If Empty(cOpSeq)
			cCdOper 	:= (cAliasIO)->GVI_CDOPER
			cSeqOper 	:= (cAliasIO)->GVI_SEQ
			cDsConf	:= (cAliasIO)->GVI_DSCONF
			cOpSeq 	:= cCdOper + cSeqOper
			cFilMov	:= (cAliasIO)->GX4_FILIAL
			cNrMov		:= (cAliasIO)->GX4_NRMOV
			nTmpMedMov	:= 0
			nContMed	:= 0
			nTmpEspera	:= 0
			nContEsp	:= 0
			nQtdReprov	:= 0
			nQtdCanc	:= 0
			nCont 		:= 0
		EndIf

		// Calcula Qtde de Reprovações do CheckList
		If cFilMov != (cAliasIO)->GX4_FILIAL .Or. cNrMov != (cAliasIO)->GX4_NRMOV
			// Conta Reprovações - Fazer o cálculo antes de atribuir novo Nr Movimento
			U_GFER520QRE()
					
			cFilMov:= (cAliasIO)->GX4_FILIAL			
			cNrMov := (cAliasIO)->GX4_NRMOV

			// Calculo Medio
			If !Empty(dtEntOper)
				nTmpMedMov	+= GFEC511ATM( dtEntOper, dtSaiOper, hrEntOper, hrSaiOper )
			EndIf

			dtEntOper 	:= ""
			dtSaiOper	:= ""
			hrEntOper 	:= ""
			hrSaiOper	:= ""
		EndIf

		If cOpSeq != (cAliasIO)->GVI_CDOPER + (cAliasIO)->GVI_SEQ
			nTmpEspera	:= nTmpEspera / nContEsp
			nTmpMedMov	:= nTmpMedMov	/ nContMed
			
			oSection1:PrintLine()

			// Inicializa
			cCdOper 	:= (cAliasIO)->GVI_CDOPER
			cSeqOper 	:= (cAliasIO)->GVI_SEQ
			cDsConf	:= (cAliasIO)->GVI_DSCONF
			cOpSeq 	:= cCdOper + cSeqOper
			nTmpMedMov	:= 0
			nContMed	:= 0
			nTmpEspera	:= 0
			nContEsp	:= 0
			nQtdReprov	:= 0
			nQtdCanc	:= 0
			nCont 		:= 0
			// Guarda o primeiro registro
			dtEntOper := dtEnt
			hrEntOper := hrEnt			
		EndIf

		// INICIO - Soma os valores
		If (cAliasIO)->GX4_SEQ == '001'
			// Tempo de Espera
			nTmpMed := GFEC511ATM( dtCria, dtEnt, hrCria, hrEnt)
			If nTmpMed != 0
				nTmpEspera	+= nTmpMed 
				nContEsp += 1
			EndIf
		EndIf
		
		If (cAliasIO)->GX3_SIT == "5"	// STATUS MOV
			nQtdCanc	+= 1	
		EndIf		

		// Guarda o primeiro registro
		If Empty(dtEntOper)
			dtEntOper := dtEnt
			hrEntOper := hrEnt
		EndIf
			
		// Guarda tempo ultimo Pt Controle  
		If !Empty(dtSai) .And. !Empty(hrSai)
			dtSaiOper := dtSai
			hrSaiOper := hrSai
		EndIf
		
		// Guarda tempo ultimo Pt Controle  
		If !Empty(dtEnt) .And. !Empty(hrEnt) .And. !Empty(dtSai) .And. !Empty(hrSai)
			If cFilMovQt != (cAliasIO)->GX4_FILIAL .Or. cNrMovQt != (cAliasIO)->GX4_NRMOV
				// Conta Movimentacoes para Média
				nContMed += 1
				
				cFilMovQt	:= (cAliasIO)->GX4_FILIAL
				cNrMovQt 	:= (cAliasIO)->GX4_NRMOV
			EndIf
		EndIf
		
		// Passa para próx. registro
		(cAliasIO)->( dbSkip() )
		
		If (cAliasIO)->( Eof() )
			// Calcula Qtde de Reprovações do CheckList
			U_GFER520QRE()

			nTmpEspera	:= nTmpEspera / nContEsp
			// Calculo Tempo Medio Operações
			nTmpMedMov	:= nTmpMedMov	/ nContMed

			oSection1:PrintLine()
		EndIf
	EndDo

	oSection1:Finish()
Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CarregaDados
A funcao estatica CarregaDados Alimentam as tabelas temporárias cTabTotMD 
Faz a leitura do Pergunte GFER520
@author helder.santos
@version 1.0
@since 03/03/2014
@return Nil

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CarregaDados()
	Local aArea := GetArea(), cQuery := ""
	Local cFltrGX3 := "" 

	CriaTabTemp()
	
	cFltrGX3 += " AND GVI.GVI_FILIAL >= '" + MV_PAR01 		+ "' AND GVI.GVI_FILIAL 	<= '" + MV_PAR02 + "' "	
	cFltrGX3 += " AND GVI.GVI_CDOPER >= '" + MV_PAR03 		+ "' AND GVI.GVI_CDOPER 	<= '" + MV_PAR05 + "' "
	cFltrGX3 += " AND GX3.GX3_SEQ    >= '" + MV_PAR04 		+ "' AND GX3.GX3_SEQ 	<= '" + MV_PAR06 + "' "
	cFltrGX3 += " AND GX3.GX3_DTCRIA >= '" + DTOS(MV_PAR07) + "' AND GX3.GX3_DTCRIA 	<= '" + DTOS(MV_PAR08) + "' "
	If AllTrim(MV_PAR09) != ""
		cFltrGX3 += " AND GX3.GX3_CDEMIT = '" + MV_PAR09 + "'"
	EndIf
	cFltrGX3 += " AND GVI.D_E_L_E_T_ = '' AND GX3.D_E_L_E_T_ = '' "

	cAliasIO := GetNextAlias()

	cQuery += "SELECT	GX4.GX4_FILIAL, GVI.GVI_CDOPER, GVI.GVI_SEQ, GVI.GVI_DSCONF, "
	cQuery += "		GX3.GX3_DTCRIA, GX3.GX3_HRCRIA, GX3.GX3_SIT, "
	cQuery += "		GX4.GX4_DTENTR, GX4.GX4_HRENTR, GX4.GX4_DTSAI, GX4.GX4_HRSAI, GX4.GX4_SIT, GX4.GX4_NRMOV, GX4_CDPTCT, GX4.GX4_SEQ "
  	cQuery += "  FROM " + RetSQLName("GVI") + " GVI"
	cQuery += "  LEFT JOIN " + RetSQLName("GX3") + " GX3 ON GX3.GX3_FILIAL = GVI.GVI_FILIAL"
	cQuery += "											   AND GX3.GX3_CDOPER = GVI.GVI_CDOPER"
	cQuery += "	     									   AND GX3.GX3_SEQ    = GVI.GVI_SEQ"
	cQuery += "  LEFT JOIN " + RetSQLName("GX4") + " GX4 ON GX4.GX4_FILIAL = GX3.GX3_FILIAL"
	cQuery += "	     									   AND GX4.GX4_NRMOV  = GX3.GX3_NRMOV"
	cQuery += " WHERE (GX3.GX3_SIT = 5 OR GX3.GX3_SIT = 6) " + cFltrGX3
	cQuery += " ORDER BY GVI.GVI_CDOPER, GVI.GVI_SEQ, GX3.GX3_DTCRIA, GX3.GX3_HRCRIA, GX4.GX4_SEQ " // GX4.GX4_DTENTR, GX4.GX4_HRENTR

	cQuery := ChangeQuery(cQuery)

	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasIO, .F., .T.)
	dbSelectArea( (cAliasIO) )
	(cAliasIO)->( dbGoTop() )

	RestArea(aArea)
Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CriaTabTemp
Esta funcao estatica cria a struct dos dados do relatório e cria as tabelas temporárias, privadas em U_GFER520() 

@author helder.santos
@version 1.0
@since 03/03/2014
@return {aStruOpTot} Array com Struct dos campos
/*/
//--------------------------------------------------------------------------------------------------------

Static Function CriaTabTemp()
	Local aStruOpTot	
	
	aStruOpTot :=	{	{"GVI_CDOPER","C",16,0};
					}

	cTabTotMD := GFECriaTab({aStruOpTot,{"GVI_CDOPER"}})
	
Return {aStruOpTot}

User Function GFER520QRE()
	
	dbSelectArea("GX4")
	GX4->(dbSetOrder(1))
	If GX4->(dbSeek( cFilMov + cNrMov ) )
		
		While GX4->(!Eof()) .And. GX4->GX4_FILIAL == cFilMov .And. GX4->GX4_NRMOV == cNrMov
		
			If GX4->GX4_SIT != "1"
				
				GX5->( dbSetOrder(1) ) // Filial + GX4->GX4_NRMOV + GX4->GX4_CDPTCT + GX4->GX4_SEQ
				GX5->( dbSeek( GX4->GX4_FILIAL + GX4->GX4_NRMOV + GX4->GX4_CDPTCT +  GX4->GX4_SEQ) )
				While GX5->( !Eof() ) .And. GX5->GX5_FILIAL == GX4->GX4_FILIAL .And. ;
				                            GX5->GX5_NRMOV == GX4->GX4_NRMOV .And. ;
				                            GX5->GX5_CDPTCT == GX4->GX4_CDPTCT .And. ;
				                            GX5->GX5_SEQ == GX4->GX4_SEQ
					If GX5->GX5_RESPOS == '2'
						nQtdReprov	+= 1
					EndIf
			
					GX5->( dbSkip() )
				EndDo	
				
			EndIf
			
			GX4->(dbSkip())
		EndDo
		
	EndIf

Return Nil