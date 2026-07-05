/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"        
//-------------------------------------------------------------------
//Inclusão Pátios 12.1.4
//-------------------------------------------------------------------
/*/{Protheus.doc} GFER521

Relátorio de Indicadores por Usuário

@author Helder Fuckner dos Santos
@since 13/03/14
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFER521()
	Local oReport
	Private cTabTotMD
	Private cAliasIU 		// Registros referente a consultaSQL

	Private cUsuario		:= ""
	Private cFilMov
	Private nTmpMedAt		:= 0
	Private nQtdMov		:= 0
	Private nQtdRep		:= 0
	Private nQtdCanc		:= 0

	Private nTmpMAOp		:= 0
	Private nQtdMovOp		:= 0
	Private nQtdRepOp		:= 0
	Private nQtdCancOp	:= 0
	
	If TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	GFEDelTab(cTabTotMD)
	
Return

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.          
//
//Uso       GFER521                                                    
//---------------------------------------------------------------------------

Static Function ReportDef()                                                                      	
	Local oReport, oSection1, oSection2
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
	
	oReport:= TReport():New("GFER521","Indicadores por Usuário","GFER521", {|oReport| ReportPrint(oReport)},"Emite relatório de Indicadores por Usuário conforme os parâmetros informados.") //"Indicadores por Usuário"
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
	
	Aadd( aOrdem, "Indicadores por Usuário" ) // "Indicadores por Usuário"

	oSection1 := TRSection():New(oReport,"Indicadores por Usuário",{"(cAliasIU)"},aOrdem) //"Indicadores por Usuário"
	oSection1:SetTotalInLine(.T.)
	oSection1:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
 	
 	TRCell():New(oSection1,"cFilMov","","Filial"					,"@!",20,/*lPixel*/,{|| cFilMov })
 	TRCell():New(oSection1,"cUsuario"	,"","Usuário"	 			,"@!",50,/*lPixel*/,{|| cUsuario })
	TRCell():New(oSection1,"nQtdMov"	,"","Qtde Movimentos"	 	,"@E 9999999",7,/*lPixel*/,{|| Transform(nQtdMov,"@E 9999999") })
	TRCell():New(oSection1,"nTmpMedAt" ,"","Tempo Médio Atend.(hr)" ,"@!",7,/*lPixel*/,{|| Transform(nTmpMedAt, "@E 9999.99") })
	TRCell():New(oSection1,"nQtdRep"	,"","Reprovações"			,"@E 9999999",7,/*lPixel*/,{|| Transform(nQtdRep,"@E 9999999") })
	TRCell():New(oSection1,"nQtdCanc"	,"","Cancelamentos"			,"@E 9999999",7,/*lPixel*/,{|| Transform(nQtdCanc,  "@E 9999999") })

	oSection2 := TRSection():New(oReport,"Indicadores por Usuário",{"(cAliasIU)"},aOrdem) //"Indicadores por Usuário"
	oSection2:SetTotalInLine(.T.)
	oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
 	TRCell():New(oSection2,"cOper"		,"","Operação" 				,"@!",16,	/*lPixel*/,{|| cOper })
 	TRCell():New(oSection2,"cSeq"		,"","Sequência" 				,"@!",3,	/*lPixel*/,{|| cSeq })
 	TRCell():New(oSection2,"cDesConfOp","","Descrição" 				,"@!",30,	/*lPixel*/,{|| cDesConfOp })
	TRCell():New(oSection2,"nQtdMovOp"	,"","Qtde Movimentos"	 	,"@E 9999999",7,/*lPixel*/,{|| Transform(nQtdMovOp,"@E 9999999") })
	TRCell():New(oSection2,"nTmpMAOp"	,"","Tempo Médio Atend.(hr)","@!",7,/*lPixel*/,{|| Transform(nTmpMAOp,"@E 9999.99") })
	TRCell():New(oSection2,"nQtdRepOp"	,"","Reprovações"				,"@E 9999999",7,/*lPixel*/,{|| Transform(nQtdRepOp,"@E 9999999") })
	TRCell():New(oSection2,"nQtdCancOp","","Cancelamentos"			,"@E 9999999",7,/*lPixel*/,{|| Transform(nQtdCancOp,"@E 9999999") })		

Return(oReport)

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.         
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório
//---------------------------------------------------------------------------
//Uso  GFER521                                                    
//---------------------------------------------------------------------------

Static Function ReportPrint(oReport)
	Local oSection1 	:= oReport:Section(1)
	Local oSection2 	:= oReport:Section(2)
	Local dtEnt		:= ""
	Local hrEnt		:= ""
	Local dtSai		:= ""
	Local hrSai		:= ""		
	Local cAux			:= ""
	Local aDados		:= {}
	Local nPos, nPosOp
	Local nCount, nCountOp 
	
	/*
	aDados := 
	{
		{1 "Filial"
		 2 "Administrador", 	//Usuário 
		 3 {"00001", "000002", "00003"}, // Qtde Movimentos
		 4 {"2", "3"},		// Reprovações
		 5 {"2"}, 				// Cancelamentos
		 6 0, 					// Tempo Médio Atend.(hr)
		 7 0, 					// Qtd atendimento
		 8 {
		   	 {
			   	 1 "Operação", 	// Operação
			   	 2 "Sequencia", 	// Sequência
			   	 3 "Descrição", 	// Descrição
			   	 4 {"00001", "000002", "00003"}, // Qtde Movimentos
				 5 {"2", "3"},		// Reprovações
				 6 {"2"}, 				// Cancelamentos
			   	 7 0, 					// Tempo Médio Atend.(hr)
			   	 8 0, 					// Qtd atendimento
		   	 },
		   	 {
		   	 },
		   	 {
		   	 }		
		  }
		}
	}
	*/

	CarregaDados()

	//----------------------------------------------------------
	//Seta regua de processamento
	//----------------------------------------------------------
	oReport:SetMeter(GFENumReg(cAliasIU))

	(cAliasIU)->(dbGoTop())
		
	While (cAliasIU)->(!Eof())
		// ##### INICIO - Carrega Array #####
		
		// INI - Carrega Usuário
		nPos := aScan(aDados, {|x| x[1] == (cAliasIU)->FILIAL .And. x[2] == (cAliasIU)->USUARIO })

		If Len(aDados) == 0 .Or. nPos == 0
			aAdd(aDados, { (cAliasIU)->FILIAL, (cAliasIU)->USUARIO, {}, {}, {}, 0, 0, {} } )
			nPos := aScan(aDados, {|x| x[1] == (cAliasIU)->FILIAL .And. x[2] == (cAliasIU)->USUARIO })	
		EndIf

		If aScan(aDados[nPos][3], (cAliasIU)->NRMOV) == 0
			// Movimentações
			aAdd(aDados[nPos][3], (cAliasIU)->NRMOV)
			
			// Cancelamentos
			If (cAliasIU)->SITMOV == "5"
				aAdd(aDados[nPos][5], (cAliasIU)->NRMOV)	
			EndIf
		EndIf
		
		// Reprovações
		If (cAliasIU)->SITMOVPC == "3" .And. aScan(aDados[nPos][4], (cAliasIU)->NRMOV) == 0 
			aAdd(aDados[nPos][4], (cAliasIU)->NRMOV)
		EndIf
		
		dtEnt	:= (cAliasIU)->GX4_DTENTR
		hrEnt	:= (cAliasIU)->GX4_HRENTR
		dtSai	:= (cAliasIU)->GX4_DTSAI
		hrSai	:= (cAliasIU)->GX4_HRSAI

		nAtend := GFEC511ATM( StoD(dtEnt), StoD(dtSai), hrEnt, hrSai)
		
		If nAtend > 0
			//Atendimentos
			aDados[nPos][6] += nAtend
			aDados[nPos][7]++
		EndIf
		// FIM - Carrega Usuário
		
		// INI - Carrega Operação
		If MV_PAR11 == 2
			
			nPosOp := aScan(aDados[nPos][8], {|x| x[1] == (cAliasIU)->OPER .And. x[2] == (cAliasIU)->SEQ })
	
			If Len(aDados[nPos][8]) == 0 .Or. nPosOp == 0
				cAux := Posicione("GVI",1,xFilial("GVI") + (cAliasIU)->OPER + (cAliasIU)->SEQ, "GVI_DSCONF")
				
				aAdd(aDados[nPos][8], { (cAliasIU)->OPER, (cAliasIU)->SEQ, cAux, {}, {}, {}, 0, 0 } )
				nPosOp := aScan(aDados[nPos][8], {|x| x[1] == (cAliasIU)->OPER .And. x[2] == (cAliasIU)->SEQ })	
			EndIf

			If aScan(aDados[nPos][8][nPosOp][4], (cAliasIU)->NRMOV) == 0
				// Movimentações
				aAdd(aDados[nPos][8][nPosOp][4], (cAliasIU)->NRMOV)
				
				// Cancelamentos
				If (cAliasIU)->SITMOV == "5"
					aAdd(aDados[nPos][8][nPosOp][6], (cAliasIU)->NRMOV)	
				EndIf
			EndIf

			// Reprovações
			If (cAliasIU)->SITMOVPC == "3" .And. aScan(aDados[nPos][8][nPosOp][5], (cAliasIU)->NRMOV) == 0 
				aAdd(aDados[nPos][8][nPosOp][5], (cAliasIU)->NRMOV)
			EndIf

			If nAtend > 0
				// Atendimentos
				aDados[nPos][8][nPosOp][7] += nAtend
				aDados[nPos][8][nPosOp][8]++
			EndIf

		EndIf
		// FIM - Carrega Operação
		
		(cAliasIU)->(dbSkip())
	EndDo
	// ##### FIM - Carrega Array #####
	
	
	For nCount := 1 To Len(aDados)
		
		oSection1:Init()
		
		cFilMov	 	:= aDados[nCount][1]
		cUsuario 		:= aDados[nCount][2] 
		nTmpMedAt		:= If(aDados[nCount][6] > 0, aDados[nCount][6] / aDados[nCount][7], 0) 
		nQtdMov		:= Len(aDados[nCount][3])
		nQtdRep		:= Len(aDados[nCount][4])
		nQtdCanc		:= Len(aDados[nCount][5])

		oSection1:PrintLine()
		
		If MV_PAR11 == 2
			
			oSection2:Init()
			
			For nCountOp := 1 To Len(aDados[nCount][8])
			
				cOper	 	:= aDados[nCount][8][nCountOp][1]
				cSeq		:= aDados[nCount][8][nCountOp][2] 
				cDesConfOp	:= aDados[nCount][8][nCountOp][3]
				nQtdMovOp	:= Len(aDados[nCount][8][nCountOp][4])
				nTmpMAOp	:= If(aDados[nCount][8][nCountOp][7] > 0, aDados[nCount][8][nCountOp][7] / aDados[nCount][8][nCountOp][8], 0)
				nQtdRepOp	:= Len(aDados[nCount][8][nCountOp][5])
				nQtdCancOp	:= Len(aDados[nCount][8][nCountOp][6])
	
				oSection2:PrintLine()
				
			Next nCountOp
			
			oSection2:Finish()
		
		oSection1:Finish()
		
		EndIf
		
	Next nCount
	
	(cAliasIU)->(dbCloseArea())

Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CarregaDados
A funcao estatica CarregaDados Alimentam as tabelas temporárias cTabTotMD 
Faz a leitura do Pergunte GFER521
@author helder.santos
@version 1.0
@since 03/03/2014
@return Nil

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CarregaDados()
	Local cQuery := ""
	Local cFltrGX3 := "" 

	CriaTabTemp()
	
	cFltrGX3 += " AND GX3.GX3_CDOPER >= '" + MV_PAR07 		+ "' AND GX3.GX3_CDOPER <= '" + MV_PAR09 + "' "
	cFltrGX3 += " AND GX3.GX3_SEQ    >= '" + MV_PAR08 		+ "' AND GX3.GX3_SEQ    <= '" + MV_PAR10 + "' "
	cFltrGX3 += " AND GX3.GX3_DTCRIA >= '" + DTOS(MV_PAR05) + "' AND GX3.GX3_DTCRIA <= '" + DTOS(MV_PAR06) + "' " 
	cFltrGX3 += " AND GX3.GX3_SIT IN ('5','6') "	// considerar somente movimentos com status cancelado ou concluído
	cFltrGX3 += " AND GX3.D_E_L_E_T_ = '' AND GX4.D_E_L_E_T_ = '' "

	// GX3_SIT (1=Aberto; 2=Movimentado; 3=Em Fila; 4=Endereçado; 5=Cancelado; 6=Concluído)
	// GX4_SIT (1=Nao Avaliado 2=Aprovado 3=Reprovado)
	
	cAliasIU := GetNextAlias()

	cQuery += "SELECT	FILIAL,"
	cQuery += "		USUARIO,"
	cQuery += "		GX4_DTENTR, GX4_HRENTR, GX4_DTSAI, GX4_HRSAI,"
	cQuery += "		SUM(CASE WHEN SEQ = '001' THEN QTD_REPROV END) QTD_REPROV,"
	cQuery += "		SUM(CASE WHEN SEQ = '001' THEN QTD_CANCEL END) QTD_CANCEL,"
	cQuery += "		SITMOV,"
	cQuery += "		SITMOVPC,"
	cQuery += "		OPER,"
	cQuery += "		SEQ,"
	cQuery += "		NRMOV"
	cQuery += "  FROM ("
	cQuery += "			SELECT GX4.GX4_FILIAL FILIAL,"
	cQuery += "				   GX4.GX4_USUENT USUARIO,"
	cQuery += "				   '' GX4_DTENTR,"
	cQuery += "				   '' GX4_HRENTR,"
	cQuery += "				   '' GX4_DTSAI,"
	cQuery += "				   '' GX4_HRSAI," 
	cQuery += "			       COUNT(CASE WHEN GX4_SIT = '3' THEN 1 END) QTD_REPROV," 
	cQuery += "			       COUNT(CASE WHEN GX3_SIT = '5' THEN 1 END) QTD_CANCEL,"
	cQuery += "					GX3.GX3_SIT SITMOV,"
	cQuery += "					GX4.GX4_SIT SITMOVPC,"
	cQuery += "					GX3.GX3_CDOPER OPER,"
	cQuery += "					GX3.GX3_SEQ SEQ,"
	cQuery += "					GX3.GX3_NRMOV NRMOV"
	
	cQuery += "			  FROM " + RetSQLName("GX3") + " GX3"
	cQuery += "			 INNER JOIN " + RetSQLName("GX4") + " GX4  ON GX4.GX4_FILIAL = GX3.GX3_FILIAL" 
	cQuery += "															AND GX4.GX4_NRMOV  = GX3.GX3_NRMOV"
	cQuery += "			                      						AND GX4.D_E_L_E_T_ = ''"
	cQuery += "			 WHERE GX4.GX4_USUENT != GX4.GX4_USUSAI"
	cQuery += cFltrGX3
	cQuery += "			 GROUP BY GX4.GX4_FILIAL, GX4.GX4_USUENT, GX3.GX3_SIT, GX4.GX4_SIT, GX3.GX3_CDOPER, GX3.GX3_SEQ, GX3.GX3_NRMOV"

	cQuery += "			 UNION ALL"

	cQuery += "			SELECT	GX4.GX4_FILIAL FILIAL,"
	cQuery += "			      	GX4.GX4_USUSAI USUARIO," 
	cQuery += "			      	'' GX4_DTENTR,"
	cQuery += "				  	'' GX4_HRENTR,"
	cQuery += "				  	'' GX4_DTSAI,"
	cQuery += "				  	'' GX4_HRSAI," 
	cQuery += "			       COUNT(CASE WHEN GX4_SEQ = '001' AND GX4_SIT = '3' THEN 1 END) QTD_REPROV,"
	cQuery += "			       COUNT(CASE WHEN GX3_SIT = '5' THEN 1 END) QTD_CANCEL,"
	cQuery += "					GX3.GX3_SIT SITMOV,"
	cQuery += "					GX4.GX4_SIT SITMOVPC,"
	cQuery += "					GX3.GX3_CDOPER,"
	cQuery += "					GX3.GX3_SEQ,"
	cQuery += "					GX3.GX3_NRMOV NRMOV"
	cQuery += "			  FROM " + RetSQLName("GX3") + " GX3"
	cQuery += "			 INNER JOIN " + RetSQLName("GX4") + " GX4  ON GX4.GX4_FILIAL = GX3.GX3_FILIAL"
	cQuery += "			                      						AND GX4.GX4_NRMOV  = GX3.GX3_NRMOV"
	cQuery += "			                      						AND GX4.D_E_L_E_T_ = ''"
	cQuery += "			 WHERE GX4.GX4_USUENT != GX4.GX4_USUSAI"
	cQuery += cFltrGX3
	cQuery += "			 GROUP BY GX4.GX4_FILIAL, GX4.GX4_USUSAI, GX3.GX3_SIT, GX4.GX4_SIT, GX3.GX3_CDOPER, GX3.GX3_SEQ, GX3.GX3_NRMOV"

	cQuery += "			 UNION ALL"

	cQuery += "			SELECT GX4.GX4_FILIAL FILIAL,"
	cQuery += "			      	GX4.GX4_USUSAI USUARIO," 
	cQuery += "				   	GX4.GX4_DTENTR,"
	cQuery += "				   	GX4.GX4_HRENTR,"
	cQuery += "				   	GX4.GX4_DTSAI,"
	cQuery += "				   	GX4.GX4_HRSAI," 
	cQuery += "			       COUNT(CASE WHEN GX4_SIT = '3' THEN 1 END) QTD_REPROV," 
	cQuery += "			       COUNT(CASE WHEN GX3_SIT = '5' THEN 1 END) QTD_CANCEL,"
	cQuery += "					GX3.GX3_SIT SITMOV,"
	cQuery += "					GX4.GX4_SIT SITMOVPC,"
	cQuery += "					GX3.GX3_CDOPER,"
	cQuery += "					GX3.GX3_SEQ,"
	cQuery += "					GX3.GX3_NRMOV NRMOV"
	cQuery += "			  FROM " + RetSQLName("GX3") + " GX3"
	cQuery += "			 INNER JOIN " + RetSQLName("GX4") + " GX4	 ON GX4.GX4_FILIAL = GX3.GX3_FILIAL" 
	cQuery += "															AND GX4.GX4_NRMOV  = GX3.GX3_NRMOV"
	cQuery += "															AND GX4.D_E_L_E_T_ = ''"
	cQuery += "			 WHERE GX4.GX4_USUENT = GX4.GX4_USUSAI"
	cQuery += cFltrGX3
	cQuery += "			 GROUP BY 	GX4.GX4_FILIAL, GX4.GX4_USUSAI, GX4.GX4_DTENTR, GX4.GX4_HRENTR, GX4.GX4_DTSAI, GX4.GX4_HRSAI,"
	cQuery += "			 			GX3.GX3_SIT, GX4.GX4_SIT, GX3.GX3_CDOPER, GX3.GX3_SEQ, GX3.GX3_NRMOV"

	cQuery += "			 UNION ALL"

	cQuery += "			SELECT	GX3.GX3_FILIAL FILIAL,"
	cQuery += "			      	GX3.GX3_USUCRI USUARIO," 
	cQuery += "				   	'' GX4_DTENTR,"
	cQuery += "				   	'' GX4_HRENTR,"
	cQuery += "				   	'' GX4_DTSAI,"
	cQuery += "				   	'' GX4_HRSAI," 
	cQuery += "			       0 QTD_REPROV,"
	cQuery += "			       COUNT(CASE WHEN GX3_SIT = '5' THEN 1 END) QTD_CANCEL,"
	cQuery += "					GX3.GX3_SIT SITMOV,"
	cQuery += "					GX4.GX4_SIT SITMOVPC,"
	cQuery += "					GX3.GX3_CDOPER,"
	cQuery += "					GX3.GX3_SEQ,"
	cQuery += "					GX3.GX3_NRMOV NRMOV"
	cQuery += "			  FROM " + RetSQLName("GX3") + " GX3"
	cQuery += "			 INNER JOIN " + RetSQLName("GX4") + " GX4  ON GX4.GX4_FILIAL = GX3.GX3_FILIAL"
	cQuery += "															AND GX4.GX4_NRMOV  = GX3.GX3_NRMOV"
	cQuery += "															AND GX4.D_E_L_E_T_ = ''"
	cQuery += "			 WHERE GX3.GX3_USUCRI != GX4.GX4_USUENT"
	cQuery += "			   AND GX3.GX3_USUCRI != GX4.GX4_USUSAI"
	cQuery += cFltrGX3
	cQuery += "			 GROUP BY GX3.GX3_FILIAL, GX3.GX3_USUCRI, GX3.GX3_SIT, GX4.GX4_SIT, GX3.GX3_CDOPER, GX3.GX3_SEQ, GX3.GX3_NRMOV"
	cQuery += "			) A"

	cQuery += " WHERE USUARIO != '' "
	cQuery += "   AND FILIAL  >= '" + MV_PAR01 + "' AND FILIAL  <= '" + MV_PAR02 + "' "
	cQuery += "   AND LOWER(USUARIO) >= '" + Lower(MV_PAR03) + "' AND LOWER(USUARIO) <= '" + Lower(MV_PAR04) + "' "

	cQuery += " GROUP BY FILIAL, USUARIO, GX4_DTENTR, GX4_HRENTR, GX4_DTSAI, GX4_HRSAI, SITMOV, SITMOVPC, OPER, SEQ, NRMOV"
	cQuery += " ORDER BY FILIAL, USUARIO, OPER, SEQ"

	cQuery := ChangeQuery(cQuery)

	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasIU, .F., .T.)
	dbSelectArea( (cAliasIU) )
	(cAliasIU)->( dbGoTop() )
Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CriaTabTemp
Esta funcao estatica cria a struct dos dados do relatório e cria as tabelas temporárias, privadas em U_GFER521() 

@author helder.santos
@version 1.0
@since 03/03/2014
@return {aStruOpTot} Array com Struct dos campos
/*/
//--------------------------------------------------------------------------------------------------------

Static Function CriaTabTemp()
	Local aStruOpTot
	
	aStruOpTot :=	{	{"NRMOV","C",16,0};
					}

	cTabTotMD := GFECriaTab({aStruOpTot,{"NRMOV"}})
	
Return {aStruOpTot}
