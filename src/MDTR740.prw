/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr740.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR740  ³ Autor ³ Rafael Diogo Richter  ³ Data ³ 16/06/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de atestados Medico emitidos				      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR740( aPerg )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM()
Local nX		  := 0

Default aPerg := {}

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

cPerg := If(!lSigaMdtPS,PADR("MDT740",10),PADR("MDT740PS",10))

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif
/*---------------------------------
//PERGUNTAS PADRÃO					|
| 01  Tipo Impressao ?            	|
| 02  De Ficha Medica ?           	|
| 03  Ate Ficha Medica ?          	|
| 04  De Data ?                   	|
| 05  Ate Data ?                  	|
| 06  Exibir CID no Atestado ?    	|
| 07  Unidade Administrativa ?    	|
| 08  CID Complementar ?   			|
| 09  Assinatura do funcionário ? 	|
|									|
//PERGUNTAS PRESTADOR DE SERVIÇO	|
| 01  De  Cliente ?             	|
| 02  Loja                      	|
| 03  Até Cliente ?             	|
| 04  Loja                      	|
| 05  Tipo Impressao ?          	|
| 06  De Ficha Medica ?         	|
| 07  Ate Ficha Medica ?        	|
| 08  De Data ?                 	|
| 09  Ate Data ?                	|
| 10  Exibir CID no Atestado ?  	|
| 11  CID Complementar ?   			|
| 12  Assinatura do funcionário ? 	|
-----------------------------------*/

If Len(aPerg) > 0

	//Joga os valores para os Mv_par
	Mv_par01 := aPerg[1,1]
	Mv_par02 := aPerg[2,1]
	Mv_par03 := aPerg[3,1]
	Mv_par04 := aPerg[4,1]
	Mv_par05 := aPerg[5,1]
	Mv_par06 := aPerg[6,1]
	Mv_par07 := aPerg[7,1]
	Mv_par08 := aPerg[8,1]
	Mv_par09 := aPerg[9,1]

	U_MDT740IMP()

Else
	If pergunte(AllTrim(cPerg),.t.)
		U_MDT740IMP()
	Endif
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MDT740IMP³ Autor ³Rafael Diogo Richter   ³ Data ³16/06/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT740IMP()

//Variaveis para controle da regua de progressao
Local bAcao := { |lEnd| U_MODMDT740(@lEnd) }
Local cTitulo := STR0011	//"Atestado Medico"
Local cMsg := STR0010	//"Imprimindo atestados médicos..."
Local lAborta := .T.

Private lCancel := .F.
PRIVATE oPrint
Private lin := 0
Private oFont06,oFont07,oFont08,oFont09,oFont10p,oFont10r,oFont11,oFont11t,oFont12,oFont13,oFont14,oFont15,oFont20
oFont06	:= TFont():New("Courier New",06,06,,.F.,,,,.F.,.F.)
oFont07	:= TFont():New("Courier New",07,07,,.F.,,,,.F.,.F.)
oFont08	:= TFont():New("Courier New",08,08,,.F.,,,,.F.,.F.)
oFont09	:= TFont():New("Courier New",09,09,,.F.,,,,.F.,.F.)
oFont10r := TFont():New("Courier New",10,10,,.F.,,,,.F.,.F.)
oFont10p := TFont():New("Courier New",10,10,,.T.,,,,.F.,.F.)
oFont11t := TFont():New("Courier New",11,11,,.F.,,,,.F.,.F.)
oFont11	:= TFont():New("Courier New",11,11,,.T.,,,,.T.,.T.)
oFont12	:= TFont():New("Courier New",12,12,,.T.,,,,.F.,.F.)
oFont13	:= TFont():New("Courier New",12,12,,.F.,,,,.F.,.F.)
oFont14	:= TFont():New("Courier New",12,12,,.T.,,,,.F.,.F.)
oFont15	:= TFont():New("Courier New",15,15,,.T.,,,,.F.,.F.)
oFont20	:= TFont():New("Courier New",20,20,,.T.,,,,.F.,.F.)

oPrint	:= TMSPrinter():New(OemToAnsi(STR0001)) //"Atestado Clínico"
oPrint:Setup()

Processa( bAcao, cTitulo, cMsg, lAborta )
If lCancel
	MsgStop(STR0013)	//"CANCELADO PELO OPERADOR"
	Return
Else
	If lSigaMdtps
		If Mv_par05 == 2
			oPrint:Print()
		Else
			oPrint:Preview()
		Endif
	Else
		If Mv_par01 == 2
			oPrint:Print()
		Else
			oPrint:Preview()
		Endif
	Endif
EndIf

Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MODMDT740³ Autor ³Rafael Diogo Richter   ³ Data ³16/06/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Modelo Individual                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MODMDT740(lEnd)
Local cAliasCC := "SI3"
Local cDescCC2 := "SI3->I3_DESC"

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cDescCC2 := "CTT->CTT_DESC01"
Endif

If lSigaMdtps
	dbSelectArea("TM0")
	dbSetOrder(02)
	dbSeek(xFilial("TM0"))
	ProcRegua(reccount())
	While !Eof() .AND. TM0->TM0_FILIAL = xFilial('TM0')

		If lEnd
			lCancel := .T.
			Exit
		EndIf

		IncProc()

		If TM0->(TM0_CLIENT+TM0_LOJA) < mv_par01+mv_par02 .or. TM0->(TM0_CLIENT+TM0_LOJA) > mv_par03+mv_par04
	  		DBSkip()
	    	Loop
	    ENDIF

	 	IF TM0->TM0_NUMFIC < MV_PAR06 .or. TM0->TM0_NUMFIC > MV_PAR07
	  		DBSkip()
	    	Loop
	    ENDIF

	    dbSelectArea("SRJ")
	    dbSetOrder(1)
	    dbSeek(xFilial("SRJ")+TM0->TM0_CODFUN)

	    dbSelectArea(cAliasCC)
	    dbSetOrder(1)
	    dbSeek(xFilial(cAliasCC)+TM0->TM0_CC)

	    dbselectArea("TNY")
		dbSetOrder(01)
		dbSeek(xFilial("TNY")+TM0->TM0_NUMFIC)
		While !Eof() .AND. TNY->TNY_FILIAL = xFilial('TNY') .AND. TNY->TNY_NUMFIC = TM0->TM0_NUMFIC
	 		IF TNY->TNY_DTINIC < MV_PAR08 .or. TNY->TNY_DTINIC > MV_PAR09
	   			dbSkip()
	   			Loop
	   		ENDIF
			U_ImpAtestTNY(3,@oPrint) //3-Prestador - Esta Função está no MDTA685.prx
	   		dbSelectArea("TNY")
	     	dbSkip()
		END
		dbSelectArea("TM0")
		dbSkip()
	END
Else
	dbSelectArea("TM0")
	dbSetOrder( 01 )
	dbSeek(xFilial("TM0"))
	ProcRegua(reccount())
	Do While TM0->(!Eof()) .AND. TM0->TM0_FILIAL = xFilial('TM0')
		If lEnd
			lCancel := .T.
			Exit
		EndIf

		IncProc()
	 	IF TM0->TM0_NUMFIC < MV_PAR02 .or. TM0->TM0_NUMFIC > MV_PAR03
	  		TM0->(DBSkip())
	    	Loop
	    ENDIF

	    dbSelectArea("SRJ")
	    dbSetOrder(1)
	    dbSeek(xFilial("SRJ")+TM0->TM0_CODFUN)

	    dbSelectArea(cAliasCC)
	    dbSetOrder(1)
	    dbSeek(xFilial(cAliasCC)+TM0->TM0_CC)

	    dbselectArea("TNY")
		dbSetOrder(01)
		dbSeek(xFilial("TNY")+TM0->TM0_NUMFIC)
		While !Eof() .AND. TNY->TNY_FILIAL = xFilial('TNY') .AND. TNY->TNY_NUMFIC = TM0->TM0_NUMFIC
	 		IF TNY->TNY_DTINIC < MV_PAR04 .or. ( TNY->TNY_DTINIC > MV_PAR05 .And. !Empty(MV_PAR05) )
	   			TNY->(dbSkip())
	   			Loop
	   		ENDIF
			If IsincallStar("MDTA685") .or. IsincallStar("MDTA155")
			   U_ImpAtestTNY(1,@oPrint) //2-Padrao - Esta Função está no MDTA685.prx
			Else
               U_ImpAtestTNY(2,@oPrint) //2-Padrao - Esta Função está no MDTA685.prx
			EndIf

			dbSelectArea("TNY")
			TNY->(dbSkip())
		END
		dbSelectArea("TM0")
		TM0->(dbSkip())
	END
Endif

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDT740VAL³ Autor ³ Guilheme Benkendorf   ³ Data ³08/10/2012³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao para validacao dos parametros de SX1				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT740VAL(nTipo,nSX1,lPres)

	Local lRet		:= .T.

	Default nTipo	:= 0
	Default nSX1	:= 0
	Default lPres	:= .F.

	If lPres //Prestador
		If nSX1 == 11 .AND. MV_PAR10 == 2 .AND. MV_PAR11 == 1
			MsgInfo(STR0045, STR0044)
			lRet := .F.
		EndIf
	ElseIf nTipo == 1 //MDTA685
		If nSX1 == 4 .AND. MV_PAR02 == 2 .AND. MV_PAR04 == 1
			MsgInfo(STR0045, STR0044)
			lRet := .F.
		EndIf
	ElseIf nTipo == 2 //MDTR740
		If nSX1 == 8 .AND. MV_PAR06 == 2 .AND. MV_PAR08 == 1
			MsgInfo(STR0045, STR0044)
			lRet := .F.
		EndIf
	Endif

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ImpAtestTNY³ Autor ³ Denis                ³ Data ³ 18/03/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime o atestado medico.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Parametros do array a Rotina:                               ³±±
±±³          ³1. nTipo - 1=MDTA685; 2=Padrao MDTR740; 3=Prestador MDTR740 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ImpAtestTNY(nTipo,oPrint,lPres)
	Local oFont10p, oFont10, oFont12, oFont13, oFont20, cAuxAtestado, nHorasAf, nMinAf, cLogo, lin, cTempo
	Local nDiasAf := 0, POS := 0
	Local cHora := "",cMin := "", cDia := ""
	Local cHorasAf := "", cHrTot := ""
	Local cCidade := "SM0->M0_CIDCOB"  //Imprime endereco de Cobranca da Empresa (padrao)
	Local cSMCOD := If(FindFunction("FWGrpCompany"),FWGrpCompany(),SM0->M0_CODIGO)
	Local cSMFIL := If(FindFunction("FWCodFil"),FWCodFil(),SM0->M0_CODFIL)
	Local cAliasCC := "SI3"
	Local cDescCC2 := "SI3->I3_DESC"
	Local cBarraSrv := "\"
	Local cBarSrv2 := "\\"
	Local cROOTPATH
	Local cSTARPATH
	Local cDIREXETH
	Local cCIDC
	Local oTamFon //Verifica qual rotina esta em uso para utilizar o tamanho da fonte correto.
	Local lHFVazio
	Local lFunc   := .F. //Verifica se deve mostrar local para o funcionário assinar.
	Local lImpCid := .F.
	Local lImpCom := .F.
	Local lNoturn := .F.
	Local cHrIni := ""
	Local cHrFim := ""

	Local nCol  := 0 //Valor vertical da linha
	Local lUltra :=.F. //Controle se Ultrapassar limite da linha
	Local aAreaTMP
	Default lPres := .F.

	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
		cBarSrv2 := "//"
	Endif

	cROOTPATH := Alltrim(GetSrvProfString("RootPath",cBarraSrv) )
	cSTARPATH := AllTrim(GetSrvProfString("StartPath",cBarraSrv ) )
	cDIREXETH := cROOTPATH+cSTARPATH
	cDIREXETH := Strtran(cDIREXETH,cBarSrv2,cBarraSrv)

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAliasCC := "CTT"
		cDescCC2 := "CTT->CTT_DESC01"
	Endif

	If Alltrim(GETMV("MV_PAREND")) == "F" //Imprime Endereco Fiscal da Empresa
		cCidade := "SM0->M0_CIDENT"
	Endif

	oFont10p := TFont():New("Courier New",10,10,,.T.,,,,.F.,.F.)
	oFont10	 := TFont():New("Courier New",10,10,,.F.,,,,.F.,.F.)
	oFont12	 := TFont():New("Courier New",12,12,,.T.,,,,.F.,.F.)
	oFont13	 := TFont():New("Courier New",12,12,,.F.,,,,.F.,.F.)
	oFont20	 := TFont():New("Courier New",20,20,,.T.,,,,.F.,.F.)

	oPrint:StartPage() // Iniciar Pagina
	oPrint:Box(200,200,400,550)
	cLogo := "LGRL"+cSMCOD+cSMFIL+".BMP" // Empresa+Filial

	If File(cLogo)
		oPrint:SayBitMap(210,210,cLogo,335,185)
	Else
		cLogo := "LGRL"+cSMCOD+".BMP" // Empresa
		If File(cLogo)
			oPrint:SayBitMap(210,210,cLogo,335,185)
		ElseIf File(cDIREXETH+"LGRL"+cSMCOD+cSMFIL+".BMP")
			oPrint:SayBitMap(210,210,cDIREXETH+"LGRL"+cSMCOD+cSMFIL+".BMP",335,185)
		ElseIf File(cDIREXETH+"LGRL"+cSMCOD+".BMP")
			oPrint:SayBitMap(210,210,cDIREXETH+"LGRL"+cSMCOD+".BMP",335,185)
		ElseIf File("LGRL"+cSMCOD+cSMFIL+".BMP")
			oPrint:SayBitMap(210,210,"LGRL"+cSMCOD+cSMFIL+".BMP",335,185)
		ElseIf File("LGRL"+cSMCOD+".BMP")
			oPrint:SayBitMap(210,210,"LGRL"+cSMCOD+".BMP",335,185)
		ElseIf File("\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP")
			oPrint:SayBitMap(210,210,"\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP",335,185)
		ElseIf File("\SIGAADV\LGRL"+cSMCOD+".BMP")
			oPrint:SayBitMap(210,210,"\SIGAADV\LGRL"+cSMCOD+".BMP",335,185)
		Endif
	Endif

	dbSelectArea("TMR")
	dbSetOrder(1)
	dbSeek(xFilial("TMR")+TNY->TNY_CID)
	If nTipo == 1 //MDTA685
		dbSelectArea("TM0")
		dbSetOrder(1)
		dbSeek(xFilial("TM0")+TNY->TNY_NUMFIC)
		dbSelectArea("SRJ")
		dbSetOrder(1)
		dbSeek(xFilial("SRJ")+TM0->TM0_CODFUN)

		dbSelectArea(cAliasCC)
		dbSetOrder(1)
		dbSeek(xFilial(cAliasCC)+TM0->TM0_CC)
	ElseIf nTipo == 3 //Prestador
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+TNY->(TNY_CLIENT+TNY_LOJA))
	Endif

	lin := 200
	oPrint:Box(lin,570,lin+200,1520)

	If (TNY->TNY_TIPATE == "A")
		oPrint:Say(lin+65,600,Upper(STR0052/*STR0113*/),oFont20) //"AUTORIZAÇÂO DE SAÌDA"
		cAuxAtestado := "pela Autorização"
	Else
		oPrint:Say(lin+65,715,Upper(STR0053/*STR0006*/),oFont20) //"ATESTADO MÉDICO"
		cAuxAtestado := "pelo Atestado"
	EndIf

	oPrint:Box(lin,1540,lin+200,2200)
	oPrint:Say(lin+5,1550,STR0054/*STR0067*/,oFont10p) //"Unidade Administrativa"

	cNomeUnid := SUBSTR(SM0->M0_NOMECOM,1,22)
	If lPres //Prestador
		cNomeUnid := SA1->A1_NOME
	ElseIf nTipo == 1 //MDTA685
		If !Empty(mv_par03)
			cNomeUnid := mv_par03
		Endif
	ElseIf nTipo == 2 //Padrao
		If !Empty(mv_par07)
			cNomeUnid := mv_par07
		Endif
	ElseIf nTipo == 3
		cNomeUnid := SA1->A1_NOME
	Endif
	oPrint:Say(lin+100,1560,SUBSTR(cNomeUnid,1,22),oFont13)

	lin += 220 //420
	oPrint:Box(lin,200,lin+60,2200)
	oPrint:Say(lin+12,650,STR0055/*STR0068*/,oFont12) //"ATESTO PARA OS DEVIDOS FINS QUE O EMPREGADO"
	lin += 60 //480
	oPrint:Say(lin+5,210,STR0056/*STR0069*/,oFont10p) //"Nome"
	oPrint:Say(lin+70,220,TM0->TM0_NOMFIC,oFont13)
	oPrint:Line(lin,1540,lin+150,1540)
	oPrint:Say(lin+5,1550,STR0057/*STR0070*/,oFont10p) //"Nº R.G."
	oPrint:Say(lin+70,1560,TM0->TM0_RG,oFont13)
	oPrint:Line(lin,200,lin+150,200)
	oPrint:Line(lin,2200,lin+150,2200)
	oPrint:Line(lin+150,200,lin+150,2200)
	lin += 150
	oPrint:Say(lin+5,210,STR0058/*STR0109*/,oFont10p)  //"Função"
	oPrint:Say(lin+70,220,Alltrim(SRJ->RJ_DESC),oFont13)
	oPrint:Line(lin,200,lin+150,200)
	oPrint:Line(lin,2200,lin+150,2200)
	oPrint:Line(lin+150,200,lin+150,2200)
	oPrint:Line(lin,1200,lin+150,1200)
	oPrint:Say(lin+5,1210,STR0059/*STR0110*/,oFont10p)  //"Centro de Custo"
	oPrint:Say(lin+70,1220,Alltrim(&cDescCC2),oFont13)
	lin += 150

	If nTipo == 1 //MDTA685
		If Mv_par06 == 1
			lImpCid := .T.
			lImpCom := AliasIndic("TKI") .And. mv_par08 == 1
		Endif
	ElseIf nTipo == 2 //Padrao
		If Mv_par06 == 1
			lImpCid := .T.
			lImpCom := AliasIndic("TKI") .And. mv_par08 == 1
		Endif
	ElseIf nTipo == 3 //Prestador
		If Mv_par10 == 1
			lImpCid := .T.
			lImpCom := AliasIndic("TKI") .And. mv_par11 == 1
		Endif
	Endif
	If lImpCid .And. !Empty(TNY->TNY_CID)
		oPrint:Say(lin+5,210,STR0060/*STR0071*/,oFont10p) //"CID"
		oPrint:Say(lin+52,220,Memoline(Alltrim(TNY->TNY_CID),70,1),oFont13)
		oPrint:Say(lin+105,220,Memoline(Alltrim(TNY->TNY_CID),70,2),oFont13)
		oPrint:Line(lin,200,lin+150,200)
		oPrint:Line(lin,2200,lin+150,2200)
		oPrint:Line(lin+150,200,lin+150,2200)
		lin += 150
		If lImpCom
			dbSelectArea("TKI")
			dbSetOrder(1)
			dbSeek(xFilial("TKI")+TNY->TNY_NATEST)

			While !EOF() .And. xFilial('TKI')+TNY->TNY_NATEST = TKI->TKI_FILIAL+TKI->TKI_NATEST
				cCIDC := Alltrim(TKI->TKI_CID)

				If EMPTY(cCIDC) // Se não houver CID Complementar, não exibe
					dbSkip()
					Loop
				EndIf

				//Concatenacao dos CID complementares
				aAreaTMP := GetArea()
				dbSkip()
				cCIDC += If(Eof() .OR. xFilial('TKI')+TNY->TNY_NATEST <> TKI->TKI_FILIAL+TKI->TKI_NATEST,".",", ")
				RestArea(aAreaTMP)

				// Se houver muitos registros, pula linha.
				If nCol + Len(cCIDC) >= 1850
					nCol := 0
					If !lUltra //Se ainda nao ultrapassou, imprime titulo
						oPrint:Say(lin+5,210,STR0061/*STR0145*/,oFont10p) //"CID Complementar"
					Endif
					oPrint:Line(lin,200,lin+150,200)
					oPrint:Line(lin,2200,lin+150,2200)
					lin+=100
					lUltra:= .T.
				EndIF
				//imprime os valores do CID Complementar e incrementa espaco para o lado
				oPrint:Say(lin+52,nCol+220,AllTrim(cCIDC),oFont13)
				nCol += 170

				dbSkip()
				Loop
			End
			// Se encontrou e nao ultrapassa linha titulo
			IF dbSeek(xFilial("TKI")+TNY->TNY_NATEST) .And. !lUltra
				oPrint:Say(lin+5,210,STR0061/*STR0145*/,oFont10p) //"CID Complementar"
				oPrint:Line(lin,200,lin+150,200)
				oPrint:Line(lin,2200,lin+150,2200)
				nCol += 110
			Endif
			// Realizou a pesquisa, imprime linha final
			If Found()
				lin += 50
				oPrint:Line(lin+100,200,lin+100,2200)
			Endif
		Endif
	Endif

	dDtIniTNY := TNY->TNY_DTINIC
	dDtFimTNY := TNY->TNY_DTFIM
	cHrIniTNY := TNY->TNY_HRINIC
	cHrFimTNY := TNY->TNY_HRFIM
	cTempoTNY := MTOH( HTOM(cHrFimTNY) - HTOM(cHrIniTNY) )

	lHFVazio := AllTrim(cHrFimTNY) == ":" .Or. Empty(cHrFimTNY) //Verificar se hora final esta vazia.

	aRetSPJ := {.F., ""}
	dbSelectArea("SRA")
	dbSetOrder(1)
	If dbSeek(xFilial("SRA",TM0->TM0_FILFUN)+TM0->TM0_MAT) .And. !Empty(SRA->RA_TNOTRAB) .And. NGVALHORA(cHrIniTNY,.F.) .And. NGVALHORA(cHrFimTNY,.F.)
		aRetSPJ := MdtTurnoSPJ(	dDtIniTNY,; // Se aRetSPJ[1] = .T. , o funcionário possui turno com horarios cadastrados.
		dDtFimTNY,;
		cHrIniTNY,;
		cHrFimTNY )
		If aRetSPJ[1]
			cTempoTNY := aRetSPJ[2]
		Endif
	Endif

	If (aRetSPJ[1] .And. !Empty(aRetSPJ[2]) .And. AllTrim(aRetSPJ[2]) <> ":") .OR.;
	(NGVALHORA(cHrIniTNY,.F.) .And. NGVALHORA(cHrFimTNY,.F.) .And. ;
	(cHrIniTNY <> "00:00" .And. cHrFimTNY <> "23:59"))
		If !lHFVazio //Se Hora Final nao estiver vazio
			// Adicionado verificação com aRetSPJ[1] pois Candidato não possui Horario padrão
			If aRetSPJ[1] .And. aRetSPJ[4] == "1"
				cTempoTNY	:= aRetSPJ[2]
				nDiasAf	:= aRetSPJ[3]
			Else
				cHrIni 	:= MTOH( HTOM("24:00") - HTOM(cHrIniTNY) )
				cHrFim 	:= MTOH( HTOM("00:00") + HTOM(cHrFimTNY) )
				cTempoTNY	:= MTOH( HTOM(cHrIni) + HTOM(cHrFim) )
				lNoturn := MDT685TUR(TNY->TNY_NUMFIC, dDtIniTNY)[1]
				nDiasAf	:= If( lNoturn , aRetSPJ[3] , dDtFimTNY - dDtIniTNY) //Total de dias
			EndIf
			cHrTot  := cHorasAf := MTOH(MOD(HTOM(cTempoTNY),1440))
			POS := At(":",cTempoTNY)
			nHorasAf := Val(Substr(cHorasAf,1,(POS-1)))
			nMinAf   := Val(Substr(cHorasAf,(POS+1)))

			If nHorasAf == 23 .And. nMinAf == 59

				nHorasAf := 0
				nMinAf   := 0

				nDiasAf ++
				
			EndIf

			If nDiasAf > 0
				cDia := " (" + Alltrim(STR(nDiasAf,5)) + ") " + Extenso(nDiasAf,.T.)
			EndIf
			If nHorasAf <> 0
				If nHorasAf == 1
					cHora := " (" + Alltrim(cHrTot) + ") " + STR0062/*STR0087*/ //"UMA HORA"
				ElseIf nHorasAf == 2
					cHora := " (" + Alltrim(cHrTot) + ") " + STR0063/*STR0088*/ //"DUAS HORAS"
				Else
					cHora := " (" + Alltrim(cHrTot) + ") " + Extenso(nHorasAf,.T.) + STR0064/*STR0089*/ //" HORAS"
				EndIf
			EndIf

			If nMinAf <> 0
				If nHorasAf <> 0
					cHora := cHora
				EndIf
				cMin := Extenso(nMinAf,.T.) + STR0065/*STR0091*/ //" MINUTOS"
			EndIf

			If nDiasAf > 0
				cTexto1 := STR0066/*STR0096*/ + cDia + STR0067/*STR0101*/ + If(nHorasAf > 0, STR0068/*STR0090*/ + cHora, "")//"SE ENCONTRA SOB CUIDADOS MÉDICOS, NECESSITANDO DE LICENÇA POR"###" DIA(S)"###" E"
				cTexto1 += If(nMinAf > 0,STR0068/*STR0090*/ + cMin + ". ", ", ") + STR0069/*STR0102*/ + " " + DTOC(dDtIniTNY) + ", " + cHrIniTNY + "." //"A PARTIR DE"
			Else
				If nMinAf == 0 .And. nHorasAf == 0 .And. nDiasAf == 0
					cTexto1 := STR0070/*STR0159*///"SE ENCONTRA SOB CUIDADOS MÉDICOS, NECESSITANDO DE LICENÇA"
					cTexto1 += " " + STR0071/*STR0097*/ + " " + cHrIniTNY + " " + STR0072/*STR0099*/ + " " //"DAS"###" HORA(S)"
				Else
					cTexto1 := STR0066/*STR0096*/ //"SE ENCONTRA SOB CUIDADOS MÉDICOS, NECESSITANDO DE LICENÇA POR"
					cTexto1 += cHora + cMin + ", " + STR0071/*STR0097*/ + " " + cHrIniTNY + " " + STR0072/*STR0099*/ + " " //"DAS"###" HORA(S)"
				EndIf
				If dDtIniTNY != dDtFimTNY
					cTexto1 += STR0073/*STR0100*/ + " " + DTOC(dDtIniTNY)//"NO DIA"
				Endif
				cTexto1 += " " + STR0074/*STR0098*/ + " " + cHrFimTNY + " " + STR0072/*STR0099*/ //"ATÉ AS"###" HORA(S)"
				cTexto1 += STR0073/*STR0100*/ + " " + DTOC(dDtFimTNY) + "." //"NO DIA"
			EndIf

			nLinhasMemo := MLCOUNT(cTexto1,75)
		Else
			POS := At(":",cHrIniTNY)
			nHorasAf := Val(Substr(cHrIniTNY,1,(POS-1)))
			nMinAf   := Val(Substr(cHrIniTNY,(POS+1)))
			If nHorasAf <> 0
				If nHorasAf == 1
					cHora := STR0062/*STR0087*/ //"UMA HORA"
				ElseIf nHorasAf == 2
					cHora := STR0063/*STR0088*/ //"DUAS HORAS"
				Else
					cHora := Extenso(nHorasAf,.T.) + STR0064/*STR0089*/ //" HORAS"
				EndIf
			EndIf

			If nMinAf <> 0
				If nHorasAf <> 0
					cHora := cHora + STR0068/*STR0090*/ //" E"
				EndIf
				cMin := Extenso(nMinAf,.T.) + STR0065/*STR0091*/ //" MINUTOS"
			EndIf
			cTexto1 := STR0075/*STR0148*/ + " (" + Alltrim(cHrIniTNY) + ") " //"SE ENCONTRA SOB CUIDADOS MÉDICOS, NECESSITANDO DE LICENÇA DESDE À(S)"
			cTexto1 += cHora + cMin + ", "
			cTexto1 += STR0069/*STR0102*/ + " " + DTOC(dDtIniTNY) + " " //"A PARTIR DE"

			nLinhasMemo := MLCOUNT(cTexto1,75)
		Endif

		If nLinhasMemo > 0
			oPrint:Say(lin+120,230,MemoLine(cTexto1,75,1),oFont13)
		Endif
		If nLinhasMemo > 1
			oPrint:Say(lin+250,230,MemoLine(cTexto1,75,2),oFont13)
		Endif
		If nLinhasMemo > 2
			oPrint:Say(lin+380,230,MemoLine(cTexto1,75,3),oFont13)
		Endif
		oPrint:Line(lin,200,lin+490,200)
		oPrint:Line(lin,2200,lin+490,2200)
		oPrint:Line(lin+490,200,lin+490,2200)
	Else
		If Empty(dDtFimTNY)
			nDiasAf := (dDataBase - dDtIniTNY) + 1
		Else
			nDiasAf := (dDtFimTNY - dDtIniTNY) + 1
		EndIf

		cTexto1 := STR0066/*STR0096*/ + " (" + Alltrim(STR(nDiasAf,5)) + ") " //"SE ENCONTRA SOB CUIDADOS MÉDICOS, NECESSITANDO DE LICENÇA POR"
		cTexto1 += Extenso(nDiasAf,.T.) + STR0067/*STR0101*/ + " " + STR0069/*STR0102*/ + " " + DTOC(dDtIniTNY) //" DIA(S)"###"A PARTIR DE"
		nLinhasMemo := MLCOUNT(cTexto1,75)
		If nLinhasMemo > 0
			oPrint:Say(lin+120,230,MemoLine(cTexto1,75,1),oFont13)
		Endif
		If nLinhasMemo > 1
			oPrint:Say(lin+250,230,MemoLine(cTexto1,75,2),oFont13)
		Endif
		If nLinhasMemo > 2
			oPrint:Say(lin+380,230,MemoLine(cTexto1,75,3),oFont13)
		Endif
		oPrint:Line(lin,200,lin+490,200)
		oPrint:Line(lin,2200,lin+490,2200)
		oPrint:Line(lin+490,200,lin+490,2200)
	Endif

	If Empty(dDtFimTNY)
		nDiasAf := (dDataBase - dDtIniTNY) + 1
	Else
		nDiasAf := (dDtFimTNY - dDtIniTNY) + 1
	Endif

	lin += 510
	dbSelectArea("TNY")
	IF TNY->(ColumnPos("TNY_OBS")) > 0
		oPrint:Box(lin,200,lin+700,2200)
		oPrint:Say(lin+5,210,STR0076/*STR0073*/,oFont10p) //"Observações"
		oPrint:Say(lin+110,220,MEMOLINE(TNY->TNY_OBS,70,1),oFont13)
		oPrint:Say(lin+210,220,MEMOLINE(TNY->TNY_OBS,70,2),oFont13)
		oPrint:Say(lin+310,220,MEMOLINE(TNY->TNY_OBS,70,3),oFont13)
		oPrint:Say(lin+410,220,MEMOLINE(TNY->TNY_OBS,70,4),oFont13)
		lin += 720
	ELSEIF TNY->(ColumnPos("TNY_OBSERV")) > 0
		oPrint:Box(lin,200,lin+700,2200)
		oPrint:Say(lin+5,210,STR0076/*STR0073*/,oFont10p) //"Observações"
		oPrint:Say(lin+110,220,MEMOLINE(TNY->TNY_OBSERV,70,1),oFont13)
		oPrint:Say(lin+210,220,MEMOLINE(TNY->TNY_OBSERV,70,2),oFont13)
		oPrint:Say(lin+310,220,MEMOLINE(TNY->TNY_OBSERV,70,3),oFont13)
		oPrint:Say(lin+410,220,MEMOLINE(TNY->TNY_OBSERV,70,4),oFont13)
		lin += 720
	ENDIF
	oPrint:Box(lin,200,lin+180,2200)
	oPrint:Say(lin+5,210,STR0077/*STR0074*/,oFont10p) //"Local e Data"
	oPrint:Say(lin+75,220,AllTrim(&cCidade)+"    |    "+DTOC(dDataBase),oFont13)
	oPrint:Line(lin,1250,lin+180,1250)

	dbSelectArea("TNP")
	dbSetOrder(1)
	If (dbSeek(xFilial("TNP") + TNY->TNY_EMITEN))
		If (NGCADICBASE("TNP_INDFUN","A","TNP",.F.) == .F.) .or.;
		(NGCADICBASE("TNP_INDFUN","A","TNP",.F.) == .T. .And. Empty(TNP->TNP_INDFUN))
			oPrint:Say(lin+5,1260,STR0078/*STR0075*/+" "+cAuxAtestado,oFont10p) //"Médico Responsável pelo Atestado/Autorização"
		Else
			oPrint:Say(lin+5,1260,Tabela("P1",TNP->TNP_INDFUN,.F.)+" "+STR0079/*STR0114*/+" "+cAuxAtestado,oFont10p) //" "Funcao" Responsável pelo Atestado/Autorização"
		EndIf
	EndIf

	dbSelectArea("TNP")
	dbSetOrder(01)
	dbSeek(xFilial("TNP")+TNY->TNY_EMITEN)
	dbSelectArea("TMK")
	dbSetOrder(02)
	If dbSeek(xFilial("TMK")+RTrim(TNP->TNP_NOME))
		oPrint:Say(lin+60,1270,SUBSTR(TMK->TMK_NOMUSU,1,35),oFont13)
		cEntClasse := If(Empty(TMK->TMK_ENTCLA),"CRM",Alltrim(TMK->TMK_ENTCLA))
		oPrint:Say(lin+105,1270,cEntClasse+": "+Alltrim(TMK->TMK_NUMENT),oFont13)
	Else
		oPrint:Say(lin+85,1270,SUBSTR(TNP->TNP_NOME,1,35),oFont13)
	Endif
	//--------------------------
	//Impressão da Assinatura
	//--------------------------
	lFunc := If( nTipo == 1 ,MV_PAR09 == 1 , If(nTipo == 3, MV_PAR12 == 1,MV_PAR09 == 1) )
	oTamFon	:= If( nTipo == 1 .And. MV_PAR01 == 1, oFont10, ; //MDTA685 e Impressora
	If( nTipo == 2 .And. MV_PAR01 == 2, oFont10, oFont13 ) ) //MDTR740 e Impressora


	If lFunc
		lin += 200
		oPrint:Box(lin,200,lin+300,2200)
		oPrint:Say(lin+15,1000,STR0080/*STR0170*/,oFont10p) //"Assinatura do Funcionário"
		oPrint:Line(lin+145,250,lin+145,2150)
		oPrint:Say(lin+160,1100,STR0081/*STR0171*/,oTamFon) //"Assinatura"
		oPrint:Say(lin+200,720,STR0082/*STR0172*/,oTamFon) //"Concordo com a divulgação do CID, conforme"
		oPrint:Say(lin+240,780,STR0083/*STR0173*/,oTamFon) //"parecer do CFM Nº32/90 de 14/09/1990"
	EndIf

	dbSelectArea("TNY")
	oPrint:EndPage() // Finalizar Pagina
Return
