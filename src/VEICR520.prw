/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "veicr520.ch"
#Include "fileio.ch"
#Include "protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ VEICR520 ³ Autor ³  Fabio                ³ Data ³ 05/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Clientes por Regiao                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ (Veiculos)                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR520()
Private aReturn  := { OemToAnsi(STR0002), 1,OemToAnsi(STR0003), 2, 2, 2,,1 } // Clientes p/ Regiao / Regiao

cAlias := "VC1"
cNomRel:= "VEIR520"
cPerg := "VCR520"
cTitulo:= STR0002 // Clientes p/ Regiao
cDesc1 := STR0002 // Clientes p/ Regiao
cDesc2 := cDesc3 := ""
lHabil := .f.
wnRel:=cTamanho:= "P"

cNomRel := SetPrint(cAlias,cNomRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lHabil,,,cTamanho)

Pergunte(cPerg,.f.)

If nlastkey == 27
	Return
EndIf

SetDefault(aReturn,cAlias)

RptStatus({|lEnd| FS_IMPR520(@lEnd,wnRel,"VC1")},cTitulo)

DbSelectArea("SA1")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_IMPR520³ Autor ³  Fabio                ³ Data ³ 05/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao dos Clientes por Regiao (CIDADE)                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_IMPR520()
Local cQuery    := ""
Local cSQLAlias := "SQLALIAS"
Local cFilVAM   := xFilial("VAM")
Local cFilSA1   := xFilial("SA1")

Set Printer to &cNomRel
Set Printer On
Set device to Printer

cbTxt    := Space(10)
cbCont   := 0
cString  := "VC1"
Li       := 80
m_Pag    := 1
nLin := 1
tamanho:="P"
nCaracter:=15

DbSelectArea("VCB")
DbSetOrder(1)
DbSeek(xFilial("VCB")+Alltrim(MV_PAR01))
SetRegua(RecCount())
While !Eof() .and. VCB->VCB_FILIAL == xFilial("VCB") .and. ( Empty(MV_PAR01) .or. VCB->VCB_CODREG == MV_PAR01 )
	cTitulo:= STR0002 // Clientes p/ Regiao
	cabec1 := STR0003+": "+VCB->VCB_CODREG+" - "+VCB->VCB_DESREG // Regiao
	cabec2 := left(STR0005+space(20),(TamSx3("A1_COD")[1]+TamSx3("A1_LOJA")[1]))+"  "+STR0006 // Cliente / Nome
	cQuery := "SELECT SA1.A1_COD , SA1.A1_LOJA , SA1.A1_NOME FROM "+RetSQLName("VAM")+" VAM "
	cQuery += "JOIN "+RetSQLName("SA1")+" SA1 ON ( SA1.A1_FILIAL='"+cFilSA1+"' AND SA1.A1_IBGE=VAM.VAM_IBGE AND SA1.D_E_L_E_T_=' ' ) "
	cQuery += "WHERE VAM.VAM_FILIAL='"+cFilVAM+"' AND VAM.VAM_REGIAO='"+VCB->VCB_CODREG+"' AND VAM.D_E_L_E_T_=' ' ORDER BY SA1.A1_NOME , SA1.A1_COD , SA1.A1_LOJA "
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cSQLAlias, .F., .T. )
	If !(cSQLAlias)->(Eof())
		nLin := cabec(ctitulo,cabec1,cabec2,cNomRel,tamanho,nCaracter) + 1
		While !(cSQLAlias)->(Eof())
			If nLin > 55
				nLin := cabec(ctitulo,cabec1,cabec2,cNomRel,tamanho,nCaracter) + 1
			EndIf
			@ nLin++,000 PSAY (cSQLAlias)->( A1_COD )+"-"+(cSQLAlias)->( A1_LOJA )+" "+(cSQLAlias)->( A1_NOME )
			(cSQLAlias)->(dbSkip())
		EndDo
	Else
		If !Empty(MV_PAR01)
			nLin := cabec(ctitulo,cabec1,cabec2,cNomRel,tamanho,nCaracter) + 1
		EndIf
	EndIf
	(cSQLAlias)->(dbCloseArea())
	DbSelectArea("VCB")
	DbSkip()
	nLin:=1
EndDo
Set Printer to
Set device to Screen
MS_FLUSH()
OurSpool(cNomRel)
Return