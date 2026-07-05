/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFER100.ch"
#INCLUDE "PROTHEUS.CH" 

//-------------------------------------------------------------------
/*/{Protheus.doc} GFER100    

Relatório de Contrato Autônomo

@author Jorge Matos Valcanaia
@since 16/03/10
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFER100()


Local oReport
Local aArea := GetArea()

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
//Uso       GFER100                                                    
//---------------------------------------------------------------------------

Static Function ReportDef()                                                                      	
Local oReport, oSection1
Local aOrdem    := {} 


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

oReport:= TReport():New("GFER100",STR0001,"GFER100", {|oReport| ReportPrint(oReport)},".")  //"Contrato Autônomo"
oReport:SetLandscape()
oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
oReport:SetTotalInLine(.F.)
Pergunte("GFER100",.F.)

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

Aadd( aOrdem, STR0002 ) // "Sequência" //"Codigo"

oSection1 := TRSection():New(oReport,STR0003,{"GW2"},aOrdem) // "Contrato com Autônomo" //"Contrato com Autônomo"
oSection1:SetLineStyle() //Define a impressao da secao em linha
oSection1:SetTotalInLine(.F.)
TRCell():New(oSection1,"GW2_FILIAL" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_NRCONT" ,"GW2",/*cTitle*/,/*Picture*/, 10 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_CDPROP" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cNmProp"    ,""   ,STR0004  ,/*Picture*/,  40        ,/*lPixel*/,                    {||cNmProp}) //"Nome Prop"
TRCell():New(oSection1,"GW2_SITCON" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_DTCRIA" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_DTVENC" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_DTCANC" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_SITFIN" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_SITRH"  ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_CDMTR"  ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cNmMtr"     ,""   ,STR0005  ,/*Picture*/,  50        ,/*lPixel*/,                {||cNmMtr}) //"Nome Motorista"
TRCell():New(oSection1,"GW2_CDVEI1" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cPlacaVei1" ,"XXX-XXXX"   ,STR0006  ,/*Picture*/ ,  8        ,/*lPixel*/,             {||cPlacaVei1}) //"Placa"
TRCell():New(oSection1,"GW2_CDVEI2" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cPlacaVei2" ,"XXX-XXXX"   ,STR0006  ,/*Picture*/ ,  8        ,/*lPixel*/,             {||cPlacaVei2}) //"Placa"
TRCell():New(oSection1,"GW2_CDVEI3" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cPlacaVei3" ,"XXX-XXXX"   ,STR0006  ,/*Picture*/ ,  8        ,/*lPixel*/,             {||cPlacaVei3}) //"Placa"
TRCell():New(oSection1,"GW2_CIDORI" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cNmCidOri"  ,"XXX-XXXX"   ,STR0007  ,/*Picture*/ ,  50        ,/*lPixel*/,          {||cNmCidOri}) //"Nome Cid"
TRCell():New(oSection1,"GW2_CIDDES" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cNmcidDes"  ,"XXX-XXXX"   ,STR0007  ,/*Picture*/ ,  50        ,/*lPixel*/,          {||cNmcidDes}) //"Nome Cid"
TRCell():New(oSection1,"GW2_VLFRET" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_VLADIC" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_VLDESC" ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_VLIMP"  ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW2_VLLIQ"  ,"GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)


oSection2 := TRSection():New(oSection1,STR0008,{"GVB"},aOrdem) // "Valores Adicionais"  //"Valores Adicionais"
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
TRCell():New(oSection2,"GW5_CDVLAD" ,"GW5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GW5_OPERAC" ,"GW5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GW5_VALOR"  ,"GW5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GW5_BASIRR" ,"GW5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GW5_BASINS" ,"GW5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GW5_BASISS" ,"GW5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GW5_BASEST" ,"GW5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)


oSection3 := TRSection():New(oSection1,STR0003,{"GW2"},aOrdem) // "Contrato com Autônomo" //"Contrato com Autônomo"
oSection3:SetTotalInLine(.F.)
oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
TRCell():New(oSection3,"GW2_VLINOE","GW2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GW2_INSSPE","GW2",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, /*{|| Tabela("L4",(cAliasQry)->DTW_SERVIC,.F.) }*/ )
TRCell():New(oSection3,"GW2_VLREIR","GW2",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, /*{|| Tabela("L4",(cAliasQry)->DTW_SERVIC,.F.) }*/ )
TRCell():New(oSection3,"GW2_VLSEST","GW2",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, /*{|| Tabela("L4",(cAliasQry)->DTW_SERVIC,.F.) }*/ )
TRCell():New(oSection3,"GW2_VLINSS","GW2",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, /*{|| Tabela("L4",(cAliasQry)->DTW_SERVIC,.F.) }*/ )
TRCell():New(oSection3,"GW2_VLINEM","GW2",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, /*{|| Tabela("L4",(cAliasQry)->DTW_SERVIC,.F.) }*/ )
TRCell():New(oSection3,"GW2_VLISS" ,"GW2",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, /*{|| Tabela("L4",(cAliasQry)->DTW_SERVIC,.F.) }*/ )
TRCell():New(oSection3,"GW2_VLBAIR","GW2",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, /*{|| Tabela("L4",(cAliasQry)->DTW_SERVIC,.F.) }*/ )


oSection4:= TRSection():New(oSection1,STR0009,{"GWF"},aOrdem) // "Cálculo de Frete" //"Cálculo de Frete"
oSection4:SetTotalInLine(.F.)
oSection4:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
TRCell():New(oSection4,"GWF_NRCALC","GWF",/*cTitle*/,/*Picture*/,  10 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"GWF_DTCRIA","GWF",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"GWF_TPFRET","GWF",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"GWF_EMIREM","GWF",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New(oSection4,"cNmEmiRem" ,"XXX-XXXX"   ,STR0010  ,/*Picture*/ ,  30        ,/*lPixel*/,          {||cNmEmiRem}) //"Nome Rem"
TRCell():New(oSection4,"GWF_EMIDES","GWF",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"cNmEmiDes" ,"XXX-XXXX"   ,STR0011  ,/*Picture*/ ,  30        ,/*lPixel*/,          {||cNmEmiDes})   //"Nome Des"
TRCell():New(oSection4,"nVlFrete"  ,"999,999,999.99"   ,STR0012  ,/*Picture*/ ,  15        ,/*lPixel*/,  {||nVlFrete}) //"Valor Frete"

oSection5 := TRSection():New(oSection1,"Rateio Contábil",{"GW9"},aOrdem) // "Contrato com Autônomo" //"Contrato com Autônomo"
oSection5:SetTotalInLine(.F.)
oSection5:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
TRCell():New(oSection5,"GW9_SEQ","GW9",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"GW9_CTACTB","GW9",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"GW9_CCUSTO","GW9",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"GW9_LANCTO","GW9",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"GW9_TRANS","GW9",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.         
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório                          
//---------------------------------------------------------------------------
//Uso  GFER100                                                  
//---------------------------------------------------------------------------

Static Function ReportPrint(oReport)
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local oSection3  := oReport:Section(1):Section(2)
Local oSection4  := oReport:Section(1):Section(3) 
Local oSection5  := oReport:Section(1):Section(4)               

Private cNmProp     //Nome Proprietario
Private cNmMtr      //Nome Motorista
Private cPlacaVei1  //Placa Veiculo 1
Private cPlacaVei2  //Placa Veiculo 2
Private cPlacaVei3  //Placa Veiculo 3 
Private cNmCidOri   //Nome Cidade Origem
Private cNmcidDes   //Nome Cidade Destino
Private cNmEmiRem   //Nome Remetente
Private cNmEmiDes   //Nome Destinatario
Private nVlFrete    //Valor Do Cálculo do frete

//----------------------------------------------------------
//Seta regua de processamento
//----------------------------------------------------------
oReport:SetMeter (GW2->(LastRec()))

oSection1:Init()

dbselectarea("GW2")
dbsetorder(1)
dbseek(xFilial("GW2")+MV_PAR05,.T.)    
While !oReport:Cancel() .And. !Eof() .And. GW2->GW2_FILIAL == xFilial("GW2") .And. GW2->GW2_NRCONT <= MV_PAR06 	
     
	If GW2->GW2_DTCRIA >= MV_PAR03 .And. GW2->GW2_DTCRIA <= MV_PAR04 .And. GW2->GW2_CDPROP >= MV_PAR01 .And. GW2->GW2_CDPROP <= MV_PAR02

		cNmProp    := POSICIONE("GU3",1,xFilial("GU3")+GW2->GW2_CDPROP,"GU3_NMEMIT") 
		cNmMtr     := POSICIONE("GUU",1,xFilial("GUU")+GW2->GW2_CDMTR ,"GUU_NMMTR" )                
		cPlacaVei1 := POSICIONE("GU8",1,xFilial("GU8")+GW2->GW2_CDVEI1,"GU8_PLACA" )  
		cPlacaVei2 := POSICIONE("GU8",1,xFilial("GU8")+GW2->GW2_CDVEI2,"GU8_PLACA" )     
		cPlacaVei3 := POSICIONE("GU8",1,xFilial("GU8")+GW2->GW2_CDVEI3,"GU8_PLACA" ) 
		cNmCidOri  := POSICIONE("GU7",1,xFilial("GU7")+GW2->GW2_CIDORI,"GU7_NMCID" ) 
		cNmcidDes  := POSICIONE("GU7",1,xFilial("GU7")+GW2->GW2_CIDDES,"GU7_NMCID" ) 
		
			oSection2:Init() 
			oSection3:Init()   
			oSection4:Init()  
	  
		oReport:FatLine() /*Imprime uma linha no inicio de cada contrato*/
		oReport:IncMeter()
		oSection1:PrintLine()    
			
		dbSelectArea("GW5")
		dbSetOrder(1)
		If dbSeek(xFilial("GW5")+GW2->GW2_NRCONT)
		    oReport:PrintText(STR0008,,300) /*Imprime o identificador dos Valores Adicionais*/ //"Valores Adicionais"
			While !oReport:Cancel() .And. !Eof() .And. GW5->GW5_FILIAL == xFilial("GW5") .And. GW5->GW5_NRCONT == GW2->GW2_NRCONT
			    
			    oSection2:PrintLine()
			
				dbSelectArea("GW5")
				dbSkip()
			EndDo     
		Endif
	
	   	oReport:SkipLine() /*Pula uma linha apos a impressao de Valores*/
	    oReport:PrintText(STR0013,,300)	/*Imprime o identificador dos Impostos*/ //"Impostos"
	    oSection3:PrintLine()                        
	     
	    dbSelectArea("GWF")
	    dbSetOrder(2)
	    If dbSeek(xFilial("GWF")+GW2->GW2_NRCONT)	                    
		   	oReport:SkipLine()
		    oReport:PrintText(STR0014,,300)	/*Imprime o identificador dos Cálculos relacionados*/	     //"Cálculos Relacionados"
		    While !oReport:Cancel() .And. !Eof() .And. GWF->GWF_FILIAL == xFilial("GWF") .And. GWF->GWF_NRCONT == GW2->GW2_NRCONT  
	
			    cNmEmiRem := POSICIONE("GU3",1,xFilial("GU3")+GWF->GWF_EMIREM,"GU3_NMEMIT" )	  
			    cNmEmiDes := POSICIONE("GU3",1,xFilial("GU3")+GWF->GWF_EMIDES,"GU3_NMEMIT" )	 
			    nVlFrete  := VLTOTFRET(GWF->GWF_NRCALC)
			    oSection4:PrintLine()
		    	
		    	dbSelectArea("GWF")
		    	dbSkip()
		    EndDo
	    Endif
			               
		oSection4 :Finish()
		oSection3 :Finish()	
		oSection2 :Finish()	 
		
		oReport:PrintText("Rateio Contábil",,300)	/*Imprime o identificador dos Rateio Contábil*/    
		
		oSection5:Init()
		
		dbselectarea("GW9")
		dbsetorder(1)
		If dbSeek(xFilial("GW9") + GW2->GW2_NRCONT)
			oSection5:Init()  		
			While !oReport:Cancel() .And. !EOF() .AND. GW9->GW9_FILIAL == xFilial("GW9") .AND. GW9->GW9_NRCONT == GW2->GW2_NRCONT
				
							
				oSection5:PrintLine()
				
				
				DBSELECTAREA("GW9")
				DBSKIP()
			
			ENDDO
		
			oSection5:Finish()
		EndIf
		
		oReport:SkipLine()
		oReport:SkipLine()
	
	Endif							
	dbSelectArea("GW2")
	dbSkip()                                                                           			
End

//----------------------------------------------------------
// Finaliza utilizacao das sections e fecha area temporaria 
//----------------------------------------------------------
oSection1 :Finish()

Return
