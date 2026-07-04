/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
/*/{Protheus.doc}GFER064
 Relatório Comparativo de Tarifas 

@Author Alexandre José Cuchi
@Since 15/10/2014
@Version 1.0
/*/ 
User Function GFER064()
	Local oReport
	Private cCmpnt     := "" // código do componente                        
	Private cTipoValor := "" // Tipo do campo para comparação               
	Private cCidOrigem := "" // Cidade de origem da rota                    
	Private cUFDestino := "" // UF destino da rota                          
	Private cTranspA   := "" // Código do primeiro transportador            
	Private cFxTpVcA   := "" // Sequencia de faixa do primeiro transportador
	Private cNegA      := "" // Negociação da primeira tabela de frete      
	Private cTabelaA   := "" // Tabela de frete do primeiro transportador   
	Private cTranspB   := "" // Código do segundo transportador             
	Private cFxTpVcB   := "" // Sequencia de faixa do segundo transportador 
	Private cNegB      := "" // Negociação da segunda tabela de frete       
	Private cTabelaB   := "" // Numero da tabela de frete                   
	
	Private cNmCidOr   := "" // Nome da cidade de origem
	Private cNmTrpA    := "" // Nome do transportador A
	Private cNmTrpB    := "" // Nome do transportador B
	
	dbSelectArea("GV1")
	GV1->(dbSetOrder(1))
	If TRepInUse() 
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
Return

Static Function ReportDef()
	Local oReport
	Local aOrdem := {}
	Local oSection
	Local oSecInfo
	Local oSctnHide
	Private cAli := ""
	
	oReport := TReport():New("GFER064","Relatório Comparativo entre Tarifas de Frete",;
							    "GFER064A",{|oReport| Iif(GFR63VLPER("GFER064A",.F.),ReportPrint(oReport),oReport:CancelPrint())},"")
							    
	oReport:SetLandscape()
	oReport:HideParamPage()
	oReport:SetTotalInLine(.F.)
	
	oSctnHide := TrSection():New(oReport,"",{"GV8"} ,{'-'})
	
	oSctnHide:Hide()
	oSctnHide:Disable()
	oSctnHide:lReadOnly := .T.
	oSctnHide:lUserVisible := .F.
	
	oSecInfo := TrSection():New(oReport,"Relatório Comparativo de Tarifas",{(cAli)} ,aOrdem)
	
	TrCell():New(oSecInfo , "CIDORI"            , ""       , "Cidade Origem",,,,{|| cNmCidOr })
	TrCell():New(oSecInfo , "UFDST"             , ""       , "Uf Destino",,,,{|| cUFDestino })
	TrCell():New(oSecInfo , "COMPT"             , ""       , "Componente",,,,{|| cCmpnt })
	
	oSection := TrSection():New(oReport,"Relatório Comparativo de Tarifas",{(cAli)} ,aOrdem)
	
	TrCell():New(oSection, "(cAli)->GU7_NMCID"		,"(cAli)",	"Cid. Destino")
	TrCell():New(oSection, "cNmTrpA"				,""		 ,	"Transportador A"	,,,,{|| If(!Empty((cAli)->CDFXTV1),cNmTrpA,"") })
	TrCell():New(oSection, "(cAli)->NRTAB1"			,"(cAli)",	"Tabela A"			,,,,{|| If(!Empty((cAli)->CDFXTV1),(cAli)->NRTAB1,"") })
	TrCell():New(oSection, "(cAli)->NRNEG1"			,"(cAli)",	"Negociação A"		,,,,{|| If(!Empty((cAli)->CDFXTV1),(cAli)->NRNEG1,"") })
	TrCell():New(oSection, "(cAli)->NRROTA1"		,"(cAli)",	"Nr Rota A"			,,,,{|| If(!Empty((cAli)->CDFXTV1),(cAli)->NRROTA1,"")})
	TrCell():New(oSection, "(cAli)->CDFXTV1"		,"(cAli)",	"Cód Faixa A")
	TrCell():New(oSection, "(cAli)->VALOR1"			,"(cAli)",	"Vl Componente A"	,,,,{|| Iif(!Empty((cAli)->CDFXTV1),Transform((cAli)->VALOR1, PESQPICT("GV1",cTipoValor)),"") })
	TrCell():New(oSection, "cNmTrpB"				,""		 ,	"Transportador B"	,,,,{|| If(!Empty((cAli)->CDFXTV2),cNmTrpB,"") })
	TrCell():New(oSection, "(cAli)->NRTAB2"			,"(cAli)",	"Tabela B"			,,,,{|| If(!Empty((cAli)->CDFXTV2),(cAli)->NRTAB2,"") })
	TrCell():New(oSection, "(cAli)->NRNEG2"			,"(cAli)",	"Negociação B"		,,,,{|| If(!Empty((cAli)->CDFXTV2),(cAli)->NRNEG2,"") })
	TrCell():New(oSection, "(cAli)->NRROTA2"		,"(cAli)",	"Nr Rota B"			,,,,{|| If(!Empty((cAli)->CDFXTV2),(cAli)->NRROTA2,"")})
	TrCell():New(oSection, "(cAli)->CDFXTV2"		,"(cAli)",	"Cód Faixa B")
	TrCell():New(oSection, "(cAli)->VALOR2"			,"(cAli)",	"Vl Componente B"	,,,,{|| Iif(!Empty((cAli)->CDFXTV2),Transform((cAli)->VALOR2, PESQPICT("GV1",cTipoValor)),"") })
	TrCell():New(oSection, ""						,""		 ,	"Dif Valor" 		,,,,{|| CompDif((cAli)->VALOR1, (cAli)->VALOR2, (cAli)->CDFXTV1, (cAli)->CDFXTV2) })
	TrCell():New(oSection, ""						,""		 ,	"% Dif Valor"		,,,,{|| CompPctDif((cAli)->VALOR1, (cAli)->VALOR2) })
	TrCell():New(oSection,"OBSERVA"          		, ""     , "OBS:",,,,{||OutrosVal()})
Return oReport

/*/{Protheus.doc} CalcDif
Calcula a diferença de valor entre as tarifas dos componentes de frete para a cidade do Transportador A x Transportador B
@author Alexandre José Cuchi
@since 12/02/2015
@version 1.0
@param nValCompA, numérico, valor do componente A
@param nValCompB, numérico, valor do componente B
@param cCdFxTv1, numérico, faixa do componente A
@param cCdFxTv2, numérico, faixa do componente B
@return cDif, Diferença entre os valores dos componentes
/*/
Static Function CompDif(nValCompA, nValCompB, cCdFxTv1, cCdFxTv2)
	Local cDif := ""
	
	If Empty(cCdFxTv1) .Or. Empty(cCdFxTv2)
		cDif := "-"
	Else	
		cDif := Transform( ABS(nValCompB - nValCompA) , PESQPICT("GV1",cTipoValor))
	EndIf
Return cDif

/*/{Protheus.doc} CompPctDif
Calcula o percentual de diferença de valor entre as tarifas dos componentes de frete para a cidade do Transportador A x Transportador B
@author Alexandre José Cuchi
@since 12/02/2015
@version 1.0
@param nValCompA, numérico, valor do componente A
@param nValCompB, numérico, valor do componente B
@return cPctDif, percentual de diferença entre os valores dos componentes
/*/
Static Function CompPctDif(nValCompA, nValCompB)
	Local cPctDif := 0
	
	If nValCompA == 0 .Or. nValCompB == 0
		cPctDif := "-"
	Else
		cPctDif := AllTrim(Transform( (ABS(nValCompB - nValCompA) / nValCompA * 100), "@E 99,999.99"))
	EndIf
Return cPctDif

/*/{Protheus.doc}ReportPrint
As duas consultas tem um retorno semelhante.                                                                   
A diferença entre elas é o fato de na primeira consulta foi informado a UF de destino,                         
e será conciderada todas as rodas com origem na cidade escolhida e destino a UF informada,                     
já na segunda consulta, não foi informado a UF, logo só serão conciderados rotas com origem a cidade escolhida;

@Author Alexandre José Cuchi
@Since15/10/2014
@Version 1.0
/*/
Static Function ReportPrint(oReport)
	Local cQuery     := ""
	Local aGCList 
	Local oSecInfo   := oReport:Section(2)
	Local oSection   := oReport:Section(3)
	Local cFiliais   := ''
	Local nX         := 0
	Local cTmp		 := ""
	Local lImprimir
	
	If oReport:Cancel()
		Return
	EndIf
	
	cCmpnt     := MV_PAR01              // código do componente                        
	cTipoValor := BuscaCampo(MV_PAR02)  // Tipo do campo para comparação               
	cCidOrigem := MV_PAR03              // Cidade de origem da rota                    
	cUFDestino := MV_PAR04              // UF destino da rota                          
	cTranspA   := MV_PAR05              // Código do primeiro transportador            
	cFxTpVcA   := MV_PAR06              // Sequencia de faixa do primeiro transportador
	cNegA      := MV_PAR07              // Negociação da primeira tabela de frete      
	cTabelaA   := MV_PAR08              // Tabela de frete do primeiro transportador   
	cTranspB   := MV_PAR09              // Código do segundo transportador             
	cFxTpVcB   := MV_PAR10              // Sequencia de faixa do segundo transportador 
	cNegB      := MV_PAR11              // Negociação da segunda tabela de frete       
	cTabelaB   := MV_PAR12              // Numero da tabela de frete      
	
	cNmCidOr   := BuscCid(xFilial("GU7"), cCidOrigem)
	cNmTrpA	   := Posicione("GU3",1,xFilial("GU3")+cTranspA,"GU3_NMEMIT")
	cNmTrpB	   := Posicione("GU3",1,xFilial("GU3")+cTranspB,"GU3_NMEMIT")
	
	aGCList := oReport:GetGCList()// Função retorna array com filiais que o usuário tem acesso
	
	If !Empty(aGCList)
		cFiliais += '('
		For nX := 1 To Len(aGCList)
			If nX != 1
				cFiliais += ","
			EndIf
			cFiliais += "'"+aGCList[nX]+"'"
		Next nX
		cFiliais += ")"
	EndIf
	
	cAli := CriaTab()
	/*
		A consulta funciona da seguinte maneira
		1) Busca rotas válidas (conforme parâmetros) para o transportador A
		2) Busca rotas válidas (conforme parâmetros) para o transportador B
		3) Cruza as rotas que tenham como destino a mesma cidade
		4) Busca as tarifas de cada negociação para o componente do parâmetro
		
		Após a consulta, não são impressas as rotas de "Demais cidades" (TPDEST=3), que já tenham uma rota para a mesma cidade.
	*/
	cQuery += "SELECT ROTAS.GU7_NMCID,"
	cQuery += "	   ROTAS.GU7_NRCID,"
	cQuery += "	   ROTAS.GV8_FILIAL,"
	cQuery += "	   ROTAS.TPDEST1,"
	cQuery += "	   ROTAS.CDEMIT1," 
	cQuery += "	   ROTAS.NRTAB1," 
	cQuery += "	   ROTAS.NRNEG1,	   	   " 
	cQuery += "	   ROTAS.NRROTA1,	   " 
	cQuery += "	   GV1_1.GV1_CDFXTV CDFXTV1," 
	cQuery += "       GV1_1.GV1_CDCOMP CDCOMP1," 
	cQuery += "       GV1_1."+cTipoValor+" VALOR1," 
	cQuery += "	   ROTAS.TPDEST2," 
	cQuery += "	   ROTAS.CDEMIT2,	   	   " 
	cQuery += "	   ROTAS.NRTAB2," 
	cQuery += "	   ROTAS.NRNEG2,	   	   " 
	cQuery += "	   ROTAS.NRROTA2,	       " 
	cQuery += "       GV1_2.GV1_CDFXTV CDFXTV2," 
	cQuery += "       GV1_2.GV1_CDCOMP CDCOMP2," 
	cQuery += "       GV1_2."+cTipoValor+" VALOR2"
	cQuery += "  FROM  ("
	cQuery += "  SELECT NEG_1.GU7_NMCID, NEG_1.GU7_NRCID, NEG_1.GV8_FILIAL,"
	cQuery += "       NEG_1.TPDESTINO  TPDEST1,"
	cQuery += "       NEG_1.GV8_CDEMIT CDEMIT1,"
	cQuery += "       NEG_1.GV8_NRTAB  NRTAB1,"
	cQuery += "       NEG_1.GV8_NRNEG  NRNEG1,"
	cQuery += "       NEG_1.GV8_NRROTA NRROTA1,"
	cQuery += "       NEG_2.TPDESTINO  TPDEST2,"
	cQuery += "       NEG_2.GV8_CDEMIT CDEMIT2,"
	cQuery += "       NEG_2.GV8_NRTAB  NRTAB2,"
	cQuery += "       NEG_2.GV8_NRNEG  NRNEG2,"
	cQuery += "       NEG_2.GV8_NRROTA NRROTA2"
	cQuery += "  FROM ("
	cQuery += "		SELECT GU7.GU7_NMCID,GU7.GU7_NRCID, TRANSP1.TPDESTINO, GV8_CDEMIT, GV8_NRTAB, GV8_NRNEG, GV8_NRROTA, GV8_FILIAL"
	cQuery += "		  FROM "+RetSQLName("GU7")+" GU7"
	cQuery += "		 INNER JOIN ("
	cQuery += "		  SELECT"
	cQuery += "		       CASE "
	cQuery += "		      	WHEN COALESCE(GU7DEST1.GU7_NRCID, GU7DEST2.GU7_NRCID, GU7DEST3.GU7_NRCID, GU7DEST4.GU7_NRCID) IS NOT NULL THEN COALESCE(GU7DEST1.GU7_NRCID, GU7DEST2.GU7_NRCID, GU7DEST3.GU7_NRCID, GU7DEST4.GU7_NRCID)"
	cQuery += "		       END NRCIDD,"
	cQuery += "		       CASE "
	cQuery += "		      	WHEN COALESCE(GU7DEST1.GU7_NMCID, GU7DEST2.GU7_NMCID, GU7DEST3.GU7_NMCID, GU7DEST4.GU7_NMCID) IS NOT NULL THEN '1'"
	cQuery += "		      	WHEN GV8.GV8_TPDEST = '4' AND GV8.GV8_CDUFDS = '"+cUFDestino+"' THEN '4'"
	cQuery += "		      	WHEN GV8.GV8_DUPSEN = '1' AND GV8.GV8_TPORIG = '4' AND GV8.GV8_CDUFOR = '"+cUFDestino+"' THEN '4'"
	cQuery += "		      	WHEN GV8.GV8_TPDEST = '3' OR (GV8.GV8_DUPSEN = '1' AND GV8.GV8_TPORIG = '3') THEN '3'"
	cQuery += "		       END TPDESTINO,"
	cQuery += "			   GV8.GV8_CDEMIT,"
	cQuery += "			   GV8.GV8_NRTAB,"
	cQuery += "			   GV8.GV8_NRNEG,"
	cQuery += "			   GV8.GV8_NRROTA,"
	cQuery += "			   GV8.GV8_FILIAL"	
	cQuery += "	 	  FROM "+RetSQLName("GV8")+" GV8"
	cQuery += "	 	  LEFT JOIN "+RetSQLName("GU7")+" GU7ORIGEM ON GU7ORIGEM.GU7_NRCID  = '"+cCidOrigem+"'"
	cQuery += "	  						     	AND GU7ORIGEM.D_E_L_E_T_ = ' '"
	cQuery += "		  LEFT JOIN "+RetSQLName("GU7")+" GU7DEST1 ON GU7DEST1.GU7_NRCID  = GV8.GV8_NRCIDS"
	cQuery += "		    					   AND GU7DEST1.D_E_L_E_T_ = ' '"
	cQuery += "		    					   AND GV8.GV8_TPDEST = '1'"
	cQuery += "		    					   AND GU7DEST1.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += "		  LEFT JOIN "+RetSQLName("GU7")+" GU7DEST2 ON GU7DEST2.GU7_NRCID  = GV8.GV8_NRCIOR"
	cQuery += "		    					   AND GU7DEST2.D_E_L_E_T_ = ' '"
	cQuery += "		    					   AND GV8.GV8_TPORIG      = '1'"
	cQuery += "		    					   AND GV8.GV8_DUPSEN      = '1'"
	cQuery += "		    					   AND GU7DEST2.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += "		  LEFT JOIN "+RetSQLName("GUA")+" GUADEST1 ON GUADEST1.GUA_NRREG = GV8.GV8_NRREDS"
	cQuery += "		  						   AND GUADEST1.D_E_L_E_T_ = ' '"
	cQuery += "		  						   AND GV8.GV8_TPDEST = '3'		 "
	cQuery += "		  LEFT JOIN "+RetSQLName("GU7")+" GU7DEST3 ON GU7DEST3.GU7_NRCID  = GUADEST1.GUA_NRCID"
	cQuery += "		    					   AND GU7DEST3.D_E_L_E_T_ = ' '"
	cQuery += "		    					   AND GU7DEST3.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += "		  LEFT JOIN "+RetSQLName("GUA")+" GUADEST2 ON GUADEST2.GUA_NRREG = GV8.GV8_NRREOR"
	cQuery += "		  						   AND GUADEST2.D_E_L_E_T_ = ' '"
	cQuery += "		  						   AND GV8.GV8_TPORIG = '3'"
	cQuery += "		  						   AND GV8.GV8_DUPSEN = '1'"
	cQuery += "		  LEFT JOIN "+RetSQLName("GU7")+" GU7DEST4 ON GU7DEST4.GU7_NRCID  = GUADEST2.GUA_NRCID"
	cQuery += "		    					   AND GU7DEST4.D_E_L_E_T_ = ' '"
	cQuery += "		    					   AND GU7DEST4.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += "		 	 WHERE GV8.GV8_FILIAL = '"+cFiliais+"'"
	cQuery += "		 	   AND GV8.GV8_CDEMIT = '"+cTranspA+"'"
	cQuery += "		 	   AND GV8.GV8_NRTAB  = '"+cTabelaA+"'"
	cQuery += "		 	   AND GV8.GV8_NRNEG  = '"+cNegA+"'"
	cQuery += "		 	   AND GV8.D_E_L_E_T_ = ' '"
	cQuery += "		 	   AND GV8.GV8_TPORIG IN ( '1', '3', '4' )"
	cQuery += "		   	   AND GV8.GV8_TPDEST IN ( '1', '3', '4' )"
	cQuery += "		   	   AND ( "
	cQuery += "	   	      ("
	cQuery += "		   	      (GV8.GV8_TPORIG = '1' AND GU7ORIGEM.GU7_NRCID = GV8.GV8_NRCIOR) OR "
	cQuery += "		   	      (GV8.GV8_TPORIG = '4' AND GU7ORIGEM.GU7_CDUF  = GV8.GV8_CDUFOR) OR "
	cQuery += "		   	      (GV8.GV8_TPORIG = '3' AND (GV8.GV8_NRREOR IN   (SELECT DISTINCT GUA_NRREG"
	cQuery += "																	     FROM "+RetSQLName("GUA")+""
	cQuery += "																	    WHERE GUA_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	      AND D_E_L_E_T_ = ' ') "
	cQuery += "						   	      							OR"
	cQuery += "															"
	cQuery += "															EXISTS (SELECT GU9_NRREG "
	cQuery += "																	  FROM "+RetSQLName("GU7")+" GU7"
	cQuery += "																	 INNER JOIN "+RetSQLName("GU9")+" GU9 ON GU9_CDUF = GU7_CDUF"
	cQuery += "																	  				  AND GU9_DEMCID = '1'"
	cQuery += "																	 WHERE GU9_NRREG  = GV8.GV8_NRREOR"
	cQuery += "																	   AND GU7_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	   AND GU7.D_E_L_E_T_ = ' ' "
	cQuery += "																	   AND GU9.D_E_L_E_T_ = ' ')"
	cQuery += "											)"
	cQuery += "				  )"
	cQuery += "			  )"
	cQuery += "		      OR"
	cQuery += "		      ("
	cQuery += "		      	  GV8.GV8_DUPSEN = '1' AND"
	cQuery += "		      	  ("
	cQuery += "			   	      (GV8.GV8_TPDEST = '1' AND GU7ORIGEM.GU7_NRCID = GV8.GV8_NRCIDS) OR"
	cQuery += "			   	      (GV8.GV8_TPDEST = '4' AND GU7ORIGEM.GU7_CDUF  = GV8.GV8_CDUFDS) OR"
	cQuery += "			   	      (GV8.GV8_TPDEST = '3' AND (GV8.GV8_NRREDS IN   (SELECT DISTINCT GUA_NRREG"
	cQuery += "																		     FROM "+RetSQLName("GUA")+""
	cQuery += "																		    WHERE GUA_NRCID = '"+cCidOrigem+"'"
	cQuery += "																		      AND D_E_L_E_T_ = ' ')"
	cQuery += "			   	      											OR "
	cQuery += "			   	      											EXISTS (SELECT GU9_NRREG "
	cQuery += "																	  FROM "+RetSQLName("GU7")+" GU7"
	cQuery += "																	 INNER JOIN "+RetSQLName("GU9")+" GU9 ON GU9_CDUF = GU7_CDUF"
	cQuery += "																	  				  AND GU9_DEMCID = '1'"
	cQuery += "																	 WHERE GU9_NRREG  = GV8.GV8_NRREDS"
	cQuery += "																	   AND GU7_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	   AND GU7.D_E_L_E_T_ = ' ' "
	cQuery += "																	   AND GU9.D_E_L_E_T_ = ' ')"
	cQuery += "			   	      							)"
	cQuery += "			   	      )  "
	cQuery += "				  )"
	cQuery += "		      )"
	cQuery += "	       )"
cQuery += "	   AND ( ( "
	cQuery += "	   	      ("
	cQuery += "		   	      (GV8.GV8_TPORIG = '1' AND GU7ORIGEM.GU7_NRCID = GV8.GV8_NRCIOR) OR "
	cQuery += "		   	      (GV8.GV8_TPORIG = '4' AND GU7ORIGEM.GU7_CDUF  = GV8.GV8_CDUFOR) OR "
	cQuery += "		   	      (GV8.GV8_TPORIG = '3' AND (GV8.GV8_NRREOR IN   (SELECT DISTINCT GUA_NRREG"
	cQuery += "																	     FROM " + RetSqlName("GUA")
	cQuery += "																	    WHERE GUA_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	      AND D_E_L_E_T_ = ' ') "
	cQuery += "						   	      							OR"
	cQuery += "															"
	cQuery += "															EXISTS (SELECT GU9_NRREG "
	cQuery += "																	  FROM " + RetSqlName("GU7") + " GU7 "
	cQuery += "																	 INNER JOIN " + RetSqlName("GU9") + " GU9 ON GU9_CDUF = GU7_CDUF"
	cQuery += "																	  				  AND GU9_DEMCID = '1'"
	cQuery += "																	 WHERE GU9_NRREG  = GV8.GV8_NRREOR"
	cQuery += "																	   AND GU7_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	   AND GU7.D_E_L_E_T_ = ' ' "
	cQuery += "																	   AND GU9.D_E_L_E_T_ = ' ')"
	cQuery += "											)"
	cQuery += "				  )"
	cQuery += "			  )"
	cQuery += "	       AND " //**** 
	cQuery += "	   	      ("
	cQuery += "		   	      (GV8.GV8_TPDEST = '1' AND EXISTS (SELECT 1 FROM " + RetSqlName("GU7") + " WHERE GU7_NRCID = GV8.GV8_NRCIDS AND GU7_CDUF = '"+cUFDestino+"' AND D_E_L_E_T_ = ' ') ) OR "
	cQuery += "		   	      (GV8.GV8_TPDEST = '4' AND GV8.GV8_CDUFDS = '"+cUFDestino+"' ) OR "
	cQuery += "		   	      (GV8.GV8_TPDEST = '3' AND (GV8.GV8_NRREDS IN (SELECT DISTINCT GUA_NRREG"
	cQuery += "													     FROM " + RetSqlName("GUA") + " GUA "
	cQuery += "													    INNER JOIN " + RetSqlName("GU7") + " GU7 ON GU7_NRCID = GUA_NRCID"
	cQuery += "													    WHERE GU7_CDUF = '"+cUFDestino+"'"
	cQuery += "													      AND GUA.D_E_L_E_T_ = ' '"
	cQuery += "													      AND GU7.D_E_L_E_T_ = ' ')"
	cQuery += ""
	cQuery += "		   	      										OR"
	cQuery += ""
	cQuery += "		   	      							 GV8.GV8_NRREDS IN (SELECT GU9_NRREG "
	cQuery += "		   	      							 	                  FROM " + RetSqlName("GU9")
	cQuery += "		   	      							 	                 WHERE GU9_DEMCID = '1' "
	cQuery += "		   	      							 	                   AND GU9_CDUF = '"+cUFDestino+"' "
	cQuery += "		   	      							 	                   AND D_E_L_E_T_ = '')"
	cQuery += "		   	     							)"
	cQuery += "		   	     	)"
	cQuery += "			  )"
	cQuery += "	       ) "
	cQuery += " OR ( " 
	cQuery += "		      	  GV8.GV8_DUPSEN = '1' AND "
	cQuery += "		      	  ("
	cQuery += "			   	      (GV8.GV8_TPDEST = '1' AND GU7ORIGEM.GU7_NRCID = GV8.GV8_NRCIDS) OR"
	cQuery += "			   	      (GV8.GV8_TPDEST = '4' AND GU7ORIGEM.GU7_CDUF  = GV8.GV8_CDUFDS) OR"
	cQuery += "			   	      (GV8.GV8_TPDEST = '3' AND (GV8.GV8_NRREDS IN   (SELECT DISTINCT GUA_NRREG"
	cQuery += "																		     FROM " + RetSqlName("GUA")
	cQuery += "																		    WHERE GUA_NRCID = '"+cCidOrigem+"'"
	cQuery += "																		      AND D_E_L_E_T_ = ' ')"
	cQuery += "			   	      											OR "
	cQuery += ""
	cQuery += "			   	      											EXISTS (SELECT GU9_NRREG "
	cQuery += "																	  FROM " + RetSqlName("GU7") + " GU7 "
	cQuery += "																	 INNER JOIN " + RetSqlName("GU9") + " GU9 ON GU9_CDUF = GU7_CDUF"
	cQuery += "																	  				  AND GU9_DEMCID = '1'"
	cQuery += "																	 WHERE GU9_NRREG  = GV8.GV8_NRREDS"
	cQuery += "																	   AND GU7_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	   AND GU7.D_E_L_E_T_ = ' ' "
	cQuery += "																	   AND GU9.D_E_L_E_T_ = ' ')"
	cQuery += "			   	      							)"
	cQuery += "			   	      )   "
	cQuery += "				  )"
	cQuery += "		      )"
	cQuery += "		      AND ("
	cQuery += "			   	      (GV8.GV8_TPORIG = '1' AND EXISTS (SELECT 1 FROM " + RetSqlName("GU7") + " WHERE GU7_NRCID = GV8.GV8_NRCIOR AND GU7_CDUF = '"+cUFDestino+"' AND D_E_L_E_T_ = ' ') ) OR"
	cQuery += "			   	      (GV8.GV8_TPORIG = '4' AND GV8.GV8_CDUFOR = '"+cUFDestino+"' ) OR "
	cQuery += "			   	      (GV8.GV8_TPORIG = '3' AND (GV8.GV8_NRREOR IN (SELECT DISTINCT GUA_NRREG"
	cQuery += "														     FROM " + RetSqlName("GUA") + " GUA "
	cQuery += "														    INNER JOIN " + RetSqlName("GU7") + " GU7 ON GU7_NRCID = GUA_NRCID"
	cQuery += "														    WHERE GU7_CDUF = '"+cUFDestino+"'"
	cQuery += "														      AND GUA.D_E_L_E_T_ = ' '"
	cQuery += "														      AND GU7.D_E_L_E_T_ = ' '))"
	cQuery += "			   	      							 OR"
	cQuery += "			   	      							 GV8.GV8_NRREOR IN (SELECT GU9_NRREG "
	cQuery += "		   	      							 	                  FROM " + RetSqlName("GU9")
	cQuery += "		   	      							 	                 WHERE GU9_DEMCID = '1' "
	cQuery += "		   	      							 	                   AND GU9_CDUF = '"+cUFDestino+"' "
	cQuery += "		   	      							 	                   AND D_E_L_E_T_ = '')"
	cQuery += "			   	      							)"
	cQuery += "				  )	        "
	cQuery += "	       )) "  // **
	cQuery += "	 TRANSP1 ON ( ( TRANSP1.TPDESTINO = '1' AND GU7.GU7_NRCID = TRANSP1.NRCIDD ) OR  "
	cQuery += "		      		                ( TRANSP1.TPDESTINO = '4' AND GU7.GU7_CDUF = '"+cUFDestino+"' ) OR"
	cQuery += "		      		                ( TRANSP1.TPDESTINO = '3' AND GU7.GU7_CDUF = '"+cUFDestino+"' ) )"
	cQuery += "  ) NEG_1"
	cQuery += "  FULL OUTER JOIN ("
	cQuery += "  			SELECT GU7.GU7_NMCID,GU7.GU7_NRCID, TRANSP1.TPDESTINO, GV8_CDEMIT, GV8_NRTAB, GV8_NRNEG, GV8_NRROTA,GV8_FILIAL"
	cQuery += "		  FROM "+RetSQLName("GU7")+" GU7"
	cQuery += "		 INNER JOIN ("
	cQuery += "		  SELECT"
	cQuery += "		       CASE "
	cQuery += "		      	WHEN COALESCE(GU7DEST1.GU7_NRCID, GU7DEST2.GU7_NRCID, GU7DEST3.GU7_NRCID, GU7DEST4.GU7_NRCID) IS NOT NULL THEN COALESCE(GU7DEST1.GU7_NRCID, GU7DEST2.GU7_NRCID, GU7DEST3.GU7_NRCID, GU7DEST4.GU7_NRCID)"
	cQuery += "		       END NRCIDD,"
	cQuery += "		       CASE "
	cQuery += "		      	WHEN COALESCE(GU7DEST1.GU7_NMCID, GU7DEST2.GU7_NMCID, GU7DEST3.GU7_NMCID, GU7DEST4.GU7_NMCID) IS NOT NULL THEN '1'"
	cQuery += "		      	WHEN GV8.GV8_TPDEST = '4' AND GV8.GV8_CDUFDS = '"+cUFDestino+"' THEN '4'"
	cQuery += "		      	WHEN GV8.GV8_DUPSEN = '1' AND GV8.GV8_TPORIG = '4' AND GV8.GV8_CDUFOR = '"+cUFDestino+"' THEN '4'"
	cQuery += "		      	WHEN GV8.GV8_TPDEST = '3' OR (GV8.GV8_DUPSEN = '1' AND GV8.GV8_TPORIG = '3') THEN '3'"
	cQuery += "		       END TPDESTINO,"
	cQuery += "			   GV8.GV8_CDEMIT,"
	cQuery += "			   GV8.GV8_NRTAB,"
	cQuery += "			   GV8.GV8_NRNEG,"
	cQuery += "			   GV8.GV8_NRROTA,"
	cQuery += "			   GV8.GV8_FILIAL"
	cQuery += "	 	  FROM "+RetSQLName("GV8")+" GV8"
	cQuery += "	 	  LEFT JOIN "+RetSQLName("GU7")+" GU7ORIGEM ON GU7ORIGEM.GU7_NRCID  = '"+cCidOrigem+"'"
	cQuery += "	  						     	AND GU7ORIGEM.D_E_L_E_T_ = ' '"
	cQuery += "		  LEFT JOIN "+RetSQLName("GU7")+" GU7DEST1 ON GU7DEST1.GU7_NRCID  = GV8.GV8_NRCIDS"
	cQuery += "		    					   AND GU7DEST1.D_E_L_E_T_ = ' '"
	cQuery += "		    					   AND GV8.GV8_TPDEST = '1'"
	cQuery += "		    					   AND GU7DEST1.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += "		  LEFT JOIN "+RetSQLName("GU7")+" GU7DEST2 ON GU7DEST2.GU7_NRCID  = GV8.GV8_NRCIOR"
	cQuery += "		    					   AND GU7DEST2.D_E_L_E_T_ = ' '"
	cQuery += "		    					   AND GV8.GV8_TPORIG      = '1'"
	cQuery += "		    					   AND GV8.GV8_DUPSEN      = '1'"
	cQuery += "		    					   AND GU7DEST2.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += "		  LEFT JOIN "+RetSQLName("GUA")+" GUADEST1 ON GUADEST1.GUA_NRREG = GV8.GV8_NRREDS"
	cQuery += "		  						   AND GUADEST1.D_E_L_E_T_ = ' '"
	cQuery += "		  						   AND GV8.GV8_TPDEST = '3'		 "
	cQuery += "		  LEFT JOIN "+RetSQLName("GU7")+" GU7DEST3 ON GU7DEST3.GU7_NRCID  = GUADEST1.GUA_NRCID"
	cQuery += "		    					   AND GU7DEST3.D_E_L_E_T_ = ' '"
	cQuery += "		    					   AND GU7DEST3.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += "		  LEFT JOIN "+RetSQLName("GUA")+" GUADEST2 ON GUADEST2.GUA_NRREG = GV8.GV8_NRREOR"
	cQuery += "		  						   AND GUADEST2.D_E_L_E_T_ = ' '"
	cQuery += "		  						   AND GV8.GV8_TPORIG = '3'"
	cQuery += "		  						   AND GV8.GV8_DUPSEN = '1'"
	cQuery += "		  LEFT JOIN "+RetSQLName("GU7")+" GU7DEST4 ON GU7DEST4.GU7_NRCID  = GUADEST2.GUA_NRCID"
	cQuery += "		    					   AND GU7DEST4.D_E_L_E_T_ = ' '"
	cQuery += "		    					   AND GU7DEST4.GU7_CDUF   = '"+cUFDestino+"'	  						     	"
	cQuery += "		 	 WHERE GV8.GV8_FILIAL = '"+cFiliais+"'"
	cQuery += "		 	   AND GV8.GV8_CDEMIT = '"+cTranspB+"'"
	cQuery += "		 	   AND GV8.GV8_NRTAB  = '"+cTabelaB+"'"
	cQuery += "		 	   AND GV8.GV8_NRNEG  = '"+cNegB+"'"
	cQuery += "		 	   AND GV8.D_E_L_E_T_ = ' '"
	cQuery += "		 	   AND GV8.GV8_TPORIG IN ( '1', '3', '4' )"
	cQuery += "		   	   AND GV8.GV8_TPDEST IN ( '1', '3', '4' )"
	cQuery += "		   	   AND ( "
	cQuery += "	   	      ("
	cQuery += "		   	      (GV8.GV8_TPORIG = '1' AND GU7ORIGEM.GU7_NRCID = GV8.GV8_NRCIOR) OR "
	cQuery += "		   	      (GV8.GV8_TPORIG = '4' AND GU7ORIGEM.GU7_CDUF  = GV8.GV8_CDUFOR) OR "
	cQuery += "		   	      (GV8.GV8_TPORIG = '3' AND (GV8.GV8_NRREOR IN   (SELECT DISTINCT GUA_NRREG"
	cQuery += "																	     FROM "+RetSQLName("GUA")+""
	cQuery += "																	    WHERE GUA_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	      AND D_E_L_E_T_ = ' ') "
	cQuery += "						   	      							OR"
	cQuery += "															EXISTS (SELECT GU9_NRREG "
	cQuery += "																	  FROM "+RetSQLName("GU7")+" GU7"
	cQuery += "																	 INNER JOIN "+RetSQLName("GU9")+" GU9 ON GU9_CDUF = GU7_CDUF"
	cQuery += "																	  				  AND GU9_DEMCID = '1'"
	cQuery += "																	 WHERE GU9_NRREG  = GV8.GV8_NRREOR"
	cQuery += "																	   AND GU7_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	   AND GU7.D_E_L_E_T_ = ' ' "
	cQuery += "																	   AND GU9.D_E_L_E_T_ = ' ')"
	cQuery += "											)"
	cQuery += "				  )"
	cQuery += "			  )"
	cQuery += "		      OR"
	cQuery += "		      ("
	cQuery += "		      	  GV8.GV8_DUPSEN = '1' AND"
	cQuery += "		      	  ("
	cQuery += "			   	      (GV8.GV8_TPDEST = '1' AND GU7ORIGEM.GU7_NRCID = GV8.GV8_NRCIDS) OR"
	cQuery += "			   	      (GV8.GV8_TPDEST = '4' AND GU7ORIGEM.GU7_CDUF  = GV8.GV8_CDUFDS) OR"
	cQuery += "			   	      (GV8.GV8_TPDEST = '3' AND (GV8.GV8_NRREDS IN   (SELECT DISTINCT GUA_NRREG"
	cQuery += "																		     FROM "+RetSQLName("GUA")+""
	cQuery += "																		    WHERE GUA_NRCID = '"+cCidOrigem+"'"
	cQuery += "																		      AND D_E_L_E_T_ = ' ')"
	cQuery += "			   	      											OR "
	cQuery += "			   	      											EXISTS (SELECT GU9_NRREG "
	cQuery += "																	  FROM "+RetSQLName("GU7")+" GU7"
	cQuery += "																	 INNER JOIN "+RetSQLName("GU9")+" GU9 ON GU9_CDUF = GU7_CDUF"
	cQuery += "																	  				  AND GU9_DEMCID = '1'"
	cQuery += "																	 WHERE GU9_NRREG  = GV8.GV8_NRREDS"
	cQuery += "																	   AND GU7_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	   AND GU7.D_E_L_E_T_ = ' ' "
	cQuery += "																	   AND GU9.D_E_L_E_T_ = ' ')"
	cQuery += "			   	      							)"
	cQuery += "			   	      )  "
	cQuery += "				  )"
	cQuery += "		      )"
	cQuery += "	       )"
cQuery += "	   AND ( ( "
	cQuery += "	   	      ("
	cQuery += "		   	      (GV8.GV8_TPORIG = '1' AND GU7ORIGEM.GU7_NRCID = GV8.GV8_NRCIOR) OR "
	cQuery += "		   	      (GV8.GV8_TPORIG = '4' AND GU7ORIGEM.GU7_CDUF  = GV8.GV8_CDUFOR) OR "
	cQuery += "		   	      (GV8.GV8_TPORIG = '3' AND (GV8.GV8_NRREOR IN   (SELECT DISTINCT GUA_NRREG"
	cQuery += "																	     FROM " + RetSqlName("GUA")
	cQuery += "																	    WHERE GUA_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	      AND D_E_L_E_T_ = ' ') "
	cQuery += "						   	      							OR"
	cQuery += "															"
	cQuery += "															EXISTS (SELECT GU9_NRREG "
	cQuery += "																	  FROM " + RetSqlName("GU7") + " GU7 "
	cQuery += "																	 INNER JOIN " + RetSqlName("GU9") + " GU9 ON GU9_CDUF = GU7_CDUF"
	cQuery += "																	  				  AND GU9_DEMCID = '1'"
	cQuery += "																	 WHERE GU9_NRREG  = GV8.GV8_NRREOR"
	cQuery += "																	   AND GU7_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	   AND GU7.D_E_L_E_T_ = ' ' "
	cQuery += "																	   AND GU9.D_E_L_E_T_ = ' ')"
	cQuery += "											)"
	cQuery += "				  )"
	cQuery += "			  )"
	cQuery += "	       AND " //**** 
	cQuery += "	   	      ("
	cQuery += "		   	      (GV8.GV8_TPDEST = '1' AND EXISTS (SELECT 1 FROM " + RetSqlName("GU7") + " WHERE GU7_NRCID = GV8.GV8_NRCIDS AND GU7_CDUF = '"+cUFDestino+"' AND D_E_L_E_T_ = ' ') ) OR "
	cQuery += "		   	      (GV8.GV8_TPDEST = '4' AND GV8.GV8_CDUFDS = '"+cUFDestino+"' ) OR "
	cQuery += "		   	      (GV8.GV8_TPDEST = '3' AND (GV8.GV8_NRREDS IN (SELECT DISTINCT GUA_NRREG"
	cQuery += "													     FROM " + RetSqlName("GUA") + " GUA "
	cQuery += "													    INNER JOIN " + RetSqlName("GU7") + " GU7 ON GU7_NRCID = GUA_NRCID"
	cQuery += "													    WHERE GU7_CDUF = '"+cUFDestino+"'"
	cQuery += "													      AND GUA.D_E_L_E_T_ = ' '"
	cQuery += "													      AND GU7.D_E_L_E_T_ = ' ')"
	cQuery += ""
	cQuery += "		   	      										OR"
	cQuery += ""
	cQuery += "		   	      							 GV8.GV8_NRREDS IN (SELECT GU9_NRREG "
	cQuery += "		   	      							 	                  FROM " + RetSqlName("GU9")
	cQuery += "		   	      							 	                 WHERE GU9_DEMCID = '1' "
	cQuery += "		   	      							 	                   AND GU9_CDUF = '"+cUFDestino+"' "
	cQuery += "		   	      							 	                   AND D_E_L_E_T_ = '')"
	cQuery += "		   	     							)"
	cQuery += "		   	     	)"
	cQuery += "			  )"
	cQuery += "	       ) "
	cQuery += " OR ( " 
	cQuery += "		      	  GV8.GV8_DUPSEN = '1' AND "
	cQuery += "		      	  ("
	cQuery += "			   	      (GV8.GV8_TPDEST = '1' AND GU7ORIGEM.GU7_NRCID = GV8.GV8_NRCIDS) OR"
	cQuery += "			   	      (GV8.GV8_TPDEST = '4' AND GU7ORIGEM.GU7_CDUF  = GV8.GV8_CDUFDS) OR"
	cQuery += "			   	      (GV8.GV8_TPDEST = '3' AND (GV8.GV8_NRREDS IN   (SELECT DISTINCT GUA_NRREG"
	cQuery += "																		     FROM " + RetSqlName("GUA")
	cQuery += "																		    WHERE GUA_NRCID = '"+cCidOrigem+"'"
	cQuery += "																		      AND D_E_L_E_T_ = ' ')"
	cQuery += "			   	      											OR "
	cQuery += ""
	cQuery += "			   	      											EXISTS (SELECT GU9_NRREG "
	cQuery += "																	  FROM " + RetSqlName("GU7") + " GU7 "
	cQuery += "																	 INNER JOIN " + RetSqlName("GU9") + " GU9 ON GU9_CDUF = GU7_CDUF"
	cQuery += "																	  				  AND GU9_DEMCID = '1'"
	cQuery += "																	 WHERE GU9_NRREG  = GV8.GV8_NRREDS"
	cQuery += "																	   AND GU7_NRCID = '"+cCidOrigem+"'"
	cQuery += "																	   AND GU7.D_E_L_E_T_ = ' ' "
	cQuery += "																	   AND GU9.D_E_L_E_T_ = ' ')"
	cQuery += "			   	      							)"
	cQuery += "			   	      )   "
	cQuery += "				  )"
	cQuery += "		      )"
	cQuery += "		      AND ("
	cQuery += "			   	      (GV8.GV8_TPORIG = '1' AND EXISTS (SELECT 1 FROM " + RetSqlName("GU7") + " WHERE GU7_NRCID = GV8.GV8_NRCIOR AND GU7_CDUF = '"+cUFDestino+"' AND D_E_L_E_T_ = ' ') ) OR"
	cQuery += "			   	      (GV8.GV8_TPORIG = '4' AND GV8.GV8_CDUFOR = '"+cUFDestino+"' ) OR "
	cQuery += "			   	      (GV8.GV8_TPORIG = '3' AND (GV8.GV8_NRREOR IN (SELECT DISTINCT GUA_NRREG"
	cQuery += "														     FROM " + RetSqlName("GUA") + " GUA "
	cQuery += "														    INNER JOIN " + RetSqlName("GU7") + " GU7 ON GU7_NRCID = GUA_NRCID"
	cQuery += "														    WHERE GU7_CDUF = '"+cUFDestino+"'"
	cQuery += "														      AND GUA.D_E_L_E_T_ = ' '"
	cQuery += "														      AND GU7.D_E_L_E_T_ = ' '))"
	cQuery += "			   	      							 OR"
	cQuery += "			   	      							 GV8.GV8_NRREOR IN (SELECT GU9_NRREG "
	cQuery += "		   	      							 	                  FROM " + RetSqlName("GU9")
	cQuery += "		   	      							 	                 WHERE GU9_DEMCID = '1' "
	cQuery += "		   	      							 	                   AND GU9_CDUF = '"+cUFDestino+"' "
	cQuery += "		   	      							 	                   AND D_E_L_E_T_ = '')"
	cQuery += "			   	      							)"
	cQuery += "				  )	        "
	cQuery += "	       )) "  // **
	cQuery += "	 TRANSP1 ON ( ( TRANSP1.TPDESTINO = '1' AND GU7.GU7_NRCID = TRANSP1.NRCIDD ) OR"
	cQuery += "		      		                ( TRANSP1.TPDESTINO = '4' AND GU7.GU7_CDUF = '"+cUFDestino+"' ) OR"
	cQuery += "		      		                ( TRANSP1.TPDESTINO = '3' AND GU7.GU7_CDUF = '"+cUFDestino+"' ) )"
	cQuery += "  ) NEG_2 ON NEG_1.GU7_NRCID = NEG_2.GU7_NRCID ) ROTAS"
	cQuery += " LEFT JOIN "+RetSQLName("GV1")+" GV1_1 ON GV1_1.GV1_FILIAL = ROTAS.GV8_FILIAL"
	cQuery += "                      AND GV1_1.GV1_CDEMIT = ROTAS.CDEMIT1"
	cQuery += "	                   AND GV1_1.GV1_NRTAB  = ROTAS.NRTAB1 "
	cQuery += "	                   AND GV1_1.GV1_NRNEG  = ROTAS.NRNEG1 "
	cQuery += "	                   AND GV1_1.GV1_CDFXTV = '"+cFxTpVcA+"' "
	cQuery += "	                   AND GV1_1.GV1_NRROTA = ROTAS.NRROTA1 "
	cQuery += "	                   AND GV1_1.GV1_CDCOMP = '"+cCmpnt+"'"
	cQuery += "	                   AND GV1_1.D_E_L_E_T_ = ' '"
	cQuery += " LEFT JOIN "+RetSQLName("GV1")+" GV1_2 ON GV1_2.GV1_FILIAL = ROTAS.GV8_FILIAL"
	cQuery += "                      AND GV1_2.GV1_CDEMIT = ROTAS.CDEMIT2"
	cQuery += "	                   AND GV1_2.GV1_NRTAB  = ROTAS.NRTAB2 "
	cQuery += "	                   AND GV1_2.GV1_NRNEG  = ROTAS.NRNEG2"
	cQuery += "	                   AND GV1_2.GV1_CDFXTV = '"+cFxTpVcB+"' "
	cQuery += "	                   AND GV1_2.GV1_NRROTA = ROTAS.NRROTA2 "
	cQuery += "	                   AND GV1_2.GV1_CDCOMP = '"+cCmpnt+"'"
	cQuery += "	                   AND GV1_2.D_E_L_E_T_ = ' '"
	cQuery += "WHERE GV1_1.GV1_CDFXTV != '' OR GV1_2.GV1_CDFXTV != '' "
		
	cTmp     := GetNextAlias()
	cQuery   := ChangeQuery(cQuery)
	dbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery), cTmp, .F.) 
	
	(cTmp)->(dbGoTop())
	
	While !(cTmp)->( Eof())
			
		RecLock(cAli, .T.)
			(cAli)->FILIAL		:= (cTmp)->GV8_FILIAL	 
			(cAli)->GU7_NMCID	:= (cTmp)->GU7_NMCID	 
			(cAli)->GU7_NRCID	:= (cTmp)->GU7_NRCID	 
			(cAli)->TPDEST1		:= (cTmp)->TPDEST1		 
			(cAli)->CDEMIT1		:= (cTmp)->CDEMIT1		
			(cAli)->NRTAB1		:= (cTmp)->NRTAB1		
			(cAli)->NRNEG1		:= (cTmp)->NRNEG1		
			(cAli)->NRROTA1		:= (cTmp)->NRROTA1		
			(cAli)->CDFXTV1		:= (cTmp)->CDFXTV1		
			(cAli)->CDCOMP1		:= (cTmp)->CDCOMP1		  
			(cAli)->VALOR1		:= (cTmp)->VALOR1		  
			(cAli)->TPDEST2		:= (cTmp)->TPDEST2		  
			(cAli)->CDEMIT2		:= (cTmp)->CDEMIT2		  
			(cAli)->NRTAB2		:= (cTmp)->NRTAB2		  
			(cAli)->NRNEG2		:= (cTmp)->NRNEG2		  
			(cAli)->NRROTA2		:= (cTmp)->NRROTA2		  
			(cAli)->CDFXTV2		:= (cTmp)->CDFXTV2		  
			(cAli)->CDCOMP2		:= (cTmp)->CDCOMP2		  
			(cAli)->VALOR2		:= (cTmp)->VALOR2				
		(cAli)->(MsUnlock())
		
		(cTmp)->( dbSkip() )
	EndDo
	
	(cTmp)->(dbCloseArea())
	
	oSecInfo:Init()
	oSecInfo:PrintLine()
	oSecInfo:Finish()
			
	oSection:Init()
	(cAli)->(dbSetOrder(3))
	(cAli)->(dbGoTop())
	
	While !(cAli)->(Eof()) .And. !oReport:Cancel()
		lImprimir := .T.
		
		// Demais cidades para negociação A
		lImprimir := VldDemaisCid((cAli)->TPDEST1, 1)
		
		If lImprimir
			// Demais cidades para negociação B
			lImprimir := VldDemaisCid((cAli)->TPDEST2, 2)
		EndIf
		
		If lImprimir
			oSection:PrintLine()
		EndIf
		
		(cAli)->(dbSkip())
	EndDo

	oSection:Finish()
	
	GFEDelTab(cAli)
Return 

Static Function VldDemaisCid(cTpDest, nOrder)
	Local lRet := .T.
	
	If cTpDest == "3" // cTpDest 3 == Região com demais cidades
		aArea := (cAli)->(GetArea())
		(cAli)->(dbSetOrder(nOrder))
			
		// Deve imprimir a cidade corrente se a mesma não estiver em outra rota
		lRet :=  !(cAli)->(dbSeek((cAli)->GU7_NRCID + "1")) .And. !(cAli)->(dbSeek((cAli)->GU7_NRCID + "4"))

		RestArea(aArea)
	EndIf
Return lRet

Static Function CriaTab()
	Local aStruct
	Local aIndices
	Local cAlias
	
	aStruct := {;
		{"GU7_NMCID","C",TamSX3("GU7_NMCID")[1],0},;	
		{"GU7_NRCID","C",TamSX3("GU7_NRCID")[1],0},;	
		{"FILIAL"	,"C",FWSizeFilial(),0},;
		{"TPDEST1"	,"C",1,0},;
		{"CDEMIT1"	,"C",TamSX3("GU3_CDEMIT")[1],0},;
		{"NRTAB1"	,"C",TamSX3("GVA_NRTAB")[1],0},;
		{"NRNEG1"	,"C",TamSX3("GV9_NRNEG")[1],0},;
		{"NRROTA1"	,"C",TamSX3("GV8_NRROTA")[1],0},;
		{"CDFXTV1"	,"C",TamSX3("GV1_CDFXTV")[1],0},;
		{"CDCOMP1"	,"C",TamSX3("GV1_CDCOMP")[1],0},;
		{"VALOR1"	,"N",TamSX3(cTipoValor)[1],TamSX3(cTipoValor)[2]},;
		{"TPDEST2"	,"C",1,0},;
		{"CDEMIT2"	,"C",TamSX3("GU3_CDEMIT")[1],0},;
		{"NRTAB2"	,"C",TamSX3("GVA_NRTAB")[1],0},;
		{"NRNEG2"	,"C",TamSX3("GV9_NRNEG")[1],0},;
		{"NRROTA2"	,"C",TamSX3("GV8_NRROTA")[1],0},;
		{"CDFXTV2"	,"C",TamSX3("GV1_CDFXTV")[1],0},;
		{"CDCOMP2"	,"C",TamSX3("GV1_CDCOMP")[1],0},;
		{"VALOR2"	,"N",TamSX3(cTipoValor)[1],TamSX3(cTipoValor)[2]};
	}	
	
	aIndices := {"GU7_NRCID+TPDEST1+CDEMIT1+NRTAB1+NRNEG1+NRROTA1+CDFXTV1", "GU7_NRCID+TPDEST2+CDEMIT2+NRTAB2+NRNEG2+NRROTA2+CDFXTV2", "GU7_NMCID"}
		
	cAlias := GFECriaTab({aStruct, aIndices})
Return cAlias

/*/{Protheus.doc}BuscaCampo
Função retorna qual campo sera retornado o valor para comparação no relatório

@Param nTipo, númerico, Valor para escolha do campo
@Return nome do campo para comparação
@Author Alexandre José Cuchi	
@Since  15/10/2014
@Version 1.0
/*/                                                                                              
Static Function BuscaCampo(nTipo)                                                                
	Local cCampo := ""                                                                           
	
	Do Case
		Case nTipo == 1
			cCampo := "GV1_VLFIXN"
		Case nTipo == 2
			cCampo := "GV1_PCNORM"
		Case nTipo == 3
			cCampo := "GV1_VLUNIN"			
	EndCase
Return cCampo

/*/{Protheus.doc}OutrosVal
Caso exista outros cálculos será exibida a mensagem
Como referência será utilizado o registro 'setado'
@Return Mensagem
@Author Alexandre José Cuchi
@Since 15/10/2014
@Version 1.0
/*/
Static Function OutrosVal()
	Local cMsg := "Existem outros valores cadastrados para o componente além de Fixo Normal, % Normal e Unit. Normal."
	Local lMsg := .F.

	//GV1_FILIAL+GV1_CDEMIT+GV1_NRTAB+GV1_NRNEG+GV1_CDFXTV+GV1_NRROTA+GV1_CDCOMP
	If GV1->( dbSeek((cAli)->FILIAL+(cAli)->CDEMIT1+(cAli)->NRTAB1+(cAli)->NRNEG1+(cAli)->CDFXTV1+(cAli)->NRROTA1+cCmpnt) ) .And.;
	   (!Empty(GV1->GV1_VLMINN).Or. !Empty(GV1->GV1_VLLIM) .Or. !Empty(GV1->GV1_VLFIXE) .Or. ;
	   !Empty(GV1->GV1_PCEXTR).Or. !Empty(GV1->GV1_VLUNIE) )
		lMsg := .T.
	EndIf
	
	If !lMsg
	If GV1->( dbSeek((cAli)->FILIAL+(cAli)->CDEMIT2+(cAli)->NRTAB2+(cAli)->NRNEG2+(cAli)->CDFXTV2+(cAli)->NRROTA2+cCmpnt) ) .And.;
		   (!Empty(GV1->GV1_VLMINN).Or. !Empty(GV1->GV1_VLLIM) .Or. !Empty(GV1->GV1_VLFIXE) .Or. ;
	       !Empty(GV1->GV1_PCEXTR).Or. !Empty(GV1->GV1_VLUNIE) )
			lMsg := .T.
		EndIf
	EndIf
Return Iif(lMsg, cMsg, "")


Static Function BuscCid(cFil,cNrCid)
	Local cCid       := ""
	
	dbSelectArea("GU7")
	GU7->(dbSetOrder(1))
	If GU7->(dbSeek(cFil+cNrCid))
		cCid := AllTrim(GU7->GU7_NMCID) + " - " + GU7->GU7_CDUF
	EndIf
Return cCid