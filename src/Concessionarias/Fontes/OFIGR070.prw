/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Protheus.ch"
#include "Ofigr070.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ OFIGR070 ³ Autor ³ Emilton Miranda       ³ Data ³ 11/04/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relacao de Pecas a Devolver para a Montadora               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIGR070

Local cAlias :="VIS"
Local cDesc3 := ""

Private nLin := 1
Private aPag := 1

//Variaveis padrao de relatorio
Private cDesc1     := OemToAnsi(STR0001)
Private cCabec1    := OemToAnsi(STR0005)
Private cDesc2     := ""
Private cCabec2    := ""
Private aReturn   := { "", 1,"", 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private cTamanho   := "M"           // P/M/G
Private Limite     := 132         // 80/132/220
Private cTitulo    := OemToAnsi(STR0001)
Private cNomProg   := "OFIGR070"
Private cNomeRel   := "OFIGR070"
Private nLastKey   := 0
Private nCaracter  := 15
Private cPerg      := "OFI070"

set printer to &cNomeRel
set printer on
set device to printer

cNomeRel := SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,.t.,cTamanho)

if nlastkey == 27 
   return
Endif

PERGUNTE(cPerg,.f.) 

SetDefault(aReturn,cAlias)                                                 

DbSelectArea("SB5")
cIndex := CriaTrab(nil,.f.)
cChave  := "B5_FILIAL + B5_CODFAB"  //"VGA_FILIAL+VGA_CODMAR+VGA_NUMOSV+VGA_ESPGAR"
IndRegua("SB5",cIndex,cChave,,,"") //"Aguarde, filtrando registros..."
nIndex := RetIndex("SB5")
#IFNDEF TOP
	dbSetIndex(cIndex+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)


RptStatus({|lEnd| ImpDevPec(@lEnd,cNomeRel,cAlias)},cTitulo)

RetIndex("SB5")
dbSelectArea("SB5")
Set Filter To
dbSetOrder(1)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³IMPDEVPEC ³ Autor ³ Emilton Miranda       ³ Data ³ 11/04/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Imprime a Relacao de Pecas a Devolver para a Montadora     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpDevPec(lEnd,wNRel,cAlias)

Local ix1    := 0
Local _QTDIT := 0
Local _CODIT := Space(27)
Local _CODEN := ""
Local _DTDEV := cTod("  /  /  ")

M_PAG    := 1     
nLin     := 80
aPag     := 1
clin     := 1

cTitulo    := OemToAnsi(STR0001)

DbSelectArea("VIS")
 
nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg,cTamanho,nCaracter)+1
nLin++

DbSelectArea("VE4")
DbSetOrder(1)
DbSeek(xFilial("VE4")+MV_PAR05)

DbSelectArea("VIS")
DbSetOrder(1)
DbGoTop()
//DbSeek(xFilial("VIS")+alltrim(mv_par01),.t.)  && Nao saber o indice criado pelo Rogerio

SetRegua(RecCount())

while !Eof() .and. xFilial("VIS") == VIS->VIS_FILIAL

   IncRegua()
   If VIS->VIS_DATLAN < MV_PAR01 .or. VIS->VIS_DATLAN > MV_PAR02
	   DbSelectArea("VIS")
      dbSkip()
      Loop
   EndIf

   If !Empty(MV_PAR04)
      If MV_PAR04 != VIS->VIS_NUMOSV
		   DbSelectArea("VIS")
         dbSkip()
         Loop
      EndIf
   EndIf

   If nLin >= 60
      nLin := 1
      nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg, cTamanho,nCaracter)+1   
   EndiF 

   For ix1 := 1 to 5

       _QTDIT := "VIS->VIS_QTDIT"+StrZero(ix1,1)
       _CODIT := "VIS->VIS_CODIT"+StrZero(ix1,1)
       _CODEN := "VIS->VIS_CODEN"+StrZero(ix1,1)
       _DTDEV := "VIS->VIS_DTDEV"+StrZero(ix1,1)

      If &_QTDIT == 0
         Loop
      EndIf

      If MV_PAR03 != 4
         If MV_PAR03 != VAL(&(_CODEN))
            Loop
         EndIf
      EndIf

      @ ++nLin, 000       pSay VIS->VIS_LANCTO
      @ nLin  , pCol()+05 pSay VIS->VIS_DATLAN
      @ nLin  , pCol()+01 pSay VIS->VIS_NUMOSV
      @ nLin  , pCol()+01 pSay &(_CODIT)
  
		SB5->(DbSeek(XFILIAL("SB5") + &(_CODIT)))
      /*
      DbSelectArea("SB1")
      DbSetOrder(7)
      If DbSeek(xFilial("SB1")+VE4->VE4_GRUITE+&(_CODIT))
      */
      DbSelectArea("SB1")
      DbSetOrder(1)
      If DbSeek(xFilial("SB1")+SB5->B5_COD)
         @ nLin  , pCol()+08 pSay Left(SB1->B1_DESC,30)
      Else
         @ nLin  , pCol()+08 pSay OemToAnsi(STR0006)
      EndIf
      @ nLin  , pCol()+01 pSay Transform(&(_QTDIT),"@ez 999999")
      @ nLin  , pCol()+01 pSay &(_DTDEV)

      Do Case
         Case &(_CODEN) == "1"
              @ nLin  , pCol()+01 pSay OemToAnsi(STR0002)
         Case &(_CODEN) == "2"
              @ nLin  , pCol()+01 pSay OemToAnsi(STR0003)
         Case &(_CODEN) == "3"
              @ nLin  , pCol()+01 pSay OemToAnsi(STR0004)
      EndCase

   Next
   
   DbSelectArea("VIS")
   DbSkip()

Enddo    
 
Eject

Set Printer to
Set device to Screen

MS_FLUSH()
If aReturn[5] == 1
   OurSpool(cNomeRel)
EndIf

Return     
