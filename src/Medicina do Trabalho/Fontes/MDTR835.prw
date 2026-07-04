/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR835.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 2 //Versao do fonte
  
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR835
Relatorio dos Acidentes de Trabalhos ocorridos no periodo.  
O usuario pode selecionar o periodo, o centro de custo, a  
funcao, objeto causador.                                  
Tambem podera selecionar todos ou apenas os acidentes cujo a
a CAT nao foi Impressa, bem como obter detalhes dos custos  
com os acidentes.   

@author  Thiago Machado
@since 18.08.00 
@return .T.  
/*/ 
//---------------------------------------------------------------------
User Function MDTR835()
//------------------------------------------------------------------------
// Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  
//------------------------------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)  

Local oReport  
Local aArea := GetArea()

Private cPerg := ""
Private lRelPer  := .T.
PRIVATE nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
PRIVATE nSizeTNG := If((TAMSX3("TNG_TIPACI")[1]) < 1,12,(TAMSX3("TNG_TIPACI")[1]))
PRIVATE oTempTNC

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
cPerg    :=If(!lSigaMdtps,"MDT835    ","MDT835PS  ")
  
/*--------------------------------------------
//PERGUNTAS PADRÃO  								|
|MDT835    ¦01      ¦De  Acidente ?			|
|MDT835    ¦02      ¦Ate Acidente ?			|
|MDT835    ¦03      ¦De Data de Acidente ?	|
|MDT835    ¦04      ¦Ate Data Acidente ?		|
|MDT835    ¦05      ¦De  Centro de Custo ?	|
|MDT835    ¦06      ¦Ate Centro de Custo ?	|
|MDT835    ¦07      ¦De Funcao ?				|
|MDT835    ¦08      ¦Ate Funcao ?				|
|MDT835    ¦09      ¦Todos ?					|
|MDT835    ¦10      ¦Listar Despesas ?			|
|MDT835    ¦11      ¦De Tipo Acidente ?		|
|MDT835    ¦12      ¦Ate Tipo Acidente ?		|
|MDT835    ¦13      ¦De  Ficha Medica ?		|
|MDT835    ¦14      ¦Ate Ficha Medica ? 		|
|													|
//PERGUNTAS PRESTADOR DE SERVIÇO				|
|	01       De Cliente ?						|
|	02       Loja									|
|	03       Até Cliente ?						|
|	04       Loja									|
|	MDT835    ¦05      ¦De  Acidente ?			|
|	MDT835    ¦06      ¦Ate Acidente ?			|
|	MDT835    ¦07      ¦De Data de Acidente ?	|
|	MDT835    ¦08      ¦Ate Data Acidente ?	|
|	MDT835    ¦09      ¦De  Centro de Custo ?	|
|	MDT835    ¦10      ¦Ate Centro de Custo ?	|
|	MDT835    ¦11      ¦De Funcao ?				|
|	MDT835    ¦12      ¦Ate Funcao ?			|
|	MDT835    ¦13      ¦Todos ?					|
|	MDT835    ¦14      ¦Listar Despesas ?		|
|	MDT835    ¦15      ¦De Tipo Acidente ?		|
|	MDT835    ¦16      ¦Ate Tipo Acidente ?	|
|	MDT835    ¦17      ¦De  Ficha Medica ?		|
|	MDT835    ¦18      ¦Ate Ficha Medica ?		|
----------------------------------------------*/
	
If TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:DisableOrientation()
	oReport:SetLandscape() 
	oReport:PrintDialog()
Else
	lRelPer := .F.
	U_MDTR835R3()
EndIf
 
RestArea(aArea) 

//------------------------------------------------------------------------
// Devolve variaveis armazenadas (NGRIGHTCLICK)                          
//------------------------------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)
 
Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as secoes impressas no relatorio 

@author  Andre E. Perez Alvarez
@since 09/08/06
@return oReport
/*/ 
//---------------------------------------------------------------------
Static Function ReportDef()

Static oReport
Static oSection0
Static oSection1
Static oSection2
Static oSection3
Static oSection4
Static oBreak1
Static oBreak2
Static oCell

//LAYOUT
/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
_______________________________________________________________________________________________________________________________________________
                                                       
                                                       Acidentes de Trabalho            
_______________________________________________________________________________________________________________________________________________

Acidente   Dt. Acidente   Descricao Acidente      Matricula     Nome do Funcionario          C. Custo    Funcao  Objeto   Dt.CAT   Afastamento
_______________________________________________________________________________________________________________________________________________
xxxxxxxx   xx/xx/xxxx     xxxxxxxxxxxxxxxxxxxxxx  xxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxx   xxxxxx  xxxxxx   xx/xx/xxxx   xxxxxxx

Despesa                        Valor
____________________________________
xxxxxxxxxxxxxxxxxxxxxxxxxx   xxxx,xx
xxxxxxxxxxxxxxxxxxxxxxxxxx   xxxx,xx
					  Total: xxxx,xx           		
			
Acidente   Dt. Acidente   Descricao Acidente      Matricula     Nome do Funcionario          C. Custo    Funcao  Objeto   Dt.CAT   Afastamento
_______________________________________________________________________________________________________________________________________________
xxxxxxxx   xx/xx/xxxx     xxxxxxxxxxxxxxxxxxxxxx  xxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxx   xxxxxx  xxxxxx   xx/xx/xxxx   xxxxxxx

xxxxxxxx   xx/xx/xxxx     xxxxxxxxxxxxxxxxxxxxxx  xxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxx   xxxxxx  xxxxxx   xx/xx/xxxx   xxxxxxx

xxxxxxxx   xx/xx/xxxx     xxxxxxxxxxxxxxxxxxxxxx  xxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxx   xxxxxx  xxxxxx   xx/xx/xxxx   xxxxxxx

Despesa                        Valor
____________________________________
xxxxxxxxxxxxxxxxxxxxxxxxxx   xxxx,xx
xxxxxxxxxxxxxxxxxxxxxxxxxx   xxxx,xx
					  Total: xxxx,xx                                    

xxxxxxxx   xx/xx/xxxx     xxxxxxxxxxxxxxxxxxxxxx  xxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxx   xxxxxx  xxxxxx   xx/xx/xxxx   xxxxxxx

xxxxxxxx   xx/xx/xxxx     xxxxxxxxxxxxxxxxxxxxxx  xxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxx   xxxxxx  xxxxxx   xx/xx/xxxx   xxxxxxx

*/ 

//------------------------------------------------------------------------
// Criacao do componente de impressao                                      
//                                                                        
// TReport():New                                                           
// ExpC1 : Nome do relatorio                                               
// ExpC2 : Titulo                                                          
// ExpC3 : Pergunte                                                        
// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  
// ExpC5 : Descricao                                                       
//                                                                        
//------------------------------------------------------------------------
oReport := TReport():New("MDTR835",OemToAnsi(STR0006),cPerg,{|oReport| ReportPrint()},;  //"Acidentes de Trabalho"
           STR0030+STR0031+STR0032)

//------------------------------------------------------------------------
// Variaveis utilizadas para parametros                         
// mv_par01             // De  Acidente                          
// mv_par02             // Ate Acidente                         
// mv_par03             // De  Dt. Acidente                     
// mv_par04             // Ate Dt. Acidente                     
// mv_par05             // De  Centro de Custo                  
// mv_par06             // Ate Centro de Custo                  
// mv_par07             // De  Funcao                           
// mv_par08             // Ate Funcao                           
// mv_par09             // Todos, CAT's nao emitidas.           
// mv_par10             // Listar Despesas                      
// mv_par11             // De Tipo Acidente ?                   
// mv_par12             // Ate Tipo Acidente ?                  
// mv_par13             // De  Ficha Medica ?                   
// mv_par14             // Ate Ficha Medica ?                   
//------------------------------------------------------------------------
Pergunte(oReport:uParam,.F.)

U_MDT835SEC()

Return oReport

//---------------------------------------------------------------------
/*/{Protheus.doc} Posic1
Retorna a quantidade de dias de afastamento.

@author  Andre E. Perez Alvarez
@since 09/08/06
@return cDias
/*/ 
//---------------------------------------------------------------------
Static Function Posic1()

Local cDias

If TNC->TNC_AFASTA == '1'
	cDias := STRZERO(TNC->TNC_QTAFAS,3) + STR0051 //" Dias"
Else
	cDias := STR0052 //"Não Houve"
EndIf	

Return cDias

//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o relatorio. 

@author  Andre E. Perez Alvarez
@since 09/08/06
@return .T.
/*/ 
//---------------------------------------------------------------------
Static Function ReportPrint()
	
Local cCliente := ""

Processa( {|lEND| TRBgrava()}, STR0022 ,STR0023 ) //"Aguarde" ## "Processando os Acidentes de Trabalho..."

dbSelectARea("TRBTNC")
dbGoTop()
oReport:SetMeter( LastRec() )  

If lSigaMdtps

	If mv_par14 == 2	//Nao listar despesas
	
		While !oReport:Cancel() 	.AND.;
			  !Eof()
			  
			cCliente := TRBTNC->CLIENT+TRBTNC->LOJA
			oSection0:Init()
			oSection0:PrintLine()               					  			
			While !oReport:Cancel() 	.AND.;
				  !Eof()			    .AND.;
				  cCliente = TRBTNC->CLIENT+TRBTNC->LOJA				  
				
				oSection1:Init()	
				oReport:IncMeter()
				oSection1:PrintLine()               
				oSection4:Init()//Inica Seção 4
		    	oSection4:PrintLine()//Imprime Seção 4
		    	oSection4:Finish()//Fecha Seção
		    	oSection1:Finish()	  
				    
				dbSkip()
			End			 
			oSection0:Finish()
		    
		End

	
	Else	//Listar despesas
		
		While !oReport:Cancel() 	.AND.;
			  !Eof()                
			  
			cCliente := TRBTNC->CLIENT+TRBTNC->LOJA
			oSection0:Init()
			oSection0:PrintLine()
			While !oReport:Cancel() 	.AND.;
				  !Eof()			    .AND.;
				  cCliente = TRBTNC->CLIENT+TRBTNC->LOJA
				
				oSection1:Init()			  			
				oReport:IncMeter()
				oSection1:PrintLine()  
				oSection4:Init()//Inica Seção 4
		    	oSection4:PrintLine()//Imprime Seção 4
		    	oSection4:Finish()//Fecha Seção
		   		oSection2:Init()     
		   		
				dbSelectArea("TNM")
				dbsetorder(03)  //TNM_FILIAL+TNM_CLIENT+TNM_LOJA+TNM_ACIDEN+TNM_CODDES
				If dbseek ( xfilial("TNM") + TRBTNC->CLIENT + TRBTNC->LOJA + TRBTNC->ACIDENTE )   
				
					oSection2:Init()
					While !oReport:Cancel() 				  .AND.;
				  		  !Eof()							  .AND.; 
						  TNM->TNM_FILIAL == xFilial("TNM")   .AND.; 
						  TNM->TNM_ACIDEN == TRBTNC->ACIDENTE .AND.;     
						  TNM->(TNM_CLIENT+TNM_LOJA) == TRBTNC->CLIENT+TRBTNC->LOJA
						
						oSection2:PrintLine()
						
						dbSelectarea("TNM")
						dbSkip()
					End
					
					
				Endif
				oSection2:Finish()	  
				oSection1:Finish()							

				dbSelectArea("TRBTNC")
			    dbSkip()
			End			
			oSection0:Finish()

		End
		oSection0:Finish()
	
	Endif

Else

	If mv_par10 == 2	//Nao listar despesas
	
		
		While !oReport:Cancel() 	.AND.;
			  !Eof()
			oSection1:Init()//Inicia Seção 1
			oReport:IncMeter()
			oSection1:PrintLine()//Imprime Seção 1
			
			oSection4:Init()//Inica Seção 4
			oSection4:PrintLine()//Imprime Seção 4
			
			oSection1:Finish()//Fecha Seção
		    oSection4:Finish()//Fecha Seção
		    
		    dbSkip()
		End
		
	
	Else	//Listar despesas
		

		While !oReport:Cancel() 	.AND.;
			  !Eof()			
			oSection3:Init() 	
			oSection1:Init()
		    
		    oReport:IncMeter()
		    oSection1:PrintLine()
		    oSection4:Init()//Inica Seção 4
		    oSection4:PrintLine()//Imprime Seção 4
		    oSection4:Finish()//Fecha Seção
			oSection2:Init()			
			dbSelectArea("TNM")
			dbsetorder(01)
			If dbseek ( xfilial("TNM") + TRBTNC->ACIDENTE )   
				While !oReport:Cancel() 				  .AND.;
			  		  !Eof()							  .AND.; 
					  TNM->TNM_FILIAL == xFilial("TNM")  .AND.; 
					  TNM->TNM_ACIDEN == TRBTNC->ACIDENTE     
					
					oSection2:PrintLine()
					
					dbSelectarea("TNM")
					dbSkip()
				End
			Endif 
			oSection2:Finish()
			oSection1:Finish() 
			oSection3:Finish()
							
			dbSelectArea("TRBTNC")
		    dbSkip()
		End
		
	Endif

Endif

//use
dbSelectArea("TRBTNC")
oTempTNC:Delete()

Return .T.   

//---------------------------------------------------------------------
/*/{Protheus.doc} TRBgrava
Processa os acidentes de acordo com os parametros e grava   
no arquivo temporario.   

@author  Andre E. Perez Alvarez
@since 09/08/06
@return .T.
/*/ 
//---------------------------------------------------------------------
Static Function TRBgrava()

Local nSizefil := FwSizeFilial()
Local nTamMat  := TAMSX3("RA_MAT")[1]

If lSigaMdtps

	aDBF := {}
	AADD (aDBF, {"CLIENT"  ,"C", nTa1, 0} )
	AADD (aDBF, {"LOJA"    ,"C", nTa1L, 0} )
	AADD (aDBF, {"ACIDENTE","C", 06, 0} )
	AADD (aDBF, {"FICHA"   ,"C", 09, 0} )
	AADD (aDBF, {"MAT"     ,"C", nTamMat, 0} )
	AADD (aDBF, {"FILFUN"  ,"C", nSizefil, 0} )	
	
	//Cria TRB
	oTempTNC := FWTemporaryTable():New( "TRBTNC", aDBF )
	oTempTNC:AddIndex( "1", {"CLIENT","LOJA","ACIDENTE"} )
	oTempTNC:Create()
	
	dbSelectArea("TNC")
	dbSetOrder(13)  //TNC_FILIAL+TNC_CLIENT+TNC_LOJA+TNC_ACIDEN
	dbSeek( xFilial("TNC") + MV_PAR01 + MV_PAR02, .T. )
	oReport:SetMeter( LastRec() ) 
	   
	While !oReport:Cancel() 			  	   .AND.;
		  !Eof()                     		   .AND.;
	      TNC->TNC_FILIAL  == xFilial('TNC')   .AND.;
	      TNC->(TNC_CLIENT+TNC_LOJA) >= mv_par01+mv_par02 .AND.; 
	      TNC->(TNC_CLIENT+TNC_LOJA) <= mv_par03+mv_par04
	      
	    oReport:IncMeter()
	    
	    If TNC->TNC_ACIDEN < mv_par05 .OR. TNC->TNC_ACIDEN > mv_par06
	    	dbSkip()
	    	Loop
	    Endif
	                                                       
		If TNC->TNC_TIPACI < MV_PAR15 .OR. TNC->TNC_TIPACI > MV_PAR16
			dbSkip()
			Loop
	    Endif
	
	    If ( TNC->TNC_DTACID < MV_PAR07 ) .OR. ( TNC->TNC_DTACID > MV_PAR08 )  
	      	dbSKIP()
	      	loop
	    Endif
	    
	    If ( TNC->TNC_CC < MV_PAR09 ) .OR. ( TNC->TNC_CC > MV_PAR10 )
	      	dbskip()
	      	loop
	    Endif
	    
	    If ( TNC->TNC_CODFUN < MV_PAR11 ) .OR. ( TNC->TNC_CODFUN > MV_PAR12 )
			dbSKIP()
			loop
	    Endif
	    
	    If ( mv_par13 == 2 ) .AND. !Empty(TNC->TNC_DTEMIS)
	      	dbSkip()
			loop
	    Endif 
	    
	    If ( TNC->TNC_NUMFIC < MV_PAR17 ) .OR. ( TNC->TNC_NUMFIC > MV_PAR18 )
	    	dbSkip()
	    	Loop
	    endif	    
	    
	    dbSelectArea("TM0")
	    dbSetOrder(1)
	    dbSeek(xFilial("TM0")+TNC->TNC_NUMFIC)
	    
	    TRBTNC->(DbAppend())
	    TRBTNC->CLIENT   := TNC->TNC_CLIENT
		TRBTNC->LOJA     := TNC->TNC_LOJA
	    TRBTNC->ACIDENTE := TNC->TNC_ACIDEN           
	    TRBTNC->FICHA    := TNC->TNC_NUMFIC
	    TRBTNC->MAT      := TM0->TM0_MAT
	    TRBTNC->FILFUN   := TM0->TM0_FILFUN
	       
		dbSelectArea("TNC")
	    dbSkip()
	End

Else

	aDBF := {}
	AADD (aDBF, {"ACIDENTE","C", 06, 0} )  
	AADD (aDBF, {"FICHA"   ,"C", 09, 0} )
	AADD (aDBF, {"MAT"     ,"C", nTamMat, 0} )  
	AADD (aDBF, {"FILFUN"  ,"C", nSizefil, 0} )

	oTempTNC := FWTemporaryTable():New( "TRBTNC", aDBF )
	oTempTNC:AddIndex( "1", {"ACIDENTE"} )
	oTempTNC:Create()
	
	dbSelectArea("TNC")
	dbSetOrder(01)
	dbSeek( xFilial("TNC") + MV_PAR01, .T. )
	oReport:SetMeter( LastRec() ) 
	   
	While !oReport:Cancel() 			  	   .AND.;
		  !Eof()                     		   .AND.;
	      TNC->TNC_FILIAL  == xFilial('TNC')   .AND.;
	      TNC->TNC_ACIDEN  <= MV_PAR02
	      
	    oReport:IncMeter()
	                                                       
		if TNC->TNC_TIPACI < MV_PAR11 .OR. TNC->TNC_TIPACI > MV_PAR12
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif
	
	    If ( TNC->TNC_DTACID < MV_PAR03 ) .OR. ( TNC->TNC_DTACID > MV_PAR04 )  
			dbSelectARea("TNC")
	      	dbSKIP()
	      	loop
	    Endif
	    
	    If ( TNC->TNC_CC < MV_PAR05 ) .OR. ( TNC->TNC_CC > MV_PAR06 )
	      	dbSelectARea("TNC")
	      	dbSKIP()
	      	loop
	    Endif
	    
	    If ( TNC->TNC_CODFUN < MV_PAR07 ) .OR. ( TNC->TNC_CODFUN > MV_PAR08 )
			dbSelectARea("TNC")
			dbSKIP()
			loop
	    Endif
	    
	    If ( mv_par09 == 2 ) .AND. !Empty(TNC->TNC_DTEMIS) 
	    	dbSelectARea("TNC")
	      	dbSkip()
			loop
	    Endif 
	    
	    If ( TNC->TNC_NUMFIC < MV_PAR13 ) .OR. ( TNC->TNC_NUMFIC > MV_PAR14 )
	    	dbSkip()
	    	Loop
	    endif	    
	    
	    dbSelectArea("TM0")
	    dbSetOrder(1)
	    dbSeek(xFilial("TM0")+TNC->TNC_NUMFIC)

	    TRBTNC->(DbAppend())
	    TRBTNC->ACIDENTE := TNC->TNC_ACIDEN            
	    TRBTNC->FICHA    := TNC->TNC_NUMFIC
	    TRBTNC->MAT      := TM0->TM0_MAT  
	    TRBTNC->FILFUN   := TM0->TM0_FILFUN
	       
		dbSelectArea("TNC")
	    dbSkip()
	End

Endif


Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR835R3
Relatorio dos Acidentes de Trabalhos ocorridos no periodo.  
(realese 3)    

@author Thiago Machado 
@since  18/08/00
@return Nil
/*/ 
//---------------------------------------------------------------------
User Function MDTR835R3()
//-------------------------------------------------
// Define Variaveis                                             
//-------------------------------------------------
LOCAL wnrel   := "MDTR835"
LOCAL limite  := 220
LOCAL cDesc1  := STR0001 //"Relatorio dos Acidentes de Trabalho ocorridos na Empresa.      "
LOCAL cDesc2  := STR0002 //"Atrav‚s dos parametros o usu rio poder  selecionar o periodo,  "
LOCAL cDesc3  := STR0003 //"C.Custo entre outras op‡äes dispon¡eis para um melhor aproveitamento.     "
LOCAL cString := "TNC"


PRIVATE nomeprog := "MDTR835"
PRIVATE tamanho  := "G"
PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Acidentes de Trabalho"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2
Private lFicha := .t. 
PRIVATE cPROGRAMA  := "MDTA640"

//-------------------------------------------------
// Verifica as perguntas selecionadas             
//-------------------------------------------------
pergunte(cPerg,.F.)
//-----------------------------------------------------
// Variaveis utilizadas para parametros                         
// mv_par01             // De  Acidente                          
// mv_par02             // Ate Acidente                         
// mv_par03             // De  Dt. Acidente                     
// mv_par04             // Ate Dt. Acidente                     
// mv_par05             // De  Centro de Custo                  
// mv_par06             // Ate Centro de Custo                  
// mv_par07             // De  Funcao                           
// mv_par08             // Ate Funcao                           
// mv_par09             // Todos, CAT's nao emitidas.           
// mv_par10             // Listar Despesas                      
// mv_par11             // De Tipo Acidente ?                   
// mv_par12             // Ate Tipo Acidente ?                  
// mv_par13             // De  Ficha Medica ?                   
// mv_par14             // Ate Ficha Medica ?                   
//-----------------------------------------------------
//-------------------------------------------------
// Envia controle para a funcao SETPRINT                        
//-------------------------------------------------
wnrel := "MDTR835"

wnrel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| R835Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Chama relatório.

@param lEnd - Cancela a impressão.
@param wnRel - Programa utilizado.
@param titulo - Titulo do relatório.
@param tamanho - Tamanho do relatório. 

@author Thiago Machado 
@since  18/08/00
@return Nil
/*/ 
//---------------------------------------------------------------------
Static Function R835Imp(lEnd,wnRel,titulo,tamanho)

//-----------------------------------------------------
// Variaveis locais exclusivas deste programa                   
//-----------------------------------------------------
//LOCAL cChave           := SPACE(16)
LOCAL lContinua        := .T.
LOCAL cCliente := ""
Local nTamMat  := TAMSX3("RA_MAT")[1]
Local oTempTRB, oTempTRB2
//-----------------------------------------------------
// Contadores de linha e pagina                                 
//-----------------------------------------------------
PRIVATE li := 80 ,m_pag := 1

//-----------------------------------------------------
// Variaveis locais exclusivas deste programa                   
//-----------------------------------------------------
// PRIVATE
PRIVATE cFicAnt := SPACE(9)
PRIVATE nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,4,(TAMSX3("RJ_FUNCAO")[1]))

//-----------------------------------------------------
// Verifica se deve comprimir ou nao                            
//-----------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//-----------------------------------------------------
// Monta os Cabecalhos                                          
//-----------------------------------------------------
cabec1 := STR0061 //"Acidente   Data Acidente   Descrição Acidente                                  Matricula   Nome Funcionario                 Centro de Custo       Função         Indicativo                Data CAT    Afastamento"
If MV_PAR10 == 1
	cabec2 := STR0062 //"         Despesa                                     Valor(R$)							                                   Obj. Causador Descrição                                Tipo Acidente  Descrição"
Else
	cabec2 := STR0063 //"                                                              							                                   Obj. Causador Descrição                                Tipo Acidente  Descrição"
Endif 
/* 
=======================================================================================================================================
          1         2         3         4         5         6         7         8         9       100       110       120       130       140       150       160       170       180       190       200       210       220
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Acidente   Data Acidente   Descricao Acidente                                  Matricula   Nome Funcionario                 Centro de Custo       Funcao   Objeto Causador  Tipo Acidente  Data CAT    Afastamento
         Despesa                                      Valor(R$)                                                                      
xxxxxx     xx/xx/xxxx      12345678901234567890123456789012345678901234567890  xxxxxx      123456789012345678901234567890   12345678901234567890  xxxxx    1234567890       1234567890     xx/xx/xxxx  xxx Dias  
xxxxxx     xx/xx/xxxx      12345678901234567890123456789012345678901234567890  xxxxxx      123456789012345678901234567890   12345678901234567890  xxxxx    1234567890       1234567890     xx/xx/xxxx  xxx Dias  
xxxxxx     xx/xx/xxxx      12345678901234567890123456789012345678901234567890  xxxxxx      123456789012345678901234567890   12345678901234567890  xxxxx    1234567890       1234567890     xx/xx/xxxx  xxx Dias  
xxxxxx     xx/xx/xxxx      12345678901234567890123456789012345678901234567890  xxxxxx      123456789012345678901234567890   12345678901234567890  xxxxx    1234567890       1234567890     xx/xx/xxxx  xxx Dias  
         xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxx,xx                                                          
         xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxx,xx
        
Total de despesas com esse acidente............: xxxxxxxxxx,xx

-------------------------------------------------------------------------------------------------------------------------------------
Total geral de despesas........................: xxxxxxxxxx,xx
=======================================================================================================================================
caso funcao seja maior q 10
          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
Acid.   Dt.Acid.   Descricao Acidente        Mat.   Nome Funcionario       C.Custo    Func.           Obj. Tip. Dt.CAT     Afasta.
                   1234567890123456789012345        1234567890123456789012 
xxxxxx  xx/xx/xxxx xxxxxxxxxxxxxxxxxxxxxxxxx xxxxxx xxxxxxxxxxxxxxxxxxxxxx xxxxxxxxx  xxxxxxxxxxxxxx  xxx  xxx  xx/xx/xxxx xxx Dias

*/

nCol01 := 0
nCol02 := 11
nCol03 := 27
nCol04 := 79
nCol05 := 91
nCol06 := 124
nCol07 := 146
nCol08 := 155
nCol09 := 172
nCol10 := 187
nCol11 := 199
nCol12 := 161
nCol13 := 99
nCol14 := 113
nCol15 := 155
nCol16 := 170
nNomeT := 30
nDescT := 50

If lSigaMdtps
	aDBF := {}
	AADD(aDBF,{"CLIENT"   ,"C",nTa1,0})
	AADD(aDBF,{"LOJA"     ,"C",nTa1L,0})
	AADD(aDBF,{"ACIDENTE" ,"C",06,0})
	AADD(aDBF,{"DATACID"  ,"D",08,0})
	AADD(aDBF,{"MATRICULA","C",09,0})

	oTempTRB := FWTemporaryTable():New( "TRB835", aDBF )
	oTempTRB:AddIndex( "1", {"CLIENT","LOJA","ACIDENTE","DATACID"} )
	oTempTRB:Create()
	
	aDBF := {}
	AADD(aDBF,{"CLIENT"   ,"C",nTa1,0}) 
	AADD(aDBF,{"LOJA"     ,"C",nTa1L,0})
	AADD(aDBF,{"ACIDENTE" ,"C",06,0})  
	AADD(aDBF,{"VALDES"   ,"N",10,2})   
	AADD(aDBF,{"DESPESA"  ,"C",40,0})  
		
	oTempTRB2 := FWTemporaryTable():New( "TRB835_2", aDBF )
	oTempTRB2:AddIndex( "1", {"CLIENT","LOJA","ACIDENTE","DESPESA"} )
	oTempTRB2:Create()
	
	dbSelectArea("TNC")
	dbSetOrder(13)  //TNC_FILIAL+TNC_CLIENT+TNC_LOJA+TNC_ACIDEN
	dbSeek(xFilial("TNC") + MV_PAR01 + MV_PAR02,.T.)	   
	SetRegua(LastRec())

	While lContinua .And.!Eof()                      .AND.;
	      TNC->TNC_FILIAL  == xFilial('TNC')         .AND.;
	      TNC->(TNC_CLIENT+TNC_LOJA) >= mv_Par01+mv_par02 .and. TNC->(TNC_CLIENT+TNC_LOJA) <= mv_Par03+mv_par04
	      
	    IncRegua()
		
		If TNC->TNC_ACIDEN < mv_par05 .OR. TNC->TNC_ACIDEN > mv_par06
	      dbSKIP()
	      loop		
		Endif
	
		if TNC->TNC_TIPACI < MV_PAR15 .OR. TNC->TNC_TIPACI > MV_PAR16
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif
	    if TNC->TNC_DTACID < MV_PAR07 .OR. TNC->TNC_DTACID > MV_PAR08   
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif
	    if TNC->TNC_CC < MV_PAR09 .OR. TNC->TNC_CC > MV_PAR10
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif
	    if TNC->TNC_CODFUN < MV_PAR11 .OR. TNC->TNC_CODFUN > MV_PAR12
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif
	    If mv_par13 == 2 .AND. !Empty(TNC->TNC_DTEMIS) 
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif
	    If TNC->TNC_NUMFIC < MV_PAR17 .OR. TNC->TNC_NUMFIC > MV_PAR18
	      dbSelectARea("TNC")
	      dbSkip()
	      Loop
	    endif
        
	    dbSelectArea("TRB835")
	    TRB835->(DbAppend())
	    TRB835->CLIENT    := TNC->TNC_CLIENT
	    TRB835->LOJA      := TNC->TNC_LOJA
	    TRB835->ACIDENTE  := TNC->TNC_ACIDEN           
	    TRB835->DATACID   := TNC->TNC_DTACID
	    TRB835->MATRICULA := TNC->TNC_NUMFIC
	    
	    If mv_par14 = 1
	      dbSelectArea("TNM")
	      dbsetorder(03)  //TNM_FILIAL+TNM_CLIENT+TNM_LOJA+TNM_ACIDEN+TNM_CODDES
	      dbseek(xfilial("TNM")+TNC->TNC_CLIENT+TNC->TNC_LOJA+TNC->TNC_ACIDEN)   
	      While !Eof() .and. xFilial("TNM") = TNM->TNM_FILIAL .and. TNC->TNC_ACIDEN = TNM->TNM_ACIDEN .and. TNC->TNC_CLIENT+TNC->TNC_LOJA = TNM->TNM_CLIENT+TNM->TNM_LOJA
	        dbSelectarea("TNL")
	        dbSetorder(01)  //TNL_FILIAL+TNL_CLIENT+TNL_LOJA+TNL_CODDES
	        dbSeek(xFilial("TNL")+TNM->TNM_CLIENT+TNM->TNM_LOJA+TNM->TNM_CODDES)     
	        TRB835_2->(DbAppend())
	      	TRB835_2->CLIENT   := TNL->TNL_CLIENT
	      	TRB835_2->LOJA     := TNL->TNL_LOJA
	      	TRB835_2->DESPESA  := TNL->TNL_NOMDES
	      	TRB835_2->VALDES   := TNM->TNM_VALDES
	      	TRB835_2->ACIDENTE := TNC->TNC_ACIDEN           
	      	dbSelectarea("TNM")
	      	dbSkip()
	      End
	    endif
	    dbSelectArea("TNC")
	    dbSKIP()
	END
	            
	dbSelectARea("TRB835")
	dbGOTOP()  
	nTotgeral := 0
	
	While !eof()
	    	    
	    Somalinha()
	    
		If cCliente <> TRB835->CLIENT+TRB835->LOJA
			dbSelectArea("SA1")
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+TRB835->CLIENT+TRB835->LOJA)
			@Li,000 Psay STR0053 + SA1->A1_COD +"-"+ SA1->A1_LOJA +STR0054+ SA1->A1_NOME //"Cliente/Loja: "###"         Nome: "
			cCliente := TRB835->CLIENT+TRB835->LOJA
			nTotgeral := 0
			Somalinha()
			Somalinha()
		Endif
	    
	    nTotacidente := 0
	    @Li,nCol01 PSAY TRB835->ACIDENTE PICTURE "999999"
	    @Li,nCol02 PSAY TRB835->DATACID  PICTURE "99/99/99"
	 
	    dbSelectArea("TNC")
	    dbSetOrder(13)  //TNC_FILIAL+TNC_CLIENT+TNC_LOJA+TNC_ACIDEN
	    dbSEEK(xfilial("TNC")+TRB835->CLIENT+TRB835->LOJA+TRB835->ACIDENTE)	        
        @Li,nCol03 PSAY SUBSTR(TNC->TNC_DESACI,1,nDescT) PICTURE "@!"
        cMAT:=TRB835->MATRICULA
        
        dbSelectArea("TM0")
        dbSetOrder(1)
        dbSEEK(xfilial("TM0")+TRB835->MATRICULA)
        @Li,nCol04 PSAY TM0->TM0_MAT    PICTURE Replicate("9",nTamMat)
        @Li,nCol05 PSAY SUBSTR(TM0->TM0_NOMFIC,1,nNomeT) PICTURE "@!"
        cMAT2 := TM0->TM0_MAT
        
        dbSelectArea("SRA")
        dbSetOrder(1)
        dbSEEK(TM0->TM0_FILFUN+cMAT2)
        @Li,nCol06 PSAY SRA->RA_CC
        @Li,nCol07 PSAY SRA->RA_CODFUNC
        
        dbSelectArea("TNC")
        dbSetOrder(13)  //TNC_FILIAL+TNC_CLIENT+TNC_LOJA+TNC_ACIDEN
        dbSEEK(xfilial("TNC")+TRB835->CLIENT+TRB835->LOJA+TRB835->ACIDENTE)
	     @Li,nCol13 PSAY TNC->TNC_CODOBJ	//Objeto
	     @Li,nCol14 PSAY NGSEEK("TNH",TNC->TNC_CODOBJ,1,"TNH->TNH_DESOBJ")//Descrição
	     @Li,nCol15 PSAY TNC->TNC_TIPACI	//Tipo Acidente
	     @Li,nCol16 PSAY NGSEEK("TNG",TNC->TNC_TIPACI,1,"TNG->TNG_DESTIP") //Descrição
        @Li,nCol10 PSAY TNC->TNC_DTEMIS PICTURE "99/99/99"
        If TNC->TNC_AFASTA == '1'
        	@Li,nCol11 PSAY STRZERO(TNC->TNC_QTAFAS,3) + STR0051 //" Dias"
        Else
        	@Li,nCol11 PSAY STR0052 //"Não Houve"
        EndIf	
		
		If mv_par14 = 1
			dbSelectArea("TRB835_2")
			dbGoTop()
			dbSeek(TRB835->CLIENT+TRB835->LOJA+TRB835->ACIDENTE)
			While !Eof() .and. TRB835_2->ACIDENTE = TRB835->ACIDENTE .AND. TRB835->CLIENT+TRB835->LOJA = TRB835_2->CLIENT+TRB835_2->LOJA
				somalinha()
				@Li,009 PSAY Alltrim(TRB835_2->DESPESA)
				@Li,051 PSAY TRB835_2->VALDES picture "@E 999,999,999.99"
				nTotacidente += TRB835_2->VALDES
				nTotgeral    += TRB835_2->VALDES
				dbSelectArea("TRB835_2")
				dbSKIP()	
			End
			Somalinha()
			Somalinha()
	 		@Li,000 PSAY STR0055 //"Total de despesas com esse acidente............: "
	 		@Li,051 PSAY nTotacidente picture "@E 999,999,999.99"
		EndIf
	    
	    dbSelectArea("TRB835")
	    dbSKIP()
	    somalinha()
		If mv_par14 = 1
			If cCliente <> TRB835->CLIENT+TRB835->LOJA
				Somalinha()
				@Li,000 PSAY STR0056 //"Total de despesas do cliente...................: "
				@Li,051 PSAY nTotgeral picture "@E 999,999,999.99"			
				Somalinha()
				@Li,000 PSAY Replicate("-",132)				
				Somalinha()				
			Endif			
		EndIf			
		
	Enddo
		
Else
	aDBF := {}
	AADD(aDBF,{"ACIDENTE" ,"C",06,0})  
	AADD(aDBF,{"DATACID"  ,"D",08,0})  
	AADD(aDBF,{"MATRICULA","C",09,0})  
	
	oTempTRB := FWTemporaryTable():New( "TRB835", aDBF )
	oTempTRB:AddIndex( "1", {"ACIDENTE","DATACID"} )
	oTempTRB:Create()
	
	aDBF := {}
	AADD(aDBF,{"ACIDENTE" ,"C",06,0})  
	AADD(aDBF,{"VALDES"   ,"N",10,2})   
	AADD(aDBF,{"DESPESA"  ,"C",40,0})  
	            
	oTempTRB2 := FWTemporaryTable():New( "TRB835_2", aDBF )
	oTempTRB2:AddIndex( "1", {"ACIDENTE","DESPESA"} )
	oTempTRB2:Create()
	
	//-----------------------------------------------------
	// Define o Indice conforme a classificacao selecionada.    
	//-----------------------------------------------------
	dbSelectArea("TNC")
	dbSetOrder(01)
	dbSeek(xFilial("TNC") + MV_PAR01,.T.)
	   
	SetRegua(LastRec())
	//-----------------------------------------------------
	// Correr TNC para ler os  Exames Programados               
	//-----------------------------------------------------
	While lContinua .And.!Eof()                      .AND.;
	      TNC->TNC_FILIAL  == xFilial('TNC')         .AND.;
	      TNC->TNC_ACIDEN  <= MV_PAR02
	      
	      #IFNDEF WINDOWS
	          If LastKey() = 286    //ALT_A
	             lEnd := .t.
	          End
	      #ENDIF
	          If lEnd
	             @ PROW()+1,001 PSay STR0008 //"CANCELADO PELO OPERADOR"
	             Exit
	          EndIf
	
	    IncRegua()
		if TNC->TNC_TIPACI < MV_PAR11 .OR. TNC->TNC_TIPACI > MV_PAR12
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif
	    if TNC->TNC_DTACID < MV_PAR03 .OR. TNC->TNC_DTACID > MV_PAR04   
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif
	    if TNC->TNC_CC < MV_PAR05 .OR. TNC->TNC_CC > MV_PAR06
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif
	    if TNC->TNC_CODFUN < MV_PAR07 .OR. TNC->TNC_CODFUN > MV_PAR08
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif
	    If mv_par09 == 2 .AND. !Empty(TNC->TNC_DTEMIS) 
	      dbSelectARea("TNC")
	      dbSKIP()
	      loop
	    endif 
	    If TNC->TNC_NUMFIC < MV_PAR13 .OR. TNC->TNC_NUMFIC > MV_PAR14
	      dbSelectARea("TNC")
	      dbSkip()
	      Loop
	    endif
	    	    
	    dbSelectArea("TRB835")
	    TRB835->(DbAppend())
	    TRB835->ACIDENTE := TNC->TNC_ACIDEN           
	    TRB835->DATACID  := TNC->TNC_DTACID
	    TRB835->MATRICULA:= TNC->TNC_NUMFIC
	    If mv_par10 = 1
	      dbSelectArea("TNM")
	      dbsetorder(01)
	      dbseek(xfilial("TNM")+TNC->TNC_ACIDEN)   
	      While !Eof() .and. xFilial("TNM") = TNM->TNM_FILIAL .and. TNC->TNC_ACIDEN = TNM->TNM_ACIDEN
	        dbSelectarea("TNL")
	        dbSetorder(01)
	        dbSeek(xFilial("TNL")+TNM->TNM_CODDES)     
	        TRB835_2->(DbAppend())
	      	TRB835_2->DESPESA  := TNL->TNL_NOMDES
	      	TRB835_2->VALDES   := TNM->TNM_VALDES
	      	TRB835_2->ACIDENTE := TNC->TNC_ACIDEN           
	      	dbSelectarea("TNM")
	      	dbSkip()
	      End
	    endif
	    dbSelectArea("TNC")
	    dbSKIP()
	END
	            
	dbSelectARea("TRB835")
	dbGOTOP()  
	nTotgeral := 0

	While !eof()
	    Somalinha()
	    nTotacidente := 0
	    @Li,nCol01 PSAY TRB835->ACIDENTE PICTURE "999999"
	    @Li,nCol02 PSAY TRB835->DATACID  PICTURE "99/99/99"
	    dbSelectArea("TNC")
	    dbSetOrder(1)
	    dbSEEK(xfilial("TNC")+TRB835->ACIDENTE)
	        @Li,nCol03 PSAY SUBSTR(TNC->TNC_DESACI,1,nDescT) PICTURE "@!"
	        cMAT:=TRB835->MATRICULA
	        dbSelectArea("TM0")
	        dbSetOrder(1)
	        dbSEEK(xfilial("TM0")+TRB835->MATRICULA)
	            @Li,nCol04 PSAY TM0->TM0_MAT    PICTURE "999999"
	            @Li,nCol05 PSAY SUBSTR(TM0->TM0_NOMFIC,1,nNomeT) PICTURE "@!"
	            cMAT2 := TM0->TM0_MAT
	            dbSelectArea("SRA")
	            dbSetOrder(1)
	            dbSEEK(TM0->TM0_FILFUN+cMAT2)
	                @Li,nCol06 PSAY SRA->RA_CC
	                @Li,nCol07 PSAY SRA->RA_CODFUNC
	                @Li,nCol12 PSAY NGRETSX3BOX("TNC_INDACI",TNC->TNC_INDACI) 
	                dbSelectArea("TNC")
	                dbSetOrder(1)
	                dbSEEK(xfilial("TNC")+TRB835->ACIDENTE)
	                    @Li,nCol10 PSAY TNC->TNC_DTEMIS PICTURE "99/99/99"
	                    If TNC->TNC_AFASTA == '1'
	                    	@Li,nCol11 PSAY STRZERO(TNC->TNC_QTAFAS,3) + STR0051 //" Dias"
	                    Else
	                    	@Li,nCol11 PSAY STR0052 //"Não Houve"
	                    EndIf	
	                    Somalinha()
	                    @Li,nCol13 PSAY TNC->TNC_CODOBJ	//Objeto
	                    @Li,nCol14 PSAY NGSEEK("TNH",TNC->TNC_CODOBJ,1,"TNH->TNH_DESOBJ")//Descrição
	                    @Li,nCol15 PSAY TNC->TNC_TIPACI	//Tipo Acidente
	                    @Li,nCol16 PSAY NGSEEK("TNG",TNC->TNC_TIPACI,1,"TNG->TNG_DESTIP") //Descrição
		If mv_par10 = 1 
			dbSelectArea("TRB835_2")
			dbGoTop()
			dbSeek(TRB835->ACIDENTE)
			While !Eof() .and. TRB835_2->ACIDENTE = TRB835->ACIDENTE
				somalinha()
				@Li,009 PSAY Alltrim(TRB835_2->DESPESA)
				@Li,051 PSAY TRB835_2->VALDES picture "@E 999,999,999.99"
				nTotacidente += TRB835_2->VALDES
				nTotgeral    += TRB835_2->VALDES
				dbSelectArea("TRB835_2")
				dbSKIP()	
			End
			Somalinha()
			Somalinha()
	 		@Li,000 PSAY STR0055 //"Total de despesas com esse acidente............: "
	 		@Li,051 PSAY nTotacidente picture "@E 999,999,999.99"
		EndIf
	    dbSelectArea("TRB835")
	    dbSKIP()
	    somalinha()
	Enddo
	If mv_par10 = 1
		Somalinha()
		@Li,000 PSAY Replicate("-",132)
		Somalinha()
		@Li,000 PSAY STR0057 //"Total geral de despesas........................: "
		@Li,051 PSAY nTotgeral picture "@E 999,999,999.99"
	EndIf
	
Endif


//-----------------------------------------------------
// Devolve a condicao original do arquivo principal             
//-----------------------------------------------------
RetIndex("TNC")

Set Filter To

Set device to Screen

If aReturn[5] = 1
        Set Printer To
        dbCommitAll()
        OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()         

dbSelectArea("TRB835")
oTempTRB:Delete()
dbSelectArea("TRB835_2")
oTempTRB2:Delete()
dbSelectArea("TNC")   
dbSetOrder(01)

Return NIL    

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina 

@author Inacio Luiz Kolling
@since   /06/97
@return 
/*/ 
//---------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)  
    EndIf
Return
//---------------------------------------------------------------------
/*/{Protheus.doc} MDT835SEC
Atualiza as configuracoes de secao de acordo com o parametro
Listar Despesa?" 1=sim; 2=nao    

@author Andre Perez Alvarez
@since 06/12/2007
@return .T. 
/*/ 
//---------------------------------------------------------------------
User Function MDT835SEC()

If lRelPer

	//--------------------------------------------------------------------------
	// Criacao da secao utilizada pelo relatorio                               
	//                                                                         
	// TRSection():New                                                         
	// ExpO1 : Objeto TReport que a secao pertence                             
	// ExpC2 : Descricao da seçao                                              
	// ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   
	//         sera considerada como principal para a seção.                   
	// ExpA4 : Array com as Ordens do relatório                                
	// ExpL5 : Carrega campos do SX3 como celulas                              
	//         Default : False                                                 
	// ExpL6 : Carrega ordens do Sindex                                        
	//         Default : False                                                 
	//                                                                         
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	// Criacao da celulas da secao do relatorio                                
	//                                                                         
	// TRCell():New                                                            
	// xpO1 : Objeto TSection que a secao pertence                            
	// ExpC2 : Nome da celula do relatório. O SX3 será consultado              
	// ExpC3 : Nome da tabela de referencia da celula                          
	// ExpC4 : Titulo da celula                                                
	//         Default : X3Titulo()                                            
	// ExpC5 : Picture                                                         
	//         Default : X3_PICTURE                                            
	// ExpC6 : Tamanho                                                         
	//         Default : X3_TAMANHO                                            
	// ExpL7 : Informe se o tamanho esta em pixel                              
	//         Default : False                                                 
	// ExpB8 : Bloco de código para impressao.                                 
	//         Default : ExpC2                                                 
	//                                                                         
	//--------------------------------------------------------------------------
	
	oReport:Asection := {}  //Apaga as secoes dos parametros anteriores
	oReport:Afunction := {}  //Apaga as funcoes totalizadoras
	
	If lSigaMdtps
		//********************* Secao 0 - Cliente
		oSection0 := TRSection():New (oReport,STR0033+"/"+STR0034, {"TRBTNC","SA1"} )//"Cliente"###"Loja" 
		oCell := TRCell():New(oSection0, "A1_COD"        , "SA1" , STR0033, "@!", nTa1  )  //"Cliente"
		oCell := TRCell():New(oSection0, "A1_LOJA"       , "SA1" , STR0034, "@!", nTa1L )   //"Loja"
		oCell := TRCell():New(oSection0, "A1_NOME"       , "SA1" , STR0035, "@!", 40 )   //"Nome"
		TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + TRBTNC->CLIENT + TRBTNC->LOJA } )
		
		//********************* Secao 1 - Acidente 
		oSection1 := TRSection():New (oReport,STR0009, {"TRBTNC","TNC","TM0","SRA"} )//"Acidente" 
		oCell := TRCell():New(oSection1, "TRBTNC->ACIDENTE", "TRBTNC" , STR0009, "@!"      , 10  )  //"Acidente"     
		oCell := TRCell():New(oSection1, "TNC_DTACID"      , "TNC"    , STR0010, "99/99/99", 12  )  //"Dt.Acidente"     
		oCell := TRCell():New(oSection1, "TNC_DESACI"      , "TNC"    , STR0011, "@!"      , 15  )  //"Descricao Acidente"    
		oCell := TRCell():New(oSection1, "TRBTNC->MAT"     , "TRBTNC" , STR0012, "@!"      , 10  )  //"Matricula"     
		oCell := TRCell():New(oSection1, "TM0_NOMFIC"      , "TM0"    , STR0013, "@!"      ,  15)  //"Nome Funcionario"     
		oCell := TRCell():New(oSection1, "TM0_CC"          , "TM0"    , STR0014, "@!"      , nSizeSI3+15  )  //"C.Custo"     
		oCell := TRCell():New(oSection1, "RA_CODFUNC"      , "SRA"    , STR0015, "@!"      , 15  )  //"Funcao"  
		oCell := TRCell():New(oSection1, "TNC_INDACI"      , "TNC"    , STR0058, "@!"      , 20  ) //"Indicativo"   
		oCell := TRCell():New(oSection1, "TNC->TNC_DTEMIS" , "TNC"    , STR0018, "99/99/99", 12  )  //"Dt.CAT"     
		oCell := TRCell():New(oSection1, "cAfast"          ,          , STR0019, "@!", 16, /*lPixel*/, {|| Posic1() }  )  //"Afastamento"     
		TRPosition():New (oSection1, "TNC", 1, {|| xFilial("TNC") + TRBTNC->CLIENT + TRBTNC->LOJA + TRBTNC->ACIDENTE } )      
		TRPosition():New (oSection1, "TM0", 1, {|| xFilial("TM0") + TRBTNC->FICHA    } )      
		TRPosition():New (oSection1, "SRA", 1, {|| TRBTNC->FILFUN + TRBTNC->MAT      } )    
		
		//********************* Secao 4 - Acidente
		oSection4 := TRSection():New (oReport,STR0009, {"TNC"} ) //"Acidente"
		oCell := TRCell():New(oSection4, "TNC_CODOBJ"      , "TNC"    , STR0016		, "@!" 	, 18  )  //"Obj."    
		oCell := TRCell():New(oSection4, "cDescricao"      , "TNC"    , STR0064		, "@!"		, 45, /*lPixel*/, {|| NGSEEK("TNH",TNC->TNC_CODOBJ,1,"TNH->TNH_DESOBJ") }  ) //"Descrição"       
		oCell := TRCell():New(oSection4, "TNC_TIPACI"      , "TNC"    , STR0017		, "@!"		, 20  )  //"Tipo"    
		oCell := TRCell():New(oSection4, "cDescricao"      , "TNC"    , STR0064		, "@!"		, 45, /*lPixel*/, {|| NGSEEK("TNG",TNC->TNC_TIPACI,1,"TNG->TNG_DESTIP") }  )  //"Descrição"    
		
		TRPosition():New (oSection4, "TNC", 1, {|| xFilial("TNC") + TRBTNC->ACIDENTE } )      
		   
		If mv_par14 == 1  //Listar despesas
			//********************* Secao 2 - Despesas
			oSection2 := TRSection():New (oReport,STR0020, {"TNM","TNL"} )//"Despesa"
			oCell := TRCell():New (oSection2, "TNL_NOMDES", "TNL", STR0020, "@!"            , 45, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Despesa"
			oCell := TRCell():New (oSection2, "TNM_VALDES", "TNM", STR0021, "@E 999,999,999.99", 18, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Valor (R$)"
			TRPosition():New (oSection2, "TNL", 1, {|| xFilial("TNL") + TNM->TNM_CLIENT + TNM->TNM_LOJA + TNM->TNM_CODDES } )           	
		
			oReport:SetTotalInLine(.T.)
			oReport:SetTotalText(STR0036)  //"Total de Despesas do Cliente"
			oBreak1 := TRBreak():New(oSection2,".T.",STR0024,.F.)  //"Total de despesas com esse acidente"
			oBreak0 := TRBreak():New(oSection0,".T.",STR0036,.F.)  //"Total de Despesas do Cliente"
			TRFunction():New(oSection2:Cell("TNM_VALDES"),/*cId*/,"SUM",oBreak1,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)		
			TRFunction():New(oSection2:Cell("TNM_VALDES"),/*cId*/,"SUM",oBreak0,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)
		Endif		
	Else
		//********************* Secao 1 - Acidente
		oSection1 := TRSection():New (oReport,STR0009, {"TRBTNC","TNC","TM0","SRA"} ) //"Acidente"
		oCell := TRCell():New(oSection1, "TNC_ACIDEN"      , "TNC"    , STR0009, "@!"      , 10  )  //"Acidente"     
		oCell := TRCell():New(oSection1, "TNC_DTACID"      , "TNC"    , STR0010, "99/99/99", 12  )  //"Dt.Acidente"     
		oCell := TRCell():New(oSection1, "TNC_DESACI"      , "TNC"    , STR0011, "@!"      , 30  )  //"Descricao Acidente"     
		oCell := TRCell():New(oSection1, "RA_MAT"         , "SRA"     , STR0012, "@!"      , 10  )  //"Matricula"     
		oCell := TRCell():New(oSection1, "TM0_NOMFIC"      , "TM0"    , STR0013, "@!"      , 45  )  //"Nome Funcionario"     
		oCell := TRCell():New(oSection1, "TM0_CC"          , "TM0"    , STR0014, "@!"      , nSizeSI3+15 )  //"C.Custo"      
		oCell := TRCell():New(oSection1, "RA_CODFUNC"      , "SRA"    , STR0015, "@!"      , 20  )  //"Funcao"    
		oCell := TRCell():New(oSection1, "TNC_INDACI"      , "TNC"    , STR0058, "@!"      , 20 ) //"Indicativo" 
		oCell := TRCell():New(oSection1, "TNC->TNC_DTEMIS" , "TNC"    , STR0018, "99/99/99", 16  )  //"Dt.CAT"     
		oCell := TRCell():New(oSection1, "cAfast"          ,          , STR0019, "@!", 18, /*lPixel*/, {|| Posic1() }  )  //"Afastamento"     
		
		TRPosition():New (oSection1, "TNC", 1, {|| xFilial("TNC") + TRBTNC->ACIDENTE } )        
		TRPosition():New (oSection1, "TM0", 1, {|| xFilial("TM0") + TRBTNC->FICHA    } )         
		TRPosition():New (oSection1, "SRA", 1, {|| TRBTNC->FILFUN + TRBTNC->MAT      } )        

		//********************* Secao 4 - Acidente
		oSection4 := TRSection():New (oReport,STR0009, {"TNC"} ) //"Acidente"
		oCell := TRCell():New(oSection4, "TNC_CODOBJ"      , "TNC"    , STR0016		, "@!" 	, 18  )  //"Obj."    
		oCell := TRCell():New(oSection4, "cDescricao"      , "TNC"    , STR0064		, "@!"		, 45, /*lPixel*/, {|| NGSEEK("TNH",TNC->TNC_CODOBJ,1,"TNH->TNH_DESOBJ") }  ) //"Descrição"       
		oCell := TRCell():New(oSection4, "TNC_TIPACI"      , "TNC"    , STR0017		, "@!"		, 20  )  //"Tipo"    
		oCell := TRCell():New(oSection4, "cDescricao"      , "TNC"    , STR0064		, "@!"		, 45, /*lPixel*/, {|| NGSEEK("TNG",TNC->TNC_TIPACI,1,"TNG->TNG_DESTIP") }  )  //"Descrição"    
		
		TRPosition():New (oSection4, "TNC", 1, {|| xFilial("TNC") + TRBTNC->ACIDENTE } )        

		//********************* Secao 2 - Despesas
		oSection2 := TRSection():New (oReport,STR0020, {"TNM","TNL"} )//"Despesa"
		oCell := TRCell():New (oSection2, "TNL_NOMDES", "TNL", STR0020, "@!"             , 45, .T./*lPixel*/, /*{|| code-block de impressao }*/ ) //"Despesa"
		oCell := TRCell():New (oSection2, "TNM_VALDES", "TNM", STR0021, "@E 9,999,999.99", 18,.T./*lPixel*/, /*{|| code-block de impressao }*/ ) //"Valor (R$)"
		oSection2:nLeftMargin := 3
		TRPosition():New (oSection2, "TNL", 1, {|| xFilial("TNL") + TNM->TNM_CODDES } )           

		oReport:SetTotalInLine(.T.)
		oReport:SetTotalText(STR0025)  //Total Geral de Despesas
		oBreak1 := TRBreak():New(oSection2,".T.",STR0024,.F.)  //"Total de despesas com esse acidente"
		TRFunction():New(oSection2:Cell("TNM_VALDES"),/*cId*/,"SUM",oBreak1,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)

		oSection3 := TRSection():New (oReport,STR0025, {"TNM","TNL"} )//"Total Geral de despesas"
		oBreak2 := TRBreak():New(oSection3,".T.",STR0025+" ("+STR0021+")",.F.)  //"Total Geral de despesas"###"Valor (R$)"
		TRFunction():New(oSection2:Cell("TNM_VALDES"),/*cId*/,"SUM",oBreak2,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)
		oSection1:Cell("TNC_DESACI"):lLineBreak := .T.  
     	oSection1:Cell("TM0_NOMFIC"):lLineBreak := .T.   
	Endif 


Endif  

Return .T.