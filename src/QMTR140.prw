/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR140.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE Confirma 1
#DEFINE Redigita 2
#DEFINE Abandona 3

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR140  ³Autora ³ Iuri Seto             ³ Data ³ 27/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Historico de Instrumento                                   ³±±
±±³          ³ Este programa e uma copia do QMTR030 com alteracoes para   ³±±
±±³          ³ impressao de varias calibracoes. Funcoes do QMTR030 sao    ³±±
±±³          ³ usadas por este fonte, ja que nao sofreram modificacoes.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQmt                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL. 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³	MOTIVO DA ALTERACAO					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Denis Martins ³26.12.00³------³Correcao de impressao de STR's(LIE/LSE) ³±± 
±±³              ³        ³------³Substituicao de textos por STR's.       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Qmtr140()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nOpc:=1, oDlg,cTitulo:="",cText1:=""
Private lEnd:=.F.
Private lEdit := .t.	// Para editar os textos
Private aMedicoes := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para montar Get.                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aListBox:={},aMsg:={},aSel:={},aValid:={},aConteudo:={}
Private cPerg1:= "QMR141"
Private Inclui := .T.
Private Altera	:= .T.
Private cCERT

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Janela Principal                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo:=OemToAnsi(STR0001)		//"Historico de Instrumento"
cText1:=OemToAnsi(STR0002)			//"Neste relat¢rio ser  impresso o Historico de Instrumento"


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
			//³ Relat¢rio de Historico de Instrumento                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			U_R140IMP()
			Exit
		Case nOpc==2
			R140Processa()
		Case nOpc==3
			Exit
	EndCase
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura area                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QM6")
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R140Processa ³ Autor ³Wanderley Goncalves³ Data ³ 13/05/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento do QMTR140                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R140Processa()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta tela para digitacao de itens.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
A140Mont()

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³   A140Mont   ³ Autor ³Wanderley Goncalves³ Data ³ 13/05/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta Tela para digitacao dos textos.                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function a140Mont()

Local oListBox,oDlgGet

aListBox := {}
AADD(aListBox," ")
AADD(aListBox,OemToAnsi(STR0003))		//" Texto Final do Certificado "
AADD(aListBox,OemToAnsi(STR0013))		//" Informa‡”es Complementares "
AADD(aListBox,OemToAnsi(STR0004))		//" Impress„o "
AADD(aListBox," ")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa ListBox com opcoes para o array da configuracao          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlgGet TITLE OemtoAnsi(STR0001) FROM  180,110 TO 450,520 PIXEL OF oMainWnd		//"Certificado de Calibracao"
@ 10, 20 SAY Oemtoansi(STR0006)	SIZE 300, 07 OF oDlgGet PIXEL		//"Itens de Configuracao"
@ 26, 18 TO 112, 188 LABEL "" OF oDlgGet PIXEL

@ 33,22 LISTBOX oListBox VAR cVar FIELDS HEADER "" ON DBLCLICK (R140GetList(oListBox)) SIZE 164,76 PIXEL

oListBox:SetArray(aListBox)
oListBox:bLine := { ||{aListBox[oListBox:nAt]}}

DEFINE SBUTTON FROM 115, 132 TYPE 1 ACTION (oDlgGet:End()) ENABLE OF oDlgGet
DEFINE SBUTTON FROM 115, 160 TYPE 2 ACTION (oDlgGet:End()) ENABLE OF oDlgGet

ACTIVATE MSDIALOG oDlgGet CENTERED

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R140GetList ³Autor³ Wanderley Goncalves   ³ Data ³ 05.07.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Get para edicao de Elemento relacionado ao ListBox    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QMTR140                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R140GetList(oListBox)
Local nAt

nAt:=oListBox:nAt

If nAt == 2 .Or. nAt == 3
	R140TEXT(oListBox)
ElseIf nAt == 4

	Pergunte(cPerg1,.T.)
Endif

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R140Text    ³Autor³Wanderley Goncalves    ³ Data ³ 13/05/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Tela para preenchimento do conteudo relacionado com o ³±±
±±³          ³ListBox.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QMTR140                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R140Text(oListBox)

Local cTexto := ""
Local nOpca:=2
Local oFontMet   := TFont():New("Courier New",6,0)
Local oDlgGet2,oTexto
Local oFontDialog:= TFont():New("Arial",6,15,,.T.)

nAt:=oListBox:nAt

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

cNomeArq := "QMR140"+Str(nAt,1)+".TXT"
If ExistBlock("QR030ALT")
	lEdit := ExecBlock("QR030ALT",.F.,.F.,{lEdit})
Endif

While .T.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Le arquivo                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTexto:=MemoRead(cNomeArq)

	DEFINE MSDIALOG oDlgGet2 FROM	62,100 TO 345,610 TITLE  OemToAnsi(STR0006) PIXEL FONT oFontDialog		//"Itens de Configura‡„o"
	@ 003, 004 TO 027, 250 LABEL "" 	OF oDlgGet2 PIXEL
	@ 040, 004 TO 110, 250				OF oDlgGet2 PIXEL

	@ 013, 010 MSGET aListBox[nAt]		  WHEN .F. SIZE 235, 010 OF oDlgGet2 PIXEL

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
±±³Fun‡…o    ³ R140Imp  ³Autora ³ Iuri Seto             ³ Data ³ 27/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Historico de Instrumento                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R140Imp(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R140IMP()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1		:=OemToAnsi(STR0007) // "Este programa ira emitir a rela‡ao de"
Local cDesc2		:=OemToAnsi(STR0020) // "Certificados de Calibra‡„o de acordo com os"
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
Local nIitb			// Imprime Legenda Incerteza do Tipo B
Local nImpH 		// Imprime Historico de Instrimento

Private titulo		:= OemToAnsi(STR0010) //"HISTORICO DE INSTRUMENTO"
Private cabec1		:= ""
Private cabec2		:= ""
Private aReturn	:= { OemToAnsi(STR0011), 1,OemToAnsi(STR0012), 1, 2, 1, "",1 } // "Zebrado"###"Administra‡„o"
Private nomeprog	:="QMTR140"
Private nLastKey	:= 0
Private cPerg		:="QMR140"
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("QMR141",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ nTxtFin := mv_par01 // Imprime Texto Final:    1-Sim 2-Nao   ³
//³ nInfCom := mv_par02 // Imprime Inf.Compl.:     1-Sim 2-Nao   ³
//³ nInfCIn := mv_par03 // Imp.Inf.Compl.Instr.:   1-Sim 2-Nao   ³
//³ nIncs   := mv_par04 // Imp.Nao Conformid.  :   1-Sim 2-Nao   ³
//³ nIOBS   := mv_par05 // Imp.Observacoes     :   1-Sim 2-Nao   ³
//³ nILaudo := mv_par06 // Imp.Laudo           :   1-Sim 2-Nao   ³
//³ nIJInst := mv_par07 // Imp.Just.Cad.Instr. :   1-Sim 2-Nao   ³
//³ nIJCali := mv_par08 // Imp.Just.Calibr.    :   1-Sim 2-Nao   ³
//³ nIManut := mv_par09 // Imp.Manutencoes     :   1-Sim 2-Nao   ³
//³ nIitb   := mv_par10 // Imp.Leg.Inc.Tipo B  :   1-Sim 2-Nao   ³
//³ nImpH   := mv_par11 // Imp.Texto Hist.Ins  :   1-Sim 2-Nao   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nTxtFin := mv_par01
nInfCom := mv_par02
nInfCIn := mv_par03
nIncs   := mv_par04
nIOBS   := mv_par05
nILaudo := mv_par06
nIJInst := mv_par07
nIJCali := mv_par08
nIManut := mv_par09
nIitb	:= mv_par10
nImpH	:= mv_par11

Pergunte("QMR140",.F.)
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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="QMTR140"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,cTamanho)

If nLastKey = 27
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
   Return
Endif

RptStatus({|lEnd| U_MTR140Imp(@lEnd,wnRel,cString,nTxtFin, nInfCom,;
										 nInfCIn,nIncs,nIOBS,nILaudo,nIitb,nImpH)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MtR140Imp³Autora ³ Iuri Seto             ³ Data ³ 27/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Historico de Instrumento                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³  U_MTR140IMP(void)                                           ³±±
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
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto ³ 20/06/00 ³ Alteracoes para calibrar Tipo de Calibracao Re- ³±±
±±³          ³          ³ logio.                        				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MtR140Imp( lEnd, wnRel, cString, nTxtFin,;
						  nInfCom, nInfCIn, nIncs, nIOBS, nILaudo, nIitb, nImpH)

Local Tamanho		:= " "
Local cEscala		:= ""
Local nCntFor		:= 0
Local nCntFor2		:= 0
Local nCntFor3		:= 0
Local nCntForM		:= 0
Local nCntForM2 	:= 0
Local nCont			:= 0
Local cStat			:= ''
Local lCab 			:= .f.
Local cPonto		:= ''
Local nRec			:= 0
Local dData
Local lAchou 		:= .f.
Local cChave 		:= ''
Local nLimMin		:= 0
Local nLimMax		:= 0
Local cText 		:= ''
Local lDuplica 	:= .t.
Local nRecQM7     := 0  // Guardo numero do registro atual
Local nVezes 		:= 0
Local aRelResu	:= {}
Local cChaveQM2 := ""
Local cChaveQM6 := ""
Local cChaveQMR := ""   
Local lImpMan	:= .F.
Local cFiltro	:= ""
Local nCntForMAnt := 0
Local aArea:={Alias(),IndexOrd(),Recno()}
Local ni := 1
Local nx := 1
Local nRQM6 		:= 0
Local lImpOk		:= .F.
Local lQMR140R 		:= ExistBlock("QMR140R")
Local lqmt140EI 	:= ExistBlock("qmt140EI")

Private lRepro	  := .F.	
Private	cIndice	  := ""
Private nIndis
Private	cInstrMan	:= ""
Private aResult		:= {}
Private cApro		:= GetMv("MV_QAPROV")
Private cRepro		:= GetMv("MV_QREPRO")
Private cCondi		:= GetMv("MV_QAPCON")
Private cFreqs		:= GetMv("MV_QFREQAF")
Private cCalInc		:= GetMv("MV_QCALINC")
Private cIncRR		:= GetMv("MV_QINCRR")

Private cTitEsc		:= QaTit("QMR_ESCALA",12,.f.)
Private cTitEscal	:= QaTit("QMR_ESCALA",22,.t.)
Private cTitPro		:= QaTit("QMR_TOLPRO",12)
Private cTitRedut	:= QaTit("QMR_REDUT",12)
Private cTitInpr	:= QaTit("QMR_INPERM",12)
Private cTitPrec	:= QaTit("QMR_PREC",12)
Private cInstQMR	:= QaTit("QMR_INSTR",12)

Private cTitCalib	:= QaTit("QM9_TIPAFE",22,.t.)

Private cTituPad	:= QaTit("QM3_PADRAO",6)
Private cTitRevPad	:= QaTit("QM3_REVPAD",2)
Private cTitEspec	:= QaTit("QM3_ESPEC",12)
Private cTitToler	:= QaTit("QM3_TOLER",08)
Private cTitUni		:= QaTit("QM3_UNIMED",8)
Private cTitCer		:= QaTit("QM3_CERTIF",08)
Private cTitPadut	:= QaTit("QM3_PADUT",12)
Private cTitDaf		:= QaTit("QM3_VALDAF",8)
Private cTitInc		:= QaTit("QM3_INCERT",9)
Private cTitTolMin := QaTit("QM3_TOLMIN",08)

Private cTDafQM6	:= QaTit("QM6_VALDAF",14,.F.)
Private cTitRepr	:= QaTit("QM6_REPEPR",10,.F.)

Private cTitNor		:= QaTit("QA5_NORMA",22,.t.)

Private cTitProc	:= QaTit("QM1_PROCAL",22,.t.)

Private cTitEscQM7	:= QaTit("QM7_ESCALA",12,.t.)                                                  
Private cTitCert	:= QaTit("QM7_NRCERT",14,.F.)

Private cTitDep		:= QaTit("QM2_DEPTO",3,.F.)
Private cTDepto		:= QaTit("QM2_DEPTO",22,.t.)
Private cTitLoc		:= QaTit("QM2_LOCAL",22,.t.)
Private cTitInst	:= QaTit("QM2_INSTR",22,.t.)
Private cTitInstF	:= QaTit("QM2_INSTR",12,.f.)
Private cTitResp	:= QaTit("QM2_RESP",22,.t.)
Private cTitNFab	:= QaTit("QM2_NUMFAB",22,.t.)
Private cTitFabr	:= QaTit("QM2_FABR",22,.t.)
Private cTTalim		:= QaTit("QM2_TALIM",22,.t.)
Private cTitLei		:= QaTit("QM2_LEIT",22,.t.)
Private cTitSFab	:= QaTit("QM2_NSEFAB",22,.t.)
Private cTitPot		:= QaTit("QM2_POT",22,.t.)
Private cTitCus		:= QaTit("QM2_CUSTO",22,.t.)
Private cTitUso		:= QaTit("QM2_USOINI",22,.t.)
Private cTitFreq	:= QaTit("QM2_FREQAF",22,.t.)
Private cTitResol	:= QaTit("QM2_RESOL",22,.t.)
Private cTitStat	:= QaTit("QM2_STATUS",22,.t.) 
Private cTitSeq		:= QaTit("QM6_CSEQ",22,.t.)

Private cTitRev		:= QaTit("QME_REVINS",12,.F.)
Private cTitData	:= QaTit("QME_DATA"  ,12,.F.)
Private cTQMERes	:= QaTit("QME_RESP"  ,12,.F.)
Private cTitHors	:= QaTit("QME_QTDHOR",12,.F.)
Private cTitLabor	:= QaTit("QME_LABOR" ,12,.F.)
Private cTitNCert	:= QaTit("QME_NRCERT",12,.F.)

Private cTTolQMA	:= QaTit("QMA_TOLER",8) //Toler.Maxima
Private cTTMinQMA 	:= QaTit("QMA_TOLMIN",8) //Toler.Minima
Private	TRB_FILIAL
Private	TRB_FILQM2
Private	TRB_INSTR	
Private	TRB_REVINS	
Private TRB_REVQM2	
Private TRB_VALDAF	
Private TRB_LAUDO	
Private TRB_COND	
Private	TRB_RESP	
Private	TRB_TOTHOR	
Private	TRB_REPEPR	
Private	TRB_DATA	
Private	TRB_DEPQM2	
Private	TRB_TIPQM2	
Private	TRB_FABQM2	
Private TRB_RESQM2	
Private TRB_NUMQM2	
Private	TRB_TALQM2	
Private	TRB_LEIQM2	
Private	TRB_NSEQM2	
Private	TRB_POTQM2	
Private TRB_CUSQM2	
Private TRB_USOQM2	
Private	TRB_FREQM2	
Private	TRB_SOLQM2	
Private	TRB_STAQM2	
Private	TRB_LOCAL	
Private TRB_CHAVE	
Private TRB_CHVQM6	
Private TRB_FILRES
Private TRB_REFQM2
Private cSeql := ""
Private lProcs := .F.
Private cTextRet		:= ""
Private axTex			:= {}
// variaveis dos cabecalhos
li     := 80
m_pag  := 1
cbCont := 0
cbTXT  := ""
//Garante integridade QM2
dbSelectArea("QM2")
dbSetOrder(1)
dbGoTop()

dbSelectArea( "QM6" )
dbSetOrder(1)

If !empty(mv_par01)
	If ExistCpo("QM2",mv_par01)
		If !dbSeek( xFilial("QM6") + mv_par01 )
			MessageDlg(STR0133,,3)	  //"Instrumento Inicial Nao Apresenta Coleta de Dados."
			Set Device To Screen
			Set Filter To
			Return .F.
		Endif
	Else		
		Return .F.
	Endif
Else
	DbGoTop()
EndIf

cChave := "QM6_FILIAL+QM6_INSTR"	
cFiltro:= "SELECT QM6_FILIAL,QM6_INSTR,QM6_REVINS,QM6_VALDAF,QM6_LAUDO,QM6_COND,QM6_DATA,QM6_CHAVE,QM6_CSEQ,QM6_FILRES,"		
cFiltro+= "QM6_RESP,QM6_TOTHOR,QM6_REPEPR,QM6.R_E_C_N_O_ QM6R_E_C_N_O_,QM2_FILIAL,QM2_INSTR,QM2_REVINS,QM2_REVINV,"
cFiltro+= "QM2_CHAVE,QM2_DEPTO,QM2_TIPO,QM2_FABR,QM2_RESP,QM2_FILRES,"
cFiltro+= "QM2_LOCAL,QM2_NUMFAB,QM2_TALIM,QM2_LEIT,QM2_POT,QM2_CUSTO,QM2_USOINI,"						
cFiltro+= "QM2_FREQAF,QM2_RESOL,QM2_STATUS,QM2_NSEFAB "								
cFiltro+= "FROM "+RetSqlName("QM6")+" QM6, "
cFiltro+= RetSqlName("QM2")+" QM2 "
cFiltro+= "WHERE "
cFiltro+= "QM6.QM6_FILIAL = '"	+xFilial("QM6")+	"' AND "
cFiltro+= "QM6.QM6_INSTR	>= '"	+ mv_par01 +	"' AND " 
cFiltro+= "QM6.QM6_INSTR	<= '"	+ mv_par02 +	"' AND " 
cFiltro+= "QM6.QM6_DATA 	>= '"	+ DtoS(mv_par03) +	"' AND " 
cFiltro+= "QM6.QM6_DATA 	<= '"	+ DtoS(mv_par04) +	"' AND " 		
cFiltro+= "QM2.QM2_FILIAL	= QM6.QM6_FILIAL AND "
cFiltro+= "QM2.QM2_INSTR 	= QM6.QM6_INSTR  AND "
cFiltro+= "QM2.QM2_REVINS 	= QM6.QM6_REVINS AND "
cFiltro+= "QM2.QM2_DEPTO	>= '"	+ mv_par05 +	"' AND " 
cFiltro+= "QM2.QM2_DEPTO	<= '"	+ mv_par06 +	"' AND " 
cFiltro+= "QM2.QM2_TIPO		>= '"	+ mv_par12 +	"' AND " 
cFiltro+= "QM2.QM2_TIPO		<= '"	+ mv_par13 +	"' AND " 
cFiltro+= "QM2.QM2_FABR		>= '"	+ mv_par14 +	"' AND " 
cFiltro+= "QM2.QM2_FABR		<= '"	+ mv_par15 +	"' AND " 
cFiltro+= "QM2.QM2_RESP		>= '"	+ mv_par16 +	"' AND " 
cFiltro+= "QM2.QM2_RESP		<= '"	+ mv_par17 +	"' AND " 
cFiltro+= "QM2.D_E_L_E_T_= ' ' AND QM6.D_E_L_E_T_= ' ' "
cFiltro += "ORDER BY " + SqlOrder(cChave)

cFiltro:= ChangeQuery(cFiltro)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cFiltro),"TRB",.T.,.T.)
TcSetField("TRB","QM6_DATA","D",8,0)
TcSetField("TRB","QM6_VALDAF","D",8,0)
TcSetField("TRB","QM2_USOINI","D",8,0)		
dbSelectArea( "TRB" )				

While ! Eof()
	TRB_FILIAL	:=	TRB->QM6_FILIAL		
	TRB_FILQM2	:= 	TRB->QM2_FILIAL
	TRB_INSTR	:=	TRB->QM6_INSTR
	TRB_REVINS	:= 	TRB->QM6_REVINS		
	TRB_REVQM2	:=	TRB->QM2_REVINS			
	TRB_VALDAF	:=	TRB->QM6_VALDAF
	TRB_LAUDO	:=	TRB->QM6_LAUDO
			            TRB_COND	:=	TRB->QM6_COND
	TRB_RESP	:=  TRB->QM6_RESP
	TRB_TOTHOR	:=	TRB->QM6_TOTHOR
	TRB_REPEPR	:=	TRB->QM6_REPEPR            
	TRB_DATA	:=	TRB->QM6_DATA
	TRB_DEPQM2	:=	TRB->QM2_DEPTO
	TRB_TIPQM2	:=	TRB->QM2_TIPO
	TRB_FABQM2	:=	TRB->QM2_FABR						
	   			TRB_RESQM2	:=	TRB->QM2_RESP
	            TRB_NUMQM2	:= 	TRB->QM2_NUMFAB
	TRB_TALQM2	:= 	TRB->QM2_TALIM
	TRB_LEIQM2	:=  TRB->QM2_LEIT
	TRB_NSEQM2	:= 	TRB->QM2_NSEFAB
	TRB_POTQM2	:=	TRB->QM2_POT
	   			TRB_CUSQM2	:=	TRB->QM2_CUSTO
	            TRB_USOQM2	:=	TRB->QM2_USOINI
	TRB_FREQM2	:=	TRB->QM2_FREQAF
	TRB_SOLQM2	:=	TRB->QM2_RESOL
	TRB_STAQM2	:=	TRB->QM2_STATUS
	TRB_LOCAL	:=	TRB->QM2_LOCAL
	TRB_CHAVE	:=	TRB->QM2_CHAVE
	TRB_CHVQM6	:=	TRB->QM6_CHAVE			
	cInstrMan 	:=	TRB->QM2_INSTR			
	TRB_FILRES	:=	TRB->QM6_FILRES	 
	TRB_REFQM2	:=	TRB->QM2_FILRES				
	cSeql		:=  TRB->QM6_CSEQ
	
	aArea := GetArea()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno e externo                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 1
		If ! Calibrador(0,mv_par08,mv_par09,mv_par10,mv_par11,TRB_INSTR,TRB_REVINS)
			dbSkip()
			Loop
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 2
		If ! Calibrador(1,mv_par08,mv_par09,,,TRB_INSTR,TRB_REVINS)
			dbSkip()
			Loop
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. externo                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 3
		If ! Calibrador(2,,,mv_par10,mv_par11,TRB_INSTR,TRB_REVINS)
			dbSkip()
			Loop
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciono na familia e revisao referentes a data do QM6.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "QM1" )
	dbSetOrder(1)
	dbSeek( xFilial("QM1") + TRB_TIPQM2 )
	While ! Eof() .And. xFilial("QM1")+QM1->QM1_TIPO == TRB_FILQM2+TRB_TIPQM2
		If QM1->QM1_DATREV <= TRB_DATA
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

	lImpMan	  := .F.		// Imprime Manutencao
	
	If lQMR140R
       ExecBlock("QMR140R",.F.,.F.,{nTxtFin,nInfCom,nInfCIn,nIncs,nIOBS,nILaudo,nIitb,nImpH})
	Else
		cabec1 := OemToAnsi(cTitInst) + cInstrMan // Instrumento
		If cChaveQM2 <> TRB_FILQM2+cInstrMan //QM2->QM2_INSTR
			cChaveQM2 := TRB_FILQM2+cInstrMan //QM2->QM2_INSTR
			m_pag := 1	
			Cabec( Titulo, cabec1, cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18)) 
			li++
		Else
			If li > 55
				Cabec( Titulo, cabec1, cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18)) 
				li++
			EndIf
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o Cabecalho da Calibracao                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		U_QMR140ICC()	
		lProcs := .F.
		//Localizar o procedimento de calibracao utilizado na data da calibracao...
		QA5->(dbSetOrder(1))
		If QA5->(dbSeek(xFilial("QA5") + "C" + QM1->QM1_PROCAL))                 
			While QA5->(!Eof()) .and. QA5->QA5_FILIAL+QA5->QA5_CODTAB+QA5->QA5_NORMA ==;
				xFilial("QA5")+"C"+QM1->QM1_PROCAL 
			    If QA5->QA5_DATA <= TRB_DATA
			    	lProcs := .T.
			    	Exit
			    Endif	
				QA5->(dbSkip())
			Enddo
		Endif
                  
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o Dados do Instrumento                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		U_QMR140IIns(@cChaveQM6)	
         
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se existem tolerancias de processo e redutores para    ³
		//³ serem impressos (se escala for confirma‡ao metrologica)         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		U_QMR140ImTP(@cChaveQMR)	

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime os Padroes de Calibracao                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		U_QMR140IPad()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime as medicoes                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		li+=2
		@ li,004 PSAY repl("-",46)+">>  " + Padc(OemToAnsi(STR0029),22) +; //"Medicoes"
						  "  <<"+repl("-",46)
		li+=2                 
		If nIJCali == 1
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime Justificativa da nao digitacao das medicoes  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("QA3")
			dbSetOrder(1)

			li+=1
			@ li,004 PSAY repl("-",48)+">>  " + OemToAnsi(STR0130) +; // "Justificativa da nao digitacao das medicoes"
						  "  <<"+repl("-",48)

			cTextRet := ""							  
			axTex := {}			
			cTextRet := QA_Rectxt(TRB_CHVQM6,"QMTA140L",1,100,"QA3")
   	        axTex := Q_MemoArray(cTextRet,axTex,100)

			For ni := 1 To Len(axTex)            

				li+=1							  

				If li > 55
					Cabec( Titulo, cabec1, cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18)) 
					li++
				EndIf

				@ li  ,004 PSAY axTex[ni]
			Next					  
							  
			li+=1
		EndIf		

		cTextRet:= ""
		axTex	:= {}

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
 		If QM7->(DbSeek(xFilial()+TRB_INSTR+TRB_REVINS+DtoS(TRB_DATA)+cSeql))
			cCert := QM7->QM7_NRCERT			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta aMedicoes                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	 		aResult := U_MTR140Carg(@aRelResu)
	 	Else
	 		aMedicoes := {}
	 	Endif               
	 	
 		If Len(aMedicoes) <> 0
	 	    cEscala := aMedicoes[1,nPosEsc]
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica o numero de colunas 1-simples, 2-completo, 4-pressao   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nTotCol := U_R140NumCol(1)
		EndIf	 	    

		nCntFor := 1
		nCntForMAnt := 1
		While nCntFor <= Len(aMedicoes)
			lCab := .T.
			nAuxCntFor := nCntFor		// Guarda o indice da primeira escala

			For nCntForM := 1 to nTotCol
			
				nCntForMAnt := nCntForM              
  				nCntFor := nAuxCntFor
				lCab := .T.

				While nCntFor <= Len(aMedicoes) .and. ;
					  cEscala == aMedicoes[nCntFor,nPosEsc]			
				If aMedicoes[nCntFor,nPosGer,1,3] == "A"
					nCntForM := 1				
				Endif
					  
					cText := ""

					If aMedicoes[nCntFor,nPosGer,1,2] $ "2,5,8,3,9" .and. aMedicoes[nCntFor,nPosGer,1,6] $ "1|2"
    	
	 					If nTotCol == 4
							If nCntForM == 1 
								cText := If(aMedicoes[nCntFor,nPosGer,1,2] = "3",STR0033,If(aMedicoes[nCntFor,nPosGer,1,2] = "9",STR0115," "))	//"Inicial Subida"	//"Inicial Crescente"
							ElseIf nCntForM == 2
								cText := If(aMedicoes[nCntFor,nPosGer,1,2] = "3",STR0035,If(aMedicoes[nCntFor,nPosGer,1,2] = "9",STR0116," "))  //"Final Subida"     //"Final Crescente"
							ElseIf nCntForM == 3
								cText := If(aMedicoes[nCntFor,nPosGer,1,2] = "3",STR0034,If(aMedicoes[nCntFor,nPosGer,1,2] = "9",STR0117," "))	//"Inicial Descida"	 //"Inicial Descrescente"
							Else
								cText := If(aMedicoes[nCntFor,nPosGer,1,2] = "3",STR0036,If(aMedicoes[nCntFor,nPosGer,1,2] = "9",STR0118," "))   //"Final Descida"    //"Final Descrescente"
							EndIf
						ElseIf nTotCol > 1
							If nCntForM == 1
								cText := STR0037   // "Iniciais"
							Else
								cText := STR0038   // "Finais"
							EndIf
						Else
							cText := ""
						EndIf
					EndIf
		
					If aMedicoes[nCntFor,nPosGer,1,6] $ "1|2" // Se houver medicoes com incerteza

						If li > 55
							U_R140Cab()
							li++
							lCab := .t.
						EndIf
	
                  		If lCab
                     		If li > 49
       		               		@ li,004 PSAY Repl("-",124)
		                        U_R140Cab()
        		                li++
                		        U_MTR140CInc(cText,nCntFor)  // Imprime cabecalho de
											             // Medicoes com Incerteza
		                    Else
        		                If nCntForM == 1
                		           U_MTR140CInc(cText,nCntFor)  // Imprime cabecalho de 
                        			                         // Medicoes com Incerteza
		                        EndIf
        		            EndIf
                		    If li > 53
        		               @ li,004 PSAY Repl("-",124)
		                        U_R140CAB()
								li++
                		        U_MTR140CInc(cText,nCntFor)  // Imprime cabecalho de 
	                      			                       // Medicoes com Incerteza
            	        	    MTR140SubCab(cText,nCntFor)  // Imprime o SubCabecalho
		                        lCab := .f.
        		            Else
                		        MTR140SubCab(cText,nCntFor)  // Imprime o SubCabecalho
        		                lCab := .f.
		                        If li > 55
        		                   U_R140CAB()
                		           li++
		                           U_MTR140CInc(cText,nCntFor)  // Imprime cabecalho de 
        			                                           // Medicoes com Incerteza
		                           MTR140SubCab(cText,nCntFor)  // Imprime o SubCabecalho
                		        EndIf
		                    EndIf
						EndIf
						
						@li,004 PSAY '|'+alltrim(aMedicoes[nCntFor,nPosPad])
	
						@li,025 PSAY '|'
						If ntotcol > 0 .and. aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
							@li,026 PSAY If(!empty(aMedicoes[nCntFor,nPosMed,1,nCntForM]),;
												aMedicoes[nCntFor,nPosMed,1,nCntForM],'')
						ElseIf aMedicoes[nCntFor,nPosGer,1,3] == "A" // Tipo do padrao ‚ Atributo
							// Senao ‚ tipo Atributo (imprime Aprovado ou Reprovado)
							@li,026 PSAY If(aMedicoes[nCntFor,nPosMed,1,nCntForM]=="A",;
												cApro,;
											 If(aMedicoes[nCntFor,nPosMed,1,nCntForM]=="R",;
											   cRepro,""))
						EndIf
						@li,036 PSAY '|'
						If aMedicoes[nCntFor,nPosGer,1,1] > 1 // Verifica se Escala tem mais de uma medicao
							If nTotCol > 0 .and.;
								aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
								@li,037 PSAY If(!empty(aMedicoes[nCntFor,nPosMed,2,nCntForM]),;
													aMedicoes[nCntFor,nPosMed,2,nCntForM],'')
							EndIf
						EndIf
						@li,047 PSAY '|'
	


						If QmtNum(aResult[nCntFor,nCntForM,1]) > 0
							If nTotCol > 0 .and.;
								aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
								@li,048 PSAY    aResult[nCntFor,nCntForM,1] PICTURE QMT140Pics("aResult[nCntFor,nCntForM,1]",;
													 aMedicoes[nCntFor,nPosMed,1,nCntForM],.t.) //Media das Leituras
							EndIF
						EndIf
	
						@li,058 PSAY '|'
	
						If aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M"  .or.;
							(aMedicoes[nCntFor,nPosGer,1,4] == "E" .and.;
							aMedicoes[nCntFor,nPosGer,1,1] == 0)
							If QmtNum(aResult[nCntFor,nCntForM,2]) > 0
								If ValType(aResult[nCntFor,nCntForM,2]) == "C"
									@li,059 PSAY 	 PADL(AllTrim(aResult[nCntFor,nCntForM,2]),10," ")
								Else
									@li,059 PSAY 	 aResult[nCntFor,nCntForM,2] PICTURE QMT140Pics("aResult[nCntFor,nCntForM,2]",;
														 aMedicoes[nCntFor,nPosMed,1,nCntForM],.t.) //Desvio Medio
								EndIf
							EndIf
	 					EndIf
	
	 					@li,069 PSAY '|'
	
						If QmtNum( aResult[nCntFor,nCntForM,3]) > 0
							If aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" .or.;
								(aMedicoes[nCntFor,nPosGer,1,4] == "E" .and.;
								aMedicoes[nCntFor,nPosGer,1,1] == 0)
								@li,070 PSAY 	 aResult[nCntFor,nCntForM,3] PICTURE QMT140Pics("aResult[nCntFor,nCntForM,3]",;
													 aMedicoes[nCntFor,nPosMed,1,nCntForM],.t.) //Desvio Padrao
							EndIf
						EndIf
	
		 				@li,080 PSAY '|'
	
						If QmtNum(aResult[nCntFor,nCntForM,4]) > 0
							If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
								@li,081 PSAY 	 aResult[nCntFor,nCntForM,4] PICTURE QMT140Pics("aResult[nCntFor,nCntForM,4]",;
													 aMedicoes[nCntFor,nPosMed,1,nCntForM],.t.) //Incerteza Medicao
							EndIf
						EndIf
	
			 			@li,091 PSAY '|'
	
						If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"  .or.;
							(aMedicoes[nCntFor,nPosGer,1,4] == "E" .and.;
							aMedicoes[nCntFor,nPosGer,1,1] == 0)
							If QmtNum(aResult[nCntfor,nCntForM,5]) > 0
								If ValType(aResult[nCntFor,nCntForM,5]) == "C"
									@li,092 PSAY 	 PADL(AllTrim(aResult[nCntFor,nCntForM,5]),10," ")
								Else
									@li,092 PSAY 	 aResult[nCntFor,nCntForM,5] PICTURE QMT140Pics("aResult[nCntFor,nCntForM,5]",;
														 aMedicoes[nCntFor,nPosMed,1,nCntForM],.t.)  //Incerteza Total
								EndIf
							EndIf
						EndIf
	
						@li,102 PSAY '|'
	
						If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"  //Erro Total
							If QmtNum(aResult[nCntfor,nCntForM,5])+QmtNum(aResult[nCntfor,nCntForM,2]) > 0
								If lqmt140EI
									nErrMa := ExecBlock("qmt140EI",.F.,.F.,{aResult[nCntFor,nCntForM,5],aResult[nCntfor,nCntForM,2]})
									@li,103	PSAY nErrMa PICTURE QMT140Pics("aMedicoes[nCntFor,nPosMed,1,1]",aMedicoes[nCntFor,nPosMed,1,1],.t.)
								Else
									If cCalInc == '1' // Soma Algebrica - MV_QCALINC
										@li,103 PSAY aResult[nCntFor,nCntForM,5]+aResult[nCntfor,nCntForM,2] ;
										PICTURE QMT140Pics("aMedicoes[nCntFor,nPosMed,1,1]",aMedicoes[nCntFor,nPosMed,1,1],.t.)
									Else
										@li,103 PSAY Sqrt(aResult[nCntfor,nCntForM,5]^2+aResult[nCntFor,nCntForM,2]^2) ;
										PICTURE QMT140Pics("aMedicoes[nCntFor,nPosMed,1,1",aMedicoes[nCntFor,nPosMed,1,1],.t.)
									EndIf
								Endif	
							Endif
						Else
							If aMedicoes[nCntFor,nPosGer,1,4] == "E" .and.;	//Externo sem medicao
								aMedicoes[nCntFor,nPosGer,1,1] == 0 			// Incerteza e desvio são digitados
								nValDesv := SuperVal(aResult[nCntfor,nCntForM,5])
								nValIncs := SuperVal(aResult[nCntfor,nCntForM,2])
								If QmtNum(nValDesv)+QmtNum(nValIncs) > 0
									If lqmt140EI
										nErrMa := ExecBlock("qmt140EI",.F.,.F.,{nValIncs,nValDesv})
										@li,103	PSAY nErrMa PICTURE QMT140Pics("aResult[nCntfor,nCntForM,5]",aResult[nCntfor,nCntForM,5],.f.)
									Else
										If cCalInc == '1' // Soma Algebrica - MV_QCALINC
											@li,103 PSAY nValDesv+nValIncs;
											PICTURE QMT140Pics("aResult[nCntfor,nCntForM,5]",aResult[nCntfor,nCntForM,5],.f.)
										Else
											@li,103 PSAY Sqrt(nValDesv^2+nValIncs^2);
											PICTURE QMT140Pics("aResult[nCntfor,nCntForM,5]",aResult[nCntfor,nCntForM,5],.f.)
										EndIf
									Endif	
								EndIF
							EndIf
						EndIf
	
	 					@li,113 PSAY '|'
	
						If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"  //Status de Medicao
							@li,114 PSAY If(aResult[nCntFor,nCntForM,10] == "A",cApro,;
											 If(aResult[nCntFor,nCntForM,10] == "R",cRepro,;
											 ""))
	 					EndIf
	
						@li,127 PSAY '|'
						li++
		                If li > 54
		                   @ li,004 PSAY Repl("-",124)
		                   U_R140CAB()
		                   li++
		                   U_MTR140CInc(cText,nCntFor)  // Imprime cabecalho de 
		                                            // Medicoes com Incerteza
		                   MTR140SubCab(cText,nCntFor)  // Imprime o SubCabecalho
		                EndIf
	
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Imprime a segunda linha com o nominal e, se houver mais medicoes³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						@li,004 PSAY '|'
						@li,005 PSAY aMedicoes[nCntFor,nPosEsp]
						@li,025 PSAY '|'
	
						nCont := 3
	
						If nCont <= aMedicoes[nCntFor,nPosGer,1,1] .and.;
							aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
	
							Do while nCont <= aMedicoes[nCntFor,nPosGer,1,1] .and.;
								aMedicoes[nCntFor,nPosGer,1,3] $ "O,S,M" // Tipo do padrao ‚ Mensuravel
								If nCont > 4
									@li,004 PSAY '|'
									@li,025 PSAY '|'
								EndIf							
								@li,026 PSAY aMedicoes[nCntFor,nPosMed,nCont,nCntForM]
								@li,036 PSAY '|'
								nCont++
								If nCont <= aMedicoes[nCntFor,nPosGer,1,1]
									@li,037 PSAY aMedicoes[nCntFor,nPosMed,nCont,nCntForM]
									nCont++
								EndIf
	
								@li,047 PSAY '|'
								@li,058 PSAY '|'
								@li,069 PSAY '|'
								@li,080 PSAY '|'
								@li,091 PSAY '|'
								@li,102 PSAY '|'
								@li,113 PSAY '|'
	
								If aMedicoes[nCntFor,nPosGer,1,6] == '1' // Se for Confirmacao Metrologica
									If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
										cStat := If(!aResult[nCntFor,nCntForM,7],"Ext,","")+;
													If(!aResult[nCntFor,nCntForM,8],"Ace,","")+;
													If(!aResult[nCntFor,nCntForM,9],"Adq","")
									EndIf
									If Subs(cStat,len(cStat),1) == ","
										cStat := Subs(cStat,1,len(cStat)-1)
									EndIf
									@li,114 PSAY cStat
								EndIf
	
								@li,127 PSAY '|'
								li++
                		        If li > 54 .and. ;
		                           nCont <= aMedicoes[nCntFor,nPosGer,1,1] .and.;
        	        	           aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M" 
	
	      		                   @ li,004 PSAY Repl("-",124)
                		           U_R140CAB()
                        		   li++
		                           U_MTR140CInc(cText,nCntFor)  // Imprime cabecalho de 
        		                                            // Medicoes com Incerteza
                		           MTR140SubCab(cText,nCntFor)  // Imprime o SubCabecalho
        		                EndIf

							EndDo
	
						Else
							If nCont > 4
								@li,004 PSAY '|'
								@li,025 PSAY '|'
							EndIf
							@li,036 PSAY '|'
							@li,047 PSAY '|'
							@li,058 PSAY '|'
							@li,069 PSAY '|'
							@li,080 PSAY '|'
							@li,091 PSAY '|'
							@li,102 PSAY '|'
							@li,113 PSAY '|'
	
							If aMedicoes[nCntFor,nPosGer,1,6] == '1' // Se for Confirmacao Metrologica
								If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
									cStat := If(!aResult[nCntFor,nCntForM,7],"Ext,","")+;
												If(!aResult[nCntFor,nCntForM,8],"Ace,","")+;
												If(!aResult[nCntFor,nCntForM,9],"Adq","")
								EndIf
								If Subs(cStat,len(cStat),1) == ","
									cStat := Subs(cStat,1,len(cStat)-1)
								EndIf
								@li,114 PSAY cStat
							EndIf
							@li,127 PSAY '|'
							li++
						EndIf
	
	 				Else  // Medicoes em relacao ao especificado/limite
	
						If li > 55
							U_R140CAB()
							li++
							lCab := .t.
						EndIf
						If lCab
							U_MTR140CEsp(nCntFor,nCntForM) // Imprime cabecalho de Medicoes sem Incerteza
							lCab := .f.
		                    If li > 55
		                       U_R140CAB()
		                       li++
		                       U_MTR140CEsp(nCntFor,nCntforM) // Imprime cabecalho de Medicoes sem Incerteza
		                    EndIf
							
	 					EndIf
	
						@ li  ,004 PSAY aMedicoes[nCntFor,nPosEsc]
						@ li  ,022 PSAY aMedicoes[nCntFor,nPosGer,1,11]
						@ li  ,027 PSAY aMedicoes[nCntFor,nPosPad]
						@ li  ,045 PSAY aMedicoes[nCntFor,nPosGer,1,12]
						If Alltrim(aMedicoes[nCntFor,nPosGer,1,3]) $ "A"
						// Somente considerar a primeira medicao       
							If Alltrim(aMedicoes[nCntFor,nPosMed,1,1]) == "A"
								@ li  ,055 PSAY OemToAnsi(STR0137) //"Aprovado"
							ElseIf Alltrim(aMedicoes[nCntFor,nPosMed,1,1]) == "R"
								@ li  ,055 PSAY OemToAnsi(STR0138) //"Reprovado"							
							Endif	
	                    Endif
						nLimMin := SuperVal(aMedicoes[nCntFor,nPosEsp]) -;
									  SuperVal(aMedicoes[nCntFor,nPosGer,1,7,2])
						nLimMax := SuperVal(aMedicoes[nCntFor,nPosEsp]) +;
									  SuperVal(aMedicoes[nCntFor,nPosGer,1,7,1])
	
						For nCntFor3 := 1 to aMedicoes[nCntFor,nPosGer,1,1]
							If li > 55
								U_R140CAB()
								li++
								lCab := .t.
							EndIf
							If lCab
								U_MTR140CEsp(nCntFor,nCntForM) // Imprime cabecalho de Medicoes sem Incerteza
								lCab := .f.
		                        If li > 55
		                           U_R140CAB()
		                           li++
		                           U_MTR140CEsp(nCntFor,nCntforM) // Imprime cabecalho de Medicoes sem Incerteza
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
	
							If aMedicoes[nCntFor,nPosGer,1,3] $ "O$S$M"
								@ li  ,055 PSAY aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2]	// era so M em todas as linhas seguintes
								@ li  ,067 PSAY U_R140Dif (SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2]),;
																nCntFor,nLimMin,nLimMax);
																PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
								@ li  ,079 PSAY U_R140PerDif(SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2]),;
																nCntFor,nLimMin,nLimMax);
																PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
	
								If nTotCol > 1
									@ li  ,093 PSAY aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2+1]
									@ li  ,105 PSAY U_R140Dif (SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2+1]),;
															nCntFor,nLimMin,nLimMax);
															PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
									@ li  ,117 PSAY U_R140PerDif(SuperVal(aMedicoes[nCntFor,nPosMed,nCntFor3,nCntForM2+1]),;
															nCntFor,nLimMin,nLimMax);
															PICTURE QMT140Pics("aMedicoes[nCntFor,nPosEsp]",aMedicoes[nCntFor,nPosEsp],.f.)
	
								EndIf
							EndIf
							li++
	
			 			Next nCntFor3
	
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
	
						cTextRet := ""							  
						axTex := {}			

						cTextRet := QA_Rectxt(cChave,"QMTA140O",1,100,"QA2")
						axTex := Q_MemoArray(cTextRet,axTex,100)

						For nx := 1 To Len(axTex)
							If nx == 1 //Pela primeira vez
								If aMedicoes[nCntFor,nPosGer,1,6] $ "1|2"
									@ li  ,004 PSAY "|"
								EndIf
								@ li  ,005 PSAY OemToAnsi(STR0039)    //"Observacao : "

								@ li  ,017 PSAY axTex[nx]
																
								If aMedicoes[nCntFor,nPosGer,1,6] $ "1|2"
									@ li  ,127 PSAY "|"
								EndIf
								li++
	                        	If aMedicoes[nCntFor,nPosGer,1,6] $ "1|2" // Se houver medicoes com incerteza
	                           		If li > 54
	                              		@ li,004 PSAY Repl("-",124)
	                              		U_R140CAB()
	                              		li++
	                              		If nCntForM == 1 
	                                  		U_MTR140CInc(cText,nCntFor)  // Imprime cabecalho de 
	                                        		                   // Medicoes com Incerteza
	                              		EndIf
	                              		MTR140SubCab(cText,nCntFor)  // Imprime o SubCabecalho
	                           		EndIf
								Else
	                           		If li > 55
				                       U_R140CAB()
		    			               li++
		                		       U_MTR140CEsp(nCntFor,nCntforM) // Imprime cabecalho de Medicoes sem Incerteza
	 								EndIf
								EndIf
							Else 
								If aMedicoes[nCntFor,nPosGer,1,6] $ "1|2"
									@ li  ,004 PSAY "|"
								EndIf
	
								@ li  ,017 PSAY axTex[nx] 
								
								If aMedicoes[nCntFor,nPosGer,1,6] $ "1|2"
									@ li  ,127 PSAY "|"
								EndIf
								li++
	  		                    If aMedicoes[nCntFor,nPosGer,1,6] $ "1|2" // Se houver medicoes com incerteza
									If li > 54
										@ li,004 PSAY Repl("-",124)
	                		                U_R140CAB()
	    	                    		        li++
		                                If nCntForM == 1 
	        			                            U_MTR140CInc(cText,nCntFor)  // Imprime cabecalho de 
	                			                                             // Medicoes com Incerteza
	                    	    		        EndIf
	                	                MTR140SubCab(cText,nCntFor)  // Imprime o SubCabecalho
									Else
										If li > 55
											U_R140CAB()
											li++	
											U_MTR140CEsp(nCntFor,nCntforM) // Imprime cabecalho de Medicoes sem Incerteza
										EndIf
									EndIf
                       		    EndIf
							EndIf
						Next nx	
					EndIf
	
					QM7->(DbGoto(nRecQM7))
	
					If aMedicoes[nCntFor,nPosGer,1,2] $ "1,4" .or. aMedicoes[nCntFor,nPosGer,1,6] $ "3,4"
						lDuplica := .f.
					EndIf
					//Forca a saida do While pois para pontos atributo, deve-se imprimir uma unica vez...
					If Alltrim(aMedicoes[nCntFor,nPosGer,1,3]) == "A"
						nCntForM := nCntForMAnt
					Endif						
	               	nCntFor++
				EndDo	// nCntFor
 			Next nCntForM

 			@li,004 PSAY repl('-',124)
 			li++
            
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Quando muda de Escala, imprime rodape e cabecalho           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nCntFor <= Len(aMedicoes)
				If cEscala <> aMedicoes[nCntFor,nPosEsc]
					If aMedicoes[If(nCntFor>1,nCntFor-1,1),nPosGer,1,2] = "3" // Imprime o Rodape da Escala para Tipo de Calibracao = Pressao (3)
						If li > 52
							U_R140Cab()
							li++
						EndIf
						U_MTR140REsP(aRelResu,cEscala,If(nCntFor>1,nCntFor-1,1))
					ElseIf aMedicoes[If(nCntFor>1,nCntFor-1,1),nPosGer,1,2] = "9" // Imprime o Rodape da Escala para Tipo de Calibracao = Relogio (9)
						If li > 45
							U_R140Cab()
							li++
						EndIf
						U_MTR140REsc(aRelResu,cEscala,If(nCntFor>1,nCntFor-1,1))
					EndIf   					
					lCab      := .T.
					cEscala   := aMedicoes[nCntFor,nPosEsc]
					nTotCol   := U_R140NumCol(nCntFor)
				EndIf
			Else
				If aMedicoes[If(nCntFor>1,nCntFor-1,1),nPosGer,1,2] = "3"
					// Imprime o Rodape da Escala para Tipo de Calibracao = Pressao (3)
					If li > 52
						U_R140Cab()
						li++
					EndIf
					U_MTR140REsP(aRelResu,cEscala,If(nCntFor>1,nCntFor-1,1))
				ElseIf aMedicoes[If(nCntFor>1,nCntFor-1,1),nPosGer,1,2] = "9"
					// Imprime o Rodape da Escala para Tipo de Calibracao = Relogio (9)
					If li > 45
						U_R140Cab()
						li++
					EndIf
					U_MTR140REsc(aRelResu,cEscala,If(nCntFor>1,nCntFor-1,1))
				EndIf   					
			EndIf

		EndDo	//nCntFor

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver instrumentos utilizados, imprimir 	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		/*
		   ================================================================================================================
		   |                                          INSTRUMENTOS UTILIZADOS                                             |
		   ================================================================================================================
		   |     ESCALA     |        PONTO       |INSTRUMENTO UTIL.| VALIDADE | INCERTEZA | CERTIFICADO  |   LABORATORIO  |
		   |--------------------------------------------------------------------------------------------------------------|
		   |1234567890123456|1234567890123456 - S|1234567890123456 |99/99/9999|1234567890 | 123456789012 |1234567890123456|
		   |--------------------------------------------------------------------------------------------------------------|
		*/

		lCab := .t.
		For nCntFor := 1 to Len(aMedicoes)

			If !Empty(aMedicoes[nCntFor,nPosIns,1,1])

				cEscala := " "
				cPonto  := " "
				For nCntFor2 := 1 to len(aMedicoes[nCntFor,nPosIns])
					If li > 55
						R030Cab()
						li++
						lCab := .t.
					EndIf
					If lCab
						CabPadInst("I") // Imprime cabecalho de instrumento utilizado
						lCab := .f.
					EndIf
					li++
					@ li  ,004 PSAY "|"
					If aMedicoes[nCntFor,nPosEsc] <> cESCALA
						@ li  ,005 PSAY aMedicoes[nCntFor,nPosEsc]
						cEscala := aMedicoes[nCntFor,nPosEsc]
					EndIf
					@ li  ,021 PSAY "|"
					If aMedicoes[nCntFor,nPosPad] <> cPONTO
						@ li  ,022 PSAY aMedicoes[nCntFor,nPosPad]
						cPonto := aMedicoes[nCntFor,nPosPad]
					EndIf
					dData := QM6->QM6_DATA
					// Posiciono na medicao em que o instrumento utilizado foi aprovado e
					// dentro do periodo procurado
							
					nRecQM6 := TRB->QM6R_E_C_N_O_

					lImpOk := .F.
					dbSelectArea("QMI")
					dbSetOrder(1)
					If dbSeek(xFilial()+TRB_INSTR+TRB_REVINS+DtoS(TRB_DATA))
						If !Empty(QMI->QMI_CSEQPR) .and. !Empty(QMI->QMI_REVQPR) .and. !Empty(QMI->QMI_DATQPR)							
							While QMI->(!Eof()) .and. QMI->QMI_INSTR+QMI->QMI_REVINS+DtoS(QMI->QMI_DATA) ==;
								  TRB_INSTR+TRB_REVINS+DtoS(TRB_DATA)
								  If Alltrim(aMedicoes[nCntFor,nPosIns,nCntFor2,1]) == Alltrim(QMI->QMI_INSUT)	
									  //Sequencia como ultimo campo no indice de padroes secundarios	 
									  If QMI->QMI_CSEQ == QM6->QM6_CSEQ
											lImpOk := .T.
											Exit
									  Endif
								  Endif										  
								  dbSelectArea("QMI") 
								  dbSkip()
							Enddo								  								  	
							If lImpOk
								dbSelectArea("QM6")
								dbSetOrder(4)
								If DbSeek(xFilial("QM6")+aMedicoes[nCntFor,nPosIns,nCntFor2,1]+Inverte(QMI->QMI_REVQPR)) //+DtoS(QMS->QMS_DATQPR)+QMS->QMS_CSEQPR
									nRQM6 := QM6->(RecNo())
									While !QM6->(Eof()) .and. xFilial("QM6")+aMedicoes[nCntFor,nPosIns,nCntFor2,1]+QMI->QMI_REVQPR ==;
										QM6->QM6_FILIAL+QM6->QM6_INSTR+QM6->QM6_REVINS
										If DtoS(TRB_DATA) <= DtoS(QMI->QMI_DATQPR) .and. (Val(QM6->QM6_CSEQ) == Val(QMS->QMS_CSEQPR))
											nRQM6 := QM6->(RecNo())    
											Exit
										Endif
										dbSelectArea("QM6")
										QM6->(dbSkip())
									Enddo	

									QM6->(dbGoTo(nRQM6))
										
									lAchou := .f.
									Do while aMedicoes[nCntFor,nPosIns,nCntFor2,1] == QM6->QM6_INSTR
										If QM6->QM6_DATA <= dData .and.;
											dData <= QM6->QM6_VALDAF .and.;
											!QM6->(Eof())	
										   If QM6->QM6_LAUDO == "A" 
											// Posiciono no QM7 para descobrir o numero do certificado e laboratorio
											// ATENCAO: Prevalecera numero e laboratorio da PRIMEIRA ESCALA
												nRecQM7 := QM7->(Recno())
												QM7->(DbSeek(xFilial("QM7")+QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA)))
												@ li  ,042 PSAY "|"
												@ li  ,043 PSAY aMedicoes[nCntFor,nPosIns,nCntFor2,1]
												@ li  ,060 PSAY "|"
												@ li  ,061 PSAY QM6->QM6_VALDAF
												@ li  ,071 PSAY "|"
												@ li  ,072 PSAY aMedicoes[nCntFor,nPosIns,nCntFor2,3]
												@ li  ,083 PSAY "|"	
												@ li  ,085 PSAY QM7->QM7_NRCERT
												@ li  ,098 PSAY "|"
												@ li  ,099 PSAY QM7->QM7_LABOR
												@ li  ,115 PSAY "|"
												lAchou := .t.
												QM7->(DbGoto(nRecQM7))
												exit
											EndIf
										Else 
											lRepro := .T.
										Endif	

										QM6->(DbSkip())
									EndDo
						
									If lRepro
										@ li  ,042 PSAY "|" + STR0135 //"Padrao Secundario com Status diferente de Ativo"
										@ li  ,115 PSAY "|"
										lRepro := .F.
									Else	
										If !lAchou
											@ li  ,042 PSAY "|"+ OemToAnsi(STR0040) //"Medi‡„o alterada indevidamente"
											@ li  ,115 PSAY "|"
										Endif	
									EndIf
								Else
									@ li  ,042 PSAY "|"+ OemToAnsi(STR0041) //"Medi‡„o exclu¡da"
									@ li  ,115 PSAY "|"	
								EndIf
								li++
								@ li  ,004 PSAY repl("-",112)

								RestArea(aArea)

								TRB->(dbGoTo(nRecQM6))  
							Endif
						Endif			
					Endif	
 				Next nCntFor2
 			EndIf
		Next nCntFor

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver incerteza tipo B, imprime.           ³                            	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aMedicoes) > 0
			R140ITB()
		EndIf			

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

 		lCab := .t.

 		For nCntFor := 1 to len(aMedicoes)

			If !empty(aMedicoes[nCntFor,nPosSec,1,1]) //File(cArqQMS)

				cEscala := " "
				cPonto  := " "


				For nCntFor2 := 1 to len(aMedicoes[nCntFor,nPosSec])
					If li > 53
						U_R140Cab()
						li++
						lCab := .t.
					EndIf
					If lCab
						CabPadInst("S") // Imprime cabecalho de padroes secundarios
						lCab := .f.
						If li > 53
							U_R140Cab()
							li++
							CabPadInst("S") 
						EndIf
					EndIf
					li++
					@ li  ,004 PSAY "|"
					If aMedicoes[nCntFor,nPosEsc] <> cEscala
						@ li  ,005 PSAY aMedicoes[nCntFor,nPosEsc]
						cEscala := aMedicoes[nCntFor,nPosEsc]
					EndIf
					@ li  ,021 PSAY "|"
					If aMedicoes[nCntFor,nPosPad] <> cPONTO
						@ li  ,022 PSAY aMedicoes[nCntFor,nPosPad]
						cPonto := aMedicoes[nCntFor,nPosPad]
					EndIf
					dData := TRB_DATA
					// Posiciono na medicao em que o padrao secundario foi aprovado e
					// dentro do periodo procurado
					nRecQM6 := TRB->QM6R_E_C_N_O_

					lImpOk := .F.
					dbSelectArea("QMS")
					dbSetOrder(1)
					If dbSeek(xFilial()+TRB_INSTR+TRB_REVINS+DtoS(TRB_DATA))
						If !Empty(QMS->QMS_CSEQPR) .and. !Empty(QMS->QMS_REVQPR) .and. !Empty(QMS_DATQPR)							
							While QMS->(!Eof()) .and. QMS->QMS_INSTR+QMS->QMS_REVINS+DtoS(QMS->QMS_DATA) ==;
								  TRB_INSTR+TRB_REVINS+DtoS(TRB_DATA)
								  If Alltrim(aMedicoes[nCntFor,nPosSec,nCntFor2,1]) == Alltrim(QMS->QMS_PADSEC)	
									  //Sequencia como ultimo campo no indice de padroes secundarios	 
									  If QMS->QMS_CSEQ == cSeql
											lImpOk := .T.
											Exit
									  Endif
								  Endif										  
								  dbSelectArea("QMS") 
								  dbSkip()
							Enddo								  								  	
							If lImpOk
								dbSelectArea("QM6")
								dbSetOrder(4)
								If DbSeek(xFilial("QM6")+aMedicoes[nCntFor,nPosSec,nCntFor2,1]+Inverte(QMS->QMS_REVQPR)) //+DtoS(QMS->QMS_DATQPR)+QMS->QMS_CSEQPR

									nRQM6 := QM6->(RecNo())

									While !QM6->(Eof()) .and. xFilial("QM6")+aMedicoes[nCntFor,nPosSec,nCntFor2,1]+QMS->QMS_REVQPR ==;
										QM6->QM6_FILIAL+QM6_INSTR+QM6_REVINS
										If (DtoS(QM6->QM6_DATA) <= DtoS(QMS->QMS_DATQPR)) .and. (Val(QM6->QM6_CSEQ) == Val(QMS->QMS_CSEQPR))
											nRQM6 := QM6->(RecNo())    
											Exit
										Endif
										dbSelectArea("QM6")
										QM6->(dbSkip())
									Enddo	
									QM6->(dbGoTo(nRQM6))
									lAchou := .f.
									Do while aMedicoes[nCntFor,nPosSec,nCntFor2,1] == QM6->QM6_INSTR
										If QM6->QM6_DATA <= dData .and.;
											dData <= QM6->QM6_VALDAF .and.;
											!QM6->(Eof())	
										   If QM6->QM6_LAUDO == "A" 
											// Posiciono no QM7 para descobrir o numero do certificado e laboratorio
											// ATENCAO: Prevalecera numero e laboratorio da PRIMEIRA ESCALA
												nRecQM7 := QM7->(Recno())
												QM7->(DbSeek(xFilial("QM7")+QM6->QM6_INSTR+QM6->QM6_REVINS+DtoS(QM6->QM6_DATA)))
												@ li  ,042 PSAY "|"
												@ li  ,043 PSAY aMedicoes[nCntFor,nPosSec,nCntFor2,1]
												@ li  ,060 PSAY "|"
												@ li  ,061 PSAY QM6->QM6_VALDAF
												@ li  ,071 PSAY "|"
												@ li  ,072 PSAY aMedicoes[nCntFor,nPosSec,nCntFor2,3]
												@ li  ,083 PSAY "|"	
												@ li  ,085 PSAY QM7->QM7_NRCERT
												@ li  ,098 PSAY "|"
												@ li  ,099 PSAY QM7->QM7_LABOR
												@ li  ,115 PSAY "|"
												lAchou := .t.
												QM7->(DbGoto(nRecQM7))
												exit
											EndIf
										Else 
											lRepro := .T.
										Endif	
										QM6->(DbSkip())
									EndDo
						
									If lRepro
										@ li  ,042 PSAY "|" + STR0135 //"Padrao Secundario com Status diferente de Ativo"
										@ li  ,115 PSAY "|"
										lRepro := .F.
									Else	
										If !lAchou
											@ li  ,042 PSAY "|"+ OemToAnsi(STR0040) //"Medi‡„o alterada indevidamente"
											@ li  ,115 PSAY "|"
										Endif	
									EndIf
								Else
									@ li  ,042 PSAY "|"+ OemToAnsi(STR0041) //"Medi‡„o exclu¡da"
									@ li  ,115 PSAY "|"	
								EndIf
								li++
								@ li  ,004 PSAY repl("-",112)
								RestArea(aArea)

								TRB->(dbGoTo(nRecQM6))  
							Endif
						Endif			
					Endif
				Next nCntFor2
 			EndIf

		Next nCntFor


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

		lCab := .t.

 		For nCntFor := 1 to Len(aMedicoes)

 			If !empty(aMedicoes[nCntFor,nPosNco,1,1])				// File(cArqQMJ)

 				If nINCs == 1 // Se impressao de Nao Conformidades == Sim

					cEscala := " "
 					cPonto  := " "

 					For nCntFor2 := 1 to Len(aMedicoes[nCntFor,nPosNco])
						If li > 55
							U_R140Cab()
							li++
							lCab := .t.
						EndIf
						If lCab
							CabNaoConf() // Imprime cabecalho de Nao Conformidade
							lCab := .f.
							If li > 55
								U_R140Cab()
								li++
								lCab := .t.
							EndIf
						EndIf
						li++
						@ li  ,004 PSAY "|"
						If aMedicoes[nCntFor,nPosEsc] <> cESCALA
							@ li  ,005 PSAY aMedicoes[nCntFor,nPosEsc]
							cEscala := aMedicoes[nCntFor,nPosEsc]
						EndIf
						@ li  ,021 PSAY "|"
						If aMedicoes[nCntFor,NposPad] <> cPONTO
							@ li  ,022 PSAY aMedicoes[nCntFor,NposPad]
							cPonto := aMedicoes[nCntFor,nPosPad]
						EndIf

						@ li  ,042 PSAY "|"
						@ li  ,044 PSAY aMedicoes[nCntFor,nPosNco,nCntFor2,1]
						@ li  ,053 PSAY "|"
						@ li  ,055 PSAY aMedicoes[nCntFor,nPosNco,nCntFor2,2]
						@ li  ,096 PSAY "|"
					 	@ li  ,099 PSAY  LTrim(MTR030QNC(nCntFor,nPosNco,nCntFor2))
						@ li  ,131 PSAY "|"

						li++
						@ li  ,000 PSAY repl("-",132)
					Next nCntFor2
				EndIf

	 		EndIf

		Next nCntFor


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Confirmacao Metrologica por Escala (se houver)       	  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aMedicoes) > 0
			U_R140CM()
		EndIf			

		If nIItb == 1
			li+= 2
			If li > 53
				r030Cab()
				li+= 2
			EndIf
			nCnt := ( 120 - Len(STR0139)) / 2 //Legenda Incerteza do Tipo B
			@ li,4 PSAY repl("=",112)
			li++
			If li > 53
				r030Cab()
				li+= 2
			EndIf
			@ li,4 PSAY "|"
			@ li,nCnt PSAY Upper(STR0139) //"LEGENDA INCERTEZA DO TIPO 'B'"
			@ li,115 PSAY "|"
			li++
			If li > 53
				r030Cab()
				li+= 2
			EndIf
				
			@ li,4 PSAY repl("=",112)

			li++
			If li > 53
				r030Cab()
				li+= 2
			EndIf

			@ li,4 PSAY "|"
			@ li,6 PSAY STR0140 //"*=Infinito ou >100"
			@ li,115 PSAY "|"
		
			aItbBox := RetSx3Box( Posicione("SX3", 2, "QMV_DISTR", "X3CBox()" ),,, 1 )
		
			For nx := 1 To Len(aItbBox)
				If !Empty(aItbBox[nx][1])
					li++            
					If li > 53
						r030Cab()
						li+= 2
					EndIf
					@ li,4 PSAY "|"
					@ li,6 PSAY Alltrim(aItbBox[nx][1])
					@ li,115 PSAY "|"
				Endif
			Next nx	
			li++
			@ li,4 PSAY  Repl("=",112)
			li++	
		Endif		
		
		li+=2		
		If nILaudo == 1 // Se impressao do laudo == sim
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime laudo (e justificativa, se houver)                   	  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			li++
			If li > 55
				U_R140Cab()
 				li+=2
 			EndIf

			@	li  ,004 PSAY OemToAnsi(STR0045)+" : " +; // "LAUDO "
														 If(TRB_LAUDO=="A",cApro,;
														 If(TRB_LAUDO=="R",cRepro,;
														 cCondi))
			li++
			cChave := TRB_CHVQM6
			QA3->(DbSetOrder(1))

			cTextRet := ""
			axTex := {}        

			cTextRet := QA_Rectxt(cChave,"QMTA140M",1,130,"QA3")
            axTex := Q_MemoArray(cTextRet,axTex,130)

			For ni := 1 To Len(axTex)
				li++
				If li > 55
					Cabec( Titulo, cabec1, cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18)) 
					li++
				EndIf
				@ li  ,004 PSAY axTex[ni]
			Next ni	

			li++
 		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Condicao de Recebimento (se houver)                  	  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cFreqs == "S" //GetMv("MV_QFREQAF")
			If !empty(TRB_COND)
				@ li  ,004 PSAY OemToAnsi(STR0046)+" : " +; //"CONDICAO DE RECEBIMENTO "
									If(TRB_COND =="A",OemToAnsi(STR0047),;  //"AVARIA"
									If(TRB_COND =="C",OemToAnsi(STR0048),;  //"CONFORME"
																  OemToAnsi(STR0049)))  //"NAO CONFORME"
			EndIf
		EndIf


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver inf.compl.do instr.(de acordo com param. de impressao)³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If nInfCIn == 1 // Se impressao da inform.compl.instr. == 1
			If li > 55
				U_R140Cab()
				li++
			EndIf
			li++
			QA2->(DbSetOrder(1))
			cChave := TRB_CHAVE    
			cTextRet := ""							  
			axTex := {}			

			cTextRet	:= QA_Rectxt(cChave,"QMTA010I",1,130,"QA2")
   	        axTex		:= Q_MemoArray(cTextRet,axTex,130)
			For nx := 1 To Len(axTex)
				If li > 55
					Cabec( Titulo, cabec1, cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18)) 
					li++
				EndIf
				If nx == 1
					@ li  ,004 PSAY OemToAnsi(STR0019)+" :" // "Informacoes Complementares do Instrumento"
					li++
					@ li  ,004 PSAY axTex[nx]					
				Else
					li++
					@ li  ,004 PSAY axTex[nx]									
				Endif	
            Next nx
		EndIf


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver inf.compl.  (de acordo com parametro de impressao)    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If nInfCom == 1 // Se impressao de Inf.Compl. == Sim
			If li > 55
				U_R140Cab()
				li++
			EndIf
			cArqTxt := "QMR1403"+".TXT"
			li++
			U_R140IMPTXT(cArqTxt,2)
			li++
		EndIf

		// Realizar impressao do historico imputado em INSTRUMENTO/CADASTRO/TEXTOS/HOSTORICO
		If nImpH == 1
			cTextRet := ""							  
			axTex := {}			

			cTextRet	:= QA_Rectxt(cChave,"QMTA010H",1,130,"QA2")
	        axTex := Q_MemoArray(cTextRet,axTex,130)
	
			For nx := 1 To Len(axTex)
				If li > 55
					Cabec( Titulo, cabec1, cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18)) 
					li++
				EndIf
				If nx == 1
					@ li  ,004 PSAY Ltrim(OemToAnsi(STR0013))+OemToAnsi(STR0001)+" :" // "Informacoes Complementares"###"Historico de Instrumento"
					li++
					@ li  ,004 PSAY axTex[nx]					
				Else
					li++
					@ li  ,004 PSAY axTex[nx]									
				Endif	
			Next nx
	
			If Len(axTex) > 0
				li++
			EndIf
		EndIf	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se houver texto final (de acordo com parametro de impressao)    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If nTxtFin == 1 // Se impressao de Texto Final == Sim
			If li > 55
				U_R140Cab()
				li++
			EndIf
			cArqTxt := "QMR1402"+".TXT"
			li++
			U_R140IMPTXT(cArqTxt,2)
			li++
 		EndIf

 		dbSelectArea( "QM6" )

		// Imrprime Analise das ultimas pecas produzidas se
 		// parametro 18 = "S" e Laudo for reprovado.

	EndIf

	dbSelectArea("TRB")
	dbSkip()

	If ( cInstrMan <> TRB_INSTR .Or. Eof() ) .And. !lImpMan
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime as manutencoes                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		U_QMR140Man(cInstrMan)
		lImpMan := .T.
	EndIf		
	
	dbSelectArea("TRB")

EndDo

If ( cInstrMan <> TRB_INSTR .Or. Eof() ) .And. !lImpMan
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime as manutencoes                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	U_QMR140Man(cInstrMan)
EndIf		

Roda( cbCont, cbTxt, Tamanho )

Set Device To Screen

	dbSelectArea("TRB")
	dbCloseArea()
	dbSelectArea("QM6")
	dbSetOrder(1)

If aReturn[5] = 1
	Set Printer TO
	dbCommitall()
	ourspool(wnrel)
End
MS_FLUSH()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R140CAB   ³ Autor ³ Wanderley Goncalves Jr³ Data ³ 15.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Cabecalho na quebra de pagina                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R140CAB()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R140CAB()

Local Tamanho := " "

Cabec( Titulo, cabec1, cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18))

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR140SubCab³ Autora³ Iuri Seto            ³ Data ³ 05/06/00³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime SubCabecalho de Medicoes com Incerteza para Ins-   ³±±
±±³          ³ trumentos.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³   R140SubCab()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cText                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MTR140SubCab(cText,nLin)

If cText == Nil
	cText := " "
EndIf

@li,004 PSAY repl("-",124)
li++
@ li,004 PSAY "|"
@ li,006 PSAY STR0111 + ;  // "Valores"
            " " + ;
         	cText
@ li,127 PSAY "|"
li++
@li,004 PSAY repl("-",124)
li++		                                            

Return(Nil)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³QMR140ImTP³Autora ³ Iuri Seto             ³ Data ³ 24/07/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprime Tolerancia de Processo e Redutores (QMR)           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMR140ImTP(cExp1)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cExp1 : Chave anterior do QMR.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMR140ImTP(cChaveQMR)
Local lMalha := .F.
Local aArray 
Local cInsEsc
Local nCntFor := 1

aArray := {}
lMalha := .F.
cInsEsc := " "
dbSelectArea("QMR")
DbSetOrder(1)
If DbSeek(xFilial("QMR")+TRB_INSTR+TRB_REVINS)
	If cChaveQMR <> xFilial("QMR")+TRB_INSTR+TRB_REVINS
		cChaveQMR := xFilial("QMR")+TRB_INSTR+TRB_REVINS
		li+=2
		@ li,004 PSAY repl("-",43)+">>  " + OemToAnsi(STR0127) +; // "Tolerancia/Redutor por Escala"
						  "  <<"+repl("-",43)
		Do while QMR->(!Eof()) .and. xFilial("QMR")+QMR->QMR_INSTR+QMR->QMR_REVINS ==;
			xFilial("QMR")+TRB_INSTR+TRB_REVINS
			If QMR->QMR_CAOBRI = "S"
				cInsEsc := U_R140InsEsc(QMR->QMR_INSTR,QMR->QMR_ESCALA)
				If !Empty(cInsEsc)
					lMalha := .T.	
					// E instrumento Malha, entao imprime o codigo do instrumento filho junto com 
					// as escalas, tolerancia e redutor
				EndIf
				aadd(aArray,{QMR->QMR_ESCALA,QMR->QMR_TOLPRO,QMR->QMR_REDUT,QMR->QMR_INPERM,QMR->QMR_PREC,cInsEsc})
			EndIf
			QMR->(DbSkip())
		EndDo

		If !lMalha	// Nao e instrumento Malha
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
				For nCntFor := 1 to Len(aArray)
					If li > 55 .or. lCab
						If li > 55
							U_R140Cab()
						EndIf
						li+= 2
						@ li  ,011 PSAY repl("=",103)
						li++
						@ li  ,011 PSAY "|"+space(5)+OemToAnsi(cTitEsc) // Escala
						@ li  ,036 PSAY "|"+space(3)+OemToAnsi(cTitPro) // Tolerancia do Processo
						@ li  ,065 PSAY "|"+Space(2)+OemToAnsi(cTitRedut) // Redutor
						@ li  ,077 PSAY "|"+Space(2)+OemToAnsi(cTitInpr) // Inc.Permit.
						@ li  ,093 PSAY "|"+Space(1)+OemToAnsi(cTitPrec) // Precisao
						@ li  ,113 PSAY "|"
						li++
						@ li  ,011 PSAY repl("-",103)
						lCab := .f.
					EndIf
					li++
					@ li  ,011 PSAY "|"
					@ li  ,016 PSAY aArray[nCntFor,1]
					@ li  ,036 PSAY "|"
					@ li  ,046 PSAY aArray[nCntFor,2]
					@ li  ,065 PSAY "|"
					@ li  ,071 PSAY aArray[nCntFor,3]
					@ li  ,077 PSAY "|"
					@ li  ,080 PSAY aArray[nCntFor,4]
					@ li  ,093 PSAY "|"
					@ li  ,095 PSAY aArray[nCntFor,5]
					@ li  ,113 PSAY "|"
					li++
					@ li  ,011 PSAY repl("-",103)
				Next nCntFor
			EndIf
        Else    
			// 01 - Posicao Inicial						     			 Posicao Final - 129
            //          1         2         3         4         5         6         7         8         9        10        11        12        
			// 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
			// =================================================================================================================================
			// |         Escala         |      Instrumento       |   Tolerancia do Processo   |  Redutor  |  Inc.Permitida | Precisao          |
			// ---------------------------------------------------------------------------------------------------------------------------------
			// |    1234567890123456    |    1234567890123456    |         1234567890         |     99    |   9999999999   | 01234567890123456 |
			// ---------------------------------------------------------------------------------------------------------------------------------

			lCab := .t.
			If !empty(aArray)
				For nCntFor := 1 to Len(aArray)
					If li > 55 .or. lCab
						If li > 55
							U_R140Cab()
						EndIf
						li+= 2
						@ li  ,001 PSAY repl("=",129)
						li++
						@ li  ,001 PSAY "|"+space(5)+OemToAnsi(cTitEsc) // Escala
						@ li  ,026 PSAY "|"+space(3)+OemToAnsi(cInstQMR) // Instrumento
						@ li  ,051 PSAY "|"+space(3)+OemToAnsi(cTitPro) // Tolerancia do Processo
						@ li  ,080 PSAY "|"+Space(2)+OemToAnsi(cTitRedut) // Redutor
						@ li  ,092 PSAY "|"+Space(2)+OemToAnsi(cTitInpr	) // Inc.Permit.
						@ li  ,109 PSAY "|"+Space(1)+OemToAnsi(cTitPrec) // Precisao
						@ li  ,129 PSAY "|"
						li++
						@ li  ,001 PSAY repl("-",129)
						lCab := .f.
					EndIf

					li++
					@ li  ,001 PSAY "|"
					@ li  ,006 PSAY aArray[nCntFor,1]
					@ li  ,026 PSAY "|"
					@ li  ,031 PSAY aArray[nCntFor,6]
					@ li  ,051 PSAY "|"
					@ li  ,061 PSAY aArray[nCntFor,2]
					@ li  ,080 PSAY "|"
					@ li  ,086 PSAY aArray[nCntFor,3]
					@ li  ,092 PSAY "|"
					@ li  ,096 PSAY aArray[nCntFor,4]
					@ li  ,109 PSAY "|"
					@ li  ,111 PSAY aArray[nCntFor,5]
					@ li  ,129 PSAY "|"

					li++
					@ li  ,001 PSAY repl("-",129)
				Next nCntFor
			EndIf
		EndIf
	EndIf
EndIf
Return(Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³QMR140IPad³Autora ³ Iuri Seto             ³ Data ³ 24/07/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprime os Padroes de Calibracao.                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMR140IPad()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMR140IPad()
Local lImpCabec := .T.
Local cTipTol := "1"
Local cDesc_Labor := ""
DbSelectArea("QM7")
QM7->(DbSetOrder(1))
If QM7->(DbSeek(xFilial()+TRB_INSTR+TRB_REVINS+dtos(TRB_DATA)+cSeql))
	li+=2
	@ li,004 PSAY repl("-",46)+">>  " + OemToAnsi(STR0015) +; // "Padrao para Calibracao"
				  "  <<"+repl("-",46)
	Do while !QM7->(Eof()) .and. TRB_INSTR+TRB_REVINS+dtos(TRB_DATA) ==;
 			  QM7->QM7_INSTR+QM7->QM7_REVINS+DtoS(QM7->QM7_DATA)
		If li > 55
			U_R140Cab()
			lImpCabec := .T.
			Loop
		Endif
		If lImpCabec
			li++
			@ li,004 PSAY OemToAnsi(cTitEscQM7) + ; //QM7_ESCALA
			alltrim(QM7->QM7_ESCALA) + ' - ' + QM7->QM7_REVESC
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciono no Procedimento de Calibracao do QA5.                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			li++
			@ li,004 PSAY OemToAnsi(cTitProc)  + ; // "Procedimento Cal.
			If(lProcs,alltrim(QA5->QA5_NORMA) + "-" + QA5->QA5_REVPRO+" - " + QA5->QA5_DESCRI,QM1->QM1_PROCAL)
				li++
				QM9->(DbSetOrder(1))
				QM9->(DbSeek(xFilial("QM9")+QM7->QM7_ESCALA+Inverte(QM7->QM7_REVESC)))
				QMO->(DbSetOrder(1))
				QMO->(DbSeek(xFilial("QMO")+QM9->QM9_LABOR))
				cDesc_Labor := Alltrim(QMO->QMO_EMPR)     
				QM9->(DbSetOrder(1))
				QM9->(DbSeek(xFilial("QM9")+QM7->QM7_ESCALA+Inverte(QM7->QM7_REVESC)))
				@ li,004 PSAY OemToAnsi(cTitCalib)+; // "Destino Calib.
				If(QM9->QM9_ORGAFE=="E", OemToAnsi(STR0016) + " / " + Alltrim(QM9->QM9_LABOR) + " - " + cDesc_Labor,; // "Externo"
					 OemToAnsi(STR0017) + " - " + QM9->QM9_DEPTO)  // "Interno"
	 			    li++
					@ li,004 PSAY OemToAnsi(QaTit("QM6_CODDOC",22,.t.))  + ; // "Codigo Docto
					allTrim(QM6->QM6_CODDOC) + "/" + AllTrim(QM6->QM6_REVDOC)
					li+=1
				Else
				    li+=1
				Endif
				@ li,004 PSAY OemToAnsi(QaTit("QM6_COTEAM",22,.t.))  + ; // "Temperatura Ambiente
			   	allTrim(QM6->QM6_COTEAM) 
				li+=2	
		
 				QM9->(DbSetOrder(1))
				QM9->(DbSeek(xFilial("QM9")+QM7->QM7_ESCALA+Inverte(QM7->QM7_REVESC)))
		 		cChave := TRB_INSTR+TRB_REVINS+dtos(TRB_DATA) +;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
				lCab := .t.
				If QM9->QM9_TIPAFE $ "1,2,3,9"
					// aLTERADO DE QM6 PARA QM7 NA LINHA ABAIXO PARA INSTRUMENTO E REVISAO
					Do while cChave == QM7->QM7_INSTR+QM7->QM7_REVINS+dtos(QM7->QM7_DATA) +;
								 QM7->QM7_ESCALA+QM7->QM7_REVESC
						If li > 55
							U_R140Cab()
							li++	
							lCab := .t.
						EndIf      
//          10        20        30        40        50        60        70        80        90        100       110       120       130
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
// Padrao - Revisao        Vlr.Nominal Toler.Max  Toler.Min  T.Tol Unid.Med. Num.Cert. Padrao Utilizado     Val.Cal    Incerteza
// XXXXXXXXXXXXXXXXXXXXXbbbXXXXXXXXXXXbXXXXXXXXXXbXXXXXXXXXXbXXXXXbXXXXXXXXXbXXXXXXXXbbXXXXXXXXXXXXXXXXXXXXbXXXXXXXXXXb
						If lCab
							@ li,001 PSAY OemToAnsi(cTituPad) + ' - ' +;  // Padrao
											  OemToAnsi(cTitRevPad)				  // Rev
							@ li,025 PSAY OemToAnsi(cTitEspec)  // Especificado
							@ li,037 PSAY OemToAnsi(cTitToler)  // Toler.Maxima
							@ li,048 PSAY OemToAnsi(cTitTolMin) // Toler.Minima 						
							@ li,059 PSAY OemToAnsi(STR0132)  // T.Tol - Tipo Tolerancia
							@ li,065 PSAY OemToAnsi(cTitUni)  // Unid.Med
							@ li,075 PSAY OemToAnsi(cTitCer) // Certificado
							@ li,085 PSAY OemToAnsi(cTitPadut)  // Padrao Utilizado
							@ li,107 PSAY OemToAnsi(cTitDaf)  // Val.Cal.
							@ li,119 PSAY OemToAnsi(cTitInc)  // Incerteza
							li++	
							@ li,001 PSAY repl("=",23)+" "+;			//Ponto
											  repl("=",11)+" "+;		//Especificado
											  repl("=",10)+" "+;		//Toler.Max
											  repl("=",10)+" "+;		//Toler.Max
											  repl("=",05)+" "+;	    //Tipo Toler
											  repl("=",09)+" "+;		//Unid.Med.
											  repl("=",09)+" "+;		//Num.Cert.  
											  repl("=",12)+"          "+;//Padrao Util.
											  repl("=",08)+"    "+;	//Valid. Ca
											  repl("=",09)             //Incerteza
							li++
							lCab := .F.
						EndIf
						@ li,001 PSAY alltrim(QM7->QM7_PONTO) + ' - ' + QM7->QM7_REVPAD
						@ li,025 PSAY QM7->QM7_ESPEC
						QM3->(DbSetOrder(1))
						QM3->(DbSeek(xFilial("QM3")+QM7->QM7_PONTO+Inverte(QM7->QM7_REVPAD)))
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Pego tolerancia informada no QMC. A do padrao serviu como suges-³
						//³ tao no momento da amarracao do padrao com a escala.             ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						QMC->(DbSetOrder(1))
						If QMC->(DbSeek(xFilial("QMC")+QM7->QM7_ESCALA+Inverte(QM7->QM7_REVESC)+QM7->QM7_PONTO))
							@ li,037 PSAY QMC->QMC_TOLER
							@ li,048 PSAY QMC->QMC_TOLMIN							
							cTipTol := QMC->QMC_TIPTOL
						Else
							@ li,037 PSAY QM3->QM3_TOLER 
							@ li,048 PSAY QM3->QM3_TOLMIN							
							cTipTol := QM3->QM3_TIPTOL
					EndIf           
					
					If cTipTol <> "1"
						@ li,60 PSAY "%"
					Endif
					
					SAH->(DbSetOrder(1))
					@ li,065 PSAY If(SAH->(DbSeek(xFilial("SAH")+QM3->QM3_UNIMED)),SAH->AH_UMRES,space(9))
					@ li,075 PSAY QM3->QM3_CERTIF
					@ li,085 PSAY QM3->QM3_PADUT
					@ li,107 PSAY DtoC(QM3->QM3_VALDAF)
					@ li,119 PSAY QM3->QM3_INCERT
					li++
					@ li,001 PSAY QM3->QM3_DESCRI
					li++
					dbSelectArea( "QM7" )
					dbSkip()
				EndDo
				cChave := TRB_INSTR+TRB_REVINS+dtos(TRB_DATA) +;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
			ElseIf QM9->QM9_TIPAFE $ "4,8"
				/*
				 	       Ponto          Nominal        LSE          LIE       Unid.Med            Escala
		 			  ================   ==========   ==========   ==========   =========   =======================
				 	  1234567890123456   1234567890   1234567890   1234567890   12345678    1234567890 a 1234567890
				*/
				cChave := TRB_INSTR+TRB_REVINS+dtos(TRB_DATA) +;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
				lCab := .T.
				QMG->(DbSetOrder(1))
				// aLTERADO DE QM6 PARA QM7 NA LINHA ABAIXO PARA INSTRUMENTO E REVISAO
				Do while cChave == QM7->QM7_INSTR+QM7->QM7_REVINS+dtos(QM7->QM7_DATA) +;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
					If QMG->(DbSeek(xFilial("QMG")+TRB_INSTR+TRB_REVINS+QM7->QM7_PONTO))
						If li > 55
							U_R140Cab()
							li++
							lCab := .t.
						EndIf
/*                          10        20        30        40        50        60        70        80        90        100       110       120       130
                  01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123
				 	       Ponto          Nominal        LSE          LIE       T.Tol. Unid.Med            Escala
		 			  ================   ==========   ==========   ==========   ====== =========   =======================
				 	  1234567890123456   1234567890   1234567890   1234567890   123456 12345678    1234567890 a 1234567890
*/
						If lCab
							@ li,009 PSAY OemToAnsi(STR0053) //Ponto
							@ li,024 PSAY OemToAnsi(STR0074) //Nominal
							@ li,039 PSAY OemToAnsi(STR0076) //LSE
							@ li,052 PSAY OemToAnsi(STR0075) //LIE
							@ li,062 PSAY OemToAnsi(STR0132) //T.Tol.  		
							@ li,069 PSAY OemToAnsi(STR0077) //Unid.Med.
							@ li,090 PSAY OemToAnsi(STR0052) //Escala   
							li++
							@ li,004 PSAY repl("=",16)+"   "+;
											  repl("=",10)+"   "+;
											  repl("=",10)+"   "+;
											  repl("=",10)+"   "+;
											  repl("=",06)+" "+;											  
											  repl("=",09)+"   "+;
											  repl("=",24)
							li++
							lCab := .F.
						EndIf
						@ li  ,004 PSAY QM7->QM7_PONTO
						@ li  ,023 PSAY QM7->QM7_ESPEC
						@ li  ,036 PSAY QMG->QMG_LIE
						@ li  ,049 PSAY QMG->QMG_LSE
						If QMG->QMG_TIPTOL <> "1"
							@ li  ,064 PSAY "%"
						Endif
						@ li  ,069 PSAY If(SAH->(DbSeek(xFilial("SAH")+QMG->QMG_UNIMED)),SAH->AH_UMRES,space(9))
	   				    @ li  ,081 PSAY QMG->QMG_ESCALI
					    @ li  ,093 PSAY "a"
						@ li  ,095 PSAY QMG->QMG_ESCALF
						li++
					EndIf
					DbSelectArea("QM7")
					QM7->(DbSkip())
				EndDo
				cChave := TRB_INSTR+TRB_REVINS+dtos(TRB_DATA) +;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
			ElseIf QM9->QM9_TIPAFE == "5"
				/*
		    		   Faixa         Especificado    Tolerancia  Unid.Med   Incerteza    Dt.Calib
				   ================   =============   ==========  ========   ==========   ==========
				   1234567890123456      1234567890   1234567890  12345678   1234567890   99/99/99
			*/
				cChave := TRB_INSTR+TRB_REVINS+dtos(TRB_DATA) +;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
				QMT->(DbSetOrder(1))
				// aLTERADO DE QM6 PARA QM7 NA LINHA ABAIXO PARA INSTRUMENTO E REVISAO
				Do while cChave == QM7->QM7_INSTR+QM7->QM7_REVINS+dtos(QM7->QM7_DATA) +;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
					If QMA->(DbSeek(xFilial("QMA")+QM7->QM7_ESCALA+QM7->QM7_REVESC+;
															 QM7->QM7_PONTO))
						If li > 55
							U_R140Cab()
							li++
							lCab := .t.
						EndIf
						If lCab
							@ li,009 PSAY OemToAnsi(STR0080)//Faixa
							@ li,022 PSAY OemToAnsi(STR0081)//Especificado
							@ li,037 PSAY OemToAnsi(cTTolQMA) //Toler.Maxima
							@ li,049 PSAY OemToAnsi(cTTMinQMA) //Toler.Minima
							@ li,062 PSAY OemToAnsi(STR0132) //T.Tol
							@ li,068 PSAY OemToAnsi(STR0083) //Unid.Med
							@ li,081 PSAY OemToAnsi(STR0084) //Incerteza
							@ li,093 PSAY OemToAnsi(STR0085) //Dt.Calib.
/*                       10        20        30        40        50        60        70        80        90        100       110
  	               45678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123
		    		    Faixa        Especificado   Toler.Max   Toler.Min    T.Tol Unid.Med     Incerteza   Dt.Calib.           
				   ================  =============  ==========  ==========   ===== ==========   ==========  ===========
				   1234567890123456  1234567890     1234567890  1234567890   12345 1234567890   01234567890 99/99/9999  
*/
							li++
							@ li,004 PSAY repl("=",16)+"  "+;			//Faixa
											  repl("=",13)+"  "+;     //Especificado
											  repl("=",10)+"  "+;     //Toler.Max
											  repl("=",10)+"   "+;     //Toler.Min
											  repl("=",05)+" "+;		//T.Tol
											  repl("=",10)+"   "+;    //Unid.Med.
											  repl("=",10)+"  "+;     //Incerteza
											  repl("=",10)				//Dt.Calib   
							li++
							lCab := .F.
						EndIf
						QMT->(DbSetOrder(1))
						QMT->(DbSeek(xFilial("QMT")+TRB_INSTR+TRB_REVINS+;
										 dtos(TRB_DATA)+QM7->QM7_ESCALA+QM7->QM7_REVESC+;
										 QM7->QM7_PONTO))
						nIncert := 0
						cIncerQM3 := ""
						dData := ctod("31/12/2050","DDMMYY")
						QM3->(DbSetOrder(1))
						Do while QMT->QMT_FILIAL+QMT->QMT_INSTR+QMT->QMT_REVINS+;
									dtos(QMT->QMT_DATA)+QMT->QMT_ESCALA+QMT->QMT_REVESC+;
									QMT->QMT_PONTO ==;
									TRB_FILIAL+TRB_INSTR+TRB_REVINS+;
									dtos(TRB_DATA)+QM7->QM7_ESCALA+QM7->QM7_REVESC+;
									QM7->QM7_PONTO
							If QM3->(DbSeek(xFilial("QM3")+QMT->QMT_PADRAO+Inverte(QMT->QMT_REVPAD)))
								If At(QM3->QM3_INCERT,".") > 0 // Se a incerteza foi cadastrada com ponto
									cIncerQM3 := StrTran(QM3->QM3_INCERT,".",",")
								Else
									cIncerQM3 := QM3->QM3_INCERT								                 	
								Endif
								nIncert += SuperVal(cIncerQM3) // Verificar p/ colocar SuperVal - Denis
								If(QM3->QM3_VALDAF < dData,dData := QM3->QM3_VALDAF,Nil)
							Endif
							QMT->(DbSkip())
						EndDo
						@ li  ,004 PSAY QM7->QM7_PONTO
						@ li  ,022 PSAY QM7->QM7_ESPEC
						@ li  ,037 PSAY QMA->QMA_TOLER
						@ li  ,049 PSAY QMA->QMA_TOLMIN
						If QMA->QMA_TIPTOL <> "1"
							@ li  ,063 PSAY "%" 
						Endif
						@ li  ,068 PSAY If(SAH->(DbSeek(xFilial("SAH")+QM3->QM3_UNIMED)),SAH->AH_UMRES,space(9))
						@ li  ,081 PSAY Alltrim(Str(nIncert))
						@ li  ,093 PSAY dtoc(dData)
						li++
					EndIf
					DbSelectArea("QM7")
					QM7->(DbSkip())
				EndDo
				cChave := TRB_INSTR+TRB_REVINS+dtos(TRB_DATA) +;
							 QM7->QM7_ESCALA+QM7->QM7_REVESC
			Else
				DbSelectArea("QM7")
				QM7->(DbSkip())
			EndIf
			lImpCabec := .T.
		EndDo  
EndIf	
Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³QMR140ICC ³Autora ³ Iuri Seto             ³ Data ³ 25/07/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprime Cabecalho da Calibracao.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMR140ICC()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMR140ICC()

li+=1
@ li,004 PSAY Repl("=",129)
li+=1

QAA->(DbSetOrder(1))
QAA->(DbSeek(TRB_FILRES+TRB_RESP))

QM7->(DbSetOrder(1))
QM7->(DbSeek(xFilial()+TRB_INSTR+TRB_REVINS+dtos(TRB_DATA)))

@ li,004 PSAY OemToAnsi(STR0030)+DtoC(TRB_DATA)+space(2)+; //"Data: "
			 	OemToAnsi(STR0031)+TRB_TOTHOR+space(1)+; //"Horas: "
			 	OemToAnsi(STR0032)+TRB_RESP+; // "Metrolog.: "
				" - " + SUBS(QAA->QAA_APELID,1,10) +space(1)+;
				OemToAnsi(cTDafQM6)+":"+DtoC(TRB_VALDAF)+space(1)+;   // Validade da Afericao					
				OemToAnsi(cTitCert)+":"+QM7->QM7_NRCERT+space(1)+;		// Num.Certif.
				OemToAnsi(cTitDep)+".:"+TRB_DEPQM2		// Departamento				
// Se inclui valor de R&R na calculo de Incerteza, imprimir
If cIncRR == "S" //GetMV("MV_QINCRR")
	li+=1
	@ li,004 PSAY OemToAnsi(cTitRepr)+":"+TRB_REPEPR		// Repe/Repro
EndIf
li+=1
@ li,004 PSAY Repl("=",129)

Return(Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³QMR140IIns³Autora ³ Iuri Seto             ³ Data ³ 25/07/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprime Dados do Instrumento.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMR140IIns(ExpC1)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ ExpC1 : Chave anterior do QM6                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMR140IIns(cChaveQM6)
Local ni := 1

If cChaveQM6 <> xFilial() + TRB_INSTR + Inverte(TRB_REVINS)
	cChaveQM6 := xFilial() + TRB_INSTR + Inverte(TRB_REVINS)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura o RESPONSAVEL NO QAA.                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QAA")
	dbSetOrder(1)
	MsSeek( xFilial() + TRB_RESQM2 )

	li+=2
	@ li,004 PSAY repl("-",52)+">>  " + OemToAnsi(cTitInstF) +; // "Instrumento"
				  "  <<"+repl("-",53)
	li+=2
	@ li,004 PSay OemToAnsi(cTitInst) + cInstrMan + " - " + TRB_REVQM2 // Instrumento
	li++
	@ li,004 PSAY OemToAnsi(cTitEscal) + ; // Familia
	QM1->QM1_TIPO + " - " + QM1->QM1_REVTIP + " - " + QM1->QM1_DESCR
	li++
	If lProcs
		@ li,004 PSAY OemToAnsi(cTitNor)	+ ;
		QA5->QA5_NORMA + "-" + QA5->QA5_REVPRO + " - " + QA5->QA5_DESCRI
	Else
		@ li,004 PSAY OemToAnsi(cTitNor)	+ ;
		QM1->QM1_PROCAL 
	Endif		
	li++
	
	@ li,004 PSAY OemToAnsi(cTDepto) + ; // Departamento
	TRB_DEPQM2 + " - " + Posicione("QAD",1,xFilial("QAD")+TRB_DEPQM2,"QAD_DESC")
	li++
	@ li,004 PSAY OemToAnsi(cTitLoc) + ; // Localizacao
	TRB_LOCAL
	li++
	@ li,004 PSAY OemToAnsi(cTitResp) + ; // Responsavel
	TRB_RESQM2 + " - " + QAA->QAA_NOME
	li++
	@ li,004 PSAY OemToAnsi(cTitNFab) + ; // Cod.Fabricante
	TRB_NUMQM2
	@ li,043 PSAY OemToAnsi(cTitFabr) + ; // Fabricante
	TRB_FABQM2
	li++
	@ li,004 PSAY OemToAnsi(cTTalim) + ; // Tensao Aliment
	TRB_TALQM2
	@ li,043 PSAY OemToAnsi(cTitLei) + ; // Leitura
	TRB_LEIQM2
	@ li,086 PSAY OemToAnsi(cTitSFab) + ; // Num.Serie
	TRB_NSEQM2
	li++
	@ li,004 PSAY OemToAnsi(cTitPot) + ; // Potencia
	TRB_POTQM2
	@ li,043 PSAY OemToAnsi(cTitCus) + ; // Custo
	TRB_CUSQM2
	@ li,086 PSAY OemToAnsi(cTitUso) + ; // Uso Inicial
	DtoC( TRB_USOQM2 )
	li++
	@ li,004 PSAY OemToAnsi(cTitFreq) + ; // Freq.Calib.
	StrZero(TRB_FREQM2,4) + " Dias"
	@ li,043 PSAY OemToAnsi(cTitResol) + ; // Erro de Resolucao
	TRB_SOLQM2
	li++
	// Procura descricao do Status
	QMP->(DbSetOrder(1))
	QMP->(DbSeek(xFilial("QMP")+TRB_STAQM2))
	@ li,004 PSAY OemToAnsi(cTitStat) + ; // Status
	If(QMP->(Found()),QMP->QMP_DESCR,space(36))
	
	li++
	@ li,004 PSAY OemToAnsi(cTitSeq) + cSeql // Sequencia
	
	If nIJInst == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Justificativa do Cadastro de Instrumento   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("QA3")
		dbSetOrder(1)
		

		li+=1
		@ li,004 PSAY repl("-",48)+">>  " + OemToAnsi(STR0128) +; // "Justificativa do Cadastro de Instrumento"
					  "  <<"+repl("-",48)
		li+=1						  

		cTextRet := ""
   	    axTex := {}
   
  		cTextRet := QA_Rectxt(TRB_CHAVE,"QMTA010S",1,130,"QA3")
   	    axTex := Q_MemoArray(cTextRet,axTex,130)
							  
		For ni := 1 To Len(axTex)            
			li+=1							  
			If li > 55
				Cabec( Titulo, cabec1, cabec2, NomeProg, cTamanho, IIF(aReturn[4]==1,15,18)) 
				li++
			EndIf
			@ li  ,004 PSAY axTex[ni]
		Next					  
							  
		li+=1
	EndIf		

EndIf

If nIJCali == 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Justificativa da mudanca de Status do Instrumento   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cChave := TRB_CHVQM6
	dbSelectArea("QA3")
	dbSetOrder(1)

	cTextRet := ""
	axTex := {}

	cTextRet := QA_Rectxt(cChave,"QMTA140S",1,130,"QA3")
	axTex := Q_MemoArray(cTextRet,axTex,130)

	li+=1
	@ li,004 PSAY repl("-",30)+">>  " + OemToAnsi(STR0129) +; // "Justificativa da mudanca de Status do Instrumento"
				  "  <<"+repl("-",30)
	li+=1

	For ni := 1 To Len(axTex)            
		If li > 55
			Cabec( Titulo, cabec1, cabec2, NomeProg, cTamanho, IIF(aReturn[4]==1,15,18)) 
			li++
		EndIf
		@ li  ,004 PSAY axTex[ni]
		li+=1
	Next ni

	li+=1
EndIf		

Return(Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³r140ITB   ³ Autor ³ Antonio Aurelio       ³ Data ³ 03.04.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o item Incerteza do Tipo B relacionado com o instr.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ r140ITB()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r140ITB()

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
//³ nPosITB, declarada como Private na fun‡Æo chamadora.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(aMedicoes[nCntFor,nPosITB,1,1]) //File(cArqQMS)
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
	For nCntFor := 1 to Len(aMedicoes) // [nCntFor,nPosITB])

		For nCntFor2 := 1 to Len(aMedicoes[nCntFor,nPosITB])
		
			If Empty(aMedicoes[nCntFor,nPosITB,nCntFor2,1])
				Loop
			EndIf
			
			li++
			If li > 55
				U_r140Cab()
				lCab := .T.
				li+= 2
			EndIf
			If lCab
				@ li,00 PSAY repl("=",132)
				li++
				nCnt := ( 132 - Len(STR0100)) / 2 //  INCERTEZA TIPO B
				@ li,00   PSAY "|"
				@ li,nCnt PSAY STR0100 //  "INCERTEZA TIPO B"
				@ li,131  PSAY "|"
				li++
				@ li,00 PSAY repl("=",132)
				li++
				@ li,00 PSAY STR0101 // "| Cod. Incerteza | Simbolo  | Fonte                        |Valor Incert.|Distr.| Divisor  |Coef.Sensib.| Incer.Calc. |Graus Liber.|"
				li++
				@ li,00 PSAY repl("-",132)
				li++
				lCab := .F.
			EndIf          
			If aMedicoes[nCntFor,nPosEsc] <> cEscala .or.;
			   aMedicoes[nCntFor,nPosPad] <> cPonto
				@ li ,000 PSAY "| "+STR0052+" : " + aMedicoes[nCntFor,nPosEsc] + "     " +;
				               STR0053+" : " + aMedicoes[nCntFor,nPosPad]  //"Escala"  //"Ponto"
				cEscala := aMedicoes[nCntFor,nPosEsc]
				cPonto := aMedicoes[nCntFor,nPosPad]
				@ li,131  PSAY "|"
				li++
				@ li,00 PSAY repl("-",132)
				li++
			EndIf
			@ li, 00 PSAY "|"
			@ li, 01 PSAY PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,1],16) // Cod. Incerteza
			@ li, 17 PSAY "|"
			@ li, 18 PSAY PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,2],10) // Simbolo
			@ li, 28 PSAY "|"
			@ li, 29 PSAY PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,3],30) // Fonte
			@ li, 59 PSAY "|"
			@ li, 60 PSAY PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,4],10) // Vl. Inc.
			@ li, 73 PSAY "|"
			@ li, 76 PSAY PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,5],01) // Distrib.
			@ li, 80 PSAY "|"
			@ li, 81 PSAY PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,6],10) // Divisor
			@ li, 91 PSAY "|"
			@ li, 92 PSAY PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,7],10) // Coef. Sensib.
			@ li,104 PSAY "|"
			@ li,106 PSAY PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,8],10) // Incert. Calc.
			@ li,118 PSAY "|"
			If Empty(aMedicoes[nCntFor,nPosITB,nCntFor2,9])			
				@ li,120 PSAY "*"
			Else
				@ li,120 PSAY PadR(aMedicoes[nCntFor,nPosITB,nCntFor2,9],10) // Graus Liber.
			Endif	
			@ li,131 PSAY "|"
			If li > 55
				U_r140Cab()
				lCab := .T.
				li+= 2
			EndIf
			nUi := aMedicoes[nCntFor,nPosITB,nCntFor2,8] // Coef. Sensib.
			If At(aMedicoes[nCntFor,nPosITB,nCntFor2,8],".") == 0
				aMedicoes[nCntFor,nPosITB,nCntFor2,8] := StrTran(aMedicoes[nCntFor,nPosITB,nCntFor2,8],".",",")			
			Endif
			If Valtype(nUi) == "C"
				nUi := SuperVal(nUi)**2 
			Else
				nUi := Val(nUi)**2 
			Endif
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
				If SuperVal(nUa) > (nUc / 2)
					nVeffTot := 0
					For nCnt := 1 To Len(aVeff)
						If aVeff[nCnt,2] > 0
							nVeffTot := nVeffTot +	(	(aVeff[nCnt,1]**4)*((10)**10) / aVeff[nCnt,2]*((10)**10) )
						EndIf
					Next
					If nVeffTot > 0
						nVeffTot := (nUc^4)*((10)**10) / nVeffTot*((10)**10)
					EndIf
				EndIf
				li++
				If li > 53
					U_r140Cab()
					li+= 2
				EndIf
				@ li,00 PSAY repl("-",132)
				li++
				@li,00  PSAY STR0102+Padr(AllTrim(Str(nUc)),12) // "|                | Uc       | Inc. Padrao Combinada        |             |Nor   |          |"
				@li,104 PSAY "|"
				@li,118 PSAY "|"
				@li,131 PSAY "|"
				li++
				@ li,00 PSAY repl("-",132)
				li++
				@li,00  PSAY STR0103+Padr(AllTrim(Str(nUc*2)),12) //  "|                | U        | Inc. Expandida               |             |Nor K |          |"
				@li,104 PSAY "|"
				@li,118 PSAY "|"
				@li,131 PSAY "|"
				li++
				@ li,00 PSAY Repl("-",132)
				li++
				If nCntFor2 <> 1 .and. SuperVal(aMedicoes[nCntFor,nPosITB,nCntFor2,9]) <> 1
					@li,00  PSAY  STR0104+Padr(AllTrim(Str(nVeffTot)),12)  // "|                | Ui       | Inc. Expandida               |             |Nor Kp|          |            |             |"
					@li,131 PSAY "|"
					li++				
				Endif	
				@ li,00 PSAY  Repl("=",132)
			EndIf
		Next
		
	Next
	
EndIf

Return .T.


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³QMR140Man ³Autora ³ Iuri Seto             ³ Data ³ 01/08/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprime Manutencoes do Instrumento.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMR140Man(ExpC1)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ ExpC1 : Codigo do Instrumento                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMR140Man(cInstrAnt)
Local lImpCab := .F.
Local Tamanho := ""
dbSelectArea("QME")
dbSetOrder(1)
If MsSeek( xFilial("QME")+cInstrAnt )
    Do While !Eof() .And. xFilial("QME")+cInstrAnt == QME->QME_FILIAL+QME->QME_INSTR
		If ( QME->QME_DATA >= mv_par03 .And. QME->QME_DATA <= mv_par04 )    
			If li > 55
				Cabec( Titulo, cabec1, cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18)) 
				li++ 
				lImpCab := .F.
			EndIf
			If !lImpCab
				U_QMR140CabM()
				lImpCab := .T.
			EndIf				
			@ li,004 PSAY QME->QME_REVINS
			@ li,018 PSAY QME->QME_DATA  
			@ li,032 PSAY QME->QME_RESP  
			@ li,056 PSAY QME->QME_QTDHOR
			@ li,070 PSAY QME->QME_LABOR 
			@ li,088 PSAY QME->QME_NRCERT
			li++		
		EndIf
		QME->(DbSkip())
	EndDo    
EndIf	


Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³QMR140CabM³Autora ³ Iuri Seto             ³ Data ³ 01/08/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprime cabecalho das Manutencoes do Instrumento.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMR140CabM()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMR140CabM()

li+=2
@ li,004 PSAY repl("-",52)+">>  " + OemToAnsi(STR0131) +; // "Manutencoes"
		  "  <<"+repl("-",53)
li+=2
lCabec := .T.    
//       1         2         3         4         5         6         7         8         9
// 456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
// Rev.Instr.    Data          Responsavel             Horas Manut.  Lab.Externo       Nro.Certif
// ============  ============  ======================  ============  ================  ============
//   XX          99/99/99      XXXXXX XXXXXXXXXXXXXXX      99:99     XXXXXXXXXXXXXXXX    XXXXXXXXX

@ li,004 PSAY OemToAnsi(cTitRev) // Rev.Instr.
@ li,018 PSAY OemToAnsi(cTitData) // Data
@ li,032 PSAY OemToAnsi(cTQMERes) // Responsavel
@ li,056 PSAY OemToAnsi(cTitHors) // Horas Manut.
@ li,070 PSAY OemToAnsi(cTitLabor) // Lab.Externo
@ li,088 PSAY OemToAnsi(cTitNCert) // Nro.Certif.
li++
@ li,004 PSAY REPL("=",12)
@ li,018 PSAY REPL("=",12)
@ li,032 PSAY REPL("=",21)
@ li,056 PSAY REPL("=",12)
@ li,070 PSAY REPL("=",12)
@ li,088 PSAY REPL("=",12)
li++

Return(Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR140CInc³ Autor ³ Wanderley Goncalves Jr³ Data ³ 20.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Cabecalho de Medicoes com Incerteza                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MTR140CInc()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cText                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR140CInc(cText,nLin)

Local nOrd := 0
Local cDesv := Padc(STR0087,10)
Local cDesIncert := Padc(STR0084,10)
Local cTotal := Padc(STR0096,10)

If cText == Nil
	cText := " "
EndIf

@ li,004 PSAY Repl("=",124)
li++
@ li,004 PSAY "|"
@ li,006 PSAY STR0052+" : " + ;  // "Escala"
         	AllTrim( aMedicoes[nLin,nPosEsc] ) + ;
          	" - " + ;
         	AllTrim( aMedicoes[nLin,nPosGer,1,11] )
@ li,127 PSAY "|"
li++

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Unidade de madida, valor minimo e maximo da escala    ³
//³  |  Valor Minimo: 9999999999    Valor Maximo: 9999999999      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nRec := QM9->(recno())
nOrd := QM9->(IndexOrd())
QM9->(dbSetOrder(1))
If QM9->(MsSeek(xFilial("QM9")+aMedicoes[nLin,nPosEsc] + Inverte(aMedicoes[nLin,nPosGer,1,11])))
	@ li,004 PSAY "|"
	@ li,006 PSAY STR0112+" : "+QM9->QM9_ESCALI  // "Valor Minimo"
	@ li,035 PSAY STR0113+" : "+QM9->QM9_ESCALF  // "Valor Maximo"
	@ li,094 PSAY STR0114+" : "+;                // "Unidade de Medida"
						IIf(SAH->(MsSeek(xFilial("SAH")+QM9->QM9_UNIMED)),;
							AllTrim(SAH->AH_UMRES),;
							Space(9) )
	@ li,127 PSAY "|"
	li++
EndIf
QM9->(dbGoto(nRec))
QM9->(dbSetOrder(nOrd))

@ li,004 PSAY Repl("=",124)
li++
@ li,004 PSAY "|"
@ li,025 PSAY "|"
@ li,047 PSAY "|"
@ li,048 PSAY Padc(STR0086,10)  // "Media"
@ li,058 PSAY "|"
@ li,059 PSAY cDesv // "Desvio"
@ li,069 PSAY "|"
@ li,070 PSAY cDesv // "Desvio"
@ li,080 PSAY "|"
@ li,081 PSAY cDesIncert  // "Incerteza"
@ li,091 PSAY "|"
@ li,092 PSAY cDesIncert // "Incerteza" 
@ li,102 PSAY "|"
@ li,103 PSAY Padc(STR0089,10)  // "Erro"
@ li,113 PSAY "|"
@ li,127 PSAY "|"
li++
@ li,004 PSAY "|"
@ li,005 PSAY STR0090  // Padrao 
@ li,025 PSAY "|"
@ li,026 PSAY STR0091  // Valores Encontrados
@ li,047 PSAY "|"
@ li,048 PSAY Padc(STR0092,10)  // Leituras
@ li,058 PSAY "|"
@ li,059 PSAY Padc(STR0093,10)  // "Medio"
@ li,069 PSAY "|"
@ li,070 PSAY Padc(STR0090,10)  // "Padrao"
@ li,080 PSAY "|"
@ li,081 PSAY Padc(STR0095,10) // Medicao
@ li,091 PSAY "|"
@ li,092 PSAY cTotal // Total
@ li,102 PSAY "|"
@ li,103 PSAY cTotal // Total
@ li,113 PSAY "|"
@ li,116 PSAY STR0097  // Status
@ li,127 PSAY "|"
    
li++

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR140CEsp³ Autor ³ Wanderley Goncalves Jr³ Data ³ 20.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Cabecalho de Medicoes em relacao a valores         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MTR140CEsp()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto ³ 20/06/00 ³ Alteracoes para calibrar Tipo de Calibracao Re- ³±±
±±³          ³          ³ logio.                        				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR140CEsp(nLin,nCntForM)



/*
   Escala            Rev  Padrao            Rev       V.Inicial      Dif.         %        V.Final       Dif.         %
   ================  ===  ================  ===       ==========  ==========  ==========  ==========  ==========  ==========
   1234567890123456  00   1234567890123456  00        9999999999  9999999999  9999999999  9999999999  9999999999  9999999999
*/

li++

@ li  ,004 PSAY OemToAnsi(STR0052)//Escala
@ li  ,022 PSAY OemToAnsi(STR0106) //Rev
@ li  ,027 PSAY OemToAnsi(STR0090) //Padrao
@ li  ,045 PSAY OemToAnsi(STR0106) //Rev
@ li  ,055 PSAY OemToAnsi(STR0108) //V.Inicial
@ li  ,070 PSAY OemToAnsi(STR0109) // Dif
@ li  ,083 PSAY OemToAnsi("%")
If aMedicoes[nLin,nPosGer,1,2] $ "2,5,3,8,9"  // Se nao for tipo simples ou calibrador, imprime final
	@ li  ,093 PSAY OemToAnsi(STR0108) //V.Inicial
	@ li  ,108 PSAY OemToAnsi(STR0109)  //"Dif."
	@ li  ,121 PSAY OemToAnsi("%")
EndIf

li++

@ li  ,004 PSAY repl("=",16)+"  "+;
					 repl("=",03)+"  "+;
					 repl("=",16)+"  "+;
					 repl("=",03)+"       "+;
					 repl("=",10)+"    "+;
					 repl("=",10)+"  "+;
					 repl("=",10) //+"  "+;

If aMedicoes[nLin,nPosGer,1,2] $ "2,5,3,8,9"
	@ li  ,093 PSAY repl("=",10)+"    "+;
					 	repl("=",10)+"  "+;
					 	repl("=",10)
EndIf

li++
If nTotCol == 4
	If nCntForM <= 2
		@ li   , 004 PSAY STR0021 // "Subida"
	Else
		@ li   , 004 PSAY STR0022 // "Descida"
	EndIf
	li++
EndIf

Return(Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR140Carg³ Autor ³ Wanderley Goncalves Jr³ Data ³ 12.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega aMedicoes, para calculo dos resultados para impres-³±±
±±³          ³ sao.                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MTR140Carg()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto ³ 20/06/00 ³ Alteracoes para calibrar Tipo de Calibracao Re- ³±±
±±³          ³          ³ logio.                        				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR140Carg(aRelResu)

Local   nRelResu
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

cMtInstr	:= TRB_INSTR
cMtRevIns := TRB_REVINS
dMtData	:= TRB_DATA
cMtResp	:= TRB_RESP
cMtTotHr	:= TRB_TOTHOR
cMtRepRepr:= TRB_REPEPR

dbSelectArea("TRB")

aMedicoes := {}

a140CarMed()

aResult := {}
nRelResu := 0

For nCntFor2 := 1 To len(aMedicoes)
	aadd(aResult, a140Calc(nCntFor2,.t.))
	If aMedicoes[nCntFor2,nPosGer,1,2] $ "3,9"
		If aMedicoes[nCntFor2,nPosGer,1,3] <> "A"
			If cEscala <> aMedicoes[nCntFor2,nPosEsc]	
			  	cEscala   	:= aMedicoes[nCntFor2,nPosEsc]	
				AADD(aRelResu,{cEscala,;							//  1- Escala
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
				AADD(aRelResu,{cEscala,;							//  1- Escala
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
			Endif	
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

Return(aResult)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R140NumCol³ Autor ³ Wanderley Goncalves Jr³ Data ³ 22.08.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna numero de colunas de medições                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R140NumCol()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nCntFor -> Linha da array aMedicoes posicionada            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto ³ 20/06/00 ³ Alteracoes para calibrar Tipo de Calibracao Re- ³±±
±±³          ³          ³ logio.                        				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R140NumCol(nCntFor)

Local nTotCol := 1

If aMedicoes[nCntFor,nPosGer,1,2] $ "1,4"
	nTotCol := 1
Elseif aMedicoes[nCntFor,nPosGer,1,2] $ "2,5,8"
		nTotCol := 2
Elseif aMedicoes[nCntFor,nPosGer,1,2] $ "3,9"
		nTotCol := 4
EndIf
If aMedicoes[nCntFor,nPosGer,1,3] == "A"
	nTotCol := 1
Endif
Return(nTotCol)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R140Dif   ³ Autor ³ Wanderley Goncalves Jr³ Data ³ 20.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula Diferenca entre Valor Encontrado e Nominal ou      ³±±
±±³          ³ limites                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R140Dif(nLin,nMin,nMax)                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nVal -> Valor Informado na Medicao                         ³±±
±±³          ³ nLin -> Linha de posicao no aMedicoes                      ³±±
±±³          ³ nMin -> Limite Minimo (para calculo c/relacao aos limites) ³±±
±±³          ³ nMax -> Limite Maximo (para calculo c/relacao aos limites) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R140Dif(nVal,nLin,nMin,nMax)

Local nValor    := 0
Local nRegistro := QM9->(recno())
Local nOrdem    := QM9->(IndexOrd())

QM9->(DbSetOrder(1))
QM9->(MsSeek(xFilial("QM9")+aMedicoes[nLin,nPosEsc]+Inverte(aMedicoes[nLin,nPosGer,1,11])))

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
±±³Fun‡…o    ³R140PerDif³ Autor ³ Wanderley Goncalves Jr³ Data ³ 20.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula Diferenca entre Valor Encontrado e Nominal ou      ³±±
±±³          ³ limites em percentual                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R140PerDif(nVal,nLin,nMin,nMax)                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nVal -> Valor Informado na Medicao                         ³±±
±±³          ³ nLin -> Linha de posicao no aMedicoes                      ³±±
±±³          ³ nMin -> Limite Minimo (para calculo c/relacao aos limites) ³±±
±±³          ³ nMax -> Limite Maximo (para calculo c/relacao aos limites) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R140PerDif(nVal,nLin,nMin,nMax)

Local nValor := 0
Local nOrdem := QM9->(Indexord())
Local nRegistro := QM9->(recno())

QM9->(DbSetOrder(1))
QM9->(MsSeek(xFilial("QM9")+aMedicoes[nLin,nPosEsc]+Inverte(aMedicoes[nLin,nPosGer,1,11])))
If QM9->QM9_PERRO == '1'   && % Erro em relacao ao especificado
   Do Case
   Case SuperVal(aMedicoes[nLin,nPosEsp]) == 0
		nValor := 0
   Otherwise
      nValor := ( (nVal - SuperVal(aMedicoes[nLin,nPosEsp])) / SuperVal(aMedicoes[nLin,nPosEsp]) ) * 100
   EndCase
Else                           && % Erro em relacao ao especificado +/- Tolerancia
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
±±³Fun‡…o    ³MTR140REsP³Autora ³ Iuri Seto             ³ Data ³ 21/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Rodape para Tipo de Calibracao Pressao             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MTR140REsP()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nCntFor, nCntForM                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR140REsP(aRelResu,cEscala,nCntFor)
Local nIndice

If !EMPTY(cEscala)
/*       1         2         3         4         5         6         7         8         9       110       120        
   456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
   ==================================================================================================================
   | Histerese                                                                                     |  1234567890    |
   ==================================================================================================================
*/
	nIndice := ASCAN(aRelResu,{ |x| x[1] == cEscala})

	li++	
	@ li,004 PSAY Repl("=",124)
	li++	
	@ li,004 PSAY "|"
	@ li,006 PSAY STR0126  //"Histerese"
	@ li,110 PSAY "|"
	@ li,113 PSAY aRelResu[nIndice,10] PICTURE QMT140Pics("aRelResu[nIndice,10]",;
														 aMedicoes[nCntFor,nPosEsp],.t.)
	@ li,127 PSAY "|"
	li++	
	@ li,004 PSAY Repl("=",124)
	li+=2

EndIf
	
Return(Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR140REsc³Autora ³ Iuri Seto             ³ Data ³ 21/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Rodape para Tipo de Calibracao Relogio             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MTR140REsc()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nCntFor, nCntForM                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR140REsc(aRelResu,cEscala,nCntFor)
Local nIndice

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

	li++	
	@ li,004 PSAY Repl("=",124)
	li++
	@ li,004 PSAY "|"
	@ li,053 PSAY STR0119	//"Parametros de Analise"
	@ li,127 PSAY "|"
	li++
	@ li,004 PSAY Repl("=",124)
	li++
	
	@ li,004 PSAY "|"
	@ li,006 PSAY STR0120	//"fe"
	@ li,011 PSAY "|"
	@ li,013 PSAY STR0121  //"Desvio Maximo no sentido crescente"
	@ li,110 PSAY "|"
	@ li,113 PSAY aRelResu[nIndice,6] PICTURE QMT140Pics("aRelResu[nIndice,6]",;
														 aMedicoes[nCntFor,nPosEsp],.t.)
	@ li,127 PSAY "|"
	li++
        
	@ li,004 PSAY "|"
	@ li,006 PSAY STR0122	//"fges"
	@ li,011 PSAY "|"
	@ li,013 PSAY STR0123  //"Desvio Total ( crescente / decrescente )"
	@ li,110 PSAY "|"
	@ li,113 PSAY aRelResu[nIndice,7] PICTURE QMT140Pics("aRelResu[nIndice,7]",;
														 aMedicoes[nCntFor,nPosEsp],.t.)
	@ li,127 PSAY "|"
	li++
	
	@ li,004 PSAY "|"
	@ li,006 PSAY STR0124	//"fu"
	@ li,011 PSAY "|"
	@ li,013 PSAY STR0125  //"Erro de Retorno"
	@ li,110 PSAY "|"
	@ li,113 PSAY aRelResu[nIndice,8] PICTURE QMT140Pics("aRelResu[nIndice,8]",;
														 aMedicoes[nCntFor,nPosEsp],.t.)
	@ li,127 PSAY "|"
	li++	

	@ li,004 PSAY Repl("=",124)
	li++	
	@ li,004 PSAY "|"
	@ li,006 PSAY STR0126  //"Histerese"
	@ li,110 PSAY "|"
	@ li,113 PSAY aRelResu[nIndice,10] PICTURE QMT140Pics("aRelResu[nIndice,10]",;
														 aMedicoes[nCntFor,nPosEsp],.t.)
	@ li,127 PSAY "|"
	li++	
	@ li,004 PSAY Repl("=",124)
	li+=2

EndIf
	
Return(Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³U_R140CM()  ³ Autor ³ Wanderley Goncalves Jr³ Data ³ 19.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Resultado Confirma‡ao Metrologica por Escala       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R140CM()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R140CM()

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
Local nIncTotEsc := 0
Local nErrSisEsc := 0
Local lExatEsc := .t.
Local lAceiEsc := .t.
Local lAdeqEsc := .t.
Local nNumDec := 0    // Numero de casas para exibir os valores.
Local cValor          // Nominal com maior numero de casas decimais na Escala
Local aResEsc := {}
Local aRetorno := {}

M->QM6_INSTR := TRB_INSTR
M->QM6_REVINS := TRB_REVINS
M->QM6_DATA  := TRB_DATA
M->QM6_REPEPR := TRB_REPEPR

nCntFor2 := 1
cEscala := aMedicoes[nCntFor2,nPosEsc]
lCab := .t.

Do while nCntFor2 <= Len(aMedicoes)
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
					If QA_NumDec(aMedicoes[nCntFor,nPosEsp]) > nNumDec
						nNumDec := QA_NumDec(aMedicoes[nCntFor,nPosEsp])
						cValor := aMedicoes[nCntFor,nPosEsp]
					EndIf
				EndIf
			Next nCntFor

			If li > 55
				U_R140Cab()
				li++
				lCab := .t.
			EndIf
			If lCab
				CabConfMet() // Imprime cabecalho de Confirmacao Metrologica
				lCab := .f.
			EndIf
			li++
			@ li  ,004 PSAY "|"
			@ li  ,007 PSAY cEscala
			@ li  ,025 PSAY "|"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Deve-se verificar se existe "cValor", pois o mesmo e utilizado na qmt140pics.³
		//³Se nao existir nao devera ser impresso.      	                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cValor <> NIL
				@ li  ,029 PSAY nIncTotEsc PICTURE QMT140Pics("nIncTotEsc",cValor,.t.)
			Endif	
			@ li  ,042 PSAY "|"
			If cValor <> NIL
				@ li  ,046 PSAY nErrSisEsc PICTURE QMT140Pics("nErrSisEsc",cValor,.t.)
			Endif	
			@ li  ,061 PSAY "|"
			@ li  ,064 PSAY If(lExatEsc,OemToAnsi(STR0070),OemToAnsi(STR0071)) //Aceito / Rejeitado
			@ li  ,079 PSAY "|"
			@ li  ,083 PSAY If(lAdeqEsc,OemToAnsi(STR0070),OemToAnsi(STR0071)) //Aceito / Rejeitado
			@ li  ,097 PSAY "|"
			@ li  ,100 PSAY If(lAceiEsc,OemToAnsi(STR0070),OemToAnsi(STR0071)) //Aceito / Rejeitado
			@ li  ,115 PSAY "|"
			li++
			@ li  ,004 PSAY repl("-",112)
			aadd(aResEsc,{nIncTotEsc,nErrSisEsc,lExatEsc,lAdeqEsc,lAceiEsc})
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
	nIncTotEsc := 0
	nErrSisEsc := 0
	lExatEsc := .t.
	lAceiEsc := .t.
	lAdeqEsc := .t.
	For nCntFor := 1 to Len(aResEsc)
		nIncTotEsc := If(aResEsc[nCntFor,1] > nIncTotEsc, aResEsc[nCntFor,1], nIncTotEsc)
		nErrSisEsc := If(aResEsc[nCntFor,2] > nErrSisEsc, aResEsc[nCntFor,2], nErrSisEsc)
		lExatEsc := If(lExatEsc,If(aResEsc[nCntFor,3],.t.,.f.),.f.)
                lAdeqEsc := If(lAdeqEsc,If(aResEsc[nCntFor,4],.t.,.f.),.f.)
                lAceiEsc := If(lAceiEsc,If(aResEsc[nCntFor,5],.t.,.f.),.f.)
	Next

	li++
	@ li  ,004 PSAY "|"
	@ li  ,007 PSAY OemToAnsi(STR0072) //CONF. INSTRUMENTO
	@ li  ,025 PSAY "|"
//	@ li  ,029 PSAY nIncTotEsc PICTURE QMT140Pics("nIncTotEsc",cValor,.t.)
	@ li  ,042 PSAY "|"
//	@ li  ,046 PSAY nErrSisEsc PICTURE QMT140Pics("nErrSisEsc",cValor,.t.)
	@ li  ,061 PSAY "|"
	@ li  ,064 PSAY If(lExatEsc,OemToAnsi(STR0070),OemToAnsi(STR0071)) //Aceito / Rejeitado
	@ li  ,079 PSAY "|"
	@ li  ,083 PSAY If(lAdeqEsc,OemToAnsi(STR0070),OemToAnsi(STR0071)) //Aceito / Rejeitado
	@ li  ,097 PSAY "|"
	@ li  ,100 PSAY If(lAceiEsc,OemToAnsi(STR0070),OemToAnsi(STR0071)) //Aceito / Rejeitado
	@ li  ,115 PSAY "|"
	li++
	@ li  ,004 PSAY repl("-",112)
	li++
EndIf

Return(Nil)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R140IMPTXT³ Autor ³ Wanderley Goncalves Jr³ Data ³ 14.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Texto do arquivo TXT passado como parametro        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R140IMPTXT(cArq,nTipo)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cArq := Arquivo a ser impresso                             ³±±
±±³          ³ nTipo:= Tipo de cabecalho (1-Certificado, 2-Analise de pp) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R140IMPTXT(cArq,nTipo)

Local Tamanho := " "
Local nCntFor
Local nCount
Local cAcentos  := "€ú‡úú?ú…ú†úƒú ú?úˆú‚ú¡ú“ú”ú¢ú™ú£ú"
Local cAcSubst  := "C,c,A~A'a`a~a^a'E'e^e'i'o^o~o'O~U'"


If File(cArq)
	cTexto:=MemoRead(cArq)
	For nCntFor := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nCntFor)
		cImpTxt   := ""
		cImpLinha := ""
		For nCount := 1 To Len(aLinha)
			cImpTxt := Substr(aLinha,nCount,1)
			If AT(cImpTxt,cAcentos)>0
				cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
			EndIf
			cImpLinha := cImpLinha+cImpTxt
		Next nCount
		@Li,04 PSAY cImpLinha
		Li++
		If li > 55
			If nTipo == 1
				Cabec( Titulo+"No. "+cCert, Cabec1, Cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18))
			Else
			   Cabec( Titulo, Cabec1, Cabec2, NomeProg, Tamanho, IIF(aReturn[4]==1,15,18))
			EndIf

		EndIf
	Next nCntFor
EndIf

Return(Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³R140InsEsc³ Autora³ Iuri Seto             ³ Data ³ 15/05/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o Código do Instrumento que se refere a Malha        ³
±±³          ³ enviada como parâmetro.                                      ³
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 : Codigo do Instrumento Malha     					  ³±±
±±³          ³ ExpC2 : Escala do Instrumento Malha     					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ ExpC1 : Código do Instrumento Filho                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ QMTR140													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R140InsEsc(cInstr,cEscala)
Local cOldAlias := Select()
Local nOrdem := IndexOrd()
Local nRegistro := Recno()
Local nQM2Ord := QM2->(IndexOrd())
Local nQM2Reg := QM2->(Recno())
Local cInsEsc

cInsEsc := " "

dbSelectArea("QM2")
dbSetOrder(7)
If QM2->(dbSeek(TRB_FILQM2+"M"+cInstr+cEscala))
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
±±³Fun‡…o    ³CabPadInst³ Autor ³ Wanderley Goncalves Jr³ Data ³ 15.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Cabecalho de Instrumentos ou Padrao Sec.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CabPadInst(cpoc)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cOpc == "I" - Instrumento Utilizado / "P" - Padrao Secund. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CabPadInst(cOpc)

li++
@ li  ,004 PSAY repl("=",112)
li++
@ li  ,004 PSAY "|"
If cOpc == "I"
	@ li  ,047 PSAY OemToAnsi(STR0050) //"INSTRUMENTOS UTILIZADOS"
Else
	@ li  ,050 PSAY OemToAnsi(STR0051) //"PADRAO SECUNDARIO"
EndIf
@ li  ,115 PSAY "|"
li++
@ li  ,004 PSAY repl("=",112)
li++
@ li  ,004 PSAY "|     " 	+ OemToAnsi(STR0052) //"Escala"
@ li  ,021 PSAY "|     " 	+ OemToAnsi(STR0053) //"Ponto"
If cOpc == "I"
	@ li  ,042 PSAY "|" 		 	+ OemToAnsi(STR0054)  //"Instrumento Util."
Else
	@ li  ,042 PSAY "|" 		 	+ OemToAnsi(STR0055) //"Padrao Secundario"
EndIf
@ li  ,060 PSAY "| " 		+ OemToAnsi(STR0056) //"Validade"
@ li  ,071 PSAY "| " 		+ OemToAnsi(STR0057) //"Incerteza"
@ li  ,083 PSAY "|" 			+ OemToAnsi(STR0058) //"Certificado"
@ li  ,098 PSAY "|   " 		+ OemToAnsi(STR0059) //"Laboratorio"
@ li  ,115 PSAY "|"
li++
@ li  ,004 PSAY repl('-',112)

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CabConfMet³ Autor ³ Wanderley Goncalves Jr³ Data ³ 19.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Cabecalho de Confirmacao Metrologica por Escala    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CabConfMet()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CabConfMet()

li++
@ li  ,004 PSAY repl("=",112)
li++
@ li  ,004 PSAY "|"
@ li  ,048 PSAY OemToAnsi(STR0064)  //"CONFIRMACAO METROLOGICA"
@ li  ,115 PSAY "|"
li++
@ li  ,004 PSAY repl("=",112)
li++
@ li  ,004 PSAY "|       "	    + OemToAnsi(STR0052)  //"Escala"
@ li  ,025 PSAY "|   "  	    + OemToAnsi(STR0057)  //"Incerteza"
@ li  ,042 PSAY "| "		 	    + OemToAnsi(STR0065)  //"Erro Sistematico"
@ li  ,061 PSAY "|    "        + OemToAnsi(STR0066)  //"Exatidao"
@ li  ,079 PSAY "|    "  	    + OemToAnsi(STR0067)  //"Adequacao"
@ li  ,097 PSAY "| "    	    + OemToAnsi(STR0068)  //"Aceitabilidade"
@ li  ,115 PSAY "|"
li++
@ li  ,004 PSAY repl('-',112)

Return(Nil)
