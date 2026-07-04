/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#include "RWMAKE.CH"
#INCLUDE "WMSR410A.CH"
#INCLUDE "APVT100.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE WMSR41001 "WMSR41001"

//-----------------------------------------------------------
/*/{Protheus.doc} U_WMSR410A (cVolume,lMontagem,cLocImp)
Impressao de Etiquetas de Embalagem do processo de Montagem de Volume

@author  Squad WMS
@since 05/17/2011
@version 2.0
@param cVolume, character, (Volume a ser impresso)
@param lMontagem, lógico, (Indica se o processo de impressão está sendo chamado após a montagem de volume)
@param cLocImp, character, (Local de impressão)
/*/
//-----------------------------------------------------------
User Function WMSR410A(cVolume,lMontagem,cLocImp)
Local aDCSArea  := DCS->(GetArea())
Local aDCTArea  := DCT->(GetArea())
Local aDCUArea  := DCU->(GetArea())
Local aDCVArea  := DCV->(GetArea())
Local lRet      := .T.
Local cAliasDCV := ""
Local aItens    := {}
Local oDlgLI    := Nil
Local oGetLI    := Nil
Local nOpcLI    := 0

Default lMontagem	:= .T.
Default cVolume	:= Space(TamSx3("DCU_CODVOL")[1])

	// Se a impressão não for chamada após a montagem do Volume será necessário solicitar qual volume será impresso
	If !lMontagem
		If IsTelNet()
			VtClear()
			@ 0,0 VtSay STR0001 // Informe o Volume:
			@ 1,0 VtGet cVolume Picture "@!" Valid VldVolume(cVolume)
			VtRead
			If VtLastkey() == 27
				Return .F.
			EndIf
		Else
			DEFINE MSDIALOG oDlgLI TITLE STR0001 From 50,50 to 120,280 PIXEL //Informe o Volume:
			@ 06,05 SAY STR0002+":" SIZE 50,8 OF oDlgLI PIXEL // Volume:
			@ 05,60 MSGET oGetLI VAR cVolume VALID VldVolume(@cVolume) SIZE 50,06 WHEN .T. PICTURE "@!" OF oDlgLI PIXEL
			DEFINE SBUTTON FROM 21,083 TYPE 1 ACTION (nOpcLI := 1,oDlgLI:End()) ENABLE Of oDlgLI
			ACTIVATE DIALOG oDlgLI CENTERED
			If !(nOpcLI == 1) .Or. Empty(cVolume)
				lRet := .F.
			EndIf
		EndIf
	EndIf

	If lRet
		cQuery := "SELECT DCV.DCV_CODPRO,"
		cQuery +=       " DCV.DCV_LOTE,"
		cQuery +=       " DCV.DCV_SUBLOT,"
		cQuery +=       " DCV.DCV_QUANT,"
		cQuery +=       " DCV.DCV_CARGA,"
		cQuery +=       " DCV.DCV_PEDIDO,"
		cQuery +=       " SC9.C9_CLIENTE,"
		cQuery +=       " SC9.C9_LOJA"
		cQuery +=  " FROM "+RetSqlName("DCV")+" DCV"
		cQuery += " INNER JOIN "+RetSqlName("SC9")+" SC9"
		cQuery +=    " ON SC9.C9_FILIAL = '"+xFilial("SC9")+"'"
		cQuery +=   " AND SC9.C9_PEDIDO = DCV.DCV_PEDIDO"
		cQuery +=   " AND SC9.C9_ITEM = DCV.DCV_ITEM"
		cQuery +=   " AND SC9.C9_SEQUEN = DCV.DCV_SEQUEN"
		cQuery +=   " AND SC9.C9_PRODUTO = DCV.DCV_PRDORI"
		cQuery +=   " AND SC9.D_E_L_E_T_ = ' '"
		cQuery += " WHERE DCV_FILIAL = '"+xFilial("DCV")+"'"
		cQuery +=   " AND DCV_CODVOL = '"+cVolume+"'"
		cQuery +=   " AND DCV.D_E_L_E_T_ = ' '"
		cQuery := ChangeQuery(cQuery)
		cAliasDCV := GetNextAlias()
		dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAliasDCV,.F.,.T.)
		Do While (cAliasDCV)->(!Eof())
			(cAliasDCV)->(aAdd(aItens,{DCV_CODPRO,DCV_QUANT,cVolume,DCV_LOTE,DCV_SUBLOT,DCV_CARGA,DCV_PEDIDO,C9_CLIENTE,C9_LOJA}))
			(cAliasDCV)->(dbSkip())
		EndDo
		(cAliasDCV)->(dbCloseArea())
		
		U_WMSR410ETI(aItens,lMontagem,cLocImp)
	EndIf
	RestArea(aDCVArea)
	RestArea(aDCUArea)
	RestArea(aDCTArea)
	RestArea(aDCSArea)

Return Nil

Static Function VldVolume(cVolume)
Local lRet := .T.
	DCU->(DbSetOrder(1))
	If !DCU->(DbSeek(xFilial('DCU')+cVolume))
		WmsMessage(WMSR41001,STR0016) // Volume Inexistente
		cVolume := ""
		lRet := .F.
	EndIf
Return lRet

//-------------------------------------------------------
// WMSR410ETI
// Efetiva a impressão da etiqueta
//-------------------------------------------------------
User Function WMSR410ETI(aItens,lMontagem,cLocImp)
Local nQuebr  := If(Len(aItens) < 11,Len(aItens),11)
Local nVol    := 1
Local nVolAtu := 1
Local nItens  := 1
Local nTotVol := 0
Local nlinha  := 0
Local cVolAtu := ""
Local cDesc   := ""
Local oDlgLI  := Nil
Local oGetLI  := Nil
Local nOpcLI  := 0
Local lRasLot := (AllTrim(SuperGetMV("MV_RASTRO",.F.,"N")) == "S") .And. SuperGetMV("MV_WMSLOTE",.F.,.F.)
Local cDocAnt := ""
Local cTimeIni := 0 //Var para controle de envio de dados para impressora
Local cTimeFim := 0 
Local cDifTime := 0 
Local nExec    := 0 

Default cLocImp := Space(TamSX3("CB5_CODIGO")[1])
Default lMontagem	:= .F.
	For nVol := 1 to len(aItens)
		If aItens[nVol,3] <> cVolAtu
			nTotVol++
			cVolAtu:= aItens[nVol,3]
		Endif
	Next
	dbSelectArea("DCU")
	// Pergunta qual o volume terá a etiqueta impressa
	If Empty(cLocImp)
		If !lMontagem
			If IsTelNet()
				If Empty(SuperGetMV("MV_WMSLOCI",.F.,"")) // Solicita o Local de Impressão
					VtClear()
					@ 0,00 VTSAY STR0003 // Informe o Local
					@ 1,00 VTSAY STR0004+":"// de Impressao
					@ 2,00 VTGET cLocImp PICTURE '@!' F3 "CB5"
					VtRead
					If VtLastkey() == 27
						Return ( .F. )
					EndIf
					If !CB5SetImp(cLocImp,IsTelNet())
						VtAlert(STR0005,STR0006,.t.,3000,2) // Local de impressao invalido! // Aviso
						Return .F.
					EndIf
				ElseIf !CB5SetImp(CBRLocImp("MV_WMSLOCI"),IsTelNet())
					VtAlert(STR0005,STR0006,.t.,3000,2) // Local de impressao invalido! // Aviso
					Return .F.
				EndIf
			Else
				If Empty(SuperGetMV("MV_WMSLOCI",.F.,""))

					DEFINE MSDIALOG oDlgLI TITLE STR0003 + " " + STR0004 From 50,50 to 120,280 PIXEL // Informe o Local // de Impressão

						@ 06,05 SAY STR0007 SIZE 50,8 OF oDlgLI PIXEL // Local de Impressao:
						@ 05,60 MSGET oGetLI VAR cLocImp F3 "CB5" SIZE 50,06 WHEN .T. PICTURE "@!" OF oDlgLI PIXEL
						DEFINE SBUTTON FROM 21,083 TYPE 1 ACTION (nOpcLI := 1,oDlgLI:End()) ENABLE Of oDlgLI

					ACTIVATE DIALOG oDlgLI CENTERED

					If !CB5SetImp(cLocImp,IsTelNet())
						Alert(STR0005,STR0006,.t.,3000,2)
						Return .F.
					EndIf
				ElseIf !CB5SetImp(CBRLocImp("MV_WMSLOCI"),IsTelNet())
					Alert(STR0005,STR0006,.t.,3000,2)
					Return .F.
				EndIf
			EndIf
		EndIf
	EndIf
	If ExistBlock("WMSA391E")
		ExecBlock("WMSA391E",.F.,.F.,{aItens, nTotVol})
	Else
		 While nItens <= Len(aItens) // Trata todos os Itens do Volume

			cTimeIni := timecounter()

			// Dados do Cliente
			SA1->(dbSetOrder(1))
			SA1->(dbSeek(xFilial("SA1")+aItens[nItens][8]+aItens[nItens][9]))
			cNomeCli := AllTrim(SA1->A1_NOME)
			cEnderec := AllTrim(SA1->A1_END)
			cCidade  := AllTrim(SA1->A1_MUN)
			cUf      := AllTrim(SA1->A1_EST)

			MSCBINFOETI(STR0012) // Etiqueta de Volume.

			cVolAtu := Alltrim(aItens[nItens,3])
			MSCBBEGIN(1,6,70)
			MSCBLineH(00,16,150,3) // Primeira Linha H
			MSCBLineH(59,26,150,3) // Segunda Linha H

			//MSCBLineV - Imprime uma linha vertical (nX1,nY1,nY2,nEspessura,cCor)
			MSCBLineV(67,00,16,3) // Linha um V
			MSCBLineV(50,16,40,3) // Linha dois V
			MSCBLineV(59,16,40,3) // Linha tres V

			//BSay - Imprime uma String (nX,nY,cTexto,cRotação,cFont,cTam,lReverso,lSerial,cIncr,lZerosL,lNoAlltrim)
			MSCBSAY(003,005, NoAcentoCte(SUBSTR(cNomeCli,1,42)),"N","C","1,2",,,,.T.)
			MSCBSAY(003,009, NoAcentoCte(SUBSTR(cEnderec,1,42)),"N","C","1,2",,,,.T.)
			MSCBSAY(003,013, SUBSTR(cCidade +' - '+ cUf ,1,42),"N","C","1,2",,,,.T.)

			MSCBSAY(003,017, STR0017,"N","C","1,2",,,,.T.) // Produto
			MSCBSAY(051,017, STR0009,"N","C","1,2",,,,.T.) // Qtde.
			If lRasLot
				MSCBSAY(034,017, STR0013,"N","C","1,2",,,,.T.) // Lote
			EndIf

			nl    := 021
			cDocAnt := aItens[nItens,7]
			For nlinha := 1 To nQuebr
				cDesc := Posicione("SB1",1,xFilial("SB1")+aItens[nItens,1],"B1_DESC") // Descricao

				MSCBSAY(003,nl,SUBSTR(cDesc,1,IIf(lRasLot,20,30)),"N","C","1,2",,,,.T.) // Item
				MSCBSAY(051,nl,Transform(aItens[nItens,2],'@E 99999'),"N","C","1,2",,,,.T.) // Qtde.
				If lRasLot
					MSCBSAY(034,nl, aItens[nItens,4],"N","C","1,2",,,,.T.) // Lote
				EndIf

				nItens++
				nl += 4
				If nItens > Len(aItens) .Or. Alltrim(aItens[nItens,3]) <> cVolAtu
					Exit
				Endif

				If cDocAnt <> aItens[nItens + IIf(nItens == Len(aItens),0,1),7]
					MSCBSAY(069,005, STR0010,"N","C","1,2",,,,.T.) // Documento
					MSCBSAY(069,009, aItens[nItens,7],"N","E","1,2",,,,.T.) // Pedido
					cDocAnt := aItens[nItens,7]
				EndIf
			Next

			If cDocAnt == aItens[nItens - 1,7]
				MSCBSAY(069,005, STR0010,"N","C","1,2",,,,.T.) // Documento
				MSCBSAY(069,009, aItens[nItens - 1,7],"N","E","1,2",,,,.T.) // Pedido
			EndIf

			If nItens <= Len(aItens)
				If Alltrim(aItens[nItens,3]) <> cVolAtu
					nVolAtu++
				EndIf
			EndIf

			MSCBSAY(073,017, STR0002,"N","F","1,2",,,,.T.)// Volume
			MSCBSAY(070,021, cVolAtu,"N","F","1,2",,,,.T.)
			If Val(cVolAtu) > 0
				MSCBSAYBAR(IIf(Val(cVolAtu)>0,067,061),028, ALLTRIM(cVolAtu),'N','MB07',9,.F.,.F.,,'B',2.3,2,) // Opcao B -> Utilizado no code128/ para aceitar letras e numeros.
			Else
				MSCBSAYBAR(061,028, ALLTRIM(cVolAtu),'N','MB07',9,.F.,.F.,,'B',2.3,2,) // Opcao B -> Utilizado no code128/ para aceitar letras e numeros.
			EndIf

			//DLOGWMSMSP-15041 Envio de dados para impressora com intervalo de meio segundo para conseguir processar a fila 
			cTimeFim := timecounter()
			cDifTime = cTimeFim - cTimeIni
			If nExec > 0 .And. cDifTime < 500
				Sleep(500)
			EndIf
			nExec++
			MSCBEND()
		EndDo
	EndIf

	If !lMontagem
		MSCBCLOSEPRINTER()
	EndIf
	// Atualiza campo DCU_IMPETI (Flag de Impressao)
	DCU->(DbSetOrder(1))
	For nVol := 1 to len(aItens)
		cVolAtu := aItens[nvol,3]
		If !Empty(cVolAtu) .And. DCU->(DbSeek(xFilial("DCU")+cVolAtu))
			While !Eof() .And. DCU->DCU_CODVOL == cVolAtu
				RecLock("DCU",.F.)
				DCU->DCU_IMPETI := '1'
				DCU->(MsUnlock())
				DCU->(dbSkip())
			EndDo
		EndIf
	Next
Return Nil