/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR160.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	17

// 17/08/2009 -- Filial com mais de 2 caracteres

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr160	³ Autor ³ Cicero J. Silva	    ³ Data ³ 02.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balanco Geral Modelo 2				 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_CTBR160(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum        											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum         											  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctbr160(wnRel)

Local oReport

Local aArea := GetArea()
Local lOk := .T.

		If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
			lOk := .F.
		EndIf
		If lOk
			oReport := ReportDef("CTR160")
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
±±ºParametros³ aCtbMoeda  - Matriz ref. a moeda                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef(cPerg)

Local oReport
Local oTotais                                               

Local cDesc1		:= STR0001	//"Este programa ira imprimir o Balanco Geral Modelo 1 (132) Colunas."
Local cDesc2		:= STR0002	//"A conta eh impressa limitando-se a 30 caracteres e sua descricao 40 caracteres,"
Local cDesc3		:= STR0003	//"sao tambem impressos colunas do saldo a debito e a credito do periodo."

Local aTamConta		:= TamSX3("CT1_CONTA")
Local aTamCtaRes	:= TamSX3("CT1_RES")

oReport := TReport():New("CTBR160",STR0004,cPerg,{|oReport| Pergunte(cPerg,.F.),;
						Iif( ReportPrint(oReport), .T., oReport:CancelPrint() ) },cDesc1+cDesc2+cDesc3)
		
oReport:SetLandscape(.T.)

// Sessao 1
oPlcontas := TRSection():New(oReport,STR0004,{"cArqTmp","CT1"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)	// "Balanco Geral"
oPlcontas:SetTotalInLine(.F.)

TRCell():New(oPlcontas,"CONTA"  , "cArqTmp"	, STR0023,/*Picture*/,aTamConta[1],/*lPixel*/,/*{|| code-block de impressao }*/)	// "C O N T A"
TRCell():New(oPlcontas,"DESCCTA", "cArqTmp"	, STR0024,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)	// "D E N O M I N A C A O"
TRCell():New(oPlcontas,"COL_DEB", ""		, STR0029+CRLF+STR0026,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")	// "D E B I T O"
TRCell():New(oPlcontas,"COL_CRD", ""		, STR0029+CRLF+STR0027,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")	// "C R E D I T O"

oTotais := TRSection():New( oReport,STR0028,,, .F., .F. )	// "Totais"
TRCell():New( oTotais, "TOT",, STR0024,/*Picture*/,61,/*lPixel*/,/*{|| code-block de impressao }*/)	//"D E N O M I N A C A O"
TRCell():New( oTotais, "TOT_DEBITO"	,, STR0026,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")	//"D E B I T O"
TRCell():New( oTotais, "TOT_CREDITO",, STR0027,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")	//"C R E D I T O"

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

Static Function	ReportPrint(oReport)

Local oPlcontas		:= oReport:Section(1)
Local oTotais		:= oReport:Section(2)

Local aSetOfBook	:= CTBSetOf(mv_par06)
Local aCtbMoeda		:= {}

Local cArqTmp		:=	""
LOCAL limite		:= 132
Local lImpLivro		:=.T.
Local lImpTermos	:=.F.
Local lImpAntLP		:= (mv_par21 == 1)
Local dDataLP		:= mv_par22
Local lVlrZerado	:= (mv_par07 == 1)
Local lImpSint		:= (mv_par05=1 .Or. mv_par05 ==3)
Local lTotGSint		:= (mv_par24 == 2)	//Define se ira imprimir o total geral pelas contas analiticas ou sinteticas
Local lPrintZero	:= (mv_par17 == 1)
Local cSegAte   	:= mv_par20
Local dDataFim 		:= mv_par02
Local lImpRes		:= (mv_par18 # 1)
Local lPula			:= (mv_par16 == 1) 

Local nDivide		:= 1
Local nDigitAte		:= 0
Local cFiltro		:= oPlcontas:GetAdvplExp()
Local cSepara		:= ""
Local cDescMoeda 	:= ""
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)
Local cMascara		:= IIf(Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSepara))
Local cPicture 		:= aSetOfBook[4]

Local nGrpDeb 		:= 0
Local nTotDeb 		:= 0
Local nGrpCrd 		:= 0
Local nTotCrd 		:= 0              
Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC"+mv_par08))
Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.)

Private cTipoAnt	:= ""
Private nomeprog	:= "CTBR160"

If mv_par19 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par19 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par19 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par06)
	Return .F.
EndIf 

aCtbMoeda := CtbMoeda(mv_par08,nDivide)
If Empty(aCtbMoeda[1])
	Help(" ",1,"NOMOEDA")
	Return .F.
Endif
                          
cDescMoeda := aCtbMoeda[2]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par05 == 1
	titulo:=	OemToAnsi(STR0009)	//"BALANCO GERAL SINTETICO DE "
ElseIf mv_par05 == 2
	titulo:=	OemToAnsi(STR0010)	//"BALANCO GERAL ANALITICO DE "
ElseIf mv_par05 == 3
	titulo:=	OemToAnsi(STR0011)	//"BALANCO GERAL DE "
EndIf

titulo += 	DTOC(mv_par01) + OemToAnsi(STR0012) + Dtoc(mv_par02) + ;
			OemToAnsi(STR0013) + cDescMoeda + CtbTitSaldo(mv_par10)

oReport:SetCustomText( { || CtCGCCabTR(,,,,,dDataBase,titulo,,,,,oReport) } )

oReport:SetPageNumber(mv_par09) //mv_par08	-	Pagina Inicial

#IFNDEF TOP
	If !Empty(cFiltro)
		CT1->( dbSetFilter( { || &cFiltro }, cFiltro ) )
	EndIf
#ENDIF

If lImpRes 
	oPlContas:Cell("CONTA"):SetBlock( { || EntidadeCTB(cArqTmp->(Iif(TIPOCONTA=="2",CTARES,CONTA)),0,0,70,.F.,cMascara,cSepara,,,,,.F.) } )
Else
	oPlContas:Cell("CONTA"):SetBlock( { || EntidadeCTB(cArqTmp->CONTA,0,0,70,.F.,cMascara,cSepara,,,,,.F.) } )
EndIf	

If lRedStorn
	oPlContas:Cell("COL_DEB"):SetBlock({|| ValorCTB(Iif(cArqTmp->NORMAL=="1",cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR,0),,,TAM_VALOR,nDecimais,.F.,cPicture," ",,,,,,lPrintZero,.F.,lColDbCr) })
	oPlContas:Cell("COL_CRD"):SetBlock({|| ValorCTB(Iif(cArqTmp->NORMAL=="2",cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB,0),,,TAM_VALOR,nDecimais,.F.,cPicture," ",,,,,,lPrintZero,.F.,lColDbCr) })
Else
	oPlContas:Cell("COL_DEB"):SetBlock({|| ValorCTB(IIF( cArqTmp->(SALDOATUCR - SALDOATUDB) < 0,ABS(cArqTmp->(SALDOATUCR - SALDOATUDB)),0),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) })
	oPlContas:Cell("COL_CRD"):SetBlock({|| ValorCTB(IIF( cArqTmp->(SALDOATUCR - SALDOATUDB) > 0,ABS(cArqTmp->(SALDOATUCR - SALDOATUDB)),0),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) })
Endif	
oPlContas:Cell("DESCCTA"):SetSize(nTamCta)

oPlcontas:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCONTA == "1" .And. cTipoAnt == "2")),oReport:SkipLine(),NIL),;//Salta linha sintetica ?
								 cTipoAnt := cArqTmp->TIPOCONTA	)  })
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Termo / Livro                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case mv_par23==1 ; lImpLivro:=.t. ; lImpTermos:=.f.
	Case mv_par23==2 ; lImpLivro:=.t. ; lImpTermos:=.t.
	Case mv_par23==3 ; lImpLivro:=.f. ; lImpTermos:=.t.
EndCase

If lImpLivro
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			  mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
				mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
				  .F.,.F.,mv_par11,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFiltro )},;	
					OemToAnsi(OemToAnsi(STR0016)),;  //"Criando Arquivo Tempor rio..."
					  OemToAnsi(STR0004))  				//"Balanco Geral"				
		   
	oReport:NoUserFilter()
						
	dbSelectArea("cArqTmp")
	dbGoTop()

	cGrupoAnt := AllTrim(cArqTmp->GRUPO)
	
	oReport:SetMeter( RecCount() )
	oPlcontas:Init()
	
	// Verifica Se existe filtragem Ate o Segmento
	If !Empty(cSegAte)
		nDigitAte := CtbRelDig(cSegAte,cMascara) 	
	EndIf		
	
	
    Do While !Eof() .And. !oReport:Cancel()
    
        If oReport:Cancel()
	    	Exit
    	EndIf      

	    oReport:IncMeter() 

		If R160Fil(cSegAte, nDigitAte,cMascara)
			dbSkip()
			Loop
		EndIf

    	oPlcontas:Printline()

		If lRedStorn
			nTotDeb += f160RSsum("D",cSegAte,lTotGSint)
			nGrpDeb += f160RSsum("D",cSegAte,lTotGSint)
			nTotCrd += f160RSsum("C",cSegAte,lTotGSint)
			nGrpCrd += f160RSsum("C",cSegAte,lTotGSint)
		Else
			nTotDeb += f160Soma("D",cSegAte,lTotGSint)
			nGrpDeb += f160Soma("D",cSegAte,lTotGSint)
			nTotCrd += f160Soma("C",cSegAte,lTotGSint)
			nGrpCrd += f160Soma("C",cSegAte,lTotGSint)
		Endif
		
    	dbSkip()

   		If mv_par11 == 1 // mv_par11 - Quebra por Grupo Contabil? 
			If cGrupoAnt <> AllTrim(cArqTmp->GRUPO)

				oTotais:Cell("TOT"):SetTitle(OemToAnsi(STR0021) + cGrupoAnt + " )")
				oTotais:Cell( "TOT_DEBITO"	):SetBlock( { || ValorCTB(nGrpDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
				oTotais:Cell( "TOT_CREDITO"	):SetBlock( { || ValorCTB(nGrpCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )

				oTotais:Init()
					oTotais:PrintLine()
				oTotais:Finish()
				oReport:SkipLine()
				
				oReport:EndPage()
				
				nGrpDeb	:= 0
				nGrpCrd	:= 0		
				cGrupoAnt := AllTrim(cArqTmp->GRUPO)
			EndIf
		Else
			If cArqTmp->NIVEL1				// Sintetica de 1o. grupo
				oReport:EndPage()
			EndIf
		EndIf

	EndDo       
	
	oPlcontas:Finish()

	If Round(nTotDeb,nDecimais) != Round(nTotCrd,nDecimais)

		nDifer := Round(nTotDeb,nDecimais)-Round(nTotCrd,nDecimais)
		
		If nDifer > 0
			oTotais:Cell("TOT"):Hide()
			oTotais:Cell("TOT"):HideHeader()
			oTotais:Cell("TOT_CREDITO"):Hide()
			oTotais:Cell("TOT_CREDITO"):HideHeader()
			oTotais:Cell("TOT_DEBITO"):SetTitle(SUBS(STR0019,1,14))//"DEBITO A MAIOR:"
			oTotais:Cell("TOT_DEBITO"):SetBlock( { || ValorCTB(Abs(nDifer),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) } )
		ElseIf nDifer < 0
			oTotais:Cell("TOT"):Hide()
			oTotais:Cell("TOT"):HideHeader()
			oTotais:Cell("TOT_DEBITO"):Hide()
			oTotais:Cell("TOT_DEBITO"):HideHeader()
			oTotais:Cell("TOT_CREDITO"):SetTitle(SUBS(STR0020,1,15))//"CREDITO A MAIOR:"
			oTotais:Cell("TOT_CREDITO"):SetBlock( { || ValorCTB(Abs(nDifer),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) } )
		EndIF

		oTotais:Init()
		oTotais:PrintLine()
		oTotais:Finish()

		If nDifer > 0
			oTotais:Cell("TOT"):Show()
			oTotais:Cell("TOT"):ShowHeader()
			oTotais:Cell("TOT_CREDITO"):Show()
			oTotais:Cell("TOT_CREDITO"):ShowHeader()
			oTotais:Cell("TOT_DEBITO"):SetTitle(STR0026)
		Else                                        
			oTotais:Cell("TOT"):Show()
			oTotais:Cell("TOT"):ShowHeader()
			oTotais:Cell("TOT_DEBITO"):Show()
			oTotais:Cell("TOT_DEBITO"):ShowHeader()
			oTotais:Cell("TOT_CREDITO"):SetTitle(STR0027)			
		EndIf

	EndIf	
	
	oTotais:SetLineStyle(.F.)
	oTotais:Cell("TOT"):SetTitle(OemToAnsi(STR0022))//"T O T A I S : "
	oTotais:Cell("TOT_DEBITO"):SetBlock( { || ValorCTB(nTotDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) } )
	oTotais:Cell("TOT_CREDITO"):SetBlock( { || ValorCTB(nTotCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) } )

	oTotais:Init()
	oTotais:PrintLine()
	oTotais:Finish()

	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()
	If Select("cArqTmp") == 0
		FErase(cArqTmp+GetDBExtension())
		FErase(cArqTmp+OrdBagExt())
	EndIF	
	dbselectArea("CT2")
Endif

If lImpTermos 							// Impressao dos Termos
	Ctr150Termos("CTR160", Limite, oReport)
Endif

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f160soma  ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR160                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f160soma(cTipo,cSegAte,lTotGSint)

Local nRetValor		:= 0
Local nValor		:= 0

	nValor := cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB

	If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1  
				If nValor < 0 .And. cTipo == "D"					
					nRetValor := Abs(nValor)
				ElseIf  nValor > 0 .And. cTipo == "C"					
					nRetValor := Abs(nValor)
				EndIf
		EndIf
	Else	// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel	
			If mv_par05 == 2		//Se imprime so as analiticas
				If cArqTmp->TIPOCONTA == "2"
					If nValor < 0 .And. cTipo == "D" 								
						nRetValor := Abs(nValor)
					ElseIf nValor > 0 .And. cTipo == "C" 								
						nRetValor := Abs(nValor)
					EndIf
				EndIf
			ElseIf mv_par05 == 3		//Se imprime as analiticas e sinteticas
				If lTotGSint		//Se totaliza pelas sinteticas
					If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1  
						If (nValor) < 0 .And. cTipo == "D"  					
							nRetValor := Abs(nValor)
						ElseIf  nValor > 0 .And. cTipo == "C"  					
							nRetValor := Abs(nValor)
						EndIf
					EndIf				
				Else				//Se totaliza pelas analiticas
					If cArqTmp->TIPOCONTA == "2"
						If (nValor) < 0 .And. cTipo == "D"
							nRetValor := Abs(nValor)
						ElseIf nValor > 0 .And. cTipo == "C" 
							nRetValor := Abs(nValor)
						EndIf
					EndIf
			    EndIf
			EndIf
		Else	//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1                                                       
				If nValor < 0 .And. cTipo == "D"
					nRetValor := Abs(nValor)
				ElseIf  nValor > 0 .And. cTipo == "C"
					nRetValor := Abs(nValor)
				EndIf
			EndIf
    	Endif
	EndIf

Return nRetValor                                                                         


//-------------------------------------------------------------------
/*{Protheus.doc} f160RSsum()

Totalize moviment value according to CT1->CT1_NORMAL if RedStorn 
is activated

@author Fabio Cazarini
   
@version P12
@since   11/05/2017
@return  nRetValor
@obs	 
*/
//-------------------------------------------------------------------
Static Function f160RSsum(cTipo,cSegAte,lTotGSint)
Local nRetValor		:= 0
Local nValor		:= 0

If cTipo == "D" .and. cArqTmp->NORMAL == "1" 
	nValor := cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR
Elseif cTipo == "C" .and. cArqTmp->NORMAL == "2" 
	nValor := cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB
Endif

If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
	If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1  
		nRetValor := nValor
	EndIf
Else	// Soma Analiticas
	If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel	
		If mv_par05 == 2		//Se imprime so as analiticas
			If cArqTmp->TIPOCONTA == "2"
				nRetValor := nValor
			EndIf
		ElseIf mv_par05 == 3		//Se imprime as analiticas e sinteticas
			If lTotGSint		//Se totaliza pelas sinteticas
				If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1  
					nRetValor := nValor
				EndIf				
			Else				//Se totaliza pelas analiticas
				If cArqTmp->TIPOCONTA == "2"
					nRetValor := nValor
				EndIf
		    EndIf
		EndIf
	Else	//Se tiver filtragem, somo somente as sinteticas
		If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1                                                       
			nRetValor := nValor
		EndIf
	Endif
EndIf

Return nRetValor                                                                         


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R160Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR160                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R160Fil(cSegAte, nDigitAte,cMascara)

Local lDeixa	:= .F.

	If mv_par05 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCONTA == "2"
			lDeixa := .T.
		EndIf
	ElseIf mv_par05 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCONTA == "1"
			lDeixa := .T.
		EndIf
	EndIf

	// Verifica Se existe filtragem Ate o Segmento
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(cArqTmp->CONTA)) > nDigitAte
			lDeixa := .T.
		Endif
	EndIf
	If mv_par07 == 2						// Saldos Zerados nao serao impressos
		If ( cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB ) == 0
			lDeixa := .T.
		EndIf
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)