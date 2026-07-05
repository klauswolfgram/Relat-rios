/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MDTR853.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR853
Relatorio Ficha de Reconhecimento dos Ambientes de Trabalho

@type    function
@author  Felipe Nathan Welter
@since   26/04/2010
@sample  U_MDTR853()

@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDTR853()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM( )

	Private lSigaMdtPS := SuperGetMv("MV_MDTPS",.F.,"N") == "S"
	Private cCliMdtPs  := " "
	Private cCTTSI3 := If(CtbInUse(), "CTT", "SI3")

	U_MDTREL853()

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTREL853
Montagem do Relatório

@type    function
@author  Felipe Nathan Welter
@since   26/04/2010
@sample  U_MDTREL853()

@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDTREL853()

	Local wnrel   := "MDTR853"
	Local limite  := 132
	Local cString := "TO0"
	Local cDesc1  := STR0001 //"FICHA DE RECONHECIMENTO DOS AMBIENTES DE TRABALHO"
	Local cDesc2  := STR0002 //"Através dos parâmetros selecionar os itens que devem ser considerados"
	Local cDesc3  := STR0003 //"no relatório."

	Private nomeprog := "MDTR853"
	Private tamanho  := "M"
	Private aReturn  := { STR0004, 1,STR0005, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cabec1, cabec2
	Private titulo   := Capital(STR0001) //"Ficha de Reconhecimento dos Ambientes de Trabalho"
	Private cPerg    := PADR( "MDT853" , 10 )
	Private cPerg2   := PADR( "MDT8532" , 10 )

	MDT853SX1(cPerg , cPerg2)

	/*-------------------------------------
	//PERGUNTAS PADRÃO						|
	| Laudo ?								|
	| Observações ?							|
	| Imp. Luminosidade ?					|
	| Imp. Ruido ?							|
	| 										|
	//PERGUNTAS DO PRESTADOR DE SERVIÇO		|
	| Cliente ?								|
	| Loja								    |
	| Laudo ?								|
	| Observações ?							|
	| Imp. Luminosidade ?					|
	| Imp. Ruido ?							|
	---------------------------------------*/

	// Verifica as perguntas selecionadas
	Pergunte(cPerg,.F.)

	// Envia controle para a funcao SETPRINT
	wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Set Filter to
		Return
	Endif

	RptStatus({|lEnd| R853Grf(@lEnd,wnRel,titulo,tamanho)},titulo)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} R853Grf
Chamada do Relatório Grafico

@type    function
@author  Felipe Nathan Welter
@since   26/04/10
@sample  R853Grf( @lEnd, 'MDTR853', 'Relatório X', 'M' )

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caracter, Nome do relatório
@param   titulo, Caracter, Título do relatório
@param   tamanho, Caracter, Tamanho do relatório

@return  Nil, Sempre nulo
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function R853Grf( lEnd, wnRel, titulo, tamanho )

	Local nX, nY //Contadores de FOR
	Local cTxtMemo := "" //termo descritivo e medidas de controle
	Local aLumRui  := {{/*Luminosidade*/},{/*Ruido*/}} //armazena luminosidade/ruido selecionados
	Local lDepto   := NGCADICBASE("TN0_DEPTO" ,"A","TN0",.F.) .And. !lSigaMDTPS

	Private lImpLUM := lImpRUI := .F.  //Imprime luminosidade/ruido?

	// Definicao de objetos tipo fonte utilizados
	Private oFont08  := TFont():New("Verdana",08,08,,.F.,,,,.F.,.F.)
	Private oFont10b := TFont():New("Verdana",10,10,,.T.,,,,.F.,.F.)
	Private oFont10  := TFont():New("Verdana",10,10,,.F.,,,,.F.,.F.)
	Private oFont10o := TFont():New("Courier New",10,10,,.F.,,,,.F.,.F.) //observacoes
	Private oFont14s := TFont():New("Verdana",14,14,,.F.,,,,.F.,.T.)
	Private oFont16b := TFont():New("Verdana",16,16,,.T.,,,,.F.,.F.)

	oPrint := TMSPrinter():New(OemToAnsi(titulo))
	oPrint:Setup()

	// Contadores de linha e pagina

	Private lin := 9999 ,m_pag := 1
	Private nPaginaG := 0

	// Verifica se deve comprimir ou nao

	nTipo  := IIF(aReturn[4]==1,15,18)

	cabec1 := " "
	cabec2 := " "

	// Verifica a impressao de luminosidade/ruido

	If lSigaMdtPs
		lImpLUM := (MV_PAR05 == 1)
		lImpRUI := (MV_PAR06 == 1)
	Else
		lImpLUM := (MV_PAR03 == 1)
		lImpRUI := (MV_PAR04 == 1)
	EndIf

	If lImpLUM .Or. lImpRUI
		aLumRui := aClone(fR853LR())  //monta tela para selecao
		If Empty(aLumRui[1]) .And. Empty(aLumRui[2])
			Return .F.
		EndIf
	EndIf

	// Inicia a selecao das informacoes para impressao
	// Inicia nova pagina
	SomaLinha()

	// Posiciona Laudo Ambiental e empresa
	If lSigaMdtPs
		cCliMdtps := MV_PAR01+MV_PAR02

		dbSelectArea("SA1")
		dbSetOrder(01)
		dbSeek(xFilial("SA1")+cCliMdtps)

		dbSelectArea("TO0")
		dbSetOrder(06)  //cli + loj + laudo
		dbSeek(xFilial("TO0")+cCliMdtps+MV_PAR03)

		cEmp_Nome := SA1->A1_NOME
	Else
		dbSelectArea("TO0")
		dbSetOrder(01)
		dbSeek(xFilial("TO0")+MV_PAR01)

		dbSelectArea("SM0")
		dbSetOrder(01)
		dbSeek(cNumEmp)

		cEmp_Nome := SM0->M0_NOMECOM
	EndIf

	// Cria variaveis de armazenamento para impressao do relatorio:
	// - aCC    : [n] - centro de custo
	// - aTN0[x]: [1] - centro de custo
	//            [2] - risco
	//            [3] - grupo
	//            [4] - descricao
	//            [5] - fonte geradora
	//            [6] [1] - agente (luminosidade)
	//                [2] - quantidade
	//            [6] [3] - agente (ruido)
	//                [4] - quantidade
	// - aSRJ[x]: [1] - centro de custo
	//            [2] - funcao
	//            [3] - descricao
	//            [4] - qtd. masculino
	//            [5] - qtd. feminino
	//- aMedCon[]: [1] - codigo med. controle
	//             [2] - nome med. controle

	aCC := {}  //Armazena centros de custo para impressao (por pagina)
	aTN0 := {}  //Riscos detectados (por CC)
	aSRJ := {}  //Funcoes existentes
	aMedCon := {} //Medidas de Controle

	// Com base no laudo selecionado no parametro SX1, encontra os riscos relacionados e define os centros de custo
	// que serao apresentados no relatorio em aCC[], e os riscos por centro de custo aTN0[].

	If lSigaMdtPs
		nIndTO1 := 03
		cKeyTO1 := "xFilial('TO1') + cCliMdtPs + TO0->TO0_LAUDO"
		cWhiTO1 := "TO1->(!Eof()) .And. xFilial('TO1')+TO0->TO0_LAUDO == TO1->TO1_FILIAL+TO1->TO1_LAUDO .and. cCliMdtPs == TO1->TO1_CLIENT+TO1->TO1_LOJA"

		nIndTJF := 02
		cKeyTJF := "xFilial( 'TJF' ) + cCliMdtPs + TN0->TN0_NUMRIS"
		cWhiTJF := "xFilial( 'TJF' ) == TJF->TJF_FILIAL .And. cCliMdtPs == TJF->(TJF_CLIENT+TJF_LOJA) .And. TN0->TN0_NUMRIS == TJF->TJF_NUMRIS"
	Else
		nIndTO1 := 01
		cKeyTO1 := "xFilial('TO1') + TO0->TO0_LAUDO"
		cWhiTO1 := "TO1->(!Eof()) .And. TO1->TO1_FILIAL == xFilial('TO1') .And. TO1->TO1_LAUDO == TO0->TO0_LAUDO"

		nIndTJF := 01
		cKeyTJF := "xFilial( 'TJF' ) + TN0->TN0_NUMRIS"
		cWhiTJF := "xFilial( 'TJF' ) == TJF->TJF_FILIAL .And. TN0->TN0_NUMRIS == TJF->TJF_NUMRIS"

	EndIf

	dbSelectArea("TO1")
	dbSetOrder(nIndTO1)
	dbSeek(&(cKeyTO1),.T.)
	ProcRegua(TO1->(RecCount()))
	While &(cWhiTO1)

		IncProc()

		If lSigaMdtPs
			nIndTN0 := 08
			cKeyTN0 := "xFilial('TN0')+cCliMdtps+TO1->TO1_NUMRIS"
		Else
			nIndTN0 := 01
			cKeyTN0 := "xFilial('TN0')+TO1->TO1_NUMRIS"
		EndIf

		//Riscos
		dbSelectArea("TN0")
		dbSetOrder(nIndTN0)
		If dbSeek(&(cKeyTN0))

			//Laudos x Riscos

			If TN0->TN0_CC <> '*'  //Adiciona centro de custo do risco
				If aSCan(aCC,{|x| x == TN0->TN0_CC}) == 0
					aAdd(aCC,TN0->TN0_CC)
				EndIf
				If aSCan(aTN0,{|x| x[1] == TN0->TN0_CC .And. x[2] == TN0->TN0_NUMRIS}) == 0
					aNewTN0 := {TN0->TN0_CC,TN0->TN0_NUMRIS,Nil,Nil,Nil,{'',0,'',0}}
					aNewTN0 := aClone(fChkLumRui(aLumRui,aNewTN0,TN0->TN0_AGENTE,TN0->TN0_QTAGEN))
					aAdd(aTN0,aNewTN0)  //adiciona risco ao centro de custo
				EndIf
			Else  //Pesquisa por codigo funcao
				If TN0->TN0_CODFUN <> '*'  //Adiciona centro de custo da funcao

					If lSigaMdtPs
						nIndSRA1 := 02
						cKeySRA1 := "xFilial('SRA')+cCliMdtPs"
						cWhiSRA1 := "SRA->(!Eof()) .and. xFilial('SRA') == SRA->RA_FILIAL .AND. cCliMdtPs == Substr(SRA->RA_CC,1,nSizeCli+nSizeLoj)"
						cIfSRA1  := "SRA->RA_CODFUNC == TN0->TN0_CODFUN .And. !(SRA->RA_SITFOLH $ 'D/T')"
					Else
						nIndSRA1 := 07
						cKeySRA1 := "xFilial('SRA')+TN0->TN0_CODFUN"
						cWhiSRA1 := "SRA->(!Eof()) .And. SRA->RA_FILIAL == xFilial('SRA') .And. SRA->RA_CODFUNC == TN0->TN0_CODFUN"
						cIfSRA1  := "!(SRA->RA_SITFOLH $ 'D/T')"
					EndIf

					dbSelectArea("SRA")
					dbSetOrder(nIndSRA1)
					dbSeek(&(cKeySRA1),.T.)
					While &(cWhiSRA1)
						If &(cIfSRA1)
							If aSCan(aCC,{|x| x = SRA->RA_CC}) == 0
								aAdd(aCC,SRA->RA_CC)
							EndIf
							If aSCan(aTN0,{|x| x[1] == SRA->RA_CC .And. x[2] == TN0->TN0_NUMRIS}) == 0
								aNewTN0 := {SRA->RA_CC,TN0->TN0_NUMRIS,Nil,Nil,Nil,{'',0,'',0}}
								aNewTN0 := aClone(fChkLumRui(aLumRui,aNewTN0,TN0->TN0_AGENTE,TN0->TN0_QTAGEN))
								aAdd(aTN0,aNewTN0)  // Adiciona risco ao centro de custo
							EndIf
						EndIf
						dbSelectArea("SRA")
						dbSkip()
					EndDo
				Else // Pesquisa por Departamento
					If lDepto .And. TN0->TN0_DEPTO <> '*'
						nIndSRA1 := 21
						cKeySRA1 := "xFilial('SRA')+TN0->TN0_DEPTO"
						cWhiSRA1 := "SRA->(!Eof()) .And. SRA->RA_FILIAL == xFilial('SRA') .And. SRA->RA_DEPTO == TN0->TN0_DEPTO"
						cIfSRA1  := "!(SRA->RA_SITFOLH $ 'D/T')"

						dbSelectArea("SRA")
						dbSetOrder(nIndSRA1)
						dbSeek(&(cKeySRA1),.T.)
						While &(cWhiSRA1)
							If &(cIfSRA1)
								If aSCan(aCC,{|x| x = SRA->RA_CC}) == 0
									aAdd(aCC,SRA->RA_CC)
								EndIf
								If aSCan(aTN0,{|x| x[1] == SRA->RA_CC .And. x[2] == TN0->TN0_NUMRIS}) == 0
									aNewTN0 := {SRA->RA_CC,TN0->TN0_NUMRIS,Nil,Nil,Nil,{'',0,'',0}}
									aNewTN0 := aClone(fChkLumRui(aLumRui,aNewTN0,TN0->TN0_AGENTE,TN0->TN0_QTAGEN))
									aAdd(aTN0,aNewTN0)  //adiciona risco ao centro de custo
								EndIf
							EndIf
							dbSelectArea("SRA")
							dbSkip()
						EndDo
					Else  // Pesquisa por tarefa
						If TN0->TN0_CODTAR <> '*'  // Adiciona centro de custo da tarefa

							If lSigaMdtPs
								nIndTN61 := 03
								cKeyTN61 := "xFilial('TN6')+cCliMdtps+TN0->TN0_CODTAR"
								cWhiTN61 := "TN6->(!Eof()) .and. xFilial('TN6') == TN6->TN6_FILIAL .and. TN6->TN6_CODTAR == TN0->TN0_CODTAR .AND. cCliMdtps == TN6->(TN6_CLIENT+TN6_LOJA)"
							Else
								nIndTN61 := 01
								cKeyTN61 := "xFilial('TN6')+TN0->TN0_CODTAR"
								cWhiTN61 := "TN6->(!Eof()) .And. TN6->TN6_FILIAL == xFilial('TN6') .And. TN6->TN6_CODTAR == TN0->TN0_CODTAR"
							EndIf

							dbSelectArea("TN6")
							dbSetOrder(nIndTN61)
							dbSeek(&(cKeyTN61),.T.)
							While &(cWhiTN61)
								dbSelectArea("SRA")
								dbSetOrder(01)
								If dbSeek(xFilial("SRA")+TN6->TN6_MAT) .And. !(SRA->RA_SITFOLH $ 'D/T')
									If aSCan(aCC,{|x| x = SRA->RA_CC}) == 0
										aAdd(aCC,SRA->RA_CC)
									EndIf
									If aSCan(aTN0,{|x| x[1] == SRA->RA_CC .And. x[2] == TN0->TN0_NUMRIS}) == 0
										aNewTN0 := {SRA->RA_CC,TN0->TN0_NUMRIS,Nil,Nil,Nil,{'',0,'',0}}
										aNewTN0 := aClone(fChkLumRui(aLumRui,aNewTN0,TN0->TN0_AGENTE,TN0->TN0_QTAGEN))
										aAdd(aTN0,aNewTN0)  // Adiciona risco ao centro de custo
									EndIf
								EndIf
								dbSelectArea("TN6")
								dbSkip()
							EndDo
				//Else //Descarta Risco
						EndIf
					EndIf
				EndIf
			EndIf

		//Funcoes

		//Em cima do risco, pesquisa pela funcao relacionada e adiciona ao centro de custo em aSRJ[].
			If TN0->TN0_CC <> '*'
				If TN0->TN0_CODFUN <> '*'
					If aSCan(aSRJ,{|x| x[1] = TN0->TN0_CC .And. x[2] == TN0->TN0_CODFUN}) == 0
						aAdd(aSRJ,{TN0->TN0_CC,TN0->TN0_CODFUN,NGSEEK('SRJ',TN0->TN0_CODFUN,1,'RJ_DESC'),0,0})
					EndIf
				Else
					If TN0->TN0_CODTAR <> '*'

						If lSigaMdtPs
							nIndTN62 := 03
							cKeyTN62 := "xFilial('TN6')+cCliMdtps+TN0->TN0_CODTAR"
							cWhiTN62 := "TN6->(!Eof()) .And. xFilial('TN6') == TN6->TN6_FILIAL .And. TN6->TN6_CODTAR == TN0->TN0_CODTAR .And. cCliMdtps == TN6->(TN6_CLIENT+TN6_LOJA)"
						Else
							nIndTN62 := 01
							cKeyTN62 := "xFilial('TN6')+TN0->TN0_CODTAR"
							cWhiTN62 := "TN6->(!Eof()) .And. TN6->TN6_FILIAL == xFilial('TN6') .And. TN6->TN6_CODTAR == TN0->TN0_CODTAR"
						EndIf

						dbSelectArea("TN6")
						dbSetOrder(nIndTN62)
						dbSeek(&(cKeyTN62),.T.)
						While &(cWhiTN62)
							dbSelectArea("SRA")
							dbSetOrder(01)
							If dbSeek(xFilial("SRA")+TN6->TN6_MAT) .And. !(SRA->RA_SITFOLH $ 'D/T')
								If aSCan(aSRJ,{|x| x[1] = SRA->RA_CC .And. x[2] == SRA->RA_CODFUNC}) == 0
									aAdd(aSRJ,{SRA->RA_CC,SRA->RA_CODFUNC,NGSEEK('SRJ',SRA->RA_CODFUNC,1,'RJ_DESC'),0,0})
								EndIf
							EndIf
							dbSelectArea("TN6")
							dbSkip()
						EndDo
					Else
						If lDepto .And. TN0->TN0_DEPTO <> '*'
							nIndSRA2 := 21
							cKeySRA2 := "xFilial('SRA')+TN0->TN0_DEPTO"
							cWhiSRA2 := "SRA->(!Eof()) .And. SRA->RA_FILIAL == xFilial('SRA') .And. SRA->RA_DEPTO == TN0->TN0_DEPTO"
							cIfSRA2  := "!(SRA->RA_SITFOLH $ 'D/T')"

							dbSelectArea("SRA")
							dbSetOrder(nIndSRA2)
							dbSeek(&(cKeySRA2),.T.)
							While &(cWhiSRA2)
								If &(cIfSRA2)
									If aSCan(aSRJ,{|x| x[1] = SRA->RA_CC .And. x[2] == SRA->RA_CODFUNC}) == 0
										aAdd(aSRJ,{SRA->RA_CC,SRA->RA_CODFUNC,NGSEEK('SRJ',SRA->RA_CODFUNC,1,'RJ_DESC'),0,0})
									EndIf
								EndIf
								dbSelectArea("SRA")
								dbSkip()
							EndDo
						Else
							dbSelectArea("SRA")
							dbSetOrder(02)
							dbSeek(xFilial("SRA")+TN0->TN0_CC,.T.)
							While SRA->(!Eof()) .And. xFilial("SRA") == SRA->RA_FILIAL .AND. TN0->TN0_CC == SRA->RA_CC
								If !(SRA->RA_SITFOLH $ 'D/T')
									If aSCan(aSRJ,{|x| x[1] = TN0->TN0_CC .And. x[2] == SRA->RA_CODFUNC}) == 0
										aAdd(aSRJ,{TN0->TN0_CC,SRA->RA_CODFUNC,NGSEEK('SRJ',SRA->RA_CODFUNC,1,'RJ_DESC'),0,0})
									EndIf
								EndIf
								dbSelectArea("SRA")
								dbSkip()
							EndDo
						EndIf
					EndIf
				EndIf
			Else
				If TN0->TN0_CODFUN <> '*'

					If lSigaMdtPs
						nIndSRA2 := 02
						cKeySRA2 := "xFilial('SRA')+cCliMdtPs"
						cWhiSRA2 := "SRA->(!Eof()) .and. xFilial('SRA') == SRA->RA_FILIAL .AND. cCliMdtPs == Substr(SRA->RA_CC,1,nSizeCli+nSizeLoj)"
						cIfSRA2  := "SRA->RA_CODFUNC == TN0->TN0_CODFUN .And. !(SRA->RA_SITFOLH $ 'D/T')"
					Else
						nIndSRA2 := 07
						cKeySRA2 := "xFilial('SRA')+TN0->TN0_CODFUN"
						cWhiSRA2 := "SRA->(!Eof()) .And. SRA->RA_FILIAL == xFilial('SRA') .And. SRA->RA_CODFUNC == TN0->TN0_CODFUN"
						cIfSRA2  := "!(SRA->RA_SITFOLH $ 'D/T')"
					EndIf

					dbSelectArea("SRA")
					dbSetOrder(nIndSRA2)
					dbSeek(&(cKeySRA2),.T.)
					While &(cWhiSRA2)
						If &(cIfSRA2)
							If aSCan(aSRJ,{|x| x[1] = SRA->RA_CC .And. x[2] == SRA->RA_CODFUNC}) == 0
								aAdd(aSRJ,{SRA->RA_CC,SRA->RA_CODFUNC,NGSEEK('SRJ',SRA->RA_CODFUNC,1,'RJ_DESC'),0,0})
							EndIf
						EndIf
						dbSelectArea("SRA")
						dbSkip()
					EndDo
				Else // Departamento
					If lDepto .And. TN0->TN0_DEPTO <> '*'
						nIndSRA2 := 21
						cKeySRA2 := "xFilial('SRA')+TN0->TN0_DEPTO"
						cWhiSRA2 := "SRA->(!Eof()) .And. SRA->RA_FILIAL == xFilial('SRA') .And. SRA->RA_DEPTO == TN0->TN0_DEPTO"
						cIfSRA2  := "!(SRA->RA_SITFOLH $ 'D/T')"

						dbSelectArea("SRA")
						dbSetOrder(nIndSRA2)
						dbSeek(&(cKeySRA2),.T.)
						While &(cWhiSRA2)
							If &(cIfSRA2)
								If aSCan(aSRJ,{|x| x[1] = SRA->RA_CC .And. x[2] == SRA->RA_CODFUNC}) == 0
									aAdd(aSRJ,{SRA->RA_CC,SRA->RA_CODFUNC,NGSEEK('SRJ',SRA->RA_CODFUNC,1,'RJ_DESC'),0,0})
								EndIf
							EndIf
							dbSelectArea("SRA")
							dbSkip()
						EndDo
					Else
						If TN0->TN0_CODTAR <> '*'

							If lSigaMdtPs
								nIndTN63 := 03
								cKeyTN63 := "xFilial('TN6')+cCliMdtps+TN0->TN0_CODTAR"
								cWhiTN63 := "TN6->(!Eof()) .and. xFilial('TN6') == TN6->TN6_FILIAL .and. TN6->TN6_CODTAR == TN0->TN0_CODTAR .AND. cCliMdtps == TN6->(TN6_CLIENT+TN6_LOJA)"
							Else
								nIndTN63 := 01
								cKeyTN63 := "xFilial('TN6')+TN0->TN0_CODTAR"
								cWhiTN63 := "TN6->(!Eof()) .And. TN6->TN6_FILIAL == xFilial('TN6') .And. TN6->TN6_CODTAR == TN0->TN0_CODTAR"
							EndIf

							dbSelectArea("TN6")
							dbSetOrder(nIndTN63)
							dbSeek(&(cKeyTN63),.T.)
							While &(cWhiTN63)
								dbSelectArea("SRA")
								dbSetOrder(01)
								If dbSeek(xFilial("SRA")+TN6->TN6_MAT) .And. !(SRA->RA_SITFOLH $ 'D/T')
									If aSCan(aSRJ,{|x| x[1] = SRA->RA_CC .And. x[2] == SRA->RA_CODFUNC}) == 0
										aAdd(aSRJ,{SRA->RA_CC,SRA->RA_CODFUNC,NGSEEK('SRJ',SRA->RA_CODFUNC,1,'RJ_DESC'),0,0})
									EndIf
								EndIf
								dbSelectArea("TN6")
								dbSkip()
							EndDo
				//Else //Descarta
						EndIf
					EndIf
				EndIf
			EndIf

		// Medidas de Controle

			dbSelectArea( "TJF" )
			dbSetOrder( nIndTJF )
			dbSeek(&cKeyTJF)
			While &(cWhiTJF)

				If aSCan( aMedCon , { | x | x[ 1 ] == TJF->TJF_MEDCON } ) == 0
					aAdd(aMedCon , { TJF->TJF_MEDCON , AllTrim( NGSEEK( "TO4" , TJF->TJF_MEDCON , 1 , "TO4_NOMCTR" ) ) } )
				EndIf

				dbSelectArea("TJF")
				dbSkip()

			EndDo
		EndIf

		dbSelectArea("TO1")
		TO1->(dbSkip())

	EndDo

	aSort(aTN0,,,{|x,y| x[2] < y[2] })  //ordena por risco

	//Grava 'Grupo','Descricao' e 'Fonte Geradora' para cada risco
	For nX := 1 To Len(aTN0)

		dbSelectArea("TN0")
		dbSetOrder(01)
		dbSeek(xFilial("TN0")+aTN0[nX,2])

		dbSelectArea("TMA")
		dbSetOrder(01)
		If dbSeek(xFilial("TMA")+TN0->TN0_AGENTE)

			aTN0[nX,3] := TMA->TMA_GRISCO
			aTN0[nX,4] := TMA->TMA_NOMAGE
			aTN0[nX,5] := NGSEEK('TN7',TN0->TN0_FONTE,1,'TN7_NOMFON')

			While nX < Len(aTN0) .And. aTN0[nX,2] == aTN0[nX+1,2]
				nX++
				aTN0[nX,3] := TMA->TMA_GRISCO
				aTN0[nX,4] := TMA->TMA_NOMAGE
				aTN0[nX,5] := NGSEEK('TN7',TN0->TN0_FONTE,1,'TN7_NOMFON')
			EndDo
		EndIf
	Next nX

	//Termos descritivos
	cTxtMemo := " "
	dbSelectArea("TMZ")
	dbSetOrder(01)
	If dbSeek(xFilial("TMZ")+If(lSigaMdtPs,MV_PAR04,MV_PAR02))
		cTxtMemo := TMZ->TMZ_DESCRI
	EndIf

	//Funcoes e Trabalhadores
	//  grava quantidade de trabalhadores para cada funcao selecionada para o centro de custo
	cAliasFun := GetNextAlias()
	cQuery := " SELECT SRA.RA_CODFUNC, SRA.RA_CC, SRA.RA_SEXO, COUNT(*) AS TOTAL"
	cQuery += " FROM "+RetSqlName("SRA")+" SRA "
	cQuery += " WHERE SRA.RA_SITFOLH <> 'D'"
	cQuery += 		" AND SRA.RA_SITFOLH <> 'T'"
	cQuery += 		" AND SRA.D_E_L_E_T_ <> '*'"
	cQuery += 		" AND SRA.RA_FILIAL = '"+xFilial("SRA")+"'"
	cQuery += " GROUP BY SRA.RA_CODFUNC, SRA.RA_CC, SRA.RA_SEXO"
	cQuery := ChangeQuery(cQuery)
	MPSysOpenQuery( cQuery , cAliasFun )

	(cAliasFun)->(dbGoTop())
	While (cAliasFun)->(!Eof())
		If (nPos := aSCan(aSRJ,{|x| x[1] = (cAliasFun)->RA_CC .And. x[2] == (cAliasFun)->RA_CODFUNC})) > 0
			aSRJ[nPos,If((cAliasFun)->RA_SEXO == 'M',4,5)] := (cAliasFun)->TOTAL
		EndIf
		(cAliasFun)->(dbSkip())
	EndDo

	//Inicia a impressao do relatorio

	aSort(aTN0,,,{|x,y| x[1] < y[1] })  //ordena por centro de custo
	aSort(aSRJ,,,{|x,y| x[1] < y[1] })  //ordena por centro de custo

	//Imprime nome da empresa e titulo do relatorio
	oPrint:Say(210,200,Capital(cEmp_Nome),oFont16b)
	oPrint:Line(275,180,275,2300)
	oPrint:Line(279,180,279,2300)

	oPrint:Say(325,200,Upper(titulo),oFont14s)

	For nX := 1 To Len(aCC) //quebra por centro de custo

		SomaLinha(150)
		oPrint:Box(lin,150,lin+120,1500)
		oPrint:Line(lin,1000,lin+120,1000)
		nBoxCol := 1500
		If lImpLUM
			oPrint:Box(lin,nBoxCol,lin+120,nBoxCol+400)
			nBoxCol += 400
		EndIf
		If lImpRUI
			oPrint:Box(lin,nBoxCol,lin+120,nBoxCol+400)
			nBoxCol += 400
		EndIf

		SomaLinha(10)
		oPrint:Say(lin,200,STR0022+":",oFont10b) //"Centro de Custo"
		oPrint:Say(lin,1050,STR0023+":",oFont10b) //"Data Lev."
		nBoxCol := 1500
		If lImpLUM
			oPrint:Say(lin,nBoxCol+50,STR0020+":",oFont10b) //"Luminosidade"
			nBoxCol += 400
		EndIf
		If lImpRUI
			oPrint:Say(lin,nBoxCol+50,STR0024+":",oFont10b) //"Ruído"
			nBoxCol += 400
		EndIf

		SomaLinha()
		oPrint:Say(lin,200,SubStr(NGSEEK(cCTTSI3,aCC[nX],1,If(cCTTSI3=="CTT","CTT_DESC01","I3_DESC")),1,25),oFont10)
		oPrint:Say(lin,1050,NGSEEK('TO0',TO0->TO0_LAUDO,1,'DTOC(TO0_DTINIC)'),oFont10)
		nBoxCol := 1500
		If lImpLUM
			nMAX := 0
			aEval(aTN0,{|x|If(x[6,2] > nMAX,nMAX := x[6,2],Nil)})
			oPrint:Say(lin,nBoxCol+50,cValToChar(Transform(nMAX,"@E 99,999.999")),oFont10)
			nBoxCol += 400
		EndIf
		If lImpRUI
			nMAX := 0
			aEval(aTN0,{|x|If(x[6,4] > nMAX,nMAX := x[6,4],Nil)})
			oPrint:Say(lin,nBoxCol+50,cValToChar(Transform(nMAX,"@E 99,999.999")),oFont10)
			nBoxCol += 400
		EndIf

		//Cabecalho - Observacoes / Riscos detectados
		SomaLinha(120)
		oPrint:Box(lin,150,lin+70,2300)
		oPrint:Line(lin,1550,lin+70,1550)
		SomaLinha(10)

		oPrint:Say(lin,700,STR0025,oFont10b) //"Observações"
		oPrint:Say(lin,1750,STR0026,oFont10b) //"Riscos Detectados"

		SomaLinha(10)
		nLinR := 0
		While !Empty(cTxtMemo) .Or. nLinR < 5
			nLinR++
			SomaLinha()

			oPrint:Line(lin-10,0150,lin+60,0150)
			oPrint:Line(lin-10,1550,lin+60,1550)
			oPrint:Line(lin-10,2300,lin+60,2300)

			//Observacoes
			oPrint:Say(lin,160,SubStr(cTxtMemo,1,63),oFont10o)
			cTxtMemo := SubStr(cTxtMemo,64,Len(cTxtMemo))

			//Riscos detectados
			If nLinR == 1
				oPrint:Say(lin,1800,If(aSCan(aTN0,{|x|x[1]==aCC[nX] .And. x[3]=='1'})>0,"- (X)","- ( )")+" "+STR0027,oFont10) //"Físico"
			ElseIf nLinR == 2
				oPrint:Say(lin,1800,If(aSCan(aTN0,{|x|x[1]==aCC[nX] .And. x[3]=='2'})>0,"- (X)","- ( )")+" "+STR0028,oFont10) //"Ecológico"
			ElseIf nLinR == 3
				oPrint:Say(lin,1800,If(aSCan(aTN0,{|x|x[1]==aCC[nX] .And. x[3]=='3'})>0,"- (X)","- ( )")+" "+STR0029,oFont10) //"Biológico"
			ElseIf nLinR == 4
				oPrint:Say(lin,1800,If(aSCan(aTN0,{|x|x[1]==aCC[nX] .And. x[3]=='4'})>0,"- (X)","- ( )")+" "+STR0030,oFont10) //"Ergonômico"
			ElseIf nLinR == 5
				oPrint:Say(lin,1800,If(aSCan(aTN0,{|x|x[1]==aCC[nX] .And. x[3]=='5'})>0,"- (X)","- ( )")+" "+STR0031,oFont10) //"Acidente"
			EndIf

		EndDo
		SomaLinha()
		oPrint:Line(lin,150,lin,2300)

		//Cabecalho - Descricao dos Riscos / Fontes Geradoras
		SomaLinha(120)
		oPrint:Box(lin,150,lin+70,2300)
		oPrint:Line(lin,1225,lin+70,1225)
		SomaLinha(10)

		oPrint:Say(lin,475,STR0032,oFont10b) //"Descrição dos Riscos"
		oPrint:Say(lin,1550,STR0033,oFont10b) //"Fontes Geradoras"

		SomaLinha(10)

		For nY := 1 To 5

			If nY == 1
				cTxtRI := Upper(STR0027)+": " //"FÍSICO"
			ElseIf nY == 2
				cTxtRI := Upper(STR0034)+": " //"QUÍMICOS"
			ElseIf nY == 3
				cTxtRI := Upper(STR0035)+": " //"BIOLÓGICOS"
			ElseIf nY == 4
				cTxtRI := Upper(STR0036)+": " //"ERGONÔMICOS"
			ElseIf nY == 5
				cTxtRI := Upper(STR0031)+": " //"ACIDENTE"
			EndIf
			cTxtFG := ""

			//Alimenta riscos e fontes geradoras
			nPos := aSCan(aTN0,{|x| x[1] == aCC[nX] .And. Val(x[3]) == nY})
			While nPos > 0 .And. nPos <= Len(aTN0) .And. ((aTN0[nPos,1] == aCC[nX] .And. Val(aTN0[nPos,3]) == nY))
				If At( AllTrim(aTN0[nPos,4])+", " , cTxtRI ) == 0
					cTxtRI += AllTrim(aTN0[nPos,4])+", "
				EndIf
				If At( AllTrim(aTN0[nPos,5])+", " , cTxtFG ) == 0
					cTxtFG += AllTrim(aTN0[nPos,5])+", "
				EndIf
				nPos++
			EndDo
			If nPos > 0
				cTxtRI := SubStr(cTxtRI,1,Len(cTxtRI)-2)  //retira ultima virgula
				cTxtFG := SubStr(cTxtFG,1,Len(cTxtFG)-2)  //retira ultima virgula
			EndIf

			While !Empty(cTxtRI) .Or. !Empty(cTxtFG)
				SomaLinha()

				oPrint:Line(lin-10,0150,lin+60,0150)
				oPrint:Line(lin-10,1225,lin+60,1225)
				oPrint:Line(lin-10,2300,lin+60,2300)

			//Descricao dos riscos
				If !Empty(cTxtRI)
					oPrint:Say(lin,160,SubStr(cTxtRI,1,55),oFont08)
					cTxtRI := SubStr(cTxtRI,56,Len(cTxtRI))
				EndIf

			//Descricao das fontes geradoras
				If !Empty(cTxtFG)
					oPrint:Say(lin,1235,SubStr(cTxtFG,1,55),oFont08)
					cTxtFG := SubStr(cTxtFG,56,Len(cTxtFG))
				EndIf

			EndDo
			If nY == 5
				oPrint:Line(lin+60,150,lin+60,2300)
			Else
				oPrint:Line(lin+50,150,lin+50,2300)  //-10+60
			EndIf
		Next nX
		SomaLinha()

		//Cabecalho - Descricao das Funcoes Existentes / Trabalhadores
		SomaLinha(120)
		oPrint:Box(lin,150,lin+70,2300)
		oPrint:Line(lin,1650,lin+70,1650)
		SomaLinha(10)

		oPrint:Say(lin,500,STR0037,oFont10b) //"Funções Existentes"
		oPrint:Say(lin,1840,STR0038,oFont10b) //"Trabalhadores"

		SomaLinha(10)
		nLinR := 0

		cTxt := ""
		nQtdH := 0
		nQtdF := 0

		//Alimenta funcoes existentes
		nPos := aSCan(aSRJ,{|x| x[1] == aCC[nX]})
		While nPos > 0 .And. nPos <= Len(aSRJ) .And. ((aSRJ[nPos,1] == aCC[nX]))
			cTxt += AllTrim(aSRJ[nPos,3])+", "
			nQtdH += aSRJ[nPos,4]
			nQtdF += aSRJ[nPos,5]
			nPos++
		EndDo
		cTxt := SubStr(cTxt,1,Len(cTxt)-2)  //retira ultima virgula

		While !Empty(cTxt) .Or. nLinR < 2
			nLinR++
			SomaLinha()

			oPrint:Line(lin-10,0150,lin+60,0150)
			oPrint:Line(lin-10,1650,lin+60,1650)
			oPrint:Line(lin-10,2300,lin+60,2300)

			//Descricao dos riscos
			If !Empty(cTxt)
				oPrint:Say(lin,160,SubStr(cTxt,1,84),oFont08)
				cTxt := SubStr(cTxt,85,Len(cTxt))
			EndIf

			If nLinR == 1
				oPrint:Say(lin,1700,"- ("+StrZero(nQtdH,3)+") "+STR0039,oFont08) //"Masculino"
			ElseIf nLinR == 2
				oPrint:Say(lin,1700,"- ("+StrZero(nQtdF,3)+") "+STR0040,oFont08)		 //"Feminino"
			EndIf

		EndDo
		SomaLinha()
		oPrint:Line(lin,150,lin,2300)

		//Cabecalho - Medidas de Controle
		If Len(aMedCon) > 0
			SomaLinha(120)
			oPrint:Box(lin,150,lin+70,2300)
			SomaLinha(10)

			oPrint:Say(lin,750,STR0041,oFont10b) //"Medidas de Controle Existentes no Local de Trabalho"

			SomaLinha(10)
			For nY := 1 To Len(aMedCon)
				SomaLinha()

				oPrint:Line(lin-10,0150,lin+60,0150)
				oPrint:Line(lin-10,2300,lin+60,2300)
				oPrint:Say(lin,160,"- "+aMedCon[nY,2],oFont08)
			Next nY
			SomaLinha()
			oPrint:Line(lin,150,lin,2300)
		EndIf

		lin := 9999 //forca a quebra de pagina

	Next nX

	If aReturn[5] == 1
		oPrint:Preview()
	Else
		oPrint:Print()
	EndIf

	// Devolve a condicao original do arquivo principal

	RetIndex("TO0")
	Set Filter To
	(cAliasFun)->(dbCloseArea())

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} fChkLumRui
Encontra, entre os agentes luminosidade/ruido selecionados, o que
possui maior quantidade e atualiza array.

@type    function
@author  Felipe Nathan Welter
@since   27/04/2010
@sample  fChkLumRui({{001,002}}, {10.001,001,,,,{'',0,'',0}}, 'RUIDO', 0)

@param   aLumRui, Array, Contem lum./ruid. selecionados
@param   aNewTN0, Array, Adicionar no vetor aTN0
@param   cAgente, Cractere, Agente do risco
@param   nQtAgen, Numérico, Quantidade do agente

@return  aNewTN0, aArray, contem na posicao [1] array de luminosidade,
[2] array de ruido
/*/
//-------------------------------------------------------------------
Static Function fChkLumRui( aLumRui, aNewTN0, cAgente, nQtAgen )

	//Verifica Luminosidade
	If aSCan(aLumRui[1],{|x| x == cAgente}) > 0
		If aNewTN0[6,2] < nQtAgen
			aNewTN0[6,2] := nQtAgen
			aNewTN0[6,1] := cAgente
		EndIf
	EndIf
	//Verifica Ruido
	If aSCan(aLumRui[2],{|x| x == cAgente}) > 0
		If aNewTN0[6,4] < nQtAgen
			aNewTN0[6,4] := nQtAgen
			aNewTN0[6,3] := cAgente
		EndIf
	EndIf

Return aNewTN0

//-------------------------------------------------------------------
/*/{Protheus.doc} fR853LR
Apresenta tela para selecao de agentes validos como luminosidade e/ou
ruido para a impressao do relatorio

@type    function
@author  Felipe Nathan Welter
@since   27/04/2010
@sample  fR853LR()

@return  aNewTN0, aArray, contem na posicao [1] array de luminosidade,
[2] array de ruido
/*/
//-------------------------------------------------------------------
Static Function fR853LR()

	Local aCpL
	Local aCpR  // Definicao de arquivos temporarios
	Local aDBFR
	Local aDBFL
	Local aColor := NGCOLOR()
	Local aArray := { { /*Luminosidade*/ }, { /*Ruido*/ } }

	Local cQryINL := ''
	Local cQryINR := ''

	Local lRet := .F.

	Local nX := 0

	Local oDlg
	Local oPnlL
	Local oPnlR  // Objetos da tela
	Local oTempLUM
	Local oTempRUI // Objetos do FwTemporaryTable
	Local oSplitter

	// Variáveis para markbrowse
	Private cMarca := GetMark()

	Private oMarkL
	Private oMarkR

	// Criação da tabela temporária - Luminosidade
	If lImpLUM

		aDBFL := {;
			{ "OK", "C", 02, 0 },;
			{ "CODIGO", "C", TamSX3( 'TMA_AGENTE' )[ 1 ], 0 },;
			{ "DESCRI", "C", TamSX3( 'TMA_NOMAGE' )[ 1 ], 0 };
		}

		aCpL := {;
			{ "OK", NIL, "", "" },;
			{ "CODIGO", NIL, STR0042, "@!" },; // "Agente"
			{ "DESCRI", NIL, STR0043, "@!" }; // "Descrição"
		}

		cAliLUM := GetNextAlias()
		oTempLUM := FWTemporaryTable():New( cAliLUM, aDBFL )
		oTempLUM:AddIndex( "1", {"DESCRI"} )
		oTempLUM:AddIndex( "2", {"OK"} )
		oTempLUM:Create()

	EndIf

	// Criação da tabela temporária - Ruído
	If lImpRUI

		aDBFR := {;
			{ "OK", "C", 02, 0 },;
			{ "CODIGO", "C", TamSX3( 'TMA_AGENTE' )[ 1 ], 0 },;
			{ "DESCRI", "C", TamSX3( 'TMA_NOMAGE' )[ 1 ], 0 };
		}

		aCpR := {;
			{"OK", NIL, "", "" },;
			{ "CODIGO", NIL, STR0042, "@!" },; // "Agente"
			{ "DESCRI", NIL, STR0043, "@!" }; // "Descrição"
		}

		cAliRUI := GetNextAlias()
		oTempRUI := FWTemporaryTable():New( cAliRUI, aDBFR )
		oTempRUI:AddIndex( "1", {"DESCRI"} )
		oTempRUI:AddIndex( "2", {"OK"} )
		oTempRUI:Create()

	EndIf

	//Selecao de registros - Luminosidade

	If lImpLUM
	//leitura de itens pre-selecionados em SX1 secundario
		dbSelectArea("SX1")
		dbSetOrder(01)
		If dbSeek(cPerg2+"01")
			cQryINL := SX1->(X1_CNT01+X1_CNT02+X1_CNT03+X1_CNT04+X1_CNT05)
		EndIf

		cQuery := " SELECT '' AS OK, TMA.TMA_AGENTE AS CODIGO, TMA.TMA_NOMAGE AS DESCRI"
		cQuery += " FROM "+RetSqlName("TMA")+" TMA"
		cQuery += " WHERE TMA.TMA_GRISCO = '1'"  //Fisico
		cQuery += "       AND TMA_FILIAL = '"+ xFilial("TMA")+"'"+" AND TMA.D_E_L_E_T_ <> '*'"

		SqlToTrb(cQuery,aDBFL,cAliLUM)

		dbSelectArea(cAliLUM)
		dbSetOrder(01)
		dbGoTop()
		While !Eof()
			If (cAliLUM)->CODIGO $ cQryINL
				RecLock((cAliLUM),.F.)
				(cAliLUM)->OK := cMarca
				MsUnLock(cAliLUM)
			EndIf
			(cAliLUM)->(dbSkip())
		EndDo
	EndIf

	//Selecao de registros - Ruido
	If lImpRUI
	//leitura de itens pre-selecionados em SX1 secundario
		dbSelectArea("SX1")
		dbSetOrder(01)
		If dbSeek(cPerg2+"02")
			cQryINR := SX1->(X1_CNT01+X1_CNT02+X1_CNT03+X1_CNT04+X1_CNT05)
		EndIf

		cQuery := " SELECT '' AS OK, TMA.TMA_AGENTE AS CODIGO, TMA.TMA_NOMAGE AS DESCRI"
		cQuery += " FROM "+RetSqlName("TMA")+" TMA"
		cQuery += " WHERE TMA.TMA_GRISCO = '1'"  //Fisico
		cQuery += "       AND TMA_FILIAL = '"+ xFilial("TMA")+"'"+" AND TMA.D_E_L_E_T_ <> '*'"

		SqlToTrb(cQuery,aDBFR,cAliRUI)

		dbSelectArea(cAliRUI)
		dbSetOrder(01)
		dbGoTop()
		While !Eof()
			If (cAliRUI)->CODIGO $ cQryINR
				RecLock((cAliRUI),.F.)
				(cAliRUI)->OK := cMarca
				MsUnLock(cAliRUI)
			EndIf
			(cAliRUI)->(dbSkip())
		EndDo
	EndIf

	Define MsDialog oDlg Title OemToAnsi(STR0045) From 0,0 To 400,650 Of oMainWnd Color CLR_BLACK,RGB(225,225,225) Pixel //"Luminosidade/Ruido"

	oDlg:lEscClose := .F.

	oPnl1 := tPanel():New(00,00,,oDlg,,,,CLR_BLACK,CLR_WHITE,00,15,.F.,.F.)
	oPnl1:Align := CONTROL_ALIGN_TOP

	@ 004,006 Say STR0046+If(lImpLUM,If(lImpRUI,STR0047,STR0020),STR0024)+":"; //"Selecione Agentes válidos como "###"Luminosidade/Ruído"###"Luminosidade"###"Ruído"
	Pixel Of oPnl1 Color aColor[ 1 ]

	oPnl2 := tPanel():New(00,00,,oDlg,,,,CLR_BLACK,CLR_WHITE,00,20,.F.,.F.)
	oPnl2:Align := CONTROL_ALIGN_BOTTOM

	Define sButton From 5,250 Type 1 Enable Of oPnl2 Action EVAL({|| lRet := fVldLumRui(),If(lRet,oDlg:End(),Nil) })
	Define sButton From 5,280 Type 2 Enable Of oPnl2 Action EVAL({|| lRet := .F.,oDlg:End() })

	oSplitter := tSplitter():New( 0,0,oDlg,100,100,0 )
	oSplitter:Align := CONTROL_ALIGN_ALLCLIENT

	//Painel para selecao - Luminosidade
	If lImpLUM
		oPnlL := tPanel():New(00,00,,oSplitter,,,,,,80,00,.F.,.F.)
		oPnlL:Align := CONTROL_ALIGN_LEFT

		oPnlL1 := tPanel():New(00,00,,oPnlL,,,,,aColor[ 2 ],00,12,.F.,.F.)
		oPnlL1:Align := CONTROL_ALIGN_TOP

		@ 003,006 Say STR0020 Pixel Of oPnlL1 Color aColor[ 1 ] //"Luminosidade"

		dbSelectArea(cAliLUM)
		dbSetOrder(01)
		dbGoTop()
		oMarkL := MsSelect():New(cAliLUM,"OK",,aCpL,,@cMarca,{0,0,0,0},,,oPnlL)
		oMarkL:oBrowse:bLDblClick := { || f853MarkOne((cAliLUM)) }
		oMarkL:oBrowse:bAllMark := {||f853MarkAll(cAliLUM) }
		oMarkL:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
		If (cAliLUM)->(RecCount()) == 0
			oMarkL:oBrowse:Disable()
		EndIf
	EndIf

	//Painel para selecao - Ruido
	If lImpRUI
		oPnlR := tPanel():New(00,00,,oSplitter,,,,,,80,00,.F.,.F.)
		oPnlR:Align := CONTROL_ALIGN_RIGHT

		oPnlR1 := tPanel():New(00,00,,oPnlR,,,,,aColor[ 2 ],00,12,.F.,.F.)
		oPnlR1:Align := CONTROL_ALIGN_TOP

		@ 003,006 Say STR0024 Pixel Of oPnlR1 Color aColor[ 1 ] //"Ruído"

		dbSelectArea(cAliRUI)
		dbSetOrder(01)
		dbGoTop()
		oMarkR := MsSelect():New(cAliRUI,"OK",,aCpR,,@cMarca,{0,0,0,0},,,oPnlR)
		oMarkR:oBrowse:bLDblClick := { || f853MarkOne((cAliRUI)) }
		oMarkR:oBrowse:bAllMark := {||f853MarkAll(cAliRUI) }
		oMarkR:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
		If (cAliRUI)->(RecCount()) == 0
			oMarkR:oBrowse:Disable()
		EndIf
	EndIf

	Activate MsDialog oDlg Centered

	//Grava SX1 secundario - Luminosidade
	If lImpLUM .And. lRet
		cQryINL := ""
		dbSelectArea(cAliLUM)
		dbSetOrder(02)
		dbSeek(cMarca,.T.)
		While (cAliLUM)->(!Eof()) .And. (cAliLUM)->OK == cMarca
			cQryINL += (cAliLUM)->CODIGO+"/"
			aAdd(aArray[1],(cAliLUM)->CODIGO)  //adiciona no retorno
			dbSelectArea(cAliLUM)
			dbSkip()
		EndDo
		cQryINL := SubStr(cQryINL,1,Len(cQryINL)-1)

		dbSelectArea("SX1")
		dbSetOrder(01)
		If dbSeek(cPerg2+"01")
			RecLock("SX1",.F.)
			For nX := 1 To 5
				&("SX1->X1_CNT"+StrZero(nX,2)) := Left(cQryINL,60)
				cQryINL := SubStr(cQryINL,61,Len(cQryINL))
			Next nX
		EndIf
	EndIf

	//Grava SX1 secundario - Ruido
	If lImpRUI .And. lRet
		cQryINR := ""
		dbSelectArea(cAliRUI)
		dbSetOrder(02)
		dbSeek(cMarca,.T.)
		While (cAliRUI)->(!Eof()) .And. (cAliRUI)->OK == cMarca
			cQryINR += (cAliRUI)->CODIGO+"/"
			aAdd(aArray[2],(cAliRUI)->CODIGO)  //adiciona no retorno
			dbSelectArea(cAliRUI)
			dbSkip()
		EndDo
		cQryINR := SubStr(cQryINR,1,Len(cQryINR)-1)

		dbSelectArea("SX1")
		dbSetOrder(01)
		If dbSeek(cPerg2+"02")
			RecLock("SX1",.F.)
			For nX := 1 To 5
				&("SX1->X1_CNT"+StrZero(nX,2)) := Left(cQryINR,60)
				cQryINR := SubStr(cQryINR,61,Len(cQryINR))
			Next nX
		EndIf
	EndIf

	If lImpLUM
		oTempLUM:Delete()
	EndIf

	If lImpRUI
		oTempRUI:Delete()
	EndIf

Return aArray

//-------------------------------------------------------------------
/*/{Protheus.doc} f853MarkOne
Funcao chamada no duplo clique em um elemento no markbrowse

@type    function
@author  Felipe Nathan Welter
@since   12/08/2009
@sample  f853MarkOne( 'XXX' )
@param   cAlias, Caractere, param_descr
@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function f853MarkOne( cAlias )

	dbSelectArea(cAlias)
	dbSetOrder(01)
	RecLock((cAlias),.F.)
	(cAlias)->OK := If(IsMark('OK',cMarca),"  ",cMarca)
	MsUnLock(cAlias)

	If lImpLUM
		oMarkL:oBrowse:Refresh()
	EndIf
	If lImpRUI
		oMarkR:oBrowse:Refresh()
	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} f853MarkAll
Grava marca em todos os registros no markbrowse (inverte)

@type    function
@author  Felipe Nathan Welter
@since   12/08/2009
@sample  f853MarkOne( 'XXX' )
@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function f853MarkAll( cAlias )

	dbSelectArea(cAlias)
	dbSetOrder(01)
	dbGoTop()
	While (cAlias)->(!Eof())
		RecLock((cAlias),.F.)
		(cAlias)->OK := If(IsMark('OK',cMarca),"  ",cMarca)
		MsUnLock(cAlias)
		dbSkip()
	End
	dbGoTop()
	MsUnLock(cAlias)

	If lImpLUM
		oMarkL:oBrowse:Refresh()
	EndIf
	If lImpRUI
		oMarkR:oBrowse:Refresh()
	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} fVldLumRui
Valida se foram selecionados ao menos uma luminosidade/ruido

@type    function
@author  Felipe Nathan Welter
@since   12/08/2009
@sample  fVldLumRui()
@return  lRet, Lógico, Verdadeiro, se hhouve seleção
/*/
//-------------------------------------------------------------------
Static Function fVldLumRui()

	Local aArea := GetArea()
	Local lRet := .T.
	Local cMsg := ""

	If lImpLUM
		aAreaLUM := (cAliLUM)->(GetArea())
		dbSelectArea(cAliLUM)
		dbSetOrder(02)
		If !dbSeek(cMarca)
			cMsg += STR0020 //"Luminosidade"
		EndIf
		RestArea(aAreaLUM)
	EndIf

	If lImpRUI
		aAreaRUI := (cAliRUI)->(GetArea())
		dbSelectArea(cAliRUI)
		dbSetOrder(02)
		If !dbSeek(cMarca)
			cMsg += If(!Empty(cMsg),"/","") +STR0024 //"Ruído"
		EndIf
		RestArea(aAreaRUI)
	EndIf

	If !Empty(cMsg)
		Help(" ",1,STR0048,,STR0049+CRLF+cMsg+".",4,5) //"ATENÇÃO"###"Deve ser selecionado ao menos um agente"
		lRet := .F.
	EndIf

	RestArea(aArea)

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@type    function
@author  Felipe Nathan Welter
@since   26/04/10
@sample  Somalinha( 25 )
@param   nLin__, Numérico, Linha atual
@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function Somalinha(nLin__)

	If ValType(nLin__) == "N"
	    Lin += nLin__
	Else
		Lin += 60
	Endif
    If Lin > 3000
	    Lin := 300
	    If nPaginaG > 0
		    oPrint:EndPage()
		EndIf
		oPrint:StartPage()
		nPaginaG++
		If nPaginaG != 1
			oPrint:Say(100,2320,Alltrim(Str(nPaginaG,10)),oFont08)
		EndIf
	EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT853SX1
Cria SX1 no MDT853 e MDT8532

@type    function
@author  Guilherme Benkendorf
@since   04/12/2013
@sample  MDT853SX1( 'MDT853    ' )
@param   cPerg indica o grupo de perguntas.
@return  Nil, Sempre nulo
/*/
//---------------------------------------------------------------------
Static Function MDT853SX1( cPerg , cPerg2 )

	Local aPerg := {}
	Local aPerg2:= {}

	lSigaMdtPS := If(Type("lSigaMdtPS") == "L", lSigaMdtPs, If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. ) )

	If lSigaMdtPs
		cPerg := "MDT853PS  "
	EndIf

Return Nil
