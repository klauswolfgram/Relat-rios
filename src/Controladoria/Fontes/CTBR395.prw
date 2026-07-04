/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR395.CH"
#Include "PROTHEUS.Ch"


// 17/08/2009 -- Filial com mais de 2 caracteres

STATIC 	SEPARA1		:=		1
STATIC 	COL_REV		:=		2
STATIC 	SEPARA2		:=		3
STATIC 	COLUNA_1	:=     	4
STATIC 	SEPARA3		:=		5
STATIC 	COLUNA_2 	:=     	6
STATIC 	SEPARA4		:=		7
STATIC 	COLUNA_3	:=     	8
STATIC 	SEPARA5		:=		9 
STATIC 	COLUNA_4	:= 		10
STATIC 	SEPARA6		:=		11
STATIC 	COLUNA_5	:= 		12
STATIC 	SEPARA7		:=		13                                                                                       
STATIC 	COLUNA_6	:= 		14
STATIC 	SEPARA8		:=		15
STATIC 	COLUNA_7	:=		16
STATIC 	SEPARA9		:=		17
STATIC 	COLUNA_8	:=		18
STATIC 	SEPARA10	:=		19
STATIC 	COLUNA_9	:=		20
STATIC 	SEPARA11	:=		21
STATIC 	COLUNA_10	:=		22
STATIC 	SEPARA12	:=		23
STATIC 	COLUNA_11	:=		24
STATIC 	SEPARA13	:=		25
STATIC 	COLUNA_12	:=		26
STATIC 	SEPARA14	:=		27
STATIC 	TOTAL   	:=		28
STATIC 	SEPARA15	:=		29

STATIC 	__oCTBR3951

//Tradução PTG 20080721

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ CTBR395    ³ Autor ³ Simone Mie Sato       ³ Data ³ 21.10.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de Comparativo de Orcamentos						³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGACTB                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Ctbr395()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL cString 	:= "CV1"
LOCAL cDesc1    := STR0001 // "Este programa ira emitir o Comparativo do Cadastro de Orcamentos. "
LOCAL cDesc2    := STR0002 // "Deve-se informar as revisões que deverão ser comparadas para  "
LOCAL cDesc3    := STR0003 // "um mesmo orçamento."
LOCAL wnrel

PRIVATE aReturn  := { STR0007, 1,STR0008, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE aLinha   := {}
PRIVATE cPerg    := "CTR395"
PRIVATE nomeprog := "CTBR395"
PRIVATE nLastKey := 0
PRIVATE tamanho  := "G"

PRIVATE titulo  := STR0004 // "Comparativo de Orçamentos"
PRIVATE cabec1  
PRIVATE cabec2
PRIVATE nTamanho

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros:      							³
//³ mv_par01    Do Orcamento           									³
//³ mv_par02    Ate o Orcamento        									³
//³ mv_par03    Revisao 1              									³
//³ mv_par04    Revisao 2              									³
//³ mv_par05    Moeda                    								³
//³ mv_par06    Calendario do Orcamento  								³
//³ mv_par07 	Pag. Inicial                                         	³
//³ mv_par08    Imprime Valor 0,00     									³
//³ mv_par09    Imprime Cod. Conta     									³
//³ mv_par10    Imprime Cod. C.C.      									³
//³ mv_par11    Imprime Cod. Item      									³
//³ mv_par12    Imprime Cod. Cl.Valor  									³
//³ mv_par13    Divide Por			  									³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

li	:= 80 

pergunte(cPerg,.F.)

wnrel := NomeProg
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

If nLastKey == 27
	Return
End

SetDefault( aReturn,cString )

nTamanho:=IIf(aReturn[4]==1,15,18)

If nLastKey == 27
   Return
Endif

RptStatus({|lEnd| Ctr395Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTR395Imp³ Autor ³ Simone Mie Sato       ³ Data ³ 21/10/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o relatorio do cadastro de plano gerencial         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CTR395IMP(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Ctr395Imp(lEnd,wnRel,cString)

Local cOrctoIni		:= mv_par01
Local cOrctoFim		:= mv_par02
Local cRevisa1		:= mv_par03
Local cRevisa2		:= mv_par04
Local cMoeda		:= mv_par05
Local cCalend		:= mv_par06
Local cContaIni		:= ""
Local cContaFim		:= ""
Local cCCIni		:= ""
Local cCCFim		:= ""
Local cItemIni		:= ""
Local cItemFim		:= ""
Local cClVlIni		:= ""
Local cClVlFim		:= ""
Local cEntCC		:= CtbSayApro("CTT")
Local cEntItem		:= CtbSayApro("CTD")
Local cEntClVl		:= CtbSayApro("CTH")
Local cColuna		:= ""
Local cSeparador	:= ""
Local cArqTmp		:= ""
Local cOrcAnt		:= ""
Local cSeqAnt		:= ""     
Local cMensagem		:= ""                
Local cHelp			:= ""

Local nVlrRvs1		:= 0
Local nVlrRvs2		:= 0
Local nRecCV1		:= 0
Local nCont			:= 0
Local limite		:= 220
Local nColuna		:= 0
Local nSepara		:= 0
Local nTotLinha		:= 0 
Local nTotRev1		:= 0
Local nTotRev2		:= 0
Local nDivide		:= 1

Local aColunas		:= {}
Local aCabAux		:= {}
Local aRevisa1		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local aRevisa2		:= {0,0,0,0,0,0,0,0,0,0,0,0}

Local lFirstPage	:= .T.
Local lFirstOrc		:= .T.
Local lTemConta		:= .F.
Local lTemCusto		:= .F.
Local lTemItem		:= .F.
Local lTemClVl		:= .F.
Local lDifConta		:= .F.
Local lDifCusto		:= .F.
Local lDifItem		:= .F.
Local lDifClVl		:= .F.
Local lMensagem		:= .T.
Local lPrintZero	:= Iif(mv_par08==1,.T.,.F.)
Local lCtaRes		:= Iif(mv_par09 == 2, .T.,.F.)
Local lCCRes		:= Iif(mv_par10 == 2, .T.,.F.) 
Local lItemRes		:= Iif(mv_par11 == 2, .T.,.F.) 
Local lClVlRes		:= Iif(mv_par12 == 2, .T.,.F.) 


Titulo	:=	STR0004	//"Comparativo de Orcamentos"
cabec1  := 	STR0015	//"|       |  PERIODO 01  |  PERIODO 02  |  PERIODO 03  |  PERIODO 04  |  PERIODO 05  |  PERIODO 06  |  PERIODO 07  |  PERIODO 08  |  PERIODO 09  |  PERIODO 10  |  PERIODO 11  |  PERIODO 12  |TOTAL              |"		
cabec2	:= ""          


aColunas := { 000, 001, 009, 010, 025, 026, 041, 042, 057, 058, 073, 074, 089, 090, 105,  106, 121, 122, 137, 138, 153, 154, 169, 170, 185, 186 , 201, 202, 219} 

m_pag := mv_par08        

//Se a revisao 2 for menor que a revisao 1, o relatorio nao podera ser impresso
If mv_par03 > mv_par04
	cHelp	:= STR0026 + chr(9)	//"O código da revisao 1 não poderá ser maior que o código "		
	cHelp 	+= STR0027    		//"da revisão 2."						
	MsgAlert(cHelp)
	Return
EndIf

If Empty(cMoeda)
	cHelp	:= STR0028	//"Favor preencher o parametro Moeda"		
	MsgAlert(cHelp)
	Return
EndIf


cMensagem	:= STR0024 + chr(09) 	//"Será impresso somente 12 colunas de movimento. Caso o calendário contábil possua mais de "
cMensagem 	+= STR0025				//"12 períodos, os períodos superiores a 12 serão ignorados.   "	

If mv_par13 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par13 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par13 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao   					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			U_CTB395Cria(oMeter,oText,oDlg,lEnd,@cArqTmp,cOrctoIni,cOrctoFim,;
			cRevisa1,cRevisa2,cCalend,cMoeda)},;
			STR0019,;		// "Criando Arquivo Tempor rio..."
			STR0004)		// "Comparativo de Orcamentos"

dbSelectArea(cArqTmp)
SetRegua(RecCount())
dbGoTop()


While !Eof()

	If lEnd
		@Prow()+1,0 PSAY STR0006   //"***** CANCELADO PELO OPERADOR *****"
		Exit
	EndIF
	
	IncRegua()
	
	//Adiciona no array aCabAux as datas finais do calendario contabil	                      
	dbSelectArea("CTG")
	dbSetOrder(1) 
	If MsSeek(xFilial()+cCalend)
		While CTG->CTG_FILIAL == xFilial() .And. cCalend == CTG->CTG_CALEND		
			AADD(aCabAux,CTG->CTG_DTFIM)
			dbSkip()
		End	
	EndIf       
	
    //Se o calendario contabil tiver mais que 12 periodos, sera exibido mensagem que os periodos 
    //superiores a 12 serão ignorados.                            
    If lMensagem
		If Len(aCabAux) > 12
			MsgAlert(cmensagem)
		EndIf
		lMensagem 	:= .F.
	EndIf
		

	Cabec2 	:= "|"+STR0014+"|"	//"REVISAO"  	
	
	For nCont := 1 to 12
		Cabec2	+= SPACE(3)+DTOC(aCabAux[nCont])+ SPACE(4)+"|"	
	Next  
	
	Cabec2	+= SPACE(17)+"|"       			
	
	IF li > 58 
		If !lFirstPage
			@Prow()+1,00 PSAY	Replicate("-",limite)
		EndIf
		CtCGCCabec(,,,Cabec1,Cabec2,dDataBase,Titulo,,"2",Tamanho)
		lFirstPage := .F.	
	EndIf
	
	dbSelectArea(cArqTmp)
	dbSetOrder(1)
	
	If lFirstOrc .Or. (cArqTmp)->ORCMTO <> cOrcAnt .Or. (cArqTmp)->SEQUEN <> cSeqAnt
			
		If lFirstOrc .And. (cArqTmp)->ORCMTO <> cOrcAnt
			//Imprime o codigo do orcamento
			@li,aColunas[SEPARA1]	PSAY Replicate("-",limite)
			li++
			@li,aColunas[SEPARA1]	PSAY "|"
			@li,aColunas[COLUNA_1]  PSAY STR0023 + (cArqTmp)->ORCMTO	// "Codigo do orçamento: "
			@li,aColunas[SEPARA15]	PSAY "|"			
			li++			
			@li,aColunas[SEPARA1]	PSAY Replicate("-",limite)		
			li++
		EndIf                  
			
		lTemConta	:= IIf(!Empty((cArqTmp)->CONTAINI)  .Or. !Empty((cArqTmp)->CONTAFIM),.T.,.F.)
		lTemCusto	:= IIf(!Empty((cArqTmp)->CUSTOINI) .Or. !Empty((cArqTmp)->CUSTOFIM),.T.,.F.)
		lTemItem 	:= IIf(!Empty((cArqTmp)->ITEMINI) .Or. !Empty((cArqTmp)->ITEMFIM),.T.,.F.)		
		lTemClVl 	:= IIf(!Empty((cArqTmp)->CLVLINI) .Or. !Empty((cArqTmp)->CLVLFIM),.T.,.F.)
			
		lDifConta	:= Iif((cArqTmp)->CONTAINI <> (cArqTmp)->CONTAFIM,.T.,.F.)
		lDifCusto	:= Iif((cArqTmp)->CUSTOINI <> (cArqTmp)->CUSTOFIM,.T.,.F.)
		lDifItem	:= Iif((cArqTmp)->ITEMINI <> (cArqTmp)->ITEMFIM,.T.,.F.)
		lDifClVl	:= Iif((cArqTmp)->CLVLINI <> (cArqTmp)->CLVLFIM,.T.,.F.)
		
		//Se for sequencia diferente dentro de um mesmo orcamento
		If (cArqTmp)->SEQUEN <> cSeqAnt				
			//Se uma das entidades inicial for diferente da entidade final, imprime a 
			//entidade inicial e a entidade final.  
			If lDifConta .Or. lDifCusto .Or. lDifItem .Or. lDifClVl
				@ li,aColunas[SEPARA1] PSAY REPLICATE("-",limite)
				li++                     							
				@li, aColunas[SEPARA1] 	PSAY "|"								                                                                                            
				If lTemConta 
					If lCtaRes	//Imprime codigo de conta reduzido
						@li, aColunas[COL_REV]	PSAY STR0017 + Alltrim((cArqTmp)->CTAINIRES) + STR0018 + Alltrim((cArqTmp)->CTAFIMRES) 					//"Conta:"  "à"                               						
					Else
						@li, aColunas[COL_REV]	PSAY STR0017 + Alltrim((cArqTmp)->CONTAINI) + STR0018 + Alltrim((cArqTmp)->CONTAFIM) 					//"Conta:"  "à"                               
					EndIf
				EndIf
				If lTemCusto
					If lCCRes
						@li, aColunas[SEPARA4] PSAY Alltrim(cEntCC) +":"+ Alltrim((cArqTmp)->CCINIRES) + STR0018 + Alltrim((cArqTmp)->CCFIMRES)		//C.Custo						
					Else
						@li, aColunas[SEPARA4] PSAY Alltrim(cEntCC) +":"+ Alltrim((cArqTmp)->CUSTOINI) + STR0018 + Alltrim((cArqTmp)->CUSTOFIM)		//C.Custo
					EndIf
				EndIf
				If lTemItem
					If lItemRes
						@li, aColunas[SEPARA8]	PSAY Alltrim(cEntItem)+":" + Alltrim((cArqTmp)->ITINIRES) + STR0018 + Alltrim((cArqTmp)->ITFIMRES)		//Item									
					Else
						@li, aColunas[SEPARA8]	PSAY Alltrim(cEntItem)+":" + Alltrim((cArqTmp)->ITEMINI) + STR0018 + Alltrim((cArqTmp)->ITEMFIM)		//Item			
					EndIf
				EndIF
				If lTemClVl
					If lClVlRes
						@li, aColunas[SEPARA12]	PSAY Alltrim(cEntClVl) +":"+ Alltrim((cArqTmp)->CVINIRES) + STR0018 + Alltrim((cArqTmp)->CVFIMRES)		//ClVl												
					Else
						@li, aColunas[SEPARA12]	PSAY Alltrim(cEntClVl) +":"+ Alltrim((cArqTmp)->CLVLINI) + STR0018 + Alltrim((cArqTmp)->CLVLFIM)		//ClVl						
					EndIf
				EndIF
				@ li,aColunas[SEPARA15]	PSAY "|"                                										
			Else
				@ li,aColunas[SEPARA1] PSAY REPLICATE("-",limite)
				li++                     							
				@li, aColunas[SEPARA1] 	PSAY "|"								                                                                                            									
				If lTemConta
					If lCtaRes
						@li, aColunas[COL_REV]			PSAY STR0017 + Alltrim((cArqTmp)->CTAINIRES) 	//"Conta:"						
					Else
						@li, aColunas[COL_REV]			PSAY STR0017 + Alltrim((cArqTmp)->CONTAINI) 	//"Conta:"
					EndIf
					@li, aColunas[COLUNA_2]+3    	PSAY Subs((cArqTmp)->DESCCTA,1,20)
				EndIf      
				If lTemCusto
					If lCCRes
						@li, aColunas[SEPARA4]+10	  PSAY Alltrim(cEntCC) +":"+ Alltrim((cArqTmp)->CCINIRES) //C.Custo						
					Else
						@li, aColunas[SEPARA4]+10	  PSAY Alltrim(cEntCC) +":"+ Alltrim((cArqTmp)->CUSTOINI) //C.Custo
					EndIf
					@li, aColunas[COLUNA_5]  	  PSAY Subs((cArqTmp)->DESCCC,1,20)
				EndIf
				If lTemItem                                                             
					If lItemRes
						@li, aColunas[SEPARA8]	PSAY Alltrim(cEntItem)+":" + Alltrim((cArqTmp)->ITINIRES) //Item									
					Else
						@li, aColunas[SEPARA8]	PSAY Alltrim(cEntItem)+":" + Alltrim((cArqTmp)->ITEMINI) //Item			
					EndIf
					@li, aColunas[SEPARA10]  	PSAY Subs((cArqTmp)->DESCITEM,1,20)
				EndIf
				If lTemClVl
					If lClVlRes
						@li, aColunas[SEPARA12]	PSAY Alltrim(cEntClVl) +":"+ Alltrim((cArqTmp)->CVINIRES) 	//ClVl						
					Else
						@li, aColunas[SEPARA12]	PSAY Alltrim(cEntClVl) +":"+ Alltrim((cArqTmp)->CLVLINI) 	//ClVl						
					EndIf						
					@li, aColunas[SEPARA14] PSAY Subs((cArqTmp)->DESCCLVL,1,18)
				EndIf
				@ li,aColunas[SEPARA15]	PSAY "|"                                															
			EndIf         
		EndIf
		
		lFirstOrc	:= .F.
		If (cArqTmp)->SEQUEN <> cSeqAnt .Or. (cArqTmp)->ORCMTO <> cOrcAnt				
			li++                    
			@ li,aColunas[SEPARA1] PSAY REPLICATE("-",limite)
			li++                     									
		EndIf
	EndIf
	
	@li,aColunas[SEPARA1]	PSAY "|"
	@li,aColunas[COL_REV] 	PSAY (cArqTmp)->REVISAO		
	@li,aColunas[SEPARA2]	PSAY "|" 

	nSepara	:= 3	
	
	For nCont	:= 1 to 12
		cColuna	:= "COLUNA_"+Alltrim(Str(nCont,2))		
		cSepara	:= "SEPARA"+Alltrim(Str(nSepara,2))			
		
		ValorCTB(&("COLUNA"+Alltrim(Str(nCont,2)))/nDivide,li,aColunas[&(cColuna)],12,2,.F.,"", , , , , , ,lPrintZero)		

		@li,aColunas[&(cSepara)]	PSAY "|"			     								
		nSepara++                                                                          
		nTotLinha	+= &("COLUNA"+Alltrim(Str(nCont,2)))
		
		If (cArqTmp)->REVISAO == cRevisa1
			aRevisa1[nCont] := &("COLUNA"+Alltrim(Str(nCont,2)))
			nTotRev1	:= nTotLinha
		EndIf
		If (cArqTmp)->REVISAO == cRevisa2
			aRevisa2[nCont] := &("COLUNA"+Alltrim(Str(nCont,2)))		
			nTotRev2	:= nTotLinha
		EndIf		
	Next							     

	ValorCTB(nTotLinha/nDivide,li,aColunas[TOTAL],12,2,.F.,"", , , , , , ,lPrintZero)

	@li,aColunas[SEPARA15]	PSAY "|" 				
	nTotLinha := 0 
	
    dbSelectArea(cArqTmp)
    cOrcAnt	:= (cArqTmp)->ORCMTO
    cSeqAnt	:= (cArqTmp)->SEQUEN
	dbSkip()
	//Imprime a variacao das 2 revisoes                  
	If cOrcAnt <> (cArqTmp)->ORCMTO .Or. cSeqAnt <> (cArqTmp)->SEQUEN
		li++                                                   
		@ li,aColunas[SEPARA1] PSAY REPLICATE("-",limite)		
		li++            
		@li,aColunas[SEPARA1]	PSAY "|" 						
		@li,aColunas[COL_REV] 	PSAY STR0022	//"VARI~ÇÃO"    
		@li,aColunas[SEPARA2]	PSAY "|" 								
		
		nSepara	:= 3			
		
		For nCont	:= 1 to 12
			cColuna	:= "COLUNA_"+Alltrim(Str(nCont,2))		
			cSepara	:= "SEPARA"+Alltrim(Str(nSepara,2))			

   			ValorCTB(((aRevisa1[nCont]/aRevisa2[nCont] )*100),li,aColunas[&(cColuna)],10,2,.F.,"", , , , , , , ,)			
			@li,aColunas[&(cColuna)]+10 PSAY "%"
			@li,aColunas[&(cSepara)]	PSAY "|"			     								
			nSepara++                                                                          
		Next							                                                       		
		ValorCTB(((nTotRev1/nTotRev2)*100),li,aColunas[TOTAL],10,2,.F.,"", , , , , , , ,)			
		@li,aColunas[TOTAL]+10 PSAY "%"		
		@li,aColunas[SEPARA15]	PSAY "|" 										
		li++                                                   
		@ li,aColunas[SEPARA1] PSAY REPLICATE("-",limite)		
		li++            
		aRevisa1	:= {0,0,0,0,0,0,0,0,0,0,0,0}
		aRevisa2	:= {0,0,0,0,0,0,0,0,0,0,0,0}
		nTotRev1	:= 0
		nTotRev2	:= 0        
		lFirstOrc	:= .T.
	EndIf
	li++	                                                      
End		
		
If aReturn[5] = 1 .And. ! lExterno
	Set Printer To
	Commit
	Ourspool(wnrel)
EndIf

If __oCTBR3951 <> Nil
	__oCTBR3951:Delete()
	__oCTBR3951 := Nil
Endif

dbselectArea("CV1")


If ! lExterno
	MS_FLUSH()
Endif

Return .T.                                   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CTB395Cria³ Autor ³ Simone Mie Sato       ³ Data ³ 04/11/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Cria Arquivo Temporario.                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³U_Ctb395Cria(oMeter,oText,oDlg,lEnd,cArqTmp,cOrctoIni,		   ³±±
±±³			  ³						cOrctoFim,cRevisa1,cRevisa2,cCalend,   ³±±
±±³			  ³						cMoeda)				                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nome do arquivo temporario                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter                                      ³±±
±±³           ³ ExpO2 = Objeto oText                                       ³±±
±±³           ³ ExpO3 = Objeto oDlg                                        ³±±
±±³           ³ ExpL1 = Acao do Codeblock                                  ³±±
±±³           ³ ExpC1 = Arquivo temporario                                 ³±±
±±³           ³ ExpC2 = Codigo do Orcamento Inicial                        ³±±
±±³           ³ ExpC3 = Codigo do Orcamento Final                          ³±±
±±³           ³ ExpC4 = Codigo da Revisao 1                                ³±±
±±³           ³ ExpC5 = Codigo da Revisao 2                                ³±±
±±³           ³ ExpC6 = Codigo do Calendario Contabil                      ³±±
±±³           ³ ExpC7 = Codigo da Moeda					                   ³±±
±±³           ³ ExpL2 = Indica se eh Comparacao de Revisao de um Orcamento ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTB395Cria(oMeter,oText,oDlg,lEnd,cArqTmp,cOrctoIni,cOrctoFim,;
					cRevisa1,cRevisa2,cCalend,cMoeda)

Local aTamConta	:= TAMSX3("CT1_CONTA")
Local aTamCusto	:= TAMSX3("CTT_CUSTO")
Local aTamItem	:= TAMSX3("CTD_ITEM")
Local aTamClVl	:= TAMSX3("CTH_CLVL")
Local aDecimais	:= TAMSX3("CV1_VALOR")
Local aTamVal	:= TAMSX3("CT2_VALOR")
Local aCtbMoeda	:= {}
Local aSaveArea := GetArea()
Local aCampos

Local aChave		:= {}
Local nDescCta	:= Len(CriaVar("CT1_DESC"+cMoeda))
Local nDescCC 	:= Len(CriaVar("CTT_DESC"+cMoeda))
Local nDescItem := Len(CriaVar("CTD_DESC"+cMoeda))
Local nDescClVl	:= Len(CriaVar("CTH_DESC"+cMoeda))
Local nDecimais	:= aDecimais[2]


// Retorna Decimais
aCtbMoeda := CTbMoeda(cMoeda)
nDecimais := aCtbMoeda[5]

aCampos :={	{ "ORCMTO"		, "C", 6			, 0 },;  	// Codigo do Orcamento
			{ "CALEND"		, "C", 3			, 0 },;  	// Codigo do Calendario
			{ "REVISAO"		, "C", 3			, 0 },;  	// Codigo da Revisao		
			{ "SEQUEN" 		, "C", 4			, 0 },;  	// Codigo da Sequencia	
			{ "MOEDA"  		, "C", 2			, 0 },;  	// Codigo da Moeda
			{ "CONTAINI"	, "C", aTamConta[1]	, 0 },;  	// Conta Inicial
			{ "CONTAFIM"	, "C", aTamConta[1]	, 0 },;  	// Conta Final
			{ "CUSTOINI"	, "C", aTamCusto[1]	, 0 },;  	// Centro de Custo Inicial
			{ "CUSTOFIM"	, "C", aTamCusto[1]	, 0 },;  	// Centro de Custo Final
			{ "ITEMINI" 	, "C", aTamItem[1]	, 0 },;  	// Item Inicial
			{ "ITEMFIM" 	, "C", aTamItem[1]	, 0 },;  	// Item Final
			{ "CLVLINI" 	, "C", aTamClVl[1]	, 0 },;  	// Classe de Valor Inicial
			{ "CLVLFIM" 	, "C", aTamClVl[1]	, 0 },;  	// Classe de Valor Final
			{ "DESCCTA"		, "C", nDescCta   	, 0 },;  	// Descricao da Conta
			{ "DESCCC"		, "C", nDescCC    	, 0 },;  	// Descricao do Centro de Custo 
			{ "DESCITEM"	, "C", nDescItem  	, 0 },;		// Descricao do Item
			{ "DESCCLVL"	, "C", nDescClVl  	, 0 },;		// Descricao da Classe de Valor
			{ "CTAINIRES"	, "C", 10		  	, 0 },;  	// Conta Inicial Reduzida
			{ "CTAFIMRES"	, "C", 10         	, 0 },;  	// Conta Final Reduzida
			{ "CCINIRES"	, "C", 10		  	, 0 },;  	// C.Custo Inicial Reduzida
			{ "CCFIMRES"	, "C", 10         	, 0 },;  	// C.Custo Final Reduzida
			{ "ITINIRES"	, "C", 10		  	, 0 },;  	// Item Inicial Reduzida
			{ "ITFIMRES"	, "C", 10         	, 0 },;  	// Item Final Reduzida  
			{ "CVINIRES"	, "C", 10		  	, 0 },;  	// Cl.Valor Inicial Reduzida
			{ "CVFIMRES"	, "C", 10         	, 0 },;  	// Cl.Valor Final Reduzida			
			{ "COLUNA1" 	, "N", aTamVal[1]+2	, nDecimais },; 	// Coluna1
			{ "COLUNA2" 	, "N", aTamVal[1]+2, nDecimais },; 	// Coluna2
			{ "COLUNA3" 	, "N", aTamVal[1]+2, nDecimais },; 	// Coluna3
			{ "COLUNA4" 	, "N", aTamVal[1]+2, nDecimais },; 	// Coluna4
			{ "COLUNA5" 	, "N", aTamVal[1]+2, nDecimais },; 	// Coluna5
			{ "COLUNA6" 	, "N", aTamVal[1]+2, nDecimais },; 	// Coluna6
			{ "COLUNA7" 	, "N", aTamVal[1]+2, nDecimais },; 	// Coluna7
			{ "COLUNA8" 	, "N", aTamVal[1]+2, nDecimais },; 	// Coluna8									
			{ "COLUNA9" 	, "N", aTamVal[1]+2, nDecimais },; 	// Coluna9									
			{ "COLUNA10" 	, "N", aTamVal[1]+2, nDecimais },; 	// Coluna10											
			{ "COLUNA11" 	, "N", aTamVal[1]+2, nDecimais },;		// Coluna11								
			{ "COLUNA12" 	, "N", aTamVal[1]+2, nDecimais } } 	// Coluna12		

//-------------------
//Criação do objeto
//-------------------
cArqTmp := GetNextAlias()

__oCTBR3951 := FWTemporaryTable():New(cArqTmp)
__oCTBR3951:SetFields( aCampos )

aChave   := {"ORCMTO","CALEND","SEQUEN","REVISAO"}

__oCTBR3951:AddIndex("1", aChave)

__oCTBR3951:Create()

dbSelectArea(cArqTmp)
dbSetOrder(1)

//Gravar no arquivo temporario
U_Ctb395Grv(oMeter,oText,oDlg,lEnd,cArqTmp,cOrctoIni,cOrctoFim,cRevisa1,cRevisa2,cCalend,cMoeda)

RestArea(aSaveArea)

Return cArqTmp

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CTB395Grv ³ Autor ³ Simone Mie Sato       ³ Data ³ 04/11/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Grava Arquivo Temporario.                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³U_Ctb395Grv((oMeter,oText,oDlg,lEnd,cArqTmp,cOrctoIni,		   ³±±
±±³			  ³						cOrctoFim,cRevisa1,cRevisa2,cCalend)   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nome do arquivo temporario                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter                                      ³±±
±±³           ³ ExpO2 = Objeto oText                                       ³±±
±±³           ³ ExpO3 = Objeto oDlg                                        ³±±
±±³           ³ ExpL1 = Acao do Codeblock                                  ³±±
±±³           ³ ExpC1 = Arquivo temporario                                 ³±±
±±³           ³ ExpC2 = Codigo do Orcamento Inicial                        ³±±
±±³           ³ ExpC3 = Codigo do Orcamento Final                          ³±±
±±³           ³ ExpC4 = Codigo da Revisao 1                                ³±±
±±³           ³ ExpC5 = Codigo da Revisao 2                                ³±±
±±³           ³ ExpC6 = Codigo do Calendario Contabil                      ³±±
±±³           ³ ExpC7 = Codigo da Moeda					                   ³±±
±±³           ³ ExpL2 = Indica se eh comparat.de rev. de um mesmo orcamento³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTB395Grv(oMeter,oText,oDlg,lEnd,cArqTmp,cOrctoIni,cOrctoFim,;
					cRevisa1,cRevisa2,cCalend,cMoeda)
					
Local aSavearea	:= GetArea() 

Local nTotal	:= 0 
Local nColuna	:= 0
Local nRecCV1	:= 0 
Local nCont		:= 0 

Local cOrcmto	:= ""
Local cDescCta	:= ""
Local cDescCC	:= ""
Local cDescItem	:= ""
Local cDescClVl	:= ""             
Local cSequen	:= ""
Local cCtaIniRes:= ""
Local cCtaFimRes:= ""
Local cCCIniRes	:= ""
Local cCCFimRes	:= ""
Local cItIniRes	:= ""
Local cItFimRes	:= ""
Local cCvIniRes	:= ""
Local cCvFimRes	:= ""

Local lFirst	:= .T.      
Local lImpDesc	:= .F.

Local aCodRev1		:= {}
Local aCodRev2		:= {}

If !IsBlind()
	oMeter:nTotal := CV1->(RecCount())
EndIf

dbSelectArea("CV1")
dbSetOrder(1)
MsSeek(xFilial()+cOrctoIni,.T.)

While !Eof() .And. CV1->CV1_FILIAL == xFilial("CV1") .And. CV1->CV1_ORCMTO <= cOrctoFim
	
	If CV1->CV1_REVISA <> cRevisa1 .And. CV1->CV1_REVISA <> cRevisa2
		dbSkip()
		Loop
	EndIf               
	
	If CV1->CV1_CALEND <> cCalend
		dbSkip()
		Loop
	EndIf

	cOrcmto	:= CV1->CV1_ORCMTO

	//Revisao1						
	If MsSeek(xFilial()+ cOrcmto+cCalend+cMoeda+cRevisa1)
		
		While !Eof() .And. xFilial() == CV1->CV1_FILIAL .And. cOrcmto == CV1->CV1_ORCMTO .And. ;
			CV1->CV1_CALEND == cCalend .And. CV1->CV1_MOEDA == cMoeda .And.;
			CV1->CV1_REVISA == cRevisa1
			
			//Se todas as entidades iniciais forem iguais às entidades finais, gravar as descricoes
			//das entidades
			If 	CV1->CV1_CT1INI == CV1->CV1_CT1FIM .And. CV1->CV1_CTTINI == CV1->CV1_CTTFIM .And. ;
				CV1->CV1_CTDINI == CV1->CV1_CTDFIM .And. CV1->CV1_CTHINI == CV1->CV1_CTHFIM        
				lImpDesc	:= .T.
			Else
				lImpDesc	:= .F.
			EndIf					
				
			If !Empty(CV1->CV1_CT1INI)
				dbSelectArea("CT1")
				dbSetOrder(1)
				If MsSeek(xFilial()+CV1->CV1_CT1INI)
					cCtaIniRes	:= CT1->CT1_RES              
					If lImpDesc
						cDescCta	:= &("CT1->CT1_DESC"+cMoeda) 
						If Empty(cDescCta)
							cDescCta	:= CT1->CT1_DESC01
						EndIf							
					EndIf						        
				EndIF
				If MsSeek(xFilial()+CV1->CV1_CT1FIM)
					cCtaFimRes	:= CT1->CT1_RES
				EndIf
			EndIf
							
			If !Empty(CV1->CV1_CTTINI)
				dbSelectArea("CTT")
				dbSetOrder(1)
				If MsSeek(xFilial()+CV1->CV1_CTTINI)
					cCCIniRes	:= CTT->CTT_RES						
					If lImpDesc
						cDescCC 	:= &("CTT->CTT_DESC"+cMoeda) 
						If Empty(cDescCC)
							cDescCC	:= CTT->CTT_DESC01
						EndIf				
					EndIf			
				EndIf						
				If MsSeek(xFilial()+CV1->CV1_CTTFIM)
					cCCFimRes	:= CTT->CTT_RES
				EndIf							
			EndIf
		
			If !Empty(CV1->CV1_CTDINI)
				dbSelectArea("CTD")
				dbSetOrder(1)
				If MsSeek(xFilial()+CV1->CV1_CTDINI)
					cItIniRes	:= CTD->CTD_RES												
					If lImpDesc
						cDescItem	:= &("CTD->CTD_DESC"+cMoeda) 
						If Empty(cDescItem)
							cDescItem	:= CTD->CTD_DESC01
						EndIf							
					EndIf
				EndIf	 
				If MsSeek(xFilial()+CV1->CV1_CTDFIM)
					cItFimRes	:= CTD->CTD_RES
				EndIf																		
			EndIf

			If !Empty(CV1->CV1_CTHINI)
				dbSelectArea("CTH")
				dbSetOrder(1)
				If MsSeek(xFilial()+CV1->CV1_CTHINI)
					cCvIniRes	:= CTH->CTH_RES																		
					If lImpDesc
						cDescClVl	:= &("CTH->CTH_DESC"+cMoeda) 
						If Empty(cDescClVl)
							cDescClVl	:= CTH->CTH_DESC01
						EndIF
					EndIf							
				EndIf						
				If MsSeek(xFilial()+CV1->CV1_CTHFIM)
					cCvFimRes	:= CTH->CTH_RES
				EndIf													
			EndIf						
			
			dbSelectArea(cArqTmp)
			dbSetOrder(1)	
			cSequen	:= CV1->CV1_SEQUEN				
								
			If !MsSeek(cOrcMto+cCalend+cSequen+cRevisa1)					
			
				AADD(aCodRev1,{cOrcMto,cSequen}) 				
				
				RecLock(cArqTmp,.T.)
				Replace ORCMTO		With CV1->CV1_ORCMTO
				Replace CALEND		With CV1->CV1_CALEND
				Replace REVISAO		With CV1->CV1_REVISA
				Replace SEQUEN		With CV1->CV1_SEQUEN
				Replace MOEDA 		With CV1->CV1_MOEDA
				Replace CONTAINI	With CV1->CV1_CT1INI
				Replace CONTAFIM	With CV1->CV1_CT1FIM
				Replace CUSTOINI	With CV1->CV1_CTTINI					
				Replace CUSTOFIM	With CV1->CV1_CTTFIM					
				Replace ITEMINI 	With CV1->CV1_CTDINI				
				Replace ITEMFIM 	With CV1->CV1_CTDFIM				
				Replace CLVLINI 	With CV1->CV1_CTHINI				
				Replace CLVLFIM 	With CV1->CV1_CTHFIM				
				Replace CTAINIRES 	With cCtaIniRes										
				Replace CTAFIMRES 	With cCtaFimRes															
				Replace CCINIRES 	With cCCIniRes																						
				Replace CCFIMRES 	With cCCFimRes																							    	    
				Replace ITINIRES 	With cItIniRes																						
				Replace ITFIMRES 	With cItFimRes																											
				Replace CVINIRES 	With cCvIniRes																																	
				Replace CVFIMRES 	With cCvFimRes																																						
				If !Empty(cDescCta)
					Replace DESCCTA With cDescCta						
				EndIf                                                   
					
				If !Empty(cDescCC)
					Replace DESCCC With cDescCC		 
				EndIf
				If !Empty(cDescItem)
					Replace DESCITEM With cDescItem
				Endif
				If !Empty(cDescClVl)
					Replace DESCCLVL With cDescClVl
				EndIf						       
				nColuna	:= Val(CV1->CV1_PERIODO)								
				Replace &("COLUNA"+Alltrim(Str(nColuna,2))) With CV1->CV1_VALOR			  																		
			Else                                                                
				nColuna	:= Val(CV1->CV1_PERIODO)												
				Replace &("COLUNA"+Alltrim(Str(nColuna,2))) With CV1->CV1_VALOR			  																							
			Endif					
			MsUnlock()
			dbSelectArea("CV1")
    	 	dbSkip()
  		End		  	
	EndIf
		
	//Revisao 2
	If MsSeek(xFilial()+ cOrcmto+cCalend+cMoeda+cRevisa2)
			
		While !Eof() .And. xFilial() == CV1->CV1_FILIAL .And. cOrcmto == CV1->CV1_ORCMTO .And. ;
			CV1->CV1_CALEND == cCalend .And. CV1->CV1_MOEDA == cMoeda .And.;
			CV1->CV1_REVISA == cRevisa2
			
			dbSelectArea(cArqTmp)
			dbSetOrder(1)	       
			cSequen	:= CV1->CV1_SEQUEN     
				
			If !MsSeek(cOrcMto+cCalend+cSequen+cRevisa2)									
				AADD(aCodRev2,{cOrcMto,cSequen}) 				
				RecLock(cArqTmp,.T.)
				Replace ORCMTO		With CV1->CV1_ORCMTO
				Replace CALEND		With CV1->CV1_CALEND
				Replace REVISAO		With CV1->CV1_REVISAO
				Replace SEQUEN		With CV1->CV1_SEQUEN
				Replace MOEDA 		With CV1->CV1_MOEDA
				Replace CONTAINI	With CV1->CV1_CT1INI
				Replace CONTAFIM	With CV1->CV1_CT1FIM
				Replace CUSTOINI	With CV1->CV1_CTTINI					
				Replace CUSTOFIM	With CV1->CV1_CTTFIM					
				Replace ITEMINI 	With CV1->CV1_CTDINI				
				Replace ITEMFIM 	With CV1->CV1_CTDFIM				
				Replace CLVLINI 	With CV1->CV1_CTHINI				
				Replace CLVLFIM 	With CV1->CV1_CTHFIM									
						    
				If !Empty(cDescCta)
					Replace DESCCTA With cDescCta						
				EndIf
				If !Empty(cDescCC)
					Replace DESCCC With cDescCC												
				EndIf
				If !Empty(cDescItem)
					Replace DESCITEM With cDescItem
				Endif
				If !Empty(cDescClVl)
					Replace DESCCLVL With cDescClVl
				EndIf						       
				nColuna	:= Val(CV1->CV1_PERIODO)								
				Replace &("COLUNA"+Alltrim(Str(nColuna,2))) With CV1->CV1_VALOR			  																		
			Else                                                                
				nColuna	:= Val(CV1->CV1_PERIODO)												
				Replace &("COLUNA"+Alltrim(Str(nColuna,2))) With CV1->CV1_VALOR			  																							
			Endif					
			MsUnlock()
			dbSelectArea("CV1")
    	 	dbSkip()
  		End	    
  	EndIf
End

//Verificar o que foi gravado para a revisao 1 e verificar se existe para a revisao 2. 
//Caso nao exista, ira gravar com os valores zerados. 

For nCont := 1 to Len(aCodRev1)
	dbSelectArea(cArqTmp)
	dbSetOrder(1)
	If !MsSeek(aCodRev1[nCont][1]+cCalend+aCodRev1[nCont][2]+cRevisa2)									
		RecLock(cArqTmp,.T.)
		Replace ORCMTO		With aCodRev1[nCont][1]
		Replace CALEND		With cCalend
		Replace REVISAO		With cRevisa2
		Replace SEQUEN		With aCodRev1[nCont][2]
		Replace MOEDA 		With cMoeda
		MsUnlock()				  		
	EndIf
Next

//Verificar o que foi gravado para a revisao 2 e verificar se existe para a revisao 1. 
//Caso nao exista, ira gravar com os valores zerados. 
For nCont := 1 to Len(aCodRev2)
	dbSelectArea(cArqTmp)
	dbSetOrder(1)
	If !MsSeek(aCodRev2[nCont][1]+cCalend+aCodRev2[nCont][2]+cRevisa1)									
		RecLock(cArqTmp,.T.)
		Replace ORCMTO		With aCodRev2[nCont][1]
		Replace CALEND		With cCalend
		Replace REVISAO		With cRevisa1
		Replace SEQUEN		With aCodRev2[nCont][2]
		Replace MOEDA 		With cMoeda
		MsUnlock()				  		
	EndIf
Next

RestArea(aSaveArea)

Return