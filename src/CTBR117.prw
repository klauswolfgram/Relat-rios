/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR117.Ch"
#Include "PROTHEUS.Ch"
// 17/08/2009 -- Filial com mais de 2 caracteres
// 09/09/2011 - Alterado tradução das colunas de Debito e Credito para Pais Mexico

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR117  ³ Autor ³ Getulio A. Oliveira   ³ Data ³ 28/10/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Diario Geral                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CTBR117(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR117()

Local cFilIni		:= cFilAnt    

PRIVATE titulo		:= ""
Private nomeprog	:= "CTBR117"
Private l1StQb		:= .T.         
Private nTransC	:= 0 
Private nTransD	:= 0 
Private aSelFil	:= {}


U_CTBR117R4()

cFilAnt := cFilIni
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR117R4 ³ Autor³ Getulio A. Oliveira	³ Data ³ 28/10/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Diario Geral - R4                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR117R4												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR117R4()                                                       
PRIVATE oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//| Variaveis utilizadas para parametros                                 | 
//| mv_par01  	        //  Data Inicial                                |
//| mv_par02              // Data Final                                  | 
//| mv_par03              // Moeda?                                      | 
//| mv_par04				 // Set Of Books			    		             | 
//| mv_par05			     // Tipo Lcto? Real / Orcad / Gerenc / Pre      | 
//| mv_par06  	      	 // Pagina Inicial                              | 
//| mv_par07         	 // Pagina Final                                | 
//| mv_par08         	 // Pagina ao Reiniciar                         | 
//| mv_par09         	 // So Livro/Livro e Termos/So Termos           | 
//| mv_par10         	 // Imprime Balancete                           | 
//| mv_par11         	 // Imprime Plano de contas                     |
//| mv_par12         	 // Imprime Valor 0.00	                        | 
//| mv_par13         	 // Impr Cod(Normal/Reduz/Cod.Impressao)         |  /// CT1_CODIMP
//| mv_par14             //  Num.linhas p/ o diario?				          | 
//| mv_par15             //  Salta linha entre contas?                   |
//| mv_par16             //  Descricao na Moeda?                         |
//| mv_par17             //  Balancete Modelo?
//| mv_par18			    // Imprime correlativo						          |
//| mv_par19             //  Seleciona Filiais?							   |
//| mv_par20             //  Mostrar(Normal/Só Cabeçalho/ So Informações |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()      

IF Valtype( oReport ) == 'O'
	If !Empty( oReport:uParam )
		Pergunte( oReport:uParam, .F. )
	EndIf	
	
	oReport:PrintDialog()      
Endif

oReport := Nil

Return                                

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Getulio A. Oliveira	³ Data ³ 28/10/09 ³±±
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

Local aArea	   		:= GetArea()   
Local CREPORT		:= "CTBR117"
Local CTITULO		:= OemToAnsi(STR0006)				// Emissao do Diario Geral
Local CDESC			:= OemToAnsi(STR0001)+OemToAnsi(STR0002)+OemToAnsi(STR0003)	// "Este programa ir  imprimir o Diário Geral Modelo 1"
Local cPerg		   	:= "CTR117"			  
Local CVALDEB		:= ""
Local CVALCRED		:= ""
Local cSeparador    := ""
Local cMoeda		:= ""
Local aCtbMoeda		:= {}
Local lRet		 	:= .T. 
Local cQuery
Local cFilCt1		:= ""   
Local cFilCt2		:= "" 
Local nSize
Public cMascara		:= ""
Public cDescMoeda 	:= ""
Public cPicture		:= ""
Public nDecimais		:= 0
Public aTamVal		:= TAMSX3("CT2_VALOR")
Public nTamQuebra	:= 0      
Public nTamConta	:= 25  
private TMP


DEFAULT aSelFil		:= {}

If !Pergunte( 'CTR117' , .T. )
	lRet := .F.
EndIf
    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)		     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// faz a validação do livro
if lRet .And. !Empty( mv_par04 ) 
	if ! VdSetOfBook( mv_par04 , .F. )
		lRet := .F.
	endif
Endif

IF lRet
	// seta o livro
	aSetOfBook := CTBSetOf(mv_par04)
	
	// seta a moeda
	aCtbMoeda	:= CtbMoeda(mv_par03)
	If Empty(aCtbMoeda[1])
		Help(" ",1,"NOMOEDA")
		lRet := .F.
	EndIf	
Endif

If lRet .And. mv_par19 == 1 .And. Len( aSelFil ) <= 0
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		lRet := .F.
	EndIf
Else
	aSelFil := {cFilAnt} 
EndIf 
	
If !lRet	
	Set Filter To
	Return
EndIf

cMoeda		:= mv_par03
cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,cMoeda)

If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
Else
	cMascara := RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf

// mascara do valor
cPicture 	:= aSetOfBook[4]
If Empty( cPicture ) .Or. cPicture == Nil
	cPicture := "@E " + TmContab(CT2->CT2_VALOR,aTamVal[1],nDecimais)
Endif

                                     
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

//"Este programa tem o objetivo de emitir o Cadastro de Itens Classe de Valor "
//"Sera impresso de acordo com os parametros solicitados pelo"
//"usuario"
oReport	:= TReport():New( CREPORT,CTITULO,, { |oReport| ReportPrint( oReport, cPicture, nDecimais, cMascara, cSeparador, cDescMoeda ) }, CDESC ) 
                    
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)
oReport:SetPortrait(.T.)  

oReport:SetEdit(.T.)// Habilita opcao de personalizacao do R4, a personalizacao deve estar sempre habilitada
                    //  independentemente do valor do parametro MV_CTBPOFF

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
           

     
nTamQuebra := (TamSX3("CT2_DATA")[1]+TamSX3("CT1_CONTA")[1]+TamSX3("CT1_DESC01")[1])

oSection1  := TRSection():New( oReport, STR0007, {"TMP"},,.F.,.F.,,,,,,,,,,.F./*AutoAjuste*/,)    //"Totalizadores Doc / Geral"   
TRCell():New( oSection1, "Documento"    , /*Alias*/, /*Titulo*/, /*Picture*/,nTamQuebra)
TRCell():New( oSection1, "CDEBITO"		, 	   ,/*STR0022*/   ,/*Picture*/,aTamVal[1]	,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT")		//"Vlr.Debito"
TRCell():New( oSection1, "CCREDITO"		,	   ,/*STR0023*/	  ,/*Picture*/,aTamVal[1]	,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT")		//"Vlr.Credito"

oSection1:Cell("CDEBITO"):lHeaderSize	:= .F.
oSection1:Cell("CCREDITO"):lHeaderSize	:= .F.
oSection1:SetHeaderSection(.F.)  
oSection1:SetReadOnly()

oSection2  := TRSection():New( oReport, STR0008 , {"TMP"},, .F., .F.,,,,,,,,,,.F./*AutoAjuste*/, )    //"Lancamentos Contabeis"

TRCell():New( oSection2, "CT2_DC"       , "TMP","DC", /*Picture*/,TamSX3("CT2_DC")[1])
TRCell():New( oSection2, "CT2_LINHA"    , "TMP","LIN", /*Picture*/,TamSX3("CT2_LINHA")[1])
TRCell():New( oSection2, "DOCTO"    	 , ,"DOCUMENTO", /*Picture*/, TamSX3("CT2_LOTE")[1] + TamSX3("CT2_SBLOTE")[1] + TamSX3("CT2_SEGOFI")[1])
TRCell():New( oSection2, "DATA"	  		 ,"",/*Titulo*/	,/*Picture*/,TamSX3("CT2_DATA")[1]+3,	/*lPixel*/,/*CodeBlock*/,/*"LEFT"*/,,"LEFT")
TRCell():New( oSection2, "CT1_CONTA"    , "TMP", "CONTA", /*Picture*/,TamSX3("CT1_CONTA")[1])
TRCell():New( oSection2, "CT1_DESC01"   , "TMP", "DESC. CONTA", /*Picture*/,TamSX3("CT1_DESC01")[1],	/*lPixel*/,/*CodeBlock*/,/*"LEFT"*/,.t.,"LEFT")
TRCell():New( oSection2, "CVALDEB"		 , ""	,STR0010,/*Picture*/,aTamVal[1]	,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT")		//"Vlr.Debito"
TRCell():New( oSection2, "CVALCRED"		 ,""	,STR0011,/*Picture*/,aTamVal[1]	,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT")		//"Vlr.Credito"

oSection2:Cell("DATA"):lHeaderSize  := .F.
oSection2:Cell("CT1_CONTA"):lHeaderSize := .F.
oSection2:Cell("CT1_DESC01"):lHeaderSize := .F.
oSection2:Cell("CVALDEB"):lHeaderSize  := .F.
oSection2:Cell("CVALCRED"):lHeaderSize := .F.
oSection2:SetReadOnly()
                         
oSection3  := TRSection():New( oReport, STR0009, ,, .F., .F.,,,,,,,,,,.F./*AutoAjuste*/,)    //"Transporte"
TRCell():New( oSection3, "Transporte", /*Alias*/, /*Titulo*/, /*Picture*/,nTamQuebra)     
TRCell():New( oSection3, "CDEBTRANSP"	, 	   ,STR0010   ,/*Picture*/,aTamVal[1]	,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT")		//"Vlr.Debito"
TRCell():New( oSection3, "CCREDTRANSP"	,	   ,STR0011	  ,/*cPicture*/,aTamVal[1]	,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT")		//"Vlr.Credito"

oSection3:Cell("CDEBTRANSP"):lHeaderSize  := .F.
oSection3:Cell("CCREDTRANSP"):lHeaderSize := .F.
oSection3:SetHeaderSection(.F.)   
oSection3:SetReadOnly()  

nSize := oSection2:Cell("CT2_DC"):GetSize()
nSize += oSection2:Cell("CT2_LINHA"):GetSize()
nSize += oSection2:Cell("DOCTO"):GetSize()
nSize += oSection2:Cell("DATA"):GetSize()
nSize += oSection2:Cell("CT1_CONTA"):GetSize()
nSize += oSection2:Cell("CT1_DESC01"):GetSize()
oSection1:Cell("DOCUMENTO"):SetSize(nSize+5)	
oSection3:Cell("Transporte"):SetSize(nSize+5)	

If mv_par20 == 2

	oSection2:SetHeaderSection(.F.)

	oSection1:Cell("DOCUMENTO"):Hide() 
	
	oSection1:Cell("CDEBITO"):Hide() 
 	oSection1:Cell("CCREDITO"):Hide() 
 	
	oSection2:Cell("CT2_DC"):Hide()                    
	oSection2:Cell("CT2_LINHA"):Hide()                    	
	oSection2:Cell("DOCTO"):Hide()
	oSection2:Cell("DATA"):Hide()
	oSection2:Cell("CT1_CONTA"):Hide()
	oSection2:Cell("CT1_DESC01"):Hide()
	oSection2:Cell("CVALDEB"):Hide()
	oSection2:Cell("CVALCRED"):Hide()
	
	oSection3:Cell("Transporte"):Hide()
	oSection3:Cell("CDEBTRANSP"):Hide()
	oSection3:Cell("CCREDTRANSP"):Hide()

	oReport:OnPageBreak( { || oReport:SkipLine(6)}) 
	
Elseif mv_par20 == 3               
    oReport:HideHeader() 
	oReport:OnPageBreak( { || oReport:SkipLine(6)})  
Endif     

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Getulio A. Oliveira	³ Data ³ 28/10/09 ³±±
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
Static Function ReportPrint( oReport, cPicture, nDecimais, cMascara, cSeparador, cDescMoeda )  

Local oSection1 	:= oReport:Section(1)     
Local oSection2 	:= oReport:Section(2)     
Local oSection3 	:= oReport:Section(3)     

Local lPula			:= Iif(mv_par10==1,.T.,.F.) 
Local lImpLivro		:=.t.                         
Local lImpTermos	:=.f.
Local cMSGT			:= SubStr(STR0012,3,25)
Local i				:= 0
Local nLinReport    := 8
Local nMaxLin		:= mv_par14
Local lSalLin 		:= Iif(MV_PAR15==1,.T.,.F.)
Local lResetPag		:= .T.
Local m_pag			:= 1 // controle de numeração de pagina
Local l1StQb		:= .T.  
Local nPagIni		:= mv_par06
Local nPagFim		:= mv_par07
Local nReinicia		:= mv_par08
Local nBloco		:= 0
Local nBlCount		:= 1  
Local nPaginas      := mv_par06      
Local dData      
Local lNovoDoc		:= .T. 
Local nToDocC		:= 0 
Local nToDocD		:= 0
Local nGeralC		:= 0
Local nGeralD		:= 0
Local lFim			:= .F.
Local nK				:= 0  
Local cFilOld	    := cFilAnt
Local aArea			:= GetArea()
Local aAreaSM0		:= SM0->(GetArea())
Local cDoc			:= ""
Local aDC			:={"D","C","P","H"}
Local cTmpCT1Fil
Local cTmpCT2Fil
Local lColDbCr 		:= lIsRedStor // Disconsider cTipo in ValorCTB function, setting cTipo to empty
	
Public lPrintZero	:= Iif(mv_par12 == 1,.T.,.F.)  
                                            

TMP := GetNextAlias()

cFilCt1  := " CT1_FILIAL " + GetRngFil( aSelFil, "CT1", .T., @cTmpCT1Fil )
cFilCt2  := " CT2_FILIAL " + GetRngFil( aSelFil, "CT2", .T., @cTmpCT2Fil )

cQuery := " SELECT "  
cQuery += " CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_SEGOFI, CT2_DATA, CT1_CONTA, CT2_DEBITO, CT2_CREDIT, CT1_DESC01, CT1_RES, CT1_CODIMP, CT2_VALOR, CT2_DC, CT2_LINHA, 'DB' CT2_ID_DC "
cQuery += " FROM " + RetSqlName('CT2') + " CT2"
cQuery += " LEFT JOIN " + RetSqlName('CT1') + " CT1 ON (CT2_DEBITO = CT1_CONTA) AND " + cFilCt1 + " AND CT1.D_E_L_E_T_ <> '*'"
cQuery += " WHERE " + cFilCt1 + " AND " + cFilCt2
cQuery += " AND CT2_DATA BETWEEN '" + DTOS( mv_par01 ) + "' AND '" + DTOS ( mv_par02 ) + "' "
cQuery += " AND CT2_MOEDLC = '" + mv_par03 + "' "
cQuery += " AND CT2_TPSALD = '" + mv_par05 + "' "  
cQuery += " AND CT2_DC IN ('1','3') "
cQuery += " AND CT2.D_E_L_E_T_ <> '*' " +CRLF
cQuery += " UNION ALL " +CRLF
cQuery += " SELECT "  
cQuery += " CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_SEGOFI, CT2_DATA, CT1_CONTA, CT2_DEBITO, CT2_CREDIT, CT1_DESC01, CT1_RES, CT1_CODIMP, CT2_VALOR, CT2_DC, CT2_LINHA, 'CR' CT2_ID_DC "
cQuery += " FROM " + RetSqlName('CT2') + " CT2"
cQuery += " LEFT JOIN " + RetSqlName('CT1') + " CT1 ON (CT2_CREDIT = CT1_CONTA) AND " + cFilCt1 + " AND CT1.D_E_L_E_T_ <> '*'"
cQuery += " WHERE " + cFilCt1 + " AND " + cFilCt2
cQuery += " AND CT2_DATA BETWEEN '" + DTOS( mv_par01 ) + "' AND '" + DTOS ( mv_par02 ) + "' "
cQuery += " AND CT2_MOEDLC = '" + mv_par03 + "' "
cQuery += " AND CT2_TPSALD = '" + mv_par05 + "' "  
cQuery += " AND CT2_DC IN ('2','3') "
cQuery += " AND CT2.D_E_L_E_T_ <> '*'"

If MV_PAR18 == 1
	cQuery += " ORDER BY CT2_LOTE, CT2_SBLOTE, CT2_SEGOFI, CT2_LINHA, CT2_DATA "
	Else	
	cQuery += " ORDER BY CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA, CT2_DATA "
EndIf
                     
cQuery := ChangeQuery(cQuery)

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), 'TMP', .T., .F. )  

DbSelectArea('TMP')


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Termo / Livro                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case mv_par09 == 1 ; lImpLivro := .T. ; lImpTermos := .F.
	Case mv_par09 == 2 ; lImpLivro := .T. ; lImpTermos := .T.
	Case mv_par09 == 3 ; lImpLivro := .F. ; lImpTermos := .T.      
EndCase		                                                  

aSetOfBook := CTBSetOf(mv_par04)
cPicture 	:= aSetOfBook[4]
If Empty( cPicture ) .Or. cPicture == Nil
	cPicture := "@E " + TmContab(CT2->CT2_VALOR,aTamVal[1],nDecimais)
Endif        
              
For nK := 1 to Len(aSelFil)
	cFilAnt := aSelFil[nK]
	SM0->(DbSeek(cEmpAnt+cFilAnt))
		
	If lImpLivro
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//| titulo do relatorio                                          |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		titulo		:= 	OemToAnsi(STR0013) + DTOC(mv_par01) + OemToAnsi(STR0014) + DTOC(mv_par02) + OemToAnsi(STR0015) + cDescMoeda + CtbTitSaldo(mv_par05)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//| cabeçalho do relatorio                                       |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	   	oReport:SetCustomText( {|| (Pergunte("CTR117",.F.),CtCGCCabTR(,,,,,mv_par02,titulo,,,,,oReport,.T.,@lResetPag,@nPagIni,@nPagFim,@nReinicia,@m_pag,@nBloco,@nBlCount,@l1StQb)) } )
				
		oReport:SetMeter( RecCount() )  
		
	 	oSection1:OnPrintLine( {|| CTR117Maxl( nMaxLin, @nLinReport, cPicture )} )	  
	 	oSection2:OnPrintLine( {|| CTR117Maxl( nMaxLin, @nLinReport, cPicture )} )	  	

		If MV_PAR18 == 1
			oSection2:Cell("DOCTO"):SetBlock( { || (TMP->CT2_LOTE+TMP->CT2_SBLOTE+"-"+TMP->CT2_SEGOFI) })
		Else
			oSection2:Cell("DOCTO"):SetBlock( { || (TMP->CT2_LOTE+TMP->CT2_SBLOTE+TMP->CT2_DOC) })
		EndIf
		      
		oSection2:Cell("CT2_DC"):SetBlock({|| aDC[val(TMP->CT2_DC)] })
		
		oSection2:Cell("CT2_LINHA"):SetBlock({|| TMP->CT2_LINHA })		
		
		oSection2:Cell("CVALDEB" ):SetBlock( { || ValorCTB( if( TMP->CT1_CONTA == TMP->CT2_DEBITO,TMP->CT2_VALOR , 0 ) ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr)})
		oSection2:Cell("CVALCRED"):SetBlock( { || ValorCTB( if( TMP->CT1_CONTA == TMP->CT2_CREDIT,TMP->CT2_VALOR ,0 ) ,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr)})
		
	    oSection2:Cell("DATA"):SetBlock( { || stod(tmp->ct2_Data) } ) 
	  	
	  	 
		If MV_PAR13 == 2	       /// Impressao do Codigo Reduzido
			
			oSection2:Cell("CT1_CONTA" ):SetBlock( { || EntidadeCTB(TMP->CT1_RES,0 ,00,nTamConta,.F.,cMascara,cSeparador,,,,,.F.) } )
				
		ElseIf MV_PAR13 == 3 	/// Impressao do Codigo de Impressao (se o campo existir)
		
			oSection2:Cell("CT1_CONTA" ):SetBlock( { || EntidadeCTB(TMP->CT1_CODIMP,0,0,nTamConta,.F.,cMascara,cSeparador,,,,,.F.) } )

		Else   					/// Impressao do Codigo Normal

			oSection2:Cell("CT1_CONTA" ):SetBlock( { || EntidadeCTB(TMP->CT1_CONTA,0,0,nTamConta,.F.,cMascara,cSeparador,,,,,.F.) } )
			
		Endif
			  
		If MV_PAR18 == 1
	 		oSection1:Cell("DOCUMENTO"):SetBlock( { || Iif( lFim, STR0016,  Iif (lNovoDoc, STR0017 + TMP->CT2_LOTE+TMP->CT2_SBLOTE+"-"+TMP->CT2_SEGOFI, STR0018))})     
		Else  	
		 	oSection1:Cell("DOCUMENTO"):SetBlock( { || Iif( lFim, STR0016, Iif (lNovoDoc, STR0017 +  TMP->CT2_LOTE+TMP->CT2_SBLOTE+TMP->CT2_DOC, STR0018))})
	    EndIf
	 	
	 	oSection1:Cell("CDEBITO"):SetBlock( { || Iif( lFim, ValorCTB( nGeralD,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr), Iif(lNovoDoc, nil,;
	 	ValorCTB( nToDocD,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr)))})  
	 	
	 	oSection1:Cell("CCREDITO"):SetBlock( { || Iif( lFim, ValorCTB( nGeralC,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr), Iif(lNovoDoc, nil,;
	    ValorCTB( nToDocC,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr)))})  
	
		oSection3:Cell("CDEBTRANSP"):SetBlock( { || ValorCTB( nTransD,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr)})  
	  	oSection3:Cell("CCREDTRANSP"):SetBlock( { || ValorCTB( nTransC,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr)})  
		oSection3:Cell("TRANSPORTE"):SetBlock( { || Iif(nLinReport == 11, STR0012, STR0019)}) 

		
		While TMP->(!Eof()) 
	   	
			cDoc := TMP->(CT2_DATA+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA)

			lNovoDoc := .T.
			nToDocC  := 0
			nToDocD  := 0
			nTransC  := 0
	   		nTransD  := 0
		
			oSection1:Init()   
		   	oSection1:PrintLine() 
	 		oSection1:Finish()
	
			oSection2:Init()
	
			While TMP->(CT2_DATA+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA) == cDoc  

			    If oReport:Cancel()
			    	Exit
			    EndIf        
	
				lNovoDoc := .F.
					
				oSection2:PrintLine() 
				oReport:IncMeter()
											
			 	
			 	If TMP->CT2_ID_DC == 'DB' 
					nToDocD += TMP->CT2_VALOR 
					nTransD += TMP->CT2_VALOR  
					nGeralD += TMP->CT2_VALOR  
				EndIf
				
			 	
			 	If TMP->CT2_ID_DC == 'CR' 
			 		nToDocC += TMP->CT2_VALOR 
					nTransC += TMP->CT2_VALOR  	
					nGeralC += TMP->CT2_VALOR  							
				EndIf   
				
				TMP->(dbSkip())
			EndDo  
			
			oSection2:Finish()	
			
			oSection1:Init() 
			oSection1:PrintLine()
			oSection1:Finish()
			nLinReport := nLinReport + 1;
			
		EndDo  
		lFim := .T.
	 	oSection1:Init()
		oSection1:PrintLine()
		oSection1:Finish()  		
		
	  		
	Endif   	
	oReport:EndPage()
Next

nGeralD := 0
nGeralC	:= 0
lFim := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressão do Balancete Modelo 1                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par10 == 1
	If MV_PAR17 == 1
		Ctbr040R4()
	ElseIf	MV_PAR17 == 2
		Ctbr043R4()	
	EndIf
	Pergunte( "CTR117" , .F. )
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressão do Plano de Contas                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par11 == 1
	Ctbr010R4( mv_par03 )
Endif

If lImpTermos 							// Impressao dos Termos
	oReport:HideHeader()
	oSection2:Hide()

	Pergunte( "CTR117", .F. )
	
	cArqAbert:=GetMv("MV_LDIARAB")
	cArqEncer:=GetMv("MV_LDIAREN")

	dbSelectArea("SM0")
	aVariaveis:={}

	For i:=1 to FCount()	
		If FieldName(i)=="M0_CGC"
			AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R! NN.NNN.NNN/NNNN-99")})
		Else
            If FieldName(i)=="M0_NOME"
                Loop
            EndIf
			AADD(aVariaveis,{FieldName(i),FieldGet(i)})
		Endif
	Next

	dbSelectArea("SX1")
	dbSeek( padr( "CTR117" , Len( X1_GRUPO ) , ' ' ) + "01" )

	While ! Eof() .And. SX1->X1_GRUPO  == padr( "CTR117" , Len( X1_GRUPO ) , ' ' )
		AADD(aVariaveis,{Rtrim(Upper(X1_VAR01)),&(X1_VAR01)})
		dbSkip()
	End

	dbSelectArea( "CVB" )
	CVB->(dbSeek( xFilial( "CVB" ) ))
	For i:=1 to FCount()
		If FieldName(i)=="CVB_CGC"
			AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R! NN.NNN.NNN/NNNN-99")})
		ElseIf FieldName(i)=="CVB_CPF"
			AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R 999.999.999-99")})
		Else
			AADD(aVariaveis,{FieldName(i),FieldGet(i)})
		Endif
	Next

	AADD(aVariaveis,{"M_DIA",StrZero(Day(dDataBase),2)})
	AADD(aVariaveis,{"M_MES",MesExtenso()})
	AADD(aVariaveis,{"M_ANO",StrZero(Year(dDataBase),4)})

	If !File(cArqAbert)
		aSavSet:=__SetSets()
		cArqAbert:=CFGX024(,"Diario Geral.") // Editor de Termos de Livros
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
	Endif

	If !File(cArqEncer)
		aSavSet:=__SetSets()
		cArqEncer:=CFGX024(,"Diario Geral.") // Editor de Termos de Livros
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

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| cabeçalho do relatorio                                       |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:EndPage()
	oReport:ShowHeader()
	oSection2:Show()

Endif

cFilAnt := cFilOld
RestArea(aAreaSM0)	
RestArea(aArea)		
TMP->(DbCloseArea()) 

CtbTmpErase(cTmpCT1Fil)
CtbTmpErase(cTmpCT2Fil)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |CTR117MaxL    ºAutor ³ Renato F. Campos º Data ³ 01/03/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Faz a quebra de pagina de acordo com o parametro passado   º±±
±±º          ³ no relatorio.                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPL1 - Numero maximo de linhas definido no relatorio      º±±
±±º          ³ EXPL2 - Contador de linhas impressas no relatorio          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ nil                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Diario Geral                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/           

Static Function CTR117MaxL(nMaxLin,nLinReport, cPicture )
Local oSection1 := oReport:Section(1)
Local oSection3 := oReport:Section(3)
Local nMaxLin1       

nMaxLin1 := nMaxLin   

If oSection1:Printing()
	nLinReport += 2
Else
	nLinReport++
Endif

If nLinReport > nMaxLin1 - 2
	If nTransC > 0 .OR. nTransD > 0
	  
		oSection3:Init()
		oSection3:Printline() 
		oSection3:Finish()
	                      
 		oReport:EndPage()
		nLinReport := 11 	
		oSection3:Init()
		oSection3:Printline() 
		oSection3:Finish()
		oReport:Skipline() 
	
    Else 
    
  		nLinReport := 9  
	                      
 		oReport:EndPage()
 	
	EndIf 	
Else       
EndIf   


Return Nil

