/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "ctbr380.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	17


// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ Ctbr380  ³ Autor ³ Cicero J. Silva       ³ Data ³ 27.07.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Demonstrativo da variacao monetaria                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr380()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbR380()

Local aArea		:= GetArea()
Local oReport
Local lOk		:= .T.
Local nDivide	:= 1

Local aSetOfBook
Local aCtbMoeda	:= {}

PRIVATE cPerg	 	:= "CTR380"
Private aMedias 
PRIVATE cTipoAnt	:= ""
PRIVATE nomeProg  	:= "CTBR380"




	If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
		lOk := .F.
	EndIf

	Pergunte(cPerg,.T.)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
	//³ Gerencial -> montagem especifica para impressao)			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !ct040Valid(mv_par05)// mv_par05 - Set Of Books
		lOk := .F.
	Else
	   aSetOfBook := CTBSetOf(mv_par05)// mv_par05 - Set Of Books
	Endif
	If mv_par17 == 2			// Divide por cem
		nDivide := 100
	ElseIf mv_par17 == 3		// Divide por mil
		nDivide := 1000
	ElseIf mv_par17 == 4		// Divide por milhao
		nDivide := 1000000
	EndIf	
	If lOk
		aCtbMoeda	:= CtbMoeda(mv_par07,nDivide) //mv_par07 - Moeda?
		If Empty(aCtbMoeda[1])                       
	      Help(" ",1,"NOMOEDA")
	      lOk := .F.
	   Endif
	Endif
	If (mv_par20 # 1)  // mv_par20 - Apresenta-Calculo Efetuado/Simulacao
		aMedias := CtbMedias(FirstDay(mv_par01), LastDay(mv_par01))  // mv_par01 - Data referencia
		CTP->(DbSetOrder(1))
	Endif
	If lOk

		oReport := ReportDef(aSetOfBook,aCtbMoeda,nDivide)
		oReport:PrintDialog()

	EndIf

//Limpa os arquivos temporários 
CTBGerClean()

RestArea(aArea)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Cicero J. Silva    º Data ³  07/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ aSetOfBook - Matriz ref. Config. Relatorio                 º±±
±±º          ³ aCtbMoeda  - Matriz ref. a moeda                           º±±
±±º          ³ nDivide    - Valor a ser usado para divisao de valores     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef(aSetOfBook,aCtbMoeda,nDivide)

Local oReport
Local oTotais
Local oBreak

Local aTamConta	:= TAMSX3("CT1_CONTA")
Local aTamCtaRes	:= TAMSX3("CT1_RES")
Local nTamCta 		:= Len(CriaVar("CT1_DESC"+mv_par07))
Local nTamGrupo	:= Len(CriaVar("CT1_GRUPO"))
Local cSegAte   	:= mv_par10
Local titulo 		:= Upper(OemToAnsi(STR0006))	//"Demonstrativo da correcao monetaria"
Local cDescMoe1	:=	CtbMoeda("01",nDivide)[2]
Local cDescMoe2	:=	CtbMoeda(mv_par07,nDivide)[2]
Local nDecimais	:= 2
Local nDigitAte	:= 0
Local cSepara		:= 	""
Local cMascara		:= IIf( Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSepara))
Local cPicture		:= aSetOfBook[4]
Local lPrintZero	:= Iif(mv_par16==1,.T.,.F.)
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty

oReport := TReport():New(nomeProg,titulo,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,aCtbMoeda,nDivide,cMascara,cPicture)},STR0001+STR0002+STR0015)//"Este programa ira imprimir a variacao entre a moeda padrao e a moeda solicitada"##"de acordo com os parametros solicitados pelo usuario. A data de referencia indica"##"a data para busca dos lancamentos de variacao."
oReport:SetLandScape(.T.)
oReport:SetTotalText(OemToAnsi(STR0012))//"T O T A I S  D O  P E R I O D O: "

// Sessao 1
oPlcontas := TRSection():New(oReport,STR0020,{"cArqTmp","CT1"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)		//"Plano de Contas"

TRCell():New(oPlcontas,"CONTA"		,"cArqTmp",STR0022											 				,/*Picture*/,aTamConta[1]	,/*lPixel*/,{|| IIF(cArqTmp->TIPOCONTA=="2","  ","")+EntidadeCTB(cArqTmp->CONTA ,0,0,70,.F.,cMascara,cSepara,,,,,.F.) })// Codigo da Conta
TRCell():New(oPlcontas,"CTARES"		,"cArqTmp",STR0023											 				,/*Picture*/,aTamCtaRes[1]	,/*lPixel*/,{|| IIF(cArqTmp->TIPOCONTA=="2","  ","")+EntidadeCTB(cArqTmp->CTARES,0,0,70,.F.,cMascara,cSepara,,,,,.F.) })// Codigo Reduzido da Conta
TRCell():New(oPlcontas,"DESCCTA"		,"cArqTmp",STR0024											 				,/*Picture*/,nTamCta		,/*lPixel*/,/*{|| }*/)// Descricao da Conta
TRCell():New(oPlcontas,"MOVIMENTO1"	,"cArqTmp",AllTrim(Upper(cDescMoe1))+" (1)",/*Picture*/		,19,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO1,,,TAM_VALOR,nDecimais	,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) },/*"CENTER"*/,,"CENTER") // Movimento Tipo de Saldo 01
TRCell():New(oPlcontas,"MOVIMENTO2"	,"cArqTmp",AllTrim(Upper(cDescMoe2))+" (2)",/*Picture*/		,19,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO2,,,TAM_VALOR,nDecimais	,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) },/*"CENTER"*/,,"CENTER")// Movimento Tipo de Saldo 02
TRCell():New(oPlcontas,"COLUNA_1"	,"cArqTmp",AllTrim(STR0007)+" "+AllTrim(Upper(cDescMoe2)),	,19,/*lPixel*/,{|| ValorCTB(Abs(cArqTmp->COLUNA_1),,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) },/*"CENTER"*/,,"CENTER")
TRCell():New(oPlcontas,"VARIACAO"	,"cArqTmp",OemToAnsi(STR0007)				,/*Picture*/,10			,/*lPixel*/,{|| ValorCTB(Abs(cArqTmp->VARIACAO),,,7,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr)+"%" },/*"CENTER"*/,,"CENTER")// Variacao
TRCell():New(oPlcontas,"COLUNA_2"	,"cArqTmp",AllTrim(STR0019 + cDescMoe2),/*Picture*/,19			,/*lPixel*/,{|| ValorCTB(cArqTmp->COLUNA_2,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) },/*"CENTER"*/,,"CENTER") 

oPlContas:Cell("MOVIMENTO1"):lHeaderSize 	:= .F.
oPlContas:Cell("MOVIMENTO2"):lHeaderSize 	:= .F.
oPlContas:Cell("COLUNA_1"):lHeaderSize	 	:= .F.
oPlContas:Cell("VARIACAO"):lHeaderSize 		:= .F.
oPlContas:Cell("COLUNA_2"):lHeaderSize 		:= .F.

oPlcontas:SetLineCondition({|| R380Fil(cSegAte, nDigitAte,cMascara) })

oPlcontas:OnPrintLine( {|| ( IIf( (mv_par15 == 1) .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCONTA == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
								 cTipoAnt := cArqTmp->TIPOCONTA)  })

oPlcontas:SetTotalInLine(.F.)

oTotais := TRSection():New( oReport,STR0021,{"cArqTmp"},, .F., .F. )		//"Total"

TRCell():New( oTotais, "TOT"			,""		 ,Upper(STR0021),/*Picture*/,aTamConta[1]+nTamCta+1,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotais, "MOVIMENTO1"	,"cArqTmp",AllTrim(Upper(cDescMoe1))+" (1)",/*Picture*/,TAM_VALOR+2,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotais, "MOVIMENTO2"	,"cArqTmp",AllTrim(Upper(cDescMoe2))+" (2)",/*Picture*/,TAM_VALOR+2,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotais, "COLUNA_1"	,"cArqTmp",AllTrim(STR0007)+" "+AllTrim(Upper(cDescMoe2)),/*Picture*/,TAM_VALOR+13,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotais, "COLUNA_2"	,"cArqTmp",AllTrim(STR0019+cDescMoe2),/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/)
                                   
oReport:ParamReadOnly()

Return oReport

Static Function ReportPrint(oReport,aSetOfBook,aCtbMoeda,nDivide,cMascara,cPicture)

Local oPlcontas	:= oReport:Section(1)
Local oTotais		:= oReport:Section(2)

Local cArqTmp		:= ""
Local cTpSld1		:= mv_par09		//Tipo de Saldo 1
Local cTpSld2		:= mv_par09	    //Tipo de Saldo 2   
Local cSegAte   	:= mv_par10
Local dDataFim 		:= mv_par01
Local lVar0			:= Iif(mv_par06 == 1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par16==1,.T.,.F.)
Local cDescMoeda 	:= aCtbMoeda[2]                  
Local cFiltro		:= oPlcontas:GetAdvplExp()
Local nDecimais 	:= 2
Local nGrupo1		:= 0
Local nGrupo2		:= 0                     
Local nTotMoe1		:= 0
Local nTotMoe2		:= 0
Local nAtuMoe2		:= 0
Local nGAtuMoe2 	:= 0
Local nVariacao	:= 0
Local nGrpVar 		:= 0
Local nDigitAte	:= 0
Local titulo 		:= titulo	:= oReport:Title() + " " + OemToAnsi(STR0014)+ Alltrim(cDescMoeda)+OemToAnsi(STR0016)+ Dtoc(mv_par01) 
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
	
	If nDivide > 1
		titulo  += " (" + OemToAnsi(STR0017) + Alltrim(Str(nDivide)) + ")"
	EndIf
	
	oReport:SetTitle(titulo)
	oReport:SetPageNumber(mv_par08) //mv_par08	-	Pagina Inicial
	oReport:SetCustomText( { || CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )	
	oPlcontas:OnPrintLine( {|| ( IIf( (mv_par15 == 1) .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCONTA == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
									 cTipoAnt := cArqTmp->TIPOCONTA	), Iif( mv_par19 != 1 .And. cArqTmp->NIVEL1, oReport:EndPage(), .T. ) })
									                                                         
	If !Empty(cFiltro)
		CT1->(dbSetFilter({ || &cFiltro }, cFiltro) )
	EndIf
									 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao					     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CtbGerCmp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				 mv_par01,mv_par01,"CT7",mv_par02,mv_par03,,,,,,,;
				  mv_par07,cTpSld1,cTpSld2,aSetOfBook,mv_par11,mv_par12,mv_par13,mv_par14,;
				   mv_par10,lVar0,nDivide,mv_par19, { |x,y| Ctbr380Val(x,y) },, "01", 2)},;
					OemToAnsi(OemToAnsi(STR0010)),;  //"Criando Arquivo Tempor rio..."
					 OemToAnsi(STR0006))  				//"Demonstrativo da correcao monetaria"

	If mv_par18 == 2 //Se Imprime Codigo Reduzido
		oPlcontas:Cell("CONTA"):Disable()	
	Else
		oPlcontas:Cell("CTARES"):Disable()
	EndIf

	oTotais:Cell("MOVIMENTO1"):SetTitle("")
	oTotais:Cell("MOVIMENTO2"):SetTitle("")
	oTotais:Cell("COLUNA_1"  ):SetTitle("")
	oTotais:Cell("COLUNA_2"  ):SetTitle("")
			

	dbSelectArea("cArqTmp")
	dbGoTop()
	oReport:SetMeter( RecCount() )

	TRPosition():New(oPlcontas,"CT1",1,{|| xFilial("CT1") + cArqTmp->CONTA })   
	TRPosition():New(oPlcontas,"CTT",1,{|| xFilial("CTT") + cArqTmp->CUSTO})
	TRPosition():New(oPlcontas,"CTD",1,{|| xFilial("CTD") + cArqTmp->ITEM})

	cGrupo := cArqTmp->GRUPO	

	oPlcontas:Init()
	While !Eof() .And. !oReport:Cancel()
    
	   If oReport:Cancel()
	    	Exit
    	EndIf        

	    oReport:IncMeter() 

		If R380Fil(cSegAte, nDigitAte,cMascara)
			dbSkip()
			Loop
		EndIf

    	oPlcontas:Printline()
    	
    	nValorM1 := R380Soma("M1",cSegAte)
    	nValorM2 := R380Soma("M2",cSegAte)
		nValorC1 := R380Soma("C1",cSegAte)
		nValorC2 := R380Soma("C2",cSegAte)
                              
		nTotMoe1  += nValorM1
		nTotMoe2  += nValorM2
		nGrupo1	 += nValorM1
		nGrupo2	 += nValorM2
		nVariacao += nValorC1
		nGrpVar   += nValorC1
		nAtuMoe2  += nValorC2
		nGAtuMoe2 += nValorC2
		
		dbSkip()
		
		If mv_par19 == 1							// Grupo Diferente - Totaliza e Quebra
			If cGrupo != cArqTmp->GRUPO

				oTotais:Cell("TOT"):SetTitle(OemToAnsi(STR0011) + "( " + cGrupo + " )")
				oTotais:Cell( "MOVIMENTO1"):SetBlock( { || ValorCTB(nGrupo1,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr) } )
				oTotais:Cell( "MOVIMENTO2"):SetBlock( { || ValorCTB(nGrupo2,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr) } )

				oTotais:Init()
				oTotais:PrintLine()
				oTotais:Finish()
				
				oReport:EndPage()
				
				nGrupo1		:= 0
				nGrupo2		:= 0		
				nGrpVar		:= 0		
				nGAtuMoe2	:= 0		
				
				cGrupo := cArqTmp->GRUPO
			
			EndIf			
		EndIF    
	EndDo
	
	oPlContas:Finish()
	
	If !oReport:Cancel() 
	
		If mv_par19 == 1							// Grupo Diferente - Totaliza e Quebra
			If cGrupo <> cArqTmp->GRUPO
	
				oTotais:Cell("TOT"):SetTitle(OemToAnsi(STR0011) + "( " + cGrupo + " )")
				oTotais:Cell( "MOVIMENTO1"):SetBlock( { || ValorCTB(nGrupo1,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr) } )
				oTotais:Cell( "MOVIMENTO2"):SetBlock( { || ValorCTB(nGrupo2,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr) } )
				oTotais:Cell( "COLUNA_1"):SetBlock( { || ValorCTB(nGrpVar,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr) } )
				oTotais:Cell( "COLUNA_2"):SetBlock( { || ValorCTB(nGAtuMoe2,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr) } )
	
				oTotais:Init()
				oTotais:PrintLine()
				oTotais:Finish()
	
			EndIf			
		EndIF    
	
		oTotais:Cell("TOT"):SetTitle(OemToAnsi(STR0012))
		oTotais:Cell( "MOVIMENTO1"):SetBlock( { || ValorCTB(nTotMoe1,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr) } )
		oTotais:Cell( "MOVIMENTO2"):SetBlock( { || ValorCTB(nTotMoe2,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr) } )
		oTotais:Cell( "COLUNA_1"  ):SetBlock( { || ValorCTB(nVariacao,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr) } )
		oTotais:Cell( "COLUNA_2"  ):SetBlock( { || ValorCTB(nAtuMoe2,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr) } )

		oTotais:Init()
		oTotais:PrintLine()
		oTotais:Finish()
	
	EndIf                                    

	CT1->( dbClearFil())
		
	dbSelectArea("cArqTmp")
	dbClearFilter()
	dbCloseArea()
	FErase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
	dbselectArea("CT1")
	

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R380Soma  ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR380                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R380Soma(cTipo,cSegAte)

Local nRetValor := 0

	If mv_par04 == 1 .Or. mv_par04 = 3	// So imprime Sinteticas ou ambas - Soma Sinteticas
		If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1
			If cTipo == "M1"
				nRetValor := cArqTmp->MOVIMENTO1
			ElseIf cTipo == "M2"
				nRetValor := cArqTmp->MOVIMENTO2
			ElseIf cTipo == "C1"
				nRetValor := cArqTmp->COLUNA_1
			ElseIf cTipo == "C2"
				nRetValor := cArqTmp->COLUNA_2
			EndIf
		EndIf
	Else         //Se soma as analiticas ou ambas
		If Empty(cSegAte)  //Se nao tiver filtragem ate o nivel
			If TIPOCONTA == "2"
				If cTipo == "M1"
					nRetValor := cArqTmp->MOVIMENTO1
				ElseIf cTipo == "M2"
					nRetValor := cArqTmp->MOVIMENTO2
				ElseIf cTipo == "C1"
					nRetValor := cArqTmp->COLUNA_1
				ElseIf cTipo == "C2"
					nRetValor := cArqTmp->COLUNA_2
				EndIf
			EndIf                                              
		Else		//Se tiver filtragem ate o nivel, somo somente as sinteticas
			If TIPOCONTA == "1" .And. NIVEL1
				If cTipo == "M1"
					nRetValor := cArqTmp->MOVIMENTO1
				ElseIf cTipo == "M2"
					nRetValor := cArqTmp->MOVIMENTO2
				ElseIf cTipo == "C1"
					nRetValor := cArqTmp->COLUNA_1
				ElseIf cTipo == "C2"
					nRetValor := cArqTmp->COLUNA_2
				EndIf
			Endif
		EndIf	
	EndIf                     

Return nRetValor                                                                         


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R380Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR380                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R380Fil(cSegAte, nDigitAte,cMascara)

Local lDeixa	:= .F.
Local nCont		:= 0

	If mv_par04 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCONTA == "2"
			lDeixa := .T.
		EndIf
	ElseIf mv_par04 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCONTA == "1"
			lDeixa := .T.
		EndIf
	EndIf

	// Verifica Se existe filtragem Ate o Segmento
	If !Empty(cSegAte)
		//For nCont := 1 to Val(cSegAte)
		//	nDigitAte += Val(Subs(cMascara,nCont,1))	
		//Next
		nDigitAte	:= CtbRelDig(cSegAte,cMascara)
	EndIf		

		
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(cArqTmp->CONTA)) > nDigitAte
			lDeixa := .T.
		Endif
	EndIf

Return (lDeixa)


