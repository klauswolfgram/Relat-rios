/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.CH"

/*/{Protheus.doc} GFER056
Relatorio de Romaneio de Carga
Generico.
 
@sampleGFER056()

@author Alexandre Cuchi
@since 11/12/14                                                            
@version 1.0
/*/
User Function GFER056()
	Local oReport          //objeto que contem o relatorio
	Local aArea := GetArea()

	Private cNMEMIS   := ""
	Private cNMCDREM  := ""
	Private cUFCDREM  := ""
	Private cDSTRP    := ""
	Private nTotTrans := 0
	Private nTotVol   := 0
	Private nTotPeso  := 0
	Private nTotPesoC := 0
	Private nTotItens := 0
	Private nUnit     := 0
	Private aTotDocs   := {0,0,0,0,0} //aTotDocs := {Vl.Total , Peso Bruto , Cubagem m3 , Volumes , Unitizador}
	Private aItnsPrint := {}
	Private cAliasGW1  
	Private cNrDc      := ""
	Private cNSerDc    := ""
	Private nQtVol     := 0

	Pergunte("GFER050",.F.)

	If TRepInUse() // teste padrão 
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

	RestArea( aArea )
Return      

/*/{Protheus.doc} ReportDef
Relatorio de Documentos de Carga
Generico.

@sample
ReportDef()

@author Alexandre Cuchi
@since 11/12/14   
@version 1.0
/*/
Static Function ReportDef()
	Local oReport
	Local oSection1
	Local oSection2
	Local oSection3
	Local oSection4
	Local aOrdem    := {}

	/*/--------------------------------------------------------------------
	Criacao do componente de impressao                                      
                                                                        
	TReport():New                                                           
	ExpC1 : Nome do relatorio                                               
	ExpC2 : Titulo                                                          
	ExpC3 : Pergunte                                                        
	ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  
	ExpC5 : Descricao                                                       
	------------------------------------------------------------------------/*/ 
	oReport:= TReport():New("GFER056","Expedição de Romaneios","GFER050", {|oReport| ReportPrint(oReport)},"Emite a listagem dos Romaneios de Carga conforme os parâmetros informados.")
	oReport:SetLandscape()   // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)

	/*/---------------------------------------------------------------------------
	Criacao da secao utilizada pelo relatorio                             
	TRSection():New                                                       
	ExpO1 : Objeto TReport que a secao pertence                           
	ExpC2 : Descricao da seçao                                            
	ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela 
			sera considerada como principal para a seção.                 
	ExpA4 : Array com as Ordens do relatório                              
	ExpL5 : Carrega campos do SX3 como celulas                            
			Default : False                                               
	ExpL6 : Carrega ordens do Sindex                                      
			Default : False                                               
	Criacao da celulas da secao do relatorio                              
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
	-----------------------------------------------------------------------------/*/
	Aadd( aOrdem,"Sequência"  ) // "Sequência" //"Codigo"

	oSection1 := TRSection():New(oReport,"Romaneios de Carga",{"GWN","GU7"},aOrdem)  //"Romaneios de Carga"
	oSection1:SetLineStyle() //Define a impressao da secao em linha
	oSection1:SetTotalInLine(.F.)  

	TRCell():New(oSection1,"GWN_FILIAL","GWN", "Filial "              ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWN_NRROM" ,"GWN", " Romaneio "           ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWN_CDTRP" ,"GWN", "Cd. Transp"			  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"cDSTRP"    ,""   , ""          			  ,"@!"       ,50         ,/*lPixel*/,  {||cDSTRP}  ) //"Nome Transportador"
	TRCell():New(oSection1,"GWN_CDTPOP","GWN", /*cTitle*/  			  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 

	TRCell():New(oSection1,"GWN_NRCIDD","GWN", "Cidade Dest. Romaneio",/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GU7_NMCID" ,"GU7", "Nome Cid. Romaneio"   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWN_CEPD " ,"GWN", /*cTitle*/  			  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

	TRPosition():New(oSection1,"GU7",1,{|| xFilial("GU7") + GWN->GWN_NRCIDD})                  
	/***************************************************************************/   
	oSection2 := TRSection():New(oSection1,"Documentos de Carga",{"GW1","GWB"},aOrdem) //  //
	oSection2:SetTotalInLine(.F.)
	oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	//cEMISDC, cNMEMIS, cCDREM, cNMREM, cCDDEST2, cNMREM2

	TRCell():New(oSection2,"GW1_SERDC" ,"GW1", /*cTitle*/         , /*Picture*/        , 5          		   ,/*lPixel*/, {||cNSerDc   })
	TRCell():New(oSection2,"GW1_NRDC"  ,"GW1", /*cTitle*/         , /*Picture*/        , 12         		   ,/*lPixel*/, {||cNrDC     })
	TRCell():New(oSection2,"cNMEMIS"   ,"GW1", "Nome"             , /*Picture*/        , 15         		   ,/*lPixel*/, {||cNMEMIS   }) //Nome
	TRCell():New(oSection2,"GW1_NMREM" ,"GW1", "Nome do Remetente", /*Picture*/        , /*Tamanho*/		   ,/*lPixel*/, {||NomeEmit(GW1->GW1_FILIAL , cCdRem)  }) 
	TRCell():New(oSection2,"GW1_CDDEST","GW1", ""     			  , /*Picture*/        , /*Tamanho*/		   ,/*lPixel*/, {||cCdDest   })
	TRCell():New(oSection2,"GW1_NMDEST","GW1", "Nome Destinatário", /*Picture*/        , /*Tamanho*/		   ,/*lPixel*/, {||NomeEmit(GW1->GW1_FILIAL , cCdDest) })
	TRCell():New(oSection2,"cNMCDREM"  ,"GW1", "Cidade Remetente" , /*Picture*/        , 15         		   ,/*lPixel*/, {||cNMCDREM  }) //"Cidade"
	TRCell():New(oSection2,"cUFCDREM"  ,"GW1", "UF Remetente"     , /*Picture*/		   , 2          		   ,/*lPixel*/, {||cUFCDREM  }) //UF

	TRCell():New(oSection2,"nTotTrans" ,"GW1", "Vl.Total"  		  , "@E 99,999,999.99" , 13                    ,/*lPixel*/, {||nTotTrans }) 
	TRCell():New(oSection2,"nTotPeso"  ,"GW1", "Peso Bruto"		  , "@E 99,999.99999"  , 11                    ,/*lPixel*/, {||nTotPeso  }) 
	TRCell():New(oSection2,"nTotPesoC" ,"GW1", "Cubagem m3"		  , "@E 9,999,999.9999", 13                    ,/*lPixel*/, {||nTotPesoC }) 
	TRCell():New(oSection2,"GW1_QTVOL" ,"GW1", "Volumes"   		  , /*Picture*/        , TamSX3("GW1_QTVOL")[1],/*lPixel*/, {||nQtVol    })
	TRCell():New(oSection2,"nUnit"     ,"GW1", "Unitizadores"	  , /*Picture*/        , 20                    ,/*lPixel*/, {||nUnit     })
	/* Celulas que se necessárias o usuário deve ativar. */
	oSection2:Cell(3):lUserEnabled := .F. // Cd. Transp
	oSection2:Cell(4):lUserEnabled := .F. //cDSTRP - Nome Transportador

	/*************************************************************************/ 
	oSection3 := TRSection():New(oSection2,"Itens dos Documentos",{"GW8"},aOrdem) // //
	oSection3:SetTotalInLine(.T.)
	oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção  

	TRCell():New(oSection3,"GW8_ITEM"   ,"GW8",/*cTitle*/  ,/*Picture*/,TamSX3("GW8_ITEM"  )[1],/*lPixel*/,{|| aItnsPrint[1] })
	TRCell():New(oSection3,"GW8_DSITEM" ,"GW8",/*cTitle*/  ,/*Picture*/,TamSX3("GW8_DSITEM")[1],/*lPixel*/,{|| aItnsPrint[2] })
	TRCell():New(oSection3,"GW8_QTDE"   ,"GW8",/*cTitle*/  ,/*Picture*/,TamSX3("GW8_QTDE"  )[1],/*lPixel*/,{|| aItnsPrint[3] })
	/**************************************************************************/   
	oSection4 := TRSection():New(oSection2,"Total de Itens",{"GWB"},aOrdem) //  //"Unitizadores"
	oSection4:SetTotalInLine(.T.)
	oSection4:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção      
	TRCell():New(oSection4,"nTotIten1"   ,"GW8"," "               ,/*Picture*/,TamSX3("GW8_ITEM")[1]  ,/*lPixel*/,{|| '' })
	TRCell():New(oSection4,"nTotIten2"   ,"GW8"," "               ,/*Picture*/,TamSX3("GW8_DSITEM")[1],/*lPixel*/,{|| '' })
	TRCell():New(oSection4,"nTotItens"   ,"GW8","Total Dos Itens","@E 9,999,999.99999",/*Tamanho*/       ,/*lPixel*/,{|| nTotItens })
	/***************************************************************************/
	oSctnTotal := TRSection():New(oSection2,"Totais do documento",{""},aOrdem) //"Totais do Documentos"
	oSctnTotal:SetTotalInLine(.T.)

	TRCell():New(oSctnTotal,"12"          ,"" ," "                ,/*Picture*/,5         ,/*lPixel*/,{||""          })
	TRCell():New(oSctnTotal,"13"          ,"" ," "                ,/*Picture*/,12        ,/*lPixel*/,{||""          })
	TRCell():New(oSctnTotal,"14"          ,"" ," "                ,/*Picture*/,15        ,/*lPixel*/,{||""          })
	TRCell():New(oSctnTotal,"15"          ,"" ," "                ,/*Picture*/,15        ,/*lPixel*/,{||""          })
	TRCell():New(oSctnTotal,"16"          ,"" ," "                ,/*Picture*/,2         ,/*lPixel*/,{||""          })
	TRCell():New(oSctnTotal,"aTotDocs[1]" ,"TOT" ,"Tot. Romaneio"    ,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| aTotDocs[1] })
	TRCell():New(oSctnTotal,"aTotDocs[2]" ,"TOT" ,"Tot. Peso Bruto"  ,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| aTotDocs[2] })
	TRCell():New(oSctnTotal,"aTotDocs[3]" ,"TOT" ,"Tot. Cubagem (M3)",/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| aTotDocs[3] })
	TRCell():New(oSctnTotal,"aTotDocs[4]" ,"TOT" ,"Qtd. Volumes"     ,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| aTotDocs[4] })
	TRCell():New(oSctnTotal,"aTotDocs[5]" ,"TOT" ,"Qtd. Unitizadores",/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| aTotDocs[5] })

Return(oReport)

/*************************************************************************************************************************************/   
/*/{Protheus.doc} ReportPrint
Relatorio de Romaneio
Generico.

@sample ReportPrint(oReport,cAliasQry)

@author Alexandre Cuchi
@since 11/12/14                               
@version 1.0
/*/
Static Function ReportPrint(oReport)
	Local nPos 		 := 0
	Local nCont      := 0
	Local lLoop      := .F.
	Local aItensRoma :=  {}
	Local oSection1  := oReport:Section(1)
	Local oSection2  := oReport:Section(1):Section(1)
	Local oSection3  := oReport:Section(1):Section(1):Section(1)
	Local oSection4  := oReport:Section(1):Section(1):Section(2)
	Local oSctnTotal := oReport:Section(1):Section(1):Section(3)
	Local cFilialDe  := MV_PAR01
	Local cFilialAte := MV_PAR02
	Local cNrRomDe   := MV_PAR03
	Local cNrRomAte  := MV_PAR04
	Local nSituacao  := MV_PAR05
	Local nCalculo   := MV_PAR06
	Local dDtCriaDe  := MV_PAR07
	Local dDtCriaAte := MV_PAR08
	Local cTranspDe  := MV_PAR09
	Local cTranspAte := MV_PAR10
	Local cTpOperDe  := MV_PAR11
	Local cTpOperAte := MV_PAR12
	Local dDtSaiDe   := MV_PAR13
	Local dDtSaiAte  := MV_PAR14
	Local cClsFrtde  := MV_PAR15
	Local cClsFrtAte := MV_PAR16
	Local cTpVeicDe  := MV_PAR17
	Local cTpVeicAte := MV_PAR18
	Local cAliasGW1  := Nil
	Local cWhere     := Nil
	
	Private cCdRem	  := ''
	Private cCdDest   := ''
	//Private nTotTrans := 0
	//Private nTotVol   := 0
	//Private nTotPeso  := 0
	//Private nTotPesoC := 0
	Private nTotItens := 0
	//Private nUnit     := 0
	Private aTotDocs   := {0,0,0,0,0}
	//Private aItnsPrint := {}

	oReport:SetMeter( GWN->( LastRec() ) )
	GWN->( dbSetOrder(2) )
	GWN->( dbGoTop() )

	While !GWN->( Eof() ) .And. !oReport:Cancel()
	
		If GWN->GWN_FILIAL >= cFilialDe .And. GWN->GWN_FILIAL <= cFilialAte .And. GWN->GWN_NRROM >= cNrRomDe .And. GWN->GWN_NRROM <= cNrRomAte .And.;
	       GWN->GWN_CDTRP >= cTranspDe .And. GWN->GWN_CDTRP <= cTranspAte .And. GWN->GWN_CDTPOP >= cTpOperDe .And. GWN->GWN_CDTPOP <= cTpOperAte .And.;
	   	   dTOs(GWN->GWN_DTSAI) >= dTos(dDtSaiDe ) .And. dTos(GWN->GWN_DTSAI) <= dTos(dDtSaiAte ) .And. GWN->GWN_CDCLFR >= cClsFrtde .And. GWN->GWN_CDCLFR <= cClsFrtAte .And.;
	       GWN->GWN_CDTPVC >= cTpVeicDe .And. GWN->GWN_CDTPVC <= cTpVeicAte .And. dTos(GWN->GWN_DTIMPL) >= dTos(dDtCriaDe) .And. dTos(GWN->GWN_DTIMPL)<= dTOs(dDtCriaAte) .And.;  
	       (nCalculo == 3 .Or. Val(GWN->GWN_CALC) == nCalculo) .And. IIf (nSituacao == 4, .T., Val(GWN->GWN_SIT) == nSituacao)

			If GFXCP1212210('GW1_FILROM')
				cWhere := "GW1.GW1_FILROM = '" + GWN->GWN_FILIAL + "'"
			Else
				cWhere := "GW1.GW1_FILIAL = '" + GWN->GWN_FILIAL + "'"
			EndIf
			cWhere := "%" + cWhere + "%"

			cAliasGW1 := GetNextAlias()
			BeginSql Alias cAliasGW1
				SELECT GW1_FILIAL, GW1_CDTPDC, GW1_EMISDC, GW1_SERDC, GW1_NRDC, GW1_CDREM, GW1_CDDEST, GW1_QTVOL, GW1.R_E_C_N_O_ AS GW1RECNO
				FROM %table:GW1% GW1
				WHERE %Exp:cWhere%
				AND GW1.GW1_NRROM  = %Exp:GWN->GWN_NRROM%
				AND GW1.%NotDel%
				ORDER BY GW1.GW1_FILIAL,GW1.GW1_NRDC
			EndSql
			If (cAliasGW1)->(Eof())
				GWN->(dbSkip())
				Loop
			EndIf
		
			oSection1:Init()// INICIO SECTION 1
			oSctnTotal:Init()// Inicio dos totalizadores
			cDSTRP := Posicione("GU3",1,XFILIAL("GU3")+GWN->GWN_CDTRP,"GU3_NMEMIT")
			oSection1:PrintLine()
			oReport:IncMeter()
			oReport:SetTotalInLine(.T.)
		
			nTotTrans  := 0
			nTotVol    := 0
			nTotPeso   := 0
			nTotPesoC  := 0 
			aTotDocs[1]:= 0 
		
			aTotDocs[2]:= 0 
			aTotDocs[3]:= 0 
			aTotDocs[4]:= 0 
			aTotDocs[5]:= 0 
			aItensRoma := {}    

			oSection2:Init()// INICIO SECTION 2     
			oSctnTotal:Init()// Inicio totalizadores
			
			While !oReport:Cancel() .And. !(cAliasGW1)->(Eof())
				nTotTrans := 0 
				nTotVol   := 0 
				nTotPeso  := 0 
				nTotPesoC := 0 

				cNrDC      := (cAliasGW1)->GW1_NRDC
				cNSerDc	   := (cAliasGW1)->GW1_SERDC
				nQtVol	   := (cAliasGW1)->GW1_QTVOL

				GW8->( dbSetOrder(1) )
				If GW8->( dbSeek((cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC) )

		    		oSection4:Init() //INICIO SECTION 4
		    	
					While lLoop := !oReport:Cancel() .And. !GW8->( Eof() ) .And. GW8->GW8_FILIAL == (cAliasGW1)->GW1_FILIAL ;
																		.And. GW8->GW8_CDTPDC == (cAliasGW1)->GW1_CDTPDC;
																		.And. GW8->GW8_EMISDC == (cAliasGW1)->GW1_EMISDC;
																		.And. GW8->GW8_SERDC  == (cAliasGW1)->GW1_SERDC ;
																		.And. GW8->GW8_NRDC   == (cAliasGW1)->GW1_NRDC
						//Totalizador dos itens
						nTotTrans  += GW8->GW8_VALOR
						nTotVol    += GW8->GW8_VOLUME 
						nTotPeso   += GW8->GW8_PESOR
						nTotPesoC  += GW8->GW8_PESOC
						nTotItens  += GW8->GW8_QTDE
          					
						nPos := aScan( aItensRoma, {|x| x[1] == GW8->GW8_ITEM} )
						If nPos == 0
							AAdd(aItensRoma,{GW8->GW8_ITEM,GW8->GW8_DSITEM,GW8->GW8_QTDE})
						Else
							aItensRoma[nPos][3] := GW8->GW8_QTDE+aItensRoma[nPos][3]
						EndIf	 
					
						GW8->( dbSkip() )
					EndDo
					//Volta
					GU3->(dbSetOrder(1))
					GU3->(dbSeek(xFilial("GU3") + (cAliasGW1)->GW1_EMISDC)) 
				
					cNMEMIS := GU3->GU3_NMEMIT
				
					GU3->(dbSeek(xFilial("GU3") + (cAliasGW1)->GW1_CDREM))  
					GU7->(dbSetOrder(1))
					GU7->(dbSeek(xFilial("GU7") + GU3->GU3_NRCID))  
				
					cCDREM   := (cAliasGW1)->GW1_CDREM
					cNMREM   := GU3->GU3_NMEMIT
					cNRCDREM := GU7->GU7_NRCID
					cNMCDREM := AllTrim(GU7->GU7_NMCID) 
					cUFCDREM := GU7->GU7_CDUF
				
					GU3->(dbSeek(xFilial("GU3") + (cAliasGW1)->GW1_CDDEST))
					cCdDest := (cAliasGW1)->GW1_CDDEST
					
					GU7->(dbSeek(xFilial("GU7") + GU3->GU3_NRCID))
				
					GWB->(dbSetOrder(2))
					GWB->(dbSeek((cAliasGW1)->GW1_FILIAL + (cAliasGW1)->GW1_CDTPDC + (cAliasGW1)->GW1_EMISDC + (cAliasGW1)->GW1_SERDC + (cAliasGW1)->GW1_NRDC))
					nUnit := 0
				
					While !GWB->( Eof() ) .And. GWB->GWB_FILIAL == (cAliasGW1)->GW1_FILIAL .And. GWB->GWB_CDTPDC == (cAliasGW1)->GW1_CDTPDC; 
										  .And. GWB->GWB_EMISDC == (cAliasGW1)->GW1_EMISDC .And. GWB->GWB_SERDC  == (cAliasGW1)->GW1_SERDC;
										  .And. GWB->GWB_NRDC   == (cAliasGW1)->GW1_NRDC
						nUnit += GWB->GWB_QTDE
						GWB->( dbSkip() )
					EndDo
				
					oSection2:PrintLine() // PrintLine Secção 2
				
					aTotDocs[1] += nTotTrans
					aTotDocs[2] += nTotPeso
					aTotDocs[3] += nTotPesoC
					aTotDocs[4] += (cAliasGW1)->GW1_QTVOL
					aTotDocs[5] += nUnit
				EndIf
				(cAliasGW1)->(dbSkip())
			EndDo	
			(cAliasGW1)->(dbCloseArea())

			oSctnTotal:PrintLine()
			oSection2:Finish()
			oSection3:Init()
			For nCont := 1 to Len(aItensRoma)
				aItnsPrint := aItensRoma[nCont]
				oSection3:PrintLine()// Prit Line Secção 3
			Next nCont
			cDSTRP := Posicione("GU3",1,XFILIAL("GU3")+GWN->GWN_CDTRP,"GU3_NMEMIT")
			oSection4:PrintLine() // Prit Line Secção 4
			oReport:SkipLine()
			oSctnTotal:Finish()  
			oSection4:Finish()
			nTotItens := 0
			oReport:SkipLine()
			oSection1:Finish()
			oSection3:Finish()
			oSection4:Finish()
		EndIf
	
		GWN->( dbSkip() )
	EndDo
Return

Static Function NomeEmit(cFil, cCdEmit)
	Local cNome    := ''
	Local aAreaGU3 := {}
	Local cFilBkp  := cFilAnt

	cFilAnt := cFil

	aAreaGU3 := GU3->(GetArea())
	GU3->(dbSetOrder(1))
	GU3->(dbSeek(xFilial('GU3')+cCdEmit))
	cNome := GU3->GU3_NMEMIT

	RestArea(aAreaGU3)
	cFilAnt := cFilBkp
	
Return cNome

