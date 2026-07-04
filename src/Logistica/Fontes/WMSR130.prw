/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#include "RWMAKE.CH"
#INCLUDE "WMSR130.CH"
#INCLUDE "APVT100.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE WMSR13001 "WMSR13001"
#DEFINE WMSR13002 "WMSR13002"
//-----------------------------------------------------------------------------
/*/{Protheus.doc} WMSR130ETI
Efetiva a impressão da etiqueta
@author Amanda Rosa Vieira
@since 27/06/2017
@version 1.0
/*/
//-----------------------------------------------------------------------------
User Function WMSR130ETI(aItens)
Local lRet    := .T.
Local nCont   := 0
Local oDlgLI  := Nil
Local oGetLI  := Nil
Local nOpcLI  := 0
Local cLocImp := Space(TamSX3("CB5_CODIGO")[01])

	// Pergunta qual o volume terá a etiqueta impressa
	DbSelectArea("D0Y")
	If Empty(SuperGetMV("MV_WMSLOCI",.F.,""))
		DEFINE MSDIALOG oDlgLI TITLE STR0004 From 50,50 to 120,280 PIXEL // Informe o local de impressão
		@ 06,05 SAY STR0005 SIZE 50,8 OF oDlgLI PIXEL // Local de Impressao:
		@ 05,60 MSGET oGetLI VAR cLocImp F3 "CB5" SIZE 50,06 WHEN .T. PICTURE "@!" OF oDlgLI PIXEL
		DEFINE SBUTTON FROM 21,083 TYPE 1 ACTION (nOpcLI := 1,oDlgLI:End()) ENABLE Of oDlgLI
		ACTIVATE DIALOG oDlgLI CENTERED		
		If nOpcLI == 0
			Return .F.	
		EndIf
		If !CB5SetImp(cLocImp,IsTelNet())
			WmsMessage(STR0001,WMSR13001,1) //Local de impressão inválido.
			Return .F.
		EndIf
	ElseIf !CB5SetImp(CBRLocImp("MV_WMSLOCI"),IsTelNet())
		WmsMessage(STR0001,WMSR13002,1) //Local de impressão inválido.
		Return .F.
	EndIf
	For nCont := 1 To Len(aItens)
		MSCBINFOETI(STR0002,"50x30") //Etiqueta de Unitizador
	
		cIdUnitiz:= Alltrim(aItens[nCont,1])
		
		MSCBBEGIN(1,6,70)
		
		MSCBSAY(007,005,STR0003,"N","F","1,2", , , ,.T.)// Unitizador
		MSCBSAYBAR(007,011,ALLTRIM(cIdUnitiz),'N','MB07',9,.F.,.F.,,'B',2.3,2,) // Opcao B -> Utilizado no code128/ para aceitar letras e numeros.
		MSCBSAY(007,021,cIdUnitiz,"N","C","1,2", , , ,.T.)
	
		MSCBEND()
	Next nCont
	
	MSCBCLOSEPRINTER()
	
	// Atualiza campo D0Y_IMPRES (Flag de Impressao)
	D0Y->(DbSetOrder(1))
	For nCont := 1 to len(aItens)
		cIdUnitiz := aItens[nCont,1]
		If D0Y->(DbSeek(xFilial("D0Y")+cIdUnitiz)) .And. D0Y->D0Y_IMPRES == '2'
			RecLock("D0Y",.F.)
			D0Y->D0Y_IMPRES := '1'
			D0Y->(MsUnlock())
			D0Y->(dbSkip())
		EndIf
	Next
Return lRet