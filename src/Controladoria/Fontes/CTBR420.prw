/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR420.Ch"
#Include "PROTHEUS.Ch"
 
#DEFINE TAM_VALOR	16
#DEFINE TAM_CONTA  17
//AMARRACAO DE PACOTE
Static nTamCT2Key := 100 // JA EXITIA PARA RELESE 3 e SERA UTILIZADA NO RELESE 4
Static lFWCodFil := .T.
Static _oCTBR4201

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR420  ³ Autor ³ Cicero J. Silva   	³ Data ³ 04.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o do Raz„o de Documentos Fiscais                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_CTBR420()    											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 		 ³ SIGACTB      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CTBR420( cContaIni, cContaFim, dDataIni, dDataFim, cMoeda, cSaldo, cBook,;
				   nDocBranco,lSaltLin,aSelFil)

Local aArea := GetArea()
Local aCtbMoeda		:= {}

Local lOk := .T.
Local lExterno		:= cContaIni <> Nil

DEFAULT lSaltLin	:= .T.
DEFAULT aSelFil := {}

PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR420"
PRIVATE nomeProg  	:= "CTBR420"  
PRIVATE nSldATransp	:= 0 // Esta variavel eh utilizada para calcular o valor de transporte
PRIVATE nSldDTransp	:= 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // da conta                              ³
//³ mv_par02            // ate a conta                           ³
//³ mv_par03            // da data                               ³
//³ mv_par04            // Ate a data                            ³
//³ mv_par05            // Moeda			                     ³   
//³ mv_par06            // Saldos		                         ³   
//³ mv_par07            // Set Of Books                          ³
//³ mv_par08            // Imprime conta sem movimento?          ³
//³ mv_par09            // Imprime Cod (Normal / Reduzida)       ³
//³ mv_par10            // Salto de pagina                       ³
//³ mv_par11            // Pagina Inicial                        ³
//³ mv_par12            // Pagina Final                          ³
//³ mv_par13            // Numero da Pag p/ Reiniciar            ³	   
//³ mv_par14            // Imprime Total Geral (Sim/Nao)         ³
//³ mv_par15            // So Livro/Livro e Termos/So Termos     ³
//³ mv_par16            // Imprime Doc. Fiscal em Branco(Sim/Nao)³ 
//³ mv_par17            // Imprime Valor 0.00						  ³
//³ mv_par18            // Salta linha entre contas? 			     ³
//³ mv_par19            // Seleciona filiais? 			           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	lOk := .F.
EndIf

If lOk
	If !lExterno
		If !Pergunte("CTR420", .T. )
			lOk := .F.
		Endif
	Else
		Pergunte("CTR420", .F. )	
	Endif
Endif

// Se aFil nao foi enviada, exibe tela para selecao das filiais
If lOk .And. mv_par19 == 1 .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		lOk := .F.
	EndIf 
EndIf   

//Verifica se o relatorio foi chamado a partir de outro programa. Ex. CTBC400
If lExterno //Caso seja externo, atualiza os parametros do relatorio com os dados passados como parametros.
	mv_par01 := cContaIni
	mv_par02 := cContaFim
	mv_par03 := dDataIni
	mv_par04 := dDataFim
	mv_par05 := cMoeda
	mv_par06 := cSaldo
	mv_par07 := cBook
	mv_par16 := nDocBranco
	mv_par18 := If(lSaltLin==.T.,1,2)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par07) // Set Of Books
	lOk := .F.
EndIf 

If lOk
	aCtbMoeda  	:= CtbMoeda(mv_par05) // Moeda?
   If Empty(aCtbMoeda[1])
      Help(" ",1,"NOMOEDA")
      lOk := .F.
   Endif
Endif 

If lOk
	CTBR420R4(aCtbMoeda,aSelFil)
EndIf          

If Select("cArqTmp") > 0
	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()

	//Deleta tabela temporaria do banco de dados
	If _oCTBR4201 <> Nil
		_oCTBR4201:Delete()
		_oCTBR4201 := Nil
	Endif

EndIf	

RestArea(aArea)
Return 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR420R4  ºAutor  ³Microsiga           º Data ³  16/09/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Realiza a impresão do relatorio em R4                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CTBR420R4(aCtbMoeda,aSelFil)
Local oReport := Nil                   

oReport := ReportDef(aCtbMoeda,aSelFil)
oReport:PrintDialog()
oReport := Nil                        

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Cicero J. Silva    º Data ³  01/08/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ aCtbMoeda  - Matriz ref. a moeda                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef(aCtbMoeda,aSelFil,cDescMoeda)

Local oReport
Local oSection1
Local oSection2 
Local oSection3 
Local oSection4 
Local oSection5 

Local cDesc1		:= STR0001	//"Este programa ir   imprimir o  Raz„o Contabil dos lancamentos"
Local cDesc2		:= STR0002	//"contab. aglutinados por contas/documentos fiscais de acordo   "
Local cDesc3		:= STR0003	//"com os parametros configurados pelo usuario"
Local titulo		:= STR0006 	//"Emissao do Razao Aglut. por contas/doc.fiscais"

Local aTamConta	:= TAMSX3("CT1_CONTA")
Local nTamConta		:= TamSX3("CT1_DESC01")[1]
Local nTamHist		:= Len(CriaVar("CT2_HIST"))

// Se for Diario Geral por Docto. Fiscal (CTBR112) e o tamanho de CT1_CONTA for maior que 50, considerar apenas 
//	70 caracteres de CT2_KEY, para nao ultrapassar o limite de caracteres permitidos para o indice do temporario.
Local nTamCT2Key 	:= IIf (aTamConta[1] > 50,70,100)

Local lSalLin		:= IIf(mv_par18==1,.T.,.F.)//"Salta linha entre contas?"
Local lPrintZero	:= IIf(mv_par17==1,.T.,.F.)// Imprime valor 0.00    ?
Local lSalto		:= IIf(mv_par10==1,.T.,.F.)// Salto de pagina                       ³

Local aSetOfBook	:= CTBSetOf(mv_par07)// Set Of Books	
Local cPicture 	:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par05)// Moeda
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty

If !lIsRedStor  .and. aCtbMoeda = Nil 
	aCtbMoeda  	:= CtbMoeda(mv_par05) // Moeda?
	cDescMoeda 	:= aCtbMoeda[2]
Else
	cDescMoeda 	:= aCtbMoeda[2]
Endif

oReport := TReport():New(nomeProg,titulo,"CTR420", {|oReport| ;
			ReportPrint(oReport,aCtbMoeda,aSetOfBook,cPicture,cDescMoeda,nDecimais,nTamConta,aSelFil)},cDesc1+cDesc2+cDesc3)
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)
oReport:SetLandScape(.T.)

// oSection1
oSection1 := TRSection():New(oReport,STR0022,{"cArqTmp","CT1"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)	//"Conta" 

	If lSalto
		oSection1:SetPageBreak(.T.)
	EndIf

	TRCell():New(oSection1,"CONTA"	,"cArqTmp",Upper(STR0022),/*Picture*/,aTamConta[1]		,/*lPixel*/,/*{|| }*/)	//"CONTA"
	TRCell():New(oSection1,"DESCCC"	,"cArqTmp",STR0023,/*Picture*/,nTamConta			,/*lPixel*/,/*{|| }*/)	//"DESCRICAO"

	oSection1:OnPrintLine( {|| IIf(lSalLin,oReport:SkipLine(),NIL) } )

// oSection2
oSection2 := TRSection():New(oReport,STR0024,{"cArqTmp"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/,,,,,,,,,,.F. /*AutoSize*/)		//"Lançamentos Contábeis"
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderPage(.T.)      

	TRCell():New(oSection2,"DATAL"		,"cArqTmp",STR0025,/*Picture*/,10			,/*lPixel*/,/*{|| }*/)// "DATA"
	TRCell():New(oSection2,"DOCUMENTO"	,""       ,STR0026,/*Picture*/,22	,/*lPixel*/,{|| cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA })// "LOTE/SUB/DOC/LINHA"
	TRCell():New(oSection2,"HISTORICO"	,"cArqTmp",STR0027,/*Picture*/,30	,/*lPixel*/,{|| Subs(cArqTmp->HISTORICO,1,30)})// "HISTORICO"	
	TRCell():New(oSection2,"CT2KEY"		,"cArqTmp",STR0028,/*Picture*/,50	,/*lPixel*/,/*{|| Subs(cArqTmp->CT2KEY,1,50) }*/,,.T. /*Quebra Linha*/)	//"DOC.FISCAL"
	TRCell():New(oSection2,"LANCDEB"	,"cArqTmp",STR0029,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->LANCDEB,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },/*"RIGHT"*/,,"RIGHT")// "DEBITO"
	TRCell():New(oSection2,"LANCCRD"	,"cArqTmp",STR0030,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->LANCCRD,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },/*"RIGHT"*/,,"RIGHT")// "CREDITO"
	TRCell():New(oSection2,"TPSLDATU"	,"cArqTmp",STR0031,/*Picture*/,TAM_VALOR+2	,/*lPixel*/,/*{|| }*/,/*"RIGHT"*/,,"RIGHT")// "SALDO ATUAL"
	If cPaisLoc $ "CHI|ARG"
		TRCell():New(oSection2,"SEGOFI"	,"cArqTmp","SEGOFI"		,/*Picture*/,TamSx3("CT2_SEGOFI")[1],/*lPixel*/,{|| cArqTmp->CORRELATO })
		oSection2:Cell("SEGOFI"):lHeaderSize := .F.
	EndIf    
	
oSection2:Cell("DATAL"):lHeaderSize     := .F.
oSection2:Cell("DOCUMENTO"):lHeaderSize := .F.
oSection2:Cell("HISTORICO"):lHeaderSize := .F.
oSection2:Cell("CT2KEY"):lHeaderSize    := .F.
oSection2:Cell("LANCDEB"):lHeaderSize   := .F.
oSection2:Cell("LANCCRD"):lHeaderSize   := .F.
oSection2:Cell("TPSLDATU"):lHeaderSize  := .F.   
 
// oSection3 - Totais das sessoes	
oSection3 := TRSection():New( oReport,STR0032,,, .F.,.F.,,,,,,,,,,.F. /*AutoSize*/ )	//"Totais"
	TRCell():New(oSection3,"TOT",""			,STR0023,/*Picture*/, 115 ,/*lPixel*/,/*{|| code-block de impressao }*/)	//"DESCRICAO"
	TRCell():New(oSection3,"TOT_DEBITO"	,""	,STR0029,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"RIGHT")	//"DEBITO"
	TRCell():New(oSection3,"TOT_CREDITO",""	,STR0030,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"RIGHT")	//"CREDITO"
	TRCell():New(oSection3,"TOT_ATU",""		,STR0031,/*Picture*/,TAM_VALOR+2,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"RIGHT")	//"SALDO ATUAL"
	oSection3:Cell("TOT_DEBITO"	):HideHeader() 
	oSection3:Cell("TOT_CREDITO"):HideHeader() 
	oSection3:Cell("TOT_ATU"):HideHeader()   
	
oSection3:Cell("TOT"):lHeaderSize			:= .F.
oSection3:Cell("TOT_DEBITO"):lHeaderSize	:= .F.
oSection3:Cell("TOT_CREDITO"):lHeaderSize	:= .F.
oSection3:Cell("TOT_ATU"):lHeaderSize		:= .F.

// oSection4 - Complemento
oSection4 := TRSection():New( oReport,STR0033,,, .F., .F. )	//"Complemento"
	TRCell():New(oSection4,"COMP","",Upper(STR0033),/*Picture*/,18+nTamHist+nTamCT2Key,/*lPixel*/,/*{|| code-block de impressao }*/)
	oSection4:Cell("COMP"):HideHeader()
               
oReport:ParamReadOnly()          

// oSection5 - Transporte	
oSection5 := TRSection():New( oReport,"Transporte",,, .F., .F. )	// Total
TRCell():New(oSection5,"CTRANSP"	,"" ,		 ,/*Picture*/ , 117 + (TAM_VALOR * 2),/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,/*"RIGHT"*/,,,)
TRCell():New(oSection5,"TVLTRANSP"	,"" ,		 ,/*Picture*/ ,TAM_VALOR+2,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"RIGHT")	// "SALDO ATUAL"

oSection5:Cell("TVLTRANSP"):lHeaderSize	:= .F.
oSection5:SetHeaderSection(.F.) 

TRPosition():New( oSection2, "CT1", 1,{|| xFilial("CT1")+cArqTmp->CONTA } )  

oSection1:SetEdit(.F.)
oSection2:SetEdit(.F.)
oSection3:SetEdit(.F.)
oSection4:SetEdit(.F.)
oSection5:SetEdit(.F.)

Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintº Autor ³ Cicero J. Silva    º Data ³  14/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,aCtbMoeda,aSetOfBook,cPicture,cDescMoeda,nDecimais,nTamConta,aSelFil)

Local oSection1 	:= oReport:Section(1)
Local oSection2		:= oReport:Section(2)
Local oSection3		:= oReport:Section(3)   
Local oSection5		:= oReport:Section(5)

Local cFiltCT1		:= oSection1:GetAdvplExp()
Local cArqTmp		:= ""

Local aSaldo		:= {}
Local aSaldoAnt		:= {}
Local cFil := ""

Local cContaIni		:= mv_par01 // da conta
Local cContaFIm		:= mv_par02 // ate a conta 
Local cMoeda		:= mv_par05 // Moeda
Local cSaldo		:= mv_par06 // Saldos
Local cContaAnt		:= ""
Local cDescConta	:= ""

Local cCodRes		:= ""
Local cDescSint		:= ""
Local cContaSint	:= ""

Local cConta		:= ""

Local cSepara		:= ""
Local cMascara		:= IIf (Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSepara) )	// Mascara da Conta

Local dDataAnt		:= CTOD("  /  /  ")
Local dDataIni		:= mv_par03 // da data
Local dDataFim		:= mv_par04 // Ate a data

Local nPagIni		:= mv_par11 // Pagina Inicial 
Local nReinicia 	:= mv_par13 // Numero da Pag p/ Reiniciar 
Local nPagFim		:= mv_par12 // Pagina Final 

Local nCont			:= 0
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nTotGerDeb	:= 0
Local nTotGerCrd	:= 0

Local lNoMov		:= Iif(mv_par08==1,.T.,.F.) // Imprime conta sem movimento?
Local lPrintZero	:= Iif(mv_par17==1,.T.,.F.) // Imprime valor 0.00    ?
Local lImpDoc0		:= Iif(mv_par16 == 1,.T.,.F.)
Local lImpLivro		:= .T.
Local lImpTermos	:= .F. 

Local nSldTransp	:= 0  
Local cNormal		:= ""

Local cArq
Local nX 
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Termo / Livro                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case mv_par15==1 ; lImpLivro:=.t. ; lImpTermos:=.f.
	Case mv_par15==2 ; lImpLivro:=.t. ; lImpTermos:=.t.
	Case mv_par15==3 ; lImpLivro:=.f. ; lImpTermos:=.t.
EndCase		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Titulo do Relatorio                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("NewHead")== "U"
	Titulo	:=	STR0007	//"RAZAO EM "
	Titulo += 	cDescMoeda + STR0008 + DTOC(dDataIni) +;	// "DE"
				STR0009 + DTOC(dDataFim) + CtbTitSaldo(mv_par06)	// "ATE"
Else
	Titulo := NewHead
EndIf

oReport:SetTitle(Titulo)
oReport:SetPageNumber(mv_par11) //mv_par11	-	Pagina Inicial
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )

If lImpLivro
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao   					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				U_CTBR420Raz(	oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,;
								cMoeda,dDataIni,dDataFim,aSetOfBook,lNoMov,cSaldo,"1",,,,,,,,cFiltCT1,aSelFil)},;
				 STR0014,;		// "Criando Arquivo Tempor rio..."
				 STR0006)		// "Emissao do Razao"
		
	dbSelectArea("cArqTmp")
	dbGoTop()
	oReport:SetMeter( RecCount() )      
	oReport:NoUserFilter()
Endif


//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If lImpLivro
	If !(cArqTmp->(RecCount()) == 0 .And. !Empty(aSetOfBook[5]))
		While lImpLivro .And. !cArqTmp->(Eof() .And. !oReport:Cancel())
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³INICIO DA 1a SECAO             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		    If oReport:Cancel()
		    	Exit
		    EndIf        

			If !lImpDoc0 .And. Empty(cArqTmp->CT2KEY) 
				dbSkip()
				Loop
			Endif	

			aSaldoAnt 	:= SaldoCT7Fil(cArqTmp->CONTA,dDataIni,cMoeda,cSaldo,"CTBR400",,,aSelFil)
			aSaldo 		:= SaldoCT7Fil(cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo,,,,aSelFil)

			If f180Fil(lNoMov,aSaldo,lImpDoc0)
				dbSkip()
				Loop
			EndIf
		   
			nSaldoAtu:= 0
			nTotDeb	:= 0
			nTotCrd	:= 0                              

			// Conta Sintetica	
			
			cContaSint := Ctr400Sint(cArqTmp->CONTA,@cDescSint,cMoeda,@cDescConta,@cCodRes)
			cNormal := CT1->CT1_NORMAL
			
			oSection1:Cell("CONTA" ):SetBlock( { || EntidadeCTB(cContaSint,0,0,nTamConta,.F.,cMascara,cSepara,,,,,.F.) } )
			oSection1:Cell("DESCCC"):SetBlock( { || cDescSint } )     
			
			oSection5:Cell("CTRANSP"):SetBlock( { || Iif(oReport:PageBreak(),STR0018,STR0017) } )	
			oSection5:Cell("TVLTRANSP"):SetBlock( { || ValorCTB(nSldTransp,,,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) } )


			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³INICIO DA IMPRESSAO DA 1A SECAO³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    	 	oSection1:Init()       
		   	oSection1:PrintLine()
		    oSection1:Finish()        

			// Conta Analitica
			cConta := STR0012 //"CONTA - "	

			If mv_par09 == 1							// Imprime Cod Normal
				cConta += AllTrim(EntidadeCTB(cArqTmp->CONTA,0,0,nTamConta,.F.,cMascara,cSepara,,,,,.F.))
			Else
				cConta += AllTrim(EntidadeCTB(cCodRes,0,0,nTamConta,.F.,cMascara,cSepara,,,,,.F.))
			Endif

			cConta +=  " - " + cDescConta	     
			
			// A TRANSPORTAR :  	
		    oReport:SetPageFooter(10, {|| Iif(nSldTransp != 0, (oSection5:Init(),oSection5:PrintLine()),) } ) // A TRANSPORTAR

			//"DE TRANSPORTE : "    
			oReport:OnPageBreak( {|| Iif(nSldTransp != 0, (oSection5:printline(),oReport:SkipLine(),oSection5:Finish()),) } )      // DE TRANSPORTE

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Impressao do Saldo Anterior do Centro de Custo³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oReport:PrintText(cConta + "SALDO ANTERIOR: " + ValorCTB(aSaldoAnt[6],,,TAM_VALOR,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.) ) //"SALDO ANTERIOR: "

			nSaldoAtu := aSaldoAnt[6]  
			nSldTransp := nSaldoAtu                                         
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³FIM DA 1a SECAO³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³INICIO DA 2a SECAO³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("cArqTmp")
			cContaAnt:= cArqTmp->CONTA
			dDataAnt	:= CTOD("  /  /  ")

			oSection2:Init()                            
			
			While cArqTmp->(!Eof()) .And. cArqTmp->CONTA == cContaAnt .And. !oReport:Cancel()
                                                  
				If oReport:Cancel()
					Exit
				EndIf	

				If !lImpDoc0 .And. Empty(cArqTmp->CT2KEY) 
					dbSkip()
					Loop
				Endif	

				If dDataAnt <> cArqTmp->DATAL 
					If (cArqTmp->LANCDEB <> 0 .Or. cArqTmp->LANCCRD <> 0)
						oSection2:Cell("DATAL"):SetBlock( { || dDataAnt } )
					Endif	
					dDataAnt := cArqTmp->DATAL    
				EndIf	
   					
   				nSaldoAtu 	:= nSaldoAtu - cArqTmp->LANCDEB + cArqTmp->LANCCRD 
   				
				nTotDeb		+= cArqTmp->LANCDEB
				nTotCrd		+= cArqTmp->LANCCRD
				nTotGerDeb	+= cArqTmp->LANCDEB
				nTotGerCrd	+= cArqTmp->LANCCRD			

				oSection2:Cell("TPSLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) } )

				nSldATransp := nSaldoAtu // Valor a Transportar

				oSection2:PrintLine() 
   				nSldTransp	:= nSaldoAtu
				oReport:IncMeter()

				nSldDTransp := nSaldoAtu // Valor de Transporte

				// Procura complemento de historico e imprime
				ImpCompl(oReport)
			        
				dbSkip()
			
			EndDo //cArqTmp->(!Eof()) .And. cArqTmp->CONTA == cContaAnt
   				oSection2:Finish()        
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³FIM DA 2a SECAO³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³INICIO DA 3a SECAO - Totais da Conta ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oSection3:Cell("TOT"):SetTitle(OemToAnsi(STR0016))//"T o t a i s  d a  C o n t a  ==> " 	    
			oSection3:Cell("TOT_DEBITO"	):SetBlock(	{ || ValorCTB(nTotDeb  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
			oSection3:Cell("TOT_CREDITO" ):SetBlock(	{ || ValorCTB(nTotCrd  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
			oSection3:Cell("TOT_ATU"	):SetBlock(		{ || ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) } )

			// Imprime totalizado

   			oSection3:Init() // oSection3 - Totalizadora   
			oSection3:PrintLine()         
			nSldTransp := 0
			oSection3:Finish()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³FIM DA 3a SECAO - Totais da Conta³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		EndDo //lImpLivro .And. !cArqTmp->(Eof())

		cArqTmp->(dbGoTop())

		If !oReport:Cancel() .And. lImpLivro .And. mv_par14 == 1 .And. cArqTmp->(!EoF())  //Imprime total Geral
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³INICIO DA 3a SECAO - Total Geral     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oSection3:Cell("TOT"):SetTitle(OemToAnsi(STR0019))//"T O T A L  G E R A L  ==> "
			oSection3:Cell("TOT_DEBITO"  ):SetBlock(	{ || ValorCTB(nTotGerDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
			oSection3:Cell("TOT_CREDITO" ):SetBlock(	{ || ValorCTB(nTotGerCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
			oSection3:Cell("TOT_ATU"):Hide()			
			// Imprime totalizado
			oSection3:Init()   
			oSection3:PrintLine()
			oSection3:Finish()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³FIM DA 3a SECAO - Total Geral    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		Endif

	EndIf //!(cArqTmp->(RecCount()) == 0 .And. !Empty(aSetOfBook[5]))
EndIf // lImpLivro

If ! oReport:Cancel()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao dos Termos ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lImpTermos 							// Impressao dos Termos
		
		oSection2:SetHeaderPage(.F.) // Desabilita a impressao 
		
		cArqAbert:=GetNewPar("MV_LRAZABE","")
		cArqEncer:=GetNewPar("MV_LRAZENC","")
		
	    If Empty(cArqAbert)
			ApMsgAlert(	"Devem ser criados os parametros MV_LRAZABE e MV_LRAZENC. " +;
						"Utilize como base o parametro MV_LDIARAB.")
		Endif
	Endif
	
	If lImpTermos .And. ! Empty(cArqAbert)	
		dbSelectArea("SM0")
		aVariaveis:={}
	
		For nCont :=1 to FCount()	
			If FieldName(nCont)=="M0_CGC"
				AADD(aVariaveis,{FieldName(nCont),Transform(FieldGet(nCont),"@R! NN.NNN.NNN/NNNN-99")})
			Else
	            If FieldName(nCont)=="M0_NOME"
	                Loop
	            EndIf
				AADD(aVariaveis,{FieldName(nCont),FieldGet(nCont)})
			Endif
		Next
	
		dbSelectArea("SX1")
		dbSeek(Padr( "CTR400", Len( X1_GRUPO ) , ' ' ) + "01")
	
		While SX1->X1_GRUPO == Padr( "CTR400", Len( X1_GRUPO ) , ' ' )
			AADD(aVariaveis,{Rtrim(Upper(X1_VAR01)),&(X1_VAR01)})
			dbSkip()
		End
	
		If !File(cArqAbert)
			aSavSet:=__SetSets()
			cArqAbert:=CFGX024(,"Razão") // Editor de Termos de Livros
			__SetSets(aSavSet)
			Set(24,Set(24),.t.)
		Endif
	
		If !File(cArqEncer)
			aSavSet:=__SetSets()
			cArqEncer:=CFGX024(,"Razão") // Editor de Termos de Livros
			__SetSets(aSavSet)
			Set(24,Set(24),.t.)
		Endif
	
		If cArqAbert#NIL
			oReport:EndPage()
			ImpTerm2(cArqAbert,aVariaveis,,,,oReport)
		Endif
		If cArqEncer#NIL
			oReport:EndPage()
			ImpTerm2(cArqEncer,aVariaveis,,,,oReport)
		Endif	 
	Endif
EndIf
		
If lImpLivro
	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()

	If _oCTBR4201 <> Nil
		_oCTBR4201:Delete()
		_oCTBR4201 := Nil
	Endif

Endif

dbselectArea("CT2")
  
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpCompl  ºAutor  ³Cicero J. Silva     º Data ³  27/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a descricao, da conta contabil, item, centro de     º±±
±±º          ³custo ou classe valor                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR390                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ImpCompl(oReport)
	
	Local oSection4 := oReport:Section(4)

	oSection4:Cell("COMP"):SetBlock({|| Space(15)+CT2->CT2_LINHA,Subs(CT2->CT2_HIST,1,40) } )
	
	// Procura pelo complemento de historico
	dbSelectArea("CT2")
	dbSetOrder(10)
	If MsSeek(xFilial("CT2")+cArqTMP->(DTOS(DATAL)+LOTE+SUBLOTE+DOC+SEQLAN+EMPORI+FILORI),.F.)
		dbSkip()
		If CT2->CT2_DC == "4"			//// TRATAMENTO PARA IMPRESSAO DAS CONTINUACOES DE HISTORICO
			While !CT2->(Eof()) .And.;
					CT2->CT2_FILIAL == xFilial("CT2") .And.;
					 CT2->CT2_LOTE == cArqTMP->LOTE .And.;
					  CT2->CT2_SBLOTE == cArqTMP->SUBLOTE .And.;
					   CT2->CT2_DOC == cArqTmp->DOC .And.;
						CT2->CT2_SEQLAN == cArqTmp->SEQLAN .And.;
						 CT2->CT2_EMPORI == cArqTmp->EMPORI .And.;
						  CT2->CT2_FILORI == cArqTmp->FILORI .And.;
						   CT2->CT2_DC == "4" .And.;
				    	    DTOS(CT2->CT2_DATA) == DTOS(cArqTmp->DATAL)
			

				oSection4:Printline()
				CT2->(dbSkip())
			
			EndDo	
		EndIf
	EndIf                  

	oSection4:Finish()

	dbSelectArea("cArqTmp")
   
Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f180Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR420                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function f180Fil(lNoMov,aSaldo,lImpDoc0)

Local lDeixa	:= .F.

	If !lNoMov //Se imprime conta sem movimento
		If aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0 
			lDeixa	:= .T.
		Endif	
	Endif             

Return (lDeixa)


//-------------------------------------------------------------------
/*{Protheus.doc} Ctbr420Raz
Consulta do plano de contas em formato de TREE e os saldos 

@author Alvaro Camillo Neto

@param oMeter      Objeto oMeter                                  
@param oText       Objeto oText                                   
@param oDlg        Objeto oDlg                                    
@param lEnd        Acao do Codeblock                              
@param cArqTmp     Arquivo temporario                             
@param cContaIni   Conta Inicial                                  
@param cContaFim   Conta Final                                    
@param cMoeda      Moeda                                          
@param dDataIni    Data Inicial                                   
@param dDataFim    Data Final                                     
@param aSetOfBook  Matriz aSetOfBook								
@param lNoMov      Indica se imprime movimento zerado ou nao.     
@param cSaldo      Tipo de Saldo                                  

   
@version P12
@since   20/02/2014
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------

User Function Ctbr420Raz(oMeter,oText,oDlg,lEnd,cArqTmp,cContaIni,cContaFim,cMoeda,;
					dDataIni,dDataFim,aSetOfBook,lNoMov,cSaldo,cTpRel,lAnalitico,;
					cLoteIni,cLoteFim,cSbLoteIni,cSbLoteFim,cDocIni,cDocFim,cFiltCT1,aSelFil)

Local aTamConta	:= TAMSX3("CT1_CONTA")
Local aCtbMoeda	:= {}
Local aSaveArea := GetArea()
Local aCampos
Local aTamCusto	:= TAMSX3("CTT_CUSTO")         
Local aTamVal	:= TAMSX3("CT2_VALOR")
Local nTamFilial 	:= IIf( lFWCodFil, FWGETTAMFILIAL, TamSx3( "CT2_FILIAL" )[1] )
Local aChave    	:= {}
Local cMensagem	:= STR0020// O plano gerencial nao esta disponivel nesse relatorio. 
Local nDecimais	:= 0                       
Local nTamHist		:= Len(CriaVar("CT2_HIST"))
Local nTamItem		:= Len(CriaVar("CTD_ITEM"))
Local nTamCLVL		:= Len(CriaVar("CTH_CLVL"))
Local lCriaInd		:= .F.
Local lUseDocHis  := X3USADO("CTC_DOCHIS")


DEFAULT lAnalitico	:= .F.	
DEFAULT lNoMov		:= .F.
DEFAULT cLoteIni	:= ""
DEFAULT cLoteFim	:= ""
DEFAULT cSbLoteIni	:= ""
DEFAULT cSbLoteFim	:= ""
DEFAULT cDocIni		:= ""
DEFAULT cDocFim		:= ""
DEFAULT aSelFil := {}

nTamCT2Key := 70

// Retorna Decimais
aCtbMoeda := CTbMoeda(cMoeda)
nDecimais := aCtbMoeda[5]

aCampos :={	{ "CONTA"		, "C", aTamConta[1], 0 },;  		// Codigo da Conta
			{ "CONTAD"		, "C", aTamConta[1], 0 },;  		// Codigo da Conta Debito (p/rel Diario)
			{ "CONTAC"		, "C", aTamConta[1], 0 },;  		// Codigo da Conta Credito (p/rel Diario)
			{ "TIPO"       	, "C", 01			, 0 },;			// Tipo do Registro (Debito/Credito/Continuacao)
			{ "LANCDEB"		, "N", aTamVal[1]+2, nDecimais },; // Debito
			{ "LANCCRD"		, "N", aTamVal[1]+2	, nDecimais },; // Credito
			{ "SALDOSCR"	, "N", aTamVal[1]+2, nDecimais },; // Saldo
			{ "TPSLDANT"	, "C", 01, 0 },; 					// Sinal do Saldo Anterior => Consulta Razao
			{ "TPSLDATU"	, "C", 01, 0 },; 					// Sinal do Saldo Atual => Consulta Razao						
			{ "DATAL"		, "D", 10			, 0 },;			// Data do Lancamento
			{ "LOTE" 		, "C", 06			, 0 },;			// Lote
			{ "SUBLOTE" 	, "C", 03			, 0 },;			// Sub-Lote
			{ "DOC" 		, "C", 06			, 0 },;			// Documento
			{ "LINHA"		, "C", LEN(CT2->CT2_LINHA), 0 },;	// Linha  03
			{ "SEQLAN"		, "C", LEN(CT2->CT2_SEQLAN), 0 },;			// Sequencia do Lancamento  03
			{ "SEQHIST"		, "C", 03			, 0 },;			// Seq do Historico
			{ "EMPORI"		, "C", 02			, 0 },;			// Empresa Original
			{ "FILORI"		, "C", nTamFilial , 0 },;			// Filial Original
			{ "CT2KEY"   	, "C", nTamCT2Key	, 0 },;			// CHAVE DE AGLUTINACAO DOC.FISCAL.
			{ "HP"        	, "C", 03   		, 0 },;			// Codigo do Historico padrao
			{ "HISTORICO"	, "C", nTamHist   	, 0 },;			// Historico		
			{ "NOMOV"		, "L", 01			, 0 },;			// Conta Sem Movimento
			{ "GRUPO"		, "C", 44			, 0 },;			// Chave de agrupamento da Quadratura Contabil			
			{ "ALIAS"		, "C", 03			, 0 },;		    // Alias do relacionamento			
			{ "CCUSTO"		, "C", aTamCusto[1], 0 },;			// Centro de Custo
			{ "ITEM"		, "C", nTamItem		, 0 },;			// Item Contabil
			{ "CLVL"		, "C", nTamCLVL		, 0 },;			// Classe de Valor			
			{ "XPARTIDA"   	, "C", aTamConta[1] , 0 },;		// Contra Partida						
			{ "OPERACAO"	, "C", 25			, 0 },;		    // Descricao da operacao
			{ "FILIAL"		, "C", nTamFilial , 0 }}		    // Filial do Sistema
If cPaisLoc $ "CHI|ARG"
   Aadd(aCampos,{"CORRELATO","C",TamSX3("CT2_SEGOFI")[1],0})  //Numero Correlativo
EndIf
If cPaisLoc $ "ARG" .AND. lUseDocHis
	Aadd(aCampos,{"DOCHIS","C",TamSX3("CTC_DOCHIS")[1],0}) //Historico da Capa do Lote
EndIf

// Se o arquivo temporario de trabalho esta aberto
If ( Select ( "cArqTmp" ) > 0 )
	cArqTmp->(dbCloseArea())
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Regras para Indice da tabela temporaria a ser criada no banco de dados ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If cTpRel	== "1" 		//Se for Razao Conta/Doc.Fiscal
	aChave   := {"CONTA","DATAL","LOTE","SUBLOTE","DOC","CT2KEY","EMPORI","FILORI"}
ElseIf cTpRel == "2"   	//Se for Conferencia de Dig. 
	If lAnalitico	//Conta/Doc.Fiscal
		aChave   := {"DATAL","LOTE","SUBLOTE","DOC","CT2KEY","CONTA","EMPORI","FILORI"}	
	Else			//Doc.Fiscal
		aChave   := {"DATAL","LOTE","SUBLOTE","DOC","CT2KEY","EMPORI","FILORI"}	
	Endif
ElseIf cTpRel	== "3"	// Se for Relatorio de SubLote/Doc.Fiscal
	aChave  := {"SUBLOTE","DATAL","LOTE","DOC","CT2KEY","CONTA","EMPORI","FILORI"}	
ElseIf cTpRel == "4"	
	aChave  := {"DATAL","LOTE","SUBLOTE","DOC","CT2KEY","EMPORI","FILORI","TIPO","CONTAD","CONTAC","LINHA"}	
ElseIf cTpRel	== "6"	//Diario aglutinado por conta
	aChave  := {"DATAL","LOTE","SUBLOTE","DOC","EMPORI","FILORI","TIPO","CONTAD","CONTAC"}
ElseIf cTpRel	== "7" 		//Se for Razao aglutinado por Conta
	aChave  := {"CONTA","DATAL","LOTE","SUBLOTE","DOC","EMPORI","FILORI"}
Endif

If _oCTBR4201 <> Nil
	_oCTBR4201:Delete()
	_oCTBR4201 := Nil
Endif

_oCTBR4201 := FWTemporaryTable():New( "cArqTmp" )  
_oCTBR4201:SetFields(aCampos) 
_oCTBR4201:AddIndex("1", aChave)

//------------------
//Criação da tabela temporaria
//------------------
_oCTBR4201:Create()
	
dbSelectArea("cArqTmp")
dbSetOrder(1)

If !Empty(aSetOfBook[5])
	MsgAlert(cMensagem)	
	Return
EndIf

If cTpRel $ "1/3/7" .Or. (cTpRel == "2" .And. lAnalitico) 
	// Monta Arquivo para gerar o Razao ou Conf. Digitacao por Conta/Doc.Fiscal
	U_Ctbr420Flt(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cMoeda,dDataIni,dDataFim,;
				aSetOfBook,lNoMov,cSaldo,cTpRel,lAnalitico,cLoteIni,cLoteFim,;
				cSbLoteIni,cSbLoteFim,cDocIni,cDocFim,cFiltCT1,aSelFil)
ElseIf cTpRel == "2" .And. !lAnalitico
	Ctbr075Flt(oMeter,oText,oDlg,lEnd,cMoeda,dDataIni,dDataFim,cSaldo,lAnalitico,;
		cLoteIni,cLoteFim,cSbLoteIni,cSbLoteFim,cDocIni,cDocFim,cFiltCT1)
ElseIf cTpRel == "4"		
	Ctbr112Flt(oMeter,oText,oDlg,lEnd,cMoeda,dDataIni,dDataFim,cSaldo,cFiltCT1)				
ElseIf cTpRel == "6"		
	Ctbr114Flt(oMeter,oText,oDlg,lEnd,cMoeda,dDataIni,dDataFim,cSaldo,cFiltCT1)					
EndIf

RestArea(aSaveArea)

Return cArqTmp


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³Ctbr420Flt³ Autor ³ Simone Mie Sato       ³ Data ³ 04/10/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Realiza a "filtragem" dos registros do Razao                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³U_Ctbr420Flt(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,	   ³±±
±±³			  ³	cMoeda,dDataIni,dDataFim,aSetOfBook,lNoMov,cSaldo)         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ oMeter 		= Objeto oMeter                                ³±±
±±³           ³ oText  		= Objeto oText                                 ³±±
±±³           ³ oDlg   		= Objeto oDlg                                  ³±±
±±³           ³ lEnd   		= Acao do Codeblock                            ³±±
±±³           ³ cContaIni 	= Conta Inicial                                ³±±
±±³           ³ cContaFim 	= Conta Final                                  ³±±
±±³           ³ cMoeda 		= Moeda                                        ³±±
±±³           ³ dDataIni 	= Data Inicial                                 ³±±
±±³           ³ dDataFim 	= Data Final                                   ³±±
±±³           ³ aSetOfBook	= Matriz aSetOfBook                            ³±±
±±³           ³ lNoMov  	=  Indica se imprime movimento zerado ou nao.  ³±±
±±³           ³ cSaldo		= Tipo de Saldo                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctbr420Flt(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cMoeda,dDataIni,dDataFim,;
					  aSetOfBook,lNoMov,cSaldo,cTpRel,lAnalitico,cLoteIni,cLoteFim,;
					  cSbLoteIni,cSbLoteFim,cDocIni,cDocFim,cFiltCT1,aSelFil)

Local lNoMovDeb, lNoMovCrd
Local cChave
Local lFiltCT1		:= (cFiltCT1 <> Nil .And. !Empty(cFiltCT1))
Local nX				:= 0

DEFAULT lAnalitico	:= .T.
DEFAULT aSelFil		:= {}
cContaF := CCONTAFIM      

If !(IsBlind())
	oMeter:nTotal := CT1->(RecCount())
EndIf
If Empty(aSelFil) .Or. Empty(xFilial("CT2"))
	aSelFil := {cFilAnt}
EndIf

dbSelectArea("CT1")
dbSetOrder(3)
// Posiciona na primeira conta analitica
dbSeek(xFilial()+"2"+cContaIni,.T.)
	
While CT1->CT1_FILIAL == xFilial("CT1") .And. CT1->CT1_CONTA <= cContaF .And.	CT1->CT1_CLASSE = "2" .And. CT1->(!Eof())

   lNoMovDeb := .T.
   lNoMovCrd := .T.
	If lFiltCT1 .And. !&(cFiltCT1)
		DbSkip()
		Loop
	Endif

	For nX:= 1 to Len(aSelFil)
	   // ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   // ³ Obt‚m os d‚bitos ³
	   // ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	 	dbSelectArea("CT2")
		dbSetOrder(2)
		CT2->(MSSeek(xFilial("CT2",aSelFil[nX])+CT1->CT1_CONTA+ DTOS(dDataIni),.T.))		
		While CT2->CT2_FILIAL == xFilial("CT2",aSelFil[nX]) .And. ;
			CT2->CT2_DEBITO == CT1->CT1_CONTA .And.	;
			CT2->CT2_DATA >= dDataIni .And. CT2->CT2_DATA <= dDataFim .And. CT2->(!Eof())
	        
	        If !Empty(cSaldo)      
				If CT2->CT2_VALOR == 0 .Or. CT2->CT2_DC $ "24" .Or.;
				 CT2->CT2_TPSALD != cSaldo .Or. CT2->CT2_MOEDLC <> cMoeda
					dbSkip()
					Loop
				EndIf
			ElseIf CT2->CT2_VALOR == 0 .Or. CT2->CT2_DC $ "24" .Or.;
			 CT2->CT2_MOEDLC <> cMoeda
				dbSkip()
				Loop
			EndIF
	
			If (CT2->CT2_DEBITO < cContaIni .Or. CT2->CT2_DEBITO > cContaFim) 	
				dbSkip()
				Loop
			Endif 
			
			If cTpRel $ "2/3"
				If  (CT2->CT2_LOTE < cLoteIni .Or. CT2->CT2_LOTE > cLoteFim) .Or. ;
					(CT2->CT2_SBLOTE < cSbLoteIni .Or. CT2->CT2_SBLOTE > cSbLoteFim) .Or. ;
					(CT2->CT2_DOC < cDocIni .Or. CT2->CT2_DOC > cDocFim)
					dbSkip()
					Loop
				EndIf
			EndIf
	
			U_Ctbr420Grv(cMoeda,cSaldo,"1",cTpRel,lAnalitico)
			lNoMovDeb := .F.
	
			dbSelectArea("CT2")
			dbSetOrder(2)
			dbSkip()
		Enddo
		
	   // ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   // ³ Obt‚m os creditos³
	   // ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("CT2")
		CT2->(dbSetOrder(3))
		CT2->(MSSeek(xFilial("CT2",aSelFil[nX])+CT1->CT1_CONTA+ DTOS(dDataIni),.T.))
	
		While CT2->CT2_FILIAL == xFilial("CT2",aSelFil[nX]) .And. ;
			CT2->CT2_CREDIT == CT1->CT1_CONTA .And.	;
			CT2->CT2_DATA >= dDataIni .And. CT2->CT2_DATA <= dDataFim .And. CT2->(!Eof())
	
			If CT2->CT2_VALOR == 0 .Or. CT2->CT2_DC $ "14" .Or.;
				CT2->CT2_TPSALD != cSaldo .Or. CT2->CT2_MOEDLC <> cMoeda
				dbSkip()
				Loop
			EndIF 
	          
			If (CT2->CT2_CREDIT < cContaIni .Or. CT2->CT2_CREDIT > cContaFim) 
				dbSkip()
				Loop
			Endif
			
			If cTpRel $ "2/3"
				If  (CT2->CT2_LOTE < cLoteIni .Or. CT2->CT2_LOTE > cLoteFim) .Or. ;
					(CT2->CT2_SBLOTE < cSbLoteIni .Or. CT2->CT2_SBLOTE > cSbLoteFim) .Or. ;
					(CT2->CT2_DOC < cDocIni .Or. CT2->CT2_DOC > cDocFim)
					dbSkip()
					Loop
				EndIf
			EndIf
			
	
			U_Ctbr420Grv(cMoeda,cSaldo,"2",cTpRel,lAnalitico)
			lNoMovCrd := .F.
	
			dbSelectArea("CT2")
			dbSetOrder(3)
			dbSkip()		
		Enddo
	
		// Conta sem movimento
		If lNoMov
			If lNoMovCrd .And. lNoMovDeb
				If CtbExDtFim("CT1")							
					If CtbVlDtFim("CT1",dDataIni) 
						CtbGrvNoMov(CT1->CT1_CONTA,dDataIni,"CONTA")	//Esta sendo passado "CONTA" fixo, porque essa funcao esta sendo 									
					EndIf												//chamada somente para o CTBR420
				Else
					CtbGrvNoMov(CT1->CT1_CONTA,dDataIni,"CONTA")	//Esta sendo passado "CONTA" fixo, porque essa funcao esta sendo 				
				EndIf												//chamada somente para o CTBR420
			EndIf
		EndIf
				
	Next nX
	
	dbSelectArea("CT1")
	dbSetOrder(3)
   dbSkip()
EndDo

Return                        
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³Ctbr420Grv³ Autor ³ Simone Mie Sato       ³ Data ³ 04/10/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Grava registros no arq temporario - Razao                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³U_Ctbr420Grv(cMoeda,cSaldo,cTipo,cTpRel)                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ cMoeda = Moeda                                             ³±±
±±³           ³ cSaldo = Tipo de Saldo                                     ³±±
±±            ³ cTipo  = Tipo do lancamento                                ³±±
±±            ³ cTpRel = Tipo do relatorio                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctbr420Grv(cMoeda,cSaldo,cTipo,cTpRel,lAnalitico)

Local cConta := ""
Local cChave := ""
Local cGrupo    := ""		
Local cAliasCTL := ""		
Local cCT2Key   := CT2->CT2_KEY
Local cTpOper   	:= ""
Local cHistor		:= ""
Local lUseDocHis	:= X3USADO("CTC_DOCHIS") 

DEFAULT cTpRel		:= "1"
DEFAULT lAnalitico  := .T.

If cTpRel $ "1/3/7" .Or. (cTpRel == "2" .And. lAnalitico)
	If cTipo == "1"
		cConta 	:= CT2->CT2_DEBITO
	EndIf	
	If cTipo == "2"
		cConta 	:= CT2->CT2_CREDIT
	EndIf		                                       
	If cTpRel == "1"	
		cChave	:= cConta+CT2->(Dtos(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC+LEFT(CT2_KEY,nTamCT2Key/*100*/)+CT2_EMPORI+CT2_FILORI)
	ElseIf cTpRel == "2"
		cChave   := DTOS(CT2->CT2_DATA)+CT2->CT2_LOTE+CT2->CT2_SBLOTE+CT2->CT2_DOC+LEFT(CT2->CT2_KEY,100)+cConta+CT2->CT2_EMPORI+CT2->CT2_FILORI			
	ElseIf cTpRel == "3"
		cChave   := CT2->CT2_SBLOTE+DTOS(CT2->CT2_DATA)+CT2->CT2_LOTE+CT2->CT2_DOC+LEFT(CT2->CT2_KEY,100)+cConta+CT2->CT2_EMPORI+CT2->CT2_FILORI				   
	ElseIf cTpRel == "7"
		cChave	:= cConta+CT2->(Dtos(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_EMPORI+CT2_FILORI)
	EndIf
ElseIf cTpRel == "2" .And. !lAnalitico
	cChave   := DTOS(CT2->CT2_DATA)+CT2->CT2_LOTE+CT2->CT2_SBLOTE+CT2->CT2_DOC+LEFT(CT2->CT2_KEY,100)+CT2->CT2_EMPORI+CT2->CT2_FILORI	
ElseIf cTpRel == "4"
	cChave   := CT2->(DTOS(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC+LEFT(CT2_KEY,nTamCT2Key)+CT2_EMPORI+CT2_FILORI+CT2_DC+CT2_DEBITO+CT2_CREDIT+CT2_LINHA)
ElseIf cTpRel == "6"
	cChave   := CT2->(DTOS(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_EMPORI+CT2_FILORI+CT2_DC+CT2_DEBITO+CT2_CREDIT)
EndIf
                
dbSelectArea("cArqTmp")
dbSetOrder(1)	

If !MsSeek(cChave,.F.)
	RecLock("cArqTmp",.T.)
	Replace DATAL		With CT2->CT2_DATA
	If cTpRel == "4"
		Replace CT2KEY	With LEFT(cCT2Key,nTamCT2Key)
	Else
		Replace CT2KEY	With LEFT(cCT2Key,100)
	EndIf
	Replace TIPO		With cTipo
	Replace LOTE		With CT2->CT2_LOTE
	Replace SUBLOTE	With CT2->CT2_SBLOTE
	Replace DOC			With CT2->CT2_DOC
	Replace LINHA		With CT2->CT2_LINHA
	If cTpRel $ "4/6" 
		If TIPO $ "13"
			Replace CONTAD With CT2->CT2_DEBITO
		EndIF
		If TIPO $ "23"
			Replace CONTAC With CT2->CT2_CREDIT	
		EndIf	
	Else	
		Replace CONTA		With cConta
	EndIf	
	Replace EMPORI		With CT2->CT2_EMPORI
	Replace FILORI		With CT2->CT2_FILORI                               
	Replace FILIAL		With CT2->CT2_FILORI                               
	Replace SEQHIST	With CT2->CT2_SEQHIS
	Replace SEQLAN		With CT2->CT2_SEQLAN
	Replace HP 			With CT2->CT2_HP
	Replace HISTORICO With CT2->CT2_HIST
	Replace NOMOV		With .F.							// Conta com movimento
	Replace GRUPO		With cGrupo		
	Replace ALIAS		With cAliasCTL
	Replace OPERACAO   With cTpOper
	If cPaisLoc $ "CHI|ARG"
	   Replace CORRELATO	With CT2->CT2_SEGOFI   
	EndIf
	If cPaisLoc $ "ARG" .AND. lUseDocHis
		cHistor := CTBR080HCL()
		Replace DOCHIS With cHistor   
	EndIf
Else
	RecLock("cArqTmp",.F.)
EndIf
If cTipo $ "13"
	Replace LANCDEB	With LANCDEB + CT2->CT2_VALOR
EndIf	
If cTipo $ "23"
	Replace LANCCRD With LANCCRD + CT2->CT2_VALOR
EndIf	    
If !(cTpRel $ "4/6")
	// Este replace e valido para os relatorios -> Razao e Conf Digitacao
	// No caso do diario, eh mantido o tipo 3
	If CT2->CT2_DC == "3"
		Replace TIPO	With cTipo
	Else
		Replace TIPO 	With CT2->CT2_DC
	EndIf		
EndIf	
MsUnlock()

Return
