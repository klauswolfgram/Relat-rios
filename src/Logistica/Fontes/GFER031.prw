/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFER031.ch"
#INCLUDE "PROTHEUS.CH" 

//-------------------------------------------------------------------
/*/{Protheus.doc} GFER031    

Relatório de Contrato Autônomo

@author Luiz Fernando Soares
@since 16/03/10
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFER031()                                	
                                                       

Local oReport
Local aArea := GetArea()

If  TRepInUse()
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
//Uso       GFER031                                                    
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

oReport:= TReport():New("GFER031",STR0001,"GFER031", {|oReport| ReportPrint(oReport)},".")  //"Documentos com Ocorrência"
oReport:SetLandscape()
oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
oReport:SetTotalInLine(.F.)
Pergunte("GFER031",.F.)
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

oSection1 := TRSection():New(oReport,STR0003,{"GWD"},aOrdem) // "Contrato com Autônomo" //"Ocorrencias"
oSection1:SetLineStyle() //Define a impressao da secao em linha
oSection1:SetTotalInLine(.F.)
TRCell():New(oSection1,"GWD_NROCO"  ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cDsOco"     ,""   ,STR0004  ,/*Picture*/,   20     ,/*lPixel*/,                     {||cDsOco  }) //"Descrição"
//TRCell():New(oSection2,"GWD_DSOCO"  ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWD_CDTIPO" ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cDsTpOco"   ,""   ,STR0004  ,/*Picture*/,   20     ,/*lPixel*/,                     {||cDsTpOco}) //"Descrição"
TRCell():New(oSection1,"GWD_CDMOT"  ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cDsMotOco"   ,""   ,STR0004  ,/*Picture*/,  20     ,/*lPixel*/,                    {||cDsMotOco}) //"Descrição"
TRCell():New(oSection1,"GWD_DTCRIA" ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWD_HRCRIA" ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWD_DSPROB" ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWD_DSSOLU" ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWD_SIT"    ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  
TRCell():New(oSection1,"nVLFrete"   ,""   ,"Valor Frete","@E 999,999.99"/*Picture*/,  12     ,/*lPixel*/, {||nVLFrete}) 


Return(oReport)

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.         
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório                          
//---------------------------------------------------------------------------
//Uso  GFER031                                                  
//---------------------------------------------------------------------------

Static Function ReportPrint(oReport)
Local oSection1  := oReport:Section(1)


//Local oSection3  := oReport:Section(1):Section(2)
//Local oSection4  := oReport:Section(1):Section(3)
                   

Private cDescTipo   //Descrição do tipo do DC
Private cNmRem      //Nome Remetente
Private cNmDest     //Nome Destinatario
Private cDsTpOco    //Descrição do Tipo de Ocorrencia
Private cDsMotOco   //Descricao do Motivo de Ocorrencia
Private cNmTransp
Private cCodTransp   
Private nVLFrete := 0 
//----------------------------------------------------------
//Seta regua de processamento
//----------------------------------------------------------
oReport:SetMeter (GWD->(LastRec()))

oSection1:Init()

dbselectarea("GWD")
dbsetorder(1)
dbseek(xFilial("GWD"),.T.)    
While !oReport:Cancel()  	.And. !Eof() .And. GWD->GWD_FILIAL == xFilial("GWD")
		
		
		if    GWD->GWD_NROCO  >= MV_PAR01 .And. GWD->GWD_NROCO    <= MV_PAR02;
		.And. GWD->GWD_DTOCOR >= MV_PAR03 .And. GWD->GWD_DTOCOR   <= MV_PAR04;	
		.And. GWD->GWD_CDTIPO >= MV_PAR07 .And. GWD->GWD_CDTIPO   <= MV_PAR08;
		.And. GWD->GWD_CDMOT  >= MV_PAR09 .And. GWD->GWD_CDMOT    <= MV_PAR10;
		.And. GWD->GWD_SIT    == cValToChar(MV_PAR11);
		.And. UPPER(GWD->GWD_USUBAI) >= MV_PAR12 .And. UPPER(GWD->GWD_USUBAI)   <= MV_PAR13;
		.and. (cValToChar(MV_PAR11) == "1" .or. (GWD->GWD_DTBAI  >= MV_PAR05 .And. GWD->GWD_DTBAI  <= MV_PAR06))
		
			
		
			cDsTpOco   := POSICIONE("GU5",1,xFilial("GU5")+GWD->GWD_CDTIPO,"GU5_DESC")
			cDsMotOco  := POSICIONE("GU6",1,xFilial("GU6")+GWD->GWD_CDMOT ,"GU6_DESC")
			cDsOco     := GWD->GWD_DSOCOR		    
		    
		    nVLFrete := 0							
		    dbSelectArea("GWF")
		    dbSetOrder(5)
			If dbSeek(xFilial("GWF")+GWD->GWD_NROCO)
				While !Eof() .and. GWD->GWD_NROCO == GWF->GWF_NROCO			
					nVLFrete := nVLFrete + GFEVlrFrete(1, {GWF->GWF_FILIAL, GWF->GWF_NRCALC})[1]
				
					
					dbSelectArea("GWf")
					dbSkip() 
				EndDo
			EndIf  
						
			oSection1:PrintLine()
		  oReport:FatLine() //Imprime uma linha no inicio de cada contrato
		  oReport:IncMeter()				               	
			oReport:SkipLine()
		endif
				
	  
	dbSelectArea("GWD")
	dbSkip()                                                                         			
End

//----------------------------------------------------------
// Finaliza utilizacao das sections e fecha area temporaria 
//----------------------------------------------------------
oSection1 :Finish()

Return
