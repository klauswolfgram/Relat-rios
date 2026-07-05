/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "SGAR060.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 1 //Versao do fonte

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ SGAR060  ³ Autor ³ Rafael Diogo Richter  ³ Data ³18/11/2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio da Politica Ambiental                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tabelas   ³TAU - Politica Ambiental                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function SGAR060()
//------------------------------------------------
// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
//------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)
local cNewTitle := ""
PRIVATE cTitleR060 := STR0001
PRIVATE cPerg := "SGR060"
Private cStartPath := AllTrim(GetSrvProfString("Startpath",""))//Local onde se encontra o logo para impressão

If IsInCallStack("SGAA230")
	If ExistBlock("SGAA230A") //Ponto de entrada para alteração de título da rotina Politica Ambiental
		cNewTitle:= ExecBlock("SGAA230A",.F.,.F.)
		If ValType(cNewTitle) == "C" .AND. !Empty(cNewTitle)
			cTitleR060 := cNewTitle 
		EndIf
	Endif 
EndIf

U_R060Imp()

//------------------------------------------------
// Devolve variaveis armazenadas (NGRIGHTCLICK)
//------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R060IMP  ³ Autor ³ Rafael Diogo Richter  ³ Data ³18/11/2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio.                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±± 
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/  

User Function R060IMP()
Private oPrint
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
oFont14	:= TFont():New("Courier New",13,13,,.T.,,,,.F.,.F.)
oFont15	:= TFont():New("Courier New",15,15,,.T.,,,,.F.,.F.)
oFont20	:= TFont():New("Courier New",20,20,,.T.,,,,.F.,.F.)

oPrint	:= TMSPrinter():New(OemToAnsi(cTitleR060))  //"Política Ambiental"
oPrint:Setup()

U_ModSga060(oPrint)
oPrint:Preview()

Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MODSGA060 ³ Autor ³ Rafael Diogo Richter  ³ Data ³18/11/2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Modelo Individual.                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ModSga060(oPrint)
Local i, cMemo, cMemo2, cMemo3, cMemo4
Local nLinha, nLinha2, nLinha3, nLinha4
Local nEsp1, nEsp2, nTamMax
Local dDtVige := CTOD("  /  /  ")
Private l, lObsoleto := .F.

dDtVige := TAU->TAU_DTVIGE

aAreaTAU := TAU->( GetArea() )
//-------------- Define o espaçamento para a impressao das linhas --------------
nEsp1 := 80
nEsp2 := 100

dbSelectArea("TAU")
dbSetOrder(1)
dbGoTop()
While !Eof() .And. xFilial() == TAU->TAU_FILIAL
	If TAU->TAU_DTVIGE > dDtVige
		lObsoleto := .T.
		Exit
	EndIf
	dbSelectArea("TAU")
	dbSkip()
End

RestArea(aAreaTAU)

l := 410
SomaLinha(.T.)
If NGCADICBASE('TAU_MMSYP','A','TAU',.F.)
	cMemo := Msmm(TAU->TAU_MMSYP,,,,3)
	cMemo2:= Msmm(TAU->TAU_MMMISS,,,,3)
	cMemo3:= Msmm(TAU->TAU_MMVISA,,,,3)
	cMemo4:= Msmm(TAU->TAU_MMVALO,,,,3)
Else
	cMemo:= Msmm(TAU->TAU_DESC,,,,4)
	cMemo2:= Msmm(TAU->TAU_MISSAO,,,,4)
	cMemo3:= Msmm(TAU->TAU_VISAO,,,,4)
	cMemo4:= Msmm(TAU->TAU_VALORE,,,,4)
EndIf	

nTamMax:= 70
nLinha:= MlCount(cMemo,nTamMax)
nLinha2:= MlCount(cMemo2,nTamMax)
nLinha3:= MlCount(cMemo3,nTamMax)
nLinha4:= MlCount(cMemo4,nTamMax)
lfirst:= .T.

Somalinha(.F.)
For i:=1 to nLinha
	Somalinha(.F.)
	oPrint:Say(l,220,MEMOLINE(cMemo,nTamMax,i),oFont13)
	oPrint:Line(420, 200, 420, 2200)
	oPrint:Line(420, 180, l+nEsp2, 180)
	oPrint:Line(420, 200, l+nEsp1, 200)
	oPrint:Line(180, 2220, 420, 2220)
	oPrint:Line(420, 2220, l+nEsp2, 2220)
	oPrint:Line(420, 2200, l+nEsp1, 2200)
Next i

If nLinha2 > 0
	Somalinha(.F.)
	Somalinha(.F.)
	Somalinha(.F.)
	oPrint:Line(l-5, 200, l-5, 2200)
	oPrint:Say(l,1040,"MISSÃO",oFont14)
	oPrint:Line(l+45, 200, l+45, 2200)
	Somalinha(.F.)
	For i:=1 to nLinha2
		Somalinha(.F.)
		oPrint:Say(l,220,MEMOLINE(cMemo2,nTamMax,i),oFont13)
		oPrint:Line(420, 200, 420, 2200)
		oPrint:Line(420, 180, l+nEsp2, 180)
		oPrint:Line(420, 200, l+nEsp1, 200)
		oPrint:Line(180, 2220, 420, 2220)
		oPrint:Line(420, 2220, l+nEsp2, 2220)
		oPrint:Line(420, 2200, l+nEsp1, 2200)
	Next i
EndIf

If nLinha3 > 0
	Somalinha(.F.)
	Somalinha(.F.)
	Somalinha(.F.)
	oPrint:Line(l-5, 200, l-5, 2200)
	oPrint:Say(l,1045,"VISÃO",oFont14)
	oPrint:Line(l+45, 200, l+45, 2200)
	Somalinha(.F.)
	For i:=1 to nLinha3
		Somalinha(.F.)
		oPrint:Say(l,220,MEMOLINE(cMemo3,nTamMax,i),oFont13)
		oPrint:Line(420, 200, 420, 2200)
		oPrint:Line(420, 180, l+nEsp2, 180)
		oPrint:Line(420, 200, l+nEsp1, 200)
		oPrint:Line(180, 2220, 420, 2220)
		oPrint:Line(420, 2220, l+nEsp2, 2220)
		oPrint:Line(420, 2200, l+nEsp1, 2200)
	Next i
EndIf

If nLinha4 > 0
	Somalinha(.F.)
	Somalinha(.F.)
	Somalinha(.F.)
	oPrint:Line(l-5, 200, l-5, 2200)
	oPrint:Say(l,1035,"VALORES",oFont14)
	oPrint:Line(l+45, 200, l+45, 2200)
	Somalinha(.F.)
	For i:=1 to nLinha4
		Somalinha(.F.)
		oPrint:Say(l,220,MEMOLINE(cMemo4,nTamMax,i),oFont13)
		oPrint:Line(420, 200, 420, 2200)
		oPrint:Line(420, 180, l+nEsp2, 180)
		oPrint:Line(420, 200, l+nEsp1, 200)
		oPrint:Line(180, 2220, 420, 2220)
		oPrint:Line(420, 2220, l+nEsp2, 2220)
		oPrint:Line(420, 2200, l+nEsp1, 2200)
	Next i
EndIf

If lObsoleto
	oPrint:Say(3030,1800,"Documento Obsoleto",oFont12)
EndIf
oPrint:Line(l+nEsp1, 200, l+nEsp1, 2200)
oPrint:Line(l+nEsp2, 180, l+nEsp2, 2220)
oPrint:EndPage()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Somalinha ³ Autor ³ Rafael Diogo Richter  ³ Data ³18/11/2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao para incrementar linha                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Somalinha(lCabec)
Local nLin := 50
//Varáiveis para controle de empresa e filial
Local cSMCOD := If(FindFunction("FWGrpCompany"),FWGrpCompany(),SM0->M0_CODIGO)
Local cSMFIL := If(FindFunction("FWCodFil"),FWCodFil(),SM0->M0_CODFIL)
L += nLin

If L > 2950
	oPrint:Line(l+30, 200, l+30, 2200)
	oPrint:Line(l+50, 180, l+50, 2220)
	If lObsoleto
		oPrint:Say(3030,1800,"Documento Obsoleto",oFont12)
	EndIf
	oPrint:EndPage()
	lCabec := .T.
	l:= 440
EndIf
//Impressão do cabecalho
If lCabec
	oPrint:StartPage()
	oPrint:Line(180, 180, 180, 2220)
	oPrint:Line(180, 180, 420, 180)
	oPrint:Line(180, 2220, 420, 2220)
	oPrint:Box(200,200,400,550)
	//Procura logo para impressão
	cLogo := cStartPath+"LGRL"+cSMCOD+cSMFIL+".BMP"
	If !File(cLogo)
		cLogo := cStartPath+"LGRL"+cSMCOD+".BMP"	
	EndIf
	//Imprime logo da empresa
	If File(cLogo)
		oPrint:SayBitMap(210,210,cLogo,335,185)
	Endif
	oPrint:Box(200,570,400,1520)
	oPrint:Say(265,660,cTitleR060,oFont20) //"Política Ambiental"
	oPrint:Box(200,1540,400,2200)
	oPrint:Say(205,1570,STR0002,oFont10p) //"Ano: "
	oPrint:Say(260,1180,STR(Year(TAU->TAU_DTVIGE)),oFont20)
EndIf

Return .T.