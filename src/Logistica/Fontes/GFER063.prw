/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"// P12
/*/{Protheus.doc}GFER063
Relatório para a análise e verificação dos valores de frete entre cidades
 
@Author Alexandre José Cuchi
@Since 15/10/2014
@Version 1.0
/*/
User Function GFER063()
	Local oReport

	Private cTransp    := ""
	Private cVigenteEm := ""
	Private cCdOrigem  := ""
	Private cUFDestino := ""
	Private cFxTpVeic  := ""
	Private cNegocia   := ""
	Private cTabFrete  := ""
	Private cCmpnt     := ""
	Private cMultip    := ""
	Private cAli   := ""

	If TRepInUse() 
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

Return

Static Function ReportDef()
	Local oReport    := Nil
	Local oSctnHead  := Nil
	Local oSctnDtlhe := Nil
	Local oSctnHide  := Nil
	Local oRodaPe    := Nil  
	Local aOrdem     := {{},{},{}}

	/* CRIAÇÃO DO COMPONENTE DE IMPRESSÃO
	TReport():New                                                           
	ExpC1 : Nome do relatorio                                               
	ExpC2 : Titulo                                                          
	ExpC3 : Pergunte                                                        
	ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  
	ExpC5 : Descricao 
	*/
	oReport := TReport():New("GFER063","Relatório de Tarifas por Cidade de Destino",;
								"GFER063",{|oReport| Iif(U_GFR63VLPER("GFER063",.F.),ReportPrint(oReport),oReport:CancelPrint())},"")
	oReport:SetLandscape()
	oReport:HideParamPage()
	oReport:SetTotalInLine(.F.)
	// Definição do TrSection 
	/*	TRSection():New
	ExpO1 : Objeto TReport que a secao pertence
	ExpC2 : Descricao da seçao
	ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
	        sera considerada como principal para a seção.
	ExpA4 : Array com as Ordens do relatório
	ExpL5 : Carrega campos do SX3 como celulas                           
	        Default : False                                              
	ExpL6 : Carrega ordens do Sindex                                     
		    Default : False                                              
	*/
	oSctnHide  := TRSection():New(oReport,"-",{"GW1"},{"-"})
	oSctnHead  := TrSection():New(oReport,"Relatório de Tarifas por Cidade Destino",{}    ,aOrdem[1])
	oSctnDtlhe := TrSection():New(oReport,"Relatório de Tarifas por Cidade Destino",{"cAli"},aOrdem[2])
	oRodaPe    := TrSection():New(oReport,"Rodapé",{},aOrdem[3])
	//Definição das colunas do Relatorio
	/*
	TRCell():New                                               
	ExpO1 : Objeto TSection que a secao pertence               
	ExpC2 : Nome da celula do relatório. O SX3 será consultado 
	ExpC3 : Nome da tabela de referencia da celula             
	ExpC4 : Titulo da celula                                   
	        Default : X3Titulo()                               
	ExpC5 : Picture                                            
	        Default : X3_PICTURE                               
	ExpC6 : Tamanho                                            
	        Default : X3_TAMANHO                               
	ExpL7 : Informe se o tamanho esta em pixel                 
	        Default : False                                    
	ExpB8 : Bloco de código para impressao.                    
	        Default : ExpC2                                    
	*/  
	/**/
	oSctnHide:Hide()
	oSctnHide:Disable()
	oSctnHide:lReadOnly := .T.
	oSctnHide:lUserVisible := .F.
	/**/
	oSctnDtlhe:SetTotalInLine(.F.)
	oSctnDtlhe:SetHeaderSection(.T.)
	//  Cabeçalho com informações do pergunte
	TrCell():New(oSctnHead , "TRANSPORT"         , ""       , "Transportador",,,,{||cTransp   })
	TrCell():New(oSctnHead , "TABELA"            , ""       , "Tabela"       ,,,,{||cTabFrete })
	TrCell():New(oSctnHead , "NRNEG"             , ""       , "Negociação"   ,,,,{||cNegocia})
	TrCell():New(oSctnHead , "CIDORI"            , ""       , "Cidade Origem",,,,{||BuscaCid() })
	TrCell():New(oSctnHead , "UFDST"             , ""       , "Uf Destino",,,,{||cUFDestino })
	// Detalhes do Relatorio
	TrCell():New(oSctnDtlhe ,"CDDEST"            , ""       , "Cidade Destino"       ,,,,{||AllTrim((cAli)->CDDEST)})
	TrCell():New(oSctnDtlhe ,"(cAli)->NRROTA"    , "(cAli)" , "Nr Rota" )
	TrCell():New(oSctnDtlhe ,"ROTADESC"          , ""       , "Descrição da Rota"    ,,110,,{||GFEAINFROT(cTransp, cTabFrete ,cNegocia,(cAli)->NRROTA)})
	TrCell():New(oSctnDtlhe ,"COMPONENTE", ""       , "Componente "          ,,,,{||AllTrim((cAli)->CDCOMP) +' - '+AllTrim((cAli)->DCCOMP)})
	TrCell():New(oSctnDtlhe ,"CTVAR"             , ""       , "Categoria"            ,,,,{||PegaCateg((cAli)->CTVAR)})
	TrCell():New(oSctnDtlhe ,"DTCALC"            , ""       , "Calcula sobre"        ,,,,{||GFER063DTC()})
	TrCell():New(oSctnDtlhe ,"VLFIXN"    , "(cAli)" , "Vlr Fixo Normal",,,, {|| Transform((cAli)->VLFIXN,PESQPICT("GV1", "GV1_VLFIXN")) }     )
	TrCell():New(oSctnDtlhe ,"VLUNIN"    , "(cAli)" , "Vlr Unitario Normal",,,, {|| Transform((cAli)->VLUNIN,PESQPICT("GV1", "GV1_VLUNIN")) }  )
	TrCell():New(oSctnDtlhe ,"PERNORM"   , "(cAli)" , "% Normal",,,, {|| Transform((cAli)->PERNORM,PESQPICT("GV1", "GV1_PCNORM")) }            )
	TrCell():New(oSctnDtlhe ,"VLFXCORRIG", "(cAli)" , "Valor Fixo Corrigido" ,,,, {|| Transform((cAli)->VLFXCORRIG,PESQPICT("GV1", "GV1_VLFIXN")) })
	TrCell():New(oSctnDtlhe ,"VLUNCORRIG", "(cAli)" , "Valor Unit. Corrigido",,,, {|| Transform((cAli)->VLUNCORRIG,PESQPICT("GV1", "GV1_VLUNIN")) })
	//Rodapé do relatorio 
	TrCell():New(oRodaPe, "IMPORTANTE",,,,20,.F.,{|| "Existem rotas na Tabela/Negociação/Faixa informados cujo tipo de origem e/ou tipo de destino impossibilitam determinar se elas abrangem a cidade de origem e a UF de destino informadas."})
Return oReport

Static Function ReportPrint(oReport)	
	Local oSctnPrt1:= oReport:Section(2)
	Local oSctnPrt2:= oReport:Section(3)
	Local oSctnPrt3:= oReport:Section(4)
	Local oCell    := oReport:Section(4):Cell("IMPORTANTE")
	Local cQuery   := ""
	Local aGCList  := {}
	Local cFiliais := ''
	Local nX       := 0

	Private cTransp    := ""
	Private cVigenteEm := ""
	Private cCdOrigem  := ""
	Private cUFDestino := ""
	Private cFxTpVeic  := ""
	Private cNegocia   := ""
	Private cTabFrete  := ""
	Private cCmpnt     := ""
	Private cMultip    := ""
	Private cAli   := ""
	
	If oReport:nDevice == 1
		oCell:SetSIze(190,.F.)
	EndIf
	cTransp    := MV_PAR04       // Transportador?
	cVigenteEm := DToS(MV_PAR01) // Vigente em ?                                                  
	cCdOrigem  := MV_PAR02       // Cidade Origem ?                                               
	cUFDestino := MV_PAR03       // UF Destino ?                                                  
	cFxTpVeic  := MV_PAR05       // Faixa/Tipo Veiculo ?                                          
	cNegocia   := MV_PAR06       // Negociacao ?                                                  
	cTabFrete  := MV_PAR07       // Tabela de Frete ?                                             
	cCmpnt     := MV_PAR08       // Componente ?                                                  
	cMultip    := StrTran(cValToChar(Iif(Empty(MV_PAR09),1,MV_PAR09)),',','.')  // Multiplicador ?
	
	oSctnPrt1:Init()
	oSctnPrt1:PrintLine()
	oSctnPrt1:Finish()
	
	aGCList := oReport:GetGCList()// Função retorna array com filiais que o usuário tem acesso
	cFiliais += "("
	
	For nX := 1 To Len(aGCList)
		If nX != 1
			cFiliais += ","
		EndIf
		cFiliais += "'"+aGCList[nX]+"'"
	Next nX
	
	cFiliais += ")"
	
	cQuery += "SELECT DISTINCT * "
	cQuery += "  FROM ("
	cQuery += "  SELECT CASE "
	cQuery += "	      	WHEN COALESCE(GU7DEST1.GU7_NMCID, GU7DEST2.GU7_NMCID, GU7DEST3.GU7_NMCID, GU7DEST4.GU7_NMCID) IS NOT NULL THEN COALESCE(GU7DEST1.GU7_NMCID, GU7DEST2.GU7_NMCID, GU7DEST3.GU7_NMCID, GU7DEST4.GU7_NMCID)"
	cQuery += "	      	WHEN GV8.GV8_TPDEST = '4' AND GV8.GV8_CDUFDS = '"+cUFDestino+"' THEN 'QUAISQUER CIDADES'"
	cQuery += "	      	WHEN GV8.GV8_DUPSEN = '1' AND GV8.GV8_TPORIG = '4' AND GV8.GV8_CDUFOR = '"+cUFDestino+"' THEN 'QUAISQUER CIDADES'"
	cQuery += "	      	WHEN GV8.GV8_TPDEST = '3' OR (GV8.GV8_DUPSEN = '1' AND GV8.GV8_TPORIG = '3') THEN 'DEMAIS CIDADES'"
	cQuery += "	      END CDDEST,"
	cQuery += "	      	CASE WHEN COALESCE(GU7DEST1.GU7_NMCID, GU7DEST2.GU7_NMCID, GU7DEST3.GU7_NMCID, GU7DEST4.GU7_NMCID) IS NOT NULL THEN '1'"
	cQuery += "	      	WHEN GV8.GV8_TPDEST = '4' AND GV8.GV8_CDUFDS = '"+cUFDestino+"' THEN '4'"
	cQuery += "	      	WHEN GV8.GV8_DUPSEN = '1' AND GV8.GV8_TPORIG = '4' AND GV8.GV8_CDUFOR = '"+cUFDestino+"' THEN '4'"
	cQuery += "	      	WHEN GV8.GV8_TPDEST = '3' OR (GV8.GV8_DUPSEN = '1' AND GV8.GV8_TPORIG = '3') THEN '3'"
	cQuery += "	      END TPDESTINO,"
	cQuery += "	      GV7.GV7_CDFXTV,"
	cQuery += "	      GV8_FILIAL         FILIAL, "
	cQuery += "	      GV8_NRROTA         NRROTA, "
	cQuery += "	      GV1_CDCOMP         COMP, "
	cQuery += "	      GV1_CDCOMP         CDCOMP, "
	cQuery += "	      GV2_DSCOMP         DCCOMP, "
	cQuery += "	      GV2_CATVAL         CTVAR, "
	cQuery += "	      GV2_ATRCAL         DTCALC, "
	cQuery += "	      GV1_VLFIXN         VLFIXN, "
	cQuery += "	      GV1_VLUNIN         VLUNIN, "
	cQuery += "	      GV1_PCNORM        PERNORM, "
	cQuery += "	      ( GV1_VLFIXN * "+cMultip+" ) VLFXCORRIG, "
	cQuery += "	      ( GV1_VLUNIN * "+cMultip+" ) VLUNCORRIG "
	cQuery += "	  FROM " + RetSqlName("GV8") + " GV8"
	cQuery += "	 INNER JOIN " + RetSqlName("GV7") + " GV7 ON GV7.GV7_CDEMIT = GV8.GV8_CDEMIT"
	cQuery += "	                      AND GV7.GV7_NRTAB = GV8.GV8_NRTAB"
	cQuery += "	                      AND GV7.GV7_NRNEG = GV8.GV8_NRNEG "
	cQuery += "	                      AND GV7.GV7_FILIAL = GV8.GV8_FILIAL "		
	cQuery += "	                      AND GV7.D_E_L_E_T_ = ' '"
	cQuery += ""
	cQuery += "	 INNER JOIN " + RetSqlName("GV1") + " GV1 ON GV1.GV1_CDEMIT = GV7.GV7_CDEMIT "
	cQuery += "	                      AND GV1.GV1_NRTAB = GV7.GV7_NRTAB"
	cQuery += "	                      AND GV1.GV1_NRNEG = GV7.GV7_NRNEG "
	cQuery += "	                      AND GV1.GV1_CDFXTV = GV7.GV7_CDFXTV"
	cQuery += "	                      AND GV1.GV1_NRROTA = GV8.GV8_NRROTA"
	cQuery += "	                      AND GV1.GV1_FILIAL = GV7.GV7_FILIAL "		
	cQuery += "	                      AND GV1.D_E_L_E_T_ = ' ' "
	cQuery += ""
	cQuery += "	 INNER JOIN " + RetSqlName("GV2") + " GV2 ON GV2.GV2_CDCOMP = GV1.GV1_CDCOMP "
	cQuery += "	                      AND GV2.GV2_FILIAL = GV1.GV1_FILIAL "		
	cQuery += "	 					  AND GV2.D_E_L_E_T_ = ' '"
	cQuery += "						  "
	cQuery += "	 INNER JOIN " + RetSqlName("GV9") + " GV9 ON GV9.GV9_CDEMIT = GV8.GV8_CDEMIT "
	cQuery += "	                      AND GV9.GV9_NRTAB  = GV8.GV8_NRTAB "
	cQuery += "	                      AND GV9.GV9_NRNEG  = GV8.GV8_NRNEG "
	cQuery += "	                      AND GV9.GV9_FILIAL = GV8.GV8_FILIAL "		
	cQuery += "	                      AND GV9.GV9_SIT    = '2'"
	cQuery += "	                      AND GV9.GV9_DTVALI <= '"+cVigenteEm+"'"
	cQuery += "	                      AND (GV9.GV9_DTVALF >= '"+cVigenteEm+"' OR GV9.GV9_DTVALF = '')"
	cQuery += "	                      AND GV9.D_E_L_E_T_ = ' '"
	cQuery += ""
	cQuery += "	 INNER JOIN " + RetSqlName("GV6") + " GV6 ON GV6.GV6_CDEMIT = GV9.GV9_CDEMIT "
	cQuery += "	                      AND GV6.GV6_NRTAB = GV9.GV9_NRTAB "
	cQuery += "	                      AND GV6.GV6_NRNEG = GV9.GV9_NRNEG "
	cQuery += "	                      AND GV6.GV6_FILIAL = GV8.GV8_FILIAL "		
	cQuery += "	                      AND GV6.GV6_CDFXTV = GV7.GV7_CDFXTV "
	cQuery += "	                      AND GV6.GV6_NRROTA = GV8.GV8_NRROTA "
	cQuery += "	                      AND GV6.D_E_L_E_T_ = ' '  "
	//cQuery += "	  -- Parâmetro"
	cQuery += "	  LEFT JOIN " + RetSqlName("GU7") + " GU7ORIGEM ON GU7ORIGEM.GU7_NRCID  = '"+cCdOrigem+"'"
	cQuery += "	  							AND GU7ORIGEM.D_E_L_E_T_ = ' '"
	cQuery += ""
	//cQuery += "	  -- Cidade Destino"
	cQuery += "	  LEFT JOIN " + RetSqlName("GU7") + " GU7DEST1 ON GU7DEST1.GU7_NRCID  = GV8.GV8_NRCIDS"
	cQuery += "	    					   AND GU7DEST1.D_E_L_E_T_ = ' '"
	cQuery += "	    					   AND GV8.GV8_TPDEST = '1'"
	cQuery += "	    					   AND GU7DEST1.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += ""
	cQuery += "	  LEFT JOIN " + RetSqlName("GU7") + " GU7DEST2 ON GU7DEST2.GU7_NRCID  = GV8.GV8_NRCIOR"
	cQuery += "	    					   AND GU7DEST2.D_E_L_E_T_ = ' '"
	cQuery += "	    					   AND GV8.GV8_TPORIG      = '1'"
	cQuery += "	    					   AND GV8.GV8_DUPSEN      = '1'"
	cQuery += "	    					   AND GU7DEST2.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += ""
	cQuery += "	  LEFT JOIN " + RetSqlName("GUA") + " GUADEST1 ON GUADEST1.GUA_NRREG = GV8.GV8_NRREDS"
	cQuery += "	  						   AND GUADEST1.D_E_L_E_T_ = ' '"
	cQuery += "	  						   AND GV8.GV8_TPDEST = '3'"
	cQuery += "	 "
	cQuery += "	  LEFT JOIN " + RetSqlName("GU7") + " GU7DEST3 ON GU7DEST3.GU7_NRCID  = GUADEST1.GUA_NRCID"
	cQuery += "	    					   AND GU7DEST3.D_E_L_E_T_ = ' '"
	cQuery += "	    					   AND GU7DEST3.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += ""
	cQuery += "	  LEFT JOIN " + RetSqlName("GUA") + " GUADEST2 ON GUADEST2.GUA_NRREG = GV8.GV8_NRREOR"
	cQuery += "	  						   AND GUADEST2.D_E_L_E_T_ = ' '"
	cQuery += "	  						   AND GV8.GV8_TPORIG = '3'"
	cQuery += "	  						   AND GV8.GV8_DUPSEN = '1'"
	cQuery += ""
	cQuery += "	  LEFT JOIN " + RetSqlName("GU7") + " GU7DEST4 ON GU7DEST4.GU7_NRCID  = GUADEST2.GUA_NRCID"
	cQuery += "	    					   AND GU7DEST4.D_E_L_E_T_ = ' '"
	cQuery += "	    					   AND GU7DEST4.GU7_CDUF   = '"+cUFDestino+"'"
	cQuery += ""
	cQuery += "	 WHERE GV8.GV8_TPORIG IN ( '1', '3', '4' )"
	cQuery += "	   AND GV8.GV8_TPDEST IN ( '1', '3', '4' )"
	cQuery += "	   AND GV8.D_E_L_E_T_ = ' '"
	cQuery += "	   AND GV8.GV8_CDEMIT = '"+cTransp+"' "
	cQuery += "	   AND GV8.GV8_NRTAB = '"+cTabFrete+"'"
	cQuery += "	   AND GV8.GV8_NRNEG = '"+cNegocia+"'"
	
	If !Empty(cCmpnt)
		cQuery += "  AND GV1.GV1_CDCOMP = '"+cCmpnt+"' "
	EndIf

	cQuery += " AND GV7.GV7_CDFXTV = '"+cFxTpVeic+"' "

	If !Empty(aGCList)
		cQuery += " AND GV8.GV8_FILIAL IN "+cFiliais+""
	EndIf 
	//cQuery += "	   -- Valida origem"
	cQuery += "	   AND ( ( "
	cQuery += "	   	      ("
	cQuery += "		   	      (GV8.GV8_TPORIG = '1' AND GU7ORIGEM.GU7_NRCID = GV8.GV8_NRCIOR) OR "
	cQuery += "		   	      (GV8.GV8_TPORIG = '4' AND GU7ORIGEM.GU7_CDUF  = GV8.GV8_CDUFOR) OR "
	cQuery += "		   	      (GV8.GV8_TPORIG = '3' AND (GV8.GV8_NRREOR IN   (SELECT DISTINCT GUAA.GUA_NRREG"
	cQuery += "																	     FROM " + RetSqlName("GUA") + " GUAA"
	cQuery += "																	    WHERE GUAA.GUA_NRCID = '"+cCdOrigem+"'"
	cQuery += "																	      AND GUAA.D_E_L_E_T_ = ' ') "
	cQuery += "						   	      							OR"
	cQuery += "		   	                                 EXISTS (SELECT GUAB.GUA_NRREG  "
	cQuery += "                                                               FROM "+RetSQLName("GUA")+" GUAB  "
	cQuery += " 			                                                  JOIN "+RetSQLName("GVR")+" GVR ON (GVR.GVR_NRREGR = GUAB.GUA_NRREG) "
	cQuery += " 		                                                      WHERE GUAB.GUA_FILIAL = '"+xFilial("GUA")+"' "
	cQuery += " 		                                                      AND GVR.GVR_FILIAL = '"+xFilial("GVR")+"' "
	cQuery += "			                                                      AND GUAB.D_E_L_E_T_ = ' ' "
	cQuery += "			                                                      AND GVR.D_E_L_E_T_ = ' ' "
	cQuery += " 		                                                      AND GVR.GVR_NRREG = GV8.GV8_NRREOR "
	cQuery += "			                                                      AND GUAB.GUA_NRCID = '"+cCdOrigem+"')"
	cQuery += "						   	      							OR"
	cQuery += "															"
	cQuery += "															EXISTS (SELECT GU9_NRREG "
	cQuery += "																	  FROM " + RetSqlName("GU7") + " GU7 "
	cQuery += "																	 INNER JOIN " + RetSqlName("GU9") + " GU9 ON GU9_CDUF = GU7_CDUF"
	cQuery += "																	  				  AND GU9_DEMCID = '1'"
	cQuery += "																	 WHERE GU9_NRREG  = GV8.GV8_NRREOR"
	cQuery += "																	   AND GU7_NRCID = '"+cCdOrigem+"'"
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
	cQuery += "													     FROM " + RetSqlName("GUA") + " GUAC "
	cQuery += "													    INNER JOIN " + RetSqlName("GU7") + " GU7 ON GU7_NRCID = GUAC.GUA_NRCID"
	cQuery += "													    WHERE GU7_CDUF = '"+cUFDestino+"'"
	cQuery += "													      AND GUAC.D_E_L_E_T_ = ' '"
	cQuery += "													      AND GU7.D_E_L_E_T_ = ' ')"
	cQuery += ""
	cQuery += "		   	      										OR"
	cQuery += "		   	                                 EXISTS (SELECT GUAD.GUA_NRREG  "
	cQuery += "                                                               FROM "+RetSQLName("GUA")+" GUAD  "
	cQuery += " 			                                                  JOIN "+RetSQLName("GVR")+" GVR ON (GVR.GVR_NRREGR = GUAD.GUA_NRREG) "
	cQuery += "													              JOIN " + RetSqlName("GU7") + " GU7 ON GU7_NRCID = GUAD.GUA_NRCID"
	cQuery += " 		                                                      WHERE GUAD.GUA_FILIAL = '"+xFilial("GUA")+"' "
	cQuery += " 		                                                      AND GVR.GVR_FILIAL = '"+xFilial("GVR")+"' "
	cQuery += " 		                                                      AND GU7_CDUF = '"+cUFDestino+"'"
	cQuery += "			                                                      AND GUAD.D_E_L_E_T_ = ' ' "
	cQuery += "			                                                      AND GVR.D_E_L_E_T_ = ' ' "
	cQuery += " 		                                                      AND GVR.GVR_NRREG = GV8.GV8_NRREDS )"
	cQuery += "						   	      							OR"
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
	cQuery += "		   	          (GV8.GV8_TPDEST = '3' AND (GV8.GV8_NRREDS IN   (SELECT DISTINCT GUAA.GUA_NRREG"
	cQuery += "																	     FROM " + RetSqlName("GUA") + " GUAA"
	cQuery += "																	    WHERE GUAA.GUA_NRCID = '"+cCdOrigem+"'"
	cQuery += "																	      AND GUAA.D_E_L_E_T_ = ' ') "
	cQuery += "						   	      							OR"
	cQuery += "		   	                                 EXISTS (SELECT GUAB.GUA_NRREG  "
	cQuery += "                                                               FROM "+RetSQLName("GUA")+" GUAB  "
	cQuery += " 			                                                  JOIN "+RetSQLName("GVR")+" GVR ON (GVR.GVR_NRREGR = GUAB.GUA_NRREG) "
	cQuery += " 		                                                      WHERE GUAB.GUA_FILIAL = '"+xFilial("GUA")+"' "
	cQuery += " 		                                                      AND GVR.GVR_FILIAL = '"+xFilial("GVR")+"' "
	cQuery += "			                                                      AND GUAB.D_E_L_E_T_ = ' ' "
	cQuery += "			                                                      AND GVR.D_E_L_E_T_ = ' ' "
	cQuery += " 		                                                      AND GVR.GVR_NRREG = GV8.GV8_NRREDS "
	cQuery += "			                                                      AND GUAB.GUA_NRCID = '"+cCdOrigem+"')"
	cQuery += "						   	      							OR"
	cQuery += "															"
	cQuery += "															EXISTS (SELECT GU9_NRREG "
	cQuery += "																	  FROM " + RetSqlName("GU7") + " GU7 "
	cQuery += "																	 INNER JOIN " + RetSqlName("GU9") + " GU9 ON GU9_CDUF = GU7_CDUF"
	cQuery += "																	  				  AND GU9_DEMCID = '1'"
	cQuery += "																	 WHERE GU9_NRREG  = GV8.GV8_NRREDS"
	cQuery += "																	   AND GU7_NRCID = '"+cCdOrigem+"'"
	cQuery += "																	   AND GU7.D_E_L_E_T_ = ' ' "
	cQuery += "																	   AND GU9.D_E_L_E_T_ = ' ')"
	cQuery += "											)"
	cQuery += "				  )"
	
	cQuery += "				  )"
	cQuery += "		      )"
	cQuery += "		      AND ("
	cQuery += "			   	      (GV8.GV8_TPORIG = '1' AND EXISTS (SELECT 1 FROM " + RetSqlName("GU7") + " WHERE GU7_NRCID = GV8.GV8_NRCIOR AND GU7_CDUF = '"+cUFDestino+"' AND D_E_L_E_T_ = ' ') ) OR"
	cQuery += "			   	      (GV8.GV8_TPORIG = '4' AND GV8.GV8_CDUFOR = '"+cUFDestino+"' ) OR "
	cQuery += "		   	          (GV8.GV8_TPORIG = '3' AND (GV8.GV8_NRREOR IN (SELECT DISTINCT GUA_NRREG"
	cQuery += "													     FROM " + RetSqlName("GUA") + " GUAC "
	cQuery += "													    INNER JOIN " + RetSqlName("GU7") + " GU7 ON GU7_NRCID = GUAC.GUA_NRCID"
	cQuery += "													    WHERE GU7_CDUF = '"+cUFDestino+"'"
	cQuery += "													      AND GUAC.D_E_L_E_T_ = ' '"
	cQuery += "													      AND GU7.D_E_L_E_T_ = ' ')"
	cQuery += ""
	cQuery += "		   	      										OR"
	cQuery += "		   	                                 EXISTS (SELECT GUAD.GUA_NRREG  "
	cQuery += "                                                               FROM "+RetSQLName("GUA")+" GUAD  "
	cQuery += " 			                                                  JOIN "+RetSQLName("GVR")+" GVR ON (GVR.GVR_NRREGR = GUAD.GUA_NRREG) "
	cQuery += "													              JOIN " + RetSqlName("GU7") + " GU7 ON GU7_NRCID = GUAD.GUA_NRCID"
	cQuery += " 		                                                      WHERE GUAD.GUA_FILIAL = '"+xFilial("GUA")+"' "
	cQuery += " 		                                                      AND GVR.GVR_FILIAL = '"+xFilial("GVR")+"' "
	cQuery += " 		                                                      AND GU7_CDUF = '"+cUFDestino+"'"
	cQuery += "			                                                      AND GUAD.D_E_L_E_T_ = ' ' "
	cQuery += "			                                                      AND GVR.D_E_L_E_T_ = ' ' "
	cQuery += " 		                                                      AND GVR.GVR_NRREG = GV8.GV8_NRREOR )"
	cQuery += "						   	      							OR"
	cQuery += ""
	cQuery += "		   	      							 GV8.GV8_NRREOR IN (SELECT GU9_NRREG "
	cQuery += "		   	      							 	                  FROM " + RetSqlName("GU9")
	cQuery += "		   	      							 	                 WHERE GU9_DEMCID = '1' "
	cQuery += "		   	      							 	                   AND GU9_CDUF = '"+cUFDestino+"' "
	cQuery += "		   	      							 	                   AND D_E_L_E_T_ = '')"
	cQuery += "		   	     							)"
	cQuery += "		   	     	)"
	cQuery += "				  )	        "
	cQuery += "	       ) "  // **
	cQuery += "	) A"
	cQuery += ""
	cQuery += "ORDER BY TPDESTINO, CDDEST, NRROTA, COMP"	
	
	//---------------------------------------------------------------
	// Fim da query
	//--------------------------------------------------------------	
	cAli   := GetNextAlias()
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery), cAli, .F.) 
	
	TCSetField (cAli, "VLFIXN", "N", 15, 5)
	TCSetField (cAli, "VLUNIN", "N", 15, 5)
	TCSetField (cAli, "PERNORM", "N", 15, 5)
	TCSetField (cAli, "VLFXCORRIG", "N", 15, 5)
	TCSetField (cAli, "VLUNCORRIG", "N", 15, 5)
	oSctnPrt2:Init()

	While  !(cAli)->( Eof() ) .And. !oReport:Cancel()
		oSctnPrt2:PrintLine()
		(cAli)->( dbSkip() )
	EndDo
	(cAli)->(dbCloseArea())
	oSctnPrt2:Finish()
	oSctnPrt3:Init()
	oSctnPrt3:PrintLine()
	oSctnPrt3:Finish()
	GFEDelTab(cAli)
Return
/*/{Protheus.doc} GFER063DTC
Função para buscar a descrição do componente 

@since 15/10/2014
@Author Alexandre Cuchi
@version 1.0
/*/
Static Function GFER063DTC()
	dbSelectArea("GV2")
	GV2->( dbSetOrder(1) )
	GV2->( dbSeek((cAli)->FILIAL+(cAli)->COMP ) )
Return GFEA060DAC()
/*/{Protheus.doc} BuscaCid
Função Busca descrição da cidade e retorna cidade / UF

@since 15/10/2014
@Author Alexandre Cuchi
@version 1.0
/*/
Static Function BuscaCid()
	Local cRet := ""
	
	dbSelectArea("GU7")
	GU7->(dbSetOrder(1))
	GU7->(dbSeek(xFilial("GU7")+cCdOrigem ))
	cRet := AllTrim(GU7->GU7_NMCID) + " - " + GU7->GU7_CDUF 
Return cRet
/*/{Protheus.doc} PegaCateg
Função para retornar a descrição da categoria do cálculo

@param cCateg = categoria para pesquisa
@since 15/10/2014
@Author Alexandre Cuchi
@version 1.0
/*/
Static Function PegaCateg(cCateg)
	Local cRet
	Do Case
		Case cCateg == '1'
			cRet := "Frete Unidade"
		Case cCateg == '2'
			cRet := "Frete Valor"
		Case cCateg == '3'
			cRet := "Taxas"
		Case cCateg == '4'
			cRet := "Pedagio"
	EndCase
Return cRet
/*/{Protheus.doc}GFER63ZOOM
Consulta padrão FRTGV7

@Author Alexandre José Cuchi
@Since 15/10/2014
@Version 1.0
/*/
User Function GFER63ZOOM()
	Local cTitulo  := "Faixa/ Tipo Veículo"
	Local lRet     := .F.
	Local nItem    := 0
	Local cSeqFx   := ""
	Local cTpLota  := GV9->GV9_TPLOTA 
	Local aRet     := {}
	Local cVar     := ReadVar()
	
	If Type("cTransp") != "C"
		cTransp  := ""
	EndIf
	
	If cVar == 'MV_PAR05' // Pergunte GFER063
		cTransp := MV_PAR04
	ElseIf cVar == 'MV_PAR06' // Pergunte GFER064 -> Transportador A
		cTransp := MV_PAR05
	ElseIf cVar == 'MV_PAR10' // Pergunte GFER064 -> Transportador B
		cTransp := MV_PAR09
	EndIf
	
	dbSelectArea("GV9")
	dbSelectArea("GV7")
	GV9->(dbSetOrder(1))
	GV7->(dbSetOrder(1))
	
	If !Empty(cTransp) 
		GV9->( dbSeek( xFilial("GV9")+ cTransp ) )
	Else
		GV9->(dbGoTop())
	EndIf
	
	While !GV9->( Eof() )
		GV7->( dbSeek( GV9->GV9_FILIAL+GV9->GV9_CDEMIT+GV9->GV9_NRTAB+GV9->GV9_NRNEG) )
		While !Eof() .And. xFilial("GV7") == GV7->GV7_FILIAL .And. GV7->GV7_CDEMIT == GV9->GV9_CDEMIT .And. GV7->GV7_NRTAB == GV9->GV9_NRTAB .And. GV7->GV7_NRNEG == GV9->GV9_NRNEG
			If cTpLota == "1"
				aAdd( aRet, {GV7->GV7_CDEMIT, GV7->GV7_NRTAB, GV7->GV7_NRNEG , GV7->GV7_CDFXTV, Alltrim(STR(GV7->GV7_QTFXFI))} )                        			
			Else 
				aAdd( aRet, {GV7->GV7_CDEMIT, GV7->GV7_NRTAB, GV7->GV7_NRNEG , GV7->GV7_CDFXTV,Alltrim(GV7->GV7_CDTPVC),POSICIONE("GV3",1,XFILIAL("GV3")+GV7->GV7_CDTPVC,"GV3_DSTPVC") } )                        			
			Endif	
			GV7->( dbSkip() )
		EndDo
		GV9->( dbSkip() )
		lRet:= .T.
	EndDo
	If lRet 
		lRet := .F.
		If cTpLota == "1"
			nItem := TmsF3Array( {"Emitente","Número Tab.","Número Neg.","Seq. Faixa","Qtde. Final Faixa"}, aRet, cTitulo ) 
		Else            
			nItem := TmsF3Array( {"Emitente","Número Tab.","Número Neg.", "Seq. Faixa","Tipo Veículo", "Descrição Veículo"}, aRet, cTitulo ) 
		Endif
		If nItem > 0
			cSeqFx  := aRet[ nItem, 4 ]
			dbSelectArea("GV7")
			dbSetOrder(1)
			lRet := GV7->(dbSeek(xFilial("GV7") + aRet[ nItem, 1 ] + aRet[ nItem, 2 ] + aRet[ nItem, 3 ] + cSeqFx ) )
		Endif		
	EndIf 
Return lRet

User Function GFR63VLPER(cPergunte,lNotMsg)
	
	Local cMsg
	Local aCmps
	Local nX
	Local lLoop := .T.
	Default lNotMsg := .T.
	If Type("aPergunta") == "A"
		aPergunta := Nil
	EndIf
	
	Pergunte(cPergunte,.F.)
	
	If lNotMsg 
		Return .T.
	EndIf
	
	While lLoop .And. (aCmps := VldCampos())[1] 
		cMsg := "um ou mais campos obrigatórios não foram preenchidos: "
		For nX := 1 To Len(aCmps[2])
			cMsg += aCmps[2,nX] + ","
		Next nX
		cMsg := Stuff( cMsg, Len(cMsg), 1, ".")
		cMsg += + CRLF + "A impressão do relatório será cancelada."
		MsgInfo(cMsg,"Campos em branco" )
		lLoop := .F.
	EndDo
	
Return lLoop

Static Function VldCampos()
	Local aRet := {.F.,{}}
	Local nX 
	For nX := 1 To Len(aPergunta)
		If Empty(&(aPergunta[nX,14])) .And. 'VAZIO' $ aPergunta[nX,7] 
			AAdd(aRet[2],'"'+AllTrim(aPergunta[nX,1])+'"')
			aRet[1] := .T.
		EndIf
	Next nX
Return aRet
