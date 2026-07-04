/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIPR190.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ QIPR190	³ Autor ³ Eduardo de Souza      ³ Data ³ 07/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Etiqueta de Laudo Final                 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QIPR190()                                     			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAQIP  												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QIPR190 ()

Local wnrel     := "QIPR190"
Local cString   := "SC2"
Local cDesc1    := OemToAnsi(STR0001) //"Ser„o impressas as etiquetas de Laudo."
Local cDesc2    := " "
Local cDesc3    := " "

Private cTitulo	 := OemToAnsi(STR0002) // "Etiqueta de Laudo"
Private cTamanho := "P"
Private nPagina	 := 1
Private aReturn  := {STR0003, 1,STR0004,  1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
Private nLastKey := 0
Private cPerg    := "QPR190"
Private lEnd     := .F.
Private nLimite  := 80

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					     ³
//³ mv_par01			  // Ordem Producao De                   ³
//³ mv_par02			  // Ordem Producao Ate  				 ³
//³ mv_par03			  // Produto De							 ³
//³ mv_par04			  // Produto Ate 						 ³
//³ mv_par05			  // Data Emissao De					 ³
//³ mv_par06           	  // Data Emissao Ate                    ³
//³ mv_par07              // Lote De                             ³
//³ mv_par08              // Lote Ate                            ³
//³ mv_par09              // Assumir Tam.Lote                    ³
//³ mv_par10              // N§ de Etiquetas se Nao Usar Tam.Lote³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT 				         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,@ctitulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,cTamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se apertou o botao cancela ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey == 27
	Return .F.
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
	Return .F.
EndIf

RptStatus({|lEnd| A190Imp(@lEnd,wnRel,cString)},cTitulo)

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ A190Imp  ³ Autor ³ Eduardo de Souza      ³ Data ³ 07/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime as Etiquetas dos Produtos                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd  - Verifica se o foi cancelada a impressao            ³±±
±±³			 ³ wnRel - Usada na fun‡Æo OurSpool                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ A190Imp(QIPR190.PRW)                          	          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function A190Imp(lEnd,wnRel,cString)

Local nSaltPag := 0
Local nLin     := 0
Local cKey     := ""
Local cFiltro  := ""
Local cLote    := ""
Local dDtLaudo := CTOD("  /  /  ")
Local dDtValid := CTOD("  /  /  ")
Local cTamLot  := ""
Local nC       := 0
Local aArea    := GetArea()
Local cLaudo   := ""
Local aCpoEnc  := {{},{}}
Local nPosDtaLau := 0
Local nPosValLot := 0
Local nPosLauGer := 0
Local aLauLab  :={}
Local aStruAlias := FWFormStruct(3, "QPL")[3]
Local nX

mv_par10:= If(mv_par10 < 1,1,mv_par10)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o vetor com os campos a serem utilizados na Enchoice LAB³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 To Len(aStruAlias)
	If cNivel >= GetSx3Cache(aStruAlias[nX,1], "X3_NIVEL") 
		Aadd(aCpoEnc[1],aStruAlias[nX,1])//X3_CAMPO
		Aadd(aCpoEnc[2],GetSx3Cache(aStruAlias[nX,1], "X3_CONTEXT"))
	EndIf
Next nX

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salva as posicoes das variaveis no aCpoEnc                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nPosDtaLau := Ascan(aCpoEnc[1],{|x|AllTrim(x)=="QPL_DTLAUD"})//posicao da data do Laudo
nPosValLot := Ascan(aCpoEnc[1],{|x|AllTrim(x)=="QPL_DTVAL"}) //posicao da Validade do Lote
nPosLauGer := Ascan(aCpoEnc[1],{|x|AllTrim(x)=="QPL_LAUDO"}) //Posicao do Laudo da OP

DbSelectArea("QPK")
DbSetOrder(1)

DbSelectArea("SC2")
DbSetOrder(1)
cKey:= SC2->(IndexKey())             

cFiltro:= "SELECT C2_FILIAL, C2_NUM, C2_ITEM, C2_SEQUEN, C2_ITEMGRD, C2_QUANT, C2_PRODUTO, C2_REVI, C2_UM, C2_EMISSAO FROM "
cFiltro+= RetSqlName("SC2") + " WHERE "
cFiltro+= "C2_FILIAL = '"+xFilial("SC2")+"' AND "
cFiltro+= "C2_NUM >= '"+mv_par01+"' AND "
cFiltro+= "C2_NUM <= '"+mv_par02+"' AND "
cFiltro+= "C2_PRODUTO >= '"+mv_par03+"' AND "
cFiltro+= "C2_PRODUTO <= '"+mv_par04+"' AND "
cFiltro+= "C2_EMISSAO >= '"+DtoS(mv_par05)+"' AND "
cFiltro+= "C2_EMISSAO <= '"+DtoS(mv_par06)+"' "
cFiltro+= "ORDER BY " + SqlOrder(cKey)
   
cFiltro := ChangeQuery(cFiltro)
	
dbUseArea( .T., "TOPCONN", TCGENQRY(,,cFiltro),"TRB", .F., .T.)
cAliasC2 := "TRB"

SetRegua((cAliasC2)->(LastRec()))
While (cAliasC2)->(!Eof())
	
	If QPK->(DbSeek(xFilial("QPK")+(cAliasC2)->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)))
		
		While QPK->(!Eof()) .AND. QPK->QPK_OP==(cAliasC2)->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)
			
			IncRegua()
			
			cLote:= QPK->QPK_LOTE
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se o Lote satifaz o parametro  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !(cLote >= mv_par07 .And. cLote <= mv_par08)
				QPK->(DbSkip())
				Loop
			EndIf
			
			//Posiciona no Laudo da Ordem de Producao
			aLauLab := QP215FLAU(QPK->QPK_OP,,,,)
			If Len(aLauLab)	!= 0
				dDtLaudo := aLauLab[nPosDtaLau]//data do Laudo
				dDtValid := aLauLab[nPosValLot]//Validade do Lote
				cLaudo   := aLauLab[nPosLauGer]//Laudo da OP
			Endif
			
			cTamLot:= Alltrim(Str(QPK->QPK_TAMLOT))
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Utiliza o Tam.Lote corrente ou assume   ³
			//³   o informado na pergunte mv_par10      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par09 == 1
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Troca a virgula por ponto outros        ³
				//³   caracteres sao bloqueados no cadastro ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If AT(",",cTamLot) > 0
					cTamLot := StrTran(cTamLot,",",".")
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Se o Tam.Lote nao for inteiro ‚ adicionado   ³
				//³  uma etiqueta a mais                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Int(SuperVal(cTamLot)) == SuperVal(cTamLot)
					mv_par10 := Int(SuperVal(cTamLot))
				Else
					mv_par10 := Int(SuperVal(cTamLot)) + 1
				EndIf
			EndIf
			
			For nC := 1 To mv_par10
				
				//Contador para Saltar Pagina
				nSaltPag++
				
				If lEnd
					nLin := nLin + 1
					@ nLin ,001 PSAY OemToAnsi(STR0007)  // "CANCELADO PELO OPERADOR"
					Exit
				EndIf
				
				nLin := nLin + 1
				If !Empty(cLaudo)
					@ nLin, 000 PSAY Posicione("QPD",1,xFilial("QPD")+cLaudo,"QPD_DESCPO")
				Else
					@ nLin, 000 PSAY OemToAnsi(STR0006) //"EM INSPECAO"
				EndIf
				
				nLin := nLin + 1
				@ nLin, 000 PSAY Pad(AllTrim(TitSx3("C2_PRODUTO")[1]),12,".")+":"
				@ nLin, 014 PSAY AllTrim((cAliasC2)->C2_PRODUTO)
				@ nLin, PCol()+1 PSAY "-"
				@ nLin, PCol()+1 PSAY (cAliasC2)->C2_REVI
				
				nLin := nLin + 1
				@ nLin, 013 PSAY Posicione("QP6",2,xFilial("QP6")+(cAliasC2)->C2_PRODUTO+(cAliasC2)->C2_REVI,"QP6_DESCPO")
				
				nLin := nLin + 1
				@ nLin, 000      PSAY Pad(AllTrim(TitSx3("QPL_DTLAUD")[1]),12,".")+":"
				@ nLin, 014      PSAY dDtLaudo Picture "@D"
				@ nLin, 025      PSAY Pad(AllTrim(TitSx3("QPL_LOTE")[1]),10,".")+":"
				@ nLin, PCol()+1 PSAY cLote
				
				nLin := nLin + 1
				@ nLin, 000      PSAY OemToAnsi(STR0005) // "Validade..:"
				@ nLin, 014      PSAY dDtValid Picture "@D"
				@ nLin, 025      PSAY Pad(AllTrim(TitSx3("QPL_TAMLOT")[1]),10,".")+":"
				@ nLin, PCol()+1 PSAY AllTrim(cTamLot)+" "
				SAH->(dbSetOrder(1))
				SAH->(dbSeek(xFilial("SAH")+(cAliasC2)->C2_UM))
				@ nLin, PCol()   PSAY SAH->AH_UMRES
				
				nLin := nLin + 1
				@ nLin, 000      PSAY Pad(AllTrim(TitSx3("C2_NUM")[1]),12,".")+":"
				@ nLin, 014      PSAY (cAliasC2)->(C2_NUM+C2_ITEM+C2_SEQUEN)
				
				If nSaltPag == 7 // Pula de Pagina a cada 7 etiquetas impressas
					nLin := nLin + 6
					nSaltPag:= 0
				Else
					nLin := nLin + 3 // Pula 3 linhas
				EndIf
				
			Next nC
			
			cLote    := ""
			dDtLaudo := CTOD("  /  /  ")
			dDtValid := CTOD("  /  /  ")
			cTamLot  := ""
			cLaudo   := ""
			
			QPK->(DbSkip())
		EndDo
	Endif
	(cAliasC2)->(DbSkip())
EndDo

Set Device To Screen

If aReturn[5] == 1
	Set Printer To
	Commit
	Ourspool(wnrel)
EndIf

MS_FLUSH()

TRB->(dbCloseArea())

RestArea(aArea)

Return .T.
