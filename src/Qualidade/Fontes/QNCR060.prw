/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "TOTVS.CH"
#INCLUDE "QNCR060.CH"
#INCLUDE "Report.CH"

Static lQLTDispSVR := Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QNCR060  ³ Autor ³ Aldo Marini Junior    ³ Data ³ 31.07.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Plano de Acao  Formulario                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QNCR060(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function QNCR060(nRegImp)

	Private nLastKey := 0
	Private cPerg    := "QNR060"
	Private Titulo	 := OemToAnsi(STR0007)		//"PLANO DE ACAO"
	Private nLig    := 0
	Private nTamanho:= "M"
	Private nPag    := 1                              
	Private lPagPrint := .T.

	lQLTDispSVR   := Iif(lQLTDispSVR == Nil, FindFunction("QLTDispSVR"), lQLTDispSVR)

	If !lQLTDispSVR .OR. !QLTDispSVR("manufacturing.sv.qnc.actionplan",,,,QLTTReportsManager():mountDefaultParams(cPerg, .F.))

		Default nRegImp := 0

		INCLUI := .F.	// Utilizado devido algumas funcoes de retorno de descricao/nome
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis utilizadas para parametros                         ³
		//³ mv_par01        //  Filial  De                               ³
		//³ mv_par02        //  Filial  Ate                              ³
		//³ mv_par03        //  Ano De                                   ³
		//³ mv_par04        //  Ano Ate                                  ³
		//³ mv_par05        //  Plano de Acao                            ³
		//³ mv_par06        //  Plano de Acao                            ³
		//³ mv_par07        //  Revisao De                               ³
		//³ mv_par08        //  Revisao Ate                              ³
		//³ mv_par09        //  Etapas 1-Pendentes/2-Baixadas/3-Ambas    ³
		//³ mv_par10        //  Acoes 1-Corretiva/2-Preventiva/3-Melhoria/4-Ambas
		//³ mv_par11        //  Status Acoes 1-Registrada/2-Em Analise/3-Procede/4-Nao Procede/5-Cancelada/6-Ambas
		//³ mv_par12        //  FNC Relacionadas 1-Sim/2-Nao             |
		//³ mv_par13        //  Visualiza antes  1-Sim/2-Nao             |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If nRegImp == 0
																																																													
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica as perguntas selecionadas                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			lOkPrint := pergunte("QNR060",.T.)

			If !lOkPrint
				Return(.F.)
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cFilDe   := mv_par01
			cFilAte  := mv_par02
			cAnoDe   := mv_par03
			cAnoAte  := mv_par04
			cAcaoDe  := mv_par05
			cAcaoAte := mv_par06
			cRevDe   := mv_par07
			cRevAte  := mv_par08
			nEtapa   := mv_par09
			nAcao    := mv_par10
			cStatus  := mv_par11
			nRelac   := mv_par12
			nView    := mv_par13

		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			pergunte("QNR060",.F.)
			cFilDe   := QI3->QI3_FILIAL
			cFilAte  := QI3->QI3_FILIAL
			cAnoDe   := QI3->QI3_ANO
			cAnoAte  := QI3->QI3_ANO
			cAcaoDe  := QI3->QI3_CODIGO
			cAcaoAte := QI3->QI3_CODIGO
			cRevDe   := QI3->QI3_REV
			cRevAte  := QI3->QI3_REV
			nEtapa   := 3
			nAcao    := 4
			cStatus  := QI3->QI3_STATUS
			nRelac   := 1
			nView    := 1
		
		Endif

		RptStatus({|lEnd| QNCR060Imp(@lEnd)},Titulo)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Volta o registro correspondente ao Plano de Acao quando a    ³
		//³ impressao for selecionada via cadastro.                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nRegImp > 0
			dbSelectArea("QI3")
			dbSetOrder( 1 )
			dbGoTo(nRegImp)
		Endif

		dbSelectArea( "QI2" )
		dbSetOrder( 1 )
		
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QNCR060Imp³ Autor ³ Aldo Marini Junior    ³ Data ³ 08.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o Relatorio                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³QNCR060Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR060                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QNCR060Imp(lEnd)
Local nColT    := 0
Local cTxtDet  := ""
Local nLig1    := 0
Local nLig2    := 0
Local lPend    := .F.
Local cFiltro  := "" 
Local cIndex1  := CriaTrab( Nil, .f. )
Local nT
Local nA
Local cCliente := "" 
Local cForn    := "" 
Local nLin     := 0
Local aUsrMat	:= QNCUSUARIO()
Local cMatFil  	:= aUsrMat[2]
Local cMatCod	:= aUsrMat[3]
Local lSigiloso := .f.

Private aTipQI3 :=QNCCombo ("QI3_TIPO") //{OemToAnsi(STR0008),OemToAnsi(STR0009),OemToAnsi(STR0010)} "Corretiva" ### "Preventiva" ### "Melhoria"
Private aStatus := {OemtoAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013),OemToAnsi(STR0014),OemToAnsi(STR0015)}	// "Registrada" ### "Em Analise" ### "Procede" ### "Nao Procede" ### "Cancelada"
Private oFont08, oFont10, oFont15, oFont10n, oFont20
Private oQPrint
Private lFirst   := .T.
Private lInicial := .F.
Private lFirQB	 := .F.
Private aCausas  := {}
Private aFichas  := {}
Private aEtapas  := {}

Private cFileLogo  := ""
Private cFilOld    := cFilAnt
Private cNomFilial := ""
Private lTMKPMS    := If(GetMv("MV_QTMKPMS",.F.,1) == 1,.F.,.T.)//Integracao do QNC com TMK e PMS: 1-Sem integracao,2-TMKxQNC,3-QNCxPMS,4-TMKxQNCxPMS ³

oFont06	:= TFont():New("Courier New",06,08,,.T.,,,,.T.,.F.)
oFont10	:= TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
oFont10n:= TFont():New("Courier New",10,10,,.T.,,,,.T.,.F.)
oFont15	:= TFont():New("Courier New",15,15,,.T.,,,,.T.,.F.)
oFont20	:= TFont():New("Courier New",20,20,,.T.,,,,.T.,.F.)
// 5o. Bold
// 9o. Italico
//10o. Underline

dbSelectArea( "QI3" )
dbSetOrder( 1 )

cFiltro:= '( QI3->QI3_ANO >= "'+ cAnoDe  +'" ) .And. '
cFiltro+= '( QI3->QI3_ANO <= "'+ cAnoAte +'" ) .And. '
cFiltro+= '( QI3->QI3_REV >= "'+ cRevDe  +'" ) .And. '
cFiltro+= '( QI3->QI3_REV <= "'+ cRevAte +'" ) .And. '
If !lTMKPMS
	cFiltro+= '( Right(Alltrim(QI3->QI3_CODIGO),4) + Left(QI3->QI3_CODIGO,15) >= "'+ Right(Alltrim(cAcaoDe ),4) + Left(cAcaoDe ,15) + '" ) .And. '
	cFiltro+= '( Right(Alltrim(QI3->QI3_CODIGO),4) + Left(QI3->QI3_CODIGO,15) <= "'+ Right(Alltrim(cAcaoAte),4) + Left(cAcaoAte,15) + '" ) .And. '
Else
	cFiltro+= '( Right(Alltrim(QI3->QI3_CODIGO),4) + Left(QI3->QI3_CODIGO,11) >= "'+ Right(Alltrim(cAcaoDe ),4) + Left(cAcaoDe ,11) + '" ) .And. '
	cFiltro+= '( Right(Alltrim(QI3->QI3_CODIGO),4) + Left(QI3->QI3_CODIGO,11) <= "'+ Right(Alltrim(cAcaoAte),4) + Left(cAcaoAte,11) + '" ) .And. '
Endif
cFiltro+= ' QI3->QI3_STATUS $ "'+ cStatus + '"'

QI3->(DbSeek(xFilial("QI3")))
dbSeek(IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilDe) + cAnoDe + cAcaoDe + cRevDe,.T.)
cInicio  := "QI3->QI3_FILIAL + QI3->QI3_ANO + QI3->QI3_CODIGO + QI3->QI3_REV"
cFim     := IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilAte) + cAnoAte + cAcaoAte + cRevAte

cFileLogo  := "LGRL"+SM0->M0_CODIGO
cFilOld    := QI3->QI3_FILIAL

If (FWModeAccess("QI3") == "C")
	cFileLogo += FwCodFil()+".BMP"
Else
	cFileLogo += QI3->QI3_FILIAL+".BMP"
Endif

If !File( cFileLogo )
	cFileLogo := "LGRL"+SM0->M0_CODIGO+".BMP" // Empresa
Endif

While QI3->(!EOF()) .And. &cInicio <= cFim
	If !&(cFiltro)
		QI3->(DbSkip())
		Loop
	EndIf

		lPend:= .F.
		cCliente:=""

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 	//³ Consiste o tipo de Plano de Acao                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nAcao <> 4 .And. Val(QI3->QI3_TIPO) <> nAcao
		dbSkip()
		Loop
	Endif

	If nEtapa == 1 // Pendente
		If QI5->(DbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV))
			While QI5->(!Eof()) .And. QI5->QI5_FILIAL+QI5->QI5_CODIGO+QI5->QI5_REV == QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV
				If QI5->QI5_STATUS <> "4"
					lPend:= .T.
					Exit
				EndIf
				QI5->(DbSkip())
			EndDo		
		EndIf			
	ElseIf nEtapa == 2 // Baixada
		If QI5->(DbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV))
			While QI5->(!Eof()) .And. QI5->QI5_FILIAL+QI5->QI5_CODIGO+QI5->QI5_REV == QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV
				If QI5->QI5_STATUS == "4"
					lPend:= .T.
					Exit
				EndIf
				QI5->(DbSkip())
			EndDo		
		EndIf			
	Else 
		lPend:= .T.
	EndIf

	If !lPend
		DbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 	//³ Quebra de Pagina e imprime cabecalho                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLig := 2900
	nPag := 1

	cNomFilial := AllTrim(QA_CHKFIL(QI3->QI3_FILIAL,,.T.))
	If !Empty(cFilOld) .And. cFilOld <> QI3->QI3_FILIAL
        cFilOld    := QI3->QI3_FILIAL
		cFileLogo := "LGRL"+SM0->M0_CODIGO+QI3->QI3_FILIAL+".BMP"
		If !File( cFileLogo )
			cFileLogo := "LGRL"+SM0->M0_CODIGO+".BMP" // Empresa
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se Plano eh Sigiloso. Somente Responsavel (plano e etapas) pode Imprimir   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	lSigiloso := .f.
	If QI3->QI3_SIGILO == "1"	
		If cMatFil+cMatCod <> QI3->QI3_FILMAT+QI3->QI3_MAT 
			lSigiloso := .T.
			QI5->(dbSetOrder(1))
			If QI5->(dbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV))
				While QI5->(!Eof()) .And. QI5->QI5_FILIAL+QI5->QI5_CODIGO+QI5->QI5_REV == QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV
					If QI5->QI5_FILMAT + QI5->QI5_MAT == cMatFil + cMatCod 
						lSigiloso := .f.
						Exit
					Endif
					QI5->(dbSkip())
				Enddo
			Endif							
		Endif
	Endif
	
	If lSigiloso
		U_QNCR060LIN("T",nLig,30,OemToAnsi(STR0040),oFont10n)		// "Dados Sigilosos"
		nLig += 40
		U_QNCR060LIN("B",,,,,,OemToAnsi(STR0040),nLig,30,nLig+100,2350)	// "Dados Sigilosos"
		nLig += 40
		U_QNCR060LIN("T",nLig,50,OemToAnsi(STR0041 + AllTrim(Posicione("QAA",1, QI3->QI3_FILMAT+QI3->QI3_MAT,"QAA_NOME")) + STR0042 ),oFont10)	// "Acesso permitido a " ### " e aos responsáveis pelas etapas"
		nLig += 40
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a Descricao Detalhada                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cTxtDet  := MSMM(QI3->QI3_PROBLE)
		If !Empty(cTxtDet)
			If nLig+110 >= 2900
				nLig := 2900
			Endif

			aTxtDet := {}
			Q_MemoArray(cTxtDet, @aTxtDet, 100)
			
			If mv_par14 == 1
				If Len(aTxtDet) > 0
					U_QNCR060LIN("T",nLig,30,OemToAnsi(STR0023),oFont10n) // "Descricao Detalhada"
					nLig += 110
					nLig2 := 540+(Len(aTxtDet)*40)+200
					nLig2 := If(nLig2>=2900,2930,nLig2)
					nLig2 += 180                   
					U_QNCR060LIN("B",,,,,,OemToAnsi(STR0023),nLig,30,nLig2,2350)// "Descricao Detalhada"
					nLig1 := nLig 	// Pula de 40 em 40
					nLig += 20
					nColT := 1
					For nT:=1 to Len(aTxtDet)
						U_QNCR060LIN("T",nLig,50,aTxtDet[nT],oFont10,Len(aTxtDet)-nT+1,OemToAnsi(STR0023)) // "Descricao Detalhada"
						nLig+=40
					Next
					nLig+=40
				Endif
			Else			
				If Len(aTxtDet) > 0
					U_QNCR060LIN("T",nLig,30,OemToAnsi(STR0023),oFont10n) // "Descricao Detalhada"
					nLig += 40
					nLig2 := 540+(Len(aTxtDet)*40)+80
					nLig2 := If(nLig2>=2900,2930,nLig2)
					U_QNCR060LIN("B",,,,,,OemToAnsi(STR0023),nLig,30,nLig2,2350)// "Descricao Detalhada"
					nLig1 := nLig 	// Pula de 40 em 40
					nLig += 20
					nColT := 1
					For nT:=1 to Len(aTxtDet)
						U_QNCR060LIN("T",nLig,50,aTxtDet[nT],oFont10,Len(aTxtDet)-nT+1,OemToAnsi(STR0023)) // "Descricao Detalhada"
						nLig+=40
					Next
					nLig+=40
				Endif
			Endif
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a Descricao Resumida das Possiveis Causas            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If QI6->(dbSeek( QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV ))
			aCausas := {}
			While QI6->(!Eof()) .And. QI6->QI6_FILIAL + QI6->QI6_CODIGO + QI6->QI6_REV == QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV
				aAdd(aCausas,{QI6->QI6_SEQ,FQNCNTAB("1",QI6->QI6_CAUSA)})
				QI6->(dbSkip())
			Enddo
			If Len(aCausas) > 0
				If nLig+170 >= 2900
					nLig := 2900
				Endif

				nLig += 50
				U_QNCR060LIN("T",nLig,30,OemToAnsi(STR0024),oFont10n)	// "Possiveis Causas"
				nLig += 40
				nLigf := nLig+(40*Len(aCausas))+80
				nLigf := If(nLigf>=2900,2930,nLigf)
				U_QNCR060LIN("B",,,,,,,nLig,30,nLigf,2350)

				nLig1 := nLig
				nLig += 20

				U_QNCR060LIN("T",nLig,  40,OemToAnsi(STR0001),oFont10n)	// "Sequencia"
				U_QNCR060LIN("T",nLig, 310,OemToAnsi(STR0002),oFont10n)	// "Descricao"

				nLig += 40
				U_QNCR060LIN("L",,,,,,,nLig ,30 ,nLig ,2350)
				U_QNCR060LIN("L",,,,,,,nLig1,300,nLigf, 300)
																	
				nLig1 := nLig 	// Pula de 40 em 40
				nLig += 20
				nColT := 1

				For nA:=1 to Len(aCausas)

					U_QNCR060LIN("T",nLig,  50,aCausas[nA,1],oFont10,Len(aCausas)-nA+1,OemToAnsi(STR0024),,,,,.T.)	// "Possiveis Causas"
					U_QNCR060LIN("T",nLig, 310,aCausas[nA,2],oFont10,Len(aCausas)-nA+1,OemToAnsi(STR0024),,,,,.T.)	// "Possiveis Causas"
										
					nLig+=40
				Next
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime as Etapas das Acoes                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF QI5->(dbSeek( QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV ))
			aEtapas := {}
			While QI5->(!Eof()) .And. QI5->QI5_FILIAL + QI5->QI5_CODIGO + QI5->QI5_REV == QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV
				IF nEtapa == 3 .Or. ;
					( nEtapa == 1 .And. QI5->QI5_STATUS <> "4" ) .Or. ;
					( nEtapa == 2 .And. QI5->QI5_STATUS == "4" ) 
					aAdd(aEtapas,{	QI5->QI5_FILMAT,QI5->QI5_MAT,QI5->QI5_PRAZO,QI5->QI5_REALIZ,QI5->QI5_DESCRE})
				Endif
				QI5->(dbSkip())
			Enddo

			If Len(aEtapas) > 0
				If nLig+170 >= 2900
					nLig := 2900
				Endif

				nLig += 50
				U_QNCR060LIN("T",nLig,30,OemToAnsi(STR0025),oFont10n)	// "Acoes"
				nLig += 40
				nLin := 0
				For nA:=1 to Len(aEtapas)
					If Len(Alltrim(aEtapas[nA,5])) > 40
						nLin++
					Endif
				Next
				nLigf := nLig+(40*(Len(aEtapas)+nLin))+80
				nLigf := If(nLigf>=2900,2930,nLigf)
				U_QNCR060LIN("B",,,,,,,nLig,30,nLigf,2350)

				nLig1 := nLig
				nLig += 20

				U_QNCR060LIN("T",nLig,  40,OemToAnsi(STR0021),oFont10n)	// "Responsavel"
				U_QNCR060LIN("T",nLig,  925,OemToAnsi(STR0034),oFont10n)	// "Previsao"
				U_QNCR060LIN("T",nLig, 1175,OemToAnsi(STR0035),oFont10n)	// "Conclusao"
				U_QNCR060LIN("T",nLig, 1425,OemToAnsi(STR0002),oFont10n)	// "Descricao"
																	
				nLig += 40
				U_QNCR060LIN("L",,,,,,,nLig ,30  ,nLig ,2350)
				U_QNCR060LIN("L",,,,,,,nLig1,915 ,nLigf, 915)
				U_QNCR060LIN("L",,,,,,,nLig1,1165,nLigf,1165)
				U_QNCR060LIN("L",,,,,,,nLig1,1415,nLigf,1415)

				nLig1 := nLig 	// Pula de 40 em 40
				nLig += 20
				nColT := 1

				For nA:=1 to Len(aEtapas)
					U_QNCR060LIN("T",nLig,  40,PADR(QA_NUSR(aEtapas[nA,1],aEtapas[nA,2],.F.),37),oFont10,Len(aEtapas)-nA+1,OemToAnsi(STR0025),,,,,,,.T.)	// "Acoes"
					U_QNCR060LIN("T",nLig, 925,PADR(DTOC(aEtapas[nA,3]),10),oFont10,Len(aEtapas)-nA+1,OemToAnsi(STR0025),,,,,,,.T.)	// "Acoes"
					U_QNCR060LIN("T",nLig,1175,PADR(DTOC(aEtapas[nA,4]),10),oFont10,Len(aEtapas)-nA+1,OemToAnsi(STR0025),,,,,,,.T.)	// "Acoes"
					U_QNCR060LIN("T",nLig,1425,PADR(aEtapas[nA,5],40),oFont10,Len(aEtapas)-nA+1,OemToAnsi(STR0025),,,,,,,.T.)	// "Acoes"
					If Len(Alltrim(aEtapas[nA,5])) > 40
						U_QNCR060LIN("T",nLig+=40,1425,SUBSTR(aEtapas[nA,5],41,10),oFont10,Len(aEtapas)-nA+1,OemToAnsi(STR0025),,,,,,,.T.)	// "Acoes"
					Endif							
					nLig+=40
				Next
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a Descricao do Resultado Esperado                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cTxtDet  := MSMM(QI3->QI3_RESESP)
		If !Empty(cTxtDet)
			If nLig+110 >= 2900
				nLig := 2900
			Endif

			aTxtDet := {}
			Q_MemoArray(cTxtDet, @aTxtDet, 100)

			If Len(aTxtDet) > 0
				nLig += 50
				U_QNCR060LIN("T",nLig,30,OemToAnsi(STR0027),oFont10n,,OemToAnsi(STR0027)) // "Resultado Esperado"
				nLig += 40
				nLig2:= nLig+(Len(aTxtDet)*40)+80
				nLig2:= If(nLig2>=2900,2930,nLig2)
				U_QNCR060LIN("B",,,,,,OemToAnsi(STR0027),nLig,30,nLig2,2350) // "Resultado Esperado"
				nLig1 := nLig 	// Pula de 40 em 40
				nLig += 20
				nColT := 1
				For nT:=1 to Len(aTxtDet)
					U_QNCR060LIN("T",nLig,50,aTxtDet[nT],oFont10,Len(aTxtDet)-nT+1,OemToAnsi(STR0027)) // "Resultado Esperado"
					nLig+=40
				Next
				nLig+=40
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a Descricao do Resultado Atingido                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cTxtDet  := MSMM(QI3->QI3_RESATI)
		If !Empty(cTxtDet)
			If nLig+110 >= 2900
				nLig := 2900
			Endif

			aTxtDet := {}
			Q_MemoArray(cTxtDet, @aTxtDet, 100)

			If Len(aTxtDet) > 0
				nLig += 50
				U_QNCR060LIN("T",nLig,30,OemToAnsi(STR0028),oFont10n,,OemToAnsi(STR0028)) // "Resultado Atingido"
				nLig += 40
				nLig2:= nLig+(Len(aTxtDet)*40)+80
				nLig2:= If(nLig2>=2900,2930,nLig2)
				U_QNCR060LIN("B",,,,,,OemToAnsi(STR0028),nLig,30,nLig2,2350) // "Resultado Atingido"
				nLig1 := nLig 	// Pula de 40 em 40
				nLig += 20
				nColT := 1
				For nT:=1 to Len(aTxtDet)
					U_QNCR060LIN("T",nLig,50,aTxtDet[nT],oFont10,Len(aTxtDet)-nT+1,OemToAnsi(STR0028)) // "Resultado Atingido"
					nLig+=40
				Next
				nLig+=40
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime as Fichas de Ocorrencias/Nao-conformidades Relacionadas ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nRelac == 1	// Sim
			If QI9->(dbSeek(QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV))
				aFichas := {}
				If nLig+110 >= 2900
					nLig := 2900
				Endif

				While QI9->(!Eof()) .And. QI9->QI9_FILIAL + QI9->QI9_CODIGO + QI9->QI9_REV == QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV
					IF QI2->(dbSeek(QI9->QI9_FILIAL+Right(QI9->QI9_FNC,4)+QI9->QI9_FNC+QI9->QI9_REVFNC))
						aAdd(aFichas,{QI2->QI2_FNC,QI2->QI2_REV,QI2->QI2_FILMAT,QI2->QI2_MAT,QI2->QI2_OCORRE,QI2->QI2_DESCR,QI2->QI2_CODCLI,QI2->QI2_CODFOR,QI2->QI2_CONTAT })
					Endif
					QI9->(dbSkip())
				Enddo
				If Len(aFichas) > 0
					nLig += 50
					U_QNCR060LIN("T",nLig,30,OemToAnsi(STR0029),oFont10n)	// "Ficha Ocorrencias/Nao-conformidades Relacionadas"
					nLig += 40
					nLin := 0
					For nA:=1 to Len(aFichas)
						If Len(Alltrim(aFichas[nA,6])) > 40
							nLin++
						Endif
					Next
					nLigf := nLig+(40*(Len(aFichas)+nLin))+80
					nLigf := If(nLigf>=2900,2930,nLigf)
					U_QNCR060LIN("B",,,,,,,nLig,30,nLigf,2350)

					nLig1 := nLig
					nLig += 20

					U_QNCR060LIN("T",nLig,  40,OemToAnsi(STR0004),oFont10n)	// "No. FNC Rv"
					U_QNCR060LIN("T",nLig, 370,OemToAnsi(STR0005),oFont10n)	// "Originador"
					U_QNCR060LIN("T",nLig,1175,OemToAnsi(STR0006),oFont10n)	// "Abertura"
					U_QNCR060LIN("T",nLig,1425,OemToAnsi(STR0033),oFont10n)	// "Descricao"
																	
					nLig += 40
					U_QNCR060LIN("L",,,,,,,nLig,30,nLig,2350)

					U_QNCR060LIN("L",,,,,,,nLig1, 360,nLigf, 360)
					U_QNCR060LIN("L",,,,,,,nLig1,1165,nLigf,1165)
					U_QNCR060LIN("L",,,,,,,nLig1,1415,nLigf,1415)
																	
					nLig1 := nLig 	// Pula de 40 em 40
					nLig += 20
					nColT := 1

					For nA:=1 to Len(aFichas)
						U_QNCR060LIN("T",nLig,  40,Transform(aFichas[nA,1],PesqPict("QI2","QI2_FNC"))+" "+aFichas[nA,2],oFont06 ,Len(aFichas)-nA+1,OemToAnsi(STR0029),,,,,,.T.)	// "Ficha Ocorrencias/Nao-conformidades Relacionadas"
						U_QNCR060LIN("T",nLig, 370,Padr(QA_NUSR(aFichas[nA,3],aFichas[nA,4],.F.),37),oFont10,Len(aFichas)-nA+1,OemToAnsi(STR0029),,,,,,.T.)	// "Ficha Ocorrencias/Nao-conformidades Relacionadas"
						U_QNCR060LIN("T",nLig,1175,PADR(DTOC(aFichas[nA,5]),10),oFont10,Len(aFichas)-nA+1,OemToAnsi(STR0029),,,,,,.T.)	// "Ficha Ocorrencias/Nao-conformidades Relacionadas"
						U_QNCR060LIN("T",nLig,1425,PADR(aFichas[nA,6],40),oFont10,Len(aFichas)-nA+1,OemToAnsi(STR0029),,,,,,.T.)	// "Ficha Ocorrencias/Nao-conformidades Relacionadas"
						If Len(Alltrim(aFichas[nA,6])) > 40
							U_QNCR060LIN("T",nLig+=40,1425,SUBSTR(aFichas[nA,6],41,10),oFont10,Len(aFichas)-nA+1,OemToAnsi(STR0029),,,,,,.T.)	// "Ficha Ocorrencias/Nao-conformidades Relacionadas"
						Endif
						nLig+=40
					Next 
					If mv_par14 == 1 .and. 	!lFirQB 
						dbSelectArea("SA1")
						dbSetOrder(1)
						If SA1->(DbSeek(xFilial() + aFichas[1,7]))
						cCliente := SA1->A1_NOME
						Endif
						
						dbSelectArea("SA2")
						dbSetOrder(1)
						If SA2->(DbSeek(xFilial() + aFichas[1,8]))
						cForn := SA2->A2_NOME
						Endif
									
						//Detalhes do Cadastro Outros - FNC
						oQPrint:Box(490, 30, 740, 2350 )
						
						oQPrint:Say(495, 40,OemToAnsi(STR0036),oFont06 )//"Cliente"	   
						oQPrint:Say(535, 40,aFichas[1,7]+" "+cCliente,oFont10 )
						oQPrint:Line( 567, 30, 567, 2350 )
						
						oQPrint:Say(575, 40,OemToAnsi(STR0037),oFont06 )//"Fornecedor"
						oQPrint:Say(615, 40,aFichas[1,8]+" "+cForn,oFont10 )
						oQPrint:Line( 650, 30, 650, 2350 )
						
						oQPrint:Say(660, 40,OemToAnsi(STR0038),oFont06 )//"Contato"		
						oQPrint:Say(700, 40,PADR(aFichas[1,9],100),oFont10 )
				
					Endif
					
				Endif
			Endif
		Endif	

	Endif
	nLig+=40
	oQPrint:Say(nLig,2200,OemToAnsi(STR0003)+Transform(nPag,"@e 99"),oFont06 )	// "Pag."
	nPag++
	lPagPrint := .F.
	oQPrint:EndPage()
	dbSelectArea("QI3")
	dbSkip()
Enddo


If oQPrint <> NIL
	oQPrint:EndPage() // Finaliza a pagina
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve as ordens originais dos arquivos                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("QI3")
Set Filter to

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indices de trabalho                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cIndex1 += OrdBagExt()
Delete File &(cIndex1)

If oQPrint <> NIL
	If nView == 1
		oQPrint:Preview()  // Visualiza antes de imprimir
	Else
	   oQPrint:Print() // Imprime direto na impressora default Protheus
	Endif
Endif

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QNCR060Imp³ Autor ³ Aldo Marini Junior    ³ Data ³ 31.07.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o Cabecalho                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³U_QNCR060LIN(cTipo,nLin,nCol,cTexto,oFontT,nBoxTam,cTextCab,  ³±±
±±³          ³nBoxTamLI,nBoxTamCI,nBoxTamLF,nBoxTamCF,lCabec)             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1-Caracter definindo "L"-Linha","T"-Texto,"B"-Box      ³±±
±±³          ³ ExpN1-Numerico definindo linha a ser impressa              ³±±
±±³          ³ ExpN2-Numerico definindo coluna a ser impressa             ³±±
±±³          ³ ExpC2-Caracter definindo texto a ser impresso              ³±±
±±³          ³ ExpO1-Objeto contendo o fonte da letra a ser impressa      ³±±
±±³          ³ ExpN3-Numerico definindo No.Linha faltantes para o Box     ³±±
±±³          ³ ExpC3-Caracter definindo o Texto do cabecalho qdo quebrar  ³±±
±±³          ³ ExpN4-Numerico definindo Linha Inicial do Box              ³±±
±±³          ³ ExpN5-Numerico definindo Coluna Inicial do Box             ³±±
±±³          ³ ExpN6-Numerico definindo Linha final do Box                ³±±
±±³          ³ ExpN7-Numerico definindo Coluna final do BOX               ³±±
±±³          ³ ExpL1-Logico definindo se imprime cabecalho Possiveis Causa³±±
±±³          ³ ExpL2-Logico definindo se imprime cabecalho FNC Relacionad.³±±
±±³          ³ ExpL3-Logico definindo se imprime cabecalho Etapa das Acoes³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR060                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QNCR060LIN(cTipo,nLin,nCol,cTexto,oFontT,nBoxTam,cTextCab,nBoxTamLI,nBoxTamCI,nBoxTamLF,nBoxTamCF,lCabec1,lCabec2,lCabec3)
Local nLig1      := 0
Local nColEmp    := 550
Default nBoxTam  := 0
Default cTextCab := " "
Default lCabec1  := .F.
Default lCabec2  := .F.
Default lCabec3  := .F.

If !lInicial
	lInicial := .T.
	oQPrint:= TMSPrinter():New( Titulo )
	oQPrint:SetPortrait()
	nLig := 2900
Endif

If nLig >= 2900
	If !lFirst
		If lPagPrint
			nLig+=40
			oQPrint:Say(nLig,2200,OemToAnsi(STR0003)+Transform(nPag,"@e 99"),oFont06 )	// "Pag."
			nPag++
		Endif
		oQPrint:EndPage()
	Endif
	If lFirst
		lFirst := .F.
	Endif
	lPagPrint := .T.
	oQPrint:StartPage() // Inicia uma nova pagina

	oQPrint:SayBitmap(30,30, cFileLogo,474,117)
	nColEmp := 1175-((Len(cNomFilial)/2)*29.375) // Tamanho de fonte 15
	oQPrint:Say(030,nColEmp,cNomFilial,oFont15 )

	oQPrint:Say(146,30,OemToAnsi(STR0007),oFont20 )	// "PLANO DE ACAO"

	oQPrint:Box(130, 1680, 210, 2350 )
	oQPrint:Say(143,1700,OemToAnsi(STR0016)+TransForm(QI3->QI3_CODIGO,PesqPict("QI3","QI3_CODIGO"))+"-"+QI3->QI3_REV,oFont10n) // "No. "

	oQPrint:Line( 225, 30, 225, 2350 )
	oQPrint:Line( 226, 30, 226, 2350 )
	oQPrint:Line( 227, 30, 227, 2350 )
	oQPrint:Line( 228, 30, 228, 2350 )
	oQPrint:Line( 229, 30, 229, 2350 )

	oQPrint:Box(270, 30, 440, 2350 )
	oQPrint:Line( 355, 30, 355, 2350 )

	oQPrint:Line( 270, 390, 355, 390 )
	oQPrint:Line( 270, 850, 355, 850 )
	oQPrint:Line( 270,1270, 355,1270 )
	oQPrint:Line( 270,1670, 355,1670 )

	oQPrint:Say(275,  40,OemToAnsi(STR0018),oFont06 )	// "Data de Abertura"
	oQPrint:Say(315,  40,PADR(DTOC(QI3->QI3_ABERTU),10),oFont10 )

	oQPrint:Say(275, 400,OemToAnsi(STR0031),oFont06 )	// "Data Encerramento Previsto"
	oQPrint:Say(315, 400,PADR(DTOC(QI3->QI3_ENCPRE),10),oFont10 )

	oQPrint:Say(275, 860,OemToAnsi(STR0019),oFont06 )	// "Data Encerramento Real"
	oQPrint:Say(315, 860,PADR(DTOC(QI3->QI3_ENCREA),10),oFont10 )

	oQPrint:Say(275,1280,OemToAnsi(STR0032),oFont06 ) // "Tipo de Acao"
	oQPrint:Say(315,1280,aTipQI3[Val(QI3->QI3_TIPO)],oFont10 )

	oQPrint:Say(275,1680,OemToAnsi(STR0022),oFont06 )	// "Status"
	oQPrint:Say(315,1680,aStatus[Val(QI3->QI3_STATUS)],oFont10 )

	oQPrint:Say(360, 40,OemToAnsi(STR0021),oFont06 )	// "Responsavel"
	oQPrint:Say(390, 40,PADR(QA_NUSR(QI3->QI3_FILMAT,QI3->QI3_MAT,.F.),40),oFont10 )
	
	lFirQB := .T.
	QncImFich () 
	
	// Seta Linha inicial apos quebra de pagina
    If mv_par14 == 1
	   	nLig := 760
		nLin := 800	
    Else	
		nLig := 500
		nLin := 500	  
	Endif
    
	If !Empty(AllTrim(cTextCab)) .And. nBoxTam > 0

		oQPrint:Say(nLig,30,cTextCab,oFont10n )
		nLig += 40
		nLig1 := nLig+(nBoxTam*40)+80
		nLig1 := If(nLig1>=2900,2930,nLig1)
		oQPrint:Box(nLig, 30,nLig1, 2350 )
		nLig += 20
		nLin := nLig

		If lCabec1	// Possiveis Causas
			nLig2 := nLig-20
			oQPrint:Say(nLig,  40,OemToAnsi(STR0001),oFont10n ) // "Sequencia"
			oQPrint:Say(nLig, 310,OemToAnsi(STR0002),oFont10n ) // "Descricao"

			nLig += 40
			oQPrint:Line(nLig,  30, nLig, 2350 )
			oQPrint:Line(nLig2, 300, nLig1, 300 )
			nLig += 20
			nLin := nLig
		Endif

		If lCabec2	// FNC Relacionadas
			nLig2 := nLig-20
			oQPrint:Say(nLig,  40,OemToAnsi(STR0004),oFont10n ) // "No. FNC Rv"
			oQPrint:Say(nLig, 370,OemToAnsi(STR0005),oFont10n ) // "Originador"
			oQPrint:Say(nLig,1175,OemToAnsi(STR0006),oFont10n ) // "Abertura"
			oQPrint:Say(nLig,1425,OemToAnsi(STR0033),oFont10n ) // "Descricao"

			nLig += 40
			oQPrint:Line(nLig,  30, nLig, 2350 )

			oQPrint:Line(nLig2, 360, nLig1, 360 )
			oQPrint:Line(nLig2,1165, nLig1, 1165 )
			oQPrint:Line(nLig2,1415, nLig1, 1415 )
			
			nLig += 20
			nLin := nLig
		Endif

		If lCabec3	// Etapas da Acoes
			nLig2 := nLig-20
			oQPrint:Say(nLig,  40,OemToAnsi(STR0021),oFont10n ) // "Responsavel"
			oQPrint:Say(nLig, 925,OemToAnsi(STR0034),oFont10n ) // "Previsao"
			oQPrint:Say(nLig,1175,OemToAnsi(STR0035),oFont10n ) // "Conclusao"
			oQPrint:Say(nLig,1425,OemToAnsi(STR0002),oFont10n ) // "Descricao"
			
			nLig += 40

			oQPrint:Line(nLig,  30, nLig, 2350 )
			oQPrint:Line(nLig2, 915, nLig1, 915 )
			oQPrint:Line(nLig2,1165, nLig1,1165 )
			oQPrint:Line(nLig2,1415, nLig1,1415 )									

			nLig += 20
			nLin := nLig
   		Endif
	Endif
Endif

If cTipo == "T"
	oQPrint:Say(nLin,nCol,cTexto,oFontT)
	lFirQB := .F.
ElseIf cTipo == "B"
	oQPrint:Box(nBoxTamLI,nBoxTamCI,nBoxTamLF,nBoxTamCF)
	lFirQB := .F.
ElseIf cTipo == "L"
	oQPrint:Line(nBoxTamLI,nBoxTamCI,nBoxTamLF,nBoxTamCF)
	lFirQB := .F.	
Endif

Return Nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³QNCCombo      ºAutor  ³Iolanda Vilanovaº Data ³  30/10/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que le o itens do combo no SX3 e retorna num array   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QNCR060                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QNCCombo(cCampo)
Local aArea    := GetArea()
Local cBox     := ""
Local aBox     := {}
Local nPosicao1:= 0
Local nPosicao2:= 0
Local cElem1   := ""

dbSelectArea("SX3")
dbSetOrder(2)
If ( MsSeek(cCampo) )
	cBox  := x3cbox(cCampo)
	While ( !Empty(cBox) )
		nPosicao1   := At(";",cBox)
		If ( nPosicao1 == 0 )
			nPosicao1 := Len(cBox)+1
		EndIf
		nPosicao2   := At("=",cBox)
		cElem1 := SubStr(cBox,1,nPosicao2-1)
		cElem2 := SubStr(cBox,nPosicao2+1,nPosicao1-nPosicao2-1)
		aadd(aBox,cElem1+' - '+cElem2)
		cBox := SubStr(cBox,nPosicao1+1)
	EndDo
EndIf
dbSelectArea("SX3")
dbSetOrder(1)

RestArea(aArea)
Return(aBox)

Static Function QncImFich ()  
Local cCliente := ""
Local cForn    := ""
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 	//³ Imprime as Fichas de Ocorrencias/Nao-conformidades Relacionadas ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nRelac == 1	// Sim
		If QI9->(dbSeek(QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV))
			aFichas := {}
			If nLig+110 >= 2900
				nLig := 2900
			Endif

			While QI9->(!Eof()) .And. QI9->QI9_FILIAL + QI9->QI9_CODIGO + QI9->QI9_REV == QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV
				IF QI2->(dbSeek(QI9->QI9_FILIAL+Right(QI9->QI9_FNC,4)+QI9->QI9_FNC+QI9->QI9_REVFNC))
					aAdd(aFichas,{QI2->QI2_FNC,QI2->QI2_REV,QI2->QI2_FILMAT,QI2->QI2_MAT,QI2->QI2_OCORRE,QI2->QI2_DESCR,QI2->QI2_CODCLI,QI2->QI2_CODFOR,QI2->QI2_CONTAT })
				Endif
				QI9->(dbSkip())
			Enddo
			If Len(aFichas) > 0  
				If mv_par14 == 1
			   	    dbSelectArea("SA1")
					dbSetOrder(1)
					If SA1->(DbSeek(xFilial() + aFichas[1,7]))
					   cCliente := SA1->A1_NOME
					Endif
					   
					dbSelectArea("SA2")
					dbSetOrder(1)
					If SA2->(DbSeek(xFilial() + aFichas[1,8]))
					   cForn := SA2->A2_NOME
					Endif
								
					//Detalhes do Cadastro Outros - FNC
					oQPrint:Box(490, 30, 740, 2350 )
					
					oQPrint:Say(495, 40,OemToAnsi(STR0036),oFont06 )//"Cliente"	   
					oQPrint:Say(535, 40,aFichas[1,7]+" "+cCliente,oFont10 )
					oQPrint:Line( 567, 30, 567, 2350 )
					
					oQPrint:Say(575, 40,OemToAnsi(STR0037),oFont06 )//"Fornecedor"
					oQPrint:Say(615, 40,aFichas[1,8]+" "+cForn,oFont10 )
					oQPrint:Line( 650, 30, 650, 2350 )
					
					oQPrint:Say(660, 40,OemToAnsi(STR0038),oFont06 )//"Contato"		
					oQPrint:Say(700, 40,PADR(aFichas[1,9],100),oFont10 )
			
				Endif
				
			Endif
		Endif
	Endif	

Return
