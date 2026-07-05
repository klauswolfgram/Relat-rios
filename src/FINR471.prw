/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR471.CH"
#INCLUDE "PROTHEUS.Ch"                                          


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma³ FINR471 ºAutor³ Gabriel Borges Vilete º   Data ³  01/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Relatório de conciliação bancária                        º±±
±±º          ³   Parâmetros: Seleção do que será impresso a partir da     º±±
±±º							 rotina FINA471 (conciliados e/ou não         º±±
±±º                          conciliados)                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function FINR471(cBanco, ldecide1, ldecide2)          

Private nomeprog	:= "FINR471"    
Private cBancomov := cBanco
Private lconc1 := ldecide1
Private lconc2 := ldecide2

pergunte("AFI470",.F.)

	U_FINR471R4()
	
Return

User Function FINR471R4()                           

Local aTRB := {}
Local oReport  

PRIVATE cPerg := "AFI470"        

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ            
Pergunte( cPerg, .F. )

aTRB := TRB->(GetArea())

oReport := ReportDef()      

			oReport:SetEdit(.F.) 
			oReport:ParamReadOnly()
			oReport:SetLandScape()
			oReport:DisableOrientation()
			oReport:HideFooter() 
			oReport:PrintDialog()


oReport := nil

RestArea(aTRB)

Return                                

         
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma ³ ReportDef ºAutor³ Gabriel Borges Vileteº Data³   01/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Esta funcao tem como objetivo definir as secoes, celulas,   ³±±
±±³          ³totalizadores do relatorio que poderao ser configurados     ³±±
±±³          ³pelo relatorio.                                             ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()     

Local CREPORT	:= "FINR471"                    
Local CTITULO	:= OemToAnsi(STR0001)				// "CONCILIAÇÃO BANCÁRIA"
Local CDESC		:= OemToAnsi(STR0002) + ; 			// "Este programa irá imprimir a Conciliação Bancária "
	   			   OemToAnsi(STR0003) 				// "de acordo com as preferências informadas pelo usuário."
                                         
Local aTamReconc := TamSX3("E5_RECONC")                                                
Local aTamSeq	 := TamSX3("E5_SEQ")
Local aTamData	 := TamSX3("E5_DATA")	
Local aTamValor  := TamSX3("E5_VALOR")
Local aTamDocum	 := TamSX3("E5_DOCUMEN")		
Local aTamOcors  := TamSX3("EJ_OCORSIS")
Local aTamDescr  := TamSX3("EJ_DESCR")
Local aTamDebcre := TamSX3("EJ_DEBCRE")
Local aTamHistor := TamSX3("E5_HISTOR")
Local cPerg471	:= "AFI470"
Local oSection1		 

cTitulo	:= OemToAnsi(STR000D)						// "Conciliação Bancária"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³                                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


oReport	:= TReport():New( cReport,cTitulo,cPerg, { |oReport| Pergunte(cPerg , .F. ), If(! ReportPrint( oReport )  , oReport:CancelPrint(), .T. ) }, cDesc ) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1 := TRSection():New( oReport, STR000D) // "Conciliação Bancária"

TRCell():New( oSection1, "RECONC"	,"",STR0004 /*"Estado"*/				/*STR0008Titulo*/,/*"@D 99/99/9999"*//*Picture*/,aTamReconc[1] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
TRCell():New( oSection1, "SEQ"  	,"",STR0005 /*"Sequência"*/				/*STR0009Titulo*/,/*"@!"*//*Picture*/,aTamSeq[1] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
TRCell():New( oSection1, "DATA" 	,"",STR0006 /*"Data Movimento"*/				/*STR0010Titulo*/,/*Picture*/,aTamData[1] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
TRCell():New( oSection1, "VALOR"	,"",STR0007 /*"Valor Movimento"*/				/*STR0011Titulo*/,/*Picture*/,aTamValor[1]+aTamValor[2] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
TRCell():New( oSection1, "DOCUMEN"	,"",STR0008 /*"Código Documento"*/				/*STR0012Titulo*/,/*Picture*/,aTamDocum[1] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
TRCell():New( oSection1, "OCORSIS"	,"",STR0009 /*"Tipo Movimento"*/				/*STR0013Titulo*/,/*Picture*/,aTamOcors[1] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
TRCell():New( oSection1, "DESCR"	,"",STR000A /*"Descrição"*/				/*STR0014Titulo*/,/*Picture*/,aTamDescr[1] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection1, "DEBCRE"	,"",STR000B /*"D/C"*/				/*STR0015Titulo*/,/*Picture*/,aTamDebcre[1] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection1, "HISTOR"	,"",STR000C /*"Historico"*/				/*STR0016Titulo*/,	/*Picture*/,aTamHistor[1] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)


oSection1:SetHeaderPage()
oSection1:SetTotalInLine(.F.) 

Return(oReport)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma³ ReportPrint ºAutor³ Gabriel Borges Vilete ºData³  01/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime o relatorio definido pelo usuario de acordo com as  ³±±
±±³          ³secoes/celulas criadas na funcao ReportDef definida acima.  ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint( oReport )    

Local oSection1 	:= oReport:Section(1)
Local cArqTmp
Local aTamReconc := TamSX3("E5_RECONC")                                                
Local aTamSeq	 := TamSX3("E5_SEQ")
Local aTamData	 := TamSX3("E5_DATA")	
Local aTamValor  := TamSX3("E5_VALOR")
Local aTamDocum	 := TamSX3("E5_DOCUMEN")		
Local aTamOcors  := TamSX3("EJ_OCORSIS")
Local aTamDescr  := TamSX3("EJ_DESCR")
Local aTamDebcre := TamSX3("EJ_DEBCRE")
Local aTamHistor := TamSX3("E5_HISTOR")
Local cRec       := "0"
						  
dbSelectArea("TRB")       

cArqTmp1 := CriaTrab(,.F.)
                   
dbSetOrder(1)       
dbGoTop()
 
oReport:SetMeter( RecCount() )

oReport:SetPageNumber(1)

While TRB->(!EOF())

	oReport:IncMeter()
	
	cRec := Soma1(cRec)
		

	SE5->(DbSetOrder(1))
	If SE5->(dbSeek(xFilial("SE5")+dtos(ctod(TRB->DATAMOV))+CBANCOMOV+TRB->AGEMOV+TRB->CTAMOV+TRB->NUMMOV))
	
		If (LCONC1) .AND. !(EMPTY(SE5->E5_RECONC))
			
			If oReport:Cancel()
				Exit
			EndIf
			
			oSection1:Init()
			
			
			oSection1:Cell("RECONC" ):SetBlock( { || SE5->E5_RECONC } )	
			oSection1:Cell("SEQ"    ):SetBlock( { || TRB->SEQMOV } )
			oSection1:Cell("DATA"   ):SetBlock( { || TRB->DATAMOV } )
			oSection1:Cell("VALOR"  ):SetBlock( { || TRB->VALORMOV } )
			oSection1:Cell("DOCUMEN"):SetBlock( { || TRB->NUMMOV } )
			oSection1:Cell("OCORSIS"):SetBlock( { || TRB->TIPOMOV } )
			oSection1:Cell("DESCR"  ):SetBlock( { || TRB->DESCMOV } )
			oSection1:Cell("DEBCRE" ):SetBlock( { || TRB->DEBCRED } )
			oSection1:Cell("HISTOR" ):SetBlock( { || TRB->DESCMOV } ) 
						
			oSection1:PrintLine()
			oSection1:Finish()
				
		ElseIf (LCONC2) .AND. (EMPTY(SE5->E5_RECONC))
			
			If oReport:Cancel()
				Exit
			EndIf
			
			oSection1:Init()
			
			oSection1:Cell("RECONC" ):SetBlock( { || SE5->E5_RECONC } )	
			oSection1:Cell("SEQ"    ):SetBlock( { || TRB->SEQMOV } )
			oSection1:Cell("DATA"   ):SetBlock( { || TRB->DATAMOV } )
			oSection1:Cell("VALOR"  ):SetBlock( { || TRB->VALORMOV } )
			oSection1:Cell("DOCUMEN"):SetBlock( { || TRB->NUMMOV } )
			oSection1:Cell("OCORSIS"):SetBlock( { || TRB->TIPOMOV } )
			oSection1:Cell("DESCR"  ):SetBlock( { || TRB->DESCMOV } )
			oSection1:Cell("DEBCRE" ):SetBlock( { || TRB->DEBCRED } )
			oSection1:Cell("HISTOR" ):SetBlock( { || TRB->DESCMOV } ) 
		
			oSection1:PrintLine() 
			
			oSection1:Finish()
		EndIf
	ElseIf (LCONC2) // Os registros não encontrados pelo seek que pertencem ao documento .ret não estão conciliados, portando devem ser impressos
		If oReport:Cancel()
				Exit
			EndIf
			
			oSection1:Init()
			
			oSection1:Cell("RECONC" ):SetBlock( { || "" } )	
			oSection1:Cell("SEQ"    ):SetBlock( { || TRB->SEQMOV } )
			oSection1:Cell("DATA"   ):SetBlock( { || TRB->DATAMOV } )
			oSection1:Cell("VALOR"  ):SetBlock( { || TRB->VALORMOV } )
			oSection1:Cell("DOCUMEN"):SetBlock( { || TRB->NUMMOV } )
			oSection1:Cell("OCORSIS"):SetBlock( { || TRB->TIPOMOV } )
			oSection1:Cell("DESCR"  ):SetBlock( { || TRB->DESCMOV } )
			oSection1:Cell("DEBCRE" ):SetBlock( { || TRB->DEBCRED } )
			oSection1:Cell("HISTOR" ):SetBlock( { || TRB->DESCMOV } ) 
		
			oSection1:PrintLine() 
			
			oSection1:Finish()
	Endif
   	
	TRB->(dbSkip())
		
End  


Return(.T.)        
