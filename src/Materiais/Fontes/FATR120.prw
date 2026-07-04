/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "SHELL.CH"
#INCLUDE "FATR120.CH"

Static oMapKey	:= THashMap():New()

//-------------------------------------------------------------------
/*/{Protheus.doc} FATR120
Relatório de Faturamento Real por Agrupador.

@author  TOTVS 
@version P12
@since   23/03/2015  
/*/
//-------------------------------------------------------------------
User Function FATR120()
	Local oReport   := Nil
	Local aPDFields	:= {}
	If cPaisLoc == "BRA"
		If FindFunction("CRMXGeraExcel")
			Pergunte( "FATR120", .F. )
			aPDFields := {"A1_NOME"}
			FATPDLoad(Nil,Nil,aPDFields)	 
			oReport := ReportDef() 
			oReport:PrintDialog() 
			FATPDUnload()
		Else
			HELP(" ",1,"CRMXGeraExcel", ,STR0038,1,0) //"Necessário CRMXFUNGEN.PRW com data superior o 24/05/2017"
		EndIf
	Else
		HELP(" ",1,"BrazilOnly", ,STR0037,1,0) //"Relatório exclusivo para localização Brasil"
	EndIf
	
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef  
Criacao dos componentes de impressao.

@author  TOTVS 
@version P12
@since   23/03/2015                                                             
/*/
//-------------------------------------------------------------------
Static Function ReportDef()
	Local oReport			:= Nil
	Local oSection1 		:= Nil
	Local oSection2 		:= Nil
	Local oTotGer   		:= Nil
	Local oTotMant  		:= Nil
	Local oTotDesc  		:= Nil
	Local oTotDAnt			:= Nil
	Local cDescription 	 	:= STR0001 //"Faturamento real"
	
	//-------------------------------------------------------------------
	// Define as sessões do relatório. 
	//------------------------------------------------------------------- 	
	DEFINE REPORT oReport NAME "FATR120"  TITLE cDescription PARAMETER "FATR120" ACTION {|oReport| PrintReport(oReport )} DESCRIPTION cDescription       
		//-------------------------------------------------------------------
		// Faturamento real. 
		//------------------------------------------------------------------- 		
		DEFINE SECTION oSection1 OF oReport TITLE STR0001 //"Faturamento real"
			DEFINE Cell NAME "TB_DESC" 		OF oSection1 TITLE STR0003 SIZE 05  ALIGN LEFT //"Dia"

		//-------------------------------------------------------------------
		// Totalizadores. 
		//------------------------------------------------------------------- 	
		DEFINE SECTION oSection2 OF oReport TITLE STR0002 //Totalizadores 
			DEFINE Cell NAME "TB2_TIPO"   	OF oSection2 TITLE STR0004 SIZE 01 	ALIGN LEFT //"Tipo"
			DEFINE Cell NAME "TB2_DESC"   	OF oSection2 TITLE STR0003 SIZE 05 	ALIGN LEFT //"Dia"
			DEFINE Cell NAME "TB2_TOTG"		OF oSection2 TITLE STR0005 PICTURE 	PesqPict("SD2","D2_TOTAL")   SIZE TamSx3("D2_TOTAL")[1] //"Total"
			DEFINE Cell NAME "TB2_TOTGA"	OF oSection2 TITLE STR0006 PICTURE 	PesqPict("SD2","D2_TOTAL")   SIZE TamSx3("D2_TOTAL")[1] //"Total M-1"
			DEFINE Cell NAME "TB2_TOTGP"	OF oSection2 TITLE "%" 		       	PICTURE "@E 99,999,999.99"  		 SIZE 15
			DEFINE Cell NAME "TB2_TOTD"		OF oSection2 TITLE STR0007 PICTURE 	PesqPict("SD2","D2_TOTAL")   SIZE TamSx3("D2_TOTAL")[1]	//"Desconto"				 
			DEFINE Cell NAME "TB2_TOTDA"	OF oSection2 TITLE STR0008 PICTURE 	PesqPict("SD2","D2_TOTAL")   SIZE TamSx3("D2_TOTAL")[1] //"Desconto M-1"
			DEFINE Cell NAME "TB2_TOTDP"	OF oSection2 TITLE "%"		       	PICTURE "@E 99,999,999.99"  		 SIZE 15 
			DEFINE Cell NAME "TB2_INSS"		OF oSection2 TITLE "INSS"      		PICTURE PesqPict("SD2","D2_VALCPB")  SIZE TamSx3("D2_VALCPB")[1]  
			DEFINE Cell NAME "TB2_ISS"		OF oSection2 TITLE "ISS"      		PICTURE PesqPict("SD2","D2_VALISS")  SIZE TamSx3("D2_VALISS")[1]
			DEFINE Cell NAME "TB2_PIS"		OF oSection2 TITLE "PIS"      		PICTURE PesqPict("SD2","D2_VALPIS")  SIZE TamSx3("D2_VALPIS")[1] 
			DEFINE Cell NAME "TB2_COFINS"	OF oSection2 TITLE "COFINS"      	PICTURE PesqPict("SD2","D2_VALCOF")  SIZE TamSx3("D2_VALCOF")[1]

			//-------------------------------------------------------------------
			// Remove o tipo do relatório. 
			//------------------------------------------------------------------- 
			oSection2:Cell("TB2_TIPO"):Disable()
			
			//-------------------------------------------------------------------
			// Totalizadores. 
			//------------------------------------------------------------------- 
			DEFINE BREAK oBreak OF oSection2 WHEN oSection2:Cell("TB2_TIPO")                           
			DEFINE FUNCTION oTotGer  FROM oSection2:Cell("TB2_TOTG") FUNCTION SUM BREAK oBreak NO END REPORT NO END SECTION  
			DEFINE FUNCTION oTotMant FROM oSection2:Cell("TB2_TOTGA") FUNCTION SUM BREAK oBreak NO END REPORT NO END SECTION
			DEFINE FUNCTION oTotDesc FROM oSection2:Cell("TB2_TOTD") FUNCTION SUM BREAK oBreak NO END REPORT NO END SECTION
			DEFINE FUNCTION oTotDAnt FROM oSection2:Cell("TB2_TOTDA") FUNCTION SUM BREAK oBreak NO END REPORT NO END SECTION
			DEFINE FUNCTION FROM oSection2:Cell("TB2_TOTDA") FUNCTION SUM BREAK oBreak NO END REPORT NO END SECTION
			DEFINE FUNCTION FROM oSection2:Cell("TB2_INSS") FUNCTION SUM BREAK oBreak NO END REPORT NO END SECTION  
			DEFINE FUNCTION FROM oSection2:Cell("TB2_ISS") FUNCTION SUM BREAK oBreak NO END REPORT NO END SECTION
			DEFINE FUNCTION FROM oSection2:Cell("TB2_PIS") FUNCTION SUM BREAK oBreak NO END REPORT NO END SECTION
			DEFINE FUNCTION FROM oSection2:Cell("TB2_COFINS") FUNCTION SUM BREAK oBreak NO END REPORT NO END SECTION		
			DEFINE FUNCTION FROM oSection2:Cell("TB2_TOTDP") FUNCTION ONPRINT FORMULA {|| getVariation( oTotDesc:GetLastValue(), oTotDAnt:GetLastValue() ) } BREAK oBreak NO END REPORT NO END SECTION		
			DEFINE FUNCTION FROM oSection2:Cell("TB2_TOTGP") FUNCTION ONPRINT FORMULA {|| getVariation( oTotGer:GetLastValue(), oTotMant:GetLastValue() ) } BREAK oBreak NO END REPORT NO END SECTION		
			DEFINE FUNCTION FROM oSection2:Cell("TB2_TOTG") FUNCTION ONPRINT FORMULA {||oTotDesc:GetLastValue()} BREAK oBreak NO END REPORT NO END SECTION		
			DEFINE FUNCTION FROM oSection2:Cell("TB2_TOTG") FUNCTION ONPRINT FORMULA {||oTotGer:GetLastValue()- oTotDesc:GetLastValue()} BREAK oBreak NO END REPORT NO END SECTION
	
	//-------------------------------------------------------------------
	// Força a exibição do relatório no formato paisagem. 
	//-------------------------------------------------------------------  		
	oReport:SetLandscape()		
	
	//-------------------------------------------------------------------
	// Desabilita a personalização do relatório. 
	//-------------------------------------------------------------------  
	oReport:SetEdit(.F.)
	
	//-------------------------------------------------------------------
	// Apresenta a tela de impressão. 
	//-------------------------------------------------------------------  
Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} PrintReport   
Relatorio de Faturamento Real por agrupador

@param oReport 	Objeto do TReport

	MV_PAR01     // Mes/Ano do Faturamento                              
	MV_PAR02     // Agrupador 
	MV_PAR03     // Considerar Valores - Faturado/Líquido 	
	MV_PAR04     // Gera Planilha
	MV_PAR05     // Todas as Empresas?                             
	MV_PAR06     // Todas as Unidades de Negocios?                               
	MV_PAR07     // Todas as Filiais? 
	
@author  TOTVS 
@since   11/03/2015                                                          
/*/
//-------------------------------------------------------------------
Static Function PrintReport( oReport )
	Local oSection1 	:= oReport:Section(1)
	Local oSection2 	:= oReport:Section(2)
	Local oTmpDetail  	:= NIL
	Local oTmpTotal    	:= NIL
	Local oTmpExcel    	:= NIL
	Local aFieldTotal	:= GetFieldTotal()
	Local aFieldExcel 	:= GetFieldExcel()
	Local aFieldDetail	:= {}
	Local aAreaSM0		:= SM0->( GetArea() )
	Local aPool			:= {}
	Local aAccess		:= FWLoadSM0() 
	Local cResultSet 	:= getNextAlias()
	Local cDetail 		:= GetNextAlias()
	Local cTotal		:= GetNextAlias()	
	Local cExcel		:= GetNextAlias() 	
	Local cFilOri 		:= cFilAnt
	Local cCompany		:= FWCompany() 
	Local cUnitBusiness	:= FWUnitBusiness()
	Local cBranch		:= FWFilial()
	Local cOldCompany	:= ""
	Local cOldUnit		:= ""
	Local cOldBranch	:= ""
	Local cLastCompany	:= ""
	Local cLastUnit		:= ""
	Local cLastBranch	:= ""
	Local cSerie 		:= SuperGetMv( "MV_FATSCAN", .T., "CAN/DES/DEV" )
	Local cTES 			:= SuperGetMv( "MV_FATTESX", .T., "" )
	Local cSerieFilter	:= ""
	Local cTESFilter	:= ""
	Local cDBType		:= TCGetDB()
	Local cSQLValues	:= ""
	Local cSQLExec		:= ""
	Local cSQLInsert	:= ""
	Local cEmissao		:= ""
	Local cOrigem		:= ""
	Local cGrupo		:= ""
	Local cCliFor		:= ""
	Local cNome			:= ""
	Local cDoc			:= ""
	Local cDDigit		:= ""
	Local cSerieTB3		:= ""
	Local cItem			:= ""
	Local cProduto		:= ""
	Local cProdDesc		:= ""
	Local cGrpPrd		:= ""
	Local cDescGrp		:= ""
	Local cCC			:= ""
	Local cItemCC		:= ""
	Local cClvl			:= ""
	Local cConta		:= ""
	Local cPais			:= ""
	Local cNCliObf		:= ""
	Local dDate			:=  CToD( "01/" + MV_PAR01 )
	Local dDateFrom		:= dDate
	Local dDateTo		:= LastDay( dDate )
	Local nMonth		:= Month( dDate )
	Local nField		:= 0
	Local nDay    		:= 0  
	Local nType			:= 0 
	Local nDiscount 	:= 0
	Local nTotal 		:= 0
	Local nValue 		:= 0
	Local nINSS 		:= 0
	Local nPIS 			:= 0
	Local nCOF 			:= 0
	Local nISS 			:= 0
	Local nCount 		:= 0 
	Local nRet 			:= 0	 
	Local nRecord 		:= 0 
	Local nTarget 		:= IIF(cDBType == "ORACLE", 20, 1)   //Quantos Inserts são realizados em cada loop
	Local lUnit			:= .F. 
	Local lCompany		:= .F. 
	
	//-------------------------------------------------------------------
	// Define qual agrupador será utilizado. 
	//-------------------------------------------------------------------
	aPool 			:= CRMA580E( { MV_PAR02 } )
	aFieldDetail 	:= GetFieldDetail( aPool )	

	//-------------------------------------------------------------------
	// Cria a Tabela Temporária de grupos para o relatório. 
	//------------------------------------------------------------------- 
	oTmpDetail := FWTemporaryTable():New(cDetail,aFieldDetail)
	oTmpDetail:AddIndex("A", {"TB_GRUPO","TB_EMP","TB_UN","TB_FILIAL","TB_DIA","TB_TIPO"} )
	oTmpDetail:Create()
	
	//-------------------------------------------------------------------
	// Cria a Tabela Temporária de totalizador para o relatório. 
	//------------------------------------------------------------------- 	
	oTmpTotal := FWTemporaryTable():New(cTotal,aFieldTotal)
	oTmpTotal:AddIndex("B", {"TB2_GRUPO","TB2_EMP","TB2_UN","TB2_FILIAL","TB2_DIA","TB2_TIPO"} )
	oTmpTotal:Create()

	//-------------------------------------------------------------------
	// Cria a Tabela Temporária para a planilha analítica. 
	//------------------------------------------------------------------- 	
	oTmpExcel := FWTemporaryTable():New(cExcel,aFieldExcel)
	oTmpExcel:AddIndex("C", {"TB3_FILIAL","TB3_ORIGEM","TB3_EMISSA","TB3_CLIENT","TB3_DOC","TB3_SERIE"} )
	oTmpExcel:Create()

	//-------------------------------------------------------------------
	// Insere os grupos como colunas no relatório. 
	//------------------------------------------------------------------- 
	For nField := 1 To Len( aFieldDetail )   	
		If ( aFieldDetail[nField][5] )
			DEFINE Cell NAME aFieldDetail[nField][1] OF oSection1 TITLE aFieldDetail[nField][6] PICTURE PesqPict("SD2","D2_TOTAL") SIZE TamSX3("D2_TOTAL")[1]
		EndIf 			
	Next nField
	
	DEFINE Cell NAME "TB_TOTAL"		OF oSection1 TITLE STR0005 PICTURE PesqPict("SD2","D2_TOTAL") SIZE TamSX3("D2_TOTAL")[1] //"Total"
	DEFINE Cell NAME "TB_ACUM"		OF oSection1 TITLE STR0009 PICTURE PesqPict("SD2","D2_TOTAL") SIZE TamSX3("D2_TOTAL")[1] //"Acumulado" 

    //-------------------------------------------------------------------
	// Localiza o grupo de empresas corrente. 
	//-------------------------------------------------------------------
	If ( SM0->( MSSeek( cEmpAnt ) ) ) .And. (Empty(aPool) .Or. (!Empty(aPool) .And. aPool[1][3] $ "SA1|SB1|SBM|SF4"))
		
		//-------------------------------------------------------------------
		// Percorre todas as empresas, unidades de negócio e filiais.
		//-------------------------------------------------------------------
		While SM0->( ! Eof() ) .And. SM0->M0_CODIGO == cEmpAnt			
			cOldCompany		:= FWCompany()
			cOldUnit		:= FWUnitBusiness()
			cOldBranch		:= cFilAnt
			cFilAnt			:= SM0->M0_CODFIL
			lUnit			:= .F. 
			lCompany		:= .F. 

			//-------------------------------------------------------------------
			// Verifica se o usuário tem acesso a filial. 
			//------------------------------------------------------------------- 
			If ! ( aScan( aAccess, {|x| x[1] == cEmpAnt .And. x[2] == cFilAnt } ) == 0 )
				//-------------------------------------------------------------------
				// Define se imprime todas as empresas. 
				//------------------------------------------------------------------- 
				If ( MV_PAR05 == 1 ) 
					cCompany := FWCompany()
					MV_PAR06 := 1 
					MV_PAR07 := 1
				Endif
		
				//-------------------------------------------------------------------
				// Define se imprime todas as unidades de negócio. 
				//------------------------------------------------------------------- 
				If ( MV_PAR06 == 1 ) 
					cUnitBusiness 	:= FWUnitBusiness()
					MV_PAR07 		:= 1	
				Endif
				
				//-------------------------------------------------------------------
				// Define se imprime todas as filiais. 
				//------------------------------------------------------------------ 
				If	( MV_PAR07 == 1 ) 
					cBranch := FWFilial()    
				Endif
	
				If 	( SM0->M0_CODIGO == cEmpAnt .And. ( cCompany + cUnitBusiness + cBranch ) $ SM0->M0_CODFIL )
					cLastCompany	:= FWCompany()
					cLastUnit		:= FWUnitBusiness()
					cLastBranch		:= cFilAnt
					nDiscount 		:= 0
					nTotal 			:= 0									
					cKey 			:= cEmpAnt  
					cKey			+= Padr( FWCompany(), 12 ) 
					cKey			+= Padr( FWUnitBusiness(), 12 ) 
					cKey			+= Padr( FWFilial(), 12 )

					//-------------------------------------------------------------------
					// Totalizar por unidade de negócio. 
					//-------------------------------------------------------------------	
					If ( MV_PAR06 == 1 )
						If ! Empty( FWUnitBusiness() ) .And. ! ( cOldUnit == FWUnitBusiness() )			
							PrintTotal( oReport, aFieldDetail, aFieldTotal, cDetail, cTotal, cOldCompany, cOldUnit, cOldBranch )
							lUnit := .T. 
						EndIf	
					EndIf	
					
					//-------------------------------------------------------------------
					// Totalizar por empresa. 
					//-------------------------------------------------------------------		
					If ( MV_PAR05 == 1 ) 
						If ! Empty( FWCompany() ) .And. ! ( cOldCompany == FWCompany() )			
							PrintTotal( oReport, aFieldDetail, aFieldTotal, cDetail, cTotal, cOldCompany,,cOldBranch )
							lCompany := .T. 
						EndIf 
					EndIf

					//-------------------------------------------------------------------
					// Define o título do relatório. 
					//-------------------------------------------------------------------	
					cTitle := STR0001 //"Faturamento Real"
				
					If ! Empty( FWCompany() )
						cTitle += " - "  + AllTrim( FWCompanyName() )
					EndIf 
					
					If ! Empty( FWUnitBusiness() )
						cTitle += " - "  + AllTrim( FWUnitName() )  
					EndIf 				
					
					cTitle += " - "  + FWFilialName()
					oReport:SetTitle( cTitle ) 

					//-------------------------------------------------------------------
					// Filtra somente as TES fora do parâmetro MV_FATTESX.  
					//------------------------------------------------------------------- 
					If ! ( Empty( cTES ) )
						cTESFilter := "%AND SD2.D2_TES NOT IN " + FormatIn( cTES, "/" ) + "%"
					Else
						cTESFilter := "%AND SD2.D2_TES <> ''%"
					EndIf 

					//-------------------------------------------------------------------
					// Documento de Saída. 
					//-------------------------------------------------------------------
					BEGINSQL ALIAS cResultSet
						SELECT  	
							SD2.D2_TOTAL TOTAL , 
							SD2.D2_VALCPB INSS, 
							SD2.D2_VALIMP6 PIS, 
							SD2.D2_VALIMP5 COF, 
							SD2.D2_VALISS ISS,
							SD2.D2_EMISSAO,
							SD2.D2_DOC,
							SD2.D2_SERIE,
							SD2.D2_ITEM,
							SD2.D2_QUANT,
							SD2.D2_CCUSTO, 
							SD2.D2_ITEMCC, 
							SD2.D2_CONTA,  
							SD2.D2_CLIENTE, 
							SD2.D2_COD, 
							SD2.D2_CLVL,
							SF2.F2_MOEDA,
							SF2.F2_EMISSAO,
							SB1.B1_COD,
							SB1.B1_DESC,
							SB1.B1_GRUPO,
							SBM.BM_GRUPO, 
							SBM.BM_DESC, 
							SA1.A1_COD,
							SA1.A1_LOJA,
							SA1.A1_NOME,
							SA1.A1_PAIS,
							SF4.F4_CODIGO					
						FROM  %Table:SD2% SD2
							INNER JOIN %Table:SF2% SF2 
								ON (SF2.F2_FILIAL = %xFilial:SF2% 
								AND SF2.F2_DOC = SD2.D2_DOC 
								AND SF2.F2_SERIE = SD2.D2_SERIE
								AND SF2.F2_CLIENTE = SD2.D2_CLIENTE 
								AND SF2.F2_LOJA = SD2.D2_LOJA
								AND SF2.%NOTDEL%) 
							INNER JOIN %Table:SA1% SA1 
								ON (SA1.A1_FILIAL = %xFilial:SA1% 
								AND SA1.A1_COD = SD2.D2_CLIENTE 
								AND SA1.A1_LOJA = SD2.D2_LOJA
								AND SA1.%NOTDEL%) 
							INNER JOIN %Table:SB1% SB1 
								ON (SB1.B1_FILIAL = %xFilial:SB1% 
								AND SB1.B1_COD = SD2.D2_COD 
								AND SB1.%NOTDEL%) 
							INNER JOIN %Table:SF4% SF4 
								ON (SF4.F4_FILIAL= %xFilial:SF4%
								AND SF4.F4_CODIGO = D2_TES 
								AND SF4.F4_DUPLIC <> %exp:'N'%
								AND SF4.%NotDel%)
							LEFT JOIN %Table:SBM% SBM 
								ON (SBM.BM_FILIAL = %xFilial:SBM% 
								AND SBM.BM_GRUPO = SD2.D2_GRUPO 
								AND SBM.%NotDel% ) 
						WHERE
							SD2.D2_FILIAL = %xFilial:SD2% 
							%exp:cTESFilter%
							AND SD2.D2_EMISSAO BETWEEN %Exp:DToS(dDateFrom)% AND %Exp:DToS(dDateTo)%
							AND SD2.%NOTDEL% 
						ORDER BY 
							SD2.D2_EMISSAO
					ENDSQL    
					
					//-------------------------------------------------------------------
					// Identifica a quantidade de registro no alias temporário.    
					//-------------------------------------------------------------------
					COUNT TO nRecord

					//-------------------------------------------------------------------
					// Posiciona no primeiro registro.  
					//-------------------------------------------------------------------	
					(cResultSet)->( DBGoTop() )
					
					If cDBType $ "MSSQL|ORACLE" 
					
						cSQLInsert := " INTO " + oTmpExcel:GetRealName()
						cSQLInsert += " (	TB3_FILIAL	,TB3_EMISSA,TB3_ORIGEM,TB3_AGRUP, "
						cSQLInsert += " TB3_DESC	,TB3_CLIENT,TB3_NOME,TB3_DOC, "	   
						cSQLInsert += " TB3_DIGIT,TB3_SERIE,TB3_ITEM,TB3_COD, "
						cSQLInsert += " TB3_PROD	,TB3_QUANT,TB3_TOTAL,TB3_GRUPO, "
						cSQLInsert += " TB3_GRDES,TB3_CC,TB3_ITEMCC,TB3_CLVL, "
						cSQLInsert += " TB3_CONTA,TB3_PAIS,TB3_INSS,TB3_PIS, "
						cSQLInsert += " TB3_COFINS,TB3_ISS )
						cSQLInsert += " VALUES "
													
					EndIf
					
					
					//-------------------------------------------------------------------
					// Monta a estrutura da tabela temporária. 
					//-------------------------------------------------------------------  
					For nDay := 1 To 31
						//-------------------------------------------------------------------
						// Vendas. 
						//-------------------------------------------------------------------  
						Reclock(cDetail,.T.)
							(cDetail)->TB_GRUPO		:= cEmpAnt
							(cDetail)->TB_EMP		:= FWCompany()
							(cDetail)->TB_UN		:= FWUnitBusiness()
							(cDetail)->TB_FILIAL	:= FWFilial()
							(cDetail)->TB_TIPO 		:= "1"
							(cDetail)->TB_DIA  		:= StrZero(nDay,3)
							(cDetail)->TB_DESC  	:= StrZero(nDay,2) 	
						MsUnlock(cDetail)
			
						//-------------------------------------------------------------------
						// Descontos. 
						//------------------------------------------------------------------- 
						Reclock(cDetail,.T.)    		
							(cDetail)->TB_GRUPO		:= cEmpAnt
							(cDetail)->TB_EMP		:= FWCompany()
							(cDetail)->TB_UN		:= FWUnitBusiness()
							(cDetail)->TB_FILIAL	:= FWFilial()
							(cDetail)->TB_TIPO 		:= "2"
							(cDetail)->TB_DIA  		:= StrZero(nDay,3)		
							(cDetail)->TB_DESC  	:= "DES"  
						MsUnlock(cDetail)
		
						//-------------------------------------------------------------------
						// Totalizadores. 
						//------------------------------------------------------------------- 
						Reclock(cTotal,.T.)    		
							(cTotal)->TB2_GRUPO		:= cEmpAnt
							(cTotal)->TB2_EMP		:= FWCompany()
							(cTotal)->TB2_UN		:= FWUnitBusiness()
							(cTotal)->TB2_FILIAL	:= FWFilial()
							(cTotal)->TB2_TIPO 		:= "X"
							(cTotal)->TB2_DIA  		:= StrZero(nDay,3)		
							(cTotal)->TB2_DESC  	:= StrZero(nDay,2)
						MsUnlock(cTotal)
					Next nDay	

					//-------------------------------------------------------------------
					// Total Acumulado por linha. 
					//------------------------------------------------------------------- 
					Reclock(cDetail,.T.)
						(cDetail)->TB_GRUPO		:= cEmpAnt
						(cDetail)->TB_EMP		:= FWCompany()
						(cDetail)->TB_UN		:= FWUnitBusiness()
						(cDetail)->TB_FILIAL	:= FWFilial()
						(cDetail)->TB_TIPO 		:= "A"
						(cDetail)->TB_DIA  		:= "032"
						(cDetail)->TB_DESC  	:= ""   	 		
					MsUnlock(cDetail)
				
					//-------------------------------------------------------------------
					// Total Desconto por linha. 
					//------------------------------------------------------------------- 
					Reclock(cDetail,.T.)
						(cDetail)->TB_GRUPO		:= cEmpAnt
						(cDetail)->TB_EMP		:= FWCompany()
						(cDetail)->TB_UN		:= FWUnitBusiness()
						(cDetail)->TB_FILIAL	:= FWFilial()
						(cDetail)->TB_TIPO 		:= "D"
						(cDetail)->TB_DIA  		:= "033"
						(cDetail)->TB_DESC  	:= ""   	 		
					MsUnlock(cDetail)
			
					//-------------------------------------------------------------------
					// Total Geral por linha. 
					//------------------------------------------------------------------- 
					Reclock(cDetail,.T.)
						(cDetail)->TB_GRUPO		:= cEmpAnt
						(cDetail)->TB_EMP		:= FWCompany()
						(cDetail)->TB_UN		:= FWUnitBusiness()
						(cDetail)->TB_FILIAL	:= FWFilial()
						(cDetail)->TB_TIPO 		:= "T"
						(cDetail)->TB_DIA  		:= "034"
						(cDetail)->TB_DESC  	:= ""   	 		
					MsUnlock(cDetail)
											
					//-------------------------------------------------------------------
					// Grava as informações do Documento de Saída. 
					//-------------------------------------------------------------------  
					While ! (cResultSet)->( Eof() )
						
						nRecord -= 1
						
						//-------------------------------------------------------------------
						// Identifica o grupo.  
						//-------------------------------------------------------------------
						If ! ( Len( aPool ) == 0 )
							aGroup := CRMA580Group( aPool, getKey( aPool[1][3], cResultSet ), .T., .F., oMapKey )
						Else
							aGroup := { "", CRMA580Root(), "", STR0010 } //INDEFINIDO
						EndIf

						//-------------------------------------------------------------------
						// Converte os valores para a moeda oficial.  
						//------------------------------------------------------------------- 
						nValue 	:= xMoeda( (cResultSet)->TOTAL	, (cResultSet)->F2_MOEDA, 1, (cResultSet)->F2_EMISSAO )
						nINSS 	:= xMoeda( (cResultSet)->INSS 	, (cResultSet)->F2_MOEDA, 1, (cResultSet)->F2_EMISSAO )
						nPIS 	:= xMoeda( (cResultSet)->PIS 	, (cResultSet)->F2_MOEDA, 1, (cResultSet)->F2_EMISSAO )
						nCOF 	:= xMoeda( (cResultSet)->COF  	, (cResultSet)->F2_MOEDA, 1, (cResultSet)->F2_EMISSAO )
						nISS 	:= xMoeda( (cResultSet)->ISS  	, (cResultSet)->F2_MOEDA, 1, (cResultSet)->F2_EMISSAO )
						
						//-------------------------------------------------------------------
						// Calcula o total líquido.  
						//------------------------------------------------------------------- 
						If ( MV_PAR03 == 2 )
							nValue := nValue - ( nPIS + nCOF + nISS )
						EndIf 
						//-------------------------------------------------------------------
						// Identifica se o lancamento é do mês corrente.  
						//------------------------------------------------------------------- 
						If ( Month( SToD( (cResultSet)->D2_EMISSAO ) ) = Month( dDateTo ) .And.;
							Year( SToD( (cResultSet)->D2_EMISSAO ) ) = Year( dDateTo ) )

							Reclock(cDetail,.F.)

								//-------------------------------------------------------------------
								// Vendas por agrupador por dia. 
								//-------------------------------------------------------------------  
								If ( (cDetail)->( MSSeek( cKey + StrZero( Day( SToD( (cResultSet)->D2_EMISSAO ) ), 3 ) + "1" ) ) )
									(cDetail)->&( "TB_" + aGroup[2] ) += nValue	
									(cDetail)->TB_TOTAL += nValue
								Endif	
		
								//-------------------------------------------------------------------
								// Acumulado por agrupador por linha. 
								//-------------------------------------------------------------------  
								If ( (cDetail)->( MSSeek( cKey +  "032" + "A" ) ) )
									(cDetail)->&( "TB_" + aGroup[2] ) += nValue	
								Endif
				
								//-------------------------------------------------------------------
								// Total por agrupador por linha. 
								//------------------------------------------------------------------- 
								If ( (cDetail)->( MSSeek (cKey +  "034" + "T" ) ) )
									(cDetail)->&( "TB_" + aGroup[2] ) += nValue
								Endif
	
							MsUnlock(cDetail)

							//-------------------------------------------------------------------
							// Total mês atual e impostos por dia. 
							//------------------------------------------------------------------- 
							If ( (cTotal)->( MSSeek( cKey + StrZero( Day( SToD( (cResultSet)->D2_EMISSAO ) ), 3 ) + "X" ) ) )
								Reclock(cTotal,.F.)
									(cTotal)->TB2_TOTG		+= nValue
									(cTotal)->TB2_INSS		+= nINSS
									(cTotal)->TB2_ISS		+= nISS
									(cTotal)->TB2_PIS		+= nPIS
									(cTotal)->TB2_COFINS	+= nCOF 					  										 					
								MsUnlock(cTotal)
							Endif	
						Else
							If ( (cTotal)->( MSSeek( cKey + StrZero( Day( SToD( (cResultSet)->D2_EMISSAO ) ), 3 ) + "X" ) ) )
								Reclock(cTotal,.F.)
									(cTotal)->TB2_TOTGA += nValue
								MsUnlock(cTotal)
							Endif	
						Endif

						//-------------------------------------------------------------------
						// Relatório analítico. 
						//------------------------------------------------------------------- 
						If ( MV_PAR04 == 1 ) .And. ( nMonth == Month( SToD( (cResultSet)->D2_EMISSAO ) ) )
							
							If !Empty( cSQLInsert )
							
								nCount ++
								
								If nCount <= nTarget

									cEmissao	:= IIf(Empty(AllTrim((cResultSet)->D2_EMISSAO))					, " ", AllTrim((cResultSet)->D2_EMISSAO))
									cOrigem		:= IIF(Empty(AllTrim(aGroup[2]))								, " ", AllTrim(aGroup[2]))
									cGrupo		:= IIF(Empty(AllTrim(aGroup[4]))								, " ", AllTrim(aGroup[4]))
									cCliFor		:= IIF(Empty(AllTrim((cResultSet)->D2_CLIENTE))					, " ", AllTrim((cResultSet)->D2_CLIENTE))
									cNome		:= IIF(Empty(AllTrim(StrTran((cResultSet)->A1_NOME,"'","")))	, " ", AllTrim(StrTran((cResultSet)->A1_NOME,"'","")))
									cDoc		:= IIF(Empty(AllTrim((cResultSet)->D2_DOC))						, " ", AllTrim((cResultSet)->D2_DOC))		
									cSerieTB3	:= IIF(Empty(AllTrim((cResultSet)->D2_SERIE))					, " ", AllTrim((cResultSet)->D2_SERIE))
									cItem		:= IIF(Empty(AllTrim((cResultSet)->D2_ITEM))					, " ", AllTrim((cResultSet)->D2_ITEM))
									cProduto	:= IIF(Empty(AllTrim((cResultSet)->D2_COD))						, " ", AllTrim((cResultSet)->D2_COD))
									cProdDesc	:= IIF(Empty(AllTrim(StrTran((cResultSet)->B1_DESC,"'"," ")))	, " ", AllTrim(StrTran((cResultSet)->B1_DESC,"'"," ")))
									cGrpPrd		:= IIF(Empty(AllTrim((cResultSet)->BM_GRUPO))					, " ", AllTrim((cResultSet)->BM_GRUPO))
									cDescGrp	:= IIF(Empty(AllTrim(StrTran((cResultSet)->BM_DESC,"'"," " )))	, " ", AllTrim(StrTran((cResultSet)->BM_DESC,"'"," " )))
									cItemCC		:= IIF(Empty(AllTrim((cResultSet)->D2_ITEMCC))					, " ", AllTrim((cResultSet)->D2_ITEMCC))
									cClvl		:= IIF(Empty(AllTrim((cResultSet)->D2_CLVL))					, " ", AllTrim((cResultSet)->D2_CLVL))
									cCC			:= IIF(Empty(AllTrim((cResultSet)->D2_CCUSTO))					, " ", AllTrim((cResultSet)->D2_CCUSTO))
									cConta		:= IIF(Empty(AllTrim((cResultSet)->D2_CONTA))					, " ", AllTrim((cResultSet)->D2_CONTA))
									cPais		:= IIF(Empty(AllTrim((cResultSet)->A1_PAIS))					, " ", AllTrim((cResultSet)->A1_PAIS))

									If Empty(cNCliObf) .And. FATPDIsObfuscate("A1_NOME") 
										cNCliObf := FATPDObfuscate(cNome)
									EndIf

									If !Empty(cNCliObf)
										cNome := cNCliObf 
									EndIf

									cSQLValues	+= cSQLInsert
									
									cSQLValues	+= "(	'"   + cFilAnt  				+ "','" + cEmissao 									+	"',"
									cSQLValues	+= "'1-" + STR0033						+ "','" + cOrigem  									+	"',"
									cSQLValues	+= "'"   + cGrupo						+ "','" + cCliFor									+	"',"
									cSQLValues	+= "'"   + cNome 						+ "','" + cDoc										+	"'," 
									cSQLValues	+= "'"   + cEmissao						+ "','" + cSerieTB3									+	"'," 
									cSQLValues	+= "'"   + cItem						+ "','" + cProduto									+	"'," 
									cSQLValues	+= "'"   + cProdDesc					+ "',"  + AllTrim(Str((cResultSet)->D2_QUANT ))		+	"," 
									cSQLValues	+= AllTrim( Str( (cResultSet)->TOTAL ))	+ ",'" 	+ cGrpPrd									+	"'," 
									cSQLValues	+= "'"   + cDescGrp						+ "','" + cCC										+	"'," 
									cSQLValues	+= "'"   + cItemCC						+ "','" + cClvl										+	"'," 
									cSQLValues	+= "'"   + cConta						+ "','" + cPais 									+	"'," 
									cSQLValues	+= AllTrim(Str( (cResultSet)->INSS ))	+ ","	+ AllTrim(Str( (cResultSet)->PIS ))			+	"," 
									cSQLValues	+= AllTrim(Str( (cResultSet)->COF ))	+ ","	+ AllTrim(Str( (cResultSet)->ISS ))			+	" ) " 	
								
									If ( cDBType == "MSSQL" .And. ( nCount < nTarget .And. nRecord > nTarget ) )
										cSQLValues	+= ", " 
									EndIf
									
								EndIf
							
								If nCount == nTarget .Or. nRecord < nTarget  
									
									If cDBType == "ORACLE" 
										cSQLExec := "INSERT ALL "
										cSQLExec += cSQLValues
										cSQLExec += " SELECT 1 FROM DUAL "
									ElseIf cDBType == "MSSQL"
										cSQLExec := "INSERT "
										cSQLExec += cSQLValues	
									EndIf
							
									nRet := TCSQLExec( cSQLExec )
						
									If nRet < 0
										MsgStop( TCSqlError() ) 
									EndIf
									
									cSQLValues	:= ""
									nCount		:= 0
									
								EndIf
							
							Else 

								cNome := (cResultSet)->A1_NOME
								If Empty(cNCliObf) .And. FATPDIsObfuscate("A1_NOME") 
									cNCliObf := FATPDObfuscate(cNome)
								EndIf

								If !Empty(cNCliObf)
									cNome := cNCliObf  
								EndIf

								Reclock(cExcel,.T.)
									(cExcel)->TB3_FILIAL	:= cFilAnt
									(cExcel)->TB3_EMISSA	:= SToD( (cResultSet)->D2_EMISSAO )
									(cExcel)->TB3_ORIGEM	:= "1-" + STR0033 //"SAIDA"
									(cExcel)->TB3_AGRUP		:= aGroup[2]
									(cExcel)->TB3_DESC 		:= aGroup[4]
									(cExcel)->TB3_CLIENT	:= (cResultSet)->D2_CLIENTE 
									(cExcel)->TB3_NOME  	:= cNome
									(cExcel)->TB3_DOC   	:= (cResultSet)->D2_DOC 
									(cExcel)->TB3_DIGIT 	:= SToD( (cResultSet)->D2_EMISSAO ) 
									(cExcel)->TB3_SERIE 	:= (cResultSet)->D2_SERIE
									(cExcel)->TB3_ITEM  	:= (cResultSet)->D2_ITEM
									(cExcel)->TB3_COD   	:= (cResultSet)->D2_COD
									(cExcel)->TB3_PROD  	:= (cResultSet)->B1_DESC
									(cExcel)->TB3_QUANT 	:= (cResultSet)->D2_QUANT
									(cExcel)->TB3_TOTAL 	:= (cResultSet)->TOTAL
									(cExcel)->TB3_GRUPO 	:= (cResultSet)->BM_GRUPO
									(cExcel)->TB3_GRDES 	:= (cResultSet)->BM_DESC
									(cExcel)->TB3_CC   		:= (cResultSet)->D2_CCUSTO
									(cExcel)->TB3_ITEMCC	:= (cResultSet)->D2_ITEMCC
									(cExcel)->TB3_CLVL		:= (cResultSet)->D2_CLVL
									(cExcel)->TB3_CONTA 	:= (cResultSet)->D2_CONTA
									(cExcel)->TB3_PAIS  	:= (cResultSet)->A1_PAIS
									(cExcel)->TB3_INSS  	:= (cResultSet)->INSS
									(cExcel)->TB3_PIS   	:= (cResultSet)->PIS
									(cExcel)->TB3_COFINS	:= (cResultSet)->COF
									(cExcel)->TB3_ISS   	:= (cResultSet)->ISS
								MsUnlock(cExcel)
							
							EndIf
						
						EndIf 
								
						(cResultSet)->( DBSkip() )
						
					Enddo
					
					//Limpa o cache dados protegidos. 
					cNCliObf := ""
					(cResultSet)->( DBCloseArea() )  
					
	
					//-------------------------------------------------------------------
					// Filtra somente as sérias informada no parâmetro MV_FATSCAN.  
					//------------------------------------------------------------------- 
					If ! ( Empty( cSerie ) )
						cSerieFilter := "%AND SF1.F1_SERIE IN " + FormatIn( cSerie, "/" ) + "%"
					Else
						cSerieFilter := "%AND SF1.F1_SERIE <> ''%"
					EndIf 

					//-------------------------------------------------------------------
					// Documento de Entrada. 
					//------------------------------------------------------------------- 
					BEGINSQL ALIAS cResultSet
						SELECT 	
							SF1.F1_DTDIGIT,
							SF1.F1_MOEDA,
							SF1.F1_EMISSAO,
							SD1.D1_VALCPB INSS, 
							SD1.D1_VALIMP6 PIS, 
							SD1.D1_VALIMP5 COF, 
							SD1.D1_VALISS ISS,
							SD1.D1_TOTAL  TOTAL,
							SD1.D1_VALDESC DESCONTO, 
							SD1.D1_EMISSAO,
							SD1.D1_FORNECE,
							SD1.D1_DOC,
							SD1.D1_DTDIGIT,
							SD1.D1_SERIE,
							SD1.D1_ITEM,
							SD1.D1_COD,
							SD1.D1_QUANT,
							SD1.D1_CC,
							SD1.D1_ITEMCTA,
							SD1.D1_CONTA,
							SD1.D1_CLVL,
							SB1.B1_COD,
							SB1.B1_DESC,
							SB1.B1_GRUPO,
							SBM.BM_GRUPO, 
							SBM.BM_DESC, 
							SA1.A1_COD,
							SA1.A1_LOJA,
							SA1.A1_NOME,
							SA1.A1_PAIS,
							SF4.F4_CODIGO
						FROM  %Table:SF1% SF1
						INNER JOIN %Table:SD1% SD1 
							ON (SD1.D1_FILIAL = %xFilial:SD1% 
							AND SF1.F1_DOC = SD1.D1_DOC 
							AND SF1.F1_SERIE = SD1.D1_SERIE
							AND SF1.F1_FORNECE = SD1.D1_FORNECE 
							AND SF1.F1_LOJA = SD1.D1_LOJA
							AND SD1.%NotDel%) 
						INNER JOIN %TABLE:SA1% SA1 
							ON (
							SA1.A1_FILIAL = %xFILIAL:SA1% 
							AND SA1.A1_COD = SF1.F1_FORNECE 
							AND SA1.A1_LOJA = SF1.F1_LOJA
							AND SA1.%NOTDEL%)  	
						LEFT JOIN %TABLE:SD2% SD2
							ON (
							SD2.D2_FILIAL = %xFILIAL:SD2%  
							AND	SD2.D2_DOC = SD1.D1_NFORI
							AND SD2.D2_SERIE = SD1.D1_SERIORI 
							AND SD2.D2_CLIENTE = SD1.D1_FORNECE
							AND SD2.D2_LOJA = SD1.D1_LOJA
							AND SD2.D2_COD = SD1.D1_COD
							AND 
							(
								SD2.D2_ITEM = %exp:""%
								OR 
								SD2.D2_ITEM = SD1.D1_ITEMORI
							)				        	
							AND SD2.%NOTDEL% ) 				            			         
						LEFT JOIN %Table:SBM% SBM 
							ON (SBM.BM_FILIAL = %xFilial:SBM% 
							And SBM.BM_GRUPO = SD1.D1_GRUPO 
							And SBM.%NotDel% ) 	
						LEFT JOIN %TABLE:SB1% SB1 
							ON ( 
							SB1.B1_FILIAL = %xFILIAL:SB1% 
							AND	SB1.B1_COD = SD1.D1_COD 
							AND SB1.%NOTDEL%) 
						LEFT JOIN %TABLE:SF4% SF4 
							ON ( 
							SF4.F4_FILIAL = %xFILIAL:SF4% 
							AND	SF4.F4_CODIGO = SD1.D1_TES
							AND SF4.%NOTDEL%) 
						WHERE
							SF1.F1_FILIAL = %xFilial:SF1% 
							%exp:cSerieFilter%
							AND SF1.F1_DTDIGIT BETWEEN %Exp:DToS(dDateFrom)% AND %Exp:DToS(dDateTo)%
							AND SF1.F1_TIPO = %exp:"D"%
							AND SF1.F1_STATUS != %exp:" "%
							AND SF1.%NotDel%
						ORDER BY 
							SD1.D1_EMISSAO	
					ENDSQL    

					cSQLValues	:= " " 
					
					//-------------------------------------------------------------------
					// Identifica a quantidade de registro no alias temporário.    
					//-------------------------------------------------------------------
					COUNT TO nRecord

					//-------------------------------------------------------------------
					// Posiciona no primeiro registro.  
					//-------------------------------------------------------------------	
					(cResultSet)->( DBGoTop() )
					
					//-------------------------------------------------------------------
					// Grava as informações do Documento de Entrada. 
					//-------------------------------------------------------------------  
					While ! (cResultSet)->( Eof() )
						
						nRecord -= 1
						
						//-------------------------------------------------------------------
						// Identifica o grupo.  
						//------------------------------------------------------------------- 
						If ! ( Len( aPool ) == 0 )
							aGroup := CRMA580Group( aPool, getKey( aPool[1][3], cResultSet ), .T., .F., oMapKey )
						Else
							aGroup := { "", CRMA580Root(), "", STR0010 } //INDEFINIDO 
						EndIf
	
						//-------------------------------------------------------------------
						// Calcula o total faturado.   
						//------------------------------------------------------------------- 
						nValue	:= (cResultSet)->TOTAL - (cResultSet)->DESCONTO
						
						//-------------------------------------------------------------------
						// Converte os valores para a moeda oficial.  
						//------------------------------------------------------------------- 
						nValue 	:= xMoeda(  nValue				, (cResultSet)->F1_MOEDA, 1, (cResultSet)->F1_EMISSAO )
						nINSS 	:= xMoeda( (cResultSet)->INSS	, (cResultSet)->F1_MOEDA, 1, (cResultSet)->F1_EMISSAO )
						nPIS 	:= xMoeda( (cResultSet)->PIS	, (cResultSet)->F1_MOEDA, 1, (cResultSet)->F1_EMISSAO )
						nCOF 	:= xMoeda( (cResultSet)->COF	, (cResultSet)->F1_MOEDA, 1, (cResultSet)->F1_EMISSAO )
						nISS 	:= xMoeda( (cResultSet)->ISS	, (cResultSet)->F1_MOEDA, 1, (cResultSet)->F1_EMISSAO )
						
						//-------------------------------------------------------------------
						// Calcula o total líquido.  
						//------------------------------------------------------------------- 
						If ( MV_PAR03 == 2 )
							nValue := nValue - ( nPIS + nCOF + nISS )
						EndIf 
						
						//-------------------------------------------------------------------
						// Identifica se o lancamento é do mês corrente.  
						//------------------------------------------------------------------- 
						If ( Month( SToD( (cResultSet)->F1_DTDIGIT ) ) = Month( dDateTo ) .And.;
							Year( SToD( (cResultSet)->F1_DTDIGIT ) ) = Year( dDateTo ) )	

							Reclock(cDetail,.F.)

								//-------------------------------------------------------------------
								// Descontos por agrupador por dia. 
								//------------------------------------------------------------------- 
								If	(cDetail)->(MSSeek( cKey + StrZero( Day( SToD( (cResultSet)->F1_DTDIGIT ) ),3) + "2"))
									(cDetail)->&( "TB_" + aGroup[2] ) += nValue
											
									//-------------------------------------------------------------------
									// Desconto total. 
									//------------------------------------------------------------------- 		
									(cDetail)->TB_TOTAL += nValue
								Endif
									
								//-------------------------------------------------------------------
								// Descontos acumulado por agrupador por linha. 
								//------------------------------------------------------------------- 
								If	(cDetail)->( MSSeek( cKey + "033" + "D"))
									(cDetail)->&( "TB_" + aGroup[2] ) += nValue
								Endif
				
								//-------------------------------------------------------------------
								// Descontos por agrupador por linha
								//------------------------------------------------------------------- 
								If	(cDetail)->( MSSeek( cKey +  "034" + "T"))
									(cDetail)->&( "TB_" + aGroup[2] ) -= nValue
								Endif

							MsUnlock(cDetail)

							//-------------------------------------------------------------------
							// Descontos total
							//------------------------------------------------------------------- 
							If ( (cTotal)->( MSSeek( cKey + StrZero( Day( SToD( (cResultSet)->F1_DTDIGIT ) ), 3 ) + "X" ) ) )
								Reclock(cTotal,.F.)
									(cTotal)->TB2_TOTD 		+= nValue
									(cTotal)->TB2_INSS		+= nINSS
									(cTotal)->TB2_ISS		+= nISS
									(cTotal)->TB2_PIS		+= nPIS
									(cTotal)->TB2_COFINS	+= nCOF 
								MsUnlock(cTotal)
							Endif		
						Else
							If (cTotal)->(MSSeek( cKey + StrZero( Day( SToD( (cResultSet)->F1_DTDIGIT ) ), 3) + "X"))
								Reclock(cTotal,.F.)
									(cTotal)->TB2_TOTDA += nValue
								MsUnlock(cTotal)
							Endif	
						Endif
						
						//-------------------------------------------------------------------
						// Relatório analítico de documento de entrada. 
						//------------------------------------------------------------------- 
						If ( MV_PAR04 == 1 ) .And. ( nMonth == Month( SToD( (cResultSet)->F1_EMISSAO ) ) ) 
							
							If !Empty( cSQLInsert )
							
								nCount ++
											
								If nCount <= nTarget 

									cEmissao	:= IIf(Empty(AllTrim((cResultSet)->D1_EMISSAO))					, " ", AllTrim((cResultSet)->D1_EMISSAO))
									cOrigem		:= IIF(Empty(AllTrim(aGroup[2]))								, " ", AllTrim(aGroup[2]))
									cGrupo		:= IIF(Empty(AllTrim(aGroup[4]))								, " ", AllTrim(aGroup[4]))
									cCliFor		:= IIF(Empty(AllTrim((cResultSet)->D1_FORNECE))					, " ", AllTrim((cResultSet)->D1_FORNECE))
									cNome		:= IIF(Empty(AllTrim(StrTran((cResultSet)->A1_NOME,"'","")))	, " ", AllTrim(StrTran((cResultSet)->A1_NOME,"'","")))
									cDoc		:= IIF(Empty(AllTrim((cResultSet)->D1_DOC))						, " ", AllTrim((cResultSet)->D1_DOC))		
									cDDigit		:= IIF(Empty(AllTrim((cResultSet)->D1_DTDIGIT))					, " ", AllTrim((cResultSet)->D1_DTDIGIT))		
									cSerieTB3	:= IIF(Empty(AllTrim((cResultSet)->D1_SERIE))					, " ", AllTrim((cResultSet)->D1_SERIE))
									cItem		:= IIF(Empty(AllTrim((cResultSet)->D1_ITEM))					, " ", AllTrim((cResultSet)->D1_ITEM))
									cProduto	:= IIF(Empty(AllTrim((cResultSet)->D1_COD))						, " ", AllTrim((cResultSet)->D1_COD))
									cProdDesc	:= IIF(Empty(AllTrim(StrTran((cResultSet)->B1_DESC,"'"," ")))	, " ", AllTrim(StrTran((cResultSet)->B1_DESC,"'"," ")))
									cGrpPrd		:= IIF(Empty(AllTrim((cResultSet)->BM_GRUPO))					, " ", AllTrim((cResultSet)->BM_GRUPO))
									cDescGrp	:= IIF(Empty(AllTrim(StrTran((cResultSet)->BM_DESC,"'"," " )))	, " ", AllTrim(StrTran((cResultSet)->BM_DESC,"'"," " )))
									cCC			:= IIF(Empty(AllTrim((cResultSet)->D1_CC))						, " ", AllTrim((cResultSet)->D1_CC))
									cItemCC		:= IIF(Empty(AllTrim((cResultSet)->D1_ITEMCTA))					, " ", AllTrim((cResultSet)->D1_ITEMCTA))
									cClvl		:= IIF(Empty(AllTrim((cResultSet)->D1_CLVL))					, " ", AllTrim((cResultSet)->D1_CLVL))
									cConta		:= IIF(Empty(AllTrim((cResultSet)->D1_CONTA))					, " ", AllTrim((cResultSet)->D1_CONTA))
									cPais		:= IIF(Empty(AllTrim((cResultSet)->A1_PAIS))					, " ", AllTrim((cResultSet)->A1_PAIS))

									cSQLValues	+= cSQLInsert

									If Empty(cNCliObf) .And. FATPDIsObfuscate("A1_NOME") 
										cNCliObf := FATPDObfuscate(cNome)
									EndIf

									If !Empty(cNCliObf)
										cNome := cNCliObf  
									EndIf
																		
									cSQLValues += "('" 	+ cFilAnt  												+ "','" + cEmissao 									+	"',"
									cSQLValues += "'2-" + STR0034												+ "','" + cOrigem				  					+	"',"
									cSQLValues += "'"   + cGrupo												+ "','" + cCliFor									+	"',"
									cSQLValues += "'"   + cNome													+ "','" + cDoc										+	"'," 
									cSQLValues += "'"   + cDDigit												+ "','" + cSerieTB3									+	"'," 
									cSQLValues += "'"   + cItem													+ "','" + cProduto									+	"'," 
									cSQLValues += "'"   + cProdDesc												+ "',"	+ AllTrim(Str( (cResultSet)->D1_QUANT )) 	+	"," 
									cSQLValues += AllTrim(Str((cResultSet)->TOTAL - (cResultSet)->DESCONTO))	+ ",'"  + cGrpPrd 									+	"'," 
									cSQLValues += "'"   + cDescGrp												+ "','" + cCC										+	"'," 
									cSQLValues += "'"   + cItemCC												+ "','" + cClvl										+	"'," 
									cSQLValues += "'"   + cConta												+ "','" + cPais 									+	"'," 
									cSQLValues += AllTrim(Str( -(cResultSet)->INSS ))							+ ","	+ AllTrim(Str( -(cResultSet)->PIS ))		+	"," 
									cSQLValues += AllTrim(Str( -(cResultSet)->COF ))							+ ","	+ AllTrim(Str( -(cResultSet)->ISS ))		+	" ) " 	
								
									If ( cDBType == "MSSQL" .And. ( nCount < nTarget .And. nRecord > nTarget ) )
										cSQLValues	+= ", " 
									EndIf
									
								EndIf
								
								If nCount == nTarget .Or. nRecord < nTarget  
									
									If cDBType == "ORACLE" 
										cSQLExec := "INSERT ALL "
										cSQLExec += cSQLValues
										cSQLExec += " SELECT 1 FROM DUAL "
									ElseIf cDBType == "MSSQL"
										cSQLExec := "INSERT "
										cSQLExec += cSQLValues	
									EndIf
									
									nRet := TCSQLExec( cSQLExec )
									
									If nRet < 0
										MsgStop( TCSqlError() ) 
									EndIf
									
									cSQLValues	:= ""
									nCount		:= 0
									
								EndIf
							
							Else

								cNome := (cResultSet)->A1_NOME
								If Empty(cNCliObf) .And. FATPDIsObfuscate("A1_NOME") 
									cNCliObf := FATPDObfuscate(cNome) 
								EndIf

								If !Empty(cNCliObf)
									cNome := cNCliObf  
								EndIf
								
								Reclock(cExcel,.T.)
									(cExcel)->TB3_FILIAL	:= cFilAnt
									(cExcel)->TB3_EMISSA	:= SToD( (cResultSet)->D1_EMISSAO )
									(cExcel)->TB3_ORIGEM	:= "2-" + STR0034 //"ENTRADA"
									(cExcel)->TB3_AGRUP		:= aGroup[2]
									(cExcel)->TB3_DESC 		:= aGroup[4]
									(cExcel)->TB3_CLIENT	:= (cResultSet)->D1_FORNECE 
									(cExcel)->TB3_NOME  	:= cNome
									(cExcel)->TB3_DOC   	:= (cResultSet)->D1_DOC 
									(cExcel)->TB3_DIGIT 	:= SToD( (cResultSet)->D1_DTDIGIT ) 
									(cExcel)->TB3_SERIE 	:= (cResultSet)->D1_SERIE
									(cExcel)->TB3_ITEM  	:= (cResultSet)->D1_ITEM
									(cExcel)->TB3_COD   	:= (cResultSet)->D1_COD
									(cExcel)->TB3_PROD  	:= (cResultSet)->B1_DESC
									(cExcel)->TB3_QUANT 	:= (cResultSet)->D1_QUANT
									(cExcel)->TB3_TOTAL 	:= (cResultSet)->TOTAL - (cResultSet)->DESCONTO
									(cExcel)->TB3_GRUPO 	:= (cResultSet)->BM_GRUPO
									(cExcel)->TB3_GRDES 	:= (cResultSet)->BM_DESC
									(cExcel)->TB3_CC   		:= (cResultSet)->D1_CC
									(cExcel)->TB3_ITEMCC	:= (cResultSet)->D1_ITEMCTA
									(cExcel)->TB3_CLVL		:= (cResultSet)->D1_CLVL
									(cExcel)->TB3_CONTA 	:= (cResultSet)->D1_CONTA
									(cExcel)->TB3_PAIS  	:= (cResultSet)->A1_PAIS
									(cExcel)->TB3_INSS  	-= (cResultSet)->INSS
									(cExcel)->TB3_PIS   	-= (cResultSet)->PIS 
									(cExcel)->TB3_COFINS	-= (cResultSet)->COF
									(cExcel)->TB3_ISS   	-= (cResultSet)->ISS
								MsUnlock(cExcel)
							
							EndIf
							
						EndIf 						
						
						(cResultSet)->(dbSkip())
						
					Enddo

					(cResultSet)->( DbCloseArea() )
					
					//-------------------------------------------------------------------
					// Grava os totais e acumulado
					//------------------------------------------------------------------- 
					For nDay:= 1 To 31
						For	nType := 1 To 2
							//-------------------------------------------------------------------
							// Total e Acumulado por tipo por dia.
							//------------------------------------------------------------------- 
							If ( (cDetail)->(MSSeek( cKey + StrZero(nDay,3) + AllTrim( Str( nType ) ) ) ) )
								Reclock(cDetail,.F.)
									If ( (cDetail)->TB_DESC == "DES" )
										(cDetail)->TB_ACUM := (cDetail)->TB_TOTAL + nDiscount
										nDiscount += (cDetail)->TB_TOTAL
									Else
										(cDetail)->TB_ACUM := (cDetail)->TB_TOTAL + nTotal
										nTotal += (cDetail)->TB_TOTAL
									Endif
								MsUnlock(cDetail)
							Endif
						Next nType	
				
						//-------------------------------------------------------------------
						// Percentual de vendes e desconto por dia.
						//-------------------------------------------------------------------	
						If 	(cTotal)->( MSSeek( cKey + StrZero(nDay,3) + "X" ) )
							Reclock(cTotal,.F.)				
								If( (cTotal)->TB2_TOTG > 0 .Or. (cTotal)->TB2_TOTGA > 0 ) 	
									(cTotal)->TB2_TOTGP :=  getVariation( (cTotal)->TB2_TOTG, (cTotal)->TB2_TOTGA )
								Endif
								
								If ( (cTotal)->TB2_TOTD > 0 .Or. (cTotal)->TB2_TOTDA > 0 )	
									(cTotal)->TB2_TOTDP :=  getVariation( (cTotal)->TB2_TOTD, (cTotal)->TB2_TOTDA )  
								Endif	  					
							MsUnlock(cTotal)
						Endif	
					Next nDay	

					//-------------------------------------------------------------------
					// Acumulado de vendas.
					//------------------------------------------------------------------- 
					IF	(cDetail)->( MSSeek( cKey + "032" + "A"))
						Reclock(cDetail,.F.)
							(cDetail)->TB_ACUM 	+= nTotal
							(cDetail)->TB_TOTAL += nTotal
						MsUnlock(cDetail)
					Endif
				
					//-------------------------------------------------------------------
					// Acumulado de descontos.
					//-------------------------------------------------------------------
					IF	(cDetail)->( MSSeek( cKey + "033" + "D"))
						Reclock(cDetail,.F.)
							(cDetail)->TB_ACUM 	+= nDiscount
							(cDetail)->TB_TOTAL += nDiscount
						MsUnlock(cDetail)
					Endif
				
					//-------------------------------------------------------------------
					// Acumulado total.
					//-------------------------------------------------------------------
					IF	(cDetail)->( MSSeek( cKey + "034" + "T"))
						Reclock(cDetail,.F.)
							(cDetail)->TB_ACUM 	+= nTotal - nDiscount
							(cDetail)->TB_TOTAL += nTotal - nDiscount
						MsUnlock(cDetail)
					Endif	
		
					//-------------------------------------------------------------------
					// Define o conjunto de dados para a sessão de Faturamento Real.  
					//-------------------------------------------------------------------
					cFilter := "TB_GRUPO 			= '" + cEmpAnt + "'"
					cFilter += " .And. TB_EMP 		= '" + Padr( FWCompany(), 12 ) + "'"
					cFilter += " .And. TB_UN 		= '" + Padr( FWUnitBusiness(), 12 ) + "'"
					cFilter += " .And. TB_FILIAL 	= '" + Padr( FWFilial(), 12 ) + "'"
					
					oSection1:aTable := {cDetail}
					oSection1:cAlias := cDetail
					oSection1:SetFilter( cFilter)
					
					//-------------------------------------------------------------------
					// Define o conjunto de dados para a sessão de Totalizadores.  
					//-------------------------------------------------------------------				
					cFilter := "TB2_GRUPO 			= '" + cEmpAnt + "'"
					cFilter += " .And. TB2_EMP 		= '" + Padr( FWCompany(), 12 ) + "'"
					cFilter += " .And. TB2_UN 		= '" + Padr( FWUnitBusiness(), 12 ) + "'"
					cFilter += " .And. TB2_FILIAL 	= '" + Padr( FWFilial(), 12 ) + "'"				
					
					oSection2:aTable := {cTotal}
					oSection2:cAlias := cTotal
					oSection2:SetFilter( cFilter )
				
					//-------------------------------------------------------------------
					// Imprime o relatório.  
					//-------------------------------------------------------------------				
					PrintPage( oReport, cDetail, aFieldDetail )
					
					//-------------------------------------------------------------------
					// Remove os filtros.  
					//-------------------------------------------------------------------	
					oSection1:CloseFilter() 
					oSection2:CloseFilter() 
					oSection1:aFilter := {}
					oSection2:aFilter := {}

				Endif
			EndIf
				
			//-------------------------------------------------------------------
			// Interrompe o loop em caso de cancelamento da impressão.
			//-------------------------------------------------------------------	
			If ( oReport:Cancel() )
				Exit 
			EndIf 		
				
			//-------------------------------------------------------------------
			// Libera a memória alocada para o acelerador de busca.
			//-------------------------------------------------------------------	
			oMapKey:Clean()					
					
			SM0->( DbSkip() )
		EndDo
			
		//-------------------------------------------------------------------
		// Totaliza por grupo de empresa. 
		//-------------------------------------------------------------------
		If ( MV_PAR07 == 1 ) 
			PrintTotal( oReport, aFieldDetail, aFieldTotal, cDetail, cTotal,,, cLastBranch )
		EndIf  

		//-------------------------------------------------------------------
		// Gera o relatório analítico em planilha. 
		//-------------------------------------------------------------------		
		If ( MV_PAR04 == 1 )
			dbSelectArea(cExcel)
			(cExcel)->(DbGoTop())
			If (cExcel)->(!Eof())
				CRMXGeraExcel( 2, {cExcel}, {aFieldExcel}, {STR0001}, "FATR120_" )   
			EndIf
		EndIf
	EndIf 	
	
	//-------------------------------------------------------------------
	// Restaura o cache, SM0 e cFilAnt.  
	//------------------------------------------------------------------- 			
	cFilAnt	:= cFilOri
 	SM0->( RestArea( aAreaSM0 ) )
 	
	//-------------------------------------------------------------------
	// Apaga as Tabelas Temporárias.  
	//------------------------------------------------------------------- 
	oTmpDetail:Delete()
	oTmpTotal:Delete()
	oTmpExcel:Delete()
	
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} PrintPage
Imprime as páginas do relatório. 

@param oReport		Objeto do relatório. 	
@param cDetail		Alias do relatório principal. 
@param aFieldDetail	Lista de colunas do relatório principal. 

@author  TOTVS
@since   04/05/2015
/*/
//-------------------------------------------------------------------
Static Function PrintPage( oReport, cDetail, aFieldDetail )
	Local oSection1 	:= oReport:Section(1)
	Local oSection2 	:= oReport:Section(2)	
	Local nLimit		:= 10	
	Local nGroupField	:= 0
	Local nTotalField	:= 0
	Local nFixedField	:= 0
	Local nField		:= 0
	Local nPageCount	:= 0
	Local nPage			:= 0
	Local nStart		:= 0
	Local nStop			:= 0
	Local nExcess		:= 0	
	Local nDevice 		:= oReport:nDevice

	//-------------------------------------------------------------------
	// Restaura os dados das sessões.  
	//-------------------------------------------------------------------		
	aEval( oSection1:aCell, {|x| x:bCellBlock := Nil })	
	aEval( oSection2:aCell, {|x| x:bCellBlock := Nil })	
		
	//-------------------------------------------------------------------
	// Calcula a quantidade de agrupadores no relatório.  
	//-------------------------------------------------------------------		
	For nField := 1 To Len( aFieldDetail )   	
		If ( aFieldDetail[nField][5] )
			nGroupField ++
		EndIf 			
	Next nField		
	
	//-------------------------------------------------------------------
	// Imprime o relatório.  
	//-------------------------------------------------------------------
	If ! ( nDevice == IMP_EXCEL )	
		//-------------------------------------------------------------------
		// Verifica se todas as colunas cabem em apenas uma folha.  
		//-------------------------------------------------------------------		
		If ! ( nGroupField > nLimit )
			(cDetail)->(DbGoTop())
		
			//-------------------------------------------------------------------
			// Inicia a sessão. 
			//-------------------------------------------------------------------
			oSection1:Init()
							
			//-------------------------------------------------------------------
			// Percorre os dados da sessão Faturamento Real. 
			//-------------------------------------------------------------------	
			While ! (cDetail)->( Eof() )
				//-------------------------------------------------------------------
				// Imprime as colunas da página. 
				//-------------------------------------------------------------------
				oSection1:PrintLine()
				
				If ( (cDetail)->TB_DESC == "DES" )
					oReport:ThinLine()				
				EndIf
				
				(cDetail)->( DBSkip() )
			Enddo			

			oReport:EndPage()
			oReport:StartPage()
		Else
			nStart			:= 10       			
			nStop			:= nStart + ( nLimit - 1 )
			nFixedField 	:= Len( aFieldDetail ) - nGroupField
			nTotalField		:= 2
			nExcess			:= Mod( nGroupField + nTotalField, nLimit )
			nPageCount  	:= Int( ( nGroupField + nTotalField )/ nLimit )	
			nPageCount		:= If (	! ( nExcess == 0 ), nPageCount + 1 , nPageCount )

			//-------------------------------------------------------------------
			// Imprime. 
			//-------------------------------------------------------------------
			For	nPage = 1 To nPageCount
				//-------------------------------------------------------------------
				// Oculta as colunas de agrupadores e totais.  
				//-------------------------------------------------------------------
				For	nField = ( nFixedField + 1 ) To Len( aFieldDetail )
					oSection1:Cell(aFieldDetail[nField][1]):Disable()
				Next nField
	
				oSection1:Cell("TB_TOTAL"):Disable() 
				oSection1:Cell("TB_ACUM"):Disable()
			
				//-------------------------------------------------------------------
				// Define os limites de impressão em cada quebra da pagina. 
				//-------------------------------------------------------------------
				If ( nPage == nPageCount )
					nStart 	:= nStop + 1
					nStop 	:= nGroupField + nFixedField
					
					//-------------------------------------------------------------------
					// Exibe os totais na última página. 
					//-------------------------------------------------------------------
					oSection1:Cell("TB_TOTAL"):Enable() 
					oSection1:Cell("TB_ACUM"):Enable() 
				ElseIf !( nPage == 1 )
					nStart 	:= nStop + 1
					nStop 	+= nLimit
				Endif

				(cDetail)->(DbGoTop())
				
				//-------------------------------------------------------------------
				// Inicia a sessão. 
				//-------------------------------------------------------------------
				oSection1:Init()
				
				If nStop > Len( aFieldDetail )
					nStop := Len( aFieldDetail )
				EndIf
				
				//-------------------------------------------------------------------
				// Percorre os dados da sessão Faturamento Real. 
				//-------------------------------------------------------------------	
				While ! (cDetail)->( Eof() )
					//-------------------------------------------------------------------
					// Exibe a coluna de descrição em todas as páginas. 
					//-------------------------------------------------------------------
					oSection1:Cell("TB_DESC"):Show()
					
					//-------------------------------------------------------------------
					// Exibe somente os agrupadores dentro do limite da página. 
					//-------------------------------------------------------------------										
					For nField := nStart To nStop	
						oSection1:Cell( aFieldDetail[nField][1] ):Enable()
					Next nField
					
					//-------------------------------------------------------------------
					// Imprime as colunas da página. 
					//-------------------------------------------------------------------
					oSection1:PrintLine()
					
					If ( (cDetail)->TB_DESC == "DES" )
						oReport:ThinLine()				
					EndIf
					
					(cDetail)->( DBSkip() )
				Enddo

				oReport:EndPage()
				oReport:StartPage()
			Next nPage
		Endif	
		
		//-------------------------------------------------------------------
		// Imprime a sessão Totalizadores.  
		//-------------------------------------------------------------------		
		oSection2:Print()
		oReport:EndPage()
	Else
		(cDetail)->(DbGoTop())
		oReport:PrintText( oReport:Title() ) 
		
		//-------------------------------------------------------------------
		// Inicia a sessão. 
		//-------------------------------------------------------------------
		oSection1:Init()
			
		//-------------------------------------------------------------------
		// Percorre os dados da sessão Faturamento Real. 
		//-------------------------------------------------------------------	
		While ! (cDetail)->( Eof() )
			//-------------------------------------------------------------------
			// Imprime as colunas da página. 
			//-------------------------------------------------------------------
			oSection1:PrintLine()
			(cDetail)->( DBSkip() )
		Enddo			

		oReport:EndPage()
		oReport:StartPage()
		
		//-------------------------------------------------------------------
		// Imprime a sessão Totalizadores.  
		//-------------------------------------------------------------------
		oReport:StartPage()
	 	oSection2:Print()
	Endif
Return 

//-------------------------------------------------------------------
/*/{Protheus.doc} PrintTotal
Imprime a página de totalização por Unidade de Negócio, Empresa e Grupo
de Empresas

@param oReport			Objeto do relatório. 
@param aFieldDetail		Lista de colunas do relatório principal. 
@param aFieldTotal		Lista de campos da página de totalizadores. 
@param cAliasDetail		Alias do relatório principal. 
@param cAliasTotal		Alias dos totalizadores. 
@param cCompany			Empresa. 
@param cUnit			Unidade de negício. 
@param cBranch			Conteúdo da variável cFilAnt. 

@author  Valdiney V GOMES
@since   04/05/2015
/*/
//-------------------------------------------------------------------
Static Function PrintTotal( oReport, aFieldDetail, aFieldTotal, cAliasDetail, cAliasTotal, cCompany, cUnit, cBranch )
	Local oSection1 	:= oReport:Section(1)
	Local oSection2 	:= oReport:Section(2)		
	Local oTmpDetail    := NIL
	Local oTmpTotal     := NIL	
	Local cDetail 		:= GetNextAlias()
	Local cTotal		:= GetNextAlias()
	Local cKey 			:= cEmpAnt 
	Local aIndex1		:= {"TB_GRUPO","TB_EMP","TB_UN","TB_DIA","TB_TIPO"}
	Local aIndex2		:= {"TB2_GRUPO","TB2_EMP","TB2_UN","TB2_DIA","TB2_TIPO"}
	Local nField		:= 0
	Local lUpsert		:= .F. 
	
	Default aFieldDetail	:= {}
	Default aFieldTotal		:= {}
	Default cAliasDetail	:= ""
	Default cAliasTotal		:= ""
	Default cCompany		:= ""
	Default cUnit			:= ""
	Default cBranch			:= ""

	//-------------------------------------------------------------------
	// Define a chave de busca para totalização. 
	//------------------------------------------------------------------- 	
	If ! Empty( cCompany )
		cKey += Padr( cCompany, 12 )
		
		If ! Empty( cUnit )
			cKey += Padr( cUnit, 12 ) 
		Else
			aIndex1 := {"TB_GRUPO","TB_EMP","TB_DIA","TB_TIPO"}
			aIndex2 := {"TB2_GRUPO","TB2_EMP","TB2_DIA","TB2_TIPO"}
		EndIf  
	Else
		aIndex1 := {"TB_GRUPO","TB_DIA","TB_TIPO"}
		aIndex2 := {"TB2_GRUPO","TB2_DIA","TB2_TIPO"}	
	EndIf 

	//-------------------------------------------------------------------
	// Cria a Tabela Temporária para Faturamento Real. 
	//------------------------------------------------------------------- 
	oTmpDetail := FWTemporaryTable():New(cDetail,aFieldDetail)
	oTmpDetail:AddIndex("D", aIndex1 )
	oTmpDetail:Create()
	
	//-------------------------------------------------------------------
	// Cria a Tabela Temporária para Totalizadores. 
	//------------------------------------------------------------------- 	
	oTmpTotal := FWTemporaryTable():New(cTotal,aFieldTotal)
	oTmpTotal:AddIndex("E", aIndex2 )
	oTmpTotal:Create()
	
	//-------------------------------------------------------------------
	// Totaliza o sessão de Faturamento Real. 
	//------------------------------------------------------------------- 	
	(cAliasDetail)->( DBGoTop() )
	
	If ( (cAliasDetail)->( MSSeek( cKey ) ) )
		While ! (cAliasDetail)->( Eof() ) .And. Left( (cAliasDetail)->TB_GRUPO + (cAliasDetail)->TB_EMP + (cAliasDetail)->TB_UN, Len( cKey ) ) == cKey 
			lUpsert :=	! (cDetail)->(MSSeek( cKey + (cAliasDetail)->TB_DIA + (cAliasDetail)->TB_TIPO ) )

			Reclock(cDetail, lUpsert )
				For nField := 1 To Len( aFieldDetail )   	
					If ( aFieldDetail[nField][2] == "N" )
						(cDetail)->&(aFieldDetail[nField][1]) += (cAliasDetail)->&(aFieldDetail[nField][1])
					Else
						(cDetail)->&(aFieldDetail[nField][1]) := (cAliasDetail)->&(aFieldDetail[nField][1])	
					EndIf 			
				Next nField
			MsUnlock(cDetail)
			
			(cAliasDetail)->( DBSkip() )
		EndDo
	EndIf 

	//-------------------------------------------------------------------
	// Totaliza a sessão de Totalizadores. 
	//------------------------------------------------------------------- 
	(cAliasTotal)->( DBGoTop() )
	
	If ( (cAliasTotal)->( MSSeek( cKey ) ) )
		While ! (cAliasTotal)->( Eof() ) .And. Left( (cAliasTotal)->TB2_GRUPO + (cAliasTotal)->TB2_EMP + (cAliasTotal)->TB2_UN, Len( cKey ) ) == cKey 
			lUpsert := ! (cTotal)->(MSSeek( cKey + (cAliasTotal)->TB2_DIA + (cAliasTotal)->TB2_TIPO ) )

			Reclock(cTotal, lUpsert )
				For nField := 1 To Len( aFieldTotal )   	
					If ( aFieldTotal[nField][2] == "N" )
						(cTotal)->&(aFieldTotal[nField][1]) += (cAliasTotal)->&(aFieldTotal[nField][1])
					Else
						(cTotal)->&(aFieldTotal[nField][1]) := (cAliasTotal)->&(aFieldTotal[nField][1])	
					EndIf 			
				Next nField
			MsUnlock(cTotal)
			
			(cAliasTotal)->( DBSkip() )
		EndDo
	EndIf 	

	//-------------------------------------------------------------------
	// Define o título do totalizador do relatório.  
	//-------------------------------------------------------------------	
	cTitle := STR0001 //"Faturamento Real" 
	cTitle += " - "  + STR0005 //"Total "
				
	If ! Empty( FWCompany() ) .And. ! Empty( cCompany )
		cTitle += " - " + AllTrim( FWCompanyName() )
	EndIf 
	
	If ! Empty( FWUnitBusiness() ) .And. ! Empty( cUnit )
		cTitle += " - " + AllTrim( FWUnitName() ) 
	EndIf 				
	
	oReport:SetTitle( cTitle ) 

	//-------------------------------------------------------------------
	// Define o conjunto de dados para a sessão de Faturamento Real.  
	//-------------------------------------------------------------------
	oSection1:aTable := {cDetail}
	oSection1:cAlias := cDetail

	//-------------------------------------------------------------------
	// Define o conjunto de dados para a sessão de Totalizadores.  
	//-------------------------------------------------------------------
	oSection2:aTable := {cTotal}
	oSection2:cAlias := cTotal

	//-------------------------------------------------------------------
	// Imprime o relatório.  
	//-------------------------------------------------------------------	
	PrintPage( oReport, cDetail, aFieldDetail )
	
	//-------------------------------------------------------------------
	// Apaga as Tabelas Temporárias.  
	//------------------------------------------------------------------- 
	oTmpDetail:Delete()
	oTmpTotal:Delete()
Return 

//-------------------------------------------------------------------
/*/{Protheus.doc} getKey
Retorna a chave de busca no agrupador com base no valor do resultset.  
 
@param cTable		Tabela principal do agrupador.  
@param cResultSet	Conjunto de dados do relatório. 
@return aKey		Array no formato {{CAMPO, VALOR}}
 
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
	If ( SIX->( MSSeek( cTable + "1" ) ) )
		aField := aBIToken( SIX->CHAVE, "+", .F. )
		
		For nField := 1 To Len( aField )
			If ! ( "_FILIAL" $ aField[nField] )
				aAdd( aKey, { AllTrim( aField[nField] ), (cResultSet)->&( aField[nField] ) } )
			EndIf 
		Next nField 
	EndIf
Return aKey

//-------------------------------------------------------------------
/*/{Protheus.doc} getVariation
Calcula a variação percentual entre dois valores. 

@param nFinal 		Valor final ou atual
@param nInitial 	Valor inicial. 
@return nVariation	Variação percentual.

@author  Valdiney V GOMES
@since   29/04/2015
/*/
//-------------------------------------------------------------------
Static Function getVariation( nFinal, nInitial ) 
	Local nVariation 	:= 0
	
	Default nFinal 		:= 0
	Default nInitial	:= 0	
	
	If ! ( ( nFinal == 0 ) .Or. ( nInitial == 0 ) )
		//-------------------------------------------------------------------
		// Calcula a variação percentual. 
		//-------------------------------------------------------------------  
		nVariation := ( ( nFinal - nInitial ) / nInitial ) * 100
	EndIf
Return nVariation

//-------------------------------------------------------------------
/*/{Protheus.doc} GetFieldDetail
Monta as colunas do relatório. 

@param aPool	Retorno da função CRMA580E. 
@return aField 	Campos utilizados como colunas no relatório onde: {COLUNA, TIPO, TAMANHO, DECIMAIS, AGRUPADOR?, NIVEL}

@author  Valdiney V GOMES
@version P12
@since   29/04/2015  
/*/
//-------------------------------------------------------------------
Static Function GetFieldDetail( aPool ) 
	Local aField	:= {}
	Local nLevel 	:= 0
	
	Default aPool	:= {}

	aAdd(aField,{"TB_GRUPO"		,"C"	,02 					,00						,.F. }) 
	aAdd(aField,{"TB_EMP"	  	,"C"	,12 					,00						,.F. })
	aAdd(aField,{"TB_UN"	  	,"C"	,12 					,00						,.F. })
	aAdd(aField,{"TB_FILIAL" 	,"C"	,12 					,00						,.F. })
	aAdd(aField,{"TB_TIPO"	  	,"C"	,01 					,00						,.F. })
	aAdd(aField,{"TB_DIA"	  	,"C"	,03 					,00						,.F. })
	aAdd(aField,{"TB_DESC"	  	,"C"	,03 					,00						,.F. })
	aAdd(aField,{"TB_TOTAL"		,"N"	,TamSx3("D2_TOTAL")[1] 	,TamSx3("D2_TOTAL")[2]	,.F. })
	aAdd(aField,{"TB_ACUM"	  	,"N"	,TamSx3("D2_TOTAL")[1] 	,TamSx3("D2_TOTAL")[2]	,.F. })

	//-------------------------------------------------------------------
	// Adiciona um campo para cada agrupador. 
	//------------------------------------------------------------------- 	
	If ( ! Len( aPool ) == 0 )	
		
		AOM->( DBSetOrder( 1 ) )
			
		For nLevel := 1 To Len( aPool[1][4] )	
			If ( aPool[1][4][nLevel][2] == CRMA580Root() )
				If ( AOM->( MSSeek( xFilial("AOM") + aPool[1][1] + aPool[1][4][nLevel][1] ) ) )
					aAdd( aField, { "TB_" + AOM->AOM_CODNIV, "N", TamSx3("D2_TOTAL")[1] ,TamSx3("D2_TOTAL")[2], .T.,  AOM->AOM_DESCRI } )
				EndIf 	
			EndIf	
		Next nLevel
	EndIf 
	
	//-------------------------------------------------------------------
	// Adiciona um campo para o agrupador indefinido. 
	//------------------------------------------------------------------- 
	aAdd(aField,{"TB_" + CRMA580Root(), "N", TamSx3("D2_TOTAL")[1], TamSx3("D2_TOTAL")[2], .T., STR0010 } ) //"INDEFINIDO" Top da raiz Root(000)
	
Return aField

//-------------------------------------------------------------------
/*/{Protheus.doc} GetFieldTotal
Monta as colunas do relatório. 

@Return aField Campos utilizados como colunas no relatório onde: {COLUNA, TIPO, TAMANHO, DECIMAIS}

@author  Valdiney V GOMES
@version P12
@since   29/04/2015  
/*/
//-------------------------------------------------------------------
Static Function GetFieldTotal() 
	Local aField	:= {}

	aAdd(aField,{"TB2_GRUPO"  	,"C" ,02 						,00}) 
	aAdd(aField,{"TB2_EMP"	   	,"C" ,12 						,00})
	aAdd(aField,{"TB2_UN"	   	,"C" ,12						,00})
	aAdd(aField,{"TB2_FILIAL"	,"C" ,12 						,00})
	aAdd(aField,{"TB2_TIPO"  	,"C" ,01 						,00})
	aAdd(aField,{"TB2_DIA"	   	,"C" ,03 						,00})
	aAdd(aField,{"TB2_DESC"  	,"C" ,03 						,00})
	aAdd(aField,{"TB2_TOTDP" 	,"N" ,16 						,04})
	aAdd(aField,{"TB2_TOTGP" 	,"N" ,16 						,04})
	aAdd(aField,{"TB2_TOTG" 	,"N" ,TamSx3("D2_TOTAL")[1] 	,TamSx3("D2_TOTAL")[2]})
	aAdd(aField,{"TB2_TOTGA" 	,"N" ,TamSx3("D2_TOTAL")[1] 	,TamSx3("D2_TOTAL")[2]})
	aAdd(aField,{"TB2_TOTD" 	,"N" ,TamSx3("D2_TOTAL")[1] 	,TamSx3("D2_TOTAL")[2]})
	aAdd(aField,{"TB2_TOTDA" 	,"N" ,TamSx3("D2_TOTAL")[1]		,TamSx3("D2_TOTAL")[2]})
	aAdd(aField,{"TB2_INSS" 	,"N" ,TamSx3("D2_VALCPB")[1] 	,TamSx3("D2_VALCPB")[2]})
	aAdd(aField,{"TB2_ISS" 		,"N" ,TamSx3("D2_VALISS")[1] 	,TamSx3("D2_VALISS")[2]})
	aAdd(aField,{"TB2_PIS" 		,"N" ,TamSx3("D2_VALPIS")[1] 	,TamSx3("D2_VALPIS")[2]})
	aAdd(aField,{"TB2_COFINS" 	,"N" ,TamSx3("D2_VALCOF")[1] 	,TamSx3("D2_VALCOF")[2]})	
Return aField

//-------------------------------------------------------------------
/*/{Protheus.doc} GetFieldExcel
Monta os campos do relatório analítico.

@Return aField Campos utilizados como colunas no relatório onde: {COLUNA, TIPO, TAMANHO, DECIMAIS, DESCRIÇÃO}

@author  Valdiney V GOMES
@version P12
@since   29/04/2015  
/*/
//-------------------------------------------------------------------
Static Function GetFieldExcel() 
	Local aField	:= {}

	aAdd(aField,{"TB3_FILIAL"  	,"C" ,12 						,00							,STR0011 }) //"Filial"
	aAdd(aField,{"TB3_ORIGEM"  	,"C" ,10 						,00							,STR0013 }) //"Origem" 
	aAdd(aField,{"TB3_EMISSA" 	,"D" ,TamSX3("D2_EMISSAO")[1]	,TamSX3("D2_EMISSAO")[2]	,STR0012 }) //"Emissão"
	aAdd(aField,{"TB3_AGRUP"   	,"C" ,TamSX3("AOM_CODNIV")[1]	,TamSX3("AOM_CODNIV")[2]	,STR0014 }) //"Cod. Agrupador"
	aAdd(aField,{"TB3_DESC"   	,"C" ,TamSX3("AOM_DESCRI")[1]	,TamSX3("AOM_DESCRI")[2]	,STR0015 }) //"Agrupador"  	
	aAdd(aField,{"TB3_CLIENT"   ,"C" ,TamSX3("D2_CLIENTE")[1]	,TamSX3("D2_CLIENTE")[2]	,STR0016 }) //"Cod. Cliente" 
	aAdd(aField,{"TB3_NOME"   	,"C" ,TamSX3("A1_NOME")[1]		,TamSX3("A1_NOME")[2]		,STR0017 }) //"Cliente" 
	aAdd(aField,{"TB3_DOC"   	,"C" ,TamSX3("D2_DOC")[1]		,TamSX3("D2_DOC")[2]		,STR0018 }) //"Documento"
	aAdd(aField,{"TB3_DIGIT"   	,"D" ,TamSX3("D2_EMISSAO")[1]	,TamSX3("D2_EMISSAO")[2]	,STR0019 }) //"Data de Digitação" 
	aAdd(aField,{"TB3_SERIE"   	,"C" ,TamSX3("D2_SERIE")[1]		,TamSX3("D2_SERIE")[2]		,STR0020 }) //"Série"
	aAdd(aField,{"TB3_ITEM"   	,"C" ,TamSX3("D1_ITEM")[1]		,TamSX3("D1_ITEM")[2]		,STR0021 }) //"Item" 
	aAdd(aField,{"TB3_COD"   	,"C" ,TamSX3("D2_COD")[1]		,TamSX3("D2_COD")[2]		,STR0022 }) //"Cod. Produto"
	aAdd(aField,{"TB3_PROD"   	,"C" ,TamSX3("B1_DESC")[1]		,TamSX3("B1_DESC")[2]		,STR0023 }) //"Produto"
	aAdd(aField,{"TB3_QUANT"  	,"N" ,TamSX3("D2_QUANT")[1]		,TamSX3("D2_QUANT")[2]		,STR0024 }) //"Quantidade"
	aAdd(aField,{"TB3_TOTAL"   	,"N" ,TamSX3("D2_TOTAL")[1]		,TamSX3("D2_TOTAL")[2]		,STR0025 }) //"Valor"
	aAdd(aField,{"TB3_GRUPO"   	,"C" ,TamSX3("BM_GRUPO")[1]		,TamSX3("BM_GRUPO")[2]		,STR0035 }) //"Cod. Grupo Produto"
	aAdd(aField,{"TB3_GRDES"   	,"C" ,TamSX3("BM_DESC")[1]		,TamSX3("BM_DESC")[2]		,STR0026 }) //"Grupo Produto"
	aAdd(aField,{"TB3_CC"   	,"C" ,TamSX3("D2_CCUSTO")[1]	,TamSX3("D2_CCUSTO")[2]		,STR0027 }) //"Centro de Custo"
	aAdd(aField,{"TB3_ITEMCC"   ,"C" ,TamSX3("D2_ITEMCC")[1]	,TamSX3("D2_ITEMCC")[2]		,STR0028 }) //"Item Contábil"
	aAdd(aField,{"TB3_CLVL"  	,"C" ,TamSX3("D2_CLVL")[1]		,TamSX3("D2_CLVL")[2]		,STR0036 }) //"Classe de Valor"
	aAdd(aField,{"TB3_CONTA"   	,"C" ,TamSX3("D2_CONTA")[1]		,TamSX3("D2_CONTA")[2]		,STR0029 }) //"Conta contábil"
	aAdd(aField,{"TB3_PAIS"   	,"C" ,TamSX3("A1_PAIS")[1]		,TamSX3("A1_PAIS")[2]		,STR0030 }) //"País"
	aAdd(aField,{"TB3_INSS"   	,"N" ,TamSX3("D2_VALCPB")[1]	,TamSX3("D2_VALCPB")[2]		,"INSS" })
	aAdd(aField,{"TB3_PIS"   	,"N" ,TamSX3("D2_VALPIS")[1]	,TamSX3("D2_VALPIS")[2]		,"PIS" })
	aAdd(aField,{"TB3_COFINS"   ,"N" ,TamSX3("D2_VALCOF")[1]	,TamSX3("D2_VALCOF")[2]		,"COFINS" })
	aAdd(aField,{"TB3_ISS "   	,"N" ,TamSX3("D2_VALISS")[1]	,TamSX3("D2_VALISS")[2]		,"ISS" })
Return aField




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
