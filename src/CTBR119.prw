/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR119.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE TAM_VALOR  20

Static lFWCodFil := .T.
//-------------------------------------------------------------------
/*{Protheus.doc} CTBR119
Diário do Plano Referencial
@author Simone Mie Sato Kakinoana
   
@version P12
@since   26/03/2015
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
User Function CTBR119()

Local oReport 
Local lTReport	:= TRepInUse()
Local aCtbMoeddesc	:= {}

Private aSetOfBook	:= {}
Private cPerg1		:= "CTBR119"
Private cPerg2		:= "CTBPLREF2"
Private cPlanoRef	:= ""							//Cod. Plano Ref. 
Private cVersao		:= ""							//Versão
Private dDataIni	:= CTOD("  /  /  ")				//Data Inicial
Private dDataFim	:= CTOD("  /  /  ")				//Data Final
Private cMoeda		:= "01"							//Moeda  
Private cTpSald		:= "1"							//Tipo de Saldo                                  
Private lPula     	:= .T.							//Salta por Folha?1=Sim;2=Não                                  
Private nPagIni		:= 0  							//Folha Inicial              
Private nPagFim		:= 0 							//Folha Final   
Private nReinicia	:= 0 							//Folha ao Reiniciar
Private lImpTotG	:= .T.							//Se imprime total geral
Private lSelFil		:= .T.							//Seleciona Filiais
Private lPartDob	:= .T.							//Divide Partida Dobrada
Private lResetPag	:= .T.
Private m_pag		:= 1 							//Controle de numeração de pagina
Private nBloco		:= 0
Private nBlCount		:= 1
Private l1StQb		:= .T.  
Private dDataL		:= CTOD("  /  /  ")
Private cLote		:= ""
Private cSubLote	:= ""
Private cDoc		:= ""
Private cLinha		:= ""
Private cSeq		:= ""
Private cEmpOri		:= ""
Private cFilOri		:= "" 
Private cConta		:= ""
Private cCusto		:= ""
Private cItem		:= ""
Private cClVl		:= ""

Private cTmpCT2Fil	:= ""

PRIVATE aSelFil		:= {}

If !lTReport
	Help("  ",1,"CTR119R4",,STR0011,1,0) //"Função disponível apenas TReport, verificar parametro MV_TREPORT"
	Return
EndIf

		
If Pergunte(cPerg1, .T.)

	If Empty( mv_par05 )
		Help(" ",1,"NOMOEDA")
		Return
	EndIf
	
	aCtbMoeddesc := CtbMoeda(mv_par05) // Moeda?

	 If Empty( aCtbMoeddesc[1] )
		Help(" ",1,"NOMOEDA")
		aCtbMoeddesc := nil
	    Return
	Endif	

	cPlanoRef	:= mv_par01								//Cod. Plano Referencial
	cVersao  	:= mv_par02								//Versao
	dDataIni	:= mv_par03								//Data Inicial
	dDataFim	:= mv_par04								//Data Final
	cMoeda		:= mv_par05								//Moeda  
	cTpSald		:= mv_par06								//Tipo de Saldo                                  
	lPula     	:= Iif(mv_par07 == 1,.T.,.F.)			//Salta Folha por dia? 1=Sim;2=Não                 
	nPagIni		:= mv_par08								//Folha Inicial              
	nPagFim		:= mv_par09								//Folha Final   
	nReinicia	:= mv_par10								//Folha ao Reiniciar
	lImpTotG	:= Iif(mv_par11 == 1,.T.,.F.)			//Se imprime total geral
	lSelFil		:= Iif(mv_par12 == 1,.T.,.F.)			//Seleciona Filiais
	lPartDob	:= Iif(mv_par13 == 1,.T.,.F.)			//Divide Partida Dobrada

	If Empty(cPlanoRef) .Or. Empty(cVersao)
		MsgAlert(STR0010)	//"Plano Referencial e/ou Versão não preenchidos. " 
		Return
	EndIf	
	
	DbSelectArea("CVN")
	DbSetOrder(4) 	//CVN_FILIAL+CVN_CODPLA+CVN_VERSAO+CVN_CTAREF                                                                                                                     
	If !DbSeek(xFilial("CVN")+cPlanoRef+cVersao)	
		MsgAlert(STR0009)	//"Plano Ref. e Versao não cadastrados no Cad. Plano Referencial."
		Return
	Endif

	Pergunte(cPerg2,.T.)	//Exibe a pergunta de Intervalo de Contas	                                                                                                                     
	
	If lSelFil .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Return
		EndIf
	Else
		aSelFil := {cFilAnt}
	EndIf 
		
	oReport := ReportDef()
	
	If ValType( oReport ) == "O"
	
		If ! Empty( oReport:uParam )
			Pergunte( oReport:uParam, .F. )
		EndIf	
		
		oReport :PrintDialog()
	Endif	
	
	oReport := Nil
EndIf
		

Return                                

//-------------------------------------------------------------------
/*{Protheus.doc} ReportDef
Esta funcao tem como objetivo definir as secoes, celulas,   
totalizadores do relatorio que poderao ser configurados    
pelo relatorio.                                   

@author Simone Mie Sato Kakinoana
   
@version P12
@since   26/03/2015
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function ReportDef()

Local aArea	   		:= GetArea()
Local aArqs			:= {}   
Local cReport		:= "CTBR119"
Local cTitulo		:= STR0001				   			// "Diário Plano de Contas Referencial"
Local cDesc			:= STR0002							// "Este programa ira  imprimir o diário do plano de contas referencial"
Local cSayCusto		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")
Local oSection1

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
oReport	:= TReport():New( cReport,cTitulo,cPerg1, { |oReport| ReportPrint( oReport,cTitulo ) }, cDesc ) 

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

oReport:ParamReadOnly()

If lPartDob
	aArqs	:= {"CT2","CT1","CTD","CTH","CTT"}
Else
	aArqs	:= {"CT2"}
EndIf

oReport:SetTotalInLine(.F.)

oReport:SetUseGC(.F.) // Remove botão da gestão de empresas pois conflita com a pergunta "Seleciona Filiais"

oSection1  := TRSection():New( oReport, STR0017,aArqs, , .F., .F. ) //"Dia"
oSection1:SetTotalInLine(.F.)
If lPartDob	//Se divide partida dobrada
	TRCell():New( oSection1, "CT2_DATA"  , "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_DATA")[1]+2/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection1, "CT2_CHAVE"  , "CT2",STR0007/*Titulo*/,"@!"/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)//"Lote/SubLt/Doc./Lin"
	TRCell():New( oSection1, "CT2_CONTA" , "CT2",STR0005/*Titulo*/,PesqPict("CT2","CT2_DEBITO")/*Picture*/,TAMSX3("CT2_DEBITO")[1]+5/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	//Conta
	TRCell():New( oSection1, "CVD_CTAREF", "CVD",STR0006/*Titulo*/,PesqPict("CVD","CVD_CTAREF")/*Picture*/,30/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	//Conta Ref.  
	TRCell():New( oSection1, "CT2_CUSTO", "CT2",cSayCusto/*Titulo*/,PesqPict("CT2","CT2_CCD")/*Picture*/,TAMSX3("CT2_CCD")[1]+15/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)		//C.Custo
	TRCell():New( oSection1, "CT2_ITEM", "CT2",cSayItem/*Titulo*/,PesqPict("CT2","CT2_ITEMD")/*Picture*/,TAMSX3("CT2_ITEMD")[1]+17/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)		//Item
	TRCell():New( oSection1, "CT2_CLVL", "CT2",cSayClVl/*Titulo*/,PesqPict("CT2","CT2_CLVLDB")/*Picture*/,TAMSX3("CT2_CLVLDB")[1]+25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)		//Classe de Valor
	TRCell():New( oSection1, "CT2_TIPO", "CT2",STR0008/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)				//Tipo
	TRCell():New( oSection1, "CT2_VALOR", "CT2",/*Titulo*/,/*Picture*/,/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"RIGHT",,,.F.)
	TRCell():New( oSection1, "CT2_HIST", "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_HIST")[1]+10/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,/*cAlign*/,.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)

	TRPosition():New( oSection1, "CT1", 1, {|| xFilial( "CT1" ) + cConta })
	TRPosition():New( oSection1, "CTT", 1, {|| xFilial( "CTT" ) + cCusto })
	TRPosition():New( oSection1, "CTD", 1, {|| xFilial( "CTD" ) + cItem })
	TRPosition():New( oSection1, "CTH", 1, {|| xFilial( "CTH" ) + cClVl })
	TRPosition():New( oSection1, "CT2", 1, {|| xFilial( "CT2" ) +DTOS(dDataL)+cLote+cSubLote+cDoc+cLinha+cTpSald+cEmpOri+cFilOri+cMoeda })
Else
	TRCell():New( oSection1, "CT2_DATA"  , "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_DATA")[1]+2/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection1, "CT2_CHAVE"  , "CT2",STR0007/*Titulo*/,"@!"/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)//Lote/SubLote/Doc./Linha
	TRCell():New( oSection1, "CT2_DEBITO" , "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_DEBITO")[1]+8/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection1, "CT2_CREFDEB", "CT2",STR0003/*Titulo*/,PesqPict("CVD","CVD_CTAREF")/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)//Cta.Ref.Deb.
	TRCell():New( oSection1, "CT2_CREDIT" , "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_CREDIT")[1]+8/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection1, "CT2_CREFCRD", "CT2",STR0004/*Titulo*/,PesqPict("CVD","CVD_CTAREF")/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)//Cta.Ref.Cred. 
	TRCell():New( oSection1, "CT2_CCD", "CT2",/*Titulo*/,/*Picture*/,TAMSX3("CT2_CCD")[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection1, "CT2_CCC", "CT2",/*Titulo*/,/*Picture*/,TAMSX3("CT2_CCC")[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection1, "CT2_ITEMD", "CT2",/*Titulo*/,/*Picture*/,TAMSX3("CT2_ITEMD")[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection1, "CT2_ITEMC", "CT2",/*Titulo*/,/*Picture*/,TAMSX3("CT2_ITEMC")[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection1, "CT2_CLVLDB", "CT2",/*Titulo*/,/*Picture*/,TAMSX3("CT2_CLVLDB")[1]+8/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection1, "CT2_CLVLCR", "CT2",/*Titulo*/,/*Picture*/,TAMSX3("CT2_CLVLCR")[1]+1/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection1, "CT2_VALOR", "CT2",/*Titulo*/,/*Picture*/,/*Tamanho*/TamSX3("CT2_VALOR")[1]+3, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"RIGHT",,,.F.)
	TRCell():New( oSection1, "CT2_HIST", "CT2",/*Titulo*/,/*Picture*/,35/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"LEFT"/*cAlign*/,.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRPosition():New( oSection1, "CT2", 1, {|| xFilial( "CT2" ) +DTOS(dDataL)+cLote+cSubLote+cDoc+cLinha+cTpSald+cEmpOri+cFilOri+cMoeda })	
EndIf



// Imprime Cabecalho no Topo da Pagina
oReport:Section(1):SetHeaderPage()                       
oReport:SetLandScape(.T.)
oReport:lDisableOrientation := .T. 

oSection1:SetAutoSize()

Return(oReport)
//-------------------------------------------------------------------
/*{Protheus.doc} ReportPrint
Imprime o relatorio definido pelo usuario de acordo com as  
secoes/celulas criadas na funcao ReportDef definida acima. 
Nesta funcao deve ser criada a query das secoes se SQL ou  
definido o relacionamento e filtros das tabelas em CodeBase.

@author Simone Mie Sato Kakinoana
   
@version P12
@since   26/03/2015
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function ReportPrint(oReport,cTitulo)

Local oSection1 	:= oReport:Section(1)
Local oTotDia   	:= oReport:Section(2)
Local oTotGeral 	:= oReport:Section(3)

Local cArqTmp		:= GetNextAlias()

Local nTotDebG 		:= 0
Local nTotCrdG		:= 0
Local nTotDiaD		:= 0 
Local nTotDiaC		:= 0 

Local dDataAnt		:= CTOD("  /  /  ") 

oReport:SetCustomText( {|| (Pergunte("CTBR119",.F.),CtCGCCabTR(,,,,,dDataFim,ctitulo,,,,,oReport,.T.,@lResetPag,@nPagIni,@nPagFim,@nReinicia,@m_pag,@nBloco,@nBlCount,@l1StQb)) } )

//Monta query 
Ctbr119Grv(@cArqTmp,oSection1)

DbSelectArea("cArqTmp")
DbGotop()
While !Eof()

	If oReport:Cancel()
		Exit
	EndIf
	
	oReport:IncMeter()
	oSection1:Init()
	
	If lPartDob	//Se divide partida dobrada
		oSection1:Cell("CT2_DATA"):SetValue(cArqTmp->CT2_DATA)
		oSection1:Cell("CT2_CHAVE"):SetValue(cArqTmp->CT2_LOTE+cArqTmp->CT2_SBLOTE+cArqTmp->CT2_DOC+cArqTmp->CT2_LINHA)
		oSection1:Cell("CT2_CONTA"):SetValue(cArqTmp->CONTA)
		oSection1:Cell("CVD_CTAREF"):SetValue(cArqTmp->CVD_CTAREF)  
		oSection1:Cell("CT2_CUSTO"):SetValue(cArqTmp->CUSTO)
		oSection1:Cell("CT2_ITEM"):SetValue(cArqTmp->ITEM)
		oSection1:Cell("CT2_CLVL"):SetValue(cArqTmp->CLVL)
		If cArqTmp->TIPO == "1"
			oSection1:Cell("CT2_TIPO"):SetValue("D")
		Else
			oSection1:Cell("CT2_TIPO"):SetValue("C")
		EndIf
		oSection1:Cell("CT2_VALOR"):SetValue(cArqTmp->CT2_VALOR)
		oSection1:Cell("CT2_HIST"):SetValue(cArqTmp->CT2_HIST)
		TRPosition():New( oSection1, "CT2", 1, {|| xFilial( "CT2" ) +DTOS(dDataL)+cLote+cSubLote+cDoc+cLinha+cTpSald+cEmpOri+cFilOri+cMoeda })
		If cArqTmp->TIPO == "1"
			nTotDebG += cArqTmp->CT2_VALOR
			nTotDiaD += cArqTmp->CT2_VALOR
		Else
			nTotCrdG += cArqTmp->CT2_VALOR
			nTotDiaC += cArqTmp->CT2_VALOR
		Endif
		cConta	:= cArqTmp->CONTA
		cCusto	:= cArqTmp->CUSTO
		cItem	:= cArqTmp->ITEM
		cClVl	:= cArqTmp->CLVL
	Else
		oSection1:Cell("CT2_DATA"):SetValue(cArqTmp->CT2_DATA)
		oSection1:Cell("CT2_CHAVE"):SetValue(cArqTmp->CT2_LOTE+cArqTmp->CT2_SBLOTE+cArqTmp->CT2_DOC+cArqTmp->CT2_LINHA)
		oSection1:Cell("CT2_DEBITO"):SetValue(cArqTmp->CT2_DEBITO)
		oSection1:Cell("CT2_CREFDEB"):SetValue(cArqTmp->CREFDEB)	
		oSection1:Cell("CT2_CREDIT"):SetValue(cArqTmp->CT2_CREDIT)
		oSection1:Cell("CT2_CREFCRD"):SetValue(cArqTmp->CREFCRD)
		oSection1:Cell("CT2_CCD"):SetValue(cArqTmp->CT2_CCD)
		oSection1:Cell("CT2_CCC"):SetValue(cArqTmp->CT2_CCC)
		oSection1:Cell("CT2_ITEMD"):SetValue(cArqTmp->CT2_ITEMD)		
		oSection1:Cell("CT2_ITEMC"):SetValue(cArqTmp->CT2_ITEMC)
		oSection1:Cell("CT2_CLVLDB"):SetValue(cArqTmp->CT2_CLVLDB)		
		oSection1:Cell("CT2_CLVLCR"):SetValue(cArqTmp->CT2_CLVLCR)
		oSection1:Cell("CT2_VALOR"):SetValue(cArqTmp->CT2_VALOR)
		oSection1:Cell("CT2_HIST"):SetValue(cArqTmp->CT2_HIST)
		TRPosition():New( oSection1, "CT2", 1, {|| xFilial( "CT2" ) +DTOS(dDataL)+cLote+cSubLote+cDoc+cLinha+cTpSald+cEmpOri+cFilOri+cMoeda })
		If !Empty(cArqTmp->CREFDEB)
			nTotDebG += cArqTmp->CT2_VALOR
			nTotDiaD += cArqTmp->CT2_VALOR
		EndIf
		If !Empty(cArqTmp->CREFCRD)
			nTotCrdG += cArqTmp->CT2_VALOR
			nTotDiaC += cArqTmp->CT2_VALOR
		Endif
	EndIf
	dDataL	:= cArqTmp->CT2_DATA
	cLote	:= cArqTmp->CT2_LOTE
	cSubLote:= cArqTmp->CT2_SBLOTE
	cDoc    := cArqTmp->CT2_DOC
	cLinha	:= cArqTmp->CT2_LINHA
	cSeq	:= cArqTmp->CT2_SEQLAN
	cEmpOri	:= cArqTmp->CT2_EMPORI 
	cFilOri	:= cArqTmp->CT2_FILORI
		
	oSection1:PrintLine()	
	// Faz a impressao do historico detalhado
	RpPrintHist( cArqTmp , oSection1 )
	
	DbSelectArea("cArqTmp")
	dDataAnt	:= cArqTmp->CT2_DATA
	DbSkip()
	
	If lPartDob
		TRFunction():New(oSection1:Cell("CT2_CLVL"),,"ONPRINT",,"Total Debito",,{||STR0014+Alltrim(ValorCTB(nTotDiaD  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.T.,.F.,.F.)	//" Total Déb:"
		TRFunction():New(oSection1:Cell("CT2_HIST"),,"ONPRINT",,"Total Credito",,{||STR0015+Alltrim(ValorCTB(nTotDiaC  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.T.,.F.,.F.)//" Total Crd:"
	Else
		TRFunction():New(oSection1:Cell("CT2_ITEMC"),,"ONPRINT",,"Total Debito" ,,{||STR0014},.T.,.F.,.F.)			//" Total Déb:"
		TRFunction():New(oSection1:Cell("CT2_CLVLDB"),,"ONPRINT",,"Total Debito" ,,{||Alltrim(ValorCTB(nTotDiaD  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.T.,.F.,.F.)			
		TRFunction():New(oSection1:Cell("CT2_HIST"),,"ONPRINT",,"Total Credito"  ,,{||STR0015+Alltrim(ValorCTB(nTotDiaC  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.T.,.F.,.F.) //" Total Crd:"		
	EndIf

	//IMPRIME TOTAL GERAL
	If lImpTotG
		If lPartDob	//Se divide partida dobrada
			TRFunction():New(oSection1:Cell("CT2_CLVL"),,"ONPRINT",,"Total Debito"	,,{||STR0018+Alltrim(ValorCTB(nTotDebG  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.F.,.T.,.F.)	//"Tot.Ger.D:"
			TRFunction():New(oSection1:Cell("CT2_HIST"),,"ONPRINT",,"Total Credito",,{||STR0019+Alltrim(ValorCTB(nTotCrdG  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.F.,.T.,.F.)//"Tot.Ger.C:"
		Else
			TRFunction():New(oSection1:Cell("CT2_ITEMC"),,"ONPRINT",,"Tot.Ger.Deb." ,,{||STR0018},.F.,.T.,.F.)	//"Tot.Ger.D:"
			TRFunction():New(oSection1:Cell("CT2_CLVLDB"),,"ONPRINT",,"Total Debito" ,,{||Alltrim(ValorCTB(nTotDebG  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.F.,.T.,.F.)
			TRFunction():New(oSection1:Cell("CT2_HIST"),,"ONPRINT",,"Tot.Ger.Crd"  ,,{||STR0019+Alltrim(ValorCTB(nTotCrdG  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.F.,.T.,.F.) ////"Tot.Ger.C:"

		EndIf
	Endif

	If dDataAnt <> cArqTmp->CT2_DATA 
		oSection1:Finish()
		nTotDiaD := 0
		nTotDiaC := 0 
		If lPula .And. cArqTmp->(!Eof())  
			oReport:EndPage()
		Endif	
	EndIf	
	
End

CtbTmpErase(cTmpCT2Fil)

If Select("cArqTmp") > 0
	DbSelectArea("cArqTmp")
	DbCloseArea()
Endif

Return

//-------------------------------------------------------------------
/*{Protheus.doc} Ctbr119Grv()
Monta a query e grava no arquivo temporário

@author Simone Mie Sato Kakinoana
   
@version P12
@since   27/03/2015
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function Ctbr119Grv(cArqTmp,oSection1)

Local aSaveArea	:= GetArea()

Local cQuery	:= ""
Local cWhere	:= ""

Pergunte(cPerg2,.F.)

MakeSqlExpr(cPerg2)
	
cWhere	:= MV_PAR01 //SUBSTRING(MV_PAR01,13,LEN(ALLTRIM(MV_PAR01))-13)

If lPartDob	
	cQuery	:= " SELECT * FROM "+ CRLF
	cQuery	+= " ( " + CRLF
	cQuery	+= " SELECT CT2_FILIAL,CT2_DATA,CT2_LOTE,CT2_SBLOTE,CT2_DOC,CT2_DC,'1' TIPO,CT2_DEBITO CONTA,CT2_LINHA, " + CRLF
	cQuery	+= " (SELECT CVD_CTAREF FROM "+RetSqlName("CVD") +" CVD WHERE  CVD_CONTA = CT2_DEBITO AND CVD.D_E_L_E_T_= ' ' AND CVD_CODPLA ='"+cPlanoRef+"' AND CVD_VERSAO = '"+cVersao+"') CVD_CTAREF, "+ CRLF
	cQuery	+= " CT2_CCD CUSTO, CT2_ITEMD ITEM, CT2_CLVLDB CLVL, CT2_VALOR, CT2_HIST, CT2_SEQLAN, CT2_SEQHIS, CT2_EMPORI, CT2_FILORI "+ CRLF
	cQuery	+= " FROM "+ RetSqlName("CT2")+ " CT2 " + CRLF
	cQuery	+= " WHERE CT2.CT2_FILIAL "+ GetRngFil( aSelFil, "CT2", .T., @cTmpCT2Fil ) +" "+ CRLF
	cQuery	+= " AND CT2_DC IN ('1','3') " + CRLF
	cQuery	+= " AND CT2_DATA BETWEEN '" + DTOS(dDataIni)+ "' AND '"+ DTOS(dDataFim)+"' "+ CRLF
	cQuery	+= " AND CT2_MOEDLC = '"+cMoeda+"' "+ CRLF
	cQuery	+= " AND CT2_TPSALD = '"+cTpSald+"' "+ CRLF
	cQuery	+= " AND CT2.D_E_L_E_T_ = ' ' "+ CRLF
	cQuery	+= " UNION "+ CRLF
	cQuery	+= " SELECT CT2_FILIAL,CT2_DATA,CT2_LOTE,CT2_SBLOTE,CT2_DOC,CT2_DC,'2' TIPO,CT2_CREDIT CONTA,CT2_LINHA, "+ CRLF
	cQuery	+= " (SELECT CVD_CTAREF FROM "+RetSqlName("CVD") +" CVD WHERE  CVD_CONTA = CT2_CREDIT AND CVD.D_E_L_E_T_= ' ' AND CVD_CODPLA ='"+cPlanoRef+"' AND CVD_VERSAO = '"+cVersao+"') CVD_CTAREF, "+ CRLF
	cQuery	+= " CT2_CCC CUSTO, CT2_ITEMC ITEM, CT2_CLVLCR CLVL, CT2_VALOR, CT2_HIST, CT2_SEQLAN, CT2_SEQHIS, CT2_EMPORI, CT2_FILORI "+ CRLF
	cQuery	+= " FROM "+ RetSqlName("CT2")+ " CT2 " + CRLF
	cQuery	+= " WHERE CT2.CT2_FILIAL  "+ GetRngFil( aSelFil, "CT2", .T., @cTmpCT2Fil ) +" "+ CRLF
	cQuery	+= " AND CT2_DC IN ('2','3') " + CRLF
	cQuery	+= " AND CT2_DATA BETWEEN '" + DTOS(dDataIni)+ "' AND '"+ DTOS(dDataFim)+"' "+ CRLF
	cQuery	+= " AND CT2_MOEDLC = '"+cMoeda+"' "+ CRLF
	cQuery	+= " AND CT2_TPSALD = '"+cTpSald+"' "+ CRLF
	cQuery	+= " AND CT2.D_E_L_E_T_ = ' ' "+ CRLF
	cQuery	+= " ) CT2DIA "+CRLF
	cQuery	+= " WHERE "+CRLF
	cQuery	+= " CVD_CTAREF <> '' "+CRLF
	If !Empty(cWhere) 
		cQuery	+= " AND "
		cQuery  += cWhere 
	EndIf
	cQuery	+= " ORDER BY CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA "+ CRLF
	//Passar pelo ChangeQuery se não for DB2.
	If Alltrim(Upper(TCGetDB())) <> "DB2"
		cQuery := ChangeQuery(cQuery)
	EndIf
Else
	cQuery	:= " SELECT * FROM "+ CRLF
	cQuery	+= " ( " + CRLF
	cQuery	+= " SELECT CT2_FILIAL,CT2_DATA,CT2_LOTE,CT2_SBLOTE,CT2_DOC,CT2_DC,CT2_DEBITO, "+CRLF
	cQuery	+= " (SELECT CVD_CTAREF FROM "+RetSqlName("CVD")+" CVD WHERE  CVD_CONTA = CT2_DEBITO AND CVD.D_E_L_E_T_= ' ' AND CVD_CODPLA ='"+cPlanoRef+"' AND CVD_VERSAO = '"+cVersao+"'"
	IF !Empty(cWhere)
		cQuery	+= " AND "+ cWhere + CRLF
	Endif
	cQuery	+= ") CREFDEB,"+CRLF 
	cQuery	+= " CT2_CREDIT , "+CRLF
	cQuery	+= " (SELECT CVD_CTAREF FROM "+RetSqlName("CVD")+" CVD WHERE  CVD_CONTA = CT2_CREDIT AND CVD.D_E_L_E_T_= ' ' AND CVD_CODPLA ='"+cPlanoRef+"' AND CVD_VERSAO = '"+cVersao+"'"
	IF !Empty(cWhere)
		cQuery	+= " AND "+ cWhere + CRLF
	Endif
	cQuery	+=  ") CREFCRD, "+CRLF
	cQuery	+= " CT2_LINHA, CT2_CCD, CT2_CCC, CT2_ITEMD, CT2_ITEMC, CT2_CLVLDB, CT2_CLVLCR, CT2_VALOR, CT2_HIST, CT2_SEQLAN, CT2_SEQHIS, CT2_EMPORI, CT2_FILORI "+CRLF 
	cQuery	+= " FROM "+ RetSqlName("CT2")+ " CT2 "+CRLF
	cQuery	+= " WHERE CT2.CT2_FILIAL  "+ GetRngFil( aSelFil, "CT2", .T., @cTmpCT2Fil ) +" "+CRLF
	cQuery	+= " AND CT2_DATA BETWEEN '" + DTOS(dDataIni)+ "' AND '"+ DTOS(dDataFim)+"' "+CRLF
	cQuery	+= " AND CT2_DC <> '4'"+CRLF
	cQuery	+= " AND CT2_MOEDLC = '"+cMoeda+"' "+CRLF
	cQuery	+= " AND CT2_TPSALD = '"+cTpSald+"' "+CRLF
	cQuery	+= " AND CT2.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " ) CT2DIA "+CRLF
	cQuery	+= " WHERE ( CREFDEB <> '' OR CREFCRD <> '' )	
	cQuery	+= " ORDER BY CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA "
	cQuery := ChangeQuery(cQuery)
EndIf

If Select("cArqTmp") > 0
	DbSelectArea("cArqTmp")
	DbCloseArea()
Endif

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cArqTmp",.T.,.F.)

TcSetField("cArqTmp","CT2_DATA","D",8,0)

Pergunte(cPerg1,.F.)

RestArea(aSaveArea)

Return

//-------------------------------------------------------------------
/*{Protheus.doc} RpPrintHist()
Impressão do histórico detalhado

@author Simone Mie Sato Kakinoana
   
@version P12
@since   27/03/2015
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function RpPrintHist( cArqTmp , oSection1 )

Local nReg		:= 0
Local cQuery	:= ""

If lPartDob	//Se divide partida dobrada
	oSection1:Cell("CT2_DATA"):SetValue(cArqTmp->CT2_DATA)
	oSection1:Cell("CT2_CHAVE"):SetValue(cArqTmp->CT2_LOTE+cArqTmp->CT2_SBLOTE+cArqTmp->CT2_DOC+cArqTmp->CT2_LINHA)
	oSection1:Cell("CT2_CONTA"):SetBlock( { || '' } )
	oSection1:Cell("CVD_CTAREF"):SetBlock( { || '' } )  
	oSection1:Cell("CT2_CUSTO"):SetBlock( { || '' } )
	oSection1:Cell("CT2_ITEM"):SetBlock( { || '' } )
	oSection1:Cell("CT2_CLVL"):SetBlock( { || '' } )
	oSection1:Cell("CT2_TIPO"):SetBlock( { || '' } )	
	oSection1:Cell("CT2_VALOR"):SetBlock( { || 0  } )
Else
	oSection1:Cell("CT2_DATA"):SetValue(cArqTmp->CT2_DATA)
	oSection1:Cell("CT2_CHAVE"):SetValue(cArqTmp->CT2_LOTE+cArqTmp->CT2_SBLOTE+cArqTmp->CT2_DOC+cArqTmp->CT2_LINHA)
	oSection1:Cell("CT2_DEBITO"):SetBlock( { || '' } )
	oSection1:Cell("CT2_CREFDEB"):SetBlock( { || '' } )	
	oSection1:Cell("CT2_CREDIT"):SetBlock( { || '' } )
	oSection1:Cell("CT2_CREFCRD"):SetBlock( { || '' } )
	oSection1:Cell("CT2_CCD"):SetBlock( { || '' } )
	oSection1:Cell("CT2_CCC"):SetBlock( { || '' } )
	oSection1:Cell("CT2_ITEMD"):SetBlock( { || '' } )		
	oSection1:Cell("CT2_ITEMC"):SetBlock( { || '' } )
	oSection1:Cell("CT2_CLVLDB"):SetBlock( { || '' } )		
	oSection1:Cell("CT2_CLVLCR"):SetBlock( { || '' } )
	oSection1:Cell("CT2_VALOR"):SetBlock( { || 0  } )
EndIf

// Procura pelo complemento de historico
dbSelectArea( "cArqTmp" )
nReg := Recno()

cQuery	:= " SELECT R_E_C_N_O_ RECNO "
cQuery	+= " FROM "+ RetSqlName("CT2") + CRLF
cQuery	+= " WHERE CT2_FILIAL  = '"+xFilial("CT2")+"' "+ CRLF
cQuery	+= " AND CT2_DATA = '"+DTOS(dDataL)+"' "+ CRLF
cQuery	+= " AND CT2_LOTE = '"+cLote+"' "+ CRLF
cQuery	+= " AND CT2_SBLOTE = '"+cSubLote+"' "+ CRLF
cQuery	+= " AND CT2_DOC ='"+cDoc+"' "+ CRLF
cQuery	+= " AND CT2_SEQLAN ='"+cSeq+"' "+ CRLF
cQuery	+= " AND CT2_EMPORI ='"+cEmpOri+"' "+ CRLF
cQuery	+= " AND CT2_FILORI ='"+cFilOri+"' "+ CRLF
cQuery	+= " AND CT2_DC = '4' "+ CRLF
cQuery	+= " ORDER BY CT2_SEQHIS"+ CRLF

cQuery	:= ChangeQuery(cQuery)

If Select("cHistCompl") > 0
	DbSelectArea("cHistCompl")
	DbCloseArea()
Endif

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cHistCompl",.T.,.F.)

DbSelectArea("cHistCompl")
DbGotop()
While !Eof()
	CT2->(dbGoto(cHistCompl->RECNO))
	oSection1:Cell("CT2_DATA"):SetValue(CT2->CT2_DATA)
	oSection1:Cell("CT2_CHAVE"):SetValue(CT2->CT2_LOTE+CT2->CT2_SBLOTE+CT2->CT2_DOC+CT2->CT2_LINHA)
	oSection1:Cell( "CT2_HIST"  ):SetValue(CT2->CT2_HIST)
	cLinha	:= CT2->CT2_LINHA
	cConta	:= SPACE(TAMSX3("CT2_DEBITO")[1])
	cCusto	:= SPACE(TAMSX3("CT2_CCD")[1])
	cItem	:= SPACE(TAMSX3("CT2_ITEMD")[1])
	cClVl	:= SPACE(TAMSX3("CT2_CLVLDB")[1])
	oSection1:PrintLine()																	
	dbSkip()
EndDo
		
If Select("cHistCompl") > 0
	DbSelectArea("cHistCompl")
	DbCloseArea()
Endif

dbSelectArea("CT2")
dbSetOrder(1)					

dbSelectArea("cArqTmp")
dbGoto( nReg )

Return                                                                                                                                                                                                                             
