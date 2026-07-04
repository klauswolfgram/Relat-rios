/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ษออออออออหออออออออป
// บ Versao บ 11     บ
// ศออออออออสออออออออผ
#Include "OFIOR610.ch"
#Include "Protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ OFIOR610 บ Autor ณ Andre Luis Almeida บ Data ณ  05/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Etiqueta para Itens (Impressora Termica)                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Uso      ณ Concessionarias                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function OFIOR610()
Local OXvermelho
Local OXverde

Local oInterfHelper := DMS_InterfaceHelper():New()
Local aObjects      := {} , aInfo := {}, aPos := {}
Local aSizeAut      := MsAdvSize(.t.)  // Tamanho Maximo da Janela (.t.=TOOLBAR,.f.=SEM TOOLBAR)

Private overde   := LoadBitmap( GetResources(), "BR_verde")
Private overmelho:= LoadBitmap( GetResources(), "BR_vermelho")
Private cNFE := Space(TamSX3("F1_DOC")[1])
Private cNSE := Space(TamSX3("F1_SERIE")[1])
Private cFor := Space(TamSX3("F1_FORNECE")[1])
Private cFoL := Space(TamSX3("F1_LOJA")[1])
Private cNom := space(100)
Private cGrI := Space(TamSX3("D1_GRUPO")[1])
Private cCdI := Space(TamSX3("D1_COD")[1])
Private cDcI := space(100)
Private cGrF := Space(TamSX3("D1_GRUPO")[1])
Private cCdF := Space(TamSX3("D1_COD")[1])
Private cDcF := space(100)
Private cAlm := Space(TamSX3("D1_LOCPAD")[1])
Private cLcI := Space(TamSX3("B5_LOCALI2")[1])
Private cLcF := Repl("ZZZZZZZZZZZZZZZZ",TamSX3("B5_LOCALI2")[1])
Private nQtd := 0
Private aIte := {}
Private nCkPerg1 := 1
Private nCkPerg2 := 2
Private nCkPerg3 := 1
Private nCkPerg4 := 1
Private nVetor := 0
Private aTpEtq := {STR0001,STR0002}
Private cTpEtq := STR0001
Private cPerg  := "OFR610"

Aadd(aIte,{.f.,"","","",0,"","",""})


oInterfHelper:nOpc := 2
oInterfHelper:SetOwnerPvt("OFIOR610")

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ],aSizeAut[ 3 ] ,aSizeAut[ 4 ], 3, 3 } // Tamanho total da tela
aAdd( aObjects, { 100 , 100 , .T. , .T. } ) // 100%
aPos := MsObjSize( aInfo, aObjects )

DEFINE MSDIALOG oEtqBarra FROM aSizeAut[7],0 TO aSizeAut[6],aSizeAut[5] TITLE (STR0003) OF oMainWnd PIXEL STYLE DS_MODALFRAME STATUS 
oEtqBarra:lEscClose := .F.

oFWLayer := FWLayer():New()
oFWLayer:Init(oEtqBarra,.t.)

oFWLayer:AddLine('WIN_TOP',23,.f.) // Janela do Objeto do Topo
oFWLayer:addCollumn('WIN_TOP1',050,.F.,"WIN_TOP") // Topo Esquerda
oFWLayer:addCollumn('WIN_TOP2',050,.F.,"WIN_TOP") // Topo Esquerda

oFWLayer:AddLine('WIN_MID',62,.t.) // Janela do Objeto do Centro
oFWLayer:addCollumn('WIN_MID1',100,.F.,"WIN_MID") // Topo Esquerda

oFWLayer:AddLine('WIN_DOW',15,.f.) // Janela do Objeto do Baixo
oFWLayer:addCollumn('WIN_DOW1',050,.F.,"WIN_DOW") // Topo Esquerda
oFWLayer:addCollumn('WIN_DOW2',050,.F.,"WIN_DOW") // Topo Esquerda

oFWLayer:AddWindow('WIN_TOP1','WIN_TOPE',STR0036,100,.F.,.F.,,'WIN_TOP',) // 'Filtro'
oFWLayer:AddWindow('WIN_TOP2','WIN_TOPD',STR0037,100,.F.,.F.,,'WIN_TOP',) // 'Ordena็ใo'
oFWLayer:AddWindow('WIN_MID1','WIN_MIDG',STR0038,100,.F.,.F.,,'WIN_MID',) // 'Produtos'
oFWLayer:AddWindow('WIN_DOW1','WIN_DOWE',STR0039,100,.F.,.F.,,'WIN_DOW',) // 'Quantidade de Impressใo'
oFWLayer:AddWindow('WIN_DOW2','WIN_DOWD',STR0040,100,.F.,.F.,,'WIN_DOW',) // 'Impressใo'

oWIN_TOP1 := oFWLayer:GetWinPanel('WIN_TOP1','WIN_TOPE', 'WIN_TOP')
oWIN_TOP2 := oFWLayer:GetWinPanel('WIN_TOP2','WIN_TOPD', 'WIN_TOP')
oWIN_MID1 := oFWLayer:GetWinPanel('WIN_MID1','WIN_MIDG', 'WIN_MID')
oWIN_DOW1 := oFWLayer:GetWinPanel('WIN_DOW1','WIN_DOWE', 'WIN_DOW')
oWIN_DOW2 := oFWLayer:GetWinPanel('WIN_DOW2','WIN_DOWD', 'WIN_DOW')


// Janela Superior Esquerda
@ 001,005 RADIO oRadio1 VAR nCkPerg1 3D SIZE 60,10 PROMPT;
OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008);
OF oWIN_TOP1 PIXEL ON CHANGE (FS_RADIO("F",nCkPerg1))

@ 002,075 SAY oTit1 VAR STR0004 SIZE 40,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLACK
@ 001,108 MSGET oNFE VAR cNFE PICTURE "999999999" SIZE 40,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE
@ 001,148 MSGET oNSE VAR cNSE SIZE 15,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE
@ 014,075 SAY oTit2 VAR STR0005 SIZE 40,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLACK
@ 013,108 MSGET oFor VAR cFor F3 "FOR" VALID(cFoL:=SA2->A2_LOJA) SIZE 30,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE
@ 013,140 MSGET oFoL VAR cFoL VALID iif(!Empty(cNFE+cNSE+cFor+cFoL),Processa({ || FS_PESQ("NF") }),.t.) SIZE 10,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE
@ 027,075 SAY oNom VAR cNom SIZE 140,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE

@ 023,147 RADIO oRadio2 VAR nCkPerg2 3D SIZE 30,10 PROMPT;
OemToAnsi(STR0009),OemToAnsi(STR0010) OF oWIN_TOP1 PIXEL

@ 002,075 SAY oTit3 VAR STR0012 SIZE 40,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLACK
@ 001,098 MSGET oGrI VAR cGrI PICTURE "@!" F3 "SBM" VALID FS_POSSBM(cGrI) SIZE 20,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE
@ 001,129 MSGET oCdI VAR cCdI PICTURE "@!" VALID FS_POSSB1("I") SIZE 50,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE
@ 002,185 SAY oDcI VAR cDcI SIZE 140,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLACK
@ 014,075 SAY oTit4 VAR STR0013 SIZE 40,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLACK
@ 013,098 MSGET oGrF VAR cGrF PICTURE "@!" F3 "SBM" VALID FS_POSSBM(cGrF) SIZE 20,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE
@ 013,129 MSGET oCdF VAR cCdF PICTURE "@!" VALID FS_POSSB1("F") SIZE 50,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE
@ 014,185 SAY oDcF VAR cDcF SIZE 140,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLACK

@ 002,075 SAY oTit6 VAR STR0014 SIZE 40,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLACK
@ 001,110 MSGET oLcI VAR cLcI PICTURE "@!" SIZE 50,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE
@ 014,075 SAY oTit7 VAR STR0015 SIZE 40,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLACK
@ 013,110 MSGET oLcF VAR cLcF PICTURE "@!" SIZE 50,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE

@ 027,075 SAY oTit5 VAR STR0016 SIZE 40,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLACK
@ 026,110 MSGET oAlm VAR cAlm PICTURE "@!" SIZE 15,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLUE
@ 026,127 BUTTON oPesC PROMPT STR0017 OF oWIN_TOP1 SIZE 16,10 PIXEL ACTION (Processa({ || FS_PESQ("IT") }))
@ 026,127 BUTTON oPesL PROMPT STR0018 OF oWIN_TOP1 SIZE 31,10 PIXEL ACTION (Processa({ || FS_PESQ("LO") }))

@ 028,225 SAY (iif(nVetor>0,Transform(nVetor,"@E 999,999")+" "+ STR0035,"")) SIZE 50,08 OF oWIN_TOP1 PIXEL COLOR CLR_BLACK //itens

// Janela Superior Direita
@ 001,005 RADIO oRadio3 VAR nCkPerg3 3D SIZE 60,10 PROMPT;
Alltrim(RetTitle('B1_GRUPO'))+'+'+RetTitle('B1_CODITE'),RetTitle('B1_CODITE'),OemToAnsi(STR0008);
OF oWIN_TOP2 PIXEL ON CHANGE (FS_RADIO("O",nCkPerg3))

// Janela do Meio
oTit3:lVisible:=.f.
oTit4:lVisible:=.f.
oTit5:lVisible:=.f.
oTit6:lVisible:=.f.
oTit7:lVisible:=.f.
oRadio2:lVisible:=.f.
oGrI:lVisible:=.f.
oCdI:lVisible:=.f.
oDcI:lVisible:=.f.
oGrF:lVisible:=.f.
oCdF:lVisible:=.f.
oDcF:lVisible:=.f.
oAlm:lVisible:=.f.
oLcI:lVisible:=.f.
oLcF:lVisible:=.f.
oPesC:lVisible:=.f.
oPesL:lVisible:=.f.

@ 001,001 LISTBOX oLbIte FIELDS HEADER OemToAnsi(""),;  //"Status"
OemToAnsi(STR0019),;  //"Grupo"
OemToAnsi(STR0020),;  //"Cod.Item"
OemToAnsi(STR0021),;  //"Descricao"
OemToAnsi(STR0008),;  //"Loca็ใo
OemToAnsi(STR0022);   //"Qtd.Etiquetas"
COLSIZES 10,35,80,80,99,30 SIZE 275,155 OF oWIN_MID1 PIXEL ON CHANGE(nQtd:=(aIte[oLbIte:nAt,5]),oQtd:Refresh(),oLbIte:SetFocus()) ON DBLCLICK FS_TIK()

oLbIte:SetArray(aIte)
oLbIte:bLine := { || {Iif(aIte[oLbIte:nAt,1],overde,overmelho),;
aIte[oLbIte:nAt,2] ,;
aIte[oLbIte:nAt,3] ,;
aIte[oLbIte:nAt,4] ,;
aIte[oLbIte:nAt,7] ,;
Iif(aIte[oLbIte:nAt,1],Transform(aIte[oLbIte:nAt,5],"@E 999,999,999")," ") }}
oLBIte:Align := CONTROL_ALIGN_ALLCLIENT

// Janela Inferior Esquerda
@ 001,005 RADIO oRadio4 VAR nCkPerg4 3D SIZE 60,10 PROMPT;
OemToAnsi(STR0041),OemToAnsi(STR0042);
OF oWIN_DOW1 PIXEL

@ 004,080 SAY STR0023 SIZE 40,08 OF oWIN_DOW1 PIXEL COLOR CLR_BLUE
@ 004,100 MSGET oQtd VAR nQtd VALID FS_QTDETQ() PICTURE "@E 999,999,999" SIZE 50,08 OF oWIN_DOW1 PIXEL COLOR CLR_BLUE


// Janela Inferior Direita
@ 005,005 SAY STR0024 SIZE 40,08 OF oWIN_DOW2 PIXEL COLOR CLR_BLUE
@ 004,035 MSCOMBOBOX oTpEtq VAR cTpEtq ITEMS aTpEtq SIZE 58,10 OF oWIN_DOW2 PIXEL COLOR CLR_BLUE
@ 004,120 BUTTON oImpr PROMPT STR0025 OF oWIN_DOW2 SIZE 70,10 PIXEL ACTION FS_IMPETQ()

//@ 004, aSizeAut[6]-50 BUTTON oSair PROMPT STR0026 OF oWIN_DOW2 SIZE 44,10 PIXEL ACTION (oWIN_DOW2:End())

ACTIVATE MSDIALOG oEtqBarra CENTER
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FS_RADIO บ Autor ณ Andre Luis Almeida บ Data ณ  25/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Objeto radio								                  บฑฑ
ฑฑบ          ณ Parametro 1	- "F" - Filtro, "O" - Ordena็ใo               บฑฑ
ฑฑบ          ณ Parametro 2	- Conte๚do					                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Uso      ณ Concessionarias                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_RADIO(nFilOrd,nTp)
Local lTp1 := Iif(nTp==1,.t.,.f.)
Local lTp2 := Iif(nTp==2,.t.,.f.)
Local lTp3 := .f. 

If nFilOrd == "F" // Filtro
	
	lTp3 := Iif(nTp==3,.t.,.f.)
	oTit1:lVisible := lTp1
	oTit2:lVisible := lTp1
	oNFE:lVisible  := lTp1
	oNSE:lVisible  := lTp1
	oFor:lVisible  := lTp1
	oFoL:lVisible  := lTp1
	oNom:lVisible  := lTp1
	oTit3:lVisible := lTp2
	oTit4:lVisible := lTp2
	oRadio2:lVisible:=lTp2
	oGrI:lVisible  := lTp2
	oCdI:lVisible  := lTp2
	oDcI:lVisible  := lTp2
	oGrF:lVisible  := lTp2
	oCdF:lVisible  := lTp2
	oDcF:lVisible  := lTp2
	oPesC:lVisible := lTp2
	oTit6:lVisible := lTp3
	oTit7:lVisible := lTp3
	oLcI:lVisible  := lTp3
	oLcF:lVisible  := lTp3
	oPesL:lVisible := lTp3
	oTit5:lVisible := Iif(lTp2.or.lTp3,.t.,.f.)
	oAlm:lVisible  := Iif(lTp2.or.lTp3,.t.,.f.)

	cNFE := Space(TamSX3("F1_DOC")[1])
	cNSE := Space(TamSX3("F1_SERIE")[1])
	cFor := Space(TamSX3("F1_FORNECE")[1])
	cFoL := Space(TamSX3("F1_LOJA")[1])
	cNom := space(100)
	cGrI := Space(TamSX3("D1_GRUPO")[1])
	cCdI := Space(TamSX3("D1_COD")[1])
	cDcI := space(100)
	cGrF := Space(TamSX3("D1_GRUPO")[1])
	cCdF := Space(TamSX3("D1_COD")[1])
	cDcF := space(100)
	cAlm := Space(TamSX3("D1_LOCPAD")[1])
	cLcI := Space(TamSX3("B5_LOCALI2")[1])
	cLcF := Repl("ZZZZZZZZZZZZZZZZ",TamSX3("B5_LOCALI2")[1])
	nQtd := 0
	aIte := {}
	nVetor := 0
	Aadd(aIte,{.f.,"","","",0,"","",""})
	oLbIte:nAt := 1
	oLbIte:SetArray(aIte)
	oLbIte:bLine := { || {Iif(aIte[oLbIte:nAt,1],overde,overmelho),;
	aIte[oLbIte:nAt,2] ,;
	aIte[oLbIte:nAt,3] ,;
	aIte[oLbIte:nAt,4] ,;
	aIte[oLbIte:nAt,7] ,;
	Iif(aIte[oLbIte:nAt,1],Transform(aIte[oLbIte:nAt,5],"@E 999,999,999")," ") }}
	oLbIte:Refresh()
	oNFE:Refresh()
	oNSE:Refresh()
	oFor:Refresh()
	oFoL:Refresh()
	oQtd:Refresh()
	oNom:Refresh()
	oRadio2:Refresh()
	oGrI:Refresh()
	oCdI:Refresh()
	oDcI:Refresh()
	oGrF:Refresh()
	oCdF:Refresh()
	oDcF:Refresh()
	oAlm:Refresh()
	oLcI:Refresh()
	oLcF:Refresh()
	oTit1:Refresh()
	oTit2:Refresh()
	oTit3:Refresh()
	oTit4:Refresh()
	oTit5:Refresh()
	oTit6:Refresh()
	oTit7:Refresh()
	oPesC:Refresh()
	oPesL:Refresh()
	If lTp1
		oNFE:SetFocus()
	ElseIf lTp2
		oGrI:SetFocus()
	ElseIf lTp3
		oLcI:SetFocus()
	EndIf

Else // Ordena็ใo
	
	If lTp1 // Ordenar por Grupo + Item
		aSort(aIte,1,,{|x,y| x[2]+x[3] < y[2]+y[3] })
	ElseIf nCkPerg3 == 2 // Ordenar por Item
		aSort(aIte,1,,{|x,y| x[3] < y[3] })
	Else // Ordenar por Loca็ใo
		aSort(aIte,1,,{|x,y| x[7]+x[2]+x[3] < y[7]+y[2]+y[3] })
	Endif

	oLbIte:Refresh()
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FS_POSSBMบ Autor ณ Andre Luis Almeida บ Data ณ  25/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Posiciona no SBM							                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Uso      ณ Concessionarias                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_POSSBM(cGrupo)
Local lRet := .f.
DbSelectArea("SBM")
DbSetOrder(1)
If DbSeek(xFilial("SBM")+alltrim(cGrupo))
	lRet := .t.
	If Empty(cGrupo)
		cGrupo := SBM->BM_GRUPO
	EndIf
Else
	MsgAlert(STR0027,STR0028)
EndIf
Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FS_POSSB1บ Autor ณ Andre Luis Almeida บ Data ณ  25/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Posiciona no SB1							                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Uso      ณ Concessionarias                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_POSSB1(cTipo)
Local lRet := .t.
Local cAux := ""
If cTipo =="I"
	If !Empty(cCdI)
		cDcI := space(100)
		cAux := cCdI
		If FG_POSSB1("cCdI","SB1->B1_CODITE","cGrI")
			cGrI := SB1->B1_GRUPO
			cDcI := left(SB1->B1_DESC,20)
			cGrF := cGrI
			cCdF := cCdI
			cDcF := cDcI
		Else
			cCdI := cAux
			cGrF := space(4)
			cCdF := space(27)
			cDcF := space(100)
		EndIf
	EndIf
ElseIf cTipo =="F"
	If !Empty(cCdF)
		cDcF := space(100)
		cAux := cCdF
		If FG_POSSB1("cCdF","SB1->B1_CODITE","cGrF")
			cGrF := SB1->B1_GRUPO
			cDcF := left(SB1->B1_DESC,20)
		Else
			cCdF := cAux
		EndIf
	EndIf
EndIf
oGrI:Refresh()
oGrF:Refresh()
oDcI:Refresh()
oDcF:Refresh()
Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FS_PESQ  บ Autor ณ Andre Luis Almeida บ Data ณ  25/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Pesquisa Itens da NF Entrada				                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Uso      ณ Concessionarias                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_PESQ(cTipo) // Pesquisa Itens da NF Entrada
Local cGruVei := left(GetNewPar("MV_GRUVEI","VEI")+space(10),len(SB1->B1_GRUPO))
Local cGruSrv := left(GetNewPar("MV_GRUSRV","SRVC")+space(10),len(SB1->B1_GRUPO))
Local lSBZ    := ( ( SuperGetMV("MV_ARQPROD",.F.,"SB1") == "SBZ" ) .and. SBZ->(FieldPos("BZ_LOCALI2")) > 0 )
Local cQuery  := ""
Local cQuerySB2 := "SELECT SB2.B2_QATU FROM "+RetSqlName("SB2")+" SB2 WHERE SB2.B2_FILIAL='"+xFilial("SB2")+"' AND "
Local cQAlSB1 := "SQLSB1"
Local cQAlSB2 := "SQLSB2"
Local cTamBZ_LOCALI2 := IIF(SBZ->(FieldPos("BZ_LOCALI2")) > 0, Space(TamSX3("BZ_LOCALI2")[1]), " ")
Local ni := 0
Local nj := 0
Local lZera := .t.
If nCkPerg2 == 1 .and. len(aIte) > 0
	If !Empty(aIte[1,2]+aIte[1,3])
		If cTipo == "IT"
			lZera := .f.
		EndIf
	EndIf
EndIf
nVetor := 0
If lZera
	aIte := {}
EndIf
If cTipo == "NF"
	ProcRegua(25)
	cNom := space(100)
	DbSelectArea("SF1")
	DbSetOrder(1)
	If DbSeek(xFilial("SF1")+cNFE+cNSE+cFor+cFoL)
		DbSelectArea("SA2")
		DbSetOrder(1)
		DbSeek(xFilial("SA2")+cFor+cFoL)
		cNom := SA2->A2_NOME
		DbSelectArea("SD1")
		DbSetOrder(1)
		If DbSeek(xFilial("SD1")+cNFE+cNSE+cFor+cFoL)
			Do While !Eof() .and. SD1->D1_FILIAL == xFilial("SD1") .and. ( ( SD1->D1_DOC + SD1->D1_SERIE + SD1->D1_FORNECE + SD1->D1_LOJA ) == cNFE+cNSE+cFor+cFoL )
				ni++
				If ni == 25
					ni := 0
					ProcRegua(25)
				EndIf
				DbSelectArea("SB1")
				DbSetOrder(1)
				DbSeek( xFilial("SB1")+SD1->D1_COD)
				IncProc(SB1->B1_GRUPO+" "+SB1->B1_CODITE)
				DbSelectArea("SB5")
				DbSetOrder(1)
				DbSeek( xFilial("SB5")+SB1->B1_COD)
				Aadd(aIte,{Iif(SD1->D1_QUANT>0,.t.,.f.),SB1->B1_GRUPO,SB1->B1_CODITE,SB1->B1_DESC,SD1->D1_QUANT,SB1->B1_CODBAR,FM_PRODSBZ(SB1->B1_COD,"SB5->B5_LOCALI2"),Transform(SB1->B1_QE,"@E 99,999")})
				DbSelectArea("SD1")
				DbSkip()
			EndDo
		EndIf
		If nCkPerg3 == 1 // Ordenar por Grupo + Item
			aSort(aIte,1,,{|x,y| x[2]+x[3] < y[2]+y[3] })
		ElseIf nCkPerg3 == 2 // Ordenar por Item
			aSort(aIte,1,,{|x,y| x[3] < y[3] })
		Else // Ordenar por Loca็ใo
			aSort(aIte,1,,{|x,y| x[7]+x[2]+x[3] < y[7]+y[2]+y[3] })
		Endif
	Else
		MsgAlert(STR0029,STR0028)
	EndIf
ElseIf cTipo == "IT"	//Por ITEM/ESTOQUE ALMOX.
	ni := 0
	cQuery := "SELECT SB1.B1_COD , SB1.B1_GRUPO , SB1.B1_CODITE , SB1.B1_DESC , SB1.B1_CODBAR , SB1.B1_QE FROM "+RetSqlName("SB1")+" SB1 WHERE SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
	If cGrI == cGrF
		cQuery += "SB1.B1_GRUPO='"+cGrI+"' AND "
	Else
		cQuery += "SB1.B1_GRUPO>='"+cGrI+"' AND SB1.B1_GRUPO<='"+cGrF+"' AND "
	EndIf
	cQuery += "SB1.B1_CODITE>='"+cCdI+"' AND SB1.B1_CODITE<='"+cCdF+"' AND SB1.B1_GRUPO<>'"+cGruVei+"' AND SB1.B1_GRUPO<>'"+cGruSrv+"' AND SB1.D_E_L_E_T_=' '"
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSB1, .F., .T. )
	ProcRegua( ( ( cQAlSB1 )->( RecCount() ) / 25 ))
	While !( cQAlSB1 )->( Eof() )
		ni++
		If ni == 25
			ni := 0
			IncProc(STR0030+Transform(nVetor,"@E 999,999")+STR0031)
		EndIf
		nQtd := 0
		DbSelectArea("SB5")
		DbSetOrder(1)
		DbSeek( xFilial("SB5")+( cQAlSB1 )->( B1_COD ))
		If !Empty(cAlm)
			cQuery := cQuerySB2+"SB2.B2_COD='"+( cQAlSB1 )->( B1_COD )+"' AND SB2.B2_LOCAL='"+cAlm+"' AND SB2.D_E_L_E_T_=' '"
			dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSB2, .F., .T. )
			If !( cQAlSB2 )->( Eof() )
				nQtd := ( cQAlSB2 )->( B2_QATU )
			EndIf
			( cQAlSB2 )->( dbCloseArea() )
			If nQtd > 0 .or. ( ( cGrI + cCdI ) == ( cGrF + cCdF ) )
				Aadd(aIte,{Iif(nQtd>0,.t.,.f.),( cQAlSB1 )->( B1_GRUPO ),( cQAlSB1 )->( B1_CODITE ),( cQAlSB1 )->( B1_DESC ),nQtd,( cQAlSB1 )->( B1_CODBAR ),FM_PRODSBZ(( cQAlSB1 )->( B1_COD ),"SB5->B5_LOCALI2"),Transform(( cQAlSB1 )->( B1_QE ),"@E 99,999")})
				nVetor++
			EndIf
		Else
			Aadd(aIte,{.t.,( cQAlSB1 )->( B1_GRUPO ),( cQAlSB1 )->( B1_CODITE ),( cQAlSB1 )->( B1_DESC ),1,( cQAlSB1 )->( B1_CODBAR ),FM_PRODSBZ(( cQAlSB1 )->( B1_COD ),"SB5->B5_LOCALI2"),Transform(( cQAlSB1 )->( B1_QE ),"@E 99,999")})
			nVetor++
		EndIf
		( cQAlSB1 )->( DbSkip() )
	EndDo
	( cQAlSB1 )->( DbCloseArea() )
	If !lZera
		cGrI := cGrF := space(4)
		cCdI := cCdF := space(27)
		cDcI := cDcF := space(100)
	EndIf
	If nCkPerg3 == 1 // Ordenar por Grupo + Item
		aSort(aIte,1,,{|x,y| x[2]+x[3] < y[2]+y[3] })
	ElseIf nCkPerg3 == 2 // Ordenar por Item
		aSort(aIte,1,,{|x,y| x[3] < y[3] })
	Else // Ordenar por Loca็ใo
		aSort(aIte,1,,{|x,y| x[7]+x[2]+x[3] < y[7]+y[2]+y[3] })
	Endif
ElseIf cTipo == "LO"	// Por Locacao SB5 / SBZ
	If lSBZ
		cQuery := "SELECT * FROM ( SELECT SB1.B1_COD , SB1.B1_GRUPO , SB1.B1_CODITE , SB1.B1_DESC , SB1.B1_CODBAR , SB1.B1_QE , "
		If GetNewPar("MV_MIL0096","S") == "N" // A loca็ใo da pe็a tamb้m deve ser considerada na tabela SB5 quando o parโmetro MV_ARQPROD estiver configurado com SBZ? ( S=Considera / N=Nใo Considera )
			cQuery += "SBZ.BZ_LOCALI2 LOCALIZACAO FROM "+RetSqlName("SB1")+" SB1 "
		Else
			cQuery += "CASE WHEN (SBZ.BZ_LOCALI2 IS NULL OR SBZ.BZ_LOCALI2 = '" + cTamBZ_LOCALI2 + "') THEN SB5.B5_LOCALI2 ELSE SBZ.BZ_LOCALI2 END LOCALIZACAO FROM "+RetSqlName("SB1")+" SB1 "
		EndIf
		cQuery += "LEFT JOIN "+RetSqlName("SB5")+" SB5 ON (SB5.B5_FILIAL='"+xFilial("SB5")+"' AND SB1.B1_COD=SB5.B5_COD AND SB5.D_E_L_E_T_=' ') "
		cQuery += "LEFT JOIN "+RetSqlName("SBZ")+" SBZ ON (SBZ.BZ_FILIAL='"+xFilial("SBZ")+"' AND SB1.B1_COD=SBZ.BZ_COD AND SBZ.D_E_L_E_T_=' ') "
		cQuery += "WHERE SB1.B1_FILIAL='"+xFilial("SB1")+"' AND SB1.B1_GRUPO<>'"+cGruVei+"' AND SB1.B1_GRUPO<>'"+cGruSrv+"' AND SB1.D_E_L_E_T_=' ' ) TEMP WHERE TEMP.LOCALIZACAO>='"+cLcI+"' AND TEMP.LOCALIZACAO<='"+cLcF+"'"
	Else
		cQuery := "SELECT SB1.B1_COD , SB1.B1_GRUPO , SB1.B1_CODITE , SB1.B1_DESC , SB1.B1_CODBAR , SB1.B1_QE , SB5.B5_LOCALI2 AS LOCALIZACAO FROM "+RetSqlName("SB1")+" SB1 , "+RetSqlName("SB5")+" SB5 "
		cQuery += "WHERE SB1.B1_FILIAL='"+xFilial("SB1")+"' AND SB5.B5_FILIAL='"+xFilial("SB5")+"' AND "
		cQuery += "SB1.B1_GRUPO<>'"+cGruVei+"' AND SB1.B1_GRUPO<>'"+cGruSrv+"' AND SB1.B1_COD=SB5.B5_COD AND SB5.B5_LOCALI2>='"+cLcI+"' AND SB5.B5_LOCALI2<='"+cLcF+"' AND "
		cQuery += "SB1.D_E_L_E_T_=' ' AND SB5.D_E_L_E_T_=' '"
	EndIf
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSB1, .F., .T. )
	ProcRegua( ( ( cQAlSB1 )->( RecCount() ) / 25 ))
	While !( cQAlSB1 )->( Eof() )
		ni++
		If ni == 25
			ni := 0
			IncProc(STR0030+Transform(nVetor,"@E 999,999")+STR0031)
		EndIf
		nQtd := 0
		If !Empty(cAlm)
			cQuery := cQuerySB2+"SB2.B2_COD='"+( cQAlSB1 )->( B1_COD )+"' AND SB2.B2_LOCAL='"+cAlm+"' AND SB2.D_E_L_E_T_=' '"
			dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSB2, .F., .T. )
			If !( cQAlSB2 )->( Eof() )
				nQtd := ( cQAlSB2 )->( B2_QATU )
			EndIf
			( cQAlSB2 )->( dbCloseArea() )
		Else
			nQtd := 1
		EndIf
		If nQtd > 0
			Aadd(aIte,{.t.,( cQAlSB1 )->( B1_GRUPO ),( cQAlSB1 )->( B1_CODITE ),( cQAlSB1 )->( B1_DESC ),nQtd,( cQAlSB1 )->( B1_CODBAR ),( cQAlSB1 )->( LOCALIZACAO ),Transform(( cQAlSB1 )->( B1_QE ),"@E 99,999")})
			nVetor++
		EndIf
		( cQAlSB1 )->( DbSkip() )
	Enddo
	( cQAlSB1 )->( DbCloseArea() )
	If nCkPerg3 == 1 // Ordenar por Grupo + Item
		aSort(aIte,1,,{|x,y| x[2]+x[3] < y[2]+y[3] })
	ElseIf nCkPerg3 == 2 // Ordenar por Item
		aSort(aIte,1,,{|x,y| x[3] < y[3] })
	Else // Ordenar por Loca็ใo
		aSort(aIte,1,,{|x,y| x[7]+x[2]+x[3] < y[7]+y[2]+y[3] })
	Endif
EndIf
nVetor := len(aIte)
If len(aIte) == 0
	Aadd(aIte,{.f.,"","","",0,"","",""})
EndIf
oLbIte:nAt := 1
oLbIte:SetArray(aIte)
oLbIte:bLine := { || {Iif(aIte[oLbIte:nAt,1],overde,overmelho),;
aIte[oLbIte:nAt,2] ,;
aIte[oLbIte:nAt,3] ,;
aIte[oLbIte:nAt,4] ,;
aIte[oLbIte:nAt,7] ,;
Iif(aIte[oLbIte:nAt,1],Transform(aIte[oLbIte:nAt,5],"@E 999,999,999")," ") }}
oLbIte:SetFocus()
oLbIte:Refresh()
nQtd := aIte[oLbIte:nAt,5]
oQtd:Refresh()
Return(.t.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FS_QTDETQบ Autor ณ Andre Luis Almeida บ Data ณ  25/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Quantidade de etiqueta					                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Uso      ณ Concessionarias                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_QTDETQ()
Local nFor := 0
Local nIniFor := 0
Local nQtdFor := 0

If nCkPerg4 == 1
	nIniFor := 1
	nQtdFor := len(aIte)
Else
	nIniFor := oLbIte:nAt
	nQtdFor := oLbIte:nAt
Endif

For nFor := nIniFor to nQtdFor
	If nQtd >= 0 .and. !Empty(aIte[nFor,3])
		If nQtd > 0
			aIte[nFor,1] := .t.
		Else
			aIte[nFor,1] := .f.
		EndIf
		aIte[nFor,5] := nQtd
	EndIf
Next

oLbIte:SetFocus()
oLbIte:Refresh()

Return .t.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FS_TIK   บ Autor ณ Andre Luis Almeida บ Data ณ  25/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Seleciona itens da etiqueta				                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Uso      ณ Concessionarias                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_TIK()
If !Empty(aIte[oLbIte:nAt,3])
	aIte[oLbIte:nAt,1]:=!aIte[oLbIte:nAt,1]
Else
	aIte[oLbIte:nAt,1]:=aIte[oLbIte:nAt,1]
EndIf
If aIte[oLbIte:nAt,5] == 0 .and. aIte[oLbIte:nAt,1]
	aIte[oLbIte:nAt,5] := nQtd := 1
	oQtd:Refresh()
	oLbIte:SetFocus()
	oLbIte:Refresh()
EndIf
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FS_IMPETQบ Autor ณ Andre Luis Almeida บ Data ณ  25/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Imprime etiqueta							                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Uso      ณ Concessionarias                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_IMPETQ()
Local cLinha := ""
Local cModelo := Iif(cTpEtq==STR0001,"1","2")
Local cNomMod := Iif(IsSrvUnix(),Lower(alltrim(GetMV("MV_MIL0078"))+"ECODBAR"+cModelo+".TXT"),alltrim(GetMV("MV_MIL0078"))+"ECODBAR"+cModelo+".TXT")
Local cEtqCdB := "CBAR"+__cUserId+".TXT"
Local cLPT := "LPT1"
Local ni := 0
Local nx := 0
Local nj := 0
Local nPos := 0
Local cOpc := ""
Local lLin := .f.
Local cL1 := cG1 := cC1 := cD1 := cB1 := cE1 := cF1 := ""
Local cL2 := cG2 := cC2 := cD2 := cB2 := cE2 := cF2 := ""
Local aSM0     := {}            
Local lOutputfile := .t.
aSM0 := FWArrFilAtu(cEmpAnt,cFilAnt) // Filial Origem (Filial logada)
If File(cNomMod)
	If MsgYesNo(STR0032,STR0028)
		If PERGUNTE(cPerg,.t.)
			Outputfile := FCREATE("SYSTEM\"+cEtqCdB,0)     
			FT_FUse( cNomMod )
			If cModelo == "1" // Etiqueta Modelo 1 (2 colunas)
				For ni := 1 to len(aIte)
					If aIte[ni,1] .and. aIte[ni,5] > 0
						For nx := 1 to aIte[ni,5]
							nj++
							If nj == 1
								cL1 := Alltrim(aIte[ni,7])
								cG1 := Alltrim(aIte[ni,2])
								cC1 := Alltrim(aIte[ni,3])
								cD1 := left(FS_ASPAS(Alltrim(aIte[ni,4])),26)
								cB1 := Alltrim(aIte[ni,6])
								cE1 := Alltrim(aIte[ni,8])
								cF1 := Alltrim(aSM0[2])
							Else
								cL2 := Alltrim(aIte[ni,7])
								cG2 := Alltrim(aIte[ni,2])
								cC2 := Alltrim(aIte[ni,3])
								cD2 := left(FS_ASPAS(Alltrim(aIte[ni,4])),26)
								cB2 := Alltrim(aIte[ni,6])
								cE2 := Alltrim(aIte[ni,8])
								cF2 := Alltrim(aSM0[2])
								FT_FGotop()
								While !FT_FEof()
									cLinha := FT_FReadLN()
									nPos := At("@@",cLinha)
									While nPos > 0
										cLinTot := cLinha
										cLinha  := substr(cLinTot,1,nPos-1)
										cOpc    := substr(cLinTot,nPos,4)
										If substr(cOpc,4,1) == "1"
											If cOpc == "@@L1" // Localiz 1
												cLinha += cL1
											ElseIf cOpc == "@@G1" // Grupo 1
												cLinha += cG1
											ElseIf cOpc == "@@C1" // Cod.Item 1
												cLinha += cC1
											ElseIf cOpc == "@@D1" // Descr.Item 1
												cLinha += cD1
											ElseIf cOpc == "@@B1" // Cod.Barras 1
												cLinha += cB1
											ElseIf cOpc == "@@E1" // Qtd.Embalagem 1
												cLinha += cE1
											ElseIf cOpc == "@@F1" // Filial 1
												cLinha += cF1
											EndIf
										Else // "2"
											If cOpc == "@@L2" // Localiz 2
												cLinha += cL2
											ElseIf cOpc == "@@G2" // Grupo 2
												cLinha += cG2
											ElseIf cOpc == "@@C2" // Cod.Item 2
												cLinha += cC2
											ElseIf cOpc == "@@D2" // Descr.Item 2
												cLinha += cD2
											ElseIf cOpc == "@@B2" // Cod.Barras 2
												cLinha += cB2
											ElseIf cOpc == "@@E2" // Qtd.Embalagem 2
												cLinha += cE2
											ElseIf cOpc == "@@F2" // Filial 2
												cLinha += cF2
											EndIf
										EndIf
										cLinha += substr(cLinTot,nPos+4)
										nPos := At("@@",cLinha)
									EndDo
									If !Empty(cLinha)
										fwrite(outputfile,(If(left(cLinha,1)$"QqrSDZJORNABPG",CHR(13)+CHR(10),""))+cLinha)
									Else
										If lLin
											fwrite(outputfile,CHR(13)+CHR(10))
										EndIf
										lLin := .t.
									EndIf
									FT_FSkip()
								End
								nj := 0
								cL1 := cG1 := cC1 := cD1 := cB1 := cE1 := cF1 := ""
								cL2 := cG2 := cC2 := cD2 := cB2 := cE2 := cF2 := ""
							EndIf
						Next
					EndIf
				Next
				If !Empty(Alltrim(cG1+cC1))
					FT_FGotop()
					While !FT_FEof()
						cLinha := FT_FReadLN()
						nPos := At("@@",cLinha)
						While nPos > 0
							cLinTot := cLinha
							cLinha  := substr(cLinTot,1,nPos-1)
							cOpc    := substr(cLinTot,nPos,4)
							If cOpc == "@@L1" // Localiz 1
								cLinha += cL1
							ElseIf cOpc == "@@G1" // Grupo 1
								cLinha += cG1
							ElseIf cOpc == "@@C1" // Cod.Item 1
								cLinha += cC1
							ElseIf cOpc == "@@D1" // Descr.Item 1
								cLinha += cD1
							ElseIf cOpc == "@@B1" // Cod.Barras 1
								cLinha += cB1
							ElseIf cOpc == "@@E1" // Qtd.Embalagem 1
								cLinha += cE1
							ElseIf cOpc == "@@F1" // Filial 1
								cLinha += cF1
							EndIf
							cLinha += substr(cLinTot,nPos+4)
							nPos := At("@@",cLinha)
						EndDo
						If !Empty(cLinha)
							fwrite(outputfile,(If(left(cLinha,1)$"QqrSDZJORNABPG",CHR(13)+CHR(10),""))+cLinha)
						Else
							If lLin
								fwrite(outputfile,CHR(13)+CHR(10))
							EndIf
							lLin := .t.
						EndIf
						FT_FSkip()
					End
				EndIf
			ElseIf cModelo == "2" // Etiqueta Modelo 2 (1 coluna)
				For ni := 1 to len(aIte)
					If aIte[ni,1] .and. aIte[ni,5] > 0
						FT_FGotop()
						While !FT_FEof()
							cLinha := FT_FReadLN()
							nPos := At("@@",cLinha)
							While nPos > 0
								cLinTot := cLinha
								cLinha  := substr(cLinTot,1,nPos-1)
								cOpc    := substr(cLinTot,nPos,3)
								If cOpc == "@@L" // Localiz
									cLinha += Alltrim(aIte[ni,7])
								ElseIf cOpc == "@@G" // Grupo
									cLinha += Alltrim(aIte[ni,2])
								ElseIf cOpc == "@@C" // Cod.Item
									cLinha += Alltrim(aIte[ni,3])
								ElseIf cOpc == "@@D" // Descr.Item
									cLinha += left(FS_ASPAS(Alltrim(aIte[ni,4])),19)
								ElseIf cOpc == "@@B" // Cod.Barras
									cLinha += Alltrim(aIte[ni,6])
								ElseIf cOpc == "@@E" // Qtd.Embalagem
									cLinha += Alltrim(aIte[ni,8])
								ElseIf cOpc == "@@F" // Filial
									cLinha += Alltrim(aSM0[2])
								EndIf
								cLinha += substr(cLinTot,nPos+3)
								nPos := At("@@",cLinha)
							EndDo
							If !Empty(cLinha)
								nPos := At("P1",cLinha)
								If nPos > 0
									If nPos > 1
										cLinha := substr(cLinha,1,nPos-1)+"P"+Alltrim(str(int(aIte[ni,5]),5))
									Else
										cLinha := "P"+Alltrim(str(int(aIte[ni,5]),5))
									EndIf
								EndIf
								fwrite(outputfile,(If(left(cLinha,1)$"QqrSDZJORNABPG",CHR(13)+CHR(10),""))+cLinha)
							Else
								If lLin
									fwrite(outputfile,CHR(13)+CHR(10))
								EndIf
								lLin := .t.
							EndIf
							FT_FSkip()
						End
					EndIf
				Next
			EndIf
			fwrite(outputfile,CHR(13)+CHR(10))
			FT_FUse()
			FClose(outputfile)
			cLPT := "LPT" + strzero(MV_PAR01,1) 
			Copy File &(cEtqCdB) to &(cLPT)
			MsgInfo(STR0033,STR0028)
		EndIf
	EndIf
Else
	MsgAlert(cNomMod+STR0034,STR0028)
EndIf
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณFS_ASPAS  บ Autor ณ Andre Luis Almeida บ Data ณ  25/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Retira Aspas								                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Uso      ณ Concessionarias                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_ASPAS(cStr)
Local nPos := 0
Local cStrT := ""
nPos := At('"',cStr)
While nPos > 0
	cStrT := cStr
	cStr := substr(cStrT,1,nPos-1)+"''"
	cStr += substr(cStrT,nPos+1)
	nPos := At('"',cStr)
EndDo
Return(cStr)
