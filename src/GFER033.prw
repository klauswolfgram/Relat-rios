/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFER033.ch"
#INCLUDE "PROTHEUS.CH" 

//-------------------------------------------------------------------
/*/{Protheus.doc} GFER033    

Relatório de Ocorrências 

@author Luiz Fernando Soares
@since 16/03/10
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFER033()


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
//Uso       GFER033                                                    
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

oReport:= TReport():New("GFER033",STR0001,"GFER033", {|oReport| ReportPrint(oReport)},".")  //"Ocorrências"
oReport:SetLandscape()
oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
oReport:SetTotalInLine(.F.)
Pergunte("GFER033",.F.)
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

Aadd( aOrdem, STR0002 ) // "Sequência" //"Ocorrencia"

oSection1 := TRSection():New(oReport,STR0003,{"GU5"},aOrdem) // "Contrato com Autônomo" //"Tipos de Ocorrências"
oSection1:SetLineStyle() //Define a impressao da secao em linha
oSection1:SetTotalInLine(.F.)

TRCell():New(oSection1,"GU5_CDTIPO" ,"GU5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GU5_DESC"   ,"GU5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection2 := TRSection():New(oSection1,STR0004,{"GU4"},aOrdem) //"Motivos"
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção

TRCell():New(oSection2,"GU4_CDMOT"  ,"GU4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"cDescMot"   ,""   ,""        ,/*Picture*/,  20         ,/*lPixel*/,                     {||cDescMot})

oSection3 := TRSection():New(oSection1,STR0001,{"GWD"},aOrdem) // "Valores Adicionais"  //"Ocorrências"
oSection3:SetTotalInLine(.F.)
oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
TRCell():New(oSection3,"GWD_FILIAL" ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GWD_NROCO"  ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GWD_DSOCOR" ,"GWD",/*cTitle*/,/*Picture*/,  30 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GWD_DTOCOR" ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GWD_HROCOR" ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GWD_DTCRIA" ,"GWD",/*cTitle*/,/*Picture*/,  10 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GWD_HRCRIA" ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GWD_DTBAI"  ,"GWD",/*cTitle*/,/*Picture*/,  10 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GWD_HRBAI"  ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GWD_SIT"    ,"GWD",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)



Return(oReport)

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.         
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório                          
//---------------------------------------------------------------------------
//Uso  GFER033                                                  
//---------------------------------------------------------------------------

Static Function ReportPrint(oReport)
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local oSection3  := oReport:Section(1):Section(2)
local cCodTipo,cCodMot
                   
Private cDescTipo     //Desc Tipo
Private cDescMot      //Desc Motivo
//----------------------------------------------------------
//Seta regua de processamento
//----------------------------------------------------------
oReport:SetMeter (GU5->(LastRec()))

oSection1:Init() 

dbselectarea("GU5")
dbsetorder(1)
dbseek(xFilial("GU5"),.T.)
While !oReport:Cancel() 	.And. !Eof() .And. GU5->GU5_FILIAL == xFilial("GU5")
	IF GU5->GU5_CDTIPO >= MV_PAR01 .And. GU5->GU5_CDTIPO <= MV_PAR02
		
	   //	oReport:FatLine() /*Imprime uma linha no inicio de cada contrato*/ 		
		 
		
		dbselectarea("GU4")
		dbsetorder(2)
		dbseek(xFilial("GU4")+GU5->GU5_CDTIPO,.T.)    
		While !oReport:Cancel() 	.And. !Eof() .And. GU5->GU5_FILIAL == xFilial("GU5").and. GU5->GU5_CDTIPO == GU4->GU4_CDTIPO
			IF GU4->GU4_CDMOT  >= MV_PAR03 .And. GU4->GU4_CDMOT  <= MV_PAR04 
				cDescMot     := POSICIONE("GU6",1,xFilial("GU6")+GU4->GU4_CDMOT ,"GU6_DESC")			
				
				
				dbselectarea("GWD")
				dbsetorder(2)
				dbseek(xFilial("GWD")+GU5->GU5_CDTIPO + GU4->GU4_CDMOT,.T.) 				 
				While !oReport:Cancel() 	.And. !Eof() .And. GWD->GWD_FILIAL == xFilial("GWD");
											.And. GWD->GWD_CDTIPO              	== GU4->GU4_CDTIPO;
											.And. GWD->GWD_CDMOT 				== GU4->GU4_CDMOT
				
					if   GWD->GWD_NROCO  >= MV_PAR05 .And. GWD->GWD_NROCO  <= MV_PAR06;
						.And. GWD->GWD_DTOCOR >= MV_PAR07 .And. GWD->GWD_DTOCOR <= MV_PAR08
						
						if cCodTipo <> GWD->GWD_CDTIPO
							oReport:SkipLine()		
							oReport:SkipLine()
							oReport:IncMeter() 
							oSection1:PrintLine()
							cCodTipo :=  GWD->GWD_CDTIPO
							cCodMot := "   "
						endif
						if cCodMot <> GWD->GWD_CDMOT
							oSection2:Init()
							oSection2:PrintLine()
							oReport:FatLine() /*Imprime uma linha no inicio de cada contrato*/ 
							cCodMot := GWD->GWD_CDMOT
						endif          
						
						oSection3:Init()
						oSection3:PrintLine() 
											
					endif  
					dbSelectArea("GWD")
					dbSkip()                                                                         			
				End
				oSection3 :Finish()
			ENDIF
			dbSelectArea("GU4")
			dbSkip() 
		END
	ENDIF
	
	oSection2 :Finish()
	
	dbSelectArea("GU5")
	dbSkip() 
END

//----------------------------------------------------------
// Finaliza utilizacao das sections e fecha area temporaria 
//----------------------------------------------------------
oSection1 :Finish()

Return
