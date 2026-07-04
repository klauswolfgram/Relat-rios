/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"        
//-------------------------------------------------------------------
//Inclusão Pátios 12.1.4
//-------------------------------------------------------------------
/*/{Protheus.doc} GFER522

Relátorio de Reprovações

@author Helder Fuckner dos Santos
@since 13/03/14
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFER522()
	Local oReport
	Local aArea := GetArea()
	Private cTabTotMD
	Private cAliasR 	// Registros referente a consultaSQL
	Private cDesTrans		:= ""
	Private cDesOper		:= ""
	Private cDesPtCtrl	:= ""
	Private cDesPerg  	:= ""
	Private cObs			:= ""


	If TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

	RestArea( aArea )
	GFEDelTab(cTabTotMD)
	If !Empty(cAliasR)
		(cAliasR)->(dbCloseArea())
	EndIf
	
Return

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.          
//
//Uso       GFER522                                                    
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
	
	oReport:= TReport():New("GFER522","Reprovações","GFER522", {|oReport| ReportPrint(oReport)},"Emite relatório de Reprovações conforme os parâmetros informados.") //"Reprovações"
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
	
	Aadd( aOrdem, "Reprovações" ) // "Reprovações"
	
	oSection1 := TRSection():New(oReport,"Reprovações",{"(cAliasR)"},aOrdem) //"Reprovações"
	oSection1:SetTotalInLine(.T.)
	oSection1:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	//TRCell():New(oSection1,"(cAliasR)->GWD_DTOCOR","(cAliasR)","Dt. Ocorr.",,10,/*lPixel*/,{|| If(Vazio((cAliasR)->GWD_DTOCOR),(cAliasR)->GWD_DTOCOR,SubStr((cAliasR)->GWD_DTOCOR,7,2) + '/' + SubStr((cAliasR)->GWD_DTOCOR,5,2)+ '/' + SubStr((cAliasR)->GWD_DTOCOR,1,4) ) })
 	TRCell():New(oSection1,"(cAliasR)->GX3_NRMOV"		,"(cAliasR)"	,"Nr Movimento"	,GetSx3Inf("GX3_NRMOV")[3],8,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"cDesTrans"          	 	,""				,"Transportador"	,"@!",50,/*lPixel*/,{|| cDesTrans })
	TRCell():New(oSection1,"(cAliasR)->GX3_CDOPER"	,"(cAliasR)"	,"Operação"		,GetSx3Inf("GX3_CDOPER")[3],16,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliasR)->GX3_SEQ"		,"(cAliasR)"	,"Seq"				,GetSx3Inf("GX3_SEQ")[3],4,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"cDesOper"      			,""			  	,"Desc. Config."	,"@!",30,/*lPixel*/,{|| cDesOper })
	TRCell():New(oSection1,"cDesPtCtrl"          		,""				,"Ponto de Controle","@!",30,/*lPixel*/,{|| cDesPtCtrl })
	TRCell():New(oSection1,"cDesPerg"          		,""				,"Pergunta"		,"@!",30,/*lPixel*/,{|| cDesPerg })
	TRCell():New(oSection1,"cObs"          			,""				,"Observação"		,"@!",99,/*lPixel*/,{|| cObs })
/*
"Nr Movimentação", "Transportador", "Operação", "Seq", "Desc Config", "Ponto de controle", "Pergunta", "Observação";
*/
Return(oReport)

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.         
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório
//---------------------------------------------------------------------------
//Uso  GFER522                                                    
//---------------------------------------------------------------------------

Static Function ReportPrint(oReport)
	Local oSection1 	:= oReport:Section(1)
	
	CarregaDados()

	//----------------------------------------------------------
	//Seta regua de processamento
	//----------------------------------------------------------
	oReport:SetMeter(GFENumReg(cAliasR))
	
	oSection1:Init()
	
	(cAliasR)->(dbGoTop())	
	While !oReport:Cancel() .And. !(cAliasR)->( Eof() )

		cDesTrans 	:= Posicione("GU3",1,xFilial("GU3")+(cAliasR)->GX3_CDEMIT,"GU3_NMEMIT")
		cDesOper	:= Posicione("GVI",1,xFilial("GVI")+(cAliasR)->GX3_CDOPER+(cAliasR)->GX3_SEQ,"GVI_DSCONF")
		cDesPtCtrl	:= Posicione("GVF",1,xFilial("GVI")+(cAliasR)->GX5_CDPTCT,"GVF_DSPTCT")
		cDesPerg	:= Posicione("GVG",1,xFilial("GVG")+(cAliasR)->GX5_CDPERG,"GVG_DSPERG")

		cObs := Posicione("GX5",1,(cAliasR)->GX3_FILIAL+(cAliasR)->GX3_NRMOV+(cAliasR)->GX5_CDPTCT+(cAliasR)->GX5_SEQ+(cAliasR)->GX5_CDPERG,"GX5_OBS")

		// Imprime
		oSection1:PrintLine()

		(cAliasR)->( dbSkip() )
	EndDo
	
	oSection1:Finish()
	
Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CarregaDados
A funcao estatica CarregaDados Alimentam as tabelas temporárias cTabTotMD 
Faz a leitura do Pergunte GFER522
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

	cFltrGX3 += " AND GX3.GX3_FILIAL >= '" + MV_PAR01 		+ "' AND GX3.GX3_FILIAL <= '" + MV_PAR02 + "' "	
	If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
		cFltrGX3 += " AND GX3.GX3_DTCRIA >= '" + DTOS(MV_PAR03) + "' AND GX3.GX3_DTCRIA <= '" + DTOS(MV_PAR04) + "' "
	EndIf
	cFltrGX3 += " AND GX3.GX3_CDOPER >= '" + MV_PAR05 + "' AND GX3.GX3_CDOPER <= '" + MV_PAR07	+ "' "
	cFltrGX3 += " AND GX3.GX3_SEQ >= '" + MV_PAR06 + "' AND GX3.GX3_SEQ  <= '" + MV_PAR08 + "' "
	If AllTrim(MV_PAR09) != ""
		cFltrGX3 += " AND GX3.GX3_CDEMIT = '" + MV_PAR09 + "'"
	EndIf
	cFltrGX3 += " AND GX5.GX5_RESPOS = '2' "	// Reprovado


	cAliasR := GetNextAlias()

	cQuery += "SELECT	GX3.GX3_FILIAL, GX3.GX3_NRMOV, GX3.GX3_CDEMIT, GX3.GX3_CDOPER, GX3.GX3_SEQ, "
	cQuery += "		GX5.GX5_CDPTCT, GX5.GX5_SEQ, GX5.GX5_CDPERG, GX5.GX5_OBS "
	cQuery += "  FROM " + RetSQLName("GX3") + " GX3 "
	cQuery += " INNER JOIN " + RetSQLName("GX4") + " GX4	 ON GX3.GX3_FILIAL = GX4.GX4_FILIAL"
	cQuery += "												AND GX3.GX3_NRMOV  = GX4.GX4_NRMOV"
	cQuery += "					  							AND GX4.GX4_DTSAI != ''"
	cQuery += " INNER JOIN " + RetSQLName("GX5") + "	GX5	 ON GX4.GX4_FILIAL = GX5.GX5_FILIAL "
	cQuery += "												AND GX4.GX4_NRMOV  = GX5.GX5_NRMOV "
	cQuery += "												AND GX4.GX4_SEQ    = GX5.GX5_SEQ"
	cQuery += " WHERE GX3.D_E_L_E_T_ = '' AND GX5.D_E_L_E_T_ = '' " 
	cQuery += "	AND GX3_SIT IN ('5','6') " + cFltrGX3

	cQuery := ChangeQuery(cQuery)

	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasR, .F., .T.)
	dbSelectArea( (cAliasR) )
	(cAliasR)->( dbGoTop() )

	RestArea(aArea)
Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CriaTabTemp
Esta funcao estatica cria a struct dos dados do relatório e cria as tabelas temporárias, privadas em U_GFER522() 

@author helder.santos
@version 1.0
@since 03/03/2014
@return {aStruOpTot} Array com Struct dos campos
/*/
//--------------------------------------------------------------------------------------------------------

Static Function CriaTabTemp()
	Local aStruOpTot
	
	aStruOpTot :=	{	{"GX3_NRMOV","C",8,0};
					}

	cTabTotMD := GFECriaTab({aStruOpTot,{"GX3_NRMOV"}})
	
Return {aStruOpTot}

/*/{Protheus.doc} GetSx3Inf
	
@author helder.santos
@since 03/03/2014
@version 1.0

@param cCampo, character, Campo  do Banco de dados 
@param aRetorno, array, Opcional, Informações de Retorno caso não encontre o Campo

@description

Função que busca no sx3 as informações de titulo,cbox,picture e descrição do campo
e retorna um array nessa ordem, ou caso não encontre o campo, retorna o segundo parametro

@example

GetSx3Inf("GW1_FILIAL") Retorno {"Filial","","@!","Filial"}
GetSx3Inf("GW1_FILI",{"Fila","1=Sim;2=Nao","","Fila de espera"})Retorno {"Fila","1=Sim;2=Nao","","Fila de espera"} 

@return aArray:={X3Titulo, X3Cbox,X3Picture,X3DESCRIC}
/*/

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