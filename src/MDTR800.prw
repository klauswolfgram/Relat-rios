/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR800.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 2 //Versao do fonte
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR800
Fornecedores de EPI.                                        
Mostrando para cada fornecedor os EPI'S fornecidos.         
Inicia pela tabel TN3, obtem o nome do fornecedor na tabela 
SA2 e o nome do produto na tabela SB1.   

@author Thiago Machado 
@since 11/08/2000
/*/
//---------------------------------------------------------------------
User Function MDTR800()
//----------------------------------------------------------------
// Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  
//----------------------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

Local oReport 
Local aArea := GetArea()
Local nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,20,(TAMSX3("B1_COD")[1]))
Private oTempTRB1, oTempTRB2, oTempTRB3, oTempTRB4

nSizeSA2 := If((TAMSX3("A2_COD")[1]) < 1,6,(TAMSX3("A2_COD")[1]))
nSizeLoj := If((TAMSX3("A2_LOJA")[1]) < 1,2,(TAMSX3("A2_LOJA")[1]))

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
cCliMdtps := ""
nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
nSizeTD := nTa1+nTa1L
cPerg := If(!lSigaMdtps,"MDT800    ","MDT800PS  ")

Private lRelPer  := .T.

/*------------------------------------------------
//PERGUNTA PADRÃO										|
| MDT800    01      De  Fornecedor ?				|
| MDT800    02      Ate Fornecedor ?				|
| MDT800    03      De  EPI ?						|
| MDT800    04      Ate EPI ?						|
| MDT800    05      Classificar Por ?				|
| MDT800    06      Listar Especificação EPI ?	|
|														|
//PERGUNTAS PRESTADOR DE SERVIÇO					|
| 		   01       De Cliente ?						|
|		   02       Loja								|
|		   03       Até Cliente ?					|
|		   04       Loja								|
| MDT800    01      De  Fornecedor ?				|
| MDT800    02      Ate Fornecedor ?				|
| MDT800    03      De  EPI ?						|
| MDT800    04      Ate EPI ?						|
| MDT800    05      Classificar Por ?				|
| MDT800    06      Listar Especificação EPI ?	|
-------------------------------------------------*/
  
If TRepInUse()
   	//-- Interface de impressao
  	oReport := ReportDef()
	oReport:SetPortrait()
	oReport:PrintDialog()
Else
   lRelPer := .F.
   U_MDTR800R3()
EndIf        

RestArea(aArea)

//----------------------------------------------------------------
// Devolve variaveis armazenadas (NGRIGHTCLICK)                          
//----------------------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)
 
Return .T.
 
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Retorna as definicoes de locais do risco

Define as secoes impressas no relatorio 

@author Andre E. Perez Alvarez
@since 31/07/2006 
/*/
//---------------------------------------------------------------------
Static Function ReportDef()

	Static oReport
	Static oSection0
	Static oSection1
	Static oSection2
	Static oCell

	//LAYOUT ------------- mv_par05 == 1 (classificar por EPI)
	/*        1         2         3         4         5         6         7         8         9       100       110       120       130 
	012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	____________________________________________________________________________________________________________________________________
														
														Fornecedores de Epi              
	____________________________________________________________________________________________________________________________________

	EPI       Nome Do EPI                         C.A.            Avaliacao   Validade    Dias Durabil.    Devolver
	________________________________________________________________________________________________________________
	xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxx    xx/xx/xx    xx/xx/xx              xx          Nao
			Observacao: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	Fornecedor   Loja   Nome Do Fornecedor                        Quantidade  Tamanho
	_________________________________________________________________________________

	123456      12      1234567890123456789012345678901234567890       (    )   (    )  
	123456      12      1234567890123456789012345678901234567890       (    )   (    ) 
	123456      12      1234567890123456789012345678901234567890       (    )   (    ) 

	*/ 


	//LAYOUT ------------------ mv_par05 == 2 (classificar por Fornecedor)
	/*        1         2         3         4         5         6         7         8         9       100       110       120       130 
	012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	____________________________________________________________________________________________________________________________________
														
														Fornecedores de Epi               
	____________________________________________________________________________________________________________________________________

	Fornecedor  Loja    Nome Do Fornecedor
	________________________________________________________________________________________________________________
	123456      12      1234567890123456789012345678901234567890


	EPI       Nome Do EPI                         C.A.            Avaliacao   Validade    Dias Durabil.    Devolver
	________________________________________________________________________________________________________________
	xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxx    xx/xx/xx    xx/xx/xx              xx          Nao
			Observacao: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxx    xx/xx/xx    xx/xx/xx              xx          Nao
			Observacao: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	________________________________________________________________________________________________________________

	*/

	//--------------------------------------------------------------------------
	// Criacao do componente de impressao                                      
	//                                                                        
	// TReport():New                                                           
	// ExpC1 : Nome do relatorio                                               
	// ExpC2 : Titulo                                                          
	// ExpC3 : Pergunte                                                        
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  
	// ExpC5 : Descricao                                                       
	//                                                                        
	//--------------------------------------------------------------------------
	oReport := TReport():New("MDTR800",OemToAnsi(STR0007),cPerg,{|oReport| ReportPrint()},;  //"Fornecedores de Epi's"
			STR0001+" "+STR0002)

	//----------------------------------------------------------------
	// Variaveis utilizadas para parametros                         
	// mv_par01             // Fornecedor De                        
	// mv_par02             // Fornecedor Ate                       
	// mv_par03             // EPI  De                              
	// mv_par04             // EPI  Ate                             
	// mv_par05             // Classificar EPI  (Epi / Fornecedor)  
	// mv_par06             // Listar Especificacao (Sim / Nao)     
	//----------------------------------------------------------------
	Pergunte(oReport:uParam,.F.)

	U_MDT800SEC()
	
Return oReport

//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o relatorio.   

@author Andre E. Perez Alvarez
@since 31/07/2006 
/*/
//---------------------------------------------------------------------
Static Function ReportPrint()

	Local cClient := ""

	Processa( {|lEND| TRBgrava()}, STR0025 ,STR0026 ) //"Aguarde" ## "Processando os Fornecedores de EPI..."	

	If lSigaMdtps

		dbSelectArea("TRB")
		dbGoTop()
		
		If mv_par11 == 1	//Classificar por EPI
		
			While !oReport:Cancel()		.And.;
				!Eof()          
			
				If cClient <> TRB->CLIENT+TRB->LOJACL
					cClient := TRB->CLIENT+TRB->LOJACL
					oSection0:Init()
					oSection0:PrintLine()
				Endif
				
				cEpi := TRB->EPI
				oSection1:Init()
				oSection1:PrintLine()
				oSection2:Init()
				While !oReport:Cancel()		.And.;
					!Eof()				.And.; 
					cEpi = TRB->EPI       .And.;
					cClient = TRB->CLIENT+TRB->LOJACL			  	  
					oSection2:PrintLine()
					If (mv_par12 == 1) .and. !Empty(TRB->OBS)
						oReport:PrintText(STR0033 + ": " + AllTrim(TRB->OBS), , 60 )//"Observacao"
					EndIf
					DbSkip()
				End
				oSection2:Finish()
				oSection1:Finish()      
				If cClient <> TRB->CLIENT+TRB->LOJACL
					oSection0:Finish()      			
				Endif			
			
			End
		
		Else  //Classificar por Fornecedor
		
			While !oReport:Cancel()		.And.;
				!Eof()          
			
				If cClient <> TRB->CLIENT+TRB->LOJACL
					cClient := TRB->CLIENT+TRB->LOJACL
					oSection0:Init()
					oSection0:PrintLine()
				Endif
				
				cFornec := TRB->FORNEC
				cLoja   := TRB->LOJA
				oSection1:Init()
				oSection1:PrintLine()
				oSection2:Init()
				While !oReport:Cancel()		 .And.;
					!Eof()				 .And.; 
					cFornec = TRB->FORNEC	 .AND.;
					cLoja = TRB->LOJA      .And.;
					cClient = TRB->CLIENT+TRB->LOJACL			  	  			  	  
					
					oSection2:PrintLine()
					If (mv_par12 == 1) .and. !Empty(TRB->OBS)
						oReport:PrintText(STR0033 + ": " + AllTrim(TRB->OBS), , 60 )//"Observacao"
					EndIf
					DbSkip()
				End
				oSection2:Finish()
				oSection1:Finish()      
				If cClient <> TRB->CLIENT+TRB->LOJACL
					oSection0:Finish()      			
				Endif			
			
			End
		
		Endif

	Else

		dbSelectArea("TRB")
		dbGoTop()
		
		If mv_par05 == 1	//Classificar por EPI
		
			While !oReport:Cancel()		.And.;
				!Eof()          
			
				cEpi := TRB->EPI
				oSection1:Init()
				oSection1:PrintLine()

				oSection2:Init()
				While !oReport:Cancel()		.And.;
					!Eof()				.And.; 
					cEpi = TRB->EPI
					
					oSection2:PrintLine()
					If (mv_par06 == 1) .and. !Empty(TRB->OBS)
						oReport:PrintText(STR0033 + ": " + AllTrim(TRB->OBS), , 60 )//"Observacao"		
					EndIf
					DbSkip()
				End
				oSection2:Finish()
				oSection1:Finish()      
			
			End
		
		Else  //Classificar por Fornecedor
		
			While !oReport:Cancel()		.And.;
				!Eof()          
			
				cFornec := TRB->FORNEC
				cLoja   := TRB->LOJA
				oSection1:Init()
				oSection1:PrintLine()
				oSection2:Init()
				While !oReport:Cancel()		 .And.;
					!Eof()				 .And.; 
					cFornec = TRB->FORNEC	 .AND.;
					cLoja = TRB->LOJA 
					
					oSection2:PrintLine()
					If (mv_par06 == 1) .and. !Empty(TRB->OBS)
						oReport:PrintText(STR0033 + ": " + AllTrim(TRB->OBS), , 60 )//"Observacao"
					EndIf
					DbSkip()
				End
				oSection2:Finish()
				oSection1:Finish()      
			
			End
		
		Endif

	Endif

	//use
	If Select("TRB") > 0
		dbSelectArea("TRB")  //Antes dos Return
		If lSigaMdtps
			oTempTRB1:Delete()
		Else	
			oTempTRB2:Delete()
		EndIf	
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} TRBgrava

Processa os fornecedores de epi de acordo com os parametros
e grava no arquivo temporario. 

@author Andre E. Perez Alvarez
@since 31/07/2006 
/*/
//---------------------------------------------------------------------
Static Function TRBgrava()
Local nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,20,(TAMSX3("B1_COD")[1]))
If lSigaMdtps

	aDBF := {}  
	AADD(aDBF,{"CLIENT","C",nTa1,0}) 
	AADD(aDBF,{"LOJACL","C",nTa1L,0}) 	
	AADD(aDBF,{"FORNEC","C",nSizeSA2,0}) 
	AADD(aDBF,{"LOJA"  ,"C",nSizeLoj,0}) 
	AADD(aDBF,{"EPI"   ,"C",nSizeCod,0}) 
	AADD(aDBF,{"NUMCAP","C",12,0}) 
	AADD(aDBF,{"INDEVO","C",03,0}) 
	AADD(aDBF,{"DATAVA","D",08,0})
	AADD(aDBF,{"DTVENC","D",08,0}) 
	AADD(aDBF,{"DURABI","N",04,0})
	AADD(aDBF,{"OBS"   ,"C",240,0})
	AADD(aDBF,{"TPDURA","C",5,0})
	
	//Cria TRB
	oTempTRB1 := FWTemporaryTable():New( "TRB", aDBF )
	If mv_par11 == 1
		oTempTRB1:AddIndex( "1", {"CLIENT","LOJACL","EPI","FORNEC","LOJA"} )
	Else
		oTempTRB1:AddIndex( "1", {"CLIENT","LOJACL","FORNEC","LOJA","EPI","NUMCAP"} )
	EndIf
	oTempTRB1:Create()

	dbSelectArea("TN3")
	dbSetOrder(05)  //TN3_FILIAL+TN3_CLIENT+TN3_LOJACL+TN3_FORNEC+TN3_LOJA+TN3_CODEPI+TN3_NUMCAP
	dbSeek(xFilial("TN3")+MV_PAR01+MV_PAR02,.t.)
	oReport:SetMeter(LastRec())
	
	While !oReport:Cancel()                  .And.;
	      !Eof()                           	 .AND.;
	      TN3->TN3_FILIAL == xFIlial('TN3')	 .AND.;
	      TN3->(TN3_CLIENT+TN3_LOJACL) >= mv_par01+mv_par02 .and. TN3->(TN3_CLIENT+TN3_LOJACL) <= mv_par03+mv_par04
	       
		oReport:IncMeter()
	
		If (TN3->TN3_CODEPI < MV_PAR09) .OR. (TN3->TN3_CODEPI > MV_PAR10) .OR. (TN3->TN3_FORNEC+TN3->TN3_LOJA < MV_PAR05+MV_PAR06) .OR.;
			(TN3->TN3_FORNEC+TN3->TN3_LOJA > MV_PAR07+MV_PAR08)

			dbSelectArea("TN3")
			dbSkip()
			loop
		Endif
	
		dbSelectArea("TRB")
		TRB->(DbAppend())
		TRB->CLIENT    := TN3->TN3_CLIENT
		TRB->LOJACL    := TN3->TN3_LOJACL
		TRB->FORNEC    := TN3->TN3_FORNEC 
		TRB->EPI       := TN3->TN3_CODEPI
		TRB->DATAVA    := TN3->TN3_DTAVAL 
		TRB->LOJA      := TN3->TN3_LOJA
		TRB->NUMCAP    := TN3->TN3_NUMCAP
		TRB->DTVENC    := TN3->TN3_DTVENC
		TRB->DURABI    := TN3->TN3_DURABI
		If TN3->TN3_INDEVO == "1"
			TRB->INDEVO := STR0010//Sim    	
		ElseIf TN3->TN3_INDEVO == "2" 
			TRB->INDEVO := STR0011//Nao
		Endif
		TRB->OBS       := TN3->TN3_OBSAVA
		If TN3->TN3_TPDURA == "U"
			TRB->TPDURA    := STR0034//"Uso"
		ElseIf TN3->TN3_TPDURA == "G"
			TRB->TPDURA    := STR0035//"Geral"
		Else
			TRB->TPDURA    := ""
		Endif

		dbSelectArea("TN3")
		dbskip()
	End

Else

	aDBF := {}
	AADD(aDBF,{"FORNEC","C",nSizeSA2,0}) 
	AADD(aDBF,{"LOJA"  ,"C",nSizeLoj,0}) 
	AADD(aDBF,{"EPI"   ,"C",nSizeCod,0}) 
	AADD(aDBF,{"NUMCAP","C",12,0}) 
	AADD(aDBF,{"INDEVO","C",03,0}) 
	AADD(aDBF,{"DATAVA","D",08,0})
	AADD(aDBF,{"DTVENC","D",08,0}) 
	AADD(aDBF,{"DURABI","N",04,0})
	AADD(aDBF,{"OBS"   ,"C",240,0})
	AADD(aDBF,{"TPDURA","C",5,0})
		
	oTempTRB2 := FWTemporaryTable():New( "TRB", aDBF )
	If mv_par05 == 1
		oTempTRB2:AddIndex( "1", {"EPI","FORNEC","LOJA"} )
	Else
		oTempTRB2:AddIndex( "1", {"FORNEC","LOJA","EPI","NUMCAP"} )
	EndIf
	oTempTRB2:Create()
		
	dbSelectArea("TN3")
	dbSetOrder(01)
	dbSeek(xFilial("TN3")+MV_PAR01,.t.)
	oReport:SetMeter(LastRec())
	
	While !oReport:Cancel()                  .And.;
	      !Eof()                           	 .AND.;
	      TN3->TN3_FILIAL == xFIlial('TN3')	 .AND.;
	      TN3->TN3_FORNEC <= MV_PAR02
	       
		oReport:IncMeter()
	
		If (TN3->TN3_CODEPI < MV_PAR03) .OR. (TN3->TN3_CODEPI > MV_PAR04)
			dbSelectArea("TN3")
			dbSkip()
			loop
		Endif
	
		dbSelectArea("TRB")
		TRB->(DbAppend())
		TRB->FORNEC    := TN3->TN3_FORNEC 
		TRB->EPI       := TN3->TN3_CODEPI
		TRB->DATAVA    := TN3->TN3_DTAVAL 
		TRB->LOJA      := TN3->TN3_LOJA
		TRB->NUMCAP    := TN3->TN3_NUMCAP
		TRB->DTVENC    := TN3->TN3_DTVENC
		TRB->DURABI    := TN3->TN3_DURABI
		If TN3->TN3_INDEVO == "1"
			TRB->INDEVO := STR0010//SIM
		ElseIf TN3->TN3_INDEVO == "2" 
			TRB->INDEVO := STR0011//NAO
		Endif
		TRB->OBS       := TN3->TN3_OBSAVA
		If TN3->TN3_TPDURA == "U"
			TRB->TPDURA    := STR0034//"Uso"
		ElseIf TN3->TN3_TPDURA == "G"
			TRB->TPDURA    := STR0035//"Geral"
		Else
			TRB->TPDURA    := ""
		Endif
		dbSelectArea("TN3")
		dbskip()
	End

Endif


Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} TAMSX3_
Retorna tamanho do campo no SX3.

@param cCampo - Campo utilizado.
@param nDefault - Velor padrão.

@author Andre E. Perez Alvarez
@since 31/07/2006 
/*/
//---------------------------------------------------------------------
Static Function TAMSX3_(cCampo, nDefault)

nTamanho := If( (TAMSX3(cCampo)[1]) < 1, nDefault, (TAMSX3(cCampo)[1]) )

Return nTamanho

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR800R3
Fornecedores de EPI.                                    
Mostrando para cada fornecedor os EPI'S fornecidos.       
Inicia pela tabel TN3, obtem o nome do fornecedor na tabela
SA2 e o nome do produto na tabela SB1.  

@author Thiago Machado 
@since 11/08/2000
/*/
//---------------------------------------------------------------------
User Function MDTR800R3()

//----------------------------------------------------------------
// Define Variaveis                                            
//----------------------------------------------------------------
LOCAL cString := "TN3"
LOCAL wnrel   := "MDTR800"
LOCAL cDesc1  := STR0001 //"Relatorio de apresentacao dos fornecedores de EPI's "
LOCAL cDesc2  := STR0002 //"e numero do certificado de aprovacao do fornecedor. "
LOCAL cDesc3  := " "

LOCAL aOrd    := {STR0003,STR0004} //" Fornecedor/EPI"###" EPI/Fornecedor "
Local nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,20,(TAMSX3("B1_COD")[1]))    

PRIVATE aReturn  := { STR0005, 1,STR0006, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE nomeprog := "MDTR800"
PRIVATE tamanho  := "M"
PRIVATE titulo   := STR0007 //"Fornecedores de EPI's"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2

//----------------------------------------------------------------
// Verifica as perguntas selecionadas                           
//----------------------------------------------------------------
pergunte(cPerg,.F.)
//----------------------------------------------------------------
// Variaveis utilizadas para parametros                         
// mv_par01             // Fornecedor De                        
// mv_par02             // Fornecedor Ate                       
// mv_par03             // EPI  De                              
// mv_par04             // EPI  Ate                             
// mv_par05             // Classificar EPI  (Epi/ Fornecedor)   
// mv_par06             // Listar Especificacao                 
//----------------------------------------------------------------
//----------------------------------------------------------------
// Envia controle para a funcao SETPRINT                        
//----------------------------------------------------------------

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
        Set Filter to
        Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
        Set Filter to
   Return
Endif

#IFDEF WINDOWS
	tamanho := "G"
    RptStatus({|lEnd| R800Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
#ELSE
	R800Imp(.F.,wnRel,titulo,tamanho)
#ENDIF
Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} R800Imp
Chama Relatório

@param lEnd - Cancela a impressão.
@param wnRel - Programa utilizado.
@param titulo - Titulo do relatório.
@param tamanho - Tamanho do relatório. 

@author Thiago Machado 
@since 11/08/2000
/*/
//---------------------------------------------------------------------
Static Function R800Imp(lEnd,wnRel,titulo,tamanho)

//----------------------------------------------------------------
// Define Variaveis                                             
//----------------------------------------------------------------
Local lPri := .T.
Local cCliente := ""

//----------------------------------------------------------------
// Variaveis locais exclusivas deste programa                   
//----------------------------------------------------------------
LOCAL lContinua        := .T.
Local nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,20,(TAMSX3("B1_COD")[1]))

//----------------------------------------------------------------
// Contadores de linha e pagina                                 
//----------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1
Tamanho := "G"

//----------------------------------------------------------------
// Verifica se deve comprimir ou nao                            
//----------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)


//----------------------------------------------------------------
// Monta os Cabecalhos                                          
//----------------------------------------------------------------         
cabec1 := ""
cabec2 := ""
If lSigaMdtps
	If mv_par11 == 1
		cabec1 := STR0046
		cabec2 := Space(4) + STR0045 + Space(3) + STR0036 + Space(3) + STR0044 //"Qtde.  Tam.    "
	Else
		cabec1 := STR0008
		cabec2 := Space(4) + STR0012 + Space(6) + STR0036
	EndIf
Else
	If mv_par05 == 1
		cabec1 := STR0046
		cabec2 := Space(4) + STR0045 + Space(3) + STR0036 + Space(3) + STR0044 //"Qtde.  Tam.    "
	Else
		cabec1 := STR0008
		cabec2 := Space(4) + STR0012 + Space(6) + STR0036
	EndIf
Endif

/*
Classificar por EPI

          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
EPI                                   Nome Do EPI
    Fornecedor            Loja  Nome Do Fornecedor                         C.A.            Avaliacao    Validade   Dias Durabil.    Devolver   Qtde.  Tam.    Observacao
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
xxxxxxxxxxxxxxx                       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    xxxxxxxxxxxxxxxxxxxx  xxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx    xxxxxxxxxxxx    99/99/99     99/99/99            9999    SIM/NAO    (   )  (   )   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx



Classificar por Fornecedor

          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
-------------------------------------------------------------------------------------------------------------------------------------
Fornecedor            Loja  Nome Do Fornecedor                                
    EPI              Nome Do EPI                     C.A.          Avaliacao   Dias    Durabil.    Devolver
-------------------------------------------------------------------------------------------------------------------------------------
xxxxxxxxxxxxxxxxxxxx  xxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    xxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx  xx/xx/xxxx  xxxx    xxx         xxx
    

*/


If lSigaMdtps

	aDBF := {}
	AADD(aDBF,{"CLIENT","C",nTa1,0}) 
	AADD(aDBF,{"LOJACL","C",nTa1L,0})
	AADD(aDBF,{"FORNEC","C",nSizeSA2,0})
	AADD(aDBF,{"LOJA"  ,"C",nSizeLoj,0})
	AADD(aDBF,{"EPI"   ,"C",nSizeCod,0})
	AADD(aDBF,{"NUMCAP","C",12,0}) 
	AADD(aDBF,{"INDEVO","C",01,0}) 
	AADD(aDBF,{"DATAVA","D",08,0})
	AADD(aDBF,{"DTVENC","D",08,0}) 
	AADD(aDBF,{"DURABI","N",04,0})
	AADD(aDBF,{"OBS"   ,"C",240,0})
	AADD(aDBF,{"TPDURA","C",5,0})

	oTempTRB3 := FWTemporaryTable():New( "TRB", aDBF )
	If mv_par11 == 1
		oTempTRB3:AddIndex( "1", {"CLIENT","LOJACL","EPI","FORNEC","LOJA"} )
	Else
		oTempTRB3:AddIndex( "1", {"CLIENT","LOJACL","FORNEC","LOJA","EPI","NUMCAP"} )
	EndIf
	oTempTRB3:Create()

	dbSelectArea("TN3")
	dbSetOrder(05)  //TN3_FILIAL+TN3_CLIENT+TN3_LOJACL+TN3_FORNEC+TN3_LOJA+TN3_CODEPI+TN3_NUMCAP
	dbSeek(xFilial("TN3")+MV_PAR01+MV_PAR02,.t.)
	
	SetRegua(LastRec())
	While lContinua 							.And.;
	      !Eof()     							.And.;
	      TN3->TN3_FILIAL == xFIlial('TN3')	.And.;
	      TN3->TN3_CLIENT+TN3->TN3_LOJACL >= mv_par01+mv_par02 .and. TN3->TN3_CLIENT+TN3->TN3_LOJACL <= mv_par03+mv_par04
	       	
		IncRegua()
		
		If TN3->TN3_CODEPI < MV_PAR09 .OR. TN3->TN3_CODEPI > MV_PAR10 .OR. TN3->TN3_FORNEC+TN3->TN3_LOJA < MV_PAR05+MV_PAR06 .OR. ;
			TN3->TN3_FORNEC+TN3->TN3_LOJA > MV_PAR07+MV_PAR08

			dbSelectArea("TN3")
			dbSKIP()
			loop
		EndIf
	
		dbSelectArea("TRB")
		TRB->(DbAppend())
		TRB->CLIENT    := TN3->TN3_CLIENT
		TRB->LOJACL    := TN3->TN3_LOJACL
		TRB->FORNEC    := TN3->TN3_FORNEC
		TRB->EPI       := TN3->TN3_CODEPI
		TRB->DATAVA    := TN3->TN3_DTAVAL 
		TRB->LOJA      := TN3->TN3_LOJA
		TRB->NUMCAP    := TN3->TN3_NUMCAP
		TRB->DTVENC    := TN3->TN3_DTVENC
		TRB->DURABI    := TN3->TN3_DURABI
		TRB->INDEVO    := TN3->TN3_INDEVO
		TRB->OBS       := TN3->TN3_OBSAVA
		If TN3->TN3_TPDURA == "U"
			TRB->TPDURA    := STR0034//"Uso"
		ElseIf TN3->TN3_TPDURA == "G"
			TRB->TPDURA    := STR0035//"Geral"
		Else
			TRB->TPDURA    := ""
		Endif
				
		dbSelectArea("TN3")
		dbskip()
	End
	
	dbSelectArea("TRB")
	dbGOTOP()

	If !Eof()
    	Somalinha()	
	Endif	

	While !Eof()  
	
	    If cCliente <> TRB->CLIENT+TRB->LOJACL
	    	If !lPri
		    	@Li,000 PSAY Replicate("-",132)
			    Somalinha()	    		    	
	    	Endif
	    	dbSelectArea("SA1")
	    	dbSetOrder(1)
	    	dbSeek(xFilial("SA1")+TRB->CLIENT+TRB->LOJACL)
	    	@Li,000 PSAY STR0032 + Alltrim(TRB->CLIENT) + "-" + Alltrim(TRB->LOJACL) + " - " + AllTrim(SA1->A1_NOME)  //"Cliente: "
		    cCliente := TRB->CLIENT + TRB->LOJACL
		    Somalinha()
	    Endif					
		
		If mv_par11 == 1
			
			cEPI := TRB->EPI
			Somalinha() 
			dbSelectArea("SB1")
			dbSetOrder(01)
			dbSeek(xFilial("SB1")+TRB->EPI)	
			@ Li,000 PSay TRB->EPI PICTURE "@!"
			@ Li,038 PSay Left(SB1->B1_DESC,35) PICTURE "@!"
	
			while ! eof() .and. TRB->EPI == cEPI .and. TRB->CLIENT+TRB->LOJACL == cCliente
				Somalinha()
				dbSelectArea("SA2")
				dbSetOrder(01)
				dbSeek(xFilial("SA2")+TRB->FORNEC+TRB->LOJA)
				@ Li,004 PSay TRB->FORNEC
				@ Li,026 PSay TRB->LOJA
				@ Li,034 PSay Substr(SA2->A2_NOME,1,40) PICTURE "@!"
				@ Li,077 PSay TRB->NUMCAP PICTURE "@!"
				@ Li,093 PSay TRB->DATAVA PICTURE "99/99/99"
				@ Li,107 PSay TRB->DTVENC
				@ Li,138 PSay TRB->DURABI PICTURE "@!"
				
				If TRB->INDEVO = "1"
					@ Li,134 PSay STR0010 //"SIM"
				ELSEIF TRB->INDEVO = "2"
					@ Li,134 PSay STR0011 //"NAO"
				EndIf
				
				@ Li,196 PSay TRB->TPDURA PICTURE "@!"
				@ Li,212 PSay "(   )  (   )"
				If mv_par12 == 1 .and. !Empty(TRB->OBS)
					Somalinha()
					@ Li,004 PSay STR0033+": "+TRB->OBS
				EndIf
				
				DbSelectArea("TRB")
				dbSKIP()
			EndDo
			Somalinha()
		Else
			cFORNEC := TRB->FORNEC
			cLOJAFO := TRB->LOJA
			Somalinha() 
			dbSelectArea("SA2")
			dbSetOrder(01)
			dbSeek(xFilial("SA2")+TRB->FORNEC+TRB->LOJA)
			@ Li,000 PSay TRB->FORNEC
			@ Li,012 PSay TRB->LOJA
			@ Li,020 PSay SA2->A2_NOME PICTURE "@!"
		
			while ! eof() .and. TRB->FORNEC == cFORNEC .and. cLOJAFO == TRB->LOJA .and. TRB->CLIENT+TRB->LOJACL == cCliente
				Somalinha()
				dbSelectArea("SB1")
				dbSetOrder(01)
				dbSeek(xFilial("SB1")+TRB->EPI)
				@ Li,004 PSay TRB->EPI PICTURE "@!"
				@ Li,042 PSay Left(SB1->B1_DESC,35) PICTURE "@!"
				@ Li,081 PSay TRB->NUMCAP PICTURE "@!"
				@ Li,097 PSay TRB->DATAVA PICTURE "99/99/99"
				@ Li,110 PSay TRB->DTVENC
				@ Li,132 PSay TRB->DURABI PICTURE "@!"
				If TRB->INDEVO = "1"
					@ Li,138 PSay STR0010 //"SIM"
				ELSEIF TRB->INDEVO = "2"
					@ Li,138 PSay STR0011 //"NAO"
				ENDIF
				@ Li,152 PSay TRB->TPDURA PICTURE "@!"
				If mv_par12 == 1 .and. !Empty(TRB->OBS)
					Somalinha()
					@ Li,004 PSay STR0033+": "+TRB->OBS
				EndIf				
				DbSelectArea("TRB")
				dbSKIP()
			Enddo
			Somalinha()
		EndIf
		
		lPri := .F.
			
	Enddo

Else

	aDBF := {}
	AADD(aDBF,{"FORNEC","C",nSizeSA2,0}) 
	AADD(aDBF,{"LOJA"  ,"C",nSizeLoj,0}) 
	AADD(aDBF,{"EPI"   ,"C",nSizeCod,0}) 
	AADD(aDBF,{"NUMCAP","C",12,0}) 
	AADD(aDBF,{"INDEVO","C",01,0}) 
	AADD(aDBF,{"DATAVA","D",08,0})
	AADD(aDBF,{"DTVENC","D",08,0}) 
	AADD(aDBF,{"DURABI","N",04,0})
	AADD(aDBF,{"OBS"   ,"C",240,0})
	AADD(aDBF,{"TPDURA","C",5,0})
	
	//Cria TRB
	oTempTRB4 := FWTemporaryTable():New( "TRB", aDBF )
	If mv_par05 == 1
		oTempTRB4:AddIndex( "1", {"EPI","FORNEC","LOJA"} )
	Else
		oTempTRB4:AddIndex( "1", {"FORNEC","LOJA","EPI","NUMCAP"} )
	EndIf
	oTempTRB4:Create()
	
	dbSelectArea("TN3")
	dbSetOrder(01)
	dbSeek(xFilial("TN3")+MV_PAR01,.t.)
	
	SetRegua(LastRec())
	While lContinua                               .And.;
	      !Eof()                                 .AND.;
	      TN3->TN3_FILIAL == xFIlial('TN3')     .AND.;
	      TN3->TN3_FORNEC <= MV_PAR02
	       
		#IFNDEF WINDOWS
			If LastKey() = 286    //ALT_A
				lEnd := .t.
			End
		#ENDIF
	
		If lEnd
			@ PROW()+1,001 PSay STR0009 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
	
		IncRegua()
	
		If TN3->TN3_CODEPI < MV_PAR03 .OR. TN3->TN3_CODEPI > MV_PAR04
			dbSelectArea("TN3")
			dbSKIP()
			loop
		Endif
	
		dbSelectArea("TRB")
		TRB->(DbAppend())
		TRB->FORNEC    := TN3->TN3_FORNEC 
		TRB->EPI       := TN3->TN3_CODEPI
		TRB->DATAVA    := TN3->TN3_DTAVAL 
		TRB->LOJA      := TN3->TN3_LOJA
		TRB->NUMCAP    := TN3->TN3_NUMCAP
		TRB->DTVENC    := TN3->TN3_DTVENC
		TRB->DURABI    := TN3->TN3_DURABI
		TRB->INDEVO    := TN3->TN3_INDEVO
		TRB->OBS       := TN3->TN3_OBSAVA
		If TN3->TN3_TPDURA == "U"
			TRB->TPDURA    := STR0034//"Uso"
		ElseIf TN3->TN3_TPDURA == "G"
			TRB->TPDURA    := STR0035//"Geral"
		Else
			TRB->TPDURA    := ""
		Endif
		
		dbSelectArea("TN3")
		dbskip()
	End
	
	dbSelectArea("TRB")
	dbGOTOP()
	
	While !Eof()  
	
		If mv_par05 == 1
			cEPI := TRB->EPI
			Somalinha() 
			dbSelectArea("SB1")
			dbSetOrder(01)
			dbSeek(xFilial("SB1")+TRB->EPI)	
			@ Li,000 PSay TRB->EPI PICTURE "@!"
			@ Li,037 PSay Left(SB1->B1_DESC,35) PICTURE "@!"
	
			while ! eof() .and. TRB->EPI == cEPI
				Somalinha()
				dbSelectArea("SA2")
				dbSetOrder(01)
				dbSeek(xFilial("SA2")+TRB->FORNEC+TRB->LOJA)
				@ Li,004 PSay TRB->FORNEC
				@ Li,026 PSay TRB->LOJA
				@ Li,032 PSay Substr(SA2->A2_NOME,1,40) PICTURE "@!"
				@ Li,075 PSay TRB->NUMCAP PICTURE "@!"
				@ Li,091 PSay TRB->DATAVA PICTURE "99/99/99"
				@ Li,104 PSay TRB->DTVENC
				@ Li,124 PSay TRB->DURABI PICTURE "9999"
				
				If TRB->INDEVO = "1"
					@ Li,132 PSay STR0010 //"SIM"
				ELSEIF TRB->INDEVO = "2"
					@ Li,132 PSay STR0011 //"NAO"
				ENDIF
				
				@ Li,143 PSay TRB->TPDURA PICTURE "@!"
				@ Li,159 PSay "(   )  (   )"
				If mv_par06 == 1 .and. !Empty(TRB->OBS)
					Somalinha()
					@ Li,004 PSay STR0033+": "+TRB->OBS
				EndIf
				
				DbSelectArea("TRB")
				dbSKIP()
			Enddo
			Somalinha()
			somalinha()	
		Else
			cFORNEC := TRB->FORNEC
			cLOJAFO := TRB->LOJA
			Somalinha() 
			dbSelectArea("SA2")
			dbSetOrder(01)
			dbSeek(xFilial("SA2")+TRB->FORNEC+TRB->LOJA)
			@ Li,000 PSay TRB->FORNEC
			@ Li,022 PSay TRB->LOJA
			@ Li,028 PSay SA2->A2_NOME PICTURE "@!"
		
			while ! eof() .and. TRB->FORNEC == cFORNEC .and. cLOJAFO == TRB->LOJA
				Somalinha()
				dbSelectArea("SB1")
				dbSetOrder(01)
				dbSeek(xFilial("SB1")+TRB->EPI)
				@ Li,004 PSay TRB->EPI PICTURE "@!"
				@ Li,042 PSay Left(SB1->B1_DESC,35) PICTURE "@!"
				@ Li,081 PSay TRB->NUMCAP PICTURE "@!"
				@ Li,097 PSay TRB->DATAVA PICTURE "99/99/99"
				@ Li,110 PSay TRB->DTVENC
				@ Li,130 PSay TRB->DURABI PICTURE "9999"
				If TRB->INDEVO = "1"
					@ Li,138 PSay STR0010 //"SIM"
				ELSEIF TRB->INDEVO = "2"
					@ Li,138 PSay STR0011 //"NAO"
				ENDIF
				@ Li,152 PSay TRB->TPDURA PICTURE "@!"
				If mv_par06 == 1 .and. !Empty(TRB->OBS)
					Somalinha()
					@ Li,004 PSay STR0033+": "+TRB->OBS
				EndIf				
				DbSelectArea("TRB")
				dbSKIP()
			Enddo
			Somalinha()
			somalinha()
		EndIf
			
	Enddo

Endif


//-------------------------------------------------------------------------
// Devolve a condicao original do arquivo principal             
//-------------------------------------------------------------------------

RetIndex("TN3")

Set Filter To

Set device to Screen

If aReturn[5] = 1
        Set Printer To
        dbCommitAll()
        OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()
              
dbSelectArea("TRB")
If lSigaMdtps 
	oTempTRB3:Delete()
Else	
	oTempTRB4:Delete()
EndIf	
dbSelectArea("TN3")
dbSetOrder(01)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina   

@author Thiago Machado 
@since 11/08/2000
/*/
//---------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return
//---------------------------------------------------------------------
/*/{Protheus.doc} MDT800SEC
Atualiza as configuracoes de secao de acordo com o parametro
Classificacao     

@author Andre Perez Alvarez
@since 09/01/2008  
/*/
//---------------------------------------------------------------------
User Function MDT800SEC()

//-------------------------------------------------------------------------
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
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
// Criacao da celulas da secao do relatorio                                
//                                                                         
// TRCell():New                                                            
// ExpO1 : Objeto TSection que a secao pertence                            
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
//-------------------------------------------------------------------------
Local nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,20,(TAMSX3("B1_COD")[1]))
Local lEsp     := .F.

If lSigaMdtPs
	If mv_par12 == 1
		lEsp := .T.
	Endif
Else
	If mv_par06 == 1
		lEsp := .T.
	Endif
Endif

If lRelPer

	oReport:Asection := {}  //Apaga as secoes dos parametros anteriores
	
	oReport:SetTotalInLine(.F.)
	
	If lSigaMdtps
		//********************* Secao 0 - Cliente
		oSection0 := TRSection():New (oReport,STR0018, {"TRB","SA1"} )  //"Cliente"
		//oSection1:SetHeaderBreak() // sempre que houver quebra imprime o cabeçalho da seção
		oCell := TRCell():New(oSection0, "TRB->CLIENT"   , "TRB"  , STR0030, "@!", nTa1 )  //"Cliente"
		oCell := TRCell():New(oSection0, "TRB->LOJACL"   , "TRB"  , STR0028, "@!", nTa1L  )  //"Loja"
		oCell := TRCell():New(oSection0, "A1_NOME"      , "SA1"  , STR0031, "@!", 40  ) //"Nome"
		TRPosition():New(oSection0, "SA1", 1, {|| xFilial("SA1") + TRB->CLIENT+TRB->LOJACL})
		
		If mv_par11 == 1 //Classificar por EPI
			
			//********************* Secao 1 - EPI
			oSection1 := TRSection():New (oReport,STR0013, {"TRB","SB1"} ) 
			oSection1:SetHeaderBreak() // sempre que houver quebra imprime o cabeçalho da seção 
			oCell := TRCell():New(oSection1, "TRB->EPI"    , "TRB", STR0013, "@!"        , nSizeCod                    	)  //"EPI"
			oCell := TRCell():New(oSection1, "B1_DESC"     , "SB1", STR0014, "@!"        , TAMSX3_("B1_DESC",40)	)  //"Nome do EPI"
			TRPosition():New(oSection1, "SB1", 1, {|| xFilial("SB1") + TRB->EPI})    
			        
			//********************* Secao 2 - Fornecedor
			oSection2 := TRSection():New (oReport,"Fornecedor", {"TRB","SA2"} )
			oCell := TRCell():New (oSection2, "TRB->FORNEC"  , "TRB", STR0020, "@!"      , nSizeSA2              , /*lPixel*/ , /*{|| code-block de impressao }*/) //"Fornecedor"
			oCell := TRCell():New (oSection2, "TRB->LOJA"    , "TRB", STR0021, "@!"      , nSizeLoj              , /*lPixel*/ , /*{|| code-block de impressao }*/) //"Loja"
			oCell := TRCell():New (oSection2, "A2_NOME"      , "SA2", STR0022, "@!"      , TAMSX3_("A2_NOME",40) , /*lPixel*/ , /*{|| code-block de impressao }*/) //"Nome do Fornecedor" 
			oCell := TRCell():New(oSection2, "TRB->NUMCAP" , "TRB", STR0015, "@!"        , 12 					  	)  //"C.A."
			oCell := TRCell():New(oSection2, "TRB->DATAVA" , "TRB", STR0016, "99/99/9999", 12                    	)  //"Avaliação"
			oCell := TRCell():New(oSection2, "TRB->DTVENC" , "TRB", STR0017, "99/99/9999", 12                   	)  //"Validade"
			oCell := TRCell():New(oSection2, "TRB->DURABI" , "TRB", STR0018, "9999"      , 04			  			)  //"Dias Durabil."
			oCell := TRCell():New(oSection2, "TRB->INDEVO" , "TRB", STR0019, "@!"        , 3 					 	)  //"Devolver"
			oCell := TRCell():New(oSection2, "TRB->TPDURA" , "TRB", STR0036, "@!"        , 5 					 	)  //"Tipo Durabil."
			oCell := TRCell():New (oSection2, STR0023   ,      , STR0023, "@!"      , 7                     , /*lPixel*/ , {|| "(     )" }                  ) //"Quantidade" 
			oCell := TRCell():New (oSection2, STR0024      ,      , STR0024, "@!"      , 7                     , /*lPixel*/ , {|| "(     )" }                  ) //"Tamanho" 
			
		
			TRPosition():New (oSection2, "SA2", 1, {|| xFilial("SA2") + TRB->FORNEC + TRB->LOJA} )      
		
		Else  //Classificar por Fornecedor
		
			//********************* Secao 1 - Fornecedor
			oSection1 := TRSection():New (oReport,STR0020, {"TRB","SA2"} )
			oSection1:SetHeaderBreak() // sempre que houver quebra imprime o cabeçalho da seção 	
			oCell := TRCell():New (oSection1, "TRB->FORNEC"  , "TRB", STR0020, "@!"      , nSizeSA2               , /*lPixel*/, /*{|| code-block de impressao }*/) //"Fornecedor"
			oCell := TRCell():New (oSection1, "TRB->LOJA"    , "TRB", STR0021, "@!"      , nSizeLoj               , /*lPixel*/, /*{|| code-block de impressao }*/) //"Loja"
			oCell := TRCell():New (oSection1, "A2_NOME"      , "SA2", STR0022, "@!"      , TAMSX3_("A2_NOME",40)  , /*lPixel*/, /*{|| code-block de impressao }*/) //"Nome do Fornecedor" 
			TRPosition():New (oSection1, "SA2", 1, {|| xFilial("SA2") + TRB->FORNEC + TRB->LOJA} )      	
			
			//********************* Secao 2 - EPI
			oSection2 := TRSection():New (oReport,STR0013, {"TRB","SB1"} ) 
			oCell := TRCell():New(oSection2, "TRB->EPI"    , "TRB", STR0013, "@!"        , nSizeCod                    	)  //"EPI"
			oCell := TRCell():New(oSection2, "B1_DESC"     , "SB1", STR0014, "@!"        , TAMSX3_("B1_DESC",40)	)  //"Nome do EPI"
			oCell := TRCell():New(oSection2, "TRB->NUMCAP" , "TRB", STR0015, "@!"        , 12 					  	)  //"C.A."
			oCell := TRCell():New(oSection2, "TRB->DATAVA" , "TRB", STR0016, "99/99/9999", 12                    	)  //"Avaliação"
			oCell := TRCell():New(oSection2, "TRB->DTVENC" , "TRB", STR0017, "99/99/9999", 12                   	)  //"Validade"
			oCell := TRCell():New(oSection2, "TRB->DURABI" , "TRB", STR0018, "9999"      , 4			  			)  //"Dias Durabil."
			oCell := TRCell():New(oSection2, "TRB->INDEVO" , "TRB", STR0019, "@!"        , 3 					 	)  //"Devolver"
			oCell := TRCell():New(oSection2, "TRB->TPDURA" , "TRB", STR0036, "@!"        , 5 					 	)  //"Tipo Durabil."

			TRPosition():New(oSection2, "SB1", 1, {|| xFilial("SB1") + TRB->EPI})    
			
		Endif		
		
	Else
	
		If mv_par05 == 1 //Classificar por EPI
			
			//********************* Secao 1 - EPI
			oSection1 := TRSection():New (oReport,STR0013, {"TRB","SB1"} ) 
			oSection1:SetHeaderBreak() // sempre que houver quebra imprime o cabeçalho da seção 
			oCell := TRCell():New(oSection1, "TRB->EPI"    , "TRB", STR0013, "@!"        , nSizeCod                    	)  //"EPI"
			oCell := TRCell():New(oSection1, "B1_DESC"     , "SB1", STR0014, "@!"        , TAMSX3_("B1_DESC",40)	)  //"Nome do EPI"
			TRPosition():New(oSection1, "SB1", 1, {|| xFilial("SB1") + TRB->EPI})    
			        
			//********************* Secao 2 - Fornecedor
			oSection2 := TRSection():New (oReport,STR0020, {"TRB","SA2"} )
			oCell := TRCell():New (oSection2, "TRB->FORNEC"  , "TRB", STR0020, "@!"      , nSizeSA2              , /*lPixel*/ , /*{|| code-block de impressao }*/) //"Fornecedor"
			oCell := TRCell():New (oSection2, "TRB->LOJA"    , "TRB", STR0021, "@!"      , nSizeLoj              , /*lPixel*/ , /*{|| code-block de impressao }*/) //"Loja"
			oCell := TRCell():New (oSection2, "A2_NOME"      , "SA2", STR0022, "@!"      , TAMSX3_("A2_NOME",40) , /*lPixel*/ , /*{|| code-block de impressao }*/) //"Nome do Fornecedor" 
			oCell := TRCell():New(oSection2, "TRB->NUMCAP" , "TRB", STR0015, "@!"        , 12 					  	)  //"C.A."
			oCell := TRCell():New(oSection2, "TRB->DATAVA" , "TRB", STR0016, "99/99/9999", 12                    	)  //"Avaliação"
			oCell := TRCell():New(oSection2, "TRB->DTVENC" , "TRB", STR0017, "99/99/9999", 12                   	)  //"Validade"
			oCell := TRCell():New(oSection2, "TRB->DURABI" , "TRB", STR0018, "9999"      , 04			  			)  //"Dias Durabil."
			oCell := TRCell():New(oSection2, "TRB->INDEVO" , "TRB", STR0019, "@!"        , 3 					 	)  //"Devolver"
			oCell := TRCell():New(oSection2, "TRB->TPDURA" , "TRB", STR0036, "@!"        , 5 					 	)  //"Tipo Durabil."
			
			oCell := TRCell():New (oSection2, STR0023   ,      , STR0023, "@!"      , 7                     , /*lPixel*/ , {|| "(     )" }                  ) //"Quantidade" 
			oCell := TRCell():New (oSection2, STR0024      ,      , STR0024, "@!"      , 7                     , /*lPixel*/ , {|| "(     )" }                  ) //"Tamanho" 
			
			TRPosition():New (oSection2, "SA2", 1, {|| xFilial("SA2") + TRB->FORNEC + TRB->LOJA} )      
		
		Else  //Classificar por Fornecedor
		
			//********************* Secao 1 - Fornecedor
			oSection1 := TRSection():New (oReport,STR0020, {"TRB","SA2"} )
			oSection1:SetHeaderBreak() // sempre que houver quebra imprime o cabeçalho da seção 	
			oCell := TRCell():New (oSection1, "TRB->FORNEC"  , "TRB", STR0020, "@!"      , nSizeSA2               , /*lPixel*/, /*{|| code-block de impressao }*/) //"Fornecedor"
			oCell := TRCell():New (oSection1, "TRB->LOJA"    , "TRB", STR0021, "@!"      , nSizeLoj               , /*lPixel*/, /*{|| code-block de impressao }*/) //"Loja"
			oCell := TRCell():New (oSection1, "A2_NOME"      , "SA2", STR0022, "@!"      , TAMSX3_("A2_NOME",40)  , /*lPixel*/, /*{|| code-block de impressao }*/) //"Nome do Fornecedor" 
			TRPosition():New (oSection1, "SA2", 1, {|| xFilial("SA2") + TRB->FORNEC + TRB->LOJA} )      	
			
			//********************* Secao 2 - EPI
			oSection2 := TRSection():New (oReport,STR0013, {"TRB","SB1"} ) 
			oCell := TRCell():New(oSection2, "TRB->EPI"    , "TRB", STR0013, "@!"        , nSizeCod                    	)  //"EPI"
			oCell := TRCell():New(oSection2, "B1_DESC"     , "SB1", STR0014, "@!"        , TAMSX3_("B1_DESC",40)	)  //"Nome do EPI"
			oCell := TRCell():New(oSection2, "TRB->NUMCAP" , "TRB", STR0015, "@!"        , 12 					  	)  //"C.A."
			oCell := TRCell():New(oSection2, "TRB->DATAVA" , "TRB", STR0016, "99/99/9999", 12                    	)  //"Avaliação"
			oCell := TRCell():New(oSection2, "TRB->DTVENC" , "TRB", STR0017, "99/99/9999", 12                   	)  //"Validade"
			oCell := TRCell():New(oSection2, "TRB->DURABI" , "TRB", STR0018, "9999"      , 4			  			)  //"Dias Durabil."
			oCell := TRCell():New(oSection2, "TRB->INDEVO" , "TRB", STR0019, "@!"        , 3 					 	)  //"Devolver"
			oCell := TRCell():New(oSection2, "TRB->TPDURA" , "TRB", STR0036, "@!"        , 5 					 	)  //"Tipo Durabil."
			
			TRPosition():New(oSection2, "SB1", 1, {|| xFilial("SB1") + TRB->EPI})    
			
		Endif		
	
	Endif

Endif

Return .T.
