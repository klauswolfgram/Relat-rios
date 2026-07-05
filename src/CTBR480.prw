/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR480.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR  17
#DEFINE TAM_CONTA  17   

STATIC __lBlind  := IsBlind()

Static __oQueryCont := Nil

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

//AMARRACAO DE PACOTE
// 17/08/2009 -- Filial com mais de 2 caracteres
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR480  ³ Autor ³ Simone Mie Sato       ³ Data ³ 02.05.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Razao por Item Contabil                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CTBR480                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctbr480(cItemIni, cItemFim, dDataIni, dDataFim, cMoeda, cSaldo, cBook, cContaIni,; 
			cContaFim, lCusto, cCustoIni, cCustoFim, lCLVL,	cCLVLIni, cCLVLFim,lSalLin,aSelFil)

Local aArea			:= GetArea()
Local cPerg			:= "CTR480"
Local lExterno		:= cContaIni <> Nil
Local lOk	  		:= .T.  

Private nSldDTransp	:= 0 // Variaveis utilizadas para calcular o valor de transporte entre contas
Private nSldATransp := 0
Private NomeProg 	:= "CTBR480"

Default lCusto		:= .T.
Default lCLVL		:= .T.   
Default lSalLin		:= .T.
Default aSelFil 	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // Do Item Contabil                      ³
//³ mv_par02            // Ate o Item Contabil                   ³
//³ mv_par03            // da data                               ³
//³ mv_par04            // Ate a data                            ³
//³ mv_par05            // Moeda			                     ³   
//³ mv_par06            // Saldos		                         ³   
//³ mv_par07            // Set Of Books                          ³
//³ mv_par08            // Analitico ou Resumido dia (resumo)    ³
//³ mv_par09            // Imprime conta sem movimento?          ³
//³ mv_par10            // Imprime Cod (Normal / Reduzida)       ³
//³ mv_par11            // Totaliza tb por Conta?                ³
//³ mv_par12            // Da Conta                              ³
//³ mv_par13            // Ate a Conta                           ³
//³ mv_par14            // Imprime Centro de Custo?		         ³	
//³ mv_par15            // Do Centro de Custo                    ³
//³ mv_par16            // Ate o Centro de Custo                 ³
//³ mv_par17            // Imprime Classe de Valor?              ³	
//³ mv_par18            // Da Classe de Valor                    ³
//³ mv_par19            // Ate a Classe de Valor                 ³
//³ mv_par20            // Salta folha por Item?                 ³
//³ mv_par21            // Pagina Inicial                        ³
//³ mv_par22            // Pagina Final                          ³
//³ mv_par23            // Numero da Pag p/ Reiniciar            ³	   
//³ mv_par24            // Imprime Cod. CCusto(Normal/Reduzido)  ³
//³ mv_par25            // Imprime Cod. Item (Normal/Reduzido)   ³
//³ mv_par26            // Imprime Cod. Cl.Valor(Normal/Reduzido)³	   	    
//³ mv_par27            // Imprime Valor 0.00				 	 ³	   	   
//³ mv_par28            // Salta linha            				 ³	   	   
//³ mv_par29            // Seleciona filiais ?				     ³	   	   
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	lOk := .F.
EndIf

If lOk 
	
	If !lExterno
		If ! Pergunte(cPerg, .T. )
			lOk := .F.
		Endif
		
		// Se aFil nao foi enviada, exibe tela para selecao das filiais
		If lOk .And. mv_par29 == 1 .And. Len( aSelFil ) <= 0
			aSelFil := AdmGetFil()
			If Len( aSelFil ) <= 0
				lOk := .F.
			EndIf 
		EndIf   
		
	Else
		Pergunte(cPerg, .F.)
	Endif

	If !lExterno
		lCusto	:= Iif(mv_par14 == 1,.T.,.F.)
		lCLVL	:= Iif(mv_par17 == 1,.T.,.F.)
	Else //Caso seja externo, atualiza os parametros do relatorio com os dados passados como parametros.
		mv_par01 := cItemIni
		mv_par02 := cItemFim
		mv_par03 := dDataIni
		mv_par04 := dDataFim
		mv_par05 := cMoeda
		mv_par06 := cSaldo
		mv_par07 := cBook
		mv_par12 := cContaIni
		mv_par13 := cContaFim
		mv_par14 := If(lCusto,1,2)
		mv_par15 := cCustoIni
		mv_par16 := cCustoFim
		mv_par17 := If(lClVl,1,2)
		mv_par18 := cClVlIni
		mv_par19 := cClVlFim
		MV_PAR28 := Iif(lSalLin,1,2)
		mv_par09 := 2
		
		If Empty( mv_par01 ) .And. Empty( mv_par02 )      
			Help(" ",1,"CTR480IT",,STR0040 )//"Nao ha dados a exibir, Item de - Item Ate em branco"
			lOk := .F.
		ENDIF  
	Endif	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se usa Set Of Books -> Conf. da Mascara / Valores   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Ct040Valid(mv_par07)
		lOk := .F.
	EndIf
	
	If lOk
		aCtbMoeda := CtbMoeda(mv_par05)
		If Empty(aCtbMoeda[1])
			Help(" ",1,"NOMOEDA")
			lOk := .F.
		Endif
	Endif
EndIF

If lOk	
	U_CTBR480R4(cPerg,lCusto, lCLVL,aCtbMoeda,aSelFil)	
EndIf

If Select("cArqTmp") > 0
	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()

EndIf	

//Limpa os arquivos temporários 
CtbRazClean()

RestArea(aArea)
Return              

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr480R4³ Autor ³ Gustavo Henrique  	³ Data ³ 01/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao dos lanc. gerados pela rotina de apurac. c/ cta pte³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_Ctbr480R4()    											  ³±±
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
User Function CTBR480R4( cPerg,lCusto, lCLVL,aCtbMoeda,aSelFil)
Local oReport

oReport := ReportDef( cPerg, lCusto, lCLVL, aCtbMoeda, aSelFil )
oReport:PrintDialog()
oReport := Nil
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Gustavo Henrique      ³ Data ³01/09/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Esta funcao tem como objetivo definir as secoes, celulas,   ³±±
±±³          ³totalizadores do relatorio que poderao ser configurados     ³±±
±±³          ³pelo usuario.                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³EXPO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef( cPerg, lCusto, lCLVL, aCtbMoeda, aSelFil )

Local aSetOfBook := CTBSetOf(mv_par07)// Set Of Books	

Local cPicture 		:= aSetOfBook[4]
Local cDescMoeda 	:= aCtbMoeda[2]
Local cSayCusto		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")
Local cTitulo		:= STR0006 + Alltrim(cSayItem)	//"Emissao do Razao Contabil por Item"
Local cDescricao	:= ""


Local aTamItem  	:= TamSX3("CTD_ITEM")
Local nTamCusto		:= Len(CriaVar("CT3_CUSTO"))
Local nTamConta		:= Len(CriaVar("CT1_CONTA"))
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par05)// Moeda
Local nTamHist		:= Len(CriaVar("CT2_HIST"))
Local nTamCLVL		:= Len(CriaVar("CTH_CLVL"))
Local nSepMasc 		:= 0 // separador da mascara (".")

Local lAnalitico	:= Iif(mv_par08==1,.T.,.F.)// Analitico ou Resumido dia (resumo)
Local lSaltaPg		:= Iif(mv_par20==1,.T.,.F.)// Salto de pagina por Item
Local lPrintZero	:= IIf(mv_par27==1,.T.,.F.)// Imprime valor 0.00    ?   

Local nTamTransp    := 0
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty

If nTamHist > 40   
	//se ultrapassar 40 posicoes define o tamanho como 40 posicoes 
	// para nao truncar informacoes como contra-partida / debito / cred/ etc
	nTamHist := 40
EndIf

cDescricao := STR0001+AllTrim(cSayItem)		//"Este programa ira imprimir o Razao por "
cDescricao += STR0002						//"de acordo com os parametros sugeridos pelo usuario. "


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
oReport :=	TReport():New( NomeProg, cTitulo,cPerg ,;
			{ |oReport|	ReportPrint(oReport,aCtbMoeda,aSetOfBook,cPicture,cDescMoeda,nDecimais,;
						nTamConta + 5,lAnalitico,lCusto,lCLVL,cSayItem,aSelFil) }, cDescricao )

oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)

// Tratativa para acrescentar separadores de mascara da CTM no tamanho da célula "ITEM CONTA"
If !Empty(aSetOfBook[7]) 
	DbSelectArea("CTM")
	DbSetOrder(1)
	If MsSeek(xFilial("CTM")+aSetOfBook[7])
		While CTM->(!EOF() .And. CTM_FILIAL+CTM_CODIGO == xFilial("CTM")+aSetOfBook[7])
			If !Empty(CTM->CTM_SEPARA)
				nSepMasc += 1 // tamanho do CTM_SEPARA
			EndIf
			CTM->(DbSkip())
		EndDo
	EndIf
EndIf

If nSepMasc > 0
	aTamItem[1] += nSepMasc // atualiza tamanho do campo
EndIf

If lAnalitico
	oReport:DisableOrientation()
	oReport:SetLandScape(.T.)
Else
	oReport:SetPortrait(.T.)
EndIf

oItem := TRSection():New( oReport, STR0028, {"cArqTmp","CT2"},, .F., .F. )	// "Item"

	If lSaltaPg
		oItem:SetPageBreak(.T.)
	EndIf

	TRCell():New( oItem, "ITEM"		, "cArqTmp"	, Upper(cSayItem)/*Titulo*/	,/*Picture*/,aTamItem[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/) 
	                                                                                                   
	TRCell():New( oItem, "DESCIT"	, ""       	, STR0039					,/*Picture*/,IIF(lAnalitico,nTamHist+43,39)+nTamConta+nTamCusto+nTamCLVL+TAM_VALOR,/*lPixel*/,/*CodeBlock*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/) //"DESCRICAO"
	TRCell():New( oItem, "DESANT"	, ""       	, STR0027					,/*Picture*/,Len(STR0027)	,/*lPixel*/,{||STR0027}/*{|| }*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	TRCell():New( oItem, "TPSLDANT"	, ""       	, STR0027					,/*Picture*/,TAM_VALOR+2	,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	oItem:SetEdit(.F.)//Inibido as celulas para não possibilitar personalização	
                                                         
	oItem:Cell("DESANT"):HideHeader()
	oItem:Cell("TPSLDANT"):HideHeader()

oLancto := TRSection():New( oReport, STR0029, {"cArqTmp"},, .F., .F. )	//"Lançamentos Contábeis"
	oLancto:SetTotalInLine(.F.)

	if MV_PAR28 == 2  .Or. MV_PAR28 == 1
		oLancto:SetLinesBefore(0)
	Endif 

	TRCell():New(oLancto, "DATAL"		, "cArqTmp", STR0030			,/*Picture*/,IIF(lAnalitico, 10, 24)	,/*lPixel*/	,/*{|| }*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// "DATA"		
	TRCell():New(oLancto, "DOCUMENTO"	,""        , STR0031			,/*Picture*/,IIF(lIsRedStor, 22, 18)  	,/*lPixel*/	,{|| cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA }, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// "LOTE/SUB/DOC/LINHA"
	TRCell():New(oLancto, "HISTORICO"	,"cArqTmp" , STR0032			,/*Picture*/,nTamHist   				,/*lPixel*/	,{|| cArqTmp->HISTORICO }, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// "Historico"
	TRCell():New(oLancto, "XPARTIDA"	,"cArqTmp" , STR0033			,/*Picture*/,nTamConta + 5				,/*lPixel*/	,/*{|| }*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// "XPARTIDA"
	TRCell():New(oLancto, "CUSTO"	  	,"cArqTmp" , Upper(cSayCusto)	,/*Picture*/,nTamCusto + 5				,/*lPixel*/	,/*{|| }*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// Item Contabil	
	If ! __lBlind
		TRCell():New(oLancto, "ITEM"	    , "cArqTmp"	, Upper(cSayItem)/*Titulo*/	,/*Picture*/,aTamItem[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/) 
	EndIf
	TRCell():New(oLancto, "CLVL"		,"cArqTmp" , Upper(cSayClVl) 	,/*Picture*/,nTamCLVL					,/*lPixel*/	,/*{|| }*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// Classe de Valor	
	TRCell():New(oLancto, "LANCDEB"		,"cArqTmp" , STR0034			,/*Picture*/,TAM_VALOR					,/*lPixel*/	,{|| ValorCTB(cArqTmp->LANCDEB,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// "DEBITO"
	TRCell():New(oLancto, "LANCCRD"		,"cArqTmp" , STR0035			,/*Picture*/,TAM_VALOR					,/*lPixel*/	,{|| ValorCTB(cArqTmp->LANCCRD,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// "CREDITO"
	TRCell():New(oLancto, "TPSLDATU"	,"cArqTmp" , STR0036			,/*Picture*/,TAM_VALOR+2				,/*lPixel*/	,/*{|| }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// "SALDO ATUAL"
	
	oLancto:Cell("HISTORICO"):SetLineBreak()
	oLancto:SetHeaderPage()
	
	oLancto:SetEdit(.F.)//Inibido as celulas para não possibilitar personalização	

	If lAnalitico 
		If !lCusto
			oLancto:Cell("CUSTO" ):SetBlock({|| "" })
			oLancto:Cell("CUSTO" ):Hide()
			oLancto:Cell("CUSTO" ):HideHeader() 
		EndIf
		If !lCLVL
			oLancto:Cell("CLVL"	):SetBlock({|| "" })
			oLancto:Cell("CLVL"	):Hide()
			oLancto:Cell("CLVL"	):HideHeader() 
		EndIf
	Else // Resumido
		oLancto:Cell("CUSTO"):SetBlock({|| "" })
		oLancto:Cell("CUSTO"):Hide()
		oLancto:Cell("CUSTO"):HideHeader() 
		oLancto:Cell("CLVL"	):SetBlock({|| "" })
		oLancto:Cell("CLVL"	):Hide()
		oLancto:Cell("CLVL"	):HideHeader() 

		oLancto:Cell("HISTORICO"):Disable()
		oLancto:Cell("DOCUMENTO"):Hide()
		oLancto:Cell("DOCUMENTO"):HideHeader()
		oLancto:Cell("XPARTIDA"	):Hide()
		oLancto:Cell("XPARTIDA"	):HideHeader() 
	EndIf


If lAnalitico
	nTamTransp := oLancto:Cell("DATAL"):GetSize()     + oLancto:Cell("DOCUMENTO"):GetSize();
	            + oLancto:Cell("HISTORICO"):GetSize() + oLancto:Cell("XPARTIDA"):GetSize();  
				+ oLancto:Cell("CUSTO"):GetSize()     + oLancto:Cell("CLVL"):GetSize()+7
Else
	nTamTransp := oLancto:Cell("DATAL"):GetSize()     + oLancto:Cell("DOCUMENTO"):GetSize();
	            + oLancto:Cell("XPARTIDA"):GetSize()  + oLancto:Cell("CUSTO"):GetSize();
				+ oLancto:Cell("CLVL"):GetSize()+6
EndIf
				


// Totais das sessoes
oTotais := TRSection():New( oReport,STR0037,,, .F., .F. )		
	TRCell():New(oTotais,"TOT"			,"",STR0039,/*Picture*/,nTamTransp	,/*lPixel*/,/*{|| code-block de impressao }*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)	//"DESCRICAO"	
	
	// celulas somente criadas para tratar formatação no modo planilha
	TRCell():New(oTotais,"espColumDescricao"	,""," ",/*Picture*/,TAM_VALOR	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	TRCell():New(oTotais,"espColumHistorico"	,""," ",/*Picture*/,TAM_VALOR	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	TRCell():New(oTotais,"espColumXpartida"	,""," ",/*Picture*/,TAM_VALOR	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	TRCell():New(oTotais,"espColumCusto"	,""," ",/*Picture*/,TAM_VALOR	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	TRCell():New(oTotais,"espColumCValor"	,""," ",/*Picture*/,TAM_VALOR	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	TRCell():New(oTotais,"espColumItemConta"	,""," ",/*Picture*/,TAM_VALOR	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	// nos pontos acima nao e possivel saber se o usuario vai imprimir modo planilha por esse motivo criada para todos os cenarios

	TRCell():New(oTotais,"TOT_DEBITO"	,"",STR0034,/*Picture*/,TAM_VALOR	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	TRCell():New(oTotais,"TOT_CREDITO"	,"",STR0035,/*Picture*/,TAM_VALOR	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	TRCell():New(oTotais,"TOT_ATU"		,"",STR0036,/*Picture*/,TAM_VALOR+2	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT", /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)	
	oTotais:SetEdit(.F.)//Inibido as celulas para não possibilitar personalização	
	// oTotais:Cell("TOT"			):HideHeader() 
	oTotais:Cell("TOT_DEBITO"	):HideHeader() 
	oTotais:Cell("TOT_CREDITO"	):HideHeader() 
	oTotais:Cell("TOT_ATU"		):HideHeader() 

// Complemento
oCompl := TRSection():New( oReport,STR0038,,, .F., .F. )	//"Complemento" 
	TRCell():New(oCompl, "tamdata"		, "", 	,/*Picture*/,oLancto:Cell("DATAL"):GetSize() 	,/*lPixel*/	,/*{|| }*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// linha inserida apenas para manter formatação ao imprimir continuação de historico	
	TRCell():New(oCompl, "tamdocum"	,""        , ,/*Picture*/,oLancto:Cell("DOCUMENTO"):GetSize() 	,/*lPixel*/	,/*{|| code-block de impressao }*/, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)// linha inserida apenas para manter formatação ao imprimir continuação de historico	
	TRCell():New(oCompl,"COMP","",Upper(STR0038),/*Picture*/,oLancto:Cell("HISTORICO"):GetSize()+28+oLancto:Cell("XPARTIDA"):GetSize()+oLancto:Cell("LANCDEB"):GetSize()+oLancto:Cell("LANCCRD"):GetSize()+oLancto:Cell("TPSLDATU"):GetSize(),/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, .T./*lAutoSize*/)
	oCompl:SetEdit(.F.)//Inibido as celulas para não possibilitar personalização		
	oCompl:Cell("COMP"):HideHeader()  
	oCompl:Cell("tamdata"):HideHeader()  
	oCompl:Cell("tamdocum"):HideHeader()  
	oCompl:SetHeaderSection(.F.)
	oCompl:SetLinesBefore(0)
	
oReport:ParamReadOnly()

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Gustavo Henrique      ³ Data ³01/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime o relatorio definido pelo usuario de acordo com as  ³±±
±±³          ³secoes/celulas criadas na funcao ReportDef definida acima.  ³±±
±±³          ³Nesta funcao deve ser criada a query das secoes se SQL ou   ³±±
±±³          ³definido o relacionamento e filtros das tabelas em CodeBase.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³EXPO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport,aCtbMoeda,aSetOfBook,cPicture,cDescMoeda,;
				nDecimais,nTamConta,lAnalitico,lCusto,lCLVL,cSayItem,aSelFil )
                          
Local oItem    		:= oReport:Section(1)
Local oLancto  		:= oReport:Section(2)
Local oTotais  		:= oReport:Section(3)
                                      
Local cMascara1		:= ""
Local cMascara2		:= ""
Local cMascara3		:= ""
Local cMascara4		:= ""
Local cItemAnt		:= ""
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cSepara3		:= ""
Local cSepara4		:= ""
Local cArqTmp		:= ""               
Local cFiltro		:= ""
Local cContaAnt		:= ""
Local cResCusto		:= ""
Local cResClVl		:= ""
Local cItem			:= ""
Local cNormal		:= ""
Local cSaldo		:= mv_par06
Local cItemIni		:= mv_par01
Local cItemFim		:= mv_par02
Local cMoeda		:= mv_par05
Local cContaIni		:= mv_par12
Local cContaFIm		:= mv_par13
Local cCustoIni		:= mv_par15
Local cCustoFim		:= mv_par16
Local cCLVLIni		:= mv_par18
Local cCLVLFim		:= mv_par19
Local cFilCCIni		:= Space( TamSX3("CTT_CUSTO")[1] )
Local cFilCCFim		:= Repl('Z',Len(CTT->CTT_CUSTO))

Local dDataIni		:= mv_par03
Local dDataFim		:= mv_par04
Local dDataAnt		:= CtoD("  /  /  ")

Local lNoMov		:= Iif(mv_par09==1,.T.,.F.) // Imprime conta sem movimento?           
Local lSaltaPg		:= Iif(mv_par20==1,.T.,.F.)// Salto de pagina por Item
Local lPrintZero	:= Iif(mv_par27==1,.T.,.F.) // Imprime valor 0.00    ?

Local nTamItem 		:= Len(CriaVar("CTD->CTD_DESC"+mv_par05))

Local lUsaNormalC   := .F.

Local nVlrDeb		:= 0
Local nVlrCrd		:= 0
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nTotCtaDeb	:= 0
Local nTotCtaCrd	:= 0
Local cFilOld := cFilAnt
Local oMeter   
Local oText
Local oDlg   
Local lEnd
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local cNormalIT		:= ""
Local aTamItem  	:= TamSX3("CTD_ITEM")
Local nTamDesc		:= Len(STR0020) //T o t a i s  d a  C o n t a  ==>

cFiltro	:= oItem:GetAdvplExp()

If Type("NewHead")== "U"
	Titulo	:=	STR0007	+ Upper(Alltrim(cSayItem))//"RAZAO POR ITEM  "
	IF lAnalitico
		Titulo	+= STR0008		//"ANALITICO EM"
	Else
		Titulo	+=	STR0021		//" SINTETICO EM "
	EndIf
	Titulo += 	cDescMoeda + space(01)+STR0009 + space(01)+DTOC(dDataIni) +;	// "DE"
					space(01)+STR0010 + space(01)+DTOC(dDataFim)						// "ATE"
	
	If mv_par06 > "1"
		Titulo += " (" + Tabela("SL", mv_par06, .F.) + ")"
	EndIf
Else
	Titulo := NewHead
EndIf

// Mascara do Item Contabil
If Empty(aSetOfBook[7])
	cMascara3 := GetMv("MV_MASCCTD")
Else
	cMascara3 := RetMasCtb(aSetOfBook[7],@cSepara3)
EndIf

// Mascara da Conta
If Empty(aSetOfBook[2])
	cMascara1 	:= GetMv("MV_MASCARA")
Else
	cMascara1	:= RetMasCtb(aSetOfBook[2],@cSepara1)
EndIf
 
// Mascara do Centro de Custo
If lCusto
	If Empty(aSetOfBook[6])
		cMascara2 	:= GetMv("MV_MASCCUS")
	Else
		cMascara2	:= RetMasCtb(aSetOfBook[6],@cSepara2)
	EndIf                                                
Endif 

// Mascara da Classe de Valor
If lCLVL
	If Empty(aSetOfBook[8])
		cMascara4 := ""
	Else
		cMascara4 := RetMasCtb(aSetOfBook[8],@cSepara4)
	EndIf
EndIf	

If oReport:nDevice != 4 // verificação de modo planilha caso nao for desabilitamos a impressao das celulas tratamento para imprimir formatação dos totais corretos no modo planilha
	oTotais:Cell("espColumDescricao"):Disable()
	oTotais:Cell("espColumHistorico"):Disable()
	oTotais:Cell("espColumXpartida"):Disable()
	oTotais:Cell("espColumCusto"):Disable()
	oTotais:Cell("espColumCValor"):Disable()
	oTotais:Cell("espColumItemConta"):Disable()
	IIF(!__lBlind, oLancto:Cell("ITEM"):Disable(), .f.)
Else// fecho o header da coluna
	oTotais:Cell("espColumDescricao"):HideHeader()
	oTotais:Cell("espColumHistorico"):HideHeader()
	If lAnalitico
		oTotais:Cell("espColumXpartida"):HideHeader()
	Else
		oTotais:Cell("espColumXpartida"):Disable()
	EndIf
	oTotais:Cell("espColumCusto"):HideHeader()
	oTotais:Cell("espColumCValor"):HideHeader()
	oTotais:Cell("espColumItemConta"):HideHeader()

	oTotais:Cell("TOT"):SetSize(aTamItem[1]+nTamDesc+45) // Definindo o tamanho da celula "Totais Item Conta" quando impresso em planilha.
EndIf

oReport:SetTitle(Titulo)
oReport:SetPageNumber(mv_par21) //mv_par21	-	Pagina Inicial
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    


If  __lBlind 

	lExterno := .T.   
	
	CTBGerRaz(oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
				cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
				aSetOfBook,lNoMov,cSaldo,.t.,"3",lAnalitico,,,cFiltro,,aSelFil,lExterno)
Else

	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTBGerRaz(oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
				cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
				aSetOfBook,lNoMov,cSaldo,.t.,"3",lAnalitico,,,cFiltro,,aSelFil)},;
				STR0018,;		// "Criando Arquivo Temporario..."
				STR0006+(Alltrim(cSayItem)))	// "Emissao do Razao"  
Endif

dbSelectArea("cArqTmp")
dbGoTop()

oReport:SetMeter(RecCount())
oReport:NoUserFilter()

oItem:Init()

If !(cArqTmp->(RecCount()) == 0 .And. !Empty(aSetOfBook[5]))
	Do While cArqTmp->( ! EoF() ) .And. !oReport:Cancel()
	
	    cFilAnt := cArqTmp->FILORI
	    
	    If oReport:Cancel()
	    	Exit
	    EndIf        
		
		// Se imprime centro de custo, ira considerar o filtro do centro de custo para calculo do saldo ant. 
		cItem := cArqTmp->ITEM
		
		If lCusto 	
			aSaldoAnt	:= SaldTotCT4(cItem,cItem,cCustoIni,cCustoFim,cContaIni,cContaFim,dDataIni,cMoeda,cSaldo,aSelFil)
			aSaldo		:= SaldTotCT4(cItem,cItem,cCustoIni,cCustoFim,cContaIni,cContaFim,cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)
		Else		
			aSaldoAnt	:= SaldTotCT4(cItem,cItem,cFilCCIni,cFilCCFim,cContaIni,cContaFim,dDataIni,cMoeda,cSaldo,aSelFil)
			aSaldo 		:= SaldTotCT4(cItem,cItem,cFilCCIni,cFilCCFim,cContaIni,cContaFim,cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)
		EndIf

		If Ctbr480Fil(lNoMov,aSaldo,dDataIni)
			cArqTmp->(dbSkip())
			Loop
		EndIf
                                        
		nTotDeb		:= 0
		nTotCrd		:= 0                              
		nSaldoAtu	:= 0

		oItem:Cell("ITEM"):SetTitle( Upper(AllTrim(cSayItem)) )	//"ITEM"
	
		CTD->(dbSetOrder(1))
		CTD->(MsSeek(xFilial()+cArqTMP->ITEM))
		If lIsRedStor
			cNormalIT := CTD->CTD_NORMAL
		Endif
		If mv_par25 == 1 //Se imprime cod. normal item
			oItem:Cell("ITEM"):SetBlock( { || EntidadeCTB(cArqTmp->ITEM,0,0,nTamItem,.F.,cMascara3,cSepara3,,,,,.F.) } )
		Else
			cResItem := CTD->CTD_RES
			oItem:Cell("ITEM"):SetBlock( { || EntidadeCTB(cResItem,0,0,Len(cResItem),.F.,cMascara3,cSepara3,,,,,.F.)	 } )
		Endif
	
		oItem:Cell("DESCIT"):SetBlock( { || " - " + CtbDescMoeda("CTD->CTD_DESC"+cMoeda) } )

		If mv_par12 == mv_par13 .and. Len(aSelFil) < 2 
			CT1->(dbSetOrder(1))
			CT1->(MsSeek(xFilial('CT1')+cArqTmp->CONTA))
			cNormal := CT1->CT1_NORMAL
			lUsaNormalC := .T.
		Else
			lUsaNormalC := Ctr480Nor(aSelFil)
			If lUsaNormalC
				CT1->(dbSetOrder(1))
				CT1->(MsSeek(xFilial('CT1')+cArqTmp->CONTA))
				cNormal := CT1->CT1_NORMAL
			EndIf
		EndIf
	    
		If lIsRedStor	
			oItem:Cell("TPSLDANT"):SetBlock( { || ValorCTB(aSaldoAnt[6],,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lIsRedStor,cNormalIT,""),,,,,,lPrintZero,.F.) } )
		Else
			oItem:Cell("TPSLDANT"):SetBlock( { || ValorCTB(aSaldoAnt[6],,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lUsaNormalC, cNormal,'' ),,,,,,lPrintZero,.F.) } )
		EndIF

		oItem:PrintLine()    //Imprime o Saldo anterior         
		
		nSaldoAtu := aSaldoAnt[6]

		// A TRANSPORTAR :  	
		If lIsRedStor
			oReport:SetPageFooter( 5, {|| Iif(oLancto:Printing() .Or. oTotais:Printing(),;
				oReport:PrintText(STR0022 + ValorCTB(nSldATransp,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lIsRedStor,cNormalIT,""),,,,,,lPrintZero,.F.) ),nil)})
		Else
			oReport:SetPageFooter( 5, {|| Iif(oLancto:Printing() .Or. oTotais:Printing(),;
				oReport:PrintText(STR0022 + ValorCTB(nSldATransp,,,TAM_VALOR,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.) ),nil)})
		EndIF

		//"DE TRANSPORTE : "
		If lIsRedStor
			oReport:OnPageBreak( {|| Iif(oLancto:Printing() .Or. oTotais:Printing(),;
				(oReport:PrintText(STR0023 + ValorCTB(nSldDTransp,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lIsRedStor,cNormalIT,""),,,,,,lPrintZero,.F.),oReport:Row(),10),oReport:Skipline()),nil)})
		Else
			oReport:OnPageBreak( {|| Iif(oLancto:Printing() .Or. oTotais:Printing(),;
				(oReport:PrintText(STR0023 + ValorCTB(nSldDTransp,,,TAM_VALOR,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.),oReport:Row(),10),oReport:Skipline()),nil)})
		EndIF
		
		cItemAnt := cArqTmp->ITEM

		Do While cArqTmp->(!Eof()) .And. cArqTmp->ITEM == cItemAnt .And. !oReport:Cancel()
		                                        
		   	If oReport:Cancel()
		   		Exit
		   	EndIf
		   
			cContaAnt	:= cArqTmp->CONTA
			dDataAnt	:= cArqTmp->DATAL		

			If lAnalitico
				
				nTotCtaDeb  := 0
				nTotCtaCrd	:= 0
				
				If ! Empty(cArqTmp->CONTA)
				
					cConta := STR0024	// "CONTA - "
				
					CT1->(dbSetOrder(1))
					CT1->(MsSeek(xFilial('CT1')+cArqTmp->CONTA))
					
					cCodRes := CT1->CT1_RES
					cNormal := CT1->CT1_NORMAL
			
					If mv_par10 == 1 // Imprime Cod Normal
						cConta += EntidadeCTB(cArqTmp->CONTA,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.)
					Else
						cConta += EntidadeCTB(cCodRes,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.)
					EndIf
	
					cConta += CtbDescMoeda("CT1->CT1_DESC"+cMoeda)
					               
					If mv_par11 == 1 // Totaliza tb por conta ?	
						oReport:SkipLine()
					EndIf	     
					
					If oReport:Printing() .and. MV_PAR28 == 1 .And. mv_par11 == 2
						oReport:SkipLine()                                                                                        
					EndIf

					oReport:PrintText(cConta)	 //Imprime a Conta

				Endif

				oLancto:Init()

				Do While cArqTmp->(!Eof()) .And. cArqTmp->ITEM == cItemAnt .And. cArqTmp->CONTA == cContaAnt .And. !oReport:Cancel()
					
					If len(aSelFil)>1 .and. cFilAnt != cArqTmp->FILORI
						cFilAnt := cArqTmp->FILORI
						CT1->(dbSetOrder(1))
						CT1->(MsSeek(xFilial('CT1')+cArqTmp->CONTA)) //Posiciono na conta para pegar a condição normal de acordo com a FILIAL
						cNormal := CT1->CT1_NORMAL
					EndIF

					If oReport:Cancel()
						Exit
					EndIf	
				     
					oReport:IncMeter() 

   					If lIsRedStor
						nSaldoAtu 	:= nSaldoAtu - cArqTmp->LANCDEB + cArqTmp->LANCCRD
					Else
						nSaldoAtu 	:= Round(Noround(nSaldoAtu - cArqTmp->LANCDEB + cArqTmp->LANCCRD,nDecimais+1),nDecimais)
					EndIF
					nTotDeb		+= cArqTmp->LANCDEB
					nTotCrd		+= cArqTmp->LANCCRD
					nTotCtaDeb	+= cArqTmp->LANCDEB
					nTotCtaCrd	+= cArqTmp->LANCCRD			
					
					             
					If dDataAnt <> cArqTmp->DATAL 
						oLancto:Cell("DATAL"):SetBlock( { || cArqTmp->DATAL } )
						dDataAnt := cArqTmp->DATAL    
					Else
						oLancto:Cell("DATAL"):SetBlock( { || dDataAnt } )
					EndIf	
					                   
					CT1->(dbSetOrder(1))
					CT1->(MsSeek(xFilial("CT1")+cArqTmp->XPARTIDA))
						
					cCodRes := CT1->CT1_RES
											
					If mv_par10 == 1 // Impr Cod (Normal/Reduzida/Cod.Impress)
						oLancto:Cell("XPARTIDA"):SetBlock( { || EntidadeCTB(cArqTmp->XPARTIDA,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.) } )
					Else
						oLancto:Cell("XPARTIDA"):SetBlock( { || EntidadeCTB(cCodRes,0,0,TAM_CONTA,.F.,cMascara1,cSepara1,,,,,.F.) } )
					Endif
					
					If lCusto	//Se imprime custo
						If mv_par25 == 1 //Imprime Codigo Normal centro de custo
							oLancto:Cell("CUSTO"):SetBlock( { || EntidadeCTB(cArqTmp->CCUSTO,0,0,TAM_CONTA,.F.,cMascara2,cSepara2,,,,,.F.) } )
						Else
							CTT->(dbSetOrder(1))
							CTT->(MsSeek(xFilial("CTT")+cArqTmp->CCUSTO))
							cResCusto := CTT->CTT_RES
							oLancto:Cell("CUSTO"):SetBlock( { || EntidadeCTB(cResCusto,0,0,TAM_CONTA,.F.,cMascara2,cSepara2,,,,,.F.) } )
						Endif
					Endif					
					
					If oReport:nDevice == 4 .And. ! __lBlind					
						oLancto:Cell("ITEM"):SetBlock( { || EntidadeCTB(cArqTmp->ITEM,0,0,aTamItem[1],.F.,cMascara3,cSepara3,,,,,.F.) } )
					EndIf	
		
					If lCLVL //Se imprime classe de valor
						If mv_par26 == 1 //Imprime Cod. Normal Classe de Valor
							oLancto:Cell("CLVL"):SetBlock( { || EntidadeCTB(cArqTmp->CLVL,0,0,TAM_CONTA,.F.,cMascara4,cSepara4,,,,,.F.) } )
						Else
							CTH->(dbSetOrder(1))
							CTH->(MsSeek(xFilial("CTH")+cArqTmp->CLVL))
							cResClVl := CTH->CTH_RES
							oLancto:Cell("CLVL"):SetBlock( { || EntidadeCTB(cResClVl,0,0,TAM_CONTA,.F.,cMascara4,cSepara4,,,,,.F.) } )
						EndIf
					Endif
                            
					nSldATransp := nSaldoAtu // Valor a Transportar - 1
                                                                       
					// Sinal do Saldo Atual => Consulta Razao
					If lIsRedStor
						oLancto:Cell("TPSLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lIsRedStor,cNormalIT,cNormal),,,,,,lPrintZero,.F.) })
					Else
						oLancto:Cell("TPSLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) }) 
					EndIF

					oLancto:PrintLine()  //Imprime as Datas

					nSldDTransp := nSaldoAtu // Valor de Transporte - 2

					ImpCompl(oReport)

				    lTotConta	:= ! Empty(cArqTmp->CONTA)
					dDataAnt	:= cArqTmp->DATAL		

					cArqTmp->(dbSkip())
				
				EndDo
				
				If lTotConta .And. mv_par11 == 1	// Totaliza tb por Conta
					oTotais:Cell("TOT"):ShowHeader()
					oTotais:Cell("TOT"):SetTitle(STR0020)	//"T o t a i s  d a  C o n t a  ==> "
					oTotais:Cell("TOT_DEBITO"):SetBlock(	{ || ValorCTB(nTotCtaDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
					oTotais:Cell("TOT_CREDITO"):SetBlock(	{ || ValorCTB(nTotCtaCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
					
					// Imprime totalizado
					oTotais:Init()
					oTotais:PrintLine()
					oTotais:Finish()
					
					nTotCtaDeb := 0
					nTotCtaCrd := 0   
				EndIf	

			Else
				
				oLancto:Init()    
			
				If ! Empty(cArqTmp->CONTA)
					CT1->(dbSetOrder(1))
					CT1->(dbSeek(xFilial()+cArqTmp->CONTA))
					cCodRes := CT1->CT1_RES
					cNormal := CT1->CT1_NORMAL
				Else
					cNormal := ""
				Endif
						
				Do While cArqTmp->( ! EoF() .And. dDataAnt == cArqTmp->DATAL .And. cItemAnt == cArqTmp->ITEM ) .And. !oReport:Cancel()
					If oReport:Cancel()
						Exit
					EndIf					
					oReport:IncMeter() 
					nVlrDeb	+= cArqTmp->LANCDEB		                                         
					nVlrCrd	+= cArqTmp->LANCCRD		                                         
					cArqTmp->(dbSkip())
				EndDo		   
				
				If lIsRedStor
					nSaldoAtu := nSaldoAtu - nVlrDeb + nVlrCrd
				Else
					nSaldoAtu := Round(NoRound(nSaldoAtu - nVlrDeb + nVlrCrd,nDecimais+1),nDecimais)
				EndIF
				
				oLancto:Cell("DATAL"):SetBlock( { || dDataAnt } )
				oLancto:Cell("LANCDEB"	):SetBlock( { || ValorCTB(nVlrDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) })// Debito
				oLancto:Cell("LANCCRD"	):SetBlock( { || ValorCTB(nVlrCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) })// Credito
				if lIsRedStor
					oLancto:Cell("TPSLDATU"	):SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lIsRedStor,cNormalIT,cNormal),,,,,,lPrintZero,.F.) })// Sinal do Saldo Atual => Consulta Razao
				Else
					oLancto:Cell("TPSLDATU"	):SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) })// Sinal do Saldo Atual => Consulta Razao
				EndIF

				nSldATransp := nSaldoAtu // Valor a Transportar  (nSld-A-Transp)

				oLancto:PrintLine()
				
				nSldDTransp := nSaldoAtu // Valor de Transporte (nSld-D-Transp)

				nTotDeb	+= nVlrDeb
				nTotCrd	+= nVlrCrd         
				nVlrDeb	:= 0
				nVlrCrd	:= 0
				
			EndIf

		EndDo      

		oLancto:Finish()

		// Inicio da 3a secao - Totais da Conta  
		cItem := "( "
		If mv_par24 == 1 // Se imprime cod. normal de Centro de Custo
			cItem += EntidadeCTB(cItemAnt,0,0,nTamItem,.F.,cMascara3,cSepara3,,,,,.F.)
		Else
			CTD->(dbSetOrder(1))
			CTD->(MsSeek(xFilial()+cItemAnt))
			cResItem := CTD->CTD_RES
			cItem += EntidadeCTB(cResItem,0,0,nTamItem,.F.,cMascara3,cSepara3,,,,,.F.)
		Endif
		cItem +=" )"
			
		//"T o t a i s " 
		oTotais:Cell("TOT"			):SetTitle(STR0017+ Upper(Alltrim(cSayItem)) + " ==> "+cItem)
		oTotais:Cell("TOT_DEBITO"	):SetBlock(	{ || ValorCTB(nTotDeb  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
		oTotais:Cell("TOT_CREDITO" 	):SetBlock(	{ || ValorCTB(nTotCrd  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
		if lIsRedStor
			oTotais:Cell("TOT_ATU"		):SetBlock(	{ || ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lIsRedStor,cNormalIT,cNormal),,,,,,lPrintZero,.F.) } )
		Else
			oTotais:Cell("TOT_ATU"		):SetBlock(	{ || ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) } )
		EndIF
		
		oTotais:Init()			// Imprime totalizado
		oTotais:PrintLine()
		oTotais:Finish()		// Fim da 3a secao - Totais da Conta 
		
		oReport:SkipLine()
		If lSaltaPg             // Salta Pagina Por Item
			oReport:EndPage()
		Endif
	EndDo
	
EndIf

cFilAnt := cFilOld
oItem:Finish()   

// Inicializa PageFooter e OnPageBreak para evitar quebra de pagina desnecessaria
oReport:SetPageFooter(0,{||.T.})
oReport:OnPageBreak({||.T.})

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()

dbselectArea("CT2")

Return

      
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpCompl  ºAutor  ³Gustavo Henrique    º Data ³  12/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Retorna a descricao, da conta contabil, item, centro de     º±±
±±º          ³custo ou classe valor                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³EXPO1 - Objeto do relatorio TReport.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR390                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpCompl(oReport)
	
Local oCompl := oReport:Section(4)

oCompl:Cell("COMP"):SetBlock({|| Space(15)+CT2->CT2_LINHA,Subs(CT2->CT2_HIST,1,40) } )

// Procura pelo complemento de historico
dbSelectArea("CT2")
dbSetOrder(10)
If MsSeek(xFilial("CT2")+cArqTMP->(DTOS(DATAL)+LOTE+SUBLOTE+DOC+SEQLAN+EMPORI+FILORI),.F.)
	//MsSeek(xFilial("CT2")+cArqTMP->(DTOS(DATAL)+LOTE+SUBLOTE+DOC+SEQLAN),.F.)
	dbSkip()
	If CT2->CT2_DC == "4"			//// TRATAMENTO PARA IMPRESSAO DAS CONTINUACOES DE HISTORICO
		oCompl:Init()
		Do While !	CT2->(Eof()) .And.;
					CT2->CT2_FILIAL == xFilial("CT2") 		.And.;
					CT2->CT2_LOTE   == cArqTMP->LOTE		.And.;
					CT2->CT2_SBLOTE == cArqTMP->SUBLOTE		.And.;
					CT2->CT2_DOC    == cArqTmp->DOC 		.And.;
					CT2->CT2_SEQLAN == cArqTmp->SEQLAN	 	.And.;
					CT2->CT2_EMPORI == cArqTmp->EMPORI		.And.;
					CT2->CT2_FILORI == cArqTmp->FILORI 		.And.;
					CT2->CT2_DC     == "4" 					.And.;
				 	DTOS(CT2->CT2_DATA) == DTOS(cArqTmp->DATAL)
			oCompl:Printline()
			CT2->(dbSkip())
		EndDo
		oCompl:Finish()
	EndIf
EndIf

dbSelectArea("cArqTmp")
    
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f440Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR440                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Ctbr480Fil(lNoMov,aSaldo,dDataIni)

Local lOk := .F.

If !lNoMov //Se imprime conta sem movimento
	If aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0 
		lOk := .T.
	Endif	
Endif             

If lNoMov .And. aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0 
	If CtbExDtFim("CTD")
		CTD->(dbSetOrder(1))
		If CTD->(MsSeek(xFilial()+cArqTmp->ITEM))
			lOk := !CtbVlDtFim("CTD",dDataIni)
	    EndIf
	EndIf
EndIf

Return( lOk )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ctr480Nor   ºAutor  ³TOTVS 			    º Data ³  14/07/21º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Verifica as condições normais do range de contas           º±±
±±º          ³ Retorna .T. caso tenha somente uma condição normal no rangeº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR480                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
				
Static function Ctr480Nor(aSelFil) 
	Local lRet 			:= .F.
	Local aArea			:= GetArea()
	Local cNextAlias	:= GetNextAlias()
	Local cQuery 		:= ''
	Local cSelFilial	:= ''
	Local nX 			:= 0
	Local cFilialAnt    := cFilAnt


	If __oQueryCont == Nil
		cQuery := " SELECT COUNT(DISTINCT(CT1_NORMAL)) QTD FROM " + RetSQLName("CT1")+" CT1 "+;
					"WHERE CT1_FILIAL IN ( ? ) AND CT1_CONTA >= ? AND CT1_CONTA <= ? AND "+;
						"D_E_L_E_T_ = ' ' "
		__oQueryCont := FWPreparedStatement():New(cQuery)
	EndIf
	If Len( aSelFil ) > 1 
		For nX := 1 To Len(aSelFil)
			cFilAnt := aSelFil[nx]
			cSelFilial += "'"+ xFilial( "CT1" ) + "'"	 
			If nX < Len(aSelFil)
				cSelFilial += ','
			EndIf
		Next
		__oQueryCont:SetNumeric(1, cSelFilial  ) 			// P1 xFilial( "Ct1" )
	Else
		__oQueryCont:SetString(1, xFilial( "CT1" )  )  		// P1 xFilial( "Ct1" )
	EndIf	
	__oQueryCont:SetString(2, mv_par12 )  		// P2 Conta Inicial				
	__oQueryCont:SetString(3, mv_par13  )  		// P3 Conta Final	

	cNextAlias := MPSYSOpenQuery(__oQueryCont:GetFixQuery(),cNextAlias)
	DbSelectArea(cNextAlias)

	lRet	:=	 ( QTD < 2)
	(cNextAlias)->(dbCloseArea())

	cFilAnt := cFilialAnt

	RestArea(aArea)

return lRet
