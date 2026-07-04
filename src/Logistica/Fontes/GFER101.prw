/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
/*/{Protheus.doc}U_GFER101()
 Relatório de Impostos dos Autônomos 

@Author Alexandre José Cuchi
@Since 15/10/2014
@Version 1.0 
/*/
User Function GFER101()
	Private oReport

	If TRepInUse()
		Pergunte("GFER101",.F.)
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

Return

/*/{Protheus.doc}ReportDef
Definição do componente de relatório

@Return oReport = Objeto tReport com informações do relatório
@Author Alexandre José Cuchi
@Since 15/10/2014
@Version 1.0 
/*/
Static Function ReportDef()
	Local oSection
	Local oSctnHide
	Local aOrdem := {}

	Private nSEST      := 0
	Private nVLADD     := 0
	Private nVLISS     := 0
	Private nVLDESC    := 0
	Private nVLIRRF    := 0
	Private nVLSERV    := 0
	Private nBASESER   := 0
	Private nBSRENDA   := 0
	Private nVLPREVD   := 0
	Private nINSSAUT   := 0
	Private nINSSEMB   := 0
	Private nVLTOTAL   := 0
	Private cAli       := ""
	Private cData      := "" // Data para referência do relatório         
	Private cempty     := ""
	Private cTransp    := "" // Código do transportador                   
	Private nCptCntrt  := "" // Competencia do contrato                   
	Private nTpReport  := "" // Tipo do relatorio(Resimido/ detalhado)    
	Private nComCntrt  := "" // Considerar cálculos com contrato          
	Private nSemCntrt  := "" // Considerar cálculos sem contrato       

	/* CRIAÇÃO DO COMPONENTE DE IMPRESSÃO
	TReport():New                                                           
	ExpC1 : Nome do relatorio                                               
	ExpC2 : Titulo                                                          
	ExpC3 : Pergunte                                                        
	ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  
	ExpC5 : Descricao 
	*/
	oReport := TReport():New("GFER101","Relatório de Impostos dos Autônomos ","GFER101",{|oReport| ReportPrint(oReport)}," ")
	oReport:SetLandscape()
	oReport:HideParamPage()
	oReport:SetTotalInLine(.F.)

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
	oSctnHide := TrSection():New(oReport,"",{"GW2"},{'-'})
	oSctnHide:Hide()
	oSctnHide:Disable()
	oSctnHide:lReadOnly := .T.
	oSctnHide:lUserVisible := .F.

	oSection  := TrSection():New(oReport,"Impostos dos Autônomos",{cAli},aOrdem)
	oSection:SetTotalInLine(.F.)
	oSection:SetHeaderSection(.T.)

	TRCell():New(oSection, "(cAli)->FILIAL" ,"(cAli)","Filial"              ,,TamSx3("GW2_FILIAL")[1],,															)//  Filial
	TRCell():New(oSection, "(cAli)->PROPRI" ,"(cAli)","Proprietário"        ,,TamSx3("GW2_CDPROP")[1],,{||IIf(MV_PAR05 == 2,(cAli)->GWF_TRANSP,(cAli)->PROPRI)}	)//  Proprietário
	TRCell():New(oSection, "(cAli)->NMEMIT" ,"(cAli)","Nome"                ,,TamSx3("GU3_NMABRV")[1],,															)//  Nome
	TRCell():New(oSection, "(cAli)->NRCONT" ,"(cAli)","Numer do Contrato"   ,,TamSx3("GW2_NRCONT")[1],,															)//  Numer do Contrato
	TRCell():New(oSection, "DTLIBE"         ,"(cAli)","Data Emissão"   	    ,,10                     ,,{||SToD((cAli)->DTLIBE)}									)//  Data de Liberação
	TRCell():New(oSection, "DTVENC"         ,"(cAli)","Data Vencimento"     ,,10                     ,,{||SToD((cAli)->DTVENC)}									)//  Data Vencimento
	TRCell():New(oSection, "SITCON"         ,"(cAli)","Situação do contrato",,24                     ,,{||BuscaSit((cAli)->SITCON,'2')}							)
	TRCell():New(oSection, "SITFIN"         ,"(cAli)","Situação Financeiro" ,,24                     ,,{||BuscaSit((cAli)->SITFIN,'1')}							)//  Situação Financeiro
	TRCell():New(oSection, "(cAli)->VLSERV" ,"(cAli)","Valor Serviço"       ,,TamSx3("GW2_VLFRET")[1],,{||(cAli)->VLSERV }										)//  Valor Serviço       
	TRCell():New(oSection, "(cAli)->VLADD"  ,"(cAli)","Adicionais"          ,,TamSx3("GW2_VLADIC")[1],,{||(cAli)->VLADD  }										)//  Adicionais          
	TRCell():New(oSection, "(cAli)->VLDESC" ,"(cAli)","Descontos"           ,,TamSx3("GW2_VLDESC")[1],,{||(cAli)->VLDESC }										)//  Descontos           
	TRCell():New(oSection, "(cAli)->BASESER","(cAli)","Base Serviço"        ,,TamSx3("GWF_BASISS")[1],,{||(cAli)->BASESER}										)//  Base Serviço        
	TRCell():New(oSection, "(cAli)->VLISS"  ,"(cAli)","ISS"                 ,,TamSx3("GW2_VLISS" )[1],,{||(cAli)->VLISS  }										)//  ISS                 
	TRCell():New(oSection, "(cAli)->BSRENDA","(cAli)","Base Renda"          ,,TamSx3("GW2_VLBAIR")[1],,{||(cAli)->BSRENDA}										)//  Base Renda          
	TRCell():New(oSection, "(cAli)->VLIRRF" ,"(cAli)","IRRF"                ,,TamSx3("GW2_VLIRRF")[1],,{||(cAli)->VLIRRF }										)//  IRRF                
	TRCell():New(oSection, "(cAli)->VLPREVD","(cAli)","Base Previdência"    ,,TamSx3("GW2_VLBAIN")[1],,{||(cAli)->VLPREVD}										)//  Base Previdência     
	TRCell():New(oSection, "(cAli)->INSSAUT","(cAli)","INSS Autônomo"       ,,TamSx3("GW2_VLINSS")[1],,{||(cAli)->INSSAUT}										)//  INSS Autônomo        
	TRCell():New(oSection, "(cAli)->SEST"   ,"(cAli)","SEST/SENAT"          ,,TamSx3("GW2_VLSEST")[1],,{||(cAli)->SEST   }										)//  SEST/SENAT          
	TRCell():New(oSection, "(cAli)->INSSEMB","(cAli)","INSS Embarcador"     ,,TamSx3("GW2_VLINEM")[1],,{||(cAli)->INSSEMB}										)//  INSS Embarcador      
	TRCell():New(oSection, "(cAli)->VLTOTAL","(cAli)","Valor Total"         ,,20                     ,,{||(cAli)->VLTOTAL}										)//  Valor Total - Totalizador         
	
	TRCell():New(oSection, "(cAli)->CDTPDC","(cAli)","Tipo Doc"             ,,TamSx3("GW1_CDTPDC")[1],,{||IIf(MV_PAR05 == 2,(cAli)->CDTPDC            			  ,'')})//  Tipo Doc
	TRCell():New(oSection, "(cAli)->SERDC" ,"(cAli)","Série"                ,,TamSx3("GW1_SERDC" )[1],,{||IIf(MV_PAR05 == 2,(cAli)->SERDC             			  ,'')})//  Série
	TRCell():New(oSection, "(cAli)->NRDC"  ,"(cAli)","Doc Carga"            ,,TamSx3("GW1_NRDC"  )[1],,{||IIf(MV_PAR05 == 2,(cAli)->NRDC             			  ,'')})//  Doc Carga
	TRCell():New(oSection, "(cAli)->DTEMIS","(cAli)","Data Emissão"         ,,10                     ,,{||IIf(MV_PAR05 == 2,SToD((cAli)->DTEMIS)      			  ,'')})//  Data Emissão
	TRCell():New(oSection, "(cAli)->NRROM" ,"(cAli)","Romaneio"             ,,TamSx3("GWN_NRROM" )[1],,{||IIf(MV_PAR05 == 2,(cAli)->NRROM             			  ,'')})//  Romaneio
	TRCell():New(oSection, "(cAli)->DTLIB" ,"(cAli)","Data Liberação"       ,,10                     ,,{||IIf(MV_PAR05 == 2,SToD((cAli)->DTLIB)       			  ,'')})//  Data Liberação 
	TRCell():New(oSection, "(cAli)->DTOCOR","(cAli)","Data Entrega"         ,,10                     ,,{||IIf(MV_PAR05 == 2,StoD((cAli)->DTOCOR)      			  ,'')})//  Data Entrega - Entrega do documento é informado como ocorrencia
	TRCell():New(oSection, "(cAli)->VLFER" ,"(cAli)","Frete Doc Carga"      ,,TamSx3("GWM_VLFRET")[1],,{||IIf(MV_PAR05 == 2,(cAli)->VLFER             			  ,'')})//  Frete Doc Carga - GWM vlfrete
	TRCell():New(oSection, "(cAli)->NRCALC","(cAli)","Cálculo"              ,,TamSx3("GWF_NRCALC")[1],,{||IIf(MV_PAR05 == 2,(cAli)->NRCALC            			  ,'')})//  Cálculo
	TRCell():New(oSection, "(cAli)->DTCRIA","(cAli)","Data Cálculo"         ,,10                     ,,{||IIf(MV_PAR05 == 2,StoD((cAli)->DTCRIA)       			  ,'')})//  Data Cálculo
	TRCell():New(oSection, "(cAli)->VALOR" ,"(cAli)","Valor Cálculo"        ,,20                     ,,{||IIf(MV_PAR05 == 2,(cAli)->VALOR             			  ,'')})//  Valor Cálculo - Totalizador
	TRCell():New(oSection, "NRCALC"        ,""      ,"Outros Cálculos"      ,,40                     ,,{||IIf(MV_PAR05 == 2,ListCalc((cAli)->NRROM,(cAli)->FILIAL),'')})//  Outros Cálculos
	TRCell():New(oSection, "(cAli)->VALOTR","(cAli)","Valor Outros Cálculos",,20                     ,,{||IIf(MV_PAR05 == 2,(cAli)->VALOTR            			  ,'')})//  Valor Outros Cálculos - Totalizador

	oSection2  := TrSection():New(oReport,"Totalizadores",{cAli},aOrdem)
	oSection2:SetTotalInLine(.F.)
	oSection2:SetHeaderSection(.F.)

	TRCell():New(oSection2, "cempty"  ,"",""                ,,TamSx3("GW2_FILIAL")[1],,				)//  Filial
	TRCell():New(oSection2, "cempty"  ,"",""                ,,TamSx3("GW2_CDPROP")[1],,				)//  Proprietário
	TRCell():New(oSection2, "cempty"  ,"",""                ,,TamSx3("GU3_NMABRV")[1],,				)//  Nome
	TRCell():New(oSection2, "cempty"  ,"",""                ,,TamSx3("GW2_NRCONT")[1],,				)//  Numer do Contrato
	TRCell():New(oSection2, "cempty"  ,"",""                ,,10                     ,,				)//  Data de Liberação
	TRCell():New(oSection2, "cempty"  ,"",""                ,,10                     ,,				)//  Data Vencimento
	TRCell():New(oSection2, "cempty"  ,"",""                ,,24                     ,,				)
	TRCell():New(oSection2, "cempty"  ,"",""                ,,24                     ,,				)//  Situação Financeiro
	TRCell():New(oSection2, "nVLSERV" ,"","Valor Serviço"   ,,TamSx3("GW2_VLFRET")[1],,{||nVLSERV }	)//  Valor Serviço       
	TRCell():New(oSection2, "nVLADD"  ,"","Adicionais"      ,,TamSx3("GW2_VLADIC")[1],,{||nVLADD  }	)//  Adicionais          
	TRCell():New(oSection2, "nVLDESC" ,"","Descontos"       ,,TamSx3("GW2_VLDESC")[1],,{||nVLDESC }	)//  Descontos           
	TRCell():New(oSection2, "nBASESER","","Base Serviço"    ,,TamSx3("GWF_BASISS")[1],,{||nBASESER}	)//  Base Serviço        
	TRCell():New(oSection2, "nVLISS"  ,"","ISS"             ,,TamSx3("GW2_VLISS" )[1],,{||nVLISS  }	)//  ISS                 
	TRCell():New(oSection2, "nBSRENDA","","Base Renda"      ,,TamSx3("GW2_VLBAIR")[1],,{||nBSRENDA}	)//  Base Renda          
	TRCell():New(oSection2, "nVLIRRF" ,"","IRRF"            ,,TamSx3("GW2_VLIRRF")[1],,{||nVLIRRF }	)//  IRRF                
	TRCell():New(oSection2, "nVLPREVD","","Base Previdência",,TamSx3("GW2_VLBAIN")[1],,{||nVLPREVD}	)//  Base Previdência     
	TRCell():New(oSection2, "nINSSAUT","","INSS Autônomo"   ,,TamSx3("GW2_VLINSS")[1],,{||nINSSAUT}	)//  INSS Autônomo        
	TRCell():New(oSection2, "nSEST"   ,"","SEST/SENAT"      ,,TamSx3("GW2_VLSEST")[1],,{||nSEST   }	)//  SEST/SENAT          
	TRCell():New(oSection2, "nINSSEMB","","INSS Embarcador"	,,TamSx3("GW2_VLINEM")[1],,{||nINSSEMB}	)//  INSS Embarcador      
	TRCell():New(oSection2, "nVLTOTAL","","Valor Total"     ,,20                     ,,{||nVLTOTAL}	)//  Valor Total - Totalizador

Return oReport

Static Function ReportPrint(oReport)	
	Local nX        := 0
	Local cQuery    := ""
	Local cWhere    := ""
	Local cFiliais  := ""
	Local cChaveCtr := ""
	Local lInitTot  := .F.
	Local aGCList   := oReport:GetGCList() // retorna array com todas as filiais que o usuário tem acess
	Local oSection  := oReport:Section(2)  // Seleciona a primeira consulta
	Local oSection2 := oReport:Section(3)  // totalizadores

	cData      := MV_PAR02+MV_PAR01
	nCptCntrt  := MV_PAR03
	cTransp    := MV_PAR04
	nTpReport  := MV_PAR05
	nComCntrt  := MV_PAR06
	nSemCntrt  := MV_PAR07

	nVLSERV    := 0
	nVLADD     := 0
	nVLDESC    := 0
	nBASESER   := 0
	nVLISS     := 0
	nBSRENDA   := 0
	nVLIRRF    := 0
	nVLPREVD   := 0
	nINSSAUT   := 0
	nSEST      := 0
	nINSSEMB   := 0
	nVLTOTAL   := 0

	If MV_PAR05 == 1
		oSection:Cell(21):Disable()
		oSection:Cell(22):Disable()
		oSection:Cell(23):Disable()
		oSection:Cell(24):Disable()
		oSection:Cell(25):Disable()
		oSection:Cell(26):Disable()
		oSection:Cell(27):Disable()
		oSection:Cell(28):Disable()
		oSection:Cell(29):Disable()
		oSection:Cell(30):Disable()
		oSection:Cell(31):Disable()
		oSection:Cell(32):Disable()
		oSection:Cell(33):Disable()
	EndIf

	aGCList := oReport:GetGCList()// Função retorna array com filiais que o usuário tem acesso

	cFiliais += '('
	For nX := 1 To Len(aGCList)
		If nX != 1
			cFiliais += ","
		EndIf
		cFiliais += "'" + aGCList[nX] + "'"
	Next nX
	cFiliais += ")"

	cQuery +=  "SELECT DISTINCT " + Iif (MV_PAR05 == 2,'coalesce(GW2_FILIAL,GWF_FILIAL)','GW2_FILIAL') + " FILIAL  , GW2_CDPROP PROPRI, "
	cQuery +=  "	   GU3_NMABRV NMEMIT , GW2_NRCONT NRCONT, "
	cQuery +=  "	   GW2_DTIMPR DTLIBE , GW2_DTVENC DTVENC, "
	cQuery +=  "	   GW2_SITCON SITCON , GW2_SITFIN SITFIN, "
	cQuery +=  "	   GW2_VLFRET VLSERV , GW2_VLADIC VLADD, "
	cQuery +=  "	   GW2_VLDESC VLDESC , "
	cQuery +=  "       (SELECT SUM(GWF_BASISS) FROM " + RetSqlName('GWF') + " GWF WHERE  GWF.GWF_FILIAL = GW2.GW2_FILIAL "
	cQuery +=  "        AND GWF.GWF_NRCONT  = GW2.GW2_NRCONT AND GWF.D_E_L_E_T_ = '') + "
	cQuery +=  "       ( SELECT SUM(GW5_VALOR) FROM " + RetSqlName('GW5') + " GW5 WHERE  GW5.GW5_FILIAL = GW2.GW2_FILIAL "
	cQuery +=  "       AND GW5.GW5_NRCONT  = GW2.GW2_NRCONT AND GW5.D_E_L_E_T_ = '' AND GW5.GW5_BASISS = '1' ) BASESER, "
	cQuery +=  "	   GW2_VLISS  VLISS  , GW2_VLBAIR BSRENDA, "
	cQuery +=  "	   GW2_VLIRRF VLIRRF , GW2_VLBAIN VLPREVD, "
	cQuery +=  "	   GW2_VLINSS INSSAUT, GW2_VLSEST SEST, "
	cQuery +=  "	   GW2_VLINEM INSSEMB, "
	cQuery +=  "	   (GW2_VLFRET + GW2_VLADIC + GW2_VLISS + GW2_VLIRRF + GW2_VLSEST + GW2_VLINEM -GW2_VLDESC) VLTOTAL "
	If MV_PAR05 == 2
		cQuery +=  "     ,GWF_TRANSP,GW1_CDTPDC CDTPDC, GW1_SERDC SERDC, "
		cQuery +=  "      GW1_NRDC   NRDC  , GW1_DTEMIS DTEMIS, "
		cQuery +=  "      GWN_NRROM  NRROM , GWN_DTSAI  DTLIB, "
		cQuery +=  "      GWU_DTENT  DTOCOR, GWF_NRCALC NRCALC, "
		cQuery +=  "      GWF_DTCRIA DTCRIA, "
		cQuery +=  "      (SELECT SUM(GWM_VLFRET) "
		cQuery +=  "         FROM " + RetSqlName("GWM") + " GWM "
		cQuery +=  "        WHERE GWM.GWM_FILIAL = GW2_FILIAL "
		cQuery +=  "	      AND GWM.GWM_CDTPDC = GW1.GW1_CDTPDC "
		cQuery +=  "	      AND GWM.GWM_EMISDC = GW1.GW1_EMISDC "
		cQuery +=  "	      AND GWM.GWM_SERDC  = GW1.GW1_SERDC "
		cQuery +=  "	      AND GWM.GWM_NRDC   = GW1.GW1_NRDC "
		cQuery +=  "	      AND GWM.GWM_TPDOC  = '3' "
		cQuery +=  "          AND GWM.D_E_L_E_T_ = '' "
		cQuery +=  "      ) VLFER , "
		cQuery +=  "      (SELECT SUM(GWI_VLFRET) "
		cQuery +=  " 		 FROM " + RetSQLName("GWI")
		cQuery +=  "        WHERE GWI_FILIAL = GWF.GWF_FILIAL "
		cQuery +=  " 	 	  AND GWI_NRCALC = GWF.GWF_NRCALC "
		cQuery +=  " 		  AND GWI_TOTFRE = '1' "
		cQuery +=  " 		  AND GWF_TPCALC IN ('1','6') "
		cQuery +=  " 		  AND D_E_L_E_T_ = '') VALOR , "
	 	cQuery +=  "      (SELECT SUM(GWI_VLFRET) "
		cQuery +=  " 	 	 FROM " + RetSQLName("GWI")  + " GWI "
		cQuery +=  " 	    INNER JOIN " + RetSqlName("GWF") + " GWFA ON GWI.GWI_FILIAL = GWFA.GWF_FILIAL "
		cQuery +=  " 	 	  AND GWI.GWI_NRCALC = GWFA.GWF_NRCALC "
		cQuery +=  " 		  AND GWI.GWI_TOTFRE = '1' "
		cQuery +=  " 		  AND GWFA.GWF_TPCALC NOT IN ('1','6') "
		cQuery +=  " 		  AND GWI.D_E_L_E_T_ = '' "
		cQuery +=  " 		  AND GWFA.D_E_L_E_T_ = '' "
		cQuery +=  " 		WHERE GWFA.GWF_NRROM = GWN.GWN_NRROM"
		If GFXCP1212210('GWF_FILROM')
			cQuery +=  " 	  AND GWFA.GWF_FILROM = GWN.GWN_FILIAL"
		Else
			cQuery +=  " 	  AND GWFA.GWF_FILIAL = GWN.GWN_FILIAL"
		EndIf
		cQuery +=  " 	  )  VALOTR "
	EndIf
	If MV_PAR05 == 1
		cQuery +=  "  FROM " + RetSQLName("GW2") + " GW2 "
		cQuery +=  " INNER JOIN " + RetSQLName("GU3") + " GU3 "
		cQuery +=  "	ON GU3.GU3_CDEMIT = GW2.GW2_CDPROP "
		cQuery +=  "   AND GU3.D_E_L_E_T_ = '' "
		cQuery +=  "   AND GW2.D_E_L_E_T_ = '' "
		If nCptCntrt == 2
			cQuery += " AND  GW2_DTCRIA LIKE '" + cData + "%' "
		Else
			cQuery += " AND GW2_DTVENC LIKE '" + cData + "%'"
		EndIf
		cQuery +=  " INNER JOIN " + RetSQLName("GWF") + " GWF "
		cQuery +=  "    ON GWF.GWF_FILIAL = GW2.GW2_FILIAL "
		cQuery +=  "   AND GWF.GWF_NRCONT = GW2.GW2_NRCONT "
		cQuery +=  "   AND GWF.D_E_L_E_T_ = '' "
	Else
		cQuery +=  "  FROM " + RetSQLName("GWF") + " GWF "
		cQuery +=  " INNER JOIN " + RetSQLName("GU3") + " GU3 "
		cQuery +=  "	ON GU3.GU3_CDEMIT = GWF.GWF_TRANSP "
		cQuery +=  "   AND GU3.D_E_L_E_T_ = '' "
		cQuery +=  "   AND GWF.D_E_L_E_T_ = '' "
		cQuery +=  "   AND GWF.GWF_FINCAL = '3' "
		cQuery +=  "   AND GWF.GWF_TPCALC IN ('1','6') "
		cQuery +=  " INNER JOIN " + RetSQLName("GWN") + " GWN "
		If GFXCP1212210('GWF_FILROM')
			cQuery += "	ON GWN.GWN_FILIAL = GWF.GWF_FILROM "
		Else
			cQuery += "	ON GWN.GWN_FILIAL = GWF.GWF_FILIAL "
		EndIf
		cQuery +=  "   AND GWN.GWN_NRROM = GWF.GWF_NRROM "
		cQuery +=  "   AND GWN.D_E_L_E_T_ = '' "
		cQuery +=  " INNER JOIN " + RetSQLName("GW1") + " GW1 "
		If GFXCP1212210('GW1_FILROM')
			cQuery += " ON GW1.GW1_FILROM = GWN.GWN_FILIAL "
		Else
			cQuery += " ON GW1.GW1_FILIAL = GWN.GWN_FILIAL "
		EndIf
		cQuery +=  "   AND GW1.GW1_NRROM = GWN.GWN_NRROM "
		cQuery +=  "   AND GW1.D_E_L_E_T_ = '' "
		cQuery +=  " INNER JOIN " + RetSQLName("GWH") + " GWH "
		cQuery +=  "    ON GWH.GWH_FILIAL = GW1.GW1_FILIAL "
		cQuery +=  "   AND GWH.GWH_CDTPDC = GW1.GW1_CDTPDC "
		cQuery +=  "   AND GWH.GWH_EMISDC = GW1.GW1_EMISDC "
		cQuery +=  "   AND GWH.GWH_SERDC  = GW1.GW1_SERDC "
		cQuery +=  "   AND GWH.GWH_NRDC   = GW1.GW1_NRDC "
		cQuery +=  "   AND GWH.GWH_NRCALC = GWF.GWF_NRCALC "
		cQuery +=  "   AND GWH.D_E_L_E_T_ = '' "
		cQuery +=  " INNER JOIN " + RetSQLName("GWU") + " GWU "
		cQuery +=  "    ON GWU.GWU_FILIAL = GW1.GW1_FILIAL "
		cQuery +=  "   AND GWU.GWU_CDTPDC = GW1.GW1_CDTPDC "
		cQuery +=  "   AND GWU.GWU_EMISDC = GW1.GW1_EMISDC "
		cQuery +=  "   AND GWU.GWU_SERDC  = GW1.GW1_SERDC "
		cQuery +=  "   AND GWU.GWU_NRDC   = GW1.GW1_NRDC "
		cQuery +=  "   AND GWU.D_E_L_E_T_ = '' "
		cQuery +=  "   AND GWU.GWU_SEQ = (SELECT MAX(GWU_SEQ) "
		cQuery +=  "					    FROM " + RetSQLName("GWU") + " GW1SUB "
		cQuery +=  "					   WHERE GW1SUB.GWU_FILIAL = GW1.GW1_FILIAL "
		cQuery +=  "						 AND GW1SUB.GWU_CDTPDC = GW1.GW1_CDTPDC "
		cQuery +=  "						 AND GW1SUB.GWU_EMISDC = GW1.GW1_EMISDC "
		cQuery +=  "						 AND GW1SUB.GWU_SERDC  = GW1.GW1_SERDC "
		cQuery +=  "						 AND GW1SUB.GWU_NRDC   = GW1.GW1_NRDC "
		cQuery +=  "                         AND GW1SUB.D_E_L_E_T_ = '' ) "
		cQuery +=  "  LEFT JOIN " + RetSQLName("GW2") + " GW2 "
		cQuery +=  "    ON GWF.GWF_FILIAL = GW2.GW2_FILIAL "
		cQuery +=  "   AND GWF.GWF_NRCONT = GW2.GW2_NRCONT "
		cQuery +=  "   AND GW2.D_E_L_E_T_ = '' "
		If nCptCntrt == 2
			cQuery += " AND GW2.GW2_DTCRIA LIKE '" + cData + "%' "
		Else
			cQuery += " AND GW2.GW2_DTVENC LIKE '" + cData + "%'"
		EndIf
	EndIf

	If !Empty(cTransp)
		If MV_PAR05 == 1
			cWhere += " GW2.GW2_CDPROP = '" + cTransp + "'"
		Else
			cWhere += " (GW2.GW2_CDPROP = '" + cTransp + "' OR GWF.GWF_TRANSP = '" + cTransp + "')"
		EndIf
	EndIf

	If nComCntrt == 2 .Or. nComCntrt == 3 .Or. (nComCntrt != 1 .And. MV_PAR05 == 2) .Or. (nSemCntrt != 1 .And. MV_PAR05 == 2) .Or. (nSemCntrt == 1 .And. MV_PAR05 == 2)
		If !Empty(cTransp)
			cWhere += " AND "
		EndIf
		cWhere += " ( "
	EndIf

	If nComCntrt == 2
		cWhere += " ( (GW2_SITCON = '2' OR GW2_SITCON = '3' )) " // Situação do contrato, Confirmado ou emitido
	ElseIf nComCntrt == 3
		cWhere += " (GW2_SITFIN = '4') " // Liberado no fiscal
	EndIf

	If nSemCntrt != 1 // CALCULOS SEM CONTRATO ATÉ O PERIODO
		If MV_PAR05 == 2
			If nComCntrt != 1
				cWhere += " OR "
			EndIf
			cWhere += " ( "
			If nSemCntrt == 2 // Considerar no periodo 
				cWhere += " GWF_DTCRIA LIKE '" + cData + "%' "
			Else // nSemCntrt == 3 -- Periodo e anterior
				cWhere += " GWF_DTCRIA <= '" + cData + "31' "
			EndIf
			cWhere += " ) " // Final dos dois parenteses
		EndIf
	Else
		If MV_PAR05 == 2 // SE DETALHADO, ELIMINAR CALCULOS SEM CONTRATO
			If nComCntrt != 1
				cWhere += " AND "
			EndIf
			cWhere += " (GW2_NRCONT IS NOT NULL) "
		EndIf
	EndIf

	If nComCntrt == 2 .Or. nComCntrt == 3 .Or. (nComCntrt != 1 .And. MV_PAR05 == 2) .Or. (nSemCntrt != 1 .And. MV_PAR05 == 2) .Or. (nSemCntrt == 1 .And. MV_PAR05 == 2)
		cWhere += " ) "
	EndIf

	If !Empty(aGCList)
		If nComCntrt == 2 .Or. nComCntrt == 3 .Or. (nComCntrt != 1 .And. MV_PAR05 == 2) .Or. (nSemCntrt != 1 .And. MV_PAR05 == 2) .Or. (nSemCntrt == 1 .And. MV_PAR05 == 2)
			cWhere += " AND "
		EndIf

		If MV_PAR05 == 1
			cWhere += " GW2.GW2_FILIAL IN " + cFiliais + " "
		Else
			cWhere += " (GW2.GW2_FILIAL IN " + cFiliais + " OR GWF.GWF_FILIAL IN " + cFiliais + ") "
		EndIf
	EndIf

	//---------------------------------------------------------------
	// Fim da query
	//--------------------------------------------------------------	
	cAli   := GetNextAlias()
	cQuery := ChangeQuery( cQuery + Iif(!Empty(Strtran(Strtran(cWhere,"(",""),")","")),'Where ' + cWhere, ""))
	dbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery), cAli, .F.)

	oSection:Init()
	(cAli)->(dbGoTop())
	While !(cAli)->( Eof() ) .And. !oReport:Cancel()
		lInitTot := .T.
		oSection:PrintLine()
		If cChaveCtr != (cAli)->FILIAL+(cAli)->NRCONT
			cChaveCtr := (cAli)->FILIAL+(cAli)->NRCONT
			nVLSERV  += (cAli)->VLSERV
			nVLADD   += (cAli)->VLADD
			nVLDESC  += (cAli)->VLDESC
			nBASESER += (cAli)->BASESER
			nVLISS   += (cAli)->VLISS
			nBSRENDA += (cAli)->BSRENDA
			nVLIRRF  += (cAli)->VLIRRF
			nVLPREVD += (cAli)->VLPREVD
			nINSSAUT += (cAli)->INSSAUT
			nSEST    += (cAli)->SEST
			nINSSEMB += (cAli)->INSSEMB
			nVLTOTAL += (cAli)->VLTOTAL
		EndIf

		(cAli)->( dbSkip() )
	EndDo

	oSection:Finish()
	(cAli)->(dbCloseArea())

	If lInitTot
		oSection2:Init()
		oSection2:PrintLine()
		oSection2:Finish()
	EndIf
Return

/*/{Protheus.doc}BuscaSit
Função busca a descrição da situação do contrato com o financeiro

@Param cSit, Codigo da situação
@param cCmp, Define se retorna a descrição da situação 1-> do contrato; 2-> Financeiro
@Return cRet, Descrição da situação
@Author Alexandre José Cuchi
@Since 15/10/2014
@Version 1.0
/*/
Static Function BuscaSit(cSit,cCmp)
	Local cRet

	If cCmp == '1'
		Do Case
			Case cSit == '1'
				cRet := "Nao Enviado"
			Case cSit == '2'
				cRet := "Pendente"
			Case cSit == '3'
				cRet := "Rejeitado"
			Case cSit == '4'
				cRet := "Atualizado"
			Case cSit == '5'
				cRet := "Pendente Cancelamento"
		EndCase
	Else
		Do Case
			Case cSit == '1'
				cRet := "Criado"
			Case cSit == '2'
				cRet := "Confirmado"
			Case cSit == '3'
				cRet := "Emitido"
			Case cSit == '4'
				cRet := "Cancelado"
		EndCase
	EndIf
Return cRet

/*/{Protheus.doc}
Faz uma busca de todos os cálculos relacionados a um transportador
que tenha seja diferente de cálculo normal e redespacho

@Param cNrDc = Numero do documento para consulta
@Return cRet = String concatenada dos valores dos cálculos separados por ';'
@Author Alexandre José Cuchi
@Since 15/10/2014
@Version 1.0 
/*/
Static Function ListCalc(cNrRom,cFil)
	Local cRet     := ""
	Local cTabela  := ""
	Local cAliNr   := GetNextAlias()

	//--------- Começo da consulta ---------//
	cTabela += " SELECT DISTINCT GWF.GWF_NRCALC NRCALC"
	cTabela += "   FROM " + RetSqlName("GWF") + " GWF"
	cTabela += "  WHERE GWF_NRROM = '" + cNrRom + "'"
	cTabela += "    AND GWF_TPCALC NOT IN ('1','6')"
	cTabela += "    AND GWF.D_E_L_E_T_ = ''"
	If GFXCP1212210('GWF_FILROM')
		cTabela += " AND GWF.GWF_FILROM = '" + cFil + "'"
	Else
		cTabela += " AND GWF.GWF_FILIAL = '" + cFil + "'"
	EndIf
	//--------- Final da consulta ---------//
	cTabela := ChangeQuery(cTabela)
	dbUseArea(.T., "TOPCONN", TCGENQRY(,,cTabela), cAliNr, .F.)
	While !(cAliNr)->( Eof() )
		If !Empty(cRet)
			cret += "; "
		EndIf
		cRet += (cAliNr)->NRCALC
		(cAliNr)->(dbSkip())
	EndDo

	(cAliNr)->(dbCloseArea())
Return cRet
