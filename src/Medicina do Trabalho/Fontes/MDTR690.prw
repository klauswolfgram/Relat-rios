/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR690.ch"
#Include "Protheus.ch"  

#DEFINE _nVERSAO 4 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³MDTR690   ³ Autor ³ Denis Hyroshi de Souza ³ Data ³30/11/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Ficha de Controle de Inspecao dos Extintores                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR690()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aArea := GetArea()
LOCAL cF3CC := "SI3001"  //SI3 apenas do cliente

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

PRIVATE nomeprog := "MDTR690"
PRIVATE titulo   := STR0001 //"Ficha de Controle de Inspeção dos Extintores"
PRIVATE cPerg    := If(!lSigaMdtPS,"MDT690    ","MDT690PS  ")
PRIVATE nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
PRIVATE cAliasCC := "SI3"
PRIVATE cCliMdtps := " "

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cF3CC := "CTT001"  //CTT apenas do cliente				
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
Endif        

/*---------------------------------------------------
//PERGUNTAS PADRÃO										|
MDT690    01      ¦De  Extintor             ?			|
MDT690    02      ¦Ate Extintor             ?			|
MDT690    03      ¦De  Centro de Custo      ?			|
MDT690    04      ¦Ate Centro de Custo      ?			|
MDT690    05      ¦De  Data Inspecao   ?				|
MDT690    06      ¦Ate Data Inspecao   ?				|
MDT690    07      ¦Tipo de Impressao?					|
MDT690    08      |Listar ?								|
|					 1)Somente c/ ordens finalizadas	|	
|					 2)Todos								|
|			09		 Modelo Impressão ?					|
|			10		 Informe o Cód. da Recarga ?		|
|			11		 Informe o Cód. do Teste Hidr.?		|
|															|
//PERGUNTAS PRESTADOR DE SERVIÇO						|
|			   01       De Cliente ?						|
|			   02       Loja								|
|			   03       Até Cliente ?					|
|			   04       Loja								|
|	MDT690    05      ¦De  Extintor             ?		|
|	MDT690    06      ¦Ate Extintor             ?		|
|	MDT690    07      ¦De  Centro de Custo      ?		|
|	MDT690    08      ¦Ate Centro de Custo      ?		|
|	MDT690    09      ¦De  Data Inspecao   ?			|
|	MDT690    10      ¦Ate Data Inspecao   ?			|
|	MDT690    11      ¦Tipo de Impressao?				|
|	MDT690    12      |Listar extintores com ordens?	|
|						 1)C/ ordens finalizadas			|
|						 2)Todos							|
|			   13		 Modelo Impressão ?				|
|			   14		 Informe o Cód. da Recarga ?	|
|			   15		 Informe o Cód. do Teste Hidr.?	|
-----------------------------------------------------*/

Private lMod1 := .T.
If Pergunte(cPerg,.T.,titulo)
	If lSigaMdtps
		If mv_par13 == 2
			lMod1 := .F.
		Endif
	Else
		If mv_par09 == 2
			lMod1 := .F.
		Endif
	Endif
	Processa({|lEND| MDTA690IMP()},STR0002) //"Processando..."
Endif

RestArea(aArea) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³MDTA690IMP³ Autor ³ Denis Hyroshi de Souza ³ Data ³09/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³Funcao de impressao                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MDTA690IMP()

Local n_Par08 := 1

If lSigaMdtps
	n_Par08 := Mv_par12

	cSeekExt := xFilial('TLA')+Mv_par01+mv_par02
	cWhilExt := "xFilial('TLA') == TLA->TLA_FILIAL .AND. TLA->(TLA_CLIENT+TLA_LOJA) <= mv_par03+mv_par04"
	cCondExt := "TLA->TLA_CODEXT >= Mv_par05 .and. TLA->TLA_CODEXT <= Mv_par06 .and. TLA->TLA_CC >= Mv_par07 .and. TLA->TLA_CC <= Mv_par08"
	nIndiExt := 7   //TLA_FILIAL+TLA_CLIENT+TLA_LOJA+TLA_CODEXT
	
	If (Mv_par07 == Mv_par08 .and. Mv_par05 != Mv_par06) .or. (Empty(Mv_par05) .and. Mv_par06 == "ZZZZZZZZZZ")
		nIndiExt := 9  //TLA_FILIAL+TLA_CLIENT+TLA_LOJA+TLA_CC
	Endif
	
	oPrint01 := TMSPrinter():New( OemToAnsi(titulo))
	oPrint01:SetPortrait() 	//Retrato
	oPrint01:Setup() 		//Configuracao
	
	dbSelectArea("TLA")
	dbSetOrder(nIndiExt)
	dbSeek(cSeekExt,.t.)
	ProcRegua(LastRec())
	While !eof() .and. &(cWhilExt)
		IncProc()
		If &(cCondExt)
			dbSelectArea("SA1")
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+TLA->(TLA_CLIENT+TLA_LOJA) )
			cCliMdtps := SA1->A1_COD+SA1->A1_LOJA
			If lMod1
				U_MDT690Ficha(mv_par09,mv_par10,.f.,SubStr(SA1->A1_NOME,1,50) , n_Par08)
			Else
				U_MDTA690MOD2(mv_par09,mv_par10,.f.,SubStr(SA1->A1_NOME,1,50) , n_Par08)
			Endif
		Endif
	
		dbSelectArea("TLA")
		dbSkip()
	End
	
	If mv_par11 == 1
		oPrint01:Preview()
	Else
		oPrint01:Print()
	EndIf		

Else
	n_Par08 := Mv_par08

	cSeekExt := xFilial('TLA')+Mv_par01
	cWhilExt := "xFilial('TLA') == TLA->TLA_FILIAL .AND. TLA->TLA_CODEXT <= Mv_par02"
	cCondExt := "TLA->TLA_CC >= Mv_par03 .and. TLA->TLA_CC <= Mv_par04"
	nIndiExt := 1
	
	If (Mv_par03 == Mv_par04 .and. Mv_par01 != Mv_par02) .or. (Empty(Mv_par01) .and. Mv_par02 == "ZZZZZZZZZZ")
		cSeekExt := xFilial('TLA')+Mv_par03
		cWhilExt := "xFilial('TLA') == TLA->TLA_FILIAL .AND. TLA->TLA_CC <= Mv_par04"
		cCondExt := "TLA->TLA_CODEXT >= Mv_par01 .and. TLA->TLA_CODEXT <= Mv_par02"
		nIndiExt := 3
	Endif
	
	oPrint01 := TMSPrinter():New( OemToAnsi(titulo))
	oPrint01:SetPortrait() 	//Retrato
	oPrint01:Setup() 		//Configuracao
	
	dbSelectArea("TLA")
	dbSetOrder(nIndiExt)
	dbSeek(cSeekExt,.T.)
	ProcRegua(LastRec())
	While !eof() .and. &(cWhilExt)
		IncProc()
		If &(cCondExt)
			If lMod1
				U_MDT690Ficha(mv_par05,mv_par06,.f.,,n_Par08)
			Else
				U_MDTA690MOD2(mv_par05,mv_par06,.f.,,n_Par08)
			Endif
		Endif
	
		dbSelectArea("TLA")
		dbSkip()
	End
	
	If mv_par07 == 1
		oPrint01:Preview()
	Else
		oPrint01:Print()
	EndIf	

Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³MDT690Ficha Autor ³ Denis Hyroshi de Souza ³ Data ³05/12/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³Impressao da Ficha de Controle de Inspecao                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT690Ficha(dDeData,dAteDate,lPreview,cNmCli,n_Par08)

Local nFor    := 0   // Contador
Local nCont   := 0   // Contador
// Local nEspaco := 80  // Espaco Simples dado entre as linhas de impressao
Local cData  // Data da realizacao

Private cNomeCli := cNmCli

	aInspecao := {}
	aTotIns   := {}

	If lSigaMdtps
		If mv_par12 == 1 // Finalizadas
			cCond08 := "TLD->TLD_SITUAC == '2' .And. TLD->TLD_DTPREV >= mv_par09 .And. TLD->TLD_DTPREV <= mv_par10"
		Else // Todos
			cCond08 := "TLD->TLD_DTPREV >= mv_par09 .And. TLD->TLD_DTPREV <= mv_par10"
		EndIf

		dbSelectArea("TLD")
		dbSetOrder(9)  //TLD_FILIAL+TLD_CLIENT+TLD_LOJA+TLD_CODEXT
		dbSeek(xFilial("TLD")+TLA->(TLA_CLIENT+TLA_LOJA)+TLA->TLA_CODEXT)
		While !eof() .and. TLD->TLD_FILIAL+TLD->TLD_CODEXT == xFilial("TLD")+TLA->TLA_CODEXT .and. TLA->(TLA_CLIENT+TLA_LOJA) == TLD->(TLD_CLIENT+TLD_LOJA)
			If &(cCond08)
				dbSelectArea("TK5")
				dbSetOrder(1)
				If dbSeek(xFilial("TK5")+TLD->TLD_ORDEM)
					While !Eof() .And. TK5->TK5_ORDEM == TLD->TLD_ORDEM
						dbSelectArea("TK4")
						dbSetOrder(1)
						If dbSeek(xFilial("TK4")+TK5->TK5_EVENTO) .And. (TK5->TK5_REALIZ == "1" .Or. (Val(TK5->TK5_EVENTO) >= 1 .And. Val(TK5->TK5_EVENTO) <= 13))
							aAdd(aInspecao,{TLD->TLD_DTREAL,;
												TLA->TLA_CODEXT,;
												TLD->TLD_ORDEM,;
												TK5->TK5_EVENTO,;
												Capital(TK4->TK4_DESCRI),;
												TK5->TK5_REALIZ})
							aAdd(aInspecao[Len(aInspecao)],TLD->TLD_RECEBI)
							nPosX := aScan(aTotIns,{|x| x[1] == TK5->TK5_EVENTO })
							If nPosX == 0
								aAdd(aTotIns, { TK5->TK5_EVENTO, 0 , 1 }) // Cod Evento, Totalizador, Quantidade encontrada do evento
							Else
								aTotIns[nPosX][3]++
							EndIf
						EndIf
						dbSelectArea("TK5")
						dbSkip()
					End
				EndIf
			Endif
			dbSelectArea("TLD")
			dbSkip()
		End
	Else
		If mv_par08 == 1 // Finalizadas
			cCond08 := "TLD->TLD_SITUAC == '2' .And. TLD->TLD_DTPREV >= mv_par05 .And. TLD->TLD_DTPREV <= mv_par06"
		Else // Todos ou Ficha Em Branco
			cCond08 := "TLD->TLD_DTPREV >= mv_par05 .And. TLD->TLD_DTPREV <= mv_par06"
		EndIf
		
		dbSelectArea( "TLD" )
		dbSetOrder( 2 )
		dbSeek( xFilial( "TLD" ) + AllTrim( TLA->TLA_CODEXT ) )

		While ( 'TLD' )->( !Eof() ) .And.;
		TLD->TLD_FILIAL + AllTrim( TLD->TLD_CODEXT ) == xFilial( "TLD" ) + AllTrim( TLA->TLA_CODEXT )

			If &(cCond08)
				dbSelectArea("TK5")
				dbSetOrder(1)
				If dbSeek(xFilial("TK5")+TLD->TLD_ORDEM)
					While !Eof() .And. TK5->TK5_ORDEM == TLD->TLD_ORDEM
						dbSelectArea("TK4")
						dbSetOrder(1)
						If dbSeek(xFilial("TK4")+TK5->TK5_EVENTO) .And. (TK5->TK5_REALIZ == "1" .Or. (Val(TK5->TK5_EVENTO) >= 1 .And. Val(TK5->TK5_EVENTO) <= 13))
							aAdd(aInspecao,{TLD->TLD_DTREAL,;
												TLA->TLA_CODEXT,;
												TLD->TLD_ORDEM,;
												TK5->TK5_EVENTO,;
												Capital(TK4->TK4_DESCRI),;
												TK5->TK5_REALIZ})
							aAdd(aInspecao[Len(aInspecao)],TLD->TLD_RECEBI)
							nPosX := aScan(aTotIns,{|x| x[1] == TK5->TK5_EVENTO })
							If nPosX == 0
								aAdd(aTotIns, { TK5->TK5_EVENTO, 0 , 1 }) // Cod Evento, Totalizador, Quantidade encontrada do evento
							Else
								aTotIns[nPosX][3]++
							EndIf
						EndIf
						dbSelectArea("TK5")
						dbSkip()
					End
				EndIf
			Endif
			dbSelectArea("TLD")
			dbSkip()
		End
	Endif
	
	If Len(aInspecao) = 0 // Lista somente os extintores que possuem ordens finalizadas
		Return NIL
	Endif
	
	oFont12n    := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)
	oFont11     := TFont():New("VERDANA",11,11,,.F.,,,,.F.,.F.)
	oFont12     := TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	oFont10     := TFont():New("VERDANA",10,10,,.F.,,,,.F.,.F.)
	
	oPrint01:StartPage()	//Inicia Pagina
	
	oPrint01:Say(200,750,Upper(STR0016),oFont12n) //"FICHA DE CONTROLE DE INSPEÇÃO"
	
	MDTR690PAG(.F.)
	
	ASORT(aInspecao,,, { |x, y| x[4] < y[4] .Or. (x[4] == y[4] .And. x[1] < y[1]) } )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atencao:                                                    ³
	//³                                                             ³
	//³ Todos os eventos da NR23 (13) serao mostrados, independente ³
	//³ de sua realizacao. Porem, qualquer outro evento cadastrado  ³
	//³ somente sera mostrado se sua Realizacao for "1" (Sim).      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLin := 590
	// Imprime as linhas
	For nCont := 1 To Len(aTotIns)
		nPos := aScan(aInspecao,{|x| x[4] == aTotIns[nCont][1] })
		// Imprime barras
		SomaLinha(160)
		oPrint01:line(nLin,1600,nLin+160,1600)	// Linha Vertical que isola 'Codigos e Reparos'
		oPrint01:line(nLin,500,nLin+160,500)	// Linha Vertical que separa 'Data' e 'Recebido'
		oPrint01:line(nLin,700,nLin+160,700)	// Linha Vertical que separa 'Recebido' e 'Inspecionado'
		oPrint01:line(nLin,950,nLin+160,950)	// Linha Vertical que separa 'Inspecionado' e 'Reparado'
		oPrint01:line(nLin,1183,nLin+160,1183)	// Linha Vertical que separa 'Reparado' e 'Instrucao'
		oPrint01:line(nLin,1416,nLin+160,1416)	// Linha Vertical que separa 'Instrucao' e 'Incendio'
		oPrint01:line(nLin+80,200,nLin+80,1600)		// Linha Horizontal que corta o Evento em dois
		oPrint01:line(nLin+160,200,nLin+160,2300)		// Linha Horizontal que corta o Evento
		nLinTemp := nLin+20
		For nFor := nPos To Len(aInspecao)
			If aTotIns[nCont][1] == aInspecao[nFor][4]
				cData := DTOC(aInspecao[nFor][1])
				If aTotIns[nCont][2] < 2
					// Preenche com 'X' ou ' ' os campos Inepecionado e Reparado
					If cData <> "  /  /  " .and. n_Par08 <> 3
						oPrint01:Say(nLinTemp,250,cData,oFont11) 
						If Len(aInspecao[nFor]) > 6 .and. aInspecao[nFor][7] == "1"
							oPrint01:Say(nLinTemp,590,"X",oFont12)  // Recebido
						Endif
						oPrint01:Say(nLinTemp,810,"X",oFont12)  // Inspecionado
						If aInspecao[nFor][6] == "1"
							oPrint01:Say(nLinTemp,1250,"X",oFont12) // Reparado
						EndIf
					Else
						oPrint01:Say(nLinTemp,250,"   /   /   ",oFont11)
					EndIf
					// Preenche com 'X' o campo Usado em Incendio
					If Val(aInspecao[nFor][4]) == 11 .And. aInspecao[nFor][6] == "1"
						If cData <> "  /  /  " .and. n_Par08 <> 3
							oPrint01:Say(nLinTemp,250,cData,oFont11)
							oPrint01:Say(nLinTemp,1500,"X",oFont12) // Incendio
						Else
							oPrint01:Say(nLinTemp,250,"   /   /   ",oFont11)
						EndIf
					EndIf
					// Preenche com 'X' o campo Usado em Instrucao
					If Val(aInspecao[nFor][4]) == 12 .And. aInspecao[nFor][6] == "1"
						If cData <> "  /  /  " .and. n_Par08 <> 3
							oPrint01:Say(nLinTemp,250,cData,oFont11)
							oPrint01:Say(nLinTemp,1280,"X",oFont12) // Instrucao
						Else
							oPrint01:Say(nLinTemp,250,"   /   /   ",oFont11)
						EndIf
					EndIf
					
					If aTotIns[nCont][2] == 0
						oPrint01:Say(nLinTemp,1610,AllTrim(aInspecao[nFor][4])+". "+SubStr(aInspecao[nFor][5],1,30),oFont11)
					EndIf
					aTotIns[nCont][2]++
					
					If aTotIns[nCont][3] == 1
						oPrint01:Say(nLin+100,250,"   /   /   ",oFont11)
					EndIf
					nLinTemp += 80
				EndIf
			Else
				Exit
			EndIf
		Next nFor
		
	Next nCont
	
	// 670 pixels e' o valor onde inicia a impressao dos eventos
	// Quando a pagina e' finalizada pela funcao SomaLinha(), a varialvel nLin recebe +160,
	// portanto primeiro deve atribuir os 160 que seriam recebidos no rodape' para depois
	// terminar a pagina
	oPrint01:Box(350,200,nLin+240,2300)			// Box que contem o relatorio
	oPrint01:line(nLin+160,1600,nLin+240,1600)		// Linha Vertical que isola 'Codigos e Reparos'
	oPrint01:Say(nLin+180,600,STR0028,oFont11)	// "CONTROLE DE EXTINTORES"


oPrint01:EndPage()

If lPreview
	oPrint01:Preview()
EndIf

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³MDTA690MOD2 Autor ³ Denis Hyroshi de Souza ³ Data ³05/12/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³Impressao da Ficha de Controle de Inspecao MODELO 2          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTA690MOD2(dDeData,dAteDate,lPreview,cNmCli,n_Par08)

Local nFor    := 0   // Contador
Local nCont   := 0   // Contador
// Local nEspaco := 80  // Espaco Simples dado entre as linhas de impressao
Local cData  // Data da realizacao

Private nLin := 100

Private cNomeCli := cNmCli

	aInspecao := {}
	aTipoInsp := {}
	
	aAdd( aTipoInsp , {"001",STR0003} ) //"Substituição de Gatilho"
	aAdd( aTipoInsp , {"002",STR0004} ) //"Substituição de Difusor"
	aAdd( aTipoInsp , {"003",STR0005} ) //"Mangote"
	aAdd( aTipoInsp , {"004",STR0006} ) //"Válvula de Segurança"
	aAdd( aTipoInsp , {"005",STR0007} ) //"Válvula Completa"
	aAdd( aTipoInsp , {"006",STR0008} ) //"Válvula Cilindro Adicional"
	aAdd( aTipoInsp , {"007",STR0009} ) //"Pintura"
	aAdd( aTipoInsp , {"008",STR0010} ) //"Manômetro"
	aAdd( aTipoInsp , {"009",STR0011} ) //"Teste Hidrostático"
	aAdd( aTipoInsp , {"010",STR0012} ) //"Recarregado"
	aAdd( aTipoInsp , {"011",STR0013} ) //"Usado em Incêndio"
	aAdd( aTipoInsp , {"012",STR0014} ) //"Usado em Instrução"
	aAdd( aTipoInsp , {"013",STR0015} ) //"Diversos"

	dbSelectArea("TK4")
	dbSetOrder(1)
	dbSeek(xFilial("TK4"))
	While !Eof() .and. xFilial("TK4") == TK4->TK4_FILIAL
		nPosX := aScan(aTipoInsp,{|x| x[1] == TK4->TK4_CODIGO })
		If nPosX == 0
			aAdd( aTipoInsp , {TK4->TK4_CODIGO,Capital(TK4->TK4_DESCRI)} )
		Else
			aTipoInsp[nPosX,2] := Capital(TK4->TK4_DESCRI)
		EndIf
		dbSkip()
	End

	If lSigaMdtps
		If mv_par12 == 1 // Finalizadas
			cCond08 := "TLD->TLD_SITUAC == '2' .And. TLD->TLD_DTPREV >= mv_par09 .And. TLD->TLD_DTPREV <= mv_par10"
		Else // Todos
			cCond08 := "TLD->TLD_DTPREV >= mv_par09 .And. TLD->TLD_DTPREV <= mv_par10"
		EndIf

		dbSelectArea("TLD")
		dbSetOrder(9)  //TLD_FILIAL+TLD_CLIENT+TLD_LOJA+TLD_CODEXT
		dbSeek(xFilial("TLD")+TLA->(TLA_CLIENT+TLA_LOJA)+TLA->TLA_CODEXT)
		While !eof() .and. TLD->TLD_FILIAL+TLD->TLD_CODEXT == xFilial("TLD")+TLA->TLA_CODEXT .and. TLA->(TLA_CLIENT+TLA_LOJA) == TLD->(TLD_CLIENT+TLD_LOJA)
			If &(cCond08)
				lTemTK5 := .F.
				dbSelectArea("TK5")
				dbSetOrder(1)
				If dbSeek(xFilial("TK5")+TLD->TLD_ORDEM)
					While !Eof() .And. TK5->TK5_ORDEM == TLD->TLD_ORDEM
						dbSelectArea("TK4")
						dbSetOrder(1)
						If dbSeek(xFilial("TK4")+TK5->TK5_EVENTO) .And. TK5->TK5_REALIZ == "1"
							If aScan(aInspecao,{|x| x[1] == TLD->TLD_DTREAL .and. x[2] == TLA->TLA_CODEXT .and.;
													x[4] == TK5->TK5_EVENTO }) == 0
								aAdd(aInspecao,{TLD->TLD_DTREAL,;
													TLA->TLA_CODEXT,;
													TLD->TLD_ORDEM,;
													TK5->TK5_EVENTO,;
													TK4->TK4_DESCRI,;
													TK5->TK5_REALIZ})
								lTemTK5 := .T.
							Endif
						EndIf
						dbSelectArea("TK5")
						dbSkip()
					End
				EndIf
				If !lTemTK5 .and. !Empty(TLD->TLD_DTREAL)
					aAdd(aInspecao,{TLD->TLD_DTREAL,;
										TLA->TLA_CODEXT,;
										TLD->TLD_ORDEM,;
										"-#-",;
										" ",;
										" " })
				Endif
			Endif
			dbSelectArea("TLD")
			dbSkip()
		End
	Else
		If mv_par08 == 1 // Finalizadas
			cCond08 := "TLD->TLD_SITUAC == '2' .And. TLD->TLD_DTPREV >= mv_par05 .And. TLD->TLD_DTPREV <= mv_par06"
		Else // Todos ou Ficha em branco
			cCond08 := "TLD->TLD_DTPREV >= mv_par05 .And. TLD->TLD_DTPREV <= mv_par06"
		EndIf
		
		dbSelectArea("TLD")
		dbSetOrder(2)
		dbSeek(xFilial("TLD")+TLA->TLA_CODEXT)
		While !eof() .and. TLD->TLD_FILIAL+TLD->TLD_CODEXT == xFilial("TLD")+TLA->TLA_CODEXT
			If &(cCond08)
				lTemTK5 := .F.
				dbSelectArea("TK5")
				dbSetOrder(1)
				If dbSeek(xFilial("TK5")+TLD->TLD_ORDEM)
					While !Eof() .And. TK5->TK5_ORDEM == TLD->TLD_ORDEM
						dbSelectArea("TK4")
						dbSetOrder(1)
						If dbSeek(xFilial("TK4")+TK5->TK5_EVENTO) .And. TK5->TK5_REALIZ == "1"
							If aScan(aInspecao,{|x| x[1] == TLD->TLD_DTREAL .and. x[2] == TLA->TLA_CODEXT .and.;
													x[4] == TK5->TK5_EVENTO }) == 0
								aAdd(aInspecao,{TLD->TLD_DTREAL,;
													TLA->TLA_CODEXT,;
													TLD->TLD_ORDEM,;
													TK5->TK5_EVENTO,;
													TK4->TK4_DESCRI,;
													TK5->TK5_REALIZ})
								lTemTK5 := .T.
							Endif
						EndIf
						dbSelectArea("TK5")
						dbSkip()
					End
				EndIf
				If !lTemTK5 .and. !Empty(TLD->TLD_DTREAL)
					aAdd(aInspecao,{TLD->TLD_DTREAL,;
										TLA->TLA_CODEXT,;
										TLD->TLD_ORDEM,;
										"-#-",;
										" ",;
										" " })
				Endif
			Endif
			dbSelectArea("TLD")
			dbSkip()
		End
	Endif

	If Len(aInspecao) = 0 // Lista somente os extintores que possuem ordens finalizadas
		Return NIL
	Endif

	oFont09n := TFont():New("VERDANA",09,09,,.T.,,,,.F.,.F.)
	oFont10  := TFont():New("VERDANA",10,10,,.F.,,,,.F.,.F.)
	oFont10n := TFont():New("VERDANA",10,10,,.T.,,,,.F.,.F.)
	oFont11  := TFont():New("VERDANA",11,11,,.F.,,,,.F.,.F.)
	oFont11n := TFont():New("VERDANA",11,11,,.T.,,,,.F.,.F.)
	oFont12  := TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	oFont12n := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)

	oPrint01:StartPage()	//Inicia Pagina

	MDTR690PAG(.F.)

	ASORT(aInspecao,,, { |x, y| DtoS(x[1])+x[4] < DtoS(y[1])+y[4] } )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atencao:                                                    ³
	//³                                                             ³
	//³ Todos os eventos da NR23 (13) serao mostrados, independente ³
	//³ de sua realizacao. Porem, qualquer outro evento cadastrado  ³
	//³ somente sera mostrado se sua Realizacao for "1" (Sim).      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nConTit := 0
	nContDt := 0
	dSvData := StoD("20301224")
	// Imprime as linhas
	For nFor := 1 To Len(aInspecao)
		If Empty(aInspecao[nFor][1])
			Loop
		Else
			If aInspecao[nFor][1] <> dSvData
				nContDt := 0
			Endif
		Endif
		dSvData := aInspecao[nFor][1]
		nContDt++
		If nContDt == 1 .or. (nContDt%7) == 1
			SomaLinha(60)
			oPrint01:line(nLin,1600,nLin+60,1600)	// Linha Vertical que isola 'Codigos e Reparos'
			oPrint01:line(nLin,540,nLin+60,540)		// Linha Vertical que separa 'Data'
			oPrint01:line(nLin+60,200,nLin+60,1600)	// Linha Horizontal
			oPrint01:line(nLin,200,nLin+60,200)		// Linha Horizontal
			oPrint01:line(nLin,2300,nLin+60,2300)	// Linha Horizontal
			oPrint01:line(nLin,630,nLin+60,630)		// Linha Vertical H.1 -> H.2
			oPrint01:line(nLin,720,nLin+60,720)		// Linha Vertical H.2 -> H.3
			oPrint01:line(nLin,810,nLin+60,810)		// Linha Vertical H.3 -> H.4
			oPrint01:line(nLin,900,nLin+60,900)		// Linha Vertical H.4 -> H.5
			oPrint01:line(nLin,990,nLin+60,990)		// Linha Vertical H.5 -> H.6
			oPrint01:line(nLin,1080,nLin+60,1080)	// Linha Vertical H.6 -> H.7
			oPrint01:line(nLin,1170,nLin+60,1170)	// Linha Vertical H.7 -> ASS
			If nContDt == 1 .and. n_Par08 <> 3
				If !Empty(aInspecao[nFor][1])
					oPrint01:Say(nLin+10,300,DtoC(aInspecao[nFor][1]),oFont10)
				Else
					oPrint01:Say(nLin+10,300,"   /   /   ",oFont10)
				EndIf
			Endif
			nConTit++
			If nConTit > 0 .and. nConTit <= Len(aTipoInsp)
				oPrint01:Say(nLin+10,1610,aTipoInsp[nConTit,1]+". "+SubStr(aTipoInsp[nConTit,2],1,30),oFont10)
			EndIf
			If n_Par08 <> 3
				If aInspecao[nFor][4] <> "-#-"
					oPrint01:Say(nLin+10,550,aInspecao[nFor][4],oFont10)
				Endif
			Endif
		Else
			nResto := (nContDt%7)-1
			If nResto == -1
				nResto := 6
			Endif
			If n_Par08 <> 3
				If aInspecao[nFor][4] <> "-#-"
					oPrint01:Say(nLin+10,550+(nResto*90),aInspecao[nFor][4],oFont10)
				Endif
			Else
				nContDt := 2
			Endif
		Endif
	Next nFor

	For nConT := nConTit+1 to Len(aTipoInsp)
		SomaLinha(60)
		oPrint01:line(nLin,1600,nLin+60,1600)	// Linha Vertical que isola 'Codigos e Reparos'
		oPrint01:line(nLin,540,nLin+60,540)		// Linha Vertical que separa 'Data'
		oPrint01:line(nLin+60,200,nLin+60,1600)	// Linha Horizontal
		oPrint01:line(nLin,200,nLin+60,200)		// Linha Vertical
		oPrint01:line(nLin,2300,nLin+60,2300)	// Linha Vertical
		oPrint01:line(nLin,630,nLin+60,630)		// Linha Vertical H.1 -> H.2
		oPrint01:line(nLin,720,nLin+60,720)		// Linha Vertical H.2 -> H.3
		oPrint01:line(nLin,810,nLin+60,810)		// Linha Vertical H.3 -> H.4
		oPrint01:line(nLin,900,nLin+60,900)		// Linha Vertical H.4 -> H.5
		oPrint01:line(nLin,990,nLin+60,990)		// Linha Vertical H.5 -> H.6
		oPrint01:line(nLin,1080,nLin+60,1080)	// Linha Vertical H.6 -> H.7
		oPrint01:line(nLin,1170,nLin+60,1170)	// Linha Vertical H.7 -> ASS
		oPrint01:Say(nLin+10,1610,aTipoInsp[nConT,1]+". "+SubStr(Capital(aTipoInsp[nConT,2]),1,30),oFont10)
	Next nConT

	If nLin+60 > 3060
		nLin += 60
	Else
		SomaLinha(60)
	Endif

	oPrint01:Box(nLin,200,nLin+80,2300)			// Box que contem o relatorio
	oPrint01:Say(nLin+20,1000,STR0028,oFont12n)	// "CONTROLE DE EXTINTORES"

	oPrint01:EndPage()

	If lPreview
		oPrint01:Preview()
	EndIf

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³MDTR690PAGºAutor  ³Wagner S. de Lacerdaº Data ³  14/06/2010 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Pula de pagina.                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MDTR690                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MDTR690PAG(lQuebra)
Local cSMCOD
Local cSMFIL
Local nAti := 0

If lMod1
	If lQuebra
		// 2400 pixels e' onde o ultimo evento e' impresso
		oPrint01:Box(350,200,nLin+80,2300)			// Box que contem o relatorio
		oPrint01:line(nLin,1600,nLin+80,1600)		// Linha Vertical que isola 'Codigos e Reparos'
		oPrint01:Say(nLin+20,600,STR0028,oFont11)	// "CONTROLE DE EXTINTORES"
		// Encerra a pagina atual
		oPrint01:EndPage()
		// Comeca uma nova pagina
		oPrint01:StartPage()
	EndIf
	
	nAti += 80
	// Prepara a nova pagina com o cabecalho
	oPrint01:line(350,1150,510+nAti,1150)		// Linha Vertical que separa 'MARCA' e 'TIPO' / 'EXTINTOR' e 'LOCAL'
	oPrint01:line(430,200,430,2300)		// Linha Horizontal que corta 'MARCA' e 'TIPO'
	oPrint01:line(510,200,510,2300)		// Linha Horizontal que corta 'EXTINTOR' e 'LOCAL'
	oPrint01:line(590,200,590,2300)		// Linha Horizontal que corta 'ATIVO FIXO' e 'ABNT'
	oPrint01:line(590+nAti,200,590+nAti,1600)		// Linha Horizontal que corta 'HISTORICO'
	oPrint01:line(510+nAti,1600,670+nAti,1600)		// Linha Vertical que isola 'Codigos e Reparos'
	oPrint01:line(670+nAti,200,670+nAti,2300)		// Linha Horizontal que corta o Cabecalho (Data, Inspecionado, Reparado, Instrucao, Incendio, Codigos e Reparos)
	oPrint01:line(670,500,670+160,500)	// Linha Vertical que separa 'Data' e 'Recebido'
	oPrint01:line(670,700,670+160,700)	// Linha Vertical que separa 'Recebido' e 'Inspecionado'
	oPrint01:line(670,950,670+160,950)	// Linha Vertical que separa 'Inspecionado' e 'Reparado'
	oPrint01:line(670,1183,670+160,1183)	// Linha Vertical que separa 'Reparado' e 'Instrucao'
	oPrint01:line(670,1416,670+160,1416)	// Linha Vertical que separa 'Instrucao' e 'Incendio'
	If lSigaMdtPS
		oPrint01:Say(300,210,STR0029 + TLA->TLA_CLIENT + "-" + TLA->TLA_LOJA + " - " + cNomeCli, oFont11)   //"Cliente/Loja: "
	Endif
	
	oPrint01:Say(360,210,STR0017,oFont11) //"MARCA:"
	oPrint01:Say(365,380,TLA->TLA_MARCA,oFont10)
	oPrint01:Say(360,1160,STR0018,oFont11) //"TIPO:"
	oPrint01:Say(365,1300,TLA->TLA_TIPO,oFont10)
	
	oPrint01:Say(440,210,STR0019,oFont11) //"EXTINTOR Nº:"
	oPrint01:Say(445,510,TLA->TLA_CODEXT,oFont10)
	oPrint01:Say(440,1160,STR0020,oFont11) //"LOCAL:"
	oPrint01:Say(445,1320,TLA->TLA_LOCAL,oFont10)
	oPrint01:Say(520,210,STR0072+":",oFont11) //"ATIVO FIXO"
	oPrint01:Say(525,510,TLA->TLA_ATIFIX,oFont10)
	oPrint01:Say(520,1160,STR0073+":",oFont11) //"ABNT"
	oPrint01:Say(525,1320,TLA->TLA_ABNT,oFont10)
	oPrint01:Say(520+nAti,780,STR0021,oFont11) //"HISTÓRICO"
	oPrint01:Say(600+nAti,315,STR0022,oFont11) //"Data"
	oPrint01:Say(600+nAti,515,STR0074,oFont11) //"Recebido"
	oPrint01:Say(600+nAti,740,STR0023,oFont11) //"Inspecionado"
	oPrint01:Say(600+nAti,980,STR0024,oFont11) //"Reparado"
	oPrint01:Say(600+nAti,1213,STR0025,oFont11) //"Instrução"
	oPrint01:Say(600+nAti,1425,STR0026,oFont11) //"Incêndio"
	oPrint01:Say(580+nAti,1690,STR0027,oFont11) //"Códigos e reparos"
	nLin := 610+nAti
Else
	If lQuebra
		// 2400 pixels e' onde o ultimo evento e' impresso
		oPrint01:Box(nLin,200,nLin+80,2300)			// Box que contem o relatorio
		oPrint01:Say(nLin+20,1000,STR0028,oFont12n)	// "CONTROLE DE EXTINTORES"
		// Encerra a pagina atual
		oPrint01:EndPage()
		// Comeca uma nova pagina
		oPrint01:StartPage()
		nLin := 100
		oPrint01:line(nLin,200,nLin,2300) //linha estreita
	Else

		If lSigaMdtPS
			oPrint01:Say(150,800,STR0059,oFont12n) //"FICHA INDIVIDUAL DE CONTROLE DE EXTINTOR"
			oPrint01:Say(240,550,STR0029 + TLA->TLA_CLIENT + "-" + TLA->TLA_LOJA + " - " + cNomeCli, oFont11)   //"Cliente/Loja: "
		Else
			oPrint01:Say(170,800,STR0059,oFont12n) //"FICHA INDIVIDUAL DE CONTROLE DE EXTINTOR"
		Endif

		cSMCOD := FWGrpCompany()
		cSMFIL := FWCodFil()
		cFileLogo := "lgrl"+cSMCOD+cSMFIL+".bmp"
		If File(cFileLogo)
			oPrint01:sayBitMap(101,201,cFileLogo,340,200)
		Else
			cFileLogo := "lgrl"+cSMCOD+".bmp"
			If File(cFileLogo)
				oPrint01:sayBitMap(101,201,cFileLogo,340,200)
			Endif
		EndIf
		nAti += 60	
		// Prepara a nova pagina com o cabecalho
		oPrint01:line(100,200,100,2300)
		oPrint01:line(100,540,300,540)
		oPrint01:line(300,200,300,2300)
		oPrint01:line(335,200,335,2300)
		oPrint01:line(395,1040,575+nAti,1040) //linha vert
		oPrint01:line(455+nAti,1510,515+nAti,1510) //linha vert
		oPrint01:line(395,1900,515+nAti,1900) //linha vert
		oPrint01:Say(460,505,STR0060,oFont11) //"Nº INT."
		oPrint01:Say(465,655,Alltrim(TLA->TLA_CODEXT),oFont09n)

		oPrint01:line(335,200,335,2300) //linha estreita
		oPrint01:Say(345,1250,STR0061,oFont11n) //"MEDICINA E SEGURANÇA DO TRABALHO"
		oPrint01:line(395,200,395,2300) //linha 1
		oPrint01:Say(405,210,STR0062,oFont10) //"TIPO"
		oPrint01:Say(405,310,Substr(TLA->TLA_TIPO,1,20),oFont09n)
		oPrint01:Say(405,1050,STR0063,oFont10) //"LOCALIZAÇÃO"
		oPrint01:Say(405,1360,Substr(TLA->TLA_LOCAL,1,20),oFont09n)
		oPrint01:line(455,200,455,1900) //linha 2
		oPrint01:Say(465,210,STR0072,oFont10) //"ATIVO FIXO"
		oPrint01:Say(465,500,Substr(TLA->TLA_ATIFIX,1,20),oFont09n)
		oPrint01:line( 455, 490, 515, 490 ) //linha vert
		oPrint01:Say(465,1050,STR0073,oFont10) //"ABNT"
		oPrint01:Say(465,1360,Substr(TLA->TLA_ABNT,1,20),oFont09n)
		oPrint01:line(515,200,515,1900) //linha 3
		oPrint01:Say(465+nAti,210,STR0064,oFont10) //"CAPACIDADE"
		oPrint01:Say(465+nAti,500,Alltrim(TransForm(TLA->TLA_CAPACI,"@E 999,999,999.99")) + " " + TLA->TLA_UNIMED,oFont09n)
		oPrint01:Say(465+nAti,1050,STR0065,oFont10) //"RECARGA"
		oPrint01:Say(465+nAti,1240,fDtProxEve( 1 ),oFont09n)
		oPrint01:Say(465+nAti,1520,STR0066,oFont10) //"TESTE"
		oPrint01:Say(465+nAti,1650,fDtProxEve( 2 ),oFont09n)
		oPrint01:line(515+nAti,200,515+nAti,2300) //linha 3
		oPrint01:Say(525+nAti,210,STR0067,oFont10) //"FABRICANTE"
		oPrint01:Say(525+nAti,500,Substr(TLA->TLA_MARCA,1,20),oFont09n)
		oPrint01:Say(525+nAti,1050,STR0068,oFont10) //"Nº FABRICAÇÃO"
		oPrint01:Say(525+nAti,1350,TLA->TLA_NUMFAB,oFont09n)
		oPrint01:line(515+nAti,1720,575+nAti,1720) //linha vert
		oPrint01:line(515+nAti,2017,575+nAti,2017) //linha vert
		nVal1 := If( TLA->TLA_PESOVZ > 999999 , Int(TLA->TLA_PESOVZ) , TLA->TLA_PESOVZ )
		nVal2 := If( TLA->TLA_PESOCH > 999999 , Int(TLA->TLA_PESOCH) , TLA->TLA_PESOCH )
		cVal0 := Alltrim(TransForm(nVal1,"@E 999,999")) + " " + TLA->TLA_PESOUN
		oPrint01:Say(525+nAti,1730,"PV",oFont10)
		oPrint01:Say(525+nAti,1780,Substr(cVal0,1,10),oFont09n)
		cVal1 := Alltrim(TransForm(nVal2,"@E 999,999")) + " " + TLA->TLA_PESOUN
		oPrint01:Say(525+nAti,2025,"PC",oFont10)
		oPrint01:Say(525+nAti,2075,Substr(cVal1,1,10),oFont09n)
		oPrint01:line(575+nAti,200,575+nAti,2300) //linha 4
		oPrint01:line(610+nAti,200,610+nAti,2300) //linha estreita
		oPrint01:line(100,200,610+nAti,200)
		oPrint01:line(100,2300,610+nAti,2300)
		
		nLin := 610+nAti
	EndIf

	oPrint01:line(nLin,0200,nLin+60,0200)
	oPrint01:Say(nLin+10,300,Upper(STR0022),oFont11n) //"Data"
	oPrint01:line(nLin,0540,nLin+60,0540)
	oPrint01:Say(nLin+10,705,STR0021,oFont11n) //"HISTÓRICO"
	oPrint01:line(nLin,1170,nLin+60,1170)
	oPrint01:Say(nLin+10,1335,STR0069,oFont11n) //"ASS."
	oPrint01:line(nLin,1600,nLin+60,1600)
	oPrint01:Say(nLin+10,1800,STR0070,oFont11n) //"CODIFICAÇÃO"
	oPrint01:line(nLin,2300,nLin+60,2300)
	oPrint01:line(nLin+60,200,nLin+60,2300)
	If lQuebra
		nLin += 60
	Endif
Endif

Return .T.

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR405                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha(linhas)

Default linhas := 80

nLin += linhas
If nLin > 3060
	MDTR690PAG(.T.)
EndIf	

Return
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³R690DATAIN³ Autor ³ Jackson Machado       ³ Data ³ 08/06/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Valida data inicial.							              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR505                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function R690DATAIN(dData,dFim)

If Empty(dData)
	Help(" ",1,"DEDATAINVA")
	Return .F.
Endif

If !Empty(dFim) .and. dData > dFim
	Help(" ",1,"DATAINVALI")
 	Return .F.
Endif

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fDtProxEve


@author Guilherme Benekendorf
@since 10/11/2014
@version P11/P12
@return
/*/
//---------------------------------------------------------------------
Static Function fDtProxEve( nTipEvent )

Local cSkTLB		:= ""
Local dDtProx		:= STOD("")

Local nIndexTLB := 1

//Se prestador altera indices
If lSigaMdtps
	nIndexTLB := 3 
Endif

If nTipEvent == 1
	cSkTLB	:= If( lSigaMdtPs, cCliMdtps+Mv_par14 , Mv_par10 )
ElseIf nTipEvent == 2
	cSkTLB	:= If( lSigaMdtPs, cCliMdtps+Mv_par15 , Mv_par11 )
EndIf

dbSelectArea("TLB")
dbSetOrder(nIndexTLB)
If dbSeek(xFilial("TLB")+cSkTLB) //Busca proxima recarga
	dDtProx := f550PRXPEN()
	If Empty(dDtProx)
		dDtProx := f550ULTINS(.F.)
		//Gera ordens de inspecao de acordo com a periodicidade
		If !Empty(dDtProx) .and. !Empty(TLB->TLB_UNIDAD) .and. !Empty(TLB->TLB_PERIOD)
			//Verifica se deve somar a periodicidade
			If TLB->TLB_UNIDAD == "1"  //Dia
				dDtProx += TLB->TLB_PERIOD
			Elseif TLB->TLB_UNIDAD == "2"  //Semana
				dDtProx += (TLB->TLB_PERIOD * 7)
			Elseif TLB->TLB_UNIDAD == "3"  //Mes
				dDtProx := NGSomaMes( dDtProx, TLB->TLB_PERIOD )
			Elseif TLB->TLB_UNIDAD == "4"  //Ano
				dDtProx := NGSomaAno( dDtProx, TLB->TLB_PERIOD )
			Endif
		Endif
	Endif
Endif

Return DtoC(dDtProx)
