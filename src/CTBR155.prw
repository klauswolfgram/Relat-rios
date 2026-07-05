/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr155.Ch"
#Include "PROTHEUS.Ch"

#DEFINE 	COL_SEPARA1			1
#DEFINE 	COL_CLVL   			2
#DEFINE 	COL_SEPARA2			3
#DEFINE 	COL_DESCRICAO		4
#DEFINE 	COL_SEPARA3			5
#DEFINE 	COL_SALDO_ANT     	6
#DEFINE 	COL_SEPARA4			7
#DEFINE 	COL_VLR_DEBITO    	8
#DEFINE 	COL_SEPARA5			9
#DEFINE 	COL_VLR_CREDITO   	10
#DEFINE 	COL_SEPARA6			11
#DEFINE 	COL_MOVIMENTO 		12
#DEFINE 	COL_SEPARA7			13
#DEFINE 	COL_SALDO_ATU 		14
#DEFINE 	COL_SEPARA8			15


// 17/08/2009 -- Filial com mais de 2 caracteres

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr155	³ Autor ³ Simone Mie Sato   	³ Data ³ 11.05.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Conta/Cl.Valor                			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_Ctbr155()    											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ SIGACTB      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctbr155()

Local aSetOfBook
Local aCtbMoeda		:= {}
Local cSayClVl		:= CtbSayApro("CTH")
LOCAL cDesc1 		:= STR0001+ Upper(cSayClVl)	//"Este programa ira imprimir o Balancete de Conta / "
LOCAL cDesc2 		:= STR0002					  //"de acordo com os parametros solicitados pelo Usuario"

LOCAL wnrel
LOCAL cString		:= "CT1"
Local titulo 		:= STR0003+ Upper(cSayClVl)  	//"Balancete de Verificacao Conta / "
Local lRet			:= .T.
Local nDivide		:= 1

PRIVATE nLastKey 	:= 0
PRIVATE cPerg	 	:= "CTR155"
PRIVATE aReturn 	:= { STR0015, 1,STR0016, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE aLinha		:= {}
PRIVATE nomeProg  	:= "CTBR155"
PRIVATE Tamanho		:="M"

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

li 		:= 80
m_pag	:= 1

Pergunte("CTR155",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					  	   	³
//³ mv_par01				// Data Inicial              	       	³
//³ mv_par02				// Data Final                          	³
//³ mv_par03				// Conta Inicial                       	³
//³ mv_par04				// Conta Final  					   	³
//³ mv_par05				// Cl.Valor Inicial                    	³
//³ mv_par06				// Cl.Valor Final				   		³
//³ mv_par07				// Imprime Cl.Valor:Sintet/Analit/Ambas	³
//³ mv_par08				// Configuracao de Livros			  	³
//³ mv_par09				// Saldos Zerados?			     	   	³
//³ mv_par10				// Moeda?          			     	   	³
//³ mv_par11				// Pagina Inicial  		     		   	³
//³ mv_par12				// Saldos? Reais / Orcados	/Gerenciais	³
//³ mv_par13				// Imprimir ate o Segmento?			  	³
//³ mv_par14				// Filtra Segmento?					   	³
//³ mv_par15				// Conteudo Inicial Segmento?		   	³
//³ mv_par16				// Conteudo Final Segmento?		       	³
//³ mv_par17				// Conteudo Contido em?				   	³
//³ mv_par18				// Imprime Movimento do Mes            	³
//³ mv_par19				// Imprime Totalizacao de Contas Sontet.³
//³ mv_par20				// Pula Pagina                         	³

//³ mv_par21				// Salta linha sintetica ?			    ³
//³ mv_par22				// Imprime valor 0.00    ?			    ³
//³ mv_par23				// Imprimir Codigo? Normal / Reduzido  	³
//³ mv_par24				// Divide por ?                   		³
                                                                     
//³ mv_par25				// Imprime Cod. Conta ? Normal/Reduzido ³
//³ mv_par26				// Posicao Ant. L/P? Sim / Nao         	³
//³ mv_par27 				// Data Lucros/Perdas?                	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel	:= "CTBR155"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,,.F.,"",,Tamanho)

If nLastKey == 27
	Set Filter To
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par08)
	lRet := .F.
Else
   aSetOfBook := CTBSetOf(mv_par08)
Endif

If mv_par24 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par24 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par24 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par10)
	If Empty(aCtbMoeda[1])                       
      Help(" ",1,"NOMOEDA")
      lRet := .F.
   Endif
Endif

If !lRet
	Set Filter To
	Return
EndIf

If mv_par18 == 1			// Se imprime coluna movimento -> relatorio 220 colunas
	tamanho := "G"
EndIf

If nLastKey == 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| CTR155Imp(@lEnd,wnRel,cString,aSetOfBook,aCtbMoeda,cSayClVl,nDivide)})

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³CTR155IMP ³ Autor ³ Simone Mie Sato       ³ Data ³ 11.05.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio -> Balancete Conta/Cl.Valor              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ctr155Imp(lEnd,Wnrel,cString,aSetOfBook,aCtbMoeda,cSayClVl) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Sigactb                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd       - A‡ao do Codeblock                             ³±±
±±³          ³ wnRel      - Nome do Relatorio                             ³±±
±±³          ³ cString    - Mensagem                                      ³±±
±±³          ³ aSetOfBook - Array de configuracao set of book             ³±±
±±³          ³ aCtbMoeda  - Moeda                                         ³±±
±±³          ³ cSayClVl   - Descricao da cl.valor utilizada pelo usuario. ³±±
±±³          ³ nDivide    - Fator de divisao de valores                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CTR155Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda,cSayClVl,nDivide)

LOCAL CbTxt			:= Space(10)
Local CbCont		:= 0
LOCAL tamanho		:= "M"
LOCAL limite		:= 132
Local cabec1  		:= ""
Local cabec2		:= ""

Local aColunas

Local cSepara1		:= ""
Local cSepara2		:= ""
Local cPicture
Local cDescMoeda
Local cMascara1
Local cMascara2
Local cContaAnt 	:= ""
Local cCtaAntRes	:= ""
Local cSegAte   	:= mv_par13
Local cArqTmp		:= ""
Local cSegmento		:= mv_par14
Local cSegIni		:= mv_par15
Local cSegFim		:= mv_par16
Local cFiltSegm		:= mv_par17
Local cMascCta		:= ""
Local cMascClVl		:= ""

Local dDataLP		:= mv_par27
Local dDataFim		:= mv_par02

Local lFirstPage	:= .T.
Local lPula			:= Iif(mv_par21==1,.T.,.F.)
Local lJaPulou		:= .F.
Local l132			:= .T.
Local lImpAntLP		:= Iif(mv_par26==1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par09==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par22==1,.T.,.F.)
Local lClVlNormal	:= Iif(mv_par23==1,.T.,.F.)
Local lContaNormal	:= Iif(mv_par25==1,.T.,.F.)
Local lSaltaPag		:= Iif(mv_par20==1,.T.,.F.)
Local lImpMov		:= Iif(mv_par18==1,.T.,.F.)
Local lImpSint		:= Iif(mv_par07=1 .Or. mv_par07 ==3,.T.,.F.)

Local nDecimais
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nTotMov		:= 0

Local nTamCta		:= Len(CriaVar("CT1_CONTA"))
Local nTotCtDeb		:= 0
Local nTotCtCrd		:= 0

Local nDigitAte		:= 0

Local nPos			:= 0
Local nDigitos		:= 0
Local nCont			:= 0

cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)


// Mascara da Classe de Valor
If Empty(aSetOfBook[8])
	cMascara1 := ""
Else                                                
	cMascClVl := aSetOfBook[8]
	cMascara1 := RetMasCtb(aSetOfBook[8],@cSepara1)
EndIf

//Mascara da Conta
If Empty(aSetOfBook[2])
	cMascara2 := GetMv("MV_MASCARA")
Else
	cMascCta	:= aSetOfBook[2]
	cMascara2 	:= RetMasCtb(aSetOfBook[2],@cSepara2)
EndIf             


cPicture 		:= aSetOfBook[4]

If mv_par18 == 1 // Se imprime saldo movimento do periodo
	cabec1 := STR0004  //"|  CODIGO              |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |    DEBITO     |    CREDITO   | MOVIMENTO DO PERIODO |   SALDO ATUAL    |"
	tamanho := "G"
	limite	:= 220        
	l132	:= .F.
Else	
	cabec1 := STR0005  //"|  CODIGO               |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |      DEBITO    |      CREDITO   |   SALDO ATUAL     |"
Endif
SetDefault(aReturn,cString,,,Tamanho,If(Tamanho="G",2,1))	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par07 == 1
	Titulo:=	STR0006 + Upper(cSayClVl)	//"BALANCETE ANALITICO DE CONTA / "
ElseIf mv_par07 == 2
	Titulo:=	STR0007 + Upper(cSayClVl)	//"BALANCETE SINTETICO DE CONTA / "
ElseIf mv_par07 == 3
	Titulo:=	STR0008 + Upper(cSayClVl)	//"BALANCETE DE CONTA / "
EndIf

Titulo += 	STR0009 + DTOC(mv_par01) + STR0010 + Dtoc(mv_par02) + ;
				STR0011 + cDescMoeda

If mv_par12 > "1"
	Titulo += " (" + Tabela("SL", mv_par12, .F.) + ")"
EndIf

If nDivide > 1			
	Titulo += " (" + STR0022 + Alltrim(Str(nDivide)) + ")"
EndIf	

If l132
	aColunas := { 000,001, 024, 025, 057,058, 077, 078, 094, 095, 111, , , 112, 131 }
Else
	aColunas := { 000,001, 030, 032, 080,082, 112, 114, 131, 133, 151, 153, 183,185,219}
Endif

m_pag := mv_par11
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CTI","",mv_par03,mv_par04,,,,,mv_par05,mv_par06,mv_par10,;
				mv_par12,aSetOfBook,mv_par14,mv_par15,mv_par16,mv_par17, l132,.T.,,"CT1",;
				lImpAntLP,dDataLP, nDivide,lVlrZerado,,,,,,,,,,,,,lImpMov,lImpSint,aReturn[7])},;
				STR0014,;  //"Criando Arquivo Tempor rio..."
				STR0003+cSayClVl)     //"Balancete Verificacao Conta /"

// Verifica Se existe filtragem Ate o Segmento
/*If !Empty(cSegAte)
	For nCont := 1 to Val(cSegAte)
		nDigitAte += Val(Subs(cMascara1,nCont,1))	
	Next
EndIf		*/

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascara1) 	
EndIf		

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()        

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. !Empty(aSetOfBook[5])                                       
	dbCloseArea()
	Ferase(cArqTmp+GetDBExtension())
	Ferase("cArqInd"+OrdBagExt())
	Return
Endif

SetRegua(RecCount())

If !Empty(cSegmento)
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+cMascClVl)
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == cMascClVl
			nPos += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == cSegmento
				nPos -= Val(CTM->CTM_DIGITO)
				nPos ++
				nDigitos := Val(CTM->CTM_DIGITO)      
				Exit
			EndIf	
			dbSkip()
		EndDo	
	EndIf	
EndIf	

dbSelectArea("cArqTmp")

While !Eof()

	If lEnd
		@Prow()+1,0 PSAY STR0017   //"***** CANCELADO PELO OPERADOR *****"
		Exit
	EndIF

	IncRegua()

	******************** "FILTRAGEM" PARA IMPRESSAO *************************

	If mv_par07 == 1					// So imprime Cl.Valor Sinteticos
		If TIPOCLVL == "2"
			dbSkip()
			Loop
		EndIf
	ElseIf mv_par07 == 2				// So imprime Cl.Valor Analiticos
		If TIPOCLVL == "1"
			dbSkip()
			Loop
		EndIf
	EndIf
	
	If !Empty(cSegmento)
		If Empty(cSegIni) .And. Empty(cSegFim) .And. !Empty(cFiltSegm)
			If  !(Substr(cArqTmp->CLVL,nPos,nDigitos) $ (Alltrim(cFiltSegm)) ) 
				dbSkip()
				Loop
			EndIf	
		Else
			If Substr(cArqTmp->CLVL,nPos,nDigitos) < Alltrim(cSegIni) .Or. ;
				Substr(cArqTmp->CLVL,nPos,nDigitos) > Alltrim(cSegFim)
				dbSkip()
				Loop
			EndIf	
		Endif
	EndIf	
	
	//Filtragem ate o Segmento da Classe de Valor( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(CLVL)) > nDigitAte
			dbSkip()
			Loop
		Endif
	EndIf

	************************* ROTINA DE IMPRESSAO *************************
		
	cContaAnt	:= cArqTmp->CONTA
	cCtaAntRes 	:= cArqTmp->CTARES

	If li > 58 .Or. lFirstPage .Or. lSaltaPag
		If !lFirstPage
			@Prow()+1,00 PSAY	Replicate("-",limite)
		EndIf
		CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
		lFirstPage := .F.
	EndIf	
	
	@ li,000 PSAY REPLICATE("-",limite)
	li++
	@ li,000 PSAY "|"                                
	@ li,001 PSAY Upper(STR0021) + " : "
	If lContaNormal
		EntidadeCTB(CONTA,li,17,nTamCta+Len(cSepara2),.F.,cMascara2,cSepara2)					
	Else
		EntidadeCTB(CTARES,li,17,nTamCta+Len(cSepara2),.F.,cMascara2,cSepara2)		
	Endif			
	@ li,aColunas[COL_CLVL]+ Len(CriaVar("CT1_DESC01")) PSAY " - " +cArqTMP->DESCCTA
	@ li,131 PSAY "|"		                                        
	li++
	@ li,000 PSAY REPLICATE("-",limite)		
	li+=1		                                                    			
   
	While !Eof() .And. cContaAnt == cArqTmp->CONTA
	
		If mv_par07 == 1					// So imprime Itens Sinteticos
			If TIPOCLVL == "2"
				dbSkip()
				Loop
			EndIf
		ElseIf mv_par07 == 2				// So imprime Itens Analiticos
			If TIPOCLVL == "1"
				dbSkip()
				Loop
			EndIf
		EndIf	
		
		//Filtragem ate o Segmento da Classe de Valor( antigo nivel do SIGACON)		
		If !Empty(cSegAte)
			If Len(Alltrim(CLVL)) > nDigitAte
				dbSkip()
				Loop
			Endif
		EndIf		
		
		If !Empty(cSegmento)
			If Empty(cSegIni) .And. Empty(cSegFim) .And. !Empty(cFiltSegm)
				If  !(Substr(cArqTmp->CLVL,nPos,nDigitos) $ (Alltrim(cFiltSegm)) ) 
					dbSkip()
					Loop
				EndIf	
			Else
				If Substr(cArqTmp->CLVL,nPos,nDigitos) < Alltrim(cSegIni) .Or. ;
					Substr(cArqTmp->CLVL,nPos,nDigitos) > Alltrim(cSegFim)
					dbSkip()
					Loop
				EndIf	
			Endif
		EndIf			

		@ li,aColunas[COL_SEPARA1] PSAY "|"
		If lClVlNormal
			EntidadeCTB(CLVL,li,aColunas[COL_CLVL],20,.F.,cMascara1,cSepara1)
		Else	
			EntidadeCTB(CLVLRES,li,aColunas[COL_CLVL],20,.F.,cMascara1,cSepara1)
		EndIf	
		
		@ li,aColunas[COL_SEPARA2] PSAY "|"
		@ li,aColunas[COL_DESCRICAO] PSAY Substr(DESCCLVL,1,31)
		@ li,aColunas[COL_SEPARA3] PSAY "|"
		ValorCTB(SALDOANT,li,aColunas[COL_SALDO_ANT],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA4] PSAY "|"
		ValorCTB(SALDODEB,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA5] PSAY "|"
		ValorCTB(SALDOCRD,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA6] PSAY "|"
		If !l132
			ValorCTB(MOVIMENTO,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA7] PSAY "|"	
		Endif
		ValorCTB(SALDOATU,li,aColunas[COL_SALDO_ATU],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA8] PSAY "|"
		
		lJaPulou := .F.
		If lPula .And. TIPOCLVL == "1"				// Pula linha entre sinteticas
			li++
			@ li,aColunas[COL_SEPARA1] PSAY "|"
			@ li,aColunas[COL_SEPARA2] PSAY "|"
			@ li,aColunas[COL_SEPARA3] PSAY "|"	
			@ li,aColunas[COL_SEPARA4] PSAY "|"
			@ li,aColunas[COL_SEPARA5] PSAY "|"
			@ li,aColunas[COL_SEPARA6] PSAY "|"
			If !l132  
				@ li,aColunas[COL_SEPARA7] PSAY "|"
				@ li,aColunas[COL_SEPARA8] PSAY "|"
			Else
				@ li,aColunas[COL_SEPARA8] PSAY "|"
			EndIf	
			li++
			lJaPulou := .T.
		Else
			li++
		EndIf			

		// Soma dos totalizadores
		If mv_par07 != 1					// Imprime Analiticas ou Ambas
			If TIPOCLVL == "2"
				If TIPOCONTA== "2"
					nTotDeb 		+= SALDODEB 
					nTotCrd    		+= SALDOCRD
				EndIf	
				nTotCtDeb 		+= SALDODEB
				nTotCtCrd 		+= SALDOCRD				
			Endif
		Else
			If TIPOCLVL	== "1" .And. NIVEL1
				nTotDeb += SALDODEB
				nTotCrd += SALDOCRD
			Endif
			If TIPOCLVL == "1" .And. Empty(ITSUP)
				nTotCtDeb += SALDODEB
				nTotCtCrd += SALDOCRD				
			Endif
		Endif	
		
		dbSkip()  
		
		If lPula .And. TIPOCLVL == "1" 			// Pula linha entre sinteticas
			If !lJaPulou
				@ li,aColunas[COL_SEPARA1] PSAY "|"
				@ li,aColunas[COL_SEPARA2] PSAY "|"
				@ li,aColunas[COL_SEPARA3] PSAY "|"	
				@ li,aColunas[COL_SEPARA4] PSAY "|"
				@ li,aColunas[COL_SEPARA5] PSAY "|"
				@ li,aColunas[COL_SEPARA6] PSAY "|"
				If !l132  
					@ li,aColunas[COL_SEPARA7] PSAY "|"
					@ li,aColunas[COL_SEPARA8] PSAY "|"
				Else
					@ li,aColunas[COL_SEPARA8] PSAY "|"
				EndIf	
				li++
			EndIf	
		EndIf
		
		If li > 58 
			If !lFirstPage
				@Prow()+1,00 PSAY	Replicate("-",limite)
			EndIf		
			CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
			lFirstPage := .F.
		EndIf	
		
    EndDo
    
	// Impressao do Totalizador da Conta
	@li,00 PSAY	Replicate("-",limite)
	li++
	@li,0 PSAY "|"          			
	@li,01 PSAY STR0020//"T O T A I S  D A  C O N T A:  "
	If lContaNormal				// Codigo Normal da Conta
		EntidadeCTB(cContaAnt,li,40,nTamCta+Len(cSepara2),.F.,cMascara2,cSepara2)		
	Else
		EntidadeCTB(cCtaAntRes,li,40,nTamCta+Len(cSepara2),.F.,cMascara2,cSepara2)
	EndIf
	@ li,aColunas[COL_SEPARA4] PSAY "|"
	ValorCTB(nTotCtDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA5] PSAY "|"
	ValorCTB(nTotCtCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)			
	@ li,aColunas[COL_SEPARA6] PSAY "|"
	If !l132
		nTotMov := (nTotCtCrd - nTotCtDeb)
		If Round(NoRound(nTotMov,3),2) < 0
			ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero)
		ElseIf Round(NoRound(nTotMov,3),2) > 0
			ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero)
	    EndIf
		@ li,aColunas[COL_SEPARA7] PSAY "|"	
	Endif
	@ li,aColunas[COL_SEPARA8] PSAY "|"
	nTotCtDeb := 0
	nTotCtCrd := 0                     
	li++
	
	If li > 58  	
		If !lFirstPage
			@Prow()+1,00 PSAY	Replicate("-",limite)
		EndIf
		CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
		lFirstPage := .F.
	EndIf	
	
EndDO

IF li != 80 .And. !lEnd
	li++
	@li,00 PSAY REPLICATE("-",limite)
	li++
	@li,0 PSAY "|"          			
	@li, 10 PSAY OemToAnsi(STR0018)  		//"T O T A I S  D O  P E R I O D O : "
	@ li,aColunas[COL_SEPARA4] PSAY "|"	
	ValorCTB(nTotDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA5] PSAY "|"
	ValorCTB(nTotCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA6] PSAY "|"
	@ li,aColunas[COL_SEPARA8] PSAY "|"
	li++
	@li,00 PSAY REPLICATE("-",limite)
	li++
	@li,0 PSAY " "
	If !lExterno
		roda(cbcont,cbtxt,"M")
		Set Filter To
	EndIf		
EndIF

If aReturn[5] = 1
	Set Printer To
	Commit
	Ourspool(wnrel)
EndIf

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
Ferase(cArqTmp+GetDBExtension())
FErase("cArqInd"+OrdBagExt())

dbselectArea("CT2")

MS_FLUSH()

