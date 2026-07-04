/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWBROWSE.CH"
#INCLUDE "FATR080.CH"

Static oMapKey		:= THashMap():New()
Static aCRMA580E	:= {}

//-------------------------------------------------------------------
/*/{Protheus.doc} FATR080
Emissao de relatorio de notas fiscais canceladas ou que tiveram desconto de valor
Necessário CRMXFUNGEN com data igual ou superior a 24/05/2017 12.1.16
@author  TOTVS 
@version P12
@since   11/03/2015  
/*/
//-------------------------------------------------------------------
User Function FATR080()
	Local oReport := Nil
	Local aPDFields	:= {"A1_NOME"}

	FATPDLoad(Nil,Nil,aPDFields)	
	
	If cPaisLoc == "BRA"
		If FindFunction("CRMXGeraExcel")
			Pergunte("FATR080",.F.)
			oReport := ReportDef()
			//-------------------------------------------------------------------
			// Apresenta a tela de impressão. 
			//-------------------------------------------------------------------  
			oReport:PrintDialog()
		Else
			HELP(" ",1,"CRMXGeraExcel", ,STR0076,1,0) //"Necessário CRMXFUNGEN.PRW com data superior o 24/05/2017"
		EndIf
	Else
		HELP(" ",1,"BrazilOnly", ,STR0077,1,0) //"Relatório exclusivo para localização Brasil"
	EndIf

	FATPDUnload()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef  
Criacao dos componentes de impressao 

@author  TOTVS 
@version P12
@since   11/03/2015                                                            
/*/
//-------------------------------------------------------------------
Static Function ReportDef()
	Local oReport   	:= Nil
	Local oSection1 	:= Nil
	Local oSection2 	:= Nil
	Local cDescription  := STR0001 //"Cancelamentos e Descontos por Agrupador"
	Local cTemp 		:= GetNextAlias()
	Local oTempTable	:= Nil
	Local oTempPlan   	:= Nil
	
	//-------------------------------------------------------------------
	// Define as sessões do relatório. 
	//-------------------------------------------------------------------                      
	DEFINE REPORT oReport NAME "FATR080"  TITLE cDescription PARAMETER "FATR080" ACTION { |oReport| PrintReport( oReport, cTemp, oTempTable, oTempPlan ) } DESCRIPTION cDescription       
		//-------------------------------------------------------------------
		// Grupos. 
		//------------------------------------------------------------------- 		
		DEFINE SECTION oSection1 OF oReport TABLE cTemp TITLE STR0028 //"Agrupador" 
			oSection1:SetHeaderSection(.F.)
			
			DEFINE CELL NAME "TB_GRUPO" OF oSection1 TITLE STR0002 SIZE TamSX3("AOM_CODAGR")[1] BOLD //"Grupo"     	
			DEFINE CELL NAME "TB_DESCR" OF oSection1 TITLE STR0003 SIZE TamSX3("AOM_DESCRI")[1] BOLD //"Descrição"
		
		//-------------------------------------------------------------------
		// Notas canceladas ou com descontos. 
		//-------------------------------------------------------------------
		DEFINE SECTION oSection2 OF oSection1 TABLE cTemp TITLE STR0029 //"Notas canceladas ou com descontos"  
			oSection2:SetTotalInLine(.T.)
			oSection2:SetHeaderPage(.T.)

			DEFINE CELL NAME "TB_FILIAL" 	OF oSection2 TITLE STR0004 SIZE TamSX3("D1_FILIAL")[1] 	//"Filial"	
			DEFINE CELL NAME "TB_CLIENTE" 	OF oSection2 TITLE STR0005 SIZE TamSX3("A1_COD")[1]+1 	//"Codigo"	
			DEFINE CELL NAME "TB_NOME"   	OF oSection2 TITLE STR0006 SIZE TamSX3("A1_NOME")[1]  Align Left 			//"Nome"   	  				
			DEFINE CELL NAME "TB_SERIEE"   	OF oSection2 TITLE STR0007 SIZE TamSX3("F1_SERIE")[1]  Align Left //"Série" 
			DEFINE CELL NAME "TB_NUMENT"  	OF oSection2 TITLE STR0008 SIZE TamSX3("F1_DOC")[1] 	//"Nr NFE" 
			DEFINE CELL NAME "TB_EMISENT" 	OF oSection2 TITLE STR0009 SIZE 12 						//"Emissão"     		 
			DEFINE CELL NAME "TB_SERIES" 	OF oSection2 TITLE STR0007 SIZE TamSX3("F2_SERIE")[1] 	//"Série"  
			DEFINE CELL NAME "TB_NUMSAI" 	OF oSection2 TITLE STR0010 SIZE TamSX3("F2_DOC")[1] 	//"Nr NFS"  			
			DEFINE CELL NAME "TB_EMISSAI" 	OF oSection2 TITLE STR0009 SIZE 12 						//"Emissão"   			
			DEFINE CELL NAME "TB_VENCTO" 	OF oSection2 TITLE STR0011 SIZE 12 						//"Vencimento"      
			DEFINE CELL NAME "TB_DESC" 		OF oSection2 TITLE STR0012 SIZE TamSX3("D1_TOTAL")[1]  +TamSX3("D1_TOTAL")[2]   PICTURE "@E 99,999,999.99"  Align RIGHT //"Vl.Desc/Canc."  	 
			DEFINE CELL NAME "TB_VLNFOR"	OF oSection2 TITLE STR0013 SIZE TamSX3("F2_VALBRUT")[1]+TamSX3("F2_VALBRUT")[2] PICTURE "@E 99,999,999.99"	Align RIGHT //"Vl. NF Or."		 
			DEFINE CELL NAME "TB_TOTAL"		OF oSection2 TITLE STR0014 SIZE TamSX3("F2_VALBRUT")[1]+TamSX3("F2_VALBRUT")[2] PICTURE "@E 99,999,999.99"  Align RIGHT //"Total"	 
			DEFINE CELL NAME "TB_CODMOT"	OF oSection2 TITLE STR0031 SIZE TamSX3("DHI_CODIGO")[1] //"Motivo"	 
			DEFINE CELL NAME "TB_DESCMOT"	OF oSection2 TITLE STR0032 SIZE 40 						//"Descricao"	 
			DEFINE CELL NAME "TB_HISTORI"	OF oSection2 TITLE STR0033 SIZE 22 						//"Histórico"	 

		//-------------------------------------------------------------------
		// Totaliza por agrupador. 
		//-------------------------------------------------------------------
		If ! ( Empty( MV_PAR09 ) )
			DEFINE BREAK oBreak OF oSection2 WHEN oSection1:Cell("TB_GRUPO") TITLE STR0015 //"Total Grupo"                                               
			DEFINE FUNCTION FROM oSection2:Cell("TB_DESC") FUNCTION SUM BREAK oBreak NO END REPORT NO END SECTION         
		EndIf

	//-------------------------------------------------------------------
	// Força a exibição do relatório no formato paisagem. 
	//-------------------------------------------------------------------  		
	oReport:SetLandscape()	
	
Return(oReport)

//-------------------------------------------------------------------
/*/{Protheus.doc} PrintReport  
Relatorio de cancelamentos e descontos
                   
	mv_par01     // Da NF de saída Original                        
	mv_par02     // Até NF de saída Original 	                            
	mv_par03     // Da Emissao da NF Saida Original                                                  
	mv_par04     // Até Emissão da NF de Saída Original                              
	mv_par05     // Da NF de Entrada                                
	mv_par06     // Até NF de Entrada                       
	mv_par07     // Da Emissão da NF de Entrada                             
	mv_par08     // Até Emissão da NF de Entrada                           
	mv_par09     // Agrupador                                                  
	mv_par10     // Todas as Empresas ?
	mv_par11     // Todas as Unidades de Negócio ?
	mv_par12     // Todas as Filiais ?
	mv_par13     // Gera Planilha ?

@author  TOTVS 
@version P12
@since   11/03/2015
/*/
//-------------------------------------------------------------------
Static Function PrintReport( oReport, cTemp, oTempTable, oTempPlan )
	Local oSection1 	:= oReport:Section(1)
	Local oSection2 	:= oSection1:Section(1)
	Local aSummary  	:= {}
	Local aGeneral		:= {}	
	Local aPool			:= {}
	Local aGroup		:= {}
	Local aAreaSM0		:= SM0->( GetArea() )
	Local aField		:= GetFields()
	Local aFieldPlan       := {}
	Local aAccess		:= FWLoadSM0() 
	Local cFilOri 		:= cFilAnt
	Local cResultSet 	:= ""
	Local cTitle		:= ""
	Local cDescription  := STR0001
	Local cCompany		:= FWCompany() 
	Local cUnitBusiness	:= FWUnitBusiness()
	Local cBranch		:= FWFilial()
	Local nTotal  		:= 0
	Local nGeneral		:= 0
	Local nType        	:= 0
	Local nGroup        := 0
	Local nReason       := 0	
	Local nItem			:= 0
	Local nDevice 		:= oReport:nDevice  
	Local cChave        := ""  
	Local nSaldoNFS     := 0
	Local nValFim       := 0
	Local nDescont      := 0
	Local cDescMot      := ""
	Local cHistori      := ""
	Local cPlanilha     := GetNextAlias()
	Local aAreaSD2      := SD2->(GetArea())
	Local cSerieRef     := ""
	Local cDocRef       := ""
	Local cNomeCli		:= ""
	Local cNCliObf		:= ""
	Local cCNPJP 		:= ""
	Local cCNPJR		:= ""
	Local cCNPJObf 		:= ""

	
	DbSelectArea("SD2")

	//-------------------------------------------------------------------
	// Monta a Tabela Temporária para o relatório. 
	//------------------------------------------------------------------- 
	oTempTable := FWTemporaryTable():New(cTemp,aField)
	oTempTable:AddIndex("1", {"TB_GRUPO"} )
	oTempTable:Create()

	//-------------------------------------------------------------------
	// Monta a Tabela Temporária para a planilha. 
	//-------------------------------------------------------------------
	If ( MV_PAR13 == 1 )
		aFieldPlan := GetFieldExcel() 
		oTempPlan  := FWTemporaryTable():New(cPlanilha,aFieldPlan)
		oTempPlan:AddIndex("2", {"TB_GRUPO"} )
		oTempPlan:Create()
	Endif

	//-------------------------------------------------------------------
	// Monta o título do relatório. 
	//------------------------------------------------------------------- 
	If	( MV_PAR10 == 1 )
		cTitle := cDescription + " - " + STR0016 //"Todas as empresas" 
	Else
		//-------------------------------------------------------------------
		// Todas as empresas. 
		//------------------------------------------------------------------- 
		If ( MV_PAR11 == 1 ) 
			cTitle := cDescription + " - " 
			
			If ! Empty( FWCompany() )
				cTitle += AllTrim( FWCompanyName() ) + ", "
			EndIf
			
			If ! Empty( FWUnitBusiness() )
				cTitle += STR0017 + ", " //"todas as unidades"   
			EndIf 			
			
			cTitle += STR0018 //"todas as filiais"
		Else
			//-------------------------------------------------------------------
			// Todas as unidades. 
			//------------------------------------------------------------------- 
			If ( MV_PAR12 == 1 )
				cTitle := cDescription + " - " 
				
				If ! Empty( FWCompany() )
					cTitle += AllTrim( FWCompanyName() ) + ", " 
				EndIf 
				
				If ! Empty( FWUnitBusiness() )
					cTitle += AllTrim( FWUnitName() ) + ", " 
				EndIf 		
				
				cTitle += STR0018 //"todas as filiais"
			Else
				//-------------------------------------------------------------------
				// Filial corrente.  
				//------------------------------------------------------------------- 
				cTitle := cDescription + " - " 
				
				If ! Empty( FWCompany() )
					cTitle += AllTrim( FWCompanyName() ) + ", " 
				EndIf 
				
				If ! Empty( FWUnitBusiness() )
					cTitle += AllTrim( FWUnitName() ) + ", " 
				EndIf 				
				
				cTitle += FWFilialName()
			EndIf		
		EndIf 	
	Endif

	//-------------------------------------------------------------------
	// Define o título do relatório. 
	//-------------------------------------------------------------------
	oReport:SetTitle( cTitle ) 

	//-------------------------------------------------------------------
	// Define qual agrupador será utilizado. 
	//-------------------------------------------------------------------
	If ! ( Empty( MV_PAR09 ) )
		If ( Len( aCRMA580E ) == 0 )
			aPool := CRMA580E( { MV_PAR09 } )
		Else
			aPool := aCRMA580E
		EndIf
	EndIf 
	
	//-------------------------------------------------------------------
	// Localiza o grupo de empresas corrente. 
	//-------------------------------------------------------------------
	If ( SM0->( DbSeek( cEmpAnt ) ) )
		//-------------------------------------------------------------------
		// Percorre todas as empresas, unidades de negócio e filiais 
		//-------------------------------------------------------------------
		While SM0->( ! Eof() ) .And. SM0->M0_CODIGO == cEmpAnt			
			cFilAnt		:= SM0->M0_CODFIL
			
			//-------------------------------------------------------------------
			// Verifica se o usuário tem acesso a filial. 
			//------------------------------------------------------------------- 
			If ! ( aScan( aAccess, {|x| x[1] == cEmpAnt .And. x[2] == cFilAnt } ) == 0 )
				//-------------------------------------------------------------------
				// Define se imprime todas as empresas. 
				//------------------------------------------------------------------- 
				If ( MV_PAR10 == 1 ) 
					cCompany := FWCompany()
					
					MV_PAR11 := 1 
					MV_PAR12 := 1
				Endif
		
				//-------------------------------------------------------------------
				// Define se imprime todas as unidades de negócio. 
				//------------------------------------------------------------------- 
				If ( MV_PAR11 == 1 ) 
					cUnitBusiness := FWUnitBusiness()
	
					MV_PAR12 := 1	  
				Endif
				
				//-------------------------------------------------------------------
				// Define se imprime todas as filiais. 
				//------------------------------------------------------------------ 
				If	( MV_PAR12 == 1 ) 
					cBranch := FWFilial()    
				Endif
	
				If 	( SM0->M0_CODIGO == cEmpAnt .And. ( cCompany + cUnitBusiness + cBranch ) $ SM0->M0_CODFIL )
					//-------------------------------------------------------------------
					// Obtém os dados para o relatório. 
					//------------------------------------------------------------------- 
					cResultSet := U_FATR080QRY(MV_PAR01, MV_PAR02, MV_PAR03, MV_PAR04, MV_PAR05, MV_PAR06, MV_PAR07, MV_PAR08)
		
					//-------------------------------------------------------------------
					// Monta a tabela temporária com os valores formatados do resultset.  
					//------------------------------------------------------------------- 
					While ! (cResultSet)->( Eof() )
						If cChave == (cResultSet)->F2_SERIE+(cResultSet)->F2_DOC+(cResultSet)->A1_COD+(cResultSet)->A1_LOJA
							nSaldoNFS		-= nDescont  // abater o desconto anterior quando repete NF Saida
							nDescont		:= xMoeda(((cResultSet)->D1_TOTAL - (cResultSet)->D1_VALDESC),(cResultSet)->F1_MOEDA,1,dDataBase,TamSX3("D1_TOTAL")[2])
							nValFim		:= nSaldoNFS - nDescont
						Else
							nDescont		:= xMoeda(((cResultSet)->D1_TOTAL - (cResultSet)->D1_VALDESC),(cResultSet)->F1_MOEDA,1,dDataBase,TamSX3("D1_TOTAL")[2])
							nSaldoNFS		:= xMoeda((cResultSet)->F2_VALBRUT,(cResultSet)->F1_MOEDA,1,dDataBase,TamSX3("F2_VALBRUT")[2])
							nValFim		:= xMoeda((cResultSet)->F2_VALBRUT - ((cResultSet)->D1_TOTAL-(cResultSet)->D1_VALDESC),(cResultSet)->F1_MOEDA,1,dDataBase,TamSX3("D1_TOTAL")[2])
							cChave			:= (cResultSet)->F2_SERIE+(cResultSet)->F2_DOC+(cResultSet)->A1_COD+(cResultSet)->A1_LOJA
						Endif
						
						cDescMot := AllTrim(Posicione("DHI",1,xFilial("DHI")+(cResultSet)->F1_MOTRET,"DHI_DESCRI"))
						cHistori := AllTrim(Posicione("SF1",1,xFilial("SF1")+(cResultSet)->F1_DOC+(cResultSet)->F1_SERIE+(cResultSet)->A1_COD+(cResultSet)->A1_LOJA+(cResultSet)->F1_TIPO,"F1_HISTRET"))
						
						cNomeCli := SubStr((cResultSet)->A1_NOME,1,50)

						If Empty(cNCliObf) .And. FATPDIsObfuscate("A1_NOME") 
							cNCliObf := FATPDObfuscate(cNomeCli)  
						EndIf

						Reclock( cTemp, .T. )
							(cTemp)->TB_FILIAL		:= cFilAnt
							(cTemp)->TB_TIPO		:= (cResultSet)->F1_SERIE
							(cTemp)->TB_CLIENTE		:= (cResultSet)->A1_COD
							(cTemp)->TB_NOME	 	:= IIF(Empty(cNCliObf),cNomeCli,cNCliObf)
							(cTemp)->TB_SERIEE 		:= (cResultSet)->F1_SERIE
							(cTemp)->TB_NUMENT 		:= (cResultSet)->F1_DOC
							(cTemp)->TB_EMISENT 	:= StoD( (cResultSet)->F1_DTDIGIT )
							(cTemp)->TB_SERIES 		:= (cResultSet)->F2_SERIE
							(cTemp)->TB_NUMSAI 		:= (cResultSet)->F2_DOC
							(cTemp)->TB_EMISSAI		:= StoD( (cResultSet)->F2_EMISSAO )
							(cTemp)->TB_VENCTO		:= StoD( (cResultSet)->E1_VENCREA )
							(cTemp)->TB_VLNFOR 		:= nSaldoNFS
							(cTemp)->TB_TOTAL 		:= nValFim
							(cTemp)->TB_DESC		:= nDescont 
							(cTemp)->TB_CODMOT		:= AllTrim((cResultSet)->F1_MOTRET)
							(cTemp)->TB_DESCMOT     := cDescMot
							(cTemp)->TB_HISTORI     := cHistori
								
							//-------------------------------------------------------------------
							// Totaliza por agrupador.  
							//------------------------------------------------------------------- 	
							If ! ( Empty( MV_PAR09 ) ) 
								If ! ( Len( aPool ) == 0 )					
									aGroup := CRMA580Group( aPool, getKey( aPool[1][3], cResultSet ),.F., .T., oMapKey )
									If !Empty(aGroup)	
										(cTemp)->TB_GRUPO	:= aGroup[3]		
										(cTemp)->TB_DESCR	:= aGroup[4]
									EndIf
								EndIf 
							EndIf 						
						MsUnlock( cTemp )
			
						If ( MV_PAR13 == 1 )             //   Gera Planilha

							If (cResultSet)->A1_TPMEMB=="1"
								cTipMembro := STR0072				//	"1-Unidade de Negócio"
								cNomMembro := Posicione("ADK",1,xFilial("ADK")+(cResultSet)->A1_CODMEMB,"ADK_NOME")
							ElseIf (cResultSet)->A1_TPMEMB=="2"
								cTipMembro := STR0073				//	"2-Usuário do CRM"
								cNomMembro := UsrRetName((cResultSet)->A1_CODMEMB)
							ElseIf (cResultSet)->A1_TPMEMB=="3"
								cTipMembro := STR0074				//	"3-Equipe"
								cNomMembro := Posicione("ACA",1,xFilial("ACA")+(cResultSet)->A1_CODMEMB,"ACA_DESCRI")
							Else
								cTipMembro := ""
								cNomMembro := ""
							Endif
	
							If (cResultSet)->RECNOREF > 0
								DbSelectArea("SD2")
								DbGoto((cResultSet)->RECNOREF)
								cSerieRef         := SD2->D2_SERIE
								cDocRef           := SD2->D2_DOC
							Else
								cSerieRef         := ""
								cDocRef           := ""
							Endif

							
							cNomeCli := SubStr((cResultSet)->A1_NOME,1,50)

							If Empty(cNCliObf) .And. FATPDIsObfuscate("A1_NOME") 
								cNCliObf := FATPDObfuscate(cNomeCli) 
							EndIf

							cCNPJP := If((cResultSet)->A1_PESSOA='F',Left(Right('000000000'+(cResultSet)->A1_CGC,11),9),Left(Right('000000000'+(cResultSet)->A1_CGC,16),8))
							cCNPJR := If((cResultSet)->A1_PESSOA='F',' ',Left(Right((cResultSet)->A1_CGC,6),4))

							If Empty(cCNPJObf) .And. FATPDIsObfuscate("A1_CGC")  
								cCNPJObf	:= FATPDObfuscate(cCNPJP)
								cCNPJP		:= cCNPJObf
								cCNPJR		:= cCNPJObf      
							EndIf    
							
							RecLock( cPlanilha , .T. )
								If !Empty(FwCompany())
									(cPlanilha)->TB_EMPRES      := FwCompanyName(cEmpAnt,cFilAnt)
								Endif
								If !Empty(FwUnitBusiness())
									(cPlanilha)->TB_UNIDAD      := FwUnitName(cEmpAnt,cFilAnt)
								Endif
								(cPlanilha)->TB_NOMFIL      := FwFilialName(cEmpAnt,cFilAnt)
								(cPlanilha)->TB_FILIAL      := cFilAnt
								(cPlanilha)->TB_TIPO        := (cResultSet)->F1_TIPO
								(cPlanilha)->TB_CLIENTE     := (cResultSet)->A1_COD
								(cPlanilha)->TB_NOME        := IIF(Empty(cNCliObf),cNomeCli,cNCliObf) 
								(cPlanilha)->TB_PESSOA      := (cResultSet)->A1_PESSOA
								(cPlanilha)->TB_CNPJRAI     := cCNPJP
								(cPlanilha)->TB_CNPJFIL     := cCNPJR
								(cPlanilha)->TB_CODSEG      := (cResultSet)->A1_CODSEG
								(cPlanilha)->TB_DESSEG      := (cResultSet)->AOV_DESSEG
								(cPlanilha)->TB_SERIEE      := (cResultSet)->F1_SERIE
								(cPlanilha)->TB_NUMENT      := (cResultSet)->F1_DOC
								(cPlanilha)->TB_EMISENT     := StoD( (cResultSet)->F1_DTDIGIT )
								(cPlanilha)->TB_SERIREF     := cSerieRef
								(cPlanilha)->TB_REFATUR     := cDocRef
								(cPlanilha)->TB_SERIES      := (cResultSet)->F2_SERIE
								(cPlanilha)->TB_NUMSAI      := (cResultSet)->F2_DOC
								(cPlanilha)->TB_EMISSAI     := StoD( (cResultSet)->F2_EMISSAO )
								(cPlanilha)->TB_ITEMORI     := (cResultSet)->D2_ITEM
								(cPlanilha)->TB_VENCTO      := StoD( (cResultSet)->E1_VENCREA )
								(cPlanilha)->TB_VLNFOR      := nSaldoNFS
								(cPlanilha)->TB_TOTAL       := nValFim
								(cPlanilha)->TB_DESC        := nDescont 
								(cPlanilha)->TB_INSS        := (cResultSet)->INSS
								(cPlanilha)->TB_PIS         := (cResultSet)->PIS
								(cPlanilha)->TB_COFINS      := (cResultSet)->COFINS 
								(cPlanilha)->TB_ISS         := (cResultSet)->ISS 
								(cPlanilha)->TB_GRUPO       := (cResultSet)->BM_GRUPO
								(cPlanilha)->TB_GRPDES      := (cResultSet)->BM_DESC
								(cPlanilha)->TB_CODMOT      := AllTrim((cResultSet)->F1_MOTRET)
								(cPlanilha)->TB_DESCMOT     := cDescMot
								(cPlanilha)->TB_HISTORI     := cHistori
								(cPlanilha)->TB_CTACTB      := (cResultSet)->D2_CONTA
								(cPlanilha)->TB_DESCTA      := (cResultSet)->CT1_DESC01
								(cPlanilha)->TB_PRODUTO     := (cResultSet)->B1_COD
								(cPlanilha)->TB_DESPRD      := (cResultSet)->B1_DESC
								(cPlanilha)->TB_CLASVL      := (cResultSet)->D2_CLVL
								(cPlanilha)->TB_CCUSTO      := (cResultSet)->D2_CCUSTO
								(cPlanilha)->TB_DCCUST      := (cResultSet)->CTT_DESC01
								(cPlanilha)->TB_ITEMCC      := (cResultSet)->D2_ITEMCC
								(cPlanilha)->TB_CODTER      := (cResultSet)->A1_CODTER
								(cPlanilha)->TB_NOMTER      := (cResultSet)->AOY_NMTER
								(cPlanilha)->TB_TIPMEMB     := cTipMembro
								(cPlanilha)->TB_CODMEMB     := (cResultSet)->A1_CODMEMB
								(cPlanilha)->TB_NOMMEMB     := cNomMembro
	

								//-------------------------------------------------------------------
								// Se tiver agrupador.  
								//------------------------------------------------------------------- 	
								If !Empty( MV_PAR09 ) .And. !Empty( aGroup )  
									(cPlanilha)->TB_AGRUP       := aGroup[3]
									(cPlanilha)->TB_AGRDES      := aGroup[4]
								EndIf
							MsUnlock( cPlanilha )
						Endif 

						(cResultSet)->( DBSkip() )
					EndDo
					//-------------------------------------------------------------------
					// Libera a memória alocada para o acelerador de busca.
					//-------------------------------------------------------------------	
					oMapKey:Clean()	
					
					(cResultSet)->( DBCloseArea() ) 
				Endif
			EndIf 

			SM0->(DbSkip())
		EndDo
	EndIf
	
	//-------------------------------------------------------------------
	// Restaura o cache, SM0 e cFilAnt.  
	//------------------------------------------------------------------- 			
	
	aCRMA580E	:= {}
	cFilAnt	 	:= cFilOri
 	SM0->( RestArea( aAreaSM0 ) )
	
	//-------------------------------------------------------------------
	// Define o conjunto de dados para o relatório.  
	//-------------------------------------------------------------------
	BEGIN REPORT QUERY oSection1
		BEGINSQL ALIAS cTemp
			(cTemp)->( DBSetOrder(1) )
			(cTemp)->( DBGoTop() ) 		
	 	ENDSQL    
	END REPORT QUERY oSection1 	

	//-------------------------------------------------------------------
	// Imprime a página principal.  
	//------------------------------------------------------------------- 
	oSection2:SetParentQuery()
	oSection2:SetParentFilter( { |cParam| cParam == (cTemp)->TB_GRUPO},{|| (cTemp)->TB_GRUPO } ) 
	oSection1:Print()
	oSection2:Print()	

	//-------------------------------------------------------------------
	// Monta o resumo dos dados.  
	//------------------------------------------------------------------- 
	(cTemp)->(dbGoTop())
	
	While !(cTemp)->(EOF())
		If ! ( nDevice == IMP_EXCEL )
			//-------------------------------------------------------------------
			// Monta o resumo por tipo/serie da NFE.  
			//------------------------------------------------------------------- 
			nType := aScan(aSummary,{|x| AllTrim(x[1]) == AllTrim((cTemp)->TB_TIPO) })
			
			If ( nType == 0 )                                                 
		    	aAdd(aSummary,{AllTrim((cTemp)->TB_TIPO),0,0,{} })
		    	nType := Len(aSummary)
		   	EndIf 
	   		
	   		aSummary[nType,2] += (cTemp)->TB_DESC
			   	
			//-------------------------------------------------------------------
			// Monta o resumo por grupo.  
			//------------------------------------------------------------------- 
			nGroup := aScan(aSummary[nType,4],{|x| AllTrim(x[1]) == AllTrim((cTemp)->TB_GRUPO) })
		   
		   	If nGroup == 0                                                 
		    	aAdd(aSummary[nType,4],{AllTrim((cTemp)->TB_GRUPO),AllTrim((cTemp)->TB_DESCR),0,0,{} })
		    	nGroup := Len(aSummary[nType,4])
		   	EndIf
		   	
		   	aSummary[nType,4,nGroup,3] += (cTemp)->TB_DESC
			   	
			//-------------------------------------------------------------------
			// Monta o resumo por motivo.  
			//------------------------------------------------------------------- 
			nReason := aScan(aSummary[nType,4,nGroup,5],{|x| AllTrim(x[1]) == AllTrim((cTemp)->TB_CODMOT) })
		   	
		   	If nReason == 0                                                 
		    	aAdd(aSummary[nType,4,nGroup,5],{ AllTrim((cTemp)->TB_CODMOT), AllTrim((cTemp)->TB_DESCMOT),0,0 })
		    	nReason := Len(aSummary[nType,4,nGroup,5])
		   	EndIf
		   	
		   	aSummary[nType,4,nGroup,5,nReason,3] += (cTemp)->TB_DESC
		   
	   		//-------------------------------------------------------------------
			// Monta o resumo geral.  
			//------------------------------------------------------------------- 	
	   		nGeneral 	:= aScan( aGeneral, {|x| AllTrim(x[1]) == AllTrim( (cTemp)->TB_TIPO ) } )
			   	
		   	If ( nGeneral == 0 )   
				If ( Month( (cTemp)->TB_EMISENT ) == Month( dDatabase ) .And. Year( (cTemp)->TB_EMISENT ) == Year( dDatabase ) )
					aAdd( aGeneral, { AllTrim( (cTemp)->TB_TIPO ), (cTemp)->TB_DESC, 0 } )	
				ElseIf 	( Month( (cTemp)->TB_EMISENT ) < Month( dDatabase ) .And. Year( (cTemp)->TB_EMISENT ) == Year( dDatabase ) ) .Or.; 
						( Year( (cTemp)->TB_EMISENT ) < Year( dDatabase ) ) 
					aAdd( aGeneral, { AllTrim( (cTemp)->TB_TIPO ), 0, (cTemp)->TB_DESC } )
				EndIf 
		   	Else
				If ( Month( (cTemp)->TB_EMISENT ) == Month( dDatabase ) .And. Year( (cTemp)->TB_EMISENT ) == Year( dDatabase ) )
					aGeneral[nGeneral][2] += (cTemp)->TB_DESC
				ElseIf 	( Month( (cTemp)->TB_EMISENT ) < Month( dDatabase ) .And. Year( (cTemp)->TB_EMISENT ) == Year( dDatabase ) ) .Or.; 
						( Year( (cTemp)->TB_EMISENT ) < Year( dDatabase ) ) 
					aGeneral[nGeneral][3] += (cTemp)->TB_DESC
				EndIf  		    	
		    EndIf  	
		EndIf 

		nTotal += (cTemp)->TB_DESC
	   (cTemp)->( DBSkip() )
	EndDo

	For nType := 1 To Len(aSummary)
		aSummary[nType,3] := Round(aSummary[nType,2] / nTotal * 100,2)
		 
		For nGroup := 1 To Len(aSummary[nType,4])
			aSummary[nType,4,nGroup,4] := Round(aSummary[nType,4,nGroup,3] / aSummary[nType,2] * 100,2)
			
			For nReason := 1 To Len(aSummary[nType,4,nGroup,5])
				aSummary[nType,4,nGroup,5,nReason,4] := Round(aSummary[nType,4,nGroup,5,nReason,3] / aSummary[nType,4,nGroup,3] * 100,2)
			Next nReason
		Next nGroup
	Next nType
		
	//-------------------------------------------------------------------
	// Imprime o total geral.  
	//-------------------------------------------------------------------
	oReport:SkipLine()
	oReport:PrintText( STR0019, oReport:Row()  ) //"Total Geral"
	oReport:PrintText( Transform( nTotal,"@E 99,999,999.99" ), oReport:Row(), oSection2:Cell("TB_DESC"):ColPos() - ( oSection2:Cell("TB_DESC"):GetWidth() / 3 ) ) 
	oReport:EndPage()
	
	//-------------------------------------------------------------------
	// Remove o cabeçalho das páginas de resumo.  
	//-------------------------------------------------------------------	
	oReport:aHeaderPage := {}

	If !(nDevice == IMP_EXCEL)
		oReport:StartPage()
		
		//-------------------------------------------------------------------
		// Imprime o resumo por tipo e categoria.  
		//------------------------------------------------------------------- 
		oReport:PrintText( Space(10) + Padr( STR0020, 55 ) + STR0021 + Space(10) + STR0034 ) //"Categoria"###"Valor"###"Perc.Grupo (%)"
		oReport:ThinLine()
		oReport:SkipLine()
	
		For nType := 1 To Len(aSummary)
			//-------------------------------------------------------------------
			// Imprime o total por tipo.  
			//------------------------------------------------------------------- 	
			oReport:PrintText( 	Space(10)+;
								Padr( aSummary[nType][1] , 50) +;
								Transform( aSummary[nType][2], "@E 99,999,999.99" ) +;
								Space(10) +;
								Transform( aSummary[nType,3], "@E 999.99%" ) ) //"Subtotal"
			oReport:SkipLine()
	
			For nGroup := 1 To Len(aSummary[nType,4])
				//-------------------------------------------------------------------
				// Imprime o total por grupo.  
				//-------------------------------------------------------------------	
				If ! Empty( MV_PAR09 ) 	
					oReport:PrintText( 	Space(15) +;
										Padr( AllTrim( aSummary[nType,4,nGroup,1] ) + " - " + AllTrim( aSummary[nType,4,nGroup,2] ) , 45 ) +;
										Transform( aSummary[nType,4,nGroup,3], "@E 99,999,999.99" ) +;
										Space(10) +;
										Transform( aSummary[nType,4,nGroup,4], "@E 999.99%" ) )	    
				EndIf 
				
				//-------------------------------------------------------------------
				// Imprime o total por motivo.  
				//-------------------------------------------------------------------
				For nReason := 1 To Len(aSummary[nType,4,nGroup,5])
					If ! Empty( aSummary[nType,4,nGroup,5,nReason,1] ) 
						oReport:PrintText(	Space(20) +;
										 	Padr( AllTrim( aSummary[nType,4,nGroup,5,nReason,1] ) + " - " + AllTrim( aSummary[nType,4,nGroup,5,nReason,2] ) , 40 ) +;
										 	Transform( aSummary[nType,4,nGroup,5,nReason,3], "@E 99,999,999.99" ) +;
										 	Space(10) +;
										 	Transform( aSummary[nType,4,nGroup,5,nReason,4], "@E 999.99%" ) ) 
					EndIf    
				Next nReason

				oReport:SkipLine()
			Next nGroup
		Next nType
		
		//-------------------------------------------------------------------
		// Imprime o resumo geral.  
		//------------------------------------------------------------------- 
		oReport:SkipLine(5)
		oReport:PrintText( Space(10) + Padr( STR0024, 55 ) + STR0021 + Space(10) + STR0034 ) //"Resumo Geral"###"Valor"###"Perc.Grupo (%)"
		oReport:ThinLine()
		oReport:SkipLine()
		
		For nItem := 1 To Len( aGeneral )	
			//-------------------------------------------------------------------
			// Imprime o valor das notas do mês corrente.  
			//------------------------------------------------------------------- 
			oReport:PrintText( 	Space(10) +; 
								Padr(AllTrim(aGeneral[nItem][1])+ " - " + STR0025 + AllTrim( StrZero( Month( dDatabase), 2 ) ) + "/" + AllTrim( Str( Year( dDatabase) ) ), 50 ) +;
								Transform( aGeneral[nItem][2], "@E 99,999,999.99" ) +;
								Space(10) +;
								Transform( Round( aGeneral[nItem,2] / nTotal * 100, 2 ), "@E 999.99%" ) ) //"Notas do Mês "  
			
			//-------------------------------------------------------------------
			// Imprime o valor das notas do meses anteriores.  
			//------------------------------------------------------------------- 
			oReport:PrintText( 	Space(10) +; 
								Padr(AllTrim(aGeneral[nItem][1])+ " - " + STR0026 + AllTrim( StrZero( Month( dDatabase), 2 ) ) + "/" + AllTrim( Str( Year( dDatabase) ) ), 50 ) +;
								Transform( aGeneral[nItem][3], "@E 99,999,999.99" ) +;
								Space(10) +;
								Transform( Round( aGeneral[nItem,3] / nTotal * 100, 2 )	, "@E 999.99%" ) ) //"Notas dos Meses Anteriores à "  	    
		Next nItem

		oReport:EndPage() 
	EndIf

	If ( MV_PAR13 == 1 )   //  Gera planilha detalhada
		If (cPlanilha)->(!Eof())
			CRMXGeraExcel( 2, {cPlanilha}, {aFieldPlan}, {STR0001}, "FATR080_" )
		EndIf  
		//-------------------------------------------------------------------
		// Apaga a tabela temporária para a planilha 
		//-------------------------------------------------------------------  
		oTempPlan:Delete()
	Endif

	//-------------------------------------------------------------------
	// Apaga a tabela temporária principal 
	//-------------------------------------------------------------------  
	oTempTable:Delete()
	
	SD2->(RestArea(aAreaSD2))

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetFields
Estrutura de campoas para a tabela temporária base do relatório. 
 
@return aField Array contendo a estrutura da tabela temporária. 
 
@author  TOTVS 
@version P12
@since   11/03/2015  
/*/
//-------------------------------------------------------------------
Static Function GetFields()
	Local aField := {}
	Local nGroup 		:= If( TamSX3('BM_GRUPO')[1] > TamSX3('AOM_CODNIV')[1], TamSX3('BM_GRUPO')[1], TamSX3('AOM_CODNIV')[1] )
	Local nDescription 	:= If( TamSX3('BM_DESC')[1] > TamSX3('AOM_DESCRI')[1], TamSX3('BM_DESC')[1], TamSX3('AOM_DESCRI')[1] )

	aAdd( aField,{"TB_FILIAL"	,"C"	,TamSX3("D1_FILIAL")[1]	 ,0})
	aAdd( aField,{"TB_TIPO"        ,"C"   ,TamSX3("F1_TIPO")[1]          ,0})
	aAdd( aField,{"TB_CLIENTE"	,"C"	,TamSX3("A1_COD")[1]	 ,0})
	aAdd( aField,{"TB_NOME"		,"C"	,050					 ,0}) //fixo 50 para não desconfigurar a impressao
	aAdd( aField,{"TB_SERIEE"  	,"C"	,TamSX3("F1_SERIE")[1]	 ,0})
	aAdd( aField,{"TB_NUMENT"	,"C"	,TamSX3("F1_DOC")[1]	 ,0})
	aAdd( aField,{"TB_EMISENT"	,"D"	,10 					 ,0})
	aAdd( aField,{"TB_SERIES"	,"C"	,TamSX3("F2_SERIE")[1]	 ,0})
	aAdd( aField,{"TB_NUMSAI"	,"C"	,TamSX3("F2_DOC")[1]	 ,0})
	aAdd( aField,{"TB_EMISSAI"	,"D"	,10 					 ,0})
	aAdd( aField,{"TB_VENCTO"	,"D"	,10 					 ,0})
	aAdd( aField,{"TB_DESC"		,"N"	,TamSX3("D1_TOTAL")[1]	 ,TamSX3("D1_TOTAL")[2]})
	aAdd( aField,{"TB_TOTAL"	,"N"	,TamSX3("F2_VALBRUT")[1] ,TamSX3("F2_VALBRUT")[2]})
	aAdd( aField,{"TB_VLNFOR"	,"N"	,TamSX3("F2_VALBRUT")[1] ,TamSX3("F2_VALBRUT")[2]})
	aAdd( aField,{"TB_GRUPO"	,"C"	,nGroup 				 ,0})
	aAdd( aField,{"TB_DESCR"	,"C"	,nDescription			 ,0})
	aAdd( aField,{"TB_CODMOT"	,"C"	,TamSX3("DHI_CODIGO")[1] ,0})	
	aAdd( aField,{"TB_DESCMOT"	,"C"	,040					 ,0}) //fixo 40 para não desconfigurar a impressao
	aAdd( aField,{"TB_HISTORI"	,"C"	,022					 ,0}) //fixo 22 para não desconfigurar a impressao
Return( aField )

//-------------------------------------------------------------------
/*/{Protheus.doc} FATR080QRY
Definição da regra de negócio do relatório. 

@param cNFSDe      Documento de Saida Inicial
@param cNFSAte     Documento de Saida Final
@param dNFSDe      data inicial de emissao do Documento de Saida
@param dNFSAte     data final de emissao do Documento de Saida
@param cNFEDe      Documento de Entrada Inicial
@param cNFEAte     Documento de Saida Final
@param dNFEDe      data iniclal de emissao do Documento de Entrada
@param dNFEAte     data final de emissao do Documento de Entrada

@return cResultSet	Alias contendo a regra de negócio do relatório

@author  Valdiney V GOMES
@since   09/04/2015
/*/
//-------------------------------------------------------------------
User Function FATR080QRY(cNFSDe, cNFSAte, dNFSDe, dNFSAte, cNFEDe, cNFEAte, dNFEDe, dNFEAte)
	Local cResultSet 	:= GetNextAlias()
	Local cSeries 	 	:= SuperGetMv( "MV_FATSCAN" , .F. , "" )
	Local cSerieFilter	:= ""

	Default cNFSDe   := ""
	Default cNFSAte  := ""
	Default dNFSDe   := Stod("        ")
	Default dNFSAte  := Stod("        ")
	Default cNFEDe   := ""
	Default cNFEAte  := ""
	Default dNFEDe   := Stod("        ")
	Default dNFEAte  := Stod("        ")
	//-------------------------------------------------------------------
	// Filtra somente as sérias informada no parâmetro MV_FATSCAN.  
	//------------------------------------------------------------------- 
	If ! ( Empty( cSeries ) )
		cSerieFilter := "%AND SF1.F1_SERIE IN " + FormatIn( cSeries, "/" ) + "%"
	Else
		cSerieFilter := "%AND SF1.F1_SERIE <> ''%"
	EndIf 

	//-------------------------------------------------------------------
	// Monta o ResultSet com a regra de negócio do relatório.  
	//------------------------------------------------------------------- 
	BEGINSQL ALIAS cResultSet
		SELECT 	SD1.D1_FORNECE,
			MIN(SD1.D1_TOTAL) D1_TOTAL,
			MIN(SD1.D1_VALDESC) D1_VALDESC,
		       	SA1.A1_COD,
		       	SA1.A1_LOJA,
		       	SA1.A1_NOME,
			SA1.A1_PESSOA,
			SA1.A1_CGC,
			SA1.A1_CODSEG,
			AOV.AOV_DESSEG,
			SA1.A1_CODTER,
			AOY.AOY_NMTER,
			SA1.A1_TPMEMB,
			SA1.A1_CODMEMB,
		       	SF1.F1_SERIE,
		       	SF1.F1_DOC,
		       	SF1.F1_DTDIGIT, 
		       	SF1.F1_MOEDA,
				SF1.F1_MOTRET,
				SF1.F1_TIPO,
	    	    SF2.F2_SERIE,
	    	   	SF2.F2_DOC,
	    	   	SF2.F2_EMISSAO,
	    	   	SF2.F2_VALBRUT,
	    	   	SD2.D2_SERIE,
			SD2.D2_ITEM,
           		MIN(SE1.E1_VENCREA) E1_VENCREA, 
				SBM.BM_GRUPO,
				SBM.BM_DESC,
				SB1.B1_COD,
			SB1.B1_DESC,
			SF4.F4_CODIGO,
			SD1.R_E_C_N_O_ RECNOSD1,
			SD2.D2_CONTA,
			CT1.CT1_DESC01,
			SD2.D2_CLVL,
			SD2.D2_CCUSTO,
			SD2.D2_ITEMCC,
			MIN(REF.R_E_C_N_O_) RECNOREF,
			CTT.CTT_DESC01,
			MIN(SD2.D2_VALINS) INSS,
			MIN(SD2.D2_VALIMP6) PIS,
			MIN(SD2.D2_VALIMP5) COFINS,
			MIN(SD2.D2_VALICM) ISS
		FROM  %TABLE:SF1% SF1
			INNER JOIN %TABLE:SD1% SD1 
				ON (   SD1.D1_FILIAL= %xFILIAL:SD1%
				AND SD1.D1_FORNECE = SF1.F1_FORNECE
				AND SD1.D1_LOJA = SF1.F1_LOJA
				AND SD1.D1_DOC = SF1.F1_DOC
				AND SD1.D1_SERIE = SF1.F1_SERIE
				AND SD1.D1_TES <> %Exp:''%
				AND SD1.%NOTDEL% )
			INNER JOIN %TABLE:SA1% SA1 
				ON (   SA1.A1_FILIAL = %xFILIAL:SA1% 
	            AND SA1.A1_COD = SF1.F1_FORNECE 
	            AND SA1.A1_LOJA = SF1.F1_LOJA
	            AND SA1.%NOTDEL%) 
			INNER JOIN %TABLE:SF2% SF2 
				ON (   SF2.F2_FILIAL = %xFILIAL:SF2% 
	    	    AND SF2.F2_DOC = SD1.D1_NFORI 
	    	    AND SF2.F2_SERIE = SD1.D1_SERIORI
					AND SF2.F2_EMISSAO BETWEEN  %Exp:DToS(dNFSDe)% AND %Exp:DToS(dNFSAte)%
					AND SF2.F2_DOC BETWEEN  %Exp:cNFSDe% AND %Exp:cNFSAte%
		        AND SF2.%NOTDEL%) 
	    	LEFT JOIN %TABLE:SBM% SBM 
				ON (   SBM.BM_FILIAL = %xFILIAL:SBM% 
	            AND SBM.BM_GRUPO = SD1.D1_GRUPO 
	            AND SBM.%NOTDEL% ) 
		 	LEFT JOIN %TABLE:SD2% SD2 
				ON (   SD2.D2_FILIAL=%xFILIAL:SD2% 
		        AND SD2.D2_DOC = SF2.F2_DOC	    
		        AND SD2.D2_SERIE = SF2.F2_SERIE
		        AND SD2.D2_CLIENTE = SF2.F2_CLIENTE
		        AND SD2.D2_LOJA = SF2.F2_LOJA 	    
		        AND SD2.D2_COD = SD1.D1_COD
			  	 AND ( ( SD2.D2_ITEM = SD1.D1_ITEMORI 	AND SD1.D1_ITEMORI <> %Exp:''% ) OR SD1.D1_ITEMORI = %Exp:''% ) 		
		        AND SD2.%NOTDEL%) 
		    LEFT JOIN %TABLE:SE1% SE1
				ON (   SE1.E1_FILIAL = %xFILIAL:SE1% 
		        AND SE1.E1_PREFIXO = SF2.F2_SERIE 
		        AND SE1.E1_NUM = SF2.F2_DOC 
		        AND SE1.%NOTDEL%)  
			LEFT JOIN %TABLE:SB1% SB1 
				ON (   SB1.B1_FILIAL = %xFILIAL:SB1% 
				AND	SB1.B1_COD = SD1.D1_COD 
			    AND SB1.%NOTDEL%) 
			LEFT JOIN %TABLE:SF4% SF4 
				ON (   SF4.F4_FILIAL = %xFILIAL:SF4% 
				AND	SF4.F4_CODIGO = SD2.D2_TES
			    AND SF4.%NOTDEL%) 
			LEFT JOIN %TABLE:AOY% AOY 
				ON (   AOY.AOY_FILIAL = %xFILIAL:AOY% 
					AND	AOY.AOY_CODTER = SA1.A1_CODTER
					AND AOY.%NOTDEL%)
			LEFT JOIN %TABLE:AOV% AOV 
				ON (   AOV.AOV_FILIAL = %xFILIAL:AOV% 
					AND AOV.AOV_CODSEG = SA1.A1_CODSEG
					AND AOV.%NOTDEL% )
			LEFT JOIN %TABLE:CT1% CT1
				ON (   CT1.CT1_FILIAL = %xFILIAL:CT1% 
					AND CT1.CT1_CONTA = SD2.D2_CONTA
					AND CT1.%NOTDEL% )
			LEFT JOIN %TABLE:CTT% CTT
				ON (   CTT.CTT_FILIAL = %xFILIAL:CTT% 
					AND CTT.CTT_CUSTO = SD2.D2_CCUSTO
					AND CTT.%NOTDEL% )
			LEFT JOIN %TABLE:SD2% REF
				ON (   REF.D2_FILIAL = %xFILIAL:SD2% 
					AND REF.D2_NFORI = SD2.D2_DOC
					AND REF.D2_SERIORI = SD2.D2_SERIE
					AND REF.%NOTDEL% )
		WHERE
	     	SF1.F1_FILIAL = %xFILIAL:SF1% 
	     	
	     	%exp:cSerieFilter%
	     	
	     	AND SF1.F1_TIPO = %Exp:'D'% 
			AND SF1.F1_DOC BETWEEN %Exp:cNFEDe% AND %Exp:cNFEAte%
			AND SF1.F1_DTDIGIT BETWEEN %Exp:DToS(dNFEDe)% AND %Exp:DToS(dNFEAte)%
	     	AND SF1.%NOTDEL% 
	 	GROUP BY 
			SD1.D1_FORNECE,
		    SA1.A1_COD, 
		    SA1.A1_LOJA, 
		    SA1.A1_NOME, 
			SA1.A1_PESSOA,
			SA1.A1_CGC,
			SA1.A1_CODSEG,
			AOV.AOV_DESSEG,
			SA1.A1_CODTER,
			AOY.AOY_NMTER,
			SA1.A1_TPMEMB,
			SA1.A1_CODMEMB,
		    SF1.F1_SERIE, 
		    SF1.F1_DOC, 
		    SF1.F1_DTDIGIT, 
		    SF1.F1_MOEDA, 
			SF1.F1_MOTRET,
			SF1.F1_TIPO,
		    SF2.F2_SERIE, 
		    SF2.F2_DOC, 
		    SF2.F2_EMISSAO, 
		    SF2.F2_VALBRUT, 
		    SD2.D2_SERIE, 
			SD2.D2_ITEM,
		    SBM.BM_GRUPO, 
		    SBM.BM_DESC,
		    SB1.B1_COD,
			SB1.B1_DESC,
			SF4.F4_CODIGO,
			SD1.R_E_C_N_O_,
			SD2.D2_CONTA,
			CT1.CT1_DESC01,
			SD2.D2_CLVL,
			SD2.D2_CCUSTO,
			SD2.D2_ITEMCC,
			CTT.CTT_DESC01
		ORDER BY 
			SA1.A1_NOME,
			SF2.F2_SERIE,
			SF2.F2_EMISSAO,
			SF2.F2_DOC
	ENDSQL    
Return cResultSet

//-------------------------------------------------------------------
/*/{Protheus.doc} getKey
Retorna a chave de busca no agrupador com base no valor do resultset.  
 
@param cTable		Tabela principal do agrupador.  
@param cResultSet	Conjunto de dados do relatório. 
@return aKey		Array no formato {{CAMPO, VALOR}}.
 
@author  Valdiney V GOMES
@since   22/04/2015
/*/
//-------------------------------------------------------------------
Static Function getKey( cTable, cResultSet ) 
	Local aKey 			:= {}
	Local aField		:= {}
	Local nField		:= 0

	Default cTable		:= ""
	Default cResultSet	:= ""

	//-------------------------------------------------------------------
	// Monta a chave considerando o primeiro índice da tabela.  
	//-------------------------------------------------------------------
	If ( SIX->( dbSeek( cTable + "1" ) ) )
		aField := aBIToken( SIX->CHAVE, "+", .F. )
		
		For nField := 1 To Len( aField )
			If ! ( "_FILIAL" $ aField[nField] )
				aAdd( aKey, { AllTrim( aField[nField] ), (cResultSet)->&( aField[nField] ) } )
			EndIf 
		Next nField 
	EndIf
Return aKey

//-------------------------------------------------------------------
/*/{Protheus.doc} FATR080E
Consulta específica para agrupadores. 

@author  Valdiney V GOMES
@since   23/04/2015
/*/
//-------------------------------------------------------------------
User Function FATR080E()
	Local lFound 	:= .F. 

	//-------------------------------------------------------------------
	// Exibe a tela de seleção de agrupador e níveis.  
	//-------------------------------------------------------------------
	aCRMA580E := CRMA580E(,,.T.,.T.,,.T.,{"SA1", "SB1", "SBM", "SF4"})
	
	//-------------------------------------------------------------------
	// Retorna o código do agrupador selecionado.  
	//-------------------------------------------------------------------
	If !( Len( aCRMA580E ) == 0 )
		lFound := AOL->( DBSeek( xFilial("AOL") + aCRMA580E[1][1] ) )
	EndIf
Return lFound

//-------------------------------------------------------------------
/*/{Protheus.doc} GetFieldExcel
Estrutura de campos para a tabela temporária base do relatório. 
 
@return aField         Array contendo a estrutura da tabela temporária. 
 
@author  TOTVS 
@version P12
@since   11/03/2015  
/*/
//-------------------------------------------------------------------
Static Function GetFieldExcel()
	Local aField            := {}
	Local nGroup            := If( TamSX3('BM_GRUPO')[1] > TamSX3('AOM_CODNIV')[1], TamSX3('BM_GRUPO')[1], TamSX3('AOM_CODNIV')[1] )
	Local nDescription      := If( TamSX3('BM_DESC')[1] > TamSX3('AOM_DESCRI')[1], TamSX3('BM_DESC')[1], TamSX3('AOM_DESCRI')[1] )
	Local nTamCodMem        := Max(TamSX3('ADK_COD')[1],Max(TamSX3('AO3_CODUSR')[1],TamSX3('ACA_GRPREP')[1]))
	Local nTamNomMem        := Max(TamSX3('ADK_NOME')[1],Max(25,TamSX3('ACA_DESCRI')[1]))
	
	If !Empty(FwCompany())
		aAdd( aField,{"TB_EMPRES"      ,"C"   ,60                            ,0                       , STR0069})               //  Empresa
	Endif
	If !Empty(FwUnitBusiness())
		aAdd( aField,{"TB_UNIDAD"      ,"C"   ,60                            ,0                       , STR0070})               //  Unidade
	Endif
	aAdd( aField,{"TB_FILIAL"      ,"C"   ,TamSX3("D1_FILIAL")[1]        ,0                       , STR0004})               //  Filial
	aAdd( aField,{"TB_NOMFIL"      ,"C"   ,41                            ,0                       , STR0071})               //  Nome Filial
	aAdd( aField,{"TB_AGRUP"       ,"C"   ,TamSX3("AOM_CODNIV")[1]	      ,0                       , STR0028})               //  Agrupador"
	aAdd( aField,{"TB_AGRDES"      ,"C"   ,TamSX3("AOM_DESCRI")[1]	      ,0                       , STR0035})               //  Nivel Agrupador"
	aAdd( aField,{"TB_CLIENTE"     ,"C"   ,TamSX3("A1_COD")[1]           ,0                       , STR0036})               //  Cliente
	aAdd( aField,{"TB_NOME"        ,"C"   ,TamSX3("A1_NOME")[1]          ,0                       , STR0006})               //  Nome
	aAdd( aField,{"TB_PESSOA"      ,"C"   ,TamSX3("A1_PESSOA")[1]        ,0                       , STR0037})               //  Pessoa
	aAdd( aField,{"TB_CNPJRAI"     ,"C"   ,9                             ,0                       , STR0067})               //  Raiz CPF CNPJ
	aAdd( aField,{"TB_CNPJFIL"     ,"C"   ,4                             ,0                       , STR0068})               //  Fil. CNPJ
	aAdd( aField,{"TB_CODSEG"      ,"C"   ,TamSX3("AOV_CODSEG")[1]       ,0                       , STR0038})               //  Cod.Segmento
	aAdd( aField,{"TB_DESSEG"      ,"C"   ,TamSX3("AOV_DESSEG")[1]       ,0                       , STR0039})               //  Descrição Segmento
	aAdd( aField,{"TB_SERIEE"      ,"C"   ,TamSX3("F1_SERIE")[1]         ,0                       , STR0040})               //  Serie NFE
	aAdd( aField,{"TB_NUMENT"      ,"C"   ,TamSX3("F1_DOC")[1]           ,0                       , STR0008})               //  Nr NFE
	aAdd( aField,{"TB_EMISENT"     ,"D"   ,10                            ,0                       , STR0042})               //  Emissao NFE
	aAdd( aField,{"TB_SERIREF"     ,"C"   ,TamSX3("D2_SERIE")[1]         ,0                       , STR0062})               //  Ser.Ref.
	aAdd( aField,{"TB_REFATUR"     ,"C"   ,TamSX3("D2_DOC")[1]           ,0                       , STR0061})               //  Refaturado
	aAdd( aField,{"TB_SERIES"      ,"C"   ,TamSX3("F2_SERIE")[1]         ,0                       , STR0041})               //  Serie NFS
	aAdd( aField,{"TB_NUMSAI"      ,"C"   ,TamSX3("F2_DOC")[1]           ,0                       , STR0010})               //  Nr NFS
	aAdd( aField,{"TB_EMISSAI"     ,"D"   ,10                            ,0                       , STR0043})               //  Emissao NFS
	aAdd( aField,{"TB_ITEMORI"     ,"C"   ,TamSX3("D2_ITEM")[1]          ,0                       , STR0053})               //  Item Orig.
	aAdd( aField,{"TB_VENCTO"      ,"D"   ,10                            ,0                       , STR0011})               //  Vencimento
	aAdd( aField,{"TB_GRUPO"       ,"C"   ,nGroup                        ,0                       , STR0044})               //  Grupo Prd
	aAdd( aField,{"TB_GRPDES"      ,"C"   ,nDescription                  ,0                       , STR0045})               //  Descr.Grupo
	aAdd( aField,{"TB_DESC"        ,"N"   ,TamSX3("D1_TOTAL")[1]         ,TamSX3("D1_TOTAL")[2]   , STR0012})               //  Vl.Desc/Canc.
	aAdd( aField,{"TB_TOTAL"       ,"N"   ,TamSX3("F2_VALBRUT")[1]       ,TamSX3("F2_VALBRUT")[2] , STR0046})               //  Saldo
	aAdd( aField,{"TB_VLNFOR"      ,"N"   ,TamSX3("F2_VALBRUT")[1]       ,TamSX3("F2_VALBRUT")[2] , STR0013})               //  Vl. NF Or.
	aAdd( aField,{"TB_INSS"        ,"N"   ,TamSX3("D2_VALINS")[1]        ,TamSX3("D2_VALINS")[2]  , STR0063})               //  INSS
	aAdd( aField,{"TB_PIS"         ,"N"   ,TamSX3("D2_VALIMP6")[1]       ,TamSX3("D2_VALIMP6")[2] , STR0064})               //  PIS
	aAdd( aField,{"TB_COFINS"      ,"N"   ,TamSX3("D2_VALIMP5")[1]       ,TamSX3("D2_VALIMP5")[2] , STR0065})               //  COFINS
	aAdd( aField,{"TB_ISS"         ,"N"   ,TamSX3("D2_VALICM")[1]        ,TamSX3("D2_VALICM")[2]  , STR0066})               //  ISS
	aAdd( aField,{"TB_TIPO"        ,"C"   ,TamSX3("F1_TIPO")[1]          ,0                       , STR0047})               //  Tipo
	aAdd( aField,{"TB_CTACTB"      ,"C"   ,TamSX3("D2_CONTA")[1]         ,0                       , STR0054})               //  Conta Contabil
	aAdd( aField,{"TB_DESCTA"      ,"C"   ,TamSX3("CT1_DESC01")[1]       ,0                       , STR0060})               //  Descr. Conta
	aAdd( aField,{"TB_PRODUTO"     ,"C"   ,TamSX3("B1_COD")[1]           ,0                       , STR0055})               //  Produto
	aAdd( aField,{"TB_DESPRD"      ,"C"   ,TamSX3("B1_DESC")[1]          ,0                       , STR0056})               //  Descr. Produto
	aAdd( aField,{"TB_CLASVL"      ,"C"   ,TamSX3("D2_CLVL")[1]          ,0                       , STR0057})               //  Classe de Valor
	aAdd( aField,{"TB_CCUSTO"      ,"C"   ,TamSX3("D2_CCUSTO")[1]        ,0                       , STR0058})               //  Centro de Custo
	aAdd( aField,{"TB_DCCUST"      ,"C"   ,TamSX3("CTT_DESC01")[1]       ,0                       , STR0075})               //  Descr. C. Custo
	aAdd( aField,{"TB_ITEMCC"      ,"C"   ,TamSX3("D2_ITEMCC")[1]        ,0                       , STR0059})               //  Item Contabil
	aAdd( aField,{"TB_CODTER"      ,"C"   ,TamSX3("AOY_CODTER")[1]       ,0                       , STR0048})               //  Territorio
	aAdd( aField,{"TB_NOMTER"      ,"C"   ,TamSX3("AOY_NMTER")[1]        ,0                       , STR0049})               //  Nome Territorio
	aAdd( aField,{"TB_TIPMEMB"     ,"C"   ,20                            ,0                       , STR0050})               //  Tipo Membro
	aAdd( aField,{"TB_CODMEMB"     ,"C"   ,nTamCodMem                    ,0                       , STR0051})               //  Cod.Membro
	aAdd( aField,{"TB_NOMMEMB"     ,"C"   ,nTamNomMem                    ,0                       , STR0052})               //  Nome Membro
	aAdd( aField,{"TB_CODMOT"      ,"C"   ,TamSX3("DHI_CODIGO")[1]       ,0                       , STR0031})               //  Motivo
	aAdd( aField,{"TB_DESCMOT"     ,"C"   ,TamSX3("DHI_DESCRI")[1]       ,0                       , STR0032})               //  Descricao do Motivo
	aAdd( aField,{"TB_HISTORI"     ,"C"   ,255                           ,0                       , STR0033})               //  Historico do Retorno

Return( aField )




//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuário utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serão verificados.
    @param aFields, Array, Array com todos os Campos que serão verificados, utilizado 
        apenas se parametro aAlias estiver vazio.
    @param cSource, Caractere, Nome do recurso para gerenciar os dados protegidos.
    
    @return cSource, Caractere, Retorna nome do recurso que foi adicionado na pilha.
    @example FATPDLoad("ADMIN", {"SA1","SU5"}, {"A1_CGC"})
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDLoad(cUser, aAlias, aFields, cSource)
	Local cPDSource := ""

	If FATPDActive()
		cPDSource := FTPDLoad(cUser, aAlias, aFields, cSource)
	EndIf

Return cPDSource


//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUnload
    @description
    Finaliza o gerenciamento dos campos com proteção de dados.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cSource, Caractere, Remove da pilha apenas o recurso que foi carregado.
    @return return, Nulo
    @example FATPDUnload("XXXA010") 
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDUnload(cSource)    

    If FATPDActive()
		FTPDUnload(cSource)    
    EndIf

Return Nil

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDIsObfuscate
    @description
    Verifica se um campo deve ser ofuscado, esta função deve utilizada somente após 
    a inicialização das variaveis atravez da função FATPDLoad.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cField, Caractere, Campo que sera validado
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado
    @return lObfuscate, Lógico, Retorna se o campo será ofuscado.
    @example FATPDIsObfuscate("A1_CGC",Nil,.T.)
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDIsObfuscate(cField, cSource, lLoad)
    
	Local lObfuscate := .F.

    If FATPDActive()
		lObfuscate := FTPDIsObfuscate(cField, cSource, lLoad)
    EndIf 

Return lObfuscate

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   



//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  
