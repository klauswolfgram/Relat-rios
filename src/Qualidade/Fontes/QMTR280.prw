/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MSOLE.CH"
#INCLUDE "QMTR280.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE Confirma 1
#DEFINE Redigita 2
#DEFINE Abandona 3


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR280  ³ Autor ³ Denis Martins         ³ Data ³ 01.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Certificado de Calibracao - Word                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQmt                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL. 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³	MOTIVO DA ALTERACAO					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Denis Martins ³01/04/03³      ³ Criando certificado Word               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Qmtr280(aImpCer)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aArea
Local nOpc:=1, oDlg,cTitulo:="",cText1:="" 
Local cNomNovo
Local nx := 1
Local cNomeArq

Private lEnd:=.F.
Private lEdit := .t.	// Para editar os textos
Private cCERT
Private aMedicoes := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para montar Get.                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aListBox:={},aMsg:={},aSel:={},aValid:={},aConteudo:={}
Private cPerg1:= "QMR031"
Private lCertif := .F.
Private Inclui	:= .F.
Private Altera	:= .F.
Private cSeql	:= ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Janela Principal                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo:=OemToAnsi(STR0001)		//"Certificado de Calibracao"
cText1:=OemToAnsi(STR0002)			//"Neste relat¢rio ser  impresso o Certificado de Calibracao"
dbSelectArea("QM6")
dbSetOrder(1)
aArea :={Alias(),IndexOrd()}


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Permitir criar arquivos textos por filial³ 
//³Nomenclatura do(s) arquivo(s) textos:    ³
//³R30XYYZZ - Nome do Arquivo               ³
//³R30  - Fonte Origem                      ³
//³X    - Identificador                     ³ 
//³YY   - Empresa Corrente(Sigamat.emp)     ³
//³ZZ   - Filial Corrente(Sigamat.emp)      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

For nx := 1 To 4
	cNomeArq := "QMR030"+Str(nx,1)+".TXT"

	If File(cNomeArq)
		cNomNovo := "R30"+Str(nx,1)+cEmpAnt+cFilAnt+".TXT"
		Rename &cNomeArq To &cNomNovo
		FERASE(cNomeArq)
	Endif
Next nx

Do While .T.

	If __cInternet != "AUTOMATICO"
		DEFINE MSDIALOG oDlg TITLE OemtoAnsi(cTitulo) FROM  165,115 TO 315,525 PIXEL OF oMainWnd
		@ 03, 10 TO 43, 195 LABEL "" OF oDlg  PIXEL
		@ 10, 15 SAY OemToAnsi(cText1) SIZE 160, 8 OF oDlg PIXEL
		DEFINE SBUTTON FROM 50, 112 TYPE 5 ACTION (nOpc:=2,oDlg:End()) ENABLE OF oDlg
		DEFINE SBUTTON FROM 50, 141 TYPE 1 ACTION (nOpc:=1,oDlg:End()) ENABLE OF oDlg
		DEFINE SBUTTON FROM 50, 170 TYPE 2 ACTION (nOpc:=3,oDlg:End()) ENABLE OF oDlg
		ACTIVATE MSDIALOG oDlg
	Endif
	Do Case
		Case nOpc==1
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Relat¢rio de Certificado de Calibracao                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			U_R280IMP(aImpCer)
			Exit
		Case nOpc==2
			Processa({|lEnd| R030Processa(aImpCer) })
		Case nOpc==3
			Exit
	EndCase
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura area                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(aArea[1]);dbSetOrder(aArea[2])
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R280Processa ³ Autor ³Denis Martins      ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento do QMTR280                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R030Processa(aImpCer)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta tela para digitacao de itens.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lEnd:=A030Mont(aImpCer)

Return(Nil)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³   A030Mont   ³ Autor ³Denis Martins      ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta Tela para digitacao dos textos.                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function a030Mont(aImpCer)

Local i:=1,oListBox,nOpcA:=2,oDlgGet

AADD(aListBox," ")
AADD(aListBox,OemToAnsi(STR0003))		//" Texto Final do Certificado "
AADD(aListBox,OemToAnsi(STR0013))		//" Informa‡”es Complementares "
AADD(aListBox,OemToAnsi(STR0004))		//" Impress„o "
AADD(aListBox," ")

For i:= 1 To Len(aListBox)
	aListBox[i] := OemToAnsi(aListBox[i])
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa ListBox com opcoes para o array da configuracao          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlgGet TITLE OemtoAnsi(STR0001) FROM  180,110 TO 450,520 PIXEL OF oMainWnd		//"Certificado de Calibracao"
@ 10, 20 SAY Oemtoansi(STR0006)	SIZE 300, 07 OF oDlgGet PIXEL		//"Itens de Configuracao"
@ 26, 18 TO 112, 188 LABEL "" OF oDlgGet PIXEL

@ 33,22 LISTBOX oListBox VAR cVar FIELDS HEADER "" ON DBLCLICK (R030GetList(oListBox)) SIZE 164,76 PIXEL

oListBox:SetArray(aListBox)
oListBox:bLine := { ||{aListBox[oListBox:nAt]}}

DEFINE SBUTTON FROM 115, 132 TYPE 1 ACTION (nOpca:=1,oDlgGet:End()) ENABLE OF oDlgGet
DEFINE SBUTTON FROM 115, 160 TYPE 2 ACTION (nOpca:=2,oDlgGet:End()) ENABLE OF oDlgGet

ACTIVATE MSDIALOG oDlgGet CENTERED

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R030GetList ³Autor³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Get para edicao de Elemento relacionado ao ListBox    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QMTR280                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R030GetList(oListBox,aImpCer)
Local nAt

nAt:=oListBox:nAt

If nAt == 2 .Or. nAt == 3
	R030TEXT(oListBox,aImpCer)
ElseIf nAt == 4
	Pergunte(cPerg1,.T.)
Endif

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R030Text    ³Autor³Denis Martins          ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Tela para preenchimento do conteudo relacionado com o ³±±
±±³          ³ListBox.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QMTR280                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R030Text(oListBox,aImpCer)

Local cTexto := ""
Local nOpca:=2
Local oFontMet   := TFont():New("Courier New",6,0)
Local oDlgGet2,oTexto
Local oFontDialog:= TFont():New("Arial",6,15,,.T.)
Local cNomeArq 
Local oListB
Local nHdl
Local nAt

cNomeArq := "X"
nHdl:=MSFCREATE(cNomeArq,0)
If nHdl <= -1
	HELP(" ",1,"NODIRCQ")
	Return .T.
Else
	If File(cNomeArq)
		FCLOSE(nHdl)
		FERASE(cNomeArq)
	Endif
Endif

nAt:=oListBox:nAt

cNomeArq := "R30"+Str(nAt,1)+cEmpAnt+cFilAnt+".TXT"

While .T.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Le arquivo                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTexto:=MemoRead(cNomeArq)

	DEFINE MSDIALOG oDlgGet2 FROM	62,100 TO 345,610 TITLE  OemToAnsi(STR0008) PIXEL FONT oFontDialog		//"Itens de Configura‡„o"
	@ 003, 004 TO 027, 250 LABEL "" 	OF oDlgGet2 PIXEL
	@ 040, 004 TO 110, 250				OF oDlgGet2 PIXEL

	@ 013, 010 MSGET oListB VAR aListBox[nAt]	SIZE 235, 010 OF oDlgGet2 PIXEL
	oListB:lReadOnly:= .T.

	@ 050, 010 GET oTexto VAR cTexto MEMO WHEN lEdit SIZE 235, 051 OF oDlgGet2 PIXEL

	oTexto:oFont := oFontMet

	DEFINE SBUTTON FROM 120,190 TYPE 1 ACTION (nOpca := 1,oDlgGet2:End()) ENABLE OF oDlgGet2
	DEFINE SBUTTON FROM 120,220 TYPE 2 ACTION (nOpca := 2,oDlgGet2:End()) ENABLE OF oDlgGet2

	ACTIVATE MSDIALOG oDlgGet2 CENTERED
	Exit
EndDo

If nOpca == Confirma
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua gravacao do arquivo                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MemoWrit( cNomeArq,cTexto )
EndIf

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R280Imp  ³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Certificado de calibra‡„o                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R280Imp(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R280IMP(aImpCer)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1		:=OemToAnsi(STR0007) // "Este programa ira emitir a rela‡ao de"
Local cDesc2		:=OemToAnsi(STR0014) // "Certificados de Calibra‡„o de acordo com os"
Local cDesc3		:=OemToAnsi(STR0009) // "Parƒmetros selecionados."
Local cString		:="QM6"
Local wnrel

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis para impressao de textos gerais             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nTxtFin 		// Imprime Texto Final
Local nInfCom 		// Imprime Informacoes Complementares
Local nInfCIn 		// Imprime Informacoes Complementares do Instrumento
Local nINCs   		// Imprime Nao Conformidades
Local nIOBS   		// Imprime Observacoes
Local nILaudo 		// Imprime Laudo Final do Instrumento

Private titulo		:= OemToAnsi(STR0010) //"CERTIFICADO DE CALIBRACAO "
Private cabec1		:= ""
Private cabec2		:= ""
Private aReturn	:= { OemToAnsi(STR0011), 1,OemToAnsi(STR0012), 1, 2, 1, "",1 } // "Zebrado"###"Administra‡„o"
Private nomeprog	:="QMTR280"
Private nLastKey	:= 0
Private cPerg		:="QMR280"
Private cTamanho := "M"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Privates para efetuar os calculos     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cMtInstr	:= ''
Private cMtRevIns := ''
Private dMtData
Private cMtResp	:= ''
Private cMtTotHr	:= ''
Private cMtRepRepr:= ''

Private nPosEsc	:= 01
Private nPosPad	:= 02
Private nPosEsp	:= 03
Private nPosMed	:= 04
Private nPosObs	:= 05
Private nPosSec	:= 06
Private nPosIns	:= 07
Private nPosNco	:= 08
Private nPosITB	:= 09
Private nPosCar	:= 10
Private nPosExt	:= 11
Private nPosGer	:= 12
Private nPosTp5	:= 13

Private cResIni := ' '   	// Guarda Resultado da medicao inicial (se houver)
Private nCond   := 0     	// Opcao escolhida no menu de Condi‡ao de Recebimento
Private nFreqGrav := 0   	// Frequencia a ser gravada
Private nLaudoFim := 0   	// Guarda laudo final do Instrumento
Private nDec := 0        	// Numero de casas decimais para tipo soma(5)
Private lForaEsp := .f.  	// Verifica se houve alguma medicao fora do especificado
							// para sugerir Avaria.
Private dData
Private nAtual
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("QMR031",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ nTxtFin := mv_par01 // Imprime Texto Final:    1-Sim 2-Nao   ³
//³ nInfCom := mv_par02 // Imprime Inf.Compl.:     1-Sim 2-Nao   ³
//³ nInfCIn := mv_par03 // Imp.Inf.Compl.Instr.:   1-Sim 2-Nao   ³
//³ nIncs   := mv_par04 // Imp.Nao Conformid.  :   1-Sim 2-Nao   ³
//³ nIOBS   := mv_par05 // Imp.Observacoes     :   1-Sim 2-Nao   ³
//³ nILaudo := mv_par06 // Imp.Laudo           :   1-Sim 2-Nao   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nTxtFin := mv_par01
nInfCom := mv_par02
nInfCIn := mv_par03
nIncs   := mv_par04
nIOBS   := mv_par05
nILaudo := mv_par06

Pergunte("QMR280",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                ³
//³ mv_par01 : Instrumento Inicial                      ³
//³ mv_par02 : Instrumento Final                        ³
//³ mv_par03 : Periodo Inicial                          ³
//³ mv_par04 : Periodo Final                            ³
//³ mv_par05 : Departamento Inicial                     ³
//³ mv_par06 : Departamento Final                       ³
//³ mv_par07 : Orgao Calibrador Todos/Interno/Externo   ³
//³ mv_par08 : Orgao Calibrador interno de              ³
//³ mv_par09 : Orgao Calibrador interno ate             ³
//³ mv_par10 : Orgao Calibrador externo de              ³
//³ mv_par11 : Orgao Calibrador externo ate             ³
//³ mv_par12 : Familia de                               ³
//³ mv_par13 : Familia ate                              ³
//³ mv_par14 : Fabricante de                            ³
//³ mv_par15 : Fabricante ate                           ³
//³ mv_par16 : Usu rio de                               ³
//³ mv_par17 : Usu rio ate                              ³
//³ mv_par18 : Imprime Anal.Ult.Pecas Prod.?            ³
//³ mv_par19 : Imprime Padrao p/Calibracao ?(Subjetivo) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aImpCer <> NIL
	cPerg:=""
Endif
	
wnrel:="QMTR280"            //Nome Default do relatorio em Disco
If aImpCer == NIL
	wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,cTamanho)
EndIf
cPerg		:="QMR280" //Atribui valor ao cPerg,qdo o certif. for impresso pela Rotina de Medicao.

If nLastKey = 27
   Return
Endif

If aImpCer == NIL
	SetDefault(aReturn,cString)
Endif

If nLastKey = 27
   Return
Endif

If aImpCer == NIL
	U_MTR280Imp(@lEnd,wnRel,cString,nTxtFin, nInfCom,nInfCIn,nIncs,nIOBS,nILaudo,aImpCer)
Else
	RptStatus({|lEnd| U_MTR280Imp(@lEnd,wnRel,cString,nTxtFin, nInfCom,;
										 nInfCIn,nIncs,nIOBS,nILaudo,aImpCer)},Titulo)
EndiF 
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Mtr280Imp³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chamada do Certificado de Calibracao                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³  U_MTR280IMP(void)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd     -> Parametro do relatorio	                      ³±±
±±³          ³ wnRel    -> Nome default do arquivo em disco               ³±±
±±³          ³ cString  -> Parametro do relatorio                         ³±±
±±³          ³ nTxtFin  -> Imprime textos finais                          ³±±
±±³          ³ nInfCom  -> Imprime informacoes complementares gerais      ³±±
±±³          ³ nInfCIn  -> Imprime informacoes complementares do instr.   ³±±
±±³          ³ nINCs    -> Imprime nao conformidades                      ³±±
±±³          ³ nIOBS    -> Imprime observacao                             ³±±
±±³          ³ nLaudo   -> Imprime Laudo Final do Instrumento             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Mtr280Imp(	lEnd, wnRel, cString, nTxtFin,nInfCom, nInfCIn, nIncs, nIOBS, nILaudo,aImpCer)

ProcessaDoc({||U_Mtr280ImpCer(@lEnd, wnRel, cString, nTxtFin,nInfCom, nInfCIn, nIncs, nIOBS, nILaudo,aImpCer)})

Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Mtr280ImpCer³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Certificado de Calibra‡„o                                  	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³  U_MTR280IMP(void)                                           	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd     -> Parametro do relatorio	                      	³±±
±±³          ³ wnRel    -> Nome default do arquivo em disco               	³±±
±±³          ³ cString  -> Parametro do relatorio                         	³±±
±±³          ³ nTxtFin  -> Imprime textos finais                          	³±±
±±³          ³ nInfCom  -> Imprime informacoes complementares gerais      	³±±
±±³          ³ nInfCIn  -> Imprime informacoes complementares do instr.   	³±±
±±³          ³ nINCs    -> Imprime nao conformidades                      	³±±
±±³          ³ nIOBS    -> Imprime observacao                             	³±±
±±³          ³ nLaudo   -> Imprime Laudo Final do Instrumento             	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto ³ 20/06/00 ³ Alteracoes para calibrar Tipo de Calibracao Re- 	³±±
±±³          ³          ³ logio.                        				  	³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Mtr280ImpCer(	lEnd, wnRel, cString, nTxtFin,nInfCom, nInfCIn, nIncs, nIOBS, nILaudo,aImpCer)

Local cEscala		:= ""
Local cPadraoQMA	:= ""		
Local lImpDados		:= .T.
Local lImpCabec		:= .T.
Local nCntFor		:= 0
Local nCntFor2		:= 0
Local nCntFor3		:= 0
Local nCntForM		:= 0
Local nCntForM2		:= 0
Local nCont			:= 0
Local cStat			:= Space(1)
Local aArray 		:= {}
Local lCab 			:= .f.
Local cPonto		:= ''
Local nRec			:= 0
Local lAchou 		:= .f.
Local cChave 		:= ''
Local nIncert		:= 0
Local nLimMin		:= 0
Local nLimMax		:= 0
Local cText 		:= ''
Local lDuplica		:= .t.
Local nRecQM7		:= 0  // Guardo numero do registro atual
Local nVezes 		:= 0
Local cInsEsc		:= " "
Local lMalha		:= .F.
Local aRelResu		:= {}
Local dDataQM3		:= ctod("  /  /  ")
Local lImpJust		:= .F.
Local cTipTol
Local cTolMaxQMA
Local cTolerQMA
Local lImp			:= .F.
Local cSeqlQM6		:= "00"
Local lImpSub		:= .T.
Local lFrsInsUt 	:= .f.
Local cMVQAPROV 	:= GetMv("MV_QAPROV")
Local cMVQREPRO 	:= GetMv("MV_QREPRO")
Local cMVQCALINC 	:= GetMv("MV_QCALINC")
Local cMVQAPCON 	:= GetMv("MV_QAPCON")
Local cMVQFREQAF 	:= GetMv("MV_QFREQAF")
Private aResult 	:= {}
Private oWord
Private nTeste		:= 0
Private nTeste1		:= 0
Private nSomEsc		:= 0
Private nMed		:= 0
Private nSomE		:= 0
Private nSomPa		:= 0
Private nTxt140O	:= 0
Private clImpJus	:= ""
Private nEsc34		:= 0 
Private nMedi		:= 0
Private nPdSom		:= 0
Private aQPath		:= QDOPATH()
Private cQPathD		:= aQPath[2] //Define onde esta o .dot original
Private cQPathTrm	:= aQPath[3] //Define onde sera gravado a copia do .dot
Private cTxtWord	:= Alltrim(GETMV("MV_QMTDDOT")) //Nome do .Dot
Private nRecQM6		:= 0
Private nItPS		:= 0
Private lFzNov
Private lPadoSec	:= .t.
Private lCabNco		:= .t.
Private nNc			:= 0
Private lFzNco		:= .T.
Private cInfComple	:= ""
Private cArqTxt 	:= ""
Private	cImpLi 		:= ""
Private lPrimeira	:= .T.
Private cLabor		:= ""

li     := 80
m_pag  := 1
cbCont := 0
cbTXT  := ""     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Caso impressão seja seguida da calibracao.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aImpCer <> NIL
    lCertif := .T.
	mv_par01  := aImpCer[1][1]
	mv_par02  := aImpCer[1][1]
	mv_par03  := aImpCer[1][2]
	mv_par04  := aImpCer[1][2]
  	mv_par05  := Space(9)
	mv_par06  := "zzzzzzzzz"				
	mv_par07  := 1	
	mv_par08  := Space(9)	
	mv_par09  := "zzzzzzzzz"					
	mv_par10  := Space(16)				 
	mv_par11  := "zzzzzzzzzzzzzzzz"
	mv_par12  := Space(16)				
	mv_par13  := "zzzzzzzzzzzzzzzz"
	mv_par14  := Space(16)				
	mv_par15  := "zzzzzzzzzzzzzzzz"
	mv_par16  := Space(6)
	mv_par17  := "zzzzzz" 
	mv_par18  := aImpCer[1][7]	
	mv_par19  := aImpCer[1][8]	
Endif

dbSelectArea( "QM6" )
dbSetOrder(1)
dbSeek( xFilial() + mv_par01 , .T. )

//Copia arquivo do server para o client, evitando mexer no dot principal que esta no server.

Do While QM6->(!Eof()) .and. QM6_FILIAL == xFilial("QM6") .and. QM6->QM6_INSTR <= mv_par02
	CpyS2T(cQPathD+cTxtWord,cQPathTrm,.T.)
	oWord:=OLE_CreateLink( "TMsOleWord97" )

	OLE_OpenFile( oWord,cQPathTrm+cTxtWord, .f.)
	//Executa invisivel  
	OLE_SetProperty( oWord, oleWdVisible,.F. )
	OLE_SetProperty( oWord, oleWdPrintBack, .f. )

	RegProcDoc( 2 )
	IncProcDoc("Gerando Certificado...")  
	lPrimeira := .T.
	//Quando eh chamado direto da rotina de calibracoes
	If aImpCer <> Nil
		If ( QM6->QM6_CSEQ < aImpCer[1][9] .or. QM6->QM6_CSEQ > aImpCer[1][9] )
			dbSkip()
			Loop
		EndIf
		cSeql := aImpCer[1][9]
	Else
		cSeql := QM6->QM6_CSEQ
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se n„o est  entre os periodos informados, n„o imprime.          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( QM6->QM6_DATA < mv_par03 .or. QM6->QM6_DATA > mv_par04 )
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura o instrumento relacionado com o cabe‡alho               ³
	//³ e posiciona os arquivos relacionados.                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "QM2" )
	dbSetOrder(1)
	dbSeek( xFilial() + QM6->QM6_INSTR + Inverte(QM6->QM6_REVINS) )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura o DEPARTAMENTO no QAD.                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "QAD" )
	dbSetOrder(1)
	dbSeek( xFilial() + QM2->QM2_DEPTO )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura o RESPONSAVEL NO QAA.                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QAA")
	dbSetOrder(1)
	dbSeek( QM2->QM2_FILRES + QM2->QM2_RESP )

	dbSelectArea( "QM6" )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se n„o est  entre os departamentos informados, n„o imprime.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( QM2->QM2_DEPTO < mv_par05 .or. QM2->QM2_DEPTO > mv_par06 )
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno e externo                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 1
		If ! Calibrador(0,mv_par08,mv_par09,mv_par10,mv_par11)
			dbSkip()
			Loop
		EndIf
	ElseIf mv_par07 == 2
		If ! Calibrador(1,mv_par08,mv_par09)
			dbSkip()
			Loop
		EndIf
	ElseIf mv_par07 == 3
		If ! Calibrador(2,,,mv_par10,mv_par11)
			dbSkip()
			Loop
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se n„o ‚ a familia selecionada n„o Imprime.                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( QM2->QM2_TIPO < mv_par12 .or. QM2->QM2_TIPO > mv_par13 )
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ N„o ‚ o fabricante selecionado.                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( QM2->QM2_FABR < mv_par14 .or. QM2->QM2_FABR > mv_par15 )
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ N„o ‚ o usu rio selecionado.                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( QM2->QM2_RESP < mv_par16 .or. QM2->QM2_RESP > mv_par17 )
		dbSkip()
		Loop
	EndIf

	DbSelectArea("QM7")
 	DbSetOrder(1)
 	If !QM7->(DbSeek(xFilial()+QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA)))
		dbSelectArea("QM6")
		dbSkip() 		
		Loop
 	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciono na familia e revisao referentes a data do QM6.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "QM1" )
	dbSetOrder(1)
	dbSeek( xFilial() + QM2->QM2_TIPO )
	While QM1->(!Eof()) .And. QM1->QM1_TIPO == QM2->QM2_TIPO
		If xFilial() != QM1->QM1_FILIAL
			Exit
		EndIf
		If QM1->QM1_DATREV <= QM6->QM6_DATA
			Exit
		EndIf
		// Para garantir a impressao do ultimo registro, de qualquer forma
		// Necessario para os casos de importacao, onde a data da revisao ‚ a
		// data da importacao. Desta forma, nao funcionaria o "IF" anterior.
		nRec := recno()
		dbSkip()
	EndDo
	If nRec >  0
		DbGoto(nRec)
	EndIf

	m_pag  := 1
	
	Cabec1 := U_QMR280ICabec1()
	
	lImpDados	:= .T.

	Ole_ExecuteMacro(oWord,"MtDesSave")

	If li > 55
			QM7->(DbSetOrder(1))
			QM7->(DbSeek(xFilial()+QM6->QM6_INSTR+QM6->QM6_REVINS+dtos(QM6->QM6_DATA)+cSeql))
			cCert := QM7->QM7_NRCERT
			OLE_SetDocumentVar( oWord, "Adv_NumCert"	,Alltrim(cCert)) 
			If !Empty(QM2->QM2_CLIE)
				dbSelectArea("SA1")
				dbSetOrder(01)
				If dbSeek(xFilial("SA1")+QM2->QM2_CLIE+QM2->QM2_LOJA)
					Ole_SetDocumentVar(oWord,"Adv_Clie",Alltrim(SA1->A1_NOME) + " - " + Alltrim(SA1->A1_NREDUZ))
					Ole_SetDocumentVar(oWord,"Adv_EndClie",Alltrim(SA1->A1_END) + " - " + Alltrim(A1_MUN) + " - " + Alltrim(A1_EST))					
					Ole_SetDocumentVar(oWord,"Adv_CepClie",Alltrim(SA1->A1_CEP) + " - " + Alltrim(A1_BAIRRO))					
					Ole_SetDocumentVar(oWord,"Adv_TeleClie",SA1->A1_TEL)					
					Ole_Executemacro(oWord,"MtCabClie")
				Endif
			Endif	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se existem tolerancias de processo e redutores para    ³
			//³ serem impressos (se escala for confirma‡ao metrologica)         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 			aArray := {}
 			lMalha := .F.
 			cInsEsc := " "
			QMR->(DbSetOrder(1))
			If QMR->(DbSeek(xFilial("QMR")+QM6->QM6_INSTR+QM6->QM6_REVINS))
				cChave := xFilial("QMR")+QMR->QMR_INSTR+QMR->QMR_REVINS
				Do while cChave ==;
					xFilial("QMR")+QMR->QMR_INSTR+QMR->QMR_REVINS
					If QMR->QMR_CAOBRI = "S"
						cInsEsc := U_R280InsEsc(QMR->QMR_INSTR,QMR->QMR_ESCALA)
						If !Empty(cInsEsc)
							lMalha := .T.	
							// E instrumento Malha, entao imprime o codigo do instrumento filho na junto com 
							// as escalas, tolerancia e redutor
						EndIf
						aadd(aArray,{QMR->QMR_ESCALA,QMR->QMR_TOLPRO,QMR->QMR_REDUT,QMR->QMR_INPERM,QMR->QMR_PREC,cInsEsc})
					EndIf
					QMR->(DbSkip())
				EndDo
			EndIf

			If !lMalha	// Nao eh instrumento Malha
				// 11 - Posicao Inicial						     			 Posicao Final - 97
	            //          2         3         4         5         6         7         8         9        10        11        12
				// 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
				// =======================================================================================================
				//	|         Escala         |   Tolerancia do Processo   |  Redutor  | Inc.Permitida | 0123456789012     |
				//	-------------------------------------------------------------------------------------------------------
				//	|    1234567890123456    |         1234567890         |     99    |	9999999999	 | 01234567890123456 |
				//	-------------------------------------------------------------------------------------------------------
	
				lCab := .t.
				If !empty(aArray)
					lCab := .f.					
					nCount := 1
					lFirst := .T.
					OLE_ExecuteMacro( oWord,"MtDifMalha") 	                                               					

					For nCntFor := 1 to Len(aArray)
						OLE_SetDocumentVar( oWord, "Adv_CodEsc"+Alltrim(Str(nCount))	,aArray[nCntFor][1]) 	
						OLE_SetDocumentVar( oWord, "Adv_cToler"+Alltrim(Str(nCount))	,aArray[nCntFor][2])  
						OLE_SetDocumentVar( oWord, "Adv_cRedut"+Alltrim(Str(nCount))	,aArray[nCntFor][3])
						OLE_SetDocumentVar( oWord, "Adv_cIncP"+Alltrim(Str(nCount))		,aArray[nCntFor][4]) 	 	  
						OLE_SetDocumentVar( oWord, "Adv_cPrec"+Alltrim(Str(nCount))		,aArray[nCntFor][5]) 	
						nCount++								
						lFirst := .F.
					Next nCntFor

					nCount := 1
					lFirst := .T.

					For nCntFor := 1 to Len(aArray)
						OLE_SetDocumentVar( oWord, "Adv_CodEsc"+Alltrim(Str(nCount))	,aArray[nCntFor][1]) 
						OLE_ExecuteMacro( oWord,"MtEscNor") 
						OLE_SetDocumentVar( oWord, "Adv_CodEsc"+Alltrim(Str(nCount))	,aArray[nCntFor][1]) 	
						OLE_SetDocumentVar( oWord, "Adv_cToler"+Alltrim(Str(nCount))	,aArray[nCntFor][2])  
						OLE_SetDocumentVar( oWord, "Adv_cRedut"+Alltrim(Str(nCount))	,aArray[nCntFor][3])
						OLE_SetDocumentVar( oWord, "Adv_cIncP"+Alltrim(Str(nCount))		,aArray[nCntFor][4]) 	 	  
						OLE_SetDocumentVar( oWord, "Adv_cPrec"+Alltrim(Str(nCount))		,aArray[nCntFor][5]) 	
						nCount++								
						lFirst := .F.
					Next nCntFor
				EndIf
	        Else    
				// 01 - Posicao Inicial						     			 Posicao Final - 129
	            //          1         2         3         4         5         6         7         8         9        10        11        12         13
				// 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
				// =================================================================================================================================
				// |  Escala                |      Instrumento       |   Tolerancia do Processo   |  Redutor  |  Inc.Permitida | Precisao          |
				// ---------------------------------------------------------------------------------------------------------------------------------
				// |  1234567890123456      |    1234567890123456    |         1234567890         |     99    |   9999999999   | 01234567890123456 |
				// ---------------------------------------------------------------------------------------------------------------------------------
	
				lCab := .t.

				If !empty(aArray)
					lCab := .f.					
					nCount := 1
					lFirst := .T.
					OLE_ExecuteMacro( oWord, "MtCbcMalha") 	                                                					

					For nCntFor := 1 to Len(aArray)
						OLE_SetDocumentVar( oWord, "Adv_MEsc"+Alltrim(Str(nCount))		,aArray[nCntFor][1]) 	
						OLE_SetDocumentVar( oWord, "Adv_MInstr"+Alltrim(Str(nCount))	,aArray[nCntFor][6])  
						OLE_SetDocumentVar( oWord, "Adv_Tole"+Alltrim(Str(nCount))		,aArray[nCntFor][2])
						OLE_SetDocumentVar( oWord, "Adv_Reduto"+Alltrim(Str(nCount))	,aArray[nCntFor][3]) 	 	  
						OLE_SetDocumentVar( oWord, "Adv_MIperm"+Alltrim(Str(nCount))	,aArray[nCntFor][4]) 	
						OLE_SetDocumentVar( oWord, "Adv_MPreci"+Alltrim(Str(nCount))	,aArray[nCntFor][5]) 	
						nCount++								
						lFirst := .F.
					Next nCntFor

					nCount := 1
					lFirst := .T.


					For nCntFor := 1 to Len(aArray)
						OLE_ExecuteMacro( oWord, "MtCbcItMalha") 	                                                
						OLE_SetDocumentVar( oWord, "Adv_MEsc"+Alltrim(Str(nCount))		,aArray[nCntFor][1]) 	
						OLE_SetDocumentVar( oWord, "Adv_MInstr"+Alltrim(Str(nCount))	,aArray[nCntFor][6])  
						OLE_SetDocumentVar( oWord, "Adv_Tole"+Alltrim(Str(nCount))		,aArray[nCntFor][2])
						OLE_SetDocumentVar( oWord, "Adv_Reduto"+Alltrim(Str(nCount))	,aArray[nCntFor][3]) 	 	  
						OLE_SetDocumentVar( oWord, "Adv_MIperm"+Alltrim(Str(nCount))	,aArray[nCntFor][4]) 	
						OLE_SetDocumentVar( oWord, "Adv_MPreci"+Alltrim(Str(nCount))	,aArray[nCntFor][5]) 	
						nCount++								
						lFirst := .F.
					Next nCntFor
				EndIf
			EndIf
		EndIf
	
 		DbSelectArea("QM7")
		QM7->(DbSetOrder(1))
		QM7->(DbSeek(xFilial()+QM6->QM6_INSTR+QM6->QM6_REVINS+dtos(QM6->QM6_DATA)+cSeql))    

		Do while !QM7->(Eof()) .and. QM6->QM6_INSTR+QM6->QM6_REVINS+dtos(QM6->QM6_DATA)+cSeql ==;
			QM7->QM7_INSTR+QM7->QM7_REVINS+DtoS(QM7->QM7_DATA)+QM7->QM7_CSEQ
			Ole_ExecuteMacro(oWord,"MontEscs")// Cria as escalas
			If lImpCabec  
				nTeste++
				OLE_SetDocumentVar( oWord, "Adv_Escala"+Alltrim(Str(nTeste))	,Alltrim(QM7->QM7_ESCALA)+" - "+Alltrim(QM7->QM7_REVINS)) 	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciono no Procedimento de Calibracao do QA5.                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				QA5->(dbSetOrder(1))
				QA5->(dbSeek(xFilial("QA5") + "C" + QM1->QM1_PROCAL))

				OLE_SetDocumentVar( oWord, "Adv_ProcCab"+Alltrim(Str(nTeste))		,If(QA5->(Found()),alltrim(QA5->QA5_NORMA) + "-" + QA5->QA5_REVPRO+" - " + QA5->QA5_DESCRI,QM1->QM1_PROCAL))  
                
				//Localizar Laboratorio
				QM9->(DbSetOrder(1))
				QM9->(DbSeek(xFilial("QM9")+QM7->QM7_ESCALA+Inverte(QM7->QM7_REVESC)))
				If QM9->QM9_ORGAFE=="E"
					dbSelectArea("QMO")
					dbSetOrder(1)
					If dbSeek(xFilial("QMO")+QM7->QM7_LABOR)
				    	cLabor:= QM7->QM7_LABOR+" - "+QMO->QMO_EMPR
					Endif					
				Else
					cLabor := QM9->QM9_DEPTO	
				Endif
				
				OLE_SetDocumentVar( oWord, "Adv_TpCal"+Alltrim(Str(nTeste))	,cLabor)
			Endif
 
			QM9->(DbSetOrder(1))
			QM9->(DbSeek(xFilial("QM9")+QM7->QM7_ESCALA+Inverte(QM7->QM7_REVESC)))

	 		cChave := QM6->QM6_INSTR+QM6->QM6_REVINS+dtos(QM6->QM6_DATA)+QM6->QM6_CSEQ+;
						 QM7->QM7_ESCALA+QM7->QM7_REVESC

			lCab := .t.

			If QM9->QM9_TIPAFE $ "1,2,3,9"
				// ALTERADO DE QM6 PARA QM7 NA LINHA ABAIXO PARA INSTRUMENTO E REVISAO
				Ole_ExecuteMacro(oWord,"MtPadroes")
				Do while cChave == QM7->QM7_INSTR+QM7->QM7_REVINS+dtos(QM7->QM7_DATA)+QM7->QM7_CSEQ+;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC

					lImpSub := .T.
					
					QM3->(DbSetOrder(1))
					QM3->(DbSeek(xFilial("QM3")+QM7->QM7_PONTO+Inverte(QM7->QM7_REVPAD)))
					OLE_ExeCuteMacro( oWord, "MontPd1239") 	  									
					If lImpSub  
							nTeste1++
							OLE_SetDocumentVar( oWord, "Adv_PdRev"+Alltrim(Str(nTeste1))	,QM3->QM3_PADRAO+" - "+QM3->QM3_REVPAD) 						
							OLE_SetDocumentVar( oWord, "Adv_VNom"+Alltrim(Str(nTeste1))		,QM3->QM3_ESPEC) 						

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Pego tolerancia informada no QMC. A do padrao serviu como suges-³
							//³ tao no momento da amarracao do padrao com a escala.             ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							QMC->(DbSetOrder(1))
							If QMC->(DbSeek(xFilial("QMC")+QM7->QM7_ESCALA+Inverte(QM7->QM7_REVESC)+QM7->QM7_PONTO))
								OLE_SetDocumentVar( oWord, "Adv_TMin"+Alltrim(Str(nTeste1))		,QMC->QMC_TOLMIN) 						
								OLE_SetDocumentVar( oWord, "Adv_TMax"+Alltrim(Str(nTeste1))		,QMC->QMC_TOLER) 						
								cTipTol := QMC->QMC_TIPTOL
							Else
								OLE_SetDocumentVar( oWord, "Adv_TMin"+Alltrim(Str(nTeste1))		,QMC->QMC_TOLMIN) 						
								OLE_SetDocumentVar( oWord, "Adv_TMax"+Alltrim(Str(nTeste1))		,QMC->QMC_TOLER) 						
								cTipTol := QM3->QM3_TIPTOL						
							EndIf
							If cTipTol <> "1"
								OLE_SetDocumentVar( oWord, "Adv_TTol"+Alltrim(Str(nTeste1))		,"%") 													
							Else	
								OLE_SetDocumentVar( oWord, "Adv_TTol"+Alltrim(Str(nTeste1))		,"Numerico") 																			
							Endif				

							SAH->(DbSetOrder(1))
							OLE_SetDocumentVar( oWord, "Adv_UMed"+Alltrim(Str(nTeste1))		,If(SAH->(DbSeek(xFilial("SAH")+QM3->QM3_UNIMED)),SAH->AH_UMRES,space(9))) 						
							OLE_SetDocumentVar( oWord, "Adv_NCert"+Alltrim(Str(nTeste1))		,QM3->QM3_CERTIF) 						
							OLE_SetDocumentVar( oWord, "Adv_Putil"+Alltrim(Str(nTeste1))		,QM3->QM3_PADUT) 						
							OLE_SetDocumentVar( oWord, "Adv_VaCal"+Alltrim(Str(nTeste1))		,DtoC(QM3->QM3_VALDAF)) 						
							OLE_SetDocumentVar( oWord, "Adv_IncPa"+Alltrim(Str(nTeste1))		,QM3->QM3_INCERT) 						
					Endif	
					dbSelectArea( "QM7" )
					dbSkip()
				EndDo
				Ole_ExecuteMacro(oWord,"SomaPadroes")
				cChave := QM6->QM6_INSTR+QM6->QM6_REVINS+dtos(QM6->QM6_DATA)+QM6->QM6_CSEQ+;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC

			ElseIf QM9->QM9_TIPAFE $ "4,8"

/*
 	       Ponto          Nominal        LIE          LSE       Unid.Med            Escala            Tipo Calc.Tolerancia
 	  ================   ==========   ==========   ==========   =========   =======================   =====================
 	  1234567890123456   1234567890   1234567890   1234567890   12345678    1234567890 a 1234567890         1234567890

*/
				cChave := QM6->QM6_INSTR+QM6->QM6_REVINS+dtos(QM6->QM6_DATA)+QM6->QM6_CSEQ+;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC

				lCab := .T.

				QMG->(DbSetOrder(1))

				// ALTERADO DE QM6 PARA QM7 NA LINHA ABAIXO PARA INSTRUMENTO E REVISAO
				Do while cChave == QM7->QM7_INSTR+QM7->QM7_REVINS+dtos(QM7->QM7_DATA)+QM7->QM7_CSEQ+;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC

					If QMG->(DbSeek(xFilial("QMG")+QM6->QM6_INSTR+QM6->QM6_REVINS+QM7->QM7_PONTO))
						If lCab
					//          1         2         3         4         5         6         7         8         9         0          1        2         3
					//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
					//    PONTO               NOMINAL          LIE              LSE               T.TOL             UNID.MED.            ESCALA  
					//    xxxxxxxxxxxxxxxxxxx yyyyyyyyyyyy     YYYYYYYYYYY      YYYYYYYYYYY         %               YYYYYYYYY   XXXXXXXXXXX a XXXXXXXXXXX
							Ole_ExecuteMacro(oWord,"MtCabCaliba")

							lCab := .F.
						EndIf
					//           10        20        30        40        50        60        70        80        90        100       110       120       130
					//01234567789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
					//    xxxxxxxxxxxxxxxxxxx yyyyyyyyyyyy     YYYYYYYYYYY         YYYYYYYYYYY         XXXXXXXXXXX YYYYYYYYY   XXXXXXXXXXX a XXXXXXXXXXX
						Ole_ExecuteMacro(oWord,"MtItemCalib")
						nTeste1++
                        Ole_SetDocumentVar(oWord,"Adv_PtCalib"+Alltrim(Str(nTeste1)),QM7->QM7_PONTO)
                        Ole_SetDocumentVar(oWord,"Adv_Nomi"+Alltrim(Str(nTeste1)),QM7->QM7_ESPEC)
						Ole_SetDocumentVar(oWord,"Adv_LIE"+Alltrim(Str(nTeste1)),QMG->QMG_LIE)
						Ole_SetDocumentVar(oWord,"Adv_LSE"+Alltrim(Str(nTeste1)),QMG->QMG_LSE)
						If QMG->QMG_TIPTOL <> "1"
							Ole_SetDocumentVar(oWord,"Adv_TTol"+Alltrim(Str(nTeste1)),"%")
						Endif

                        Ole_SetDocumentVar(oWord,"Adv_UMedid"+Alltrim(Str(nTeste1)),If(SAH->(DbSeek(xFilial("SAH")+QMG->QMG_UNIMED)),SAH->AH_UMRES,space(9)))
						Ole_SetDocumentVar(oWord,"Adv_EscIni"+Alltrim(Str(nTeste1)),If(!Empty(QMG->QMG_ESCALI),QMG->QMG_ESCALI,Space(1)))
						Ole_SetDocumentVar(oWord,"Adv_EscFim"+Alltrim(Str(nTeste1)),If(!Empty(QMG->QMG_ESCALF),QMG->QMG_ESCALF,Space(1)))
					EndIf
					DbSelectArea("QM7")
					QM7->(DbSkip())
				EndDo
				cChave := QM6->QM6_INSTR+QM6->QM6_REVINS+dtos(QM6->QM6_DATA)+QM6->QM6_CSEQ+;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
				Ole_ExecuteMacro(oWord,"SomaPadroes")
 			ElseIf QM9->QM9_TIPAFE == "5"
/*
        Faixa         Especificado    Tolerancia  Unid.Med   Incerteza    Dt.Calib   Tipo Toler.
   ================   =============   ==========  ========   ==========   ========== ===========
   1234567890123456      1234567890   1234567890  12345678   1234567890   99/99/99   1234567890

*/

				cChave := QM6->QM6_INSTR+QM6->QM6_REVINS+dtos(QM6->QM6_DATA)+QM6->QM6_CSEQ+;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC

				QMT->(DbSetOrder(1))

				// ALTERADO DE QM6 PARA QM7 NA LINHA ABAIXO PARA INSTRUMENTO E REVISAO
				Do while cChave == QM7->QM7_INSTR+QM7->QM7_REVINS+dtos(QM7->QM7_DATA)+QM7->QM7_CSEQ+;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
                    QMA->(DbSetOrder(1))
					If QMA->(DbSeek(xFilial("QMA")+QM7->QM7_ESCALA+QM7->QM7_REVESC+;
															 QM7->QM7_PONTO))
					//          1         2         3         4         5         6         7        8          9         0         1         2         3
					//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
					//    FAIXA              ESPECIFICADO       TOLER.MIN.       TOLER.MAX.      TP.TOLER.       UNID.MED      INCERTEZA      DT.CALIB.
						If lCab
							Ole_ExecuteMacro(oWord,"MtPadSoma")
							lCab := .F.
						EndIf

						nIncert := 0
                                                     
						dData := ctod("31/12/2050","DDMMYY")
						QM3->(DbSetOrder(1))
                        Do while QMA->QMA_FILIAL+QMA->QMA_ESCALA+QMA->QMA_REVESC+QMA->QMA_FAIXA ==;
									QM7->QM7_FILIAL+QM7->QM7_ESCALA+QM7->QM7_REVESC+QM7->QM7_PONTO

							QM3->(DbSeek(xFilial("QM3")+QMA->QMA_PADRAO))    
							cPadraoQMA := QMA->QMA_PADRAO
							cTolerQMA  := QMA->QMA_TOLMIN	
							cTolMaxQMA := QMA->QMA_TOLER	
							cTipTol	   := QMA->QMA_TIPTOL	
							
							Do While QM3->(!Eof()) 
								If QM3->QM3_FILIAL+QM3->QM3_PADRAO == xFilial("QMA")+cPadraoQMA
									If QM7->QM7_DATA >= QM3->QM3_DATREV
										If dDataQM3 <= QM3->QM3_DATREV
											nRec := QM3->(RecNo())
											dDataQM3 := QM3->QM3_DATREV
											lImp := .T.
										Endif	
									Else
										lImp := .F.
									Endif	 
								Endif
								dbSelectArea("QM3")	
								QM3->(dbSkip())
							Enddo	      
							
							QM3->(dbGoTo(nRec))         
							
							dDataQM3 := ctod("  /  /  ")
							nIncert += SuperVal(QM3->QM3_INCERT)
							If !Empty(QM3->QM3_VALDAF)
								If(QM3->QM3_VALDAF < dData,dData := QM3->QM3_VALDAF,Nil)
							Else
								dData := ctod("  /  /  ")
							Endif	
							QMA->(DbSkip())
						EndDo
						If lImp
    						nTeste1++
							Ole_SetDocumentVar(oWord,"Adv_FxSom"+Alltrim(Str(nTeste1)),QM7->QM7_PONTO)	
							Ole_SetDocumentVar(oWord,"Adv_Especi"+Alltrim(Str(nTeste1)),QM7->QM7_ESPEC)	
							Ole_SetDocumentVar(oWord,"Adv_TolMi"+Alltrim(Str(nTeste1)),cTolMaxQMA)	
							Ole_SetDocumentVar(oWord,"Adv_TolMa"+Alltrim(Str(nTeste1)),cTolerQMA)															

							If cTipTol <> "1"
								Ole_SetDocumentVar(oWord,"Adv_TpTol"+Alltrim(Str(nTeste1)),"%")																						
							Else
								Ole_SetDocumentVar(oWord,"Adv_TpTol"+Alltrim(Str(nTeste1)),Space(1))																						
							Endif
							Ole_SetDocumentVar(oWord,"Adv_UM"+Alltrim(Str(nTeste1)),If(SAH->(DbSeek(xFilial("SAH")+QM3->QM3_UNIMED)),SAH->AH_UMRES,space(9)))
							Ole_SetDocumentVar(oWord,"Adv_Incert"+Alltrim(Str(nTeste1)),Alltrim(Str(nIncert)))																						
							Ole_SetDocumentVar(oWord,"Adv_DtCali"+Alltrim(Str(nTeste1)),dtoc(dData))																						
							Ole_ExecuteMacro(oWord,"MtItemSoma")
						Endif	
					EndIf
					DbSelectArea("QM7")
					QM7->(DbSkip())
				EndDo
				cChave := QM6->QM6_INSTR+QM6->QM6_REVINS+dtos(QM6->QM6_DATA)+QM6->QM6_CSEQ+;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
				Ole_ExecuteMacro(oWord,"SomaPadroes")							 
			Else
				DbSelectArea("QM7")
				QM7->(DbSkip())
			EndIf
			lImpCabec := .T.
		EndDo
 	  
		QAA->(DbSetOrder(1))
		QAA->(DbSeek(QM6->QM6_FILRES + QM6->QM6_RESP))

		OLE_SetDocumentVar( oWord, "Adv_DtMed",DtoC(QM6->QM6_DATA)) 	
		OLE_SetDocumentVar( oWord, "Adv_TotH" ,QM6->QM6_TOTHOR)  
		OLE_SetDocumentVar( oWord, "Adv_Metrol",QM6->QM6_RESP+" - "+SubStr(QAA->QAA_NOME,1,15))

		If !Empty(QM6->QM6_STATUS)
			dbSelectArea("QMP")
			dbSetOrder(1)
			QMP->(DbSeek(xFilial("QMP")+QM6->QM6_STATUS))
			OLE_SetDocumentVar( oWord, "Adv_StMed",QMP->QMP_DESCR) 		
		Endif	

		Ole_ExecuteMacro(oWord,"MtDadMed")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime as medicoes                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		/*
	   ============================================================================================================================
	   |	Escala: XXXXXXXXXXXXXXXX-99                              Valores Inicial Subida                 								|
	   |  Valor Mínimo: 9999999999    Valor Maximo: 9999999999                                    Unidade de Medida: XXXXXXXXX    |
	   ============================================================================================================================
	   |					|			  	      |	 Media	 |  Desvio  |  Desvio  |Incerteza |Incerteza |   Erro   |             |
	   |Padrao              | Valores Encontrados | Leituras |  Medio   |  Padrao  |Medicao   |  Total   |   Total  |  Status     |
	   ----------------------------------------------------------------------------------------------------------------------------
	   |12345678901234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890123|
	   |1234567890 UUUUMMMM |          |          |          |          |          |          |          |          |             |
	   |        Observacao : xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx					      |
	   |              		 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                          |
	   ----------------------------------------------------------------------------------------------------------------------------

		*/

		lCab := .t.
 		DbSelectArea("QM7")
 		DbSetOrder(1)
 		QM7->(DbSeek(xFilial()+QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA)+cSeql))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta aMedicoes                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 		aResult := U_MTR280Carg(@aRelResu,aImpCer)
 	    cEscala := aMedicoes[1,nPosEsc]

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o numero de colunas 1-simples, 2-completo, 4-pressao   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotCol := U_R280NumCol(1)

		nCntFor := 1
		lPrimeira := .T.
		lPassou	  := .F.
		While nCntFor <= Len(aMedicoes)

			lCab := .T.
			nAuxCntFor := nCntFor		// Guarda o indice da primeira escala

			For nCntForM := 1 to nTotCol
			    If nCntForM <= nTotCol
  				nCntFor := nAuxCntFor
				lCab := .T.

				While nCntFor <= Len(aMedicoes) .and. ;
					  cEscala == aMedicoes[nCntFor,nPosEsc]			
					  
					cText := Space(1)

					If aMedicoes[nCntFor,nPosGer,1,2] $ "2,5,8,3,9" .and. aMedicoes[nCntFor,nPosGer,1,6] $ "1|2"
    	
	 					If nTotCol == 4
							If nCntForM == 1 
								cText := If(aMedicoes[nCntFor,nPosGer,1,2] = "3",Upper(STR0022),If(aMedicoes[nCntFor,nPosGer,1,2] = "9",Upper(STR0043)," "))	//"Inicial Subida"	//"Inicial Crescente"
							ElseIf nCntForM == 2
								cText := If(aMedicoes[nCntFor,nPosGer,1,2] = "3",Upper(STR0024),If(aMedicoes[nCntFor,nPosGer,1,2] = "9",Upper(STR0044)," "))  //"Final Subida"     //"Final Crescente"
							ElseIf nCntForM == 3
								cText := If(aMedicoes[nCntFor,nPosGer,1,2] = "3",Upper(STR0023),If(aMedicoes[nCntFor,nPosGer,1,2] = "9",Upper(STR0045)," "))	//"Inicial Descida"	 //"Inicial Descrescente"
							Else
								cText := If(aMedicoes[nCntFor,nPosGer,1,2] = "3",Upper(STR0025),If(aMedicoes[nCntFor,nPosGer,1,2] = "9",Upper(STR0046)," "))   //"Final Descida"    //"Final Descrescente"
							EndIf
						ElseIf nTotCol > 1 .and. aMedicoes[nCntFor,nPosGer,1,3] <> "A"
							If nCntForM == 1
								cText := Upper(STR0026)   // "Iniciais"
							Else
								cText := Upper(STR0027)   // "Finais"
							EndIf
						ElseIf aMedicoes[nCntFor,nPosGer,1,3] == "A"	
							cText := Upper(STR0027)   // "Finais"						
						Else
							cText := Space(1)
						EndIf
					EndIf
		
					If aMedicoes[nCntFor,nPosGer,1,6] $ "1|2" // Se houver medicoes com incerteza
                  		If lCab

       		                If nCntForM == 1
                		        U_MTR280CInc(cText,nCntFor)  // Imprime cabecalho de
							Endif							// Medicoes com Incerteza
           	        	    
           	        	    If nCntFor > 1 .or. nCntForM > 1
									Ole_ExecuteMacro(oWord,"MtSomaSomEsc") //Soma 1 no nSomEsc           	        	       
           	        	    Endif
           	        	    
           	        	    MTR030SubCab(cText,nCntFor)  // Imprime o SubCabecalho
							lCab := .f.
							
						Else
							
							Ole_ExecuteMacro(oWord,"MtSomaSomEsc")	//Soma 1 no nSomEsc					

						EndIf
						
							nSomEsc++ 
							Ole_ExecuteMacro(oWord,"MtCabGerais")	//Cabecalho Gerais
						    If lPassou
								Ole_ExecuteMacro(oWord,"MtSomnMed")	//Soma nMed (Numero de medicoes)						    
						    Endif
							Ole_ExecuteMacro(oWord,"MtItGerais")	//Itens Gerais
							OLE_SetDocumentVar( oWord, "Adv_CodPr"+Alltrim(Str(nSomEsc)) ,alltrim(aMedicoes[nCntFor,nPosPad]))  
                            lPassou := .T.
						If ntotcol > 0 .and. aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
	                        nMed++
							OLE_SetDocumentVar( oWord, "Adv_VMed"+Alltrim(Str(nMed)) ,If(!empty(aMedicoes[nCntFor,nPosMed,1,nCntForM]),;
												aMedicoes[nCntFor,nPosMed,1,nCntForM],Space(1)))  
						ElseIf aMedicoes[nCntFor,nPosGer,1,3] == "A" // Tipo do padrao ‚ Atributo
							nMed++   
							// Senao ‚ tipo Atributo (imprime Aprovado ou Reprovado)
							OLE_SetDocumentVar( oWord, "Adv_VMed"+Alltrim(Str(nMed)) ,If(aMedicoes[nCntFor,nPosMed,1,nCntForM]=="A",;
									cMVQAPROV,;
									If(aMedicoes[nCntFor,nPosMed,1,nCntForM]=="R",;
									cMVQREPRO,Space(1))))  
						EndIf
 
						If aMedicoes[nCntFor,nPosGer,1,1] > 1 // Verifica se Escala tem mais de uma medicao
							If nTotCol > 0 .and.;
								aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
 								nMed++

								OLE_SetDocumentVar( oWord, "Adv_VMed"+Alltrim(Str(nMed)),If(!empty(aMedicoes[nCntFor,nPosMed,2,nCntForM]),;
													aMedicoes[nCntFor,nPosMed,2,nCntForM],Space(1)))
							ElseIf aMedicoes[nCntFor,nPosGer,1,3] == "A" // Tipo do padrao ‚ Atributo
								nMed++
								OLE_SetDocumentVar( oWord, "Adv_VMed"+Alltrim(Str(nMed)),Space(1))
							EndIf
						EndIf
	
						If nTotCol > 0 .and.; //Media das Leituras
							aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel

							@5000,5000 SAY cMedLei PROMPT aResult[nCntFor,nCntForM,1] PICTURE QMT140Pics("aResult[nCntFor,nCntForM,1]",;
											aMedicoes[nCntFor,nPosMed,1,nCntForM],.t.)

							OLE_SetDocumentVar( oWord, "Adv_MLeitu"+Alltrim(Str(nSomEsc)),cMedLei:cCaption) 	
						
						ElseIf aMedicoes[nCntFor,nPosGer,1,3] $ "A| "
							OLE_SetDocumentVar( oWord, "Adv_MLeitu"+Alltrim(Str(nSomEsc)),Space(1)) 							
						Endif
	
						If aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M"  .or.;
							(aMedicoes[nCntFor,nPosGer,1,4] == "E" .and.;
							aMedicoes[nCntFor,nPosGer,1,1] == 0)
							If ValType(aResult[nCntFor,nCntForM,2]) == "C"
								OLE_SetDocumentVar( oWord, "Adv_DesvMed"+Alltrim(Str(nSomEsc)),PADL(AllTrim(aResult[nCntFor,nCntForM,2]),10," ")) 	
							Else
								@5000,5000 SAY cDesvMed PROMPT	 aResult[nCntFor,nCntForM,2] PICTURE QMT140Pics("aResult[nCntFor,nCntForM,2]",;
													 aMedicoes[nCntFor,nPosMed,1,nCntForM],.t.)
								OLE_SetDocumentVar( oWord, "Adv_DesvMed"+Alltrim(Str(nSomEsc)),cDesvMed:cCaption) 	
							EndIf
	 					ElseIf aMedicoes[nCntFor,nPosGer,1,3] $ "A| "
							OLE_SetDocumentVar( oWord, "Adv_DesvMed"+Alltrim(Str(nSomEsc)),Space(1)) 		 					
	 					EndIf
	
						If aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" .or.;
								(aMedicoes[nCntFor,nPosGer,1,4] == "E" .and.;
								aMedicoes[nCntFor,nPosGer,1,1] == 0) //Desvio Padrao
								@5000,5000 Say cDesvPad PROMPT  aResult[nCntFor,nCntForM,3] PICTURE QMT140Pics("aResult[nCntFor,nCntForM,3]",;
											  aMedicoes[nCntFor,nPosMed,1,nCntForM],.t.)
								OLE_SetDocumentVar( oWord, "Adv_DesvPad"+Alltrim(Str(nSomEsc)),cDesvPad:cCaption) 	
						ElseIf aMedicoes[nCntFor,nPosGer,1,3] $ "A| "
							OLE_SetDocumentVar( oWord, "Adv_DesvPad"+Alltrim(Str(nSomEsc)),Space(1)) 							
						EndIf
	
						If QmtNum(aResult[nCntFor,nCntForM,4]) > 0
							If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
								@5000,5000 SAY cInceMed PROMPT	 aResult[nCntFor,nCntForM,4] PICTURE QMT140Pics("aResult[nCntFor,nCntForM,4]",;
												 aMedicoes[nCntFor,nPosMed,1,nCntForM],.t.) //Incerteza Medicao
								OLE_SetDocumentVar( oWord, "Adv_IncMed"+Alltrim(Str(nSomEsc)),cInceMed:cCaption) 										
							Else
								OLE_SetDocumentVar( oWord, "Adv_IncMed"+Alltrim(Str(nSomEsc)),Space(1)) 																	
							EndIf
						Else
							OLE_SetDocumentVar( oWord, "Adv_IncMed"+Alltrim(Str(nSomEsc)),Space(1)) 																							
						EndIf
						
						If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"  .or.;
							(aMedicoes[nCntFor,nPosGer,1,4] == "E" .and.;
							aMedicoes[nCntFor,nPosGer,1,1] == 0)
							If ValType(aResult[nCntFor,nCntForM,5]) == "C"
								OLE_SetDocumentVar( oWord, "Adv_IncTot"+Alltrim(Str(nSomEsc)),PADL(AllTrim(aResult[nCntFor,nCntForM,5]),10," ")) 										
							Else
								@5000,5000 SAY cInceTot PROMPT aResult[nCntFor,nCntForM,5] PICTURE QMT140Pics("aResult[nCntFor,nCntForM,5]",;
													 aMedicoes[nCntFor,nPosMed,1,nCntForM],.t.)
								OLE_SetDocumentVar( oWord, "Adv_IncTot"+Alltrim(Str(nSomEsc)),cInceTot:cCaption) 										
							EndIf
						ElseIf aMedicoes[nCntFor,nPosGer,1,3] $ "A| "
							OLE_SetDocumentVar( oWord, "Adv_IncTot"+Alltrim(Str(nSomEsc)),Space(1)) 																
						EndIf
	
						If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
							If cMVQCALINC == '1' // Soma Algebrica
								@5000,5000	SAY cErrTot PROMPT aResult[nCntFor,nCntForM,5]+aResult[nCntfor,nCntForM,2] ;
									PICTURE QMT140Pics("aMedicoes[nCntFor,nPosMed,1,1]",aMedicoes[nCntFor,nPosMed,1,1],.t.)
								OLE_SetDocumentVar( oWord, "Adv_ErTot"+Alltrim(Str(nSomEsc)),cErrTot:cCaption) 			
							Else
								@5000,5000 SAY cErrTot PROMPT Sqrt(aResult[nCntfor,nCntForM,5]^2+aResult[nCntFor,nCntForM,2]^2) ;
									PICTURE QMT140Pics("aMedicoes[nCntFor,nPosMed,1,1",aMedicoes[nCntFor,nPosMed,1,1],.t.)
								OLE_SetDocumentVar( oWord, "Adv_ErTot"+Alltrim(Str(nSomEsc)),cErrTot:cCaption) 			
							EndIf
//							OLE_SetDocumentVar( oWord, "Adv_ErTot"+Alltrim(Str(nSomEsc)),Space(1)) 																	
						Else
							If aMedicoes[nCntFor,nPosGer,1,4] == "E" .and.;	//Externo sem medicao
								aMedicoes[nCntFor,nPosGer,1,1] == 0 			// Incerteza e desvio são digitados
								If cMVQCALINC == '1' // Soma Algebrica
									@5000,5000 SAY cErtot PROMPT SuperVal(aResult[nCntFor,nCntForM,5])+SuperVal(aResult[nCntfor,nCntForM,2]);
									PICTURE QMT140Pics("aResult[nCntfor,nCntForM,5]",aResult[nCntfor,nCntForM,5],.f.)
									OLE_SetDocumentVar( oWord, "Adv_ErTot"+Alltrim(Str(nSomEsc)),cErTot:cCaption) 			
								Else
									@5000,5000  SAY cErTot PROMPt Sqrt(SuperVal(aResult[nCntfor,nCntForM,5])^2+SuperVal(aResult[nCntFor,nCntForM,2])^2);
									PICTURE QMT140Pics("aResult[nCntfor,nCntForM,5]",aResult[nCntfor,nCntForM,5],.f.)
									OLE_SetDocumentVar( oWord, "Adv_ErTot"+Alltrim(Str(nSomEsc)),cErTot:cCaption) 			
								EndIf
							Else
								OLE_SetDocumentVar( oWord, "Adv_IncTot"+Alltrim(Str(nSomEsc)),Space(1)) 																	
								OLE_SetDocumentVar( oWord, "Adv_ErTot"+Alltrim(Str(nSomEsc)),Space(1)) 																	
							EndIf
						EndIf
	
						If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
							OLE_SetDocumentVar( oWord, "Adv_Stat"+Alltrim(Str(nSomEsc)),If(aResult[nCntFor,nCntForM,10] == "A" .and. !Empty(aResult[nCntFor,nCntForM,1]),cMVQAPROV,;
												If(aResult[nCntFor,nCntForM,10] == "R" .and. !Empty(aResult[nCntFor,nCntForM,1]),cMVQREPRO,;
											 	"(*)N/A"))) 			  
	 					Else
							OLE_SetDocumentVar( oWord, "Adv_Stat"+Alltrim(Str(nSomEsc)),Space(1)) 			  
	 					EndIf
						
						OLE_SetDocumentVar( oWord, "Adv_CodE"+Alltrim(Str(nSomEsc)),aMedicoes[nCntFor,nPosEsp])
						
						nCont := 3
	                    lPro := .T.
	                    lPulaTab := .F.
						//Com/Sem confirmacao metrologica
						If aMedicoes[nCntFor,nPosGer,1,6] $ "1|2"						
							If nCont <= aMedicoes[nCntFor,nPosGer,1,1] .and.;
								aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
								lMaiorTres := .F.
								Do while nCont <= aMedicoes[nCntFor,nPosGer,1,1] .and.;
									aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
									nMed++
									OLE_ExecuteMacro(oWord,"Mt3MedConf")								
									OLE_SetDocumentVar( oWord, "Adv_CodE"+Alltrim(Str(nSomEsc)),aMedicoes[nCntFor,nPosEsp]) 	
									OLE_SetDocumentVar( oWord, "Adv_VMed"+Alltrim(Str(nMed)),aMedicoes[nCntFor,nPosMed,nCont,nCntForM]) 	
									nCont++
									If nCont <= aMedicoes[nCntFor,nPosGer,1,1]
										nMed++
										Ole_ExecuteMacro(oWord,"MtMedConf")
										Ole_SetDocumentVar( oWord, "Adv_VMed"+Alltrim(Str(nMed)),aMedicoes[nCntFor,nPosMed,nCont,nCntForM]) 	
										nCont++
										lMaiorTres := .T.
									EndIf
 		                            cStat := Space(1)
									If aMedicoes[nCntFor,nPosGer,1,6] == '1' // Se for Confirmacao Metrologica
										If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
											cStat := If(!aResult[nCntFor,nCntForM,7] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Ext,","")+;
														If(!aResult[nCntFor,nCntForM,8] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Ace,","")+;
														If(!aResult[nCntFor,nCntForM,9] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Adq","")
										EndIf
										If Subs(cStat,len(cStat),1) == ","
											cStat := Subs(cStat,1,len(cStat)-1)
										EndIf
										If Empty(cStat) 
											cStat := Space(1)
											Ole_SetDocumentVar(oWord,"Adv_AAE"+Alltrim(Str(nSomEsc)),Space(1))
										Else
											Ole_SetDocumentVar(oWord,"Adv_AAE"+Alltrim(Str(nSomEsc)),cStat)
										Endif
										If !lMaiorTres 
											Ole_Executemacro(oWord,"MtPulCell")
										Endif
										Ole_Executemacro(oWord,"MtImpLaudo")
									EndIf
                		        	If li > 54 .and. ; 
										nCont <= aMedicoes[nCntFor,nPosGer,1,1] .and.;
										aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M" 
	
										@li,000 PSAY __PrtThinLine()
										li++
										li++
									EndIf
								EndDo
									Ole_ExecuteMacro(oWord,"PulaProxTab")
							Else
								If nCont > 4
									@li,004 PSAY '|'
									@li,025 PSAY '|'
								EndIf
        	                    cStat := Space(1)
								If aMedicoes[nCntFor,nPosGer,1,6] == '1' // Se for Confirmacao Metrologica
									If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
										cStat := If(!aResult[nCntFor,nCntForM,7] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Ext,",Space(1))+;
												If(!aResult[nCntFor,nCntForM,8] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Ace,",Space(1))+;
												If(!aResult[nCntFor,nCntForM,9] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Adq",Space(1))
									EndIf
									If Subs(cStat,len(cStat),1) == ","
										cStat := Subs(cStat,1,len(cStat)-1)
									EndIf
								
									If Empty(cStat) 
										cStat := Space(1)
										Ole_SetDocumentVar(oWord,"Adv_AAE"+Alltrim(Str(nSomEsc)),Space(1))
									Else
										Ole_SetDocumentVar(oWord,"Adv_AAE"+Alltrim(Str(nSomEsc)),cStat)
									Endif
									If aMedicoes[nCntFor,nPosGer,1,3] == "A"
										Ole_ExecuteMacro(oWord,"MtCodEAee") //Preenche campo Cod.Padrao e justif. de reprovado
									Else
										Ole_ExecuteMacro(oWord,"MtCodPadrao") //Preenche campo padrao								
									Endif	
									Ole_Executemacro(oWord,"PulaProxTab")																	
								Else
									If aMedicoes[nCntFor,nPosGer,1,3] == "A"
										Ole_ExecuteMacro(oWord,"MtCodEAee")//Preenche campo Cod.Padrao e justif. de reprovado
									Endif
									Ole_Executemacro(oWord,"PulaProxTab")																	
								EndIf
							EndIf
						Else
							If nCont <= aMedicoes[nCntFor,nPosGer,1,1] .and.;
								aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
	
								Do while nCont <= aMedicoes[nCntFor,nPosGer,1,1] .and.;
									aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
									nMed++
									If lPro
										OLE_ExecuteMacro(oWord,"MtIncPadMedi") //Incrementa Padrao e Valor da Medicao								
										OLE_SetDocumentVar( oWord, "Adv_CodE"+Alltrim(Str(nSomEsc)),aMedicoes[nCntFor,nPosEsp]) 	
										lPro := .F.
									Else
										Ole_ExecuteMacro(oWord,"MtIncreMedi") //Incrementa valor da medicao
										lPulaTab := .T.
									Endif
									OLE_SetDocumentVar( oWord, "Adv_VMed"+Alltrim(Str(nMed)),aMedicoes[nCntFor,nPosMed,nCont,nCntForM]) 	
									nCont++
									If nCont <= aMedicoes[nCntFor,nPosGer,1,1]
										nMed++
										Ole_ExecuteMacro(oWord,"MtIncreMedi") //Incrementa valor da medicao
										Ole_SetDocumentVar( oWord, "Adv_VMed"+Alltrim(Str(nMed)),aMedicoes[nCntFor,nPosMed,nCont,nCntForM]) 	
										nCont++
									EndIf
 		                            cStat := Space(1)
									If aMedicoes[nCntFor,nPosGer,1,6] == '1' // Se for Confirmacao Metrologica
										If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
											cStat := If(!aResult[nCntFor,nCntForM,7] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Ext,","")+;
														If(!aResult[nCntFor,nCntForM,8] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Ace,","")+;
														If(!aResult[nCntFor,nCntForM,9] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Adq","")
										EndIf
										If Subs(cStat,len(cStat),1) == ","
											cStat := Subs(cStat,1,len(cStat)-1)
										EndIf
										If Empty(cStat) 
											cStat := Space(1)
											Ole_SetDocumentVar(oWord,"Adv_AAE"+Alltrim(Str(nSomEsc)),Space(1))
										Else
											Ole_SetDocumentVar(oWord,"Adv_AAE"+Alltrim(Str(nSomEsc)),cStat)
										Endif
									EndIf
                		        	If li > 54 .and. ; 
										nCont <= aMedicoes[nCntFor,nPosGer,1,1] .and.;
										aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M" 
	
										@li,000 PSAY __PrtThinLine()
										li++
										li++
									EndIf
								EndDo
								If !lPulaTab //Pular a ultima posicao da tabela - I-SIM/COMPLETA - 25/03
									Ole_ExecuteMacro(oWord,"PulaProxTab")
								Endif
							Else
								If nCont > 4
									@li,004 PSAY '|'
									@li,025 PSAY '|'
								EndIf
        	                    cStat := Space(1)
								If aMedicoes[nCntFor,nPosGer,1,6] == '1' // Se for Confirmacao Metrologica
									If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
										cStat := If(!aResult[nCntFor,nCntForM,7] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Ext,",Space(1))+;
												If(!aResult[nCntFor,nCntForM,8] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Ace,",Space(1))+;
												If(!aResult[nCntFor,nCntForM,9] .and. !Empty(aResult[nCntFor,nCntForM,1]),"Adq",Space(1))
									EndIf
									If Subs(cStat,len(cStat),1) == ","
										cStat := Subs(cStat,1,len(cStat)-1)
									EndIf
								
									If Empty(cStat) 
										cStat := Space(1)
										Ole_SetDocumentVar(oWord,"Adv_AAE"+Alltrim(Str(nSomEsc)),Space(1))
									Else
										Ole_SetDocumentVar(oWord,"Adv_AAE"+Alltrim(Str(nSomEsc)),cStat)
									Endif
									If aMedicoes[nCntFor,nPosGer,1,3] == "A"
										Ole_ExecuteMacro(oWord,"MtCodEAee")//Preenche campo Cod.Padrao e justif. de reprovado
									Else
										Ole_ExecuteMacro(oWord,"MtCodPadrao")//Preenche campo Cod.Padrao								
									Endif	
									Ole_Executemacro(oWord,"PulaProxTab")																	
								Else
									If aMedicoes[nCntFor,nPosGer,1,3] == "A"
										Ole_ExecuteMacro(oWord,"MtCodEAee")//Preenche campo Cod.Padrao e justif. de reprovado
									Endif
									Ole_Executemacro(oWord,"PulaProxTab")																	
								EndIf
							EndIf
						Endif
	                    Ole_ExecuteMacro(oWord,"BkObsEsc")
	 				Else  // Medicoes em relacao ao especificado/limite
						nSomEsc++
						Ole_ExecuteMacro(oWord,"MtSomaSomEsc") //Soma 1 no nSomEsc
						If li > 55
							li++
							lCab := .t.
						EndIf
						If lCab
							U_MTR280CEsp(nCntFor,nCntForM) // Imprime cabecalho de Medicoes sem Incerteza
							Ole_ExecuteMacro(oWord,"MtItVlrEnc")
							lCab := .f.
							lCabDif12 := .T.
	 					EndIf
						nLimMin := SuperVal(aMedicoes[nCntFor,nPosEsp]) -;
									  SuperVal(aMedicoes[nCntFor,nPosGer,1,7,2])
						nLimMax := SuperVal(aMedicoes[nCntFor,nPosEsp]) +;
									  SuperVal(aMedicoes[nCntFor,nPosGer,1,7,1])
	              
	
						For nCntFor3 := 1 to aMedicoes[nCntFor,nPosGer,1,1]
							If li > 55
								li++
								lCab := .t.
							EndIf
							If lCab
								lCab := .f.
		                        If li > 55
		                           li++
		                        EndIf
							EndIf
	
							If nTotCol == 4
								nVezes++
								If ncntForm < 3 .and. nVezes <=Len(aMedicoes)
									nCntForM2 := 1
								Else
									nCntForM2 := 3
								EndIf
							Elseif nTotCol == 2 //nCntForm < 3 .and. nVezes <= Len(aMedicoes)
								nCntforM2 := 1
							Else
								nCntForM2 := nCntForM
							EndIf
	
							If lCabDif12
								Ole_Executemacro(oWord,"MtItDifConfMet")
								lCabDif12 := .f.
							Else
								Ole_Executemacro(oWord,"MtDif12")									
							Endif
							
							If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
								nMedi++
								If nCntFor3 > 1
									Ole_SetDocumentVar(oWord,"Adv_VInic"+Alltrim(Str(nMedi)),aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2])

									@ 5000,5000 SAY nVDif1 PROMPT U_R280Dif (SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2]),;
																nCntFor,nLimMin,nLimMax);
																PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
									Ole_SetDocumentVar(oWord,"Adv_VDif1"+Alltrim(Str(nMedi)),nVDif1:cCaption)																

									@ 5000,5000  SAY nVPerc PROMPT U_R280PerDif(SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2]),;
																nCntFor,nLimMin,nLimMax);
																PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
									Ole_SetDocumentVar(oWord,"Adv_VPerc1"+Alltrim(Str(nMedi)),nVPerc:cCaption)																
								
									If nTotCol > 1
										Ole_SetDocumentVar(oWord,"Adv_VFina"+Alltrim(Str(nMedi)),aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2+1])
        	
										@ 5000,5000 SAY nVPercF PROMPT U_R280Dif (SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2+1]),;
															nCntFor,nLimMin,nLimMax);
															PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
										Ole_SetDocumentVar(oWord,"Adv_VDif2"+Alltrim(Str(nMedi)),nVPercF:cCaption)

										@ 5000,5000  SAY nVDif2 PROMPT U_R280PerDif(SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2+1]),;
															nCntFor,nLimMin,nLimMax);
																PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
										Ole_SetDocumentVar(oWord,"Adv_VPerc2"+Alltrim(Str(nMedi)),nVDif2:cCaption)																
									Else
										Ole_SetDocumentVar(oWord,"Adv_VFina"+Alltrim(Str(nMedi)),Space(1))		  
										Ole_SetDocumentVar(oWord,"Adv_VDif2"+Alltrim(Str(nMedi)),Space(1))							
										Ole_SetDocumentVar(oWord,"Adv_VPerc2"+Alltrim(Str(nMedi)),Space(1))																
									EndIf
			                        Ole_SetDocumentVar(oWord,"Adv_Esc"+Alltrim(Str(nMedi)),Space(1))
            			            Ole_SetDocumentVar(oWord,"Adv_EscRv"+Alltrim(Str(nMedi)),Space(1))	
                        			Ole_SetDocumentVar(oWord,"Adv_CodPad"+Alltrim(Str(nMedi)),Space(1))	
			                        Ole_SetDocumentVar(oWord,"Adv_CodRv"+Alltrim(Str(nMedi)),Space(1))	
								Else
									If nTotCol == 1
										Ole_SetDocumentVar(oWord,"Adv_VInic"+Alltrim(Str(nMedi)),aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2])
										Ole_SetDocumentVar(oWord,"Adv_VFina"+Alltrim(Str(nMedi)),Space(1))		  
										Ole_SetDocumentVar(oWord,"Adv_VDif2"+Alltrim(Str(nMedi)),Space(1))							
										Ole_SetDocumentVar(oWord,"Adv_VPerc2"+Alltrim(Str(nMedi)),Space(1))																
										If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
											@ 5000,5000 SAY nVDif1 PROMPT U_R280Dif (SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2]),;
													nCntFor,nLimMin,nLimMax);
													PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
											Ole_SetDocumentVar(oWord,"Adv_VDif1"+Alltrim(Str(nMedi)),nVDif1:cCaption)																

											@ 5000,5000  SAY nVPerc PROMPT U_R280PerDif(SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2]),;
													nCntFor,nLimMin,nLimMax);
													PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
											Ole_SetDocumentVar(oWord,"Adv_VPerc1"+Alltrim(Str(nMedi)),nVPerc:cCaption)																
										Endif
									Else
										Ole_SetDocumentVar(oWord,"Adv_VInic"+Alltrim(Str(nMedi)),aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2])

										@ 5000,5000 SAY nVDif1 PROMPT U_R280Dif (SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2]),;
																nCntFor,nLimMin,nLimMax);
																PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
										Ole_SetDocumentVar(oWord,"Adv_VDif1"+Alltrim(Str(nMedi)),nVDif1:cCaption)																
        	
										@ 5000,5000  SAY nVPerc PROMPT U_R280PerDif(SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2]),;
																nCntFor,nLimMin,nLimMax);
																PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
										Ole_SetDocumentVar(oWord,"Adv_VPerc1"+Alltrim(Str(nMedi)),nVPerc:cCaption)																
										Ole_SetDocumentVar(oWord,"Adv_VFina"+Alltrim(Str(nMedi)),aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2+1])
        	
										@ 5000,5000 SAY nVPercF PROMPT U_R280Dif (SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2+1]),;
															nCntFor,nLimMin,nLimMax);
															PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
										Ole_SetDocumentVar(oWord,"Adv_VDif2"+Alltrim(Str(nMedi)),nVPercF:cCaption)

										@ 5000,5000  SAY nVDif2 PROMPT U_R280PerDif(SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2+1]),;
															nCntFor,nLimMin,nLimMax);
																PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
										Ole_SetDocumentVar(oWord,"Adv_VPerc2"+Alltrim(Str(nMedi)),nVDif2:cCaption)																
									
									Endif
								Endif
							ElseIf aMedicoes[nCntFor,nPosGer,1,3] == "A" // Tipo do padrao ‚ Atributo
							// Senao ‚ tipo Atributo (imprime Aprovado ou Reprovado)
								nMedi++
								Ole_SetDocumentVar(oWord,"Adv_VInic"+Alltrim(Str(nMedi)),If(aMedicoes[nCntFor,nPosMed,1,nCntForM2]=="A",;
												cMVQAPROV,;
											 If(aMedicoes[nCntFor,nPosMed,1,nCntForM2]=="R",;
											   cMVQREPRO,"")))
								Ole_SetDocumentVar(oWord,"Adv_VDif1"+Alltrim(Str(nMedi)),Space(1))																
								Ole_SetDocumentVar(oWord,"Adv_VPerc1"+Alltrim(Str(nMedi)),Space(1))
								Ole_SetDocumentVar(oWord,"Adv_VFina"+Alltrim(Str(nMedi)),Space(1))           
								Ole_SetDocumentVar(oWord,"Adv_VDif2"+Alltrim(Str(nMedi)),Space(1))								
								Ole_SetDocumentVar(oWord,"Adv_VPerc2"+Alltrim(Str(nMedi)),Space(1))																
								nCntFor3 := aMedicoes[nCntFor,nPosGer,1,1]
							EndIf
			 			Next nCntFor3
						Ole_ExecuteMacro(oWord,"MtFzParag") // Pula tabela e faz paragrafo
	                    Ole_ExecuteMacro(oWord,"BkObsEsc")
						Ole_ExecuteMacro(oWord,"MtObsMed")						
						
						If (nTotCol == 2 .or. nTotCol == 4) .and. nCntForM ==1
							nCntForM := 2
						ElseIf nTotCol == 4 .and. nCntForM == 3
							nCntForM := 4
						EndIf
					EndIf
	
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime observacao de medicao, se houver  (QA2)                 ³
	 				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
		 			nRecQM7 := QM7->(recno())
					cText140O := ""
					
					If nIOBS == 1 // Se impressao de Texto Final == Sim
						QA2->(DbSetOrder(1))
						QM7->(DbSetOrder(1))
						If QM7->(DbSeek(xFilial("QM7")+cMtInstr+cMtRevIns+dtos(dMtData)+cSeql+;
									aMedicoes[nCntFor,nPosEsc]+aMedicoes[nCntFor,nPosGer,1,11]+;
									aMedicoes[nCntFor,nPosPad]+aMedicoes[nCntFor,nPosGer,1,12]))
							cChave := QM7->QM7_CHAVE
						Else
							cChave := CriaVar("QM7_CHAVE")
						EndIf
	
						If QA2->(DbSeek(xFilial("QA2")+"QMTA140O"+cChave))
							If !empty(QA2->QA2_TEXTO) // para garantir nao imprimir uma linha em branco
								cText140O := Alltrim(QA2->QA2_TEXTO)
		               		EndIf
							QA2->(DbSkip())
							Do while QA2->QA2_FILIAL == xFilial("QA2") .and.;
									QA2->QA2_ESPEC + QA2->QA2_CHAVE ==;
									"QMTA140O" + cChave .and.;
									!QA2->(Eof())
								If !empty(QA2->QA2_TEXTO) // para garantir nÆo imprimir uma linha em branco
									cText140O := cText140O + Alltrim(QA2->QA2_TEXTO)
								EndIf
								QA2->(DbSkip())
							EndDo
							If !Empty(cText140O)
								nTxt140O++
								Ole_SetDocumentVar(oWord,"Adv_Tt140O"+Alltrim(Str(nTxt140O)),cText140O)
								Ole_ExecuteMacro(oWord,"MtObs140O")							
							Else
								nTxt140O++
								cText140O := Space(1)
								Ole_SetDocumentVar(oWord,"Adv_Tt140O"+Alltrim(Str(nTxt140O)),cText140O)
								Ole_ExecuteMacro(oWord,"MtObs140O")														
							Endif
						EndIf
					EndIf
	
					QM7->(DbGoto(nRecQM7))
	
					If aMedicoes[nCntFor,nPosGer,1,2] $ "1,4" .or. aMedicoes[nCntFor,nPosGer,1,6] $ "3,4"
						lDuplica := .f.
					EndIf

					If Empty(aMedicoes[nCntFor,nPosMed,1,nCntForM])
					   lImpJust := .T.
					Endif
					If aMedicoes[nCntFor,nPosGer,1,3] == "A"        
						nTotCol := 1
					Endif		               	
	               	nCntFor++       
	               	lPrimeira := .F.
				EndDo	
				Endif
 			Next nCntForM
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Quando muda de Escala, imprime rodape e cabecalho           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nCntFor <= Len(aMedicoes)
				If cEscala <> aMedicoes[nCntFor,nPosEsc]
					If aMedicoes[If(nCntFor>1,nCntFor-1,1),nPosGer,1,2] = "3" // Imprime o Rodape da Escala para Tipo de Calibracao = Pressao (3)
						Ole_ExecuteMacro(oWord,"MtCabHiste") //Cabec. de Histerese
						U_MTR280REsP(aRelResu,cEscala,If(nCntFor>1,nCntFor-1,1))
					ElseIf aMedicoes[If(nCntFor>1,nCntFor-1,1),nPosGer,1,2] = "9" // Imprime o Rodape da Escala para Tipo de Calibracao = Relogio (9)
						U_MTR280REsc(aRelResu,cEscala,If(nCntFor>1,nCntFor-1,1))
					EndIf   					
					lCab      := .T.
					cEscala   := aMedicoes[nCntFor,nPosEsc]
					nTotCol   := U_R280NumCol(nCntFor)
					Ole_ExecuteMacro(oWord,"MtObsMed") //fazer BookMark de Observacao e Medicao
					lPrimeira := .T.
				EndIf
			Else
				If aMedicoes[If(nCntFor>1,nCntFor-1,1),nPosGer,1,2] = "3"
					// Imprime o Rodape da Escala para Tipo de Calibracao = Pressao (3)
					U_MTR280REsP(aRelResu,cEscala,If(nCntFor>1,nCntFor-1,1))
				ElseIf aMedicoes[If(nCntFor>1,nCntFor-1,1),nPosGer,1,2] = "9"
					// Imprime o Rodape da Escala para Tipo de Calibracao = Relogio (9)
					U_MTR280REsc(aRelResu,cEscala,If(nCntFor>1,nCntFor-1,1))
				EndIf   					
			EndIf

		EndDo	//nCntFor

		If lImpJust
			cChave := QM6->QM6_CHAVE
		
			dbSelectArea("QA3")
			dbSetOrder(01)
			If dbSeek(xFilial("QA3")+"QMTA140L"+cChave)
				lFirst := .T.
                cFalMed := Space(1)
				While QA3->(!Eof()) .and. QA3->QA3_FILIAL+"QMTA140L"+QA3->QA3_CHAVE == xFilial("QA3")+"QMTA140L"+cChave
					If lFirst
						Ole_ExecuteMacro(oWord,"MtImFalMed")
						lFirst := .F.
					Endif
                    cFalMed := Alltrim(QA3->QA3_TEXTO)
					QA3->(dbSkip())
				Enddo	
				If !lFirst
					Ole_SetDocumentVar(oWord,"Adv_FaltMed",cFalMed)
				Endif
			Endif		
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver instrumentos utilizados, imprimir    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
       //          1         2         3         4         5         6         7         8         9         0         1         2         3
       //0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
       //|      ESCALA        |        PONTO       |  INSTRUMENTO UTIL.  |  VALIDADE  |  INCERTEZA  |  CERTIFICADO  |      LABORATORIO     |

		lCabUIns := .t.
		lFrsInsUt := .f.
	For nCntFor := 1 to Len(aMedicoes)
			If !Empty(aMedicoes[nCntFor,nPosIns,1,1])
				For nCntFor2 := 1 to len(aMedicoes[nCntFor,nPosIns])
					cEscala := " "
					cPonto  := " "
					If lFrsInsUt
						Ole_ExecuteMacro(oWord,"MtFzParag") // Pula tabela e faz paragrafo
					Endif
					
					If lCabUIns
						CabPadInst("I") // Imprime cabecalho de instrumento utilizado
						lCabUIns := .f.
					EndIf
					nPdSom++
					If aMedicoes[nCntFor,nPosEsc] <> cESCALA
						cEscala := aMedicoes[nCntFor,nPosEsc]
						Ole_SetDocumentVar(oWord,"Adv_PiEsc"+Alltrim(Str(nPdSom)),cEscala)
					Else
						Ole_SetDocumentVar(oWord,"Adv_PiEsc"+Alltrim(Str(nPdSom)),Space(10))
					EndIf

					If aMedicoes[nCntFor,NposPad] <> cPONTO
						cPonto := aMedicoes[nCntFor,nPosPad]
						Ole_SetDocumentVar(oWord,"Adv_PiPto"+Alltrim(Str(nPdSom)),cPonto)
					Else
						Ole_SetDocumentVar(oWord,"Adv_PiPto"+Alltrim(Str(nPdSom)),Space(10))
					EndIf
					dData := QM6->QM6_DATA
					// Posiciono na medicao em que o instrumento utilizado foi aprovado e
					// dentro do periodo procurado
					nRecQM6 := QM6->(recno())
					Ole_Executemacro(oWord,"MtPSecUIns") 
					lFrsInsUt := .t.
					dbSelectArea("QMI")
					dbSetOrder(1)
					If dbSeek(xFilial()+QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA)+cSeql)
						nItPS := 0
						If !Empty(QMI->QMI_CSEQPR) .and. !Empty(QMI->QMI_REVQPR) .and. !Empty(QMI->QMI_DATQPR) 								
							dbSelectArea("QM6")
							dbSetOrder(1)
							If DbSeek(xFilial("QM6")+aMedicoes[nCntFor,nPosIns,nCntFor2,1]+QMI->QMI_REVQPR+DtoS(QMI->QMI_DATQPR)+QMI->QMI_CSEQPR)
								lAchou := .f.
								Do while aMedicoes[nCntFor,nPosIns,nCntFor2,1] == QM6->QM6_INSTR
									If	QM6->QM6_DATA <= dData .and.;
										dData <= QM6->QM6_VALDAF .and.;
										QM6->QM6_LAUDO == "A" .and.;
										!QM6->(Eof())               
									// Posiciono no QM7 para descobrir o numero do certificado e laboratorio
									// ATENCAO: Prevalecera numero e laboratorio da PRIMEIRA ESCALA
										nRecQM7 := QM7->(Recno())
										QM7->(DbSeek(xFilial("QM7")+QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA)+QM6->QM6_CSEQ))
                               			nItPS++
	 									If !lFzNov        
											Ole_SetDocumentVar(oWord,"Adv_PiEsc"+Alltrim(Str(nItPS)),Space(10))  
											Ole_SetDocumentVar(oWord,"Adv_PiPto"+Alltrim(Str(nItPS)),Space(10))									
										Endif
										lFzNov := .F.
										Ole_SetDocumentVar(oWord,"Adv_PaInstr"+Alltrim(Str(nItPS)),aMedicoes[nCntFor,nPosIns,nCntFor2,1])
										Ole_SetDocumentVar(oWord,"Adv_PIVal"+Alltrim(Str(nItPS))  ,QM6->QM6_VALDAF)
										Ole_SetDocumentVar(oWord,"Adv_PIncert"+Alltrim(Str(nItPS)),aMedicoes[nCntFor,nPosIns,nCntFor2,3])
										Ole_SetDocumentVar(oWord,"Adv_PICert"+Alltrim(Str(nItPS)) ,QM7->QM7_NRCERT)
										lAchou := .t.
										Ole_Executemacro(oWord,"MtItPSecUIns")
										QM7->(DbGoto(nRecQM7))
										exit
									EndIf
								QM6->(DbSkip())
								EndDo
								If !lAchou
									nItPS++
									Ole_SetDocumentVar(oWord,"Adv_PiEsc"+Alltrim(Str(nItPS)),OemToAnsi(STR0028))  
									Ole_Executemacro(oWord,"MtItPSecUIns")
								EndIf
							Else
								nItPS++
								Ole_SetDocumentVar(oWord,"Adv_PiEsc"+Alltrim(Str(nItPS)),OemToAnsi(STR0029))  
								Ole_Executemacro(oWord,"MtItPSecUIns")
							EndIf
						Else
							dbSelectArea("QM6")
							dbSetOrder(2)
							If QM6->(DbSeek(xFilial("QM6")+aMedicoes[nCntFor,nPosIns,nCntFor2,1]))
								lAchou := .f.
								Do while aMedicoes[nCntFor,nPosIns,nCntFor2,1] == QM6->QM6_INSTR
									If QM6->QM6_DATA <= dData .and. dData <= QM6->QM6_VALDAF .and.;
										QM6->QM6_LAUDO == "A" .and.	!QM6->(Eof())
   		            	    	        cSeqlQM6 := QM6->QM6_CSEQ
										// Posiciono no QM7 para descobrir o numero do certificado e laboratorio
										// ATENCAO: Prevalecera numero e laboratorio da PRIMEIRA ESCALA
										nRecQM7 := QM7->(Recno())
										QM7->(DbSeek(xFilial("QM7")+QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA)+cSeqlQM6))
										@ li  ,042 PSAY "|" 
										@ li  ,043 PSAY aMedicoes[nCntFor,nPosIns,nCntFor2,1]
										@ li  ,064 PSAY "|" 
										@ li  ,066 PSAY QM6->QM6_VALDAF
										@ li  ,077 PSAY "|" 								
										@ li  ,079 PSAY  aMedicoes[nCntFor,nPosIns,nCntFor2,3]
										@ li  ,091 PSAY "|" 								
										@ li  ,093 PSAY QM7->QM7_NRCERT
										@ li  ,107 PSAY "|" 								
										@ li  ,108 PSAY QM7->QM7_LABOR
										@ li  ,131 PSAY "|" 
										lAchou := .t.
										QM7->(DbGoto(nRecQM7))
										exit
									EndIf
									QM6->(DbSkip())
								EndDo
								If !lAchou
									@ li  ,042 PSAY "|"
									@ li  ,043 PSAY OemToAnsi(STR0028)//"Medicao com status diferente de Ativo" 
									@ li  ,131 PSAY "|" 
								EndIf
							Else
								@ li  ,042 PSAY "|"
								@ li  ,043 PSAY OemToAnsi(STR0029) //"Medi‡„o exclu¡da"
								@ li  ,131 PSAY "|" 
							EndIf								
						Endif
					Else
						@ li  ,042 PSAY "|"+ OemToAnsi(STR0029) //"Medi‡„o exclu¡da"
						@ li  ,131 PSAY "|"
					Endif
					QM6->(DbGoto(nRecQM6))
 				Next nCntFor2
 				If lFrsInsUt
					Ole_ExecuteMacro(oWord,"MtFzParag") // Pula tabela e faz paragrafo
				Endif
 			EndIf
		Next nCntFor
		If lFrsInsUt
			Ole_ExecuteMacro(oWord,"MtFzParag") // Pula tabela e faz paragrafo
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver incerteza tipo B, imprime.           ³                            	
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		r280ITB()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver padroes secundarios, imprimir  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
   ================================================================================================================
   |                                            PADROES SECUNDARIOS                                               |
   ================================================================================================================
   |     ESCALA     |        PONTO       |PADRAO SECUNDARIO| VALIDADE | INCERTEZA | CERTIFICADO  |   LABORATORIO  |
   |--------------------------------------------------------------------------------------------------------------|
   |1234567890123456|1234567890123456 - S|1234567890123456 |99/99/9999|1234567890 | 123456789012 |1234567890123456|
   |--------------------------------------------------------------------------------------------------------------|
*/

 		lPadoSec := .t.
		nPdSom := 0
 		nItPS := 0
 		For nCntFor := 1 to len(aMedicoes)
			If !empty(aMedicoes[nCntFor,nPosSec,1,1]) //File(cArqQMS)
				cEscala := " "
				cPonto  := " "
				For nCntFor2 := 1 to len(aMedicoes[nCntFor,nPosSec])
					If lPadoSec
						CabPadInst("S") // Imprime cabecalho de padroes secundarios
						lPadoSec := .f.
					EndIf
					nPdSom++
					If aMedicoes[nCntFor,nPosEsc] <> cEscala
						cEscala := aMedicoes[nCntFor,nPosEsc]
						Ole_SetDocumentVar(oWord,"Adv_PiEsc"+Alltrim(Str(nPdSom)),cEscala)
						lFzNov := .T.
					EndIf

					If aMedicoes[nCntFor,nPosPad] <> cPONTO
						cPonto := aMedicoes[nCntFor,nPosPad]
						Ole_SetDocumentVar(oWord,"Adv_PiPto"+Alltrim(Str(nPdSom)),cPonto)
						lFzNov := .T.
					EndIf
					
/*					If lFzNov             
						lFrsInsUt := .t.
						Ole_Executemacro(oWord,"MtPSecUIns") 					
					Endif
*/					
					dData := QM6->QM6_DATA
					// Posiciono na medicao em que o padrao secundario foi aprovado e
					// dentro do periodo procurado
					nRecQM6 := QM6->(recno())

					dbSelectArea("QMS")
					dbSetOrder(1)
					If dbSeek(xFilial()+QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA))
						If !Empty(QMS->QMS_CSEQPR) .and. !Empty(QMS->QMS_REVQPR) .and. !Empty(QMS_DATQPR)							
							While QMS->(!Eof()) .and. QMS->QMS_INSTR+QMS->QMS_REVINS+DtoS(QMS->QMS_DATA) ==;
								  QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA)
								  //Sequencia como ultimo campo no indice de padroes secundarios	 
								  If QMS->QMS_CSEQ == QM6->QM6_CSEQ
										Exit
								  Endif
								  dbSelectArea("QM7") 
								  dbSkip()
							Enddo								  								  	
							dbSelectArea("QM6")
							dbSetOrder(1)
							If DbSeek(xFilial("QM6")+aMedicoes[nCntFor,nPosSec,nCntFor2,1]+QMS->QMS_REVQPR+DtoS(QMS->QMS_DATQPR)+QMS->QMS_CSEQPR)
								lAchou := .f.
								If QM6->QM6_DATA <= dData .and. dData <= QM6->QM6_VALDAF .and.;
									QM6->QM6_LAUDO == "A" .and. !QM6->(Eof())               
									// Posiciono no QM7 para descobrir o numero do certificado e laboratorio
									// ATENCAO: Prevalecera numero e laboratorio da PRIMEIRA ESCALA
									nRecQM7 := QM7->(Recno())
									QM7->(DbSeek(xFilial("QM7")+QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA)+QM6->QM6_CSEQ))
									nItPS++
									If !lFzNov 
										Ole_SetDocumentVar(oWord,"Adv_PiEsc"+Alltrim(Str(nItPS)),Space(10))  
										Ole_SetDocumentVar(oWord,"Adv_PiPto"+Alltrim(Str(nItPS)),Space(10))									
									Endif
									lFzNov := .F.
									Ole_SetDocumentVar(oWord,"Adv_PaInstr"+Alltrim(Str(nItPS)),aMedicoes[nCntFor,nPosSec,nCntFor2,1])
									Ole_SetDocumentVar(oWord,"Adv_PIVal"+Alltrim(Str(nItPS))  ,QM6->QM6_VALDAF)
									Ole_SetDocumentVar(oWord,"Adv_PIncert"+Alltrim(Str(nItPS)),aMedicoes[nCntFor,nPosSec,nCntFor2,3])
									Ole_SetDocumentVar(oWord,"Adv_PICert"+Alltrim(Str(nItPS)) ,QM7->QM7_NRCERT)
									Ole_SetDocumentVar(oWord,"Adv_PILab"+Alltrim(Str(nItPS)) ,Space(TamSx3("QM2_DEPTO")[1]))
									lAchou := .t.
									Ole_Executemacro(oWord,"MtItPSecUIns")
									QM7->(DbGoto(nRecQM7))
									exit
								Endif
							Else
								nItPS++
								Ole_SetDocumentVar(oWord,"Adv_PiEsc"+Alltrim(Str(nItPS)),OemToAnsi(STR0028))  
								Ole_Executemacro(oWord,"MtItPSecUIns")
							EndIf
							If !lAchou
								nItPS++
								Ole_SetDocumentVar(oWord,"Adv_PiEsc"+Alltrim(Str(nItPS)),OemToAnsi(STR0029))  
								Ole_Executemacro(oWord,"MtItPSecUIns")
							EndIf
						Else
							dbSelectArea("QM6")
							dbSetOrder(2)
							If DbSeek(xFilial("QM6")+aMedicoes[nCntFor,nPosSec,nCntFor2,1])
								lAchou := .f.
								Do while aMedicoes[nCntFor,nPosSec,nCntFor2,1] == QM6->QM6_INSTR
									If QM6->QM6_DATA <= dData .and. dData <= QM6->QM6_VALDAF .and.;
										QM6->QM6_LAUDO == "A" .and.	!QM6->(Eof())               
										cSeqlQM6 := QM6->QM6_CSEQ
										// Posiciono no QM7 para descobrir o numero do certificado e laboratorio
										// ATENCAO: Prevalecera numero e laboratorio da PRIMEIRA ESCALA
										nRecQM7 := QM7->(Recno())	
										QM7->(DbSeek(xFilial("QM7")+QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA)+cSeqlQM6))
										@ li  ,042 PSAY "|"
										@ li  ,043 PSAY aMedicoes[nCntFor,nPosSec,nCntFor2,1]
										@ li  ,064 PSAY "|"
										@ li  ,066 PSAY QM6->QM6_VALDAF
										@ li  ,077 PSAY "|"
										@ li  ,079 PSAY aMedicoes[nCntFor,nPosSec,nCntFor2,3]
										@ li  ,091 PSAY "|"
										@ li  ,093 PSAY QM7->QM7_NRCERT
										@ li  ,107 PSAY "|"
										@ li  ,108 PSAY QM7->QM7_LABOR
										@ li  ,131 PSAY "|"
										lAchou := .t.
										QM7->(DbGoto(nRecQM7))
										exit
									EndIf
									QM6->(DbSkip())
								EndDo
								If !lAchou
									@ li  ,042 PSAY "|"+ OemToAnsi(STR0028)//"Medicao com status diferente de Ativo"
									@ li  ,131 PSAY "|"
								EndIf
							Else
								@ li  ,042 PSAY "|"+ OemToAnsi(STR0029) //"Medi‡„o exclu¡da"
								@ li  ,131 PSAY "|"
							EndIf
						Endif						
					Else
						@ li  ,042 PSAY "|"+ OemToAnsi(STR0029) //"Medi‡„o exclu¡da"
						@ li  ,131 PSAY "|"
					Endif								
					QM6->(DbGoto(nRecQM6))
				Next nCntFor2
 			EndIf
		Next nCntFor
        
		If nItPS > 0
			Ole_Executemacro(oWord,"MtPulaTab")
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver nao conformidades, imprimir   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
   ================================================================================================================
   |                                             NAO CONFORMIDADES                                                |
   ================================================================================================================
   |     ESCALA     |        PONTO       |   N/C    |                DESCRICAO                 |   CLASSIFICACAO  |
   |--------------------------------------------------------------------------------------------------------------|
   |1234567890123456|1234567890123456 - S| 12345678 | 1234567890123456789012345678901234567890 |  Muito GRave     |
   |--------------------------------------------------------------------------------------------------------------|
*/

		lCabNco := .t.
		nNc := 0
		//          1         2         3         4         5         6         7         8         9         0         1         2         3
		//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		//|   ESCALA           |       PONTO        |   N/C    |                DESCRICAO				  |           CLASSIFICACAO          |

 		If nINCs == 1
 			For nCntFor := 1 to Len(aMedicoes)
 				If !empty(aMedicoes[nCntFor,nPosNco,1,1])				// File(cArqQMJ)
					cEscala := " "
					cPonto  := " "
 					For nCntFor2 := 1 to Len(aMedicoes[nCntFor,nPosNco])
						nNc++
						If lCabNco
							Ole_ExecuteMacro(oWord,"MtCabNco")
							Ole_ExecuteMacro(oWord,"MtCabCpoNco")
							lCabNco := .f.
						EndIf
						If aMedicoes[nCntFor,nPosEsc] <> cESCALA
							cEscala := aMedicoes[nCntFor,nPosEsc]
							lFzNco	:= .t.
							Ole_SetDocumentVar(oWord,"Adv_NcEsc"+Alltrim(Str(nNc)),cEscala)
						Else
							lFzNco	:= .f.						
						EndIf
						If aMedicoes[nCntFor,nPosPad] <> cPONTO
							cPonto := aMedicoes[nCntFor,nPosPad]
							Ole_SetDocumentVar(oWord,"Adv_NcPto"+Alltrim(Str(nNc)),cPonto)							
							lFzNco := .t.
						Else
							lFzNco	:= .f.												
						EndIf
						
						If !lFzNco
							Ole_SetDocumentVar(oWord,"Adv_NcEsc"+Alltrim(Str(nNc)),Space(5))						
							Ole_SetDocumentVar(oWord,"Adv_NcPto"+Alltrim(Str(nNc)),Space(5))														
						Endif

						Ole_SetDocumentVar(oWord,"Adv_NcNco"+Alltrim(Str(nNc)),aMedicoes[nCntFor,nPosNco,nCntFor2,1])
						Ole_SetDocumentVar(oWord,"Adv_NcDesc"+Alltrim(Str(nNc)),aMedicoes[nCntFor,nPosNco,nCntFor2,2])
						Ole_SetDocumentVar(oWord,"Adv_NcClass"+Alltrim(Str(nNc)),If(aMedicoes[nCntFor,nPosNco,nCntFor2,3] == "M",OemToAnsi(STR0030),If(aMedicoes[nCntFor,nPosNco,nCntFor2,3] == "G",OemToAnsi(STR0031), OemToAnsi(STR0032))))
						Ole_Executemacro(oWord,"MtIncItNco")
					Next nCntFor2
	 			EndIf
			Next nCntFor
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Confirmacao Metrologica por Escala (se houver)       	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		U_R280CM()

		If nILaudo == 1 // Se impressao do laudo == sim
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime laudo (e justificativa, se houver)                   	³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			Ole_SetDocumentVar(oWord,"Adv_DesLau",If(QM6->QM6_LAUDO=="A",cMVQAPROV,If(QM6->QM6_LAUDO=="R",cMVQREPRO,cMVQAPCON)))
			Ole_ExecuteMacro(oWord,"MtDesLaudo")
			cChave := QM6->QM6_CHAVE
			clImpJus := ""
			QA3->(DbSetOrder(1))
			If QA3->(DbSeek(xFilial("QA3")+"QMTA140M"+cChave))
				While QA3->(!Eof()) .and. QA3->QA3_FILIAL+"QMTA140M"+QA3->QA3_CHAVE ==;
				xFilial("QA3")+"QMTA140M"+cChave
					clImpJus := Alltrim(QA3->QA3_TEXTO)
					QA3->(dbSkip())
				Enddo	
 			EndIf
			If !Empty(clImpJus)
				Ole_SetDocumentVar(oWord,"Adv_ImpJus",clImpJus)	   
				Ole_ExecuteMacro(oWord,"MtJustLaudo")
			Endif
 		EndIf
        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Condicao de Recebimento (se houver)                  	  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cMVQFREQAF == "S"
			If !empty(QM6->QM6_COND)
				Ole_SetDocumentVar(oWord,"Adv_CondRec",If(QM6->QM6_COND =="A",OemToAnsi(STR0033),If(QM6->QM6_COND =="C",OemToAnsi(STR0034),OemToAnsi(STR0035))))
				Ole_ExecuteMacro(oWord,"MtCondRec")
			EndIf
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver inf.compl.do instr.(de acordo com param. de impressao)³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If nInfCIn == 1 // Se impressao da inform.compl.instr. == 1
			cInfComple := ""
			QA2->(DbSetOrder(1))
			cChave := QM2->QM2_CHAVE
			If QA2->(DbSeek(xFilial("QA2")+"QMTA010I"+cChave))
				Do while QA2->QA2_FILIAL == xFilial("QA2") .and.;
							QA2->QA2_ESPEC + QA2->QA2_CHAVE ==;
							"QMTA010I" + cCHAVE .and.;
							!QA2->(Eof())
						cInfComple := Alltrim(QA2->QA2_TEXTO)
					QA2->(DbSkip())
				EndDo
			EndIf
		EndIf


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver inf.compl.  (de acordo com parametro de impressao)    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If nInfCom == 1 // Se impressao de Inf.Compl. == Sim
			cArqTxt := "R303"+cEmpAnt+cFilAnt+".TXT"
			cImpLi := U_R280IMPTXT(cArqTxt,1)
			If Empty(cImpLi)
				cImpLi := Space(1)
			Endif
			Ole_SetDocumentVar(oWord,"Adv_InfTex",cImpLi)
			Ole_ExecuteMacro(oWord,"MtInfText")
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver texto final (de acordo com parametro de impressao)    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If nTxtFin == 1 // Se impressao de Texto Final == Sim
			cArqTxt := "R302"+cEmpAnt+cFilAnt+".TXT"
			cImpLi := U_R280IMPTXT(cArqTxt,1)
            If Empty(cImpLi)
            	cImpLi := Space(1)
            Endif
			Ole_SetDocumentVar(oWord,"Adv_TexFim",cImpLi)
			Ole_ExecuteMacro(oWord,"MtTextFim")

 		EndIf

		lImpCabec := .T.

 		dbSelectArea( "QM6" )

		// Imrprime Analise das ultimas pecas produzidas se
 		// parametro 18 = "S" e Laudo for reprovado.
/*
		If mv_par18 == 1 .and. QM6->QM6_LAUDO == "R"   - Fazer essa situacao
			m_pag := 1
			li := 100
			R999AnaUP()
		EndIf
*/		
//	EndIf

		If !Empty(QM2->QM2_CLIE)
			dbSelectArea("SM0")
			dbSeek(cEmpAnt)
            Ole_SetDocumentVar(oWord,"Adv_Labori",Alltrim(SM0->M0_NOME) + " - " + Alltrim(SM0->M0_NOMECOM))
            Ole_SetDocumentVar(oWord,"Adv_EndLabor",Alltrim(SM0->M0_ENDENT) + " - " + Alltrim(SM0->M0_CIDENT))
            Ole_SetDocumentVar(oWord,"Adv_CepLabor",Alltrim(SM0->M0_CEPENT) + " - " + Alltrim(SM0->M0_BAIRENT))
            Ole_SetDocumentVar(oWord,"Adv_TelLabor",Alltrim(SM0->M0_TEL))  
            Ole_ExecuteMacro(oWord,"MtFimClie")
		Endif   
  	li := 60	
	IncProcDoc( "Atualizando Variaveis..." ) 
	OLE_UpdateFields( oWord ) 
   	If msgyesno ('Selecione SIM para enviar o Certificado em Word para impressora padrão e NÂO para salvar na pasta temporaria') 
		OLE_PrintFile( oWord, "ALL",,,1)
	Else
		OLE_SaveAsFile( oWord, ( cQPathTrm + SubStr(cTxtWord,1,9) + Alltrim(QM6->QM6_RESP)+".DOC" ), , , .f., oleWdFormatDocument )
	EndIf 
	OLE_CloseFile( oWord )	      
	OLE_CloseLink( oWord ) 	
	DbSelectArea("QM6")
	dbSetOrder(1)
	dbSkip()
EndDo

Return 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR280Carg³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega aMedicoes, para calculo dos resultados para impres-³±±
±±³          ³ sao.                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MTR280Carg()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto ³ 20/06/00 ³ Alteracoes para calibrar Tipo de Calibracao Re- ³±±
±±³          ³          ³ logio.                        				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR280Carg(aRelResu,aImpCer)
Local 	nRelResu
Local	aArea := GetArea()
Local   nCntFor2 := 1
Private nPosGer	:= 0 //Posicao na String para referencia no dbTree
Private Inclui		:= .F.
Private cEscala	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ aRelResu : contem os dados para impressao dos Parametros       ³
//³            de Analise para o Tipo de Calibracao Relogio e      ³
//³            Histerese para Pressao                              ³
//³ Conteudo :                                                     ³
//³ Posicao 													   ³
//³ 1		- Escala                                               ³
//³ 2		- Maior Erro de Indicacao Crescente                    ³
//³ 3		- Menor Erro de Indicacao Crescente                    ³
//³ 4		- Maior Erro de Indicacao Total (Crescente/Decrescente)³
//³ 5		- Menor Erro de Indicacao Total (Crescente/Decrescente)³
//³ 6		- Desvio Maximo no sentido Crescente                   ³
//³ 7		- Desvio Total (Crescente/Decrescente)                 ³
//³ 8		- Erro de Retorno                                      ³
//³ 9		- Diferenca do mesmo ponto Crescente e Decrescente     ³
//³ 10		- Histerese											   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !lCertif
	cMtInstr	:= QM6->QM6_INSTR
	cMtRevIns	:= QM6->QM6_REVINS
	dMtData		:= QM6->QM6_DATA
	cMtResp		:= QM6->QM6_RESP
	cMtTotHr	:= QM6->QM6_TOTHOR
	cMtRepRepr	:= QM6->QM6_REPEPR
Else 
	cMtInstr	:= aImpCer[1][1]
	cMtRevIns	:= aImpCer[1][4]
	dMtData		:= aImpCer[1][2]
	cMtResp		:= aImpCer[1][3]
	cMtTotHr	:= aImpCer[1][5]
	cMtRepRepr	:= aImpCer[1][6]
Endif	

dbSelectArea("QM6")

aMedicoes := {}

cSeql := QM6->QM6_CSEQ //Seguencia de calibracao em uma mesma data

a140CarMed()

aResult := {}
nRelResu := 0

For nCntFor2 := 1 To len(aMedicoes)
	aadd(aResult, a140Calc(nCntFor2,.t.))
	If aMedicoes[nCntFor2,nPosGer,1,2] $ "3,9"
		If aMedicoes[nCntFor2,nPosGer,1,3] <> "A"	 
			If cEscala <> aMedicoes[nCntFor2,nPosEsc]	
		  		cEscala   	:= aMedicoes[nCntFor2,nPosEsc]	
				AADD(aRelResu,{cEscala,;					//  1- Escala
		 				QmtNum(aResult[nCntFor2,2,11]),;	//  2- Maior Erro de Indicacao Crescente
						QmtNum(aResult[nCntFor2,2,11]),;	//  3- Menor Erro de Indicacao Crescente
						QmtNum(aResult[nCntFor2,2,11]),;	//  4- Maior Erro de Indicacao Total (Crescente/Decrescente)
						QmtNum(aResult[nCntFor2,2,11]),;	//  5- Menor Erro de Indicacao Total (Crescente/Decrescente)
						QmtNum(aResult[nCntFor2,2,11]),;	//  6- Desvio Maximo no sentido Crescente
						QmtNum(aResult[nCntFor2,2,11]),;	//  7- Desvio Total (Crescente/Decrescente)
						0,;									//  8- Erro de Retorno
						QmtNum(aResult[nCntFor2,2,11]),;	//  9- Diferenca do mesmo ponto Crescente e Decrescente                                            		
						0})									// 10- Histerese                                           		
				nRelResu++
			Else
				aRelResu[nRelResu,2] := Iif(QmtNum(aResult[nCntFor2,2,11]) > aRelResu[nRelResu,2], QmtNum(aResult[nCntFor2,2,11]), aRelResu[nRelResu,2])
				aRelResu[nRelResu,3] := Iif(QmtNum(aResult[nCntFor2,2,11]) < aRelResu[nRelResu,3], QmtNum(aResult[nCntFor2,2,11]), aRelResu[nRelResu,3])
				aRelResu[nRelResu,6] := ABS(aRelResu[nRelResu,2]-aRelResu[nRelResu,3])
				aRelResu[nRelResu,4] := Iif(QmtNum(aResult[nCntFor2,2,11]) > aRelResu[nRelResu,4], QmtNum(aResult[nCntFor2,2,11]), aRelResu[nRelResu,4])
				aRelResu[nRelResu,5] := Iif(QmtNum(aResult[nCntFor2,2,11]) < aRelResu[nRelResu,5], QmtNum(aResult[nCntFor2,2,11]), aRelResu[nRelResu,5])
				aRelResu[nRelResu,7] := ABS(aRelResu[nRelResu,4]-aRelResu[nRelResu,5])
				aRelResu[nRelResu,9] := QmtNum(aResult[nCntFor2,2,11])
			EndIf			
			aRelResu[nRelResu, 4] := Iif(QmtNum(aResult[nCntFor2,4,11]) > aRelResu[nRelResu,4], QmtNum(aResult[nCntFor2,4,11]), aRelResu[nRelResu,4])
			aRelResu[nRelResu, 5] := Iif(QmtNum(aResult[nCntFor2,4,11]) < aRelResu[nRelResu,5], QmtNum(aResult[nCntFor2,4,11]), aRelResu[nRelResu,5])
			aRelResu[nRelResu, 6] := ABS(aRelResu[nRelResu,4] - aRelResu[nRelResu,5])	
			aRelResu[nRelResu, 9] := ABS(aRelResu[nRelResu,9] - QmtNum(aResult[nCntFor2,4,11]))
			If aRelResu[nRelResu,9] > aRelResu[nRelResu,8]
				aRelResu[nRelResu, 8] := aRelResu[nRelResu,9]
				If aMedicoes[nCntFor2,nPosGer,1,2] == "3"
					aRelResu[nRelResu,10] := (aRelResu[nRelResu,8]/QmtNum(aResult[nCntFor2,4,12])) * 100
				Else			
					aRelResu[nRelResu,10] := aRelResu[nRelResu,8] / Sqrt(12)
				EndIf			
			EndIf	
		Else
			If cEscala <> aMedicoes[nCntFor2,nPosEsc]	
		  		cEscala   	:= aMedicoes[nCntFor2,nPosEsc]	
				AADD(aRelResu,{cEscala,;					//  1- Escala
		 				QmtNum(aResult[nCntFor2,1,11]),;	//  2- Maior Erro de Indicacao Crescente
						QmtNum(aResult[nCntFor2,1,11]),;	//  3- Menor Erro de Indicacao Crescente
						QmtNum(aResult[nCntFor2,1,11]),;	//  4- Maior Erro de Indicacao Total (Crescente/Decrescente)
						QmtNum(aResult[nCntFor2,1,11]),;	//  5- Menor Erro de Indicacao Total (Crescente/Decrescente)
						QmtNum(aResult[nCntFor2,1,11]),;	//  6- Desvio Maximo no sentido Crescente
						QmtNum(aResult[nCntFor2,1,11]),;	//  7- Desvio Total (Crescente/Decrescente)
						0,;									//  8- Erro de Retorno
						QmtNum(aResult[nCntFor2,1,11]),;	//  9- Diferenca do mesmo ponto Crescente e Decrescente                                            		
						0})									// 10- Histerese                                           		
				nRelResu++
			Else
				aRelResu[nRelResu,2] := Iif(QmtNum(aResult[nCntFor2,1,11]) > aRelResu[nRelResu,2], QmtNum(aResult[nCntFor2,1,11]), aRelResu[nRelResu,2])
				aRelResu[nRelResu,3] := Iif(QmtNum(aResult[nCntFor2,1,11]) < aRelResu[nRelResu,3], QmtNum(aResult[nCntFor2,1,11]), aRelResu[nRelResu,3])
				aRelResu[nRelResu,6] := ABS(aRelResu[nRelResu,2]-aRelResu[nRelResu,3])
				aRelResu[nRelResu,4] := Iif(QmtNum(aResult[nCntFor2,1,11]) > aRelResu[nRelResu,4], QmtNum(aResult[nCntFor2,1,11]), aRelResu[nRelResu,4])
				aRelResu[nRelResu,5] := Iif(QmtNum(aResult[nCntFor2,1,11]) < aRelResu[nRelResu,5], QmtNum(aResult[nCntFor2,1,11]), aRelResu[nRelResu,5])
				aRelResu[nRelResu,7] := ABS(aRelResu[nRelResu,4]-aRelResu[nRelResu,5])
				aRelResu[nRelResu,9] := QmtNum(aResult[nCntFor2,1,11])
			EndIf			
			aRelResu[nRelResu, 4] := Iif(QmtNum(aResult[nCntFor2,1,11]) > aRelResu[nRelResu,4], QmtNum(aResult[nCntFor2,1,11]), aRelResu[nRelResu,4])
			aRelResu[nRelResu, 5] := Iif(QmtNum(aResult[nCntFor2,1,11]) < aRelResu[nRelResu,5], QmtNum(aResult[nCntFor2,1,11]), aRelResu[nRelResu,5])
			aRelResu[nRelResu, 6] := ABS(aRelResu[nRelResu,4] - aRelResu[nRelResu,5])	
			aRelResu[nRelResu, 9] := ABS(aRelResu[nRelResu,9] - QmtNum(aResult[nCntFor2,1,11]))
			If aRelResu[nRelResu,9] > aRelResu[nRelResu,8]
				aRelResu[nRelResu, 8] := aRelResu[nRelResu,9]
				If aMedicoes[nCntFor2,nPosGer,1,2] == "3"
					aRelResu[nRelResu,10] := (aRelResu[nRelResu,8]/QmtNum(aResult[nCntFor2,1,12])) * 100
				Else			
					aRelResu[nRelResu,10] := aRelResu[nRelResu,8] / Sqrt(12)
				EndIf			
			EndIf	
		EndIf
	Endif
Next nCntFor2
RestArea(aArea)
Return(aResult)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R280IMPTXT³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Texto do arquivo TXT passado como parametro        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R280IMPTXT(cArq,nTipo)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cArq := Arquivo a ser impresso                             ³±±
±±³          ³ nTipo:= Tipo de cabecalho (1-Certificado, 2-Analise de pp) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R280IMPTXT(cArq,nTipo)

Local nCntFor
Local nCount    
Local cAcentos  := "€ú‡úú"+chr(65533)+"ú…ú†úƒú ú"+chr(65533)+"úˆú‚ú¡ú“ú”ú¢ú™ú£ú"
Local cAcSubst  := "C,c,A~A'a`a~a^a'E'e^e'i'o^o~o'O~U'"
Local cImpLinha :=""
Local cTexto	:= ""
Local aLinha	:= {}
Local cImpTxt   := ""

If File(cArq)
	cTexto:=MemoRead(cArq)
	For nCntFor := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nCntFor)
		cImpTxt   := ""
		For nCount := 1 To Len(aLinha)
			cImpTxt := Substr(aLinha,nCount,1)
			If AT(cImpTxt,cAcentos)>0
				cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
			EndIf
			cImpLinha := cImpLinha+cImpTxt
		Next nCount
	Next nCntFor
EndIf

Return cImpLinha //(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CabPadInst³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Cabecalho de Instrumentos ou Padrao Sec.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CabPadInst(cpoc)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cOpc == "I" - Instrumento Utilizado / "P" - Padrao Secund. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CabPadInst(cOpc)

//          1         2         3         4         5         6         7         8         9         0         1         2         3
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//|      ESCALA        |        PONTO       |  INSTRUMENTO UTIL.  |  VALIDADE  |  INCERTEZA  |  CERTIFICADO  |      LABORATORIO     |

If cOpc == "I"
	Ole_SetDocumentVar(oWord,"Adv_Tema",OemToAnsi(STR0036))
	Ole_SetDocumentVar(oWord,"Adv_PadIns",OemToAnsi(STR0038))
Else
	Ole_SetDocumentVar(oWord,"Adv_Tema",OemToAnsi(STR0037))
	Ole_SetDocumentVar(oWord,"Adv_PadIns",OemToAnsi(STR0039))
EndIf

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³U_R280CM()  ³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Resultado Confirma‡ao Metrologica por Escala       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R280CM()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R280CM()

/*
   ================================================================================================================
   |                                           CONFIRMACAO METROLOGICA                                            |
   ================================================================================================================
   |       ESCALA       |   INCERTEZA    | ERRO SISTEMATICO |    EXATIDAO     |    ADEQUACAO    | ACEITABILIDADE  |
   |--------------------------------------------------------------------------------------------------------------|
   |  1234567890123456  |   1234567890   |   1234567890     |  Rejeitado      |   Rejeitado     |  Rejeitado      |
   |--------------------------------------------------------------------------------------------------------------|
*/

Local nCntFor := 0, nCntFor2 := 0        // Contadores
Local nIncTotEsc	:= 0
Local nErrSisEsc	:= 0
Local lExatEsc		:= .t.
Local lAceiEsc		:= .t.
Local lAdeqEsc		:= .t.
Local nNumDec		:= 0    // Numero de casas para exibir os valores.
Local cValor          // Nominal com maior numero de casas decimais na Escala
Local aResEsc		:= {}
Local aRetorno		:= {}
Local oIncTot  
Local lCabConf		:= .t.
Local nConf			:= 0
If !lCertif
	M->QM6_INSTR := QM6->QM6_INSTR
	M->QM6_REVINS := QM6->QM6_REVINS
	M->QM6_DATA  := QM6->QM6_DATA
	M->QM6_REPEPR := QM6->QM6_REPEPR
Endif	

nCntFor2 := 1
cEscala := aMedicoes[nCntFor2,nPosEsc]
lCabConf := .t.
nConf := 0
Do while nCntFor2 <= Len(aMedicoes)
	nConf++
	If aMedicoes[nCntFor2,nPosGer,1,6] == "1"
		aResult := {}
		Do while nCntFor2<= Len(aMedicoes)
			If cEscala == aMedicoes[nCntFor2,nPosEsc]
			    aRetorno := a140Calc(nCntFor2,.t.)
       			If Len(aRetorno) == 2
               		Aadd( aResult, aRetorno[2] )
       			Elseif Len(aRetorno) == 4
               		Aadd( aResult, aRetorno[2] )
               		Aadd( aResult, aRetorno[4] )
       			Else
               		Aadd( aResult, aRetorno[1] )
       			EndIf
				nCntFor2++
			Else
            	exit
			EndIf
		EndDo
		If len(aResult) > 0
			nIncTotEsc := QmtNum(aResult[1,5]) // Incerteza Total do Primeiro Ponto
			nErrSisEsc := QmtNum(aResult[1,2]) // Desvio M‚dio do Primeiro Ponto
			lExatEsc := aResult[1,7] // Exatid„o do Primeiro Ponto
			lAceiEsc := aResult[1,8] // Aceita‡„o do Primeiro Ponto
			lAdeqEsc := aResult[1,9] // Adequa‡„o ao Uso do Primeiro Ponto
			For nCntFor := 1 to Len(aResult)
				nIncTotEsc := If(QmtNum(aResult[nCntFor,5]) > nIncTotEsc, QmtNum(aResult[nCntFor,5]), nIncTotEsc)
				nErrSisEsc := If(QmtNum(aResult[nCntFor,2]) > nErrSisEsc, QmtNum(aResult[nCntFor,2]), nErrSisEsc)
				lExatEsc := If(lExatEsc,If(aResult[nCntFor,7],.t.,.f.),.f.)
				lAceiEsc := If(lAceiEsc,If(aResult[nCntFor,8],.t.,.f.),.f.)
				lAdeqEsc := If(lAdeqEsc,If(aResult[nCntFor,9],.t.,.f.),.f.)
			Next

			// Procura valor nominal com maior numero de casas decimais na escala
			nNumDec := 0
			For nCntFor := 1 to len(aMedicoes)
				If cEscala == aMedicoes[nCntFor,nPosEsc]
					If QA_NumDec(aMedicoes[nCntFor,nPosEsp]) >= nNumDec
						nNumDec := QA_NumDec(aMedicoes[nCntFor,nPosEsp])
						cValor := aMedicoes[nCntFor,nPosEsp]
					EndIf
				EndIf
			Next nCntFor

			If lCabConf
				Ole_ExecuteMacro(oWord,"MtFzParag") // Pula tabela e faz paragrafo
				Ole_ExecuteMacro(oWord,"MtCabConfMet")  // Imprime cabecalho de Confirmacao Metrologica
				lCabConf := .f.
			EndIf  

			Ole_SetDocumentVar(oWord,"Adv_EscConf"+Alltrim(Str(nConf)),cEscala)

			If cValor <> NIL
				@ 5000,5000 SAY oIncTot PROMPT nIncTotEsc PICTURE QMT140Pics("nIncTotEsc",cValor,.t.)
				Ole_SetDocumentVar(oWord,"Adv_IncC"+Alltrim(Str(nConf)),oIncTot:cCaption)
			Endif

			If cValor <> NIL
				@ 5000,5000 SAY oErroSis PROMPT nErrSisEsc PICTURE QMT140Pics("nErrSisEsc",cValor,.t.)
				Ole_SetDocumentVar(oWord,"Adv_ErroConf"+Alltrim(Str(nConf)),oErroSis:cCaption)
			Endif	

			Ole_SetDocumentVar(oWord,"Adv_ExtConf"+Alltrim(Str(nConf)),If(lExatEsc,OemToAnsi(STR0041),OemToAnsi(STR0042)))
			Ole_SetDocumentVar(oWord,"Adv_AdeConf"+Alltrim(Str(nConf)),If(lAdeqEsc,OemToAnsi(STR0041),OemToAnsi(STR0042)))
			Ole_SetDocumentVar(oWord,"Adv_AceiConf"+Alltrim(Str(nConf)),If(lAceiEsc,OemToAnsi(STR0041),OemToAnsi(STR0042)))

			aadd(aResEsc,{nIncTotEsc,nErrSisEsc,lExatEsc,lAdeqEsc,lAceiEsc})
			Ole_ExecuteMacro(oWord,"MtIncConfMed")
		EndIf
	Else
        nCntFor2++
	EndIf
	
	If nCntFor2 <= Len(aMedicoes)
       cEscala := aMedicoes[nCntFor2,nPosEsc]
 	EndIf
EndDo

// Imprime a Confirmacao Metrologica do Instrumento

If len(aResEsc) > 0
//	Ole_Executemacro(oWord,"MtPulaTab") 
	nIncTotEsc := 0
	nErrSisEsc := 0
	lExatEsc := .t.
	lAceiEsc := .t.
	lAdeqEsc := .t.
	For nCntFor := 1 to Len(aResEsc)
		nIncTotEsc	:= If(aResEsc[nCntFor,1] > nIncTotEsc, aResEsc[nCntFor,1], nIncTotEsc)
		nErrSisEsc	:= If(aResEsc[nCntFor,2] > nErrSisEsc, aResEsc[nCntFor,2], nErrSisEsc)
		lExatEsc	:= If(lExatEsc,If(aResEsc[nCntFor,3],.t.,.f.),.f.)
		lAdeqEsc	:= If(lAdeqEsc,If(aResEsc[nCntFor,4],.t.,.f.),.f.)
		lAceiEsc	:= If(lAceiEsc,If(aResEsc[nCntFor,5],.t.,.f.),.f.)
	Next nCntFor

	Ole_SetDocumentVar(oWord,"Adv_GerExt",If(lExatEsc,OemToAnsi(STR0041),OemToAnsi(STR0042)))
	Ole_SetDocumentVar(oWord,"Adv_GerAde",If(lAdeqEsc,OemToAnsi(STR0041),OemToAnsi(STR0042)))
	Ole_SetDocumentVar(oWord,"Adv_GerAcei",If(lAceiEsc,OemToAnsi(STR0041),OemToAnsi(STR0042)))
	li++
	Ole_Executemacro(oWord,"MtConfInstr")
EndIf

Return(Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR280CInc³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Cabecalho de Medicoes com Incerteza                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MTR280CINC()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cText                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR280CInc(cText,nLin)

Local nOrd := 0
Local nRec := 0

If cText == Nil
	cText := Space(1)
EndIf

If lPrimeira
	Ole_ExecuteMacro(oWord,"MtCabUni")
	nSomE++
Endif	
OLE_SetDocumentVar( oWord, "Adv_Escals"+Alltrim(Str(nSomE)),AllTrim(aMedicoes[nLin,nPosEsc])+" - "+AllTrim(aMedicoes[nLin,nPosGer,1,11])) 		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Unidade de madida, valor minimo e maximo da escala    ³
//³    Valor Minimo: 9999999999    Valor Maximo: 9999999999       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nRec := QM9->(recno())
nOrd := QM9->(IndexOrd())
QM9->(dbSetOrder(1))
If QM9->(dbSeek(xFilial("QM9")+aMedicoes[nLin,nPosEsc] + Inverte(aMedicoes[nLin,nPosGer,1,11])))
//	AllTrim( aMedicoes[nLin,nPosGer,1,11] ) 
	If lPrimeira
		Ole_ExecuteMacro(oWord,"MtVMinMax") //Imprime Valor Minimo-Maximo
	Endif	
	OLE_SetDocumentVar( oWord, "Adv_ValMin"+Alltrim(Str(nSomE)),QM9->QM9_ESCALI)
	OLE_SetDocumentVar( oWord, "Adv_ValMax"+Alltrim(Str(nSomE)),QM9->QM9_ESCALF)
	OLE_SetDocumentVar( oWord, "Adv_UniEsc"+Alltrim(Str(nSomE)),IIf(SAH->(dbSeek(xFilial("SAH")+QM9->QM9_UNIMED)),AllTrim(SAH->AH_UMRES),Space(9)))
EndIf   

QM9->(dbGoto(nRec))
QM9->(dbSetOrder(nOrd))
Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR280CEsp³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Cabecalho de Medicoes em relacao a valores         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MTR280CEsp()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto ³ 20/06/00 ³ Alteracoes para calibrar Tipo de Calibracao Re- ³±±
±±³          ³          ³ logio.                        				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MTR280CEsp(nLin,nCntForM)

//          1         2         3         4         5         6         7         8         9         0         1         2         3
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//|   ESCALA            |REV|      PADRAO      |   REV   |  V.Inicial   |Dif.       |%         |V.Final     |Dif.     |%           |

Ole_ExecuteMacro(oWord,"MtCabValores") //Cabecalho valores encontrados / valores individuais
                                 
If aMedicoes[nLin,nPosGer,1,2] $ "2,5,3,8,9"  // Se nao for tipo simples ou calibrador, imprime final
	Ole_ExecuteMacro(oWord,"MtCabVlrFin") //Cabecalho valores encontrados / valores individuais - Valores Finais
Else
	Ole_ExecuteMacro(oWord,"TabR030CEsp")
EndIf
/*
If nTotCol == 4
	If nCntForM <= 2
		@ li   , 000 PSAY "|"
		@ li   , 004 PSAY STR0015 // "Subida"
		@ li   , 022 PSAY "|"
		@ li   , 026 PSAY "|"
		@ li   , 045 PSAY "|"
		@ li   , 055 PSAY "|"
		@ li   , 070 PSAY "|"								
		@ li   , 082 PSAY "|"
		@ li   , 093 PSAY "|"
		@ li   , 106 PSAY "|"		
		@ li   , 117 PSAY "|"				
		@ li   , 131 PSAY "|"
	Else                     
		@ li   , 000 PSAY "|"	
		@ li   , 004 PSAY STR0016 // "Descida"
		@ li   , 022 PSAY "|"
		@ li   , 026 PSAY "|"
		@ li   , 045 PSAY "|"
		@ li   , 055 PSAY "|"
		@ li   , 070 PSAY "|"								
		@ li   , 082 PSAY "|"
		@ li   , 093 PSAY "|"
		@ li   , 106 PSAY "|"		
		@ li   , 117 PSAY "|"				
		@ li   , 131 PSAY "|"
	EndIf
	li++
EndIf
  */
nEsc34 := nEsc34 + 1  
Ole_SetDocumentVar(oWord,"Adv_Esc"+Alltrim(Str(nEsc34)),aMedicoes[nLin,nPosEsc])
Ole_SetDocumentVar(oWord,"Adv_EscRv"+Alltrim(Str(nEsc34)),aMedicoes[nLin,nPosGer,1,11])	
Ole_SetDocumentVar(oWord,"Adv_CodPad"+Alltrim(Str(nEsc34)),aMedicoes[nLin,nPosPad])	
Ole_SetDocumentVar(oWord,"Adv_CodRv"+Alltrim(Str(nEsc34)),aMedicoes[nLin,nPosGer,1,12])	

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R280Min   ³ Autor ³ Wanderley Goncalves Jr³ Data ³ 20.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula Valor Minimo                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R280Min(nLin)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nLin -> Linha no aMedicoes                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto ³ 20/06/00 ³ Alteracoes para calibrar Tipo de Calibracao Re- ³±±
±±³          ³          ³ logio.                        				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R280Min(nLin)

Local nVal := 0

If aMedicoes[nLin,nPosGer,1,2] $ "1,2,3,9"
	QM3->(DbSetOrder(1))
	If QM3->(DbSeek(xFilial("QM3")+aMedicoes[nLin,nPosPad]+Inverte(aMedicoes[nLin,nPosGer,1,12])))
		nVal := SuperVal(QM3->QM3_ESPEC) - SuperVal(QM3->QM3_TOLER)
	Else
		nVal := 0
	EndIf
ElseIf aMedicoes[nLin,nPosGer,1,2] $ "4,8"
	QMG->(DbSetOrder(1))
	If QMG->(DbSeek(xFilial("QMG")+QM6->QM6_INSTR+QM6->QM6_REVINS+aMedicoes[nLin,nPosPad]))
		nVal := SuperVal(QMG->QMG_LIE)
	Else
		nVal := 0
	EndIf
ElseIf aMedicoes[nLin,nPosGer,1,2] $ "5"
	QMA->(DbSetOrder(1))
	If QMA->(xFilial("QMA")+aMedicoes[nLin,nPosEsc]+aMedicoes[nLin,nPosGer,1,11]+aMedicoes[nLin,nPosPad])
		nVal := SuperVal(aMedicoes[nLin,nPosEsp]) - SuperVal(QMA->QMA_TOLER)
	Else
		nVal := 0
	EndIf
EndIf

Return(nVal)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R280Max   ³ Autor ³ Wanderley Goncalves Jr³ Data ³ 20.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula Valor Minimo                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R280Max(nLin)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nLin -> Linha no aMedicoes                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto ³ 20/06/00 ³ Alteracoes para calibrar Tipo de Calibracao Re- ³±±
±±³          ³          ³ logio.                        				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R280Max(nLin)

Local nVal := 0

If aMedicoes[nLin,nPosGer,1,2] $ "1,2,3,9"
	QM3->(DbSetOrder(1))
	If QM3->(DbSeek(xFilial("QM3")+aMedicoes[nLin,nPosPad]+Inverte(aMedicoes[nLin,nPosGer,1,12])))
		nVal := SuperVal(QM3->QM3_ESPEC) + SuperVal(QM3->QM3_TOLER)
	Else
		nVal := 0
	EndIf
ElseIf aMedicoes[nLin,nPosGer,1,2] $ "4,8"
	QMG->(DbSetOrder(1))
	If QMG->(DbSeek(xFilial("QMG")+QM6->QM6_INSTR+QM6->QM6_REVINS+aMedicoes[nLin,nPosPad]))
		nVal := SuperVal(QMG->QMG_LSE)
	Else
		nVal := 0
	EndIf
ElseIf aMedicoes[nLin,nPosGer,1,2] $ "5"
	QMA->(DbSetOrder(1))
	If QMA->(xFilial("QMA")+aMedicoes[nLin,nPosEsc]+aMedicoes[nLin,nPosGer,1,11]+aMedicoes[nLin,nPosPad])
		nVal := SuperVal(aMedicoes[nLin,nPosEsp]) + SuperVal(QMA->QMA_TOLER)
	Else
		nVal := 0
	EndIf
EndIf

Return(nVal)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R280Dif   ³ Autor ³ Wanderley Goncalves Jr³ Data ³ 20.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula Diferenca entre Valor Encontrado e Nominal ou      ³±±
±±³          ³ limites                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R280Dif(nLin,nMin,nMax)                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nVal -> Valor Informado na Medicao                         ³±±
±±³          ³ nLin -> Linha de posicao no aMedicoes                      ³±±
±±³          ³ nMin -> Limite Minimo (para calculo c/relacao aos limites) ³±±
±±³          ³ nMax -> Limite Maximo (para calculo c/relacao aos limites) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R280Dif(nVal,nLin,nMin,nMax)

Local nValor    := 0
Local nRegistro := QM9->(recno())
Local nOrdem    := QM9->(IndexOrd())

QM9->(DbSetOrder(1))
QM9->(DbSeek(xFilial("QM9")+aMedicoes[nLin,nPosEsc]+Inverte(aMedicoes[nLin,nPosGer,1,11])))

If QM9->QM9_PERRO == '1'   && % Erro em relacao ao especificado
   Do Case
   Case SuperVal(aMedicoes[nLin,nPosEsp]) == 0
		nValor := 0
   Otherwise
      nValor := Abs(nVal - SuperVal(aMedicoes[nLin,nPosEsp]))
   EndCase
Else                           && % Erro em relacao ao especificado +/- Tolerancia
   Do Case
   Case nVal >= nMin .and. nVal <= nMax
        nValor := 0
   otherwise
        If nVal < nMin
           nValor := Abs(Abs(nMin) - abs(nVal))
        ElseIf nVal > nMax
           nValor := Abs(Abs(nVal) - Abs(nMax))
        EndIf
   EndCase
EndIf

QM9->(DbSetOrder(nOrdem))
QM9->(DbGoto(nRegistro))

return(nValor)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R280PerDif³ Autor ³ Wanderley Goncalves Jr³ Data ³ 20.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula Diferenca entre Valor Encontrado e Nominal ou      ³±±
±±³          ³ limites em percentual                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R280PerDif(nVal,nLin,nMin,nMax)                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nVal -> Valor Informado na Medicao                         ³±±
±±³          ³ nLin -> Linha de posicao no aMedicoes                      ³±±
±±³          ³ nMin -> Limite Minimo (para calculo c/relacao aos limites) ³±±
±±³          ³ nMax -> Limite Maximo (para calculo c/relacao aos limites) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R280PerDif(nVal,nLin,nMin,nMax)

Local nValor := 0
Local nOrdem := QM9->(Indexord())
Local nRegistro := QM9->(recno())
Local lc_valor := 0

QM9->(DbSetOrder(1))
QM9->(DbSeek(xFilial("QM9")+aMedicoes[nLin,nPosEsc]+Inverte(aMedicoes[nLin,nPosGer,1,11])))
If QM9->QM9_PERRO == '1'   && % Erro em relacao ao especificado
   Do Case
   Case SuperVal(aMedicoes[nLin,nPosEsp]) == 0
		nValor := 0
   Otherwise
      nValor := ( (nVal - SuperVal(aMedicoes[nLin,nPosEsp])) / SuperVal(aMedicoes[nLin,nPosEsp]) ) * 100
   EndCase
Else  // % Erro em relacao ao especificado +/- Tolerancia
   Do Case
   Case nVal >= nMin .and. nVal <= nMax
        lc_valor := 0
   otherwise
        If nVal < nMin
           nValor := Abs(Abs(nMin) - abs(nVal)) / abs(nMin) * 100
        ElseIf nVal > nMax
           nValor := Abs(Abs(nVal) - Abs(nMax)) / abs(nMax) * 100
        EndIf
   EndCase
EndIf

QM9->(DbSetOrder(nOrdem))
QM9->(DbGoto(nRegistro))

return(nValor)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R280NumCol³ Autor ³ Wanderley Goncalves Jr³ Data ³ 22.08.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna numero de colunas de medições                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R280NumCol()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nCntFor -> Linha da array aMedicoes posicionada            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto ³ 20/06/00 ³ Alteracoes para calibrar Tipo de Calibracao Re- ³±±
±±³          ³          ³ logio.                        				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R280NumCol(nCntFor)

Local nTotCol := 1

If aMedicoes[nCntFor,nPosGer,1,2] $ "1,4"
	nTotCol := 1
Elseif aMedicoes[nCntFor,nPosGer,1,2] $ "2,5,8" 
   If aMedicoes[nCntFor,nPosGer,1,3] <> "A"
		nTotCol := 2
	Else 
		nTotCol := 1	
	Endif	
Elseif aMedicoes[nCntFor,nPosGer,1,2] $ "3,9"
    If aMedicoes[nCntFor,nPosGer,1,3] <> "A"
		nTotCol := 4
	Else 
		nTotCol := 1
	Endif	
EndIf

Return(nTotCol)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R280AnaUP ³ Autor ³ Wanderley Goncalves Jr³ Data ³ 03.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao da Analise das Ultimas Pecas Produzidas          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R280AnaUP()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R280AnaUP()

Local cArqTxt := "R304"+cEmpAnt+cFilAnt+".TXT"
Local cTitulo := TITULO
Local Tamanho := " "

TITULO := OemToAnsi(STR0040)//"ANALISE DAS ULTIMAS PECAS PRODUZIDAS"

If li > 55
   Cabec( Titulo, Cabec1, Cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18))
	li+=2
EndIf
U_R280IMPTXT(cArqTxt,2)

TITULO := cTitulo

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³r280ITB   ³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o item Incerteza do Tipo B relacionado com o instr.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ r280ITB()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r280ITB()

Local nUi := 0
Local nUc := 0
Local nUa := 0
Local nUaTot := 0
Local nUcTot := 0		
Local nUiTot := 0
Local nVeffTot := 0
Local aVeff    := {}
Local nCnt     := 0
Local nCntFor  := 1
Local nCntFor2 := 0
Local cEscala := " "
Local cPonto  := " "	
Local lCab		:= .T.
/*
	       1         2         3         4         5         6         7         8         9        10        11        12        13      
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
====================================================================================================================================
|                                          INCERTEZA TIPO B                                                                        |
====================================================================================================================================
| Cod. Incerteza | Simbolo  | Fonte                        |Valor Incert.|Distr.| Divisor  |Coef.Sensib.| Incer.Calc. |Graus Liber.|
------------------------------------------------------------------------------------------------------------------------------------
|1234567890123456|1234567890|123456789012345678901234567890|1234567890   |  X   |1234567890|1234567890  | 1234567890  | 1234567890 |
|----------------------------------------------------------------------------------------------------------------------------------|
*/		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ nPosITB, declarada como Private na funcao chamadora.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(aMedicoes[nCntFor,nPosITB,1,1]) 
	For nCntFor := 1 to Len(aMedicoes) 
		li+= 2
		lCab := .T.
		nUi := 0
		nUc := 0
		nUa := 0
		nUaTot := 0
		nUcTot := 0		
		nUiTot := 0
		nVeffTot := 0
		aVeff    := {}
		
		For nCntFor2 := 1 to Len(aMedicoes[nCntFor,nPosITB])
			Ole_ExecuteMacro(oWord,"MtFzParag") // Pula tabela e faz paragrafo
			Ole_Executemacro(oWord,"MtSomIncB")

			If Empty(aMedicoes[nCntFor,nPosITB,nCntFor2,1])
				Loop
			EndIf
			
			If lCab
				Ole_ExecuteMacro(oWord,"MtCabIncB")
            Endif
//          1         2         3         4         5         6         7         8         9         0         1         2         3
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//  Cod. Incertid.   Simbolo    Fuente                        Valor Incert. Distr.  Divisor   Coef.Sensib.  Incer.Calc.  Grados Liber.
//                   Uc         Inc. Estand.Combinada                       Nor               "
//                   U          Inc. Expandida                              Nor K             "
//                   Ui         Inc. Expandida                              Nor Kp                                      "

			If aMedicoes[nCntFor,nPosEsc] <> cEscala .or.;
			   aMedicoes[nCntFor,nPosPad] <> cPonto
				cEscala := aMedicoes[nCntFor,nPosEsc]
				cPonto := aMedicoes[nCntFor,nPosPad]
				Ole_SetDocumentVar(oWord,"Adv_EscInB"+Alltrim(Str(nCntFor)),cEscala)
				Ole_SetDocumentVar(oWord,"Adv_PtoTpB"+Alltrim(Str(nCntFor)),cPonto)				
				Ole_ExecuteMacro(oWord,"MtCab2IncB") 
			EndIf
			If lCab
				lCab := .F.
			EndIf          

			Ole_SetDocumentVar(oWord,"Adv_CodTpB"+Alltrim(Str(nCntFor)),PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,1],16))
			Ole_SetDocumentVar(oWord,"Adv_SimbB"+Alltrim(Str(nCntFor)),PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,2],10))			
			Ole_SetDocumentVar(oWord,"Adv_FontB"+Alltrim(Str(nCntFor)),PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,3],30))			
			Ole_SetDocumentVar(oWord,"Adv_VlTpB"+Alltrim(Str(nCntFor)),PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,4],10))			
			Ole_SetDocumentVar(oWord,"Adv_DistrB"+Alltrim(Str(nCntFor)),PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,5],01))			
			Ole_SetDocumentVar(oWord,"Adv_DiviB"+Alltrim(Str(nCntFor)),PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,6],10))			
			Ole_SetDocumentVar(oWord,"Adv_CoefB"+Alltrim(Str(nCntFor)),PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,7],10))			
			Ole_SetDocumentVar(oWord,"Adv_IncerB"+Alltrim(Str(nCntFor)),PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,8],10))			
			Ole_SetDocumentVar(oWord,"Adv_GrausB"+Alltrim(Str(nCntFor)),PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,9],10))			
			nUi := aMedicoes[nCntFor,nPosITB,nCntFor2,8] // Coef. Sensib.
			If At(aMedicoes[nCntFor,nPosITB,nCntFor2,8],".") == 0
				aMedicoes[nCntFor,nPosITB,nCntFor2,8] := StrTran(aMedicoes[nCntFor,nPosITB,nCntFor2,8],".",",")			
			Endif
			nUi := Val(nUi)^2
			nUiTot := nUiTot + nUi
			If SuperVal(aMedicoes[nCntFor,nPosITB,nCntFor2,9]) <> 0 // Grau Liber.
				nUaTot := nUaTot + nUi
				aAdd(aVeff, ;
				{ Val(Str(SuperVal(aMedicoes[nCntFor,nPosITB,nCntFor2,8]))), ; // Coef. Sensib.
				Val(Str(SuperVal(aMedicoes[nCntFor,nPosITB,nCntFor2,9]))) }) // Grau Liber.
			EndIf
			If nCntFor2 == Len(aMedicoes[nCntFor,nPosITB])
				nUc := SQRT(nUiTot)
				nUa := StrTran(aMedicoes[nCntFor,12,1,17,2],".",",")//SQRT(nUaTot)
				If Val(nUa) > (nUc / 2)
					nVeffTot := 0
					For nCnt := 1 To Len(aVeff)
						If aVeff[nCnt,2] > 0
							nVeffTot := nVeffTot + ( aVeff[nCnt,1]^4 / aVeff[nCnt,2] )
						EndIf
					Next
					If nVeffTot > 0
						nVeffTot := nUc^4 / nVeffTot
					EndIf
				EndIf
				Ole_SetDocumentVar(oWord,"Adv_Coef2B"+Alltrim(Str(nCntFor)),Padr(AllTrim(Str(nUc)),12))
				Ole_SetDocumentVar(oWord,"Adv_Coef3B"+Alltrim(Str(nCntFor)),Padr(AllTrim(Str(nUc*2)),12))				
				If nCntFor2 <> 1 .and. SuperVal(aMedicoes[nCntFor,nPosITB,nCntFor2,9]) <> 1
					Ole_SetDocumentVar(oWord,"Adv_Graus2B"+Alltrim(Str(nCntFor)),Padr(AllTrim(Str(nVeffTot)),12))				
				Else
					Ole_SetDocumentVar(oWord,"Adv_Graus2B"+Alltrim(Str(nCntFor)),Space(1))								
				Endif	
				Ole_ExecuteMacro(oWord,"MtItIncB")
			EndIf
		Next
	Next
EndIf

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR030SubCab³ Autora³ Denis Martins        ³ Data ³         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime SubCabecalho de Medicoes com Incerteza para Ins-   ³±±
±±³          ³ trumentos.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³   r030SubCab()                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cText                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MTR030SubCab(cText,nLin)

If cText == Nil
	cText := Space(1)
EndIf

Ole_SetDocumentVar(oWord, "Adv_Texts"+Alltrim(Str(nSomE))	,Space(1))  //cText	

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³R280InsEsc³ Autora³ Iuri Seto           	³ Data ³ 15/05/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o Codigo do Instrumento que se refere a Malha      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 : Codigo do Instrumento Malha     					  ³±±
±±³          ³ ExpC2 : Escala do Instrumento Malha     					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ ExpC1 : Código do Instrumento Filho                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ QMTR280													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R280InsEsc(cInstr,cEscala)
Local cOldAlias := Select()
Local nOrdem := IndexOrd()
Local nRegistro := Recno()
Local nQM2Ord := QM2->(IndexOrd())
Local nQM2Reg := QM2->(Recno())
Local cInsEsc

cInsEsc := " "

dbSelectArea("QM2")
dbSetOrder(7)
If QM2->(dbSeek(xFilial("QM2")+"0"+cInstr+cEscala))
	cInsEsc := QM2->QM2_INSTR	
EndIf
dbSetOrder(nQM2Ord)
dbGoto(nQM2Reg)

dbSelectArea(cOldAlias)
dbSetOrder(nOrdem)
dbGoto(nRegistro)

Return(cInsEsc)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR280REsc³Autora ³ Denis Martins         ³ Data ³ 21/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Rodape para Tipo de Calibracao Relogio             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MTR280REsc()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nCntFor, nCntForM                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR280REsc(aRelResu,cEscala,nCntFor)
Local nIndice
Local cFe
Local cfges
Local cfu

If !EMPTY(cEscala)
/*       1         2         3         4         5         6         7         8         9       110       120        
   456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
   ==================================================================================================================
   |                                                Parametros de Analise                                           |
   ==================================================================================================================
   | fe   | Desvio Maximo no sentido crescente              								       |  1234567890    |
   | fges | Desvio Total ( crescente / decrescente )                                               |  1234567890    |
   | fu   | Erro de Retorno                                                                        |  1234567890    |
   ==================================================================================================================
   | Histerese                                                                                     |  1234567890    |
   ==================================================================================================================
*/
	nIndice := ASCAN(aRelResu,{ |x| x[1] == cEscala})

	@ 5000,5000 SAY cfe PROMPT aRelResu[nIndice,6] PICTURE QMT140Pics("aRelResu[nIndice,6]",;
														 aMedicoes[nCntFor,nPosEsp],.t.)
	
	@ 5000,5000 SAY cfges PROMPT aRelResu[nIndice,7] PICTURE QMT140Pics("aRelResu[nIndice,7]",;
														 aMedicoes[nCntFor,nPosEsp],.t.)
	
	@ 5000,5000 SAY cfu PROMPT aRelResu[nIndice,8] PICTURE QMT140Pics("aRelResu[nIndice,8]",;
														 aMedicoes[nCntFor,nPosEsp],.t.)
	
	@ 5000,5000 SAY cHisters PROMPT aRelResu[nIndice,10] PICTURE QMT140Pics("aRelResu[nIndice,10]",;
														 aMedicoes[nCntFor,nPosEsp],.t.)

	nSomPA++
	Ole_SetDocumentVar(oWord,"Adv_DMaxc"+Alltrim(Str(nSomPA)),cFe:cCaption)
	Ole_SetDocumentVar(oWord,"Adv_DTotal"+Alltrim(Str(nSomPA)),cFges:cCaption)
	Ole_SetDocumentVar(oWord,"Adv_ErRet"+Alltrim(Str(nSomPA)),cFu:cCaption)
	Ole_SetDocumentVar(oWord,"Adv_Histere"+Alltrim(Str(nSomPA)),cHisters:cCaption)

	Ole_ExecuteMacro(oWord,"MtParAnalise") //Parametros de Analise

EndIf
	
Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR280REsP³Autora ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Rodape para Tipo de Calibracao Pressao             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MTR280REsP()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nCntFor, nCntForM                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR280REsP(aRelResu,cEscala,nCntFor)
Local nIndice

If !EMPTY(cEscala)
/*       1         2         3         4         5         6         7         8         9       110       120        
   456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
   ==================================================================================================================
   | Histerese                                                                                     |  1234567890    |
   ==================================================================================================================
*/
	nIndice := ASCAN(aRelResu,{ |x| x[1] == cEscala})

	//"Histerese"
	@ 5000,5000 SAY cHister PROMPT aRelResu[nIndice,10]PICTURE QMT140Pics("aRelResu[nIndice,10]",;
														 aMedicoes[nCntFor,nPosEsp],.t.)

	Ole_SetDocumentVar(oWord,"Adv_Hister"+Alltrim(Str(nSomEsc)),cHister:cCaption)	
	Ole_ExecuteMacro(oWord,"MtCabHiste")														 
EndIf
	
Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QMR280ICabec1ºAutor  ³Denis Martins       º Data ³             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime cabecalho com dados do instrumento                  	 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QMTR280                                                    	 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function QMR280ICabec1()
	OLE_SetDocumentVar( oWord, "Adv_Instr"		,Alltrim(QM2->QM2_INSTR)+" - "+Alltrim(QM2->QM2_REVINS) ) 
	OLE_SetDocumentVar( oWord, "Adv_VCal"		,QM2->QM2_VALDAF) 
	OLE_SetDocumentVar( oWord, "Adv_Emissor"	,QM2->QM2_RESP) 
	OLE_SetDocumentVar( oWord, "Adv_Semana"		,RetSem(QM2->QM2_VALDAF)) 
	OLE_SetDocumentVar( oWord, "Adv_Familia"	,QM2->QM2_TIPO) 
	OLE_SetDocumentVar( oWord, "Adv_Depto"		,QM2->QM2_DEPTO) 
	OLE_SetDocumentVar( oWord, "Adv_Local"		,QM2->QM2_LOCAL) 
	OLE_SetDocumentVar( oWord, "Adv_Resp"		,QM2->QM2_RESP) 
	OLE_SetDocumentVar( oWord, "Adv_Fabr"		,QM2->QM2_NUMFAB)
	OLE_SetDocumentVar( oWord, "Adv_NomFabr"	,QM2->QM2_FABR) 
	OLE_SetDocumentVar( oWord, "Adv_Tensao"		,QM2->QM2_TALIM)
	OLE_SetDocumentVar( oWord, "Adv_Leit"		,QM2->QM2_LEIT) 
	OLE_SetDocumentVar( oWord, "Adv_Serie"		,QM2->QM2_NSEFAB)
	OLE_SetDocumentVar( oWord, "Adv_Potencia"	,QM2->QM2_POT)   
	OLE_SetDocumentVar( oWord, "Adv_Leit"		,QM2->QM2_LEIT) 	
	OLE_SetDocumentVar( oWord, "Adv_Custo"		,QM2->QM2_CUSTO)  
	OLE_SetDocumentVar( oWord, "Adv_UsoIni"		,QM2->QM2_USOINI)
	OLE_SetDocumentVar( oWord, "Adv_Freq"		,QM2->QM2_FREQAF) 	 	  
	OLE_SetDocumentVar( oWord, "Adv_Erro"		,QM2->QM2_RESOL) 	
	dbSelectArea("QMP") 
	dbSetOrder(1)
	dbSeek(xFilial("QMP")+QM2->QM2_STATUS)
	OLE_SetDocumentVar( oWord, "Adv_Status"		,QMP->QMP_DESCR) 	  
Return 
