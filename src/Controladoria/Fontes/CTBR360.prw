/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "ctbr360.Ch"
#Include "PROTHEUS.Ch"

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema


// 17/08/2009 -- Filial com mais de 2 caracteres


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR360  ³ Autor ³ Eduardo Nunes Cirqueira ³ Data ³ 12/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Comparativo de Tp Saldos (CC X Conta)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr360()                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbR360()

Local oReport
Private cPerg		:= "CTR360"
Private NomeProg	:= "CTBR360"


If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					  	   	 ³
//³ mv_par01				// Data Inicial              	       	 ³
//³ mv_par02				// Data Final                           ³
//³ mv_par03				// Conta Inicial                        ³
//³ mv_par04				// Conta Final  					   	    ³
//³ mv_par05				// Do Centro de Custo                   ³
//³ mv_par06				// Ate Centro de Custo                  ³
//³ mv_par07				// Imprime Contas: Sintet/Analit/Ambas  ³
//³ mv_par08				// Set Of Books				    	   	 ³
//³ mv_par09				// Considera Variacao 0.00 			  	 ³
//³ mv_par10				// Moeda?          			     	   	 ³
//³ mv_par11				// Pagina Inicial  		     		   	 ³
//³ mv_par12				// Tipo de Saldo 1                    	 ³
//³ mv_par13				// Tipo de Saldo 2                    	 ³
//³ mv_par14				// Imprimir ate o Segmento?			    ³
//³ mv_par15				// Filtra Segmento?					   	 ³
//³ mv_par16				// Conteudo Inicial Segmento?		   	 ³
//³ mv_par17				// Conteudo Final Segmento?		       ³
//³ mv_par18				// Conteudo Contido em?				   	 ³
//³ mv_par19				// Pula Pagina                          ³
//³ mv_par20				// Salta linha sintetica ?			       ³
//³ mv_par21				// Imprime valor 0.00    ?			       ³
//³ mv_par22				// Imprimir CC?Normal / Reduzido        ³
//³ mv_par23				// Divide por ?                   		 ³
//³ mv_par24				// Imprime Cod. Conta ? Normal/Reduzido ³
//³ mv_par25				// Imprime C.Custo: Sintet/Analit/Ambas ³
//³ mv_par26				// Imprime Até o Segmento (C.Custo)?  	 ³
//³ mv_par27				// Filtra Segmento (C.Custo) ?		    ³
//³ mv_par28				// Conteudo Inicial Segmento(C.Custo) ? ³
//³ mv_par29				// Conteudo Final Segmento(C.Custo) ?   ³
//³ mv_par30				// Conteudo Contido em(C.Custo) ?   	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := ReportDef()
oReport:PrintDialog()

//Limpa os arquivos temporários
CTBGerClean()


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Eduardo Nunes      º Data ³  12/09/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local oSection1
Local oSection2
Local nTamValor		:= TAMSX3("CT2_VALOR")[1]
Local aTamCC    	:= TAMSX3("CTT_CUSTO")
Local aTamCCRes 	:= TAMSX3("CTT_RES")
Local aTamConta		:= TAMSX3("CT1_CONTA")
Local aTamCtaRes	:= TAMSX3("CT1_RES")
Local cPrmMoed		:= IIf( Empty( MV_PAR10 ), "01", MV_PAR10 )
Local nTamCC  		:= Len(CriaVar("CTT->CTT_DESC"+ cPrmMoed ))
Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC"+ cPrmMoed ))
Local cSayCC		:= CtbSayApro("CTT")
LOCAL cDesc1 		:= OemToAnsi(STR0001)+ Upper(cSayCC)+ " / " + Upper(OemToAnsi(STR0003))	//"Este programa ira imprimir o Comparativo de Tipos de Saldos de  "
LOCAL cDesc2 		:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"
Local Titulo 		:= Upper(OemToAnsi(STR0013))+ Alltrim(Upper(cSayCC))+ " X " + Upper(OemToAnsi(STR0003))	//"Comparativo  / Conta"
Local cMascara
Local nTamConta		:= 0
Local aSetOfBook 	:= CTBSetOf(mv_par08)
Local cSeparador	:= ""

If Empty(aSetOfBook[2])
	cMascara	:= GetMv("MV_MASCARA")	
Else
	cMascara	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf

//Tratamento para tamnaho da conta + Mascara
nTamConta	:= aTamConta[1] + Len(cMascara)

oReport := TReport():New(NomeProg,Titulo,cPerg,;
								  {|oReport| If(!Ct040Valid(mv_par08),oReport:CancelPrint(),ReportPrint(oReport,Titulo))},;
								  cDesc1+cDesc2)

oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)

oReport:SetPortrait(.T.)

// Secao 1 (Centro de Custo)
oSection1 := TRSection():New(oReport,cSayCC,{"cArqTmp"},/*aOrder*/,.F./*lLoadCells*/,.F./*cTotalText*/,/*lTotalInCol*/,/*lHeaderPage*/,.F./*lHeaderBreak*/)

TRCell():New(oSection1,"CUSTO"	,"cArqTmp",,/*Picture*/,aTamCC[1]+5	,/*lPixel*/,/*{|| }*/)
TRCell():New(oSection1,"DESCCC"	,"cArqTmp",,/*Picture*/,nTamCC			,/*lPixel*/,/*{|| }*/)

oSection1:SetTotalInLine(.F.)
oSection1:SetLineStyle()

// Secao 2 (Conta)
oSection2 := TRSection():New(oReport,Capital(STR0018),{"cArqTmp"},/*aOrder*/,.F./*lLoadCells*/,.F./*lLoadOrder*/)		//"CONTA"

TRCell():New(oSection2,"CONTA"		,"cArqTmp",,/*Picture*/,nTamConta	,/*lPixel*/, /*{|| }*/ )	// Codigo da Conta
TRCell():New(oSection2,"DESCCTA"		,"cArqTmp",,/*Picture*/,nTamCta			,/*lPixel*/, /*{|| }*/ )	// Descricao da Conta
TRCell():New(oSection2,"SALDO1"		,"cArqTmp",,/*Picture*/,nTamValor		,/*lPixel*/, /*{|| }*/,"RIGHT",,"CENTER" )	// Valor no Primeiro tipo de saldo
TRCell():New(oSection2,"SALDO2"		,"cArqTmp",,/*Picture*/,nTamValor		,/*lPixel*/, /*{|| }*/,"RIGHT",,"CENTER" )	//	Valor no Primeiro tipo de saldo
TRCell():New(oSection2,"VARIACAO"	,"cArqTmp",,/*Picture*/,nTamValor		,/*lPixel*/, /*{|| }*/,"RIGHT",,"CENTER" )	// Vaiacao %

oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderPage(.T.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint³ Autor ³ Eduardo Nunes      ³ Data ³  12/09/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR360                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport,Titulo)

Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)
Local cFiltro		:= oSection1:GetAdvplExp()  /*aReturn[7]*/
Local oBreakCusto
Local oBreakPeriodo
Local oTotCus1, oTotCus2
Local oTotSld1, oTotSld2
Local nTotCus1, nTotCus2
Local nTotSld1, nTotSld2
Local aSetOfBook
Local aCtbMoeda	:= {}
Local cArqTmp		:=	""
LOCAL cString		:= "CT1"
Local cMascara1	:=	""
Local cMascara2	:=	""
Local cSepara1		:=	""
Local cSepara2		:=	""
Local cPicture		:=	""
Local cSegAte		:= mv_par14
Local cSegAteCC	:= mv_par26
Local cDescMoeda
Local cTpSld1		:=	mv_par12		//Tipo de Saldo 1
Local cTpSld2		:=	mv_par13		//Tipo de Saldo 2
Local cDescSld1	:=	Tabela("SL",mv_par12,.F.)
Local cDescSld2	:=	Tabela("SL",mv_par13,.F.)
Local cTipoLanc   //na quebra de sintetica pular uma linha
Local cCusto		:= ""
Local cCustoAnt	:= ""
Local nTamValor	:= TAMSX3("CT2_VALOR")[1]
Local aTamCC    	:= TAMSX3("CTT_CUSTO")
Local aTamCCRes 	:= TAMSX3("CTT_RES")
Local aTamCtaRes	:= TAMSX3("CT1_RES")
Local cPrmMoed		:= IIf( Empty( MV_PAR10 ), "01", MV_PAR10 )
Local nTamCC  		:= Len(CriaVar("CTT->CTT_DESC"+ cPrmMoed ))
Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC"+ cPrmMoed ))
Local aTamConta	:= TAMSX3("CT1_CONTA")
Local cSayCC		:= CtbSayApro("CTT")
Local nDecimais 	:= 2
Local nDivide		:= 1
Local nDigitAte	:= 0
Local nDigAteCC	:= 0
Local nPos			:= 0
Local nPosCC		:= 0
Local nDigitos		:= 0
Local nDigitCC		:= 0
Local lVar0			:= ( mv_par09 == 1 )
Local lPulaPag		:= ( mv_par19 == 1 )
Local lPulaSint	:= ( mv_par20 == 1 )
Local lPrintZero	:= ( mv_par21 == 1 )
Local lCCNormal	:= ( mv_par22 == 1 )
Local lCNormal		:= ( mv_par24 == 1 )
Local lPriVez		:= .T.
Local dDataFim 	:= mv_par02
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local bNormal 		:= {|| cArqTmp->TIPOCONTA }
Local lCharSinal	:= .F.

If lIsRedStor
	bNormal	:= {|| cArqTmp->NORMAL }
Endif

Private nTotSld1 := 0
Private nTotSld2 := 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)				  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSetOfBook := CTBSetOf(mv_par08)

lCt1Sint := If(mv_par07 == 2,.F.,.T.)
lCttSint := If(mv_par25 >= 2,.T.,.F.)


aCtbMoeda  	:= CtbMoeda(mv_par10,nDivide)

cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)

If Empty(aSetOfBook[2])					/// OBTEM A MASCARA PARA A CONTA
	cMascara1	:= GetMv("MV_MASCARA")
Else
	cMascara1	:= RetMasCtb(aSetOfBook[2],@cSepara1)
EndIf
If Empty(aSetOfBook[6])					/// OBTEM A MASCARA PARA O CENTRO DE CUSTO
	cMascara2 := GetMv("MV_MASCCUS")
Else
	cMascara2 := RetMasCtb(aSetOfBook[6],@cSepara2)
EndIf
//Tratamento para tamnaho da conta + Mascara
nTamConta	:= aTamConta[1] + Len(cMascara1)

cPicture 	:= aSetOfBook[4]

Titulo	:= AllTrim(Titulo)
Titulo 	+= SPACE(01)+"("+cDescSld1+"/"+cDescSld2+") "
Titulo	+= OemToAnsi(STR0014)+ Alltrim(cDescMoeda)+OemToAnsi(STR0015)+Dtoc(mv_par01)
Titulo	+= OemToAnsi(STR0016)+ Dtoc(mv_par02)


If mv_par23 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par23 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par23 == 4		// Divide por milhao
	nDivide := 1000000
EndIf

If Empty(aCtbMoeda[1])
	Help(" ",1,"NOMOEDA")
	oReport:CancelPrint()
	Return
Endif

If !Empty(aSetOfBook[5])
	MsgInfo("O plano gerencial ainda não está disponível para este relatório."+CHR(10)+"Altere a configuração de livros...","Config. de Livros...")
	oReport:CancelPrint()
	Return
Endif


cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)


If !Empty(mv_par15)			//// FILTRA O SEGMENTO Nº
	mv_par15 := strzero(val(mv_par15),2)
	If Empty(mv_par08)		//// VALIDA SE O CÓDIGO DE CONFIGURAÇÃO DE LIVROS ESTÁ CONFIGURADO
		help("",1,"CTN_CODIGO")
		oReport:CancelPrint()
		Return
	Endif
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+aSetOfBook[2])
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == aSetOfBook[2]
			nPos += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == STRZERO(val(mv_par15),2)
				nPos -= Val(CTM->CTM_DIGITO)
				nPos ++
				nDigitos := Val(CTM->CTM_DIGITO)
				Exit
			EndIf
			dbSkip()
		EndDo
	Else
		help("",1,"CTM_CODIGO")
		oReport:CancelPrint()
		Return
	EndIf
EndIf

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascara1)
EndIf

///////////////////////////////////////////////////////////////////////
/// MONTAGEM DAS VARIAVEIS PARA FILTRAGEM DE SEGMENTO POR C.CUSTO
///////////////////////////////////////////////////////////////////////
If !Empty(mv_par27)			//// FILTRA O SEGMENTO Nº
	mv_par27 := strzero(val(mv_par27),2)
	If Empty(mv_par08)		//// VALIDA SE O CÓDIGO DE CONFIGURAÇÃO DE LIVROS ESTÁ CONFIGURADO
		help("",1,"CTN_CODIGO")
		oReport:CancelPrint()
		Return
	Endif
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+aSetOfBook[6])
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == aSetOfBook[6]
			nPosCC += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == STRZERO(val(mv_par27),2)
				nPosCC -= Val(CTM->CTM_DIGITO)
				nPosCC ++
				nDigitCC := Val(CTM->CTM_DIGITO)
				Exit
			EndIf
			dbSkip()
		EndDo
	Else
		help("",1,"CTM_CODIGO")
		oReport:CancelPrint()
		Return
	EndIf
EndIf

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAteCC)
	nDigAteCC := CtbRelDig(cSegAteCC,cMascara2)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
		CtbGerCmp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				   mv_par01,mv_par02,"CT3",mv_par03,mv_par04,mv_par05,mv_par06,,,,,;
				   mv_par10,cTpSld1,cTpSld2,aSetOfBook,mv_par15,mv_par16,mv_par17,mv_par18,;
				   mv_par14,lVar0,nDivide,,,,lCt1Sint,cString,cFiltro,lCttSint)},;
			OemToAnsi(OemToAnsi(STR0010)),;  //"Criando Arquivo Tempor rio..."
			OemToAnsi(STR0006))  				//"Comparativo de Tipo de Saldos "

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()

TRPosition():New(oSection1,"CTT",1,{|| xFilial("CTT") + cArqTmp->CUSTO })
TRPosition():New(oSection1,"CT1",1,{|| xFilial("CT1") + cArqTmp->CONTA })

// Secao 1 - Alguns tratamentos

// Setando o titulo das celulas
oSection1:Cell("CUSTO"	):SetTitle(Upper(cSayCC))
oSection1:Cell("DESCCC"	):SetTitle(STR0019)

// Setando os Blocos de Codigo das celulas
If lCCNormal .Or. cArqTmp->TIPOCC == "1"		//Se Imprime Cod. Normal do CC ou e sintetico
	oSection1:Cell("CUSTO"):SetBlock( {||	EntidadeCTB(cArqTmp->CUSTO,,,nTamCC+10,.F.,cMascara2,cSepara2,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)} )
Else
	oSection1:Cell("CUSTO"):SetBlock( {||	EntidadeCTB(cArqTmp->CCRES,,,nTamCC+10,.F.,cMascara2,cSepara2,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)} )
EndIf
oSection1:Cell("DESCCC"):SetBlock( {||		cArqTMP->DESCCC} )

// Secao 2 - Alguns tratamentos

// Setando o titulo das celulas
oSection2:Cell("CONTA"		):SetTitle(STR0018)
oSection2:Cell("DESCCTA"	):SetTitle(STR0019)
oSection2:Cell("SALDO1"		):SetTitle(Space(05)+cDescSld1)
oSection2:Cell("SALDO2"		):SetTitle(Space(05)+cDescSld2)
oSection2:Cell("VARIACAO"	):SetTitle(Space(05)+STR0007  )

If lCNormal
	oSection2:Cell("CONTA"):SetBlock( {|| EntidadeCTB(cArqTmp->CONTA,,,nTamConta,.F.,cMascara1,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)} )
Else
	oSection2:Cell("CONTA"):SetBlock( {|| EntidadeCTB(cArqTmp->CTARES,,,nTamConta,.F.,cMascara1,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)} )
EndIf


// Setando os Blocos de Codigo das celulas
oSection2:Cell("DESCCTA"):SetBlock	(	{||	cArqTmp->DESCCTA} )
oSection2:Cell("SALDO1"):SetBlock	(	{|| ValorCTB(cArqTmp->MOVIMENTO1,,,nTamValor,nDecimais,.T.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})	//	Valor do primeiro saldo
oSection2:Cell("SALDO2"):SetBlock	(	{|| ValorCTB(cArqTmp->MOVIMENTO2,,,nTamValor,nDecimais,.T.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})	//	Valor do segundo saldo
oSection2:Cell("VARIACAO"):SetBlock	(	{|| ValorCTB(Abs(cArqTmp->(MOVIMENTO1/MOVIMENTO2)*100),,,15,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr)})	//	% de Variacao entre os dois saldos

oSection2:OnPrintLine({||( If( lPulaSint .And. (cTipoLanc == "1" .Or. (cArqTmp->TIPOCONTA == "1" .And. cTipoLanc == "2")),;
										  oReport:SkipLine(),;
										  NIL ),;
										  cTipoLanc := cArqTmp->TIPOCONTA) })


oBreakCusto := TRBreak():New(oSection1, {|| cArqTMP->CUSTO },{||	STR0011+" "+ RTrim( Upper(cSayCC) ) + ": "+cCustoAnt })	//	" T O T A I S  D O "

If lPulaPag
	oBreakCusto:SetPageBreak(.T.)
EndIf

//If !lCttSint
//	oBreakPeriodo := TRBreak():New(oSection2, {|| .T.}, STR0012 )  //"T O T A I S  D O  P E R I O D O : "
//Endif

oSection2:SetTotalText({|| STR0012 })

// Totalizadores por Centro de Custo
oTotCus1 :=	TRFunction():New(oSection2:Cell("SALDO1"	 ),nil,"SUM"		,oBreakCusto,/*Titulo*/,/*cPicture*/,{ || F360Soma("1",cSegAte) },.F.,.F.,.F.,oSection2)
				TRFunction():New(oSection2:Cell("SALDO1"	 ),nil,"ONPRINT"	,oBreakCusto,/*Titulo*/,/*cPicture*/,{ || (nTotCus1 := oTotCus1:GetValue(),ValorCTB(nTotCus1,,,nTamValor-2,nDecimais,.T.,cPicture,Iif(lIsRedStor,"1",cArqTmp->TIPOCONTA),,,,,,lPrintZero,.F.,,lCharSinal)) },.F.,.F.,.F.,oSection2)

oTotCus2 :=	TRFunction():New(oSection2:Cell("SALDO2"	 ),nil,"SUM"		,oBreakCusto,/*Titulo*/,/*cPicture*/,{ || F360Soma("2",cSegAte) },.F.,.F.,.F.,oSection2)
				TRFunction():New(oSection2:Cell("SALDO2"	 ),nil,"ONPRINT"	,oBreakCusto,/*Titulo*/,/*cPicture*/,{ || (nTotCus2 := oTotCus2:GetValue(),ValorCTB(nTotCus2,,,nTamValor-2,nDecimais,.T.,cPicture,Iif(lIsRedStor,"1",cArqTmp->TIPOCONTA),,,,,,lPrintZero,.F.,,lCharSinal)) },.F.,.F.,.F.,oSection2)
				TRFunction():New(oSection2:Cell("VARIACAO"),nil,"ONPRINT"	,oBreakCusto,/*Titulo*/,/*cPicture*/,{ || ValorCTB(Abs((nTotCus1/nTotCus2)*100),,,nTamValor,nDecimais,.F.,cPicture,Iif(lIsRedStor," ",cArqTmp->TIPOCONTA),,,,,,lPrintZero,.F.,,lCharSinal) },.F.,.F.,.F.,oSection2)


// Desabilitando, pois a quebra sera feita pelo oBreakCusto
oTotCus1:Disable()
oTotCus2:Disable()

// Totalizadores Gerais
oTotSld1 :=	TRFunction():New(oSection2:Cell("SALDO1"),nil,"SUM"		,oBreakPeriodo,/*Titulo*/,/*cPicture*/,{ || F360Soma("1",cSegAte) },.F.,.F.,.F.,oSection2)
				TRFunction():New(oSection2:Cell("SALDO1"),nil,"ONPRINT"	,oBreakPeriodo,/*Titulo*/,/*cPicture*/,{ || nTotSld1 := oTotSld1:GetValue(),(ValorCTB(nTotSld1,,,nTamValor-2,nDecimais,.T.,cPicture,Iif(lIsRedStor,"1",cArqTmp->TIPOCONTA),,,,,,lPrintZero,.F.,,lCharSinal)) },.T.,.F.,.F.,oSection2)


oTotSld2 :=	TRFunction():New(oSection2:Cell("SALDO2"),nil,"SUM"		,oBreakPeriodo,/*Titulo*/,/*cPicture*/,{ || F360Soma("2",cSegAte) },.F.,.F.,.F.,oSection2)
				TRFunction():New(oSection2:Cell("SALDO2"),nil,"ONPRINT"	,oBreakPeriodo,/*Titulo*/,/*cPicture*/,{ || nTotSld2 := oTotSld2:GetValue(),(ValorCTB(nTotSld2,,,nTamValor-2,nDecimais,.T.,cPicture,Iif(lIsRedStor,"1",cArqTmp->TIPOCONTA),,,,,,lPrintZero,.F.,,lCharSinal)) },.T.,.F.,.F.,oSection2)

				TRFunction():New(oSection2:Cell("VARIACAO"),nil,"ONPRINT"	,oBreakPeriodo,/*Titulo*/,/*cPicture*/,{ || ValorCTB(Abs((nTotSld1/nTotSld2)*100),,,nTamValor,nDecimais,.F.,cPicture,Iif(lIsRedStor," ",cArqTmp->TIPOCONTA),,,,,,lPrintZero,.F.,,lCharSinal) },.T.,.F.,.F.,oSection2)

// Desabilitando, pois a quebra sera feita pelo oBreakPeriodo
oTotSld1:Disable()
oTotSld2:Disable()

oBreakPeriodo := TRBreak():New(oReport, {|| .T. }, STR0012 )  //"T O T A I S  D O  P E R I O D O : "

oReport:SetTitle(Titulo)
oReport:SetPageNumber(mv_par11)
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )


oReport:SetMeter(RecCount())

oSection1:Init()
oSection2:Init()

cCusto		:= cArqTmp->CUSTO
cCustoAnt	:= cArqTmp->CUSTO


While !Eof()

	If oReport:Cancel()
		Exit
	EndIF

	oReport:IncMeter()


	******************** "FILTRAGEM" PARA IMPRESSAO *************************

	If lVar0
		If MOVIMENTO1 == 0 .And. MOVIMENTO2 == 0
			If CtbExDtFim("CT1")
				dbSelectArea("CT1")
				dbSetOrder(1)
				If MsSeek(xFilial()+cArqTmp->CONTA)
					If !CtbVlDtFim("CT1",mv_par01)
			     		dbSelectArea("cArqTmp")
			     		dbSkip()
			     		Loop
					EndIf
				EndIf
			EndIf

			If CtbExDtFim("CTT")
				dbSelectArea("CTT")
				dbSetOrder(1)
				If MsSeek(xFilial()+cArqTmp->CUSTO)
					If !CtbVlDtFim("CTT",mv_par01)
			     		dbSelectArea("cArqTmp")
			     		dbSkip()
			     		Loop
					EndIf
				EndIf
			EndIf

			dbSelectArea("cArqTmp")
		EndIf
	EndIf

	//////////////////////////////////////////////////////////////////////////////////////////
	//Caso faca filtragem por segmento DA CONTA ,verifico se esta dentro
	//da solicitacao feita pelo usuario.
	//////////////////////////////////////////////////////////////////////////////////////////
	If mv_par07 == 1					// So imprime Sinteticas
		If TIPOCONTA == "2"
			dbSkip()
			Loop
		EndIf
	ElseIf mv_par07 == 2				// So imprime Analiticas
		If TIPOCONTA == "1"
			dbSkip()
			Loop
		EndIf
	EndIf

	//Filtragem ate o Segmento da Conta( antigo nivel do SIGACON)
	If !Empty(cSegAte)
		If Len(Alltrim(CONTA)) > nDigitAte
			dbSkip()
			Loop
		Endif
	EndIf

	/*If !Empty(mv_par15)
		If Empty(mv_par16) .And. Empty(mv_par17) .And. !Empty(mv_par18)
			If  !(Substr(CONTA,nPos,nDigitos) $ (mv_par18) )
				dbSelectArea("cArqTMP")
				dbSkip()
				Loop
			EndIf
		Else
			If Substr(CONTA,nPos,nDigitos) < Alltrim(mv_par16) .Or. Substr(CONTA,nPos,nDigitos) > Alltrim(mv_par17)
				dbSelectArea("cArqTMP")
				dbSkip()
				Loop
			EndIf
		Endif
	EndIf*/

	//////////////////////////////////////////////////////////////////////////////////////////
	//Caso faca filtragem por segmento DO CENTRO DE CUSTO, verifico se esta dentro
	//da solicitacao feita pelo usuario.
	//////////////////////////////////////////////////////////////////////////////////////////
	If mv_par25 == 2		/// Se imprime somente C.Custo Sintetico
		If cArqTMP->TIPOCC == "2"
			dbSkip()
			Loop
		EndIf
	EndIf					/// Se só imprime analiticas não há Sintetico no TRB / Ambas não precisa filtrar

	//Filtragem ate o Segmento do C.Custo
	If !Empty(cSegAteCC)
		If Len(Alltrim(CUSTO)) > nDigAteCC
			dbSkip()
			Loop
		Endif
	EndIf

	If !Empty(mv_par27)
		If Empty(mv_par28) .And. Empty(mv_par29) .And. !Empty(mv_par30)
			If  !(Substr(CUSTO,nPosCC,nDigitCC) $ (mv_par30) )
				dbSelectArea("cArqTMP")
				dbSkip()
				Loop
			EndIf
		Else
			If Substr(CUSTO,nPosCC,nDigitCC) < Alltrim(mv_par28) .Or. Substr(CUSTO,nPosCC,nDigitCC) > Alltrim(mv_par29)
				dbSelectArea("cArqTMP")
				dbSkip()
				Loop
			EndIf
		Endif
	EndIf

	************************* ROTINA DE IMPRESSAO *************************

	If lPriVez .Or. cCusto <> cArqTmp->CUSTO
		cCustoAnt	:= cCusto
		oSection1:PrintLine()
     	oReport:ThinLine()
     	lPriVez := .F.
	EndIf

   cCustoAnt	:= If(	cCusto <> cArqTmp->CUSTO .Or. EOF(),	cCusto,	cCustoAnt	)
	cCusto		:= If(	!EOF(),	cArqTmp->CUSTO,	cCusto	)

	oSection2:PrintLine()

	dbSelectArea("cArqTmp")
	dbSkip()

EndDo

cCustoAnt := cCusto

oSection1:Finish()
oSection2:Finish()

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF
dbselectArea("CT2")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F360Soma  ºAutor  ³Eduardo Nunes       º Data ³  13/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Calcular os valores para a totalizacao das colunas          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR360                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F360Soma(cSaldo,cSegAte)

Local cCampo 	:= "MOVIMENTO"+cSaldo
Local nRetorno	:= 0
Local nPosCpo 	:= cArqTmp->(FieldPos(cCampo))

If nPosCpo > 0
	If mv_par07 == 1 .Or. mv_par07 = 3 	// So imprime Sinteticas ou ambas - Soma Sinteticas
		If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1
			nRetorno := cArqTmp->(FieldGet(nPosCpo))
		EndIf
   	Else         							//	Se soma as analiticas ou ambas
	  	If Empty(cSegAte)  					//	Se nao tiver filtragem ate o nivel
			If cArqTmp->TIPOCONTA == "2"
				nRetorno := cArqTmp->(FieldGet(nPosCpo))
			EndIf
		Else										//	Se tiver filtragem ate o nivel, somo somente as sinteticas
			If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1
				nRetorno := cArqTmp->(FieldGet(nPosCpo))
			Endif
		EndIf
	EndIf
EndIf

Return nRetorno
