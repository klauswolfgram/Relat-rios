/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR210.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	24
// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR210  ³ Autor ³ Cicero J. Silva   	³ Data ³ 01.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete por Classe de Valor           			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR210        											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 		 ³ SIGACTB      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CTBR210()

Local aArea := GetArea()
Local oReport          
Local lOk := .T.
Local aCtbMoeda		:= {}
Local aSetOfBook
Local nDivide		:= 1
Local lAtSlComp		:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)
Local cFilIni		:= cFilAnt  

PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR210"
PRIVATE nomeProg  	:= "CTBR210"
PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE nTotMov		:= 0
PRIVATE titulo		:= ""
PRIVATE aSelFil   		:= {} 

If Type("lExterno") == "U"
	PRIVATE lExterno
EndIf

Pergunte( cPerg, .T. )			

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mostra tela de aviso - atualizacao de saldos				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMensagem := OemToAnsi(STR0022)+chr(13)  		//"Caso nao atualize os saldos compostos na"
cMensagem += OemToAnsi(STR0023)+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
cMensagem += OemToAnsi(STR0024)+chr(13)  		//"rodar a rotina de atualizacao de saldos "

IF !lAtSlComp
	If !MsgYesNo(cMensagem,OemToAnsi(STR0025))	//"ATEN€O"
		Return
	EndIf
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par06) // Set Of Books
	lOk := .F.
Else
   aSetOfBook := CTBSetOf(mv_par06)		
EndIf 

If mv_par20 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par20 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par20 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lOk
	aCtbMoeda  	:= CtbMoeda(mv_par08,nDivide) // Moeda?
   If Empty(aCtbMoeda[1])
      Help(" ",1,"NOMOEDA")
      lOk := .F.
   Endif
Endif

If lOk .And. mv_par23 == 1 .And. Len( aSelFil ) <= 0
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		lOk := .F.
	EndIf 
EndIf  

If lOk
	oReport := ReportDef(aSetOfBook,aCtbMoeda,nDivide)
	oReport:PrintDialog()
EndIf

//Limpa os arquivos temporários 
CTBGerClean()

RestArea(aArea)
cFilAnt := cFilIni

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
Static Function ReportDef(aSetOfBook,aCtbMoeda,nDivide)

Local oReport
Local oSection1                        
Local cSayClVl		:= CtbSayApro("CTH")
LOCAL cDesc1		:= OemToAnsi(STR0001)+ Upper(cSayClVl)+ " "	//"Este programa ira imprimir o Balancete de  "
LOCAL cDesc2		:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"
Local aTamClVl  	:= TAMSX3("CTH_CLVL")
Local aTamCVRes 	:= TAMSX3("CTH_RES")
Local nTamClVl		:= Len(CriaVar("CTH->CTH_DESC"+mv_par08))
Local lPula			:= Iif(mv_par17==1,.T.,.F.) 
Local lNormal		:= Iif(mv_par19==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)
Local lMov 			:= IIF(mv_par16==1,.T.,.F.) // Imprime movimento ?
Local cSegAte 	   	:= mv_par11 // Imprimir ate o Segmento?
Local nDigitAte		:= 0
Local cSeparador		:= ""
Local cMascara		:= IIF (Empty(aSetOfBook[8]),"",RetMasCtb(aSetOfBook[8],@cSeparador))// Mascara do Item Contabil
Local cPicture 		:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)
Local cDescMoeda 	:= aCtbMoeda[2]
Local bCdCVRL	:= {|| IIF(cArqTmp->TIPOCLVL=="1","","  ")+EntidadeCTB(cArqTmp->CLVL,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) }
Local bCdCVRES := {|| IIF(cArqTmp->TIPOCLVL=="1",	EntidadeCTB(cArqTmp->CLVL,0,0,20,.F.,cMascara,cSeparador,,,,,.F.),;
	  										"  " + EntidadeCTB(cArqTmp->CLVLRES,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) ) }
Local lColDbCr 		:= If(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= If(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.)// Parameter to activate Red Storn

	titulo			:= OemToAnsi(STR0003)+Alltrim(Upper(cSayClVl)) 	//"Balancete de Verificacao Conta / "

	oReport := TReport():New(nomeProg,titulo,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayClVl,nDivide)},cDesc1+cDesc2)
	oReport:SetTotalInLine(.F.)
	oReport:EndPage(.T.)
	
	If lMov
		oReport:SetLandScape(.T.)
	Else
		oReport:SetPortrait(.T.)
	EndIf
	
	// Sessao 1
	oSection1 := TRSection():New(oReport,cSayClVl,{"cArqTmp","CTH"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
	oSection1:SetTotalInLine(.F.)
	oSection1:SetHeaderPage()
	
	TRCell():New(oSection1,"FILIAL"	 ,"cArqTmp","FILIAL" 	,/*Picture*/,12 			,/*lPixel*/, {|| cArqTmp->FILIAL}  )// Codigo da FILIAL
	TRCell():New(oSection1,"CLVL"	 ,"cArqTmp",STR0026 	,/*Picture*/,aTamClVl[1]+2	,/*lPixel*/, bCdCVRL  )// Codigo da Classe de Valor
	TRCell():New(oSection1,"CLVLRES" ,"cArqTmp",STR0027 	,/*Picture*/,aTamCVRes[1]	,/*lPixel*/, bCdCVRES )// Cod. Red. Classe de Valor
	TRCell():New(oSection1,"DESCCLVL","cArqTmp",STR0028 	,/*Picture*/,nTamClVl 	,/*lPixel*/,/*{|| }*/ , /*"CENTER"*/,.T.,/*"CENTER"*/,,,.F.)// Descricao da Conta	
	TRCell():New(oSection1,"SALDOANT","cArqTmp",STR0029 	,/*Picture*/,TAM_VALOR  ,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.)}, /*"CENTER"*/,,"CENTER",,,.F.)// Saldo Anterior
	TRCell():New(oSection1,"SALDODEB","cArqTmp",STR0030 	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.,lColDbCr)}, /*"CENTER"*/,,"CENTER",,,.F.)// Debito
	TRCell():New(oSection1,"SALDOCRD","cArqTmp",STR0031 	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.,lColDbCr)}, /*"CENTER"*/,,"CENTER",,,.F.)// Credito

	If lMov //Nao Imprime Coluna Movimento!!
		TRCell():New(oSection1,"MOVIMENTO","cArqTmp",STR0032 	,/*Picture*/,TAM_VALOR ,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.)}, /*"CENTER"*/,,"CENTER",,,.F.)// Movimento do Periodo
		oSection1:Cell("MOVIMENTO"):lHeaderSize := .F.
	EndIf

	TRCell():New(oSection1,"SALDOATU","cArqTmp",STR0033 ,/*Picture*/,TAM_VALOR ,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.)}, /*"CENTER"*/,,"CENTER",,,.F.)// Saldo Atual
	TRCell():New(oSection1,"TIPOCLVL","cArqTmp",STR0034 ,/*Picture*/,01			,/*lPixel*/,/*{|| }*/)// Situacao
	TRCell():New(oSection1,"NIVEL1"	,"cArqTmp",STR0035 ,/*Picture*/,01			,/*lPixel*/,/*{|| }*/)// Logico para identificar se 
	
    oSection1:Cell("SALDOANT"):lHeaderSize  := .F.
    oSection1:Cell("SALDODEB"):lHeaderSize  := .F.
    oSection1:Cell("SALDOCRD"):lHeaderSize  := .F.
    oSection1:Cell("SALDOATU"):lHeaderSize  := .F.
	
	TRPosition():New( oSection1, "CTH", 1, {|| xFilial("CTH") + cArqTMP->CLVL  })
	oSection1:Cell("TIPOCLVL"	):Disable() 
	oSection1:Cell("NIVEL1"  	):Disable()
	
	If lNormal //Se Imprime Codigo Reduzido
		oSection1:Cell("CLVLRES"):Disable()
	Else
		oSection1:Cell("CLVL"):Disable()	
	EndIf 
	
	oSection1:OnPrintLine( {|| cFilAnt := cArqTmp->FILIAL, ;
						 ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCLVL == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
									 cTipoAnt := cArqTmp->TIPOCLVL;
								)  })
	
	oSection1:SetLineCondition({|| cFilAnt := cArqTmp->FILIAL, f210Fil(cSegAte, nDigitAte,cMascara) })

// Totais das sessoes	
	TRFunction():New(oSection1:Cell("SALDOANT"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ""},.T.,.F.,.F.,oSection1)

	oTRF1 := TRFunction():New(oSection1:Cell("SALDODEB"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f210Soma("D",cSegAte) },.F.,.F.,.F.,oSection1)
	 		 TRFunction():New(oSection1:Cell("SALDODEB"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF1:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSection1)

	oTRF2 := TRFunction():New(oSection1:Cell("SALDOCRD"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f210Soma("C",cSegAte) },.F.,.F.,.F.,oSection1)
			 TRFunction():New(oSection1:Cell("SALDOCRD"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF2:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSection1)

	If lMov
		If lRedStorn
			TRFunction():New(oSection1:Cell("MOVIMENTO"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := RedStorTt(oTRF1:GetValue(),oTRF2:GetValue(),,,"T"),;
				  ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(nTotMov<0,"1","2"),,,,,,lPrintZero,.F.,lColDbCr),;
				  ) },.T.,.F.,.F.,oSection1)
		Else
			TRFunction():New(oSection1:Cell("MOVIMENTO"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := (oTRF2:GetValue() - oTRF1:GetValue()),;
			IIF ( nTotMov < 0,;
				  ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),;
				  IIF ( nTotMov > 0,ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.),nil) ) )},.T.,.F.,.F.,oSection1)
		Endif
	EndIf
	
oReport:ParamReadOnly()

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
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayClVl,nDivide)

Local oSection1 	:= oReport:Section(1)

Local cArqTmp		:= ""
Local cFiltro		:= oSection1:GetAdvplExp()
Local cCtaIni		:= Space(Len(CriaVar("CT1_CONTA")))
Local cCtaFim		:= Repl('Z',Len(CriaVar("CT1_CONTA")))            
Local lImpSint		:= Iif(mv_par05=1 .Or. mv_par05 ==3,.T.,.F.)
Local dDataFim 		:= mv_par02
Local lImpAntLP		:= Iif(mv_par21==1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par07==1,.T.,.F.) 
Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)
Local dDataLP  		:= mv_par22
Local l132			:= IIF(mv_par16 == 1,.F.,.T.)// Se imprime saldo movimento do periodo
Local lImpConta		:= .F.
Local nK			:= 0
         

If oReport:GetOrientation() == 1 
	oSection1:Cell("DESCCLVL"):SetSize(20)
EndIf


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF mv_par05 == 1 
		Titulo:=	OemToAnsi(STR0007) + Upper(cSayClVl) 	//"BALANCETE SINTETICO DE  "
	ElseIf mv_par05 == 2 
		Titulo:=	OemToAnsi(STR0006) + Upper(cSayClVl)	//"BALANCETE ANALITICO DE  "
	ElseIf mv_par05 == 3
		Titulo:=	OemToAnsi(STR0008) + Upper(cSayClVl)	//"BALANCETE DE  "
	EndIf
	
	Titulo += 	OemToAnsi(STR0009) + DTOC(mv_par01) + OemToAnsi(STR0010) + Dtoc(mv_par02) + ;
				OemToAnsi(STR0011) + cDescMoeda
	
	If mv_par10 > "1"
		Titulo += " (" + Tabela("SL", mv_par10, .F.) + ")"
	EndIf
	
	If nDivide > 1			
		Titulo += " (" + OemToAnsi(STR0021) + Alltrim(Str(nDivide)) + ")"
	EndIf	
	
	oReport:SetPageNumber(mv_par09) //mv_par09	-	Pagina Inicial
	oReport:SetCustomText( { || CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra tabela CTH com dbSetFilter, independente se RPO Top ou CodeBase, pois ³
	//³ existem campos na CTH que nao estao na tabela temporaria em que eh aplicado  ³
	//³ o filtro e isto gerava mensagem de erro.log de campo nao encontrado.         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If ! Empty(cFiltro)
    	CTH->( dbSetFilter( { || &cFiltro }, cFiltro ) )
    EndIf
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;				   
				cArqTmp := CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				 mv_par01,mv_par02,"CTU","CTH",cCtaIni,cCtaFim,,,,,mv_par03,mv_par04,;
				  mv_par08,mv_par10,aSetOfBook,mv_par12,;
				   mv_par13,mv_par14,mv_par15,l132,lImpConta,,,lImpAntLP,dDataLP,;
					nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFiltro,,,,,,,,,,,,aSelFil) },;
					 OemToAnsi(OemToAnsi(STR0014)),;  //"Criando Arquivo Tempor rio..."
					  OemToAnsi(STR0003)+cSayClVl)     //"Balancete de Verificacao por " 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a impressao do relatorio                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Select("cArqTmp") > 0
		dbSelectArea("cArqTmp")
		dbGotop()
	
		oSection1:Print()
	
		dbSelectArea("cArqTmp")
		Set Filter To
		dbCloseArea()
		FErase(cArqTmp+GetDBExtension())
		FErase("cArqInd"+OrdBagExt())
	EndIf

	dbSelectArea("CTH")
	dbClearFilter()

	dbselectArea("CT2")
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f210Soma  ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function f210Soma(cTipo,cSegAte)

Local nRetValor		:= 0

	If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOCLVL == "1" .And. cArqTmp->NIVEL1
			If cTipo == "D"
				nRetValor := cArqTmp->SALDODEB
			ElseIf cTipo == "C"
				nRetValor := cArqTmp->SALDOCRD
			EndIf
		EndIf
	Else								// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If cArqTmp->TIPOCLVL == "2"
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOCLVL == "1" .And. cArqTmp->NIVEL1
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			EndIf
    	Endif
	EndIf                     

Return nRetValor
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f210Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function f210Fil(cSegAte, nDigitAte,cMascara)

Local lDeixa	:= .T.

	If mv_par05 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCLVL == "2"
			lDeixa := .F.
		EndIf
	ElseIf mv_par05 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCLVL == "1"
			lDeixa := .F.
		EndIf
	EndIf
	// Verifica Se existe filtragem Ate o Segmento
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)

		nDigitAte := CtbRelDig(cSegAte,cMascara) 	

		If Len(Alltrim(cArqTmp->CLVL)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)