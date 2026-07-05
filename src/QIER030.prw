/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "PROTHEUS.CH"
#include "QIER030.CH"
#INCLUDE "REPORT.CH"

#define POR  1
#define ING  2
#define ESP  3  
                                                                         
#define INGLES     "I"
#define ESPANHOL   "E"
#define PORTUGUES  "P"

#define ARQTXT "QIER030.TXT"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIER030  ³ Autor ³ Cleber Souza          ³ Data ³ 14/06/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Notificacao de nao Conformidade.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQie                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³  	   ³   	                             		  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QIER030( aParam, cProg )
Local aCpos        := {}
Local aFields      :={STR0001} //"  ITENS CONFIGURAÇÂO"
Local aItens       := {}
Local aSizes       :={45}
Local aStrs        := {}
Local bBlock       :={||Afill(Array(Len(aSizes))," ")}
Local cCpoAtualE   := Space(12)
Local cCpoAtualI   := Space(12)
Local cCpoAtualP   := Space(12)
Local cCpoEditE    := Space(12)
Local cCpoEditI    := Space(12)
Local cCpoEditP    := Space(12)
Local cIdioma      := ""
Local cNomeArq     := ""
Local cStrAtualE   := ""
Local cStrAtualI   := ""
Local cStrAtualP   := ""
Local cStrEditE    := ""
Local cStrEditI    := ""
Local cStrEditP    := ""
Local lCallInter   := If(ValType(aParam) <> "U",.T.,.F.)
Local lModificad   := .F.
Local nI           := 0
Local nJ           := 0
Local nOpcA        := 0
Local nX           := 0
Local nY           := 0
Local oBrwItem     := Nil
Local oCBoxCpos    := Nil
Local oCBoxStr     := Nil
Local oCpoAtualE   := Nil
Local oCpoAtualI   := Nil
Local oCpoAtualP   := Nil
Local oCpoEditE    := Nil
Local oCpoEditI    := Nil
Local oCpoEditP    := Nil
Local oDlg         := Nil
Local oFont        := TFont():New('Courier New', , -11, .T.)
Local oLaudo11     := Nil
Local oLaudo12     := Nil
Local oLaudo13     := Nil
Local oLaudo14     := Nil
Local oLaudo15     := Nil
Local oLaudo21     := Nil
Local oLaudo22     := Nil
Local oLaudo23     := Nil
Local oLaudo24     := Nil
Local oLaudo25     := Nil
Local oLaudo31     := Nil
Local oLaudo32     := Nil
Local oLaudo33     := Nil
Local oLaudo34     := Nil
Local oLaudo35     := Nil
Local oStrAtualE   := Nil
Local oStrAtualI   := Nil
Local oStrAtualP   := Nil
Local oStrEditE    := Nil
Local oStrEditI    := Nil
Local oStrEditP    := Nil
Local oVia11       := Nil
Local oVia12       := Nil
Local oVia13       := Nil
Local oVia14       := Nil
Local oVia15       := Nil
Local oVia21       := Nil
Local oVia22       := Nil
Local oVia23       := Nil
Local oVia24       := Nil
Local oVia25       := Nil
Local oVia31       := Nil
Local oVia32       := Nil
Local oVia33       := Nil
Local oVia34       := Nil
Local oVia35       := Nil
Private aGetTxt    := ARRAY(5,3)
Private aLaudo     := ARRAY(5,3)
Private aObjeto    := {}
Private aPrincipal := {}
Private aTexto     := {}
Private aTextos    := ARRAY(5,3)
Private aVarStr    := {}
Private aVia       := ARRAY(5,3)
Private cQERESNC   := SuperGetMv("MV_QERESNC")
Private cSeek      := ""
Private cTexESP    := Space(150)
Private cTexING    := Space(150)
Private cTexPOR    := Space(150)
Private lQtdRep    := If(GetMv("MV_QTRFREP")=="S",.T.,.F.)
Private nItem      := 1
Private nItemAnt   := 1
Private oPanel01   := Nil
Private oPanel02   := Nil
Private oPanel03   := Nil
Private oPanel04   := Nil
Private oPanel05   := Nil
Private oPanel06   := Nil
Private oPanel07   := Nil
Private oPanel08   := Nil
Default cProg      := ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Carrega arrays com spaces para digitação.     			           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aeval(aTextos,{|x,y|aTextos[y,POR]:=Space(150)})
Aeval(aTextos,{|x,y|aTextos[y,ING]:=Space(150)})
Aeval(aTextos,{|x,y|aTextos[y,ESP]:=Space(150)}) 

Aeval(aTextos,{|x,y|aVia[y,POR]:=Space(20)})
Aeval(aTextos,{|x,y|aVia[y,ING]:=Space(20)})
Aeval(aTextos,{|x,y|aVia[y,ESP]:=Space(20)}) 

Aeval(aTextos,{|x,y|aLaudo[y,POR]:=Space(1)})
Aeval(aTextos,{|x,y|aLaudo[y,ING]:=Space(1)})
Aeval(aTextos,{|x,y|aLaudo[y,ESP]:=Space(1)}) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Carrega os textos gravados nos arquivios TXTs.			           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nY:=1 to Len(aTextos)
	For nX:=1 to Len(aTextos[nY])
        IIF(nX==1,cIdioma:="P",IIF(nX==2,cIdioma:="I",cIdioma:="E"))
		cNomeArq := "QER3"+StrZero(nY,1)+SubStr(cNumEmp,1,2)+cIdioma+".TXT"
		aTextos[nY,nX] := MemoRead(cNomeArq)
	Next nX
Next nY	

cTexPOR := aTextos[nItem,POR]
cTexING := aTextos[nItem,ING]
cTexESP := aTextos[nItem,ESP]  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Carrega as Vias e Laudos.								           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nY:=1 to 3                                                  
	IIF(nY==1,cIdioma:="P",IIF(nY==2,cIdioma:="I",cIdioma:="E"))
	cNomeArq := "QER3"+StrZero(6,1)+SubStr(cNumEmp,1,2)+cIdioma+".TXT"
	If File(cNomeArq)
		cTexto := MemoRead(cNomeArq)
		For nI := 1 To MlCount(cTexto)
			cLinha := MemoLine(cTexto,254,nI)	
			If Subs(cLinha,1,1)$"12345"
				nJ := Val( Subs(cLinha,1,1) )
				aVia[nJ,nY]  := Subs(cLinha,3,20)
				aLaudo[nJ,nY]:= Subs(cLinha,24,1)
			EndIf
		Next
	EndIf      
Next nY

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Carrega os conteudos de campos e Strings.				           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aPrincipal := QER030Carr()

AADD(aItens,{STR0002})  //"Texto Superior da Capa"
AADD(aItens,{STR0003})  //"Texto Inferior da Capa"
AADD(aItens,{STR0004})  //"Justificativas"
AADD(aItens,{STR0005})  //"Instrucoes Digitação"
AADD(aItens,{STR0006})  //"Texto Analise Interna"
AADD(aItens,{STR0007})  //"Destino das Vias"
AADD(aItens,{STR0008})  //"Titulos dos Campos do Relatorio"
 
DEFINE MSDIALOG oDlg TITLE OemToAnsi(STR0009) FROM  001,003 TO 630,770 PIXEL OF oMainWnd //"Notificacao da Nao Conformidade"

oBrwItem:= TwBrowse():New( 2.5,0.5,95,265,bBlock,aFields,aSizes,oDlg)
oBrwItem:SetArray(aItens)      
oBrwItem:lMChange := .F.      
oBrwItem:bLine := {||{aItens[oBrwItem:nAt,1]}}
oBrwItem:bChange := {||{aObjeto[nItem]:Hide(),nItemAnt:=nItem,nItem:=oBrwItem:nAt,aObjeto[oBrwItem:nAt]:Show(),QER030ChgIt()}}      

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Objetos referentes ao Painel 01 - TEXTO SUPERIOR DA CAPA.           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPanel01 := 	TPanel():New(030,100,,oDlg,,,,GetSysColor( 8 ),,280,384,.F.,.F.)
@ 003,005 TO 88,280 LABEL OemToAnsi(STR0010) OF oPanel01 PIXEL //"Texto em Portugues"  
@ 093,005 TO 178,280 LABEL OemToAnsi(STR0011) OF oPanel01 PIXEL //"Texto em Ingles" 
@ 183,005 TO 268,280 LABEL OemToAnsi(STR0012) OF oPanel01 PIXEL //"Texto em Espanhol"   

aGetTxt[1,POR] := tMultiget():New(010,010,{|u|if(Pcount()>0,cTexPOR:=u,cTexPOR)},oPanel01,265,070,oFont,,,,,.T.)
aGetTxt[1,POR]:EnableVScroll( .T. )
aGetTxt[1,POR]:EnableHScroll( .F. )

aGetTxt[1,ING] := tMultiget():New(100,010,{|u|if(Pcount()>0,cTexING:=u,cTexING)},oPanel01,265,070,oFont,,,,,.T.)
aGetTxt[1,ING]:EnableVScroll( .T. )
aGetTxt[1,ING]:EnableHScroll( .F. )

aGetTxt[1,ESP] := tMultiget():New(190,010,{|u|if(Pcount()>0,cTexESP:=u,cTexESP)},oPanel01,265,070,oFont,,,,,.T.)
aGetTxt[1,ESP]:EnableVScroll( .T. )
aGetTxt[1,ESP]:EnableHScroll( .F. )

oPanel01:Hide()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Objetos referentes ao Painel 01 - TEXTO INFERIOR DA CAPA.           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPanel02 := 	TPanel():New(030,100,,oDlg,,,,GetSysColor( 8 ),,280,384,.F.,.F.)
@ 003,005 TO 88 ,280 LABEL OemToAnsi(STR0010) OF oPanel02 PIXEL //"Texto em Portugues"  
@ 093,005 TO 178,280 LABEL OemToAnsi(STR0011) OF oPanel02 PIXEL //"Texto em Ingles"  
@ 183,005 TO 268,280 LABEL OemToAnsi(STR0012) OF oPanel02 PIXEL //"Texto em Espanhol"  

aGetTxt[2,POR] := tMultiget():New(010,010,{|u|if(Pcount()>0,cTexPOR:=u,cTexPOR)},oPanel02,265,070,oFont,,,,,.T.)
aGetTxt[2,POR]:EnableVScroll( .T. )
aGetTxt[2,POR]:EnableHScroll( .F. )

aGetTxt[2,ING] := tMultiget():New(100,010,{|u|if(Pcount()>0,cTexING:=u,cTexING)},oPanel02,265,070,oFont,,,,,.T.)
aGetTxt[2,ING]:EnableVScroll( .T. )
aGetTxt[2,ING]:EnableHScroll( .F. )

aGetTxt[2,ESP] := tMultiget():New(190,010,{|u|if(Pcount()>0,cTexESP:=u,cTexESP)},oPanel02,265,070,oFont,,,,,.T.)
aGetTxt[2,ESP]:EnableVScroll( .T. )
aGetTxt[2,ESP]:EnableHScroll( .F. )

oPanel02:Hide()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Objetos referentes ao Painel 01 - JUSTIFICATIVAS.		           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPanel03 := 	TPanel():New(030,100,,oDlg,,,,GetSysColor( 8 ),,280,384,.F.,.F.)
@ 003,005 TO 88 ,280 LABEL OemToAnsi(STR0010) OF oPanel03 PIXEL //"Texto em Portugues"  
@ 093,005 TO 178,280 LABEL OemToAnsi(STR0011) OF oPanel03 PIXEL //"Texto em Ingles"  
@ 183,005 TO 268,280 LABEL OemToAnsi(STR0012) OF oPanel03 PIXEL //"Texto em Espanhol"  

aGetTxt[3,POR] := tMultiget():New(010,010,{|u|if(Pcount()>0,cTexPOR:=u,cTexPOR)},oPanel03,265,070,oFont,,,,,.T.)
aGetTxt[3,POR]:EnableVScroll( .T. )
aGetTxt[3,POR]:EnableHScroll( .F. )

aGetTxt[3,ING] := tMultiget():New(100,010,{|u|if(Pcount()>0,cTexING:=u,cTexING)},oPanel03,265,070,oFont,,,,,.T.)
aGetTxt[3,ING]:EnableVScroll( .T. )
aGetTxt[3,ING]:EnableHScroll( .F. )

aGetTxt[3,ESP] := tMultiget():New(190,010,{|u|if(Pcount()>0,cTexESP:=u,cTexESP)},oPanel03,265,070,oFont,,,,,.T.)
aGetTxt[3,ESP]:EnableVScroll( .T. )
aGetTxt[3,ESP]:EnableHScroll( .F. )

oPanel03:Hide()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Objetos referentes ao Painel 01 - INSTRUCOES DIGITAÇÃO.	           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPanel04 := 	TPanel():New(030,100,,oDlg,,,,GetSysColor( 8 ),,280,384,.F.,.F.)
@ 003,005 TO 88 ,280 LABEL OemToAnsi(STR0010) OF oPanel04 PIXEL //"Texto em Portugues" 
@ 093,005 TO 178,280 LABEL OemToAnsi(STR0011) OF oPanel04 PIXEL //"Texto em Ingles"  
@ 183,005 TO 268,280 LABEL OemToAnsi(STR0012) OF oPanel04 PIXEL //"Texto em Espanhol"

aGetTxt[4,POR] := tMultiget():New(010,010,{|u|if(Pcount()>0,cTexPOR:=u,cTexPOR)},oPanel04,265,070,oFont,,,,,.T.)
aGetTxt[4,POR]:EnableVScroll( .T. )
aGetTxt[4,POR]:EnableHScroll( .F. )

aGetTxt[4,ING] := tMultiget():New(100,010,{|u|if(Pcount()>0,cTexING:=u,cTexING)},oPanel04,265,070,oFont,,,,,.T.)
aGetTxt[4,ING]:EnableVScroll( .T. )
aGetTxt[4,ING]:EnableHScroll( .F. )

aGetTxt[4,ESP] := tMultiget():New(190,010,{|u|if(Pcount()>0,cTexESP:=u,cTexESP)},oPanel04,265,070,oFont,,,,,.T.)
aGetTxt[4,ESP]:EnableVScroll( .T. )
aGetTxt[4,ESP]:EnableHScroll( .F. )
  
oPanel04:Hide()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Objetos referentes ao Painel 01 - TEXTO ANALISE INTERNA.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPanel05 := 	TPanel():New(030,100,,oDlg,,,,GetSysColor( 8 ),,280,384,.F.,.F.)
@ 003,005 TO 88 ,280 LABEL OemToAnsi(STR0010) OF oPanel05 PIXEL //"Texto em Portugues"  
@ 093,005 TO 178,280 LABEL OemToAnsi(STR0011) OF oPanel05 PIXEL //"Texto em Ingles"  
@ 183,005 TO 268,280 LABEL OemToAnsi(STR0012) OF oPanel05 PIXEL //"Texto em Espanhol"

aGetTxt[5,POR] := tMultiget():New(010,010,{|u|if(Pcount()>0,cTexPOR:=u,cTexPOR)},oPanel05,265,070,oFont,,,,,.T.)
aGetTxt[5,POR]:EnableVScroll( .T. )
aGetTxt[5,POR]:EnableHScroll( .F. )

aGetTxt[5,ING] := tMultiget():New(100,010,{|u|if(Pcount()>0,cTexING:=u,cTexING)},oPanel05,265,070,oFont,,,,,.T.)
aGetTxt[5,ING]:EnableVScroll( .T. )
aGetTxt[5,ING]:EnableHScroll( .F. )

aGetTxt[5,ESP] := tMultiget():New(190,010,{|u|if(Pcount()>0,cTexESP:=u,cTexESP)},oPanel05,265,070,oFont,,,,,.T.)
aGetTxt[5,ESP]:EnableVScroll( .T. )
aGetTxt[5,ESP]:EnableHScroll( .F. )
  
oPanel05:Hide()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Objetos referentes ao Painel 01 - DESTINO DAS VIAS.		           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPanel06 := 	TPanel():New(030,100,,oDlg,,,,GetSysColor( 8 ),,280,384,.F.,.F.)
@ 003,005 TO 88 ,280 LABEL OemToAnsi(STR0010) OF oPanel06 PIXEL //"Texto em Portugues"  
@ 093,005 TO 178,280 LABEL OemToAnsi(STR0011) OF oPanel06 PIXEL //"Texto em Ingles"  
@ 183,005 TO 268,280 LABEL OemToAnsi(STR0012) OF oPanel06 PIXEL //"Texto em Espanhol"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Vias Referentes ao idioma PORTUGUES.						           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 013, 018  SAY   OemToAnsi(STR0013) RIGHT SIZE 36, 7   OF oPanel06 PIXEL //"Primeira Via :"
@ 011, 055  MSGET oVia11 VAR aVia[1,POR] SIZE 111, 10 OF oPanel06 PIXEL
oVia11:cSX1Hlp := "QE030VIAS"

@ 013, 178 SAY   OemToAnsi(STR0014) SIZE 20, 7   OF oPanel06 PIXEL //"Laudo :"
@ 011, 200 MSGET oLaudo11 VAR aLaudo[1,POR] Valid QER030Laud(aLaudo[1,POR]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo11:cSX1Hlp := "QE030LAUV"

@ 028, 018  SAY   OemToAnsi(STR0015) RIGHT SIZE 36, 7   OF oPanel06 PIXEL //"Segunda Via :"
@ 026, 055 MSGET oVia12 VAR aVia[2,POR] SIZE 111,10  OF oPanel06 PIXEL
oVia12:cSX1Hlp := "QE030VIAS"

@ 028, 178 SAY   OemToAnsi(STR0014) SIZE 20, 7   OF oPanel06 PIXEL //"Laudo  :"
@ 026, 200 MSGET oLaudo12 VAR aLaudo[2,POR] Valid QER030Laud(aLaudo[2,POR]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo12:cSX1Hlp := "QE030LAUV"

@ 043, 018  SAY   OemToAnsi(STR0016) RIGHT SIZE 36,  7  OF oPanel06 PIXEL //"Terceira Via :"
@ 041, 055  MSGET oVia13 VAR aVia[3,POR] SIZE 111, 10 OF oPanel06 PIXEL
oVia13:cSX1Hlp := "QE030VIAS"

@ 043, 178 SAY   OemToAnsi(STR0014) SIZE 20,  7  OF oPanel06 PIXEL //"Laudo :"
@ 041, 200 MSGET oLaudo13 VAR aLaudo[3,POR]  Valid QER030Laud(aLaudo[3,POR]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo13:cSX1Hlp := "QE030LAUV"

@ 058, 018 SAY   OemToAnsi(STR0017) RIGHT SIZE 36,  7  OF oPanel06 PIXEL //"Quarta Via"
@ 056, 055 MSGET oVia14 VAR aVia[4,POR] SIZE 111, 10 OF oPanel06 PIXEL
oVia14:cSX1Hlp := "QE030VIAS"

@ 058, 178  SAY   OemToAnsi(STR0014) SIZE 20,  7  OF oPanel06 PIXEL //"Laudo :"
@ 056, 200  MSGET oLaudo14 VAR aLaudo[4,POR]  Valid QER030Laud(aLaudo[4,POR]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo14:cSX1Hlp := "QE030LAUV"

@ 073, 018   SAY   OemToAnsi(STR0018) RIGHT SIZE 36,  7  OF oPanel06 PIXEL // "Quinta Via"
@ 071, 055   MSGET oVia15 VAR aVia[5,POR] SIZE 111, 10 OF oPanel06 PIXEL
oVia15:cSX1Hlp := "QE030VIAS"

@ 073, 178  SAY   OemToAnsi(STR0014) SIZE 20,  7  OF oPanel06 PIXEL // "Laudo"
@ 071, 200  MSGET oLaudo15 VAR aLaudo[5,POR]  Valid QER030Laud(aLaudo[5,POR]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo15:cSX1Hlp := "QE030LAUV"       

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Vias Referentes ao idioma INGLES.						           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 103, 018  SAY   OemToAnsi(STR0013) RIGHT SIZE 36, 7   OF oPanel06 PIXEL //"Primeira Via :"
@ 101, 055  MSGET oVia21 VAR aVia[1,ING] SIZE 111, 10 OF oPanel06 PIXEL
oVia21:cSX1Hlp := "QE030VIAS"

@ 103, 178 SAY   OemToAnsi(STR0014) SIZE 20, 7   OF oPanel06 PIXEL //"Laudo :"
@ 101, 200 MSGET oLaudo21 VAR aLaudo[1,ING] Valid QER030Laud(aLaudo[1,ING]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo21:cSX1Hlp := "QE030LAUV"

@ 118, 018  SAY   OemToAnsi(STR0015) RIGHT SIZE 36, 7   OF oPanel06 PIXEL //"Segunda Via :"
@ 116, 055 MSGET oVia22 VAR aVia[2,ING] SIZE 111,10  OF oPanel06 PIXEL
oVia22:cSX1Hlp := "QE030VIAS"

@ 118, 178 SAY   OemToAnsi(STR0014) SIZE 20, 7   OF oPanel06 PIXEL //"Laudo  :"
@ 116, 200 MSGET oLaudo22 VAR aLaudo[2,ING] Valid QER030Laud(aLaudo[2,ING]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo22:cSX1Hlp := "QE030LAUV"

@ 133, 018  SAY   OemToAnsi(STR0016) RIGHT SIZE 36,  7  OF oPanel06 PIXEL //"Terceira Via :"
@ 131, 055  MSGET oVia23 VAR aVia[3,ING] SIZE 111, 10 OF oPanel06 PIXEL
oVia23:cSX1Hlp := "QE030VIAS"

@ 133, 178 SAY   OemToAnsi(STR0014) SIZE 20,  7  OF oPanel06 PIXEL //"Laudo :"
@ 131, 200 MSGET oLaudo23 VAR aLaudo[3,ING]  Valid QER030Laud(aLaudo[3,ING]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo23:cSX1Hlp := "QE030LAUV"

@ 148, 018 SAY   OemToAnsi(STR0017) RIGHT SIZE 36,  7  OF oPanel06 PIXEL //"Quarta Via"
@ 146, 055 MSGET oVia24 VAR aVia[4,ING] SIZE 111, 10 OF oPanel06 PIXEL
oVia24:cSX1Hlp := "QE030VIAS"

@ 148, 178  SAY   OemToAnsi(STR0014) SIZE 20,  7  OF oPanel06 PIXEL //"Laudo :"
@ 146, 200  MSGET oLaudo24 VAR aLaudo[4,ING]  Valid QER030Laud(aLaudo[4,ING]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo24:cSX1Hlp := "QE030LAUV"

@ 163, 018   SAY   OemToAnsi(STR0018) RIGHT SIZE 36,  7  OF oPanel06 PIXEL // "Quinta Via"
@ 161, 055   MSGET oVia25 VAR aVia[5,ING] SIZE 111, 10 OF oPanel06 PIXEL
oVia25:cSX1Hlp := "QE030VIAS"

@ 163, 178  SAY   OemToAnsi(STR0014) SIZE 20,  7  OF oPanel06 PIXEL // "Laudo"
@ 161, 200  MSGET oLaudo25 VAR aLaudo[5,ING]  Valid QER030Laud(aLaudo[5,ING]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo25:cSX1Hlp := "QE030LAUV" 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Vias Referentes ao idioma ESPANHOL.						           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 193, 018  SAY   OemToAnsi(STR0013) RIGHT SIZE 36, 7   OF oPanel06 PIXEL //"Primeira Via :"
@ 191, 055  MSGET oVia31 VAR aVia[1,ESP] SIZE 111, 10 OF oPanel06 PIXEL
oVia31:cSX1Hlp := "QE030VIAS"

@ 193, 178 SAY   OemToAnsi(STR0014) SIZE 20, 7   OF oPanel06 PIXEL //"Laudo :"
@ 191, 200 MSGET oLaudo31 VAR aLaudo[1,ESP] Valid QER030Laud(aLaudo[1,ESP]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo31:cSX1Hlp := "QE030LAUV"

@ 208, 018  SAY   OemToAnsi(STR0015) RIGHT SIZE 36, 7   OF oPanel06 PIXEL //"Segunda Via :"
@ 206, 055 MSGET oVia32 VAR aVia[2,ESP] SIZE 111,10  OF oPanel06 PIXEL
oVia32:cSX1Hlp := "QE030VIAS"

@ 208, 178 SAY   OemToAnsi(STR0014)                          SIZE 20, 7   OF oPanel06 PIXEL //"Laudo  :"
@ 206, 200 MSGET oLaudo32 VAR aLaudo[2,ESP] Valid QER030Laud(aLaudo[2,ESP]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo32:cSX1Hlp := "QE030LAUV"

@ 223, 018  SAY   OemToAnsi(STR0016) RIGHT SIZE 36,  7  OF oPanel06 PIXEL //"Terceira Via :"
@ 221, 055  MSGET oVia33 VAR aVia[3,ESP] SIZE 111, 10 OF oPanel06 PIXEL
oVia33:cSX1Hlp := "QE030VIAS"

@ 223, 178 SAY   OemToAnsi(STR0014) SIZE 20,  7  OF oPanel06 PIXEL //"Laudo :"
@ 221, 200 MSGET oLaudo33 VAR aLaudo[3,ESP]  Valid QER030Laud(aLaudo[3,ESP]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo33:cSX1Hlp := "QE030LAUV"

@ 238, 018 SAY   OemToAnsi(STR0017) RIGHT SIZE 36,  7  OF oPanel06 PIXEL //"Quarta Via"
@ 236, 055 MSGET oVia34 VAR aVia[4,ESP] SIZE 111, 10 OF oPanel06 PIXEL
oVia34:cSX1Hlp := "QE030VIAS"

@ 238, 178  SAY   OemToAnsi(STR0014) SIZE 20,  7  OF oPanel06 PIXEL //"Laudo :"
@ 236, 200  MSGET oLaudo34 VAR aLaudo[4,ESP]  Valid QER030Laud(aLaudo[4,ESP]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo34:cSX1Hlp := "QE030LAUV"

@ 253, 018   SAY   OemToAnsi(STR0018) RIGHT SIZE 36,  7  OF oPanel06 PIXEL // "Quinta Via"
@ 251, 055   MSGET oVia35 VAR aVia[5,ESP] SIZE 111, 10 OF oPanel06 PIXEL
oVia35:cSX1Hlp := "QE030VIAS"

@ 253, 178  SAY   OemToAnsi(STR0014) SIZE 20,  7  OF oPanel06 PIXEL // "Laudo"
@ 251, 200  MSGET oLaudo35 VAR aLaudo[5,ESP]  Valid QER030Laud(aLaudo[5,ESP]) F3 "QED" SIZE 22, 10  OF oPanel06 PIXEL
oLaudo35:cSX1Hlp := "QE030LAUV"

oPanel06:Hide()  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Objetos referentes ao Painel 01 - TITULOS DE CAMPOS DO RELATORIO.   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPanel07 := 	TPanel():New(030,100,,oDlg,,,,GetSysColor( 8 ),,280,384,.F.,.F.)
@ 003,005 TO 082 ,280 LABEL STR0019 OF oPanel07 PIXEL //"CAMPOS" 
@ 087,005 TO 220 ,280 LABEL STR0020 OF oPanel07 PIXEL //"STRINGS" 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Usa aCpos s¢ para manipular o Combo - tem que ser matriz de uma dimensao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nI := 1 To Len(aPrincipal[POR])
	If Subs(aPrincipal[POR,nI,1],1,3) == "Str"
		aAdd(aStrs, aPrincipal[POR,nI,1])
	Else
		aAdd(aCpos, aPrincipal[POR,nI,1])
	EndIf
Next 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tela com os CAMPOS														³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cStrItem   := aStrs[1]

cStrAtualP := Pad(aPrincipal[POR][aScan(aPrincipal[POR],{|x| x[1] == cStrItem})][2],50," ")
cStrEditP  := cStrAtualP   

cStrAtualI := Pad(aPrincipal[ING][aScan(aPrincipal[ING],{|x| x[1] == cStrItem})][2],50," ")
cStrEditI  := cStrAtualI   

cStrAtualE := Pad(aPrincipal[ESP][aScan(aPrincipal[ESP],{|x| x[1] == cStrItem})][2],50," ")
cStrEditE  := cStrAtualE   

cCpoItem   := Subs(aCpos[1],1,12) // Posiciona o Combo no 1§ item

cCpoAtualP := Subs(aPrincipal[POR,1,2],1,12)
cCpoEditP  := Subs(aPrincipal[POR,1,2],1,12)   

cCpoAtualI := Subs(aPrincipal[ING,1,2],1,12)
cCpoEditI  := Subs(aPrincipal[ING,1,2],1,12)   

cCpoAtualE := Subs(aPrincipal[ESP,1,2],1,12)
cCpoEditE  := Subs(aPrincipal[ESP,1,2],1,12)   

@ 14, 09 COMBOBOX oCBoxCpos VAR cCpoItem ITEMS aCpos OF oPanel07 ;
ON CHANGE Eval({|oCpoAtualP,oCpoEditP| cCpoAtualP := Subs(aPrincipal[POR][aScan(aPrincipal[POR],{|x| x[1] == cCpoItem})][2],1,12),;
									   cCpoAtualI := Subs(aPrincipal[ING][aScan(aPrincipal[ING],{|x| x[1] == cCpoItem})][2],1,12),;
									   cCpoAtualE := Subs(aPrincipal[ESP][aScan(aPrincipal[ESP],{|x| x[1] == cCpoItem})][2],1,12),;		
									   cCpoEditP := cCpoAtualP, oCpoAtualP:Refresh(), oCpoEditP:Refresh(), ;
									   cCpoEditI := cCpoAtualI, oCpoAtualI:Refresh(), oCpoEditI:Refresh(), ;
									   cCpoEditE := cCpoAtualE, oCpoAtualE:Refresh(), oCpoEditE:Refresh()}, oCpoAtualP, oCpoEditP ) ;
SIZE 100,76 PIXEL

@ 33, 09  SAY OemToAnsi(STR0021) SIZE 60,07 OF oPanel07 PIXEL //"Valor atual Portugues :"  
@ 32, 71  GET oCpoAtualP VAR cCpoAtualP  SIZE 45,09  OF oPanel07 PIXEL  
oCpoAtualP:lReadOnly := .t.

@ 33, 145  SAY OemToAnsi(STR0022) SIZE 60,07 OF oPanel07 PIXEL //"Novo valor Portugues :"  
@ 32, 207 GET oCpoEditP  VAR cCpoEditP   SIZE 45,09  ;
VALID QER030StVal(cCpoEditP,@cCpoAtualP,;
cCpoItem,@oCpoAtualP,@aPrincipal,@lModificad,POR) ;
OF oPanel07 PIXEL
oCpoEditP:cSX1Hlp := "QE030CPOED"  

@ 48, 09  SAY OemToAnsi(STR0023) SIZE 60,07 OF oPanel07 PIXEL //"Valor atual Ingles :"	 
@ 47, 71  GET oCpoAtualI VAR cCpoAtualI  SIZE 45,09  OF oPanel07 PIXEL  
oCpoAtualI:lReadOnly := .t.

@ 48, 145  SAY OemToAnsi(STR0024) SIZE 60,07 OF oPanel07 PIXEL //"Novo valor Ingles :"  
@ 47, 207 GET oCpoEditI  VAR cCpoEditI   SIZE 45,09  ;
VALID QER030StVal(cCpoEditI,@cCpoAtualI,;
cCpoItem,@oCpoAtualI,@aPrincipal,@lModificad,ING) ;
OF oPanel07 PIXEL
oCpoEditI:cSX1Hlp := "QE030CPOED"  

@ 63, 09  SAY OemToAnsi(STR0025) SIZE 60,07 OF oPanel07 PIXEL //"Valor atual Espanhol :"  
@ 62, 71  GET oCpoAtualE VAR cCpoAtualE  SIZE 45,09  OF oPanel07 PIXEL  
oCpoAtualE:lReadOnly := .t.

@ 63, 145  SAY OemToAnsi(STR0026) SIZE 60,07 OF oPanel07 PIXEL //"Novo valor Espanhol :"   
@ 62, 207 GET oCpoEditE  VAR cCpoEditE   SIZE 45,09  ;
VALID QER030StVal(cCpoEditE,@cCpoAtualE,;
cCpoItem,@oCpoAtualE,@aPrincipal,@lModificad,ESP) ;
OF oPanel07 PIXEL
oCpoEditE:cSX1Hlp := "QE030CPOED" 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tela com os STRINGS														³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 
@ 098, 009 COMBOBOX oCBoxStr VAR cStrItem ITEMS aStrs ;
OF oPanel07 ;
ON CHANGE Eval({|oStrAtualP, oStrEditP| cStrAtualP := Pad(aPrincipal[POR][aScan(aPrincipal[POR],{|x| x[1] == cStrItem})][2],50," "),;
									  cStrAtualI := Pad(aPrincipal[ING][aScan(aPrincipal[ING],{|x| x[1] == cStrItem})][2],50," "),;
									  cStrAtualE := Pad(aPrincipal[ESP][aScan(aPrincipal[ESP],{|x| x[1] == cStrItem})][2],50," "),;
   									  cStrEditP := cStrAtualP, oStrAtualP:Refresh(), oStrEditP:Refresh(), ;
   									  cStrEditI := cStrAtualI, oStrAtualI:Refresh(), oStrEditI:Refresh(), ;
   									  cStrEditE := cStrAtualE, oStrAtualE:Refresh(), oStrEditE:Refresh() } , oStrAtualP, oStrEditP ) ;
SIZE 100,76 PIXEL
oCBoxStr:cSX1Hlp := "QE030STRIT"

@ 117,09 SAY OemToAnsi(STR0021) SIZE  60,07 OF oPanel07 PIXEL //"Valor atual Portugues:"  
@ 116,66 GET oStrAtualP VAR cStrAtualP     SIZE 150,09  OF oPanel07 PIXEL
oStrAtualP:lReadOnly := .t.

@ 132,009 SAY OemToAnsi(STR0022)  SIZE 60,07 OF oPanel07 PIXEL //"Novo valor Portugues :" 
@ 131,066 GET oStrEditP  VAR cStrEditP     SIZE 150,09  ;
VALID QER030StVal(cStrEditP,@cStrAtualP,;
cStrItem,@oStrAtualP,@aPrincipal,@lModificad,POR)  ;
OF oPanel07 PIXEL
oStrEditP:cSX1Hlp := "QE030STRED" 

@ 152,09 SAY OemToAnsi(STR0023) SIZE  60,07 OF oPanel07 PIXEL //"Valor atual Ingles:"  
@ 151,66 GET oStrAtualI VAR cStrAtualI     SIZE 150,09  OF oPanel07 PIXEL
oStrAtualI:lReadOnly := .t.

@ 167,009 SAY OemToAnsi(STR0024)  SIZE 60,07 OF oPanel07 PIXEL //"Novo valor Ingles :" 
@ 166,066 GET oStrEditI  VAR cStrEditI     SIZE 150,09  ;
VALID QER030StVal(cStrEditI,@cStrAtualI,;
cStrItem,@oStrAtualI,@aPrincipal,@lModificad,POR)  ;
OF oPanel07 PIXEL
oStrEditI:cSX1Hlp := "QE030STRED" 

@ 186,09 SAY OemToAnsi(STR0025) SIZE  60,07 OF oPanel07 PIXEL //"Valor atual Espanhol:" 
@ 185,66 GET oStrAtualE VAR cStrAtualE     SIZE 150,09  OF oPanel07 PIXEL
oStrAtualE:lReadOnly := .t.

@ 201,009 SAY OemToAnsi(STR0026)  SIZE 60,07 OF oPanel07 PIXEL //"Novo valor Espanhol :" 
@ 200,066 GET oStrEditE  VAR cStrEditE     SIZE 150,09  ;
VALID QER030StVal(cStrEditE,@cStrAtualE,;
cStrItem,@oStrAtualE,@aPrincipal,@lModificad,POR)  ;
OF oPanel07 PIXEL
oStrEditE:cSX1Hlp := "QE030STRED" 
oPanel07:Hide()  

aObjeto := {oPanel01,oPanel02,oPanel03,oPanel04,oPanel05,oPanel06,oPanel07}

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| IIF(nItem<=5,(nItemAnt:=nItem,QER030ChgIt()),.F.),IIF(QER030VALI(),(nOpcA:=1,oDlg:End()),.F.)},{||nOpcA:=0,oDlg:End()}) CENTERED  

If nOpcA==1
	QER030GRVALL()

	
	// Interface de impressao
	Pergunte("QER030",.F.)
	oReport := ReportDef(lCallInter,aParam, cProg)
	oReport:PrintDialog()	
	

EndIF	

Return


Static Function ReportDef(lCallInter,aParam,cProg)
Local aOrd      :={"QEK", "QEL", "SA2", "SA5", "QE6", "QE1", "QED"} // Salvo a Ordem aqui
Local cAlias    := ""
Local cDesc1    := OemToAnsi(STR0045) //"Neste relatorio sera impresso a Notificacao de Nao Conformidade."	 
Local cPerg     := Padr("QER030",10)
Local cTitulo   := ""
Local nCt       := 0
Local nI        := 0
Local nOrd      := 0
Local nTamDesc  := TamSx3("QE6_DESCPO")[1]
Local nTamLote  := TamSx3("QEK_TAMLOT")[1]+TamSx3("AH_UMRES")[1]
Local nTamQRej  := TamSx3("QEL_QTREJ")[1]+TamSx3("AH_UMRES")[1]+5
Local oSection1 := Nil
Local oSection2 := Nil
Local oSection3 := Nil
Local oSection4 := Nil
Local oSection5 := Nil
Local oSection6 := Nil
Local wnRel     := "QIER030"
Default cProg   := "" //CRIADA VAR

cAlias          := Alias()
nOrd            := IndexOrd()
// FUNCAO ICALLCENTER DELETADA
For nI := 1 To Len(aOrd)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Redefino toda a matriz com base nos indices   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(aOrd[nI])
	aOrd[nI] := { aOrd[nI], IndexOrd() }
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ A chamada interna indica que os parametros foram passados ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01           // Fornecedor                 	         ³
//³ mv_par02           // Loja do Fornecedor                     ³
//³ mv_par03           // Produto                                ³
//³ mv_par04           // Data de Entrada                        ³
//³ mv_par05           // Lote                                   ³
//³ mv_par06           // Nota Fiscal 						     ³  
//³ mv_par07           // Serie	                                 ³
//³ mv_par08           // Item	                                 ³
//³ mv_par09           // Nr. Sequencial						 ³  
//³ mv_par10           // Nr. da NNC                             ³
//³ mv_par11           // Idioma								 ³  
//³ mv_par12           // Justif. do Laudo             Sim/Nao   ³  
//³ mv_par13           // 2a. Parte                    Sim/Nao   ³  
//³ mv_par14           // Cronica                      Sim/Nao   ³  
//³ mv_par15           // Medicoes                     Sim/Nao   ³  
//³ mv_par16           // Impr. NC c/ Fator 0 					 ³  
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If lCallInter //Forca o conteudo das perguntas (mv_pars)
	mv_par01 := aParam[1] 
	mv_par02 := aParam[2] 
	mv_par03 := aParam[3]	
	If Valtype(aParam[4]) == "D"
		mv_par04 := DtoS(aParam[4])
	Else
		mv_par04 := Dtos(CtoD(aParam[4]))
	Endif
	mv_par05 := aParam[5]
	mv_par06 := aParam[6]
	mv_par07 := aParam[7]
	mv_par08 := aParam[8]
	mv_par09 := aParam[9]
	mv_par10 := aParam[10]
Endif 
aVarStr := QER030Carr() 

If Len(aVarStr) < 1  // Nao consegui carregar os STRs...
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Restaura a Integridade dos dados                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCt := 1 To Len(aOrd)
		dbSelectArea(aOrd[nCt][1])
		Set Filter To
		dbSetOrder(aOrd[nCt][2])
	Next                                 
	dbSelectArea(cAlias)
	dbSetOrder(nOrd)
	Return .F.
EndIf

If cProg $ "QIEA215"
	cPerg    := ""  // Desabilita a pergunte
EndIf

DEFINE REPORT oReport NAME wnrel TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport,aOrd,lCallInter)} DESCRIPTION (cDesc1)
oReport:SetLandscape() 

DEFINE SECTION oSection1 OF oReport TITLE STR0052 TABLES "SA2","SA1"	// "Fornecedor"

DEFINE CELL NAME "A2_COD"    OF oSection1 ALIAS "SA2" 
DEFINE CELL NAME "A2_LOJA"   OF oSection1 ALIAS "SA2" 
DEFINE CELL NAME "A2_NOME"   OF oSection1 ALIAS "SA2" 
DEFINE CELL NAME "A2_END"    OF oSection1 ALIAS "SA2" SIZE 20 LINE BREAK
DEFINE CELL NAME "A2_MUN" 	 OF oSection1 ALIAS "SA2" 
DEFINE CELL NAME "A2_EST"    OF oSection1 ALIAS "SA2"
DEFINE CELL NAME "A2_CEP"    OF oSection1 ALIAS "SA2"
DEFINE CELL NAME "A2_CGC"    OF oSection1 ALIAS "SA2" 
DEFINE CELL NAME "A2_TEL"    OF oSection1 ALIAS "SA2" SIZE 9 LINE BREAK
DEFINE CELL NAME "A2_FAX"    OF oSection1 ALIAS "SA2" SIZE 9 LINE BREAK

DEFINE CELL NAME "A1_COD"    OF oSection1 ALIAS "SA1" 
DEFINE CELL NAME "A1_LOJA"   OF oSection1 ALIAS "SA1" 
DEFINE CELL NAME "A1_NOME"   OF oSection1 ALIAS "SA1" 
DEFINE CELL NAME "A1_END"    OF oSection1 ALIAS "SA1" SIZE 20 LINE BREAK
DEFINE CELL NAME "A1_MUN" 	 OF oSection1 ALIAS "SA1" 
DEFINE CELL NAME "A1_EST"    OF oSection1 ALIAS "SA1"
DEFINE CELL NAME "A1_CEP"    OF oSection1 ALIAS "SA1"
DEFINE CELL NAME "A1_CGC"    OF oSection1 ALIAS "SA1"
DEFINE CELL NAME "A1_TEL"    OF oSection1 ALIAS "SA1" SIZE 9 LINE BREAK
DEFINE CELL NAME "A1_FAX"    OF oSection1 ALIAS "SA1" SIZE 9 LINE BREAK

DEFINE CELL NAME "Data"		 OF oSection1 ALIAS NIL  SIZE 30  ALIGN RIGHT

DEFINE SECTION oSection2 OF oSection1 TITLE STR0053 TABLES "QEK","SA5" // "Entrega"

DEFINE CELL NAME "QEK_PRODUT" OF oSection2 ALIAS "QEK" TITLE QER030StRe("QEK_PRODUT") 	SIZE nTamDesc BLOCK {|| QEK->QEK_PRODUT+"-"+Posicione("QE6",1,xFilial("QE6")+QEK->QEK_PRODUT+INVERTE(QEK->QEK_REVI),If(cIdioma == INGLES,"QE6_DESCIN",If(cIdioma == ESPANHOL,"QE6_DESCES","QE6_DESCPO")))} LINE BREAK
DEFINE CELL NAME "A5_CODPRF"  OF oSection2 ALIAS "SA5" TITLE QER030StRe("A5_CODPRF")
DEFINE CELL NAME "QEK_DTENTR" OF oSection2 ALIAS "QEK" TITLE QER030StRe("QEK_DTENTR")
DEFINE CELL NAME "QEK_LOTE"   OF oSection2 ALIAS "QEK" TITLE QER030StRe("QEK_LOTE")
DEFINE CELL NAME "QEK_NTFISC" OF oSection2 ALIAS "QEK" TITLE QER030StRe("QEK_NTFISC")
DEFINE CELL NAME "QEK_DTNFIS" OF oSection2 ALIAS "QEK" TITLE QER030StRe("QEK_DTNFIS")
DEFINE CELL NAME "QEK_PEDIDO" OF oSection2 ALIAS "QEK" TITLE QER030StRe("QEK_PEDIDO")
DEFINE CELL NAME "QEK_DOCENT" OF oSection2 ALIAS "QEK" TITLE QER030StRe("QEK_DOCENT")
DEFINE CELL NAME "QEK_CERFOR" OF oSection2 ALIAS "QEK" TITLE QER030StRe("QEK_CERFOR")
DEFINE CELL NAME "QEK_TAMLOT" OF oSection2 ALIAS "QEK" TITLE QER030StRe("QEK_TAMLOT") 	SIZE nTamLote 

DEFINE SECTION oSection3 OF oSection1 TITLE STR0054  TABLES ""	// "EnsaiosMed"

DEFINE CELL NAME "cENSAIO"    OF oSection3 ALIAS Nil   TITLE QER030StRe("QE7_ENSAIO") 	SIZE TamSx3("QE7_DESENS")[1]+6 
DEFINE CELL NAME "cLIE" 	  OF oSection3 ALIAS Nil   TITLE QER030StRe("QE7_LIE")    	SIZE TamSx3("QE7_LIE")[1]      
DEFINE CELL NAME "cLSE" 	  OF oSection3 ALIAS Nil   TITLE QER030StRe("QE7_LSE") 		SIZE TamSx3("QE7_LSE")[1]      
DEFINE CELL NAME "cUNIMED"    OF oSection3 ALIAS Nil   TITLE QER030StRe("QE7_UNIMED")	SIZE TamSx3("AH_UMRES")[1]      
DEFINE CELL NAME "cResult"    OF oSection3 ALIAS NiL   TITLE QER030StRe("Str0028")		SIZE 150  	//"Resultados"

DEFINE SECTION oSection4 OF oSection1 TITLE STR0055 TABLES "" // "EnsaiosTXT"

DEFINE CELL NAME "cENSAIO"    OF oSection4 ALIAS Nil   TITLE QER030StRe("QE7_ENSAIO")	SIZE TamSx3("QE8_DESENS")[1]+6 
DEFINE CELL NAME "cEspecif"   OF oSection4 ALIAS NiL   TITLE QER030StRe("Str0030") 		SIZE 50    LINE BREAK	//"Especificado"
DEFINE CELL NAME "cResult"    OF oSection4 ALIAS NiL   TITLE QER030StRe("Str0028")      SIZE TamSx3("QEQ_MEDICA")[1]   	//"Resultados"

DEFINE SECTION oSection5 OF oSection1 TITLE STR0056 TABLES "QEU"   // "NAO-Conf"

DEFINE CELL NAME "QEU_NAOCON"  OF oSection5 ALIAS "QEU" TITLE QER030StRe("Str0031") //"Nao Conformidade(s) encontrada(s)"
DEFINE CELL NAME "QEU_NUMNC"   OF oSection5 ALIAS "QEU" TITLE QER030StRe("Str0032")	//"No."
DEFINE CELL NAME "QEU_CLASSE"  OF oSection5 ALIAS "QEU" TITLE QER030StRe("Str0033") 	SIZE TamSx3("QEE_DESCPO")[1] //"Classe"
DEFINE CELL NAME "QEU_DEMIQI"  OF oSection5 ALIAS "QEU" TITLE QER030StRe("Str0034") //"Fator Criticidade"
DEFINE CELL NAME "REINC"  	   OF oSection5 ALIAS NIL   TITLE QER030StRe("Str0035") //"Reincidencia"
DEFINE CELL NAME "CRONICA" 	   OF oSection5 ALIAS NIL   TITLE QER030StRe("Str0051") 	SIZE 75  LINE BREAK //  //"Cronica"

DEFINE SECTION oSection6 OF oSection1 TITLE STR0057 TABLES "QEL" // "Laudo"

DEFINE CELL NAME "QEL_LAUDO"   OF oSection6 ALIAS "QEL" TITLE QER030StRe("QEL_LAUDO") SIZE TAMSX3("QED_DESCPO")[1]+2
DEFINE CELL NAME "QEL_JUSTLA"  OF oSection6 ALIAS "QEL" TITLE QER030StRe("QEL_JUSTLA")
DEFINE CELL NAME "QEL_QTREJ"   OF oSection6 ALIAS "QEL" TITLE QER030StRe("QEL_QTREJ") SIZE nTamQRej

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReporºAutor  ³Telso Carneiro      º Data ³  30/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio Personalizavel                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³U_QIER030()                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
                  
Static Function PrintReport(oReport,aOrd,lCallInter) 
Local aDest     := {}
//				Janeiro, Fevereiro,  Março,    Abril,    Maio,    Junho,   Julho,  Agosto,   Setembro,  Outubro,  Novembro, Dezembro//
Local aMeses   :={STR0070 , STR0071, STR0072 , STR0073 , STR0074, STR0075, STR0076, STR0077, STR0078  , STR0079 , STR0080 , STR0081}
Local cAcentos  := "€ú‡úú?ú…ú†úƒúú?úˆú‚ú¡ú“ú”ú¢ú™ú£ú"
Local cAcSubst  := "C,c,A~A 'a' a~a^a 'E' e^e 'i' o^o~o 'O~U' "
Local cAlias    := ""
Local cCronica  := ""
Local cDesCla   := ""
Local cDesEnsa  := ""
Local cDesLau   := ""
Local cDesNc    := ""
Local cNiseri   := ""
Local cResult   := ""
Local cSeek     := ""
Local dDataEnt  := dDataBase
Local lImp      := .F.
Local lQReinsp  := QieReinsp()
Local nC        := 0
Local nConf     := 0
Local nCont     := 0
Local nCount    := 0
Local nCt       := 0
Local nOrd      := 0
Local nP        := 0
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(2)
Local oSection4 := oReport:Section(1):Section(3)
Local oSection5 := oReport:Section(1):Section(4)
Local oSection6 := oReport:Section(1):Section(5)

cAlias          := Alias()
nOrd            := IndexOrd()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se a Entrada existe ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !Empty(mv_par10) // N§ da NNC
	dbSelectArea("QEK")
	dbSetOrder(5)
	dbSeek(xFilial("QEK")+subs(mv_par10,9,4)+subs(mv_par10,1,7))
	If !Eof()
		lImp := .T.
	EndIf
Else
	dbSelectArea("QEK")
	dDataEnt := IIF(ValType(mv_par04) == "D",dtos(mv_par04),mv_par04)
	dbSetOrder(14)
	If dbSeek(xFilial("QEK")+mv_par01+mv_par02+mv_par03+mv_par06+mv_par07+dDataEnt+mv_par05)
		While QEK->(!Eof()) .and. QEK->QEK_FILIAL==xFilial("QEK") .And. QEK->QEK_FORNEC==MV_PAR01 .AND. QEK->QEK_LOJFOR==MV_PAR02 .AND. QEK->QEK_PRODUT==MV_PAR03 .AND. QEK->QEK_NTFISC==MV_PAR06 .AND.	QEK->&(SERIENFID("QEK", 3, "QEK_SERINF"))/*QEK->QEK_SERINF*/==MV_PAR07 .AND. DTOS(QEK->QEK_DTENTR)==ddataent .AND. QEK->QEK_LOTE==MV_PAR05
			IF mv_par08 == QEK->QEK_ITEMNF
				If lQReinsp
					If QEK->QEK_NUMSEQ == mv_par09
						lImp := .T.
						exit
					Endif
				Else
					lImp := .T.
					exit
				Endif
			Endif  
			QEK->(DBSkip())  
		Enddo
	Endif
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Realiza os filtros de usuario                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QEK")))
	If !QEK->(&(oReport:Section(1):GetAdvplExp("QEK")))
		lImp := .F.
	Endif
EndIf

If !lImp
	Set Device to Screen
	Help(" ",1,"QE_NAOENTR")	// "Entrada nao cadastrada"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Restaura a Integridade dos dados                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCt := 1 To Len(aOrd)
		dbSelectArea(aOrd[nCt][1])
		Set Filter To
		dbSetOrder(aOrd[nCt][2])
	Next
	dbSelectArea(cAlias)
	dbSetOrder(nOrd)
	Return .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se a Entrada tem laudo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEL")
cNiseri := QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
QEL->(dbSetOrder(3))
cSeek := QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+cNiseri+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE

If lQReinsp
	cSeek += Space(TamSx3("QEL_LABOR")[1])+QEK->QEK_NUMSEQ
Endif

If !dbSeek(xFilial("QEL")+cSeek)
	MsgStop(OemToAnsi(STR0046),OemToAnsi(STR0009)) //"Entrada sem Laudo"###"Notificacao De Nao Conformidade"
	// "Notificacao De Nao Conformidade"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Restaura a Integridade dos dados                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCt := 1 To Len(aOrd)
		dbSelectArea(aOrd[nCt][1])
		Set Filter To
		dbSetOrder(aOrd[nCt][2])
	Next
	dbSelectArea(cAlias)
	dbSetOrder(nOrd)
	Return .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualizo o Texto das Vias de acordo com o parametro (mv_par07) ³
//³  relacionado com o idioma                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  mv_par11 == 2
	cIdioma := INGLES
ElseIf mv_par11 == 3
	cIdioma := ESPANHOL
Else
	cIdioma := PORTUGUES
EndIf

aDest := QER030Vias(cIdioma)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se a matriz nÆo retornar linhas suficientes informo o usu rio      ³
//³ e aborto o programa                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aDest) < 1
	Set Device to Screen
	If lCallInter
		MsgStop(OemToAnsi(STR0047),OemToAnsi(STR0009)) //"Notificacao De Nao Conformidade"
		// "Nao foi possivel encontrar a via e/ou laudo para este idioma,
		//  o que impossibilita a emissao do relatorio. Verifique pelo menu
		//  'Relatorios', se a via, neste idioma esta corretamente informada."
	Else
		MsgStop(OemToAnsi(STR0048),OemToAnsi(STR0009)) //"Notificacao De Nao Conformidade"
		// Nao foi poss¡vel encontrar a via e/ou laudo para este idioma,
		// o que impossibilita a emissao do relatorio.
		//	 Verifique se a via no respectivo idioma esta corretamente informada.
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Restaura a Integridade dos dados                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCt := 1 To Len(aOrd)
		dbSelectArea(aOrd[nCt][1])
		Set Filter To
		dbSetOrder(aOrd[nCt][2])
	Next
	dbSelectArea(cAlias)
	dbSetOrder(nOrd)
	Return .F.
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Zera a variavel para que da proxima vez trate corretamente o contador     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nContNNC := 0
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ realiza a Inclusao da Notificacao das Nao-conformidades					  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNNC := QieAtuNNC(1)                                                                

cTitulo := QER030StRe("Str0027") // Notificacao de Nao Conformidade - para impressao	
cTitulo := cTitulo+"  "+QER030StRe("Str0032")+"  "+cNNC

oReport:SetTitle(cTitulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona em registros de outros Arquivos p/dados Fornecedor  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If QEK->QEK_TIPONF $ "N "
	dbSelectArea("SA2")
	dbSetOrder(1)
	dbSeek(xFilial("SA2")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)

	dbSelectArea("SA5")
	dbSetOrder(2)
	dbSeek(xFilial("SA5")+QEK->QEK_PRODUT+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Realiza os filtros de usuario                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("SA2")))
		If !SA2->(&(oReport:Section(1):GetAdvplExp("SA2")))
			aDest := {}
		Endif
	EndIf

	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("SA5")))
		If !SA5->(&(oReport:Section(1):GetAdvplExp("SA5")))
			aDest := {}
		Endif
	EndIf

Else
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Realiza os filtros de usuario                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("SA1")))
		If !SA1->(&(oReport:Section(1):GetAdvplExp("SA1")))
			aDest := {}
		Endif
	EndIf

EndIf	

dbSelectArea("QE6")
dbSetOrder(1)
dbSeek(xFilial("QE6")+QEK->QEK_PRODUT+Inverte(QEK->QEK_REVI))

dbSelectArea("QE7")
dbSetOrder(1)

oReport:SetMeter(Len(aDest))

For nCt := 1 to Len(aDest)  
			
	oReport:IncMeter()	
	
	If oReport:Cancel()
		Exit
	EndIf
		
	dbSelectArea("QEL")
	cNiseri := QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
	QEL->(dbSetOrder(3))
	cSeek := QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+cNiseri+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE

	If lQReinsp
		cSeek += Space(TamSx3("QEL_LABOR")[1])+QEK->QEK_NUMSEQ
	Endif

	If dbSeek(xFilial("QEL")+cSeek)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o Laudo informado na via ‚ maior do que o Laudo  ³
		//³  do Fornecedor atual.                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Asc(aDest[nCt,2]) > Asc(QEL->QEL_LAUDO)
			Loop
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Realiza os filtros de usuario                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QEL")))
		If !QEL->(&(oReport:Section(1):GetAdvplExp("QEL")))
			Loop
		Endif
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chamada da funcao onde armazenar  array's com NConformidades.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aEnsaio  := {}
	nEns	 := 1
	aNConf	 := {}
	aResTXT  := {}
	aResult  := {}
	QER030NNC(.T.)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Flag para verificar se ir  imprimir as Nao Conformidades en- ³
	//³ contradas de acordo c/o paramentro: Imprime NC com Fator 0   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par16 == 2
		If Len(aNConf) > 0
			For nConf:= 1 to Len(aNConf)
				If AllTrim(aNConf[nConf,6]) == "0"
					lImpNNC	:= .F.
					nContNNC++
				EndIf
			Next
		Else
			lImpNNC := .F.
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se o parametro Imprime NC com Fator 0 == Nao e o fator de to-³
	//³ das as nao conformidades estiver com 0, nao ser  impresso.   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par16 == 2 .and. nContNNC == Len(aNConf)
		If !lImpNNC .And. cQERESNC == "N"
			Set Device to Screen
			Help(" ",1,"Q_ENTNAONC")	//"Entrada n„o apresenta N„o Conformidades"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Restaura a Integridade dos dados                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nCt := 1 To Len(aOrd)
				dbSelectArea(aOrd[nCt][1])
				Set Filter To
				dbSetOrder(aOrd[nCt][2])
			Next
			dbSelectArea(cAlias)
			dbSetOrder(nOrd)
			Return .F.
		Endif
	EndIf
		                                  	   
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Obtem a data original da Geracao da Notificacao da Nao-conformidade		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    QEM->(dbSetOrder(1))
    QEM->(dbSeek(xFilial("QEM")+QEK->QEK_NNC))
    If QEM->(!Eof())
        dNNC := QEM->QEM_DTNNC                 
	Else
		dNNC := dDataBase	    	
    EndIf

	// SM0: Campos do arquivo SIGAMAT.EMP      	
	If MV_PAR11 == 1      		
		cData := AllTrim(SM0->M0_CIDENT)+","+ StrZero(day(dNNC),2) + OemToAnsi(STR0050) +; //" de "###" de "
		aMeses[month(dNNC)] + OemToAnsi(STR0050) + StrZero(year(dNNC),4)	 
    ElseIf MV_PAR11 == 2
		cData := AllTrim(SM0->M0_CIDENT)+","+ aMeses[month(dNNC)] + StrZero(day(dNNC),2) + ", "+ StrZero(year(dNNC),4)
    Else
		cData := AllTrim(SM0->M0_CIDENT)+","+ StrZero(day(dNNC),2) + OemToAnsi(STR0050) +;//" de "###" de "
		aMeses[month(dNNC)] + OemToAnsi(STR0050) + StrZero(year(dNNC),4)	 
    EndIF

	oSection1:Init()
    oSection1:Cell("Data"):Enable()
	oSection1:Cell("Data"):SetTitle(cData)

	oSection1:Cell("A2_COD"):Disable()
	oSection1:Cell("A2_LOJA"):Disable()
	oSection1:Cell("A2_NOME"):Disable()
	oSection1:Cell("A2_END"):Disable()
	oSection1:Cell("A2_MUN"):Disable()
	oSection1:Cell("A2_EST"):Disable()
	oSection1:Cell("A2_CEP"):Disable()
	oSection1:Cell("A2_CGC"):Disable()
	oSection1:Cell("A2_TEL"):Disable()
	oSection1:Cell("A2_FAX"):Disable()
		                                          
	oSection1:Cell("A1_COD"):Disable()
	oSection1:Cell("A1_LOJA"):Disable()
	oSection1:Cell("A1_NOME"):Disable()
	oSection1:Cell("A1_END"):Disable()
	oSection1:Cell("A1_MUN"):Disable()
	oSection1:Cell("A1_EST"):Disable()
	oSection1:Cell("A1_CEP"):Disable()
	oSection1:Cell("A1_CGC"):Disable()
	oSection1:Cell("A1_TEL"):Disable()
	oSection1:Cell("A1_FAX"):Disable()
	
	oReport:PrintText(cData,oReport:Row(),1700)
	oReport:SkipLine()
	oReport:SkipLine()
		
	If (QEK->QEK_TIPONF $ "N ")
		oReport:PrintText(SA2->A2_NOME,oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(SA2->A2_END,oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(ALLTRIM(SA2->A2_MUN) + " - " + SA2->A2_EST,oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("A2_CEP")) + ": " + Transform(SA2->A2_CEP,PesqPict("SA2","A2_CEP")),oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("A2_CGC")) + ": " + Transform(SA2->A2_CGC,PesqPict("SA2","A2_CGC")),oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("A2_TEL")) + ": " + Transform(SA2->A2_TEL,PesqPict("SA2","A2_TEL")),oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("A2_FAX")) + ": " + Transform(SA2->A2_FAX,PesqPict("SA2","A2_FAX")),oReport:Row(),025)
		oReport:SkipLine()
	Else
		oReport:PrintText(SA1->A1_NOME,oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(SA1->A1_END,oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(ALLTRIM(SA1->A1_MUN) + " - " + SA1->A1_EST,oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("A1_CEP")) + ": " + Transform(SA1->A1_CEP,PesqPict("SA2","A1_CEP")),oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("A1_CGC")) + ": " + Transform(SA1->A1_CGC,PesqPict("SA2","A1_CGC")),oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("A1_TEL")) + ": " + Transform(SA1->A1_TEL,PesqPict("SA2","A1_TEL")),oReport:Row(),025)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("A1_FAX")) + ": " + Transform(SA1->A1_FAX,PesqPict("SA2","A1_FAX")),oReport:Row(),025)
		oReport:SkipLine()
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto superior da Capa        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqTxt := "QER31"+SubStr(cNumEmp,1,2)+cIdioma+".TXT"
	If File(cArqTxt)
		cTexto:=MemoRead(cArqTxt)
		For nC := 1 To MLCOUNT(cTexto,130)
			aLinha    := MEMOLINE(cTexto,130,nC)
			cImpTxt   := ""
			cImpLinha := ""
			For nCount := 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			oReport:PrintText(cImpLinha,oReport:Row(),025)		
			oReport:SkipLine()
		Next nC
	Else
		oReport:SkipLine()
	EndIf
	                  
	oSection2:Init()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pesquisa os dados do item da Nota Fiscal original³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTamLot  := QEK->QEK_TAMLOT 
	dEntrada := QEK->QEK_DTENTR	       
	If lQtdRep
		If AllTrim(QEK->QEK_TIPDOC) == "TR" 
			dEntrada := QEK->QEK_DTNFIS			
			If !Empty(QEK->QEK_LOTORI)
				cTamLot := QEK->QEK_LOTORI 
			EndIf		    
		EndIf
	EndIf                       

	cTamLot+=Posicione("SAH",1,xFilial("SAH")+QEK->QEK_UNIMED,"AH_UMRES")									
		
	oSection2:Cell("QEK_TAMLOT"):SetValue(cTamLot)
	oSection2:Cell("QEK_DTENTR"):SetValue(dEntrada)
		              
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo dos dados da Entrega             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection2:Cell("A5_CODPRF"):Disable()	
	If QEK->QEK_TIPONF $ "N "                    
		oSection2:Cell("A5_CODPRF"):Enable()
	EndIf	              
	
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:PrintText(AllTrim(QER030StRe("QEK_PRODUT")) + Replicate(".",23-Len(AllTrim(QER030StRe("QEK_PRODUT")))) + ": " + ALLTRIM(QEK->QEK_PRODUT) + " - " + Posicione("QE6",1,xFilial("QE6")+QEK->QEK_PRODUT+INVERTE(QEK->QEK_REVI),If(cIdioma == INGLES,"QE6_DESCIN",If(cIdioma == ESPANHOL,"QE6_DESCES","QE6_DESCPO"))),oReport:Row(),025)
	oReport:SkipLine()
	oReport:PrintText(AllTrim(QER030StRe("A5_CODPRF")) + Replicate(".",23-Len(AllTrim(QER030StRe("A5_CODPRF")))) + ": " + SA5->A5_CODPRF,oReport:Row(),025)
	oReport:SkipLine()
	oReport:PrintText(AllTrim(QER030StRe("QEK_DTENTR")) + Replicate(".",23-Len(AllTrim(QER030StRe("QEK_DTENTR")))) + ": " + DTOC(QEK->QEK_DTENTR),oReport:Row(),025)
	oReport:PrintText(AllTrim(QER030StRe("QEK_LOTE")) + Replicate(".",19-Len(AllTrim(QER030StRe("QEK_LOTE")))) + ": " + QEK->QEK_LOTE,oReport:Row(),1000)
	oReport:SkipLine()
	oReport:PrintText(AllTrim(QER030StRe("QEK_NTFISC")) + Replicate(".",23-Len(AllTrim(QER030StRe("QEK_NTFISC")))) + ": " + QEK->QEK_NTFISC,oReport:Row(),025)
	oReport:PrintText(AllTrim(QER030StRe("QEK_DTNFIS")) + Replicate(".",19-Len(AllTrim(QER030StRe("QEK_DTNFIS")))) + ": " + DTOC(QEK->QEK_DTNFIS),oReport:Row(),1000)
	oReport:SkipLine()
	oReport:PrintText(AllTrim(QER030StRe("QEK_PEDIDO")) + Replicate(".",23-Len(AllTrim(QER030StRe("QEK_PEDIDO")))) + ": " + QEK->QEK_PEDIDO,oReport:Row(),025)
	oReport:PrintText(AllTrim(QER030StRe("QEK_DOCENT")) + Replicate(".",19-Len(AllTrim(QER030StRe("QEK_DOCENT")))) + ": " + QEK->QEK_DOCENT,oReport:Row(),1000)
	oReport:SkipLine()
	oReport:PrintText(AllTrim(QER030StRe("QEK_CERFOR")) + Replicate(".",23-Len(AllTrim(QER030StRe("QEK_CERFOR")))) + ": " + QEK->QEK_CERFOR,oReport:Row(),025)
	oReport:PrintText(AllTrim(QER030StRe("QEK_TAMLOT")) + Replicate(".",19-Len(AllTrim(QER030StRe("QEK_TAMLOT")))) + ": " + QEK->QEK_TAMLOT,oReport:Row(),1000)
	oReport:SkipLine()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  VERIFICACAO DO PARAMETRO DE MEDICOES            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par15 == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se existe medi‡äes <> TXT               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aEnsaio) > 0 .And. Len(aEnsaio) <> Len(aResTxt)					
			oSection3:Init()			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Faz a impressao dos resultados                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nC := 1 to Len(aEnsaio)
				If aEnsaio[nC,6] != "TXT"					
					
					cDesEnsa:= Posicione("QE1",1,xFilial("QE1")+aEnsaio[nC,2],If(cIdioma == INGLES,"QE1_DESCIN",If(cIdioma == ESPANHOL,"QE1_DESCES","QE1_DESCPO")))					    
					cDesEnsa+="(" + StrZero(aEnsaio[nC,1],2) + ")"		  
								
					oSection3:Cell("cENSAIO"):SetValue(cDesEnsa)
					
					QE7->(dbSetOrder(1))
					QE7->(dbSeek(xFilial("QE7")+QEK->QEK_PRODUT+QEK->QEK_REVI+aEnsaio[nC,2]))
					
					If QE7->QE7_MINMAX == "1"
						oSection3:Cell("cLIE"):SetValue(aEnsaio[nC,3])
						oSection3:Cell("cLSE"):SetValue(aEnsaio[nC,4])
					ElseIf QE7->QE7_MINMAX == "2"						
						oSection3:Cell("cLIE"):SetValue(aEnsaio[nC,3])
						oSection3:Cell("cLSE"):SetValue(">>>")						
					ElseIf QE7->QE7_MINMAX == "3"
						oSection3:Cell("cLIE"):SetValue("<<<")
						oSection3:Cell("cLSE"):SetValue(aEnsaio[nC,4])
					EndIf
					 
					// Busca Descricao resumida da Unidade Medida					                                           
					aEnsaio[nC,5]:=Posicione("SAH",1,xFilial("SAH")+aEnsaio[nC,5],"AH_UMRES")										

					oSection3:Cell("cUNIMED"):SetValue(aEnsaio[nC,5])
					
					For nCont := 1 to Len(aResult)                             					
						If nC == aResult[nCont,1]                             
							cResult+=aResult[nCont,2] + "  "
						EndIf
					Next nCont	
					oSection3:Cell("cResult"):SetValue(cResult)  
					oSection3:Printline()						
					cResult:=""
				EndIf
			Next nC
			oSection3:Finish()
		EndIf                        				

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ CABECALHO DOS ENSAIOS TEXTO - TXT  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se existe medi‡äes no formato TXT       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aResTxt) > 0			
			oSection4:Init()
			For nP:= 1 to Len(aResTxt)
				cDesEnsa:= Posicione("QE1",1,xFilial("QE1")+aResTxt[nP,3],If(cIdioma == INGLES,"QE1_DESCIN",If(cIdioma == ESPANHOL,"QE1_DESCES","QE1_DESCPO")))					    
				cDesEnsa+="(" + StrZero(aResTxt[nP,4],2) + ")"
				
				oSection4:Cell("cENSAIO"):SetValue(cDesEnsa)
				oSection4:Cell("cEspecif"):SetValue(aResTxt[nP,1])
				oSection4:Cell("cResult"):SetValue(AllTrim(aResTxt[nP,2]))
				oSection4:Printline()
			Next nP
			oSection4:Finish()
		Endif
	EndIf	

	If Len(aNConf) > 0
		oSection5:Init()		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Relacionamento com as Nao Conformidades encontradas          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ CABECALHO DAS NAO CONFORMIDADES ENCONTRADAS      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ						
		For nC := 1 to Len(aNConf)
			If mv_par16 == 2 .and. AllTrim(aNConf[nC,6]) == "0"
				Loop
			EndIf

			cDesNc:="("+StrZero(aNConf[nC,1],2)+") "+aNConf[nC,2]
			cDesNc+=Posicione("SAG",1,xFilial("SAG")+aNConf[nC,2],If(cIdioma == INGLES,"AG_DESCIN",If(cIdioma == ESPANHOL,"AG_DESCES","AG_DESCPO")))					    
			
			oSection5:Cell("QEU_NAOCON"):SetValue(cDesNc)			
			oSection5:Cell("QEU_NUMNC"):SetValue(aNConf[nC,3])

			cDesCla:=aNConf[nC,4]
			cDesCla+=Posicione("QEE",1,xFilial("QEE")+aNConf[nC,4],If(cIdioma == INGLES,"QEE_DESCIN",If(cIdioma == ESPANHOL,"QEE_DESCES","QEE_DESCPO")))
			oSection5:Cell("QEU_CLASSE"):SetValue(cDesCla)
			
			If aNConf[nC,8] == "S"
				oSection5:Cell("QEU_DEMIQI"):SetValue(AllTrim(aNConf[nC,6]) + QER030StRe("Str0038") )	//"Sim -"###" pontos"
			Else
				oSection5:Cell("QEU_DEMIQI"):SetValue(QER030StRe("Str0039"))	//"Nao"		
			EndIf
			
			If aNConf[nC,7] > 1
				oSection5:Cell("REINC"):SetValue(AllTrim(Str(aNConf[nC,7])) + QER030StRe("Str0041")) // " a."
			EndIf			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³  VERIFICACAO DO PARAMETRO DE CRONICA             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par14 == 1				 
				dbSelectArea("QA2")
				dbSetOrder(1)
				If QA2->(dbSeek(xFilial("QA2")+"QIEA210C"+aNConf[nC,5]))
					cCronica:=""
					While QA2->(!Eof()) .and.	xFilial("QA2") == QA2->QA2_FILIAL .And. ;
						QA2->QA2_CHAVE == aNConf[nC,5]
						cCronica+=StrTran(QA2->QA2_TEXTO, "\13\10", "")
						QA2->(dbSkip())
					EndDo
				EndIf   
				oSection5:Cell("CRONICA"):SetValue(cCronica)
			Else
				oSection5:Cell("CRONICA"):Disable()	
			EndIf
			oSection5:Printline()
		Next nC
		oSection5:Finish()
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  IMPRESSAO DO LAUDO DA Entrada  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QEL")
	cNiseri := QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
	QEL->(dbSetOrder(3))
	cSeek := QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+cNiseri+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE+Space(TamSX3("QEL_LABOR")[1])

	If lQReinsp
		cSeek += QEK->QEK_NUMSEQ
	Endif

	If QEL->(dbSeek(xFilial("QEL")+cSeek))
		
		oSection6:Init()
		cDesLau:=QEL->QEL_LAUDO
		cDesLau+="-"+Posicione("QED",1,xFilial("QED")+QEL->QEL_LAUDO,If(cIdioma == INGLES,"QED_DESCIN",If(cIdioma == ESPANHOL,"QED_DESCES","QED_DESCPO")))
		
		oSection6:Cell("QEL_LAUDO"):SetValue(cDesLau)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica parametro para imprimir a Justificativa do Laudo  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par12 == 2
			oSection6:Cell("QEL_JUSTLA"):Disable()
		EndIf
		
		If SuperVal(QEL->QEL_QTREJ) > 0 
			cDesQTd:=QEL->QEL_QTREJ
			cDesQTd+=" "+Posicione("SAH",1,xFilial("SAH")+QEK->QEK_UNIMED,"AH_UMRES")												
			oSection6:Cell("QEL_QTREJ"):SetValue(cDesQTd)
		Else
			oSection6:Cell("QEL_QTREJ"):Disable()
		EndIf
		oSection6:PrintLine()
		oSection6:Finish()
	EndIf
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto inferior da Capa        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lCabec	:= .F.
	cArqTxt := "QER32"+SubStr(cNumEmp,1,2)+cIdioma+".TXT"
	If File(cArqTxt)
		cTexto:=MemoRead(cArqTxt)
		For nC := 1 To MLCOUNT(cTexto,130)
			aLinha 		:= MEMOLINE(cTexto,130,nC)
			cImpTxt   	:= ""
			cImpLinha 	:= ""
			For nCount 	:= 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			oReport:PrintText(cImpLinha,oReport:Row(),025)		
			oReport:SkipLine()
		Next nC
	Else
		oReport:SkipLine()
	EndIf
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a ImpressÆo do Nome do Fornecedor            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:PrintText(SA2->A2_NOME,oReport:Row(),2500)
		oReport:SkipLine()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a ImpressÆo da Data da Garantia da Qualidade ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:PrintText(QER030StRe("Str0040"),oReport:Row(),2500)	//"Garantia da Qualidade       /     /
		oReport:SkipLine()
	
	                  
	oReport:SkipLine()
	oReport:PrintText(AllTrim(Str(nCt))+ QER030StRe("Str0029") + " " + aDest[nCt,1],oReport:Row(),010) //"a. via: "
	
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  VERIFICACAO DO PARAMETRO PARA A IMPRESSAO       ³
	//³  DA 2a. PARTE DA CARTA                           ³
	//³  OBS.:SERA IMPRESSO SOMENTE NA 1a.VIA            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par13 == 1 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a ImpressÆo dos dados da Entrada na 2a. parte da Carta   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        oReport:EndPage()
		oSection1:Init()
		oSection1:Cell("Data"):Disable()

		If (QEK->QEK_TIPONF $ "N ")           
			oReport:PrintText(AllTrim(QER030StRe("QEK_FORNEC")) + Replicate(".",23-Len(AllTrim(QER030StRe("QEK_FORNEC")))) + ": " + AllTrim(QEK->QEK_FORNEC) + "/" + QEK->QEK_LOJFOR + " - " + SA2->A2_NOME,oReport:Row(),200)
			oReport:SkipLine()
		Else
			oReport:PrintText(AllTrim(QER030StRe("QEK_FORNEC")) + Replicate(".",23-Len(AllTrim(QER030StRe("QEK_FORNEC")))) + ": " + AllTrim(QEK->QEK_FORNEC) + "/" + QEK->QEK_LOJFOR + " - " + SA1->A1_NOME,oReport:Row(),200)
			oReport:SkipLine()
		Endif
		
		oSection2:Init()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pesquisa os dados do item da Nota Fiscal original³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cTamLot  := QEK->QEK_TAMLOT 
		dEntrada := QEK->QEK_DTENTR	       
		If lQtdRep
			If AllTrim(QEK->QEK_TIPDOC) == "TR" 
				dEntrada := QEK->QEK_DTNFIS				
				If !Empty(QEK->QEK_LOTORI)
					cTamLot := QEK->QEK_LOTORI 
				EndIf
			EndIf
		EndIf                       
	
		cTamLot+=Posicione("SAH",1,xFilial("SAH")+QEK->QEK_UNIMED,"AH_UMRES")									
			
		oSection2:Cell("QEK_TAMLOT"):SetValue(cTamLot)
		oSection2:Cell("QEK_DTENTR"):SetValue(dEntrada)
			              
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a ImpressÆo dos dados da Entrega             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection2:Cell("A5_CODPRF"):Disable()	
		If QEK->QEK_TIPONF $ "N "                    
			oSection2:Cell("A5_CODPRF"):Enable()
		EndIf	              
		
		oReport:PrintText(AllTrim(QER030StRe("QEK_PRODUT"))+Replicate(".",23-Len(AllTrim(QER030StRe("QEK_PRODUT")))) + ": " + ALLTRIM(QEK->QEK_PRODUT) + " - " + Posicione("QE6",1,xFilial("QE6")+QEK->QEK_PRODUT+INVERTE(QEK->QEK_REVI),If(cIdioma == INGLES,"QE6_DESCIN",If(cIdioma == ESPANHOL,"QE6_DESCES","QE6_DESCPO"))),oReport:Row(),200)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("A5_CODPRF"))+Replicate(".",23-Len(AllTrim(QER030StRe("A5_CODPRF")))) + ": " + SA5->A5_CODPRF,oReport:Row(),200)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("QEK_DTENTR"))+Replicate(".",23-Len(AllTrim(QER030StRe("QEK_DTENTR")))) + ": " + DTOC(QEK->QEK_DTENTR),oReport:Row(),200)
		oReport:PrintText(AllTrim(QER030StRe("QEK_LOTE"))+Replicate(".",19-Len(AllTrim(QER030StRe("QEK_LOTE")))) + ": " + QEK->QEK_LOTE,oReport:Row(),1200)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("QEK_NTFISC"))+Replicate(".",23-Len(AllTrim(QER030StRe("QEK_NTFISC")))) + ": " + QEK->QEK_NTFISC,oReport:Row(),200)
		oReport:PrintText(AllTrim(QER030StRe("QEK_DTNFIS"))+Replicate(".",19-Len(AllTrim(QER030StRe("QEK_DTNFIS")))) + ": " + DTOC(QEK->QEK_DTNFIS),oReport:Row(),1200)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("QEK_PEDIDO"))+Replicate(".",23-Len(AllTrim(QER030StRe("QEK_PEDIDO")))) + ": " + QEK->QEK_PEDIDO,oReport:Row(),200)
		oReport:PrintText(AllTrim(QER030StRe("QEK_DOCENT"))+Replicate(".",19-Len(AllTrim(QER030StRe("QEK_DOCENT")))) + ": " + QEK->QEK_DOCENT,oReport:Row(),1200)
		oReport:SkipLine()
		oReport:PrintText(AllTrim(QER030StRe("QEK_CERFOR"))+Replicate(".",23-Len(AllTrim(QER030StRe("QEK_CERFOR")))) + ": " + QEK->QEK_CERFOR,oReport:Row(),200)
		oReport:PrintText(AllTrim(QER030StRe("QEK_TAMLOT"))+Replicate(".",19-Len(AllTrim(QER030StRe("QEK_TAMLOT")))) + ": " + QEK->QEK_TAMLOT,oReport:Row(),1200)
		oReport:SkipLine()
						
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a ImpressÆo do Texto Justificativas          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:SkipLine()
		cArqTxt := "QER33"+SubStr(cNumEmp,1,2)+cIdioma+".TXT"
		If File(cArqTxt)
			cTexto := MemoRead(cArqTxt)
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
				oReport:PrintText(cImpLinha,oReport:Row(),025)		
				oReport:SkipLine()
			Next nC
			oReport:SkipLine()
		Else
			oReport:SkipLine()
		EndIf
			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a ImpressÆo do Texto Instrucoes - Digita‡Æo  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cArqTxt := "QER34"+SubStr(cNumEmp,1,2)+cIdioma+".TXT"
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
				oReport:PrintText(cImpLinha,oReport:Row(),025)		
				oReport:SkipLine()
			Next nC
		Else
			oReport:SkipLine()
		EndIf	
		oReport:SkipLine()
				
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a ImpressÆo do Texto An lise Interna         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cArqTxt := "QER35"+SubStr(cNumEmp,1,2)+cIdioma+".TXT"
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
				oReport:PrintText(cImpLinha,oReport:Row(),025)		
				oReport:SkipLine()
			Next nC
		Else
			oReport:SkipLine()
		EndIf	              
		oReport:SkipLine()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a ImpressÆo do Nome do Fornecedor            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:PrintText(SA2->A2_NOME,oReport:Row(),2500)
		oReport:SkipLine()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a ImpressÆo da Data da Garantia da Qualidade ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:PrintText(QER030StRe("Str0040"),oReport:Row(),2500)	//"Garantia da Qualidade       /     /
		oReport:SkipLine()
		
		oReport:SkipLine()
	    oReport:PrintText(AllTrim(Str(nCt))+ QER030StRe("Str0029") + " " + aDest[nCt,1],oReport:Row(),010) //"a. via: "
	
	EndIf 
	
	oReport:SkipLine()
     
           

	
	
	IF nCt <> Len(aDest)
		oReport:EndPage(.T.)
	Endif	
	oSection1:Finish()    
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCt := 1 To Len(aOrd)
	dbSelectArea(aOrd[nCt][1])
	Set Filter To
	dbSetOrder(aOrd[nCt][2])
Next

Return NIL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QER030ChgIt ºAutor  ³Cleber Souza      º Data ³  06/14/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Salva conteudo ds objetos na mudanca de itens do TwBrowse  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAQIE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QER030ChgIt()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Salva conteudo do Objeto Antigo.									   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nItemAnt <= 5
	aTextos[nItemAnt,POR] := cTexPOR
	aTextos[nItemAnt,ING] := cTexING
	aTextos[nItemAnt,ESP] := cTexESP
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Carrega Conteudos da Variavel Nova.								   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nItem <= 5
	cTexPOR := aTextos[nItem,POR]
	cTexING := aTextos[nItem,ING]
	cTexESP := aTextos[nItem,ESP] 
	
	aGetTxt[nItem,POR]:Refresh()
	aGetTxt[nItem,ING]:Refresh()
	aGetTxt[nItem,ESP]:Refresh()
	
EndIF 

Return(.T.)     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QER030Carr  ³Autor³ Cleber Souza          ³ Data ³ 14/06/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega os Cpos/Str de acordo com o parametro passado      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIER030                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QER030Carr()
Local nInicio := 0
Local nI 	  := 0
Local nY 	  := 0
Local cTexto  := ""
Local cVarStr := ""
Local aVarStr := ARRAY(3)

For nY:=1 to 3
	
	aVarStr[nY]:={}
	If nY == ING
		nInicio := 61
	ElseIf nY == ESP
		nInicio := 111
	Else
		nInicio := 11
	EndIf
	
	If File(ARQTXT)
		
		cTexto := MemoRead(ARQTXT)
		If At("Str0027",cTexto)==0
			cTexto := Substr(cTexto,1,At("Str0028",cTexto)-1) + ;
			Pad("Str0027",10," ")+;
			Pad(STR0027,50," ")+;
			Pad(STR0027,50," ")+;
			Pad(STR0027,50," ")+;
			Chr(13)+Chr(10)+;
			Substr(cTexto,At("Str0028",cTexto),Len(cTexto)-At("Str0028",cTexto))
			
			If !MemoWrit(ARQTXT, cTexto) // Grava atualizado
				HELP(" ",1,"NODIRCQ")
				Return .F.
			EndIf
		EndIf
		cVarStr := ""
		For nI := 1 To MlCount(cTexto,161)
			cVarStr := MemoLine(cTexto,161,nI)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Leio a linha separando os STR ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			AADD(aVarStr[nY],{ AllTrim(Subs(cVarStr,1,10)), Subs(cVarStr,nInicio,49) })

			If "QEK_DOCENT" == AllTrim(Subs(cVarStr,1,10)) .AND. "Doc. Entrada" $ AllTrim(Subs(cVarStr, 11,LEN(cVarStr) ))
				
				aVarStr[nY,nI,2] := FwX3Titulo("QEK_DOCENT") //"Lote Fornec"

			EndIf
		Next
		
	Else
		
		If QER030StGrv(.T.)
			cTexto := MemoRead(ARQTXT)
			cVarStr := ""
			For nI := 1 To MlCount(cTexto,161)
				cVarStr := MemoLine(cTexto,161,nI)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Leio a linha separando os STR ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				AADD(aVarStr[nY],{ AllTrim(Subs(cVarStr,1,10)),;
				Subs(cVarStr,nInicio,49) })
			Next
		Else
			aVarStr[nY] := {}
		EndIf
		
	EndIf
Next nY

Return(aVarStr) 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QER030StGrv³ Autor ³ Cleber Souza         ³ Data ³ 14/06/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava os Cpos/Str num arq. TXT                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QER030StGrv()                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QER030StGrv(lNew)
Local cTexto   := ""
Local cVarStr  := ""
Local nI 	   := 0
Local nY       := 0
Local nInicio  := 0
Local nHdl 	   := 0
Local aStrCpo  := {}
                    
Aadd(aStrCpo,"QEK_PRODUT")
Aadd(aStrCpo,"A5_CODPRF" )
Aadd(aStrCpo,"QEK_DTENTR")
Aadd(aStrCpo,"QEK_LOTE"  )
Aadd(aStrCpo,"QEK_NTFISC")
Aadd(aStrCpo,"QEK_DTNFIS")
Aadd(aStrCpo,"QEK_PEDIDO")
Aadd(aStrCpo,"QEK_DOCENT")
Aadd(aStrCpo,"QEK_CERFOR")
Aadd(aStrCpo,"QEK_TAMLOT")
Aadd(aStrCpo,"QE7_ENSAIO")
Aadd(aStrCpo,"QE7_LIE"   )
Aadd(aStrCpo,"QE7_LSE"   )
Aadd(aStrCpo,"QE7_UNIMED")
Aadd(aStrCpo,"QEL_LAUDO" )
Aadd(aStrCpo,"QEL_JUSTLA")
Aadd(aStrCpo,"QEL_QTREJ" )
Aadd(aStrCpo,"QEK_FORNEC")
Aadd(aStrCpo,"A2_CGC"    )
Aadd(aStrCpo,"A2_FAX"    )
Aadd(aStrCpo,"A2_TEL"    )
Aadd(aStrCpo,"A2_CEP"    )

Aadd(aStrCpo,{"Str0027",STR0027})
Aadd(aStrCpo,{"Str0028",STR0028})
Aadd(aStrCpo,{"Str0029",STR0029})
Aadd(aStrCpo,{"Str0030",STR0030})
Aadd(aStrCpo,{"Str0031",STR0031})
Aadd(aStrCpo,{"Str0032",STR0032})
Aadd(aStrCpo,{"Str0033",STR0033})
Aadd(aStrCpo,{"Str0034",STR0034})
Aadd(aStrCpo,{"Str0035",STR0035})
Aadd(aStrCpo,{"Str0036",STR0036})
Aadd(aStrCpo,{"Str0037",STR0037})
Aadd(aStrCpo,{"Str0038",STR0038})
Aadd(aStrCpo,{"Str0039",STR0039})
Aadd(aStrCpo,{"Str0040",STR0040})
Aadd(aStrCpo,{"Str0041",STR0041})
Aadd(aStrCpo,{"Str0051",STR0051})

IF(aPrincipal==NIL,aPrincipal:={},NIL)     
IF(lNew==NIL,lNew:=.F.,NIL)     

For nY:=1 to 3
                      
	If !lNew 
		If nY == ING
			nInicio := 61
		ElseIf nY == ESP
			nInicio := 111
		Else
			nInicio := 11
		EndIf
	Else
		nInicio := 0 // Faz um novo com valores padroes
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verificacao se ‚ poss¡vel efetuar grava‡Æo                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTexto := "X"
	nHdl   := msfCreate(cTexto,0)
	If nHdl <= -1
		HELP(" ",1,"NODIRCQ")
		Return .F.
	Else
		If File(cTexto)
			fClose(nHdl)
			fErase(cTexto)
		Endif
	Endif

	cTexto := ""

	If File(ARQTXT) .And. nInicio > 0
	
		cTexto  := MemoRead(ARQTXT)
		cVarStr := ""
		aStrCpo := {}
		For nI := 1 To MlCount(cTexto,161)
			cVarStr := MemoLine(cTexto,161,nI)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Leio a linha separando os STR ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
			If "QEK_DOCENT" == AllTrim(Subs(cVarStr,1,10)) .AND. "Doc. Entrada" $ AllTrim(Subs(cVarStr, 11,LEN(cVarStr) ))
				AADD(aStrCpo,;
				{ AllTrim(Subs(cVarStr,1,10)),;
				{FwX3Titulo("QEK_DOCENT") ,; //"Lote Fornec"
				FwX3Titulo("QEK_DOCENT")  ,; //"Lote Fornec"
				FwX3Titulo("QEK_DOCENT") }  }) //"Lote Fornec"
			Else
				AADD(aStrCpo,;
				{ AllTrim(Subs(cVarStr,1,10)),;
				{ Subs(cVarStr, 11,50 ),;
				Subs(cVarStr, 61,50 )  ,;
				Subs(cVarStr,111,50 ) }  })
			Endif
		Next
        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Inclusao de Str Novo³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		IF Ascan(aStrCpo,{|x| x[1]=="Str0051"}) == 0
			Aadd(aStrCpo,{"Str0051",{STR0051,STR0051,STR0051}}) //Cronica
		Endif                                
		
		cTexto := ""
		For nI := 1 To Len(aStrCpo)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ S¢ ‚ carregada um idioma por vez, os outros dois sao completados           ³
			//³ com o conte£do de aStrCpo,                                                 ³
			//³ ‚ carregado com base no QIER030.TXT, s¢ alterando os valores do novo       ³
			//³ idioma.                                                                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nI > Len(aPrincipal[nY])
				cTexto := cTexto + Pad(aStrCpo[nI,1],10," ")+;
				Pad(aStrCpo[nI,2,1],50," ")+;
				Pad(aStrCpo[nI,2,2],50," ")+;
				Pad(aStrCpo[nI,2,3],50," ")+;
				Chr(13)+Chr(10)
			Else
				If Subs(aStrCpo[nI,1],1,3) == "Str"  // Processa Strs ou Cpos....
				
	  				cTexto := cTexto + Pad(aStrCpo[nI,1],10," ")+;
					If(nInicio== 11,Pad(aPrincipal[nY,nI,2],50," "),Pad(aStrCpo[nI,2,1],50," "))+;
					If(nInicio== 61,Pad(aPrincipal[nY,nI,2],50," "),Pad(aStrCpo[nI,2,2],50," "))+;
					If(nInicio==111,Pad(aPrincipal[nY,nI,2],50," "),Pad(aStrCpo[nI,2,3],50," "))+;
					Chr(13)+Chr(10)
				
				Else
					cTexto := cTexto + Pad(aStrCpo[nI,1],10," ")+;
					If(nInicio== 11,Pad(aPrincipal[nY,nI,2],50," "),Pad(aStrCpo[nI,2,1],50," "))+;
					If(nInicio== 61,Pad(aPrincipal[nY,nI,2],50," "),Pad(aStrCpo[nI,2,2],50," "))+;
					If(nInicio==111,Pad(aPrincipal[nY,nI,2],50," "),Pad(aStrCpo[nI,2,3],50," "))+;
					Chr(13)+Chr(10)
				EndIf
			
			EndIf
		
		Next
	
	Else
	
		For nI := 1 To Len(aStrCpo)
			If ValType(aStrCpo[nI]) == "A"  // Processa Strs ou Cpos...
				cTexto := cTexto + Pad(aStrCpo[nI,1],10," ")+;
				Pad(aStrCpo[nI,2],50," ")+;
				Pad(aStrCpo[nI,2],50," ")+;
				Pad(aStrCpo[nI,2],50," ")+;
				Chr(13)+Chr(10)
			Else
				cTexto := cTexto + Pad(aStrCpo[nI],10," ")+;
				Pad(TitSX3(aStrCpo[nI])[1],50," ")+;
				Pad(TitSX3(aStrCpo[nI])[1],50," ")+;
				Pad(TitSX3(aStrCpo[nI])[1],50," ")+;
				Chr(13)+Chr(10)
			EndIf
		Next
	
	EndIf

	If !MemoWrit(ARQTXT, cTexto) // Grava atualizado
		HELP(" ",1,"NODIRCQ")
		Return .F.
	EndIf
    
	If lNew
		Exit
	EndIF	
Next nY

Return(.T.)          

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QER030StVal ³Autor³ Cleber Souza          ³ Data ³ 14/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se ocorreu foi digitada alguma altera‡Æo          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIER030                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QER030StVal(cCpoEdit, cCpoAtual,cCpoItem,oCpoAtual,aPrincipal,lModificad,nIdioma)

If !(AllTrim(cCpoEdit) == AllTrim(cCpoAtual))
	If MsgNoYes(OemToAnsi(STR0042),OemToAnsi(STR0009)) //"O valor do campo foi alterado. Você deseja atualizar o campo para este novo valor ?"###"Notificacao de Nao Conformidade"
		aPrincipal[nIdioma][aScan(aPrincipal[nIdioma],{|x| x[1] == cCpoItem })][2]	:= cCpoEdit
		cCpoAtual := cCpoEdit
		oCpoAtual:Refresh()
		lModificad := .T.
	EndIf
EndIf

Return(.T.)  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QER030VALI³ Autor ³ Cleber Souza          ³ Data ³ 15/06/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Consiste os 4 Laudos informados                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QER030VALI(ExpC1)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QER030VALI()
Local lRetorna := .T.
Local nI       := 0
Local nY       := 0

For nI := 1 To Len(aLaudo) 
	For nY:=1 to Len(aLaudo[nI])
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Retorna .F. quando ha uma Via sem laudo correspondente mas libera  ³
		//³  se os dois estiverem vazios                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Do Case
			Case Empty(aLaudo[nI,nY]) .And. !Empty(aVia[nI,nY])
				MsgInfo(OemToAnsi(STR0043),OemToAnsi(STR0009)) // "E necessario informar tanto o Laudo quanto a Via."###"Notificacao de Nao Conformidade"
				lRetorna := .F.
				Exit
			Case Empty(aVia[nI,nY]) .And. !Empty(aLaudo[nI,nY])
				MsgInfo(OemToAnsi(STR0043),OemToAnsi(STR0009))  //"E necessario informar tanto o Laudo quanto a Via."###"Notificacao de Nao Conformidade"
				lRetorna := .F.
				Exit
		EndCase
	Next nY 
Next nI	
Return(lRetorna)   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QER030Laud³ Autor ³ Cleber Souza         ³ Data ³ 14/06/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Consiste o Laudo informado                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QER030Laud(ExpC1)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Laudo informado                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QER030Laud(cLaudo)
Local lRetorna:= .T.

QED->(dbSetOrder(1))
If !Empty(cLaudo)
	If !QED->(dbSeek(xFilial("QED")+cLaudo))
		lRetorna := .F.
		MsgAlert(OemToAnsi(STR0044),OemToAnsi(STR0009)) // "Informe um Laudo Valido"###"Notificacao De Nao Conformidade"
	EndIf
Else
	lRetorna := .T. // Libera o usu rio se vazio
EndIf

Return(lRetorna)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QER030GRVALL ³Autor³ Cleber Souza         ³ Data ³ 14/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Realiza a gravação dos dados informados nos TXTs           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIER030                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QER030GRVALL()   

Local nX      :=0
Local nY      :=0
Local nZ      :=0
Local cIdioma :=""  
Local cCpoTxt :=""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Grava textos referentes aos itens 1 ao 5.						   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nY:=1 to Len(aTextos)
	For nX:=1 to Len(aTextos[nY])
        IIF(nX==1,cIdioma:="P",IIF(nX==2,cIdioma:="I",cIdioma:="E"))
		cNomeArq := "QER3"+StrZero(nY,1)+SubStr(cNumEmp,1,2)+cIdioma+".TXT"
		MemoWrit(cNomeArq,aTextos[nY,nX])		
	Next nX
Next nY	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Grava os responsaveias pelas Vias cadastradas.					   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 to 3
	For nY := 1 to Len(aVia) 
		IIF(nX==1,cIdioma:="P",IIF(nX==2,cIdioma:="I",cIdioma:="E"))
		cNomeArq := "QER3"+StrZero(6,1)+SubStr(cNumEmp,1,2)+cIdioma+".TXT"

   		If !Empty(aVia[nY,nX]) .and. !Empty(aLaudo[nY,nX])
  			cCpoTxt += AllTrim(Str(nY))+" "+aVia[nY,nX]+" "+aLaudo[nY,nX]+Chr(13)+Chr(10)
		Else
			nZ++
		EndIf
	Next nY
	If nZ == Len(aVia)
		MemoWrit(cNomeArq, cCpoTxt)
	Else
		IF(Len(cCpoTxt)>0, MemoWrit(cNomeArq, cCpoTxt), NIL)
	EndIf
	nZ:=0
	cCpoTxt := ""
Next nX 
                 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Grava os campos e Strings										   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QER030StGrv(.F.)

Return(NIL) 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QER030NNC     ³Autor³ Cleber Souza        ³ Data ³ 15/06/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se existe Nao Conformidade.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIER030                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QER030NNC(lR4)
Local nOcor		:= 0
Local cSeek 
Local nOrdem  
Local cChaQER
Local cChave
Local cNiseri	:= ""
Local lQReinsp	:= QieReinsp()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verif. cada resultado da Entrada se possui NC ou se esta fora espec. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QER")
cNiseri := QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
cSeek:=xFilial("QER")+QEK->QEK_PRODUT+QEK->QEK_REVI+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+cNiseri+QEK->QEK_TIPONF+QEK->QEK_LOTE
cChaQER  := "(QER->QER_FILIAL+QER->QER_PRODUT+QER->QER_REVI+QER->QER_FORNEC+QER->QER_LOJFOR+QER->QER_NISERI+QER->QER_TIPONF+QER->QER_LOTE)"  
nOrdem  := 5
dbSetOrder(nOrdem)
dbSeek(cSeek)
	
While !Eof() .And. &cChaQER == cSeek

	If lQReinsp
		If QER->QER_NUMSEQ <> mv_par09
			QER->(dbSkip())
			Loop
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chave de ligacao com o QEU - Nao Conformidades das Entradas  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cChave := QER->QER_CHAVE
		
	QE1->(dbSetOrder(1))
	If QE1->(dbSeek(xFilial("QE1")+QER->QER_ENSAIO))
	
		dbSelectArea("QEU")
		dbSetOrder(1)
		If dbSeek(xFilial("QEU")+cChave)
			While !Eof() .And. xFilial("QEU") == QEU_FILIAL .And. cChave == QEU_CODMED

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Realiza os filtros de usuario para o Release 4                            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lR4
					If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QEU")))
						If !QEU->(&(oReport:Section(1):GetAdvplExp("QEU")))
							dbSelectArea("QEU") 
							dbSetOrder(1)
							DbSkip()
						Endif
					EndIf
				Endif

				cChavTxt := QEU_CHAVE
				cNConf   := QEU_NAOCON
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta array com nao conformidades encontradas                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				SAG->(dbSetOrder(1))
				If SAG->(dbSeek(xFilial("SAG")+cNConf))
					QEE->(dbSetOrder(1))
					If QEE->(dbSeek(xFilial("QEE")+QEU->QEU_CLASSE))
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Ser  Calculado o nr. de ocorrencias encontradas              ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						nOcor := QER030Ocor(QEU->QEU_NAOCON,QEK->QEK_TIPONF)
							
						If cIdioma == INGLES
							AADD(aNConf,{nENS,SAG->AG_DESCIN,QEU->QEU_NUMNC,QEE->QEE_DESCIN,cChavTxt,Str(QEE->QEE_PONTOS,2),nOcor,QEU->QEU_DEMIQI})
						ElseIf cIdioma == ESPANHOL
							AADD(aNConf,{nENS,SAG->AG_DESCES,QEU->QEU_NUMNC,QEE->QEE_DESCES,cChavTxt,Str(QEE->QEE_PONTOS,2),nOcor,QEU->QEU_DEMIQI})
						Else
							AADD(aNConf,{nENS,SAG->AG_DESCPO,QEU->QEU_NUMNC,QEE->QEE_DESCPO,cChavTxt,Str(QEE->QEE_PONTOS,2),nOcor,QEU->QEU_DEMIQI})
						EndIf
							
					EndIf
				Endif           
				dbSelectArea("QEU") 
				dbSetOrder(1)
				DbSkip()
			EndDo
			nOcor := 0
				
			If QE1->QE1_CARTA <> "TXT"
				QES->(dbSetOrder(1))
				If QES->(dbSeek(xFilial("QES")+cChave))
					While !QES->(EOF()) .And. QES->QES_FILIAL == xFilial("QES") .and.;
						QES->QES_CODMED == cChave
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Monta array c/ os valores de medicoes mensur veis(QES)    ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						AADD(aResult,{nEns,QES->QES_MEDICA})
						QES->(dbSkip())
					EndDo
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Monta array c/ os ensaios mensur veis dos produtos(QE7)      ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					QE7->(dbSetOrder(1))
					QE7->(dbSeek(xFilial("QE7")+QER->QER_PRODUT+QER->QER_REVI+QER->QER_ENSAIO))
					AADD(aEnsaio,{nEns,QER->QER_ENSAIO,QE7->QE7_LIE,QE7->QE7_LSE,QE7->QE7_UNIMED,"NTXT"})
				EndIf
			Else
				QE8->(dbSetOrder(1))
				QE8->(dbSeek(xFilial("QE8")+QER->QER_PRODUT+QER->QER_REVI+QER->QER_ENSAIO))
				cTxt := QE8->QE8_TEXTO

				QEQ->(dbSetOrder(1))
				QEQ->(dbSeek(xFilial("QEQ")+cChave))
				cTxtRes := QEQ->QEQ_MEDICA

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta £nico array com Ensaios textos e valores de medic.(QEQ)³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				AADD(aResTXT,{QE8->QE8_TEXTO,QEQ->QEQ_MEDICA,QER->QER_ENSAIO,nEns})
				AADD(aEnsaio,{nEns,,,,,"TXT" })
			Endif
			nEns++
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se há medicoes fora da especificacao ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			// So verifica se nao tiver NC, porque se tiver, ja relacionou o ensaio
			// e seus resultados
			If cQERESNC == "S"	// Ind. se considera med. fora espec. como NC
				If QER->QER_RESULT == "R"	// Fora espec. e da tolerancia
					If QE1->QE1_CARTA <> "TXT"
						
						QES->(dbSetOrder(1))
						If QES->(dbSeek(xFilial("QES")+cChave))
							While !QES->(EOF()) .And. QES->QES_FILIAL == xFilial("QES") .and.;
								QES->QES_CODMED == cChave
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ Monta array c/ os valores de medicoes mensur veis(QES)    ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								AADD(aResult,{nEns,QES->QES_MEDICA})
								QES->(dbSkip())
							EndDo
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Monta array c/ os ensaios mensur veis dos produtos(QE7)      ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							QE7->(dbSetOrder(1))
							If QE7->(dbSeek(xFilial("QE7")+QER->QER_PRODUT+QER->QER_REVI+QER->QER_ENSAIO))
								AADD(aEnsaio,{nEns,QER->QER_ENSAIO,QE7->QE7_LIE,QE7->QE7_LSE,QE7->QE7_UNIMED,"NTXT"})
							EndIf
						EndIf
					Else
						QE8->(dbSetOrder(1))
						If QE8->(dbSeek(xFilial("QE8")+QER->QER_PRODUT+QER->QER_REVI+QER->QER_ENSAIO))
							cTxt := QE8->QE8_TEXTO
							QEQ->(dbSetOrder(1))
							QEQ->(dbSeek(xFilial("QEQ")+cChave))
							cTxtRes := QEQ->QEQ_MEDICA
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Monta £nico array com Ensaios textos e valores de medic.(QEQ)³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							AADD(aResTXT,{QE8->QE8_TEXTO,QEQ->QEQ_MEDICA,QER->QER_ENSAIO,nEns})
							AADD(aEnsaio,{nEns,,,,,"TXT" })
						EndIf
					EndIf
					nEns++
				EndIf
			EndIf
		EndIf
	EndIf              
	
	dbSelectArea("QER")
	dbSetOrder(1)
	dbSkip()

EndDo

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QER030Ocor ³ Autor ³ Cleber Souza        ³ Data ³ 15/06/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula a reicidencia da NC para o Produto e Fornecedor    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QER030Ocor()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QER030Ocor(cNConf,cTipoNF)
Local nOcor    := 0
Local dDtLimite
Local cFornec  := QEK->QEK_FORNEC
Local cLojFor  := QEK->QEK_LOJFOR
Local cProdut  := QEK->QEK_PRODUT
Local cCh      := ""
Local nDias	   := GetMv("MV_QDIREIN")
Local aAreaQEK := QEK->(GetArea())
Local aAreaQER := QER->(GetArea())
Local aAreaQEU := QEU->(GetArea())
Local cSeek    := "" 
Local cChave   := ""
Local nOrdem   := ""
Local cNiseri  := ""
Local lQReinsp := QieReinsp()

dbSelectArea("QEK")
dDtLimite := (QEK->QEK_DTENTR-nDias)
dbgotop()
While !QEK->(Eof()) .And. QEK->QEK_FILIAL == xFilial("QEK") .And. ;
	QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT == cFornec+cLojFor+cProdut
	
	If cTipoNF == " "
		If !(QEK_TIPONF $ "N ")
	        QEK->(dbSkip())
	        Loop                
		EndIf	
	Else		
		If !(QEK_TIPONF == cTipoNF)
	        QEK->(dbSkip())
	        Loop                
		EndIf	
	EndIf         
	
	If (QEK->QEK_DTENTR < dDtLimite)
		Exit
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona os resultados da Entrada                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNiseri := QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
	cSeek   := xFilial("QER")+QEK->QEK_PRODUT+QEK->QEK_REVI+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+cNiseri+QEK->QEK_TIPONF+QEK->QEK_LOTE
	cChave  := "(QER->QER_FILIAL+QER->QER_PRODUT+QER->QER_REVI+QER->QER_FORNEC+QER->QER_LOJFOR+QER->QER_NISERI+QER->QER_TIPONF+QER->QER_LOTE)"  
	nOrdem  := 5

	QER->(dbSetOrder(nOrdem))
	If QER->(dbSeek(cSeek))  
		
		While !QER->(Eof()) .And. &cChave == cSeek
		
			If lQReinsp
				If QER->QER_NUMSEQ <> mv_par09
					QER->(dbSkip())
					Loop
				Endif
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Obtem chave de ligacao da medicao com os outros arquivos     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cCh := QER->QER_CHAVE
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a medicao tem NC                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			QEU->(dbSetOrder(1))
			QEU->(dbSeek(xFilial("QEU")+cCh))
			While !QEU->(eof()) .And. QEU->QEU_FILIAL == xFilial("QEU") .And.;
				QEU->QEU_CODMED == cCh
				If QEU->QEU_NAOCON == cNConf
					nOcor++
				EndIf
				QEU->(dbSkip())
			EndDo
			
			QER->(dbSkip())
		EndDo
	EndIf
	QEK->(dbSkip())
EndDo

//Retorna a area corrente
RestArea(aAreaQEK)
RestArea(aAreaQER)
RestArea(aAreaQEU)

Return(nOcor)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QER030Vias    ³Autor³ Cleber Souza        ³ Data ³ 15/06/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Fun‡Æo que retorna o array com o destino das Vias           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIER030                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QER030Vias(cIdioma)
Local aVias    := {}
Local nI       := 1
Local cNomeArq := ""
Local cTexto   := ""
Local cVia     := ""
Local cLaudo   := ""
Local cLinha   := ""

cNomeArq := "QER36"+SubStr(cNumEmp,1,2)+cIdioma+".TXT"

If File(cNomeArq)
	cTexto := MemoRead(cNomeArq)
	For nI := 1 To MlCount(cTexto)
		cLinha := MemoLine(cTexto,254,nI)
		cVia   := Subs(cLinha,3,20)
		cLaudo := Subs(cLinha,24,1)
		Aadd(aVias, {cVia, cLaudo})
	Next
EndIf

Return(aVias)     

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QER030StRe³ Autor ³ Cleber Souza          ³ Data ³ 15/06/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Recupera os Str pertinentes ao idioma                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QER030StRe() Recupera arrays de Strs trazidos por r030StCar³±±
±±³          ³  trabalha em conjunto com aVarStr declarada como Private   ³±±
±±³          ³  na fun‡Æo chamadora                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QER030StRe(cStrProc)
Local nI
Local cRetorno

nI := aScan(aVarStr[mv_par11],{|x| x[1] == cStrProc})

If nI > 0
	If Subs(aVarStr[mv_par11,nI,1],1,3) == "Str"
		cRetorno  := AllTrim(aVarStr[mv_par11,nI,2])
	Else
		cRetorno  := aVarStr[mv_par11,nI,2]
	EndIf
Else
	cRetorno := TitSx3(cStrProc)[1]
EndIF

Return(cRetorno)
