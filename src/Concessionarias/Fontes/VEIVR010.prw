/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Veivr010.ch"
#include "Protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ VEIVR010 ³ Autor ³  Manoel               ³ Data ³ 08/08/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Copia da Nota Fiscal de Saida de Veiculos                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEIVR010

Private aRotina := MenuDef()
Private cCadastro := OemToAnsi(STR0003) //"Copia da Nota Fiscal Saida"
Inclui := .F.
nReg   := 0

DbSelectArea("VV0")
cIndex := CriaTrab(nil,.f.)

cCondicao :='VV0->VV0_OPEMOV # "1" .and. !empty(VV0->VV0_NUMPED) .and. !empty(VV0->VV0_NUMNFI) .and. VV0->VV0_SITNFI == "1" .and. VV0->VV0_TIPFAT # "2"'  // So Propostas e Faturamentos

IndRegua("VV0",cIndex,"VV0_FILIAL+DtoS(VV0_DATMOV)",,cCondicao,OemToAnsi(STR0004))  // "Selecionando Registros..." //"Selecionando registros..."

DbSelectArea("VV0")
nIndex := RetIndex("VV0")
#IFNDEF TOP
   dbSetIndex(cIndex+ordBagExt())
#ENDIF
dbSetOrder(nIndex+1)

mBrowse( 6, 1,22,75,"VV0")

dbSelectArea("VV0")
Set Filter to
RetIndex("VV0")
DbsetOrder(1)
#IFNDEF TOP
        If File(cIndex+OrdBagExt())
                fErase(cIndex+OrdBagExt())
        Endif
#ENDIF

Return


User Function VR010COP()
////////////////////
Local bCampo4           := { |nCPO| Field(nCPO) }
Local nCntFor,_ni		:= 0
dbSelectArea("SX3")
dbSeek("VV0")
While !Eof().and.(x3_arquivo=="VV0")
          wVar := "M->"+x3_campo
          IF Alltrim(x3_campo) # "VV0_NUMTRA"
          &wVar:= CriaVar(x3_campo)
          Endif
        dbSkip()
EndDo

if !Inclui
    RegToMemory("VV0",.f.)
    DbSelectArea("VV0")
    For nCntFor := 1 TO FCount()
        M->&(EVAL(bCampo4,nCntFor)) := FieldGet(nCntFor)
    Next
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria aHeader e aCols da GetDados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nUsado:=0
dbSelectArea("SX3")
dbSeek("VVA")
aHeader:={}
While !Eof().And.(x3_arquivo=="VVA")
           If X3USO(x3_usado).And.cNivel>=x3_nivel .And. !Alltrim(x3_campo) $ [VVA_TRACPA/VVA_NUMTRA/VVA_CODORI/VVA_SIMVDA/VVA_CODIND/VVA_COMPGC]
                        nUsado:=nUsado+1
                        Aadd(aHeader,{ TRIM(X3Titulo()), x3_campo, x3_picture,;
                        x3_tamanho, x3_decimal,x3_valid,;
                        x3_usado, x3_tipo, x3_arquivo, x3_context } )
                   wVar := "M->"+x3_campo
                   &wVar:= CriaVar(x3_campo)
                Endif
        dbSkip()
End

nOpcE:=2
nOpcG:=2


Acols:={}
dbSelectArea("VVA")
dbSetOrder(1)
dbSeek(xFilial()+M->VV0_NUMTRA)
While !eof() .and. VVA->VVA_FILIAL == xFilial("VVA") .and. M->VV0_NUMTRA == VVA_NUMTRA
                AADD(aCols,Array(nUsado+1))
                For _ni:=1 to nUsado
            aCols[Len(aCols),_ni]:=If(aHeader[_ni,10] # "V",FieldGet(FieldPos(aHeader[_ni,2])),CriaVar(aHeader[_ni,2]))
                Next
                aCols[Len(aCols),nUsado+1]:=.F.
                dbSkip()
EndDO

cTitulo    :=OemToAnsi(STR0003) //"Copia da Nota Fiscal Saida"
cAliasEnch :="VV0"
cLinOk     :="FG_OBRIGAT"
cTudoOk     :="AllwaysTrue()"
cFieldOk   :="FG_MEMVAR()"

nOpca := 0
lVirtual := .f. //Iif(lVirtual==Nil,.F.,lVirtual)
nLinhas:= 99 //Iif(nLinhas==Nil,99,nLinhas)

aMyEncho     := {}
aAltEnchoice := {}
Private Altera:=.t.,Inclui:=.t.,lRefresh:=.t.,aTELA:=Array(0,0),aGets:=Array(0),;
nPosAnt:=9999,      nColAnt:=9999
Private cSavScrVT,cSavScrVP,cSavScrHT,cSavScrHP,CurLen,nPosAtu:=0
cAlias2     := "VVA"

DEFINE MSDIALOG oDlg TITLE cTitulo From 4,10 to 36,90   of oMainWnd
EnChoice("VV0",nReg,nOpcE,,,,,{15,1,194,315},,2,,,,,,lVirtual)
oGetDados := MsGetDados():New(197,1,241,315,nOpcG,cLinOk,cTudoOk,"",.T.,,,,nLinhas,cFieldOk)
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||nOpca:=1,oDlg:End()},{||oDlg:End()})

if nOpca == 1
  _lRet := .t.
Else
  _lRet := .f.
Endif

DbSelectArea("VV0")
DbSetOrder(1)
if _lRet
        If ExistBlock("NFSAIVEI")
               ExecBlock("NFSAIVEI",.f.,.f.,{VV0->VV0_NUMNFI,VV0->VV0_SERNFI,"SN"}) // SN - NF Saida (Normal)
               DbSelectArea("VV0")
					cCondicao :='VV0->VV0_OPEMOV == "0" .and. !empty(VV0->VV0_NUMPED) .and. !empty(VV0->VV0_NUMNFI) .and. VV0->VV0_SITNFI == "1" .and. VV0->VV0_TIPFAT # "2"'  // So Propostas e Faturamentos
					
                                        IndRegua("VV0",cIndex,"VV0_FILIAL+DtoS(VV0_DATMOV)",,cCondicao,OemToAnsi(STR0004))  // "Selecionando Registros..." //"Selecionando registros..."
					
					DbSelectArea("VV0")
					nIndex := RetIndex("VV0")
					#IFNDEF TOP
					   dbSetIndex(cIndex+ordBagExt())
					#ENDIF
					dbSetOrder(nIndex+1)

        Endif
Endif

Return

Static Function MenuDef()
Local aRotina := {{OemToAnsi(STR0001),  "AxPesqui",0,1},; //"Pesquisar"
                    {OemToAnsi(STR0002), "VR010COP",0,2}} //"Emitir Copia"
Return aRotina
