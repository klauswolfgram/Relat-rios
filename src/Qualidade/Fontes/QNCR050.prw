/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "TOTVS.CH"
#INCLUDE "QNCR050.CH"

Static lQLTDispSVR := Nil

/*/{Protheus.doc} QNCR050
Relatorio de Ficha de Ocorrencias/Nao-conformidades-Grafico
@author Aldo Marini Junior
@since 23/07/2001
@param1: nRegImp   , númerico, recno da QI2 correspondente ao relatório
@param2: lRelAntigo, lógico  , Imprime o relatório antigo, sem perguntar ao usuário se deverá usar o relatório Smart View
@param3: lEnvMail  , lógico  , Controlar o envio de e-mail
@version 1.0
/*/
User Function QNCR050(nRegImp, lRelAntigo, lEnvMail)

	Local cJPEG  := ""
	Local lEmail := .F.

	Private cPerg      := "QNR050"
	Private cStartPath := GetSrvProfString("Startpath","")
	Private lPagPrint  := .T.
	Private lTMKPMS    := If(GetMv("MV_QTMKPMS",.F.,1) == 1,.F.,.T.) //Integracao do QNC com TMK e PMS: 1-Sem integracao,2-TMKxQNC,3-QNCxPMS,4-TMKxQNCxPMS ³
	Private nLastKey   := 0
	Private nLiG       := 2900
	Private Titulo     := STR0001 //"FICHA DE OCORRENCIAS/NAO-CONFORMIDADES"
	Default lRelAntigo := .F.
	Default nRegImp    := 0
	Default lEnvMail   := .F.

	lQLTDispSVR   := Iif(lQLTDispSVR == Nil, FindFunction("QLTDispSVR"), lQLTDispSVR)

	If lRelAntigo .OR. !lQLTDispSVR .OR. !FWSX1Util():ExistPergunte( "QNR050SV" ) .OR. !QLTDispSVR("manufacturing.sv.qnc.nonconformance",,,,QLTTReportsManager():mountDefaultParams("QNR050SV", .F.))

		INCLUI := .F.	// Utilizado devido algumas funcoes de retorno de descricao/nome

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis utilizadas para parametros                         ³
		//³ mv_par01        //  Filial  De                               ³
		//³ mv_par02        //  Filial  Ate                              ³
		//³ mv_par03        //  Ano De                                   ³
		//³ mv_par04        //  Ano Ate             			         ³
		//³ mv_par05        //  Codigo FNC De     	                     ³
		//³ mv_par06        //  Codigo FNC Ate                           ³
		//³ mv_par07        //  Revisao De                               ³
		//³ mv_par08        //  Revisao Ate                              ³
		//³ mv_par09        //  Tipo 1-N.C.Potencial/2-N.C.Existente/3-Melhoria/4-Ambas ³
		//³ mv_par10        //  Plano de Acao Relac. 1-Sim/2-Nao         ³
		//³ mv_par11        //  Visualiza antes        1-Sim/2-Nao       ³
		//³ mv_par12        //  Envia E-Mail           1-Sim/2-Nao       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If nRegImp == 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica as perguntas selecionadas                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			lOkPrint := pergunte("QNR050",.T.)

			If !lOkPrint
				Return
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cFilDe   := mv_par01
			cFilAte  := mv_par02
			cAnoDe   := mv_par03
			cAnoAte  := mv_par04
			cFNCDe   := mv_par05
			cFNCAte  := mv_par06
			cRevDe   := mv_par07
			cRevAte  := mv_par08
			nTipo    := mv_par09
			nRelac   := mv_par10
			nView    := mv_par11
			lEmail   := mv_par12 == 1
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			pergunte("QNR050",.F.)
			cFilDe   := QI2->QI2_FILIAL
			cFilAte  := QI2->QI2_FILIAL
			cAnoDe   := QI2->QI2_ANO
			cAnoAte  := QI2->QI2_ANO
			cFNCDe   := QI2->QI2_FNC
			cFNCAte  := QI2->QI2_FNC
			cRevDe   := QI2->QI2_REV
			cRevAte  := QI2->QI2_REV
			nTipo    := Val(QI2->QI2_TPFIC)
			nRelac   := 1
			nView    := If(lEnvMail, 0, 1)
			lEmail   := If(lEnvMail, .T., mv_par12 == 1)
			
		Endif
			
		If lEmail
			cJPEG := CriaTrab(,.F.)
		EndIf

		RptStatus({|lEnd| QNCR050Imp(@lEnd, lEmail, cJPEG)},Titulo)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Volta o registro correspondente a FNC quando a impressao for ³
		//³ selecionada via cadastro.                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nRegImp > 0
			dbSelectArea("QI2")
			dbSetOrder( 1 )
			dbGoTo(nRegImp)
		Endif

		dbSelectArea("QI3")
		dbSetOrder( 1 )

		If lEmail
			//Deleta arquivos JPEG gerados pelos relatorios.                          
			FErase( cStartPath+cJPEG )
		EndIf

	EndIf

Return

/*/{Protheus.doc} QNCR050Imp
Impressão da Ficha de Ocorrencias/Nao-conformidades
@author Aldo Marini Junior
@since 23/07/2001
@param1: lEnd  , lógico, A‡Æo do Codelock
@param2: lEmail, lógico, Envio de E-mail
@param3: cJPEG , caracter, Nome do JPG
@version 1.0
/*/
Static Function QNCR050Imp(lEnd, lEmail, cJPEG)
Local aPlanos   := {}
Local aUsrMat   := QNCUSUARIO()
Local cMatCod   := aUsrMat[3]
Local cMatFil   := aUsrMat[2]
Local cTxtDet   := ""
Local lAmbLinux := (GetRemoteType() == 2) .OR. ISSRVUNIX() //Checa se o Remote ou Server e Linux 
Local lSigiloso := .f.
Local nA
Local nColT     := 0
Local nCont     := 0
Local nLig1     := 0
Local nLig2     := 0
Local nT
Local nTot      := 0

Private aPriori  := {}
Private aStatus  :={OemtoAnsi(STR0005), OemToAnsi(STR0006), OemToAnsi(STR0007), OemToAnsi(STR0008), OemToAnsi(STR0009)} // "Registrada" ### "Em Analise" ### "Procede" ### "Nao Procede" ### "Cancelada"
Private lFirst   := .T.
Private lInicial := .F.
Private oFont08  := Nil
Private oFont10  := Nil
Private oFont10n := Nil
Private oFont15  := Nil
Private oFont20  := Nil
Private oQPrint  := Nil

Private cFileLogo  := ""
Private cFilOld    := cFilAnt
Private cNomFilial := ""

oFont06	:= TFont():New("Courier New",06,08,,.T.,,,,.T.,.F.)
oFont10	:= TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
oFont10n:= TFont():New("Courier New",10,10,,.T.,,,,.T.,.F.)
oFont13	:= TFont():New("Courier New",13,13,,.T.,,,,.T.,.F.)
oFont15	:= TFont():New("Courier New",15,15,,.T.,,,,.T.,.F.)
oFont20	:= TFont():New("Courier New",20,20,,.T.,,,,.T.,.F.)
// 5o. Bold
// 9o. Italico
//10o. Underline

// Carrega o conteudo do X3_CBOX no array
QNCCBOX("QI2_PRIORI",@aPriori)

QI9->(dbSetOrder(2))	// Buscar por FNC

dbSelectArea( "QI2" )
dbGoTop()

dbSetOrder( 1 )
dbSeek(IF((FWModeAccess("QI2") == "C"),xFilial("QI2"),cFilDe) + cAnoDe + cFNCDe+ cRevDe,.T.) 
cInicio  := "QI2->QI2_FILIAL + QI2->QI2_ANO + QI2->QI2_FNC + QI2->QI2_REV"
cFim     := IF((FWModeAccess("QI2") == "C"),xFilial("QI2"),cFilAte) + cAnoAte + cFNCAte + cRevAte

cFileLogo  := "LGRL"+SM0->M0_CODIGO
cFilOld    := QI2->QI2_FILIAL

If (FWModeAccess("QI2") == "C")
	cFileLogo += FWCodFil()+".BMP"
Else
	cFileLogo += QI2->QI2_FILIAL+".BMP"
Endif

If !File( cFileLogo )
	cFileLogo := "LGRL"+SM0->M0_CODIGO+".BMP" // Empresa
Endif

// Carrega Regua de Processamento
SetRegua(QI2->(RecCount()))

While !EOF() .And. &cInicio <= cFim

	// Movimenta Regua de Processamento
	IncRegua()

	If lEnd
		Exit
	Endif

 	// Consiste Parametrizacao do Intervalo de Impressao
	If !lTMKPMS
		cParam := ( Right(Alltrim(QI2->QI2_FNC),4) + Left(QI2->QI2_FNC,15) < Right(Alltrim(cFNCDe ),4) + Left(cFNCDe ,15) ) .Or. ;
			   	  ( Right(Alltrim(QI2->QI2_FNC),4) + Left(QI2->QI2_FNC,15) > Right(Alltrim(cFNCAte),4) + Left(cFNCAte,15) )
	Else
		cParam := ( Right(Alltrim(QI2->QI2_FNC),4) + Left(QI2->QI2_FNC,11) < Right(Alltrim(cFNCDe ),4) + Left(cFNCDe ,11) ) .Or. ;
			   	  ( Right(Alltrim(QI2->QI2_FNC),4) + Left(QI2->QI2_FNC,11) > Right(Alltrim(cFNCAte),4) + Left(cFNCAte,11) )
	Endif

	If	( QI2->QI2_ANO < cAnoDe ) .Or. ( QI2->QI2_ANO > cAnoAte ) .Or. ;
		( QI2->QI2_REV < cRevDe ) .Or. ( QI2->QI2_REV > cRevAte ) .Or. cParam	 	
		dbSkip()
		Loop
	Endif

 	// Consiste o tipo de Ficha de Ocorrencia/Nao-conformidade
	If nTipo <> 4 .And. Val(QI2->QI2_TPFIC) <> nTipo
		dbSkip()
		Loop
	Endif

 	// Quebra de Pagina e imprime cabecalho
	nLig := 2900
	nTot := 0
	
	cNomFilial := AllTrim(QA_CHKFIL(QI2->QI2_FILIAL,,.T.))
	If !Empty(cFilOld) .And. cFilOld <> QI2->QI2_FILIAL
        cFilOld    := QI2->QI2_FILIAL
		cFileLogo  := "LGRL"+SM0->M0_CODIGO+QI2->QI2_FILIAL+".BMP"
		If !File( cFileLogo )
			cFileLogo := "LGRL"+SM0->M0_CODIGO+".BMP" // Empresa
		Endif
	Endif
	
	// Verifica se FNC é Sigilosa. Somente Responsavel e Digitador podem Imprimir
	lSigiloso := .f.

	If QI2->QI2_SIGILO == "1"	
		If ! (cMatFil+cMatCod == QI2->QI2_FILMAT+QI2->QI2_MAT .or. ;
		   	  cMatFil+cMatCod == QI2->QI2_FILRES+QI2->QI2_MATRES)
			lSigiloso := .T.
		Endif
	Endif
	
	If lSigiloso
		U_QNCR050LIN("T",nLig,30,OemToAnsi(STR0039),oFont10n)	// "Dados Sigilosos"
		nLig += 40
		U_QNCR050LIN("B",,,,,,OemToAnsi(STR0039),nLig,30,nLig+120,2350)		// "Dados Sigilosos"
		nLig += 20
		U_QNCR050LIN("T",nLig,50,OemToAnsi(STR0040 + AllTrim(Posicione("QAA",1, QI2->QI2_FILMAT+QI2->QI2_MAT,"QAA_NOME"))),oFont10)		// "Acesso permitido a "
		nLig += 40
		U_QNCR050LIN("T",nLig,50,OemToAnsi(STR0041 + AllTrim(Posicione("QAA",1, QI2->QI2_FILRES+QI2->QI2_MATRES,"QAA_NOME"))),oFont10)	// " e "
		nLig += 40
	Else
	
	 	// Imprime a Descricao Detalhada
		cTxtDet  := MSMM(QI2->QI2_DDETA)
		If !Empty(cTxtDet)
			aTxtDet := {}
			Q_MemoArray(cTxtDet, @aTxtDet, 100)
	
			If Len(aTxtDet) > 0
				U_QNCR050LIN("T",nLig,30,OemToAnsi(STR0010),oFont10n) // "Descricao Detalhada"
				nLig += 40
				nLig2 := 540+(Len(aTxtDet)*40)+80
				nLig2 := If(nLig2>=2900,2930,nLig2)
				U_QNCR050LIN("B",,,,,,OemToAnsi(STR0010),nLig,30,nLig2,2350)// "Descricao Detalhada"
				nLig1 := nLig 	// Pula de 40 em 40
				nLig += 20
				nColT := 1
				For nT:=1 to Len(aTxtDet)
					U_QNCR050LIN("T",nLig,50,aTxtDet[nT],oFont10,Len(aTxtDet)-nT+1,OemToAnsi(STR0010)) // "Descricao Detalhada"
		            nLig+=40
				Next
				nLig+=40
			Endif
		Endif
	Endif

	// Imprime a Descricao dos Comentarios
	cTxtDet := MSMM(QI2->QI2_COMEN)
	If !Empty(cTxtDet)
		If nLig+110 >= 2900
			nLig := 2900
		Endif

		aTxtDet := {}
		Q_MemoArray(cTxtDet, @aTxtDet, 100)

		If Len(aTxtDet) > 0
			nLig += 50
			U_QNCR050LIN("T",nLig,30,OemToAnsi(STR0011),oFont10n,,OemToAnsi(STR0011)) // "Comentarios"
			nLig += 40
			nLig2:= nLig+(Len(aTxtDet)*40)+80
			nLig2:= If(nLig2>=2900,2930,nLig2)
			U_QNCR050LIN("B",,,,,,OemToAnsi(STR0011),nLig,30,nLig2,2350) // "Comentarios"
			nLig1 := nLig 	// Pula de 40 em 40
			nLig += 20
			nColT := 1
			For nT:=1 to Len(aTxtDet)
				U_QNCR050LIN("T",nLig,50,aTxtDet[nT],oFont10,Len(aTxtDet)-nT+1,OemToAnsi(STR0011)) // "Comentarios"
				nLig+=40
			Next
			nLig+=40
		Endif
	Endif

 	// Imprime a Descricao da Disposicao
	cTxtDet := MSMM(QI2->QI2_DISPOS)
	If !Empty(cTxtDet)
		If nLig+110 >= 2900
			nLig := 2900
		Endif

		aTxtDet := {}
		Q_MemoArray(cTxtDet, @aTxtDet, 100)

		If Len(aTxtDet) > 0
			nLig += 50
			U_QNCR050LIN("T",nLig,30,OemToAnsi(STR0012),oFont10n,,OemToAnsi(STR0012)) // "Disposicao"
			nLig += 40
			nLig2 := nLig+(Len(aTxtDet)*40)+80
			nLig2 := If(nLig2>=2900,2930,nLig2)
			U_QNCR050LIN("B",,,,,,OemToAnsi(STR0012),nLig,30,nLig2,2350) // "Disposicao"
			nLig1 := nLig 	// Pula de 40 em 40
			nLig += 20
			nColT := 1
			For nT:=1 to Len(aTxtDet)
				U_QNCR050LIN("T",nLig,50,aTxtDet[nT],oFont10,Len(aTxtDet)-nT+1,OemToAnsi(STR0012)) // "Disposicao"
				nLig+=40
			Next
			nLig+=40
		Endif
	Endif

	nLig += 50

	If nLig+295 >= 2900
		nLig := 2900
	Endif

	U_QNCR050LIN("T",nLig,30,OemToAnsi(STR0013),oFont10n,,OemToAnsi(STR0013))	// "Analise"
	nLig += 40
	nLig1 := nLig	// 2200
	nLig2 := nLig+255


	nCont := nLig2//padrao
	If !Empty(QI2->QI2_CODCLI)
		nCont+= 90 
		nTot+=1
	Endif
	 
	If !Empty(QI2->QI2_CODFOR)
		nCont+= 90 
		nTot+=1
	Endif
	
	If !Empty(QI2->QI2_CONTAT)
		nCont+= 90 
		nTot+=1
	Endif
	 
	//Desenhar o box
	U_QNCR050LIN("B",,,,,,,nLig1,30,nCont,2350)

	//Impressao das Linhas Padroes
	nLig += 85	// 2285
	U_QNCR050LIN("L",,,,,,,nLig,30,nLig,2350)
	nLig += 85	// 2370
	U_QNCR050LIN("L",,,,,,,nLig,30,nLig,2350)
	U_QNCR050LIN("L",,,,,,,nLig1,1175,nLig,1175)

	//Impressao de Outras Linhas
	For nT:=0 to nTot-1 
		nLig += 90	
		U_QNCR050LIN("L",,,,,,,nLig,30,nLig,2350)
	Next

	nLig := nLig1+5
	U_QNCR050LIN("T",nLig,40,OemToAnsi(STR0014),oFont06)	// "Disposicao"

	nLig +=40
	U_QNCR050LIN("T",nLig,40,QI2->QI2_CODDIS+"-"+PADR(FQNCCHKDIS(QI2->QI2_CODDIS),40),oFont10)

	nLig := nLig1+5

	U_QNCR050LIN("T",nLig,1190,(TitSX3("QI2_CODORI")[1]),oFont06)  // "Origem"
	nLig +=40
	U_QNCR050LIN("T",nLig,1190,QI2->QI2_CODORI+"-"+PADR(FQNCNTAB("3",QI2->QI2_CODORI),40),oFont10)

	nLig1 += 90
	nLig := nLig1
	U_QNCR050LIN("T",nLig,40,OemToAnsi(STR0016),oFont06)  // "Causa"
	nLig +=40
	U_QNCR050LIN("T",nLig,40,QI2->QI2_CODCAU+"-"+PADR(FQNCNTAB("1",QI2->QI2_CODCAU),40),oFont10)

	nLig := nLig1
	U_QNCR050LIN("T",nLig,1190,OemToAnsi(STR0017),oFont06)  // "Efeito"
	nLig +=40
	U_QNCR050LIN("T",nLig,1190,QI2->QI2_CODEFE+"-"+PADR(FQNCNTAB("2",QI2->QI2_CODEFE),40),oFont10)

	nLig1 += 90
	nLig := nLig1
	U_QNCR050LIN("T",nLig,40,OemToAnsi(STR0018),oFont06)  // "Categoria FNC"
	nLig +=40
	U_QNCR050LIN("T",nLig,40,QI2->QI2_CODCAT+"-"+PADR(FQNCNTAB("4",QI2->QI2_CODCAT),50),oFont10)
	nLig := nLig2

	If !Empty(QI2->QI2_CODCLI)
		nLig1 += 90
		nLig := nLig1
		U_QNCR050LIN("T",nLig,40,OemToAnsi(STR0034),oFont06)  // "Cliente"
		nLig +=40
		U_QNCR050LIN("T",nLig,40,QI2->QI2_CODCLI+"-"+Posicione("SA1",1,xFilial("SA1")+QI2->QI2_CODCLI+QI2->QI2_LOJCLI,"A1_NOME"),oFont10)	
	Endif
	
	If !Empty(QI2->QI2_CODFOR)
		nLig1 += 90
		nLig := nLig1
		U_QNCR050LIN("T",nLig,40,OemToAnsi(STR0035),oFont06)  // "Fornecedor"
		nLig +=40
		U_QNCR050LIN("T",nLig,40,QI2->QI2_CODFOR+"-"+FQNCDESFOR(QI2->QI2_CODFOR,QI2->QI2_LOJFOR,"1"),oFont10)	
	Endif
	
	If !Empty(QI2->QI2_CONTAT)
		nLig1 += 90
		nLig := nLig1
		U_QNCR050LIN("T",nLig,40,OemToAnsi(STR0036),oFont06)  // "Contato"
		nLig +=40
		U_QNCR050LIN("T",nLig,40,QI2->QI2_CONTAT,oFont10)
    Endif

 	// Imprime os Plano de Acao Relacionadas
	If nRelac == 1	// Sim

		If QI9->(dbSeek(QI2->QI2_FILIAL + QI2->QI2_FNC + QI2->QI2_REV))
			aPlanos := {}
			While !Eof() .And. QI9->QI9_FILIAL + QI9->QI9_FNC + QI9->QI9_REVFNC == QI2->QI2_FILIAL + QI2->QI2_FNC + QI2->QI2_REV
				IF QI3->(dbSeek(QI9->QI9_FILIAL+Right(QI9->QI9_CODIGO,4)+QI9->QI9_CODIGO+QI9->QI9_REV))
					aAdd(aPlanos,{ QI3->QI3_CODIGO,QI3->QI3_REV,QI3->QI3_FILMAT,QI3->QI3_MAT,QI3->QI3_ABERTU,QI3->QI3_ENCPRE,QI3->QI3_ENCREA })
				Endif
				QI9->(dbSkip())
			Enddo
			If Len(aPlanos) > 0
				nLig += 50
				If nLig+100 >= 2900
					nLig := 2900
				Endif
				U_QNCR050LIN("T",nLig,30,OemToAnsi(STR0019),oFont10n)	// "Plano de Acao Relacionados"
				nLig += 40
				nLigf := nLig+(40*Len(aPlanos))+80
				nLigf := If(nLigf>=2900,2930,nLigf)
				U_QNCR050LIN("B",,,,,,,nLig,30,nLigf,2350)

				nLig1 := nLig
				nLig += 20

				U_QNCR050LIN("T",nLig,  40,OemToAnsi(STR0020),oFont10n)	 // "No.Pl.Acao Rv"
				U_QNCR050LIN("T",nLig, 470,OemToAnsi(STR0021),oFont10n)	// "Originador"
				U_QNCR050LIN("T",nLig,1310,OemToAnsi(STR0022),oFont10n)	// "Dt.Abertura"
				U_QNCR050LIN("T",nLig,1660,OemToAnsi(STR0023),oFont10n)	// "Dt.Encerr.Prev."
				U_QNCR050LIN("T",nLig,2010,OemToAnsi(STR0024),oFont10n)	// "Dt.Encerr.Real"
																
				nLig += 40
				U_QNCR050LIN("L",,,,,,,nLig,30,nLig,2350)

				U_QNCR050LIN("L",,,,,,,nLig1, 460,nLigf, 460)
				U_QNCR050LIN("L",,,,,,,nLig1,1300,nLigf,1300)
				U_QNCR050LIN("L",,,,,,,nLig1,1650,nLigf,1650)
				U_QNCR050LIN("L",,,,,,,nLig1,2000,nLigf,2000)
																
				nLig1 := nLig 	// Pula de 40 em 40
				nLig += 20
				nColT := 1

				For nA:=1 to Len(aPlanos)

					U_QNCR050LIN("T",nLig,  40,Transform(aPlanos[nA,1],PesqPict("QI3","QI3_CODIGO"))+" "+aPlanos[nA,2],oFont10,Len(aPlanos)-nA+1,OemToAnsi(STR0019),,,,,.T.)
					U_QNCR050LIN("T",nLig, 470,Padr(QA_NUSR(aPlanos[nA,3],aPlanos[nA,4],.F.),30),oFont10,Len(aPlanos)-nA+1,OemToAnsi(STR0019),,,,,.T.)
					U_QNCR050LIN("T",nLig,1310,PADR(DTOC(aPlanos[nA,5]),10),oFont10,,OemToAnsi(STR0019),Len(aPlanos)-nA+1,,,,.T.)
					U_QNCR050LIN("T",nLig,1660,PADR(DTOC(aPlanos[nA,6]),10),oFont10,,OemToAnsi(STR0019),Len(aPlanos)-nA+1,,,,.T.)
					U_QNCR050LIN("T",nLig,2010,PADR(DTOC(aPlanos[nA,7]),10),oFont10,,OemToAnsi(STR0019),Len(aPlanos)-nA+1,,,,.T.)
									
					nLig+=40
				Next
			Endif
		Endif
	Endif	
	nLig+=40
	oQPrint:Say(nLig,2200,OemToAnsi(STR0025)+Transform(oQPrint:nPage,"@e 99"),oFont06 )	// "Pag."
	lPagPrint := .F.
	oQPrint:EndPage()
	dbSkip()
Enddo

If oQPrint <> NIL
	oQPrint:EndPage() // Finaliza a página
Endif

// Termino do relatorio
QI9->(dbSetOrder(1))

dbSelectArea("QI2")
Set Filter to
dbSetOrder(1)
If oQPrint <> NIL

	If nView == 1
		oQPrint:Preview() // Visualiza antes de imprimir 
	Elseif nView == 2
		oQPrint:Print()   // Imprime direto na impressora default Protheus
	Endif

	If lEmail .and. !Empty(cJPEG)

		oQPrint:SaveAllAsJPEG(cStartPath+cJPEG,865,1170,140)

		IF lAmbLinux
			// STR0037 - Em Ambiente Linux, 
		            //   Não será enviado o relatorio por e-mail! Esta Opcão está em Desenvolvimento.
		    MsgAlert(OemToAnsi(STR0037))  
        Else
			QNCXRMAIL({{cStartPath,cJPEG,STR0001}})
		Endif
	Endif
Endif

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QNCR050Imp³ Autor ³ Aldo Marini Junior    ³ Data ³ 31.07.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o cabecalho                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³U_QNCR050LIN(cTipo,nLin,nCol,cTexto,oFontT,nBoxTam,cTextCab,  ³±±
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
±±³          ³ ExpL1-Logico definindo se imprime cabecalho do Plano Acao  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR050                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QNCR050LIN(cTipo,nLin,nCol,cTexto,oFontT,nBoxTam,cTextCab,nBoxTamLI,nBoxTamCI,nBoxTamLF,nBoxTamCF,lCabec)
Local nLig1      := 0
Local nColEmp    := 550
Default nBoxTam  := 0
Default cTextCab := " "
Default lCabec   := .F.

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
			oQPrint:Say(nLig,2200,OemToAnsi(STR0025)+Transform(oQPrint:nPage,"@e 99"),oFont06 )	// "Pag."
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

	oQPrint:Say(146,30,OemToAnsi(STR0001),oFont15 )	// "FICHA DE OCORRENCIAS/NAO-CONFORMIDADES"

	oQPrint:Box(130, 1680, 210, 2350 )
	oQPrint:Say(143,1700,OemToAnsi(STR0026)+TransForm(QI2->QI2_FNC,PesqPict("QI2","QI2_FNC"))+"-"+QI2->QI2_REV,oFont10n ) // "No. "

	oQPrint:Line( 225, 30, 225, 2350 )
	oQPrint:Line( 226, 30, 226, 2350 )
	oQPrint:Line( 227, 30, 227, 2350 )
	oQPrint:Line( 228, 30, 228, 2350 )
	oQPrint:Line( 229, 30, 229, 2350 )

	oQPrint:Box(270, 30, 540, 2350 )
	oQPrint:Line( 355, 30, 355, 2350 )
	oQPrint:Line( 450, 30, 450, 2350 )

	oQPrint:Line( 270, 430, 355, 430 )
	oQPrint:Line( 270, 830, 355, 830 )
	oQPrint:Line( 270,1240, 455,1240 )
	oQPrint:Line( 270,1640, 455,1640 )
	oQPrint:Say(275,  40,OemToAnsi(STR0027),oFont06 )	// "Data de Registro"
	oQPrint:Say(315,  40,PADR(DTOC(QI2->QI2_REGIST),10),oFont10 )

	oQPrint:Say(275, 440,OemToAnsi(STR0028),oFont06 )	// "Data de Ocorrencia"
	oQPrint:Say(315, 440,PADR(DTOC(QI2->QI2_OCORRE),10),oFont10 )

	oQPrint:Say(275, 840,OemToAnsi(STR0029),oFont06 )	// "Data Conclusao Prevista"
	oQPrint:Say(315, 840,PADR(DTOC(QI2->QI2_CONPRE),10),oFont10 )

	oQPrint:Say(275,1250,OemToAnsi(STR0030),oFont06 ) // "Data Conclusao Real"
	oQPrint:Say(315,1250,PADR(DTOC(QI2->QI2_CONREA),10),oFont10 )

	oQPrint:Say(275,1650,OemToAnsi(STR0031),oFont06 )	// "Status"
	oQPrint:Say(315,1650,aStatus[Val(QI2->QI2_STATUS)],oFont10 )

	oQPrint:Say(360, 40,OemToAnsi(STR0021),oFont06 )	// "Originador"
	oQPrint:Say(400, 40,PADR(QA_NUSR(QI2->QI2_FILMAT,QI2->QI2_MAT,.F.),40),oFont10 )

	oQPrint:Say(360,1250,OemToAnsi(STR0032),oFont06 )	// "Prioridade"
	oQPrint:Say(400,1250,aPriori[Val(QI2->QI2_PRIORI)],oFont10 )

	oQPrint:Say(360,1650,OemToAnsi(STR0033),oFont06 )	// "Tipo"
	oQPrint:Say(400,1650,Padr(QA_CBOX("QI2_TPFIC",QI2->QI2_TPFIC),32),oFont10 )
	oQPrint:Say(455,  40,OemToAnsi(STR0038),oFont06 )	// "Responsavel"
	oQPrint:Say(495,  40,Padr(QA_NUSR(QI2->QI2_FILRES,QI2->QI2_MATRES,.F.),40),oFont10 )

	// Seta Linha inicial apos quebra de pagina
	nLig := 550
	nLin := 550	

	If !Empty(AllTrim(cTextCab)) .And. nBoxTam > 0
		oQPrint:Say(nLig,30,cTextCab,oFont10n )
		nLig += 40
		nLig1 := nLig+(nBoxTam*40)+80
		nLig1 := If(nLig1>=2900,2930,nLig1)
		oQPrint:Box(nLig, 30,nLig1, 2350 )
		nLig += 20
		nLin := nLig

		If lCabec
			nLig2 := nLig-20
			oQPrint:Say(nLig,  40,OemToAnsi(STR0020),oFont10n ) // "No.Pl.Acao Rv"
			oQPrint:Say(nLig, 370,OemToAnsi(STR0021),oFont10n ) // "Originador"
			oQPrint:Say(nLig,1310,OemToAnsi(STR0022),oFont10n ) // "Dt.Abertura"
			oQPrint:Say(nLig,1660,OemToAnsi(STR0023),oFont10n ) // "Dt.Encerr.Prev."
			oQPrint:Say(nLig,2010,OemToAnsi(STR0024),oFont10n ) // "Dt.Encerr.Real"
	         
			nLig += 40
			oQPrint:Line(nLig,  30, nLig, 2350 )

			oQPrint:Line(nLig2, 360, nLig1, 360 )
			oQPrint:Line(nLig2,1300, nLig1, 1300 )
			oQPrint:Line(nLig2,1650, nLig1, 1650 )
			oQPrint:Line(nLig2,2000, nLig1, 2000 )
			nLig += 20
			nLin := nLig
		Endif
	Endif
Endif
                                         
If cTipo == "T"
	oQPrint:Say(nLin,nCol,cTexto,oFontT)
ElseIf cTipo == "B"
	oQPrint:Box(nBoxTamLI,nBoxTamCI,nBoxTamLF,nBoxTamCF)
ElseIf cTipo == "L"
	oQPrint:Line(nBoxTamLI,nBoxTamCI,nBoxTamLF,nBoxTamCF)
Endif
Return Nil
