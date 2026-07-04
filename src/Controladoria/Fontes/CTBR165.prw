/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR165.CH"
#Include "PROTHEUS.Ch"

#DEFINE 	COL_SEPARA1			1
#DEFINE 	COL_CONTA  			2
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
Static lAutomato := IsBlind()



// 17/08/2009 -- Filial com mais de 2 caracteres

//Tradução PTG

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr165	³ Autor ³ Simone Mie Sato   	³ Data ³ 20.05.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Balancete CC ou Item ou Classe de Valor / Entidade Gerencial³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_Ctbr165()    											  ³±±
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
User Function Ctbr165()

Local aSetOfBook
Local aCtbMoeda		:= {}
Local cSayCusto		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")
LOCAL cDesc1 			:= STR0001 +  "(" +cSayCusto + "/" +cSayItem+ "/" +cSayClVl+ ")"//"Este programa ira imprimir o Balancete de 1 Entidade    
LOCAL cDesc2 			:= +" / "+STR0021 + STR0002  //"por Entidade Gerencial " "de acordo com os parametros solicitados pelo Usuario"
Local cNomeArq
LOCAL wnrel
LOCAL cString			:= "CT1"
Local titulo 			:= STR0003 + " / "+ STR0021 	//"Balancete de Verificacao Conta / "
Local lRet				:= .T.
Local nDivide			:= 1
Local aPergs 			:= {}
Local cMensagem		:= ""

PRIVATE nLastKey 	:= 0
PRIVATE cPerg	 		:= "CTR165"
PRIVATE aReturn 	:= { STR0015, 1,STR0016, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE aLinha		:= {}
PRIVATE nomeProg  := "CTBR165"
PRIVATE Tamanho		:="M"

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

li 		:= 80
m_pag	:= 1


Pergunte("CTR165",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					  	   	³
//³ mv_par01				// Data Inicial              	       	³
//³ mv_par02				// Data Final                          	³
//³ mv_par03				// Configuracao de Livros			   	³
//³ mv_par04				// Imprime C.Custo/Item/Cl.Valor	   	³
//³ mv_par05				// Da Entidade                         	³
//³ mv_par06				// Ate a Entidade					   	³
//³ mv_par07				// Da Entidade Gerencial               	³
//³ mv_par08				// Ate a Entidade Gerencial			   	³
//³ mv_par09				// Imp.Ent.Gerenc: Sintet/Analit/Ambas	³
//³ mv_par10 				// Saldos Zerados?			     	   	³
//³ mv_par11				// Moeda?          			     	   	³
//³ mv_par12				// Pagina Inicial  		     		   	³
//³ mv_par13				// Imprimir ate o Segmento?			  	³
//³ mv_par14				// Filtra Segmento?					   	³
//³ mv_par15				// Conteudo Inicial Segmento?		   	³
//³ mv_par16				// Conteudo Final Segmento?		       	³
//³ mv_par17				// Conteudo Contido em?				   	³
//³ mv_par18				// Imprime Movimento do Mes            	³
//³ mv_par19				// Pula Pagina                         	³
//³ mv_par20				// Salta linha sintetica ?			    ³
//³ mv_par21				// Imprime valor 0.00    ?			    ³
//³ mv_par22				// Imprimir Codigo? Normal / Reduzido  	³
//³ mv_par23				// Divide por ?                   		³                                                                     
//³ mv_par24 				// Posicao Ant. L/P? Sim / Nao         	³
//³ mv_par25 				// Data Lucros/Perdas?                	³
//³ mv_par26				// Rec./Desp. Anterior Zeradas?			³		
//³ mv_par27				// Grupo Receitas/Despesas?      		³		
//³ mv_par28				// Data de Zeramento Receita/Despesas?	³		
//³ mv_par29				// Filtra Centro de Custo?            	³		
//³ mv_par30				// Do Centro de Custo?                	³		
//³ mv_par31				// Ate o Centro de Custo?             	³		
//³ mv_par32				// Filtra Item?                       	³		
//³ mv_par33				// Do Item?                           	³		
//³ mv_par34				// Ate o Item?                        	³		
//³ mv_par35				// Filtra Classe de Valor?            	³		
//³ mv_par36				// Do Item?                           	³		
//³ mv_par37				// Ate o Item?                        	³		
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel	:= "CTBR165"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,,.F.,"",,Tamanho)

If nLastKey == 27
	Set Filter To
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par03)
	lRet 		:= .F.
Else
   aSetOfBook := CTBSetOf(mv_par03)
Endif

If mv_par23 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par23 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par23 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par11)
	If Empty(aCtbMoeda[1])                       
      Help(" ",1,"NOMOEDA")
      lRet := .F.
   Endif
Endif

If lRet
	If Empty(mv_par03) 
		cMensagem	:= STR0025	//"Favor preencher a configuracao de livros. Por se tratar de um relatorio de "
		cMensagem	+= STR0026	//"entidades gerenciais, essa pergunta é obrigatória."
		MsgAlert(cMensagem)	
		lRet	:= .F.	
    EndIf
EndIf

If lRet
	If (mv_par26 == 1) .and. ( Empty(mv_par27) .or. Empty(mv_par28) )
		cMensagem	:= STR0027	//"Favor preencher os parametros Grupos Receitas/Despesas e Data Sld Ant. Receitas/Despesas ou "
		cMensagem	+= STR0028	//"deixar o parametro Ignora Sl Ant.Rec/Des = Nao "
		MsgAlert(cMensagem,"Ignora Sl Ant.Rec/Des")	
		lRet    	:= .F.	
    EndIf
EndIf

If !lRet
	Set Filter To
	Return
EndIf

If mv_par18 == 1			// Se imprime coluna movimento -> relatorio 220 colunas
	tamanho := "G"
EndIf

SetDefault(aReturn,cString,,,Tamanho,If(Tamanho="G",2,1))	

If nLastKey == 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| CTR165Imp(@lEnd,wnRel,cString,aSetOfBook,aCtbMoeda,cSayCusto,cSayItem,cSayClVl,nDivide)})

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³CTR165IMP ³ Autor ³ Simone Mie Sato       ³ Data ³ 23.05.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio -> Balancete Entidade/Entidade Gerencial ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CTR165Imp(lEnd,Wnrel,cString,aSetOfBook,aCtbMoeda,cSayCusto,³±±
±±³          ³          cSayItem,cSayClvl,nDivide)                        ³±±
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
±±³          ³ cSayCusto  - Descricao do c.custo utilizado pelo usuario.  ³±±
±±³          ³ cSayItem   - Descricao do item utilizado pelo usuario.     ³±±
±±³          ³ cSayClVl   - Descricao da cl.valor utilizada pelo usuario. ³±±
±±³          ³ nDivide    - Fator de divisao de valores                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CTR165Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda,cSayCusto,cSayItem,cSayClVl,nDivide)

LOCAL CbTxt				:= Space(10)
Local CbCont			:= 0
LOCAL tamanho			:= "M"
LOCAL limite			:= 132
Local cabec1  		:= ""
Local cabec2			:= ""

Local aColunas

Local cSepara1		:= ""
Local cSepara2		:= ""
Local cPicture		
Local cDescMoeda	
Local cCodMasc		:= aSetOfBook[1]
Local cMascara1
Local cMascara2
Local cEntidAnt 	:= ""
Local cEntAntRes	:= ""	
Local cSegAte   	:= mv_par13
Local cSegmento		:= mv_par14
Local cSegIni			:= mv_par15
Local cSegFim			:= mv_par16
Local cFiltSegm		:= mv_par17
Local cArqTmp			:= ""
Local cAlias			:= ""
Local cDesc				:= ""
Local cDescEnt		:= ""
Local cHeader			:= ""
Local cContaIni		:= mv_par07 	//Considerar o codigo da entidade gerencial inicial
Local cContaFim		:= mv_par08 	//Considerar o codigo da entidade gerencial final
Local cCustoIni		:= ""
Local cCustoFim		:=  Repl("Z",Len(CriaVar("CTT_CUSTO")))
Local cItemIni		:= ""
Local cItemFim		:=  Repl("Z",Len(CriaVar("CTD_ITEM")))
Local cClVlIni		:= ""
Local cClVlFim		:=  Repl("Z",Len(CriaVar("CTH_CLVL")))
Local cCodigo			:= ""
Local cCodRes			:= ""
Local cTipo       := ""
Local cTipoAnt    := ""

Local dDataLP			:= mv_par25
Local dDataFim		:= mv_par02

Local lFirstPage	:= .T.
Local lPula				:= Iif(mv_par20==1,.T.,.F.)
Local lPulaPag		:= Iif(mv_par19==1,.T.,.F.)
Local lJaPulou		:= .F.
Local l132				:= .T.
Local lImpAntLP		:= Iif(mv_par24==1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par10==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par21==1,.T.,.F.)
Local lEntNormal	:= Iif(mv_par22==1,.T.,.F.)
Local lFiltraCC		:= Iif(mv_par29==1,.T.,.F.)
Local lFiltraIt		:= Iif(mv_par32==1,.T.,.F.)
Local lFiltraCV		:= Iif(mv_par35==1,.T.,.F.)

Local nDecimais
Local nTotDeb			:= 0
Local nTotCrd			:= 0
Local nTotMov			:= 0
Local nTamEnt			:= 0
Local nTotEntDeb	:= 0
Local nTotEntCrd	:= 0
Local nPosAte			:= 0
Local nDigitAte		:= 0
Local nPos				:= 0
Local nDigitos		:= 0 

Local lRecDesp0		:= Iif(mv_par26==1,.T.,.F.)
Local cRecDesp		:= mv_par27
Local dDtZeraRD		:= mv_par28

cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par11)

If mv_par04 == 1		//Balancete C.Custo / Entidade Gerencial
	cAlias 			:= "CT3"     
	cHeader			:= "CTT"
	cCustoIni		:= mv_par05
	cCustoFim		:= mv_par06
	If lFiltraIt
		cItemIni	:= mv_par33
		cItemFim	:= mv_par34
	Endif
	
	If lFiltraCV	
		cClVlIni	:= mv_par36
		cClVlFim	:= mv_par37
	EndIf	

ElseIf mv_par04 == 2	//Balancete Item / Entidade Gerencial
	cAlias			:= "CT4"
	cHeader			:= "CTD"
	cItemIni		:= mv_par05
	cItemFim		:= mv_par06
	If lFiltraCC
		cCustoIni	:= mv_par30
		cCustoFim	:= mv_par31
	EndIf

	If lFiltraCV
		cClVlIni	:= mv_par36
		cClVlFim	:= mv_par37
	EndIf
				
ElseIf mv_par04 == 3	//Balancete Cl.Valor / Entidade Gerencial
	cAlias			:= "CTI"
	cHeader			:= "CTH"   
	cClVlIni		:= mv_par05
	cClVlFim		:= mv_par06
	If lFiltraCC
		cCustoIni	:= mv_par30
		cCustoFim	:= mv_par31
	EndIf
	
	If lFiltraIt
		cItemIni	:= mv_par33
		cItemFim	:= mv_par34
	EndIf
EndIf

//Mascara da Conta
If Empty(aSetOfBook[2])
	cMascara1 := GetMv("MV_MASCARA")
Else
	cMascara1 	:= RetMasCtb(aSetOfBook[2],@cSepara1)
EndIf             
         
If cHeader == "CTT"
	// Mascara do C.Custo
	If Empty(aSetOfBook[6])
		cMascara2 := ""
	Else
		cMascara2 := RetMasCtb(aSetOfBook[7],@cSepara2)
	EndIf
	cDescEnt	:= cSayCusto
	cCodigo		:= "CUSTO"
	cCodRes		:= "CCRES"	
	cDesc			:= "DESCCC"	
	cTipo     := "TIPOCC"
ElseIf cHeader == "CTD"
	// Mascara do Item Contabil
	If Empty(aSetOfBook[7])
		cMascara2 := ""
	Else
		cMascara2 := RetMasCtb(aSetOfBook[7],@cSepara2)
	EndIf
	cDescEnt	:= cSayItem
	cCodigo		:= "ITEM"
	cCodRes		:= "ITEMRES"		
	cDesc			:= "DESCITEM"
	cTipo     := "TIPOITEM"
ElseIf cHeader == "CTH"
	// Mascara da Classe de Valor
	If Empty(aSetOfBook[8])
		cMascara2 := ""
	Else
		cMascara2 := RetMasCtb(aSetOfBook[7],@cSepara2)
	EndIf
	cDescEnt	:= cSayClvl
	cCodigo		:= "CLVL"
	cCodRes		:= "CLVLRES"		
	cDesc			:= "DESCCLVL"	
	cTipo     := "TIPOCLVL"
Endif

cPicture 		:= aSetOfBook[4]

If mv_par18 == 1 // Se imprime saldo movimento do periodo
	cabec1 	:=  Iif (cPaisLoc<>"MEX",STR0004,STR0023)  //"|  CODIGO              |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |    DEBITO     |    CREDITO   | MOVIMENTO DO PERIODO |   SALDO ATUAL    |"
	tamanho := "G"
	limite	:= 220        
	l132		:= .F.
Else	
	cabec1 :=  Iif (cPaisLoc<>"MEX",STR0005,STR0024)  //"|  CODIGO               |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |      DEBITO    |      CREDITO   |   SALDO ATUAL     |"
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par09 == 1
	Titulo := STR0006 + Upper(cDescEnt)+ " / " + Upper(STR0021)	//"BALANCETE ANALITICO DE  / ENTIDADE GERENCIAL"
ElseIf mv_par09 == 2
	Titulo :=	STR0007 + Upper(cDescEnt)+ " / "+ Upper(STR0021)	//"BALANCETE SINTETICO DE  / ENTIDADE GERENCIAL"
ElseIf mv_par09 == 3
	Titulo :=	STR0008 + Upper(cDescEnt)+ " / "+ Upper(STR0021)	//"BALANCETE DE  / ENTIDADE GERENCIAL"
EndIf

Titulo += 	STR0009 + DTOC(mv_par01) + STR0010 + Dtoc(mv_par02) + ;
				STR0011 + cDescMoeda

If nDivide > 1			
	Titulo += " (" + STR0022 + Alltrim(Str(nDivide)) + ")"
EndIf	

If l132
	aColunas := { 000,001, 024, 025, 057,058, 077, 078, 094, 095, 111, , , 112, 131 }
	nTamEnt  := 35
Else
	aColunas := { 000,001, 030, 032, 080,082, 112, 114, 131, 133, 151, 153, 183,185,219}
	nTamEnt  := 40
Endif
      
m_pag := mv_par12

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if !lAutomato
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
					CtGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
					mv_par01,mv_par02,cAlias,"",cContaIni,cContaFim,cCustoIni,cCustoFim,cItemIni,cItemFim,cClVlIni,cClVlFim,mv_par11,;
					MV_PAR38,aSetOfBook,mv_par14,mv_par15,mv_par16,mv_par17, l132,.T.,,cHeader,;
					lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,,aReturn[7],lRecDesp0,;
					cRecDesp,dDtZeraRD,,.F.,.T.,lFiltraCC,lFiltraIt,lFiltraCV)},;
					STR0014,;  //"Criando Arquivo Tempor rio..."
					STR0003+" / "+STR0021)     //""Balancete de Verificacao de 1 Entidade " "Entidade Gerencial "
Else
					CtGerPlan(,,,,@cArqTmp,;
					mv_par01,mv_par02,cAlias,"",cContaIni,cContaFim,cCustoIni,cCustoFim,cItemIni,cItemFim,cClVlIni,cClVlFim,mv_par11,;
					MV_PAR38,aSetOfBook,mv_par14,mv_par15,mv_par16,mv_par17, l132,.T.,,cHeader,;
					lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,,aReturn[7],lRecDesp0,;
					cRecDesp,dDtZeraRD,,.F.,.T.,lFiltraCC,lFiltraIt,lFiltraCV)
Endif

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascara1) 	
EndIf		

If !Empty(cSegmento)
	If Len(aSetOfBook) == 0 .or. Empty(aSetOfBook[1])
		Help("CTN_CODIGO")
		Return
	Endif
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+cCodMasc)
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == cCodMasc
			nPos += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == strzero(val(cSegmento),2)
				nPos -= Val(CTM->CTM_DIGITO)
				nPos ++
				nDigitos := Val(CTM->CTM_DIGITO)      
				Exit
			EndIf	
			dbSkip()
		EndDo	
	Else
		Help("CTM_CODIGO")
		Return
	EndIf		
EndIf	

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()        
                                           
//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. !Empty(aSetOfBook[5])                                       
	dbCloseArea()
//	FErase(cArqTmp+GetDBExtension())
//	FErase("cArqInd"+OrdBagExt())
	Return
Endif

SetRegua(RecCount())

While !Eof()

	If lEnd
		@Prow()+1,0 PSAY STR0017   //"***** CANCELADO PELO OPERADOR *****"
		Exit
	EndIF

	IncRegua()

	******************** "FILTRAGEM" PARA IMPRESSAO *************************
	
	If mv_par09 == 1					// So imprime Sinteticas
		If TIPOCONTA == "2"
			dbSkip()
			Loop
		EndIf
	ElseIf mv_par09 == 2				// So imprime Analiticas
		If TIPOCONTA == "1"
			dbSkip()
			Loop
		EndIf
	EndIf

	//Filtragem ate o Segmento da Conta( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(CONTA)) > nDigitAte
			dbSkip()
			Loop
		Endif
	EndIf

	If !Empty(cSegmento)	
		If Empty(cSegIni) .And. Empty(cSegFim) .And. !Empty(cFiltSegm)
			If  !(Substr(CONTA,nPos,nDigitos) $ (cFiltSegm) ) 
				dbSkip()
				Loop
			EndIf	
		Else
			If Substr(CONTA,nPos,nDigitos) < Alltrim(cSegIni) .Or. ;
				Substr(CONTA,nPos,nDigitos) > Alltrim(cSegFim)
				dbSkip()
				Loop
			EndIf	
		Endif	
	EndIf		

	************************* ROTINA DE IMPRESSAO *************************
		
	If cHeader == "CTT"
		cEntidAnt 	:= cArqTmp->CUSTO	
		cEntAntRes 	:= cArqTmp->CCRES		
		cTipoAnt    := cArqTmp->TIPOCC
	ElseIf cHeader == "CTD"
		cEntidAnt 	:= cArqTmp->ITEM		
		cEntAntRes 	:= cArqTmp->ITEMRES		
		cTipoAnt    := cArqTmp->TIPOITEM
	ElseIf cHeader == "CTH"
		cEntidAnt 	:= cArqTmp->CLVL		
		cEntAntRes 	:= cArqTmp->CLVLRES	
		cTipoAnt    := cArqTmp->TIPOCLVL			
	EndIf		

	If li > 58 .Or. lFirstPage .Or. lPulaPag
		If !lFirstPage
			@Prow()+1,00 PSAY	Replicate("-",limite)
		EndIf
		CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
		lFirstPage := .F.
	EndIf	
	
	@ li,000 PSAY REPLICATE("-",limite)
	li++
	@ li,000 PSAY "|"                                
	@ li,001 PSAY Upper(cDescEnt) + " : "
	If lEntNormal .or. &(cTipo) == "1"
		EntidadeCTB(&(cCodigo),li,17,nTamEnt +Len(cSepara2),.F.,cMascara2,cSepara2)					
	Else
		EntidadeCTB(&(cCodRes),li,17,nTamEnt +Len(cSepara2),.F.,cMascara2,cSepara2)		
	Endif                        
	
	If l132
		@ li,aColunas[COL_SEPARA4] PSAY " - " +&(cDesc)
	Else			
		@ li,aColunas[COL_SEPARA3] PSAY " - " +&(cDesc)
	EndIf
	
	@ li,aColunas[COL_SEPARA8] PSAY "|"		                                        
	li++
	@ li,000 PSAY REPLICATE("-",limite)		
	li+=1		                                                    			
   
	While !Eof() .And. cEntidAnt == &(cArqtmp->(cCodigo))
	
		If mv_par09 == 1					// So imprime Sinteticas
			If TIPOCONTA == "2"
				dbSkip()
				Loop
			EndIf
		ElseIf mv_par09 == 2				// So imprime Analiticas
			If TIPOCONTA == "1"
				dbSkip()
				Loop
			EndIf
		EndIf

		//Filtragem ate o Segmento da Conta( antigo nivel do SIGACON)		
		If !Empty(cSegAte)
			If Len(Alltrim(CONTA)) > nDigitAte
				dbSkip()
				Loop
			Endif
		EndIf	

		@ li,aColunas[COL_SEPARA1] PSAY "|"
		If l132
			EntidadeCTB(CONTA,li,aColunas[COL_CONTA],23,.F.,cMascara1,cSepara1)
		Else
			EntidadeCTB(CONTA,li,aColunas[COL_CONTA],29,.F.,cMascara1,cSepara1)
		EndIf
		
		@ li,aColunas[COL_SEPARA2] PSAY "|"
		@ li,aColunas[COL_DESCRICAO] PSAY Substr(DESCCTA,1,31)
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
		If lPula .And. TIPOCONTA == "1"				// Pula linha entre sinteticas
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
		
		If mv_par09 == 1					// So imprime Sinteticas - Soma Sinteticas
			If TIPOCONTA == "1"
				If NIVEL1
					nTotDeb += SALDODEB
					nTotCrd += SALDOCRD
					nTotEntDeb += SALDODEB
					nTotEntCrd += SALDOCRD
				EndIf
			EndIf
		Else									// Soma Analiticas
			If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
				If TIPOCONTA == "2"
					nTotDeb += SALDODEB
					nTotCrd += SALDOCRD
					nTotEntDeb += SALDODEB
					ntotEntCrd += SALDOCRD
				EndIf
			Else							//Se tiver filtragem, somo somente as sinteticas
				If TIPOCONTA == "1"
					If NIVEL1
						nTotDeb += SALDODEB
						nTotCrd += SALDOCRD
						nTotEntDeb += SALDODEB
						nTotEntCrd += SALDOCRD
					EndIf
				EndIf	
	    	Endif			
		EndIf
				
		dbSkip()  
		
		If lPula .And. TIPOCONTA == "1" 			// Pula linha entre sinteticas
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
    
	// Impressao do Totalizador da Entidade
	@li,00 PSAY	Replicate("-",limite)
	li++
	@li,0 PSAY "|"          			
	@li,01 PSAY STR0020 + Upper(cDescEnt) + ":"//"TOTAIS DO "

	If lEntNormal .or. cTipoAnt == "1"				// Codigo Normal da Entidade ou é sintetica
		EntidadeCTB(cEntidAnt,li,30,nTamEnt+Len(cSepara2),.F.,cMascara2,cSepara2)		
	Else               	
		EntidadeCTB(cEntAntRes,li,30,nTamEnt+Len(cSepara2),.F.,cMascara2,cSepara2)
	EndIf
	@ li,aColunas[COL_SEPARA4] PSAY "|"
	ValorCTB(nTotEntDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA5] PSAY "|"
	ValorCTB(nTotEntCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)			
	@ li,aColunas[COL_SEPARA6] PSAY "|"
	If !l132
		nTotMov := (nTotEntCrd - nTotEntDeb)
		If Round(NoRound(nTotMov,3),2) < 0
			ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero)
		ElseIf Round(NoRound(nTotMov,3),2) > 0
			ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero)
	    EndIf
		@ li,aColunas[COL_SEPARA7] PSAY "|"	
	Endif
	@ li,aColunas[COL_SEPARA8] PSAY "|"
	nTotEntDeb := 0
	nTotEntCrd := 0                     
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
//	li++
	@li,00 PSAY REPLICATE("-",limite)
	li++
	@li,0 PSAY "|"          			
	@li, 10 PSAY STR0018  		//"T O T A I S  D O  P E R I O D O : "
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

MS_FLUSH()

Return

