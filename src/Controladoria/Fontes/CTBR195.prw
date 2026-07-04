/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR195.CH"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	32


// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR195  ³ Autor ³ Cicero J. Silva   	³ Data ³ 04.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Centro de Custo/Conta/Item/Cl. Valor			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR195        											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 		 ³ SIGACTB      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CTBR195()

Local aArea := GetArea()
Local oReport          

Local lOk := .T.
Local aCtbMoeda		:= {}
Local nDivide		:= 1
Local nQuadro		:= 0 

PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR195"
PRIVATE nomeProg  	:= "CTBR195"  
PRIVATE aQuadro := { "","","","","","","",""}              
PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE nTotMov	:= 0
PRIVATE lMov		:= .F. // eh private por necessidade da TRFunction
PRIVATE nTotdbt		:= 0
PRIVATE nTotcrt		:= 0
PRIVATE titulo
		
For nQuadro :=1 To Len(aQuadro)
	aQuadro[nQuadro] := Space(Len(CriaVar("CT1_CONTA")))
Next	

CtbCarTxt()

Pergunte(cPerg,.T.) // Precisa ativar as perguntas antes das definicoes.

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	lOk := .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par12) // Set Of Books
	lOk := .F.
EndIf 

If mv_par29 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par29 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par29 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lOk
	aCtbMoeda  	:= CtbMoeda(mv_par13,nDivide) // Moeda?
   If Empty(aCtbMoeda[1])
      Help(" ",1,"NOMOEDA")
      lOk := .F.
   Endif
Endif

If lOk
	oReport := ReportDef(aCtbMoeda,nDivide,aQuadro)
	oReport:PrintDialog()
EndIf
	
//Limpa os arquivos temporários 
CTBGerClean()
	
RestArea(aArea)

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
Static Function ReportDef(aCtbMoeda,nDivide,aQuadro)

Local oReport
Local oS1CCusto
Local oS2Conta 

Local oBreak

Local cSayCC		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")

Local cDesc1 		:= STR0001+ Upper(cSayCC)+ " / " + Upper(STR0021)+" / "+Upper(cSayItem	) + " / " + Upper(cSayClVl) //"Este programa ira imprimir o Balancete de  / Conta  / "
Local cDesc2 		:= STR0002  //"de acordo com os parametros solicitados pelo Usuario"

Local aTamCC    	:= TAMSX3("CTT_CUSTO")
Local aTamCCRes 	:= TAMSX3("CTT_RES")
Local aTamConta		:= TAMSX3("CT1_CONTA")
Local aTamCtaRes	:= TAMSX3("CT1_RES")
Local aTamItem  	:= TAMSX3("CTD_ITEM")
Local aTamItRes 	:= TAMSX3("CTD_RES")    
Local aTamClVl  	:= TAMSX3("CTH_CLVL")
Local aTamCvRes 	:= TAMSX3("CTH_RES")
                                            
Local nTamCC  		:= Len(CriaVar("CTT->CTT_DESC"+mv_par13))
Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC"+mv_par13))

Local lPula			:= Iif(mv_par23==1,.T.,.F.) 

Local lCNormal		:= Iif(mv_par25==1,.T.,.F.)
Local lCCNormal		:= Iif(mv_par26 == 1,.T.,.F.)
Local lItNormal		:= Iif(mv_par27 == 1,.T.,.F.)
Local lCvNormal		:= Iif(mv_par28 == 1,.T.,.F.)

Local lPrintZero	:= Iif(mv_par24==1,.T.,.F.)
Local cSegAte 	   	:= mv_par16 // Imprimir ate o Segmento?
Local lPulaPag		:= Iif(mv_par22==1,.T.,.F.)

Local nDigitAte		:= 0
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cSepara3		:= ""
Local cSepara4		:= ""
Local aSetOfBook := CTBSetOf(mv_par12)	
	
Local cMascara1		:= IIF (Empty(aSetOfBook[6]),GetMv("MV_MASCCUS"),RetMasCtb(aSetOfBook[6],@cSepara1))//Mascara do Centro de Custo
Local cMascara2		:= IIF (Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSepara2))//Mascara da Conta
Local cMascara3		:= IIF (Empty(aSetOfBook[7]),"",RetMasCtb(aSetOfBook[7],@cSepara3))//Mascara do Item 
Local cMascara4		:= IIF (Empty(aSetOfBook[8]),"",RetMasCtb(aSetOfBook[8],@cSepara4))//Mascara da Classe de Valor

Local cPicture 		:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par13)
Local cDescMoeda 	:= ""

Local bCdCUSTO	:= {|| EntidadeCTB(cArqTmp->CUSTO,,,20,.F.,cMascara1,cSepara1,,,,,.F.) }
Local bCdCCRES	:= {|| EntidadeCTB(cArqTmp->CCRES,,,20,.F.,cMascara1,cSepara1,,,,,.F.) }

Local bCdCONTA	:= {|| IIF(Empty(cArqTmp->ITEM) .And. Empty(cArqTmp->CLVL),IIF(cArqTmp->TIPOCONTA=="1","","  ")+EntidadeCTB(cArqTmp->CONTA,,,25 ,.F.,cMascara2,cSepara2,,,,,.F.),"")}
Local bCdCTRES	:= {|| IIF(Empty(cArqTmp->ITEM) .And. Empty(cArqTmp->CLVL),IIF(cArqTmp->TIPOCONTA=="1","","  ")+EntidadeCTB(cArqTmp->CTARES,,,20,.F.,,,,,,,.F.),"")}

Local bCdITEM	:= {|| IIF(Empty(cArqTmp->CLVL),EntidadeCTB(cArqTmp->ITEM,,,20,.F.,cMascara3,cSepara3,,,,,.F.),"")}
Local bCdITRES	:= {|| IIF(Empty(cArqTmp->CLVL),EntidadeCTB(cArqTmp->ITEMRES,,,20,.F.,,,,,,,.F.),"")}

Local bCdCVRL	:= {|| EntidadeCTB(cArqTmp->CLVL,,,20,.F.,cMascara4,cSepara4,,,,,.F.) }
Local bCdCVRES	:= {|| EntidadeCTB(cArqTmp->CLVLRES,,,20,.F.,,,,,,,.F.) }

Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.) // Parameter to activate Red Storn

Default nDivide	  := 1
Default aCtbMoeda := CtbMoeda(mv_par13,nDivide)

	  titulo	:= STR0003+ Upper(cSayCC)+ " / " +  Upper(STR0021)+" / "+Upper(cSayItem)+ " / " + Upper(cSayClVl)	//"Balancete de Verificacao  / Conta / "
	  lMov		:= IIF(mv_par21 == 1,.T.,.F.) // Imprime movimento ?

if len(aCtbMoeda) > 0
	cDescMoeda 	:= aCtbMoeda[2]
endIf

oReport := TReport():New(nomeProg,Capital(titulo),cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayCC,cSayItem,cSayClVl,nDivide)},cDesc1+cDesc2)
oReport:SetLandScape(.T.)

// Sessao 1
oS1CCusto := TRSection():New(oReport,STR0040 ,{"cArqTmp", "CTT"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)  //"Centro de Custo"
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)

TRCell():New(oS1CCusto,"CUSTO"		,"cArqTmp",STR0040,/*Picture*/,aTamCC[1]+6		,/*lPixel*/,bCdCUSTO) //"Centro de Custo"
TRCell():New(oS1CCusto,"CCRES"		,"cArqTmp",STR0041,/*Picture*/,aTamCCRes[1]	,/*lPixel*/,bCdCCRES)  //"CODIGO REDUZIDO C. CUSTO"
TRCell():New(oS1CCusto,"DESCCC"		,"cArqTmp",STR0042,/*Picture*/,nTamCC			,/*lPixel*/,/*{|| }*/)  //"DESCRICAO"
TRPosition():New( oS1CCusto, "CTT", 1, {|| xFilial("CTT") + cArqTMP->CUSTO })
oS1CCusto:SetLineStyle()
oS1CCusto:SetNoFilter({"cArqTmp", "CTT"})

If lCCNormal
	oS1CCusto:Cell("CCRES"	):Disable()
Else
	oS1CCusto:Cell("CUSTO"	):Disable() 
EndIf

If lPulaPag
	oS1CCusto:SetPageBreak(.T.)
EndIf

//Somente sera impresso centro de custo analitico	
oS1CCusto:SetLineCondition({|| IIF(cArqTmp->TIPOCC == "1",.F.,.T.) })

// Sessao 2
oS2Conta := TRSection():New(oS1CCusto, UPPER(STR0043),{"cArqTmp", "CT1", "CTH", "CTD"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)  //
oS2Conta:SetTotalInLine(.F.)
oS2Conta:SetHeaderPage()

TRCell():New(oS2Conta,"CONTA"		,"cArqTmp",UPPER(STR0043),/*Picture*/,aTamConta[1],/*lPixel*/, bCdCONTA ) //"CONTA"			
TRCell():New(oS2Conta,"CTARES"		,"cArqTmp",UPPER(STR0044),/*Picture*/,aTamCtaRes[1]		,/*lPixel*/, bCdCTRES ) //"CONTA RES"
TRCell():New(oS2Conta,"ITEM"		,"cArqTmp",UPPER(STR0045),/*Picture*/,aTamItem[1]		,/*lPixel*/, bCdITEM  ) //"ITEM"
TRCell():New(oS2Conta,"ITEMRES"		,"cArqTmp",UPPER(STR0046),/*Picture*/,aTamItRes[1]		,/*lPixel*/, bCdITRES )  //"ITEM RES"
TRCell():New(oS2Conta,"CLVL"		,"cArqTmp",UPPER(STR0047),/*Picture*/,aTamClVl[1]		,/*lPixel*/, bCdCVRL  ) //"CL.VALOR"		
TRCell():New(oS2Conta,"CLVLRES"		,"cArqTmp",UPPER(STR0048),/*Picture*/,aTamCvRes[1]		,/*lPixel*/, bCdCVRES ) //"CL.VALOR RES."
TRCell():New(oS2Conta,"DESC"		,"cArqTmp",UPPER(STR0042),/*Picture*/,nTamCta-10	,/*lPixel*/,{|| IIF( !Empty(cArqTmp->CLVL), cArqTmp->DESCCLVL, IIF( !Empty(cArqTmp->ITEM), cArqTmp->DESCITEM,cArqTmp->DESCCTA ) ) },,.T., ) //"DESCRICAO"		
TRCell():New(oS2Conta,"SALDOANT"	,"cArqTmp",UPPER(STR0049),/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"RIGHT"*/,,"CENTER")  //"SALDO ANTERIOR"
TRCell():New(oS2Conta,"SALDODEB"	,"cArqTmp",UPPER(STR0050),/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"RIGHT"*/,,"CENTER")  //"DEBITO"
TRCell():New(oS2Conta,"SALDOCRD"	,"cArqTmp",UPPER(STR0051),/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"RIGHT"*/,,"CENTER") //"CREDITO"
TRCell():New(oS2Conta,"MOVIMENTO"	,"cArqTmp",UPPER(STR0052),/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"RIGHT"*/,,"CENTER")  //"MOVIMENTO DO PERIODO"
TRCell():New(oS2Conta,"SALDOATU"	,"cArqTmp",UPPER(STR0053),/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR+5,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"RIGHT"*/,,"CENTER")  //"SALDO ATUAL"
TRPosition():New( oS2Conta, "CTH", 1, {|| xFilial("CTH") + cArqTMP->CLVL })
TRPosition():New( oS2Conta, "CTD", 1, {|| xFilial("CTD") + cArqTMP->ITEM })
TRPosition():New( oS2Conta, "CT1", 1, {|| xFilial("CT1") + cArqTMP->CONTA})

If lCNormal
	oS2Conta:Cell("CTARES"	):Disable()
Else
	oS2Conta:Cell("CONTA"	):Disable() 
EndIf
If lItNormal
	oS2Conta:Cell("ITEMRES"):Disable()
Else
	oS2Conta:Cell("ITEM"):Disable() 
EndIf
If lCvNormal //Se Imprime Codigo Reduzido
	oS2Conta:Cell("CLVLRES"):Disable()
Else
	oS2Conta:Cell("CLVL"):Disable()
EndIf
If !lMov //Nao Imprime Coluna Movimento!!
	oS2Conta:Cell("MOVIMENTO"):Disable()
EndIf  

If oReport:GetOrientation() == 1
	If lMov
		oS2Conta:Cell("DESC"):Disable() 
	EndIf
EndIf

oS2Conta:SetNoFilter({"cArqTmp", "CT1", "CTH", "CTD"})
oS2Conta:SetLinesBefore(0)

oS2Conta:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCONTA == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
								 cTipoAnt := cArqTmp->TIPOCONTA;
							)  })

	oS2Conta:SetLineCondition({|| f195Fil(cSegAte, nDigitAte,cMascara2) })
	
	oBreak:= TRBreak():New(oS2Conta,{ || cArqTmp->CUSTO },Capital(STR0020+cSayCC),.F.)
	
	oBreak:OnBreak({ || nTotdbt := oTRF1:GetValue(),nTotcrt := oTRF2:GetValue() })

	oTRF1 := TRFunction():New(oS2Conta:Cell("SALDODEB"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f195Soma("D",cSegAte) },.F.,.F.,.F.,oS2Conta)
	oTRF1:disable()
	 		 TRFunction():New(oS2Conta:Cell("SALDODEB"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotdbt,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oS2Conta)
	
	oTRF2 := TRFunction():New(oS2Conta:Cell("SALDOCRD"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f195Soma("C",cSegAte) },.F.,.F.,.F.,oS2Conta)
	oTRF2:disable()
			 TRFunction():New(oS2Conta:Cell("SALDOCRD"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotcrt,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oS2Conta)

	If lRedStorn
		TRFunction():New(oS2Conta:Cell("MOVIMENTO"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := RedStorTt(nTotdbt,nTotcrt,,,"T"),;
		IIF ( lMov,; 
					ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr),;
				    nil);
			)},.F.,.F.,.F.,oS2Conta)
	Else
		TRFunction():New(oS2Conta:Cell("MOVIMENTO"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := (nTotcrt - nTotdbt),;
		IIF ( lMov, IIF ( nTotMov < 0,;
	                       ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),;
				           IIF ( nTotMov > 0,ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),nil) ), nil) )},.F.,.F.,.F.,oS2Conta)
	Endif
	
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
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayCC,cSayItem,cSayClVl,nDivide)

Local oS1CCusto 	:= oReport:Section(1)
Local oS2Conta		:= oReport:Section(1):Section(1)

Local cArqTmp		:= ""
Local cFiltro		:= oS1CCusto:GetAdvplExp("CTT")

Local dDataLP  		:= mv_par31
Local dDataFim 		:= mv_par02

Local lImpAntLP		:= Iif(mv_par30==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par24==1,.T.,.F.)    

If oReport:GetOrientation() == 1
	If lMov
		oS2Conta:Cell("DESC"):Disable() 
	Else
		oS2Conta:Cell("DESC"):SetSize(28)	
	EndIf
EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF mv_par11 == 1
		titulo:=	STR0006   	//"BALANCETE ANALITICO DE  "
	ElseIf mv_par11 == 2
		titulo:=	STR0007 	//"BALANCETE SINTETICO DE  "
	ElseIf mv_par11 == 3
		titulo:=	STR0008 	//"BALANCETE DE  "
	EndIf
	                                                           
	titulo += 	Upper(cSayCC) + "/" + Upper(STR0021) + "/" + Upper(cSayItem) + "/" + Upper(cSayClVl)
	titulo += 	STR0009 + DTOC(mv_par01) + STR0010 + Dtoc(mv_par02) + 	STR0011 + cDescMoeda
	
	If mv_par15 > "1"
		titulo += " (" + Tabela("SL", mv_par13, .F.) + ")"
	EndIf
	
	If nDivide > 1			
		titulo += " (" + STR0022 + Alltrim(Str(nDivide)) + ")"
	EndIf	
	
//	oReport:SetTitle(titulo)
	oReport:SetPageNumber(mv_par14) //mv_par14	-	Pagina Inicial
	oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao					     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;                        
			CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			 mv_par01,mv_par02,"CTI","",mv_par03,mv_par04,mv_par05,mv_par06,mv_par07,mv_par08,mv_par09,mv_par10,mv_par13,;
			  mv_par15,aSetOfBook,mv_par17,mv_par18,mv_par19,mv_par20,;
			   .F.,.T.,,"CTT",lImpAntLP,dDataLP, nDivide,.F.,,,,,,,,,,,,,,,cFiltro /*aReturn[7]*/,,,,,.T.,.T./*lImpEntGer*/)},;									
			    (STR0014),;  //"Criando Arquivo Tempor rio..."
				 (STR0003)+Upper(cSayCC)+ " / "+Upper(STR0021)+ " / " + Upper(cSayItem)+ " / " + Upper(cSayClVl))      //"Balancete Verificacao "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a impressao do relatorio                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("cArqTmp")
	dbGotop()
	//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
	//nao esta disponivel e sai da rotina.
	If !( RecCount() == 0 .And. !Empty(aSetOfBook[5]) )
		
		oS2Conta:SetParentFilter( { |cParam| cArqTmp->CUSTO == cParam },{ || cArqTmp->CUSTO })// SERVE PARA IMPRIMIR O TITULO DA SECAO PAI


		oS1CCusto:Print()
		
	EndIf
	
dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
If Select("cArqTmp") == 0
//	Ferase(cArqTmp+GetDBExtension())
//	FErase("cArqInd"+OrdBagExt())
EndIf	
dbselectArea("CT2")


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f195Soma  ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR195                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f195Soma(cTipo,cSegAte)

Local nRetValor		:= 0

	If Empty(cArqTmp->ITEM) .And. Empty(cArqTmp->CLVL)
		If mv_par11 == 1					// So imprime Sinteticas - Soma Sinteticas
			If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			EndIf
		Else								// Soma Analiticas
			If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
				If cArqTmp->TIPOCONTA == "2"
					If cTipo == "D"
						nRetValor := cArqTmp->SALDODEB
					ElseIf cTipo == "C"
						nRetValor := cArqTmp->SALDOCRD
					EndIf
				EndIf
			Else							//Se tiver filtragem, somo somente as sinteticas
				If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1
					If cTipo == "D"
						nRetValor := cArqTmp->SALDODEB
					ElseIf cTipo == "C"
						nRetValor := cArqTmp->SALDOCRD
					EndIf
				EndIf
	    	Endif
		EndIf                     
	EndIf
	
Return nRetValor                                                                         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f195Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR195                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f195Fil(cSegAte, nDigitAte,cMascara2)

Local lDeixa	:= .T.
Local nCont    := 0

	If mv_par11 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCONTA == "2"
			lDeixa := .F.
		EndIf
	ElseIf mv_par11 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCONTA == "1"
			lDeixa := .F.
		EndIf
	EndIf

	// Verifica Se existe filtragem Ate o Segmento
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		For nCont := 1 to Val(cSegAte)
			nDigitAte += Val(Subs(cMascara2,nCont,1))	
		Next
		If Len(Alltrim(cArqTmp->CONTA)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)
