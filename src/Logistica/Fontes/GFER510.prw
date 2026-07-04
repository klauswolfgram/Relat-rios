/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"        
#INCLUDE "GFER510.CH"       

//-------------------------------------------------------------------
//Inclusão Pátios 12.1.4
//-------------------------------------------------------------------
/*/{Protheus.doc} GFER510

Relátorio Tabela de Frete

@author Jorge Matos Valcanaia
@since 05/11/09
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFER510()
Local oReport
Local aArea := GetArea()     
Private cPont
Private nTotAgend 	:= 0
Private nQtdInd		:= 0
Private nPerInd		:= 0
Private nQtdAtraso	:= 0
Private nPerAtraso	:= 0
Private nQtdAdiant	:= 0
Private nPerAdiant	:= 0
Private nQtdHora	:= 0
Private nPerHora	:= 0

If TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf

RestArea( aArea )

Return

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.          
//
//Uso       GFER510
//---------------------------------------------------------------------------

Static Function ReportDef()                                                                      	
Local oReport, oSection1, oSection2, oSection3, oSection4, oSection5, oSection6, oSection7
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
oReport:= TReport():New("GFER510",STR0001,"GFER5101", {|oReport| ReportPrint(oReport)},STR0001) //"Listagem Programação" ### "Listagem Programação"
Pergunte("GFER5101",.F.)



oReport:SetLandscape()
oReport:HideParamPage()   	// Desabilita a impressao da pagina de parametros
oReport:SetTotalInLine(.F.)	// Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha


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

	Aadd( aOrdem, STR0002 ) //"Agendamento"
	
	oSection1 := TRSection():New(oReport,"Agendamento",{"GWV","GU3","GVL"},aOrdem) //"Agendamento"
	oSection1:SetLineStyle() //Define a impressao da secao em linha
	oSection1:SetTotalInLine(.F.)
	TRCell():New(oSection1,"GWV_NRAGEN","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_CDEMIT","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_NMEMIT","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,{|| POSICIONE("GU3",1,XFILIAL("GU3")+GWV->GWV_CDEMIT,"GU3_NMEMIT") }/*{|| code-block de impressao }*/) 
	TRCell():New(oSection1,"GWV_CDOPER","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_DSOPER","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,{|| POSICIONE("GVC",1,XFILIAL("GVC")+GWV->GWV_CDOPER,"GVC_DSOPER") }/*{|| code-block de impressao }*/)

	TRCell():New(oSection1,"GWV_SEQ","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_DSCONF","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,{|| Posicione("GVI",1,xFilial("GVI")+GWV->GWV_CDOPER+GWV->GWV_SEQ,"GVI_DSCONF") }/*{|| code-block de impressao }*/)
	
	TRCell():New(oSection1,"GWV_DTAGEN","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_HRAGEN","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	TRCell():New(oSection1,"GWV_NRROM","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_PESOR","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	TRCell():New(oSection1,"GWV_NRMOV" ,"GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_IDTIPO","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_SIT"   ,"GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_MOTCAN","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_IDENVI","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWV_IDCONF","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"cPont"  ,"", "Pontualidade","@!",13,/*lPixel*/,{|| cPont })
	
	oSection2 := TRSection():New(oSection1,STR0003,{"GWW"},aOrdem) //"Agendamento Docto Carga "
	oSection2:SetTotalInLine(.F.)
	oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection2,"GWW_NRDC"  ,"GWW",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GWW_EMISDC","GWW",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GWW_SERDC" ,"GWW",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GWW_CDTPDC","GWW",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	oSection3 := TRSection():New(oSection1,STR0004,{"GVD"},aOrdem) //"Endereço Mercadoria"
	oSection3:SetTotalInLine(.F.)
	oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection3,"GVD_CDENDE","GVD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GVD_DSENDE","GVD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GVD_SENTID","GVD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GVD_IDOCUP","GVD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GVD_QTPOFI","GVD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  
	
	oSection4 := TRSection():New(oSection1,STR0005,{"GUU"},aOrdem) //"Motoristas e Ajudantes"
	oSection4:SetTotalInLine(.F.)
	oSection4:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection4,"GUU_CDMTR","GUU",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection4,"GUU_NMMTR","GUU",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection4,"GUU_TPMTR","GUU",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	oSection5 := TRSection():New(oSection1,STR0006,{"GVE"},aOrdem) //"Agendamento Visitante"
	oSection5:SetTotalInLine(.F.)
	oSection5:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection5,"GVE_CDVISI","GVE",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"GVE_NMVISI","GVE",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	oSection6 := TRSection():New(oSection1,STR0007,{"GV3"},aOrdem) //"Tipo Veículo"
	oSection6:SetTotalInLine(.F.)
	oSection6:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection6,"GV3_CDTPVC","GV3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection6,"GV3_DSTPVC","GV3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection6,"GV3_EIXOS" ,"GV3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection6,"GV3_CARGUT","GV3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection6,"GV3_POSCOM","GV3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

	oSection7 := TRSection():New(oReport,"Total Agendamentos",{"GWV"},aOrdem) //"Total Agendamentos"
	oSection7:SetTotalInLine(.F.)
	oSection7:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection7,"nTotAgend"	,"", "Total Agendamentos",	"9999999",	7,/*lPixel*/,{|| Transform(nTotAgend,"@E 9999999") })
	TRCell():New(oSection7,"nQtdInd"	,"", "Indeterminado",		"9999999",	7,/*lPixel*/,{|| Transform(nQtdInd,"@E 9999999") })
	TRCell():New(oSection7,"nPerInd"	,"", "% Indeterminado",		"999",		3,/*lPixel*/,{|| nPerInd })
	TRCell():New(oSection7,"nQtdAtraso","", "Qtd Atrasado",			"9999999",	7,/*lPixel*/,{|| Transform(nQtdAtraso,"@E 9999999") })
	TRCell():New(oSection7,"nPerAtraso","", "% Atrasado",			"999",		3,/*lPixel*/,{|| nPerAtraso })
	TRCell():New(oSection7,"nQtdAdiant","", "Qtd Adiantado",		"9999999",	7,/*lPixel*/,{|| Transform(nQtdAdiant,"@E 9999999") })
	TRCell():New(oSection7,"nPerAdiant","", "% Adiantado",			"999",		3,/*lPixel*/,{|| nPerAdiant })
	TRCell():New(oSection7,"nQtdHora"	,"", "Qtd no horário",		"9999999",	7,/*lPixel*/,{|| Transform(nQtdHora,"@E 9999999") })
	TRCell():New(oSection7,"nPerHora"	,"", "% no horário",			"999",		3,/*lPixel*/,{|| nPerHora })
//
Return(oReport)

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.         
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório
//---------------------------------------------------------------------------
//Uso  GFER510                                                    
//---------------------------------------------------------------------------

Static Function ReportPrint(oReport)
	Local oSection1  := oReport:Section(1)
	Local oSection2  := oSection1:Section(1)
	Local oSection3  := oSection1:Section(2)
	Local oSection4  := oSection1:Section(3)
	Local oSection5  := oSection1:Section(4)
	Local oSection6  := oSection1:Section(5)
	Local oSection7  := oReport:Section(2)

	Local cSit 	:= STR(MV_PAR13)
	Local nMin 	:= 0
	Local nMinNeg := 0
	Local nMinPos := 0
	Local nMinDif	:= 0
	Local dtEnt
	Local hrEnt
	Local dtAge
	Local hrAge


	//----------------------------------------------------------
	//Seta regua de processamento
	//----------------------------------------------------------
	oReport:SetMeter (GWV->(LastRec()))

	dbSelectArea("GWV")
	GWV->( dbSetOrder(1) )
	GWV->( dbSeek(xFilial("GWV") + MV_PAR01,.T.) )
	While !oReport:Cancel() .And. GWV->( !Eof() ) .And. xFilial("GWV") == GWV->GWV_FILIAL .And. GWV->GWV_NRAGEN <= MV_PAR02

		If	GWV->GWV_CDEMIT >= MV_PAR03 .And. GWV->GWV_CDEMIT <= MV_PAR04 .And.;
			GWV->GWV_CDOPER >= MV_PAR05 .And. GWV->GWV_SEQ >= MV_PAR07 .And. GWV->GWV_CDOPER <= MV_PAR06 .And. GWV->GWV_SEQ <= MV_PAR08 .And.;			
			GWV->GWV_DTAGEN >= MV_PAR09 .And. GWV->GWV_DTAGEN <= MV_PAR10 .And. GWV->GWV_HRAGEN >= MV_PAR11 .And. GWV->GWV_HRAGEN <= MV_PAR12

			If GWV->GWV_SIT $ cSit
				oSection1:Init()

				nTotAgend 	+= 1
				nQtdInd	+= 1
				cPont 		:= ""

				If GWV->GWV_SIT != "2"
					cPont := "Indeterminado"	// caso o agendamento não esteja na situação Concluído
				Else
					If GWV->GWV_NRMOV != ""

						dbSelectArea("GX4")
						GX4->( dbSetOrder(4) ) // GX4_FILIAL+GX4_NRMOV+GX4_SEQ+GX4_CDPTCT
						If GX4->( dbSeek(xFilial("GX4") + GWV->GWV_NRMOV + "001" ) )
							dtEnt := GX4->GX4_DTENTR
							hrEnt := GX4->GX4_HRENTR
							dtAge := GWV->GWV_DTAGEN
							hrAge := GWV->GWV_HRAGEN
						EndIf

						If !Empty(dtEnt) .And. !Empty(hrEnt) .And. !Empty(dtAge) .And. !Empty(hrAge)

							// Limites de atraso e adiantamento
							nMinNeg := Posicione("GVI",1,xFilial("GVI") + GWV->GWV_CDOPER + GWV->GWV_SEQ,"GVI_QTHRNE")
							nMinPos := Posicione("GVI",1,xFilial("GVI") + GWV->GWV_CDOPER + GWV->GWV_SEQ,"GVI_QTHRPO")

							If Val(hrAge) < Val(hrEnt)
								// Converte as horas em minutos
								nMin := Val(SubStr(ElapTime(AllTrim(Stuff(hrAge,3,0,":"))+":00",AllTrim(Stuff(hrEnt,3,0,":"))+":00"),1,2))
								nMin := nMin * 60
								// Converte as horas em minutos

								// Soma os minutos restantes
								nMin += Val(SubStr(ElapTime(AllTrim(Stuff(hrAge,3,0,":"))+":00",AllTrim(Stuff(hrEnt,3,0,":"))+":00"),4,2))
							Else
								// Converte as horas em minutos
								nMin := Val(SubStr(ElapTime(AllTrim(Stuff(hrEnt,3,0,":"))+":00",AllTrim(Stuff(hrAge,3,0,":"))+":00"),1,2))
								nMin := nMin * 60
								// Converte as horas em minutos

								// Soma os minutos restantes
								nMin += Val(SubStr(ElapTime(AllTrim(Stuff(hrEnt,3,0,":"))+":00",AllTrim(Stuff(hrAge,3,0,":"))+":00"),4,2))
							EndIf

					 		If	( dtAge == dtEnt .And. Val(hrAge) < Val(hrEnt) ) .Or. dtAge < dtEnt

								nMinDif := ( ( (dtEnt - dtAge) * 24 ) * 60 ) + nMin

								If nMinDif <= nMinNeg
									cPont := "No horário"
								Else
									cPont := "Atrasado"
								EndIf

							ElseIf	( dtAge == dtEnt .And. Val(hrAge) > Val(hrEnt) ) .Or. ;
					            	  dtAge > dtEnt

								nMinDif := ( ( (dtAge - dtEnt) * 24 ) * 60 ) + nMin

								If nMinDif <= nMinPos
									cPont := "No horário"
								Else
									cPont := "Adiantado"
								EndIf

					       EndIf

						EndIf

					EndIf
				EndIf
		
				oSection1:PrintLine()
				
				If MV_PAR14 == 2
					
					dbSelectArea("GWW")
					GWW->(dbSetOrder(1))
					If GWW->(dbSeek(xFilial("GWW")+GWV->GWV_NRAGEN))
						oSection2:Init()
						While !oReport:Cancel() .And. GWW->(!Eof()) .And. xFilial("GWW") == GWW->GWW_FILIAL .And. GWW->GWW_NRAGEN == GWV->GWV_NRAGEN
							oSection2:PrintLine()
							
							dbSelectArea("GWW")
							dbSkip()
						EndDo    
						oSection2:Finish()
					EndIf
					
					dbSelectArea("GWX")
					GWX->(dbSetOrder(1))
					If GWX->(dbSeek(xFilial("GWX")+GWV->GWV_NRAGEN))
						dbSelectArea("GVD")
						GVD->(dbSetOrder(1))
						
						oSection3:Init()
						
						While !oReport:Cancel() .And. GWX->(!Eof()) .And. xFilial("GWX") == GWX->GWX_FILIAL .And. GWX->GWX_NRAGEN== GWV->GWV_NRAGEN
							If GVD->(dbSeek(xFilial("GVD")+GWX->GWX_CDENDE))
								While !oReport:Cancel() .And. GVD->(!Eof()) .And. xFilial("GVD") == GVD->GVD_FILIAL .And. GVD->GVD_CDENDE == GWX->GWX_CDENDE
									oSection3:PrintLine()                                                                                                
									GVD->(dbSkip())
								EndDo
							EndIf				
							
							GWX->(dbSkip())
						EndDo    
						oSection3:Finish()
					EndIf
					
					dbSelectArea("GX1")
					GX1->(dbSetOrder(1))
					If GX1->(dbSeek(xFilial("GX1")+GWV->GWV_NRAGEN))
						oSection4:Init()
						While !oReport:Cancel() .And. GX1->(!Eof()) .And. xFilial("GX1") == GX1->GX1_FILIAL .And. GX1->GX1_NRAGEN == GWV->GWV_NRAGEN
							dbSelectArea("GUU")
							GUU->(dbSetOrder(1))
							GUU->(dbSeek(xFilial("GUU")+GX1->GX1_CDMTR))
							While !oReport:Cancel() .And. GUU->(!Eof()) .And. xFilial("GUU") == GUU->GUU_FILIAL .And. GUU->GUU_CDMTR == GX1->GX1_CDMTR
								oSection4:PrintLine()

								GUU->(dbSkip())
							EndDo				

							GX1->(dbSkip())
						EndDo
						    
						oSection4:Finish()
					EndIf
					
					oSection5:Init()
					dbSelectArea("GWZ")
					dbSetOrder(1)
					dbSeek(xFilial("GWZ")+GWV->GWV_NRAGEN)
					While !oReport:Cancel() .And. !Eof() .And. xFilial("GWZ") == GWZ->GWZ_FILIAL .And. GWZ->GWZ_NRAGEN == GWV->GWV_NRAGEN
						dbSelectArea("GVE")
						dbSetOrder(1)
						dbSeek(xFilial("GVE")+GWZ->GWZ_CDVISI)  
						While !oReport:Cancel() .And. !Eof() .And. xFilial("GVE") == GVE->GVE_FILIAL .And. GVE->GVE_CDVISI == GWZ->GWZ_CDVISI

							oSection5:PrintLine()                   

							dbSelectArea("GVE")
							dbSkip()
						EndDo				
						dbSelectArea("GWZ")
						dbSkip()
					EndDo    
					oSection5:Finish() 
					
					oSection6:Init()
					dbSelectArea("GWY")
					dbSetOrder(1)
					dbSeek(xFilial("GWY")+GWV->GWV_NRAGEN)
					While !oReport:Cancel() .And. !Eof() .And. xFilial("GWY") == GWY->GWY_FILIAL .And. GWY->GWY_NRAGEN == GWV->GWV_NRAGEN
						dbSelectArea("GV3")
						dbSetOrder(1)
						dbSeek(xFilial("GV3")+GWY->GWY_CDTPVC)
						While !oReport:Cancel() .And. !Eof() .And. xFilial("GV3") == GV3->GV3_FILIAL .And. GV3->GV3_CDTPVC == GWY->GWY_CDTPVC
							oSection6:PrintLine()     

							dbSelectArea("GV3")
							dbSkip()
						EndDo				
						dbSelectArea("GWY")
						dbSkip()
					EndDo    
					oSection6:Finish()   			

					oReport:SkipLine()
					oReport:SkipLine()
					oReport:SkipLine()
				EndIf
							
				oSection1:Finish()
			EndIf		
		EndIf

		GWV->(dbSkip())	                                                                           			
	EndDo
	
	nPerAtraso	:= (nQtdAtraso * 100) / nTotAgend
	nPerAdiant	:= (nQtdAdiant * 100) / nTotAgend
	nPerHora	:= (nQtdHora * 100) / nTotAgend
	nPerInd	:= (nQtdInd * 100) / nTotAgend
	
	oSection7:Init()
	oSection7:PrintLine()     
	oSection7:Finish()   			
	
	//----------------------------------------------------------
	// Finaliza utilizacao das sections e fecha area temporaria 
	//----------------------------------------------------------
Return
