/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "QIER050.Ch"
#Include "PROTHEUS.CH"
#define Confirma 1
#define Redigita 2
#define Abandona 3

Static lQLTDispSVR := NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIER050  ³ Autor ³     Marcelo Pimentel  ³ Data ³ 08.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Certificado de Qualidade.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQie                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Vera        ³14/04/99³------³ Inclusao da Loja do Fornecedor           ³±±
±±³CesarValadao³01/09/99³PROTHE³Retirada funcao FClose() apos MemoWrite() ³±±
±±³Paulo Emídio³16/08/00³Melhor³ Revisao e compatibilizacao da funcao     ³±±
±±³            ³        ³      ³ CTOD().                                  ³±±
±±³Paulo Emidio³29/09/00³------³Alteracao na exibicao de caracteres invali³±±
±±³            ³        ³      ³dos.                                      ³±±
±±³Robson Ramir³25/04/01³FNC   ³Alteracao para cabecalho grafico.         ³±±
±±³Paulo Emidio³21/05/01³META  ³ Alterado programa para que possa ser sele³±±
±±³       	   ³		³	   ³ cionado o Tipo da Nota Fiscal de Entrada ³±±
±±³       	   ³		³	   ³ sendo a mesma 1)Normal 2)Beneficiamento  ³±±
±±³       	   ³		³	   ³ 3)Devolucao.							  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Qier050(lGerTXT,aDados)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salva a Integridade dos dados de Entrada                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aArea := GetArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nOpc    :=0 
Local oDlg
Local cTitulo :=""
Local cText1  :=""

Private lEnd  :=.F.
Private lEdit := .t.	// Para editar os textos

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para montar Get.                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aListBox  :={}
Private aMsg      :={}
Private aSel      :={}
Private aValid    :={}
Private aConteudo :={}
Private cPerg1    := "QER051"   
Private cRelDir   :=GetMv("MV_RELT") 

DEFAULT lGerTXT   := .F.

lQLTDispSVR := Iif(lQLTDispSVR == Nil, FindFunction("QLTDispSVR"), lQLTDispSVR)

If lQLTDispSVR .AND. FWSX1Util():ExistPergunte( "QIER052" ) .AND. QLTDispSVR("manufacturing.sv.qie.certificate")
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Janela Principal                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo := OemToAnsi(STR0001)	//"Certificado de Qualidade"
cText1  := OemToAnsi(STR0002)  	//"Neste relatorio sera impresso o Certificado de Qualidade"

If !lGerTxt
	DEFINE MSDIALOG oDlg TITLE cTitulo FROM  165,115 TO 315,525 PIXEL OF oMainWnd
	@ 03, 10 TO 43, 195 LABEL "" OF oDlg  PIXEL
	@ 10, 15 SAY cText1 SIZE 180, 8 OF oDlg PIXEL
	DEFINE SBUTTON FROM 50, 112 TYPE 5 ACTION (nOpc:=2,oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 50, 141 TYPE 1 ACTION (nOpc:=1,oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 50, 170 TYPE 2 ACTION (nOpc:=3,oDlg:End()) ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg
EndIf
	
If nOpc == 1 .or. lGerTxt
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Relat¢rio de Certificado deo Qualidade                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R050IMP(lGerTXT,aDados)
ElseIf nOpc == 2
	R050Processa()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura area                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aArea)

If lGerTXT
	Return(File(aDados[7]))
Else
	Return
EndIF

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R050Processa ³ Autor ³  Marcelo Pimentel ³ Data ³ 08/04/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento do QIER050                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R050Processa()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta tela para digitacao de itens.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lEnd:=A050Mont()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³   A050Mont   ³ Autor ³   Marcelo Pimentel³ Data ³ 08/04/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta Tela para digitacao dos textos.                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function a050Mont()
Local i       :=1
Local oListBox
Local nOpcA   :=2
Local oDlgGet

AADD(aListBox," ")
AADD(aListBox,OemToAnsi(STR0004))		//" Texto Superior "
AADD(aListBox,OemToAnsi(STR0005))		//" Texto Inferior "
AADD(aListBox,OemToAnsi(STR0006))		//" Impressao "
AADD(aListBox," ")

For i:= 1 To Len(aListBox)
	aListBox[i] := aListBox[i]
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa ListBox com opcoes para o array da configuracao          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlgGet TITLE STR0007 FROM  63,1 		TO 275,399 PIXEL OF oMainWnd		//"Certificado de Qualidade"
@ 12, 21 SAY OemToAnsi(STR0008)	SIZE 300, 07 OF oDlgGet PIXEL		//"Itens de Configuracao"
@ 20, 21 TO 82, 181 OF oDlgGet PIXEL
@ 33,28 LISTBOX oListBox VAR cVar FIELDS HEADER "" ON DBLCLICK (R050GetList(oListBox)) SIZE 147,42 PIXEL

oListBox:SetArray(aListBox)
oListBox:bLine := { ||{aListBox[oListBox:nAt]}}

DEFINE SBUTTON FROM 88, 110 TYPE 1 ACTION (nOpca:=1,oDlgGet:End()) ENABLE OF oDlgGet
DEFINE SBUTTON FROM 88, 150 TYPE 2 ACTION (nOpca:=2,oDlgGet:End()) ENABLE OF oDlgGet

ACTIVATE MSDIALOG oDlgGet CENTERED

If nOpca == 1
	R050IMP()
Else
	Return(NIL)	
EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R050GetList ³Autor³ Marcelo Pimentel      ³ Data ³ 19.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Get para edicao de Elemento relacionado ao ListBox    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIER050                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R050GetList(oListBox)
Local nAt :=oListBox:nAt

If nAt == 2 .Or. nAt == 3
	R050TEXT(oListBox)
ElseIf nAt == 4
	Pergunte(cPerg1,.T.)
Endif
Return    


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R050Text    ³Autor³ Marcelo Pimentel      ³ Data ³ 08.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Tela para preenchimento do conteudo relacionado com o ³±±
±±³          ³ListBox.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIER050                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R050Text(oListBox)
Local cTexto      := ""
Local nOpca       := 2
Local oFontMet    := TFont():New("Courier New",6,0)
Local oDlgGet2
Local oTexto
Local oFontDialog := TFont():New("Arial",6,15,,.T.)
Local oBox1

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

cNomeArq := "QER050"+Str(nAt,1)+".TXT"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Le arquivo                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTexto:=MemoRead(cNomeArq)
		
DEFINE MSDIALOG oDlgGet2 FROM	62,100 TO 345,610 TITLE  OemToAnsi(STR0008) PIXEL FONT oFontDialog		//"Itens de Configuracao"
@ 003, 004 TO 027, 250 LABEL "" 	OF oDlgGet2 PIXEL
@ 040, 004 TO 110, 250				OF oDlgGet2 PIXEL
@ 013, 010 MSGET oBox1 VAR aListBox[nAt] SIZE 235, 010 OF oDlgGet2 PIXEL
oBox1:lReadOnly := .t.

@ 050, 010 GET oTexto VAR cTexto MEMO NO VSCROLL WHEN lEdit SIZE 235, 051 OF oDlgGet2 PIXEL
oTexto:oFont := oFontMet
	
DEFINE SBUTTON FROM 120,190 TYPE 1 ACTION (nOpca := 1,oDlgGet2:End()) ENABLE OF oDlgGet2
DEFINE SBUTTON FROM 120,220 TYPE 2 ACTION (nOpca := 2,oDlgGet2:End()) ENABLE OF oDlgGet2
	
ACTIVATE MSDIALOG oDlgGet2 CENTERED

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
±±³Fun‡…o    ³ R050Imp  ³ Autor ³     Marcelo Pimentel  ³ Data ³ 08.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Certificado                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQie                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R050Imp(lGerTXT,aDados)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Par„metros para a fun‡„o SetPrint () ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel    :="QIER050"
Local cString  :="QER"
Local cDesc1   :=STR0009		//"Neste relatorio sera impresso os Certificados"
Local cDesc2   :=""
Local cDesc3   :=""

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Par„metros para a fun‡„o Cabec()  ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nTipo      := 0
Private cTitulo    := STR0010	//"Certificado Qualidade"
Private cRelatorio := "QIER050"
Private cTamanho   := "M"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas pela fun‡„o SetDefault () ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0011, 1,STR0012,  1, 2, 1, "",1 }		//"Zebrado"###"Administracao"
Private nLastKey := 0  
Private Perg     := "QER050"

nTipo := Iif(aReturn[4] == 1, 15, 18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01           // Fornecedor                             ³
//³ mv_par02           // Loja do Fornecedor                     ³
//³ mv_par03           // Produto                                ³
//³ mv_par04           // Data de Entrada                        ³
//³ mv_par05           // Lote                                   ³
//³ mv_par06           // Nota Fiscal                            ³
//³ mv_par07           // Serie                                  ³
//³ mv_par08           // Item          						 ³
//³ mv_par09           // Nr. Sequencial  						 ³
//³ mv_par10           // Nr. de Copias   						 ³
//³ mv_par11           // Impr. Ensaio Texto (Primeira/Todas)    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(Perg,.F.)

If lGerTXT 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Posições da array para geração do TXT     ³
	//³1 - Codigo do Fornecedor                  ³
	//³2 - Loja do Fornecedor                    ³ 
	//³3 - Nota Fiscal                           ³
	//³4 - Serie			                     ³
	//³5 - Item                                  ³ 
	//³6 - TipoNf                                ³ 
	//³7 - Caminho e nome do TXT que será gerado.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QEK")
	dbSetOrder(10)
	If dbSeek(xFilial("QEK")+aDados[1]+aDados[2]+aDados[3]+aDados[4]+aDados[5]+aDados[6])
		If !Empty(QEK->QEK_CERQUA) 
			mv_par01 := QEK->QEK_FORNEC	
			mv_par02 := QEK->QEK_LOJFOR
			mv_par03 := QEK->QEK_PRODUT
			mv_par04 := QEK->QEK_DTENTR
			mv_par05 := QEK->QEK_LOTE 			
			mv_par06 := QEK->QEK_NTFISC  
			mv_par07 := QEK->QEK_SERINF 
			mv_par08 := QEK->QEK_ITEMNF	
		Else 
			Return(.F.)	
		EndIF
	Else
		Return(.F.)	
	EndIF
		
EndIF                     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel  := SetPrint(cString,wnrel,Perg,@ctitulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,cTamanho,,.F.,,,lGerTXT)  
  
If nLastKey == 27
	Set Filter to
	Return
Endif

If lGerTXT
	SetPrintFile(wnrel)
EndIF
SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

If lGerTXT
	A050Imp(@lEnd,wnRel,cString,cTitulo,lGerTxt)
Else
	RptStatus({|lEnd| A050Imp(@lEnd,wnRel,cString,cTitulo,lGerTxt)},ctitulo)   
EndIf

If lGerTXT
	RmvToken(cRelDir+wnrel+".##R",aDados[7])
EndIF

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A050Imp  ³ Autor ³ Marcelo Pimentel      ³ Data ³ 08.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡Æo dos Certificados                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ A050Imp(lEnd,wnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQie                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A050Imp(lEnd,wnRel,cString,cTitulo,lGerTxt)
Local cData    := ""
Local cArqTxt  :=""
Local cTexto   :=""
Local cImpTxt  :=""
Local cEnsaio  :=""
Local cNomArq
Local cKey     :=""
Local cChave   :=""
Local cLabor   :=""
Local cProduto := ""
Local cRevi    :=""
Local cFornec  :=""
Local cLojFor  :=""
Local dDat     :=Ctod("  /  /  ")
Local cLote    :=""
Local cLaborat :=""
Local cAcentos := "€ú‡úŽúú…ú†úƒú úúˆú‚ú¡ú“ú”ú¢ú™ú£ú",cAcSubst := "C,c,A~A'a`a~a^a'E'e^e'i'o^o~o'O~U'"
Local aTexto   :={}
Local aTxtRes  :={}
Local aLinha   :={}
Local cImpLinha:={}
Local aMeses   := {STR0021,STR0022,STR0023,STR0024,STR0025,STR0026,STR0027,STR0028,STR0029,STR0030,STR0031,STR0032}	//"Janeiro"###"Fevereiro"###"Marco"###"Abril"###"Maio"###"Junho"###"Julho"###"Agosto"###"Setembro"###"Outubro"###"Novembro"###"Dezembro"
Local CbTxt
Local cbCont   :=00
Local cVlrMin  :=" "
Local cVlrMax  :=" "
Local cVlrUni  :=" "
Local nC       :=0
Local nCount   :=0
Local nV       :=1
Local nRec	   :=0
Local nAmostra :=0
Local nPorcent :=0
Local lUnic    :=.T.
Local nContador:=1
Local lImpTxt  := .T.
Local lMinFora := .F. 
Local cSeek    := ""
Local cNiseri  := ""
Local lNtEn    := .F.
Local cLaudo   := ""
Local lQReinsp := QieReinsp()
Local nQELRec  := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li       := 80
m_pag    := 1
Cabec1   := ""
Cabec2   := ""
nomeprog := "QIER050"

If !Empty(mv_par06)
	dbSelectArea("QEK")
	dbSetOrder(14)
	IF !(dbSeek(xFilial("QEK")+mv_par01+mv_par02+mv_par03+mv_par06+mv_par07))
        While !(Eof()) .and. xFilial("QEK")+mv_par01+mv_par02+mv_par03+mv_par06+mv_par07 ==;
	        QEK->QEK_FILIAL+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+QEK->QEK_NTFISC+QEK->QEK_SERINF

    	    If !lNtEn
	    	    If DTOS(mv_par04) <> DTOS(QEK->QEK_DTENTR) .And. mv_par05 <> QEK->QEK_LOTE .And. mv_par08 <> QEK->QEK_ITEMNF
					lNtEn := .F.			 
				Else	
					If lQReinsp
						If QEK->QEK_NUMSEQ == mv_par09
							lNtEn := .T.
							Exit
						Endif
					Else
						lNtEn := .T.
						Exit
					Endif
				Endif		
			Endif

			dbSelectArea("QEK")
			dbSkip()
		Enddo
				
		If !lNtEn
			Set Device to Screen
			Help(" ",1,"QE_NAOENTR")	// "Entrada nao cadastrada."
			dbSelectArea("QER")
			dbSetOrder(1)
			Return
		Endif	
	Else
        While !(Eof()) .and. xFilial("QEK")+mv_par01+mv_par02+mv_par03+mv_par06+mv_par07 ==;
	        QEK->QEK_FILIAL+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+QEK->QEK_NTFISC+QEK->QEK_SERINF

    	    If DTOS(mv_par04) == DTOS(QEK->QEK_DTENTR) .And. mv_par05 == QEK->QEK_LOTE .And. mv_par08 == QEK->QEK_ITEMNF
    	    	If lQReinsp
					If QEK->QEK_NUMSEQ == mv_par09
						cTitulo += " - "+QEK_CERQUA	
						Exit
					Endif
    	    	Else
					cTitulo += " - "+QEK_CERQUA	
					Exit
				Endif
			Endif
			dbSelectArea("QEK")
			dbSkip()
		Enddo
	EndIf
Else
	dbSelectArea("QEK")
	dbSetOrder(1)
	IF !(dbSeek(xFilial("QEK")+mv_par01+mv_par02+mv_par03+Inverte(mv_par04)+;
			Inverte(mv_par05)))
		Set Device to Screen
		Help(" ",1,"QE_NAOENTR")	// "Entrada nao cadastrada."
		dbSelectArea("QER")
		dbSetOrder(1)
		Return
	Else
		cTitulo += " - "+QEK_CERQUA	
	EndIf
EndIF

cCond := 'QER_FILIAL == "'+xFilial("QER") +'"'
cCond += '.And. QER_FORNEC=="'+mv_par01+'" .And.QER_LOJFOR=="'+mv_par02+'"'
cCond += '.And.QER_PRODUT=="'+mv_par03+'"'
cCond += '.And.DTOS(QER_DTENTR)=="'+DTOS(mv_par04)+'" .And.QER_LOTE=="'+mv_par05+'"'

cSeek := xFilial("QER")+mv_par03+QEK->QEK_REVI+mv_par01+mv_par02+DTOS(mv_par04)+mv_par05

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01           // Resultados:1-Minimo/Maximo 2-Vlr.Unico ³
//³ mv_par02           // Observacao da Entrada:  1-Sim 2-Nao    ³
//³ mv_par03           // Justificativa do Laudo: 1-Sim 2-Nao    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg1,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona o Fornecedor ou Cliente se a NFE igual  a "B" ou "D"³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If QEK->QEK_TIPONF $ "D/B"
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)
	
Else
	dbSelectArea("SA2")
	dbSetOrder(1)
	dbSeek(xFilial("SA2")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)
	
EndIf

dbSelectArea("QE6")
dbSetOrder(1)
dbSeek(xFilial("QE6")+QEK->QEK_PRODUT+Inverte(QEK->QEK_REVI))

If Empty(mv_par10)	//Nr. Copias
	mv_par10 := 1
EndIf

SetRegua(mv_par10)

For nContador := 1 To mv_par10

	IncRegua(nContador)		//Incrementar a Regua
	
	m_pag := 1
	Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)

	cData := AllTrim(SM0->M0_CIDENT)+","+ Str(day(dDataBase)) + STR0014 + aMeses[month(dDataBase)] + STR0014 + StrZero(year(dDataBase),4)		//" de "###" de "
	@ Li,132-Len(cData) PSAY cData
	Li+=2
	@Li,01 PSAY AllTrim(TitSX3("QEK_PRODUT")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_PRODUT")[1])))+":"
	@Li,27 PSAY AllTrim(QEK->QEK_PRODUT)+" - "+AllTrim(QE6->QE6_DESCPO) +" - "+QEK->QEK_REVI
	Li++
	@Li,01 PSAY AllTrim(TitSX3("QEK_FORNEC")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_FORNEC")[1])))+":"
	If QEK->QEK_TIPONF $ "B/D"
		@Li,27 PSAY QEK->QEK_FORNEC+"/"+QEK->QEK_LOJFOR+" - "+SA1->A1_NOME
	Else
		@Li,27 PSAY QEK->QEK_FORNEC+"/"+QEK->QEK_LOJFOR+" - "+SA2->A2_NOME
	EndIf	
	Li++
	@Li,01 PSAY AllTrim(TitSX3("QEK_DTENTR")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_DTENTR")[1])))+":"
	@Li,27 PSAY QEK->QEK_DTENTR
	@Li,62 PSAY AllTrim(TitSX3("QEK_LOTE")[1])+Replicate(".",19-Len(AllTrim(TitSX3("QEK_LOTE")[1])))+":"
	@Li,85 PSAY QEK->QEK_LOTE
	Li++
	@Li,01 PSAY AllTrim(TitSX3("QEK_NTFISC")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_NTFISC")[1])))+":"
	@Li,27 PSAY QEK->QEK_NTFISC
	@Li,62 PSAY AllTrim(TitSX3("QEK_DTNFIS")[1])+Replicate(".",19-Len(AllTrim(TitSX3("QEK_DTNFIS")[1])))+":"
	@Li,85 PSAY QEK->QEK_DTNFIS
	Li++
	@Li,01 PSAY AllTrim(TitSX3("QEK_PEDIDO")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_PEDIDO")[1])))+":"
	@Li,27 PSAY QEK->QEK_PEDIDO
	@Li,62 PSAY AllTrim(FwX3Titulo("QEK_DOCENT"))+Replicate(".",19-Len(AllTrim(FwX3Titulo("QEK_DOCENT"))))+":"
	@Li,85 PSAY QEK->QEK_DOCENT
	Li++
	@Li,01 PSAY AllTrim(TitSX3("QEK_CERFOR")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_CERFOR")[1])))+":"
	@Li,27 PSAY QEK->QEK_CERFOR
	@Li,62 PSAY AllTrim(TitSX3("QEK_TAMLOT")[1])+Replicate(".",19-Len(AllTrim(TitSX3("QEK_TAMLOT")[1])))+":"
	SAH->(dbSetOrder(1))
	SAH->(dbSeek(xFilial("SAH")+QEK->QEK_UNIMED))
	@Li,85 PSAY QEK->QEK_TAMLOT+" "+SAH->AH_UMRES
	Li++
	@Li,01 PSAY AllTrim(TitSX3("QE6_APLIC")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QE6_APLIC")[1])))+":"
	@Li,27 PSAY QE6->QE6_APLIC
	Li++
	@Li,01 PSAY AllTrim(TitSX3("QE6_CROQUI")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QE6_CROQUI")[1])))+":"
	@Li,27 PSAY QE6->QE6_CROQUI
	Li+=2

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chave de ligacao da medicao com outros arquivos              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cChave := QER->QER_CHAVE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto de Entrada - QA2        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par02 == 1
		dbSelectArea("QA2")
		dbSetOrder(1)
		If dbSeek(xFilial("QA2")+"QIEA200 "+cChave)
			While !Eof() .And. xFilial("QA2") == QA2->QA2_FILIAL .And. ;
				QA2->QA2_CHAVE == cChave
				
				@Li,01 PSAY STR0033+StrTran(QA2_TEXTO, "\13\10", "")	//"OBS.: "
				If Li > 56
                    Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
				EndIf
				Li++
				dbSkip()
			EndDo
		EndIf
	EndIf	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto superior                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqTxt := "QER0502"+".TXT"
	If File(cArqTxt)
		cTexto:=MemoRead(cArqTxt)
		For nC := 1 To MLCOUNT(cTexto,130)
			aLinha := MEMOLINE(cTexto,130,nC)
			cImpTxt   := ""
			cImpLinha := ""
			For nCount := 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			@Li,01 PSAY cImpLinha
			Li++
		Next nC
		Li++
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ CABECALHO DOS RESULTADOS ENCONTRADOS          	 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//                                                                                  Especificado                    Encontrado
	//Ensaio                                         Metodo            Un.Med      Minimo          Maximo         Minimo           Maximo
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo dos Ensaios especificado com Encontrado           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	dbSelectArea("QER")
	DbSetOrder(1)
	dbGoTop()
	SetRegua(RecCount())
	
	DbSeek(cSeek)
	
	While !Eof() .and. &cCond

		IncRegua()
		
		If lQReinsp
			If QER->QER_NUMSEQ <> mv_par09
				QER->(dbSkip())
				Loop
			Endif
		Endif
		
		If !Empty(mv_par06)
			If !(SubsTr(QER_NISERI,1,TamSX3("D1_DOC")[1]) == mv_par06 .And. ;
				SubsTr(QER_NISERI,TamSX3("D1_DOC")[1]+1,TamSX3("D1_SERIE")[1]) == mv_par07 .And. ;
				SubsTr(QER_NISERI,(TamSX3("D1_DOC")[1]+1+TamSX3("D1_SERIE")[1]),TamSX3("D1_ITEM")[1]) == mv_par08)
				
				QER->(dbSkip())
				Loop
			Endif
		EndIf

		If cLabor <> QER_LABOR
			cLabor := QER_LABOR
			Li++
			@Li,01 PSAY STR0015+QER_LABOR		//"LABORATORIO : "
			Li++
			
			@Li,82 PSAY STR0016		//"Especificado"
			If mv_par01 == 1
				@Li,114 PSAY STR0017	//"Encontrados"
			EndIf	
			Li++
			@Li,001 PSAY TitSX3("QER_ENSAIO")[1]
			@Li,047 PSAY TitSX3("QE7_METODO")[1]
			@Li,065 PSAY Subs(TitSX3("QE7_UNIMED")[1],1,9)
			@Li,077 PSAY STR0018		//"Minimo"
			@Li,093 PSAY STR0019		//"Maximo"
			If mv_par01 == 1
				@Li,108 PSAY STR0018	//"Minimo"
				@Li,125 PSAY STR0019	//"Maximo"
			Else
				@Li,106 PSAY STR0020	//"Encontrado"
			EndIf
			Li++
			@Li,01 PSAY Replicate("=",130)
			Li++
		EndIf
		If Li > 56
            Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
		EndIf

		dbSelectArea("QE1")
		dbSetOrder(1)
		If dbSeek(xFilial("QE1")+QER->QER_ENSAIO)
			If QE1->QE1_CARTA <> "TXT"
				@Li,01 PSAY QE1->QE1_DESCPO		
				dbSelectArea("QE7")
				dbSetOrder(1)
				If dbSeek(xFilial("QE7")+QER->QER_PRODUT+QER->QER_REVI+QER->QER_ENSAIO)
					@Li,47 PSAY QE7_METODO
					SAH->(dbSeek(xFilial("SAH")+QE7->QE7_UNIMED))
					@Li,65 PSAY SAH->AH_UMRES
					If QE7_MINMAX == "1"
						@Li,75 PSAY QE7_LIE
						@Li,91 PSAY QE7_LSE
					ElseIf QE7_MINMAX == "2"
						@Li,75 PSAY QE7_LIE
						@Li,91 PSAY ">>>"
					ElseIf QE7_MINMAX == "3"
						@Li,75 PSAY "<<<"
						@Li,91 PSAY QE7_LSE
					EndIf
				EndIf
			Else
				@Li,001 PSAY QE1->QE1_DESCPO
				dbSelectArea("QE8")
				dbSetOrder(1)
				dbSeek(xFilial()+QER->QER_PRODUT+QER->QER_REVI+QER->QER_ENSAIO)
				@Li,047 PSAY QE8_METODO
			EndIf
			If Li > 56
				Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			EndIf
			
			cProduto := QER->QER_PRODUT
			cRevi	 := QER->QER_REVI
			cFornec	 := QER->QER_FORNEC
			cLojFor	 := QER->QER_LOJFOR
			dDat	 := QER->QER_DTENTR
			cLote	 := QER->QER_LOTE
			cLaborat := QER->QER_LABOR
			cEnsaio	 := QER->QER_ENSAIO                                                              
	
	  
			dbSelectArea("QER")
			QER->(dbSetOrder(1))
			cSeekQER    := "QER_FILIAL+QER_PRODUT+QER_REVI+QER_FORNEC+QER_LOJFOR+DTOS(QER_DTENTR)+QER_LOTE+QER_LABOR+QER_ENSAIO"
			cCompQER    := xFilial('QER')+cProduto+cRevi+cFornec+cLojFor+DTOS(dDat)+cLote+cLaborat+cEnsaio

			QER->(dbSetOrder(5))
			cSeekQER    := "QER_FILIAL+QER_PRODUT+QER_REVI+QER_FORNEC+QER_LOJFOR+QER_NISERI+QER_TIPONF+QER_LOTE+QER_LABOR+QER_ENSAIO"
			cNiseri := QER->QER_NISERI
			cTipNoF := QER->QER_TIPONF			
			cCompQER    := xFilial('QER')+cProduto+cRevi+cFornec+cLojFor+cNiseri+cTipNoF+cLote+cLaborat+cEnsaio

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Definicao das vari veis para impressao da Cartas de Controle:     ³
			//³ XBR,XBS,XMR,IND,HIS,C,NP,U,P : cVlrMin,cVlrMax,cVlrUni            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			lImpTxt:= .T.
			lMinFora := .F.
			While !Eof() .And. cCompQER == &cSeekQER
				
				If lQReinsp
					If QER->QER_NUMSEQ <> mv_par09
						QER->(dbSkip())
						Loop
					Endif
				Endif

				If li > 56
					Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
				EndIf

				IncRegua()
			
				cChave:= QER->QER_CHAVE

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Os tipos de cartas:XBR|XBS|XMR|IND|HIS - Se o param. for "Minimo/  ³
				//³Maximo"-ira considerar o menor e o maior valor. Se o param. for    ³
				//³"Valor Unico-Ser  o maior valor encontrado ou menor fora da espec. ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If QE1->QE1_CARTA$"XBR/XBS/XMR/IND/HIS"
					dbSelectArea("QES")
					dbSetOrder(1)
					If dbSeek(xFilial("QES")+cChave)
						While !Eof() .And.	QES_FILIAL == xFilial("QES") .And. QES_CODMED == cChave
							cVlrMin:=If(SuperVal(QES_MEDICA)<SuperVal(cVlrMin) .Or. SuperVal(cVlrMin)==0,QES_MEDICA,cVlrMin)
							cVlrMax:=If(SuperVal(QES_MEDICA)>SuperVal(cVlrMax) .Or. SuperVal(cVlrMax)==0,QES_MEDICA,cVlrMax)

							If mv_par01 == 2 // Valor Unico
								If SuperVal(cVlrMin) < SuperVal(QE7->QE7_LIE)
									cVlrUni := cVlrMin
									lMinFora:= .T.
								EndIf
								If !lMinFora
									If SuperVal(cVlrMax) > SuperVal(QE7->QE7_LSE) .Or. SuperVal(cVlrMax) > SuperVal(cVlrUni) .Or. SuperVal(cVlrUni) == 0
										cVlrUni := cVlrMax
									EndIf
								EndIf
							EndIf
							dbSkip()
						EndDo
					EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³O tipo de Carta:TMP (Tempo).						                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				ElseIf QE1->QE1_CARTA == "TMP" 
				
	   				dbSelectArea("QES")
					dbSetOrder(1)
					If dbSeek(xFilial("QES")+cChave)
						While !Eof() .And.	QES_FILIAL == xFilial("QES") .And. QES_CODMED == cChave
							cVlrMin:=If(QA_HTOM(QES_MEDICA)<QA_HTOM(cVlrMin) .Or. Val(QA_HTOM(cVlrMin))==0,QES_MEDICA,cVlrMin)
							cVlrMax:=If(QA_HTOM(QES_MEDICA)>QA_HTOM(cVlrMax),QES_MEDICA,cVlrMax)

							If mv_par01 == 2 // Valor Unico
								If QA_HTOM(cVlrMin) < QA_HTOM(QE7->QE7_LIE)
									cVlrUni := cVlrMin
									lMinFora:= .T.
								EndIf
								If !lMinFora
									If QA_HTOM(cVlrMax) > QA_HTOM(QE7->QE7_LSE) .Or. QA_HTOM(cVlrMax) > QA_HTOM(cVlrUni) .Or. Val(QA_HTOM(cVlrUni)) == 0
										cVlrUni := cVlrMax
									EndIf
								EndIf
							EndIf
							dbSkip()
						EndDo
					EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³O tipo de Carta:TXT ir  o 1o. resultado encontrado.              ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				ElseIf QE1->QE1_CARTA == "TXT" .And. ;
						((Len(aTexto) == 0 .And. Len(aTxtRes) == 0) .Or. mv_par11 == 2)  // Imprime Todas Medicoes
					
					If Len(aTexto) == 0
						aTexto := QJustTxt(QE8->QE8_TEXTO,34)
					EndIf
				
					If Len(aTxtRes) == 0
						dbSelectArea("QEQ")
						dbSetOrder(1)
						dbSeek(xFilial()+cChave)
						aTxtRes := QJustTxt(QEQ_MEDICA,25)
					EndIf
				
					nTot:= IIF(Len(aTexto)>Len(aTxtRes),Len(aTexto),Len(aTxtRes))

					For nC := 1 to nTot
						If lImpTxT
							If Len(aTexto) >= nC
								If	!Empty(aTexto[nC])
									@Li,065 PSAY aTexto[nC]
								EndIf
							EndIf	
						EndIf
						If  Len(aTxtRes) >= nC
							If	!Empty(aTxtRes[nC])
								@Li,106 PSAY aTxtRes[nC]
							EndIf
						EndIf
						If Li > 56
							Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
						EndIf
						Li++
					Next nC
					lImpTxt:= .F.
					aTxtRes:= {}
					
				ElseIf QE1->QE1_CARTA$"C  /NP "
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Os tipos de carta : C / NP -Se o param. for "Minimo/Maximo", o Mi- ³
					//³nimo ser  0, o M ximo ser  o maior valor da 1a. medicao do QES p/  ³
					//³cada data/hora. Sempre existem 1 medi‡Æo para cada data/hora.      ³
					//³Se param. for "Valor Unico" - Ser  o maior valor do QES.           ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
					dbSelectArea("QES")
					dbSetOrder(1)
					If dbSeek(xFilial("QES")+cChave)
						While !Eof() .And.	QES_FILIAL == xFilial("QES") .And. QES_CODMED == cChave
							cVlrMax := If(SuperVal(QES_MEDICA)>SuperVal(cVlrMax),QES_MEDICA,cVlrMax)
							dbSkip()
						EndDo
						If mv_par01 == 2 // Valor Unico
							If SuperVal(cVlrMax) > SuperVal(QE7->QE7_LSE) .Or. SuperVal(cVlrMax) > SuperVal(cVlrUni) .Or. SuperVal(cVlrUni) == 0
								cVlrUni := cVlrMax
							EndIf
						EndIf
					EndIf
			
				ElseIf AllTrim(QE1->QE1_CARTA)=="U"
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³O  tipo  de carta : U      -Se o param. for "Minimo/Maximo", o Mi- ³
					//³nimo ser  0, o M ximo ser  o maior valor da 2a. medicao do QES p/  ³
					//³cada data/hora. Sempre existem 2 regs. medi‡äes para cada data/hora³
					//³Se param. for "Valor Unico" - Ser  a 2a. medi‡Æo do QES para a 1a. ³
					//³data/hora.                                                         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("QES")
					dbSetOrder(1)
					If dbSeek(xFilial("QES")+cChave)
						While !Eof() .And. 	QES_FILIAL == xFilial("QES") .And. QES_CODMED == cChave
							If nV == 2
								cVlrMax:=If(SuperVal(QES_MEDICA)>SuperVal(cVlrMax),QES_MEDICA,cVlrMax)
								nV:=0
								If mv_par01 == 2 .And. lUnic
									cVlrUni := QES_MEDICA
									lUnic:= .F.
								EndIf
							EndIf
							nV++
							dbSkip()
						EndDo
					EndIf
				
				ElseIf AllTrim(QE1->QE1_CARTA)=="P"
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³O  tipo  de carta : P      -Se o param. for "Minimo/Maximo", o Mi- ³
					//³nimo ser  0, o M ximo ser  o maior valor de :                      ³
					//³Amostra * (Porcent./100)                                           ³
					//³Se param. for "Valor Unico" - Ser  o maior valor da Amostra:       ³
					//³Amostra * (Porcent./100)                                           ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("QES")
					dbSetOrder(1)
					If dbSeek(xFilial("QES")+cChave)
						While !Eof() .And. 	QES_FILIAL == xFilial("QES") .And. QES_CODMED == cChave
													
							If QES_INDMED == "A"
								nAmostra := SuperVal(QES_MEDICA)
							ElseIf QES_INDMED == "P"
								nPorcent := SuperVal(QES_MEDICA)
							EndIf
							If !Empty(nAmostra) .And. !Empty(nPorcent)
								cVlrMax:= If(nAmostra * (nPorcent / 100 )>SuperVal(cVlrMax),AllTrim(Str(nAmostra*(nPorcent/100))),cVlrMax)
								nAmostra:=0
								nPorcent:=0
								If mv_par01 == 2 // Valor Unico
									cVlrUni := IIF(ValType(cVlrMax)=="N",STR(cVlrMax),cVlrMax)
								EndIf
							EndIf
							dbSkip()
						EndDo
					EndIf
				EndIf
				If Li > 56
					Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
				EndIf
				dbSelectArea("QER")
				dbSkip()
				nRec:=Recno()
			EndDo

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Faz impressÆo de todas as cartas                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If QE1->QE1_CARTA$"XBR/XBS/XMR/IND/HIS/TMP"
				If mv_par01 == 1
					@Li,099 PSAY PadL(AllTrim(cVlrMin),15)
					@Li,116 PSAY PadL(AllTrim(cVlrMax),15)
				Else
				    @Li,099 PSAY PadL(AllTrim(cVlrUni),15)
				EndIf
			ElseIf AllTrim(QE1->QE1_CARTA)$"C/NP/U/P"
				If mv_par01 == 1
					@Li,099 PSAY PadL("0",15)
					@Li,116 PSAY PadL(AllTrim(cVlrMax),15)
				Else
					@Li,099 PSAY PadL(AllTrim(cVlrUni),15)
				EndIf
			EndIf
			
			If QE1->QE1_CARTA == "TXT"
				aTexto:={}
				aTxtRes:={}
			Else
				cVlrMin := " "
				cVlrMax := " "
				cVlrUni := " "
				lUnic   :=.T.
				Li++
			EndIf	
			Li++
			@Li,01 PSAY Replicate("-",130)
            Li++    
            
            If Li > 56
				Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			EndIf
						
			dbSelectArea("QER")
			If nRec > 0
				dbGoTo(nRec)
			Else 
				QER->(dbSkip())
			Endif	
		EndIf
	EndDo

	dbSelectArea("QEL")

	cNiseri	:= QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
	dbSetOrder(3) 
	cSeek	:= QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+cNiseri+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE+;
	Space(TamSX3("QEL_LABOR")[1])

	If dbSeek(xFilial("QEL")+cSeek)
		dbSelectArea("QED")
		dbSetOrder(1)
		dbSeek(xFilial("QED")+QEL->QEL_LAUDO)
		Li+=2
		cLaudo := QaxIdioma("QED->QED_DESCPO","QED->QED_DESCIN","QED->QED_DESCES")
		@Li,01 PSAY AllTrim(TitSX3("QEL_LAUDO")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QEL_LAUDO")[1])))+": "+cLaudo
		Li++
		@Li,01 PSAY AllTrim(TitSX3("QEL_DTLAUD")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QEL_DTLAUD")[1])))+": "+Dtoc(QEL->QEL_DTLAUD)
		Li++
		@Li,01 PSAY AllTrim(TitSX3("QEL_DTVAL")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QEL_DTVAL")[1])))+": "+Dtoc(QEL->QEL_DTVAL)
		Li++
		If !Empty(QEL->QEL_QTREJ)
			SAH->(dbSeek(xFilial("SAH")+QEK->QEK_UNIMED))
			@Li,01 PSAY AllTrim(TitSX3("QEL_QTREJ")[1])+;
				Replicate(".",15-Len(AllTrim(TitSX3("QEL_QTREJ")[1])))+": "+;
				QEL->QEL_QTREJ+" "+SAH->AH_UMRES
			Li++
		EndIf
		If mv_par03 == 1
			@Li,01 PSAY AllTrim(TitSX3("QEL_JUSTLA")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QEL_JUSTLA")[1])))+": "+QEL->QEL_JUSTLA
			Li++
		EndIf
	EndIf

	Li+=2

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto inferior                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqTxt := "QER0503"+".TXT"
	If File(cArqTxt)
		cTexto:=MemoRead(cArqTxt)
		For nC:=1 To MLCOUNT(cTexto,130)
			aLinha   := MEMOLINE(cTexto,130,nC)
			cImpTxt  := ""
			cImpLinha:= ""
			For nCount  := 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			@Li,01 PSAY cImpLinha
			Li++
			If Li > 56
				Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			EndIf
		Next nC
	EndIf
	Li++
Next nContador

If Li != 80
	roda(CbCont,cbtxt,cTamanho)
EnDif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QER")
Set Filter To
RetIndex("QER")
dbSetOrder(1)

If aReturn[5] == 1 
	Set Printer To 
	dbCommitAll()
	IIF(!lGerTXt,OurSpool(wnrel),.t.)
Endif

MS_FLUSH()
Return .T.
