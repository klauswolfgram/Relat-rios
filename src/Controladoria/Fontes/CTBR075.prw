/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR075.Ch"
#Include "PROTHEUS.Ch"

#define FILTRO_CT1	1
#define FILTRO_CTT	2
#define FILTRO_CTD	3
#define FILTRO_CTH	4

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema
//amarracao

// 17/08/2009 -- Filial com mais de 2 caracteres

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR075  ³ Autor ³ Simone Mie Sato       ³ Data ³ 08.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o do Relatorio de Conferencia por Documento Fiscal   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CTBR075()                                                  ³±±
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
User Function Ctbr075()
PRIVATE titulo		:= ""
Private nomeprog	:= "CTBR075"                            
Private aFiltrosR4:=	{Nil,Nil,Nil,Nil} //CT1,CTT,CTD,CTH

U_CTBR075R4()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR075R4 ³ Autor³ Daniel Sakavicius		³ Data ³ 28/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o do Relatorio de Conferencia por Doc. Fiscal - R4   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR075R4												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR075R4()         
Local cArqTmp	:= "CT7"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef(cArqTmp)      
If !Empty( oReport:uParam )
	Pergunte( oReport:uParam, .F. )
EndIf	
oReport :PrintDialog()      
If Select("cArqTmp") <> 0
	dbSelectArea("cArqTmp")
	dbClearFilter()
	dbCloseArea()
	If Select("cArqTmp") == 0
		FErase(cArqTmp+GetDBExtension())
		FErase(cArqTmp+OrdBagExt())
	EndIf
Endif
Return                                

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Daniel Sakavicius		³ Data ³ 28/07/06 ³±±
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
Static Function ReportDef(cArqTmp) 
local aArea	   		:= GetArea()   
Local CREPORT		:= "CTBR075"
Local CTITULO		:= STR0006				   			// "Emissao do Relat. Conf. Dig. "
Local CDESC			:= STR0001//+STR002+STR003			// "Este programa ira imprimir o Relatorio para Conferencia"
Local CPERG	   		:= "CTR075"			  
Local lAnalitico	:= .F.
Local mv_par17		:= 1
Local cInfDig		:= ""       
Local aTamData		:= TAMSX3("CT2_DATA")    
Local aTamVal		:= TAMSX3("CT2_VALOR")
Local aTamHist		:= TAMSX3("CT2_HIST")   
Local aTamLote		:= TAMSX3("CT2_LOTE")    
Local aTamSbLote	:= TAMSX3("CT2_SBLOTE")
Local aTamDoc		:= TAMSX3("CT2_DOC")
Local aTamConta		:= TAMSX3("CT1_CONTA")     
Local cPictVal 		:= PesqPict("CT2","CT2_VALOR")
Local aTamDocHis	:= TAMSX3("CTC_DOCHIS")
Local lUseDocHis	:= X3USADO("CTC_DOCHIS")
	
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
oReport	:= TReport():New( CREPORT,CTITULO,CPERG, { |oReport| ReportPrint( oReport, cArqTmp ) }, CDESC ) 
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.F.)
oReport:SetTotalText(STR0013)	//"T O T A L  G E R A L ==> "
	
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
oSection1  := TRSection():New( oReport, STR0030, {"cArqTmp"},, .F., .F. )         //Lote

TRCell():New( oSection1, "DATAL"  , ,STR0031/*Titulo*/,/*Picture*/,aTamData[1]+2/*Tamanho*/,/*lPixel*/,{ || (cArqTMp->DATAL) }/*CodeBlock*/)
TRCell():New( oSection1, "LOTE"   , ,STR0030/*Titulo*/,/*Picture*/,aTamLote[1]/*Tamanho*/,/*lPixel*/,{ || (cArqTMp->LOTE) }/*CodeBlock*/)
TRCell():New( oSection1, "SUBLOTE", ,STR0032/*Titulo*/,/*Picture*/,aTamSbLote[1]/*Tamanho*/,/*lPixel*/,{ || (cArqTMp->SUBLOTE) }/*CodeBlock*/)
TRCell():New( oSection1, "DOC"    , ,STR0033/*Titulo*/,/*Picture*/,aTamDoc[1]/*Tamanho*/,/*lPixel*/,{ || (cArqTMp->DOC) }/*CodeBlock*/)
If cPaisLoc == "ARG" .And. lUseDocHis
	TRCell():New( oSection1, "DOCHIS" , ,STR0041/*Titulo*/,/*Picture*/,aTamDocHis[1]/*Tamanho*/,/*lPixel*/,{ || (cArqTMp->DOCHIS) }/*CodeBlock*/)
EndIf

oSection1:SetTotalInLine(.F.)
oSection1:SetTotalText(STR0027) //Total 
                                                                               
oSection11  := TRSection():New( oSection1, STR0040, {"cArqTmp","CT1"},, .F., .F. )        //"Lancamento"
TRCell():New( oSection11, "CONTA"   	, ,STR0034/*Titulo*/,/*Picture*/,aTamConta[1]/*Tamanho*/,/*lPixel*/,{ || (cArqTMp->CONTA) }/*CodeBlock*/)
TRCell():New( oSection11, "CT2KEY"   	, ,STR0035/*Titulo*/,/*Picture*/,30/*Tamanho*/,/*lPixel*/,{ || SubStr((cArqTMp->CT2KEY),1,40) }/*CodeBlock*/)
TRCell():New( oSection11, "LANCDEB"  	, ,STR0036/*Titulo*/,cPictVal/*Picture*/,aTamVal[1]/*Tamanho*/,/*lPixel*/,{ || (cArqTMp->LANCDEB) },"RIGHT",,"RIGHT")
TRCell():New( oSection11, "LANCCRD"  	, ,STR0037/*Titulo*/,cPictVal/*Picture*/,aTamVal[1]/*Tamanho*/,/*lPixel*/,{ || (cArqTMp->LANCCRD) },"RIGHT",,"RIGHT")
TRCell():New( oSection11, "HP"       	, ,STR0038/*Titulo*/,/*Picture*/,5/*Tamanho*/,/*lPixel*/,{ || (cArqTMp->HP) }/*CodeBlock*/) 
TRCell():New( oSection11, "HISTORICO"	, ,STR0039/*Titulo*/,/*Picture*/,aTamHist[1]/*Tamanho*/,/*lPixel*/,{ || (cArqTMp->HISTORICO) }/*CodeBlock*/) 
TRCell():New( oSection11, "INF"  	  	, ,STR0024/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection11, "DIG"  	  	, ,STR0025/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection11, "DIF" 	  	, ,STR0026/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")

TRPosition():New( oSection11, "CT1", 1, {|| xFilial("CT1") + cArqTMP->CONTA })

oSection11:SetHeaderPage(.T.)

Return(oReport)

/*/
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
Static Function ReportPrint( oReport, cArqTmp )  
Local oBreak1
Local oBreak2
Local oSection1 	:= oReport:Section(1) 
Local oSection11 	:= oReport:Section(1):Section(1)
Local lQuebraLote	:= (mv_par09 == 1)
Local lQuebraDoc	:= (mv_par09 == 2)
Local lNaoQuebra	:= (mv_par09 == 3)
Local lImpDoc0		:= (mv_par13 == 1)
Local lTotal		:= (mv_par10 == 1)        
Local dDataIni		:= mv_par01
Local dDataFim		:= mv_par02
Local cLoteIni		:= mv_par03
Local cLoteFim		:= mv_par04
Local cDocIni		:= mv_par05
Local cDocFim		:= mv_par06
Local cMoeda		:= mv_par07
Local cSaldo		:= mv_par08
Local cSbLoteIni	:= mv_par11
Local cSbLoteFim	:= mv_par12
Local cContaIni		:= ""
Local cContaFim		:= ""
Local aSetOfBook	:= {"","",0,"","","","","",1,""}
Local lAnalitico	:= (mv_par14 == 1)
Local lEnd 			:= .F.
Local lFirst		:= .F.
Local cChaveCTC		:= ""
Local nTotDocInf	:= 0
Local nTotDocDig	:= 0
Local nTotDocDif	:= 0
Local lQbLote		:= .F.
Local cQbLote		:= ""
Local aRetCT6		:= {}

If !Empty(oSection1:GetAdvplExp('CT1'))
	aFiltrosR4[FILTRO_CT1]	:=	oSection1:GetAdvplExp('CT1')
Endif	

oSection1:NoUserFilter()

aCtbMoeda  	:= CtbMoeda(mv_par07)
If Empty(aCtbMoeda[1])
	Help(" ",1,"NOMOEDA")
	Return
Endif
cDescMoeda 	:= Alltrim(aCtbMoeda[2])

If lAnalitico
	cContaIni   := mv_par15
	cContaFim	:= mv_par16
Endif

MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
CTBR420Raz(oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,;
cMoeda,dDataIni,dDataFim,aSetOfBook,.F.,cSaldo,"2",lAnalitico,cLoteIni,cLoteFim,;
cSbLoteIni,cSbLoteFim,cDocIni,cDocFim,aFiltrosR4[FILTRO_CT1])},;
STR0012,;		// "Criando Arquivo Tempor rio..."
STR0006)		// "Emissao do Relat. Conf. Dig. "

                                                         
cArqTmp->(dbGoTop())

If cArqTmp->(!EoF())

	oReport:SetMeter(cArqTmp->(RecCount()))
	
	oSection11:SetParentFilter({|cParam| cArqTmp->(DTOS(DATAL)+LOTE+SUBLOTE+DOC) == cParam  },{|| cArqTmp->(DTOS(DATAL)+LOTE+SUBLOTE+DOC) })                                                     
	                                                  
	If lAnalitico
		Titulo 		:= 	STR0015+STR0016+STR0011+cDescMoeda + STR0007 + DTOC(dDataIni) +;	// "DE"
						STR0008 + DTOC(dDataFim) + CtbTitSaldo(mv_par08)	// "ATE"
	Else
		Titulo 		:= 	STR0015+STR0017+STR0011+cDescMoeda + STR0007 + DTOC(dDataIni) +;	// "DE"
						STR0008 + DTOC(dDataFim) + CtbTitSaldo(mv_par08)	// "ATE	
	EndIf
	                                                              
	oReport:SetCustomText({|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport)} )
	                                               
	If lAnalitico
		TRPosition():New(oSection1,"CT1",1,{|| xFilial("CT1")+cArqTmp->CONTA })
		If mv_par17 == 2
			oSection11:Cell("CONTA"):SetBlock( { || CT1->CT1_RES } )		
		Else
			oSection11:Cell("CONTA"):SetBlock( { || cArqTmp->CONTA } )		
		Endif
	Else
		oSection11:Cell("CONTA"):Disable()		
	EndIf
	
	oSection11:Cell("INF" ):Hide()
	oSection11:Cell("DIG" ):Hide()
	oSection11:Cell("DIF"):Hide()
	                                
	If !lImpDoc0
		oSection1:SetLineCondition( { || !Empty(cArqTmp->CT2KEY) } )
	EndIf	
	
	If !lTotal                                                                                                     
		
		oSection11:Cell("INF" ):HideHeader()
		oSection11:Cell("DIG" ):HideHeader()
		oSection11:Cell("DIF"):HideHeader()
	
	Else

		TRPosition():New( oSection11, "CTC", 1, {|| xFilial("CTC") + cArqTmp->( DtoS(DATAL)+LOTE+SUBLOTE+DOC+cMoeda) })
		

		oBreak1 := TRBreak():New( oReport, {|| cArqTmp->(DTOS(DATAL)+LOTE+DOC) }, STR0027) // "Total do Doc"
		oBreak1:SetPageBreak(.F.)
							
		TRFunction():New(oSection11:Cell("LANCDEB"), ,"SUM",oBreak1/*oBreak */,STR0027,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.F.,.F.)
		TRFunction():New(oSection11:Cell("LANCCRD"), ,"SUM",oBreak1/*oBreak*/ ,STR0027,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.F.,.F.)

		// Totalizadores Informado/Digitado/Diferenca por Documento
		TRFunction():New(oSection11:Cell("INF"), ,"ONPRINT",oBreak1/*oBreak */,STR0027,/*[ cPicture ]*/,;
			{ || Transform( CTC->CTC_INF, Tm(CTC->CTC_INF,17)) }/*[ uFormula ]*/,.F.,.F.)
	
		TRFunction():New(oSection11:Cell("DIG"), ,"ONPRINT",oBreak1/*oBreak*/ ,STR0027,""/*[ cPicture ]*/,;
			{ || Transform( CTC->CTC_DIG, Tm(CTC->CTC_DIG,17)) }/*[ uFormula ]*/,.F.,.F.)
			
		TRFunction():New(oSection11:Cell("DIF"), ,"ONPRINT",oBreak1/*oBreak*/ ,STR0027,""/*[ cPicture ]*/,;
			{ || Transform( Abs(CTC->CTC_DIG - CTC->CTC_INF), Tm(CTC->CTC_DIG,17)) }/*[ uFormula ]*/,.F.,.F.)
	                                                                  
		oBreak2 := TRBreak():New( oReport, {|| cArqTmp->(DtoS(DATAL)+LOTE) }, STR0028 ) // "Total do Lote"
			
		oBreak2:OnBreak( {|| aRetCT6 := CtbSaldoLote(CTC->CTC_LOTE,CTC->CTC_SBLOTE,CTC->CTC_DATA,cMoeda,mv_par08,cFilAnt)	  , nTotDocInf += aRetCT6[3], nTotDocDig += aRetCT6[4], nTotDocDif += Abs(aRetCT6[4]-aRetCT6[3]) } )
		oBreak2:SetPageBreak(lQuebraLote .Or. lQuebraDoc)
		
		// Totalizadores Informado/Digitado/Diferenca por Lote	
		TRFunction():New(oSection11:Cell("LANCDEB"), ,"SUM",oBreak2/*oBreak */,STR0028,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.T.,.F.)
		TRFunction():New(oSection11:Cell("LANCCRD"), ,"SUM",oBreak2/*oBreak*/ ,STR0028,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.T.,.F.)
	
		TRFunction():New(oSection11:Cell("INF"), ,"ONPRINT",oBreak2/*oBreak */,STR0027,/*[ cPicture ]*/,;
			{ || Transform( aRetCT6[3], Tm(CTC->CTC_INF,17)) }/*[ uFormula ]*/,.F.,.F.)
	
		TRFunction():New(oSection11:Cell("DIG"), ,"ONPRINT",oBreak2/*oBreak*/ ,STR0027,""/*[ cPicture ]*/,;
			{ || Transform( aRetCT6[4], Tm(CTC->CTC_DIG,17)) }/*[ uFormula ]*/,.F.,.F.)
			
		TRFunction():New(oSection11:Cell("DIF"), ,"ONPRINT",oBreak2/*oBreak*/ ,STR0027,""/*[ cPicture ]*/,;
			{ || Transform( Abs(aRetCT6[4] - aRetCT6[3]), Tm(CTC->CTC_DIG,17)) }/*[ uFormula ]*/,.F.,.F.)
  	                                         
		// Total geral
		TRFunction():New(oSection11:Cell("INF"), ,"ONPRINT",,,Tm(CTC->CTC_DIG,17),{ || nTotDocInf },.F.,.T.)
		TRFunction():New(oSection11:Cell("DIG"), ,"ONPRINT",,,Tm(CTC->CTC_DIG,17),{ || nTotDocDig },.F.,.T.)
		TRFunction():New(oSection11:Cell("DIF"), ,"ONPRINT",,,Tm(CTC->CTC_DIG,17),{ || nTotDocDif },.F.,.T.)
	
		// Se quebra por documento, verifica se vai quebrar o lote. Em caso afirmativo, nao quebra a pagina antes de imprimir os totais do lote
		If lQuebraDoc
			oBreak1:OnPrintTotal( { || lQbLote := ( cQbLote # cArqTmp->( DtoS(DATAL)+LOTE ) ), If(lQbLote, cQbLote := cArqTmp->(DToS(DATAL)+LOTE), .T. ),;
				Iif( lQbLote .Or. cArqTmp->(EoF()), .T., oReport:EndPage() ) } )
		EndIf                                                                                             
		
	Endif
	
	DbSelectArea("cArqTmp")
	DbGoTop()
	       
	cChaveCTC	:= cArqTmp->( DtoS(DATAL)+LOTE+SUBLOTE+DOC+"01")
	cQbLote	    := cArqTmp->( DtoS(DATAL)+LOTE)

	oSection1:Print()	   	           
	
	If lTotal
		oBreak1:SetPageBreak(.F.)
		oBreak2:SetPageBreak(.F.)
    Endif
EndIf

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³Ctbr075Flt³ Autor ³ Simone Mie Sato       ³ Data ³ 08/10/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Realiza a "filtragem" dos registros do Conf. Digitacao      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³U_Ctbr075Flt(oMeter,oText,oDlg,lEnd,cMoeda,dDataIni,dDataFim, ³±±
±±³           ³           cSaldo)   								       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ oMeter 		= Objeto oMeter                                ³±±
±±³           ³ oText  		= Objeto oText                                 ³±±
±±³           ³ oDlg   		= Objeto oDlg                                  ³±±
±±³           ³ lEnd   		= Acao do Codeblock                            ³±±
±±³           ³ cMoeda 		= Moeda                                        ³±±
±±³           ³ dDataIni 	= Data Inicial                                 ³±±
±±³           ³ dDataFim 	= Data Final                                   ³±±
±±³           ³ cSaldo		= Tipo de Saldo                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctbr075Flt(oMeter,oText,oDlg,lEnd,cMoeda,dDataIni,dDataFim,cSaldo,;
			lAnalitico,cLoteIni,cLoteFim,cSbLoteIni,cSbLoteFim,cDocIni,cDocFim,cFiltroCT1)

oMeter:nTotal := CT2->(RecCount())

dbSelectArea("CT2")
dbSetOrder(1)
MsSeek(xFilial()+dtos(dDataIni)+cLoteIni+cSbLoteIni+cDocIni,.T.)

While !Eof() .And. CT2->CT2_FILIAL == xFilial() .And. ;
	CT2->CT2_DATA >= dDataIni .And. CT2->CT2_DATA <= dDataFim 

		If !Empty(cSaldo)
			IF CT2->CT2_MOEDLC <> cMoeda .Or.;
			 CT2->CT2_VALOR == 0 .Or. CT2->CT2_TPSALD != cSaldo
				dbSkip()
				Loop
			EndIF
		ElseIf CT2->CT2_MOEDLC <> cMoeda .Or.;
		 CT2->CT2_VALOR == 0
			dbSkip()
			Loop
		EndIF

		If  (CT2->CT2_LOTE < cLoteIni .Or. CT2->CT2_LOTE > cLoteFim) .Or. ;
			(CT2->CT2_SBLOTE < cSbLoteIni .Or. CT2->CT2_SBLOTE > cSbLoteFim) .Or. ;
			(CT2->CT2_DOC < cDocIni .Or. CT2->CT2_DOC > cDocFim)
			dbSkip()
			Loop
		EndIf

		//Verifica o filtro do CT1
		If cFiltroCT1 <> Nil 
			CT1->(DbSetOrder(1))     
			If CT2->CT2_DC $ "13"
				CT1->(MsSeek(xFilial() + CT2->CT2_DEBITO))
				If !CT1->(&cFiltroCT1)    
					dbSkip()
					Loop
				Endif	
			Endif
			If CT2->CT2_DC $ "13"
				CT1->(MsSeek(xFilial() + CT2->CT2_CREDIT))
				If !CT1->(&cFiltroCT1)    
					dbSkip()
					Loop
				Endif	
			Endif
		Endif
/*
		//Verifica o filtro do CTT
		If aFiltrosR4[FILTRO_CTT] <> Nil 
			CTT->(DbSetOrder(1))     
			If CT2->CT2_DC $ "13" .And. !Empty(CT2->CT2_CCD)
				CTT->(MsSeek(xFilial() + CT2->CT2_CCD))
				If !CTT->(&aFiltrosR4[FILTRO_CTT]) 
					dbSkip()
					Loop
				Endif	
			Endif
			If CT2->CT2_DC $ "23".And. !Empty(CT2->CT2_CCC)
				CTT->(MsSeek(xFilial() + CT2->CT2_CCC))
				If !CTT->(&aFiltrosR4[FILTRO_CTT])    
					dbSkip()
					Loop
				Endif	
			Endif
		Endif
		//Verifica o filtro do CTD
		If aFiltrosR4[FILTRO_CTD] <> Nil 
			CTD->(DbSetOrder(1))     
			If CT2->CT2_DC $ "13".And. !Empty(CT2->CT2_ITEMD)
				CTD->(MsSeek(xFilial() + CT2->CT2_ITEMD))
				If !CTD->(&aFiltrosR4[FILTRO_CTD]) 
					dbSkip()
					Loop
				Endif	
			Endif
			If CT2->CT2_DC $ "23".And. !Empty(CT2->CT2_ITEMC)
				CTD->(MsSeek(xFilial() + CT2->CT2_ITEMC))
				If !CTD->(&aFiltrosR4[FILTRO_CTD])    
					dbSkip()
					Loop
				Endif	
			Endif
		Endif
		//Verifica o filtro do CTH
		If aFiltrosR4[FILTRO_CTH] <> Nil 
			CTH->(DbSetOrder(1))     
			If CT2->CT2_DC $ "13".And. !Empty(CT2->CT2_CLVLDB)
				CTH->(MsSeek(xFilial() + CT2->CT2_CLVLDB))
				If !CTH->(&aFiltrosR4[FILTRO_CTH]) 
					dbSkip()
					Loop
				Endif	
			Endif
			If CT2->CT2_DC $ "23".And. !Empty(CT2->CT2_CLVLCR)
				CTH->(MsSeek(xFilial() + CT2->CT2_CLVLCR))
				If !CTH->(&aFiltrosR4[FILTRO_CTH])    
					dbSkip()
					Loop
				Endif	
			Endif
		Endif
*/         
		If CT2->CT2_DC == "1"
			Ctbr420Grv(cMoeda,cSaldo,"1","2",lAnalitico)
		ElseIf CT2->CT2_DC == "2"
			Ctbr420Grv(cMoeda,cSaldo,"2","2",lAnalitico)
		ElseIf CT2->CT2_DC == "3"     
			Ctbr420Grv(cMoeda,cSaldo,"1","2",lAnalitico)
			Ctbr420Grv(cMoeda,cSaldo,"2","2",lAnalitico)		
		EndIf
		dbSelectArea("CT2")
		dbSetOrder(1)
		dbSkip()
	Enddo

Return                        

