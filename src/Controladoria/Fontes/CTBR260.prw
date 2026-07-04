/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR260.Ch"
#Include "PROTHEUS.Ch"

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

// 17/08/2009 -- Filial com mais de 2 caracteres

//Tradução PTG

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr260	³ Autor ³ Simone Mie Sato   	³ Data ³ 02.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Comparativo de Saldos de Contas 6 meses    	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr260()                               			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctbr260()                

Private Titulo		:= "" 
Private NomeProg	:= "CTBR260"
Private aSelFil    := {}
 
U_CTBR260R4()

//Limpa os arquivos temporários 
CTBGerClean()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR260R4 ³ Autor³ Daniel Sakavicius		³ Data ³ 31/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Comparativo de Saldos de Contas 6 meses - R4  	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR260R4												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR260R4() 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()      

If !Empty( oReport:uParam )
	Pergunte( oReport:uParam, .F. )
EndIf	

oReport :PrintDialog()      

Return                                

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Daniel Sakavicius		³ Data ³ 31/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Esta funcao tem como objetivo definir as secoes, celulas,   ³±±
±±³          ³totalizadores do relatorio que poderao ser configurados     ³±±
±±³          ³pelo relatorio.                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef() 
local aArea	   		:= GetArea()   
Local cREPORT		:= "CTBR260"
Local cSayItem		:= CtbSayApro("CTD")
Local cTITULO		:= OemToAnsi(STR0003)//"Comparativo  de Contas Contabeis ate 6 meses"
Local cDESC			:= OemToAnsi(STR0001)+OemtoAnsi(STR0002)	//"Este programa ira imprimir o Comparativo de Contas Contabeis de 2 ate "
																//" 6 meses.  Os valores sao ref. a movimentacao do periodo solicitado. "
Local cPerg	   		:= "CTR260"			       
Local aTamConta		:= TAMSX3("CT1_CONTA")    
Local aTamVal		:= TAMSX3("CT2_VALOR")
Local aTamDesc		:= {30}  

// Ajuste no tamanho das colunas de conta e valores para evitar a sobreposição de informações 
aTamConta[1] += 6 
aTamVal[1] += 4

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport	:= TReport():New( cReport,cTITULO,cPERG, { |oReport| ReportPrint( oReport ) }, cDESC )
oReport:SetLandScape(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1  := TRSection():New( oReport, STR0029, {"cArqTmp","CT1"},, .F., .F.,,,,,,,,,, /*AutoSize */ .T.)	//	"Conta Contábil"
TRCell():New( oSection1, "CONTA"   , ,Substr(STR0004,002,10) /*Titulo*/,/*Picture*/,aTamConta[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/) 
TRCell():New( oSection1, "DESCCTA" , ,Substr(STR0004,032,30) /*Titulo*/,/*Picture*/,aTamDesc[1] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection1, "COLUNA1" , ,                       /*Titulo*/,/*Picture*/,aTamVal[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection1, "COLUNA2" , ,                       /*Titulo*/,/*Picture*/,aTamVal[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection1, "COLUNA3" , ,                       /*Titulo*/,/*Picture*/,aTamVal[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection1, "COLUNA4" , ,                       /*Titulo*/,/*Picture*/,aTamVal[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection1, "COLUNA5" , ,                       /*Titulo*/,/*Picture*/,aTamVal[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection1, "COLUNA6" , ,                       /*Titulo*/,/*Picture*/,aTamVal[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection1, "COLUNAT" , ,Substr(STR0028,006,015)/*Titulo*/,/*Picture*/,aTamVal[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")

oSection1:SetTotalInLine(.F.)
oSection1:SetTotalText(STR0011) //	"T O T A I S  D O  P E R I O D O: "

Return(oReport)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Daniel Sakavicius	³ Data ³ 28/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime o relatorio definido pelo usuario de acordo com as  ³±±
±±³          ³secoes/celulas criadas na funcao ReportDef definida acima.  ³±±
±±³          ³Nesta funcao deve ser criada a query das secoes se SQL ou   ³±±
±±³          ³definido o relacionamento e filtros das tabelas em CodeBase.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportPrint(oReport)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³EXPO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )  

Local oSection1 	:= oReport:Section(1)    

Local oTotCol1, oTotCol2, oTotCol3, oTotCol4, oTotCol5, oTotCol6, oTotColTot
Local oTotGrp1,	oTotGrp2, oTotGrp3, oTotGrp4, oTotGrp5, oTotGrp6, oTotGrpTot, oBreakGrp

Local aCtbMoeda		:= {}
Local cSeparador	:= ""
Local cPicture
Local cDescMoeda            
Local cTipoAnt      := ""
Local cString		:= "CT1"
Local lRet			:= .T.
Local cGrupo		:= ""
Local cArqTmp
Local dDataFim 		:= mv_par02
Local lFirstPage	:= .T.
Local lJaPulou		:= .F.
Local lPrintZero	:= Iif(mv_par17==1,.T.,.F.)
Local lPula			:= Iif(mv_par16==1,.T.,.F.) 
Local lNormal		:= Iif(mv_par18==1,.T.,.F.)
Local lQbGrupo		:= Iif(mv_par11==1 .and. Empty(mv_par06),.T.,.F.) // Não imprime grupo quando se utiliza livro
Local nDecimais
Local nDivide		:= 1
Local cCodMasc		:= ""
Local cSegmento		:= mv_par12
Local cSegAte   	:= mv_par20
Local cSegIni		:= mv_par13
Local cSegFim		:= mv_par14
Local cFiltSegm		:= mv_par15
Local nDigitAte		:= 0
Local lImpAntLP		:= Iif(mv_par21 == 1,.T.,.F.)
Local dDataLP		:= mv_par22
Local aMeses		:= {}          
Local aPeriodos
Local nMeses		:= 1
Local nCont			:= 0
Local nDigitos		:= 0
Local nVezes		:= 0
Local nPos			:= 0
Local lVlrZerado	:= Iif(mv_par07 == 1,.T.,.F.)
Local lImpSint		:= Iif(mv_par05 = 2,.F.,.T.)
Local lSinalMov		:= .T.
Local cHeader 		:= ""
Local cTpComp		:= If( mv_par23 == 1,"M","S" )	//	Comparativo : "M"ovimento ou "S"aldo Acumulado
Local cFilter		:= ""
Local nTotGer 		:= 0
Local aTamVal		:= TAMSX3("CT2_VALOR")
Local cFilUser		:= ""
Local cMensagem     := ""
Local cEspaco
Local bCond
                                                                         
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par06)
	lRet := .F. 
	return lRet
Else
   aSetOfBook := CTBSetOf(mv_par06)
Endif

If lImpAntLP .And. Empty(dDataLP)
	cMensagem	:= STR0030 //"Posição Ant. LP = Sim "
	cMensagem	+= STR0031	//"Informe a data de Apuração de Resultados "
	MsgAlert(cMensagem,STR0032)	//"Considera Apuração de Resultados " 
	lRet := .F. 
	Return lRet
EndIf

If mv_par19 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par19 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par19 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par08,nDivide)
	If Empty(aCtbMoeda[1])                       
    	Help(" ",1,"NOMOEDA")
    	lRet := .F.
    	Return lRet
	Endif
EndIf

cDescMoeda 	:= Alltrim(aCtbMoeda[2])

If !Empty(aCtbMoeda[6])
	cDescMoeda += OemToAnsi(STR0007) + aCtbMoeda[6]			// Indica o divisor
EndIf	

nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)

aPeriodos := ctbPeriodos(mv_par08, mv_par01, mv_par02, .T., .F.)

For nCont := 1 to len(aPeriodos)       
	//Se a Data do periodo eh maior ou igual a data inicial solicitada no relatorio.
	If aPeriodos[nCont][1] >= mv_par01 .And. aPeriodos[nCont][2] <= mv_par02 
		If nMeses <= 6
			AADD(aMeses,{StrZero(nMeses,2),aPeriodos[nCont][1],aPeriodos[nCont][2]})	
			nMeses += 1           					
		EndIf
	EndIf
Next                                                                   

If nMeses == 1
	cMensagem := OemToAnsi(STR0024)
	cMensagem += OemToAnsi(STR0025)
	MsgAlert(cMensagem)
	Return
ElseIf nMeses > 7//Se o periodo solicitado for maior que 6 meses, eh exibido uma mensagem
	cMensagem := OemToAnsi(STR0022)+OemToAnsi(STR0023)//que sera impresso somente os 6 meses		
	MsgAlert(cMensagem)
EndIf                                                      

If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
	cCodMasc	:= ""
Else
	cCodmasc	:= aSetOfBook[2]
	cMascara 	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf
cPicture 		:= aSetOfBook[4]


// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)                
    nDigitAte	:= CtbRelDig(cSegAte,cMascara) 	
EndIf

If !Empty(cSegmento)
	If Empty(mv_par06)
		Help("",1,"CTN_CODIGO")
		Return
	Endif
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+cCodMasc)
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == cCodMasc
			nPos += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == STRZERO(VAL(cSegmento),2)
				nPos -= Val(CTM->CTM_DIGITO)
				nPos ++
				nDigitos := Val(CTM->CTM_DIGITO)      
				Exit
			EndIf	
			dbSkip()
		EndDo	
	Else
		Help("",1,"CTM_CODIGO")
		Return
	EndIf	
EndIf


// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
If mv_par23 == 2
	cHeader := "SLD"			/// Indica que deverá obter o saldo na 1ª coluna (Comparativo de Saldo Acumulado)
Endif 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par05 == 1
	Titulo:=	OemToAnsi(STR0008)	//"COMPARATIVO SINTETICO DE "
ElseIf mv_par05 == 2
	Titulo:=	OemToAnsi(STR0005)	//"COMPARATIVO ANALITICO DE "
ElseIf mv_par05 == 3
	Titulo:=	OemToAnsi(STR0012)	//"COMPARATIVO DE "
EndIf

Titulo += 	DTOC(mv_par01) + OemToAnsi(STR0006) + Dtoc(aMeses[Len(aMeses)][3]) + ;
				OemToAnsi(STR0007) + cDescMoeda

If mv_par10 > "1"			
	Titulo += " (" + Tabela("SL", mv_par10, .F.) + ")"
Endif                     
                
// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
If mv_par23 == 2
	Titulo += " - "+STR0026
Endif

oReport:SetPageNumber( mv_par09 )
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )

DbSelectArea("CT1")
cFilUser := oSection1:GetAdvplExp("CT1")

If Empty(cFilUser)
	cFilUser := ".T."
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
				mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
				.F.,.F.,mv_par11,cHeader,lImpAntLP,dDataLP,nDivide,cTpComp,.F.,,.T.,aMeses,lVlrZerado,,,lImpSint,cString,cFilUser)},;
				OemToAnsi(OemToAnsi(STR0015)),;  //"Criando Arquivo Tempor rio..."
				OemToAnsi(STR0003))  				//"Comparativo de Contas Contabeis com Filiais"
If Select("cArqTmp") == 0
	Return
EndIf		

oSection1:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCONTA == "1" .And. cTipoAnt == "2")), oReport:skipLine(),NIL),;
								 cTipoAnt := cArqTmp->TIPOCONTA;
							)  })       
							           
If mv_par05 == 1					// So imprime Sinteticas
	cFilter := "cArqTmp->TIPOCONTA  <>  '2'  "
	If !lVlrZerado
		cFilter += " .AND. (cArqTmp->COLUNA1 <> 0 .OR.  cArqTmp->COLUNA2 <> 0 .OR.  cArqTmp->COLUNA3 <> 0"
		cFilter += " .OR.   cArqTmp->COLUNA4 <> 0 .OR.  cArqTmp->COLUNA5 <> 0 .OR.  cArqTmp->COLUNA6 <> 0)"
	EndIf
ElseIf mv_par05 == 2				// So imprime Analiticas
	cFilter := "cArqTmp->TIPOCONTA  <>  '1'  "
	If !lVlrZerado
		cFilter += " .AND. (cArqTmp->COLUNA1 <> 0 .OR. cArqTmp->COLUNA2 <> 0 .OR.  cArqTmp->COLUNA3 <> 0"
  		cFilter += " .OR.   cArqTmp->COLUNA4 <> 0 .OR. cArqTmp->COLUNA5 <> 0 .OR.  cArqTmp->COLUNA6 <> 0)"
	EndIf	
EndIf

If !lVlrZerado  //se nao traz valor zerado entao verificar se as analiticas estao com algum coluna com valor diferente de zero
	If Empty(cFilter)
		//considerar sempre as sinteticas pois se a ctgerComp retornou eh pq tem alguma movimentacao e nas analitica verifica se as colunas estao zeradas
		cFilter += " cArqTmp->TIPOCONTA == '1' .OR. ( cArqTmp->TIPOCONTA == '2' .And. ( cArqTmp->COLUNA1 <> 0 .OR. cArqTmp->COLUNA2 <> 0 .OR. cArqTmp->COLUNA3 <> 0 .OR. "
		cFilter += "                                                                   cArqTmp->COLUNA4 <> 0 .OR. cArqTmp->COLUNA5 <> 0 .OR. cArqTmp->COLUNA6 <> 0 )  )      "
	Endif
EndIf

// Verifica Se existe filtragem Ate o Segmento
If ! Empty( cSegAte )
	If !Empty(cFilter)
		cFilter += " .And. "
	EndIf	 	
		 	
	cFilter += ( 'Len(Alltrim(cArqTmp->CONTA)) <= ' + alltrim( Str( nDigitAte )) )  
EndIf	 

oSection1:SetFilter( cFilter )

For nCont := 1 to Len(aMeses)
	cColVal := "COLUNA"+Alltrim(Str(nCont))
	
	// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
	If mv_par23 == 2	/// SE FOR ACUMULADO É O SALDO ATE A DATA FINAL
		oSection1:Cell(cColVal):SetTitle(Substr(STR0004,68,14)+Alltrim(Str(nCont))+CRLF+STR0027+"-"+DTOC(aMeses[nCont][3]))
	Else
		oSection1:Cell(cColVal):SetTitle(Substr(STR0004,68,14)+Alltrim(Str(nCont))+CRLF+SubStr(DTOC(aMeses[nCont][2]), 1, 6); 
		+ SubStr(DTOC(aMeses[nCont][2]), 9, 2)+" - "+SubStr(DTOC(aMeses[nCont][3]), 1, 6) + SubStr(DTOC(aMeses[nCont][3]), 9, 2)) // SubStr na data no nome da coluna para ocupar menos espaço
	Endif
Next

For nCont:= Len(aMeses)+1 to 6
	cColVal := "COLUNA"+Alltrim(Str(nCont))
	oSection1:Cell(cColVal):SetTitle(	Substr(STR0004,68,14)+Alltrim(Str(nCont))	)
Next


oSection1:Cell("CONTA"  ):SetBlock( {|| IF( cArqTmp->TIPOCONTA == "2" .And. mv_par05 <> 2,cEspaco:=SPACE(02),cEspaco:="" ),	/*Fazer um recuo nas contas analíticas em relação à sintética*/;
                                        IF( lNormal,	cEspaco + EntidadeCTB(cArqTmp->CONTA,0,0,70,.F.,cMascara,cSeparador,,,,,.F.),	/*Se Imprime Codigo Normal da Conta*/;
                                            			IF( cArqTmp->TIPOCONTA == "1",	AllTrim(cArqTmp->CONTA),	cEspaco + AllTrim(cArqTmp->CTARES) ) ) } )	//Conta Sintética
oSection1:Cell("DESCCTA"):SetBlock( { || (cArqTMp->DESCCTA) } )
oSection1:Cell("COLUNA1"):SetBlock( { || ValorCTB(cArqTmp->COLUNA1,,,aTamVal[1],nDecimais,lSinalMov,cPicture,Iif(lIsRedStor,cArqTmp->NORMAL,""), , , , , ,lPrintZero,.F.) } )
oSection1:Cell("COLUNA2"):SetBlock( { || ValorCTB(cArqTmp->COLUNA2,,,aTamVal[1],nDecimais,lSinalMov,cPicture,Iif(lIsRedStor,cArqTmp->NORMAL,""), , , , , ,lPrintZero,.F.) } )
oSection1:Cell("COLUNA3"):SetBlock( { || ValorCTB(cArqTmp->COLUNA3,,,aTamVal[1],nDecimais,lSinalMov,cPicture,Iif(lIsRedStor,cArqTmp->NORMAL,""), , , , , ,lPrintZero,.F.) } )
oSection1:Cell("COLUNA4"):SetBlock( { || ValorCTB(cArqTmp->COLUNA4,,,aTamVal[1],nDecimais,lSinalMov,cPicture,Iif(lIsRedStor,cArqTmp->NORMAL,""), , , , , ,lPrintZero,.F.) } )
oSection1:Cell("COLUNA5"):SetBlock( { || ValorCTB(cArqTmp->COLUNA5,,,aTamVal[1],nDecimais,lSinalMov,cPicture,Iif(lIsRedStor,cArqTmp->NORMAL,""), , , , , ,lPrintZero,.F.) } )
oSection1:Cell("COLUNA6"):SetBlock( { || ValorCTB(cArqTmp->COLUNA6,,,aTamVal[1],nDecimais,lSinalMov,cPicture,Iif(lIsRedStor,cArqTmp->NORMAL,""), , , , , ,lPrintZero,.F.) } )


// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
If mv_par23 == 1
	oSection1:Cell("COLUNAT"):SetBlock( { || ValorCTB(cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6),,,aTamVal[1],nDecimais,lSinalMov,cPicture,Iif(lIsRedStor,cArqTmp->NORMAL,""), , , , , ,lPrintZero,.F.) } )	
Else
	oSection1:Cell("COLUNAT"):Disable()
EndIf


bCond := {|| Iif( cArqTmp->TIPOCONTA="1"/*Conta Sintetica*/, IF( mv_par05 <> 1	/*Analiticas ou ambas*/,;
                                                                 .F.,;
                                                                 IF(cArqTmp->NIVEL1 /*Maior Conta superiora*/,.T.,.F.) ),;
                                                             .T. ) }

// Quebra por Grupo              
If lQbGrupo
   
	//Totais do Grupo
	oBreakGrp := TRBreak():New(oSection1, { || cArqTmp->GRUPO },{|| STR0016+" "+ RTrim( Upper(AllTrim(cGrupo) )) + " )" },,,.F.)	//	"T O T A I S  D O  G R U P O ("
	oBreakGrp:OnBreak( { |x| cGrupo := x } )
                                              
	oTotGrp1 := TRFunction():New(oSection1:Cell("COLUNA1"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA1, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp2 := TRFunction():New(oSection1:Cell("COLUNA2"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA2, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp3 := TRFunction():New(oSection1:Cell("COLUNA3"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA3, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp4 := TRFunction():New(oSection1:Cell("COLUNA4"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA4, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp5 := TRFunction():New(oSection1:Cell("COLUNA5"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA5, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp6 := TRFunction():New(oSection1:Cell("COLUNA6"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA6, 0 ) },.F.,.F.,.F.,oSection1)
	
	If lIsRedStor
		TRFunction():New(oSection1:Cell("COLUNA1"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp1:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA1"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp1:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1 )
	Endif
	
	If lIsRedStor
		TRFunction():New(oSection1:Cell("COLUNA2"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp2:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA2"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp2:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1 )
	Endif
	
	If lIsRedStor
		TRFunction():New(oSection1:Cell("COLUNA3"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp3:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA3"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp3:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1 )
	Endif
	
	If lIsRedStor
		TRFunction():New(oSection1:Cell("COLUNA4"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp4:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA4"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp4:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA5"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp5:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA5"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp5:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA6"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp6:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA6"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp6:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1 )
	Endif

	// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
	If mv_par23 == 1
		oTotGrpTot := TRFunction():New(oSection1:Cell("COLUNAT"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6), 0 ) },.F.,.F.,.F.,oSection1)
	    If lIsRedStor
	    	TRFunction():New(oSection1:Cell("COLUNAT"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	    	{ || StrTran(ValorCTB(oTotGrpTot:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	    Else
	    	TRFunction():New(oSection1:Cell("COLUNAT"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	    	{ || ValorCTB(oTotGrpTot:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1 )
	    Endif	

		oTotGrpTot:Disable()
	EndIf

	oTotGrp1:Disable()
	oTotGrp2:Disable()
	oTotGrp3:Disable()
	oTotGrp4:Disable()
	oTotGrp5:Disable()
	oTotGrp6:Disable()
EndIf


// Total
oTotCol1 := TRFunction():New(oSection1:Cell("COLUNA1"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA1, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol2 := TRFunction():New(oSection1:Cell("COLUNA2"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA2, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol3 := TRFunction():New(oSection1:Cell("COLUNA3"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA3, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol4 := TRFunction():New(oSection1:Cell("COLUNA4"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA4, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol5 := TRFunction():New(oSection1:Cell("COLUNA5"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA5, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol6 := TRFunction():New(oSection1:Cell("COLUNA6"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA6, 0 ) },.F.,.T.,.F.,oSection1)

// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
If mv_par23 == 1
	oTotColTot := TRFunction():New(oSection1:Cell("COLUNAT"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                                   { || If( Eval(bCond), cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6), 0 ) },.F.,.T.,.F.,oSection1)
EndIf
                                                                      
If lIsRedStor
	TRFunction():New(oSection1:Cell("COLUNA1"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol1:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA1"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol1:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.T.,.F.,oSection1 )
Endif		

If lIsRedStor
	TRFunction():New(oSection1:Cell("COLUNA2"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol2:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA2"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol2:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.T.,.F.,oSection1 )
Endif		

If lIsRedStor
	TRFunction():New(oSection1:Cell("COLUNA3"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol3:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA3"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol3:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.T.,.F.,oSection1 )
Endif		

If lIsRedStor
	TRFunction():New(oSection1:Cell("COLUNA4"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol4:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA4"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol4:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.T.,.F.,oSection1 )
Endif		

If lIsRedStor
	TRFunction():New(oSection1:Cell("COLUNA5"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol5:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA5"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol5:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.T.,.F.,oSection1 )
Endif		

If lIsRedStor
	TRFunction():New(oSection1:Cell("COLUNA6"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol6:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA6"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol6:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.T.,.F.,oSection1 )
Endif		

// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
If mv_par23 == 1
	If lIsRedStor
		TRFunction():New(oSection1:Cell("COLUNAT"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotColTot:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNAT"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotColTot:GetValue(),,,aTamVal[1],nDecimais,lSinalMov,cPicture,,,,,,,lPrintZero,.F.) },.F.,.T.,.F.,oSection1 )
	Endif		
EndIf

oTotCol1:Disable()
oTotCol2:Disable()
oTotCol3:Disable()
oTotCol4:Disable()
oTotCol5:Disable()
oTotCol6:Disable()

// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
If mv_par23 == 1
	oTotColTot:Disable()
EndIf
                     
oReport:SetTotalInLine(.F.)	
oReport:SetTotalText(STR0011)	//	"T O T A I S  D O  P E R I O D O: "

oSection1:Print()

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea() 
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF	

Return