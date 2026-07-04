/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr940.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR940
Relatorio de Restricoes por Funcionario

@author Denis Hyroshi de Souza
@since 04.09.07 
@return
/*/ 
//---------------------------------------------------------------------
User Function MDTR940()
//----------------------------------------------------------------
// Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  
//----------------------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

Local oReport 
Local aArea := GetArea()
                  
lSigaMdtPS    := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
nSizeTD := nTa1+nTa1L

cPerg := "MDT940    "
lRelPer  := .T.

IncluiSX1()

If TRepInUse()
	//If Pergunte(cPerg,.t.)
	   //-- Interface de impressao
	   oReport := ReportDef()
	   oReport:SetLandscape()
	   oReport:PrintDialog()
	//Endif
Else
   lRelPer := .F.   
   U_MDTR940R3()
EndIf
RestArea(aArea)

//----------------------------------------------------------------
// Devolve variaveis armazenadas (NGRIGHTCLICK)                          
//----------------------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as secoes impressas no relatorio 

@author Andre E. Perez Alvarez
@since 31/07/06
@return oReport
/*/ 
//---------------------------------------------------------------------
Static Function ReportDef()

Local nX
Static oReport 
Static oSection0
Static oSection1 
Static oSection2

/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140       150       160       170       180       190       200       210       220
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
________________________________________________________________________________
                         Restricoes por Funcionario         
________________________________________________________________________________
Ficha Med.  Nome do Funcionário
________________________________________________________________________________
xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Código      Restrição                                 Dt. Início   Dt. Término
________________________________________________________________________________
123456789   1234567890123456789012345678901234567890  99/99/9999    99/99/9999
123456789   1234567890123456789012345678901234567890  99/99/9999    99/99/9999
*/

//-------------------------------------------------------------------------
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
oReport := TReport():New("MDTR940",OemToAnsi(STR0001),cPerg,; //"Restrições de Trabalho dos Funcionários"
			{|oReport| ReportPrint()},STR0002+" "+STR0003) //"Relatório de listagem das restrições que os funcionários tem para o  "###"trabalho por motivos de saúde."

//----------------------------------------------------------------
// Variaveis utilizadas para parametros                         
// mv_par01             // De  Ficha Medica                     
// mv_par02             // Ate Ficha Medica                     
// mv_par03             // De  Restricao                        
// mv_par04             // Ate Restricao                        
// mv_par05             // De  Data Restricao                   
// mv_par06             // Ate Data Restricao                   
// mv_par07             // Listar Restricoes                    
//                            1 - Abertas                       
//                            2 - Finalizadas                   
//                            3 - Todas                         
// mv_par08             // Classificar por                      
//                            1 - Funcionario                   
//                            2 - Restricao                     
//----------------------------------------------------------------
Pergunte(oReport:uParam,.F.)

U_MDT940SEC()

Return oReport   
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Chamada do Relatório 

@author Andre E. Perez Alvarez
@since 31/07/06
@return .T. 
/*/ 
//---------------------------------------------------------------------
Static Function ReportPrint()

Local oTempTable

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
//--------------------------------------------------------------------------

cCodAnt_ := "ZZZZZZ"

lFirstReg := .t.

If lSigaMdtps

	aDBF := {}
	
	AADD ( aDBF, {"TM0_CLIENT", "C", nTa1, 0} )  
	AADD ( aDBF, {"TM0_LOJA"  , "C", nTa1L, 0} )  
	AADD ( aDBF, {"TM0_NOMCLI", "C", 40, 0} )  

	AADD ( aDBF, {"TM0_NUMFIC", "C",  9, 0} )  
	AADD ( aDBF, {"TM0_NOMFIC", "C", 40, 0} )  
	
	AADD ( aDBF, {"TMF_RESTRI", "C", 6  , 0} )
	AADD ( aDBF, {"TMF_NOMRES", "C", 40 , 0} )
	AADD ( aDBF, {"TMF_DTINIC", "D", 8  , 0} )
	AADD ( aDBF, {"TMF_DTFIM" , "D", 8  , 0} )
	//	
	AADD ( aDBF, { "R7_FUNANT", "C", 20 , 0} )		// Descricao da Funcao Anterior
	AADD ( aDBF, { "RJ_FUNATU", "C", 20 , 0} )		// Descricao da Funcao Atual
	
	oTempTable := FWTemporaryTable():New( "TRB", aDBF )
    If Mv_par12 == 1
    	oTempTable:AddIndex( "1", {"TM0_CLIENT","TM0_LOJA","TM0_NUMFIC","TMF_RESTRI","TMF_DTINIC"} )
		cabec1 := STR0013 //"Ficha Med.  Nome do Funcionário"
		cabec2 := STR0014 //"Código      Restrição                                 Dt. Início   Dt. Término"		
		cSeekTMF := Mv_par05
		cCondTMF := "TMF->TMF_NUMFIC <= Mv_par06"
		cCpoComp := "TMF->TMF_NUMFIC"		
    Else
    	oTempTable:AddIndex( "1", {"TM0_CLIENT","TM0_LOJA","TMF_RESTRI","TM0_NUMFIC","TMF_DTINIC"} )
		cabec1 := STR0015 //"Código      Restrição"
		cabec2 := STR0016 //"Ficha Med.  Nome do Funcionário                       Dt. Início   Dt. Término"		
		cSeekTMF := Mv_par07
		cCondTMF := "TMF->TMF_RESTRI <= Mv_par08"
		cCpoComp := "TMF->TMF_RESTRI"		
    Endif
	oTempTable:Create()
	
	dbSelectArea("TMF")	 
	dbSetOrder(Mv_par12)	
	dbSeek(xFilial("TMF")+cSeekTMF,.T.)
	
	While !Eof() .And. TMF->TMF_FILIAL == xFilial('TMF') .AND. &(cCondTMF)
		
		dbSelectArea("TMF")
		If Mv_par12 == 1
			If TMF->TMF_RESTRI < Mv_par07 .or. TMF->TMF_RESTRI > Mv_par08
				DbSkip()
				Loop
			Endif
		Else
			If TMF->TMF_NUMFIC < Mv_par05 .or. TMF->TMF_NUMFIC > Mv_par06
				DbSkip()
				Loop
			Endif
		Endif
	
		If TMF->TMF_DTINIC > Mv_par10 .or. (TMF->TMF_DTFIM < Mv_par09 .and. !Empty(TMF->TMF_DTFIM) )
			DbSkip()
			Loop
		Endif
	
		If mv_par11 == 1   //Abertas
			If !Empty(TMF->TMF_DTFIM)
				DbSkip()
				Loop
			EndIf
		ElseIf mv_par11 == 2  //Finalizadas
			If Empty(TMF->TMF_DTFIM)
				DbSkip()
				Loop
			EndIf
		EndIf

		dbSelectArea("TM0")
		dbSetOrder(1)
		dbSeek( xFilial("TM0") + TMF->TMF_NUMFIC )		
		If TM0->(TM0_CLIENT+TM0_LOJA) < mv_par01+mv_par02 .OR. TM0->(TM0_CLIENT+TM0_LOJA) > mv_par03+mv_par04
			dbSelectArea("TMF")	 			
			DbSkip()
			Loop		
		Endif
		
		dbSelectArea("SRA")
		dbSetOrder(1)
		dbSeek(xFilial("SRA") + TM0->TM0_MAT)
		
		dbSelectArea("TRB")
		Reclock("TRB",.T.)		
		TRB->TM0_CLIENT := TM0->TM0_CLIENT
		TRB->TM0_LOJA   := TM0->TM0_LOJA
		TRB->TM0_NOMCLI := NGSEEK("SA1",TM0->TM0_CLIENT+TM0->TM0_LOJA,1,"SA1->A1_NOME")
		TRB->TM0_NUMFIC := TM0->TM0_NUMFIC
		TRB->TM0_NOMFIC	:= TM0->TM0_NOMFIC
		TRB->TMF_RESTRI := TMF->TMF_RESTRI
		TRB->TMF_NOMRES := NGSEEK("TME",TMF->TMF_RESTRI,1,"TME->TME_NOMRES")
		TRB->TMF_DTINIC := TMF->TMF_DTINIC
		TRB->TMF_DTFIM	:= TMF->TMF_DTFIM
		TRB->R7_FUNANT		:= SubStr(U_MDT940FUAN(TM0->TM0_MAT), 1, 20)
		TRB->RJ_FUNATU		:= SubStr(NGSEEK("SRJ", SRA->RA_CODFUNC, 1, 'RJ_DESC'), 1, 20)
		MsUnlock("TRB")		                      
		
		dbSelectArea("TMF")
		dbskip()
	End				
	
	dbSelectArea("TRB")
	dbGoTop()
	
	If Eof()
		MsgInfo(STR0033)  //"Não há nada para imprimir no relatório."
		Use
		Return .f.		
	Endif         
	
	oReport:SetMeter(RecCount())	
	
	If mv_par12 = 1
		
		While !Eof()
	
			cCliente := TRB->TM0_CLIENT+TRB->TM0_LOJA			
			oSection0:Init()  //Cliente
			oSection0:PrintLine()        
			
			While !Eof() .and. cCliente = TRB->TM0_CLIENT+TRB->TM0_LOJA
				cFicha := TRB->TM0_NUMFIC
				oSection1:Init()   //Funcionario				
				oSection1:PrintLine()							
				oSection2:Init()    //Restricoes do Funcionario
				While !Eof() .and. cCliente = TRB->TM0_CLIENT+TRB->TM0_LOJA .and. cFicha = TRB->TM0_NUMFIC
					oSection2:PrintLine()                   
					oReport:IncMeter()
					dbSkip()
				End
				oSection2:Finish()
				oSection1:Finish()
			End
			oSection0:Finish()
		
		End
			
	Else

		While !Eof()
	
			cCliente := TRB->TM0_CLIENT+TRB->TM0_LOJA
			oSection0:Init()  //Cliente
			oSection0:PrintLine()        
			
			While !Eof() .and. cCliente = TRB->TM0_CLIENT+TRB->TM0_LOJA
				oSection1:Init()   //Restricao
				cRetri := TRB->TMF_RESTRI
				oSection1:PrintLine()							
				oSection2:Init()    //Funcionarios com a Restricao
				While !Eof() .and. cCliente = TRB->TM0_CLIENT+TRB->TM0_LOJA .and. cRetri = TRB->TMF_RESTRI
					oSection2:PrintLine()
					oReport:IncMeter()
					dbSkip()
				End				
				oSection2:Finish()
				oSection1:Finish()				
			End			
			oSection0:Finish()			
		
		End
	
	Endif				
	
	dbSelectArea("TRB")
	Use

Else

	cSeekTMF := Mv_par01
	cCondTMF := "TMF->TMF_NUMFIC <= Mv_par02"
	cCpoComp := "TMF->TMF_NUMFIC"
	If Mv_par08 == 2
		cSeekTMF := Mv_par03
		cCondTMF := "TMF->TMF_RESTRI <= Mv_par04"
		cCpoComp := "TMF->TMF_RESTRI"
	Endif
	
	lFirstReg := .t.
	
	dbSelectArea("TMF")
	dbSetOrder(Mv_par08)
	dbSeek(xFilial("TMF")+cSeekTMF,.T.)
	
	oReport:SetMeter(RecCount())
	
	//----------------------------------------------------------------
	// Correr TM5 para ler os  Exames realizados                
	//----------------------------------------------------------------
	While !Eof() .And. !oReport:Cancel()	  .AND.;
	      TMF->TMF_FILIAL == xFilial('TMF')	  .AND.;
	      &(cCondTMF)
	
		dbSelectArea("TMF")
		If Mv_par08 == 1
			If TMF->TMF_RESTRI < Mv_par03 .or. TMF->TMF_RESTRI > Mv_par04
				DbSkip()
				Loop
			Endif
		Else
			If TMF->TMF_NUMFIC < Mv_par01 .or. TMF->TMF_NUMFIC > Mv_par02
				DbSkip()
				Loop
			Endif
		Endif
	
		If TMF->TMF_DTINIC > Mv_par06 .or. (TMF->TMF_DTFIM < Mv_par05 .and. !Empty(TMF->TMF_DTFIM) )
			DbSkip()
			Loop
		Endif
	
		If mv_par07 == 1   //Abertas
			If !Empty(TMF->TMF_DTFIM)
				DbSkip()
				Loop
			EndIf
		ElseIf mv_par07 == 2  //Finalizadas
			If Empty(TMF->TMF_DTFIM)
				DbSkip()
				Loop
			EndIf
		EndIf
		
		If cCodAnt_ <> &(cCpoComp)
			If !lFirstReg
				oSection2:Finish()
				oSection1:Finish()
			Endif
			oSection1:Init()
			oSection1:PrintLine()
			oSection2:Init()
			lFirstReg := .f.
			cCodAnt_ := &(cCpoComp)
		Endif
	
		oSection2:PrintLine()
	
		oReport:IncMeter()
		
		dbSelectArea("TMF")
		dbskip()
	End
	
	If !lFirstReg
		oSection2:Finish()
		oSection1:Finish()
	Else
		MsgInfo(STR0033)  //"Não há nada para imprimir no relatório."
		Return .f.	
	Endif	
	
Endif
     
Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR940R3
Relatorio do Resultado dos Exames por Centro de Custo (R3)

@author Marcio Costa 
@since 12.01.00
@return Nil
/*/ 
//---------------------------------------------------------------------
User Function MDTR940R3()

//----------------------------------------------------------------
// Define Variaveis                                             
//----------------------------------------------------------------
LOCAL wnrel   := "MDTR940"
LOCAL cDesc1  := STR0002 //"Relatório de listagem das restrições que os funcionários tem para o  "
LOCAL cDesc2  := STR0003 //"trabalho por motivos de saúde."
LOCAL cDesc3  := " "
LOCAL cString := "TMF"

PRIVATE nomeprog := "MDTR940"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := { STR0011, 1,STR0012, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0001 //"Restrições de Trabalho dos Funcionários"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2

//----------------------------------------------------------------
// Verifica as perguntas selecionadas                           
//----------------------------------------------------------------
pergunte(cPerg,.F.)

//----------------------------------------------------------------
// Variaveis utilizadas para parametros                         
// mv_par01             // De  Ficha Medica                     
// mv_par02             // Ate Ficha Medica                     
// mv_par03             // De  Restricao                        
// mv_par04             // Ate Restricao                        
// mv_par05             // De  Data Restricao                   
// mv_par06             // Ate Data Restricao                   
// mv_par07             // Listar Restricoes                    
//                            1 - Abertas                       
//                            2 - Finalizadas                   
//                            3 - Todas                         
// mv_par08             // Classificar por                      
//                            1 - Funcionario                   
//                            2 - Restricao                     
//----------------------------------------------------------------

wnrel:="MDTR940"

WnRel:=SetPrint(cString,WnRel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,"G")

If nLastKey == 27
	Set Filter to
 	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
        Set Filter to
   Return
Endif

RptStatus({|lEnd| R940Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} R940Imp
 Chamada do Relatório (R3)

@param lEnd - Cancela a impressão
@param wnRel - Nome do Programa utilizado
@param titulo - Titulo do Relatório 
@param tamanho - Tamanho do relatório

@author Inacio Luiz Kolling
@since 12.01.00
@return Nil
/*/ 
//---------------------------------------------------------------------
Static Function R940Imp(lEnd,wnRel,titulo,tamanho)

//----------------------------------------------------------------
// Define Variaveis                                             
//----------------------------------------------------------------
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0
Local oTempTable

//----------------------------------------------------------------
// Variaveis para controle do cursor de progressao do relatorio 
//----------------------------------------------------------------
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//----------------------------------------------------------------
// Variaveis locais exclusivas deste programa                   
//----------------------------------------------------------------
LOCAL cChave           := SPACE(16)
LOCAL lContinua        := .T.
LOCAL cCLiente := ""

//----------------------------------------------------------------
// Contadores de linha e pagina                                 
//----------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1

//----------------------------------------------------------------
// Verifica se deve comprimir ou nao                            
//----------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

cCodAnt_ := "ZZZZZZ"

lFirstReg := .t.

If lSigaMdtps

	aDBF := {}
	
	AADD ( aDBF, {"TM0_CLIENT", "C", nTa1	, 0} )  
	AADD ( aDBF, {"TM0_LOJA"  , "C", nTa1L	, 0} )  
	AADD ( aDBF, {"TM0_NOMCLI", "C", 40		, 0} )  

	AADD ( aDBF, {"TM0_NUMFIC", "C", 09	, 0} )  
	AADD ( aDBF, {"TM0_NOMFIC", "C", 40	, 0} )  
	
	AADD ( aDBF, {"TMF_RESTRI", "C", 06 , 0} )
	AADD ( aDBF, {"TMF_NOMRES", "C", 40 , 0} )
	AADD ( aDBF, {"TMF_DTINIC", "D", 08 , 0} )
	AADD ( aDBF, {"TMF_DTFIM" , "D", 08 , 0} )
	
	AADD ( aDBF, { "R7_FUNANT", "C", 20 , 0} )		// Descricao da Funcao Anterior
	AADD ( aDBF, { "RJ_FUNATU", "C", 20 , 0} )		// Descricao da Funcao Atual
	
	oTempTable := FWTemporaryTable():New( "TRB", aDBF )
    If Mv_par12 == 1
    	oTempTable:AddIndex( "1", {"TM0_CLIENT","TM0_LOJA","TM0_NUMFIC","TMF_RESTRI","TMF_DTINIC"} )
		cabec1 := STR0013 //"Ficha Med.  Nome do Funcionário               Função Anterior        Função Atual"
		cabec2 := STR0014 //"   Código      Restrição                                 Dt. Início   Dt. Término"		
		cSeekTMF := Mv_par05
		cCondTMF := "TMF->TMF_NUMFIC <= Mv_par06"
		cCpoComp := "TMF->TMF_NUMFIC"		
    Else
    	oTempTable:AddIndex( "1", {"TM0_CLIENT","TM0_LOJA","TMF_RESTRI","TM0_NUMFIC","TMF_DTINIC"} )
		cabec1 := STR0015 //"Código      Restrição"
		cabec2 := STR0016 //"   Ficha Med.  Nome do Funcionário               Função Anterior        Função Atual         Dt. Início   Dt. Término"		
		cSeekTMF := Mv_par07
		cCondTMF := "TMF->TMF_RESTRI <= Mv_par08"
		cCpoComp := "TMF->TMF_RESTRI"		
    Endif
	oTempTable:Create()
	
	dbSelectArea("TMF")	 
	dbSetOrder(Mv_par12)	
	dbSeek(xFilial("TMF")+cSeekTMF,.T.)
	
	SetRegua(LastRec())
	
	While !Eof() .And. TMF->TMF_FILIAL == xFilial('TMF') .AND. &(cCondTMF)
	
		IncRegua()
		
		dbSelectArea("TMF")
		If Mv_par12 == 1
			If TMF->TMF_RESTRI < Mv_par07 .or. TMF->TMF_RESTRI > Mv_par08
				DbSkip()
				Loop
			Endif
		Else
			If TMF->TMF_NUMFIC < Mv_par05 .or. TMF->TMF_NUMFIC > Mv_par06
				DbSkip()
				Loop
			Endif
		Endif
	
		If TMF->TMF_DTINIC > Mv_par10 .or. (TMF->TMF_DTFIM < Mv_par09 .and. !Empty(TMF->TMF_DTFIM) )
			DbSkip()
			Loop
		Endif
	
		If mv_par11 == 1   //Abertas
			If !Empty(TMF->TMF_DTFIM)
				DbSkip()
				Loop
			EndIf
		ElseIf mv_par11 == 2  //Finalizadas
			If Empty(TMF->TMF_DTFIM)
				DbSkip()
				Loop
			EndIf
		EndIf

		dbSelectArea("TM0")
		dbSetOrder(1)
		dbSeek( xFilial("TM0") + TMF->TMF_NUMFIC )		
		If TM0->(TM0_CLIENT+TM0_LOJA) < mv_par01+mv_par02 .OR. TM0->(TM0_CLIENT+TM0_LOJA) > mv_par03+mv_par04
			dbSelectArea("TMF")	 			
			DbSkip()
			Loop		
		Endif
		
		dbSelectArea("SRA")
		dbSetOrder(1)
		dbSeek(xFilial("SRA") + TM0->TM0_MAT)
		
		dbSelectArea("TRB")
		Reclock("TRB",.T.)		
		TRB->TM0_CLIENT	:= TM0->TM0_CLIENT
		TRB->TM0_LOJA		:= TM0->TM0_LOJA
		TRB->TM0_NOMCLI	:= NGSEEK("SA1",TM0->TM0_CLIENT+TM0->TM0_LOJA,1,"SA1->A1_NOME")
		TRB->TM0_NUMFIC	:= TM0->TM0_NUMFIC
		TRB->TM0_NOMFIC	:= TM0->TM0_NOMFIC
		TRB->TMF_RESTRI	:= TMF->TMF_RESTRI
		TRB->TMF_NOMRES	:= NGSEEK("TME",TMF->TMF_RESTRI,1,"TME->TME_NOMRES")
		TRB->TMF_DTINIC	:= TMF->TMF_DTINIC
		TRB->TMF_DTFIM		:= TMF->TMF_DTFIM
		TRB->R7_FUNANT		:= SubStr(U_MDT940FUAN(TM0->TM0_MAT), 1, 20)
		TRB->RJ_FUNATU		:= SubStr(NGSEEK("SRJ", SRA->RA_CODFUNC, 1, 'RJ_DESC'), 1, 20)
		MsUnlock("TRB")		                      
		
		dbSelectArea("TMF")
		dbskip()
	End		
	
	dbSelectArea("TRB")
	dbGoTop()
	
	If mv_par12 = 1
		
		While !Eof()
	
			cCliente := TRB->TM0_CLIENT+TRB->TM0_LOJA
			Somalinha()
			@ Li,000 PSay STR0034 + TRB->TM0_CLIENT + "-" + TRB->TM0_LOJA + " - " + TRB->TM0_NOMCLI  //"Cliente/Loja: "
			Somalinha()	 
			
			While !Eof() .and. cCliente = TRB->TM0_CLIENT+TRB->TM0_LOJA
				cFicha := TRB->TM0_NUMFIC
				Somalinha()	 
				@ Li,000 PSay TRB->TM0_NUMFIC
				@ Li,012 PSay TRB->TM0_NOMFIC
				@ Li,047 PSay TRB->R7_FUNANT
				@ Li,070 PSay TRB->RJ_FUNATU
				Somalinha()	   
				@ Li,000 PSay Replicate("-",120)
				SomaLinha()
				While !Eof() .and. cCliente = TRB->TM0_CLIENT+TRB->TM0_LOJA .and. cFicha = TRB->TM0_NUMFIC
					@ Li,003 PSay TRB->TMF_RESTRI
					@ Li,015 PSay TRB->TMF_NOMRES
					@ Li,057 PSay TRB->TMF_DTINIC
					@ Li,070 PSay TRB->TMF_DTFIM
					Somalinha()	 
					dbSkip()
				End				
			End		
		
		End
			
	Else

		While !Eof()
	
			cCliente := TRB->TM0_CLIENT+TRB->TM0_LOJA
			Somalinha()
			@ Li,000 PSay STR0034 + TRB->TM0_CLIENT + "-" + TRB->TM0_LOJA + " - " + TRB->TM0_NOMCLI  //"Cliente/Loja: "
			Somalinha()	 
			
			While !Eof() .and. cCliente = TRB->TM0_CLIENT+TRB->TM0_LOJA
				cRetri := TRB->TMF_RESTRI
				Somalinha()	 
				@ Li,000 PSay TRB->TMF_RESTRI
				@ Li,012 PSay TRB->TMF_NOMRES
				Somalinha()	  
				@ Li,000 PSay Replicate("-",120)
				SomaLinha()
				While !Eof() .and. cCliente = TRB->TM0_CLIENT+TRB->TM0_LOJA .and. cRetri = TRB->TMF_RESTRI
					@ Li,003 PSay TRB->TM0_NUMFIC
					@ Li,015 PSay TRB->TM0_NOMFIC
					@ Li,050 PSay TRB->R7_FUNANT
					@ Li,073 PSay TRB->RJ_FUNATU
					@ Li,093 PSay TRB->TMF_DTINIC
					@ Li,108 PSay TRB->TMF_DTFIM
					Somalinha()	 
					dbSkip()
				End						
			End
		
		End
	
	Endif				
	
	Roda(nCntImpr,cRodaTxt,Tamanho)
	
	//----------------------------------------------------------------
	// Devolve a condicao original do arquivo principal             
	//----------------------------------------------------------------
	RetIndex("TMF")
	
	Set Filter To
	
	Set device to Screen
	
	If TRB->(RecCount()) = 0
		MsgInfo(STR0033)  //"Não há nada para imprimir no relatório."
		dbSelectArea("TRB")
		Use
		Return NIL
	Endif	
	
	dbSelectArea("TRB")
	Use	  

Else

	//----------------------------------------------------------------
	//  Monta os Cabecalhos                                          
	//----------------------------------------------------------------
	If Mv_par08 == 1
		cabec1 := STR0013 //"Ficha Med.  Nome do Funcionário              Função Anterior        Função Atual"
		cabec2 := STR0014 //"   Código      Restrição                                 Dt. Início   Dt. Término"
	Else
		cabec1 := STR0015 //"Código      Restrição"
		cabec2 := STR0016 //"   Ficha Med.  Nome do Funcionário               Função Anterior        Função Atual         Dt. Início   Dt. Término"
	Endif

	cSeekTMF := Mv_par01
	cCondTMF := "TMF->TMF_NUMFIC <= Mv_par02"
	cCpoComp := "TMF->TMF_NUMFIC"
	If Mv_par08 == 2
		cSeekTMF := Mv_par03
		cCondTMF := "TMF->TMF_RESTRI <= Mv_par04"
		cCpoComp := "TMF->TMF_RESTRI"
	Endif

	dbSelectArea("TMF")
	dbSetOrder(Mv_par08)
	dbSeek(xFilial("TMF")+cSeekTMF,.T.)
	
	SetRegua(LastRec())
	
	//----------------------------------------------------------------
	//  Correr TM5 para ler os  Exames realizados                
	//----------------------------------------------------------------
	While !Eof() .And. TMF->TMF_FILIAL == xFilial('TMF') .AND. &(cCondTMF)
	
		IncRegua()
	
		dbSelectArea("TMF")
		If Mv_par08 == 1
			If TMF->TMF_RESTRI < Mv_par03 .or. TMF->TMF_RESTRI > Mv_par04
				DbSkip()
				Loop
			Endif
		Else
			If TMF->TMF_NUMFIC < Mv_par01 .or. TMF->TMF_NUMFIC > Mv_par02
				DbSkip()
				Loop
			Endif
		Endif
	
		If TMF->TMF_DTINIC > Mv_par06 .or. (TMF->TMF_DTFIM < Mv_par05 .and. !Empty(TMF->TMF_DTFIM) )
			DbSkip()
			Loop
		Endif
	
		If mv_par07 == 1   //Abertas
			If !Empty(TMF->TMF_DTFIM)
				DbSkip()
				Loop
			EndIf
		ElseIf mv_par07 == 2  //Finalizadas
			If Empty(TMF->TMF_DTFIM)
				DbSkip()
				Loop
			EndIf
		EndIf

		dbSelectArea("TM0")
		dbSetOrder(1)
		dbSeek( xFilial("TM0") + TMF->TMF_NUMFIC )		
		dbSelectArea("TME")
		dbSetOrder(1)
		dbSeek( xFilial("TME") + TMF->TMF_RESTRI )             
		
		dbSelectArea("SRA")
		dbSetOrder(1)
		dbSeek(xFilial("SRA") + TM0->TM0_MAT)
		
		If cCodAnt_ <> &(cCpoComp)
			Somalinha()
			If !lFirstReg
				Somalinha()
			Endif
			@ Li,000 PSay &(cCpoComp)
			If Mv_par08 == 1
				@ Li,012 PSay TM0->TM0_NOMFIC                                             
				@ Li,047 PSay U_MDT940FUAN(TM0->TM0_MAT)
				@ Li,070 PSay SubStr(NGSEEK("SRJ", SRA->RA_CODFUNC, 1, 'RJ_DESC'), 1, 20)
			Else
				@ Li,012 PSay TME->TME_NOMRES
			Endif
			cCodAnt_ := &(cCpoComp)
			lFirstReg := .f.
			Somalinha()
			@ Li,000 PSay Replicate("-",120)
			SomaLinha()
		Endif
	
		Somalinha()
		If Mv_par08 == 1
			@ Li,003 PSay TMF->TMF_RESTRI
			@ Li,015 PSay TME->TME_NOMRES
			@ Li,057 PSay TMF->TMF_DTINIC
			@ Li,070 PSay TMF->TMF_DTFIM
		Else
			@ Li,003 PSay TMF->TMF_NUMFIC
			@ Li,015 PSay TM0->TM0_NOMFIC
			@ Li,050 PSay SubStr(U_MDT940FUAN(TM0->TM0_MAT), 1, 20)
			@ Li,073 PSay SubStr(NGSEEK("SRJ", SRA->RA_CODFUNC, 1, 'RJ_DESC'), 1, 20)          
			@ Li,093 PSay TMF->TMF_DTINIC
			@ Li,108 PSay TMF->TMF_DTFIM
		Endif
		
		dbSelectArea("TMF")
		dbskip()
	End
     
	Roda(nCntImpr,cRodaTxt,Tamanho)
	
	//----------------------------------------------------------------
	// Devolve a condicao original do arquivo principal             
	//----------------------------------------------------------------
	RetIndex("TMF")
	
	Set Filter To
	
	Set device to Screen
	
	If lFirstReg
		MsgInfo(STR0033)  //"Não há nada para imprimir no relatório."
		Return NIL
	Endif

Endif

If aReturn[5] = 1
        Set Printer To
        dbCommitAll()
        OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina (R3)

@author Inacio Luiz Kolling
@since 12.01.00
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
/*/{Protheus.doc} IncluiSX1
Inclui os SX1

@author Denis
@since 12.01.00
@return 
/*/ 
//---------------------------------------------------------------------
Static Function IncluiSX1()

Local aPerg := {}

If lSigaMdtps
	cPerg    :=  "MDT940PS  "
Endif

Return
//---------------------------------------------------------------------
/*/{Protheus.doc} MDT940SEC
Atualiza as configuracoes de secao de acordo com o parametro
de classificacao 

@author Andre Perez Alvarez
@since 15/02/2008
@return .T.
/*/ 
//---------------------------------------------------------------------
User Function MDT940SEC()

If lRelPer

	oReport:Asection := {}  //Apaga as secoes dos parametros anteriores
	
	If lSigaMdtps
		If Mv_par12 == 2
			oSection0 := TRSection():New (oReport,STR0030, {"TRB","SA1"} )  //"Cliente"
			TRCell():New(oSection0, "TRB->TM0_CLIENT" , "TRB", STR0030, "@!", nta1 )   //"Cliente"
			TRCell():New(oSection0, "TRB->TM0_LOJA"   , "TRB", STR0031, "@!", nTa1L )  //"Loja"
			TRCell():New(oSection0, "A1_NOME"         , "SA1", STR0032 ,"@!", 40 )     //"Nome"
				TRPosition():New(oSection0, "SA1", 1, {|| xFilial("TM0") + TRB->TM0_CLIENT + TRB->TM0_LOJA })

			oSection1 := TRSection():New (oReport,STR0004, {"TRB","TME"} ) //"Restrição"
			TRCell():New(oSection1, "TRB->TMF_RESTRI" , "TRB", STR0005, "@!", 06 ) //"Código"
			TRCell():New(oSection1, "TME_NOMRES"      , "TME", STR0004, "@!", 40 ) //"Restrição"
				TRPosition():New(oSection1, "TME", 1, {|| xFilial("TME") + TRB->TMF_RESTRI })
			        
			oSection2 := TRSection():New (oReport,STR0006, {"TRB","TM0","TMF"} ) //"Funcionário"
			oCell := TRCell():New (oSection2, "TRB->TM0_NUMFIC", "TRB", STR0007, "@!", 09, /*lPixel*/,/*{|| code-block de impressao }*/) //"Ficha Med."
			oCell := TRCell():New (oSection2, "TM0_NOMFIC"     , "TM0", STR0008, "@!" , 40, /*lPixel*/,/*{|| code-block de impressao }*/) //"Nome do Funcionário"
			oCell := TRCell():New (oSection2, "TRB->R7_FUNANT"	 , "TRB", STR0035, "@!" , 20, /*lPixel*/,/*{|| code-block de impressao }*/) //"Função Anterior"
			oCell := TRCell():New (oSection2, "TRB->RJ_FUNATU"	 , "TRB", STR0036, "@!" , 20, /*lPixel*/,/*{|| code-block de impressao }*/) //"Função Atual"
			oCell := TRCell():New (oSection2, "TRB->TMF_DTINIC", "TRB", STR0009, "99/99/99", 08, /*lPixel*/,/*{|| code-block de impressao }*/) //"Dt. Início"
			oCell := TRCell():New (oSection2, "TRB->TMF_DTFIM" , "TRB", STR0010, "99/99/99", 08, /*lPixel*/,/*{|| code-block de impressao }*/) //"Dt. Término"
				TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + TRB->TM0_NUMFIC} )
				TRPosition():New (oSection2, "TMF", 1, {|| xFilial("TMF") + TRB->TM0_NUMFIC + TRB->TMF_RESTRI + DTOS(TRB->TMF_DTINIC) } )
		Else
			oSection0 := TRSection():New (oReport,STR0030, {"TRB","SA1"} )  //"Cliente"
			TRCell():New(oSection0, "TRB->TM0_CLIENT" , "TRB", STR0030, "@!", nta1 )   //"Cliente"
			TRCell():New(oSection0, "TRB->TM0_LOJA"   , "TRB", STR0031, "@!", nTa1L )  //"Loja"
			TRCell():New(oSection0, "A1_NOME"         , "SA1", STR0032 ,"@!", 40 )     //"Nome"
				TRPosition():New(oSection0, "SA1", 1, {|| xFilial("TM0") + TRB->TM0_CLIENT + TRB->TM0_LOJA })
			
			oSection1 := TRSection():New (oReport,STR0006, {"TRB","TM0"} ) //"Funcionário"
			TRCell():New(oSection1, "TRB->TM0_NUMFIC" , "TRB", STR0007, "@!", 09 ) //"Ficha Med."
			TRCell():New(oSection1, "TM0_NOMFIC"      , "TM0", STR0008, "@!", 40 ) //"Nome do Funcionário"
			TRCell():New (oSection1, "TRB->R7_FUNANT"	 , "TRB", STR0035, "@!" , 20, /*lPixel*/,/*{|| code-block de impressao }*/) //"Função Anterior"
			TRCell():New (oSection1, "TRB->RJ_FUNATU"	 , "TRB", STR0036, "@!" , 20, /*lPixel*/,/*{|| code-block de impressao }*/) //"Função Atual"
				TRPosition():New(oSection1, "TM0", 1, {|| xFilial("TM0") + TRB->TM0_NUMFIC} )
				        
			oSection2 := TRSection():New (oReport,STR0004, {"TMF","TME","TMF"} ) //"Restrição"
			oCell := TRCell():New (oSection2, "TRB->TMF_RESTRI", "TRB", STR0005, "@!", 06, /*lPixel*/,/*{|| code-block de impressao }*/) //"Código"
			oCell := TRCell():New (oSection2, "TME_NOMRES"     , "TME", STR0004, "@!", 40, /*lPixel*/,/*{|| code-block de impressao }*/) //"Restrição"
			oCell := TRCell():New (oSection2, "TRB->TMF_DTINIC", "TRB", STR0009, "99/99/99", 08, /*lPixel*/,/*{|| code-block de impressao }*/) //"Dt. Início"
			oCell := TRCell():New (oSection2, "TRB->TMF_DTFIM" , "TRB", STR0010, "99/99/99", 08, /*lPixel*/,/*{|| code-block de impressao }*/) //"Dt. Término"
				TRPosition():New(oSection2, "TME", 1, {|| xFilial("TME") + TRB->TMF_RESTRI })
				TRPosition():New(oSection2, "TMF", 1, {|| xFilial("TMF") + TRB->TM0_NUMFIC + TRB->TMF_RESTRI + DTOS(TRB->TMF_DTINIC) } )
		Endif   
	Else
		If Mv_par08 == 2
			oSection1 := TRSection():New (oReport,STR0004, {"TMF","TME"} ) //"Restrição"
			TRCell():New(oSection1, "TMF_RESTRI" , "TMF", STR0005, "@!" , 06 ) //"Código"
			TRCell():New(oSection1, "TME_NOMRES" , "TME", STR0004 , "@!", 40 ) //"Restrição"
				TRPosition():New(oSection1, "TME", 1, {|| xFilial("TME") + TMF->TMF_RESTRI })
			        
			oSection2 := TRSection():New (oReport,STR0006, {"TMF","TM0"} ) //"Funcionário"
			oCell := TRCell():New (oSection2, "TMF_NUMFIC" , "TMF", STR0007, "@!", 09, /*lPixel*/,/*{|| code-block de impressao }*/) //"Ficha Med."
			oCell := TRCell():New (oSection2, "TM0_NOMFIC"	, "TM0", STR0008, "@!", 40, /*lPixel*/,/*{|| code-block de impressao }*/) //"Nome do Funcionário"
			oCell := TRCell():New (oSection2, "FUNANT"		, "   ", STR0035, "@!" , 20, /*lPixel*/,{|| U_MDT940FUAN(TM0->TM0_MAT) }) //"Função Anterior"
			oCell := TRCell():New (oSection2, "FUNATU"		, "   ", STR0036, "@!" , 20, /*lPixel*/,{|| SubStr(NGSEEK("SRJ", SRA->RA_CODFUNC, 1, 'RJ_DESC'), 1, 20) }) //"Função Atual"		
			oCell := TRCell():New (oSection2, "TMF_DTINIC" , "TMF", STR0009, "99/99/99", 08, /*lPixel*/,/*{|| code-block de impressao }*/) //"Dt. Início"
			oCell := TRCell():New (oSection2, "TMF_DTFIM"  , "TMF", STR0010, "99/99/99", 08, /*lPixel*/,/*{|| code-block de impressao }*/) //"Dt. Término"
				TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + TMF->TMF_NUMFIC} )
		Else
			oSection1 := TRSection():New (oReport,STR0006, {"TMF","TM0"} ) //"Funcionário"
			TRCell():New(oSection1, "TMF_NUMFIC"	, "TMF", STR0007, "@!" , 09 ) //"Ficha Med."
			TRCell():New(oSection1, "TM0_NOMFIC"	, "TM0", STR0008 , "@!", 40 ) //"Nome do Funcionário"
			TRCell():New(oSection1, "FUNANT"			, "   ", STR0035, "@!" , 20, /*lPixel*/,{|| U_MDT940FUAN(TM0->TM0_MAT) }) //"Função Anterior"
			TRCell():New(oSection1, "FUNATU"			, "   ", STR0036, "@!" , 20, /*lPixel*/,{|| SubStr(NGSEEK("SRJ", SRA->RA_CODFUNC, 1, 'RJ_DESC'), 1, 20) }) //"Função Atual"		
				TRPosition():New(oSection1, "TM0", 1, {|| xFilial("TM0") + TMF->TMF_NUMFIC} )
				        
			oSection2 := TRSection():New (oReport,STR0004, {"TMF","TME"} ) //"Restrição"
			oCell := TRCell():New (oSection2, "TMF_RESTRI" , "TMF", STR0005, "@!", 06, /*lPixel*/,/*{|| code-block de impressao }*/) //"Código"
			oCell := TRCell():New (oSection2, "TME_NOMRES" , "TME", STR0004, "@!", 40, /*lPixel*/,/*{|| code-block de impressao }*/) //"Restrição"
			oCell := TRCell():New (oSection2, "TMF_DTINIC" , "TMF", STR0009, "99/99/99", 08, /*lPixel*/,/*{|| code-block de impressao }*/) //"Dt. Início"
			oCell := TRCell():New (oSection2, "TMF_DTFIM"  , "TMF", STR0010, "99/99/99", 08, /*lPixel*/,/*{|| code-block de impressao }*/) //"Dt. Término"
				TRPosition():New(oSection2, "TME", 1, {|| xFilial("TME") + TMF->TMF_RESTRI })
		Endif   
	Endif

Endif

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT940FUAN
Pesquisa na base de dados a descricao da funcao anterior a 
atual.     

@param cMat - Matricula. 

@author Pedro Acacio de M Neto
@since 26/01/2010
@return SubStr(NGSEEK("SRJ", cFun, 1, 'RJ_DESC'), 1, 20)
/*/ 
//---------------------------------------------------------------------
User Function MDT940FUAN(cMat)  
Local cFun		:= ""
Local cFunAtu
Local aAreaOld	:= GetArea()              

dbSelectArea("SRA")
dbSetOrder(1)
dbSeek(xFilial("SRA") + TM0->TM0_MAT)
cFunAtu := SRA->RA_CODFUNC

dbSelectArea("SR7")
dbSetOrder(1)
SET FILTER TO SR7->R7_FILIAL == xFilial("SR7") .And. SR7->R7_MAT == cMat

dbGoBottom()

While !BOF()
	If SR7->R7_FUNCAO <> cFunAtu
		cFun := SR7->R7_FUNCAO
		Exit
	EndIf                       
	dbSkip(-1)
EndDo

// Se estiver vazio, a funcao anterior e igual a atual.
If Empty(cFun)
	cFun := cFunAtu
EndIf

RestArea(aAreaOld)
Return SubStr(NGSEEK("SRJ", cFun, 1, 'RJ_DESC'), 1, 20)