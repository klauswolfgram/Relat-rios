/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR404.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE TAM_VALOR  20

Static lFWCodFil   := .T.
Static _oCTBR404 := NIL

//-------------------------------------------------------------------
/*{Protheus.doc} CTBR404
Razão do Plano Referencial
@author Simone Mie Sato Kakinoana
   
@version P12
@since   10/04/2015
@return  Nil
@obs	 
*/
//--------------------------------a-----------------------------------
User Function CTBR404()

Local oReport 
Local lTReport	:= TRepInUse()
Local aCtbMoeddesc	:= {}

Private aSetOfBook	:= {}
Private cPerg1		:= "CTBR404"
Private cPerg2		:= "CTBPLREF"
Private cPlanoRef	:= ""							//Codigo Plano Referencial
Private cVersao		:= ""							//Versão
Private dDataIni	:= CTOD("  /  /  ")				//Data Inicial
Private dDataFim	:= CTOD("  /  /  ")				//Data Final
Private cMoeda		:= "01"							//Moeda  
Private cTpSald		:= "1"							//Tipo de Saldo
Private lImpSemMov	:= .T.							//Imprime conta sem movimento                                  
Private lPula     	:= .T.							//Salta por Folha?1=Sim;2=Não                                  
Private nPagIni		:= 0  							//Folha Inicial              
Private nPagFim		:= 0 							//Folha Final   
Private nReinicia	:= 0 							//Folha ao Reiniciar
Private lImpTotG	:= .T.							//Se imprime total geral
Private cDescMoeda	:= "" 							//Descrição na Moeda
Private lSelFil		:= .T.							//Seleciona Filiais
Private lContaPart	:= .T.							//Define se ira trazer conta partida
Private lPartDob	:= .T.							//Divide Partida Dobrada
Private lResetPag	:= .T.
Private m_pag		:= 1 							//Controle de numeração de pagina
Private nBloco		:= 0
Private nBlCount	:= 1
Private l1StQb		:= .T.  
Private lTodasFil 	:= .F.
Private dDataL		:= CTOD("  /  /  ")
Private cLote		:= ""
Private cSubLote	:= ""
Private cDoc		:= ""
Private cLinha		:= ""
Private cSeq		:= ""
Private cEmpOri		:= ""
Private cFilOri		:= "" 

Private cTmpCT2Fil	:= ""

PRIVATE aSelFil		:= {}
Private cArqTmp		:= GetNextAlias()

If !lTReport
	Help("  ",1,"CTR4045R4",,STR0020,1,0) //"Função disponível apenas TReport, verificar parametro MV_TREPORT"
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
	cVersao		:= mv_par02								//Versao do Plano Referencial
	dDataIni	:= mv_par03								//Data Inicial
	dDataFim	:= mv_par04								//Data Final
	cMoeda		:= mv_par05								//Moeda  
	cTpSald		:= mv_par06								//Tipo de Saldo
	lImpSemMov	:= Iif(mv_par07 == 1,.T.,.F.)			//Imprime conta sem movimento                        
	lPula     	:= Iif(mv_par08 == 1,.T.,.F.)			//Salta Folha por dia? 1=Sim;2=Não                 
	nPagIni		:= mv_par09								//Folha Inicial              
	nPagFim		:= mv_par10								//Folha Final   
	nReinicia	:= mv_par11								//Folha ao Reiniciar
	lImpTotG	:= Iif(mv_par12 == 1,.T.,.F.)			//Se imprime total geral
	lSelFil		:= Iif(mv_par13 == 1,.T.,.F.)			//Seleciona Filiais
	lContaPart	:= Iif(mv_par14 == 1,.T.,.F.)			//Imprime Conta Partida
	lPartDob	:= Iif(mv_par15 == 1,.T.,.F.)			//Divide Partida Dobrada
	
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
		aSelFil := AdmGetFil(@lTodasFil)
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
@since   10/04/2015
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function ReportDef()

Local aArea	   		:= GetArea()
Local aArqs			:= {"CT2"}   
Local aAreaCVN		:= CVN->(GetArea())
Local cReport		:= "CTBR404"
Local cTitulo		:= STR0001				   			// "Razão Plano Referencial"
Local cDesc			:= STR0002							// "Este programa ira  imprimir o razão do plano de contas referencial"
Local cSayCusto		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")
Local oSection1
Local oSection2
Local oTotCta
Local oTotGeral	
Local nTamCtaRef	:= Len(CriaVar("CVD_CTAREF"))
Local cDescPlRef	:= ""

DbSelectArea("CVN")
DbSetOrder(5) //CVN_FILIAL+CVN_CODPLA+CVN_VERSAO+CVN_LINHA
If DbSeek(xFilial("CVN")+cPlanoRef+cVersao)
	cDescPlRef	:= Alltrim(CVN->CVN_DSCPLA)
EndIf
RestArea(aAreaCVN)

cTitulo 	:= cTitulo + ":"+Alltrim(cPlanoRef)+" "+STR0027+":"+cVersao+" - "+cDescPlRef
cTitulo		:= UPPER(cTitulo)

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

oReport:SetTotalInLine(.F.)

oReport:SetUseGC(.F.) // Remove botão da gestão de empresas pois conflita com a pergunta "Seleciona Filiais"

oSection1  := TRSection():New( oReport, STR0001,"CVN", , .F., .F. ) //"Razão Plano de Contas Referencial"

TRCell():New( oSection1, "CVN_CTAREF", "cArqTmp",UPPER(STR0006)/*Titulo*/,PesqPict("CVN","CVN_CTAREF")/*Picture*/,TAMSX3("CVN_CTAREF")[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	//Conta Ref.

If lPartDob
	If lContaPart
		TRCell():New( oSection1, "CVN_DSCCTA", "cArqTmp",UPPER(STR0017)/*Titulo*/,PesqPict("CVN","CVN_DSCCTA")/*Picture*/,114/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	//Descrição
		TRCell():New( oSection1, "SALDOANT"	,"cArqTmp",UPPER(STR0022),/*Picture*/,76,/*lPixel*/,/*{|| }*/,/*"RIGHT"*/,,"LEFT",,,.F.)// "SALDO ANTERIOR"
	Else
		TRCell():New( oSection1, "CVN_DSCCTA", "cArqTmp",UPPER(STR0017)/*Titulo*/,PesqPict("CVN","CVN_DSCCTA")/*Picture*/,116/*Tamanho	*/,/*lPixel*/,/*CodeBlock*/)	//Descrição
		TRCell():New( oSection1, "SALDOANT"	,"cArqTmp",UPPER(STR0022),/*Picture*/,74,/*lPixel*/,/*{|| }*/,/*"RIGHT"*/,,"LEFT",,,.F.)// "SALDO ANTERIOR"
	EndIf
Else	
	If lContaPart
		TRCell():New( oSection1, "CVN_DSCCTA", "cArqTmp",UPPER(STR0017)/*Titulo*/,PesqPict("CVN","CVN_DSCCTA")/*Picture*/,140/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	//Descrição
		TRCell():New( oSection1, "SALDOANT"	,"cArqTmp",UPPER(STR0022),/*Picture*/,50,/*lPixel*/,/*{|| }*/,/*"RIGHT"*/,,"LEFT",,,.F.)// "SALDO ANTERIOR"
	Else
		TRCell():New( oSection1, "CVN_DSCCTA", "cArqTmp",UPPER(STR0017)/*Titulo*/,PesqPict("CVN","CVN_DSCCTA")/*Picture*/,130/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	//Descrição
		TRCell():New( oSection1, "SALDOANT"	,"cArqTmp",UPPER(STR0022),/*Picture*/,60,/*lPixel*/,/*{|| }*/,/*"RIGHT"*/,,"LEFT",,,.F.)// "SALDO ANTERIOR"
	Endif
Endif
oSection1:Cell("SALDOANT"):SetHeaderAlign("LEFT")

oSection1:SetReadOnly()
oSection1:SetEdit(.F.)

oSection2  := TRSection():New( oReport, STR0006,aArqs, , .F., .F. ) //"Conta Ref."
oSection2:SetTotalInLine(.F.)
If lPartDob	//Se divide partida dobrada
	TRCell():New( oSection2, "CT2_DATA"  , "cArqTmp",STR0018/*Titulo*/, /*Picture*/,15/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,/*nALign*/ ,/*lLineBreak*/,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )	
	TRCell():New( oSection2, "CT2_CHAVE" , "cArqTmp",STR0007/*Titulo*/,"@!"/*Picture*/,50/*Tamanho*/,/*lPixel*/,{|| cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA }/*CodeBlock*/)//Lote/SubLote/Doc./Linha
	TRCell():New( oSection2, "CT2_CONTA" , "cArqTmp",STR0005/*Titulo*/,PesqPict("CT2","CT2_DEBITO")/*Picture*/,TAMSX3("CT2_DEBITO")[1]+5/*Tamanho*/,/*lPixel*/,{|| cArqTmp->CONTA}/*CodeBlock*/)	//Conta	
	If lContaPart
		TRCell():New( oSection2, "CT2_CTPART" , "cArqTmp",STR0021/*Titulo*/,PesqPict("CT2","CT2_DEBITO")/*Picture*/,TAMSX3("CT2_DEBITO")[1]+5/*Tamanho*/,/*lPixel*/,{|| cArqTmp->XPARTIDA}/*CodeBlock*/)	//Conta Partida
	EndIf
	TRCell():New( oSection2, "CT2_CUSTO", "cArqTmp",cSayCusto/*Titulo*/,PesqPict("CT2","CT2_CCD")/*Picture*/,TAMSX3("CT2_CCD")[1]+15/*Tamanho*/,/*lPixel*/,{|| cArqTmp->CUSTO}/*CodeBlock*/)		//C.Custo
	TRCell():New( oSection2, "CT2_ITEM" , "cArqTmp",cSayItem/*Titulo*/,PesqPict("CT2","CT2_ITEMD")/*Picture*/,TAMSX3("CT2_ITEMD")[1]+15/*Tamanho*/,/*lPixel*/,{|| cArqTmp->ITEM }/*CodeBlock*/)		//Item
	TRCell():New( oSection2, "CT2_CLVL" , "cArqTmp",cSayClVl/*Titulo*/,PesqPict("CT2","CT2_CLVLDB")/*Picture*/,TAMSX3("CT2_CLVLDB")[1]+15/*Tamanho*/,/*lPixel*/,{|| cArqTmp->CLVL }/*CodeBlock*/)		//Classe de Valor
	TRCell():New( oSection2, "CT2_TIPO" , "cArqTmp",STR0008/*Titulo*/,/*Picture*/,6/*Tamanho*/,/*lPixel*/,{|| cArqTmp->TIPO}/*CodeBlock*/)				//Tipo
	TRCell():New( oSection2, "CT2_VALOR", "cArqTmp",STR0019/*Titulo*/,/*Picture*/,/*Tamanho*/, /*lPixel*/, {|| ValorCTB(cArqTmp->VALOR,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.) }/*CodeBlock*/, /*"RIGHT"*/,,"RIGHT",,,.F.)//Valor
	TRCell():New( oSection2, "CT2_HIST" , "",STR0026/*Titulo*/,/*Picture*/,TAMSX3("CT2_HIST")[1]+50/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)//Historico
	
	If lContaPart
		oSection2:Cell("CT2_HIST"):SetSize(TAMSX3("CT2_HIST")[1]+80)
	Else
		oSection2:Cell("CT2_HIST"):SetSize(TAMSX3("CT2_HIST")[1]+55)
	EndIF	
	oSection2:Cell("TIPO"):SetAlign("CENTER")
	TRPosition():New( oSection2, "CT2", 1, {|| xFilial( "CT2" ) +DTOS(dDataL)+cLote+cSubLote+cDoc+cLinha+cTpSald+cEmpOri+cFilOri+cMoeda })
Else
	TRCell():New( oSection2, "CT2_DATA"   , "CT2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection2, "CT2_CHAVE"  , "CT2",STR0007/*Titulo*/,"@!"/*Picture*/,65/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)//Lote/SubLote/Doc./Linha
	TRCell():New( oSection2, "CT2_CONTA" , "CT2",STR0005/*Titulo*/,PesqPict("CT2","CT2_DEBITO")/*Picture*/,TAMSX3("CT2_DEBITO")[1]+5/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	//Conta
	If lContaPart
		TRCell():New( oSection2, "CT2_CTPART" , "CT2",STR0021/*Titulo*/,PesqPict("CT2","CT2_DEBITO")/*Picture*/,TAMSX3("CT2_DEBITO")[1]+5/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	//Conta Partida
	EndIf
	TRCell():New( oSection2, "CT2_CCD"	  , "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_CCD")[1]+10/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection2, "CT2_CCC"	  , "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_CCC")[1]+10/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection2, "CT2_ITEMD"  , "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_ITEMD")[1]+10/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection2, "CT2_ITEMC"  , "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_ITEMC")[1]+10/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection2, "CT2_CLVLDB" , "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_CLVLDB")[1]+10/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection2, "CT2_CLVLCR" , "CT2",/*Titulo*/,/*Picture*/,TamSX3("CT2_CLVLCR")[1]+10/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
	TRCell():New( oSection2, "CT2_VLRDEB" , "CT2",STR0024/*Titulo*/,/*Picture*/,/*Tamanho*/TamSX3("CT2_VALOR")[1]+15, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"RIGHT",,,.F.)//"Valor Debito"
	TRCell():New( oSection2, "CT2_VLRCRD" , "CT2",STR0025/*Titulo*/,/*Picture*/,/*Tamanho*/TamSX3("CT2_VALOR")[1]+15, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"RIGHT",,,.F.)//"Valor Credito"
	TRCell():New( oSection2, "CT2_HIST"  , "CT2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
		
	If lContaPart
		oSection2:Cell("CT2_HIST"):SetSize(TAMSX3("CT2_HIST")[1]+62)
	Else
		oSection2:Cell("CT2_CHAVE"):SetSize(50)	
		oSection2:Cell("CT2_HIST"):SetSize(TAMSX3("CT2_HIST")[1]+62)		
	EndIf	
TRPosition():New( oSection2, "CT2", 1, {|| xFilial( "CT2" ) +DTOS(dDataL)+cLote+cSubLote+cDoc+cLinha+cTpSald+cEmpOri+cFilOri+cMoeda })
EndIf

oSection2:Cell("CT2_DATA"):SetSize(TamSX3("CT2_DATA")[1]+5)


// Imprime Cabecalho no Topo da Pagina
oReport:SetLandScape(.T.)
oReport:lDisableOrientation := .T. 
oSection2:SetAutoSize()

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

Local aSaldo		:= {}
Local aSaldoAnt		:= {}

Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)

Local cCtaRefAnt	:= ""	

Local nTotDebG 		:= 0
Local nTotCrdG		:= 0
Local nTotCtaD		:= 0 
Local nTotCtaC		:= 0
Local nSaldoAnt		:= 0
Local nTotSaldoAtu	:= 0
Local nSaldoAtu		:= 0   

Local lFirst		:= .T.

oReport:SetCustomText( {|| (Pergunte("CTBR404",.F.),CtCGCCabTR(,,,,,dDataFim,ctitulo,,,,,oReport,.T.,@lResetPag,@nPagIni,@nPagFim,@nReinicia,@m_pag,@nBloco,@nBlCount,@l1StQb)) } )

//Monta query 
Ctbr404Grv(@cArqTmp)

DbSelectArea("cArqTmp")
DbGotop()
While !Eof()

	If oReport:Cancel()
		Exit
	EndIf
	
	If !lImpSemMov .And. (cArqTmp->NOMOV == "T" .Or. Empty(cArqTmp->NOMOV))
		dbSkip()
		Loop
	Endif
	
	If lFirst .Or. cCtaRefAnt <> cArqTmp->CTAREF
	
		aSaldoAnt := SaldoCVNFil(cPlanoRef,cVersao,cArqTmp->CTAREF,dDataIni,cMoeda,cTpSald,.F.,,aSelFil)
				
		nSaldoAnt	:= aSaldoAnt[6] 	
		nSaldoAtu	:= nSaldoAnt
		oSection1:Init()
		oSection1:Cell("CVN_CTAREF"):SetValue(cArqTmp->CTAREF)
		oSection1:Cell("CVN_DSCCTA"):SetValue(cArqTmp->DSCCTAREF)
		oSection1:Cell("SALDOANT"):SetBlock( {||   ALLTRIM(ValorCTB(nSaldoAnt,,,TAM_VALOR,,.T.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.)) } )//"SALDO"
		oSection1:Cell("SALDOANT"):SetAlign("LEFT")
		oSection1:PrintLine()
		oSection1:Finish()
		oReport:SkipLine()
		nSaldoAnt	:= 0 
		lFirst	:= .F.
	EndIf
	
	oReport:IncMeter()
	oSection2:Init()
	
	If lPartDob	//Se divide partida dobrada

		If Empty(cArqTmp->NOMOV) .Or. cArqTmp->NOMOV == "T"	//Se não tem movimento
			oSection2:Cell("CT2_DATA"):Hide()
			oSection2:Cell("CT2_CHAVE"):SetValue(STR0011)	//"Conta Ref. sem movimento"
			oSection2:Cell("CT2_TIPO"):Hide()
			oSection2:Cell("CT2_CONTA"):Hide()
			If lContaPart
				oSection2:Cell("CT2_CTPART"):Hide()			
			EndIf
			oSection2:Cell("CT2_CUSTO"):Hide()
			oSection2:Cell("CT2_ITEM"):Hide()
			oSection2:Cell("CT2_CLVL"):Hide()
			oSection2:Cell("CT2_VALOR"):Hide()
			oSection2:Cell("CT2_HIST"):Hide()
		Else
			oSection2:Cell("CT2_DATA"):SetValue(cArqTmp->DATAL)
			oSection2:Cell("CT2_CHAVE"):SetValue(cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA)
			oSection2:Cell("CT2_CONTA"):SetValue(cArqTmp->CONTA)
			If lContaPart
				oSection2:Cell("CT2_CTPART"):SetValue(cArqTmp->XPARTIDA)			
			EndIf
			oSection2:Cell("CT2_CUSTO"):SetValue(cArqTmp->CUSTO)
			oSection2:Cell("CT2_ITEM"):SetValue(cArqTmp->ITEM)
			oSection2:Cell("CT2_CLVL"):SetValue(cArqTmp->CLVL)
			If cArqTmp->TIPO == "1"
				oSection2:Cell("CT2_TIPO"):SetValue("D")
			Else
				oSection2:Cell("CT2_TIPO"):SetValue("C")
			EndIf
			
			oSection2:Cell("CT2_VALOR"):SetValue(cArqTmp->VALOR)  
			oSection2:Cell("CT2_HIST"):SetValue(cArqTmp->HIST)
			If cArqTmp->TIPO == "1"
				nTotDebG 	+= cArqTmp->VALOR
				nTotCtaD 	+= cArqTmp->VALOR
				nSaldoAtu 	:= nSaldoAtu - cArqTmp->VALOR 
			Else
				nTotCrdG 	+= cArqTmp->VALOR
				nTotCtaC 	+= cArqTmp->VALOR
				nSaldoAtu 	:= nSaldoAtu + cArqTmp->VALOR
			Endif
			
		EndIf
	Else
		If Empty(cArqTmp->NOMOV) .Or. cArqTmp->NOMOV == "T"	//Se não tem movimento
			oSection2:Cell("CT2_DATA"):Hide()
			oSection2:Cell("CT2_CHAVE"):SetValue(STR0011)	//"Conta Ref. sem movimento"			
			oSection2:Cell("CT2_CONTA"):Hide()
			If lContaPart
				oSection2:Cell("CT2_CTPART"):Hide()			
			EndIf
			oSection2:Cell("CT2_CCD"):Hide()
			oSection2:Cell("CT2_CCC"):Hide()
			oSection2:Cell("CT2_ITEMD"):Hide()
			oSection2:Cell("CT2_ITEMC"):Hide()
			oSection2:Cell("CT2_CLVLDB"):Hide()
			oSection2:Cell("CT2_CLVLCR"):Hide()
			oSection2:Cell("CT2_VLRDEB"):Hide()
			oSection2:Cell("CT2_VLRCRD"):Hide()
			oSection2:Cell("CT2_HIST"):Hide()
		Else
			oSection2:Cell("CT2_DATA"):SetValue(cArqTmp->DATAL)
			oSection2:Cell("CT2_CHAVE"):SetValue(cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA)
			oSection2:Cell("CT2_CONTA"):SetValue(cArqTmp->CONTA)
			If cArqTmp->TIPO == "1"
				oSection2:Cell("CT2_CCD"):SetValue(cArqTmp->CCD)	
				oSection2:Cell("CT2_ITEMD"):SetValue(cArqTmp->ITEMD)
				oSection2:Cell("CT2_CLVLDB"):SetValue(cArqTmp->CLVLDB)
				oSection2:Cell("CT2_VLRDEB"):SetValue(cArqTmp->VLRDEB)			
				oSection2:Cell("CT2_VLRDEB"):SetPicture(PesqPict("CT2","CT2_VALOR"))
				oSection2:Cell("CT2_VLRCRD"):SetPicture(PesqPict("CT2","CT2_VALOR"))
				If lContaPart
					oSection2:Cell("CT2_CTPART"):SetValue(cArqTmp->XPARTIDA)				
					oSection2:Cell("CT2_CCC"):SetValue(cArqTmp->CCC)
					oSection2:Cell("CT2_ITEMC"):SetValue(cArqTmp->ITEMC)
					oSection2:Cell("CT2_CLVLCR"):SetValue(cArqTmp->CLVLCR)
					oSection2:Cell("CT2_VLRCRD"):SetValue(cArqTmp->VLRCRD)
					oSection2:Cell("CT2_VLRCRD"):SetPicture(PesqPict("CT2","CT2_VALOR"))
					
					If cArqTmp->VLRCRD == 0 //Inibe valores zerados
						oSection2:Cell("CT2_VLRCRD"):Hide()
					EndIf
				Else
					oSection2:Cell("CT2_CCC"):Hide()
					oSection2:Cell("CT2_ITEMC"):Hide()
					oSection2:Cell("CT2_CLVLCR"):Hide()
					oSection2:Cell("CT2_VLRCRD"):Hide()
				EndIf
			Else
				oSection2:Cell("CT2_CCC"):SetValue(cArqTmp->CCC)
				oSection2:Cell("CT2_ITEMC"):SetValue(cArqTmp->ITEMC)
				oSection2:Cell("CT2_CLVLCR"):SetValue(cArqTmp->CLVLCR)	
				oSection2:Cell("CT2_VLRCRD"):SetValue(cArqTmp->VLRCRD)
				oSection2:Cell("CT2_VLRCRD"):SetPicture(PesqPict("CT2","CT2_VALOR"))
				oSection2:Cell("CT2_VLRDEB"):SetPicture(PesqPict("CT2","CT2_VALOR"))		
				If lContaPart
					oSection2:Cell("CT2_CTPART"):SetValue(cArqTmp->XPARTIDA)
					oSection2:Cell("CT2_CCD"):SetValue(cArqTmp->CCD)	
					oSection2:Cell("CT2_ITEMD"):SetValue(cArqTmp->ITEMD)
					oSection2:Cell("CT2_CLVLDB"):SetValue(cArqTmp->CLVLDB)
					oSection2:Cell("CT2_VLRDEB"):SetValue(cArqTmp->VLRDEB)
					oSection2:Cell("CT2_VLRDEB"):SetPicture(PesqPict("CT2","CT2_VALOR"))

					If cArqTmp->VLRDEB == 0 //Inibe valores zerados
						oSection2:Cell("CT2_VLRDEB"):Hide()
					EndIf
				Else
					oSection2:Cell("CT2_CCD"):Hide() 
					oSection2:Cell("CT2_ITEMD"):Hide()
					oSection2:Cell("CT2_CLVLDB"):Hide()
					oSection2:Cell("CT2_VLRDEB"):Hide()
				EndIf				
			EndIf			  
			oSection2:Cell("CT2_HIST"):SetValue(cArqTmp->HIST)
			
			nTotDebG 	+= cArqTmp->VLRDEB
			nTotCtaD 	+= cArqTmp->VLRDEB
			nTotCrdG 	+= cArqTmp->VLRCRD
			nTotCtaC 	+= cArqTmp->VLRCRD
			nSaldoAtu 	:= nSaldoAtu - cArqTmp->VLRDEB + cArqTmp->VLRCRD
		EndIf
	EndIf
	If lImpTotG
		nTotSaldoAtu := nSaldoAtu
		If lPartDob
				TRFunction():New(oSection2:Cell("CT2_CONTA"),,"ONPRINT",,"Total Debito"     ,,{||STR0014+":"},.F.,.T.,.F.) //Total Debito
				If lContaPart				
					TRFunction():New(oSection2:Cell("CT2_CTPART"),,"ONPRINT",,"Debito"     ,,{||Alltrim(ValorCTB(nTotDebG  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.F.,.T.,.F.)
				Else
					TRFunction():New(oSection2:Cell("CT2_CUSTO"),,"ONPRINT",,"Debito"     ,,{||Alltrim(ValorCTB(nTotDebG  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.F.,.T.,.F.)				
				Endif
				TRFunction():New(oSection2:Cell("CT2_ITEM") ,,"ONPRINT",,"Total Credito",,{||STR0015+":"},.F.,.T.,.F.)	//" Total Crédito"
				TRFunction():New(oSection2:Cell("CT2_CLVL"),,"ONPRINT",,"Debito"     ,,{||Alltrim(ValorCTB(nTotCrdG  ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.F.,.T.,.F.)
		Else
			TRFunction():New(oSection2:Cell("CT2_VLRDEB"),,"ONPRINT",,"Debito"     ,,{||nTotDebG},.F.,.T.,.F.)
			TRFunction():New(oSection2:Cell("CT2_VLRCRD"),,"ONPRINT",,"Credito"    ,,{||nTotCrdG},.F.,.T.,.F.)
		EndIf
	EndIf
	
	If lPartDob	
		TRFunction():New(oSection2:Cell("CT2_CONTA"),,"ONPRINT",,"Debito",,     {||STR0014+":" },.T.,.F.,.F.)
		If lContaPart
			TRFunction():New(oSection2:Cell("CT2_CTPART"),,"ONPRINT",,"",,     {||Alltrim(ValorCTB(nTotCtaD ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.T.,.F.,.F.)		
		Else		
			TRFunction():New(oSection2:Cell("CT2_CUSTO"),,"ONPRINT",,"",,     {||Alltrim(ValorCTB(nTotCtaD ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.T.,.F.,.F.)
		EndIf
		TRFunction():New(oSection2:Cell("CT2_ITEM"),,"ONPRINT",,"",,    {||STR0015+":" },.T.,.F.,.F.)
		TRFunction():New(oSection2:Cell("CT2_CLVL"),,"ONPRINT",,"",,    {||Alltrim(ValorCTB(nTotCtaC ,,,TAM_VALOR,2,.F.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.)) },.T.,.F.,.F.)
		TRFunction():New(oSection2:Cell("CT2_HIST") ,,"ONPRINT",,"Saldo ",,{|| STR0022+": "+ Alltrim(ValorCTB(nSaldoAtu  ,,,TAM_VALOR,2,.T.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.))},.T.,.F.,.F.)
	Else
		TRFunction():New(oSection2:Cell("CT2_VLRDEB"),,"ONPRINT",,"Debito",,     {|| nTotCtaD },.T.,.F.,.F.)
		TRFunction():New(oSection2:Cell("CT2_VLRCRD"),,"ONPRINT",,"Credito",,    {|| nTotCtaC },.T.,.F.,.F.)
		TRFunction():New(oSection2:Cell("CT2_HIST") ,,"ONPRINT",,"Saldo Atual",,{|| ValorCTB(nSaldoAtu  ,,,TAM_VALOR,2,.T.,PesqPict("CT2","CT2_VALOR"),,,,,,,.T.,.F.)},.T.,.F.,.F.)
	EndIf
	
	dDataL	:= cArqTmp->DATAL
	cLote	:= cArqTmp->LOTE
	cSubLote:= cArqTmp->SUBLOTE
	cDoc    := cArqTmp->DOC
	cLinha	:= cArqTmp->LINHA
	cSeq	:= cArqTmp->SEQLAN
	cEmpOri	:= cArqTmp->EMPORI 
	cFilOri	:= cArqTmp->FILORI
	oSection2:PrintLine()
	
	
	oSection2:Cell("CT2_DATA"):Show()
	oSection2:Cell("CT2_CONTA"):Show()
	If lContaPart
		oSection2:Cell("CT2_CTPART"):Show()			
	EndIf
	If lPartDob
		oSection2:Cell("CT2_TIPO"):Show()
		oSection2:Cell("CT2_CUSTO"):Show()
		oSection2:Cell("CT2_ITEM"):Show()
		oSection2:Cell("CT2_CLVL"):Show()
		oSection2:Cell("CT2_VALOR"):Show()
	Else
		oSection2:Cell("CT2_CCD"):Show()
		oSection2:Cell("CT2_CCC"):Show()
		oSection2:Cell("CT2_ITEMD"):Show()
		oSection2:Cell("CT2_ITEMC"):Show()
		oSection2:Cell("CT2_CLVLDB"):Show()
		oSection2:Cell("CT2_CLVLCR"):Show()
		oSection2:Cell("CT2_VLRDEB"):Show()
		oSection2:Cell("CT2_VLRCRD"):Show()
	EndIf
	oSection2:Cell("CT2_HIST"):Show()
	
	// Faz a impressao do historico detalhado
	RpPrintHist( cArqTmp , oSection2 )

	DbSelectArea("cArqTmp")
	cCtaRefAnt	:= cArqTmp->CTAREF 
	DbSkip()
	
	If cCtaRefAnt <>  cArqTmp->CTAREF
		oSection2:Finish()
		nTotCtaD := 0
		nTotCtaC := 0 
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

If(_oCTBR404 <> NIL)

	_oCTBR404:Delete()
	_oCTBR404 := NIL

EndIF	


Return

//-------------------------------------------------------------------
/*{Protheus.doc} Ctbr404Grv()
Monta a query e grava no arquivo temporário

@author Simone Mie Sato Kakinoana
   
@version P12
@since   27/03/2015
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function Ctbr404Grv(cArqTmp)

Local aSaveArea	:= GetArea()
Local aCampos	:= {}	
Local aTamConta	:= TAMSX3("CT1_CONTA")
Local aTamCusto	:= TAMSX3("CTT_CUSTO") 
Local aTamVal	:= TAMSX3("CT2_VALOR")
Local aCtbMoeda	:= {}

Local cQuery	:= ""
Local cWhere	:= ""
Local cTempIdx	:= ""
Local aChave	:= {}
Local cAliasQry := GetNextAlias()

Local nTamHist	:= Len(CriaVar("CT2_HIST"))
Local nTamItem	:= Len(CriaVar("CTD_ITEM"))
Local nTamCLVL	:= Len(CriaVar("CTH_CLVL"))
Local nTamCtaRef:= Len(CriaVar("CVN_CTAREF"))
Local nTamDesc	:= Len(CriaVar("CVN_DSCCTA"))
Local nDecimais	:= 0
Local nTamFilial 	:= IIf( lFWCodFil, FWGETTAMFILIAL, TamSx3( "CT2_FILIAL" )[1] )

Local lRecLockT	:= .T.
Local lFirstGrv	:= .T.

// Retorna Decimais
aCtbMoeda := CTbMoeda(cMoeda)
nDecimais := aCtbMoeda[5]

If lPartDob	//Se divide partida dobrada
	aCampos :={	{ "CTAREF"		, "C", nTamCtaRef	, 0 },;  		// Codigo da Conta Referencial
				{ "DSCCTAREF"	, "C", nTamDesc		, 0 },;  		// Descrição Conta Referencial
				{ "DATAL"		, "D", 10			, 0 },;			// Data do Lancamento
				{ "LOTE" 		, "C", 06			, 0 },;			// Lote
				{ "SUBLOTE" 	, "C", 03			, 0 },;			// Sub-Lote
				{ "DOC" 		, "C", 06			, 0 },;			// Documento
				{ "LINHA"		, "C", 03			, 0 },;			// Linha						
				{ "CONTA"		, "C", aTamConta[1]	, 0 },;  		// Codigo da Conta
				{ "XPARTIDA"   	, "C", aTamConta[1] , 0 },;			// Contra Partida
				{ "TIPO"       	, "C", 01			, 0 },;			// Tipo do Registro (Debito/Credito/Continuacao)
				{ "VALOR"		, "N", aTamVal[1]+2	, nDecimais },; // Valor
				{ "HIST"     	, "C", nTamHist   	, 0 },;			// Historico
				{ "CUSTO"		, "C", aTamCusto[1]	, 0 },;			// Centro de Custo
				{ "ITEM"		, "C", nTamItem		, 0 },;			// Item Contabil
				{ "CLVL"		, "C", nTamCLVL		, 0 },;			// Classe de Valor
				{ "SEQLAN"		, "C", 03			, 0 },;			// Sequencia do Lancamento
				{ "SEQHIST"		, "C", 03			, 0 },;			// Seq do Historico
				{ "EMPORI"		, "C", 02			, 0 },;			// Empresa Original
				{ "FILORI"		, "C", nTamFilial	, 0 },;			// Filial Original
				{ "NOMOV"		, "C", 01			, 0 },;			// Conta Sem Movimento
				{ "FILIAL"		, "C", nTamFilial	, 0 }} 			// Filial do sistema			
Else
	aCampos :={	{ "CTAREF"		, "C", nTamCtaRef	, 0 },;  		// Codigo da Conta Referencial
				{ "DSCCTAREF"	, "C", nTamDesc		, 0 },;  		// Descrição Conta Referencial
				{ "DATAL"		, "D", 10			, 0 },;			// Data do Lancamento
				{ "LOTE" 		, "C", 06			, 0 },;			// Lote
				{ "SUBLOTE" 	, "C", 03			, 0 },;			// Sub-Lote
				{ "DOC" 		, "C", 06			, 0 },;			// Documento
				{ "LINHA"		, "C", 03			, 0 },;			// Linha						
				{ "CONTA"		, "C", aTamConta[1]	, 0 },;  		// Codigo da Conta
				{ "XPARTIDA"   	, "C", aTamConta[1] , 0 },;			// Contra Partida
				{ "TIPO"       	, "C", 01			, 0 },;			// Tipo do Registro (Debito/Credito/Continuacao)
				{ "VLRDEB"		, "N", aTamVal[1]+2	, nDecimais },; // Valor Debito
				{ "VLRCRD"		, "N", aTamVal[1]+2	, nDecimais },; // Valor Credito
				{ "HIST"     	, "C", nTamHist   	, 0 },;			// Historico
				{ "CCD"			, "C", aTamCusto[1]	, 0 },;			// Centro de Custo Debito
				{ "CCC"			, "C", aTamCusto[1]	, 0 },;			// Centro de Custo Credito
				{ "ITEMD"		, "C", nTamItem		, 0 },;			// Item Contabil Debito
				{ "ITEMC"		, "C", nTamItem		, 0 },;			// Item Contabil Credito
				{ "CLVLDB"		, "C", nTamCLVL		, 0 },;			// Classe de Valor Debito
				{ "CLVLCR"		, "C", nTamCLVL		, 0 },;			// Classe de Valor Credito
				{ "SEQLAN"		, "C", 03			, 0 },;			// Sequencia do Lancamento
				{ "SEQHIST"		, "C", 03			, 0 },;			// Seq do Historico
				{ "EMPORI"		, "C", 02			, 0 },;			// Empresa Original
				{ "FILORI"		, "C", nTamFilial	, 0 },;			// Filial Original
				{ "NOMOV"		, "C", 01			, 0 },;			// Conta Sem Movimento
				{ "FILIAL"		, "C", nTamFilial	, 0 }} 			// Filial do sistema
EndIf
///////////////////////////////////////////
//Criação do Objeto de Tabela Temporaria //
///////////////////////////////////////////		

//Criando a chave da Tabela Temporaria 
aChave   := {"CTAREF","DATAL","LOTE","SUBLOTE","DOC","EMPORI","FILORI","LINHA"}

_oCTBR404 := FwTemporaryTable():New("cArqTmp")
_oCTBR404:SetFields(aCampos)
_oCTBR404:AddIndex("1" , aChave)

/////////////////////
//Criando a Tabela //
/////////////////////
_oCTBR404:Create()

Pergunte(cPerg2,.F.)

MakeSqlExpr(cPerg2)
	
cWhere	:= MV_PAR01 //SUBSTRING(MV_PAR01,13,LEN(ALLTRIM(MV_PAR01))-13)

	cQuery	:= " SELECT * FROM "+ CRLF
	cQuery	+= " ( " + CRLF
	cQuery	+= " SELECT ISNULL(CT2_FILIAL,'')  FILIAL, CVN_CTAREF, CVN_DSCCTA, ISNULL(CT2_DEBITO,'') CONTA, ISNULL(CT2_CCD,'') CUSTO,ISNULL(CT2_ITEMD,'') ITEM, ISNULL(CT2_CLVLDB,'') CLVL, ISNULL(CT2_DATA,'') DATAL, ISNULL(CT2_TPSALD,'') TPSALD, "	+ CRLF
	cQuery	+= " ISNULL(CT2_DC,'') DC, ISNULL(CT2_LOTE,'') LOTE, ISNULL(CT2_SBLOTE,'') SUBLOTE, ISNULL(CT2_DOC,'') DOC, ISNULL(CT2_LINHA,'') LINHA, "+CRLF
	cQuery	+= " ISNULL(CT2_CREDIT,'') XPARTIDA, ISNULL(CT2_CCC,'') XPARTCC, ISNULL(CT2_ITEMC,'') XPARTIT, ISNULL(CT2_CLVLCR,'') XPARTCLVL, "+ CRLF
	cQuery	+= " ISNULL(CT2_HIST,'') HIST, ISNULL(CT2_SEQHIS,'') SEQHIS, ISNULL(CT2_SEQLAN,'') SEQLAN, '1' TIPOLAN, "+ CRLF	
	cQuery  += " ISNULL(CT2_VALOR,0) VALOR, ISNULL(CT2_EMPORI,'') EMPORI, ISNULL(CT2_FILORI,'') FILORI"+ CRLF
	cQuery	+= " FROM " + RetSqlName("CVN")+ " CVN " + CRLF 
	cQuery	+= " LEFT JOIN " + RetSqlName("CVD")+" CVD ON CVD_FILIAL = '"+xFilial("CVD")+"'" + CRLF 
	cQuery	+= " AND CVD_CODPLA = CVN_CODPLA AND CVD_VERSAO = CVN_VERSAO AND CVD_CTAREF = CVN_CTAREF AND CVD.D_E_L_E_T_ = ' ' " + CRLF 
	cQuery	+= " LEFT JOIN "+ RetSqlName("CT2")+" CT2 ON CT2_DEBITO = CVD_CONTA  " + CRLF
	cQuery	+= " AND CT2.CT2_FILIAL "+ GetRngFil( aSelFil, "CT2", .T., @cTmpCT2Fil ) +" "+ CRLF
	cQuery	+= " AND CT2_DATA BETWEEN '"+DTOS(dDataIni)+"' AND '"+DTOS(dDataFim)+"' " + CRLF
	cQuery	+= " AND CT2_MOEDLC = '"+cMoeda+"' "+ CRLF
	cQuery	+= " AND CT2_TPSALD = '"+cTpSald+"' "+ CRLF
	cQuery  += " AND (CT2.CT2_DC = '1' OR CT2.CT2_DC = '3') "+ CRLF
	cQuery  += " AND CT2_VALOR <> 0 "+ CRLF
	cQuery	+= " AND CT2.D_E_L_E_T_ = ' ' "+ CRLF
	cQuery	+= " WHERE CVN.CVN_FILIAL = '"+xFilial("CVN")+"' " +CRLF
	cQuery	+= " AND CVN.CVN_CODPLA ='"+cPlanoRef+"' "+CRLF
	cQuery	+= " AND CVN.CVN_VERSAO ='"+cVersao+"' "+CRLF
	cQuery	+= " AND CVN.CVN_CLASSE = '2'"+CRLF
	cQuery	+= " UNION "+ CRLF
	cQuery	+= " SELECT ISNULL(CT2_FILIAL,'')  FILIAL, CVN_CTAREF, CVN_DSCCTA,  ISNULL(CT2_CREDIT,'') CONTA, ISNULL(CT2_CCC,'') CUSTO,ISNULL(CT2_ITEMC,'') ITEM, ISNULL(CT2_CLVLCR,'') CLVL, ISNULL(CT2_DATA,'') DATAL, ISNULL(CT2_TPSALD,'') TPSALD, "	+ CRLF
	cQuery	+= " ISNULL(CT2_DC,'') DC, ISNULL(CT2_LOTE,'') LOTE, ISNULL(CT2_SBLOTE,'') SUBLOTE, ISNULL(CT2_DOC,'') DOC, ISNULL(CT2_LINHA,'') LINHA, "	+ CRLF
	cQuery	+= " ISNULL(CT2_DEBITO,'') XPARTIDA, ISNULL(CT2_CCD,'') XPARTCC, ISNULL(CT2_ITEMD,'') XPARTIT, ISNULL(CT2_CLVLDB,'') XPARTCLVL, "+ CRLF 
	cQuery	+= " ISNULL(CT2_HIST,'') HIST, ISNULL(CT2_SEQHIS,'') SEQHIS, ISNULL(CT2_SEQLAN,'') SEQLAN, '2' TIPOLAN, "+ CRLF	
	cQuery  += " ISNULL(CT2_VALOR,0) VALOR, ISNULL(CT2_EMPORI,'') EMPORI, ISNULL(CT2_FILORI,'') FILORI"+ CRLF
	cQuery	+= " FROM " + RetSqlName("CVN")+ " CVN " + CRLF 
	cQuery	+= " LEFT JOIN " + RetSqlName("CVD")+" CVD ON CVD_FILIAL = '"+xFilial("CVD")+"'" + CRLF 
	cQuery	+= " AND CVD_CODPLA = CVN_CODPLA AND CVD_VERSAO = CVN_VERSAO AND CVD_CTAREF = CVN_CTAREF AND CVD.D_E_L_E_T_ = ' ' " + CRLF 
	cQuery	+= " LEFT JOIN "+ RetSqlName("CT2")+" CT2 ON CT2_CREDIT = CVD_CONTA  " + CRLF
	cQuery	+= " AND CT2.CT2_FILIAL "+ GetRngFil( aSelFil, "CT2", .T., @cTmpCT2Fil ) +" "+ CRLF
	cQuery	+= " AND CT2_DATA BETWEEN '"+DTOS(dDataIni)+"' AND '"+DTOS(dDataFim)+"' " + CRLF
	cQuery	+= " AND CT2_MOEDLC = '"+cMoeda+"' "+ CRLF
	cQuery	+= " AND CT2_TPSALD = '"+cTpSald+"' "+ CRLF
	cQuery  += " AND (CT2.CT2_DC = '2' OR CT2.CT2_DC = '3') "+ CRLF
	cQuery  += " AND CT2_VALOR <> 0 "+ CRLF
	cQuery	+= " AND CT2.D_E_L_E_T_ = ' ' "+ CRLF
	cQuery	+= " WHERE CVN.CVN_FILIAL = '"+xFilial("CVN")+"' " +CRLF
	cQuery	+= " AND CVN.CVN_CODPLA ='"+cPlanoRef+"' "+CRLF
	cQuery	+= " AND CVN.CVN_VERSAO ='"+cVersao+"' "+CRLF
	cQuery	+= " AND CVN.CVN_CLASSE = '2'"+CRLF
	cQuery	+= " ) CVNLANCTO "+CRLF
	
	If !Empty(cWhere)
		cQuery	+= " WHERE "+CRLF 
		cQuery  += cWhere 
	EndIf
	cQuery	+= " ORDER BY CVN_CTAREF, DATAL, LOTE, SUBLOTE, DOC, LINHA "+ CRLF
	cQuery := ChangeQuery(cQuery)
	
If Select("cAliasQry") > 0
	DbSelectArea("cAliasQry")
	DbCloseArea()
Endif

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cAliasQry",.T.,.F.)

TcSetField("cAliasQry","DATAL","D",8,0)

DbSelectArea("cArqTmp")
DbSetOrder(1)

DbSelectArea("cAliasQry")
DbGotop()
While !Eof()

	DbSelectArea("cArqTmp")
	If !DbSeek(cAliasQry->CVN_CTAREF,.F.)
		lRecLockT	:= .T.
		lFirstGrv	:= .T.	 
	Else
	
		If cAliasQry->VALOR  == 0 
			DbSelectArea("cAliasQry") 
			dbSkip()
			Loop
 		EndIf		
 		
		If Empty(cArqTmp->CONTA)	
			lRecLockT	:= .F.
		Else		
			lRecLockT	:= .T.
		EndIf	
	EndIf 

	Reclock("cArqTmp",lRecLockT)
	
	If lFirstGrv  
		cArqTmp->FILIAL		:= cAliasQry->FILIAL		 
		cArqTmp->CTAREF		:= cAliasQry->CVN_CTAREF
		cArqTmp->DSCCTAREF	:= cAliasQry->CVN_DSCCTA	
		cArqTmp->NOMOV		:= "T"
	Else
		cArqTmp->FILIAL		:= cAliasQry->FILIAL		 
		cArqTmp->CTAREF		:= cAliasQry->CVN_CTAREF
		cArqTmp->DSCCTAREF	:= cAliasQry->CVN_DSCCTA
		cArqTmp->DATAL		:= cAliasQry->DATAL 	
		cArqTmp->LOTE		:= cAliasQry->LOTE
		cArqTmp->SUBLOTE	:= cAliasQry->SUBLOTE
		cArqTmp->DOC		:= cAliasQry->DOC
		cArqTmp->LINHA		:= cAliasQry->LINHA						
		cArqTmp->CONTA		:= cAliasQry->CONTA
		cArqTmp->XPARTIDA	:= cAliasQry->XPARTIDA
		cArqTmp->TIPO		:= cAliasQry->TIPOLAN
		cArqTmp->HIST     	:= cAliasQry->HIST
		If lPartDob	//Divide Partida Dobrada
			cArqTmp->VALOR		:= cAliasQry->VALOR			
			cArqTmp->CUSTO		:= cAliasQry->CUSTO
			cArqTmp->ITEM		:= cAliasQry->ITEM
			cArqTmp->CLVL		:= cAliasQry->CLVL
		Else
			If cAliasQry->TIPOLAN == "1"
				cArqTmp->VLRDEB	:= cAliasQry->VALOR 
				cArqTmp->CCD	:= cAliasQry->CUSTO 
				cArqTmp->ITEMD	:= cAliasQry->ITEM
				cArqTmp->CLVLDB	:= cAliasQry->CLVL
				If cAliasQry->DC == "3" .And. lContaPart
					cArqTmp->VLRCRD	:= 0 //Contra-Partida nao apresenta valor
					cArqTmp->CCC	:= cAliasQry->XPARTCC
					cArqTmp->ITEMC 	:= cAliasQry->XPARTIT
					cArqTmp->CLVLCR := cAliasQry->XPARTCLVL				
				EndIf 
			Else 
				cArqTmp->VLRCRD	:= cAliasQry->VALOR
				cArqTmp->CCC	:= cAliasQry->CUSTO
				cArqTmp->ITEMC 	:= cAliasQry->ITEM
				cArqTmp->CLVLCR := cAliasQry->CLVL
				If cAliasQry->DC == "3" .And. lContaPart
					cArqTmp->VLRDEB	:= 0 //Contra-Partida nao apresenta valor
					cArqTmp->CCD	:= cAliasQry->XPARTCC 
					cArqTmp->ITEMD	:= cAliasQry->XPARTIT
					cArqTmp->CLVLDB	:= cAliasQry->XPARTCLVL
				EndIf
			EndIf
		EndIf
		cArqTmp->SEQLAN		:= cAliasQry->SEQLAN
		cArqTmp->SEQHIST	:= cAliasQry->SEQHIS
		cArqTmp->EMPORI		:= cAliasQry->EMPORI 
		cArqTmp->FILORI		:= cAliasQry->FILORI 
		cArqTmp->NOMOV		:= "F"
	Endif	
	
	MsUnlock()
	DbSelectArea("cAliasQry")
	lFirstGrv	:= .F.
	DbSkip()
End

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
Static Function RpPrintHist( cArqTmp , oSection2 )

Local nReg		:= 0
Local cQuery	:= ""

If lPartDob	//Se divide partida dobrada
	oSection2:Cell("CT2_DATA"):SetValue(cArqTmp->DATAL)
	oSection2:Cell("CT2_CHAVE"):SetValue(cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA)
	oSection2:Cell("CT2_CONTA"):Hide()
	If lContaPart
		oSection2:Cell("CT2_CTPART"):Hide()
	EndIf
	oSection2:Cell("CT2_CUSTO"):Hide()
	oSection2:Cell("CT2_ITEM"):Hide()
	oSection2:Cell("CT2_CLVL"):Hide()
	oSection2:Cell("CT2_TIPO"):Hide()	
	oSection2:Cell("CT2_VALOR"):Hide()
	
Else
	oSection2:Cell("CT2_DATA"):SetValue(cArqTmp->DATAL)
	oSection2:Cell("CT2_CHAVE"):SetValue(cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA)
	oSection2:Cell("CT2_CONTA"):Hide()
	If lContaPart
		oSection2:Cell("CT2_CTPART"):Hide()
	EndIf
	oSection2:Cell("CT2_CCD"):Hide()
	oSection2:Cell("CT2_CCC"):Hide()
	oSection2:Cell("CT2_ITEMD"):Hide()
	oSection2:Cell("CT2_ITEMC"):Hide()
	oSection2:Cell("CT2_CLVLDB"):Hide()
	oSection2:Cell("CT2_CLVLCR"):Hide()
	oSection2:Cell("CT2_VLRDEB"):Hide()
	oSection2:Cell("CT2_VLRCRD"):Hide()
EndIf

DbSelectArea("cArqTmp")
nReg	:= Recno()

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
cQuery	+= " AND D_E_L_E_T_ = ' ' "+ CRLF
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
	oSection2:Cell("CT2_DATA"):SetValue(CT2->CT2_DATA)
	oSection2:Cell("CT2_CHAVE"):SetValue(CT2->CT2_LOTE+CT2->CT2_SBLOTE+CT2->CT2_DOC+CT2->CT2_LINHA)
	oSection2:Cell( "CT2_HIST"  ):SetValue(CT2->CT2_HIST) 
	cLinha	:= CT2->CT2_LINHA	
   	oSection2:PrintLine()
	dbSkip()																
EndDo

If Select("cHistCompl") > 0
	DbSelectArea("cHistCompl")
	DbCloseArea()
Endif

DbSelectArea("cArqTmp")

If lPartDob	//Se divide partida dobrada
	oSection2:Cell("CT2_CONTA"):Show()
	If lContaPart
		oSection2:Cell("CT2_CTPART"):Show()			
	EndIf
	oSection2:Cell("CT2_CUSTO"):Show()
	oSection2:Cell("CT2_ITEM"):Show()
	oSection2:Cell("CT2_CLVL"):Show()
	oSection2:Cell("CT2_TIPO"):Show()	
	oSection2:Cell("CT2_VALOR"):Show()
	oSection2:Cell("CT2_HIST"):Show()
Else
	oSection2:Cell("CT2_CONTA"):Show()
	If lContaPart
		oSection2:Cell("CT2_CTPART"):Show()
	EndIf
	oSection2:Cell("CT2_CCD"):Show()
	oSection2:Cell("CT2_CCC"):Show()
	oSection2:Cell("CT2_ITEMD"):Show()
	oSection2:Cell("CT2_ITEMC"):Show()
	oSection2:Cell("CT2_CLVLDB"):Show()
	oSection2:Cell("CT2_CLVLCR"):Show()
	oSection2:Cell("CT2_VLRDEB"):Show()
	oSection2:Cell("CT2_VLRCRD"):Show()
	oSection2:Cell("CT2_HIST"):Show()
Endif

dbSelectArea("CT2")
dbSetOrder(1)					

dbSelectArea("cArqTmp")
dbGoto( nReg )

Return     

