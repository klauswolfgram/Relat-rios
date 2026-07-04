/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR680.Ch"
#Include "PROTHEUS.Ch"

#DEFINE 	COL_SEP1  			1
#DEFINE 	COL_LINHA 			2
#DEFINE 	COL_SEP2			3
#DEFINE 	COL_DC	 			4
#DEFINE 	COL_SEP3  			5
#DEFINE 	COL_CTADEB			6
#DEFINE 	COL_SEP4  			7
#DEFINE 	COL_CTACRD       	8
#DEFINE 	COL_SEP5			9
#DEFINE 	COL_CCDEB        	10
#DEFINE 	COL_SEP6			11
#DEFINE 	COL_CCCRD        	12
#DEFINE 	COL_SEP7			13
#DEFINE 	COL_ITEMDEB   		14
#DEFINE 	COL_SEP8			15
#DEFINE 	COL_ITEMCRD   		16
#DEFINE 	COL_SEP9			17
#DEFINE 	COL_CLVLDEB   		18
#DEFINE 	COL_SEP10			19
#DEFINE 	COL_CLVLCRD   		20
#DEFINE 	COL_SEP11			21
#DEFINE 	COL_VALORLANC 		22
#DEFINE 	COL_SEP12			23


// 17/08/2009 -- Filial com mais de 2 caracteres

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR680	³ Autor ³ Simone Mie Sato   	³ Data ³ 20.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de composicao dos lancamentos aglutinados		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_CTBR680()    											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 	     ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR680()

Local aCtbMoeda		:= {}
Local cDesc1 		:= STR0001	 //"Este programa ira imprimir o relatorio de composicao dos lancamentos aglutinados."
Local cDesc2 		:= STR0002   //"Pode-se escolher se deseja imprimir todos os lançamentos ou somente os aglutinados."
Local cDesc3		:= STR0003  //""Não é aconselhável a emissão desse relatório quando o histórico faz parte da chave de aglutinação."
Local cNomeArq
Local wnrel
Local cString		:= "CT2"
Local titulo 		:= STR0004 	//"Composição dos lançamentos aglutinados em "
Local lRet			:= .T.
Local lAglByHist	:= GetNewPar("MV_AGLHIST",.F.)

Private Tamanho		:= "G"
Private nLastKey 	:= 0
Private cPerg	 	:= "CTR680"
Private aReturn 	:= { STR0005, 1,STR0006, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
Private aLinha		:= {}
Private nomeProg  	:= "CTBR680"

li 		:= 80
m_pag	:= 1

dbSelectArea("CTO")
dbSetOrder(1)
If MsSeek(xFilial()+"01")
	titulo	+= CTO->CTO_DESC
Endif

Pergunte("CTR680",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros						 	³
//³ mv_par01				// Data Inicial                  	 	³
//³ mv_par02				// Data Final                         	³
//³ mv_par03				// Lote  Inicial                        ³
//³ mv_par04				// Lote  Final  						³
//³ mv_par05				// Sublote Inicial                  	³
//³ mv_par06				// Sub-Lote Final  						³
//³ mv_par07				// Documento Inicial                    ³
//³ mv_par08				// Documento Final			    		³
//³ mv_par09				// Codigo Conta? Normal / Reduzido 		³
//³ mv_par10				// Codigo C.Custo? Normal / Reduzido 	³
//³ mv_par11				// Codigo Item? Normal/Reduzido      	³
//³ mv_par12				// Codigo Cl.Valor?  Normal / Reduzido 	³
//³ mv_par13				// Imprime Lcto? Real/Ger/Orc/Pre/Todos ³
//³ mv_par14				// Consid. Lancamentos?Aglutinados/Todos|
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel	:= "CTBR680"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey == 27
	Set Filter To
	Return
Endif
                
//Se os lançamentos foram aglutinados considerando o historico na aglutinação, não é aconselhável 
//a emissão desse relatório porque pode ter utilizado o campo CT5_HAGLUT e não há a possibilidade
//de rastrearmos esse lançamento no CTK comparando o CTK_HIST com o CT2_HIST. 
If lAglByHist	
	MSGALERT(STR0003)//"Não é aconselhável a emissão desse relatório quando o histórico faz parte da chave de aglutinação."	
EndIf

If !lRet
	Set Filter To
	Return
EndIf

SetDefault(aReturn,cString)

RptStatus({|lEnd| CTR680Imp(@lEnd,wnRel,cString,Titulo)})

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CTR680IMP ³ Autor ³ Simone Mie Sato       ³ Data ³ 17.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CTR680Imp(lEnd,WnRel,cString,Titulo)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd       - A‡ao do Codeblock                             ³±±
±±³          ³ wnRel      - Nome do Relatorio                             ³±±
±±³          ³ cString    - Mensagem                                      ³±±
±±³          ³ Titulo     - Titulo do Relatorio                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CTR680Imp(lEnd,WnRel,cString,Titulo)

Local CbCont	:= 0
Local limite	:= 220      
Local nDecimais	:= 0 

Local CbTxt		:= Space(10)
Local cabec1  	:= ""                                       
Local cabec2  	:= " "
Local cLoteAnt	:= ""
Local cSbLoteAnt:= ""
Local cDocAnt	:= ""
Local cPicture	:= ""
Local cAlias	:= ""
Local cAliasCTK	:= ""

Local aColunas  := { 000,001,006,007,010,011,033,034,057,058,081,082,103,104,125,126,147,148,169,170,191,192,219 }
Local aTamVlr	:= TAMSX3("CT2_VALOR")


Local dDataAnt	:= CTOD("  /  /  ")

Local bCond	    := {||.T.}

Local lCtaRes	:= Iif(mv_par09==2,.T.,.F.)
Local lCCRes	:= Iif(mv_par10==2,.T.,.F.)
Local lItemRes	:= Iif(mv_par11==2,.T.,.F.)
Local lClVlRes	:= Iif(mv_par12==2,.T.,.F.)

li := 80      
nDecimais 	:= aTamVlr[2]

/*
|LINHA|DC |CONTA DEBITO          |CONTA CREDITO          |C.CUSTO DEBITO         |C.CUSTO CREDITO      |ITEM DEBITO          |ITEM CREDITO         |CL.VALOR DEBITO      |CL.VALOR CREDITO     |VALOR LCTO        |
 999    9  99999999999999999999   999999999999999999999   99999999999999999999    99999999999999999999  99999999999999999999  99999999999999999999  99999999999999999999  99999999999999999999  999,999,999,999.99

0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        17        18        19        20        21        22 

|LP   |LP SEQ  	                |HISTORICO														     |VALOR                                                                                                      |
999		999	   9999999999999999999999999999999999999999							999,999,999,999.99

0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        17        18        19        20        21        22 

DATA: 99/99/9999	LOTE: 999999	SUBLOTE: 999	DOCUMENTO: 999999
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        17        18        19        20        21        22 
*/

li := 80  

Cabec1 := STR0007	//"|LINHA|DC |CONTA DEBITO          |CONTA CREDITO          |C.CUSTO DEBITO         |C.CUSTO CREDITO      |ITEM DEBITO          |ITEM CREDITO         |CL.VALOR DEBITO      |CL.VALOR CREDITO     |VALOR LCTO        |"
Cabec2 := STR0008	//"|LP   |LP SEQ  	                |HISTORICO														      |VALOR                                                                                                      |"

dbSelectArea("CT2")
dbSetOrder(1)

U_Ctr680Qry1()	
cAlias	:= "Ctr680Qry1"

SetRegua(RecCount())

dbSelectArea(cAlias)

While !Eof() .And. Eval(bCond)

	If lEnd
		@Prow()+1,0 PSAY STR0009   //"***** CANCELADO PELO OPERADOR *****"
		Exit
	EndIF                        
	
	IncRegua()

	If  li > 58	
		Cabec( Titulo, Cabec1, Cabec2, NomeProg, Tamanho,;
				Iif(aReturn[4] == 1, GetMv("MV_COMP"), GetMv("MV_NORM")))
		U_Ctr680Cabe((cAlias)->CT2_DATA,(cAlias)->CT2_LOTE,(cAlias)->CT2_SBLOTE,(cAlias)->CT2_DOC)		
	ElseIf (cAlias)->CT2_DATA <> dDataAnt  .Or. (cAlias)->CT2_LOTE <> cLoteAnt .Or. ;		
			(cAlias)->CT2_SBLOTE <> cSbLoteAnt .Or. (cAlias)->CT2_DOC <> cDocAnt
		U_Ctr680Cabe((cAlias)->CT2_DATA,(cAlias)->CT2_LOTE,(cAlias)->CT2_SBLOTE,(cAlias)->CT2_DOC)				
	EndIf
                                                                         
	//Se imprime todos os lançamentos ou se imprime somente os lançamentos aglutinados e o CT2_AGLUT =="1"
	If mv_par14 == 2 .Or.  ( mv_par14 == 1 .And. (cAlias)->CT2_AGLUT == "1" )
		li++
		@li,aColunas[COL_SEP1] PSAY "|"
		@li,aColunas[COL_LINHA] PSAY (cAlias)->CT2_LINHA
		@li,aColunas[COL_SEP2] PSAY "|"			
		@li,aColunas[COL_DC]+1 PSAY (cAlias)->CT2_DC
		@li,aColunas[COL_SEP3] PSAY "|"			          		
		If lCtaRes
			dbSelectArea("CT1")
			dbSetOrder(1)
			If MsSeek(xFilial()+(cAlias)->CT2_DEBITO)
				@li,aColunas[COL_CTADEB] PSAY CT1->CT1_RES
			EndIf
			dbSelectArea(cAlias)
		Else
			@li,aColunas[COL_CTADEB] PSAY (cAlias)->CT2_DEBITO
		EndIf
		@li,aColunas[COL_SEP4] PSAY "|"						
		If lCtaRes
			dbSelectArea("CT1")
			dbSetOrder(1)
			If MsSeek(xFilial()+(cAlias)->CT2_CREDIT)
				@li,aColunas[COL_CTACRD] PSAY CT1->CT1_RES
			EndIf
			dbSelectArea(cAlias)
		Else		
			@li,aColunas[COL_CTACRD] PSAY (cAlias)->CT2_CREDIT	
		EndIf
		@li,aColunas[COL_SEP5] PSAY "|"											
		
		If lCCRes
			dbSelectArea("CTT")
			dbSetOrder(1)
			If MsSeek(xFilial()+(cAlias)->CT2_CCD)
				@li,aColunas[COL_CCDEB] PSAY CTT->CTT_RES
			EndIf                     
			dbSelectArea(cAlias)
		Else
			@li,aColunas[COL_CCDEB] PSAY (cAlias)->CT2_CCD						
		EndIf		
		@li,aColunas[COL_SEP6] PSAY "|"				  
		If lCCRes
			dbSelectArea("CTT")
			dbSetOrder(1)
			If MsSeek(xFilial()+(cAlias)->CT2_CCC)
				@li,aColunas[COL_CCCRD] PSAY CTT->CTT_RES
			EndIf               
			dbSelectArea(cAlias)
		Else												
			@li,aColunas[COL_CCCRD] PSAY (cAlias)->CT2_CCC
		EndIf
		@li,aColunas[COL_SEP7] PSAY "|"														
		If lItemRes
			dbSelectArea("CTD")
			dbSetOrder(1)
			If MsSeek(xFilial()+(cAlias)->CT2_ITEMD)
				@li,aColunas[COL_ITEMDEB] PSAY CTD->CTD_RES			
			EndIf                                    
			dbSelectArea(cAlias)
		Else
			@li,aColunas[COL_ITEMDEB] PSAY (cAlias)->CT2_ITEMD
		EndIf
		@li,aColunas[COL_SEP8] PSAY "|"	
		If lItemRes													
			dbSelectArea("CTD")
			dbSetOrder(1)
			If MsSeek(xFilial()+(cAlias)->CT2_ITEMC)
				@li,aColunas[COL_ITEMCRD] PSAY CTD->CTD_RES			
			EndIf                                    
			dbSelectArea(cAlias)
		Else
			@li,aColunas[COL_ITEMCRD] PSAY (cAlias)->CT2_ITEMC
		EndIf
		@li,aColunas[COL_SEP9] PSAY "|"														
        If lClVlRes
        	dbSelectArea("CTH")
        	dbSetOrder(1)
        	If MsSeek(xFilial()+(cAlias)->CT2_CLVLDB)
       			@li,aColunas[COL_CLVLDEB] PSAY CTH->CTH_RES
        	EndIf
        	dbSelectArea(cAlias)
        Else
   			@li,aColunas[COL_CLVLDEB] PSAY (cAlias)->CT2_CLVLDB
  		EndIf
		@li,aColunas[COL_SEP10] PSAY "|"				   
        If lClVlRes
        	dbSelectArea("CTH")
        	dbSetOrder(1)
        	If MsSeek(xFilial()+(cAlias)->CT2_CLVLCR)
       			@li,aColunas[COL_CLVLCRD] PSAY CTH->CTH_RES
        	EndIf
        	dbSelectArea(cAlias)
        Else												
			@li,aColunas[COL_CLVLCRD] PSAY (cAlias)->CT2_CLVLCR
		EndIf
		@li,aColunas[COL_SEP11] PSAY "|"														
		ValorCTB((cAlias)->CT2_VALOR,li,aColunas[COL_VALORLANC],16,nDecimais,.F.,cPicture, , , , , , ,)
		@li,aColunas[COL_SEP12] PSAY "|"																					
		li++
	EndIf	
	
	If (cAlias)->CT2_AGLUT == "1"	//Se for lancamento contabil aglutinado             

		U_Ctr680Qry2()			
		cAliasCTK	:= "Ctr680Qry2"

		@ li,000 PSAY Replicate("-",220)										
		
		While !Eof() .And. (cAliasCTK)->CTK_FILIAL == xFilial("CTK") .And. (cAliasCTK)->CTK_SEQUEN == (cAlias)->CT2_SEQUEN

			If  li > 58	
				Cabec( Titulo, Cabec1, Cabec2, NomeProg, Tamanho,;
					Iif(aReturn[4] == 1, GetMv("MV_COMP"), GetMv("MV_NORM")))
				U_Ctr680Cabe((cAlias)->CT2_DATA,(cAlias)->CT2_LOTE,(cAlias)->CT2_SBLOTE,(cAlias)->CT2_DOC)		
			EndIf			
			
            li++
			@li,aColunas[COL_SEP1] PSAY "|"
			@li,aColunas[COL_LINHA] PSAY (cAliasCTK)->CTK_LP
			@li,aColunas[COL_SEP2] PSAY "|"			
			@li,aColunas[COL_DC] PSAY (cAliasCTK)->CTK_LPSEQ
			@li,aColunas[COL_SEP4] PSAY "|"			        
			@li,aColunas[COL_CTACRD] PSAY (cAliasCTK)->CTK_HIST
			@li,aColunas[COL_SEP6] PSAY "|"														
			ValorCTB((cAliasCTK)->CTK_VLR01,li,aColunas[COL_CCCRD],16,nDecimais,.F.,cPicture, , , , , , ,)			
			@li,aColunas[COL_SEP12] PSAY "|"																								
		
			dbSelectArea(cAliasCTK)
			dbSkip()     
		End		
		li++		
		@ li,000 PSAY Replicate("-",220)										
	Else
		If mv_par14 == 2	//Se imprime todos os lançamentos
			@ li,000 PSAY Replicate("-",220)												
			li++
			@li,aColunas[COL_SEP1] PSAY "|"
			@li,aColunas[COL_LINHA] PSAY STR0010 //"Lançamento contábil não aglutinado."
			@li,aColunas[COL_SEP12] PSAY "|"																				
			li++						
			@ li,000 PSAY Replicate("-",220)												
		EndIf	
	EndIf

	dbSelectArea(cAlias)
	dDataAnt	:= (cAlias)->CT2_DATA
	cLoteAnt	:= (cAlias)->CT2_LOTE
	cSbLoteAnt	:= (cAlias)->CT2_SBLOTE
	cDocAnt		:= (cAlias)->CT2_DOC
	dbSkip()
End

If li != 80
	roda(cbcont,cbtxt,"M")
EndIf	

Set Filter To

If aReturn[5] = 1
	Set Printer To
	Commit
	Ourspool(wnrel)
EndIf

MS_FLUSH()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³Ctr680Qry1³ Autor ³ Simone Mie Sato       ³ Data ³ 20.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Montar query para impressao do relatorio                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_Ctr680Qry1()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctr680Qry1()

Local aSaveArea	:= GetArea()  
Local aTamVlr		:= TAMSX3("CT2_VALOR")

Local cQuery	:= ""
Local Ctr680Qry1:= ""

Ctr680Qry1:= "Ctr680Qry1"

cQuery := "SELECT CT2_FILIAL, CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA, CT2_DC, CT2_DEBITO, CT2_CREDIT, "
cQuery += "CT2_CCD, CT2_CCC, CT2_ITEMD, CT2_ITEMC, CT2_CLVLDB, CT2_CLVLCR, CT2_VALOR, CT2_MOEDLC, "
cQuery += "CT2_TPSALD, CT2_HIST, CT2_LP, CT2_SEQUEN, CT2_AGLUT "
cQuery += " FROM "+ RetSqlName("CT2")+ " "
cQuery += " WHERE CT2_FILIAL = '"+ xFilial("CT2")+"' "
cQuery += " AND CT2_DATA BETWEEN '" + DTOS(mv_par01) +"' AND '"+DTOS(mv_par02)+"' "
cQuery += " AND CT2_LOTE BETWEEN '" + mv_par03 +"' AND '" + mv_par04 +"' "
cQuery += " AND CT2_SBLOTE BETWEEN '" + mv_par05 +"' AND '" + mv_par06 +"' "
cQuery += " AND CT2_DOC BETWEEN '" + mv_par07 + "' AND '" + mv_par08 + "' "
cQuery += " AND CT2_MOEDLC = '01' " 
cQuery += " AND CT2_TPSALD = '" + mv_par13 + "' "
cQuery += " AND CT2_DC <> '4' " 
cQuery += " AND CT2_VALOR <> 0 " 
If mv_par14 == 1	//Se imprime somente os lançamentos aglutinados
	cQuery += " AND CT2_AGLUT = '1' "
EndIf
cQuery += " AND D_E_L_E_T_ = ' '"
cQuery += " ORDER BY CT2_FILIAL, CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA "

cQuery := ChangeQuery(cQuery)		   
If ( Select ( Ctr680Qry1 ) <> 0 )
	dbSelectArea ( Ctr680Qry1 )
	dbCloseArea ()
Endif

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),Ctr680Qry1,.T.,.F.)
  		
TCSetField(Ctr680Qry1,"CT2_DATA", "D",8,0)				  		
TCSetField(Ctr680Qry1,"CT2_VALOR", "N",aTamVlr[1],aTamVlr[2])	

dbSelectArea("Ctr680Qry1")
dbGoTop()

RestArea(aSaveArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³Ctr680Qry2³ Autor ³ Simone Mie Sato       ³ Data ³ 20.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Montar query para impressao do relatorio                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_Ctr680Qry2()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctr680Qry2()

Local aSaveArea	:= GetArea()  
Local aStruCTK	:= {}

Local cQuery	:= ""
Local Ctr680Qry2:= ""

Local nY		:= 0 

Ctr680Qry2:= "Ctr680Qry2"

cQuery := "SELECT * "
cQuery += " FROM "+ RetSqlName("CTK")+ " "
cQuery += " WHERE CTK_FILIAL = '"+ xFilial("CTK")+"' "
cQuery += " AND CTK_SEQUEN = '" + Ctr680Qry1->CT2_SEQUEN + "'"
cQuery += " AND CTK_DC = '" + Ctr680Qry1->CT2_DC + "'"
cQuery += " AND CTK_DEBITO = '" + Ctr680Qry1->CT2_DEBITO + "'"
cQuery += " AND CTK_CREDIT = '" + Ctr680Qry1->CT2_CREDIT + "'"
cQuery += " AND CTK_CCD = '" + Ctr680Qry1->CT2_CCD + "'"
cQuery += " AND CTK_CCC = '" + Ctr680Qry1->CT2_CCC + "'"
cQuery += " AND CTK_ITEMD = '" + Ctr680Qry1->CT2_ITEMD + "'"
cQuery += " AND CTK_ITEMC = '" + Ctr680Qry1->CT2_ITEMC + "'"
cQuery += " AND CTK_CLVLDB = '" + Ctr680Qry1->CT2_CLVLDB + "'"
cQuery += " AND CTK_CLVLCR = '" + Ctr680Qry1->CT2_CLVLCR+ "'"
cQuery += " AND D_E_L_E_T_ = ' '"

cQuery := ChangeQuery(cQuery)		   
If ( Select ( Ctr680Qry2 ) <> 0 )
	dbSelectArea ( Ctr680Qry2 )
	dbCloseArea ()
Endif

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),Ctr680Qry2,.T.,.F.)
aStruCTK	:= CTK->(dbStruct())
 		
For nY := 1 To Len(aStruCTK)
	If aStruCTK[nY][2] <> "C" 
		TcSetField(Ctr680Qry2,aStruCTK[nY][1],aStruCTK[nY][2],aStruCTK[nY][3],aStruCTK[nY][4])
    EndIf
Next nY  		

dbSelectArea("Ctr680Qry2")
dbGoTop()

RestArea(aSaveArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³CTR680Cabe³ Autor ³ Simone Mie Sato	    ³ Data ³ 20.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cabeçalho auxiliar                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CTR680Cabec(Titulo,cabec1,cabec2,cSublote,dData,cLote,cDoc, ³±±
±±³          ³lChange)													  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Titulo                                             ³±±
±±³          ³ ExpC2 = Cabec1                                             ³±±
±±³          ³ ExpC3 = Cabec2                                             ³±±
±±³          ³ ExpC4 = SubLote                                            ³±±
±±³          ³ ExpD1 = Data                                               ³±±
±±³          ³ ExpC5 = Lote                                               ³±±
±±³          ³ ExpC6 = Documento                                          ³±±
±±³          ³ ExpL1 = Se mudou o SubLote                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTR680Cabe(dData,cLote,cSubLote,cDoc)

/*
DATA: 99/99/9999	LOTE: 999999	SUBLOTE: 999	DOCUMENTO: 999999
----------------------------------------------------------------------
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        17        18        19        20        21        22 
*/
li++
@ li,000 PSAY Replicate("-",220)
li++
@ li,000 PSAY STR0012 + DTOC(dData)		// "DATA: "
@ li,020 PSAY STR0013 + cLote			// "LOTE: "
@ li,036 PSAY STR0015 + cSubLote		// "SUBLOTE:"
@ li,052 PSAY STR0014 + cDoc			// "DOCUMENTO: "
li++
@ li,000 PSAY Replicate("-",220)

Return
